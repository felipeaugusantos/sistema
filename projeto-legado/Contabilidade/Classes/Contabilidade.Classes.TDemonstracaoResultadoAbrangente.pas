unit Contabilidade.Classes.TDemonstracaoResultadoAbrangente;


interface

uses Classes, Uni, UniClientDataSet, cxProgressBar;

const
    PARAMETROS_LINHA_MAX = 9 ;
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
                        ('Lucro Líquido do Período',                                                                                                  '0', '01', '0', '0', '1'),
                        ('(+-) Ganhos/Perdas de conversão das Demonstrações Contábeis',                                                               '0', '02', '0', '0', '1'),
                        ('(+-) Ganhos/Perdas Atuariais (benefícios a empregados)',                                                                    '0', '03', '0', '0', '1'),
                        ('(+-) Mudanças nos valores justos de instrumentos de Hedge',                                                                 '0', '04', '0', '0', '1'),
                        ('(+-) Parcela de outros resultados abrangentes (coligadas, controladas e controlados em conjunto, contabilizados pelo MEP)', '0', '05', '0', '0', '1'),
                        ('(=)  Resultado Abrangente Total ',                                                                                          '0', '06', '0', '1', '0'),
                        ('Participação no Resultado Abrangente',                                                                                      '0', '07', '0', '1', '0'),
                        ('- Controladores',                                                                                                           '0', '08', '0', '0', '1'),
                        ('- Não Controladores',                                                                                                       '0', '09', '0', '0', '1')
                      ) ;
    LINHAS_RESULTADO_ABRANGENTE_TOTAL = [1..5] ;
    LINHA_RESULTADO_ABRANGENTE_TOTAL = 6 ;
    LINHA_SEM_VALOR = 7 ;

type
  TDemonstracaoResultadoAbrangenteGerar = class
  private
    FAnoExercicio: integer ;
    FEmpresas: TStringList ;
    FProgresso: TcxProgressBar ;
    class function fEmpresasToStr(const ALstEmpresas: TStringList):string ;
    class procedure pCarregaValoresContaContabil(const AExercicio: integer; const ALstEmpresas: TStringList; var cdsGerar: TUniClientDataSet) ;
    class function fPreparaFiltroEmpresa(const ANomerabela, AColEmpresa: string; const ALstEmpresas: TStringList):string ;
    class procedure pSomaValoresItens(const ACdsCtaDra, ACdsLanCreAtu, ACdsLanCreAnt, ACdsLanDebAtu, ACdsLanDebAnt: TUniClientDataSet; var AFltTotalCreditoAtu, AFltTotalCreditoAnt, AFltTotalDebitoAtu, AFltTotalDebitoAnt: double) ;
  public
    property AnoExercicio : integer read FAnoExercicio write FAnoExercicio ;
    property Empresas : TStringList read FEmpresas write FEmpresas ;
    property Progresso : TcxProgressBar read FProgresso write FProgresso ;
    function Processar:TUniClientDataset ;
    constructor Create;
    destructor Destroy; override;
    class procedure CalcularTotais(const AExercicio: integer; const ALstEmpresas: TStringList; var cdsGerar: TUniClientDataSet) ;
  end;

  TDemonstracaoResultadoAbrangenteParametros = class
  private
    class function fGetSqlInsertPARDRA: string;
    class function fGetSqlInsertCNTDRA: string;
    class function fGetSqlDeleteCNTDRA: string;
    class function fGetSqlDeletePARDRA: string;
  public
    class procedure Carregar(const AExercicio: integer; const ACodEmp: String; var cdsParametros, cdsParametrosContas : TUniClientDataSet) ;
    class function Gravar(const AExercicio: integer; const ACodEmp: String; const cdsParametros, cdsParametrosContas : TUniClientDataSet; const ModoInsert: Boolean):boolean ;
    class function Deletar(const AExercicio: integer; const ACodEmp: String):boolean ;
    class procedure IncluirDe(const AExercicio: integer; const ACodEmp: String; var qryDra : TUniquery; var cdsCon : TUniClientDataSet) ;
  end;

  TDemonstracaoResultadoAbrangenteExercicio = class
  public
    class function Listar(const ACodEmp: String):TStringList ;
    class function VerificarExistente(const AExercicio: integer; const ACodEmp: String; const ModoInsert: Boolean):boolean ;
  end;

implementation

uses untFuncoesSimples, SysUtils, DB, VCL.Forms, System.JSON, Contabilidade.Funcoes ;

{ TDemonstracaoResultadoAbrangenteGerar }

class procedure TDemonstracaoResultadoAbrangenteGerar.pCarregaValoresContaContabil(
  const AExercicio: integer; const ALstEmpresas: TStringList;
  var cdsGerar: TUniClientDataSet);
var
  qryCtaDra : TUniQuery ;
  cdsCtaDra : TUniClientDataSet ;
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
  qryCtaDra := fCriaQuery() ;
  JsonArr := TJSONArray.Create;
  qryLanCre := fCriaQuery() ;
  qryLanDeb := fCriaQuery() ;

  strTplaco := fRetTplacoEmpresaLogada ;

  try
    strSqlCta := '' ;
    strSqlCta := strSqlCta + ' SELECT DRA_ORDEM_, DRA_CODCON, PLANCO.NCO_CODCON ' ;
    strSqlCta := strSqlCta + ' FROM PARDRA ' ;
    strSqlCta := strSqlCta + '      INNER JOIN CNTDRA ON CNTDRA.DRA_SEQLAN = PARDRA.AUTOINCREM ' ;
    strSqlCta := strSqlCta + '      LEFT JOIN PLANCO ON NCO_CODCON LIKE CONCAT(DRA_CODCON,"%") AND NCO_NATURE = "A" AND NCO_TPLACO = '+ strTplaco.QuotedString ;
    strSqlCta := strSqlCta + ' WHERE PARDRA.DRA_EXERCI = :EXERCI ' + fPreparaFiltroEmpresa('PARDRA', 'DRA_CODEMP', ALstEmpresas) ;
    strSqlCta := strSqlCta + ' ORDER BY DRA_ORDEM_, DRA_CODCON, PLANCO.NCO_CODCON ' ;

    qryCtaDra.Close ;
    qryCtaDra.SQL.Clear ;
    qryCtaDra.SQL.Add(strSqlCta) ;
    qryCtaDra.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryCtaDra.Open ;

    cdsCtaDra := fCriaClientDatset(qryCtaDra) ;
    cdsCtaDra.IndexFieldNames := 'DRA_ORDEM_' ;

    ////separa as contas para buscar os valores na lancon
    cdsCtaDra.DisableControls ;
    try
      cdsCtaDra.First ;
      while not cdsCtaDra.Eof do
      begin
        JsonArr.AddElement(TJSONString.Create(cdsCtaDra.FieldByName('NCO_CODCON').AsString));
        cdsCtaDra.Next ;
      end;
    finally
      cdsCtaDra.EnableControls ;
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
        if cdsCtaDra.FindKey([cdsGerar.FieldByName('DRA_ORDEM_').AsInteger]) then
        begin
          fltTotalDebitoAtu := 0.00 ;
          fltTotalDebitoAnt := 0.00 ;
          fltTotalCreditoAtu := 0.00 ;
          fltTotalCreditoAnt := 0.00 ;
          while (cdsGerar.FieldByName('DRA_ORDEM_').AsInteger = cdsCtaDra.FieldByName('DRA_ORDEM_').AsInteger)
                and ( not cdsCtaDra.Eof ) do
          begin
            pSomaValoresItens(cdsCtaDra,
                              cdsLanCreAtu,
                              cdsLanCreAnt,
                              cdsLanDebAtu,
                              cdsLanDebAnt,
                              fltTotalCreditoAtu,
                              fltTotalCreditoAnt,
                              fltTotalDebitoAtu,
                              fltTotalDebitoAnt) ;

            cdsCtaDra.Next ;
          end;
          cdsGerar.Edit ;
          cdsGerar.FieldByName('DRA_EXERCI').AsFloat := fltTotalDebitoAtu - fltTotalCreditoAtu ;
          cdsGerar.FieldByName('DRA_EXEANT').AsFloat := fltTotalDebitoAnt - fltTotalCreditoAnt ;
          cdsGerar.Post ;
        end;
        cdsGerar.Next ;
      end;
    finally
      cdsGerar.EnableControls ;
    end;

  finally
    FreeAndNil(qryCtaDra) ;
    FreeAndNil(cdsCtaDra) ;
    FreeAndNil(JsonArr) ;

    FreeAndNil(qryLanCre) ;
    FreeAndNil(cdsLanCreAnt) ;
    FreeAndNil(cdsLanCreAtu) ;

    FreeAndNil(qryLanDeb) ;
    FreeAndNil(cdsLanDebAnt) ;
    FreeAndNil(cdsLanDebAtu) ;
  end;
end;

constructor TDemonstracaoResultadoAbrangenteGerar.Create;
begin
  FEmpresas := TStringList.Create;
end;

destructor TDemonstracaoResultadoAbrangenteGerar.Destroy;
begin
  FreeAndNil(FEmpresas) ;
  inherited;
end;

class function TDemonstracaoResultadoAbrangenteGerar.fEmpresasToStr(const ALstEmpresas: TStringList): string;
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

class procedure TDemonstracaoResultadoAbrangenteGerar.CalcularTotais(const AExercicio: integer;
  const ALstEmpresas: TStringList;
  var cdsGerar: TUniClientDataSet);
var
  fltDraExercicio, fltDraExercicioAnt: double ;
  intLinha : integer ;
begin

  cdsGerar.DisableControls ;
  try
    intLinha := cdsGerar.FieldByName('DRA_ORDEM_').AsInteger ;
    /////totaliza os agrupamentos.
    fltDraExercicio      := 0.00 ;
    fltDraExercicioAnt   := 0.00 ;

    cdsGerar.First ;
    while not cdsGerar.Eof do
    begin
      if cdsGerar.FieldByName('DRA_ORDEM_').AsInteger in LINHAS_RESULTADO_ABRANGENTE_TOTAL then
      begin
        fltDraExercicio := fltDraExercicio + cdsGerar.FieldByName('DRA_EXERCI').AsFloat ;
        fltDraExercicioAnt := fltDraExercicioAnt + cdsGerar.FieldByName('DRA_EXEANT').AsFloat ;
      end;
      cdsGerar.Next ;
    end;

    /////limpa os fields para deixar sem numero
    if cdsGerar.Locate('DRA_ORDEM_', LINHA_SEM_VALOR, []) then
    begin
      cdsGerar.Edit ;
      cdsGerar.FieldByName('DRA_EXERCI').Clear ;
      cdsGerar.FieldByName('DRA_EXEANT').Clear ;
      cdsGerar.Post ;
    end;

    if cdsGerar.Locate('DRA_ORDEM_', LINHA_RESULTADO_ABRANGENTE_TOTAL, []) then
    begin
      cdsGerar.Edit ;
      cdsGerar.FieldByName('DRA_EXERCI').AsFloat := fltDraExercicio ;
      cdsGerar.FieldByName('DRA_EXEANT').AsFloat := fltDraExercicioAnt ;
      cdsGerar.Post ;
    end;

    ///restaura a linha antes do processamento
    cdsGerar.Locate('DRA_ORDEM_', intLinha, [])

  finally
    cdsGerar.EnableControls ;
  end;
end;

class function TDemonstracaoResultadoAbrangenteGerar.fPreparaFiltroEmpresa(
  const ANomerabela, AColEmpresa: string; const ALstEmpresas: TStringList): string;
begin
  result := fEmpresasToStr(ALstEmpresas) ;
  if not fEmptyStr(result) then
  begin
    result := ' AND ' + ANomerabela + '.' + AColEmpresa + ' IN ('+result+') ' ;
  end;
end;

function TDemonstracaoResultadoAbrangenteGerar.Processar: TUniClientDataset;
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
    qryGerar.SQL.Add(' SELECT DRA_ORDEM_, CAST(CONCAT(REPEAT(" ",DRA_NIVEL_*3), DRA_DESCRI) AS CHAR(150)) AS DRA_DESCRI, ') ;
    qryGerar.SQL.Add('   CAST(NULL AS DECIMAL(12,2)) AS DRA_EXERCI, ') ;
    qryGerar.SQL.Add('   CAST(NULL AS DECIMAL(12,2)) AS DRA_EXEANT, ') ;
    qryGerar.SQL.Add('    DRA_CONTAS, DRA_NEGRIT ') ;
    qryGerar.SQL.Add(' FROM PARDRA LEFT JOIN CNTDRA ON CNTDRA.DRA_SEQLAN = PARDRA.AUTOINCREM ') ;
    qryGerar.SQL.Add(' WHERE PARDRA.DRA_EXERCI = :EXERCI ' + fPreparaFiltroEmpresa('PARDRA', 'DRA_CODEMP', FEmpresas)) ;
    qryGerar.SQL.Add(' GROUP BY DRA_ORDEM_, DRA_NIVEL_, DRA_DESCRI, DRA_CONTAS, DRA_NEGRIT ') ;
    qryGerar.SQL.Add(' ORDER BY DRA_ORDEM_ ') ;
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

class procedure TDemonstracaoResultadoAbrangenteGerar.pSomaValoresItens(
  const ACdsCtaDra, ACdsLanCreAtu, ACdsLanCreAnt, ACdsLanDebAtu, ACdsLanDebAnt: TUniClientDataSet;
  var AFltTotalCreditoAtu,AFltTotalCreditoAnt, AFltTotalDebitoAtu, AFltTotalDebitoAnt: double);
begin
  ///credito
  if ACdsLanCreAtu.FindKey([ACdsCtaDra.FieldByName('NCO_CODCON').AsString]) then
  begin
    while (ACdsCtaDra.FieldByName('NCO_CODCON').AsString = ACdsLanCreAtu.FieldByName('CODCON').AsString)
          and ( not ACdsLanCreAtu.Eof )  do
    begin
      AFltTotalCreditoAtu := AFltTotalCreditoAtu + ACdsLanCreAtu.FieldByName('VALOR_CREDITO').AsFloat ;
      ACdsLanCreAtu.Next ;
    end;
  end;
  if ACdsLanCreAnt.FindKey([ACdsCtaDra.FieldByName('NCO_CODCON').AsString]) then
  begin
    while (ACdsCtaDra.FieldByName('NCO_CODCON').AsString = ACdsLanCreAnt.FieldByName('CODCON').AsString)
          and ( not ACdsLanCreAnt.Eof )  do
    begin
      AFltTotalCreditoAnt := AFltTotalCreditoAnt + ACdsLanCreAnt.FieldByName('VALOR_CREDITO').AsFloat ;
      ACdsLanCreAnt.Next ;
    end;
  end;
  ///debito
  if ACdsLanDebAtu.FindKey([ACdsCtaDra.FieldByName('NCO_CODCON').AsString]) then
  begin
    while (ACdsCtaDra.FieldByName('NCO_CODCON').AsString = ACdsLanDebAtu.FieldByName('CODCON').AsString)
          and ( not ACdsLanDebAtu.Eof )  do
    begin
      AFltTotalDebitoAtu := AFltTotalDebitoAtu + ACdsLanDebAtu.FieldByName('VALOR_DEBITO').AsFloat ;
      ACdsLanDebAtu.Next ;
    end;
  end;
  if ACdsLanDebAnt.FindKey([ACdsCtaDra.FieldByName('NCO_CODCON').AsString]) then
  begin
    while (ACdsCtaDra.FieldByName('NCO_CODCON').AsString = ACdsLanDebAnt.FieldByName('CODCON').AsString)
          and ( not ACdsLanDebAnt.Eof )  do
    begin
      AFltTotalDebitoAnt := AFltTotalDebitoAnt + ACdsLanDebAnt.FieldByName('VALOR_DEBITO').AsFloat ;
      ACdsLanDebAnt.Next ;
    end;
  end;
end;

{ TDemonstracaoResultadoAbrangenteParametros }

class procedure TDemonstracaoResultadoAbrangenteParametros.Carregar(
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
  strSql := strSql + '  DRA_EXERCI, ' ;
  strSql := strSql + '  DRA_CODEMP, ' ;
  strSql := strSql + '  CAST(CONCAT(REPEAT(" ",DRA_NIVEL_*3), DRA_DESCRI) AS CHAR(150)) AS DRA_DESCRI, ' ;
  strSql := strSql + '  DRA_NIVEL_, ' ;
  strSql := strSql + '  DRA_ORDEM_, ' ;
  strSql := strSql + '  DRA_EDITAV, ' ;
  strSql := strSql + '  DRA_NEGRIT, ' ;
  strSql := strSql + '  DRA_CONTAS, ' ;
  strSql := strSql + '  (CAST(NULL AS CHAR(4))) AS CNT_BTN ' ;
  strSql := strSql + ' FROM PARDRA ' ;
  strSql := strSql + ' WHERE DRA_EXERCI = :EXERCI AND COALESCE(DRA_CODEMP, "") = :CODEMP ' ;
  strSql := strSql + ' ORDER BY DRA_ORDEM_' ;

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
  strSql := strSql + ' CNTDRA.AUTOINCREM, ' ;
  strSql := strSql + ' CNTDRA.DRA_SEQLAN, ' ;
  strSql := strSql + ' CNTDRA.DRA_CODCON, ' ;
  strSql := strSql + ' PLANCO.NCO_DESCRI ' ;
  strSql := strSql + ' FROM CNTDRA INNER JOIN PLANCO ON CNTDRA.DRA_CODCON = PLANCO.NCO_CODCON AND PLANCO.NCO_TPLACO = '+ strTplaco.QuotedString  ;
  strSql := strSql + ' WHERE CNTDRA.DRA_SEQLAN in ('+ strCnt +') ' ;
  strSql := strSql + ' ORDER BY CNTDRA.AUTOINCREM ' ;

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
    cdsParametrosContas.IndexFieldNames := 'DRA_CODCON;DRA_SEQLAN' ;
  finally
    FreeAndNil(qryParametrosContas);
  end;

end;

class function TDemonstracaoResultadoAbrangenteParametros.Deletar(
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
      qryExec.SQL.Add(fGetSqlDeletePARDRA);
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
      raise  ;
    End;
  End;
  result := True ;
end;

class function TDemonstracaoResultadoAbrangenteParametros.fGetSqlDeleteCNTDRA: string;
begin
  result := 'DELETE FROM CNTDRA WHERE DRA_SEQLAN IN (SELECT AUTOINCREM FROM PARDRA WHERE DRA_EXERCI = :EXERCI  AND COALESCE(DRA_CODEMP, "") = :CODEMP) ;' ;
end;

class function TDemonstracaoResultadoAbrangenteParametros.fGetSqlDeletePARDRA: string;
begin
  result := 'DELETE FROM PARDRA WHERE DRA_EXERCI = :EXERCI AND COALESCE(DRA_CODEMP, "") = :CODEMP; ' ;
end;

class function TDemonstracaoResultadoAbrangenteParametros.fGetSqlInsertCNTDRA: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO CNTDRA ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' AUTOINCREM, ' ;
  strSql := strSql + ' DRA_SEQLAN, ' ;
  strSql := strSql + ' DRA_CODCON ' ;
  strSql := strSql + ' ) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' :AUTOINCREM, ' ;
  strSql := strSql + ' :SEQLAN, ' ;
  strSql := strSql + ' :CODCON ' ;
  strSql := strSql + ' ); ' ;

  result := strSql ;
end;

class function TDemonstracaoResultadoAbrangenteParametros.fGetSqlInsertPARDRA: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO PARDRA ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' AUTOINCREM, ' ;
  strSql := strSql + ' DRA_EXERCI, ' ;
  strSql := strSql + ' DRA_CODEMP, ' ;
  strSql := strSql + ' DRA_DESCRI, ' ;
  strSql := strSql + ' DRA_NIVEL_, ' ;
  strSql := strSql + ' DRA_ORDEM_, ' ;
  strSql := strSql + ' DRA_EDITAV, ' ;
  strSql := strSql + ' DRA_NEGRIT, ' ;
  strSql := strSql + ' DRA_CONTAS ' ;
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

class function TDemonstracaoResultadoAbrangenteParametros.Gravar(const AExercicio: integer; const ACodEmp: String; const cdsParametros,
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
        qryExec.SQL.Add(fGetSqlInsertPARDRA);
        cdsParametros.DisableControls;
        cdsParametrosContas.DisableControls;
        try
          cdsParametros.First ;
          while not cdsParametros.Eof do
          begin
            qryExec.ParamByName('AUTOINCREM').AsString := cdsParametros.FieldByName('AUTOINCREM').AsString  ;
            qryExec.ParamByName('EXERCI').AsInteger := cdsParametros.FieldByName('DRA_EXERCI').AsInteger  ;
            qryExec.ParamByName('CODEMP').AsString := cdsParametros.FieldByName('DRA_CODEMP').AsString  ;
            qryExec.ParamByName('DESCRI').AsString :=  trim(cdsParametros.FieldByName('DRA_DESCRI').AsString)  ;
            qryExec.ParamByName('NIVEL_').AsInteger := cdsParametros.FieldByName('DRA_NIVEL_').AsInteger  ;
            qryExec.ParamByName('ORDEM_').AsInteger := cdsParametros.FieldByName('DRA_ORDEM_').AsInteger  ;
            qryExec.ParamByName('EDITAV').AsInteger := cdsParametros.FieldByName('DRA_EDITAV').AsInteger  ;
            qryExec.ParamByName('NEGRIT').AsInteger := cdsParametros.FieldByName('DRA_NEGRIT').AsInteger  ;
            qryExec.ParamByName('CONTAS').AsInteger := cdsParametros.FieldByName('DRA_CONTAS').AsInteger  ;
            qryExec.ExecSQL ;
            cdsParametros.Next ;
          end;

          qryExec.Close ;
          qryExec.SQL.Clear ;
          qryExec.SQL.Add(fGetSqlInsertCNTDRA) ;
          cdsParametrosContas.First;
          while not cdsParametrosContas.Eof do
          begin
            qryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CNTDRA',Vs_strCodEmp) ;
            qryExec.ParamByName('SEQLAN').AsString := cdsParametrosContas.FieldByName('DRA_SEQLAN').AsString ;
            qryExec.ParamByName('CODCON').AsString := cdsParametrosContas.FieldByName('DRA_CODCON').AsString ;
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
          qryExec.SQL.Add(fGetSqlDeleteCNTDRA) ;
          qryExec.ParamByName('EXERCI').AsInteger := AExercicio  ;
          qryExec.ParamByName('CODEMP').AsString := ACodEmp  ;
          qryExec.ExecSQL ;
          /////
          qryExec.Close ;
          qryExec.SQL.Clear ;
          qryExec.SQL.Add(fGetSqlInsertCNTDRA) ;
          cdsParametrosContas.First;
          while not cdsParametrosContas.Eof do
          begin
            qryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CNTDRA',Vs_strCodEmp) ;
            qryExec.ParamByName('SEQLAN').AsString := cdsParametrosContas.FieldByName('DRA_SEQLAN').AsString ;
            qryExec.ParamByName('CODCON').AsString := cdsParametrosContas.FieldByName('DRA_CODCON').AsString ;
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

class procedure TDemonstracaoResultadoAbrangenteParametros.IncluirDe(
  const AExercicio: integer; const ACodEmp: String; var qryDra: TUniquery;
  var cdsCon: TUniClientDataSet);
var
  qryCon : TUniquery ;
begin
  qryCon := fCriaQuery() ;
  try
    qryDra.Close ;
    qryDra.SQL.Clear ;
    qryDra.SQL.Add(' SELECT') ;
    qryDra.SQL.Add(' AUTOINCREM,') ;
    qryDra.SQL.Add(' DRA_EXERCI,') ;
    qryDra.SQL.Add(' DRA_CODEMP,') ;
    qryDra.SQL.Add(' DRA_DESCRI,') ;
    qryDra.SQL.Add(' DRA_NIVEL_,') ;
    qryDra.SQL.Add(' DRA_ORDEM_,') ;
    qryDra.SQL.Add(' DRA_EDITAV,') ;
    qryDra.SQL.Add(' DRA_NEGRIT,') ;
    qryDra.SQL.Add(' DRA_CONTAS') ;
    qryDra.SQL.Add(' FROM PARDRA') ;
    qryDra.SQL.Add(' WHERE DRA_EXERCI = :EXERCI AND COALESCE(DRA_CODEMP, "") = :CODEMP ') ;
    qryDra.SQL.Add(' ORDER BY DRA_ORDEM_') ;
    qryDra.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryDra.ParamByName('CODEMP').AsString := ACodEmp ;
    qryDra.Open ;
    qryDra.First ;

    qryCon.Close ;
    qryCon.SQL.Clear ;
    qryCon.SQL.Add(' SELECT ') ;
    qryCon.SQL.Add('   CNTDRA.DRA_SEQLAN, ') ;
    qryCon.SQL.Add('   CNTDRA.DRA_CODCON ') ;
    qryCon.SQL.Add(' FROM CNTDRA ') ;
    qryCon.SQL.Add(' WHERE DRA_SEQLAN IN (SELECT AUTOINCREM FROM PARDRA WHERE DRA_EXERCI = :EXERCI  AND COALESCE(DRA_CODEMP, "") = :CODEMP ) ') ;
    qryCon.SQL.Add(' ORDER BY CNTDRA.AUTOINCREM ') ;
    qryCon.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryCon.ParamByName('CODEMP').AsString := ACodEmp ;
    qryCon.Open ;

    cdsCon := fCriaClientDatset(qryCon);
    cdsCon.Open;
    cdsCon.IndexFieldNames := 'DRA_SEQLAN' ;

  finally
    FreeAndNil(qryCon) ;
  end;
end;

{ TDemonstracaoResultadoAbrangenteExercicio }

class function TDemonstracaoResultadoAbrangenteExercicio.Listar(const ACodEmp: String): TStringList;
var
  qryExercicio : TUniquery ;
begin
  result := TStringList.Create ;
  result.Sorted := True ;
  qryExercicio := fCriaQuery() ;
  try
    qryExercicio.Close ;
    qryExercicio.SQL.Clear ;
    qryExercicio.SQL.Add('SELECT DISTINCT DRA_EXERCI FROM PARDRA WHERE COALESCE(DRA_CODEMP, "") = :CODEMP') ;
    qryExercicio.ParamByName('CODEMP').AsString := ACodEmp ;
    qryExercicio.Open ;
    qryExercicio.First ;
    while not qryExercicio.Eof do
    begin
      result.Add( qryExercicio.FieldByName('DRA_EXERCI').AsString ) ;
      qryExercicio.Next ;
    end;
  finally
    FreeAndNil(qryExercicio) ;
  end;
end;

class function TDemonstracaoResultadoAbrangenteExercicio.VerificarExistente(
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
    qryExerc.SQL.Add('SELECT DRA_EXERCI FROM PARDRA WHERE DRA_EXERCI = :EXERCI AND COALESCE(DRA_CODEMP, "") = :CODEMP LIMIT 1') ;
    qryExerc.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryExerc.ParamByName('CODEMP').AsString := ACodEmp ;
    qryExerc.Open ;

    result := not qryExerc.IsEmpty ;
  finally
    FreeAndNil(qryExerc) ;
  end;
end;

end.
