unit NfeApiEnotas;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Printers, Dialogs, Messages, ActiveX, Forms, ShellApi, Windows,
{$ENDIF}
  InvokeRegistry,  Types, Classes, DateUtils, StrUtils, untInterfaces;

type

  TMetodo = (mGet, mPost, mDelete);

  type
    TNfeApiWS = class
    private
      FDownloadDeArquivo: Boolean;
      FlibApiRest: Cardinal;
      fExecuteAuth:       function(AMetodo, AUrl, AJsonEnvio, AToken: WideString; out AJsonRetorno: WideString): Integer; stdcall;
      fExecuteAuthProxy:  function(AMetodo, AUrl, AJsonEnvio, AToken, AProxyServer, AProxyPort, AProxyUsername, AProxyPassword, AProxyAtivado: WideString; out AJsonRetorno: WideString): Integer; stdcall;
      fGetJsonValue:      function(AJsonString, AChave: WideString): WideString; stdcall;
      fGetJsonArrayValue: function(AJsonString, AChaveArr, AChave: WideString; AIndex: Integer): WideString; stdcall;

      function fEhDownloadDeArquivo(strComando: String): Boolean;
      function fEhMetadados(strJsonString: WideString): Boolean;
      function fEhRetornoDeArquivo(strJsonString: WideString): Boolean;
      function fParseResponse(const Metodo: TMetodo; const intStatus: Integer; strJsonString: WideString): TRetornoEnotas;
    public
      constructor Create;
      destructor Destroy; override;
      function NfeEnviaRecebeDados(strApiKey: WideString; Metodo: TMetodo; strComando, strJson,
                                   strProxyServer, strProxyPort, strProxyUsername, strProxyPassword, strProxyAtivado: WideString): TRetornoEnotas;
    end;

  TWSNFeEnotas = class;

  IMetodoImpressao = interface(IInterface)
    function fComandoWebService: String;
    function fExtensaoArquivo: String;
    function fPrefixoArquivo: String;
    procedure pImprimeArquivo(strArquivo, strImpressora: String);
  end;

  TImpressaoDiretaCitel = class
  public
    class procedure pImprimir(strCodigoEmpresa, strImpressora, strAcesso, strTipo: String; blnReimpressao: Boolean = false);
  end;

  TImpressaoIntegradorLocal = class(TInterfacedObject, IInterface)
    private
      strIntegrador: String;
      strImpressora: String;
      EnotasWrapper: TWSNFeEnotas;
    public
      constructor Create(EnotasWrapper: TWSNFeEnotas; strIntegrador, strImpressora: String);
  end;

  TMetodoImpressaoFactory = class(TInterfacedObject, IInterface)
    class function fCriarNotaFiscal(strPrefixo: String): IMetodoImpressao;
    class function fCriarCartaCorrecao(strPrefixo: String): IMetodoImpressao;
    class function fCriarNotaServico(strPrefixo: String): IMetodoImpressao;
    class function fCriarManifesto: IMetodoImpressao;
    class function fCriarConhecimento(strForcarImpressaoPDF: String = 'N'): IMetodoImpressao;
  end;

  TWSNfeEnotasRetorno = class(TInterfacedObject, IInterface)
    private
      FRetornoOk: Boolean;
      FTexto: String;
    public
      constructor Create(blnRetornoOk: Boolean; strTexto: String);
      function RetornoOk: Boolean;
      function Texto: String;
  end;

  TWSNFeEnotas = class(TObject)
    private
      WSEnotas: TNfeApiWS;
      strApiKey: String;
      strIdEmpresa: String;
      FUltimoRetorno: String;
      FOffLine: Boolean;
      strArquivoPDFtoPrinter: String;
      FProxyAtivado: String;
      FProxyServer: String;
      FProxyPort: String;
      FProxyUsername: String;
      FProxyPassword: String;

      function fComunicaWebService(Metodo: TMetodo; strComando, strJson: String): TWSNfeEnotasRetorno;
      function fComunicaWebServiceInterna(Metodo: TMetodo; strComando, strJson: String): TWSNfeEnotasRetorno;
      function fRetornaApiKey(fonteDados: IFonteDados): String;
      function fRetNomeArquivoPDFtoPrinter: String;
      function fCarregaPDF(fonteDados: IFonteDados; strAcesso: String; AIgnorarLayoutSimplificado: Boolean):String;
      procedure pDownloadDanfe(fonteDados: IFonteDados; strAcesso, strIdNota, strNumDoc: String);
      procedure pImprimeArquivo(strArquivo, strImpressora: String);
      function fRemoverCaracteresInvalidosXML(const AValue: String): String;
    public
      constructor Create;
      destructor Destroy; override;
      procedure pCarregaConfiguracoesEnotas(fonteDados: IFonteDados);
      function fConsultaSituacaoId(strIdExterno: String): TWSNfeEnotasRetorno;
      function fEnviaNotaFiscal(strJson: String): TWSNfeEnotasRetorno;
      function fCancelaNotaFiscal(strIdExterno: String): TWSNfeEnotasRetorno;
      function fRetXMLNfe(strIdExterno: String): string;
      function fRetornaXMLNfe(strIdExterno: String): TWSNfeEnotasRetorno;
      function fDownloadPDF(strIdExterno: String): TWSNfeEnotasRetorno;
      procedure pDownloadXml(strAcesso, strIdNota, strNumDoc: String; strPathXml: String = 'XMLNFE'; fonteDados: IFonteDados = nil);
      function fDownloadDanfe(strAcesso, strNumDoc, strImpressora: String; intViasServidor: Integer; strIdNota: String; fonteDados: IFonteDados = nil; blnContingencia: Boolean = False; strImprimirTelaPDF: String = ''; AIgnorarLayoutSimplificado: Boolean = False): String;
      property strUltimoRetorno: String Read FUltimoRetorno;
      property blnOffLine: Boolean Read FOffLine Write FOffLine;
  end;

  function fMetodoToString(AMetodo: TMetodo): String;

implementation

uses SysUtils, untUtil, untConfigNFE, untImpressaoDiretaCitel, untConstantesNFe,
     untLogDanfe, untDicSis;

{ TWSNFeEnotas }

constructor TWSNFeEnotas.Create;
begin
  FOffLine := False;
  WSEnotas := TNfeApiWS.Create;
  strArquivoPDFtoPrinter := fRetNomeArquivoPDFtoPrinter;
  pLogEnotas('TWSNFeEnotas.Create');
end;

destructor TWSNFeEnotas.Destroy;
begin
  pLogEnotas('TWSNFeEnotas.Destroy');
  FreeAndNil(WSEnotas);
  inherited;
end;

function TWSNFeEnotas.fRetornaApiKey(fonteDados: IFonteDados): String;
begin
  Result := fCfgSisFonte(fonteDados, 'KEYENO');

  If fConteudoEncriptado(Result) Then
  Begin
    Result := fDecriptar(Result);
  End;
end;

procedure TWSNFeEnotas.pCarregaConfiguracoesEnotas(fonteDados: IFonteDados);
begin
  If Assigned(fonteDados) Then
  Begin
    strApiKey      := fRetornaApiKey(fonteDados);
    strIdEmpresa   := fCfgSisFonte(fonteDados, 'EMPENO');
    FProxyAtivado  := fCfgSisFonte(fonteDados, 'HPXENO');
    FProxyServer   := fCfgSisFonte(fonteDados, 'EPXENO');
    FProxyPort     := fCfgSisFonte(fonteDados, 'PPXENO');
    FProxyUsername := fCfgSisFonte(fonteDados, 'UPXENO');
    FProxyPassword := fCfgSisFonte(fonteDados, 'SPXENO');
    VS_PDFtoPrinterEnotas := fUtilizaPDFtoPrinterNoEnotas(fonteDados);
    VS_PDFtoPrinterQtdeCopias := fPDFToPrinterQuantidadeDeCopias(fonteDados);
  End;
end;

function TWSNFeEnotas.fComunicaWebService(Metodo: TMetodo; strComando, strJson: String): TWSNfeEnotasRetorno;
 Var
   strMsg: String;
   resultValidacao: TResultadoValidacao;
begin
  Try
    Result := fComunicaWebServiceInterna(Metodo, strComando, strJson);
  Except
    On E: Exception Do
    Begin
      strMsg := 'Problema na conexão com WebService ' + #13#10 + E.Message +  #13#10 + 'Tente enviar o documento novamente.';
      resultValidacao := TResultadoValidacao.Create;
      resultValidacao.pAdicionarErro(strMsg, Nil);
      pLogEnotas(strMsg);
      Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
    End;
  End;
end;

function TWSNFeEnotas.fComunicaWebServiceInterna(Metodo: TMetodo; strComando, strJson: String): TWSNfeEnotasRetorno;
Var
  strRetorno: String;
  RetornoEnotas: TRetornoEnotas;
begin
  pLogEnotas('fComunicaWebServiceInterna('''+fMetodoToString(Metodo)+''', '''+strComando+''', '''+strJson+''')');
  Try
    if (not blnOffLine) Then
    Begin
      RetornoEnotas  := WSEnotas.NfeEnviaRecebeDados(strApiKey, Metodo, strComando, strJson, FProxyServer, FProxyPort, FProxyUsername, FProxyPassword, FProxyAtivado);
      strRetorno     := RetornoEnotas.strCodigo+'|'+RetornoEnotas.strMensagem+'|'+RetornoEnotas.strChaveAcesso+'|'+RetornoEnotas.strProtocolo+'|'+RetornoEnotas.strNumRps;
      FUltimoRetorno := RetornoEnotas.strUltimoRetorno;
    end;

    Result := TWSNfeEnotasRetorno.Create(True, strRetorno);

  Except
    On E: Exception Do
    Begin
      Raise ErrosValidacaoNFE.fCriaErroSimples(E.Message);
    End;
  End;
  pLogEnotas('fComunicaWebServiceInterna <');
end;

// https://api.enotasgw.com.br/v1/empresas/{empresaId}/nfes/porIdExterno/{idExterno}
function TWSNFeEnotas.fConsultaSituacaoId(strIdExterno: String): TWSNfeEnotasRetorno;
var
  strComando: String;
begin
  pLogEnotas('fConsultaSituacaoId >');

  strComando := '/empresas/'+strIdEmpresa+'/nfes/porIdExterno/'+strIdExterno;

  Result := fComunicaWebService(mGet, strComando, '');

  pLogENotas('fConsultaSituacaoId <');
end;

// https://api.enotasgw.com.br/v1/empresas/{empresaId}/nfes
function TWSNFeEnotas.fEnviaNotaFiscal(strJson: String): TWSNfeEnotasRetorno;
var
  intStatus: Integer;
  strComando: String;
begin
  pLogEnotas('fEnviaNotaFiscal >');

  strComando := '/empresas/'+strIdEmpresa+'/nfes';

  Result := fComunicaWebService(mPost, strComando, strJson);

  If Result.FRetornoOk Then
  Begin
    intStatus := StrToIntDef(fGetValorLinha(Result.Texto, '|', 1), 0);
    If intStatus = 200 Then
    Begin
      Result := TWSNfeEnotasRetorno.Create(True, Result.Texto);
    End
    Else
    Begin
      Result := TWSNfeEnotasRetorno.Create(False, Result.Texto);
    End;
  End;

  pLogEnotas('fEnviaNotaFiscal <');
end;

// https://api.enotasgw.com.br/v1/empresas/{empresaId}/nfes/porIdExterno/{idExterno}
function TWSNFeEnotas.fCancelaNotaFiscal(strIdExterno: String): TWSNfeEnotasRetorno;
var
  intStatus: Integer;
  strComando: String;
begin
  pLogEnotas('fCancelaNotaFiscal >');

  strComando := '/empresas/'+strIdEmpresa+'/nfes/porIdExterno/'+strIdExterno;

  Result := fComunicaWebService(mDelete, strComando, '');

  If Result.FRetornoOk Then
  Begin
    intStatus := StrToIntDef(fGetValorLinha(Result.Texto, '|', 1), 0);
    If intStatus = 200 Then
    Begin
      Result := TWSNfeEnotasRetorno.Create(True, Result.Texto);
    End
    Else
    Begin
      Result := TWSNfeEnotasRetorno.Create(False, Result.Texto);
    End;
  End;

  pLogEnotas('fCancelaNotaFiscal <');
end;

// https://api.enotasgw.com.br/v1/empresas/{empresaId}/nfes/porIdExterno/{idExterno}/xml
function TWSNFeEnotas.fRetXMLNfe(strIdExterno: String): string;
Var
  strComando: String;
  retornoEnotas: TWSNfeEnotasRetorno;
  resultValidacao: TResultadoValidacao;
  strMsg: String;
begin
  pLogEnotas('fRetXMLNfe >');

  strComando := '/empresas/'+strIdEmpresa+'/nfes/porIdExterno/'+strIdExterno+'/xml';

  retornoEnotas := fComunicaWebService(mGet, strComando, '');

  If retornoEnotas.RetornoOk Then
  Begin
    Result := retornoEnotas.Texto;
  End
  Else
  Begin
    strMsg := 'Não foi possível recuperar o XML  ' + strIdExterno + '. Motivo: ' + retornoEnotas.Texto;
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogEnotas(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  pLogEnotas('fRetXMLNfe <');
End;

// https://api.enotasgw.com.br/v1/empresas/{empresaId}/nfes/porIdExterno/{idExterno}/xml
function TWSNFeEnotas.fRetornaXMLNfe(strIdExterno: String): TWSNfeEnotasRetorno;
Var
  strComando: String;
  resultValidacao: TResultadoValidacao;
  strMsg: String;
begin
  pLogEnotas('fRetornaXMLNfe >');

  strComando := '/empresas/'+strIdEmpresa+'/nfes/porIdExterno/'+strIdExterno+'/xml';

  Result := fComunicaWebService(mGet, strComando, '');

  If not Result.RetornoOk Then
  Begin
    strMsg := 'Não foi possível recuperar o XML  ' + strIdExterno + '. Motivo: ' + result.Texto;
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogEnotas(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  pLogEnotas('fRetornaXMLNfe <');
End;

// https://api.enotasgw.com.br/v1/empresas/{empresaId}/nfes/porIdExterno/{idExterno}/pdf
function TWSNFeEnotas.fDownloadPDF(strIdExterno: String): TWSNfeEnotasRetorno;
Var
  strComando: String;
  resultValidacao: TResultadoValidacao;
  strMsg: String;
begin
  pLogEnotas('fDownloadPDF >');

  strComando := '/empresas/'+strIdEmpresa+'/nfes/porIdExterno/'+strIdExterno+'/pdf';

  Result := fComunicaWebService(mGet, strComando, '');

  If not Result.RetornoOk Then
  Begin
    strMsg := 'Não foi possível recuperar o PDF  ' + strIdExterno + '. Motivo: ' + result.Texto;
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogEnotas(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  pLogEnotas('fDownloadPDF <');
End;

procedure TWSNFeEnotas.pDownloadXml(strAcesso, strIdNota, strNumDoc: String; strPathXml: String = 'XMLNFE'; fonteDados: IFonteDados = nil);
  Var
    retornoEnotas: TWSNfeEnotasRetorno;
    xmlStream: TFileStream;
    intContador: Integer;
    resultValidacao: TResultadoValidacao;
    strMsg: String;
    LImprimeNFeCitel : Boolean;
    LCodigoEmpresa: String;
begin
  pLogEnotas('pDownloadXml >');

  if not (Assigned(fonteDados)) then
  Begin
    pLogEnotas('pDownloadXml < Exit(Not (Assigned(fonteDados)))');
    Exit;
  End;

  LCodigoEmpresa := fonteDados.fDadosGerais.strCodEmp;
  if fEmptyStr(LCodigoEmpresa) then
    LCodigoEmpresa := fonteDados.fGetCampoValor('NFE_CODEMP', 'NFE_ACESSO', strAcesso, 'LOGNFE');
  LImprimeNFeCitel := IIF(fEmptyStr(fCfgSisFonte(fonteDados, 'CITINF')), fCfgSisFonte(fonteDados, 'CITINF', LCodigoEmpresa) = 'S' , fCfgSisFonte(fonteDados, 'CITINF') = 'S');

  if (LImprimeNFeCitel) then
    LImprimeNFeCitel := (fonteDados.fDadosGerais.strEspDoc <> 'NS') or ((fonteDados.fDadosGerais.strEspDoc = 'NS') and (fCfgSisFonte(fonteDados, 'IMPNFS') = 'S'));

  if (fonteDados.fDadosGerais.strEspDoc = 'NS') and
     (fCfgSisFonte(fonteDados, 'NFSCIT', LCodigoEmpresa) = 'S') and
     (Not fEmptyStr(strAcesso)) then
  begin
    pLogEnotas('pDownloadXml < Exit(CFG_NFSCIT = S, não pode fazer download pois o XML é gerado na emissão)');
    Exit;
  end;

  if strPathXml = EmptyStr then
    strPathXml := 'XMLNFE';

  retornoEnotas := fRetornaXMLNfe(strIdNota);

  If retornoEnotas.RetornoOk Then
  Begin
    If (Not fEmptyStr(strAcesso)) Then
      fonteDados.pSalvarXMLNFeBD(strAcesso, fRemoverCaracteresInvalidosXML(strUltimoRetorno));

    If FileExists('nfe.downloadxml') Then
    begin
      strPathXml := fSepDir(fPnlDir('') + strPathXml);
      If Not DirectoryExists(strPathXml) Then
        CreateDir(strPathXml);

      strPathXml := strPathXml + strAcesso + '.xml';
      If FileExists(strPathXml) Then
        DeleteFile(strPathXml);

      xmlStream := TFileStream.Create(strPathXml, fmCreate);
      For intContador := 1 To Length(strUltimoRetorno) Do
      Begin
        xmlStream.Write(strUltimoRetorno[intContador], 1);
      End;
      FreeAndNil(xmlStream);
    end;

    pLogEnotas('pDownloadXml < Exit(retornoEnotas.RetornoOk)');
    Exit;
  End;

  If (not retornoEnotas.RetornoOk) And LImprimeNFeCitel Then
  Begin
    strMsg := 'Não foi possível recuperar o XML na nota ' + strNumDoc + '. Motivo: ' + retornoEnotas.Texto;
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogEnotas(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;
  pLogEnotas('pDownloadXml <');
end;

function TWSNFeEnotas.fCarregaPDF(fonteDados: IFonteDados; strAcesso: String; AIgnorarLayoutSimplificado: Boolean):String;
Var
  LDanfePathPDF: String;
  LDanfeStreamEntrada: TStringStream;
  LDanfeStreamSaida: TFileStream;
Begin
  pLogEnotas('fCarregaPDF >');
  Try
    If fonteDados.PDFJaBaixado(strAcesso) Then
      LDanfePathPDF := fonteDados.CarregarPDF(strAcesso, strAcesso, True, AIgnorarLayoutSimplificado)
    Else
    Begin
      If not fEmptyStr(strUltimoRetorno) Then
      Begin
        pCriarDiretorioDanfeEnotasCasoNaoExista;

        LDanfePathPDF := fDiretorioDanfeEnotas;

        LDanfePathPDF := LDanfePathPDF + strAcesso + '.pdf';

        If FileExists(LDanfePathPDF) Then
          DeleteFile(LDanfePathPDF);

        LDanfeStreamSaida    := TFileStream.Create(LDanfePathPDF, fmCreate);
        LDanfeStreamEntrada  := TStringStream.Create(strUltimoRetorno);
        Try
          LDanfeStreamSaida.CopyFrom(LDanfeStreamEntrada, LDanfeStreamEntrada.Size);
        Finally
          LDanfeStreamSaida.Free;
          LDanfeStreamEntrada.Free;
        End;
      End;
    End;
  Finally
    Result := LDanfePathPDF;
  End;
  pLogEnotas('fCarregaPDF <');
End;

procedure TWSNFeEnotas.pDownloadDanfe(fonteDados: IFonteDados; strAcesso, strIdNota, strNumDoc: String);
Var
  retornoEnotas: TWSNfeEnotasRetorno;
begin
  pLogEnotas('pDownloadDanfe >');
  If (Assigned(fonteDados)) Then
  Begin
    If (Not fonteDados.XMLJaBaixado(strAcesso)) Then
    Begin
      pLogEnotas('XML DOWNLOAD - ' + strAcesso);
      pDownloadXml(strAcesso, strIdNota, strNumDoc, EmptyStr, fonteDados);
    End;

    If not (fCfgSisFonte(fonteDados, 'IMPNFS') = 'S') Then
    Begin
      If (Not fonteDados.PDFJaBaixado(strAcesso)) Then
      Begin
        pLogEnotas('PDF DOWNLOAD - ' + strAcesso);

        retornoEnotas := fDownloadPDF(strIdNota);

        If retornoEnotas.RetornoOk Then
        Begin
          fonteDados.pSalvarPDFNFeBD(strAcesso, strUltimoRetorno);
        End
      End;
    End;
  End;
  pLogEnotas('pDownloadDanfe <');
end;

function TWSNFeEnotas.fDownloadDanfe(strAcesso, strNumDoc, strImpressora: String;
  intViasServidor: Integer; strIdNota: String; fonteDados: IFonteDados = nil;
  blnContingencia: Boolean = False; strImprimirTelaPDF: String = ''; AIgnorarLayoutSimplificado: Boolean = False): String;

Var
  LImprimeNFeCitel : Boolean;
  LCodigoEmpresa: String;
  blnReimpressao : boolean;
  LDanfePathPDF: String;

  function fImprimirTelaPDFouPDF: Boolean;
  begin
    Result := False;

    If (strImprimirTelaPDF = 'TelaPDF') Then
    Begin
      Result := True;
      Exit;
    End;

    If (strImprimirTelaPDF = 'PDF') Then
    Begin
      Result := True;
      Exit;
    End;
  end;

begin
  pLogEnotas('fDownloadDanfe >');

  LImprimeNFeCitel := False;

  If fEmptyStr(strIdNota) Then
  Begin
    strIdNota := strAcesso;
  End;

  if Assigned(fonteDados) then
  begin
    LCodigoEmpresa := fonteDados.fDadosGerais.strCodEmp;
    If fEmptyStr(LCodigoEmpresa) Then
      LCodigoEmpresa := fonteDados.fGetCampoValor('NFE_CODEMP', 'NFE_ACESSO', strAcesso, 'LOGNFE');

    LImprimeNFeCitel := IIF(fEmptyStr(fCfgSisFonte(fonteDados, 'CITINF')), fCfgSisFonte(fonteDados, 'CITINF', LCodigoEmpresa) = 'S' , fCfgSisFonte(fonteDados, 'CITINF') = 'S');

    if LImprimeNFeCitel then
      LImprimeNFeCitel := (fCfgSisFonte(fonteDados, 'IMPNFS') = 'S');
  end;

  if (not fImprimirTelaPDFouPDF) and (not blnContingencia) and (not fEmptyStr(strAcesso)) then
  begin
    pDownloadDanfe(fonteDados, strAcesso, strIdNota, strNumDoc);
  end;

  if (fImprimirTelaPDFouPDF) then
  begin
    LDanfePathPDF := fCarregaPDF(fonteDados, strAcesso, AIgnorarLayoutSimplificado);
    If (not fEmptyStr(LDanfePathPDF)) And (strImprimirTelaPDF = 'TelaPDF') Then
      pImprimeArquivo(LDanfePathPDF, 'ImpressaoEmTelaPDF');

    pLogEnotas('fDownloadDanfe < Exit = fImprimirTelaPDFouPDF');
    Exit;
  end;

  if (not fImprimirTelaPDFouPDF) and (not blnContingencia) then
  begin
    If LImprimeNFeCitel Then
    Begin
      blnReimpressao := intViasServidor > 0;

      pLogEnotas('IMPRESSAO DIRETA CITEL - ' + strImpressora);

      TImpressaoDiretaCitel.pImprimir(LCodigoEmpresa, strImpressora, strAcesso, 'NFS', blnReimpressao);
    End
    Else
    Begin
      LDanfePathPDF := fCarregaPDF(fonteDados, strAcesso, AIgnorarLayoutSimplificado);

      If not fEmptyStr(LDanfePathPDF) Then
        pImprimeArquivo(LDanfePathPDF, strImpressora);
    End;
  end;

  Result := LDanfePathPDF;
  pLogEnotas('fDownloadDanfe < Result = ' + Result);
end;

function TWSNFeEnotas.fRemoverCaracteresInvalidosXML(const AValue: String): String;
begin
  Result := AValue;

  If (StartsStr('"', Result)) And (EndsStr('"', Result)) Then
  Begin
    Result := Copy(Result, 2, Length(Result));
    Result := Copy(Result, 1, Pred(Length(Result)));
  End;

  Result := AnsiReplaceStr(Result, '\', '');
end;

function TWSNFeEnotas.fRetNomeArquivoPDFtoPrinter: String;
begin
  Result := 'c:' + PATH_SEPARATOR + 'NFEPRINTER' + PATH_SEPARATOR + 'PDFtoPrinter.exe';
  If Not FileExists(Result) Then
  Begin
    Result := ExtractFilePath(Application.ExeName) + PATH_SEPARATOR + 'PDFtoPrinter.exe';
  End;
end;

procedure TWSNFeEnotas.pImprimeArquivo(strArquivo, strImpressora: String);
{$IFDEF LINUX}
begin
  raise Exception.Create('TWSNFeEnotas.pImprimeArquivo ainda não possui implementação linux');
end;
{$ELSE}
  Var
    strCMD: String;
begin
  pLogEnotas('pImprimeArquivo > '+strImpressora);

  If (Not fEhParaImprimir(strImpressora)) Then
  begin
    DeleteFile(strArquivo);
    pLogEnotas('pImprimeArquivo < Exit = '+UpperCase(strImpressora));
    Exit;
  end;

  If fEmptyStr(strImpressora) Or (Pos('>>',strImpressora) > 0) Then
  Begin
    Try
      strImpressora := Printer.Printers[Printer.PrinterIndex];
    Except
      On E: Exception Do
      Begin
        pLogEnotas('ERRO AO LOCALIZAR A IMPRESSORA: ' + E.Message);
        DeleteFile(strArquivo);
        Exit;
      End;
    End;
  End;

  If (strImpressora = 'ImpressaoEmTelaPDF') Or
     (UpperCase(strImpressora) = 'EXPORTAR PARA PDF') Or
     (Not VS_PDFtoPrinterEnotas) Then
  Begin
    pLogEnotas('Comando a ser executado no shell: ' + strArquivo);
    ShellExecute(0, NIL, PChar(strArquivo), NIL, '', SW_NORMAL);
    pLogEnotas('Executou ShellExecute()');

    If (Not VS_PDFtoPrinterEnotas) And
       (Not ((strImpressora = 'ImpressaoEmTelaPDF') Or (UpperCase(strImpressora) = 'EXPORTAR PARA PDF'))) Then
    Begin
      Sleep(3000);
      DeleteFile(strArquivo);
    End;
  End
  Else
  Begin
    strCMD := strArquivoPDFtoPrinter + ' ' + strArquivo + ' "' + strImpressora + '"' + VS_PDFtoPrinterQtdeCopias;
    pLogEnotas('Comando a ser executado no shell: ' + strCMD);

    ShellExecuteAndWait('', strArquivoPDFtoPrinter, PChar(strArquivo+' "'+strImpressora+'"' + VS_PDFtoPrinterQtdeCopias), '', SW_NORMAL, True);
    pLogEnotas('Executou ShellExecuteAndWait()');
  End;
  pLogEnotas('pImprimeArquivo <');
end;
{$ENDIF}

{ TWSNfeEnotasRetorno }

constructor TWSNfeEnotasRetorno.Create(blnRetornoOk: Boolean; strTexto: String);
begin
  FRetornoOk := blnRetornoOk;
  FTexto := strTexto;
end;

function TWSNfeEnotasRetorno.RetornoOk: Boolean;
begin
  Result := FRetornoOk;
end;

function TWSNfeEnotasRetorno.Texto: String;
begin
  Result := FTexto;
end;

{ TMetodoImpressaoFactory }

class function TMetodoImpressaoFactory.fCriarCartaCorrecao(strPrefixo: String): IMetodoImpressao;
begin
//
end;

class function TMetodoImpressaoFactory.fCriarConhecimento(strForcarImpressaoPDF: String = 'N'): IMetodoImpressao;
begin
//
end;

class function TMetodoImpressaoFactory.fCriarManifesto: IMetodoImpressao;
begin
//
end;

class function TMetodoImpressaoFactory.fCriarNotaFiscal(strPrefixo: String): IMetodoImpressao;
begin
//
end;

class function TMetodoImpressaoFactory.fCriarNotaServico(strPrefixo: String): IMetodoImpressao;
begin
//
end;

{ TImpressaoIntegradorLocal }

constructor TImpressaoIntegradorLocal.Create(EnotasWrapper: TWSNFeEnotas;
  strIntegrador, strImpressora: String);
begin
  Self.EnotasWrapper := EnotasWrapper;
  Self.strIntegrador := strIntegrador;
  Self.strImpressora := strImpressora;
end;

{ TImpressaoDiretaCitel }

class procedure TImpressaoDiretaCitel.pImprimir(strCodigoEmpresa, strImpressora, strAcesso, strTipo: String; blnReimpressao: Boolean = false);
begin
  untImpressaoDiretaCitel.TImpressaoDiretaCitel.pImprimir(strCodigoEmpresa, strImpressora, strAcesso, strTipo, blnReimpressao, VS_PidMD5DicSis);
end;

{TNfeApiWS}

constructor TNfeApiWS.Create;
Var
  strMsg: String;
  resultValidacao: TResultadoValidacao;
begin
 {$IFDEF LINUX}
  FlibApiRest := LoadLibrary(PChar('libapi.rest.so'));
 {$ELSE}
  FlibApiRest := LoadLibrary(PChar('api.rest.dll'));
 {$ENDIF}

  If (FlibApiRest = 0) Then
  Begin
   {$IFDEF LINUX}
    strMsg := 'Biblioteca "libapi.rest.so" não encontrada!';
   {$ELSE}
    strMsg := 'Biblioteca "api.rest.dll" não encontrada!';
   {$ENDIF}
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogEnotas(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End
  Else
  Begin
    Try
     {$IFDEF LINUX}
      pLogEnotas('LoadLibrary(libapi.rest.so) > '+IntToStr(FlibApiRest));
     {$ELSE}
      pLogEnotas('LoadLibrary(api.rest.dll) > '+IntToStr(FlibApiRest));
     {$ENDIF}
    Except
    End;
  End;

  @fExecuteAuth       := GetProcAddress(FlibApiRest, PChar('ExecuteAuth'));
  @fExecuteAuthProxy  := GetProcAddress(FlibApiRest, PChar('ExecuteAuthProxy'));
  @fGetJsonValue      := GetProcAddress(FlibApiRest, PChar('GetJsonValue'));
  @fGetJsonArrayValue := GetProcAddress(FlibApiRest, PChar('GetJsonArrayValue'));
end;

destructor TNfeApiWS.Destroy;
begin
  If (FlibApiRest <> 0) Then
  Begin
    FreeLibrary(FlibApiRest);
    Try
     {$IFDEF LINUX}
      pLogEnotas('FreeLibrary(libapi.rest.so) < '+IntToStr(FlibApiRest));
     {$ELSE}
      pLogEnotas('FreeLibrary(api.rest.dll) < '+IntToStr(FlibApiRest));
     {$ENDIF}
    Except
    End;
    FlibApiRest := 0;
  End;

  inherited;
end;

function TNfeApiWS.fEhDownloadDeArquivo(strComando: String): Boolean;
begin
  Result := True;

  If (Pos('/xml', strComando) > 0) Then
    Exit;

  If (Pos('/pdf', strComando) > 0) Then
    Exit;

  Result := False;
end;

function TNfeApiWS.NfeEnviaRecebeDados(strApiKey: WideString; Metodo: TMetodo; strComando, strJson,
                                       strProxyServer, strProxyPort, strProxyUsername, strProxyPassword, strProxyAtivado: WideString): TRetornoEnotas;
Const
  strURL = 'https://api.enotasgw.com.br/v1';

var
  intStatus: Integer;
  strMetodo: WideString;
  strResultado: WideString;
  stlRetorno: TStringList;
begin
  Try
    pLogEnotas('NfeEnviaRecebeDados >');

    Case Metodo Of
         mGet: strMetodo := 'GET';
        mPost: strMetodo := 'POST';
      mDelete: strMetodo := 'DELETE';
    End;

    FDownloadDeArquivo := fEhDownloadDeArquivo(strComando);

    pLogEnotas('fEhDownloadDeArquivo = '+fBooleanToString(FDownloadDeArquivo));

    pLogEnotas('Env > fExecuteAuth('''+strMetodo+''', '''+strURL + strComando+''', '''+strJson+''', '''+'Basic '+strApiKey+''')');

    If (Metodo = mGet) Then
      Sleep(2000);

    If (strProxyAtivado = 'S') Then
    Begin
      intStatus := fExecuteAuthProxy(strMetodo, strURL + strComando, strJson, 'Basic '+strApiKey, strProxyServer, strProxyPort, strProxyUsername, strProxyPassword, strProxyAtivado ,strResultado);
    End
    Else
    Begin
      intStatus := fExecuteAuth(strMetodo, strURL + strComando, strJson, 'Basic '+strApiKey, strResultado);
    End;

    If (not fEhRetornoDeArquivo(strResultado)) And (not fEhMetadados(strResultado)) Then
      strResultado := AnsiReplaceStr(AnsiReplaceStr(strResultado, '[', ''), ']', '');

    pLogEnotas('Ret < fExecuteAuth '+#10#13
                                    +'intStatus....: '+IntToStr(intStatus) + #13
                                    +'strResultado.: '+strResultado);

    stlRetorno := TStringList.Create;
    Try
      stlRetorno.Add(strResultado);
      Try
        stlRetorno.SaveToFile(fPnlDir('ULTIMO_RETORNO_NFE_WS.TXT'));
      Except

      End;
    Finally
      FreeAndNil(stlRetorno);
    End;

    Result := fParseResponse(Metodo, intStatus, strResultado);

    pLogEnotas('NfeEnviaRecebeDados <');
  Except
    On E: Exception Do
    Begin
      pLogEnotas('NfeEnviaRecebeDados (Exception) < '+E.Message);
      Raise ErrosValidacaoNFE.fCriaErroSimples(E.Message);
    End;
  End;
end;

function TNfeApiWS.fEhMetadados(strJsonString: WideString): Boolean;
var strResultado: String;
begin
  strResultado := strJsonString;

  Result := (Pos('metadados', strResultado) > 0);
end;

function TNfeApiWS.fEhRetornoDeArquivo(strJsonString: WideString): Boolean;
var strResultado: String;
begin
  strResultado := strJsonString;

  Result := ((Pos('%PDF', strResultado) > 0) Or
             (Pos('?xml version', strResultado) > 0) Or
             (Pos('X509Data', strResultado) > 0) Or
             (Length(strResultado) > 30000) Or
             (Pos('xmlns', strResultado) > 0) Or
             (Pos('<Nfse>', strResultado) > 0) Or
             (Pos('<Nota>', strResultado) > 0) Or
             (FDownloadDeArquivo));
end;

function TNfeApiWS.fParseResponse(const Metodo: TMetodo; const intStatus: Integer; strJsonString: WideString): TRetornoEnotas;
begin
  pLogEnotas('fParseResponse > '+strJsonString);

  Result := TRetornoEnotas.Create();

  Result.strCodigo := IntToStr(intStatus);

  If intStatus = 200 Then
  Begin
    If fEhRetornoDeArquivo(strJsonString) Then
    Begin
      Result.strUltimoRetorno := strJsonString;
    End
    Else
    Begin
      Result.strTipo        := fGetJsonValue(strJsonString, 'tipo');
      Result.strChaveAcesso := fGetJsonValue(strJsonString, 'chaveAcesso');
      Result.strProtocolo   := fGetJsonValue(strJsonString, 'nfeId');
      Result.strNumRps      := fGetJsonValue(strJsonString, 'numeroRps');

      If Result.strChaveAcesso = 'null' Then
        Result.strChaveAcesso := '';

      Case Metodo Of
           mGet: Result.strMensagem := fGetJsonValue(strJsonString, 'status');
          mPost: Result.strMensagem := 'AguardandoAutorizacao';
        mDelete: Result.strMensagem := 'SolicitandoCancelamento';
      End;

      If (Metodo = mGet) And (fGetJsonValue(strJsonString, 'status') = 'Negada') Then
      Begin
        Result.strMensagem := fGetJsonValue(strJsonString, 'status') + ' - ' + fGetJsonValue(strJsonString, 'motivoStatus');
      End;

      If (Pos('não pode ser atualizada', LowerCase(Result.strMensagem)) > 0) Then
        Result.strMensagem := 'AguardandoAutorizacao';

      If (Metodo = mPost) Then
        Sleep(8000);

    End;
  End
  Else
  Begin
    Result.strMensagem := fGetJsonValue(strJsonString, 'mensagem');

    If Pos('Padrão de NFS-e não parametrizado', Result.strMensagem) > 0 Then
    Begin
      Result.strMensagem := Result.strMensagem + ' Verifique os dados municipais no cadastro de empresas do eNotas.';
    End;

    If fEmptyStr(Result.strMensagem) Then
      Result.strMensagem := strJsonString;
  End;

  pLogEnotas('fParseResponse < '+#10#13
                                +'strCodigo....: '+Result.strCodigo + #13
                                +'strTipo......: '+Result.strTipo + #13
                                +'strChaveAcess: '+Result.strChaveAcesso + #13
                                +'strProtocolo.: '+Result.strProtocolo + #13
                                +'strNumRps....: '+Result.strNumRps + #13
                                +'strMensagem..: '+Result.strMensagem);
end;

function fMetodoToString(AMetodo: TMetodo): String;
begin
  Case AMetodo Of
       mGet: Result := 'mGet';
      mPost: Result := 'mPost';
    mDelete: Result := 'mDelete';
  End;
end;

initialization
{$IFNDEF LINUX}
  CoInitialize(Nil);
{$ENDIF}

finalization
{$IFNDEF LINUX}
  CoUninitialize;
{$ENDIF}

end.
