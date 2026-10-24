unit untConfiguracoesBrasimixImob;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  FilenameEditFocus, StrUtils, AppEvnts, Uni, ComCtrls,
  untConfConsulta,  untIConfTinta, untIConsultaTinta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxClasses, cxStyles,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmConfiguracoesBrasimixImob = class(TfrmPai)
    pnlCabecalho: TPanel;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    tbsConfCampos: TTabSheet;
    pnlCentral: TPanel;
    Label6: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label20: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    chkUsaBri: TCheckBox;
    edtDesBri: TEditFocus;
    edtProBri: TEditFocus;
    edtTraBri: TEditFocus;
    edtFatBri: TEditFocus;
    edtNfmBri: TEditFocus;
    chkUsaFor: TCheckBox;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label22: TLabel;
    edtApreve: TEditFocus;
    edtTxtBri: TFilenameEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtProBriKeyPress(Sender: TObject; var Key: Char);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    { Private declarations }
    frmConfConsultaBrasimixImob: TfrmConfConsulta;
    tinta: IConsultaTinta ;
    conf: IConfTinta;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesBrasimixImob: TfrmConfiguracoesBrasimixImob;

implementation

uses  untFuncTinta,  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmConfiguracoesBrasimix }

function TfrmConfiguracoesBrasimixImob.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtProBri) Then
  Begin
    If (fEmptyStr(edtProBri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtDesBri.Text := fRetNomProduto(edtProBri.Text);
      If (fEmptyStr(edtDesBri.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtTraBri) Then
  Begin
    If (fEmptyStr(edtTraBri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTraBri.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTraBri.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatBri) Then
  Begin
    If (fEmptyStr(edtFatBri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFatBri.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtDesOpe) Then
  Begin
    If (fEmptyStr(edtDesOpe.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtDesOpe.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtApreve) Then
  Begin
    If (fEmptyStr(edtApreve.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtApreve.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End


  Else If (Sender = edtNfmBri) Then
  Begin
    If (fEmptyStr(edtNfmBri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O próximo codigo para novas formulas deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtTxtBri) Then
  Begin
    If (fEmptyStr(edtTxtBri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O path para o arquivo TXT deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtTxtBri.Text := fGetPath(edtTxtBri.Text);
      If (RightStr(edtTxtBri.Text, 1) = '\') Then
        edtTxtBri.Text := Copy(edtTxtBri.Text, 1, Length(edtTxtBri.Text)-1);
    End;
  End;

end;

procedure TfrmConfiguracoesBrasimixImob.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA BRASIMIX             *}
  {**************************************MV*}
{
  chkUsaBri.Checked := (fArqIniTinta(0, 'Brasimix Imobiliaria', 'USATIN', '') = 'S');
  chkUsaFor.Checked := fArqIniTinta(0, 'USA_FORMUL', 'BZI', 'S') = 'S';
  edtProBri.Text    := fArqIniTinta(0, 'Brasimix Imobiliaria', 'PROBRI', '');
  edtTraBri.Text    := fArqIniTinta(0, 'Brasimix Imobiliaria', 'TRABRI', '');
  edtFatBri.Text    := fArqIniTinta(0, 'Brasimix Imobiliaria', 'FATBRI', '');
  edtNfmBri.Text    := fArqIniTinta(0, 'Brasimix Imobiliaria', 'NFMBRI', '');
  edtTxtBri.Text    := fArqIniTinta(0, 'Brasimix Imobiliaria', 'TXTBRI', '');
}


  conf := fGetConfTinta('BZI');

  chkUsaBri.Checked := conf.fGetBoolean('USATIN'); //(fArqIniTinta(0, 'Brasimix Imobiliaria', 'USATIN', '') = 'S');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR'); //fArqIniTinta(0, 'USA_FORMUL', 'BZI', 'S') = 'S';
  edtProBri.Text    := conf.fGet('PROBRI'); //fArqIniTinta(0, 'Brasimix Imobiliaria', 'PROBRI', '');
  edtTraBri.Text    := conf.fGet('TRABRI'); //fArqIniTinta(0, 'Brasimix Imobiliaria', 'TRABRI', '');
  edtFatBri.Text    := conf.fGet('FATBRI'); //fArqIniTinta(0, 'Brasimix Imobiliaria', 'FATBRI', '');
  edtNfmBri.Text    := conf.fGet('NFMBRI'); //fArqIniTinta(0, 'Brasimix Imobiliaria', 'NFMBRI', '');
  edtTxtBri.Text    := conf.fGet('TXTBRI'); //fArqIniTinta(0, 'Brasimix Imobiliaria', 'TXTBRI', '');
  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');

end;

procedure TfrmConfiguracoesBrasimixImob.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesBrasimixImob.pGravaArqIni;
begin

  {*****************************************}
  {* GRAVA DADOS DA BRASIMIX               *}
  {**************************************MV*}
{
  If chkUsaBri.Checked Then
    strUsaTin := 'S'
  Else
    strUsaTin := 'N';

  strUsaFor := IIF(chkUsaFor.Checked, 'S', 'N');

  fArqIniTinta(1, 'Brasimix Imobiliaria', 'USATIN', strUsaTin);
  fArqIniTinta(1, 'USA_FORMUL', 'BZI', strUsaFor);
  fArqIniTinta(1, 'Brasimix Imobiliaria', 'PROBRI', edtProBri.Text);
  fArqIniTinta(1, 'Brasimix Imobiliaria', 'TRABRI', edtTraBri.Text);
  fArqIniTinta(1, 'Brasimix Imobiliaria', 'FATBRI', edtFatBri.Text);
  fArqIniTinta(1, 'Brasimix Imobiliaria', 'NFMBRI', edtNfmBri.Text);
  fArqIniTinta(1, 'Brasimix Imobiliaria', 'TXTBRI', edtTxtBri.Text);
}

  conf.pSetBoolean('USATIN', chkUsaBri.Checked); //fArqIniTinta(1, 'Brasimix Imobiliaria', 'USATIN', strUsaTin);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked); //fArqIniTinta(1, 'USA_FORMUL', 'BZI', strUsaFor);
  conf.pSet('PROBRI', edtProBri.Text); //fArqIniTinta(1, 'Brasimix Imobiliaria', 'PROBRI', edtProBri.Text);
  conf.pSet('TRABRI', edtTraBri.Text); //fArqIniTinta(1, 'Brasimix Imobiliaria', 'TRABRI', edtTraBri.Text);
  conf.pSet('FATBRI', edtFatBri.Text); //fArqIniTinta(1, 'Brasimix Imobiliaria', 'FATBRI', edtFatBri.Text);
  conf.pSet('NFMBRI', edtNfmBri.Text); //fArqIniTinta(1, 'Brasimix Imobiliaria', 'NFMBRI', edtNfmBri.Text);
  conf.pSet('TXTBRI', edtTxtBri.Text); //fArqIniTinta(1, 'Brasimix Imobiliaria', 'TXTBRI', edtTxtBri.Text);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaBrasimixImob.pSalvarConfs;
end;

procedure TfrmConfiguracoesBrasimixImob.btnGravarConfClick(
  Sender: TObject);
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

procedure TfrmConfiguracoesBrasimixImob.FormCreate(Sender: TObject);
begin
  inherited;
  conf  := fGetConfTinta('BZI');
  tinta := fGetConsultaTinta('BZI');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}
  
  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'Brasimix Imobiliaria', 'USATIN', ''));
  conf.pInsereCodigo('USAFOR', 'Utilizar formução', fArqIniTinta(0, 'USA_FORMUL', 'BZI', 'S'));
  conf.pInsereCodigo('PROBRI', 'Produto para venda', fArqIniTinta(0, 'Brasimix Imobiliaria', 'PROBRI', ''));
  conf.pInsereCodigo('TRABRI', 'Trava para valor de venda BZI_PRE', fArqIniTinta(0, 'Brasimix Imobiliaria', 'TRABRI', ''));
  conf.pInsereCodigo('FATBRI', 'Fator', fArqIniTinta(0, 'Brasimix Imobiliaria', 'FATBRI', ''));
  conf.pInsereCodigo('NFMBRI', 'Próximo código Nova Fórmula', fArqIniTinta(0, 'Brasimix Imobiliaria', 'NFMBRI', ''));
  conf.pInsereCodigo('TXTBRI', 'Path para arquivo TXT', fArqIniTinta(0, 'Brasimix Imobiliaria', 'TXTBRI', ''));
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregaArqIni;
  pgcDados.ActivePageIndex    := 0;
  frmConfConsultaBrasimixImob := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
  edtDesBri.Text := fRetNomProduto(edtProBri.Text);
end;

procedure TfrmConfiguracoesBrasimixImob.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaBrasimixImob.pRestaurarPadrao;
end;

destructor TfrmConfiguracoesBrasimixImob.Destroy;
begin
  if Assigned(frmConfConsultaBrasimixImob) then FreeAndNil(frmConfConsultaBrasimixImob);
  inherited;
end;

procedure TfrmConfiguracoesBrasimixImob.edtProBriKeyPress(Sender: TObject; var Key: Char);
  var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtProBri, edtDesBri, nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtProBri) then
      SelectNext(ActiveControl, True, True);
  End;

end;

end.
