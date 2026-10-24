unit untGeoSalePedidoSingletonCollection;

interface

Uses System.SysUtils, System.Generics.Collections, untGeoSale_Pedido, untGeoSale_Item_Pedido;

Type
  TPedidoAux = Class
  Strict Private
    FPedido : TGeoSale_Pedido;
    FItens  : TObjectList<TGeoSale_Item_Pedido>;
  Public
    Constructor Create;
    Property objPedido : TGeoSale_Pedido                   Read FPedido;
    Property lstItens  : TObjectList<TGeoSale_Item_Pedido> Read FItens;
  End;


  TGeoSalePedidoSingletonCollection = class
  Strict Private

    FPedido : TObjectDictionary<Integer, TPedidoAux>;

    Class Var FInstance : TGeoSalePedidoSingletonCollection;
    Constructor MakeInstance;
  Public
    Class Function Instance : TGeoSalePedidoSingletonCollection;
    Constructor Create; reintroduce; deprecated;
    Destructor Destroy; Override;

    procedure pAddPedido(objPedido : TGeoSale_Pedido);
    procedure pAddItem(objItem     : TGeoSale_Item_Pedido);

    Property lstPedido : TObjectDictionary<Integer, TPedidoAux> Read FPedido;

  End;


implementation


{ TGeoSalePedidoSingletonCollection }

constructor TGeoSalePedidoSingletonCollection.Create;
begin
  Raise Exception.Create('Utilizar: TGeoSalePedidoSingletonCollection.Instance');
end;

destructor TGeoSalePedidoSingletonCollection.Destroy;
begin
  If Assigned(FInstance) Then
  Begin
    FreeAndNil(FPedido);
    FInstance := nil;
  End;

end;

class function TGeoSalePedidoSingletonCollection.Instance: TGeoSalePedidoSingletonCollection;
begin
  If Not Assigned(FInstance) Then
    FInstance := MakeInstance;
  Result := FInstance;
end;

constructor TGeoSalePedidoSingletonCollection.MakeInstance;
begin
  FPedido := TObjectDictionary<Integer, TPedidoAux>.Create;
end;

procedure TGeoSalePedidoSingletonCollection.pAddItem(objItem: TGeoSale_Item_Pedido);
  Var
    obj : TGeoSale_Item_Pedido;
begin
  If FPedido.ContainsKey(objItem.CD_PEDIDO_PALM) Then
  Begin
    obj := TGeoSale_Item_Pedido.Create('', '');
    obj.Assign( objItem );
    FPedido[objItem.CD_PEDIDO_PALM].lstItens.Add(obj);
  End;

end;

procedure TGeoSalePedidoSingletonCollection.pAddPedido(objPedido: TGeoSale_Pedido);
  Var
    obj : TPedidoAux;
begin
  obj := TPedidoAux.Create;
  obj.objPedido.Assign(objPedido);
  FPedido.Add(obj.objPedido.CD_PEDIDO_PALM, obj );

end;

{ TPedidoAux }

constructor TPedidoAux.Create;
begin
  FPedido := TGeoSale_Pedido.Create('', '');
  FItens  := TObjectList<TGeoSale_Item_Pedido>.Create;
end;

end.
