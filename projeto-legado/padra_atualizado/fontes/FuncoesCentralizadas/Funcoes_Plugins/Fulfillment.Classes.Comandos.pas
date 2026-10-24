unit Fulfillment.Classes.Comandos;

interface

uses
  System.SysUtils, Uni;

function ExecucaoRoboPausada(const AHubMkp, ACodEmp: String): Boolean;
function ForcaRefreshCacheRobo(const AHubMkp, ACodEmp: String): Boolean;
procedure IncrementaQtdCanaisFULL_COMAND(const AHubMkp, ACodEmp, AComand: String; const AApagarCanais: Integer);

{$IFNDEF LINUX}
  var VS_ExisteTabelaFULL_COMAND: Boolean;
{$ENDIF}

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core;
{$ELSE}
  untFuncoesSimples;
{$ENDIF}

function ExecucaoRoboPausada(const AHubMkp, ACodEmp: String): Boolean;
begin
  if not VS_ExisteTabelaFULL_COMAND then
    Exit(False);

  try
    Result := fCampoTabela('1', 'FULL_COMAND',
                          ['FUL_HUBMKP', 'FUL_CODEMP', 'FUL_COMAND'],
                          [AHubMkp, ACodEmp, 'PAUSE']) = '1';
  except
    Result := False;
  end;
end;

function ForcaRefreshCacheRobo(const AHubMkp, ACodEmp: String): Boolean;
var
  qryAux: TUniQuery;
begin
  if not VS_ExisteTabelaFULL_COMAND then
    Exit(False);

  qryAux := fCriaQuery;

  try
    qryAux.SQL.Add('SELECT 1 FROM FULL_COMAND');
    qryAux.SQL.Add('WHERE FUL_HUBMKP = :HUBMKP');
    qryAux.SQL.Add('  AND FUL_CODEMP = :CODEMP');
    qryAux.SQL.Add('  AND FUL_COMAND = ''REFRESH''');
    qryAux.SQL.Add('  AND DATE(FUL_DTAINC) = CURRENT_DATE');

    qryAux.ParamByName('HUBMKP').AsString := AHubMkp;
    qryAux.ParamByName('CODEMP').AsString := ACodEmp;
    qryAux.Open;

    Result := (qryAux.RecordCount > 0);
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure IncrementaQtdCanaisFULL_COMAND(const AHubMkp, ACodEmp, AComand: String; const AApagarCanais: Integer);
var
  qryAux: TUniQuery;
begin
  if not VS_ExisteTabelaFULL_COMAND then
    Exit;

  qryAux := fCriaQuery;

  try
    try
      fStartTransaction;

      qryAux.SQL.Add('UPDATE FULL_COMAND');
      qryAux.SQL.Add('SET FUL_CANAIS = IFNULL(FUL_CANAIS, 0) +1');
      qryAux.SQL.Add('WHERE FUL_HUBMKP = :HUBMKP');
      qryAux.SQL.Add('  AND FUL_CODEMP = :CODEMP');
      qryAux.SQL.Add('  AND FUL_COMAND = :COMAND');

      qryAux.ParamByName('HUBMKP').AsString := AHubMkp;
      qryAux.ParamByName('CODEMP').AsString := ACodEmp;
      qryAux.ParamByName('COMAND').AsString := AComand;
      qryAux.ExecSQL;

      if AApagarCanais > 0 then
      begin
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('DELETE FROM FULL_COMAND');
        qryAux.SQL.Add('WHERE FUL_HUBMKP = :HUBMKP');
        qryAux.SQL.Add('  AND FUL_CODEMP = :CODEMP');
        qryAux.SQL.Add('  AND FUL_COMAND = :COMAND');
        qryAux.SQL.Add('  AND FUL_CANAIS >= :CANAIS');

        qryAux.ParamByName('HUBMKP').AsString  := AHubMkp;
        qryAux.ParamByName('CODEMP').AsString  := ACodEmp;
        qryAux.ParamByName('COMAND').AsString  := AComand;
        qryAux.ParamByName('CANAIS').AsInteger := AApagarCanais;
        qryAux.ExecSQL;
      end;

      fCommit;
    except
      fRollback;
      Raise;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

initialization
{$IFNDEF LINUX}
  VS_ExisteTabelaFULL_COMAND := False;
{$ENDIF}

end.
