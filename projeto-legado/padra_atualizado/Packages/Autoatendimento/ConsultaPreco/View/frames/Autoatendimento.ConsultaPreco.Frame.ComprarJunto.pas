unit Autoatendimento.ConsultaPreco.Frame.ComprarJunto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Effects, FMX.Layouts,
  Autoatendimento.ConsultaPreco.Frame.Precos;

type
  TframeComprarJunto = class(TFrame)
    recFundoAzul: TRectangle;
    recFundoBranco: TRectangle;
    lblDescricao: TLabel;
    imgProduto: TImage;
    layRodape: TLayout;
    fraPrecos: TframePrecos;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
