unit Principal.View.FMXNotificacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Ani, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFMXNotificacao = class(TForm)
    recFundoBranco: TRectangle;
    recRodape: TRectangle;
    patMensagem: TPath;
    layIcone: TLayout;
    efeSombra: TShadowEffect;
    layFundo: TLayout;
    lblTitulo: TLabel;
    lblTexto: TLabel;
    btnFechar: TSpeedButton;
    imgFechar: TImage;
    tmrTimer: TTimer;
    patConfirmacao: TPath;
    patErro: TPath;
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tipNotificacao: Integer;
  end;

var
  FMXNotificacao: TFMXNotificacao;

Const
  CorMensagem    = TAlphaColor($FF508fac);
  CorConfirmacao = TAlphaColor($FF1da161);
  CorErro        = TAlphaColor($FFad1507);

implementation

{$R *.fmx}

procedure TFMXNotificacao.btnFecharClick(Sender: TObject);
begin
  layFundo.Position.X := 450;
  Close;
end;

procedure TFMXNotificacao.FormShow(Sender: TObject);
begin
  tipNotificacao := 1;

  If (tipNotificacao = 1) Then
  Begin
    patMensagem.Visible    := True;
    patMensagem.Fill.Color := CorMensagem;
    recRodape.Fill.Color   := CorMensagem;
    lblTitulo.FontColor    := CorMensagem;
  End
  Else If (tipNotificacao = 2) Then
  Begin
    patConfirmacao.Visible    := True;
    patConfirmacao.Fill.Color := CorConfirmacao;
    recRodape.Fill.Color      := CorConfirmacao;
    lblTitulo.FontColor       := CorConfirmacao;
  End
  Else If (tipNotificacao = 3) Then
  Begin
    patErro.Visible      := True;
    patErro.Fill.Color   := CorErro;
    recRodape.Fill.Color := CorErro;
    lblTitulo.FontColor  := CorErro;
  End;

  layFundo.Position.X := 40;
end;

end.
