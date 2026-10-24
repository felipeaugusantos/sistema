unit untAuditoriaGravacaoFaturamento;

interface

uses Generics.Collections;

type
  IAuditoriaGravacaoFaturamento = interface
    ['{D1868E86-FB7D-454F-9DE9-9C24E1F1BB54}']
    function Adicionar(strAutoincrem: string; strTabela: String): IAuditoriaGravacaoFaturamento;
    function Limpar: IAuditoriaGravacaoFaturamento;
    function fValidouTodas(out ACodErros: String): boolean;
  end;

  TAuditoriaGravacaoFaturamento = class(TInterfacedObject, IAuditoriaGravacaoFaturamento)
  private
    FFazerAuditoria : boolean;
    FListAutInc : TList<String>;
    FListTabela : TList<String>;
    function fValidou(strTabela, strAutoincrem: String; blnModoRobo: Boolean): String;
  public
    function Adicionar(strAutoincrem: string; strTabela: String): IAuditoriaGravacaoFaturamento;
    function Limpar: IAuditoriaGravacaoFaturamento;
    function fValidouTodas(out ACodErros: String): boolean;
    constructor Create;
    destructor Destroy; override;
    class function New: IAuditoriaGravacaoFaturamento;
  end;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untConstantes, SysUtils, Uni, Data.DB, untAuditoriaLog;

{ TAuditoriaGravacaoFaturamento }

function TAuditoriaGravacaoFaturamento.Adicionar(strAutoincrem,
  strTabela: String): IAuditoriaGravacaoFaturamento;
begin
  FListAutInc.Add(strAutoincrem);
  FListTabela.Add(strTabela);
end;

function TAuditoriaGravacaoFaturamento.Limpar: IAuditoriaGravacaoFaturamento;
begin
  FListAutInc.Clear;
  FListTabela.Clear;
end;

class function TAuditoriaGravacaoFaturamento.New: IAuditoriaGravacaoFaturamento;
begin
  Result := Self.Create;
end;

constructor TAuditoriaGravacaoFaturamento.Create;
begin
  FListAutInc := TList<String>.Create;
  FListTabela := TList<String>.Create;
  FFazerAuditoria := fCFgSis('UTAUFA', varBoolean);
end;

destructor TAuditoriaGravacaoFaturamento.Destroy;
begin
  FreeAndNil(FListAutInc);
  FreeAndNil(FListTabela);
  inherited;
end;

function TAuditoriaGravacaoFaturamento.fValidou(strTabela, strAutoincrem: String; blnModoRobo: Boolean): String;
const
  AUDITORIA = 'F_AUDITORIA_GRAVACAO_FATURAMENTO';
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

function TAuditoriaGravacaoFaturamento.fValidouTodas(out ACodErros: String): Boolean;
var
  intCnt : Integer;
  LAutComEmModoImportacao: Boolean;
begin
  Result := True;
  ACodErros := '';

  if not FFazerAuditoria then
    exit;

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
      break;
  end;
end;

end.
