unit Autoatendimento.PagueFacil.View.Pergunta;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects,
  FMX.Filter.Effects, DateUtils;

type
  TfmxPergunta = class(TForm)
    recFundoBranco: TRectangle;
    cirFundoIcone: TCircle;
    layFundo: TLayout;
    layTopo: TLayout;
    recEsmaecer: TRectangle;
    lblDescricao: TLabel;
    lblMensagem: TText;
    recBotaoSim: TRectangle;
    layBotoes: TLayout;
    lblBotaoSim: TLabel;
    efeSombraJanela: TShadowEffect;
    recFundoTopo: TRectangle;
    layRodape: TLayout;
    recFundoRodape: TRectangle;
    Line1: TLine;
    patIconePergunta: TPath;
    recBotaoNao: TRectangle;
    lblBotaoNao: TLabel;
    efeSombraBotaoNao: TShadowEffect;
    efeSombraBotaoSim: TShadowEffect;
    tmrClose: TTimer;
    procedure recBotaoSimClick(Sender: TObject);
    procedure recBotaoNaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure tmrCloseTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmxPergunta: TfmxPergunta;

implementation

{$R *.fmx}

procedure TfmxPergunta.FormCreate(Sender: TObject);
begin
  Self.Tag := mrNo;
  tmrClose.Enabled := True;
end;

procedure TfmxPergunta.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkEscape: Self.Close;
  End;
end;

procedure TfmxPergunta.recBotaoNaoClick(Sender: TObject);
begin
  Self.Tag := mrNo;
  Self.Close;
end;

procedure TfmxPergunta.recBotaoSimClick(Sender: TObject);
begin
  Self.Tag := mrYes;
  Self.Close;
end;

procedure TfmxPergunta.tmrCloseTimer(Sender: TObject);
begin
  Self.Tag := mrNo;
  Self.Close;
end;

end.
