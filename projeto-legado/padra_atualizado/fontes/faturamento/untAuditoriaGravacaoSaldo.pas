unit untAuditoriaGravacaoSaldo;

interface

uses Generics.Collections;

type
  IAuditoriaGravacaoSaldo = interface
    ['{F4E3C3DA-5306-48FB-8C9C-6DF9AB0E086C}']
    function Adicionar(strAutoincrem, strTabela: String): IAuditoriaGravacaoSaldo;
    function Limpar: IAuditoriaGravacaoSaldo;
    function fValidouTodas(out ACodErros: String): Boolean;
  end;

  TAuditoriaGravacaoSaldo = class(TInterfacedObject, IAuditoriaGravacaoSaldo)
  private
    FFazerAuditoria : Boolean;
    FListAutInc : TList<String>;
    FListTabela : TList<String>;
    function fValidou(strTabela, strAutoincrem: String; blnModoRobo: Boolean): String;
  public
    function Adicionar(strAutoincrem, strTabela: String): IAuditoriaGravacaoSaldo;
    function Limpar: IAuditoriaGravacaoSaldo;
    function fValidouTodas(out ACodErros: String): Boolean;
    constructor Create;
    destructor Destroy; override;
    class function New: IAuditoriaGravacaoSaldo;
  end;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untConstantes, SysUtils, Uni, Data.DB, untAuditoriaLog;

{ IAuditoriaGravacaoSaldo }

function TAuditoriaGravacaoSaldo.Adicionar(strAutoincrem, strTabela: String): IAuditoriaGravacaoSaldo;
begin
  Result := Self;
  FListAutInc.Add(strAutoincrem);
  FListTabela.Add(strTabela);
end;

function TAuditoriaGravacaoSaldo.Limpar: IAuditoriaGravacaoSaldo;
begin
  Result := Self;
  FListAutInc.Clear;
  FListTabela.Clear;
end;

class function TAuditoriaGravacaoSaldo.New: IAuditoriaGravacaoSaldo;
begin
  Result := Self.Create;
end;

constructor TAuditoriaGravacaoSaldo.Create;
begin
  FListAutInc := TList<String>.Create;
  FListTabela := TList<String>.Create;
  FFazerAuditoria := fCFgSis('UTAUFA', varBoolean);
end;

destructor TAuditoriaGravacaoSaldo.Destroy;
begin
  FreeAndNil(FListAutInc);
  FreeAndNil(FListTabela);
  inherited;
end;

function TAuditoriaGravacaoSaldo.fValidou(strTabela, strAutoincrem: String; blnModoRobo: Boolean): String;
const
  AUDITORIA = 'F_AUDITORIA_GRAVACAO_SALDO';
var
  qryFunction : TUniQuery;
begin
  Result := '';

  qryFunction := fCriaQuery;

  try
    try
      qryFunction.SQL.Text := 'SELECT '+AUDITORIA+'(:TABELA, :AUTOINCREM, :MODO_ROBO);';
      qryFunction.ParamByName('TABELA').AsString := strTabela;
      qryFunction.ParamByName('AUTOINCREM').AsString := strAutoincrem;
      qryFunction.ParamByName('MODO_ROBO').AsInteger := IIF(blnModoRobo, 1, 0);
      qryFunction.Open;

      if (not qryFunction.IsEmpty) and (qryFunction.Fields[0].AsString <> '0') then
        Result := qryFunction.Fields[0].AsString;

      If fCfgSis('AUDLOG', varBoolean) Then
        TAuditoriaLog.New()
          .setAuditoria(AUDITORIA)
          .setParametro(strTabela + '|' + strAutoincrem + '|' + IIF(blnModoRobo, '1', '0'))
          .setResultado(Result)
          .setOpeLogado(strLoginUsuarioLogado)
          .Gravar;

    except
      on E: Exception do
        Result := '';
    end;
  finally
    FreeAndNil(qryFunction);
  end;
end;

function TAuditoriaGravacaoSaldo.fValidouTodas(out ACodErros: String): Boolean;
var
  intCnt : Integer;
  LAutComEmModoImportacao: Boolean;
begin
  Result := True;
  ACodErros := '';

  If Not FFazerAuditoria Then
    Exit;

{$IFDEF LINUX}
  LAutComEmModoImportacao := False;
{$ELSE}
  LAutComEmModoImportacao := fAutComEmModoImportacao;
{$ENDIF}

  for intCnt := 0 to Pred(FListAutInc.Count) do
  begin
    ACodErros := fValidou(FListTabela[intCnt], FListAutInc[intCnt], LAutComEmModoImportacao);
    Result := fEmptyStr(ACodErros);

    if (not Result) then
      Break;
  end;
end;

end.
