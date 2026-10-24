unit untFormulaImobiliariaSayerlack;

interface

uses
  untIFormulaImobiliaria, untFuncEspecificas, untAbstractFormulaImobiliaria;

type
  TFormulaImobiliariaSayerlack = class(TAbstractFormulaImobiliaria, IFormulaImobiliaria)
  protected
    const fltFator: Double = 1;
    function GetEmbalagem(objColorante: TColoranteImobiliario): Double; override;
  public
    function GetNomeTabelaBase: string; override;
    function GetNomeTabelaColorante: string; override;
    function GetCamposAdicionaisCarregarColorantes: string; override;

    function GetCalculoColorantePreCu2(objColorante: TColoranteImobiliario): Double; override;
    function GetCalculoColorantePreCus(objColorante: TColoranteImobiliario): Double; override;
    function GetCalculoColorantePreVen(objColorante: TColoranteImobiliario): Double; override;
    function GetCalculoColoranteDesOpe(objColorante: TColoranteImobiliario): Double; override;
    function GetCalculoColoranteIcmSai(objColorante: TColoranteImobiliario): Double; override;
    function GetCalculoColoranteImpFed(objColorante: TColoranteImobiliario): Double; override;
    function GetCalculoColoranteOutVal(objColorante: TColoranteImobiliario): Double; override;
    function GetCalculoColorantePreMed(objColorante: TColoranteImobiliario): Double; override;
    function GetTextoCalculoValor: string; override;
    function GetNomeCampoColDesCol: string; override;

  end;

implementation

{ TFormulaImobiliariaSayerlack }

function TFormulaImobiliariaSayerlack.GetCalculoColoranteDesOpe(objColorante: TColoranteImobiliario): Double;
begin
  Result := GetCalculoColorantePreVen(objColorante) * objColorante.fltDesOpe / 100;
end;

function TFormulaImobiliariaSayerlack.GetCalculoColoranteIcmSai(objColorante: TColoranteImobiliario): Double;
begin
  Result := GetCalculoColorantePreVen(objColorante) * objColorante.fltIcmSai / 100;
end;

function TFormulaImobiliariaSayerlack.GetCalculoColoranteImpFed(objColorante: TColoranteImobiliario): Double;
begin
  Result := GetCalculoColorantePreVen(objColorante) * objColorante.fltImpFed / 100;
end;

function TFormulaImobiliariaSayerlack.GetCalculoColoranteOutVal(objColorante: TColoranteImobiliario): Double;
begin
  Result := objColorante.fltQtdCol * objColorante.fltOutVal * fltFator / GetEmbalagem(objColorante);
end;

function TFormulaImobiliariaSayerlack.GetCalculoColorantePreCu2(objColorante: TColoranteImobiliario): Double;
begin
  Result := objColorante.fltQtdCol * objColorante.fltPreCu2 * fltFator / GetEmbalagem(objColorante);
end;

function TFormulaImobiliariaSayerlack.GetCalculoColorantePreCus(objColorante: TColoranteImobiliario): Double;
begin
  Result := objColorante.fltQtdCol * objColorante.fltPreCus * fltFator / GetEmbalagem(objColorante);
end;

function TFormulaImobiliariaSayerlack.GetCalculoColorantePreMed(objColorante: TColoranteImobiliario): Double;
begin
  Result := objColorante.fltQtdCol * objColorante.fltPreMed * fltFator / GetEmbalagem(objColorante);
end;

function TFormulaImobiliariaSayerlack.GetCalculoColorantePreVen(objColorante: TColoranteImobiliario): Double;
begin
  Result := objColorante.fltQtdCol * objColorante.fltPreVen * fltFator / GetEmbalagem(objColorante);
end;

function TFormulaImobiliariaSayerlack.GetCamposAdicionaisCarregarColorantes: string;
begin
  Result := 'COL_EMBALA';
end;

function TFormulaImobiliariaSayerlack.GetEmbalagem(objColorante: TColoranteImobiliario): Double;
begin
  Result := objColorante.fltEmbala;
end;

function TFormulaImobiliariaSayerlack.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaSayerlack.GetNomeTabelaBase: string;
begin
  Result := 'SAY_CADBAS';
end;

function TFormulaImobiliariaSayerlack.GetNomeTabelaColorante: string;
begin
  Result := 'SAY_CADCOL';
end;

function TFormulaImobiliariaSayerlack.GetTextoCalculoValor: string;
begin
  Result := 'Valor do Colorante = (Quantidade/384) * 0,029574 * Preço' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

end.
