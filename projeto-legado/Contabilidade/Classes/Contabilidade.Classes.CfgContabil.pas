unit Contabilidade.Classes.CfgContabil;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  ICfgContabil = interface
    ['{312E424E-3657-4EB0-8B8E-281F1C6496E3}']
    function fCfgSis(const AstrCodCfg: string; AvarTipVar: TVarType = varString; const AstrCodEmp: string = ''): Variant;
    function fCfgSisBoolean(const AstrCodCfg: string; AblnDefault: Boolean = False; const AstrCodEmp: string = ''): Boolean;
  end;

  TCfgContabilDefault = class(TInterfacedObject, ICfgContabil)
  public
    function fCfgSis(const AstrCodCfg: string; AvarTipVar: TVarType = varString; const AstrCodEmp: string = ''): Variant;
    function fCfgSisBoolean(const AstrCodCfg: string; AblnDefault: Boolean = False; const AstrCodEmp: string = ''): Boolean;

    class function New: ICfgContabil;
  end;

  TCfgContabilImportacao = class(TInterfacedObject, ICfgContabil)
  private
    FdctOverlay: TDictionary<string, string>;
    FblnOwnsDictionary: Boolean;
    function fConverteValor(const AstrValor: string; AvarTipVar: TVarType): Variant;
    function fNormalizaChave(const AstrCodCfg: string): string;
  public
    function fCfgSis(const AstrCodCfg: string; AvarTipVar: TVarType = varString; const AstrCodEmp: string = ''): Variant;
    function fCfgSisBoolean(const AstrCodCfg: string; AblnDefault: Boolean = False; const AstrCodEmp: string = ''): Boolean;
    constructor Create(AdctOverlay: TDictionary<string, string>; AblnOwnsDictionary: Boolean = False);
    destructor Destroy; override;

    class function New(AdctOverlay: TDictionary<string, string>; AblnOwnsDictionary: Boolean = False): ICfgContabil;
  end;

implementation

uses
  untFuncoesSimples, Contabilidade.Funcoes;

{ TCfgContabilDefault }

function TCfgContabilDefault.fCfgSis(const AstrCodCfg: string; AvarTipVar: TVarType; const AstrCodEmp: string): Variant;
begin
  Result := untFuncoesSimples.fCfgSis(AstrCodCfg, AvarTipVar, AstrCodEmp);
end;

function TCfgContabilDefault.fCfgSisBoolean(const AstrCodCfg: string; AblnDefault: Boolean; const AstrCodEmp: string): Boolean;
begin
  if not fConfiguracaoExiste(AstrCodCfg, AstrCodEmp) then
  begin
    Result := AblnDefault;
    Exit;
  end;
  Result := untFuncoesSimples.fCfgSis(AstrCodCfg, varBoolean, AstrCodEmp);
end;

class function TCfgContabilDefault.New: ICfgContabil;
begin
  Result := Self.Create;
end;

{ TCfgContabilImportacao }

constructor TCfgContabilImportacao.Create(
  AdctOverlay: TDictionary<string, string>;
  AblnOwnsDictionary: Boolean);
begin
  inherited Create;
  FdctOverlay := AdctOverlay;
  FblnOwnsDictionary := AblnOwnsDictionary;
end;

destructor TCfgContabilImportacao.Destroy;
begin
  if FblnOwnsDictionary then
    FreeAndNil(FdctOverlay);
  inherited;
end;

function TCfgContabilImportacao.fNormalizaChave(const AstrCodCfg: string): string;
begin
  // A fCfgSis global recebe 'NOME' e internamente adiciona 'CFG_'
  // O dict do overlay armazena a chave SEM o prefixo CFG_
  // Se por acaso vier com prefixo, removemos para manter consistencia
  Result := UpperCase(AstrCodCfg);
  if Copy(Result, 1, 4) = 'CFG_' then
    Result := Copy(Result, 5, Length(Result) - 4);
end;

function TCfgContabilImportacao.fCfgSis(const AstrCodCfg: string; AvarTipVar: TVarType; const AstrCodEmp: string): Variant;
var
  LstrValor: string;
  LstrChave: string;
begin
  LstrChave := fNormalizaChave(AstrCodCfg);
  if Assigned(FdctOverlay) and FdctOverlay.TryGetValue(LstrChave, LstrValor) then
    Result := fConverteValor(LstrValor, AvarTipVar)
  else
    Result := untFuncoesSimples.fCfgSis(AstrCodCfg, AvarTipVar, AstrCodEmp);
end;

function TCfgContabilImportacao.fCfgSisBoolean(const AstrCodCfg: string;
  AblnDefault: Boolean; const AstrCodEmp: string): Boolean;
var
  LstrValor: string;
  LstrChave: string;
begin
  LstrChave := fNormalizaChave(AstrCodCfg);
  if Assigned(FdctOverlay) and FdctOverlay.TryGetValue(LstrChave, LstrValor) then
  begin
    Result := fConverteValor(LstrValor, varBoolean);
    Exit;
  end;

  if not fConfiguracaoExiste(AstrCodCfg, AstrCodEmp) then
  begin
    Result := AblnDefault;
    Exit;
  end;
  Result := untFuncoesSimples.fCfgSis(AstrCodCfg, varBoolean, AstrCodEmp);
end;

function TCfgContabilImportacao.fConverteValor(const AstrValor: string;
  AvarTipVar: TVarType): Variant;
begin
  case AvarTipVar of
    varString:
      Result := AstrValor;

    varInteger, varSmallint, varSingle, varByte, varShortInt, varInt64:
    begin
      if AstrValor.IsEmpty then
        Result := 0
      else
      begin
        try
          Result := StrToInt(AstrValor);
        except
          Result := 0;
        end;
      end;
    end;

    varDouble, varCurrency:
    begin
      if AstrValor.IsEmpty then
        Result := 0.00
      else
      begin
        try
          Result := StrToFloat(StringReplace(AstrValor, '.', ',', [rfReplaceAll]));
        except
          Result := 0.00;
        end;
      end;
    end;

    varDate:
    begin
      if AstrValor.IsEmpty then
        Result := 0
      else
      begin
        try
          Result := StrToDate(AstrValor);
        except
          Result := 0;
        end;
      end;
    end;

    varBoolean:
    begin
      if AstrValor.IsEmpty then
        Result := False
      else if Pos('S_N_', AstrValor) > 0 then
        Result := (AstrValor = 'S')
      else if Pos('0_1_', AstrValor) > 0 then
        Result := (AstrValor = '1')
      else
        Result := (Length(AstrValor) > 0) and
          CharInSet(AstrValor[1], ['T', 't', 'Y', 'y', 'S', 's']);
    end;
  else
    Result := AstrValor;
  end;
end;

class function TCfgContabilImportacao.New(AdctOverlay: TDictionary<string, string>; AblnOwnsDictionary: Boolean): ICfgContabil;
begin
  Result := Self.Create(AdctOverlay, AblnOwnsDictionary);
end;

end.
