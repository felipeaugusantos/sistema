unit Contabilidade.Classes.TDemonstracaoValorAdicionado;

interface

uses Classes, Uni, UniClientDataSet, cxProgressBar;

const
    PARAMETROS_LINHA_MAX = 23 ;
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
                        ('1 – RECEITAS',                                                   '0', '01', '0', '1', '0'),
                        ('1.1) Vendas de Mercadorias, Produtos e Serviços',                '0', '02', '0', '0', '1'),
                        ('1.2) Provisão para Devedores Duvidosos – Reversão/Constituição', '0', '03', '0', '0', '1'),
                        ('1.3) Não Operacionais',                                          '0', '04', '0', '0', '1'),
                        ('2 – INSUMOS ADQUIRIDOS DE TERCEIROS',                            '0', '05', '0', '1', '0'),
                        ('2.1) Matérias-Primas Consumidas',                                '0', '06', '0', '0', '1'),
                        ('2.2) Custos da Mercadorias e/ou Serviços Vendidos',              '0', '07', '0', '0', '1'),
                        ('2.3) Materiais, Energia, Serviços de Terceiros e Outros',        '0', '08', '0', '0', '1'),
                        ('2.4) Perda/Recuperação de Valores Ativos',                       '0', '09', '0', '0', '1'),
                        ('3 – VALOR ADICIONADO BRUTO',                                     '0', '10', '0', '1', '0'),
                        ('4 – RETENÇÕES',                                                  '0', '11', '0', '1', '0'),
                        ('4.1) Depreciação, Amortização e Exaustão',                       '0', '12', '0', '0', '1'),
                        ('5 – VALOR ADICIONADO LIQUIDO PRODUZIDO PELA ENTIDADE',           '0', '13', '0', '1', '0'),
                        ('6 – VALOR ADICIONADO RECEBIDO EM TRANSFERÊNCIA',                 '0', '14', '0', '1', '0'),
                        ('6.1) Resultado de Equivalência Patrimonial',                     '0', '15', '0', '0', '1'),
                        ('6.2) Receitas Financeiras',                                      '0', '16', '0', '0', '1'),
                        ('7 – VALOR ADICIONADO TOTAL A DISTRIBUIR',                        '0', '17', '0', '1', '0'),
                        ('8 – DISTRIBUIÇÃO DO VALOR ADICIONADO',                           '0', '18', '0', '1', '0'),
                        ('8.1) Pessoal e Encargos',                                        '0', '19', '0', '0', '1'),
                        ('8.2) Impostos, Taxas e Contribuições',                           '0', '20', '0', '0', '1'),
                        ('8.3) Juros e Aluguéis',                                          '0', '21', '0', '0', '1'),
                        ('8.4) Juros s/ Capital Próprio e Dividendos',                     '0', '22', '0', '0', '1'),
                        ('8.5) Lucros Retidos/Prejuízo do Exercício',                      '0', '23', '0', '0', '1')
                      ) ;
    LINHAS_RECEITAS_TOTAL = [2..4] ;
    LINHAS_INSUMOS_ADQUIRIDOS_TERCEIROS_TOTAL = [6..9] ;
    LINHAS_RETENCOES_TOTAL = [12..12] ;
    LINHAS_VALOR_ADICIONADO_RECEBIDO_TRANSFERENCIA_TOTAL = [15..16] ;
    LINHAS_DISTRIBUICAO_VALOR_ADICIONADO_TOTAL = [19..23] ;

    LINHA_RECEITAS = 1 ;
    LINHA_INSUMOS_ADQUIRIDOS_TERCEIROS = 5 ;
    LINHA_ADICIONADO_BRUTO = 10 ;
    LINHA_RETENCOES = 11 ;
    LINHA_VALOR_ADICIONADO_LIQUIDO_PRODUZIDO_ENTIDADE = 13 ;
    LINHA_VALOR_ADICIONADO_RECEBIDO_TRANSFERENCIA = 14 ;
    LINHA_VALOR_ADICIONADO_TOTAL_DISTRIBUIR = 17 ;
    LINHA_DISTRIBUICAO_VALOR_ADICIONADO = 18 ;

type
  TDemonstracaoValorAdicionadoGerar = class
  private
    FAnoExercicio: integer ;
    FEmpresas: TStringList ;
    FProgresso: TcxProgressBar ;
    class function fEmpresasToStr(const ALstEmpresas: TStringList):string ;
    class procedure pCarregaValoresContaContabil(const AExercicio: integer; const ALstEmpresas: TStringList; var cdsGerar: TUniClientDataSet) ;
    class function fPreparaFiltroEmpresa(const ANomerabela, AColEmpresa: string; const ALstEmpresas: TStringList):string ;
    class procedure pSomaValoresItens(const ACdsCtaDva, ACdsLanCreAtu, ACdsLanCreAnt, ACdsLanDebAtu, ACdsLanDebAnt: TUniClientDataSet; var AFltTotalCreditoAtu, AFltTotalCreditoAnt, AFltTotalDebitoAtu, AFltTotalDebitoAnt: double) ;
    class procedure pTotalizaCalcularTotais(var AfltReceitas,
                                                AfltReceitasAnt,
                                                AfltInsumosAdquiridos,
                                                AfltInsumosAdquiridosAnt,
                                                AfltRetencoes,
                                                AfltRetencoesAnt,
                                                AfltValorAdicionadoTransferencia,
                                                AfltValorAdicionadoTransferenciaAnt,
                                                AfltDistribuicaoValorAdicionado,
                                                AfltDistribuicaoValorAdicionadoAnt : double;
                                                const cdsGerar: TUniClientDataSet);
  public
    property AnoExercicio : integer read FAnoExercicio write FAnoExercicio ;
    property Empresas : TStringList read FEmpresas write FEmpresas ;
    property Progresso : TcxProgressBar read FProgresso write FProgresso ;
    function Processar:TUniClientDataset ;
    constructor Create;
    destructor Destroy; override;
    class procedure CalcularTotais(const AExercicio: integer; const ALstEmpresas: TStringList; var cdsGerar: TUniClientDataSet) ;
  end;

  TDemonstracaoValorAdicionadoParametros = class
  private
    class function fGetSqlInsertPARDVA: string;
    class function fGetSqlInsertCNTDVA: string;
    class function fGetSqlDeleteCNTDVA: string;
    class function fGetSqlDeletePARDVA: string;
  public
    class procedure Carregar(const AExercicio: integer; const ACodEmp: String; var cdsParametros, cdsParametrosContas : TUniClientDataSet) ;
    class function Gravar(const AExercicio: integer; const ACodEmp: String; const cdsParametros, cdsParametrosContas : TUniClientDataSet; const ModoInsert: Boolean):boolean ;
    class function Deletar(const AExercicio: integer; const ACodEmp: String):boolean ;
    class procedure IncluirDe(const AExercicio: integer; const ACodEmp: String; var qryDva : TUniquery; var cdsCon : TUniClientDataSet) ;
  end;

  TDemonstracaoValorAdicionadoExercicio = class
  public
    class function Listar(const ACodEmp: String):TStringList ;
    class function VerificarExistente(const AExercicio: integer; const ACodEmp: String; const ModoInsert: Boolean):boolean ;
  end;

implementation

uses untFuncoesSimples, SysUtils, DB, VCL.Forms, System.JSON, Contabilidade.Funcoes ;

{ TDemonstracaoValorAdicionadoGerar }

class procedure TDemonstracaoValorAdicionadoGerar.pCarregaValoresContaContabil(
  const AExercicio: integer; const ALstEmpresas: TStringList;
  var cdsGerar: TUniClientDataSet);
var
  qryCtaDva : TUniQuery ;
  cdsCtaDva : TUniClientDataSet ;
  strSqlCta : String ;
  strSqlDeb : String ;
  strSqlCre : string ;
  JsonArr   : TJSONArray ;
  strCta    : string ;

  qryLanCre : TUniQuery ;
  cdsLanCreAtu : TUniClientDataSet ;
  cdsLanCreAnt : TUniClientDataSet ;
  strFilCre : String ;
  qryLanDeb : TUniQuery ;
  cdsLanDebAtu : TUniClientDataSet ;
  cdsLanDebAnt : TUniClientDataSet ;
  strFilDeb : string ;
  fltTotalDebitoAtu : Double ;
  fltTotalDebitoAnt : Double ;
  fltTotalCreditoAtu : Double ;
  fltTotalCreditoAnt : Double ;
  strTplaco : String ;
begin
  qryCtaDva := fCriaQuery() ;
  JsonArr := TJSONArray.Create;
  qryLanCre := fCriaQuery() ;
  qryLanDeb := fCriaQuery() ;
  strTplaco := fRetTplacoEmpresaLogada ;
  try
    strSqlCta := '' ;
    strSqlCta := strSqlCta + ' SELECT DVA_ORDEM_, DVA_CODCON, PLANCO.NCO_CODCON ' ;
    strSqlCta := strSqlCta + ' FROM PARDVA ' ;
    strSqlCta := strSqlCta + '      INNER JOIN CNTDVA ON CNTDVA.DVA_SEQLAN = PARDVA.AUTOINCREM ' ;
    strSqlCta := strSqlCta + '      LEFT JOIN PLANCO ON NCO_CODCON LIKE CONCAT(DVA_CODCON,"%") AND NCO_NATURE = "A" AND NCO_TPLACO = '+ strTplaco.QuotedString ;
    strSqlCta := strSqlCta + ' WHERE PARDVA.DVA_EXERCI = :EXERCI ' ;
    strSqlCta := strSqlCta + ' ORDER BY DVA_ORDEM_, DVA_CODCON, PLANCO.NCO_CODCON ' ;

    qryCtaDva.Close ;
    qryCtaDva.SQL.Clear ;
    qryCtaDva.SQL.Add(strSqlCta) ;
    qryCtaDva.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryCtaDva.Open ;

    cdsCtaDva := fCriaClientDatset(qryCtaDva) ;
    cdsCtaDva.IndexFieldNames := 'DVA_ORDEM_' ;

    ////separa as contas para buscar os valores na lancon
    cdsCtaDva.DisableControls ;
    try
      cdsCtaDva.First ;
      while not cdsCtaDva.Eof do
      begin
        JsonArr.AddElement(TJSONString.Create(cdsCtaDva.FieldByName('NCO_CODCON').AsString));
        cdsCtaDva.Next ;
      end;
    finally
      cdsCtaDva.EnableControls ;
    end;
    strCta := JsonArr.ToString.Replace('[','').Replace(']','') ;

    if fEmptyStr(strCta) then
    begin
      exit ;
    end;

    strFilDeb := fPreparaFiltroEmpresa('LANCON', 'CON_EMPLAN', ALstEmpresas) ;
    strFilCre := fPreparaFiltroEmpresa('LANCON', 'CON_EMPLAN', ALstEmpresas) ;

    strSqlDeb := '' ;
    strSqlDeb := strSqlDeb + ' SELECT LANCON.CON_CONDEB AS CODCON, SUM(COALESCE(LANCON.CON_VALLAN,0.00)) AS VALOR_DEBITO ' ;
    strSqlDeb := strSqlDeb + ' FROM LANCON ' ;
    strSqlDeb := strSqlDeb + ' WHERE EXTRACT(YEAR FROM LANCON.CON_DTALAN) = :EXERCI ' ;
    strSqlDeb := strSqlDeb + '       AND COALESCE(LANCON.CON_TIPLAN,"") <> "FEC" ' ;
    strSqlDeb := strSqlDeb + '       AND LANCON.CON_CONDEB IN (' + strCta + ') ' ;
    strSqlDeb := strSqlDeb + ' 			                 ' + strFilDeb ;
    strSqlDeb := strSqlDeb + ' GROUP BY LANCON.CON_CONDEB ' ;

    qryLanDeb.Close ;
    qryLanDeb.SQL.Clear ;
    qryLanDeb.SQL.Add(strSqlDeb) ;
    qryLanDeb.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryLanDeb.Open ;

    cdsLanDebAtu := fCriaClientDatset(qryLanDeb) ;
    cdsLanDebAtu.IndexFieldNames := 'CODCON' ;

    qryLanDeb.Close ;
    qryLanDeb.ParamByName('EXERCI').AsInteger := AExercicio-1 ;
    qryLanDeb.Open ;

    cdsLanDebAnt := fCriaClientDatset(qryLanDeb) ;
    cdsLanDebAnt.IndexFieldNames := 'CODCON' ;

    strSqlCre := '' ;
    strSqlCre := strSqlCre + ' SELECT LANCON.CON_CONCRE AS CODCON, SUM(COALESCE(LANCON.CON_VALLAN,0.00)) AS VALOR_CREDITO ' ;
    strSqlCre := strSqlCre + ' FROM LANCON ' ;
    strSqlCre := strSqlCre + ' WHERE EXTRACT(YEAR FROM LANCON.CON_DTALAN) = :EXERCI ' ;
    strSqlCre := strSqlCre + '       AND COALESCE(LANCON.CON_TIPLAN,"") <> "FEC" ' ;
    strSqlCre := strSqlCre + '       AND LANCON.CON_CONCRE IN (' + strCta + ') ' ;
    strSqlCre := strSqlCre + ' 			                 ' + strFilCre ;
    strSqlCre := strSqlCre + ' GROUP BY LANCON.CON_CONCRE ' ;

    qryLanCre.Close ;
    qryLanCre.SQL.Clear ;
    qryLanCre.SQL.Add(strSqlCre) ;
    qryLanCre.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryLanCre.Open ;

    cdsLanCreAtu := fCriaClientDatset(qryLanCre) ;
    cdsLanCreAtu.IndexFieldNames := 'CODCON' ;

    qryLanCre.Close ;
    qryLanCre.ParamByName('EXERCI').AsInteger := AExercicio-1 ;
    qryLanCre.Open ;

    cdsLanCreAnt := fCriaClientDatset(qryLanCre) ;
    cdsLanCreAnt.IndexFieldNames := 'CODCON' ;

    //////inicia o processamento
    cdsGerar.DisableControls ;
    try
      cdsGerar.First ;
      while not cdsGerar.Eof do
      begin
        if cdsCtaDva.FindKey([cdsGerar.FieldByName('DVA_ORDEM_').AsInteger]) then
        begin
          fltTotalDebitoAtu := 0.00 ;
          fltTotalDebitoAnt := 0.00 ;
          fltTotalCreditoAtu := 0.00 ;
          fltTotalCreditoAnt := 0.00 ;
          while (cdsGerar.FieldByName('DVA_ORDEM_').AsInteger = cdsCtaDva.FieldByName('DVA_ORDEM_').AsInteger)
                and ( not cdsCtaDva.Eof ) do
          begin
            pSomaValoresItens(cdsCtaDva,
                              cdsLanCreAtu,
                              cdsLanCreAnt,
                              cdsLanDebAtu,
                              cdsLanDebAnt,
                              fltTotalCreditoAtu,
                              fltTotalCreditoAnt,
                              fltTotalDebitoAtu,
                              fltTotalDebitoAnt) ;

            cdsCtaDva.Next ;
          end;
          cdsGerar.Edit ;
          cdsGerar.FieldByName('DVA_EXERCI').AsFloat := fltTotalDebitoAtu - fltTotalCreditoAtu ;
          cdsGerar.FieldByName('DVA_EXEANT').AsFloat := fltTotalDebitoAnt - fltTotalCreditoAnt ;
          cdsGerar.Post ;
        end;
        cdsGerar.Next ;
      end;
    finally
      cdsGerar.EnableControls ;
    end;

  finally
    FreeAndNil(qryCtaDva) ;
    FreeAndNil(cdsCtaDva) ;
    FreeAndNil(JsonArr) ;

    FreeAndNil(qryLanCre) ;
    FreeAndNil(cdsLanCreAnt) ;
    FreeAndNil(cdsLanCreAtu) ;

    FreeAndNil(qryLanDeb) ;
    FreeAndNil(cdsLanDebAnt) ;
    FreeAndNil(cdsLanDebAtu) ;
  end;
end;

constructor TDemonstracaoValorAdicionadoGerar.Create;
begin
  FEmpresas := TStringList.Create;
end;

destructor TDemonstracaoValorAdicionadoGerar.Destroy;
begin
  FreeAndNil(FEmpresas) ;
  inherited;
end;

class function TDemonstracaoValorAdicionadoGerar.fEmpresasToStr(const ALstEmpresas: TStringList): string;
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

class procedure TDemonstracaoValorAdicionadoGerar.CalcularTotais(const AExercicio: integer;
  const ALstEmpresas: TStringList;
  var cdsGerar: TUniClientDataSet);
var
  fltReceitas, fltInsumosAdquiridos, fltRetencoes: double ;
  fltValorAdicionadoTransferencia, fltDistribuicaoValorAdicionado: double ;

  fltReceitasAnt, fltInsumosAdquiridosAnt, fltRetencoesAnt: double ;
  fltValorAdicionadoTransferenciaAnt, fltDistribuicaoValorAdicionadoAnt: double ;

  fltTotalAdicionadoBruto, fltTotalAdicionadoBrutoAnt: double ;
  fltValorAdicionadoLiquidoProduzidoEntidade, fltValorAdicionadoLiquidoProduzidoEntidadeAnt: double ;

  fltValorAdicionadoTotalDistribuir, fltValorAdicionadoTotalDistribuirAnt: double;

  intLinha : integer ;
begin

  cdsGerar.DisableControls ;
  try
    intLinha := cdsGerar.FieldByName('DVA_ORDEM_').AsInteger ;
    /////totaliza os agrupamentos.
    fltReceitas := 0.00 ;
    fltInsumosAdquiridos := 0.00 ;
    fltRetencoes := 0.00 ;
    fltValorAdicionadoTransferencia := 0.00 ;
    fltDistribuicaoValorAdicionado := 0.00 ;

    fltReceitasAnt := 0.00 ;
    fltInsumosAdquiridosAnt := 0.00 ;
    fltRetencoesAnt := 0.00 ;
    fltValorAdicionadoTransferenciaAnt := 0.00 ;
    fltDistribuicaoValorAdicionadoAnt := 0.00 ;

    cdsGerar.First ;
    while not cdsGerar.Eof do
    begin
      pTotalizaCalcularTotais(
        fltReceitas, fltReceitasAnt, fltInsumosAdquiridos,
        fltInsumosAdquiridosAnt, fltRetencoes, fltRetencoesAnt,
        fltValorAdicionadoTransferencia, fltValorAdicionadoTransferenciaAnt,
        fltDistribuicaoValorAdicionado, fltDistribuicaoValorAdicionadoAnt,
        cdsGerar);

      cdsGerar.Next ;
    end;

    if cdsGerar.Locate('DVA_ORDEM_', LINHA_RECEITAS, []) then
    begin
      cdsGerar.Edit ;
      cdsGerar.FieldByName('DVA_EXERCI').AsFloat := fltReceitas ;
      cdsGerar.FieldByName('DVA_EXEANT').AsFloat := fltReceitasAnt ;
      cdsGerar.Post ;
    end;

    if cdsGerar.Locate('DVA_ORDEM_', LINHA_INSUMOS_ADQUIRIDOS_TERCEIROS, []) then
    begin
      cdsGerar.Edit ;
      cdsGerar.FieldByName('DVA_EXERCI').AsFloat := fltInsumosAdquiridos ;
      cdsGerar.FieldByName('DVA_EXEANT').AsFloat := fltInsumosAdquiridosAnt ;
      cdsGerar.Post ;
    end;

    fltTotalAdicionadoBruto := fltReceitas - fltInsumosAdquiridos ;
    fltTotalAdicionadoBrutoAnt := fltReceitasAnt - fltInsumosAdquiridosAnt ;
    if cdsGerar.Locate('DVA_ORDEM_', LINHA_ADICIONADO_BRUTO, []) then
    begin
      cdsGerar.Edit ;
      cdsGerar.FieldByName('DVA_EXERCI').AsFloat := fltTotalAdicionadoBruto ;
      cdsGerar.FieldByName('DVA_EXEANT').AsFloat := fltTotalAdicionadoBrutoAnt ;
      cdsGerar.Post ;
    end;

    if cdsGerar.Locate('DVA_ORDEM_', LINHA_RETENCOES, []) then
    begin
      cdsGerar.Edit ;
      cdsGerar.FieldByName('DVA_EXERCI').AsFloat := fltRetencoes ;
      cdsGerar.FieldByName('DVA_EXEANT').AsFloat := fltRetencoesAnt ;
      cdsGerar.Post ;
    end;

    fltValorAdicionadoLiquidoProduzidoEntidade := fltTotalAdicionadoBruto - fltRetencoes ;
    fltValorAdicionadoLiquidoProduzidoEntidadeAnt := fltTotalAdicionadoBrutoAnt - fltRetencoesAnt ;
    if cdsGerar.Locate('DVA_ORDEM_', LINHA_VALOR_ADICIONADO_LIQUIDO_PRODUZIDO_ENTIDADE, []) then
    begin
      cdsGerar.Edit ;
      cdsGerar.FieldByName('DVA_EXERCI').AsFloat := fltValorAdicionadoLiquidoProduzidoEntidade ;
      cdsGerar.FieldByName('DVA_EXEANT').AsFloat := fltValorAdicionadoLiquidoProduzidoEntidadeAnt ;
      cdsGerar.Post ;
    end;

    if cdsGerar.Locate('DVA_ORDEM_', LINHA_VALOR_ADICIONADO_RECEBIDO_TRANSFERENCIA, []) then
    begin
      cdsGerar.Edit ;
      cdsGerar.FieldByName('DVA_EXERCI').AsFloat := fltValorAdicionadoTransferencia ;
      cdsGerar.FieldByName('DVA_EXEANT').AsFloat := fltValorAdicionadoTransferenciaAnt ;
      cdsGerar.Post ;
    end;

    fltValorAdicionadoTotalDistribuir := fltValorAdicionadoLiquidoProduzidoEntidade + fltValorAdicionadoTransferencia ;
    fltValorAdicionadoTotalDistribuirAnt := fltValorAdicionadoLiquidoProduzidoEntidadeAnt + fltValorAdicionadoTransferenciaAnt ;
    if cdsGerar.Locate('DVA_ORDEM_', LINHA_VALOR_ADICIONADO_TOTAL_DISTRIBUIR, []) then
    begin
      cdsGerar.Edit ;
      cdsGerar.FieldByName('DVA_EXERCI').AsFloat := fltValorAdicionadoTotalDistribuir ;
      cdsGerar.FieldByName('DVA_EXEANT').AsFloat := fltValorAdicionadoTotalDistribuirAnt ;
      cdsGerar.Post ;
    end;

    if cdsGerar.Locate('DVA_ORDEM_', LINHA_DISTRIBUICAO_VALOR_ADICIONADO, []) then
    begin
      cdsGerar.Edit ;
      cdsGerar.FieldByName('DVA_EXERCI').AsFloat := fltDistribuicaoValorAdicionado ;
      cdsGerar.FieldByName('DVA_EXEANT').AsFloat := fltDistribuicaoValorAdicionadoAnt ;
      cdsGerar.Post ;
    end;

    ///restaura a linha antes do processamento
    cdsGerar.Locate('DVA_ORDEM_', intLinha, [])

  finally
    cdsGerar.EnableControls ;
  end;
end;

class function TDemonstracaoValorAdicionadoGerar.fPreparaFiltroEmpresa(
  const ANomerabela, AColEmpresa: string; const ALstEmpresas: TStringList): string;
begin
  result := fEmpresasToStr(ALstEmpresas) ;
  if not fEmptyStr(result) then
  begin
    result := ' AND ' + ANomerabela + '.' + AColEmpresa + ' IN ('+result+') ' ;
  end;
end;

function TDemonstracaoValorAdicionadoGerar.Processar: TUniClientDataset;
var
  qryGerar : TUniQuery ;
  cdsGerar : TUniClientDataset ;
begin
  result := nil ;

  if FAnoExercicio <= 0 then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não selecionado!' , ['&Ok']);
    exit ;
  end;

  qryGerar := fCriaQuery() ;
  try
    qryGerar.Close ;
    qryGerar.SQL.Clear ;
    qryGerar.SQL.Add(' SELECT DVA_ORDEM_, CAST(CONCAT(REPEAT(" ",DVA_NIVEL_*3), DVA_DESCRI) AS CHAR(150)) AS DVA_DESCRI, ') ;
    qryGerar.SQL.Add('   CAST(NULL AS DECIMAL(12,2)) AS DVA_EXERCI, ') ;
    qryGerar.SQL.Add('   CAST(NULL AS DECIMAL(12,2)) AS DVA_EXEANT, ') ;
    qryGerar.SQL.Add('    DVA_CONTAS, DVA_NEGRIT ') ;
    qryGerar.SQL.Add(' FROM PARDVA LEFT JOIN CNTDVA ON CNTDVA.DVA_SEQLAN = PARDVA.AUTOINCREM ') ;
    qryGerar.SQL.Add(' WHERE PARDVA.DVA_EXERCI = :EXERCI ') ;
    qryGerar.SQL.Add(' GROUP BY DVA_ORDEM_, DVA_NIVEL_, DVA_DESCRI, DVA_CONTAS, DVA_NEGRIT ') ;
    qryGerar.SQL.Add(' ORDER BY DVA_ORDEM_ ') ;
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

class procedure TDemonstracaoValorAdicionadoGerar.pSomaValoresItens(
  const ACdsCtaDva, ACdsLanCreAtu, ACdsLanCreAnt, ACdsLanDebAtu, ACdsLanDebAnt: TUniClientDataSet;
  var AFltTotalCreditoAtu,AFltTotalCreditoAnt, AFltTotalDebitoAtu, AFltTotalDebitoAnt: double);
begin
  ///credito
  if ACdsLanCreAtu.FindKey([ACdsCtaDva.FieldByName('NCO_CODCON').AsString]) then
  begin
    while (ACdsCtaDva.FieldByName('NCO_CODCON').AsString = ACdsLanCreAtu.FieldByName('CODCON').AsString)
          and ( not ACdsLanCreAtu.Eof )  do
    begin
      AFltTotalCreditoAtu := AFltTotalCreditoAtu + ACdsLanCreAtu.FieldByName('VALOR_CREDITO').AsFloat ;
      ACdsLanCreAtu.Next ;
    end;
  end;
  if ACdsLanCreAnt.FindKey([ACdsCtaDva.FieldByName('NCO_CODCON').AsString]) then
  begin
    while (ACdsCtaDva.FieldByName('NCO_CODCON').AsString = ACdsLanCreAnt.FieldByName('CODCON').AsString)
          and ( not ACdsLanCreAnt.Eof )  do
    begin
      AFltTotalCreditoAnt := AFltTotalCreditoAnt + ACdsLanCreAnt.FieldByName('VALOR_CREDITO').AsFloat ;
      ACdsLanCreAnt.Next ;
    end;
  end;
  ///debito
  if ACdsLanDebAtu.FindKey([ACdsCtaDva.FieldByName('NCO_CODCON').AsString]) then
  begin
    while (ACdsCtaDva.FieldByName('NCO_CODCON').AsString = ACdsLanDebAtu.FieldByName('CODCON').AsString)
          and ( not ACdsLanDebAtu.Eof )  do
    begin
      AFltTotalDebitoAtu := AFltTotalDebitoAtu + ACdsLanDebAtu.FieldByName('VALOR_DEBITO').AsFloat ;
      ACdsLanDebAtu.Next ;
    end;
  end;
  if ACdsLanDebAnt.FindKey([ACdsCtaDva.FieldByName('NCO_CODCON').AsString]) then
  begin
    while (ACdsCtaDva.FieldByName('NCO_CODCON').AsString = ACdsLanDebAnt.FieldByName('CODCON').AsString)
          and ( not ACdsLanDebAnt.Eof )  do
    begin
      AFltTotalDebitoAnt := AFltTotalDebitoAnt + ACdsLanDebAnt.FieldByName('VALOR_DEBITO').AsFloat ;
      ACdsLanDebAnt.Next ;
    end;
  end;
end;

class procedure TDemonstracaoValorAdicionadoGerar.pTotalizaCalcularTotais(
  var AfltReceitas, AfltReceitasAnt, AfltInsumosAdquiridos,
  AfltInsumosAdquiridosAnt, AfltRetencoes, AfltRetencoesAnt,
  AfltValorAdicionadoTransferencia, AfltValorAdicionadoTransferenciaAnt,
  AfltDistribuicaoValorAdicionado, AfltDistribuicaoValorAdicionadoAnt: double;
  const cdsGerar: TUniClientDataSet);
begin
  if cdsGerar.FieldByName('DVA_ORDEM_').AsInteger in LINHAS_RECEITAS_TOTAL then
  begin
    AfltReceitas := AfltReceitas + cdsGerar.FieldByName('DVA_EXERCI').AsFloat ;
    AfltReceitasAnt := AfltReceitasAnt + cdsGerar.FieldByName('DVA_EXEANT').AsFloat ;
  end;

  if cdsGerar.FieldByName('DVA_ORDEM_').AsInteger in LINHAS_INSUMOS_ADQUIRIDOS_TERCEIROS_TOTAL then
  begin
    AfltInsumosAdquiridos := AfltInsumosAdquiridos + cdsGerar.FieldByName('DVA_EXERCI').AsFloat ;
    AfltInsumosAdquiridosAnt := AfltInsumosAdquiridosAnt + cdsGerar.FieldByName('DVA_EXEANT').AsFloat ;
  end;

  if cdsGerar.FieldByName('DVA_ORDEM_').AsInteger in LINHAS_RETENCOES_TOTAL then
  begin
    AfltRetencoes := AfltRetencoes + cdsGerar.FieldByName('DVA_EXERCI').AsFloat ;
    AfltRetencoesAnt := AfltRetencoesAnt + cdsGerar.FieldByName('DVA_EXEANT').AsFloat ;
  end;

  if cdsGerar.FieldByName('DVA_ORDEM_').AsInteger in LINHAS_VALOR_ADICIONADO_RECEBIDO_TRANSFERENCIA_TOTAL then
  begin
    AfltValorAdicionadoTransferencia := AfltValorAdicionadoTransferencia + cdsGerar.FieldByName('DVA_EXERCI').AsFloat ;
    AfltValorAdicionadoTransferenciaAnt := AfltValorAdicionadoTransferenciaAnt + cdsGerar.FieldByName('DVA_EXEANT').AsFloat ;
  end;

  if cdsGerar.FieldByName('DVA_ORDEM_').AsInteger in LINHAS_DISTRIBUICAO_VALOR_ADICIONADO_TOTAL then
  begin
    AfltDistribuicaoValorAdicionado := AfltDistribuicaoValorAdicionado + cdsGerar.FieldByName('DVA_EXERCI').AsFloat ;
    AfltDistribuicaoValorAdicionadoAnt := AfltDistribuicaoValorAdicionadoAnt + cdsGerar.FieldByName('DVA_EXEANT').AsFloat ;
  end;
end;

{ TDemonstracaoValorAdicionadoParametros }

class procedure TDemonstracaoValorAdicionadoParametros.Carregar(
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
  strSql := strSql + '  DVA_EXERCI, ' ;
  strSql := strSql + '  DVA_CODEMP, ' ;
  strSql := strSql + '  CAST(CONCAT(REPEAT(" ",DVA_NIVEL_*3), DVA_DESCRI) AS CHAR(150)) AS DVA_DESCRI, ' ;
  strSql := strSql + '  DVA_NIVEL_, ' ;
  strSql := strSql + '  DVA_ORDEM_, ' ;
  strSql := strSql + '  DVA_EDITAV, ' ;
  strSql := strSql + '  DVA_NEGRIT, ' ;
  strSql := strSql + '  DVA_CONTAS, ' ;
  strSql := strSql + '  (CAST(NULL AS CHAR(4))) AS CNT_BTN ' ;
  strSql := strSql + ' FROM PARDVA ' ;
  strSql := strSql + ' WHERE DVA_EXERCI = :EXERCI AND COALESCE(DVA_CODEMP, "") = :CODEMP ' ;
  strSql := strSql + ' ORDER BY DVA_ORDEM_' ;

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

  ////contas associadas aos parametros.
  strTplaco := fRetTplacoEmpresaLogada ;
  strSql := '' ;
  strSql := strSql + ' SELECT ' ;
  strSql := strSql + ' CNTDVA.AUTOINCREM, ' ;
  strSql := strSql + ' CNTDVA.DVA_SEQLAN, ' ;
  strSql := strSql + ' CNTDVA.DVA_CODCON, ' ;
  strSql := strSql + ' PLANCO.NCO_DESCRI ' ;
  strSql := strSql + ' FROM CNTDVA INNER JOIN PLANCO ON CNTDVA.DVA_CODCON = PLANCO.NCO_CODCON AND PLANCO.NCO_TPLACO = ' + strTplaco.QuotedString ;
  strSql := strSql + ' WHERE CNTDVA.DVA_SEQLAN in ('+ strCnt +') ' ;
  strSql := strSql + ' ORDER BY CNTDVA.AUTOINCREM ' ;

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
    cdsParametrosContas.IndexFieldNames := 'DVA_CODCON;DVA_SEQLAN' ;
  finally
    FreeAndNil(qryParametrosContas);
  end;

end;

class function TDemonstracaoValorAdicionadoParametros.Deletar(
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
      qryExec.SQL.Add(fGetSqlDeletePARDVA);
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

class function TDemonstracaoValorAdicionadoParametros.fGetSqlDeleteCNTDVA: string;
begin
  result := 'DELETE FROM CNTDVA WHERE DVA_SEQLAN IN (SELECT AUTOINCREM FROM PARDVA WHERE DVA_EXERCI = :EXERCI AND COALESCE(DVA_CODEMP, "") = :CODEMP) ;' ;
end;

class function TDemonstracaoValorAdicionadoParametros.fGetSqlDeletePARDVA: string;
begin
  result := 'DELETE FROM PARDVA WHERE DVA_EXERCI = :EXERCI AND COALESCE(DVA_CODEMP, "") = :CODEMP; ' ;
end;

class function TDemonstracaoValorAdicionadoParametros.fGetSqlInsertCNTDVA: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO CNTDVA ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' AUTOINCREM, ' ;
  strSql := strSql + ' DVA_SEQLAN, ' ;
  strSql := strSql + ' DVA_CODCON ' ;
  strSql := strSql + ' ) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' :AUTOINCREM, ' ;
  strSql := strSql + ' :SEQLAN, ' ;
  strSql := strSql + ' :CODCON ' ;
  strSql := strSql + ' ); ' ;

  result := strSql ;
end;

class function TDemonstracaoValorAdicionadoParametros.fGetSqlInsertPARDVA: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO PARDVA ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' AUTOINCREM, ' ;
  strSql := strSql + ' DVA_EXERCI, ' ;
  strSql := strSql + ' DVA_CODEMP, ' ;
  strSql := strSql + ' DVA_DESCRI, ' ;
  strSql := strSql + ' DVA_NIVEL_, ' ;
  strSql := strSql + ' DVA_ORDEM_, ' ;
  strSql := strSql + ' DVA_EDITAV, ' ;
  strSql := strSql + ' DVA_NEGRIT, ' ;
  strSql := strSql + ' DVA_CONTAS ' ;
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

class function TDemonstracaoValorAdicionadoParametros.Gravar(const AExercicio: integer; const ACodEmp: String; const cdsParametros,
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
        qryExec.SQL.Add(fGetSqlInsertPARDVA);
        cdsParametros.DisableControls;
        cdsParametrosContas.DisableControls;
        try
          cdsParametros.First ;
          while not cdsParametros.Eof do
          begin
            qryExec.ParamByName('AUTOINCREM').AsString := cdsParametros.FieldByName('AUTOINCREM').AsString  ;
            qryExec.ParamByName('EXERCI').AsInteger := cdsParametros.FieldByName('DVA_EXERCI').AsInteger  ;
            qryExec.ParamByName('CODEMP').AsString := cdsParametros.FieldByName('DVA_CODEMP').AsString  ;
            qryExec.ParamByName('DESCRI').AsString :=  trim(cdsParametros.FieldByName('DVA_DESCRI').AsString)  ;
            qryExec.ParamByName('NIVEL_').AsInteger := cdsParametros.FieldByName('DVA_NIVEL_').AsInteger  ;
            qryExec.ParamByName('ORDEM_').AsInteger := cdsParametros.FieldByName('DVA_ORDEM_').AsInteger  ;
            qryExec.ParamByName('EDITAV').AsInteger := cdsParametros.FieldByName('DVA_EDITAV').AsInteger  ;
            qryExec.ParamByName('NEGRIT').AsInteger := cdsParametros.FieldByName('DVA_NEGRIT').AsInteger  ;
            qryExec.ParamByName('CONTAS').AsInteger := cdsParametros.FieldByName('DVA_CONTAS').AsInteger  ;
            qryExec.ExecSQL ;
            cdsParametros.Next ;
          end;

          qryExec.Close ;
          qryExec.SQL.Clear ;
          qryExec.SQL.Add(fGetSqlInsertCNTDVA) ;
          cdsParametrosContas.First;
          while not cdsParametrosContas.Eof do
          begin
            qryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CNTDVA',Vs_strCodEmp) ;
            qryExec.ParamByName('SEQLAN').AsString := cdsParametrosContas.FieldByName('DVA_SEQLAN').AsString ;
            qryExec.ParamByName('CODCON').AsString := cdsParametrosContas.FieldByName('DVA_CODCON').AsString ;
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
        cdsParametros.DisableControls;
        cdsParametrosContas.DisableControls;
        try
          /////exclui e relança os dados das contas contabeis
          qryExec.Close ;
          qryExec.SQL.Clear ;
          qryExec.SQL.Add(fGetSqlDeleteCNTDVA) ;
          qryExec.ParamByName('EXERCI').AsInteger := AExercicio  ;
          qryExec.ParamByName('CODEMP').AsString := ACodEmp  ;
          qryExec.ExecSQL ;
          /////
          qryExec.Close ;
          qryExec.SQL.Clear ;
          qryExec.SQL.Add(fGetSqlInsertCNTDVA) ;
          cdsParametrosContas.First;
          while not cdsParametrosContas.Eof do
          begin
            qryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CNTDVA',Vs_strCodEmp) ;
            qryExec.ParamByName('SEQLAN').AsString := cdsParametrosContas.FieldByName('DVA_SEQLAN').AsString ;
            qryExec.ParamByName('CODCON').AsString := cdsParametrosContas.FieldByName('DVA_CODCON').AsString ;
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

class procedure TDemonstracaoValorAdicionadoParametros.IncluirDe(
  const AExercicio: integer; const ACodEmp: String; var qryDva: TUniquery;
  var cdsCon: TUniClientDataSet);
var
  qryCon : TUniquery ;
begin
  qryCon := fCriaQuery() ;
  try
    qryDva.Close ;
    qryDva.SQL.Clear ;
    qryDva.SQL.Add(' SELECT') ;
    qryDva.SQL.Add(' AUTOINCREM,') ;
    qryDva.SQL.Add(' DVA_CODEMP,') ;
    qryDva.SQL.Add(' DVA_DESCRI,') ;
    qryDva.SQL.Add(' DVA_NIVEL_,') ;
    qryDva.SQL.Add(' DVA_ORDEM_,') ;
    qryDva.SQL.Add(' DVA_EDITAV,') ;
    qryDva.SQL.Add(' DVA_NEGRIT,') ;
    qryDva.SQL.Add(' DVA_CONTAS') ;
    qryDva.SQL.Add(' FROM PARDVA') ;
    qryDva.SQL.Add(' WHERE DVA_EXERCI = :EXERCI AND COALESCE(DVA_CODEMP, "") = :CODEMP') ;
    qryDva.SQL.Add(' ORDER BY DVA_ORDEM_') ;
    qryDva.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryDva.ParamByName('CODEMP').AsString := ACodEmp ;
    qryDva.Open ;
    qryDva.First ;

    qryCon.Close ;
    qryCon.SQL.Clear ;
    qryCon.SQL.Add(' SELECT ') ;
    qryCon.SQL.Add('   CNTDVA.DVA_SEQLAN, ') ;
    qryCon.SQL.Add('   CNTDVA.DVA_CODCON ') ;
    qryCon.SQL.Add(' FROM CNTDVA ') ;
    qryCon.SQL.Add(' WHERE DVA_SEQLAN IN (SELECT AUTOINCREM FROM PARDVA WHERE DVA_EXERCI = :EXERCI  AND COALESCE(DVA_CODEMP, "") = :CODEMP) ') ;
    qryCon.SQL.Add(' ORDER BY CNTDVA.AUTOINCREM ') ;
    qryCon.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryCon.ParamByName('CODEMP').AsString := ACodEmp ;
    qryCon.Open ;

    cdsCon := fCriaClientDatset(qryCon);
    cdsCon.Open;
    cdsCon.IndexFieldNames := 'DVA_SEQLAN' ;

  finally
    FreeAndNil(qryCon) ;
  end;
end;

{ TDemonstracaoValorAdicionadoExercicio }

class function TDemonstracaoValorAdicionadoExercicio.Listar(const ACodEmp: String): TStringList;
var
  qryExercicio : TUniquery ;
begin
  result := TStringList.Create ;
  result.Sorted := True ;
  qryExercicio := fCriaQuery() ;
  try
    qryExercicio.Close ;
    qryExercicio.SQL.Clear ;
    qryExercicio.SQL.Add('SELECT DISTINCT DVA_EXERCI FROM PARDVA WHERE COALESCE(DVA_CODEMP, "") = :CODEMP') ;
    qryExercicio.ParamByName('CODEMP').AsString := ACodEmp ;
    qryExercicio.Open ;
    qryExercicio.First ;
    while not qryExercicio.Eof do
    begin
      result.Add( qryExercicio.FieldByName('DVA_EXERCI').AsString ) ;
      qryExercicio.Next ;
    end;
  finally
    FreeAndNil(qryExercicio) ;
  end;
end;

class function TDemonstracaoValorAdicionadoExercicio.VerificarExistente(
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
    qryExerc.SQL.Add('SELECT DVA_EXERCI FROM PARDVA WHERE DVA_EXERCI = :EXERCI AND COALESCE(DVA_CODEMP, "") = :CODEMP LIMIT 1') ;
    qryExerc.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryExerc.ParamByName('CODEMP').AsString := ACodEmp ;
    qryExerc.Open ;

    result := not qryExerc.IsEmpty ;
  finally
    FreeAndNil(qryExerc) ;
  end;
end;


end.
