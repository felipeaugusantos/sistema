unit untTRecorrenciaOcorrencia;

interface

uses
  Classes, SysUtils, untAtualizaOcorrenciasCRM, System.Generics.Collections, Uni,
  untModulo, untOcorrenciaCRM, untIFuncoesCRM;

type

  TTipoRecorrencia = (tpNone = -1, tpDiaria = 0, tpSemanal = 1, tpMensal = 2, tpAnual = 3);
  TTipoIntervaloRecorrencia = (tpNenhum = -1, tpData = 0, tpApos = 1, tpSemData = 2);
  TTipoFrequenciaDiaria  = (tpTodosDias = 0, tpCadaNDias = 1);
  TTipoFrequenciaSemanal = (tpDomingo = 0, tpSegunda = 1, tpTerca = 2, tpQuarta = 3, tpQuinta = 4, tpSexta = 5, tpSabado = 6);
  TTipoFrequenciaMensal  = (tpNoDia);
  TTipoFrequenciaAnual   = (tpAnos);
  TStatusRecorrencia = (tpAberta, tpFechada, tpTodas);
  TTipoProcessamento = (tpFrequencia, tpTotal);

  TFrequenciaRecorrencia = Class;
  TRecorrenciaOcorrencia =  Class
  private
    FAutInc: String;
    FObjAtuCrm: TAtuOcoCrm;
    FTipoIntervaloRecorrencia: TTipoIntervaloRecorrencia;
    FTipoRecorrencia: TTipoRecorrencia;
    FMensagemRetorno: String;
    FNroOcoParaTermino: Integer;
    FDataParaTermino: TDateTime;
    FListaFrequencia: TList<TFrequenciaRecorrencia>;
    FEnviarEmailCliente: Boolean;
    FEnviarEmailUsuario: Boolean;
    FDtaInicial: TDateTime;
    FHraInicial: TDateTime;
    FEmailCli: String;
    FEmailUsu: String;
    FStatus: TStatusRecorrencia;

    procedure pGravarRecorrencia;
    procedure pGravarFrequenciaRecorrencia;
    procedure pExcluirFrequencia;
    procedure pAtualizarRecorrenciaOcorrencia(const strCodOco: String; const blnRecorrente: Boolean;
      const tpStatus: TStatusRecorrencia);
    procedure pExcluirRecorrencia;

    function fStrToTipoIntervaloRecorencia(const strTipoIntervalo: String): TTipoIntervaloRecorrencia;
    function fStrToRecorencia(const strTipoRecorrencia: String): TTipoRecorrencia;
    function fStrToFreSem(const strDiaSem: String): TTipoFrequenciaSemanal;
    function fValidaFrequencia: Boolean;
    function fStrToStatusRec(const strStatus: String): TStatusRecorrencia;
    function fStatusRecToStr(const tpStatus: TStatusRecorrencia): String;

    function GetDtaTer: TDateTime;
    function GetItvRec: TTipoIntervaloRecorrencia;
    function GetMsgRet: String;
    function GetNroTer: Integer;
    function GetTipRec: TTipoRecorrencia;
    procedure SetDtaTer(const AValue: TDateTime);
    procedure SetItvRec(const AValue: TTipoIntervaloRecorrencia);
    procedure SetMsgRet(const AValue: String);
    procedure SetNroTer(const AValue: Integer);
    procedure SetTipRec(const AValue: TTipoRecorrencia);
    function GetLstFre: TList<TFrequenciaRecorrencia>;
    procedure SetLstFre(const AValue: TList<TFrequenciaRecorrencia>);
    function GetAutInc: String;
    function GetOcoCrm: TAtuOcoCrm;
    procedure SetOcoCrm(const AValue: TAtuOcoCrm);
    function GetEnvCli: Boolean;
    procedure SetEnvCli(const AValue: Boolean);
    procedure SetEnvUsu(const AValue: Boolean);
    function GetEnvUsu: Boolean;
    function GetDtaIni: TDateTime;
    function GetHraIni: TDateTime;
    procedure SetDtaIni(const AValue: TDateTime);
    procedure SetHraIni(const AValue: TDateTime);
    function GetEmaCli: String;
    function GetEmaUsu: String;
    procedure SetEmaCli(const AValue: String);
    procedure SetEmaUsu(const AValue: String);
    function GetStaRec: TStatusRecorrencia;
    procedure SetStaRec(const AValue: TStatusRecorrencia);
  public
    constructor Create(Owner: TAtuOcoCrm);
    destructor  Destroy; override;

    function fAddFrequencia: TFrequenciaRecorrencia;
    function fRemFrequencia(const Indice: Integer): Boolean;
    function fValidarRecorrenciaPreenchida: Boolean;

    function fInserirRecorrencia: Boolean;
    procedure pLimpar;
    procedure pCarregarRecorrencia(const strAutInc: String);
    procedure pCarregarFrequencia;
    procedure pExcluir(const strAutInc: String);
    procedure pSugerirDataInicial(const dtaIni, hraIni: TDateTime);
    procedure pAtualizarRecorrencia;

    property AutInc: String read GetAutInc;
    property Ocorrencia : TAtuOcoCrm read GetOcoCrm write SetOcoCrm;
    property MensagemRetorno: String read GetMsgRet write SetMsgRet;
    property TipoRecorrencia: TTipoRecorrencia read GetTipRec write SetTipRec;
    property IntervaloRecorrencia: TTipoIntervaloRecorrencia read GetItvRec write SetItvRec;
    property NumeroOcorrenciaParaTermino: Integer read GetNroTer write SetNroTer;
    property DataParaTermino: TDateTime read GetDtaTer write SetDtaTer;
    property Frequencia: TList<TFrequenciaRecorrencia> read GetLstFre write SetLstFre;
    property blnEnviarEmailCliente: Boolean read GetEnvCli write SetEnvCli;
    property blnEnviarEmailUsuario: Boolean read GetEnvUsu write SetEnvUsu;
    property DataInicial: TDateTime read GetDtaIni write SetDtaIni;
    property HoraInicial: TDateTime read GetHraIni write SetHraIni;
    property EmailCli: String read GetEmaCli write SetEmaCli;
    property EmailUsu: String read GetEmaUsu write SetEmaUsu;
    property Status: TStatusRecorrencia read GetStaRec write SetStaRec;

  End;

  TFrequenciaRecorrencia = Class
  [weak]
  private
    FRecorrencia : TRecorrenciaOcorrencia;
    FDiaSemana: TTipoFrequenciaSemanal;
    FIntFrequencia: Integer;
    FblnTodosDias: Boolean;
    FIndiceFrequencia: Integer;
    FAutInc: String;

    function GetIndFre: Integer;
    function GetItvFre: Integer;
    procedure SetIndFre(const AValue: Integer);
    procedure SetItvFre(const AValue: Integer);
    function GetTodDia: Boolean;
    procedure SetTodDia(const AValue: Boolean);
    function GetDiaSem: TTipoFrequenciaSemanal;
    procedure SetDiaSem(const AValue: TTipoFrequenciaSemanal);

  public
    constructor Create(Owner: TRecorrenciaOcorrencia);
    destructor Destroy; override;

    procedure pGravarFrequencia;
    procedure pExcluirFrequencia(const strAutInc: String);

    property IndiceFrequencia: Integer read GetIndFre write SetIndFre;
    property Frequencia: Integer read GetItvFre write SetItvFre;
    property blnTodosDias: Boolean read GetTodDia write SetTodDia;
    property DiaSemana: TTipoFrequenciaSemanal read GetDiaSem write SetDiaSem;
  End;

  TManutencaoRecorrencia = Class
  private
    FObjRecorrenciaPadrao: TRecorrenciaOcorrencia;
    FObjRecorrenciaManute: TRecorrenciaOcorrencia;
  public
    constructor Create;
    destructor Destroy; override;

    procedure pAtualizarRecorrencia(const ObjRecorrenciaManParam, ObjRecorrenciaParam: TRecorrenciaOcorrencia); overload;
    procedure pAtualizarRecorrencia(const ObjRecorrenciaParam: TRecorrenciaOcorrencia); overload;
  End;

  TProcessarRecorrencia = Class
  private
    FObjRecorrencia: TRecorrenciaOcorrencia;
    FNroOcorrenciasProcessadas: Integer;
    FDataAgeUltimaOcorrencia: TDateTime;
    FHoraAgeUltimaOcorrencia: TDateTime;
    FDataAgeProximaOcorrencia: TDateTime;
    FHoraAgeProximaOcorrencia: TDateTime;
    FDataUltimoProcessamento: TDateTime;
    FHoraUltimoProcessamento: TDateTime;
    FEncerrarRecorrencia: Boolean;
    FIncluirOcorrencia: Boolean;
    FAutInc: String;
    FStatus: String;
    FblnEmTeste: Boolean;
    FDataProIni: TDateTime;
    FHoraProIni: TDateTime;
    FblnRecorrenciaEncerrada: Boolean;
    FTipPro: TTipoProcessamento;
    FDtaPro: TDateTime;
    FHraPro: TDateTime;
    FMensagemRetorno: String;
    FDtaInc: TDateTime;
    FHraInc: TDateTime;

    procedure pCalcularDataProximoAgendamento(const strAutInc: String);
    procedure pGravarProcessamento(const strSeqOco, strSeqRec: String);
    procedure pProcessarRecorrenciaInterna(const aTipPro: TTipoProcessamento = tpFrequencia;
      strAutIncRec: String = '');
    procedure pProcessarRecorrenciaTotal;
    procedure pProcessarRecorrenciaPorFrequencia;

    function fObtemProximaDataHora(
      const dtaUlt, hraUlt: TDateTime; objRecorrenciaParam: TRecorrenciaOcorrencia): TDateTime;
    function fObtemDataHoraFrequenciaDiario(
      const dtaHorUlt: TDateTime; blnDiario: Boolean; intDia: Integer): TDateTime;
    function fObtemDataHoraFrequenciaMensal(
      const dtaUlt, hraUlt: TDateTime; intDia: Integer): TDateTime;
    function fObtemDataHoraFrequenciaAnual(
      const dtaHorUlt: TDateTime; intDia: Integer): TDateTime;

    function fRetornaDataInclusao(aTipPro: TTipoProcessamento = tpFrequencia): TDateTime;
    function fRetornaHoraInclusao(aTipPro: TTipoProcessamento = tpFrequencia): TDateTime;
    procedure pCarregarRecorrenciaInt(strAutInc: String);

    function getDUltPro: TDateTime;
    function getHUltPro: TDateTime;
    function getBlnTst: Boolean;
    procedure setBlnTst(const Value: Boolean);
    function GetBlnRecEnc: Boolean;
    procedure SetBlnRecEnc(const Value: Boolean);
    function GetTipPro: TTipoProcessamento;
    procedure SetTipPro(const Value: TTipoProcessamento);
    function GetMsgRet: String;
  public
    constructor Create;
    destructor Destroy; override;

    procedure pProcessarRecorrencias(const aTipPro: TTipoProcessamento = tpFrequencia;
      const strAutIncRec: String = '');
    procedure pCarregarDataUltimoProcessamento(const strAutInc: String);
    procedure pInativaProcessamento(const strSeqRec: String);
    class function fTipProToStr(const aTipPro: TTipoProcessamento): String;
    class function fStrToTipPro(const strTipPro: String): TTipoProcessamento;

    property DataUltimoProcessamento: TDateTime read getDUltPro;
    property HoraUltimoProcessamento: TDateTime read getHUltPro;
    property blnEmTeste: Boolean read getBlnTst write setBlnTst;
    property blnRecorrenciaEncerrada: Boolean read GetBlnRecEnc write SetBlnRecEnc;
    property TipoProcessamento: TTipoProcessamento read GetTipPro write SetTipPro;
    property strMensagemRetorno: String read GetMsgRet;

  End;

const
  arrTipoRecorrencia: array[TTipoRecorrencia] of string = ('','Diária', 'Semanal', 'Mensal', 'Anual');
  arrTipoIntervaloRecorrencia: array[TTipoIntervaloRecorrencia] of string = ('','Termina em', 'Termina após', 'Sem data de término');
  arrTipoFrequenciaDiaria: array[TTipoFrequenciaDiaria] of string = ('Todos os dias', 'A cada NN dias');
  arrTipoFrequenciaSemanal: array[TTipoFrequenciaSemanal] of string = ('Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado');

  arrStrTipoRecorrencia: array[TTipoRecorrencia] of string = ('','D', 'S', 'M', 'A');
  arrFrequenciaDiaria: array[TTipoFrequenciaDiaria] of string = ('C','T');
  arrFrequenciaSemanal: array[TTipoFrequenciaSemanal] of string = ('D','S', 'T', 'Q', 'U', 'X', 'B');
  arrFrequenciaMensal: array[TTipoFrequenciaMensal] of string = ('D');
  arrFrequenciaAnual: array[TTipoFrequenciaAnual] of string = ('A');
  arrStrTipoIntervaloRecorrencia: array[TTipoIntervaloRecorrencia] of string = ('','D', 'A', 'S');
  arrStatusRecorrencia: array[TStatusRecorrencia] of string = ('A','F', 'T');
  arrTipoProcessamento: array[TTipoProcessamento] of string = ('F','T');

implementation

uses
  untFuncoesSimples, StrUtils, DateUtils;

{ TRecorrenciaOcorrencia }

constructor TRecorrenciaOcorrencia.Create(Owner: TAtuOcoCrm);
begin
  FObjAtuCrm := Owner;
  FListaFrequencia := TList<TFrequenciaRecorrencia>.Create;
  pLimpar;
end;

destructor TRecorrenciaOcorrencia.Destroy;
begin
  FreeAndNil(FListaFrequencia);

  inherited;
end;

function TRecorrenciaOcorrencia.fAddFrequencia: TFrequenciaRecorrencia;
var
  intCont: Integer;
begin
  FListaFrequencia.add(TFrequenciaRecorrencia.Create(Self));
  intCont := FListaFrequencia.Count -1;
  Result  := FListaFrequencia[intCont];
end;

function TRecorrenciaOcorrencia.fInserirRecorrencia: Boolean;
Var
  blnTransacaoIniciada: Boolean;
begin
  blnTransacaoIniciada := frmModulo.GetCurrentConnection.InTransaction;
  Try
    If Not blnTransacaoIniciada Then
      fStartTransaction;

    pGravarRecorrencia;
    pGravarFrequenciaRecorrencia;
    pAtualizarRecorrenciaOcorrencia(FObjAtuCrm.strAutInc, True, FStatus);

    If Not blnTransacaoIniciada Then
      fCommit;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      If Not blnTransacaoIniciada Then
        fRollback;
      pMensagensErro(E.Message, '[TRecorrenciaOcorrencia.fInserirRecorrencia]');
    End;
  End;
end;

function TRecorrenciaOcorrencia.fRemFrequencia(const Indice: Integer): Boolean;
var
  intCnt: Integer;
begin
  Result := False;
  For intCnt := 0 To FListaFrequencia.Count-1 Do
  Begin
    If FListaFrequencia[intCnt].IndiceFrequencia = Indice Then
    Begin
      FListaFrequencia.Delete(intCnt);
      Result := True;
      Break;
    End;
  End;
end;

function TRecorrenciaOcorrencia.fStrToTipoIntervaloRecorencia(const strTipoIntervalo: String): TTipoIntervaloRecorrencia;
Begin
  Case AnsiIndexStr(UpperCase(strTipoIntervalo), arrStrTipoIntervaloRecorrencia) Of
    1 : Result := tpData;
    2 : Result := tpApos;
    3 : Result := tpSemData;
    Else
      Result := tpNenhum;
  End;
End;

function TRecorrenciaOcorrencia.fStrToRecorencia(const strTipoRecorrencia: String): TTipoRecorrencia;
Begin
  Case AnsiIndexStr(UpperCase(strTipoRecorrencia), arrStrTipoRecorrencia) Of
    1 : Result := tpDiaria;
    2 : Result := tpSemanal;
    3 : Result := tpMensal;
    4 : Result := tpAnual;
    Else
      Result := tpNone;
  End;
End;

function TRecorrenciaOcorrencia.fStrToStatusRec(
  const strStatus: String): TStatusRecorrencia;
begin
  Case AnsiIndexStr(UpperCase(strStatus), arrStatusRecorrencia) Of
    1 : Result := tpFechada;
    2 : Result := tpTodas;
    Else
      Result := tpAberta;
  End;
end;

function TRecorrenciaOcorrencia.fStatusRecToStr(
  const tpStatus: TStatusRecorrencia): String;
begin
  Result := arrStatusRecorrencia[tpStatus];
end;

function TRecorrenciaOcorrencia.fStrToFreSem(const strDiaSem: String): TTipoFrequenciaSemanal;
Begin
  Case AnsiIndexStr(UpperCase(strDiaSem), arrFrequenciaSemanal) Of
    1 : Result := tpSegunda;
    2 : Result := tpTerca;
    3 : Result := tpQuarta;
    4 : Result := tpQuinta;
    5 : Result := tpSexta;
    6 : Result := tpSabado
    Else
      Result := tpDomingo;
  End;
End;

function TRecorrenciaOcorrencia.fValidaFrequencia: Boolean;
begin
  Result := FListaFrequencia.Count > 0;

  If Not Result Then
    Exit;

  Case FTipoRecorrencia of
    tpDiaria : Begin
                 Result := (FListaFrequencia[0].blnTodosDias) or (FListaFrequencia[0].FIntFrequencia > 0);
               End;
    tpMensal,
    tpAnual  : Begin
                 Result := (FListaFrequencia[0].FIntFrequencia > 0);
               End;
  End;
end;

function TRecorrenciaOcorrencia.fValidarRecorrenciaPreenchida: Boolean;
begin
  Result := True;

  If FTipoRecorrencia = tpNone Then
  Begin
    FMensagemRetorno := 'Para tornar a ocorrência recorrente, é preciso escolher a Recorrência!';
    Result := False;
    Exit;
  End;

  If Not fValidaFrequencia Then
  Begin
    FMensagemRetorno := 'Para tornar a ocorrência recorrente, é preciso informar a Frequência!';
    Result := False;
    Exit;
  End;

  If FTipoIntervaloRecorrencia = tpNenhum Then
  Begin
    FMensagemRetorno := 'Para tornar a ocorrência recorrente, é preciso escolher o Intervalo de Recorrência!';
    Result := False;
    Exit;
  End
  Else Begin
    If (FNroOcoParaTermino = 0) And (FDataParaTermino = 0) And (FTipoIntervaloRecorrencia <> tpSemData) Then
    Begin
      FMensagemRetorno := 'Para tornar a ocorrência recorrente, é preciso informar o término do Intervalo de Recorrência!';
      Result := False;
      Exit;
    End;

    If (FNroOcoParaTermino > fCfgSis('QTOREC', varInteger)) Then
    Begin
      FMensagemRetorno := 'A quantidade de recorrência por cliente é superior à máxima estabelecida na configuração ' +
                          '"CFG_QTOREC - Quantidade limite de recorrência de ocorrência por cliente". ' +
                          'É necessário rever as opções desta recorrência ou ajustar a quantidade máxima da configuração e refazer o processo.';
      Result := False;
      Exit;
    End;
  End;

  If (FStatus = tpTodas) And (FTipoIntervaloRecorrencia = tpSemData) Then
  Begin
    FMensagemRetorno := 'Para gerar todas as ocorrências, o período para término precisa ser informado.';
    Result := False;
    Exit;
  End;

end;

function TRecorrenciaOcorrencia.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TRecorrenciaOcorrencia.GetDtaIni: TDateTime;
begin
  Result := FDtaInicial;
end;

function TRecorrenciaOcorrencia.GetDtaTer: TDateTime;
begin
  Result := FDataParaTermino;
end;

function TRecorrenciaOcorrencia.GetEmaCli: String;
begin
  Result := FEmailCli;
end;

function TRecorrenciaOcorrencia.GetEmaUsu: String;
begin
  Result := FEmailUsu;
end;

function TRecorrenciaOcorrencia.GetEnvCli: Boolean;
begin
  Result := FEnviarEmailCliente;
end;

function TRecorrenciaOcorrencia.GetEnvUsu: Boolean;
begin
  Result := FEnviarEmailUsuario;
end;

function TRecorrenciaOcorrencia.GetHraIni: TDateTime;
begin
  Result := FHraInicial;
end;

function TRecorrenciaOcorrencia.GetItvRec: TTipoIntervaloRecorrencia;
begin
  Result := FTipoIntervaloRecorrencia;
end;

function TRecorrenciaOcorrencia.GetLstFre: TList<TFrequenciaRecorrencia>;
begin
  Result := FListaFrequencia;
end;

function TRecorrenciaOcorrencia.GetMsgRet: String;
begin
  Result := FMensagemRetorno;
end;

function TRecorrenciaOcorrencia.GetNroTer: Integer;
begin
  Result := FNroOcoParaTermino;
end;

function TRecorrenciaOcorrencia.GetOcoCrm: TAtuOcoCrm;
begin
  Result := FObjAtuCrm;
end;

function TRecorrenciaOcorrencia.GetStaRec: TStatusRecorrencia;
begin
  Result := FStatus;
end;

function TRecorrenciaOcorrencia.GetTipRec: TTipoRecorrencia;
begin
  Result := FTipoRecorrencia;
end;

procedure TRecorrenciaOcorrencia.pAtualizarRecorrencia;
var
  qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.DisableControls;
    qryUpdate.SQL.Add('UPDATE OCOREC SET REC_TIPREC = :REC_TIPREC, ');
    qryUpdate.SQL.Add('                  REC_DTAREC = :REC_DTAREC, ');
    qryUpdate.SQL.Add('                  REC_HRAREC = :REC_HRAREC, ');
    qryUpdate.SQL.Add('                  REC_QTDTER = :REC_QTDTER, ');
    qryUpdate.SQL.Add('                  REC_DTATER = :REC_DTATER, ');
    qryUpdate.SQL.Add('                  REC_ENVCLI = :REC_ENVCLI, ');
    qryUpdate.SQL.Add('                  REC_ENVUSU = :REC_ENVUSU, ');
    qryUpdate.SQL.Add('                  REC_TIPITV = :REC_TIPITV, ');
    qryUpdate.SQL.Add('                  REC_DTAINI = :REC_DTAINI, ');
    qryUpdate.SQL.Add('                  REC_HRAINI = :REC_HRAINI  ');
    qryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM');

    qryUpdate.ParamByName('AUTOINCREM').AsString := FAutInc;
    qryUpdate.ParamByName('REC_TIPREC').AsString := arrStrTipoRecorrencia[FTipoRecorrencia];
    qryUpdate.ParamByName('REC_DTAREC').AsDateTime := VS_Date;
    qryUpdate.ParamByName('REC_HRAREC').AsDateTime := fNow();
    qryUpdate.ParamByName('REC_QTDTER').AsInteger := FNroOcoParaTermino;
    qryUpdate.ParamByName('REC_DTATER').AsDateTime := FDataParaTermino;
    qryUpdate.ParamByName('REC_ENVCLI').AsString := IIF(FEnviarEmailCliente, 'S', 'N');
    qryUpdate.ParamByName('REC_ENVUSU').AsString := IIF(FEnviarEmailUsuario, 'S', 'N');
    qryUpdate.ParamByName('REC_TIPITV').AsString := arrStrTipoIntervaloRecorrencia[FTipoIntervaloRecorrencia];
    qryUpdate.ParamByName('REC_DTAINI').AsDateTime := FDtaInicial;
    qryUpdate.ParamByName('REC_HRAINI').AsDateTime := FHraInicial;

    qryUpdate.ExecSQL;
  Finally
    qryUpdate.Close;
    FreeAndNil(qryUpdate);
  End;
end;

procedure TRecorrenciaOcorrencia.pAtualizarRecorrenciaOcorrencia(const strCodOco: String;
  const blnRecorrente: Boolean; const tpStatus: TStatusRecorrencia);
var
  qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.DisableControls;

    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE OCOREC SET REC_STATUS = :STATUS ');
    qryUpdate.SQL.Add('  WHERE AUTOINCREM = :AUTOINCREM');
    qryUpdate.ParamByName('AUTOINCREM').AsString := FAutInc;
    qryUpdate.ParamByName('STATUS').AsString := fStatusRecToStr(tpStatus);
    qryUpdate.ExecSQL;

    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE MOVOCO SET           ');
    qryUpdate.SQL.Add('  OCO_OCOREC = :OCO_OCOREC, ');
    qryUpdate.SQL.Add('  OCO_SEQREC = :OCO_SEQREC  ');
    qryUpdate.SQL.Add('  WHERE AUTOINCREM = :AUTOINCREM');
    qryUpdate.ParamByName('AUTOINCREM').AsString := strCodOco;
    qryUpdate.ParamByName('OCO_OCOREC').AsString := IIF(blnRecorrente, 'S', 'N');
    qryUpdate.ParamByName('OCO_SEQREC').AsString := FAutInc;
    qryUpdate.ExecSQL;
  Finally
    qryUpdate.Close;
    FreeAndNil(qryUpdate);
  End;
end;

procedure TRecorrenciaOcorrencia.pCarregarFrequencia;
var
  ObjFrequencia: TFrequenciaRecorrencia;
  qryFreRec: TUniQuery;
begin
  FListaFrequencia.Clear;

  qryFreRec := fCriaQuery;
  Try
    qryFreRec.DisableControls;
    qryFreRec.SQL.Add('SELECT * FROM FREREC WHERE FRE_SEQREC = :SEQREC');
    qryFreRec.ParamByName('SEQREC').AsString := FAutInc;
    qryFreRec.Open;
    While Not qryFreRec.Eof Do
    Begin
      ObjFrequencia := fAddFrequencia;
      ObjFrequencia.FblnTodosDias := IIF(qryFreRec.FieldByName('FRE_DIARIO').AsString = 'S', True, False);
      ObjFrequencia.FIntFrequencia := qryFreRec.FieldByName('FRE_INTFRE').AsInteger;
      ObjFrequencia.DiaSemana := fStrToFreSem(qryFreRec.FieldByName('FRE_DIASEM').AsString);
      Case FTipoRecorrencia Of
          tpSemanal : ObjFrequencia.IndiceFrequencia := Integer(ObjFrequencia.DiaSemana)
        Else
          ObjFrequencia.IndiceFrequencia := 0;
      End;
      qryFreRec.Next;
    End;
  Finally
    qryFreRec.Close;
    FreeAndNil(qryFreRec);
  End;
end;

procedure TRecorrenciaOcorrencia.pCarregarRecorrencia(const strAutInc: String);
var
  qryOcoRec: TUniQuery;
begin
  pLimpar;

  If Not Assigned(FObjAtuCrm) Then
    FObjAtuCrm := TAtuOcoCrm.Create(Nil);

  qryOcoRec := fCriaQuery;
  Try
    qryOcoRec.DisableControls;
    qryOcoRec.SQL.Add('SELECT OCOREC.*,   ');
    qryOcoRec.SQL.Add('       OCO_TIP_FC, ');
    qryOcoRec.SQL.Add('       OCO_CODEMP  ');
    qryOcoRec.SQL.Add('FROM OCOREC        ');
    qryOcoRec.SQL.Add('  INNER JOIN MOVOCO ON REC_SEQOCO = MOVOCO.AUTOINCREM ');
    qryOcoRec.SQL.Add('WHERE OCOREC.AUTOINCREM = :AUTINC');

    qryOcoRec.ParamByName('AUTINC').AsString := strAutInc;
    qryOcoRec.Open;
    While Not qryOcoRec.Eof Do
    Begin
      FAutInc := qryOcoRec.FieldByName('AUTOINCREM').AsString;
      FObjAtuCrm.pCarregaOcorrencia(qryOcoRec.FieldByName('OCO_TIP_FC').AsString, qryOcoRec.FieldByName('REC_SEQOCO').AsString, qryOcoRec.FieldByName('OCO_CODEMP').AsString);
      FTipoIntervaloRecorrencia := fStrToTipoIntervaloRecorencia(qryOcoRec.FieldByName('REC_TIPITV').AsString);
      FTipoRecorrencia := fStrToRecorencia(qryOcoRec.FieldByName('REC_TIPREC').AsString);
      FNroOcoParaTermino := qryOcoRec.FieldByName('REC_QTDTER').AsInteger;
      FDataParaTermino := qryOcoRec.FieldByName('REC_DTATER').AsDateTime;
      FEnviarEmailCliente := IIF(qryOcoRec.FieldByName('REC_ENVCLI').AsString = 'S', True, False);
      FEnviarEmailUsuario := IIF(qryOcoRec.FieldByName('REC_ENVUSU').AsString = 'S', True, False);
      FDtaInicial := qryOcoRec.FieldByName('REC_DTAINI').AsDateTime;
      FHraInicial := qryOcoRec.FieldByName('REC_HRAINI').AsDateTime;
      FStatus := fStrToStatusRec(qryOcoRec.FieldByName('REC_STATUS').AsString);

      pCarregarFrequencia;

      qryOcoRec.Next;
    End;
  Finally
    qryOcoRec.Close;
    FreeAndNil(qryOcoRec);
  End;
end;

procedure TRecorrenciaOcorrencia.pExcluir(const strAutInc: String);
begin
  pCarregarRecorrencia(strAutInc);
  pExcluirFrequencia;
  pExcluirRecorrencia;
  pAtualizarRecorrenciaOcorrencia(FObjAtuCrm.strAutInc, False, tpFechada);
end;

procedure TRecorrenciaOcorrencia.pExcluirFrequencia;
var
  intCnt: Integer;
begin
  For intCnt := 0 To FListaFrequencia.Count-1 Do
  Begin
    FListaFrequencia[intCnt].pExcluirFrequencia(FAutInc);
  End;
end;

procedure TRecorrenciaOcorrencia.pExcluirRecorrencia;
var
  qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery;
  Try
    qryDelete.DisableControls;
    qryDelete.SQL.Add('DELETE FROM OCOREC WHERE AUTOINCREM = :AUTOINCREM');
    qryDelete.ParamByName('AUTOINCREM').AsString := FAutInc;

    qryDelete.ExecSQL;
  Finally
    qryDelete.Close;
    FreeAndNil(qryDelete);
  End;
end;

procedure TRecorrenciaOcorrencia.pGravarFrequenciaRecorrencia;
var
  intCnt: Integer;
begin
  For intCnt := 0 To FListaFrequencia.Count-1 Do
  Begin
    FListaFrequencia[intCnt].pGravarFrequencia;
  End;
end;

procedure TRecorrenciaOcorrencia.pGravarRecorrencia;
var
  strInsert: String;
  qryInsert: TUniQuery;
begin
  strInsert := 'INSERT INTO OCOREC(AUTOINCREM, REC_CODEMP, REC_SEQOCO, REC_TIPREC, REC_TIPITV, ' +
                                  'REC_ENVCLI, REC_ENVUSU, REC_QTDTER, REC_DTATER, REC_DTAREC, REC_HRAREC, ' +
                                  'REC_DTAINI, REC_HRAINI, REC_EMACLI, REC_EMAUSU)' +
               '  VALUES(:AUTOINCREM, :REC_CODEMP, :REC_SEQOCO, :REC_TIPREC, :REC_TIPITV, ' +
                        ':REC_ENVCLI, :REC_ENVUSU, :REC_QTDTER, :REC_DTATER, :REC_DTAREC, :REC_HRAREC, ' +
                        ':REC_DTAINI, :REC_HRAINI, :REC_EMACLI, :REC_EMAUSU)';

  FAutInc := fRetAutoIncrem('OCOREC', VS_strCodEmp);
  qryInsert := fCriaQuery;
  Try
    qryInsert.DisableControls;
    qryInsert.SQL.Add(strInsert);
    qryInsert.ParamByName('AUTOINCREM').AsString := FAutInc;
    qryInsert.ParamByName('REC_CODEMP').AsString := VS_strCodEmp;
    qryInsert.ParamByName('REC_SEQOCO').AsString := FObjAtuCrm.strAutInc;
    qryInsert.ParamByName('REC_TIPREC').AsString := arrStrTipoRecorrencia[FTipoRecorrencia];
    qryInsert.ParamByName('REC_ENVCLI').AsString := IIF(FEnviarEmailCliente, 'S', 'N');
    qryInsert.ParamByName('REC_ENVUSU').AsString := IIF(FEnviarEmailUsuario, 'S', 'N');
    qryInsert.ParamByName('REC_TIPITV').AsString := arrStrTipoIntervaloRecorrencia[FTipoIntervaloRecorrencia];
    qryInsert.ParamByName('REC_QTDTER').AsInteger := FNroOcoParaTermino;
    qryInsert.ParamByName('REC_DTATER').AsDateTime := FDataParaTermino;
    qryInsert.ParamByName('REC_DTAREC').AsDateTime := VS_Date;
    qryInsert.ParamByName('REC_HRAREC').AsDateTime := fNow();
    qryInsert.ParamByName('REC_DTAINI').AsDateTime := FDtaInicial;
    qryInsert.ParamByName('REC_HRAINI').AsDateTime := FHraInicial;
    qryInsert.ParamByName('REC_EMACLI').AsString := FEmailCli;
    qryInsert.ParamByName('REC_EMAUSU').AsString := FEmailUsu;

    qryInsert.ExecSQL;
  Finally
    qryInsert.Close;
    FreeAndNil(qryInsert);
  End;
end;

procedure TRecorrenciaOcorrencia.pLimpar;
begin
  FStatus := tpAberta;
  FTipoRecorrencia := tpNone;
  FTipoIntervaloRecorrencia := tpNenhum;
  FListaFrequencia.Clear;
end;

procedure TRecorrenciaOcorrencia.pSugerirDataInicial(const dtaIni,
  hraIni: TDateTime);
begin
  If FDtaInicial <= 0 Then
    FDtaInicial := dtaIni;
  If FHraInicial <= 0 Then
    FHraInicial := hraIni;
end;

procedure TRecorrenciaOcorrencia.SetDtaIni(const AValue: TDateTime);
begin
  FDtaInicial := AValue;
end;

procedure TRecorrenciaOcorrencia.SetDtaTer(const AValue: TDateTime);
begin
  FDataParaTermino := AValue;
end;

procedure TRecorrenciaOcorrencia.SetEmaCli(const AValue: String);
begin
  FEmailCli := AValue;
end;

procedure TRecorrenciaOcorrencia.SetEmaUsu(const AValue: String);
begin
  FEmailUsu := AValue;
end;

procedure TRecorrenciaOcorrencia.SetEnvCli(const AValue: Boolean);
begin
  FEnviarEmailCliente := AValue;
end;

procedure TRecorrenciaOcorrencia.SetEnvUsu(const AValue: Boolean);
begin
  FEnviarEmailUsuario := AValue;
end;

procedure TRecorrenciaOcorrencia.SetHraIni(const AValue: TDateTime);
begin
  FHraInicial := AValue;
end;

procedure TRecorrenciaOcorrencia.SetItvRec(
  const AValue: TTipoIntervaloRecorrencia);
begin
  FTipoIntervaloRecorrencia := AValue;
end;

procedure TRecorrenciaOcorrencia.SetLstFre(
  const AValue: TList<TFrequenciaRecorrencia>);
begin
  FListaFrequencia := AValue;
end;

procedure TRecorrenciaOcorrencia.SetMsgRet(const AValue: String);
begin
  FMensagemRetorno := AValue;
end;

procedure TRecorrenciaOcorrencia.SetNroTer(const AValue: Integer);
begin
  FNroOcoParaTermino := AValue;
end;

procedure TRecorrenciaOcorrencia.SetOcoCrm(const AValue: TAtuOcoCrm);
begin
  FObjAtuCrm := AValue;
end;

procedure TRecorrenciaOcorrencia.SetStaRec(const AValue: TStatusRecorrencia);
begin
  FStatus := AValue;
end;

procedure TRecorrenciaOcorrencia.SetTipRec(const AValue: TTipoRecorrencia);
begin
  FTipoRecorrencia := AValue;
end;

{ TFrequenciaRecorrencia }

constructor TFrequenciaRecorrencia.Create(Owner: TRecorrenciaOcorrencia);
begin
  FRecorrencia := Owner;
end;

destructor TFrequenciaRecorrencia.Destroy;
begin

  inherited;
end;

function TFrequenciaRecorrencia.GetDiaSem: TTipoFrequenciaSemanal;
begin
  Result := FDiaSemana;
end;

function TFrequenciaRecorrencia.GetIndFre: Integer;
begin
  Result := FIndiceFrequencia;
end;

function TFrequenciaRecorrencia.GetItvFre: Integer;
begin
  Result := FIntFrequencia;
end;

function TFrequenciaRecorrencia.GetTodDia: Boolean;
begin
  Result := FblnTodosDias;
end;

procedure TFrequenciaRecorrencia.pExcluirFrequencia(const strAutInc: String);
var
  qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery;
  Try
    qryDelete.DisableControls;
    qryDelete.SQL.Add('DELETE FROM FREREC WHERE FRE_SEQREC = :FRE_SEQREC');
    qryDelete.ParamByName('FRE_SEQREC').AsString := strAutInc;

    qryDelete.ExecSQL;
  Finally
    qryDelete.Close;
    FreeAndNil(qryDelete);
  End;
end;

procedure TFrequenciaRecorrencia.pGravarFrequencia;
var
  strInsert: String;
  qryInsert: TUniQuery;
begin
  strInsert := 'INSERT INTO FREREC(AUTOINCREM, FRE_SEQREC, FRE_TIPFRE, FRE_DIARIO, FRE_DIASEM, FRE_INTFRE)' +
               '   VALUES(:AUTOINCREM, :FRE_SEQREC, :FRE_TIPFRE, :FRE_DIARIO, :FRE_DIASEM, :FRE_INTFRE)';

  FAutInc := fRetAutoIncrem('FREREC', VS_strCodEmp);

  qryInsert := fCriaQuery;
  Try
    qryInsert.DisableControls;
    qryInsert.SQL.Add(strInsert);
    qryInsert.ParamByName('AUTOINCREM').AsString := FAutInc;
    qryInsert.ParamByName('FRE_SEQREC').AsString := FRecorrencia.AutInc;
    qryInsert.ParamByName('FRE_TIPFRE').AsString := arrStrTipoRecorrencia[FRecorrencia.TipoRecorrencia];
    qryInsert.ParamByName('FRE_DIARIO').AsString := IIF(FblnTodosDias, 'S', 'N');
    qryInsert.ParamByName('FRE_DIASEM').AsString := arrFrequenciaSemanal[FDiaSemana];
    qryInsert.ParamByName('FRE_INTFRE').AsInteger := FIntFrequencia;

    qryInsert.ExecSQL;
  Finally
    qryInsert.Close;
    FreeAndNil(qryInsert);
  End;
end;

procedure TFrequenciaRecorrencia.SetDiaSem(const AValue: TTipoFrequenciaSemanal);
begin
  FDiaSemana := AValue;
end;

procedure TFrequenciaRecorrencia.SetIndFre(const AValue: Integer);
begin
  FIndiceFrequencia := AValue;
  Case FRecorrencia.TipoRecorrencia Of
    tpSemanal : FDiaSemana := TTipoFrequenciaSemanal(FIndiceFrequencia);
  End;
end;

procedure TFrequenciaRecorrencia.SetItvFre(const AValue: Integer);
begin
  FIntFrequencia := AValue;
end;

procedure TFrequenciaRecorrencia.SetTodDia(const AValue: Boolean);
begin
  FblnTodosDias := AValue;
end;

{ TManutencaoRecorrencia }

constructor TManutencaoRecorrencia.Create;
begin

end;

destructor TManutencaoRecorrencia.Destroy;
begin

  inherited;
end;

procedure TManutencaoRecorrencia.pAtualizarRecorrencia(
  const ObjRecorrenciaParam: TRecorrenciaOcorrencia);
var
  objPro: TProcessarRecorrencia;
begin
  objPro := TProcessarRecorrencia.Create;
  Try
    FObjRecorrenciaManute := ObjRecorrenciaParam;
    FObjRecorrenciaManute.pExcluirFrequencia;
    FObjRecorrenciaManute.pAtualizarRecorrencia;
    FObjRecorrenciaManute.pGravarFrequenciaRecorrencia;
    objPro.pInativaProcessamento(FObjRecorrenciaManute.AutInc);
    If ObjRecorrenciaParam.Status = tpTodas Then
    Begin
      objPro.pProcessarRecorrencias(tpTotal, ObjRecorrenciaParam.AutInc);
    End;
    If Not fEmptyStr(objPro.strMensagemRetorno) Then
    Begin
      fMensagem('ATENÇÃO!', objPro.strMensagemRetorno, ['&Ok']);
    End;
  Finally
    FreeAndNil(objPro);
  End;
end;

procedure TManutencaoRecorrencia.pAtualizarRecorrencia(const ObjRecorrenciaManParam,
  ObjRecorrenciaParam: TRecorrenciaOcorrencia);
var
  ObjItemFrequencia: TFrequenciaRecorrencia;
  int: Integer;
begin
  FObjRecorrenciaManute := ObjRecorrenciaManParam;
  FObjRecorrenciaPadrao := ObjRecorrenciaParam;

  FObjRecorrenciaManute.IntervaloRecorrencia:= FObjRecorrenciaPadrao.IntervaloRecorrencia;
  FObjRecorrenciaManute.TipoRecorrencia := FObjRecorrenciaPadrao.TipoRecorrencia;
  FObjRecorrenciaManute.NumeroOcorrenciaParaTermino := FObjRecorrenciaPadrao.NumeroOcorrenciaParaTermino;
  FObjRecorrenciaManute.DataParaTermino := FObjRecorrenciaPadrao.DataParaTermino;
  FObjRecorrenciaManute.blnEnviarEmailCliente := FObjRecorrenciaPadrao.blnEnviarEmailCliente;
  FObjRecorrenciaManute.blnEnviarEmailUsuario := FObjRecorrenciaPadrao.blnEnviarEmailUsuario;
  FObjRecorrenciaManute.DataInicial := FObjRecorrenciaPadrao.DataInicial;
  FObjRecorrenciaManute.HoraInicial := FObjRecorrenciaPadrao.HoraInicial;

  FObjRecorrenciaManute.pExcluirFrequencia;
  FObjRecorrenciaManute.Frequencia.Clear;

  For int:= 0 to FObjRecorrenciaPadrao.Frequencia.Count-1 Do
  Begin
    ObjItemFrequencia := FObjRecorrenciaManute.fAddFrequencia;
    ObjItemFrequencia.DiaSemana := FObjRecorrenciaPadrao.Frequencia[int].DiaSemana;
    ObjItemFrequencia.blnTodosDias := FObjRecorrenciaPadrao.Frequencia[int].blnTodosDias;
    ObjItemFrequencia.IndiceFrequencia := FObjRecorrenciaPadrao.Frequencia[int].IndiceFrequencia;
    ObjItemFrequencia.Frequencia := FObjRecorrenciaPadrao.Frequencia[int].Frequencia;
  End;

  FObjRecorrenciaManute.pAtualizarRecorrencia;
  FObjRecorrenciaManute.pGravarFrequenciaRecorrencia;
end;

{ TProcessarRecorrencia }

constructor TProcessarRecorrencia.Create;
begin
  FObjRecorrencia := TRecorrenciaOcorrencia.Create(Nil);
  FEncerrarRecorrencia := False;
  FIncluirOcorrencia := True;
  FblnEmTeste := False;
  FblnRecorrenciaEncerrada := False;
  FTipPro := tpFrequencia;
  FMensagemRetorno := EmptyStr;
end;

destructor TProcessarRecorrencia.Destroy;
begin

  FreeAndNil(FObjRecorrencia);

  inherited;
end;

function TProcessarRecorrencia.fObtemDataHoraFrequenciaAnual(
  const dtaHorUlt: TDateTime; intDia: Integer): TDateTime;
var
  ano: Word;
  dtaHorProx: TDateTime;
begin
  dtaHorProx := dtaHorUlt + (365 * intDia);

  ano := yearOf(dtaHorProx);
  If IsLeapYear(ano) Then
   dtaHorProx := dtaHorUlt + (366 * intDia);

  Result := dtaHorProx;
end;

function TProcessarRecorrencia.fObtemDataHoraFrequenciaDiario(
  const dtaHorUlt: TDateTime; blnDiario: Boolean;
  intDia: Integer): TDateTime;
begin
  If blnDiario Then
  Begin
    Result := dtaHorUlt + 1;
  End
  Else
    Result := dtaHorUlt + intDia ;
end;

function TProcessarRecorrencia.fObtemDataHoraFrequenciaMensal(
  const dtaUlt, hraUlt: TDateTime; intDia: Integer): TDateTime;
var
  dia: Word;
  mes: Word;
  ano: Word;
  dtaHorUlt,
  dtaHorProx: TDateTime;
begin
  dtaHorUlt :=  dtaUlt + hraUlt;

  dia := intDia;
  mes := MonthOf(dtaHorUlt);
  ano := yearOf(dtaHorUlt);
  If (mes = 12) Then
  Begin
    mes := 1;
    ano := ano + 1;
  End
  Else
    mes := mes + 1;

  dtaHorProx := EncodeDate(ano, mes, dia);
  dtaHorProx := dtaHorProx + hraUlt;

  Result := dtaHorProx;
end;

function TProcessarRecorrencia.fObtemProximaDataHora(
  const dtaUlt, hraUlt: TDateTime;  objRecorrenciaParam: TRecorrenciaOcorrencia): TDateTime;
var
  intCnt: Integer;

  dtaHorUlt: TDateTime;
  dtaHorProx: TDateTime;
  intDiaSem,
  intDiaSel: Integer;
  dtaHorAux: TDateTime;
begin
  dtaHorProx := 0;
  dtaHorUlt := dtaUlt + hraUlt;

  Try

    If objRecorrenciaParam.TipoRecorrencia = tpSemanal Then
    Begin
      dtaHorAux := dtaHorUlt;
      Repeat

        dtaHorAux := dtaHorAux + 1;
        intDiaSem := DayOfWeek(dtaHorAux);
        For intCnt:= 0 To objRecorrenciaParam.Frequencia.Count -1 Do
        Begin
          intDiaSel := objRecorrenciaParam.Frequencia[intCnt].IndiceFrequencia +1;
          If intDiaSem = intDiaSel Then
          Begin
            dtaHorProx := dtaHorAux;
          End;
        End;

      Until dtaHorProx > 0;

    End
    Else
    Begin
      For intCnt:= 0 To objRecorrenciaParam.Frequencia.Count -1 Do
      Begin
        Case objRecorrenciaParam.TipoRecorrencia Of
          tpDiaria : Begin
                       dtaHorProx := fObtemDataHoraFrequenciaDiario(dtaHorUlt,
                                                                    objRecorrenciaParam.Frequencia[intCnt].blnTodosDias,
                                                                    objRecorrenciaParam.Frequencia[intCnt].FIntFrequencia);
                     End;
          tpMensal : Begin
                       dtaHorProx := fObtemDataHoraFrequenciaMensal(dtaUlt, hraUlt,
                                                                    objRecorrenciaParam.Frequencia[intCnt].FIntFrequencia);

                     End;
          tpAnual  : Begin
                       dtaHorProx := fObtemDataHoraFrequenciaAnual(dtaHorUlt,
                                                                   objRecorrenciaParam.Frequencia[intCnt].FIntFrequencia);
                     End;
        End;
      End;
    End;

  Finally
    Result := dtaHorProx;
  End;
end;

function TProcessarRecorrencia.fRetornaDataInclusao(
  aTipPro: TTipoProcessamento = tpFrequencia): TDateTime;
begin
  If aTipPro = tpTotal Then
  Begin
    Result := FDataAgeProximaOcorrencia;
  End
  Else
    Result := VS_Date;
end;

function TProcessarRecorrencia.fRetornaHoraInclusao(
  aTipPro: TTipoProcessamento = tpFrequencia): TDateTime;
begin
  If aTipPro = tpTotal Then
  Begin
    Result := FHoraAgeProximaOcorrencia;
  End
  Else
    Result := fNow();
end;

function TProcessarRecorrencia.getBlnTst: Boolean;
begin
  Result := FblnEmTeste;
end;

function TProcessarRecorrencia.getDUltPro: TDateTime;
begin
  Result := FDataUltimoProcessamento;
end;

function TProcessarRecorrencia.getHUltPro: TDateTime;
begin
  Result := FHoraUltimoProcessamento;
end;

function TProcessarRecorrencia.GetMsgRet: String;
begin
  Result := FMensagemRetorno;
end;

function TProcessarRecorrencia.GetTipPro: TTipoProcessamento;
begin
  Result := FTipPro;
end;

procedure TProcessarRecorrencia.pCalcularDataProximoAgendamento(
  const strAutInc: String);
var
  dataHoraProxAgendamento: TDateTime;
  dataHoraProxProcessamento: TDateTime;
begin
  FIncluirOcorrencia := True;
  FEncerrarRecorrencia := False;

  pCarregarDataUltimoProcessamento(strAutInc);

  dataHoraProxAgendamento := fObtemProximaDataHora(FDataAgeUltimaOcorrencia,
                                                   FHoraAgeUltimaOcorrencia,
                                                   FObjRecorrencia);

  dataHoraProxProcessamento := fObtemProximaDataHora(FDataUltimoProcessamento,
                                                     FHoraUltimoProcessamento,
                                                     FObjRecorrencia);

  dataHoraProxProcessamento := IIF(dataHoraProxProcessamento <= 0, fNow(), dataHoraProxProcessamento);


  If FblnEmTeste Then
  Begin
    FIncluirOcorrencia := True;
  End
  Else
  Begin
    If (FObjRecorrencia.Status = tpTodas) Then
    Begin
      FIncluirOcorrencia := (dataHoraProxAgendamento >= dataHoraProxProcessamento) And
                            (dataHoraProxProcessamento >= ((FDataProIni + FHoraProIni)));
    End
    Else
      FIncluirOcorrencia := (fNow() >= dataHoraProxProcessamento ) And
                            (dataHoraProxAgendamento >= dataHoraProxProcessamento) And
                            (dataHoraProxProcessamento >= ((FDataProIni + FHoraProIni)));
  End;

  If Not FIncluirOcorrencia Then
    Exit;

  FDataAgeProximaOcorrencia := StrToDateTime(FormatDateTime('dd/mm/yyyy', dataHoraProxAgendamento));
  FHoraAgeProximaOcorrencia := StrToDateTime(FormatDateTime('hh:mm', dataHoraProxAgendamento));

  If (FObjRecorrencia.IntervaloRecorrencia = tpData) Then
  Begin
    FIncluirOcorrencia := (FDataAgeProximaOcorrencia <= FObjRecorrencia.DataParaTermino);
    FEncerrarRecorrencia := (FDataAgeProximaOcorrencia >= FObjRecorrencia.DataParaTermino);
  End
  Else If (FObjRecorrencia.IntervaloRecorrencia = tpApos) Then
  Begin
    FEncerrarRecorrencia := ((FNroOcorrenciasProcessadas +1) > FObjRecorrencia.NumeroOcorrenciaParaTermino);
    FIncluirOcorrencia   := ((FNroOcorrenciasProcessadas +1) <= FObjRecorrencia.NumeroOcorrenciaParaTermino);
  End;

end;

procedure TProcessarRecorrencia.pCarregarDataUltimoProcessamento(const strAutInc: String);
var
  qryConsulta: TUniQuery;
begin
  FNroOcorrenciasProcessadas := 0;
  FDataAgeUltimaOcorrencia := 0;
  FHoraAgeUltimaOcorrencia := 0;
  FDataUltimoProcessamento := 0;
  FHoraUltimoProcessamento := 0;

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add('  SELECT R.*,                                        ');
    qryConsulta.SQL.Add('         P.*,                                        ');
    qryConsulta.SQL.Add('         O.OCO_DTAAGE,                               ');
    qryConsulta.SQL.Add('         O.OCO_HORAGE,                               ');
    qryConsulta.SQL.Add('         M.OCO_DTAAGE AS DTAAGE_INI,                 ');
    qryConsulta.SQL.Add('         M.OCO_HORAGE AS HORAGE_INI                  ');
    qryConsulta.SQL.Add('  FROM OCOREC R                                      ');
    qryConsulta.SQL.Add('  LEFT JOIN PROREC P ON PRO_SEQREC = R.AUTOINCREM    ');
    qryConsulta.SQL.Add('  LEFT JOIN MOVOCO O ON P.PRO_SEQMOV = O.AUTOINCREM  ');
    qryConsulta.SQL.Add('  INNER JOIN MOVOCO M ON R.REC_SEQOCO = M.AUTOINCREM ');
    qryConsulta.SQL.Add('  WHERE R.AUTOINCREM = :AUTOINCREM                   ');
    qryConsulta.SQL.Add('  ORDER BY P.PRO_DTAPRO, P.PRO_HRAPRO                ');
    qryConsulta.ParamByName('AUTOINCREM').AsString := strAutInc;

    qryConsulta.Open;
    While Not qryConsulta.EOF Do
    Begin

      FDataProIni := qryConsulta.FieldByName('REC_DTAINI').AsDateTime;
      FHoraProIni := qryConsulta.FieldByName('REC_HRAINI').AsDateTime;
      FStatus     := qryConsulta.FieldByName('PRO_STATUS').AsString;

      If (qryConsulta.FieldByName('PRO_DTAPRO').AsDateTime > 0) and ((qryConsulta.FieldByName('PRO_STATUS').AsString = 'A') Or (qryConsulta.FieldByName('PRO_STATUS').AsString = 'T')) Then
      Begin
        FDataAgeUltimaOcorrencia := qryConsulta.FieldByName('OCO_DTAAGE').AsDateTime;
        FHoraAgeUltimaOcorrencia := qryConsulta.FieldByName('OCO_HORAGE').AsDateTime;
        FDataUltimoProcessamento := qryConsulta.FieldByName('PRO_DTAPRO').AsDateTime;
        FHoraUltimoProcessamento := qryConsulta.FieldByName('PRO_HRAPRO').AsDateTime;
      End
      Else
      Begin
        FDataAgeUltimaOcorrencia := qryConsulta.FieldByName('DTAAGE_INI').AsDateTime;
        FHoraAgeUltimaOcorrencia := qryConsulta.FieldByName('HORAGE_INI').AsDateTime;
        FDataUltimoProcessamento := FDataAgeUltimaOcorrencia;
        FHoraUltimoProcessamento := FHoraAgeUltimaOcorrencia;
      End;

      Inc(FNroOcorrenciasProcessadas);

      qryConsulta.Next;
    End;

  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

procedure TProcessarRecorrencia.pCarregarRecorrenciaInt(
  strAutInc: String);
begin
  FObjRecorrencia.pCarregarRecorrencia(strAutInc);
end;

procedure TProcessarRecorrencia.pGravarProcessamento(const strSeqOco, strSeqRec: String);
var
  strInsert: String;
  qryInsert: TUniQuery;
begin
  strInsert := 'INSERT INTO PROREC(AUTOINCREM, PRO_SEQREC, PRO_DTAPRO, PRO_HRAPRO, PRO_SEQMOV, PRO_TIPPRO, PRO_DTAINC, PRO_HRAINC)' +
               '   VALUES(:AUTOINCREM, :PRO_SEQREC, :PRO_DTAPRO, :PRO_HRAPRO, :PRO_SEQMOV, :PRO_TIPPRO, :PRO_DTAINC, :PRO_HRAINC)';

  FAutInc := fRetAutoIncrem('PROREC', VS_strCodEmp);

  If FTipPro = tpTotal Then
  Begin
    FDtaPro := FDataAgeProximaOcorrencia;
    FHraPro := FHoraAgeProximaOcorrencia;
  End
  Else
  Begin
    FDtaPro := VS_Date;
    FHraPro := fNow();
  End;

  qryInsert := fCriaQuery;
  Try
    qryInsert.DisableControls;
    qryInsert.SQL.Add(strInsert);
    qryInsert.ParamByName('AUTOINCREM').AsString := FAutInc;
    qryInsert.ParamByName('PRO_SEQMOV').AsString := strSeqOco;
    qryInsert.ParamByName('PRO_SEQREC').AsString := strSeqRec;
    qryInsert.ParamByName('PRO_DTAPRO').AsDateTime := FDtaPro;
    qryInsert.ParamByName('PRO_HRAPRO').AsDateTime := FHraPro;
    qryInsert.ParamByName('PRO_TIPPRO').AsString := fTipProToStr(FTipPro);
    qryInsert.ParamByName('PRO_DTAINC').AsDateTime := VS_Date;
    qryInsert.ParamByName('PRO_HRAINC').AsDateTime := fNow();

    qryInsert.ExecSQL;
  Finally
    qryInsert.Close;
    FreeAndNil(qryInsert);
  End;
end;

procedure TProcessarRecorrencia.pInativaProcessamento(const strSeqRec: String);
var
  qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.DisableControls;
    qryUpdate.SQL.Add('UPDATE PROREC SET PRO_STATUS  = "F" ');
    qryUpdate.SQL.Add('WHERE PRO_SEQREC = :PRO_SEQREC');
    qryUpdate.ParamByName('PRO_SEQREC').AsString := strSeqRec;
    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure TProcessarRecorrencia.pProcessarRecorrencias(const aTipPro: TTipoProcessamento = tpFrequencia;
  const strAutIncRec: String = '');
var
  blnInTransaction: Boolean;
begin
  blnInTransaction := False;
  Try
    FTipPro := aTipPro;

    blnInTransaction := fInTransaction;

    If Not blnInTransaction Then
      fStartTransaction;

    Case aTipPro Of
      tpTotal      : Begin
                       FObjRecorrencia.pCarregarRecorrencia(strAutIncRec);
                       pProcessarRecorrenciaTotal;
                     End;
      tpFrequencia : pProcessarRecorrenciaPorFrequencia;
    End;

    If Not blnInTransaction Then
      fCommit;

  Except
    If Not blnInTransaction Then
      fRollBack;
  End;
end;

procedure TProcessarRecorrencia.pProcessarRecorrenciaPorFrequencia;
Begin
  pProcessarRecorrenciaInterna(tpFrequencia);
End;

procedure TProcessarRecorrencia.pProcessarRecorrenciaTotal;
var
  strAutIncAux: String;
begin
  If Not Assigned(FObjRecorrencia) Then
  Begin
    FMensagemRetorno := 'Verifique se foi carregada a Recorrência Cadastrada para realizar o processamento total.';
    Exit;
  End;

  strAutIncAux := FObjRecorrencia.AutInc;
  FObjRecorrencia.pCarregarRecorrencia(strAutIncAux);
  FObjRecorrencia.blnEnviarEmailCliente := False;
  FObjRecorrencia.blnEnviarEmailUsuario := False;
  FObjRecorrencia.Status := tpTodas;
  Repeat
    pProcessarRecorrenciaInterna(tpTotal, strAutIncAux);
  Until (FblnRecorrenciaEncerrada = True) Or (Not fEmptyStr(FMensagemRetorno));
End;

procedure TProcessarRecorrencia.SetBlnRecEnc(const Value: Boolean);
begin
  FblnRecorrenciaEncerrada := Value;
end;

procedure TProcessarRecorrencia.pProcessarRecorrenciaInterna(const aTipPro: TTipoProcessamento = tpFrequencia;
  strAutIncRec: String = '');
var
  qryConsulta: TUniQuery;
  objOcoCrm: IOcorrenciaCRM;
  statusRecPro: TStatusRecorrencia;
begin
  FMensagemRetorno := EmptyStr;

  qryConsulta := fCriaQuery;
  Try
    Try
      Case aTipPro Of
        tpTotal : statusRecPro := tpTodas;
        Else
          statusRecPro := tpFechada;
      End;

      qryConsulta.DisableControls;
      qryConsulta.SQL.Add('SELECT R.*,            ');
      qryConsulta.SQL.Add('       O.*,            ');
      qryConsulta.SQL.Add('       T.TOC_CODGOC    ');
      qryConsulta.SQL.Add('FROM OCOREC R          ');
      qryConsulta.SQL.Add('  INNER JOIN MOVOCO O ON REC_SEQOCO = O.AUTOINCREM');
      qryConsulta.SQL.Add('  INNER JOIN CADTOC T ON O.OCO_CODTOC = T.TOC_CODTOC');
      qryConsulta.SQL.Add('WHERE O.OCO_OCOREC = "S"');

      If aTipPro = tpTotal Then
      Begin
        qryConsulta.SQL.Add('  AND R.AUTOINCREM = :AUTOINCREM');
        qryConsulta.ParamByName('AUTOINCREM').AsString := strAutIncRec;
      End
      Else If aTipPro = tpFrequencia Then
      Begin
        qryConsulta.SQL.Add('  AND R.REC_STATUS = :REC_STATUS');
        qryConsulta.ParamByName('REC_STATUS').AsString := 'A';
      End;

      qryConsulta.Open;

      If Not qryConsulta.isEmpty Then
      Begin
        While Not qryConsulta.EOF Do
        Begin
          If aTipPro = tpFrequencia Then
            pCarregarRecorrenciaInt(qryConsulta.FieldByName('AUTOINCREM').AsString);

          pCalcularDataProximoAgendamento(qryConsulta.FieldByName('AUTOINCREM').AsString);

          FDtaInc := fRetornaDataInclusao(aTipPro);
          FHraInc := fRetornaHoraInclusao(aTipPro);

          If FIncluirOcorrencia Then
          Begin
            FblnRecorrenciaEncerrada := False;
            objOcoCrm := TAtuOcoCrmRecorrente.fNew()
                            .CodEmp(qryConsulta.FieldByName('OCO_CODEMP').AsString)
                            .CodToc(qryConsulta.FieldByName('OCO_CODTOC').AsString)
                            .CodCli(qryConsulta.FieldByName('OCO_CODCLI').AsString)
                            .OpeOco(qryConsulta.FieldByName('OCO_OPEOCO').AsString)
                            .CodOpe(qryConsulta.FieldByName('OCO_CODOPE').AsString)
                            .Descri(qryConsulta.FieldByName('OCO_DESCRI').AsString)
                            .CodCoc(qryConsulta.FieldByName('OCO_CODCOC').AsString)
                            .Tip_FC(qryConsulta.FieldByName('OCO_TIP_FC').AsString)
                            .EspDoc(qryConsulta.FieldByName('OCO_ESPDOC').AsString)
                            .NumDoc(qryConsulta.FieldByName('OCO_NUMDOC').AsString)
                            .CodSit(qryConsulta.FieldByName('OCO_CODSIT').AsString)
                            .DtaAge(FDataAgeProximaOcorrencia)
                            .HraAge(FHoraAgeProximaOcorrencia)
                            .CodAca(qryConsulta.FieldByName('OCO_CODACA').AsString)
                            .SeqLag(qryConsulta.FieldByName('OCO_SEQLAG').AsString)
                            .strCpf(qryConsulta.FieldByName('OCO_C_P_F_').AsString)
                            .Parcel(qryConsulta.FieldByName('OCO_PARCEL').AsString)
                            .blnEnvCli(FObjRecorrencia.blnEnviarEmailCliente)
                            .blnEnvUsu(FObjRecorrencia.blnEnviarEmailUsuario)
                            .MailCli(qryConsulta.FieldByName('REC_EMACLI').AsString)
                            .MailUsu(qryConsulta.FieldByName('REC_EMAUSU').AsString)
                            .CodGoc(qryConsulta.FieldByName('TOC_CODGOC').AsString)
                            .DtaInc(FDtaInc)
                            .HraInc(FHraInc)
                            .NomFrm('TProcessarRecorrencia');

            objOcoCrm.pInserirOcorrenciaRecorrente();

            pGravarProcessamento(objOcoCrm.AutInc,
                                 qryConsulta.FieldByName('AUTOINCREM').AsString);
          End;

          If FEncerrarRecorrencia Then
          Begin
            FObjRecorrencia.pAtualizarRecorrenciaOcorrencia(qryConsulta.FieldByName('REC_SEQOCO').AsString, False, statusRecPro);
            FblnRecorrenciaEncerrada := True;
          End;

          qryConsulta.Next;
        End;

      End
      Else
        FblnRecorrenciaEncerrada := True;

    Except
      On E: Exception Do
      Begin
        FblnRecorrenciaEncerrada := True;
        FMensagemRetorno := 'Erro ao processar ocorrências recorrentes: ' +E.Message;
        raise;
      End;
    End;

  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

class function TProcessarRecorrencia.fStrToTipPro(
  const strTipPro: String): TTipoProcessamento;
begin
  Case AnsiIndexStr(UpperCase(strTipPro), arrTipoProcessamento) Of
    1 : Result := tpTotal;
    Else
      Result := tpFrequencia;
  End;
end;

class function TProcessarRecorrencia.fTipProToStr(
  const aTipPro: TTipoProcessamento): String;
begin
  Result := arrTipoProcessamento[aTipPro];
end;

function TProcessarRecorrencia.GetBlnRecEnc: Boolean;
begin
  Result := FblnRecorrenciaEncerrada;
end;

procedure TProcessarRecorrencia.setBlnTst(const Value: Boolean);
begin
  FblnEmTeste := Value;
end;

procedure TProcessarRecorrencia.SetTipPro(const Value: TTipoProcessamento);
begin
  FTipPro := Value;
end;

end.
