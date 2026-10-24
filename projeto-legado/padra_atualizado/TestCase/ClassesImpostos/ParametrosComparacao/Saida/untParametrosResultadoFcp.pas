unit untParametrosResultadoFcp;

interface

Uses
 Shared.Functions.Types;


type
  IParametrosResultadoFcp = interface
    ['{45B30447-1F13-453A-B58D-2FE108ACF9AB}']

    function BaseDestino: Double; overload;
    function BaseDestino(AValue: Double): IParametrosResultadoFcp; overload;

    function BaseFCP: Double; overload;
    function BaseFCP(AValue: Double): IParametrosResultadoFcp; overload;

    function ValorFCP: Double; overload;
    function ValorFCP(AValue: Double): IParametrosResultadoFcp; overload;

    function AliquotaDoFCPDoItem: Double; overload;
    function AliquotaDoFCPDoItem(AValue: Double): IParametrosResultadoFcp; overload;

    function RecordDifalFCP: TRecDifalFCP; overload;
    function RecordDifalFCP(AValue: TRecDifalFCP): IParametrosResultadoFcp; overload;	
  end;

type
  TParametrosResultadoFcp = class(TInterfacedObject, IParametrosResultadoFcp)
  private
    FBaseDestino: Double;
    FBaseFCP: Double;
    FValorFCP: Double;
    FAliquotaFCPST: Double;
	  FRecordDifalFCP: TRecDifalFCP;
  public
    function BaseDestino: Double; overload;
    function BaseDestino(AValue: Double): IParametrosResultadoFcp; overload;

    function BaseFCP: Double; overload;
    function BaseFCP(AValue: Double): IParametrosResultadoFcp; overload;

    function ValorFCP: Double; overload;
    function ValorFCP(AValue: Double): IParametrosResultadoFcp; overload;

    function AliquotaDoFCPDoItem: Double; overload;
    function AliquotaDoFCPDoItem(AValue: Double): IParametrosResultadoFcp; overload;

    function RecordDifalFCP: TRecDifalFCP; overload;
    function RecordDifalFCP(AValue: TRecDifalFCP): IParametrosResultadoFcp; overload;

    class function New(): IParametrosResultadoFcp;
  end;

implementation

{ TParametrosResultadoFcp }

class function TParametrosResultadoFcp.New: IParametrosResultadoFcp;
begin
  Result := Self.Create;
end;

function TParametrosResultadoFcp.RecordDifalFCP: TRecDifalFCP;
begin
  Result := FRecordDifalFCP;
end;

function TParametrosResultadoFcp.RecordDifalFCP(
  AValue: TRecDifalFCP): IParametrosResultadoFcp;
begin
  Result := Self;
  FRecordDifalFCP := AValue;
end;

function TParametrosResultadoFcp.ValorFCP(
  AValue: Double): IParametrosResultadoFcp;
begin
  Result := Self;
  FValorFCP := AValue;
end;

function TParametrosResultadoFcp.ValorFCP: Double;
begin
  Result := FValorFCP;
end;

function TParametrosResultadoFcp.BaseDestino: Double;
begin
  Result := FBaseDestino;
end;

function TParametrosResultadoFcp.AliquotaDoFCPDoItem: Double;
begin
  Result := FAliquotaFCPST;
end;

function TParametrosResultadoFcp.AliquotaDoFCPDoItem(
  AValue: Double): IParametrosResultadoFcp;
begin
  Result := Self;
  FAliquotaFCPST := AValue;
end;

function TParametrosResultadoFcp.BaseDestino(
  AValue: Double): IParametrosResultadoFcp;
begin
  Result := Self;
  FBaseDestino := AValue;
end;

function TParametrosResultadoFcp.BaseFCP(
  AValue: Double): IParametrosResultadoFcp;
begin
  Result := Self;
  FBaseFCP := AValue;
end;

function TParametrosResultadoFcp.BaseFCP: Double;
begin
  Result := FBaseFCP;
end;

end.
