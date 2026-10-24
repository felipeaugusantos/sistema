unit untMarketPlace.Classes;

interface

uses Generics.Collections,
     System.DateUtils,
     Types,
     Uni,
     StrUtils,
     Classes,
     SysUtils,
     Rest.Json,
     Forms,
     Windows,
     Messages;

type
  TPedidoNFeHubCitel = class
  private
    FNfKey        : string;
    FNfNumber     : string;
    FNfXml        : string;
    FOrderId      : string;
    FTrackingCode : string;
    FOrigin       : string;
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TPedidoNFeHubCitel;

    property NfKey        : string read FNfKey        write FNfKey;
    property NfNumber     : string read FNfNumber     write FNfNumber;
    property NfXml        : string read FNfXml        write FNfXml;
    property OrderId      : string read FOrderId      write FOrderId;
    property TrackingCode : string read FTrackingCode write FTrackingCode;
    property Origin       : string read FOrigin       write FOrigin;
  end;

implementation

{ TPedidoNFeHubCitel }

class function TPedidoNFeHubCitel.FromJsonString(AJsonString: string): TPedidoNFeHubCitel;
begin
  Result := TJson.JsonToObject<TPedidoNFeHubCitel>(AJsonString);
end;

function TPedidoNFeHubCitel.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

end.
