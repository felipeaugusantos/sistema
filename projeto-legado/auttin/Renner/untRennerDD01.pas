unit untRennerDD01;

interface

uses  DB,SysUtils,untAbstractDataSetFactory;

type
  TRennerDD01 = class(TAbstractDataSetFactory)
  public
    function GetDataSet: TDataSet; override;
  end;

implementation
uses untDefinicaoTxtCampoTipo,
  untADOTxtFactory, untGenericDefinicaoTxt, untGenericDefinicaoTxtCampo, untIDefinicaoTxtCampo,
  untDefinicaoTxtCharacterSet, untFuncTinta,untDataSetFactory;
{ TRennerDD01 }

function TRennerDD01.GetDataSet: TDataSet;
begin
  Result := TADOTxtFactory.GetTxt12DataSet(
    TGenericDefinicaoTxt.Create(ExtractFilePath(fGetConfTinta('REI').fGet('TXTREI')) + 'DD01.txt',
      False, ';', dtcsAnsi, '.', '.', TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
        TGenericDefinicaoTxtCampo.Create('CODPROD', dtctText, 10),
        TGenericDefinicaoTxtCampo.Create('PIG', dtctText, 5),
        TGenericDefinicaoTxtCampo.Create('BASE', dtctText, 20),
        TGenericDefinicaoTxtCampo.Create('QTD14_1', dtctInteger),
        TGenericDefinicaoTxtCampo.Create('QTD14_2', dtctInteger),
        TGenericDefinicaoTxtCampo.Create('QTD14_3', dtctInteger),
        TGenericDefinicaoTxtCampo.Create('QTD01_1', dtctInteger),
        TGenericDefinicaoTxtCampo.Create('QTD01_2', dtctInteger),
        TGenericDefinicaoTxtCampo.Create('QTD01_3', dtctInteger),
        TGenericDefinicaoTxtCampo.Create('QTD18_1', dtctInteger),
        TGenericDefinicaoTxtCampo.Create('QTD18_2', dtctInteger),
        TGenericDefinicaoTxtCampo.Create('QTD18_3', dtctInteger)
  ])));
end;

initialization
  TDataSetFactory.Registrar('RennerDD01', TRennerDD01);

end.

