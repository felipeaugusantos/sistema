unit untGenericSaldosColorantes;

interface

uses
  untISaldosColorantes, untColorante, Classes;

Const
    BASE_AUTOMOTIVA: String = 'BA';
    EMBALAGEM: String = 'E';
    BASE_IMOBILIARIA: String = 'B';
    COLORANTE_IMOBILIARIO: String = 'C';

type
  TGenericSaldoColorante = class(TInterfacedObject, ISaldoColorante)
  private
    intIDTinta: Integer;
    strDescTinta: String;
    strCodIte: String;
    strDesIte: String;
    strCodCol: String;
    fltQtdFormula: Double;
    strBasCol: string;
  public
    function GetBasCol: string;
    function GetCodCol: string;
    function GetCodIte: string;
    function GetDesIte: string;
    function GetDescTinta: string;
    function GetIDTinta: Integer;
    function GetQtdFormula: Double;
    constructor Create(const intIDTinta: Integer; const strDescTinta,
      strCodIte, strDesIte, strCodCol: String; const fltQtdFormula: Double;
      const strBasCol: string);
  end;

  TGenericSaldosColorantes = class(TInterfacedObject, ISaldosColorantes)
  private
    lstItens: IInterfaceList;
  public
    constructor Create();
    function GetCont: Integer;
    function GetSaldoColorante(const index: Integer): ISaldoColorante;
    procedure Adicionar(const saldoColorante: ISaldoColorante);
  end;

implementation

{ TGenericSaldosColorantes }

procedure TGenericSaldosColorantes.Adicionar(
  const saldoColorante: ISaldoColorante);
begin
  lstItens.Add(saldoColorante);  
end;

constructor TGenericSaldosColorantes.Create();
begin
  inherited Create();
  lstItens := TInterfaceList.Create;
end;

function TGenericSaldosColorantes.GetCont: Integer;
begin
  Result := lstItens.Count;
end;

function TGenericSaldosColorantes.GetSaldoColorante(
  const index: Integer): ISaldoColorante;
begin
  Result := lstItens[index] as ISaldoColorante;
end;

{ TGenericSaldoColorante }

constructor TGenericSaldoColorante.Create(const intIDTinta: Integer;
  const strDescTinta, strCodIte, strDesIte, strCodCol: String;
  const fltQtdFormula: Double; const strBasCol: string);
begin
  inherited Create();
  Self.intIDTinta := intIDTinta;
  Self.strDescTinta := strDescTinta;
  Self.strCodIte := strCodIte;
  Self.strDesIte := strDesIte;
  Self.strCodCol := strCodCol;
  Self.fltQtdFormula := fltQtdFormula;
  Self.strBasCol := strBasCol;
end;

function TGenericSaldoColorante.GetBasCol: string;
begin
  Result := strBasCol;
end;

function TGenericSaldoColorante.GetCodCol: string;
begin
  Result := strCodCol;
end;

function TGenericSaldoColorante.GetCodIte: string;
begin
  Result := strCodIte;
end;

function TGenericSaldoColorante.GetDescTinta: string;
begin
  Result := strDescTinta;
end;

function TGenericSaldoColorante.GetDesIte: string;
begin
  Result := strDesIte;
end;

function TGenericSaldoColorante.GetIDTinta: Integer;
begin
  Result := intIDTinta;
end;

function TGenericSaldoColorante.GetQtdFormula: Double;
begin
  Result := fltQtdFormula;
end;

end.
