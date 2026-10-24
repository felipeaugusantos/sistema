unit NfeApiWSBean;

interface

uses
{$IF Defined(LINUX)}
{$ELSE}
  Forms, Windows, ActiveX, untWorkStationInfo,
{$IFEND}
  EncdDecd,
{$IF RTLVersion >= 28}
  NetEncoding,
{$IFEND}
  Types, XSBuiltIns, Classes, StrUtils, SOAPHTTPTrans,
  OPToSOAPDomConv, XMLDoc, XMLIntf, SysUtils, untConfigNFE,
  untHttpTypes, untDicSis;

Const
  FIT_COMANDO_CONS_SIT = 'FIT_NFE_CONSULTA_ID_NOTA_FISCAL';
  FIT_SERVICO_WS_NFEENVIARECEBEDADOS = 'NfeEnviaRecebeDados';
  FIT_SERVICO_WS_NFERECEBEDANFE = 'NfeRecebeDanfe';

type

  TAfterExecute = function(SOAPResponse: WideString): WideString of object;

  TNfeApiWS = class
    private
      fOnAfterExecute: TAfterExecute;
      FstrUrl: String;
      FstrNms: String;
      FmodeEnvSoap: TmodeEnvSoap;
      function fMontaRetornaEnvelope(const servico, nr_licenca: WideString; const nm_usuario: WideString; const nm_senha: WideString; const nm_servico: WideString; const dados: WideString): WideString;
      function fDecodeBase64ToByteDynArray(const strBase64: AnsiString): TByteDynArray;
      procedure pLevantaExcecao(intRespHttp: Integer; strResponse, strExcecao_: WideString);
      function fIsXml(const strCmd: WideString): Boolean;
    public
      constructor Create(strUrl: String; fOnAfterExecute: TAfterExecute; AmodeEnvSoap: TmodeEnvSoap);
      destructor Destroy; override;
      function NfeEnviaRecebeDados(const nr_licenca: WideString; const nm_usuario: WideString; const nm_senha: WideString; const nm_servico: WideString; const dados: WideString): WideString; stdcall;
      function NfeRecebeDanfe(const nr_licenca: WideString; const nm_usuario: WideString; const nm_senha: WideString; const nm_servico: WideString; const dados: WideString): TByteDynArray; stdcall;
  end;

  TWSNfeFitRetorno = class(TInterfacedObject, IInterface)
    private
      FRetornoOk: Boolean;
      FTexto: String;
    public
      constructor Create(blnRetornoOk: Boolean; strTexto: String);
      function RetornoOk: Boolean;
      function Texto: String;
  end;

  TWSNFeFitWrapper = class(TObject)
    private
      WSFit: TNfeApiWS;
      FLicenca: String;
      FUsuario: String;
      FSenha: String;
      FUltimoRetorno: String;
      FUrlAlternativa: String;
      FmodeEnvSoap: TmodeEnvSoap;

      procedure pCarregaWsFit;
      function fComunicaWebService(AComando, ATexto: String; ALocal: String=''): TWSNfeFitRetorno;
      function fComunicaWebServiceInterna(AComando, ATexto, ALocal: String): TWSNfeFitRetorno;
      function OnAfterExecute(SOAPResponse: WideString): WideString;
      function fEscapeXml(AXml: String): String;

    public
      constructor Create;
      destructor Destroy; override;
      procedure pSetaConfiguracoes(objCfgNFE: TConfiguracoesNFE; objCfgProxy: TConfiguracaoProxy);
      function fConsultaSituacaoId(ANumDoc, ASerie, ACodEmp: String): TWSNfeFitRetorno; overload;
      function fConsultaSituacaoId(strIdNota: String): TWSNfeFitRetorno; overload;
      function fDownloadXml(AAcesso, AIdNota, ANumDoc, AEspDoc: String):String;
      property strUltimoRetorno: String Read FUltimoRetorno;
      property strUrlAlternativa: String Read FUrlAlternativa Write FUrlAlternativa;
      property modeEnvSoap: TmodeEnvSoap Read FmodeEnvSoap Write FmodeEnvSoap;
  end;

  function GetNfeApiWS(strUrl: string=''; OnAfterExecute: TAfterExecute=Nil; AmodeEnvSoap: TmodeEnvSoap=modeOpen): TNfeApiWS;
  function fGetModeEnvSoap(strValCfg: String): TmodeEnvSoap;
  function fStringToModeEnvSoap(strMode: String): TmodeEnvSoap;
  function fModeEnvSoapToString(AmodeEnvSoap: TmodeEnvSoap): String;
  function fErroPassivelReenvio(strExcept: String): Boolean;

  var
    objConfig: TConfiguracoesNFE;
    objConfigProxy: TConfiguracaoProxy;

implementation

uses untUtil, untExecuteSoapWithMode;

function GetNfeApiWS(strUrl: string=''; OnAfterExecute: TAfterExecute=Nil; AmodeEnvSoap: TmodeEnvSoap=modeOpen): TNfeApiWS;
begin
  Result := TNfeApiWS.Create(strUrl, OnAfterExecute, AmodeEnvSoap);
end;

function fGetModeEnvSoap(strValCfg: String): TmodeEnvSoap;
  Var
    stlModEnvLoc : TStringList;
    strNomeMaqui : String;
    strValLinArq : String;
    intIdx: Integer;
    modeEnvArq: TmodeEnvSoap;
    blnExisteLinhaIdentificadora: Boolean;
    blnUsaMetodoPersonalizado: Boolean;

    function fLinhaIdentificadoraMetodoEnvio: Boolean;
    begin
      Result := (fStringToModeEnvSoap(strValLinArq) In [modeOpen, modeHttp, modeOpAp]);
    end;

begin
  Result := modeOpen;
  If (strValCfg = cnstOpen) Then
    Result := modeOpen
  Else If (strValCfg = cnstHttp) Then
    Result := modeHttp
  Else If (strValCfg = cnstOpAp) Then
    Result := modeOpAp;

  //VERIFICA SE DETERMINADA MÁQUINA ESTÁ CONFIGURADA PARA USAR MÉTODO DE ENVIO PRÓPRIO (IGNORA A CFG_MDEVAR)
  If FileExists(cnstArqModEnvSoap) Then
  Begin
    Try
    {$IF Defined(LINUX)}
      strNomeMaqui := GetComputerNetName;
    {$ELSE}
      strNomeMaqui := TWorkStationInfo.fGetWorkstationID;
    {$IFEND}
      pLogImp('Iniciando fGetModeEnvSoap() > Identificação de envio definido em arquivo.');
      pLogImp('Arquivo...: '+ExtractFilePath(ParamStr(0))+AnsiReplaceStr(cnstArqModEnvSoap,'.\',''));
      pLogImp('Máquina...: '+strNomeMaqui);
      stlModEnvLoc := TStringList.Create;
      stlModEnvLoc.LoadFromFile(cnstArqModEnvSoap);
      modeEnvArq := modeNull;
      blnExisteLinhaIdentificadora := False;
      blnUsaMetodoPersonalizado := False;
      Try
        For intIdx := 0 To stlModEnvLoc.Count-1 Do
        Begin
          strValLinArq := Trim(stlModEnvLoc[intIdx]);

          If (fLinhaIdentificadoraMetodoEnvio) Then
          Begin
            modeEnvArq := fStringToModeEnvSoap(strValLinArq);
            blnExisteLinhaIdentificadora := True;
          End;

          If (blnExisteLinhaIdentificadora) Then
          Begin
            If (Not fLinhaIdentificadoraMetodoEnvio) And (Not fEmptyStr(strValLinArq)) Then
            Begin
              If (strNomeMaqui = strValLinArq) Then
              Begin
                blnUsaMetodoPersonalizado := True;
                Result := modeEnvArq;
                Break;
              End;
            End;
          End;
        End;
      Finally
        FreeAndNil(stlModEnvLoc);
        If blnUsaMetodoPersonalizado Then
          pLogImp('Finalizando fGetModeEnvSoap < ' + strNomeMaqui + ' usa método de envio definido em '+cnstArqModEnvSoap+': '+fModeEnvSoapToString(Result))
        Else
          pLogImp('Finalizando fGetModeEnvSoap < ' + strNomeMaqui + ' usa método de envio da CFG_MDEVAR: '+fModeEnvSoapToString(Result));
      End;
    Except
      Result := modeOpen;
    End;
  End;
end;

function fModeEnvSoapToString(AmodeEnvSoap: TmodeEnvSoap): String;
begin
  Case AmodeEnvSoap Of
    modeOpen: Result := '[modeOpen]';
    modeHttp: Result := '[modeHttp]';
    modeOpAp: Result := '[modeOpAp]';
    modeNull: Result := '[modeNull]';
  End;
end;

function fStringToModeEnvSoap(strMode: String): TmodeEnvSoap;
begin
  Result := modeNull;
  If (strMode = '[modeOpen]') Then
    Result := modeOpen
  Else If (strMode = '[modeHttp]') Then
    Result := modeHttp
  Else If (strMode = '[modeOpAp]') Then
    Result := modeOpAp;
end;

function fErroPassivelReenvio(strExcept: String): Boolean;

   function fEhErroTratavel: Boolean;
   begin
     Result := False;

     //REPRODUZIR CONDIÇÃO QUE RESULTARÁ TRUE NA FUNÇÃO DE MESMO NOME DENTRO DO AUTCOM
     If (Pos('falha na', strExcept) > 0) Then
     Begin
       Result := (Pos('libeay32.dll', strExcept) > 0) Or
                 (Pos('ssl library', strExcept) > 0) Or
                 (Pos('http/1.1 502 bad gateway', strExcept) > 0) Or
                 (Pos('http/1.1 504 gateway time-out', strExcept) > 0) Or
                 (Pos('connect timed out', strExcept) > 0) Or
                 (Pos('connection timed out', strExcept) > 0);
     End;
   end;

begin
  Result := True;
  strExcept := AnsiLowerCase(strExcept);
  If (fEhErroTratavel) Then
  Begin
    Result := False;
  End;
end;

{ TWSNfeFitRetorno }

constructor TWSNfeFitRetorno.Create(blnRetornoOk: Boolean; strTexto: String);
begin
  FRetornoOk := blnRetornoOk;
  FTexto := strTexto;
end;

function TWSNfeFitRetorno.RetornoOk: Boolean;
begin
  Result := FRetornoOk;
end;

function TWSNfeFitRetorno.Texto: String;
begin
  Result := FTexto;
end;

{ TWSNFeFitWrapper }

constructor TWSNFeFitWrapper.Create;
begin
  Self.WSFit := Nil;
  Self.FUrlAlternativa := '';
  Self.FmodeEnvSoap := modeOpen;
end;

destructor TWSNFeFitWrapper.Destroy;
begin
  If Assigned(Self.WSFit) Then
    FreeAndNil(Self.WSFit);

  inherited;
end;

procedure TWSNFeFitWrapper.pCarregaWsFit;
Var
  LUrl: String;
begin
  If Not Assigned(WSFit) Then
  Begin
    LUrl := objConfig.strFitUrlWebService;

    If Not fEmptyStr(strUrlAlternativa) Then
      LUrl := strUrlAlternativa;

    pLogImp('pCarregaWsFit > LUrl = ' + LUrl);

    WSFit := GetNfeApiWS(LUrl, OnAfterExecute, FmodeEnvSoap);

    Self.FLicenca := objConfig.strFitLicenca;
    Self.FUsuario := objConfig.strFitUsuario;
    Self.FSenha   := objConfig.strFitSenha;
  End;
end;

function TWSNFeFitWrapper.fComunicaWebService(AComando, ATexto: String; ALocal: String=''): TWSNfeFitRetorno;
begin
  pCarregaWsFit;
  Try
    Result := fComunicaWebServiceInterna(AComando, ATexto, ALocal);
  Except
    On E: ESOAPDomConvertError Do
    Begin
      Raise;
    End;
  End;
end;

function TWSNFeFitWrapper.fComunicaWebServiceInterna(AComando, ATexto, ALocal: String): TWSNfeFitRetorno;
Var
  LRetorno: String;

  procedure pEnviaRecebeDadosLocal;
  begin
    LRetorno := WSFit.NfeEnviaRecebeDados(FLicenca, FUsuario, FSenha, AComando, ATexto);

    Result := TWSNfeFitRetorno.Create(True, LRetorno);
  end;

begin
  pLogImp('Iniciando TWSNFeFitWrapper.fComunicaWebServiceInterna');
  Try
    pLogImp('pEnviaRecebeDadosLocal');
    pEnviaRecebeDadosLocal;
    pLogImp('Finalizando TWSNFeFitWrapper.fComunicaWebServiceInterna');
  Except
    On E: ESOAPHTTPException Do
    Begin
      If fErroPassivelReenvio(E.Message) Then
      Begin
        Sleep(2000);
        pLogImp('TWSNFeFitWrapper.fComunicaWebServiceInterna > (E: ESOAPHTTPException) > '+ E.Message);
        pLogImp('pEnviaRecebeDadosLocal * ');
        pEnviaRecebeDadosLocal;
      End
      Else
      Begin
        Raise;
      End;
    End;

    On E: EAccessViolation Do
    Begin
      pLogImp('TWSNFeFitWrapper.fComunicaWebServiceInterna > (E: EAccessViolation) > '+ E.Message);
      If (Pos('dhcpcsvc', E.Message) > 0) Or
         (Pos('netprofm', E.Message) > 0) Or
         (Pos('mswsock' , E.Message) > 0) Or
         (Pos('rtutils' , E.Message) > 0) Or
         (Pos('fwpuclnt', E.Message) > 0) Then
      Begin
        Sleep(5000);
        pLogImp('pEnviaRecebeDadosLocal * ');
        pEnviaRecebeDadosLocal;
      End
      Else
      Begin
        Raise;
      End;
    End;

    On E: Exception Do
    Begin
      pLogImp('TWSNFeFitWrapper.fComunicaWebServiceInterna > (E: Exception) > '+ E.Message);
      If (Pos('unqualified', LowerCase(E.Message)) > 0) Or
         (Pos('client fault', LowerCase(E.Message)) > 0) Then
      Begin
        Sleep(5000);
        pLogImp('pEnviaRecebeDadosLocal * ');
        pEnviaRecebeDadosLocal;
      End
      Else
      Begin
        Raise;
      End;
    End;
  End;
end;

function TWSNFeFitWrapper.OnAfterExecute(SOAPResponse: WideString): WideString;
Var
  LXmlDoc: IXMLDocument;
  Lretornos: IXMLNodeList;
  LContador: Integer;

  LXml: String;
  LPos: Integer;
begin
  FUltimoRetorno := '';

  LXmlDoc := TXMLDocument.Create(nil);
  Try
    Try
      LXmlDoc.LoadFromXML(SOAPResponse);
      LXmlDoc.Active := True;

      Lretornos := LXmlDoc.Node.ChildNodes[0].ChildNodes[1].ChildNodes[0].ChildNodes;

      If Lretornos.Count > 0 Then
      Begin
        FUltimoRetorno := Lretornos[0].Text;
        For LContador := 1 To Lretornos.Count -1 Do
        Begin
          FUltimoRetorno := FUltimoRetorno + #13#10 + Lretornos[LContador].Text;
        End;
      End;
    Except
      Try
        LXml := SOAPResponse;;

        LPos := Pos('<return>', LXml);
        LXml := Copy(LXml, LPos+Length('<return>'), Length(LXml));

        LPos := Pos('</return>', LXml);
        LXml := Copy(LXml, 1, LPos-1);

        FUltimoRetorno := fEscapeXml(LXml);
      Except
        //
      End;
    End;
  Finally
    Result := FUltimoRetorno;
  End;
end;

function TWSNFeFitWrapper.fEscapeXml(AXml: String): String;
begin
  Result := AnsiReplaceStr(AXml,   '&lt;', '<');
  Result := AnsiReplaceStr(Result, '&quot;', '"');
  Result := AnsiReplaceStr(Result, '&gt;', '>');
end;

function TWSNFeFitWrapper.fConsultaSituacaoId(ANumDoc, ASerie, ACodEmp: String): TWSNfeFitRetorno;
begin
  Result := fComunicaWebService(FIT_COMANDO_CONS_SIT, ACodEmp+fStrZero(ANumDoc,9)+ASerie);

  If (Pos('Processando/Transmitindo', Result.Texto) > 0) Then
  Begin
    Sleep(5000);
    Result := fComunicaWebService(FIT_COMANDO_CONS_SIT, ACodEmp+fStrZero(ANumDoc,9)+ASerie);
  End;
end;

function TWSNFeFitWrapper.fConsultaSituacaoId(strIdNota: String): TWSNfeFitRetorno;
begin
  Result := fComunicaWebService(FIT_COMANDO_CONS_SIT, strIdNota);
end;

function TWSNFeFitWrapper.fDownloadXml(AAcesso, AIdNota, ANumDoc, AEspDoc: String):String;
Var
  retornoFit: TWSNfeFitRetorno;
begin
  if not (Assigned(objConfig)) then
    Exit;

  pCarregaWsFit;

  if (AEspDoc = 'NS') then
  begin
    retornoFit := fComunicaWebService('FIT_NFE_RECEBE_XML_NFSE_ID_NOTA_FISCAL', AIdNota, 'DOWNLOAD XML');
  end

  else IF (AEspDoc = 'IF') then
  begin
    retornoFit := fComunicaWebService('FIT_NFE_RECEBE_XML_CHAVE_ACESSO', AAcesso, 'DOWNLOAD XML');
  end

  else
  begin
    retornoFit := fComunicaWebService('FIT_NFE_RECEBE_XML_ID_NOTA_FISCAL', AIdNota, 'DOWNLOAD XML');
  end;

  If retornoFit.RetornoOk Then
  Begin
    Result := strUltimoRetorno ;
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit)
end;

procedure TWSNFeFitWrapper.pSetaConfiguracoes(objCfgNFE: TConfiguracoesNFE; objCfgProxy: TConfiguracaoProxy);
begin
  objConfig      := objCfgNFE;
  objConfigProxy := objCfgProxy;
end;

//Atenção: NfeApiWSBean existe em libNefe.dll e NFeImpressao.exe então, ao mudar algo na classe TNfeApiWS, alterar em ambos projetos!

{ TNfeApiWS }

constructor TNfeApiWS.Create(strUrl: String; fOnAfterExecute: TAfterExecute; AmodeEnvSoap: TmodeEnvSoap);
begin
  Self.fOnAfterExecute := fOnAfterExecute;
  Self.FstrUrl := strUrl;
  Self.FstrNms := 'http://server.api.ws.nfe.fitsistemas.com.br/';
  If Pos('citel.com.br', AnsiLowerCase(Self.FstrUrl)) > 0 Then
    Self.FstrNms := 'https://'+fExtraiHostDaUrl(Self.FstrUrl)+'/';
  Self.FmodeEnvSoap := AmodeEnvSoap;
end;

destructor TNfeApiWS.Destroy;
begin

  inherited;
end;

function TNfeApiWS.fMontaRetornaEnvelope(const servico, nr_licenca, nm_usuario, nm_senha,
  nm_servico, dados: WideString): WideString;
  Var
    LTeor: WideString;
begin
  LTeor := dados;

  If fIsXml(LTeor) Then
    LTeor := '<![CDATA['+LTeor+']]>';

  Result :=
    '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="'+FstrNms+'">'+
    '   <soapenv:Header/>'+
    '   <soapenv:Body>'+
    '      <ser:'+servico+'>'+
    '         <nr_licenca>'+nr_licenca+'</nr_licenca>'+
    '         <nm_usuario>'+nm_usuario+'</nm_usuario>'+
    '         <nm_senha>'+nm_senha+'</nm_senha>'+
    '         <nm_servico>'+nm_servico+'</nm_servico>'+
    '         <dados>'+LTeor+'</dados>'+
    '      </ser:'+servico+'>'+
    '   </soapenv:Body>'+
    '</soapenv:Envelope>';
end;

function TNfeApiWS.fDecodeBase64ToByteDynArray(const strBase64: AnsiString): TByteDynArray;
  Var
    {$IF RTLVersion >= 27}
    mmsArquivo: TBytesStream;
    {$ELSE}
    mmsArquivo: TStringStream;
    {$IFEND}
begin
  If (strBase64 = '') Then
    Raise ESOAPDomConvertError.Create('String base64 vazia');

  Try
    {$IF RTLVersion >= 27}
    mmsArquivo := TBytesStream.Create(DecodeBase64(strBase64));
    {$ELSE}
    mmsArquivo := TStringStream.Create(DecodeString(strBase64));
    {$IFEND}
    Try
      mmsArquivo.Position := 0;
      SetLength(Result, mmsArquivo.Size);
      mmsArquivo.Read(Result[0], mmsArquivo.Size);
    Finally
      mmsArquivo.Free;
    End;
  Except
    On E: Exception Do
      Raise ESOAPDomConvertError.Create('Erro na conversão da string base64 '+E.Message);
  End;
end;

procedure TNfeApiWS.pLevantaExcecao(intRespHttp: Integer; strResponse, strExcecao_: WideString);
begin
  If (intRespHttp >= 200) And (intRespHttp <= 299) Then
  Begin
    If (Pos('envelope', LowerCase(strResponse)) = 0) Then
    Begin
      Raise ESOAPHTTPException.Create('Não encontrado conteúdo SOAP na resposta');
    End;
  End
  Else If (intRespHttp = 0) Or (intRespHttp >= 500) Or (strExcecao_ <> '') Then
  Begin
    pLogImp('pLevantaExcecao > intRespHttp: '+IntToStr(intRespHttp) + ' - strResponse: ' + strResponse + ' - strExcecao_: ' + strExcecao_);
    Raise ESOAPHTTPException.Create('Falha na conexão HTTP - Exceção: '+strExcecao_)
  End;
end;

function TNfeApiWS.fIsXml(const strCmd: WideString): Boolean;
 Var
  aXMLDoc: IXMLDocument;
begin
  Result := False;
  If (Pos('<',strCmd) > 0) Then
  Begin
    pLogImp('fIsXml('+strCmd+')');
    aXmlDoc := TXMLDocument.Create(nil);
    aXmlDoc.ParseOptions := [poValidateOnParse, poResolveExternals];

    Try
      aXmlDoc.LoadFromXML(strCmd);
      Result := True;
      pLogImp('fIsXml = Sim');
    Except
      pLogImp('fIsXml = Não');
    End;
  End;
end;

function TNfeApiWS.NfeEnviaRecebeDados(const nr_licenca, nm_usuario, nm_senha,
  nm_servico, dados: WideString): WideString;
  Var
    strEnvelope: WideString;
    strResponse: WideString;
    strExcecao_: WideString;
    intRespHttp: Integer;
begin
  Try
    strEnvelope := fMontaRetornaEnvelope(FIT_SERVICO_WS_NFEENVIARECEBEDADOS, nr_licenca, nm_usuario, nm_senha, nm_servico, dados);

    pLogImp('Env > fExecuteSoapWithMode: '+fModeEnvSoapToString(FmodeEnvSoap)+' '+nm_servico+' '+strEnvelope);

    intRespHttp := fExecuteSoapWithMode(Self.FstrUrl,
                                        TLS12,
                                        Self.FmodeEnvSoap,
                                        strEnvelope,
                                        strResponse,
                                        strExcecao_);

    pLogImp('Ret < fExecuteSoapWithMode: '+nm_servico+' ['+'HTTPCode: '+IntToStr(intRespHttp)+'] '+strResponse);

    pLevantaExcecao(intRespHttp, strResponse, strExcecao_);

    Result := Self.fOnAfterExecute(strResponse);
  Except
    On E: Exception Do
    Begin
      pLogImp('Exception - fExecuteSoapWithMode: '+E.Message);
      Raise;
    End;
  End;
end;

function TNfeApiWS.NfeRecebeDanfe(const nr_licenca, nm_usuario, nm_senha,
  nm_servico, dados: WideString): TByteDynArray;
  Var
    strEnvelope: WideString;
    strResponse: WideString;
    strExcecao_: WideString;
    intRespHttp: Integer;
begin
  Try
    strEnvelope := fMontaRetornaEnvelope(FIT_SERVICO_WS_NFERECEBEDANFE, nr_licenca, nm_usuario, nm_senha, nm_servico, dados);

    pLogImp('Env > fExecuteSoapWithMode: '+fModeEnvSoapToString(FmodeEnvSoap)+' '+nm_servico+' '+strEnvelope);

    intRespHttp := fExecuteSoapWithMode(Self.FstrUrl,
                                        TLS12,
                                        Self.FmodeEnvSoap,
                                        strEnvelope,
                                        strResponse,
                                        strExcecao_);

    pLogImp('Ret < fExecuteSoapWithMode: '+nm_servico+' ['+'HTTPCode: '+IntToStr(intRespHttp)+'] '+strResponse);

    pLevantaExcecao(intRespHttp, strResponse, strExcecao_);

    Result := fDecodeBase64ToByteDynArray(AnsiString(Self.fOnAfterExecute(strResponse)));
  Except
    On E: Exception Do
    Begin
      pLogImp('Exception - fExecuteSoapWithMode: '+E.Message);
      Raise;
    End;
  End;
end;

initialization
{$IF not Defined(LINUX)}
  CoInitialize(Nil);
{$IFEND}

finalization
{$IF not Defined(LINUX)}
  CoUninitialize;
{$IFEND}

end.
