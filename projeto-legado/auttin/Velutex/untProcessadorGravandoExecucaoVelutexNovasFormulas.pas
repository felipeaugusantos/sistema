unit untProcessadorGravandoExecucaoVelutexNovasFormulas;

interface

uses
  untIProcessadorGravandoExecucao, DB, Classes, SysUtils, untIGravando,  Uni, untINovaFormula;

type
  TProcessadorGravandoExecucaoVelutexNovasFormulas = class abstract (TInterfacedObject, IProcessadorGravandoExecucao)
  private
    novaFormula: INovaFormula;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings);
    function GetDataSetOrigem(): TDataSet;
    function GetSqlDestino(): string;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet);
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet);
    function fGetNomeGravacao(): string;
    procedure LimparTabelas;
    constructor Create(const novaFormula: INovaFormula); overload;
    constructor Create(); overload;
  end;

implementation

uses
  untNovaFormulaVelutex,untFuncoesSimples;

{ TProcessadorGravandoExecucaoVelutexNovasFormulas }

constructor TProcessadorGravandoExecucaoVelutexNovasFormulas.Create(const novaFormula: INovaFormula);
begin
  inherited Create();
  Self.novaFormula := novaFormula;
end;

constructor TProcessadorGravandoExecucaoVelutexNovasFormulas.Create;
begin
  Create(TNovaFormulaVelutex.Create);
end;

function TProcessadorGravandoExecucaoVelutexNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Novas Fórmulas';
end;

function TProcessadorGravandoExecucaoVelutexNovasFormulas.GetDataSetOrigem(): TDataSet;
begin
  Result := fCriarQuery('SELECT * FROM VEL_CADNFM ');
end;

function TProcessadorGravandoExecucaoVelutexNovasFormulas.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM VEL_CADVEL WHERE FALSE';
end;

procedure TProcessadorGravandoExecucaoVelutexNovasFormulas.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'VEL_CADVEL';
end;

procedure TProcessadorGravandoExecucaoVelutexNovasFormulas.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  novaFormula.GravarNovaFormula(qryOrigem);
end;

function TProcessadorGravandoExecucaoVelutexNovasFormulas.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoVelutexNovasFormulas.LimparTabelas;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' DELETE                ' +
        ' FROM                  ' +
        '   VEL_CADVEL          ' +
        ' WHERE VEL_CODNFM IN   ' +
        '   (SELECT             ' +
        '     NFM_CODNFM        ' +
        '   FROM                ' +
        '     VEL_CADNFM)       ';
      qryGen.ExecSQL;
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

procedure TProcessadorGravandoExecucaoVelutexNovasFormulas.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel cadastrar a nova formula [%s - %s - %s - %s - %s - %s - %s], [%s - %s]',
    [qryOrigem.FieldByName('NFM_CORCOD').AsString, qryOrigem.FieldByName('NFM_CODBAS').AsString,
    qryOrigem.FieldByName('NFM_COLECA').AsString, qryOrigem.FieldByName('NFM_PRODUT').AsString,
    qryOrigem.FieldByName('NFM_CODUNI').AsString, qryOrigem.FieldByName('NFM_CODNFM').AsString,
    qryOrigem.FieldByName('NFM_NOTA__').AsString,
    E.ClassName,
    E.Message]);
end;

end.

