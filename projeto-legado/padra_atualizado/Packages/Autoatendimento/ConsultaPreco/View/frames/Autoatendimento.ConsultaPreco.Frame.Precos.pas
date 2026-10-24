unit Autoatendimento.ConsultaPreco.Frame.Precos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Effects, FMX.Layouts;

type
  TframePrecos = class(TFrame)
    recfundoBranco: TRectangle;
    lblPrecoTabela: TLabel;
    lblPrecoVenda: TLabel;
    ShadowEffect2: TShadowEffect;
    lblCondicao: TLabel;
    recDesconto: TRectangle;
    patSetaBaixo: TPath;
    lblDesconto: TLabel;
    layPreco: TLayout;
    layCondicao: TLayout;
    layPromocao: TFlowLayout;
  private
    { Private declarations }
  public
    { Public declarations }
    LEmPromocao : Boolean;

    procedure AjustarLayout;
  end;

Const
  CorDefault  = TAlphaColor($FFF03D1C);
  CorPromocao = TAlphaColor($FF66CE02);

implementation

{$R *.fmx}

{ TframePrecos }

procedure TframePrecos.AjustarLayout;
begin
  If LEmPromocao Then
  Begin
    layPromocao.Visible     := True;
    recDesconto.Fill.Color  := CorPromocao;
    lblPrecoVenda.FontColor := CorPromocao;
  End
  Else
  Begin
    layPromocao.Visible     := False;
    recDesconto.Fill.Color  := CorDefault;
    lblPrecoVenda.FontColor := CorDefault;
  End;
end;

end.
