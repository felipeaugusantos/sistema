unit untConfiguracoesAutocolor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, StrUtils, AppEvnts, Uni, QColorLabel,
  ComCtrls, untIConsultaTinta, untConfConsulta, untIConfTinta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesAutocolor = class(TfrmPai)
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    pnlCentral: TPanel;
    Label6: TLabel;
    Label17: TLabel;
    Label9: TLabel;
    Label20: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label10: TLabel;
    Label7: TLabel;
    Label16: TLabel;
    Label1: TLabel;
    lblAutIco: TLabel;
    lblAutIsp: TLabel;
    Label2: TLabel;
    ColorLabel4: TColorLabel;
    lblAutIla: TLabel;
    lblAutItb: TLabel;
    edtDesProAut: TEditFocus;
    edtProAut: TEditFocus;
    chkUsaAut: TCheckBox;
    edtTraAut: TEditFocus;
    edtFatAut: TEditFocus;
    edtFatCus: TEditFocus;
    edtDesAutIem: TEditFocus;
    edtDesAutIgl: TEditFocus;
    edtAutPgl: TEditFocus;
    edtAutPlt: TEditFocus;
    edtAutIem: TEditFocus;
    edtAutIgl: TEditFocus;
    edtDesAutIco: TEditFocus;
    edtDesAutIsp: TEditFocus;
    edtAutIco: TEditFocus;
    edtAutIsp: TEditFocus;
    edtAcuAbs: TEditFocus;
    edtAutIla: TEditFocus;
    edtDesAutIla: TEditFocus;
    edtDesAutItb: TEditFocus;
    edtAutItb: TEditFocus;
    chkUsaFor: TCheckBox;
    pnlCabecalho: TPanel;
    Label19: TLabel;
    edtNfmAut: TEditFocus;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    fraPatAut: TfraDirectoryEditFocus;
	procedure FormShow(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure edtProAutKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    { Private declarations }
    frmConfConsultaAutocolor: TfrmConfConsulta;
    tinta: IConsultaTinta ;
    conf: IConfTinta;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pRetornaDescricaoItem(edtCodIte: TEdit);
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesAutocolor: TfrmConfiguracoesAutocolor;

implementation

uses  untFuncTinta, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmConfiguracoesAutocolor }

procedure TfrmConfiguracoesAutocolor.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA AUTOCOLOR            *}
  {**************************************MV*}
{
  chkUsaAut.Checked := (fArqIniTinta(0, 'AUTOCOLOR', 'USATIN', '') = 'S');
  edtProAut.Text    := fArqIniTinta(0, 'AUTOCOLOR', 'PROAUT', '');
  edtDesProAut.Text := fRetNomProduto(edtProAut.Text);
  edtAutPlt.Text    := fArqIniTinta(0, 'AUTOCOLOR', 'AUTPLT', '');
  edtAutIem.Text    := fArqIniTinta(0, 'AUTOCOLOR', 'AUTIEM', '');
  edtDesAutIem.Text := fRetNomProduto(edtAutIem.Text);
  edtAutPgl.Text    := fArqIniTinta(0, 'AUTOCOLOR', 'AUTPGL', '');
  edtAutIgl.Text    := fArqIniTinta(0, 'AUTOCOLOR', 'AUTIGL', '');
  edtDesAutIgl.Text := fRetNomProduto(edtAutIgl.Text);

  edtAutIco.Text    := fArqIniTinta(0, 'AUTOCOLOR', 'AUTICO', '');
  edtDesAutIco.Text := fRetNomProduto(edtAutIco.Text);

  edtAutIsp.Text    := fArqIniTinta(0, 'AUTOCOLOR', 'AUTISP', '');
  edtDesAutIsp.Text := fRetNomProduto(edtAutIsp.Text);

  edtAutItb.Text    := fArqIniTinta(0, 'AUTOCOLOR', 'AUTITB', '');
  edtDesAutItb.Text := fRetNomProduto(edtAutItb.Text);

  edtAutIla.Text    := fArqIniTinta(0, 'AUTOCOLOR', 'AUTILA', '');
  edtDesAutIla.Text := fRetNomProduto(edtAutIla.Text);

  edtFatCus.Text    := fArqIniTinta(0, 'AUTOCOLOR', 'FATCUS', '');
  edtTraAut.Text    := fArqIniTinta(0, 'AUTOCOLOR', 'TRAAUT', '');
  edtFatAut.Text    := fArqIniTinta(0, 'AUTOCOLOR', 'FATAUT', '');
  fraPatAut.edtDirectory.text    := fArqIniTinta(0, 'AUTOCOLOR', 'PATAUT', '');
  edtAcuAbs.Text    := fArqIniTinta(0, 'AUTOCOLOR', 'ACUABS', '2');

  chkUsaFor.Checked := (fArqIniTinta(0, 'USA_FORMUL', 'AUT', 'S') = 'S');
}

  chkUsaAut.Checked := conf.fGetBoolean('USATIN'); //(fArqIniTinta(0, 'AUTOCOLOR', 'USATIN', '') = 'S');
  edtProAut.Text    := conf.fGet('PROAUT'); //fArqIniTinta(0, 'AUTOCOLOR', 'PROAUT', '');
  edtDesProAut.Text := fRetNomProduto(edtProAut.Text);
  edtAutPlt.Text    := conf.fGet('AUTPLT'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTPLT', '');
  edtAutIem.Text    := conf.fGet('AUTIEM'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTIEM', '');
  edtDesAutIem.Text := fRetNomProduto(edtAutIem.Text);
  edtAutPgl.Text    := conf.fGet('AUTPGL'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTPGL', '');
  edtAutIgl.Text    := conf.fGet('AUTIGL'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTIGL', '');
  edtDesAutIgl.Text := fRetNomProduto(edtAutIgl.Text);

  edtAutIco.Text    := conf.fGet('AUTICO'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTICO', '');
  edtDesAutIco.Text := fRetNomProduto(edtAutIco.Text);

  edtAutIsp.Text    := conf.fGet('AUTISP'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTISP', '');
  edtDesAutIsp.Text := fRetNomProduto(edtAutIsp.Text);

  edtAutItb.Text    := conf.fGet('AUTITB'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTITB', '');
  edtDesAutItb.Text := fRetNomProduto(edtAutItb.Text);

  edtAutIla.Text    := conf.fGet('AUTILA'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTILA', '');
  edtDesAutIla.Text := fRetNomProduto(edtAutIla.Text);

  edtFatCus.Text    := conf.fGet('FATCUS'); //fArqIniTinta(0, 'AUTOCOLOR', 'FATCUS', '');
  edtTraAut.Text    := conf.fGet('TRAAUT'); //fArqIniTinta(0, 'AUTOCOLOR', 'TRAAUT', '');
  edtFatAut.Text    := conf.fGet('FATAUT'); //fArqIniTinta(0, 'AUTOCOLOR', 'FATAUT', '');
  fraPatAut.edtDirectory.text    := conf.fGet('PATAUT'); //fArqIniTinta(0, 'AUTOCOLOR', 'PATAUT', '');
  edtAcuAbs.Text    := conf.fGet('ACUABS'); //fArqIniTinta(0, 'AUTOCOLOR', 'ACUABS', '2');

  edtNfmAut.Text    := conf.fGet('NFMAUT'); //fArqIniTinta(0, 'AUTOCOLOR', 'NFMAUT', '00001');

  chkUsaFor.Checked := conf.fGetBoolean('USAFOR'); //(fArqIniTinta(0, 'USA_FORMUL', 'AUT', 'S') = 'S');

end;

procedure TfrmConfiguracoesAutocolor.pGravaArqIni;
begin
  {*****************************************}
  {* GRAVA DADOS DA AUTOCOLOR                *}
  {**************************************MV*}
{
  If chkUsaAut.Checked Then
    strUsaTin := 'S'
  Else
    strUsaTin := 'N';

  fArqIniTinta(1, 'AUTOCOLOR', 'USATIN', strUsaTin);
  fArqIniTinta(1, 'AUTOCOLOR', 'PROAUT', edtProAut.Text);
  fArqIniTinta(1, 'AUTOCOLOR', 'AUTPLT', edtAutPlt.Text);
  fArqIniTinta(1, 'AUTOCOLOR', 'AUTIEM', edtAutIem.Text);
  fArqIniTinta(1, 'AUTOCOLOR', 'AUTPGL', edtAutPgl.Text);
  fArqIniTinta(1, 'AUTOCOLOR', 'AUTIGL', edtAutIgl.Text);

  fArqIniTinta(1, 'AUTOCOLOR', 'AUTICO', edtAutIco.Text);
  fArqIniTinta(1, 'AUTOCOLOR', 'AUTISP', edtAutIsp.Text);

  fArqIniTinta(1, 'AUTOCOLOR', 'AUTITB', edtAutItb.Text);
  fArqIniTinta(1, 'AUTOCOLOR', 'AUTILA', edtAutIla.Text);

  fArqIniTinta(1, 'AUTOCOLOR', 'FATCUS', edtFatCus.Text);
  fArqIniTinta(1, 'AUTOCOLOR', 'TRAAUT', edtTraAut.Text);
  fArqIniTinta(1, 'AUTOCOLOR', 'FATAUT', edtFatAut.Text);
  fArqIniTinta(1, 'AUTOCOLOR', 'PATAUT', fraPatAut.edtDirectory.text);

  fArqIniTinta(1, 'AUTOCOLOR', 'ACUABS', edtAcuAbs.Text);

  fArqIniTinta(1, 'USA_FORMUL', 'AUT', IfThen(chkUsaFor.Checked, 'S', 'N'));
}

  conf.pSetBoolean('USATIN', chkUsaAut.Checked); //fArqIniTinta(1, 'AUTOCOLOR', 'USATIN', strUsaTin);
  conf.pSet('PROAUT', edtProAut.Text); //fArqIniTinta(1, 'AUTOCOLOR', 'PROAUT', edtProAut.Text);
  conf.pSet('AUTPLT', edtAutPlt.Text); //fArqIniTinta(1, 'AUTOCOLOR', 'AUTPLT', edtAutPlt.Text);
  conf.pSet('AUTIEM', edtAutIem.Text); //fArqIniTinta(1, 'AUTOCOLOR', 'AUTIEM', edtAutIem.Text);
  conf.pSet('AUTPGL', edtAutPgl.Text); //fArqIniTinta(1, 'AUTOCOLOR', 'AUTPGL', edtAutPgl.Text);
  conf.pSet('AUTIGL', edtAutIgl.Text); //fArqIniTinta(1, 'AUTOCOLOR', 'AUTIGL', edtAutIgl.Text);

  conf.pSet('AUTICO', edtAutIco.Text); //fArqIniTinta(1, 'AUTOCOLOR', 'AUTICO', edtAutIco.Text);
  conf.pSet('AUTISP', edtAutIsp.Text); //fArqIniTinta(1, 'AUTOCOLOR', 'AUTISP', edtAutIsp.Text);

  conf.pSet('AUTITB', edtAutItb.Text); //fArqIniTinta(1, 'AUTOCOLOR', 'AUTITB', edtAutItb.Text);
  conf.pSet('AUTILA', edtAutIla.Text); //fArqIniTinta(1, 'AUTOCOLOR', 'AUTILA', edtAutIla.Text);

  conf.pSet('FATCUS', edtFatCus.Text); //fArqIniTinta(1, 'AUTOCOLOR', 'FATCUS', edtFatCus.Text);
  conf.pSet('TRAAUT', edtTraAut.Text); //fArqIniTinta(1, 'AUTOCOLOR', 'TRAAUT', edtTraAut.Text);
  conf.pSet('FATAUT', edtFatAut.Text); //fArqIniTinta(1, 'AUTOCOLOR', 'FATAUT', edtFatAut.Text);
  conf.pSet('PATAUT', fraPatAut.edtDirectory.text); //fArqIniTinta(1, 'AUTOCOLOR', 'PATAUT', fraPatAut.edtDirectory.text);

  conf.pSet('ACUABS', edtAcuAbs.Text); //fArqIniTinta(1, 'AUTOCOLOR', 'ACUABS', edtAcuAbs.Text);

  conf.pSet('NFMAUT', edtNfmAut.Text);  

  conf.pSetBoolean('USAFOR', chkUsaFor.Checked); //fArqIniTinta(1, 'USA_FORMUL', 'AUT', IfThen(chkUsaFor.Checked, 'S', 'N'));

  frmConfConsultaAutocolor.pSalvarConfs;  
end;

procedure TfrmConfiguracoesAutocolor.pRetornaDescricaoItem(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 6);
  edtDesIte := TEdit(fComponentByName(pnlCentral, strNomEdt));

  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesAutocolor.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesAutocolor.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesAutocolor.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('AUT');
  tinta := fGetConsultaTinta('AUT');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}
  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'AUTOCOLOR', 'USATIN', ''));
  conf.pInsereCodigo('PROAUT', 'Produto para venda', fArqIniTinta(0, 'AUTOCOLOR', 'PROAUT', ''));
  conf.pInsereCodigo('AUTPLT', 'Preço de embalagem(Litro)', fArqIniTinta(0, 'AUTOCOLOR', 'AUTPLT', ''));
  conf.pInsereCodigo('AUTIEM', 'Item embalagem(Litro)', fArqIniTinta(0, 'AUTOCOLOR', 'AUTIEM', ''));
  conf.pInsereCodigo('AUTPGL', 'Preço de embalagem(Galão)', fArqIniTinta(0, 'AUTOCOLOR', 'AUTPGL', ''));
  conf.pInsereCodigo('AUTIGL', 'Item embalagem(Galão)', fArqIniTinta(0, 'AUTOCOLOR', 'AUTIGL', ''));
  conf.pInsereCodigo('AUTICO', 'Item embalagem para Copo', fArqIniTinta(0, 'AUTOCOLOR', 'AUTICO', ''));
  conf.pInsereCodigo('AUTISP', 'Item embalagem para Spray', fArqIniTinta(0, 'AUTOCOLOR', 'AUTISP', ''));
  conf.pInsereCodigo('AUTITB', 'Item embalagem para Tambor', fArqIniTinta(0, 'AUTOCOLOR', 'AUTITB', ''));
  conf.pInsereCodigo('AUTILA', 'Item embalagem para Lata', fArqIniTinta(0, 'AUTOCOLOR', 'AUTILA', ''));
  conf.pInsereCodigo('FATCUS', 'Fator para geração Preço de Custo', fArqIniTinta(0, 'AUTOCOLOR', 'FATCUS', ''));
  conf.pInsereCodigo('TRAAUT', 'Trava para valor de venda AUT_PRE', fArqIniTinta(0, 'AUTOCOLOR', 'TRAAUT', ''));
  conf.pInsereCodigo('FATAUT', 'Fator', fArqIniTinta(0, 'AUTOCOLOR', 'FATAUT', ''));
  conf.pInsereCodigo('PATAUT', 'Path para arquivos (*.txt / *.dbf)', fArqIniTinta(0, 'AUTOCOLOR', 'PATAUT', ''));
  conf.pInsereCodigo('ACUABS', 'Valores da formulação', fArqIniTinta(0, 'AUTOCOLOR', 'ACUABS', '2'));
  conf.pInsereCodigo('USAFOR', 'Usar Formulação', fArqIniTinta(0, 'USA_FORMUL', 'AUT', 'S'));
  conf.pInsereCodigo('NFMAUT', 'Próximo código Novas Fórmulas', fArqIniTinta(0, 'AUTOCOLOR', 'NFMAUT', ''));

  pgcDados.ActivePageIndex := 0;
  frmConfConsultaAutocolor := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
end;

procedure TfrmConfiguracoesAutocolor.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
  pRetornaDescricaoItem(edtProAut);  
  pRetornaDescricaoItem(edtAutIem);  
  pRetornaDescricaoItem(edtAutIgl);
  pRetornaDescricaoItem(edtAutIco);
  pRetornaDescricaoItem(edtAutIsp);
  pRetornaDescricaoItem(edtAutItb);
  pRetornaDescricaoItem(edtAutIla);

end;

procedure TfrmConfiguracoesAutocolor.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    pGravaArqIni;
    Close;
  End;
end;

procedure TfrmConfiguracoesAutocolor.edtProAutKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(fComponentByName(pnlCentral, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

function TfrmConfiguracoesAutocolor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  //#Asimov# inherited fValidaCampos
  If not (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Exit(False);
  //

  Result := True;

  If (Sender = edtProAut) Then
  Begin
    If (fEmptyStr(edtProAut.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtProAut);
      If (fEmptyStr(edtDesProAut.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtAutPlt) And (edtAutPlt.Enabled) Then
  Begin
    If (fEmptyStr(edtAutPlt.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço da embalagem (Litro) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtAutPlt.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço da embalagem (Litro) deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtAutIem) Then
  Begin
    If (fEmptyStr(edtAutIem.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para embalagem (Litro) deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtAutIem);
      If (fEmptyStr(edtDesAutIem.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtAutPgl) And (edtAutPgl.Enabled) Then
  Begin
    If (fEmptyStr(edtAutPgl.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço da embalagem (Galão) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtAutPgl.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço da embalagem (Galão) deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtAutIgl) Then
  Begin
    If (fEmptyStr(edtAutIgl.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para embalagem (Galão) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtAutIgl);
      If (fEmptyStr(edtDesAutIgl.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtAutIco)  And (edtAutIco.Enabled) Then
  Begin
    If (fEmptyStr(edtAutIco.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para embalagem (Copo) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtAutIco);
      If (fEmptyStr(edtDesAutIco.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtAutIsp)  And (edtAutIsp.Enabled) Then
  Begin
    If (fEmptyStr(edtAutIsp.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para embalagem (Spray) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtAutIsp);
      If (fEmptyStr(edtDesAutIsp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtAutItb)  And (edtAutItb.Enabled) Then
  Begin
    If (fEmptyStr(edtAutItb.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para embalagem (Tambor) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtAutItb);
      If (fEmptyStr(edtDesAutItb.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtAutIla)  And (edtAutIla.Enabled) Then
  Begin
    If (fEmptyStr(edtAutIla.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para embalagem (Lata) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtAutIla);
      If (fEmptyStr(edtDesAutIla.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtFatCus) Then
  Begin
    If (fEmptyStr(edtFatCus.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para geração Preço de Custo deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtFatCus.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para geração Preço de Custo deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtTraAut) Then
  Begin
    If (fEmptyStr(edtTraAut.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTraAut.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTraAut.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatAut) Then
  Begin
    If (fEmptyStr(edtFatAut.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFatAut.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = fraPatAut) Then
  Begin
    If (fEmptyStr(fraPatAut.edtDirectory.text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O path para os arquivos Txt deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      fraPatAut.edtDirectory.text := fGetPath(fraPatAut.edtDirectory.text);
    End;
  End
  Else If (Sender = edtAcuAbs) Then
  Begin
    Result := (Pos(edtAcuAbs.Text, '12') > 0);
  End
  Else If (Sender = edtNfmAut) Then
  Begin
    if (fEmptyStr(edtNfmAut.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'O código das novas fórmulas deve ser preenchido!', ['&Ok']);
      Result := False;
    end;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmConfiguracoesAutocolor.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaAutocolor.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesAutocolor.Destroy;
begin
  if Assigned(frmConfConsultaAutocolor) then FreeAndNil(frmConfConsultaAutocolor);
  inherited;
end;

end.
