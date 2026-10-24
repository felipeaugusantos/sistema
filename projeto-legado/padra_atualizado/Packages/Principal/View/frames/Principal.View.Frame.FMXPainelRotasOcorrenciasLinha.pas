unit Principal.View.Frame.FMXPainelRotasOcorrenciasLinha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TframeOcorrencias = class(TFrame)
    lblDataHora: TLabel;
    lblDescricao: TLabel;
    lblMensagem: TLabel;
    linBase: TLine;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
