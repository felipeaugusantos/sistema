unit Contabilidade.Classes.Utils;

interface

uses
  Contabilidade.Interfaces ;

type
  TFormaFechamentoContabil = class(TObject)
  private
    FArrayDataInicial : Array of TDate;
    FArrayDataFinal : Array of TDate;
    FIteracoes: Integer;
    FExercicio : Integer;
    FTipoFechamento : TTipoFechamentoContabil;
    procedure pProcessar;
  public
    property Iteracoes: Integer read FIteracoes write FIteracoes;
    function DataInicial(const AIndex: Integer): TDateTime;
    function DataFinal(const AIndex: Integer): TDateTime;
    constructor Create(const AExercicio: Integer; ATipoFechamento: TTipoFechamentoContabil);
  end;

implementation

uses
  DateUtils, SysUtils ;

{ TFormaFechamentoContabil }

constructor TFormaFechamentoContabil.Create(const AExercicio: Integer;
  ATipoFechamento: TTipoFechamentoContabil);
begin
  FExercicio := AExercicio;
  FTipoFechamento := ATipoFechamento;
  pProcessar;
end;

function TFormaFechamentoContabil.DataFinal(const AIndex: Integer): TDateTime;
begin
  Result := FArrayDataFinal[AIndex];
end;

function TFormaFechamentoContabil.DataInicial(
  const AIndex: Integer): TDateTime;
begin
  Result := FArrayDataInicial[AIndex];
end;

procedure TFormaFechamentoContabil.pProcessar;
  var
    intCnt : Integer;
    LDataInicial, LDataFinal : TDate;
begin
  case FTipoFechamento of
    tfcMensal:
    begin
      Self.Iteracoes := 12;
      SetLength(FArrayDataInicial, Self.Iteracoes);
      SetLength(FArrayDataFinal, Self.Iteracoes);
      for intCnt := 0 to Pred(Self.Iteracoes) do
      begin
        LDataInicial := EncodeDate(FExercicio, Succ(intCnt), 01);
        FArrayDataInicial[intCnt] := EncodeDate(FExercicio, Succ(intCnt), DayOf(StartOfTheMonth(LDataInicial)));
        FArrayDataFinal[intCnt] := EncodeDate(FExercicio, Succ(intCnt), DayOf(EndOfTheMonth(LDataInicial)));
      end;
    end;
    tfcTrimestral:
    begin
      Self.Iteracoes := 4;
      SetLength(FArrayDataInicial, Self.Iteracoes);
      SetLength(FArrayDataFinal, Self.Iteracoes);
      for intCnt := 0 to Pred(Self.Iteracoes) do
      begin
        LDataFinal := DateOf(EndOfTheMonth(DateOf(EncodeDate(FExercicio, Succ(intCnt)*3, 01))));
        LDataInicial := EncodeDate(FExercicio, MonthOf(LDataFinal)-2, 01);

        FArrayDataInicial[intCnt] := LDataInicial;
        FArrayDataFinal[intCnt] := LDataFinal;
      end;
    end;
    tfcAnual:
    begin
      Self.Iteracoes := 1;
      SetLength(FArrayDataInicial, Self.Iteracoes);
      SetLength(FArrayDataFinal, Self.Iteracoes);
      FArrayDataInicial[0] := EncodeDate(FExercicio, 01, 01);
      FArrayDataFinal[0] := EncodeDate(FExercicio, 12, 31);
    end;
  end;
end;


end.
