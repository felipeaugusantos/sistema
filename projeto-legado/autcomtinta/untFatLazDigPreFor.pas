unit untFatLazDigPreFor;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, EditFocus, QColorLabel, AppEvnts, BitBtnLockedIncrem;

type
  TfrmFatLazDigPreFor = class(TfrmPaiSimples)
    pnlDados: TPanel;
    Label1: TLabel;
    edtDilCon: TEditFocus;
    ColorLabel1: TColorLabel;
    pnlConfirma: TPanel;
    Label2: TLabel;
    chkMeioQuarto: TCheckBox;
    chkUmQuarto: TCheckBox;
    chkDoisQuartos: TCheckBox;
    chkTresQuartos: TCheckBox;
    chkQuatroQuartos: TCheckBox;
    chk660ML: TCheckBox;
    Label3: TLabel;
    chk1320ML: TCheckBox;
    chk2640ML: TCheckBox;
    chk1980ML: TCheckBox;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure chkMeioQuartoClick(Sender: TObject);
    procedure chkUmQuartoClick(Sender: TObject);
    procedure chkDoisQuartosClick(Sender: TObject);
    procedure chkTresQuartosClick(Sender: TObject);
    procedure chkQuatroQuartosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chk660MLClick(Sender: TObject);
    procedure chk1320MLClick(Sender: TObject);
    procedure chk1980MLClick(Sender: TObject);
    procedure chk2640MLClick(Sender: TObject);
    procedure edtDilConChange(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    intLazQua: Integer;
    blnConfirma: Boolean;
  end;

var
  frmFatLazDigPreFor: TfrmFatLazDigPreFor;

implementation

uses  untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatLazDigPreFor.chkMeioQuartoClick(Sender: TObject);
begin
  inherited;
  If (chkMeioQuarto.Checked) Then
  Begin
    chkUmQuarto.Checked      := False;
    chkDoisQuartos.Checked   := False;
    chkTresQuartos.Checked   := False;
    chkQuatroQuartos.Checked := False;
    chk660ML.Checked         := False;
    chk1320ML.Checked        := False;
    chk1980ML.Checked        := False;
    chk2640ML.Checked        := False;
  End;
end;

procedure TfrmFatLazDigPreFor.chkUmQuartoClick(Sender: TObject);
begin
  inherited;
  If (chkUmQuarto.Checked) Then
  Begin
    chkMeioQuarto.Checked    := False;
    chkDoisQuartos.Checked   := False;
    chkTresQuartos.Checked   := False;
    chkQuatroQuartos.Checked := False;
    chk660ML.Checked         := False;
    chk1320ML.Checked        := False;
    chk1980ML.Checked        := False;
    chk2640ML.Checked        := False;
  End;
end;

procedure TfrmFatLazDigPreFor.chkDoisQuartosClick(Sender: TObject);
begin
  inherited;
  If (chkDoisQuartos.Checked) Then
  Begin
    chkMeioQuarto.Checked    := False;
    chkUmQuarto.Checked      := False;
    chkTresQuartos.Checked   := False;
    chkQuatroQuartos.Checked := False;
    chk660ML.Checked         := False;
    chk1320ML.Checked        := False;
    chk1980ML.Checked        := False;
    chk2640ML.Checked        := False;
  End;
end;

procedure TfrmFatLazDigPreFor.chkTresQuartosClick(Sender: TObject);
begin
  inherited;
  If (chkTresQuartos.Checked) Then
  Begin
    chkMeioQuarto.Checked    := False;
    chkUmQuarto.Checked      := False;
    chkDoisQuartos.Checked   := False;
    chkQuatroQuartos.Checked := False;
    chk660ML.Checked         := False;
    chk1320ML.Checked        := False;
    chk1980ML.Checked        := False;
    chk2640ML.Checked        := False;
  End;
end;

procedure TfrmFatLazDigPreFor.chkQuatroQuartosClick(Sender: TObject);
begin
  inherited;
  If (chkQuatroQuartos.Checked) Then
  Begin
    chkMeioQuarto.Checked    := False;
    chkUmQuarto.Checked      := False;
    chkDoisQuartos.Checked   := False;
    chkTresQuartos.Checked   := False;
    chk660ML.Checked         := False;
    chk1320ML.Checked        := False;
    chk1980ML.Checked        := False;
    chk2640ML.Checked        := False;
  End;
end;

function TfrmFatLazDigPreFor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDilCon) Then
    Begin
      If fEmptyStr((edtDilCon.Text)) Then
      Begin
        Result := False;
      End
      Else If (Pos(edtDilCon.Text, 'DC') <= 0) Then
      Begin
        Result := False;
      End
    End;

  End; 

end;

procedure TfrmFatLazDigPreFor.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin

    {*****************************************}
    {* VALIDA OS CHECK BOX DE "QUARTO"       *}
    {**************************************MV*}
    If (Not chkMeioQuarto.Checked)    And
       (Not chkUmQuarto.Checked)      And
       (Not chkDoisQuartos.Checked)   And
       (Not chkTresQuartos.Checked)   And
       (Not chkQuatroQuartos.Checked) And
       (Not chk660ML.Checked)         And
       (Not chk1320ML.Checked)        And
       (Not chk1980ML.Checked)        And
       (Not chk2640ML.Checked)        Then
    Begin
      fMensagem('', 'É necessário escolher pelo menos um item!', ['&O k']);
      Exit;
    End;

    intLazQua := -1;
    If (chkMeioQuarto.Checked) Then
      intLazQua := 0
    Else If (chkUmQuarto.Checked) Then
      intLazQua := 1
    Else If (chkDoisQuartos.Checked) Then
      intLazQua := 2
    Else If (chkTresQuartos.Checked) Then
      intLazQua := 3
    Else If (chkQuatroQuartos.Checked) Then
      intLazQua := 4
    Else If (chk660ML.Checked) Then
      intLazQua := 1
    Else If (chk1320ML.Checked) Then
      intLazQua := 2
    Else If (chk1980ML.Checked) Then
      intLazQua := 3
    Else If (chk2640ML.Checked) Then
      intLazQua := 4;

    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmFatLazDigPreFor.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

end;

procedure TfrmFatLazDigPreFor.FormShow(Sender: TObject);
begin
  inherited;
  Self.Height := 206;
//  Case intLazQua Of
//    0: chkMeioQuarto.Checked    := True;
//    1: chkUmQuarto.Checked      := True;
//    2: chkDoisQuartos.Checked   := True;
//    3: chkTresQuartos.Checked   := True;
//    4: chkQuatroQuartos.Checked := True;
//  End;

end;

procedure TfrmFatLazDigPreFor.chk660MLClick(Sender: TObject);
begin
  inherited;
  If (chk660ML.Checked) Then
  Begin
    chkMeioQuarto.Checked    := False;
    chkUmQuarto.Checked      := False;
    chkDoisQuartos.Checked   := False;
    chkTresQuartos.Checked   := False;
    chkQuatroQuartos.Checked := False;
    chk1320ML.Checked        := False;
    chk1980ML.Checked        := False;
    chk2640ML.Checked        := False;
  End;
end;

procedure TfrmFatLazDigPreFor.chk1320MLClick(Sender: TObject);
begin
  inherited;
  If (chk1320ML.Checked) Then
  Begin
    chkMeioQuarto.Checked    := False;
    chkUmQuarto.Checked      := False;
    chkDoisQuartos.Checked   := False;
    chkTresQuartos.Checked   := False;
    chkQuatroQuartos.Checked := False;
    chk660ML.Checked         := False;
    chk1980ML.Checked        := False;
    chk2640ML.Checked        := False;
  End;
end;

procedure TfrmFatLazDigPreFor.chk1980MLClick(Sender: TObject);
begin
  inherited;
  If (chk1980ML.Checked) Then
  Begin
    chkMeioQuarto.Checked    := False;
    chkUmQuarto.Checked      := False;
    chkDoisQuartos.Checked   := False;
    chkTresQuartos.Checked   := False;
    chkQuatroQuartos.Checked := False;
    chk660ML.Checked         := False;
    chk1320ML.Checked        := False;
    chk2640ML.Checked        := False;
  End;
end;

procedure TfrmFatLazDigPreFor.chk2640MLClick(Sender: TObject);
begin
  inherited;
  If (chk2640ML.Checked) Then
  Begin
    chkMeioQuarto.Checked    := False;
    chkUmQuarto.Checked      := False;
    chkDoisQuartos.Checked   := False;
    chkTresQuartos.Checked   := False;
    chkQuatroQuartos.Checked := False;
    chk660ML.Checked         := False;
    chk1320ML.Checked        := False;
    chk1980ML.Checked        := False;
  End;
end;

procedure TfrmFatLazDigPreFor.edtDilConChange(Sender: TObject);
begin
  inherited;
  chkUmQuarto.Checked := True;
  If (edtDilCon.Text = 'D') Then
  Begin
    chk660ML.Visible := True;
    chk1320ML.Visible := True;
    chk1980ML.Visible := True;
    chk2640ML.Visible := True;

    Self.Height := 265;
  End
  Else
  Begin
    chk660ML.Visible := False;
    chk1320ML.Visible := False;
    chk1980ML.Visible := False;
    chk2640ML.Visible := False;

    Self.Height := 207;
  End;
end;

end.
