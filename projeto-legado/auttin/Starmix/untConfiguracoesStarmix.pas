unit untConfiguracoesStarmix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, StrUtils, AppEvnts, QColorLabel, Uni,
  ComCtrls, untConfConsulta, untIConfTinta, untIConsultaTinta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesStarmix = class(TfrmPai)
    pnlCabecalho: TPanel;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    pnlCentral: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    Label10: TLabel;
    Label7: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TColorLabel;
    lblStaIco: TLabel;
    lblStaIsp: TLabel;
    edtDesProSta: TEditFocus;
    edtProSta: TEditFocus;
    chkUsaSta: TCheckBox;
    edtTraSta: TEditFocus;
    edtFatSta: TEditFocus;
    edtFveSta: TEditFocus;
    edtDesSta: TEditFocus;
    edtDesStaIem: TEditFocus;
    edtDesStaIgl: TEditFocus;
    edtStaImp: TEditFocus;
    edtStaPgl: TEditFocus;
    edtStaPlt: TEditFocus;
    edtStaIem: TEditFocus;
    edtStaIgl: TEditFocus;
    edtStaPer: TEditFocus;
    edtNfmSta: TEditFocus;
    edtAcuAbs: TEditFocus;
    edtDesStaIco: TEditFocus;
    edtDesStaIsp: TEditFocus;
    edtStaIco: TEditFocus;
    edtStaIsp: TEditFocus;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label1: TLabel;
    edtDesOpe: TEditFocus;
    Label38: TLabel;
    edtApreve: TEditFocus;
    fraPatSta: TfraDirectoryEditFocus;
    Label2: TLabel;
    edtDesStaIla: TEditFocus;
    edtStaIla: TEditFocus;
    Label3: TLabel;
    edtDesPst: TEditFocus;
    ColorLabel1: TColorLabel;
    procedure FormShow(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure edtProStaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    { Private declarations }
    frmConfConsultaStarmix: TfrmConfConsulta;
    tinta: IConsultaTinta;
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
  frmConfiguracoesStarmix: TfrmConfiguracoesStarmix;

implementation

uses untFuncTinta, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmConfiguracoesStarmix }

procedure TfrmConfiguracoesStarmix.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA STARMIX              *}
  {**************************************MV*}
{
  chkUsaSta.Checked := (fArqIniTinta(0, 'STARMIX', 'USATIN', '') = 'S');
  edtProSta.Text := fArqIniTinta(0, 'STARMIX', 'PROSTA', '');
  edtStaPlt.Text := fArqIniTinta(0, 'STARMIX', 'STAPLT', '');
  edtStaIem.Text := fArqIniTinta(0, 'STARMIX', 'STAIEM', '');
  edtStaPgl.Text := fArqIniTinta(0, 'STARMIX', 'STAPGL', '');
  edtStaIgl.Text := fArqIniTinta(0, 'STARMIX', 'STAIGL', '');

  edtStaIco.Text := fArqIniTinta(0, 'STARMIX', 'STAICO', '');
  edtStaIsp.Text := fArqIniTinta(0, 'STARMIX', 'STAISP', '');

  edtStaImp.Text := fArqIniTinta(0, 'STARMIX', 'STAIMP', '');
  edtFveSta.Text := fArqIniTinta(0, 'STARMIX', 'FVESTA', '');
  edtStaPer.Text := fArqIniTinta(0, 'STARMIX', 'STAPER', '');
  edtTraSta.Text := fArqIniTinta(0, 'STARMIX', 'TRASTA', '');
  edtFatSta.Text := fArqIniTinta(0, 'STARMIX', 'FATSTA', '');
  fraPatSta.edtDirectory.text := fArqIniTinta(0, 'STARMIX', 'PATSTA', '');
  edtDesSta.Text := fArqIniTinta(0, 'STARMIX', 'DESSTA', '');
  edtNfmSta.Text := fArqIniTinta(0, 'STARMIX', 'NFMSTA', '');

  edtAcuAbs.Text := fArqIniTinta(0, 'STARMIX', 'ACUABS', '1');
}
  conf  := fGetConfTinta('STA');


  chkUsaSta.Checked        := conf.fGetBoolean('USATIN');
  edtProSta.Text           := conf.fGet('PROSTA');
  edtStaPlt.Text           := conf.fGet('STAPLT');
  edtStaIem.Text           := conf.fGet('STAIEM');
  edtStaPgl.Text           := conf.fGet('STAPGL');
  edtStaIgl.Text           := conf.fGet('STAIGL');
  edtStaIla.Text           := conf.fGet('STAILA');

  edtStaIco.Text := conf.fGet('STAICO');
  edtStaIsp.Text := conf.fGet('STAISP');

  edtStaImp.Text := conf.fGet('STAIMP');
  edtFveSta.Text := conf.fGet('FVESTA');
  edtStaPer.Text := conf.fGet('STAPER');
  edtTraSta.Text := conf.fGet('TRASTA');
  edtFatSta.Text := conf.fGet('FATSTA');
  fraPatSta.edtDirectory.text := conf.fGet('PATSTA');
  edtDesSta.Text := conf.fGet('DESSTA');
  edtNfmSta.Text := conf.fGet('NFMSTA');

  edtAcuAbs.Text := conf.fGet('ACUABS');

  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');

  edtDesPst.Text := conf.fGet('DESPST');
end;

procedure TfrmConfiguracoesStarmix.pGravaArqIni;
begin
  {*****************************************}
  {* GRAVA DADOS DA STARMIX                *}
  {**************************************MV*}

  conf.pSetBoolean('USATIN', chkUsaSta.Checked);
  conf.pSet('PROSTA', edtProSta.Text);
  conf.pSetDouble('STAPLT', fStrToFloat(edtStaPlt.Text));
  conf.pSet('STAIEM', edtStaIem.Text);
  conf.pSetDouble('STAPGL', fStrToFloat(edtStaPgl.Text));
  conf.pSet('STAIGL', edtStaIgl.Text);
  conf.pSet('STAILA', edtStaIla.Text);

  conf.pSet('STAICO', edtStaIco.Text);
  conf.pSet('STAISP', edtStaIsp.Text);

  conf.pSetDouble('STAIMP', fStrToFloat(edtStaImp.Text));
  conf.pSetDouble('FVESTA', fStrToFloat(edtFveSta.Text));
  conf.pSetDouble('STAPER', fStrToFloat(edtStaPer.Text));
  conf.pSet('TRASTA', edtTraSta.Text);
  conf.pSetDouble('FATSTA', fStrToFloat(edtFatSta.Text));
  conf.pSet('PATSTA', fraPatSta.edtDirectory.text);
  conf.pSetDouble('DESSTA', fStrToFloat(edtDesSta.Text));
  conf.pSet('NFMSTA', edtNfmSta.Text);

  conf.pSetInteger('ACUABS', StrToIntDef(edtAcuAbs.Text,0));
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  conf.pSet('DESPST', edtDesPst.Text);

{
  If chkUsaSta.Checked Then
    strUsaTin := 'S'
  Else
    strUsaTin := 'N';

  strVenDin := IIF(chkVendaDinamica.Checked, 'S', 'N');

  fArqIniTinta(1, 'STARMIX', 'USATIN', strUsaTin);
  fArqIniTinta(1, 'STARMIX', 'PROSTA', edtProSta.Text);
  fArqIniTinta(1, 'STARMIX', 'STAPLT', edtStaPlt.Text);
  fArqIniTinta(1, 'STARMIX', 'STAIEM', edtStaIem.Text);
  fArqIniTinta(1, 'STARMIX', 'STAPGL', edtStaPgl.Text);
  fArqIniTinta(1, 'STARMIX', 'STAIGL', edtStaIgl.Text);

  fArqIniTinta(1, 'STARMIX', 'STAICO', edtStaIco.Text);
  fArqIniTinta(1, 'STARMIX', 'STAISP', edtStaIsp.Text);

  fArqIniTinta(1, 'STARMIX', 'STAIMP', edtStaImp.Text);
  fArqIniTinta(1, 'STARMIX', 'FVESTA', edtFveSta.Text);
  fArqIniTinta(1, 'STARMIX', 'STAPER', edtStaPer.Text);
  fArqIniTinta(1, 'STARMIX', 'TRASTA', edtTraSta.Text);
  fArqIniTinta(1, 'STARMIX', 'FATSTA', edtFatSta.Text);
  fArqIniTinta(1, 'STARMIX', 'PATSTA', fraPatSta.edtDirectory.text);
  fArqIniTinta(1, 'STARMIX', 'DESSTA', edtDesSta.Text);
  fArqIniTinta(1, 'STARMIX', 'NFMSTA', edtNfmSta.Text);

  fArqIniTinta(1, 'STARMIX', 'ACUABS', edtAcuAbs.Text);
}
  frmConfConsultaStarmix.pSalvarConfs;
end;

procedure TfrmConfiguracoesStarmix.pRetornaDescricaoItem(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 6);
  edtDesIte := TEdit(fComponentByName(pnlCentral, strNomEdt));

  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesStarmix.pConsultaItem(edtItem, edtDesIte: TEdit);
  var
    arrSel: TConsultasArray;
    Key: Char;
Begin
  Key := '/';
  if fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesStarmix.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesStarmix.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('STA');
  tinta := fGetConsultaTinta('STA');

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'STARMIX', 'USATIN', ''));
  conf.pInsereCodigo('PROSTA', 'Produto para venda', fArqIniTinta(0, 'STARMIX', 'PROSTA', ''));
  conf.pInsereCodigo('STAPLT', 'Preço de embalagem', fArqIniTinta(0, 'STARMIX', 'STAPLT', ''));
  conf.pInsereCodigo('STAPGL', 'Preço de galão', fArqIniTinta(0, 'STARMIX', 'STAPGL', ''));

  conf.pInsereCodigo('STAIGL', 'Item Embalagem galão', fArqIniTinta(0, 'STARMIX', 'STAIGL', ''));
  conf.pInsereCodigo('STAIEM', 'Item Embalagem litro', fArqIniTinta(0, 'STARMIX', 'STAIEM', ''));
  conf.pInsereCodigo('STAILA', 'Item Embalagem lata', fArqIniTinta(0, 'STARMIX', 'STAILA', ''));
  conf.pInsereCodigo('STAICO', 'Item Embalagem do Copo', fArqIniTinta(0, 'STARMIX', 'STAICO', ''));
  conf.pInsereCodigo('STAISP', 'Item Embalagem do Spray', fArqIniTinta(0, 'STARMIX', 'STAISP', ''));

  conf.pInsereCodigo('STAIMP', 'Percentual de impostos', fArqIniTinta(0, 'STARMIX', 'STAIMP', ''));
  conf.pInsereCodigo('FVESTA', 'Fator para geração Preço de Venda', fArqIniTinta(0, 'STARMIX', 'FVESTA', ''));
  conf.pInsereCodigo('STAPER', 'Percentual de Perda', fArqIniTinta(0, 'STARMIX', 'STAPER', ''));
  conf.pInsereCodigo('TRASTA', 'Trava para valor de venda STA_PRE', fArqIniTinta(0, 'STARMIX', 'TRASTA', ''));
  conf.pInsereCodigo('FATSTA', 'Fator', fArqIniTinta(0, 'STARMIX', 'FATSTA', ''));
  conf.pInsereCodigo('PATSTA', 'Path para arquivos (*.txt)', fArqIniTinta(0, 'STARMIX', 'PATSTA', ''));
  conf.pInsereCodigo('NFMSTA', 'Próximo código Nova Fórmula', fArqIniTinta(0, 'STARMIX', 'NFMSTA', ''));
  conf.pInsereCodigo('DESSTA', 'Desconto máximo', fArqIniTinta(0, 'STARMIX', 'DESSTA', ''));
  conf.pInsereCodigo('ACUABS', 'Valores da Formulação', fArqIniTinta(0, 'STARMIX', 'ACUABS', '1'));
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  conf.pInsereCodigo('DESPST', 'Utilizar descrição personalizada Starmix', 'S');

  pgcDados.ActivePageIndex := 0;
  frmConfConsultaStarmix   := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
end;

procedure TfrmConfiguracoesStarmix.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;


  pRetornaDescricaoItem(edtProSta);
  pRetornaDescricaoItem(edtStaIem);
  pRetornaDescricaoItem(edtStaIgl);
  pRetornaDescricaoItem(edtStaIla);
  pRetornaDescricaoItem(edtStaIco);
  pRetornaDescricaoItem(edtStaIsp);
end;

procedure TfrmConfiguracoesStarmix.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    pGravaArqIni;
    Close;
  End;
end;

procedure TfrmConfiguracoesStarmix.edtProStaKeyPress(Sender: TObject;
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

function TfrmConfiguracoesStarmix.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  //#Asimov# inherited fValidaCampos
  If not (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Exit(False);
  //

  Result := True;

  If (Sender = edtProSta) Then
  Begin
    If (fEmptyStr(edtProSta.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtProSta);
      If (fEmptyStr(edtDesProSta.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtStaPlt) Then
  Begin
    If (fEmptyStr(edtStaPlt.Text)) Then
    Begin
      edtStaPlt.Text := '0,00';
    End
    Else If (fStrToFloat(edtStaPlt.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço da embalagem (Litro) deve ser preenchido!', ['&Ok']);
      Result := False;      
    End;
  End

  Else If (Sender = edtStaIem) Then
  Begin
    If (fEmptyStr(edtStaIem.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para embalagem (Litro) deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtStaIem);
      If (fEmptyStr(edtDesStaIem.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtStaPgl) Then
  Begin
    If (fEmptyStr(edtStaPgl.Text)) Then
    Begin
      edtStaPlt.Text := '0,00';
    End
    Else If (fStrToFloat(edtStaPgl.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço da embalagem (Galão) deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtStaIgl) Then
  Begin
    If (fEmptyStr(edtStaIgl.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para embalagem (Galão) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtStaIgl);
      If (fEmptyStr(edtDesStaIgl.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtStaIla) Then
  Begin
    If (fEmptyStr(edtStaIla.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para embalagem (lata) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtStaIla);
      If (fEmptyStr(edtDesStaIla.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End


  Else If (Sender = edtStaIco) And (edtStaIco.Enabled) Then
  Begin
    If (fEmptyStr(edtStaIco.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para embalagem (Copo) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtStaIco);
      If (fEmptyStr(edtDesStaIco.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtStaIsp) And (edtStaIsp.Enabled) Then
  Begin
    If (fEmptyStr(edtStaIsp.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para embalagem (Spray) deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtStaIsp);
      If (fEmptyStr(edtDesStaIsp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtStaImp) Then
  Begin
    If (fEmptyStr(edtStaImp.Text)) Then
    Begin
      edtStaPlt.Text := '0,00';
    End
    Else If (fStrToFloat(edtStaImp.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O percentual de impostos deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFveSta) Then
  Begin
    If (fEmptyStr(edtFveSta.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para geração Preço de Venda deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtFveSta.Text) <= 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para geração Preço de Venda deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtStaPer) Then
  Begin
    If (fEmptyStr(edtStaPer.Text)) Then
    Begin
      edtStaPlt.Text := '0,00';
    End
    Else If (fStrToFloat(edtStaPer.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O percentual de perda deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtTraSta) Then
  Begin
    If (fEmptyStr(edtTraSta.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTraSta.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTraSta.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatSta) Then
  Begin
    If (fEmptyStr(edtFatSta.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFatSta.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = fraPatSta) Then
  Begin
    If (fEmptyStr(fraPatSta.edtDirectory.text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O path para os arquivos Txt deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      fraPatSta.edtDirectory.text := fGetPath(fraPatSta.edtDirectory.text);
    End;
  End

  Else If (Sender = edtDesSta) Then
  Begin
    If (fEmptyStr(edtDesSta.Text)) Then
    Begin
      edtDesSta.Text := '0,00';
    End
    Else If (fStrToFloat(edtDesSta.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O desconto máximo deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtAcuAbs) Then
  Begin
    Result := (Pos(edtAcuAbs.Text, '12') > 0);
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
  End

  Else If (Sender = edtDesPst) Then
  Begin
    Result := (Pos(edtDesPst.Text, 'SN') > 0);

    If Not Result Then
      fMensagem('ATENÇÃO!', 'O campo Utilizar descrição personalizada Starmix, aceita somente S ou N!', ['&Ok']);
  End;


  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmConfiguracoesStarmix.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaStarmix.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesStarmix.Destroy;
begin
  if Assigned(frmConfConsultaStarmix) then FreeAndNil(frmConfConsultaStarmix);
  inherited;
end;

end.
