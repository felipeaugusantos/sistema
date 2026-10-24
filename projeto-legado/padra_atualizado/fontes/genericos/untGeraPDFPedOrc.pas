unit untGeraPDFPedOrc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, QColorLabel, StdCtrls, EditFocus, AppEvnts, Menus, untTypesSistema,
  Buttons, ExtCtrls, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmGeraPDFPedOrc = class(TfrmPai)
    pnlPrincipal: TPanel;
    gpbOrdem: TGroupBox;
    ColorLabel2: TColorLabel;
    edtOrdem: TEditFocus;
    ColorLabel1: TColorLabel;
    rdgNomEmp: TRadioGroup;
    gpbPreco: TGroupBox;
    lbl1: TColorLabel;
    edtPreco: TEditFocus;
    btnConfirma: TBitBtnLocked;
    pnlPaisagem: TPanel;
    chkMarca: TCheckBox;
    chkLocFis: TCheckBox;
    gpbModo: TGroupBox;
    lbl2: TColorLabel;
    edtModo: TEditFocus;
    pnlEmpCab: TPanel;
    GroupBox1: TGroupBox;
    ColorLabel3: TColorLabel;
    ColorLabel4: TColorLabel;
    edtEmpCab: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    opcComSemPreco: TImpressaoComSemPrecoOrPd;
    strEspDoc: String;
  end;

var
  frmGeraPDFPedOrc: TfrmGeraPDFPedOrc;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmGeraPDFPedOrc }

procedure TfrmGeraPDFPedOrc.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtOrdem);
end;

procedure TfrmGeraPDFPedOrc.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (ActiveControl Is TRadioButton) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraPDFPedOrc.FormShow(Sender: TObject);
begin

  inherited;

  If (fCfgSis('UTIDEF', varBoolean) And (fGetUtilizaLayoutFR3EspecificoImpDefAmbiente(strEspDoc))) Then
  Begin
    Self.Height := Self.Height - pnlPaisagem.Height;
    pnlPrincipal.Visible := True;
    pnlPaisagem.Visible  := False;
  End
  Else
  Begin
    pnlPrincipal.Visible := True;
    pnlPaisagem.Visible  := True;
  End;

  If (Not pnlEmpCab.Visible) Then
    Self.Height := Self.Height - pnlEmpCab.Height;
end;

function TfrmGeraPDFPedOrc.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtOrdem) Then
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
  Else If (Sender = edtModo) Then
  Begin

    If Pos(edtModo.Text,'R_P_') <= 0 Then
    Begin
      fMensagem('','O campo Modo deve ser R ou P.',['&O K']);
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

procedure TfrmGeraPDFPedOrc.btnConfirmaClick(Sender: TObject);
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
  
  If (fVerificaCampos) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;

end;

end.
