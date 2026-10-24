unit untFusionIntegWS;

interface

uses
  System.JSON, SysUtils, StrUtils,untFusionVeiculo, untFusionMotoristaAjudante,
  untFusionEntregaServico, untFusionRomaneio, untFusionCarga, untFusionWS, untConstantes, untFusionAtualizaCarga,

  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'}
  {$ELSE }
    Uni,
    untFuncoesSimples
  {$ENDIF LINUX};

type
  IFusionInteg = interface
    ['{6A3A8F63-730E-46BA-B1CC-37147D519199}']
    function fEnviar(AarrVeiculos: Array of TFusionVeiculo): IFusionInteg; overload;
    function fEnviar(AarrMotoristas: Array of TFusionMotoristaAjudante): IFusionInteg; overload;
    function fEnviar(AarrPedidos: Array of TFusionEntregaServico): IFusionInteg; overload;
    function fGetRomaneio: IFusionInteg;
    function fGetRomaneioFilial(const AFilial: String): IFusionInteg;
    function fSetRomaneioImportado(ACodigoInt, ACarga, ARetorno, AAtualizar: String): IFusionInteg;
    function fSetRomaneioImportadoFilial(ACodigoInt, ACarga, ARetorno, AFilial: String): IFusionInteg;
    function fCancelarCarga(ACarga: TFusionCarga): IFusionInteg;
    function fAtualizaCarga(ACarga: TFusionAtualizaCarga): IFusionInteg;
    function pCarregaRetorno(var AarrFusionRomaneio: TArray<TFusionRomaneio>): IFusionInteg;
    function fRetornoSucesso: String;
  end;

  TFusionIntegWS = class sealed(TInterfacedObject, IFusionInteg)
  private
    FLogin: String;
    FPassword: String;
    FUrl: String;
    FRetorno: String;

    function fTratarRetornoSucesso: String;
    procedure pGravaLog(strRecurs, strParame, strResult: String);
  protected
    constructor Create;
  public
    function fEnviar(AarrVeiculos: Array of TFusionVeiculo): IFusionInteg; overload;
    function fEnviar(AarrMotoristas: Array of TFusionMotoristaAjudante): IFusionInteg; overload;
    function fEnviar(AarrPedidos: Array of TFusionEntregaServico): IFusionInteg; overload;
    function fGetRomaneio: IFusionInteg;
    function fGetRomaneioFilial(const AFilial: String): IFusionInteg;
    function fSetRomaneioImportado(ACodigoInt, ACarga, ARetorno, AAtualizar: String): IFusionInteg;
    function fSetRomaneioImportadoFilial(ACodigoInt, ACarga, ARetorno, AFilial: String): IFusionInteg;
    function fCancelarCarga(ACarga: TFusionCarga): IFusionInteg;
    function fAtualizaCarga(ACarga: TFusionAtualizaCarga): IFusionInteg;
    function pCarregaRetorno(var AarrFusionRomaneio: TArray<TFusionRomaneio>): IFusionInteg;
    function fRetornoSucesso: String;

    class function New: IFusionInteg;
  end;

implementation

{ TFusionIntegWS }

constructor TFusionIntegWS.Create;
begin
  FLogin := fCfgSis('FUSUSR', varString);
  FPassword := fCfgSis('FUSSEN', varString);
  FUrl := '';

  if (fCfgSis('FUSHOM', varBoolean)) then
    FUrl := 'https://homologacao.fusiondms.com.br/sandbox/clientws/clientws.php';
end;

function TFusionIntegWS.fEnviar(AarrMotoristas: array of TFusionMotoristaAjudante): IFusionInteg;
var
  LobjMotorista: TFusionMotoristaAjudante;
begin
  Result := Self;
  LobjMotorista := TFusionMotoristaAjudante.Create;

  try
    FRetorno := GetsamplePortType(False, FUrl).sendMotoristas(FLogin, FPassword, LobjMotorista.fGerarJson(AarrMotoristas));

    pGravaLog('sendMotoristas', LobjMotorista.fGerarJson(AarrMotoristas), FRetorno);
  finally
    FreeAndNil(LobjMotorista);
  end;
end;

function TFusionIntegWS.fEnviar(AarrVeiculos: array of TFusionVeiculo): IFusionInteg;
var
  LobjVeiculo: TFusionVeiculo;
begin
  Result := Self;
  LobjVeiculo := TFusionVeiculo.Create;

  try
    FRetorno := GetsamplePortType(False, FUrl).sendVeiculos(FLogin, FPassword, LobjVeiculo.fGerarJson(AarrVeiculos));

    pGravaLog('sendVeiculos', LobjVeiculo.fGerarJson(AarrVeiculos), FRetorno);
  finally
    FreeAndNil(LobjVeiculo);
  end;
end;

function TFusionIntegWS.fRetornoSucesso: String;
begin
  Result := fTratarRetornoSucesso;
end;

function TFusionIntegWS.fSetRomaneioImportado(ACodigoInt, ACarga, ARetorno, AAtualizar: String): IFusionInteg;
begin
  FRetorno := GetsamplePortType(False, FUrl).setIntErp(FLogin, FPassword, ACodigoInt, ARetorno, ACarga, '', AAtualizar);

  pGravaLog('setIntErp', (ACodigoInt +';'+ ARetorno +';'+ ACarga +';'+ AAtualizar), FRetorno);
end;

function TFusionIntegWS.fSetRomaneioImportadoFilial(ACodigoInt, ACarga,
  ARetorno, AFilial: String): IFusionInteg;
begin
  FRetorno := GetsamplePortType(False, FUrl).setIntErpFiliais(FLogin, FPassword, ACodigoInt, ARetorno, ACarga, AFilial);

  pGravaLog('setIntErpFiliais', (ACodigoInt +';'+ ARetorno +';'+ ACarga +';'+ AFilial), FRetorno);
end;

function TFusionIntegWS.fTratarRetornoSucesso: String;
begin
  try
    Result := (TJsonObject.ParseJSONValue(FRetorno) as TJsonObject)
              .GetValue('success')
              .ToJSON.Replace('[', '')
              .Replace(']', '')
              .ToLower;
  except
    on E: Exception do
      Result := '';
  end;
end;

class function TFusionIntegWS.New: IFusionInteg;
begin
  Result := TFusionIntegWS.Create;
end;

function TFusionIntegWS.pCarregaRetorno(var AarrFusionRomaneio: TArray<TFusionRomaneio>): IFusionInteg;
var
  LobjRomaneio: TFusionRomaneio;
begin
  Result := Self;

  LobjRomaneio := TFusionRomaneio.Create;

  try
    LobjRomaneio.pJsonToObject(FRetorno, AarrFusionRomaneio);
  finally
    FreeAndNil(LobjRomaneio);
  end;
end;

function TFusionIntegWS.fAtualizaCarga(ACarga: TFusionAtualizaCarga): IFusionInteg;
begin
  Result := Self;

  FRetorno := GetsamplePortType(False, FUrl).atualizaCarga(FLogin, FPassword, ACarga.ToJsonString);

  pGravaLog('atualizaCarga', ACarga.ToJsonString, FRetorno);
end;

function TFusionIntegWS.fCancelarCarga(ACarga: TFusionCarga): IFusionInteg;
var
  LimpaCargaDaEntrega: String;
begin
  Result := Self;
  LimpaCargaDaEntrega := 'S';

  FRetorno := GetsamplePortType(False, FUrl).cancelaCarga(FLogin, FPassword, ACarga.fGerarJson, LimpaCargaDaEntrega);

  pGravaLog('cancelaCarga', ACarga.fGerarJson +';'+ LimpaCargaDaEntrega, FRetorno);
end;

function TFusionIntegWS.fEnviar(AarrPedidos: array of TFusionEntregaServico): IFusionInteg;
var
  LobjEntregaServico: TFusionEntregaServico;
begin
  Result := Self;
  LobjEntregaServico := TFusionEntregaServico.Create;

  try
    FRetorno := GetsamplePortType(False, FUrl).saveEntregaServico(FLogin, FPassword, LobjEntregaServico.fGerarJson(AarrPedidos));

    pGravaLog('saveEntregaServico', LobjEntregaServico.fGerarJson(AarrPedidos), FRetorno);
  finally
    FreeAndNil(LobjEntregaServico);
  end;
end;

function TFusionIntegWS.fGetRomaneio: IFusionInteg;
var
  limite_padrao: String;
begin
  Result := Self;
  limite_padrao := '10';

  FRetorno := GetSamplePortType(False, FUrl).getIntErp(FLogin, FPassword, limite_padrao);

  pGravaLog('getIntErp', limite_padrao, FRetorno);
end;

function TFusionIntegWS.fGetRomaneioFilial(const AFilial: String): IFusionInteg;
var
  limite_padrao: String;
begin
  Result := Self;
  limite_padrao := '10';

  FRetorno := GetSamplePortType(False, FUrl).getIntErpFilial(FLogin, FPassword, AFilial, limite_padrao);

  pGravaLog('getIntErpFilial', limite_padrao, FRetorno);
end;

procedure TFusionIntegWS.pGravaLog(strRecurs, strParame, strResult: String);
const
  API = 'FUSION';
var
  qryLogAPI: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
 {$IFNDEF LINUX}
  pValidaProCod('LOGAPI');
 {$ENDIF LINUX};

  qryLogAPI := fCriaQuery;
  try
    qryLogAPI.Close;
    qryLogAPI.SQL.Clear;
    qryLogAPI.SQL.Text :=
    STR_SQL_NAO_REPLICAR+
    ' INSERT INTO '+
    '   LOGAPI '+
    '  (AUTOINCREM, '+
    '   LOG_DTAENT, '+
    '   LOG_HORENT, '+
    '   LOG_RECURS, '+
    '   LOG_PARAME, '+
    '   LOG_RESULT, '+
    '   LOG_LOGAPI) '+
    ' VALUES '+
    '  (:AUTINC,    '+
    '   :DTAENT,    '+
    '   :HORENT,    '+
    '   :RECURS,    '+
    '   :PARAME,    '+
    '   :RESULT,    '+
    '   :LOGAPI)    ';

    qryLogAPI.ParamByName('AUTINC').AsString  := fRetAutoIncrem('LOGAPI', VS_strCodEmp);

    qryLogAPI.ParamByName('DTAENT').AsDate    := Date;
    qryLogAPI.ParamByName('HORENT').AsTime    := fTime();
    qryLogAPI.ParamByName('RECURS').AsString  := strRecurs;
    qryLogAPI.ParamByName('PARAME').AsString  := strParamE;
    qryLogAPI.ParamByName('RESULT').AsString  := strResult;
    qryLogAPI.ParamByName('LOGAPI').AsString  := API;

    qryLogAPI.ExecSQL;
  finally
   {$IFNDEF LINUX}
     qryLogAPI.Free;
   {$ENDIF LINUX}
  end;
end;

end.
