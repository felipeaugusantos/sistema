unit untGenericGravandoExecucaoArquivos;

interface

uses
  untAbstractGravandoExecucao, untIGravando, untIProcessadorGravandoExecucaoArquivos,
  Classes, DB, Uni, SysUtils, untFuncoesSimples, untStatusGravando, ActiveX,
  Windows, UniSQLMonitor, DASQLMonitor, StrUtils;

type
  TGenericGravandoExecucaoArquivos = class(TAbstractGravandoExecucao)
  private
    strLog: string;
    monitor: TUniSQLMonitor;
    function GetMonitor(): TUniSQLMonitor;  
    procedure pVerificaProCod(const gravando: IGravando);
    procedure Carregar(const gravando: IGravando; var qryOrigem: TDataSet; const strNomeArquivo: string; var qryDestino: TUniQuery);
    procedure Animar(const gravando: IGravando);
    procedure Logar(Sender: TObject; Text: string; Flag: TDATraceFlag);
    procedure IniciarLog;
    procedure FinalizarLog;    
  protected
    processadorGravandoExecucaoArquivos: IProcessadorGravandoExecucaoArquivos;
    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet; virtual;
    function GetDataSetDestino(): TUniQuery; virtual;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet; const gravando: IGravando); virtual;
    procedure ArquivoFormulaPadrao(const gravando: IGravando; const strNomeArquivo: string); virtual;
  public
    constructor Create(const processadorGravandoExecucaoArquivos: IProcessadorGravandoExecucaoArquivos); virtual;
    procedure Executar(const gravando: IGravando); override;
    function fGetNomeGravacao(): string; override;
  end;

  TProcedureGravandoExecucao = procedure (const gravando: IGravando) of object;
  TGetDataSetOrigem =  function (const strNomeArquivo: string): TDataSet of object;
  TGetDataSetDestino = function(): TUniQuery of object;

  TThreadCarregar = class(TThread)
  private
    GetDataSetOrigem: TGetDataSetOrigem;
    GetDataSetDestino: TGetDataSetDestino;
    strNomeArquivo: string;
    dataSetOrigem: TDataSet;
    dataSetDestino: TUniQuery;
  protected
    procedure Execute; override;
  public
    constructor Create(const GetDataSetOrigem: TGetDataSetOrigem; const GetDataSetDestino: TGetDataSetDestino;
      const strNomeArquivo: string); reintroduce;
    destructor Destroy; override;

    property Origem: TDataSet read dataSetOrigem;
    property Destino: TUniQuery read dataSetDestino;
  end;

implementation

{ TAbstractGenericGravandoExecucao }

procedure TGenericGravandoExecucaoArquivos.Animar(const gravando: IGravando);
begin
  gravando.AnimarEsperar;
  Sleep(100);
end;

procedure TGenericGravandoExecucaoArquivos.ArquivoFormulaPadrao(
  const gravando: IGravando; const strNomeArquivo: string);
begin
  processadorGravandoExecucaoArquivos.ArquivoFormulaPadrao(gravando, strNomeArquivo);
end;

procedure TGenericGravandoExecucaoArquivos.Carregar(const gravando: IGravando; var qryOrigem: TDataSet; const strNomeArquivo: string; var qryDestino: TUniQuery);
var
  threadCarregar: TThreadCarregar;
begin
  threadCarregar := nil;
  Try
    Try
      threadCarregar := TThreadCarregar.Create(GetDataSetOrigem, GetDataSetDestino, strNomeArquivo);
      
      while not threadCarregar.Terminated do
      begin
        if gravando.Status in [sgCancelado, sgFinalizado] then
        begin
          threadCarregar.Terminate;
          TerminateThread(threadCarregar.Handle, 0);
        end
        else
          Animar(gravando);
      end;

      threadCarregar.WaitFor;
      qryOrigem := threadCarregar.Origem;
      qryDestino := threadCarregar.Destino;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(threadCarregar) then FreeAndNil(threadCarregar);
  End;
end;

constructor TGenericGravandoExecucaoArquivos.Create(const processadorGravandoExecucaoArquivos: IProcessadorGravandoExecucaoArquivos);
begin
  inherited Create();
  Self.processadorGravandoExecucaoArquivos := processadorGravandoExecucaoArquivos;
  Self.monitor := nil;  
end;

procedure TGenericGravandoExecucaoArquivos.Executar(const gravando: IGravando);
var
  qryOrigem: TDataSet;
  strNomeArquivo: string;
  qryDestino: TUniQuery;
  stlArquivos: TStringList;
begin
  qryOrigem := nil;
  stlArquivos := nil;
  Try
    Try
      pVerificaProCod(gravando);

      stlArquivos := TStringList.Create;
      processadorGravandoExecucaoArquivos.GetArquivosProcessar(stlArquivos);
      processadorGravandoExecucaoArquivos.LimparTabelas;

      for strNomeArquivo in stlArquivos do
      begin
        Try
          Try
            if (gravando.Status <> sgGravando) then
              Break;
              
            if not FileExists(AnsiReplaceStr(strNomeArquivo, '"', '')) then
            begin
              gravando.Texto := Format('O arquivo [%s] não existe, ou não foi encontrado!', [AnsiReplaceStr(strNomeArquivo, '"', '')]);
              Continue;
            end;

            gravando.Texto := Format('Abrindo arquivo [%s]', [AnsiReplaceStr(strNomeArquivo, '"', '')]);
            Carregar(gravando, qryOrigem, AnsiReplaceStr(strNomeArquivo, '"', ''), qryDestino);

            ArquivoFormulaPadrao(gravando, AnsiReplaceStr(strNomeArquivo, '"', ''));

            if (gravando.Status <> sgGravando) then
              Break;
              
            gravando.Texto := 'Arquivo aberto com sucesso!';

            gravando.Texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(strNomeArquivo, '"', '')]);
            gravando.RegistrarProgresso(0, 0, 0);

            while (not qryOrigem.Eof) and (gravando.Status = sgGravando) do
            begin
              Try
                Try
                  if not processadorGravandoExecucaoArquivos.IsRegistroExistente(qryOrigem, qryDestino) then
                  begin
                    IniciarLog;
                    GravarRegistro(qryOrigem, qryDestino, gravando);
                    FinalizarLog;
                  end;
                Except
                  on E: Exception do
                  begin
                    processadorGravandoExecucaoArquivos.RegistrarImpossivelGravarRegistro(E, gravando, qryOrigem, qryDestino);
                    gravando.Texto := strLog + sLineBreak;
                  end;
                End;
              Finally
                qryOrigem.Next;
                gravando.RegistrarProgresso(1, qryOrigem.RecNo, qryOrigem.RecordCount);
              End;
            end;
            gravando.Texto := Format('Arquivo [%s] processado com sucesso!', [AnsiReplaceStr(strNomeArquivo, '"', '')]);
          Except
            on E: Exception do
            begin
              gravando.Texto := Format('Não foi possivel processar o arquivo [%s][%s: %s]',
                [AnsiReplaceStr(strNomeArquivo, '"', ''), E.ClassName, E.Message]);
              Continue;
            end;
          End;
        Finally
          if Assigned(qryOrigem) then FreeAndNil(qryOrigem);
          if Assigned(qryDestino) then FreeAndNil(qryDestino);
        End;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryOrigem) then FreeAndNil(qryOrigem);
    if Assigned(qryDestino) then FreeAndNil(qryDestino);
    if Assigned(stlArquivos) then FreeAndNil(stlArquivos);
  End;
end;

function TGenericGravandoExecucaoArquivos.fGetNomeGravacao: string;
begin
  Result := processadorGravandoExecucaoArquivos.fGetNomeGravacao;
end;

function TGenericGravandoExecucaoArquivos.GetDataSetDestino(): TUniQuery;
begin
  Result := fCriaQuery();
  Result.SQL.Text := processadorGravandoExecucaoArquivos.GetSqlDestino;
  Result.Open;
end;

function TGenericGravandoExecucaoArquivos.GetDataSetOrigem(const strNomeArquivo: string): TDataSet;
begin
  Result := processadorGravandoExecucaoArquivos.GetDataSetOrigem(strNomeArquivo);
  Result.Open;
end;

procedure TGenericGravandoExecucaoArquivos.pVerificaProCod(const gravando: IGravando);
var
  stlTabelas: TStringList;
  strTabela: string;
begin
  stlTabelas := nil;
  Try
    Try
      stlTabelas := TStringList.Create;
      processadorGravandoExecucaoArquivos.GetTabelasVerificaProCod(stlTabelas);
      gravando.Texto := 'Verificando PROCOD';
      for strTabela in stlTabelas do
        fInsereProCod(strTabela);
      gravando.Texto := 'PROCOD Verificado com sucesso!';
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlTabelas) then FreeAndNil(stlTabelas);
  End;                              
end;

{ TThreadCarregar }

constructor TThreadCarregar.Create(const GetDataSetOrigem: TGetDataSetOrigem; const GetDataSetDestino: TGetDataSetDestino;
  const strNomeArquivo: string);
begin
  inherited Create(False);

  Self.GetDataSetOrigem := GetDataSetOrigem;
  Self.GetDataSetDestino := GetDataSetDestino;
  Self.strNomeArquivo := strNomeArquivo;
end;

destructor TThreadCarregar.Destroy;
begin

  inherited;
end;

procedure TThreadCarregar.Execute;
begin
  Try
    CoInitializeEx(nil, COINIT_MULTITHREADED);
    Self.dataSetOrigem := GetDataSetOrigem(strNomeArquivo);
    Self.dataSetDestino := GetDataSetDestino;
  Finally
    CoUninitialize;
    Terminate;
  End;
end;

procedure TGenericGravandoExecucaoArquivos.FinalizarLog;
begin
  GetMonitor.Active := False;
end;

function TGenericGravandoExecucaoArquivos.GetMonitor: TUniSQLMonitor;
begin
  if not Assigned(monitor) then
  begin
    monitor := TUniSQLMonitor.Create(nil);
    monitor.OnSQL := Logar;
  end;

  Result := monitor;   
end;

procedure TGenericGravandoExecucaoArquivos.IniciarLog;
begin
  GetMonitor.Active := False;
  strLog := '';
  GetMonitor.Active := True;
end;

procedure TGenericGravandoExecucaoArquivos.Logar(Sender: TObject;
  Text: string; Flag: TDATraceFlag);
begin
  strLog := Trim(Trim(strLog) + sLineBreak + Text);
end;

procedure TGenericGravandoExecucaoArquivos.GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet; const gravando: IGravando);
begin
  processadorGravandoExecucaoArquivos.GravarRegistro(qryOrigem, qryDestino);
end;

end.
