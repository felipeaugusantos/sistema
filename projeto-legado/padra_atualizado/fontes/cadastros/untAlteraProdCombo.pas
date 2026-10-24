unit untAlteraProdCombo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, ComboBoxFocus, untTypesSistema;

type
  TfrmAlteraProdCombo = class(TfrmPaiConfirma)
    Panel1: TPanel;
    pnlOpcoes: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblValDes: TLabel;
    cmbBrinde: TComboBoxFocus;
    cmbTabPre: TComboBoxFocus;
    cmbOperad: TComboBoxFocus;
    cmbTipDes: TComboBoxFocus;
    edtValDes: TEditFocus;
    lblQtdIte: TLabel;
    edtQtdIte: TEditFocus;
    procedure cmbBrindeChange(Sender: TObject);
    procedure cmbTipDesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    intDecQtd: Integer;
    procedure pAjustaTela;
    procedure pAjustaCombos;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    tipTipPro: TTipProCombo;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmAlteraProdCombo }

procedure TfrmAlteraProdCombo.cmbBrindeChange(Sender: TObject);
begin
  inherited;
  If (cmbBrinde.ItemIndex = 0) Then
  Begin
    cmbTabPre.ItemIndex := -1;
    cmbOperad.ItemIndex := -1;
    cmbTipDes.ItemIndex := -1;

    edtValDes.Text := '0,00';

    cmbTabPre.Enabled := False;
    cmbOperad.Enabled := False;
    cmbTipDes.Enabled := False;
    edtValDes.Enabled := False;
  End
  Else
  Begin
    cmbTabPre.Enabled := True;
    cmbOperad.Enabled := True;
    cmbTipDes.Enabled := True;
    edtValDes.Enabled := True;
  End;
end;

procedure TfrmAlteraProdCombo.cmbTipDesChange(Sender: TObject);
begin
  inherited;
  If (cmbTipDes.ItemIndex = 1) Then
    lblValDes.Caption := 'Valor Desc.:'
  Else
    lblValDes.Caption := 'Perc. Desc.:';
end;

procedure TfrmAlteraProdCombo.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtQtdIte);
end;

procedure TfrmAlteraProdCombo.FormCreate(Sender: TObject);
begin
  inherited;
  pAjustaCombos;
end;

procedure TfrmAlteraProdCombo.FormShow(Sender: TObject);
begin
  inherited;
  pAjustaTela;

  pSetaCodIte( edtCodIte );

end;

function TfrmAlteraProdCombo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtQtdIte) Then
    Begin
      If (fEmptyStr(edtQtdIte.Text)) Then
        edtQtdIte.Text := '0,00';

      edtQtdIte.Text := FormatFloat(fMskDigitos(intDecQtd), fstrToFloat(edtQtdIte.Text));

      If (fStrToFloat(edtQtdIte.Text) <= 0) Then
      Begin
        fMensagem('', 'A Quantidade deve ser maior que zero!', ['&OK']);
        edtQtdIte.SelectAll;
        Result := False;
      End;
    End

    Else If (Sender = cmbBrinde) Then
    Begin
      If (pnlOpcoes.Visible) And (cmbBrinde.ItemIndex = -1) Then
      Begin
        fMensagem('', 'Favor informar se o Produto será Brinde!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbTabPre) Then
    Begin
      If (pnlOpcoes.Visible) And (cmbTabPre.Enabled) And (cmbTabPre.ItemIndex = -1) Then
      Begin
        fMensagem('', 'Favor informar a Tabela de Preço!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbOperad) Then
    Begin
      If (pnlOpcoes.Visible) And (cmbOperad.Enabled) And (cmbOperad.ItemIndex = -1) Then
      Begin
        fMensagem('', 'Favor informar o Operador!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = cmbTipDes) Then
    Begin
      If (pnlOpcoes.Visible) And (cmbTipDes.Enabled) And (cmbTipDes.ItemIndex = -1) Then
      Begin
        fMensagem('', 'Favor informar o Tipo de Desconto!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtValDes) Then
    Begin
      If (pnlOpcoes.Visible) And (edtValDes.Enabled) Then
      Begin
        If (fEmptyStr(edtValDes.Text)) Then
          edtValDes.Text := FormatFloat('#,##0.00', 0)
        Else
          edtValDes.Text := FormatFloat('#,##0.00', fStrToFloat(edtValDes.Text));

        If (fStrToFloat(edtValDes.Text) < 0) Then
        Begin
          fMensagem('', 'O Valor do Desconto deve ser maior ou igual a zero!', ['&OK']);
          edtValDes.SelectAll;
          Result := False;
        End;
      End
      Else
        edtValDes.Text := FormatFloat('#,##0.00', 0);
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmAlteraProdCombo.pAjustaCombos;
Var
  intContador: Integer;
begin
  cmbTabPre.Clear;

  cmbTabPre.Items.Add('FAT');

  For intContador := 1 To Length(VS_strTabVen) Do
  Begin
    If (VS_strTabVen[intContador] = 'S' ) Then
      cmbTabPre.Items.Add(intToStr(intContador));
  End;

  cmbBrinde.ItemIndex := -1;
  cmbTabPre.ItemIndex := -1;
  cmbOperad.ItemIndex := -1;
  cmbTipDes.ItemIndex := -1;
end;

procedure TfrmAlteraProdCombo.pAjustaTela;
begin
  If (tipTipPro in [pcoAtivacao, pcoSimilar]) Then
  Begin
    If (tipTipPro = pcoSimilar) Then
    Begin
      lblQtdIte.Visible := False;
      edtQtdIte.Visible := False;
    End;

    pnlOpcoes.Visible := False;
    Self.Height := Self.Height - pnlOpcoes.Height + 3;
  End;
end;

end.
