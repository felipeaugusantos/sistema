unit untConfiguracoesLazzumix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  QColorLabel, Mask, FilenameEditFocus, Menus, StrUtils, AppEvnts,
  Uni, untIConsultaTinta, untIConfTinta, untConfConsulta,
  BitBtnLockedIncrem, JvExMask, JvToolEdit, frxClass, frxExportCSVTestabilidade;

type
  TfrmConfiguracoesLazzumix = class(TfrmPaiSimples)
    pnlBotoesConf: TPanel;
    Label9: TLabel;
    Label12: TLabel;
    ColorLabel1: TColorLabel;
    ColorLabel2: TColorLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    chkUsaLaz: TCheckBox;
    edtTraClz: TEditFocus;
    edtTraDlz: TEditFocus;
    edtFatClz: TEditFocus;
    edtFatDlz: TEditFocus;
    edtLazPpr: TFilenameEditFocus;
    edtLazPfo: TFilenameEditFocus;
    Label6: TLabel;
    edtProLaz: TEditFocus;
    edtDesLaz: TEditFocus;
    pnlFundo: TPanel;
    Label11: TLabel;
    edtLaz_So: TEditFocus;
    ColorLabel3: TColorLabel;
    chkUsaFor: TCheckBox;
    Label13: TLabel;
    ColorLabel4: TColorLabel;
    edtAcuAbs: TEditFocus;
    Label20: TLabel;
    edtPerFre: TEditFocus;
    Label21: TLabel;
    edtPerIpi: TEditFocus;
    Label22: TLabel;
    edtPerRet: TEditFocus;
    Label23: TLabel;
    edtPerAdc: TEditFocus;
    Label24: TLabel;
    edtPerPer: TEditFocus;
    Label25: TLabel;
    edtMarLuc: TEditFocus;
    Label26: TLabel;
    edtProNfm: TEditFocus;
    tbsEmbalagens: TTabSheet;
    pnlCabecalho: TPanel;
    pnlEmbalagens: TPanel;
    tbsConfCampos: TTabSheet;
    Label33: TLabel;
    Label34: TLabel;
    edtPerso210: TFilenameEditFocus;
    edtPerso211: TFilenameEditFocus;
    Label35: TLabel;
    edtLazPba: TFilenameEditFocus;
    edtLinPer: TEditFocus;
    ColorLabel5: TColorLabel;
    Label38: TLabel;
    btnSairConf: TBitBtnLocked;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    pnlPrecos: TPanel;
    Label10: TLabel;
    Label7: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    edtGalLaz: TEditFocus;
    edtEmbLaz: TEditFocus;
    edtCopLaz: TEditFocus;
    edtSprLaz: TEditFocus;
    pnlProdBaixas: TPanel;
    lblLazSpr: TLabel;
    lblLazCop: TLabel;
    edtLazCop: TEditFocus;
    edtLazSpr: TEditFocus;
    edtDesLazCop: TEditFocus;
    edtDesLazSpr: TEditFocus;
    pgcTiposEmbalagens: TPageControl;
    tbsGalao: TTabSheet;
    tbsLitro: TTabSheet;
    tbsLata: TTabSheet;
    gpbGalao: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    Label37: TLabel;
    edtDesLazIgl: TEditFocus;
    edtLazIgl: TEditFocus;
    edtDesLazGla: TEditFocus;
    edtLazGla: TEditFocus;
    edtDesLazGpo: TEditFocus;
    edtLazGpo: TEditFocus;
    edtDesLazGpu: TEditFocus;
    edtLazGpu: TEditFocus;
    edtDesLazGcr: TEditFocus;
    edtLazGcr: TEditFocus;
    edtLazGfl: TEditFocus;
    edtDesLazGfl: TEditFocus;
    edtUltraBaseGl: TEditFocus;
    edtDesUltraBaseGl: TEditFocus;
    edtDesPuMsGl: TEditFocus;
    edtPuMsGl: TEditFocus;
    edtSherGl: TEditFocus;
    edtDesSherGl: TEditFocus;
    gpbLitro: TGroupBox;
    Label3: TLabel;
    Label14: TLabel;
    Label19: TLabel;
    Label8: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    Label36: TLabel;
    edtDesLazIem: TEditFocus;
    edtLazIem: TEditFocus;
    edtDesLazLla: TEditFocus;
    edtLazLla: TEditFocus;
    edtDesLazLpo: TEditFocus;
    edtLazLpo: TEditFocus;
    edtDesLazLpu: TEditFocus;
    edtLazLpu: TEditFocus;
    edtDesLazLcr: TEditFocus;
    edtLazLcr: TEditFocus;
    edtLazLfl: TEditFocus;
    edtDesLazLfl: TEditFocus;
    edtUltraBaseLt: TEditFocus;
    edtDesUltraBaseLt: TEditFocus;
    edtPuMsLt: TEditFocus;
    edtDesPuMsLt: TEditFocus;
    edtSherLt: TEditFocus;
    edtDesSherLt: TEditFocus;
    Label39: TLabel;
    edtLatLaz: TEditFocus;
    gpbLata: TGroupBox;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    edtDesLazIla: TEditFocus;
    edtLazIla: TEditFocus;
    edtDesLazLaz: TEditFocus;
    edtLazLaz: TEditFocus;
    edtDesLazLdu: TEditFocus;
    edtLazLdu: TEditFocus;
    edtDesLazLap: TEditFocus;
    edtLazLap: TEditFocus;
    edtDesLazLil: TEditFocus;
    edtLazLil: TEditFocus;
    edtLazLco: TEditFocus;
    edtDesLazLco: TEditFocus;
    edtUltraBaseLa: TEditFocus;
    edtDesUltraBaseLa: TEditFocus;
    edtDesPuMsLa: TEditFocus;
    edtPuMsLa: TEditFocus;
    edtSherLa: TEditFocus;
    edtDesSherLa: TEditFocus;
    Label49: TLabel;
    edtDesOpe: TEditFocus;
    Label50: TLabel;
    edtApreve: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure btnSairConfClick(Sender: TObject);
    procedure edtLazIglKeyPress(Sender: TObject; var Key: Char);
    procedure edtProLazKeyPress(Sender: TObject; var Key: Char);
    procedure tbsGeralShow(Sender: TObject);
    procedure chkVenDinClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    { Private declarations }

    consulta: IConsultaTinta;
    conf: IConfTinta;
    frmConfConsultaLazzumix: TfrmConfConsulta;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pAtualizaVariaveisGlobais;
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
    function fRetornaDescricaoItem(edtCodIte: TEdit): TEdit;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesLazzumix: TfrmConfiguracoesLazzumix;

implementation

uses untPai,
     untFuncTinta,  DB, untFuncoesSimples;

{$R *.dfm}

{ TfrmConfiguracoesLazzumix }

procedure TfrmConfiguracoesLazzumix.pAtualizaVariaveisGlobais;
begin

end;

procedure TfrmConfiguracoesLazzumix.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA LAZZUMIX / HSMIX     *}
  {**************************************MV*}
  chkUsaLaz.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  edtProLaz.Text    := conf.fGet('PROLAZ');
  edtDesLaz.Text    := fRetNomProduto(edtProLaz.Text);
  edtEmbLaz.Text    := conf.fGet('EMBLAZ');
  edtGalLaz.Text    := conf.fGet('GALLAZ');
  edtCopLaz.Text    := conf.fGet('COPLAZ');
  edtSprLaz.Text    := conf.fGet('SPRLAZ');
  edtLatLaz.Text    := conf.fGet('LATLAZ');
  edtLazIgl.Text := conf.fGet('LAZIGL');
  edtLazGla.Text := conf.fGet('LAZGLA');

  //Lata
  edtLazIla.Text := conf.fGet('LAZILA');
  edtLazLaz.Text := conf.fGet('LAZLAZ');
  edtLazLdu.Text := conf.fGet('LAZLDU');
  edtLazLap.Text := conf.fGet('LAZLAP');
  edtLazLil.Text := conf.fGet('LAZLIL');
  edtLazLco.Text := conf.fGet('LAZLCO');
  edtUltraBaseLa.Text := conf.fGet('ULTRABASELA');
  edtPuMsLa.Text := conf.fGet('PUMSLA');
  edtSherLa.Text := conf.fGet('SHERLA');

  edtLazGpo.Text := conf.fGet('LAZGPO');
  edtLazGpu.Text := conf.fGet('LAZGPU');
  edtLazGcr.Text := conf.fGet('LAZGCR');
  edtLazGfl.Text := conf.fGet('LAZGFL');
  edtLazIem.Text := conf.fGet('LAZIEM');
  edtLazLla.Text := conf.fGet('LAZLLA');
  edtLazLpo.Text := conf.fGet('LAZLPO');
  edtLazLpu.Text := conf.fGet('LAZLPU');
  edtLazLcr.Text := conf.fGet('LAZLCR');
  edtLazLfl.Text := conf.fGet('LAZLFL');

  edtLazCop.Text := conf.fGet('LAZCOP');
  edtLazSpr.Text := conf.fGet('LAZSPR');

  edtTraClz.Text := conf.fGet('TRACLZ');
  edtFatClz.Text := conf.fGet('FATCLZ');
  edtTraDlz.Text := conf.fGet('TRADLZ');
  edtFatDlz.Text := conf.fGet('FATDLZ');
  edtLazPpr.Text := conf.fGet('LAZPPR');
  edtLazPfo.Text := conf.fGet('LAZPFO');
  edtLazPba.Text := conf.fGet('LAZPBA');

  edtLaz_So.Text := conf.fGet('LAZ_SO');
  edtAcuAbs.Text := conf.fGet('ACUABS');

  edtPerFre.Text := conf.fGet('PERFRE');
  edtPerIpi.Text := conf.fGet('PERIPI');
  edtPerRet.Text := conf.fGet('PERRET');
  edtPerAdc.Text := conf.fGet('PERADC');
  edtPerPer.Text := conf.fGet('PERPER');
  edtMarLuc.Text := conf.fGet('MARLUC');

  edtProNfm.Text := conf.fGet('PRONFM');

  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');


  edtUltraBaseGl.Text := conf.fGet('ULTRABASEGL');
  edtUltraBaseLt.Text := conf.fGet('ULTRABASELT');
  edtPuMsGl.Text := conf.fGet('PUMSGL');
  edtPuMsLt.Text := conf.fGet('PUMSLT');

  edtSherGl.Text := conf.fGet('SHERGL');
  edtSherLt.Text := conf.fGet('SHERLT');

  edtPerso210.Text := conf.fGet('PERSO210');
  edtPerso211.Text := conf.fGet('PERSO211');
  edtLinPer.Text   := conf.fGet('LINPER');

  fRetornaDescricaoItem(edtLazIgl);
  fRetornaDescricaoItem(edtLazGla);
  fRetornaDescricaoItem(edtLazGpo);
  fRetornaDescricaoItem(edtLazGpu);
  fRetornaDescricaoItem(edtLazGcr);
  fRetornaDescricaoItem(edtLazGfl);
  fRetornaDescricaoItem(edtLazIem);
  fRetornaDescricaoItem(edtLazLla);
  fRetornaDescricaoItem(edtLazLpo);
  fRetornaDescricaoItem(edtLazLpu);
  fRetornaDescricaoItem(edtLazLcr);
  fRetornaDescricaoItem(edtLazLfl);
  fRetornaDescricaoItem(edtLazCop);
  fRetornaDescricaoItem(edtLazSpr);

  fRetornaDescricaoItem(edtUltraBaseGl);
  fRetornaDescricaoItem(edtUltraBaseLt);
  fRetornaDescricaoItem(edtPuMsGl);
  fRetornaDescricaoItem(edtPuMsLt);

  fRetornaDescricaoItem(edtSherGl);
  fRetornaDescricaoItem(edtSherLt);

  //Lata
  fRetornaDescricaoItem(edtLazIla);
  fRetornaDescricaoItem(edtLazLaz);
  fRetornaDescricaoItem(edtLazLdu);
  fRetornaDescricaoItem(edtLazLap);
  fRetornaDescricaoItem(edtLazLil);
  fRetornaDescricaoItem(edtLazLco);
  fRetornaDescricaoItem(edtUltraBaseLa);
  fRetornaDescricaoItem(edtPuMsLa);
  fRetornaDescricaoItem(edtSherLa);

end;

procedure TfrmConfiguracoesLazzumix.pGravaArqIni;
Begin
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSetBoolean('USATIN', chkUsaLaz.Checked);
  conf.pSet('PROLAZ', edtProLaz.Text);
  conf.pSet('EMBLAZ', edtEmbLaz.Text);
  conf.pSet('GALLAZ', edtGalLaz.Text);
  conf.pSet('COPLAZ', edtCopLaz.Text);
  conf.pSet('SPRLAZ', edtSprLaz.Text);
  conf.pSet('LATLAZ', edtLatLaz.Text);
  conf.pSet('LAZIGL', edtLazIgl.Text);
  conf.pSet('LAZGLA', edtLazGla.Text);
  conf.pSet('LAZGPO', edtLazGpo.Text);
  conf.pSet('LAZGPU', edtLazGpu.Text);
  conf.pSet('LAZGCR', edtLazGcr.Text);
  conf.pSet('LAZGFL', edtLazGfl.Text);
  conf.pSet('LAZIEM', edtLazIem.Text);
  conf.pSet('LAZLLA', edtLazLla.Text);
  conf.pSet('LAZLPO', edtLazLpo.Text);
  conf.pSet('LAZLPU', edtLazLpu.Text);
  conf.pSet('LAZLCR', edtLazLcr.Text);
  conf.pSet('LAZLFL', edtLazLfl.Text);
  conf.pSet('LAZCOP', edtLazCop.Text);
  conf.pSet('LAZSPR', edtLazSpr.Text);
  conf.pSet('TRACLZ', edtTraClz.Text);
  conf.pSet('FATCLZ', edtFatClz.Text);
  conf.pSet('TRADLZ', edtTraDlz.Text);
  conf.pSet('FATDLZ', edtFatDlz.Text);
  conf.pSet('LAZPPR', edtLazPpr.Text);
  conf.pSet('LAZPFO', edtLazPfo.Text);
  conf.pSet('LAZPBA', edtLazPba.Text);

  conf.pSet('LAZ_SO', edtLaz_So.Text);
  conf.pSet('ACUABS', edtAcuAbs.Text);

  conf.pSet('PERFRE', edtPerFre.Text);
  conf.pSet('PERIPI', edtPerIpi.Text);
  conf.pSet('PERRET', edtPerRet.Text);
  conf.pSet('PERADC', edtPerAdc.Text);
  conf.pSet('PERPER', edtPerPer.Text);
  conf.pSet('MARLUC', edtMarLuc.Text);

  conf.pSet('PRONFM', edtProNfm.Text);

  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  conf.pSet('ULTRABASEGL', edtUltraBaseGl.Text);
  conf.pSet('ULTRABASELT', edtUltraBaseLt.Text);
  conf.pSet('PUMSGL', edtPuMsGl.Text);
  conf.pSet('PUMSLT', edtPuMsLt.Text);
  conf.pSet('SHERGL', edtSherGl.Text);
  conf.pSet('SHERLT', edtSherLt.Text);

  conf.pSet('PERSO210', edtPerso210.Text);
  conf.pSet('PERSO211', edtPerso211.Text);
  conf.pSet('LINPER', edtLinPer.Text);

  //Lata
  conf.pSet('LAZILA', edtLazIla.Text);
  conf.pSet('LAZLAZ', edtLazLaz.Text);
  conf.pSet('LAZLDU', edtLazLdu.Text);
  conf.pSet('LAZLAP', edtLazLap.Text);
  conf.pSet('LAZLIL', edtLazLil.Text);
  conf.pSet('LAZLCO', edtLazLco.Text);
  conf.pSet('ULTRABASELA', edtUltraBaseLa.Text);
  conf.pSet('PUMSLA', edtPuMsLa.Text);
  conf.pSet('SHERLA', edtSherLa.Text);

  frmConfConsultaLazzumix.pSalvarConfs;

end;

procedure TfrmConfiguracoesLazzumix.FormCreate(Sender: TObject);
begin
  inherited;
  consulta := fGetConsultaTinta('LAZ');
  conf := fGetConfTinta('LAZ');

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', 'S');
  conf.pInsereCodigo('USAFOR', 'Utilizar Formulação', 'S');
  conf.pInsereCodigo('PROLAZ', 'Produto para venda', '');
  conf.pInsereCodigo('EMBLAZ', 'Preço de embalagem', '');
  conf.pInsereCodigo('GALLAZ', 'Preço de galão', '');
  conf.pInsereCodigo('COPLAZ', 'Preço de copo', '');
  conf.pInsereCodigo('SPRLAZ', 'Preço de spray', '');
  conf.pInsereCodigo('LATLAZ', 'Preço de lata', '');  
  conf.pInsereCodigo('LAZIGL', 'Produto para baixa embalagem LAZZURIL (GL)', '');
  conf.pInsereCodigo('LAZGLA', 'Produto para baixa embalagem LAZZULAC (GL)', '');
  conf.pInsereCodigo('LAZGPO', 'Produto para baixa embalagem LAZZUDUR (GL)', '');
  conf.pInsereCodigo('LAZGPU', 'Produto para baixa embalagem P.U. (GL)', '');
  conf.pInsereCodigo('LAZGCR', 'Produto para baixa embalagem LAZZUCRIT (GL)', '');
  conf.pInsereCodigo('LAZGFL', 'Produto para baixa embalagem FLEET COLOR (GL)', '');
  conf.pInsereCodigo('LAZIEM', 'Produto para baixa embalagem LAZZURIL (LT)', '');
  conf.pInsereCodigo('LAZLLA', 'Produto para baixa embalagem LAZZULAC (LT)', '');
  conf.pInsereCodigo('LAZLPO', 'Produto para baixa embalagem LAZZUDUR (LT)', '');
  conf.pInsereCodigo('LAZLPU', 'Produto para baixa embalagem P.U. (LT)', '');
  conf.pInsereCodigo('LAZLCR', 'Produto para baixa embalagem LAZZUCRIT (LT)', '');
  conf.pInsereCodigo('LAZLFL', 'Produto para baixa embalagem FLEET COLOR (LT)', '');
  conf.pInsereCodigo('LAZCOP', 'Produto para baixa embalagem COPO', '');
  conf.pInsereCodigo('LAZSPR', 'Produto para baixa embalagem SPRAY', '');
  conf.pInsereCodigo('TRACLZ', 'Trava de preço Concentrado', '1');
  conf.pInsereCodigo('FATCLZ', 'Fator de trava de preço Concentrado', '1,00');
  conf.pInsereCodigo('TRADLZ', 'Trava de preço Diluido', '3');
  conf.pInsereCodigo('FATDLZ', 'Fator de trava de preço Diluido', '1,00');
  conf.pInsereCodigo('LAZPPR', 'Path para o arquivo "Produto.txt"', '');
  conf.pInsereCodigo('LAZPFO', 'Path para o arquivo "Formula.txt"', '');
  conf.pInsereCodigo('LAZPBA', 'Path para o arquivo "Base.txt"', '');
  conf.pInsereCodigo('LAZ_SO', 'Sistema Operacional', 'W');
  conf.pInsereCodigo('ACUABS', 'Formulação Acumulada / Absoluta', '2');
  conf.pInsereCodigo('PERFRE', 'Percentual frete', '0,00');;
  conf.pInsereCodigo('PERIPI', 'Percentual da IPI', '0,00');
  conf.pInsereCodigo('PERRET', 'Percentual retido', '0,00');
  conf.pInsereCodigo('PERADC', 'Percentual adicionais', '0,00');
  conf.pInsereCodigo('PERPER', 'Percentual de perda', '0,00');
  conf.pInsereCodigo('MARLUC', 'Margem de lucro', '0,00');
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0,00');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0,00');
  conf.pInsereCodigo('PRONFM', 'Próximo código novas fórmulas', '1');
  conf.pInsereCodigo('ULTRABASEGL', 'Produto para baixa embalagem ULTRABASE (GL)', '');
  conf.pInsereCodigo('ULTRABASELT', 'Produto para baixa embalagem ULTRABASE (LT)', '');
  conf.pInsereCodigo('PUMSGL', 'Produto para baixa embalagem P.U. MS (GL)', '');
  conf.pInsereCodigo('PUMSLT', 'Produto para baixa embalagem P.U. MS (LT)', '');
  conf.pInsereCodigo('SHERGL', 'Produto para baixa embalagem SHERTRUCKMIX (GL)', '');
  conf.pInsereCodigo('SHERLT', 'Produto para baixa embalagem SHERTRUCKMIX (LT)', '');
  conf.pInsereCodigo('PERSO210', 'Path para arquivo (Perso210.TXT):', '');
  conf.pInsereCodigo('PERSO211', 'Path para arquivo (Perso211.TXT):', '');
  conf.pInsereCodigo('LINPER', 'Quantidade de Linhas no Arquivo (Perso211.TXT)', '3');

  //Lata
  conf.pInsereCodigo('LAZILA', 'Produto baixa embalagem LAZZURIL(LA)', '');
  conf.pInsereCodigo('LAZLAZ', 'Produto baixa embalagem LAZZULAC(LA)', '');
  conf.pInsereCodigo('LAZLDU', 'Produto baixa embalagem LAZZUDUR(LA)', '');
  conf.pInsereCodigo('LAZLAP', 'Produto baixa embalagem P. U.(LA)', '');
  conf.pInsereCodigo('LAZLIL', 'Produto baixa embalagem Lazzucril(LA)', '');
  conf.pInsereCodigo('LAZLCO', 'Produto baixa embalagem Fleet Color(LA)', '');
  conf.pInsereCodigo('ULTRABASELA', 'Produto baixa embalagem UltraBase(LA)', '');
  conf.pInsereCodigo('PUMSLA', 'Produto baixa embalagem PU MS(LA)', '');
  conf.pInsereCodigo('SHERLA', 'Produto baixa embalagem SHERTRUCKMIX(LA)', '');

  pCarregaArqIni;

  frmConfConsultaLazzumix := TfrmConfConsulta.Create(Self, tbsConfCampos, Self.Canvas, consulta);
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmConfiguracoesLazzumix.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin

    If (fMensagem('', 'Confirma dados?', ['&Sim', '&Não']) = 1) Then
    Begin
      pGravaArqIni;
      pAtualizaVariaveisGlobais;
      Close;
    End;

  End;

end;

procedure TfrmConfiguracoesLazzumix.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmConfiguracoesLazzumix.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    edtDesIte: TEdit;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtProLaz) Then
    Begin
      If (fEmptyStr(edtProLaz.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtDesLaz.Text := fRetNomProduto(edtProLaz.Text);
        If (fEmptyStr(edtDesLaz.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtEmbLaz) Then
    Begin
      If (fEmptyStr(edtEmbLaz.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço de Embalagem deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(edtEmbLaz.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço de Embalagem deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtGalLaz) Then
    Begin
      If (fEmptyStr(edtGalLaz.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço do Galão deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(edtGalLaz.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço do Galão deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA PRECO DA EMBALAGEM DE COPO     *}
    {**************************************JB*}
    Else If (Sender = edtCopLaz) Then
    Begin
      If (fEmptyStr(edtCopLaz.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço do Copo deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(edtCopLaz.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço do Copo deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA PRECO DA EMBALAGEM DE SPRAY    *}
    {**************************************JB*}
    Else If (Sender = edtSprLaz) Then
    Begin
      If (fEmptyStr(edtSprLaz.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço do Spray deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(edtSprLaz.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço do Spray deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtLatLaz) Then
    Begin
      If (fEmptyStr(edtLatLaz.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço da Lata deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(edtLatLaz.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço da Lata deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtLazIgl) Or
            (Sender = edtLazGla) Or
            (Sender = edtLazGpo) Or
            (Sender = edtLazGpu) Or
            (Sender = edtLazGcr) Or
            (Sender = edtLazGfl) Or
            (Sender = edtLazIem) Or
            (Sender = edtLazLla) Or
            (Sender = edtLazLpo) Or
            (Sender = edtLazLpu) Or
            (Sender = edtLazLcr) Or
            (Sender = edtLazLfl) Or
            (Sender = edtLazCop) Or
            (Sender = edtLazSpr) Or
            (Sender = edtSherLt) Or
            (Sender = edtSherGl) Or

            (Sender = edtLazIla) Or
            (Sender = edtLazLaz) Or
            (Sender = edtLazLdu) Or
            (Sender = edtLazLap) Or
            (Sender = edtLazLil) Or
            (Sender = edtLazLco) Or
            (Sender = edtUltraBaseLa) Or
            (Sender = edtPuMsLa) Or
            (Sender = edtSherLa) Then
    Begin

      If TEdit(Sender).Visible Then
      Begin
        If Not (fEmptyStr(TEdit(Sender).Text)) Then
        Begin
          edtDesIte := fRetornaDescricaoItem(TEdit(Sender));
          If (fEmptyStr(edtDesIte.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End;

    End

    Else If (Sender = edtTraClz) Then
    Begin
      If (fEmptyStr(edtTraClz.Text)) Then
      Begin
        Result := False;
      End
      Else If (Pos(edtTraClz.Text, '12') <= 0) Then
      Begin
        Result := False;
      End;
    End

    Else If (Sender = edtFatClz) Then
    Begin

      If (fEmptyStr(edtFatClz.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O fator para concentrado deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(edtFatClz.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O fator para concentrado deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = edtTraDlz) Then
    Begin
      If (fEmptyStr(edtTraDlz.Text)) Then
      Begin
        Result := False;
      End
      Else If (Pos(edtTraDlz.Text, '34') <= 0) Then
      Begin
        Result := False;
      End;
    End

    Else If (Sender = edtFatDlz) Then
    Begin
      If (fEmptyStr(edtFatDlz.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O fator para diluido deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(edtFatDlz.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O fator para diluido deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtLazPpr) Then
    Begin
      If (fEmptyStr(edtLazPpr.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O path para arquivo de produtos deve ser preenchido!', ['&O k']);
        Result := False;
      End;
//    Else
//      edtLazPpr.Text := fGetPath(edtLazPpr.Text);
    End

    Else If (Sender = edtLazPfo) Then
    Begin
      If (fEmptyStr(edtLazPfo.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O path para arquivo de fórmulas deve ser preenchido!', ['&O k']);
        Result := False;
      End;
//    Else
//      edtLazPfo.Text := fGetPath(edtLazPfo.Text);
    End

    Else If (Sender = edtLaz_So) Then
    Begin
      If (Pos(edtLaz_So.Text, 'WD') <= 0) Then
      Begin
        Result := False;
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
    Else If (Sender = edtLinPer) Then
    Begin
      Result := (Pos(fStrZero(edtLinPer.Text,3), '003_004_') > 0);
    End

    Else If (Sender = edtDesOpe) Then
    begin
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
    begin
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
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmConfiguracoesLazzumix.edtLazIglKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;

  If (fEntraCons(Key)) Then
  Begin

    edtDesEdt := fRetornaDescricaoItem(TEdit(Sender));
    pConsultaItem(TEdit(Sender), edtDesEdt);

  End;
end;

procedure TfrmConfiguracoesLazzumix.pConsultaItem(edtItem,
  edtDesIte: TEdit);
  Var
    stlCamposIte: TStringList;
    stlCamIndIte: TStringList;
    stlDesIndIte: TStringList;
    qryCadIte: TUniQuery;
begin
  inherited;

  stlCamposIte := TStringList.Create;
  stlCamIndIte := TStringList.Create;
  stlDesIndIte := TStringList.Create;

  stlCamposIte.Add('ITE_CODITE');
  stlCamposIte.Add('ITE_DESITE');
  stlCamposIte.Add('ITE_REFERE');
  stlCamposIte.Add('ITE_CODUNI');
  stlCamposIte.Add('ITE_CODBAR');
  stlCamposIte.Add('ITE_CODMAR');
  stlCamposIte.Add('AUTOINCREM');

  stlCamIndIte.Add('ITE_DESITE');
  stlCamIndIte.Add('ITE_REFERE');
  stlCamIndIte.Add('ITE_CODITE');
  stlCamIndIte.Add('ITE_CODBAR');

  stlDesIndIte.Add('Descrição');
  stlDesIndIte.Add('Referência');
  stlDesIndIte.Add('Código');
  stlDesIndIte.Add('Cód. Barra');

  qryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  pSetaQueryCadIte(qryCadIte);

  If pConsultaRapida(Self, qryCadIte, 'CADITE', stlCamIndIte,
    stlDesIndIte, stlCamposIte) Then
  Begin

    edtItem.Text   := qryCadIte.FieldByName('ITE_CODITE').AsString;
    edtDesIte.Text := qryCadIte.FieldByName('ITE_DESITE').AsString;
    SelectNext(ActiveControl, True, True);

  End;

  FreeAndNil(qryCadIte);
  FreeAndNil(stlCamposIte);
  FreeAndNil(stlCamIndIte);
  FreeAndNil(stlDesIndIte);

end;

procedure TfrmConfiguracoesLazzumix.edtProLazKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProLaz, edtDesLaz);
  End;
end;

function TfrmConfiguracoesLazzumix.fRetornaDescricaoItem(edtCodIte: TEdit): TEdit;
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + Copy(edtCodIte.Name, 4, Length(edtCodIte.Name));
  edtDesIte := TEdit(fComponentByName(gpbGalao, strNomEdt));
  If Not Assigned(edtDesIte) Then
    edtDesIte := TEdit(fComponentByName(gpbLitro, strNomEdt));
    If Not Assigned(edtDesIte) Then
      edtDesIte := TEdit(fComponentByName(gpbLata, strNomEdt));
      If Not Assigned(edtDesIte) Then
        edtDesIte := TEdit(fComponentByName(pnlFundo, strNomEdt));
        If (Not Assigned(edtDesIte)) Then
          edtDesIte := TEdit(fComponentByName(pnlEmbalagens, strNomEdt));
          If (Not Assigned(edtDesIte)) Then
            edtDesIte := TEdit(fComponentByName(pnlProdBaixas, strNomEdt));

  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
  Result := edtDesIte;
end;

procedure TfrmConfiguracoesLazzumix.tbsGeralShow(Sender: TObject);
begin
  inherited;
  pSetFocus(chkUsaLaz);
  chkVenDinClick(Self);
end;

procedure TfrmConfiguracoesLazzumix.chkVenDinClick(Sender: TObject);
begin
  inherited;
  lblLazCop.Visible    := True;
  lblLazSpr.Visible    := True;
  edtLazCop.Visible    := True;
  edtLazSpr.Visible    := True;
  edtDesLazCop.Visible := True;
  edtDesLazSpr.Visible := True;
end;

destructor TfrmConfiguracoesLazzumix.Destroy;
begin
  if Assigned(frmConfConsultaLazzumix) then FreeAndNil(frmConfConsultaLazzumix);
  inherited Destroy;
end;

procedure TfrmConfiguracoesLazzumix.btnRestaurarClick(Sender: TObject);
Begin
  frmConfConsultaLazzumix.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesLazzumix.pgcDadosChange(Sender: TObject);
begin
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

end.


