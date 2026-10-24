unit Contabilidade.Classes.TPeriodoDatas;

interface

type
  TArrayPeriodoDatas = array of TDateTime ;

  TPeriodoDatas = class
  private
    FdtaDataLancamento: TDateTime ;
    FintQtdPeriodos: Integer ;
    FblnUsarDiaFixo: Boolean ;
    FintDiasPeriodicidade: Integer ;
    FarrPeriodoDatas: TArrayPeriodoDatas ;
  public
    property DataLancamento: TDateTime write FdtaDataLancamento ;
    property QtdPeriodos: Integer write FintQtdPeriodos ;
    property UsarDiaFixo: Boolean write FblnUsarDiaFixo ;
    property DiasPeriodicidade: Integer write FintDiasPeriodicidade ;
    property PeriodoDatas: TArrayPeriodoDatas read FarrPeriodoDatas ;
    constructor Create ;
    function fCalculaPeriodoDatas: TArrayPeriodoDatas ;
  end ;

implementation

uses DateUtils, SysUtils ;

{ TPeriodoDatas }

constructor TPeriodoDatas.Create;
begin
  FdtaDataLancamento := Today ;
  FintQtdPeriodos := 1 ;
  FblnUsarDiaFixo := False ;
  FintDiasPeriodicidade := 30 ;
  SetLength(FarrPeriodoDatas, 0);
end;

function TPeriodoDatas.fCalculaPeriodoDatas: TArrayPeriodoDatas;
var
  LintCnt: Integer ;
  LintDia: Integer ;
  LintMes: Integer ;
  LintAno: Integer ;
  LdtaCalculada: TDateTime ;
begin
  SetLength(FarrPeriodoDatas, 0);
  if FintQtdPeriodos = 1 then
  begin
    SetLength(FarrPeriodoDatas, Length(FarrPeriodoDatas)+1);
    FarrPeriodoDatas[High(FarrPeriodoDatas)] := FdtaDataLancamento ;
  end
  else
  begin
    LdtaCalculada := FdtaDataLancamento ;
    LintDia     := DayOf(LdtaCalculada) ;
    for LintCnt := 1 to FintQtdPeriodos do
    begin
      if FblnUsarDiaFixo then
      begin
        LintMes     := MonthOf(LdtaCalculada) ;
        LintAno     := YearOf(LdtaCalculada) ;

        if IsValidDate(LintAno, LintMes, LintDia) then
          LdtaCalculada := EncodeDate(LintAno, LintMes, LintDia)
        else
          LdtaCalculada := EndOfAMonth(LintAno, LintMes) ;

        SetLength(FarrPeriodoDatas, Length(FarrPeriodoDatas)+1);
        FarrPeriodoDatas[High(FarrPeriodoDatas)] := LdtaCalculada ;

        LdtaCalculada := IncMonth(LdtaCalculada, 1) ;

      end
      else
      begin
        SetLength(FarrPeriodoDatas, Length(FarrPeriodoDatas)+1);
        FarrPeriodoDatas[High(FarrPeriodoDatas)] := LdtaCalculada ;
        LdtaCalculada := IncDay(LdtaCalculada, FintDiasPeriodicidade) ;
      end ;
    end ;
  end ;
  result := FarrPeriodoDatas ;
end;

end.
