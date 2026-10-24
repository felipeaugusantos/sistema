unit untConexaoBD;

interface
{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}
uses
{$IF Defined(LINUX)}
  FMX.Forms, FMX.frxClass, FMX.frxDBSet, FMX.frxExportPDF, FMX.frxBarcode,
  FMX.frxDelphiZXingQRCode, FMX.Graphics, FMX.Objects, NFe.Modulo, FMX.frxBarcode2DView,
{$ELSE}
  Forms, frxClass, frxExportPDF, frxBarcode, frxDelphiZXingQRCode, frxRich,
  Graphics, Printers, cxImage, frxDBSet, untModulo, Dialogs, frxBarcode2D,
  ShellAPI, Windows,
{$IFEND}
{$IF Defined(UNIDAC)}
{$IF Defined(LINUX)}
  DBClient,
{$ELSE}
  UniClientDataSet,
{$IFEND}
  Uni, MySQLUniProvider, UniProvider,
  System.Generics.Collections, UITypes,
{$IFNDEF VER270}
  NetEncoding,
{$ENDIF}
{$ELSE}
  ZConnection, ZDataset, ZDbcIntfs, Controls,
{$IFEND}
  Classes, DB, EncdDecd,
  untUniClientDataSet;

type
  TTipoImagem = (tpLogo, tpMarcaDagua, tpBrasaoPrefeitura);


type
  TConfiguracao = record
    LayoutPaisagem : string;
    LayoutRetrato : string;
    LayoutSimplificado : string;
    LayoutUnificado    : string;
    LayoutSmartPOS : string;
    Logo: string;
    CodigoEmpresa : string;
    Versao : Double;
    OrientacaoPagina : integer;
    PosicaoRecibo : integer;
    QuantidadeDecimal: integer;
    ValorUnDecimal: integer;
    MarcaDagua : string;
    TemMarcaDagua : boolean;
    ClassifiVenda : boolean;
    NfeCancelada : Boolean;
    ImprimeTagObsCont : Boolean;
    BrasaoPrefeitura : string;
    Prefeitura : string;
    Secretaria : string;
  end;

  TInfosNfsBd = record
    //Informações do prestador da Base de Dados
    strCodEmp   : string;
    strEmail    : string;
    strFone     : string;
    strInsEst   : string;
    strFone2    : string;
    strCNAE     : string;
    strIM       : string;
    strRazSoc   : string;
    strEnder    : string;
    strNume     : string;
    srtBairro   : string;
    strCidad    : string;
    strCEP      : string;
    strUF       : string;
    strCompl    : string;
    strCNPJ     : string;
    strFant     : string;
    strHomePage : string;
    strMunPre   : string;
    strSerMun   : string;
    strCNFNFE   : string;

    // Informações do Tomador da Base de Dados
    strTomadorI_E_S_     : string;
    strTomadorEmail_     : string;
    strTomadorFone01     : string;
    strTomadorUF         : string;
    strTomadorEmail2     : string;
    strTomadorIM         : string;
    strTomadorComplEnder : string;
    strTomadorCelular    : string;
    strTomadorCidade     : string;

    //Informações do documento
    strNumDoc              : string;
    strEspDoc              : string;
    strDiscriminacaoServico: string;

    // Faturas
    strConPag: String;

    strIteDes: String;
    strMovObs: String;
    strObservContratoLocacao : string;
    strPedidoDeCompra : string;
    strInicioContratoLocacao: string;
    strFimContratoLocacao: string;
    strVencimentoFatura: string;
    strNumeroContratoLocacao: string;

  end;

  TConexaoBD = class
  private
    FDatabase: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
    FInfosNfsBd: TInfosNfsBd;
    function RetornarLogotipo(AChaveAcesso, ACodigoEmpresa: String; ALogoDefault: WideString): string;
    function fAbrirQueryLayoutDANFe(strCodigoEmpresa, strModelo: string; fltVersaoNFe: Double): {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    function fClassifiVenda(AChaveAcesso, ACodigoEmpresa: string; AClaFis: String=''): Boolean;
  public
    FConfiguracao : TConfiguracao;
    FLayoutDinamico: Boolean;

    function fTabelaExiste(const strTabela: String): Boolean;
    function fCampoExiste(const strTabela, strCampo: String): Boolean;
    function fUtilizaCadastroImpressoras(): Boolean;

    function fDocumentoEmitidoSmartPOS(AChaveAcesso: String; AstrOpcDoc: String=''): Boolean;
    function fPontoImpressaoUtilizaLayoutSimplificado(AChaveAcesso: String; AstrPonImp: String=''): Boolean;
    function fRetornaNomeImpressoraSpoolerImpressaoCitel(AChaveAcesso: String; AstrPonImp: String=''): string;
    function fAcharImpressoraPeloPonto(const APonto: String): String;

    function fIdentificarNomeDaImpressora(const AImpressora: String): String;

    constructor Create(Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND});
    destructor Destroy; override;

    function fNfeCancelada(AChaveAcesso, ACodigoEmpresa: string; AFisHis: String=''): Boolean;
    function CarregarXML(AChaveAcesso: string): string;
    function CarregarCFGSIS(AConfiguracao: string) : string;
    procedure CarregarConfiguracao(AChaveAcesso, ACodigoEmpresa, AModelo: string; AVersaoNFe: Double; AFisHis: String=''; AClaFis: String='');
    function RetornarCodigoEmpresa(AChaveAcesso: string): string;
{$IF Defined(LINUX)}
    function CarregarImagemBase64(ACodigoEmpresa: string; AVersaoNFe: Double; picImagem : FMX.Graphics.TBitmap; tpImagem: TTipoImagem; AModelo: string): Boolean;
    procedure SalvarImagemBase64(LCodigoEmpresa: string; LVersaoNFe: Double; picImagem : TImage; tpImagem: TTipoImagem; LModelo: string; blnAplicarTodasEmpresas: Boolean = False);
{$ELSE}
    function CarregarImagemBase64(ACodigoEmpresa: string; AVersaoNFe: Double; picImagem : TPicture; tpImagem: TTipoImagem; AModelo: string): Boolean;
    procedure SalvarImagemBase64(LCodigoEmpresa: string; LVersaoNFe: Double; picImagem : TGraphic; tpImagem: TTipoImagem; LModelo: string; blnAplicarTodasEmpresas: Boolean = False);
{$IFEND}
    function fGetInfComplementar(DataSet: TDataSet; strQuebra: String; strDadCli: String = ''; blnPossuiItensEmPromocao: Boolean = False; blnRetornaOpe: Boolean = True; blnRetornaInfo: Boolean = True): String;
    function fUsaSat : Boolean;
    procedure pCarregaModalidadesPagamento(fltTotGer: Double; strNumDoc, strEspDoc,
      strCodEmp, strCodCli, strSerie: String; Var strModalidades, strValores, strCarConPag, strParcelasCartao, strDescrCartao: String);
    function fSatComplementar(strCodEmp, strAcesso: string): Boolean;

    procedure pGetDadosEmpresa(ACodigoEmpresa  : String;
                               out strRazSoc   : String;
                               out strEmail    : String;
                               out strHomepage : String;
                               out strFone2    : String;
                               out strCNAE     : String;
                               out strIM       : String;
                               out strCNPJ     : String); overload;

    procedure pGetDadosEmpresa(ACodigoEmpresa  : String;
                               out strEmail    : String;
                               out strFone     : String;
                               out strInsEst   : String;
                               out strFone2    : String;
                               out strCNAE     : String;
                               out strIM       : String;
                               out strRazSoc   : String;
                               out strEnder    : String;
                               out strNume     : String;
                               out srtBairro   : String;
                               out strCidad    : String;
                               out strCEP      : String;
                               out strUF       : String;
                               out strCompl    : String;
                               out strCNPJ     : String;
                               out strFant     : String;
                               out strHomePage : String); overload;

    procedure pImportarLayoutDANFe(strCodigoEmpresa, strModelo: string; fltVersaoNFe: Double;
      intTipoLayout: Integer; strCaminhoArquivo: String; ALayoutSimplificado, ALayoutSmartPOS: Boolean;
      ALayoutUnificado: Boolean = False);

    procedure pExportarLayoutDANFe(strCodigoEmpresa, strModelo: string; fltVersaoNFe: Double;
      intTipoLayout: Integer; strCaminhoArquivo: String; ALayoutSimplificado, ALayoutSmartPOS: Boolean;
      ALayoutUnificado: Boolean = False);

    procedure pGetDadosCndFpg(strNumDoc, strEspDoc, strCodEmp : String; out strDadosCndFpg : String);
    procedure pSetaEmpresa(strCodEmp: String);
    procedure pGerarQrCodeNfs(var frxDanfe:TfrxReport;
     strNomeObjQrCode, strLinkQrCode: String);
    function fGetQrCode(AChaveAcesso, ACodigoEmpresa: String): String;
    function CarregarPDF(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean): string;
    function fBase64Codifica(ATexto: String): String;
    function fBase64Decodifica(ATexto: String): String;
    procedure pExportaPDF(ATexto: String; APath: String);
    procedure pSalvarDFePDF(ADanfe: TfrxReport; AChaveAcesso: String; ALayoutSimplificado: Boolean = False);
    procedure pSalvarDFEBMP(ADanfe: TfrxReport; APath: String);
    procedure pSalvarPDFNFeBD(AChaveAcesso: string; APDFStream: TStringStream; ALayoutSimplificado: Boolean);
    function fPrefeituraComLayoutNfse(strCidNfs: string): Boolean;
    procedure pGetTomadorParaENotas(strNumDoc, strEspDoc, strCodEmp : String;
                                    out strTomadorI_E_S_, strTomadorEmail_, strTomadorFone01, strTomadorUF, strTomadorEmail2,
                                    strTomadorIM, strTomadorCidade, strTomadorComplEnder, strTomadorCelular: String); overload;
    procedure pGetDiscriminacaoServico(strNumDoc, strEspDoc, strCodEmp, strTip_FC: String;
                                       out strDiscriminacaoServico, strMunPre, strSerMun, strCNFNFE, strMovObs: String); overload;
    procedure pGetListaDeServico(strNumDoc, strEspDoc, strCodEmp: string;
                                       out strCodSer: String);
    procedure pGetItensServicoParaENotas(strNumDoc, strEspDoc, strCodEmp : String; out strIteDes: String ) overload;
    procedure pGetItensServicoParaENotas(var cdsItens: TUniClientDataSet; strNumDoc, strEspDoc, strCodEmp : String; out strIndOpe: String; out strCodNBS: String ) overload;
    procedure pGetDadosSerObs(strNumDoc, strEspDoc, strCodEmp : String; out strSerObs : String);
    procedure pGetDeducaoISSQN(strNumDoc, strEspDoc, strCodEmp : String; out fltVALDED : Double);
    function fRetObsOrdemServ(strNumDoc, strEspDoc, strCodEmp: string): string;
    function fRetDesIte(strNumDoc, strEspDoc, strCodEmp: string): string;
    function fMontaDtaVenCarteira(strNumDoc, strEspDoc, strCodEmp: string): string;
    function fRetMsgPed(strNumDoc, strEspDoc, strCodEmp: string): string;
    function fRetNFUti(strNumDoc, strEspDoc, strCodEmp: string; out strEmpNF, strEspNF, strNumNF : String): string;
    function fRetOSUti(strNumDoc, strEspDoc, strCodEmp: string): string;
    procedure pGetDadosCancelamentoNFS(strNumDoc, strEspDoc, strCodEmp : String; out strDtaDel, strHorDel, strMotDel : String);
    function fGetConnectionID: String;
    procedure pLimpaCfg(ACodigoEmpresa, ACodigoCFG: string);
    function fCriarQryRetencoesNs(strChaveAcesso: String): {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    function fRetDescClassificacaoServico(strCodigo: string): string;

    procedure pPreencheCdsFaturas(var cdsFaturas: TUniClientDataSet);
  	procedure pGetTomadorParaENotas(strNumDoc, strEspDoc, strCodEmp : String); overload;
	  procedure pGetDadosNfsBd(strCodEmp, strNumDoc, strEspDoc, strTip_Fc: String);
	  procedure pGetDiscriminacaoServico(strNumDoc, strEspDoc, strCodEmp, strTip_FC: String); overload;
	  procedure pGetDadosEmpresa(ACodigoEmpresa  : String); overload;
    procedure pGetValoresRetencoesNFS(strNumDoc, strEspDoc, strCodEmp, strSerie_ : String; out fltVlrCofins, fltVlrCsll, fltVlrPis, fltVlrIr, fltVlrInss : Double);
    function fMontaCarteira(strNumDoc, strEspDoc, strCodEmp: string): string;
    procedure pGetMensagemDadosFiscais(strNumDoc, strEspDoc, strCodEmp: string; out strMsgFis: String);
    procedure pRetornarItensContratoLocacao(var cdsItens: TUniClientDataSet; strNumDoc, strEspDoc, strCodEmp: String);
    procedure pRetornarObservacaoContratoLocacao(strNumDoc, strEspDoc, strCodEmp: String);
    procedure pRetornarPedidoDeCompra(strNumDoc, strEspDoc, strCodEmp: String);
    procedure pGetModalidade(strNumDoc, strEspDoc, strCodEmp: String; out strModalidadeValor: String);
  end;

  TImpressaoNfs =  class
    private
      objConexaoBD: TConexaoBD;
      frxDanfe: TfrxReport;
      frxDbDanfe: TfrxDBDataset;
      frxDbItens: TfrxDBDataset;
      frxDbFaturas: TfrxDBDataset;
      frxPDFExport: TfrxPDFExport;
      arrCdsNfs: Array Of TUniClientDataSet;
      arrFrxDb: Array Of TfrxDBDataset;
      FDatasetsDinProprios: Boolean;

    public
      strPDF_Diretorio,
      strImpressora,
      strChaveAcesso,
      FProvedorDin,
      FXmlDin: String;
      blnDesignReport,
      blnReimpressao,
      blnPDF_Gerar,
      blnPDF_Banco,
      blnPDF_Apresentar: Boolean;
      constructor Create(var AConexaoBD: TConexaoBD); overload;
      destructor Destroy; override;
      procedure pCarregaVariaveisPadrao;
      procedure pFormataCamposPadrao;
      procedure pImprimeDanfeNfs;
      procedure pImprimeDanfeNfsDinamica;
      procedure pAddArrCdsNfs(arr: TUniClientDataSet);

      procedure pConfigurarLogotipoDanfse;
  end;

 TTraducaoXml = class
   class function fEhOptanteSimplesNacional(strValor: String) : String;
   class function fExigivelIss(strValor: String) : String;
   class function fTemIncentivoFiscal(strValor: String) : String;
   class function fValidaRegimeEspTri(strValor: String): String;
   class function fEhIssRetido(strValor: String) : String;
   class function fRetNatOpe(strValor: String) : String;
   class function fEhTributacaoISSQN(strValor: String): String;
   class function fRegimeEspecialTributacao(strValor: String): String;
   class function fEhOptanteSimplesNacionalPortalNacional(strValor: String): String;
   class function fValidaRegimeApTribSNPortalNacional(strValor: String): String;
   class function fValidaRegimeEspTriPortalNacional(strValor: String): String;
   class function fValidaRegimeEspTriABRASF(strValor: String): String;
   class function fValidaISSRetidoPortalNacional(strValor: String): String;
   class function fDescricaoRetPisCofinsPortalNacional(strValor: String): String;

 end;

Var
  VS_Desativa_eNotas: Boolean;

implementation

uses
  SysUtils, IniFiles, StrUtils,
  untImagemBase64, untDicSis, untNfsDinamico,
  untUtil, untConfImpressora,
{$IF Defined(LINUX)}
  FMX.frxExportImage
{$ELSE}
  frxExportImage
{$IFEND}
  ;

constructor TConexaoBD.Create(Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND});
begin
  If Not Assigned(Database) Then
    Raise Exception.Create('Não foi definido a conexão!');

  FConfiguracao.TemMarcaDagua := fCampoExiste('IMPNFE', 'NFE_MDAGUA');
end;

destructor TConexaoBD.Destroy();
begin
  inherited;
end;

function TConexaoBD.fTabelaExiste(const strTabela: String): Boolean;
  Var
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
    lBanco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
Begin
  If (fEmptyStr(strTabela)) Then
  Begin
    Result := False;
    Exit;
  End;

  If Assigned(FDatabase) Then
    lBanco := FDatabase
  Else
    lBanco := frmModulo.Database;

  {$IF Defined(UNIDAC)}
  strKey := fFormataKeyTabExiParaDicSis(strTabela);
  If fAchouDicSisBln(lBanco, strKey, Result) Then
    Exit;
  {$IFEND}

  Result := fTabelaCampoExiste(lBanco, strTabela);

  {$IF Defined(UNIDAC)}
  pInsereDicSis(lBanco, strKey, fBooleanToStringDisSis(Result));
  {$IFEND}
end;

function TConexaoBD.fIdentificarNomeDaImpressora(const AImpressora: String): String;
{$IF Defined(LINUX)}
begin
  Result := AImpressora;
end;
{$ELSE}
  Var
    intCnt : Integer;
    qryExpressoes : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strExpressao: String;
    blnIdentificou: Boolean;
    blnPreVerifica: Boolean;
    strNomeImpressoraNoWindows: String;

  function fIdentificouImpressora(APrinter: String): Boolean;
    Var
      qryExpressoesResult : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  begin
    Result := False;
    qryExpressoes.First;
    While Not qryExpressoes.Eof Do
    Begin
      strExpressao := 'SELECT ' +
        QuotedStr(APrinter) + ' LIKE ' +
        QuotedStr(AnsiReplaceStr(AnsiReplaceStr(
                  qryExpressoes.FieldByName('IDE_EXPRES').AsString,
                  'NOME_IMPRESSORA', AImpressora),
                  '\', '\\'));

      qryExpressoesResult := fCriaQuery(nil);
      Try
        pLogImp('Testando como: '+strExpressao);
        qryExpressoesResult.SQL.Text := strExpressao;
        qryExpressoesResult.Open;

        If qryExpressoesResult.Fields[0].AsInteger > 0 Then
        Begin
          pLogImp('Identificou como: '+strExpressao);
          Result := True;
          Break;
        End;
      Finally
        FreeAndNil(qryExpressoesResult);
      End;

      qryExpressoes.Next;
    End;
  end;

begin
  Result := AImpressora;

  If fEmptyStr(Result) Then
    Exit;

  If fArqIniLocal(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S', fPathOpcoesIni) <> 'N' Then
    If (CarregarCFGSIS('SPOIMP') = 'S') Then
      Exit;

  If (CarregarCFGSIS('CADIMP') <> 'S') Then
    Exit;

  pLogImp('Identificando nome da impressora "'+AImpressora+'" pelo "Cadastro de Impressoras" [CFG_CADIMP]');

  qryExpressoes := fCriaQuery(nil);
  blnIdentificou := False;
  Try
    qryExpressoes.SQL.Text := 'SELECT IDE_EXPRES FROM IDEIMP';
    qryExpressoes.Open;

    Printer.Refresh;

    blnPreVerifica := True;
    If (CarregarCFGSIS('CIVRDR') = 'S') Then
      blnPreVerifica := False;

    For intCnt := 0 To Printer.Printers.Count -1 Do
    Begin
      strNomeImpressoraNoWindows := Printer.Printers[intCnt];

      If (blnPreVerifica) Then
      Begin
        If (Pos(AnsiUpperCase(AImpressora), AnsiUpperCase(strNomeImpressoraNoWindows)) = 0) Then
        Begin
          If (Printer.Printers.Count <= 100) Then
            pLogImp('Impressora [IGNORADA]: ' + strNomeImpressoraNoWindows);

          Continue;
        End;
      End;

      pLogImp('Impressora [TESTAR]: ' + strNomeImpressoraNoWindows);
      If fIdentificouImpressora(strNomeImpressoraNoWindows) Then
      Begin
        If VerImpressoraONLINE(strNomeImpressoraNoWindows) = 0 Then
        Begin
          blnIdentificou := True;
          pLogImp('Identificado. Impressora: '+AImpressora+' é '+strNomeImpressoraNoWindows+' no Windows');

          Result := strNomeImpressoraNoWindows;
          Break;
        End
        Else
          pLogImp('Identificado. Impressora: '+AImpressora+' é '+strNomeImpressoraNoWindows+' no Windows, porém, ela está OFF-LINE e não será considerada');
      End;
    End;
  Finally
    If (Not blnIdentificou) Then
      pLogImp('Impressora não identificada. Irá permanecer "'+AImpressora+'"');

    FreeAndNil(qryExpressoes);
  End;
end;
{$IFEND}

function TConexaoBD.fMontaDtaVenCarteira(strNumDoc, strEspDoc,
  strCodEmp: string): string;
var
  dtaVenCar : String;
  qryDta: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := EmptyStr;
  qryDta := fCriaQuery;
  FInfosNfsBd.strVencimentoFatura := EmptyStr;

  try
    qryDta.Close;
    qryDta.SQL.Clear;
    qryDta.SQL.Add('SELECT CR.CTR_DTAVEN AS DTAVEN                        ');
    qryDta.SQL.Add('  FROM MOVGER MG                                      ');
    qryDta.SQL.Add('  JOIN CADREC CR ON CR.CTR_NUMDUP = MG.GER_NUMDOC AND ');
    qryDta.SQL.Add('    CR.CTR_ESPDOC = MG.GER_ESPDOC AND                 ');
    qryDta.SQL.Add('    CR.CTR_CODEMP = MG.GER_CODEMP                     ');
    qryDta.SQL.Add('  WHERE MG.GER_CODEMP = :CODEMP                       ');
    qryDta.SQL.Add('    AND MG.GER_ESPDOC = :ESPDOC                       ');
    qryDta.SQL.Add('    AND MG.GER_NUMDOC = :NUMDOC                       ');


    qryDta.ParamByName('CODEMP').AsString := strCodEmp;
    qryDta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDta.ParamByName('NUMDOC').AsString := strNumDoc;

    qryDta.Open;

    if (not qryDta.IsEmpty) then
    begin

      While not qryDta.eof do
      Begin
        if dtaVenCar <> EmptyStr then
          dtaVenCar := dtaVenCar + ' - ';
        dtaVenCar := dtaVenCar + qryDta.FieldByName('DTAVEN').AsString;
        qryDta.Next;
      End;

      FInfosNfsBd.strVencimentoFatura := dtaVenCar;

      Result := dtaVenCar;
    end;
  finally
    FreeAndNil(qryDta);
  end;
end;

function TConexaoBD.CarregarCFGSIS(AConfiguracao: string) : string;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
    LCodEmp: String;
begin
  Result := EmptyStr;

  If VS_Desativa_eNotas And (AConfiguracao = 'NFSENO') Then
  Begin
    Result := 'N';
    Exit;
  End;

  if FConfiguracao.CodigoEmpresa = EmptyStr then
  begin
    pRetornaParamSeExistir(consTagParamsEmp, LCodEmp, True);
    LCodEmp := IfEmptyStr(LCodEmp, ParamStr(2));
  end
  else
    LCodEmp := FConfiguracao.CodigoEmpresa;

  qryGen := fCriaQuery(nil, FDatabase);
  Try
    {$IF Defined(UNIDAC)}
    strKey := fFormataKeyValCfgParaDicSis(AConfiguracao, LCodEmp);
    If fAchouDicSisStr(qryGen.Connection, strKey, Result) Then
      Exit;
    {$IFEND}

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT SQL_NO_CACHE SIS_VALCFG FROM CFGSIS WHERE SIS_CODEMP = :CODEMP AND SIS_CODCFG = :CODCFG');
    qryGen.ParamByName('CODEMP').Value := LCodEmp;
    qryGen.ParamByName('CODCFG').Value := 'CFG_' + AConfiguracao;
    qryGen.Open();
    If not qryGen.IsEmpty Then
      Result := qryGen.FieldByName('SIS_VALCFG').AsString;

    {$IF Defined(UNIDAC)}
    pInsereDicSis(qryGen.Connection, strKey, Result);
    {$IFEND}
  Finally
    qryGen.Free();
  End;
end;

function TConexaoBD.CarregarXML(AChaveAcesso: string): string;
var
  qryXML : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := EmptyStr;

  qryXML := fCriaQuery(nil, FDatabase);
  try
    qryXML.Close;
    qryXML.SQL.Clear;
    qryXML.SQL.Add('SELECT NFE_ARQXML FROM XMLNFE WHERE NFE_ACESSO = :ACESSO');
    qryXML.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryXML.Open;
    qryXML.First;

    if qryXML.IsEmpty then
      raise Exception.Create('Nenhum registro foi encontrado na tabela XMLNFE para carregar o XML.');

    if qryXML.FieldByName('NFE_ARQXML').IsNull then
      raise Exception.Create('O XML está vazio.');

    Result := qryXML.FieldByName('NFE_ARQXML').AsString;
  finally
    qryXML.free;
  end;
end;

function TConexaoBD.RetornarCodigoEmpresa(AChaveAcesso: string): string;
var
  qryXML : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := EmptyStr;

  qryXML := fCriaQuery(nil, FDatabase);
  try
    qryXML.Close;
    qryXML.SQL.Clear;
    qryXML.SQL.Add('SELECT FIS_CODEMP FROM CADFIS WHERE FIS_ACESSO = :ACESSO');
    qryXML.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryXML.Open;
    qryXML.First;

    if qryXML.IsEmpty then
        raise Exception.Create('Nenhum registro foi encontrado na tabela CADFIS para recuperar o código da empresa.');

    if qryXML.FieldByName('FIS_CODEMP').IsNull then
        raise Exception.Create('Código da empresa está vazio.');

    Result := qryXML.FieldByName('FIS_CODEMP').AsString;
  finally
    qryXML.free;
  end;
end;

function TConexaoBD.fRetOSUti(strNumDoc, strEspDoc, strCodEmp: string): string;
Var
  qryOS: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  Result := EmptyStr;
  qryOS := fCriaQuery;

  Try
    qryOS.Close;
    qryOS.SQL.Clear;
    qryOS.SQL.Add(' SELECT DISTINCT EQUGER.EQU_NUMOSE                          ');
    qryOS.SQL.Add('  FROM EQUGER                                               ');
    qryOS.SQL.Add('  LEFT JOIN MOVDET ON MOVDET.DET_NUMDOC = :NUMDOC           ');
    qryOS.SQL.Add('   AND MOVDET.DET_ESPDOC = :ESPDOC                          ');
    qryOS.SQL.Add('   AND MOVDET.DET_CODEMP = :CODEMP                          ');
    qryOS.SQL.Add('  WHERE EQUGER.EQU_NUMPED = MOVDET.DET_NUM_PD               ');
    qryOS.SQL.Add('    AND EQUGER.EQU_CODEMP = MOVDET.DET_EMP_PD               ');
    qryOS.SQL.Add('    AND EQUGER.EQU_TIPPED = MOVDET.DET_ESP_PD               ');

    qryOS.ParamByName('NUMDOC').AsString := strNumDoc;
    qryOS.ParamByName('ESPDOC').AsString := strEspDoc;
    qryOS.ParamByName('CODEMP').AsString := strCodEmp;


    qryOS.Open;

    If (Not qryOS.IsEmpty) Then
    Begin
      Result := qryOS.FieldByName('EQU_NUMOSE').AsString;
    End;
  Finally
    FreeAndNil(qryOS);
  End;
End;

function TConexaoBD.RetornarLogotipo(AChaveAcesso, ACodigoEmpresa: String; ALogoDefault: WideString): string;
var
  qryLogotipo : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LCodigoVendedor: string;
begin
  Result := EmptyStr;

  if (CarregarCFGSIS('CITLVE') = 'S') And fTabelaExiste('OPELTP') then
  begin
    qryLogotipo := fCriaQuery(nil, FDatabase);
    try
      qryLogotipo.Close;
      qryLogotipo.SQL.Clear;
      qryLogotipo.SQL.Add('SELECT COALESCE(B.GER_CODVEN, C.GER_CODVEN) AS CODVEN');
      qryLogotipo.SQL.Add('FROM CADFIS A');
      qryLogotipo.SQL.Add('LEFT JOIN MOVGER B ON A.FIS_CODEMP = B.GER_CODEMP');
      qryLogotipo.SQL.Add('                                 AND A.FIS_NUMDOC = B.GER_NUMDOC');
      qryLogotipo.SQL.Add('                                 AND A.FIS_ESPDOC = B.GER_ESPDOC');
      qryLogotipo.SQL.Add('                                 AND A.FIS_SERIE_ = B.GER_SERIE_');
      qryLogotipo.SQL.Add('                                 AND A.FIS_TIP_FC = B.GER_TIP_FC');
      qryLogotipo.SQL.Add('                                 AND A.FIS_FORCLI = IF(B.GER_TIP_FC = "C", B.GER_CODCLI, B.GER_CODFOR)');
      qryLogotipo.SQL.Add('LEFT JOIN NOTGER C ON A.FIS_CODEMP = C.GER_CODEMP');
      qryLogotipo.SQL.Add('                                 AND A.FIS_NUMDOC = C.GER_NUMDOC');
      qryLogotipo.SQL.Add('                                 AND A.FIS_ESPDOC = C.GER_ESPDOC');
      qryLogotipo.SQL.Add('                                 AND A.FIS_SERIE_ = C.GER_SERIE_');
      qryLogotipo.SQL.Add('                                 AND A.FIS_TIP_FC = C.GER_TIP_FC');
      qryLogotipo.SQL.Add('                                 AND A.FIS_FORCLI = IF(C.GER_TIP_FC = "C", C.GER_CODCLI, C.GER_CODFOR)');
      qryLogotipo.SQL.Add('WHERE A.FIS_ACESSO = :ACESSO AND A.FIS_CODEMP = :CODEMP');
      qryLogotipo.ParamByName('ACESSO').AsString := AChaveAcesso;
      qryLogotipo.ParamByName('CODEMP').AsString := ACodigoEmpresa;
      qryLogotipo.Open;
      qryLogotipo.First;

      if (not qryLogotipo.IsEmpty) and (not qryLogotipo.FieldByName('CODVEN').IsNull) then
      begin
        LCodigoVendedor := qryLogotipo.FieldByName('CODVEN').AsString;
        qryLogotipo.Close;
        qryLogotipo.SQL.Clear;
        qryLogotipo.SQL.Add('SELECT LTP_IMAGEM AS IMG FROM OPELTP WHERE LTP_CODOPE = :CODOPE');
        qryLogotipo.ParamByName('CODOPE').AsString := LCodigoVendedor;
        qryLogotipo.Open;
        qryLogotipo.First;
        Result := TBlobField(qryLogotipo.FieldByName('IMG')).AsString;
      end;
    finally
      qryLogotipo.free;
    end;
  end;

  if (Length(Trim(Result)) = 0) then
    Result := ALogoDefault;
end;

procedure TConexaoBD.CarregarConfiguracao(AChaveAcesso, ACodigoEmpresa, AModelo: string; AVersaoNFe: Double; AFisHis: String=''; AClaFis: String='');
var
  qryConf : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strLogo : string;
{$IF Defined(LINUX)}
  imgLogotipo : TImage;
{$ELSE}
  imgLogotipo : TPicture;
{$IFEND}

begin
  qryConf := fCriaQuery(nil, FDatabase);
  try

    if (AModelo = 'NFS') then
    begin
      strLogo := CarregarCFGSIS('LOGNFS');
      if (not fEmptyStr(strLogo)) then
      begin
        if (FileExists(strLogo)) then
        begin
        {$IF Defined(LINUX)}
          imgLogotipo := TImage.Create(nil);
          try
            imgLogotipo.Bitmap.LoadFromFile(strLogo);
            SalvarImagemBase64(ACodigoEmpresa, AVersaoNFe, imgLogotipo, tpLogo, AModelo, False);
            pLimpaCfg(ACodigoEmpresa, 'LOGNFS');
          finally
            FreeAndNil(imgLogotipo);
          end;
        {$ELSE}
          imgLogotipo := TPicture.Create();
          try
            imgLogotipo.LoadFromFile(strLogo);
            SalvarImagemBase64(ACodigoEmpresa, AVersaoNFe, imgLogotipo.Graphic, tpLogo, AModelo, False);
            pLimpaCfg(ACodigoEmpresa, 'LOGNFS');
          finally
            FreeAndNil(imgLogotipo);
          end;
        {$IFEND}
        end;
      end;
    end;

    if (AModelo = 'NFCE') and (CarregarCFGSIS('LOGNFC')='S') then
    begin
      strLogo := CarregarCFGSIS('PTLNFC');
      if (not fEmptyStr(strLogo)) then
      begin
        if (FileExists(strLogo)) then
        begin
        {$IF Defined(LINUX)}
          imgLogotipo := TImage.Create(nil);
          try
            imgLogotipo.Bitmap.LoadFromFile(strLogo);
            SalvarImagemBase64(ACodigoEmpresa, AVersaoNFe, imgLogotipo, tpLogo, AModelo, False);
            pLimpaCfg(ACodigoEmpresa, 'PTLNFC');
          finally
            FreeAndNil(imgLogotipo);
          end;
        {$ELSE}
          imgLogotipo := TPicture.Create();
          try
            imgLogotipo.LoadFromFile(strLogo);
            SalvarImagemBase64(ACodigoEmpresa, AVersaoNFe, imgLogotipo.Graphic, tpLogo, AModelo, False);
            pLimpaCfg(ACodigoEmpresa, 'PTLNFC');
          finally
            FreeAndNil(imgLogotipo);
          end;
        {$IFEND}
        end;
      end;
    end;

    qryConf.Close;
    qryConf.SQL.Clear;
    qryConf.SQL.Add('SELECT        ');
    qryConf.SQL.Add('  NFE_CODEMP, ');
    qryConf.SQL.Add('  NFE_VERSAO, ');
    qryConf.SQL.Add('  NFE_ORIENT, ');
    qryConf.SQL.Add('  NFE_POSREC, ');
    qryConf.SQL.Add('  NFE_LOGO,   ');
    if (FConfiguracao.TemMarcaDagua) then
      qryConf.SQL.Add('NFE_MDAGUA, ');

    if fCampoExiste('IMPNFE', 'NFE_LAYSIM') then
      qryConf.SQL.Add('NFE_LAYSIM, ')
    else
      qryConf.SQL.Add('CAST("" AS CHAR(1)) AS NFE_LAYSIM, ');

    if fCampoExiste('IMPNFE', 'NFE_LAYSMA') then
      qryConf.SQL.Add('NFE_LAYSMA, ')
    else
      qryConf.SQL.Add('CAST("" AS CHAR(1)) AS NFE_LAYSMA, ');

    if fCampoExiste('IMPNFE', 'NFE_LAYUNI') then
      qryConf.SQL.Add('NFE_LAYUNI, ')
    else
      qryConf.SQL.Add('CAST("" AS CHAR(1)) AS NFE_LAYUNI, ');

    qryConf.SQL.Add('  NFE_LAYPSG, ');
    qryConf.SQL.Add('  NFE_LAYRET  ');

    if FLayoutDinamico then
    begin
      if fCampoExiste('IMPNFE', 'NFE_LAYDMP') then
        qryConf.SQL.Add(' ,NFE_LAYDMP ');
      if fCampoExiste('IMPNFE', 'NFE_LAYDMR') then
        qryConf.SQL.Add(' ,NFE_LAYDMR ');
      if (AModelo = 'NFE') and fCampoExiste('IMPNFE', 'NFE_LAYDMS') then
        qryConf.SQL.Add(' ,NFE_LAYDMS ');
    end;

    if fCampoExiste('IMPNFE', 'NFE_BRASAO') then
      qryConf.SQL.Add(' ,NFE_BRASAO ');

    if fCampoExiste('IMPNFE', 'NFE_NOMPRE') then
      qryConf.SQL.Add(' ,NFE_NOMPRE ');

    if fCampoExiste('IMPNFE', 'NFE_NOMSEC') then
      qryConf.SQL.Add(' ,NFE_NOMSEC ');

    qryConf.SQL.Add('FROM IMPNFE   ');

    if (ACodigoEmpresa <> EmptyStr) then
    begin
      qryConf.SQL.Add('WHERE NFE_CODEMP = :CODEMP');
      qryConf.SQL.Add('  AND NFE_VERSAO = :VERSAO');
      qryConf.SQL.Add('  AND NFE_MODELO = :MODELO');

      qryConf.ParamByName('CODEMP').AsString := ACodigoEmpresa;
      qryConf.ParamByName('VERSAO').AsFloat  := AVersaoNFe;
      qryConf.ParamByName('MODELO').AsString := AModelo;
    end
    else
      qryConf.SQL.Add('ORDER BY NFE_CODEMP, NFE_VERSAO');
    qryConf.Open();
    qryConf.First;

    if qryConf.IsEmpty then
      raise Exception.Create('Cadastre as configurações de impressão na tabela IMPNFE da empresa (' + ACodigoEmpresa + ') e versão NFe(' + FormatFloat('#,##0.00', AVersaoNFe) + ').');

    FConfiguracao.ImprimeTagObsCont  := CarregarCFGSIS('IMPOXV') = 'S';
    FConfiguracao.CodigoEmpresa      := qryConf.FieldByName('NFE_CODEMP').AsString;
    FConfiguracao.Versao             := qryConf.FieldByName('NFE_VERSAO').AsFloat;
    FConfiguracao.OrientacaoPagina   := qryConf.FieldByName('NFE_ORIENT').AsInteger;
    FConfiguracao.PosicaoRecibo      := qryConf.FieldByName('NFE_POSREC').AsInteger;

    FConfiguracao.Logo               :=  RetornarLogotipo(AChaveAcesso, ACodigoEmpresa, qryConf.FieldByName('NFE_LOGO').AsString);

    if (FConfiguracao.TemMarcaDagua) then
      FConfiguracao.MarcaDagua       :=  qryConf.FieldByName('NFE_MDAGUA').AsString;

    FConfiguracao.ClassifiVenda      :=  fClassifiVenda(AChaveAcesso, ACodigoEmpresa, AClaFis);

    FConfiguracao.NfeCancelada       :=  fNfeCancelada(AChaveAcesso, ACodigoEmpresa, AFisHis);

    FConfiguracao.LayoutPaisagem     := qryConf.FieldByName('NFE_LAYPSG').AsString;
    FConfiguracao.LayoutRetrato      := qryConf.FieldByName('NFE_LAYRET').AsString;

    if FLayoutDinamico and ((AModelo = 'NFS') or (AModelo = 'NFE') or (AModelo = 'NFCE')) then
    begin
      if (qryConf.FindField('NFE_LAYDMP') <> nil) and
         (Trim(qryConf.FieldByName('NFE_LAYDMP').AsString) <> '') then
        FConfiguracao.LayoutPaisagem := qryConf.FieldByName('NFE_LAYDMP').AsString;
      if (qryConf.FindField('NFE_LAYDMR') <> nil) and
         (Trim(qryConf.FieldByName('NFE_LAYDMR').AsString) <> '') then
        FConfiguracao.LayoutRetrato  := qryConf.FieldByName('NFE_LAYDMR').AsString;
    end;

    FConfiguracao.LayoutSimplificado := qryConf.FieldByName('NFE_LAYSIM').AsString;

    if FLayoutDinamico and (AModelo = 'NFE') and (qryConf.FindField('NFE_LAYDMS') <> nil) and
       (Trim(qryConf.FieldByName('NFE_LAYDMS').AsString) <> '') then
      FConfiguracao.LayoutSimplificado := qryConf.FieldByName('NFE_LAYDMS').AsString;
    FConfiguracao.LayoutUnificado    := qryConf.FieldByName('NFE_LAYUNI').AsString;
    FConfiguracao.LayoutSmartPOS     := qryConf.FieldByName('NFE_LAYSMA').AsString;

    FConfiguracao.QuantidadeDecimal  := StrToInt(CarregarCFGSIS('DECQTD'));
    FConfiguracao.ValorUnDecimal     := StrToInt(CarregarCFGSIS('DECUNI'));

    if qryConf.FindField('NFE_BRASAO') <> nil then
      FConfiguracao.BrasaoPrefeitura   := qryConf.FieldByName('NFE_BRASAO').AsString
    else
      FConfiguracao.BrasaoPrefeitura   := '';

    if qryConf.FindField('NFE_NOMPRE') <> nil then
      FConfiguracao.Prefeitura         := qryConf.FieldByName('NFE_NOMPRE').AsString
    else
      FConfiguracao.Prefeitura         := '';

    if qryConf.FindField('NFE_NOMSEC') <> nil then
      FConfiguracao.Secretaria         := qryConf.FieldByName('NFE_NOMSEC').AsString
    else
      FConfiguracao.Secretaria         := '';

  finally
    qryConf.free;
  end;
end;

{$IF Defined(LINUX)}
procedure TConexaoBD.SalvarImagemBase64(LCodigoEmpresa: string; LVersaoNFe: Double; picImagem : TImage; tpImagem: TTipoImagem; LModelo: string; blnAplicarTodasEmpresas: Boolean);
{$ELSE}
procedure TConexaoBD.SalvarImagemBase64(LCodigoEmpresa: string; LVersaoNFe: Double; picImagem : TGraphic; tpImagem: TTipoImagem; LModelo: string; blnAplicarTodasEmpresas: Boolean);
{$IFEND}
var
  qryTabela : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strBase64 : string;
begin
  if Assigned(picImagem) then
    strBase64 := ConverterImagemParaBase64(picImagem);

  qryTabela := fCriaQuery;
  try
    //salva no banco de dados
    With qryTabela, SQL Do
    Begin
      Close;
      Clear;
      Add(' UPDATE IMPNFE SET  ');
      if fEmptyStr(strBase64) then
      begin
        if tpImagem = tpLogo Then
          Add(' NFE_LOGO = NULL ')
        Else if (tpImagem = tpMarcaDagua) And (FConfiguracao.TemMarcaDagua) Then
          Add(' NFE_MDAGUA = NULL ')
        else if (tpImagem = tpBrasaoPrefeitura) Then
          Add(' NFE_BRASAO = NULL ')
        else
          Add(' NFE_LOGO = NULL ');
      end
      else
      begin
        if tpImagem = tpLogo Then
          Add(' NFE_LOGO = :IMGB64 ')
        Else if (tpImagem = tpMarcaDagua) And (FConfiguracao.TemMarcaDagua) Then
          Add(' NFE_MDAGUA = :IMGB64 ')
        else if (tpImagem = tpBrasaoPrefeitura) Then
          Add(' NFE_BRASAO = :IMGB64 ')
        else
          Add(' NFE_LOGO = :IMGB64 ');
        ParamByName('IMGB64').AsString := strBase64;
      end;
      Add(' WHERE NFE_CODEMP = :CODEMP AND NFE_VERSAO = :VERSAO AND NFE_MODELO = :MODELO ');
      if (not blnAplicarTodasEmpresas) then
      begin
        Add(' AND NFE_CODEMP = :CODEMP ');
        ParamByName('CODEMP').AsString := LCodigoEmpresa;
      end;
      ParamByName('VERSAO').AsFloat  := LVersaoNFe;
      ParamByName('MODELO').AsString := LModelo;

      Try
        ExecSQL;
      Except
        On E: Exception Do
        Begin
        {$IF Defined(LINUX)}
          Writeln(E.Message);
        {$ELSE}
          ShowErrorMsgTimeout(E.ClassName, e.Message, 10000);
        {$IFEND}
        End;
      End;
    End;
  Finally
    FreeAndNil(qryTabela);
  End;
end;

{$IF Defined(LINUX)}
function TConexaoBD.CarregarImagemBase64(ACodigoEmpresa: string; AVersaoNFe: Double; picImagem : FMX.Graphics.TBitmap; tpImagem: TTipoImagem; AModelo: string): Boolean;
{$ELSE}
function TConexaoBD.CarregarImagemBase64(ACodigoEmpresa: string; AVersaoNFe: Double; picImagem : TPicture; tpImagem: TTipoImagem; AModelo: string): Boolean;
{$IFEND}
Var
  strImg : String;
  qryConf : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := False;
  qryConf := fCriaQuery(nil, FDatabase);
  try
    qryConf.Close;
    qryConf.SQL.Clear;
    qryConf.SQL.Add('SELECT ');
    if (tpImagem = tpLogo) Then
      qryConf.SQL.Add('NFE_LOGO AS IMG ')
    else if (tpImagem = tpMarcaDagua) And (FConfiguracao.TemMarcaDagua) then
      qryConf.SQL.Add('NFE_MDAGUA AS IMG ')
    else if (tpImagem = tpBrasaoPrefeitura) then
      qryConf.SQL.Add('NFE_BRASAO AS IMG ')
    else
      qryConf.SQL.Add('"" AS IMG ');
    qryConf.SQL.Add('FROM IMPNFE ');
    qryConf.SQL.Add(' WHERE NFE_CODEMP = :CODEMP ');
    qryConf.SQL.Add('   AND NFE_VERSAO = :VERSAO ');
    qryConf.SQL.Add('   AND NFE_MODELO = :MODELO ');
    qryConf.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    qryConf.ParamByName('VERSAO').AsFloat := AVersaoNFe;
    qryConf.ParamByName('MODELO').AsString := AModelo;
    qryConf.Open();
    qryConf.First;

    if not qryConf.IsEmpty then
    begin

      strImg := qryConf.FieldByName('IMG').AsString;
      If Length(strImg) > 0 Then
      Begin
        Try
          ConverterBase64ParaImagem(strImg, picImagem);
          Result := True;
        Except
          Result := False;
        End;
      End;
    end;

  finally
    qryConf.free;
  end;
End;

function TConexaoBD.fSatComplementar(strCodEmp, strAcesso: string): Boolean;
Var
  qryAux : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(nil, FDatabase);
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT FIS_NFCOMP FROM CADFIS ');
    qryAux.SQL.Add('WHERE FIS_ACESSO = :ACESSO ');
    qryAux.SQL.Add('  AND FIS_CODEMP = :CODEMP ');
    qryAux.ParamByName('ACESSO').AsString := strAcesso;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open;

    Result := (qryAux.FieldByName('FIS_NFCOMP').AsString = 'S');
  finally
    qryAux.free;
  end;
End;

function TConexaoBD.fAbrirQueryLayoutDANFe(strCodigoEmpresa, strModelo: string;
  fltVersaoNFe: Double): {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := fCriaQuery(nil, FDatabase);
  Result.Close;
  Result.SQL.Clear;
  Result.SQL.Add('SELECT * FROM IMPNFE');
  Result.SQL.Add('WHERE NFE_CODEMP = :CODEMP');
  Result.SQL.Add('AND NFE_MODELO = :MODELO');
  Result.SQL.Add('AND NFE_VERSAO = :VERSAO ;');
  Result.ParamByName('CODEMP').AsString := strCodigoEmpresa;
  Result.ParamByName('MODELO').AsString := strModelo;
  Result.ParamByName('VERSAO').AsFloat := fltVersaoNFe;
  Result.Open();
end;

function TConexaoBD.fCampoExiste(const strTabela, strCampo: String): Boolean;
  Var
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
    lBanco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
begin
  If Assigned(FDatabase) Then
    lBanco := FDatabase
  Else
    lBanco := frmModulo.Database;

  {$IF Defined(UNIDAC)}
  strKey := fFormataKeyCmpExiParaDicSis(strTabela, strCampo);
  If fAchouDicSisBln(lBanco, strKey, Result) Then
    Exit;
  {$IFEND}

  Result := fTabelaCampoExiste(lBanco, strTabela, strCampo);

  {$IF Defined(UNIDAC)}
  pInsereDicSis(lBanco, strKey, fBooleanToStringDisSis(Result));
  {$IFEND}
end;

function TConexaoBD.fClassifiVenda(AChaveAcesso, ACodigoEmpresa: string; AClaFis: String=''): Boolean;
Var
  qryDoc : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQLRef: String;
  LSQLAux: String;
begin
  Result := False;

  If Not fEmptyStr(AClaFis) Then
  Begin
    Result := (Pos(AClaFis, fTransform(CarregarCFGSIS('CLAVEN'), 4)) > 0);
  End
  Else
  Begin
    qryDoc := fCriaQuery();
    Try
      qryDoc.Close;
      qryDoc.SQL.Add('SELECT G.GER_CLAFIS AS CLAFIS ');
      qryDoc.SQL.Add('  FROM CADFIS F ');
      qryDoc.SQL.Add('     INNER JOIN MOVGER G ON F.FIS_CODEMP = G.GER_CODEMP ');
      qryDoc.SQL.Add('                        AND F.FIS_NUMDOC = G.GER_NUMDOC ');
      qryDoc.SQL.Add('                        AND F.FIS_ESPDOC = G.GER_ESPDOC ');
      qryDoc.SQL.Add('                        AND F.FIS_SERIE_ = G.GER_SERIE_ ');
      qryDoc.SQL.Add('                        AND F.FIS_TIP_FC = G.GER_TIP_FC ');
      qryDoc.SQL.Add('                        AND F.FIS_FORCLI = IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) ');
      qryDoc.SQL.Add('WHERE F.FIS_ACESSO = :ACESSO AND F.FIS_CODEMP = :CODEMP ');

      LSQLRef := qryDoc.SQL.Text;

      //MOVGER...
      LSQLAux := LSQLRef;

      qryDoc.SQL.Clear;
      qryDoc.SQL.Text := LSQLAux;

      qryDoc.ParamByName('ACESSO').AsString := AChaveAcesso;
      qryDoc.ParamByName('CODEMP').AsString := ACodigoEmpresa;
      qryDoc.Open;

      //...MOVGER
      If qryDoc.IsEmpty Then
      Begin
        qryDoc.Close;

        //NOTGER...
        LSQLAux := LSQLRef;

        LSQLAux := AnsiReplaceStr(LSQLAux, 'MOVGER', 'NOTGER');

        qryDoc.SQL.Clear;
        qryDoc.SQL.Text := LSQLAux;

        qryDoc.ParamByName('ACESSO').AsString := AChaveAcesso;
        qryDoc.ParamByName('CODEMP').AsString := ACodigoEmpresa;
        qryDoc.Open;
        //...NOTGER
      End
    Finally
      If Not qryDoc.IsEmpty Then
        Result := (Pos(qryDoc.FieldByName('CLAFIS').AsString, fTransform(CarregarCFGSIS('CLAVEN'), 4)) > 0);
      FreeAndNil(qryDoc);
    End;
  End;
end;

function TConexaoBD.fCriarQryRetencoesNs(strChaveAcesso: String): {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
var
  strSql: String;
begin
  Result := fCriaQuery(nil);
  Try
    strSql := '           SELECT                                                ';
    strSql := strSql + '     GER.GER_COFRET AS COFRET,                          ';
    strSql := strSql + '     GER_ALQIRF     AS ALQIRF,                          ';
    strSql := strSql + '     GER.GER_IRFRET AS IRFRET,                          ';
    strSql := strSql + '     GER_ALQCSL     AS ALQCSL,                          ';
    strSql := strSql + '     GER.GER_CSLRET AS CSLRET,                          ';
    strSql := strSql + '     GER_PESGSO     AS PESGSO,                          ';
    strSql := strSql + '     GER.GER_VLSGSO AS VLSGSO                           ';
    strSql := strSql + '  FROM                                                  ';
    strSql := strSql + '    CADFIS FIS                                          ';
    strSql := strSql + '  JOIN MOVGER GER ON GER.GER_NUMDOC = FIS.FIS_NUMDOC    ';
    strSql := strSql + '                 AND GER.GER_ESPDOC = FIS.FIS_ESPDOC    ';
    strSql := strSql + '                 AND GER.GER_CODEMP = FIS.FIS_CODEMP    ';
    strSql := strSql + '  WHERE FIS.FIS_ACESSO = :ACESSO                        ';
    Result.SQL.Text := strSql;
    Result.ParamByName('ACESSO').AsString := strChaveAcesso;
    Result.Open
  Except
    Raise;
  End;
end;

procedure TConexaoBD.pGetDadosCndFpg(strNumDoc, strEspDoc, strCodEmp : String; out strDadosCndFpg : String);
var
  qryConsulta : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  strDadosCndFpg := EmptyStr;

  qryConsulta := fCriaQuery(nil, FDatabase);

  try

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT CADCND.CND_CNDPAG, CADFPG.FPG_DESCRI FROM MOVGER ');
    qryConsulta.SQL.Add('LEFT JOIN CADFPG ON FPG_CODIGO = GER_CODFPG ');
    qryConsulta.SQL.Add('LEFT JOIN CADCND ON CND_CODIGO = GER_CODCND ');
    qryConsulta.SQL.Add('WHERE MOVGER.GER_NUMDOC = :NUMDOC ');
    qryConsulta.SQL.Add('  AND MOVGER.GER_ESPDOC = :ESPDOC ');
    qryConsulta.SQL.Add('  AND MOVGER.GER_CODEMP = :CODEMP ');
    qryConsulta.SQL.Add('UNION ');
    qryConsulta.SQL.Add('SELECT CADCND.CND_CNDPAG, CADFPG.FPG_DESCRI FROM DEL_MOVGER ');
    qryConsulta.SQL.Add('LEFT JOIN CADFPG ON FPG_CODIGO = GER_CODFPG ');
    qryConsulta.SQL.Add('LEFT JOIN CADCND ON CND_CODIGO = GER_CODCND ');
    qryConsulta.SQL.Add('WHERE DEL_MOVGER.GER_NUMDOC = :NUMDOC ');
    qryConsulta.SQL.Add('  AND DEL_MOVGER.GER_ESPDOC = :ESPDOC ');
    qryConsulta.SQL.Add('  AND DEL_MOVGER.GER_CODEMP = :CODEMP ');

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;

    qryConsulta.Open;

    strDadosCndFpg := fFormataCondPag(Trim(qryConsulta.FieldByName('CND_CNDPAG').AsString))+
                      '-'+
                      Trim(qryConsulta.FieldByName('FPG_DESCRI').AsString);

  finally
    FreeAndNil(qryConsulta);
  end;

end;

procedure TConexaoBD.pGetTomadorParaENotas(strNumDoc, strEspDoc,
  strCodEmp: String; out strTomadorI_E_S_, strTomadorEmail_, strTomadorFone01, strTomadorUF, strTomadorEmail2,
  strTomadorIM, strTomadorCidade, strTomadorComplEnder, strTomadorCelular: String);
Const
    STR_CLIENTE_CONSUMIDOR = 'CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%"';
var
  qryConsulta : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

  function fConsumid(const strCampoGer, strCampoCon: String): String;
  begin
    Result := 'IF(CLICON.CON_C_P_F_ IS NULL, ' + strCampoGer + ', ' + strCampoCon + ') '
  end;

  function fFazenda(const strCampoCli, strCampoFaz: String): String;
  begin
    If Not (CarregarCFGSIS('CADFAZ') = 'S') And (fCampoExiste('AUXMOV', 'AUX_CODFAZ')) Then
      Result := strCampoCli
    Else
      Result := 'IF(FAZ_CODFAZ IS NULL, ' + strCampoCli + ', ' + strCampoFaz + ') '
  end;

begin

  strTomadorI_E_S_ := EmptyStr;
  strTomadorEmail_ := EmptyStr;
  strTomadorFone01 := EmptyStr;
  strTomadorUF     := EmptyStr;
  strTomadorEmail2 := EmptyStr;
  strTomadorIM     := EmptyStr;
  strTomadorComplEnder := EmptyStr;
  strTomadorCelular := EmptyStr;
  strTomadorCidade := EmptyStr;

  qryConsulta := fCriaQuery(nil, FDatabase);

  try

    qryConsulta.Close;
    qryConsulta.SQL.Clear;

    qryConsulta.SQL.Add('SELECT                                         ');
    qryConsulta.SQL.Add('  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('MG.GER_IESCON', 'CON_I_E_S_') + ', ' + fFazenda('CC.CLI_I_E_S_', 'FAZ_I_E_S_') + ') AS I_E_S_, ');

    qryConsulta.SQL.Add('  CC.CLI_FONE01 AS FONE01,                     ');
    qryConsulta.SQL.Add('  CC.CLI_EMAIL_ AS EMAIL_,                     ');
    qryConsulta.SQL.Add('  CD.CID_ESTADO AS UFDEST,                     ');
    If (fCampoExiste('CADCLI', 'CLI_EMAIL2')) Then
      qryConsulta.SQL.Add('  CC.CLI_EMAIL2 AS EMAIL2,                   ')
    else
      qryConsulta.SQL.Add('  CAST("" AS CHAR(1)) AS EMAIL2,             ');
    qryConsulta.SQL.Add('  CC.CLI_I_M_P_ AS I_M_P_,                     ');
    qryConsulta.SQL.Add('  CC.CLI_CELULA AS CELULA,                     ');
    qryConsulta.SQL.Add('  CC.CLI_ENDCOM AS ENDCOM,                     ');
    qryConsulta.SQL.Add('  CD.CID_NOMCID AS NOMCID                      ');
    qryConsulta.SQL.Add('FROM                                           ');
    qryConsulta.SQL.Add('  MOVGER MG                                    ');
    qryConsulta.SQL.Add('  LEFT JOIN CADCID CD                          ');
    qryConsulta.SQL.Add('    ON CD.CID_CODCID = MG.GER_CIDCON           ');
    qryConsulta.SQL.Add('  LEFT JOIN CADCLI CC                          ');
    qryConsulta.SQL.Add('    ON CC.CLI_CODCLI = MG.GER_CODCLI           ');
    qryConsulta.SQL.Add('  LEFT JOIN CLICON                             ');
    qryConsulta.SQL.Add('    ON CLICON.CON_C_P_F_ = CC.CLI_C_G_C_       ');
    qryConsulta.SQL.Add('  LEFT JOIN CADFAZ                             ');
    qryConsulta.SQL.Add('    ON CC.CLI_CODCLI = CADFAZ.FAZ_CODCLI       ');
    qryConsulta.SQL.Add('WHERE MG.GER_NUMDOC = :NUMDOC                  ');
    qryConsulta.SQL.Add('  AND MG.GER_ESPDOC = :ESPDOC                  ');
    qryConsulta.SQL.Add('  AND MG.GER_CODEMP = :CODEMP                  ');
    qryConsulta.SQL.Add('UNION                                          ');
    qryConsulta.SQL.Add('SELECT                                         ');
    qryConsulta.SQL.Add('  IF(' + STR_CLIENTE_CONSUMIDOR + ', ' + fConsumid('NG.GER_IESCON', 'CON_I_E_S_') + ', ' + fFazenda('CC.CLI_I_E_S_', 'FAZ_I_E_S_') + ') AS I_E_S_, ');

    qryConsulta.SQL.Add('  CC.CLI_FONE01 AS FONE01,                     ');
    qryConsulta.SQL.Add('  CC.CLI_EMAIL_ AS EMAIL_,                     ');
    qryConsulta.SQL.Add('  CD.CID_ESTADO AS UFDEST,                     ');
    If (fCampoExiste('CADCLI', 'CLI_EMAIL2')) Then
      qryConsulta.SQL.Add('  CC.CLI_EMAIL2 AS EMAIL2,                   ')
    else
      qryConsulta.SQL.Add('  CAST("" AS CHAR(1)) AS EMAIL2,             ');
    qryConsulta.SQL.Add('  CC.CLI_I_M_P_ AS I_M_P_,                     ');
    qryConsulta.SQL.Add('  CC.CLI_CELULA AS CELULA,                     ');
    qryConsulta.SQL.Add('  CC.CLI_ENDCOM AS ENDCOM,                     ');
    qryConsulta.SQL.Add('  CD.CID_NOMCID AS NOMCID                      ');
    qryConsulta.SQL.Add('FROM                                           ');
    qryConsulta.SQL.Add('  NOTGER NG                                    ');
    qryConsulta.SQL.Add('  LEFT JOIN CADCID CD                          ');
    qryConsulta.SQL.Add('    ON CD.CID_CODCID = NG.GER_CIDCON           ');
    qryConsulta.SQL.Add('  LEFT JOIN CADCLI CC                          ');
    qryConsulta.SQL.Add('    ON CC.CLI_CODCLI = NG.GER_CODCLI           ');
    qryConsulta.SQL.Add('  LEFT JOIN CLICON                             ');
    qryConsulta.SQL.Add('    ON CLICON.CON_C_P_F_ = CC.CLI_C_G_C_       ');
    qryConsulta.SQL.Add('  LEFT JOIN CADFAZ                             ');
    qryConsulta.SQL.Add('    ON CC.CLI_CODCLI = CADFAZ.FAZ_CODCLI       ');
    qryConsulta.SQL.Add('WHERE NG.GER_NUMDOC = :NUMDOC                  ');
    qryConsulta.SQL.Add('  AND NG.GER_ESPDOC = :ESPDOC                  ');
    qryConsulta.SQL.Add('  AND NG.GER_CODEMP = :CODEMP;                 ');

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;

    qryConsulta.Open;

    strTomadorI_E_S_ := Trim(qryConsulta.FieldByName('I_E_S_').AsString);
    strTomadorEmail_ := Trim(qryConsulta.FieldByName('EMAIL_').AsString);
    strTomadorFone01 := Trim(qryConsulta.FieldByName('FONE01').AsString);
    strTomadorUF     := Trim(qryConsulta.FieldByName('UFDEST').AsString);
    strTomadorEmail2 := Trim(qryConsulta.FieldByName('EMAIL2').AsString);
    strTomadorIM     := Trim(qryConsulta.FieldByName('I_M_P_').AsString);
    strTomadorComplEnder := Trim(qryConsulta.FieldByName('ENDCOM').AsString);
    strTomadorCelular := Trim(qryConsulta.FieldByName('CELULA').AsString);
    strTomadorCidade := Trim(qryConsulta.FieldByName('NOMCID').AsString);

  finally
    FreeAndNil(qryConsulta);
  end;

end;

procedure TConexaoBD.pGetDiscriminacaoServico(strNumDoc, strEspDoc, strCodEmp, strTip_FC: String;
                                              out strDiscriminacaoServico, strMunPre, strSerMun, strCNFNFE, strMovObs: String);
var
  qryConsulta : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  strDiscriminacaoServico := EmptyStr;
  strMunPre := EmptyStr;
  strSerMun := EmptyStr;
  strCNFNFE := EmptyStr;
  strMovObs := EmptyStr;

  qryConsulta := fCriaQuery(nil, FDatabase);

  try

    qryConsulta.Close;
    qryConsulta.SQL.Clear;

    qryConsulta.SQL.Add('SELECT                                             ');
    qryConsulta.SQL.Add('  OB.MOV_OBSERV AS MOVOBS,                         ');
    qryConsulta.SQL.Add('  OB.MOV_DISSER AS DISSER,                         ');
    qryConsulta.SQL.Add('  OB.MOV_CNFNFE AS CNFNFE                          ');
    If fCampoExiste('SERMOV', 'GER_MUNPRE') then
      qryConsulta.SQL.Add(',S.GER_MUNPRE AS MUNPRE                          ')
    Else
      qryConsulta.SQL.Add(',CAST("" AS CHAR(1)) AS MUNPRE                   ');
    qryConsulta.SQL.Add(',CONCAT(CC.CID_NOMCID,"-",CC.CID_ESTADO) AS SERMUN ');
    qryConsulta.SQL.Add('FROM                                               ');
    qryConsulta.SQL.Add('  MOVGER MG                                        ');
    qryConsulta.SQL.Add('  LEFT JOIN AUXMOV AM                              ');
    qryConsulta.SQL.Add('    ON AM.AUX_SEQGER = MG.AUTOINCREM               ');
    qryConsulta.SQL.Add('  LEFT JOIN ENTCLI EC                              ');
    qryConsulta.SQL.Add('    ON EC.AUTOINCREM = AM.AUX_ENTGER               ');
    qryConsulta.SQL.Add('  LEFT JOIN CADCID CC                              ');
    qryConsulta.SQL.Add('    ON CC.CID_CODCID = EC.ETC_CIDENT               ');
    qryConsulta.SQL.Add('  LEFT JOIN MOVOBS OB                              ');
    qryConsulta.SQL.Add('    ON OB.MOV_SEQGER = MG.AUTOINCREM               ');
    qryConsulta.SQL.Add('  LEFT JOIN SERMOV S                               ');
    qryConsulta.SQL.Add('    ON S.GER_SEQGER = MG.AUTOINCREM                ');
    qryConsulta.SQL.Add('WHERE MG.GER_NUMDOC = :NUMDOC                      ');
    qryConsulta.SQL.Add('  AND MG.GER_ESPDOC = :ESPDOC                      ');
    qryConsulta.SQL.Add('  AND MG.GER_CODEMP = :CODEMP                      ');
    qryConsulta.SQL.Add('  AND MG.GER_TIP_FC = :TIP_FC                      ');
    qryConsulta.SQL.Add('  AND MG.GER_ORIDOC = "V"                          ');
    qryConsulta.SQL.Add('UNION ALL                                          ');
    qryConsulta.SQL.Add('SELECT                                             ');
    qryConsulta.SQL.Add('  OB.MOV_OBSERV AS MOVOBS,                         ');
    qryConsulta.SQL.Add('  OB.MOV_DISSER AS DISSER,                         ');
    qryConsulta.SQL.Add('  OB.MOV_CNFNFE AS CNFNFE                          ');
    If fCampoExiste('SERNOT', 'GER_MUNPRE') then
      qryConsulta.SQL.Add(',S.GER_MUNPRE AS MUNPRE                          ')
    Else
      qryConsulta.SQL.Add(',CAST("" AS CHAR(1)) AS MUNPRE                   ');
    qryConsulta.SQL.Add(',CONCAT(CC.CID_NOMCID,"-",CC.CID_ESTADO) AS SERMUN ');
    qryConsulta.SQL.Add('FROM                                               ');
    qryConsulta.SQL.Add('  NOTGER NG                                        ');
    qryConsulta.SQL.Add('  LEFT JOIN AUXNOT AN                              ');
    qryConsulta.SQL.Add('    ON AN.AUX_SEQGER = NG.AUTOINCREM               ');
    qryConsulta.SQL.Add('  LEFT JOIN ENTCLI EC                              ');
    qryConsulta.SQL.Add('    ON EC.AUTOINCREM = AN.AUX_ENTGER               ');
    qryConsulta.SQL.Add('  LEFT JOIN CADCID CC                              ');
    qryConsulta.SQL.Add('    ON CC.CID_CODCID = EC.ETC_CIDENT               ');
    qryConsulta.SQL.Add('  LEFT JOIN NOTOBS OB                              ');
    qryConsulta.SQL.Add('    ON OB.MOV_SEQGER = NG.AUTOINCREM               ');
    qryConsulta.SQL.Add('  LEFT JOIN SERNOT S                               ');
    qryConsulta.SQL.Add('    ON S.GER_SEQGER = NG.AUTOINCREM                ');
    qryConsulta.SQL.Add('WHERE NG.GER_NUMDOC = :NUMDOC                      ');
    qryConsulta.SQL.Add('  AND NG.GER_ESPDOC = :ESPDOC                      ');
    qryConsulta.SQL.Add('  AND NG.GER_CODEMP = :CODEMP                      ');
    qryConsulta.SQL.Add('  AND NG.GER_TIP_FC = :TIP_FC                      ');
    qryConsulta.SQL.Add('  AND NG.GER_ORIDOC = "V"                          ');

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;
    qryConsulta.ParamByName('TIP_FC').AsString := strTip_FC;

    qryConsulta.Open;

    strMovObs := Trim(qryConsulta.FieldByName('MOVOBS').AsString);
    strDiscriminacaoServico := Trim(qryConsulta.FieldByName('DISSER').AsString);
    strMunPre := Trim(qryConsulta.FieldByName('MUNPRE').AsString);
    strSerMun := Trim(qryConsulta.FieldByName('SERMUN').AsString);
    if not fEmptyStr(Trim(qryConsulta.FieldByName('CNFNFE').AsString)) then
      strCNFNFE := 'Informações: ' + Trim(qryConsulta.FieldByName('CNFNFE').AsString);

  finally
    FreeAndNil(qryConsulta);
  end;

end;

procedure TConexaoBD.pGetDadosEmpresa(ACodigoEmpresa  : String;
                                      out strEmail    : String;
                                      out strFone     : String;
                                      out strInsEst   : String;
                                      out strFone2    : String;
                                      out strCNAE     : String;
                                      out strIM       : String;
                                      out strRazSoc   : String;
                                      out strEnder    : String;
                                      out strNume     : String;
                                      out srtBairro   : String;
                                      out strCidad    : String;
                                      out strCEP      : String;
                                      out strUF       : String;
                                      out strCompl    : String;
                                      out strCNPJ     : String;
                                      out strFant     : String;
                                      out strHomePage : String);

var
  qryConsulta : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  strEmail    := EmptyStr;
  strFone     := EmptyStr;
  strInsEst   := EmptyStr;
  strFone2    := EmptyStr;
  strCNAE     := EmptyStr;
  strIM       := EmptyStr;
  strRazSoc   := EmptyStr;
  strEnder    := EmptyStr;
  strNume     := EmptyStr;
  srtBairro   := EmptyStr;
  strCidad    := EmptyStr;
  strCEP      := EmptyStr;
  strUF       := EmptyStr;
  strCompl    := EmptyStr;
  strCNPJ     := EmptyStr;
  strFant     := EmptyStr;
  strHomePage := EmptyStr;

  qryConsulta := fCriaQuery(nil, FDatabase);

  try

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT EMP_EMAIL_, EMP_FONE01, EMP_I_E_S_, EMP_FONE02, EMP_CNAEFI, EMP_INSMUN, EMP_CODCID, ');
    qryConsulta.SQL.Add('       EMP_NOMEMP, EMP_ENDERE, EMP_ENDNUM, EMP_BAIRRO, EMP_C_E_P_, EMP_ENDCMP, EMP_C_G_C_, ');
    qryConsulta.SQL.Add('       EMP_NOMFAN, EMP_HOMEPA                                                              ');
    qryConsulta.SQL.Add('  FROM CADEMP WHERE EMP_CODEMP = :CODEMP                                                   ');

    qryConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    qryConsulta.Open;

    strEmail    := Trim(qryConsulta.FieldByName('EMP_EMAIL_').AsString);
    strFone     := Trim(qryConsulta.FieldByName('EMP_FONE01').AsString);
    strInsEst   := Trim(qryConsulta.FieldByName('EMP_I_E_S_').AsString);
    strFone2    := Trim(qryConsulta.FieldByName('EMP_FONE02').AsString);
    strCNAE     := Trim(qryConsulta.FieldByName('EMP_CNAEFI').AsString);
    strIM       := Trim(qryConsulta.FieldByName('EMP_INSMUN').AsString);
    strRazSoc   := Trim(qryConsulta.FieldByName('EMP_NOMEMP').AsString);
    strEnder    := Trim(qryConsulta.FieldByName('EMP_ENDERE').AsString);
    strNume     := Trim(qryConsulta.FieldByName('EMP_ENDNUM').AsString);
    srtBairro   := Trim(qryConsulta.FieldByName('EMP_BAIRRO').AsString);
    strCidad    := fCampoTabela('CID_NOMCID', 'CADCID', ['CID_CODCID'], [qryConsulta.FieldByName('EMP_CODCID').AsString]);
    strCEP      := Trim(qryConsulta.FieldByName('EMP_C_E_P_').AsString);
    strUF       := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [qryConsulta.FieldByName('EMP_CODCID').AsString]);
    strCompl    := Trim(qryConsulta.FieldByName('EMP_ENDCMP').AsString);
    strCNPJ     := Trim(qryConsulta.FieldByName('EMP_C_G_C_').AsString);
    strFant     := Trim(qryConsulta.FieldByName('EMP_NOMFAN').AsString);
    strHomePage := Trim(qryConsulta.FieldByName('EMP_HOMEPA').AsString);

  finally
    FreeAndNil(qryConsulta);
  end;

end;

procedure TConexaoBD.pGetDadosEmpresa(ACodigoEmpresa  : String;
                                      out strRazSoc   : String;
                                      out strEmail    : String;
                                      out strHomepage : String;
                                      out strFone2    : String;
                                      out strCNAE     : String;
                                      out strIM       : String;
                                      out strCNPJ     : String);
var
  qryConsulta : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  strRazSoc   := EmptyStr;
  strEmail    := EmptyStr;
  strHomepage := EmptyStr;
  strFone2    := EmptyStr;
  strCNAE     := EmptyStr;
  strIM       := EmptyStr;
  strCNPJ     := EmptyStr;

  qryConsulta := fCriaQuery(nil, FDatabase);

  try

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT EMP_NOMEMP, EMP_EMAIL_, EMP_HOMEPA, EMP_FONE02, EMP_CNAEFI, EMP_INSMUN, EMP_C_G_C_ FROM CADEMP WHERE EMP_CODEMP = :CODEMP');
    qryConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    qryConsulta.Open;

    strRazSoc   := Trim(qryConsulta.FieldByName('EMP_NOMEMP').AsString);
    strEmail    := Trim(qryConsulta.FieldByName('EMP_EMAIL_').AsString);
    strHomepage := Trim(qryConsulta.FieldByName('EMP_HOMEPA').AsString);
    strFone2    := Trim(qryConsulta.FieldByName('EMP_FONE02').AsString);
    strCNAE     := Trim(qryConsulta.FieldByName('EMP_CNAEFI').AsString);
    strIM       := Trim(qryConsulta.FieldByName('EMP_INSMUN').AsString);
    strCNPJ     := Trim(qryConsulta.FieldByName('EMP_C_G_C_').AsString);

  finally
    FreeAndNil(qryConsulta);
  end;

end;

function TConexaoBD.fGetConnectionID: String;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Try
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.SQL.Add('SELECT CONNECTION_ID()');
      qryAux.Open;

      Result := qryAux.Fields[0].AsString;
    Finally
      FreeAndNil(qryAux);
    End;
  Except
    //
  End;
end;

function TConexaoBD.fGetInfComplementar(DataSet: TDataSet; strQuebra: String;
  strDadCli: String = ''; blnPossuiItensEmPromocao: Boolean = False; blnRetornaOpe: Boolean = True; blnRetornaInfo: Boolean = True): String;

  function fConsumidorIdentificado(strCGCCON: String): Boolean;
  begin
    Result := (Not fEmptyStr(strCGCCON)) And
              (Not fStringRepetida(strCGCCON)) And
              (fTestaCgc(strCGCCON) Or
               fValidaCPF(strCGCCON));
  end;

begin
  Result := '';
  If CarregarCFGSIS('VENDAD') = 'S' Then
  Begin
    If CarregarCFGSIS('AUTCEN') = 'S' Then
    Begin
      Result := Result + 'Vendedor: ' + DataSet.FieldByName('NOMVEN').AsString + strQuebra;
    End
    Else
      Result := Result + 'Vendedor: ' + DataSet.FieldByName('CODVEN').AsString + ' - ' +
                                        DataSet.FieldByName('NOMVEN').AsString + strQuebra;
  End;

  If blnRetornaOpe then
  Begin
    If (Not fEmptyStr(DataSet.FieldByName('OPECXA').AsString)) Then
    Begin
      If CarregarCFGSIS('AUTCEN') = 'S' Then
      Begin
        Result := Result + 'Operador: ' + DataSet.FieldByName('NOMCXA').AsString + strQuebra;
      End
      Else
        Result := Result + 'Operador: ' + DataSet.FieldByName('OPECXA').AsString + ' - ' +
                                          DataSet.FieldByName('NOMCXA').AsString + strQuebra;
    End
  End;

  if not fEmptyStr(strDadCli) then
    Result := Result + strDadCli;

  If blnRetornaInfo then
  Begin
    if blnPossuiItensEmPromocao then
    begin
      Result := Result + '*PRODUTO EM PROMOÇÃO ' + strQuebra;
    end;

    Result := Result + 'IF: ' + DataSet.FieldByName('NUMDOC').AsString + strQuebra;

    if not fEmptyStr( DataSet.FieldByName('CODCAX').AsString ) then
      Result := Result + 'CAIXA: ' + DataSet.FieldByName('CODCAX').AsString + strQuebra;

  end;

  If CarregarCFGSIS('ORGDFI') = 'S' Then
  Begin
    If Not fEmptyStr(CarregarCFGSIS('ENDPRC')) Then
    Begin
      Result := Result + 'PROCON-'+DataSet.FieldByName('ESTEMP').AsString+': ' + CarregarCFGSIS('ENDPRC') + strQuebra;
      Result := Result + 'TEL: ' + CarregarCFGSIS('TELPRC') + strQuebra;
    End;

    If Not fEmptyStr(CarregarCFGSIS('ENDALE')) Then
    Begin
      Result := Result + 'ALERJ: ' + CarregarCFGSIS('ENDALE') + strQuebra;
      Result := Result + 'TEL: ' + CarregarCFGSIS('TELALE') + strQuebra;
    End;
  End;

  If blnRetornaInfo then
  begin

    If Not fEmptyStr(DataSet.FieldByName('MEN001').AsString) Then
      Result := Result + DataSet.FieldByName('MEN001').AsString + strQuebra;

    If Not fEmptyStr(DataSet.FieldByName('MEN002').AsString) Then
      Result := Result + DataSet.FieldByName('MEN002').AsString + strQuebra;

    If Not fEmptyStr(DataSet.FieldByName('MEN003').AsString) Then
      Result := Result + DataSet.FieldByName('MEN003').AsString + strQuebra;

    If Not fEmptyStr(DataSet.FieldByName('MEN004').AsString) Then
      Result := Result + DataSet.FieldByName('MEN004').AsString + strQuebra;

    If Not fEmptyStr(DataSet.FieldByName('MEN005').AsString) Then
      Result := Result + DataSet.FieldByName('MEN005').AsString + strQuebra;

    If DataSet.FieldByName('PESBRU').asFloat > 0 Then
      Result := Result + 'PESO BRUTO: ' + FloatToStrF(DataSet.FieldByName('PESBRU').AsFloat, ffNumber, 12, 2) + strQuebra;

    If Not fEmptyStr(CarregarCFGSIS('MSGNFC')) Then
      Result := Result + CarregarCFGSIS('MSGNFC') + #13#10;

    If Not fEmptyStr(CarregarCFGSIS('IADNFC')) Then
      Result := Result + CarregarCFGSIS('IADNFC') + #13#10;

    If IfEmptyStr(CarregarCFGSIS('NFCCPG'), 'S') = 'S' Then
      Result := Result + 'COND.PAG.: ' + fFormataCondPag(DataSet.FieldByName('CONPAG').AsString) + ' - ' + DataSet.FieldByName('DESCND').AsString + strQuebra;

    Result := Result + iif(DataSet.FieldByName('ENTRET').AsString='E', 'ENTREGA', 'RETIRA') + strQuebra;

    If Assigned(DataSet.FindField('PRTMSG')) Then
    Begin
      If Not fEmptyStr(DataSet.FieldByName('PRTMSG').AsString) Then
        Result := Result + DataSet.FieldByName('PRTMSG').AsString + strQuebra;
    End;

    If DataSet.FieldByName('ENTRET').AsString = 'E' Then
      Result := Result + 'ENTREGA = S' + strQuebra;

    If DataSet.FieldByName('ENTRET').AsString = 'R' Then
      Result := Result + 'ENTREGA = N' + strQuebra;

  End;

  if ((CarregarCFGSIS('VENDAD') = 'S') or (blnRetornaInfo)) and (not fConsumidorIdentificado(DataSet.FieldByName('CGCCON').AsString)) then
    Result := Result + 'Cliente: ' + DataSet.FieldByName('CODCLI').AsString + ' - ' + DataSet.FieldByName('NOMCON').AsString + strQuebra;

  If fTabelaExiste('MOVREF') Then
  Begin
    Result := Result + strQuebra + ' Vlr.CBS '     + FloatToStrF(DataSet.FieldByName('CBSVAL').AsFloat, ffNumber, 12, 2) +
                                   ' Vlr.IBS UF '  + FloatToStrF(DataSet.FieldByName('IBSUFV').AsFloat, ffNumber, 12, 2) +
                                   ' Vlr.IBS MUN ' + FloatToStrF(DataSet.FieldByName('IBSMNV').AsFloat, ffNumber, 12, 2) + strQuebra;
  End;
end;

procedure TConexaoBD.pGetMensagemDadosFiscais(strNumDoc, strEspDoc, strCodEmp: string; out strMsgFis: string);
var
  qryMsg: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  strMsgFis := EmptyStr;
  qryMsg := fCriaQuery;

  try
    qryMsg.Close;
    qryMsg.SQL.Clear;
    qryMsg.SQL.Add('SELECT                      ');
    qryMsg.SQL.Add('  CONCAT(                   ');
    qryMsg.SQL.Add('    IFNULL(GER_MEN001, ""), ');
    qryMsg.SQL.Add('    " ",                    ');
    qryMsg.SQL.Add('    IFNULL(GER_MEN002, ""), ');
    qryMsg.SQL.Add('    " ",                    ');
    qryMsg.SQL.Add('    IFNULL(GER_MEN003, ""), ');
    qryMsg.SQL.Add('    " ",                    ');
    qryMsg.SQL.Add('    IFNULL(GER_MEN004, ""), ');
    qryMsg.SQL.Add('    " ",                    ');
    qryMsg.SQL.Add('    IFNULL(GER_MEN005, "")  ');
    qryMsg.SQL.Add('  ) AS MSGFIS               ');
    qryMsg.SQL.Add('FROM                        ');
    qryMsg.SQL.Add('  MOVGER                    ');
    qryMsg.SQL.Add('WHERE GER_NUMDOC = :NUMDOC  ');
    qryMsg.SQL.Add('  AND GER_ESPDOC = :ESPDOC  ');
    qryMsg.SQL.Add('  AND GER_CODEMP = :CODEMP  ');
    qryMsg.SQL.Add('  AND GER_TIP_FC = "C"      ');
    qryMsg.SQL.Add('UNION                       ');
    qryMsg.SQL.Add('ALL                         ');
    qryMsg.SQL.Add('SELECT                      ');
    qryMsg.SQL.Add('  CONCAT(                   ');
    qryMsg.SQL.Add('    IFNULL(GER_MEN001, ""), ');
    qryMsg.SQL.Add('    " ",                    ');
    qryMsg.SQL.Add('    IFNULL(GER_MEN002, ""), ');
    qryMsg.SQL.Add('    " ",                    ');
    qryMsg.SQL.Add('    IFNULL(GER_MEN003, ""), ');
    qryMsg.SQL.Add('    " ",                    ');
    qryMsg.SQL.Add('    IFNULL(GER_MEN004, ""), ');
    qryMsg.SQL.Add('    " ",                    ');
    qryMsg.SQL.Add('    IFNULL(GER_MEN005, "")  ');
    qryMsg.SQL.Add('  ) AS MSGFIS               ');
    qryMsg.SQL.Add('FROM                        ');
    qryMsg.SQL.Add('  NOTGER                    ');
    qryMsg.SQL.Add('WHERE GER_NUMDOC = :NUMDOC  ');
    qryMsg.SQL.Add('  AND GER_ESPDOC = :ESPDOC  ');
    qryMsg.SQL.Add('  AND GER_CODEMP = :CODEMP  ');
    qryMsg.SQL.Add('  AND GER_TIP_FC = "C"      ');

    qryMsg.ParamByName('CODEMP').AsString := strCodEmp;
    qryMsg.ParamByName('ESPDOC').AsString := strEspDoc;
    qryMsg.ParamByName('NUMDOC').AsString := strNumDoc;

    qryMsg.Open;

    if (not qryMsg.IsEmpty) then
      strMsgFis := qryMsg.FieldByName('MSGFIS').AsString;

  finally
    FreeAndNil(qryMsg);
  end;

end;

procedure TConexaoBD.pGerarQrCodeNfs(var frxDanfe:TfrxReport;
 strNomeObjQrCode, strLinkQrCode: String);
var
  streamQrCode: TMemoryStream;
  frxQrCode: TfrxPictureView;
{$IF Defined(LINUX)}
  bmpQrCode: FMX.Graphics.TBitmap;
{$ELSE}
  bmpQrCode: Graphics.TBitmap;
{$IFEND}
begin

  If fEmptyStr(strLinkQrCode)
  Or (Not Assigned(frxDanfe)) Then
  Begin
    Exit;
  End;

  If (Assigned(frxDanfe.FindObject(strNomeObjQrCode))) Then
  Begin
  {$IF Defined(LINUX)}
    bmpQrCode := FMX.Graphics.TBitmap.Create;
  {$ELSE}
    bmpQrCode := Graphics.TBitmap.Create;
  {$IFEND}
    streamQrCode := TMemoryStream.Create;
    Try
      frxQrCode := TfrxPictureView(frxDanfe.FindObject(strNomeObjQrCode));
      bmpQrCode := fGerarQRCode(strLinkQrCode);
      bmpQrCode.SaveToStream(streamQrCode);
    {$IF Defined(LINUX)}
      frxQrCode.Picture.LoadFromStream(streamQrCode);
    {$ELSE}
      frxQrCode.LoadPictureFromStream(streamQrCode);
    {$IFEND}
    Finally
      FreeAndNil(streamQrCode);
      FreeAndNil(bmpQrCode);
    End;
  End;
end;

function TConexaoBD.fGetQrCode(AChaveAcesso, ACodigoEmpresa: String): String;
var
  qryNFEQRC : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qryDados : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  intCnt: Integer;
begin
  Result := '';
  if not fTabelaExiste('NFEQRC') then
    Exit;

  qryNFEQRC := fCriaQuery(nil, FDatabase);
  Try
    qryNFEQRC.Close;
    qryNFEQRC.SQL.Clear;
    qryNFEQRC.SQL.Add('SELECT * FROM NFEQRC ');
    qryNFEQRC.SQL.Add(' WHERE QRC_CODEMP = :CODEMP ');

    qryNFEQRC.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    qryNFEQRC.Open;

    if qryNFEQRC.isEmpty then
      Exit;

    Try

      qryDados := fCriaQuery(nil, FDatabase);
      Try
        qryDados.Close;
        qryDados.SQL.Clear;
        qryDados.SQL.Text := qryNFEQRC.FieldByName('QRC_SQLDAD').AsString;

      {$IF Defined(UNIDAC)}
        if Assigned(qryDados.FindParam('ACESSO')) then
          qryDados.ParamByName('ACESSO').AsString := AChaveAcesso;
      {$ELSE}
        if Assigned(qryDados.ParamByName('ACESSO')) then
          qryDados.ParamByName('ACESSO').AsString := AChaveAcesso;
      {$IFEND}

        qryDados.Open;

        for intCnt := 0 to Pred(qryDados.Fields.Count) do
          Result := Result + qryDados.Fields[intCnt].AsString + #9;

        if Result <> '' then
          delete(Result, Length(Result), 1);
      Finally
        qryDados.free;
      End;

    Except
      On E: Exception Do
      Begin
      {$IF Defined(LINUX)}
        Writeln('Não foi possível carregar os dados do QR Code! Verifique a tabela NFEQRC!' + sLineBreak + E.Message);
      {$ELSE}
        ShowErrorMsgTimeout(E.ClassName, 'Não foi possível carregar os dados do QR Code! Verifique a tabela NFEQRC!' + sLineBreak + E.Message, 10000);
      {$IFEND}
      End;
    End;

  Finally
    qryNFEQRC.free;
  End;
end;

function TConexaoBD.fNfeCancelada(AChaveAcesso, ACodigoEmpresa: string; AFisHis: String=''): Boolean;
  Var
    qryNfeCanc : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If Not fEmptyStr(AFisHis) Then
  Begin
    Result := (AFisHis = 'CANCELADO');
  End
  Else
  Begin
    qryNfeCanc := fCriaQuery(nil, FDatabase);
    Try
      qryNfeCanc.Close;
      qryNfeCanc.SQL.Clear;
      qryNfeCanc.SQL.Add('SELECT FIS_ACESSO FROM CADFIS ');
      qryNfeCanc.SQL.Add('  WHERE FIS_CODEMP = :CODEMP ');
      qryNfeCanc.SQL.Add('    AND FIS_ACESSO = :ACESSO ');
      qryNfeCanc.SQL.Add('    AND FIS_HISTOR = "CANCELADO" ');
      qryNfeCanc.ParamByName('CODEMP').AsString := ACodigoEmpresa;
      qryNfeCanc.ParamByName('ACESSO').AsString := AChaveAcesso;
      qryNfeCanc.Open;

      Result := not qryNfeCanc.IsEmpty;

      qryNfeCanc.Close;
    Finally
      qryNfeCanc.Free;
    End;
  End;
end;

function TConexaoBD.fDocumentoEmitidoSmartPOS(AChaveAcesso: String; AstrOpcDoc: String=''): Boolean;
Var
  LQryGen : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

  procedure pLogarResult;
  begin
    pLogImp('fDocumentoEmitidoSmartPOS('+AChaveAcesso+', '+AstrOpcDoc+') = '+IIF(Result,'SIM','NAO'));
  end;

begin
  If (AChaveAcesso = '') And (AstrOpcDoc = '') Then
  Begin
    Result := False;
    pLogarResult;
    Exit;
  End;

  If (Not fEmptyStr(AstrOpcDoc)) Then
  Begin
    Result := (AstrOpcDoc = 'FS');
    pLogarResult;
  End
  Else
  Begin
    LQryGen := fCriaQuery(nil);
    Try
      Try
        LQryGen.Close;
        LQryGen.SQL.Clear;
        LQryGen.SQL.Add('SELECT ');
        LQryGen.SQL.Add('  AUX_OPCDOC ');
        LQryGen.SQL.Add('FROM ');
        LQryGen.SQL.Add('  LOGNFE ');
        LQryGen.SQL.Add('  JOIN MOVGER ');
        LQryGen.SQL.Add('     ON GER_NUMDOC = NFE_NUMDOC ');
        LQryGen.SQL.Add('    AND GER_ESPDOC = NFE_ESPDOC ');
        LQryGen.SQL.Add('    AND GER_CODEMP = NFE_CODEMP ');
        LQryGen.SQL.Add('    AND GER_TIP_FC = NFE_TIP_FC ');
        LQryGen.SQL.Add('    AND GER_CODCLI = NFE_CODCLI ');
        LQryGen.SQL.Add('  JOIN AUXMOV ');
        LQryGen.SQL.Add('    ON AUX_SEQGER = MOVGER.AUTOINCREM ');
        LQryGen.SQL.Add('WHERE NFE_ACESSO = "'+AChaveAcesso+'" ');
        LQryGen.Open;
        Result := LQryGen.FieldByName('AUX_OPCDOC').AsString = 'FS'; //Faturamento automático - Smart POS
      Except
        On E: Exception Do
        Begin
          pLogImp(E.Message);
          Result := False;
        End;
      End;
    Finally
      FreeAndNil(LQryGen);
      pLogarResult;
    End;
  End;
end;

function TConexaoBD.fPontoImpressaoUtilizaLayoutSimplificado(AChaveAcesso: String; AstrPonImp: String=''): Boolean;
Var
  LQryGen : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LPontoImpressao: String;
  LExisteLayoutSimplificado: Boolean;
  LTentativas: Integer;
begin
  pLogImp('Verificando se ponto de impressao utiliza layout simplificado');

  Result := False;
  LQryGen := fCriaQuery(nil);
  Try
    LExisteLayoutSimplificado := False;

    If (fCampoExiste('PONIMP', 'PON_NFESIM')) Then
    Begin
      Try
        LQryGen.Close;
        LQryGen.SQL.Clear;
        LQryGen.SQL.Add('SELECT COUNT(0) FROM PONIMP WHERE PON_CODEMP = "' + VS_strCodEmp + '" AND PON_NFESIM = "S"');
        LQryGen.Open;
      Except
        On E: Exception Do
          pLogImp(E.Message);
      End;

      If (Not LQryGen.IsEmpty) Then
        LExisteLayoutSimplificado := LQryGen.Fields[0].AsInteger > 0;
    End;

    LQryGen.Close;
    LQryGen.SQL.Clear;
    LQryGen.SQL.Add('SELECT NFE_PONIMP FROM LOGNFE WHERE NFE_ACESSO = "' + AChaveAcesso + '" ');

    If fEmptyStr(AstrPonImp) Then
    Begin
      pLogImp('Carregando ponto de impressao DANFE a partir da LOGNFE "' + AChaveAcesso + '" (T1)');
      LQryGen.Open;
      LPontoImpressao := LQryGen.FieldByName('NFE_PONIMP').AsString;
    End
    Else
    Begin
      LPontoImpressao := AstrPonImp;
    End;

    If LExisteLayoutSimplificado And (LPontoImpressao = '') Then
    Begin
      For LTentativas := 2 To 10 Do
      Begin
        Sleep(5000);
        pLogImp('Carregando ponto de impressao DANFE a partir da LOGNFE "' + AChaveAcesso + '" (T' + IntToStr(LTentativas) + ')');
        LQryGen.Close;
        LQryGen.Open;
        LPontoImpressao := LQryGen.FieldByName('NFE_PONIMP').AsString;
        If LPontoImpressao <> '' Then
          Break;
      End;
    End;

    If LPontoImpressao = '' Then
    Begin
      Result := False;
      pLogImp('Ponto de impressao nao localizado');
    End
    Else
    Begin
      pLogImp('Ponto de impressao localizado: ' + LPontoImpressao);

      If LExisteLayoutSimplificado Then
      Begin
        Try
          LQryGen.Close;
          LQryGen.SQL.Clear;
          LQryGen.SQL.Add('SELECT COUNT(0) FROM PONIMP WHERE PON_CODEMP = "' + VS_strCodEmp + '" AND PON_NOMPON = "' + LPontoImpressao + '" AND PON_NFESIM = "S"');
          LQryGen.Open;

          If (Not LQryGen.IsEmpty) Then
            Result := LQryGen.Fields[0].AsInteger > 0;
        Except
          Result := False;
        End;
      End;
    End;
  Finally
    pLogImp('Ponto de impressao utiliza layout simplificado = '+IIF(Result,'SIM','NAO'));
    FreeAndNil(LQryGen);
  End;
end;

function TConexaoBD.fPrefeituraComLayoutNfse(strCidNfs: string): Boolean;
var
  LqryPrefeitura : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  LqryPrefeitura := fCriaQuery;

  try

    LqryPrefeitura.SQL.Clear;
    LqryPrefeitura.SQL.Add('SELECT NFS_CIDADE ');
    LqryPrefeitura.SQL.Add('  FROM CIDNFS     ');
    LqryPrefeitura.SQL.Add(' WHERE NFS_CIDADE = ' + QuotedStr(strCidNfs) + ';' );
    LqryPrefeitura.Open;

    Result := not LqryPrefeitura.IsEmpty;

  finally
    FreeAndNil(LqryPrefeitura);
  end;

end;

function TConexaoBD.fAcharImpressoraPeloPonto(const APonto: String): String;
  Var
    LQryGen : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  pLogImp('fAcharImpressoraPeloPonto - Ponto: ' + APonto + ' - Empresa: ' + VS_strCodEmp);

  LQryGen := fCriaQuery(nil);
  Try
    Try
      LQryGen.Close;
      LQryGen.SQL.Clear;
      LQryGen.SQL.Add('SELECT PON_NOMIMP FROM PONIMP WHERE PON_CODEMP = "' +  VS_strCodEmp + '" AND PON_NOMPON = ' + QuotedStr(APonto));
      LQryGen.Open;
      Result := LQryGen.FieldByName('PON_NOMIMP').AsString;

      If Result = EmptyStr Then
      Begin
        Result := APonto;
        pLogImp('fAcharImpressoraPeloPonto > Não achou > Nome da impressora vai permanecer: ' + Result);
      End
      Else
        pLogImp('fAcharImpressoraPeloPonto > Achou > Nome da impressora: ' + Result);

    Except
      On E: Exception Do
        pLogImp(E.Message);
    End;
  Finally
    FreeAndNil(LQryGen);
  End;
end;

function TConexaoBD.fRetornaNomeImpressoraSpoolerImpressaoCitel(AChaveAcesso: String; AstrPonImp: String=''): string;
Var
  LQryGen : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LPontoImpressao: String;
  LExistePontoImpressaoSpool: Boolean;
  LTentativas: Integer;
begin
  pLogImp('Verificando nome da impressora (spooler de impresssao citel)');
  LQryGen := fCriaQuery(nil);
  Try
    LExistePontoImpressaoSpool := False;

    Try
      LQryGen.Close;
      LQryGen.SQL.Clear;
      LQryGen.SQL.Add('SELECT COUNT(0) FROM PONIMP WHERE PON_CODEMP = "' + VS_strCodEmp + '" AND PON_SPOIMP = "S"');
      LQryGen.Open;
    Except
      On E: Exception Do
        pLogImp(E.Message);
    End;

    If (Not LQryGen.IsEmpty) Then
      LExistePontoImpressaoSpool := LQryGen.Fields[0].AsInteger > 0;

    LQryGen.Close;
    LQryGen.SQL.Clear;
    LQryGen.SQL.Add('SELECT NFE_PONIMP FROM LOGNFE WHERE NFE_ACESSO = "' + AChaveAcesso + '" ');

    If fEmptyStr(AstrPonImp) Then
    Begin
      pLogImp('Carregando ponto de impressao DANFE a partir da LOGNFE "' + AChaveAcesso + '" (T1)');
      LQryGen.Open;
      LPontoImpressao := LQryGen.FieldByName('NFE_PONIMP').AsString;
    End
    Else
    Begin
      LPontoImpressao := AstrPonImp;
    End;

    If LExistePontoImpressaoSpool And (LPontoImpressao = '') Then
    Begin
      For LTentativas := 2 To 5 Do
      Begin
        Sleep(1000);
        pLogImp('Carregando ponto de impressao DANFE a partir da LOGNFE "' + AChaveAcesso + '" (T' + IntToStr(LTentativas) + ')');
        LQryGen.Close;
        LQryGen.Open;
        LPontoImpressao := LQryGen.FieldByName('NFE_PONIMP').AsString;
        If LPontoImpressao <> '' Then
          Break;
      End;
    End;

    If LPontoImpressao = '' Then
    Begin
      pLogImp('Ponto de impressao nao localizado');
      Result := '';
    End
    Else
    Begin
      pLogImp('Ponto de impressao localizado: ' + LPontoImpressao);

      If LExistePontoImpressaoSpool Then
      Begin
        Try
          LQryGen.Close;
          LQryGen.SQL.Clear;
          LQryGen.SQL.Add('SELECT PON_NOMIMP FROM PONIMP WHERE PON_CODEMP = "' + VS_strCodEmp + '" AND PON_NOMPON = "' + LPontoImpressao + '" AND PON_SPOIMP = "S"');
          LQryGen.Open;
          Result := LQryGen.FieldByName('PON_NOMIMP').AsString;

          pLogImp('Nome da impressora do ponto de impressao spool: ' + Result);
        Except
          Result := '';
        End;
      End;
    End;
  Finally
    FreeAndNil(LQryGen);
  End;
end;

function TConexaoBD.fRetMsgPed(strNumDoc, strEspDoc, strCodEmp: string): string;
var
  qryMsg: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := EmptyStr;
  qryMsg := fCriaQuery;

  try
    qryMsg.Close;
    qryMsg.SQL.Clear;
    qryMsg.SQL.Add('SELECT DISTINCT FG.FGO_MEN001,              ');
    qryMsg.SQL.Add('                FG.FGO_MEN002,              ');

    If (fCampoExiste('AUXGOR', 'AUX_MEN003')) Then
      qryMsg.SQL.Add('  AG.AUX_MEN003,                     ')
    else
      qryMsg.SQL.Add('  CAST("" AS CHAR(1)) AS AUX_MEN003, ');

    If (fCampoExiste('AUXGOR', 'AUX_MEN004')) Then
      qryMsg.SQL.Add('  AG.AUX_MEN004,                     ')
    else
      qryMsg.SQL.Add('  CAST("" AS CHAR(1)) AS AUX_MEN004, ');

    If (fCampoExiste('AUXGOR', 'AUX_MEN005')) Then
      qryMsg.SQL.Add('  AG.AUX_MEN005                      ')
    else
      qryMsg.SQL.Add('  CAST("" AS CHAR(1)) AS AUX_MEN005  ');

    qryMsg.SQL.Add('  FROM FATGOR FG                                   ');
    qryMsg.SQL.Add('  JOIN MOVDET MD ON MD.DET_NUM_PD = FG.FGO_NUMDOC  ');
    qryMsg.SQL.Add('    AND MD.DET_ESP_PD = FG.FGO_ESPDOC              ');
    qryMsg.SQL.Add('    AND MD.DET_EMP_PD = FG.FGO_CODEMP              ');
    qryMsg.SQL.Add('   JOIN AUXGOR AG ON AG.AUX_SEQGER = FG.AUTOINCREM ');
    qryMsg.SQL.Add('  WHERE MD.DET_CODEMP = :CODEMP                    ');
    qryMsg.SQL.Add('    AND MD.DET_ESPDOC = :ESPDOC                    ');
    qryMsg.SQL.Add('    AND MD.DET_NUMDOC = :NUMDOC                    ');

    qryMsg.ParamByName('CODEMP').AsString := strCodEmp;
    qryMsg.ParamByName('ESPDOC').AsString := strEspDoc;
    qryMsg.ParamByName('NUMDOC').AsString := strNumDoc;

    qryMsg.Open;

    if (not qryMsg.IsEmpty) then
    begin
      Result := qryMsg.FieldByName('FGO_MEN001').AsString+ ' '+
                qryMsg.FieldByName('FGO_MEN002').AsString+ ' '+
                qryMsg.FieldByName('AUX_MEN003').AsString+ ' '+
                qryMsg.FieldByName('AUX_MEN004').AsString+ ' '+
                qryMsg.FieldByName('AUX_MEN005').AsString;
    end;
  finally
    FreeAndNil(qryMsg);
  end;
end;

function TConexaoBD.fRetNFUti(strNumDoc, strEspDoc, strCodEmp: string; out strEmpNF, strEspNF, strNumNF : String): string;
var
  qryPD: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qryNF: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := EmptyStr;
  qryPD := fCriaQuery;
  qryNF := fCriaQuery;

  try
    qryPD.Close;
    qryPD.SQL.Clear;
    qryPD.SQL.Add(' SELECT DISTINCT MOVDET.DET_NUM_PD,                         ');
    qryPD.SQL.Add('    MOVDET.DET_ESP_PD,                                      ');
    qryPD.SQL.Add('    MOVDET.DET_EMP_PD                                      ');
    qryPD.SQL.Add('  FROM MOVDET                                               ');
    qryPD.SQL.Add('  LEFT JOIN FATDOR ON FATDOR.FDO_NUMDOC = MOVDET.DET_NUM_PD ');
    qryPD.SQL.Add('    AND FATDOR.FDO_ESPDOC = MOVDET.DET_ESP_PD               ');
    qryPD.SQL.Add('    AND FATDOR.FDO_CODEMP = MOVDET.DET_EMP_PD               ');
    qryPD.SQL.Add('  WHERE MOVDET.DET_CODEMP = :CODEMP                         ');
    qryPD.SQL.Add('    AND MOVDET.DET_ESPDOC = :ESPDOC                         ');
    qryPD.SQL.Add('    AND MOVDET.DET_NUMDOC = :NUMDOC                         ');

    qryPD.ParamByName('CODEMP').AsString := strCodEmp;
    qryPD.ParamByName('ESPDOC').AsString := strEspDoc;
    qryPD.ParamByName('NUMDOC').AsString := strNumDoc;

    qryPD.Open;

    if (not qryPD.IsEmpty) then
    Begin
      qryNF.Close;
      qryNF.SQL.Clear;
      qryNF.SQL.Add(' SELECT DISTINCT MOVDET.DET_NUMDOC,                         ');
      qryNF.SQL.Add('    MOVDET.DET_ESPDOC,                                      ');
      qryNF.SQL.Add('    MOVDET.DET_CODEMP                                       ');
      qryNF.SQL.Add('  FROM MOVDET                                               ');
      qryNF.SQL.Add('  WHERE MOVDET.DET_EMP_PD = :CODEMP                         ');
      qryNF.SQL.Add('    AND MOVDET.DET_ESP_PD = :ESPDOC                         ');
      qryNF.SQL.Add('    AND MOVDET.DET_NUM_PD = :NUMDOC                         ');
      qryNF.SQL.Add('    AND MOVDET.DET_ESPDOC = "NF"                            ');

      qryNF.ParamByName('CODEMP').AsString := qryPD.FieldByName('DET_EMP_PD').AsString;
      qryNF.ParamByName('ESPDOC').AsString := qryPD.FieldByName('DET_ESP_PD').AsString;
      qryNF.ParamByName('NUMDOC').AsString := qryPD.FieldByName('DET_NUM_PD').AsString;

      qryNF.Open;

      If (not qryNF.IsEmpty) then
      begin
        strNumNF := qryNF.FieldByName('DET_NUMDOC').AsString;
        strEspNF := qryNF.FieldByName('DET_ESPDOC').AsString;
        strEmpNF := qryNF.FieldByName('DET_CODEMP').AsString;
      end;
    End

  finally
    FreeAndNil(qryPD);
    FreeAndNil(qryNF);
  end;
end;

function TConexaoBD.fRetObsOrdemServ(strNumDoc, strEspDoc,
  strCodEmp: string): string;
var
  qryObs: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := EmptyStr;
  qryObs := fCriaQuery;

  try
    qryObs.Close;
    qryObs.SQL.Clear;
    qryObs.SQL.Add('SELECT EG.EQU_OBSNFS                              ');
    qryObs.SQL.Add('  FROM MOVGER MG                                  ');
    qryObs.SQL.Add('  JOIN FATGOR FG ON FG.FGO_TIPFAT = MG.GER_ESPDOC ');
    qryObs.SQL.Add('    AND FG.FGO_NUMFAT = MG.GER_NUMDOC             ');
    qryObs.SQL.Add('    AND FG.FGO_CODEMP = MG.GER_CODEMP             ');
    qryObs.SQL.Add('    AND FG.FGO_JAFATU = 1                         ');
    qryObs.SQL.Add('  JOIN EQUGER EG ON EG.EQU_TIPPED = FG.FGO_ESPDOC ');
    qryObs.SQL.Add('    AND EG.EQU_NUMPED = FG.FGO_NUMDOC             ');
    qryObs.SQL.Add('    AND EG.EQU_CODEMP = FG.FGO_CODEMP             ');
    qryObs.SQL.Add('  WHERE MG.GER_CODEMP = :CODEMP                   ');
    qryObs.SQL.Add('    AND MG.GER_ESPDOC = :ESPDOC                   ');
    qryObs.SQL.Add('    AND MG.GER_NUMDOC = :NUMDOC                   ');


    qryObs.ParamByName('CODEMP').AsString := strCodEmp;
    qryObs.ParamByName('ESPDOC').AsString := strEspDoc;
    qryObs.ParamByName('NUMDOC').AsString := strNumDoc;

    qryObs.Open;

    if (not qryObs.IsEmpty) then
    begin
      Result := qryObs.FieldByName('EQU_OBSNFS').AsString;
    end;
  finally
    FreeAndNil(qryObs);
  end;
end;

function TConexaoBD.fRetDesIte(strNumDoc, strEspDoc, strCodEmp: string): string;
var
  qryDescri: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := EmptyStr;
  qryDescri := fCriaQuery;

  try
    qryDescri.Close;
    qryDescri.SQL.Clear;
    qryDescri.SQL.Add('SELECT D.DET_DESCRI                              ');
    qryDescri.SQL.Add('  FROM MOVDET D                                  ');
    qryDescri.SQL.Add('  WHERE D.DET_CODEMP = :CODEMP                   ');
    qryDescri.SQL.Add('    AND D.DET_ESPDOC = :ESPDOC                   ');
    qryDescri.SQL.Add('    AND D.DET_NUMDOC = :NUMDOC                   ');
    qryDescri.SQL.Add('  LIMIT 1                                        ');


    qryDescri.ParamByName('CODEMP').AsString := strCodEmp;
    qryDescri.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDescri.ParamByName('NUMDOC').AsString := Format('%.12d', [StrToIntDef(strNumDoc, 0)]);

    qryDescri.Open;

    if (not qryDescri.IsEmpty) then
    begin
      Result := qryDescri.FieldByName('DET_DESCRI').AsString;
    end;
  finally
    FreeAndNil(qryDescri);
  end;
end;

procedure TConexaoBD.pGetDadosCancelamentoNFS(strNumDoc, strEspDoc, strCodEmp : String; out strDtaDel, strHorDel, strMotDel : String);
var
  qryConsulta : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  strDtaDel := EmptyStr;
  strHorDel := EmptyStr;
  strMotDel := EmptyStr;

  qryConsulta := fCriaQuery(nil, FDatabase);

  try

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT                             ');
    qryConsulta.SQL.Add('  M.DTADEL,                        ');
    qryConsulta.SQL.Add('  M.HORDEL,                        ');
    qryConsulta.SQL.Add('  M.MOTDEL                         ');
    qryConsulta.SQL.Add('FROM                               ');
    qryConsulta.SQL.Add('  DEL_MOVGER M                     ');
    qryConsulta.SQL.Add('WHERE M.GER_NUMDOC = :NUMDOC       ');
    qryConsulta.SQL.Add('  AND M.GER_ESPDOC = :ESPDOC       ');
    qryConsulta.SQL.Add('  AND M.GER_CODEMP = :CODEMP       ');
    qryConsulta.SQL.Add('UNION                              ');
    qryConsulta.SQL.Add('ALL                                ');
    qryConsulta.SQL.Add('SELECT                             ');
    qryConsulta.SQL.Add('  N.DTADEL,                        ');
    qryConsulta.SQL.Add('  N.HORDEL,                        ');
    qryConsulta.SQL.Add('  N.MOTDEL                         ');
    qryConsulta.SQL.Add('FROM                               ');
    qryConsulta.SQL.Add('  DEL_NOTGER N                     ');
    qryConsulta.SQL.Add('WHERE N.GER_NUMDOC = :NUMDOC       ');
    qryConsulta.SQL.Add('  AND N.GER_ESPDOC = :ESPDOC       ');
    qryConsulta.SQL.Add('  AND N.GER_CODEMP = :CODEMP       ');

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;

    qryConsulta.Open;

    strDtaDel := qryConsulta.FieldByName('DTADEL').asString;
    strHorDel := qryConsulta.FieldByName('HORDEL').asString;
    strMotDel := qryConsulta.FieldByName('MOTDEL').asString;

  finally
    FreeAndNil(qryConsulta);
  end;

end;

procedure TConexaoBD.pGetValoresRetencoesNFS(strNumDoc, strEspDoc, strCodEmp, strSerie_ : String; out fltVlrCofins, fltVlrCsll, fltVlrPis, fltVlrIr, fltVlrInss : Double);
var
  qryConsulta : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  fltVlrCofins := 0;
  fltVlrCsll   := 0;
  fltVlrPis    := 0;
  fltVlrIr     := 0;
  fltVlrInss   := 0;

  qryConsulta := fCriaQuery(nil, FDatabase);

  try

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT                             ');
    qryConsulta.SQL.Add('  M.GER_COSERT,                    ');
    qryConsulta.SQL.Add('  M.GER_CSSERT,                    ');
    qryConsulta.SQL.Add('  M.GER_PISERT,                    ');
    qryConsulta.SQL.Add('  M.GER_IRSERT,                    ');
    qryConsulta.SQL.Add('  M.GER_CSPRRT                     ');
    qryConsulta.SQL.Add('FROM                               ');
    qryConsulta.SQL.Add('  MOVGER M                         ');
    qryConsulta.SQL.Add('WHERE M.GER_NUMDOC = :NUMDOC       ');
    qryConsulta.SQL.Add('  AND M.GER_ESPDOC = :ESPDOC       ');
    qryConsulta.SQL.Add('  AND M.GER_CODEMP = :CODEMP       ');
    qryConsulta.SQL.Add('  AND IFNULL(M.GER_SERIE_, "") = IFNULL(:SERIE_, "") ');
    qryConsulta.SQL.Add('UNION                              ');
    qryConsulta.SQL.Add('ALL                                ');
    qryConsulta.SQL.Add('SELECT                             ');
    qryConsulta.SQL.Add('  N.GER_COSERT,                    ');
    qryConsulta.SQL.Add('  N.GER_CSSERT,                    ');
    qryConsulta.SQL.Add('  N.GER_PISERT,                    ');
    qryConsulta.SQL.Add('  N.GER_IRSERT,                    ');
    qryConsulta.SQL.Add('  N.GER_CSPRRT                     ');
    qryConsulta.SQL.Add('FROM                               ');
    qryConsulta.SQL.Add('  NOTGER N                         ');
    qryConsulta.SQL.Add('WHERE N.GER_NUMDOC = :NUMDOC       ');
    qryConsulta.SQL.Add('  AND N.GER_ESPDOC = :ESPDOC       ');
    qryConsulta.SQL.Add('  AND N.GER_CODEMP = :CODEMP       ');
    qryConsulta.SQL.Add('  AND IFNULL(N.GER_SERIE_, "") = IFNULL(:SERIE_, "") ');

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;
    qryConsulta.ParamByName('SERIE_').AsString := strSerie_;

    qryConsulta.Open;

    fltVlrCofins := qryConsulta.FieldByName('GER_COSERT').asFloat;
    fltVlrCsll   := qryConsulta.FieldByName('GER_CSSERT').asFloat;
    fltVlrPis    := qryConsulta.FieldByName('GER_PISERT').asFloat;
    fltVlrIr     := qryConsulta.FieldByName('GER_IRSERT').asFloat;
    fltVlrInss   := qryConsulta.FieldByName('GER_CSPRRT').asFloat;

  finally
    FreeAndNil(qryConsulta);
  end;

end;

procedure TConexaoBD.pGetItensServicoParaENotas(strNumDoc, strEspDoc, strCodEmp : String; out strIteDes: String);
var
  qryIteDes : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  strIteDes := EmptyStr;
  qryIteDes := fCriaQuery;

  try
    qryIteDes.Close;
    qryIteDes.SQL.Clear;

    qryIteDes.SQL.Text := 'SELECT                         '+
                          '  CONCAT(                      '+
                          '    IFNULL(G.GER_DESS01, " "), "#", '+
                          '    IFNULL(G.GER_DESS02, " "), "#", '+
                          '    IFNULL(G.GER_DESS03, " "), "#", '+
                          '    IFNULL(G.GER_DESS04, " "), "#", '+
                          '    IFNULL(G.GER_DESS05, " "), "#", '+
                          '    IFNULL(G.GER_DESS06, " "), "#", '+
                          '    IFNULL(S.GER_DESS07, " "), "#", '+
                          '    IFNULL(S.GER_DESS08, " "), "#", '+
                          '    IFNULL(S.GER_DESS09, " "), "#", '+
                          '    IFNULL(S.GER_DESS10, " "), "#", '+
                          '    IFNULL(S.GER_DESS11, " "), "#", '+
                          '    IFNULL(S.GER_DESS12, " "), "#", '+
                          '    IFNULL(S.GER_DESS13, " "), "#", '+
                          '    IFNULL(S.GER_DESS14, " "), "#", '+
                          '    IFNULL(S.GER_DESS15, " "), "#", '+
                          '    IFNULL(S.GER_DESS16, " "), "#", '+
                          '    IFNULL(S.GER_DESS17, " "), "#", '+
                          '    IFNULL(S.GER_DESS18, " "), "#", '+
                          '    IFNULL(S.GER_DESS19, " "), "#", '+
                          '    IFNULL(S.GER_DESS20, " "), "#", '+
                          '    IFNULL(S.GER_DESS21, " "), "#", '+
                          '    IFNULL(S.GER_DESS22, " "), "#", '+
                          '    IFNULL(S.GER_DESS23, " "), "#", '+
                          '    IFNULL(S.GER_DESS24, " "), "#", '+
                          '    IFNULL(S.GER_DESS25, " "), "#", '+
                          '    IFNULL(S.GER_DESS26, " "), "#", '+
                          '    IFNULL(S.GER_DESS27, " "), "#", '+
                          '    IFNULL(S.GER_DESS28, " "), "#", '+
                          '    IFNULL(S.GER_DESS29, " "), "#", '+
                          '    IFNULL(S.GER_DESS30, " ")  '+
                          '  ) AS DESSER                              '+
                          'FROM                                       '+
                          '  MOVGER G                                 '+
                          '  LEFT JOIN SERMOV S                       '+
                          '    ON S.GER_SEQGER = G.AUTOINCREM         '+
                          'WHERE G.GER_ESPDOC = :ESPDOC               '+
                          '  AND G.GER_NUMDOC = :NUMDOC               '+
                          '  AND G.GER_CODEMP = :CODEMP               '+
                          '  AND G.GER_TIP_FC = "C"                   ';

    qryIteDes.ParamByName('NUMDOC').AsString := strNumDoc;
    qryIteDes.ParamByName('ESPDOC').AsString := strEspDoc;
    qryIteDes.ParamByName('CODEMP').AsString := strCodEmp;

    qryIteDes.Open;

    strIteDes := qryIteDes.FieldByName('DESSER').AsString;
    FInfosNfsBd.strIteDes := qryIteDes.FieldByName('DESSER').AsString;

  finally
    FreeAndNil(qryIteDes);
  end;
end;

procedure TConexaoBD.pGetItensServicoParaENotas( var cdsItens: TUniClientDataSet; strNumDoc, strEspDoc, strCodEmp : String; out strIndOpe: String; out strCodNBS: String ) ;
var
  qryItensServico: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  intServico: integer;
  strCmpCodNBS: String;
  strCmpIndOpe: String;
begin
  strCodNBS := EmptyStr;
  strIndOpe := EmptyStr;

  strCmpIndOpe := ' CAST("" AS CHAR(1)) AS SER_INDOPE, ';
  If fCampoExiste('CADSER', 'SER_INDOPE') Then
    strCmpIndOpe := ' C.SER_INDOPE, ';

  strCmpCodNBS := ' CAST("" AS CHAR(1)) AS SER_CODNBS, ';
  If fCampoExiste('CADSER', 'SER_CODNBS') Then
    strCmpCodNBS := ' C.SER_CODNBS, ';

  qryItensServico := fCriaQuery;
  try
    qryItensServico.Close;
    qryItensServico.SQL.Clear;
    qryItensServico.SQL.Text := 'SELECT                                      '+
                                '  C.SER_TRIMUN,                             '+
                                strCmpIndOpe +
                                strCmpCodNBS +
                                '  G.GER_PERISS,                             '+
                                '  G.GER_DESS01, G.GER_VALS01, S.GER_QTDS01, '+
                                '  G.GER_DESS02, G.GER_VALS02, S.GER_QTDS02, '+
                                '  G.GER_DESS03, G.GER_VALS03, S.GER_QTDS03, '+
                                '  G.GER_DESS04, G.GER_VALS04, S.GER_QTDS04, '+
                                '  G.GER_DESS05, G.GER_VALS05, S.GER_QTDS05, '+
                                '  G.GER_DESS06, G.GER_VALS06, S.GER_QTDS06, '+
                                '  S.GER_DESS07, S.GER_VALS07, S.GER_QTDS07, '+
                                '  S.GER_DESS08, S.GER_VALS08, S.GER_QTDS08, '+
                                '  S.GER_DESS09, S.GER_VALS09, S.GER_QTDS09, '+
                                '  S.GER_DESS10, S.GER_VALS10, S.GER_QTDS10, '+
                                '  S.GER_DESS11, S.GER_VALS11, S.GER_QTDS11, '+
                                '  S.GER_DESS12, S.GER_VALS12, S.GER_QTDS12, '+
                                '  S.GER_DESS13, S.GER_VALS13, S.GER_QTDS13, '+
                                '  S.GER_DESS14, S.GER_VALS14, S.GER_QTDS14, '+
                                '  S.GER_DESS15, S.GER_VALS15, S.GER_QTDS15, '+
                                '  S.GER_DESS16, S.GER_VALS16, S.GER_QTDS16, '+
                                '  S.GER_DESS17, S.GER_VALS17, S.GER_QTDS17, '+
                                '  S.GER_DESS18, S.GER_VALS18, S.GER_QTDS18, '+
                                '  S.GER_DESS19, S.GER_VALS19, S.GER_QTDS19, '+
                                '  S.GER_DESS20, S.GER_VALS20, S.GER_QTDS20, '+
                                '  S.GER_DESS21, S.GER_VALS21, S.GER_QTDS21, '+
                                '  S.GER_DESS22, S.GER_VALS22, S.GER_QTDS22, '+
                                '  S.GER_DESS23, S.GER_VALS23, S.GER_QTDS23, '+
                                '  S.GER_DESS24, S.GER_VALS24, S.GER_QTDS24, '+
                                '  S.GER_DESS25, S.GER_VALS25, S.GER_QTDS25, '+
                                '  S.GER_DESS26, S.GER_VALS26, S.GER_QTDS26, '+
                                '  S.GER_DESS27, S.GER_VALS27, S.GER_QTDS27, '+
                                '  S.GER_DESS28, S.GER_VALS28, S.GER_QTDS28, '+
                                '  S.GER_DESS29, S.GER_VALS29, S.GER_QTDS29, '+
                                '  S.GER_DESS30, S.GER_VALS30, S.GER_QTDS30  '+
                                'FROM                                        '+
                                '  MOVGER G                                  '+
                                '  LEFT JOIN SERMOV S                        '+
                                '    ON S.GER_SEQGER = G.AUTOINCREM          '+
                                '  LEFT JOIN CADSER C                        '+
                                '    ON C.SER_CODSER = G.GER_CODS01          '+
                                'WHERE G.GER_ESPDOC = :ESPDOC                '+
                                '  AND G.GER_NUMDOC = :NUMDOC                '+
                                '  AND G.GER_CODEMP = :CODEMP                '+
                                '  AND G.GER_TIP_FC = "C";                   ';
    qryItensServico.ParamByName('NUMDOC').AsString := strNumDoc;
    qryItensServico.ParamByName('ESPDOC').AsString := strEspDoc;
    qryItensServico.ParamByName('CODEMP').AsString := strCodEmp;
    qryItensServico.Open;

    if not qryItensServico.isEmpty then
    begin

      strCodNBS := qryItensServico.FieldByName('SER_CODNBS').AsString;
      strIndOpe := qryItensServico.FieldByName('SER_INDOPE').AsString;

      for intServico := 1 to 30 do
      begin
        if not fEmptyStr(qryItensServico.FieldByName('GER_DESS'+FormatFloat('00', intServico)).asString) then
        begin
          cdsItens.Insert;
          cdsItens.FieldByName('CODSER').asString := qryItensServico.FieldByName('SER_TRIMUN').asString;
          cdsItens.FieldByName('ITEDES').asString := qryItensServico.FieldByName('GER_DESS'+FormatFloat('00', intServico)).asString;
          cdsItens.FieldByName('ITEQTD').asFloat  := qryItensServico.FieldByName('GER_QTDS'+FormatFloat('00', intServico)).asFloat;
          cdsItens.FieldByName('VLRUNT').asFloat  := qryItensServico.FieldByName('GER_VALS'+FormatFloat('00', intServico)).asFloat;
          cdsItens.FieldByName('VLRTOT').asFloat  := qryItensServico.FieldByName('GER_VALS'+FormatFloat('00', intServico)).asFloat;
          cdsItens.FieldByName('VLRDES').asFloat  := 0;
          cdsItens.FieldByName('ALIISS').asFloat  := qryItensServico.FieldByName('GER_PERISS').asFloat;
          cdsItens.Post;
        end;
      end;
    end;

  finally
    FreeAndNil(qryItensServico);
  end;
end;


function TConexaoBD.fUsaSat : Boolean;
Var
  strPathSat : String;
Begin
  If (CarregarCFGSIS('USASAT') = 'S') And (CarregarCFGSIS('SATECF') = 'S') Then
  Begin
    If Not fEmptyStr(VS_PathSat) Then
    Begin
      strPathSat := IncludeTrailingPathDelimiter(VS_PathSat) + 'opcoes_sat.ini';
    End
    Else
    Begin
      strPathSat := IncludeTrailingPathDelimiter(CarregarCFGSIS('PATSAT')) + 'opcoes_sat.ini';
    End;

    If FileExists(strPathSat) Then
      Result := StrToBool(fArqIniLocal(0, 'SATCFE', 'USASAT', '0', strPathSat ))
    Else
      Result := False;
  End
  Else
    Result := (CarregarCFGSIS('USASAT') = 'S');

  Result := Result And (CarregarCFGSIS('USNFCE') = 'N');
End;

function TConexaoBD.fUtilizaCadastroImpressoras: Boolean;
begin
  Result := CarregarCFGSIS('CADIMP') = 'S';
end;

procedure TConexaoBD.pCarregaModalidadesPagamento(fltTotGer: Double; strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strSerie: String; Var strModalidades, strValores, strCarConPag, strParcelasCartao, strDescrCartao: String);
  Var
    qryMod : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    fltTotMod: Double;
    strTipCar: String;
    fltValPag: Double;
    strModVal: String;
    strParcAtual: String;
    strSQL: String;

    Function fFormaPagtoAPrazo(strCodFpg: String): Boolean;
      Const
        arrAPrazo : Array[0..4] Of String = ('008','010','012','014','015');
      Var
        i: Integer;
    Begin
      Result := False;

      For i := Low(arrAPrazo) To High(arrAPrazo) Do
      Begin
        If (Not Result) And (strCodFpg = arrAPrazo[i]) Then
          Result := True;
      End;
    End;

begin

  qryMod := fCriaQuery(nil);
  strSQL := '';

  Try

    if fCfgSis('NFCMOD') = 'T' then
    begin
      strSQL :=          'SELECT DISTINCT ';
      strSQL := strSQL + '  FPG_CODIGO, ';
      strSQL := strSQL + '  FPG_DESCRI, ';
      strSQL := strSQL + '  SUM(MOD_VALMOD) AS MOD_VALMOD, ';
      strSQL := strSQL + '  SUM(MOD_VALPAG) AS MOD_VALPAG, ';

      strSQL := strSQL + '  MCA_TIPCAR, ';
      If fCampoExiste('MOVCAR', 'MCA_CONPAG') then
        strSQL := strSQL + '   MCA_CONPAG, ';
      If fCampoExiste('CADCAR', 'CAR_CODCAR') then
        strSQL := strSQL + '   CAR_CODCAR, ';
      If fCampoExiste('CADCAR', 'CAR_DESCAR') then
        strSQL := strSQL + '   CAR_DESCAR, ';
      If fCampoExiste('CADCAR', 'CAR_TIPCAR') then
        strSQL := strSQL + '   CAR_TIPCAR, ';
      strSQL := strSQL + '  MCA_VALDUP, ';
      strSQL := strSQL + '  MCA_VALSTA, ';
      strSQL := strSQL + '  CASE MOD_CODMOD ';
      strSQL := strSQL + '    WHEN "001" THEN "01" ';
      strSQL := strSQL + '    WHEN "002" THEN "02" ';
      strSQL := strSQL + '    WHEN "006" THEN "02" ';
      strSQL := strSQL + '    WHEN "007" THEN IF(CAR_TIPCAR="C", "03", "04") ';
      strSQL := strSQL + '    ELSE "99" ';
      strSQL := strSQL + '  END AS CODMOD ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '   MOVMOD ';
      strSQL := strSQL + '   JOIN CADFPG ON FPG_CODIGO = MOD_CODMOD ';
      strSQL := strSQL + '   LEFT JOIN MOVCAR ON MOD_DOCUME = MCA_DOCUME AND MCA_PARCEL = "A" AND MOD_CODMOD = "007" AND TRIM(IFNULL(MOD_DOCUME, "")) <> "" AND MOD_CODCLI = MCA_CODCLI ';
      strSQL := strSQL + '   LEFT JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   MOD_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '   MOD_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '   MOD_CODEMP = :CODEMP AND ';
      strSQL := strSQL + IIF(strEspDoc <> 'IF', ' TRUE ', '  MOD_CODCLI = :CODCLI ');
      strSQL := strSQL + '   AND  IFNULL(MOD_SERIE_, "") = :SERIE_ ';
      strSQL := strSQL + '   GROUP BY ';
      strSQL := strSQL + '   MOD_NUMDOC, MOD_ESPDOC, MOD_CODEMP, MOD_CODCLI, MOD_SERIE_, MOD_CODMOD ';
    end
    else
    begin
      strSQL :=          'SELECT ';
      strSQL := strSQL + '  FPG_CODIGO, ';
      strSQL := strSQL + '  FPG_DESCRI, ';
      strSQL := strSQL + '  MOD_VALMOD, ';
      strSQL := strSQL + '  MOD_VALPAG, ';

      strSQL := strSQL + '  MCA_TIPCAR, ';
      If fCampoExiste('MOVCAR', 'MCA_CONPAG') then
        strSQL := strSQL + '   MCA_CONPAG, ';
      If fCampoExiste('CADCAR', 'CAR_CODCAR') then
        strSQL := strSQL + '   CAR_CODCAR, ';
      If fCampoExiste('CADCAR', 'CAR_DESCAR') then
        strSQL := strSQL + '   CAR_DESCAR, ';
      If fCampoExiste('CADCAR', 'CAR_TIPCAR') then
        strSQL := strSQL + '   CAR_TIPCAR, ';
      strSQL := strSQL + '  MCA_VALSTA, ';
      strSQL := strSQL + '  CASE MOD_CODMOD ';
      strSQL := strSQL + '    WHEN "001" THEN "01" ';
      strSQL := strSQL + '    WHEN "002" THEN "02" ';
      strSQL := strSQL + '    WHEN "006" THEN "02" ';
      If fCampoExiste('MOVMOD', 'MOD_TIPCAR') Then
        strSQL := strSQL + '    WHEN "007" THEN IF(MOD_DOCUME <> "", IF(CAR_TIPCAR="C", "03", "04"), IF(MOD_TIPCAR="C", "03", "04")) '
      else
        strSQL := strSQL + '    WHEN "007" THEN IF(CAR_TIPCAR="C", "03", "04") ';
      strSQL := strSQL + '    ELSE "99" ';
      strSQL := strSQL + '  END AS CODMOD ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  MOVMOD ';
      strSQL := strSQL + '  JOIN CADFPG ON FPG_CODIGO = MOD_CODMOD ';
      strSQL := strSQL + '  LEFT JOIN MOVCAR ON MOD_DOCUME = MCA_DOCUME ';
      strSQL := strSQL + '                  AND MCA_PARCEL = "A" ';
      strSQL := strSQL + '                  AND MOD_CODMOD = "007" ';
      strSQL := strSQL + '                  AND TRIM(IFNULL(MOD_DOCUME, "")) <> "" ';
      strSQL := strSQL + '                  AND MOD_CODCLI = MCA_CODCLI ';
      strSQL := strSQL + '  LEFT JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  MOD_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  MOD_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  MOD_CODEMP = :CODEMP AND ';
      strSQL := strSQL + IIF(strEspDoc <> 'IF', ' TRUE ', '  MOD_CODCLI = :CODCLI ');      
      strSQL := strSQL + '  AND IFNULL(MOD_SERIE_, "") = :SERIE_ ';
    end;

    qryMod.Close;
    qryMod.SQL.Clear;
    qryMod.SQL.Text := strSQL;

    qryMod.ParamByName('NUMDOC').AsString := strNumDoc;
    qryMod.ParamByName('ESPDOC').AsString := strEspDoc;
    qryMod.ParamByName('CODEMP').AsString := strCodEmp;

    if strEspDoc = 'IF' then
      qryMod.ParamByName('CODCLI').AsString := strCodCli;

    qryMod.ParamByName('SERIE_').AsString := strSerie;
    qryMod.Open;

    strModalidades := '';
    strValores := '';
    strCarConPag := '';
    fltTotMod := 0;
    strParcelasCartao := '';
    strModVal := '';
    strDescrCartao := '';

    qryMod.First;

    While (Not qryMod.Eof) Do
    Begin
      strTipCar := '';

      {********************************************************************************}
      {* SE A FORMA DE PAGAMENTO FOR A PRAZO, UTILIZA O VALMOD, SE NÃO UTILIZA VALPAG *}
      {*****************************************************************************MM*}
      If fFormaPagtoAPrazo(qryMod.FieldByName('FPG_CODIGO').AsString) Then
        fltValPag := qryMod.FieldByName('MOD_VALMOD').AsFloat
      Else
        fltValPag := qryMod.FieldByName('MOD_VALPAG').AsFloat;

      If fltValPag > 0 Then
      Begin
        If Pos(qryMod.FieldByName('CODMOD').AsString, '03_04_') > 0 Then
        Begin
          If (qryMod.FieldByName('MCA_TIPCAR').AsString = 'TEF') Then
          Begin
            strTipCar := 'TEF';
          End
          Else
          Begin
            strTipCar := 'POS';
          End;
        End;

        If Not fEmptyStr(strTipCar) Then
          strModalidades := strModalidades + qryMod.FieldByName('FPG_DESCRI').AsString + ' (' + strTipCar + '):'
        Else
          strModalidades := strModalidades + qryMod.FieldByName('FPG_DESCRI').AsString + ':';

        strValores     := strValores + FloatToStrF(fltValPag, ffNumber, 12, 2);
        fltTotMod      := fltTotMod + fltValPag;

        If qryMod.RecNo < qryMod.RecordCount Then
        Begin
          strModalidades := strModalidades + IIF( strEspDoc <> 'IF', ' ', #13#10);
          strValores := strValores + IIF( strEspDoc <> 'IF', ' ', #13#10);
        End;

        If strEspDoc <> 'IF' Then
        Begin
          strModVal := strModVal +
            IIF(Not fEmptyStr(strTipCar),
              qryMod.FieldByName('FPG_DESCRI').AsString + ' (' + strTipCar + '):', qryMod.FieldByName('FPG_DESCRI').AsString + ':')+ ' ' +
              FloatToStrF(fltValPag, ffNumber, 12, 2) + ' ';
        End;

        If Assigned(qryMod.FindField('CAR_CODCAR')) and Assigned(qryMod.FindField('CAR_DESCAR')) and Assigned(qryMod.FindField('MCA_CONPAG')) then
        Begin
          If Pos(qryMod.FieldByName('CODMOD').AsString, '03_04') > 0 Then
          Begin
            strCarConPag := strCarConPag + 'CARTÃO: ' + qryMod.FieldByName('CAR_CODCAR').AsString + ' - ' +
                                                               qryMod.FieldByName('CAR_DESCAR').AsString + ' - ' +
                                                               fFormataCondPag(qryMod.FieldByName('MCA_CONPAG').AsString);

            strParcAtual := '';
            if not fEmptyStr(qryMod.FieldByName('MCA_CONPAG').asString) then
              strParcAtual := Copy(qryMod.FieldByName('MCA_CONPAG').asString,1,2)+ ' X ' +
              FormatFloat('###,##0.00', qryMod.FieldByName('MCA_VALSTA').asFloat);
            strParcelasCartao := strParcAtual;

            strDescrCartao := strDescrCartao + 'CARTÃO' +
                                               iif(qryMod.FieldByName('CAR_TIPCAR').AsString='D', ' (DÉBITO): ', ' (CRÉDITO): ' ) +
                                               strParcelasCartao + ' - ' +
                                               fFormataCondPag(qryMod.FieldByName('MCA_CONPAG').AsString);
          End;
        End;

      End;

      qryMod.Next;
    End;

    if strEspDoc <> 'IF' then
      strModalidades := strModVal;

    If fFormataFloat(fltTotGer, 2) > fFormataFloat(fltTotMod, 2) Then
    Begin
      strModalidades := strModalidades + IIF( strEspDoc <> 'IF', ' ', #13#10) + 'DINHEIRO:';
      strValores     := strValores     + IIF( strEspDoc <> 'IF', ' ', #13#10) + FloatToStrF(fFormataFloat(fltTotGer, 2) - fFormataFloat(fltTotMod, 2), ffNumber, 12, 2);
    End;

  Finally
    FreeAndNil(qryMod);
  End;
end;

procedure TConexaoBD.pExportarLayoutDANFe(strCodigoEmpresa, strModelo: string;
  fltVersaoNFe: Double; intTipoLayout: Integer; strCaminhoArquivo: String;
  ALayoutSimplificado, ALayoutSmartPOS: Boolean; ALayoutUnificado: Boolean = False);
Var
  strCampoLayout : String;
  qryConf: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryConf := fAbrirQueryLayoutDANFe(strCodigoEmpresa, strModelo, fltVersaoNFe);

  try
    try
      if not qryConf.IsEmpty then
      begin
        If ALayoutUnificado Then
        Begin
          strCampoLayout := 'NFE_LAYUNI';
        End
        Else If ALayoutSimplificado Then
        Begin
          strCampoLayout := 'NFE_LAYSIM';
        End
        Else If ALayoutSmartPOS Then
        Begin
          strCampoLayout := 'NFE_LAYSMA';
        End
        Else
        Begin
          case intTipoLayout of
            0: strCampoLayout := 'NFE_LAYRET';
            1: strCampoLayout := 'NFE_LAYPSG';
          end;
        End;

        TBlobField(qryConf.FieldByName(strCampoLayout)).SaveToFile(strCaminhoArquivo);
      end;
    except
      On E: Exception Do
      Begin
      {$IF Defined(LINUX)}
        Writeln(E.Message);
      {$ELSE}
        ShowErrorMsgTimeout(E.ClassName, e.Message, 10000);
      {$IFEND}
      End;
    end;
  finally
    FreeAndNil(qryConf);
  end;
end;

procedure TConexaoBD.pImportarLayoutDANFe(strCodigoEmpresa, strModelo: string;
  fltVersaoNFe: Double; intTipoLayout: Integer; strCaminhoArquivo: String;
  ALayoutSimplificado, ALayoutSmartPOS: Boolean; ALayoutUnificado: Boolean = False);
Var
  strCampoLayout : String;
  lstArquivo: TStringList;
  qryConf: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryConf := fAbrirQueryLayoutDANFe(strCodigoEmpresa, strModelo, fltVersaoNFe);

  try
    try
      if not qryConf.IsEmpty then
      begin
        lstArquivo := TStringList.Create;
        try
          {$IF Defined(UNIDAC)}
          try
            lstArquivo.LoadFromFile(strCaminhoArquivo, TEncoding.UTF8);
          except
            lstArquivo.LoadFromFile(UTF8Encode(strCaminhoArquivo));
          end;
          {$ELSE}
          lstArquivo.LoadFromFile(UTF8Encode(strCaminhoArquivo));
          {$IFEND}

          If ALayoutUnificado Then
          Begin
            strCampoLayout := 'NFE_LAYUNI';
          End
          Else If ALayoutSimplificado Then
          Begin
            strCampoLayout := 'NFE_LAYSIM';
          End
          Else If ALayoutSmartPOS Then
          Begin
            strCampoLayout := 'NFE_LAYSMA';
          End
          Else
          Begin
            case intTipoLayout of
              0: strCampoLayout := 'NFE_LAYRET';
              1: strCampoLayout := 'NFE_LAYPSG';
            end;
          End;

          qryConf.Edit;
          qryConf.FieldByName(strCampoLayout).Text := lstArquivo.Text;
          qryConf.Post;
        finally
          lstArquivo.Free;
        end;
      end;
    except
      On E: Exception Do
      Begin
      {$IF Defined(LINUX)}
        Writeln(E.Message);
      {$ELSE}
        ShowErrorMsgTimeout(E.ClassName, e.Message, 10000);
      {$IFEND}
      End;
    end;
  finally
    FreeAndNil(qryConf);
  end;
end;

procedure TConexaoBD.pSetaEmpresa(strCodEmp: String);
begin
  FConfiguracao.CodigoEmpresa := strCodEmp;
  untUtil.VS_strCodEmp := strCodEmp;
end;

procedure TConexaoBD.pGetListaDeServico(strNumDoc, strEspDoc, strCodEmp: string; out strCodSer: string);
  Var
    qryGenTmp: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin

  strCodSer := EmptyStr;

  qryGenTmp := fCriaQuery(Nil);

  Try

    qryGenTmp.Close;
    qryGenTmp.SQL.Clear;

    qryGenTmp.SQL.Add('SELECT DISTINCT GROUP_CONCAT(X.CODSER) AS CODSER                                                                                                                              ');
    qryGenTmp.SQL.Add('FROM (                                                                                                                                                                        ');
    qryGenTmp.SQL.Add('SELECT IFNULL((SELECT CONCAT(S.SER_CDLSSE,"-",C.CDS_DESCRI) FROM CADSER S LEFT JOIN CADCDS C ON C.CDS_CDSERV = S.SER_CDLSSE WHERE S.SER_CODSER = M.GER_CODS01), "") AS CODSER ');
    qryGenTmp.SQL.Add('  FROM MOVGER M                                                                                                                                                               ');
    qryGenTmp.SQL.Add(' WHERE M.GER_NUMDOC = :NUMDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND M.GER_ESPDOC = :ESPDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND M.GER_CODEMP = :CODEMP                                                                                                                                                 ');
    qryGenTmp.SQL.Add('UNION ALL                                                                                                                                                                     ');
    qryGenTmp.SQL.Add('SELECT IFNULL((SELECT CONCAT(S.SER_CDLSSE,"-",C.CDS_DESCRI) FROM CADSER S LEFT JOIN CADCDS C ON C.CDS_CDSERV = S.SER_CDLSSE WHERE S.SER_CODSER = M.GER_CODS02), "") AS CODSER ');
    qryGenTmp.SQL.Add('  FROM MOVGER M                                                                                                                                                               ');
    qryGenTmp.SQL.Add(' WHERE M.GER_NUMDOC = :NUMDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND M.GER_ESPDOC = :ESPDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND M.GER_CODEMP = :CODEMP                                                                                                                                                 ');
    qryGenTmp.SQL.Add('UNION ALL                                                                                                                                                                     ');
    qryGenTmp.SQL.Add('SELECT IFNULL((SELECT CONCAT(S.SER_CDLSSE,"-",C.CDS_DESCRI) FROM CADSER S LEFT JOIN CADCDS C ON C.CDS_CDSERV = S.SER_CDLSSE WHERE S.SER_CODSER = M.GER_CODS03), "") AS CODSER ');
    qryGenTmp.SQL.Add('  FROM MOVGER M                                                                                                                                                               ');
    qryGenTmp.SQL.Add(' WHERE M.GER_NUMDOC = :NUMDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND M.GER_ESPDOC = :ESPDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND M.GER_CODEMP = :CODEMP                                                                                                                                                 ');
    qryGenTmp.SQL.Add('UNION ALL                                                                                                                                                                     ');
    qryGenTmp.SQL.Add('SELECT IFNULL((SELECT CONCAT(S.SER_CDLSSE,"-",C.CDS_DESCRI) FROM CADSER S LEFT JOIN CADCDS C ON C.CDS_CDSERV = S.SER_CDLSSE WHERE S.SER_CODSER = M.GER_CODS04), "") AS CODSER ');
    qryGenTmp.SQL.Add('  FROM MOVGER M                                                                                                                                                               ');
    qryGenTmp.SQL.Add(' WHERE M.GER_NUMDOC = :NUMDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND M.GER_ESPDOC = :ESPDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND M.GER_CODEMP = :CODEMP                                                                                                                                                 ');
    qryGenTmp.SQL.Add('UNION ALL                                                                                                                                                                     ');
    qryGenTmp.SQL.Add('SELECT IFNULL((SELECT CONCAT(S.SER_CDLSSE,"-",C.CDS_DESCRI) FROM CADSER S LEFT JOIN CADCDS C ON C.CDS_CDSERV = S.SER_CDLSSE WHERE S.SER_CODSER = M.GER_CODS05), "") AS CODSER ');
    qryGenTmp.SQL.Add('  FROM MOVGER M                                                                                                                                                               ');
    qryGenTmp.SQL.Add(' WHERE M.GER_NUMDOC = :NUMDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND M.GER_ESPDOC = :ESPDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND M.GER_CODEMP = :CODEMP                                                                                                                                                 ');
    qryGenTmp.SQL.Add('UNION ALL                                                                                                                                                                     ');
    qryGenTmp.SQL.Add('SELECT IFNULL((SELECT CONCAT(S.SER_CDLSSE,"-",C.CDS_DESCRI) FROM CADSER S LEFT JOIN CADCDS C ON C.CDS_CDSERV = S.SER_CDLSSE WHERE S.SER_CODSER = M.GER_CODS06), "") AS CODSER ');
    qryGenTmp.SQL.Add('  FROM MOVGER M                                                                                                                                                               ');
    qryGenTmp.SQL.Add(' WHERE M.GER_NUMDOC = :NUMDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND M.GER_ESPDOC = :ESPDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND M.GER_CODEMP = :CODEMP                                                                                                                                                 ');
    qryGenTmp.SQL.Add('UNION ALL                                                                                                                                                                     ');
    qryGenTmp.SQL.Add('SELECT IFNULL((SELECT CONCAT(S.SER_CDLSSE,"-",C.CDS_DESCRI) FROM CADSER S LEFT JOIN CADCDS C ON C.CDS_CDSERV = S.SER_CDLSSE WHERE S.SER_CODSER = N.GER_CODS01), "") AS CODSER ');
    qryGenTmp.SQL.Add('  FROM NOTGER N                                                                                                                                                               ');
    qryGenTmp.SQL.Add(' WHERE N.GER_NUMDOC = :NUMDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND N.GER_ESPDOC = :ESPDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND N.GER_CODEMP = :CODEMP                                                                                                                                                 ');
    qryGenTmp.SQL.Add('UNION ALL                                                                                                                                                                     ');
    qryGenTmp.SQL.Add('SELECT IFNULL((SELECT CONCAT(S.SER_CDLSSE,"-",C.CDS_DESCRI) FROM CADSER S LEFT JOIN CADCDS C ON C.CDS_CDSERV = S.SER_CDLSSE WHERE S.SER_CODSER = N.GER_CODS02), "") AS CODSER ');
    qryGenTmp.SQL.Add('  FROM NOTGER N                                                                                                                                                               ');
    qryGenTmp.SQL.Add(' WHERE N.GER_NUMDOC = :NUMDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND N.GER_ESPDOC = :ESPDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND N.GER_CODEMP = :CODEMP                                                                                                                                                 ');
    qryGenTmp.SQL.Add('UNION ALL                                                                                                                                                                     ');
    qryGenTmp.SQL.Add('SELECT IFNULL((SELECT CONCAT(S.SER_CDLSSE,"-",C.CDS_DESCRI) FROM CADSER S LEFT JOIN CADCDS C ON C.CDS_CDSERV = S.SER_CDLSSE WHERE S.SER_CODSER = N.GER_CODS03), "") AS CODSER ');
    qryGenTmp.SQL.Add('  FROM NOTGER N                                                                                                                                                               ');
    qryGenTmp.SQL.Add(' WHERE N.GER_NUMDOC = :NUMDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND N.GER_ESPDOC = :ESPDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND N.GER_CODEMP = :CODEMP                                                                                                                                                 ');
    qryGenTmp.SQL.Add('UNION ALL                                                                                                                                                                     ');
    qryGenTmp.SQL.Add('SELECT IFNULL((SELECT CONCAT(S.SER_CDLSSE,"-",C.CDS_DESCRI) FROM CADSER S LEFT JOIN CADCDS C ON C.CDS_CDSERV = S.SER_CDLSSE WHERE S.SER_CODSER = N.GER_CODS04), "") AS CODSER ');
    qryGenTmp.SQL.Add('  FROM NOTGER N                                                                                                                                                               ');
    qryGenTmp.SQL.Add(' WHERE N.GER_NUMDOC = :NUMDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND N.GER_ESPDOC = :ESPDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND N.GER_CODEMP = :CODEMP                                                                                                                                                 ');
    qryGenTmp.SQL.Add('UNION ALL                                                                                                                                                                     ');
    qryGenTmp.SQL.Add('SELECT IFNULL((SELECT CONCAT(S.SER_CDLSSE,"-",C.CDS_DESCRI) FROM CADSER S LEFT JOIN CADCDS C ON C.CDS_CDSERV = S.SER_CDLSSE WHERE S.SER_CODSER = N.GER_CODS05), "") AS CODSER ');
    qryGenTmp.SQL.Add('  FROM NOTGER N                                                                                                                                                               ');
    qryGenTmp.SQL.Add(' WHERE N.GER_NUMDOC = :NUMDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND N.GER_ESPDOC = :ESPDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND N.GER_CODEMP = :CODEMP                                                                                                                                                 ');
    qryGenTmp.SQL.Add('UNION ALL                                                                                                                                                                     ');
    qryGenTmp.SQL.Add('SELECT IFNULL((SELECT CONCAT(S.SER_CDLSSE,"-",C.CDS_DESCRI) FROM CADSER S LEFT JOIN CADCDS C ON C.CDS_CDSERV = S.SER_CDLSSE WHERE S.SER_CODSER = N.GER_CODS06), "") AS CODSER ');
    qryGenTmp.SQL.Add('  FROM NOTGER N                                                                                                                                                               ');
    qryGenTmp.SQL.Add(' WHERE N.GER_NUMDOC = :NUMDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND N.GER_ESPDOC = :ESPDOC                                                                                                                                                 ');
    qryGenTmp.SQL.Add('   AND N.GER_CODEMP = :CODEMP ) AS X WHERE X.CODSER <> "" ORDER BY CODSER                                                                                                     ');

    qryGenTmp.ParamByName('NUMDOC').AsString := strNumDoc;
    qryGenTmp.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGenTmp.ParamByName('CODEMP').AsString := strCodEmp;
    qryGenTmp.Open;

    if not qryGenTmp.isEmpty then
      strCodSer := qryGenTmp.FieldByName('CODSER').asString;

  finally
    qryGenTmp.Close;
    FreeAndNil(qryGenTmp);
  end;

end;


function TConexaoBD.CarregarPDF(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean): string;
var
  qryPDF : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LArquivoPDF: String;
  LConteudoPDF: TStringStream;
begin
  Result := EmptyStr;

  if not fTabelaExiste('PDFNFE') then
    Exit;

  qryPDF := fCriaQuery(nil);
  try
    qryPDF.Close;
    qryPDF.SQL.Clear;
    qryPDF.SQL.Add('SELECT * FROM PDFNFE WHERE NFE_ACESSO = :ACESSO');
    qryPDF.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryPDF.Open;
    qryPDF.First;

    if qryPDF.IsEmpty then
        raise Exception.Create('Nenhum registro foi encontrado na tabela PDFNFE para carregar o PDF.');

    if qryPDF.FieldByName('NFE_ARQPDF').IsNull then
        raise Exception.Create('O PDF está vazio.');

    LArquivoPDF := ANomeArquivo;

    If AExtensao Then
    begin
      pCriarDiretorioDanfeEnotasCasoNaoExista;
      LArquivoPDF := fDiretorioDanfeEnotas+LArquivoPDF+'.pdf';
    end;

    DeleteFile(PChar(LArquivoPDF));

    LConteudoPDF := TStringStream.Create(EmptyStr);

    Try
      TBlobField(qryPDF.FieldByName('NFE_ARQPDF')).SaveToStream(LConteudoPDF);
      pExportaPDF(LConteudoPDF.DataString, LArquivoPDF);
    Finally
      FreeAndNil(LConteudoPDF);
    End;

    Result := LArquivoPDF;
  finally
    qryPDF.free;
  end;
end;

function TConexaoBD.fBase64Codifica(ATexto: String): String;
var
  LEntrada:  TStringStream;
  LSaida: TStringStream;
begin
  LEntrada := TStringStream.Create(ATexto);
  LSaida   := TStringStream.Create(EmptyStr);

  Try
    EncdDecd.EncodeStream(LEntrada, LSaida);
    Result := LSaida.DataString;
  Finally
    FreeAndNil(LEntrada);
    FreeAndNil(LSaida);
  End;
end;

function TConexaoBD.fBase64Decodifica(ATexto: String): String;
var
  LEntrada:  TStringStream;
  LSaida: TStringStream;
begin
  LEntrada := TStringStream.Create(ATexto);
  LSaida   := TStringStream.Create(EmptyStr);

  Try
    EncdDecd.DecodeStream(LEntrada, LSaida);
    Result := LSaida.DataString;
  Finally
    FreeAndNil(LEntrada);
    FreeAndNil(LSaida);
  End;
end;

procedure TConexaoBD.pExportaPDF(ATexto: String; APath: String);
var
  LEntrada: TStringStream;
  LSaida: TFileStream;
  LTexto: String;
begin
  LTexto := fBase64Decodifica(ATexto);

  LSaida   := TFileStream.Create(APath, fmCreate);
  LEntrada := TStringStream.Create(LTexto);

  Try
    LSaida.CopyFrom(LEntrada, LEntrada.Size);
  Finally
    LSaida.Free;
    LEntrada.Free;
  End;
end;

procedure TConexaoBD.pSalvarDFePDF(ADanfe: TfrxReport; AChaveAcesso: String; ALayoutSimplificado: Boolean = False);
var
  LPDFExport: TfrxPDFExport;
  LStreamPDF: TStringStream;
begin
  pLogImp('pSalvarDFePDF > ' + AChaveAcesso);

  If fEmptyStr(AChaveAcesso) Then
  Begin
    pLogImp('pSalvarDFePDF < AChaveAcesso='' > Exit;');
    Exit;
  End;

  LPDFExport := TfrxPDFExport.Create(nil);

  {$IF Defined(UNIDAC)}
  LStreamPDF := TStringStream.Create();
  {$ELSE}
  LStreamPDF := TStringStream.Create('');
  {$IFEND}

  Try
    Try
      LPDFExport.Stream         := LStreamPDF;
      LPDFExport.ShowDialog     := False;
      LPDFExport.Background     := True;
      LPDFExport.EmbeddedFonts  := False;
      LPDFExport.Subject        := 'Exportando DANFE para PDF';
      LPDFExport.ShowProgress   := False;
      LPDFExport.PrintOptimized := ( CarregarCFGSIS('IOTPDF') = 'S' );
      ADanfe.ShowProgress       := False;

      ADanfe.PrintOptions.ShowDialog := False;
      If (ADanfe.PreviewPages.Count = 0) Then
        ADanfe.PrepareReport;

      pLogImp('Exportando DANFE para PDF >');
    {$IF Defined(LINUX)}
      LPDFExport.EmbeddedFonts := True;
    {$IFEND}
      ADanfe.Export(LPDFExport);
      pLogImp('Exportando DANFE para PDF <');

    {$IF Defined(LINUX)}
      If LStreamPDF.Size > 3 Then
    {$ELSE}
      If (Not fEmptyStr(LStreamPDF.DataString)) Then
    {$IFEND}
      Begin
        pSalvarPDFNFeBD(AChaveAcesso, LStreamPDF, ALayoutSimplificado);
      End;
    Finally
      FreeAndNil(LPDFExport);
      FreeAndNil(LStreamPDF);
    End;
  Except
    On E: Exception Do
    Begin
      pLogImp('Erro ao pSalvarDFePDF '+ E.Message);
    End;
  End;

  pLogImp('pSalvarDFePDF < ' );
end;

procedure TConexaoBD.pSalvarDFEBMP(ADanfe: TfrxReport; APath: String);
Var
  LExpBMP: TfrxBMPExport;
  strPathReal: String;
begin
  pLogImp('pSalvarDFEBMP > ' + APath);

  LExpBMP := TfrxBMPExport.Create(nil);
  Try
    LExpBMP.FileName     := APath;
    LExpBMP.ShowDialog   := False;
    LExpBMP.ShowProgress := False;
    // Resolucao: Zebra 8dpmm = 203dpi. FastReport default eh 96dpi.
    // Sem esse ajuste, pagina 100x72mm exporta como ~378x272 px, e o embed
    // ZPL com XGR ratio 1,1 ocupa metade da largura da etiqueta (etiqueta = 800 dots).
    // Com 203dpi o BMP sai ~800x576 px, preenchendo o espaco alvo (760x580 dots).
    // Conversao para 1bpp acontece no autcom (fEmbutirBitmap threshold interno).
    LExpBMP.Resolution   := 203;
    LExpBMP.Monochrome   := False;
    ADanfe.ShowProgress  := False;
    ADanfe.PrintOptions.ShowDialog := False;
    If (ADanfe.PreviewPages.Count = 0) Then
      ADanfe.PrepareReport;
    ADanfe.Export(LExpBMP);
  Finally
    FreeAndNil(LExpBMP);
  End;

  // TfrxBMPExport sufixa o nome com .N.bmp (N = numero da pagina), mesmo
  // em relatorios single-page. Renomeia pra o nome pedido pelo chamador
  // para preservar o contrato (chamador nao precisa saber do quirk do FR).
  strPathReal := ChangeFileExt(APath, '.1.bmp');
  If FileExists(strPathReal) And Not SameText(strPathReal, APath) Then
  Begin
    If FileExists(APath) Then
      SysUtils.DeleteFile(APath);
    RenameFile(strPathReal, APath);
  End;

  pLogImp('pSalvarDFEBMP < ' );
end;

procedure TConexaoBD.pSalvarPDFNFeBD(AChaveAcesso: string; APDFStream: TStringStream; ALayoutSimplificado: Boolean);
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strSQLLog,
    strPDF: string;
begin
  pLogImp('TConexaoBD.pSalvarPDFNFeBD >');

  If (Not fCampoExiste('PDFNFE', 'NFE_ACESSO')) Then
  Begin
    pLogImp('TConexaoBD.pSalvarPDFNFeBD < NÃO EXISTE PDFNFE-NFE_ACESSO');
    Exit;
  End;

  If (Not fCampoExiste('PDFNFE', 'NFE_ARQPDF')) Then
  Begin
    pLogImp('TConexaoBD.pSalvarPDFNFeBD < NÃO EXISTE PDFNFE-NFE_ARQPDF');
    Exit;
  End;

  If fEmptyStr(AChaveAcesso) Then
  Begin
    pLogImp('TConexaoBD.pSalvarPDFNFeBD < AChaveAcesso='' > Exit;');
    Exit;
  End;

  If fExistePdfNfe(AChaveAcesso) Then
  Begin
    pLogImp('TConexaoBD.pSalvarPDFNFeBD < PDFNFE JÁ SALVA');
    Exit;
  End;

  qryAux := fCriaQuery(Nil);
  Try
    Try
      pLogImp('fBase64Codifica(APDFStream.DataString) >');

     {$IF Defined(LINUX)}
      strPDF := StreamToBase64(APDFStream);
     {$ELSE}
      strPDF := fBase64Codifica(APDFStream.DataString);
     {$IFEND}

      pLogImp('fBase64Codifica(APDFStream.DataString) <');

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('INSERT INTO PDFNFE        ');
      qryAux.SQL.Add('   SET NFE_ARQPDF = :PDF, ');
      qryAux.SQL.Add('       NFE_ACESSO = :CHV ');

      If fCampoExiste('PDFNFE', 'NFE_NFESIM') Then
        qryAux.SQL.Add('    ,NFE_NFESIM = :SIM; ');

      qryAux.ParamByName('CHV').AsString := AChaveAcesso;
      qryAux.ParamByName('PDF').AsString := strPDF;

      If fCampoExiste('PDFNFE', 'NFE_NFESIM') Then
        qryAux.ParamByName('SIM').AsString := IIF(ALayoutSimplificado, 'S', 'N');

      pLogImp('<qryAux.ExecSQL;>');
      strSQLLog := qryAux.SQL.Text;
      pLogImp(Trim(strSQLLog));

      qryAux.ExecSQL;
      pLogImp('</qryAux.ExecSQL;>');
    Except
      On E: Exception Do
      Begin
        pLogImp(E.Message + ' [untConexaoBD.pSalvarPDFNFeBD]');
        Exception.Create(E.Message + ' [untConexaoBD.pSalvarPDFNFeBD]');
      End;
    End;
  Finally
    FreeAndNil(qryAux);
    pLogImp('TConexaoBD.pSalvarPDFNFeBD <');
  End;
End;

procedure TConexaoBD.pGetDadosSerObs(strNumDoc, strEspDoc, strCodEmp : String; out strSerObs : String);
var
  qryConsulta : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  strSerObs := EmptyStr;

  qryConsulta := fCriaQuery(nil, FDatabase);

  try

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT                             ');
    qryConsulta.SQL.Add('  S.GER_SEROBS AS SEROBS           ');
    qryConsulta.SQL.Add('FROM                               ');
    qryConsulta.SQL.Add('  SERMOV S                         ');
    qryConsulta.SQL.Add('  LEFT JOIN MOVGER G               ');
    qryConsulta.SQL.Add('    ON G.AUTOINCREM = S.GER_SEQGER ');
    qryConsulta.SQL.Add('WHERE G.GER_NUMDOC = :NUMDOC       ');
    qryConsulta.SQL.Add('  AND G.GER_ESPDOC = :ESPDOC       ');
    qryConsulta.SQL.Add('  AND G.GER_CODEMP = :CODEMP       ');
    qryConsulta.SQL.Add('UNION                              ');
    qryConsulta.SQL.Add('ALL                                ');
    qryConsulta.SQL.Add('SELECT                             ');
    qryConsulta.SQL.Add('  S.GER_SEROBS AS SEROBS           ');
    qryConsulta.SQL.Add('FROM                               ');
    qryConsulta.SQL.Add('  SERNOT S                         ');
    qryConsulta.SQL.Add('  LEFT JOIN NOTGER N               ');
    qryConsulta.SQL.Add('    ON N.AUTOINCREM = S.GER_SEQGER ');
    qryConsulta.SQL.Add('WHERE N.GER_NUMDOC = :NUMDOC       ');
    qryConsulta.SQL.Add('  AND N.GER_ESPDOC = :ESPDOC       ');
    qryConsulta.SQL.Add('  AND N.GER_CODEMP = :CODEMP       ');

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;

    qryConsulta.Open;

    strSerObs := AnsiReplaceStr(Trim(qryConsulta.FieldByName('SEROBS').AsString), '<<csq>>', #13#10);

  finally
    FreeAndNil(qryConsulta);
  end;

end;

procedure TConexaoBD.pGetDeducaoISSQN(strNumDoc, strEspDoc, strCodEmp : String; out fltVALDED : Double);
var
  qryConsulta : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  fltVALDED := 0;

  qryConsulta := fCriaQuery(nil, FDatabase);

  try

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT                             ');
    If fCampoExiste('AUXMOV', 'AUX_DEDISS') then
      qryConsulta.SQL.Add('  A.AUX_DEDISS AS DEDISS         ')
    else
      qryConsulta.SQL.Add('  0.00         AS DEDISS         ');
    qryConsulta.SQL.Add('FROM                               ');
    qryConsulta.SQL.Add('  MOVGER G                         ');
    qryConsulta.SQL.Add('  LEFT JOIN AUXMOV A               ');
    qryConsulta.SQL.Add('    ON A.AUX_SEQGER = G.AUTOINCREM ');
    qryConsulta.SQL.Add('WHERE G.GER_NUMDOC = :NUMDOC       ');
    qryConsulta.SQL.Add('  AND G.GER_ESPDOC = :ESPDOC       ');
    qryConsulta.SQL.Add('  AND G.GER_CODEMP = :CODEMP       ');

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;

    qryConsulta.Open;

    fltVALDED := qryConsulta.FieldByName('DEDISS').AsFloat;

  finally
    FreeAndNil(qryConsulta);
  end;

end;

procedure TConexaoBD.pLimpaCfg(ACodigoEmpresa, ACodigoCFG: string);
var
  qryLimpaCfg : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryLimpaCfg := fCriaQuery;
  try
    qryLimpaCfg.Close;
    qryLimpaCfg.SQL.Clear;
    qryLimpaCfg.SQL.Add(' UPDATE CFGSIS SET SIS_VALCFG = NULL ');
    qryLimpaCfg.SQL.Add('  WHERE SIS_CODEMP = :CODEMP         ');
    qryLimpaCfg.SQL.Add('    AND SIS_CODCFG = :CODCFG         ');
    qryLimpaCfg.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    qryLimpaCfg.ParamByName('CODCFG').AsString := 'CFG_' + ACodigoCFG;
    qryLimpaCfg.ExecSQL;

    {$IF Defined(UNIDAC)}
    pInsereDicSis(qryLimpaCfg.Connection, fFormataKeyValCfgParaDicSis(ACodigoCFG, ACodigoEmpresa), ''); //APENAS ATUALIZA A DICSIS
    {$IFEND}
  finally
    FreeAndNil(qryLimpaCfg);
  end;
end;

procedure TConexaoBD.pGetDiscriminacaoServico(strNumDoc, strEspDoc, strCodEmp,
  strTip_FC: String);
var
  qryConsulta : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  qryConsulta := fCriaQuery(nil, FDatabase);
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    Try
      qryConsulta.SQL.Add('SELECT                                             ');
      qryConsulta.SQL.Add('  OB.MOV_OBSERV AS MOVOBS,                         ');
      qryConsulta.SQL.Add('  OB.MOV_DISSER AS DISSER                          ');
      If fCampoExiste('SERMOV', 'GER_MUNPRE') then
        qryConsulta.SQL.Add(',S.GER_MUNPRE AS MUNPRE                          ')
      Else
        qryConsulta.SQL.Add(',CAST("" AS CHAR(1)) AS MUNPRE                   ');
      qryConsulta.SQL.Add(',CONCAT(CC.CID_NOMCID,"-",CC.CID_ESTADO) AS SERMUN ');
      qryConsulta.SQL.Add('FROM                                               ');
      qryConsulta.SQL.Add('  MOVGER MG                                        ');
      qryConsulta.SQL.Add('  LEFT JOIN AUXMOV AM                              ');
      qryConsulta.SQL.Add('    ON AM.AUX_SEQGER = MG.AUTOINCREM               ');
      qryConsulta.SQL.Add('  LEFT JOIN ENTCLI EC                              ');
      qryConsulta.SQL.Add('    ON EC.AUTOINCREM = AM.AUX_ENTGER               ');
      qryConsulta.SQL.Add('  LEFT JOIN CADCID CC                              ');
      qryConsulta.SQL.Add('    ON CC.CID_CODCID = EC.ETC_CIDENT               ');
      qryConsulta.SQL.Add('  LEFT JOIN MOVOBS OB                              ');
      qryConsulta.SQL.Add('    ON OB.MOV_SEQGER = MG.AUTOINCREM               ');
      qryConsulta.SQL.Add('  LEFT JOIN SERMOV S                               ');
      qryConsulta.SQL.Add('    ON S.GER_SEQGER = MG.AUTOINCREM                ');
      qryConsulta.SQL.Add('WHERE MG.GER_NUMDOC = :NUMDOC                      ');
      qryConsulta.SQL.Add('  AND MG.GER_ESPDOC = :ESPDOC                      ');
      qryConsulta.SQL.Add('  AND MG.GER_CODEMP = :CODEMP                      ');
      qryConsulta.SQL.Add('  AND MG.GER_TIP_FC = :TIP_FC                      ');
      qryConsulta.SQL.Add('  AND MG.GER_ORIDOC = "V"                          ');
      qryConsulta.SQL.Add('UNION ALL                                          ');
      qryConsulta.SQL.Add('SELECT                                             ');
      qryConsulta.SQL.Add('  OB.MOV_OBSERV AS MOVOBS,                         ');
      qryConsulta.SQL.Add('  OB.MOV_DISSER AS DISSER                          ');
      If fCampoExiste('SERNOT', 'GER_MUNPRE') then
        qryConsulta.SQL.Add(',S.GER_MUNPRE AS MUNPRE                          ')
      Else
        qryConsulta.SQL.Add(',CAST("" AS CHAR(1)) AS MUNPRE                   ');
      qryConsulta.SQL.Add(',CONCAT(CC.CID_NOMCID,"-",CC.CID_ESTADO) AS SERMUN ');
      qryConsulta.SQL.Add('FROM                                               ');
      qryConsulta.SQL.Add('  NOTGER NG                                        ');
      qryConsulta.SQL.Add('  LEFT JOIN AUXNOT AN                              ');
      qryConsulta.SQL.Add('    ON AN.AUX_SEQGER = NG.AUTOINCREM               ');
      qryConsulta.SQL.Add('  LEFT JOIN ENTCLI EC                              ');
      qryConsulta.SQL.Add('    ON EC.AUTOINCREM = AN.AUX_ENTGER               ');
      qryConsulta.SQL.Add('  LEFT JOIN CADCID CC                              ');
      qryConsulta.SQL.Add('    ON CC.CID_CODCID = EC.ETC_CIDENT               ');
      qryConsulta.SQL.Add('  LEFT JOIN NOTOBS OB                              ');
      qryConsulta.SQL.Add('    ON OB.MOV_SEQGER = NG.AUTOINCREM               ');
      qryConsulta.SQL.Add('  LEFT JOIN SERNOT S                               ');
      qryConsulta.SQL.Add('    ON S.GER_SEQGER = NG.AUTOINCREM                ');
      qryConsulta.SQL.Add('WHERE NG.GER_NUMDOC = :NUMDOC                      ');
      qryConsulta.SQL.Add('  AND NG.GER_ESPDOC = :ESPDOC                      ');
      qryConsulta.SQL.Add('  AND NG.GER_CODEMP = :CODEMP                      ');
      qryConsulta.SQL.Add('  AND NG.GER_TIP_FC = :TIP_FC                      ');
      qryConsulta.SQL.Add('  AND NG.GER_ORIDOC = "V"                          ');

      qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
      qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
      qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;
      qryConsulta.ParamByName('TIP_FC').AsString := strTip_FC;
      qryConsulta.Open;
    Except On e: Exception Do
      raise Exception.Create('Erro ao retornar descriminação de serviço da base de dados! Erro: '+ e.Message);
    End;

    FInfosNfsBd.strMovObs := Trim(qryConsulta.FieldByName('MOVOBS').AsString);
    FInfosNfsBd.strDiscriminacaoServico := Trim(qryConsulta.FieldByName('DISSER').AsString);
    FInfosNfsBd.strMunPre := Trim(qryConsulta.FieldByName('MUNPRE').AsString);
    FInfosNfsBd.strSerMun := Trim(qryConsulta.FieldByName('SERMUN').AsString);

  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TConexaoBD.pPreencheCdsFaturas(var cdsFaturas: TUniClientDataSet);
var
  qryDuplicata: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryDuplicata := fCriaQuery;
  Try
    if Assigned(cdsFaturas) then
    Begin
      qryDuplicata.Close;
      qryDuplicata.SQL.Clear;
      qryDuplicata.SQL.Add('SET @SEQDET := 0; ');
      qryDuplicata.SQL.Add('');
      qryDuplicata.SQL.Add('SELECT CTR_DTAVEN, ');
      qryDuplicata.SQL.Add('       IF(CTR_VALDUP = 0, CTR_VALORI, CTR_VALDUP) AS VALDUP, ');
      qryDuplicata.SQL.Add('       @SEQDET := IFNULL(@SEQDET,0) + 1 AS SEQDET ');
      qryDuplicata.SQL.Add('FROM CADREC ');
      qryDuplicata.SQL.Add('WHERE CTR_NUMDUP = :NUMDOC ');
      qryDuplicata.SQL.Add('  AND CTR_CODEMP = :CODEMP ');
      qryDuplicata.SQL.Add('  AND CTR_ESPDOC = :ESPDOC ');
      qryDuplicata.SQL.Add('ORDER BY CTR_DTAVEN ');

      qryDuplicata.ParamByName('NUMDOC').AsString := FInfosNfsBd.strNumDoc;
      qryDuplicata.ParamByName('CODEMP').AsString := FInfosNfsBd.strCodEmp;
      qryDuplicata.ParamByName('ESPDOC').AsString := FInfosNfsBd.strEspDoc;

      qryDuplicata.Open;

      qryDuplicata.First;
      while not qryDuplicata.Eof do
      Begin
        cdsFaturas.Append;
        cdsFaturas.FieldByName('FATNUM').AsString := qryDuplicata.FieldByName('SEQDET').asString;
        cdsFaturas.FieldByName('DTAVEN').AsString := qryDuplicata.FieldByName('CTR_DTAVEN').asString;
        cdsFaturas.FieldByName('VALFAT').AsFloat  := qryDuplicata.FieldByName('VALDUP').asFloat;
        cdsFaturas.Post;

        qryDuplicata.Next;
      End;
    End;
  Finally
    FreeAndNil(qryDuplicata);
  End;
end;

procedure TConexaoBD.pRetornarPedidoDeCompra(strNumDoc, strEspDoc, strCodEmp: String);
var
  qryPedidoDeCompra: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  FInfosNfsBd.strPedidoDeCompra := EmptyStr;
  qryPedidoDeCompra := fCriaQuery;
  Try

      qryPedidoDeCompra.Close;
      qryPedidoDeCompra.SQL.Clear;

      qryPedidoDeCompra.SQL.Add(' SELECT ');
      qryPedidoDeCompra.SQL.Add('   NULLIF( ');
      qryPedidoDeCompra.SQL.Add('     CONCAT_WS(", ", ');
      qryPedidoDeCompra.SQL.Add('       NULLIF(GROUP_CONCAT(DISTINCT NC.CMP_NUMCMP  ORDER BY NC.CMP_NUMCMP  SEPARATOR ", "), ""), ');
      qryPedidoDeCompra.SQL.Add('       NULLIF(GROUP_CONCAT(DISTINCT ED.FDO_NUMCMP  ORDER BY ED.FDO_NUMCMP  SEPARATOR ", "), ""), ');
      if fCampoExiste('CONEQL', 'EQL_PEDCOM') then
        qryPedidoDeCompra.SQL.Add('       NULLIF(GROUP_CONCAT(DISTINCT CQ.EQL_PEDCOM  ORDER BY CQ.EQL_PEDCOM  SEPARATOR ", "), "")  ')
      else
        qryPedidoDeCompra.SQL.Add('       NULLIF("", "") ');
      qryPedidoDeCompra.SQL.Add('     ), "" ');
      qryPedidoDeCompra.SQL.Add('   ) AS NUMCMP ');
      qryPedidoDeCompra.SQL.Add(' FROM MOVDET MD ');
      qryPedidoDeCompra.SQL.Add(' /* Origem 1: FATGOR = NUMCMP */ ');
      qryPedidoDeCompra.SQL.Add(' LEFT JOIN FATGOR FG ');
      qryPedidoDeCompra.SQL.Add('        ON FG.FGO_NUMDOC = MD.DET_NUM_PD ');
      qryPedidoDeCompra.SQL.Add('       AND FG.FGO_ESPDOC = MD.DET_ESP_PD ');
      qryPedidoDeCompra.SQL.Add('       AND FG.FGO_CODEMP = MD.DET_EMP_PD ');
      qryPedidoDeCompra.SQL.Add(' LEFT JOIN NUMCMP NC ');
      qryPedidoDeCompra.SQL.Add('        ON NC.CMP_SEQGER = FG.AUTOINCREM ');
      qryPedidoDeCompra.SQL.Add('       AND IFNULL(NC.CMP_NUMCMP, "") <> "" ');
      qryPedidoDeCompra.SQL.Add(' /* Origem 2: FATGOR = FATDOR = EXTDOR */ ');
      qryPedidoDeCompra.SQL.Add(' LEFT JOIN FATDOR FD ');
      qryPedidoDeCompra.SQL.Add('        ON FD.FDO_SEQGER = FG.AUTOINCREM ');
      qryPedidoDeCompra.SQL.Add(' LEFT JOIN EXTDOR ED ');
      qryPedidoDeCompra.SQL.Add('        ON ED.FDO_SEQFDO = FD.AUTOINCREM ');
      qryPedidoDeCompra.SQL.Add('       AND IFNULL(ED.FDO_NUMCMP, "") <> "" ');
      qryPedidoDeCompra.SQL.Add(' /* Origem 3: EQLFAT = CONEQL (chave pelo documento, não pelo FATGOR) */ ');
      qryPedidoDeCompra.SQL.Add(' LEFT JOIN EQLFAT EF ');
      qryPedidoDeCompra.SQL.Add('        ON EF.EQF_NUMDOC = MD.DET_NUMDOC ');
      qryPedidoDeCompra.SQL.Add('       AND EF.EQF_ESPDOC = MD.DET_ESPDOC ');
      qryPedidoDeCompra.SQL.Add('       AND EF.EQF_EMPDOC = MD.DET_CODEMP ');
      if fCampoExiste('CONEQL', 'EQL_PEDCOM') then
      begin
        qryPedidoDeCompra.SQL.Add(' LEFT JOIN CONEQL CQ ');
        qryPedidoDeCompra.SQL.Add('        ON CQ.AUTOINCREM = EF.EQF_SEQCON ');
        qryPedidoDeCompra.SQL.Add('       AND IFNULL(CQ.EQL_PEDCOM, "") <> "" ');
      end;
      qryPedidoDeCompra.SQL.Add(' WHERE MD.DET_CODEMP = :CODEMP ');
      qryPedidoDeCompra.SQL.Add('   AND MD.DET_ESPDOC = :ESPDOC ');
      qryPedidoDeCompra.SQL.Add('   AND MD.DET_NUMDOC = :NUMDOC ');
      qryPedidoDeCompra.SQL.Add(' GROUP BY MD.DET_NUMDOC, MD.DET_ESPDOC, MD.DET_CODEMP ');

      qryPedidoDeCompra.ParamByName('NUMDOC').AsString := strNumDoc;
      qryPedidoDeCompra.ParamByName('CODEMP').AsString := strCodEmp;
      qryPedidoDeCompra.ParamByName('ESPDOC').AsString := strEspDoc;

      qryPedidoDeCompra.Open;

      FInfosNfsBd.strPedidoDeCompra := Trim(qryPedidoDeCompra.FieldByName('NUMCMP').AsString);

  Finally
    FreeAndNil(qryPedidoDeCompra);
  End;
end;

procedure TConexaoBD.pRetornarObservacaoContratoLocacao(strNumDoc, strEspDoc, strCodEmp: String);
var
  qryObservacaoContratoLocacao: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  FInfosNfsBd.strObservContratoLocacao := EmptyStr;
  FInfosNfsBd.strInicioContratoLocacao := EmptyStr;
  FInfosNfsBd.strFimContratoLocacao := EmptyStr;
  FInfosNfsBd.strNumeroContratoLocacao := EmptyStr;

  qryObservacaoContratoLocacao := fCriaQuery;
  Try

      qryObservacaoContratoLocacao.Close;
      qryObservacaoContratoLocacao.SQL.Clear;

      qryObservacaoContratoLocacao.SQL.Add('SELECT DISTINCT                              ');
      qryObservacaoContratoLocacao.SQL.Add('  IFNULL(CONEQL.EQL_OBSERV, "") AS OBSERV,   ');
      qryObservacaoContratoLocacao.SQL.Add('  CONEQL.EQL_NROCON AS NROCON,               ');
      qryObservacaoContratoLocacao.SQL.Add('  CONEQL.EQL_DTAFIN AS DTAFIN,               ');
      qryObservacaoContratoLocacao.SQL.Add('  CONEQL.EQL_HORFIN AS HORFIN,               ');
      qryObservacaoContratoLocacao.SQL.Add('  CONEQL.EQL_DTAINI AS DTAINI,               ');
      qryObservacaoContratoLocacao.SQL.Add('  CONEQL.EQL_HORINI AS HORINI                ');
      qryObservacaoContratoLocacao.SQL.Add('FROM                                         ');
      qryObservacaoContratoLocacao.SQL.Add('  CONEQL                                     ');
      qryObservacaoContratoLocacao.SQL.Add('  JOIN EQLFAT                                ');
      qryObservacaoContratoLocacao.SQL.Add('    ON EQLFAT.EQF_SEQCON = CONEQL.AUTOINCREM ');
      qryObservacaoContratoLocacao.SQL.Add('WHERE EQF_NUMDOC = :NUMDOC                   ');
      qryObservacaoContratoLocacao.SQL.Add('  AND EQF_EMPDOC = :CODEMP                   ');
      qryObservacaoContratoLocacao.SQL.Add('  AND EQF_ESPDOC = :ESPDOC                   ');

      qryObservacaoContratoLocacao.ParamByName('NUMDOC').AsString := strNumDoc;
      qryObservacaoContratoLocacao.ParamByName('CODEMP').AsString := strCodEmp;
      qryObservacaoContratoLocacao.ParamByName('ESPDOC').AsString := strEspDoc;

      qryObservacaoContratoLocacao.Open;
      
      if not qryObservacaoContratoLocacao.isEmpty then
      begin
        FInfosNfsBd.strObservContratoLocacao := AnsiReplaceStr(Trim(qryObservacaoContratoLocacao.FieldByName('OBSERV').AsString), '<<csq>>', #13#10);
        FInfosNfsBd.strInicioContratoLocacao := qryObservacaoContratoLocacao.FieldByName('DTAINI').AsString+'-'+qryObservacaoContratoLocacao.FieldByName('HORINI').AsString;
        FInfosNfsBd.strFimContratoLocacao    := qryObservacaoContratoLocacao.FieldByName('DTAFIN').AsString+'-'+qryObservacaoContratoLocacao.FieldByName('HORFIN').AsString;
        FInfosNfsBd.strNumeroContratoLocacao := qryObservacaoContratoLocacao.FieldByName('NROCON').AsString;
      end;

  Finally
    FreeAndNil(qryObservacaoContratoLocacao);
  End;
end;

procedure TConexaoBD.pRetornarItensContratoLocacao(var cdsItens: TUniClientDataSet; strNumDoc, strEspDoc, strCodEmp: String);
var
  qryItensContratoLocacao: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryItensContratoLocacao := fCriaQuery;
  Try
    if Assigned(cdsItens) then
    Begin
      qryItensContratoLocacao.Close;
      qryItensContratoLocacao.SQL.Clear;
      qryItensContratoLocacao.SQL.Add('SELECT                                         ');
      qryItensContratoLocacao.SQL.Add('  F.EQF_QTDEQU,                                ');
      qryItensContratoLocacao.SQL.Add('  E.EQL_DESCRI,                                ');
      qryItensContratoLocacao.SQL.Add('  (F.EQF_VALFAT / F.EQF_QTDEQU) AS EQF_VALUNI, ');
      qryItensContratoLocacao.SQL.Add('  F.EQF_VALFAT                                 ');
      qryItensContratoLocacao.SQL.Add('FROM                                           ');
      qryItensContratoLocacao.SQL.Add('  CONEQL C                                     ');
      qryItensContratoLocacao.SQL.Add('  JOIN EQLFAT F                                ');
      qryItensContratoLocacao.SQL.Add('    ON C.AUTOINCREM = F.EQF_SEQCON             ');
      qryItensContratoLocacao.SQL.Add('  JOIN CADEQL E                                ');
      qryItensContratoLocacao.SQL.Add('    ON F.EQF_SEQEQL = E.EQL_CODIGO             ');
      qryItensContratoLocacao.SQL.Add('WHERE TRUE                                     ');
      qryItensContratoLocacao.SQL.Add('  AND F.EQF_NUMDOC = :NUMDOC                   ');
      qryItensContratoLocacao.SQL.Add('  AND F.EQF_ESPDOC = :ESPDOC                   ');
      qryItensContratoLocacao.SQL.Add('  AND F.EQF_EMPDOC = :CODEMP                   ');

      qryItensContratoLocacao.ParamByName('NUMDOC').AsString := strNumDoc;
      qryItensContratoLocacao.ParamByName('CODEMP').AsString := strCodEmp;
      qryItensContratoLocacao.ParamByName('ESPDOC').AsString := strEspDoc;

      qryItensContratoLocacao.Open;

      qryItensContratoLocacao.First;
      while not qryItensContratoLocacao.Eof do
      Begin
        cdsItens.Append;
        cdsItens.FieldByName('NUMNFS').AsString := strNumDoc;
        cdsItens.FieldByName('ITEDES').AsString := qryItensContratoLocacao.FieldByName('EQL_DESCRI').asString;
        cdsItens.FieldByName('ITEQTD').AsFloat  := qryItensContratoLocacao.FieldByName('EQF_QTDEQU').asFloat;
        cdsItens.FieldByName('VLRUNT').AsFloat  := qryItensContratoLocacao.FieldByName('EQF_VALUNI').asFloat;
        cdsItens.FieldByName('VLRTOT').AsFloat  := qryItensContratoLocacao.FieldByName('EQF_VALFAT').asFloat;
        cdsItens.Post;

        qryItensContratoLocacao.Next;
      End;
    End;
  Finally
    FreeAndNil(qryItensContratoLocacao);
  End;
end;

function TConexaoBD.fMontaCarteira(strNumDoc, strEspDoc, strCodEmp: string): string;
var
  qryDuplicata: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := '';
  qryDuplicata := fCriaQuery;
  Try

    qryDuplicata.Close;
    qryDuplicata.SQL.Clear;
    qryDuplicata.SQL.Add('SELECT CTR_DTAVEN, ');
    qryDuplicata.SQL.Add('       IF(CTR_VALDUP = 0, CTR_VALORI, CTR_VALDUP) AS VALDUP ');
    qryDuplicata.SQL.Add('FROM CADREC ');
    qryDuplicata.SQL.Add('WHERE CTR_NUMDUP = :NUMDOC ');
    qryDuplicata.SQL.Add('  AND CTR_CODEMP = :CODEMP ');
    qryDuplicata.SQL.Add('  AND CTR_ESPDOC = :ESPDOC ');
    qryDuplicata.SQL.Add('ORDER BY CTR_DTAVEN ');

    qryDuplicata.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDuplicata.ParamByName('CODEMP').AsString := strCodEmp;
    qryDuplicata.ParamByName('ESPDOC').AsString := strEspDoc;

    qryDuplicata.Open;

    qryDuplicata.First;
    while not qryDuplicata.Eof do
    Begin
      Result := Result + qryDuplicata.FieldByName('CTR_DTAVEN').asString + '  ' + qryDuplicata.FieldByName('VALDUP').asString + ' | ';
      qryDuplicata.Next;
    End;

  Finally
    FreeAndNil(qryDuplicata);
  End;
end;

{ TImpressaoNfs }

constructor TImpressaoNfs.Create(var AConexaoBD: TConexaoBD);
  Var
    LStreamDanfe: TStringStream;
begin
  frxDanfe     := TfrxReport.Create(nil);
  frxDbDanfe   := TfrxDBDataset.Create(nil);
  frxDbItens   := TfrxDBDataset.Create(nil);
  frxDbFaturas := TfrxDBDataset.Create(nil);
  frxPDFExport := TfrxPDFExport.Create(nil);
  objConexaoBD := AConexaoBD;

  Try
    LStreamDanfe := fStringToStreamDanfe(objConexaoBD.FConfiguracao.LayoutRetrato);
    frxDanfe.LoadFromStream(LStreamDanfe);
    LStreamDanfe.Free;
  Except On e: Exception Do
    Raise Exception.Create('Erro ao carregar Layout NFSE. Erro: ' + e.Message);
  End;
end;

destructor TImpressaoNfs.Destroy;
var
  i: Integer;
begin
  FreeAndNil(frxDanfe);
  if FDatasetsDinProprios then
  begin
    for i := 0 to High(arrFrxDb) do
      if arrFrxDb[i] <> nil then
        FreeAndNil(arrFrxDb[i]);
    for i := 0 to High(arrCdsNfs) do
      if arrCdsNfs[i] <> nil then
        FreeAndNil(arrCdsNfs[i]);
  end;
  FreeAndNil(frxDbDanfe);
  FreeAndNil(frxDbFaturas);
  FreeAndNil(frxPDFExport);
  inherited;
end;

procedure TImpressaoNfs.pAddArrCdsNfs(arr: TUniClientDataSet);
begin
  SetLength(Self.arrCdsNfs, Length(Self.arrCdsNfs) + 1);
  Self.arrCdsNfs[Length(Self.arrCdsNfs)-1] := arr;
end;

procedure TImpressaoNfs.pCarregaVariaveisPadrao;
var
  LAnoComp,
  LMesComp: string;
  dtDataVenIss : TDate;
  strFaturas: string;
begin
  If frxDbDanfe.DataSet.IsEmpty Then
    Exit;

  LAnoComp := Copy(arrCdsNfs[0].FieldByName('COMPET').asString,1,4);
  LMesComp := Copy(arrCdsNfs[0].FieldByName('COMPET').asString,6,2);

  frxDanfe.Script.Variables['ANOCPT']   := LAnoComp + StringOfChar('0', 8 - Length(LAnoComp));

  //Identificação NFS-e
  frxDanfe.Script.Variables['NUMNFS']   := arrCdsNfs[0].FieldByName('NUMNFS').AsString;
  frxDanfe.Script.Variables['CODVER']   := arrCdsNfs[0].FieldByName('CODVER').AsString;
  frxDanfe.Script.Variables['SERNFS']   := arrCdsNfs[0].FieldByName('SERIE').AsString;
  frxDanfe.Script.Variables['COMPET']   := arrCdsNfs[0].FieldByName('COMPET').AsString;
  frxDanfe.Script.Variables['DTAHRA']   := arrCdsNfs[0].FieldByName('DTAHRA').AsString;
  frxDanfe.Script.Variables['DTAEMI']   := arrCdsNfs[0].FieldByName('DTAEMI').AsString;
  frxDanfe.Script.Variables['MES_COMPETENCIA'] := LMesComp+'/'+LAnoComp;
  frxDanfe.Script.Variables['MES_COMPETENCIA_XML'] := Copy(arrCdsNfs[0].FieldByName('COMPET').asString,4,7);

  //Identificação RPS
  frxDanfe.Script.Variables['SERRPS']   := arrCdsNfs[0].FieldByName('SERRPS').AsString;
  frxDanfe.Script.Variables['NUMRPS']   := arrCdsNfs[0].FieldByName('NUMRPS').AsString;
  frxDanfe.Script.Variables['DTARPS']   := arrCdsNfs[0].FieldByName('EMIRPS').AsString;

  // Tradução de XML - Informações de tributação
  frxDanfe.Script.Variables['PSOSN']       := TTraducaoXml.fEhOptanteSimplesNacionalPortalNacional(arrCdsNfs[0].FieldByName('PSVOSN').AsString);
  frxDanfe.Script.Variables['REGAPTRIBSN'] := TTraducaoXml.fValidaRegimeApTribSNPortalNacional(arrCdsNfs[0].FieldByName('PSVREG').AsString);
  frxDanfe.Script.Variables['REGESPTRIB']  := TTraducaoXml.fValidaRegimeEspTriPortalNacional(arrCdsNfs[0].FieldByName('PSVESP').AsString);
  frxDanfe.Script.Variables['REGESPTRIBABRASF'] := TTraducaoXml.fValidaRegimeEspTriABRASF(arrCdsNfs[0].FieldByName('RESPTRIB').AsString);
  frxDanfe.Script.Variables['ISSRETIDO']   := TTraducaoXml.fValidaISSRetidoPortalNacional(arrCdsNfs[0].FieldByName('ISSRETIDO').AsString);
  frxDanfe.Script.Variables['RETPISCOFINS']:= TTraducaoXml.fDescricaoRetPisCofinsPortalNacional(arrCdsNfs[0].FieldByName('RETPISCOFINS').AsString);
  frxDanfe.Script.Variables['OPCSN']      := TTraducaoXml.fEhOptanteSimplesNacional(arrCdsNfs[0].FieldByName('EMIOSN').AsString);
  frxDanfe.Script.Variables['EMIOSN']     := TTraducaoXml.fEhOptanteSimplesNacional(arrCdsNfs[0].FieldByName('EMIOSN').AsString);
  frxDanfe.Script.Variables['RESPTRIB']   := TTraducaoXml.fValidaRegimeEspTri(arrCdsNfs[0].FieldByName('RESPTRIB').AsString);
  frxDanfe.Script.Variables['REGESPTRIB'] := TTraducaoXml.fValidaRegimeEspTri(arrCdsNfs[0].FieldByName('CODRET').AsString);
  frxDanfe.Script.Variables['EMIICC']     := TTraducaoXml.fTemIncentivoFiscal(arrCdsNfs[0].FieldByName('EMIICC').AsString);
  frxDanfe.Script.Variables['EXIISS']     := TTraducaoXml.fExigivelIss(arrCdsNfs[0].FieldByName('EXIISS').AsString);
  frxDanfe.Script.Variables['ISS_RET']    := TTraducaoXml.fEhIssRetido(arrCdsNfs[0].FieldByName('ISS_RET').AsString);
  frxDanfe.Script.Variables['NATOPE']     := TTraducaoXml.fRetNatOpe(arrCdsNfs[0].FieldByName('NATOPE').AsString);
  frxDanfe.Script.Variables['NATOPE_XML'] := arrCdsNfs[0].FieldByName('NATOPE_XML').AsString;
  frxDanfe.Script.Variables['CDISSQN']    := TTraducaoXml.fEhTributacaoISSQN(arrCdsNfs[0].FieldByName('CDISSQN').AsString);
  frxDanfe.Script.Variables['REGESP']     := TTraducaoXml.fRegimeEspecialTributacao(arrCdsNfs[0].FieldByName('REGESP').AsString);
  // Variaveis de Prestador
  frxDanfe.Script.Variables['NOMPRE'] := IfEmptyStr(arrCdsNfs[0].FieldByName('PSVRAZAO').AsString, objConexaoBD.FInfosNfsBd.strRazSoc);
  frxDanfe.Script.Variables['NOMFAN'] := arrCdsNfs[0].FieldByName('PSVFANT').AsString;
  frxDanfe.Script.Variables['DOCPRE'] := fFormataCpfCgc(IfEmptyStr(arrCdsNfs[0].FieldByName('PSVCNPJ').AsString, objConexaoBD.FInfosNfsBd.strCNPJ));
  frxDanfe.Script.Variables['MUNINC'] := IfEmptyStr(arrCdsNfs[0].FieldByName('MUNINC').AsString, objConexaoBD.FInfosNfsBd.strCidad+'/'+objConexaoBD.FInfosNfsBd.strUF);
  frxDanfe.Script.Variables['CNPJPRE_XML'] := arrCdsNfs[0].FieldByName('PSVCNPJ').AsString;
  frxDanfe.Script.Variables['IEPRES'] := objConexaoBD.FInfosNfsBd.strInsEst;
  frxDanfe.Script.Variables['IMPRES']   := IfEmptyStr(arrCdsNfs[0].FieldByName('PSVIM').AsString ,   objConexaoBD.FInfosNfsBd.strIM);
  frxDanfe.Script.Variables['ENDPRE']   := IfEmptyStr(arrCdsNfs[0].FieldByName('PSVEND').AsString,   objConexaoBD.FInfosNfsBd.strEnder);
  frxDanfe.Script.Variables['NUENPR']   := IfEmptyStr(arrCdsNfs[0].FieldByName('PSVNUM').AsString,   objConexaoBD.FInfosNfsBd.strNume);
  frxDanfe.Script.Variables['BAIPRE']   := arrCdsNfs[0].FieldByName('PSVBAIR').AsString;
  frxDanfe.Script.Variables['CIDPRE']   := IfEmptyStr(arrCdsNfs[0].FieldByName('PSVMUN').AsString,   objConexaoBD.FInfosNfsBd.strCidad);
  frxDanfe.Script.Variables['UFPRES']   := IfEmptyStr(arrCdsNfs[0].FieldByName('PSVUF').AsString ,   objConexaoBD.FInfosNfsBd.strUF);
  frxDanfe.Script.Variables['PSVMUN']   := objConexaoBD.FInfosNfsBd.strCidad;
  frxDanfe.Script.Variables['CEPPRE']   := fFormataCEP(IfEmptyStr(arrCdsNfs[0].FieldByName('PSVCEP').AsString, objConexaoBD.FInfosNfsBd.strCEP));
  frxDanfe.Script.Variables['COMPRE']   := IfEmptyStr(arrCdsNfs[0].FieldByName('PSVCOMPL').AsString, objConexaoBD.FInfosNfsBd.strCompl);
  frxDanfe.Script.Variables['EMAPRE']   := IfEmptyStr(arrCdsNfs[0].FieldByName('PSVEMAIL').AsString, objConexaoBD.FInfosNfsBd.strEmail);
  frxDanfe.Script.Variables['FONPRE']   := fFormataFone(IfEmptyStr(arrCdsNfs[0].FieldByName('PSVFONE').AsString, objConexaoBD.FInfosNfsBd.strFone));
  frxDanfe.Script.Variables['PSVEMAIL'] := objConexaoBD.FInfosNfsBd.strEmail;

  // Variaveis de Tomador
  frxDanfe.Script.Variables['TOMRAZ']     := arrCdsNfs[0].FieldByName('TMSRAZAO').AsString;
  frxDanfe.Script.Variables['DOCDES']     := fFormataCpfCgc(arrCdsNfs[0].FieldByName('TMSCNPJ').AsString);
  frxDanfe.Script.Variables['ENDDES']     := arrCdsNfs[0].FieldByName('TMSEND').AsString;
  frxDanfe.Script.Variables['NUENDE']     := arrCdsNfs[0].FieldByName('TMSNUM').AsString;
  frxDanfe.Script.Variables['BAIDES']     := arrCdsNfs[0].FieldByName('TMSBAIR').AsString;
  frxDanfe.Script.Variables['CIDDES']     := IfEmptyStr(arrCdsNfs[0].FieldByName('TMSMUN').AsString, objConexaoBD.FInfosNfsBd.strTomadorCidade);
  frxDanfe.Script.Variables['UFDEST']     := IfEmptyStr(fCampoTabela('CID_ESTADO', 'CADCID', ['CID_COIBGE'], [arrCdsNfs[0].FieldByName('TMSMUN').AsString]), objConexaoBD.FInfosNfsBd.strTomadorUF);
  frxDanfe.Script.Variables['CEPDES']     := fFormataCEP(arrCdsNfs[0].FieldByName('TMSCEP').AsString);
  frxDanfe.Script.Variables['COMPDE']     := IfEmptyStr(arrCdsNfs[0].FieldByName('TMSCOMPL').AsString, objConexaoBD.FInfosNfsBd.strTomadorComplEnder);
  frxDanfe.Script.Variables['FONDES']     := fFormataFone(IfEmptyStr(arrCdsNfs[0].FieldByName('TMSFONE').AsString, objConexaoBD.FInfosNfsBd.strTomadorFone01));
  frxDanfe.Script.Variables['MUNTOM']     := IfEmptyStr(fCampoTabela('CID_NOMCID', 'CADCID', ['CID_COIBGE'], [arrCdsNfs[0].FieldByName('TMSMUN').AsString]), objConexaoBD.FInfosNfsBd.strTomadorCidade);
  frxDanfe.Script.Variables['TMSIM']      := objConexaoBD.FInfosNfsBd.strTomadorIM;
  frxDanfe.Script.Variables['TMSIM_XML']  := arrCdsNfs[0].FieldByName('TMSIM').AsString;
  frxDanfe.Script.Variables['TMSIE']      := objConexaoBD.FInfosNfsBd.strTomadorI_E_S_;
  frxDanfe.Script.Variables['EMADES']     := IfEmptyStr(arrCdsNfs[0].FieldByName('TMSEMAIL').AsString, objConexaoBD.FInfosNfsBd.strTomadorEmail_);
  frxDanfe.Script.Variables['TMSEMAIL']   := IfEmptyStr(objConexaoBD.FInfosNfsBd.strTomadorEmail_, objConexaoBD.FInfosNfsBd.strTomadorEmail2);
  frxDanfe.Script.Variables['TMSFONE']    := fFormataFone(objConexaoBD.FInfosNfsBd.strTomadorFone01);
  frxDanfe.Script.Variables['TMSCELULAR'] := objConexaoBD.FInfosNfsBd.strTomadorCelular;
  frxDanfe.Script.Variables['TMSCEP']     := fFormataCEP(arrCdsNfs[0].FieldByName('TMSCEP').AsString);
  frxDanfe.Script.Variables['IMDEST']     := IfEmptyStr(arrCdsNfs[0].FieldByName('TMSIM').AsString, objConexaoBD.FInfosNfsBd.strTomadorIM);
  frxDanfe.Script.Variables['IEDEST']     := IfEmptyStr(arrCdsNfs[0].FieldByName('TMSIE').AsString, objConexaoBD.FInfosNfsBd.strTomadorI_E_S_);

  // Variaveis de Serviço
  frxDanfe.Script.Variables['DESSER']  := objConexaoBD.fRetDescClassificacaoServico(fStrZero(AnsiReplaceStr(arrCdsNfs[0].FieldByName('CODSER').AsString, '.', ''),4));
  if fEmptyStr( arrCdsNfs[0].FieldByName('LOCPRE').AsString) then
    frxDanfe.Script.Variables['LOCPRE']  := fCampoTabela('CONCAT(CID_NOMCID," / ", CID_ESTADO) AS MUNPRE', 'CADCID', ['CID_COIBGE'], [arrCdsNfs[0].FieldByName('CODMUN').AsString])
  else
    frxDanfe.Script.Variables['LOCPRE']  := arrCdsNfs[0].FieldByName('LOCPRE').AsString;
  frxDanfe.Script.Variables['DISSER']  := objConexaoBD.FInfosNfsBd.strDiscriminacaoServico;
  frxDanfe.Script.Variables['CDCNAE']  := Copy(arrCdsNfs[0].FieldByName('CDCNAE').AsString, 1, 7);
  frxDanfe.Script.Variables['DESCNAE'] := fCampoTabela('CNA_NOMCNA', 'CADCNA', ['CNA_CODCNA'], [AnsiReplaceStr(AnsiReplaceStr(arrCdsNfs[0].FieldByName('CDCNAE').AsString, '-', ''), '/', '')]);
  frxDanfe.Script.Variables['CIDSERV'] := fCampoTabela('CID_NOMCID', 'CADCID', ['CID_COIBGE'], [arrCdsNfs[0].FieldByName('MUNINC').AsString]);
  frxDanfe.Script.Variables['UFSERV']  := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_COIBGE'], [arrCdsNfs[0].FieldByName('MUNINC').AsString]);

  frxDanfe.Script.Variables['CODSER']  := arrCdsNfs[0].FieldByName('CODSER').AsString;
  frxDanfe.Script.Variables['DESSER']  := fRetDescClassificacaoServico(Copy(fStrZero(AnsiReplaceStr(arrCdsNfs[0].FieldByName('CODSER').AsString, '.', ''),4),1,4));
  frxDanfe.Script.Variables['DESSER_XML'] := arrCdsNfs[0].FieldByName('DESSER').AsString;
  frxDanfe.Script.Variables['DESCRI']  := AnsiReplaceStr(UpperCase(arrCdsNfs[0].FieldByName('DISCRI').AsString), '.NN-', '');
  frxDanfe.Script.Variables['SERNAC']  := fRetDescClassificacaoServico(AnsiReplaceStr(arrCdsNfs[0].FieldByName('CDTRNAC').AsString, '.', ''));
  // Detalhamento de Valores
  frxDanfe.Script.Variables['VLRCRE']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VLRCRE').AsFloat);

  if (arrCdsNfs[0].FieldByName('VLRPIS').AsFloat > 0) then
    frxDanfe.Script.Variables['VALPIS']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VLRPIS').AsFloat)
  else
    frxDanfe.Script.Variables['VALPIS']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VALPIS').AsFloat);

  frxDanfe.Script.Variables['ALQPIS']     := FormatFloat('#,##0.0000', 0);

  if (arrCdsNfs[0].FieldByName('VLRCOF').AsFloat > 0) then
    frxDanfe.Script.Variables['VALCOF']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VLRCOF').AsFloat)
  else
    frxDanfe.Script.Variables['VALCOF']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VALCOF').AsFloat);

  frxDanfe.Script.Variables['ALQCOF']     := FormatFloat('#,##0.0000', 0);

  if (arrCdsNfs[0].FieldByName('VLRIR_').AsFloat > 0) then
    frxDanfe.Script.Variables['VALIRR']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VLRIR_').AsFloat)
  else
    frxDanfe.Script.Variables['VALIRR']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VALIRR').AsFloat);

  frxDanfe.Script.Variables['ALQIRR']     := FormatFloat('#,##0.0000', 0);

  if (arrCdsNfs[0].FieldByName('VLRINS').AsFloat > 0) then
    frxDanfe.Script.Variables['VALINS']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VLRINS').AsFloat)
  else
    frxDanfe.Script.Variables['VALINS']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VALINS').AsFloat);

  frxDanfe.Script.Variables['ALQINS']     := FormatFloat('#,##0.0000', 0);

  if (arrCdsNfs[0].FieldByName('VLRCSL').AsFloat > 0) then
    frxDanfe.Script.Variables['VALCSL']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VLRCSL').AsFloat)
  else
    frxDanfe.Script.Variables['VALCSL']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VALCSL').AsFloat);

  frxDanfe.Script.Variables['ALQCSL']     := FormatFloat('#,##0.0000', 0);
  frxDanfe.Script.Variables['ALQISS']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('ALIISS').AsFloat);
  frxDanfe.Script.Variables['DESCINC']    := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('DESCONI').AsFloat);
  frxDanfe.Script.Variables['DESCOND']    := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('DESCONC').AsFloat);
  frxDanfe.Script.Variables['OUTRET']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('OUT_RET').AsFloat);
  frxDanfe.Script.Variables['VALDED']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VLRDED').AsFloat);
  frxDanfe.Script.Variables['VALSER']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VLRSER').AsFloat);
  frxDanfe.Script.Variables['BASECAL']    := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('BSCISS').AsFloat);
  frxDanfe.Script.Variables['TOTDESCDED'] := FormatFloat('#,##0.00', (arrCdsNfs[0].FieldByName('DESCONC').AsFloat +
                                                                      arrCdsNfs[0].FieldByName('DESCONI').AsFloat +
                                                                      arrCdsNfs[0].FieldByName('VLRDED').AsFloat +
                                                                      arrCdsNfs[0].FieldByName('OUT_RET').AsFloat));
  frxDanfe.Script.Variables['TOTIMPFED']  := FormatFloat('#,##0.00', (arrCdsNfs[0].FieldByName('VALPIS').AsFloat +
                                                                      arrCdsNfs[0].FieldByName('VALCOF').AsFloat +
                                                                      arrCdsNfs[0].FieldByName('VAL_CP').AsFloat +
                                                                      arrCdsNfs[0].FieldByName('VALIRR').AsFloat +
                                                                      arrCdsNfs[0].FieldByName('VALCSL').AsFloat));
  frxDanfe.Script.Variables['TOTPICO']    := FormatFloat('#,##0.00', (arrCdsNfs[0].FieldByName('VALPIS').AsFloat +
                                                                      arrCdsNfs[0].FieldByName('VALCOF').AsFloat ));
  frxDanfe.Script.Variables['TOTIRCS']    := FormatFloat('#,##0.00', (arrCdsNfs[0].FieldByName('VALIRR').AsFloat +
                                                                      arrCdsNfs[0].FieldByName('VALCSL').AsFloat +
                                                                      arrCdsNfs[0].FieldByName('VAL_CP').AsFloat));
  frxDanfe.Script.Variables['VALISS']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VLRISS').AsFloat);
  frxDanfe.Script.Variables['VLRLIQ']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VLRLIQ').AsFloat);
  frxDanfe.Script.Variables['VALLIQ']     := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VALLIQ').AsFloat);
  frxDanfe.Script.Variables['OBSERV']     := arrCdsNfs[0].FieldByName('OBSERV').AsString;
  frxDanfe.Script.Variables['OBSORS']     := arrCdsNfs[0].FieldByName('OBSERV').AsString;

  if (arrCdsNfs[0].FieldByName('VLRPIS').AsFloat > 0) then
    frxDanfe.Script.Variables['PISPORCENTO'] := FormatFloat('#,##0.00', fCalculaPorcentagem(arrCdsNfs[0].FieldByName('VLRPIS').AsFloat,
                                                                                            arrCdsNfs[0].FieldByName('VLRSER').AsFloat))
  else
    frxDanfe.Script.Variables['PISPORCENTO'] := FormatFloat('#,##0.00', fCalculaPorcentagem(arrCdsNfs[0].FieldByName('VALPIS').AsFloat,
                                                                                            arrCdsNfs[0].FieldByName('VLRSER').AsFloat));

  if (arrCdsNfs[0].FieldByName('VLRCOF').AsFloat > 0) then
    frxDanfe.Script.Variables['COFPORCENTO'] := FormatFloat('#,##0.00', fCalculaPorcentagem(arrCdsNfs[0].FieldByName('VLRCOF').AsFloat,
                                                                                            arrCdsNfs[0].FieldByName('VLRSER').AsFloat))
  else
    frxDanfe.Script.Variables['COFPORCENTO'] := FormatFloat('#,##0.00', fCalculaPorcentagem(arrCdsNfs[0].FieldByName('VALCOF').AsFloat,
                                                                                            arrCdsNfs[0].FieldByName('VLRSER').AsFloat));

  if (arrCdsNfs[0].FieldByName('VLRCSL').AsFloat > 0) then
    frxDanfe.Script.Variables['CSLPORCENTO'] := FormatFloat('#,##0.00', fCalculaPorcentagem(arrCdsNfs[0].FieldByName('VLRCSL').AsFloat,
                                                                                            arrCdsNfs[0].FieldByName('VLRSER').AsFloat))
  else
    frxDanfe.Script.Variables['CSLPORCENTO'] := FormatFloat('#,##0.00', fCalculaPorcentagem(arrCdsNfs[0].FieldByName('VALCSL').AsFloat,
                                                                                            arrCdsNfs[0].FieldByName('VLRSER').AsFloat));

  if (arrCdsNfs[0].FieldByName('VLRINS').AsFloat > 0) then
    frxDanfe.Script.Variables['INSPORCENTO'] := FormatFloat('#,##0.00', fCalculaPorcentagem(arrCdsNfs[0].FieldByName('VLRINS').AsFloat,
                                                                                            arrCdsNfs[0].FieldByName('VLRSER').AsFloat))
  else
    frxDanfe.Script.Variables['INSPORCENTO'] := FormatFloat('#,##0.00', fCalculaPorcentagem(arrCdsNfs[0].FieldByName('VALINS').AsFloat,
                                                                                            arrCdsNfs[0].FieldByName('VLRSER').AsFloat));

  if (arrCdsNfs[0].FieldByName('VLRIR_').AsFloat > 0) then
    frxDanfe.Script.Variables['IRRPORCENTO'] := FormatFloat('#,##0.00', fCalculaPorcentagem(arrCdsNfs[0].FieldByName('VLRIR_').AsFloat,
                                                                                            arrCdsNfs[0].FieldByName('VLRSER').AsFloat))
  else
    frxDanfe.Script.Variables['IRRPORCENTO'] := FormatFloat('#,##0.00', fCalculaPorcentagem(arrCdsNfs[0].FieldByName('VALIRR').AsFloat,
                                                                                            arrCdsNfs[0].FieldByName('VLRSER').AsFloat));

  frxDanfe.Script.Variables['DEDUCA']     := '0,00';
  frxDanfe.Script.Variables['VALNTRIB']   := '0,00';
  frxDanfe.Script.Variables['VALDESCINC'] := '0,00';
  frxDanfe.Script.Variables['VALDESCCON'] := '0,00';
  frxDanfe.Script.Variables['VALOUTRET']  := '0,00';
  frxDanfe.Script.Variables['VALISSRET']  := '0,00';

  if (arrCdsNfs[0].FieldByName('VLRPIS').AsFloat > 0) or
     (arrCdsNfs[0].FieldByName('VLRCOF').AsFloat > 0) or
     (arrCdsNfs[0].FieldByName('VLRCSL').AsFloat > 0) or
     (arrCdsNfs[0].FieldByName('VLRIR_').AsFloat > 0) then
    frxDanfe.Script.Variables['VALRETFED']  :=  FormatFloat('#,##0.00', (arrCdsNfs[0].FieldByName('VLRPIS').AsFloat+
                                                                         arrCdsNfs[0].FieldByName('VLRCOF').AsFloat+
                                                                         arrCdsNfs[0].FieldByName('VLRCSL').AsFloat+
                                                                         arrCdsNfs[0].FieldByName('VLRIR_').AsFloat))
  else
    frxDanfe.Script.Variables['VALRETFED']  :=  FormatFloat('#,##0.00', (arrCdsNfs[0].FieldByName('VALPIS').AsFloat+
                                                                         arrCdsNfs[0].FieldByName('VALCOF').AsFloat+
                                                                         arrCdsNfs[0].FieldByName('VALCSL').AsFloat+
                                                                         arrCdsNfs[0].FieldByName('VALIRR').AsFloat));

  frxDanfe.Script.Variables['VALNFS'] := FormatFloat('#,##0.00', arrCdsNfs[0].FieldByName('VLRSER').AsFloat);

  frxDanfe.Script.Variables['MUNPRE_XML'] := arrCdsNfs[0].FieldByName('MUNPRE').AsString;

  frxDanfe.Script.Variables['MUNPRE'] := IIF((objConexaoBD.FInfosNfsBd.strMunPre = '1') or (objConexaoBD.FInfosNfsBd.strMunPre = ''),
                                             objConexaoBD.FInfosNfsBd.strCidad,
                                             objConexaoBD.FInfosNfsBd.strTomadorCidade);

  frxDanfe.Script.Variables['SERMUN'] := IIF((objConexaoBD.FInfosNfsBd.strMunPre = '1') or (objConexaoBD.FInfosNfsBd.strMunPre = ''),
                                             objConexaoBD.FInfosNfsBd.strCidad+'-'+objConexaoBD.FInfosNfsBd.strUF,
                                             IIF(((objConexaoBD.FInfosNfsBd.strMunPre = '2') and (not fEmptyStr(objConexaoBD.FInfosNfsBd.strSerMun))),
                                             objConexaoBD.FInfosNfsBd.strSerMun,
                                             objConexaoBD.FInfosNfsBd.strTomadorCidade+'-'+objConexaoBD.FInfosNfsBd.strTomadorUF));

  dtDataVenIss := IncMonth(StrToDateDef(arrCdsNfs[0].FieldByName('DTAEMI').AsString, 0), 1);

  frxDanfe.Script.Variables['DTAVENC'] := DateToStr(dtDataVenIss);
  frxDanfe.Script.Variables['VCTISS']  := DateTimeToStr(fRetDiaVencimentoISS( StrToDateTime(arrCdsNfs[0].FieldByName('DTAEMI').AsString), 14));
  frxDanfe.Script.Variables['LOCAL_RECOLHIMENTO'] := fCampoTabela('CID_NOMCID', 'CADCID', ['CID_COIBGE'], [arrCdsNfs[0].FieldByName('ORGMUN').AsString])+'-'+
                                                     arrCdsNfs[0].FieldByName('ORG_UF').AsString;

  frxDanfe.Script.Variables['IMPFED'] := '0,00';
  frxDanfe.Script.Variables['IMPEST'] := '0,00';
  frxDanfe.Script.Variables['IMPMUN'] := '0,00';
  frxDanfe.Script.Variables['TRIBUTACAO'] := 'Tributação por Faturamento (Variável)'; //Conforme Leandro da FIT, outro campo fixo.
  If (arrCdsNfs[0].FieldByName('ISS_RET').AsString = '2') Then
    frxDanfe.Script.Variables['RECOLHIMENTO'] := 'Sem Retenção'
  else
    frxDanfe.Script.Variables['RECOLHIMENTO'] := 'Com Retenção';
  frxDanfe.Script.Variables['CNAE'] := arrCdsNfs[0].FieldByName('CNAEFI').AsString;
  frxDanfe.Script.Variables['CODTRI_DESCRI'] := arrCdsNfs[0].FieldByName('CODTRI').AsString+' - '+
                                                fRetDescClassificacaoServico(arrCdsNfs[0].FieldByName('CODTRI').AsString);

  frxDanfe.Script.Variables['INCCULT'] := '';
  if arrCdsNfs[0].FieldByName('EMIICC').asString <> '' then
  begin
    If arrCdsNfs[0].FieldByName('EMIICC').AsInteger = 1 Then
      frxDanfe.Script.Variables['INCCULT'] := '1 - Sim'
    Else If arrCdsNfs[0].FieldByName('EMIICC').AsInteger = 2 Then
      frxDanfe.Script.Variables['INCCULT'] := '2 - Não';
  end;

  frxDanfe.Script.Variables['DTACPT'] := arrCdsNfs[0].FieldByName('COMPET').asString;

  // Variavel de Faturas
  frxDanfe.Script.Variables['FATURAS'] := '';
  frxDanfe.Script.Variables['CONPAG']  := objConexaoBD.FInfosNfsBd.strConPag;
  arrCdsNfs[2].First;
  While Not arrCdsNfs[2].Eof Do
  Begin
    if fEmptyStr(strFaturas) then
      strFaturas := 'Vencimento: ' + sLineBreak;
    if not fEmptyStr(arrCdsNfs[2].FieldByName('DTAVEN').AsString) then
      strFaturas := strFaturas + FormatDateTime('dd/mm/yyyy', arrCdsNfs[2].FieldByName('DTAVEN').AsDateTime)
                               +' Valor: '+ FloatToStrF(arrCdsNfs[2].FieldByName('VALFAT').AsFloat, ffCurrency, 16, 2)
                               + sLineBreak;
    arrCdsNfs[2].Next;
  End;
  frxDanfe.Script.Variables['FATURAS'] := strFaturas;
  frxDanfe.Script.Variables['DESCRSERVMUN'] := Trim(AnsiReplaceStr(objConexaoBD.FInfosNfsBd.strIteDes, '#', sLineBreak));
  frxDanfe.Script.Variables['MOVOBS'] := AnsiReplaceStr(objConexaoBD.FInfosNfsBd.strMovObs, '#', sLineBreak);
  frxDanfe.Script.Variables['OUTINF'] := AnsiReplaceStr(AnsiReplaceStr(arrCdsNfs[0].FieldByName('OUTINF').AsString, '|', sLineBreak),'sn', sLineBreak);

  //Novos campos para configuração da Prefeitura para o Portal Nacional - REQ 416240
  frxDanfe.Script.Variables['PREFEITURA'] := objConexaoBD.FConfiguracao.Prefeitura;
  frxDanfe.Script.Variables['SECRETARIA'] := objConexaoBD.FConfiguracao.Secretaria;
  If Assigned(frxDanfe.FindComponent('qrCodeNFSe')) Then
    (frxDanfe.FindComponent('qrCodeNFSe') As TfrxBarcode2DView).Text := 'https://www.nfse.gov.br/ConsultaPublica/?tpc=1&chave='+arrCdsNfs[0].FieldByName('NFSEID').AsString;
  frxDanfe.Script.Variables['CNFNFE'] := objConexaoBD.FInfosNfsBd.strCNFNFE;
  frxDanfe.Script.Variables['OBSLOCEQUIP'] := objConexaoBD.FInfosNfsBd.strObservContratoLocacao;
  frxDanfe.Script.Variables['NUMCMP'] := objConexaoBD.FInfosNfsBd.strPedidoDeCompra;
  frxDanfe.Script.Variables['LOCPRESTACAO'] := arrCdsNfs[0].FieldByName('LOCPRE').AsString;
  frxDanfe.Script.Variables['INILOCEQUIP']  := objConexaoBD.FInfosNfsBd.strInicioContratoLocacao;
  frxDanfe.Script.Variables['FINLOCEQUIP']  := objConexaoBD.FInfosNfsBd.strFimContratoLocacao;
  frxDanfe.Script.Variables['VENCTO_NFS']   := objConexaoBD.FInfosNfsBd.strVencimentoFatura;
  frxDanfe.Script.Variables['NROCON']       := objConexaoBD.FInfosNfsBd.strNumeroContratoLocacao;
  if (Length(arrCdsNfs) > 0) and Assigned(arrCdsNfs[0]) and (not arrCdsNfs[0].IsEmpty) then
    frxDanfe.Script.Variables['OBSNFS']     := objConexaoBD.fRetObsOrdemServ(arrCdsNfs[0].FieldByName('NUMNFS').AsString, 'NS', objConexaoBD.FInfosNfsBd.strCodEmp)
  else
    frxDanfe.Script.Variables['OBSNFS']     := '';
  frxDanfe.Script.Variables['DESNBS'] := fCampoTabela('NBS_DESCRI', 'CADNBS', ['NBS_CODIGO'], [arrCdsNfs[0].FieldByName('CODNBS').AsString]);
  if (Length(arrCdsNfs) > 0) and Assigned(arrCdsNfs[0]) and (not arrCdsNfs[0].IsEmpty) then
    frxDanfe.Script.Variables['DESITE']     := objConexaoBD.fRetDesIte(arrCdsNfs[0].FieldByName('NUMNFS').AsString, 'NS', objConexaoBD.FInfosNfsBd.strCodEmp)
  else
    frxDanfe.Script.Variables['DESITE']     := '';

end;

procedure TImpressaoNfs.pFormataCamposPadrao;
begin
  arrCdsNfs[0].Edit;
  arrCdsNfs[0].FieldByName('PSVCNPJ').AsString := fFormataCpfCgc( IIF(fEmptyStr(arrCdsNfs[0].FieldByName('PSVCNPJ').AsString),
                                                                      objConexaoBD.FInfosNfsBd.strCNPJ,
                                                                      arrCdsNfs[0].FieldByName('PSVCNPJ').AsString),
                                                                 objConexaoBD.FInfosNfsBd.strUF);

  arrCdsNfs[0].FieldByName('PSVIE').AsString := fFormataInscricaoEstadual(IIF(fEmptyStr(arrCdsNfs[0].FieldByName('PSVIE').AsString),
                                                      objConexaoBD.FInfosNfsBd.strInsEst,
                                                      arrCdsNfs[0].FieldByName('PSVIE').AsString));

  arrCdsNfs[0].FieldByName('TMSCNPJ').AsString := fFormataCpfCgc(arrCdsNfs[0].FieldByName('TMSCNPJ').AsString,
                                                                 objConexaoBD.FInfosNfsBd.strTomadorUF);

  arrCdsNfs[0].FieldByName('TMSIE').AsString    :=  fFormataInscricaoEstadual(arrCdsNfs[0].FieldByName('TMSIE').AsString);
  arrCdsNfs[0].FieldByName('TMSIM').AsString    :=  fFormataInscricaoEstadual(arrCdsNfs[0].FieldByName('TMSIM').AsString);
  arrCdsNfs[0].FieldByName('PSVFONE').AsString  :=  fFormataFone(arrCdsNfs[0].FieldByName('PSVFONE').AsString);
  arrCdsNfs[0].FieldByName('TMSFONE').AsString  :=  fFormataFone(arrCdsNfs[0].FieldByName('TMSFONE').AsString);
  arrCdsNfs[0].Post;
end;

procedure TImpressaoNfs.pImprimeDanfeNfs;
var
  i, intQtdVias: Integer;
begin
  Try

    frxDanfe.DataSets.Clear;

    frxDbDanfe.DataSet    := Self.arrCdsNfs[0];
    frxDbDanfe.UserName   := 'frxNFS';
    frxDanfe.DataSets.Add(frxDbDanfe);

    frxDbItens.DataSet    := Self.arrCdsNfs[1];
    frxDbItens.UserName   := 'frxITENS';
    frxDanfe.DataSets.Add(frxDbItens);

    If Assigned(frxDanfe.FindComponent('Itens')) Then
      (frxDanfe.FindComponent('Itens') As TfrxMasterData).DataSet := frxDbItens;

    objConexaoBD.pPreencheCdsFaturas(Self.arrCdsNfs[2]);
    frxDbFaturas.DataSet    := Self.arrCdsNfs[2];
    frxDbFaturas.UserName   := 'frxFATURAS';
    frxDanfe.DataSets.Add(frxDbFaturas);
    If Assigned(frxDanfe.FindComponent('Faturas')) Then
      TfrxMasterData(frxDanfe.FindObject('Faturas')).DataSet := frxDbFaturas;

    pCarregaVariaveisPadrao;
    pFormataCamposPadrao;
    pConfigurarLogotipoDanfse;

    If not blnDesignReport Then
    Begin
      intQtdVias := StrToIntDef(objConexaoBD.CarregarCFGSIS('QTDNFS'),1);

      If (intQtdVias < 0) Or (blnPDF_Gerar) Or (blnReimpressao) Then
        intQtdVias := 1;

      If not blnPDF_Banco Then
      Begin
        For i := 1 To intQtdVias Do
        Begin

          {PDF}
          If (blnPDF_Gerar) Then
          Begin
            frxDanfe.EngineOptions.SilentMode := True;
            frxDanfe.EngineOptions.ConvertNulls := False;

            frxDanfe.EngineOptions.NewSilentMode := simReThrow;
            frxPDFExport.FileName   := strPDF_Diretorio;
            frxPDFExport.ShowDialog := False;

            frxDanfe.PrintOptions.ShowDialog := False;
            frxDanfe.PrepareReport();
          {$IF Defined(LINUX)}
            frxPDFExport.EmbeddedFonts := True;
          {$IFEND}
            frxDanfe.Export(frxPDFExport);

            If (blnPDF_Apresentar) Then
            Begin
              if FileExists(frxPDFExport.FileName) then
              begin
               {$IF not defined(LINUX)}
                ShellExecute(0, nil, PChar(frxPDFExport.FileName), nil, nil, SW_SHOWNORMAL);
               {$IFEND}
              end
              else
              begin
                frxPDFExport.ShowDialog := True;
                pPreviewReport('NFeImpressao', 'NFS-e '+ strChaveAcesso, frxDanfe);
              end;
            End;

          End
          Else
          Begin
            frxDanfe.EngineOptions.SilentMode := True;
            frxDanfe.EngineOptions.ConvertNulls := False;

            frxDanfe.PrintOptions.Printer    := AnsiReplaceStr(strImpressora, '\\' + fRetNomeRede + '\', '');
            frxDanfe.PrintOptions.ShowDialog := False;

            If (frxDanfe.PrepareReport) Then
              pPrintReport('NFeImpressao', 'NFS-e '+ strChaveAcesso, strImpressora, frxDanfe);

            If (intQtdVias > 1) Then
              Sleep(1000);
          End;
        End;
      End;

      If Assigned(objConexaoBD) Then
      Begin
        objConexaoBD.pSalvarDFePDF(frxDanfe, strChaveAcesso);
      End;
    End
    Else
      frxDanfe.DesignReport;
  Finally
    //FreeAndNil(objConexaoBD); {objeto é destruído posteriormente no DanfeNFS.Free da untImpressaoNFe}
  End;
end;

procedure TImpressaoNfs.pImprimeDanfeNfsDinamica;
var
  i, intQtdVias, intDs: Integer;
  qryCds: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  cdsDin: TUniClientDataSet;
  frxDb: TfrxDBDataset;
  blnFalhaPrepare: Boolean;

  procedure pPrepareNotaServicoDinamico;
  Begin
    if (not frxDanfe.PrepareReport) Then
    begin
      // relatório incompleto: imprime (SilentMode), mas não salva o PDF no banco
      blnFalhaPrepare := True;
      TNfsDinamico.pGravaLogDin('Erro NfeImpressao NFS Dinamico', strChaveAcesso,
        'PDF da NFS-e não foi salvo no banco (falha na preparação do relatório).',
        frxDanfe.Errors.Text);
    End;
  end;

begin
  blnFalhaPrepare := False;
  Try
    frxDanfe.DataSets.Clear;
    SetLength(Self.arrCdsNfs, 0);
    FDatasetsDinProprios := True;
    intDs := 0;
    SetLength(Self.arrFrxDb, 0);

    qryCds := fCriaQuery(nil);
    Try
      qryCds.SQL.Text :=
        'SELECT c.CDS_NOMCDS, c.CDS_NOMFRX FROM IMPNFE_CDS c ' +
        'WHERE c.CDS_CODPRV = :PRV ' +
        'AND COALESCE(c.CDS_ORIGEM, ''X'') <> ''A'' ' +
        'ORDER BY (c.CDS_NOMFRX <> ''frxNFS''), c.CDS_NOMCDS';
      qryCds.ParamByName('PRV').AsString := FProvedorDin;
      qryCds.Open;
      While Not qryCds.Eof Do
      Begin
        cdsDin := TUniClientDataSet.Create(nil);
        pAddArrCdsNfs(cdsDin);
        TNfsDinamico.pMontarCds(cdsDin, FProvedorDin, qryCds.FieldByName('CDS_NOMCDS').AsString,
          FXmlDin, strChaveAcesso, objConexaoBD.FInfosNfsBd.strCodEmp);

        Inc(intDs);
        frxDb := TfrxDBDataset.Create(nil);
        // rastreado ja na criacao: o destructor libera mesmo se algo abaixo falhar
        SetLength(Self.arrFrxDb, Length(Self.arrFrxDb) + 1);
        Self.arrFrxDb[High(Self.arrFrxDb)] := frxDb;
        frxDb.Name     := 'frxDsDin' + IntToStr(intDs);
        frxDb.DataSet  := cdsDin;
        frxDb.UserName := qryCds.FieldByName('CDS_NOMFRX').AsString;
        frxDb.OpenDataSource  := False;
        frxDb.CloseDataSource := False;
        frxDanfe.DataSets.Add(frxDb);

        If SameText(qryCds.FieldByName('CDS_NOMFRX').AsString, 'frxITENS') And
           Assigned(frxDanfe.FindComponent('Itens')) Then
          (frxDanfe.FindComponent('Itens') As TfrxMasterData).DataSet := frxDb;

        If SameText(qryCds.FieldByName('CDS_NOMFRX').AsString, 'frxFATURAS') And
           Assigned(frxDanfe.FindObject('Faturas')) Then
          TfrxMasterData(frxDanfe.FindObject('Faturas')).DataSet := frxDb;

        qryCds.Next;
      End;
    Finally
      FreeAndNil(qryCds);
    End;

    If Length(Self.arrCdsNfs) > 0 Then
    Begin
      TNfsDinamico.pCarregaVariaveis(frxDanfe, FProvedorDin, Self.arrCdsNfs[0],
        strChaveAcesso, objConexaoBD.FInfosNfsBd.strCodEmp,
        objConexaoBD.FInfosNfsBd.strNumDoc, objConexaoBD.FInfosNfsBd.strEspDoc);
      pFormataCamposPadrao;

      // como na pCarregaVariaveisPadrao: QR code da consulta publica da NFS-e nacional
      If Assigned(frxDanfe.FindComponent('qrCodeNFSe')) And
         (Self.arrCdsNfs[0].FindField('NFSEID') <> nil) Then
        (frxDanfe.FindComponent('qrCodeNFSe') As TfrxBarcode2DView).Text :=
          'https://www.nfse.gov.br/ConsultaPublica/?tpc=1&chave=' + Self.arrCdsNfs[0].FieldByName('NFSEID').AsString;
    End;
    pConfigurarLogotipoDanfse;

    If not blnDesignReport Then
    Begin
      intQtdVias := StrToIntDef(objConexaoBD.CarregarCFGSIS('QTDNFS'),1);

      If (intQtdVias < 0) Or (blnPDF_Gerar) Or (blnReimpressao) Then
        intQtdVias := 1;

      If not blnPDF_Banco Then
      Begin
        For i := 1 To intQtdVias Do
        Begin

          {PDF}
          If (blnPDF_Gerar) Then
          Begin
            frxDanfe.EngineOptions.SilentMode := True;
            frxDanfe.EngineOptions.ConvertNulls := False;

            frxDanfe.EngineOptions.NewSilentMode := simReThrow;
            frxPDFExport.FileName   := strPDF_Diretorio;
            frxPDFExport.ShowDialog := False;

            frxDanfe.PrintOptions.ShowDialog := False;
            pPrepareNotaServicoDinamico;
          {$IF Defined(LINUX)}
            frxPDFExport.EmbeddedFonts := True;
          {$IFEND}
            frxDanfe.Export(frxPDFExport);

            If (blnPDF_Apresentar) Then
            Begin
              if FileExists(frxPDFExport.FileName) then
              begin
               {$IF not defined(LINUX)}
                ShellExecute(0, nil, PChar(frxPDFExport.FileName), nil, nil, SW_SHOWNORMAL);
               {$IFEND}
              end
              else
              begin
                frxPDFExport.ShowDialog := True;
                pPreviewReport('NFeImpressao', 'NFS-e '+ strChaveAcesso, frxDanfe);
              end;
            End;

          End
          Else
          Begin
            frxDanfe.PrintOptions.Printer    := AnsiReplaceStr(strImpressora, '\\' + fRetNomeRede + '\', '');
            frxDanfe.PrintOptions.ShowDialog := False;

            frxDanfe.EngineOptions.SilentMode := True;
            frxDanfe.EngineOptions.ConvertNulls := False;

            pPrepareNotaServicoDinamico;

            //pPreviewReport('NFeImpressao', 'NFS-e '+ strChaveAcesso, frxDanfe);
            pPrintReport('NFeImpressao', 'NFS-e '+ strChaveAcesso, strImpressora, frxDanfe);

            If (intQtdVias > 1) Then
              Sleep(1000);
          End;
        End;
      End;

      // não persiste PDF parcial: a falha já foi registrada na LOGERR
      If Assigned(objConexaoBD) And (Not blnFalhaPrepare) Then
      Begin
        objConexaoBD.pSalvarDFePDF(frxDanfe, strChaveAcesso);
      End;
    End
    Else
      frxDanfe.DesignReport;
  Finally
    //FreeAndNil(objConexaoBD); {objeto é destruído posteriormente no DanfeNFS.Free da untImpressaoNFe}
  End;
end;

procedure TImpressaoNfs.pConfigurarLogotipoDanfse;
var
{$IF Defined(LINUX)}
  imgLogotipo : FMX.Graphics.TBitmap;
{$ELSE}
  imgLogotipo : TPicture;
{$IFEND}
  vStreamLogotipo : TMemoryStream;
begin
  if Not fEmptyStr(objConexaoBD.FConfiguracao.Logo) then
  begin
    if Assigned(frxDanfe.FindObject('picLogo')) then
    begin
    {$IF Defined(LINUX)}
      imgLogotipo := FMX.Graphics.TBitmap.Create;
      vStreamLogotipo := TMemoryStream.Create;
      try
        ConverterBase64ParaImagem(objConexaoBD.FConfiguracao.Logo, imgLogotipo);
        imgLogotipo.SaveToStream(vStreamLogotipo);
        vStreamLogotipo.position := 0;
        TfrxPictureView(frxDanfe.FindObject('picLogo')).Picture.LoadFromStream(vStreamLogotipo);
      finally
        FreeAndNil(imgLogotipo);
        FreeAndNil(vStreamLogotipo);
      end;
    {$ELSE}
      imgLogotipo := TPicture.Create;
      vStreamLogotipo := TMemoryStream.Create;
      try
        ConverterBase64ParaImagem(objConexaoBD.FConfiguracao.Logo, imgLogotipo);
        imgLogotipo.Bitmap.SaveToStream(vStreamLogotipo);
        vStreamLogotipo.position := 0;
        TfrxPictureView(frxDanfe.FindObject('picLogo')).LoadPictureFromStream(vStreamLogotipo);
      finally
        FreeAndNil(imgLogotipo);
        FreeAndNil(vStreamLogotipo);
      end;
    {$IFEND}
    end;
  end;

  if Not fEmptyStr(objConexaoBD.FConfiguracao.BrasaoPrefeitura) then
  begin
    if Assigned(frxDanfe.FindObject('picBrasao')) then
    begin
    {$IF Defined(LINUX)}
      imgLogotipo := FMX.Graphics.TBitmap.Create;
      vStreamLogotipo := TMemoryStream.Create;
      try
        ConverterBase64ParaImagem(objConexaoBD.FConfiguracao.BrasaoPrefeitura, imgLogotipo);
        imgLogotipo.SaveToStream(vStreamLogotipo);
        vStreamLogotipo.position := 0;
        TfrxPictureView(frxDanfe.FindObject('picBrasao')).Picture.LoadFromStream(vStreamLogotipo);
      finally
        FreeAndNil(imgLogotipo);
        FreeAndNil(vStreamLogotipo);
      end;
    {$ELSE}
      imgLogotipo := TPicture.Create;
      vStreamLogotipo := TMemoryStream.Create;
      try
        ConverterBase64ParaImagem(objConexaoBD.FConfiguracao.BrasaoPrefeitura, imgLogotipo);
        imgLogotipo.Bitmap.SaveToStream(vStreamLogotipo);
        vStreamLogotipo.position := 0;
        TfrxPictureView(frxDanfe.FindObject('picBrasao')).LoadPictureFromStream(vStreamLogotipo);
      finally
        FreeAndNil(imgLogotipo);
        FreeAndNil(vStreamLogotipo);
      end;
    {$IFEND}
    end;
  end;

end;

{ TTraducaoXml }

class function TTraducaoXml.fRegimeEspecialTributacao(strValor: String): String;
begin
  Result := '';

  If fEmptyStr(strValor) Then
    Exit;

  Case StrToIntDef(strValor, 0) Of
    0: Result := 'Nenhum';
    1: Result := '';
  End;
end;

class function TTraducaoXml.fEhTributacaoISSQN(strValor: String): String;
begin
  Result := '';

  If fEmptyStr(strValor) Then
    Exit;

  Case StrToIntDef(strValor, 0) Of
    1: Result := 'Operação Tributável';
    2: Result := 'Operação Não Tributável';
  End;
end;

class function TTraducaoXml.fEhIssRetido(strValor: String): String;
begin
  Result := '';

  If fEmptyStr(strValor) Then
    Exit;

  Case StrToIntDef(strValor, 0) Of
    1: Result := '1 - Sim';
    2: Result := '2 - Não';
  End;
end;

class function TTraducaoXml.fEhOptanteSimplesNacional(strValor: String): String;
begin
  Result := '';

  If fEmptyStr(strValor) Then
    Exit;

  Case StrToIntDef(strValor, 0) Of
    1: Result := '1 - Sim';
    2: Result := '2 - Não';
  End;
end;

class function TTraducaoXml.fExigivelIss(strValor: String): String;
begin
  Result := '';

  If fEmptyStr(strValor) Then
    Exit;

  Case StrToIntDef(strValor, 0) Of
    1: Result := '1 - Exigível';
    2: Result := '2 - Não exigível';
  End;
end;

class function TTraducaoXml.fRetNatOpe(strValor: String): String;
begin
  Result := '';

  If fEmptyStr(strValor) Then
    Exit;

  Case StrToIntDef(strValor, 0) Of
    1: Result := 'Tributação no município';
    2: Result := 'Tributação fora do município';
    3: Result := 'Isenção';
    4: Result := 'Imune';
    5: Result := 'Exigibilidade suspensa';
    6: Result := 'Exigibilidade suspensa';
  End;
end;

class function TTraducaoXml.fTemIncentivoFiscal(strValor: String): String;
begin
  Result := '';

  If fEmptyStr(strValor) Then
    Exit;

  Case StrToIntDef(strValor, 0) Of
    1: Result := '1 - Sim';
    2: Result := '2 - Não';
  End;
end;

class function TTraducaoXml.fValidaRegimeEspTri(strValor: String): String;
begin
  Result := '';

  If fEmptyStr(strValor) Then
    Exit;

  Case StrToIntDef(strValor, 0) Of
      0: Result := 'Nenhum';
      1: Result := 'Microempresa Municipal';
      2: Result := 'Estimativa';
      3: Result := 'Sociedade de Profissionais';
      4: Result := 'Cooperativa';
      5: Result := 'Microempresário Individual (MEI)';
      6: Result := 'Microempresário e Empresa de Pequeno Porte (ME EPP)';
    End;
end;

class function TTraducaoXml.fEhOptanteSimplesNacionalPortalNacional(strValor: String): String;
begin
  Result := '';

  If fEmptyStr(strValor) Then
    Exit;

  Case StrToIntDef(strValor, 0) Of
    1: Result := 'Não Optante';
    2: Result := 'Optante - Microempreendedor Individual (MEI)';
    3: Result := 'Optante - Microempresa ou Empresa de Pequeno Porte (ME/EPP)';
  End;
end;

class function TTraducaoXml.fValidaRegimeApTribSNPortalNacional(strValor: String): String;
begin
  Result := '';

  If fEmptyStr(strValor) Then
    Exit('Não Informado');

  Case StrToIntDef(strValor, 0) Of
      0: Result := 'Nenhum';
      1: Result := 'Regime de apuração dos tributos federais e municipal pelo SN';
      2: Result := 'Regime de apuração dos tributos federais pelo SN e ISSQN por fora do SN conforme respectiva legislação municipal do tributo';
      3: Result := 'Regime de apuração dos tributos federais e municipal por fora do SN conforme respectivas legislações federal e municipal de cada tributo';
    End;
end;

class function TTraducaoXml.fValidaRegimeEspTriPortalNacional(strValor: String): String;
begin
  Result := '';

  If fEmptyStr(strValor) Then
    Exit;

  Case StrToIntDef(strValor, 0) Of
      0: Result := 'Nenhum';
      1: Result := 'Ato Cooperado (Cooperativa)';
      2: Result := 'Estimativa';
      3: Result := 'Microempresa Municipal';
      4: Result := 'Notário ou Registrador';
      5: Result := 'Profissional Autônomo';
      6: Result := 'Sociedade de Profissionais';
      9: Result := 'Outros';
    End;
end;

class function TTraducaoXml.fValidaRegimeEspTriABRASF(strValor: String): String;
begin
  Result := '';

  If fEmptyStr(strValor) Then
    Exit;

  Case StrToIntDef(strValor, 0) Of
      0: Result := 'Nenhum';
      1: Result := 'Microempresa Municipal';
      2: Result := 'Estimativa';
      3: Result := 'Sociedade de Profissionais';
      4: Result := 'Cooperativa';
      5: Result := 'Microempreendedor Individual (MEI)';
      6: Result := 'Microempresário e Empresa de Pequeno Porte (ME EPP)';
    End;
end;

class function TTraducaoXml.fValidaISSRetidoPortalNacional(strValor: String): String;
begin
  Result := '';

  If fEmptyStr(strValor) Then
    Exit;

  Case StrToIntDef(strValor, 0) Of
      0: Result := 'Nenhum';
      1: Result := 'Não Retido';
      2: Result := 'Retido pelo Tomador';
      3: Result := 'Retido pelo Intermediario';
    End;
end;

class function TTraducaoXml.fDescricaoRetPisCofinsPortalNacional(strValor: String): String;
begin
  Result := '';

  If fEmptyStr(strValor) Then
    Exit;

  Case StrToIntDef(strValor, 0) Of
    0: Result := '0 - PIS/COFINS/CSLL Não Retidos';
    1: Result := '1 - PIS/COFINS Retido';
    2: Result := '2 - PIS/COFINS Não Retido';
    3: Result := '3 - PIS/COFINS/CSLL Retidos';
    4: Result := '4 - PIS/COFINS Retidos, CSLL Não Retido';
    5: Result := '5 - PIS Retido, COFINS/CSLL Não Retido';
    6: Result := '6 - COFINS Retido, PIS/CSLL Não Retido';
    7: Result := '7 - PIS Não Retido, COFINS/CSLL Retidos';
    8: Result := '8 - PIS/COFINS Não Retidos, CSLL Retido';
    9: Result := '9 - COFINS Não Retido, PIS/CSLL Retidos';
  End;
end;

procedure TConexaoBD.pGetDadosEmpresa(ACodigoEmpresa: String);
var
  qryConsulta : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryConsulta := fCriaQuery(nil, FDatabase);
  Try
    Try
      qryConsulta.Close;
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('SELECT EMP_EMAIL_, EMP_FONE01, EMP_I_E_S_, EMP_FONE02, EMP_CNAEFI, EMP_INSMUN, EMP_CODCID, ');
      qryConsulta.SQL.Add('       EMP_NOMEMP, EMP_ENDERE, EMP_ENDNUM, EMP_BAIRRO, EMP_C_E_P_, EMP_ENDCMP, EMP_C_G_C_, ');
      qryConsulta.SQL.Add('       EMP_NOMFAN, EMP_HOMEPA                                                              ');
      qryConsulta.SQL.Add('  FROM CADEMP WHERE EMP_CODEMP = :CODEMP                                                   ');

      qryConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
      qryConsulta.Open;
    Except On e:Exception Do
      raise Exception.Create('Erro em consulta de dados da empresa de prestação de serviço. Erro:' + e.Message);
    End;

    FInfosNfsBd.strEmail    := Trim(qryConsulta.FieldByName('EMP_EMAIL_').AsString);
    FInfosNfsBd.strFone     := Trim(qryConsulta.FieldByName('EMP_FONE01').AsString);
    FInfosNfsBd.strInsEst   := Trim(qryConsulta.FieldByName('EMP_I_E_S_').AsString);
    FInfosNfsBd.strFone2    := Trim(qryConsulta.FieldByName('EMP_FONE02').AsString);
    FInfosNfsBd.strCNAE     := Trim(qryConsulta.FieldByName('EMP_CNAEFI').AsString);
    FInfosNfsBd.strIM       := Trim(qryConsulta.FieldByName('EMP_INSMUN').AsString);
    FInfosNfsBd.strRazSoc   := Trim(qryConsulta.FieldByName('EMP_NOMEMP').AsString);
    FInfosNfsBd.strEnder    := Trim(qryConsulta.FieldByName('EMP_ENDERE').AsString);
    FInfosNfsBd.strNume     := Trim(qryConsulta.FieldByName('EMP_ENDNUM').AsString);
    FInfosNfsBd.srtBairro   := Trim(qryConsulta.FieldByName('EMP_BAIRRO').AsString);
    FInfosNfsBd.strCidad    := fCampoTabela('CID_NOMCID', 'CADCID', ['CID_CODCID'], [qryConsulta.FieldByName('EMP_CODCID').AsString]);
    FInfosNfsBd.strCEP      := Trim(qryConsulta.FieldByName('EMP_C_E_P_').AsString);
    FInfosNfsBd.strUF       := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [qryConsulta.FieldByName('EMP_CODCID').AsString]);
    FInfosNfsBd.strCompl    := Trim(qryConsulta.FieldByName('EMP_ENDCMP').AsString);
    FInfosNfsBd.strCNPJ     := Trim(qryConsulta.FieldByName('EMP_C_G_C_').AsString);
    FInfosNfsBd.strFant     := Trim(qryConsulta.FieldByName('EMP_NOMFAN').AsString);
    FInfosNfsBd.strHomePage := Trim(qryConsulta.FieldByName('EMP_HOMEPA').AsString);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TConexaoBD.pGetDadosNfsBd(strCodEmp, strNumDoc, strEspDoc, strTip_Fc: String);
begin
  FillChar(FInfosNfsBd, SizeOf(FInfosNfsBd), #0);
  FInfosNfsBd.strNumDoc := strNumDoc;
  FInfosNfsBd.strEspDoc := strEspDoc;
  FInfosNfsBd.strCodEmp := strCodEmp;

  pGetDadosEmpresa(strCodEmp);
  pGetTomadorParaENotas(strNumDoc, strEspDoc, strCodEmp);
  pGetDiscriminacaoServico(strNumDoc, strEspDoc, strCodEmp, strTip_Fc);
end;

function TConexaoBD.fRetDescClassificacaoServico(strCodigo: string): string;
var
  qryClassificacao: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := EmptyStr;
  qryClassificacao := fCriaQuery;

  try
    qryClassificacao.Close;
    qryClassificacao.SQL.Clear;
    qryClassificacao.SQL.Add('SELECT CDS_DESCRI');
    qryClassificacao.SQL.Add('FROM CADCDS');
    qryClassificacao.SQL.Add('WHERE CDS_CDSERV = :CODIGO');

    qryClassificacao.ParamByName('CODIGO').AsString := AnsiReplaceStr(strCodigo, '.', '');

    qryClassificacao.Open;

    if (not qryClassificacao.IsEmpty) then
    begin
      Result := qryClassificacao.FieldByName('CDS_DESCRI').AsString;
    end;
  finally
    FreeAndNil(qryClassificacao);
  end;
end;

procedure TConexaoBD.pGetTomadorParaENotas(strNumDoc, strEspDoc,
  strCodEmp: String);
var
  qryConsulta : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryConsulta := fCriaQuery(nil, FDatabase);
  Try
    Try
      qryConsulta.Close;
      qryConsulta.SQL.Clear;

      qryConsulta.SQL.Add('SELECT                                         ');
      qryConsulta.SQL.Add('  MG.GER_IESCON AS I_E_S_,                     ');
      qryConsulta.SQL.Add('  CC.CLI_FONE01 AS FONE01,                     ');
      qryConsulta.SQL.Add('  CC.CLI_EMAIL_ AS EMAIL_,                     ');
      qryConsulta.SQL.Add('  CD.CID_ESTADO AS UFDEST,                     ');
      If (fCampoExiste('CADCLI', 'CLI_EMAIL2')) Then
        qryConsulta.SQL.Add('  CC.CLI_EMAIL2 AS EMAIL2,                   ')
      else
        qryConsulta.SQL.Add('  CAST("" AS CHAR(1)) AS EMAIL2,             ');
      qryConsulta.SQL.Add('  CC.CLI_I_M_P_ AS I_M_P_,                     ');
      qryConsulta.SQL.Add('  CC.CLI_CELULA AS CELULA,                     ');
      qryConsulta.SQL.Add('  CC.CLI_ENDCOM AS ENDCOM,                     ');
      qryConsulta.SQL.Add('  CD.CID_NOMCID AS NOMCID,                     ');
      qryConsulta.SQL.Add('  MG.GER_CONPAG AS CONPAG                      ');
      qryConsulta.SQL.Add('FROM                                           ');
      qryConsulta.SQL.Add('  MOVGER MG                                    ');
      qryConsulta.SQL.Add('  LEFT JOIN CADCID CD                          ');
      qryConsulta.SQL.Add('    ON CD.CID_CODCID = MG.GER_CIDCON           ');
      qryConsulta.SQL.Add('  LEFT JOIN CADCLI CC                          ');
      qryConsulta.SQL.Add('    ON CC.CLI_CODCLI = MG.GER_CODCLI           ');
      qryConsulta.SQL.Add('WHERE MG.GER_NUMDOC = :NUMDOC                  ');
      qryConsulta.SQL.Add('  AND MG.GER_ESPDOC = :ESPDOC                  ');
      qryConsulta.SQL.Add('  AND MG.GER_CODEMP = :CODEMP                  ');
      qryConsulta.SQL.Add('UNION                                          ');
      qryConsulta.SQL.Add('SELECT                                         ');
      qryConsulta.SQL.Add('  NG.GER_IESCON AS I_E_S_,                     ');
      qryConsulta.SQL.Add('  CC.CLI_FONE01 AS FONE01,                     ');
      qryConsulta.SQL.Add('  CC.CLI_EMAIL_ AS EMAIL_,                     ');
      qryConsulta.SQL.Add('  CD.CID_ESTADO AS UFDEST,                     ');
      If (fCampoExiste('CADCLI', 'CLI_EMAIL2')) Then
        qryConsulta.SQL.Add('  CC.CLI_EMAIL2 AS EMAIL2,                   ')
      else
        qryConsulta.SQL.Add('  CAST("" AS CHAR(1)) AS EMAIL2,             ');
      qryConsulta.SQL.Add('  CC.CLI_I_M_P_ AS I_M_P_,                     ');
      qryConsulta.SQL.Add('  CC.CLI_CELULA AS CELULA,                     ');
      qryConsulta.SQL.Add('  CC.CLI_ENDCOM AS ENDCOM,                     ');
      qryConsulta.SQL.Add('  CD.CID_NOMCID AS NOMCID,                     ');
      qryConsulta.SQL.Add('  NG.GER_CONPAG AS CONPAG                      ');
      qryConsulta.SQL.Add('FROM                                           ');
      qryConsulta.SQL.Add('  NOTGER NG                                    ');
      qryConsulta.SQL.Add('  LEFT JOIN CADCID CD                          ');
      qryConsulta.SQL.Add('    ON CD.CID_CODCID = NG.GER_CIDCON           ');
      qryConsulta.SQL.Add('  LEFT JOIN CADCLI CC                          ');
      qryConsulta.SQL.Add('    ON CC.CLI_CODCLI = NG.GER_CODCLI           ');
      qryConsulta.SQL.Add('WHERE NG.GER_NUMDOC = :NUMDOC                  ');
      qryConsulta.SQL.Add('  AND NG.GER_ESPDOC = :ESPDOC                  ');
      qryConsulta.SQL.Add('  AND NG.GER_CODEMP = :CODEMP;                 ');

      qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
      qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
      qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;

      qryConsulta.Open;
    Except On e:Exception Do
      raise Exception.Create('Erro ao consultar informações do tomador da NFS no BD!');
    End;

    FInfosNfsBd.strTomadorI_E_S_      := Trim(qryConsulta.FieldByName('I_E_S_').AsString);
    FInfosNfsBd.strTomadorEmail_      := Trim(qryConsulta.FieldByName('EMAIL_').AsString);
    FInfosNfsBd.strTomadorFone01      := Trim(qryConsulta.FieldByName('FONE01').AsString);
    FInfosNfsBd.strTomadorUF          := Trim(qryConsulta.FieldByName('UFDEST').AsString);
    FInfosNfsBd.strTomadorEmail2      := Trim(qryConsulta.FieldByName('EMAIL2').AsString);
    FInfosNfsBd.strTomadorIM          := Trim(qryConsulta.FieldByName('I_M_P_').AsString);
    FInfosNfsBd.strTomadorComplEnder  := Trim(qryConsulta.FieldByName('ENDCOM').AsString);
    FInfosNfsBd.strTomadorCelular     := Trim(qryConsulta.FieldByName('CELULA').AsString);
    FInfosNfsBd.strTomadorCidade      := Trim(qryConsulta.FieldByName('NOMCID').AsString);
    FInfosNfsBd.strConPag             := Trim(qryConsulta.FieldByName('CONPAG').AsString);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TConexaoBD.pGetModalidade(strNumDoc, strEspDoc, strCodEmp: String; out strModalidadeValor: String);
var
  qryConsulta : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryConsulta := fCriaQuery(nil, FDatabase);
  Try
    Try
      qryConsulta.Close;
      qryConsulta.SQL.Clear;

      qryConsulta.SQL.Add('SELECT                                               ');
      qryConsulta.SQL.Add('  MOD_NUMDOC,                                        ');
      qryConsulta.SQL.Add('  MOD_ESPDOC,                                        ');
      qryConsulta.SQL.Add('  GROUP_CONCAT(                                      ');
      qryConsulta.SQL.Add('    CONCAT(DESCRI, ": ", FORMAT(VALMOD, 2, "pt_BR")) ');
      qryConsulta.SQL.Add('    ORDER BY                                         ');
      qryConsulta.SQL.Add('      DESCRI SEPARATOR ", "                          ');
      qryConsulta.SQL.Add('  ) AS DESCRICAO                                     ');
      qryConsulta.SQL.Add('FROM                                                 ');
      qryConsulta.SQL.Add('  (                                                  ');
      qryConsulta.SQL.Add('    SELECT                                           ');
      qryConsulta.SQL.Add('      MOD_NUMDOC,                                    ');
      qryConsulta.SQL.Add('      MOD_ESPDOC,                                    ');
      qryConsulta.SQL.Add('      FPG_DESCRI AS DESCRI,                          ');
      qryConsulta.SQL.Add('      SUM(MOD_VALMOD) AS VALMOD                      ');
      qryConsulta.SQL.Add('    FROM                                             ');
      qryConsulta.SQL.Add('      MOVMOD                                         ');
      qryConsulta.SQL.Add('      INNER JOIN CADFPG ON FPG_CODIGO = MOD_CODMOD   ');
      qryConsulta.SQL.Add('    WHERE                                            ');
      qryConsulta.SQL.Add('      MOD_NUMDOC = :NUMDOC                           ');
      qryConsulta.SQL.Add('      AND MOD_ESPDOC = :ESPDOC                       ');
      qryConsulta.SQL.Add('      AND MOD_CODEMP = :CODEMP                       ');
      qryConsulta.SQL.Add('    GROUP BY                                         ');
      qryConsulta.SQL.Add('      MOD_NUMDOC,                                    ');
      qryConsulta.SQL.Add('      MOD_ESPDOC,                                    ');
      qryConsulta.SQL.Add('      FPG_DESCRI                                     ');
      qryConsulta.SQL.Add('  ) AS X                                             ');
      qryConsulta.SQL.Add('GROUP BY                                             ');
      qryConsulta.SQL.Add('  MOD_NUMDOC,                                        ');
      qryConsulta.SQL.Add('  MOD_ESPDOC;                                        ');

      qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
      qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
      qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;

      qryConsulta.Open;
    Except On e:Exception Do
      raise Exception.Create('Erro ao consultar informações de modalidades de pagamentos e valores! ' + e.Message);
    End;

    if not qryConsulta.IsEmpty then
      strModalidadeValor := '**'+Trim(qryConsulta.FieldByName('DESCRICAO').AsString)+'**'
    else
      strModalidadeValor := '';

  Finally
    FreeAndNil(qryConsulta);
  End;
end;

initialization
  VS_Desativa_eNotas := False;

finalization

end.

