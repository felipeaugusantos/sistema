unit untTEnvioEmailAutenticacaoOAuth2;

interface

Uses System.Classes, System.SysUtils, System.StrUtils, Rest.Json, System.Json,
     blcksock, synautil, ssl_openssl, System.Generics.Collections, Vcl.Forms,
     System.DateUtils, idCoderMIME, idSASL, idSASLUserPass, idSASLLogin,
     EncdDecd, Uni, UniClientDataset, HTTPSend, Rest.Authenticator.OAUTH,
     untTEnvioEmailRestSynalist, Data.DB;

Type
  TTiposProvedorOAuth = (oautNenhum, oautOutlook);

Type
  TPastasImap = Class Abstract
  public
    folderName: String;
  End;

Type
  TDadosToken = class
  public
    CodigoProvedor: Integer;

    Provedor: TTiposProvedorOAuth;

    Token: String;

    Expiracao: Integer;

    DataLimite: TDateTime;
  end;

Type
  TEnvioEmailAutenticacaoOAuth2 = class(TEnvioEmailRestSynalist)
  private
    FEmailFrom,

    FClientID,
    FClientSecret,
    FIDDiretorio,
    FBodyParametros,
    FEmailAzureID: String;

    FDatasetProvedor: TUniClientDataset;

    FProvedor: TTiposProvedorOAuth;

    FParametros: TStringList;

    function RetornaTokenAtivo(AProvedor: TTiposProvedorOAuth): TDadosToken;

    function RetornaTokenObjectJson(AProvedor: TTiposProvedorOAuth;
                                    AJsonRetorno: String): TDadosToken;

    function RetornaTipoDoProvedor: TTiposProvedorOAuth;

    function RetornaTokenGravadoEmpresaFisica: TDadosToken;

    procedure GravarDadosNovoTokenGerado(ADadosToken: TDadosToken);

    function RetornaMetodoToken: String;
    function RetornaUrlToken: String;
  public
    constructor Create(AEmailFrom: String;
                       AProvedor: Integer;
                       AClientID,
                       AClientSecret: String;
                       ATenantID: String = '';
                       AEmailAzureID: String = '');

    destructor Destroy; override;

    function GetToken(ALimparAtual: Boolean = False): String;

    function RetornaIDEmailAzureOutlook(AEmail: String): String;

    procedure CarregaEmailIDAzureDadosModeloOperador(ACodigoGrupoModelo,
                                                     ACodigoModelo,
                                                     ACodigoOperador: String);

    property EmailAzureID: String read FEmailAzureID write FEmailAzureID;
    property EmailFrom: String read FEmailFrom write FEmailFrom;
  end;

Var
  VS_ListaToken: TList<TDadosToken>;

implementation
uses untFuncoesSimples;
{ TEnvioEmailAutenticacaoOAuth2 }

procedure TEnvioEmailAutenticacaoOAuth2.CarregaEmailIDAzureDadosModeloOperador(
  ACodigoGrupoModelo, ACodigoModelo, ACodigoOperador: String);
  Var
    LConsulta: TUniQuery;

    LCarregaOperador: Boolean;
begin
  If Not FEmailAzureID.IsEmpty Then
    Exit;

  LCarregaOperador := ACodigoGrupoModelo.IsEmpty;
  If Not LCarregaOperador Then
    LCarregaOperador := fCampoTabela('EMA_PROENV',
                                     'EMASAI',
                                     ['EMA_CODGRU', 'EMA_CODIGO', 'EMA_CODEMP'],
                                     [ACodigoGrupoModelo, ACodigoModelo, VS_strCodEmp]) <> 'F';

  If LCarregaOperador Then
  Begin
    FEmailAzureID := fCampoTabela('OPE_EMA_ID', 'CADOPE', ['OPE_CODOPE'], [ACodigoOperador]);

    Exit;
  End;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT C.CFG_EMA_ID ' +
                          'FROM EMASAI E ' +
                          'JOIN CFGEMA C ON C.CFG_SEQGER=E.AUTOINCREM ' +
                          'WHERE E.EMA_CODGRU=:CODGRU ' +
                          '  AND E.EMA_CODIGO=:CODIGO ' +
                          '  AND E.EMA_CODEMP=:CODEMP';

    LConsulta.ParamByName('CODGRU').AsString := ACodigoGrupoModelo;
    LConsulta.ParamByName('CODIGO').AsString := ACodigoModelo;
    LConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;

    LConsulta.Open;

    FEmailAzureId := LConsulta.FieldByName('CFG_EMA_ID').AsString;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

constructor TEnvioEmailAutenticacaoOAuth2.Create(AEmailFrom: String;
  AProvedor: Integer; AClientID, AClientSecret: String; ATenantID: String = '';
  AEmailAzureID: String = '');
begin
  FDatasetProvedor := fCriaClientDataset('SELECT * FROM CADPRV WHERE PRV_CODPRV=' + AProvedor.ToString);
  FDatasetProvedor.Open;

  FProvedor := RetornaTipoDoProvedor;

  If FProvedor = oautNenhum Then
    Raise Exception.Create('Nenhum provedor com autenticação OAuth2 foi selecionado.');

  FEmailFrom := AEmailFrom;
  FIDDiretorio := ATenantId;
  FClientId := AClientID;
  FClientSecret := AClientSecret;
  FEmailAzureID := AEmailAzureID;

  If FProvedor = oautOutlook Then
  Begin
    If FIDDiretorio.IsEmpty Then
      Raise Exception.Create('Os dados do ID do Diretório são obrigatórios para o Outlook/Microsoft 365.');

    If FClientId.IsEmpty Then
      Raise Exception.Create('Os dados do ID do Cliente são obrigatórios para o Outlook/Microsoft 365.');

    FBodyParametros := Concat('client_id=', FClientID, '&',
                              'scope=https://graph.microsoft.com/.default&',
                              'grant_type=client_credentials&',
                              'client_secret=', FClientSecret, '&');

    FParametros := TStringList.Create;
  End;

  If Not Assigned(VS_ListaToken) Then
    VS_ListaToken := TList<TDadosToken>.Create;
end;

destructor TEnvioEmailAutenticacaoOAuth2.Destroy;
begin
  FDatasetProvedor.Close;
  FreeAndNil(FDatasetProvedor);

  If Assigned(FParametros) Then
    FreeAndNil(FParametros);

  inherited;
end;

function TEnvioEmailAutenticacaoOAuth2.GetToken(ALimparAtual: Boolean): String;
  Var
    LRetorno: String;

    LDadosToken: TDadosToken;
begin
  Result := EmptyStr;
  If Not ALimparAtual Then
    Result := RetornaTokenAtivo(FProvedor).Token;

  If Not Result.IsEmpty Then
    Exit;

  Try
    If MatchStr(ExecuteRestSynalist(RetornaMetodoToken,
                                    RetornaUrlToken,
                                    FParametros,
                                    LRetorno,
                                    FBodyParametros).ToString, ['200', '201']) Then
    BEgin
      LDadosToken := RetornaTokenObjectJson(FProvedor, LRetorno);
      VS_ListaToken.Add(LDadosToken);

      Result := LDadosToken.Token;

      GravarDadosNovoTokenGerado(LDadosToken);
    End;
  Except
    On E: Exception Do
    Begin
      If FProvedor = oautOutlook Then
        Raise Exception.Create(TrataErrosEmailOutlook(E.Message));

      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TEnvioEmailAutenticacaoOAuth2.GravarDadosNovoTokenGerado(
  ADadosToken: TDadosToken);
  Var
    LInserir: TUniQuery;
begin
  Try
    LInserir := fCriaQuery;

    LInserir.SQL.Text := 'REPLACE INTO AUTEMA (AUT_EMPFIS, AUT_CODPRV, AUT_DTAHOR, AUT_TOKEN_, AUT_EXPIRA) VALUES ' +
                         '                    (:EMPFIS, :CODPRV, :DTAHOR, :TOKEN_, :EXPIRA)';

    LInserir.ParamByName('EMPFIS').AsString := fRetEmpresaFisica;
    LInserir.ParamByName('CODPRV').AsInteger := ADadosToken.CodigoProvedor;
    LInserir.ParamByName('DTAHOR').AsDateTime := IncSecond(ADadosToken.DataLimite, -ADadosToken.Expiracao);
    LInserir.ParamByName('TOKEN_').AsString := ADadosToken.Token;
    LInserir.ParamByName('EXPIRA').AsInteger := ADadosToken.Expiracao;

    LInserir.ExecSQL;

    FreeAndNil(LInserir);
  Except

  End;
end;

function TEnvioEmailAutenticacaoOAuth2.RetornaIDEmailAzureOutlook(
  AEmail: String): String;
  Var
    LRetorno: String;

    LParametros: TStringList;

    LJsonObject: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;
begin
  Result := EmptyStr;

  LParametros := TStringList.Create;

  Try
    Try
      LParametros.Add('Authorization: ' + GetToken);

      If Not MatchStr(ExecuteRestSynalist('GET',
                                          'https://graph.microsoft.com/v1.0/users',
                                          LParametros,
                                          LRetorno,
                                          EmptyStr,
                                          'application/json').ToString, ['200', '201']) Then
        Raise Exception.Create(LRetorno);

      LJsonObject := TJsonObject.ParseJSONValue(LRetorno) As TJsonObject;

      LJsonArray := TJsonObject.ParseJSONValue(LJsonObject.GetValue('value').ToJson) As TJsonArray;

      For LJsonValue In LJsonArray Do
      Begin
        If AEmail.Equals(RetornaValorJsonValue(LJsonValue, 'mail')) Then
        Begin
          FEmailAzureID := RetornaValorJsonValue(LJsonValue, 'id');
          Exit(RetornaValorJsonValue(LJsonValue, 'id'));
        End;

        If RetornaValorJsonValue(LJsonValue, 'mail').IsEmpty Then
        Begin
          If AEmail.Replace('@', '_').Equals(LeftStr(RetornaValorJsonValue(LJsonValue, 'userPrincipalName'), AEmail.Length)) Then
          Begin
            FEmailAzureID := RetornaValorJsonValue(LJsonValue, 'id');
            Exit(RetornaValorJsonValue(LJsonValue, 'id'));
          End;
        End;
      End;

      Raise Exception.Create('Esse e-mail não faz parte do cadastro do Azure. Verifique!');
    Except
      On E: Exception Do
      Begin
        If FProvedor = oautOutlook Then
          Raise Exception.Create(TrataErrosEmailOutlook(E.Message));

        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LParametros);

    If LJsonObject <> Nil Then
      FreeAndNil(LJsonObject);
  End;
end;

function TEnvioEmailAutenticacaoOAuth2.RetornaMetodoToken: String;
begin
  Result := 'POST';

  If FProvedor = oautNenhum Then
    Exit(EmptyStr);
end;

function TEnvioEmailAutenticacaoOAuth2.RetornaTipoDoProvedor: TTiposProvedorOAuth;
begin
  Result := oautNenhum;

  If MatchStr(FDatasetProvedor.FieldByName('PRV_URSMTP').AsString.ToLower,
                                           ['smtp.office365.com',
                                            'smtp-mail.outlook.com']) Then
    Exit(oautOutlook);
end;

function TEnvioEmailAutenticacaoOAuth2.RetornaTokenAtivo(
  AProvedor: TTiposProvedorOAuth): TDadosToken;
  Var
    LTokenGravado: TDadosToken;

    LExpirado: Boolean;
begin
  Result := TDadosToken.Create;

  LExpirado := False;

  For LTokenGravado In VS_ListaToken Do
  Begin
    If LTokenGravado.Provedor = AProvedor Then
    Begin
      If FDatasetProvedor.FieldByName('PRV_CODPRV').AsString.Equals(LTokenGravado.CodigoProvedor.ToString) Then
      Begin
        If IncSecond(LTokenGravado.DataLimite, -60) > fRetDtaHraServidor Then
          Exit(LTokenGravado);

        VS_ListaToken.Delete(VS_ListaToken.IndexOf(LTokenGravado));

        LExpirado := True;

        Break;
      End;
    End;
  End;

  If LExpirado Then
    Exit;

  If Result.Token.IsEmpty Then
    Result := RetornaTokenGravadoEmpresaFisica;
end;

function TEnvioEmailAutenticacaoOAuth2.RetornaTokenGravadoEmpresaFisica: TDadosToken;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Result := TDadosToken.Create;

  Try
    LConsulta.SQL.Text := 'SELECT AUT_TOKEN_, ' +
                          '       AUT_EXPIRA, ' +
                          '       AUT_DTAHOR  ' +
                          'FROM AUTEMA ' +
                          'WHERE AUT_EMPFIS=:EMPFIS ' +
                          '  AND AUT_CODPRV=:CODPRV ';

    LConsulta.ParamByName('EMPFIS').AsString := fRetEmpresaFisica;
    LConsulta.ParamByName('CODPRV').AsInteger := FDatasetProvedor.FieldByName('PRV_CODPRV').AsInteger;
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    If IncSecond(LConsulta.FieldByName('AUT_DTAHOR').AsDateTime,
                 LConsulta.FieldByName('AUT_EXPIRA').AsInteger -60) <= fRetDtaHraServidor Then
      Exit;

    Result.CodigoProvedor := FDatasetProvedor.FieldByName('PRV_CODPRV').AsInteger;
    Result.Provedor := RetornaTipoDoProvedor;
    Result.Expiracao := LConsulta.FieldByName('AUT_EXPIRA').AsInteger;
    Result.DataLimite := IncSecond(LConsulta.FieldByName('AUT_DTAHOR').AsDateTime,
                                   Result.Expiracao);
    Result.Token := LConsulta.FieldByName('AUT_TOKEN_').AsString;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TEnvioEmailAutenticacaoOAuth2.RetornaTokenObjectJson(AProvedor: TTiposProvedorOAuth;
  AJsonRetorno: String): TDadosToken;
  Var
    LJsonObject: TJsonObject;
begin
  Result := TDadosToken.Create;

  Try
    LJsonObject := TJSONObject.ParseJSONValue(AJsonRetorno) as TJSONObject;
    Result.Provedor := AProvedor;
    Result.Token := LJsonObject.GetValue<String>('access_token');
    Result.Expiracao := LJsonObject.GetValue<Integer>('expires_in');
    Result.DataLimite := IncSecond(fRetDtaHraServidor, Result.Expiracao);
    Result.CodigoProvedor := FDatasetProvedor.FieldByName('PRV_CODPRV').AsInteger;
  Finally
    FreeAndNil(LJsonObject);
  End;
end;

function TEnvioEmailAutenticacaoOAuth2.RetornaUrlToken: String;
begin
  Result := EmptyStr;

  If FProvedor = oautOutlook Then
    Result := 'https://login.microsoftonline.com/' + FIDDiretorio + '/oauth2/v2.0/token';
end;

end.
