unit untADOFactory;

interface

uses
  ADODB;

type
  TADOFactory = class (TInterfacedObject)
  public
    class function GetExcelQuery8(const strNomeArquivo: String): TADOQuery;
    class function GetAccessQuery8(const strNomeArquivo: String): TADOQuery;
    class function GetExcelQuery12(const strNomeArquivo: String): TADOQuery;
    class function GetExcelQuery12NoHeader(const strNomeArquivo: String): TADOQuery;
    class function GetAccessQuery12(const strNomeArquivo: String): TADOQuery;
    class function GetExcelDataSet12(const strNomeArquivo: String): TADODataSet;
    class function GetAccessDataSet12(const strNomeArquivo: String): TADODataSet;
  end;

implementation

{ TADOFacotory }

class function TADOFactory.GetAccessDataSet12(const strNomeArquivo: String): TADODataSet;
begin
  Result := TADODataSet.Create(nil);
  Result.ConnectionString :=
    'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=' +
    strNomeArquivo +
    ';Persist Security Info=False';
end;

class function TADOFactory.GetExcelDataSet12(const strNomeArquivo: String): TADODataSet;
begin
  Result := TADODataSet.Create(nil);
  Result.ConnectionString :=
    'Provider=Microsoft.ACE.OLEDB.12.0;' +
    'Data Source=' + strNomeArquivo + ';' +
    'Mode=Read;' +
    'Extended Properties=Excel 12.0;' +
    'Persist Security Info=False';
end;

class function TADOFactory.GetAccessQuery12(const strNomeArquivo: String): TADOQuery;
begin
  Result := TADOQuery.Create(nil);
  Result.ConnectionString :=
    'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=' +
    strNomeArquivo +
    ';Persist Security Info=False';
end;

class function TADOFactory.GetAccessQuery8(const strNomeArquivo: String): TADOQuery;
begin
  Result := TADOQuery.Create(nil);
  Result.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' +
    strNomeArquivo +
    ';Persist Security Info=False';
end;

class function TADOFactory.GetExcelQuery12(const strNomeArquivo: String): TADOQuery;
begin
  Result := TADOQuery.Create(nil);
  Result.ConnectionString :=
    'Provider=Microsoft.ACE.OLEDB.12.0;' +
    'Data Source=' + strNomeArquivo + ';' +
    'Mode=Read;' +
    'Extended Properties=Excel 12.0;' +
    'Persist Security Info=False';
end;

class function TADOFactory.GetExcelQuery12NoHeader(const strNomeArquivo: String): TADOQuery;
begin
  Result := TADOQuery.Create(nil);
  Result.ConnectionString :=
    'Provider=Microsoft.ACE.OLEDB.12.0;' +
    'Data Source=' + strNomeArquivo +
    ';Extended Properties="Excel 12.0;HDR=NO;IMEX=1";' +
    'Persist Security Info=False';
end;

class function TADOFactory.GetExcelQuery8(const strNomeArquivo: String): TADOQuery;
begin
  Result := TADOQuery.Create(nil);
  Result.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;' +
    'Data Source=' + strNomeArquivo + ';' +
    'Mode=Read;' +
    'Extended Properties=Excel 8.0;' +
    'Persist Security Info=False';
end;

end.
