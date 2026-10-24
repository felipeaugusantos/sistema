unit untComponentFactory;

interface

uses
  Classes, SysUtils;

type
  TComponentFactory = class(TInterfacedObject)
  public
    class function ComponentToString(const Value: TComponent): string;
    class function StringToComponent(const Value: string; const instancia: TComponent = nil): TComponent;
  end;

implementation

type
  TStreamHelper = class helper for TMemoryStream
  protected
    function ReadComponent(Instance: TComponent): TComponent; reintroduce;
    procedure TratarErro (Reader: TReader; const Message: string; var Handled: Boolean);
  end;


{ TComponentFactory }

class function TComponentFactory.ComponentToString(
  const Value: TComponent): string;
var
  binStream: TMemoryStream;
  strComponente: TStringStream;
begin
  binStream := nil;
  strComponente := nil;
  Try
    Try
      binStream := TMemoryStream.Create;
      binStream.WriteComponent(Value);
      binStream.Seek(0, soFromBeginning);
      
      strComponente := TStringStream.Create('');
      ObjectBinaryToText(binStream, strComponente);
      strComponente.Seek(0, soFromBeginning);
      
      Result := strComponente.DataString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(binStream) then FreeAndNil(binStream);
    if Assigned(strComponente) then FreeAndNil(strComponente);
  End;
end;

class function TComponentFactory.StringToComponent(const Value: string; const instancia: TComponent): TComponent;
var
  strComponente: TStringStream;
  binStream: TMemoryStream;
begin
  Result := nil;
  strComponente := nil;
  binStream := nil;
  Try
    Try
      strComponente := TStringStream.Create(Value);
      strComponente.Seek(0, soFromBeginning);

      binStream := TMemoryStream.Create;
      ObjectTextToBinary(strComponente, binStream);
      binStream.Seek(0, soFromBeginning);
      
      Result := binStream.ReadComponent(instancia);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(strComponente) then FreeAndNil(strComponente);
    if Assigned(binStream) then FreeAndNil(binStream);
  End;                            
end;

{ TStreamHelper }

function TStreamHelper.ReadComponent(Instance: TComponent): TComponent;
var
  Reader: TReader;
begin
  Result := nil;
  Reader := nil;
  Try
    Try
      Reader := TReader.Create(Self, 4096);
      Reader.OnError := TratarErro;
      Result := Reader.ReadRootComponent(Instance);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(Reader) then FreeAndNil(Reader);
  End;
end;

procedure TStreamHelper.TratarErro(Reader: TReader; const Message: string;
  var Handled: Boolean);
begin
  Handled := True;
end;

end.
