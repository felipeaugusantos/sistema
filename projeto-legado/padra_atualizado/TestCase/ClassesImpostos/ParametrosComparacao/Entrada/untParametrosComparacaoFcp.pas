unit untParametrosComparacaoFcp;


interface

Uses
 Shared.Functions.Types;

  Type
    IParametrosComparacaoFcp = interface
      ['{7FDDC900-E936-4748-8177-33656D77E91C}']
	  function BaseDestino: Double; overload;
	  function BaseDestino(AValue: Double): IParametrosComparacaoFcp; overload;

	  function BaseFCP: Double; overload;
	  function BaseFCP(AValue: Double): IParametrosComparacaoFcp; overload;

	  function ValorFCP: Double; overload;
	  function ValorFCP(AValue: Double): IParametrosComparacaoFcp; overload;

	  function AliquotaDoFCPDoItem: Double; overload;
	  function AliquotaDoFCPDoItem(AValue: Double): IParametrosComparacaoFcp; overload;

	  function RecordDifalFCP: TRecDifalFCP; overload;
	  function RecordDifalFCP(AValue: TRecDifalFCP): IParametrosComparacaoFcp; overload;	  
  end;

  Type
    TParametrosComparacaoFcp = Class(TInterfacedObject, IParametrosComparacaoFcp)
    Private
	    FBaseDestino: Double;
	    FBaseFCP: Double;
	    FValorFCP: Double;
	    FAliquotaFCPST: Double;
	    FRecordDifalFCP: TRecDifalFCP;
    Public
	    function BaseDestino: Double; overload;
	    function BaseDestino(AValue: Double): IParametrosComparacaoFcp; overload;

	    function BaseFCP: Double; overload;
	    function BaseFCP(AValue: Double): IParametrosComparacaoFcp; overload;

	    function ValorFCP: Double; overload;
	    function ValorFCP(AValue: Double): IParametrosComparacaoFcp; overload;

	    function AliquotaDoFCPDoItem: Double; overload;
	    function AliquotaDoFCPDoItem(AValue: Double): IParametrosComparacaoFcp; overload;

	    function RecordDifalFCP: TRecDifalFCP; overload;
	    function RecordDifalFCP(AValue: TRecDifalFCP): IParametrosComparacaoFcp; overload;

      Class Function New() : IParametrosComparacaoFcp;
    End;


implementation

{ TParametrosComparacaoFcp }

function TParametrosComparacaoFcp.AliquotaDoFCPDoItem(
  AValue: Double): IParametrosComparacaoFcp;
begin
  Result := Self;
  FAliquotaFCPST := AValue;
end;

function TParametrosComparacaoFcp.AliquotaDoFCPDoItem: Double;
begin
  Result := FAliquotaFCPST;
end;

function TParametrosComparacaoFcp.BaseDestino(
  AValue: Double): IParametrosComparacaoFcp;
begin
  Result := Self;
  FBaseDestino := AValue;
end;

function TParametrosComparacaoFcp.BaseDestino: Double;
begin
  Result := FBaseDestino;
end;

function TParametrosComparacaoFcp.BaseFCP(
  AValue: Double): IParametrosComparacaoFcp;
begin
  Result := Self;
  FBaseFCP := AValue;
end;

function TParametrosComparacaoFcp.BaseFCP: Double;
begin
  Result := FBaseFCP;
end;

class function TParametrosComparacaoFcp.New: IParametrosComparacaoFcp;
begin
  Result := Self.Create;
end;

function TParametrosComparacaoFcp.RecordDifalFCP: TRecDifalFCP;
begin
  Result := FRecordDifalFCP;
end;

function TParametrosComparacaoFcp.RecordDifalFCP(
  AValue: TRecDifalFCP): IParametrosComparacaoFcp;
begin
  Result := Self;
  FRecordDifalFCP := AValue;
end;

function TParametrosComparacaoFcp.ValorFCP(
  AValue: Double): IParametrosComparacaoFcp;
begin
  Result := Self;
  FValorFCP := AValue;
end;

function TParametrosComparacaoFcp.ValorFCP: Double;
begin
  Result := FValorFCP;
end;

end.

