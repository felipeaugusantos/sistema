unit untConfiguracoesWandaPro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, StrUtils, MaskEditFocus, FilenameEditFocus,
  AppEvnts, QColorLabel, Uni, ComCtrls, untConfConsulta,
  untIConfTinta, untIConsultaTinta,  BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untConfEmbColorPro, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesWandaPro = class(TfrmPai)
    pnlCabecalho: TPanel;
    pgcGeral: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    pnlCentral: TPanel;
    Label17: TLabel;
    Label9: TLabel;
    Label20: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    ColorLabel4: TColorLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    chkUsaWan: TCheckBox;
    edtTraWan: TEditFocus;
    edtFatWan: TEditFocus;
    edtTrdWan: TEditFocus;
    edtFadWan: TEditFocus;
    mskLinWan: TMaskEditFocus;
    edtLd1Wan: TEditFocus;
    edtBd1Wan: TEditFocus;
    edtFveWan: TEditFocus;
    edtLd1Abs_100_50: TEditFocus;
    edtBd1Abs_100_50: TEditFocus;
    edtLd1Abs_100_80: TEditFocus;
    edtBd1Abs_100_80: TEditFocus;
    edtLd1PU_MS: TEditFocus;
    edtBd1PU_MS: TEditFocus;
    edtLd1PU_HS: TEditFocus;
    edtBd1PU_HS: TEditFocus;
    chkUsaFor: TCheckBox;
    edtNfmPro: TEditFocus;
    edtAcuAbs: TEditFocus;
    edtLd1_BT120: TEditFocus;
    edtBd1_BT120: TEditFocus;
    edtLd1_BT90: TEditFocus;
    edtBd1_BT90: TEditFocus;
    edtLd1_BT80: TEditFocus;
    edtBd1_BT80: TEditFocus;
    edtLd1_BT100: TEditFocus;
    edtBd1_BT100: TEditFocus;
    tbsEmbalagens: TTabSheet;
    Label6: TLabel;
    Label10: TLabel;
    Label7: TLabel;
    edtDesProWan: TEditFocus;
    edtProWan: TEditFocus;
    edtGalWan: TEditFocus;
    edtEmbWan: TEditFocus;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label37: TLabel;
    edtDesOpe: TEditFocus;
    Label38: TLabel;
    edtApreve: TEditFocus;
    fraPatWan: TfraDirectoryEditFocus;
    GroupBox5: TGroupBox;
    lblWanIco: TLabel;
    lblWanIsp: TLabel;
    lblWanIss: TLabel;
    edtDesWanIco: TEditFocus;
    edtDesWanIsp: TEditFocus;
    edtWanIco: TEditFocus;
    edtWanIsp: TEditFocus;
    edtWanIss: TEditFocus;
    edtDesWanIss: TEditFocus;
    Label46: TLabel;
    Label47: TLabel;
    edtLPAPB_10080: TEditFocus;
    edtBPAPB_10080: TEditFocus;
    Label52: TLabel;
    edtLD1ABS_BASELINE: TEditFocus;
    edtBD1ABS_BASELINE: TEditFocus;
    Label48: TLabel;
    pnlEmbalagens: TPanel;
    pgcEmbColorPro: TPageControl;
    procedure FormShow(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure edtProWanKeyPress(Sender: TObject; var Key: Char);
    procedure chkVendaDinamicaClick(Sender: TObject);
    procedure edtLd1WanKeyPress(Sender: TObject; var Key: Char);
    procedure edtLd1Abs_100_50KeyPress(Sender: TObject; var Key: Char);
    procedure edtLd1Abs_100_80KeyPress(Sender: TObject; var Key: Char);
    procedure edtLd1PU_MSKeyPress(Sender: TObject; var Key: Char);
    procedure edtLd1PU_HSKeyPress(Sender: TObject; var Key: Char);
//    procedure edtLd1_AbsBaselineKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinWanDblClick(Sender: TObject);
    procedure pgcGeralChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRestaurarClick(Sender: TObject);
    procedure edtLd1_BT80KeyPress(Sender: TObject; var Key: Char);
    procedure edtLd1_BT100KeyPress(Sender: TObject; var Key: Char);
    procedure edtLd1_BT90KeyPress(Sender: TObject; var Key: Char);
    procedure edtLd1_BT120KeyPress(Sender: TObject; var Key: Char);
    procedure edtLPAPB_10080KeyPress(Sender: TObject; var Key: Char);
    procedure edtLD1ABS_BASELINEKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    frmConfConsultaWandaPro: TfrmConfConsulta;
    frmConfConsultaWandaProEmb: TfrmConfEmbColorPro;
    tinta: IConsultaTinta;
    conf: IConfTinta;

    qryCadIte: TUniQuery;
    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pRetornaDescricaoItem(edtCodIte : TEdit; edtDesIte : TEditFocus );
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmConfiguracoesWandaPro: TfrmConfiguracoesWandaPro;

implementation

uses
     untFuncTinta,untFuncoesSimples, untConfiguracoesWandaProLinhas, MaskUtils, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmConfiguracoesWandaPro }

procedure TfrmConfiguracoesWandaPro.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA WANDA                *}
  {**************************************MV*}

  chkUsaWan.Checked        := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked        := conf.fGetBoolean('USAFOR'); //WCP

  edtProWan.Text := conf.fGet('PROWAN');

  If Not fEmptyStr(edtProWan.Text) Then
    edtDesProWan.Text := fRetNomProduto(edtProWan.Text);

  edtEmbWan.Text := conf.fGet('EMBWAN');
{  edtWanIem.Text := conf.fGet('WANIEM');

  If Not fEmptyStr(edtWanIem.Text) Then
    edtDesWanIem.Text := fRetNomProduto(edtWanIem.Text);}

  edtGalWan.Text := conf.fGet('GALWAN');
{  edtWanIgl.Text := conf.fGet('WANIGL');

  If Not fEmptyStr(edtWanIgl.Text) Then
    edtDesWanIgl.Text := fRetNomProduto(edtWanIgl.Text);}

{  edtWanIla.Text := conf.fGet('WANILA');

  If Not fEmptyStr(edtWanIla.Text) Then
    edtDesWanIla.Text := fRetNomProduto(edtWanIla.Text);}

  {AUTOWAVE MM }

{  edtMmsilt.Text := conf.fGet('MMSILT');

  If Not fEmptyStr(edtMmsilt.Text) Then
    edtDesMmLt.Text := fRetNomProduto(edtMmsilt.Text);

  edtMmsigl.Text := conf.fGet('MMSIGL');

  If Not fEmptyStr(edtMmsigl.Text) Then
    edtDesMmGl.Text := fRetNomProduto(edtMmsigl.Text);

  edtMmsila.Text := conf.fGet('MMSILA');

  If Not fEmptyStr(edtMmsila.Text) Then
    edtDesMmLa.Text := fRetNomProduto(edtMmsila.Text);}

  {AUTOCOAT BT100}

{  edtBtsilt.Text := conf.fGet('BTSILT');

  If Not fEmptyStr(edtBtsilt.Text) Then
    edtDesBtLt.Text := fRetNomProduto(edtBtsilt.Text);

  edtBtsigl.Text := conf.fGet('BTSIGL');

  If Not fEmptyStr(edtBtsigl.Text) Then
    edtDesBtgl.Text := fRetNomProduto(edtBtsigl.Text);

  edtBtsila.Text := conf.fGet('BTSILA');

  If Not fEmptyStr(edtBtsila.Text) Then
    edtDesBtla.Text := fRetNomProduto(edtBtsila.Text);}

  {AUTOBASE PLUS 100:50}

{  edtAupllt.Text := conf.fGet('PLSILT');

  If Not fEmptyStr(edtAupllt.Text) Then
    edtDesPlLt.Text := fRetNomProduto(edtAupllt.Text);

  edtAuplgl.Text := conf.fGet('PLSIGL');

  If Not fEmptyStr(edtAuplgl.Text) Then
    edtDesPlGl.Text := fRetNomProduto(edtAuplgl.Text);

  edtAuplla.Text := conf.fGet('PLSILA');

  If Not fEmptyStr(edtAuplla.Text) Then
    edtDesPlLa.Text := fRetNomProduto(edtAuplla.Text);}

  {FIM}

  edtWanIco.Text := conf.fGet('WANICO');

  If Not fEmptyStr(edtWanIco.Text) Then
    edtDesWanIco.Text := fRetNomProduto(edtWanIco.Text);

  edtWanIsp.Text := conf.fGet('WANISP');

  If Not fEmptyStr(edtWanIsp.Text) Then
    edtDesWanIsp.Text := fRetNomProduto(edtWanIsp.Text);

  edtWanIss.Text := conf.fGet('WANISS');

  If Not fEmptyStr(edtWanIss.Text) Then
    edtDesWanIss.Text := fRetNomProduto(edtWanIss.Text);

  edtFveWan.Text          := conf.fGet('FVEWAN');
  edtTraWan.Text          := conf.fGet('TRAWAN');
  edtFatWan.Text          := conf.fGet('FATWAN');
  edtTrdWan.Text          := conf.fGet('TRDWAN');
  edtFadWan.Text          := conf.fGet('FADWAN');
  mskLinWan.Text          := conf.fGet('LINWAN');
  edtLd1Wan.Text          := conf.fGet('LD1WAN');
  edtBd1Wan.Text          := conf.fGet('BD1WAN');
  edtLd1Abs_100_50.Text   := conf.fGet('LD1ABS_100_50');
  edtBd1Abs_100_50.Text   := conf.fGet('BD1ABS_100_50');
  edtLd1Abs_100_80.Text   := conf.fGet('LD1ABS_100_80');
  edtBd1Abs_100_80.Text   := conf.fGet('BD1ABS_100_80');
  edtLd1PU_MS.Text        := conf.fGet('LD1PU_MS');
  edtBd1PU_MS.Text        := conf.fGet('BD1PU_MS');
  edtLd1PU_HS.Text        := conf.fGet('LD1PU_HS');
  edtBd1PU_HS.Text        := conf.fGet('BD1PU_HS');
//  edtLd1_AbsBaseLine.Text := conf.fGet('LD1ABS_BASELINE');
//  edtBd1_AbsBaseLine.Text := conf.fGet('BD1ABS_BASELINE');
  edtLd1_BT120.Text       := conf.fGet('LD1BT120');
  edtBd1_BT120.Text       := conf.fGet('BD1BT120');
  edtLd1_BT90.Text        := conf.fGet('LD1BT90');
  edtBd1_BT90.Text        := conf.fGet('BD1BT90');
  edtLd1_BT80.Text        := conf.fGet('LD1BT80');
  edtBd1_BT80.Text        := conf.fGet('BD1BT80');
  edtLd1_BT100.Text       := conf.fGet('LD1BT100');
  edtBd1_BT100.Text       := conf.fGet('BD1BT100');
  edtLPAPB_10080.Text     := conf.fGet('LPAPB_10080');
  edtBPAPB_10080.Text     := conf.fGet('BPAPB_10080');
  edtLD1ABS_BASELINE.Text := conf.fGet('LD1ABS_BASELINE');
  edtBD1ABS_BASELINE.Text := conf.fGet('BD1ABS_BASELINE');
  fraPatWan.edtDirectory.text          := conf.fGet('PATWAN');
  edtNfmPro.Text          := conf.fGet('NFMPRO');
  edtAcuAbs.Text          := conf.fGet('ACUABS');
  edtDesOpe.Text          := conf.fGet('DESOPE');
  edtApreve.Text          := conf.fGet('APREVE');

end;

procedure TfrmConfiguracoesWandaPro.pGravaArqIni;
{  Var
    strUsaTin: String;
    strUsaFor: String;
    strVenDin: String;}
begin
  {*****************************************}
  {* GRAVA DADOS DA WANDA                  *}
  {**************************************MV*}


  conf.pSetBoolean('USATIN', chkUsaWan.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked); //WCP
  conf.pSet('PROWAN', edtProWan.Text);
  conf.pSet('EMBWAN', edtEmbWan.Text);
//  conf.pSet('WANIEM', edtWanIem.Text);
  conf.pSet('GALWAN', edtGalWan.Text);
//  conf.pSet('WANIGL', edtWanIgl.Text);
//  conf.pSet('WANILA', edtWanIla.Text);

  {AUTOWAVE MM}
{  conf.pSet('MMSILT', edtMmsilt.Text);
  conf.pSet('MMSIGL', edtMmsigl.Text);
  conf.pSet('MMSILA', edtMmsila.Text);}

  {AUTOCOAT BT100}
{  conf.pSet('BTSILT', edtBtsilt.Text);
  conf.pSet('BTSIGL', edtBtsigl.Text);
  conf.pSet('BTSILA', edtBtsila.Text);}

  {AUTOBASE PLUS 100:50}
{  conf.pSet('PLSILT', edtAupllt.Text);
  conf.pSet('PLSIGL', edtAuplgl.Text);
  conf.pSet('PLSILA', edtAuplla.Text);}

  conf.pSet('WANICO', edtWanIco.Text);
  conf.pSet('WANISP', edtWanIsp.Text);
  conf.pSet('WANISS', edtWanIss.Text);

  conf.pSet('FVEWAN', edtFveWan.Text);
  conf.pSet('TRAWAN', edtTraWan.Text);
  conf.pSet('FATWAN', edtFatWan.Text);
  conf.pSet('TRDWAN', edtTrdWan.Text);
  conf.pSet('FADWAN', edtFadWan.Text);
  conf.pSet('LINWAN', mskLinWan.Text);

  conf.pSet('LD1WAN', edtLd1Wan.Text);
  conf.pSet('BD1WAN', edtBd1Wan.Text);
  conf.pSet('LD1ABS_100_50', edtLd1Abs_100_50.Text);
  conf.pSet('BD1ABS_100_50', edtBd1Abs_100_50.Text);
  conf.pSet('LD1ABS_100_80', edtLd1Abs_100_80.Text);
  conf.pSet('BD1ABS_100_80', edtBd1Abs_100_80.Text);
  conf.pSet('LD1PU_MS', edtLd1PU_MS.Text);
  conf.pSet('BD1PU_MS', edtBd1PU_MS.Text);
  conf.pSet('LD1PU_HS', edtLd1PU_HS.Text);
  conf.pSet('BD1PU_HS', edtBd1PU_HS.Text);
  conf.pSet('LD1BT120', edtLd1_BT120.Text);
  conf.pSet('BD1BT120', edtBd1_BT120.Text);
  conf.pSet('LD1BT90', edtLd1_BT90.Text);
  conf.pSet('BD1BT90', edtBd1_BT90.Text);
  conf.pSet('LD1BT80', edtLd1_BT80.Text);
  conf.pSet('BD1BT80', edtBd1_BT80.Text);
  conf.pSet('LD1BT100', edtLd1_BT100.Text);
  conf.pSet('BD1BT100', edtBd1_BT100.Text);
  conf.pSet('BPAPB_10080', edtBPAPB_10080.Text);
  conf.pSet('LPAPB_10080', edtLPAPB_10080.Text);
  conf.pSet('BD1ABS_BASELINE', edtBD1ABS_BASELINE.Text);
  conf.pSet('LD1ABS_BASELINE', edtLD1ABS_BASELINE.Text);
  conf.pSet('PATWAN', fraPatWan.edtDirectory.text);

  conf.pSet('NFMPRO', edtNfmPro.Text);
  conf.pSet('ACUABS', edtAcuAbs.Text);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaWandaPro.pSalvarConfs;
  frmConfConsultaWandaProEmb.pSalvarEmbalagens;
{
  If chkUsaWan.Checked Then
    strUsaTin := 'S'
  Else
    strUsaTin := 'N';

  strUsaFor := IIF(chkUsaFor.Checked, 'S', 'N');
  strVenDin := IIF(chkVendaDinamica.Checked, 'S', 'N');
  fArqIniTinta(1, 'USA_FORMUL', 'WCP', strUsaFor);

  fArqIniTinta(1, 'COLOR PRO', 'USATIN', strUsaTin);

  fArqIniTinta(1, 'COLOR PRO', 'PROWAN', edtProWan.Text);
  fArqIniTinta(1, 'COLOR PRO', 'EMBWAN', edtEmbWan.Text);
  fArqIniTinta(1, 'COLOR PRO', 'WANIEM', edtWanIem.Text);
  fArqIniTinta(1, 'COLOR PRO', 'GALWAN', edtGalWan.Text);
  fArqIniTinta(1, 'COLOR PRO', 'WANIGL', edtWanIgl.Text);

  fArqIniTinta(1, 'COLOR PRO', 'WANICO', edtWanIco.Text);
  fArqIniTinta(1, 'COLOR PRO', 'WANISP', edtWanIsp.Text);
  fArqIniTinta(1, 'COLOR PRO', 'WANISS', edtWanIss.Text);

  fArqIniTinta(1, 'COLOR PRO', 'FVEWAN', edtFveWan.Text);
  fArqIniTinta(1, 'COLOR PRO', 'TRAWAN', edtTraWan.Text);
  fArqIniTinta(1, 'COLOR PRO', 'FATWAN', edtFatWan.Text);
  fArqIniTinta(1, 'COLOR PRO', 'TRDWAN', edtTrdWan.Text);
  fArqIniTinta(1, 'COLOR PRO', 'FADWAN', edtFadWan.Text);
  fArqIniTinta(1, 'COLOR PRO', 'LINWAN', mskLinWan.Text);

  fArqIniTinta(1, 'COLOR PRO', 'LD1WAN', edtLd1Wan.Text);
  fArqIniTinta(1, 'COLOR PRO', 'BD1WAN', edtBd1Wan.Text);
  fArqIniTinta(1, 'COLOR PRO', 'LD1ABS_100_50', edtLd1Abs_100_50.Text);
  fArqIniTinta(1, 'COLOR PRO', 'BD1ABS_100_50', edtBd1Abs_100_50.Text);
  fArqIniTinta(1, 'COLOR PRO', 'LD1ABS_100_80', edtLd1Abs_100_80.Text);
  fArqIniTinta(1, 'COLOR PRO', 'BD1ABS_100_80', edtBd1Abs_100_80.Text);
  fArqIniTinta(1, 'COLOR PRO', 'LD1PU_MS', edtLd1PU_MS.Text);
  fArqIniTinta(1, 'COLOR PRO', 'BD1PU_MS', edtBd1PU_MS.Text);
  fArqIniTinta(1, 'COLOR PRO', 'LD1PU_HS', edtLd1PU_HS.Text);
  fArqIniTinta(1, 'COLOR PRO', 'BD1PU_HS', edtBd1PU_HS.Text);
  fArqIniTinta(1, 'COLOR PRO', 'LD1ABS_BASELINE', edtLd1_AbsBaseLine.Text);
  fArqIniTinta(1, 'COLOR PRO', 'BD1ABS_BASELINE', edtBd1_AbsBaseLine.Text);
  fArqIniTinta(1, 'COLOR PRO', 'LD1BT120', edtLd1_BT120.Text);
  fArqIniTinta(1, 'COLOR PRO', 'BD1BT120', edtBd1_BT120.Text);
  fArqIniTinta(1, 'COLOR PRO', 'LD1BT90', edtLd1_BT90.Text);
  fArqIniTinta(1, 'COLOR PRO', 'BD1BT90', edtBd1_BT90.Text);
  fArqIniTinta(1, 'COLOR PRO', 'LD1BT80', edtLd1_BT80.Text);
  fArqIniTinta(1, 'COLOR PRO', 'BD1BT80', edtBd1_BT80.Text);
  fArqIniTinta(1, 'COLOR PRO', 'LD1BT100', edtLd1_BT100.Text);
  fArqIniTinta(1, 'COLOR PRO', 'BD1BT100', edtBd1_BT100.Text);

  fArqIniTinta(1, 'COLOR PRO', 'PATWAN', fraPatWan.edtDirectory.text);

  fArqIniTinta(1, 'COLOR PRO', 'NFMPRO', edtNfmPro.Text);
  fArqIniTinta(1, 'COLOR PRO', 'ACUABS', edtAcuAbs.Text);
}

end;

procedure TfrmConfiguracoesWandaPro.pRetornaDescricaoItem(edtCodIte : TEdit; edtDesIte : TEditFocus);
//  Var
//    strNomEdt: String;
//    edtDesIte: TEdit;
begin
//  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 6);
  //edtDesIte := TEdit(fComponentByName(tbsEmbalagens, strNomEdt));

  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesWandaPro.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  if fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesWandaPro.pgcGeralChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcGeral.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesWandaPro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmConfConsultaWandaPro.Free;
  frmConfConsultaWandaProEmb.Free;
end;

procedure TfrmConfiguracoesWandaPro.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('WCP');
  tinta := fGetConsultaTinta('WCP');

  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', fArqIniTinta(0, 'USA_FORMUL', 'WCP', ''));
  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'COLOR PRO', 'USATIN', ''));
  conf.pInsereCodigo('PROWAN', 'Produto de venda', fArqIniTinta(0, 'COLOR PRO', 'PROWAN', ''));
  conf.pInsereCodigo('EMBWAN', 'Preço de embalagem (LT)', fArqIniTinta(0, 'COLOR PRO', 'EMBWAN', ''));
  conf.pInsereCodigo('GALWAN', 'Preço de galão', fArqIniTinta(0, 'COLOR PRO', 'GALWAN', ''));

  //********* EMBALAGENS ********//

  //PADRAO

  conf.pInsereCodigo('WANIEM', 'Item emb. (LT)', fArqIniTinta(0, 'COLOR PRO', 'WANIEM', ''));
  conf.pInsereCodigo('WANIGL', 'Item emb. (GL)', fArqIniTinta(0, 'COLOR PRO', 'WANIGL', ''));
  conf.pInsereCodigo('WANILA', 'Item emb. (LA)', fArqIniTinta(0, 'COLOR PRO', 'WANILA', ''));

  // JA EXISTIAM

  conf.pInsereCodigo('MMSILT', 'ITEM EMB. AUTOWAVE MM - SIKKENS(LT)' , conf.fGet('WANIEM'));
  conf.pInsereCodigo('MMSIGL', 'ITEM EMB. AUTOWAVE MM - SIKKENS(GL)' , conf.fGet('WANIGL'));
  conf.pInsereCodigo('MMSILA', 'ITEM EMB. AUTOWAVE MM - SIKKENS(LA)' , conf.fGet('WANILA'));

  conf.pInsereCodigo('BTSILT', 'ITEM EMB. AUTOCOAT BT100 - SIKKENS(LT)' , conf.fGet('WANIEM'));
  conf.pInsereCodigo('BTSIGL', 'ITEM EMB. AUTOCOAT BT100 - SIKKENS(GL)' , conf.fGet('WANIGL'));
  conf.pInsereCodigo('BTSILA', 'ITEM EMB. AUTOCOAT BT100 - SIKKENS(LA)' , conf.fGet('WANILA'));

  conf.pInsereCodigo('PLSILT', 'ITEM EMB. AUTOBASE PLUS 100:50 - SIKKENS(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('PLSIGL', 'ITEM EMB. AUTOBASE PLUS 100:50 - SIKKENS(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('PLSILA', 'ITEM EMB. AUTOBASE PLUS 100:50 - SIKKENS(LA)', conf.fGet('WANILA'));

  // NOVAS

  conf.pInsereCodigo('WAHSLT', 'ITEM EMB. WANDABASE HS(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('WAHSGL', 'ITEM EMB. WANDABASE HS(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('WAHSLA', 'ITEM EMB. WANDABASE HS(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('WALALT', 'ITEM EMB. WANDALAC(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('WALAGL', 'ITEM EMB. WANDALAC(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('WALALA', 'ITEM EMB. WANDALAC(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('PUHSLT', 'ITEM EMB. WANDA PU HS(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('PUHSGL', 'ITEM EMB. WANDA PU HS(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('PUHSLA', 'ITEM EMB. WANDA PU HS(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('WCARLT', 'ITEM EMB. WANDACAR(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('WCARGL', 'ITEM EMB. WANDACAR(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('WCARLA', 'ITEM EMB. WANDACAR(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('SISTLT', 'ITEM EMB. SINGLE STAGE CONVERTER(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('SISTGL', 'ITEM EMB. SINGLE STAGE CONVERTER(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('SISTLA', 'ITEM EMB. SINGLE STAGE CONVERTER(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('PLBALT', 'ITEM EMB. AUTOBASE PLUS BASELINE 100:80(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('PLBAGL', 'ITEM EMB. AUTOBASE PLUS BASELINE 100:80(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('PLBALA', 'ITEM EMB. AUTOBASE PLUS BASELINE 100:80(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('PLAULT', 'ITEM EMB. AUTOBASE PLUS 100:80(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('PLAUGL', 'ITEM EMB. AUTOBASE PLUS 100:80(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('PLAULA', 'ITEM EMB. AUTOBASE PLUS 100:80(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('BT11LT', 'ITEM EMB. AUTOCOAT BT110(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('BT11GL', 'ITEM EMB. AUTOCOAT BT110(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('BT11LA', 'ITEM EMB. AUTOCOAT BT110(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('BT12LT', 'ITEM EMB. AUTOCOAT BT120(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('BT12GL', 'ITEM EMB. AUTOCOAT BT120(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('BT12LA', 'ITEM EMB. AUTOCOAT BT120(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('BT13LT', 'ITEM EMB. AUTOCOAT BT130(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('BT13GL', 'ITEM EMB. AUTOCOAT BT130(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('BT13LA', 'ITEM EMB. AUTOCOAT BT130(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('PLBLLT', 'ITEM EMB. AUTOBASE PLUS BASELINE 100:50(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('PLBLGL', 'ITEM EMB. AUTOBASE PLUS BASELINE 100:50(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('PLBLLA', 'ITEM EMB. AUTOBASE PLUS BASELINE 100:50(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('PUMSLT', 'ITEM EMB. WANDA PU MS(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('PUMSGL', 'ITEM EMB. WANDA PU MS(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('PUMSLA', 'ITEM EMB. WANDA PU MS(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('BT90LT', 'ITEM EMB. AUTOCOAT BT90(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('BT90GL', 'ITEM EMB. AUTOCOAT BT90(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('BT90LA', 'ITEM EMB. AUTOCOAT BT90(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('TFPULT', 'ITEM EMB. TECH FLEET PU(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('TFPUGL', 'ITEM EMB. TECH FLEET PU(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('TFPULA', 'ITEM EMB. TECH FLEET PU(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('TFEPLT', 'ITEM EMB. TECH FLEET EPOXY(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('TFEPGL', 'ITEM EMB. TECH FLEET EPOXY(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('TFEPLA', 'ITEM EMB. TECH FLEET EPOXY(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('TFSILT', 'ITEM EMB. TECH FLEET SINTETICO(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('TFSIGL', 'ITEM EMB. TECH FLEET SINTETICO(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('TFSILA', 'ITEM EMB. TECH FLEET SINTETICO(LA)', conf.fGet('WANILA'));

  conf.pInsereCodigo('TFLALT', 'ITEM EMB. TECH FLEET LACA(LT)', conf.fGet('WANIEM'));
  conf.pInsereCodigo('TFLAGL', 'ITEM EMB. TECH FLEET LACA(GL)', conf.fGet('WANIGL'));
  conf.pInsereCodigo('TFLALA', 'ITEM EMB. TECH FLEET LACA(LA)', conf.fGet('WANILA'));

  // EMBALAGENS AUXILIARES

  conf.pInsereCodigo('WANICO', 'Item emb. para Copo', fArqIniTinta(0, 'COLOR PRO', 'WANICO', ''));
  conf.pInsereCodigo('WANISP', 'Item emb. para Spray', fArqIniTinta(0, 'COLOR PRO', 'WANISP', ''));
  conf.pInsereCodigo('WANISS', 'Item emb. para Spray Sintético', fArqIniTinta(0, 'COLOR PRO', 'WANISS', ''));

  //********* EMBALAGENS ********//

  conf.pInsereCodigo('FVEWAN', 'Fator para geração de preço de venda', fArqIniTinta(0, 'COLOR PRO', 'FVEWAN', ''));
  conf.pInsereCodigo('TRAWAN', 'Trava p/ valor de venda concentrado WAN_CON', fArqIniTinta(0, 'COLOR PRO', 'TRAWAN', ''));
  conf.pInsereCodigo('FATWAN', 'Fator', fArqIniTinta(0, 'COLOR PRO', 'FATWAN', ''));
  conf.pInsereCodigo('TRDWAN', 'Trava p/ valor de venda diluido WAN_DIL', fArqIniTinta(0, 'COLOR PRO', 'TRDWAN', ''));
  conf.pInsereCodigo('FADWAN', 'Fator', fArqIniTinta(0, 'COLOR PRO', 'FADWAN', ''));
  conf.pInsereCodigo('LINWAN', 'Linhas para utilização (duplo clique para alterar)', fArqIniTinta(0, 'COLOR PRO', 'LINWAN', ''));
  conf.pInsereCodigo('LD1WAN', 'Linha / Base para preço diluído Wandabase HS', fArqIniTinta(0, 'COLOR PRO', 'LD1WAN', ''));
  conf.pInsereCodigo('BD1WAN', 'Base', fArqIniTinta(0, 'COLOR PRO', 'BD1WAN', ''));
  conf.pInsereCodigo('LD1ABS_100_50', 'Linha / Base para preço diluído Autobase 100:50', fArqIniTinta(0, 'COLOR PRO', 'LD1ABS_100_50', ''));
  conf.pInsereCodigo('BD1ABS_100_50', 'Base', fArqIniTinta(0, 'COLOR PRO', 'BD1ABS_100_50', ''));
  conf.pInsereCodigo('LD1ABS_100_80', 'Linha / Base para preço diluído Autobase 100:80', fArqIniTinta(0, 'COLOR PRO', 'LD1ABS_100_80', ''));
  conf.pInsereCodigo('BD1ABS_100_80', 'Base', fArqIniTinta(0, 'COLOR PRO', 'BD1ABS_100_80', ''));
  conf.pInsereCodigo('LD1PU_MS', 'Linha / Base para preço diluído Wanda PU MS', fArqIniTinta(0, 'COLOR PRO', 'LD1PU_MS', ''));
  conf.pInsereCodigo('BD1PU_MS', 'Base', fArqIniTinta(0, 'COLOR PRO', 'BD1PU_MS', ''));
  conf.pInsereCodigo('LD1PU_HS', 'Linha / Base para preço diluído Wanda PU HS', fArqIniTinta(0, 'COLOR PRO', 'LD1PU_HS', ''));
  conf.pInsereCodigo('BD1PU_HS', 'Base', fArqIniTinta(0, 'COLOR PRO', 'BD1PU_HS', ''));
  conf.pInsereCodigo('LD1ABS_BASELINE', 'Linha / Base para preço diluído Autobase Plus Baseline 100:50', fArqIniTinta(0, 'COLOR PRO', 'LD1ABS_BASELINE', ''));
  conf.pInsereCodigo('BD1ABS_BASELINE', 'Base', fArqIniTinta(0, 'COLOR PRO', 'BD1ABS_BASELINE', ''));
  conf.pInsereCodigo('LPAPB_10080', 'Linha / Base para preço diluído Autobase Plus Baseline 100:80', fArqIniTinta(0, 'COLOR PRO', 'LPAPB_10080', ''));
  conf.pInsereCodigo('BPAPB_10080', 'Base', fArqIniTinta(0, 'COLOR PRO', 'BPAPB_10080', ''));
  conf.pInsereCodigo('LD1BT120', 'Linha / Base para preço diluído BT120', fArqIniTinta(0, 'COLOR PRO', 'LD1BT120', ''));
  conf.pInsereCodigo('BD1BT120', 'Base', fArqIniTinta(0, 'COLOR PRO', 'BD1BT120', ''));
  conf.pInsereCodigo('LD1BT90', 'Linha / Base para preço diluído BT90', fArqIniTinta(0, 'COLOR PRO', 'LD1BT90', ''));
  conf.pInsereCodigo('BD1BT90', 'Base', fArqIniTinta(0, 'COLOR PRO', 'BD1BT90', ''));
  conf.pInsereCodigo('LD1BT80', 'Linha / Base para preço diluído BT80', fArqIniTinta(0, 'COLOR PRO', 'LD1BT80', ''));
  conf.pInsereCodigo('BD1BT80', 'Base', fArqIniTinta(0, 'COLOR PRO', 'BD1BT80', ''));
  conf.pInsereCodigo('LD1BT100', 'Linha / Base para preço diluído BT100', fArqIniTinta(0, 'COLOR PRO', 'LD1BT100', ''));
  conf.pInsereCodigo('BD1BT100', 'Base', fArqIniTinta(0, 'COLOR PRO', 'BD1BT100', ''));
  conf.pInsereCodigo('PATWAN', 'Path para arquivo Txt', fArqIniTinta(0, 'COLOR PRO', 'PATWAN', ''));
  conf.pInsereCodigo('NFMPRO', 'Próximo código Nova Fórmula', fArqIniTinta(0, 'COLOR PRO', 'NFMPRO', ''));
  conf.pInsereCodigo('ACUABS', 'Valores da Formulação', fArqIniTinta(0, 'COLOR PRO', 'ACUABS', ''));
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');


  pgcGeral.ActivePageIndex := 0;
  frmConfConsultaWandaPro  := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
  frmConfConsultaWandaProEmb := TfrmConfEmbColorPro.Create(Self, pgcEmbColorPro,
    Canvas, conf.fGet('LINWAN'));
end;

procedure TfrmConfiguracoesWandaPro.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
  qryCadIte := fCriaQuery(Self);

  chkVendaDinamicaClick(Self);
end;

procedure TfrmConfiguracoesWandaPro.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    pGravaArqIni;
    Close;
  End;
end;

procedure TfrmConfiguracoesWandaPro.edtProWanKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(fComponentByName(tbsEmbalagens, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
    fValidaCampos(TWinControl(Sender), false);
  End;
end;

function TfrmConfiguracoesWandaPro.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  //#Asimov# inherited fValidaCampos
  If not (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Exit(False);
  //

  Result := True;

  If (Sender = edtProWan) Then
  Begin
    If (fEmptyStr(edtProWan.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtProWan, edtDesProWan);
      edtDesProWan.Text := fRetNomProduto(edtProWan.Text);

      If (fEmptyStr(edtDesProWan.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtEmbWan) Then
  Begin
    edtDesProWan.Text := fRetNomProduto(edtProWan.Text);

    If (fEmptyStr(edtEmbWan.Text)) Then
    Begin
      edtEmbWan.Text := '0,00';
    End
    Else If (fStrToFloat(edtEmbWan.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço da embalagem (Litro) deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End

{  Else If (Sender = edtWanIem) Then
  Begin
    If Not (fEmptyStr(edtWanIem.Text)) Then
    Begin
      edtDesWanIem.Text := fRetNomProduto(edtWanIem.Text);

      If (fEmptyStr(edtDesWanIem.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End}

  Else If (Sender = edtGalWan) Then
  Begin
    If (fEmptyStr(edtGalWan.Text)) Then
    Begin
      edtGalWan.Text := '0,00';
    End
    Else If (fStrToFloat(edtGalWan.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço da embalagem (Galão) deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End

{  Else If (Sender = edtWanIgl) Then
  Begin
    If Not (fEmptyStr(edtWanIgl.Text)) Then
    Begin
      edtDesWanIgl.Text := fRetNomProduto(edtWanIgl.Text);

      If (fEmptyStr(edtDesWanIgl.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End}

{  Else If (Sender = edtWanIla) Then
  Begin
    If Not (fEmptyStr(edtWanIla.Text)) Then
    Begin
      edtDesWanIla.Text := fRetNomProduto(edtWanIla.Text);

      If (fEmptyStr(edtDesWanIla.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End}

  {AUTOWAVE MM}
{  Else If (Sender = edtMmsilt) Then
  Begin
    If Not (fEmptyStr(edtMmsilt.Text)) Then
    Begin
      edtDesMmLt.Text := fRetNomProduto(edtMmsilt.Text);

      If (fEmptyStr(edtDesMmLt.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End}

{  Else If (Sender = edtMmsigl) Then
  Begin
    If Not (fEmptyStr(edtMmsigl.Text)) Then
    Begin
      edtDesMmGl.Text := fRetNomProduto(edtMmsigl.Text);

      If (fEmptyStr(edtDesMmGl.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End}

{  Else If (Sender = edtMmsiLa) Then
  Begin
    If Not (fEmptyStr(edtMmsiLa.Text)) Then
    Begin
      edtDesMmLa.Text := fRetNomProduto(edtMmsiLa.Text);

      If (fEmptyStr(edtDesMmLa.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End}
  {AUTOCOAT BT100}
{  Else If (Sender = edtBtsilt) Then
  Begin
    If Not (fEmptyStr(edtBtsilt.Text)) Then
    Begin
      edtDesBtLt.Text := fRetNomProduto(edtBtsilt.Text);

      If (fEmptyStr(edtDesBtLt.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End}

{  Else If (Sender = edtBtsigl) Then
  Begin
    If Not (fEmptyStr(edtBtsigl.Text)) Then
    Begin

      edtDesBtGl.Text := fRetNomProduto(edtBtsigl.Text);

      If (fEmptyStr(edtDesBtGl.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End}

{  Else If (Sender = edtBtsiLa) Then
  Begin
    If Not (fEmptyStr(edtBtsiLa.Text)) Then
    Begin
      edtDesBtLa.Text := fRetNomProduto(edtBtsiLa.Text);

      If (fEmptyStr(edtDesBtLa.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End}
  {AUTOBASE PLUS 100:50}
{  Else If (Sender = edtAupllt) Then
  Begin
    If Not (fEmptyStr(edtAupllt.Text)) Then
    Begin
      edtDesPlLt.Text := fRetNomProduto(edtAupllt.Text);

      If (fEmptyStr(edtDesPlLt.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End}

{  Else If (Sender = edtAuplgl) Then
  Begin
    If Not (fEmptyStr(edtAuplgl.Text)) Then
    Begin
      edtDesPlGl.Text := fRetNomProduto(edtAuplgl.Text);

      If (fEmptyStr(edtDesPlGl.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End}

{  Else If (Sender = edtAuplLa) Then
  Begin
    If Not (fEmptyStr(edtAuplLa.Text)) Then
    Begin
      edtDesPlLa.Text := fRetNomProduto(edtAuplLa.Text);

      If (fEmptyStr(edtDesPlLa.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End}
  // FIM
  Else If (Sender = edtWanIco) And (edtWanIco.Enabled) Then
  Begin
    If Not (fEmptyStr(edtWanIco.Text)) Then
    Begin
      edtDesWanIco.Text := fRetNomProduto(edtWanIco.Text);

      If (fEmptyStr(edtDesWanIco.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtWanIsp) And (edtWanIsp.Enabled) Then
  Begin
    If Not (fEmptyStr(edtWanIsp.Text)) Then
    Begin
      edtDesWanIsp.Text := fRetNomProduto(edtWanIsp.Text);

      If (fEmptyStr(edtDesWanIsp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtWanIss) And (edtWanIss.Enabled) Then
  Begin
    If Not (fEmptyStr(edtWanIss.Text)) Then
    Begin
      edtDesWanIss.Text := fRetNomProduto(edtWanIss.Text);

      If (fEmptyStr(edtDesWanIss.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtFveWan) Then
  Begin
    If (fEmptyStr(edtFveWan.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para geração Preço de Venda deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtFveWan.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para geração Preço de Venda deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtTraWan) Then
  Begin
    If (fEmptyStr(edtTraWan.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda (concentrado) deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTraWan.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava (concentrado) deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTraWan.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatWan) Then
  Begin
    If (fEmptyStr(edtFatWan.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava de venda (concentrado) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFatWan.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava de venda (concentrado) deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtTrdWan) Then
  Begin
    If (fEmptyStr(edtTrdWan.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda (diluido) deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTrdWan.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava (diluido) deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTrdWan.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFadWan) Then
  Begin
    If (fEmptyStr(edtFadWan.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava de venda (diluido) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFadWan.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava de venda (diluido) deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtLd1Wan) Then
  Begin
  End

  Else If (Sender = edtBd1Wan) Then
  Begin
  End

  Else If (Sender = fraPatWan) Then
  Begin
    If (fEmptyStr(fraPatWan.edtDirectory.text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O path para os arquivos Txt deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      fraPatWan.edtDirectory.text := fGetPath(fraPatWan.edtDirectory.text);
    End;
  End

  Else If (Sender = edtAcuAbs) Then
  Begin
    if not (Pos(edtAcuAbs.Text, '12') > 0) then
    begin
      Result := False;
      fMensagem('ATENÇÃO!', 'Só é permitido as opções 1 ou 2!', ['OK']);
    end;

  End

  Else If (Sender = edtDesOpe) Then
  Begin
    If fEmptyStr(edtDesOpe.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtDesOpe.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtApreve) Then
  Begin
    If fEmptyStr(edtApreve.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtApreve.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End;


  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmConfiguracoesWandaPro.mskLinWanDblClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmConfiguracoesWandaProLinhas, frmConfiguracoesWandaProLinhas);
  frmConfiguracoesWandaProLinhas.strConfigAtual := fTransform(mskLinWan.Text, 3);

  If frmConfiguracoesWandaProLinhas.ShowModal = mrOk Then
  Begin
    mskLinWan.Text := frmConfiguracoesWandaProLinhas.getLinhasUtilizadas;
  End;

  FreeAndNil(frmConfiguracoesWandaProLinhas);

end;

procedure TfrmConfiguracoesWandaPro.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaWandaPro.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesWandaPro.chkVendaDinamicaClick(Sender: TObject);
begin
  Label7.Enabled    := False;
  edtEmbWan.Enabled := False;
  edtEmbWan.Text    := '0,00';
  Label10.Enabled   := False;
  edtGalWan.Enabled := False;
  edtGalWan.Text    := '0,00';

  lblWanIco.Enabled    := True;
  edtWanIco.Enabled    := True;

  lblWanIsp.Enabled    := True;
  edtWanIsp.Enabled    := True;

  lblWanIss.Enabled    := True;
  edtWanIss.Enabled    := True;
end;

procedure TfrmConfiguracoesWandaPro.edtLd1WanKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;
  qryAux := fCriaQuery();
  Try
    If fPesqBaseTinta(Self, conWandaProLinha, edtBd1Wan, nil, qryAux, key, arrSel) Then
    Begin
      TEditFocus(Sender).Text := qryAux.FieldByName('BAS_LINHA_').AsString;
      pSetFocus(edtLd1Abs_100_50);
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmConfiguracoesWandaPro.edtLd1Abs_100_50KeyPress( Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;
  qryAux := fCriaQuery();
  Try
    If fPesqBaseTinta(Self, conWandaProLinha, edtBd1Abs_100_50, nil, qryAux, key, arrSel) Then
    Begin
      TEditFocus(Sender).Text := qryAux.FieldByName('BAS_LINHA_').AsString;
      pSetFocus(edtLd1Abs_100_80);
    End;
  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmConfiguracoesWandaPro.edtLd1Abs_100_80KeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;
  qryAux := fCriaQuery();
  Try
    If fPesqBaseTinta(Self, conWandaProLinha, edtBd1Abs_100_80, nil, qryAux, key, arrSel) Then
    Begin
      TEditFocus(Sender).Text := qryAux.FieldByName('BAS_LINHA_').AsString;
      pSetFocus(edtLd1PU_MS);
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmConfiguracoesWandaPro.edtLD1ABS_BASELINEKeyPress(Sender: TObject;var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;

  qryAux := fCriaQuery();

  Try

    If fPesqBaseTinta(Self, conWandaProLinha, edtBD1ABS_BASELINE, nil, qryAux, key, arrSel) Then
    Begin
      TEditFocus(Sender).Text := qryAux.FieldByName('BAS_LINHA_').AsString;
      pSetFocus(fraPatWan);
    End

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmConfiguracoesWandaPro.edtLd1PU_MSKeyPress(Sender: TObject; var key: Char);
  var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;
  qryAux := fCriaQuery();
  Try
    If fPesqBaseTinta(Self, conWandaProLinha, edtBd1PU_MS, nil, qryAux, key, arrSel) Then
    Begin
      TEditFocus(Sender).Text := qryAux.FieldByName('BAS_LINHA_').AsString;
      pSetFocus(edtLd1PU_HS);
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmConfiguracoesWandaPro.edtLd1PU_HSKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;
  qryAux := fCriaQuery();
  Try
    If fPesqBaseTinta(Self, conWandaProLinha, edtBd1PU_HS, nil, qryAux, key, arrSel) Then
    Begin
      TEditFocus(Sender).Text := qryAux.FieldByName('BAS_LINHA_').AsString;
      pSetFocus(edtLd1_BT120);
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmConfiguracoesWandaPro.edtLd1_BT100KeyPress(Sender: TObject;var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;
  qryAux := fCriaQuery();
  Try
    If fPesqBaseTinta(Self, conWandaProLinha, edtBd1_BT100, nil, qryAux, key, arrSel) Then
    Begin
      TEditFocus(Sender).Text := qryAux.FieldByName('BAS_LINHA_').AsString;
      pSetFocus(edtLPAPB_10080);
    End
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmConfiguracoesWandaPro.edtLd1_BT120KeyPress(Sender: TObject;var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;
  qryAux := fCriaQuery();
  Try
    If fPesqBaseTinta(Self, conWandaProLinha, edtBd1_BT120, nil, qryAux, key, arrSel) Then
    Begin
      TEditFocus(Sender).Text := qryAux.FieldByName('BAS_LINHA_').AsString;
      pSetFocus(edtLd1_BT90);
    End
  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmConfiguracoesWandaPro.edtLd1_BT80KeyPress(Sender: TObject;var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;
  qryAux := fCriaQuery();
  Try
    If fPesqBaseTinta(Self, conWandaProLinha, edtBd1_BT80, nil, qryAux, key, arrSel) Then
    Begin
      TEditFocus(Sender).Text := qryAux.FieldByName('BAS_LINHA_').AsString;
      pSetFocus(edtLd1_BT100);
    End
  Finally
    FreeAndNil(qryAux);
  End;


end;

procedure TfrmConfiguracoesWandaPro.edtLd1_BT90KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;
  qryAux := fCriaQuery();
  Try
    If fPesqBaseTinta(Self, conWandaProLinha, edtBd1_BT90, nil, qryAux, key, arrSel) Then
    Begin
      TEditFocus(Sender).Text := qryAux.FieldByName('BAS_LINHA_').AsString;
      pSetFocus(edtLd1_BT80);
    End
  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmConfiguracoesWandaPro.edtLPAPB_10080KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;

  qryAux := fCriaQuery();

  Try

    If fPesqBaseTinta(Self, conWandaProLinha, edtBPAPB_10080, nil, qryAux, key, arrSel) Then
    Begin
      TEditFocus(Sender).Text := qryAux.FieldByName('BAS_LINHA_').AsString;
      pSetFocus(edtLD1ABS_BASELINE);
    End

  Finally
    FreeAndNil(qryAux);
  End;

end;

end.

