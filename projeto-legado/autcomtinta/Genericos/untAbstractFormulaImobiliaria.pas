unit untAbstractFormulaImobiliaria;

interface

uses
  untIFormulaImobiliaria, untFuncEspecificas;

type
  TAbstractFormulaImobiliaria = class abstract (TInterfacedObject, IFormulaImobiliaria)
  protected
    function GetEmbalagem(objColorante: TColoranteImobiliario): Double; virtual;
  public
    function GetCalculoColorantePreCu2(objColorante: TColoranteImobiliario): Double; virtual;
    function GetCalculoColorantePreCus(objColorante: TColoranteImobiliario): Double; virtual;
    function GetCalculoColorantePreVen(objColorante: TColoranteImobiliario): Double; virtual;
    function GetCalculoColoranteDesOpe(objColorante: TColoranteImobiliario): Double; virtual;
    function GetCalculoColoranteIcmSai(objColorante: TColoranteImobiliario): Double; virtual;
    function GetCalculoColoranteImpFed(objColorante: TColoranteImobiliario): Double; virtual;
    function GetCalculoColoranteOutVal(objColorante: TColoranteImobiliario): Double; virtual;
    function GetCalculoColorantePreMed(objColorante: TColoranteImobiliario): Double; virtual;
    function GetNomeTabelaBase: string; virtual; abstract;
    function GetNomeTabelaColorante: string; virtual; abstract;
    function GetTextoCalculoValor: string; virtual;
    function GetCamposAdicionaisCarregarColorantes: string; virtual;
    function GetNomeCampoBaseCusto(): string; virtual;
    function GetNomeCampoBaseVenda(): string; virtual;
    function GetNomeCampoColoranteCusto(): string; virtual; 
    function GetNomeCampoColoranteVenda(): string; virtual;
    function GetCalculoColoranteImpUlt(objColorante: TColoranteImobiliario): Double; virtual;
    function GetCalculoColorantePreUlt(objColorante: TColoranteImobiliario): Double; virtual;    
    function GetCalculoColoranteComLiq(objColorante: TColoranteImobiliario): Double; virtual;
    function GetNomeCampoColDesCol: string; virtual; abstract;
  end;

implementation

{ TAbstractFormulaImobiliaria }

function TAbstractFormulaImobiliaria.GetCalculoColoranteComLiq(
  objColorante: TColoranteImobiliario): Double;
begin
  Result := objColorante.fltQtdCol * objColorante.fltComLiq / GetEmbalagem(objColorante);
end;

function TAbstractFormulaImobiliaria.GetCalculoColoranteDesOpe(objColorante: TColoranteImobiliario): Double;
begin
  Result := (objColorante.fltQtdCol * objColorante.fltPreVen / GetEmbalagem(objColorante)) * objColorante.fltDesOpe / 100;
end;

function TAbstractFormulaImobiliaria.GetCalculoColoranteIcmSai(objColorante: TColoranteImobiliario): Double;
begin
  Result := (objColorante.fltQtdCol * objColorante.fltPreVen / GetEmbalagem(objColorante)) * objColorante.fltIcmSai / 100;
end;

function TAbstractFormulaImobiliaria.GetCalculoColoranteImpFed(objColorante: TColoranteImobiliario): Double;
begin
  Result := (objColorante.fltQtdCol * objColorante.fltPreVen / GetEmbalagem(objColorante)) * objColorante.fltImpFed / 100;
end;

function TAbstractFormulaImobiliaria.GetCalculoColoranteOutVal(objColorante: TColoranteImobiliario): Double;
begin
  Result := objColorante.fltQtdCol * objColorante.fltOutVal / GetEmbalagem(objColorante);
end;

function TAbstractFormulaImobiliaria.GetCalculoColorantePreCu2(objColorante: TColoranteImobiliario): Double;
begin
  Result := objColorante.fltQtdCol * objColorante.fltPreCu2 / GetEmbalagem(objColorante);
end;

function TAbstractFormulaImobiliaria.GetCalculoColorantePreCus(objColorante: TColoranteImobiliario): Double;
begin
  Result := objColorante.fltQtdCol * objColorante.fltPreCus / GetEmbalagem(objColorante);
end;

function TAbstractFormulaImobiliaria.GetCalculoColorantePreMed(objColorante: TColoranteImobiliario): Double;
begin
  Result := objColorante.fltQtdCol * objColorante.fltPreMed / GetEmbalagem(objColorante);
end;

function TAbstractFormulaImobiliaria.GetCalculoColorantePreVen(objColorante: TColoranteImobiliario): Double;
begin
  Result := objColorante.fltQtdCol * objColorante.fltPreVen / GetEmbalagem(objColorante);
end;

function TAbstractFormulaImobiliaria.GetCamposAdicionaisCarregarColorantes: string;
begin
  Result := '';
end;

function TAbstractFormulaImobiliaria.GetEmbalagem(objColorante: TColoranteImobiliario): Double;
begin
  Result := 1000;
end;

function TAbstractFormulaImobiliaria.GetNomeCampoBaseCusto: string;
begin
  Result := 'BAS_PRECUS';
end;

function TAbstractFormulaImobiliaria.GetNomeCampoBaseVenda: string;
begin
  Result := 'BAS_PREVEN';
end;

function TAbstractFormulaImobiliaria.GetNomeCampoColoranteCusto: string;
begin
  Result := 'COL_PRECUS';
end;

function TAbstractFormulaImobiliaria.GetNomeCampoColoranteVenda: string;
begin
  Result := 'COL_PREVEN';
end;

function TAbstractFormulaImobiliaria.GetTextoCalculoValor: string;
begin
  Result := 'Valor do Colorante = (Quantidade) * (Preço / Embalagem)' + #13#10 +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TAbstractFormulaImobiliaria.GetCalculoColoranteImpUlt(objColorante: TColoranteImobiliario): Double;
begin
  Result := objColorante.fltQtdCol * objColorante.fltImpUlt / GetEmbalagem(objColorante);
end;

function TAbstractFormulaImobiliaria.GetCalculoColorantePreUlt(objColorante: TColoranteImobiliario): Double;
begin
  Result := objColorante.fltQtdCol * objColorante.fltPreUlt / GetEmbalagem(objColorante);
end;

end.

