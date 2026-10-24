unit untIntelipost.ShipmentOrder.GetLabel;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, Math, System.DateUtils, untIntelipost.Retorno.ShipmentOrder,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types;
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni, System.IOUtils;
  {$ENDIF LINUX}

type
  TMessagesClass = class
  private
    FKey: String;
    FText: String;
    FType: String;
  public
    property key: String read FKey write FKey;
    property text: String read FText write FText;
    property &type: String read FType write FType;
  end;

  TContentClass = class
  private
    FLabel_url: String;
    FOrder_number: String;
    FShipment_order_volume_number: String;
  public
    property label_url: String read FLabel_url write FLabel_url;
    property order_number: String read FOrder_number write FOrder_number;
    property shipment_order_volume_number: String read FShipment_order_volume_number write FShipment_order_volume_number;
  end;

  TIntelipostRetornoShipmentOrderGetLabel = class
  private
    FContent: TContentClass;
    FLocale: String;
    FMessages: TArray<TMessagesClass>;
    FStatus: String;
    FTime: String;
    FTimezone: String;
  public
    property content: TContentClass read FContent write FContent;
    property locale: String read FLocale write FLocale;
    property messages: TArray<TMessagesClass> read FMessages write FMessages;
    property status: String read FStatus write FStatus;
    property time: String read FTime write FTime;
    property timezone: String read FTimezone write FTimezone;
    constructor Create;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TIntelipostRetornoShipmentOrderGetLabel;
  end;

  TIntelipostShipmentOrderGetLabel = class
  private
    Forder_number: String;
    Fshipment_order_volume_number: Integer;

    function fImprimirEtiqueta: TIntelipostRetornoShipmentOrderGetLabel;
  public
    property order_number: String read Forder_number write Forder_number;
    property shipment_order_volume_number: Integer read Fshipment_order_volume_number write Fshipment_order_volume_number;

    class function fImprimeEstiquetaIntelipost(const strNumDoc, strEspDoc, strCodEmp: String; intEtiIni: Integer = 1): Boolean;
  end;

implementation

{TIntelipostRetornoShipmentOrderGetLabel}

uses untRestApi, untIntelipostRestApi, untIntelipost.ShipmentOrder;

constructor TIntelipostRetornoShipmentOrderGetLabel.Create;
begin
  inherited;
  FContent := TContentClass.Create();
end;

destructor TIntelipostRetornoShipmentOrderGetLabel.Destroy;
var
  LmessagesItem: TMessagesClass;
begin
  FContent.free;

 for LmessagesItem in FMessages do
   LmessagesItem.free;

  inherited;
end;

class function TIntelipostRetornoShipmentOrderGetLabel.FromJsonString(AJsonString: string): TIntelipostRetornoShipmentOrderGetLabel;
begin
  result := TJson.JsonToObject<TIntelipostRetornoShipmentOrderGetLabel>(AJsonString)
end;

{ TIntelipostShipmentOrderGetLabel }

class function TIntelipostShipmentOrderGetLabel.fImprimeEstiquetaIntelipost(
  const strNumDoc, strEspDoc, strCodEmp: String; intEtiIni: Integer = 1): Boolean;
var
  IntelipostShipmentOrderGetLabel: TIntelipostShipmentOrderGetLabel;
  IntelipostRetornoShipmentOrderGetLabel: TIntelipostRetornoShipmentOrderGetLabel;
  qryPedido: TUniQuery;

  strMsgRetorno: String;
  intCount: Integer;

  strPathArquivo: String;
begin
  Result := False;

  IntelipostShipmentOrderGetLabel := TIntelipostShipmentOrderGetLabel.Create;
  qryPedido := fCriaQuery;
  try
    qryPedido.Close;
    qryPedido.SQL.Text :=
    ' SELECT '+
    '   FATDOR.FDO_SEQGER, '+
    '   FATDOR.FDO_NUMDOC, '+
    '   FATDOR.FDO_ESPDOC, '+
    '   FATDOR.FDO_CODEMP, '+
    '   MOVGER.GER_VOLUME  '+
    ' FROM '+
    '   FATDOR '+
    ' INNER JOIN MOVGER ON '+
    '   FATDOR.FDO_NUMFAT = MOVGER.GER_NUMDOC AND '+
    '   FATDOR.FDO_TIPFAT = MOVGER.GER_ESPDOC AND '+
    '   FATDOR.FDO_EMPFAT = MOVGER.GER_CODEMP     '+
    ' WHERE '+
    '   FDO_NUMDOC = :NUMDOC AND '+
    '   FDO_ESPDOC = :ESPDOC AND '+
    '   FDO_CODEMP = :CODEMP     ';

    qryPedido.ParamByName('NUMDOC').AsString := strNumDoc;
    qryPedido.ParamByName('ESPDOC').AsString := strEspDoc;
    qryPedido.ParamByName('CODEMP').AsString := strCodEmp;
    qryPedido.Open;

    if not qryPedido.IsEmpty then
    begin
      if not TIntelipostShipmentOrder.fEnviarPedidoIntelipost(qryPedido.FieldbyName('FDO_SEQGER').AsString, strMsgRetorno, True) then
      begin
        fMensagem('ATENÇÃO!', strMsgRetorno, ['&Ok']);
        Exit;
      end;

      for intCount:=intEtiIni to qryPedido.FieldByName('GER_VOLUME').AsInteger do
      begin
        IntelipostShipmentOrderGetLabel.order_number := fRetiraZerosEsquerda(qryPedido.FieldByName('FDO_NUMDOC').AsString+qryPedido.FieldByName('FDO_ESPDOC').AsString+qryPedido.FieldByName('FDO_CODEMP').AsString);
        IntelipostShipmentOrderGetLabel.shipment_order_volume_number := intCount;

        IntelipostRetornoShipmentOrderGetLabel := IntelipostShipmentOrderGetLabel.fImprimirEtiqueta;
        if ((Assigned(IntelipostRetornoShipmentOrderGetLabel)) and (IntelipostRetornoShipmentOrderGetLabel.status = 'OK')) then
        begin
          strPathArquivo := TPath.GetTempPath + strNumDoc + strEspDoc + strCodEmp + '_' + intCount.ToString + '.pdf';

          if FileExists(strPathArquivo) then
            DeleteFile(strPathArquivo);

          Result := fDownloadArquivo(IntelipostRetornoShipmentOrderGetLabel.content.label_url, strPathArquivo);

          if Result then
            pExecArquivo(strPathArquivo, 0)
          else
            fMensagem('ATENÇÃO!', 'Não foi possível fazer o download da etiqueta!', ['&Ok']);
        end
        else
        begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Não foi possível comunicar com a Intelipost! Por favor, tente novamente.'+sLineBreak+
                                'Erro ao imprimir a etiqueta do volume '+intCount.ToString+sLineBreak+
                                'Retorno: '+IntelipostRetornoShipmentOrderGetLabel.messages[0].text, ['&Ok']);
          Break;
        end;
      end;
    end;

  finally
    FreeAndNil(qryPedido);
    FreeAndNil(IntelipostShipmentOrderGetLabel);
  end;

end;

function TIntelipostShipmentOrderGetLabel.fImprimirEtiqueta: TIntelipostRetornoShipmentOrderGetLabel;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('INTELIPOST', TControllerConfigurarIntelipost.fConfigurarIntelipost);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'shipment_order/get_label/'+Self.order_number+'/'+Self.shipment_order_volume_number.ToString;
    RestRequest.Method := rmGET;

    RestRequest.Params.AddItem('api-key', fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_ITPKEY', VS_strCodEmp], True, EmptyStr), pkHTTPHEADER);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200', '400'], EmptyStr) then
      Result := TIntelipostRetornoShipmentOrderGetLabel.FromJsonString(JSONRetorno);
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;

end;

end.
