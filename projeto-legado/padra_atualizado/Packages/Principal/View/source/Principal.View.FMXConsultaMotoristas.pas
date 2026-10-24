unit Principal.View.FMXConsultaMotoristas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.ListBox,
  FMX.Edit, System.StrUtils, FMX.Effects, System.ImageList, FMX.ImgList,
  FMX.SearchBox, Generics.Collections, System.Actions, FMX.ActnList;

type
  TFMXConsultaMotoristas = class(TForm)
    layTopo: TLayout;
    recFundoTopo: TRectangle;
    btnFechar: TSpeedButton;
    imgFecharLine: TImage;
    imgFecharFull: TImage;
    lblCaptionForm: TLabel;
    layFundo: TLayout;
    recFundoLista: TRectangle;
    lbxMotoristas: TListBox;
    imgList: TImageList;
    estilos: TStyleBook;
    recFundoEditBusca: TRoundRect;
    imgLupa: TImage;
    edtBusca: TEdit;
    lblPesquisar: TLabel;
    lbiTeste: TListBoxItem;
    layEsmaecer: TLayout;
    recFundoEsmaecer: TRectangle;
    Layout4: TLayout;
    Rectangle4: TRectangle;
    btnSelecionar: TButton;
    Image2: TImage;
    actList: TActionList;
    actBtnSelecionar: TAction;
    actPesquisar: TAction;
    linSearchCursor: TLine;
    Timer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnFecharMouseEnter(Sender: TObject);
    procedure btnFecharMouseLeave(Sender: TObject);
    procedure edtBuscaEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actBtnSelecionarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure edtBuscaExit(Sender: TObject);
    procedure edtBuscaChangeTracking(Sender: TObject);
    procedure edtBuscaClick(Sender: TObject);
    procedure edtBuscaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure lbxMotoristasDblClick(Sender: TObject);
    procedure lbxMotoristasKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure lbxMotoristasMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure recFundoEsmaecerClick(Sender: TObject);
  private
    { Private declarations }
    ManterFoco : Integer;

    procedure AdicionaItem(texto, detalhe: String);
    procedure AdicionaTodos;

    procedure EscondeCursor;
    procedure MoveCursor(Key: Word);
    procedure PiscaCursor;
  public
    strCodMot: String;
    lstMotoristas,
    lstSelecionados: TStringList;
    RunningInTSPlus,
    UtilizaModoClassico: Boolean;
    { Public declarations }
  end;

var
  FMXConsultaMotoristas: TFMXConsultaMotoristas;

implementation

{$R *.fmx}

procedure TFMXConsultaMotoristas.actBtnSelecionarExecute(Sender: TObject);
Var
  i : Integer;
begin
  strCodMot := '';

  For i := 0 to lstSelecionados.Count - 1 do
    strCodMot := strCodMot + lstSelecionados[i] + ',';

  strCodMot := Copy(strCodMot, 0, Length(strCodMot)-1);

  Self.Tag := 0;
  Close;
  Self.ModalResult := mrOk;
end;

procedure TFMXConsultaMotoristas.actPesquisarExecute(Sender: TObject);
begin
  edtBusca.SetFocus;
end;

procedure TFMXConsultaMotoristas.AdicionaItem(texto, detalhe: String);
Var
  ListBoxItem : TListBoxItem;
begin
  ListBoxItem := TListBoxItem.Create(lbxMotoristas);
  ListBoxItem.Text                     := texto;
  ListBoxItem.ItemData.Detail          := detalhe;
  ListBoxItem.TagString                := detalhe;
  ListBoxItem.StyledSettings           := [TStyledSetting.Family, TStyledSetting.Style, TStyledSetting.Other];
  ListBoxItem.ImageIndex               := 0;
  ListBoxItem.Size.Height              := 40.000000000000000000;
  ListBoxItem.Size.PlatformDefault     := False;
  ListBoxItem.StyleLookup              := 'listboxitembottomdetail';
  ListBoxItem.TextSettings.Font.Family := 'Segoe UI';
  ListBoxItem.TextSettings.Font.Size   := 12;

  If (lstSelecionados.IndexOf(detalhe) > -1) Then
    ListBoxItem.ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark
  Else
    ListBoxItem.ItemData.Accessory := TListBoxItemData.TAccessory.aNone;

  lbxMotoristas.AddObject(ListBoxItem);
end;

procedure TFMXConsultaMotoristas.AdicionaTodos;
Var
  i: Integer;
begin
  lbxMotoristas.Items.Clear;

  For i := 0 to lstMotoristas.Count - 1 do
    AdicionaItem(Copy(lstMotoristas[I],7,60),
                 Copy(lstMotoristas[I],1,5));

  TListBoxItem(lbxMotoristas.ItemByIndex(0)).IsSelected := True;
end;

procedure TFMXConsultaMotoristas.btnFecharClick(Sender: TObject);
begin
  Self.Tag := 0;
  Close;
end;

procedure TFMXConsultaMotoristas.btnFecharMouseEnter(Sender: TObject);
begin
  imgFecharLine.Opacity := 0;
  imgFecharFull.Opacity := 1;
end;

procedure TFMXConsultaMotoristas.btnFecharMouseLeave(Sender: TObject);
begin
  imgFecharLine.Opacity := 0.5;
  imgFecharFull.Opacity := 0;
end;

procedure TFMXConsultaMotoristas.edtBuscaChangeTracking(Sender: TObject);
var
  I: Integer;
  S: String;
begin
  TEdit(Sender).Text := AnsiUpperCase(TEdit(Sender).Text);

  lbxMotoristas.Items.BeginUpdate;
  try
    lbxMotoristas.Clear;
    if edtBusca.Text.Length > 0 then
    begin
      S := edtBusca.Text;
      for I := 0 to lstMotoristas.Count - 1 do
      begin
        if ContainsText(lstMotoristas[I], S) then
          AdicionaItem(Copy(lstMotoristas[I],7,60),
                       Copy(lstMotoristas[I],1,5));
      end;
    end
    else
      AdicionaTodos;
  finally
    lbxMotoristas.Items.EndUpdate;
  end;

  if (lbxMotoristas.Items.Count > 0) Then
    TListBoxItem(lbxMotoristas.ItemByIndex(0)).IsSelected := True;

  MoveCursor(vkRight);
end;

procedure TFMXConsultaMotoristas.edtBuscaClick(Sender: TObject);
begin
  MoveCursor(vkNone);
end;

procedure TFMXConsultaMotoristas.edtBuscaEnter(Sender: TObject);
begin
  PiscaCursor;
  lblPesquisar.Visible := false;
end;

procedure TFMXConsultaMotoristas.edtBuscaExit(Sender: TObject);
begin
  If ManterFoco > 0 Then
  Begin
    Inc(ManterFoco, -1);
    Exit;
  End;

  EscondeCursor;

  If (edtBusca.Text.IsEmpty) Then
    lblPesquisar.Visible := true;
end;

procedure TFMXConsultaMotoristas.edtBuscaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkDown, vkReturn, vkNext:
    begin
      lbxMotoristas.SetFocus;
      If linSearchCursor.Tag = 1 Then
        edtBuscaExit(edtBusca);
    end;
  End;

  If (edtBusca.Text <> EmptyStr) Then
  Begin
    Case Key Of
      vkLeft, vkHome, vkRight, vkEnd : MoveCursor(Key);
    End;
  End;
end;

procedure TFMXConsultaMotoristas.EscondeCursor;
begin
  linSearchCursor.Tag := 0;
  linSearchCursor.Visible := False;
end;

procedure TFMXConsultaMotoristas.FormCreate(Sender: TObject);
begin
  RunningInTSPlus := False;
  Timer.Enabled := True;
  EscondeCursor;
  lstMotoristas   := TStringList.Create;
  lstSelecionados := TStringList.Create;
end;

procedure TFMXConsultaMotoristas.FormDestroy(Sender: TObject);
begin
  lstMotoristas.Free;
  lstSelecionados.Free;
end;

procedure TFMXConsultaMotoristas.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkEscape : btnFecharClick(btnFechar);
    vkF10 : actBtnSelecionarExecute(btnSelecionar);
  End;
end;

procedure TFMXConsultaMotoristas.FormShow(Sender: TObject);
begin
  AdicionaTodos;
  TListBoxItem(lbxMotoristas.ItemByIndex(0)).IsSelected := True;

  ManterFoco := 0;
  If RunningInTSPlus And UtilizaModoClassico Then
    ManterFoco := 3;

  linSearchCursor.Opacity := 0.7;

  If Not UtilizaModoClassico Then
    linSearchCursor.Opacity := 0;

  edtBusca.SetFocus;
end;

procedure TFMXConsultaMotoristas.lbxMotoristasDblClick(Sender: TObject);
begin
//  actBtnSelecionarExecute(Nil);
end;

procedure TFMXConsultaMotoristas.lbxMotoristasKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  If (TListBoxItem(lbxMotoristas.Selected).Index = 0) Then
  Begin
    Case Key Of
      vkUp, vkPrior: edtBusca.SetFocus;
    End;
  End;

  Case Key Of
    vkReturn:
    Begin
      TListBoxItem(lbxMotoristas.Selected).IsChecked := Not TListBoxItem(lbxMotoristas.Selected).IsChecked;

      If TListBoxItem(lbxMotoristas.Selected).IsChecked Then
      Begin
        TListBoxItem(lbxMotoristas.Selected).ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark;
        lstSelecionados.Add(TListBoxItem(lbxMotoristas.Selected).TagString);
      End
      Else
      Begin
        TListBoxItem(lbxMotoristas.Selected).ItemData.Accessory := TListBoxItemData.TAccessory.aNone;
        lstSelecionados.Delete(lstSelecionados.IndexOf(lbxMotoristas.Selected.TagString));
      End;

      If (ssCtrl in Shift) Then
        TListBoxItem(lbxMotoristas.Selected).SetFocus
      Else
        actBtnSelecionarExecute(Nil);
    End;
  End;
end;

procedure TFMXConsultaMotoristas.lbxMotoristasMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
Var
  LItemSelecionado : TListBoxItem;
begin
  LItemSelecionado := lbxMotoristas.ItemByPoint(X, Y);

  If (ssCtrl In Shift) Then
  Begin
    LItemSelecionado.IsChecked := Not LItemSelecionado.IsChecked;

    If LItemSelecionado.IsChecked Then
    Begin
      LItemSelecionado.ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark;
      lstSelecionados.Add(LItemSelecionado.TagString);
    End
    Else
    Begin
      LItemSelecionado.ItemData.Accessory := TListBoxItemData.TAccessory.aNone;
      lstSelecionados.Delete(lstSelecionados.IndexOf(LItemSelecionado.TagString));
    End;
  End;
end;

procedure TFMXConsultaMotoristas.MoveCursor(Key: Word);
Var
  LText: String;
begin
  PiscaCursor;

  edtBusca.Canvas.Font.Family := edtBusca.Font.Family;
  edtBusca.Canvas.Font.Size   := edtBusca.Font.Size;

  Case Key Of
    vkEnd  : linSearchCursor.Position.X := edtBusca.Canvas.TextWidth(String(edtBusca.Text).Replace(' ', '.')) + 2.5;
    vkHome : linSearchCursor.Position.X := 2.5;

    vkLeft, vkRight, vkNone:
    Begin
      If Key = vkLeft Then
        LText := Copy(String(edtBusca.Text).Replace(' ', '.'), 1, (edtBusca.CaretPosition - 1))
      Else If Key = vkRight Then
        LText := Copy(String(edtBusca.Text).Replace(' ', '.'), 1, (edtBusca.CaretPosition + 1))
      Else
        LText := Copy(String(edtBusca.Text).Replace(' ', '.'), 1, (edtBusca.CaretPosition));

      linSearchCursor.Position.X := edtBusca.Canvas.TextWidth(LText) + 2.5;
    End;
  End;
end;

procedure TFMXConsultaMotoristas.PiscaCursor;
begin
  linSearchCursor.Tag := 1;
end;

procedure TFMXConsultaMotoristas.recFundoEsmaecerClick(Sender: TObject);
begin
  Self.Tag := 0;
  Close;
end;

procedure TFMXConsultaMotoristas.TimerTimer(Sender: TObject);
begin
  If (linSearchCursor.Tag = 0) Then
    linSearchCursor.Visible := False

  Else If (linSearchCursor.Tag = 1) Then
    linSearchCursor.Visible := Not linSearchCursor.Visible;
end;

end.
