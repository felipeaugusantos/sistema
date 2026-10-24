unit untAbstractAdoProcessadorGravandoExecucaoArquivos;

interface

uses
  untIProcessadorGravandoExecucaoArquivos, DB, ADODB, Classes, SysUtils,
  untIGravando,  Uni;

type
  TAbstractAdoProcessadorGravandoExecucaoArquivos = class abstract (TInterfacedObject, IProcessadorGravandoExecucaoArquivos)
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; virtual; abstract;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery; virtual;
    procedure TruncateTable(const strNomeTabela: string);
    class function LimpaTexto(const strTexto: string): string;
    procedure GetTabelas(const qryOrigem: TADOQuery; const stlTabelas: TStrings);
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); virtual; abstract;
    procedure GetArquivosProcessar(const stlArquivos: TStrings); virtual; abstract;
    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet; virtual;
    function GetSqlDestino(): string; virtual; abstract;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; virtual; abstract;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); virtual; abstract;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); virtual; abstract;
    function fGetNomeGravacao(): string; virtual; abstract;
    procedure LimparTabelas; virtual;
    procedure ArquivoFormulaPadrao(const gravando: IGravando; const strNomeArquivo: string); virtual;
  end;

implementation

uses untFuncoesSimples, untADOFactory;

{ TAbstractAdoProcessadorGravandoExecucao }

procedure TAbstractAdoProcessadorGravandoExecucaoArquivos.ArquivoFormulaPadrao(
  const gravando: IGravando; const strNomeArquivo: string);
begin

end;

function TAbstractAdoProcessadorGravandoExecucaoArquivos.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
begin
  Result := TADOFactory.GetExcelQuery12(strNomeArquivo);
end;

function TAbstractAdoProcessadorGravandoExecucaoArquivos.GetDataSetOrigem(const strNomeArquivo: string): TDataSet;
var
  strArquivo: string;
  stlTabelas: TStringList;
begin
  stlTabelas := nil;
  Result     := nil;
  Try
    Try
      stlTabelas := TStringList.Create;
      strArquivo := strNomeArquivo;
      Result := GetAdoQuery(strArquivo);
      GetTabelas(TADOQuery(Result), stlTabelas);
      TADOQuery(Result).SQL.Text := GetSqlOrigem(strArquivo, stlTabelas);
    Except
      on E: EAbstractError do
      begin
        raise Exception.CreateFmt('[%s] %s', [Self.ClassName, E.Message]);
      end;

      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlTabelas) then FreeAndNil(stlTabelas);
  End;
end;

procedure TAbstractAdoProcessadorGravandoExecucaoArquivos.GetTabelas(const qryOrigem: TADOQuery; const stlTabelas: TStrings);
var
  conOrigem: TADOConnection;
begin
  conOrigem := nil;
  Try
    Try
      conOrigem := TADOConnection.Create(qryOrigem);
      conOrigem.ConnectionString := qryOrigem.ConnectionString;
      conOrigem.LoginPrompt := False;
      conOrigem.Open();
      conOrigem.GetTableNames(stlTabelas);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(conOrigem) then FreeAndNil(conOrigem);
  End;                              
end;

procedure TAbstractAdoProcessadorGravandoExecucaoArquivos.LimparTabelas;
begin

end;

class function TAbstractAdoProcessadorGravandoExecucaoArquivos.LimpaTexto(const strTexto: string): string;
begin
  Result := Trim(AnsiUpperCase(fRemoveAcento(strTexto)));
end;

procedure TAbstractAdoProcessadorGravandoExecucaoArquivos.TruncateTable(const strNomeTabela: string);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'TRUNCATE TABLE ' + strNomeTabela;
      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise Exception.CreateFmt('Impossivel limpar a tabela %s. [%s: %s]', [strNomeTabela, E.ClassName, E.Message]);
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

end.
