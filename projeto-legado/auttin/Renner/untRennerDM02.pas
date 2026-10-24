unit untRennerDM02;

interface

uses DB,SysUtils,untAbstractDataSetFactory;

type
  TRennerDM02 = class(TAbstractDataSetFactory)
  public
    function GetDataSet: TDataSet; override;
  end;

implementation
uses  untDataSetFactory, untDefinicaoTxtCampoTipo,
  untADOTxtFactory, untGenericDefinicaoTxt, untGenericDefinicaoTxtCampo, untIDefinicaoTxtCampo,
  untDefinicaoTxtCharacterSet,untFuncTinta;

{ TRennerDM02 }

function TRennerDM02.GetDataSet: TDataSet;
begin
  Result := TADOTxtFactory.GetTxt12DataSet(
    TGenericDefinicaoTxt.Create(ExtractFilePath(fGetConfTinta('REI').fGet('TXTREI')) + 'DM02.txt',
      False, ';', dtcsAnsi, '.', '.', TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
        TGenericDefinicaoTxtCampo.Create('TIPO', dtctText, 1),
        TGenericDefinicaoTxtCampo.Create('PIG', dtctText, 5),
        TGenericDefinicaoTxtCampo.Create('COD', dtctText, 4),
        TGenericDefinicaoTxtCampo.Create('DESCR', dtctText, 35),
        TGenericDefinicaoTxtCampo.Create('VLR_U', dtctDouble, 17),
        TGenericDefinicaoTxtCampo.Create('VLR_Y', dtctDouble, 17),
        TGenericDefinicaoTxtCampo.Create('VLR_Z', dtctDouble, 17),
        TGenericDefinicaoTxtCampo.Create('PER_N01', dtctDouble, 8),
        TGenericDefinicaoTxtCampo.Create('PER_N14', dtctDouble, 8),
        TGenericDefinicaoTxtCampo.Create('PER_N50', dtctDouble, 8),
        TGenericDefinicaoTxtCampo.Create('PER_I01', dtctDouble, 8),
        TGenericDefinicaoTxtCampo.Create('PER_I14', dtctDouble, 8),
        TGenericDefinicaoTxtCampo.Create('PER_I50', dtctDouble, 8)
  ])));
end;

initialization
  TDataSetFactory.Registrar('RennerDM02', TRennerDM02);

end.

