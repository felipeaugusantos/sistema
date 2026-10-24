unit untAuditoriaGravacaoConsertoEquip;

interface

uses Generics.Collections;

type
  IAuditoriaGravacaoConsertoEquip = interface
    ['{54D5FA46-6F96-43D0-AB03-D16AA6C28D26}']
    function Adicionar(strAutoincrem: string; strTabela: String): IAuditoriaGravacaoConsertoEquip;
    function Limpar: IAuditoriaGravacaoConsertoEquip;
    function fValidouTodas(out ACodErros: String): boolean;
  end;

  TAuditoriaGravacaoConsertoEquip = class(TInterfacedObject, IAuditoriaGravacaoConsertoEquip)
  private
    FFazerAuditoria : boolean;
    FListAutInc : TList<String>;
    FListTabela : TList<String>;
    function fValidou(strTabela, strAutoincrem: String; blnModoRobo: Boolean): String;
  public
    function Adicionar(strAutoincrem: string; strTabela: String): IAuditoriaGravacaoConsertoEquip;
    function Limpar: IAuditoriaGravacaoConsertoEquip;
    function fValidouTodas(out ACodErros: String): boolean;

    constructor Create;
    destructor Destroy; override;

    class function New: IAuditoriaGravacaoConsertoEquip;
  end;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untConstantes, SysUtils, Uni, Data.DB;

{ TAuditoriaGravacaoConsertoEquip }

function TAuditoriaGravacaoConsertoEquip.Adicionar(strAutoincrem,
  strTabela: String): IAuditoriaGravacaoConsertoEquip;
begin
  FListAutInc.Add(strAutoincrem);
  FListTabela.Add(strTabela);
end;

constructor TAuditoriaGravacaoConsertoEquip.Create;
begin
  FListAutInc := TList<String>.Create;
  FListTabela := TList<String>.Create;
  FFazerAuditoria := fCFgSis('UTAUFA', varBoolean);
end;

destructor TAuditoriaGravacaoConsertoEquip.Destroy;
begin
  FreeAndNil(FListAutInc);
  FreeAndNil(FListTabela);
  inherited;
end;

function TAuditoriaGravacaoConsertoEquip.fValidou(strTabela, strAutoincrem: String; blnModoRobo: Boolean): String;
var
  qryFunction : TUniQuery;
begin
  Result := '';

  qryFunction := fCriaQuery;

  try
    try
      qryFunction.SQL.Text := 'SELECT F_AUDITORIA_GRAVACAO_FATURAMENTO(:TABELA, :AUTOINCREM, :MODO_ROBO);';
      qryFunction.ParamByName('TABELA').AsString := strTabela;
      qryFunction.ParamByName('AUTOINCREM').AsString := strAutoincrem;
      qryFunction.ParamByName('MODO_ROBO').AsInteger := IIF(blnModoRobo, 1, 0);
      qryFunction.Open;

      if (not qryFunction.IsEmpty) and (qryFunction.Fields[0].AsString <> '0') then
        Result := qryFunction.Fields[0].AsString;
    except
      on E: Exception do
        Result := '';
    end;
  finally
    FreeAndNil(qryFunction);
  end;
end;

function TAuditoriaGravacaoConsertoEquip.fValidouTodas(out ACodErros: String): Boolean;
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
      break;
  end;
end;

function TAuditoriaGravacaoConsertoEquip.Limpar: IAuditoriaGravacaoConsertoEquip;
begin
  FListAutInc.Clear;
  FListTabela.Clear;
end;

class function TAuditoriaGravacaoConsertoEquip.New: IAuditoriaGravacaoConsertoEquip;
begin
  Result := Self.Create;
end;

end.
