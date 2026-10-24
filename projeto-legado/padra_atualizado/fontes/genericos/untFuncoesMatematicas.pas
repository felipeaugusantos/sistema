unit untFuncoesMatematicas;

interface

function fValorMaior(const A, B: Extended): Boolean; overload;
function fValorMaior(const A, B: Double): Boolean; overload;
function fValorMaior(const A, B: Single): Boolean; overload;
function fValorMaior(const A, B: Integer): Boolean; overload;
function fValorMaior(const A, B: Int64): Boolean; overload;
function fValorMaior(const A, B: UInt64): Boolean; overload;

function fValorMenor(const A, B: Extended): Boolean; overload;
function fValorMenor(const A, B: Double): Boolean; overload;
function fValorMenor(const A, B: Single): Boolean; overload;
function fValorMenor(const A, B: Integer): Boolean; overload;
function fValorMenor(const A, B: Int64): Boolean; overload;
function fValorMenor(const A, B: UInt64): Boolean; overload;

implementation

uses
  System.Math, System.Types;

function fValorMaior(const A, B: Extended): Boolean;
begin
  Result := (CompareValue(A, B) = GreaterThanValue);
end;

function fValorMaior(const A, B: Double): Boolean;
begin
  Result := (CompareValue(A, B) = GreaterThanValue);
end;

function fValorMaior(const A, B: Single): Boolean;
begin
  Result := (CompareValue(A, B) = GreaterThanValue);
end;

function fValorMaior(const A, B: Integer): Boolean;
begin
  Result := (CompareValue(A, B) = GreaterThanValue);
end;

function fValorMaior(const A, B: Int64): Boolean;
begin
  Result := (CompareValue(A, B) = GreaterThanValue);
end;

function fValorMaior(const A, B: UInt64): Boolean;
begin
  Result := (CompareValue(A, B) = GreaterThanValue);
end;

function fValorMenor(const A, B: Extended): Boolean;
begin
  Result := (CompareValue(A, B) = LessThanValue);
end;

function fValorMenor(const A, B: Double): Boolean;
begin
  Result := (CompareValue(A, B) = LessThanValue);
end;

function fValorMenor(const A, B: Single): Boolean;
begin
  Result := (CompareValue(A, B) = LessThanValue);
end;

function fValorMenor(const A, B: Integer): Boolean;
begin
  Result := (CompareValue(A, B) = LessThanValue);
end;

function fValorMenor(const A, B: Int64): Boolean;
begin
  Result := (CompareValue(A, B) = LessThanValue);
end;

function fValorMenor(const A, B: UInt64): Boolean;
begin
  Result := (CompareValue(A, B) = LessThanValue);
end;

end.
