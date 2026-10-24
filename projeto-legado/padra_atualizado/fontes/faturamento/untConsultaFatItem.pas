{***************************************}
{* >>>>>>>>>>> ATENÇÃO <<<<<<<<<<<<<<  *}
{***************************************}
{* ESSA CONSULTA ESTA SENDO USADA PELA *}
{* DLL DA TINTA E TODA ALTERAÇÃO QUE   *}
{* FOR FEITA AQUI DEVE VERIFICAR A     *}
{* TINTA DE MÁQUINA                    *}
{***************************************}
{************************************AF*}
unit untConsultaFatItem;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untConsultaComp, DB, UniClientDataSet, Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus, EditFocus, DBMemoFocus,
  StrUtils, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxGridBandedTableView, cxGridDBBandedTableView, cxColorComboBox,
  untLegendasItem, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, untfuncoesSimples, MemDS, DBAccess, untFuncoesRel2,
  untConsultas;

type
  TfrmConsultaFatItem = class(TfrmConsultaComp)
    pnlDadosItem: TPanel;
    Label3: TLabel;
    lblSalRes: TLabel;
    dbeIteAti: TDBText;
    btnPedSalRes: TBitBtnLocked;
    btnSimilares: TBitBtnLocked;
    btnMostraEstoque: TBitBtnLocked;
    lblPreCus: TLabel;
    dbePreVen: TDBEditFocus;
    Label5: TLabel;
    dbeUltVen: TDBEditFocus;
    lblMsgLv1: TLabel;
    dbeMsgLv1: TDBEditFocus;
    lblMsgLv2: TLabel;
    dbeMsgLv2: TDBEditFocus;
    lblValPro: TLabel;
    edtValPro: TEditFocus;
    edtSalRes: TEditFocus;
    btnItensVend: TBitBtnLocked;
    btnItensComp: TBitBtnLocked;
    Label4: TLabel;
    dbeMarca: TDBEditFocus;
    dbeAplica: TDBMemoFocus;
    lblAplica: TLabel;
    btnPedComp: TBitBtnLocked;
    lblSal_Ml: TLabel;
    btnEntregasPendentes: TBitBtnLocked;
    lblSalDis: TLabel;
    edtSalDis: TEditFocus;
    btnPedCompGrid: TBitBtnLocked;
    btnSemelhantes: TBitBtnLocked;
    pnlImgPro: TPanel;
    imgPro: TImage;
    lblLocFis: TLabel;
    btnLotIte: TBitBtnLocked;
    shpGravCol: TShape;
    btnSalvarLayout: TBitBtnLocked;
    btnRestaurarLayout: TBitBtnLocked;
    pnlUltCom: TPanel;
    grpUltFornecedor: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtDesForUlt: TEditFocus;
    edtDTAULT: TEditFocus;
    edtPREULT: TEditFocus;
    edtFORULT: TEditFocus;
    btnAmpliar: TSpeedButton;
    lblPreBoca: TLabel;
    edtPrecoBoca: TEditFocus;
    lblComBoca: TLabel;
    edtComBoca: TEditFocus;
    edtSal_ML: TEditFocus;
    editSaldos: TEditFocus;
    btnSepIte: TBitBtnLocked;
    cxgLegendasLevel1: TcxGridLevel;
    cxgLegendas: TcxGrid;
    cxgLegendasView: TcxGridDBBandedTableView;
    cxgLegendasViewColumn1: TcxGridDBBandedColumn;
    cxgLegendasViewColumn2: TcxGridDBBandedColumn;
    btnEmbalagem: TBitBtnLocked;
    btnMostraPrecoVenda: TBitBtnLocked;
    Label6: TLabel;
    edtSalReG: TEditFocus;
    edtSalEntFut: TEditFocus;
    Label7: TLabel;
    btnExiEstrutura: TBitBtnLocked;
    lblTmpGar: TLabel;
    dbeTmpGar: TDBEditFocus;
    dbeInfGar: TDBEditFocus;
    lblInfGar: TLabel;
    chkSaldo: TCheckBox;
    btnVendasPerdidas: TBitBtnLocked;
    edtSalDisCD: TEditFocus;
    lblSalDisCD: TLabel;
    lblMinPro: TLabel;
    edtMinPro: TEditFocus;
    chkItePro: TCheckBox;
    tmrFiltro: TTimer;
    btnMetragem: TBitBtnLocked;
    lblQtdPec: TLabel;
    lblComPec: TLabel;
    lblLarPec: TLabel;
    lblEspPec: TLabel;
    dbeLocFis: TDBEdit;
    lblErrImg: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure qryConsultaAfterScroll(DataSet: TDataSet);
    procedure btnPedSalResClick(Sender: TObject);
    procedure btnSimilaresClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMostraEstoqueClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnItensVendClick(Sender: TObject);
    procedure btnItensCompClick(Sender: TObject);
    procedure btnPedCompClick(Sender: TObject);
    procedure btnEntregasPendentesClick(Sender: TObject);
    procedure btnExecutaTarefaClick(Sender: TObject);
    procedure btnPedCompGridClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSemelhantesClick(Sender: TObject);
    procedure btnLotIteClick(Sender: TObject);
    procedure btnSalvarLayoutClick(Sender: TObject);
    procedure btnRestaurarLayoutClick(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAmpliarClick(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSepIteClick(Sender: TObject);
    procedure cxgLegendasEnter(Sender: TObject);
    procedure cxgLegendasExit(Sender: TObject);
    procedure cxgLegendasViewColumn2StylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure btnEmbalagemClick(Sender: TObject);
    procedure btnMostraPrecoVendaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExiEstruturaClick(Sender: TObject);
    procedure chkSaldoClick(Sender: TObject);
    procedure lstIndicesClick(Sender: TObject);
    procedure dbgConsultaEnter(Sender: TObject);
    procedure btnVendasPerdidasClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chkIteProClick(Sender: TObject);
    procedure tmrFiltroTimer(Sender: TObject);
    procedure btnMetragemClick(Sender: TObject);
  private
    { Private declarations }
    blnUtilizaVendaMadeira : Boolean;
    FComPec,
    FLarPec,
    FEspPec,
    FQtdPec,
    fltQtdMt3 : Double;

    cdsLegendas: TLegendasItem;

    blnSitPro: Boolean;
    blnEmpFat: Boolean;
    blnEnterSim : Boolean;
    strAutIncSim: String;
    strChaveLayout: String;

    strMskDecUnitar: String;

    objItemPromo: TItemPromo;

    blnFaturamento: Boolean;    

    blnHabF7 : Boolean;
    blnSomaEntFut: Boolean;
    blnJaExecutou: Boolean;

    procedure pResetaTemporizador;
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pEscreveAtualizando;

    procedure pDesabilitaColunas;
    procedure pMostraComposicaoPrecoCusto(strCodIte: String);

    procedure pMostraBotaoSalRes;
    procedure pMostraBotaoSimilares;
    procedure pMostraPrecoPromocional;

    procedure pMostraEstoqueLojas;
    procedure pMostraPrecoLojas;
    procedure pRetDadUltCompra(strCodIte: String);
    procedure pAmpliaFoto;
    procedure pMostraPrecoBoca;
    procedure pImprimeSeparacaoItem;

    procedure pEnviarParaVendasPerdidas;
    function fExibeSaldoDisCD: Boolean;
    procedure pFiltarConsulta;
    function fGetFiltroSaldo: String;
    function fGetFiltroPromocao: String;
    procedure pAtualizaLabelMetragem;
    procedure SetComPec(const Value: Double);
    procedure SetEspPec(const Value: Double);
    procedure SetLarPec(const Value: Double);
    procedure SetQtdPec(const Value: Double);
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
    blnMosUltCom : Boolean;
    strTabPreco  : String;
    blnPedCorte  : Boolean;
    strCodCli    : String;
    strCodVen    : String;
    strCodDig    : String;
    intPraMedio  : Integer;
    blnSoConsulta: Boolean;
    strExibirFornec: String;
    strOpcDoc : String;
    strSenVen : String;
    procVendasPerdidas: TProcVendasGenerica;
    strEmprCD: String;
    strEmpSal: String;
    strEmpIte: String;
    blnExiSalDisCD: Boolean;
    blnAtualizaIndice : Boolean;
  Published
    Property fltComPec : Double Read FComPec Write SetComPec;
    Property fltLarPec : Double Read FLarPec Write SetLarPec;
    Property fltEspPec : Double Read FEspPec Write SetEspPec;
    Property fltQtdPec : Double Read FQtdPec Write SetQtdPec;
  End;

var
  frmConsultaFatItem: TfrmConsultaFatItem;

implementation

uses untConsulta, untFatMostraProdSimilar,
  untFatMostraPedSalRes, untFatMostraEstoqueEmp,
  untFuncoesRel, untFatEntrFuturaPendente,
  untCadProdutosCompCusto, untFatMostraProdSemelhante,
  untCadLotesConsulta, untCadPro, untCadProFoto, untCfgRel,
  untFatMostraPrecoEmp,untIteBar, untZClient,untFatEstruturaSubItens, TypesRel,
  untTypesSistema, untRelFatVendasCliente, untRelEstCompForn, untGetMetragem,
  untControleSepAvulsa;

{$R *.dfm}

{ TfrmConsultaFatItem }

procedure TfrmConsultaFatItem.pAmpliaFoto;
begin
  If lblErrImg.Visible Then
    Exit;

  pCriarFormularios(TfrmCadProFoto, frmCadProFoto);

  If (fCfgSis('IMGPRO') = 'S') Then
  Begin
    If FileExists(fCfgSis('PATIMG',varString) + qryConsulta.FieldByName('Codigo').AsString +'.jpg') Then
    Begin
      frmCadProFoto.imgPro.Visible := True;
      frmCadProFoto.imgPro.Picture.LoadFromFile(fCfgSis('PATIMG',varString) + qryConsulta.FieldByName('Codigo').AsString +'.jpg');
    End
    Else
    Begin
      frmCadProFoto.imgPro.Visible := False;
    End;
  End;

  frmCadProFoto.Caption := qryConsulta.FieldByName('Descrição').AsString;
  frmCadProFoto.ShowModal;

  pFreeAndNil(frmCadProFoto);
end;

procedure TfrmConsultaFatItem.pMostraPrecoLojas;
begin
  If Not fVerificaAcessoSistema('PREVEN') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso.', ['&O k']);
    Exit;
  End;  

  Try
    pCriarFormularios(TfrmFatMostraPrecoEmp, frmFatMostraPrecoEmp);
    frmFatMostraPrecoEmp.strCodIte    := qryConsulta.FieldByName('Codigo').AsString;
    frmFatMostraPrecoEmp.edtItem.Text := qryConsulta.FieldByName('Codigo').AsString + ' - ' +
                                         qryConsulta.FieldByName('Descrição').AsString;

    frmFatMostraPrecoEmp.ShowModal;

    FreeAndNil(frmFatMostraPrecoEmp);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pMostraPrecoLojas]');
    End;

  End;

end;


procedure TfrmConsultaFatItem.pAtuIndice(intIndice: Integer);
begin
  inherited;

  pDesabilitaColunas;
  pMostraBotaoSalRes;
  pMostraBotaoSimilares;
  pMostraPrecoPromocional;
  pMostraPrecoBoca;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  qryConsulta.EnableControls;

  Try
    pCarregaColunasGridBco(dbgConsulta, strChaveLayout);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[CarregarLayoutConsulta]');
    End;
  End;

end;

procedure TfrmConsultaFatItem.pDesabilitaColunas;
var
  intIdx:Integer;

  procedure pAjustaCampoPreco(strNomeCampo: String; intLargura:integer=10);
  begin
    If (qryConsulta.FindField(strNomeCampo) <> Nil) Then
    Begin
      qryConsulta.FieldByName(strNomeCampo).DisplayWidth := intLargura;
    End;
  end;

begin

  If qryConsulta.Active Then
  Begin
    blnSitPro := fCfgSis('SITPRO', varBoolean) And (qryConsulta.FindField( 'ITE_CORSIT') <> Nil);

    If (qryConsulta.FindField( 'ITE_CORSIT' ) <> Nil) Then
      qryConsulta.FindField( 'ITE_CORSIT' ).Visible := False;

    If (qryConsulta.FindField( 'BAR_CODBAR' ) <> Nil) Then
      qryConsulta.FindField( 'BAR_CODBAR' ).Visible := False;

    If (qryConsulta.FindField( 'BAR_EMBALA' ) <> Nil) Then
      qryConsulta.FindField( 'BAR_EMBALA' ).Visible := False;

    If (qryConsulta.FindField( 'BAR_PREVEN' ) <> Nil) Then
      qryConsulta.FindField( 'BAR_PREVEN' ).Visible := False;

    If (qryConsulta.FindField( 'BAR_DESCRI' ) <> Nil) Then
      qryConsulta.FindField( 'BAR_DESCRI' ).Visible := False;

    If (qryConsulta.FindField( 'BAR_TABPRE' ) <> Nil) Then
      qryConsulta.FindField( 'BAR_TABPRE' ).Visible := False;

    qryConsulta.FieldByName('SaldoNumerico').Visible := False;
    
    If (qryConsulta.FindField( 'ITE_SALDOS' ) <> Nil) Then
      (qryConsulta.FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat := '#,###0.000';

    If (qryConsulta.FindField( 'ITE_PREVE1' ) <> Nil) Then
    Begin
      (qryConsulta.FieldByName('ITE_PREVE1') As TFloatField).DisplayFormat := strMskDecUnitar;
       qryConsulta.FieldByName('ITE_PREVE1').Visible := False;
    End;

    If (qryConsulta.FindField( 'ITE_PREVE2' ) <> Nil) Then
    Begin
      (qryConsulta.FieldByName('ITE_PREVE2') As TFloatField).DisplayFormat := strMskDecUnitar;
       qryConsulta.FieldByName('ITE_PREVE2').Visible := False;
    End;

    If (qryConsulta.FindField( 'ITE_PREVE3' ) <> Nil) Then
    Begin
      (qryConsulta.FieldByName('ITE_PREVE3') As TFloatField).DisplayFormat := strMskDecUnitar;
       qryConsulta.FieldByName('ITE_PREVE3').Visible := False;
    End;

    If (qryConsulta.FindField( 'ITE_PREVE4' ) <> Nil) Then
    Begin
      (qryConsulta.FieldByName('ITE_PREVE4') As TFloatField).DisplayFormat := strMskDecUnitar;
       qryConsulta.FieldByName('ITE_PREVE4').Visible := False;
    End;

    If (qryConsulta.FindField( 'ITE_PREVE5' ) <> Nil) Then
    Begin
      (qryConsulta.FieldByName('ITE_PREVE5') As TFloatField).DisplayFormat := strMskDecUnitar;
       qryConsulta.FieldByName('ITE_PREVE5').Visible := False;
    End;

    If (qryConsulta.FindField( 'ITE_PREVE6' ) <> Nil) Then
    Begin
      (qryConsulta.FieldByName('ITE_PREVE6') As TFloatField).DisplayFormat := strMskDecUnitar;
       qryConsulta.FieldByName('ITE_PREVE6').Visible := False;
    End;

    If (qryConsulta.FindField( 'ITE_PREVE7' ) <> Nil) Then
    Begin
      (qryConsulta.FieldByName('ITE_PREVE7') As TFloatField).DisplayFormat := strMskDecUnitar;
       qryConsulta.FieldByName('ITE_PREVE7').Visible := False;
    End;

    If (qryConsulta.FindField( 'Preço Promoção' ) <> Nil) Then
    Begin
      TFloatField(qryConsulta.FieldByName('Preço Promoção')).DisplayFormat := strMskDecUnitar;
    End;

    {************************************************}
    {* ACRESCENTOU OS CAMPOS VALOR DA BOCA DE CAIXA *}
    {* E O CAMPO COMISSAO DA BOCA DE CAIXA          *}
    {**23/02/2011-15:03***************************DP*}
    If (qryConsulta.FindField( 'Preço Boca de Caixa' ) <> Nil) Then
    Begin
      TFloatField(qryConsulta.FieldByName('Preço Boca de Caixa')).DisplayFormat := strMskDecUnitar;
    End;

    If (qryConsulta.FindField( 'Comissão Boca de Caixa' ) <> Nil) Then
    Begin
      TFloatField(qryConsulta.FieldByName('Comissão Boca de Caixa')).DisplayFormat := strMskDecUnitar;
    End;


    If (qryConsulta.FindField( 'Saldo' ) <> Nil) Then
    Begin
       qryConsulta.FieldByName('Saldo').DisplayWidth := 10;
       If fCfgSis('USAPDV', varBoolean) or  fCfgSis('GARANT', varBoolean) Then
       Begin
         //qryConsulta.FieldByName('Saldo').Visible := False;
         lblSalDis.Visible := True;
         edtSalDis.Visible := True;
       End
       Else
       Begin
         //qryConsulta.FieldByName('Saldo').Visible := True;
         lblSalDis.Visible := False;
         edtSalDis.Visible := False;
       End;
    End;

    If (qryConsulta.FindField( 'SaldoTodasEmpresas' ) <> Nil) Then
    Begin
      qryConsulta.FieldByName('SaldoTodasEmpresas').DisplayWidth := 15;
      qryConsulta.FieldByName('SaldoTodasEmpresas').DisplayLabel := 'Saldo Todas Empresas';
      (qryConsulta.FieldByName('SaldoTodasEmpresas') As TFloatField).DisplayFormat := '#,###0.000';
    End;

    If (qryConsulta.FindField( 'Saldo em Peças' ) <> Nil) Then
      qryConsulta.FieldByName('Saldo em Peças').DisplayWidth := 15;

    If (qryConsulta.FindField('SaldoCD') <> Nil) Then
    Begin
      qryConsulta.FieldByName('SaldoCD').Visible := False;
//      qryConsulta.FieldByName('SaldoCD').DisplayWidth := 10;
//      qryConsulta.FieldByName('SaldoCD').DisplayLabel := 'Saldo CD';
//      (qryConsulta.FieldByName('SaldoCD') As TFloatField).DisplayFormat := '#,###0.000';
    End;

    If (qryConsulta.FindField( 'Qtd.Ped.Compra' ) <> Nil) Then
      (qryConsulta.FieldByName('Qtd.Ped.Compra') As TFloatField).DisplayFormat := '#,###0.000';

    If (qryConsulta.FindField( 'Preço Venda' ) <> Nil) Then
      (qryConsulta.FieldByName('Preço Venda') As TFloatField).DisplayFormat := strMskDecUnitar;

    If (qryConsulta.FindField( 'Valor Parcela' ) <> Nil) Then
      (qryConsulta.FieldByName('Valor Parcela') As TFloatField).DisplayFormat := '#,##0.00';

    If (qryConsulta.FindField('Preço Venda1') <> Nil) Then
    Begin
      qryConsulta.FieldByName('Preço Venda1').DisplayWidth := 10;
    End;

    If (qryConsulta.FindField('Preço Venda2') <> Nil) Then
    Begin
      qryConsulta.FieldByName('Preço Venda2').DisplayWidth := 10;
    End;

    If (qryConsulta.FindField('Preço Venda3') <> Nil) Then
    Begin
      qryConsulta.FieldByName('Preço Venda3').DisplayWidth := 10;
    End;

    If (qryConsulta.FindField('Preço Venda4') <> Nil) Then
    Begin
      qryConsulta.FieldByName('Preço Venda4').DisplayWidth := 10;
    End;

    If (qryConsulta.FindField('Preço Venda5') <> Nil) Then
    Begin
      qryConsulta.FieldByName('Preço Venda5').DisplayWidth := 10;
    End;

    If (qryConsulta.FindField('Preço Venda6') <> Nil) Then
    Begin
      qryConsulta.FieldByName('Preço Venda6').DisplayWidth := 10;
    End;

    If (qryConsulta.FindField('Preço Venda7') <> Nil) Then
    Begin
      qryConsulta.FieldByName('Preço Venda7').DisplayWidth := 10;
    End;

    pAjustaCampoPreco('Preço Minimo1');
    pAjustaCampoPreco('Preço Minimo2');
    pAjustaCampoPreco('Preço Minimo3');
    pAjustaCampoPreco('Preço Minimo4');
    pAjustaCampoPreco('Preço Minimo5');
    pAjustaCampoPreco('Preço Minimo6');
    pAjustaCampoPreco('Preço Minimo7');

    For intIdx:=1 to 7 Do
    Begin
      pAjustaCampoPreco('Qtd.Min.'+IntToStr(intIdx),6);
    End;

    If (qryConsulta.FindField('Preço Custo') <> Nil) Then
    Begin
      qryConsulta.FieldByName('Preço Custo').DisplayWidth := 10;
    End;

    If (qryConsulta.FindField('Un.') <> Nil) Then
    Begin
      qryConsulta.FieldByName('Un.').DisplayWidth := 3;
    End;

    If (qryConsulta.FindField('Descrição') <> Nil) Then
    Begin
      qryConsulta.FieldByName('Descrição').DisplayWidth := 75;
    End;

    If (qryConsulta.FindField('IPI Saída') <> Nil) Then
    Begin
      qryConsulta.FieldByName('IPI Saída').DisplayWidth := 7;
    End;
    
    If (qryConsulta.FindField('ITE_CNV_ML') <> Nil) Then
    Begin
      qryConsulta.FieldByName('ITE_CNV_ML').Visible := False;

      If (qryConsulta.FindField('ITE_SAL_ML') <> Nil) Then
      Begin
        //dbeSal_Ml.DataField := 'ITE_SAL_ML';
        qryConsulta.FieldByName('ITE_SAL_ML').Visible := False;
        TFloatField(qryConsulta.FieldByName('ITE_SAL_ML')).DisplayFormat := '#,###0.000';
      End;

    End;

    If (qryConsulta.FindField( 'PROMOC' ) <> Nil) Then
      qryConsulta.FieldByName('PROMOC').Visible     := False;

    If (qryConsulta.FindField( 'ITE_ITEATI' ) <> Nil) Then
      qryConsulta.FieldByName('ITE_ITEATI').Visible := False;

    If (qryConsulta.FindField( 'ITE_CODSIM' ) <> Nil) Then
      qryConsulta.FieldByName('ITE_CODSIM').Visible := False;

    If (qryConsulta.FindField( 'ITE_SALDOS' ) <> Nil) Then
      qryConsulta.FieldByName('ITE_SALDOS').Visible := False;

    If qryConsulta.FindField('ESTRUT') <> Nil Then
    Begin
      qryConsulta.FieldByName('ESTRUT').Visible     := False;
    End;

    If (qryConsulta.FindField('Loc. Fisica') <> Nil) Then
    Begin
      qryConsulta.FieldByName('Loc. Fisica').Visible := False;
      dbeLocFis.DataField  := 'Loc. Fisica';
      dbeLocFis.DataSource := dtsConsulta;
    End
    Else
    Begin
      dbeLocFis.Visible    := False;
      lblLocFis.Visible    := False;
    End;

    If (qryConsulta.FindField('ITE_TMPGAR') <> Nil) Then
    Begin
      qryConsulta.FieldByName('ITE_TMPGAR').Visible := False;
      dbeTmpGar.DataField  := 'ITE_TMPGAR';
      dbeTmpGar.DataSource := dtsConsulta;
    End
    Else
    Begin
      dbeTmpGar.Visible    := False;
      lblTmpGar.Visible    := False;
    End;

    If (qryConsulta.FindField('ITE_INFGAR') <> Nil) Then
    Begin
      qryConsulta.FieldByName('ITE_INFGAR').Visible := False;
      dbeInfGar.DataField  := 'ITE_INFGAR';
      dbeInfGar.DataSource := dtsConsulta;
    End
    Else
    Begin
      dbeInfGar.Visible    := False;
      lblInfGar.Visible    := False;
    End;

    If (qryConsulta.FindField('ITE_APLICA') <> Nil) Then
    Begin
      qryConsulta.FieldByName('ITE_APLICA').Visible := False;
      dbeAplica.DataField  := 'ITE_APLICA';
      dbeAplica.DataSource := dtsConsulta;
    End
    Else
    Begin
      dbeaplica.Visible    := False;
      lblAplica.Visible    := False;
    End;

    If (qryConsulta.FindField('Aplicação') <> Nil) Then
    Begin
      qryConsulta.FindField('Aplicação').Visible := False;
    End;

    If (qryConsulta.FindField('ITE_PRECUS') <> Nil) Then
      qryConsulta.FieldByName('ITE_PRECUS').Visible := False;

    If (qryConsulta.FindField('ULTVEN') <> Nil) Then
      qryConsulta.FieldByName('ULTVEN').Visible     := False;

    If (qryConsulta.FindField('ITE_MSGLV1') = Nil) Then
    Begin
//      btnMostraEstoque.Top := 116;
//      btnPedSalRes.Top     := btnMostraEstoque.Top;
//      btnSimilares.Top     := btnMostraEstoque.Top;
//      btnItensVend.Top     := btnMostraEstoque.Top;
//      btnItensComp.Top     := btnMostraEstoque.Top;
//      btnPedComp.Top       := btnMostraEstoque.Top;
//      btnPedCompGrid.Top   := btnMostraEstoque.Top;
//      btnSemelhantes.Top   := btnMostraEstoque.Top + 24;
      dbeMsgLv1.Visible    := False;
      dbeMsgLv2.Visible    := False;
      lblMsgLv1.Visible    := False;
      lblMsgLv2.Visible    := False;
    End
    Else
    Begin
      qryConsulta.FieldByName('ITE_MSGLV1').Visible := False;
      qryConsulta.FieldByName('ITE_MSGLV2').Visible := False;
      dbeMsgLv1.DataField := 'ITE_MSGLV1';
      dbeMsgLv2.DataField := 'ITE_MSGLV2';
    End;

//    If btnEntregasPendentes.Visible Then
//    Begin
//      pnlDadosItem.Height := pnlDadosItem.Height + 25;
//      btnEntregasPendentes.Top := btnMostraEstoque.Top + btnMostraEstoque.Height + 1;
//    End;

    If (qryConsulta.FindField('Montadora') <> Nil) Then
    Begin
      qryConsulta.FieldByName('Montadora').DisplayWidth := 20;
    End;

    If (qryConsulta.FindField('Dias para entrega do Fornecedor') <> Nil) Then
      qryConsulta.FieldByName('Dias para entrega do Fornecedor').DisplayWidth := 30;
  End;

end;

procedure TfrmConsultaFatItem.pEnviarParaVendasPerdidas;
begin
  If Assigned(procVendasPerdidas) Then
    procVendasPerdidas(strCodCli, strSenVen, qryConsulta.FieldByName('Codigo').AsString);
end;

procedure TfrmConsultaFatItem.pFiltarConsulta;
  Var
    strFiltro : String;
begin
  If Not blnJaExecutou Then
  Begin
    blnJaExecutou := True;
    If (qryConsulta.Active) Then
    Begin
      strFiltro := fGetFiltroSaldo;

      If Not fEmptyStr(fGetFiltroPromocao) Then
      Begin
        If Not fEmptyStr(strFiltro) Then
          strFiltro := strFiltro + ' AND ';
        strFiltro := strFiltro + fGetFiltroPromocao;
      End;

      If Not fEmptyStr(strFiltro) Then
      Begin
        qryConsulta.Filter := strFiltro;
        qryConsulta.Filtered := True;
      End
      Else
      Begin
        qryConsulta.Filter := '';
        qryConsulta.Filtered := False;
      End;

      qryConsultaAfterScroll(qryConsulta);
    End;
  End;
end;

procedure TfrmConsultaFatItem.pEscreveAtualizando;
begin
  editSaldos.Text   := 'Atualizando...';
  edtSal_ML.Text    := 'Atualizando...';
  edtSalRes.Text    := 'Atualizando...';
  edtSalReG.Text    := 'Atualizando...';
  edtSalDis.Text    := 'Atualizando...';
  edtSalEntFut.Text := 'Atualizando...';
  edtSalDisCD.Text  := 'Atualizando...';
end;

procedure TfrmConsultaFatItem.FormShow(Sender: TObject);
begin
  If fEmptyStr(strEmpSal) Then
  Begin
    strEmpSal := VS_strCodEmp;
    strEmpIte := VS_strCodEmp;
  End;

  btnSalvarLayout.Visible := False;
  btnRestaurarLayout.Visible := False;
  btnVendasPerdidas.Visible := (Pos(strOpcDoc, 'VN_PD_OR_') > 0) And
                               (Not fEmptyStr(strCodCli)) And
                               (Not fEmptyStr(strSenVen)) And
                               (Assigned(procVendasPerdidas));

  strChaveLayout := '';

  If (Pos('frmFatVendas',   strNomeForm) > 0) Or
     (Pos('frmPrincipal',   strNomeForm) > 0) Or
     (Pos('frmCadProdutos', strNomeForm) > 0) Then
  Begin
    btnSalvarLayout.Visible := True;
    btnRestaurarLayout.Visible := True;
  End;

  blnFaturamento := (Pos('frmFatVendas', strNomeForm) > 0) Or (Pos('frmPrincipal', strNomeForm) > 0) Or (Pos('frmCadProdutos', strNomeForm) > 0);
  
  If (Pos('frmFatVendas', strNomeForm) > 0) Then
  Begin
    strChaveLayout := 'FATVENDA';
  End
  Else If (Pos('frmPrincipal', strNomeForm) > 0) Then
  Begin
    strChaveLayout := 'CONSLAPIS';
  End
  Else If (Pos('frmCadProdutos', strNomeForm) > 0) Then
  Begin
    strChaveLayout := 'CADPRODUTO';
  End;

  inherited;

  chkSaldo.Checked := blnCheckSaldo;
  chkItePro.Checked := blnCheckPromo;

  {If qryConsulta.FindField('Saldo') <> Nil Then
    dbeSaldos.DataField := 'Saldo';}

  btnMostraEstoque.Visible := VS_blnTemFil;
  btnEntregasPendentes.Visible := (fCfgSis('ENTFUT', varBoolean));

  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;

  If Not( blnMosUltCom ) Then
    pnlUltCom.Visible := False;

//  If btnEntregasPendentes.Visible Then
//  Begin
//    pnlDadosItem.Height := pnlDadosItem.Height + 25;
//    btnEntregasPendentes.Top := btnMostraEstoque.Top + btnMostraEstoque.Height + 1;
//  End;

  //btnPedCompGrid.Top := btnPedComp.Top + btnPedComp.Height + 1;
  btnPedCompGrid.Top := btnItensComp.Top;

  {************************************************}
  {* VERIFICA SE USA RELACIONAMENTO DE SEMELHANÇA *}
  {*********************************************LU*}
  If Not (fCfgSis('UTISEM', varBoolean)) Then
    btnSemelhantes.Visible := False;

  pDesabilitaColunas;

  pSetFocus(edtFiltro1);

  blnSomaEntFut := fUsaQtdPendenteEntregaFutura;

  qryConsultaAfterScroll(qryConsulta);

  If blnAtualizaIndice Then
  Begin
    lstIndices.ItemIndex := intUltItemIndex;
    pAtuIndice(intUltItemIndex);
    pAtualizaConsulta;
  End;

end;

procedure TfrmConsultaFatItem.lstIndicesClick(Sender: TObject);
begin
  inherited;

  blnJaExecutou := False;
end;

procedure TfrmConsultaFatItem.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  blnJaExecutou := False;
  pDesabilitaColunas;
end;

procedure TfrmConsultaFatItem.edtFiltro1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

function TfrmConsultaFatItem.fExibeSaldoDisCD: Boolean;
begin
  Result := (qryConsulta.FindField('SaldoCD') <> Nil) And (blnExiSalDisCD);
end;

function TfrmConsultaFatItem.fGetFiltroPromocao: String;
begin
  If chkItePro.Checked Then
    Result := '(PROMOC > 0)'
  Else
    Result := '';
end;

function TfrmConsultaFatItem.fGetFiltroSaldo: String;
begin
  If chkSaldo.Checked Then
  Begin
    If (fCfgSis('EXCOSA', varBoolean)) Then
      Result := '(SaldoTodasEmpresas > 0)'
    Else
      Result := '(ITE_SALDOS > 0)';
  End
  Else
    Result := '';
end;

procedure TfrmConsultaFatItem.qryConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  pResetaTemporizador;
end;

procedure TfrmConsultaFatItem.SetComPec(const Value: Double);
begin
  FComPec := Value;
  pAtualizaLabelMetragem;
end;

procedure TfrmConsultaFatItem.SetEspPec(const Value: Double);
begin
  FEspPec := Value;
  pAtualizaLabelMetragem;
end;

procedure TfrmConsultaFatItem.SetLarPec(const Value: Double);
begin
  FLarPec := Value;
  pAtualizaLabelMetragem;
end;

procedure TfrmConsultaFatItem.SetQtdPec(const Value: Double);
begin
  FQtdPec := Value;
  pAtualizaLabelMetragem;
end;

procedure TfrmConsultaFatItem.pAtualizaDados(DataSet: TDataSet);
  Var
    fltEntFutSoma  : Double;
    fltEntFutPen   : Double;
    fltEntFutPen_ML: Double;
    fltCnv_Ml      : Double;

  procedure pCalculaSaldoDisponivelCD(fltCnvML: Double = 0);
    Var
      fltSaldoTmp : Double;
      fltEntFutCD : Double;
  begin
    If (fExibeSaldoDisCD) Then
    Begin
      If Not lblSalDisCD.Visible Then
      Begin
        lblSalDisCD.Visible := True;
        edtSalDisCD.Visible := True;
      End;

      If fltCnvML > 0 Then
        fltSaldoTmp := qryConsulta.FieldByName('SaldoCD').AsFloat * fltCnvML
      Else
        fltSaldoTmp := qryConsulta.FieldByName('SaldoCD').AsFloat;

      If blnSomaEntFut Then
        fltEntFutCD := fQtdPendenteEntregaFutura(qryConsulta.FieldByName('CODIGO').AsString,
                                                 strEmprCD,
                                                 '',
                                                 False)
      Else
        fltEntFutCD := 0.00;

      edtSalDisCD.Text := FormatFloat('#,##0.000',
                                      fltSaldoTmp +
                                      fltEntFutCD -
                                      fRetornaSalRes(strEmprCD, False, '', qryConsulta.FieldByName('CODIGO').AsString, strEmprCD, '', '', '', False, False, True, 0, Not blnPedCorte, True));
    End;
  end;

begin
  inherited;

  If qryConsulta.Active then
  Begin
    pFiltarConsulta;

    fltComPec := 1.00;
    fltLarPec := 1.00;
    fltEspPec := 1.00;
    fltQtdPec := 1.00;

    btnMetragem.Visible := blnUtilizaVendaMadeira And dbePreVen.Visible And fMetragemObrigatoria( fRetUnidadeItem(qryConsulta.FieldByName('CODIGO').AsString) );
    lblQtdPec.Visible   := btnMetragem.Visible;
    lblComPec.Visible   := btnMetragem.Visible;
    lblLarPec.Visible   := btnMetragem.Visible;
    lblEspPec.Visible   := btnMetragem.Visible;

    fltEntFutPen    := fQtdPendenteEntregaFutura(qryConsulta.FieldByName('CODIGO').AsString, strEmpSal, '', False);
    fltEntFutPen_ML := fQtdPendenteEntregaFutura(qryConsulta.FieldByName('CODIGO').AsString, strEmpSal, '', True );
    fltEntFutSoma   := fltEntFutPen;

    If MatchStr(fCfgSis('CALSAL'), ['3','4']) Then
      fltEntFutSoma := fQtdPendenteEntregaFutura(qryConsulta.FieldByName('CODIGO').AsString, strEmpSal, '', False, blnFaturamento);

    If (qryConsulta.FindField('ITE_CNV_ML') <> Nil) And (qryConsulta.FindField('ITE_SAL_ML') <> Nil) Then
    Begin
      fltCnv_Ml    := IIF(qryConsulta.FindField('ITE_CNV_ML').AsFloat <= 0, 1, qryConsulta.FindField('ITE_CNV_ML').AsFloat);
      //Saldo sem converter em ML (Embalagens)
      editSaldos.Text := FormatFloat('#,##0.000', (qryConsulta.FieldByName('ITE_SALDOS').AsFloat) + IIF(blnSomaEntFut, fltEntFutSoma, 0) );

      edtSalRes.Text := FormatFloat('#,##0.000', fRetornaSalRes(strEmpIte,
                                                                False,
                                                                '',
                                                                qryConsulta.FieldByName('CODIGO').AsString,
                                                                strEmpSal,
                                                                '',
                                                                '',
                                                                '',
                                                                False,
                                                                False,
                                                                True,
                                                                1,
                                                                Not blnPedCorte,
                                                                True));

      edtSalReG.Text := FormatFloat('#,##0.000', fRetornaSalRes(strEmpIte,
                                                                False,
                                                                '',
                                                                qryConsulta.FieldByName('CODIGO').AsString,
                                                                strEmpSal,
                                                                '',
                                                                '',
                                                                '',
                                                                False,
                                                                False,
                                                                True,
                                                                2,
                                                                Not blnPedCorte,
                                                                True));

      blnHabF7 := (fRetornaSalRes(strEmpIte,
                                  False,
                                  '',
                                  qryConsulta.FieldByName('CODIGO').AsString,
                                  strEmpSal,
                                  '',
                                  '',
                                  '',
                                  False,
                                  False,
                                  True,
                                  1,
                                  {*******************************************************************************}
                                  {*PARA HABILITAR O BOTÃO F7 PRECISA VER TODOS OS PEDIDOS, INCLUSIVE COM CORTES!*}
                                  {****************************************************************************RN*}
                                  False,
                                  True ) + IIF(fEmptyStr(edtSalReG.Text),0,fStrToFloat(edtSalReG.Text))) > 0;

      edtSalEntFut.Text := FormatFloat('#,##0.000', fltEntFutPen_ML);//Ja convertido em ML

      If fltCnv_Ml > 0 Then
      Begin
        edtSalDis.Text := FormatFloat('#,##0.000', (qryConsulta.FieldByName('SaldoNumerico').AsFloat * fltCnv_Ml) +
                                                   qryConsulta.FieldByName('ITE_SAL_ML').AsFloat - fStrToFloat(edtSalRes.Text) - fStrToFloat(edtSalReG.Text));
        pCalculaSaldoDisponivelCD(fltCnv_Ml);
      End
      Else
      Begin
        edtSalDis.Text := FormatFloat('#,##0.000', qryConsulta.FieldByName('SaldoNumerico').AsFloat - fStrToFloat(edtSalRes.Text) - fStrToFloat(edtSalReG.Text));
        pCalculaSaldoDisponivelCD;
      End;
    End
    Else
    Begin
      edtSalRes.Text := FormatFloat('#,##0.000', fRetornaSalRes(strEmpIte, False, '', qryConsulta.FieldByName('CODIGO').AsString, strEmpSal, '', '', '', False, False, True, 1, Not blnPedCorte, True));
      edtSalReG.Text := FormatFloat('#,##0.000', fRetornaSalRes(strEmpIte, False, '', qryConsulta.FieldByName('CODIGO').AsString, strEmpSal, '', '', '', False, False, True, 2, Not blnPedCorte, True));
      edtSalDis.Text := FormatFloat('#,##0.000', qryConsulta.FieldByName('SaldoNumerico').AsFloat - fStrToFloat(edtSalRes.Text) - fStrToFloat(edtSalReG.Text) );
      pCalculaSaldoDisponivelCD;
    End;

    {************************************************************************}
    {* TRECHO QUE PERMITE EXIBIR A IMAGEM DO PRODUTO                        *}
    {******************************************************************* AM *}
    If fCfgSis('IMGPRO') = 'S' Then
    Begin
      lblErrImg.Visible := False;
      If FileExists(fCfgSis('PATIMG',varString) + qryConsulta.FieldByName('CODIGO').AsString +'.jpg') Then
      Begin
       imgPro.Visible := True;
       Try
         imgPro.Picture.LoadFromFile(fCfgSis('PATIMG',varString) + qryConsulta.FieldByName('CODIGO').AsString +'.jpg');
       Except
         imgPro.Visible    := False;
         lblErrImg.Visible := True;
       End;
      End
      Else
      Begin
        imgPro.Visible := False;
      End;
    End;
  End;

  btnExiEstrutura.Visible := (qryConsulta.Active) And (qryConsulta.FindField('ESTRUT') <> Nil) And (qryConsulta.FieldByName('ESTRUT').AsInteger > 0);

  pMostraBotaoSalRes;
  pMostraBotaoSimilares;
  pMostraPrecoPromocional;
  pMostraPrecoBoca;

  If dbeIteAti.Field.AsString = 'ATIVO' Then
    dbeIteAti.Font.Color := clGreen
  Else
    dbeIteAti.Font.Color := ARRCOR_SITUACAO_ITEM[sitInativo];

  //*************************************************//
  // RETORNA OS DADOS DA ULTIMA COMPRA               //
  //**********************************************ED*//
  If blnMosUltCom Then
    pRetDadUltCompra(qryConsulta.FieldByName('CODIGO').AsString);

  If (qryConsulta.FindField('ITE_CNV_ML') <> Nil)      And
     (qryConsulta.FindField('ITE_CNV_ML').AsFloat > 0) Then
  Begin
    edtSal_ML.Visible := True;
    edtSal_ML.Text := FormatFloat('#,##0.000', qryConsulta.FieldByName('ITE_SAL_ML').AsFloat);
  End
  Else
  Begin
    edtSal_ML.Visible := False;
  End;

  lblSal_ML.Visible := edtSal_ML.Visible;

  If Not dbgConsulta.Focused Then
    dbgConsulta.Repaint;
end;

procedure TfrmConsultaFatItem.tmrFiltroTimer(Sender: TObject);
begin
  inherited;
  tmrFiltro.Enabled := False;
  pAtualizaDados(qryConsulta);
end;

procedure TfrmConsultaFatItem.pMostraBotaoSalRes;
begin

  If fCfgSis('USAPDV', varBoolean) Then
    btnPedSalRes.Visible := blnHabF7;
  
end;

procedure TfrmConsultaFatItem.btnPedSalResClick(Sender: TObject);
  Var
    strSQL    : String;
    cdsSalRes : TUniClientDataSet;
    qrySalRes : TUniQuery;
    strEmp_CD : String;
    fltQtdeIte: Double;
begin
  inherited;

  strEmp_CD := fCfgSis('EMP_CD');  

  If btnPedSalRes.Visible Then
  Begin

    cdsSalRes := TUniClientDataSet.Create(Self);
    cdsSalRes.FieldDefs.Add('FDO_NUMDOC', ftString, fTamNumDoc, False);
    cdsSalRes.FieldDefs.Add('FDO_CODEMP', ftString, 03, False);
    cdsSalRes.FieldDefs.Add('FDO_CODVEN', ftString, 03, False);
    cdsSalRes.FieldDefs.Add('FDO_DTAENT', ftDate,   00, False);
    cdsSalRes.FieldDefs.Add('CLI_NOMCLI', ftString, 60, False);
    cdsSalRes.FieldDefs.Add('FDO_QTDITE', ftFloat,  00, False);
    cdsSalRes.FieldDefs.Add('EQU_NUMOSE', ftString, 06, False);
    cdsSalRes.FieldDefs.Add('EQU_STATUS', ftString, 20, False);
    cdsSalRes.FieldDefs.Add('FGO_CORTE_', ftString, 01, False);    
    cdsSalRes.FieldDefs.Add('FDO_ESPDOC', ftString, 02, False);
    cdsSalRes.FieldDefs.Add('TABELA'    , ftString, 07, False);
    cdsSalRes.CreateDataSet;

    qrySalRes := fCriaQuery(Self);
    
    strSQL := fGetSQLSaldoRes(strEmp_CD);

    With qrySalRes Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strEmpSal;
      ParamByName('CODITE').AsString := qryConsulta.FieldByName('Codigo').AsString;
      Open;

      If (Not IsEmpty) Then
      Begin
        First;
        While Not Eof Do
        Begin
          If FieldByName('FDO_QTDITE').AsFloat = 0 Then
            fltQtdeIte := fRetornaSalRes(strEmpSal, False,
                                         FieldByName('FDO_NUMDOC').AsString,
                                         qryConsulta.FieldByName('Codigo').AsString,
                                         FieldByName('FDO_CODEMP').AsString, '', '', '',
                                         False, True, True, 1, False)
          Else
            fltQtdeIte := FieldByName('FDO_QTDITE').AsFloat;

          If fltQtdeIte > 0 Then
          Begin
            cdsSalRes.Append;
            cdsSalRes.FieldByName('FDO_NUMDOC').AsString   := FieldByName('FDO_NUMDOC').AsString;
            cdsSalRes.FieldByName('FDO_CODEMP').AsString   := FieldByName('FDO_CODEMP').AsString;
            cdsSalRes.FieldByName('FDO_CODVEN').AsString   := FieldByName('FDO_CODVEN').AsString;
            cdsSalRes.FieldByName('FDO_DTAENT').AsDateTime := FieldByName('FDO_DTAENT').AsDateTime;
            cdsSalRes.FieldByName('CLI_NOMCLI').AsString   := FieldByName('CLI_NOMCLI').AsString;
            cdsSalRes.FieldByName('FDO_QTDITE').AsFloat    := fltQtdeIte;
            cdsSalRes.FieldByName('EQU_NUMOSE').AsString   := FieldByName('EQU_NUMOSE').AsString;
            cdsSalRes.FieldByName('EQU_STATUS').AsString   := FieldByName('EQU_STATUS').AsString;
            cdsSalRes.FieldByName('FGO_CORTE_').AsString   := FieldByName('FGO_CORTE_').AsString;
            cdsSalRes.FieldByName('FDO_ESPDOC').AsString   := FieldByName('FDO_ESPDOC').AsString;
            cdsSalRes.FieldByName('TABELA').AsString       := FieldByName('TABELA').AsString;
            cdsSalRes.Post;
          End;

          Next;
        End;

        Try
          pCriarFormularios(TfrmFatMostraPedSalRes, frmFatMostraPedSalRes);
          frmFatMostraPedSalRes.dtsSalRes.DataSet := cdsSalRes;
          frmFatMostraPedSalRes.edtItem.Text := qryConsulta.FieldByName('Codigo').AsString + ' - ' +
                                                qryConsulta.FieldByName('Descrição').AsString;
          frmFatMostraPedSalRes.showModal;
        Except
          On E: Exception Do
            pMensagensErro(E.Message, '[frmConsultaFatItem.btnPedSalResClick]');
        End;
        pFreeAndNil(frmFatMostraPedSalRes);

      End
      Else
        fMensagem('', 'Não há pedidos reservando esse item!', ['&O k']);

      Close;

    End;

    FreeAndNil(cdsSalRes);
    FreeAndNil(qrySalRes);
  End;
end;

procedure TfrmConsultaFatItem.pMostraBotaoSimilares;
begin
  If (qryConsulta.FindField( 'ITE_CODSIM' ) <> Nil) And (Not qryConsulta.FieldByName('ITE_CODSIM').IsNull) Then
  Begin
    btnSimilares.Visible := True;
  End
  Else
  Begin
    btnSimilares.Visible := False;
  End;
end;

procedure TfrmConsultaFatItem.btnSimilaresClick(Sender: TObject);
  Var
    strCodFab,
    strCodIte: String;
begin
  inherited;
  If btnSimilares.Visible Then
  Begin
    If not TfrmFatMostraProdSimilar.fMostraSimilar(qryConsulta.FieldByName('ITE_CODSIM').AsString,
                                                   qryConsulta.FieldByName('Codigo').AsString,
                                                   qryConsulta.FieldByName('Descrição').AsString ,
                                                   strTabPreco,
                                                   blnEnterSim,
                                                   strAutIncSim,
                                                   strCodFab,
                                                   strCodIte,
                                                   SameText(strNomeForm,'frmEntMercadorias') Or SameText(strNomeForm,'frmPedidoDeCompra'),
                                                   False,
                                                   blnFaturamento) Then
      fMensagem('', 'Não há itens similares!', ['&O k']);

    If (copy(strNomeForm,1,12) = 'frmFatVendas') And (blnEnterSim) Then
      btnConfirma.Click;


  End;

  pSetFocus(ActiveControl);
end;

procedure TfrmConsultaFatItem.btnVendasPerdidasClick(Sender: TObject);
begin
  inherited;
  If (btnVendasPerdidas.Visible) Then
    pEnviarParaVendasPerdidas;
end;

procedure TfrmConsultaFatItem.chkIteProClick(Sender: TObject);
begin
  inherited;
  blnCheckPromo := chkItePro.Checked;
  blnJaExecutou := False;
  pFiltarConsulta;
end;

procedure TfrmConsultaFatItem.chkSaldoClick(Sender: TObject);
begin
  blnCheckSaldo := chkSaldo.Checked;
  blnJaExecutou := False;
  pFiltarConsulta;
end;

procedure TfrmConsultaFatItem.cxgLegendasEnter(Sender: TObject);
begin
  inherited;

  blnMoveComSeta := False;
end;

procedure TfrmConsultaFatItem.cxgLegendasExit(Sender: TObject);
begin
  inherited;

  blnMoveComSeta := True;
end;

procedure TfrmConsultaFatItem.cxgLegendasViewColumn2StylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  AStyle := cdsLegendas.fRetStyle(ARecord.Values[0]);

  inherited;
end;

procedure TfrmConsultaFatItem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F5 Then
  Begin
    If ssAlt In Shift Then
      btnSepIte.Click
    Else
      btnEntregasPendentes.Click;
  End
  Else If Key = VK_F2 Then
  Begin
    btnSemelhantes.Click;
  End
  Else If Key = VK_F6 Then
  Begin
    If ssAlt In Shift Then
      btnLotIte.Click
    Else
      btnMostraEstoque.Click;
  End
  Else If Key = VK_F7 Then
  Begin
    If ssAlt In Shift Then
      btnEmbalagem.Click
    Else
      btnPedSalRes.Click;

  End
  Else If Key = VK_F8 Then
  Begin
    If Shift = [ssAlt] Then
      btnExiEstrutura.Click
    Else
      btnSimilares.Click;
  End
  Else If Key = VK_F9 Then
  Begin
    btnItensVend.Click;
  End
  Else If Key = VK_F10 Then
  Begin
    btnItensComp.Click;
  End
  Else If Key = VK_F11 Then
  Begin
    btnPedComp.Click;
  End
  Else If Key = VK_F12 Then
  Begin
    btnPedCompGrid.Click;
  End
  Else If Key = VK_F1 Then
  Begin
    btnMetragem.Click;
  End;
end;

procedure TfrmConsultaFatItem.btnMostraEstoqueClick(Sender: TObject);
begin
  inherited;

  If btnMostraEstoque.Visible Then
  Begin
    pMostraEstoqueLojas;
    pSetFocus(ActiveControl);
  End;

end;

procedure TfrmConsultaFatItem.btnMostraPrecoVendaClick(Sender: TObject);
begin
  inherited;
  pMostraPrecoLojas;
  pSetFocus(ActiveControl);

end;

procedure TfrmConsultaFatItem.pMostraEstoqueLojas;
begin
  Try
    pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);
    frmFatMostraEstoqueEmp.blnFaturamento := blnFaturamento;    
    frmFatMostraEstoqueEmp.strCodIte    := qryConsulta.FieldByName('Codigo').AsString;
    frmFatMostraEstoqueEmp.strTabPre    := strTabPreco;
    frmFatMostraEstoqueEmp.blnPedCorte  := blnPedCorte;
    frmFatMostraEstoqueEmp.edtItem.Text := qryConsulta.FieldByName('Codigo').AsString + ' - ' +
                                              qryConsulta.FieldByName('Descrição').AsString;
    frmFatMostraEstoqueEmp.blnEstrutura := fItemEstrutura(qryConsulta.FieldByName('Codigo').AsString);
    frmFatMostraEstoqueEmp.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraEstoqueLojas]');
  End;

  pFreeAndNil(frmFatMostraEstoqueEmp);
end;

procedure TfrmConsultaFatItem.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtFiltro1);
end;

procedure TfrmConsultaFatItem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objItemPromo);
  If not blnConfirma Then
    bkmUltAcesso := Nil;
end;

procedure TfrmConsultaFatItem.FormCreate(Sender: TObject);
begin
  inherited;
  blnAtualizaIndice := False;
  strEmprCD := '';
  strEmpSal := '';
  strEmpIte := '';
  blnExiSalDisCD := False;

  objItemPromo := TItemPromo.Create;

  cdsLegendas := TLegendasItem.Create(Self);
  cxgLegendasView.DataController.DataSource := cdsLegendas.dtsSource;
  If Not fCfgSis('SITPRO', varBoolean) Then
    cxgLegendas.Width := cxgLegendasView.Bands[0].Width;

  blnSitPro := False;
  blnEmpFat := fCfgSis('EMPFAT', varBoolean);

  blnMosUltCom  := False;
  blnSoConsulta := False;
  blnPedCorte   := False;

  If (Not fCfgSis('USAPDV', varBoolean)) Then
  Begin
    lblSalRes.Visible := False;
    edtSalRes.Visible := False;
    //dbeSalRes.Visible := False;
  End;

  strMskDecUnitar := fMskDigitos(fCfgSis('DECUNI', varInteger));
  strExibirFornec := 'S';

  blnHabF7 := False;

  procVendasPerdidas := Nil;

  blnUtilizaVendaMadeira := fCfgSis('VENMAD', varBoolean);

end;

procedure TfrmConsultaFatItem.pAtualizaLabelMetragem;
Begin
  lblQtdPec.Caption := 'Qtde.  : ' + FormatFloat('#0.00', fltQtdPec);
  lblComPec.Caption := 'Compri.: ' + FormatFloat('#0.00', fltComPec);
  lblLarPec.Caption := 'Largura: ' + FormatFloat('#0.00', fltLarPec);
  lblEspPec.Caption := 'Espess.: ' + FormatFloat('#0.00', fltEspPec);
End;

procedure TfrmConsultaFatItem.pMostraPrecoBoca;
begin
  {****************************************************}
  {* EXIBE OU NÃO O PREÇO DE BOCA NA TELA DE CONSULTA *}
  {**23/02/2011-15:48*******************************DP*}
  If qryConsulta.FindField('BOCACAIXA') <> Nil Then
    If (qryConsulta.FieldByName('BOCACAIXA').asInteger > 0) Then
    Begin
      edtPrecoBoca.Text := FloatToStrF(qryConsulta.FieldByName('Preço Boca de Caixa').asFloat,ffFixed,12,2);
      edtComBoca.Text   := FloatToStrF(qryConsulta.FieldByName('Comissão Boca de Caixa').asFloat,ffFixed,12,2);

      edtPrecoBoca.Visible := True;
      edtComBoca.Visible   := True;
      lblPreBoca.Visible   := True;
      lblComBoca.Visible   := True;
      lblComBoca.Caption:= 'Comiss. Boca Cx:';
      lblComBoca.Caption := IfThen((fCfgSis('COMBCA', varString) = '%'), '%', 'Valor')+' '+lblComBoca.Caption;

    End Else Begin
      edtPrecoBoca.Visible := False;
      edtComBoca.Visible   := False;
      lblPreBoca.Visible   := False;
      lblComBoca.Visible   := False;
  End;

  tmrFiltro.Enabled := False;
end;

procedure TfrmConsultaFatItem.pResetaTemporizador;
begin
  pEscreveAtualizando;
  tmrFiltro.Enabled := False;
  tmrFiltro.Enabled := True;
end;

procedure TfrmConsultaFatItem.pMostraPrecoPromocional;
  Var
    fltPreCus: Double;
    fltPreVen: Double;
    fltComVar: Double;
    fltComAta: Double;
    fltComDis: Double;
    fltQtdDis: Double;
    blnParticiona: Boolean;
    blnPromo: Boolean;
    fltMinPro : Double;
begin
  fltMinPro := 0;

  If (fRetornaPrecosPromocao(qryConsulta.FieldByName('Codigo').AsString,
                             strCodCli,
                             VS_Date,
                             1,
                             0,
                             intPraMedio,
                             fltPreCus,
                             fltPreVen,
                             fltComVar,
                             fltComAta,
                             fltComDis,
                             fltQtdDis,
                             blnParticiona,
                             blnPromo,
                             strTabPreco,
                             '',
                             '',
                             '',
                             False)) Then
  Begin
//    lblPreCus.Visible := True;
//    dbePreVen.Visible := True;
    edtValPro.Visible := True;
    lblValPro.Visible := True;
    edtValPro.Text    := FloatToStrF(fltPreVen, ffFixed, 12, 2);
    fltMinPro := fQtdPromocao(qryConsulta.FieldByName('Codigo').AsString, VS_strCodEmp, True, strCodCli, strTabPreco);
  End
  Else
  Begin
//    lblPreCus.Visible := False;
//    dbePreVen.Visible := False;
    edtValPro.Visible := False;
    lblValPro.Visible := False;
  End;

  If (edtValPro.Visible) And (fltMinPro > 1) Then
  Begin
    lblMinPro.Visible := True;
    edtMinPro.Visible := True;
    edtMinPro.Text    := FloatToStrF(fltMinPro, ffFixed, 12, 2);
  End
  Else
  Begin
    lblMinPro.Visible := False;
    edtMinPro.Visible := False;
  End;
end;

procedure TfrmConsultaFatItem.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If blnSitPro And (Not qryConsulta.FieldByName('ITE_CORSIT').IsNull) Then
  Begin
    dbgConsulta.Canvas.Font.Color := qryConsulta.FieldByName('ITE_CORSIT').AsInteger;
  End;

  If (qryConsulta.FieldByName('PROMOC').AsInteger > 0) Then
  Begin
    If objItemPromo.fVerificaProdutoPromocao(qryConsulta.FieldByName('CODIGO').AsString, strCodCli, strTabPreco) Then
    Begin
      If (intRecNo <> qryConsulta.RecNo) Then
        dbgConsulta.Canvas.Font.Color := ARRCOR_SITUACAO_ITEM[sitPromocao]
      Else
        dbgConsulta.Canvas.Font.Color := clLime;
    End;
  End;

  {******************************************}
  {* PRODUTOS EM BOCA DE CAIXA, MUDAR A COR *}
  {**23/02/2011-15:12*********************DP*}
  If (qryConsulta.FindField('BOCACAIXA') <> Nil)          And
     (qryConsulta.FieldByName('BOCACAIXA').AsInteger > 0) Then
  Begin
    If (intRecNo <> qryConsulta.RecNo) Then
      dbgConsulta.Canvas.Font.Color := ARRCOR_SITUACAO_ITEM[sitBocaCaixa]
    Else
      dbgConsulta.Canvas.Font.Color := clAqua;
  End;

  If (qryConsulta.FindField('ESTRUT') <> Nil)          And
     (qryConsulta.FieldByName('ESTRUT').AsInteger > 0) Then
  Begin
    If (intRecNo <> qryConsulta.RecNo) Then
      dbgConsulta.Canvas.Font.Color := ARRCOR_SITUACAO_ITEM[sitEstrutura]
    Else
      dbgConsulta.Canvas.Font.Color := clFuchsia;
  End;

  {************************************************************}
  {* COLOCA A FONTE DA COLUNA DOS PREÇOS DE VENDA EM VERMELHO *}
  {*********************************************************JB*}
  If (Pos(Column.FieldName, 'Preço Venda1_Preço Venda2_Preço Venda3_Preço Venda4_Preço Venda5_Preço Venda6_Preço Venda7_' +
                            'Preço Minimo1_Preço Minimo2_Preço Minimo3_Preço Minimo4_Preço Minimo5_Preço Minimo6_Preço Minimo7_') > 0) Then
  Begin
    If (intRecNo = qryConsulta.RecNo) Then
      dbgConsulta.Canvas.Font.Color := clWhite
    Else
      dbgConsulta.Canvas.Font.Color := clRed;
  End

  Else If (qryConsulta.FieldByName('ITE_ITEATI').AsString = 'INATIVO') Then
  Begin
    dbgConsulta.Canvas.Font.Color := ARRCOR_SITUACAO_ITEM[sitInativo];
  End

  Else If (qryConsulta.FindField('Ativo p/ Compra') <> Nil) And
          (qryConsulta.FieldByName('Ativo p/ Compra').AsString = 'INATIVO') Then
  Begin
    dbgConsulta.Canvas.Font.Color := ARRCOR_SITUACAO_ITEM[sitInativoCompra];
  End;

  If (Column.FieldName = 'Saldo') Then
  Begin
    If (intRecNo = qryConsulta.RecNo) Then
      dbgConsulta.Canvas.Font.Color := clWhite
    Else
      dbgConsulta.Canvas.Font.Color := clBlue;
  End;

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmConsultaFatItem.dbgConsultaEnter(Sender: TObject);
begin
  inherited;

  blnJaExecutou := True;
end;

procedure TfrmConsultaFatItem.pRetDadUltCompra(strCodIte: String);
  Var
    qryConTmp : TUniQuery;
    strSQL    : String;

begin

  qryConTmp := fCriaQuery;

  edtDTAULT.Clear;
  edtPREULT.Clear;
  edtFORULT.Clear;
  edtDesForUlt.Clear;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_DTAULT, ';
  strSQL := strSQL + '  ITE_PREULT, ';
  strSQL := strSQL + '  ITE_FORULT, ';
  strSQL := strSQL + '  FOR_NOMFOR ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER, ';
  strSQL := strSQL + '  CADFOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FOR_CODFOR = ITE_FORULT AND ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

  With qryConTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strEmpSal;
    Open;

    If Not( IsEmpty ) Then
    Begin
      edtDTAULT.Text    := FormatDateTime('dd/mm/yyyy', qryConTmp.FieldByName('ITE_DTAULT').AsDateTime);
      edtPREULT.Text    := FormatFloat('#,##0.00', qryConTmp.FieldByName('ITE_PREULT').AsFloat);
      edtFORULT.Text    := qryConTmp.FieldByName('ITE_FORULT').AsString;
      edtDesForUlt.Text := qryConTmp.FieldByName('FOR_NOMFOR').AsString;
    End;

    Close;
  End;

end;


procedure TfrmConsultaFatItem.btnItensVendClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaAcessoSistema('ITEVEN') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso aos Itens Vendidos!', ['&O k']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmRelFatVendasCliente,frmRelFatVendasCliente);

    frmRelFatVendasCliente.blnSenha        := False;
    frmRelFatVendasCliente.blnFaturamento  := False;
    frmRelFatVendasCliente.blnCliCons      := False;
    frmRelFatVendasCliente.blnConsultaItem := True;

    frmRelFatVendasCliente.mskLinhaGrupo.Enabled := False;
    frmRelFatVendasCliente.edtProdutos.Enabled   := False;
    frmRelFatVendasCliente.edtProdutos.Text      := qryConsulta.FieldByName('CODIGO').AsString;
    frmRelFatVendasCliente.edtProdutosExit(frmRelFatVendasCliente.edtProdutos);

    frmRelFatVendasCliente.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnItensVendClick]');
    End;
  End;

  pFreeAndNil(frmRelFatVendasCliente);
end;

procedure TfrmConsultaFatItem.btnItensCompClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaAcessoSistema('ITECMP') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso aos Itens Comprados!', ['&O k']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmRelEstCompForn, frmRelEstCompForn);

    frmRelEstCompForn.blnConsultaItem     := TRUE;
    frmRelEstCompForn.edtProdutos.Enabled := FALSE;
    frmRelEstCompForn.edtProdutos.Text    := qryConsulta.FieldByName('CODIGO').AsString;
    frmRelEstCompForn.edtDesProduto.Text  := qryConsulta.FieldByName('Descrição').AsString;

    frmRelEstCompForn.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pRelEstCompForn]');
    End;
  End;

  pFreeAndNil(frmRelEstCompForn);
end;

procedure TfrmConsultaFatItem.btnPedCompClick(Sender: TObject);
  Var
    varRecEst: TRegistroVarEstoque;
begin
  inherited;

  If Not btnPedComp.Visible Then
    Exit;

  FillChar(varRecEst,SizeOf(varRecEst),#0);
  varRecEst.blnTemParametros := TRUE;
  varRecEst.strCodIte        := ShortString(qryConsulta.FieldByName('CODIGO').AsString);
  pRelatorioEstoquePar(relEstPedCompra,varRecEst);

{  Try
    pCriarFormularios(TfrmRelEstPedCompra, frmRelEstPedCompra);

    frmRelEstPedCompra.edtProdutos.Enabled := False;
    frmRelEstPedCompra.edtProdutos.Text    := qryConsulta.FieldByName('CODIGO').AsString;
    frmRelEstPedCompra.edtProdutosExit(Sender);

    frmRelEstPedCompra.edtTipo.Enabled := False;
    frmRelEstPedCompra.edtTipo.Text    := 'N';

    frmRelEstPedCompra.ShowModal;
  Finally
   pFreeAndNil(frmRelEstPedCompra);
  End; }

end;

procedure TfrmConsultaFatItem.btnEmbalagemClick(Sender: TObject);
Var
   objIteBar: TIteBar;
begin
  inherited;
  Try
    objIteBar := TIteBar.Create(opcConsulta,
                                Nil,
                                Nil,
                                Nil,
                                Nil,
                                Nil,
                                qryConsulta.FieldByName('CODIGO').AsString);
    FreeAndNil(objIteBar);
  Except
    On E: Exception Do
    Begin
      FreeAndNil(objIteBar);
      pMensagensErro(E.Message, '[btnEmbalagemClick]')
    End;
  End;

end;

procedure TfrmConsultaFatItem.btnEntregasPendentesClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmFatEntrFuturaPendente, frmFatEntrFuturaPendente);
    frmFatEntrFuturaPendente.strCodEmp := strEmpSal;
    frmFatEntrFuturaPendente.blnFaturamento := blnFaturamento;    
    frmFatEntrFuturaPendente.strCodIte := qryConsulta.FieldByName('CODIGO').AsString;
    frmFatEntrFuturaPendente.fltSaldos := qryConsulta.FieldByName('ITE_SALDOS').AsFloat;
    frmFatEntrFuturaPendente.Caption   := frmFatEntrFuturaPendente.Caption + ' ' +
                                          qryConsulta.FieldByName('CODIGO').AsString + ' - ' +
                                          qryConsulta.FieldByName('Descrição').AsString;
    frmFatEntrFuturaPendente.ShowModal;
  Finally
    pFreeAndNil(frmFatEntrFuturaPendente);
  End;  

end;

procedure TfrmConsultaFatItem.btnExecutaTarefaClick(Sender: TObject);
begin
  inherited;
  If fVerificaAcessoSistema('VISCUS', strLoginUsuarioLogado) Then
    pMostraComposicaoPrecoCusto(qryConsulta.FieldByName('Codigo').AsString)
  Else
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
end;

procedure TfrmConsultaFatItem.btnExiEstruturaClick(Sender: TObject);
begin
  If Not btnExiEstrutura.Visible Then
    Exit;
    
  TfrmFatEstruturaSubItens.pExibirEstrutura(strEmpSal, qryConsulta.FieldByName('CODIGO').AsString, blnPedCorte);
end;

procedure TfrmConsultaFatItem.btnPedCompGridClick(Sender: TObject);
  Var
    varRecEst: TRegistroVarEstoque;
begin
  inherited;

  FillChar(varRecEst,SizeOf(varRecEst),#0);
  varRecEst.blnTemParametros := TRUE;
  varRecEst.strCodIte        := ShortString(qryConsulta.FieldByName('CODIGO').AsString);
  varRecEst.strDesIte        := ShortString(qryConsulta.FieldByName('Descrição').AsString);
  varRecEst.strExibirFornec  := ShortString(strExibirFornec);
  varRecEst.blnOriConsulPro  := True;
  pRelatorioEstoquePar(relEstPedCompraGrid,varRecEst);

end;

procedure TfrmConsultaFatItem.pMostraComposicaoPrecoCusto(strCodIte: String);
begin

  Try
    pCriarFormularios(TfrmCadProdutosCompCusto, frmCadProdutosCompCusto);
    frmCadprodutosCompCusto.strCodIte := strCodIte;
    frmCadprodutosCompCusto.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmConsultaFatItem.pMostraComposicaoPrecoCusto]');
    End;
  End;
  pFreeAndNil(frmCadprodutosCompCusto);

end;

procedure TfrmConsultaFatItem.btnMetragemClick(Sender: TObject);
  Var
    fltComPecP, fltLarPecP, fltEspPecP, fltQtdPecP : Double;
begin
  inherited;
  If Not btnMetragem.Visible Then
    Exit;

  fltComPecP := 1.00;
  fltLarPecP := 1.00;
  fltEspPecP := 1.00;
  fltQtdPecP := 1.00;

  fltQtdMt3 := TfrmGetMetragem.fGetQuantidadeTotal(dbePreVen.Field.AsFloat, fltComPecP, fltLarPecP, fltEspPecP, fltQtdPecP);

  fltComPec := fltComPecP;
  fltLarPec := fltLarPecP;
  fltEspPec := fltEspPecP;
  fltQtdPec := fltQtdPecP;

end;

procedure TfrmConsultaFatItem.btnAmpliarClick(Sender: TObject);
begin
  inherited;
  pAmpliaFoto;
end;

procedure TfrmConsultaFatItem.btnConfirmaClick(Sender: TObject);
  Var
    strSQL: String;
begin
//  inherited;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + strNomTabela + '.* ';

  If qryConsulta.FindField('BAR_CODBAR') <> Nil Then
  Begin
    strSQL := strSQL + ' , BAR_CODBAR ';
    strSQL := strSQL + ' , BAR_EMBALA ';
    strSQL := strSQL + ' , BAR_PREVEN ';
    strSQL := strSQL + ' , BAR_DESCRI ';
    strSQL := strSQL + ' , BAR_TABPRE ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + strNomTabela;

  If qryConsulta.FindField('BAR_CODBAR') <> Nil Then
    strSQL := strSQL + ' LEFT JOIN ITEBAR ON FALSE ';

  strSQL := strSQL + ' WHERE ';
  If(qryConsulta.IsEmpty) Then
    strSQL := strSQL + ' FALSE '
  Else
  Begin
    If (copy(strNomeForm,1,12) = 'frmFatVendas') And (blnEnterSim) Then
      strSQL := strSQL + ' ' + strNomTabela + '.AUTOINCREM = ' + QuotedStr(strAutIncSim)
    Else
      strSQL := strSQL + ' ' + strNomTabela + '.AUTOINCREM = ' + QuotedStr(qryConsulta.FieldByName('AUTOINCREM').AsString);
  End;

  bkmUltAcesso := qryConsulta.GetBookMark;

  With qryTabConsulta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

  blnConfirma := qryTabConsulta.RecordCount > 0;

  If Not blnSoConsulta Then
    Close;

end;

procedure TfrmConsultaFatItem.btnSemelhantesClick(Sender: TObject);
begin
  inherited;

  If btnSemelhantes.Visible Then
  Begin
    pMostraSemelhante(qryConsulta.FieldByName('Codigo').AsString);
  End;

  pSetFocus(ActiveControl);

end;

procedure TfrmConsultaFatItem.btnSepIteClick(Sender: TObject);
begin
  pImprimeSeparacaoItem;
end;

procedure TfrmConsultaFatItem.btnLotIteClick(Sender: TObject);
begin
  inherited;

  pCriarFormularios(TfrmCadLotesConsulta, frmCadLotesConsulta);

  If Assigned(frmCadLotesConsulta) Then
  Begin
    frmCadLotesConsulta.strCodIte := qryConsulta.FieldByName('Codigo').AsString;
    frmCadLotesConsulta.ShowModal;
    FreeAndNil(frmCadLotesConsulta);
  End;

end;

procedure TfrmConsultaFatItem.btnSalvarLayoutClick(Sender: TObject);
begin
  inherited;
  If Not btnSalvarLayout.Visible Then
    Exit;

  If Not fVerificaAcessoSistema('SARELAY') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso a Salvar Layout da Consulta!', ['&O k']);
    Exit;
  End;

  If fMensagem('ATENÇÃO!', 'Deseja realmente salvar o layout da consulta?', ['&Sim', '&Não']) = 1 Then
    pSalvaColunasGridBco(dbgConsulta, strChaveLayout);
end;

procedure TfrmConsultaFatItem.btnRestaurarLayoutClick(Sender: TObject);
begin
  inherited;
  If Not btnRestaurarLayout.Visible Then
    Exit;

  If Not fVerificaAcessoSistema('SARELAY') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso a Restaurar Layout da Consulta!', ['&O k']);
    Exit;
  End;

  If fMensagem('ATENÇÃO!', 'Confirma restaurar o layout padrão da consulta?', ['&Sim', '&Não'], 2) = 1 Then
  Begin
    pApagarColumnasGridBco(strChaveLayout);
    Try
      pCarregaColunasGridBco(dbgConsulta, strChaveLayout);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[CarregarLayoutConsulta]');
    End;
    lstIndicesClick(lstIndices);
  End;
end;

procedure TfrmConsultaFatItem.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Not blnSoConsulta Then
    inherited;
end;

procedure TfrmConsultaFatItem.pImprimeSeparacaoItem;
Begin
  TfrmControleSepAvulsa.pImprimeSeparacaoItem(qryConsulta.FieldByName('Codigo').AsString,
                                              qryConsulta.FieldByName('Descrição').AsString,
                                              AnsiReplaceStr(qryConsulta.FieldByName('Loc. Fisica').AsString, ',', #13#10),
                                              qryConsulta.FieldByName('Unid.').AsString,
                                              qryConsulta.FieldByName('Cód. Fábrica').AsString,
                                              strCodCli,
                                              strCodVen,
                                              strCodDig,
                                              dbePreVen.Field.AsFloat);

End;

End.
