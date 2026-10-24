unit untParametrosResultadoDifal;


interface

Uses
 Shared.Functions.Types;

  type
    IParametrosResultadoDifal= interface
    ['{7FDDC900-E936-4748-8177-33656D77E91C}']

    function ValorBaseDestino: Double; overload;
    function ValorBaseDestino(AValue: Double): IParametrosResultadoDifal; overload;

    function ValorIcmsDestino: Double; overload;
    function ValorIcmsDestino(AValue: Double): IParametrosResultadoDifal; overload;

    function ValorIcmsOrigem: Double; overload;
    function ValorIcmsOrigem(AValue: Double): IParametrosResultadoDifal; overload;

    function AliquotaInterestadualCalc: Double; overload;
    function AliquotaInterestadualCalc(AValue: Double): IParametrosResultadoDifal; overload;

    function RecordDifalFCP: TRecDifalFCP; overload;
    function RecordDifalFCP(AValue: TRecDifalFCP): IParametrosResultadoDifal; overload;
  end;

  Type
    TParametrosResultadoDifal = Class(TInterfacedObject, IParametrosResultadoDifal)
    Private
      FValorBaseDestino : Double;
      FValorIcmsDestino : Double;
      FValorIcmsOrigem  : Double;
      FRecordDifalFCP   : TRecDifalFCP;
      FAliquotaInterestadualCalc: Double;
    Public
      function ValorBaseDestino: Double; overload;
      function ValorBaseDestino(AValue: Double): IParametrosResultadoDifal; overload;

      function ValorIcmsDestino: Double; overload;
      function ValorIcmsDestino(AValue: Double): IParametrosResultadoDifal; overload;

      function ValorIcmsOrigem: Double; overload;
      function ValorIcmsOrigem(AValue: Double): IParametrosResultadoDifal; overload;

      function AliquotaInterestadualCalc: Double; overload;
      function AliquotaInterestadualCalc(AValue: Double): IParametrosResultadoDifal; overload;

      function RecordDifalFCP: TRecDifalFCP; overload;
      function RecordDifalFCP(AValue: TRecDifalFCP): IParametrosResultadoDifal; overload;

      Class Function New() : IParametrosResultadoDifal;
    End;

  Type
    IParametrosResutladoDifalFCP = Interface

    function AliquotaDifalDoItem: Double; overload;
    function AliquotaDifalDoItem(AValue: Double): IParametrosResutladoDifalFCP; overload;

    function IcmsDeOrigem: Double; overload;
    function IcmsDeOrigem(AValue: Double): IParametrosResutladoDifalFCP; overload;

    function IcmsDeDestino: Double; overload;
    function IcmsDeDestino(AValue: Double): IParametrosResutladoDifalFCP; overload;

    function BaseFCP: Double; overload;
    function BaseFCP(AValue: Double): IParametrosResutladoDifalFCP; overload;

    function ValorFCP: Double; overload;
    function ValorFCP(AValue: Double): IParametrosResutladoDifalFCP; overload;
  End;

  TParametrosResutladoDifalFCP = Class(TInterfacedObject, IParametrosResutladoDifalFCP)
  Private
    FAliquotaDifalDoItem: Double;
    FIcmsDeOrigem       : Double;
    FIcmsDeDestino      : Double;
    FBaseFCP            : Double;
    FValorFCP           : Double;
  Public
    function AliquotaDifalDoItem: Double; overload;
    function AliquotaDifalDoItem(AValue: Double): IParametrosResutladoDifalFCP; overload;

    function IcmsDeOrigem: Double; overload;
    function IcmsDeOrigem(AValue: Double): IParametrosResutladoDifalFCP; overload;

    function IcmsDeDestino: Double; overload;
    function IcmsDeDestino(AValue: Double): IParametrosResutladoDifalFCP; overload;

    function BaseFCP: Double; overload;
    function BaseFCP(AValue: Double): IParametrosResutladoDifalFCP; overload;

    function ValorFCP: Double; overload;
    function ValorFCP(AValue: Double): IParametrosResutladoDifalFCP; overload;

    Class Function New() : IParametrosResutladoDifalFCP;
  End;

implementation

{ TParametrosResultadoDifal }


function TParametrosResultadoDifal.AliquotaInterestadualCalc: Double;
begin
  Result := FAliquotaInterestadualCalc;
end;

function TParametrosResultadoDifal.AliquotaInterestadualCalc(
  AValue: Double): IParametrosResultadoDifal;
begin
  Result := Self;
  FAliquotaInterestadualCalc:= AValue;
end;

class function TParametrosResultadoDifal.New: IParametrosResultadoDifal;
begin
  Result := Self.Create;
end;

function TParametrosResultadoDifal.RecordDifalFCP(
  AValue: TRecDifalFCP): IParametrosResultadoDifal;
begin
  Result := Self;
  FRecordDifalFCP:= AValue;
end;

function TParametrosResultadoDifal.RecordDifalFCP: TRecDifalFCP;
begin
  Result := FRecordDifalFCP;
end;

function TParametrosResultadoDifal.ValorBaseDestino: Double;
begin
  Result := FValorBaseDestino;
end;

function TParametrosResultadoDifal.ValorBaseDestino(
  AValue: Double): IParametrosResultadoDifal;
begin
  Result := Self;
  FValorBaseDestino := AValue;
end;

function TParametrosResultadoDifal.ValorIcmsDestino: Double;
begin
  Result := FValorIcmsDestino;
end;

function TParametrosResultadoDifal.ValorIcmsDestino(
  AValue: Double): IParametrosResultadoDifal;
begin
  Result := Self;
  FValorIcmsDestino := AValue;
end;

function TParametrosResultadoDifal.ValorIcmsOrigem(
  AValue: Double): IParametrosResultadoDifal;
begin
  Result := Self;
  FValorIcmsOrigem := AValue;
end;

function TParametrosResultadoDifal.ValorIcmsOrigem: Double;
begin
  Result := FValorIcmsOrigem;
end;

{ TParametrosResutladoDifalFCP }

function TParametrosResutladoDifalFCP.AliquotaDifalDoItem(
  AValue: Double): IParametrosResutladoDifalFCP;
begin
  Result := Self;
  FAliquotaDifalDoItem := AValue;
end;

function TParametrosResutladoDifalFCP.AliquotaDifalDoItem: Double;
begin
  Result := FAliquotaDifalDoItem;
end;

function TParametrosResutladoDifalFCP.BaseFCP: Double;
begin
  Result := FBaseFCP;
end;

function TParametrosResutladoDifalFCP.BaseFCP(
  AValue: Double): IParametrosResutladoDifalFCP;
begin
  Result := Self;
  FBaseFCP := AValue;
end;

function TParametrosResutladoDifalFCP.IcmsDeDestino(
  AValue: Double): IParametrosResutladoDifalFCP;
begin
  Result := Self;
  FIcmsDeDestino:= AValue;
end;

function TParametrosResutladoDifalFCP.IcmsDeDestino: Double;
begin
  Result := FIcmsDeDestino;
end;

function TParametrosResutladoDifalFCP.IcmsDeOrigem: Double;
begin
  Result := FIcmsDeOrigem;
end;

function TParametrosResutladoDifalFCP.IcmsDeOrigem(
  AValue: Double): IParametrosResutladoDifalFCP;
begin
  Result := Self;
  FIcmsDeOrigem := AValue;
end;

class function TParametrosResutladoDifalFCP.New: IParametrosResutladoDifalFCP;
begin
  Result := Self.Create;
end;

function TParametrosResutladoDifalFCP.ValorFCP(
  AValue: Double): IParametrosResutladoDifalFCP;
begin
  Result := Self;
  FValorFCP := AValue;
end;

function TParametrosResutladoDifalFCP.ValorFCP: Double;
begin
  Result := FValorFCP;
end;

end.

