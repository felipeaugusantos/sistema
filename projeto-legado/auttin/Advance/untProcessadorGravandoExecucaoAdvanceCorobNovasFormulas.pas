unit untProcessadorGravandoExecucaoAdvanceCorobNovasFormulas;

interface

uses
  untIProcessadorGravandoExecucao, DB, Classes, SysUtils, untIGravando, Uni;

type
  TProcessadorGravandoExecucaoAdvanceCorobNovasFormulas = class(TInterfacedObject, IProcessadorGravandoExecucao)
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
  untFuncoesSimples,  untAdvanceCorobIndustrialDinamica;

{ TProcessadorGravandoExecucaoAdvanceNovasFormulas }

function TProcessadorGravandoExecucaoAdvanceCorobNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TProcessadorGravandoExecucaoAdvanceCorobNovasFormulas.GetDataSetOrigem: TDataSet;
begin
  Result := fCriarQuery('SELECT * FROM ADVCOR_CADNFM');
end;

function TProcessadorGravandoExecucaoAdvanceCorobNovasFormulas.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM ADVCOR_CADADV WHERE FALSE';
end;

procedure TProcessadorGravandoExecucaoAdvanceCorobNovasFormulas.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'ADVCOR_CADADV';
end;

procedure TProcessadorGravandoExecucaoAdvanceCorobNovasFormulas.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  fGravaNovaFormula(TUniQuery(qryOrigem));
end;

function TProcessadorGravandoExecucaoAdvanceCorobNovasFormulas.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoAdvanceCorobNovasFormulas.LimparTabelas;
begin
  fExecutaSQL(
    ' DELETE              ' +
    ' FROM                ' +
    '   ADVCOR_CADADV     ' +
    ' WHERE ADV_CODIGO IN ' +
    '   (SELECT           ' +
    '     NFM_CODPRO      ' +
    '   FROM              ' +
    '     ADVCOR_CADNFM)  ');
end;

procedure TProcessadorGravandoExecucaoAdvanceCorobNovasFormulas.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível realizar a gravação da nova fórmula [%s], [%s: %s]',
    [qryOrigem.FieldByName('NFM_CODNFM').AsString, E.ClassName, E.Message]);
end;

end.

