unit untProcessadorGravandoExecucaoBrazilianColorNovasFormulas;

interface

uses
  untIProcessadorGravandoExecucao, DB, Classes, SysUtils, untIGravando,  Uni, untINovaFormula;

type
  TProcessadorGravandoExecucaoBrazilianColorNovasFormulas = class abstract (TInterfacedObject, IProcessadorGravandoExecucao)
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
   untFuncoesSimples, untnovaFormulaBrazilianColor;

{ TProcessadorGravandoExecucaoBrazilianColorNovasFormulas }

constructor TProcessadorGravandoExecucaoBrazilianColorNovasFormulas.Create(const novaFormula: INovaFormula);
begin
  inherited Create();
  Self.novaFormula := novaFormula;
end;

constructor TProcessadorGravandoExecucaoBrazilianColorNovasFormulas.Create;
begin
  Create(TNovaFormulaBrazilianColor.Create);
end;

function TProcessadorGravandoExecucaoBrazilianColorNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Novas Fórmulas';
end;

function TProcessadorGravandoExecucaoBrazilianColorNovasFormulas.GetDataSetOrigem: TDataSet;
begin
  Result := fCriarQuery('SELECT * FROM BZC_CADNFM ');
end;

function TProcessadorGravandoExecucaoBrazilianColorNovasFormulas.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM BZC_CADBZC WHERE FALSE';
end;

procedure TProcessadorGravandoExecucaoBrazilianColorNovasFormulas.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'BZC_CADBZC';
end;

procedure TProcessadorGravandoExecucaoBrazilianColorNovasFormulas.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  novaFormula.GravarNovaFormula(qryOrigem);
end;

function TProcessadorGravandoExecucaoBrazilianColorNovasFormulas.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoBrazilianColorNovasFormulas.LimparTabelas;
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
        '   BZC_CADBZC          ' +
        ' WHERE BZC_CODNFM IN   ' +
        '   (SELECT             ' +
        '     NFM_CODNFM        ' +
        '   FROM                ' +
        '     BZC_CADNFM)       ';
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

procedure TProcessadorGravandoExecucaoBrazilianColorNovasFormulas.RegistrarImpossivelGravarRegistro(const E: Exception;
  const gravando: IGravando; const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel cadastrar a nova formula [%s - %s - %s - %s], [%s - %s]',
    [qryOrigem.FieldByName('NFM_CODNFM').AsString, qryOrigem.FieldByName('NFM_DESCRI').AsString,
    qryOrigem.FieldByName('NFM_A_N_O_').AsString, qryOrigem.FieldByName('NFM_TIPO__').AsString,
    E.ClassName,
    E.Message]);
end;

end.
