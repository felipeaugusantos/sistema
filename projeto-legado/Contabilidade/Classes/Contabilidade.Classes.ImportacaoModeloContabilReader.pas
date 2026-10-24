unit Contabilidade.Classes.ImportacaoModeloContabilReader;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Contabilidade.Classes.TImportacaoDadosContabeis,
  Contabilidade.Classes.ImportacaoModeloContabil;

type
  TImportacaoModeloContabilReader = class
  private
    FMeta   : TImportacaoModeloContabilMeta;
    FTabelas: TImportacaoModeloContabilTabelaLista;

    procedure pParseMeta(const AstrLinha: string);
    procedure pCriaFonte(const AstrNome: string; AslLinhas: TList<TArray<string>>);
  public
    constructor Create;
    destructor Destroy; override;

    procedure pParseArquivo(const AstrCaminho: string);
    procedure pParseStream(AStream: TStream);

    function fGetTabela(const AstrNome: string): TImportacaoModeloContabilTabela;
    function fGetFonte(const AstrNome: string): IImportacaoDadosContabeisFonte;
    function fTemTabela(const AstrNome: string): Boolean;
    function fGetNomesTabelas: TArray<string>;

    property Meta   : TImportacaoModeloContabilMeta        read FMeta;
    property Tabelas: TImportacaoModeloContabilTabelaLista  read FTabelas;
  end;

implementation

uses
  Contabilidade.Classes.TImportacaoDadosContabeisFonteStream,
  Contabilidade.Funcoes;

constructor TImportacaoModeloContabilReader.Create;
begin
  inherited Create;
  FTabelas := TImportacaoModeloContabilTabelaLista.Create(True);

  FMeta.strVersion := CSV_DEFAULT_VERSION;
end;

destructor TImportacaoModeloContabilReader.Destroy;
begin
  FreeAndNil(FTabelas);
  inherited;
end;

procedure TImportacaoModeloContabilReader.pParseArquivo(const AstrCaminho: string);
var
  LStream: TFileStream;
begin
  //Abre o arquivo e delega para pParseStream
  if not FileExists(AstrCaminho) then
    raise Exception.CreateFmt('Arquivo não encontrado: %s', [AstrCaminho]);

  LStream := TFileStream.Create(AstrCaminho, fmOpenRead or fmShareDenyWrite);
  try
    pParseStream(LStream);
  finally
    LStream.Free;
  end;
end;

procedure TImportacaoModeloContabilReader.pParseStream(AStream: TStream);
var
  LReader: TStreamReader;
  LParts: TArray<string>;
  LDadosRow: TArray<string>;
  LLinhasTab: TList<TArray<string>>;
  LstrLinha, LstrTag, LstrNomeTab: string;
  LblnDentroBloco, LblnPrimeiraLinha: Boolean;
  LchrSeparador: Char;
begin
  //Leitura linha a linha
  FTabelas.Clear;

  LblnDentroBloco   := False;
  LblnPrimeiraLinha := True;
  LstrNomeTab       := '';
  LLinhasTab        := nil;
  LchrSeparador     := CSV_DEFAULT_SEPARATOR;

  LReader := TStreamReader.Create(AStream, TEncoding.UTF8);
  try
    while not LReader.EndOfStream do
    begin
      //Ignora linhas vazias
      LstrLinha := LReader.ReadLine.Trim;
      if LstrLinha = '' then
        Continue;

      // Primeira linha nao-vazia deve ser META
      if LblnPrimeiraLinha then
      begin
        pParseMeta(LstrLinha);
        if Trim(FMeta.strVersion) <> CSV_DEFAULT_VERSION then
          raise Exception.CreateFmt(
            'Versao do layout inválida. Esperado [%s], encontrado [%s].',
            [CSV_DEFAULT_VERSION, Trim(FMeta.strVersion)]
          );
        LblnPrimeiraLinha := False;
        Continue;
      end;

      LParts  := LstrLinha.Split([LchrSeparador], TStringSplitOptions.None);
      LstrTag := UpperCase(LParts[0]);

      if not LblnDentroBloco then
      begin
        // Aguarda BEGIN_TABLE para iniciar um novo bloco
        if (LstrTag = CSV_TAG_BEGIN_TABLE) and (Length(LParts) >= 2) then
        begin
          LstrNomeTab     := UpperCase(Trim(LParts[1]));
          LblnDentroBloco := True;
          LLinhasTab      := TList<TArray<string>>.Create;
        end;
      end
      else
      begin
        if LstrTag = CSV_TAG_END_TABLE then
        begin
          // Fecha bloco e cria a fonte de dados
          pCriaFonte(LstrNomeTab, LLinhasTab);

          LblnDentroBloco := False;
          LstrNomeTab     := '';
          LLinhasTab      := nil;
        end
        else if LstrTag = CSV_TAG_ROW then
        begin
          // Extrai dados da linha, ignorando o primeiro elemento (ROW)
          // Compatibilidade: END_ROW eh opcional (arquivos novos e antigos)
          if Assigned(LLinhasTab) then
          begin
            LDadosRow := Copy(LParts, 1, Length(LParts) - 1);
            if (Length(LDadosRow) > 0) and SameText(LDadosRow[High(LDadosRow)], CSV_TAG_END_ROW) then
              SetLength(LDadosRow, Length(LDadosRow) - 1);
            LLinhasTab.Add(LDadosRow);
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(LReader);
  end;

  if LblnPrimeiraLinha then
    raise Exception.Create('Arquivo CSV vazio.');

  if LblnDentroBloco then
  begin
    FreeAndNil(LLinhasTab);
    raise Exception.CreateFmt('Bloco %s;%s não possui %s.',
      [CSV_TAG_BEGIN_TABLE, LstrNomeTab, CSV_TAG_END_TABLE]);
  end;
end;

procedure TImportacaoModeloContabilReader.pParseMeta(const AstrLinha: string);
var
  LParts: TArray<string>;
  LPair : TArray<string>;
  LintCount     : Integer;
begin
  //Extrai VERSION, CHARSET e SEPARATOR da linha META
  LParts := AstrLinha.Split([';'], TStringSplitOptions.None);

  if (Length(LParts) = 0) or (LParts[0].ToUpper <> CSV_TAG_META) then
    raise Exception.Create('Primeira linha deve começar com ' + CSV_TAG_META + '.');

  for LintCount := 1 to High(LParts) do
  begin
    LPair := LParts[LintCount].Split(['=']);
    if Length(LPair) <> 2 then
      Continue;

    // Apenas VERSION e variavel; CHARSET e SEPARATOR sao fixos e ignorados
    if LPair[0].ToUpper = 'VERSION' then
      FMeta.strVersion := LPair[1];
  end;
end;

procedure TImportacaoModeloContabilReader.pCriaFonte(
  const AstrNome: string;
  AslLinhas     : TList<TArray<string>>);
var
  LFonte : TImportacaoDadosContabeisFonteStream;
  LintIdx, LintCount: Integer;
  LarrLinha: TArray<string>;
  LstrTplacoEmpresa: string;
begin
  //Popula uma FonteStream a partir das linhas extraidas do bloco
  try
    LFonte := TImportacaoDadosContabeisFonteStream.Create;
    try
      LstrTplacoEmpresa := fRetTplacoEmpresaLogada('', True);

      for LintCount := 0 to AslLinhas.Count - 1 do
      begin
        LarrLinha := AslLinhas[LintCount];

        if SameText(AstrNome, DES_IMPORTACAODADOSCONTABEIS[tidcPlanoContas]) and (Length(LarrLinha) > 3) then
          LarrLinha[3] := LstrTplacoEmpresa;

        LFonte.pAdicionarLinha(LarrLinha);
      end;

      //Remove duplicada, se existir
      for LintIdx := FTabelas.Count - 1 downto 0 do
        if SameText(FTabelas[LintIdx].Nome, AstrNome) then
          FTabelas.Delete(LintIdx);

      FTabelas.Add(TImportacaoModeloContabilTabela.Create(AstrNome, LFonte));
    except
      LFonte.Free;
      raise;
    end;
  finally
    AslLinhas.Free;
  end;
end;

function TImportacaoModeloContabilReader.fGetTabela(
  const AstrNome: string): TImportacaoModeloContabilTabela;
var
  LintCount: Integer;
begin
  for LintCount := 0 to FTabelas.Count - 1 do
    if FTabelas[LintCount].Nome = AstrNome then
      Exit(FTabelas[LintCount]);

  raise Exception.CreateFmt('Tabela "%s" não encontrada no arquivo CSV.', [AstrNome]);
end;

function TImportacaoModeloContabilReader.fGetFonte(const AstrNome: string): IImportacaoDadosContabeisFonte;
begin
  Result := fGetTabela(AstrNome).Fonte;
end;

function TImportacaoModeloContabilReader.fTemTabela(const AstrNome: string): Boolean;
var
  LintCount: Integer;
begin
  for LintCount := 0 to FTabelas.Count - 1 do
    if FTabelas[LintCount].Nome = AstrNome then
      Exit(True);

  Result := False;
end;

function TImportacaoModeloContabilReader.fGetNomesTabelas: TArray<string>;
var
  LintCount: Integer;
begin
  SetLength(Result, FTabelas.Count);
  for LintCount := 0 to FTabelas.Count - 1 do
    Result[LintCount] := FTabelas[LintCount].Nome;
end;

end.
