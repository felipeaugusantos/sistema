unit untProcessadorGravandoExecucaoCalamarNovasFormulas;

interface

uses
  untIProcessadorGravandoExecucao, DB, Classes, SysUtils, untIGravando, Uni, untINovaFormula;

type
  TProcessadorGravandoExecucaoCalamarNovasFormulas = class abstract (TInterfacedObject, IProcessadorGravandoExecucao)
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
  untNovaFormulaCalamar, untFuncoesSimples;

{ TProcessadorGravandoExecucaoCalamarNovasFormulas }

constructor TProcessadorGravandoExecucaoCalamarNovasFormulas.Create(const novaFormula: INovaFormula);
begin
  inherited Create();
  Self.novaFormula := novaFormula;
end;

constructor TProcessadorGravandoExecucaoCalamarNovasFormulas.Create;
begin
  Create(TNovaFormulaCalamar.Create);
end;

function TProcessadorGravandoExecucaoCalamarNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Formulas';
end;

function TProcessadorGravandoExecucaoCalamarNovasFormulas.GetDataSetOrigem: TDataSet;
begin
  Result := fCriarQuery('SELECT * FROM CAL_CADNFM');
end;

function TProcessadorGravandoExecucaoCalamarNovasFormulas.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM CAL_CADCAL WHERE FALSE';
end;

procedure TProcessadorGravandoExecucaoCalamarNovasFormulas.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'CAL_CADCAL';
end;

procedure TProcessadorGravandoExecucaoCalamarNovasFormulas.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  novaFormula.GravarNovaFormula(qryOrigem);
end;

function TProcessadorGravandoExecucaoCalamarNovasFormulas.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoCalamarNovasFormulas.LimparTabelas;
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
        '   CAL_CADCAL          ' +
        ' WHERE CAL_CODNFM IN   ' +
        '   (SELECT             ' +
        '     NFM_CODNFM        ' +
        '   FROM                ' +
        '     CAL_CADNFM)       ';
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

procedure TProcessadorGravandoExecucaoCalamarNovasFormulas.RegistrarImpossivelGravarRegistro(const E: Exception;
  const gravando: IGravando; const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a nova formula [%s %s %s %s %s %s], [%s: %s]', [
    qryOrigem.FieldByName('NFM_CODBAS').AsString,
    qryOrigem.FieldByName('NFM_CODEMB').AsString,
    qryOrigem.FieldByName('NFM_CODNFM').AsString,
    qryOrigem.FieldByName('NFM_KEY1__').AsString,
    qryOrigem.FieldByName('NFM_KEY2__').AsString,
    qryOrigem.FieldByName('NFM_KEY3__').AsString,
    E.ClassName,
    E.Message
  ]);
end;

end.

