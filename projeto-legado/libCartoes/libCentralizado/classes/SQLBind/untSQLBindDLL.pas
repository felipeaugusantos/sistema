{***************************************************************************}
{* Ferramenta facility para obtenção de SQL com os valores dos bind.       *}
{* Uso:                                                                    *}
{* Em debug time utilizar o "CTRL + F7" do Delphi digitando "pSQLBind(qry)"*}
{* onde qry seja a TUniQuery que deseja obter o SQL.                         *}
{* Aparecerá uma janela com o SQL, onde pode ser realizado consultas SQL,  *}
{* assim como é possível executar UPDATES, INSERTS e DELETES, porém estes  *}
{* não serão comitados, a menos que seja executado o comando "COMMIT;".    *}
{* Para continuar o debug normalmente é só fechar a janela e continuar     *}
{* debugando.                                                              *}
{***************************************************************************}
unit untSQLBindDLL;

interface

uses Classes;

function fSQLBind(obj: TObject): String;

implementation

uses Uni, DB, Forms, StrUtils, Windows, SysUtils, UniClientDataSet, untSQLBind_QueryDLL;

function fSQLBind(obj: TObject): String;
  Var
    strPath: String;
    cdsAux: TUniClientDataSet;
begin
  If obj = nil Then
    Exit;

  strPath := ExtractFilePath(Application.ExeName) + 'fontes\SQLBind\';

  Result := '^^';

  Try
    If obj Is TUniQuery Then
    Begin
      TfrmSQLBind_QueryDLL.pBind(TUniQuery(obj));
    End

    Else If obj Is TUniClientDataSet Then
    Begin
      cdsAux := TUniClientDataSet.Create(Nil);
      Try
        cdsAux.Data := TUniClientDataSet(obj).Data;
        WriteComponentResFile(strPath + 'cds.res', cdsAux);
        WinExec(pAnsiChar(AnsiString(strPath + 'CDSViewer.exe')), SW_SHOWNORMAL);
      Finally
        cdsAux.Free;
      End;
    End

    Else
      Result := obj.ClassName + ' Ainda não é suportado pelo SQLBind! Sinta-se a vontade para desenvolver o suporte! ;D';
  Except
    On E:Exception Do
      Result := E.Message;
  End;
end;

// Para não ser eliminado pelo linker
initialization
  //..
finalization
  fSQLBind(nil);
End.

// now()
/// now