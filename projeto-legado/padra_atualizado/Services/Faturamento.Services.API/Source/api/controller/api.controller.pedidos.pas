unit api.controller.pedidos;

interface

uses
  api.core.common,
  System.SysUtils,
  System.StrUtils,
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Swagger.Commons,
  MVCFramework.Controllers.Register,
  Services.Core.Utils,
  Faturamento.Services.Pedido,
  Faturamento.Services.Pedido.Types;

const
  SWAGGER_USERS_GROUP = 'Pedidos';

type
  [MVCPath('/pedidos')]
  [MVCSwagAuthentication(atJsonWebToken)]
  [MVCRequiresAuthentication]
  TPedidosController = class(TMVCController)
  public
    [MVCPath('/calcularimpostos')]
    [MVCHTTPMethod([httpPOST])]
    [MVCSwagSummary(SWAGGER_USERS_GROUP, 'Calcula os impostos de um pedido.')]
    [MVCSwagParam(plBody, 'entity', 'Pedido', TPedidoBasic)]
    [MVCSwagResponses(HTTP_STATUS.OK, API_MSG_RESPONSE_SUCCESS_200, TPedidoCalculado)]
    [MVCSwagResponses(HTTP_STATUS.Unauthorized, API_MSG_RESPONSE_ERROR_401)]
    procedure CalcularImpostos;
  end;

implementation

procedure TPedidosController.CalcularImpostos;
var
  LPedido: TPedidoBasic;
  LReturn: TPedidoCalculado;
begin
  LPedido := TPedidoBasic.FromJsonstring(Context.Request.Body);
  try
    LReturn := TFatPedidoService.fCalcularPedido(LPedido);
    try
      Self.Render(FormatJson(LReturn.ToJsonString));
    finally
      LReturn.Free;
    end;
  finally
    LPedido.Free;
  end;
end;

initialization
  TControllersRegister.Instance.RegisterController(TPedidosController, API_SERVER_NAME);

end.
