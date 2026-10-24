unit untCdsTransferenciaArmazens;

interface

uses
  UniClientDataSet, Classes, SysUtils, Data.Db, untFuncoesSimples,
  System.Variants;

  type
    TCdsTransferenciaArmazens = class(TUniClientDataSet)
    public
      constructor Create(AOwner: TComponent); override;
  end;


implementation

{ TCdsTransferenciaArmazens }

constructor TCdsTransferenciaArmazens.Create(AOwner: TComponent);
var
  intDecQtd : integer;
begin
  inherited;

  intDecQtd := fCfgSis('DECQTD', varInteger);

  With FieldDefs.AddFieldDef Do Begin Name := 'AUTINC'; DataType := ftString;   Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString;   Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'NUMLOT'; DataType := ftString;   Required := False; Size := VS_Size_NumLot; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'ARMORI'; DataType := ftString;   Required := False; Size := VS_Size_NumLot; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'ARMDES'; DataType := ftString;   Required := False; Size := VS_Size_NumLot; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'LOCFIS'; DataType := ftString;   Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'DTAVAL'; DataType := ftDate;     Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CAPANT'; DataType := ftFloat;    Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CAPACI'; DataType := ftFloat;    Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'SALDOS'; DataType := ftFloat;    Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'QTDITE'; DataType := ftFloat;    Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'QTDTOT'; DataType := ftFloat;    Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'AMZDES'; DataType := ftString;   Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'DTAFAB'; DataType := ftDateTime; Required := False; End;

  AggregatesActive := True;
  With TAggregateField.Create(Self) Do
  Begin
    FieldName := 'TOTDIG';
    DataSet := Self;
    Expression := 'SUM(QTDITE)';
    Active := True;
  End;

  CreateDataSet;
  Open;

  TFloatField(FieldByName('QTDITE')).DisplayFormat := fMskDigitos(intDecQtd);
  TFloatField(FieldByName('SALDOS')).DisplayFormat := fMskDigitos(intDecQtd);
  TFloatField(FieldByName('CAPACI')).DisplayFormat := fMskDigitos(intDecQtd);
  TFloatField(FieldByName('QTDTOT')).DisplayFormat := fMskDigitos(intDecQtd);

  IndexFieldNames := 'AUTINC;CODITE;NUMLOT';

end;

end.
