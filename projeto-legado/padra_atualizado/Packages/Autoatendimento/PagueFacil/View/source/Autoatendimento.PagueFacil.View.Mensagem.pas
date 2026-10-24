unit Autoatendimento.PagueFacil.View.Mensagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects,
  FMX.Filter.Effects;

type
  TfmxMensagem = class(TForm)
    recFundoBranco: TRectangle;
    patIcone: TPath;
    cirFundoIcone: TCircle;
    layFundo: TLayout;
    layTopo: TLayout;
    recEsmaecer: TRectangle;
    lblDescricao: TLabel;
    lblMensagem: TText;
    recBotaoConfirma: TRectangle;
    layBotoes: TLayout;
    lblBotao: TLabel;
    efeSombraJanela: TShadowEffect;
    efeSombraBotao: TShadowEffect;
    ShadowEffect1: TShadowEffect;
    recFundoTopo: TRectangle;
    layRodape: TLayout;
    recFundoRodape: TRectangle;
    Line1: TLine;
    procedure recBotaoConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmxMensagem: TfmxMensagem;

implementation

{$R *.fmx}

procedure TfmxMensagem.recBotaoConfirmaClick(Sender: TObject);
begin
  Close;
end;

end.
