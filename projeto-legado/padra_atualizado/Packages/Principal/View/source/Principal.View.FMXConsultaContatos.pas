unit Principal.View.FMXConsultaContatos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.ListBox,
  FMX.Edit, System.StrUtils, FMX.Effects, System.ImageList, FMX.ImgList,
  FMX.SearchBox, Generics.Collections, System.Actions, FMX.ActnList,
  TaEntregue.Romaneios.Interfaces, Principal.View.Interfaces;

type
  TFMXConsultaContatos = class(TForm)
    layTopo: TLayout;
    recFundoTopo: TRectangle;
    lblCaptionForm: TLabel;
    layFundo: TLayout;
    recFundoLista: TRectangle;
    lstContatos: TListBox;
    recFundoEditBusca: TRoundRect;
    imgLupa: TImage;
    edtBusca: TEdit;
    lblPesquisar: TLabel;
    lbiTeste: TListBoxItem;
    layEsmaecer: TLayout;
    recFundoEsmaecer: TRectangle;
    laySelecionar: TLayout;
    recFundoBranco: TRectangle;
    actList: TActionList;
    actBtnSelecionar: TAction;
    actPesquisar: TAction;
    linSearchCursor: TLine;
    Timer: TTimer;
    recBotaoSelecionar: TRectangle;
    efeSombra: TShadowEffect;
    lblBotaoSelecionar: TLabel;
    imgDefault: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure edtBuscaEnter(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actBtnSelecionarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure edtBuscaExit(Sender: TObject);
    procedure edtBuscaChangeTracking(Sender: TObject);
    procedure edtBuscaClick(Sender: TObject);
    procedure edtBuscaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure lstContatosDblClick(Sender: TObject);
    procedure lstContatosKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure recFundoEsmaecerClick(Sender: TObject);
  private
    { Private declarations }
    ManterFoco : Integer;

    procedure AdicionaItem(Contato: IContato; Index: Integer);
    procedure AdicionaTodos;

    procedure EscondeCursor;
    procedure MoveCursor(Key: Word);
    procedure PiscaCursor;
  public
    { Public declarations }
    Chat : IChat;
    ContatoSelecionado : IContato;
    objFuncoes : IFuncoes;
    RunningInTSPlus,
    UtilizaModoClassico : Boolean;
  end;

var
  FMXConsultaContatos: TFMXConsultaContatos;

implementation

{$R *.fmx}

procedure TFMXConsultaContatos.actBtnSelecionarExecute(Sender: TObject);
begin
  ContatoSelecionado := Chat.Contatos[lstContatos.Selected.Tag];
  Self.Tag := 0;
  Close;
  Self.ModalResult := mrOk;
end;

procedure TFMXConsultaContatos.actPesquisarExecute(Sender: TObject);
begin
  edtBusca.SetFocus;
end;

procedure TFMXConsultaContatos.AdicionaItem(Contato: IContato; Index: Integer);
Var
  ListBoxItem : TListBoxItem;
begin
  ListBoxItem := TListBoxItem.Create(lstContatos);
  ListBoxItem.Text                     := Contato.NomeContato;
  ListBoxItem.ItemData.Detail          := Contato.CodigoContato;
  ListBoxItem.TagString                := Contato.CodigoContato;
  ListBoxItem.Tag                      := Index;
  ListBoxItem.StyledSettings           := [TStyledSetting.Family, TStyledSetting.Style, TStyledSetting.Other];
  ListBoxItem.ImageIndex               := 0;
  ListBoxItem.Size.Height              := 50;
  ListBoxItem.Size.PlatformDefault     := False;
  ListBoxItem.StyleLookup              := 'listboxitembottomdetail';
  ListBoxItem.TextSettings.Font.Family := 'Segoe UI';
  ListBoxItem.TextSettings.Font.Size   := 12;

  lstContatos.AddObject(ListBoxItem);
end;

procedure TFMXConsultaContatos.AdicionaTodos;
Var
  Contato: IContato;
begin
  lstContatos.Items.Clear;
  lstContatos.BeginUpdate;

  for Contato in Chat.Contatos do
    AdicionaItem(Contato, Chat.Contatos.IndexOf(Contato));

  lstContatos.ItemByIndex(0).IsSelected := True;
  lstContatos.EndUpdate;
end;

procedure TFMXConsultaContatos.edtBuscaChangeTracking(Sender: TObject);
var
  S: String;
  Contato: IContato;
begin
  TEdit(Sender).Text := AnsiUpperCase(TEdit(Sender).Text);

  lstContatos.Items.BeginUpdate;
  try
    lstContatos.Clear;
    if edtBusca.Text.Length > 0 then
    begin
      S := edtBusca.Text;

      for Contato in Chat.Contatos do
      begin
        if ContainsText(Contato.NomeContato, S) then
          AdicionaItem(Contato, Chat.Contatos.IndexOf(Contato));
      end;
    end
    else
      AdicionaTodos;
  finally
    lstContatos.Items.EndUpdate;
  end;

  if (lstContatos.Items.Count > 0) Then
    lstContatos.ItemByIndex(0).IsSelected := True;

  MoveCursor(vkRight);
end;

procedure TFMXConsultaContatos.edtBuscaClick(Sender: TObject);
begin
  MoveCursor(vkNone);
end;

procedure TFMXConsultaContatos.edtBuscaEnter(Sender: TObject);
begin
  PiscaCursor;
  lblPesquisar.Visible := false;
end;

procedure TFMXConsultaContatos.edtBuscaExit(Sender: TObject);
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

procedure TFMXConsultaContatos.edtBuscaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkDown, vkReturn, vkNext:
    begin
      lstContatos.SetFocus;
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

procedure TFMXConsultaContatos.EscondeCursor;
begin
  linSearchCursor.Tag := 0;
  linSearchCursor.Visible := False;
end;

procedure TFMXConsultaContatos.FormCreate(Sender: TObject);
begin
  RunningInTSPlus := False;
  Timer.Enabled := True;
  EscondeCursor;
end;

procedure TFMXConsultaContatos.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkEscape :
    Begin
      Self.Tag := 0;
      Close;
    End;
  End;
end;

procedure TFMXConsultaContatos.FormShow(Sender: TObject);
begin
  AdicionaTodos;

  ManterFoco := 0;
  If RunningInTSPlus And UtilizaModoClassico Then
    ManterFoco := 3;

  linSearchCursor.Opacity := 0.7;

  If Not UtilizaModoClassico Then
    linSearchCursor.Opacity := 0;

  edtBusca.SetFocus;
end;

procedure TFMXConsultaContatos.lstContatosDblClick(Sender: TObject);
begin
  actBtnSelecionarExecute(Nil);
end;

procedure TFMXConsultaContatos.lstContatosKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  If (TListBoxItem(lstContatos.Selected).Index = 0) Then
  Begin
    Case Key Of
      vkUp, vkPrior: edtBusca.SetFocus;
    End;
  End;

  Case Key Of
    vkReturn: recBotaoSelecionar.SetFocus;
  End;
end;

procedure TFMXConsultaContatos.MoveCursor(Key: Word);
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

procedure TFMXConsultaContatos.PiscaCursor;
begin
  linSearchCursor.Tag := 1;
end;

procedure TFMXConsultaContatos.recFundoEsmaecerClick(Sender: TObject);
begin
  Self.Tag := 0;
  Close;
end;

procedure TFMXConsultaContatos.TimerTimer(Sender: TObject);
begin
  If (linSearchCursor.Tag = 0) Then
    linSearchCursor.Visible := False

  Else If (linSearchCursor.Tag = 1) Then
    linSearchCursor.Visible := Not linSearchCursor.Visible;
end;

end.
