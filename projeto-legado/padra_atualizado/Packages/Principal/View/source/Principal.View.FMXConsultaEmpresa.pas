unit Principal.View.FMXConsultaEmpresa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.ListBox,
  FMX.Edit, System.StrUtils, FMX.Effects, System.ImageList, FMX.ImgList,
  FMX.SearchBox, Generics.Collections, System.Actions, FMX.ActnList;

type
  TFMXConsultaEmpresa = class(TForm)
    layTopo: TLayout;
    recFundoTopo: TRectangle;
    btnFechar: TSpeedButton;
    imgFecharLine: TImage;
    imgFecharFull: TImage;
    lblCaptionForm: TLabel;
    layFundo: TLayout;
    recFundoLista: TRectangle;
    lbxEmpresas: TListBox;
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
    procedure Button1Click(Sender: TObject);
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
    procedure lbxEmpresasDblClick(Sender: TObject);
    procedure lbxEmpresasKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure AdicionaItem(const texto, detalhe: String);
    procedure AdicionaTodos;
    procedure SelecionaPrimeiroItem;

    procedure EscondeCursor;
    procedure MoveCursor(Key: Word);
    procedure PiscaCursor;
  public
    strCodEmp: String;
    lstEmpresas: TStringList;
    { Public declarations }
  end;

var
  FMXConsultaEmpresa: TFMXConsultaEmpresa;

implementation

{$R *.fmx}

procedure TFMXConsultaEmpresa.actBtnSelecionarExecute(Sender: TObject);
begin
  If Not Assigned(lbxEmpresas.Selected) Then
    Exit;

  strCodEmp := TListBoxItem(lbxEmpresas.Selected).TagString;
  Close;
  Self.ModalResult := mrOk;
end;

procedure TFMXConsultaEmpresa.actPesquisarExecute(Sender: TObject);
begin
  edtBusca.SetFocus;
end;

procedure TFMXConsultaEmpresa.AdicionaItem(const texto, detalhe: String);
Var
  ListBoxItem : TListBoxItem;
begin
  ListBoxItem := TListBoxItem.Create(lbxEmpresas);
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

  lbxEmpresas.AddObject(ListBoxItem);
end;

procedure TFMXConsultaEmpresa.AdicionaTodos;
Var
  i: Integer;
begin
  lbxEmpresas.Items.Clear;

  For i := 0 to lstEmpresas.Count - 1 do
    AdicionaItem(Copy(lstEmpresas[I],5,60), Copy(lstEmpresas[I],1,3));

  SelecionaPrimeiroItem;
end;

procedure TFMXConsultaEmpresa.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFMXConsultaEmpresa.btnFecharMouseEnter(Sender: TObject);
begin
  imgFecharLine.Opacity := 0;
  imgFecharFull.Opacity := 1;
end;

procedure TFMXConsultaEmpresa.btnFecharMouseLeave(Sender: TObject);
begin
  imgFecharLine.Opacity := 0.5;
  imgFecharFull.Opacity := 0;
end;

procedure TFMXConsultaEmpresa.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TFMXConsultaEmpresa.edtBuscaChangeTracking(Sender: TObject);
var
  I: Integer;
  S: String;
begin
  TEdit(Sender).Text := AnsiUpperCase(TEdit(Sender).Text);

  lbxEmpresas.Items.BeginUpdate;
  try
    lbxEmpresas.Clear;
    if edtBusca.Text.Length > 0 then
    begin
      S := edtBusca.Text;
      for I := 0 to lstEmpresas.Count - 1 do
      begin
        if ContainsText(lstEmpresas[I], S) then
          AdicionaItem(Copy(lstEmpresas[I],5,60), Copy(lstEmpresas[I],1,3));
      end;
    end
    else
      AdicionaTodos;
  finally
    lbxEmpresas.Items.EndUpdate;
  end;

  SelecionaPrimeiroItem;

  MoveCursor(vkRight);
end;

procedure TFMXConsultaEmpresa.edtBuscaClick(Sender: TObject);
begin
  MoveCursor(vkNone);
end;

procedure TFMXConsultaEmpresa.edtBuscaEnter(Sender: TObject);
begin
  PiscaCursor;
  lblPesquisar.Visible := false;
end;

procedure TFMXConsultaEmpresa.edtBuscaExit(Sender: TObject);
begin
  EscondeCursor;

  If (edtBusca.Text.IsEmpty) Then
    lblPesquisar.Visible := true;
end;

procedure TFMXConsultaEmpresa.edtBuscaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkDown, vkReturn, vkNext: lbxEmpresas.SetFocus;
  End;

  If (edtBusca.Text <> EmptyStr) Then
  Begin
    Case Key Of
      vkLeft, vkHome, vkRight, vkEnd : MoveCursor(Key);
    End;
  End;
end;

procedure TFMXConsultaEmpresa.EscondeCursor;
begin
  linSearchCursor.Tag := 0;
  linSearchCursor.Visible := False;
end;

procedure TFMXConsultaEmpresa.FormCreate(Sender: TObject);
begin
  Timer.Enabled := True;
  EscondeCursor;
  lstEmpresas := TStringList.Create;
end;

procedure TFMXConsultaEmpresa.FormDestroy(Sender: TObject);
begin
  lstEmpresas.Free;
end;

procedure TFMXConsultaEmpresa.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkEscape : Close;
  End;
end;

procedure TFMXConsultaEmpresa.FormShow(Sender: TObject);
begin
  AdicionaTodos;
  edtBusca.SetFocus;
end;

procedure TFMXConsultaEmpresa.lbxEmpresasDblClick(Sender: TObject);
begin
  actBtnSelecionarExecute(Nil);
end;

procedure TFMXConsultaEmpresa.lbxEmpresasKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  If Assigned(lbxEmpresas.Selected) Then
  Begin
    If (TListBoxItem(lbxEmpresas.Selected).Index = 0) Then
    Begin
      Case Key Of
        vkUp, vkPrior: edtBusca.SetFocus;
      End;
    End;
  End;

  Case Key Of
    vkReturn: btnSelecionar.SetFocus;
  End;
end;

procedure TFMXConsultaEmpresa.MoveCursor(Key: Word);
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

procedure TFMXConsultaEmpresa.PiscaCursor;
begin
  linSearchCursor.Tag := 1;
end;

procedure TFMXConsultaEmpresa.SelecionaPrimeiroItem;
begin
  If (lbxEmpresas.Items.Count > 0) Then
    TListBoxItem(lbxEmpresas.ItemByIndex(0)).IsSelected := True;
end;

procedure TFMXConsultaEmpresa.TimerTimer(Sender: TObject);
begin
  If (linSearchCursor.Tag = 0) Then
    linSearchCursor.Visible := False

  Else If (linSearchCursor.Tag = 1) Then
    linSearchCursor.Visible := Not linSearchCursor.Visible;
end;

end.
