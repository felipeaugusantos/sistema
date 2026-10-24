unit untDadosEnviaGatilhoEmail;

interface

uses
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
    Shared.Core,
  {$ELSE}
   untFuncoesSimples,
  {$ENDIF}
    untTypesSistema, Uni, untTEnvioEmail, System.StrUtils, System.SysUtils, REST.Json, Data.DB;

type
  TDadosProvedor = class
  private
    FTipoProvedorEnvio: String;
  public
    property tipoProvedorEnvio: String Read FTipoProvedorEnvio write FTipoProvedorEnvio;
  end;

  TDadosChavesPrimarias = class
  private
    FAutIncNotfic: String;
  public
    property autIncNotfic: String Read FAutIncNotfic write FAutIncNotfic;
  end;

  TDadosOperador = class
  private
    FCodigoOperador: String;
    FNomeOperador: String;
  public
    property codigoOperador: String Read FCodigoOperador write FCodigoOperador;
    property nomeOperador: String Read FNomeOperador write FNomeOperador;
  end;

  TDadosCliente = class
  private
    FCodigoCliente: String;
  public
    property codigoCliente: String Read FCodigoCliente write FCodigoCliente;
  end;

  TDadosImagemCorpo = class
  private
    FImagemCorpoPath: String;
    FImagemCorpoBase64: String;
  public
    property imagemCorpoPath: String Read FImagemCorpoPath write FImagemCorpoPath;
    property imagemCorpoBase64: String Read FImagemCorpoBase64 write FImagemCorpoBase64;

    class function fNew: TDadosImagemCorpo;
    function fPath(const AValue: String): TDadosImagemCorpo;
    function fBase64(const AValue: String): TDadosImagemCorpo;
  end;

  TDadosEmail = class
  private
    FCopiaOculta: TStringArray;
    FImagemCorpo: TArray<TDadosImagemCorpo>;
    FEnvioAutomaticoCobranca: Boolean;
    FArrDuplicatas: TArrDupTabelaEmail;
    FGravarAnexos: Boolean;
  public
    property copiaOculta: TStringArray Read FCopiaOculta write FCopiaOculta;
    property imagemCorpo: TArray<TDadosImagemCorpo> Read FImagemCorpo write FImagemCorpo;
    property envioAutomaticoCobranca: Boolean Read FEnvioAutomaticoCobranca write FEnvioAutomaticoCobranca;
    property duplicatas: TArrDupTabelaEmail Read FArrDuplicatas write FArrDuplicatas;
    property gravarAnexos: Boolean Read FGravarAnexos write FGravarAnexos;

    destructor Destroy; override;

    procedure pAddImagemCorpo(ADadosImagemCorpo: TDadosImagemCorpo);
  end;

  TDadosGatilho = class
  private
    FCodigoGrupo: String;
    FCodigoGatilho: String;
    FNumeroDocumento: String;
    FEspecieDocumento: String;
    FOpcDocumento: String;
    FEmpresaDocumento: String;
  public
    property codigoGrupo: String Read FCodigoGrupo write FCodigoGrupo;
    property codigoGatilho: String Read FCodigoGatilho write FCodigoGatilho;
    property numeroDocumento: String Read FNumeroDocumento write FNumeroDocumento;
    property especieDocumento: String Read FEspecieDocumento write FEspecieDocumento;
    property opcDocumento: String Read FOpcDocumento write FOpcDocumento;
    property empresaDocumento: String Read FEmpresaDocumento write FEmpresaDocumento;
  end;

  TDadosEnviaGatilhoEmail = class
  private
    FType: String;
    FProvedor: TDadosProvedor;
    FChavesPrimarias: TDadosChavesPrimarias;
    FDadosOperador: TDadosOperador;
    FDadosCliente: TDadosCliente;
    FDadosEmail: TDadosEmail;
    FDadosGatilho: TDadosGatilho;
  public
    property &type: String Read FType write FType;

    property provedor: TDadosProvedor read FProvedor write FProvedor;
    property chavesPrimarias: TDadosChavesPrimarias read FChavesPrimarias write FChavesPrimarias;
    property operador: TDadosOperador read FDadosOperador write FDadosOperador;
    property cliente: TDadosCliente read FDadosCliente write FDadosCliente;
    property email: TDadosEmail read FDadosEmail write FDadosEmail;
    property gatilho: TDadosGatilho read FDadosGatilho write FDadosGatilho;

    constructor Create;
    destructor Destroy; override;

    function ToJsonString: String;
    class function FromJsonString(AJsonString: string): TDadosEnviaGatilhoEmail;

    function fRetornaDadosLoginEmail: TDadosLoginEmail;
  end;

  const
    STRING_QUEBRA = '<<csq>>';
    STRING_ENTER = #13#10;

implementation

{TDadosEnviaGatilhoEmail}

function TDadosEnviaGatilhoEmail.ToJsonString: String;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

destructor TDadosEnviaGatilhoEmail.Destroy;
begin
  FProvedor.Free;
  FChavesPrimarias.Free;
  FDadosOperador.Free;
  FDadosCliente.Free;
  FDadosEmail.Free;
  FDadosGatilho.Free;

  inherited;
end;

class function TDadosEnviaGatilhoEmail.FromJsonString(AJsonString: string): TDadosEnviaGatilhoEmail;
begin
  Result := TJson.JsonToObject<TDadosEnviaGatilhoEmail>(AJsonString);
end;

function fCarregaDadosConexaoFixa(const ACodigoGrupo, ACodigoGatilho: String): TDadosLoginEmail;
Var
  strSQL   : String;
  qryEmaSai: TUniQuery;
begin
  qryEmaSai := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  CFG_SENEMA,  ';
    strSQL := strSQL + '  CFG_EMAIL_,  ';
    strSQL := strSQL + '  CFG_EMALOG,  ';
    strSQL := strSQL + '  CFG_REMETE,  ';
    strSQL := strSQL + '  CFG_ASSB64,  ';
    strSQL := strSQL + '  CFG_ASSTXT,  ';
    strSQL := strSQL + '  PRV_CODPRV,  ';
    strSQL := strSQL + '  PRV_PORPRV,  ';
    strSQL := strSQL + '  PRV_URSMTP,  ';
    strSQL := strSQL + '  PRV_PTIMAP,  ';
    strSQL := strSQL + '  PRV_URIMAP,  ';
    strSQL := strSQL + '  PRV_LIMARQ,  ';
    strSQL := strSQL + '  PRV_SSLSAI,  ';
    strSQL := strSQL + '  PRV_SSLENT,  ';
    strSQL := strSQL + '  PRV_GRVENV   ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  EMASAI ';
    strSQL := strSQL + '  INNER JOIN CFGEMA ON CFG_SEQGER = EMASAI.AUTOINCREM ';
    strSQL := strSQL + '  INNER JOIN CADPRV ON PRV_CODPRV = CFG_CODPRV        ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  EMA_CODIGO = :CODIGO AND ';
    strSQL := strSQL + '  EMA_CODGRU = :CODGRU AND ';
    strSQL := strSQL + '  EMA_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  EMA_ENTSAI = "S"         ';

    qryEmaSai.SQL.Text := strSQL;
    qryEmaSai.ParamByName('CODIGO').AsString := ACodigoGatilho;
    qryEmaSai.ParamByName('CODGRU').AsString := ACodigoGrupo;
    qryEmaSai.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryEmaSai.Open;

    If qryEmaSai.IsEmpty Then
      Exit;

    Result.Senha := CriptografarSenhaEmail(qryEmaSai.FieldByName('CFG_SENEMA').AsString);
    Result.Email := qryEmaSai.FieldByName('CFG_EMAIL_').AsString;
    Result.Login := qryEmaSai.FieldByName('CFG_EMALOG').AsString;
    Result.Remetente := qryEmaSai.FieldByName('CFG_REMETE').AsString;

    Result.Provedor := qryEmaSai.FieldByName('PRV_CODPRV').AsInteger;
    Result.PortaSMTP := qryEmaSai.FieldByName('PRV_PORPRV').AsInteger;
    Result.ServidorSMTP := qryEmaSai.FieldByName('PRV_URSMTP').AsString;
    Result.PortaImap := qryEmaSai.FieldByName('PRV_PTIMAP').AsInteger;
    Result.ServidorImap := qryEmaSai.FieldByName('PRV_URIMAP').AsString;
    Result.LimiteArquivos := qryEmaSai.FieldByName('PRV_LIMARQ').AsInteger;
    Result.GravaPastaEnviados := (qryEmaSai.FieldByName('PRV_GRVENV').AsString);
    Result.AutenticacaoSSL := (qryEmaSai.FieldByName('PRV_SSLSAI').AsString = 'S');
    Result.AutenticacaoSSLImap := (qryEmaSai.FieldByName('PRV_SSLENT').AsString = 'S');

    Result.TextoAssinatura := AnsiReplaceStr(qryEmaSai.FieldByName('CFG_ASSTXT').AsString, STRING_QUEBRA, STRING_ENTER);
    Result.ImagemAssinaturaBase64 := qryEmaSai.FieldByName('CFG_ASSB64').AsString;
  Finally
    FreeAndNil(qryEmaSai);
  End;
end;

function fCarregaDadosConexaoEmpresa(const ACodigoOperador: String): TDadosLoginEmail;
var
  qryDados: TUniQuery;
begin
  qryDados := fCriaQuery(Nil);
  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Text := ' SELECT * FROM                        '+
                         '   OPEEML                             '+
                         ' INNER JOIN                           '+
                         '   CADPRV ON PRV_CODPRV = EML_CODPRV  '+
                         ' WHERE EML_CODOPE = :CODOPE           '+
                         '   AND EML_CODEMP = :CODEMP           ';

    qryDados.ParamByName('CODOPE').AsString := ACodigoOperador;
    qryDados.ParamByName('CODEMP').AsString := Vs_strCodEmp;
    qryDados.Open;

    If (qryDados.IsEmpty) Then
      Exit;

    Result.Senha := CriptografarSenhaEmail(qryDados.FieldByName('EML_PRVSEN').AsString);
    Result.Email := qryDados.FieldByName('EML_E_MAIL').AsString;
    Result.Login := qryDados.FieldByName('EML_EMALOG').AsString;

    Result.Provedor := qryDados.FieldByName('PRV_CODPRV').AsInteger;
    Result.PortaSMTP := qryDados.FieldByName('PRV_PORPRV').AsInteger;
    Result.ServidorSMTP := qryDados.FieldByName('PRV_URSMTP').AsString;
    Result.PortaImap := qryDados.FieldByName('PRV_PTIMAP').AsInteger;
    Result.ServidorImap := qryDados.FieldByName('PRV_URIMAP').AsString;
    Result.LimiteArquivos := qryDados.FieldByName('PRV_LIMARQ').AsInteger;
    Result.GravaPastaEnviados := (qryDados.FieldByName('PRV_GRVENV').AsString);
    Result.AutenticacaoSSL := (qryDados.FieldByName('PRV_SSLSAI').AsString = 'S');
    Result.AutenticacaoSSLImap := (qryDados.FieldByName('PRV_SSLENT').AsString = 'S');

    If (Not fEmptyStr(qryDados.FieldByName('EML_IMGB64').AsString)) Then
    Begin
      Result.TextoAssinatura := (AnsiReplaceStr(qryDados.FieldByName('EML_TEXTO_').AsString, STRING_QUEBRA, STRING_ENTER));
      Result.ImagemAssinaturaBase64 := qryDados.FieldByName('EML_IMGB64').AsString;
    End;

  Finally
    FreeAndNil(qryDados);
  End;
end;

function fCarregaDadosConexaoOperador(const ACodigoOperador: String): TDadosLoginEmail;
var
  qryCadOpe: TUniQuery;
begin
  qryCadOpe := fCriaQuery(Nil);
  Try
    qryCadOpe.SQL.Text := ' SELECT   '+
                          '  *      '+
                          ' FROM     '+
                          '   CADOPE '+
                          '   INNER JOIN CADPRV ON PRV_CODPRV = OPE_CODPRV '+
                          '   LEFT  JOIN OPEASS ON ASS_CODOPE = OPE_CODOPE '+
                          ' WHERE    '+
                          '   OPE_CODOPE = :CODOPE ';

    qryCadOpe.ParamByName('CODOPE').AsString := ACodigoOperador;
    qryCadOpe.Open;

    If qryCadOpe.IsEmpty Then
      Exit;

    Result.Senha := CriptografarSenhaEmail(qryCadOpe.FieldByName('OPE_PRVSEN').AsString);
    Result.Email := qryCadOpe.FieldByName('OPE_E_MAIL').AsString;
    Result.Login := qryCadOpe.FieldByName('OPE_EMALOG').AsString;
    Result.Remetente := qryCadOpe.FieldByName('OPE_E_NOME').AsString;

    Result.Provedor := qryCadOpe.FieldByName('PRV_CODPRV').AsInteger;
    Result.PortaSMTP := qryCadOpe.FieldByName('PRV_PORPRV').AsInteger;
    Result.ServidorSMTP := qryCadOpe.FieldByName('PRV_URSMTP').AsString;
    Result.PortaImap := qryCadOpe.FieldByName('PRV_PTIMAP').AsInteger;
    Result.ServidorImap := qryCadOpe.FieldByName('PRV_URIMAP').AsString;
    Result.LimiteArquivos := qryCadOpe.FieldByName('PRV_LIMARQ').AsInteger;
    Result.GravaPastaEnviados := (qryCadOpe.FieldByName('PRV_GRVENV').AsString);
    Result.AutenticacaoSSL := (qryCadOpe.FieldByName('PRV_SSLSAI').AsString = 'S');
    Result.AutenticacaoSSLImap := (qryCadOpe.FieldByName('PRV_SSLENT').AsString = 'S');

    If (Not fEmptyStr(qryCadOpe.FieldByName('ASS_CODOPE').AsString)) Then
    Begin
      Result.TextoAssinatura := (AnsiReplaceStr(qryCadOpe.FieldByName('ASS_TEXTO_').AsString, STRING_QUEBRA, STRING_ENTER));
      Result.ImagemAssinaturaBase64 := qryCadOpe.FieldByName('ASS_IMGB64').AsString;
    End;
  Finally
    FreeAndNil(qryCadOpe);
  End;
end;

function fCarregaDadosConexao(const ATipoProvedorEnvio, ACodigoOperador, ACodigoGrupo, ACodigoGatilho: String): TDadosLoginEmail;
begin
  If (ATipoProvedorEnvio = 'F') Then
    Result := fCarregaDadosConexaoFixa(ACodigoGrupo, ACodigoGatilho)
  Else
  Begin
    If (fCfgSis('EMLEMP', varBoolean)) Then
      Result := fCarregaDadosConexaoEmpresa(ACodigoOperador)
    Else
      Result := fCarregaDadosConexaoOperador(ACodigoOperador);
  End;
end;

function TDadosEnviaGatilhoEmail.fRetornaDadosLoginEmail: TDadosLoginEmail;
begin
  Result := fCarregaDadosConexao(Self.provedor.tipoProvedorEnvio, Self.operador.codigoOperador, Self.gatilho.codigoGrupo, Self.gatilho.codigoGatilho);
end;

constructor TDadosEnviaGatilhoEmail.Create;
const
  FTYPEJSON = 'TDadosEnviaGatilhoEmail';
begin
  FType := FTYPEJSON;

  FProvedor := TDadosProvedor.Create;
  FChavesPrimarias := TDadosChavesPrimarias.Create;
  FDadosOperador := TDadosOperador.Create;
  FDadosCliente := TDadosCliente.Create;
  FDadosEmail := TDadosEmail.Create;
  FDadosGatilho := TDadosGatilho.Create;
end;

{ TDadosEmail }

destructor TDadosEmail.Destroy;
var
  ImagemCorpo: TDadosImagemCorpo;
begin
  for ImagemCorpo in FImagemCorpo do
    ImagemCorpo.Free;

  FImagemCorpo := nil;

  inherited;
end;

procedure TDadosEmail.pAddImagemCorpo(ADadosImagemCorpo: TDadosImagemCorpo);
begin
  SetLength(FImagemCorpo, Length(FImagemCorpo)+1);
  FImagemCorpo[High(FImagemCorpo)] := ADadosImagemCorpo;
end;

{ TDadosImagemCorpo }

class function TDadosImagemCorpo.fNew: TDadosImagemCorpo;
begin
  Result := Self.Create;
end;

function TDadosImagemCorpo.fBase64(const AValue: String): TDadosImagemCorpo;
begin
  FImagemCorpoBase64 := AValue;
  Result := Self;
end;

function TDadosImagemCorpo.fPath(const AValue: String): TDadosImagemCorpo;
begin
  FImagemCorpoPath := AValue;
  Result := Self;
end;

end.
