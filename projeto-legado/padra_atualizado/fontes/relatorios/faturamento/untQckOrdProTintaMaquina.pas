unit untQckOrdProTintaMaquina;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDBSet, frxDMPExport;

type
  TfrmQckOrdProTintaMaquina = class(TForm)
    frxReport: TfrxReport;
    frxDataset: TfrxDBDataset;
    frxOrdPro40Col: TfrxReport;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxSaltoPagina: TfrxUserDataSet;
    frxOrdPro40ColJ: TfrxReport;
    frxReportM: TfrxReport;
    procedure frxSaltoPaginaGetValue(const VarName: String;
      var Value: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
    strSalto: String;
  end;

var
  frmQckOrdProTintaMaquina: TfrmQckOrdProTintaMaquina;

implementation

{$R *.dfm}

procedure TfrmQckOrdProTintaMaquina.frxSaltoPaginaGetValue(
  const VarName: String; var Value: Variant);
begin
  Value := strSalto;
end;

end.
