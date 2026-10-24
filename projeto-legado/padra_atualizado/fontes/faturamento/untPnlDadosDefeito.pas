unit untPnlDadosDefeito;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmPnlDadosDefeito = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    strNomForm : String;
    constructor Create(AOwner: TComponent); reintroduce; virtual;
  end;

  TfrmPnlDadosDefeitoClass = Class Of TfrmPnlDadosDefeito;

var
  frmPnlDadosDefeito: TfrmPnlDadosDefeito;

implementation

{$R *.dfm}

{ TfrmPnlDadosDefeito }

constructor TfrmPnlDadosDefeito.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

end.
