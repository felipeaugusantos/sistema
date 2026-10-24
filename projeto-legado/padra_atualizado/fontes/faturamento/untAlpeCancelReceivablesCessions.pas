unit untAlpeCancelReceivablesCessions;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  System.JSON, strUtils, Data.DB, MemDS, DBAccess, Uni;

type

{***********************************BEGIN******************************************
******************************OBJETOS DE ENVIO*************************************
********************************************************************************BL*}
TOrderClass = class
private
  FNumber: String;
public
  property number: String read FNumber write FNumber;
end;

TItemClass = class
private
  FOrder: TOrderClass;
public
  property order: TOrderClass read FOrder write FOrder;
  constructor Create;
  destructor Destroy; override;
  class function ToJsonString(ItemClass: TItemClass): string;
end;

TAlpeCancelReceivablesCessions = class
private
  FItems: TArray<TItemClass>;
public
  property Items: TArray<TItemClass> read FItems write FItems;
  constructor Create(length: Integer); reintroduce;
  destructor Destroy; override;
end;
{***********************************END********************************************
******************************OBJETOS DE ENVIO*************************************
********************************************************************************BL*}



{***********************************BEGIN******************************************
******************************OBJETOS DE RETORNO***********************************
********************************************************************************BL*}
TContentClass = class
private
  FOrder: TOrderClass;
public
  property order: TOrderClass read FOrder write FOrder;
  constructor Create;
  destructor Destroy; override;
end;

TAlpeRetornoCancelReceivablesCessions = class
private
  FContent: TArray<TContentClass>;
  FDuration: Extended;
  FId: String;
  FInstant: String;
  FResource: String;
  FStatus: Extended;
public
  property content: TArray<TContentClass> read FContent write FContent;
  property duration: Extended read FDuration write FDuration;
  property id: String read FId write FId;
  property instant: String read FInstant write FInstant;
  property resource: String read FResource write FResource;
  property status: Extended read FStatus write FStatus;
  destructor Destroy; override;
  class function FromJsonString(AJsonString: string): TAlpeRetornoCancelReceivablesCessions;
end;
{***********************************END********************************************
******************************OBJETOS DE RETORNO***********************************
********************************************************************************BL*}


{***********************************BEGIN******************************************
******************************OBJETOS DE ERRO RETORNO******************************
********************************************************************************BL*}
  TContentClassError = class
  private
    FCode: String;
    FTitle: String;
  public
    property code: String read FCode write FCode;
    property title: String read FTitle write FTitle;
  end;

  TErrorClass = class
  private
    FContent: TArray<TContentClassError>;
    FDuration: Extended;
    FId: String;
    FInstant: String;
    FResource: String;
    FStatus: Extended;
  public
    property content: TArray<TContentClassError> read FContent write FContent;
    property duration: Extended read FDuration write FDuration;
    property id: String read FId write FId;
    property instant: String read FInstant write FInstant;
    property resource: String read FResource write FResource;
    property status: Extended read FStatus write FStatus;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TErrorClass;
  end;
{***********************************END********************************************
******************************OBJETOS DE ERRO RETORNO******************************
********************************************************************************BL*}


{**********************************BEGIN*******************************************
*********************************CONTROLLER****************************************
********************************************************************************BL*}
TControllerCancelReceivablesCessions = class
private
  function fCancelReceivablesCessions(CancelReceivablesCessions: TItemClass; strSeqFgo: String): TAlpeRetornoCancelReceivablesCessions;
  procedure pTrataErro(ErrorClass: TErrorClass; strSeqFgo: String);
public
  procedure pProcessarCancelReceivablesCessions;
  procedure pProcessarBaixasCancelReceivablesCessions;
end;
{************************************END*******************************************
*********************************CONTROLLER****************************************
********************************************************************************BL*}

implementation

uses
  untRestApi, untAlpeRestApi;

{***********************************BEGIN******************************************
**************************MÉTODOS OBJETOS DE ENVIO*********************************
********************************************************************************BL*}
{TItemClass}

constructor TItemClass.Create;
begin
  inherited;
  FOrder := TOrderClass.Create();
end;

destructor TItemClass.Destroy;
begin
  FOrder.free;
  inherited;
end;

class function TItemClass.ToJsonString(ItemClass: TItemClass): string;
begin
  result := '['+TJson.ObjectToJsonString(ItemClass)+']';
end;

{TAlpeCancelReceivablesCessions}

constructor TAlpeCancelReceivablesCessions.Create(length: Integer);
var
  i: Integer;
begin
  SetLength(FItems, length);

  for i := 0 to length -1 do
    Items[i] := TItemClass.Create();
end;

destructor TAlpeCancelReceivablesCessions.Destroy;
var
  LItemsItem: TItemClass;
begin

 for LItemsItem in FItems do
   LItemsItem.free;

  inherited;
end;
{***********************************END********************************************
**************************MÉTODOS OBJETOS DE ENVIO*********************************
********************************************************************************BL*}




{***********************************BEGIN******************************************
**************************MÉTODOS OBJETOS DE RETORNO*******************************
********************************************************************************BL*}
{TContentClass}

constructor TContentClass.Create;
begin
  inherited;
  FOrder := TOrderClass.Create();
end;

destructor TContentClass.Destroy;
begin
  FOrder.free;
  inherited;
end;

{TAlpeRetornoCancelReceivablesCessions}
destructor TAlpeRetornoCancelReceivablesCessions.Destroy;
var
  LcontentItem: TContentClass;
begin

 for LcontentItem in FContent do
   LcontentItem.free;

  inherited;
end;

class function TAlpeRetornoCancelReceivablesCessions.FromJsonString(AJsonString: string): TAlpeRetornoCancelReceivablesCessions;
begin
  Result := TJson.JsonToObject<TAlpeRetornoCancelReceivablesCessions>(AJsonString)
end;
{************************************END*******************************************
**************************MÉTODOS OBJETOS DE RETORNO*******************************
********************************************************************************BL*}


{***********************************BEGIN******************************************
**************************MÉTODOS OBJETOS DE ERRO RETORNO**************************
********************************************************************************BL*}

{TErrorClass}
destructor TErrorClass.Destroy;
var
  LcontentItem: TContentClassError;
begin

 for LcontentItem in FContent do
   LcontentItem.free;

  inherited;
end;

class function TErrorClass.FromJsonString(AJsonString: string): TErrorClass;
begin
  result := TJson.JsonToObject<TErrorClass>(AJsonString)
end;

{************************************END*******************************************
**************************MÉTODOS OBJETOS DE ERRO RETORNO**************************
********************************************************************************BL*}

{***********************************BEGIN******************************************
******************************MÉTODOS CONTROLLER***********************************
********************************************************************************BL*}
{ TControllerCancelReceivablesCessions }


procedure TControllerCancelReceivablesCessions.pProcessarBaixasCancelReceivablesCessions;
var
  qryCancel,
  qryUpdate,
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  CancelReceivablesCessions: TAlpeCancelReceivablesCessions;
  RetornoCancelReceivablesCessions: TAlpeRetornoCancelReceivablesCessions;

  i: Integer;
begin

  try
    qryCancel                 := fCriaQuery;
    qryUpdate                 := fCriaQuery;
    qryAux                    := fCriaQuery;
    CancelReceivablesCessions := nil;
    RetornoCancelReceivablesCessions := nil;
    try
      qryCancel.Close;
      qryCancel.SQL.Text :=
      ' SELECT '+
      '   F.AUTOINCREM, '+
      '   L.EMP_C_G_C_, '+
      '   F.FGO_NUMDOC, '+
      '   F.FGO_CODEMP, '+
      '   E.FGO_TIPREC  '+
      ' FROM '+
      '   FATGOR F '+
      ' INNER JOIN EXTGOR E '+
      '   ON F.AUTOINCREM = E.FGO_SEQFGO '+
      ' INNER JOIN CADEMP L '+
      '   ON L.EMP_CODEMP = :CODEMP '+
      ' WHERE '+
      '   F.FGO_ESPDOC = "PD"    AND '+
      '   F.FGO_CODEMP = :CODEMP AND '+
      '   ( '+
      '     E.FGO_TIPREC = "ALPEP" AND '+
      '    (SELECT '+
      '       AUTOINCREM '+
      '     FROM '+
      '       FATDOR '+
      '     WHERE '+
      '       FDO_SEQGER = F.AUTOINCREM AND '+
      '       FDO_JAFATU = "0" LIMIT 1) IS NULL '+
      '    ) '+
      ' OR '+
      '   ( '+
      '     E.FGO_TIPREC = "ALPE" AND '+
      '    (SELECT '+
      '       AUTOINCREM '+
      '     FROM '+
      '       FATDOR '+
      '     WHERE '+
      '       FDO_SEQGER = F.AUTOINCREM AND '+
      '       FDO_JAFATU = "0" LIMIT 1) IS NULL AND '+
      '    (SELECT '+
      '       AUTOINCREM '+
      '     FROM '+
      '       FATDOR '+
      '     WHERE '+
      '       FDO_SEQGER = F.AUTOINCREM AND '+
      '       FDO_NUMFAT IS NOT NULL LIMIT 1) IS NULL '+
      '    )';

      qryCancel.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCancel.Open;

      if not qryCancel.IsEmpty then
      begin
        CancelReceivablesCessions   := TAlpeCancelReceivablesCessions.Create(qryCancel.RecordCount);

        for i := 0 to Length(CancelReceivablesCessions.Items)-1 do
        begin
          CancelReceivablesCessions.Items[i].order.number := qryCancel.FieldByName('EMP_C_G_C_').AsString+':'+
                                                             qryCancel.FieldByName('FGO_NUMDOC').AsString +
                                                             qryCancel.FieldByName('FGO_CODEMP').AsString;

          RetornoCancelReceivablesCessions := fCancelReceivablesCessions(
                                                CancelReceivablesCessions.Items[i],
                                                qryCancel.FieldByName('AUTOINCREM').AsString
                                              );

          if RetornoCancelReceivablesCessions <> nil then
          begin
            fStartTransaction;
            try
              qryAux.Close;
              qryAux.SQL.Text :=
              ' SELECT '+
              '   AUTOINCREM '+
              ' FROM '+
              '   FATDOR F '+
              ' INNER JOIN EXTDOR E '+
              '   ON F.AUTOINCREM = E.FDO_SEQFDO '+
              ' WHERE '+
              '   E.FDO_TIPREC = "ALPE" AND '+
              '   F.FDO_SEQGER = :AUTOIN  AND '+
              '   F.FDO_JAFATU = 1        AND '+
              '   IFNULL(F.FDO_NUMFAT, "") = "" ';

              qryAux.ParamByName('AUTOIN').AsString := qryCancel.FieldByName('AUTOINCREM').AsString;
              qryAux.Open;

              while not qryAux.Eof do
              begin
                qryUpdate.Close;
                qryUpdate.SQL.Text :=
                ' UPDATE '+
                '   EXTDOR '+
                ' SET '+
                '   FDO_TIPREC = "ALPEC"'+
                ' WHERE '+
                '   FDO_SEQFDO = :SEQFDO ';

                qryUpdate.ParamByName('SEQFDO').AsString := qryAux.FieldByName('AUTOINCREM').AsString;
                qryUpdate.ExecSQL;

                qryAux.Next;
              end;

              qryUpdate.Close;
              qryUpdate.SQL.Text :=
              ' UPDATE '+
              '   EXTGOR '+
              ' SET '+
              '   FGO_TIPREC = :TIPREC '+
              ' WHERE '+
              '   FGO_SEQFGO = :AUTOIN';

              qryUpdate.ParamByName('AUTOIN').AsString := qryCancel.FieldByName('AUTOINCREM').AsString;
              qryUpdate.ParamByName('TIPREC').AsString := IIF(qryCancel.FieldByName('FGO_TIPREC').AsString = 'ALPEP',
                                                              'ALPEFP',
                                                              'ALPEC');
              qryUpdate.ExecSQL;

              fCommit;
            except
              On E: Exception Do
              Begin
                fRollback;
              End;
            end;
          end;

          {$IFDEF LINUX}
          TTasklock.pZerarTentativasLock(Format(spIdRecebiveisAlpe, [VS_strCodEmp]));
          {$ENDIF LINUX}

          qryCancel.Next;
          Sleep(1000);
        end;
      end;

    finally
     {$IFNDEF LINUX}
      qryCancel.Free;
      qryUpdate.Free;
      qryAux.Free;
     {$ENDIF LINUX}
      if Assigned(CancelReceivablesCessions) then
        CancelReceivablesCessions.Free;
      if Assigned(RetornoCancelReceivablesCessions) then
        RetornoCancelReceivablesCessions.Free;
    end;
  except
    on E: Exception do
      pGravarErro(True, E.Message);
  end;
end;

procedure TControllerCancelReceivablesCessions.pProcessarCancelReceivablesCessions;
var
  qryCancel,
  qryUpdate,
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  CancelReceivablesCessions: TAlpeCancelReceivablesCessions;
  RetornoCancelReceivablesCessions: TAlpeRetornoCancelReceivablesCessions;

  i: Integer;
begin

  try
    qryCancel                 := fCriaQuery;
    qryUpdate                 := fCriaQuery;
    qryAux                    := fCriaQuery;
    CancelReceivablesCessions := nil;
    RetornoCancelReceivablesCessions := nil;
    try
      qryCancel.Close;
      qryCancel.SQL.Clear;
      qryCancel.SQL.Text :=
      ' SELECT '+
      '   F.AUTOINCREM, '+
      '   E.FGO_SEQFGO, '+
      '   F.FGO_NUMDOC, '+
      '   F.FGO_CODEMP, '+
      '   L.EMP_C_G_C_  '+
      ' FROM '+
      '   DEL_EXTGOR E '+
      ' INNER JOIN DEL_FATGOR F '+
      '   ON E.FGO_SEQFGO = F.AUTOINCREM '+
      ' INNER JOIN CADEMP L '+
      '   ON L.EMP_CODEMP = :CODEMP '+
      ' WHERE '+
      '   F.FGO_ESPDOC = "PD"      AND '+
      '   E.FGO_TIPREC = "ALPE"    AND '+
      '   F.FGO_LIBERA = 1         AND '+
      '   F.FGO_CODEMP = :CODEMP       ';

      qryCancel.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCancel.Open;

      if not qryCancel.IsEmpty then
      begin
        CancelReceivablesCessions   := TAlpeCancelReceivablesCessions.Create(qryCancel.RecordCount);

        for i := 0 to Length(CancelReceivablesCessions.Items)-1 do
        begin
          CancelReceivablesCessions.Items[i].order.number := qryCancel.FieldByName('EMP_C_G_C_').AsString+':'+
                                                             qryCancel.FieldByName('FGO_NUMDOC').AsString +
                                                             qryCancel.FieldByName('FGO_CODEMP').AsString;

          RetornoCancelReceivablesCessions := fCancelReceivablesCessions(
                                                CancelReceivablesCessions.Items[i],
                                                qryCancel.FieldByName('AUTOINCREM').AsString
                                              );

          if RetornoCancelReceivablesCessions <> nil then
          begin
            fStartTransaction;
            try
              qryAux.Close;
              qryAux.SQL.Text :=
              ' SELECT '+
              '   AUTOINCREM '+
              ' FROM '+
              '   DEL_FATDOR F '+
              ' INNER JOIN DEL_EXTDOR E '+
              '   ON F.AUTOINCREM = E.FDO_SEQFDO '+
              ' WHERE '+
              '   E.FDO_TIPREC = "ALPE"   AND '+
              '   F.FDO_SEQGER = :AUTOIN      ';

              qryAux.ParamByName('AUTOIN').AsString := qryCancel.FieldByName('AUTOINCREM').AsString;
              qryAux.Open;

              while not qryAux.Eof do
              begin
                qryUpdate.Close;
                qryUpdate.SQL.Text :=
                ' UPDATE '+
                '   DEL_EXTDOR '+
                ' SET '+
                '   FDO_TIPREC = "ALPEC"'+
                ' WHERE '+
                '   FDO_SEQFDO = :SEQFDO ';

                qryUpdate.ParamByName('SEQFDO').AsString := qryAux.FieldByName('AUTOINCREM').AsString;
                qryUpdate.ExecSQL;

                qryAux.Next;
              end;

              qryUpdate.Close;
              qryUpdate.SQL.Clear;
              qryUpdate.SQL.Text :=
              ' UPDATE '+
              '   DEL_EXTGOR '+
              ' SET '+
              '   FGO_TIPREC = "ALPEC"'+
              ' WHERE '+
              '   FGO_SEQFGO = :SEQFGO';

              qryUpdate.ParamByName('SEQFGO').AsString := qryCancel.FieldByName('FGO_SEQFGO').AsString;
              qryUpdate.ExecSQL;

              fCommit;
            except
              On E: Exception Do
              Begin
                fRollback;
              End;
            end;
          end;

          {$IFDEF LINUX}
          TTasklock.pZerarTentativasLock(Format(spIdRecebiveisAlpe, [VS_strCodEmp]));
          {$ENDIF LINUX}

          qryCancel.Next;
          Sleep(1000);
        end;
      end;

    finally
     {$IFNDEF LINUX}
      qryCancel.Free;
      qryUpdate.Free;
      qryAux.Free;
     {$ENDIF LINUX}
      if Assigned(CancelReceivablesCessions) then
        CancelReceivablesCessions.Free;
      if Assigned(RetornoCancelReceivablesCessions) then
        RetornoCancelReceivablesCessions.Free;
    end;
  except
    on E: Exception do
      pGravarErro(True, E.Message);
  end;
end;

procedure TControllerCancelReceivablesCessions.pTrataErro(ErrorClass: TErrorClass; strSeqFgo: String);
var
  qryError: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin

  qryError := fCriaQuery;
  try
    if ErrorClass.content[0].title = 'cessao-not-found' then
    begin
      qryError.Close;
      qryError.SQL.Text :=
      ' UPDATE '+
      '   EXTGOR '+
      ' SET '+
      '   FGO_TIPREC = "ALPEC" '+
      ' WHERE '+
      '   FGO_SEQFGO = :SEQFGO';

      qryError.ParamByName('SEQFGO').AsString := strSeqFgo;
      qryError.ExecSql;


      qryError.Close;
      qryError.SQL.Clear;
      qryError.SQL.Text :=
      ' UPDATE '+
      '   DEL_EXTGOR '+
      ' SET '+
      '   FGO_TIPREC = "ALPEC"'+
      ' WHERE '+
      '   FGO_SEQFGO = :SEQFGO';

      qryError.ParamByName('SEQFGO').AsString := strSeqFgo;
      qryError.ExecSql;
    end;

  finally
    {$IFNDEF LINUX}
      qryError.Free;
    {$ENDIF LINUX}

    if Assigned(ErrorClass) then
      ErrorClass.Free;
  end;

end;

function TControllerCancelReceivablesCessions.fCancelReceivablesCessions(
  CancelReceivablesCessions: TItemClass; strSeqFgo: String): TAlpeRetornoCancelReceivablesCessions;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('ALPE', TControllerAlpe.fConfigurarAlpe);;
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'accounting/api/v1/receivables-cessions/cancel';
    RestRequest.Method := rmPUT;

    RESTRequest
    .Params
    .AddItem(  '',
               TItemClass.ToJsonString(CancelReceivablesCessions),
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200','201'], strSeqFgo) then
      Result := TAlpeRetornoCancelReceivablesCessions.FromJsonString(JSONRetorno)
    else
      pTrataErro(TErrorClass
                 .FromJsonString(
                                 StringReplace(JSONRetorno, Copy(JSONRetorno, 0, Pos('{', JSONRetorno)-1), '', [rfReplaceAll])),
                                 strSeqFgo);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;

end;
{************************************END*******************************************
******************************MÉTODOS CONTROLLER***********************************
********************************************************************************BL*}

end.
