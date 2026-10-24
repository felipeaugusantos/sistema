unit Autoatendimento.ConsultaPreco.Frame.ProdutosSimilares;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.Effects,
  Autoatendimento.ConsultaPreco.Frame.Precos;

type
  TframeProdutosSimilares = class(TFrame)
    recFundoAzul: TRectangle;
    recFundoBranco: TRectangle;
    lblDescricao: TLabel;
    layBody: TLayout;
    layEsquerda: TLayout;
    layRodape: TLayout;
    imgProduto: TImage;
    lblDetalhes: TText;
    StyleBook1: TStyleBook;
    fraPrecos: TframePrecos;
    layDetalhes: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
