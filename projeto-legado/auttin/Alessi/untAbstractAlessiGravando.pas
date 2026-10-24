unit untAbstractAlessiGravando;

interface

uses
  untIGravandoExecucao, untIGravando, Classes, SysUtils, untIConfTinta, ADODB;

type
  TAbstractAlessiGravando = class(TInterfacedObject, IGravandoExecucao) 
  protected
    conf: IConfTinta;
    stlArquivos: TStringList;
    stlUnidades: TStringList;
  protected
    function GetUnidade(strProduto, strUnidade: string): string;
    function GetQuery(strNomeArquivo: string; stlPlanilhas: TStrings = nil) : TADOQuery;
  private
    procedure ObterNomesArquivos;
  public
    procedure Executar(const gravando: IGravando); virtual; abstract;
  public
    constructor Create(); virtual;
    destructor Destroy; override;
  end;

implementation

uses untFuncoesSimples, untFuncTinta;

{ TAlessiGravandoFormulas }

constructor TAbstractAlessiGravando.Create;
begin
  inherited Create;
  stlArquivos := TStringList.Create;
  conf := fGetConfTinta('ALE');
  stlUnidades := TStringList.Create;
  ObterNomesArquivos;
end;

destructor TAbstractAlessiGravando.Destroy;
begin
  if Assigned(stlArquivos) then FreeAndNil(stlArquivos);
  if Assigned(stlUnidades) then FreeAndNil(stlUnidades);  
  conf := nil;
  inherited Destroy;
end;

function TAbstractAlessiGravando.GetQuery(strNomeArquivo: string; stlPlanilhas: TStrings): TADOQuery;
var
  conGen: TADOConnection;
begin
  Result := nil;
  conGen := nil;
  Try
    Try
      Result := TADOQuery.Create(nil);
      Result.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;' +
        'Data Source=' + strNomeArquivo +
        ';Mode=Share Deny None;Extended Properties=Excel 8.0;Jet OLEDB:System database="";' +
        'Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=35;' +
        'Jet OLEDB:Database Locking Mode=0;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:' +
        'Global Bulk Transactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:' +
        'Create System Database=False;Jet OLEDB:Encrypt Database=False;' +
        'Jet OLEDB:Don''t Copy Locale on Compact=False;Jet OLEDB:Compact Without Replica Repair=False;' +
        'Jet OLEDB:SFP=False;IMEX=1';

      if Assigned(stlPlanilhas) then
      begin
        conGen := TADOConnection.Create(nil);
        conGen.LoginPrompt := False;
        conGen.ConnectionString := Result.ConnectionString;
        conGen.GetTableNames(stlPlanilhas);
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(conGen) then FreeAndNil(conGen);
  End;

end;

function TAbstractAlessiGravando.GetUnidade(strProduto, strUnidade: string): string;
begin
  if Pos('GEL', UpperCase(strProduto)) > 0 then
  begin
    if strUnidade = 'GL' then
    begin
      if fEmptyStr(stlUnidades.Values['UNIGELGL']) then
        stlUnidades.Values['UNIGELGL'] := conf.fGet('UNIGELGL');

      Result := stlUnidades.Values['UNIGELGL'];
    end
    else if strUnidade = 'QT' then
    begin
      if fEmptyStr(stlUnidades.Values['UNIGELQT']) then
        stlUnidades.Values['UNIGELQT'] := conf.fGet('UNIGELQT');

      Result := stlUnidades.Values['UNIGELQT'];
    end;
  end
  else if Pos('TEXTURA', UpperCase(strProduto)) > 0 then
  begin
    if strUnidade = 'GL' then
    begin
      if fEmptyStr(stlUnidades.Values['UNITXGL']) then
        stlUnidades.Values['UNITXGL'] := conf.fGet('UNITXGL');

      Result := stlUnidades.Values['UNITXGL'];
    end
    else if strUnidade = 'LA' then
    begin
      if fEmptyStr(stlUnidades.Values['UNITXLA']) then
        stlUnidades.Values['UNITXLA'] := conf.fGet('UNITXLA');

      Result := stlUnidades.Values['UNITXLA'];
    end;
  end
  else
  begin
    if strUnidade = 'QT' then
    begin
      if fEmptyStr(stlUnidades.Values['UNIQUA']) then
        stlUnidades.Values['UNIQUA'] := conf.fGet('UNIQUA');

      Result := stlUnidades.Values['UNIQUA'];
    end
    else if strUnidade = 'GL' then
    begin
      if fEmptyStr(stlUnidades.Values['UNIGL']) then
        stlUnidades.Values['UNIGL'] := conf.fGet('UNIGL');

      Result := stlUnidades.Values['UNIGL'];
    end
    else if strUnidade = 'LA' then
    begin
      if fEmptyStr(stlUnidades.Values['UNILA']) then
        stlUnidades.Values['UNILA'] := conf.fGet('UNILA');

      Result := stlUnidades.Values['UNILA'];
    end
  end;
end;

procedure TAbstractAlessiGravando.ObterNomesArquivos;
var
  strDiretorio: string;
  shrRec: TSearchRec;
begin
  Try
    Try
      strDiretorio := conf.fGet('ALEPAT') + '\*.xls';
      if FindFirst(strDiretorio, faAnyFile, shrRec) = 0 then
      begin
        repeat
          if ExtractFileExt(shrRec.Name) = '.xls' then
            stlArquivos.Add(conf.fGet('ALEPAT') + '\' + shrRec.Name);
        until FindNext(shrRec) <> 0;
      end;
      
    Except
      on E: Exception do
      begin
        raise E.Create('Não foi possivel obter os nomes de arquivos');
      end;
    End;
  Finally

  End;
end;

end.
