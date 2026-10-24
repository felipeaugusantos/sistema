unit Yapay.Api.MessageResponse;

interface

uses
  SysUtils,
  TypInfo;

type
{$M+}
  TTipoMessageResponse = (Success, Error);

  TTipoMessageResponseHelper = record helper for TTipoMessageResponse
  public
    function ToString: string;
    class function GetByName(Value: string): TTipoMessageResponse; static;
  end;

  TMessageResponse = class
  strict protected
    FMessage: TTipoMessageResponse;
  published
    property Message: TTipoMessageResponse read FMessage;
  end;
{$M-}

implementation

{ TTipoMessageResponseHelper }

class function TTipoMessageResponseHelper.GetByName(
  Value: string): TTipoMessageResponse;
begin
  result := TTipoMessageResponse(-1);
  case CompareText(Value, Success.ToString) of
    0: result := Success;
    else
    begin
      if CompareText(Value, Error.ToString) = 0 then
        result := Error
    end;
  end;
end;

function TTipoMessageResponseHelper.ToString: string;
begin
  result := GetEnumName(TypeInfo(TTipoMessageResponse), Integer(Self));
end;

end.
