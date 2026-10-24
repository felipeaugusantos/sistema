unit untFormulaImobiliariaCalamar;

interface

uses
  untIFormulaImobiliaria, untFuncEspecificas, untAbstractFormulaImobiliaria,
  Uni, UniClientDataSet,SysUtils;

type
  TFormulaImobiliariaCalamar = class(TAbstractFormulaImobiliaria, IFormulaImobiliaria)
  private
    class var qryCadCol: TUniQuery;
    function GetQryCadCol: TUniQuery;
  protected
    function GetEmbalagem(objColorante: TColoranteImobiliario): Double; override;
  public
    function GetNomeTabelaBase: string; override;
    function GetNomeTabelaColorante: string; override;
    function GetTextoCalculoValor: string; override;
    function GetNomeCampoColDesCol: string; override;
  end;

implementation
uses untFuncoesSimples;
{ TFormulaImobiliariaCalamar }

function TFormulaImobiliariaCalamar.GetEmbalagem(objColorante: TColoranteImobiliario): Double;
begin
  Result := 1000;
  if GetQryCadCol.Locate('COL_CODCOL', objColorante.strCodCol, []) then
    Result := GetQryCadCol.FieldByName('COL_EMBALA').AsFloat;
end;

function TFormulaImobiliariaCalamar.GetNomeTabelaBase: string;
begin
  Result := 'CAL_CADBAS';
end;

function TFormulaImobiliariaCalamar.GetNomeTabelaColorante: string;
begin
  Result := 'CAL_CADCOL';
end;

function TFormulaImobiliariaCalamar.GetQryCadCol: TUniQuery;
begin
  if not Assigned(qryCadCol) then
  begin
    qryCadCol := fCriaQuery();
    qryCadCol.SQL.Text := 'SELECT * FROM CAL_CADCOL';
    qryCadCol.Open;
  end;

  qryCadCol.Active := True;
  Result := qryCadCol;
end;

function TFormulaImobiliariaCalamar.GetTextoCalculoValor: string;
begin
  Result := 'Valor do Colorante = (Quantidade) * (0,3254) * (Preço / Embalagem)' + #13#10 +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaCalamar.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

initialization
  TFormulaImobiliariaCalamar.qryCadCol := nil;

finalization
  if Assigned(TFormulaImobiliariaCalamar.qryCadCol) then FreeAndNil(TFormulaImobiliariaCalamar.qryCadCol);

end.
