unit Principal.View.Frame.FMXPainelRotasGridItemALiberarLinha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Effects, FMX.Controls.Presentation, FMX.Ani,
  TaEntregue.Romaneios.Interfaces;

type
  TframeItemALiberar = class(TFrame)
    recFundoBranco: TRectangle;
    efeSombra: TShadowEffect;
    lblValorCodigo: TLabel;
    lblValorProduto: TLabel;
    lblValorPedido: TLabel;
    lblValorAvariada: TLabel;
    lblValorFaltante: TLabel;
    lblValorEntregue: TLabel;
    lblValorLiberar: TLabel;
    imgNaoLiberar: TImage;
    imgLiberar: TImage;
    procedure imgNaoLiberarClick(Sender: TObject);
    procedure imgLiberarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Pendencias : IPendencia;
  end;

implementation

{$R *.fmx}

procedure TframeItemALiberar.imgLiberarClick(Sender: TObject);
begin
  imgNaoLiberar.Opacity := 1;
  imgLiberar.Opacity := 0;

  imgNaoLiberar.HitTest := True;
  imgLiberar.HitTest    := False;

  Pendencias.DocsComItensBaixadosParcialmente[TImage(Sender).Parent.Tag]
    .Itens[TImage(Sender).Tag]
    .SetLiberarItem(False);
end;

procedure TframeItemALiberar.imgNaoLiberarClick(Sender: TObject);
begin
  imgNaoLiberar.Opacity := 0;
  imgLiberar.Opacity := 1;

  imgNaoLiberar.HitTest := False;
  imgLiberar.HitTest    := True;

  Pendencias.DocsComItensBaixadosParcialmente[TImage(Sender).Parent.Tag]
    .Itens[TImage(Sender).Tag]
    .SetLiberarItem(True);
end;

end.
