unit untTRestSynalistAutban;

interface

Uses System.Classes, System.SysUtils, System.StrUtils, System.Json, HTTPSend,
     blcksock, synautil, ssl_openssl, System.Generics.Collections, Vcl.Forms,
     System.DateUtils, idCoderMIME, Uni, Data.DB, untModulo;

Type
  TDadosToken = class
  public
    Carteira,
    Token: String;

    Expiracao: Integer;

    DataLimite: TDateTime;
  end;

Type
  TDadosCertificado = class
  public
    Carteira,
    ArquivoPfx,
    ArquivoCRT,
    ArquivoKey,
    SenhaCertificado: String;
  end;

Type
  TArrayStatusSemRaiseException = Array Of Integer;

Type
  TRestSynalistAutban = class
  private
    FPastaAutcom: String;

    FDadosCertificado: TDadosCertificado;

    FStatusSemRaise: TArrayStatusSemRaiseException;

    procedure OnHeartBeat(Sender: TObject);

    procedure AdicionaCertificadosRequisicao(var AComponente: THTTPSend);
    procedure RemoverCertificados;

    function RetornaJsonErro(AComponente: THTTPSend;
                             AErroException: String = ''): String;
    function RetornaTokenObjectJson(ACarteira,
                                    AJsonRetorno: String): TDadosToken;

    function StatusGeraRaiseException(AStatus: Integer): Boolean;

    function RetornaTokenGravado(ACarteira: String): TDadosToken;

    procedure InserirTokenTabela(ADadosToken: TDadosToken);

    class procedure CarregaChaveAutorizacaoCitel;

    class procedure AdicionaAlteraConfiguracao(ACodigoCfg,
                                               AValorCfg,
                                               AEmpresaCfg,
                                               ADescricaoCfg,
                                               AGrupoCfg: String);
  public
    Constructor Create;
    Destructor Destroy; Override;

    property StatusSemRaise: TArrayStatusSemRaiseException read FStatusSemRaise write FStatusSemRaise;

    procedure CarregaCertificados(ACarteira,
                                  ACertificadoPfx,
                                  ACertificadoCRT,
                                  ACertificadoKey,
                                  ASenhaCertificado: String);

    function GetToken(const AMetodo,
                            AUrl: String;
                            AParametros: TStringList;
                            ACarteira: String;
                            AJsonEnvio: String = '';
                            AMineType: String = '';
                            ACarregaCertificado: Boolean = True): String; overload;

    function RetornaTokenAtivo(ACarteira: String): TDadosToken;

    function GetToken(const AMetodo,
                            AUrl: String;
                            AParametros: TStringList;
                            ACarteira: String;
                        out AJsonRetorno: String;
                        out AResultCode: Integer;
                            AJsonEnvio: String = '';
                            AMineType: String = ''): String; overload;

    function ExecuteRestSynalist(const AMetodo,
                                       AUrl: String;
                                       AParametros: TStringList;
                                   out AJsonRetorno: String;
                                       AJsonEnvio: String = '';
                                       AMineType: String = '';
                                       ACarregaCertificado: Boolean = True): Integer;

    function ExecuteRestSynalist_Sicredi(const AMetodo,
                                               AUrl: String;
                                               AParametros: TStringList;
                                           out AJsonRetorno: String;
                                               AJsonEnvio: String = '';
                                               AMineType: String = ''): Integer;

    procedure RemoveTokenAtivo(ACarteira: String);

    procedure RemoverTokenGravado(ACarteira: String);

    class function RetornaValidadeCertificadoCrtCitelWebhook(AArquivoBase64: String): String;

    property DadosCertificado: TDadosCertificado read FDadosCertificado;
  end;

Var
  VS_ListaToken: TList<TDadosToken>;
  VS_ChaveAutorizacaoCitel: String;
  
implementation
Uses untFuncoesSimples, untTFuncoesAuxiliaresPix;

{ TRestSynalistAutban }

procedure TRestSynalistAutban.AdicionaCertificadosRequisicao(
  var AComponente: THTTPSend);
begin
  If FDadosCertificado.ArquivoCrt.IsEmpty Then
  Begin
    If FDadosCertificado.ArquivoPfx.IsEmpty Then
      Exit;
  End;

  If Not FDadosCertificado.ArquivoCrt.IsEmpty Then
  Begin
    AComponente.sock.SSL.CertificateFile := FDadosCertificado.ArquivoCrt;
    AComponente.sock.SSL.PrivateKeyFile  := FDadosCertificado.ArquivoKey;
  End
  Else
    AComponente.sock.SSL.PFXfile := FDadosCertificado.ArquivoPfx;

  AComponente.sock.SSL.Password := FDadosCertificado.SenhaCertificado;
  AComponente.sock.SSL.KeyPassword := FDadosCertificado.SenhaCertificado;
end;

procedure TRestSynalistAutban.CarregaCertificados(ACarteira,
  ACertificadoPfx, ACertificadoCRT, ACertificadoKey,
  ASenhaCertificado: String);
  Var
    LStream: TMemoryStream;

    LDecoder: TIdDecoderMIME;
begin
  If ACertificadoCRT.IsEmpty Then
  Begin
    If ACertificadoPfx.IsEmpty Then
      Exit;
  End;

  If Not Concat(FDadosCertificado.ArquivoCrt, FDadosCertificado.ArquivoPfx).IsEmpty Then
    Exit;

  LDecoder := TIdDecoderMIME.Create(nil);
  LStream := TMemoryStream.Create;

  Try
    FDadosCertificado := TDadosCertificado.Create;
    FDadosCertificado.Carteira := ACarteira;

    If Not ACertificadoPfx.IsEmpty Then
    Begin
      LDecoder.DecodeStream(ACertificadoPfx, LStream);

      LStream.SaveToFile(FPastaAutcom + 'temp\autb' + fGetConnectionID +
                                        VS_strCodEmp +
                                        strLoginUsuarioLogado + 'x');

      FDadosCertificado.ArquivoPFX := FPastaAutcom + 'temp\autb' + fGetConnectionID +
                                                      VS_strCodEmp +
                                                      strLoginUsuarioLogado + 'x';
    End
    Else
    Begin
      LDecoder.DecodeStream(ACertificadoCRT, LStream);

      LStream.SaveToFile(FPastaAutcom + 'temp\autb' + fGetConnectionID +
                                        VS_strCodEmp +
                                        strLoginUsuarioLogado + 'r');

      FDadosCertificado.ArquivoCRT := FPastaAutcom + 'temp\autb' + fGetConnectionID +
                                                      VS_strCodEmp +
                                                      strLoginUsuarioLogado + 'r';

      If Not ACertificadoKey.IsEmpty Then
      Begin
        LDecoder.Free;
        LStream.Free;

        LDecoder := TIdDecoderMIME.Create(nil);
        LStream := TMemoryStream.Create;

        LDecoder.DecodeStream(ACertificadoKey, LStream);

        LStream.SaveToFile(FPastaAutcom + 'temp\autb' + fGetConnectionID +
                                          VS_strCodEmp +
                                          strLoginUsuarioLogado + 'y');

        FDadosCertificado.ArquivoKey := FPastaAutcom + 'temp\autb' + fGetConnectionID +
                                                        VS_strCodEmp +
                                                        strLoginUsuarioLogado + 'y';
      End;
    End;

    FDadosCertificado.SenhaCertificado := ASenhaCertificado;
  Finally
    LDecoder.Free;
    LStream.Free;
  End;
end;

class procedure TRestSynalistAutban.CarregaChaveAutorizacaoCitel;
begin
  VS_ChaveAutorizacaoCitel := fCfgSis('CHVCIT');

  If VS_ChaveAutorizacaoCitel.Trim.IsEmpty Then
  Begin
    VS_ChaveAutorizacaoCitel := 'uLtr@-F!n&320147';

    AdicionaAlteraConfiguracao('CFG_CHVCIT',
                               VS_ChaveAutorizacaoCitel,
                               VS_strCodEmp,
                               'Chave para Pix Citel',
                               'PIX');
  End;
end;

class procedure TRestSynalistAutban.AdicionaAlteraConfiguracao(ACodigoCfg,
                                                               AValorCfg,
                                                               AEmpresaCfg,
                                                               ADescricaoCfg,
                                                               AGrupoCfg: String);
  Var
    LRegistro: TUniQuery;
Begin
  If ACodigoCfg.IsEmpty Then
    Exit;

  If AEmpresaCfg.IsEmpty Then
    Exit;

  LRegistro := fCriaQuery;
  Try
    LRegistro.SQL.Text := 'SELECT * FROM CFGSIS ' +
                          'WHERE SIS_CODCFG="' + ACodigoCfg + '" ' +
                          '  AND SIS_CODEMP="' + AEmpresaCfg + '" ';
    LRegistro.Open;

    If LRegistro.IsEmpty Then
    Begin
      LRegistro.Insert;
      LRegistro.FieldByName('SIS_CODCFG').AsString := ACodigoCfg;
      LRegistro.FieldByName('SIS_CODEMP').AsString := AEmpresaCfg;
      LRegistro.FieldByName('SIS_DESCRI').AsString := ADescricaoCfg;
      LRegistro.FieldByName('SIS_GRUCFG').AsString := AGrupoCfg;

      If LRegistro.FindField('SIS_NUMHLP') <> Nil Then
        LRegistro.FieldByName('SIS_NUMHLP').AsString := '0';

      If LRegistro.FindField('SIS_LAYOUT') <> Nil Then
        LRegistro.FieldByName('SIS_LAYOUT').AsString := 'N';
    End
    Else
      LRegistro.Edit;

    LRegistro.FieldByName('SIS_VALCFG').AsString := AValorCfg;
    LRegistro.FieldByName('SIS_ULTALT').AsFloat := fRetDataServidor;

    LRegistro.Post;
  Finally
    LRegistro.Close;
    FreeAndNil(LRegistro);
  End;
End;

constructor TRestSynalistAutban.Create;
begin
  FPastaAutcom := ExtractFilePath(Application.ExeName).Replace('autban\', EMptyStr)
                                                      .Replace('Autban\', EMptyStr)
                                                      .Replace('AUTBAN\', EMptyStr);

  If Not Assigned(VS_ListaToken) Then
    VS_ListaToken := TList<TDadosToken>.Create;

  FDadosCertificado := TDadosCertificado.Create;

  CarregaChaveAutorizacaoCitel;

  SetLength(FStatusSemRaise, 0);
end;

destructor TRestSynalistAutban.Destroy;
begin
  RemoverCertificados;

  SetLength(FStatusSemRaise, 0);
  inherited;
end;

function TRestSynalistAutban.ExecuteRestSynalist(const AMetodo, AUrl: String;
  AParametros: TStringList; out AJsonRetorno: String;
  AJsonEnvio: String = ''; AMineType: String = ''; ACarregaCertificado: Boolean = True): Integer;
  Var
    LHTTPSend: THTTPSend;

    LFDataReq,
    LFDataResp: TMemoryStream;
begin
   LHTTPSend := THTTPSend.Create;
   LHTTPSend.Sock.OnHeartbeat := OnHeartBeat;

   Result := -1;

  Try
    Try
      LHTTPSend.MimeType  := 'application/json; charset=utf-8';
      If Not AMineType.IsEmpty Then
        LHTTPSend.MimeType := AMineType;

      LHTTPSend.Protocol  := '1.1';

      If Assigned(AParametros) Then
        LHTTPSend.Headers.AddStrings(AParametros);

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 30000 );
      LHTTPSend.Sock.ConnectionTimeout   := 30000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 30000;
      LHTTPSend.Sock.SocksTimeout        := 30000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 30000;

      If ACarregaCertificado Then
        AdicionaCertificadosRequisicao(LHTTPSend);

      If Not AJsonEnvio.IsEmpty Then
      Begin
        Try
          LFDataReq := TMemoryStream.Create;
          WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(AJsonEnvio)));
          LHTTPSend.Document.LoadFromStream(LFDataReq);
        Finally
          FreeAndNil(LFDataReq);
        End;
      End;

      If LHTTPSend.HTTPMethod(AMetodo, AUrl) Then
      Begin
        LHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          AJsonRetorno := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          Result := LHTTPSend.ResultCode;

          If Not MatchStr(Result.ToString, ['200', '201']) Then
          Begin
            If StatusGeraRaiseException(Result) Then
              Raise Exception.Create(AJsonRetorno);
          End;
        Finally
          FreeAndNil(LFDataResp);
        End;

      End
      Else
      Begin
        AJsonRetorno := RetornaJsonErro(LHTTPSend);

        Result := LHTTPSend.ResultCode;

        Raise Exception.Create(LHTTPSend.Sock.LastErrorDesc);
      End;

    Except
      On E: Exception Do
        Raise Exception.Create(RetornaJsonErro(LHTTPSend, E.Message));
    End;
  Finally
    FreeAndNil(LHTTPSend);

    Application.ProcessMessages;
  End;
end;

function TRestSynalistAutban.ExecuteRestSynalist_Sicredi(const AMetodo, AUrl: String;
  AParametros: TStringList; out AJsonRetorno: String;
  AJsonEnvio: String = ''; AMineType: String = ''): Integer;
  Var
    LHTTPSend: THTTPSend;

    LFDataReq,
    LFDataResp: TMemoryStream;
begin
   LHTTPSend := THTTPSend.Create;
   LHTTPSend.Sock.OnHeartbeat := OnHeartBeat;

   Result := -1;

  Try
    Try
      LHTTPSend.MimeType  := 'application/json; charset=utf-8';
      If Not AMineType.IsEmpty Then
        LHTTPSend.MimeType := AMineType;

      LHTTPSend.Protocol  := '1.1';

      If Assigned(AParametros) Then
        LHTTPSend.Headers.AddStrings(AParametros);

      LHTTPSend.UserAgent := 'Mozilla/4.0';
      LHTTPSend.KeepAlive := True;

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 90000 );
      LHTTPSend.Sock.ConnectionTimeout   := 90000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 90000;
      LHTTPSend.Sock.SocksTimeout        := 90000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 90000;
      LHTTPSend.Sock.SocksType := TSocksType.ST_Socks4;

      AdicionaCertificadosRequisicao(LHTTPSend);

      If Not AJsonEnvio.IsEmpty Then
      Begin
        Try
          LFDataReq := TMemoryStream.Create;
          WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(AJsonEnvio)));
          LHTTPSend.Document.LoadFromStream(LFDataReq);
        Finally
          FreeAndNil(LFDataReq);
        End;
      End;

      If LHTTPSend.HTTPMethod(AMetodo, AUrl) Then
      Begin
        LHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          AJsonRetorno := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          Result := LHTTPSend.ResultCode;

          If Not MatchStr(Result.ToString, ['200', '201', '202', '404']) Then
          Begin
            If StatusGeraRaiseException(Result) Then
              Raise Exception.Create(AJsonRetorno);
          End;
        Finally
          FreeAndNil(LFDataResp);
        End;

      End
      Else
      Begin
        AJsonRetorno := RetornaJsonErro(LHTTPSend);

        Result := LHTTPSend.ResultCode;

        Raise Exception.Create(AJsonRetorno);
      End;

    Except
      On E: Exception Do
        Raise Exception.Create(RetornaJsonErro(LHTTPSend, E.Message));
    End;
  Finally
    FreeAndNil(LHTTPSend);

    Application.ProcessMessages;
  End;
end;

function TRestSynalistAutban.GetToken(const AMetodo, AUrl: String;
  AParametros: TStringList; ACarteira, AJsonEnvio, AMineType: String;
  ACarregaCertificado: Boolean): String;
  Var
    LRetorno: String;

    LDadosToken: TDadosToken;
begin
  Result := RetornaTokenAtivo(ACarteira).Token;

  If Not Result.IsEmpty Then
    Exit;

  If MatchStr(ExecuteRestSynalist(AMetodo,
                                  AUrl,
                                  AParametros,
                                  LRetorno,
                                  AJsonEnvio,
                                  AMineType,
                                  ACarregaCertificado).ToString, ['200', '201']) Then
  BEgin
    LDadosToken := RetornaTokenObjectJson(ACarteira, LRetorno);
    VS_ListaToken.Add(LDadosToken);

    InserirTokenTabela(LDadosToken);

    Result := LDadosToken.Token;
  End;
end;

function TRestSynalistAutban.GetToken(const AMetodo, AUrl: String;
  AParametros: TStringList; ACarteira : String; out AJsonRetorno: String; out AResultCode: Integer; AJsonEnvio, AMineType: String): String;
  Var
    LRetorno: String;

    LDadosToken: TDadosToken;
begin
  Result := '';

  AResultCode := ExecuteRestSynalist(AMetodo,
                                     AUrl,
                                     AParametros,
                                     LRetorno,
                                     AJsonEnvio,
                                     AMineType);

  AJsonRetorno := LRetorno;

  If MatchStr(AResultCode.ToString, ['200', '201']) Then
  Begin
    LDadosToken := RetornaTokenObjectJson(ACarteira, LRetorno);
    
    VS_ListaToken.Add(LDadosToken);

    InserirTokenTabela(LDadosToken);

    Result := LDadosToken.Token;
  End;
end;

procedure TRestSynalistAutban.InserirTokenTabela(ADadosToken: TDadosToken);
  Var
    LInserir: TUniQuery;

    LConexao: TCriarConexao;
begin
  //Apenas para o Banco 237 até o momento
  If Not ADadosToken.Carteira.Contains('237API-') Then
    Exit;

  LConexao := TCriarConexao.Create;
  LConexao.objConexao.Connect;

  LInserir := fCriaQuery(LConexao.objConexao);

  Try
    LInserir.SQL.Text := 'INSERT INTO AUTATB (' +
                         '     AUT_DTACAD, ' +
                         '     AUT_CARTEI, ' +
                         '     AUT_ATOKEN, ' +
                         '     AUT_EXPIRA  ' +
                         ') VALUES ( ' +
                         '     :DTACAD, ' +
                         '     :CARTEI, ' +
                         '     :ATOKEN, ' +
                         '     :EXPIRA) ';

    fStartTransaction(LConexao.objConexao);

    LInserir.ParamByName('DTACAD').AsDateTime := fRetDtaHraServidor;
    LInserir.ParamByName('CARTEI').AsString := ADadosToken.Carteira;
    LInserir.ParamByName('ATOKEN').AsString := ADadosToken.Token;
    LInserir.ParamByName('EXPIRA').AsInteger := ADadosToken.Expiracao;
    LInserir.ExecSQL;

    fCommit(LConexao.objConexao);
  Finally
    LInserir.Close;
    FreeAndNil(LInserir);

    LConexao.objConexao.Disconnect;
    FreeAndNil(LConexao);
  End;
end;

procedure TRestSynalistAutban.OnHeartBeat(Sender: TObject);
begin
  Application.ProcessMessages;
end;

procedure TRestSynalistAutban.RemoverCertificados;
begin
  If Not Assigned(FDadosCertificado) Then
    Exit;

  Try
    If Not FDadosCertificado.ArquivoPfx.IsEmpty Then
    Begin
      If FileExists(PChar(FDadosCertificado.ArquivoPfx)) Then
        DeleteFile(PChar(FDadosCertificado.ArquivoPfx));
    End;

    If Not FDadosCertificado.ArquivoCrt.IsEmpty Then
    Begin
      If FileExists(PChar(FDadosCertificado.ArquivoCRT)) Then
        DeleteFile(PChar(FDadosCertificado.ArquivoCRT));
    End;

    If Not FDadosCertificado.ArquivoKey.IsEmpty Then
    Begin
      If FileExists(PChar(FDadosCertificado.ArquivoKey)) Then
        DeleteFile(PChar(FDadosCertificado.ArquivoKey));
    End;
  Finally
    FreeAndNil(FDadosCertificado);
  End;
end;

procedure TRestSynalistAutban.RemoverTokenGravado(ACarteira: String);
  Var
    LConexao: TCriarConexao;

    LExcluir: TUniQuery;
begin
  RemoveTokenAtivo(ACarteira);

  LConexao := TCriarConexao.Create;
  LConexao.objConexao.Connect;

  LExcluir := fCriaQuery(LConexao.objConexao);
  Try
    fStartTransaction(LConexao.objConexao);

    LExcluir.SQL.Text := 'DELETE FROM AUTATB WHERE AUT_CARTEI="' + ACarteira + '"';
    LExcluir.ExecSQL;

    fCommit(LConexao.objConexao);
  Finally
    LExcluir.Close;
    FreeAndNil(LExcluir);

    LConexao.objConexao.Disconnect;
    FreeAndNil(LConexao);
  End;
end;

procedure TRestSynalistAutban.RemoveTokenAtivo(ACarteira: String);
  Var
    LTokenGravado: TDadosToken;
begin
  For LTokenGravado In VS_ListaToken Do
  Begin
    If LTokenGravado.Carteira.Equals(ACarteira) Then
    Begin
      VS_ListaToken.Delete(VS_ListaToken.IndexOf(LTokenGravado));
      Break;
    End;
  End;
end;

function TRestSynalistAutban.RetornaJsonErro(AComponente: THTTPSend;
  AErroException: String = ''): String;
  Var
    LErroString: String;

    LFDataResp: TMemoryStream;
begin
  Result := AComponente.Sock.GetErrorDescEx + '-' + AComponente.Sock.LastErrorDesc;
  LFDataResp := TMemoryStream.Create;

  Try
    If AComponente.Document <> Nil Then
    Begin
      AComponente.Document.Position := 0;

      LFDataResp.LoadFromStream(AComponente.Document);

      LFDataResp.Position := 0;
      LErroString := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));
      If Not LErroString.Trim.IsEmpty Then
        Result := LErroString;
    End;

    If Not AErroException.IsEmpty Then
    Begin
      If Not Result.Equals(AErroException) Then
        Result := Result + ' - ' + AErroException;
    End;
  Finally
    FreeAndNil(LFDataResp);
  End;
end;

function TRestSynalistAutban.RetornaTokenAtivo(ACarteira: String): TDadosToken;
  Var
    LTokenGravado: TDadosToken;

    LTempoLimite: Integer;
begin
  For LTokenGravado In VS_ListaToken Do
  Begin
    If LTokenGravado.Carteira.Equals(ACarteira) Then
    Begin
      LTempoLimite := -60;
      If LTokenGravado.Carteira.Contains('341API') Then
        LTempoLimite := -100;

      If IncSecond(LTokenGravado.DataLimite, LTempoLimite) > fRetDtaHraServidor Then
        Exit(LTokenGravado);

      RemoverTokenGravado(ACarteira);

      If VS_ListaToken.IndexOf(LTokenGravado) <> -1 Then
        VS_ListaToken.Delete(VS_ListaToken.IndexOf(LTokenGravado));

      Break;
    End;
  End;

  Result := RetornaTokenGravado(ACarteira);
end;

function TRestSynalistAutban.RetornaTokenGravado(
  ACarteira: String): TDadosToken;
  Var
    LConsulta: TUniQuery;
begin
  Result := TDadosToken.Create;

  //Apenas para o Banco 237 até o momento
  If Not ACarteira.Contains('237API-') Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUT_DTACAD, ' +
                          '       AUT_ATOKEN, ' +
                          '       AUT_EXPIRA  ' +
                          'FROM AUTATB ' +
                          'WHERE AUT_CARTEI=:CARTEI ' +
                          'ORDER BY AUT_DTACAD ';

    LConsulta.ParamByName('CARTEI').AsString := ACarteira;
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    While Not LConsulta.Eof Do
    Begin
      If IncSecond(LConsulta.FieldByName('AUT_DTACAD').AsDateTime,
                   LConsulta.FieldByName('AUT_EXPIRA').AsInteger - 60) < fRetDtaHraServidor Then
      Begin
        LConsulta.Delete;

        Exit;
      End;

      Result.Carteira := ACarteira;
      Result.Token := LConsulta.FieldByName('AUT_ATOKEN').AsString;
      Result.Expiracao := LConsulta.FieldByName('AUT_EXPIRA').AsInteger;
      Result.DataLimite := IncSecond(LConsulta.FieldByName('AUT_DTACAD').AsDateTime,
                                     LConsulta.FieldByName('AUT_EXPIRA').AsInteger);

      VS_ListaToken.Add(Result);

      Break;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TRestSynalistAutban.RetornaTokenObjectJson(ACarteira,
  AJsonRetorno: String): TDadosToken;
  Var
    LJsonObject: TJsonObject;
begin
  Result := TDadosToken.Create;

  Try
    LJsonObject := TJSONObject.ParseJSONValue(AJsonRetorno) as TJSONObject;
    Result.Carteira := ACarteira;
    Result.Token := LJsonObject.GetValue<String>('access_token');
    Result.Expiracao := LJsonObject.GetValue<Integer>('expires_in');
    Result.DataLimite := IncSecond(fRetDtaHraServidor, Result.Expiracao);
  Finally
    FreeAndNil(LJsonObject);
  End;
end;

class function TRestSynalistAutban.RetornaValidadeCertificadoCrtCitelWebhook(
  AArquivoBase64: String): String;
  Var
    LParametros: TStringList;

    LRetornoStatus: Integer;

    LDataRequisicao: Int64;

    LRetorno: String;
begin
  If VS_ChaveAutorizacaoCitel.Trim.IsEmpty Then
    CarregaChaveAutorizacaoCitel;

  LParametros := TStringList.Create;

  Try
    LDataRequisicao := untFuncoesSImples.RetornaTimeStampEmMilisegundos;

    LParametros.Add('WebHookItauAuthorizationCitel: ' +
                    TFuncoesPix.RetornaChaveBasic(LDataRequisicao.ToString,
                    untFuncoesSimples.GetMD5(LDataRequisicao.ToString + VS_ChaveAutorizacaoCitel)));

    LParametros.Add('base64: ' + AArquivoBase64);

    LRetornoStatus := TRestSynalistAutban.Create.ExecuteRestSynalist('POST',
                                                 'https://webhookitau.citelsoftware.com.br/ConversorCertificadosCitel/retornarValidadeCertificadoCrt',
                                                 LParametros,
                                                 LRetorno);

    If LRetornoStatus.ToString.Equals('200') Then
      Exit(LRetorno);

    Raise Exception.Create(LRetorno);
  Finally
    FreeAndNil(LParametros);
  End;
end;

function TRestSynalistAutban.StatusGeraRaiseException(
  AStatus: Integer): Boolean;
  Var
    LContador: Integer;
begin
  Result := True;

  If Length(FStatusSemRaise) = 0 Then
    Exit;

  For LContador In FStatusSemRaise Do
  Begin
    If LContador = AStatus Then
      Exit(False);
  End;
end;

end.
