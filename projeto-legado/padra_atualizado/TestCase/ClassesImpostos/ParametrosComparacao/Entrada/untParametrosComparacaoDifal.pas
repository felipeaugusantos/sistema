unit untParametrosComparacaoDifal;


interface

Uses
 Shared.Functions.Types;

  Type
    IParametrosComparacaoDifal= interface
      ['{7FDDC900-E936-4748-8177-33656D77E91C}']
    function TipoOperacao : String; overload;
    function TipoOperacao(AValue: String): IParametrosComparacaoDifal; overload;

    function ValorBaseDestino: Double; overload;
    function ValorBaseDestino(AValue: Double): IParametrosComparacaoDifal; overload;

    function ValorIcmsDestino: Double; overload;
    function ValorIcmsDestino(AValue: Double): IParametrosComparacaoDifal; overload;

    function ValorIcmsOrigem: Double; overload;
    function ValorIcmsOrigem(AValue: Double): IParametrosComparacaoDifal; overload;

    function AliquotaInterestadualCalc: Double; overload;
    function AliquotaInterestadualCalc(AValue: Double): IParametrosComparacaoDifal; overload;

    function RecordDifalFCP: TRecDifalFCP; overload;
    function RecordDifalFCP(AValue: TRecDifalFCP): IParametrosComparacaoDifal; overload;

  end;

  Type
    TParametrosComparacaoDifal = Class(TInterfacedObject, IParametrosComparacaoDifal)
    Private
      FTipoOperacao     : String;
      FValorBaseDestino : Double;
      FValorIcmsDestino : Double;
      FValorIcmsOrigem  : Double;
      FAliquotaInterestadualCalc: Double;
      FRecordDifalFCP : TRecDifalFCP;
    Public
      function TipoOperacao : String; overload;
      function TipoOperacao(AValue: String): IParametrosComparacaoDifal; overload;

      function ValorBaseDestino: Double; overload;
      function ValorBaseDestino(AValue: Double): IParametrosComparacaoDifal; overload;

      function ValorIcmsDestino: Double; overload;
      function ValorIcmsDestino(AValue: Double): IParametrosComparacaoDifal; overload;

      function ValorIcmsOrigem: Double; overload;
      function ValorIcmsOrigem(AValue: Double): IParametrosComparacaoDifal; overload;

      function AliquotaInterestadualCalc: Double; overload;
      function AliquotaInterestadualCalc(AValue: Double): IParametrosComparacaoDifal; overload;

      function RecordDifalFCP: TRecDifalFCP; overload;
      function RecordDifalFCP(AValue: TRecDifalFCP): IParametrosComparacaoDifal; overload;

      Class Function New() : IParametrosComparacaoDifal;
    End;

  Type
    IParametrosComparacaoDifalFCP = Interface

    function TipoOperacao : String; overload;
    function TipoOperacao(AValue: String): IParametrosComparacaoDifalFCP; overload;

    function AliquotaDifalDoItem: Double; overload;
    function AliquotaDifalDoItem(AValue: Double): IParametrosComparacaoDifalFCP; overload;

    function IcmsDeOrigem: Double; overload;
    function IcmsDeOrigem(AValue: Double): IParametrosComparacaoDifalFCP; overload;

    function IcmsDeDestino: Double; overload;
    function IcmsDeDestino(AValue: Double): IParametrosComparacaoDifalFCP; overload;

    function BaseFCP: Double; overload;
    function BaseFCP(AValue: Double): IParametrosComparacaoDifalFCP; overload;

    function ValorFCP: Double; overload;
    function ValorFCP(AValue: Double): IParametrosComparacaoDifalFCP; overload;
  End;

  TParametrosComparacaoDifalFCP = Class(TInterfacedObject, IParametrosComparacaoDifalFCP)
  Private
    FTipoOperacao       : String;
    FAliquotaDifalDoItem: Double;
    FIcmsDeOrigem       : Double;
    FIcmsDeDestino      : Double;
    FBaseFCP            : Double;
    FValorFCP           : Double;
  Public
    function TipoOperacao : String; overload;
    function TipoOperacao(AValue: String): IParametrosComparacaoDifalFCP; overload;

    function AliquotaDifalDoItem: Double; overload;
    function AliquotaDifalDoItem(AValue: Double): IParametrosComparacaoDifalFCP; overload;

    function IcmsDeOrigem: Double; overload;
    function IcmsDeOrigem(AValue: Double): IParametrosComparacaoDifalFCP; overload;

    function IcmsDeDestino: Double; overload;
    function IcmsDeDestino(AValue: Double): IParametrosComparacaoDifalFCP; overload;

    function BaseFCP: Double; overload;
    function BaseFCP(AValue: Double): IParametrosComparacaoDifalFCP; overload;

    function ValorFCP: Double; overload;
    function ValorFCP(AValue: Double): IParametrosComparacaoDifalFCP; overload;

    Class Function New() : IParametrosComparacaoDifalFCP;
  End;

implementation

{ TParametrosComparacaoDifal }


function TParametrosComparacaoDifal.AliquotaInterestadualCalc: Double;
begin
  Result := FAliquotaInterestadualCalc;
end;

function TParametrosComparacaoDifal.AliquotaInterestadualCalc(
  AValue: Double): IParametrosComparacaoDifal;
begin
  Result := Self;
  FAliquotaInterestadualCalc:= AValue;
end;

class function TParametrosComparacaoDifal.New: IParametrosComparacaoDifal;
begin
  Result := Self.Create;
end;

function TParametrosComparacaoDifal.RecordDifalFCP(
  AValue: TRecDifalFCP): IParametrosComparacaoDifal;
begin
  Result := Self;
  FRecordDifalFCP:= AValue;
end;

function TParametrosComparacaoDifal.TipoOperacao: String;
begin
  Result := FTipoOperacao;
end;

function TParametrosComparacaoDifal.TipoOperacao(
  AValue: String): IParametrosComparacaoDifal;
begin
  Result := Self;
  FTipoOperacao := AValue;
end;

function TParametrosComparacaoDifal.RecordDifalFCP: TRecDifalFCP;
begin
  Result := FRecordDifalFCP;
end;

function TParametrosComparacaoDifal.ValorBaseDestino: Double;
begin
  Result := FValorBaseDestino;
end;

function TParametrosComparacaoDifal.ValorBaseDestino(
  AValue: Double): IParametrosComparacaoDifal;
begin
  Result := Self;
  FValorBaseDestino := AValue;
end;

function TParametrosComparacaoDifal.ValorIcmsDestino: Double;
begin
  Result := FValorIcmsDestino;
end;

function TParametrosComparacaoDifal.ValorIcmsDestino(
  AValue: Double): IParametrosComparacaoDifal;
begin
  Result := Self;
  FValorIcmsDestino := AValue;
end;

function TParametrosComparacaoDifal.ValorIcmsOrigem(
  AValue: Double): IParametrosComparacaoDifal;
begin
  Result := Self;
  FValorIcmsOrigem := AValue;
end;

function TParametrosComparacaoDifal.ValorIcmsOrigem: Double;
begin
  Result := FValorIcmsOrigem;
end;

{ TParametrosComparacaoDifalFCP }

function TParametrosComparacaoDifalFCP.AliquotaDifalDoItem(
  AValue: Double): IParametrosComparacaoDifalFCP;
begin
  Result := Self;
  FAliquotaDifalDoItem:= AValue;
end;

function TParametrosComparacaoDifalFCP.AliquotaDifalDoItem: Double;
begin
  Result := FAliquotaDifalDoItem;
end;

function TParametrosComparacaoDifalFCP.BaseFCP: Double;
begin
  Result := FBaseFCP;
end;

function TParametrosComparacaoDifalFCP.BaseFCP(
  AValue: Double): IParametrosComparacaoDifalFCP;
begin
  Result := Self;
  FBaseFCP:= AValue;
end;

function TParametrosComparacaoDifalFCP.IcmsDeDestino(
  AValue: Double): IParametrosComparacaoDifalFCP;
begin
  Result := Self;
  FIcmsDeDestino := AValue;
end;

function TParametrosComparacaoDifalFCP.IcmsDeDestino: Double;
begin
  Result := FIcmsDeDestino;
end;

function TParametrosComparacaoDifalFCP.IcmsDeOrigem: Double;
begin
  Result := FIcmsDeOrigem;
end;

function TParametrosComparacaoDifalFCP.IcmsDeOrigem(
  AValue: Double): IParametrosComparacaoDifalFCP;
begin
  Result := Self;
  FIcmsDeOrigem := AValue;
end;

class function TParametrosComparacaoDifalFCP.New: IParametrosComparacaoDifalFCP;
begin
  Result := Self.Create;
end;

function TParametrosComparacaoDifalFCP.TipoOperacao: String;
begin
  Result := FTipoOperacao;
end;

function TParametrosComparacaoDifalFCP.TipoOperacao(
  AValue: String): IParametrosComparacaoDifalFCP;
begin
  Result := Self;
  FTipoOperacao := AValue;
end;

function TParametrosComparacaoDifalFCP.ValorFCP(
  AValue: Double): IParametrosComparacaoDifalFCP;
begin
  Result := Self;
  FValorFCP := AValue;
end;

function TParametrosComparacaoDifalFCP.ValorFCP: Double;
begin
  Result := FValorFCP;
end;

end.

