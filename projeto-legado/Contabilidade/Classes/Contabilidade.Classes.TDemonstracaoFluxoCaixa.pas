unit Contabilidade.Classes.TDemonstracaoFluxoCaixa; 

interface

uses Classes, Uni, UniClientDataSet;

const
    PARAMETROS_LINHA_MAX = 26 ;
    PARAMETROS_COLUNA_MAX = 6 ;
    PARAMETROS_LINHA_MIN =  1 ;
    PARAMETROS_COLUNA_MIN = 1 ;
    PARAMETROS_DESCRI = 1 ;
    PARAMETROS_NIVEL_ = 2 ;
    PARAMETROS_ORDEM_ = 3 ;
    PARAMETROS_EDITAV = 4 ;
    PARAMETROS_NEGRIT = 5 ;
    PARAMETROS_CONTAS = 6 ;
    PARAMETROS_PADRAO : array [PARAMETROS_LINHA_MIN..PARAMETROS_LINHA_MAX, PARAMETROS_COLUNA_MIN..PARAMETROS_COLUNA_MAX] of string = (
                        ('FLUXOS OPERACIONAIS',                                '0', '01', '0', '1', '0'),
                        ('Resultado Líquido',                                  '1', '02', '0', '0', '1'),
                        ('(+) Depreciação',                                    '1', '03', '0', '0', '1'),
                        ('Aumento/Redução de Duplicatas a Receber',            '1', '04', '0', '0', '1'),
                        ('Aumento em Duplicatas Descontadas',                  '1', '05', '0', '0', '1'),
                        ('Aumento em Provisão p/ Crédito Liquidação Duvidosa', '1', '06', '0', '0', '1'),
                        ('Aumento/Redução em Estoques',                        '1', '07', '0', '0', '1'),
                        ('Aumento/Redução em Fornecedores',                    '1', '08', '0', '0', '1'),
                        ('Redução de Salários a Pagar',                        '1', '09', '0', '0', '1'),
                        ('EM BRANCO',                                          '1', '10', '1',  '0', '1'),
                        ('Caixa Líquido das Atividades',                       '1', '11', '0', '1', '0'),

                        ('FLUXOS DE INVESTIMENTOS',                            '0', '12', '0', '1', '0'),
                        ('Pagamento na Compra de Imobilizados',                '1', '13', '0', '0', '1'),
                        ('Recebimento pela Venda de Imobilizados',             '1', '14', '0', '0', '1'),
                        ('EM BRANCO',                                          '1', '15', '1',  '0', '1'),
                        ('Caixa Líquido de Investimentos',                     '1', '16', '0', '1', '0'),

                        ('FLUXOS DE FINANCIAMENTO',                            '0', '17', '0', '1', '0'),
                        ('Integralização de Aumento de Capital',               '1', '18', '0', '0', '1'),
                        ('Amortização de Empréstimos e Financiamentos',        '1', '19', '0', '0', '1'),
                        ('Recebimento/Pagamento de Dividendos',                '1', '20', '0', '0', '1'),
                        ('Novas Captações de Empréstimos e Financiamentos',    '1', '21', '0', '0', '1'),
                        ('EM BRANCO',                                          '1', '22', '1',  '0', '1'),
                        ('Caixa Líquido de Financiamentos',                    '1', '23', '0', '1', '0'),

                        ('AUMENTO/REDUÇÃO DE CAIXA',                           '0', '24', '0', '1', '0'),
                        ('SALDO INICIAL DE CAIXA',                             '0', '25', '0', '1', '0'),
                        ('SALDO FINAL DE CAIXA',                               '0', '26', '0', '1', '0')
                      ) ;
    LINHAS_FLUXO_OPERACIONAL = [2..10] ;
    LINHAS_FLUXO_INVESTIMENTO = [13..15] ;
    LINHAS_FLUXO_FINANCEIRO = [18..22] ;
    LINHA_CAIXA_LIQUIDO_ATIVIDADES = 11 ;
    LINHA_CAIXA_LIQUIDO_INVESTIMENTOS = 16 ;
    LINHA_CAIXA_LIQUIDO_FINANCIAMENTOS = 23 ;
    LINHA_AUMENTO_REDUCAO_CAIXA = 24 ;
    LINHA_SALDO_INICIAL_CAIXA = 25 ;
    LINHA_SALDO_FINAL_CAIXA = 26 ;

type
  TDemonstracaoFluxoCaixaGerar = class
  private
    FAnoExercicio: integer ;
    FEmpresas: TStringList ;
    class function fEmpresasToStr(const ALstEmpresas: TStringList):string ;
    class function fSaldoExercicioAnteriorDFC(const AExercicio: integer; const ALstEmpresas: TStringList): double ;
    class function fPadronizaStringEmpresas(const ALstEmpresas: TStringList):string ;
    class function fGetSqlInsertSLDDFC: string;
    class function fGetSqlDeleteSLDDFC: string;
    class procedure pConfiguraValorCalculoTotais(var cdsGerar: TUniClientDataSet; const AValor: Double; const AOrdem: integer) ;
    class procedure pCarregaValoresContaContabil(const AExercicio: integer; const ALstEmpresas: TStringList; var cdsGerar: TUniClientDataSet) ;
    class function fPreparaFiltroEmpresa(const ANomerabela, AColEmpresa: string; const ALstEmpresas: TStringList):string ;
    class procedure pSomaValoresItens(const ACdsCtaDfc, ACdsLanAtu, ACdsLanAnt: TUniClientDataSet; var AFltTotalAtu,AFltTotalAnt: double);
  public
    property AnoExercicio : integer read FAnoExercicio write FAnoExercicio ;
    property Empresas : TStringList read FEmpresas write FEmpresas ;
    function Processar:TUniClientDataset ;
    constructor Create;
    destructor Destroy; override;
    class procedure CalcularTotais(const AExercicio: integer; const ALstEmpresas: TStringList; var cdsGerar: TUniClientDataSet) ;
    class function GravarSaldoExercicio(const AExercicio: integer; const ALstEmpresas: TStringList; const AValorSaldo: double): boolean ;
  end;

  TDemonstracaoFluxoCaixaParametros = class
  private
    class function fGetSqlInsertPARDFC: string;
    class function fGetSqlInsertCNTDFC: string;
    class function fGetSqlUpdatePARDFC: string;
    class function fGetSqlDeleteCNTDFC: string;
    class function fGetSqlDeletePARDFC: string;
  public
    class procedure Carregar(const AExercicio: integer; const ACodEmp: String; var cdsParametros, cdsParametrosContas : TUniClientDataSet) ;
    class function Gravar(const AExercicio: integer; const aCodEmp: String; const cdsParametros, cdsParametrosContas : TUniClientDataSet; const ModoInsert: Boolean):boolean ;
    class function Deletar(const AExercicio: integer; const ACodEmp: String):boolean ;
    class procedure IncluirDe(const AExercicio: integer; const ACodEmp: String; var qryDfc : TUniquery; var cdsCon : TUniClientDataSet) ;
  end;

  TDemonstracaoFluxoCaixaExercicio = class
  public
    class function Listar(const ACodEmp: String):TStringList ;
    class function VerificarExistente(const AExercicio: integer; const ACodEmp: String; const ModoInsert: Boolean):boolean ;
  end;

implementation

uses untFuncoesSimples, SysUtils, DB, System.JSON, Contabilidade.Funcoes;

{ TDemonstracaoFluxoCaixaGerar }

class procedure TDemonstracaoFluxoCaixaGerar.pCarregaValoresContaContabil(
  const AExercicio: integer; const ALstEmpresas: TStringList;
  var cdsGerar: TUniClientDataSet);
var
  qryCtaDfc : TUniQuery ;
  cdsCtaDfc : TUniClientDataSet ;
  strSqlCta : String ;
  strSql : String ;
  JsonArr   : TJSONArray ;
  strCta    : string ;


  qryLan : TUniQuery ;
  cdsLanAtu : TUniClientDataSet ;
  cdsLanAnt : TUniClientDataSet ;
  strFilEmp : string ;

  fltTotalAtu : Double ;
  fltTotalAnt : Double ;

  strTplaco : string ;
begin
  strTplaco := fRetTplacoEmpresaLogada ;

  qryCtaDfc := fCriaQuery() ;
  JsonArr := TJSONArray.Create;
  qryLan := fCriaQuery() ;
  try
    strSqlCta := '' ;
    strSqlCta := strSqlCta + ' SELECT DFC_ORDEM_, DFC_CODCON, PLANCO.NCO_CODCON ' ;
    strSqlCta := strSqlCta + ' FROM PARDFC ' ;
    strSqlCta := strSqlCta + '      INNER JOIN CNTDFC ON CNTDFC.DFC_SEQLAN = PARDFC.AUTOINCREM ' ;
    strSqlCta := strSqlCta + '      LEFT JOIN PLANCO ON NCO_CODCON LIKE CONCAT(DFC_CODCON,"%") AND NCO_NATURE = "A" AND NCO_TPLACO = ' + strTplaco.QuotedString ;
    strSqlCta := strSqlCta + ' WHERE PARDFC.DFC_EXERCI = :EXERCI  ' + fPreparaFiltroEmpresa('PARDFC', 'DFC_CODEMP', ALstEmpresas) ;
    strSqlCta := strSqlCta + ' ORDER BY DFC_ORDEM_, DFC_CODCON, PLANCO.NCO_CODCON ' ;

    qryCtaDfc.Close ;
    qryCtaDfc.SQL.Clear ;
    qryCtaDfc.SQL.Add(strSqlCta) ;
    qryCtaDfc.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryCtaDfc.Open ;

    cdsCtaDfc := fCriaClientDatset(qryCtaDfc) ;
    cdsCtaDfc.IndexFieldNames := 'DFC_ORDEM_' ;

    ////separa as contas para buscar os valores na lancon
    cdsCtaDfc.DisableControls ;
    try
      cdsCtaDfc.First ;
      while not cdsCtaDfc.Eof do
      begin
        JsonArr.AddElement(TJSONString.Create(cdsCtaDfc.FieldByName('NCO_CODCON').AsString));
        cdsCtaDfc.Next ;
      end;
    finally
      cdsCtaDfc.EnableControls ;
    end;
    strCta := JsonArr.ToString.Replace('[','').Replace(']','') ;

    if fEmptyStr(strCta) then
    begin
      exit ;
    end;

    strFilEmp := fPreparaFiltroEmpresa('LANBAL', 'BAL_CODEMP', ALstEmpresas) ;

    strSql := '' ;
    strSql := strSql + ' SELECT LANBAL.BAL_CODCON AS CODCON, COALESCE(BAL_SALFIN,0.00) AS VALOR, BAL_CRDEFI ' ;
    strSql := strSql + '  FROM LANBAL ' ;
    strSql := strSql + '  WHERE EXTRACT(YEAR FROM LANBAL.BAL_DTAMOV) = :EXERCI AND EXTRACT(MONTH FROM LANBAL.BAL_DTAMOV) = 12 ' ;
    strSql := strSql + '        AND LANBAL.BAL_CODCON IN (' + strCta + ') ' ;
    strSql := strSql + ' 			                 ' + strFilEmp ;

    qryLan.Close ;
    qryLan.SQL.Clear ;
    qryLan.SQL.Add(strSql) ;
    qryLan.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryLan.Open ;

    cdsLanAtu := fCriaClientDatset(qryLan) ;
    cdsLanAtu.IndexFieldNames := 'CODCON' ;

    qryLan.Close ;
    qryLan.ParamByName('EXERCI').AsInteger := AExercicio-1 ;
    qryLan.Open ;

    cdsLanAnt := fCriaClientDatset(qryLan) ;
    cdsLanAnt.IndexFieldNames := 'CODCON' ;

    //////inicia o processamento
    cdsGerar.DisableControls ;
    try
      cdsGerar.First ;
      while not cdsGerar.Eof do
      begin
        if cdsCtaDfc.FindKey([cdsGerar.FieldByName('DFC_ORDEM_').AsInteger]) then
        begin
          fltTotalAtu := 0.00 ;
          fltTotalAnt := 0.00 ;
          while (cdsGerar.FieldByName('DFC_ORDEM_').AsInteger = cdsCtaDfc.FieldByName('DFC_ORDEM_').AsInteger)
                and ( not cdsCtaDfc.Eof ) do
          begin
            pSomaValoresItens(cdsCtaDfc,
                              cdsLanAtu,
                              cdsLanAnt,
                              fltTotalAtu,
                              fltTotalAnt) ;
            cdsCtaDfc.Next ;
          end;
          cdsGerar.Edit ;
          cdsGerar.FieldByName('DFC_EXERCI').AsFloat := fltTotalAtu ;
          cdsGerar.FieldByName('DFC_EXEANT').AsFloat := fltTotalAnt ;
          cdsGerar.Post ;
        end;
        cdsGerar.Next ;
      end;
    finally
      cdsGerar.EnableControls ;
    end;

  finally
    FreeAndNil(qryCtaDfc) ;
    FreeAndNil(cdsCtaDfc) ;
    FreeAndNil(JsonArr) ;

    FreeAndNil(qryLan) ;
    FreeAndNil(cdsLanAnt) ;
    FreeAndNil(cdsLanAtu) ;
  end;
end;

constructor TDemonstracaoFluxoCaixaGerar.Create;
begin
  FEmpresas := TStringList.Create;
end;

destructor TDemonstracaoFluxoCaixaGerar.Destroy;
begin
  FreeAndNil(FEmpresas) ;
  inherited;
end;

class function TDemonstracaoFluxoCaixaGerar.fEmpresasToStr(const ALstEmpresas: TStringList): string;
var
  intCnt : integer ;
begin
  result := '' ;
  for intCnt := 0 to ALstEmpresas.Count-1 do
  begin
    if fEmptyStr(result) then
    begin
      result := quotedstr(ALstEmpresas.Strings[intCnt]) ;
    end
    else
    begin
      result := result + ',' + quotedstr(ALstEmpresas.Strings[intCnt]) ;
    end;
  end;
end;

class procedure TDemonstracaoFluxoCaixaGerar.pConfiguraValorCalculoTotais(
  var cdsGerar: TUniClientDataSet; const AValor: Double; const AOrdem: integer);
begin
  if cdsGerar.Locate('DFC_ORDEM_', AOrdem, []) then
  begin
    cdsGerar.Edit ;
    cdsGerar.FieldByName('DFC_VALOR_').AsFloat := AValor ;
    cdsGerar.Post ;
  end;
end;

class function TDemonstracaoFluxoCaixaGerar.fGetSqlDeleteSLDDFC: string;
begin
  result := 'DELETE FROM SLDDFC WHERE DFC_EXERCI = :EXERCI AND DFC_CDEMPS = :CDEMPS ;' ;
end;

class function TDemonstracaoFluxoCaixaGerar.fGetSqlInsertSLDDFC: string;
begin
  result := 'INSERT INTO SLDDFC (AUTOINCREM, DFC_VLRSLD, DFC_EXERCI, DFC_CDEMPS) VALUES (:AUTOINCREM, :VLRSLD, :EXERCI, :CDEMPS) ;' ;
end;

class function TDemonstracaoFluxoCaixaGerar.fPadronizaStringEmpresas(const ALstEmpresas: TStringList): string;
var
  intCnt: integer ;
  strRetorno: string ;
begin
  strRetorno := '' ;
  ALstEmpresas.Sorted := True ;
  for intCnt := 0 to ALstEmpresas.Count-1 do
  begin
    if fEmptyStr(ALstEmpresas.Strings[intCnt]) then
    begin
      strRetorno := ALstEmpresas.Strings[intCnt] ;
    end
    else
    begin
      strRetorno := strRetorno + '_' + ALstEmpresas.Strings[intCnt] ;
    end;
  end;
  result := strRetorno ;
end;

class function TDemonstracaoFluxoCaixaGerar.fSaldoExercicioAnteriorDFC(
  const AExercicio: integer; const ALstEmpresas: TStringList): double;
var
  iExercicioAnterior: integer ;
  qryConsulta: TUniquery ;
  strEmpresas: string ;
  strSql : string ;
begin
  strSql := '' ;
  strSql := strSql + ' SELECT ' ;
  strSql := strSql + '   DFC_VLRSLD ' ;
  strSql := strSql + ' FROM SLDDFC ' ;
  strSql := strSql + ' WHERE DFC_EXERCI = :EXERCI AND DFC_CDEMPS = :CDEMPS ' ;

  strEmpresas := fPadronizaStringEmpresas(ALstEmpresas) ;
  iExercicioAnterior := AExercicio-1 ;

  qryConsulta := fCriaQuery ;
  try
    qryConsulta.Close ;
    qryConsulta.SQL.Clear ;
    qryConsulta.SQL.Add(strSql) ;
    qryConsulta.ParamByName('EXERCI').AsInteger := iExercicioAnterior ;
    qryConsulta.ParamByName('CDEMPS').AsString := strEmpresas ;
    qryConsulta.Open ;

    result := qryConsulta.FieldByName('DFC_VLRSLD').AsFloat ;

  finally
    FreeAndNil(qryConsulta) ;
  end;
end;

class function TDemonstracaoFluxoCaixaGerar.GravarSaldoExercicio(
  const AExercicio: integer; const ALstEmpresas: TStringList;
  const AValorSaldo: double): boolean;
var
  strEmpresas: string ;
  qryExec: TUniQuery ;
begin
  result := false ;
  if AExercicio <= 0 then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não selecionado!' , ['&Ok']);
    exit ;
  end;

  strEmpresas := fPadronizaStringEmpresas(ALstEmpresas);

  qryExec := fCriaQuery() ;
  try
    fStartTransaction;
    try
      ///Exclui para relançar
      qryExec.Close ;
      qryExec.SQL.Clear ;
      qryExec.SQL.Add(fGetSqlDeleteSLDDFC);
      qryExec.ParamByName('EXERCI').AsInteger := AExercicio ;
      qryExec.ParamByName('CDEMPS').AsString := strEmpresas ;
      qryExec.ExecSQL ;

      qryExec.Close ;
      qryExec.SQL.Clear ;
      qryExec.SQL.Add(fGetSqlInsertSLDDFC);
      qryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('SLDDFC',Vs_strCodEmp) ;
      qryExec.ParamByName('VLRSLD').AsFloat := AValorSaldo ;
      qryExec.ParamByName('EXERCI').AsInteger := AExercicio ;
      qryExec.ParamByName('CDEMPS').AsString := strEmpresas ;
      qryExec.ExecSQL ;

      fCommit;
    except
      On E: Exception Do
      Begin
        fRollBack;
        raise ;
      End;
    end;

  finally
    FreeAndNil(qryExec) ;
  end;
  result := True ;
end;

class procedure TDemonstracaoFluxoCaixaGerar.CalcularTotais(const AExercicio: integer;
  const ALstEmpresas: TStringList;
  var cdsGerar: TUniClientDataSet);
var
  fltDfcFluxoOperacional, fltDfcFluxoInvestimento, fltDfcFluxoFinanciamento : double ;
  fltExercFluxoOperacional, fltExercFluxoInvestimento, fltExercFluxoFinanciamento : double ;
  fltExercAntFluxoOperacional, fltExercAntFluxoInvestimento, fltExercAntFluxoFinanciamento : double ;
  fltAumentoReducaoCaixa : Double ;
  fltSaldoInicialCaixa : Double ;
  fltSaldoFinalCaixa : Double ;
  intLinha : integer ;
  fltSaldoExercicioAnteriorDFC: double ;
begin

  fltSaldoExercicioAnteriorDFC := fSaldoExercicioAnteriorDFC(AExercicio, ALstEmpresas) ;

  cdsGerar.DisableControls ;
  try
    intLinha := cdsGerar.FieldByName('DFC_ORDEM_').AsInteger ;
    /////calcula o DFC
    cdsGerar.First ;
    while not cdsGerar.Eof do
    begin
      cdsGerar.Edit ;
      if cdsGerar.FieldByName('DFC_CONTAS').AsString = '1' then
      begin
        cdsGerar.FieldByName('DFC_VALOR_').AsFloat := cdsGerar.FieldByName('DFC_EXERCI').AsFloat - cdsGerar.FieldByName('DFC_EXEANT').AsFloat ;
      end;
      cdsGerar.Post ;
      cdsGerar.Next ;
    end;
    /////totaliza os agrupamentos.
    fltDfcFluxoOperacional    := 0 ;
    fltDfcFluxoInvestimento   := 0 ;
    fltDfcFluxoFinanciamento  := 0 ;
    /////
    fltExercFluxoOperacional   := 0 ;
    fltExercFluxoInvestimento  := 0 ;
    fltExercFluxoFinanciamento := 0 ;
    /////
    fltExercAntFluxoOperacional   := 0 ;
    fltExercAntFluxoInvestimento  := 0 ;
    fltExercAntFluxoFinanciamento := 0 ;

    cdsGerar.First ;
    while not cdsGerar.Eof do
    begin
      if cdsGerar.FieldByName('DFC_ORDEM_').AsInteger in LINHAS_FLUXO_OPERACIONAL then
      begin
        fltDfcFluxoOperacional := fltDfcFluxoOperacional + cdsGerar.FieldByName('DFC_VALOR_').AsFloat ;
        fltExercFluxoOperacional := fltExercFluxoOperacional + cdsGerar.FieldByName('DFC_EXERCI').AsFloat ;
        fltExercAntFluxoOperacional := fltExercAntFluxoOperacional + cdsGerar.FieldByName('DFC_EXEANT').AsFloat ;
      end;
      if cdsGerar.FieldByName('DFC_ORDEM_').AsInteger in LINHAS_FLUXO_INVESTIMENTO then
      begin
        fltDfcFluxoInvestimento := fltDfcFluxoInvestimento + cdsGerar.FieldByName('DFC_VALOR_').AsFloat ;
        fltExercFluxoInvestimento := fltExercFluxoInvestimento + cdsGerar.FieldByName('DFC_EXERCI').AsFloat ;
        fltExercAntFluxoInvestimento := fltExercAntFluxoInvestimento + cdsGerar.FieldByName('DFC_EXEANT').AsFloat ;
      end;
      if cdsGerar.FieldByName('DFC_ORDEM_').AsInteger in LINHAS_FLUXO_FINANCEIRO then
      begin
        fltDfcFluxoFinanciamento := fltDfcFluxoFinanciamento + cdsGerar.FieldByName('DFC_VALOR_').AsFloat ;
        fltExercFluxoFinanciamento := fltExercFluxoFinanciamento + cdsGerar.FieldByName('DFC_EXERCI').AsFloat ;
        fltExercAntFluxoFinanciamento := fltExercAntFluxoFinanciamento + cdsGerar.FieldByName('DFC_EXEANT').AsFloat ;
      end;
      cdsGerar.Next ;
    end;

    if cdsGerar.Locate('DFC_ORDEM_', LINHA_CAIXA_LIQUIDO_ATIVIDADES, []) then
    begin
      cdsGerar.Edit ;
      cdsGerar.FieldByName('DFC_VALOR_').AsFloat := fltDfcFluxoOperacional ;
      cdsGerar.FieldByName('DFC_EXERCI').AsFloat := fltExercFluxoOperacional ;
      cdsGerar.FieldByName('DFC_EXEANT').AsFloat := fltExercAntFluxoOperacional ;
      cdsGerar.Post ;
    end;

    if cdsGerar.Locate('DFC_ORDEM_', LINHA_CAIXA_LIQUIDO_INVESTIMENTOS, []) then
    begin
      cdsGerar.Edit ;
      cdsGerar.FieldByName('DFC_VALOR_').AsFloat := fltDfcFluxoInvestimento ;
      cdsGerar.FieldByName('DFC_EXERCI').AsFloat := fltExercFluxoInvestimento ;
      cdsGerar.FieldByName('DFC_EXEANT').AsFloat := fltExercAntFluxoInvestimento ;
      cdsGerar.Post ;
    end;

    if cdsGerar.Locate('DFC_ORDEM_', LINHA_CAIXA_LIQUIDO_FINANCIAMENTOS, []) then
    begin
      cdsGerar.Edit ;
      cdsGerar.FieldByName('DFC_VALOR_').AsFloat := fltDfcFluxoFinanciamento ;
      cdsGerar.FieldByName('DFC_EXERCI').AsFloat := fltExercFluxoFinanciamento ;
      cdsGerar.FieldByName('DFC_EXEANT').AsFloat := fltExercAntFluxoFinanciamento ;
      cdsGerar.Post ;
    end;

    ////aumento/redução caixa
    fltAumentoReducaoCaixa := fltDfcFluxoOperacional + fltDfcFluxoInvestimento + fltDfcFluxoFinanciamento ;
    pConfiguraValorCalculoTotais(cdsGerar, fltAumentoReducaoCaixa, LINHA_AUMENTO_REDUCAO_CAIXA);

    ////saldo inicial caixa
    fltSaldoInicialCaixa := fltSaldoExercicioAnteriorDFC ;
    pConfiguraValorCalculoTotais(cdsGerar, fltSaldoInicialCaixa, LINHA_SALDO_INICIAL_CAIXA);

    ///saldo final caixa
    fltSaldoFinalCaixa := fltSaldoInicialCaixa + fltAumentoReducaoCaixa ;
    pConfiguraValorCalculoTotais(cdsGerar, fltSaldoFinalCaixa, LINHA_SALDO_FINAL_CAIXA);

    ///restaura a linha antes do processamento
    cdsGerar.Locate('DFC_ORDEM_', intLinha, [])

  finally
    cdsGerar.EnableControls ;
  end;
end;

class function TDemonstracaoFluxoCaixaGerar.fPreparaFiltroEmpresa(
  const ANomerabela, AColEmpresa: string;
  const ALstEmpresas: TStringList): string;
begin
  result := fEmpresasToStr(ALstEmpresas) ;
  if not fEmptyStr(result) then
  begin
    result := ' AND COALESCE(' + ANomerabela + '.' + AColEmpresa + ', "") IN ('+result+') ' ;
  end;
end;

function TDemonstracaoFluxoCaixaGerar.Processar: TUniClientDataset;
var
  qryGerar : TUniQuery ;
  cdsGerar : TUniClientDataset ;
  strFiltroEmpresas : string ;
begin
  result := nil ;
  strFiltroEmpresas := '' ;

  if FAnoExercicio <= 0 then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não selecionado!' , ['&Ok']);
    exit ;
  end;

  qryGerar := fCriaQuery() ;
  try
    qryGerar.Close ;
    qryGerar.SQL.Clear ;
    qryGerar.SQL.Add('     SELECT DFC_ORDEM_, CAST(CONCAT(REPEAT(" ",DFC_NIVEL_*3), DFC_DESCRI) AS CHAR(75)) AS DFC_DESCRI, ') ;
    qryGerar.SQL.Add('        CAST(NULL AS DECIMAL(12,2)) AS DFC_VALOR_, ') ;
    qryGerar.SQL.Add('        CAST(NULL AS DECIMAL(12,2)) AS DFC_EXERCI, ') ;
    qryGerar.SQL.Add('        CAST(NULL AS DECIMAL(12,2)) AS DFC_EXEANT, DFC_CONTAS, DFC_NEGRIT ') ;
    qryGerar.SQL.Add(' FROM PARDFC WHERE DFC_EXERCI = :EXERCI ' + fPreparaFiltroEmpresa('PARDFC', 'DFC_CODEMP', FEmpresas)) ;
    qryGerar.SQL.Add(' ORDER BY DFC_ORDEM_ ') ;
    qryGerar.ParamByName('EXERCI').AsInteger := FAnoExercicio ;
    qryGerar.Open ;

    cdsGerar := fCriaClientDatset(qryGerar) ;

    pCarregaValoresContaContabil(FAnoExercicio, FEmpresas, cdsGerar) ;

    CalcularTotais(FAnoExercicio, FEmpresas, cdsGerar) ;

    result := cdsGerar ;
  finally
    FreeAndNil(qryGerar) ;
  end;
end;

class procedure TDemonstracaoFluxoCaixaGerar.pSomaValoresItens(const ACdsCtaDfc,
  ACdsLanAtu, ACdsLanAnt: TUniClientDataSet; var AFltTotalAtu,
  AFltTotalAnt: double);
begin
  ///credito
  if ACdsLanAtu.FindKey([ACdsCtaDfc.FieldByName('NCO_CODCON').AsString]) then
  begin
    while (ACdsCtaDfc.FieldByName('NCO_CODCON').AsString = ACdsLanAtu.FieldByName('CODCON').AsString)
          and ( not ACdsLanAtu.Eof )  do
    begin
      AFltTotalAtu := AFltTotalAtu + iif(ACdsLanAtu.FieldByName('BAL_CRDEFI').AsString = 'C', -ACdsLanAtu.FieldByName('VALOR').AsFloat, ACdsLanAtu.FieldByName('VALOR').AsFloat) ;
      ACdsLanAtu.Next ;
    end;
  end;
  if ACdsLanAnt.FindKey([ACdsCtaDfc.FieldByName('NCO_CODCON').AsString]) then
  begin
    while (ACdsCtaDfc.FieldByName('NCO_CODCON').AsString = ACdsLanAnt.FieldByName('CODCON').AsString)
          and ( not ACdsLanAnt.Eof )  do
    begin
      AFltTotalAnt := AFltTotalAnt + iif(ACdsLanAnt.FieldByName('BAL_CRDEFI').AsString = 'C', -ACdsLanAnt.FieldByName('VALOR').AsFloat, ACdsLanAnt.FieldByName('VALOR').AsFloat) ;
      ACdsLanAnt.Next ;
    end;
  end;
end;

{ TDemonstracaoFluxoCaixaParametros }

class procedure TDemonstracaoFluxoCaixaParametros.Carregar(
  const AExercicio: integer; const ACodEmp: String; var cdsParametros,
  cdsParametrosContas: TUniClientDataSet);
var
  strSql : string ;
  qryParametros: TUniQuery;
  qryParametrosContas: TUniQuery;
  strCnt : string ;
  strTplaco : string ;
begin
  strSql := '' ;
  strSql := strSql + ' SELECT ' ;
  strSql := strSql + '  AUTOINCREM, ' ;
  strSql := strSql + '  DFC_EXERCI, ' ;
  strSql := strSql + '  DFC_CODEMP, ' ;
  strSql := strSql + '  CAST(CONCAT(REPEAT(" ",DFC_NIVEL_*3), DFC_DESCRI) AS CHAR(75)) AS DFC_DESCRI, ' ;
  strSql := strSql + '  DFC_NIVEL_, ' ;
  strSql := strSql + '  DFC_ORDEM_, ' ;
  strSql := strSql + '  DFC_EDITAV, ' ;
  strSql := strSql + '  DFC_NEGRIT, ' ;
  strSql := strSql + '  DFC_CONTAS, ' ;
  strSql := strSql + '  (CAST(NULL AS CHAR(4))) AS CNT_BTN ' ;
  strSql := strSql + ' FROM PARDFC ' ;
  strSql := strSql + ' WHERE DFC_EXERCI = :EXERCI AND COALESCE(DFC_CODEMP, "") = :CODEMP ' ;
  strSql := strSql + ' ORDER BY DFC_ORDEM_' ;

  qryParametros := fCriaQuery;
  try
    qryParametros.Close ;
    qryParametros.SQL.Clear ;
    qryParametros.SQL.Add(strSql) ;
    qryParametros.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryParametros.ParamByName('CODEMP').AsString := ACodEmp ;
    qryParametros.Open ;

    If Assigned(cdsParametros) Then
      FreeAndNil(cdsParametros);

    cdsParametros := fCriaClientDatset(qryParametros);

    cdsParametros.Open;
    cdsParametros.First ;
    strCnt := QuotedStr('-1') ;
    while not cdsParametros.Eof do
    begin
      strCnt := strCnt +','+ QuotedStr(cdsParametros.FieldByName('AUTOINCREM').AsString) ;
      cdsParametros.Next ;
    end;

  finally
    FreeAndNil(qryParametros);
  end;

  strTplaco := fRetTplacoEmpresaLogada ;

  ////contas associadas aos parametros.
  strSql := '' ;
  strSql := strSql + ' SELECT ' ;
  strSql := strSql + ' CNTDFC.AUTOINCREM, ' ;
  strSql := strSql + ' CNTDFC.DFC_SEQLAN, ' ;
  strSql := strSql + ' CNTDFC.DFC_CODCON, ' ;
  strSql := strSql + ' PLANCO.NCO_DESCRI ' ;
  strSql := strSql + ' FROM CNTDFC INNER JOIN PLANCO ON CNTDFC.DFC_CODCON = PLANCO.NCO_CODCON AND PLANCO.NCO_TPLACO = '+ strTplaco.QuotedString ;
  strSql := strSql + ' WHERE CNTDFC.DFC_SEQLAN in ('+ strCnt +') ' ;
  strSql := strSql + ' ORDER BY CNTDFC.AUTOINCREM ' ;

  qryParametrosContas := fCriaQuery;
  try
    qryParametrosContas.Close ;
    qryParametrosContas.SQL.Clear ;
    qryParametrosContas.SQL.Add(strSql) ;
    qryParametrosContas.Open ;

    If Assigned(cdsParametrosContas) Then
      FreeAndNil(cdsParametrosContas);

    cdsParametrosContas := fCriaClientDatset(qryParametrosContas);
    cdsParametrosContas.Open;
    cdsParametrosContas.IndexFieldNames := 'DFC_CODCON;DFC_SEQLAN' ;
  finally
    FreeAndNil(qryParametrosContas);
  end;

end;

class function TDemonstracaoFluxoCaixaParametros.Deletar(
  const AExercicio: integer; const ACodEmp: String): boolean;
var
  qryExec : TUniQuery ;
begin
  fStartTransaction;
  try
    qryExec := fCriaQuery ;
    try
      qryExec.Close ;
      qryExec.SQL.Clear ;
      qryExec.SQL.Add(fGetSqlDeletePARDFC);
      qryExec.ParamByName('EXERCI').AsInteger := AExercicio ;
      qryExec.ParamByName('CODEMP').AsString := ACodEmp ;
      qryExec.ExecSQL ;

    finally
      FreeAndNil(qryExec) ;
    end;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise ;
    End;
  End;
  result := True ;
end;

class function TDemonstracaoFluxoCaixaParametros.fGetSqlDeleteCNTDFC: string;
begin
  result := 'DELETE FROM CNTDFC WHERE DFC_SEQLAN IN (SELECT AUTOINCREM FROM PARDFC WHERE DFC_EXERCI = :EXERCI AND COALESCE(DFC_CODEMP, "") = :CODEMP) ;' ;
end;

class function TDemonstracaoFluxoCaixaParametros.fGetSqlDeletePARDFC: string;
begin
  result := 'DELETE FROM PARDFC WHERE DFC_EXERCI = :EXERCI AND COALESCE(DFC_CODEMP, "") = :CODEMP ; ' ;
end;

class function TDemonstracaoFluxoCaixaParametros.fGetSqlInsertCNTDFC: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO CNTDFC ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' AUTOINCREM, ' ;
  strSql := strSql + ' DFC_SEQLAN, ' ;
  strSql := strSql + ' DFC_CODCON ' ;
  strSql := strSql + ' ) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' :AUTOINCREM, ' ;
  strSql := strSql + ' :SEQLAN, ' ;
  strSql := strSql + ' :CODCON ' ;
  strSql := strSql + ' ); ' ;

  result := strSql ;
end;

class function TDemonstracaoFluxoCaixaParametros.fGetSqlInsertPARDFC: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO PARDFC ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' AUTOINCREM, ' ;
  strSql := strSql + ' DFC_EXERCI, ' ;
  strSql := strSql + ' DFC_CODEMP, ' ;
  strSql := strSql + ' DFC_DESCRI, ' ;
  strSql := strSql + ' DFC_NIVEL_, ' ;
  strSql := strSql + ' DFC_ORDEM_, ' ;
  strSql := strSql + ' DFC_EDITAV, ' ;
  strSql := strSql + ' DFC_NEGRIT, ' ;
  strSql := strSql + ' DFC_CONTAS ' ;
  strSql := strSql + ' ) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' :AUTOINCREM, ' ;
  strSql := strSql + ' :EXERCI, ' ;
  strSql := strSql + ' :CODEMP, ' ;
  strSql := strSql + ' :DESCRI, ' ;
  strSql := strSql + ' :NIVEL_, ' ;
  strSql := strSql + ' :ORDEM_, ' ;
  strSql := strSql + ' :EDITAV, ' ;
  strSql := strSql + ' :NEGRIT, ' ;
  strSql := strSql + ' :CONTAS ' ;
  strSql := strSql + ' ); ' ;
  result := strSql ;
end;

class function TDemonstracaoFluxoCaixaParametros.fGetSqlUpdatePARDFC: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' UPDATE PARDFC SET DFC_DESCRI = :DESCRI WHERE AUTOINCREM = :AUTOINCREM ' ;
  result := strSql ;
end;

class function TDemonstracaoFluxoCaixaParametros.Gravar(const AExercicio: integer; const aCodEmp: String; const cdsParametros,
  cdsParametrosContas: TUniClientDataSet; const ModoInsert: Boolean): boolean;
var
  qryExec : TUniQuery ;
begin
  fStartTransaction;
  try
    qryExec := fCriaQuery ;
    try
      qryExec.Close ;
      qryExec.SQL.Clear ;
      if ModoInsert then
      begin
        qryExec.SQL.Add(fGetSqlInsertPARDFC);
        cdsParametros.DisableControls;
        cdsParametrosContas.DisableControls;
        try
          cdsParametros.First ;
          while not cdsParametros.Eof do
          begin
            qryExec.ParamByName('AUTOINCREM').AsString := cdsParametros.FieldByName('AUTOINCREM').AsString  ;
            qryExec.ParamByName('EXERCI').AsInteger := cdsParametros.FieldByName('DFC_EXERCI').AsInteger  ;
            qryExec.ParamByName('CODEMP').AsString := cdsParametros.FieldByName('DFC_CODEMP').AsString  ;
            qryExec.ParamByName('DESCRI').AsString :=  trim(cdsParametros.FieldByName('DFC_DESCRI').AsString)  ;
            qryExec.ParamByName('NIVEL_').AsInteger := cdsParametros.FieldByName('DFC_NIVEL_').AsInteger  ;
            qryExec.ParamByName('ORDEM_').AsInteger := cdsParametros.FieldByName('DFC_ORDEM_').AsInteger  ;
            qryExec.ParamByName('EDITAV').AsInteger := cdsParametros.FieldByName('DFC_EDITAV').AsInteger  ;
            qryExec.ParamByName('NEGRIT').AsInteger := cdsParametros.FieldByName('DFC_NEGRIT').AsInteger  ;
            qryExec.ParamByName('CONTAS').AsInteger := cdsParametros.FieldByName('DFC_CONTAS').AsInteger  ;
            qryExec.ExecSQL ;
            cdsParametros.Next ;
          end;

          qryExec.Close ;
          qryExec.SQL.Clear ;
          qryExec.SQL.Add(fGetSqlInsertCNTDFC) ;
          cdsParametrosContas.First;
          while not cdsParametrosContas.Eof do
          begin
            qryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CNTDFC',Vs_strCodEmp) ;
            qryExec.ParamByName('SEQLAN').AsString := cdsParametrosContas.FieldByName('DFC_SEQLAN').AsString ;
            qryExec.ParamByName('CODCON').AsString := cdsParametrosContas.FieldByName('DFC_CODCON').AsString ;
            qryExec.ExecSQL ;
            cdsParametrosContas.Next ;
          end;
        finally
          cdsParametros.EnableControls;
          cdsParametrosContas.EnableControls;
        end;
      end
      else
      begin
        qryExec.SQL.Add(fGetSqlUpdatePARDFC);
        cdsParametros.DisableControls;
        cdsParametrosContas.DisableControls;
        try
          cdsParametros.First ;
          while not cdsParametros.Eof do
          begin
            if cdsParametros.FieldByName('DFC_EDITAV').AsString = '1' then
            begin
              qryExec.ParamByName('AUTOINCREM').AsString := cdsParametros.FieldByName('AUTOINCREM').AsString  ;
              qryExec.ParamByName('DESCRI').AsString :=  trim(cdsParametros.FieldByName('DFC_DESCRI').AsString)  ;
              qryExec.ExecSQL ;
            end;
            cdsParametros.Next ;
          end;
          /////exclui e relança os dados das contas contabeis
          qryExec.Close ;
          qryExec.SQL.Clear ;
          qryExec.SQL.Add(fGetSqlDeleteCNTDFC) ;
          qryExec.ParamByName('EXERCI').AsInteger := AExercicio  ;
          qryExec.ParamByName('CODEMP').AsString := aCodEmp  ;
          qryExec.ExecSQL ;
          /////
          qryExec.Close ;
          qryExec.SQL.Clear ;
          qryExec.SQL.Add(fGetSqlInsertCNTDFC) ;
          cdsParametrosContas.First;
          while not cdsParametrosContas.Eof do
          begin
            qryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CNTDFC',Vs_strCodEmp) ;
            qryExec.ParamByName('SEQLAN').AsString := cdsParametrosContas.FieldByName('DFC_SEQLAN').AsString ;
            qryExec.ParamByName('CODCON').AsString := cdsParametrosContas.FieldByName('DFC_CODCON').AsString ;
            qryExec.ExecSQL ;
            cdsParametrosContas.Next ;
          end;
        finally
          cdsParametros.EnableControls;
          cdsParametrosContas.EnableControls;
        end;
      end;
    finally
      FreeAndNil(qryExec) ;
    end;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise ;
    End;
  End;
  result := True ;
end;

class procedure TDemonstracaoFluxoCaixaParametros.IncluirDe(
  const AExercicio: integer; const ACodEmp: String; var qryDfc: TUniquery;
  var cdsCon: TUniClientDataSet);
var
  qryCon : TUniquery ;
begin
  qryCon := fCriaQuery() ;
  try
    qryDfc.Close ;
    qryDfc.SQL.Clear ;
    qryDfc.SQL.Add(' SELECT') ;
    qryDfc.SQL.Add(' AUTOINCREM,') ;
    qryDfc.SQL.Add(' DFC_DESCRI,') ;
    qryDfc.SQL.Add(' DFC_NIVEL_,') ;
    qryDfc.SQL.Add(' DFC_ORDEM_,') ;
    qryDfc.SQL.Add(' DFC_EDITAV,') ;
    qryDfc.SQL.Add(' DFC_NEGRIT,') ;
    qryDfc.SQL.Add(' DFC_CONTAS,') ;
    qryDfc.SQL.Add(' DFC_EXERCI,') ;
    qryDfc.SQL.Add(' DFC_CODEMP') ;
    qryDfc.SQL.Add(' FROM PARDFC') ;
    qryDfc.SQL.Add(' WHERE DFC_EXERCI = :EXERCI AND COALESCE(DFC_CODEMP, "") = :CODEMP ') ;
    qryDfc.SQL.Add(' ORDER BY DFC_ORDEM_') ;
    qryDfc.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryDfc.ParamByName('CODEMP').AsString := ACodEmp ;
    qryDfc.Open ;
    qryDfc.First ;

    qryCon.Close ;
    qryCon.SQL.Clear ;
    qryCon.SQL.Add(' SELECT ') ;
    qryCon.SQL.Add('   CNTDFC.DFC_SEQLAN, ') ;
    qryCon.SQL.Add('   CNTDFC.DFC_CODCON ') ;
    qryCon.SQL.Add(' FROM CNTDFC ') ;
    qryCon.SQL.Add(' WHERE DFC_SEQLAN IN (SELECT AUTOINCREM FROM PARDFC WHERE DFC_EXERCI = :EXERCI AND COALESCE(DFC_CODEMP, "") = :CODEMP ) ') ;
    qryCon.SQL.Add(' ORDER BY CNTDFC.AUTOINCREM ') ;
    qryCon.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryCon.ParamByName('CODEMP').AsString := ACodEmp ;
    qryCon.Open ;

    cdsCon := fCriaClientDatset(qryCon);
    cdsCon.Open;
    cdsCon.IndexFieldNames := 'DFC_SEQLAN' ;

  finally
    FreeAndNil(qryCon) ;
  end;
end;

{ TDemonstracaoFluxoCaixaExercicio }

class function TDemonstracaoFluxoCaixaExercicio.Listar(const ACodEmp: String): TStringList;
var
  qryExercicio : TUniquery ;
begin
  result := TStringList.Create ;
  result.Sorted := True ;
  qryExercicio := fCriaQuery() ;
  try
    qryExercicio.Close ;
    qryExercicio.SQL.Clear ;
    qryExercicio.SQL.Add('SELECT DISTINCT DFC_EXERCI FROM PARDFC WHERE COALESCE(DFC_CODEMP, "") = :CODEMP') ;
    qryExercicio.ParamByName('CODEMP').AsString := ACodEmp ;
    qryExercicio.Open ;
    qryExercicio.First ;
    while not qryExercicio.Eof do
    begin
      result.Add( qryExercicio.FieldByName('DFC_EXERCI').AsString ) ;
      qryExercicio.Next ;
    end;
  finally
    FreeAndNil(qryExercicio) ;
  end;
end;

class function TDemonstracaoFluxoCaixaExercicio.VerificarExistente(
  const AExercicio: integer; const ACodEmp: String; const ModoInsert: Boolean): boolean;
var
  qryExerc : TUniQuery ;
begin
  result := False ;
  if not ModoInsert then
  begin
    exit ;
  end;

  qryExerc := fCriaQuery() ;
  try
    qryExerc.Close ;
    qryExerc.SQL.Clear ;
    qryExerc.SQL.Add('SELECT DFC_EXERCI FROM PARDFC WHERE DFC_EXERCI = :EXERCI AND DFC_CODEMP = :CODEMP LIMIT 1') ;
    qryExerc.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryExerc.ParamByName('CODEMP').AsString := ACodEmp ;
    qryExerc.Open ;

    result := not qryExerc.IsEmpty ;
  finally
    FreeAndNil(qryExerc) ;
  end;
end;

end.
