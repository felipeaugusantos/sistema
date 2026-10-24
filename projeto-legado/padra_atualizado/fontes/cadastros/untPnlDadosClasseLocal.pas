unit untPnlDadosClasseLocal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, UniClientDataSet;

type
  TfrmPnlDadosClasseLocal = class(TForm)
    shpMapeamento: TShape;
    lblMapeamento: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    strCodIte: String;
  end;

  TfrmPnlDadosClasseLocalClass = Class Of TfrmPnlDadosClasseLocal;

var
  frmPnlDadosClasseLocal: TfrmPnlDadosClasseLocal;

implementation

{$R *.dfm}

{ TfrmPnlDadosFormula }



procedure TfrmPnlDadosClasseLocal.FormShow(Sender: TObject);
begin
  lblMapeamento.Caption := 'Classes mapeadas para o produto ' + strCodIte;
end;

end.




