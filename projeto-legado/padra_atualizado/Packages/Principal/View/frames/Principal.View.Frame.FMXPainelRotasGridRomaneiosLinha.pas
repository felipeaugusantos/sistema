unit Principal.View.Frame.FMXPainelRotasGridRomaneiosLinha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.ListBox,
  FMX.Effects, System.ImageList, FMX.ImgList;

type
  TframeGridRomaneiosLinha = class(TFrame)
    recBordas: TRectangle;
    layFundo: TLayout;
    recFundoBranco: TRectangle;
    efeSombra1: TShadowEffect;
    lblValorRomaneio: TLabel;
    lblValorMotorista: TLabel;
    lblValorEntregas: TLabel;
    lblValorData: TLabel;
    lblValorInicio: TLabel;
    lblValorFim: TLabel;
    imgStatus: TImage;
    lblProgressDocsConcluidos: TLabel;
    recProgressBordaDocsConcluidos: TRectangle;
    recPorcentagemDocsConcluidos: TRectangle;
    lblPorcentagemDocsConcluidos: TLabel;
    lblValorDocsConcluidos: TLabel;
    imgRota: TImage;
    imgDocumentos: TImage;
    imgChat: TImage;
    lblOcorrencia: TLabel;
    imgOcorrencia: TImage;
    lblResolvido: TLabel;
    imgResolvido: TImage;
    lblValorVeiculo: TLabel;
    layValorRomaneio: TLayout;
    layValorMotorista: TLayout;
    layBotoesRota: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    imgCancelado: TImage;
    procedure FramePaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

{ TframeGridRomaneiosLinha }

procedure TframeGridRomaneiosLinha.FramePaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
Var
  LPercConcluido : Double;
begin
  LPercConcluido := recPorcentagemDocsConcluidos.TagFloat;
  recPorcentagemDocsConcluidos.Width := (LPercConcluido * (recProgressBordaDocsConcluidos.Width - 2)) / 100;
end;

end.
