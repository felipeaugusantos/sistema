unit untTCdsRastreamentoLote;

interface

uses
  UniClientDataSet, Classes, SysUtils, Data.Db,
  System.Variants;

  type
    TCdsRastreamentoLote = class(TUniClientDataSet)
    private
      blnFilteredBackup : boolean;
      strFilterBackup : String;
    public
      constructor Create(AOwner: TComponent); override;
      procedure pSetBackupFilter;
      procedure pVoltaBackupFilter;
  end;


implementation

{ TCdsRastreamentoLote }

constructor TCdsRastreamentoLote.Create(AOwner: TComponent);
begin
  inherited;

  blnFilteredBackup := False;
  strFilterBackup := '';

  With FieldDefs.AddFieldDef Do Begin Name := 'AUTOINCREM_MOVRAS';    DataType := ftString; Size := 020; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'AUTOINCREM_MOVDET';    DataType := ftString; Size := 020; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'AUTOINCREM_ORDDET';    DataType := ftString; Size := 020; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'AUTOINCREM_LOTRAS';    DataType := ftString; Size := 030; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'AUTOINCREM_FATGOR';    DataType := ftString; Size := 020; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO_FORNECEDOR';    DataType := ftString; Size := 008; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO_ITEM';          DataType := ftString; Size := 007; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'NUMERO_LOTE';          DataType := ftString; Size := 030; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'QUANTIDADE_ETIQUETAS'; DataType := ftInteger; Required := False; End;

  CreateDataSet;
  Open;
end;

procedure TCdsRastreamentoLote.pVoltaBackupFilter;
begin
  Self.Filter := strFilterBackup;
  Self.Filtered := blnFilteredBackup;
end;

procedure TCdsRastreamentoLote.pSetBackupFilter;
begin
  strFilterBackup := Self.Filter;
  blnFilteredBackup := Self.Filtered;
end;

end.
