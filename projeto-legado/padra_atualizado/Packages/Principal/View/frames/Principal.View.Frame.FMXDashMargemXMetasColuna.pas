unit Principal.View.Frame.FMXDashMargemXMetasColuna;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation;

type
  TframeMargemXMetasColuna = class(TFrame)
    layLegenda: TLayout;
    layColunas: TLayout;
    recMargem: TRectangle;
    recMeta: TRectangle;
    layMargem: TLayout;
    layMeta: TLayout;
    lblLegenda: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
