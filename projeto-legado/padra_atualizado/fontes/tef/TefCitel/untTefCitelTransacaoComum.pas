unit untTefCitelTransacaoComum;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  TTransacaoTefUtils = class
  private
    FstrCfgTefCit: string;
    FblnTabelaExisteBANSUG: Boolean;
    FblnTabelaExisteADQSUG: Boolean;
    FdictBandeiras: TDictionary<string, string>;
    FdictAdquirentes: TDictionary<string, string>;
    procedure pCarregarBandeiras;
    procedure pCarregarAdquirentes;
  public
    function fNomeBandeira(const ACodBan: string): string;
    function fNomeAdquirente(const ACodRed: string): string;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  Uni, untFuncoesSimples;

{ TTransacaoTefUtils }

constructor TTransacaoTefUtils.Create;
begin
  FstrCfgTefCit := fCfgSis('TEFCIT');
  FblnTabelaExisteBANSUG := fTabelaExiste('BANSUG', True);
  FblnTabelaExisteADQSUG := fTabelaExiste('ADQSUG', True);
  FdictAdquirentes := TDictionary<string, string>.Create();
  FdictBandeiras := TDictionary<string, string>.Create();
  pCarregarAdquirentes;
  pCarregarBandeiras;
end;

destructor TTransacaoTefUtils.Destroy;
begin
  FreeandNil(FdictBandeiras);
  FreeandNil(FdictAdquirentes);
  inherited;
end;

function TTransacaoTefUtils.fNomeAdquirente(const ACodRed: string): string;
begin
  Result := '';

  if not FblnTabelaExisteADQSUG then
    Exit;

  FdictAdquirentes.TryGetValue(fStrZero(ACodRed, 5), Result);
end;

function TTransacaoTefUtils.fNomeBandeira(const ACodBan: string): string;
begin
  Result := '';

  if not FblnTabelaExisteBANSUG then
    Exit;

  FdictBandeiras.TryGetValue(fStrZero(ACodBan, 5), Result);
end;

procedure TTransacaoTefUtils.pCarregarAdquirentes;
var
  Lqry: TUniQuery;
begin
  if not FblnTabelaExisteADQSUG then
    Exit;

  FdictAdquirentes.Clear;

  Lqry := fCriaQuery();
  try
    Lqry.SQL.Text := 'SELECT SUG_NOMADQ, SUG_CODADQ FROM ADQSUG WHERE SUG_FORTEF = :FORTEF';
    Lqry.ParamByName('FORTEF').AsString := FstrCfgTefCit;
    Lqry.Open;

    while not Lqry.Eof do
    begin
      FdictAdquirentes.Add(fStrZero(Lqry.FieldByName('SUG_CODADQ').AsString, 5), Lqry.FieldByName('SUG_NOMADQ').AsString);
      Lqry.Next;
    end;
  finally
    FreeAndNil(Lqry);
  end;
end;

procedure TTransacaoTefUtils.pCarregarBandeiras;
var
  Lqry: TUniQuery;
begin
  if not FblnTabelaExisteBANSUG then
    Exit;

  FdictBandeiras.Clear;

  Lqry := fCriaQuery();
  try
    Lqry.SQL.Text := 'SELECT SUG_NOMBAN, SUG_CODBAN FROM BANSUG WHERE SUG_FORTEF = :FORTEF';
    Lqry.ParamByName('FORTEF').AsString := FstrCfgTefCit;
    Lqry.Open;

    while not Lqry.Eof do
    begin
      FdictBandeiras.Add(fStrZero(Lqry.FieldByName('SUG_CODBAN').AsString, 5), Lqry.FieldByName('SUG_NOMBAN').AsString);
      Lqry.Next;
    end;
  finally
    FreeAndNil(Lqry);
  end;
end;

end.
