unit untRennerDM01;

interface

uses  DB,SysUtils,untAbstractDataSetFactory;

type
  TRennerDM01 = class(TAbstractDataSetFactory)
  public
    function GetDataSet: TDataSet; override;
  end;

implementation
uses  untDataSetFactory, untDefinicaoTxtCampoTipo,
  untADOTxtFactory, untGenericDefinicaoTxt, untGenericDefinicaoTxtCampo, untIDefinicaoTxtCampo,
  untDefinicaoTxtCharacterSet,  untFuncTinta;

{ TRennerDM01 }

function TRennerDM01.GetDataSet: TDataSet;
begin
  Result := TADOTxtFactory.GetTxt12DataSet(
    TGenericDefinicaoTxt.Create(ExtractFilePath(fGetConfTinta('REI').fGet('TXTREI')) + 'DM01.txt',
      False, ';', dtcsAnsi, '.', '.', 'ddmmyyyy', TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
        TGenericDefinicaoTxtCampo.Create('CODPROD', dtctText, 10),
        TGenericDefinicaoTxtCampo.Create('CODIND', dtctText, 8),
        TGenericDefinicaoTxtCampo.Create('COR', dtctText, 30),
        TGenericDefinicaoTxtCampo.Create('BASE', dtctText, 20),
        TGenericDefinicaoTxtCampo.Create('IDENT', dtctText, 2),
        TGenericDefinicaoTxtCampo.Create('DT_CAD', dtctDateTime),
        TGenericDefinicaoTxtCampo.Create('STAT', dtctText, 8),
        TGenericDefinicaoTxtCampo.Create('STAT2', dtctText, 8)
  ])));
end;

initialization
  TDataSetFactory.Registrar('RennerDM01', TRennerDM01);

end.
