unit untTParametrosGeracaoLanCon;

interface

uses untIContabilidade, Contabilidade.Interfaces;

type
  TParametrosGeracaoLanCon = Class(TInterfacedObject, IParametrosGeracaoLanCon)
  private
    FTipLan: string;
    FIncDoc: string;
    FTabela: string;
    FModLan: integer;
    FIncremento: int64;
    FReenvio: boolean;
    FEmpLan: string;
    FDtaLan: TDateTime;
    FarrIncDoc: TArrIncDoc ;
  public
    function TipLan: string; overload;
    function IncDoc: string; overload;
    function Tabela: string; overload;
    function ModLan: integer; overload;
    function Incremento: int64; overload;
    function Reenvio: boolean; overload;
    function TipLan(const AValue: string): IParametrosGeracaoLanCon; overload;
    function IncDoc(const AValue: string): IParametrosGeracaoLanCon; overload;
    function Tabela(const AValue: string): IParametrosGeracaoLanCon; overload;
    function ModLan(const AValue: integer): IParametrosGeracaoLanCon; overload;
    function Incremento(AValue: int64): IParametrosGeracaoLanCon; overload;
    function Reenvio(AValue: boolean): IParametrosGeracaoLanCon; overload;
    class function New: IParametrosGeracaoLanCon;
    function EmpLan: string; overload ;
    function DtaLan: TDateTime; overload ;
    function EmpLan(const AValue: string): IParametrosGeracaoLanCon; overload;
    function DtaLan(const AValue: TDateTime): IParametrosGeracaoLanCon; overload;
    function ArrIncDoc(const AValue: TArrIncDoc): IParametrosGeracaoLanCon; overload;
    function ArrIncDoc: TArrIncDoc; overload ;
    constructor Create ;
  end;

implementation

{ TParametrosGeracaoLanCon }

function TParametrosGeracaoLanCon.IncDoc: string;
begin
  Result := FIncDoc;
end;

function TParametrosGeracaoLanCon.DtaLan: TDateTime;
begin
  Result := FDtaLan;
end;

function TParametrosGeracaoLanCon.ArrIncDoc(
  const AValue: TArrIncDoc): IParametrosGeracaoLanCon;
begin
  Result := Self ;
  FarrIncDoc := AValue ;
end;

function TParametrosGeracaoLanCon.ArrIncDoc: TArrIncDoc;
begin
  Result := FarrIncDoc ;
end;

constructor TParametrosGeracaoLanCon.Create;
begin
  SetLength(FarrIncDoc, 0);
end;

function TParametrosGeracaoLanCon.DtaLan(
  const AValue: TDateTime): IParametrosGeracaoLanCon;
begin
  Result := Self;
  FDtaLan := AValue;
end;

function TParametrosGeracaoLanCon.EmpLan: string;
begin
  Result := FEmpLan;
end;

function TParametrosGeracaoLanCon.EmpLan(
  const AValue: string): IParametrosGeracaoLanCon;
begin
  Result := Self;
  FEmpLan := AValue;
end;

function TParametrosGeracaoLanCon.IncDoc(
  const AValue: string): IParametrosGeracaoLanCon;
begin
  Result := Self;
  FIncDoc := AValue;
end;

function TParametrosGeracaoLanCon.Incremento: int64;
begin
  Result := FIncremento;
end;

function TParametrosGeracaoLanCon.Incremento(
  AValue: int64): IParametrosGeracaoLanCon;
begin
  Result := Self;
  FIncremento := AValue;
end;

function TParametrosGeracaoLanCon.ModLan: integer;
begin
  Result := FModLan;
end;

function TParametrosGeracaoLanCon.ModLan(
  const AValue: integer): IParametrosGeracaoLanCon;
begin
  Result := Self;
  FModLan := AValue;
end;

class function TParametrosGeracaoLanCon.New: IParametrosGeracaoLanCon;
begin
  Result := Self.Create;
end;

function TParametrosGeracaoLanCon.Reenvio: boolean;
begin
  Result := FReenvio;
end;

function TParametrosGeracaoLanCon.Reenvio(
  AValue: boolean): IParametrosGeracaoLanCon;
begin
  Result := Self;
  FReenvio := AValue;
end;

function TParametrosGeracaoLanCon.Tabela(
  const AValue: string): IParametrosGeracaoLanCon;
begin
  Result := Self;
  FTabela := AValue;
end;

function TParametrosGeracaoLanCon.Tabela: string;
begin
  Result := FTabela;
end;

function TParametrosGeracaoLanCon.TipLan(
  const AValue: string): IParametrosGeracaoLanCon;
begin
  Result := Self;
  FTipLan := AValue;
end;

function TParametrosGeracaoLanCon.TipLan: string;
begin
  Result := FTipLan;
end;

end.
