unit untProcessadorGravandoExecucaoSayerLackNovasFormulas;

interface

uses
  untIProcessadorGravandoExecucao, DB, Classes, SysUtils, untIGravando, Uni, untINovaFormula;

type
  TProcessadorGravandoExecucaoSayerLackNovasFormulas = class abstract (TInterfacedObject, IProcessadorGravandoExecucao)
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
  untNovaFormulaSayerLack,untFuncoesSimples;

{ TProcessadorGravandoExecucaoSayerLackNovasFormulas }

constructor TProcessadorGravandoExecucaoSayerLackNovasFormulas.Create(const novaFormula: INovaFormula);
begin
  inherited Create();
  Self.novaFormula := novaFormula;
end;

constructor TProcessadorGravandoExecucaoSayerLackNovasFormulas.Create;
begin
  Create(TNovaFormulaSayerLack.Create);
end;

function TProcessadorGravandoExecucaoSayerLackNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Novas Fórmulas';
end;

function TProcessadorGravandoExecucaoSayerLackNovasFormulas.GetDataSetOrigem: TDataSet;
begin
  Result := fCriarQuery('SELECT * FROM SAY_CADNFM ');
end;

function TProcessadorGravandoExecucaoSayerLackNovasFormulas.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM SAY_CADSAY WHERE FALSE';
end;

procedure TProcessadorGravandoExecucaoSayerLackNovasFormulas.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'SAY_CADSAY';
end;

procedure TProcessadorGravandoExecucaoSayerLackNovasFormulas.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  novaFormula.GravarNovaFormula(qryOrigem);
end;

function TProcessadorGravandoExecucaoSayerLackNovasFormulas.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoSayerLackNovasFormulas.LimparTabelas;
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
        '   SAY_CADSAY          ' +
        ' WHERE SAY_CODNFM IN   ' +
        '   (SELECT             ' +
        '     NFM_CODNFM        ' +
        '   FROM                ' +
        '     SAY_CADNFM)       ';
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

procedure TProcessadorGravandoExecucaoSayerLackNovasFormulas.RegistrarImpossivelGravarRegistro(const E: Exception;
  const gravando: IGravando; const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel cadastrar a nova formula [%s - %s - %s - %s - %s], [%s - %s]',
    [qryOrigem.FieldByName('NFM_CODNFM').AsString,
    qryOrigem.FieldByName('NFM_BASE__').AsString,
    qryOrigem.FieldByName('NFM_CODBAS').AsString,
    qryOrigem.FieldByName('NFM_PRODUT').AsString,
    qryOrigem.FieldByName('NFM_DESEMB').AsString,
    E.ClassName,
    E.Message]);
end;

end.
