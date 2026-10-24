{***************************************************************************}
{* Classe responsável por retornar as intruções DDL de uma tabela do banco *}
{************************************************************************PH*}
unit untDDLFactory;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  SysUtils, Uni, Variants, StrUtils;

type
  TDDLFactory = class(TInterfacedObject)
  private
    class var dicInsert: TDicionario;
    class function GetDicInsert(): TDicionario;
    class function MontaInsert(const strTabela: string): string;
  public
    class function GetInsert(const strTabela: string): string;
    class function GetInsertDelayed(const strTabela: string): string;
  end;

implementation


{ TDDLFatcory }

class function TDDLFactory.GetDicInsert: TDicionario;
begin
  if not Assigned(dicInsert) then
    dicInsert := TDicionario.Create;

  Result := dicInsert;  
end;

class function TDDLFactory.GetInsert(const strTabela: string): string;
var
  varValue: Variant;
begin
  varValue := GetDicInsert()[strTabela];

  If varValue = Null Then
  Begin
    Result := MontaInsert(strTabela);
    GetDicInsert()[strTabela] := Result;
  End
  Else
    Result := varValue;
end;

class function TDDLFactory.GetInsertDelayed(const strTabela: string): string;
begin
  Result := ReplaceStr(GetInsert(strTabela), 'INSERT', 'INSERT DELAYED');
end;

class function TDDLFactory.MontaInsert(const strTabela: string): string;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      if strTabela = '' then
      begin
        raise Exception.Create('Informe o nome da tabela!');
      end;

      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'DESC ' + strTabela;
      qryGen.Open;

      Result := 'INSERT INTO ' + strTabela + ' VALUES ( ';
      while not qryGen.Eof do
      begin
        Result := Result + ':' + qryGen.Fields[0].AsString + ', ';
        qryGen.Next;
      end;

      Result := LeftStr(Result, Length(Result) - 2) + ' )';

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

initialization
  TDDLFactory.dicInsert := nil;

finalization
  if Assigned(TDDLFactory.dicInsert) then FreeAndNil(TDDLFactory.dicInsert);

end.
