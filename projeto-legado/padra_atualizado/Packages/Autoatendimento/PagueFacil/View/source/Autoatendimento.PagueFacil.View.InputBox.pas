unit Autoatendimento.PagueFacil.View.InputBox;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects,
  FMX.Filter.Effects, FMX.Edit, Autoatendimento.PagueFacil.Interfaces;

type
  TfmxInputBox = class(TForm)
    recEsmaecer: TRectangle;
    layFundo: TLayout;
    lblDescricao: TLabel;
    recInputText: TRectangle;
    edtInputText: TEdit;
    linCursor: TLine;
    efeSombraInput: TShadowEffect;
    recTeclado: TRectangle;
    rec7: TRectangle;
    lbl7: TLabel;
    rec4: TRectangle;
    lbl4: TLabel;
    rec1: TRectangle;
    lbl1: TLabel;
    recBackspace: TRectangle;
    lblBackspace: TLabel;
    rec0: TRectangle;
    lbl0: TLabel;
    rec2: TRectangle;
    lbl2: TLabel;
    rec8: TRectangle;
    lbl8: TLabel;
    rec5: TRectangle;
    lbl5: TLabel;
    rec9: TRectangle;
    lbl9: TLabel;
    rec6: TRectangle;
    lbl6: TLabel;
    rec3: TRectangle;
    lbl3: TLabel;
    recLimpar: TRectangle;
    lblLimpar: TLabel;
    recFundo: TRectangle;
    efeSombraFundo: TShadowEffect;
    tmrCursor: TTimer;
    lblErroInputText: TLabel;
    tmrErro: TTimer;
    tmrClose: TTimer;
    procedure recBotaoSimClick(Sender: TObject);
    procedure recBotaoNaoClick(Sender: TObject);
    procedure rec1Click(Sender: TObject);
    procedure edtInputTextExit(Sender: TObject);
    procedure edtInputTextChange(Sender: TObject);
    procedure edtInputTextChangeTracking(Sender: TObject);
    procedure edtInputTextClick(Sender: TObject);
    procedure edtInputTextKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtInputTextEnter(Sender: TObject);
    procedure tmrCursorTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure recLimparClick(Sender: TObject);
    procedure tmrErroTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure tmrCloseTimer(Sender: TObject);
  private
    { Private declarations }
    procedure EscondeCursor;
    procedure MoveCursor(Key: Word);
    procedure PiscaCursor;

    procedure MostrarErro(MsgErro: String);
    procedure LimparErro;
  public
    { Public declarations }
    FPagueFacil : IAutoatendimentoPagueFacilRecebimentoPedido;
  end;

var
  fmxInputBox: TfmxInputBox;

Const
  CorVermelha = TAlphaColor($FFEB5757);
  CorVerde    = TAlphaColor($FF49C46C);

implementation

{$R *.fmx}

procedure TfmxInputBox.edtInputTextChange(Sender: TObject);
begin
  If (edtInputText.Tag = 1) Then
  Begin
    If (edtInputText.Text.IsEmpty) Then
      Exit;

    MoveCursor(vkEnd);

    If Not FPagueFacil.CPFValido(edtInputText.Text) Then
      MostrarErro('Informe um CPF válido')
    Else
      Close;
  End;
end;

procedure TfmxInputBox.edtInputTextChangeTracking(Sender: TObject);
begin
  MoveCursor(vkRight);
end;

procedure TfmxInputBox.edtInputTextClick(Sender: TObject);
begin
  MoveCursor(vkNone);
end;

procedure TfmxInputBox.edtInputTextEnter(Sender: TObject);
begin
  PiscaCursor;
end;

procedure TfmxInputBox.edtInputTextExit(Sender: TObject);
begin
  EscondeCursor;
end;

procedure TfmxInputBox.edtInputTextKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkLeft, vkHome, vkRight, vkEnd : MoveCursor(Key);
  End;
end;

procedure TfmxInputBox.EscondeCursor;
begin
  linCursor.Tag := 0;
end;

procedure TfmxInputBox.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkEscape:
    Begin
      edtInputText.Text := '';
      Self.Close;
    End;
  End;
end;

procedure TfmxInputBox.FormShow(Sender: TObject);
begin
  edtInputText.SetFocus;
  tmrCursor.Enabled := True;
  tmrClose.Enabled := True;
end;

procedure TfmxInputBox.LimparErro;
begin
  recInputText.Stroke.Color   := TAlphaColorRec.White;
  edtInputText.Margins.Bottom := 10;
  linCursor.Position.Y        := 9;
  lblErroInputText.Text       := EmptyStr;
  tmrErro.Enabled             := False;
  lblLimpar.Text              := 'Confirma';
  recLimpar.Fill.Color        := CorVerde;
  edtInputText.SetFocus;
end;

procedure TfmxInputBox.MostrarErro(MsgErro: String);
begin
  recInputText.Stroke.Color   := CorVermelha;
  edtInputText.Margins.Bottom := 30;
  linCursor.Position.Y        := -1;
  lblErroInputText.Text       := MsgErro;
  lblLimpar.Text              := 'Limpar';
  recLimpar.Fill.Color        := CorVermelha;
  tmrErro.Enabled             := True;
end;

procedure TfmxInputBox.MoveCursor(Key: Word);
Var
  LText: String;
begin
  PiscaCursor;

  edtInputText.Canvas.Font.Family := edtInputText.Font.Family;
  edtInputText.Canvas.Font.Size   := edtInputText.Font.Size;

  Case Key Of
    vkEnd  : linCursor.Position.X := edtInputText.Canvas.TextWidth(String(edtInputText.Text).Replace(' ', '.')) + 2.5;
    vkHome : linCursor.Position.X := 2.5;

    vkLeft, vkRight, vkNone:
    Begin
      If Key = vkLeft Then
        LText := Copy(String(edtInputText.Text).Replace(' ', '.'), 1, (edtInputText.CaretPosition - 1))
      Else If Key = vkRight Then
        LText := Copy(String(edtInputText.Text).Replace(' ', '.'), 1, (edtInputText.CaretPosition + 1))
      Else
        LText := Copy(String(edtInputText.Text).Replace(' ', '.'), 1, (edtInputText.CaretPosition));

      linCursor.Position.X := edtInputText.Canvas.TextWidth(LText) + 2.5;
    End;
  End;
end;

procedure TfmxInputBox.PiscaCursor;
begin
  linCursor.Tag := 1;
end;

procedure TfmxInputBox.rec1Click(Sender: TObject);
begin
  edtInputText.Tag  := 0;

  If (recInputText.Stroke.Color = CorVermelha) Then
    LimparErro;

  If (TRectangle(Sender).Name = 'recBackspace') Then
    edtInputText.Text := Copy(edtInputText.Text, 1, edtInputText.Text.Length - 1)
  Else
    edtInputText.Text := edtInputText.Text + TRectangle(Sender).Tag.ToString();

  edtInputText.CaretPosition := edtInputText.CaretPosition + 1;
  MoveCursor(vkNone);
  edtInputText.Tag  := 1;
  edtInputText.SetFocus;
end;

procedure TfmxInputBox.recBotaoNaoClick(Sender: TObject);
begin
  Self.Tag := mrNo;
  Self.Close;
end;

procedure TfmxInputBox.recBotaoSimClick(Sender: TObject);
begin
  Self.Tag := mrYes;
  Self.Close;
end;

procedure TfmxInputBox.recLimparClick(Sender: TObject);
begin
  If (recLimpar.Fill.Color = CorVerde) Then
    edtInputTextChange(edtInputText)

  Else If (recLimpar.Fill.Color = CorVermelha) Then
  Begin
    edtInputText.Text := EmptyStr;
    LimparErro;
  End;
end;

procedure TfmxInputBox.tmrCursorTimer(Sender: TObject);
begin
  If (linCursor.Tag = 0) Then
    linCursor.Visible := False
  Else If (linCursor.Tag = 1) Then
    linCursor.Visible := Not linCursor.Visible;
end;

procedure TfmxInputBox.tmrErroTimer(Sender: TObject);
begin
  LimparErro;
end;

procedure TfmxInputBox.tmrCloseTimer(Sender: TObject);
begin
  edtInputText.Text := '';
  Self.Close;
end;

end.
