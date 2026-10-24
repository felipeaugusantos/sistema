unit untPnlDadosAcessorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmPnlDadosAcessorio = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    strNomForm : String;
    constructor Create(AOwner: TComponent); reintroduce; virtual;
  end;

  TfrmPnlDadosAcessorioClass = Class Of TfrmPnlDadosAcessorio;

var
  frmPnlDadosAcessorio: TfrmPnlDadosAcessorio;

implementation

{$R *.dfm}

{ TfrmPnlDadosAcessorio }

constructor TfrmPnlDadosAcessorio.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

end.
