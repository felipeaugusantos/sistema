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
unit untSQLBind;

interface

uses Classes;

function fSQLBind(obj: TObject): String;

implementation

uses Uni, DB, Forms, StrUtils, Windows, SysUtils, UniClientDataSet, untSQLBind_Query;

function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
begin
   if lTest then
     Result := vExpr1
   else
     Result := vExpr2
end;

procedure pCarregaCdsProperties(cdsOri, cdsPrp: TUniClientDataSet);
begin
  cdsPrp.Insert;
  cdsPrp.FieldByName('CDS_PROPRE').AsString := 'IndexFieldNames';
  cdsPrp.FieldByName('CDS_VALOR_').AsString := cdsOri.IndexFieldNames;
  cdsPrp.Post;

  cdsPrp.Insert;
  cdsPrp.FieldByName('CDS_PROPRE').AsString := 'Filter';
  cdsPrp.FieldByName('CDS_VALOR_').AsString := cdsOri.Filter;
  cdsPrp.Post;

  cdsPrp.Insert;
  cdsPrp.FieldByName('CDS_PROPRE').AsString := 'Filtered';
  cdsPrp.FieldByName('CDS_VALOR_').AsString := IIF(cdsOri.Filtered, 'True', 'False');
  cdsPrp.Post;

  cdsPrp.Insert;
  cdsPrp.FieldByName('CDS_PROPRE').AsString := 'RecNo';
  cdsPrp.FieldByName('CDS_VALOR_').AsString := IntToStr(cdsOri.RecNo);
  cdsPrp.Post;
end;

function fSQLBind(obj: TObject): String;
  Var
    strPath: String;
    cdsAux: TUniClientDataSet;
    cdsPrp: TUniClientDataSet;
begin
  If obj = nil Then
    Exit;

  strPath := ExtractFilePath(Application.ExeName) + 'fontes\SQLBind\';

  Result := '^^';

  Try
    If obj Is TUniQuery Then
    Begin
      TfrmSQLBind_Query.pBind(TUniQuery(obj));
    End

    Else If obj Is TUniClientDataSet Then
    Begin
      cdsAux := TUniClientDataSet.Create(Nil);
      cdsPrp := TUniClientDataSet.Create(Nil);
      With cdsPrp.FieldDefs.AddFieldDef Do Begin Name := 'CDS_PROPRE'; DataType := ftString; Size := 255; Required := False; End;
      With cdsPrp.FieldDefs.AddFieldDef Do Begin Name := 'CDS_VALOR_'; DataType := ftMemo;                Required := False; End;
      cdsPrp.CreateDataSet;
      cdsPrp.Open;
      Try
        pCarregaCdsProperties(TUniClientDataSet(obj), cdsPrp);
        cdsAux.Data := TUniClientDataSet(obj).Data;
        WriteComponentResFile(strPath + 'cds.res', cdsAux);
        WriteComponentResFile(strPath + 'prp.res', cdsPrp);
        If (Not FileExists(strPath + 'CDSViewer.exe')) And (FileExists(strPath + 'CDSViewer.rar')) Then
        Begin
          Result := 'CDSViewer.exe não encontrado. Descompacte o arquivo "CDSViewer.rar" '+
                    'encontrado em: ' + strPath + ' dentro do próprio diretório onde ele se encontra!';
        End
        Else
        Begin
          WinExec(pAnsiChar(AnsiString(strPath + 'CDSViewer.exe')), SW_SHOWNORMAL);
        End;
      Finally
        cdsAux.Free;
        cdsPrp.Free;
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

