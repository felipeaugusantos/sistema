unit Yapay.Api.TypeResponse;

interface

type
  TTypeResponse = (JSON, XML);

  TTypeResponseHelper = record helper for TTypeResponse
    function ToFlag: string;
  end;

implementation

{ TTypeResponseHelper }

function TTypeResponseHelper.ToFlag: string;
begin
  case Self of
    JSON: result := 'J';
    XML: result := 'X';
  end;
end;

end.
