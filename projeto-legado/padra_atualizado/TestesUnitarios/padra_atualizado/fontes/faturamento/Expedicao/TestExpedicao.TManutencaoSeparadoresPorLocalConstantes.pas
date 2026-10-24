unit TestExpedicao.TManutencaoSeparadoresPorLocalConstantes;

interface

uses
  TestFramework, Expedicao.TManutencaoSeparadoresPorLocalConstantes;

type
  // Test methods for class TManutencaoSeparadoresPorLocalConstantes

  TestTManutencaoSeparadoresPorLocalConstantes = class(TTestCase)
  public
    procedure TestTManutencaoSeparadoresPorLocalConstantes;
  end;

implementation

{ TestTManutencaoSeparadoresPorLocalConstantes }

procedure TestTManutencaoSeparadoresPorLocalConstantes.TestTManutencaoSeparadoresPorLocalConstantes;
const
  CAMPO_CODIGO_LOCAL_SEPARACAO = 'CODIGO_LOCAL_SEPARACAO';
  CAMPO_CODIGO_PRODUTO         = 'CODIGO_PRODUTO';
  CAMPO_DESCRICAO_PRODUTO      = 'DESCRICAO_PRODUTO';
  CAMPO_LOCALIZACAO_FISICA     = 'LOCALIZACAO_FISICA';
  CAMPO_NUMERO_LOTE            = 'NUMERO_LOTE';
  CAMPO_QUANTIDADE             = 'QUANTIDADE';

  CAMPO_LOCAL_SEPARACAO        = 'LOCAL_SEPARACAO';
  CAMPO_SEPARADOR_ATUAL        = 'SEPARADOR_ATUAL';
  CAMPO_SEPARADOR_NOVO         = 'SEPARADOR_NOVO';
  CAMPO_SEPARACAO_INICIADA     = 'SEPARACAO_INICIADA';

  PARAMETRO_AUTOINCREM_FATGOR      = 'AUTOINCREM_FATGOR';
  PARAMETRO_CODIGO_SEPARADOR_NOVO  = 'CODIGO_SEPARADOR_NOVO';
  PARAMETRO_CODIGO_LOCAL_SEPARACAO = 'CODIGO_LOCAL_SEPARACAO';

  VALOR_SEPARACAO_INICIADA = '1';

  COR_SEPARACAO_INICIADA = $00CCCCFF;

  CAMPO_CHAVE = 'CHAVE';
  CAMPO_DESCRICAO_SEPARADOR_NOVO = 'DESCRICAO_SEPARADOR_NOVO';
begin

  CheckEqualsString(CAMPO_CODIGO_LOCAL_SEPARACAO, TManutencaoSeparadoresPorLocalConstantes.CAMPO_CODIGO_LOCAL_SEPARACAO);
  CheckEqualsString(CAMPO_CODIGO_PRODUTO, TManutencaoSeparadoresPorLocalConstantes.CAMPO_CODIGO_PRODUTO);
  CheckEqualsString(CAMPO_DESCRICAO_PRODUTO, TManutencaoSeparadoresPorLocalConstantes.CAMPO_DESCRICAO_PRODUTO);
  CheckEqualsString(CAMPO_LOCALIZACAO_FISICA, TManutencaoSeparadoresPorLocalConstantes.CAMPO_LOCALIZACAO_FISICA);
  CheckEqualsString(CAMPO_NUMERO_LOTE, TManutencaoSeparadoresPorLocalConstantes.CAMPO_NUMERO_LOTE);
  CheckEqualsString(CAMPO_QUANTIDADE, TManutencaoSeparadoresPorLocalConstantes.CAMPO_QUANTIDADE);

  CheckEqualsString(CAMPO_LOCAL_SEPARACAO, TManutencaoSeparadoresPorLocalConstantes.CAMPO_LOCAL_SEPARACAO);
  CheckEqualsString(CAMPO_SEPARADOR_ATUAL, TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_ATUAL);
  CheckEqualsString(CAMPO_SEPARADOR_NOVO, TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARADOR_NOVO);
  CheckEqualsString(CAMPO_SEPARACAO_INICIADA, TManutencaoSeparadoresPorLocalConstantes.CAMPO_SEPARACAO_INICIADA);

  CheckEqualsString(PARAMETRO_AUTOINCREM_FATGOR, TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_AUTOINCREM_FATGOR);
  CheckEqualsString(PARAMETRO_CODIGO_SEPARADOR_NOVO, TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_CODIGO_SEPARADOR_NOVO);
  CheckEqualsString(PARAMETRO_CODIGO_LOCAL_SEPARACAO, TManutencaoSeparadoresPorLocalConstantes.PARAMETRO_CODIGO_LOCAL_SEPARACAO);

  CheckEqualsString(VALOR_SEPARACAO_INICIADA, TManutencaoSeparadoresPorLocalConstantes.VALOR_SEPARACAO_INICIADA);
  Check(COR_SEPARACAO_INICIADA = TManutencaoSeparadoresPorLocalConstantes.COR_SEPARACAO_INICIADA);

  CheckEqualsString(CAMPO_CHAVE, TManutencaoSeparadoresPorLocalConstantes.CAMPO_CHAVE );
  CheckEqualsString(CAMPO_DESCRICAO_SEPARADOR_NOVO, TManutencaoSeparadoresPorLocalConstantes.CAMPO_DESCRICAO_SEPARADOR_NOVO );

end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTManutencaoSeparadoresPorLocalConstantes.Suite);
end.

