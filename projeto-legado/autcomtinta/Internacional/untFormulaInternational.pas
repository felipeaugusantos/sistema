unit untFormulaInternational;

interface

uses
  untIFormulaImobiliaria, untFuncEspecificas, untAbstractFormulaImobiliaria,
  Uni, UniClientDataSet,  SysUtils;

type
  TFormulaInternational = class(TAbstractFormulaImobiliaria, IFormulaImobiliaria)
  private
    class var qryCadCol: TUniQuery;
    function GetQryCadCol: TUniQuery;
  protected
    function GetEmbalagem(objColorante: TColoranteImobiliario): Double; override;
  public
    function GetNomeTabelaBase: string; override;
    function GetNomeTabelaColorante: string; override;
    function GetNomeCampoColDesCol: string; override;
  end;

implementation
uses untFuncoesSimples;
{ TFormulaImobiliariaVelutex }

function TFormulaInternational.GetEmbalagem(objColorante: TColoranteImobiliario): Double;
begin
  Result := 1000;
  if GetQryCadCol.Locate('COL_CODCOL', objColorante.strCodCol, []) then
    Result := GetQryCadCol.FieldByName('COL_EMBALA').AsFloat;
end;

function TFormulaInternational.GetNomeTabelaBase: string;
begin
  Result := 'INT_CADBAS';
end;

function TFormulaInternational.GetNomeTabelaColorante: string;
begin
  Result := 'INT_CADCOL';
end;

function TFormulaInternational.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCOL';
end;

function TFormulaInternational.GetQryCadCol: TUniQuery;
begin
  if not Assigned(qryCadCol) then
  begin
    qryCadCol := fCriaQuery();
    qryCadCol.SQL.Text := 'SELECT * FROM INT_CADCOL';
    qryCadCol.Open;
  end;

  qryCadCol.Active := True;
  Result := qryCadCol;
end;

initialization
  TFormulaInternational.qryCadCol := nil;

finalization
  if Assigned(TFormulaInternational.qryCadCol) then FreeAndNil(TFormulaInternational.qryCadCol);


end.
