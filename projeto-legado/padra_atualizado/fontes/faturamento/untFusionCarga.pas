unit untFusionCarga;

interface

uses
  System.Generics.Collections, REST.Json.Types;

type
  TFusionPedidosCarga = class
  private
  public
    id: String;
    [JSonName('filial')]
    filial: String;
  end;

type
  TFusionCarga = class
  private
  public
    codigo_erp: string;
    dt_cancel: string;
    [JSonName('pedidos')]
    arrPedidos: array of TFusionPedidosCarga;

    destructor Destroy; override;

    function fGerarJson: String;
  end;

implementation

uses
  REST.JSON, System.JSON;

{ TFusionCarga }

destructor TFusionCarga.Destroy;
var
  LobjPedido: TFusionPedidosCarga;
begin
  for LobjPedido in Self.arrPedidos do
    LobjPedido.Free;
end;

function TFusionCarga.fGerarJson(): String;
begin
  Result := '[' + TJson.ObjectToJsonString(Self) + ']';
end;

end.

