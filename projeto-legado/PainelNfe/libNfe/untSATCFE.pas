unit untSATCFE;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Windows, Dialogs, Forms,
{$ENDIF}
  SysUtils, Classes, NfeApiWSBean, untInterfaces, StrUtils, Types, XMLDoc,
  XMLIntf, DB, Math, DateUtils, Variants;

Type
  TSATCFE = class(TInterfacedObject, INFE)
    private
      lstItens: TList;

      dadosEmitente: TDadosEmitente;
      dadosGerais: TDadosGerais;
      fonteDados: IFonteDados;

      strPathOpcoesSAT: String;

      strUltimoRetornoSAT: String;

      strVerSat : string;

      function fValor(fltValor: Double; intDecimais: Integer): String;

      function fRetornaXmlVenda: String;
      procedure pCarregaDadosDestinatario(raiz: IXMLNode);
      procedure pCarregaDadosItens(raiz: IXMLNode);
      procedure pCarregaDadosTotais(raiz: IXMLNode);
      procedure pCarregaDadosMeiosPagamento(raiz: IXMLNode);
      procedure pCarregaDadosAdicionais(raiz: IXMLNode);
      procedure pCarregarFuncoesDll;

      function fGeraNumeroSessao: Integer;
      procedure pSalvarXML(strArqBase64, strChave: String; strPrefixo: String=''; strNSerie: String = '');
      function fRetornaQRCode(strTexto: String): String;
      function fRetornaDataTimeStamp(strTexto: String): TDateTime;
      function fRetornaDocumentoCliente(strNumDoc, strSerie: String): String;
      function fRetornaXMLCancelamento(strDocCli: String): String;

      procedure pExtrairNumeroSerieECFe(strArqBase64: AnsiString;
        Var strNumeroSerie, strNumeroCFe, strObsFisco: String);

      procedure pDebug(strConteudo, strNomeArq: String);
      procedure pSalvarPontoRecuperacao(strConteudo, strNome: String);
      function fRetornaPontoRecuperacao(strNome: String): String;
      function fTiraCaracEspeciaisSAT(strTexto: String): String;
      function fUltimoRetornoSATSucesso(var strMensagem: String; blnCancelando: Boolean = False): Boolean;
      procedure pCarregaDadosComplementar(raiz: IXMLNode);
      function fSessaoPreGravada(strNumDoc, strCodEmp, strCodCli, strSerie: String; blnCancelado: Boolean = False): integer;
      function fDefineImpressora(dadosGeraisArg: TDadosGerais): String;
    public
      function fEnviarNota: Boolean;
      function fCancelarNota(strNumDoc, strSerie, strMotivo: String): Boolean;
      function fProcessarEnvio: TRetornoNFE;
      function fProcessarCancelamento: TRetornoNFE;
      function fRetXmlNfe(strChaveAcesso: string): string;
      function fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;

      function fMensagemErro: String;

      procedure pSetaDadosEmitente(dadosEmitente: TDadosEmitente);
      procedure pSetaDadosGerais(dadosGerais: TDadosGerais);
      procedure pAdicionaItem(dadosItem: TDadosItem);

      function fVerificarStatusNota: Boolean;
      function fProcessarStatusNota: TRetornoNFE;

      function fVerificarStatusServico(strCnpjEmitente, strIESEmitente: String): TRetornoStatusNFE; overload;

      procedure pReimprimeDanfe(strChaveAcesso: String); overload;

      function fSuportaFuncoesAdministrativas: Boolean;
      procedure pEnviaCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
        strImpressora: String; intSequencial: Integer);
      procedure pReimprimeDanfe(strChaveAcesso, strImpressora: String; strImprimirTelaPDF: String = ''); overload;
      procedure pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
        strNumeroFinal, strDescricao: String);

      function fListagemNotas(strCodEmp: String; dtaDtaIni, dtaDtaFin: TDateTime;
        intTipo, intStatus: Integer): TStringList;
      function fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
      function fEnviaNFCeXmlOffLine: Boolean;

      function fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;

      function fEnviaCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
        strImpressora: String; intSequencial: Integer): TRetornoCartaCorrecao;

      procedure pGravaErro(AMsg: String);

      function fVerificarStatusServico(strCnpjEmitente, strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE; overload;

      procedure pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);

      function fConsultaStatusDFe(strChaveAcesso: string): String;
      function fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
      function fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento : String; const strModeloFiscal : String = '55') : String;

      function fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;

      function fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;

      constructor Create(fonteDados: IFonteDados);
      destructor Destroy; override;
  end;

Const
  STATUS_SUCESSO_VENDA = 06000;
  STATUS_SUCESSO_CANCE = 07000;
  VERSAO_SAT_007 : string = '0.07';

Var
  HandleDllSAT: Cardinal;

  EnviarDadosVenda: function(NumeroSessao:integer; CodAtivacao:AnsiString; Venda_XML:AnsiString):PAnsiChar; stdcall;
  TesteFimAFim: function(NumeroSessao:Integer; CodAtivacao:AnsiString; Venda_XML:AnsiString):PAnsiChar; stdcall;
  ConsultarNumeroSessao: function(NumeroSessao:Integer; CodAtivacao:AnsiString;cNumeroSessao:integer):PAnsiChar; stdcall;
  ConsultarStatusOperacional: function(NumeroSessao:Integer; CodAtivacao:AnsiString):PAnsiChar; stdcall;
  ConsultarSAT: function(NumeroSessao:integer):PAnsiChar; stdcall;
  ExtrairLogs: function(NumeroSessao:Integer; CodAtivacao:AnsiString):PAnsiChar; stdcall;
  CancelarUltimaVenda: function(NumeroSessao:integer; CodAtivacao:AnsiString; Chave:AnsiString; DadosCancelamento:AnsiString):PAnsiChar; stdcall;

implementation

{ TSATCFE }

uses untUtil, untUtilNFSe, untFuncoesLibNfe, untConstantesNFe, untDicSis;

constructor TSATCFE.Create(fonteDados: IFonteDados);
begin
  Self.fonteDados := fonteDados;

  If not fEmptyStr(VS_PathSat) Then
  Begin
    strPathOpcoesSAT := VS_PathSat;
  End
  Else
  Begin
    strPathOpcoesSAT := fCfgSisFonte(fonteDados, 'PATSAT');
  End;

  strVerSat := fCfgSisFonte(fonteDados, 'VERSAT');

  if fEmptyStr(strVerSat) then
    strVerSat := VERSAO_SAT_007;

  pCarregarFuncoesDll;
end;

procedure TSATCFE.pCarregarFuncoesDll;
  Var
    strDll: String;
    LstrLastError: String ;
begin
  strDll := fArqIniLocal(0, 'SATCFE', 'PATHDLL', '', strPathOpcoesSAT + PATH_SEPARATOR + 'opcoes_sat.ini');

  HandleDllSAT := LoadLibrary({$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}(strDll));
  If HandleDllSAT = 0 Then
  Begin

    LstrLastError := '' ;
    try
      RaiseLastOSError ;
    except
      on e: EOSError do
      begin
        LstrLastError := e.Message  ;
      end ;
    end ;

    If (fCfgSisFonte(fonteDados, 'SATCIT') = 'S') Then
    Begin
      pGravaErro('SAT-CFe: não foi possível carregar a DLL ' + strDll + '[' + LstrLastError + ']');
      Randomize;
      Exit;
    End
    Else
      Raise Exception.Create('SAT-CFe: não foi possível carregar a DLL ' + strDll + '[' + LstrLastError + ']');
  End;

  EnviarDadosVenda := GetProcAddress(HandleDllSAT, {$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}('EnviarDadosVenda'));
  TesteFimAFim := GetProcAddress(HandleDllSAT, {$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}('TesteFimAFim'));
  ConsultarNumeroSessao := GetProcAddress(HandleDllSAT, {$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}('ConsultarNumeroSessao'));
  ConsultarStatusOperacional := GetProcAddress(HandleDllSAT, {$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}('ConsultarStatusOperacional'));
  ConsultarSAT := GetProcAddress(HandleDllSAT, {$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}('ConsultarSAT'));
  ExtrairLogs := GetProcAddress(HandleDllSAT, {$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}('ExtrairLogs'));
  CancelarUltimaVenda := GetProcAddress(HandleDllSAT, {$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}('CancelarUltimaVenda'));

  Randomize;
end;

procedure TSATCFE.pDebug(strConteudo, strNomeArq: String);
  const
    _LOG_SAT : String = 'debug.sat';
  Var
    stlLog: TStringList;
    strPath: String;
    dtaFileDateTime: TDateTime;
begin
  If FileExists(_LOG_SAT) Then
  Begin
    Try
      FileAge(_LOG_SAT,dtaFileDateTime);

      If (dtaFileDateTime < Date) Then
      Begin
        SysUtils.DeleteFile(_LOG_SAT);
        Exit;
      End;
    Except
      //
    End;

    strPath := ExtractFilePath(Application.ExeName) + 'DEBUGSAT\';
    If Not DirectoryExists(strPath) Then
    Begin
      CreateDir(strPath);
    End;

    stlLog := TStringList.Create;
    Try
      stlLog.Add(strConteudo);
      stlLog.SaveToFile(strPath + strNomeArq);
    Finally
      FreeAndNil(stlLog);
    End;
  End;
end;

destructor TSATCFE.Destroy;
begin
  If Assigned(lstItens) Then
  Begin
    FreeAndNil(lstItens);
  End;

  inherited;
end;

function TSATCFE.fCancelarNota(strNumDoc, strSerie,
  strMotivo: String): Boolean;
  Var
    strXML: String;
    strDocCli: String;
    intSessao: Integer;
    strCodAtivacao: String;
begin
  strDocCli := fRetornaDocumentoCliente(strNumDoc, strSerie);
  strXML    := fRetornaXMLCancelamento(strDocCli);

  intSessao := fSessaoPreGravada(dadosGerais.strNumDoc, dadosGerais.strCodEmp, dadosGerais.strCodCli, dadosGerais.strSerie, True);
  if (intSessao = 0) then
    intSessao := fGeraNumeroSessao;

  strCodAtivacao := fArqIniLocal(0, 'SATCFE', 'CODIGO_ATIVACAO', '', strPathOpcoesSAT + PATH_SEPARATOR + 'opcoes_sat.ini');

  pDebug(StrXML, 'SAT_CANC_' + fNumDocEnvio(dadosGerais.strNumDoc) + '_' + dadosGerais.strCodEmp + '.xml');

  {$IF Defined(VER250) Or Defined(UNIDAC)}
    strUltimoRetornoSAT := UTF8ToString(AnsiToUtf8(String(CancelarUltimaVenda(intSessao, AnsiString(strCodAtivacao),
      AnsiString('CFe' + fonteDados.fChaveAcesso), AnsiString(System.UTF8Encode(strXML))))));
  {$ELSE}
    strUltimoRetornoSAT := AnsiToUtf8(CancelarUltimaVenda(intSessao, AnsiString(strCodAtivacao), AnsiString('CFe' + fonteDados.fChaveAcesso), AnsiString(System.UTF8Encode(strXML))));
  {$IFEND}

  pSalvarPontoRecuperacao(String(strUltimoRetornoSAT), 'SAT_CANC_' + fNumDocEnvio(dadosGerais.strNumDoc) + '_' + dadosGerais.strCodEmp + '.txt');

  pDebug(String(strUltimoRetornoSAT) , 'SAT_CANC_RET_' + fNumDocEnvio(dadosGerais.strNumDoc) + '_' + dadosGerais.strCodEmp + '.txt');

  Result := True;
end;

function TSATCFE.fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string;
  AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;
begin
  If not fEmptyStr(AChaveAcesso) Then
    TImpressaoDiretaCitel.pImprimirPDF(fonteDados.fDadosGerais.strCodEmp ,
                                       'ImpressaoPDF',
                                       AChaveAcesso,
                                       fonteDados.fDadosGerais.strEspDoc,
                                       False,
                                       ANomeArquivo,
                                       False);

  Result := ANomeArquivo;
end;

function TSATCFE.fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
begin
  Result := nil;
end;

function TSATCFE.fDefineImpressora(dadosGeraisArg: TDadosGerais): String;
begin
  If (fCfgSisFonte(fonteDados, 'SATCIT') = 'S') Then
  Begin
    try
      Result := fImpressoraArqIni(fonteDados, strPathOpcoesSAT);
    except
      Result := '';
    end;
    If (Not fEmptyStr(Result)) Then
      Exit;
  End;

  If (Not Assigned(dadosGeraisArg)) Or (fEmptyStr(dadosGeraisArg.strPontoImpressao)) Then
    Result := fIdentificarNomeDaImpressora(fonteDados, objConfig.strFitImpressoraPadrao)
  Else
    Result := fIdentificarNomeDaImpressora(fonteDados, dadosGeraisArg.strPontoImpressao);
end;

function TSATCFE.fEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String;
  intSequencial: Integer): TRetornoCartaCorrecao;
begin
  Result := Nil;
end;

function TSATCFE.fEnviaNFCeXmlOffLine: Boolean;
Begin
  Result := False;
End;

function TSATCFE.fRetornaXMLCancelamento(strDocCli: String): String;
  Var
    xml: TXMLDocument;
    cfeCanc: IXMLNode;
    infCFe: IXMLNode;
    ide: IXMLNode;
    emit: IXMLNode;
    dest: IXMLNode;

    stream: TStringStream;
begin
  xml := TXMLDocument.Create(Nil);
  xml.Active := True;

  cfeCanc := xml.AddChild('CFeCanc');
  infCFe := cfeCanc.AddChild('infCFe');
  infCFe.Attributes['chCanc'] := 'CFe' + fonteDados.fChaveAcesso;

  ide := infCFe.AddChild('ide');
  ide.AddChild('CNPJ').Text := fCfgSisFonte(fonteDados, 'SFTSAT');
  ide.AddChild('signAC').Text := fArqIniLocal(0, 'SATCFE', 'ASSINATURA_AC', '', strPathOpcoesSAT + PATH_SEPARATOR + 'opcoes_sat.ini');
  ide.AddChild('numeroCaixa').Text := fArqIniLocal(0, 'SATCFE', 'PDV', '', strPathOpcoesSAT + PATH_SEPARATOR + 'opcoes_sat.ini');

  emit := infCFe.AddChild('emit');

  dest := infCFe.AddChild('dest');

  infCFe.AddChild('total');
  infCFe.AddChild('infAdic');

  stream := TStringStream.Create('');
  xml.SaveToStream(stream);

  Result := '<?xml version="1.0" encoding="UTF-8"?>' + stream.DataString;

  FreeAndNil(stream);
end;

function TSATCFe.fRetornaDocumentoCliente(strNumDoc, strSerie: String): String;
  Var
    strSQL: String;
    dataSet: TDataSet;
    intQtdRec: Integer;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT GER_CGCCON FROM MOVGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  GER_ESPDOC = "IF" AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  GER_SERIE_ = :SERIE_ ';

  dataSet := fonteDados.fExecutaQuery(strSQL, ['NUMDOC', 'CODEMP', 'SERIE_'],
    [strNumDoc, dadosGerais.strCodEmp, strSerie]);

  Result := dataSet.FieldByName('GER_CGCCON').AsString;
  intQtdRec := dataSet.RecordCount;

  FreeAndNil(dataSet);

  If intQtdRec = 0 Then
  Begin
    strSQL := AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');
    dataSet := fonteDados.fExecutaQuery(strSQL, ['NUMDOC', 'CODEMP', 'SERIE_'],
      [strNumDoc, dadosGerais.strCodEmp, strSerie]);
    Result := dataSet.FieldByName('GER_CGCCON').AsString;
  End;
end;

function TSATCFE.fRetornaPontoRecuperacao(strNome: String): String;
  Var
    stlArq: TStringList;
    strPath: String;
begin
  Result := '';

  strPath := fSepDir(ExtractFilePath(Application.ExeName) + 'XMLSAT');

  If FileExists(strPath + strNome) Then
  Begin
    stlArq := TStringList.Create;
    Try
      stlArq.LoadFromFile(strPath + strNome);
      Result := stlArq.Text;
    Finally
      FreeAndNil(stlArq);
    End;

    Result := AnsiReplaceStr(Result, '#13', '');
    Result := AnsiReplaceStr(Result, '#10', '');
  End;
end;

function TSATCFE.fEnviarNota: Boolean;
  Var
    strXML: String;
    intSessao: Integer;
    strCodAtivacao: AnsiString;
begin
  strUltimoRetornoSAT := fRetornaPontoRecuperacao(fNumDocEnvio(dadosGerais.strNumDoc) + '_' + dadosGerais.strCodEmp + '.txt');
  If Not fEmptyStr(String(strUltimoRetornoSAT)) Then
  Begin
    Result := True;
    Exit;
  End;

  strXML := fRetornaXmlVenda;
  intSessao := fSessaoPreGravada(dadosGerais.strNumDoc, dadosGerais.strCodEmp, dadosGerais.strCodCli, dadosGerais.strSerie);
  if (intSessao = 0) then
    intSessao := fGeraNumeroSessao;

  strCodAtivacao := AnsiString(fArqIniLocal(0, 'SATCFE', 'CODIGO_ATIVACAO', '', strPathOpcoesSAT + PATH_SEPARATOR + 'opcoes_sat.ini'));

  pDebug(strXML, 'SAT_' + fNumDocEnvio(dadosGerais.strNumDoc) + '_' + dadosGerais.strCodEmp + '.xml');

  {$IF Defined(VER250) Or Defined(UNIDAC)}
    strUltimoRetornoSAT := UTF8ToString(AnsiToUtf8(String(EnviarDadosVenda(intSessao, strCodAtivacao, AnsiString(strXml)))));
  {$ELSE}
    strUltimoRetornoSAT := AnsiToUtf8(EnviarDadosVenda(intSessao, strCodAtivacao, strXml));
  {$IFEND}

  pSalvarPontoRecuperacao(String(strUltimoRetornoSAT), fNumDocEnvio(dadosGerais.strNumDoc) + '_' + dadosGerais.strCodEmp + '.txt');

  pDebug(String(strUltimoRetornoSAT), 'SAT_RET' + fNumDocEnvio(dadosGerais.strNumDoc) + '_' + dadosGerais.strCodEmp + '.txt');

  Result := True;
end;

procedure TSATCFE.pSalvarPontoRecuperacao(strConteudo, strNome: String);
  Var
    stlArq: TStringList;
    strPath: String;
    strMensagem : String;
begin
  If (fUltimoRetornoSATSucesso(strMensagem)) Then
  Begin
    strPath := fSepDir(ExtractFilePath(Application.ExeName) + 'XMLSAT');

    If Not DirectoryExists(strPath) Then
      CreateDir(strPath);

    stlArq := TStringList.Create;
    Try
      stlArq.Add(strConteudo);
      stlArq.SaveToFile(strPath + strNome);
    Finally
      FreeAndNil(stlArq);
    End;
  End;
end;

function TSATCFE.fGeraNumeroSessao: Integer;
  Var
    strUltimaSessao: String;
    intRandom: Integer;
    strSessao: String;
    strNumPdv : String;
begin
  intRandom := RandomRange(0, 999);

  strNumPdv := fArqIniLocal(0, 'SATCFE', 'PDV', '', strPathOpcoesSAT + PATH_SEPARATOR + 'opcoes_sat.ini');

  If (Not fEmptyStr(strNumPdv)) And (Length(IntToStr(StrToInt(strNumPdv))) = 1) Then
    strNumPdv := IntToStr(StrToInt(strNumPdv)) + IntToStr(RandomRange(0, 99));

  strUltimaSessao := fArqIniLocal(0, 'SATCFE', 'ULTIMA_SESSAO', '', strPathOpcoesSAT + PATH_SEPARATOR + 'opcoes_sat.ini');

  strSessao := untUtil.fStrZero(strNumPdv, 3) +
               untUtil.fStrZero(IntToStr(intRandom), 3);

  If strSessao = strUltimaSessao Then
  Begin
    strSessao := untUtil.fStrZero(strNumPdv, 3) +
                 untUtil.fStrZero(IntToStr(intRandom+1), 3);
  End;

  fArqIniLocal(1, 'SATCFE', 'ULTIMA_SESSAO', strSessao, strPathOpcoesSAT + PATH_SEPARATOR + 'opcoes_sat.ini');
  Result := StrToInt(strSessao);
end;

function TSATCFE.fListagemNotas(strCodEmp: String; dtaDtaIni,
  dtaDtaFin: TDateTime; intTipo, intStatus: Integer): TStringList;
begin
  Raise Exception.Create('Operação não permitida para SAT-CFe.');
end;

function TSATCFE.fMensagemErro: String;
begin

end;

function TSATCFE.fRetXmlNfe(strChaveAcesso: string): string;
begin
  result := '';
end;

function TSATCFE.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;
begin
  result := '';
end;

function TSATCFE.fProcessarCancelamento: TRetornoNFE;
  Var
    intRetorno: Integer;
    strMensagem: String;
    blnSucesso: Boolean;
    strArqBase64: String;
    strChave: String;
    strNumeroSerie: String;
    strNumeroCFe: String;
    strObsFisco: String;
    blnJaCancelou : Boolean;
    strMsgRec : String;
begin
  intRetorno := StrToInt(fGetValorLinha(String(strUltimoRetornoSAT), '|', 2));
  strMensagem := IntToStr(intRetorno) + '-' + fGetValorLinha(String(strUltimoRetornoSAT), '|', 4);

  blnSucesso := intRetorno = 07000;
  blnJaCancelou := (intRetorno = 07007);

  If (blnJaCancelou) And (Not blnSucesso) Then
  Begin
    strMsgRec := fRetornaPontoRecuperacao('SAT_CANC_' + fNumDocEnvio(dadosGerais.strNumDoc) + '_' + dadosGerais.strCodEmp + '.txt');

    If (Not fEmptyStr(strMsgRec)) Then
    Begin
      intRetorno := StrToInt(fGetValorLinha(String(strMsgRec), '|', 2));
      strMensagem := IntToStr(intRetorno) + '-' + fGetValorLinha(String(strMsgRec), '|', 4);
      blnSucesso := (intRetorno = 07000);

      If (blnSucesso) Then
        strUltimoRetornoSAT := strMsgRec;
    End;
  End;

  If blnSucesso Then
  Begin
    strChave := RightStr(fGetValorLinha(String(strUltimoRetornoSAT), '|', 9), 44);
    strArqBase64 := fGetValorLinha(String(strUltimoRetornoSAT), '|', 7);

    pExtrairNumeroSerieECFe(AnsiString(strArqBase64), strNumeroSerie, strNumeroCFe, strObsFisco);

    pSalvarXML(strArqBase64, strChave, 'CANC_', strNumeroSerie);

    Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, strChave, '', fRetornaDataTimeStamp(strUltimoRetornoSAT));
    Result.SetDataEmissao(Result.DataAutorizacao);
    Result.SetQRCode(fRetornaQRCode(strUltimoRetornoSAT));
    Result.SetNumeroSerieSAT(strNumeroSerie);
    Result.SetNumeroCFe(strNumeroCFe);
    Result.SetObsFisco(strObsFisco);
  End
  Else
  Begin
    Result := TRetornoNFE.fCriaRetornoErro(strMensagem);
  End;

end;

function TSATCFE.fProcessarEnvio: TRetornoNFE;
  Var
    intRetorno: Integer;
    strMensagem: String;
    blnSucesso: Boolean;
    strArqBase64: String;
    strChave: String;

    strNumeroSerie: String;
    strNumeroCFe: String;
    strObsFisco: String;
    strCooOutroDoc : String;

  function fChaveJaExisteEmOutroDocumento(strChv, strCoo: String): Boolean;
    Var
      DataSet : TDataSet;
  begin
    strCooOutroDoc := '';
    Result := False;
    Try
      If (FileExists(ExtractFilePath(Application.ExeName) + 'verduplic.sat')) And (Not fEmptyStr(strChv)) And (Not fEmptyStr(strCoo)) Then
      Begin
        DataSet := fonteDados.fExecutaQuery('SELECT FIS_NUMCOO FROM CADFIS WHERE FIS_ACESSO = :ACESSO AND FIS_NUMCOO <> :NUMCOO', ['ACESSO', 'NUMCOO'], [strChv, strCoo]);
        Try
          Result := (Not DataSet.IsEmpty);

          If (Result) Then
            strCooOutroDoc := DataSet.FieldByName('FIS_NUMCOO').AsString;
        Finally
          FreeAndNil(DataSet);
        End;
      End;
    Except
      Result := False;
    End;
  end;
      
begin
  strCooOutroDoc := '';
  intRetorno := StrToInt(fGetValorLinha(String(strUltimoRetornoSAT), '|', 2));
  strMensagem := IntToStr(intRetorno) + '-' + fGetValorLinha(String(strUltimoRetornoSAT), '|', 4);

  blnSucesso := intRetorno = STATUS_SUCESSO_VENDA;

  pLogImp('TSATCFE.fProcessarEnvio >');

  If blnSucesso Then
  Begin
    strChave := RightStr(fGetValorLinha(String(strUltimoRetornoSAT), '|', 9), 44);

    strArqBase64 := fGetValorLinha(String(strUltimoRetornoSAT), '|', 7);

    If fEmptyStr(strArqBase64) Then
      Result := TRetornoNFE.fCriaRetornoErro('Atenção: O SAT retornou sucesso, porém, não há arquivo XML para processar, entre em contato com a Citel para atualizar a DLL do SAT!')
    Else
    Begin
      pExtrairNumeroSerieECFe(AnsiString(strArqBase64), strNumeroSerie, strNumeroCFe, strObsFisco);

      If (Not fChaveJaExisteEmOutroDocumento(strChave, strNumeroCFe)) Then
      Begin
        pSalvarXML(strArqBase64, strChave, '', strNumeroSerie);

        Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, strChave, '', fRetornaDataTimeStamp(strUltimoRetornoSAT));
        Result.SetQRCode(fRetornaQRCode(strUltimoRetornoSAT));
        Result.SetDataEmissao(Result.DataAutorizacao);
        Result.SetNumeroSerieSAT(strNumeroSerie);
        Result.SetNumeroCFe(strNumeroCFe);
        Result.SetObsFisco(strObsFisco);

        pLogImp('Result.Sucesso = '+fBooleanToString(Result.Sucesso));

      End
      Else
        Result := TRetornoNFE.fCriaRetornoErro(Format('Atenção: A chave processada "%s" já existe em outro documento "%s". Por favor, tente novamente, se o problema persistir entre em contato com a Citel!', [strChave, 'COO: ' + strCooOutroDoc]));
    End;
  End
  Else
  Begin
    If intRetorno = 1999 Then
      Result := TRetornoNFE.fCriaRetornoErro('Atenção: O Equipamento SAT está com dificuldades em autorizar os documentos. Por favor, tente novamente ou entre em contato com a assistência do fabricante.')
    Else
      Result := TRetornoNFE.fCriaRetornoErro(strMensagem);
  End;

  pLogImp('TSATCFE.fProcessarEnvio <');
end;

function TSATCFE.fRetornaDataTimeStamp(strTexto: String): TDateTime;
  Var
    strTimeStamp: String;
    ano,mes,dia,hora,min,seg: Word;
begin
  strTimeStamp := fGetValorLinha(String(strTexto), '|', 8);
  ano := StrToInt(Copy(strTimeStamp, 1, 4));
  mes := StrToInt(Copy(strTimeStamp, 5, 2));
  dia := StrToInt(Copy(strTimeStamp, 7, 2));
  hora := StrToInt(Copy(strTimeStamp, 9, 2));
  min := StrToInt(Copy(strTimeStamp, 11, 2));
  seg := StrToInt(Copy(strTimeStamp, 13, 2));

  Result := EncodeDateTime(ano, mes, dia, hora, min, seg, 0);
end;

function TSATCFE.fRetornaQRCode(strTexto: String): String;
  Var
    strTextoStr: String;
begin
  strTextoStr := String(strTexto);
  Result := fGetValorLinha(strTextoStr, '|', 9) + '|' +
            fGetValorLinha(strTextoStr, '|', 8) + '|' +
            fGetValorLinha(strTextoStr, '|', 10) + '|' +
            fGetValorLinha(strTextoStr, '|', 11) + '|' +
            fGetValorLinha(strTextoStr, '|', 12);
end;

procedure TSATCFE.pSalvarXML(strArqBase64, strChave: String; strPrefixo: String=''; strNSerie: String = '');
  Var
    strDirBase: String;
    strDirXml: String;
    strDirXmlSerData: String;
    strDirXmlDataSer: String;
    stlArq: TStringList;
    strSalvarSerieSAT: String;
    blnAutcomLibAtu: Boolean;
    dtaLib, dtaAutcom: TDateTime;
begin
  strChave := RightStr(strChave, 44);

  strSalvarSerieSAT := fCfgSisFonte(fonteDados, 'SSESAT');

  {$IFDef VER150}
    dtaAutcom := FileAge(Application.ExeName);
    dtaLib := FileAge(ExtractFilePath(Application.ExeName) + 'libNfe.dll');
  {$ELSE}
    FileAge(Application.ExeName, dtaAutcom);
    FileAge(ExtractFilePath(Application.ExeName) + 'libNfe.dll', dtaLib);
  {$ENDIF}

  blnAutcomLibAtu := (dtaAutcom >= StrToDate('23/11/2015')) And (dtaLib >= StrToDate('23/11/2015')) ;

  strDirBase := fSepDir(ExtractFilePath(Application.ExeName) + 'XMLSAT');
  strDirXml  := fSepDir(strDirBase + FormatDateTime('yyyymmdd', nOw()));
  strDirXmlDataSer := fSepDir(strDirBase + FormatDateTime('yyyymmdd', nOw()) + PATH_SEPARATOR + strNSerie);
  strDirXmlSerData := fSepDir(strDirBase + strNSerie + PATH_SEPARATOR + FormatDateTime('yyyymmdd', nOw()));

  If Not DirectoryExists(strDirBase) Then
  Begin
   {$IFDEF LINUX}
    CreateDir(strDirBase);
   {$ELSE}
    CreateDirectory({$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}(strDirBase), Nil);
   {$ENDIF}
  End;

  If Pos('365.85', fRetornaVersao(Application.ExeName)) > 0 Then
  Begin
    If Not DirectoryExists(strDirXml) Then
    Begin
     {$IFDEF LINUX}
      CreateDir(strDirXml);
     {$ELSE}
      CreateDirectory({$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}(strDirXml), Nil);
     {$ENDIF}
    End;
  End
  Else If strSalvarSerieSAT = 'S' Then
  Begin
    If Not DirectoryExists(strDirBase + strNSerie + PATH_SEPARATOR) Then
    Begin
     {$IFDEF LINUX}
      CreateDir(strDirBase + strNSerie);
     {$ELSE}
      CreateDirectory({$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}(strDirBase + strNSerie + PATH_SEPARATOR), Nil);
     {$ENDIF}
    End;

    If Not DirectoryExists(strDirXmlSerData) Then
    Begin
     {$IFDEF LINUX}
      CreateDir(strDirXmlSerData);
     {$ELSE}
      CreateDirectory({$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}(strDirXmlSerData), Nil);
     {$ENDIF}
    End;
  End
  Else If blnAutcomLibAtu Then
  Begin
    If Not DirectoryExists(strDirBase + FormatDateTime('yyyymmdd', nOw()) + PATH_SEPARATOR) Then
    Begin
     {$IFDEF LINUX}
      CreateDir(strDirBase + FormatDateTime('yyyymmdd', nOw()) + PATH_SEPARATOR);
     {$ELSE}
      CreateDirectory({$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}(strDirBase + FormatDateTime('yyyymmdd', nOw()) + PATH_SEPARATOR), Nil);
     {$ENDIF}
    End;

    If Not DirectoryExists(strDirXmlDataSer) Then
    Begin
     {$IFDEF LINUX}
      CreateDir(strDirXmlDataSer);
     {$ELSE}
      CreateDirectory({$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}(strDirXmlDataSer), Nil);
     {$ENDIF}
    End;
  End
  Else
  Begin
    If Not DirectoryExists(strDirXml) Then
    Begin
     {$IFDEF LINUX}
      CreateDir(strDirXml);
     {$ELSE}
      CreateDirectory({$IF Defined(VER250) Or Defined(UNIDAC)}PWideChar{$ELSE}PChar{$IFEND}(strDirXml), Nil);
     {$ENDIF}
    End;
  End;

  stlArq := TStringList.Create;
  Try
    stlArq.Add(fDecodeBase64(String(strArqBase64)));

    If Pos('365.85', fRetornaVersao(Application.ExeName)) > 0 Then
      stlArq.SaveToFile(strDirXml + strPrefixo + strChave + '.xml')
    Else If strSalvarSerieSAT = 'S' Then
      stlArq.SaveToFile(strDirXmlSerData + strPrefixo + strChave + '.xml')
    Else If blnAutcomLibAtu Then
      stlArq.SaveToFile(strDirXmlDataSer + strPrefixo + strChave + '.xml')
    Else
      stlArq.SaveToFile(strDirXml + strPrefixo + strChave + '.xml');
  Finally
    FreeAndNil(stlArq);
  End;
end;

function TSATCFE.fProcessarStatusNota: TRetornoNFE;
begin
  Result := Nil;
end;

function TSATCFE.fRetornaXmlVenda: String;
  Var
    xml: TXMLDocument;
    raiz: IXMLNode;
    ide: IXMLNode;
    emit: IXMLNode;

    stream: TStringStream;
begin
  xml := TXMLDocument.Create(Nil);
  xml.Active := True;

  raiz := xml.AddChild('CFe').AddChild('infCFe');
  raiz.Attributes['versaoDadosEnt'] := strVerSat; // Versão do layout

  ide := raiz.AddChild('ide');
  ide.AddChild('CNPJ').Text := fCfgSisFonte(fonteDados, 'SFTSAT');
  ide.AddChild('signAC').Text := fArqIniLocal(0, 'SATCFE', 'ASSINATURA_AC', '', strPathOpcoesSAT + PATH_SEPARATOR + 'opcoes_sat.ini');
  ide.AddChild('numeroCaixa').Text := fArqIniLocal(0, 'SATCFE', 'PDV', '', strPathOpcoesSAT + PATH_SEPARATOR + 'opcoes_sat.ini');

  emit := raiz.AddChild('emit');
  emit.AddChild('CNPJ').Text := dadosEmitente.strCnpj;

  If (dadosEmitente.strEstado = 'CE') Then
    emit.AddChild('IE').Text := untUtil.fStrZero(dadosEmitente.strIES, 12)
  Else
    emit.AddChild('IE').Text := dadosEmitente.strIES ;

  If Not fEmptyStr(dadosEmitente.strInscricaoMunicipal) Then
  Begin
    emit.AddChild('IM').Text := dadosEmitente.strInscricaoMunicipal;
  End;
  emit.AddChild('indRatISSQN').Text := 'N'; // Indicador de rateio do Desconto sobre subtotal entre itens sujeitos a tributação pelo ISSQN

  pCarregaDadosDestinatario(raiz);

  If dadosGerais.blnNfComp Then
    pCarregaDadosComplementar(raiz)
  Else
  Begin
    pCarregaDadosItens(raiz);
    pCarregaDadosTotais(raiz);
    pCarregaDadosMeiosPagamento(raiz);
    pCarregaDadosAdicionais(raiz);
  End;

  stream := TStringStream.Create('');
  xml.SaveToStream(stream);

  Result := stream.DataString;

  FreeAndNil(stream);
end;

procedure TSATCFE.pCarregaDadosAdicionais(raiz: IXMLNode);
  Var
    strMsg: String;
    strCnpj: String;
    intQtdNps : Integer;
begin
  strCnpj := dadosGerais.strCnpj;

  If (Not fValidaCnpjCpf(strCnpj, fonteDados)) Or (fStringRepetida(strCnpj)) Then
  Begin
    strCnpj := '';
  End;

  strMsg := '';

  If objConfig.blnVendad Then
  Begin
    If objConfig.blnAutCen Then
      strMsg := strMsg + ('Vendedor: ' + dadosGerais.strNomVen) + ' '
    Else
      strMsg := strMsg + ('Vendedor: ' + dadosGerais.strCodVen + ' - ' + dadosGerais.strNomVen) + ' '
  End;

  If objConfigInterna.blnNFeDig And Not fEmptyStr(dadosGerais.strCodDig) Then
  Begin
    If objConfig.blnAutCen Then
      strMsg := strMsg + ('Digitador: ' + dadosGerais.strNomDig) + ' '
    Else
      strMsg := strMsg + ('Digitador: ' + dadosGerais.strCodDig + ' - ' + dadosGerais.strNomDig) + ' ';
  End;

  If (dadosGerais.fNotaSaida) And (fGanhouNetpoints(fonteDados,
                                                    intQtdNps)) Then
  Begin
    strMsg := strMsg + Format(MSG_NETPOINTS, [IntToStr(intQtdNps)]) + ' ';
  End;

  If     fEmptyStr(strCnpj)               Then strMsg := strMsg + ('Código do cliente: ' + dadosGerais.strCodCli) + ' ';
  If Not fEmptyStr(dadosGerais.strMen001) Then strMsg := strMsg + (dadosGerais.strMen001) + ' ';
  If Not fEmptyStr(dadosGerais.strMen002) Then strMsg := strMsg + (dadosGerais.strMen002) + ' ';
  If Not fEmptyStr(dadosGerais.strMen003) Then strMsg := strMsg + (dadosGerais.strMen003) + ' ';
  If Not fEmptyStr(dadosGerais.strMen004) Then strMsg := strMsg + (dadosGerais.strMen004) + ' ';
  If Not fEmptyStr(dadosGerais.strMen005) Then strMsg := strMsg + (dadosGerais.strMen005) + ' ';

  strMsg := strMsg + 'IF: ' + fNumDocEnvio(dadosGerais.strNumDoc) + ' ';
  strMsg := strMsg + 'Cliente: ' + dadosGerais.strCodCli + ' - ' + dadosGerais.strNomCli + ' ';

  raiz.AddChild('infAdic').AddChild('infCpl').Text := fTiraCaracEspeciaisSAT(Trim(strMsg));
end;

procedure TSATCFE.pCarregaDadosDestinatario(raiz: IXMLNode);
  Var
    dest: IXMLNode;
    entrega: IXMLNode;
    dataSet: TDataSet;
begin
  dest := raiz.AddChild('dest');

  If Not fStringRepetida(dadosGerais.strCnpj) Then
  Begin
    If fValidaCPF(dadosGerais.strCnpj) Then
    Begin
      dest.AddChild('CPF').Text := dadosGerais.strCnpj;
    End
    Else If fTestaCgc(dadosGerais.strCnpj, fonteDados) Then
    Begin
      dest.AddChild('CNPJ').Text := dadosGerais.strCnpj;
    End;
  End;

  If Not fEmptyStr(dadosGerais.strNomCli) Then
  Begin
    dest.AddChild('xNome').Text := fTiraCaracEspeciaisSAT(dadosGerais.strNomCli);
  End;

  If Not fEmptyStr(dadosGerais.strLogradouroEndEnt) Then
  Begin
    dataSet := fonteDados.fExecutaQuery('SELECT CID_NOMCID, CID_ESTADO FROM CADCID WHERE CID_COIBGE = :COIBGE',
      ['COIBGE'], [dadosGerais.strCodIbgeEntrega]);

    entrega := raiz.AddChild('entrega');
    entrega.AddChild('xLgr').Text := fTiraCaracEspeciaisSAT(dadosGerais.strLogradouroEndEnt);
    entrega.AddChild('nro').Text := fTiraCaracEspeciaisSAT(dadosGerais.strNumeroEndEnt);

    If Not fEmptyStr(dadosGerais.strComplementoEndEnt) Then
    Begin
      entrega.AddChild('xCpl').Text := fTiraCaracEspeciaisSAT(dadosGerais.strComplementoEndEnt);
    End;

    entrega.AddChild('xBairro').Text := fTiraCaracEspeciaisSAT(dadosGerais.strBairroEndEnt);
    entrega.AddChild('xMun').Text := fTiraCaracEspeciaisSAT(dataSet.FieldByName('CID_NOMCID').AsString);
    entrega.AddChild('UF').Text := fTiraCaracEspeciaisSAT(dataSet.FieldByName('CID_ESTADO').AsString);
  End;

end;

procedure TSATCFE.pCarregaDadosItens(raiz: IXMLNode);
  Var
    strNatOpe: String;
    strCstSimples: String;

    item: TDadosItem;
    intContador: Integer;
    det: IXMLNode;
    prod: IXMLNode;
    imposto: IXMLNode;
    obsFiscoDet: IXMLNode;
    icms: IXMLNode;
    detIcms: IXMLNode;

    pis, cofins: IXMLNode;
    detPis, detCofins: IXMLNode;

    issqn: IXMLNode;
begin
  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);
    strCstSimples := fRetornaCSTSimplesUtil(dadosEmitente, dadosGerais, item, fItemServico(item));

    det := raiz.AddChild('det');
    det.Attributes['nItem'] := IntToStr(intContador+1);

    prod := det.AddChild('prod');
    prod.AddChild('cProd').Text := item.strCodIte;

    If Not fEmptyStr(item.strCodBar) Then
    Begin
      prod.AddChild('cEAN').Text := item.strCodBar;
    End;

    prod.AddChild('xProd').Text := fTiraCaracEspeciaisSAT(item.strDesIte);
    prod.AddChild('NCM').Text := item.strClaIpi;

    If (Not fEmptyStr(item.strCodigoCEST)) and (strVerSat <> VERSAO_SAT_007) Then
      prod.AddChild('CEST').Text := fTiraCaracEspeciaisSAT(item.strCodigoCEST);

    prod.AddChild('CFOP').Text := item.strClaFis;
    prod.AddChild('uCom').Text := fTiraCaracEspeciaisSAT(item.strUnidad);
    prod.AddChild('qCom').Text := fValor(item.fltQtdIte, 4);
    prod.AddChild('vUnCom').Text := fValor(item.fltUnitar, 3);
    prod.AddChild('indRegra').Text := 'A';
    prod.AddChild('vDesc').Text := fValor(item.fltDesEsp, 2);
    If (fCfgSisFonte(fonteDados, 'DESSAT') = 'S') Then
      prod.AddChild('vOutro').Text := fValor(item.fltDesAce, 2)
    Else
      prod.AddChild('vOutro').Text := fValor(0, 2);

    If Not fEmptyStr(item.strCodigoCEST) Then
    Begin
      obsFiscoDet := prod.AddChild('obsFiscoDet');
      obsFiscoDet.Attributes['xCampoDet']    := 'Cod. CEST';
      obsFiscoDet.AddChild('xTextoDet').Text := fTiraCaracEspeciaisSAT(item.strCodigoCEST);
    End;

    If Not fEmptyStr(item.strCodLub) Then
    Begin
      obsFiscoDet := prod.AddChild('obsFiscoDet');
      obsFiscoDet.Attributes['xCampoDet']    := 'Cod. Produto ANP';
      obsFiscoDet.AddChild('xTextoDet').Text := fTiraCaracEspeciaisSAT(item.strCodLub);
    End;

    imposto := det.AddChild('imposto');
    If item.fltImpPag = 0 Then
      imposto.AddChild('vItem12741').Text := fValor(item.fltMunImp + item.fltEstImp + item.fltFedImp, 2)
    Else
      imposto.AddChild('vItem12741').Text := fValor(item.fltImpPag, 2);

    If Not fItemServico(item) Then
    Begin
      icms := imposto.AddChild('ICMS');
      If (Pos(RightStr(item.strCodSit, 2), '00,20,90') > 0) And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Then
      Begin
        detIcms := icms.AddChild('ICMS00');
        detIcms.AddChild('Orig').Text := LeftStr(item.strCodSit, 1);
        detIcms.AddChild('CST').Text := RightStr(item.strCodSit, 2);
        detIcms.AddChild('pICMS').Text := fValor(item.fltAlqIcm, 2);
      End
      Else If (Pos(RightStr(item.strCodSit, 2), '40,51,50,60') > 0) And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Then
      Begin
        detIcms := icms.AddChild('ICMS40');
        detIcms.AddChild('Orig').Text := LeftStr(item.strCodSit, 1);
        detIcms.AddChild('CST').Text := RightStr(item.strCodSit, 2);
      End
      Else If (Not fEmptyStr(strCstSimples)) And (RightStr(item.strCodSit, 2) <> '90') Then
      Begin

         If RightStr(item.strCodSit, 2) = '00' Then
         Begin
           strCstSimples := LeftStr(item.strCodSit,1) + '102';
         End
         Else
         Begin
           strCstSimples := LeftStr(item.strCodSit,1) + '500';
         End;

        detIcms := icms.AddChild('ICMSSN102');
        detIcms.AddChild('Orig').Text := LeftStr(strCstSimples, 1);
        detIcms.AddChild('CSOSN').Text := RightStr(strCstSimples, 3);
      End
      Else If (Not fEmptyStr(strCstSimples)) And (RightStr(item.strCodSit, 2) = '90') Then
      Begin
        detIcms := icms.AddChild('ICMSSN900');
        detIcms.AddChild('Orig').Text := LeftStr(item.strCodSit, 1);
        detIcms.AddChild('CSOSN').Text := strCstSimples;
        detIcms.AddChild('pICMS').Text := fValor(item.fltAlqIcm, 2);
      End;
    End;

    pis := imposto.AddChild('PIS');
    cofins := imposto.AddChild('COFINS');

    If (Pos(item.strCstPis, '01,02') > 0) Then
    Begin
      detPis := pis.AddChild('PISAliq');
      detCofins := cofins.AddChild('COFINSAliq');

      detPis.AddChild('CST').Text := item.strCstPis;
      detPis.AddChild('vBC').Text := fValor(item.fltBasPis, 2);
      detPis.AddChild('pPIS').Text := fValor(item.fltAlqPis / 100, 4);

      detCofins.AddChild('CST').Text := item.strCstCof;
      detCofins.AddChild('vBC').Text := fValor(item.fltBasCof, 2);
      detCofins.AddChild('pCOFINS').Text := fValor(item.fltAlqCof / 100, 4);
    End
    Else If (Pos(item.strCstPis, '04,06,07,08,09') > 0) Then
    Begin
      detPis := pis.AddChild('PISNT');
      detCofins := cofins.AddChild('COFINSNT');

      detPis.AddChild('CST').Text := item.strCstPis;
      detCofins.AddChild('CST').Text := item.strCstCof;
    End
    Else If (Pos(item.strCstPis, '49') > 0) Then
    Begin
      detPis := pis.AddChild('PISSN');
      detCofins := cofins.AddChild('COFINSSN');

      detPis.AddChild('CST').Text := item.strCstPis;
      detCofins.AddChild('CST').Text := item.strCstCof;
    End
    Else If (Pos(item.strCstPis, '99') > 0) Then
    Begin
      detPis := pis.AddChild('PISOutr');
      detCofins := cofins.AddChild('COFINSOutr');

      detPis.AddChild('CST').Text := item.strCstPis;
      detPis.AddChild('vBC').Text := fValor(item.fltBasPis, 2);
      detPis.AddChild('pPIS').Text := fValor(item.fltAlqPis / 100, 4);

      detCofins.AddChild('CST').Text := item.strCstCof;
      detCofins.AddChild('vBC').Text := fValor(item.fltBasCof, 2);
      detCofins.AddChild('pCOFINS').Text := fValor(item.fltAlqCof / 100, 4);
    End;

    If fItemServico(item) Then
    Begin
      strNatOpe := fGetNaturezaOperacao(objConfig, dadosGerais, dadosEmitente);
      If strNatOpe = 'A' Then
      Begin
        strNatOpe := '1';
      End;

      issqn := imposto.AddChild('ISSQN');
      issqn.AddChild('vDeducISSQN').Text := fValor(0, 2);
      issqn.AddChild('vAliq').Text := fValor(dadosGerais.fltValIss / dadosGerais.fltBasIss * 100, 2);
      issqn.AddChild('cMunFG').Text := fTiraCaracEspeciaisSAT(dadosEmitente.strCodIbge);
      issqn.AddChild('cListServ').Text := fTiraCaracEspeciaisSAT(item.strCodListaServ);
      issqn.AddChild('cServTribMun').Text := fTiraCaracEspeciaisSAT(item.strTriMun);
      issqn.AddChild('cNatOp').Text := fTiraCaracEspeciaisSAT(strNatOpe);
      issqn.AddChild('indIncFisc').Text := '2'; // 1 - SIM 2 - NÃO
    End;


  End;

end;

procedure TSATCFE.pCarregaDadosComplementar(raiz: IXMLNode);
  Var
    det: IXMLNode;
    prod: IXMLNode;
    imposto: IXMLNode;
    icms: IXMLNode;
    detIcms: IXMLNode;
    pgto: IXMLNode;
    mp: IXMLNode;
    total: IXMLNode;

    pis, cofins: IXMLNode;
    detPis, detCofins: IXMLNode;

begin

  If assigned(dadosGerais) Then
  Begin
    det := raiz.AddChild('det');
    det.Attributes['nItem'] := '1';

    prod := det.AddChild('prod');
    prod.AddChild('cProd').Text := '00000';

    prod.AddChild('xProd').Text  := fTiraCaracEspeciaisSAT(dadosGerais.strDesIteNC);
    prod.AddChild('NCM').Text    := '00000000';
    prod.AddChild('CFOP').Text   := dadosGerais.strClaFis;
    prod.AddChild('uCom').Text   := 'UN';
    prod.AddChild('qCom').Text   := fValor(0, 4);
    prod.AddChild('vUnCom').Text := fValor(0, 3);
    prod.AddChild('indRegra').Text := 'A';
    prod.AddChild('vDesc').Text := fValor(0, 2);
    prod.AddChild('vOutro').Text := fValor(dadosGerais.fltBasIcm, 2);

    imposto := det.AddChild('imposto');
    icms := imposto.AddChild('ICMS');
    detIcms := icms.AddChild('ICMS00');
    detIcms.AddChild('Orig').Text  := '0';
    detIcms.AddChild('CST').Text   := RightStr(dadosGerais.strCodSit, 2);
    detIcms.AddChild('pICMS').Text := fValor(dadosGerais.fltAlqIcm, 2);

    pis := imposto.AddChild('PIS');
    cofins := imposto.AddChild('COFINS');
    detPis := pis.AddChild('PISSN');
    detCofins := cofins.AddChild('COFINSSN');

    detPis.AddChild('CST').Text := '49';
    detCofins.AddChild('CST').Text := '49';

    total := raiz.AddChild('total');
    total.AddChild('vCFeLei12741').Text := fValor(dadosGerais.fltBasIcm, 2);

    pgto := raiz.AddChild('pgto');
    mp := pgto.AddChild('MP');
    mp.AddChild('cMP').Text := '99';
    mp.AddChild('vMP').Text := fValor(dadosGerais.fltBasIcm, 2);

    raiz.AddChild('infAdic').AddChild('infCpl').Text := fTiraCaracEspeciaisSAT(Trim(dadosGerais.strAceOriNC));
  End;

end;

procedure TSATCFE.pCarregaDadosMeiosPagamento(raiz: IXMLNode);
  Var
    pgto: IXMLNode;
    mp: IXMLNode;

    intContador: Integer;
begin
  If Length(dadosGerais.arrFormasPagamento) > 20 Then
    Exit;

  pgto := raiz.AddChild('pgto');

  For intContador := Low(dadosGerais.arrFormasPagamento) To High(dadosGerais.arrFormasPagamento) Do
  Begin
    mp := pgto.AddChild('MP');
    mp.AddChild('cMP').Text := fTiraCaracEspeciaisSAT(dadosGerais.arrFormasPagamento[intContador].strCodigo);
    If dadosGerais.arrFormasPagamento[intContador].fltValPag = 0 Then
      mp.AddChild('vMP').Text := fValor(dadosGerais.arrFormasPagamento[intContador].fltValor, 2)
    Else
      mp.AddChild('vMP').Text := fValor(dadosGerais.arrFormasPagamento[intContador].fltValPag, 2);

    if (not fEmptyStr(dadosGerais.arrFormasPagamento[intContador].strCodRed)) then
      mp.AddChild('cAdmC').Text := fTiraCaracEspeciaisSAT(dadosGerais.arrFormasPagamento[intContador].strCodRed);
  End;
end;

procedure TSATCFE.pCarregaDadosTotais(raiz: IXMLNode);
  Var
    total: IXMLNode;
  function fTotalTributos: Double;
    Var
      intContador: Integer;
  begin
    Result := 0;
    If Assigned(lstItens) Then
    Begin
      For intContador := 0 To lstItens.Count-1 Do
      Begin
        If TDadosItem(lstItens[intContador]).fltImpPag = 0 Then
          Result := Result + TDadosItem(lstItens[intContador]).fltMunImp +
                             TDadosItem(lstItens[intContador]).fltEstImp +
                             TDadosItem(lstItens[intContador]).fltFedImp 
        Else
          Result := Result + TDadosItem(lstItens[intContador]).fltImpPag;
      End;
    End;
  end;
begin
  total := raiz.AddChild('total');
  total.AddChild('vCFeLei12741').Text := fValor(fTotalTributos, 2);
end;

function TSATCFE.fSessaoPreGravada(strNumDoc, strCodEmp, strCodCli, strSerie: String; blnCancelado: Boolean = False): integer;
  Var
    strSQL: String;
    dataSet: TDataSet;
    strTabela : String;
begin
  Result := 0;

  if (blnCancelado) then
    strTabela := 'CANSES'
  else
    strTabela := 'SATSES';

  if fonteDados.fTabelaExiste(strTabela) then
  begin
    strSQL := '';
    strSQL := strSQL + ' SELECT SES_SESSAO ';
    strSQL := strSQL + '   FROM ' + strTabela;
    strSQL := strSQL + '  WHERE SES_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '    AND SES_ESPDOC = "IF" ';
    strSQL := strSQL + '    AND SES_CODEMP = :CODEMP ';
    strSQL := strSQL + '    AND SES_SERIE_ = :SERIE_ ';
    strSQL := strSQL + '    AND SES_CODCLI = :CODCLI ';

    try
      dataSet := fonteDados.fExecutaQuery(strSQL, ['NUMDOC', 'CODEMP', 'CODCLI', 'SERIE_'],
        [strNumDoc, strCodEmp, strCodCli, strSerie]);
      Result := dataSet.FieldByName('SES_SESSAO').AsInteger;
    finally
      if assigned(dataSet) then
        FreeAndNil(dataSet);
    end;
  end;
end;

function TSATCFE.fSuportaFuncoesAdministrativas: Boolean;
begin
  Result := True;
end;

function TSATCFE.fTiraCaracEspeciaisSAT(strTexto: String): String;
begin
  Result := fTiraCaracEspeciais(strTexto, False, False, False);
end;

function TSATCFE.fUltimoRetornoSATSucesso(var strMensagem: String; blnCancelando: Boolean = False): Boolean;
  Var
    intRetorno : Integer;
begin
  intRetorno := StrToIntDef(fGetValorLinha(String(strUltimoRetornoSAT), '|', 2), 0);
  strMensagem := IntToStr(intRetorno) + '-' + fGetValorLinha(String(strUltimoRetornoSAT), '|', 4);
  Result := (intRetorno = STATUS_SUCESSO_VENDA);

  If (Not Result) And (blnCancelando) Then
    Result := (intRetorno = STATUS_SUCESSO_CANCE);
end;

function TSATCFE.fValor(fltValor: Double; intDecimais: Integer): String;
begin
  Result := FloatToStrF(fltValor, ffNumber, 12, intDecimais);
  Result := AnsiReplaceStr(AnsiReplaceStr(Result, '.', ''), ',', '.');
end;

function TSATCFE.fVerificarStatusNota: Boolean;
begin
  Result := False;
end;

function TSATCFE.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String): TRetornoStatusNFE;
begin
  Result := rsOperacional;
end;

function TSATCFE.fVerificarStatusServico(strCnpjEmitente, strIESEmitente: String;
  var strRetornoConsulta: string): TRetornoStatusNFE;
begin
  Result := rsOperacional;
end;

procedure TSATCFE.pAdicionaItem(dadosItem: TDadosItem);
begin
  If (Not Assigned(lstItens)) Then
    lstItens := TList.Create;

  lstItens.Add(dadosItem);
end;

procedure TSATCFE.pEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String; intSequencial: Integer);
begin
  Raise Exception.Create('Operação não permitida para SAT-CFe.');
end;

procedure TSATCFE.pExtrairNumeroSerieECFe(strArqBase64: AnsiString;
  var strNumeroSerie, strNumeroCFe, strObsFisco: String);
  Var
    xml: TXMLDocument;
    infCFe: IXMLNode;
    ide: IXMLNode;
    infAdic: IXMLNode;
    node: IXMLNode;

    intContador: Integer;
begin
  strObsFisco := '';
  xml := TXMLDocument.Create(Application);
  Try
    xml.LoadFromXML(fDecodeBase64(String(strArqBase64)));
    xml.Active := True;
    Application.ProcessMessages;

    If xml.ChildNodes.Count = 1 Then
    Begin
      infCFe := xml.ChildNodes[0].ChildNodes[0];
    End
    Else
    Begin
      infCFe := xml.ChildNodes[1].ChildNodes[0];
    End;

    For intContador := 0 To infCFe.ChildNodes.Count-1 Do
    Begin
      node := infCFe.ChildNodes.Nodes[intContador];
       If AnsiUpperCase(node.NodeName) = AnsiUpperCase('ide') Then
       Begin
         ide := node;
         Break;
       End;
    End;

    strNumeroSerie := ide.ChildValues['nserieSAT'];
    strNumeroCFe := ide.ChildValues['nCFe'];

    For intContador := 0 To infCFe.ChildNodes.Count-1 Do
    Begin
      node := infCFe.ChildNodes.Nodes[intContador];
      If AnsiUpperCase(node.NodeName) = AnsiUpperCase('infAdic') Then
      Begin
        infAdic := node;
        Break;
      End;
    End;

    If (Assigned(infAdic)) Then
    Begin
      For intContador := 0 To infAdic.ChildNodes.Count-1 Do
      Begin
        node := infAdic.ChildNodes.Nodes[intContador];
        if AnsiUpperCase(node.NodeName) = AnsiUpperCase('obsFisco') Then
        Begin
          If (Not varIsNull(node.ChildValues['xTexto'])) Then
          Begin
            strObsFisco := strObsFisco + node.ChildValues['xTexto'];
            If intContador < infAdic.ChildNodes.Count-1 Then
            Begin
              strObsFisco := strObsFisco + #13#10;
            End;
          End;
        End;
      End;
    End;
  Finally
    FreeAndNil(xml);
  End;
end;

procedure TSATCFE.pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
  strNumeroFinal, strDescricao: String);
begin

end;

procedure TSATCFE.pReimprimeDanfe(strChaveAcesso, strImpressora: String; strImprimirTelaPDF: String = '');
begin
  If not fEmptyStr(strChaveAcesso) Then
    TImpressaoDiretaCitel.pImprimir(fonteDados.fDadosGerais.strCodEmp , strImpressora, strChaveAcesso, 'NFCE');
end;

procedure TSATCFE.pReimprimeDanfe(strChaveAcesso: String);
  Var
    strImpressora: String;
begin
  pLogImp('TSATCFE.pReimprimeDanfe > strChaveAcesso > ' + strChaveAcesso);
  If not fEmptyStr(strChaveAcesso) Then
  Begin
    strImpressora := fDefineImpressora(fonteDados.fDadosGerais);
    pLogImp('pReimprimeDanfe > strImpressora > ' + strImpressora);
    pReimprimeDanfe(strChaveAcesso, fTratarNomeImpressora(strImpressora));
  End;
end;

procedure TSATCFE.pSetaDadosEmitente(dadosEmitente: TDadosEmitente);
begin
  Self.dadosEmitente := dadosEmitente;
end;

procedure TSATCFE.pSetaDadosGerais(dadosGerais: TDadosGerais);
begin
  Self.dadosGerais := dadosGerais;
end;

procedure TSATCFE.pGravaErro(AMsg: String);
Var
  SL: TStringList;
begin
  SL := TStringList.Create;
  Try
    SL.Add('ERRO AO CARREGAR DLL SATCFE: ' + AMsg);
    SL.SaveToFile('ERRO_SATCFE.TXT');
  Finally
    FreeAndNil(SL);
  End;
end;

procedure TSATCFE.pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);
begin

end;

function TSATCFE.fConsultaStatusDFe(strChaveAcesso: string): String;
begin
  Result := '';
end;

function TSATCFE.fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
begin
  Result := '';
end;

function TSATCFE.fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento : String; const strModeloFiscal : String = '55'): String;
begin
  Result := '';
end;

function TSATCFE.fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude,
  strHashEntrega, strHashData: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TSATCFE.fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TSATCFE.fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega,
  strHashData: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TSATCFE.fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  Result := Nil;
end;

initialization

finalization
  If HandleDllSAT <> 0 Then
  Begin
    FreeLibrary(HandleDllSAT);
  End;

end.
