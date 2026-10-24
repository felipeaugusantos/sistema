unit untAuditoriaGravacaoResumoCaixa;

interface

uses Generics.Collections;

{$IFNDEF LINUX}
type
  IAuditoriaGravacaoResumoCaixa = interface
    function Adicionar(AAutoincrem: string; ATabela: String): IAuditoriaGravacaoResumoCaixa;
    function Limpar: IAuditoriaGravacaoResumoCaixa;
    function ValidouTodas(out ACodErros: String): Boolean;
  end;


  TAuditoriaGravacaoResumoCaixa = class(TInterfacedObject, IAuditoriaGravacaoResumoCaixa)
  private
    FFazerAuditoria : boolean;
    FTListAutInc : TList<String>;
    FTListTabela : TList<String>;
    function Validou(ATabela, AAutoincrem: String; AModoRobo: Boolean): String;
  public
    function Adicionar(AAutoincrem: string; ATabela: String): IAuditoriaGravacaoResumoCaixa;
    function Limpar: IAuditoriaGravacaoResumoCaixa;
    function ValidouTodas(out ACodErros: String): Boolean;
    constructor Create;
    destructor Destroy; override;
    class function New: IAuditoriaGravacaoResumoCaixa;
  end;
{$ENDIF}



implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untConstantes, SysUtils, Uni, Data.DB, untAuditoriaLog;

{ TAuditoriaGravacaoResumoCaixa }

{$IFNDEF LINUX}
function TAuditoriaGravacaoResumoCaixa.Adicionar(AAutoincrem, ATabela: String): IAuditoriaGravacaoResumoCaixa;
begin
  FTListAutInc.Add(AAutoincrem);
  FTListTabela.Add(ATabela);
end;
{$ENDIF}

{$IFNDEF LINUX}
constructor TAuditoriaGravacaoResumoCaixa.Create;
begin
  FTListAutInc := TList<String>.Create;
  FTListTabela := TList<String>.Create;
  FFazerAuditoria := fCFgSis('UTAUFA', varBoolean);
end;
{$ENDIF}

{$IFNDEF LINUX}
destructor TAuditoriaGravacaoResumoCaixa.Destroy;
begin
  FreeAndNil(FTListAutInc);
  FreeAndNil(FTListTabela);
  inherited;
end;
{$ENDIF}

{$IFNDEF LINUX}
function TAuditoriaGravacaoResumoCaixa.Limpar: IAuditoriaGravacaoResumoCaixa;
begin
  FTListAutInc.Clear;
  FTListTabela.Clear;
end;
{$ENDIF}

{$IFNDEF LINUX}
class function TAuditoriaGravacaoResumoCaixa.New: IAuditoriaGravacaoResumoCaixa;
begin
  Result := Self.Create;
end;
{$ENDIF}

{$IFNDEF LINUX}
function TAuditoriaGravacaoResumoCaixa.Validou(ATabela, AAutoincrem: String; AModoRobo: Boolean): String;
const
  AUDITORIA = 'F_AUDITORIA_GRAVACAO_RESUMO_CAIXA';
var
  qryFunction : TUniQuery;
begin
  Result := '';

  qryFunction := fCriaQuery;

  try
    try
      qryFunction.SQL.Text := 'SELECT '+AUDITORIA+'(:TABELA, :AUTOINCREM, :MODO_ROBO);';
      qryFunction.ParamByName('TABELA').AsString     := ATabela;
      qryFunction.ParamByName('AUTOINCREM').AsString := AAutoincrem;
      qryFunction.ParamByName('MODO_ROBO').AsInteger := IIF(AModoRobo, 1, 0);
      qryFunction.Open;

      if (not qryFunction.IsEmpty) and (qryFunction.Fields[0].AsString <> '0') then
        Result := qryFunction.Fields[0].AsString;

      If fCfgSis('AUDLOG', varBoolean) Then
        TAuditoriaLog.New()
          .setAuditoria(AUDITORIA)
          .setParametro(ATabela + '|' + AAutoincrem + '|' + IIF(AModoRobo, '1', '0'))
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
{$ENDIF}

{$IFNDEF LINUX}
function TAuditoriaGravacaoResumoCaixa.ValidouTodas(out ACodErros: String): boolean;
var
  AContador: Integer;
  LAutComEmModoImportacao: Boolean;
begin
  Result    := True;
  ACodErros := '';

  if not FFazerAuditoria then
    Exit;

{$IFDEF LINUX}
  LAutComEmModoImportacao := False;
{$ELSE}
  LAutComEmModoImportacao := fAutComEmModoImportacao;
{$ENDIF}

  for AContador := 0 to Pred(FTListAutInc.Count) do
  begin
    ACodErros := Validou(FTListTabela[AContador], FTListAutInc[AContador], LAutComEmModoImportacao);
    Result    := fEmptyStr(ACodErros);

    if (not Result) then
      Break;
  end;
end;
{$ENDIF}

end.
