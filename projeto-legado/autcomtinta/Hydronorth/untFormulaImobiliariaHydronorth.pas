unit untFormulaImobiliariaHydronorth;

interface

uses
  untIFormulaImobiliaria, untFuncEspecificas, untAbstractFormulaImobiliaria,
  Uni, UniClientDataSet,  SysUtils;

type
  TFormulaImobiliariaHydronorth = class(TAbstractFormulaImobiliaria, IFormulaImobiliaria)
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

function TFormulaImobiliariaHydronorth.GetEmbalagem(objColorante: TColoranteImobiliario): Double;
begin
  Result := 1000;
  if GetQryCadCol.Locate('COL_CODCOL', objColorante.strCodCol, []) then
    Result := GetQryCadCol.FieldByName('COL_EMBALA').AsFloat;
end;

function TFormulaImobiliariaHydronorth.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaHydronorth.GetNomeTabelaBase: string;
begin
  Result := 'HYD_CADBAS';
end;

function TFormulaImobiliariaHydronorth.GetNomeTabelaColorante: string;
begin
  Result := 'HYD_CADCOL';
end;

function TFormulaImobiliariaHydronorth.GetQryCadCol: TUniQuery;
begin
  if not Assigned(qryCadCol) then
  begin
    qryCadCol := fCriaQuery();
    qryCadCol.SQL.Text := 'SELECT * FROM HYD_CADCOL';
    qryCadCol.Open;
  end;

  qryCadCol.Active := True;
  Result := qryCadCol;
end;

initialization
  TFormulaImobiliariaHydronorth.qryCadCol := nil;

finalization
  if Assigned(TFormulaImobiliariaHydronorth.qryCadCol) then FreeAndNil(TFormulaImobiliariaHydronorth.qryCadCol);


end.
