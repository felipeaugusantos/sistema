unit untProcessadorGravandoExecucaoInternationalNovasFormulas;

interface

uses
  untIProcessadorGravandoExecucao, DB, Classes, SysUtils, untIGravando,  Uni, untINovaFormula;

type
  TProcessadorGravandoExecucaoInternationalNovasFormulas = class abstract (TInterfacedObject, IProcessadorGravandoExecucao)
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
  untNovaFormulaInternational,untFuncoesSimples;

{ TProcessadorGravandoExecucaoInternationalNovasFormulas }

constructor TProcessadorGravandoExecucaoInternationalNovasFormulas.Create(const novaFormula: INovaFormula);
begin
  inherited Create();
  Self.novaFormula := novaFormula;  
end;

constructor TProcessadorGravandoExecucaoInternationalNovasFormulas.Create;
begin
  Create(TNovaFormulaInternational.Create);
end;

function TProcessadorGravandoExecucaoInternationalNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Formulas';
end;

function TProcessadorGravandoExecucaoInternationalNovasFormulas.GetDataSetOrigem: TDataSet;
begin
  Result := fCriarQuery('SELECT * FROM INT_CADNFM');
end;

function TProcessadorGravandoExecucaoInternationalNovasFormulas.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM INT_CADINT WHERE FALSE';
end;

procedure TProcessadorGravandoExecucaoInternationalNovasFormulas.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'INT_CADINT';
end;

procedure TProcessadorGravandoExecucaoInternationalNovasFormulas.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  novaFormula.GravarNovaFormula(qryOrigem);
end;

function TProcessadorGravandoExecucaoInternationalNovasFormulas.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoInternationalNovasFormulas.LimparTabelas;
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
        '   INT_CADINT          ' +
        ' WHERE INT_CODNFM IN   ' +
        '   (SELECT             ' +
        '     NFM_CODNFM        ' +
        '   FROM                ' +
        '     INT_CADNFM)       ';
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

procedure TProcessadorGravandoExecucaoInternationalNovasFormulas.RegistrarImpossivelGravarRegistro(const E: Exception;
  const gravando: IGravando; const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a nova formula [%s %s %s %s], [%s: %s]', [
    qryOrigem.FieldByName('NFM_CODNFM').AsString,
    qryOrigem.FieldByName('NFM_DESCOR').AsString,
    qryOrigem.FieldByName('NFM_CODBAS').AsString,
    qryOrigem.FieldByName('NFM_CODEMB').AsString,
    E.ClassName,
    E.Message
  ]);
end;

end.
