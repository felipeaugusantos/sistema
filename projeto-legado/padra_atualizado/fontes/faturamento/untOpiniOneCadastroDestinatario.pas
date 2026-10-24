unit untOpiniOneCadastroDestinatario;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type
  TPesquisaOpiniOne = (OpiniFaturamentoRetira, OpiniBaixaRomaneio);

  TDestinatariosClass = class
  private
    FCelular: String;
    FCodigoControle: String;
    FEmail: String;
    FMunicipio: String;
    FNome: String;
    FObjetoAvaliado: String;
    FUf: String;
    FControleAdicional: String;
  public
    property Celular: String read FCelular write FCelular;
    property CodigoControle: String read FCodigoControle write FCodigoControle;
    property Email: String read FEmail write FEmail;
    property Municipio: String read FMunicipio write FMunicipio;
    property Nome: String read FNome write FNome;
    property ObjetoAvaliado: String read FObjetoAvaliado write FObjetoAvaliado;
    property Uf: String read FUf write FUf;
    property ControleAdicional: String read FControleAdicional write FControleAdicional;

    class function fNew: TDestinatariosClass;

    function f_Celular(AValue: String): TDestinatariosClass;
    function f_CodigoControle(AValue: String): TDestinatariosClass;
    function f_Email(AValue: String): TDestinatariosClass;
    function f_Municipio(AValue: String): TDestinatariosClass;
    function f_Nome(AValue: String): TDestinatariosClass;
    function f_ObjetoAvaliado(AValue: String): TDestinatariosClass;
    function f_Uf(AValue: String): TDestinatariosClass;
    function f_ControleAdicional(AValue: String): TDestinatariosClass;

  end;

  TOpiniOneCadastroDestinatario = class
  private
    FDestinatarios: TArray<TDestinatariosClass>;
    FHashPesquisa: String;

    procedure pAddDestinatario(DestinatariosClass: TDestinatariosClass);
  public
    property Destinatarios: TArray<TDestinatariosClass> read FDestinatarios write FDestinatarios;
    property HashPesquisa: String read FHashPesquisa write FHashPesquisa;
    destructor Destroy; override;
    function ToJsonString: string;
  end;

  TCriticasClass = class
  private
    FCampo: String;
    FDescricao: String;
    FTipo: String;
  public
    property Campo: String read FCampo write FCampo;
    property Descricao: String read FDescricao write FDescricao;
    property Tipo: String read FTipo write FTipo;
  end;

  TRegistrosInvalidosClass = class
  private
    FCelular: String;
    FCodigoControle: String;
    FCriticas: TArray<TCriticasClass>;
    FEmail: String;
    FNome: String;
  public
    property Celular: String read FCelular write FCelular;
    property CodigoControle: String read FCodigoControle write FCodigoControle;
    property Criticas: TArray<TCriticasClass> read FCriticas write FCriticas;
    property Email: String read FEmail write FEmail;
    property Nome: String read FNome write FNome;
    destructor Destroy; override;
  end;

  TOpiniOneRetornoCadastroDestinatario = class
  private
    FDataCarga: String;
    FHashCargaDestinatario: String;
    FHashPesquisa: String;
    FQuantidadeRegistrosInvalidos: Extended;
    FQuantidadeRegistrosTotal: Extended;
    FQuantidadeRegistrosValidos: Extended;
    FRegistrosInvalidos: TArray<TRegistrosInvalidosClass>;
  public
    property DataCarga: String read FDataCarga write FDataCarga;
    property HashCargaDestinatario: String read FHashCargaDestinatario write FHashCargaDestinatario;
    property HashPesquisa: String read FHashPesquisa write FHashPesquisa;
    property QuantidadeRegistrosInvalidos: Extended read FQuantidadeRegistrosInvalidos write FQuantidadeRegistrosInvalidos;
    property QuantidadeRegistrosTotal: Extended read FQuantidadeRegistrosTotal write FQuantidadeRegistrosTotal;
    property QuantidadeRegistrosValidos: Extended read FQuantidadeRegistrosValidos write FQuantidadeRegistrosValidos;
    property RegistrosInvalidos: TArray<TRegistrosInvalidosClass> read FRegistrosInvalidos write FRegistrosInvalidos;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TOpiniOneRetornoCadastroDestinatario;
  end;

  TControllerOpiniOneCadastroDestinatario = class
  private
    class function fRetHashPesquisa(pesquisa: TPesquisaOpiniOne): String;

    class function fPesquisaVigente(strHashPesquisa: String): Boolean;

    class function fCadastraDestinatario(OpiniOneCadastroDestinatario: TOpiniOneCadastroDestinatario): TOpiniOneRetornoCadastroDestinatario;
  public
    class procedure pGravaNotificacaoPesquisa(strSeqGer, strCodCli: String; blnEntrega: Boolean);
    class function fEnviaPesquisaOpiniOne(strCodCli, strNumDoc, strEspDoc, strEmpDoc, strVendedor, strMotorista: String; pesquisa: TPesquisaOpiniOne): Boolean;
  end;

implementation

uses untOpiniOneRestApi, untRestApi, untOpiniOneAutenticacao, untNotificacoes,
  untOpiniOneListagemDePesquisas;

{ TDestinatariosClass }

class function TDestinatariosClass.fNew: TDestinatariosClass;
begin
  Result := TDestinatariosClass.Create;
end;

function TDestinatariosClass.f_Celular(AValue: String): TDestinatariosClass;
begin
  FCelular := AValue;
  Result := Self;
end;

function TDestinatariosClass.f_CodigoControle(
  AValue: String): TDestinatariosClass;
begin
  FCodigoControle := AValue;
  Result := Self;
end;

function TDestinatariosClass.f_ControleAdicional(
  AValue: String): TDestinatariosClass;
begin
  FControleAdicional := AValue;
  Result := Self;
end;

function TDestinatariosClass.f_Email(AValue: String): TDestinatariosClass;
begin
  FEmail := AnsiReplaceStr(AValue, ';', '');
  Result := Self;
end;

function TDestinatariosClass.f_Municipio(AValue: String): TDestinatariosClass;
begin
  FMunicipio := AValue;
  Result := Self;
end;

function TDestinatariosClass.f_Nome(AValue: String): TDestinatariosClass;
begin
  FNome := AValue;
  Result := Self;
end;

function TDestinatariosClass.f_ObjetoAvaliado(
  AValue: String): TDestinatariosClass;
begin
  FObjetoAvaliado := AValue;
  Result := Self;
end;

function TDestinatariosClass.f_Uf(AValue: String): TDestinatariosClass;
begin
  FUf := AValue;
  Result := Self;
end;

{TOpiniOneCadastroDestinatario}

destructor TOpiniOneCadastroDestinatario.Destroy;
var
  LDestinatariosItem: TDestinatariosClass;
begin

 for LDestinatariosItem in FDestinatarios do
   LDestinatariosItem.free;

  inherited;
end;

function TOpiniOneCadastroDestinatario.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

procedure TOpiniOneCadastroDestinatario.pAddDestinatario(
  DestinatariosClass: TDestinatariosClass);
begin
  SetLength(FDestinatarios, Length(FDestinatarios)+1);
  FDestinatarios[Length(FDestinatarios)-1] := DestinatariosClass;
end;

{TRegistrosInvalidosClass}

destructor TRegistrosInvalidosClass.Destroy;
var
  LCriticasItem: TCriticasClass;
begin

 for LCriticasItem in FCriticas do
   LCriticasItem.free;

  inherited;
end;

{TOpiniOneRetornoCadastroDestinatario}

destructor TOpiniOneRetornoCadastroDestinatario.Destroy;
var
  LRegistrosInvalidosItem: TRegistrosInvalidosClass;
begin

 for LRegistrosInvalidosItem in FRegistrosInvalidos do
   LRegistrosInvalidosItem.free;

  inherited;
end;

class function TOpiniOneRetornoCadastroDestinatario.FromJsonString(AJsonString: string): TOpiniOneRetornoCadastroDestinatario;
begin
  Result := TJson.JsonToObject<TOpiniOneRetornoCadastroDestinatario>(AJsonString)
end;

class function TControllerOpiniOneCadastroDestinatario.fRetHashPesquisa(pesquisa: TPesquisaOpiniOne): String;
begin
  case pesquisa of
    OpiniFaturamentoRetira:
      Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_OPIRET', VS_strCodEmp], True, '');

    OpiniBaixaRomaneio:
      Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_OPIENT', VS_strCodEmp], True, '');

    else
    Result := EmptyStr;
  end;
end;

class function TControllerOpiniOneCadastroDestinatario.fPesquisaVigente(strHashPesquisa: String): Boolean;
begin
  Result := TControllerOpiniOneListagemDePesquisas.fPesquisaEstaVigente(strHashPesquisa);
end;

class function TControllerOpiniOneCadastroDestinatario.fEnviaPesquisaOpiniOne(strCodCli,
  strNumDoc, strEspDoc, strEmpDoc, strVendedor, strMotorista: String; pesquisa: TPesquisaOpiniOne): Boolean;
const
  CRITICA_CLIENTE_JA_CADASTRADO_NA_PESQUISA = 'O CodigoControle está duplicado na pesquisa';
var
  OpiniOneCadastroDestinatario: TOpiniOneCadastroDestinatario;
  OpiniOneRetornoCadastroDestinatario: TOpiniOneRetornoCadastroDestinatario;

  qryCliente: TUniQuery;
  strHashPesquisa: String;

  blnClienteConsumidor: Boolean;

  strNomCli,
  strEmail,
  strCelula,
  strCodControle,
  strNomCid,
  strEstado: String;
begin
  Result := False;

  strHashPesquisa := fRetHashPesquisa(pesquisa);
  if fEmptyStr(strHashPesquisa) then
    Exit(True);

  if not fPesquisaVigente(strHashPesquisa) then
    Exit(True);

  OpiniOneCadastroDestinatario := TOpiniOneCadastroDestinatario.Create;
  qryCliente := fCriaQuery(nil);
  try
    blnClienteConsumidor := fClienteConsumidor(fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [strCodCli]));

    qryCliente.Close;
    qryCliente.SQL.Text :=
    IIF(not blnClienteConsumidor,
        ' SELECT '+
        '   CLI_NOMCLI AS NOMCLI, '+
        '   CLI_EMAIL_ AS EMAIL_, '+
        '   CLI_EMAIL2 AS EMAIL2, '+
        '   CLI_EMAIL3 AS EMAIL3, '+
        '   CLI_CELULA AS CELULA, '+
        '   CLI_CODCLI AS CODCLI, '+
        '   CID_NOMCID AS NOMCID, '+
        '   CID_ESTADO AS ESTADO  '+
        ' FROM '+
        '   CADCLI '+
        ' LEFT JOIN CADCID '+
        '   ON CLI_CODCID = CADCID.CID_CODCID '+
        ' WHERE '+
        '   CLI_CODCLI = :CODCLI '
        ,
        ' SELECT '+
        '   GER_NOMCON AS NOMCLI, '+
        '   GER_EMLCON AS EMAIL_, '+
        '   ""         AS EMAIL2, '+
        '   ""         AS EMAIL3, '+
        '   AUX_CELCON AS CELULA, '+
        '   "'+FormatDateTime('ddmmyyyyhhmmss', fNow)+'" AS CODCLI, '+
        '   CID_NOMCID AS NOMCID, '+
        '   CID_ESTADO AS ESTADO  '+
        ' FROM '+
        '   MOVGER '+
        ' INNER JOIN AUXMOV '+
        '   ON MOVGER.AUTOINCREM = AUXMOV.AUX_SEQGER '+
        ' LEFT JOIN CADCID '+
        '   ON GER_CIDCON = CADCID.CID_CODCID '+
        ' WHERE '+
        '   GER_NUMDOC = :NUMDOC AND '+
        '   GER_ESPDOC = :ESPDOC AND '+
        '   GER_CODEMP = :CODEMP ');

    if not blnClienteConsumidor then
      qryCliente.ParamByName('CODCLI').AsString := strCodCli
    else
    begin
      qryCliente.ParamByName('NUMDOC').AsString := strNumDoc;
      qryCliente.ParamByName('ESPDOC').AsString := strEspDoc;
      qryCliente.ParamByName('CODEMP').AsString := strEmpDoc;
    end;
    qryCliente.Open;

    strNomCli := qryCliente.FieldByName('NOMCLI').AsString;
    strCelula := qryCliente.FieldByName('CELULA').AsString;
    strEmail  := IIF(not fEmptyStr(qryCliente.FieldByName('EMAIL_').AsString),
                     qryCliente.FieldByName('EMAIL_').AsString,
                     IIF(not fEmptyStr(qryCliente.FieldByName('EMAIL2').AsString),
                         qryCliente.FieldByName('EMAIL2').AsString,
                         qryCliente.FieldByName('EMAIL3').AsString));
    strCodControle := qryCliente.FieldByName('CODCLI').AsString;
    strNomCid := qryCliente.FieldByName('NOMCID').AsString;
    strEstado := qryCliente.FieldByName('ESTADO').AsString;

    OpiniOneCadastroDestinatario.HashPesquisa := strHashPesquisa;
    OpiniOneCadastroDestinatario.pAddDestinatario(TDestinatariosClass.fNew()
                                                    .f_Nome(strNomCli)
                                                    .f_Email(strEmail)
                                                    .f_Celular(strCelula)
                                                    .f_CodigoControle(strCodControle)
                                                    .f_Municipio(strNomCid)
                                                    .f_Uf(strEstado)
                                                    .f_ObjetoAvaliado(strVendedor)
                                                    .f_ControleAdicional(strMotorista));

    OpiniOneRetornoCadastroDestinatario := fCadastraDestinatario(OpiniOneCadastroDestinatario);
    if Assigned(OpiniOneRetornoCadastroDestinatario) then
    begin
      Result := (OpiniOneRetornoCadastroDestinatario.QuantidadeRegistrosInvalidos = 0);
      if (not Result) and
         (UpperCase(OpiniOneRetornoCadastroDestinatario.RegistrosInvalidos[0].Criticas[0].Descricao) = UpperCase(CRITICA_CLIENTE_JA_CADASTRADO_NA_PESQUISA)) then
        Result := True;
    end;
  finally
    if Assigned(OpiniOneRetornoCadastroDestinatario) then
      FreeAndNil(OpiniOneRetornoCadastroDestinatario);

    FreeAndNil(OpiniOneCadastroDestinatario);
    FreeAndNil(qryCliente);
  end;
end;

class procedure TControllerOpiniOneCadastroDestinatario.pGravaNotificacaoPesquisa(strSeqGer, strCodCli: String; blnEntrega: Boolean);
var
  qryNotFic: TUniQuery;
begin
  qryNotFic := fCriaQuery;
  try
    qryNotFic.Close;
    qryNotFic.SQL.Text :=
    ' SELECT '+
    '   COUNT(NOTFIC.AUTOINCREM) AS QTDENV '+
    ' FROM '+
    '   NOTFIC '+
    ' INNER JOIN MOVGER ON '+
    '   NOTFIC.NOT_SEQGER = MOVGER.AUTOINCREM '+
    ' WHERE '+
    '   MOVGER.AUTOINCREM <> :AUTINC AND '+
    '   MOVGER.GER_CODCLI =  :CODCLI AND '+
    '   NOTFIC.NOT_TIPO__ =  :TIPO__ AND '+
    '   NOTFIC.NOT_CODEMP =  :CODEMP AND '+
    '   NOTFIC.NOT_DTAHOR BETWEEN :DTAINI AND :DTAFIN ';

    qryNotFic.ParamByName('AUTINC').AsString   := strSeqGer;
    qryNotFic.ParamByName('CODCLI').AsString   := strCodCli;
    qryNotFic.ParamByName('TIPO__').AsInteger  := NOTIFICACAO_NPS_OPINI_ONE;
    qryNotFic.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    qryNotFic.ParamByName('DTAINI').AsDate     := VS_Date - fCfgSis('DIAENV', varInteger);
    qryNotFic.ParamByName('DTAFIN').AsDateTime := fNow;
    qryNotFic.Open;

    if qryNotFic.FieldByName('QTDENV').AsInteger > 0 then
      Exit;

    qryNotFic.Close;
    qryNotFic.SQL.Text :=
    ' INSERT INTO '+
    ' NOTFIC '+
    '  (AUTOINCREM, '+
    '   NOT_SEQGER, '+
    '   NOT_NOTENV, '+
    '   NOT_DTAHOR, '+
    '   NOT_GATILH, '+
    '   NOT_ENVEMA, '+
    '   NOT_ENVSMS, '+
    '   NOT_ENVWPP, '+
    '   NOT_CODEMP, '+
    '   NOT_TIPO__)  '+
    ' VALUES '+
    '  (:AUTINC, '+
    '   :SEQGER, '+
    '   :NOTENV, '+
    '   :DTAHOR, '+
    '   :GATILH, '+
    '   :ENVEMA, '+
    '   :ENVSMS, '+
    '   :ENVWPP, '+
    '   :CODEMP, '+
    '   :TIPO__)  ';

    qryNotFic.ParamByName('AUTINC').AsString   := fRetAutoIncrem('NOTFIC', VS_StrCodEmp);
    qryNotFic.ParamByName('SEQGER').AsString   := strSeqGer;
    qryNotFic.ParamByName('NOTENV').AsString   := 'N';
    qryNotFic.ParamByName('DTAHOR').AsDateTime := fNow;
    qryNotFic.ParamByName('GATILH').AsString   := IIF(blnEntrega, 'ET', 'RT');
    qryNotFic.ParamByName('ENVEMA').AsString   := 'N';
    qryNotFic.ParamByName('ENVSMS').AsString   := 'N';
    qryNotFic.ParamByName('ENVWPP').AsString   := 'N';
    qryNotFic.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    qryNotFic.ParamByName('TIPO__').AsInteger  := NOTIFICACAO_NPS_OPINI_ONE;
    qryNotFic.ExecSQL;
  finally
    FreeAndNil(qryNotFic);
  end;
end;

class function TControllerOpiniOneCadastroDestinatario.fCadastraDestinatario(OpiniOneCadastroDestinatario: TOpiniOneCadastroDestinatario): TOpiniOneRetornoCadastroDestinatario;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('OPINIONE', TControllerOpiniOne.fConfigurarOpiniOne);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'pesquisas/destinatarios';
    RestRequest.Method := rmPOST;

    RestRequest.Params.AddItem('Token_Autorizacao', TControllerOpiniOneAutenticacao.fRetToken, pkHTTPHEADER);

    RESTRequest
    .Params
    .AddItem(  '',
               OpiniOneCadastroDestinatario.ToJsonString,
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], '') then
      Result := TOpiniOneRetornoCadastroDestinatario.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
