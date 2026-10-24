unit untConsultaDadosScope;

interface

uses Forms, untPaiSimples ;

type
  TConsultaDadosScopeEnvio = class
  private
    FFormMsg : TfrmPaiSimples;

    function fMontaDataScope: String ;
    function RetornaChaveBasic(AClientID,AClientSecret: String): String;
    function fTrataCnpj(const AstrCnpj: String): String ;

    procedure pMostraErrorGettingServerCertificate;
    procedure pClickBotao(Sender: TObject);
    procedure pClickLabel(Sender: TObject);

    function fVerificaIni(const ACodigoEmpresaFilial, ANumeroIP, ACaminhoArquivo: string; out AMensagem: string): Boolean;
    function fRetornaFullPathIni(const APath: String): String ;
    function fPathWithDelim(const APath : AnsiString) : AnsiString ;
  public
    function fEmpresaAtiva(const AstrCnpj, AstrCodigoEmpresa, AstrCodigoFilial, AstrPathTef: String; var AstrMsgErro: String): Boolean ;
  end ;

implementation

uses
  untRestApi, System.SysUtils, REST.Types, REST.Client, untControllerDadosScope,
  System.Hash, DateUtils, System.NetEncoding, untFuncoesSimples,
  untRepositorioDadosScope, Vcl.Controls, ShellApi, Vcl.StdCtrls, Vcl.Graphics,
  BitBtnLockedIncrem, System.Classes, JSON, strUtils, System.MaskUtils, Uni, Data.Db, System.IniFiles,
  untFuncoesGenerica ;

const
  msgErrorGettingServerCertificate = 'REST request failed: Error getting Server Certificate';

{ TConsultaDadosScopeEnvio }

function TConsultaDadosScopeEnvio.fEmpresaAtiva(
  const AstrCnpj, AstrCodigoEmpresa, AstrCodigoFilial, AstrPathTef: String; var AstrMsgErro: String): Boolean;
var
  LControllerRest: TControllerRest;
  LRestRequest: TRestRequest;

  LstrCnpj: String ;
  LstrData: String ;
  LstrCodigo: String ;
  LstrSource: String ;
  LstrSha: String ;

  LstrJSONRet: String ;

  LjsonRetorno: TJSONValue ;
  LArrJsonValue: TJSONArray ;
  LjsonValue: TJSONValue ;

  LstrStatus: String ;
  LstrCodigoEmpresa, LstrCodigoFilial, LstrServidor: String ;
  LPathTef: String ;
  LQryTefVal: TUniQuery;
begin
  Result := False ;

  LstrCnpj := fTrataCnpj(AstrCnpj) ;
  LstrData := fMontaDataScope ;
  LstrCodigo := TRepositorioDadosScope.fGetCodigoInterno ;
  LstrSource := format('%s:%s:%s', [LstrCnpj, LstrData, LstrCodigo]) ;
  LstrSha := THashSHA2.GetHashString(LstrSource) ;


  LControllerRest := TControllerRest.Create('SCOP', TControllerDadosScope.fConfigurarApiScope);
  LRestRequest := TRestRequest.Create(LControllerRest.RestClient);
  try

    LRestRequest.Method := rmPOST ;
    LRestRequest.Resource := '/dadosScopeESitef' ;
    LRestRequest.Params.Clear;
    LRestRequest.AddAuthParameter('Authorization',RetornaChaveBasic(TRepositorioDadosScope.fGetUsuario, TRepositorioDadosScope.fGetSenha), TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
    LRestRequest.AddParameter('cnpj', LstrCnpj);
    LRestRequest.AddParameter('key', LstrSha);

    if LControllerRest.fExecute(LRestRequest, LstrJSONRet, ['200']) then
    begin
      LjsonRetorno := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LstrJSONRet), 0) ;
      if LjsonRetorno is TJSONArray then
      begin
        LArrJsonValue := TJSONArray(LjsonRetorno) ;

        LjsonValue := LArrJsonValue.Items[0] ;
        if LjsonValue.TryGetValue('status', LstrStatus) then
        begin
          LstrCodigoEmpresa := '' ;
          LstrCodigoFilial := '' ;
          LstrServidor := '' ;
          LjsonValue.TryGetValue('empresa_scope', LstrCodigoEmpresa) ;
          LjsonValue.TryGetValue('filial_scope', LstrCodigoFilial) ;
          LjsonValue.TryGetValue('servidor_scope', LstrServidor) ;

          if (LstrCodigoEmpresa <> AstrCodigoEmpresa) or (LstrCodigoFilial <> AstrCodigoFilial) then
          begin
            AstrMsgErro := 'CNPJ divergente. TEF inoperante!' ;
            exit ;
          end ;

          LPathTef := fRetornaFullPathIni(AstrPathTef) ;
          if not fVerificaIni(LstrCodigoEmpresa+LstrCodigoFilial, LstrServidor, LPathTef, AstrMsgErro) then
            Exit ;

          Result := True ;
          Exit ;
        end ;
      end ;
      AstrMsgErro := 'CNPJ divergente. TEF inoperante!' ;
    end
    else
    begin
      if fTabelaExiste('TEFVAL', True) then
      begin
        LQryTefVal := fCriaQuery;
        try
          LQryTefVal.Close;
          LQryTefVal.SQL.Text := 'SELECT VAL_DTAVAL AS DTAVAL FROM TEFVAL ORDER BY AUTOINCREM DESC LIMIT 1';
          LQryTefVal.Open;

          if (LQryTefVal.RecordCount > 0) and (LQryTefVal.FieldByName('DTAVAL').AsDateTime > fNow) then
          begin
            AstrMsgErro := 'TEF em contingência!';
            Result := True;
            Exit;
          end;
        finally
          FreeAndNil(LQryTefVal);
        end;
      end;

      if LstrJSONRet = msgErrorGettingServerCertificate then
        pMostraErrorGettingServerCertificate;

      AstrMsgErro := 'TEF inoperante!' ;
    end;

  finally
    FreeAndNil(LRestRequest);
    FreeAndNil(LControllerRest);
  end ;

end;

function TConsultaDadosScopeEnvio.fMontaDataScope: String;
var
  LintAno, LintMes, LintDia: Integer ;
begin
  LintAno := YearOf(Date) ;
  LintMes := MonthOf(Date) ;
  LintDia := DayOf(Date) ;

  Result := format('%s/%s/%s', [IntToStr(LintAno), fStrZero(IntToStr(LintMes), 2), fStrZero(IntToStr(LintDia), 2)]) ;
end;

function TConsultaDadosScopeEnvio.fPathWithDelim(
  const APath: AnsiString): AnsiString;
begin
  Result := AnsiString(Trim(String(APath))) ;
  if Result <> '' then
  begin
     {$IfDef FPC}
      Result := IncludeTrailingPathDelimiter(Result);
     {$Else}
      if RightStr(Result,1) <> String(PathDelim) then
         Result := Result + PathDelim ;
     {$EndIf}
  end;
end;

function TConsultaDadosScopeEnvio.fRetornaFullPathIni(
  const APath: String): String;
var
  LPath: String ;
begin
  LPath := ExtractFileDir(Application.ExeName) ;

  if Trim(APath) <> '' then
    LPath := APath ;

  LPath := String(fPathWithDelim(AnsiString(LPath))) + 'scope.ini' ;

  Result := LPath ;
end;

function TConsultaDadosScopeEnvio.fTrataCnpj(const AstrCnpj: String): String;
var
  LstrCnpj: String ;
begin
  LstrCnpj := Trim(ReplaceStr(ReplaceStr(ReplaceStr(AstrCnpj, '.', ''), '/', ''), '-', '')) ;

  Result := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), LstrCnpj) ;
end;

function TConsultaDadosScopeEnvio.fVerificaIni(const ACodigoEmpresaFilial,
  ANumeroIP, ACaminhoArquivo: string; out AMensagem: string): Boolean;
var
  LIni: TIniFile;
  LSections: TStringList;
  LValorName: string;
begin
  Result := False;
  AMensagem := '';
  LSections := TStringList.Create;
  try
    if not FileExists(ACaminhoArquivo) then
    begin
      AMensagem := 'Scope.ini não encontrado no diretório do sistema. TEF inoperante!';
      Exit;
    end;

    LIni := TIniFile.Create(ACaminhoArquivo);
    try
      LIni.ReadSections(LSections);

      // Verifica se a seção existe
      if LSections.IndexOf(ACodigoEmpresaFilial) = -1 then
      begin
        AMensagem := format('Código Empresa/Filial [%s] não encontrado no Scope.ini. TEF inoperante!', [ACodigoEmpresaFilial]);
        Exit;
      end;

      // Lê o valor da chave Name
      LValorName := LIni.ReadString(ACodigoEmpresaFilial, 'Name', '');

      if LValorName = '' then
      begin
        AMensagem := 'Variável Name não encontrada no Scope.ini. TEF inoperante!';
        Exit;
      end;

      if not SameText(LValorName, ANumeroIP) then
      begin
        AMensagem := Format('Número IP diferente. Esperado: %s, Encontrado: %s. TEF inoperante!', [ANumeroIP, LValorName]);
        Exit;
      end;

      AMensagem := 'Validado com sucesso.';
      Result := True;
    finally
      LIni.Free;
    end;
  finally
    LSections.Free;
  end;
end;

procedure TConsultaDadosScopeEnvio.pClickBotao(Sender: TObject);
begin
  FFormMsg.Close;
end;

procedure TConsultaDadosScopeEnvio.pClickLabel(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PChar(TLabel(Sender).Caption), nil, nil, 0);
end;

procedure TConsultaDadosScopeEnvio.pMostraErrorGettingServerCertificate;
const
  urlEasyFix = 'https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi';
  msgInfo = 'Ocorreu uma crítica na verificação das exigências do TEF. ' + #13 +
            'Será necessário realizar as atualizações de segurança pendentes ' +
            'no Windows Update deste computador. ' + #13 +
            'Caso persista, uma possível solução para o problema ' +
            'pode ser encontrada na seção de downloads, no endereço: ';
  msgInfo2 = 'Após o download e instalação, reiniciar o AUTCOM!';
var
  btnOk : TBitBtnLocked;
  lblMsgInfo, lblMsgInfo2, lblMsgLink : TLabel;
begin
  pCriarFormularios(TfrmPaiSimples, FFormMsg);
  try
    FFormMsg.pgcDados.Visible := False;
    FFormMsg.Width := 784;
    FFormMsg.Height := 220;
    FFormMsg.Position := TPosition.poDesktopCenter;
    FFormMsg.BorderStyle := bsDialog;
    FFormMsg.Caption := 'Aviso';

    lblMsgInfo                  := TLabel.Create(FFormMsg);
    lblMsgInfo.Parent           := FFormMsg;
    lblMsgInfo.Font.Size        := 12;
    lblMsgInfo.Alignment        := TAlignment.taCenter;
    lblMsgInfo.AutoSize         := False;
    lblMsgInfo.WordWrap         := True;
    lblMsgInfo.Top              := 10;
    lblMsgInfo.Height           := 75;
    lblMsgInfo.Caption          := msgInfo;
    lblMsgInfo.Left             := 10;
    lblMsgInfo.Width            := FFormMsg.ClientWidth - 20;

    lblMsgLink                  := TLabel.Create(FFormMsg);
    lblMsgLink.Parent           := FFormMsg;
    lblMsgLink.Font.Size        := 10;
    lblMsgLink.Alignment        := TAlignment.taCenter;
    lblMsgLink.AutoSize         := False;
    lblMsgLink.OnClick          := pClickLabel;
    lblMsgLink.Font.Color       := clBlue;
    lblMsgLink.Font.Style       := [fsUnderline];
    lblMsgLink.Cursor           := crHandPoint;
    lblMsgLink.Width            := FFormMsg.ClientWidth - 20;
    lblMsgLink.Height           := 20;
    lblMsgLink.Top              := lblMsgInfo.Top + lblMsgInfo.Height;
    lblMsgLink.Left             := 10;
    lblMsgLink.Caption          := urlEasyFix;

    lblMsgInfo2                  := TLabel.Create(FFormMsg);
    lblMsgInfo2.Parent           := FFormMsg;
    lblMsgInfo2.Font.Size        := 12;
    lblMsgInfo2.Alignment        := TAlignment.taCenter;
    lblMsgInfo2.AutoSize         := False;
    lblMsgInfo2.WordWrap         := True;
    lblMsgInfo2.Width            := FFormMsg.ClientWidth - 20;
    lblMsgInfo2.Height           := 25;
    lblMsgInfo2.Top              := lblMsgLink.Top + lblMsgLink.Height;
    lblMsgInfo2.Left             := 10;
    lblMsgInfo2.Caption          := msgInfo2;

    btnOk                       := TBitBtnLocked.Create(FFormMsg);
    btnOk.Parent                := FFormMsg;
    btnOk.Font.Size             := 10;
    btnOk.Caption               := 'OK';
    btnOk.Cursor                := crHandPoint;
    btnOk.OnClick               := pClickBotao;
    btnOk.Width                 := 300;
    btnOk.Height                := 25;
    btnOk.Top                   := lblMsgInfo2.Top + lblMsgInfo2.Height + 5 ;
    btnOk.Left                  := Trunc((FFormMsg.ClientWidth / 2) - (btnOk.Width / 2));

    FFormMsg.ShowModal;
  finally
    pFreeAndNil(FFormMsg);
  end;
end;

function TConsultaDadosScopeEnvio.RetornaChaveBasic(AClientID,
  AClientSecret: String): String;
Var
  LBase64: TBase64Encoding;
begin
  Result := '';

  If AClientID.IsEmpty Then
    Exit;

  If AClientSecret.IsEmpty Then
    Exit;

  Try
    LBase64 := TBase64Encoding.Create(0);

    Result := 'Basic ' + LBase64.Encode(AClientID + ':' + AClientSecret);
  Finally
    FreeAndNil(LBase64);
  End;
end;

end.
