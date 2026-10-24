unit Cotacao.ApiPrecos.BaseParam;

interface

uses classes, REST.Types, REST.Json, System.JSON,  System.IOUtils, System.StrUtils, System.SysUtils,
     Generics.Collections, untFuncoesSimples;

type

  TJsonRetKeyValue = record
    Key: String;
    Value: String;
    KeyWithPos: String;
    Index: integer;
  End;

  TArrJsonRetKeyValue = array of TJsonRetKeyValue;

  TRetornoApi = Record
    Retorno: String;
    Sucess: Boolean;
    Falha: String;
    StatusCode: Integer;
  End;

  TBaseParamApi = class
  private
  protected
    FArrJsonRetKeyValue: TArrJsonRetKeyValue;
    procedure pIniciaValores; virtual;
    procedure TrataObjeto(NomeObjeto: String;NomeNoPos: string; jObj:TJSONObject);
    procedure pAddKeyValue(strKey, strKeyWithPos, strValor: String);
    function fFistKey(Value: String): integer;
    procedure TrataArray(nomeArray: String;NomeNoPos: string; jArr: TJSONArray);
    procedure pProcessaJsonRetorno(ARetjson: string);
    function  ZeroAEsquerda(qtdZero: integer; Value: integer): String;
    function  fLocate(key, Value: String): integer;
    function getJsonEnvion: String; virtual;
  public
    RetornoApi: TRetornoApi;
    constructor Create;
    function fProcessaRetono: String; virtual;
    property JsonEnvioBody: String read getJsonEnvion;
  End;

implementation

{ TBaseParamApi }

constructor TBaseParamApi.Create;
begin
  pIniciaValores
end;

procedure TBaseParamApi.pProcessaJsonRetorno(ARetjson: string);
var
  LJSONObject: TJSONObject;

begin
  SetLength(FArrJsonRetKeyValue, 0);
  LJSONObject := nil;
  try
    LJSONObject := TJsonObject.Create;
    { convert String to JSON }
    LJSONObject.Parse(TEncoding.ASCII.GetBytes(ARetjson),0);

    { output the JSON to console as String }
    TrataObjeto( '', '', LJSONObject);
  finally
    LJSONObject.Free;
  end;
end;


procedure TBaseParamApi.TrataArray(nomeArray: String;NomeNoPos: string ; jArr: TJSONArray);
 var i:integer;
Begin
 for I := 0 to Pred(jArr.Count) do
 Begin
   if jArr.Items[i] is TJSONObject then
      TrataObjeto(nomeArray +'[' + ZeroAEsquerda(Pred(jArr.Count), i) + ']',
                  NomeNoPos,
                  (jArr.Items[i] as TJSONObject))
    Else if jArr.Items[i] is TJSONArray then
      TrataArray(nomeArray +'[' + ZeroAEsquerda(Pred(jArr.Count), i) + ']',
                 NomeNoPos,
                 jArr.Items[i] as TJSONArray)
    Else
      pAddKeyValue(NomeNoPos, nomeArray +'[' + ZeroAEsquerda(Pred(jArr.Count), i) + ']', jArr.Items[i].GetValue<string>);
 End;
End;

procedure  TBaseParamApi.TrataObjeto(NomeObjeto: String;NomeNoPos: string;jObj:TJSONObject);
var i:integer;
   jPar: TJSONPair;
begin
  for i := 0 to jObj.Count -1 do
  begin
    jPar := jObj.Pairs[i];
    if jPar.JsonValue Is TJSONObject then
      TrataObjeto(NomeObjeto + IIf(NomeNoPos.IsEmpty, '', '.') + jPar.JsonString.Value,
                  NomeNoPos + IIf(NomeNoPos.IsEmpty, '', '.') + jPar.JsonString.Value, (jPar.JsonValue As TJSONObject))
    Else If jPar.JsonValue is TJSONArray then
      TrataArray(NomeObjeto + IIf(NomeNoPos.IsEmpty, '', '.') + jPar.JsonString.Value,
                 NomeNoPos + IIf(NomeNoPos.IsEmpty, '', '.') + jPar.JsonString.Value,
                 jPar.JsonValue as TJSONArray)
    Else
      pAddKeyValue(NomeNoPos + IIf(NomeNoPos.IsEmpty, '', '.') +  jPar.JsonString.Value,
                   NomeObjeto + IIf(NomeNoPos.IsEmpty, '', '.') +  jPar.JsonString.Value,
                   jPar.JsonValue.GetValue<string>)

  end;
end;

function TBaseParamApi.ZeroAEsquerda(qtdZero, Value: integer): String;
begin
    Result := Format('%.'+Length(qtdZero.ToString).ToString +'d', [Value]);
end;

function TBaseParamApi.fFistKey(Value: String): integer;
var strResult: String;
    PosIni: integer;
    PosFim: integer;
begin
  Result := -1;
  PosIni := Value.LastIndexOf('[');

  If PosIni > 0 then
  begin
    PosFim := Value.LastIndexOf(']');
    strResult := Copy(Value, PosIni + 2,  (PosFim - PosIni) - 1);
    Result := StrToIntDef(strResult, -1);
  End;
end;

function TBaseParamApi.fLocate(key, Value: String): integer;
var JsonRetKeyValue :TJsonRetKeyValue;
begin
  Result := -1;
  For JsonRetKeyValue  in FArrJsonRetKeyValue do
  Begin
    If (JsonRetKeyValue.Key = Key) Then
      If (JsonRetKeyValue.Value = Value) Then
        Exit(JsonRetKeyValue.Index)
  End;
  {}
end;

function TBaseParamApi.fProcessaRetono: String;
begin
  pProcessaJsonRetorno(RetornoApi.Retorno);
end;


function TBaseParamApi.getJsonEnvion: String;
begin
  Result := '';
  {}
end;

procedure TBaseParamApi.pAddKeyValue(strKey, strKeyWithPos, strValor: String);
begin
  SetLength(FArrJsonRetKeyValue, succ(Length(FArrJsonRetKeyValue)));
  FArrJsonRetKeyValue[High(FArrJsonRetKeyValue)].Key := strKey;
  FArrJsonRetKeyValue[High(FArrJsonRetKeyValue)].KeyWithPos := strKeyWithPos;
  FArrJsonRetKeyValue[High(FArrJsonRetKeyValue)].Value := strValor;
  FArrJsonRetKeyValue[High(FArrJsonRetKeyValue)].Index := fFistKey(strKeyWithPos);
end;

function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
begin
   if lTest then
     Result := vExpr1
   else
     Result := vExpr2
end;

procedure TBaseParamApi.pIniciaValores;
begin
  {}
end;

end.
