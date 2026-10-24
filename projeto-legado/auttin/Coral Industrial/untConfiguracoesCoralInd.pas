unit untConfiguracoesCoralInd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, FilenameEditFocus, DirectoryEditFocus, StrUtils,
  AppEvnts, Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesCoralInd = class(TfrmPai)
    pnlCentral: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label20: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    chkUsaCor: TCheckBox;
    edtDesCor: TEditFocus;
    edtProCor: TEditFocus;
    edtTraCor: TEditFocus;
    edtFatCor: TEditFocus;
    edtNfmCor: TEditFocus;
    Label13: TLabel;
    edtMarCor: TEditFocus;
    pnlCabecalho: TPanel;
    chkUsaFor: TCheckBox;
    btnGravarConf: TBitBtnLocked;
    fraTxtCor: TfraDirectoryEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtProCorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmConfiguracoesCoralInd: TfrmConfiguracoesCoralInd;

implementation

uses untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmConfiguracoesCoralInd }

function TfrmConfiguracoesCoralInd.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  //#Asimov# inherited fValidaCampos
  If not (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Exit(False);
  //

  Result := True;

  If (Sender = fraTxtCor) Then
  Begin
    If (fEmptyStr(fraTxtCor.edtDirectory.text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O path para o arquivo TXT deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      fraTxtCor.edtDirectory.text := fGetPath(fraTxtCor.edtDirectory.text);
      If (RightStr(fraTxtCor.edtDirectory.text, 1) = '\') Then
        fraTxtCor.edtDirectory.text := Copy(fraTxtCor.edtDirectory.text, 1, Length(fraTxtCor.edtDirectory.text)-1);
    End;
  End

  Else If (Sender = edtNfmCor) Then
  Begin
    If (fEmptyStr(edtNfmCor.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O próximo codigo para novas formulas deve ser preenchido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtProCor) Then
  Begin
    If (fEmptyStr(edtProCor.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtDesCor.Text := fRetNomProduto(edtProCor.Text);
      If (fEmptyStr(edtDesCor.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtTraCor) Then
  Begin
    If (fEmptyStr(edtTraCor.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTraCor.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTraCor.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatCor) Then
  Begin
    If (fEmptyStr(edtFatCor.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFatCor.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtMarCor) Then
  Begin
    If (fEmptyStr(edtMarCor.Text)) Then
      edtMarCor.Text := '0,00'
    Else If fStrToFloat(edtMarCor.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A margem de lucro do colorante deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End;

end;

procedure TfrmConfiguracoesCoralInd.pCarregaArqIni;
begin

  chkUsaCor.Checked := (fArqIniTinta(0, 'Coral Industrial', 'USATIN', '') = 'S');
  chkUsaFor.Checked := (fArqIniTinta(0, 'USA_FORMUL', 'CID', 'S') = 'S');
  fraTxtCor.edtDirectory.text := fArqIniTinta(0, 'Coral Industrial', 'TXTCOR', '');
  edtNfmCor.Text := fArqIniTinta(0, 'Coral Industrial', 'NFMCOR', '');
  edtProCor.Text := fArqIniTinta(0, 'Coral Industrial', 'PROCOR', '');
  edtTraCor.Text := fArqIniTinta(0, 'Coral Industrial', 'TRACOR', '');
  edtFatCor.Text := fArqIniTinta(0, 'Coral Industrial', 'FATCOR', '');
  edtMarCor.Text := fArqIniTinta(0, 'Coral Industrial', 'MARCOR', '');

end;

procedure TfrmConfiguracoesCoralInd.pGravaArqIni;
  Var
    strUsaTin: String;
    strUsaFor: String;
begin

  If (chkUsaCor.Checked) Then
    strUsaTin := 'S'
  Else
    strUsaTin := 'N';

  strUsaFor := IIF(chkUsaFor.Checked, 'S', 'N');

  fArqIniTinta(1, 'Coral Industrial', 'USATIN', strUsaTin);
  fArqIniTinta(1, 'USA_FORMUL', 'CID', strUsaFor);
  fArqIniTinta(1, 'Coral Industrial', 'TXTCOR', fraTxtCor.edtDirectory.text);
  fArqIniTinta(1, 'Coral Industrial', 'NFMCOR', edtNfmCor.Text);
  fArqIniTinta(1, 'Coral Industrial', 'PROCOR', edtProCor.Text);
  fArqIniTinta(1, 'Coral Industrial', 'TRACOR', edtTraCor.Text);
  fArqIniTinta(1, 'Coral Industrial', 'FATCOR', edtFatCor.Text);
  fArqIniTinta(1, 'Coral Industrial', 'MARCOR', edtMarCor.Text);

end;

procedure TfrmConfiguracoesCoralInd.btnGravarConfClick(Sender: TObject);
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

procedure TfrmConfiguracoesCoralInd.FormCreate(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
end;

procedure TfrmConfiguracoesCoralInd.FormShow(Sender: TObject);
begin
  inherited;
  edtDesCor.Text := fRetNomProduto(edtProCor.Text);
end;

procedure TfrmConfiguracoesCoralInd.edtProCorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqColorantes(Self, conBzi, edtProCor, edtDesCor, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

end.
