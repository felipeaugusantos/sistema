unit untEditorFast;

interface

Uses
  StrUtils, SysUtils, Classes, Forms, Variants, Controls, Windows, Graphics,
  ExtCtrls, Contnrs, StdCtrls, frxDesgnCtrls, untReguaEditor, Uni, Dialogs,
  frxClass, untComponentMovel, DB, frxDBSet, untConstantes, untModuloFr3,
  frxBarCod, frxBarCode, UniClientDataSet, DateUtils, cxProgressBar, frxDMPClass,
  untTypesSistema, untOrdenacao, untFuncoesEditorFast, untTipoTinta, untDespacho,
  frxBarCode2D,
  Jpeg, TypesRel;

Type
  TarrFrxComps = Array Of TComponent;

  TEditorFast = Class(TComponent)
  Private
    FMarcaDagua : TJPEGImage;
    FLastCommand: String;
    FExpOn : Boolean;
    FViaPag: Boolean;
    FTipImp: String;
    FHerdar: Boolean;
    FCamTre: TUniQuery;
    FNomVar: String; // NOME DO COMPONENTE FR3
    FCodDoc: String;
    FParent: TfrxComponent;
    FModFr3: TfrmModuloFr3;
    FErrVal: Integer;
    FDescri: String;
    FOrdena: String;
    FPadrao: Boolean;
    FEtiEmp: Boolean;
    FDBIEti: TfrxDataset;
    FGpVePx: Double;
    FReport: TfrxReport;
    FEditor: TReguaEditor;
    FCmpMvl: TComponentMovel;
    FTabCam: TUniQuery;
    FCodEti: TTipoEtiqueta;
    FLayEti: TUniQuery;
    FObjOrd: TOrdenacao;
    FInfHei: String;
    FblnReformaPedidoCompra: Boolean; // layout do pedido de compra ja recebeu (ou ja tinha) a reforma

    frxHeader    : TfrxPageHeader;
    frxPage      : TfrxReportPage;
    frxPageVias  : TfrxReportPage;
    frxPageFooter: TfrxPageFooter;
    frxSummary   : TfrxReportSummary;
    frxHeaderData: TfrxHeader;
    frxMasterData: TfrxMasterData;
    frxFooterData: TfrxFooter;

    cmdHeader,
    cmdHeaderData,
    cmdFooterData,
    cmdPageFooter: TfrxDMPCommand;

    objListaHeader: TObjectList;

    blnConsideraPrecoEmbalagem: Boolean;
    blnPrecoVendaDifPorEmbalagem: Boolean;

    FMeiaFolha: String;

    Function fInsereBeforPrintBarCode(strFr3: String): String;
    Function fMontaScript: String;
    Function fRetNomArqFr3: String;

    Function fGetParent(fltTopOri: Double; Var fltTop: Double): TComponent;
    Function fGetParentJato(fltTopOri: Double; Var fltTop: Double): TComponent;
    Function fGetParentMatricial(fltTopOri: Double; Var fltTop: Double): TComponent;

    Function fParentEditor(fltTopOri: Double; Var fltTop: Double): TWinControl;
    Function fParentEditorJato(fltTopOri: Double; Var fltTop: Double): TWinControl;
    Function fParentEditorMatricial(fltTopOri: Double; Var fltTop: Double): TWinControl;

    Function fConverteLayout: Boolean;
    Function fCarregarPadrao: Boolean;
    Function fCarregarNaoPadrao: Boolean;
    Function fCarregaRegistro(blnPadrao: Boolean; strCodLay: String; blnConverter: Boolean = True): Boolean;
    Function fTemAlteracaoFr3(mmsRelat : TMemoryStream): Boolean;
    Function fCarregar(blnPadrao: Boolean; strCodLay: String = ''): Boolean;
    Function fSetaPagina: Boolean;
    Function fEditorToFast: Boolean;
    Function fSetaEtiqueta: Boolean;
    Function fCarregaPagina: Boolean;
    Function fCarregaEtiqueta: Boolean;
    Function fExpressaoEditorToFast(strCampo: String; blnColche: Boolean = True): String;
    Function fCampoEditorToFast(strCampo: String): String;
    Function fExprToFast(layCmpMvl: TLayStaticText): String;

    Function fRetfrxPage: TfrxReportPage;
    Function fRetfrxMasterData: TfrxMasterData;
    Function fRetfrxMasterDataVias: TfrxMasterData;


    function fRetSQLAbreItens(intTabPre: Integer = 0;
                               blnTesteL: Boolean = False;
                               strTabela: String = '';
                               strLisReg: String = '';
                               intTabPra: Integer = 0;
                               intParcel: Integer = 1;
                               strValAcr: String = '1';
                               strValDes: String = '1';
                               strCodEmp: String = '';
                               strDtaPro: String = '';
                               blnEtiNFe: boolean = false;
                               strTipoAlter: Integer = 0;
                               TipoOrigemEtiquetaAbreItens: TTipoOrigemEtiquetaAbreItens = toeabiOutros;
                               blnPrePro: boolean = True;
                               strCodIte: String = '';
                               strCodCnd: String = '';
                               strCndDes: String = '';
                               strNumPar: String = '';
                               blnImpGrp: Boolean = False;
                               strLisRegGrupoPreco: String = ''):String;

    Function fRetfrxPageVias: TfrxReportPage;

    Function fRetfrxHeader: TfrxPageHeader;
    Function fRetfrxHeaderData: TfrxHeader;

    Function fRetfrxFooterData: TfrxFooter;
    Function fRetfrxPageFooter: TfrxPageFooter;
    Function fRetfrxSummary   : TfrxReportSummary;

    function fCamposToEditor(pgbProgresso: TcxProgressBar): Boolean;

    Function fCriaMemoView(winParent: TComponent): TfrxCustomMemoView;

    Function fTipoEtiquetaToEspecie: String;

    Function fColunaCommand(colColuna: TColMatricial): Integer;

    Procedure pBeforeEventPreview;
    Procedure pTextoToFast(layCmpMvl: TLayStaticText; intIndice: Integer);
    Procedure pBarCodeToFast(layCmpMvl: TLayStaticText);
    Procedure pQRCODEToFast(layCmpMvl: TLayStaticText);
    Procedure pImagemToFast(layCmpMvl: TLayStaticText);
    Procedure pCamposToFast;
    Procedure pCamposToEditor;

    Procedure pZebraToFast;
    Procedure pHeaderToFast;
    Procedure pFooterToFast;
    Procedure pSummaryToFast;

    Procedure pCriaCommand(Var frxCommand: TfrxDMPCommand;
                               frxPai: TComponent;
                               strCommand: String;
                               intLinha,
                               intColuna: Double;
                               blnMudaColuna: Boolean);

    Procedure pCriaFormatacao(colFonte: TcolMatricial;
                              Var frxCommand: TfrxDMPCommand;
                              frxPai: TComponent;
                              intLinha,
                              intColuna: Double;
                              blnMudaColuna: Boolean);

    Procedure pCriaMensagemContinuaProximaPagina;

    Procedure pHeaderDataToFast;
    Procedure pHeaderDataCorFast;

    Procedure pFooterDataToFast;
    Procedure pFooterDataCorFast;

    Procedure pMolduraToFast;

    Procedure pTextoToEditor(frxCampo: TfrxCustomMemoView);
    Procedure pBarCodeToEditor(frxBarCod: TfrxBarCodeView);
    Procedure pQRCodeToEditor(frxBarCod: TfrxBarCode2DView);
    Procedure pImagemToEditor(frxImagem: TfrxPictureView);

    Procedure pAtualizaNaoPadrao;
    Procedure pAbreLayouts(qryTabLay: TUniQuery);
    Procedure pCriaBaseReport;

    Procedure pFormataHeader(Var colFonteAnt: TColMatricial);
    Procedure pFormataHeaderData(Var colFonteAnt: TColMatricial);
    Procedure pFormataFooterData(Var colFonteAnt: TColMatricial);
    Procedure pFormataPageFooter(Var colFonteAnt: TColMatricial);
    Procedure pFormataSummary(Var colFonteAnt: TColMatricial);

    Function fExisteCampo(strCampo: String): Boolean;

    Function  fVerificaExpressao(    strExpFr3: String;
                                 Var strCodCam,
                                     strCaption: String;
                                 Var tcmTipCam: TTipoCampoEditor): Boolean;

    Procedure pInsereRegistro(mmsRelat : TMemoryStream;
                              blnPadraoP: Boolean = False;
                              blnConver: Boolean = False);

    Procedure pAjustaFr3;

    Procedure pHeaderToEditor(frxHeader: TfrxPageHeader);
    Procedure pHeaderDataToEditor(frxHeaderData: TfrxHeader);

    Procedure pFooterToEditor(frxPageFooter: TfrxPageFooter);

    Procedure pSummaryToEditor(frxSummary: TfrxReportSummary);

    Procedure pFooterDataToEditor(frxFooterData: TfrxFooter);

    Procedure pConverteImagemTinta;
    Procedure pConverteFormulacaoTinta;

    procedure pShowPreview(cdsDados: TDataSet);

    Procedure pMudaFontePagina(colFonte: TColMatricial);

    procedure pSetaVar(strNomVar: String; varValor: Variant);    

    function fLoteCriptografado: String;
    function fDiaSemanaAlfabeto: String;
    procedure pAbreLocFisPreview(qryEtique: TUniQuery);
    procedure pAbrePlanoRecebPreview(qryEtique: TUniQuery);
    procedure pAbreSeqSeparacaoWMSPreview(qryEtique: TUniQuery);
    procedure pAbreEtiqQtdFracionada(qryEtique: TUniQuery);
    procedure pAbreEtiqID(qryEtique: TUniQuery);

  Public

    FPreviw: TUniClientDataSet;

    constructor Create(Owner: TComponent;
                       PEditor: TReguaEditor;
                       PCmpMvl: TComponentMovel;
                       tpeCodEti: TTipoEtiqueta;
                       strTipImp: String = 'J'); reintroduce; Overload;

    constructor Create(Owner: TComponent;
                       frxReport: TfrxReport;
                       frxDBIEti: TfrxDataset;
                       tpeCodEti: TTipoEtiqueta;
                       strTipImp: String = 'J'); reintroduce; Overload;

    Destructor  Destroy; Override;

    Function fExcluiLayout: Boolean;
    Function fSalvaArquivo(blnPadrao: Boolean = False;
                           blnConfir: Boolean = False): Boolean;
    Function fCarregarLayout(blnPadrao: Boolean = False; strCodLayDoc: String = ''; blnChamadaPeloMenu: Boolean = False): Boolean;
    Function fValidaLayout: Boolean;
    Function fLeEtiqueta(blnPadrao: Boolean = True; strCodLay: String = ''): Boolean;

    Function fPedeDadosDocumento(Var strEspDoc, strNumDoc, strCodCli, strCodEmp, strSerie: String): Boolean;
    function fPedeDadosFiltroSeparacaoGondola(var ASeparacaoGondolaFiltro: TSeparacaoGondolaFiltro): Boolean;
    Function fAbreDocPreview(strEspDoc: String; Var strNumDoc, strCodCli: String; tpaTipoArquivo: TTipoArquivo = tpaNormal): Boolean;

    Function fHerdaLayout(qryTabela: TUniQuery): Boolean;

    Function fTemParametro(strNomPar: String): Boolean;

    Function fSQLFuncionario(blnClient: Boolean; intQtdEti: Integer = 0): String;
    function fSQLFiltroGrupoCampos(intCodEti: Integer): String;

    function fCarregarMarcaDagua : Boolean;
    function fTemMarcaDAgua : Boolean;

    procedure pAbreDefCampos(qryTabCam: TUniQuery; strFilCampos: String = '');
    procedure pAbreCamposTree;
    procedure pNovoLayout(blnRefresh: Boolean = True);

    Procedure pGeraPDF;

    Procedure pPreview(tpaTipoArquivo: TTipoArquivo = tpaNormal);

    Procedure pSetaInfoCodBar(strInfoBar: String);
    procedure pAbrePreview(tpaTipoArquivo: TTipoArquivo = tpaNormal; strNomArq: String = '');

    procedure pPedeOrdenacao;

    Procedure pMudaFontePaginaPrincipal;
    procedure pAbreEtiquetaDoProdutoSeparado(qryEtique: TUniQuery);
    procedure pAbreCliente(qryEtique: TUniQuery; blnEndCob: Boolean; strCamBus: String; blnTesteL: Boolean = False; strLisReg: String = ''; intQtdEti: Integer = 0; ACliente: String = '');
    procedure pAbreFuncionario(qryEtique: TUniQuery; strCamBus: String; blnTesteL: Boolean = False; strLisReg: String = ''; intQtdEti: Integer = 0);
    procedure pAbreFornecedor(qryEtique: TUniQuery; blnTesteL: Boolean = False);
    procedure pAbreDiversos(qryEtique: TUniQuery; blnTesteL: Boolean = False);
    procedure pAbreEstrutura(qryEtique: TUniQuery; blnTesteL: Boolean = False);
    procedure pAbreOperador(qryEtique: TUniQuery; blnTesteL: Boolean = False);
    procedure pAbreItens(qryEtique: TUniQuery;
                         intTabPre: Integer = 0;
                         blnTesteL: Boolean = False;
                         strTabela: String = '';
                         strLisReg: String = '';
                         intTabPra: Integer = 0;
                         intParcel: Integer = 1;
                         strValAcr: String = '1';
                         strValDes: String = '1';
                         strCodEmp: String = '';
                         strDtaPro: String = '';
                         blnEtiNFe: boolean = false;
                         strTipoAlter: Integer = 0;
                         TipoOrigemEtiquetaAbreItens: TTipoOrigemEtiquetaAbreItens = toeabiOutros;
                         blnPrePro: boolean = True;
                         strCodIte: String = '';
                         strCodCnd: String = '';
                         strCndDes: String = '';
                         strNumPar: String = '';
                         blnImpGrp: Boolean = False;
                         strLisRegGrupoPreco: String = '');
    procedure pAbreItensOrcPed(qryEtique: TUniQuery; blnTesteL: Boolean; strNumDoc: String = ''; strEspDoc: String = ''; strCodEmp: String = ''; strImprme: String = ''; strOrder : String = '');

    procedure pAbreDespacho(qryEtique : TUniQuery;
                            blnTesteL : Boolean;
                            strNomTab : String  = 'MOVGER';
                            strTipoFC : String  = 'C';
                            strNumDoc : String  = '';
                            strEspDoc : String  = '';
                            blnSigep  : Boolean = False;
                            strCodEmp : String  = '';
                            blnB2W    : Boolean = False;
                            strCodCli : String  = '';
                            strMultPed: String = '');

    procedure pAbreDespachoProduto(qryEtique : TUniQuery;
                                   blnTesteL : Boolean;
                                   strNomTab : String  = 'MOVGER';
                                   strTipoFC : String  = 'C';
                                   strNumDoc : String  = '';
                                   strEspDoc : String  = '';
                                   strCodEmp : String  = '');

    procedure pAbreEntregaTintaMaquina(qryEtique: TUniQuery;
                                       strAutInc,
                                       strNumDoc,
                                       strEspDoc: String;
                                       tptTipTin: TTipoTinta;
                                       prmDllEtq: TParamDllEtiquetas;
                                       blnTesteL: Boolean = False);
    Procedure pAbreFormulacaoTinta(ftiDadosEtiq: TFormulEtiq; prmDllEtq: TParamDllEtiquetas);
    Procedure pAbreFormulacaoTintaPreview;
    Procedure pAbreProducaoTinta(ftiDadosEtiq: TFormulEtiq);
    Procedure pCriaClientFormulacao(Var cdsDadEti: TUniClientDataSet);
    Procedure pCriaClientProducaoTinta(Var cdsDadEti: TUniClientDataSet);
    procedure pAbreEntregaTintaMaquinaPreview;
    procedure pAbreOrdemProducaoIndustrialPreview(qryEtique: TUniQuery);
    procedure pAbreArmazenamentoPreview(qryEtique: TUniQuery);
    procedure pAbreEmpresaPreview(qryEtique: TUniQuery);
    procedure pAbreOrdemProducao(qryEtique: TUniQuery; blnTesteL : boolean = False; strCodPro : String = ''; strCodEmp : ShortString = '');
    procedure pAbreItensCPFPreview;
    Procedure pAbreUnidadesRestantesPreview(qryEtique: TUniQuery);
    procedure pAbreProducaoTintaMaquinaPreview;
    procedure pAbreSepErrPreview(qryEtique: TUniQuery);
    procedure pAbreCodBarrasProdutoPreview(qryEtique: TUniQuery);
    Procedure pAbreOs(qryEtique: TUniQuery;
                      blnTesteL: Boolean = False;
                      strNumDoc: String = '';
                      strCodEmp: String = '');
    Procedure pAbreOsVenda(qryEtique: TUniQuery;
                           blnTesteL: Boolean = False;
                           strNumOrd: String = '';
                           strCodEmp: String = '');

    procedure pAbreLoteProdutoMarmoreTeste(qryEtique: TUniQuery);
    procedure pAbreLoteProduto(qryEtique: TUniQuery;
                               blnTesteL: Boolean = False;
                               blnAbrirQuery: Boolean = True;
                               strLimit: string = '30';
                               strLoteAutInc: string = '';
                               strCodEmp: String = '';
                               strValAcr: string = '';
                               strValDes: string = '';
                               intParcel: Integer = 1;
                               intTabPre: Integer = 1;
                               intTabPra: integer = 1;
                               blnLoteMarmore: Boolean = False;
                               strForceFiltro: String = '';
                               strChaveTemporariaLotMarmore: String = '';
                               strQtdEmb: String = '');

    procedure pAbreRastreamentoProduto(qryEtique: TUniQuery;
                                       blnTesteL: Boolean = False;
                                       blnAbrirQuery: Boolean = True;
                                       strLimit: string = '30';
                                       strLoteAutInc: string = '');

    Function fRetIdeProDoc(strAutInc, strEspDoc : String ) : String;
    procedure pAbreCaixas(qryEtique: TUniQuery; blnTesteL: Boolean = False);
    procedure pAbreMontagemCaixas(qryEtique: TUniQuery; blnTesteL: Boolean = False);
    procedure pAbreMontagemCaixasCodBarras(qryEtique: TUniQuery; blnTesteL: Boolean = False);
    procedure pAbreMontagemCaixasPackList(qryEtique: TUniQuery; blnTesteL: Boolean = False);
    procedure pAbreLocalArmazenamentoWMSPreview(qryEtique: TUniQuery);
    procedure pAbreRegiaoPreview(qryEtique: TUniQuery);
    procedure pAbreProdutosControladosPreview(qryEtique: TUniQuery);
  published

    Property blnPadrao: Boolean       Read FPadrao;
    Property blnEtiEmp: Boolean       Read FEtiEmp;
    Property strDescri: String        Read FDescri Write FDescri;
    Property intErrVal: Integer       Read FErrVal;
    Property frmModFr3: TfrmModuloFr3 Read FModFr3 Write FModFr3;
    Property strCodDoc: String        Read FCodDoc;
    Property qryCamTre: TUniQuery       Read FCamTre;

  End;

const
  cnstEspTinDet: String = 'NF_IF_PA_EP_FF_UC_';

implementation

uses
 untSelecionaLayout, untPedeOrdenacao, untGravando, untPedeMIFF, untLeDocumento,
  untFuncoesSimples, Math, untEtiquetasItemCPF, untFuncoesConsulta, untFuncoesImagem,
  untPedeDadosSeparacaoGondola;

constructor TEditorFast.Create(Owner: TComponent;
                               PEditor: TReguaEditor;
                               PCmpMvl: TComponentMovel;
                               tpeCodEti: TTipoEtiqueta;
                               strTipImp: String = 'J');
begin
  Inherited Create(Nil); //Owner

  FMarcaDagua := TJPEGImage.Create;
  FTipImp := strTipImp;
  FHerdar := False;
  FCodDoc := '';
  FErrVal := 0;
  FPadrao := False;
  FEtiEmp := fCfgSis('ETIEMP', varBoolean);
  FCodEti := tpeCodEti;
  FEditor := PEditor;

  FCmpMvl := PCmpMvl;

  FTabCam := fCriaQuery(Nil);
  FCamTre := fCriaQuery(Nil);
  FLayEti := fCriaQuery(Nil);

  pAbreDefCampos(FTabCam);

  pAbreCamposTree;

  FModFr3 := Nil;
  pCriaBaseReport;

  cmdHeader     := Nil;
  cmdHeaderData := Nil;
  cmdFooterData := Nil;
  cmdPageFooter := Nil;

  FObjOrd       := Nil;

  objListaHeader := TObjectList.Create(False);

  blnConsideraPrecoEmbalagem := fCfgSis('CPREMB', varBoolean);
  blnPrecoVendaDifPorEmbalagem := fCfgSis('PRVEMB', varBoolean);

end;

constructor TEditorFast.Create(Owner: TComponent;
                               frxReport: TfrxReport;
                               frxDBIEti: TfrxDataset;
                               tpeCodEti: TTipoEtiqueta;
                               strTipImp: String = 'J');
Begin
  Inherited Create(Nil); //Owner
  FEtiEmp := fCfgSis('ETIEMP', varBoolean);
  FEditor := Nil;
  FTipImp := strTipImp;
  FHerdar := False;
  FCodDoc := '';
  FLayEti := fCriaQuery(Self);
  FDBIEti := frxDBIEti;
  FReport := frxReport;
  FCodEti := tpeCodEti;

  cmdHeader     := Nil;
  cmdHeaderData := Nil;
  cmdFooterData := Nil;
  cmdPageFooter := Nil;

  FObjOrd       := Nil;

  objListaHeader := TObjectList.Create(False);

  blnConsideraPrecoEmbalagem := fCfgSis('CPREMB', varBoolean);
  blnPrecoVendaDifPorEmbalagem := fCfgSis('PRVEMB', varBoolean);

End;

Destructor TEditorFast.Destroy;
begin
  FreeAndNil(objListaHeader);

  FreeAndNil(FTabCam);
  FreeAndNil(FCamTre);
  FreeAndNil(FLayEti);

  If Assigned(FObjOrd) Then
    FreeAndNil(FObjOrd);

  inherited;
end;

Procedure TEditorFast.pCriaBaseReport;
Begin
  If Assigned(FModFr3) Then
    FreeAndNil(FModFr3);

  FModFr3 := TfrmModuloFr3.Create(Self);

  If FTipImp = 'J' Then
  Begin

    If FEditor.blnViaPag Then
      FReport := FModFr3.frxReportVias
    Else
      FReport := FModFr3.frxRepor;

  End Else
    FReport := FModFr3.frxReporM;

  If FCodEti = tpeEntregaTintaMaquina Then
  Begin
    frxMasterData := fRetfrxMasterData;
    FreeAndNil(frxMasterData);
  End;
End;

Function TEditorFast.fEditorToFast: Boolean;
  Var colFonteAnt: TColMatricial;
Begin
  If Assigned(FEditor) Then
    FViaPag := FEditor.blnViaPag;

  FCmpMvl.pLimpaSelecao;

  Result := False;

  pCriaBaseReport;

  FGpVePx := FEditor.fltGpVrPx;

  If Not fSetaPagina Then
    Exit;

  If Not fSetaEtiqueta Then
    Exit;

  pCamposToFast;

  If (FEditor.tplTipLay = tplDocumentos) Then
  Begin

    pFormataHeader(colFonteAnt);
    pFormataHeaderData(colFonteAnt);

    If Assigned(frxSummary) Then
    Begin
      pFormataSummary(colFonteAnt);
    End Else
    Begin
      pFormataFooterData(colFonteAnt);
      pFormataPageFooter(colFonteAnt);
    End;

  End;

  Result := True;

End;

Procedure TEditorFast.pHeaderToFast;
  Var
    frxCommand: TfrxDMPCommand;
    frxComman2: TfrxDMPCommand;
    frxComman3: TfrxDMPCommand;
    frxComman4: TfrxDMPCommand;
Begin
  frxCommand := Nil;
  frxComman2 := Nil;
  frxComman3 := Nil;
  frxComman4 := Nil;

  With FEditor, dadMargem, ppzPapSiz  Do
  Begin
    frxHeader := fRetfrxHeader;

    If blnHeader Then
    Begin

      If Not Assigned(frxHeader) Then
      Begin
        frxMasterData    := fRetfrxMasterData;

        frxHeader        := TfrxPageHeader.Create(frxPage);
        frxHeader.Name   := 'frxPageHeader';
        frxHeader.Top    := 0;

        cmdHeader        := Nil;
        cmdHeaderData    := Nil;

        frxHeader.Parent := frxPage;
        frxHeader.Height := fCmColunaToPixel(fltHeaAlt, True, FTipImp, False);

        If FTipImp = 'M' Then
        Begin
          frxCommand        := TfrxDMPCommand.Create(frxHeader);
          frxCommand.Top    := 0;
          frxCommand.Left   := 1;
          frxCommand.Height := fCmColunaToPixel(1, True, 'M');
          frxCommand.Width  := fCmColunaToPixel(1, False, 'M');
          frxCommand.Parent := frxHeader;

          frxComman2        := TfrxDMPCommand.Create(frxHeader);
          frxComman2.Top    := 0;
          frxComman2.Left   := fCmColunaToPixel(10, False, 'M');
          frxComman2.Height := fCmColunaToPixel(1, True, 'M');
          frxComman2.Width  := fCmColunaToPixel(1, False, 'M');
          frxComman2.Parent := frxHeader;

          frxComman3        := TfrxDMPCommand.Create(frxHeader);
          frxComman3.Top    := 0;
          frxComman3.Left   := fCmColunaToPixel(20, False, 'M');
          frxComman3.Height := fCmColunaToPixel(1, True, 'M');
          frxComman3.Width  := fCmColunaToPixel(1, False, 'M');
          frxComman3.Parent := frxHeader;

          frxComman4        := TfrxDMPCommand.Create(frxHeader);
          frxComman4.Top    := 0;
          frxComman4.Left   := fCmColunaToPixel(30, False, 'M');
          frxComman4.Height := fCmColunaToPixel(1, True, 'M');
          frxComman4.Width  := fCmColunaToPixel(8, False, 'M');
          frxComman4.Parent := frxHeader;
        End;
      End;

      If FTipImp = 'M' Then
      Begin

        If intPapCur In [4..7] Then  // MEIA FOLHA
        Begin

          If Assigned(frxCommand) Then
          Begin
            frxCommand.Width  := fCmColunaToPixel(Length(ppzPapSiz.FArrPpz[intPapCur].strComand), False, 'M');

            If (intPapCur = fIndiceCustom(FTipImp)) Then
            Begin

              If intLinCommand > 0 Then
                frxCommand.Command := String('#27#64#27#67#' + IntToStr(intLinCommand))
              Else
                frxCommand.Command := String('#27#64#27#67#' + IntToStr(Trunc(ppzPapSiz.fltCusHei)));

            End Else
              frxCommand.Command := String(ppzPapSiz.FArrPpz[intPapCur].strComand);
          End;

          If Assigned(frxComman2) Then
          Begin
            frxComman2.Width  := fCmColunaToPixel(Length(ppzPapSiz.FArrPpz[intPapCur].strComan2), False, 'M');
            frxComman2.Command := String(ppzPapSiz.FArrPpz[intPapCur].strComan2);
          End;

          If Assigned(frxComman3) Then
          Begin
            frxComman3.Width   := fCmColunaToPixel(Length(ppzPapSiz.FArrPpz[intPapCur].strComan3), False, 'M');

            If (intPapCur = fIndiceCustom(FTipImp)) And (intEspaca = 0) Then
              frxComman3.Command := String('#27#50'){1/6}
            Else
              frxComman3.Command := String(ppzPapSiz.FArrPpz[intPapCur].strComan3);
          End;

        End Else // FOLHA INTEIRA
        Begin

          If Assigned(frxCommand) Then
          Begin
            frxCommand.Width   := fCmColunaToPixel(Length(ppzPapSiz.FArrPpz[intPapCur].strComan3), False, 'M');

            If (intPapCur = fIndiceCustom(FTipImp)) And (intEspaca = 0) Then
              frxCommand.Command := String('#27#64#27#50'){ RESETA + 1/6}
            Else
              frxCommand.Command := String(ppzPapSiz.FArrPpz[intPapCur].strComan3);
          End;

          If Assigned(frxComman2) Then
          Begin
            frxComman2.Width  := fCmColunaToPixel(Length(ppzPapSiz.FArrPpz[intPapCur].strComan2), False, 'M');
            frxComman2.Command := String(ppzPapSiz.FArrPpz[intPapCur].strComan2);
          End;

          If Assigned(frxComman3) Then
          Begin
            frxComman3.Width  := fCmColunaToPixel(Length(ppzPapSiz.FArrPpz[intPapCur].strComand), False, 'M');

            If (intPapCur = fIndiceCustom(FTipImp)) Then
            Begin

              If intLinCommand > 0 Then
                frxComman3.Command := String('#27#67#' + IntToStr(intLinCommand))
              Else
                frxComman3.Command := String('#27#67#' + IntToStr(Trunc(ppzPapSiz.fltCusHei)));

            End Else
              If Pos('#27#50', frxCommand.Command) > 0 Then
                frxComman3.Command := String('#27#67#65')
              Else
                frxComman3.Command := String(ppzPapSiz.FArrPpz[intPapCur].strComand);
          End;

        End;

        If Assigned(frxComman4) Then
        Begin
          frxComman4.Command := '#27#87#48#18#27#80';
        End;


      End;

      frxHeader.Parent := frxPage;

      frxHeader.Height := fCmColunaToPixel(fltHeaAlt, True, FTipImp, False);

      frxHeader.Top := 0;

    End

    Else If Assigned(frxHeader) Then
         Begin
           FreeAndNil(frxHeader);
           cmdHeader := Nil;
           cmdHeaderData   := Nil;
         End;

  End;
End;

Function TEditorFast.fCriaMemoView(winParent: TComponent): TfrxCustomMemoView;
Begin
  If FTipImp = 'J' Then
    Result := TfrxMemoView.Create(winParent)
  Else
  Begin
    Result := TfrxDMPMemoView.Create(winParent);
    (Result As TfrxDMPMemoView).TruncOutboundText := True;
  End;  
End;

Procedure TEditorFast.pHeaderDataCorFast;
  Var
    frxCampo : TfrxCustomMemoView;
    fltAjuModEsq: Double;
Begin
  frxCampo := fCriaMemoView(frxHeaderData);

  With frxCampo Do
  Begin
    Name     := 'mmoCorHeaderData';
    Parent   := TfrxComponent(frxHeaderData);

    If FEditor.blnMolEsq Then
      fltAjuModEsq := FEditor.intMolLar
    Else
      fltAjuModEsq := 0;

    Width    := FEditor.fltLarEPx - fltAjuModEsq;
    Height   := fCmColunaToPixel(FEditor.fltHeaDataAlt, True, FTipImp, False);
    Top      := 0;
    Left     := fltAjuModEsq;

    Align := baClient;

    Color    := FEditor.clrHeaderDataCor;

    If Color = clWhite Then
      Color := clNone;

    Frame.Width := FEditor.intHeaderDataMol;
    Frame.Typ   := [];
    
    If FEditor.intHeaderDataMol > 0 Then
    Begin
      Frame.Typ := Frame.Typ + [ftTop];
      Frame.Typ := Frame.Typ + [ftBottom];
      Frame.Typ := Frame.Typ + [ftLeft];
      Frame.Typ := Frame.Typ + [ftRight];
    End;

  End;
End;

Procedure TEditorFast.pFooterDataCorFast;
  Var
    frxCampo : TfrxCustomMemoView;
    fltAjuModEsq: Double;
Begin
  frxCampo := fCriaMemoView(frxFooterData);

  With frxCampo Do
  Begin
    Name     := 'mmoCorFooterData';
    Parent   := TfrxComponent(frxFooterData);

    If FEditor.blnMolEsq Then
      fltAjuModEsq := FEditor.intMolLar
    Else
      fltAjuModEsq := 0;

    Width    := FEditor.fltLarEPx - fltAjuModEsq;
    Height   := fCmColunaToPixel(FEditor.fltFooDataAlt, True, FTipImp, False);
    Top      := 0;
    Left     := fltAjuModEsq;

    Align := baClient;

    Color    := FEditor.clrFooterDataCor;

    If Color = clWhite Then
      Color := clNone;

    Frame.Width := FEditor.intFooterDataMol;
    Frame.Typ   := [];

    If FEditor.intFooterDataMol > 0 Then
    Begin
      Frame.Typ := Frame.Typ + [ftTop];
      Frame.Typ := Frame.Typ + [ftBottom];
      Frame.Typ := Frame.Typ + [ftLeft];
      Frame.Typ := Frame.Typ + [ftRight];
    End;

  End;
End;

Procedure TEditorFast.pHeaderDataToFast;
Begin
  With FEditor, dadMargem, ppzPapSiz  Do
  Begin
    frxHeaderData := fRetfrxHeaderData;

    If blnHeaderData Then
    Begin
      If Not Assigned(frxHeaderData) Then
      Begin
        frxMasterData := fRetfrxMasterData;

        If Assigned(frxMasterData) Then
          FreeAndNil(frxMasterData);

        frxHeaderData := TfrxHeader.Create(frxPage);
        frxHeaderData.Name := 'HeaderData1';
        frxHeaderData.ReprintOnNewPage := True;
        frxHeaderData.Top := 0;


        frxHeaderData.Parent := frxPage;
        frxHeaderData.Height := fCmColunaToPixel(fltHeaDataAlt, True, FTipImp, False);

        If (FTipImp = 'J') And
           ((clrHeaderDataCor <> clNone) Or (clrHeaderDataCor <> clWhite) Or (intHeaderDataMol > 0)) Then
          pHeaderDataCorFast;

        frxMasterData := TfrxMasterData.Create(frxPage);
        frxMasterData.Name := 'MasterData1';
      End;

      frxHeaderData.Parent := frxPage;
      frxHeaderData.Height := fCmColunaToPixel(fltHeaDataAlt, True, FTipImp, False);
      frxHeaderData.Top := 0;

      If Assigned(frxMasterData) Then
        frxMasterData.Top := frxHeaderData.Height + 1;
    End

    Else If Assigned(frxHeaderData) Then
         Begin
           FreeAndNil(frxHeaderData);
         End;

  End;
End;

Procedure TEditorFast.pFooterToFast;
Begin
  With FEditor, dadMargem, ppzPapSiz  Do
  Begin
    frxPageFooter := fRetfrxPageFooter;

    If blnFooter And ((Not blnImpUlt) Or blnFooBra) Then
    Begin

      If Not Assigned(frxPageFooter) Then
      Begin
        frxPageFooter         := TfrxPageFooter.Create(frxPage);
        frxPageFooter.Name    := 'PageFooter';
      End;

      frxPageFooter.Parent := frxPage;
      frxPageFooter.Height := fCmColunaToPixel(fltFooAlt, True, FTipImp, False);

      frxPageFooter.PrintOnLastPage := Not blnFooBra;

    End Else
    Begin

      If Assigned(frxPageFooter) Then
        FreeAndNil(frxPageFooter);

      If (FEditor.tplTipLay = tplDocumentos) Then
        pCriaMensagemContinuaProximaPagina;

    End;
  End;
End;

Procedure TEditorFast.pCriaMensagemContinuaProximaPagina;
  Var
    frxPageFooterProx: TfrxPageFooter;
    frxMemoView: TfrxDMPMemoView;
    frxMemoViewJ: TfrxMemoView;
Begin
  If Not Assigned(FEditor) Then
    Exit;
    
  If Not FEditor.blnConPro Then
    Exit;

  frxPageFooterProx := fRetfrxPageFooter;

  If Not Assigned(frxPageFooterProx) Then
  Begin
    frxPageFooterProx         := TfrxPageFooter.Create(frxPage);
    frxPageFooterProx.Name    := 'PageFooterProx';

    frxPageFooterProx.Parent := frxPage;

    If FTipImp = 'M' Then
    Begin

      frxPageFooterProx.Height := fCmColunaToPixel(1, True, FTipImp, False);
      frxPageFooterProx.PrintOnLastPage := False;

      frxMemoView := TfrxDMPMemoView.Create(frxPageFooterProx);
      frxMemoView.Name   := 'MemoFooterProx';
      frxMemoView.Height := fCmColunaToPixel(1, True, FTipImp, False);
      frxMemoView.Parent := frxPageFooterProx;
      frxMemoView.AutoWidth := True;
      frxMemoView.Text := 'IMPRESSAO CONTINUA NA PROXIMA PAGINA...';
      frxMemoView.Top  := 0;
      frxMemoView.Left := 0;

    End Else
    Begin

      frxPageFooterProx.Height := fCmColunaToPixel(0.5, True, FTipImp, False);
      frxPageFooterProx.PrintOnLastPage := False;

      frxMemoViewJ := TfrxMemoView.Create(frxPageFooterProx);
      frxMemoViewJ.Name   := 'MemoFooterProx';
      frxMemoViewJ.Height := fCmColunaToPixel(0.5, True, FTipImp, False);
      frxMemoViewJ.Parent := frxPageFooterProx;
      frxMemoViewJ.AutoWidth := True;
      frxMemoViewJ.Text := 'IMPRESSÃO CONTINUA NA PRÓXIMA PÁGINA...';
      frxMemoViewJ.Top  := 0;
      frxMemoViewJ.Left := 0;
    End;

  End;

End;

Procedure TEditorFast.pSummaryToFast;
Begin
  With FEditor, dadMargem, ppzPapSiz  Do
  Begin
    frxSummary := fRetfrxSummary;

    If blnFooter And FEditor.blnImpUlt Then
    Begin

      If Not Assigned(frxSummary) Then
      Begin
        frxSummary        := TfrxReportSummary.Create(frxPage);
        frxSummary.Name   := 'Summary';
        frxSummary.Height := fCmColunaToPixel(fltFooAlt, True, FTipImp, False);
      End;

      frxSummary.Parent := frxPage;
    End

    Else If Assigned(frxSummary) Then
           FreeAndNil(frxSummary);
  End;
End;

Procedure TEditorFast.pFooterDataToFast;
Begin
  With FEditor, dadMargem, ppzPapSiz  Do
  Begin
    frxFooterData := fRetfrxFooterData;

    If blnFooterData Then
    Begin
      If Not Assigned(frxFooterData) Then
        frxFooterData := TfrxFooter.Create(frxPage);
      frxFooterData.Parent := frxPage;
      frxFooterData.Name   := 'Footer';
      frxFooterData.Height := fCmColunaToPixel(fltFooDataAlt, True, FTipImp, False);
      frxFooterData.Top    := frxPage.Height;

      If (FTipImp = 'J') And
         ((clrFooterDataCor <> clNone) Or (clrFooterDataCor <> clWhite) Or (intFooterDataMol > 0)) Then
       pFooterDataCorFast;

    End

    Else If Assigned(frxFooterData) Then
           FreeAndNil(frxFooterData);
  End;
End;

Procedure TEditorFast.pMolduraToFast;
Begin
  With FEditor, dadMargem, ppzPapSiz  Do
  Begin
    frxPage.Frame.Width := FEditor.intMolLar;

    If FEditor.intMolLar > 0 Then
    Begin
      frxPage.Frame.Typ := [];

      If blnMolEsq Then
        frxPage.Frame.Typ := frxPage.Frame.Typ + [ftLeft];

      If blnMolSup Then
        frxPage.Frame.Typ := frxPage.Frame.Typ + [ftTop];

      If blnMolInf Then
        frxPage.Frame.Typ := frxPage.Frame.Typ + [ftBottom];

      If blnMolDir Then
        frxPage.Frame.Typ := frxPage.Frame.Typ + [ftRight];
    End;
  End;
End;

Function TEditorFast.fSetaPagina: Boolean;
Begin
  Result := False;

  With FEditor, dadMargem, ppzPapSiz  Do
  Begin
    frxPage := fRetfrxPage;

    if fTemMarcaDAgua Then
    Begin
      frxPage.BackPicture.Assign(FMarcaDagua);
    End;

    If Not Assigned(frxPage) Then
      Exit;

    frxPage.PaperSize := recPapCur.intValFrx;

    frxPage.Orientation := ppzPapSiz.porOrient;

    frxPage.EndlessHeight := blnSemFim;

    If (intPapCur = fIndiceCustom(FTipImp)) And (FTipImp = 'J') Then
    Begin
      frxPage.PaperWidth  := (ppzPapSiz.fltCusWid) * 10;
      frxPage.PaperHeight := (ppzPapSiz.fltCusHei) * 10;
    End;

    If (FTipImp = 'M') Then
    Begin

      If (intPapCur = fIndiceCustom(FTipImp)) Then
      Begin
        frxPage.PaperWidth  :=  ppzPapSiz.FArrPpz[intPapCur].fltLarFrx;
        frxPage.PaperHeight :=  4.4979137617640235 * (ppzPapSiz.fltCusHei);
      End Else
      Begin
        frxPage.PaperWidth  :=  ppzPapSiz.FArrPpz[intPapCur].fltLarFrx;
        frxPage.PaperHeight :=  ppzPapSiz.FArrPpz[intPapCur].fltAltFrx;
      End;

      frxPage.RightMargin  := fltMarDir * FATOR_MARGEM_HORIZONTAL;
      frxPage.LeftMargin   := fltMarEsq * FATOR_MARGEM_HORIZONTAL;
      frxPage.TopMargin    := fltMarSup * FATOR_MARGEM_VERTICAL;
      frxPage.BottomMargin := fltMarInf * FATOR_MARGEM_VERTICAL;
    End Else
    Begin
      frxPage.RightMargin  := fltMarDir * 10;
      frxPage.LeftMargin   := fltMarEsq * 10;
      frxPage.TopMargin    := fltMarSup * 10;
      frxPage.BottomMargin := fltMarInf * 10;
    End;

    frxPageVias := Nil;

    pMolduraToFast;
    pHeaderToFast;
    pHeaderDataToFast;
    pFooterDataToFast;
    pFooterToFast;
    pSummaryToFast;

    If FEditor.blnViaPag Then
    Begin
      frxPageVias := fRetfrxPageVias;

      If Assigned(frxPageVias) Then
      Begin
        if fTemMarcaDAgua Then
        Begin
          frxPageVias.BackPicture.Assign(FMarcaDagua);
        End;

        frxPageVias.Orientation  := frxPage.Orientation;
        frxPageVias.Frame        := frxPage.Frame;

        frxPageVias.RightMargin  := frxPage.RightMargin;
        frxPageVias.LeftMargin   := frxPage.LeftMargin;
        frxPageVias.TopMargin    := frxPage.TopMargin;
        frxPageVias.BottomMargin := frxPage.BottomMargin;

        frxPageVias.PaperSize := fGetIndicePapel(FEditor.strNomPapVias);
      End;
    End;
  End;

  Result := True;
End;

Function TEditorFast.fSetaEtiqueta: Boolean;
Begin
  Result := True;

  frxMasterData := fRetfrxMasterData;
  If Not Assigned(frxMasterData) Then
    Exit;

  frxMasterData.DataSetName := 'frxDBImpEti';

  With FEditor Do
  Begin
    frxMasterData.Columns := dadEtique.intNumCol;

    frxMasterData.Height      := fltAltEPx;
    frxMasterData.ColumnWidth := fltLarEPx;
    frxMasterData.ColumnGap   := fltGpHrPx;

    frxMasterData.OnBeforePrint := 'MasterData1OnBeforePrint' ;

    If blnZebra Or ( intMolDad > 0) Then
      pZebraToFast;
  End;
End;

Procedure TEditorFast.pZebraToFast;
  Var
    frxCampo : TfrxCustomMemoView;
    fltAjuModEsq: Double;
Begin
  frxCampo := fCriaMemoView(frxMasterData);

  With frxCampo Do
  Begin
    Name     := 'mmoZebra';
    Parent   := TfrxComponent(frxMasterData);

    If FEditor.blnMolEsq Then
      fltAjuModEsq := FEditor.intMolLar
    Else
      fltAjuModEsq := 0;

    Width    := FEditor.fltLarEPx - fltAjuModEsq;
    Height   := FEditor.fltAltEPx;
    Top      := 0;
    Left     := fltAjuModEsq;

    Align := baClient;

    If FEditor.blnZebra Then
    Begin
      Highlight.Color    :=  FEditor.clrZebra;

      If Highlight.Color = clWhite Then
        Highlight.Color := clNone;

      Highlight.Condition := IIF(fEmptyStr(FEditor.expZebra), '<Line#> Mod 2 = 0', FEditor.expZebra);
    End;

    Frame.Width := FEditor.intMolDad;
    Frame.Typ   := [];
    If FEditor.intMolDad > 0 Then
    Begin
      Frame.Typ := Frame.Typ + [ftTop];
      Frame.Typ := Frame.Typ + [ftBottom];
      Frame.Typ := Frame.Typ + [ftLeft];
      Frame.Typ := Frame.Typ + [ftRight];
    End;

  End;
End;

Function TEditorFast.fExpressaoEditorToFast(strCampo: String; blnColche: Boolean = True): String;
  Var
    parParser: TParser;
    strStream: TStringStream;
    strExpres: String;
    strTokIde: Char;
    blnComMas: Boolean;
    strfrxSet: String;
Begin
  strStream := TStringStream.Create(strCampo);
  strStream.Position := 0;
  parParser := TParser.Create(strStream);
  strExpres := '';
  blnComMas := False;

  While parParser.token <> toEOF Do
  Begin
    strTokIde := parParser.Token;

    With FTabCam Do
    Case strTokIde Of
      #1:  Begin
             If SameText('FormatMaskText', parParser.TokenString) Then
               blnComMas := True;


             If Locate('CAM_CODCAM', parParser.TokenString, []) Then
             Begin
               If fEmptyStr(FieldByName('CAM_FRXSET').AsString) Then
                 strfrxSet := 'frxDBImpEti'
               Else
                 strfrxSet := FieldByName('CAM_FRXSET').AsString;

               If (FieldByName('CAM_TIPINF').AsString = 'P') Then // PARAMETRO
                 strExpres := strExpres + ' <' + parParser.TokenString + '> '

               Else If (FieldByName('CAM_TIPINF').AsString = 'V') Then // VARIAVEL DO FAST
               BEGIN

                 If SameText(parParser.TokenString, 'NROPAG') Then
                 Begin
                   If FEditor.blnViaPag Then
                     strExpres := strExpres + ' ' + '<intPagina>'
                   Else
                     strExpres := strExpres + ' ' + '<Page#>'
                 End

                 Else If SameText(parParser.TokenString, 'TOTPAG') Then
                   strExpres := strExpres + ' ' + '<TotalPages#>'

                 Else strExpres := strExpres + ' ' + parParser.TokenString;
               End

               Else If fEmptyStr(FieldByName('CAM_MASCAR').AsString) Or blnComMas Then
                 strExpres := strExpres + ' <' + strfrxSet + '."' + FieldByName('CAM_EXPCAM').AsString + '"> '
               Else
                 strExpres := strExpres + ' FormatMaskText(' + QuotedStr(FieldByName('CAM_MASCAR').AsString) + ' ,<' + strfrxSet + '."' + FTabCam.FieldByName('CAM_EXPCAM').AsString + '">) ';

               blnComMas := False;
             End

             Else strExpres := strExpres + ' ' + parParser.TokenString;
           End;

      #2:  strExpres := strExpres + ' ' + QuotedStr(parParser.TokenString)

      Else If ((parParser.TokenString = '>') Or (parParser.TokenString = '=')) And ((RightStr(strExpres, 1) = '<') Or (RightStr(strExpres, 1) = '>')) Then
             strExpres := strExpres + parParser.TokenString
           Else
             strExpres := strExpres + ' ' + parParser.TokenString;
    End;

    parParser.NextToken;
  End;

  If blnColche And (Not fEmptyStr(strExpres)) Then
    Result := '[' + Trim(strExpres) + ']'
  Else
    Result := Trim(strExpres);

  FreeAndNil(parParser);
  FreeAndNil(strStream);
End;

Function TEditorFast.fCampoEditorToFast(strCampo: String): String;
  Var
    strfrxSet: String;
Begin
  FNomVar := '';
  
  With FTabCam Do
  If Locate('CAM_CODCAM', strCampo, []) Then
  Begin
    If fEmptyStr(FieldByName('CAM_FRXSET').AsString) Then
      strfrxSet := 'frxDBImpEti'
    Else
      strfrxSet := FieldByName('CAM_FRXSET').AsString;

    If (FieldByName('CAM_TIPINF').AsString = 'P') Then // PARAMETRO
      Result := '[' + FieldByName('CAM_EXPCAM').AsString + ']'

    Else If (FieldByName('CAM_TIPINF').AsString = 'V') Then // VARIAVEIS DO FAST
    Begin
      If SameText(FieldByName('CAM_CODCAM').AsString, 'NROPAG') Then
      Begin
        If FEditor.blnViaPag Then
          Result := '[intPagina]'
        Else
          Result := '[Page#]'
      End

      Else If SameText(FieldByName('CAM_CODCAM').AsString, 'TOTPAG') Then
        Result := '[TotalPages#]'

      Else If SameText(FieldByName('CAM_CODCAM').AsString, 'NROPG1') Then
      Begin
        If FTipImp = 'J' Then
        Begin

          If FEditor.blnViaPag Then
            Result := 'Página [intPagina]/[TotalPages#]'
          Else
            Result := 'Página [Page#]/[TotalPages#]'


        End Else
        Begin
          Result := 'Pagina [Page#]/[TotalPages#]'
        End;
      End

      Else If SameText(FieldByName('CAM_CODCAM').AsString, 'NROPG2') Then
      Begin

        If FEditor.blnViaPag Then
          Result := '[intPagina]/[TotalPages#]'
        Else
          Result := '[Page#]/[TotalPages#]'

      End

      Else
        Result := '';
                                 
      FNomVar := FieldByName('CAM_CODCAM').AsString;
    End

    Else If fEmptyStr(FieldByName('CAM_MASCAR').AsString) Then
      Result := '[<' + strfrxSet + '."' + FieldByName('CAM_EXPCAM').AsString + '">]'

    Else
      Result := '[FormatMaskText(' + QuotedStr(FieldByName('CAM_MASCAR').AsString) + ' ,<' + strfrxSet + '."' + FTabCam.FieldByName('CAM_EXPCAM').AsString + '">)]'
  End;
End;

Function TEditorFast.fExprToFast(layCmpMvl: TLayStaticText): String;
Begin
  FNomVar := '';
  Case layCmpMvl.tcpTipCam Of
    camNormal   : Result := fCampoEditorToFast(layCmpMvl.strCodCam);
    camExpressao: Result := fExpressaoEditorToFast(layCmpMvl.strCodCam);
  End;
End;

Procedure TEditorFast.pTextoToFast(layCmpMvl: TLayStaticText; intIndice: Integer);
  Var
    frxCampo : TfrxCustomMemoView;
    fltTop   : Double;
    frxParent: TComponent;
Begin
  frxParent := fGetParent(layCmpMvl.fltfrxTop, fltTop);

  frxCampo := fCriaMemoView(frxParent);

  With frxCampo Do
  Begin
    {$IFDEF TESTABILIDADE_AUTCOM}
      Name     := 'mmoTeste' + IntToStr(intIndice);
    {$ELSE}
      Name     := 'memo' + IntToStr(intIndice);
    {$ENDIF}
    Parent   := TfrxComponent(frxParent);
    Width    := layCmpMvl.fltfrxWidth;
    Height   := layCmpMvl.fltfrxHeight;
    Top      := fltTop;
    Left     := layCmpMvl.fltfrxLeft;

    If FTipImp = 'M' Then
    Begin
      Tag  := Trunc(layCmpMvl.fltLeft);
      Left := layCmpMvl.fltLeft * LARGURA_FONTE_MATRICIAL_PIXEL;
    End Else
    Begin
      Left := layCmpMvl.fltfrxLeft;
    End;  

    Rotation := layCmpMvl.intfrxRot;
    HAlign   := layCmpMvl.aliHAlign;
    WordWrap := layCmpMvl.blnWorWra;
    HideZeros := layCmpMvl.blnHidZer;

    Description := fColMatToTexto(layCmpMvl.colFonMat);

    Font.Assign(layCmpMvl.Font);

    Text     := fExprToFast(layCmpMvl);

    If Not fEmptyStr(FNomVar) Then
      Name := FNomVar;

    Color    := layCmpMvl.colBColor;

    If Color = clWhite Then
      Color := clNone;

    AutoWidth:= layCmpMvl.blnAutWid;

    If layCmpMvl.blnAutHei Then
    Begin
      StretchMode             := smMaxHeight;
      If Assigned(frxMasterData) Then
        frxMasterData.Stretched := True;
    End;

    Frame.Width := layCmpMvl.fltBorEsp;
    Frame.Typ   := [];

    If layCmpMvl.blnBorTop Then
      Frame.Typ := Frame.Typ + [ftTop];

    If layCmpMvl.blnBorBot Then
      Frame.Typ := Frame.Typ + [ftBottom];

    If layCmpMvl.blnBorLef Then
      Frame.Typ := Frame.Typ + [ftLeft];

    If layCmpMvl.blnBorRig Then
      Frame.Typ := Frame.Typ + [ftRight];

    If (layCmpMvl.tpaTipApr = aprTexto) And (layCmpMvl.intCasDec > -1) And
       ((layCmpMvl.tcpTipCam = camExpressao) Or (layCmpMvl.fdtTipDad = ftFloat)) Then
    Begin
      DisplayFormat.Kind := fkNumeric;
      DisplayFormat.DecimalSeparator := ',';
      DisplayFormat.FormatStr := '%2.' + IntToStr(layCmpMvl.intCasDec) + 'n';
    End;

  End;
End;

Procedure TEditorFast.pImagemToFast(layCmpMvl: TLayStaticText);
  Var
    picImagem: TfrxPictureView;
    fltTop   : Double;
    frxParent: TComponent;
Begin
  frxParent := fGetParent(layCmpMvl.fltfrxTop, fltTop);

  picImagem := TfrxPictureView.Create(frxParent);

  With picImagem Do
  Begin
    Parent   := TfrxComponent(frxParent);
    Width    := layCmpMvl.fltfrxWidth;
    Height   := layCmpMvl.fltfrxHeight;
    Top      := fltTop;
    Left     := layCmpMvl.fltfrxLeft;
    AutoSize := False;
    Stretched:= layCmpMvl.blnStretc;
    Center   := layCmpMvl.blnCenImg;
    HightQuality := True;
    If layCmpMvl.strCodCam <> '' Then
    Begin
      if layCmpMvl.strCodCam = 'PROIMG' Then
          picImagem.Name := 'imgProduto';
      picImagem.DataField := layCmpMvl.strCodCam;
      If layCmpMvl.strFrxSet <> '' Then
        picImagem.DataSetName := layCmpMvl.strFrxSet
      Else If Assigned(frxMasterData) Then
        picImagem.DataSet := frxMasterData.DataSet;
    End;
    If Assigned(layCmpMvl.imgImgCmp.Picture) Then
      Picture.Assign(layCmpMvl.imgImgCmp.Picture);
  End;
End;

Procedure TEditorFast.pBarCodeToFast(layCmpMvl: TLayStaticText);
  Var
    frxBarCod: TfrxBarCodeView;
    fltTop   : Double;
    frxParent: TComponent;
Begin
  frxParent := fGetParent(layCmpMvl.fltfrxTop, fltTop);
  frxBarCod := TfrxBarCodeView.Create(frxParent);
  With frxBarCod Do
  Begin
    Parent   := TfrxComponent(frxParent);
    Width    := layCmpMvl.fltfrxWidth;
    Height   := layCmpMvl.fltfrxHeight;
    Top      := fltTop;
    Left     := layCmpMvl.fltfrxLeft;
    Rotation := layCmpMvl.intfrxRot;
    HAlign   := layCmpMvl.aliHAlign;
    Font.Assign(layCmpMvl.Font);
    BarCode.Font.Assign(layCmpMvl.Font);
    Text       := '';
    Color      := layCmpMvl.colBColor;

    If Color = clWhite Then
      Color := clNone;

    Expression := '';
    DataField  := '';
    DataSet    := Nil;
    ShowText   := layCmpMvl.blnBarTxt;
    BarType    := layCmpMvl.bctBarCod;
    CalcCheckSum := layCmpMvl.blnChkSum;

    // Devolvemos o Zoom Fixo na TagStr para recarregar na próxima impressão
    TagStr := IIF(FEditor.dblZooFix <> 0, FloatToStr(FEditor.dblZooFix), '');

    If (FEditor.dblZooFix = 0) Then
    Begin
      If (Rotation = 270) Or (Rotation = 90) Then
        Zoom       := Height / fZoomBarCode(BarType, Height)
      Else
        Zoom       := Width / fZoomBarCode(BarType, Width);
    End
    Else
      Zoom := FEditor.dblZooFix;

    Case layCmpMvl.tcpTipCam Of
      camNormal   : Begin
                      With FTabCam Do
                      If Locate('CAM_CODCAM', layCmpMvl.strCodCam, []) Then
                      Begin
                        If FieldByName('CAM_TIPINF').AsString = 'P' Then
                        Begin
                          Expression := '[' + layCmpMvl.strCodCam + ']';
                        End Else
                        Begin
                          If Assigned(frxMasterData) Then
                            DataSet := frxMasterData.DataSet;
                          DataField := FieldByName('CAM_EXPCAM').AsString;
                        End;
                      End;
                    End;

      camExpressao: Begin
                      Expression := fExpressaoEditorToFast(layCmpMvl.strCodCam, False);
                    End;
    End;

  End;

End;

Procedure TEditorFast.pQRCODEToFast(layCmpMvl: TLayStaticText);
  Var
    frxBarCod: TfrxBarCode2DView;
    fltTop   : Double;
    frxParent: TComponent;
    stlScriptBeforePrint: TStringList;
Begin
  frxParent := fGetParent(layCmpMvl.fltfrxTop, fltTop);
  frxBarCod := TfrxBarCode2DView.Create(frxParent);
  With frxBarCod Do
  Begin
    Parent   := TfrxComponent(frxParent);
    Width    := layCmpMvl.fltfrxWidth;
    Height   := layCmpMvl.fltfrxHeight;
    Top      := fltTop;
    Left     := layCmpMvl.fltfrxLeft;
    Rotation := layCmpMvl.intfrxRot;
    HAlign   := layCmpMvl.aliHAlign;
    Font.Assign(layCmpMvl.Font);

    Text       := '1234';
    Color      := layCmpMvl.colBColor;

    If Color = clWhite Then
      Color := clNone;

    Expression := '';
    DataField  := '';
    DataSet    := Nil;
    BarType    := layCmpMvl.bcqBarCQR;
    ShowText   := layCmpMvl.blnBarTxt;

    Zoom       := layCmpMvl.fltBarZoo;

    Case layCmpMvl.tcpTipCam Of
      camNormal   : Begin
                      With FTabCam Do
                      If Locate('CAM_CODCAM', layCmpMvl.strCodCam, []) Then
                      Begin
                        If FieldByName('CAM_TIPINF').AsString = 'P' Then
                        Begin
                          Expression := '[' + layCmpMvl.strCodCam + ']';
                        End Else
                        Begin
                          If Assigned(frxMasterData) Then
                            DataSet := frxMasterData.DataSet;
                          DataField := FieldByName('CAM_EXPCAM').AsString;
                        End;
                      End;
                    End;

      camExpressao: Begin
                      Expression := fExpressaoEditorToFast(layCmpMvl.strCodCam, False);
                    End;
    End;
  End;

  // Aqui eu crio o BeforePrint e ajusto o código em outro ponto
  stlScriptBeforePrint := TStringList.Create;
  Try
    If (Not fEmptyStr(frxBarCod.DataSetName)) And (Not fEmptyStr(frxBarCod.DataField)) Then
    Begin
      frxBarCod.OnBeforePrint := 'pBarcode2dViewBeforePrint';
      With stlScriptBeforePrint Do
      Begin
        Clear;
        Add('');
        Add('procedure ' + frxBarCod.OnBeforePrint + '(Sender: TfrxComponent);');
        Add('begin');
        Add('  TfrxBarcode2dView(Sender).Visible := <' + frxBarCod.DataSetName + '."' + frxBarCod.DataField + '"> <> '''';');
        Add('end;');
      End;

      FReport.ScriptText.Clear;
      FReport.ScriptText.Add(stlScriptBeforePrint.Text);
    End;
  Finally
    FreeAndNil(stlScriptBeforePrint);
  End;

End;

Procedure TEditorFast.pCamposToFast;
  Var
    intIndice: Integer;
    layCmpMvl: TLayStaticText;
Begin
  With FEditor, ppzPapSiz Do
  Begin

    For intIndice := 0 To FCmpMvl.oblCamObj.Count - 1 Do
    Begin
      layCmpMvl := TLayStaticText(FCmpMvl.oblCamObj[intIndice]);

      Case layCmpMvl.tpaTipApr Of
        aprTexto  : pTextoToFast(layCmpMvl, intIndice);
        aprCodeBar: pBarCodeToFast(layCmpMvl);
        aprQRCODE : pQRCODEToFast(layCmpMvl);
        aprImagem : pImagemToFast(layCmpMvl);
      End;

    End;
  End;

End;

function TEditorFast.fTemMarcaDAgua : Boolean;
Begin
  Result := Not FMarcaDagua.Empty;
End;
function TEditorFast.fCarregarMarcaDagua : Boolean;
  Var
    strFile: String;
    objOpenDialog : TOpenDialog;
Begin
  Result := False;

  if fTemMarcaDAgua Then
  Begin
    FMarcaDagua.Free;
    FMarcaDagua := TJPEGImage.Create;
    Exit(False);
  End

  Else
  Begin
    Try
      strFile := '';
      objOpenDialog := TOpenDialog.Create(Nil);
      objOpenDialog.Filter := 'Imagens JPEG|*.jpg';
      If objOpenDialog.Execute() Then
        strFile := objOpenDialog.FileName
    Finally
      FreeAndNil(objOpenDialog);
    End;

    If (FileExists(strFile)) Then
    Begin

      Try
        FMarcaDagua.LoadFromFile( strFile );
      Except
        On e : Exception Do
          pMensagensErro(e.message, '');
      End;

      frxPage.BackPictureVisible := True;
      frxPage.BackPicturePrintable := True;

      Exit(Not FMarcaDagua.Empty);
    End;
  End;

end;

Procedure TEditorFast.pAtualizaNaoPadrao;
  Var
    qryLayRel: TUniQuery;
Begin
  If FCodEti in [tpeOPIndustrial, tpeOPIndustrialArgox, tpeOrdemProducaoArgox] Then
    Exit;

  qryLayRel := fCriaQuery;
  With qryLayRel, SQL Do
  Begin
    Clear;
    Add('UPDATE LAYETI');
    Add('SET LAY_PADRAO = "N"');
    Add('WHERE');
    Add('  LAY_TIPLAY = :TIPLAY');

    If (Assigned(FEditor) And (FEditor.tplTipLay = tplDocumentos)) Or FEtiEmp Then
      Add(' AND LAY_CODEMP = ' + QuotedStr(VS_strCodEmp));

    If (FEtiEmp) Then
      Add('  AND LAY_ETIEMP = "S" ')
    Else
      Add('  AND LAY_ETIEMP = "N" ');


    ParamByName('TIPLAY').AsInteger := ARR_TIPO_LAYOUT[FCodEti];

    ExecSQL;
  End;
  FreeAndNil(qryLayRel);
End;

Function TEditorFast.fTemAlteracaoFr3(mmsRelat : TMemoryStream): Boolean;
  Var
    qryLayAux: TUniQuery;
    strNovLay: String;
Begin
  If FLayEti.IsEmpty Then
  Begin
    Result := True;
    Exit;
  End;

  If FLayEti.FieldByName('LAY_GAPVER').AsFloat <> FGpVePx Then
  Begin
    Result := True;
    Exit;
  End;

  If Assigned(FEditor) And (FLayEti.FieldByName('LAY_INFHEI').AsString <> FEditor.strInfHei) Then
  Begin
    Result := True;
    Exit;
  End;

  If Assigned(FEditor) And (FLayEti.FieldByName('LAY_AVNPAG').AsString <> FEditor.strAvnPag) Then
  Begin
    Result := True;
    Exit;
  End;

  qryLayAux := fCriaQuery(Self);
  With qryLayAux Do
  Begin
    SQL.Text := 'SELECT * FROM LAYETI WHERE FALSE';
    Open;
    Insert;

    TBlobField(FieldByName('LAY_RELFR3')).LoadFromStream(mmsRelat);
    strNovLay := FieldByName('LAY_RELFR3').AsString;
    Cancel;

    Result := strNovLay <> FLayEti.FieldByName('LAY_RELFR3').AsString;

    FreeAndNil(qryLayAux);
  End;
End;

Procedure TEditorFast.pInsereRegistro(mmsRelat : TMemoryStream;
                                      blnPadraoP: Boolean = False;
                                      blnConver: Boolean = False);
  Var
    strLayout: String;
Begin
  fStartTransaction;

  If blnPadraoP And ((Not Assigned(FEditor)) Or (FEditor.tplTipLay = tplEtiquetas)) Then
    pAtualizaNaoPadrao;

  With FLayEti Do
  Begin

    If Not blnPadraoP Then
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM LAYETI WHERE LAY_PADRAO = "S" AND ');
      SQL.Add('LAY_TIPLAY = ' + IntToStr(ARR_TIPO_LAYOUT[FCodEti]));

      If (Assigned(FEditor) And (FEditor.tplTipLay = tplDocumentos)) Or FEtiEmp Then
        SQL.Add('  AND LAY_CODEMP = ' + QuotedStr(VS_strCodEmp));

      Open;

      If IsEmpty And ((Not Assigned(FEditor)) Or (FEditor.tplTipLay = tplEtiquetas)) Then
      Begin
        blnPadraoP := True;
        FPadrao   := True;
      End;

      Close;
    End;

    If Not Active Then
    Begin
      If (Not fEmptyStr(FCodDoc)) And Assigned(FEditor) And (FEditor.tplTipLay = tplDocumentos) Then
        SQL.Text := 'SELECT * FROM LAYETI WHERE LAY_CODLAY = ' + QuotedStr(FCodDoc)
      Else
        SQL.Text := 'SELECT * FROM LAYETI WHERE FALSE';

      If (Assigned(FEditor) And (FEditor.tplTipLay = tplDocumentos)) Or FEtiEmp Then
        SQL.Add('  AND LAY_CODEMP = ' + QuotedStr(VS_strCodEmp));

      Open;
    End;

    If Assigned(FEditor) And (FEditor.tplTipLay = tplDocumentos) And (Not IsEmpty) Then
      Edit
    Else
    Begin
      Insert;
      FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('LAYETI', VS_strCodEmp);
      FieldByName('LAY_CODEMP').AsString   := VS_strCodEmp;
      FieldByName('LAY_CODLAY').AsString   := fAtualizaProCod('LAYETI', 'LAY_CODLAY');
    End;

    FCodDoc := FieldByName('LAY_CODLAY').AsString;

    FieldByName('LAY_NOMLAY').AsString   := String(ARR_NOME_ETIQUETA[FCodEti]);
    FieldByName('LAY_TIPLAY').AsInteger  := ARR_TIPO_LAYOUT[FCodEti];
    FieldByName('LAY_PADRAO').AsString   := IfThen(blnPadraoP, 'S', 'N');
    FieldByName('LAY_DTAALT').AsDateTime := VS_Date;
    FieldByName('LAY_HORALT').AsDateTime := fTime();
    FieldByName('LAY_DESCRI').AsString   := FDescri;
    FieldByName('LAY_GAPVER').AsFloat    := FGpVePx;
    FieldByName('LAY_ORDENA').AsString   := FOrdena;

    If Assigned(FEditor) Then
    Begin
      If FEditor.blnViaPag Then
        FieldByName('LAY_VIAPAG').AsInteger := 2
      Else
        FieldByName('LAY_VIAPAG').AsInteger := 1;


      FieldByName('LAY_CABPRI').AsString  := FEditor.strCabPri;
      FieldByName('LAY_ESPACA').AsInteger := FEditor.intEspaca;
      FieldByName('LAY_LINCOM').AsInteger := FEditor.intLinCommand;
      FieldByName('LAY_FOOBRA').AsString  := IfThen(FEditor.blnFooBra, 'S', 'N');
      FieldByName('LAY_IMPPDF').AsString  := IfThen(FEditor.blnImpPDF, 'S', 'N');
      FieldByName('LAY_FOONWP').AsString  := IfThen(FEditor.blnFooNewPage, 'S', 'N');    
    End Else
    Begin
      FieldByName('LAY_CABPRI').AsString  := 'N';
      FieldByName('LAY_ESPACA').AsInteger := 0;
      FieldByName('LAY_LINCOM').AsInteger := 0;
      FieldByName('LAY_FOOBRA').AsString  := 'N';
      FieldByName('LAY_IMPPDF').AsString  := 'N';
      FieldByName('LAY_VIAPAG').AsInteger := 1;
      FieldByName('LAY_FOONWP').AsString  := 'N';      
    End;

    TBlobField(FieldByName('LAY_RELFR3')).LoadFromStream(mmsRelat);

    If Assigned(FEditor) And (FEditor.tplTipLay = tplDocumentos) Then
    Begin
      FieldByName('LAY_RELFR3').AsString  := fInsereBeforPrintBarCode(FieldByName('LAY_RELFR3').AsString);
      FieldByName('LAY_TIPREG').AsInteger := 1;
    End Else
    Begin
      FieldByName('LAY_TIPREG').AsInteger := 0;
    End;

    If FEtiEmp Then
      FieldByName('LAY_ETIEMP').AsString := 'S'
    Else
      FieldByName('LAY_ETIEMP').AsString := 'N';

    If blnConver And Assigned(frxMasterData) Then
    Begin
      strLayout := FieldByName('LAY_RELFR3').AsString;
      strLayout := AnsiReplaceStr(strLayout, frxMasterData.DataSetName, 'frxDBImpEti');
      strLayout := AnsiReplaceStr(strLayout, 'frxDBDataset1', 'frxDBImpEti');
      strLayout := AnsiReplaceStr(strLayout, 'frxUserDataset1', 'frxDBImpEti');
      strLayout := AnsiReplaceStr(strLayout, 'frxDtsFormul', 'frxDBImpEti');
      strLayout := AnsiReplaceStr(strLayout, 'frxDados', 'frxDBImpEti');
      strLayout := AnsiReplaceStr(strLayout, 'CLI_NOMCLI', 'NOMCLI');
      strLayout := AnsiReplaceStr(strLayout, 'CLI_ENDERE', 'ENDERE');
      strLayout := AnsiReplaceStr(strLayout, 'CLI_BAIRRO', 'BAIRRO');
      strLayout := AnsiReplaceStr(strLayout, 'CLI_C_E_P_', 'C_E_P_');
      strLayout := AnsiReplaceStr(strLayout, 'CLI_NOMCID', 'NOMCID');
      strLayout := AnsiReplaceStr(strLayout, 'CLI_ENDCOM', 'ENDCOM');
      strLayout := AnsiReplaceStr(strLayout, 'CLI_ENDNUM', 'ENDNUM');
      frxMasterData.DataSetName := 'frxDBImpEti';
      FieldByName('LAY_RELFR3').AsString := strLayout;
    End;

    FieldByName('LAY_TIPIMP').AsString := FTipImp;

    // pedido de compra salvo com a reforma: a impressao para de injetar CBS / IBS / IS (o que foi salvo fica)
    If (FCodEti = tpePedidoCompra) And (FTipImp <> 'M') And Assigned(FindField('LAY_REFTRI')) And
       (FblnReformaPedidoCompra Or fSomarNovosImpostosDaReformaAoValorContabil) Then
      FieldByName('LAY_REFTRI').AsString := 'S';

    If Assigned(FEditor) Then
    Begin
      FieldByName('LAY_TIPMAT').AsInteger := FEditor.ppzPapSiz.intPapCur;
      FieldByName('LAY_ESCMOD').AsInteger := FEditor.intEscMod;
      FieldByName('LAY_CONPRO').AsInteger := IfThen(FEditor.blnConPro, 1, 0);
      FieldByName('LAY_AVNPAG').AsString  := IfThen(fEmptyStr(FEditor.strAvnPag),'S',FEditor.strAvnPag);
    End Else
    Begin
      FieldByName('LAY_TIPMAT').AsInteger := 0;
      FieldByName('LAY_ESCMOD').AsInteger := 1;
      FieldByName('LAY_CONPRO').AsInteger := 0;
      FieldByName('LAY_AVNPAG').AsString := 'S';
    End;

    Post;

    fCommit;

    FPadrao := FieldByName('LAY_PADRAO').AsString = 'S';
  End;
End;

Function TEditorFast.fSalvaArquivo(blnPadrao: Boolean = False;
                                   blnConfir: Boolean = False): Boolean;
  Var
    mmsRelat : TMemoryStream;
    strCodLay: String;
Begin
  Try
    Result := False;

    If ((Not FLayEti.Active) Or FLayEti.IsEmpty) And
       (FCmpMvl.oblCamObj.Count = 0) And blnConfir Then
    Begin
      Result := True;
      Exit;
    End;

    If (Not blnConfir) And (Not fValidaLayout) Then
      Exit;

    If Not fEditorToFast Then
      Exit;

    If (FEditor.tplTipLay = tplDocumentos) Then
      FReport.ScriptText.Text := fMontaScript
    Else
    Begin
      If FReport.ScriptText.Text <> '' Then
      Begin
        FReport.ScriptText.Add('');
        FReport.ScriptText.Add('Begin');
        FReport.ScriptText.Add('End.');
      End;
    End;

    mmsRelat := TMemoryStream.Create;
    FReport.SaveToStream(mmsRelat);

    If FLayEti.Active And (Not FLayEti.IsEmpty) And
      (FLayEti.FieldByName('LAY_PADRAO').AsString = 'S') And (Not FHerdar) Then
      blnPadrao := True;

    If FLayEti.Active And (Not FLayEti.IsEmpty) And (Not fTemAlteracaoFr3(mmsRelat)) And (Not FHerdar) Then
    Begin

      If (blnPadrao And (FLayEti.FieldByName('LAY_PADRAO').AsString <> 'S')) Or
         (FLayEti.FieldByName('LAY_ESPACA').AsInteger <> FEditor.intEspaca) Or
         (FLayEti.FieldByName('LAY_LINCOM').AsInteger <> FEditor.intLinCommand) Or
         (Not SameText(FLayEti.FieldByName('LAY_DESCRI').AsString, FDescri)) Or
         (Not SameText(FLayEti.FieldByName('LAY_ORDENA').AsString, FOrdena)) Or
         ((FLayEti.FieldByName('LAY_VIAPAG').AsInteger > 1) <> FEditor.blnViaPag) Or
         (FLayEti.FieldByName('LAY_CABPRI').AsString <> FEditor.strCabPri) Or
         ((FLayEti.FieldByName('LAY_FOOBRA').AsString = 'S') <> FEditor.blnFooBra) Or
         ((FLayEti.FieldByName('LAY_IMPPDF').AsString = 'S') <> FEditor.blnImpPDF) Then
      Begin

        If (Not blnConfir) Or fPergunta('Deseja salvar as alterações?') Then
        Begin

          If blnConfir And (Not fValidaLayout) Then
          Begin
            FreeAndNil(mmsRelat);
            Exit;
          End;

          fStartTransaction;

          If blnPadrao Then
            pAtualizaNaoPadrao;

          With FLayEti Do
          Begin
            strCodLay := FieldByName('LAY_CODLAY').AsString;
            Close;
            Sql.Text := 'SELECT * FROM LAYETI WHERE LAY_CODLAY = ' + QuotedStr(strCodLay);

            If ((FEditor.tplTipLay = tplDocumentos)) Or FEtiEmp  Then
              SQL.Add('  AND LAY_CODEMP = ' + QuotedStr(VS_strCodEmp));

            Open;
            Edit;
            FieldByName('LAY_DTAALT').AsDateTime := VS_Date;
            FieldByName('LAY_HORALT').AsDateTime := fTime();
            FieldByName('LAY_PADRAO').AsString   := IfThen(blnPadrao, 'S', 'N');
            FieldByName('LAY_DESCRI').AsString   := FDescri;
            FieldByName('LAY_ORDENA').AsString   := FOrdena;

            If FEditor.blnViaPag Then
              FieldByName('LAY_VIAPAG').AsInteger := 2
            Else
              FieldByName('LAY_VIAPAG').AsInteger := 1;

            FieldByName('LAY_CABPRI').AsString  := FEditor.strCabPri;


            FieldByName('LAY_ESPACA').AsInteger := FEditor.intEspaca;
            FieldByName('LAY_LINCOM').AsInteger := FEditor.intLinCommand;
            FieldByName('LAY_TIPIMP').AsString  := FTipImp;
            FieldByName('LAY_TIPMAT').AsInteger := FEditor.ppzPapSiz.intPapCur;
            FieldByName('LAY_ESCMOD').AsInteger := FEditor.intEscMod;
            FieldByName('LAY_CONPRO').AsInteger := IfThen(FEditor.blnConPro, 1, 0);
            FieldByName('LAY_FOOBRA').AsString  := IfThen(FEditor.blnFooBra, 'S', 'N');
            FieldByName('LAY_IMPPDF').AsString  := IfThen(FEditor.blnImpPDF, 'S', 'N');
            FieldByName('LAY_FOONWP').AsString  := IfThen(FEditor.blnFooNewPage, 'S', 'N');
            Post;
          End;

          fCommit;
        End;

      End;

      Result := True;
      FreeAndNil(mmsRelat);
      Exit;
    End;

    If (Not blnConfir) Or fPergunta('Deseja salvar as alterações?') Then
    Begin

      If blnConfir And (Not fValidaLayout) Then
      Begin
         FreeAndNil(mmsRelat);
         Exit;
      End;

      pInsereRegistro(mmsRelat, blnPadrao);
    End;

    Try
      FreeAndNil(mmsRelat);
    Except

    End;


    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fSalvaArquivo]');
    End;
  End;

End;

Procedure TEditorFast.pAbreLayouts(qryTabLay: TUniQuery);
Begin
  With qryTabLay, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT * FROM LAYETI');
    Add('WHERE ');
    Add('  LAY_TIPLAY = :TIPLAY ');

    If (FEditor.tplTipLay = tplDocumentos) Then
      SQL.Add('  AND LAY_CODEMP = ' + QuotedStr(VS_strCodEmp));

    Add('ORDER BY ');
    Add('  LAY_DTAALT DESC,');
    Add('  LAY_HORALT DESC ');

    ParamByName('TIPLAY').AsInteger := ARR_TIPO_LAYOUT[FCodEti];

    Open;
  End;
End;

procedure TEditorFast.pAbreLoteProdutoMarmoreTeste(qryEtique: TUniQuery);
begin
pAbreLoteProduto(qryEtique,
                 True,
                 True,
                 '30',
                 '',
                 '',
                 '',
                 '',
                 1,
                 1,
                 1,
                 True);
End;



procedure TEditorFast.pAbreLoteProduto(qryEtique: TUniQuery;
                               blnTesteL: Boolean = False;
                               blnAbrirQuery: Boolean = True;
                               strLimit: string = '30';
                               strLoteAutInc: string = '';
                               strCodEmp: String = '';
                               strValAcr: string = '';
                               strValDes: string = '';
                               intParcel: Integer = 1;
                               intTabPre: Integer = 1;
                               intTabPra: integer = 1;
                               blnLoteMarmore: Boolean = False;
                               strForceFiltro: String = '';
                               strChaveTemporariaLotMarmore: String = '';
                               strQtdEmb: String = '');
begin
  qryEtique.SQL.Add('SELECT ITE_CODGRU AS CODGRU,');
  qryEtique.SQL.Add('       (SELECT COALESCE(GRU_DESGRU, "") FROM CADGRU WHERE GRU_CODGRU = ITE_CODGRU) AS DESGRU,');
  qryEtique.SQL.Add('       CADITE.ITE_CODITE AS CODITE,');
  qryEtique.SQL.Add('       ITE_CODUNI AS CODUNI,');
  qryEtique.SQL.Add('       ITE_CODMAR AS CODMAR,');
  qryEtique.SQL.Add('       (SELECT COALESCE(MAR_DESMAR, "") FROM CADMAR WHERE MAR_CODMAR = ITE_CODMAR) AS DESMAR,');
  qryEtique.SQL.Add('       IFNULL(IPR_PREVEN, ITE_PREVE' + IfThen(intTabPre > 0, IntToStr(intTabPre), '1') + ') AS PROMOC,');
  qryEtique.SQL.Add('       IFNULL(IPR_PERDES, 0) AS PERDES,');
  qryEtique.SQL.Add('       CADITE.ITE_CODFOR AS CODFOR,');
  qryEtique.SQL.Add('       FOR_NOMFOR AS NOMFOR,');
  qryEtique.SQL.Add('       CADITE.ITE_DESITE AS DESITE,');
  qryEtique.SQL.Add('       CADITE.ITE_DESSIM AS DESSIM,');
  qryEtique.SQL.Add('       CADITE.ITE_DESFAB AS DESFAB,');
  qryEtique.SQL.Add('       CADITE.ITE_REFERE AS REFERE,');
  qryEtique.SQL.Add('       CADITE.ITE_CODFAB AS CODFAB,');
  qryEtique.SQL.Add('       CADITE.ITE_PESOIT AS PESOIT,');
  qryEtique.SQL.Add('       CADITE.ITE_CNV_ML AS CNV_ML,');
  qryEtique.SQL.Add('       CADITE.ITE_MSGLV1 AS MSGLV1,');
  qryEtique.SQL.Add('       CADITE.ITE_MSGLV2 AS MSGLV2,');
  qryEtique.SQL.Add('       CADITE.ITE_FATCNV AS FATCNV,');
  qryEtique.SQL.Add('       COALESCE(ITEBAR.BAR_DESCRI, "") AS DESEMB,');
  qryEtique.SQL.Add('       CADITE.ITE_APLICA AS APLICA,');
  qryEtique.SQL.Add('       CADUNI.UNI_SIGUNI AS SIGUNI,');
  qryEtique.SQL.Add('       ITEGER.ITE_PREVE1 AS PREVE1,');
  qryEtique.SQL.Add('       ITEGER.ITE_PREVE2 AS PREVE2,');
  qryEtique.SQL.Add('       ITEGER.ITE_PREVE3 AS PREVE3,');
  qryEtique.SQL.Add('       ITEGER.ITE_PREVE4 AS PREVE4,');
  qryEtique.SQL.Add('       ITEGER.ITE_PREVE5 AS PREVE5,');
  qryEtique.SQL.Add('       ITEGER.ITE_PREVE6 AS PREVE6,');
  qryEtique.SQL.Add('       ITEGER.ITE_PREVE7 AS PREVE7,');
  If blnLoteMarmore And (not fEmptyStr(strChaveTemporariaLotMarmore)) Then
  begin
    qryEtique.SQL.Add('       LOTMAR.LOT_NUMLOT AS NUMLOT,');
    qryEtique.SQL.Add('       CONCAT(CADITE.ITE_CODITE, " ", LOTMAR.LOT_NUMLOT) AS BARLOT, ');
  End
  Else
  begin
    qryEtique.SQL.Add('       CADLOT.LOT_NUMLOT AS NUMLOT,');
    qryEtique.SQL.Add('       CONCAT(CADITE.ITE_CODITE, " ", CADLOT.LOT_NUMLOT) AS BARLOT, ');
  End;

  qryEtique.SQL.Add('       CADLOT.LOT_DTAFAB AS DTAFAB,');
  qryEtique.SQL.Add('       CADLOT.LOT_DTAVAL AS DTAVAL,');
  qryEtique.SQL.Add('       CADLOT.LOT_DTABAL AS DTABAL,');
  qryEtique.SQL.Add('       CADLOT.LOT_SALBAL AS SALBAL,');
  qryEtique.SQL.Add('       CADLOT.LOT_SALDOS AS SALDOS,');
  qryEtique.SQL.Add('       CADLOT.LOT_SALCON AS SALCON,');
  qryEtique.SQL.Add('       CADLOT.LOT_PREVE' + IntToStr(intTabPre) + ' AS PREVEN,');
  qryEtique.SQL.Add('       CADLOT.LOT_PRECUS AS PRECUS,');
  {*************************************************************}
  {* QUANDO USA LOTE EM ARMAZEM, LOCALIZAÇÃO FISICA É DIFERENTE*}
  {**********************************************************RN*}
  If fCfgSis('CTLEST') = '2' Then
    qryEtique.SQL.Add('       CADLOT.LOT_LOCFIS AS LOCFIS, ')
  Else
    qryEtique.SQL.Add('       IF(IFNULL(CADLOT.LOT_LOCFIS, "") = "", ITEGER.ITE_LOCFIS,  CADLOT.LOT_LOCFIS) AS LOCFIS, ');

  qryEtique.SQL.Add('     ITEGER.ITE_LOCSUP AS LOCSUP, ');

  qryEtique.SQL.Add('     "' + fLoteCriptografado + '"' + ' AS LOTECR, ');
  qryEtique.SQL.Add('       CADLOT.LOT_CUSTOT AS CUSTOT,');
  qryEtique.SQL.Add('       CADLOT.LOT_CAPACI AS CAPACI,');
  qryEtique.SQL.Add('       CADLOT.LOT_PONREP AS PONREP,');
  qryEtique.SQL.Add('       CADLOT.LOT_ML_BAL AS ML_BAL,');
  qryEtique.SQL.Add('       CADLOT.LOT_SAL_ML AS SAL_ML,');
  qryEtique.SQL.Add('       CADLSE.LSE_CODIGO AS LSECOD,');
  qryEtique.SQL.Add('       CADLSE.LSE_DESCRI AS LSEDES,');
  qryEtique.SQL.Add('       CADLSE.LSE_FORMAT AS LSEFMT,');
  qryEtique.SQL.Add('       CADLOC.LOC_CODAMZ AS CODAMZ,');
  qryEtique.SQL.Add('       CADLOC.LOC_ALTURA AS ALTURA,');
  qryEtique.SQL.Add('       CADLOC.LOC_ITEPIC AS ITEPIC,');
  qryEtique.SQL.Add('       CADLOC.LOC_LARGUR AS LARGUR,');
  qryEtique.SQL.Add('       CADLOC.LOC_OBSERV AS OBSERV,');
  qryEtique.SQL.Add('       CADLOC.LOC_PICKIN AS PICKIN,');
  qryEtique.SQL.Add('       CADLOC.LOC_PROFUN AS PROFUN,');
  qryEtique.SQL.Add('       IF(IFNULL(ITEBAR.BAR_CODBAR,"") = "", CADITE.ITE_CODBAR, ITEBAR.BAR_CODBAR) AS CODBAR, ');
  qryEtique.SQL.Add('       IF(IFNULL(ITEBAR.BAR_EMBALA, 0) =  0, CADITE.ITE_EMBALA, ITEBAR.BAR_EMBALA) AS EMBALA, ');
  qryEtique.SQL.Add('       IF(IFNULL(ITEBAR.BAR_PREVEN, 0) =  0,              0.00, ITEBAR.BAR_PREVEN) AS EMBPRE, ');
  qryEtique.SQL.Add('       COALESCE(ITEBAR.BAR_DESCRI, "") AS DESEMB ,');
  qryEtique.SQL.Add('       CADEMP.EMP_C_G_C_ AS EMPCGC,  ');
  qryEtique.SQL.Add('       CADEMP.EMP_FONDA1 AS FONDA1,  ');
  qryEtique.SQL.Add('       CADEMP.EMP_FONDA2 AS FONDA2,  ');
  qryEtique.SQL.Add('       COALESCE(CADEMP.EMP_NOMEMP, "") AS EMPNOM, ');
  qryEtique.SQL.Add('       ITEGER.ITE_CODEMP AS EMPCOD, ');

  qryEtique.SQL.Add('      ' + Concat('ITEGER.ITE_PREVE', IfThen(intTabPre > 0, IntToStr(intTabPre), '1'), ' AS VALITE,'));
  qryEtique.SQL.Add('      ' + Concat('ITEGER.ITE_PREVE', IfThen(intTabPre > 0, IntToStr(intTabPre), '1'), ' AS VALVIS,'));

  qryEtique.SQL.Add('      ITEGER.ITE_PREVE' + IfThen(intTabPre = 0,'1',IntToStr(intTabPre)) +  ' * ' + IfThen(strValDes = '', '1', strValDes) + ' AS PREVIS, ');
  qryEtique.SQL.Add('      ROUND(((ITEGER.ITE_PREVE' + IfThen(intTabPra = 0,'1',IntToStr(intTabPra)) + ' * ' +  IfThen(strValAcr = '', '1', strValAcr) +  ')/' + IfThen(intParcel = 0, '1', IntToStr(intParcel)) + '),2) AS VALPAR, ');

  qryEtique.SQL.Add('      ' + IntToStr(intParcel) + ' AS QTDPAR, ');

  qryEtique.SQL.Add('      ROUND(((ITEGER.ITE_PREVE' + IfThen(intTabPra = 0,'1',IntToStr(intTabPra)) + ' * ' +  IfThen(strValAcr = '', '1', strValAcr) +  ')/' + IfThen(intParcel = 0, '1', IntToStr(intParcel)) + '),2) * ' + IfThen(intParcel = 0, '1', IntToStr(intParcel)) + '  AS TOTPRA, ');

  qryEtique.SQL.Add('       CADLOT.AUTOINCREM AS AUTINC, ');
  qryEtique.SQL.Add('       CADITE.ITE_MLTVEN AS MLTVEN, ');

  If blnLoteMarmore Then
  begin
    If not fEmptyStr(strChaveTemporariaLotMarmore) Then
    Begin
      qryEtique.SQL.Add('  LOTMAR.LOT_NCHAPA AS  NUMCHA,  ');
      qryEtique.SQL.Add('  LOTMAR.LOT_MEDB_L AS  MEDB_L,  ');
      qryEtique.SQL.Add('  LOTMAR.LOT_MEDB_A AS  MEDB_A,  ');
      qryEtique.SQL.Add('  LOTMAR.LOT_MEDB_L * LOTMAR.LOT_MEDB_A AS MEDB_C,  ');
      qryEtique.SQL.Add('  LOTMAR.LOT_MEDL_L AS  MEDL_L,  ');
      qryEtique.SQL.Add('  LOTMAR.LOT_MEDL_A AS  MEDL_A,  ');
      qryEtique.SQL.Add('  LOTMAR.LOT_MEDL_L * LOTMAR.LOT_MEDL_A AS MEDL_C,  ');
      qryEtique.SQL.Add('  LOTMAR.LOT_ESPESS AS  ESPESS,  ');
      qryEtique.SQL.Add('  LOTMAR.LOT_PRVMAP AS  PRVMAP,  ');
      qryEtique.SQL.Add('  LOTMAR.LOT_PRVMAT AS  PRVMAT,  ');
      qryEtique.SQL.Add('  LOTMAR.LOT_MEDL_L * LOTMAR.LOT_MEDL_A  AS QTD2ML,  ');
      qryEtique.SQL.Add('  CONCAT(LOTMAR.LOT_CODITE, LOTMAR.LOT_NUMLOT, LOTMAR.LOT_CODEMP) AS  BARMAR,  ');
      qryEtique.SQL.Add('  LOTMAR.LOT_PRVMAP AS  PREPPR,  ');
      qryEtique.SQL.Add('  LOTMAR.LOT_PRVMAT AS  VENPTR,  ');
      qryEtique.SQL.Add('  LOTMAR.LOT_PRVENP AS  PRVPPE,  ');
      qryEtique.SQL.Add('  LOTMAR.LOT_PRVENT AS  PRVPET,  ');
    End
    Else
    begin
      qryEtique.SQL.Add('  CADLOT.LOT_NCHAPA AS  NUMCHA,  ');
      qryEtique.SQL.Add('  CADLOT.LOT_MEDB_L AS  MEDB_L,  ');
      qryEtique.SQL.Add('  CADLOT.LOT_MEDB_A AS  MEDB_A,  ');
      qryEtique.SQL.Add('  CADLOT.LOT_MEDB_L * CADLOT.LOT_MEDB_A AS MEDB_C,  ');
      qryEtique.SQL.Add('  CADLOT.LOT_MEDL_L AS  MEDL_L,  ');
      qryEtique.SQL.Add('  CADLOT.LOT_MEDL_A AS  MEDL_A,  ');
      qryEtique.SQL.Add('  CADLOT.LOT_MEDL_L * CADLOT.LOT_MEDL_A AS MEDL_C,  ');
      qryEtique.SQL.Add('  CADLOT.LOT_ESPESS AS  ESPESS,  ');
      qryEtique.SQL.Add('  CADLOT.LOT_PREVE' + IntToStr(intTabPre) + ' AS  PRVMAP,  ');
      qryEtique.SQL.Add('  CADLOT.LOT_VENTO' + IntToStr(intTabPre) + ' AS  PRVMAT,  ');
      qryEtique.SQL.Add('  CADLOT.LOT_MEDL_L * CADLOT.LOT_MEDL_A  AS QTD2ML,  ');
      qryEtique.SQL.Add('  CONCAT(CADLOT.LOT_CODITE, CADLOT.LOT_NUMLOT, CADLOT.LOT_CODEMP) AS  BARMAR,  ');
      qryEtique.SQL.Add('  CADLOT.LOT_PREVE' + IntToStr(intTabPre) + ' AS  PREPPR,  ');
      qryEtique.SQL.Add('  CADLOT.LOT_VENTO' + IntToStr(intTabPre) + ' AS  VENPTR,  ');
      qryEtique.SQL.Add('  CADLOT.LOT_PRVEE' + IntToStr(intTabPre) + ' AS  PRVPPE,  ');
      qryEtique.SQL.Add('  CADLOT.LOT_VETOE' + IntToStr(intTabPre) + ' AS  PRVPET,  ');
    End;
  End;

  qryEtique.SQL.Add('       CADCOR.COR_DETCOR AS DESCOR, ');
  qryEtique.SQL.Add('       COMETI.ETI_COMP10 AS COMP10, ');
  qryEtique.SQL.Add('       CADLOT.LOT_VENTO' + IntToStr(intTabPre) + ' AS VENTOT, ');
  qryEtique.SQL.Add('       CADLOC.LOC_CODLOC AS BARLOC, ');
  qryEtique.SQL.Add('       (IFNULL(CADLOT.LOT_SALDOS, 0) + IFNULL(CADLOT.LOT_QTPDBF, 0) - IFNULL(CADLOT.LOT_SDPDBF, 0)) AS SALLDV,');
  qryEtique.SQL.Add('       (IFNULL(CADLOT.LOT_SALDOS, 0) + IFNULL(CADLOT.LOT_QTPDBF, 0)) AS SALLFR,');
  qryEtique.SQL.Add('     "' + strQtdEmb + '"' + ' AS QTDEMB ');

  If Not fEmptyStr(strChaveTemporariaLotMarmore) Then
  begin
    qryEtique.SQL.Add('  FROM LOTMAR');
    qryEtique.SQL.Add('  LEFT JOIN CADLOT ON CADLOT.LOT_CODITE = LOTMAR.LOT_CODITE');
    qryEtique.SQL.Add('                  AND CADLOT.LOT_CODEMP = LOTMAR.LOT_CODEMP');
    qryEtique.SQL.Add('                  AND CADLOT.LOT_NUMLOT = LOTMAR.LOT_NUMLOT');
    qryEtique.SQL.Add('  LEFT JOIN CADITE ON CADITE.ITE_CODITE = LOTMAR.LOT_CODITE');
    qryEtique.SQL.Add('  LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = LOTMAR.LOT_CODITE AND ITEGER.ITE_CODEMP = LOTMAR.LOT_CODEMP');
  End
  Else
  begin
    qryEtique.SQL.Add('  FROM CADLOT');
    qryEtique.SQL.Add('  LEFT JOIN CADITE ON CADITE.ITE_CODITE = CADLOT.LOT_CODITE');
    qryEtique.SQL.Add('  LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ITEGER.ITE_CODEMP = CADLOT.LOT_CODEMP');
  end;

  qryEtique.SQL.Add('  LEFT JOIN CADLOC ON CADLOC.LOC_CODLOC = CADLOT.LOT_LOCFIS');
  qryEtique.SQL.Add('                  AND CADLOT.LOT_CODEMP = CADLOC.LOC_CODEMP');

  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    qryEtique.SQL.Add('  LEFT JOIN CADLSE ON LSE_CODIGO = LOC_CODLSE ')
  else
    qryEtique.SQL.Add('  LEFT JOIN CADLSE ON CADLSE.LSE_CODIGO = ITEGER.ITE_CODLSE');

  qryEtique.SQL.Add('  LEFT JOIN CADFOR ON CADFOR.FOR_CODFOR = CADITE.ITE_CODFOR');
  qryEtique.SQL.Add('  LEFT JOIN ITEBAR ON CADITE.ITE_CODITE = ITEBAR.BAR_CODITE AND CADITE.ITE_CODBAR = ITEBAR.BAR_CODBAR');
  qryEtique.SQL.Add('  JOIN CADEMP ON CADEMP.EMP_CODEMP = ITEGER.ITE_CODEMP ');


  qryEtique.SQL.Add('  JOIN CADUNI ON CADUNI.UNI_CODUNI = CADITE.ITE_CODUNI');

  qryEtique.SQL.Add('  LEFT JOIN CADCOR ON CADITE.ITE_CODCOR = CADCOR.COR_CODCOR');
  qryEtique.SQL.Add('  LEFT JOIN COMETI ON COMETI.ETI_CODITE = CADITE.ITE_CODITE');

  qryEtique.SQL.Add('  LEFT JOIN (SELECT IF(IPR_PERDES = 0, IPR_PREVEN, ' +' ITE_PREVE' + IfThen(intTabPre > 0, IntToStr(intTabPre), '1')  +  ' - (ITE_PREVE' + IfThen(intTabPre > 0, IntToStr(intTabPre), '1') + ' * IPR_PERDES / 100) ) AS IPR_PREVEN ,');
  qryEtique.SQL.Add('  IPR_CODITE, IPR_PERDES FROM CADPRO JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ');
  qryEtique.SQL.Add('                                   JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ');
  qryEtique.SQL.Add('                                   JOIN ITEGER ON ITEGER.ITE_CODITE = ITEPRO.IPR_CODITE ');
  qryEtique.SQL.Add('                                              AND ITEGER.ITE_CODEMP = PROEMP.PRO_CODEMP ');

  qryEtique.SQL.Add('   WHERE  ');

  qryEtique.SQL.Add('     PROEMP.PRO_CODEMP = :CODEMP AND ' + fCurrentDate + ' BETWEEN PRO_DTAINI AND PRO_DTAFIN) AS TMP ON IPR_CODITE = ITEGER.ITE_CODITE ');
  If blnLoteMarmore And (fEmptyStr(strChaveTemporariaLotMarmore)) Then
     qryEtique.SQL.Add('   AND CADLOT.LOT_CHAPA_ = "S" ');

  If blnTesteL Then
    qryEtique.SQL.Add('LIMIT ' + strLimit)
  Else
  Begin
    qryEtique.SQL.Add('  WHERE TRUE ');
    If blnLoteMarmore And (not fEmptyStr(strChaveTemporariaLotMarmore)) Then
      qryEtique.SQL.Add('AND LOTMAR.LOT_CODEMP =  ' + IIf(fEmptyStr(strCodEmp), QuotedStr(VS_strCodEmp), QuotedStr(strCodEmp)))
    Else
      qryEtique.SQL.Add('AND CADLOT.LOT_CODEMP =  ' + IIf(fEmptyStr(strCodEmp), QuotedStr(VS_strCodEmp), QuotedStr(strCodEmp)));

    if Not fEmptyStr(strLoteAutInc) Then
      qryEtique.SQL.Add('  AND CADLOT.AUTOINCREM IN (' + strLoteAutInc + ')');

    If not fEmptyStr(strForceFiltro) Then
      qryEtique.SQL.Add(strForceFiltro);

    If Not fEmptyStr(strChaveTemporariaLotMarmore) Then
      qryEtique.SQL.Add('  AND LOTMAR.LOT_IDENTI = "' + strChaveTemporariaLotMarmore + '"');

  End;
  If blnAbrirQuery Then
    qryEtique.Open;
end;

Procedure TEditorFast.pConverteImagemTinta;
  Var
    stmImagem: TFileStream;
    imgLogo: TfrxPictureView;
Begin
  If (FileExists('logo_formulacao.jpg')) Then
  Begin
    stmImagem := TFileStream.Create('logo_formulacao.jpg', fmOpenRead);
    imgLogo := TfrxPictureView(FReport.FindObject('imgLogo'));
    If Assigned(imgLogo) Then
      imgLogo.LoadPictureFromStream(stmImagem);
    stmImagem.Free;
  End;
End;

Procedure TEditorFast.pConverteFormulacaoTinta;
  Var
    intIndice: Integer;
    blnApagar: Boolean;
    frxChild : TfrxChild;
    frxCabeca: TfrxHeader;
    frxCabec2: TfrxHeader;
    frxMaster: TfrxMasterData;
    frxMemo  : TfrxMemoView;
    frxMemo1 : TfrxMemoView;
    fltTop   : Double;
Begin
  blnApagar := False;
  intIndice := 0;
  frxCabeca := Nil;

  While intIndice < FReport.ComponentCount Do
  Begin

    If (FReport.Components[intIndice] Is TfrxChild) Then
    Begin
      blnApagar := False;
    End

    Else If (FReport.Components[intIndice] Is TfrxMemoView) Then
    Begin
      frxMemo := TfrxMemoView(FReport.Components[intIndice]);

      If blnApagar Then
      Begin
        Dec(intIndice);
        FreeAndNil(frxMemo);
      End

    End

    Else If (FReport.Components[intIndice] Is TfrxHeader) Then
    Begin
      frxHeaderData := TfrxHeader(FReport.Components[intIndice]);
      frxHeaderData.Top := 0;

      blnApagar := False;

      If SameText(frxHeaderData.Name, 'Header1') Then
        frxCabeca := TfrxHeader(FReport.Components[intIndice]);
    End

    Else If (FReport.Components[intIndice] Is TfrxPageFooter) Then
    Begin
      blnApagar := False;
    End

    Else If (FReport.Components[intIndice] Is TfrxMasterData) Then
    Begin
      frxMaster := TfrxMasterData(FReport.Components[intIndice]);
      blnApagar := SameText(frxMaster.Name, 'Master2Col');
    End;

    Inc(intIndice);
  End;

  frxChild := TfrxChild(FReport.FindObject('Header1Col'));
  If Assigned(frxChild) And Assigned(frxCabeca) Then
  Begin
    frxCabeca.Height := frxCabeca.Height + frxChild.Height;

    frxMemo := TfrxMemoView(FReport.FindObject('memo11'));

    fltTop := 0;
    If Assigned(frxMemo) Then
    Begin
      frxMemo1        := TfrxMemoView.Create(frxCabeca);
      frxMemo1.Parent := frxCabeca;
      frxMemo1.Top    := frxMemo.Top + frxCabeca.Height - frxChild.Height;
      frxMemo1.Text   := frxMemo.Text;
      frxMemo1.Width  := frxMemo.Width;
      frxMemo1.Height := frxMemo.Height;
      frxMemo1.Left   := frxMemo.Left;
      frxMemo1.Font.Assign(frxMemo.Font);
      frxMemo1.HAlign := frxMemo.HAlign;

      fltTop          := frxMemo1.Top;
    End;

    frxMemo := TfrxMemoView(FReport.FindObject('memo10'));
    If Assigned(frxMemo) Then
    Begin
      frxMemo1        := TfrxMemoView.Create(frxCabeca);
      frxMemo1.Parent := frxCabeca;
      frxMemo1.Top    := fltTop;
      frxMemo1.Text   := frxMemo.Text;
      frxMemo1.Width  := frxMemo.Width;
      frxMemo1.Height := frxMemo.Height;
      frxMemo1.Left   := frxMemo.Left;
      frxMemo1.Font.Assign(frxMemo.Font);
    End;

    frxMemo := TfrxMemoView(FReport.FindObject('memo9'));
    If Assigned(frxMemo) Then
    Begin
      frxMemo1        := TfrxMemoView.Create(frxCabeca);
      frxMemo1.Tag    := 1; 
      frxMemo1.Parent := frxCabeca;
      frxMemo1.Top    := frxMemo.Top + frxCabeca.Height - frxChild.Height;
      frxMemo1.Text   := frxMemo.Text;
      frxMemo1.Width  := frxMemo.Width;
      frxMemo1.Height := frxMemo.Height;
      frxMemo1.Left   := frxMemo.Left;
      frxMemo1.Font.Assign(frxMemo.Font);
      frxMemo1.Frame  := frxMemo.Frame;
    End;

    frxMemo := TfrxMemoView(FReport.FindObject('memo16'));
    If Assigned(frxMemo) Then
    Begin
      frxMemo1        := TfrxMemoView.Create(frxCabeca);
      frxMemo1.Tag    := 1; 
      frxMemo1.Parent := frxCabeca;
      frxMemo1.Top    := frxMemo.Top + frxCabeca.Height - frxChild.Height;
      frxMemo1.Text   := frxMemo.Text;
      frxMemo1.Width  := frxMemo.Width;
      frxMemo1.Height := frxMemo.Height;
      frxMemo1.Left   := frxMemo.Left;
      frxMemo1.Font.Assign(frxMemo.Font);
      frxMemo1.Frame  := frxMemo.Frame;
    End;

    FreeAndNil(frxChild);
  End;

  frxCabec2 := TfrxHeader(FReport.FindObject('Header2Col'));
  If Assigned(frxCabec2) Then
    FreeAndNil(frxCabec2);

  frxMaster := TfrxMasterData(FReport.FindObject('Master2Col'));
  If Assigned(frxMaster) Then
    FreeAndNil(frxMaster);

  frxMemo1 := TfrxMemoView.Create(frxCabeca);
  frxMemo1.Parent := frxCabeca;

  For intIndice := 0 To FReport.ComponentCount - 1 Do
  Begin
    If (FReport.Components[intIndice] Is TfrxMemoView) Then
    Begin
      frxMemo := TfrxMemoView(FReport.Components[intIndice]);

      If fEmptyStr(frxMemo.Text) And (frxMemo.Tag <> 1) Then
        FreeAndNil(frxMemo);
    End

    Else If (FReport.Components[intIndice] Is TfrxBarCodeView) Then
    Begin
      TfrxBarCodeView(FReport.Components[intIndice]).Expression := '[CODBAR]';
    End;
  End;
End;

Function TEditorFast.fRetNomArqFr3: String;
Begin
  Case FCodEti Of
    {* CLIENTE *}
    tpeClienteLaser:                Result := fCfgSis('PATETI') + '\etiqueta_laser_cliente.fr3';
    tpeClienteArgox:                Result := fCfgSis('PATETI') + '\etiqueta_argox_cliente.fr3';

    {* FORNECEDOR *}
    tpeFornecedorLaser:             Result := fCfgSis('PATETI') + '\etiqueta_fornecedores.fr3';
    tpeFornecedorArgox:             Result := fCfgSis('PATETI') + '\etiqueta_argox_fornecedor.fr3';

    {* DIVERSOS *}
    tpeDiversosLaser:               Result := fCfgSis('PATETI') + '\etiqueta_laser_diversos.fr3';
    tpeDiversosArgox:               Result := fCfgSis('PATETI') + '\etiqueta_argox_diversos.fr3';

    {* ESTRUTURAS *}
    tpeEstruturaArgox:              Result := fCfgSis('PATETI') + '\etiqueta_argox_codbarra_estrutura.fr3';

    {* ITENS / ITENS DE PEDIDO E ORCAMENTO *}
    tpeItensLaserCodBarPadr,
    tpeItensOrcPedLaserCodBar:      Result := fCfgSis('PATETI') + '\etiqueta_itens_laser_padrao.fr3';
    tpeItensLaserCodBarPers  :      Result := fCfgSis('PATETI') + '\etiqueta_itens_laser_personalizado.fr3';
    tpeItensLaserCodBarSPre  :      Result := fCfgSis('PATETI') + '\etiqueta_itens_laser_sempreco.fr3';
    tpeItensZebraGondolaCPre,
    tpeItensOrcPedZebraGondolaCPre: Result := fCfgSis('PATETI') + '\etiqueta_zebra_gondola.fr3';
    tpeItensZebraGondolaSPre,
    tpeItensOrcPedZebraGondolaSPre: Result := fCfgSis('PATETI') + '\etiqueta_zebra_gondola_sempreco.fr3';
    tpeItensZebraCodBarCPre,
    tpeItensOrcPedZebraCodBarCPre:  Result := fCfgSis('PATETI') + '\etiqueta_zebra_codbarra_compreco.fr3';
    tpeItensZebraCodBarSPre,
    tpeItensOrcPedZebraCodBarSPre:  Result := fCfgSis('PATETI') + '\etiqueta_zebra_codbarra_sempreco.fr3';
    tpeItensArgoxGondolaCPre,
    tpeItensOrcPedArgoxGondolaCPre,
    tpeItensArgoxGondolaCPreLayout1 : Result := fCfgSis('PATETI') + '\etiqueta_argox_gondola.fr3';
    tpeItensArgoxGondolaSPre,
    tpeItensOrcPedArgoxGondolaSPre: Result := fCfgSis('PATETI') + '\etiqueta_argox_gondola_sempreco.fr3';
    tpeItensArgoxCodBarCPre,
    tpeItensOrcPedArgoxCodBarCPre:  Result := fCfgSis('PATETI') + '\etiqueta_argox_codbarra_compreco.fr3';
    tpeItensArgoxCodBarSPre,
    tpeItensOrcPedArgoxCodBarSPre:  Result := fCfgSis('PATETI') + '\etiqueta_argox_codbarra_sempreco.fr3';

    {* PRECIFICAÇÃO DE PRODUTOS *}
    tpePrecificacaoProdutosLaser:   Result := fCfgSis('PATETI') + '\etiqueta_laser_precificacao.fr3';
    tpePrecificacaoProdutosArgox:   Result := fCfgSis('PATETI') + '\etiqueta_argox_precificacao.fr3';

    {* DESPACHO DE MERCADORIAS *}
    tpeDespachoArgox,
    tpeDespachoLaser:               Result := fCfgSis('PATETI') + '\etiqueta_argox_despacho.fr3';

    tpeDespachoProdutoArgox:        Result := fCfgSis('PATETI') + '\etiqueta_argox_despacho_produto.fr3';

    {* CAIXAS *}
    tpeCaixasArgox,
    tpeCaixasLaser:                 Result := fCfgSis('PATETI') + '\etiqueta_caixas.fr3';

    (* TINTA DE MAQUINA *)
    tpeEntregaTintaMaquina:         If FileExists(fCfgSis('PATETI') + '\frxEtiqFormulacaoAutomotiva.fr3') Then
                                      Result := fCfgSis('PATETI') + '\frxEtiqFormulacaoAutomotiva.fr3'
                                    Else If FileExists(fCfgSis('PATETI') + '\frxetiqueta_entrega.fr3') Then
                                      Result := fCfgSis('PATETI') + '\frxetiqueta_entrega.fr3'
                                    Else
                                      Result := fCfgSis('PATETI') + '\frxEtiqFormulacao.fr3';

    (* FORMULACAO DE TINTA DE MAQUINA *)
    tpeFomulacaoTinta     :         If FileExists(fCfgSis('PATETI') + '\frxEtiqFormulacao_CodBarra.fr3') Then
                                      Result := fCfgSis('PATETI') + '\frxEtiqFormulacao_CodBarra.fr3'
                                    Else
                                      Result := fCfgSis('PATETI') + '\frxEtiqFormulacao.fr3';

    (* PRODUCAO TINTA DE MAQUINA *)
    tpeProducaoTintaMaquina:        Result := fCfgSis('PATETI') + '\frxEtiqProducaoTinta.fr3';

//    tpeUnidadesRestantesArgox  :    Result := 'C:\autpas\18\18_ULT\etiqueta_unidades_restante.fr3';

    Else                            Result := '';
  End;
End;

Function TEditorFast.fConverteLayout: Boolean;
  Var
    strNomArq: String;
    mmsRelat : TMemoryStream;
    intIndice: Integer;
Begin
  Result := False;

  If FCodEti In [tpeItensCPF, tpeItensCPFArgox, tpeOPIndustrialArgox, tpeOPIndustrial] Then
    Exit;
  
  strNomArq := fRetNomArqFr3;

  If Not FileExists(strNomArq) Then
  Begin
    If Not fEmptyStr(strNomArq) Then
      If FEtiEmp Then
        pMensagemOk('Arquivo ' + strNomArq + ' não encontrado ou não configurado como padrão para essa empresa!')
      Else
        pMensagemOk('Arquivo ' + strNomArq + ' não encontrado!');
    Exit;
  End;

  Try
    If Not FReport.LoadFromFile(strNomArq) Then
      Exit;
  Except
    pMensagemOk('Arquivo ' + strNomArq + ' incompatível para conversão!');
    Exit;
  End;

  For intIndice := 0 To FReport.DataSets.Count -1 Do
    FReport.DataSets[intIndice].DataSetName := 'frxDBImpEti';

  Case FCodEti Of
    tpeEntregaTintaMaquina: pConverteImagemTinta;
    tpeFomulacaoTinta     : pConverteFormulacaoTinta;
  End;

  frxPage       := fRetfrxPage;
  frxMasterData := fRetfrxMasterData;

  If Not Assigned(frxPage) Then
  Begin
    pMensagemOk('Arquivo ' + strNomArq + ' sem componente de Página');
    Exit;
  End;

  If (Not Assigned(frxMasterData)) And
     (FCodEti <> tpeEntregaTintaMaquina) Then
  Begin
    pMensagemOk('Arquivo ' + strNomArq + ' sem MasterData');
    Exit;
  End;

  (*****************************)
  (* CORREÇÃO LAYOUTS ERRADOS  *)
  (*************************LAG*)
  If Assigned(frxMasterData) Then
  Begin
    If (frxMasterData.ColumnGap / CMPIXEL > 1) Then
    Begin
      If FCodEti In CONJ_LASER Then
      Begin
        If (frxMasterData.Columns < 2) And
           (frxMasterData.ColumnGap < frxPage.Width) Then
          frxMasterData.ColumnWidth := frxPage.Width
        Else
          frxMasterData.ColumnWidth := frxMasterData.ColumnGap;
      End;

      frxMasterData.ColumnGap := 0;
    End;

    If FCodEti In CONJ_ARGOX Then
    Begin
      frxMasterData.Height := frxMasterData.Height + MEIOCMPIXEL;
    End;

  End;

  mmsRelat := TMemoryStream.Create;
  FReport.SaveToStream(mmsRelat);

  FPadrao := True;
  FDescri := 'LAYOUT PADRÃO';

  pInsereRegistro(mmsRelat, True, True);

  Result := fCarregaRegistro(True, '', False);

  FreeAndNil(mmsRelat);
End;

Function TEditorFast.fInsereBeforPrintBarCode(strFr3: String): String;
  Var
    stlTexto: TStringList;
    intIndice,
    intPosBar: Integer;
    strTexto: String;
Begin
  stlTexto := TStringList.Create;

  stlTexto.Text := strFr3;

  For intIndice := 0 To stlTexto.Count - 1 Do
  Begin
    {*************************************************************}
    {* SE FOR IMPRESSÃO DE SEPARAÇÃO DE ROMANEIO (82),           *}
    {* NÃO ADICIONAR ESSE EVENTO, POIS DÁ ERRO NO CAMPO "CDBARO" *}
    {**********************************************************MM*}
    If Not ( ARR_TIPO_LAYOUT[FCodEti] = 82 ) Then
    Begin
      intPosBar := Pos('<TfrxBarCodeView', stlTexto[intIndice]);
      If intPosBar > 0 Then
      Begin
        strTexto := stlTexto[intIndice];
        Insert(' OnBeforePrint = "CodBarOnBeforePrint" ', strTexto,
               intPosBar + Length('<TfrxBarCodeView') + 1);
        stlTexto[intIndice] := strTexto;
      End;
    End;

    intPosBar := Pos('<TfrxReportSummary', stlTexto[intIndice]);
    If intPosBar > 0 Then
    Begin
      strTexto := stlTexto[intIndice];
      Insert(' OnBeforePrint = "SummaryOnBeforePrint" ', strTexto,
             intPosBar + Length('<TfrxReportSummary') + 1);
      stlTexto[intIndice] := strTexto;
    End;


    If Feditor.blnFooNewPage Then
    begin
      intPosBar := Pos('<TfrxFooter', stlTexto[intIndice]);
      If intPosBar > 0 Then
      Begin
        strTexto := stlTexto[intIndice];
        Insert(' OnAfterPrint = "FooterOnAfterPrint" ', strTexto,
               intPosBar + Length('<TfrxFooter') + 1);
        stlTexto[intIndice] := strTexto;
      End;
    End;


    If FEditor.blnViaPag Then
    Begin
      intPosBar := Pos('<TfrxFooter', stlTexto[intIndice]);
      If intPosBar > 0 Then
      Begin
        strTexto := stlTexto[intIndice];
        Insert(' OnBeforePrint = "FooterOnBeforePrint" ', strTexto,
               intPosBar + Length('<TfrxFooter') + 1);
        stlTexto[intIndice] := strTexto;
      End;

      intPosBar := Pos('<TfrxHeader', stlTexto[intIndice]);
      If intPosBar > 0 Then
      Begin
        strTexto := stlTexto[intIndice];
        Insert(' OnBeforePrint = "HeaderOnBeforePrint" ', strTexto,
               intPosBar + Length('<TfrxHeader') + 1);
        stlTexto[intIndice] := strTexto;
      End;


      intPosBar := Pos('<TfrxMasterData Name="MasterData1"', stlTexto[intIndice]);
      If intPosBar > 0 Then
      Begin
        strTexto := stlTexto[intIndice];
        Insert(' OnBeforePrint = "MasterData1OnBeforePrint" ', strTexto,  intPosBar + Length('<TfrxMasterData Name="MasterData1"') + 1);
        stlTexto[intIndice] := strTexto;
      End;

    End Else
    Begin
      If FMeiaFolha = 'S' Then
      Begin
        intPosBar := Pos('<TfrxReportPage Name="Page1"', stlTexto[intIndice]);
        If intPosBar > 0 Then
        Begin
          strTexto := stlTexto[intIndice];
          Insert(' OnBeforePrint = "Page1OnBeforePrint" ', strTexto,  intPosBar + Length('<TfrxReportPage Name="Page1"') + 1);
          stlTexto[intIndice] := strTexto;
        End;

        intPosBar := Pos('<TfrxMasterData Name="MasterData1"', stlTexto[intIndice]);
        If intPosBar > 0 Then
        Begin
          strTexto := stlTexto[intIndice];
          Insert(' OnAfterPrint = "MasterData1OnAfterPrint" ', strTexto,  intPosBar + Length('<TfrxMasterData Name="MasterData1"') + 1);
          stlTexto[intIndice] := strTexto;
        End;

        intPosBar := Pos('<TfrxFooter Name="Footer"', stlTexto[intIndice]);
        If intPosBar > 0 Then
        Begin
          strTexto := stlTexto[intIndice];
          Insert(' OnBeforePrint = "FooterOnBeforePrint" ', strTexto,  intPosBar + Length('<TfrxFooter Name="Footer"') + 1);
          stlTexto[intIndice] := strTexto;
        End;

      End;


      intPosBar := Pos('<TfrxHeader', stlTexto[intIndice]);
      If intPosBar > 0 Then
      Begin
        strTexto := stlTexto[intIndice];
        Insert(' OnBeforePrint = "HeaderOnBeforePrint" ', strTexto,
               intPosBar + Length('<TfrxHeader') + 1);
        stlTexto[intIndice] := strTexto;
      End;

    End;

  End;

  Result := stlTexto.Text;
  stlTexto.Clear;
  FreeAndNil(stlTexto);
End;


Function TEditorFast.fCarregaRegistro(blnPadrao: Boolean;
                                      strCodLay: String;
                                      blnConverter: Boolean = True): Boolean;
 Var
   mmsLoad: TStream;
Begin
  Try

    FGpVePx := 0;
    FblnReformaPedidoCompra := False;

    With FLayEti, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM ');
      Add('LAYETI');
      Add('  WHERE ');

      If FHerdar Then
        Add('  TRUE ')
      Else
        Add('  LAY_TIPLAY = :TIPLAY');

      If (FCodEti = tpeEntregaTintaMaquina) And (fCfgSis('ELAYET') = 'S') Then
        Add(' AND LAY_PADRAO IN ("S", "N")  ')
      Else If blnPadrao Then
        Add(' AND LAY_PADRAO = "S"  ')
      Else
        Add(' AND LAY_CODLAY = ' + QuotedStr(strCodLay));

      If (Assigned(FEditor) And (FEditor.tplTipLay = tplDocumentos)) Or (FEtiEmp And blnPadrao) Then
        Add('  AND LAY_CODEMP = ' + QuotedStr(VS_strCodEmp));

      If fEmptyStr(strCodLay) Then
      Begin
        If (FEtiEmp And blnPadrao) Then
          Add('  AND LAY_ETIEMP = "S" ')
        Else
          Add('  AND LAY_ETIEMP = "N" ');
      End;

      If Not FHerdar Then
        ParamByName('TIPLAY').AsInteger := ARR_TIPO_LAYOUT[FCodEti]
      Else If Assigned(FEditor) And (FEditor.tplTipLay = tplDocumentos) Then
        Add(' AND LAY_TIPREG = 1');

      Add('       ORDER BY LAY_DTAALT DESC, LAY_HORALT DESC ');

      Open;

      If IsEmpty Then
      Begin
        FDescri  := '';

        If blnPadrao And blnConverter Then
          Result   := fConverteLayout
        Else
          Result := False;

      End Else
      Begin
        If (FCodEti = tpeOPIndustrial ) Or (FCodEti = tpeOPIndustrialArgox) Then
        Begin
          if (RecordCount > 1) And (fEmptyStr(strCodLay)) Then
            TfrmSelecionaLayout.pSelecionaLayout(FLayEti);
        End
        Else If (FCodEti = tpeEntregaTintaMaquina) And (fCfgSis('ELAYET') = 'S') Then
        Begin
          if RecordCount > 1 Then
            TfrmSelecionaLayout.pSelecionaLayout(FLayEti);
        End;

        FPadrao := FieldByName('LAY_PADRAO').AsString = 'S';
        FDescri := FieldByName('LAY_DESCRI').AsString;
        FOrdena := FieldByName('LAY_ORDENA').AsString;

        If Assigned(FObjOrd) Then
          FreeAndNil(FObjOrd);

        FObjOrd := TOrdenacao.Create(Self, FOrdena, ARR_CODIGO_ETIQUETA[FCodEti]);

        If FieldByName('LAY_GAPVER').IsNull Then
          FGpVePx := -1
        Else
          FGpVePx := FieldByName('LAY_GAPVER').AsFloat;

        If Assigned(FEditor) Then
        Begin
          FEditor.blnViaPag     := FieldByName('LAY_VIAPAG').AsInteger > 1;
          FEditor.intEspaca     := FieldByName('LAY_ESPACA').AsInteger;
          FEditor.intLinCommand := FieldByName('LAY_LINCOM').AsInteger;
          FEditor.strInfHei     := FieldByName('LAY_INFHEI').AsString;
          FEditor.strAvnPag     := FieldByName('LAY_AVNPAG').AsString;
          FEditor.blnFooBra     := FieldByName('LAY_FOOBRA').AsString = 'S';
          FEditor.blnImpPDF     := FieldByName('LAY_IMPPDF').AsString = 'S';
          FEditor.strCabPri     := FieldByName('LAY_CABPRI').AsString;
          FEditor.blnFooNewPage := FieldByName('LAY_FOONWP').AsString = 'S';          
        End;

        FViaPag := FieldByName('LAY_VIAPAG').AsInteger > 1;

        FInfHei := FieldByName('LAY_INFHEI').AsString;

        FMeiaFolha := FieldByName('LAY_MEIAFO').AsString;

        If (FieldByName('LAY_TIPIMP').AsString = 'M') And Assigned(FEditor) Then
        Begin
          FEditor.ppzPapSiz.intPapCur := FieldByName('LAY_TIPMAT').AsInteger;
          FEditor.intEscMod           := FieldByName('LAY_ESCMOD').AsInteger;
        End;

        If Assigned(FEditor) Then
          FEditor.blnConPro := (FieldByName('LAY_CONPRO').AsInteger = 1);

        Edit;

        If Assigned(FEditor) And (FEditor.tplTipLay <> tplDocumentos) Then
          FieldByName('LAY_RELFR3').AsString := fInsereBeforPrintBarCode(FieldByName('LAY_RELFR3').AsString);

       {$IFNDEF LINUX}
        // pedido de compra: layout ainda sem a reforma ja abre com CBS / IBS / IS; ao salvar grava LAY_REFTRI
        If (FCodEti = tpePedidoCompra) And Assigned(FEditor) And (FEditor.tplTipLay = tplDocumentos) And
           (FieldByName('LAY_TIPIMP').AsString <> 'M') Then
        Begin
          FblnReformaPedidoCompra := fLayoutComReformaPedidoCompra(FLayEti);

          If (Not FblnReformaPedidoCompra) And fSomarNovosImpostosDaReformaAoValorContabil Then
          Begin
            FieldByName('LAY_RELFR3').AsBytes := fInjetaReformaPedidoCompra(FieldByName('LAY_RELFR3').AsBytes);
            FblnReformaPedidoCompra := True;
          End;
        End;
       {$ENDIF}

        mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmReadWrite);
        FReport.LoadFromStream(mmsLoad);

        Cancel;

        FreeAndNil(mmsLoad);
        Result := True;
      End;
    End;

    frxMasterData := fRetfrxMasterData;

    If Assigned(FEditor) And (FEditor.tplTipLay <> tplDocumentos) Then
      FReport.ScriptText.Text := fMontaScript;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCarregaRegistro]');
    End;
  End;

  If Not Result Then
  Begin
    If Assigned(FCmpMvl) Then
      FCmpMvl.pNovoLayout(True);
  End;
End;

Function TEditorFast.fCarregar(blnPadrao: Boolean; strCodLay: String = ''): Boolean;
Begin
  Try
    Result := False;

    FCmpMvl.pNovoLayout(False);

    If Not fCarregaRegistro(blnPadrao, strCodLay) Then
      Exit;

    If Not fCarregaPagina Then
      Exit;

    If Not fCarregaEtiqueta Then
      Exit;

    FEditor.pSetaRegua;

    pCamposToEditor;

    FPadrao := (Not FHerdar) And (FLayEti.FieldByName('LAY_PADRAO').AsString = 'S');

    If FHerdar Then
      FCodDoc := ''
    Else
      FCodDoc := FLayEti.FieldByName('LAY_CODLAY').AsString;

    Result  := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCarregar]');
    End;
  End;

End;

Function TEditorFast.fCarregaPagina: Boolean;
Begin
  Result := False;

  With FEditor, dadMargem, ppzPapSiz Do
  Begin
    frxPage       := fRetfrxPage;
    frxHeader     := fRetfrxHeader;
    frxHeaderData := fRetfrxHeaderData;
    frxFooterData := fRetfrxFooterData;
    frxPageFooter := fRetfrxPageFooter;
    frxSummary    := fRetfrxSummary;

    If Assigned(frxPage.BackPicture.Graphic) Then
      FMarcaDagua.Assign( frxPage.BackPicture.Graphic );

    If Not Assigned(frxPage) Then
      Exit;

    intPagFrx := frxPage.PaperSize;
    ppzPapSiz.porOrient := frxPage.Orientation;

    If blnViaPag Then
    Begin
      frxPageVias := fRetfrxPageVias;
      If Assigned(frxPageVias) Then
        strNomPapVias := string(FArrPpz[frxPageVias.PaperSize].strNomPap);
    End;

    blnSemFim := frxPage.EndlessHeight;

    If (intPapCur = fIndiceCustom(strTipImp)) Then
    Begin
      If (strTipImp = 'J') Then
      Begin
        ppzPapSiz.fltCusWid := (frxPage.PaperWidth  / 10);
        ppzPapSiz.fltCusHei := (frxPage.PaperHeight / 10);
      End Else
      Begin
        ppzPapSiz.fltCusHei := Trunc(frxPage.PaperHeight / 4.4979137617640235);
      End;
    End;

    If (strTipImp = 'J') Then
    Begin
      fltMarDir := (frxPage.RightMargin  / 10);
      fltMarEsq := (frxPage.LeftMargin   / 10);
      fltMarSup := (frxPage.TopMargin    / 10);
      fltMarInf := (frxPage.BottomMargin / 10);
    End Else
    Begin
      fltMarDir := Trunc(frxPage.RightMargin  / FATOR_MARGEM_HORIZONTAL);
      fltMarEsq := Trunc(frxPage.LeftMargin   / FATOR_MARGEM_HORIZONTAL);
      fltMarSup := Trunc(frxPage.TopMargin    / FATOR_MARGEM_VERTICAL);
      fltMarInf := Trunc(frxPage.BottomMargin / FATOR_MARGEM_VERTICAL);
    End;

    FEditor.intMolLar := Trunc(frxPage.Frame.Width);

    If (frxPage.Frame.Width > 0) And (strTipImp = 'J') Then
    Begin
      FEditor.blnMolEsq := (ftLeft In frxPage.Frame.Typ);
      FEditor.blnMolSup := (ftTop In frxPage.Frame.Typ);
      FEditor.blnMolInf := (ftBottom In frxPage.Frame.Typ);
      FEditor.blnMolDir := (ftRight In frxPage.Frame.Typ);
    End;

  End;

  Result := True;
End;

Function TEditorFast.fCarregaEtiqueta: Boolean;
Begin

  With FEditor, ppzPapSiz Do
  Begin
    frxMasterData := fRetfrxMasterData;

    If Assigned(frxMasterData) Then
    Begin
      If frxPage.Columns > 0 Then
      Begin
        intNrCoEt := frxPage.Columns;
        frxMasterData.ColumnWidth := frxMasterData.Width;
        frxPage.Columns := 0;
      End

      Else intNrCoEt := frxMasterData.Columns;

      fltAltEPx := frxMasterData.Height;
      fltLarEPx := frxMasterData.ColumnWidth;
    End Else
    Begin
      intNrCoEt := frxPage.Columns;

      If FTipImp = 'J' Then
      Begin
        fltAltEPx := frxPage.Height - fCmColunaToPixel(frxPage.TopMargin / 10, True, FTipImp) - fCmColunaToPixel(frxPage.BottomMargin / 10, True, FTipImp);
        fltLarEPx := frxPage.Width  - fCmColunaToPixel(frxPage.LeftMargin / 10, False, FTipImp) - fCmColunaToPixel(frxPage.RightMargin / 10, False, FTipImp);
      End Else
      Begin
        fltAltEPx := frxPage.Height - fMargemmFastMatricialToPixels(frxPage.TopMargin, True) - fMargemmFastMatricialToPixels(frxPage.BottomMargin, True);
        fltLarEPx := frxPage.Width  - fMargemmFastMatricialToPixels(frxPage.LeftMargin, False) - fMargemmFastMatricialToPixels(frxPage.RightMargin, False);
      End;
    End;

    If intNrCoEt = 0 Then
      intNrCoEt := 1;

    If fltLarEtq = 0 Then
      fltLarEtq := ppzPapSiz.fltCusWid;

    If Assigned(frxMasterData) Then
      fltGpHrPx := frxMasterData.ColumnGap
    Else
      fltGpHrPx := 0;

    If FGpVePx < 0 Then
      FGpVePx := fltGpHrPx;

    fltGpVrEt := fPixelToCmColuna(FGpVePx, False, FTipImp);
    fltGpVrPx := FGpVePx;
  End;

  Result := True;
End;

Procedure TEditorFast.pImagemToEditor(frxImagem: TfrxPictureView);
  Var
    intTop: Double;
    wncParent: TWinControl;
Begin
  With frxImagem, FCmpMvl Do
  Begin
    wncParent := fParentEditor(top, intTop);
    pCriaNovoCampo(wncParent,
                   Left,
                   intTop,
                   '',
                   frxImagem.DataField,
                   frxImagem.DataSetName,
                   camImagem,
                   0,
                   False,
                   False,
                   False,
                   False,
                   Font,
                   colVazio,
                   TfrxHAlign.haLeft,
                   False,
                   False,
                   aprImagem,
                   0,
                   Width,
                   Height,
                   Color,
                   False,
                   bcCodeEAN13,
                   bcCodeQR,
                   1,
                   0,
                   Center,
                   Stretched,
                   Picture);
  End;
End;

Procedure TEditorFast.pBarCodeToEditor(frxBarCod: TfrxBarCodeView);
  Var
    strCodCam,
    strCaption: String;
    tcmTipCam: TTipoCampoEditor;
    intTop: Double;
    wncParent: TWinControl;
Begin
  With frxBarCod Do
  Begin
    // Vamos usar a propriedade TagStr para armazenar um Zoom fixo para não redimensionar o código de barras
    FEditor.dblZooFix := StrToFloatDef(TagStr, 0);

    If Not fEmptyStr(Expression) Then
    Begin
      If Not fVerificaExpressao('[' + Expression + ']', strCodCam, strCaption, tcmTipCam) Then
        Exit;
    End

    Else If Not fEmptyStr(DataField) Then
    Begin
      tcmTipCam  := camNormal;
      strCaption := '';

      With FTabCam Do
      If Locate('CAM_EXPCAM', DataField, []) Then
        strCodCam  := FieldByName('CAM_CODCAM').AsString

      Else If FHerdar Then
             Exit;
    End

    Else If Not fEmptyStr(Text) Then
    Begin
      tcmTipCam  := camExpressao;
      strCaption := Text;
      strCodCam  := QuotedStr(Text);
    End;

    With FCmpMvl Do
    Begin
      wncParent := fParentEditor(top, intTop);

      pCriaNovoCampo(wncParent,
                     Left,
                     intTop,
                     strCaption,
                     strCodCam,
                     '',
                     tcmTipCam,
                     0,
                     False,
                     False,
                     False,
                     False,
                     Font,
                     colVazio,
                     HAlign,
                     False,
                     False,
                     aprCodeBar,
                     Rotation,
                     Width,
                     Height,
                     Color,
                     ShowText,
                     BarType,
                     bcCodeQR,
                     Zoom,
                     FEditor.dblZooFix,
                     True,
                     True,
                     nil,
                     2,
                     ftString,
                     False,
                     False,
                     0,
                     CalcCheckSum);
    End;
  End;
End;

Procedure TEditorFast.pQRCodeToEditor(frxBarCod: TfrxBarCode2DView);
  Var
    strCodCam,
    strCaption: String;
    tcmTipCam: TTipoCampoEditor;
    intTop: Double;
    wncParent: TWinControl;
Begin
  With frxBarCod Do
  Begin
    If Not fEmptyStr(Expression) Then
    Begin
      If Not fVerificaExpressao('[' + Expression + ']', strCodCam, strCaption, tcmTipCam) Then
        Exit;
    End

    Else If Not fEmptyStr(DataField) Then
    Begin
      tcmTipCam  := camNormal;
      strCaption := '';

      With FTabCam Do
      If Locate('CAM_EXPCAM', DataField, []) Then
        strCodCam  := FieldByName('CAM_CODCAM').AsString

      Else If FHerdar Then
             Exit;
    End

    Else If Not fEmptyStr(Text) Then
    Begin
      tcmTipCam  := camExpressao;
      strCaption := Text;
      strCodCam  := QuotedStr(Text);
    End;

    With FCmpMvl Do
    Begin
      wncParent := fParentEditor(top, intTop);

      pCriaNovoCampo(wncParent,
                     Left,
                     intTop,
                     strCaption,
                     strCodCam,
                     '',
                     tcmTipCam,
                     0,
                     False,
                     False,
                     False,
                     False,
                     Font,
                     colVazio,
                     HAlign,
                     False,
                     False,
                     aprQRCODE,
                     Rotation,
                     Width,
                     Height,
                     Color,
                     ShowText,
                     bcCodeEAN13,
                     BarType,
                     Zoom,
                     0,
                     True,
                     True,
                     nil,
                     2,
                     ftString,
                     False,
                     False,
                     0,
                     False);
    End;
  End;
End;

Procedure TEditorFast.pTextoToEditor(frxCampo: TfrxCustomMemoView);
  Var
    strCodCam,
    strCaption: String;
    tcmTipCam: TTipoCampoEditor;
    intNroDec: Integer;
    fdtTipFil: TFieldType;
    intTop: Double;
    wncParent: TWinControl;
Begin
  With frxCampo Do
  Begin

    If SameText(frxCampo.Name, 'mmoZebra') Then
    Begin
      FEditor.blnZebra  := Not fEmptyStr(frxCampo.Highlight.Condition);
      FEditor.expZebra  := frxCampo.Highlight.Condition;
      FEditor.intMolDad := Trunc(Frame.Width);
      FEditor.clrZebra  := Highlight.Color;
      Exit;
    End

    Else If SameText(frxCampo.Name, 'mmoCorHeaderData') Then
    Begin
      FEditor.intHeaderDataMol := Trunc(Frame.Width);
      FEditor.clrHeaderDataCor := frxCampo.Color;
      If FEditor.clrHeaderDataCor = clNone Then
        FEditor.clrHeaderDataCor := clWhite;
      Exit;
    End

    Else If SameText(frxCampo.Name, 'mmoCorFooterData') Then
    Begin
      FEditor.intFooterDataMol := Trunc(Frame.Width);
      FEditor.clrFooterDataCor := frxCampo.Color;
      If FEditor.clrFooterDataCor = clNone Then
        FEditor.clrFooterDataCor := clWhite;
      Exit;
    End;

    If SameText(Name, 'NROPG1') Or
       SameText(Name, 'NROPG2') Then
    Begin

      strCaption := '';
      tcmTipCam  := camNormal;

      With FTabCam Do
      If Locate('CAM_EXPCAM', frxCampo.Name, []) Then
      Begin
        strCodCam  := FieldByName('CAM_CODCAM').AsString;
        strCaption := FieldByName('CAM_DESCAM').AsString;
      End

      Else If FHerdar Then
        Exit;
    End

    Else If Not fVerificaExpressao(Text, strCodCam, strCaption, tcmTipCam) Then
    Begin
      Exit;
    End;   

    If (DisplayFormat.Kind = fkNumeric) And
       (Not fEmptyStr(DisplayFormat.FormatStr)) Then
      intNroDec := StrToIntDef(DisplayFormat.FormatStr[4], 2)
    Else
      intNroDec := -1;

    If (tcmTipCam = camNormal) And
       FTabCam.Locate('CAM_CODCAM', strCodCam, []) Then
      fdtTipFil :=  FCmpMvl.fRetTipoDado(FTabCam.FieldByName('CAM_TIPCAM').AsString)
    Else
      fdtTipFil := ftString;

    With FCmpMvl Do
    Begin
      wncParent := fParentEditor(top, intTop);

      pCriaNovoCampo(wncParent,
                     Left,
                     intTop,
                     strCaption,
                     strCodCam,
                     '',
                     tcmTipCam,
                     Frame.Width,
                     (ftTop In Frame.Typ),
                     (ftBottom In Frame.Typ),
                     (ftLeft In Frame.Typ),
                     (ftRight In Frame.Typ),
                     Font,
                     fTextoToColMat(Description),
                     HAlign,
                     WordWrap,
                     HideZeros,
                     aprTexto,
                     Rotation,
                     Width,
                     Height,
                     Color,
                     False,
                     bcCodeEan13,
                     bcCodeQR,
                     1,
                     0,
                     True,
                     True,
                     Nil,
                     intNroDec,
                     fdtTipFil,
                     AutoWidth,
                     (StretchMode = smMaxHeight),
                     frxCampo.Tag);

    End;
  End;
End;

Procedure TEditorFast.pHeaderToEditor(frxHeader: TfrxPageHeader);
Begin
  FEditor.blnHeader := True;
  FEditor.fltHeaAlt := fPixelToCmColuna(frxHeader.Height, True, FTipImp, False);
End;

Procedure TEditorFast.pHeaderDataToEditor(frxHeaderData: TfrxHeader);
Begin
  frxHeaderData.ReprintOnNewPage := True;
  FEditor.blnHeaderData := True;
  FEditor.fltHeaDataAlt := fPixelToCmColuna(frxHeaderData.Height, True, FTipImp, False);
End;

Procedure TEditorFast.pFooterToEditor(frxPageFooter: TfrxPageFooter);
Begin
  FEditor.blnImpUlt := FEditor.blnFooBra;
  FEditor.blnFooter := True;
  FEditor.fltFooAlt := fPixelToCmColuna(frxPageFooter.Height, True, FTipImp, False);
End;

Procedure TEditorFast.pSummaryToEditor(frxSummary: TfrxReportSummary);
Begin
  FEditor.blnImpUlt := True;
  FEditor.blnFooter := True;
  If Assigned(frxSummary) Then
    FEditor.fltFooAlt := fPixelToCmColuna(frxSummary.Height, True, FTipImp, False);
End;

Procedure TEditorFast.pFooterDataToEditor(frxFooterData: TfrxFooter);
Begin
  FEditor.blnFooterData := True;
  FEditor.fltFooDataAlt := fPixelToCmColuna(frxFooterData.Height, True, FTipImp, False);
End;

function TEditorFast.fCamposToEditor(pgbProgresso: TcxProgressBar): Boolean;
  Var
    intIndice: Integer;
    blnDocs: Boolean;
Begin
  FEditor.blnZebra      := False;
  FEditor.dblZooFix     := 0;
  FEditor.expZebra      := '';
  FEditor.blnFooterData := False;
  FEditor.blnFooter     := False;
//  FEditor.blnImpUlt     := False;

  FEditor.blnHeader := False;
  FEditor.fltHeaAlt := 0;

  FParent := frxMasterData;

  pgbProgresso.Properties.Max := FReport.ComponentCount;

  For intIndice := 0 To FReport.ComponentCount - 1 Do
  Begin
    If (FReport.Components[intIndice] Is TfrxPageHeader) Then
    Begin
      If Not SameText((FReport.Components[intIndice] As TfrxPageHeader).Name, 'HeaderVias') Then
      Begin
        FParent := TfrxPageHeader(FReport.Components[intIndice]);
        pHeaderToEditor(TfrxPageHeader(FReport.Components[intIndice]))
      End;
    End

    Else If (FReport.Components[intIndice] Is TfrxBarCodeView) Then
      pBarCodeToEditor(TfrxBarCodeView(FReport.Components[intIndice]))

    Else If (FReport.Components[intIndice] Is TfrxBarCode2DView) Then
      pQRCODEToEditor(TfrxBarCode2DView(FReport.Components[intIndice]))

    Else If (FReport.Components[intIndice] Is TfrxMemoView) Then
    Begin

      If Not SameText((FReport.Components[intIndice] As TfrxMemoView).Name, 'MemoFooterProx') Then
      Begin

        pTextoToEditor(TfrxMemoView(FReport.Components[intIndice]))

      End;

    End
      
    Else If (FReport.Components[intIndice] Is TfrxDMPMemoView) Then
    Begin

      If Not SameText((FReport.Components[intIndice] As TfrxDMPMemoView).Name, 'MemoFooterProx') Then
      Begin

        pTextoToEditor(TfrxDMPMemoView(FReport.Components[intIndice]))

      End;
      
    End

    Else If (FReport.Components[intIndice] Is TfrxPictureView) Then
      pImagemToEditor(TfrxPictureView(FReport.Components[intIndice]))

    Else If (FReport.Components[intIndice] Is TfrxHeader) Then
    Begin
      blnDocs := (Not Assigned(FEditor)) Or (FEditor.tplTipLay = tplDocumentos);

      If blnDocs Then
      Begin
        FParent := TfrxHeader(FReport.Components[intIndice]);
        pHeaderDataToEditor(TfrxHeader(FReport.Components[intIndice]))
      End;

    End

    Else If (FReport.Components[intIndice] Is TfrxPageFooter) Then
    Begin

      If (Not SameText((FReport.Components[intIndice] As TfrxPageFooter).Name, 'PageFooterProx')) And
         (Not SameText((FReport.Components[intIndice] As TfrxPageFooter).Name, 'FooterVias')) Then
      Begin
        FParent := TfrxPageFooter(FReport.Components[intIndice]);
        pFooterToEditor(TfrxPageFooter(FReport.Components[intIndice]));
      End;

    End

    Else If (FReport.Components[intIndice] Is TfrxReportSummary) Then
    Begin
      FParent := TfrxReportSummary(FReport.Components[intIndice]);
      pSummaryToEditor(TfrxReportSummary(FReport.Components[intIndice]));
    End

    Else If (FReport.Components[intIndice] Is TfrxFooter) Then
    Begin
      FParent := TfrxFooter(FReport.Components[intIndice]);
      pFooterDataToEditor(TfrxFooter(FReport.Components[intIndice]));
    End

    Else If (FReport.Components[intIndice] Is TfrxMasterData) Then
    Begin
      FParent := TfrxMasterData(FReport.Components[intIndice]);
    End;

    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
    
  End;

  Result := True;

  If FTipImp = 'M' Then
    FEditor.pSetaRegua;
End;

Procedure TEditorFast.pCamposToEditor;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);

  frmGravando.Height := 40;
  frmGravando.lblGravando.Align      := alClient;
  frmGravando.lblGravando.Font.Size  := 9;
  frmGravando.lblGravando.Caption    := 'Carregando Layout...';
  frmGravando.fExecutarAcao := fCamposToEditor;
  frmGravando.ShowModal;

  pFreeAndNil(frmGravando)
End;

Function TEditorFast.fExisteCampo(strCampo: String): Boolean;
  Var
    qryCamEti: TUniQuery;
Begin
  qryCamEti := fCriaQuery(Self);
  With qryCamEti, SQL Do
  Begin
    Add('SELECT');
    Add('  COUNT(*) AS QTD');
    Add('FROM');
    Add('  CAMETI');
    Add('WHERE');

    Add('  CAM_EXPCAM = :EXPCAM ');

    ParamByName('EXPCAM').AsString := strCampo;
    Open;

    Result := Not IsEmpty;

    Close;
  End;
  FreeAndNil(qryCamEti)
End;

(***************************************************************)
(* ESSA FUNCAO ESTÁ MEIA BOCA                                  *)
(* PRECISARIA CRIAR PILHAS PARA TRATAR AS EXPRESSOES ANINHADAS *)
(* MAS O TEMPO CORRE...SACUMÉ NÉ                               *)
(************************************************************LA*)
Function TEditorFast.fVerificaExpressao(strExpFr3: String;
      Var strCodCam, strCaption: String; Var tcmTipCam: TTipoCampoEditor): Boolean;
  Var
    parParser: TParser;
    strExpres,
    strMascar,
    strCamExp: String;
    strTokIde: Char;
    strStream: TStringStream;
    blnLeuCam,
    blnAbrCol,
    blnAbrCmp,
    blnEcoExp,
    blnFormat,
    blnBDImpE,
    blnTokAnt,
    blnTxtSQt, // Texto sem quote
    blnPage,
    blnTotPag: Boolean;

    intContador: Integer;
Begin
  Result    := True;

  blnTokAnt := False;
  blnTxtSQt := False;
  blnAbrCmp := False;
  blnAbrCol := False;
  blnFormat := False;
  blnBDImpE := False;
  blnPage   := False;
  blnTotPag := False;

  blnLeuCam := False;
  strStream := TStringStream.Create(strExpFr3);
  strStream.Position := 0;
  parParser := TParser.Create(strStream);

  strExpres := '';
  strMascar := '';
  strCamExp := '';

  intContador := 0;

  While parParser.token <> toEOF Do
  Begin
    Inc(intContador);

    strTokIde := parParser.Token;

    If blnAbrCmp And (strTokIde <> #1) And (strTokIde <> '.') And (strTokIde <> '"') And
      ((strTokIde <> '>') Or ((intContador = 1) And (strTokIde = '>'))) Then
    Begin
      blnAbrCmp := False;

      If strTokIde = '>' Then
        strExpres := strExpres + ' <'
      Else
        strExpres := strExpres + ' < ';
    End;

    Case strTokIde Of
      #1:  Begin // SIMBOLO (CAMPO) E FUNCOES
             If Not blnAbrCol Then
             Begin

               If Not blnTxtSQt Then
               Begin
                 If Not fEmptyStr(strExpres) Then
                   strExpres := strExpres + ' + ';

                 strExpres := strExpres + ''''; // Abre quote
               End;

               If blnTokAnt Then
                 strExpres := strExpres + parParser.TokenString
               Else
                 If Not blnTxtSQt Then
                   strExpres := Trim(strExpres + parParser.TokenString)
                 Else
                   strExpres := Trim(strExpres + ' ' + parParser.TokenString);

               blnTxtSQt := True;
             End

             Else If SameText(parParser.TokenString, 'FormatMaskText') Then
             Begin
               blnFormat := True;
             End

             Else If (Pos('FRX', UpperCase(parParser.TokenString)) > 0) Then
             Begin
               blnBDImpE := True;
             End

             Else If FTabCam.Locate('CAM_EXPCAM', parParser.TokenString, []) Then
             Begin
               If blnFormat Then // ACHOU O CAMPO DA FUNCAO FormatMaskText
               Begin

               End Else
               Begin
                 blnLeuCam := True;
                 strExpres := strExpres + ' ' + FTabCam.FieldByName('CAM_CODCAM').AsString;
               End;
             End

             Else
             Begin
               If FHerdar And Not fExisteCampo(parParser.TokenString) Then
               Begin
                 FreeAndNil(parParser);
                 FreeAndNil(strStream);
                 Result := False;
                 Exit;
               End;

               If SameText(parParser.TokenString, 'intPagina') Then
               Begin
                 strExpres := strExpres + ' NROPAG';
                 blnLeuCam := FTabCam.Locate('CAM_EXPCAM', 'NROPAG', []);
               End Else
               Begin
                 strExpres := strExpres + ' ' + parParser.TokenString;
               End;

               blnPage      := SameText(parParser.TokenString, 'Page');

               blnTotPag    := SameText(parParser.TokenString, 'TotalPages');
             End;

           End;

      #2:  Begin // STRING (ENTRE QUOTES)

             If blnFormat Then // ACHOU A MASCARA DA FUNCAO FormatMaskText
             Begin
               strMascar := parParser.TokenString;
             End Else
             Begin

               If (parParser.TokenString = #0) And blnPage Then
               Begin
                 Delete(strExpres, Length(strExpres) - Pred(Length('Page')), Length('Page'));
                 strExpres := strExpres + 'NROPAG';
                 blnLeuCam := FTabCam.Locate('CAM_EXPCAM', 'NROPAG', []);
               End

               Else If (parParser.TokenString = #0) And blnTotPag Then
               Begin
                 Delete(strExpres, Length(strExpres) - Pred(Length('TotalPages')), Length('TotalPages'));
                 strExpres := strExpres + 'TOTPAG';
                 blnLeuCam := FTabCam.Locate('CAM_EXPCAM', 'TOTPAG', []);
               End

               Else strExpres := strExpres + ' ' + QuotedStr(parParser.TokenString);
             End;

           End;
      Else Begin
             If blnFormat Then // ( , < . > )
             Begin

               If strTokIde = ')' Then // Terminou o FormatMaskText
               Begin
                 If strMascar = FTabCam.FieldByName('CAM_MASCAR').AsString Then
                 Begin
                   strExpres := strExpres + ' ' + FTabCam.FieldByName('CAM_CODCAM').AsString;
                   blnLeuCam := True;
                 End Else
                 Begin
                   strExpres := strExpres + ' FormatMaskText(' + QuotedStr(strMascar) + ',' +
                                FTabCam.FieldByName('CAM_CODCAM').AsString + ')';
                 End;               

                 blnFormat := False;
                 strMascar :='';
               End;

             End Else
             Begin
               blnEcoExp := True;
               Case strTokIde Of
                 '[': Begin
                        If blnTxtSQt Then
                          strExpres := strExpres + ' '' +'; // Fecha quote

                        blnTxtSQt := False;

                        If Not blnAbrCol Then
                        Begin
                          blnAbrCol := True;
                          blnEcoExp := False;
                        End;
                      End;

                 ']': If blnAbrCol Then
                      Begin
                        blnAbrCol := False;
                        blnEcoExp := False;
                        blnBDImpE := False;
                      End;

                 '<': Begin
                        blnTxtSQt := False;

                        If Not blnAbrCmp Then
                        Begin
                          intContador := 0;
                          blnAbrCmp := True;
                          blnEcoExp := False;
                        End;
                      End;

                 '>': If blnAbrCmp Then
                      Begin
                        blnAbrCmp := False;
                        blnEcoExp := False;
                        blnBDImpE := False;
                      End;

                 '.': If blnAbrCmp Or blnBDImpE Then
                      Begin
                        blnEcoExp := False;
                      End;

                 '"': If blnAbrCmp Or blnBDImpE Then
                      Begin
                        blnEcoExp := False;
                      End;
               End;

               If blnTxtSQt And
                 (SameText(strTokIde, parParser.TokenString) Or
                 ((strTokIde = #3) And (parParser.TokenString = '$'))) Then
               Begin
                 blnTokAnt := True;
                 strExpres := strExpres + parParser.TokenString;
               End

               Else If blnEcoExp Then
               Begin
                 If blnTxtSQt And blnTokAnt Then
                   strExpres := strExpres + parParser.TokenString

                 Else If ((parParser.TokenString = '>') Or (parParser.TokenString = '=')) And ((RightStr(strExpres, 1) = '<') Or (RightStr(strExpres, 1) = '>')) Then
                   strExpres := strExpres + parParser.TokenString

                 Else
                   strExpres := strExpres + ' ' + parParser.TokenString;

                 blnTokAnt := False;
               End;

             End;
           End;
    End;

    parParser.NextToken;
  End;

  If blnTxtSQt Then
  Begin
    strExpres := strExpres + ''''; // Fecha quote
  End;

  While RightStr(strExpres, 1) = '+' Do
    strExpres := LeftStr(strExpres, Length(strExpres) - 1);

  strCodCam := Trim(strExpres);
  If (Length(strCodCam) = 6) And blnLeuCam And (Pos('<', strExpFr3)=0) Then
  Begin
    tcmTipCam  := camNormal;
    strCaption := FTabCam.FieldByName('CAM_DESCAM').AsString;
  End Else
  Begin
    tcmTipCam  := camExpressao;
    strCaption := strCodCam;
  End;

  FreeAndNil(parParser);
  FreeAndNil(strStream);
End;

procedure TEditorFast.pNovoLayout(blnRefresh: Boolean = True);
Begin
  FLayEti.Close;
  FCmpMvl.pNovoLayout(blnRefresh);
  FPadrao := False;
End;

Function TEditorFast.fCarregarLayout(blnPadrao: Boolean = False; strCodLayDoc: String = ''; blnChamadaPeloMenu: Boolean = False): Boolean;
Begin
  If (FEditor.tplTipLay in [tplDocumentos,tplEtiquetas]) And (Not blnChamadaPeloMenu) Then
    Result := fCarregar(blnPadrao, strCodLayDoc)

  Else If blnPadrao Then
    Result := fCarregarPadrao
  Else
    Result := fCarregarNaoPadrao;
End;

Function TEditorFast.fCarregarNaoPadrao: Boolean;
  Var
    strCodLay: String;
Begin
  pCriarFormularios(TfrmSelecionaLayout, frmSelecionaLayout);

  pAbreLayouts(frmSelecionaLayout.qryLayEti);
  frmSelecionaLayout.colPadrao.Options.Editing := FCodEti in [tpeOPIndustrial, tpeOPIndustrialArgox, tpeOrdemProducaoArgox];
  frmSelecionaLayout.colOpcional.Visible := (FCodEti in [tpeClienteLaser, tpeClienteArgox, tpeClienteMatricial]);

  If FLayEti.Active And (Not FLayEti.IsEmpty) Then
    frmSelecionaLayout.strCodLay := FLayEti.FieldByName('LAY_CODLAY').AsString;

  If frmSelecionaLayout.ShowModal = mrOk Then
    strCodLay := frmSelecionaLayout.qryLayEti.FieldByName('LAY_CODLAY').AsString
  Else
    strCodLay := '';

  FreeAndNil(frmSelecionaLayout);

  Result := (Not fEmptyStr(strCodLay)) And fCarregar(False, strCodLay);
End;

Function TEditorFast.fCarregarPadrao: Boolean;
Begin
  Result := fCarregar(True);
End;

Function TEditorFast.fValidaLayout: Boolean;
Begin
  Result := False;
  FErrVal := 0;

  If fEmptyStr(FDescri) Then
  Begin
    FErrVal := 1;
    pMensagemOk('Informe uma descrição para o Layout!');
    Exit;
  End;

  If FCmpMvl.oblCamObj.Count = 0 Then
  Begin
    pMensagemOk('O Layout está vazio!');
    Exit;
  End;

  Result := True;
End;

Procedure TEditorFast.pAjustaFr3;
Var
  LIndice: Integer;
  LComponent: TfrxComponent;
Begin
  frxMasterData := fRetfrxMasterData;

  If Assigned(frxMasterData) Then
  Begin

    If (FCodEti In CONJ_ARGOX) Then
    Begin

      If Assigned(FEditor) Then
      Begin

        If (FEditor.strInfHei <> 'S') Then
          frxMasterData.Height := fCmColunaToPixel((frxPage.PaperHeight - frxPage.TopMargin - frxPage.BottomMargin ) / 10, True, FTipImp) - MEIOCMPIXEL;

      End Else
      Begin

        If (FInfHei <> 'S') And Assigned(frxPage) Then
          frxMasterData.Height := fCmColunaToPixel((frxPage.PaperHeight - frxPage.TopMargin - frxPage.BottomMargin ) / 10, True, FTipImp) - MEIOCMPIXEL;

      End;

    End;

    frxMasterData.Height := frxMasterData.Height + FGpVePx;
  End;

  For LIndice := 0 To FReport.ComponentCount - 1 Do
  Begin
    If Not (FReport.Components[LIndice] Is TfrxComponent) Then
      Continue;

    LComponent := (FReport.Components[LIndice] As TfrxComponent);

    If LComponent.Name <> EmptyStr Then
      Continue;

    LComponent.Name := LComponent.ClassName.Replace('Tfrx', EmptyStr) + LIndice.ToString;
  End;
End;

Function TEditorFast.fLeEtiqueta(blnPadrao: Boolean; strCodLay: String): Boolean;
Begin
  Result := fCarregaRegistro(blnPadrao, strCodLay);

  If Result Then
  Begin

    frxPage       := fRetfrxPage;
    frxMasterData := fRetfrxMasterData;

    FReport.DataSets.Clear;
    If Assigned(FDBIEti) Then
      FReport.DataSets.Add(FDBIEti);

    If Assigned(frxMasterData) Then
    Begin
      frxMasterData.DataSetName := 'frxDBImpEti';
      frxMasterData.DataSet := FDBIEti;
    End;

    pAjustaFr3;

  End;
End;

Function TEditorFast.fMontaScript: String;
  Var
    intIndice: Integer;
    sltScript: TStringList;
    blnInseriCodBar: Boolean;
    strCodigoAnterior: String;
Begin

  strCodigoAnterior := FReport.ScriptText.Text;

  sltScript := TStringList.Create;

  blnInseriCodBar := False;

  With sltScript Do
  Begin

    If FEditor.blnViaPag Then
    Begin
      Add('Var');
      Add('  intPagina: Integer;');
      Add('  intVia: Integer;');

      Add('  TamanhoDados: Double;');
      Add('');

      If Not ( FCodEti in CONJ_DOCUMENTOS ) then
        Add( strCodigoAnterior );

      Add('procedure MasterData1OnBeforePrint(Sender: TfrxComponent);');
      Add('begin');
      Add('  TamanhoDados := TamanhoDados + MasterData1.height;');
      Add('end;');
      Add('');

      Add('procedure masterViasOnBeforePrint(Sender: TfrxComponent);');
      Add('begin');
      Add('  intPagina := 0;');
      Add('  intVia := intVia + 1;');
      Add('');
      Add('  If <page#> > 1 Then');
      Add('  begin');
      Add('    intPagina := 0;');
      Add('  end;');

      Add('  If (Engine.FreeSpace < Engine.PageHeight / 2 - ChildVias.Height) Or (<page#> > 1) Then');
      Add('    Engine.NewPage;');

      Add('end;');

      Add('');
      Add('procedure HeaderOnBeforePrint(Sender: TfrxComponent);');
      Add('begin ');
      Add('  intPagina := intPagina + 1;');

      If Assigned(frxHeader) And (FEditor.strCabPri = 'S') Then
        Add('  frxPageHeader.Visible := False;');

      Add('end;');
      Add('');

    End Else
    Begin

      If Assigned(frxHeader) And (FEditor.strCabPri = 'S') Then
      Begin
        If Not ( FCodEti in CONJ_DOCUMENTOS ) then
          Add( strCodigoAnterior );
        Add('');
        Add('procedure HeaderOnBeforePrint(Sender: TfrxComponent);');
        Add('begin ');
        Add('  frxPageHeader.Visible := False;');
        If Assigned(frxHeaderData) And Assigned(frxMasterData) Then
          Add('  HeaderData1.Visible := Not MasterData1.DataSet.Eof;');
        Add('end;');
        Add('');
      End;

    End;

    For intIndice := 0 To FReport.ComponentCount - 1 Do
    Begin

      If (FReport.Components[intIndice] Is TfrxBarCodeView) Then
      Begin

        If Not blnInseriCodBar Then
        Begin
          {*************************************************************}
          {* SE FOR IMPRESSÃO DE SEPARAÇÃO DE ROMANEIO (82),           *}
          {* NÃO ADICIONAR ESSE EVENTO, POIS DÁ ERRO NO CAMPO "CDBARO" *}
          {**********************************************************MM*}
          If Not ( ARR_TIPO_LAYOUT[FCodEti] = 82 ) Then
          Begin
            blnInseriCodBar := True;

            Add('procedure CodBarOnBeforePrint(Sender: TfrxComponent);');
            Add('begin');

            If Assigned(frxMasterData) And
              ((FReport.Components[intIndice] As TfrxBarCodeView).Expression <> '[CODBAR]') Then
              Add('  TfrxBarCodeView(Sender).visible := <frxDBImpEti."CODBAR"> <> '''' ;')
            Else
              Add('  TfrxBarCodeView(Sender).visible := CODBAR <> '''' ;');

            Add('end;');
            Add('');
          End;
        End;

      End

      Else If (FReport.Components[intIndice] Is TfrxReportSummary) Then
      Begin

        Add('procedure SummaryOnBeforePrint(Sender: TfrxComponent);');
        Add('begin');

        If FEditor.blnFooBra And Assigned(frxPageFooter) Then
        Begin
          Add('  ' + frxPageFooter.Name +  '.Height  := 0; ');
          Add('  ' + frxPageFooter.Name +  '.visible := False; ');

          Add('  If Summary.Height > Engine.FreeSpace + Summary.Height Then ');
          Add('    Engine.NewPage;                                          ');
        End Else
        Begin
          Add('  If Summary.Height > Engine.FreeSpace Then ');
          Add('    Engine.NewPage;                          ');
        End;

        Add('  Engine.CurY := Engine.CurY + Engine.FreeSpace - Summary.Height - 1;');

        Add('end;');
        Add('');

      End

      Else If (FReport.Components[intIndice].Name = 'imgProduto') Then
      Begin
        If FEditor.blnZebra Then
        Begin
          Add('procedure MasterData1OnBeforePrint(Sender: TfrxComponent);');
          Add('begin');
          Add('  if ' + IIF(AnsiMatchStr(LowerCase(FEditor.expZebra), ['', '<line#> mod 2 = 0']), '<line#> mod 2 = 0', FEditor.expZebra) + ' then');
          Add('  begin');
          Add('    imgProduto.TransparentColor := mmoZebra.Highlight.Color;');
          Add('  end');
          Add('  else');
          Add('   imgProduto.TransparentColor := mmoZebra.Color;');
          Add(' end;');
        End;
      end

      Else If (FReport.Components[intIndice] Is TfrxFooter) Then
      Begin

        If FEditor.blnFooNewPage Then
        Begin
          Add('procedure FooterOnAfterPrint(Sender: TfrxComponent);');
          Add('begin');
          Add('  frxPageHeader.Visible := false;');
          Add('  HeaderData1.Visible := false;');
          Add('  PageFooter.Visible := False;');
          Add('  Engine.Newpage;');
          Add('  PageFooter.Visible := True;');
          Add('end;');
        End;

        If FEditor.blnViaPag Then
        Begin
          Add('procedure FooterOnBeforePrint(Sender: TfrxComponent);');
          Add('begin');
          Add('  If Footer.Height > Engine.FreeSpace Then ');
          Add('    Engine.NewPage;                        ');

          Add(' If (Engine.FreeSpace - Footer.Height - ChildVias.Height / 2 >= Engine.PageHeight / 2) And (<page#> = 1) Then');
          Add(' Begin');
          Add('   ChildVias.Visible := True;');
          Add('   If Engine.CurY + (Engine.FreeSpace - Engine.PageHeight / 2) - Footer.Height - ChildVias.Height / 2 > Engine.CurY Then');
          Add('     Engine.CurY := Engine.CurY + (Engine.FreeSpace - Engine.PageHeight / 2) - Footer.Height - ChildVias.Height / 2');
          Add(' End Else ');
          Add(' Begin');
          Add('   ChildVias.Visible := False;');
          Add('   If (Engine.CurY + Engine.FreeSpace - Footer.Height > Engine.CurY)  Then');
          Add('     Engine.CurY := Engine.CurY + Engine.FreeSpace - Footer.Height;');
          Add(' End;');
          Add('');
          Add(' TamanhoDados:= 0;');

          Add('end;');
          Add('');
        End;

      End

    End;

    If (FMeiaFolha = 'S') And (Not FEditor.blnViaPag) Then
    Begin
      Add('Var ');
      Add('iQtdeImpressas : Integer; ');
      Add('iQtdeReg   : Integer; ');
      Add('qtdeTotImp : integer; ');
      Add('impcab : boolean; ');
      Add('');

      Add('procedure Page1OnBeforePrint(Sender: TfrxComponent);');
      Add('begin');
      Add('  iQtdeImpressas := 0;');
      Add('  iQtdeReg       := MasterData1.DataSet.RecordCount;');
      Add('  qtdeTotImp     := 0;');
      Add('  Child1.Visible := True;');
      Add('end;');
      Add(' ');

      Add('procedure MasterData1OnAfterPrint(Sender: TfrxComponent);');
      Add('begin');
      Add('  Inc(qtdeTotImp);  ');
      Add('  Inc(iQtdeImpressas);');
      Add('  If iQtdeImpressas = 17 Then ');
      Add('  Begin ');
      Add('  iQtdeImpressas := 0; ');
      Add('    If (iQtdeReg > 17) Then ');
      Add('    begin ');
      Add('      If (qtdeTotImp = iQtdeReg) Then ');
      Add('        impcab := False ');
      Add('      Else ');
      Add('      Begin ');
      Add('        impcab := True; ');
      Add('        engine.ShowBand(Footer); ');
      Add('        engine.ShowBand(HeaderData1); ');
      Add('      End; ');
      Add('    End ');
      Add('    Else ');
      Add('      impcab := False; ');
      Add('  End ');
      Add('  Else ');
      Add('    impcab := False; ');
      Add('end; ');
      Add(' ');

      Add('procedure FooterOnBeforePrint(Sender: TfrxComponent);');
      Add('  var i : Integer; ');
      Add('begin');
      Add('  Child1.Height := MasterData1.Height;  ');
      Add('  If impCab = True Then ');
      Add('  Begin ');
      Add('    iQtdeImpressas := 0; ');
      Add('  End ');
      Add('  Else ');
      Add('  Begin ');
      Add('    If (iQtdeImpressas < 16) Then ');
      Add('    Begin ');
      Add('      For i := 1 to (16 - iQtdeImpressas) Do ');
      Add('      Begin ');
      Add('        engine.ShowBand(Child1); ');
      Add('      End; ');
      Add('    End; ');
      Add('  End; ');
      Add('end;');
      Add('');
      Add('begin');
      Add('  If Page1.Frame.Typ = 15 Then ');
      Add('  Begin ');
      Add('    Footer.Frame.Width := Page1.Frame.Width; ');
      Add('    MasterData1.Frame.Width  := Page1.Frame.Width; ');
      Add('    Child1.Frame.Width := Page1.Frame.Width; ');
      Add('    HeaderData1.Frame.Width := Page1.Frame.Width; ');
      Add('    Page1.Frame.Width := 0; ');
      Add('    Footer.Frame.Typ := Footer.Frame.Typ + ftLeft; ');
      Add('    Footer.Frame.Typ := Footer.Frame.Typ + ftBottom; ');
      Add('    Footer.Frame.Typ := Footer.Frame.Typ + ftRight; ');
      Add('    HeaderData1.Frame.Typ := HeaderData1.Frame.Typ + ftRight; ');
      Add('    HeaderData1.Frame.Typ := HeaderData1.Frame.Typ + ftLeft; ');
      Add('    HeaderData1.Frame.Typ := HeaderData1.Frame.Typ + ftTop; ');
      Add('    MasterData1.Frame.Typ := MasterData1.Frame.Typ + ftRight; ');
      Add('    MasterData1.Frame.Typ := MasterData1.Frame.Typ + ftLeft; ');
      Add('    Child1.Frame.Typ := Child1.Frame.Typ + ftLeft; ');
      Add('    Child1.Frame.Typ := Child1.Frame.Typ + ftRight; ');
      Add('  End; ');
      Add('end.');
    End
    Else
    Begin
      Add('');
      Add('begin');

      If FEditor.blnViaPag Then
      Begin
        Add('  intVia    := 0;');
        Add('  intPagina := 0;');
      End;

      Add('end.');
    End;
  End;

  Result := sltScript.Text;

  sltScript.Clear;
  FreeAndNil(sltScript);
End;

Procedure TEditorFast.pBeforeEventPreview;
  Var
    mmsRelat: TMemoryStream;
    mmsLoad : TStream;
    qryLayAux: TUniQuery;
    strNovLay: String;
Begin
  mmsRelat := TMemoryStream.Create;
  FReport.SaveToStream(mmsRelat);

  qryLayAux := fCriaQuery(Nil);
  With qryLayAux Do
  Begin
    SQL.Text := 'SELECT * FROM LAYETI WHERE FALSE';
    Open;
    Insert;

    TBlobField(FieldByName('LAY_RELFR3')).LoadFromStream(mmsRelat);
    strNovLay := FieldByName('LAY_RELFR3').AsString;

    strNovLay := fInsereBeforPrintBarCode(strNovLay);

    FieldByName('LAY_RELFR3').AsString := strNovLay;

    mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmReadWrite);
    FReport.LoadFromStream(mmsLoad);

    Cancel;

    FreeAndNil(mmsRelat);
    FreeAndNil(mmsLoad);
    FreeAndNil(qryLayAux);
  End;

  frxMasterData := fRetfrxMasterData;

  frxPageFooter := fRetfrxPageFooter;
  frxSummary    := fRetfrxSummary;
  frxFooterData := fRetfrxFooterData;

  frxHeaderData := fRetfrxHeaderData;
  frxHeader     := fRetfrxHeader;
  frxPage       := fRetfrxPage;
End;

Function TEditorFast.fPedeDadosDocumento(Var strEspDoc, strNumDoc, strCodCli, strCodEmp, strSerie: String): Boolean;
Begin
  pCriarFormularios(TfrmPedeMIFF, frmPedeMIFF);

  With frmPedeMIFF Do
  Begin
    teqTipEtq := FCodEti;

    Case FCodEti of
      tpeSepRomaneio: Begin
                        edtEspDoc.Visible := False;
                        lblEspDoc.visible := False;
                        edtNumDoc.Width := edtNumDoc.Width + edtEspDoc.Width;
                      End;

      tpeSepItem:     Begin
                        edtEspDoc.Visible := False;
                        lblEspDoc.visible := False;
                        edtNumDoc.Width := edtNumDoc.Width + edtEspDoc.Width;

                        Caption := 'Dados do Produto';
                      End;

      tpeOrdPro:      begin
                        lblNumDoc.Caption   := 'Núm. Ord. Prod.';
                        edtEspDoc.Visible   := False;
                        lblEspDoc.Visible   := False;
                        edtNumDoc.Width     := Width - edtNumDoc.Left - (Width - (edtEspDoc.Left + edtEspDoc.Width));
                        edtCodEmp.ReadOnly := False;
                        edtCodEmp.TabStop  := True;
                      end;

      tpeProcessoDeExtrusao: Begin
                               lblEspDoc.Visible  := False;
                               edtEspDoc.Visible  := False;
                               lblNumDoc.Caption  := 'Data Cadastro';
                               edtNumDoc.Visible  := False;
                               edtNumDoc.ReadOnly := True;
                               edtNumDoc.TabStop  := False;
                               lblSerie.Caption   := 'Cód OP';
                               lblSerie.Left      := 88;
                               edtSerie.Left      := lblSerie.Left;
                               edtSerie.Width     := 36;
                               lblCodEmp.Left     := 130;
                               edtCodEmp.Left     := lblCodEmp.Left;
                             End;
      tpePDExterior,
      tpeORExterior : Begin
                        edtNumDoc.Visible  := True;
                        edtNumDoc.ReadOnly := False;
                        edtNumDoc.TabStop  := True;
                        edtSerie.Visible   := True;
                        edtSerie.ReadOnly  := False;
                        edtSerie.TabStop   := True;
                        edtEspDoc.Visible  := True;
                        edtEspDoc.ReadOnly := False;
                        edtEspDoc.TabStop  := True;
                        edtCodEmp.Visible  := True;
                        edtCodEmp.ReadOnly := False;
                        edtCodEmp.TabStop  := True;
                      End;
    end;

    edtEspDoc.Text := strEspDoc;
    edtCodEmp.Text := VS_strCodEmp;

    edtEspDoc.Enabled := not ((teqTipEtq = tpeOrdemServico) or (teqTipEtq = tpeOrdemServicoTermoResp) or (teqTipEtq = tpeOrdemServicoTermoDev) or (teqTipEtq = tpeOrdemServicoOrdExecucao) or (teqTipEtq = tpeOrdemServicoImagem));
    edtCodEmp.Enabled := not ((teqTipEtq = tpeOrdemServico) or (teqTipEtq = tpeOrdemServicoTermoResp) or (teqTipEtq = tpeOrdemServicoTermoDev) or (teqTipEtq = tpeOrdemServicoOrdExecucao) or (teqTipEtq = tpeOrdemServicoImagem));

    Result := ShowModal = mrOk;

    If Result Then
    Begin
      strNumDoc := IIF(FCodEti = tpeProcessoDeExtrusao, mskDtaCad.Text, edtNumDoc.Text);
      strEspDoc := edtEspDoc.Text;
      strCodCli := strCliente;
      strCodEmp := edtCodEmp.Text;
      strSerie  := edtSerie.Text;
    End;
  End;

  pFreeAndNil(frmPedeMIFF);
End;

function TEditorFast.fPedeDadosFiltroSeparacaoGondola(var ASeparacaoGondolaFiltro: TSeparacaoGondolaFiltro): Boolean;
begin
  Result := False;
  pCriarFormularios(TfrmFiltroSeparacao, frmFiltroSeparacao);
  try
    if frmFiltroSeparacao.Showmodal = mrOk then
    Begin
      ASeparacaoGondolaFiltro.strOperadorSolicitacao := frmFiltroSeparacao.edtCodOpeSol.Text;
      ASeparacaoGondolaFiltro.strOperadorEfetivacao  := frmFiltroSeparacao.edtCodOpeEfe.Text;
      ASeparacaoGondolaFiltro.dtaDataEfetivacao := frmFiltroSeparacao.dtaDtaEfe.Date;
      case frmFiltroSeparacao.rdgFiltroImpresso.ItemIndex of
        0: ASeparacaoGondolaFiltro.TipoSeparacaoGondolaImpressaoFiltro := tsgiffTodos;
        1: ASeparacaoGondolaFiltro.TipoSeparacaoGondolaImpressaoFiltro := tsgiImpresso;
        2: ASeparacaoGondolaFiltro.TipoSeparacaoGondolaImpressaoFiltro := tsgiffNaoImpresso;
      End;
      Result := True;
    End;
  Finally
    FreeAndNil(frmFiltroSeparacao);
  End;
end;

Function TEditorFast.fAbreDocPreview(strEspDoc: String; Var strNumDoc, strCodCli:  String; tpaTipoArquivo: TTipoArquivo = tpaNormal): Boolean;
  Var
    objLeDocumento: TLeDocumento;
    strCodEmp,
    strSerie : String;
    lSeparacaoGondolaFiltro: TSeparacaoGondolaFiltro;
Begin
  Result := False;

  If FCodEti  = tpeSeparacaoGondola Then
  Begin
    If Not fPedeDadosFiltroSeparacaoGondola(lSeparacaoGondolaFiltro) Then
      Exit;
  End
  Else
    If Not fPedeDadosDocumento(strEspDoc, strNumDoc, strCodCli, strCodEmp, strSerie) Then
      Exit;

  objLeDocumento := fEspecieToClassDocumento(strNumDoc, strEspDoc, strCodEmp,
                    IfThen(FCodEti In [tpeGF, tpeSF, tpeSepSF], 'F', 'C'),
                    FCodEti In [tpeSepNota, tpeSepNotaObs, tpeSepSF, tpeSepPedido, tpeSepRomaneio],
                    FCodEti = tpeRequisicao,
                    FCodEti = tpeSepRomaneio,
                    FCodEti).Create(Nil);

  If FCodEti  = tpeSeparacaoGondola Then
    objLeDocumento.recDocume.SeparacaoGondolaFiltro := lSeparacaoGondolaFiltro;

  If Not Assigned(objLeDocumento) Then
    Exit;

  With objLeDocumento Do
  Begin
    blnMatricial   := FTipImp = 'M';
    objOrdena      := FObjOrd;
    frxReport      := FReport;
    fdbImpEti      := FModFr3.frxDBImpEti;

    If FCodEti In [tpeGF, tpeContGF, tpeContGR, tpeSF, tpeSepSF, tpeContGRBaixa, tpeSolicitacaoManutencaoEquipamentos, tpePedidoCompra, tpeReqMaterialConsumo, tpeLiberacaoArmazenagem] Then
      recDocume.strTipFC := 'F'
    Else
      recDocume.strTipFC := 'C';

    recDocume.blnDocSep     := FCodEti In [tpeSepNota, tpeSepNotaObs, tpeSepSF, tpeSepPedido, tpeSepRomaneio, tpeSepItem];
    recDocume.blnQtdOri     := True;
    recDocume.blnDocCan     := False;
    recDocume.blnReimpr     := True;
    recDocume.strNumDoc     := strNumDoc;
    recDocume.strEspDoc     := strEspDoc;
    recDocume.strSerie_     := strSerie;
    recDocume.strCodCli     := strCodCli;
    recDocume.strCodEmp     := strCodEmp;
    recDocume.blnRequisicao := FCodEti = tpeRequisicao;

    If FCodEti = tpeSepItem then
      recDocume.strCodIte := strNumDoc;

    If FCodEti = tpeProcessoDeExtrusao then
    Begin
      recDocume.strDtaCad := FormatDateTime('yyyy-mm-dd', StrToDate(strNumDoc));
      recDocume.strCodOrd := strSerie;
    End;

    If FCodEti = tpeRemessaDevolucao then
    begin
      recDocume.strNumRem := strNumDoc;
    end;

    Result := fMontaClients();
    objLeDocumento.pAjustarSequencia;

    If fTemParametro('INFADI') Then
      FReport.Script.Variables['INFADI'] := fInformacaoAdicionalEtiquetaItens;
  End;

  If Result Then
  Begin
    pAbrePreview(tpaTipoArquivo, strEspDoc + '_' + strNumDoc);
  End;

  If Assigned(FModFr3) Then
    FModFr3.frxDBImpEti.DataSet := Nil;

  If Assigned(FReport) Then
    FReport.DataSets.Clear;

  FreeAndNil(objLeDocumento);
End;

Procedure TEditorFast.pGeraPDF;
Begin
  pPreview(tpaPDF);
End;

Function TEditorFast.fTipoEtiquetaToEspecie: String;
Begin

  Case FCodEti Of
    tpeNF,
    tpeSF,
    tpeSepSF,
    tpeSepNota,
    tpeSepNotaObs,
    tpeOrdProImobiliaria,
    tpeOrdProAutomotiva: Result := 'NF';

    tpeNS        : Result := 'NS';

    tpeIF        : Result := 'IF';

    tpeD1        : Result := 'D1';

    tpeTicketNF  : Result := 'NF';

    tpeTicketDV  : Result := 'DV';

    tpeMI        : Result := 'MI';

    tpeFF        : Result := 'FF';

    tpeBR        : Result := 'BR';

    tpeTR        : Result := 'TR';

    tpeDV        : Result := 'DV';

    tpeAJ        : Result := 'AJ';

    tpeTA        : Result := 'TA';

    tpeEP        : Result := 'EP';

    tpeBE        : Result := 'BE';

    tpeUS        : Result := 'UC';

    tpeCS        : Result := 'CS';

    tpeCR        : Result := 'CR';

    tpeTE        : Result := 'TE';

    tpePI        : Result := 'PI';

    tpeGA        : Result := 'GA';
    tpeSeparacaoGondola : Result := 'SPG';

    tpeGF, tpeContGF   : Result := 'GF';

    tpeContGR : Result := 'GR';
    tpeContGC : Result := 'GC';
    tpeContGRBaixa : Result := 'GR';
    tpePedidoCompra : Result := 'PD';
    tpeSolicitacaoManutencaoEquipamentos: Result := 'SME';

    tpePD,
    tpeSepPedido,
    tpeSepRomaneio,
    tpeAmostraProdutoAuto,
    tpeRequisicao: Result := 'PD';

    tpeCarnePagamento: Result := 'CPS';
    tpeDuplicata: Result := 'DPS';

    tpeComprovanteGeracaoCredito: Result := 'CGC';

    tpeProcessoDeExtrusao: Result := 'PEX';

    tpeInspecaoEnt :  Result := 'IPE';
    tpeInspecaoSai :  Result := 'IPS';

    tpePA : Result := 'PA';
    tpeROTin : Result := 'RO';
    tpeSepItem: Result := 'IT';
    tpeOR : Result := 'OR';
    tpePR : Result := 'PR';
    tpeOrdemServico: Result := 'OS';
    tpeOrdemServicoTermoResp : Result := 'OSTR';
    tpeOrdemServicoTermoDev : Result := 'OSTD';
    tpeOrdemServicoOrdExecucao: Result := 'OSOE';
    tpeOrdemServicoImagem: Result := 'OSIM';

    tpeReqMaterialConsumoVidro,
    tpeReqMaterialConsumo : Result := 'RQ';

    tpeCupomServico: Result := 'NS';
    //tpeCupomServico: Result := 'ICS';
    tpeLiberacaoArmazenagem: Result := 'LAR';
    tpeLocacaoEquipamento: Result := 'LE';
    tpeRL, tpeFaturaLocacao: Result := 'RL';
    tpeDevolucaoLocacao : Result := 'DL';
    tpeRemessaDevolucao : Result := 'RD';
    tpeRB: Result := 'RB';
    tpeFFDocumentosCR: Result := 'FF';
  End;

End;

Procedure TEditorFast.pPreview(tpaTipoArquivo: TTipoArquivo = tpaNormal);
  Var
    qryEtique: TUniQuery;
    blnConfirma: Boolean;
    strNumDoc, strCodCli, strNomArq: String;
Begin
  qryEtique := Nil;

  If Not fEditorToFast Then
    Exit;

  strNomArq   := '';
  blnConfirma := True;

  If (FEditor.tplTipLay = tplDocumentos) Then
  Begin

    pBeforeEventPreview;

  End;

  FReport.ScriptText.Text := fMontaScript;

  If Not (FCodEti In CONJ_DOCUMENTOS) Then
    qryEtique := fCriaQuery(Self);

  FModFr3.frxDBImpEti.DataSet := qryEtique;

  Case FCodEti Of

    {* CLIENTE *}
    tpeClienteLaser,
    tpeClienteArgox: pAbreCliente(qryEtique, False, 'CLI_NOMCLI', True);

    {* FUNCIONARIOS *}
    tpeFuncionarioLaser,
    tpeFuncionarioArgox: pAbreFuncionario(qryEtique, 'FUN_NOMFUN', True);

    {* FORNECEDOR *}
    tpeFornecedorLaser,
    tpeFornecedorArgox: pAbreFornecedor(qryEtique, True);

    {* DIVERSOS *}
    tpeDiversosLaser,
    tpeDiversosArgox: pAbreDiversos(qryEtique, True);

    {* ESTRUTURA *}
    tpeEstruturaArgox: pAbreEstrutura(qryEtique, True);

    {* OPERADOR *}
    tpeOperadorLaser: pAbreOperador(qryEtique, True);

    {* ITENS *}
    tpeItensLaser,
    tpeItensLaserCodBarPadr,
    tpeItensLaserCodBarPers,
    tpeItensLaserCodBarSPre,
    tpeItensZebraGondolaCPre,
    tpeItensZebraGondolaSPre,
    tpeItensZebraCodBarCPre,
    tpeItensZebraCodBarSPre,
    tpeItensArgoxGondolaCPre,
    tpeItensArgoxGondolaCPreLayout1,
    tpeItensArgoxGondolaSPre,
    tpeItensArgoxCodBarCPre,
    tpeItensArgoxCodBarSPre,
    tpePrecificacaoProdutosLaser,
    tpePrecificacaoProdutosArgox,
    tpeItensControladosLaser,
    tpeItensControladosArgox: pAbreItens(qryEtique, 0, True);

    {* ITENS DE ORCAMENTO E PEDIDO *}
    tpeItensOrcPedLaser,
    tpeItensOrcPedLaserCodBar,
    tpeItensOrcPedZebraGondolaCPre,
    tpeItensOrcPedZebraGondolaSPre,
    tpeItensOrcPedZebraCodBarCPre,
    tpeItensOrcPedZebraCodBarSPre,
    tpeItensOrcPedArgoxGondolaCPre,
    tpeItensOrcPedArgoxGondolaSPre,
    tpeItensOrcPedArgoxCodBarCPre,
    tpeItensOrcPedArgoxCodBarSPre: pAbreItensOrcPed(qryEtique, True);

    {* DESPACHO *}
    tpeDespachoLaser,
    tpeDespachoLaserECommerce,
    tpeDespachoArgox,
    tpeEtiquetaDespachoVolumeGeralArgox,
    tpeEtiquetaDespachoVolumeIndividualArgox,
    tpeEtiquetaDespachoVolumeGeralLaser,
    tpeEtiquetaDespachoVolumeIndividualLaser,
    tpeDespachoFaturarExpedidoLaser,
    tpeDespachoFaturarExpedidoArgox: pAbreDespacho(qryEtique, True);

    tpeDespachoProdutoArgox: pAbreDespachoProduto(qryEtique, True);

    {* ORDEM DE SERVIÇO *}
    tpeOrdemServicoLaser,
    tpeOrdemServicoArgox,
    tpeOrdemServicoZebra: pAbreOS(qryEtique, True);

    {* ORDEM DE SERVIÇO VENDA *}
    tpeOrdemServicoVendaLaser,
    tpeOrdemServicoVendaArgox,
    tpeOrdemServicoVendaZebra: pAbreOSVenda(qryEtique, True);

    {* TINTA DE MAQUINA *}
    tpeEntregaTintaMaquina: pAbreEntregaTintaMaquinaPreview;

    tpeFomulacaoTinta: Begin
                         pAbreFormulacaoTintaPreview;
                         FModFr3.frxDBImpEti.DataSet := FPreviw;
                       End;

    tpeProducaoTintaMaquina: begin
                               pAbreProducaoTintaMaquinaPreview;
                               FModFr3.frxDBImpEti.DataSet := FPreviw;
                             end;

    {* ITENS COM OBRIGATORIEDADE DE CPF *}
    tpeItensCPF,
    tpeItensCPFArgox: pAbreItensCPFPreview;

    {* ETIQUETA DE CAIXAS *}
    tpeCaixasLaser,
    tpeCaixasArgox: pAbreCaixas(qryEtique, True);

    {* ETIQUETA DE MONTAGEM DE CAIXAS *}
    tpeMontagemCaixasArgox,
    tpeMontagemCaixasLaser,
    tpeMontagemCaixasZebra: pAbreMontagemCaixas(qryEtique, True);

    {* ETIQUETA DE MONTAGEM DE CAIXAS COM CÓD. DE BARRAS *}
    tpeMontagemCaixasLaserCodBarras: pAbreMontagemCaixasCodBarras(qryEtique, True);
    tpeMontagemCaixasZebraPackList,
    tpeMontagemCaixasLaserPackList: pAbreMontagemCaixasPackList(qryEtique, True);

    tpeUnidadesRestantesFat,
    tpeUnidadesRestantesArgoxFat: pAbreUnidadesRestantesPreview(qryEtique);

    tpeUnidadesRestantesAvu,
    tpeUnidadesRestantesArgoxAvu: pAbreUnidadesRestantesPreview(qryEtique);

    tpeOPIndustrial,
    tpeOPIndustrialArgox: pAbreOrdemProducaoIndustrialPreview(qryEtique);

    tpeOrdemProducao,
    tpeOrdemProducaoArgox,
    tpeOrdemProducaoZebra: pAbreOrdemProducao(qryEtique, True);

    tpeEmpresaLazer,
    tpeEmpresaArgox : pAbreEmpresaPreview(qryEtique);

    tpeMI,
    tpeFF,
    tpeBR,
    tpeTR,
    tpeDV,
    tpeAJ,
    tpeTA,
    tpeEP,
    tpeBE,
    tpeUS,
    tpeCS,
    tpeCR,
    tpeTE,
    tpePI,
    tpeGA,
    tpeGF,
    tpeContGF,
    tpeContGR,
    tpeContGC,
    tpeContGRBaixa,
    tpeSolicitacaoManutencaoEquipamentos,
    tpePedidoCompra,
    tpeOrdPro,
    tpePD,
    tpeAmostraProdutoAuto,
    tpeOR,
    tpePR,
    tpeNF,
    tpeNS,
    tpeIF,
    tpeSF,
    tpeD1,
    tpeCupomServico,
    tpeTicketNF,
    tpeTicketDV,
    tpeSepNota,
    tpeSepNotaObs,
    tpeSepSF,
    tpeSepPedido,
    tpeSepRomaneio,
    tpeSepItem,
    tpeOrdemServico,
    tpeOrdemServicoTermoResp,
    tpeOrdemServicoTermoDev,
    tpeOrdemServicoOrdExecucao,
    tpeOrdemServicoImagem,
    tpeOrdProImobiliaria,
    tpeOrdProAutomotiva,
    tpeRequisicao,
    tpeLiberacaoArmazenagem,

    tpeCarnePagamento,
    tpeDuplicata,

    tpeComprovanteGeracaoCredito,

    tpeProcessoDeExtrusao,

    tpeInspecaoEnt,
    tpeInspecaoSai,

    tpePA,
    tpeROTin,
    tpeReqMaterialConsumoVidro,
    tpeReqMaterialConsumo,
    tpeLocacaoEquipamento,
    tpeRL,
    tpeDevolucaoLocacao,
    tpeFaturaLocacao,
    tpeEnderecamentoDeProduto,
    tpePDExterior,
    tpeORExterior,
    tpeCupomPromocao,
    tpeRemessaDevolucao,
    tpeSeparacaoGondola,
    tpeFFDocumentosCR,
    tpeCupomProxDesc :  Begin
                          fAbreDocPreview(fTipoEtiquetaToEspecie, strNumDoc, strCodCli, tpaTipoArquivo);
                          Exit;
                        End;

    tpeMarmoreGranito, tpeMarmoreGranitoArgox : pAbreLoteProdutoMarmoreTeste(qryEtique);
    tpeEtiquetaDoProdutoSeparadoArgox,
    tpeEtiquetaDoProdutoSeparado : pAbreEtiquetaDoProdutoSeparado(qryEtique);
    tpeLoteProduto,
    tpeLoteProdutoArgox: pAbreLoteProduto(qryEtique, True);

    tpeLocFisLaser,
    tpeLocFisArgox : pAbreLocFisPreview(qryEtique);

    tpePlanoRecebWMSLaser,
    tpePlanoRecebWMSArgox: pAbrePlanoRecebPreview(qryEtique);

    tpeArmazenamento,
    tpeArmazenamentoArgox,
    tpeArmazenamentoZebra : pAbreArmazenamentoPreview(qryEtique);

    tpeSeqSeparacaoWMSLaser,
    tpeSeqSeparacaoWMSArgox : pAbreSeqSeparacaoWMSPreview(qryEtique);

    tpeCodBarrasProduto : pAbreCodBarrasProdutoPreview(qryEtique);

    tpeSepErrLaser,
    tpeSepErrArgox : pAbreSepErrPreview(qryEtique);

    tpeLoteRastreamentoProdutoLaser,
    tpeLoteRastreamentoProdutoArgox,
    tpeLoteRastreamentoProdutoZebra : pAbreRastreamentoProduto(qryEtique);

    tpeLocalArmazenamentoWmsLaser,
    tpeLocalArmazenamentoWmsArgox : pAbreLocalArmazenamentoWMSPreview(qryEtique);

    tpeRegiaoLaser,
    tpeRegiaoArgox : pAbreRegiaoPreview(qryEtique);

    tpeProdutosControladosVendasLaser,
    tpeProdutosControladosVendasArgox,
    tpeProdutosControladosVendasZebra : pAbreProdutosControladosPreview(qryEtique);

    tpeProdutoQuantidadeFracionadaLaser,
    tpeProdutoQuantidadeFracionadaArgox: pAbreEtiqQtdFracionada(qryEtique);

    tpePlanoDeRecebimentoEtiquetaIDLaser,
    tpePlanoDeRecebimentoEtiquetaIDArgox: pAbreEtiqID(qryEtique);

  End;


  If blnConfirma  And (Not (FCodEti In [tpeItensCPF, tpeItensCPFArgox])) Then
  Begin

    If qryEtique.IsEmpty And (FCodEti In [tpeOPIndustrial,
                                          tpeOPIndustrialArgox,
                                          tpeOrdemProducaoArgox]) Then
      pMensagemOk('Nenhum registro econtrado')
    Else
      pAbrePreview(tpaTipoArquivo, strNomArq);

  End;
  
  If Assigned(qryEtique) Then
    FreeAndNil(qryEtique);
End;

procedure TEditorFast.pAbrePreview(tpaTipoArquivo: TTipoArquivo = tpaNormal; strNomArq: String = '');
  Var
    strPath: String;
    frxDataVias: TfrxMasterData;
Begin
  pAjustaFr3;

  If Assigned(FModFr3) And (FTipImp = 'M') Then
    FModFr3.frxMatricial.EscModel := FEditor.intEscMod;

  If fPrepareReport(FReport, True, True) Then
    case tpaTipoArquivo Of
      tpaNormal: Begin
                   If FEditor.blnViaPag Then
                   Begin
                     frxDataVias := fRetfrxMasterDataVias;
                     If Assigned(frxDataVias) Then
                       frxDataVias.RowCount := 2;
                   End;


                   pPreviewReport('frmEditorEtiquetasPrinc', FCodEti.GetName, FReport);
                 End;

      tpaPDF   : If Assigned(FModFr3) Then
                 Begin
                   strPath := ExtractFilePath(Application.ExeName) + 'PDFS_EDITOR\';
                   strNomArq := strNomArq + '.pdf';

                   FModFr3.frxPDFExport.Background := True;
                   FModFr3.frxPDFExport.ShowDialog  := Not fCriaDiretorio(strPath);
                   FModFr3.frxPDFExport.DefaultPath := strPath;
                   FModFr3.frxPDFExport.FileName    := strNomArq;

                   FReport.PrepareReport(True);
                   FReport.Export(FModFr3.frxPDFExport);
                   pExecArquivo(strPath + strNomArq, 0);
                 End;
    End;

End;

procedure TEditorFast.pShowPreview(cdsDados: TDataSet);
Begin
  FModFr3.frxDBImpEti.DataSet := cdsDados;
  pAbrePreview;
End;

procedure TEditorFast.pAbreDefCampos(qryTabCam: TUniQuery; strFilCampos: String = '');
Begin
  {unit que coleciona os campos para dispor no relatorio: untDocGarantias.pas}
  With qryTabCam, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT');
    Add('  CAM_EXPCAM, ');
    Add('  CAM_CODETI, ');
    Add('  CAM_MASCAR, ');
    Add('  CAM_CODCAM, ');
    Add('  CAM_LASER_, ');
    Add('  CAM_ARGOX_, ');
    Add('  CAM_MATRIC, ');
    Add('  CAM_ALINHA, ');
    Add('  CAM_TIPCAM, ');
    Add('  CAM_CODBAR, ');
    Add('  CAM_TIPINF, ');
    Add('  CAM_POSCAM, ');
    Add('  CAM_FRXSET, ');
    Add('  CAM_GRUETI, ');
    Add('  CAM_DOC_MI, ');
    Add('  CAM_DOC_FF, ');
    Add('  CAM_DOC_NF, ');
    Add('  CAM_DOC_SF, ');
    Add('  CAM_DOC_PD, ');
    Add('  CAM_DOC_OR, ');
    Add('  CAM_SEP_MI, ');
    Add('  CAM_SEP_PD, ');
    Add('  CAM_DOC_GA, ');
    Add('  CAM_DOC_GC, ');
    Add('  CAM_DOC_GF, ');
    Add('  CAM_REQUIS, ');
    Add('  CAM_SEP_RO, ');
    Add('  CAM_DOC_GR, ');
    Add('  CAM_DOC_GR_B, ');
    Add('  CAM_DOC_EQU, ');
    Add('  CAM_ORDPRO_TMQ, ');
    Add('  CAM_DOC_RQ, ');
    Add('  CAM_SEP_IT, ');
    Add('  CAM_DOC_CP, ');
    Add('  CAM_DOC_DP, ');
    Add('  CAM_DOC_IE, ');
    Add('  CAM_DOC_IS, ');
    Add('  CAM_ORDIMO, ');
    Add('  CAM_ORDAUT, ');
    Add('  CAM_TIPIMG, ');
    Add('  CAM_DOC_LA, ');
    Add('  CAM_DOC_CC, ');
    Add('  CAM_DOC_PE, ');
    Add('  CAM_DOC_RL, ');
    Add('  CAM_DOC_CRFF, ');
    Add('  CAM_DOC_CDPP, ');
    {************************************************************************************}
    {* A TAG <CFG></CFG> DEVE CONTER O NOME DE UMA CONFIGURAÇÃO DO SISTEMA,             *}
    {* QUANDO O CAMPO DESCAM POSSUIR ESSA TAG, SERÁ FEITO UM REPLACE COM O              *}
    {* VALOR DA CONFIGURAÇÃO NA CFGSIS.                                                 *}
    {* OBS. É PERMITIDO APENAS UMA TAG <CFG> POR REGISTRO                               *}
    {* REFERÊNCIA DA FUNÇÃO EXTRACTVALUE DO MYSQL:                                      *}
    {* https://dev.mysql.com/doc/refman/5.7/en/xml-functions.html#function_extractvalue *}
    {*********************************************************************************LO*}
    Add('  @CONFIG := IFNULL(TRIM(EXTRACTVALUE(CAM_DESCAM, "//CFG")),""),');
    Add('  @DESCAM := IF(@CONFIG = "", CAM_DESCAM, REPLACE(CAM_DESCAM, CONCAT("<CFG>",@CONFIG, "</CFG>"), (SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = CONCAT(@CONFIG) AND SIS_CODEMP = :CODEMP))) AS CAM_DESCAM, ');
    Add('  CONCAT(CAM_POSCAM, @DESCAM) AS CAM_POSDES, ');
    Add('  (SELECT GRU_PARENT FROM GRUETI WHERE GRU_CODGRU = CAM_GRUETI) AS PAI1, ');
    Add('  (SELECT GRU_PARENT FROM GRUETI WHERE GRU_CODGRU = (SELECT GRU_PARENT FROM GRUETI WHERE GRU_CODGRU = CAM_GRUETI)) AS PAI2 ');

    Add('FROM CAMETI C ');
    Add('WHERE');

    Add(fSQLFiltroCamposDocumento(ARR_CODIGO_ETIQUETA[FCodEti]));

    If Not fEmptyStr(strFilCampos) Then
      Add('AND ' + strFilCampos );

    If FCodEti In CONJ_LASER Then
      Add('AND CAM_LASER_ = "S"')
    Else
    If FCodEti In CONJ_ARGOX Then
      Add('AND CAM_ARGOX_ = "S"');

    If Not fCfgSis('LAUDES', varBoolean) Then
    Begin
      Add('AND ((CAM_CODCAM <> "IMPLAU") AND (CAM_CODCAM <> "ETIDES"))');
    End;

    Add('ORDER BY ');
    Add('  CAM_POSCAM, CAM_DESCAM ');

    ParamByName('CODETI').AsInteger := ARR_CODIGO_ETIQUETA[FCodEti];
    ParamByName('CODEMP').AsString  := VS_strCodEmp;
    Open;

  End;
End;

procedure TEditorFast.pAbreCamposTree;
Begin
  With FCamTre, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT * FROM GRUETI ');
    Add('WHERE');

    Add(fSQLFiltroGrupoCampos(ARR_CODIGO_ETIQUETA[FCodEti]));

    ParamByName('CODETI').AsInteger := ARR_CODIGO_ETIQUETA[FCodEti];

    Open;
  End;
End;

Function TEditorFast.fExcluiLayout: Boolean;
Begin
  Try
    Result := False;
    With FLayEti Do
    Begin
      If (Not Active) Or IsEmpty Then
        Exit;

      If SameText(FieldByName('LAY_PADRAO').AsString, 'S') Then
      Begin
        pMensagemOk('Layout padrão não pode ser excluido!');
        Exit;
      End;

      If Not fPergunta('Confirma a exclusão do layout?') Then
      Begin
        Exit;
      End;

      Delete;
      Close;

      pNovoLayout;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fExcluiLayout]');
    End;
  End;
End;

Function TEditorFast.fRetfrxMasterData: TfrxMasterData;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To FReport.ComponentCount - 1 Do
    If (FReport.Components[intIndice] Is TfrxMasterData) And
       (Not SameText((FReport.Components[intIndice] As TfrxMasterData).Name, 'masterVias')) Then
    Begin
      Result := (FReport.Components[intIndice] As TfrxMasterData);
      Break;
    End;
End;

Function TEditorFast.fRetfrxMasterDataVias: TfrxMasterData;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To FReport.ComponentCount - 1 Do
    If (FReport.Components[intIndice] Is TfrxMasterData) And
       (SameText((FReport.Components[intIndice] As TfrxMasterData).Name, 'masterVias')) Then
    Begin
      Result := (FReport.Components[intIndice] As TfrxMasterData);
      Break;
    End;
End;

Function TEditorFast.fRetfrxPage: TfrxReportPage;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  If Assigned(FEditor) Then
    FViaPag := FEditor.blnViaPag;

    For intIndice := 0 To FReport.ComponentCount - 1 Do
    If (FReport.Components[intIndice] Is TfrxReportPage) And
       ((Not FViaPag) Or SameText((FReport.Components[intIndice] As TfrxReportPage).Name, 'subRelat')) Then
    Begin
      Result := (FReport.Components[intIndice] As TfrxReportPage);
      Break;
    End

    Else If (FReport.Components[intIndice] Is TfrxDMPPage) Then
    Begin
      Result := (FReport.Components[intIndice] As TfrxReportPage);
      Break;
    End

End;

Function TEditorFast.fRetfrxPageVias: TfrxReportPage;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To FReport.ComponentCount - 1 Do
    If (FReport.Components[intIndice] Is TfrxReportPage) And
       SameText((FReport.Components[intIndice] As TfrxReportPage).Name, 'pageVias') Then
    Begin
      Result := (FReport.Components[intIndice] As TfrxReportPage);
      Break;
    End;

End;

Function TEditorFast.fRetfrxHeader: TfrxPageHeader;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To FReport.ComponentCount - 1 Do
    If (FReport.Components[intIndice] Is TfrxPageHeader) And
       (Not SameText((FReport.Components[intIndice] As TfrxPageHeader).Name, 'HeaderVias')) Then
    Begin
      Result := (FReport.Components[intIndice] As TfrxPageHeader);
      Break;
    End;
End;

Function TEditorFast.fRetfrxHeaderData: TfrxHeader;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To FReport.ComponentCount - 1 Do
    If (FReport.Components[intIndice] Is TfrxHeader) Then
    Begin
      Result := (FReport.Components[intIndice] As TfrxHeader);
      Result.ReprintOnNewPage := True;
      Break;
    End;
End;

Function TEditorFast.fRetfrxFooterData: TfrxFooter;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To FReport.ComponentCount - 1 Do
    If (FReport.Components[intIndice] Is TfrxFooter) Then
    Begin
      Result := (FReport.Components[intIndice] As TfrxFooter);
      Break;
    End;
End;

Function TEditorFast.fRetfrxPageFooter: TfrxPageFooter;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To FReport.ComponentCount - 1 Do
    If (FReport.Components[intIndice] Is TfrxPageFooter) And
       (Not SameText((FReport.Components[intIndice] As TfrxPageFooter).Name, 'FooterVias')) Then
    Begin
      Result := (FReport.Components[intIndice] As TfrxPageFooter);
      Break;
    End;
End;

Function TEditorFast.fRetfrxSummary: TfrxReportSummary;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To FReport.ComponentCount - 1 Do
    If (FReport.Components[intIndice] Is TfrxReportSummary) Then
    Begin
      Result := (FReport.Components[intIndice] As TfrxReportSummary);
      Break;
    End;
End;

function TEditorFast.fRetIdeProDoc(strAutInc, strEspDoc : String): String;
Var
  qryAux : TUniQuery;
  strSQL : String;
begin

  If (fCfgSis('EXIDOC') = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
    strSQL := 'SELECT DET_IDEPRO AS IDEPRO'+
              '  FROM TINDET '+
              ' WHERE AUTOINCREM = :AUTOINCREM '
  Else
    strSQL := 'SELECT FDO_IDEPRO As IDEPRO'+
              '  FROM TINDOR'+
              ' WHERE AUTOINCREM = :AUTOINCREM ';

  qryAux := fCriaQuery(Self);

  Try
    qryAux.Close;
    qryAux.SQl.Text := strSQL;
    qryAux.ParamByName('AUTOINCREM').AsString := strAutInc;
    qryAux.Open;

    Result := qryAux.FieldByName('IDEPRO').AsString;

  Finally
    FreeAndNil(qryAux);
  End;
end;

Function TEditorFast.fGetParent(fltTopOri: Double; Var fltTop: Double): TComponent;
Begin
  If FTipImp = 'J' Then
    Result := fGetParentJato(fltTopOri, fltTop)
  Else
    Result := fGetParentMatricial(fltTopOri, fltTop);
End;

Function TEditorFast.fGetParentMatricial(fltTopOri: Double; Var fltTop: Double): TComponent;
  Var
    fltPageFooterHeight: Double;
Begin
  If Assigned(frxPageFooter) And (Not FEditor.blnFooBra) Then
    fltPageFooterHeight := frxPageFooter.Height

  Else If Assigned(frxSummary) And Assigned(frxSummary) Then
    fltPageFooterHeight := frxSummary.Height
  Else
    fltPageFooterHeight := 0;

  fltTop := fltTopOri;

  If Assigned(frxHeader) And (fltTopOri < frxHeader.Height) Then
  Begin

    Result := frxHeader;

  End

  Else If Assigned(frxHeaderData) And Assigned(frxHeader) And
       (fltTopOri >= frxHeader.Height) And (fltTopOri < frxHeader.Height + frxHeaderData.Height) Then
  Begin

    Result := frxHeaderData;

    If Assigned(frxHeader) Then
      fltTop := fltTop - frxHeader.Height;

  End

  Else If Assigned(frxPageFooter) And (Not FEditor.blnFooBra) And
         (fltTopOri + fMargemmFastMatricialToPixels(frxPage.TopMargin, True) >=
         (frxPage.Height - frxPageFooter.Height - fMargemmFastMatricialToPixels(frxPage.BottomMargin, True))) Then
  Begin

    fltTop := fltTop - (frxPage.Height - (fMargemmFastMatricialToPixels(frxPage.TopMargin, True) +
                                          frxPageFooter.Height +
                                          fMargemmFastMatricialToPixels(frxPage.BottomMargin, True)));

    Result := frxPageFooter;
  End

  Else If Assigned(frxSummary) And
          (fltTopOri + fMargemmFastMatricialToPixels(frxPage.TopMargin, True) >=
          (frxPage.Height - frxSummary.Height - fMargemmFastMatricialToPixels(frxPage.BottomMargin, True))) Then
  Begin

    fltTop := fltTop - (frxPage.Height - (fMargemmFastMatricialToPixels(frxPage.TopMargin, True) +
                                          frxSummary.Height +
                                          fMargemmFastMatricialToPixels(frxPage.BottomMargin, True)));

    Result := frxSummary;
  End

  Else If Assigned(frxFooterData) And
          (fltTopOri + fMargemmFastMatricialToPixels(frxPage.TopMargin, True) >=
          (frxPage.Height - frxFooterData.Height - fltPageFooterHeight - fMargemmFastMatricialToPixels(frxPage.BottomMargin, True))) Then
  Begin

    fltTop := fltTop - (frxPage.Height - (fMargemmFastMatricialToPixels(frxPage.TopMargin, True) +
                                          frxFooterData.Height +
                                          fltPageFooterHeight +
                                          fMargemmFastMatricialToPixels(frxPage.BottomMargin, True)));

    Result := frxFooterData;
  End

  Else
  Begin

    If Assigned(frxMasterData) Then
      Result := frxMasterData
    Else
      Result := frxPage;

    If Assigned(frxHeader) Then
      fltTop := fltTop - frxHeader.Height - frxHeaderData.Height;

  End;

End;

Function TEditorFast.fGetParentJato(fltTopOri: Double; Var fltTop: Double): TComponent;
  Var
    fltPageFooterHeight: Double;
Begin
  If Assigned(frxPageFooter) Then
    fltPageFooterHeight := frxPageFooter.Height

  Else If Assigned(frxSummary) And Assigned(frxSummary) Then
    fltPageFooterHeight := frxSummary.Height
  Else
    fltPageFooterHeight := 0;

  fltTop := fltTopOri;

  If Assigned(frxHeader) And (fltTopOri < frxHeader.Height) Then
  Begin

    Result := frxHeader;

  End

  Else If Assigned(frxHeaderData) And Assigned(frxHeader) And
       (fltTopOri + 1 >= frxHeader.Height) And (fltTopOri + 1 < frxHeader.Height + frxHeaderData.Height) Then
  Begin

    Result := frxHeaderData;

    If Assigned(frxHeader) Then
      fltTop := fltTop - frxHeader.Height;

  End

  Else If Assigned(frxHeaderData) And (Not Assigned(frxHeader)) And
       (fltTopOri + 1 < frxHeaderData.Height) Then
  Begin

    Result := frxHeaderData;

  End


  Else If Assigned(frxPageFooter) And
          (fltTopOri + fCmColunaToPixel(frxPage.TopMargin / 10, True, FTipImp) >
          (frxPage.Height - frxPageFooter.Height - fCmColunaToPixel(frxPage.BottomMargin / 10, True, FTipImp))) Then
  Begin

    fltTop := fltTop - (frxPage.Height -
                         (fCmColunaToPixel(frxPage.TopMargin / 10, True, FTipImp) +
                          frxPageFooter.Height +
                          fCmColunaToPixel(frxPage.BottomMargin / 10, True, FTipImp)));

    Result := frxPageFooter;
  End

  Else If Assigned(frxSummary) And
          (fltTopOri + fCmColunaToPixel(frxPage.TopMargin / 10, True, FTipImp) >
          (frxPage.Height - frxSummary.Height - fCmColunaToPixel(frxPage.BottomMargin / 10, True, FTipImp))) Then
  Begin

    fltTop := fltTop - (frxPage.Height -
                         (fCmColunaToPixel(frxPage.TopMargin / 10, True, FTipImp) +
                          frxSummary.Height +
                          fCmColunaToPixel(frxPage.BottomMargin / 10, True, FTipImp)));

    Result := frxSummary;
  End

  Else If Assigned(frxFooterData) And
          (fltTopOri + fCmColunaToPixel(frxPage.TopMargin / 10, True, FTipImp) >
          (frxPage.Height - frxFooterData.Height - fltPageFooterHeight - fCmColunaToPixel(frxPage.BottomMargin / 10, True, FTipImp))) Then
  Begin

    fltTop := fltTop - (frxPage.Height -
                         (fCmColunaToPixel(frxPage.TopMargin / 10, True, FTipImp) +
                          frxFooterData.Height + fltPageFooterHeight +
                          fCmColunaToPixel(frxPage.BottomMargin / 10, True, FTipImp)));

    Result := frxFooterData;
  End

  Else
  Begin

    If Assigned(frxMasterData) Then
      Result := frxMasterData
    Else
      Result := frxPage;

    If Assigned(frxHeader) Then
      fltTop := fltTop - frxHeader.Height;

    If Assigned(frxHeaderData) Then
      fltTop := fltTop - frxHeaderData.Height;

    If fltTop < 0 Then
      fltTop := 0;

  End;

End;

Function TEditorFast.fParentEditor(fltTopOri: Double; Var fltTop: Double): TWinControl;
Begin
  If FTipImp = 'J' Then
    Result := fParentEditorJato(fltTopOri, fltTop)
  Else
    Result := fParentEditorMatricial(fltTopOri, fltTop);
End;

Function TEditorFast.fParentEditorMatricial(fltTopOri: Double; Var fltTop: Double): TWinControl;
  Var
    fltPageFooterHeight: Double;
Begin
  If Assigned(frxPageFooter) Then
    fltPageFooterHeight := frxPageFooter.Height

  Else If Assigned(frxSummary) Then
    fltPageFooterHeight := frxSummary.Height

  Else
    fltPageFooterHeight := 0;

  fltTop := fltTopOri;

  If (FParent Is TfrxHeader) Then // É O HEADERDATA
  Begin

    If Assigned(frxHeader) Then // É O PAGEHEADER
      fltTop := fltTop + frxHeader.Height;

  End

  Else If ((FParent Is TfrxMasterData) Or (FParent Is TfrxPage)) Then
  Begin

    If Assigned(frxHeader) Then
      fltTop := fltTop + frxHeader.Height;

    If Assigned(frxHeaderData) Then
      fltTop := fltTop + frxHeaderData.Height;

  End

  Else If (FParent Is TfrxFooter) Then
  Begin
    fltTop := fltTopOri + frxPage.Height - frxFooterData.Height - fltPageFooterHeight
              - fMargemmFastMatricialToPixels(frxPage.BottomMargin, True) - fMargemmFastMatricialToPixels(frxPage.TopMargin, True);
  End

  Else If (FParent Is TfrxReportSummary) Then
  Begin
    fltTop := fltTopOri + frxPage.Height - frxSummary.Height
              - fMargemmFastMatricialToPixels(frxPage.BottomMargin, True) - fMargemmFastMatricialToPixels(frxPage.TopMargin, True);
  End

  Else If (FParent Is TfrxPageFooter) Then
  Begin
    fltTop := fltTopOri + frxPage.Height - frxPageFooter.Height
              - fMargemmFastMatricialToPixels(frxPage.BottomMargin, True) - fMargemmFastMatricialToPixels(frxPage.TopMargin, True);
  End;

  Result := FEditor.scrScroll;
End;

Function TEditorFast.fParentEditorJato(fltTopOri: Double; Var fltTop: Double): TWinControl;
  Var
    fltPageFooterHeight: Double;
Begin
  If Assigned(frxPageFooter) Then
  Begin

    If Assigned(FEditor) And FEditor.blnConPro And (frxPageFooter.Height < 20) Then
      fltPageFooterHeight := 0
    Else
      fltPageFooterHeight := frxPageFooter.Height;

  End

  Else If Assigned(frxSummary) Then
    fltPageFooterHeight := frxSummary.Height

  Else
    fltPageFooterHeight := 0;

  fltTop := fltTopOri;

  If (FParent Is TfrxHeader) Then // É O HEADERDATA
  Begin

    If Assigned(frxHeader) Then // É O PAGEHEADER
      fltTop := fltTop + frxHeader.Height;

  End

  Else If ((FParent Is TfrxMasterData) Or (FParent Is TfrxPage)) Then
  Begin

    If Assigned(frxHeader) Then
      fltTop := fltTop + frxHeader.Height;

    If Assigned(frxHeaderData) Then
      fltTop := fltTop + frxHeaderData.Height;

  End

  Else If (FParent Is TfrxFooter) Then
  Begin
    fltTop := fltTopOri + frxPage.Height - frxFooterData.Height - fltPageFooterHeight
              - fCmColunaToPixel(frxPage.BottomMargin / 10, True, FTipImp) - fCmColunaToPixel(frxPage.TopMargin / 10, True, FTipImp);
  End

  Else If (FParent Is TfrxReportSummary) Then
  Begin
    fltTop := fltTopOri + frxPage.Height - frxSummary.Height
              - fCmColunaToPixel(frxPage.BottomMargin / 10, True, FTipImp) - fCmColunaToPixel(frxPage.TopMargin / 10, True, FTipImp);
  End

  Else If (FParent Is TfrxPageFooter) Then
  Begin
    fltTop := fltTopOri + frxPage.Height - frxPageFooter.Height
              - fCmColunaToPixel(frxPage.BottomMargin / 10, True, FTipImp) - fCmColunaToPixel(frxPage.TopMargin / 10, True, FTipImp);
  End;

  Result := FEditor.scrScroll;
End;

Procedure TEditorFast.pSetaInfoCodBar(strInfoBar: String);
  Var
    IntIndice: Integer;
Begin

  With FReport do
  For IntIndice := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intIndice] Is TfrxBarCodeView) And
       (SameText(TfrxBarCodeView(Components[intIndice]).Expression, '[CODBAR]') Or
        SameText(TfrxBarCodeView(Components[intIndice]).Expression, '[ <CODBAR>  ]')) Then
    Begin
      TfrxBarCodeView(Components[intIndice]).Expression := '';
      TfrxBarCodeView(Components[intIndice]).Text := strInfoBar;
    End;

    If (Components[intIndice] Is TfrxBarcode2DView) And
       (SameText(TfrxBarcode2DView(Components[intIndice]).Expression, '[CODBAR]') Or
        SameText(TfrxBarcode2DView(Components[intIndice]).Expression, '[ <CODBAR>  ]')) Then
    Begin
      TfrxBarcode2DView(Components[intIndice]).Expression := '';
      TfrxBarcode2DView(Components[intIndice]).Text := strInfoBar;
    End;
  End;

End;

procedure TEditorFast.pPedeOrdenacao;
Begin
  pCriarFormularios(TfrmPedeOrdenacao, frmPedeOrdenacao);

  frmPedeOrdenacao.cdsCamOrd := FObjOrd;

  If frmPedeOrdenacao.ShowModal = mrOk Then
    FOrdena := FObjOrd.fRetTextOrdenacao;

  pFreeAndNil(frmPedeOrdenacao);
End;

Function TEditorFast.fHerdaLayout(qryTabela: TUniQuery): Boolean;
Begin
  FHerdar := True;
  Result  := fCarregarLayout(False, qryTabela.FieldByName('LAY_CODLAY').AsString, False);
End;

Procedure TEditorFast.pCriaCommand(Var frxCommand: TfrxDMPCommand;
                                       frxPai: TComponent;
                                       strCommand: String;
                                       intLinha,
                                       intColuna: Double;
                                       blnMudaColuna: Boolean);
Begin
  If FLastCommand = strCommand Then
    Exit;

  FLastCommand := strCommand;

  If FExpOn Then
  Begin
    strCommand := STR_040COL_OFF + strCommand;
    FExpOn     := False;
  End;

  frxCommand         := TfrxDMPCommand.Create(frxPai);
  frxCommand.Top     := intLinha;

  If (intLinha = 0) And blnMudaColuna Then
    frxCommand.Left := fCmColunaToPixel(39, False, 'M')
  Else
    frxCommand.Left := fCmColunaToPixel(intColuna, False, 'M');

  frxCommand.Height  := fCmColunaToPixel(1, True, 'M');
  frxCommand.Width   := fCmColunaToPixel(1, False, 'M');
  frxCommand.Parent  := TfrxComponent(frxPai);
  frxCommand.Command := strCommand;

End;

Function TEditorFast.fColunaCommand(colColuna: TColMatricial): Integer;
Begin
  Case colColuna Of
    col40   : Result := 039;
    col80   : Result := 079;
    col96   : Result := 095;
    col137  : Result := 136;
    col160  : Result := 159;
    Else      Result := 159;
  End;
End;

Procedure TEditorFast.pCriaFormatacao(colFonte: TColMatricial;
                                      Var frxCommand: TfrxDMPCommand;
                                      frxPai: TComponent;
                                      intLinha,
                                      intColuna: Double;
                                      blnMudaColuna: Boolean);
Begin
  If Assigned(frxCommand) Then
    FreeAndNil(frxCommand);

  Case colFonte Of
    col40   : Begin
                pCriaCommand(frxCommand, frxPai, STR_040COL, intLinha, IfThen(intColuna > 0 , intColuna, fColunaCommand(colFonte)), blnMudaColuna);
                FExpOn := True;
              End;
    col80   : pCriaCommand(frxCommand, frxPai, STR_080COL, intLinha, IfThen(intColuna > 0 , intColuna, fColunaCommand(colFonte)), blnMudaColuna);
    col96   : pCriaCommand(frxCommand, frxPai, STR_096COL, intLinha, IfThen(intColuna > 0 , intColuna, fColunaCommand(colFonte)), blnMudaColuna);
    col137  : pCriaCommand(frxCommand, frxPai, STR_137COL, intLinha, IfThen(intColuna > 0 , intColuna, fColunaCommand(colFonte)), blnMudaColuna);
    col160  : pCriaCommand(frxCommand, frxPai, STR_160COL, intLinha, IfThen(intColuna > 0 , intColuna, fColunaCommand(colFonte)), blnMudaColuna);
  End;
End;

Function fCompara(Item1, Item2: Pointer): Integer;
  Var
    frxItem1,
    frxItem2: TfrxDMPCommand;
Begin
  frxItem1 := Item1;
  frxItem2 := Item2;

  If frxItem1.Top < frxItem2.Top Then
    Result := -1
  Else If frxItem1.Top > frxItem2.Top Then
    Result := 1
  Else
    Result := 0;
End;

Procedure TEditorFast.pFormataHeader(Var colFonteAnt: TColMatricial);
  Var
    intIndice,
    intContador: Integer;
    stlLista: TStringList;
    frxMemo: TfrxDMPMemoView;
    frxCampo: TfrxComponent;
    colFonte: TColMatricial;
    frxCommand: TfrxDMPCommand;
    objLista: TObjectList;
Begin
  FExpOn       := False;
  FLastCommand := '';

  colFonteAnt := col40;

  If Not Assigned(frxHeader) Then
    Exit;

  objLista := TObjectList.Create(False);

  stlLista := TStringList.Create;
  stlLista.Sorted := True;

  For intContador := 0 To frxHeader.Objects.Count - 1 Do
  Begin

    frxCampo := frxHeader.Objects.Items[intContador];

    If (frxCampo Is TfrxDMPMemoView) Then
    Begin
      frxMemo := (frxCampo As TfrxDMPMemoView);

      If Not stlLista.Find(FloatToStr(frxMemo.Top), intIndice) Then
      Begin
        stlLista.Add(FloatToStr(frxMemo.Top));

        objLista.Add(frxMemo);
      End;

    End;
  End;

  objLista.Sort(fCompara);

  For intContador := 0 To objLista.Count - 1 Do
  Begin
    frxMemo := TfrxDMPMemoView(objLista[intContador]);

    colFonte := fTextoToColMat(frxMemo.Description);
    frxCommand := Nil;

    pCriaFormatacao(colFonte, frxCommand, frxHeader, frxMemo.Top - ALTURA_FONTE_MATRICIAL_PIXEL, fColunaCommand(colFonteAnt), (frxMemo.Top - ALTURA_FONTE_MATRICIAL_PIXEL) = 0);

    colFonteAnt := colFonte;

  End;

  stlLista.Clear;
  FreeAndNil(stlLista);
  FreeAndNil(objLista);
End;

Procedure TEditorFast.pFormataHeaderData(Var colFonteAnt: TColMatricial);
  Var
    intIndice,
    intContador: Integer;
    stlLista: TStringList;
    frxMemo: TfrxDMPMemoView;
    frxCampo: TfrxComponent;
    colFonte: TColMatricial;
    frxCommand: TfrxDMPCommand;
    objLista: TObjectList;
    blnPrimeiro: Boolean;
Begin
  If Not Assigned(frxHeaderData) Then
    Exit;

  objLista := TObjectList.Create(False);

  stlLista := TStringList.Create;
  stlLista.Sorted := True;

  blnPrimeiro := True;

  For intContador := 0 To frxHeaderData.Objects.Count - 1 Do
  Begin
    frxCampo := frxHeaderData.Objects.Items[intContador];

    If (frxCampo Is TfrxDMPMemoView) Then
    Begin
      frxMemo := (frxCampo As TfrxDMPMemoView);

      If Not stlLista.Find(FloatToStr(frxMemo.Top), intIndice) Then
      Begin
        stlLista.Add(FloatToStr(frxMemo.Top));

        objLista.Add(frxMemo);
      End;

    End;

  End;

  objLista.Sort(fCompara);

  For intContador := 0 To objLista.Count - 1 Do
  Begin
    frxMemo := TfrxDMPMemoView(objLista[intContador]);

    colFonte := fTextoToColMat(frxMemo.Description);

    frxCommand := Nil;

    If blnPrimeiro Then
    Begin
      pCriaFormatacao(colFonte, frxCommand, frxHeader, frxHeader.Height - ALTURA_FONTE_MATRICIAL_PIXEL, fColunaCommand(colFonteAnt), False);
      blnPrimeiro := False;
    End Else
    Begin
      pCriaFormatacao(colFonte, frxCommand, frxHeaderData, frxMemo.Top - ALTURA_FONTE_MATRICIAL_PIXEL, fColunaCommand(colFonteAnt), False);
    End;

    colFonteAnt := colFonte;
  End;

  stlLista.Clear;
  FreeAndNil(stlLista);
  FreeAndNil(objLista);
End;

Procedure TEditorFast.pFormataFooterData(Var colFonteAnt: TColMatricial);
  Var
    intIndice,
    intContador: Integer;
    stlLista: TStringList;
    frxMemo: TfrxDMPMemoView;
    frxCampo: TfrxComponent;
    colFonte: TColMatricial;
    frxCommand: TfrxDMPCommand;
    objLista: TObjectList;
Begin
  If Not Assigned(frxFooterData) Then
    Exit;

  objLista := TObjectList.Create(False);

  stlLista := TStringList.Create;
  stlLista.Sorted := True;

  For intContador := 0 To frxFooterData.Objects.Count - 1 Do
  Begin
    frxCampo := frxFooterData.Objects.Items[intContador];

    If (frxCampo Is TfrxDMPMemoView) Then
    Begin
      frxMemo := (frxCampo As TfrxDMPMemoView);

      If Not stlLista.Find(FloatToStr(frxMemo.Top), intIndice) Then
      Begin
        stlLista.Add(FloatToStr(frxMemo.Top));

        objLista.Add(frxMemo);
      End;

    End;

  End;

  objLista.Sort(fCompara);

  For intContador := 1 To objLista.Count - 1 Do
  Begin
    frxMemo := TfrxDMPMemoView(objLista[intContador]);
    colFonte := fTextoToColMat(frxMemo.Description);
    frxCommand := Nil;
    pCriaFormatacao(colFonte, frxCommand, frxFooterData, frxMemo.Top - ALTURA_FONTE_MATRICIAL_PIXEL, fColunaCommand(colFonteAnt), False);
    colFonteAnt := colFonte;
  End;

  stlLista.Clear;
  FreeAndNil(stlLista);
  FreeAndNil(objLista);
End;

Procedure TEditorFast.pFormataPageFooter(Var colFonteAnt: TColMatricial);
  Var
    intIndice,
    intContador: Integer;
    stlLista: TStringList;
    frxMemo: TfrxDMPMemoView;
    frxCampo: TfrxComponent;
    colFonte: TColMatricial;
    frxCommand: TfrxDMPCommand;
    objLista: TObjectList;
    blnPrimeiro: Boolean;
Begin
  If Not Assigned(frxPageFooter) Then
    Exit;

  objLista := TObjectList.Create(False);

  stlLista := TStringList.Create;
  stlLista.Sorted := True;

  blnPrimeiro := True;

  For intContador := 0 To frxPageFooter.Objects.Count - 1 Do
  Begin
    frxCampo := frxPageFooter.Objects.Items[intContador];

    If (frxCampo Is TfrxDMPMemoView) Then
    Begin
      frxMemo := (frxCampo As TfrxDMPMemoView);

      If Not stlLista.Find(FloatToStr(frxMemo.Top), intIndice) Then
      Begin
        stlLista.Add(FloatToStr(frxMemo.Top));

        objLista.Add(frxMemo);
      End;

    End;

  End;

  objLista.Sort(fCompara);

  For intContador := 0 To objLista.Count - 1 Do
  Begin
    frxMemo := TfrxDMPMemoView(objLista[intContador]);
    colFonte := fTextoToColMat(frxMemo.Description);
    frxCommand := Nil;

    If blnPrimeiro Then
    Begin
      If Assigned(frxFooterData) Then
        pCriaFormatacao(colFonte, frxCommand, frxFooterData, frxFooterData.Height - ALTURA_FONTE_MATRICIAL_PIXEL, fColunaCommand(colFonteAnt), False);

      blnPrimeiro := False;
    End Else
    Begin
      pCriaFormatacao(colFonte, frxCommand, frxPageFooter, frxMemo.Top - ALTURA_FONTE_MATRICIAL_PIXEL, fColunaCommand(colFonteAnt), False);
    End;

    colFonteAnt := colFonte;
  End;

  stlLista.Clear;
  FreeAndNil(stlLista);
  FreeAndNil(objLista);
End;

Procedure TEditorFast.pFormataSummary(Var colFonteAnt: TColMatricial);
  Var
    intIndice,
    intContador: Integer;
    stlLista: TStringList;
    frxMemo: TfrxDMPMemoView;
    frxCampo: TfrxComponent;
    colFonte: TColMatricial;
    frxCommand: TfrxDMPCommand;
    objLista: TObjectList;
Begin
  If Not Assigned(frxSummary) Then
    Exit;

  objLista := TObjectList.Create(False);

  stlLista := TStringList.Create;
  stlLista.Sorted := True;

  For intContador := 0 To frxSummary.Objects.Count - 1 Do
  Begin
    frxCampo := frxSummary.Objects.Items[intContador];

    If (frxCampo Is TfrxDMPMemoView) Then
    Begin
      frxMemo := (frxCampo As TfrxDMPMemoView);

      If Not stlLista.Find(FloatToStr(frxMemo.Top), intIndice) Then
      Begin
        stlLista.Add(FloatToStr(frxMemo.Top));

        objLista.Add(frxMemo);
      End;

    End;

  End;

  objLista.Sort(fCompara);

  For intContador := 1 To objLista.Count - 1 Do
  Begin
    frxMemo := TfrxDMPMemoView(objLista[intContador]);
    colFonte := fTextoToColMat(frxMemo.Description);
    frxCommand := Nil;
    pCriaFormatacao(colFonte, frxCommand, frxSummary, frxMemo.Top - ALTURA_FONTE_MATRICIAL_PIXEL, fColunaCommand(colFonteAnt), False);
    colFonteAnt := colFonte;
  End;

  stlLista.Clear;
  FreeAndNil(stlLista);
  FreeAndNil(objLista);
End;

Procedure TEditorFast.pMudaFontePagina(colFonte: TColMatricial);
  Var
    intIndice : Integer;
    layCmpMvl : TLayStaticText;
Begin

  For intIndice := 0 To FCmpMvl.oblCamObj.Count - 1 Do
  Begin
    layCmpMvl := TLayStaticText(FCmpMvl.oblCamObj[intIndice]);

    If FEditor.fCampoTemFonteDaPagina(layCmpMvl.fltfrxTop) Then
      layCmpMvl.colFonMat := colFonte;
  End;

End;

Procedure TEditorFast.pMudaFontePaginaPrincipal;
Begin
  pMudaFontePagina(FEditor.fColFontePagina);
End;

procedure TEditorFast.pSetaVar(strNomVar: String; varValor: Variant);
begin
  Try
    FReport.Script.Variables[strNomVar] := varValor;
  Except
    //
  End;
end;

Function TEditorFast.fTemParametro(strNomPar: String): Boolean;
  Var
    intIndice: Integer;
Begin
  Result := False;

  For intIndice := 0 To FReport.ComponentCount - 1 Do
  Begin
    If (FReport.Components[intIndice] Is TfrxMemoView) And
       (Pos(strNomPar, String((FReport.Components[intIndice] As TfrxMemoView).Text)) > 0) Then
    Begin
      Result := True;
      Break;
    End

    Else If (FReport.Components[intIndice] Is TfrxDMPMemoView) And
       (Pos(strNomPar, String((FReport.Components[intIndice] As TfrxDMPMemoView).Text)) > 0) Then
    Begin
      Result := True;
      Break;
    End;
  End;
End;

Procedure TEditorFast.pAbreCliente(qryEtique: TUniQuery;
                                   blnEndCob: Boolean;
                                   strCamBus: String;
                                   blnTesteL: Boolean = False;
                                   strLisReg: String = '';
                                   intQtdEti: Integer = 0;
                                   ACliente: String = '');
  Var
    strSQL: String;
Begin
  With qryEtique Do
  Begin
    Close;
    SQL.Clear;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  C.CLI_NOMCLI AS NOME, ';
    strSQL := strSQL + '  C.CLI_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  C.CLI_CGCCPF AS CGCCPF, ';
    strSQL := strSQL + '  '+ fRetSQLCGCCPFFormatado('C.CLI_CGCCPF', 'C.CLI_C_G_C_') + '  AS C_G_C_, ';

    If (intQtdEti = 0) Then
      strSQL := strSQL + '  IFNULL(C.CLI_QTDETI, 0) AS QTDETI, '
    Else
      strSQL := strSQL + '  :QTDETI AS QTDETI, ';

    strSQL := strSQL + '  C.CLI_STATUS, ';
    strSQL := strSQL + '  C.CLI_CAIPOS AS CAIPOS, ';
    strSQL := strSQL + '  C.CLI_EMAIL_ AS EMAIL_, ';
    strSQL := strSQL + '  C.CLI_CELULA AS CELULA, ';

    If blnEndCob Then
    Begin
      {*******************************************}
      {* DADOS PARA COBRANÇA                     *}
      {****************************************jb*}
      strSQL := strSQL + '  IF(C.CLI_ENDCOB = "" OR C.CLI_ENDCOB IS NULL, C.CLI_ENDERE, C.CLI_ENDCOB) AS ENDERE, ';
      strSQL := strSQL + '  IF(C.CLI_ENDCOB = "" OR C.CLI_ENDCOB IS NULL, C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
      strSQL := strSQL + '  IF(C.CLI_ENDCOB = "" OR C.CLI_ENDCOB IS NULL, C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
      strSQL := strSQL + '  IF(C.CLI_ENDCOB = "" OR C.CLI_ENDCOB IS NULL, D1.CID_ESTADO, D2.CID_ESTADO) AS ESTCLI, ';
      strSQL := strSQL + '  CONCAT(IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, D1.CID_NOMCID, D2.CID_NOMCID), " / ",' +
                         '  IF(C.CLI_ENDCOB = "" OR C.CLI_ENDCOB IS NULL, D1.CID_ESTADO, D2.CID_ESTADO)) AS NOMCID, ';
      strSQL := strSQL + '  IF(C.CLI_ENDCOB = "" OR C.CLI_ENDCOB IS NULL, C.CLI_ENDNUM, "") AS ENDNUM, ';
      strSQL := strSQL + '  IF(C.CLI_ENDCOB = "" OR C.CLI_ENDCOB IS NULL, C.CLI_ENDCOM, "") AS ENDCOM  ';
    End
    Else
    Begin
      strSQL := strSQL + '  C.CLI_ENDERE AS ENDERE, ';
      strSQL := strSQL + '  C.CLI_BAIRRO AS BAIRRO, ';
      strSQL := strSQL + '  C.CLI_C_E_P_ AS C_E_P_, ';
      strSQL := strSQL + '  D1.CID_ESTADO AS ESTCLI, ';
      strSQL := strSQL + '  C.CLI_ENDNUM AS ENDNUM, ';
      strSQL := strSQL + '  C.CLI_ENDCOM AS ENDCOM, ';
      strSQL := strSQL + '  CONCAT(D1.CID_NOMCID," / ", D1.CID_ESTADO) AS NOMCID ';

    End;
    //ABA - CONTATOS CADASTRO DO CLIENTE
    strSQL := strSQL + ' ,TT.CLI_CODCLI AS CCLITT, '; //CODIGO DO CLIENTE
    strSQL := strSQL + '  TT.CLI_NOMCTT AS NOMCTT, '; //NOME DO CONTATO
    strSQL := strSQL + '  TT.CLI_ENDCTT AS ENDCTT, '; //ENDEREÇO DO CONTATO
    strSQL := strSQL + '  TT.CLI_BAICTT AS BAICTT, '; //BAIRRO DO CONTATO
    strSQL := strSQL + '  D3.CID_NOMCID AS CIDCTT, '; //CIDADE DO CONTATO
    strSQL := strSQL + '  TT.CLI_TELCTT AS TELCTT, '; //TELEFONE DO CONTATO
    strSQL := strSQL + '  TT.CLI_EMACTT AS EMACTT, '; //EMAIL DO CONTATO
    strSQL := strSQL + '  TT.CLI_CODEMP AS EMPCTT, '; //EMPRESA DO CONTATO
    strSQL := strSQL + '  TT.CLI_CELCTT AS CELCTT, '; //CELULAR DO CONTATO
    strSQL := strSQL + '  TT.CLI_FAXCTT AS FAXCTT, '; //FAX DO CONTATO
    strSQL := strSQL + '  TT.CLI_DEPCTT AS DEPCTT, '; //DEPARTAMENTO 1
    strSQL := strSQL + '  TT.CLI_NASCTT AS NASCTT, '; //DATA DE NASCIMENTO
    strSQL := strSQL + '  TT.CLI_OBSERV AS OBSCTT, '; //OBSERVAÇÃO
    strSQL := strSQL + '     CGO_DESCGO AS CGOCTT, '; //CARGO
    strSQL := strSQL + '     DPT_DESDPT AS DPTCTT, '; //DEPARTAMENTO 2
    strSQL := strSQL + '     TFU_DESTFU AS TFUCTT, ';
    strSQL := strSQL + '     HOB_DESHOB AS HOBCTT, '; //HOBBY
    strSQL := strSQL + '     ESC_DESESC AS ESCCTT, '; //ESCOLARIDADE
    strSQL := strSQL + '  TT.CLI_TEMSEG AS TMSGTT, '; //TEMPO SEGMENTO
    strSQL := strSQL + '  TT.CLI_TEMEMP AS TMEPTT, '; //TEMPO EMPRESA
    strSQL := strSQL + '     GMU_DESGMU AS GMUCTT, '; //GOSTO MUSICAL
    strSQL := strSQL + '     ECI_DESECI AS ECICTT, '; //ESTADO CIVIL
    strSQL := strSQL + '  TT.CLI_QTDFIL AS QTFITT, '; //QUANTIDADE DE FILHOS
    strSQL := strSQL + '  TT.CLI_CERCTT AS CERCTT, '; //CERTIFICAÇÕES
    strSQL := strSQL + '  TT.CLI_NUMCPF AS CPF_TT, '; //CPF
    strSQL := strSQL + '  TT.CLI_NUMR_G AS NRG_TT, '; //RG

    strSQL := strSQL + ' C.CLI_FONE01 AS FONE01, ';
    strSQL := strSQL + ' C.CLI_FONE02 AS FONE02  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI C ';
    strSQL := strSQL + '       JOIN CADCID D1 ON  C.CLI_CODCID = D1.CID_CODCID ';
    strSQL := strSQL + '  LEFT JOIN CADCID D2 ON  C.CLI_CIDCOB = D2.CID_CODCID ';
    strSQL := strSQL + '  LEFT JOIN CLICTT TT ON TT.AUTOINCREM =               ';
    strSQL := strSQL + '  (SELECT MIN(AUTOINCREM) FROM  CLICTT WHERE CLI_CODCLI = C.CLI_CODCLI) ';
    strSQL := strSQL + '  LEFT JOIN CADCID D3 ON TT.CLI_CIDCTT = D3.CID_CODCID ';
    strSQL := strSQL + '  LEFT JOIN CADCGO    ON    CGO_CODCGO = TT.CLI_CGOCTT  ';
    strSQL := strSQL + '  LEFT JOIN CADDPT    ON    DPT_CODDPT = TT.CLI_DPTCTT  ';
    strSQL := strSQL + '  LEFT JOIN CADTFU    ON    TFU_CODTFU = TT.CLI_TFUCTT  ';
    strSQL := strSQL + '  LEFT JOIN CADHOB    ON    HOB_CODHOB = TT.CLI_HOBCTT  ';
    strSQL := strSQL + '  LEFT JOIN CADESC    ON    ESC_CODESC = TT.CLI_ESCCTT  ';
    strSQL := strSQL + '  LEFT JOIN CADGMU    ON    GMU_CODGMU = TT.CLI_GMUCTT  ';
    strSQL := strSQL + '  LEFT JOIN CADECI    ON    ECI_CODECI = TT.CLI_ECICTT  ';
    strSQL := strSQL + 'WHERE TRUE ';

    If (Not fEmptyStr(strLisReg)) Then
      strSQL := strSQL + ' AND C.AUTOINCREM IN (' + strLisReg + ') ';

    If Not fEmptyStr(ACliente) Then
      strSQL := strSQL + ' AND LOCATE(C.CLI_CODCLI, ' + QuotedStr(ACliente) + ')';

    If blnTesteL Then
    Begin
      strSQL := strSQL + ' LIMIT 30 ';
    End
    Else
    Begin
      If (intQtdEti = 0) Then
        strSQL := strSQL + '  AND CLI_QTDETI > 0 ';

      strSQL := strSQL + 'ORDER BY ';

      If SameText(strCamBus, 'CID_NOMCID') Or
         SameText(strCamBus, 'CID_ESTADO')  Then
      Begin
        If blnEndCob Then
          strSQL := strSQL + 'D2.' + strCamBus
        Else
          strSQL := strSQL + 'D1.' + strCamBus
      End

      Else strSQL := strSQL + strCamBus;
    End;

    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If (intQtdEti > 0) Then
      ParamByName('QTDETI').AsInteger := intQtdEti;

    Open;
  End;

End;

Procedure TEditorFast.pAbreEntregaTintaMaquinaPreview;
Begin
  pSetaVar('NOMEMP', fRetNomeEmpresa(VS_strCodEmp));
  pSetaVar('NOMFAN', fRetFantasiaEmpresa(VS_strCodEmp));
  pSetaVar('NUMDOC', 'Doc.: 123456789012-NF-' +  VS_strCodEmp);
  pSetaVar('NOMVEN', 'Vendedor: 999-NOME DO VENDEDOR');
  pSetaVar('NOMVE2', '999');
  pSetaVar('DESTIN', 'DESCRIÇÃO DA TINTA');
  pSetaVar('QTDEMB', '123,456');
  pSetaVar('TIPEMB', 'TIPO EMBALAGEM');

  pSetaVar('NOMAUT', 'MONTADORA');
  pSetaVar('ANOAUT', '2011');

  pSetaVar('NOMCLI', 'NOME DO CLIENTE');
  pSetaVar('ENDENT', 'ENDEREÇO DO CLIENTE');

  pSetaVar('CIDENT', 'BAIRRO - CIDADE - ESTADO');

  pSetaVar('DTAEMI', 'Emissão: 01/01/2011');
  pSetaVar('DTAVAL', 'Validade: 01/01/2011');

  pSetaVar('MONTAD', 'MONTADORA');
  pSetaVar('VOLUME', FloatToStrF(123.456, ffFixed, 12, 3));

  pSetaVar('LINTIN', '0123456789');
  pSetaVar('LIDETI', 'AUTOBASE PLUS 100:50');
  pSetaVar('CATALI', 'CATALISE');
  pSetaVar('HOREMI', '00:00:00');
  pSetaVar('CODCLI', '99999999');

  pSetaVar('CODBAR', '12345678');
  pSetaVar('TIPFOR', '1');
  pSetaVar('COMPLE', 'COMPLEMENTO');
  pSetaVar('IDEPRO', 'IDEPRO');
  pSetaVar('PESOIT', '0.00');
  pSetaVar('CODEMP', VS_strCodEmp);

  pSetaVar('ANOTIN', '18-01-2020');
  pSetaVar('BAICID', 'BAIXA');
  pSetaVar('CEPENT', '00000-000');
  pSetaVar('CEPENT', '00000-000');
  pSetaVar('CODOPE', '000');
  pSetaVar('CODVEN', '000');
  pSetaVar('ESTENT', 'SP');
  pSetaVar('MONAUT', 'MONTADORA');
  pSetaVar('PREVEN', '0.00');

  pSetaVar('FO1OPE', '11-9999-7777');

  pSetaVar('F01EMP', '11-9999-7777');
  pSetaVar('F02EMP', '11-9999-7777');

  pSetaVar('REFERE', '12345678');
  pSetaVar('VENDED', '999-NOME DO VENDEDOR');
  pSetaVar('DESCO1', 'COR PRODUTO LINHA 1');
  pSetaVar('DESCO2', 'COR PRODUTO LINHA 2');
  pSetaVar('DOCUME', '123456789012-NF-' +  VS_strCodEmp);
  pSetaVar('DTEMIS', '01/01/2011');
  pSetaVar('DTVALI', '01/01/2011');

  pSetaVar('OBSCOL', 'Observação para Colorista');

  pSetaVar('NUMCMP', '000000000000');
  pSetaVar('NITCMP', '00000');
  pSetaVar('ENTRET', 'R');

  pSetaVar('NROETI', '000');
  pSetaVar('QTDETI', '000');

  pSetaInfoCodBar('12345678');
  pSetaVar('COLORI', 'NOME DO OPERADOR DA IMPRESSAO');
End;

procedure TEditorFast.pAbreSepErrPreview(qryEtique: TUniQuery);
Begin
  With qryEtique, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT                                              ');
    Add('  A.ITE_CODITE AS CODITE,                           ');
    Add('  A.ITE_REFERE AS REFERE,                           ');
    Add('  A.ITE_DESITE AS DESITE,                           ');
    Add('  C.MAR_DESMAR AS DESMAR,                           ');
    Add('  B.ITE_LOCFIS AS LOCFIS,                           ');
    Add('  "SEPARADOR"  AS NOMSEP                            ');
    Add('FROM CADITE A                                       ');
    Add('INNER JOIN ITEGER B ON B.ITE_CODITE = A.ITE_CODITE  ');
    Add('LEFT  JOIN CADMAR C ON C.MAR_CODMAR = A.ITE_CODMAR  ');
    Add('WHERE B.ITE_CODEMP = :CODEMP                        ');
    Add('LIMIT 30 ;                                          ');

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

  End;
End;

procedure TEditorFast.pAbreCodBarrasProdutoPreview(qryEtique: TUniQuery);
Begin
  With qryEtique, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT                                              ');
    Add('  A.ITE_CODBAR AS CODBAR,                           ');
    Add('  A.ITE_CODITE AS CODITE,                           ');
    Add('  A.ITE_DESITE AS DESITE,                           ');
    Add('  A.ITE_REFERE AS REFERE,                           ');
    Add('  "41"         AS QTDITE,                           ');
    Add('  "12345678"   AS CODCLI,                           ');
    Add('  "PREVIEW"    AS NOMCLI,                           ');
    Add('  "0000000048" AS NUMDOC,                           ');
    Add('  (SELECT MOE_DOLCOM FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DOLCOM, ');
    Add('  (SELECT MOE_DOLVEN FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DOLVEN, ');
    Add('  (SELECT MOE_CODEMP FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS MOEEMP, ');
    Add('  (SELECT MOE_DTAMOE FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DTAMOE, ');
    Add('  "999"        AS TOTITE,                           ');
    Add('  "CX"         AS UNIDAD,                           ');
    Add('  I.ITE_LOCFIS AS LOCFIS                            ');
    Add('FROM CADITE A                                       ');
    Add('LEFT JOIN ITEGER I ON I.ITE_CODITE = A.ITE_CODITE   ');
    Add('                  AND I.ITE_CODEMP = :CODEMP        ');
    Add('LIMIT 30 ;                                          ');

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

  End;
End;

Procedure TEditorFast.pAbreEmpresaPreview(qryEtique: TUniQuery);
  Var
    strSQL: String;
Begin
  strSQL := strSQL + ' SELECT CE.EMP_CODEMP AS CODEMP,                                             ';
  strSQL := strSQL + '        CE.EMP_NOMEMP AS NOMEMP,                                             ';
  strSQL := strSQL + '        CE.EMP_NOMFAN AS NOMFAN,                                             ';
  strSQL := strSQL + '        CE.EMP_C_G_C_ AS C_G_C_,                                             ';
  strSQL := strSQL + '        CE.EMP_I_E_S_ AS I_E_S_,                                             ';
  strSQL := strSQL + '        CONCAT(CE.EMP_ENDERE, IF(IFNULL(CE.EMP_ENDNUM,"") <> "", ", ", "" ), ';
  strSQL := strSQL + '        IFNULL(CE.EMP_ENDNUM,""), IF( IFNULL(CE.EMP_ENDCMP,""), " - ", "" ), ';
  strSQL := strSQL + '        IFNULL(CE.EMP_ENDCMP,"") ) AS ENDERE,                                ';
  strSQL := strSQL + '        CE.EMP_BAIRRO AS BAIRRO,                                             ';
  strSQL := strSQL + '        CI.CID_NOMCID AS NOMCID,                                             ';
  strSQL := strSQL + '        CI.CID_ESTADO AS ESTADO,                                             ';
  strSQL := strSQL + '        CE.EMP_C_E_P_ AS C_E_P_,                                             ';
  strSQL := strSQL + '        CE.EMP_FONE01 AS FONE01,                                             ';
  strSQL := strSQL + '        CE.EMP_FONE02 AS FONE02,                                             ';
  strSQL := strSQL + '        CE.EMP_F_A_X_ AS F_A_X_,                                             ';
  strSQL := strSQL + '        CE.EMP_EMAIL_ AS EMAIL_,                                             ';
  strSQL := strSQL + '        CE.EMP_HOMEPA AS HOMEPA,                                             ';
  strSQL := strSQL + '        IFNULL(FROM_BASE64(EI.EMP_IMGB64), "") AS EMPIMG                     ';
  strSQL := strSQL + ' FROM CADEMP CE                                                              ';
  strSQL := strSQL + ' INNER JOIN CADCID CI ON CI.CID_CODCID = CE.EMP_CODCID                       ';
  strSQL := strSQL + ' LEFT  JOIN EMPIMG EI ON EI.EMP_CODEMP = CE.EMP_CODEMP                       ';
  strSQL := strSQL + '                     AND EI.EMP_PRINCI = "S"                                 ';
  strSQL := strSQL + ' ORDER BY CE.EMP_CODEMP                                                      ';

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

End;

Procedure TEditorFast.pAbreOrdemProducao(qryEtique: TUniQuery; blnTesteL : boolean = False; strCodPro : String = ''; strCodEmp : ShortString = '');
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT PRO_CODITE AS CODITE,                       ';
  strSQL := strSQL + '        ITE_DESITE AS DESITE,                       ';
  strSQL := strSQL + '        ITE_REFERE AS REFERE,                       ';
  strSQL := strSQL + '        CLI_NOMCLI AS NOMCLI,                       ';
  strSQL := strSQL + '        PRO_NUMDOC AS NUMDOC,                       ';
  strSQL := strSQL + '        PRO_ESPDOC AS ESPDOC,                       ';
  strSQL := strSQL + '        MAR_DESMAR AS DESMAR,                       ';
  strSQL := strSQL + '        UNI_SIGUNI AS SIGUNI,                       ';
  strSQL := strSQL + '        ITE_EMBALA AS EMBALA,                       ';
  strSQL := strSQL + '        PRO_CODPRO AS CODPRO,                       ';
  strSQL := strSQL + '        ITE_LOCFIS AS LOCFIS,                       ';
  strSQL := strSQL + '        PRO_OBS001 AS OBS001,                       ';
  strSQL := strSQL + '        PRO_OBS002 AS OBS002,                       ';
  strSQL := strSQL + '        PRO_DTACAD AS DTACAD,                       ';
  strSQL := strSQL + '        PRO_DTAPRO AS DTAPRO,                       ';
  strSQL := strSQL + '        PRO_DTABAI AS DTABAI,                       ';
  strSQL := strSQL + '        PRO_QTDAPR AS QTDAPR,                       ';
  strSQL := strSQL + '        PRO_QTDPRO AS QTDPRO,                       ';
  strSQL := strSQL + '        ITE_PESOIT * PRO_QTDPRO AS PESBRU,          ';
  strSQL := strSQL + '        ITE_PESLIQ * PRO_QTDPRO AS PESLIQ,          ';
  strSQL := strSQL + '        ITE_CODBAR AS CODBAR,                       ';
  strSQL := strSQL + '        PRO_CODEMP AS CODEMP,                       ';
  strSQL := strSQL + '        PRO_CONFER AS CONFER,                       ';
  strSQL := strSQL + '        ITE_CODBAR AS CODBAR,                       ';
  strSQL := strSQL + '        IF(IFNULL(PRO_NUMDOC,"") <> ""              ';
  strSQL := strSQL + '           , CONCAT(PRO_NUMDOC, "-",                ';
  strSQL := strSQL + '                    PRO_ESPDOC, "-",                ';
  strSQL := strSQL + '                    PRO_CODEMP)                     ';
  strSQL := strSQL + '           , "")   AS NUMPED,                       ';
  strSQL := strSQL + ' CAST("" AS CHAR(100))   AS SEQDET,                 ';

  strSQL := strSQL + ' IF( '; //INDICA SE NO PEDIDO TEM SOMENTE ESTRUTURA.
  strSQL := strSQL + ' (SELECT COUNT(0) FROM FATDOR D2 WHERE D2.FDO_SEQGER = IFNULL(F1.AUTOINCREM, F2.AUTOINCREM)) = '; //QTDE DE ITENS NO PEDIDO
  strSQL := strSQL + ' (SELECT COUNT(0) FROM FATDOR D3 INNER JOIN GERMAT ON GMT_CODITE = FDO_CODITE WHERE D3.FDO_SEQGER = IFNULL(F1.AUTOINCREM, F2.AUTOINCREM)), '; //QTDE DE ITENS NO PEDIDO QUE É ESTRUTURA
  strSQL := strSQL + ' "S", "N") AS PEDEST, ';

  strSQL := strSQL + '        PRO_NUMLOT AS NUMLOT,                       ';
  strSQL := strSQL + '        LOT_DTAFAB AS DTAFAB,                       ';
  strSQL := strSQL + '        LOT_DTAVAL AS DTAVAL,                       ';
  strSQL := strSQL + '        DP.DOP_QTDITE AS QTDUTI                     ';

  strSQL := strSQL + ' FROM MOVPRO V                                      ';
  strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = V.PRO_CODITE ';
  strSQL := strSQL + ' LEFT  JOIN DETPRO DP ON DP.DOP_SEQGER = V.AUTOINCREM     ';
  strSQL := strSQL + ' LEFT  JOIN CADCLI C ON C.CLI_CODCLI = V.PRO_CODCLI ';
  strSQL := strSQL + ' LEFT  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';
  strSQL := strSQL + ' LEFT  JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = V.PRO_CODITE ';
  strSQL := strSQL + '                    AND G.ITE_CODEMP = V.PRO_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN FATDOR D1   ON FDO_ORDPRO = PRO_CODPRO AND FDO_EMPITE = PRO_CODEMP         ';
  strSQL := strSQL + '   LEFT JOIN FATGOR F1 ON F1.AUTOINCREM = FDO_SEQGER                                  ';
  strSQL := strSQL + '   LEFT JOIN FATGOR F2 ON (F2.FGO_NUMDOC = PRO_NUMPED AND F2.FGO_ESPDOC = PRO_ESPPED AND F2.FGO_CODEMP = PRO_EMPPED) ';
  strSQL := strSQL + '   LEFT JOIN CADLOT L ON (L.LOT_CODITE = V.PRO_CODITE AND L.LOT_CODEMP = V.PRO_CODEMP AND L.LOT_NUMLOT = V.PRO_NUMLOT)';

  if blnTesteL then
    strSQL := strSQL + ' LIMIT 10                                         '
  else
  begin
    strSQL := strSQL + ' WHERE                                            ';
    strSQL := strSQL + '      V.PRO_CODPRO = :CODPRO                      ';
    strSQL := strSQL + '  AND V.PRO_CODEMP = :CODEMP                      ';
  end;

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    if not blnTesteL then
    begin
      ParamByName('CODPRO').AsString := strCodPro;
      ParamByName('CODEMP').AsString := String(strCodEmp);
    end;

    Open;
  End;

End;

Procedure TEditorFast.pAbreOrdemProducaoIndustrialPreview(qryEtique: TUniQuery);
  Var
    strSQL: String;
Begin
  strSQL := '/* untEditorFast.pAbreOrdemProducaoIndustrialPreview */ ';

  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL + '  C.ITE_CODBAR     AS CODBAR, ';
  strSQL := strSQL + '  I.ITE_CODITE     AS CODITE, ';

  strSQL := strSQL + '  C.ITE_CODFAB     AS CODFAB, ';
  strSQL := strSQL + '  DATE_FORMAT(ORD_DTAVAL, "%m/%Y") AS DTAVAL, ';
  strSQL := strSQL + '  IF(IFNULL(C.ITE_PRAVAL,0) = 0, ORD_DTAVAL, DATE_ADD(IFNULL(ORD_DTABAI, ORD_DTAPRE), INTERVAL C.ITE_PRAVAL MONTH)) AS VALITE, ';
  strSQL := strSQL + '  C.ITE_PRAVAL AS PRAVAL, ';
  strSQL := strSQL + '  ORD_DTACAD     AS DTACAD, ';
  strSQL := strSQL + '  COR_DETCOR     AS DESCOR, ';
  strSQL := strSQL + '  ORD_DTABAI     AS DTABAI, ';

  strSQL := strSQL + '  "00000" AS LAYOUT, ';

  strSQL := strSQL + '  C.ITE_DESITE AS DESCRI, ';
  strSQL := strSQL + '  CONCAT(IFNULL(GRU_DETLIN, ""), " ", ';
  strSQL := strSQL + '         IFNULL(GRU_DETGRU, ""), " ", ';
  strSQL := strSQL + '         IFNULL(U.UNI_DETUNI, "")) AS DESITE, ';
  strSQL := strSQL + '  C.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '  I.ITE_LOCFIS AS LOCFIS, ';
  strSQL := strSQL + '  U.UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '  U.UNI_DESUNI AS DESUNI, ';
  strSQL := strSQL + '  U.UNI_DREUNI AS DREUNI, ';
  strSQL := strSQL + '  U.UNI_DETUNI AS DETUNI, ';
  strSQL := strSQL + '  GRU_DETGRU AS DETGRU, ';
  strSQL := strSQL + '  GRU_DETLIN AS DETLIN, ';
  strSQL := strSQL + '  GRU_SGETGR AS SGETGR, ';
  strSQL := strSQL + '  C.ITE_BAREMB AS BAREMB, ';
  strSQL := strSQL + '  MAR_DESMAR AS DESMAR, ';

  strSQL := strSQL + '  BAR_DESCRI AS DESCRI, ';
  strSQL := strSQL + '  BAR_EMBALA AS EMBALA, ';
  strSQL := strSQL + '  MAR_DESMAR AS DESMAR, ';

  strSQL := strSQL + '  ETI_COMP01 AS COMP01, ';
  strSQL := strSQL + '  ETI_COMP02 AS COMP02, ';
  strSQL := strSQL + '  ETI_COMP03 AS COMP03, ';
  strSQL := strSQL + '  ETI_COMP04 AS COMP04, ';
  strSQL := strSQL + '  ETI_COMP05 AS COMP05, ';
  strSQL := strSQL + '  ETI_COMP06 AS COMP06, ';
  strSQL := strSQL + '  ETI_COMP07 AS COMP07, ';
  strSQL := strSQL + '  ETI_COMP08 AS COMP08, ';
  strSQL := strSQL + '  ETI_COMP09 AS COMP09, ';
  strSQL := strSQL + '  ETI_COMP10 AS COMP10, ';
  strSQL := strSQL + '  C.ITE_DESFAB AS DESFAB, ';

  strSQL := strSQL + '  FDO_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
  strSQL := strSQL + '  FDO_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  ORD_DTAPRE AS DTAPRE, ';
  strSQL := strSQL + '  C.ITE_PESOIT AS PESOIT, ';
  strSQL := strSQL + '  C.ITE_PESLIQ AS PESLIQ, ';
  strSQL := strSQL + '  C.ITE_DESFAB AS DESFAB, ';

  {Inicio de Informações de itens de componentes AB}
  strSQL := strSQL + '  CB.ITE_DESITE AS DESPRI, ';
  strSQL := strSQL + '  CD.ITE_DESITE AS DESDIL, ';
  strSQL := strSQL + '  CB.ITE_REFERE AS REFERB, '; //Referencia produto B
  strSQL := strSQL + '  CD.ITE_REFERE AS REFERD, '; //Referencia diluente
  strSQL := strSQL + '  CI.ITE_APLICA AS APLICA, '; //Aplicacao do produto
  strSQL := strSQL + '  CASE WHEN CI.ITE_VALCAT > 0 THEN CONCAT(CI.ITE_VALCAT, ":1") END AS RELCAT, '; //Relação da Catalise
                        {Condição para volume unitário A}
  strSQL := strSQL + '  CASE WHEN (SELECT SUM(IF(UNI_KILLIT="K", ';
  strSQL := strSQL + '                        IF(ORD_PESREA > 0, ((ORD_QTDPRO * UNI_PESLIT) / ';
  strSQL := strSQL + '                                             ORD_PESREA),0), ORD_QTDPRO * UNI_PESLIT ))FROM ORDDET DD ';
  strSQL := strSQL + '             INNER JOIN CADITE ON ITE_CODITE = DD.ORD_CODITE ';
  strSQL := strSQL + '             INNER JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ';
  strSQL := strSQL + '             INNER JOIN ORDGER O ON O.AUTOINCREM = ORD_SEQGER ';
  strSQL := strSQL + '             WHERE ORD_SEQGER = G.AUTOINCREM GROUP BY DD.ORD_SEQGER) > 0 THEN ';
  strSQL := strSQL + '             CAST( (SELECT SUM(IF(UNI_KILLIT="K", ';
  strSQL := strSQL + '                               IF(ORD_PESREA > 0, ((ORD_QTDPRO * UNI_PESLIT) /';
  strSQL := strSQL + '                                                    ORD_PESREA),0), ORD_QTDPRO * UNI_PESLIT ))FROM ORDDET DD ';
  strSQL := strSQL + '                    INNER JOIN CADITE ON ITE_CODITE = DD.ORD_CODITE ';
  strSQL := strSQL + '                    INNER JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ';
  strSQL := strSQL + '                    INNER JOIN ORDGER O ON O.AUTOINCREM = ORD_SEQGER ';
  strSQL := strSQL + '                    WHERE ORD_SEQGER = G.AUTOINCREM GROUP BY DD.ORD_SEQGER) AS DECIMAL(15,2)) END AS VOLUMA, '; //Volume unitario do Volume A

                       {Condição para volume unitário B}
  strSQL := strSQL + '  CASE WHEN (SELECT SUM(IF(UNI_KILLIT="K", ';
  strSQL := strSQL + '                        IF(ORD_PESREA > 0, ((ORD_QTDPRO * UNI_PESLIT) / ';
  strSQL := strSQL + '                                             ORD_PESREA),0), ORD_QTDPRO * UNI_PESLIT )) FROM ORDDET DD ';
  strSQL := strSQL + '             INNER JOIN CADITE ON ITE_CODITE = DD.ORD_CODITE ';
  strSQL := strSQL + '             INNER JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ';
  strSQL := strSQL + '             INNER JOIN ORDGER O ON O.AUTOINCREM = ORD_SEQGER ';
  strSQL := strSQL + '             WHERE ORD_SEQGER = G.ORD_SEQCPN GROUP BY DD.ORD_SEQGER) > 0 THEN ';
  strSQL := strSQL + '             CAST( (SELECT SUM(IF(UNI_KILLIT="K", ';
  strSQL := strSQL + '                               IF(ORD_PESREA > 0, ((ORD_QTDPRO * UNI_PESLIT) /';
  strSQL := strSQL + '                                                    ORD_PESREA),0), ORD_QTDPRO * UNI_PESLIT )) FROM ORDDET DD ';
  strSQL := strSQL + '                    INNER JOIN CADITE ON ITE_CODITE = DD.ORD_CODITE ';
  strSQL := strSQL + '                    INNER JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ';
  strSQL := strSQL + '                    INNER JOIN ORDGER O ON O.AUTOINCREM = ORD_SEQGER ';
  strSQL := strSQL + '                    WHERE ORD_SEQGER = G.ORD_SEQCPN GROUP BY DD.ORD_SEQGER) AS DECIMAL(15,2)) END AS VOLUMB, ';//Volume unitario do Volume B
  {Fim de Informações de itens de componentes AB}


  strSQL := strSQL + '  CONCAT(DATE_FORMAT(ORD_DTACAD, "%d%m/%y"), "-", ORD_CODORD) AS NUMLOT,  ';
  strSQL := strSQL + '  CONCAT(D.ORD_CODITE, DATE_FORMAT(ORD_DTACAD, "%d%m%y"), ORD_CODORD) AS LOTRAS,  ';
  strSQL := strSQL + '  ORD_DTACAD AS DTACAD,  ';
  strSQL := strSQL + '  CAST("1" AS CHAR(1)) AS SEQITE, ';
  strSQL := strSQL + '  CAST("" AS CHAR(100)) AS SEQDET,         ';
  strSQL := strSQL + '  "PREVIEW OBS" AS OBSOPI,         ';
  strSQL := strSQL + '  FDO_COMPLE AS COMPLE, ';
  strSQL := strSQL + '  C.ITE_DESSIM AS DESSPF ';

  strSQL := strSQL + ' FROM ';

  strSQL := strSQL + '   ORDGER G ';

  strSQL := strSQL + ' INNER JOIN CADITE CI ON CI.ITE_CODITE = ORD_CODITE ';
  strSQL := strSQL + ' INNER JOIN ORDDET D ON D.ORD_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + ' INNER JOIN CADITE C ON D.ORD_CODITE = C.ITE_CODITE ';
  strSQL := strSQL + ' INNER JOIN ITEGER I ON D.ORD_CODITE = I.ITE_CODITE AND ORD_CODEMP = I.ITE_CODEMP ';
  strSQL := strSQL + ' INNER JOIN CADCOR   ON C.ITE_CODCOR = COR_CODCOR ';
  strSQL := strSQL + ' INNER JOIN CADGRU   ON C.ITE_CODGRU = GRU_CODGRU ';
  strSQL := strSQL + ' INNER JOIN CADUNI U ON C.ITE_CODUNI = U.UNI_CODUNI ';
  strSQL := strSQL + '  LEFT JOIN ITEBAR   ON   BAR_CODITE = C.ITE_CODITE AND BAR_COMPRA = 1 ';
  strSQL := strSQL + '  LEFT JOIN COMETI   ON   ETI_CODITE = C.ITE_CODITE        ';

  strSQL := strSQL + '  LEFT JOIN CADMAR   ON C.ITE_CODMAR = MAR_CODMAR ';
  strSQL := strSQL + '  LEFT JOIN EXTDOR   ON FDO_SEQOPI = G.AUTOINCREM      ';
  strSQL := strSQL + '  LEFT JOIN FATDOR   ON FATDOR.AUTOINCREM = FDO_SEQFDO ';
  strSQL := strSQL + '  LEFT JOIN CADCLI   ON CLI_CODCLI = FDO_CODCLI        ';
  strSQL := strSQL + '  LEFT JOIN CADITE CB  ON CI.ITE_CODITB = CB.ITE_CODITE ';
  strSQL := strSQL + '  LEFT JOIN CADITE CD  ON CI.ITE_CODITD = CD.ITE_CODITE ';
  strSQL := strSQL + '  LEFT JOIN CADUNI UB ON CB.ITE_CODUNI = UB.UNI_CODUNI ';


  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   ORD_CODEMP = :CODEMP ';

  strSQL := strSQL + '  LIMIT 50 ';

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByname('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;

End;


procedure TEditorFast.pAbreArmazenamentoPreview(qryEtique: TUniQuery);
  Var
    strSQL: String;
Begin
  strSQL := '/* untEditorFast.pAbreArmazenamentoPreview */';

  strSQL := strSQL + ' SELECT                           ';
  strSQL := strSQL + '   ITE_CODITE   AS CODITE,        ';
  strSQL := strSQL + '   ITE_DESITE   AS DESITE,        ';
  strSQL := strSQL + '   0            AS QTDITE,        ';
  strSQL := strSQL + '   1            AS SEQDET,        ';
  strSQL := strSQL + '   CURRENT_DATE AS DTAEMI,        ';
  strSQL := strSQL + '   ITE_CODBAR   AS CODBAR,        ';
  strSQL := strSQL + '   ITE_BAREMB AS BAREMB,          ';
  strSQL := strSQL + '   CAST("" AS CHAR(1)) AS LOCFIS, ';
  strSQL := strSQL + '   CAST("" AS CHAR(1)) AS LOCSUP, ';
  strSQL := strSQL + '   U.UNI_SIGUNI AS SIGUNI         ';
  strSQL := strSQL + ' FROM                             ';
  strSQL := strSQL + '   CADITE                         ';
  strSQL := strSQL + '   LEFT JOIN CADUNI U ON U.UNI_CODUNI = CADITE.ITE_UNICOM ';
  strSQL := strSQL + ' LIMIT 50                         ';

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

End;

procedure TEditorFast.pAbreOs(qryEtique: TUniQuery;
                              blnTesteL: Boolean = False;
                              strNumDoc: String = '';
                              strCodEmp: String = '');
  Var
    strSQL: String;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  C.CLI_NOMCLI AS NOMCLI, ';
  strSQL := strSQL + '  G.EQU_NUMOSE AS NUMOSE, ';
  strSQL := strSQL + '  G.EQU_PREVIS AS DTAPRE, ';
  strSQL := strSQL + '  T.OPE_NOMOPE AS TECNIC, ';

  strSQL := strSQL + '  E.EQU_DESCRI AS EQUIP_, ';
  strSQL := strSQL + '  G.EQU_DESCRI AS OBSERV, ';
  strSQL := strSQL + '  REPLACE(GROUP_CONCAT(D.EQU_DESDFE),","," | ") AS DEFEIT, ';
  strSQL := strSQL + '  REPLACE(GROUP_CONCAT(S.EQU_DESSER),","," | ") AS SERVIC, ';
  strSQL := strSQL + '  G.EQU_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  E.EQU_MODELO AS EQUMOD, ';
  strSQL := strSQL + '  G.EQU_OBSGER AS OBSGER  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  EQUGER G LEFT JOIN EQUSER S ON G.AUTOINCREM = S.EQU_SEQGER ';
  strSQL := strSQL + '           LEFT JOIN CADCLI C ON C.CLI_CODCLI = G.EQU_CODCLI ';
  strSQL := strSQL + '           LEFT JOIN CADOPE T ON T.OPE_CODOPE = G.EQU_CODTEC ';
  strSQL := strSQL + '           LEFT JOIN CADEQU E ON E.EQU_CODIGO = G.EQU_CODEQU ';
  strSQL := strSQL + '           LEFT JOIN EQUDFE D ON D.EQU_SEQGER = G.AUTOINCREM ';

  strSQL := strSQL + 'WHERE ';

  If Not blnTesteL Then
    strSQL := strSQL + '  G.EQU_NUMOSE = :NUMDOC AND ';

  strSQL := strSQL + '  G.EQU_CODEMP = :CODEMP     ';
  strSQL := strSQL + 'GROUP BY G.EQU_NUMOSE        ';
  strSQL := strSQL + 'ORDER BY NUMOSE, DTAPRE      ';

  If blnTesteL Then
    strSQL := strSQL + ' LIMIT 30 ';

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not blnTesteL Then
      ParamByName('NUMDOC').AsString := strNumDoc;

    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
  End;
end;

procedure TEditorFast.pAbreOSVenda(qryEtique: TUniQuery; blnTesteL: Boolean; strNumOrd, strCodEmp: String);
  Var
    strSQL: String;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  strSQL := '';
  strSQL := strSQL + 'SELECT ORD_NUMORD AS NUMORD, ';
  strSQL := strSQL + '       ORD_CODITE AS CODITE, ';
  strSQL := strSQL + '       ORD_CODCLI AS CODCLI, ';
  strSQL := strSQL + '       ORD_TOT_M2 AS TOT_M2, ';
  strSQL := strSQL + '       ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '       CLI_NOMCLI AS NOMCLI, ';
  strSQL := strSQL + '       "1/1" AS SEQDET       ';
  strSQL := strSQL + '  FROM ORDSER                ';
  strSQL := strSQL + ' INNER JOIN CADITE ON ITE_CODITE = ORD_CODITE ';
  strSQL := strSQL + ' INNER JOIN CADCLI ON CLI_CODCLI = ORD_CODCLI ';
  strSQL := strSQL + ' WHERE ';

  If Not blnTesteL Then
    strSQL := strSQL + ' ORD_NUMORD = :NUMDOC AND ';

  strSQL := strSQL + ' ORD_CODEMP = :CODEMP ';
  strSQL := strSQL + 'ORDER BY NUMORD, CODITE ';

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not blnTesteL Then
      ParamByName('NUMDOC').AsString := strNumOrd;

    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
  End;
end;

Procedure TEditorFast.pAbreUnidadesRestantesPreview(qryEtique: TUniQuery);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  C.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '  C.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  C.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '  I.ITE_LOCFIS AS LOCFIS, ';
  strSQL := strSQL + '    12.34      AS QTDITE, ';
  strSQL := strSQL + '    UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '  M.MAR_DESMAR AS DESMAR, ';
//  strSQL := strSQL + '  CONCAT(C.ITE_CODGRU, "0", C.ITE_CODITE, "001234") AS CODBAR, ';

  strSQL := strSQL + '  "9999000123000600" AS CODBAR, ';

  strSQL := strSQL + '  (SELECT OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = :CODOPE) AS NOMOPE, ';

  strSQL := strSQL + '  (SELECT MOE_DOLCOM FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DOLCOM, ';
  strSQL := strSQL + '  (SELECT MOE_DOLVEN FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DOLVEN, ';
  strSQL := strSQL + '  (SELECT MOE_CODEMP FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS MOEEMP, ';
  strSQL := strSQL + '  (SELECT MOE_DTAMOE FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DTAMOE, ';
  strSQL := strSQL + '  "9999000123000600" AS BARITE, ';
  strSQL := strSQL + '  "LOTE 001-002-003-004/11/44/225" AS NUMLOT, ';
  strSQL := strSQL + '  CURRENT_DATE AS DTAEMI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE C ';

  strSQL := strSQL + 'INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE AND ';
  strSQL := strSQL + '                       I.ITE_CODEMP = :CODEMP ';

  strSQL := strSQL + 'INNER JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ';
  strSQL := strSQL + 'JOIN CADMAR M ON M.MAR_CODMAR = C.ITE_CODMAR ';

  strSQL := strSQL + ' WHERE ITE_ITEATI = "S" ';

  strSQL := strSQL + ' LIMIT 30 ';

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByname('CODEMP').AsString := VS_strCodEmp;
    ParamByname('CODOPE').AsString := strLoginUsuarioLogado;
    Open;
  End;

  If fTemParametro('NUMDOC') Then
    FReport.Script.Variables['NUMDOC'] := '999999999999';

  If fTemParametro('ESPDOC') Then
    FReport.Script.Variables['ESPDOC'] := 'NF';

  If fTemParametro('CODEMP') Then
    FReport.Script.Variables['CODEMP'] := '001';

  If fTemParametro('CODCON') Then
    FReport.Script.Variables['CODCON'] := '999';

  If fTemParametro('NOMCON') Then
    FReport.Script.Variables['NOMCON'] := 'CONFERENTE';

  If fTemParametro('CLICOD') Then
    FReport.Script.Variables['CLICOD'] := '00000001';

  If fTemParametro('CLINOM') Then
    FReport.Script.Variables['CLINOM'] := 'NOME DO CLIENTE';

  If fTemParametro('EMPNOM') Then
    FReport.Script.Variables['EMPNOM'] := 'NOME DA EMPRESA';

End;

Function TEditorFast.fSQLFuncionario(blnClient: Boolean; intQtdEti: Integer = 0): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  If blnClient Then
  Begin
    strSQL := strSQL + ' 0 AS QTDETI, '
  End Else
  Begin
    If (intQtdEti = 0) Then
      strSQL := strSQL + '  IFNULL(FUN_QTDETI, 0) AS QTDETI, '
    Else
      strSQL := strSQL + '  :QTDETI AS QTDETI, ';
  End;

  strSQL := strSQL + ' FUN_CODEMP AS EMPFUN, ';
  strSQL := strSQL + ' IFNULL(EMP_NOMEMP, "") AS NOMEMP, ';
  strSQL := strSQL + ' IFNULL(EMP_C_G_C_, "") AS CNPJEM, ';
  strSQL := strSQL + ' FUN_CODFUN AS CODFUN, ';
  strSQL := strSQL + ' FUN_NOMFUN AS NOMFUN, ';
  strSQL := strSQL + ' FNC_NOMFNC AS FUNCAO, ';
  strSQL := strSQL + ' FUN_DTAADM AS DTAADM, ';
  strSQL := strSQL + ' FUN_DTADEM AS DTADEM, ';
  strSQL := strSQL + ' FUN_SALBAS AS SALBAS, ';
  strSQL := strSQL + ' FUN_BANCO_ AS CODBAN, ';
  strSQL := strSQL + ' FUN_AGENCI AS AGENCI, ';
  strSQL := strSQL + ' FUN_CONTA_ AS CONCOR, ';
  strSQL := strSQL + ' FUN_PISPAS AS PISPAS, ';
  strSQL := strSQL + ' FUN_CARPON AS CARPON, ';
  strSQL := strSQL + ' FUN_REGIST AS REGIST, ';
  strSQL := strSQL + ' FUN_OBSERV AS OBSERV, ';
  strSQL := strSQL + ' FUN_N_CTPS AS CTPSFU, ';
  strSQL := strSQL + ' FUN_NUMSER AS NUMSER, ';
  strSQL := strSQL + ' FUN_C_P_F_ AS CPFFUN, ';
  strSQL := strSQL + ' FUN_NUM_RG AS RGFUNC, ';
  strSQL := strSQL + ' FUN_HT1DOM AS HT1DOM, ';
  strSQL := strSQL + ' FUN_HT2DOM AS HT2DOM, ';
  strSQL := strSQL + ' FUN_HT3DOM AS HT3DOM, ';
  strSQL := strSQL + ' FUN_HT4DOM AS HT4DOM, ';
  strSQL := strSQL + ' FUN_HT1SEG AS HT1SEG, ';
  strSQL := strSQL + ' FUN_HT2SEG AS HT2SEG, ';
  strSQL := strSQL + ' FUN_HT3SEG AS HT3SEG, ';
  strSQL := strSQL + ' FUN_HT4SEG AS HT4SEG, ';
  strSQL := strSQL + ' FUN_HT1TER AS HT1TER, ';
  strSQL := strSQL + ' FUN_HT2TER AS HT2TER, ';
  strSQL := strSQL + ' FUN_HT3TER AS HT3TER, ';
  strSQL := strSQL + ' FUN_HT4TER AS HT4TER, ';
  strSQL := strSQL + ' FUN_HT1QUA AS HT1QUA, ';
  strSQL := strSQL + ' FUN_HT2QUA AS HT2QUA, ';
  strSQL := strSQL + ' FUN_HT3QUA AS HT3QUA, ';
  strSQL := strSQL + ' FUN_HT4QUA AS HT4QUA, ';
  strSQL := strSQL + ' FUN_HT1QUI AS HT1QUI, ';
  strSQL := strSQL + ' FUN_HT2QUI AS HT2QUI, ';
  strSQL := strSQL + ' FUN_HT3QUI AS HT3QUI, ';
  strSQL := strSQL + ' FUN_HT4QUI AS HT4QUI, ';
  strSQL := strSQL + ' FUN_HT1SEX AS HT1SEX, ';
  strSQL := strSQL + ' FUN_HT2SEX AS HT2SEX, ';
  strSQL := strSQL + ' FUN_HT3SEX AS HT3SEX, ';
  strSQL := strSQL + ' FUN_HT4SEX AS HT4SEX, ';
  strSQL := strSQL + ' FUN_HT1SAB AS HT1SAB, ';
  strSQL := strSQL + ' FUN_HT2SAB AS HT2SAB, ';
  strSQL := strSQL + ' FUN_HT3SAB AS HT3SAB, ';
  strSQL := strSQL + ' FUN_HT4SAB AS HT4SAB, ';
  strSQL := strSQL + ' FUN_GRAINS AS GRAINS, ';
  strSQL := strSQL + ' FUN_NACION AS NACION, ';
  strSQL := strSQL + ' FUN_NOMPAI AS NOMPAI, ';
  strSQL := strSQL + ' FUN_NOMMAE AS NOMMAE, ';
  strSQL := strSQL + ' FUN_LOCNAS AS LOCNAS, ';
  strSQL := strSQL + ' FUN_DTANAS AS DTANAS, ';
  strSQL := strSQL + ' FUN_ESTCIV AS ESTCIV, ';
  strSQL := strSQL + ' FUN_CERMIL AS CERMIL, ';
  strSQL := strSQL + ' FUN_CARHAB AS CARHAB, ';
  strSQL := strSQL + ' FUN_MOTDES AS MOTDES, ';
  strSQL := strSQL + ' FUN_NUMTIT AS NUMTIT, ';
  strSQL := strSQL + ' FUN_ZONTIT AS ZONELE, ';
  strSQL := strSQL + ' FUN_SECTIT AS SECELE, ';
  strSQL := strSQL + ' FUN_CATHAB AS CATHAB, ';
  strSQL := strSQL + ' FUN_VALHAB AS VALHAB, ';
  strSQL := strSQL + ' FUN_CODVEN AS CODVEN  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFUN ';

  strSQL := strSQL + ' LEFT JOIN CADEMP ON EMP_CODEMP = FUN_CODEMP ';
  strSQL := strSQL + ' LEFT JOIN CADFNC ON FNC_CODFNC = FUN_FUNATU ';

  Result := strSQL;
End;

Procedure TEditorFast.pAbreFuncionario(qryEtique: TUniQuery;
                                       strCamBus: String;
                                       blnTesteL: Boolean = False;
                                       strLisReg: String = '';
                                       intQtdEti: Integer = 0);
  Var
    strSQL: String;
Begin
  With qryEtique Do
  Begin
    Close;
    SQL.Clear;

    strSQL := fSQLFuncionario(False, intQtdEti);

    strSQL := strSQL + 'WHERE TRUE ';

    If (Not fEmptyStr(strLisReg)) Then
      strSQL := strSQL + ' AND CADFUN.AUTOINCREM IN (' + strLisReg + ') ';

    If blnTesteL Then
    Begin
      strSQL := strSQL + ' LIMIT 30 ';
    End
    Else
    Begin
      If (intQtdEti = 0) Then
        strSQL := strSQL + '  AND FUN_QTDETI > 0 ';

      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + strCamBus;
    End;

    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If (intQtdEti > 0) Then
      ParamByName('QTDETI').AsInteger := intQtdEti;

    Open;
  End;

End;

procedure TEditorFast.pAbreProducaoTinta(ftiDadosEtiq: TFormulEtiq);
begin
  pSetaVar('NOMBAS', ftiDadosEtiq.strNomBas);
  pSetaVar('DESTIN', ftiDadosEtiq.strDesTin);
  pSetaVar('COMPON', 'Componente: ' + ftiDadosEtiq.strCompon);
  pSetaVar('REDUTO', 'Redutor: ' + ftiDadosEtiq.strReduto);
  pSetaVar('CONTEU', 'Conteudo Liquido: ' + ftiDadosEtiq.strConteu);

  pSetaVar('CODIGO', ftiDadosEtiq.strCodigo);
  pSetaVar('NUMLOT', ftiDadosEtiq.strNumLot);
  pSetaVar('DTAFAB', ftiDadosEtiq.strDtaFab);
end;

procedure TEditorFast.pAbreProducaoTintaMaquinaPreview;
Begin
  pSetaVar('NOMBAS', 'Descrição da Base');
  pSetaVar('DESTIN', 'Nome da Tinta');
  pSetaVar('COMPON', 'Componente: ' + 'Qualquer');
  pSetaVar('REDUTO', 'Redutor: ' + 'Qualquer');
  pSetaVar('CONTEU', 'Conteudo Liquido: ' + '900ml');

  pSetaVar('CODIGO', '12345');
  pSetaVar('NUMLOT', '123AXB');
  pSetaVar('DTAFAB', DateToStr(fNow()));

  If Assigned(FPreviw) Then
  Begin
    If FPreviw.Active Then
    Begin
      FPreviw.EmptyDataSet;
      FPreviw.Close;
    End;
    FreeAndNil(FPreviw);
  End;

  pCriaClientProducaoTinta(FPreviw);
end;

procedure TEditorFast.pAbreProdutosControladosPreview(qryEtique: TUniQuery);
begin
  qryEtique.Close;
  qryEtique.SQL.Clear;
  qryEtique.SQL.Add(' SELECT "999"                AS CODEMP, ');
  qryEtique.SQL.Add('        "NOME DA EMPRESA"    AS NOMEMP, ');
  qryEtique.SQL.Add('        "99.999.999/0001-00" AS CGCEMP, ');
  qryEtique.SQL.Add('        "(99) 9999-9999 "    AS FONE01, ');
  qryEtique.SQL.Add('        ITE_DESITE           AS DESITE, ');
  qryEtique.SQL.Add('        "999999999999"       AS NUMCON, ');
  qryEtique.SQL.Add('        "999999999999"       AS NUMENT, ');
  qryEtique.SQL.Add('        "NOME DO FORNECEDOR" AS NOMFOR ');
  qryEtique.SQL.Add('   FROM CADITE                  ');
  qryEtique.SQL.Add('  ORDER BY ITE_DESITE           ');
  qryEtique.SQL.Add('  LIMIT 30                      ');
  qryEtique.Open;
end;

procedure TEditorFast.pAbreRastreamentoProduto(qryEtique: TUniQuery; blnTesteL,
  blnAbrirQuery: Boolean; strLimit, strLoteAutInc: String);
begin
  qryEtique.SQL.Add('SELECT CADITE.ITE_CODITE AS CODITE,                         ');
  qryEtique.SQL.Add('       CADITE.ITE_DESITE AS DESITE,                         ');
  qryEtique.SQL.Add('       CADITE.ITE_DESSIM AS DESSIM,                         ');
  qryEtique.SQL.Add('       CADITE.ITE_DESFAB AS DESFAB,                         ');
  qryEtique.SQL.Add('       CADITE.ITE_REFERE AS REFERE,                         ');
  qryEtique.SQL.Add('       CADUNI.UNI_SIGUNI AS SIGUNI,                         ');
  qryEtique.SQL.Add('       LOTRAS.AUTOINCREM AS SEQLOT,                         ');
  qryEtique.SQL.Add('       LOTRAS.LOT_NUMLOT AS NUMLOT,                         ');
  qryEtique.SQL.Add('       CADFOR.FOR_CODFOR AS CODFOR,                         ');
  qryEtique.SQL.Add('       CADFOR.FOR_NOMFOR AS NOMFOR                          ');
  qryEtique.SQL.Add('FROM                                                        ');
  qryEtique.SQL.Add('  LOTRAS                                                    ');
  qryEtique.SQL.Add('  LEFT JOIN CADITE ON CADITE.ITE_CODITE = LOTRAS.LOT_CODITE ');
  qryEtique.SQL.Add('  LEFT JOIN CADFOR ON CADFOR.FOR_CODFOR = LOTRAS.LOT_CODFOR ');
  qryEtique.SQL.Add('  LEFT JOIN CADUNI ON CADUNI.UNI_CODUNI = CADITE.ITE_CODUNI ');

  If blnTesteL Then
    qryEtique.SQL.Add('LIMIT ' + strLimit)
  Else
  Begin
    if Not fEmptyStr(strLoteAutInc) Then
      qryEtique.SQL.Add('  WHERE LOTRAS.AUTOINCREM IN (' + strLoteAutInc + ')');
  End;

  If blnAbrirQuery Then
    qryEtique.Open;
end;

procedure TEditorFast.pAbreRegiaoPreview(qryEtique: TUniQuery);
begin
  qryEtique.Close;
  qryEtique.SQL.Clear;
  qryEtique.SQL.Add(' SELECT REG_CODREG AS CODREG,   ');
  qryEtique.SQL.Add('        REG_DESREG AS DESREG,   ');
  qryEtique.SQL.Add('        REG_CODREG AS BARREG    ');
  qryEtique.SQL.Add('   FROM CADREG                  ');
  qryEtique.SQL.Add('  ORDER BY REG_CODREG           ');
  qryEtique.SQL.Add('  LIMIT 30                      ');
  qryEtique.Open;
end;

procedure TEditorFast.pAbreItensCPFPreview;
Begin
  pCriarFormularios(TfrmEtiquetasItemCPF, frmEtiquetasItemCPF);

  frmEtiquetasItemCPF.pShowPreview := pShowPreview;

  With frmEtiquetasItemCPF Do
  Begin
    If FCodEti = tpeItensCPFArgox Then
      rdgTipEti.ItemIndex := 0
    Else
      rdgTipEti.ItemIndex := 1;

    rdgTipEti.Enabled   := False;

    blnPreview := True;
    ShowModal;
  End;

  FreeAndNil(frmEtiquetasItemCPF);
End;

procedure TEditorFast.pAbreDespacho(qryEtique : TUniQuery;
                                    blnTesteL : Boolean;
                                    strNomTab,
                                    strTipoFC,
                                    strNumDoc,
                                    strEspDoc : String;
                                    blnSigep  : Boolean;
                                    strCodEmp : String;
                                    blnB2W    : Boolean;
                                    strCodCli : String;
                                    strMultPed: String);
var
  strCodEti: String;
Begin
  strCodEti := '';

  case FCodEti of
    tpeEtiquetaDespachoVolumeIndividualArgox: strCodEti := 'tpeEtiquetaDespachoVolumeIndividualArgox';
    tpeEtiquetaDespachoVolumeIndividualLaser: strCodEti := 'tpeEtiquetaDespachoVolumeIndividualLaser';
    tpeEtiquetaDespachoVolumeGeralArgox: strCodEti := 'tpeEtiquetaDespachoVolumeGeralArgox';
    tpeEtiquetaDespachoVolumeGeralLaser: strCodEti := 'tpeEtiquetaDespachoVolumeGeralLaser';
  end;

  With qryEtique Do
  Begin
    Close;

    SQL.Text := fSQLDespacho(blnTesteL, strNomTab,  strTipoFC, strNumDoc, strEspDoc, False, blnSigep, blnB2W, strCodCli, strCodEti, strMultPed);
    If Not blnTesteL Then
    Begin
      if fEmptyStr(strMultPed) then
        ParamByName('NUMDOC').AsString := strNumDoc;

      ParamByName('ESPDOC').AsString := strEspDoc;
      if not fEmptyStr(strCodCli) then
        ParamByName('CODCLI').AsString := strCodCli;
    End;
    If (fEmptyStr(strCodEmp)) Then
      ParamByName('CODEMP').AsString := VS_strCodEmp
    Else
      ParamByName('CODEMP').AsString := strCodEmp;
    Open;
  End; 
end;

procedure TEditorFast.pAbreDespachoProduto(qryEtique : TUniQuery;
                                           blnTesteL : Boolean;
                                           strNomTab,
                                           strTipoFC,
                                           strNumDoc,
                                           strEspDoc : String;
                                           strCodEmp : String);
begin
  qryEtique.Close;

  qryEtique.SQL.Text := fSQLDespachoProduto(blnTesteL, strNomTab, strTipoFC);
  If Not blnTesteL Then
  Begin
    qryEtique.ParamByName('NUMDOC').AsString := strNumDoc;
    qryEtique.ParamByName('ESPDOC').AsString := strEspDoc;
  End;
  If (fEmptyStr(strCodEmp)) Then
    qryEtique.ParamByName('CODEMP').AsString := VS_strCodEmp
  Else
    qryEtique.ParamByName('CODEMP').AsString := strCodEmp;
  qryEtique.Open;
end;

procedure TEditorFast.pAbreDiversos(qryEtique: TUniQuery; blnTesteL: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DIV_NOMDIV AS NOME, ';
  strSQL := strSQL + '  DIV_ENDERE AS ENDERE, ';
  strSQL := strSQL + '  DIV_BAIRRO AS BAIRRO, ';
  strSQL := strSQL + '  DIV_C_E_P_ AS C_E_P_, ';
  strSQL := strSQL + '  CONCAT(CID_NOMCID," /",CID_ESTADO) AS NOMCID, ';
  strSQL := strSQL + '  CID_ESTADO AS ESTCLI, ';
  strSQL := strSQL + '  DIV_QTDETI AS QTDETI, ';
  strSQL := strSQL + '  DIV_CODDIV AS CODDIV ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADDIV ';
  strSQL := strSQL + '  JOIN CADCID ON DIV_CODCID = CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRUE  ';

  If blnTesteL Then
  Begin
    strSQL := strSQL + ' LIMIT 30 ';
  End Else
  Begin
    strSQL := strSQL + '  AND DIV_QTDETI > 0 ';
  End;

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;
end;


{procedure TEditorFast.pAbreOrdPro(qryEtique: TUniQuery; blnTesteL: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DIV_NOMDIV AS NOME, ';
  strSQL := strSQL + '  DIV_ENDERE AS ENDERE, ';
  strSQL := strSQL + '  DIV_BAIRRO AS BAIRRO, ';
  strSQL := strSQL + '  DIV_C_E_P_ AS C_E_P_, ';
  strSQL := strSQL + '  CONCAT(CID_NOMCID," /",CID_ESTADO) AS NOMCID, ';
  strSQL := strSQL + '  DIV_QTDETI AS QTDETI, ';
  strSQL := strSQL + '  DIV_CODDIV AS CODDIV ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADDIV ';
  strSQL := strSQL + '  JOIN CADCID ON DIV_CODCID = CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRUE  ';

  If blnTesteL Then
  Begin
    strSQL := strSQL + ' LIMIT 30 ';
  End Else
  Begin
    strSQL := strSQL + '  AND DIV_QTDETI > 0 ';
  End;

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;
end;   }

procedure TEditorFast.pAbreEstrutura(qryEtique: TUniQuery; blnTesteL: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  C1.ITE_DESITE AS ESTRUT, ';
  strSQL := strSQL + '  D.DMT_ITESUB  AS CODSUB, ';
  strSQL := strSQL + '  C2.ITE_DESITE AS ITEM,   ';
  strSQL := strSQL + '  D.DMT_QTDITE  AS QTDITE, ';
  strSQL := strSQL + '  D.DMT_DESPCA  AS DESPCA, ';
  strSQL := strSQL + '  G.GMT_QTDETI  AS QTDETI, ';
  strSQL := strSQL + '  C2.ITE_CODBAR AS CODBAR, ';
  strSQL := strSQL + '  C1.ITE_CODBAR AS BARITE, ';
  strSQL := strSQL + '  C1.ITE_COMPOS AS COMPOS, ';
  strSQL := strSQL + '  C1.ITE_PAISOR AS PAISOR, ';
  strSQL := strSQL + '  C1.ITE_APLICA AS APLICA, ';
  strSQL := strSQL + '  C1.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '  CURRENT_DATE  AS DTAEMI, ';
  strSQL := strSQL + '  EM.EMP_C_G_C_ AS EMCNPJ, ';
  strSQL := strSQL + '  EM.EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '  IB.IBG_NOMPAI AS NOMPAI, ';
  strSQL := strSQL + '  CA.CID_NOMCID AS NOMCID  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  GERMAT G ';
  strSQL := strSQL + '  JOIN DETMAT D ON (G.AUTOINCREM = D.DMT_SEQGER) ';
  strSQL := strSQL + '  JOIN CADITE C1 ON (C1.ITE_CODITE = G.GMT_CODITE) ';
  strSQL := strSQL + '  JOIN CADITE C2 ON (C2.ITE_CODITE = D.DMT_ITESUB) ';
  strSQL := strSQL + '  JOIN CADEMP EM ON (EM.EMP_CODEMP = :CODEMP) ';
  strSQL := strSQL + '  JOIN CADCID CA ON (CA.CID_CODCID = EM.EMP_CODCID) ';
  strSQL := strSQL + '  LEFT JOIN IBG_CADPAI IB ON (IB.IBG_CODPAI = CID_CODPAI) ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRUE ';

  If blnTesteL Then
  Begin
    strSQL := strSQL + ' LIMIT 30 ';
  End Else
  Begin
    strSQL := strSQL + '  AND G.GMT_QTDETI > 0 ';
  End;

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString:= VS_strCodEmp;
    Open;
  End;
end;

procedure TEditorFast.pAbreEtiquetaDoProdutoSeparado(qryEtique: TUniQuery);
begin
    qryEtique.SQL.Add('    SELECT ');
    qryEtique.SQL.Add('        "TAB1" AS TABELA,');
    qryEtique.SQL.Add('         0 AS  CODIGO,');
    qryEtique.SQL.Add('         ITE_CODITE AS CODITE,');
    qryEtique.SQL.Add('           ITE_CODFAB AS CODFAB,');
    qryEtique.SQL.Add('           ITE_CODBAR AS CODBAR,');
    qryEtique.SQL.Add('           ITE_DESITE AS DESITE,');
    qryEtique.SQL.Add('           LOT_LOCFIS AS LOCFIS,');
    qryEtique.SQL.Add('           LOT_SALDOS AS QTDETI,');
    qryEtique.SQL.Add('           CAST("F" AS CHAR(1)) AS MOVIME,');
    qryEtique.SQL.Add('           CAST("00000000001" AS CHAR(12)) AS PEDIDO,');
    qryEtique.SQL.Add('           CAST("PEDIDO Nº 00000000001" AS CHAR(255)) AS EXPMOV,');
    qryEtique.SQL.Add('           LOT_NUMLOT AS NUMLOT');
    qryEtique.SQL.Add('     FROM CADITE');
    qryEtique.SQL.Add('     LEFT JOIN CADLOT ON LOT_CODITE = ITE_CODITE AND LOT_CODEMP = "' + VS_strCodEmp + '"');
    qryEtique.SQL.Add('     GROUP BY ITE_CODITE');
    qryEtique.SQL.Add('     LIMIT 30');
    qryEtique.Open;
end;

procedure TEditorFast.pAbreFornecedor(qryEtique: TUniQuery; blnTesteL: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FOR_NOMFOR AS NOME, ';
  strSQL := strSQL + '  FOR_ENDERE AS ENDERE, ';
  strSQL := strSQL + '  FOR_BAIRRO AS BAIRRO, ';
  strSQL := strSQL + '  FOR_ENDNUM AS ENDNUF, ';
  strSQL := strSQL + '  FOR_C_E_P_ AS C_E_P_, ';
  strSQL := strSQL + '  CONCAT(CID_NOMCID," /",CID_ESTADO) AS NOMCID, ';
  strSQL := strSQL + '  FOR_QTDETI AS QTDETI ,';
  strSQL := strSQL + '  ' + fRetSQLCGCCPFFormatado('FOR_CGCCPF', 'FOR_C_G_C_') + '  AS CGCFOR ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFOR ';
  strSQL := strSQL + '  JOIN CADCID ON FOR_CODCID = CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRUE  ';

  If blnTesteL Then
  Begin
    strSQL := strSQL + ' LIMIT 30 ';
  End Else
  Begin
    strSQL := strSQL + '  AND FOR_QTDETI > 0 ';
  End;

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;
end;

procedure TEditorFast.pAbreCaixas(qryEtique: TUniQuery; blnTesteL: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  "CXSEQ00000001" AS CODBAR, ';
  strSQL := strSQL + '  EMP_CODEMP  AS CODEMP, ';
  strSQL := strSQL + '  EMP_NOMEMP  AS NOMEMP, ';
  strSQL := strSQL + '  CONCAT(EMP_ENDERE, ", ", EMP_ENDNUM,IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))) AS ENDEMP, ';
  strSQL := strSQL + '  CONCAT(EMP_ENDERE, ", ", EMP_ENDNUM,IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))," - ",EMP_BAIRRO," - ",CID_NOMCID,"-",CID_ESTADO) AS ENEMP2, ';
  strSQL := strSQL + '  EMP_C_E_P_  AS CEPEMP, ';
  strSQL := strSQL + '  CONCAT(CID_NOMCID,"-",CID_ESTADO) AS CIDEMP, ';
  strSQL := strSQL + '  EMP_FONE01  AS FONEMP ';
  strSQL := strSQL + 'FROM CADEMP ';
  strSQL := strSQL + 'LEFT JOIN CADCID ON (CID_CODCID = EMP_CODCID) ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

  If blnTesteL Then
    strSQL := strSQL + ' LIMIT 1 ';

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;
end;

procedure TEditorFast.pAbreMontagemCaixas(qryEtique: TUniQuery; blnTesteL: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT "BAURU"                   AS NOMROT, ';
  strSQL := strSQL + '       "000001"                  AS CAIXA,  ';
  strSQL := strSQL + '       "0.000"                   AS PESO,   ';
  strSQL := strSQL + '       "00000001-CITEL SOFTWARE" AS CLIENTE,';
  strSQL := strSQL + '       "000000000001"            AS PEDIDO, ';
  strSQL := strSQL + '       "17/04"                   AS DTAROT, ';
  strSQL := strSQL + '       "TRANSP. ABC LTDA"        AS NOMTRA, ';
  strSQL := strSQL + '       "CLIENTE DE NOME TAL"     AS NOMCLI, ';
  strSQL := strSQL + '       "CLIENTE DO CLIENTE-UF"   AS NOMCID, ';
  strSQL := strSQL + '       "9,999.99"                AS TOTPES, ';
  strSQL := strSQL + '       "999999999999"            AS NUMPED, ';
  strSQL := strSQL + '       "NOME DO SEPARADOR"       AS NOMSEP, ';
  strSQL := strSQL + '       "NOME DO CONFERENTE"      AS NOMCNF, ';
  strSQL := strSQL + '       "NOME DO VENDEDOR 1"      AS NOMVD1, ';
  strSQL := strSQL + '       "NOME DO VENDEDOR 2"      AS NOMVD2, ';
  strSQL := strSQL + '       "999"                     AS NUMVOL, ';
  strSQL := strSQL + '       "123456789"               AS CODBAR, ';
  strSQL := strSQL + '       "00097489"                AS CLICOD, ';
  strSQL := strSQL + '       "2,30 KG"                 AS PESPED, ';
  strSQL := strSQL + '       CONCAT("99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99") AS LSTITE, ';
  strSQL := strSQL + '       "999"                   AS CODOPE, ';
  strSQL := strSQL + '       "NOME DO OPERADOR"      AS NOMOPE, ';
  strSQL := strSQL + '       "01/03"                 AS TCAXFE, ';
  strSQL := strSQL + '       "99999"                 AS CODROT, ';
  strSQL := strSQL + '       "99,99"                 AS ALTURA, ';
  strSQL := strSQL + '       "99,99"                 AS LARGURA, ';
  strSQL := strSQL + '       "99,99"                 AS PROFUNDIDADE, ';
  strSQL := strSQL + '       "TESTE END. ENTREGA"    AS ENDENT, ';
  strSQL := strSQL + '       "9999999999"            AS CEPENT, ';
  strSQL := strSQL + '       "TESTE CIDADE ENTREGA"  AS CIDENT, ';
  strSQL := strSQL + '       "SP"                    AS ESTENT, ';
  strSQL := strSQL + '       "TESTE BAIRRO ENTREGA"  AS BAIENT, ';
  strSQL := strSQL + '       "00001"                 AS CAI_ID  ';

  If blnTesteL Then
    strSQL := strSQL + ' LIMIT 1 ';

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;
end;

procedure TEditorFast.pAbreMontagemCaixasCodBarras(qryEtique: TUniQuery; blnTesteL: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT "BAURU"                 AS NOMROT, ';
  strSQL := strSQL + '       "17/04"                 AS DTAROT, ';
  strSQL := strSQL + '       "TRANSP. ABC LTDA"      AS NOMTRA, ';
  strSQL := strSQL + '       "CLIENTE DE NOME TAL"   AS NOMCLI, ';
  strSQL := strSQL + '       "CLIENTE DO CLIENTE-UF" AS NOMCID, ';
  strSQL := strSQL + '       "9,999.99"              AS TOTPES, ';
  strSQL := strSQL + '       "999999999999"          AS NUMPED, ';
  strSQL := strSQL + '       "NOME DO SEPARADOR"     AS NOMSEP, ';
  strSQL := strSQL + '       "NOME DO CONFERENTE"    AS NOMCNF, ';
  strSQL := strSQL + '       "NOME DO VENDEDOR 1"    AS NOMVD1, ';
  strSQL := strSQL + '       "NOME DO VENDEDOR 2"    AS NOMVD2, ';
  strSQL := strSQL + '       "999"                   AS NUMVOL, ';
  strSQL := strSQL + '       "123456789"             AS CODBAR, ';
  strSQL := strSQL + '       "00097489"              AS CLICOD, ';
  strSQL := strSQL + '       "2,30 KG"               AS PESPED, ';
  strSQL := strSQL + '       CONCAT("99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99 \r" ,' +
                     '              "99999 - XXXXXXXXXXXXXX - UU - 9,999.99") AS LSTITE, ';
  strSQL := strSQL + '       "999"                   AS CODOPE, ';
  strSQL := strSQL + '       "NOME DO OPERADOR"      AS NOMOPE, ';
  strSQL := strSQL + '       "01/03"                 AS TCAXFE, ';
  strSQL := strSQL + '       "99999"                 AS CODROT, ';
  strSQL := strSQL + '       "88888"                 AS CODREG, ';
  strSQL := strSQL + '       "DESCRICAO DA REGIAO/ROTA" AS DESREG,  ';
  strSQL := strSQL + '       "000000000123-001"      AS CAIXA,   ';
  strSQL := strSQL + '       "TESTE END. ENTREGA"    AS ENDENT, ';
  strSQL := strSQL + '       "9999999999"            AS CEPENT, ';
  strSQL := strSQL + '       "TESTE CIDADE ENTREGA"  AS CIDENT, ';
  strSQL := strSQL + '       "SP"                    AS ESTENT, ';
  strSQL := strSQL + '       "TESTE BAIRRO ENTREGA"  AS BAIENT, ';
  strSQL := strSQL + '       "00001"                 AS CAI_ID  ';

  If blnTesteL Then
    strSQL := strSQL + ' LIMIT 1 ';

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;
end;

procedure TEditorFast.pAbreMontagemCaixasPackList(qryEtique: TUniQuery; blnTesteL: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT "5"                               AS CAIXA, ';
  strSQL := strSQL + '       "571579"                          AS NUMCMP, ';
  strSQL := strSQL + '       "72227"                           AS NUMDOC, ';
  strSQL := strSQL + '       "00000001"                        AS CLICOD, ';
  strSQL := strSQL + '       "RAZÃO SOCIAL DO CLIENTE"         AS NOMCLI, ';
  strSQL := strSQL + '       "NOME DE FANTASIA DO CLIENTE"     AS FANSOB, ';
  strSQL := strSQL + '       "ENDERECO DO CLIENTE, 999, COMPL" AS ENDCLI, ';
  strSQL := strSQL + '       "BAIRRO DO CLIENTE"               AS BAICLI, ';
  strSQL := strSQL + '       "CIDADE DO CLIENTE"               AS CIDCLI, ';
  strSQL := strSQL + '       "UF"                              AS ESTCLI, ';
  strSQL := strSQL + '       "99999-999"                       AS CEPCLI, ';
  strSQL := strSQL + '       "99,9999"                         AS TOTPES, ';
  strSQL := strSQL + '       "SEPARADOR"                       AS NOMSEP, ';
  strSQL := strSQL + '       "CONFERENTE"                      AS NOMCNF, ';
  strSQL := strSQL + '       CONCAT("999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX \r" ,' +
                     '              "999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX \r" ,' +
                     '              "999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX \r" ,' +
                     '              "999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX \r" ,' +
                     '              "999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX \r" ,' +
                     '              "999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX \r" ,' +
                     '              "999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX \r" ,' +
                     '              "999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX \r" ,' +
                     '              "999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX \r" ,' +
                     '              "999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX \r" ,' +
                     '              "999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX \r" ,' +
                     '              "999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX \r" ,' +
                     '              "999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX \r" ,' +
                     '              "999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX \r" ,' +
                     '              "999 - XXXXXXXXXXXXXX  999 - XXXXXXXXXXXXXX") AS LSTFAB, ';
  strSQL := strSQL + '       "TESTE END. ENTREGA"    AS ENDENT, ';
  strSQL := strSQL + '       "9999999999"            AS CEPENT, ';
  strSQL := strSQL + '       "TESTE CIDADE ENTREGA"  AS CIDENT, ';
  strSQL := strSQL + '       "SP"                    AS ESTENT, ';
  strSQL := strSQL + '       "TESTE BAIRRO ENTREGA"  AS BAIENT, ';
  strSQL := strSQL + '       CONCAT("1.0000 - 12345 - XXXXXXXXXXXXXX \r" ,' +
                     '              "1.0000 - 12345 - XXXXXXXXXXXXXX \r" ,' +
                     '              "1.0000 - 12345 - XXXXXXXXXXXXXX \r" ,' +
                     '              "1.0000 - 12345 - XXXXXXXXXXXXXX \r" ,' +
                     '              "1.0000 - 12345 - XXXXXXXXXXXXXX \r" ,' +
                     '              "1.0000 - 12345 - XXXXXXXXXXXXXX \r" ,' +
                     '              "1.0000 - 12345 - XXXXXXXXXXXXXX \r") AS LSTDES, ';
  strSQL := strSQL + '       CONCAT("1.0000 - 12345 - XXXXXXXXXXXXXX - UN \r" ,' +
                     '              "1.0000 - 12345 - XXXXXXXXXXXXXX - UN \r" ,' +
                     '              "1.0000 - 12345 - XXXXXXXXXXXXXX - UN \r" ,' +
                     '              "1.0000 - 12345 - XXXXXXXXXXXXXX - UN \r" ,' +
                     '              "1.0000 - 12345 - XXXXXXXXXXXXXX - UN \r" ,' +
                     '              "1.0000 - 12345 - XXXXXXXXXXXXXX - UN \r" ,' +
                     '              "1.0000 - 12345 - XXXXXXXXXXXXXX - UN \r") AS LSTDUN, ';

  strSQL := strSQL + '       "NOME FANTASIA EMPRESA" AS FANEMP, ';
  strSQL := strSQL + '       "RAZÃO SOCIAL EMPRESA" AS NOMEMP, ';
  strSQL := strSQL + '       "01/03"               AS TCAXFE, ';
  strSQL := strSQL + '       CONCAT("1.0000 - UN - 12345 - XXXXXXXXXXXXXX\r" ,' +
                     '              "1.0000 - UN - 12345 - XXXXXXXXXXXXXX\r" ,' +
                     '              "1.0000 - UN - 12345 - XXXXXXXXXXXXXX\r" ,' +
                     '              "1.0000 - UN - 12345 - XXXXXXXXXXXXXX\r" ,' +
                     '              "1.0000 - UN - 12345 - XXXXXXXXXXXXXX\r" ,' +
                     '              "1.0000 - UN - 12345 - XXXXXXXXXXXXXX\r" ,' +
                     '              "1.0000 - UN - 12345 - XXXXXXXXXXXXXX\r") AS LSTQUC ';

  If blnTesteL Then
    strSQL := strSQL + ' LIMIT 1 ';

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;
end;

function TEditorFast.fDiaSemanaAlfabeto: String;
begin
  Case DayOfTheWeek(VS_Date) Of
    1 : Result := 'A'; //Domingo
    2 : Result := 'B'; //Segunda
    3 : Result := 'C'; //Terça
    4 : Result := 'D'; //Quarta
    5 : Result := 'E'; //Quinta
    6 : Result := 'F'; //Sexta
    7 : Result := 'G'; //Sabado
  End;
end;

function TEditorFast.fLoteCriptografado: String;
begin
  Result := RightStr(IntToStr(YearOf(VS_Date)),2);
  Result := Result + IntToStr(WeekOfTheYear(YearOf(VS_Date)));
  Result := Result + fDiaSemanaAlfabeto;
end;

function TEditorFast.fRetSQLAbreItens(intTabPre: Integer = 0;
                                       blnTesteL: Boolean = False;
                                       strTabela: String = '';
                                       strLisReg: String = '';
                                       intTabPra: Integer = 0;
                                       intParcel: Integer = 1;
                                       strValAcr: String = '1';
                                       strValDes: String = '1';
                                       strCodEmp: String = '';
                                       strDtaPro: String = '';
                                       blnEtiNFe: boolean = false;
                                       strTipoAlter: Integer = 0;
                                       TipoOrigemEtiquetaAbreItens: TTipoOrigemEtiquetaAbreItens = toeabiOutros;
                                       blnPrePro: boolean = True;
                                       strCodIte: String = '';
                                       strCodCnd: String = '';
                                       strCndDes: String = '';
                                       strNumPar: String = '';
                                       blnImpGrp: Boolean = False;
                                       strLisRegGrupoPreco: String = ''):String;
  function fRetCamposIBPT: string;
    var
      i: integer;
  Begin
    For i := 1 To 7 Do
    Begin
      If fCfgSis('IMPPAG', varInteger) = 1 Then
      Begin
        //Internacional
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPIT' + IntToStr(i) + ' ,';
        //Federal
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPFT' + IntToStr(i) + ' ,';
        //Estadual
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPET' + IntToStr(i) + ' ,';
        //Municipal
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPMT' + IntToStr(i) + ' ,';
      End
      Else
      Begin
        //Internacional
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQIMP, 0) /100 AS IBPIT' + IntToStr(i) + ', ';
        //Federal
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQNAC, 0) /100 AS IBPFT' + IntToStr(i) + ', ';
        //Estadual
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQEST, 0) /100 AS IBPET' + IntToStr(i) + ', ';
        //Municipal
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQMUN, 0) /100 AS IBPMT' + IntToStr(i) + ', ';
      End;
    End;
  End;

  function fJoinIBPT: string;
  Begin
    Result := Result + ' LEFT JOIN CADCID EMPEST ON EMPEST.CID_CODCID = CADEMP.EMP_CODCID ';
    If fCfgSis('IMPPAG', varInteger) = 1 Then
      Result := Result + ' LEFT JOIN ABFICM ON ABF_ESTADO = EMPEST.CID_ESTADO AND ABF_CODABF = ITEGER.ITE_CODABF '
    Else
    begin
      Result := Result + 'LEFT JOIN CADIBP UTI ON UTI.AUTOINCREM = IFNULL((SELECT AUTOINCREM FROM CADIBP FUL ';
      Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
      Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(ITEGER.ITE_EXCIPI, "") ';
      Result := Result + '                                                    AND FUL.IBP_N_C_M_ = CADITE.ITE_CLAIPI), ';

      Result := Result + '                                                IFNULL((SELECT MAX(AUTOINCREM) FROM CADIBP FUL ';
      Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
      Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(ITEGER.ITE_EXCIPI, "") ';
      Result := Result + '                                                    AND FUL.IBP_N_C_M_ = LEFT(CADITE.ITE_CLAIPI, 4)) , ';
      Result := Result + '                                                    (SELECT MAX(AUTOINCREM) FROM CADIBP FUL ';
      Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
      Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(ITEGER.ITE_EXCIPI, "") ';
      Result := Result + '                                                    AND FUL.IBP_N_C_M_ = LEFT(CADITE.ITE_CLAIPI, 2)))) ';
    End;
  End;

  function fGetSQLDecidirOrigemValorItem: string;
  begin
    result := ' IF( IFNULL(ITEBAR.BAR_PREVEN, 0) = 0, ITEGER.ITE_PREVE1, ITEBAR.BAR_PREVEN ) ';
  end;

  function fRetCategoria: string;
  begin

    Result := Result + '(SELECT ';
    Result := Result + '  CAT_DESCRI ';
    Result := Result + 'FROM ';
    Result := Result + '  FXACAT ';
    Result := Result + 'WHERE ';
    Result := Result + '(SELECT LEAST(IF(SUBSTR('+ QuotedStr(VS_strTabPrc) +', 1, 1) = "S", IFNULL(ITE_MARBR1,0), 1000), ';
    Result := Result + '              IF(SUBSTR('+ QuotedStr(VS_strTabPrc) +', 2, 1) = "S", IFNULL(ITE_MARBR2,0), 1000), ';
    Result := Result + '              IF(SUBSTR('+ QuotedStr(VS_strTabPrc) +', 3, 1) = "S", IFNULL(ITE_MARBR3,0), 1000), ';
    Result := Result + '              IF(SUBSTR('+ QuotedStr(VS_strTabPrc) +', 4, 1) = "S", IFNULL(ITE_MARBR4,0), 1000), ';
    Result := Result + '              IF(SUBSTR('+ QuotedStr(VS_strTabPrc) +', 5, 1) = "S", IFNULL(ITE_MARBR5,0), 1000), ';
    Result := Result + '              IF(SUBSTR('+ QuotedStr(VS_strTabPrc) +', 6, 1) = "S", IFNULL(ITE_MARBR6,0), 1000), ';
    Result := Result + '              IF(SUBSTR('+ QuotedStr(VS_strTabPrc) +', 7, 1) = "S", IFNULL(ITE_MARBR7,0), 1000)) ';
    Result := Result + '    FROM ';
    Result := Result + '      ITEGER ';
    Result := Result + '    WHERE ITE_CODITE = CADITE.ITE_CODITE ';
    Result := Result + '      AND ITE_CODEMP = :CODEMP) BETWEEN CAT_INICIO AND CAT_FINAL) ';

  end;

  var
    strTabPre: String;
    intIndex : Integer;

Begin
  strTabPre := IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD'));

  Result := '';
  Result := Result + 'SELECT ';
  If Not fEmptyStr(strTabela) then
    Result := Result + '  DET.AUTOINCREM AS AUTOINCREM, '
  else
    Result := Result + '  ITEGER.AUTOINCREM AS AUTOINCREM, ';

  Result := Result + '  ITEGER.ITE_CODEMP AS NOMEMP, ';
  Result := Result + '  CADITE.ITE_APLICA AS APLICA, ';
  Result := Result + '  CADITE.ITE_DESITE AS DESITE, ';
  Result := Result + '  CADITE.ITE_DESSIM AS DESSIM, ';
  Result := Result + '  CADITE.ITE_REFERE AS REFERE, ';
  Result := Result + '  CADITE.ITE_CODITE AS CODITE, ';
  Result := Result + '  CADITE.ITE_CODGRU AS CODGRU, ';
  Result := Result + '  CADITE.ITE_MENFIS AS MENFIS, ';
  Result := Result + '  CADITE.ITE_MSGLV1 AS MSGLV1, ';
  Result := Result + '  CADITE.ITE_MSGLV2 AS MSGLV2, ';

  Result := Result + '  CADUNI.UNI_SIGUNI AS SIGUNI, ';
  Result := Result + '  CADITE.ITE_QRCODE AS QRCODE, ';
  Result := Result + '  CURRENT_DATE  AS DTAEMI, ';

  Result := Result + '  F.ITE_CODITF AS CODITF, ';

  Result := Result + '  "Cod. Fornecedor(GA)"    AS FORGAR, ';
  Result := Result + '  "Nome Fornecedor(GA)"    AS NOFOGA, ';

  Result := Result + '  "Cód. Cliente"    AS CODCLI, ';
  Result := Result + '  "Nome Cliente"    AS NOMCLI, ';
  //Internamente ja faz as validações referente a qual tabela pegar;
  Result := Result + fRetCamposIBPT;

  If fEmptyStr(strTabela) Then
  Begin
    Result := Result + '  ITEETI.ETI_QTDETI AS QTDETI, ';
    Result := Result + '  "Número Doc."     AS NUMDOC, ';
    Result := Result + '  "Esp Doc."        AS ESPDOC, ';
    Result := Result + '  "Série Doc."      AS SERIE_, ';
  End
  Else If strTabela = 'PCMDET' Then
  Begin
    Result := Result + '  PCD_QTDITE - IFNULL(PCD_QTDBAI, 0) AS QTDETI, ';
    Result := Result + '  PCD_NUMPED    AS NUMDOC, ';
    Result := Result + '  PCD_ESPDOC    AS ESPDOC, ';
    Result := Result + '  "Série Doc."      AS SERIE_, ';

  End
  Else
  Begin
    Result := Result + '  DET_QTDITE AS QTDETI, ';
    Result := Result + '  DET.DET_NUMDOC    AS NUMDOC, ';
    Result := Result + '  DET.DET_ESPDOC    AS ESPDOC, ';
    Result := Result + '  DET.DET_SERIE_    AS SERIE_, ';
  End;

  if blnConsideraPrecoEmbalagem and blnPrecoVendaDifPorEmbalagem then
  begin
    Result := Result + fGetSQLDecidirOrigemValorItem + ' AS VALITE, ';
  end
  else
  begin
    If blnPrePro Then
      Result := Result + ' IFNULL(IPR_PREVEN, ' +  fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPre)) + ') AS VALITE, '
    Else
      Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPre)) + ' AS VALITE, '
  end;

  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPre)) + ' AS VALVIS, ';

  Result := Result + ' (SELECT  CND_DESCRI  ';
  Result := Result + ' FROM CADCND                                         ';
  Result := Result + ' WHERE CND_CODIGO = ' + QuotedStr(strCodCnd) + ' LIMIT 1) AS CONPAG, ';

  Result := Result + ' (SELECT  CND_TXJURO  ';
  Result := Result + ' FROM CADCND                                         ';
  Result := Result + ' WHERE CND_CODIGO = ' + QuotedStr(strCodCnd) + ' LIMIT 1) AS TAXJUR, ';


  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPre)) + ' * ( ' + QuotedStr(strCndDes) + ' / 100 ) + ' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPre)) + '  AS PREPRA,  ';

  Result := Result + 'CONCAT( "' + QuotedStr(strNumPar) + ' X " , CAST(( ' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPre)) + ' * ( ' + QuotedStr(strCndDes) + ' / 100 ) + ' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPre)) + ' ) / ' + QuotedStr(strNumPar) + ' AS DECIMAL(15,2))) AS PARPRA, ';


  If intTabPre = 2 Then
  Begin
    Result := Result + 'ITE_PREVE2 + (ITE_PREVE2 * (30/100)) AS EXEVAL, ';
  End
  Else If intTabPre = 4 Then
  Begin
    Result := Result + 'ITE_PREVE4 + (ITE_PREVE4 * (40/100)) AS EXEVAL, ';
  End
  Else
  Begin
    Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPre)) + ' AS EXEVAL, ';
  End;

  If (TipoOrigemEtiquetaAbreItens = toeabiPrecificao) then
  begin
    if (intTabPre=0) Then
    Begin
      Result := Result + '  IFNULL( ';
      Result := Result + '    (SELECT ';
      Result := Result + '      IPR_PREVEN ';
      Result := Result + '    FROM ';
      Result := Result + '      CADPRO, ';
      Result := Result + '      PROEMP, ';
      Result := Result + '      ITEPRO ';
      Result := Result + '    WHERE CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
      Result := Result + '      AND PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM ';
      Result := Result + '      AND PROEMP.PRO_CODEMP = '+ VS_strCodEmp;
      Result := Result + '      AND IPR_CODITE = ITEGER.ITE_CODITE  ';
      Result := Result + '      AND CURDATE() BETWEEN PRO_DTAINI ';
      Result := Result + '      AND PRO_DTAFIN ';
      Result := Result + '    ORDER BY PRO_DTAINI, ';
      Result := Result + '      PRO_DTAFIN ';
      Result := Result + '    LIMIT 1), ';
      Result := Result + '    0 ';
      If strTipoAlter = 0 Then
        Result := Result + '  ) * ' + strValDes + ' AS PREVIS, '
      else
        Result := Result + '  ) - ' + strValDes + ' AS PREVIS, ';
    End
    Else
    Begin
      If strTipoAlter = 0 Then
        Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPre)) +  ' * ' + IfThen(strValDes = '', '1', strValDes) + ' AS PREVIS, '
      Else
        Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPre)) +  ' - ' + IfThen(strValDes = '', '1', strValDes) + ' AS PREVIS, ';
    End;


    If (intTabPra=0) Then
    Begin
      Result := Result + '  ROUND(((IFNULL( ';
      Result := Result + '    (SELECT ';
      Result := Result + '      IPR_PREVEN ';
      Result := Result + '    FROM ';
      Result := Result + '      CADPRO, ';
      Result := Result + '      PROEMP, ';
      Result := Result + '      ITEPRO ';
      Result := Result + '    WHERE CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
      Result := Result + '      AND PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM ';
      Result := Result + '      AND PROEMP.PRO_CODEMP = '+ VS_strCodEmp;
      Result := Result + '      AND IPR_CODITE = ITEGER.ITE_CODITE  ';
      Result := Result + '      AND CURDATE() BETWEEN PRO_DTAINI ';
      Result := Result + '      AND PRO_DTAFIN ';
      Result := Result + '    ORDER BY PRO_DTAINI, ';
      Result := Result + '      PRO_DTAFIN ';
      Result := Result + '    LIMIT 1), ';
      Result := Result + '    0 ';
      Result := Result + '  ) ' + IfThen(strTipoAlter = 0, ' * ', ' - ') + strValAcr + ')/' + IfThen(intParcel = 0, '1', IntToStr(intParcel)) + '),2) AS VALPAR, ';

      Result := Result + '  IFNULL( ';
      Result := Result + '    (SELECT ';
      Result := Result + '      IPR_PREVEN ';
      Result := Result + '    FROM ';
      Result := Result + '      CADPRO, ';
      Result := Result + '      PROEMP, ';
      Result := Result + '      ITEPRO ';
      Result := Result + '    WHERE CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
      Result := Result + '      AND PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM ';
      Result := Result + '      AND PROEMP.PRO_CODEMP = '+ VS_strCodEmp;
      Result := Result + '      AND IPR_CODITE = ITEGER.ITE_CODITE  ';
      Result := Result + '      AND CURDATE() BETWEEN PRO_DTAINI ';
      Result := Result + '      AND PRO_DTAFIN ';
      Result := Result + '    ORDER BY PRO_DTAINI, ';
      Result := Result + '      PRO_DTAFIN ';
      Result := Result + '    LIMIT 1), ';
      Result := Result + '    0 ';
      Result := Result + '  ) AS TOTPRA, ';
    End
    Else
    Begin
      Result := Result + '  ROUND(((' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPra)) + IfThen(strTipoAlter = 0, ' * ', ' - ') +  IfThen(strValAcr = '', '1', strValAcr) +  ')/' + IfThen(intParcel = 0, '1', IntToStr(intParcel)) + '),2) * ' + IfThen(intParcel = 0, '1', IntToStr(intParcel)) + '  AS TOTPRA, ';
      Result := Result + '  ROUND(((' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPra)) + IfThen(strTipoAlter = 0, ' * ', ' - ') +  IfThen(strValAcr = '', '1', strValAcr) +  ')/' + IfThen(intParcel = 0, '1', IntToStr(intParcel)) + '),2) AS VALPAR, ';
    End;
  end
  else
  begin
    Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPre)) +  IfThen(strTipoAlter = 0, ' * ', ' - ') + IfThen(strValDes = '', '1', strValDes) + ' AS PREVIS, ';
    Result := Result + '  ROUND(((' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPra)) + IfThen(strTipoAlter = 0, ' * ', ' - ') +  IfThen(strValAcr = '', '1', strValAcr) +  ')/' + IfThen(intParcel = 0, '1', IntToStr(intParcel)) + '),2) * ' + IfThen(intParcel = 0, '1', IntToStr(intParcel)) + '  AS TOTPRA, ';
    Result := Result + '  ROUND(((' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , IntToStr(intTabPra)) + IfThen(strTipoAlter = 0, ' * ', ' - ') +  IfThen(strValAcr = '', '1', strValAcr) +  ')/' + IfThen(intParcel = 0, '1', IntToStr(intParcel)) + '),2) AS VALPAR, ';
  end;

  Result := Result + IntToStr(intParcel) + ' AS QTDPAR, ';

  {*************************************************************}
  {* QUANDO USA LOTE EM ARMAZEM, LOCALIZAÇÃO FISICA É DIFERENTE*}
  {**********************************************************RN*}
  If fCfgSis('CTLEST') = '2' Then
  begin
    Result := Result + '  CONCAT(IFNULL(ITEGER.ITE_LOCFIS, ""), "," ,IFNULL((SELECT GROUP_CONCAT(LOT_LOCFIS) FROM CADLOT ';
    Result := Result + '  WHERE LOT_CODITE = ITEGER.ITE_CODITE ';
    Result := Result + '    AND LOT_CODEMP = ITEGER.ITE_CODEMP ';
    Result := Result + '    AND LOT_LOCFIS <> IFNULL(ITEGER.ITE_LOCFIS, "")), ""))  AS LOCFIS, ';
  end
  Else
    Result := Result + '  ITEGER.ITE_LOCFIS AS LOCFIS, ';

  Result := Result + '  ITEGER.ITE_LOCFIS AS LOCGER, ';

  Result := Result + '  ITEGER.ITE_LOCSUP AS LOCSUP, ';
  Result := Result + '  CADITE.ITE_CODFAB AS CODFAB, ';
  Result := Result + '  CADMAR.MAR_DESMAR AS DESMAR, ';
  Result := Result + '  IFNULL(IPR_PREVEN, ' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER', IntToStr(intTabPre)) + ') AS PROMOC,';
  Result := Result + '  IFNULL(IPR_PERDES, 0) AS PERDES, ';
  Result := Result + '  IFNULL(IPR_QTDMIN, 0) AS QTDMIN, ';

  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , '1') + ' AS PREVE1, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , '2') + ' AS PREVE2, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , '3') + ' AS PREVE3, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , '4') + ' AS PREVE4, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , '5') + ' AS PREVE5, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , '6') + ' AS PREVE6, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , '7') + ' AS PREVE7, ';

  If FCodEti in [tpeItensControladosLaser,
                 tpeItensControladosArgox,
                 tpeItensZebraCodBarSPre,
                 tpeItensArgoxCodBarSPre] Then
  Begin
    Result := Result + '   EMP_NOMEMP AS EMPNOM,   ';
    Result := Result + '   EMP_NOMFAN AS FANEMP,   ';
    Result := Result + '   EMP_I_E_S_ AS IESEMP,   ';
    Result := Result + '   EMP_C_E_P_ AS CEPEMP,   ';
    Result := Result + '   EMP_ENDERE AS ENDEMP,   ';
    Result := Result + '   EMP_BAIRRO AS BAIRRO,   ';
    Result := Result + '   EMP_ENDNUM AS ENDNUM,   ';
    Result := Result + '   EMP_ENDCMP AS ENDCMP,   ';
    Result := Result + '   CADCID.CID_NOMCID AS CIDEMP, ';
    Result := Result + '   CADCID.CID_ESTADO AS ESTEMP, ';
  End
  else
  Begin
    Result := Result + '   CAST("" AS CHAR(60)) AS EMPNOM,   ';
    Result := Result + '   CAST("" AS CHAR(60)) AS FANEMP,   ';
    Result := Result + '   CAST("" AS CHAR(18)) AS IESEMP,   ';
    Result := Result + '   CAST("" AS CHAR( 9)) AS CEPEMP,   ';
    Result := Result + '   CAST("" AS CHAR(40)) AS ENDEMP,   ';
    Result := Result + '   CAST("" AS CHAR(25)) AS BAIRRO,   ';
    Result := Result + '   CAST("" AS CHAR( 5)) AS ENDNUM,   ';
    Result := Result + '   CAST("" AS CHAR(25)) AS ENDCMP,   ';
    Result := Result + '   CAST("" AS CHAR(40)) AS CIDEMP, ';
    Result := Result + '   CAST("" AS CHAR( 2)) AS ESTEMP, ';
  End;
  Result := Result + '   "00000000" AS NUMSEQ,   ';

  For intIndex := 0 To 9 Do
  Begin
    Result := Result + ' ( SELECT ITB_QTDEMB                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = ITEGER.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = ITEGER.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS QTDEM'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_DESCON                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = ITEGER.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = ITEGER.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS DESCO'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT IFNULL(ITB_TABPRE, "TODAS")        ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = ITEGER.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = ITEGER.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS TABPR'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ';
    Result := Result + '     CASE ';
    Result := Result + '       IF( IFNULL(IB'+ IntToStr(intIndex)+'.ITB_TABPRE, "") = "", '+strTabPre+', ITB_TABPRE ) ';
    Result := Result + '       WHEN "0" ';
    Result := Result + '       THEN NULL ';
    Result := Result + '       WHEN "1" ';
    Result := Result + '       THEN (IFNULL(ITEGER.ITE_PREVE1,0) * ((100- IB'+ IntToStr(intIndex)+'.ITB_DESCON) / 100)) ';
    Result := Result + '       WHEN "2" ';
    Result := Result + '       THEN (IFNULL(ITEGER.ITE_PREVE2,0) * ((100- IB'+ IntToStr(intIndex)+'.ITB_DESCON) / 100)) ';
    Result := Result + '       WHEN "3" ';
    Result := Result + '       THEN (IFNULL(ITEGER.ITE_PREVE3,0) * ((100- IB'+ IntToStr(intIndex)+'.ITB_DESCON) / 100)) ';
    Result := Result + '       WHEN "4" ';
    Result := Result + '       THEN (IFNULL(ITEGER.ITE_PREVE4,0) * ((100- IB'+ IntToStr(intIndex)+'.ITB_DESCON) / 100)) ';
    Result := Result + '       WHEN "5" ';
    Result := Result + '       THEN (IFNULL(ITEGER.ITE_PREVE5,0) * ((100- IB'+ IntToStr(intIndex)+'.ITB_DESCON) / 100)) ';
    Result := Result + '       WHEN "6" ';
    Result := Result + '       THEN (IFNULL(ITEGER.ITE_PREVE6,0) * ((100- IB'+ IntToStr(intIndex)+'.ITB_DESCON) / 100)) ';
    Result := Result + '       WHEN "7" ';
    Result := Result + '       THEN (IFNULL(ITEGER.ITE_PREVE7,0) * ((100- IB'+ IntToStr(intIndex)+'.ITB_DESCON) / 100)) ';
    Result := Result + '     END ';
    Result := Result + '   FROM ITEEMB IB'+ IntToStr(intIndex);
    Result := Result + '  WHERE ITB_CODITE = ITEGER.ITE_CODITE ';
    Result := Result + '    AND ITB_CODEMP = ITEGER.ITE_CODEMP ';
    Result := Result + '  ORDER BY ITB_QTDEMB DESC ';
    Result := Result + '  LIMIT '+ IntToStr(intIndex) +',1) AS UNITA'+ IntToStr(intIndex)+ ', ';

  End;

    Result := Result + ' @QTDEMB := ( SELECT ITB_QTDEMB                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = ITEGER.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = ITEGER.ITE_CODEMP      ';
    Result := Result + '     AND ITB_PRIROM = "S"                    ';
    Result := Result + '   ORDER BY ITB_QTDEMB LIMIT 1) AS QTDEMR, ';

    Result := Result + ' @DESCOR := ( SELECT ITB_DESCON                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = ITEGER.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = ITEGER.ITE_CODEMP      ';
    Result := Result + '     AND ITB_PRIROM = "S" LIMIT 1 ) AS DESCOR, ';


    Result := Result + '@PROMOC :=  IFNULL(IPR_PREVEN, ' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER', IntToStr(intTabPre)) + '),';
    Result := Result + '@UNITAR := ROUND(@PROMOC - (@PROMOC * @DESCOR) / 100,' + IntToStr(fCfgSis('DECUNI', varInteger)) + ') AS EMBFUN,';
    Result := Result + '@TOTAL := ROUND((@PROMOC - (@PROMOC * @DESCOR) / 100),'+ IntToStr(fCfgSis('DECUNI', varInteger)) + ') * @QTDEMB AS EMBFTO,';

    Result := Result + 'IF(@QTDEMB > 0,  CONCAT("LEVE ", ROUND(@QTDEMB) ," ", IFNULL(CADUNI.UNI_SIGUNI, "UND"), " POR R$ ", ROUND(@UNITAR, 2), " CADA, TOTAL R$ ", ROUND(@TOTAL, 2)), "") AS EXPEMB,';


  Result := Result + ' CADITE.ITE_DTAALT AS DTAALT,';
  Result := Result + ' CADITE.ITE_CODMAR AS CODMAR,';
  if fCfgSis('CTLEST') = '2' then
  begin
    Result := Result + '  (SELECT GROUP_CONCAT(LOT_NUMLOT) FROM CADLOT ';
    Result := Result + '    WHERE LOT_CODITE = ITEGER.ITE_CODITE       ';
    Result := Result + '      AND LOT_CODEMP = ITEGER.ITE_CODEMP ) AS AMZETI, ';
  end
  else
    Result := Result + ' ITEGER.ITE_AMZETI AS AMZETI,';
  Result := Result + ' CADITE.ITE_ITEATI AS ITEATI,';
  Result := Result + '  CONCAT(CADITE.ITE_CODFAB, " ", CADMAR.MAR_DESMAR) AS FABMAR,  ';
  Result := Result + '  CADEMP.EMP_C_G_C_ AS EMPCGC,  ';
  Result := Result + '"' + fLoteCriptografado + '"' + ' AS LOTECR, ';
  Result := Result + '  ITEGER.ITE_SALDOS AS SALDOS,  ';
  Result := Result + '  CADEMP.EMP_FONDA1 AS FONDA1,  ';
  Result := Result + '  CADEMP.EMP_FONDA2 AS FONDA2,  ';
  Result := Result + '  IF(IFNULL(ITEBAR.BAR_CODBAR,"") = "", CADITE.ITE_CODBAR, ITEBAR.BAR_CODBAR) AS CODBAR, ';
  Result := Result + '  IF(IFNULL(ITEBAR.BAR_EMBALA, 0) =  0, CADITE.ITE_EMBALA, ITEBAR.BAR_EMBALA) AS EMBALA, ';
  Result := Result + '  IF(IFNULL(ITEBAR.BAR_PREVEN, 0) =  0,              0.00, ITEBAR.BAR_PREVEN) AS EMBPRE,  ';
  Result := Result + '  COALESCE(ITEBAR.BAR_DESCRI, "") AS DESEMB, ';
  Result := Result + '  ITEGER.ITE_TABEMF AS TABEMF, ';
  Result := Result + '  ITEGER.ITE_DESFEC AS DESFEC, ';
  Result := Result + '  ITEGER.ITE_EMBFEC AS EMBFEC, ';
  Result := Result + '  ITEETI.ETI_OBSERV AS OBSIMP, ';


  Result := Result + '  (SELECT GROUP_CONCAT(CADSEM.SEM_CODSEM) ';
  Result := Result + '     FROM CADSEM ';
  Result := Result + '    WHERE CADSEM.SEM_CODITE = CADITE.ITE_CODITE) AS CODSEM, ';
  Result := Result + '  ITE_VALIDA AS VALIDA,';
  Result := Result + '  ITE_ITESAC AS ITESAC, ';
  Result := Result + '  ITE_COMPOS AS COMPOS, ';
  Result := Result + '  ITE_PAISOR AS PAISOR, ';
  Result := Result + '  ITE_ESTMIN AS ESTMIN, ';
  Result := Result + '  ITE_ESTMAX AS ESTMAX, ';
  Result := Result + '  CADITE.ITE_CODFOR AS CODFOR, ';
  Result := Result + '  FOR_NOMFOR AS NOMFOR, ';
  Result := Result + '  CADITE.ITE_MLTVEN AS MLTVEN, ';
  Result := Result + '  ITE_IPISAI AS IPISAI,  ';
  Result := Result + '  CADITE.ITE_ATICOM AS ATICOM, ';

  Result := Result + '  OPE_CODOPE AS OPEIMP, ';
  Result := Result + '  OPE_NOMOPE AS NOMOPE, ';

  If (fUtilizaImagemOtimizada) Then
    Result := Result + ' (SELECT FROM_BASE64(IFNULL(ITE_SPOB64, ITE_IMGB64)) FROM ITEIMG WHERE ITEIMG.ITE_CODITE = CADITE.ITE_CODITE AND ITEIMG.ITE_PRINCI = "S" ORDER BY ITEIMG.AUTOINCREM DESC LIMIT 1) AS PROIMG, '
  Else
    Result := Result + ' (SELECT FROM_BASE64(IFNULL(ITE_THUB64, ITE_IMGB64)) FROM ITEIMG WHERE ITEIMG.ITE_CODITE = CADITE.ITE_CODITE AND ITEIMG.ITE_PRINCI = "S" ORDER BY ITEIMG.AUTOINCREM DESC LIMIT 1) AS PROIMG, ';

  Result := Result + '  CADITE.ITE_PRDGRU AS PRDGRU, ';
  Result := Result + '  GRPPRD.PRD_DESGRU AS DESGRU, ';
  Result := Result + '  FOR_C_G_C_ AS CGCFOR, ';

  Result := Result + fRetCategoria + ' AS CATPRO, ';

  Result := Result + '  ITEGER.ITE_TAMLCF AS TAMLCF, ';
  Result := Result + '  ITEGER.ITE_TAMLCS AS TAMLCS, ';

  Result := Result + '  ITEGER.ITE_DTAULT AS DTAULT, ';
  If Not fEmptyStr(strTabela) And SameText(strTabela,'PCMDET') And (Not strLisReg.IsEmpty) Then
    Result := Result + ' CAST(DATE_FORMAT(PCD_DTAENT, "%d/%m/%Y") AS CHAR(10)) AS DTAENT, '
  Else If Not fEmptyStr(strTabela) And SameText(strTabela,'MOVDET') And (Not strLisReg.IsEmpty) Then
    Result := Result + ' CAST(DATE_FORMAT(DET_DTAENT, "%d/%m/%Y") AS CHAR(10)) AS DTAENT, '
  Else
    Result := Result + ' "30/12/1899" AS DTAENT, ' ;

  Result := Result + ' "999999999999" AS NUMGAR, ' ;
  Result := Result + ' "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" AS OBSER1, ' ;
  Result := Result + ' "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" AS OBSER2, ' ;
  Result := Result + ' (SELECT URL_ENDERE FROM ITEURL WHERE URL_CODITE = CADITE.ITE_CODITE AND URL_PRINCI = 1) AS URLIMG, ';
  Result := Result + '  CADPRO.PRO_DESPRO AS DESPRO, ';
  Result := Result + '  CADPRO.PRO_DTAINI AS PROINI, ';
  Result := Result + '  CADPRO.PRO_DTAFIN AS PROFIN, ';
  Result := Result + '  ITEGER.ITE_PONEXP AS PONEXP, ';
  Result := Result + ' "X" AS ITEPRO, ';

  Result := Result + '  (SELECT MOE_DOLCOM FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DOLCOM, ';
  Result := Result + '  (SELECT MOE_DOLVEN FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DOLVEN, ';
  Result := Result + '  (SELECT MOE_CODEMP FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS MOEEMP, ';
  Result := Result + '  (SELECT MOE_DTAMOE FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DTAMOE, ';
  Result := Result + '  ITEGER.ITE_PRECUS AS CUSPRE,  ';
  Result := Result + '  CADUNI.UNI_DESUNI AS DESUNI,  ';
  Result := Result + '  CADITE.ITE_NVLGIR AS NVLGIR,  ';
  Result := Result + '  CADITE.ITE_VALOBR AS VALOBR   ';

  If fEmptyStr(strTabela) Then
    Result := Result + '  ,ITEETI.ETI_SEQETI AS SEQETI '
  else
    Result := Result + '  ,0 AS SEQETI ';

  Result := Result + '  ,"" AS MINQTD   ';
  Result := Result + '  ,"" AS PREPRO   ';
  Result := Result + '  ,"" AS PROTOT   ';

  Result := Result + '  ,CADITE.ITE_DESFAB AS DESFAB  ';
  Result := Result + '  ,CADITE.ITE_GRUCMP AS GRUCMP  ';
  Result := Result + '  ,(SELECT GRU_DESCRI FROM GRU_COMPRA WHERE GRU_CODIGO = ITE_GRUCMP) AS GRUDES ';
  Result := Result + '  ,ITEGER.ITE_DESMAX AS DESMAX                                  ';
  Result := Result + '  ,ITEGER.ITE_DESMVM AS DESMVM                                  ';

  {Localizações Adicionais}
  If fCfgSis('CADLOC', varBoolean) Then
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(CADLOC.LOC_DESCRI)      ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '    INNER JOIN CADLOC ON (CADLOC.LOC_CODLOC = LOCFIS.LOC_LOCFIS AND ';
    Result := Result + '                          CADLOC.LOC_CODEMP = LOCFIS.LOC_CODEMP)    ';
    Result := Result + '  WHERE                                       ';
    Result := Result + '    LOCFIS.LOC_CODITE = CADITE.ITE_CODITE AND ';
    Result := Result + '    LOCFIS.LOC_CODEMP = :CODEMP AND      ';
    Result := Result + '    CADLOC.LOC_ATIVO_ <> "N") AS LOCADI  ';
  End
 Else
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(LOC_LOCFIS)             ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '  WHERE                                  ';
    Result := Result + '    LOC_CODITE = CADITE.ITE_CODITE AND   ';
    Result := Result + '    LOC_CODEMP = :CODEMP) AS LOCADI ';
  End;

  Result := Result + ' ,LC.LOT_LOCFIS AS LFAPRC ';
  Result := Result + ' ,CADITE.ITE_DTAEPI AS DTAEPI ';

  Result := Result + 'FROM ';
  Result := Result + '  CADITE ';
  Result := Result + '  JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
  Result := Result + '  JOIN CADMAR ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR ';
  Result := Result + '  JOIN CADUNI ON CADUNI.UNI_CODUNI = CADITE.ITE_CODUNI ';
  Result := Result + '  JOIN CADEMP ON CADEMP.EMP_CODEMP = ITEGER.ITE_CODEMP ';
  Result := Result + '  JOIN CADFOR ON CADFOR.FOR_CODFOR = CADITE.ITE_CODFOR ';

  If FCodEti in [tpeItensControladosLaser,
                 tpeItensControladosArgox,
                 tpeItensZebraCodBarSPre,
                 tpeItensArgoxCodBarSPre] Then
  Begin
    Result := Result + ' INNER JOIN CADCID ON EMP_CODCID = CID_CODCID  ';
  End;

  Result := Result + '  LEFT JOIN GRPPRD ON CADITE.ITE_PRDGRU = GRPPRD.PRD_CODGRU ';
  Result := Result + '  LEFT JOIN ITEETI ON ETI_CODITE = CADITE.ITE_CODITE AND ETI_CODOPE = ' + QuotedStr(strLoginUsuarioLogado) + ' ';
  Result := Result + '  LEFT JOIN CADOPE ON OPE_CODOPE = ' + QuotedStr(strLoginUsuarioLogado) + ' ';

  If fCfgSis('CTLEST') = '2' Then
  Begin
    Result := Result + '  LEFT JOIN CADLOT ON CADLOT.LOT_NUMLOT = ITEETI.ETI_AMZETI ';
    Result := Result + '                  AND CADLOT.LOT_CODITE = CADITE.ITE_CODITE ';
    Result := Result + '                  AND CADLOT.LOT_CODEMP = ITEGER.ITE_CODEMP ';
  End;

  Result := Result + '  LEFT JOIN ITEBAR ON CADITE.ITE_CODITE = ITEBAR.BAR_CODITE AND ';
  Result := Result + '                      CADITE.ITE_CODBAR = ITEBAR.BAR_CODBAR     ';

  If intTabPre > 1 Then
    Result := Result + '  LEFT JOIN (SELECT IF(IPR_PERDES = 0, IF(IPR_PREVE' + IntToStr(intTabPre) + ' > 0,  IPR_PREVE' + IntToStr(intTabPre) + ', IPR_PREVEN), ' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER', IntToStr(intTabPre))  + ' - (' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER', IntToStr(intTabPre)) + ' * IPR_PERDES / 100) ) AS IPR_PREVEN ,'
  Else
    Result := Result + '  LEFT JOIN (SELECT IF(IPR_PERDES = 0, IPR_PREVEN, ' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER', IntToStr(intTabPre))  +  ' - (' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER', IntToStr(intTabPre)) + ' * IPR_PERDES / 100) ) AS IPR_PREVEN ,';
  Result := Result + '    IPR_CODITE, IPR_PERDES, IPR_QTDMIN, IPR_SEQGER, PRO_DESPRO FROM CADPRO JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  Result := Result + '                                   JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  Result := Result + '                                   LEFT JOIN PROCLI ON PROCLI.PRO_SEQGER = CADPRO.AUTOINCREM '; // Só pode considerar a promoção se ela não for especifica para um cliete.
  Result := Result + '                                   JOIN ITEGER ON ITEGER.ITE_CODITE = ITEPRO.IPR_CODITE ';
  Result := Result + '                                              AND ITEGER.ITE_CODEMP = PROEMP.PRO_CODEMP ';
  Result := Result + '   WHERE PROCLI.PRO_CODCLI IS NULL AND ';
  If intTabPre > 0 Then
    Result := Result + '   SUBSTRING(CADPRO.PRO_TABPRE, ' +  intTabPre.ToString + ', 1) = "S" AND ';

  {* req.: 227739 - acrescentado LIMIT 1 para o caso da impressão de preço de tabela, qdo o item constar em mais que uma promoção, concomitante.*}
  Result := Result + '     PROEMP.PRO_CODEMP = :CODEMP AND :DTAPRO BETWEEN PRO_DTAINI AND PRO_DTAFIN ) AS TMP ON IPR_CODITE = ITEGER.ITE_CODITE ';

  Result := Result + '  LEFT JOIN DESSIT ON DESSIT.ITE_CODITE = CADITE.ITE_CODITE ';
  Result := Result + '  LEFT JOIN CADPRO ON CADPRO.AUTOINCREM = IPR_SEQGER ';

  If (strTabela = 'PCMDET') And (Not fEmptyStr(strLisReg)) Then
  Begin
    Result := Result + ' INNER JOIN ' + strTabela + ' DET ON PCD_CODITE = CADITE.ITE_CODITE AND ';
    Result := Result + '                                     DET.AUTOINCREM IN (' + strLisReg + ') ';
  End
  Else If Not fEmptyStr(strTabela) Then
  Begin
    Result := Result + ' INNER JOIN ' + strTabela + ' DET ON DET_CODITE = CADITE.ITE_CODITE AND ';
    Result := Result + '                                     DET.AUTOINCREM IN (' + strLisReg + ') ';
  End;
  //Internamente ja faz as validações referente a qual tabela pegar;
  Result := Result + fJoinIBPT;

  Result := Result + '  LEFT JOIN ITEFOR F ON F.ITE_CODITE = CADITE.ITE_CODITE AND ';
  Result := Result + '                        F.ITE_CODFOR = CADFOR.FOR_CODFOR ';

  If fCfgSis('TABPRF', varBoolean) Then
  Begin
    Result := Result + '  AND (SELECT COUNT(*) FROM TABPRE      ';
    Result := Result + '       WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0 ';
  End Else
  Begin
    Result := Result + '  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF  ';
    Result := Result + '                      WHERE FF.ITE_CODITE = CADITE.ITE_CODITE AND    ';
    Result := Result + '                            FF.ITE_CODFOR = CADFOR.FOR_CODFOR    ) ';
  End;

  Result := Result + ' LEFT JOIN CADLOT LC ON LC.AUTOINCREM = (SELECT C.AUTOINCREM                      ';
  Result := Result + '                                           FROM CADLOT C                          ';
  Result := Result + '                                          WHERE ITEGER.ITE_CODITE = C.LOT_CODITE  ';
  Result := Result + '                                            AND ITEGER.ITE_CODEMP = C.LOT_CODEMP  ';
  Result := Result + '                                            AND C.LOT_ARMPRC  = "S"               ';
  Result := Result + '                                          LIMIT 1)                                ';

  Result := Result + 'WHERE ';
  Result := Result + '  ITEGER.ITE_CODEMP = :CODEMP ';

  If blnTesteL Then
  Begin
    Result := Result + '  AND ITEGER.ITE_PREVE1 > 0 ';
    Result := Result + ' LIMIT 30 ';
  End
  Else If Not fEmptyStr(strCodIte) Then
      Result := Result + ' AND ITEGER.ITE_CODITE = "'+strCodIte+'" '
  Else If fEmptyStr(strLisRegGrupoPreco) Then
  Begin
    If fEmptyStr(strTabela) Then
      Result := Result + ' AND ITEETI.ETI_QTDETI > 0 ';
  End;

  If Not fEmptyStr(strLisRegGrupoPreco) Then
    Result := Result + ' AND  ITEGER.ITE_CODITE IN (' + strLisRegGrupoPreco + ')';


  if ((intTabPre = 0) or (intTabPra = 0))  and (TipoOrigemEtiquetaAbreItens = toeabiPrecificao) then
  begin

    Result := Result + ' AND (SELECT ';
    Result := Result + '      COUNT(IPR_PREVEN) ';
    Result := Result + '    FROM ';
    Result := Result + '      CADPRO, ';
    Result := Result + '      PROEMP, ';
    Result := Result + '      ITEPRO ';
    Result := Result + '    WHERE CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
    Result := Result + '      AND PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM ';
    Result := Result + '      AND PROEMP.PRO_CODEMP = :CODEMP';
    Result := Result + '      AND IPR_CODITE = ITEGER.ITE_CODITE ';
    Result := Result + '      AND :DTAPRO BETWEEN PRO_DTAINI AND PRO_DTAFIN ) > 0 ';

  end;

  If (Not blnPrePro) And (fEmptyStr(strLisRegGrupoPreco)) And (fEmptyStr(strTabela)) Then
    Result := Result + '  GROUP BY CADITE.ITE_CODITE ';

End;

procedure TEditorFast.pAbreItens(qryEtique: TUniQuery;
                                 intTabPre: Integer = 0;
                                 blnTesteL: Boolean = False;
                                 strTabela: String = '';
                                 strLisReg: String = '';
                                 intTabPra: Integer = 0;
                                 intParcel: Integer = 1;
                                 strValAcr: String = '1';
                                 strValDes: String = '1';
                                 strCodEmp: String = '';
                                 strDtaPro: String = '';
                                 blnEtiNFe: boolean = false;
                                 strTipoAlter: Integer = 0;
                                 TipoOrigemEtiquetaAbreItens: TTipoOrigemEtiquetaAbreItens = toeabiOutros;
                                 blnPrePro: boolean = True;
                                 strCodIte: String = '';
                                 strCodCnd: String = '';
                                 strCndDes: String = '';
                                 strNumPar: String = '';
                                 blnImpGrp: Boolean = False;
                                 strLisRegGrupoPreco: String = '');
  Var
    strSQL: String;


begin

  strSQL := fRetSQLAbreItens(intTabPre,
                             blnTesteL,
                             strTabela,
                             strLisReg,
                             intTabPra,
                             intParcel,
                             strValAcr,
                             strValDes,
                             strCodEmp,
                             strDtaPro,
                             blnEtiNFe,
                             strTipoAlter,
                             TipoOrigemEtiquetaAbreItens,
                             blnPrePro,
                             strCodIte,
                             strCodCnd,
                             strCndDes,
                             strNumPar,
                             blnImpGrp,
                             '');


   If not fEmptyStr(strLisRegGrupoPreco) Then
     StrSQL := strSQL + 'UNION ALL ' + fRetSQLAbreItens(intTabPre,
                                                        blnTesteL,
                                                        '',
                                                        '',
                                                        intTabPra,
                                                        intParcel,
                                                        strValAcr,
                                                        strValDes,
                                                        strCodEmp,
                                                        strDtaPro,
                                                        blnEtiNFe,
                                                        strTipoAlter,
                                                        TipoOrigemEtiquetaAbreItens,
                                                        blnPrePro,
                                                        strCodIte,
                                                        strCodCnd,
                                                        strCndDes,
                                                        strNumPar,
                                                        blnImpGrp,
                                                        strLisRegGrupoPreco);

  If fEmptyStr(fTiraCaracEspeciais(strDtaPro)) Then
     strDtaPro := DateToStr(fNow);

  If Not fEmptyStr(strTabela) and (blnEtiNFe) Then
  Begin
    strSQL := strSQL + ' ORDER BY AUTOINCREM DESC';
  End;

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByname('DTAPRO').AsDateTime := StrToDate(strDtaPro);
    ParamByname('CODEMP').AsString := IfThen(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);

    If not fEmptyStr(strCodIte) Then
      pOtimizaImagensProduto(strCodIte)
    Else
      pOtimizaImagensProduto(qryEtique, 'CODITE');

    Open;
  End;

  If fTemParametro('INFADI') Then
    FReport.Script.Variables['INFADI'] := fInformacaoAdicionalEtiquetaItens;
end;

procedure TEditorFast.pAbreItensOrcPed(qryEtique: TUniQuery; blnTesteL: Boolean; strNumDoc, strEspDoc, strCodEmp, strImprme, strOrder : String);
  Var
    strSQL: String;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  D.AUTOINCREM AS AUTOINCREM, ';
  strSQL := strSQL + '  E.FDO_ORDITE AS ORDITE, ';
  strSQL := strSQL + '  D.FDO_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  D.FDO_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  FO.FOR_C_G_C_ AS C_G_C_, ';

  strSQL := strSQL + '  "' + strCodEmp + '" AS CODEMP, ';
  strSQL := strSQL + '  "' + fRetNomeEmpresa(strCodEmp) + '" AS NOMEMP, ';
  strSQL := strSQL + '  D.FDO_REFERE AS REFERE, ';
  strSQL := strSQL + '  D.FDO_CODITE AS CODITE, ';
  strSQL := strSQL + '  U.UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '  U.UNI_DESUNI AS DESUNI, ';
  strSQL := strSQL + '  D.FDO_QTDITE AS QTDETI, ';
  strSQL := strSQL + '  D.FDO_QTDITE AS QTDITE, ';
  strSQL := strSQL + '  ITE_CODGRU   AS LINGRU, ';
  strSQL := strSQL + '  CONCAT(I.ITE_CODBAR, LPAD(D.FDO_QTDITE, 10, "0")) AS BARPED, ';
  strSQL := strSQL + '  "1" AS QTDIMP,          ';
  strSQL := strSQL + '  D.FDO_UNITAR AS VALITE, ';
  strSQL := strSQL + '  T.ITE_LOCFIS AS LOCFIS, ';
  strSQL := strSQL + '  M.MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '  I.ITE_APLICA AS APLICA, ';
  strSQL := strSQL + '  E.FDO_PESLIQ AS PESLIQ, ';
  strSQL := strSQL + '  E.FDO_PESBRU AS PESBRU, ';

  If fCfgSis('CLIPRO', varBoolean) And (opcEtiqueta in fRetUtilizaCliPro) Then
  Begin
    strSQL := strSQL + ' IFNULL(C2.CLI_COD_NF, I.ITE_CODFAB) AS CODFAB, ';
    strSQL := strSQL + ' IFNULL(C2.CLI_DES_NF, D.FDO_DESCRI) AS DESITE, ';
    If fCfgSis('APRBAR', varBoolean) Then
      strSQL := strSQL + ' IFNULL(C2.CLI_CODBAR, I.ITE_CODBAR) AS CODBAR, '
    Else
      strSQL := strSQL + '  I.ITE_CODBAR AS CODBAR, ';
    strSQL := strSQL + ' I.ITE_CODFAB AS FABITE, ';
    strSQL := strSQL + ' C2.CLI_COD_NF AS FABCLI,';
  End
  Else
  Begin
    strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';
    strSQL := strSQL + '  D.FDO_DESCRI AS DESITE, ';
    strSQL := strSQL + '  I.ITE_CODBAR AS CODBAR, ';
    strSQL := strSQL + '  "" AS FABITE,           ';
    strSQL := strSQL + '  "" AS FABCLI,           ';
  End;

  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    strSQL := strSQL + '  IF(IFNULL(FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) AS LOCSEP, '
  else
    strSQL := strSQL + '  LSE_DESCRI AS LOCSEP,     ';

  strSQL := strSQL + '  D.FDO_CODCLI AS CODCLI,   ';
  strSQL := strSQL + '  C.CLI_NOMCLI AS NOMCLI,   ';
  strSQL := strSQL + '  P.OPE_NOMOPE AS NOMVEN,   ';
  strSQL := strSQL + '  COALESCE(X.DEP_DESCRI, "") AS DESDEP, ';
  strSQL := strSQL + '  MD.FDO_COMPEC AS METITE, ';
  strSQL := strSQL + '  IF(IFNULL(FDO_ENTRET, "R") = "R",0, IF(IFNULL(FDO_ENTFUT, "N") = "N", 1, 2)) AS ENTRET, ';

  strSQL := strSQL + '  (SELECT GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ", ") ';
  strSQL := strSQL + '     FROM NUMCMP ';
  strSQL := strSQL + '    WHERE CMP_SEQGER = D.FDO_SEQGER ) AS NUMCMP, ';

  strSQL := strSQL + '  G.FGO_DTAENT AS DTAENT, ';

  strSQL := strSQL + '  (SELECT MOE_DOLCOM FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DOLCOM, ';
  strSQL := strSQL + '  (SELECT MOE_DOLVEN FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DOLVEN, ';
  strSQL := strSQL + '  (SELECT MOE_CODEMP FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS MOEEMP, ';
  strSQL := strSQL + '  (SELECT MOE_DTAMOE FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DTAMOE  ';

  strSQL := strSQL + ' , I.ITE_PESLIQ AS ITELIQ  ';
  strSQL := strSQL + ' , I.ITE_PESOIT AS ITEBRU  ';
  strSQL := strSQL + ' , I.ITE_MLTVEN AS MLTVEN  ';
  strSQL := strSQL + ' , E.FDO_NITCMP AS NITCMP  ';

  strSQL := strSQL + ' , (SELECT URL_ENDERE FROM ITEURL WHERE URL_CODITE = I.ITE_CODITE AND URL_PRINCI = 1) AS URLIMG ';
  strSQL := strSQL + ' , I.ITE_QRCODE AS QRCODE ';

  strSQL := strSQL + 'FROM        ';
  strSQL := strSQL + '  FATDOR D ';
  strSQL := strSQL + '  JOIN FATGOR G ON G.AUTOINCREM = D.FDO_SEQGER ';
  strSQL := strSQL + '  JOIN CADITE I ON D.FDO_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '  JOIN ITEGER T ON D.FDO_CODITE = T.ITE_CODITE AND  ';
  strSQL := strSQL + '                   D.FDO_CODEMP = T.ITE_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = D.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN CADDEP X ON X.DEP_CODIGO = I.ITE_CODDEP ';
  strSQL := strSQL + '  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';
  strSQL := strSQL + '  JOIN CADCLI C ON C.CLI_CODCLI = D.FDO_CODCLI ';
  strSQL := strSQL + '  JOIN CADOPE P ON P.OPE_CODOPE = D.FDO_CODVEN ';
  strSQL := strSQL + '  LEFT JOIN CADFOR FO ON (FO.FOR_CODFOR = D.FDO_FORITE) ';

  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
  begin
    strSQL := strSQL + ' LEFT JOIN CADLOT LT ON LT.LOT_CODITE = FDO_CODITE AND LT.LOT_CODEMP = FDO_CODEMP AND LT.LOT_NUMLOT = FDO_NUMLOT ';
    strSQL := strSQL + ' LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LT.LOT_LOCFIS AND CL1.LOC_CODEMP = LT.LOT_CODEMP ';
    strSQL := strSQL + ' LEFT JOIN CADLOC CL2 ON CL2.LOC_CODLOC = I.ITE_LOCFIS AND CL2.LOC_CODEMP = I.ITE_CODEMP ';
    strSQL := strSQL + ' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ';
    strSQL := strSQL + ' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = CL2.LOC_CODLSE ';
  end
  else
    strSQL := strSQL + ' LEFT JOIN CADLSE ON LSE_CODIGO = ITE_CODLSE ';

  strSQL := strSQL + ' LEFT JOIN ORCMAD MD ON MD.FDO_SEQGER = D.AUTOINCREM ';

  If fCfgSis('CLIPRO', varBoolean) And (opcEtiqueta in fRetUtilizaCliPro) Then
  Begin
    strSQL := strSQL + ' LEFT JOIN CLIPRO C2 ON C2.CLI_CODCLI = FDO_CODCLI ';
    strSQL := strSQL + '                    AND C2.CLI_CODITE = FDO_CODITE ';
    strSQL := strSQL + '  JOIN CADUNI U ON U.UNI_CODUNI = COALESCE(CLI_CODUNI, D.FDO_UNIDAD) ';
  End
  Else
    strSQL := strSQL + '  JOIN CADUNI U ON U.UNI_CODUNI = D.FDO_UNIDAD ';


  strSQL := strSQL + 'WHERE       ';
  strSQL := strSQL + '  D.FDO_CODEMP = :CODEMP AND ';

  If Not blnTesteL Then
  Begin
    strSQL := strSQL + '  D.FDO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  D.FDO_ESPDOC = :ESPDOC AND ';
  End;

  If Not fEmptyStr(strIMPRME) Then
  Begin
    strSQL := strSQL + '  D.AUTOINCREM IN (' + strImprme + ') AND ';
  End;

  strSQL := strSQL + '  D.FDO_IDEPRO = "NOR"  ';
  strSQL := strSQL + 'ORDER BY       ';
  If fEmptyStr(strOrder) Then
    strSQL := strSQL + '  D.FDO_DESCRI '
  Else
    strSQL := strSQL + strOrder;

  If blnTesteL Then
    strSQL := strSQL + ' LIMIT 30 ';

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    If Not blnTesteL Then
    Begin
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
    End;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
  End;
end;

procedure TEditorFast.pAbreOperador(qryEtique: TUniQuery; blnTesteL: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  OPE_CODOPE AS CODOPE, ';
  strSQL := strSQL + '  OPE_NOMOPE AS NOME,   ';
  strSQL := strSQL + '  OPE_ENDERE AS ENDERE, ';
  strSQL := strSQL + '  OPE_BAIRRO AS BAIRRO, ';
  strSQL := strSQL + '  CID_NOMCID AS NOMCID, ';
  strSQL := strSQL + '  OPE_CODDEP AS CODDEP, ';
  strSQL := strSQL + '  DEP_DESCRI AS NOMDEP, ';
  strSQL := strSQL + '  OPE_C_E_P_ AS C_E_P_, ';
  strSQL := strSQL + '  OPE_QTDETI AS QTDETI, ';
  strSQL := strSQL + '  OPE_CODBAR AS CODBAR  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADOPE ';
  strSQL := strSQL + '  JOIN CADCID ON OPE_CODCID = CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADDEP ON OPE_CODDEP = DEP_CODIGO ';
  strSQL := strSQL + 'WHERE TRUE ';

  If blnTesteL Then
  Begin
    strSQL := strSQL + ' LIMIT 30 ';
  End Else
  Begin
    strSQL := strSQL + '  AND OPE_QTDETI > 0 ';
  End;

  With qryEtique Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;
end;

procedure TEditorFast.pAbreEntregaTintaMaquina(qryEtique: TUniQuery;
                                               strAutInc,
                                               strNumDoc,
                                               strEspDoc: String;
                                               tptTipTin: TTipoTinta;
                                               prmDllEtq: TParamDllEtiquetas;
                                               blnTesteL: Boolean = False);
Begin
  With qryEtique, SQL Do
  Begin
    Close;
    Clear;
    Add('SET @NROETI = 0; ');
    If (fCfgSis('EXIDOC') = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
    Begin
      Add('SELECT ');
      Add('  (@NROETI:=(@NROETI + 1.0000)) AS NROETI, ');
      Add('  FORTIN.*, ');
      Add('  D.DET_CODEMP, ');
      Add('  E.EMP_NOMEMP, ');
      Add('  E.EMP_NOMFAN, ');
      Add('  D.DET_NUMDOC, ');
      Add('  D.DET_ESPDOC, ');
      Add('  E.EMP_FONE01, ');
      Add('  E.EMP_FONE02, ');

      Add('  CONCAT(D.DET_CODVEN,"-",O.OPE_NOMOPE) AS VENDED,');
      Add('  SUBSTR(D.DET_DESCRI FROM 1 FOR 40) AS DESCO1,');
      Add('  SUBSTR(D.DET_DESCRI FROM 41 FOR LENGTH(D.DET_DESCRI)) AS DESCO2,');
      Add('  CONCAT(D.DET_NUMDOC, "-", D.DET_ESPDOC, "-", D.DET_CODEMP) AS DOCUME,');
      Add('  DATE_FORMAT(CURRENT_DATE, "%d/%m/%Y") AS DTEMIS,');
      Add('  "2 anos" AS DTVALI,');

      If (tptTipTin in [ttImobiliaria, ttIndustrial]) Then
      begin
        Add(' "" AS DET_QTDEMB, ');
        Add(' UN.UNI_SIGUNI AS DET_TIPEMB, ');
      end
      else
      begin
        Add(' D.DET_QTDEMB, ');
        Add(' D.DET_TIPEMB, ');
      end;

      Add('  D.DET_DTAENT, ');
      Add('  D.DET_HORENT, ');
      Add('  D.DET_A_N_O_, ');
      Add('  D.DET_REFERE, ');
      Add('  CONCAT(D.DET_CODVEN,"-",O.OPE_NOMOPE) AS DET_CODVEN, ');

      Add('  O.OPE_FONE01 AS OPE_FONE01, ');

      Add('  D.DET_DESCRI, ');
      Add('  IF(G.GER_NOMCON IS NULL OR G.GER_NOMCON = "", ');
      Add('    C.CLI_NOMCLI, ');
      Add('    G.GER_NOMCON) AS CLI_NOMCLI, ');

      Add('  IF(G.GER_NOMCON IS NULL OR G.GER_NOMCON = "", ');
      Add('    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", C.CLI_ENDERE,  ETC_ENDENT), ');
      Add('    G.GER_ENDCON) AS CLI_ENDENT, ');

      Add('  IF(G.GER_NOMCON IS NULL OR G.GER_NOMCON = "", ');
      Add('    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", C.CLI_BAIRRO, ETC_BAIENT), ');
      Add('    G.GER_BAICON) AS CLI_BAIENT, ');

      Add('  IF(G.GER_NOMCON IS NULL OR G.GER_NOMCON = "", ');
      Add('    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_NOMCID, CE.CID_NOMCID), ');
      Add('    CC.CID_NOMCID) AS CLI_NOMCID, ');

      Add('  IF(G.GER_NOMCON IS NULL OR G.GER_NOMCON = "", ');
      Add('    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_ESTADO, CE.CID_ESTADO), ');
      Add('    CC.CID_ESTADO) AS CLI_ESTENT, ');

      Add('  D.DET_DTAENT,                                                                              ');
      Add('  DATE_ADD(D.DET_DTAENT, INTERVAL ' + fCfgSis('VALTIN') + ' MONTH) AS DET_DTAVAL,            ');

      Add('  D.DET_MONTAD, ');
      Add('  D.DET_LINTIN, ');
      Add('  D.DET_A_N_O_, ');

      If tptTipTin = ttAutomotiva Then
      Begin
        Add('  D.DET_MONTAD AS MONAUT, ');
        Add('  D.DET_A_N_O_ AS ANOAUT, ');
        Add('  D.DET_LINTIN AS LINTIN, ');

        If fRetIdeProDoc(strAutInc, strEspDoc) = 'WCP' Then
        Begin
          Add('  WCP.WAN_NOMLIN AS LIDETI, ');
        End
        Else
        Begin
          Add('  "" AS LIDETI ,');
        End;
      End
      Else
      Begin
        Add('  "" AS MONAUT, ');
        Add('  "" AS ANOAUT, ');
        Add('  "" AS LINTIN, ');
        Add('  "" AS LIDETI, ');
      End;

      Add('  D.DET_IDEPRO, ');


      If (tptTipTin in [ttIndustrial, ttImobiliaria])Then
       Add('  "" AS DET_VOLPRO, ')
      else
        Add('  IF(D.DET_VOLPRO > 0, D.DET_VOLPRO, IF(D.DET_TIPEMB = "LT", 0.900, 3.600)) AS DET_VOLPRO, ');

      Add('  A.ACA_CODBAR, ');

      {******************************************************}
      {* CAMPOS QUE SERÃO UTILIZADOS NA IMPRESSÃO MATRICIAL *}
      {* UTILIZANDO CNFETI, POR ISSO NÃO PODE TER "DET_"    *}
      {***************************************************AL*}
      Add('  D.DET_DTAENT AS DTAENT,');
      Add('  D.DET_MONTAD AS MONTAD,');
      Add('  D.DET_A_N_O_ AS ANOTIN,');
      Add('  D.DET_QTDITE AS QTDITE,');
      Add('  D.DET_DESCRI AS DESCRI,');
      Add('  O.OPE_NOMOPE AS NOMOPE,');
      Add('  :COLORISTA   AS COLORI,');

      Add('  IF(D.DET_TIPPRE = "D", "DILUIDO", "CONCENTRADO") AS DET_TIPPRE,  ');
      Add('  M.DET_PRVTIN AS PREVEN, ');
      Add('  IF(D.DET_TIPFOR = "0", "FÓRMULA ORIGINAL", "FÓRMULA AJUSTADA") AS DET_TIPFOR,   ');
      Add('  D.DET_CODCLI,           ');
      Add('  "" AS COMPLE, ');
      Add('  D.DET_CATALI AS CATALI,  ');
      Add('  D.DET_OBSCOL AS OBSCOL,  ');
      Add('  CADITE.ITE_PESOIT AS PESOIT, ');
      Add('  T.DET_NUMCMP AS NUMCMP,      ');
      Add('  T.DET_NITCMP AS NITCMP,      ');

      Add(' (SELECT DISTINCT E.FDO_ENTRET                        ');
      Add('    FROM FATDOR F                                     ');
      Add('    LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = F.AUTOINCREM ');
      Add('   WHERE F.FDO_CODEMP = M.DET_EMP_PD                  ');
      Add('     AND F.FDO_ESPDOC = M.DET_ESP_PD                  ');
      Add('     AND F.FDO_NUMDOC = M.DET_NUM_PD                  ');
      Add('     AND F.FDO_SEQIND = M.DET_IND_PD                  ');
      Add('     AND F.FDO_CODITE = M.DET_CODITE) AS ENTRET       ');

      Add('FROM ');

      Add('  TINDET D JOIN TINGER G ON G.AUTOINCREM = D.DET_SEQGER                                    ');
      Add('  JOIN CADITE ON CADITE.ITE_CODITE = D.DET_CODITE                                          ');
      Add('LEFT JOIN MOVDET M ON M.DET_CODACA = D.DET_CODACA AND                                      ');
      Add('                      M.DET_EMPACA = D.DET_EMPACA AND                                      ');
      Add('                      M.DET_ESPDOC = D.DET_ESPDOC                                          ');

      Add('LEFT JOIN MOVTRI T ON T.DET_SEQGER = M.AUTOINCREM                                          ');

      Add('LEFT JOIN AUXMOV ON M.DET_SEQGER = AUX_SEQGER                                             ');
      Add('LEFT JOIN ENTCLI ON ETC_CODCLI = D.DET_CODCLI AND                                         ');
      Add('       IF(AUX_ENTGER <> NULL, ENTCLI.AUTOINCREM = AUX_ENTGER,                             ');
      Add('       ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = D.DET_CODCLI)) ');

      Add('LEFT JOIN CADEMP E  ON E.EMP_CODEMP = D.DET_CODEMP                                                ');
      Add('LEFT JOIN CADCLI C  ON C.CLI_CODCLI = D.DET_CODCLI                                                ');
      Add('LEFT JOIN CADOPE O  ON O.OPE_CODOPE = D.DET_CODVEN                                                ');
      Add('LEFT JOIN CADCID CF ON CF.CID_CODCID = C.CLI_CODCID                                               ');
      Add('LEFT JOIN CADCID CE ON CE.CID_CODCID = ETC_CIDENT                                                 ');
      Add('LEFT JOIN CADCID CC ON CC.CID_CODCID = G.GER_CIDCON                                               ');
      Add('LEFT JOIN FORTIN ON D.DET_CODACA = FORTIN.FOR_CODACA AND FORTIN.FOR_EMPACA = D.DET_CODEMP         ');
      Add('LEFT JOIN CADACA A  ON A.ACA_CODACA  = D.DET_CODACA                                               ');
      Add('                   AND A.ACA_CODEMP  = D.DET_EMPACA                                               ');
      Add('LEFT JOIN CADUNI UN ON UN.UNI_CODUNI =  D.DET_UNIDAD                                              ');

      If fRetIdeProDoc(strAutInc, strEspDoc) = 'WCP' Then
        Add(' LEFT JOIN WANPRO_CADLIN WCP ON WCP.WAN_CODLIN = D.DET_LINTIN                                   ');

      Add('WHERE                                                                                             ');
      Add('  D.AUTOINCREM = :AUTINC                                                                          ');
    End
    Else
    Begin
      Add('SELECT ');
      Add('  (@NROETI:=(@NROETI + 1.0000)) AS NROETI, ');
      Add('  FORTIN.*, ');
      Add('  D.FDO_CODEMP, ');
      Add('  D.FDO_NUMDOC, ');
      Add('  D.FDO_ESPDOC, ');
      Add('  E.EMP_NOMEMP, ');
      Add('  E.EMP_NOMFAN, ');
      Add('  E.EMP_FONE01, ');
      Add('  E.EMP_FONE02, ');

      Add('  CONCAT(D.FDO_CODVEN,"-",O.OPE_NOMOPE) AS VENDED,');
      Add('  SUBSTR(D.FDO_DESCRI FROM 1 FOR 40) AS DESCO1,');
      Add('  SUBSTR(D.FDO_DESCRI FROM 41 FOR LENGTH(D.FDO_DESCRI)) AS DESCO2,');
      Add('  CONCAT(D.FDO_NUMDOC, "-", D.FDO_ESPDOC, "-", D.FDO_CODEMP) AS DOCUME,');
      Add('  DATE_FORMAT(CURRENT_DATE, "%d/%m/%Y") AS DTEMIS,');
      Add('  "2 anos" AS DTVALI,');

      If (tptTipTin in [ttIndustrial, ttImobiliaria])Then
      begin
        Add('  "" AS FDO_QTDEMB, ');
        Add('  UN.UNI_SIGUNI AS FDO_TIPEMB, ')
      end
      else
      begin
        Add('  D.FDO_QTDEMB, ');
        Add('  D.FDO_TIPEMB, ');
      end;

      Add('  D.FDO_DTAENT, ');
      Add('  D.FDO_HORENT, ');
      Add('  D.FDO_A_N_O_, ');
      Add('  D.FDO_REFERE, ');
      Add('  CONCAT(D.FDO_CODVEN,"-",O.OPE_NOMOPE) AS FDO_CODVEN, ');

      Add('  O.OPE_FONE01 AS OPE_FONE01, ');

      Add('  D.FDO_DESCRI, ');
      Add('  IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "", ');
      Add('    C.CLI_NOMCLI, ');
      Add('    G.FGO_NOMCON) AS CLI_NOMCLI, ');

      Add('  IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "", ');
      Add('    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", C.CLI_ENDERE,  ETC_ENDENT), ');
      Add('    G.FGO_ENDCON) AS CLI_ENDENT, ');

      Add('  IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "", ');
      Add('    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", C.CLI_BAIRRO, ETC_BAIENT), ');
      Add('    G.FGO_BAICON) AS CLI_BAIENT, ');

      Add('  IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "", ');
      Add('    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_NOMCID, CE.CID_NOMCID), ');
      Add('    CC.CID_NOMCID) AS CLI_NOMCID, ');

      Add('  IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "", ');
      Add('    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_ESTADO, CE.CID_ESTADO), ');
      Add('    CC.CID_ESTADO) AS CLI_ESTENT, ');

      Add('  D.FDO_DTAENT,                                                                              ');
      Add('  DATE_ADD(D.FDO_DTAENT, INTERVAL ' + fCfgSis('VALTIN') + ' MONTH) AS FDO_DTAVAL,            ');

      Add('  D.FDO_MONTAD, ');
      Add('  D.FDO_LINLIN, ');
      Add('  D.FDO_A_N_O_, ');

      If tptTipTin = ttAutomotiva Then
      Begin
        Add('  D.FDO_MONTAD AS MONAUT, ');
        Add('  D.FDO_A_N_O_ AS ANOAUT, ');
        Add('  ""           AS LINTIN, ');

        If fRetIdeProDoc(strAutInc, strEspDoc) = 'WCP' Then
        Begin
          Add('  WCP.WAN_NOMLIN AS LIDETI, ');
        End
        Else
        Begin
          Add('  "" AS LIDETI ,');
        End;

      End
      Else
      Begin
        Add('  "" AS MONAUT, ');
        Add('  "" AS ANOAUT, ');
        Add('  "" AS LINTIN, ');
        Add('  "" AS LIDETI, ');
      End;

      Add('  D.FDO_IDEPRO, ');


      If (tptTipTin in [ttIndustrial, ttImobiliaria])Then
        Add(' "" AS FDO_VOLPRO, ')
      else
         Add('  IF(F.FDO_VOLPRO > 0, F.FDO_VOLPRO, IF(D.FDO_TIPEMB = "LT", 0.900, 3.600)) AS FDO_VOLPRO, ');

      Add('  A.ACA_CODBAR, ');

      {******************************************************}
      {* CAMPOS QUE SERÃO UTILIZADOS NA IMPRESSÃO MATRICIAL *}
      {* UTILIZANDO CNFETI, POR ISSO NÃO PODE TER "FDO_"    *}
      {***************************************************AL*}
      Add('  D.FDO_DTAENT AS DTAENT,');
      Add('  D.FDO_MONTAD AS MONTAD,');
      Add('  D.FDO_QTDITE AS QTDITE,');
      Add('  D.FDO_DESCRI AS DESCRI,');
      Add('  O.OPE_NOMOPE AS NOMOPE,');
      Add('  :COLORISTA   AS COLORI,');

      Add('  IF(D.FDO_TIPPRE = "D", "DILUIDO", "CONCENTRADO") AS FDO_TIPPRE,  ');
      Add('  F.FDO_PRVTIN AS PREVEN,  ');
      Add('  IF(D.FDO_TIPFOR = "0", "FÓRMULA ORIGINAL", "FÓRMULA AJUSTADA") AS FDO_TIPFOR,    ');
      Add('  D.FDO_CODCLI,            ');
      Add('  F.FDO_COMPLE AS COMPLE,  ');
      Add('  D.FDO_CATALI AS CATALI,  ');
      Add('  D.FDO_OBSCOL AS OBSCOL,  ');
      Add('  CADITE.ITE_PESOIT AS PESOIT, ');
      Add('  EX.FDO_NUMCMP AS NUMCMP,     ');
      Add('  EX.FDO_NITCMP AS NITCMP,     ');
      Add('  EX.FDO_ENTRET AS ENTRET      ');
      Add('FROM ');

      Add('  TINDOR D JOIN TINGOR G ON G.AUTOINCREM = D.FDO_SEQGER                                    ');
      Add('  JOIN CADITE ON CADITE.ITE_CODITE = D.FDO_CODITE                                          ');

      Add('LEFT JOIN FATDOR F ON F.FDO_CODACA = D.FDO_CODACA AND ');
      Add('                      F.FDO_EMPACA = D.FDO_EMPACA AND ');
      Add('                      F.FDO_ESPDOC = D.FDO_ESPDOC     ');

      Add('LEFT JOIN EXTDOR EX ON EX.FDO_SEQFDO = F.AUTOINCREM   ');

      Add('LEFT JOIN CADEMP E  ON E.EMP_CODEMP = D.FDO_CODEMP                                                ');
      Add('LEFT JOIN CADCLI C  ON C.CLI_CODCLI = D.FDO_CODCLI                                                ');
      Add('LEFT JOIN CADOPE O  ON O.OPE_CODOPE = D.FDO_CODVEN                                                ');
      Add('LEFT JOIN CADCID CF ON CF.CID_CODCID = C.CLI_CODCID                                               ');

      Add('LEFT JOIN AUXGOR ON F.FDO_SEQGER = AUX_SEQGER                                             ');
      Add('LEFT JOIN ENTCLI ON ETC_CODCLI = D.FDO_CODCLI AND                                         ');
      Add('       IF(AUX_ENTGER <> NULL, ENTCLI.AUTOINCREM = AUX_ENTGER,                             ');
      Add('       ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = D.FDO_CODCLI)) ');

      Add('LEFT JOIN CADCID CE ON CE.CID_CODCID = ETC_CIDENT                                                 ');
      Add('LEFT JOIN CADCID CC ON CC.CID_CODCID = G.FGO_CIDCON                                               ');
      Add('LEFT JOIN FORTIN ON D.FDO_CODACA = FORTIN.FOR_CODACA AND FORTIN.FOR_EMPACA = D.FDO_CODEMP         ');
      Add('LEFT JOIN CADACA A ON A.ACA_CODACA = D.FDO_CODACA                                                 ');
      Add('                  AND A.ACA_CODEMP = D.FDO_EMPACA                                                 ');
      Add('LEFT JOIN CADUNI UN ON UN.UNI_CODUNI =  D.FDO_UNIDAD                                              ');

      If fRetIdeProDoc(strAutInc, strEspDoc) = 'WCP' Then
        Add('LEFT JOIN WANPRO_CADLIN WCP ON WCP.WAN_CODLIN =  D.FDO_LINLIN                                   ');



      Add('WHERE                                                                                        ');
      Add('  D.AUTOINCREM = :AUTINC                                                                     ');
    End;

    ParamByName('AUTINC').AsString := strAutInc;
    ParamByName('COLORISTA').AsString := fRetNomeOperador(strLoginUsuarioLogado);
    Open;

    If (fCfgSis('EXIDOC') = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
    Begin
      pSetaVar('NOMEMP', fRetNomeEmpresa(FieldByName('DET_CODEMP').AsString));
      pSetaVar('NOMFAN', fRetFantasiaEmpresa(FieldByName('DET_CODEMP').AsString));
      pSetaVar('NUMDOC', 'Doc.: ' + strNumDoc + '-' + strEspDoc + '-' + VS_strCodEmp);
      pSetaVar('NOMVEN', 'Vendedor: ' + FieldByName('DET_CODVEN').AsString);
      pSetaVar('NOMVE2', FieldByName('DET_CODVEN').AsString);
      pSetaVar('DESTIN', FieldByName('DET_IDEPRO').AsString + '-' +FieldByName('DET_DESCRI').AsString);
      pSetaVar('QTDEMB', FieldByName('DET_QTDEMB').AsString);
      pSetaVar('TIPEMB', FieldByName('DET_TIPEMB').AsString);
      pSetaVar('LINTIN', FieldByName('DET_LINTIN').AsString);
      pSetaVar('LIDETI', FieldByName('LIDETI').AsString);
      pSetaVar('PREVEN', FloatToStrF(FieldByName('PREVEN').AsFloat, ffFixed, 12, 3));
      pSetaVar('TIPFOR', FieldByName('DET_TIPFOR').AsString);
      if fCfgSis('SENENT', varBoolean) then
        pSetaVar('CODOPE', prmDllEtq.strOperador)
      else
        pSetaVar('CODOPE', strLoginUsuarioLogado);
      pSetaVar('COMPLE', FieldByName('COMPLE').AsString);
      pSetaVar('IDEPRO', FieldByName('DET_IDEPRO').AsString);
      pSetaVar('PESOIT', FieldByName('PESOIT').AsString);
      pSetaVar('CODEMP', FieldByName('DET_CODEMP').AsString);
    End
    Else
    Begin
      pSetaVar('NOMEMP', fRetNomeEmpresa(FieldByName('FDO_CODEMP').AsString));
      pSetaVar('NOMFAN', fRetFantasiaEmpresa(FieldByName('FDO_CODEMP').AsString));
      pSetaVar('NUMDOC', 'Doc.: ' + strNumDoc + '-' + strEspDoc + '-' + VS_strCodEmp);
      pSetaVar('NOMVEN', 'Vendedor: ' + FieldByName('FDO_CODVEN').AsString);
      pSetaVar('NOMVE2', FieldByName('FDO_CODVEN').AsString);
      pSetaVar('DESTIN', FieldByName('FDO_IDEPRO').AsString + '-' + FieldByName('FDO_DESCRI').AsString);
      pSetaVar('QTDEMB', FieldByName('FDO_QTDEMB').AsString);
      pSetaVar('TIPEMB', FieldByName('FDO_TIPEMB').AsString);
      pSetaVar('LINTIN', FieldByName('FDO_LINLIN').AsString);
      pSetaVar('LIDETI', FieldByName('LIDETI').AsString);
      pSetaVar('PREVEN', FloatToStrF(FieldByName('PREVEN').AsFloat, ffFixed, 12, 2));
      pSetaVar('TIPFOR', FieldByName('FDO_TIPFOR').AsString);
      if fCfgSis('SENENT', varBoolean) then
        pSetaVar('CODOPE', prmDllEtq.strOperador)
      else
        pSetaVar('CODOPE', strLoginUsuarioLogado);
      pSetaVar('COMPLE', FieldByName('COMPLE').AsString);
      pSetaVar('IDEPRO', FieldByName('FDO_IDEPRO').AsString);
      pSetaVar('PESOIT', FieldByName('PESOIT').AsString);
      pSetaVar('CODEMP', FieldByName('FDO_CODEMP').AsString);
    End;

    pSetaVar('CATALI', FieldByName('CATALI').AsString);
    pSetaVar('CODBAR', FieldByName('ACA_CODBAR').AsString);
    pSetaVar('MONAUT', IfThen(fEmptyStr(FieldByName('MONAUT').AsString), '', '- ' + FieldByName('MONAUT').AsString));
    pSetaVar('NOMAUT', IfThen(fEmptyStr(FieldByName('MONAUT').AsString), '', '- ' + FieldByName('MONAUT').AsString));
    pSetaVar('ANOAUT', FieldByName('ANOAUT').AsString);

    pSetaVar('NOMCLI', FieldByName('CLI_NOMCLI').AsString);
    pSetaVar('ENDENT', FieldByName('CLI_ENDENT').AsString);

    pSetaVar('CIDENT', FieldByName('CLI_BAIENT').AsString + '-' +
                       FieldByName('CLI_NOMCID').AsString + '-' +
                       FieldByName('CLI_ESTENT').AsString);

    If (fCfgSis('EXIDOC') = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
    Begin
      pSetaVar('DTAEMI', 'Emissão: ' + FieldByName('DET_DTAENT').AsString);
      pSetaVar('DTAVAL', 'Validade: ' + FieldByName('DET_DTAVAL').AsString);
      pSetaVar('HOREMI', FieldByName('DET_HORENT').AsString);
      pSetaVar('TIPEMB', FieldByName('DET_TIPEMB').AsString);
      pSetaVar('CODCLI', FieldByName('DET_CODCLI').AsString);

      pSetaVar('MONTAD', FieldByName('DET_MONTAD').AsString);
      pSetaVar('ANOTIN', FieldByName('DET_A_N_O_').AsString);

      If (tptTipTin in [ttIndustrial, ttImobiliaria])Then
        pSetaVar('VOLUME', '')
      else
        pSetaVar('VOLUME', FloatToStrF(FieldByName('DET_VOLPRO').AsFloat, ffFixed, 12, 3));

    End
    Else
    Begin
      pSetaVar('DTAEMI', 'Emissão: ' + FieldByName('FDO_DTAENT').AsString);
      pSetaVar('DTAVAL', 'Validade: ' + FieldByName('FDO_DTAVAL').AsString);
      pSetaVar('HOREMI', FieldByName('FDO_HORENT').AsString);
      pSetaVar('TIPEMB', FieldByName('FDO_TIPEMB').AsString);
      pSetaVar('CODCLI', FieldByName('FDO_CODCLI').AsString);

      pSetaVar('MONTAD', FieldByName('FDO_MONTAD').AsString);
      pSetaVar('ANOTIN', FieldByName('FDO_A_N_O_').AsString);

      If (tptTipTin in [ttIndustrial, ttImobiliaria])Then
        pSetaVar('VOLUME', '')
      else
        pSetaVar('VOLUME', FloatToStrF(FieldByName('FDO_VOLPRO').AsFloat, ffFixed, 12, 3));
    End;

    pSetaVar('FO1OPE', FieldByName('OPE_FONE01').AsString);
    pSetaVar('F01EMP', FieldByName('EMP_FONE01').AsString);
    pSetaVar('F02EMP', FieldByName('EMP_FONE02').AsString);

    pSetaVar('VENDED', FieldByName('VENDED').AsString);
    pSetaVar('DESCO1', FieldByName('DESCO1').AsString);
    pSetaVar('DESCO2', FieldByName('DESCO2').AsString);
    pSetaVar('DOCUME', FieldByName('DOCUME').AsString);
    pSetaVar('DTEMIS', FieldByName('DTEMIS').AsString);
    pSetaVar('DTVALI', FieldByName('DTVALI').AsString);

    pSetaVar('OBSCOL', FieldByName('OBSCOL').AsString);

    pSetaVar('NUMCMP', FieldByName('NUMCMP').AsString);
    pSetaVar('NITCMP', FieldByName('NITCMP').AsString);
    pSetaVar('ENTRET', FieldByName('ENTRET').AsString);
    pSetaVar('NROETI', FieldByName('NROETI').AsString);
    pSetaVar('QTDETI', FieldByName('QTDITE').AsString);
    pSetaVar('COLORI', fRetNomeOperador(strLoginUsuarioLogado));

  End;
End;

Procedure TEditorFast.pAbreFormulacaoTintaPreview;
Begin
  pSetaVar('NOMEMP', fRetNomeEmpresa);
  pSetaVar('NOMFAN', fRetFantasiaEmpresa);
  pSetaVar('IDEPRO', 'WCP');
  pSetaVar('DESTIN', '0,900 ML VIOLET RED 301A3 27 CONCENTRADO');
  pSetaVar('DILCON', 'CONCENTRADO');
  pSetaVar('DTAENT', '01/01/2011');
  pSetaVar('MONTAD', 'COLORMAP/2011');
  pSetaVar('QTDTIN', FloatToStrF(1, ffFixed, 12, 2));
  pSetaVar('NOMOPE', 'JOAO PEREIRA');
  pSetaVar('CODBAR', '12345678');
  pSetaVar('LINTIN', '0123456789');
  pSetaVar('LIDETI', 'AUTOBASE PLUS 100:50');
  pSetaVar('LINHA',  'TINFORT');
  pSetaVar('CATALI', 'CATALISE');
  pSetaVar('DTAVAL', 'Validade: 01/01/2011');

  pSetaVar('CODCLI', '00000000');
  pSetaVar('NOMCLI', 'CLIENTE TINTA MAQUINA');
  pSetaVar('ENDERE', 'RUA TINTA DE MAQUINA');
  pSetaVar('ENDNUM', '000');
  pSetaVar('BAIRRO', 'BAIRRO TINTA DE MAQUINA');
  pSetaVar('NOMCID', 'CIDADE TINTA DE MAQUINA');
  pSetaVar('ESTADO', 'TM');
  pSetaVar('C_E_P_', '11111111');
  pSetaVar('FONE01', '1111111111');
  pSetaVar('FONE02', '1111111111');
  pSetaVar('NUMDOC', '123412341234-MM-000');
  pSetaVar('OBSCOL', 'Observação para Colorista');

  pSetaInfoCodBar('12345678');

  If Assigned(FPreviw) Then
  Begin
    If FPreviw.Active Then
    Begin
      FPreviw.EmptyDataSet;
      FPreviw.Close;
    End;
    FreeAndNil(FPreviw);
  End;

  pCriaClientFormulacao(FPreviw);

  With FPreviw Do
  Begin
    FPreviw.Insert;
    FieldByName('TMP_FORMUL').AsString := '25_597';
    FieldByName('TMP_QTDBAS').AsFloat  := 74.7;
    FieldByName('TMP_DESCRI').AsString := 'VERDE';
    Post;

    FPreviw.Insert;
    FieldByName('TMP_FORMUL').AsString := '27_744';
    FieldByName('TMP_QTDBAS').AsFloat  := 37.6;
    FieldByName('TMP_DESCRI').AsString := 'AMARELO';
    Post;

    FPreviw.Insert;
    FieldByName('TMP_FORMUL').AsString := '27_666';
    FieldByName('TMP_QTDBAS').AsFloat  := 537.6;
    FieldByName('TMP_DESCRI').AsString := 'AZUL';
    Post;
  End;

  If fTemParametro('INFADI') Then
    FReport.Script.Variables['INFADI'] := fInformacaoAdicionalEtiquetaItens;
End;

Procedure TEditorFast.pAbreFormulacaoTinta(ftiDadosEtiq: TFormulEtiq; prmDllEtq: TParamDllEtiquetas);
Begin
  pSetaVar('NOMEMP', fRetNomeEmpresa);
  pSetaVar('NOMFAN', fRetFantasiaEmpresa);
  pSetaVar('IDEPRO', ftiDadosEtiq.strIdePro);
  pSetaVar('DESTIN', ftiDadosEtiq.strDesTin);
  pSetaVar('DILCON', ftiDadosEtiq.strDilCon);
  pSetaVar('DTAENT', ftiDadosEtiq.strDtaEmi);
  pSetaVar('MONTAD', ftiDadosEtiq.strMontad + '/' + ftiDadosEtiq.strAnoTin);
  pSetaVar('QTDTIN', FloatToStrF(ftiDadosEtiq.fltQtdTin, ffFixed, 12, 2));
  pSetaVar('NOMOPE', ftiDadosEtiq.strNomOpe);
  pSetaVar('CODBAR', ftiDadosEtiq.strCodBar);
  pSetaVar('LINHA',  ftiDadosEtiq.strLinha);
  pSetaVar('CATALI', ftiDadosEtiq.strCatali);

  pSetaVar('CODCLI', ftiDadosEtiq.strCodCli);
  pSetaVar('NOMCLI', ftiDadosEtiq.strNomCli);
  pSetaVar('ENDERE', ftiDadosEtiq.strEndere);
  pSetaVar('ENDNUM', ftiDadosEtiq.strEndNum);
  pSetaVar('BAIRRO', ftiDadosEtiq.strBairro);
  pSetaVar('NOMCID', ftiDadosEtiq.strCidade);
  pSetaVar('ESTADO', ftiDadosEtiq.strEstado);
  pSetaVar('C_E_P_', ftiDadosEtiq.strC_E_P_);
  pSetaVar('FONE01', ftiDadosEtiq.strFone01);
  pSetaVar('FONE02', ftiDadosEtiq.strFone02);
  pSetaVar('NUMDOC', ftiDadosEtiq.strDocume);
  pSetaVar('OBSCOL', ftiDadosEtiq.strObsCol);
  pSetaVar('DTAVAL', ftiDadosEtiq.strDtaVal);

  pSetaInfoCodBar(ftiDadosEtiq.strCodBar);
End;

Procedure TEditorFast.pCriaClientFormulacao(Var cdsDadEti: TUniClientDataSet);
Begin
  cdsDadEti := TUniClientDataSet.Create(Self);

  With cdsDadEti, FieldDefs Do
  Begin
    With AddFieldDef Do Begin Name := 'TMP_FORMUL'; DataType := ftString; Size := 40; Required := False; End;
    With AddFieldDef Do Begin Name := 'TMP_QTDBAS'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'TMP_DESCRI'; DataType := ftString; Size := 70; Required := False; End;
    CreateDataSet;
    Open;
  End;
End;    

procedure TEditorFast.pCriaClientProducaoTinta(
  var cdsDadEti: TUniClientDataSet);
begin
  cdsDadEti := TUniClientDataSet.Create(Self);
  cdsDadEti.FieldDefs.Add('AUTOINCREM', ftString, 20);
  cdsDadEti.CreateDataSet;
  cdsDadEti.Open;
  cdsDadEti.AppendRecord(['01234567890123456789']);
end;

function TEditorFast.fSQLFiltroGrupoCampos(intCodEti: Integer): String;
Begin

  If fCodigoToTipoEtiqueta(intCodEti) In CONJ_DOCUMENTOS Then
  Begin

     Result := '  ((GRU_CODETI = :CODETI) OR ';

    Case fCodigoToTipoEtiqueta(intCodEti) of
      tpeMI         : Result := Result + '  (GRU_DOC_MI = "S") ';
      tpeBR,
      tpeTR,
      tpeDV,
      tpeAJ,
      tpeTA,
      tpeEP,
      tpeBE,
      tpeUS,
      tpeCS,
      tpeCR,
      tpeTE,
      tpePI,
      tpeTicketDV,
      tpeFF         : Result := Result + '  (GRU_DOC_FF = "S") ';
      tpePD,
      tpePR         : Result := Result + '  (GRU_DOC_PD = "S") ';
      tpeOR         : Result := Result + '  (GRU_DOC_OR = "S") ';

      tpePA         : Result := Result + '  (GRU_DOC_PA = "S") ';
      tpeROTin      : Result := Result + '  (GRU_DOC_RO = "S") ';
      tpeGA         : Result := Result + '  (GRU_DOC_GA = "S") ';
      tpeContGR,
      tpeContGRBaixa: Result := Result + '  (GRU_DOC_GR = "S") ';
      tpePedidoCompra: Result := Result + ' (GRU_DOCPDC = "S") ';
      tpeContGC     : Result := Result + '  (GRU_DOC_GC = "S") ';
      tpeOrdProImobiliaria : Result := Result + '  (GRU_ORDIMO = "S")  ';
      tpeOrdProAutomotiva : Result :=  Result + '  (GRU_ORDAUT = "S")  ';

      tpeGF,
      tpeContGF     : Result := Result + '  (GRU_DOC_GF = "S") ';

      tpeNF,
      tpeNS,
      tpeIF,
      tpeTicketNF,
      tpeD1: Result := Result + '  (GRU_DOC_NF = "S") ';

      tpeCarnePagamento : Result := Result + '  (GRU_DOC_CP = "S") ';

      tpeDuplicata: Result := Result + '  (GRU_DOC_DP = "S") ';

      tpeLiberacaoArmazenagem: Result := Result + '  (GRU_DOC_LA = "S") ';

      tpeSF,
      tpeSepSF      : Result := Result + '  (GRU_DOC_SF = "S") ';

      tpeSepNota, tpeSepNotaObs    : Result := Result + '  (GRU_SEP_MI = "S") ';
      tpeSepPedido  : Result := Result + '  (GRU_SEP_PD = "S") ';
      tpeSepRomaneio: Result := Result + '  (GRU_SEP_RO = "S") ';
      tpeRequisicao : Result := Result + '  (GRU_REQUIS = "S") ';
      tpeCupomServico : Result := Result + ' (GRU_CUPSER = "S") ';
      tpeRL, tpeFaturaLocacao : Result := Result + '  (GRU_DOC_RL = "S") ';
      tpeDevolucaoLocacao : Result := Result + '  (GRU_DOC_DL = "S") ';
      tpeCupomPromocao : Result := Result + ' (GRU_CUPPRO = "S") ';
      tpeRemessaDevolucao : Result := Result + '  (GRU_DOC_RD = "S") ';
      tpeRB : Result := Result + '  (GRU_DOC_RB = "S") ';
      tpeFFDocumentosCR : Result := Result + '  (GRU_DOC_CRFF = "S") ';
      tpeCupomProxDesc : Result := Result + '  (GRU_DOC_CDPP = "S") ';
      else            Result := Result + '  FALSE              ';
    End;

    Result := Result + ' ) ';

  End Else
  Begin

    Result := '  GRU_CODETI = :CODETI ';

  End;

End;

procedure TEditorFast.pAbreSeqSeparacaoWMSPreview(qryEtique: TUniQuery);
  Var
    strSeqSep : String;
Begin
  With qryEtique, SQL Do
  Begin
    Close;
    Clear;
    Add(' SELECT MAX(FGO_SEQSEP) AS SEQSEP ');
    Add(' FROM EXTGOR                      ');

    Open;

    StrSeqSep := FieldByName('SEQSEP').AsString;

    Close;
    Clear;

    Add(' SELECT GROUP_CONCAT(LSE.CODLSE SEPARATOR "  ") AS RESLSE,                    ');
    Add('        (SELECT COUNT(0) FROM EXTGOR  WHERE FGO_SEQSEP = :SEQSEP ) AS QTDPED, ');
    Add('        FGO_SEQSEP AS SEQSEP                                                  ');
    Add(' FROM (                                                                       ');
    Add('     SELECT CONCAT(LOC_CODLSE, " : ", SUM(LDO_QTDITE)) AS CODLSE, FGO_SEQSEP  ');
    Add('     FROM EXTGOR                                                              ');
    Add('       INNER JOIN FATDOR D ON FDO_SEQGER = FGO_SEQFGO                         ');
    Add('       INNER JOIN LOTDOR L ON LDO_SEQFDO = D.AUTOINCREM                       ');
    Add('       INNER JOIN CADLOT C ON LOT_CODITE = FDO_CODITE                         ');
    Add('                          AND LOT_CODEMP = FDO_CODEMP                         ');
    Add('                          AND LOT_NUMLOT = LDO_NUMLOT                         ');
    Add('       INNER JOIN CADLOC A ON LOC_CODLOC = LOT_LOCFIS                         ');
    Add('                          AND LOC_CODEMP = LOT_CODEMP                         ');
    Add('     WHERE FGO_SEQSEP = :SEQSEP                                               ');
    Add('     GROUP BY LOC_CODLSE                                                      ');
    Add('     ) AS LSE                                                                 ');

    ParamByName('SEQSEP').AsString := strSeqSep;

    Open;

  End;

End;

procedure TEditorFast.pAbrePlanoRecebPreview(qryEtique: TUniQuery);
  Var
    blnSugereLocalizacao : Boolean;
Begin

  blnSugereLocalizacao := (fCfgSis('TPLREC', varString) = 'L');
  With qryEtique, SQL Do
  Begin
    Close;
    Clear;

    Add(' SELECT AIT_CODITE AS CODITE,                       ');
    Add('        ITE_DESITE AS DESITE,                       ');
    Add('        ARC_DTAREC AS DTAREC,                       ');
    Add('        ARC_HRAREC AS HRAREC,                       ');
    Add('        ARC_IDEDIG AS IDEDIG,                       ');
    Add('        DEP_CODIGO AS CODDEP,                       ');
    Add('        DEP_DESCRI AS DESDEP,                       ');
    Add('        GRU_CODGRU AS CODGRU,                       ');
    Add('        GRU_DESGRU AS DESGRU,                       ');
    Add('        AIT_CLASSE AS CLASSE,                       ');
    Add('        FOR_CODFOR AS CODFOR,                       ');
    Add('        FOR_NOMFOR AS NOMFOR,                       ');
    Add('        ITE_REFERE AS REFERE,                       ');
    Add('        UNI_SIGUNI AS SIGUNI,                       ');
    Add('        DET_NUMDOC AS NUMDOC,                       ');
    Add('        DET_ESPDOC AS ESPDOC,                       ');
    Add('        (SELECT LOC_CODLOC                          ');
    Add('           FROM MOVDET D                            ');
    Add('         INNER JOIN CADLOT L ON  (D.DET_NUMLOT = L.LOT_NUMLOT) ');
    Add('                             AND (D.DET_CODEMP = L.LOT_CODEMP) ');
    Add('                             AND (D.DET_CODITE = L.LOT_CODITE) ');
    Add('         INNER JOIN CADLOC C ON  (C.LOC_CODLOC = L.LOT_LOCFIS) ');
    Add('                             AND (C.LOC_CODEMP = L.LOT_CODEMP) ');
    Add('         WHERE D.DET_CODITE = DT.DET_CODITE         ');
    Add('           AND D.DET_CODEMP = DT.DET_CODEMP         ');
    Add('           AND D.DET_CLAFIS < 5000                  ');
    Add('         ORDER BY D.DET_DTAENT, D.DET_HORENT DESC LIMIT 1) AS ULTLOC, ');
    Add('        (SELECT COUNT(0) FROM AGEITE WHERE AIT_SEQGER = :SEQGER ) QITENS, ');
    Add('        (SELECT COUNT(0) FROM AGEITE INNER JOIN AGEILO ON AIL_SEQITE = AGEITE.AUTOINCREM WHERE AIT_SEQGER = :SEQGER ) QLOCAL, ');

    If blnSugereLocalizacao Then
    Begin
      Add('      1 AS QTDETI,          ');
      Add('      AIL_QTDITE AS QTDITE, ');
      Add('      AIL_QTDVEN AS QTDVEN, ');
      Add('      AIL_LOCFIS AS LOCFIS, ');
      Add('      AIL_DTAVEN AS DTAVEN, ');
    End
    Else
    Begin
      Add('      AIT_QTDETI AS QTDETI, ');
      Add('      0 AS QTDITE,    ');
      Add('      0 AS QTDVEN,    ');
      Add('      "" AS LOCFIS,   ');
      Add('      NULL AS DTAVEN, ');
    End;

    Add('        CONCAT("1", ARC_IDEDIG,                     ');
    Add('                    AIT_CODITE,                     ');
    Add('                    "001"                           ');

    If blnSugereLocalizacao Then
      Add( ' , AIL_SEQUEN ');

    Add(' ) AS CODBAR, ');


    Add('        IF( IFNULL(AIT_LOCFIS,"") <> "", AIT_LOCFIS, IG.ITE_LOCFIS) AS ITELOC  ');

    Add(',T.ITE_CODFAB AS CODFAB, ');
    Add(' T.ITE_CODBAR AS BARITE, ');

    Add('fRetLocalizacoesFisicasEtiquetaPlano(IG.ITE_CODEMP, IG.ITE_CODITE, 3) AS LOCSAL ');

    Add(' FROM AGEITE I                                        ');
    Add('   INNER JOIN AGEREC R  ON  R.AUTOINCREM = AIT_SEQGER ');
    Add('   INNER JOIN CADITE T  ON  T.ITE_CODITE = AIT_CODITE ');
    Add('   INNER JOIN ITEGER IG ON IG.ITE_CODITE = AIT_CODITE ');
    Add('                       AND IG.ITE_CODEMP = :CODEMP    ');
    Add('   LEFT  JOIN CADUNI U  ON  U.UNI_CODUNI = ITE_UNICOM ');
    Add('   LEFT  JOIN CADDEP D  ON  D.DEP_CODIGO = ITE_CODDEP ');
    Add('   LEFT  JOIN CADGRU G  ON  G.GRU_CODGRU = ITE_CODGRU ');
    Add('   INNER JOIN AGEDOC C  ON  C.ADC_SEQGER = AIT_SEQGER ');
    Add('   INNER JOIN MOVDET DT ON DET_NUMDOC = ADC_NUMDOC       ');
    Add('                    AND DET_ESPDOC = ADC_ESPDOC       ');
    Add('                    AND DET_SERIE_ = ADC_SERIE_       ');
    Add('                    AND DET_CODFOR = ADC_CODFOR       ');
    Add('                    AND DET_CODITE = AIT_CODITE       ');
    Add('   INNER JOIN CADFOR ON FOR_CODFOR = DET_CODFOR       ');

    If blnSugereLocalizacao Then
      Add('   INNER JOIN AGEILO ON AIL_SEQITE = I.AUTOINCREM   ');

    Add(' LIMIT 30                                             ');

    ParamByName('CODEMP').AsString := VS_strCodEmp;


    Open;
  End;
End;

procedure TEditorFast.pAbreLocalArmazenamentoWMSPreview(qryEtique: TUniQuery);
begin
  qryEtique.Close;
  qryEtique.SQL.Clear;
  qryEtique.SQL.Add(' SELECT LAR_CODLAR AS CODLAR,   ');
  qryEtique.SQL.Add('        LAR_DESLAR AS DESLAR,   ');
  qryEtique.SQL.Add('        LAR_CODLAR AS BARLAR    ');
  qryEtique.SQL.Add('   FROM CADLAR                  ');
  qryEtique.SQL.Add('  ORDER BY LAR_CODLAR           ');
  qryEtique.SQL.Add('  LIMIT 30                      ');
  qryEtique.Open;
end;

procedure TEditorFast.pAbreLocFisPreview(qryEtique: TUniQuery);
Begin
  With qryEtique, SQL Do
  Begin
    Close;
    Clear;

    Add(' SELECT LOC_CODLOC AS CODLOC,                  ');
    Add('        LOC_CODLOC AS BARLOC,                  ');
    Add('        ITEGER.ITE_LOCFIS AS LOCFIS,           ');
    Add('        LOC_DESCRI AS DESCRI,                  ');
    Add('        LOC_CODAMZ AS CODAMZ,                  ');
    Add('        AMZ_DESCRI AS DESAMZ,                  ');
    Add('        LOC_ALTURA AS ALTURA,                  ');
    Add('        LOC_ITEPIC AS ITEPIC,                  ');
    Add('        CADITE.ITE_DESITE AS DESITE,           ');
    Add('        LOC_PICKIN AS PICKIN,                  ');
    Add('        LOC_PROFUN AS PROFUN,                  ');
    Add('        LOC_CAPACI AS CAPACI,                  ');
    Add('        LOC_R_U_A_ AS R_U_A_,                  ');
    Add('        LOC_PREDIO AS PREDIO,                  ');
    Add('        LOC_ANDAR_ AS ANDAR_,                  ');
    Add('        LOC_APARTA AS APARTA,                  ');
    Add('        LOC_CODLSE AS CODLSE,                  ');
    Add('        LSE_DESCRI AS DESLSE,                  ');
    Add('        LOC_ATIVO_ AS ATIVO_,                  ');
    Add('        LOC_PESMAX AS PESMAX,                  ');
    Add('        CADITE.ITE_REFERE AS REFERE,           ');
    Add('        LOC_LARGUR AS LARGUR,                  ');
    Add('        LOC_OBSERV AS OBSERV,                  ');
    Add('       (SELECT LCI_QTDMAX FROM LOCITE WHERE LCI_LOCFIS = CADLOC.AUTOINCREM LIMIT 1)  AS QTDMAX, ');
    Add('       (SELECT LCI_QTDREP FROM LOCITE WHERE LCI_LOCFIS = CADLOC.AUTOINCREM LIMIT 1)  AS QTDREP, ');
    Add('       (SELECT LCI_CODITE FROM LOCITE WHERE LCI_LOCFIS = CADLOC.AUTOINCREM LIMIT 1)  AS CODITE,  ');
    Add('       (SELECT CI.ITE_DESITE FROM CADITE CI WHERE CI.ITE_CODITE = CODITE LIMIT 1) AS PRODES  ');
    Add(' FROM CADLOC                                   ');
    Add('   LEFT JOIN CADAMZ ON AMZ_CODAMZ = LOC_CODAMZ AND AMZ_CODEMP = :CODEMP');
    Add('   LEFT JOIN CADITE ON CADITE.ITE_CODITE = LOC_ITEPIC ');
    Add('   LEFT JOIN CADLSE ON LSE_CODIGO = LOC_CODLSE ');
    Add('   LEFT JOIN ITEGER ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND ITEGER.ITE_CODEMP = "' + VS_strCodEmp + '"');
    Add(' WHERE LOC_CODEMP = :CODEMP                    ');
    Add(' ORDER BY LOC_CODLOC                           ');
    Add(' LIMIT 30                                      ');

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

  End;
End;

procedure TEditorFast.pAbreEtiqQtdFracionada(qryEtique: TUniQuery);
var
  i: Integer;
begin
  fExecutaSQL('SET @row := 0');
  With qryEtique, SQL Do
  Begin
    Close;
    Clear;
    Add( ' SELECT                   ');
    Add( '     EMP_CODEMP AS CODEMP,');
    Add( '     EMP_NOMEMP AS NOMEMP,');
    Add( '   I.ITE_APLICA AS APLICA,');
    Add( '   I.ITE_ATICOM AS ATICOM,');
    Add( '   I.ITE_CODITE AS CODITE,');
    Add( ' CAST("" AS CHAR(1)) AS NUMDOC,');
    Add( ' CAST("" AS CHAR(1)) AS ESPDOC,');
    Add( ' CAST("" AS CHAR(1)) AS SERIE_,');
    Add( '   I.ITE_DESSIM AS DESSIM,  ');
    Add( '     EMP_C_G_C_ AS EMPCGC,  ');
    Add( '   G.ITE_LOCFIS AS LOCFIS,  ');
    Add( '   I.ITE_CODGRU AS CODGRU,  ');
    Add( '   I.ITE_DESITE AS DESITE,  ');
    Add( '   I.ITE_REFERE AS REFERE,  ');
    Add( '     UNI_SIGUNI AS SIGUNI,  ');
    Add( '   I.ITE_CODFAB AS CODFAB,  ');
    Add( '   I.ITE_CODBAR AS CODBAR,  ');
    Add( '   I.ITE_CODFOR AS CODFOR,  ');
    Add( '     MAR_CODMAR AS CODMAR,  ');
    Add( '     MAR_DESMAR AS DESMAR,  ');
    Add( '     IPR_PREVEN AS PROMOC,  ');
    Add( ' IFNULL(IPR_PERDES, 0) AS PERDES,');
    Add( ' IFNULL(IPR_QTDMIN, 0) AS QTDMIN,');
    Add( '1 AS ITE_PREVE1,');
    Add( '2 AS ITE_PREVE2,');
    Add( '3 AS ITE_PREVE3,');
    Add( '4 AS ITE_PREVE4,');
    Add( '5 AS ITE_PREVE5,');
    Add( '6 AS ITE_PREVE6,');
    Add( '7 AS ITE_PREVE7,');
    Add( '1 AS PREVE1,');
    Add( '2 AS PREVE2,');
    Add( '3 AS PREVE3,');
    Add( '4 AS PREVE4,');
    Add( '5 AS PREVE5,');
    Add( '6 AS PREVE6,');
    Add( '7 AS PREVE7,');
    Add( '  (SELECT GROUP_CONCAT(CADSEM.SEM_CODSEM)');
    Add( '     FROM CADSEM');
    Add( '    WHERE CADSEM.SEM_CODITE = I.ITE_CODITE');
    Add( '      AND CADSEM.SEM_CODEMP = I.ITE_CODEMP)AS CODSEM,');

    Add( '   G.ITE_PREVE1 AS VALITE,        ');
    Add( '   G.ITE_PREVE1 AS VALVIS,        ');
    Add( '   I.ITE_DTAALT,        ');
    Add( '   CONCAT(I.ITE_CODFAB, " ", MAR_DESMAR) AS FABMAR, ');
    Add( '   G.ITE_TABEMF AS TABEMF,');
    Add( '   G.ITE_DESFEC AS DESFEC,');
    Add( '   G.ITE_EMBFEC AS EMBFEC,');
    Add( '   CAST("" AS CHAR(1)) AS DESEMB ,');
    Add( '   0.0000 AS TOTPRA,       ');
    Add( '   G.ITE_PREVE1 AS PREVIS,       ');
    Add( '   0.0000 AS VALPAR,       ');
    Add( '   0.0000 AS QTDPAR,       ');
    Add( '   CONCAT(I.ITE_CODFAB, " " , MAR_DESMAR) AS FABMAR, ');
    Add( '   G.ITE_AMZETI AS AMZETI, ');
    Add( '   I.ITE_ITEATI AS ITEATI, ');
    Add( '   G.ITE_SALDOS AS SALDOS, ');
    Add( '   I.ITE_CODBAR AS BARITE, ');
    Add( '   CONCAT("FORN_",@row) AS NFORIT, ');
    Add( '   CONCAT("ITET_",@row) AS ITETIN, ');
    Add( '   CONCAT("COR_",@row) AS DESCOR, ');
    Add( '   I.ITE_CODBAR AS BARITE, ');

    If fCfgSis('PERQPC', varBoolean) Then
    Begin
      Add( '  @row := @row + 2 AS ID,   ');
      Add( '  1 AS QTDPAC,              ');
      Add( ' (@row / 2) AS QTDFRA,      ');
      Add( ' (@row / 2) AS QTDITE,      ');
    End;

    Add(' CONCAT("LOT_",@row) AS NUMLOT, ');

    Add( '   CADEMP.EMP_FONDA1 AS FONDA1, ');
    Add( '   CADEMP.EMP_FONDA2 AS FONDA2, ');
    Add( '   I.ITE_MENFIS AS MENFIS,');

    Add( ' CAST("" AS CHAR(1)) AS LOTECR,');
    Add( ' CAST("" AS CHAR(1)) AS EMBALA,');
    Add( ' CAST("" AS CHAR(1)) AS EMBPRE,');
    Add( ' FOR_CODFOR AS CODFOR,');
    Add( ' FOR_NOMFOR AS NOMFOR,');
    Add( ' G.ITE_LOCSUP AS LOCSUP,');
    Add( ' CAST("" AS CHAR(1)) AS DESEMB,');
    Add( ' CAST("" AS CHAR(1)) AS OBSIMP,');
    Add( ' CAST("" AS CHAR(1)) AS CODAMZ,');
    Add( ' ITE_VALIDA AS VALIDA,');
    Add( ' ITE_ITESAC AS ITESAC,');
    Add( ' ITE_COMPOS AS COMPOS,');
    Add( ' ITE_PAISOR AS PAISOR,');
    Add( ' ITE_ESTMIN AS ESTMIN,');
    Add( ' ITE_ESTMAX AS ESTMAX,');
    Add( ' ITE_MLTVEN AS MLTVEN,');

    For i := 1 To 7 Do
    Begin
      If fCfgSis('IMPPAG', varInteger) = 1 Then
      Begin
        //Internacional
        Add( ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPIT' + IntToStr(i) + ' ,');
        //Federal
        Add( ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPFT' + IntToStr(i) + ' ,');
        //Estadual
        Add( ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPET' + IntToStr(i) + ' ,');
        //Municipal
        Add( ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPMT' + IntToStr(i) + ' ,');
      End
      Else
      Begin
        //Internacional
        Add( ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQIMP, 0) /100 AS IBPIT' + IntToStr(i) + ', ');
        //Federal
        Add( ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQNAC, 0) /100 AS IBPFT' + IntToStr(i) + ', ');
        //Estadual
        Add( ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQEST, 0) /100 AS IBPET' + IntToStr(i) + ', ');
        //Municipal
        Add( ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQMUN, 0) /100 AS IBPMT' + IntToStr(i) + ', ');
      End;
    End;

    Add( '   I.AUTOINCREM             ');

    Add( ' FROM                       ');
    Add( '   CADITE I ');
    Add( '   INNER JOIN CADUNI ON I.ITE_CODUNI = UNI_CODUNI');

    Add( '   INNER JOIN CADEMP ON EMP_CODEMP = ' + QuotedStr(VS_strCodEmp));
    Add( '   INNER JOIN CADFOR ON FOR_CODFOR = I.ITE_CODFOR ');

    Add( '   INNER JOIN ITEGER G ON         ');
    Add( '     I.ITE_CODITE = G.ITE_CODITE AND');
    Add( '     G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp));

    Add( '   INNER JOIN CADMAR ON      ');
    Add( '     MAR_CODMAR = ITE_CODMAR ');

    Add( '   LEFT JOIN (SELECT IPR_PREVEN, IPR_CODITE, IPR_PERDES, IPR_QTDMIN FROM CADPRO JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ');
    Add( '   WHERE  ');
    Add( '   PROEMP.PRO_CODEMP = :CODEMP AND ' + fCurrentDate + ' BETWEEN PRO_DTAINI AND PRO_DTAFIN) AS TMP ON IPR_CODITE = G.ITE_CODITE ');

    Add( ' LEFT JOIN CADCID EMPEST ON EMPEST.CID_CODCID = CADEMP.EMP_CODCID ');
    If fCfgSis('IMPPAG', varInteger) = 1 Then
    Begin
      If fCfgSis('TIPABF') = 2 Then
        Add( ' LEFT JOIN ABFICM ON ABF_ESTADO = EMPEST.CID_ESTADO AND ABF_CODABF = G.ITE_CODABF ')
      Else
        Add( ' LEFT JOIN ABFICM ON ABF_ESTADO = EMPEST.CID_ESTADO AND ABF_CODABF = I.ITE_CODABF ');
    End
    Else
    begin
      Add( 'LEFT JOIN CADIBP UTI ON UTI.AUTOINCREM = IFNULL((SELECT AUTOINCREM FROM CADIBP FUL ');
      Add( '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ');
      Add( '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ');
      Add( '                                                    AND FUL.IBP_N_C_M_ = I.ITE_CLAIPI), ');

      Add( '                                                IFNULL((SELECT MAX(AUTOINCREM) FROM CADIBP FUL ');
      Add( '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ');
      Add( '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ');
      Add( '                                                    AND FUL.IBP_N_C_M_ = LEFT(I.ITE_CLAIPI, 4)) , ');
      Add( '                                                    (SELECT MAX(AUTOINCREM) FROM CADIBP FUL ');
      Add( '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ');
      Add( '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ');
      Add( '                                                    AND FUL.IBP_N_C_M_ = LEFT(I.ITE_CLAIPI, 2)))) ');
    End;

    Add(' LIMIT 30 ');

    Open;
  End;
end;

procedure TEditorFast.pAbreEtiqID(qryEtique: TUniQuery);
begin
  With qryEtique, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT DISTINCT SUBSTRING(AUTOINCREM,1,12) AS ETIQID, LOC_CODLOC AS LOCFIS FROM CADLOC LIMIT 30');
    Open;
  End;
end;


end.

