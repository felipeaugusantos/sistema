unit untTUpdateBolCtrLote;

interface

uses
  System.Generics.Collections, System.SysUtils, Data.DB, Uni, Math;

type
  TAtualizadorBolCtrLote = class
  private
    class var FInstancia: TAtualizadorBolCtrLote;
    FChavesParaAtualizar: TList<string>;
    FTamanhoMaximoLote: Integer;
    FAtivarAtualizacao: Boolean;
    procedure ExecutarAtualizacaoEmLote(const AChaves: TArray<string>);
    function GerarClausulaWhere(const AChaves: TArray<string>): string;
    function GetTamanhoLote: Integer;
    procedure SetTamanhoLote(const Value: Integer);
    function GetAtivarAtualizacao: Boolean;
    procedure SetAtivarAtualizacao(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AdicionarParaAtualizar(const AAutoIncremCtr: string);
    procedure ExecutarTodasPendentes;
    procedure LimparPendentes;
    function QuantidadePendente: Integer;
    class function ObterInstancia: TAtualizadorBolCtrLote;
    class procedure DestruirInstancia;
    property TamanhoLote: Integer read GetTamanhoLote write SetTamanhoLote;
    property AtivarAtualizacao: Boolean read GetAtivarAtualizacao write SetAtivarAtualizacao;
  end;

implementation

uses
  untFuncoesSimples;

{ TAtualizadorBolCtrLote }

constructor TAtualizadorBolCtrLote.Create;
begin
  inherited;
  FChavesParaAtualizar := TList<string>.Create;
  FTamanhoMaximoLote := 200;
  FAtivarAtualizacao := fCfgSis('BOLCTR', varBoolean);
end;

destructor TAtualizadorBolCtrLote.Destroy;
begin
  try
    ExecutarTodasPendentes;
    FreeAndNil(FChavesParaAtualizar);
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
  inherited;
end;

class procedure TAtualizadorBolCtrLote.DestruirInstancia;
begin
  FreeAndNil(FInstancia);
end;

procedure TAtualizadorBolCtrLote.AdicionarParaAtualizar(const AAutoIncremCtr: string);
begin
  try
    if not FAtivarAtualizacao then
      Exit;

    FChavesParaAtualizar.Add(AAutoIncremCtr);

    {if FChavesParaAtualizar.Count >= FTamanhoMaximoLote then
      ExecutarTodasPendentes;}
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
end;

procedure TAtualizadorBolCtrLote.ExecutarTodasPendentes;
var
  LInicio, LFim, LI: Integer;
  LLote: TArray<string>;
begin
  try
    if (FChavesParaAtualizar.Count = 0) or (not FAtivarAtualizacao) then
      Exit;

    LInicio := 0;
    while LInicio < FChavesParaAtualizar.Count do
    begin
      LFim := Min(LInicio + FTamanhoMaximoLote, FChavesParaAtualizar.Count) - 1;
      SetLength(LLote, LFim - LInicio + 1);

      for LI := LInicio to LFim do
        LLote[LI - LInicio] := FChavesParaAtualizar[LI];

      ExecutarAtualizacaoEmLote(LLote);
      LInicio := LFim + 1;
    end;

    LimparPendentes;
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
end;

procedure TAtualizadorBolCtrLote.ExecutarAtualizacaoEmLote(const AChaves: TArray<string>);
var
  LUpdate: TUniQuery;
begin
  if (Length(AChaves) = 0) or (not FAtivarAtualizacao) then
    Exit;

  LUpdate := fCriaQuery(nil);

  try
    try
      LUpdate.SQL.Text := 'UPDATE BOLCTR ' +
                          'SET BOL_TIPBAI = "T" ' +
                          'WHERE BOL_SEQCTR IN (' + GerarClausulaWhere(AChaves) + ')';

      LUpdate.ExecSQL;
    except
      on E: Exception do
        Raise Exception.Create('Ocorreu um erro ao atualizar os registros em lote.' + #13 +
                              'Erro gerado: ' + E.Message + ' - [ExecutarAtualizacaoEmLote]');
    end;
  finally
    FreeAndNil(LUpdate);
  end;
end;

function TAtualizadorBolCtrLote.GerarClausulaWhere(const AChaves: TArray<string>): string;
var
  LContador: Integer;
begin
  Result := '';
  for LContador := 0 to High(AChaves) do
  begin
    if LContador > 0 then
      Result := Result + ', ';

    Result := Result + QuotedStr(AChaves[LContador]);
  end;
end;

function TAtualizadorBolCtrLote.GetTamanhoLote: Integer;
begin
  Result := FTamanhoMaximoLote;
end;

procedure TAtualizadorBolCtrLote.LimparPendentes;
begin
  try
    FChavesParaAtualizar.Clear;
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
end;

function TAtualizadorBolCtrLote.QuantidadePendente: Integer;
begin
  try
    Result := FChavesParaAtualizar.Count;
  except
    on E: Exception do
    begin
      Raise Exception.Create(E.Message);
      Result := 0;
    end;
  end;
end;

procedure TAtualizadorBolCtrLote.SetTamanhoLote(const Value: Integer);
begin
  FTamanhoMaximoLote := Value;
end;

function TAtualizadorBolCtrLote.GetAtivarAtualizacao: Boolean;
begin
  Result := FAtivarAtualizacao;
end;

procedure TAtualizadorBolCtrLote.SetAtivarAtualizacao(const Value: Boolean);
begin
  FAtivarAtualizacao := Value;
end;

class function TAtualizadorBolCtrLote.ObterInstancia: TAtualizadorBolCtrLote;
begin
  if not Assigned(FInstancia) then
    FInstancia := TAtualizadorBolCtrLote.Create;
  Result := FInstancia;
end;

initialization

finalization
  if Assigned(TAtualizadorBolCtrLote.FInstancia) then
    FreeAndNil(TAtualizadorBolCtrLote.FInstancia);

end.

