unit Contabilidade.Classes.TImportacaoDadosContabeisFonteDataset;

interface

uses
  System.SysUtils, System.Classes, Data.Db,
  Contabilidade.Classes.TImportacaoDadosContabeis;

type
  TImportacaoDadosContabeisFonteDataSet = class(TInterfacedObject, IImportacaoDadosContabeisFonte)
  private
    FDataSet: TDataSet;
    FOwnsDataSet: Boolean;
    procedure pValidaDataset;
  public
    function fQntLinhas: Integer;
    function fQntColunas: Integer;
    function fTemCabecalho: Boolean;
    function fGetDadosCelula(const AintCol, AintRow: Integer; out AstrCelula: string): string; //coluna e linha sempre 0-based

    // AOwnsDataSet=True: a fonte assume ownership do dataset e o destroi ao ser liberada.
    class function New(ADataSet: TDataSet; AOwnsDataSet: Boolean = False): IImportacaoDadosContabeisFonte;
    constructor Create(ADataSet: TDataSet; AOwnsDataSet: Boolean = False);
    destructor Destroy; override;
  end;

implementation

{ TImportacaoDadosContabeisFonteDataSet }

constructor TImportacaoDadosContabeisFonteDataSet.Create(ADataSet: TDataSet; AOwnsDataSet: Boolean = False);
begin
  FDataSet    := ADataSet;
  FOwnsDataSet := AOwnsDataSet;
end;

destructor TImportacaoDadosContabeisFonteDataSet.Destroy;
begin
  if FOwnsDataSet then
    FreeAndNil(FDataSet);
  inherited;
end;

function TImportacaoDadosContabeisFonteDataSet.fGetDadosCelula(const AintCol,
  AintRow: Integer; out AstrCelula: string): string;
var
  LintRecNoAlvo: Integer;
begin
  pValidaDataset;

  AstrCelula := '(' + IntToStr(AintCol) + ',' + IntToStr(AintRow) + ')';

  if (AintCol < 0) or (AintCol >= FDataSet.FieldCount) then
    raise EImportacaoDadosContabeis.CreateFmt(
      'Coluna %d fora do intervalo (0..%d).', [AintCol, FDataSet.FieldCount - 1]);

  // AintRow 0-based, RecNo 1-based
  LintRecNoAlvo := AintRow + 1;

  if FDataSet.RecNo <> LintRecNoAlvo then
  begin
    if FDataSet.RecNo = LintRecNoAlvo - 1 then
      FDataSet.Next
    else
      FDataSet.RecNo := LintRecNoAlvo;
  end;

  Result := FDataSet.Fields[AintCol].AsString;
end;

function TImportacaoDadosContabeisFonteDataSet.fQntColunas: Integer;
begin
  pValidaDataset;
  Result := FDataSet.FieldCount;
end;

function TImportacaoDadosContabeisFonteDataSet.fQntLinhas: Integer;
begin
  pValidaDataset;
  Result := FDataSet.RecordCount;
end;

function TImportacaoDadosContabeisFonteDataSet.fTemCabecalho: Boolean;
begin
  Result := False;
end;

class function TImportacaoDadosContabeisFonteDataSet.New(
  ADataSet: TDataSet; AOwnsDataSet: Boolean = False): IImportacaoDadosContabeisFonte;
begin
  Result := Self.Create(ADataSet, AOwnsDataSet);
end;

procedure TImportacaoDadosContabeisFonteDataSet.pValidaDataset;
begin
  if not Assigned(FDataSet) then
    raise EImportacaoDadosContabeis.Create('Erro interno: DataSet da fonte de dados nao foi atribuido.');

  if not FDataSet.Active then
    raise EImportacaoDadosContabeis.Create('Erro interno: DataSet da fonte de dados nao esta aberto.');
end;

end.
