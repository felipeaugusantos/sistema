unit untGenericGravandoExecucao;

interface

uses
  untAbstractGravandoExecucao, untIGravando, untIProcessadorGravandoExecucao,
  Classes, DB, Uni, SysUtils, UniSQLMonitor;

type
  TGenericGravandoExecucao = class(TAbstractGravandoExecucao)
  private
    strLog: string;
    monitor: TUniSQLMonitor;
    function GetMonitor(): TUniSQLMonitor;
    procedure pVerificaProCod(const gravando: IGravando);
    procedure IniciarLog;
    procedure FinalizarLog;    
  protected
    processadorGravandoExecucao: IProcessadorGravandoExecucao;
  public
    constructor Create(const processadorGravandoExecucao: IProcessadorGravandoExecucao);
    procedure Executar(const gravando: IGravando); override;
    function fGetNomeGravacao(): string; override;
  end;

implementation

uses untFuncoesSimples, untStatusGravando;

{ TAbstractGenericGravandoExecucao }

constructor TGenericGravandoExecucao.Create(const processadorGravandoExecucao: IProcessadorGravandoExecucao);
begin
  inherited Create();
  Self.processadorGravandoExecucao := processadorGravandoExecucao;
  Self.monitor := nil;  
end;

procedure TGenericGravandoExecucao.Executar(const gravando: IGravando);
var
  qryOrigem: TDataSet;
  qryDestino: TUniQuery;
begin
  qryOrigem := nil;
  Try
    Try
      pVerificaProCod(gravando);
      processadorGravandoExecucao.LimparTabelas;

      Try
        gravando.Texto := 'Carregando dados...';
        qryOrigem := processadorGravandoExecucao.GetDataSetOrigem();
        qryOrigem.Open;

        qryDestino := fCriaQuery();
        qryDestino.SQL.Text := processadorGravandoExecucao.GetSqlDestino;
        qryDestino.Open;
        gravando.Texto := 'Dados carregados com sucesso!';
        gravando.Texto := 'Processando ' + processadorGravandoExecucao.fGetNomeGravacao + '...';
        gravando.RegistrarProgresso(0, 0, 0);
        while (not qryOrigem.Eof) and (gravando.Status = sgGravando) do
        begin
          Try
            Try
              if not processadorGravandoExecucao.IsRegistroExistente(qryOrigem, qryDestino) then
              begin
                IniciarLog;
                processadorGravandoExecucao.GravarRegistro(qryOrigem, qryDestino);
                FinalizarLog;
              end;
            Except
              on E: Exception do
              begin
                processadorGravandoExecucao.RegistrarImpossivelGravarRegistro(E, gravando, qryOrigem, qryDestino);
                gravando.Texto := strLog + sLineBreak;
              end;
            End;
          Finally
            qryOrigem.Next;
            gravando.RegistrarProgresso(1, qryOrigem.RecNo, qryOrigem.RecordCount);
          End;
        end;
      Finally
        if Assigned(qryOrigem) then FreeAndNil(qryOrigem);
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryOrigem) then FreeAndNil(qryOrigem);
    if Assigned(qryDestino) then FreeAndNil(qryDestino);
  End;
end;

function TGenericGravandoExecucao.fGetNomeGravacao: string;
begin
  Result := processadorGravandoExecucao.fGetNomeGravacao;
end;

procedure TGenericGravandoExecucao.FinalizarLog;
begin
  GetMonitor.Active := False;
end;

procedure TGenericGravandoExecucao.pVerificaProCod(const gravando: IGravando);
var
  stlTabelas: TStringList;
  strTabela: string;
begin
  stlTabelas := nil;
  Try
    Try
      stlTabelas := TStringList.Create;
      processadorGravandoExecucao.GetTabelasVerificaProCod(stlTabelas);
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

function TGenericGravandoExecucao.GetMonitor: TUniSQLMonitor;
begin
  if not Assigned(monitor) then
  begin
    monitor := TUniSQLMonitor.Create(nil);
  end;

  Result := monitor;
end;

procedure TGenericGravandoExecucao.IniciarLog;
begin
  GetMonitor.Active := False;
  strLog := '';
  GetMonitor.Active := True;
end;

end.

