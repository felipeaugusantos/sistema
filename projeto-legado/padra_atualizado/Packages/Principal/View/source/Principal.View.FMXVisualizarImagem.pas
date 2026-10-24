unit Principal.View.FMXVisualizarImagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ExtCtrls, FMX.Ani,
  System.StrUtils;

type
  TfmxVisualizarImagem = class(TForm)
    recFundoBranco: TRectangle;
    recToolbar: TRectangle;
    layBotoes: TFlowLayout;
    saveDialog: TSaveDialog;
    imgVisualizar: TImageViewer;
    StyleBook1: TStyleBook;
    laySalvar: TLayout;
    imgSalvarLine: TImage;
    imgSalvarFull: TImage;
    lblSalvarAtalho: TLabel;
    lblSalvar: TLabel;
    layGirar: TLayout;
    imgGirarLine: TImage;
    imgGirarFull: TImage;
    lblGirarAtalho: TLabel;
    lblGirar: TLabel;
    layTamanhoReal: TLayout;
    imgTamanhoRealLine: TImage;
    imgTamanhoRealFull: TImage;
    lblTamanhoAtalho: TLabel;
    lblTamanho: TLabel;
    layZoom: TLayout;
    tbrZoom: TTrackBar;
    lblZoomAtalho: TLabel;
    lblZoom: TLabel;
    procedure recFundoBrancoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure btnGirarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnFullsizeClick(Sender: TObject);
    procedure tbrZoomTracking(Sender: TObject);
    procedure laySalvarMouseEnter(Sender: TObject);
    procedure laySalvarMouseLeave(Sender: TObject);
    procedure layGirarMouseEnter(Sender: TObject);
    procedure layGirarMouseLeave(Sender: TObject);
    procedure layTamanhoRealMouseEnter(Sender: TObject);
    procedure layTamanhoRealMouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbrZoomMouseEnter(Sender: TObject);
    procedure tbrZoomMouseLeave(Sender: TObject);
  private
    { Private declarations }
    procedure AnimarBotao(Habilitar: Boolean; ImgLine, ImgFull: TImage; lblNome, lblAtalho: TLabel);

  public
    { Public declarations }

  end;

var
  fmxVisualizarImagem: TfmxVisualizarImagem;

implementation

{$R *.fmx}

procedure TfmxVisualizarImagem.AnimarBotao(Habilitar: Boolean; ImgLine, ImgFull: TImage; lblNome, lblAtalho: TLabel);
begin
  If Habilitar Then
  Begin
    imgLine.Opacity := 0;
    imgFull.Opacity := 1;

    lblNome.Opacity   := 1;
    lblAtalho.Opacity := 1;
  End
  Else
  Begin
    imgLine.Opacity := 1;
    imgFull.Opacity := 0;

    lblNome.Opacity := 0.3;
    lblAtalho.Opacity := 0.3;
  End;
end;

procedure TfmxVisualizarImagem.btnFullsizeClick(Sender: TObject);
begin
  If (imgVisualizar.BitmapScale <> 1) Then
  Begin
    imgVisualizar.BitmapScale := 1.0;
    lblTamanho.Text := 'Ajustar à Tela';
  End
  Else
  Begin
    imgVisualizar.BestFit;
    lblTamanho.Text := 'Tamanho Real';
  End;

  tbrZoom.Value := imgVisualizar.BitmapScale;
end;

procedure TfmxVisualizarImagem.btnGirarClick(Sender: TObject);
begin
  imgVisualizar.BeginUpdate;
  imgVisualizar.Bitmap.Rotate(90);
  imgVisualizar.EndUpdate;
  imgVisualizar.Repaint;
end;

procedure TfmxVisualizarImagem.btnSalvarClick(Sender: TObject);
Var
  Extensao : String;
  M: TBitmapData;
  X,Y: integer;
begin
  Extensao              := imgVisualizar.TagString.Split(['|'])[1];
  saveDialog.FileName   := ReplaceStr(imgVisualizar.TagString, '|', '.');
  saveDialog.DefaultExt := Extensao;
  saveDialog.Filter     := UpperCase(Extensao) + '|*.' + LowerCase(Extensao);

  imgVisualizar.Bitmap.Map(TMapAccess.ReadWrite,M);

  for X:=0 to imgVisualizar.Bitmap.Width-1 do
    for Y:=0 to imgVisualizar.Bitmap.Height-1 do
      if M.GetPixel(X,Y) = TAlphaColorRec.Null then
        M.SetPixel(X,Y,TAlphaColorRec.White);

  imgVisualizar.Bitmap.Unmap(M);
  Invalidate;

  If saveDialog.Execute Then
    imgVisualizar.Bitmap.SaveToFile(saveDialog.FileName);
end;

procedure TfmxVisualizarImagem.FormCreate(Sender: TObject);
begin
  imgVisualizar.BitmapScale := 1;
  tbrZoom.Value             := 1;

  imgSalvarFull.Opacity      := 0;
  imgSalvarLine.Opacity      := 1;
  imgGirarFull.Opacity       := 0;
  imgGirarLine.Opacity       := 1;
  imgTamanhoRealFull.Opacity := 0;
  imgTamanhoRealLine.Opacity := 1;
end;

procedure TfmxVisualizarImagem.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkEscape : close;
    vkRight  : tbrZoom.Value := tbrZoom.Value + 0.1;
    vkLeft   : tbrZoom.Value := tbrZoom.Value - 0.1;
    vkF2     : btnSalvarClick(laySalvar);
    vkF3     : btnGirarClick(layGirar);
    vkF4     : btnFullsizeClick(layTamanhoReal);
  End;
end;

procedure TfmxVisualizarImagem.layGirarMouseEnter(Sender: TObject);
begin
  AnimarBotao(True, imgGirarLine, imgGirarFull, lblGirar, lblGirarAtalho);
end;

procedure TfmxVisualizarImagem.layGirarMouseLeave(Sender: TObject);
begin
  AnimarBotao(False, imgGirarLine, imgGirarFull, lblGirar, lblGirarAtalho);
end;

procedure TfmxVisualizarImagem.laySalvarMouseEnter(Sender: TObject);
begin
  AnimarBotao(True, imgSalvarLine, imgSalvarFull, lblSalvar, lblSalvarAtalho);
end;

procedure TfmxVisualizarImagem.laySalvarMouseLeave(Sender: TObject);
begin
  AnimarBotao(False, imgSalvarLine, imgSalvarFull, lblSalvar, lblSalvarAtalho);
end;

procedure TfmxVisualizarImagem.layTamanhoRealMouseEnter(Sender: TObject);
begin
  AnimarBotao(True, imgTamanhoRealLine, imgTamanhoRealFull, lblTamanho, lblTamanhoAtalho);
end;

procedure TfmxVisualizarImagem.layTamanhoRealMouseLeave(Sender: TObject);
begin
  AnimarBotao(False, imgTamanhoRealLine, imgTamanhoRealFull, lblTamanho, lblTamanhoAtalho);
end;

procedure TfmxVisualizarImagem.recFundoBrancoClick(Sender: TObject);
begin
  Close;
end;

procedure TfmxVisualizarImagem.tbrZoomMouseEnter(Sender: TObject);
begin
  lblZoom.Opacity := 1;
  lblZoomAtalho.Opacity := 1;
end;

procedure TfmxVisualizarImagem.tbrZoomMouseLeave(Sender: TObject);
begin
  lblZoom.Opacity := 0.3;
  lblZoomAtalho.Opacity := 0.3;
end;

procedure TfmxVisualizarImagem.tbrZoomTracking(Sender: TObject);
begin
  imgVisualizar.BitmapScale := tbrZoom.Value;
end;

end.
