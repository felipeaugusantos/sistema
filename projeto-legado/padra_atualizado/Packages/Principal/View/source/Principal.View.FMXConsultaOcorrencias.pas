unit Principal.View.FMXConsultaOcorrencias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.ListBox,
  FMX.Edit, System.StrUtils, FMX.Effects, System.ImageList, FMX.ImgList,
  FMX.SearchBox, Generics.Collections, System.Actions, FMX.ActnList,
  TaEntregue.Romaneios.Interfaces,
  Principal.View.Frame.FMXPainelRotasOcorrenciasLinha;

type
  TFMXConsultaOcorrencias = class(TForm)
    layTopo: TLayout;
    recFundoTopo: TRectangle;
    lblCaptionForm: TLabel;
    layFundo: TLayout;
    recFundoLista: TRectangle;
    lbxOcorrencias: TListBox;
    layEsmaecer: TLayout;
    recFundoEsmaecer: TRectangle;
    StyleBook1: TStyleBook;
    btnFechar: TSpeedButton;
    imgFechar: TImage;
    lblTeste: TListBoxItem;
    fraOcorrencias: TframeOcorrencias;
    recFundoEditBusca: TRoundRect;
    imgLupa: TImage;
    edtBusca: TEdit;
    lblPesquisar: TLabel;
    linSearchCursor: TLine;
    Timer: TTimer;
    actList: TActionList;
    actPesquisar: TAction;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure recFundoEsmaecerClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure edtBuscaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtBuscaChangeTracking(Sender: TObject);
    procedure edtBuscaClick(Sender: TObject);
    procedure edtBuscaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtBuscaEnter(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
  private
    { Private declarations }
    ManterFoco : Integer;

    procedure AdicionaItem(Ocorrencia: IOcorrencia);
    procedure AdicionaTodos;

    procedure EscondeCursor;
    procedure MoveCursor(Key: Word);
    procedure PiscaCursor;
  public
    { Public declarations }
    Romaneio : IRomaneio;
    RunningInTSPlus,
    UtilizaModoClassico : Boolean;
  end;

var
  FMXConsultaOcorrencias: TFMXConsultaOcorrencias;

implementation

{$R *.fmx}

procedure TFMXConsultaOcorrencias.actPesquisarExecute(Sender: TObject);
begin
  edtBusca.SetFocus;
end;

procedure TFMXConsultaOcorrencias.AdicionaItem(Ocorrencia: IOcorrencia);
Var
  LItem : TListBoxItem;
  LFrame: TframeOcorrencias;
begin
  LItem            := TListBoxItem.Create(lbxOcorrencias);
  LItem.Selectable := False;
  LItem.Size.PlatformDefault := False;
  LFrame           := TframeOcorrencias.Create(Self);
  LFrame.Name      := 'frameOcorrencias' + IntToStr(lbxOcorrencias.Count + 1);

  LFrame.lblMensagem.Visible := String(Ocorrencia.Mensagem) <> EmptyStr;

  If LFrame.lblMensagem.Visible Then
    LFrame.lblDescricao.TextSettings.VertAlign := TTextAlign.Trailing
  Else
    LFrame.lblDescricao.TextSettings.VertAlign := TTextAlign.Center;

  LFrame.Parent    := LItem;
  LFrame.Align     := TAlignLayout.Contents;
  LItem.Height     := 50;

  LFrame.lblDataHora.Text  := FormatDateTime('dd/MM/yyyy hh:nn', Ocorrencia.DataHoraOcorrencia);
  LFrame.lblDescricao.Text := Ocorrencia.Ocorrencia;
  LFrame.lblMensagem.Text  := String(Ocorrencia.Mensagem);

  lbxOcorrencias.AddObject(LItem);
end;

procedure TFMXConsultaOcorrencias.AdicionaTodos;
Var
  Ocorrencia: IOcorrencia;
begin
  lbxOcorrencias.Items.Clear;
  lbxOcorrencias.BeginUpdate;

  for Ocorrencia in Romaneio.Ocorrencias do
    AdicionaItem(Ocorrencia);

  lbxOcorrencias.ItemByIndex(0).IsSelected := True;
  lbxOcorrencias.EndUpdate;
end;

procedure TFMXConsultaOcorrencias.EscondeCursor;
begin
  linSearchCursor.Tag := 0;
  linSearchCursor.Visible := False;
end;

procedure TFMXConsultaOcorrencias.MoveCursor(Key: Word);
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

procedure TFMXConsultaOcorrencias.PiscaCursor;
begin
  linSearchCursor.Tag := 1;
end;

procedure TFMXConsultaOcorrencias.btnFecharClick(Sender: TObject);
begin
  Self.Tag := 0;
  Close;
end;

procedure TFMXConsultaOcorrencias.edtBuscaChangeTracking(Sender: TObject);
var
  S: String;
  Ocorrencia: IOcorrencia;
begin
  TEdit(Sender).Text := AnsiUpperCase(TEdit(Sender).Text);

  lbxOcorrencias.Items.BeginUpdate;
  try
    lbxOcorrencias.Clear;
    if edtBusca.Text.Length > 0 then
    begin
      S := edtBusca.Text;

      for Ocorrencia in Romaneio.Ocorrencias do
        if ContainsText(Ocorrencia.Ocorrencia, S) then
          AdicionaItem(Ocorrencia);
    end
    else
      AdicionaTodos;
  finally
    lbxOcorrencias.Items.EndUpdate;
  end;

  if (lbxOcorrencias.Items.Count > 0) Then
    TListBoxItem(lbxOcorrencias.ItemByIndex(0)).IsSelected := True;

  MoveCursor(vkRight);
end;

procedure TFMXConsultaOcorrencias.edtBuscaClick(Sender: TObject);
begin
  MoveCursor(vkNone);
end;

procedure TFMXConsultaOcorrencias.edtBuscaEnter(Sender: TObject);
begin
  PiscaCursor;
  lblPesquisar.Visible := false;
end;

procedure TFMXConsultaOcorrencias.edtBuscaExit(Sender: TObject);
begin
  If ManterFoco <= 0 Then
  Begin
    Inc(ManterFoco, -1);
    Exit;
  End;

  EscondeCursor;

  If (edtBusca.Text.IsEmpty) Then
    lblPesquisar.Visible := true;
end;

procedure TFMXConsultaOcorrencias.edtBuscaKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  If (edtBusca.Text <> EmptyStr) Then
  Begin
    Case Key Of
      vkLeft, vkHome, vkRight, vkEnd : MoveCursor(Key);
    End;
  End;
end;

procedure TFMXConsultaOcorrencias.FormCreate(Sender: TObject);
begin
  ManterFoco := 0;
  If RunningInTSPlus And UtilizaModoClassico Then
    ManterFoco := 3;

  Timer.Enabled := True;
  EscondeCursor;
end;

procedure TFMXConsultaOcorrencias.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFMXConsultaOcorrencias.FormShow(Sender: TObject);
begin
  AdicionaTodos;

  linSearchCursor.Opacity := 0.7;

  If Not UtilizaModoClassico Then
    linSearchCursor.Opacity := 0;

  edtBusca.SetFocus;
end;

procedure TFMXConsultaOcorrencias.recFundoEsmaecerClick(Sender: TObject);
begin
  Self.Tag := 0;
  Close;
end;

procedure TFMXConsultaOcorrencias.TimerTimer(Sender: TObject);
begin
  If (linSearchCursor.Tag = 0) Then
    linSearchCursor.Visible := False

  Else If (linSearchCursor.Tag = 1) Then
    linSearchCursor.Visible := Not linSearchCursor.Visible;
end;

end.
