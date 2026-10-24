unit untFieldFiltros;

interface

Type
  TOpcoesAdicionais = (opcNada, opcDiferente, opcIsNull, opcIsNotNull, opcBetween, opcMaiorQue);

  TFieldFiltros<T> = record
  Private
    FValue: T;
    FOpcAd: TOpcoesAdicionais;

    function GetOpcAd: TOpcoesAdicionais;
    function GetValue: T;

    procedure SetValue(const Value: T);
    procedure SetOpcAd(const Value: TOpcoesAdicionais);
  Public
    constructor Create(Value: T); overload;

    property Opcao: TOpcoesAdicionais read GetOpcAd write SetOpcAd;
    property Value: T                 read GetValue write SetValue;

    class operator Implicit(Value: TOpcoesAdicionais): TFieldFiltros<T>;

    class operator Implicit(Value: T): TFieldFiltros<T>;
    class operator Implicit(Value: TFieldFiltros<T>): T;
  End;


implementation

{ TFieldFiltros<T> }

constructor TFieldFiltros<T>.Create(Value: T);
begin
  FValue := Value;
  FOpcAd := opcNada;
end;

function TFieldFiltros<T>.GetOpcAd: TOpcoesAdicionais;
begin
  Result := FOpcAd;
end;

function TFieldFiltros<T>.GetValue: T;
begin
  Result := FValue;
end;

class operator TFieldFiltros<T>.Implicit(Value: TOpcoesAdicionais): TFieldFiltros<T>;
begin
  Result.FOpcAd := Value;
end;

class operator TFieldFiltros<T>.Implicit(Value: TFieldFiltros<T>): T;
begin
  Result := Value.GetValue;
end;

class operator TFieldFiltros<T>.Implicit(Value: T): TFieldFiltros<T>;
begin
  Result.FValue := Value;
  Result.FOpcAd := opcNada;
end;

procedure TFieldFiltros<T>.SetOpcAd(const Value: TOpcoesAdicionais);
begin
  FOpcAd := Value;
end;

procedure TFieldFiltros<T>.SetValue(const Value: T);
begin
  FValue := Value;
  FOpcAd := opcNada;
end;

end.
