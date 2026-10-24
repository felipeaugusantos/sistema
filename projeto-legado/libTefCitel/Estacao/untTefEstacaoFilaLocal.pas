unit untTefEstacaoFilaLocal;

{ Fila local em arquivo para o servico da estacao (RF07/RN03, Req. 456190).

  Quando o pipe para o plugin DVC (e, por extensao, o canal RDP com o AUTCOM)
  esta indisponivel no momento em que uma transacao termina, o resultado
  (envelope "resposta" ou "evento" completo, ja serializado) e persistido
  aqui em vez de ser perdido. O servico nunca grava direto no MySQL (decisao
  do levantamento) - so entrega, mais tarde, o mesmo envelope ao AUTCOM
  quando o pipe reconectar, reaproveitando o "id" original da chamada para
  que o AUTCOM correlacione com a chamada RPC que ainda pode estar
  aguardando (RN03: sem duplicidade de gravacao em MovTef/EspelhoTEF).

  Cada item pendente e um arquivo .json no diretorio da fila, com nome
  ordenavel por timestamp (garante reenvio na ordem original).

  Passo 8 (RF21): o nome carrega tambem o PID do autcom.exe de destino
  (sufixo _pid<N>, DEPOIS do sequencial pra nao mexer na ordem). Sem ele o
  reenvio despejava a fila inteira na primeira conexao que chegasse - com
  dois autcom.exe na estacao, a resposta de um caia no outro, e o que a
  fila guarda e resposta de metodo de transacao (fPassarCartao,
  fCancelaTransacaoTerminal, fReimpressao): o tipo que menos pode errar de
  dono. Quem le o nome sao fItemDoNome/fListaPendentes; quem decide
  entregar ou descartar e o roteador (pReenviaFilaLocal), onde vive o log
  da decisao (RF22).

  Encoding: pEnfileira grava UTF-8 COM BOM (e o que TFile.WriteAllText faz
  com TEncoding.UTF8) e fCarregaEnvelope aceita com ou sem - ver o
  comentario dentro dele, que explica por que nao se pode usar
  TFile.ReadAllText aqui. }

interface

uses
  System.SysUtils, System.Classes, System.IOUtils, System.JSON, System.SyncObjs,
  System.Generics.Collections, System.Types;

const
  { Validade de um item da fila (Req. 456190, RF21). Passado esse prazo o
    item e descartado com log no proximo passe de reenvio: o autcom.exe
    daquele PID nao voltou e a chamada RPC que esperava a resposta ja nao
    existe mais.

    Isto NAO e timeout sobre o tempo do pinpad (ver IA\rules\tef-dvc.md):
    quando o item foi gravado a transacao ja havia terminado e o resultado
    ja estava em maos. E so o teto de quanto tempo um resultado que nao
    tem mais para quem ir fica ocupando o disco da estacao. }
  TEF_ESTACAO_FILA_VALIDADE_MINUTOS = 60;

type
  { Um item pendente com o que da pra saber SEM abrir o arquivo: para qual
    autcom.exe ele e e quando foi gravado - os dois lidos do proprio nome
    (Req. 456190, RF21).

    dwPidDestino = 0: item gravado sem PID conhecido (autcom.exe anterior a
    Fase 3.5, que nao manda "contexto.pid") ou item gravado por versao
    anterior a este passo, cujo nome nao tem o sufixo _pid.

    dtaEnfileirado = 0: nome ilegivel. Vale como expirado - e o unico
    destino possivel para um arquivo cuja origem nao da pra determinar. }
  TTefEstacaoItemFila = record
    strArquivo: String;
    dwPidDestino: DWORD;
    dtaEnfileirado: TDateTime;
  end;

  TTefEstacaoFilaLocal = class
  private
    FstrDiretorio: String;
    FcsAcesso: TCriticalSection;
    FintProximoSufixo: Integer;
    function fProximoNomeArquivo(const AdwPidDestino: DWORD): String;
    function fItemDoNome(const AstrArquivo: String): TTefEstacaoItemFila;
  public
    constructor Create(const AstrDiretorio: String);
    destructor Destroy; override;
    procedure pEnfileira(const AEnvelope: TJSONObject; const AdwPidDestino: DWORD);
    function fListaPendentes: TArray<TTefEstacaoItemFila>;
    { Ids dos envelopes guardados para um pid (Req. 456190, RF26). Abre os
      arquivos daquele pid, porque o "id" vive DENTRO do envelope e nao no
      nome - o nome carrega apenas o instante, o sequencial e o pid. Na
      pratica a fila tem zero ou um item, entao o custo e desprezivel, e isto
      so roda quando um autcom reata. }
    function fIdsPendentesDoPid(const AdwPidDestino: DWORD): TArray<Integer>;
    function fCarregaEnvelope(const AstrArquivo: String): TJSONObject;
    procedure pRemove(const AstrArquivo: String);
    { Varredura total, usada na SUBIDA do servico (Req. 456190, RF29).
      Devolve quantos descartou. Nao ha filtro nem por pid nem por idade: o
      que estiver aqui quando o processo sobe e, por definicao, de uma
      instancia anterior. }
    function fDescartaTudo: Integer;
  end;

implementation

{ TTefEstacaoFilaLocal }

constructor TTefEstacaoFilaLocal.Create(const AstrDiretorio: String);
begin
  inherited Create;
  FstrDiretorio := AstrDiretorio;
  FcsAcesso := TCriticalSection.Create;
  FintProximoSufixo := 0;
  if not TDirectory.Exists(FstrDiretorio) then
    TDirectory.CreateDirectory(FstrDiretorio);
end;

destructor TTefEstacaoFilaLocal.Destroy;
begin
  FcsAcesso.Free;
  inherited;
end;

function TTefEstacaoFilaLocal.fProximoNomeArquivo(const AdwPidDestino: DWORD): String;
begin
  FcsAcesso.Enter;
  try
    Inc(FintProximoSufixo);
    { A ordem dos pedacos importa: data/hora + sequencial primeiro (e o que
      ordena o reenvio), _pid<N> por ultimo. System.SysUtils.Now qualificado
      em vez de fNow pelo mesmo motivo do log em
      untTefEstacaoRoteadorMensagens.pas (pLogaEstacao): este servico nao
      depende de libFuncoes/banco, e este timestamp e controle local de uma
      fila de arquivos, nao dado de negocio nem de auditoria. }
    Result := TPath.Combine(FstrDiretorio,
      FormatDateTime('yyyymmdd_hhnnsszzz', System.SysUtils.Now) + '_' +
      Format('%.4d_pid%d', [FintProximoSufixo, AdwPidDestino]) + '.json');
  finally
    FcsAcesso.Leave;
  end;
end;

function TTefEstacaoFilaLocal.fItemDoNome(const AstrArquivo: String): TTefEstacaoItemFila;
var
  LstrNome, LstrPid: String;
  LarrPartes: TArray<String>;
  LintAno, LintMes, LintDia, LintHora, LintMin, LintSeg, LintMs: Integer;
begin
  Result.strArquivo := AstrArquivo;
  Result.dwPidDestino := 0;
  Result.dtaEnfileirado := 0; // ilegivel ate provar o contrario - vale como expirado

  { Formato: yyyymmdd _ hhnnsszzz _ NNNN [_ pid<N>] }
  LstrNome := TPath.GetFileNameWithoutExtension(AstrArquivo);
  LarrPartes := LstrNome.Split(['_']);
  if Length(LarrPartes) < 3 then
    Exit;
  if (Length(LarrPartes[0]) <> 8) or (Length(LarrPartes[1]) <> 9) then
    Exit;

  if not (TryStrToInt(Copy(LarrPartes[0], 1, 4), LintAno) and
          TryStrToInt(Copy(LarrPartes[0], 5, 2), LintMes) and
          TryStrToInt(Copy(LarrPartes[0], 7, 2), LintDia) and
          TryStrToInt(Copy(LarrPartes[1], 1, 2), LintHora) and
          TryStrToInt(Copy(LarrPartes[1], 3, 2), LintMin) and
          TryStrToInt(Copy(LarrPartes[1], 5, 2), LintSeg) and
          TryStrToInt(Copy(LarrPartes[1], 7, 3), LintMs)) then
    Exit;

  try
    Result.dtaEnfileirado := EncodeDate(Word(LintAno), Word(LintMes), Word(LintDia)) +
                             EncodeTime(Word(LintHora), Word(LintMin), Word(LintSeg), Word(LintMs));
  except
    { EncodeDate/EncodeTime levantam em valor fora de faixa (mes 13, hora
      25...). Nome com digito no lugar certo mas valor impossivel cai aqui
      e segue valendo como expirado. }
    Result.dtaEnfileirado := 0;
  end;

  if Length(LarrPartes) >= 4 then
  begin
    LstrPid := LarrPartes[3];
    if Copy(LstrPid, 1, 3) = 'pid' then
      Result.dwPidDestino := DWORD(StrToIntDef(Copy(LstrPid, 4, MaxInt), 0));
  end;
end;

procedure TTefEstacaoFilaLocal.pEnfileira(const AEnvelope: TJSONObject;
  const AdwPidDestino: DWORD);
var
  LstrArquivo: String;
begin
  LstrArquivo := fProximoNomeArquivo(AdwPidDestino);
  FcsAcesso.Enter;
  try
    TFile.WriteAllText(LstrArquivo, AEnvelope.ToJSON, TEncoding.UTF8);
  finally
    FcsAcesso.Leave;
  end;
end;

function TTefEstacaoFilaLocal.fListaPendentes: TArray<TTefEstacaoItemFila>;
var
  LarrArquivos: TStringDynArray;
  LintIdx: Integer;
begin
  FcsAcesso.Enter;
  try
    LarrArquivos := TDirectory.GetFiles(FstrDiretorio, '*.json');
  finally
    FcsAcesso.Leave;
  end;

  { Ordenar por nome = ordenar por instante de gravacao, porque o prefixo do
    nome e data/hora + sequencial (RF07/RN03: o autcom recebe na ordem em
    que a estacao terminou as transacoes). Nada e filtrado aqui de
    proposito - inclusive item de nome ilegivel entra na lista, para que o
    roteador possa descarta-lo com log em vez de ele ficar para sempre. }
  TArray.Sort<String>(LarrArquivos);

  SetLength(Result, Length(LarrArquivos));
  for LintIdx := 0 to High(LarrArquivos) do
    Result[LintIdx] := fItemDoNome(LarrArquivos[LintIdx]);
end;

function TTefEstacaoFilaLocal.fIdsPendentesDoPid(const AdwPidDestino: DWORD): TArray<Integer>;
var
  LarrItens: TArray<TTefEstacaoItemFila>;
  LItem: TTefEstacaoItemFila;
  LEnvelope: TJSONObject;
  LValor: TJSONValue;
  LintQtd: Integer;
begin
  SetLength(Result, 0);
  LarrItens := fListaPendentes;
  LintQtd := 0;
  SetLength(Result, Length(LarrItens));

  for LItem in LarrItens do
  begin
    if LItem.dwPidDestino <> AdwPidDestino then
      Continue;

    LEnvelope := fCarregaEnvelope(LItem.strArquivo);
    if not Assigned(LEnvelope) then
      Continue; // ilegivel - quem descarta com log e o roteador, nao aqui
    try
      LValor := LEnvelope.GetValue('id');
      if (LValor <> nil) and (LValor is TJSONNumber) then
      begin
        Result[LintQtd] := TJSONNumber(LValor).AsInt;
        Inc(LintQtd);
      end;
    finally
      LEnvelope.Free;
    end;
  end;

  SetLength(Result, LintQtd);
end;

function TTefEstacaoFilaLocal.fCarregaEnvelope(const AstrArquivo: String): TJSONObject;
var
  LarrBytes, LarrPreambulo: TBytes;
  LstrConteudo: String;
  LintInicio, LintIdx: Integer;
  LblnTemBom: Boolean;
begin
  Result := nil;
  if not TFile.Exists(AstrArquivo) then
    Exit;

  { Le em BYTES e decide o BOM olhando, em vez de usar TFile.ReadAllText
    (Req. 456190, achado em 2026-09-09 lendo o fonte da RTL).

    TFile.DoReadAllText NAO detecta BOM - ele pula cegamente
    Length(Encoding.GetPreamble) bytes, que sao 3 para UTF8:

      Buff := DoReadAllBytes(Path);
      BOMLength := Length(Encoding.GetPreamble);
      Result := Encoding.GetString(Buff, BOMLength, Length(Buff) - BOMLength);

    Com o arquivo que pEnfileira grava isso da certo por acidente, porque
    TFile.WriteAllText com TEncoding.UTF8 escreve o preambulo. Mas um
    arquivo SEM BOM - plantado num teste, recuperado de backup, ou salvo por
    um editor que remove preambulo - perderia os 3 primeiros caracteres
    ('{"v' viraria '":1'), o ParseJSONValue devolveria nil e o item seria
    descartado como corrompido, EM SILENCIO. Para uma fila que guarda
    resposta de transacao de cartao, perder calado e o pior desfecho
    possivel. }
  LarrBytes := TFile.ReadAllBytes(AstrArquivo);
  if Length(LarrBytes) = 0 then
    Exit;

  LarrPreambulo := TEncoding.UTF8.GetPreamble;
  LblnTemBom := Length(LarrBytes) >= Length(LarrPreambulo);
  if LblnTemBom then
    for LintIdx := 0 to High(LarrPreambulo) do
      if LarrBytes[LintIdx] <> LarrPreambulo[LintIdx] then
      begin
        LblnTemBom := False;
        Break;
      end;

  if LblnTemBom then
    LintInicio := Length(LarrPreambulo)
  else
    LintInicio := 0;

  LstrConteudo := TEncoding.UTF8.GetString(LarrBytes, LintInicio,
    Length(LarrBytes) - LintInicio);
  Result := TJSONObject.ParseJSONValue(LstrConteudo) as TJSONObject;
end;

procedure TTefEstacaoFilaLocal.pRemove(const AstrArquivo: String);
begin
  FcsAcesso.Enter;
  try
    if TFile.Exists(AstrArquivo) then
      TFile.Delete(AstrArquivo);
  finally
    FcsAcesso.Leave;
  end;
end;

function TTefEstacaoFilaLocal.fDescartaTudo: Integer;
var
  LarrArquivos: TStringDynArray;
  LstrArquivo: String;
begin
  Result := 0;
  FcsAcesso.Enter;
  try
    LarrArquivos := TDirectory.GetFiles(FstrDiretorio, '*.json');
    for LstrArquivo in LarrArquivos do
    begin
      { Um arquivo que nao da para apagar (em uso, permissao) nao pode
        derrubar a subida do servico - e o proximo descarte por idade
        (TEF_ESTACAO_FILA_VALIDADE_MINUTOS) tenta de novo. }
      try
        if TFile.Exists(LstrArquivo) then
        begin
          TFile.Delete(LstrArquivo);
          Inc(Result);
        end;
      except
        // contabilizado pela diferenca entre Length(LarrArquivos) e Result
      end;
    end;
  finally
    FcsAcesso.Leave;
  end;
end;

end.
