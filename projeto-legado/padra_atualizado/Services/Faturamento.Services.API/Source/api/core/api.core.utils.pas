unit api.core.utils;

interface

uses System.SysUtils;

procedure FormatSettings_ptBR;

implementation

procedure FormatSettings_ptBR;
begin
  FormatSettings := TFormatSettings.Create('pt-BR');
  FormatSettings.DateSeparator:=#47;
  FormatSettings.ShortDateFormat:='dd/mm/yyyy';
  FormatSettings.TimeSeparator:=#58;
  FormatSettings.LongTimeFormat:='hh:nn:ss';
  FormatSettings.ShortTimeFormat:='hh:nn';
end;

end.
