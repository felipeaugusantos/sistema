unit untProcessadorGravandoExecucaoHydronorthNovasFormulas;

interface

uses
  untIProcessadorGravandoExecucao, DB, Classes, SysUtils, untIGravando, Uni, untINovaFormula;

type
  TProcessadorGravandoExecucaoHydronorthNovasFormulas = class abstract (TInterfacedObject, IProcessadorGravandoExecucao)
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
  untNovaFormulaHydronorth,untFuncoesSimples;

{ TProcessadorGravandoExecucaoHydronorthNovasFormulas }

constructor TProcessadorGravandoExecucaoHydronorthNovasFormulas.Create(const novaFormula: INovaFormula);
begin
  inherited Create();
  Self.novaFormula := novaFormula;  
end;

constructor TProcessadorGravandoExecucaoHydronorthNovasFormulas.Create;
begin
  Create(TNovaFormulaHydronorth.Create);
end;

function TProcessadorGravandoExecucaoHydronorthNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Formulas';
end;

function TProcessadorGravandoExecucaoHydronorthNovasFormulas.GetDataSetOrigem: TDataSet;
begin
  Result := fCriarQuery('SELECT * FROM HYD_CADNFM');
end;

function TProcessadorGravandoExecucaoHydronorthNovasFormulas.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM HYD_CADHYD WHERE FALSE';
end;

procedure TProcessadorGravandoExecucaoHydronorthNovasFormulas.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'HYD_CADHYD';
end;

procedure TProcessadorGravandoExecucaoHydronorthNovasFormulas.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  novaFormula.GravarNovaFormula(qryOrigem);
end;

function TProcessadorGravandoExecucaoHydronorthNovasFormulas.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoHydronorthNovasFormulas.LimparTabelas;
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
        '   HYD_CADHYD          ' +
        ' WHERE HYD_CODNFM IN   ' +
        '   (SELECT             ' +
        '     NFM_CODNFM        ' +
        '   FROM                ' +
        '     HYD_CADNFM)       ';
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

procedure TProcessadorGravandoExecucaoHydronorthNovasFormulas.RegistrarImpossivelGravarRegistro(const E: Exception;
  const gravando: IGravando; const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a nova formula [%s %s %s %s %s %s %s], [%s: %s]', [
    qryOrigem.FieldByName('NFM_CODNFM').AsString,
    qryOrigem.FieldByName('NFM_COLECA').AsString,
    qryOrigem.FieldByName('NFM_PRODUT').AsString,
    qryOrigem.FieldByName('NFM_C_O_R_').AsString,
    qryOrigem.FieldByName('NFM_CORLON').AsString,
    qryOrigem.FieldByName('NFM_BASE__').AsString,
    qryOrigem.FieldByName('NFM_CODEMB').AsString,
    E.ClassName,
    E.Message
  ]);
end;

end.
