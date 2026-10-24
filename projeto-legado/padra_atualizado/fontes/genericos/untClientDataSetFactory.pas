unit untClientDataSetFactory;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, UniClientDataSet, UniDataSetProvider,
{$ENDIF}
  Uni;

type
  TClientDataSetFactory = class(TInterfacedObject)
  private
    class var dicQuerys: TDicionario;
    class function GetDicQuerys: TDicionario;
    class function GetChaveQuery(const qryGen: TUniQuery): string;
    class function GetMd5Params(const qryGen: TUniQuery): string;
    class function GetMd5ParamsValues(const qryGen: TUniQuery): string;
    class procedure LimparClients;
  public
    class function GetClientDataSet(const qryGen: TUniQuery): TUniClientDataSet;
  end;

implementation

uses SysUtils, Variants, System.Classes;

var
  FMREW: TMultiReadExclusiveWriteSynchronizer;

{ TClientDataSetFactory }

class function TClientDataSetFactory.GetClientDataSet(const qryGen: TUniQuery): TUniClientDataSet;
var
  strChave: string;
  dspGen: TUniDataSetProvider;
begin
  FMREW.BeginWrite;
  try
    dspGen := nil;
    Result := GetDicQuerys.RetornaObjeto(strChave) as TUniClientDataSet;
    Try
      Try
        strChave := GetChaveQuery(qryGen);

        if not Assigned(Result) then
        begin
          if qryGen.Active then
          Begin
            pSetaClient(qryGen);
            qryGen.First;
          End;

          Result := TUniClientDataSet.Create(nil);
          dspGen := TUniDataSetProvider.Create(Result);
          dspGen.DataSet := qryGen;
          Result.Data := dspGen.Data;
          pSetaClient(Result);
          GetDicQuerys.AdicionarObjeto(strChave, Result);
        end;

        Result.Active := True;
        Result.First;
      Except
        on E: Exception do
        begin
          raise;
        end;
      End;
    Finally
      if Assigned(dspGen) then FreeAndNil(dspGen);
    End;
  finally
    FMREW.EndWrite;
  end;
end;

class function TClientDataSetFactory.GetChaveQuery(const qryGen: TUniQuery): string;
begin
  Result := GetMD5(qryGen.SQL.Text);
  Result := Result + GetMd5Params(qryGen);
  Result := Result + GetMd5ParamsValues(qryGen);
  Result := GetMD5(Result);  
end;

class function TClientDataSetFactory.GetDicQuerys: TDicionario;
begin
  if not Assigned(dicQuerys) then
    dicQuerys := TDicionario.Create;
  Result := dicQuerys;
end;

class function TClientDataSetFactory.GetMd5Params(const qryGen: TUniQuery): string;
var
  intCont: Integer;
begin
  Result := '';
  for intCont := 0 to qryGen.Params.Count - 1 do
  begin
    Result := Result + GetMD5(qryGen.Params.Items[intCont].Name);
  end;

  Result := GetMD5(Result);
end;

class function TClientDataSetFactory.GetMd5ParamsValues(const qryGen: TUniQuery): string;
var
  intCont: Integer;
begin
  Result := '';
  for intCont := 0 to qryGen.Params.Count - 1 do
  begin
    Result := Result + GetMD5(VarToStrDef(qryGen.Params.Items[intCont].Value, ''));
  end;

  Result := GetMD5(Result);
end;

class procedure TClientDataSetFactory.LimparClients;
var
  strChave: string;
begin
  for strChave in dicQuerys.Chaves do
  begin
    dicQuerys.RetornaObjeto(strChave).Free;
    dicQuerys.Remove(strChave);
  end;
end;

initialization
  TClientDataSetFactory.dicQuerys := nil;
  FMREW := TMultiReadExclusiveWriteSynchronizer.Create;

finalization
  if Assigned(TClientDataSetFactory.dicQuerys) then
  begin
    TClientDataSetFactory.LimparClients;
    FreeAndNil(TClientDataSetFactory.dicQuerys);
  end;
  FMREW.Free;
end.
