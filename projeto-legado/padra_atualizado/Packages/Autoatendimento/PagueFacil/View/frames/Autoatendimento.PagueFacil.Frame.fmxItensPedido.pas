unit Autoatendimento.PagueFacil.Frame.fmxItensPedido;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation;

type
  TframeItensPedido = class(TFrame)
    recFundoItensPedido: TRectangle;
    lblDESITE: TLabel;
    lblCODITE: TLabel;
    lblUNIDAD: TLabel;
    lblVALUNI: TLabel;
    lblVALTOT: TLabel;
    linRodape: TLine;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
