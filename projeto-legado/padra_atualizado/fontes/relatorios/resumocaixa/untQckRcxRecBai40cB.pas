unit untQckRcxRecBai40cB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDMPExport, frxDBSet, DB, UniClientDataSet, UniDataSetProvider,
  Provider, Datasnap.DBClient, frxExportPDF;

type
  TfrmQckRcxRecBai40cB = class(TForm)
    frxRecibo: TfrxReport;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    cdsRecibo: TUniClientDataSet;
    frxDBRecibo: TfrxDBDataset;
    dspRecibo: TUniDataSetProvider;
    frxAuxiliar: TfrxUserDataSet;
    frxChePre: TfrxDBDataset;
    frxCheAvi: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    procedure frxAuxiliarGetValue(const VarName: String;
      var Value: Variant);
    procedure frxOperadorGetValue(const VarName: String;
      var Value: Variant);
    procedure FormCreate(Sender: TObject);
    function frxReciboUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
  public
    { Public declarations }
    strCodOpe: String;
  end;

var
  frmQckRcxRecBai40cB: TfrmQckRcxRecBai40cB;

implementation

 uses  untfuncoesSimples;

{$R *.dfm}

procedure TfrmQckRcxRecBai40cB.FormCreate(Sender: TObject);
begin
  frxRecibo.AddFunction('function fRetNomVendRep(strCodVen: String): String;');
end;

procedure TfrmQckRcxRecBai40cB.frxAuxiliarGetValue(
  const VarName: String; var Value: Variant);
begin

   If VarName = 'OPERADOR' Then
     Value := fRetNomeOperador(strCodOpe);

end;

procedure TfrmQckRcxRecBai40cB.frxOperadorGetValue(const VarName: String;
  var Value: Variant);
begin
  Value := fRetNomeOperador(strCodOpe);

end;

function TfrmQckRcxRecBai40cB.frxReciboUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  If SameText('fRetNomVendRep', MethodName) Then
    Result := fRetNomVendRep(Params[0]);
end;

end.
