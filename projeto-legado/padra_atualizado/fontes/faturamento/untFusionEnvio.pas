unit untFusionEnvio;

interface

uses
  untFusionCliente, untFusionVeiculo, untFusionMotoristaAjudante,
  untFusionEntregaServico, untFusionWS;

  function fEnviar(strLogin, strSenha: String; arrClientes: Array of TFusionCliente): String; overload;
  function fEnviar(strLogin, strSenha: String; objCliente: TFusionCliente): String; overload;
  function fEnviar(strLogin, strSenha: String; objVeiculo: TFusionVeiculo): String; overload;
  function fEnviar(strLogin, strSenha: String; arrVeiculos: Array of TFusionVeiculo): String; overload;
  function fEnviar(strLogin, strSenha: String; objMotorista: TFusionMotoristaAjudante): String; overload;
  function fEnviar(strLogin, strSenha: String; arrMotoristas: Array of TFusionMotoristaAjudante): String; overload;
  function fEnviar(strLogin, strSenha: String; objEntregaServico: TFusionEntregaServico): String; overload;
  function fListarErros(strJson: String): String;
  function fTratarMensagens(strErro: String): String;
  function fTratarRetorno(strJson: String): String;

implementation

uses
  System.JSON, SysUtils, StrUtils;

function fEnviar(strLogin, strSenha: String; arrClientes: Array of TFusionCliente): String; overload;
var
  objCliente: TFusionCliente;
begin
  objCliente := TFusionCliente.Create;

  Result :=
    fListarErros(GetsamplePortType.sendClientes(strLogin, strSenha,
      objCliente.fGerarJson(arrClientes)));

  FreeAndNil(objCliente);
end;

function fEnviar(strLogin, strSenha: String; objCliente: TFusionCliente): String; overload;
begin
  Result :=
    fListarErros(GetsamplePortType.sendClientes(strLogin, strSenha, objCliente.fGerarJson([])));
end;

function fEnviar(strLogin, strSenha: String; objVeiculo: TFusionVeiculo): String; overload;
begin
  Result :=
    fListarErros(GetsamplePortType.sendVeiculos(strLogin, strSenha, objVeiculo.fGerarJson));
end;

function fEnviar(strLogin, strSenha: String; arrVeiculos: Array of TFusionVeiculo): String; overload;
var
  objVeiculo: TFusionVeiculo;
begin
  objVeiculo := TFusionVeiculo.Create;

  try
    Result := fTratarRetorno(GetsamplePortType.sendVeiculos(strLogin, strSenha, objVeiculo.fGerarJson(arrVeiculos)));
  finally
    FreeAndNil(objVeiculo);
  end;
end;

function fEnviar(strLogin, strSenha: String; objMotorista: TFusionMotoristaAjudante): String; overload;
begin
  Result :=
    fListarErros(GetsamplePortType.sendMotoristas(strLogin, strSenha, objMotorista.fGerarJson));
end;

function fEnviar(strLogin, strSenha: String; arrMotoristas: Array of TFusionMotoristaAjudante): String; overload;
var
  objMotorista: TFusionMotoristaAjudante;
begin
  objMotorista := TFusionMotoristaAjudante.Create;

  try
    Result := fTratarRetorno(GetsamplePortType.sendMotoristas(strLogin, strSenha, objMotorista.fGerarJson(arrMotoristas)));
  finally
    FreeAndNil(objMotorista);
  end;
end;

function fEnviar(strLogin, strSenha: String; objEntregaServico: TFusionEntregaServico): String; overload;
begin
  Result :=
    fListarErros(GetsamplePortType.saveEntregaServico(strLogin, strSenha, objEntregaServico.fGerarJson));
end;

function fListarErros(strJson: String): String;
begin
  try
    Result :=
      (TJsonObject.ParseJSONValue(strJson) as TJsonObject).
        GetValue('errors').ToJSON.Replace('[]', '').ToLower;

    if Result <> '' then
      Result := fTratarMensagens(Result);
  except
    on E: Exception do
      Result := fTratarMensagens(E.Message +' - ' +strJson);
  end;
end;

function fTratarMensagens(strErro: String): String;
var
  strErroTratado: String;
begin
  strErroTratado := '';

  if Pos('cep_cliente', strErro) > 0 then
    strErroTratado := strErroTratado +sLineBreak +'CEP do cliente inválido';

  if strErroTratado = '' then
    Result := strErro
  else
    Result := strErroTratado;
end;

function fTratarRetorno(strJson: String): String;
begin
  try
    Result := (TJsonObject.ParseJSONValue(strJson) as TJsonObject).GetValue('success').ToJSON.Replace('[', '').Replace(']', '').ToLower;
  except
    on E: Exception do
      Result := '';
  end;
end;

end.

