unit Principal.View.Frame.FMXPainelRotasConversasRecentes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts,
  Principal.View.Frame.FMXPainelRotasNotificacao;

type
  TframeConversasRecentes = class(TFrame)
    cirAvatar: TCircle;
    lblNome: TLabel;
    layInfo: TLayout;
    lblUltimaMsg: TLabel;
    layNotificacoes: TLayout;
    lblPeriodo: TLabel;
    frameNotificacao: TframeNotificacao;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

{ TframeConversasRecentes }


end.
