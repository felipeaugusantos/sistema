unit untConfiguracoesSkyMix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, DirectoryEditFocus, DB, ADODB, Uni,
  FilenameEditFocus, ComCtrls, untConfConsulta, untIConsultaTinta, untIConfTinta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmConfiguracoesSkyMix = class(TfrmPai)
    gbEmbalagens: TGroupBox;
    Label16: TLabel;
    Label1: TLabel;
    edtUniGL: TEditFocus;
    edtUniLT: TEditFocus;
    chkUsaSky: TCheckBox;
    Label11: TLabel;
    Label20: TLabel;
    Label9: TLabel;
    edtFatSky: TEditFocus;
    Label17: TLabel;
    edtUniLTDescri: TEditFocus;
    edtUniLTUni: TEditFocus;
    edtUniGLDescri: TEditFocus;
    edtUniGLUni: TEditFocus;
    Label4: TLabel;
    edtUniLat: TEditFocus;
    edtUniLatDescri: TEditFocus;
    edtUniLatUni: TEditFocus;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    edtSkyPro: TEditFocus;
    edtSkyProDes: TEditFocus;
    edtTraSky: TEditFocus;
    edtNfmCod: TEditFocus;
    Label6: TLabel;
    chkAcuBas: TCheckBox;
    pgcGeral: TPageControl;
    tbsGeral: TTabSheet;
    tbsEmbalagens: TTabSheet;
    gpbLaca: TGroupBox;
    gpbPoliester: TGroupBox;
    gpbSintetico: TGroupBox;
    gpbPU: TGroupBox;
    Label2: TLabel;
    edtProQua: TEditFocus;
    edtDesQua: TEditFocus;
    edtDesGal: TEditFocus;
    edtProGal: TEditFocus;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtProQuaPoliester: TEditFocus;
    edtProGalPoliester: TEditFocus;
    edtDesGalPoliester: TEditFocus;
    edtDesQuaPoliester: TEditFocus;
    Label10: TLabel;
    Label12: TLabel;
    edtProGalPu: TEditFocus;
    edtProQuaPu: TEditFocus;
    edtDesQuaPu: TEditFocus;
    edtDesGalPu: TEditFocus;
    Label13: TLabel;
    Label14: TLabel;
    edtProGalSintetico: TEditFocus;
    edtProQuaSintetico: TEditFocus;
    edtDesQuaSintetico: TEditFocus;
    edtDesGalSintetico: TEditFocus;
    tbsConfCampos: TTabSheet;
    Label15: TLabel;
    edtProCop: TEditFocus;
    edtDesCop: TEditFocus;
    btnConfirmaGeracao: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label18: TLabel;
    edtDesOpe: TEditFocus;
    Label38: TLabel;
    edtApreve: TEditFocus;
    edtPatSky: TFilenameEditFocus;
    GroupBox2: TGroupBox;
    Label19: TLabel;
    Label21: TLabel;
    edtProQuaFroSFL: TEditFocus;
    edtDesQuaFroSFL: TEditFocus;
    edtDesGalFroSFL: TEditFocus;
    edtProGalFroSFL: TEditFocus;
    GroupBox3: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    edtProQuaFroSFS: TEditFocus;
    edtDesQuaFroSFS: TEditFocus;
    edtDesGalFroSFS: TEditFocus;
    edtProGalFroSFS: TEditFocus;
    GroupBox4: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    edtProQuaFroSFP: TEditFocus;
    edtDesQuaFroSFP: TEditFocus;
    edtDesGalFroSFP: TEditFocus;
    edtProGalFroSFP: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure edtUniLTKeyPress(Sender: TObject; var Key: Char);
    procedure edtUniLTExit(Sender: TObject);
    procedure edtProQuaKeyPress(Sender: TObject; var Key: Char);
    procedure edtProGalKeyPress(Sender: TObject; var Key: Char);
    procedure edtSkyProKeyPress(Sender: TObject; var Key: Char);
    procedure edtSkyProExit(Sender: TObject);
    procedure edtProGalExit(Sender: TObject);
    procedure edtProQuaPoliesterExit(Sender: TObject);
    procedure edtProGalPoliesterExit(Sender: TObject);
    procedure edtProQuaPuExit(Sender: TObject);
    procedure edtProGalPuExit(Sender: TObject);
    procedure edtProQuaSinteticoExit(Sender: TObject);
    procedure edtProGalSinteticoExit(Sender: TObject);
    procedure edtProQuaPoliesterKeyPress(Sender: TObject; var Key: Char);
    procedure edtProGalPoliesterKeyPress(Sender: TObject; var Key: Char);
    procedure edtProQuaPuKeyPress(Sender: TObject; var Key: Char);
    procedure edtProGalPuKeyPress(Sender: TObject; var Key: Char);
    procedure edtProQuaSinteticoKeyPress(Sender: TObject; var Key: Char);
    procedure edtProGalSinteticoKeyPress(Sender: TObject; var Key: Char);
    procedure tbsEmbalagensShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtProQuaExit(Sender: TObject);
    procedure edtProCopExit(Sender: TObject);
    procedure edtProCopKeyPress(Sender: TObject; var Key: Char);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcGeralChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtProQuaFroSFLExit(Sender: TObject);
    procedure edtProQuaFroSFLKeyPress(Sender: TObject; var Key: Char);
    procedure edtProGalFroSFLExit(Sender: TObject);
    procedure edtProGalFroSFLKeyPress(Sender: TObject; var Key: Char);
    procedure edtProQuaFroSFSExit(Sender: TObject);
    procedure edtProQuaFroSFSKeyPress(Sender: TObject; var Key: Char);
    procedure edtProGalFroSFSExit(Sender: TObject);
    procedure edtProGalFroSFSKeyPress(Sender: TObject; var Key: Char);
    procedure edtProQuaFroSFPExit(Sender: TObject);
    procedure edtProQuaFroSFPKeyPress(Sender: TObject; var Key: Char);
    procedure edtProGalFroSFPExit(Sender: TObject);
    procedure edtProGalFroSFPKeyPress(Sender: TObject; var Key: Char);
  private
    qryCadIte: TUniQuery;

    frmConfConsultaSkyMix: TfrmConfConsulta;
    tinta: IConsultaTinta ;
    conf: IConfTinta;
    { Private declarations }
    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
    procedure pRetDescUnidade(strCodUni: String; out strDescri : String; out strUnid: String);
    function fValidaProduto(edtCodigo, edtDescricao: TEditFocus): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesSkyMix: TfrmConfiguracoesSkyMix;

implementation

uses untFuncoesSimples,  StrUtils, untFuncTinta, untConsultas, untTCadRcxx, untTypesSistema;

{$R *.dfm}

{ TfrmConfiguracoesSkyMix }

procedure TfrmConfiguracoesSkyMix.pCarregaArqIni;
begin
  conf := fGetConfTinta('SKY');
  chkUsaSky.Checked := conf.fGetBoolean('USATIN');
  chkAcuBas.Checked := IIF(conf.fGet('ACUABS') = '1', True, False);

  edtUniGL.Text := conf.fGet('SKYUGL');
  edtUniLT.Text := conf.fGet('SKYULT');

  edtUniLat.Text := conf.fGet('SKYULA');
  edtTraSky.Text := conf.fGet('SKYTRA');
  edtFatSky.Text := conf.fGet('SKYFAT');
  edtPatSky.Text := conf.fGet('SKYPAT');

  edtProQua.Text := conf.fGet('SKYPQU');
  edtProGal.Text := conf.fGet('SKYPGA');
  edtProCop.Text := conf.fGet('SKYPCP');

  edtProQuaPoliester.Text := conf.fGet('SKYPQU_POLIESTER');
  edtProGalPoliester.Text := conf.fGet('SKYPGA_POLIESTER');

  edtProQuaPu.Text := conf.fGet('SKYPQU_PU');
  edtProGalPu.Text := conf.fGet('SKYPGA_PU');

  edtProQuaSintetico.Text := conf.fGet('SKYPQU_SINTETICO');
  edtProGalSintetico.Text := conf.fGet('SKYPGA_SINTETICO');

  edtSkyPro.Text := conf.fGet('SKYPRO');
  edtNfmCod.Text := conf.fGet('SKYNFM');

  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');

  //Embalagens Frota
  edtProQuaFroSFL.Text := conf.fGet('SKYPQU_FROSFL');
  edtProGalFroSFL.Text := conf.fGet('SKYPGA_FROSFL');

  edtProQuaFroSFS.Text := conf.fGet('SKYPQU_FROSFS');
  edtProGalFroSFS.Text := conf.fGet('SKYPGA_FROSFS');

  edtProQuaFroSFP.Text := conf.fGet('SKYPQU_FROSFP');
  edtProGalFroSFP.Text := conf.fGet('SKYPGA_FROSFP');
end;

procedure TfrmConfiguracoesSkyMix.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesSkyMix.pgcGeralChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcGeral.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesSkyMix.pGravaArqIni;
begin
  conf.pSetBoolean('USATIN', chkUsaSky.Checked);
  conf.pSet('ACUABS', IIF(chkAcuBas.Checked, '1', '2'));

  conf.pSet('SKYUGL', edtUniGL.Text);
  conf.pSet('SKYULT', edtUniLT.Text);
  conf.pSet('SKYTRA', edtTraSky.Text);
  conf.pSet('SKYFAT', edtFatSky.Text);
  conf.pSet('SKYPAT', edtPatSky.Text);
  conf.pSet('SKYULA', edtUniLat.Text);

  conf.pSet('SKYPQU', edtProQua.Text);
  conf.pSet('SKYPGA', edtProGal.Text);
  conf.pSet('SKYPCP', edtProCop.Text);

  conf.pSet('SKYPQU_POLIESTER', edtProQuaPoliester.Text);
  conf.pSet('SKYPGA_POLIESTER', edtProGalPoliester.Text);

  conf.pSet('SKYPQU_PU', edtProQuaPu.Text);
  conf.pSet('SKYPGA_PU', edtProGalPu.Text);

  conf.pSet('SKYPQU_SINTETICO', edtProQuaSintetico.Text);
  conf.pSet('SKYPGA_SINTETICO', edtProGalSintetico.Text);

  conf.pSet('SKYPRO', edtSkyPro.Text);
  conf.pSet('USAFOR', 'S');
  conf.pSet('SKYNFM', edtNfmCod.Text);

  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  //Embalagens Frota
  conf.pSet('SKYPQU_FROSFL', edtProQuaFroSFL.Text);
  conf.pSet('SKYPGA_FROSFL', edtProGalFroSFL.Text);

  conf.pSet('SKYPQU_FROSFS', edtProQuaFroSFS.Text);
  conf.pSet('SKYPGA_FROSFS', edtProGalFroSFS.Text);

  conf.pSet('SKYPQU_FROSFP', edtProQuaFroSFP.Text);
  conf.pSet('SKYPGA_FROSFP', edtProGalFroSFP.Text);

  frmConfConsultaSkyMix.pSalvarConfs;
end;

procedure TfrmConfiguracoesSkyMix.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(chkUsaSky);
end;

procedure TfrmConfiguracoesSkyMix.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('SKY');
  tinta := fGetConsultaTinta('SKY');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'USATIN', 'S'));
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', 'S');
  conf.pInsereCodigo('ACUABS', 'Utilizar formulação acumulada', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'ACUABS', 'S'));
  conf.pInsereCodigo('SKYUGL', 'Unidade Galão', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYUGL', ''));
  conf.pInsereCodigo('SKYULT', 'Unidade Quarto', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYULT', ''));
  conf.pInsereCodigo('SKYULA', 'Unidade Lata', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYULA', ''));
  conf.pInsereCodigo('SKYTRA', 'Trava para valor de venda SKY_PRE', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYTRA', ''));
  conf.pInsereCodigo('SKYFAT', 'Fator', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYFAT', ''));
  conf.pInsereCodigo('SKYPAT', 'Arquivo Access 2007 (*.accdb)', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYPAT', ''));
  conf.pInsereCodigo('SKYPQU', 'LACA Embalagem Quarto', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYPQU', ''));
  conf.pInsereCodigo('SKYPGA', 'LACA Embalagem Galão', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYPGA', ''));
  conf.pInsereCodigo('SKYPCP', 'Embalagem Copo', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYPCP', ''));
  conf.pInsereCodigo('SKYPQU_POLIESTER', 'POLIESTER Embalagem Quarto', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYPQU_POLIESTER', edtProQua.Text));
  conf.pInsereCodigo('SKYPGA_POLIESTER', 'POLIESTER Embalagem Galão', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYPGA_POLIESTER', edtProGal.Text));
  conf.pInsereCodigo('SKYPQU_PU', 'PU Embalagem Quarto', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYPQU_PU', edtProQua.Text));
  conf.pInsereCodigo('SKYPGA_PU', 'PU Embalagem Galão', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYPGA_PU', edtProGal.Text));
  conf.pInsereCodigo('SKYPQU_SINTETICO', 'SINTÉTICO Embalagem Quarto', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYPQU_SINTETICO', edtProQua.Text));
  conf.pInsereCodigo('SKYPGA_SINTETICO', 'SINTÉTICO Embalagem Galão', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYPGA_SINTETICO', edtProGal.Text));
  conf.pInsereCodigo('SKYPRO', 'Produto Venda', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYPRO', ''));
  conf.pInsereCodigo('SKYNFM', 'Próximo Código Novas Formulas', fArqIniTinta(0, 'SKYMIX AUTOMOTIVA', 'SKYNFM', ''));
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  //Embalagens Frota
  conf.pInsereCodigo('SKYPQU_FROSFL', 'Frota SFL Quarto', '');
  conf.pInsereCodigo('SKYPGA_FROSFL', 'Frota SFL Galão', '');
  conf.pInsereCodigo('SKYPQU_FROSFS', 'Frota SFS Quarto', '');
  conf.pInsereCodigo('SKYPGA_FROSFS', 'Frota SFS Galão', '');
  conf.pInsereCodigo('SKYPQU_FROSFP', 'Frota SFS Quarto', '');
  conf.pInsereCodigo('SKYPGA_FROSFP', 'Frota SFS Galão', '');

  pgcGeral.ActivePageIndex := 0;
  frmConfConsultaSkyMix := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);

  edtPatSky.Dialog.Dialog.Filter := 'Arquivo Access 2007 (*.accdb):|*.accdb';
end;

procedure TfrmConfiguracoesSkyMix.FormShow(Sender: TObject);
begin
  inherited;
  pgcGeral.ActivePage := tbsGeral;

  pCarregaArqIni;
  qryCadIte := fCriaQuery(Self);
  edtUniLTExit(edtUniGL);
  edtUniLTExit(edtUniLT);
  edtUniLTExit(edtUniLat);

  edtDesGal.Text := fRetNomProduto(edtProGal.Text);
  edtDesQua.Text := fRetNomProduto(edtProQua.Text);
  edtDesCop.Text := fRetNomProduto(edtProCop.Text);

  edtProQuaPoliesterExit(edtProQuaPoliester);
  edtProGalPoliesterExit(edtProGalPoliester);

  edtProQuaPuExit(edtProQuaPu);
  edtProGalPuExit(edtProGalPu);

  edtProQuaSinteticoExit(edtProQuaSintetico);
  edtProGalSinteticoExit(edtProGalSintetico);

  //Embalagens Frota
  edtProQuaFroSFLExit(edtProQuaFroSFL);
  edtProGalFroSFLExit(edtProGalFroSFL);
  edtProQuaFroSFSExit(edtProQuaFroSFS);
  edtProGalFroSFSExit(edtProGalFroSFS);
  edtProQuaFroSFPExit(edtProQuaFroSFP);
  edtProGalFroSFPExit(edtProGalFroSFP);

  edtSkyProDes.Text := fRetNomProduto(edtSkyPro.Text);
end;

function TfrmConfiguracoesSkyMix.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Sender = edtTraSky Then
  Begin
    Result := (Pos(edtTraSky.Text, 'CUS_VEN') > 0);

    If Not Result Then
      fMensagem('ATENÇÃO!', 'O valor da trava deve ser CUS ou VEN.', ['&Ok']);
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
    End
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
    End
  End


  Else If Sender = edtSkyPro Then
    Result := fValidaProduto(edtSkyPro, edtSkyProDes)

  Else If Sender = edtProQua Then
    Result := fValidaProduto(edtProQua, edtDesQua)

  Else If Sender = edtProGal Then
    Result := fValidaProduto(edtProGal, edtDesGal);

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmConfiguracoesSkyMix.btnConfirmaGeracaoClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    If (fMensagem('', 'Confirma dados?', ['&Sim', '&Não']) = 1) Then
    Begin
      pGravaArqIni;
      Close;
    End;
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtUniLTKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqUnidade(Self, TEditFocus(Sender),
                        TEditFocus(FindComponent(TComponent(Sender).Name + 'Descri')),
                        TEditFocus(FindComponent(TComponent(Sender).Name + 'Uni')), nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesSkyMix.edtUniLTExit(Sender: TObject);
  var
    strDescri, strUnid: String;
begin
  inherited;
  pRetDescUnidade(TEditFocus(Sender).Text, strDescri, strUnid);
  TEditFocus(FindComponent(TComponent(Sender).Name + 'Descri')).Text := strDescri;
  TEditFocus(FindComponent(TComponent(Sender).Name + 'Uni')).Text := strUnid;
end;

procedure TfrmConfiguracoesSkyMix.pRetDescUnidade(strCodUni: String;
  out strDescri, strUnid: String);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT UNI_SIGUNI, UNI_DESUNI FROM CADUNI WHERE UNI_CODUNI = "' + strCodUni + '"';
  qryGen.Open;

  strDescri := qryGen.FieldByName('UNI_DESUNI').AsString;
  strUnid := qryGen.FieldByName('UNI_SIGUNI').AsString;
  FreeAndNil(qryGen);
end;

procedure TfrmConfiguracoesSkyMix.tbsEmbalagensShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtProQua);
end;

procedure TfrmConfiguracoesSkyMix.edtProQuaExit(Sender: TObject);
begin
  inherited;
  edtDesQua.Text := fRetNomProduto(edtProQua.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProQuaFroSFLExit(Sender: TObject);
begin
  inherited;
  edtDesQuaFroSFL.Text := fRetNomProduto(edtProQuaFroSFL.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProQuaFroSFLKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProQuaFroSFL, edtDesQuaFroSFL);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtProQuaFroSFPExit(Sender: TObject);
begin
  inherited;
  edtDesQuaFroSFP.Text := fRetNomProduto(edtProQuaFroSFP.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProQuaFroSFPKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProQuaFroSFP, edtDesQuaFroSFP);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtProQuaFroSFSExit(Sender: TObject);
begin
  inherited;
  edtDesQuaFroSFS.Text := fRetNomProduto(edtProQuaFroSFS.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProQuaFroSFSKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProQuaFroSFS, edtDesQuaFroSFS);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtProQuaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProQua, edtDesQua);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtProQuaPoliesterExit(Sender: TObject);
begin
  inherited;
  edtDesQuaPoliester.Text := fRetNomProduto(edtProQuaPoliester.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProQuaPoliesterKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProQuaPoliester, edtDesQuaPoliester);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtProQuaPuExit(Sender: TObject);
begin
  inherited;
  edtDesQuaPu.Text := fRetNomProduto(edtProQuaPu.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProQuaPuKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProQuaPu, edtDesQuaPu);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtProQuaSinteticoExit(Sender: TObject);
begin
  inherited;
  edtDesQuaSintetico.Text := fRetNomProduto(edtProQuaSintetico.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProQuaSinteticoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProQuaSintetico, edtDesQuaSintetico);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtProGalKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProGal, edtDesGal);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtProGalPoliesterExit(Sender: TObject);
begin
  inherited;
  edtDesGalPoliester.Text := fRetNomProduto(edtProGalPoliester.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProGalPoliesterKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProGalPoliester, edtDesGalPoliester);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtProGalPuExit(Sender: TObject);
begin
  inherited;
  edtDesGalPu.Text := fRetNomProduto(edtProGalPu.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProGalPuKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProGalPu, edtDesGalPu);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtProGalSinteticoExit(Sender: TObject);
begin
  inherited;
  edtDesGalSintetico.Text := fRetNomProduto(edtProGalSintetico.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProGalSinteticoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProGalSintetico, edtDesGalSintetico);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtSkyProKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtSkyPro, edtSkyProDes);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtSkyProExit(Sender: TObject);
begin
  inherited;
  edtSkyProDes.Text := fRetNomProduto(edtSkyPro.Text);
end;

procedure TfrmConfiguracoesSkyMix.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaSkyMix.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesSkyMix.Destroy;
begin
  if Assigned(frmConfConsultaSkyMix) then FreeAndNil(frmConfConsultaSkyMix);
  inherited;
end;

procedure TfrmConfiguracoesSkyMix.edtProCopExit(Sender: TObject);
begin
  inherited;
  edtDesCop.Text := fRetNomProduto(edtProCop.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProCopKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProCop, edtDesCop);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtProGalExit(Sender: TObject);
begin
  inherited;
  edtDesGal.Text := fRetNomProduto(edtProGal.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProGalFroSFLExit(Sender: TObject);
begin
  inherited;
  edtDesGalFroSFL.Text := fRetNomProduto(edtProGalFroSFL.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProGalFroSFLKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProGalFroSFL, edtDesGalFroSFL);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtProGalFroSFPExit(Sender: TObject);
begin
  inherited;
  edtDesGalFroSFP.Text := fRetNomProduto(edtProGalFroSFP.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProGalFroSFPKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProGalFroSFP, edtDesGalFroSFP);
  End;
end;

procedure TfrmConfiguracoesSkyMix.edtProGalFroSFSExit(Sender: TObject);
begin
  inherited;
  edtDesGalFroSFS.Text := fRetNomProduto(edtProGalFroSFS.Text);
end;

procedure TfrmConfiguracoesSkyMix.edtProGalFroSFSKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(edtProGalFroSFS, edtDesGalFroSFS);
  End;
end;

function TfrmConfiguracoesSkyMix.fValidaProduto(edtCodigo, edtDescricao: TEditFocus): Boolean;
begin
  Result := True;

  edtDescricao.Text := fRetNomProduto(edtCodigo.Text);

  If (Not fEmptyStr(edtCodigo.Text)) And fEmptyStr(edtDescricao.Text) Then
  Begin
    Result := False;
    fMensagem('', 'Nenhum produto encontrado com este código!', ['&OK']);
  End;

end;

end.

