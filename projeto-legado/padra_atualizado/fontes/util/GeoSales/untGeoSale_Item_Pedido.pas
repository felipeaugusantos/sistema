unit untGeoSale_Item_Pedido;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Importar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Item_Pedido = Class(TGeoSale_Base)
  Private
    FCD_PRODUTO: Integer;
    FVR_ITEM_ORIGINAL: Double;
    FCD_PEDIDO_PALM: Int64;
    FVR_ITEM_MOEDA_ESTRANGEIRA: Double;
    FPC_DESCONTO: Double;
    FVR_ITEM: Double;
    FQT_ITEM: Double;
    procedure setPC_DESCONTO(const Value: Double);
    procedure setVR_ITEM_MOEDA_ESTRANGEIRA(const Value: Double);
  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    Property CD_PEDIDO_PALM             : Int64     Read FCD_PEDIDO_PALM              Write FCD_PEDIDO_PALM;
    Property CD_PRODUTO                 : Integer   Read FCD_PRODUTO                  Write FCD_PRODUTO;
    Property QT_ITEM                    : Double    Read FQT_ITEM                     Write FQT_ITEM;
    Property VR_ITEM                    : Double    Read FVR_ITEM                     Write FVR_ITEM;
    Property VR_ITEM_ORIGINAL           : Double    Read FVR_ITEM_ORIGINAL            Write FVR_ITEM_ORIGINAL;
    Property PC_DESCONTO                : Double    Read FPC_DESCONTO                 Write setPC_DESCONTO;

    Property VR_ITEM_MOEDA_ESTRANGEIRA  : Double    Read FVR_ITEM_MOEDA_ESTRANGEIRA   Write setVR_ITEM_MOEDA_ESTRANGEIRA;
  End;

implementation

{ TGeoSale_Item_Pedido }

uses untFuncoesSimples, untGeoSalePedidoSingletonCollection;

function TGeoSale_Item_Pedido.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + VS_strCodEmp + 'I.TXT';
end;

function TGeoSale_Item_Pedido.fGetSql: String;
begin
  Result := '';

end;

procedure TGeoSale_Item_Pedido.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

procedure TGeoSale_Item_Pedido.setPC_DESCONTO(const Value: Double);
begin
  FPC_DESCONTO := Value;

  If FNomDir <> '' Then
    TGeoSalePedidoSingletonCollection.Instance.pAddItem( Self );

end;

procedure TGeoSale_Item_Pedido.setVR_ITEM_MOEDA_ESTRANGEIRA(
  const Value: Double);
begin
  FVR_ITEM_MOEDA_ESTRANGEIRA := Value;
end;

end.
