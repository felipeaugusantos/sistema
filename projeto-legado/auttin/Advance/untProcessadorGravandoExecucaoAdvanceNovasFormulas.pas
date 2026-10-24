unit untProcessadorGravandoExecucaoAdvanceNovasFormulas;

interface

uses
  untIProcessadorGravandoExecucao, DB, Classes, SysUtils, untIGravando, Uni;

type
  TProcessadorGravandoExecucaoAdvanceNovasFormulas = class(TInterfacedObject, IProcessadorGravandoExecucao)
  public
    function GetDataSetOrigem: TDataSet;
    function GetSqlDestino: string;
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings);
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet);
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean;
    procedure LimparTabelas;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando; const qryOrigem: TDataSet;
      const qryDestino: TDataSet);
    function fGetNomeGravacao: string;
  end;

implementation

uses
  untFuncoesSimples, untAdvanceIndustrialDinamica;

{ TProcessadorGravandoExecucaoAdvanceNovasFormulas }

function TProcessadorGravandoExecucaoAdvanceNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TProcessadorGravandoExecucaoAdvanceNovasFormulas.GetDataSetOrigem: TDataSet;
begin
  Result := fCriarQuery('SELECT * FROM ADV_CADNFM');
end;

function TProcessadorGravandoExecucaoAdvanceNovasFormulas.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM ADV_CADADV WHERE FALSE';
end;

procedure TProcessadorGravandoExecucaoAdvanceNovasFormulas.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'ADV_CADADV';
end;

procedure TProcessadorGravandoExecucaoAdvanceNovasFormulas.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  TAdvanceIndustrialDinamica.fGravarNovaFormula(TUniQuery(qryOrigem));
end;

function TProcessadorGravandoExecucaoAdvanceNovasFormulas.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoAdvanceNovasFormulas.LimparTabelas;
begin
  fExecutaSQL(
    ' DELETE              ' +
    ' FROM                ' +
    '   ADV_CADADV        ' +
    ' WHERE ADV_CODNFM IN ' +
    '   (SELECT           ' +
    '     NFM_CODNFM      ' +
    '   FROM              ' +
    '     ADV_CADNFM)     ');
end;

procedure TProcessadorGravandoExecucaoAdvanceNovasFormulas.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível realizar a gravação da nova fórmula [%s], [%s: %s]',
    [qryOrigem.FieldByName('NFM_CODNFM').AsString, E.ClassName, E.Message]);
end;

end.

