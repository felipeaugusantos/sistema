unit untGenericSaldosColorantes;

interface

uses
  untISaldosColorantes, untColorante, Classes;

Const
    BASE_AUTOMOTIVA: String = 'BA';
    EMBALAGEM: String = 'E';
    BASE_IMOBILIARIA: String = 'B';
    COLORANTE_IMOBILIARIO: String = 'C';
    CATALISADOR: String = 'CT';

type
  TGenericSaldoColorante = class(TInterfacedObject, ISaldoColorante)
  private
    intIDTinta: Integer;
    strDescTinta: String;
    strCodIte: String;
    strDesIte: String;
    strCodCol: String;
    fltQtdFormula: Double;
//    fltQtdFormOri: Double;
//    fltQtdFormAcu: Double;//Acumulado na Venda
//    fltSaldoML: Double;
    strBasCol: string;
//    strEmpPrd: string;
    strPesGra: String;
    fltEmbala: Double;
//    function GetEmpPrd: string;
  public
    function GetBasCol: string;
    function GetCodCol: string;
    function GetCodIte: string;
    function GetDesIte: string;
    function GetDescTinta: string;
    function GetIDTinta: Integer;
    function GetQtdFormula: Double;
//    function GetQtdFormOri: Double;
//    function GetQtdFormAcu: Double;
//    function GetSaldoML: Double;
//    function GetEmpPrd : string;
    function GetPesGra: String;
    function GetEmbala: Double;
    constructor Create(const intIDTinta: Integer; const strDescTinta,
      strCodIte, strDesIte, strCodCol: String; const fltQtdFormula: Double;
      {const fltQtdFormOri: Double; const fltQtdFormAcu: Double; const fltSaldoML: Double;}
      const strBasCol: string; const strPesGra: String; const fltEmbala: Double); //; const strEmpPrd: string
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
  const fltQtdFormula: Double; //const fltQtdFormOri: Double;
//  const fltQtdFormAcu: Double; const fltSaldoML: Double;
  const strBasCol: string; const strPesGra: String;
  const fltEmbala: Double); //; const strEmpPrd: string
begin
  inherited Create();
  Self.intIDTinta := intIDTinta;
  Self.strDescTinta := strDescTinta;
  Self.strCodIte := strCodIte;
  Self.strDesIte := strDesIte;
  Self.strCodCol := strCodCol;
  Self.fltQtdFormula := fltQtdFormula;
//  Self.fltQtdFormOri := fltQtdFormOri;
//  Self.fltQtdFormAcu := fltQtdFormAcu;
//  Self.fltSaldoML := fltSaldoML;
  Self.strBasCol := strBasCol;
//  Self.strEmpPrd := strEmpPrd;
  Self.strPesGra := strPesGra;
  Self.fltEmbala := fltEmbala;
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

function TGenericSaldoColorante.GetEmbala: Double;
begin
  Result := fltEmbala;
end;

{function TGenericSaldoColorante.GetEmpPrd: string;
begin
  Result := strEmpPrd;
end;}

function TGenericSaldoColorante.GetIDTinta: Integer;
begin
  Result := intIDTinta;
end;

function TGenericSaldoColorante.GetPesGra: String;
begin
  Result := strPesGra;
end;

{function TGenericSaldoColorante.GetQtdFormAcu: Double;
begin
  Result := fltQtdFormAcu;
end;}

{function TGenericSaldoColorante.GetQtdFormOri: Double;
begin
  Result := fltQtdFormOri;
end;}

function TGenericSaldoColorante.GetQtdFormula: Double;
begin
  Result := fltQtdFormula;
end;

{function TGenericSaldoColorante.GetSaldoML: Double;
begin
  Result := fltSaldoML;
end;}

end.
