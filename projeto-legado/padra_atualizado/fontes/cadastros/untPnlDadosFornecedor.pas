unit untPnlDadosFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmPnlDadosFornecedor = class(TForm)
    gpbLegenda: TGroupBox;
    shpLegenda: TShape;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TfrmPnlDadosFornecedorClass = Class Of TfrmPnlDadosFornecedor;


var
  frmPnlDadosFornecedor: TfrmPnlDadosFornecedor;

implementation

{$R *.dfm}

end.
