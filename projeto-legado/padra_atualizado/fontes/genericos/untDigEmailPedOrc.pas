unit untDigEmailPedOrc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, QColorLabel, StdCtrls, EditFocus, AppEvnts, Menus, untTypesSistema,
  Buttons, ExtCtrls, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigEmailPedOrc = class(TfrmPai)
    pnlPrincipal: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtEmail: TEditFocus;
    edtContato: TEditFocus;
    gpbOrdem: TGroupBox;
    lbl1: TColorLabel;
    ColorLabel1: TColorLabel;
    edtOrdem: TEditFocus;
    rdgNomEmp: TRadioGroup;
    btnConfirma: TBitBtnLocked;
    pnlPrecoExport: TPanel;
    gbPreco: TGroupBox;
    ColorLabel2: TColorLabel;
    edtPreco: TEditFocus;
    gbExporta: TGroupBox;
    lblPdfExc: TColorLabel;
    edtTipExp: TEditFocus;
    pnlModo: TPanel;
    gpbModo: TGroupBox;
    lbl2: TColorLabel;
    edtModo: TEditFocus;
    pnlEmpCab: TPanel;
    GroupBox1: TGroupBox;
    ColorLabel3: TColorLabel;
    ColorLabel4: TColorLabel;
    edtEmpCab: TEditFocus;
    chkAnexar: TCheckBox;
    chkMarca: TCheckBox;
    chkLocFis: TCheckBox;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtTipExpExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    opcComSemPreco: TImpressaoComSemPrecoOrPd;
    strTipExp, strEspDoc: String;
  end;

var
  frmDigEmailPedOrc: TfrmDigEmailPedOrc;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmDigEmailPedOrc }

function TfrmDigEmailPedOrc.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtEmail) Then
  Begin
    If (fEmptyStr(edtEmail.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O email deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (Pos('@', edtEmail.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', edtEmail.Text + ' não é um email válido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtContato) Then
  Begin
    If (fEmptyStr(edtContato.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O contato deve ser preenchido!', ['&Ok']);
      Result := False;
    End
  End

  Else If (Sender = edtOrdem) Then
  Begin
    If Pos(edtOrdem.Text,'1_2_3_') <= 0 Then
    Begin
      fMensagem('','O campo Ordem deve ser 1, 2 ou 3.',['&O K']);
      Result := False;
    End;
  End

  Else If (Sender = edtPreco) Then
  Begin
    If Pos(edtPreco.Text,'C_S_') <= 0 Then
    Begin
      fMensagem('','O campo Preço deve ser C ou S.',['&O K']);
      Result := False;
    End;
  End

  Else If (Sender = edtModo) And (Pos(edtTipExp.Text, 'E_C_') <= 0) Then
  Begin
    If Pos(edtModo.Text,'R_P_') <= 0 Then
    Begin
      fMensagem('','O campo Modo deve ser R ou P.',['&O K']);
      Result := False;
    End;
  End

  Else If (Sender = edtTipExp) Then
  Begin
    If (fCfgSis('EXPDOR') = 1) And (Pos(edtTipExp.Text,'P_E_') <= 0) Then
    Begin
      fMensagem('','O campo Exportar em deve ser P ou E.',['&O K']);
      Result := False;
    End
    Else If (fCfgSis('EXPDOR') = 2) And (Pos(edtTipExp.Text,'P_C_') <= 0) Then
    Begin
      fMensagem('','O campo Exportar em deve ser P ou C.',['&O K']);
      Result := False;
    End;
  End

  Else If (Sender = edtEmpCab) Then
  Begin
    If (pnlEmpCab.Visible) And (Pos(edtEmpCab.Text, '1_2_') <= 0) Then
    Begin
      fMensagem('','O campo deve ser 1 ou 2.',['&OK']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmDigEmailPedOrc.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  opcComSemPreco := IIF((edtPreco.Text = 'C'), impComPrecoGeral, impSemPrecoGeral) ;

  If (fCfgSis('ORCSPR', varBoolean, VS_strCodEmp)) And (fCfgSis('ORSPSM', varBoolean, VS_strCodEmp)) Then
  Begin
    If (edtPreco.Text = 'C') And (chkMarca.Checked) Then 
      opcComSemPreco := impComPrecoComMarca
    Else If (edtPreco.Text = 'C') And (Not chkMarca.Checked) Then
      opcComSemPreco := impComPrecoSemMarca
    Else If (edtPreco.Text = 'S') And (chkMarca.Checked) Then
      opcComSemPreco := impSemPrecoComMarca
    Else If (edtPreco.Text = 'S') And (Not chkMarca.Checked) Then
      opcComSemPreco := impSemPrecoSemMarca;
  End;

  If (opcComSemPreco in [impComPrecoComMarca, impComPrecoGeral, impComPrecoSemMarca]) Then
  Begin
    If (fCfgSis('ORCSPR', varBoolean, VS_strCodEmp)) And (Not fEmptyStr(fCfgSis('SENPRE'))) Then
    Begin
      ffrmSenha(strSenha,'Senha para Impressão do Preço');
      opcComSemPreco := IIF(strSenha = fCfgSis('SENPRE',varString), opcComSemPreco, impSemPrecoGeral);

      If (fCfgSis('ORSPSM', varBoolean, VS_strCodEmp)) Then
      Begin
        If (opcComSemPreco = impSemPrecoGeral) Then
        Begin
          Case fGetMenu('Opção para geração do PDF ("Sem Preço" pois não houve liberação!)',['Sem Preço e Com Marca', 'Sem Preço e Sem Marca'], 1) Of
            1:opcComSemPreco := impSemPrecoComMarca;
            2:opcComSemPreco := impSemPrecoSemMarca;
          End;
        End;
      End;
    End;
  End;

  strTipExp :=  edtTipExp.Text;

  If (strTipExp = 'C') Then
    strTipExp := 'E';

  If (fVerificaCampos)                                       And
     (fMensagem('', 'Enviar e-mail?', ['&Sim', '&Não']) = 1) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;

end;

procedure TfrmDigEmailPedOrc.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtEmail);
end;

procedure TfrmDigEmailPedOrc.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (ActiveControl Is TRadioButton) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigEmailPedOrc.FormShow(Sender: TObject);
begin

  inherited;

  If (fCfgSis('UTIDEF', varBoolean) And (fGetUtilizaLayoutFR3EspecificoImpDefAmbiente(strEspDoc))) Then
  Begin
    Self.Height := Self.Height - pnlModo.Height;

    pnlPrincipal.Visible   := True;
    pnlPrecoExport.Visible := True;
    pnlModo.Visible        := False;
  End
  Else
  Begin
    pnlPrincipal.Visible   := True;
    pnlPrecoExport.Visible := True;
    pnlModo.Visible        := True;
  End;

  If (fCfgSis('EXPDOR') = 2) Then
    lblPdfExc.Caption := '(P)df (C)alc-BrOffice';

  If (Not pnlEmpCab.Visible) Then
    Self.Height := Self.Height - pnlEmpCab.Height;
end;

procedure TfrmDigEmailPedOrc.edtTipExpExit(Sender: TObject);
begin
  If edtTipExp.Text = 'P' Then
  Begin
    gpbModo.Enabled := True;
    edtModo.Enabled := True;
    edtModo.Text    := 'R';
  End
  Else
  Begin
    gpbModo.Enabled := False;
    edtModo.Enabled := False;
    edtModo.Text    := '';
  End;
end;

end.
