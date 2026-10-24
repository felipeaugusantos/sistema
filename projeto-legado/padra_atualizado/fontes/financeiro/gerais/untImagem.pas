{**************************************}
{* AMPLIAÇÃO DE IMAGENS               *}
{***********************************RV*}
unit untImagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, ExtCtrls, StdCtrls, Spin, AppEvnts, Menus, Buttons, frxClass,
  frxExportCSVTestabilidade, BitBtnLockedIncrem;

type
  TfrmImagem = class(TfrmPai)
    pnl1: TPanel;
    lbl1: TLabel;
    btnTamFig: TSpinButton;
    chkTamOri: TCheckBox;
    pnlImage: TPanel;
    ScrollBox1: TScrollBox;
    imgFoto: TImage;
    lblTamZoom: TLabel;
    procedure chkTamOriClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTamFigDownClick(Sender: TObject);
    procedure btnTamFigUpClick(Sender: TObject);
    function fValidaImagem30por30: Boolean;
    function fEhImagemProporcional : Boolean;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fltTamOriginal : Double;
    procedure pCentralizar;
    procedure pCalcularZoom;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


procedure TfrmImagem.chkTamOriClick(Sender: TObject);
Var LfltPercent : Double;
begin
  inherited;
  imgFoto.AutoSize := chkTamOri.Checked;

  If imgFoto.AutoSize Then
  Begin
    Self.WindowState := wsMaximized;
    imgFoto.Align := alNone;
  End
  Else
  Begin
    imgFoto.Align := alClient;
    imgFoto.Align := alNone;
  End;

  pCentralizar;

  if chkTamOri.Checked then
  Begin
    lblTamZoom.Caption := '(100%)';
    fltTamOriginal     := imgFoto.Width;
  End
  Else
  Begin
    LfltPercent := ((100 * imgFoto.Width) / fltTamOriginal);
    lblTamZoom.Caption := '(' + FloatToStrF(LfltPercent,ffNumber, 5, 0)  + '%)';
  End;
end;

procedure TfrmImagem.pCentralizar;
begin
  If (imgFoto.Width < pnlImage.Width) Then
    imgFoto.Left := (pnlImage.Width - imgFoto.Width) Div 2
  Else
    imgFoto.Left := 0;

  If (imgFoto.Height < pnlImage.Height) Then
    imgFoto.Top  := (pnlImage.Height - imgFoto.Height) Div 2
  Else
    imgFoto.Top  := 0;

  Application.ProcessMessages;
end;

procedure TfrmImagem.FormCreate(Sender: TObject);
begin
  inherited;
  fltTamOriginal := 0;
end;

procedure TfrmImagem.FormShow(Sender: TObject);
begin
  inherited;
  If Not fEhImagemProporcional Then
  Begin
    imgFoto.AutoSize  := False;

    If imgFoto.Width > pnlImage.Width - 20 Then
      imgFoto.Width  := 750;

    If imgFoto.Width > pnlImage.Height - 20 Then
      imgFoto.Height := 450;
    imgFoto.Proportional := True;
    pCentralizar;
  End
  Else
    chkTamOri.Checked := True;


  lblTamZoom.Visible := lbl1.Visible;
  pCalcularZoom;
end;

function TfrmImagem.fValidaImagem30por30: Boolean;
begin
  Result := False;
  If(imgFoto.Width <= 30) Then
    Exit;

  If(imgFoto.Height <= 30) Then
    Exit;
  Result := True;
end;

function TfrmImagem.fEhImagemProporcional: Boolean;
begin
  Result           := False;
  imgFoto.Align    := alNone;
  imgFoto.AutoSize := True;
  fltTamOriginal   := imgFoto.Width;

  If(imgFoto.Width >= pnlImage.Width - 20) Then
    Exit;

  If(imgFoto.Height >= pnlImage.Height - 20) Then
    Exit;

  Result          := True;
end;

procedure TfrmImagem.btnTamFigDownClick(Sender: TObject);
begin
  inherited;
  If chkTamOri.Checked Then
    chkTamOri.Checked := False;

  imgFoto.Align        := alNone;
  imgFoto.Proportional := False;
  If fValidaImagem30por30 Then
  Begin
    imgFoto.Width      := imgFoto.Width  - 20;
    imgFoto.Height     := imgFoto.Height - 20;
  End;
  imgFoto.Proportional := True;

  pCentralizar;
  pCalcularZoom;
end;

procedure TfrmImagem.btnTamFigUpClick(Sender: TObject);
begin
  inherited;
  If chkTamOri.Checked Then
    chkTamOri.Checked := False;

  imgFoto.Align        := alNone;
  imgFoto.Proportional := False;
  imgFoto.Width        := imgFoto.Width  + 20;
  imgFoto.Height       := imgFoto.Height + 20;
  imgFoto.Proportional := True;

  pCentralizar;
  pCalcularZoom;
end;

procedure TfrmImagem.pCalcularZoom;
Var LfltPercent : Double;
begin
  If lblTamZoom.Visible Then
  Begin
    LfltPercent        := ((100 * imgFoto.Width) / fltTamOriginal);
    lblTamZoom.Caption := '(' + FloatToStrF(LfltPercent,ffNumber, 5, 0)  + '%)';
    chkTamOri.Checked  := (LfltPercent = 100);
  End;
End;


end.

