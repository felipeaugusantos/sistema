unit untTDeleteRetBcoLote;

interface

uses
  System.Generics.Collections, System.SysUtils, Data.DB, Uni,Math;

type
  TChaveRetBco = record
    ACodigoBanco: string;
    ANumeroDuplicata: string;
    AParcela: string;
    ATipoDocumento: string;
    ACodigoEmpresa: string;
    ACodigoCliente: string;
    ACodigoOcorrencia: string;
    ADuplicataComDivergencia: string;
    ACnab: string;
    AMotivoOcorrencia: string;
  end;

  TDeletorRetBco = class
  private
    class var FInstancia: TDeletorRetBco;
    FChavesParaDeletar: TList<TChaveRetBco>;
    FTamanhoMaximoLote: Integer;
    procedure ExecutarDelecaoEmLote(const AChaves: TArray<TChaveRetBco>);
    function GerarClausulaIn(const AChaves: TArray<TChaveRetBco>): string;
    function GetTamanhoLote: Integer;
    procedure SetTamanhoLote(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AdicionarParaDeletar(const AChave: TChaveRetBco);
    procedure ExecutarTodasPendentes;
    procedure LimparPendentes;
    function QuantidadePendente: Integer;
    class function ObterInstancia: TDeletorRetBco;
    class procedure DestruirInstancia;
    property TamanhoLote: Integer read GetTamanhoLote write SetTamanhoLote;
  end;

implementation

uses
  untFuncoesSimples;

{ TDeletorRetBco }

constructor TDeletorRetBco.Create;
begin
  inherited;
  FChavesParaDeletar := TList<TChaveRetBco>.Create;
  FTamanhoMaximoLote := 200;
end;

destructor TDeletorRetBco.Destroy;
begin
  try
    ExecutarTodasPendentes;
    FreeAndNil(FChavesParaDeletar);
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
  inherited;
end;

class procedure TDeletorRetBco.DestruirInstancia;
begin
  FreeAndNil(FInstancia);
end;

procedure TDeletorRetBco.AdicionarParaDeletar(const AChave: TChaveRetBco);
begin
  try
    FChavesParaDeletar.Add(AChave);

    if FChavesParaDeletar.Count >= FTamanhoMaximoLote then
      ExecutarTodasPendentes;
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
end;

procedure TDeletorRetBco.ExecutarTodasPendentes;
var
  LInicio, LFim, LI: Integer;
  LLote: TArray<TChaveRetBco>;
begin
  try
    if FChavesParaDeletar.Count = 0 then
      Exit;

    LInicio := 0;
    while LInicio < FChavesParaDeletar.Count do
    begin
      LFim := Min(LInicio + FTamanhoMaximoLote, FChavesParaDeletar.Count) - 1;
      SetLength(LLote, LFim - LInicio + 1);

      for LI := LInicio to LFim do
        LLote[LI - LInicio] := FChavesParaDeletar[LI];

      ExecutarDelecaoEmLote(LLote);
      LInicio := LFim + 1;
    end;

    LimparPendentes;
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
end;

procedure TDeletorRetBco.ExecutarDelecaoEmLote(const AChaves: TArray<TChaveRetBco>);
var
  LDelete: TUniQuery;
begin

  if Length(AChaves) = 0 then
    Exit;

  LDelete := fCriaQuery(nil);

  try
    try
      LDelete.SQL.Text := 'DELETE                               '+
                          '  FROM                               '+
                          '    RETBCO                           '+
                          '  WHERE (                            '+
                          '      RET_CODBCO,                    '+
                          '      RET_NUMDUP,                    '+
                          '      RET_PARCEL,                    '+
                          '      RET_ESPDOC,                    '+
                          '      RET_CODEMP,                    '+
                          '      RET_CODCLI,                    '+
                          '      RET_CODOCO,                    '+
                          '      RET_DUPDIV,                    '+
                          '      IFNULL(RET_CNAB__,""),         '+
                          '      RET_MOTOCO                     '+
                          '    ) IN (                           '+
                                  GerarClausulaIn(AChaves)       +
                          '    )                                ';
      LDelete.ExecSQL;
    except
      on E: Exception do
        Raise Exception.Create(E.Message);
    end;
  finally
    FreeAndNil(LDelete);
  end;
end;

function TDeletorRetBco.GerarClausulaIn(const AChaves: TArray<TChaveRetBco>): string;
var
  LContador: Integer;
begin
  Result := '';
  for LContador := 0 to High(AChaves) do
  begin
    if LContador > 0 then
      Result := Result + ', ';

    Result := Result + Format(
      '(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)',
      [
        QuotedStr(AChaves[LContador].ACodigoBanco),
        QuotedStr(AChaves[LContador].ANumeroDuplicata),
        QuotedStr(AChaves[LContador].AParcela),
        QuotedStr(AChaves[LContador].ATipoDocumento),
        QuotedStr(AChaves[LContador].ACodigoEmpresa),
        QuotedStr(AChaves[LContador].ACodigoCliente),
        QuotedStr(AChaves[LContador].ACodigoOcorrencia),
        QuotedStr(AChaves[LContador].ADuplicataComDivergencia),
        QuotedStr(AChaves[LContador].ACnab),
        QuotedStr(AChaves[LContador].AMotivoOcorrencia)
      ]);
  end;
end;

function TDeletorRetBco.GetTamanhoLote: Integer;
begin
  Result := FTamanhoMaximoLote;
end;

procedure TDeletorRetBco.LimparPendentes;
begin
  try
    FChavesParaDeletar.Clear;
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
end;

function TDeletorRetBco.QuantidadePendente: Integer;
begin
  try
    Result := FChavesParaDeletar.Count;
  except
    on E: Exception do
    begin
      Raise Exception.Create(E.Message);
      Result := 0;
    end;
  end;
end;

procedure TDeletorRetBco.SetTamanhoLote(const Value: Integer);
begin
 FTamanhoMaximoLote := Value;
end;

class function TDeletorRetBco.ObterInstancia: TDeletorRetBco;
begin
  if not Assigned(FInstancia) then
    FInstancia := TDeletorRetBco.Create;
  Result := FInstancia;
end;

initialization

finalization
  if Assigned(TDeletorRetBco.FInstancia) then
    FreeAndNil(TDeletorRetBco.FInstancia);

end.
