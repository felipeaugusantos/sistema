unit untPopUpDireitoAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.ExtCtrls;

type
  TfrmPopUpDireitoAcesso = class(TForm)
    lstOperadores: TListBox;
    pnlOpcoes: TPanel;
    rdbOperadores: TRadioButton;
    rdbGrupos: TRadioButton;
    pnlListas: TPanel;
    lstGrupos: TListBox;
    procedure FormShow(Sender: TObject);
    procedure lstOperadoresDblClick(Sender: TObject);
    procedure rdbGruposClick(Sender: TObject);
    procedure lstGruposKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure MostrarLista;
    procedure DefineTamanhoEPosicaoDoForm(QtdeItens:Integer);
  public
    strItemSelecionado: String;
    { Public declarations }
  end;

var
  frmPopUpDireitoAcesso: TfrmPopUpDireitoAcesso;

implementation

{$R *.dfm}

procedure TfrmPopUpDireitoAcesso.DefineTamanhoEPosicaoDoForm(
  QtdeItens: Integer);
Var
  QtdItensSemRolagem,
  LimiteTop,
  TopMedio : Integer;
Begin
  QtdItensSemRolagem := (Screen.WorkAreaHeight - 138) div 14;

  If (QtdeItens > QtdItensSemRolagem) Then
  Begin
    Self.Height := Screen.WorkAreaHeight;
    Self.Top    := 0;
  End
  Else
  Begin
    Self.Height := (QtdeItens * 14) + (pnlOpcoes.Height + 45);

    LimiteTop   := Screen.WorkAreaHeight - Self.Height;
    TopMedio    := Mouse.CursorPos.Y - (370 Div 2);

    If (TopMedio < 0) Then
      Self.Top  := 0

    ELse If (TopMedio > LimiteTop) Then
      Self.Top  := LimiteTop

    Else
      Self.Top  := TopMedio;
  End;
end;

procedure TfrmPopUpDireitoAcesso.FormShow(Sender: TObject);
Var
  QtdItensMaior: Integer;
begin
  strItemSelecionado := '';

  If (lstOperadores.Items.Count < lstGrupos.Items.Count) Then
    QtdItensMaior := lstGrupos.Items.Count
  Else
    QtdItensMaior := lstOperadores.Items.Count;

  DefineTamanhoEPosicaoDoForm(QtdItensMaior);

  Self.Left               := Mouse.CursorPos.X;
  rdbOperadores.Checked   := True;
  lstGrupos.ItemIndex     := 0;
  lstOperadores.ItemIndex := 0;
  lstOperadores.SetFocus;
end;

procedure TfrmPopUpDireitoAcesso.lstGruposKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_Return) Then
  Begin
    strItemSelecionado := TListBox(Sender).Items.Strings[TListBox(Sender).ItemIndex];
    Close;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    strItemSelecionado := '';
    Close;
  End;
end;

procedure TfrmPopUpDireitoAcesso.lstOperadoresDblClick(Sender: TObject);
begin
  strItemSelecionado := TListBox(Sender).Items.Strings[TListBox(Sender).ItemIndex];
  Close;
end;

procedure TfrmPopUpDireitoAcesso.MostrarLista;
begin
  lstOperadores.Visible := rdbOperadores.Checked;
  lstGrupos.Visible     := rdbGrupos.Checked;
end;

procedure TfrmPopUpDireitoAcesso.rdbGruposClick(Sender: TObject);
begin
  MostrarLista;
end;

end.
