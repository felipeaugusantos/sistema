unit untFormulaImobiliariaVelutex;

interface

uses
  untIFormulaImobiliaria,  untAbstractFormulaImobiliaria, SysUtils;

type
  TFormulaImobiliariaVelutex = class(TAbstractFormulaImobiliaria, IFormulaImobiliaria)
  public
    function GetNomeTabelaBase: string; override;
    function GetNomeTabelaColorante: string; override;
    function GetNomeCampoColDesCol: string; override;
    function GetTextoCalculoValor: string; override;
  end;

implementation

Uses untFuncEspecificas;

{ TFormulaImobiliariaVelutex }

function TFormulaImobiliariaVelutex.GetNomeTabelaBase: string;
begin
  Result := 'VEL_CADBAS';
end;

function TFormulaImobiliariaVelutex.GetNomeTabelaColorante: string;
begin
  Result := 'VEL_CADCOL';
end;

function TFormulaImobiliariaVelutex.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaVelutex.GetTextoCalculoValor: string;
begin
  Result := 'Valor do Colorante = (Quantidade * 0.154)* (Preço/Embalagem)'+ sLineBreak +
            'Valor da Tinta = Valor da Base + (Soma do Valor dos Colorantes) ';
end;


end.
