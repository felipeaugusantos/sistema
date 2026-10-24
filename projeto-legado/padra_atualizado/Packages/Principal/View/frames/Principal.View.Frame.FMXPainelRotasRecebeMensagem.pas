unit Principal.View.Frame.FMXPainelRotasRecebeMensagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TframeMsgRecebida = class(TFrame)
    lblMensagem: TLabel;
    lblHora: TLabel;
    recFundoMsgRecebida: TCalloutRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
