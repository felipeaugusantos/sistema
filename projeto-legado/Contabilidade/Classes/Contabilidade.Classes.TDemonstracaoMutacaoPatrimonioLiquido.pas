unit Contabilidade.Classes.TDemonstracaoMutacaoPatrimonioLiquido;

interface

uses Classes, Uni, UniClientDataSet, cxProgressBar;

const
    PARAMETROS_LINHA_MAX = 19 ;
    PARAMETROS_COLUNA_MAX = 6 ;
    PARAMETROS_LINHA_MIN =  1 ;
    PARAMETROS_COLUNA_MIN = 1 ;
    PARAMETROS_DESCRI = 1 ;
    PARAMETROS_NIVEL_ = 2 ;
    PARAMETROS_ORDEM_ = 3 ;
    PARAMETROS_EDITAV = 4 ;
    PARAMETROS_NEGRIT = 5 ;
    PARAMETROS_CONTAS = 6 ;

    CODIGO_RESERVA_CAPITAL    = 3 ;
    CODIGO_RESERVA_AVALIACAO  = 8 ;
    CODIGO_RESERVA_LUCRO      = 12 ;
    CODIGO_PATRIMONIO_LIQUIDO = 1 ;

    PARAMETROS_PADRAO : array [PARAMETROS_LINHA_MIN..PARAMETROS_LINHA_MAX, PARAMETROS_COLUNA_MIN..PARAMETROS_COLUNA_MAX] of string = (
                        ('001 – Conta Sintética do Patrimônio Líquido', '0', '01', '0', '0', '1'),
                        ('002 - Capital Social',                        '0', '02', '0', '0', '1'),
                        ('003 - Reservas de Capital',                   '0', '03', '0', '1', '1'),
                        ('004 - Ágio na Subscrição',                    '0', '04', '0', '0', '1'),
                        ('005 – Ações em Tesouraria',                   '0', '05', '0', '0', '1'),
                        ('006 - Subvenção Investimento',                '0', '06', '0', '0', '1'),
                        ('007 - Em branco',                             '0', '07', '1', '0', '1'),
                        ('008 - Reservas de Avaliação',                 '0', '08', '0', '1', '1'),
                        ('009 - De Ativos Próprios',                    '0', '09', '0', '0', '1'),
                        ('010 – De Ativos Controladores',               '0', '10', '0', '0', '1'),
                        ('011 – Em branco',                             '0', '11', '1', '0', '1'),
                        ('012 - Reservas de Lucros',                    '0', '12', '0', '1', '1'),
                        ('013 – Reserva Legal',                         '0', '13', '0', '0', '1'),
                        ('014 – Reservas Estatutárias',                 '0', '14', '0', '0', '1'),
                        ('015 - Reservas para Contingências',           '0', '15', '0', '0', '1'),
                        ('016 - Reservas para Expansão',                '0', '16', '0', '0', '1'),
                        ('017 – Reservas de Lucros a Realizar',         '0', '17', '0', '0', '1'),
                        ('018 – Em branco',                             '0', '18', '1', '0', '1'),
                        ('019 - Lucros ou Prejuízos Acumulados',        '0', '19', '0', '0', '1')
                      ) ;

type
  TTipoExercicio = (teParametro, teNotaExplicativa, teMovimentacao) ;

  TDemonstracaoMutacaoPatrimonioLiquidoGerar = class
  private
    FAnoExercicio: integer ;
    FEmpresas: TStringList ;
    FProgresso: TcxProgressBar ;
    FNaoMostrarColunasSemLancamento: Boolean ;
    FNaoMostrarLinhasSemLancamento: Boolean ;
    FcdsColunas: TUniClientDataSet ;
    FcdsBandas: TUniClientDataSet ;
    FLstReservaCapital: TStringList ;
    FLstReservaAvaliacao: TStringList ;
    FLstReservaLucro: TStringList ;
    FSimplificado: Boolean;
    function fEmpresasToStr(const ALstEmpresas: TStringList):string ;
    procedure pCarregaValoresContaContabil(const AExercicio: integer; const ALstEmpresas: TStringList; var cdsGerar: TUniClientDataSet) ;
    function fPreparaFiltroEmpresa(const ANomerabela, AColEmpresa: string; const ALstEmpresas: TStringList):string ;
    function fFieldNameValidoValorMPL(const AFieldName: string):string ;
    procedure pApagaLinhasSemValor(var cdsGerar: TUniClientDataSet) ;
    procedure pApagaColunasSemValor(var cdsGerar: TUniClientDataSet) ;
    procedure pInverteSinal(var cdsGerar: TUniClientDataSet) ;
    procedure pCalculaValorColunas(var cdsGerar: TUniClientDataSet; const cdsCtDmpl, cdsLanAtu, cdsLanAnt, cdsCtaMovime: TUniClientDataSet) ;
    procedure pAdicionaInfoColuna(const ACodigo: integer) ;
    procedure pRemoveInfoColuna(const ACodigo: integer) ;
    procedure pRemoveInfoAba() ;
    function fGetDescricaoByCodigo(const ACodigo: integer):string ;
    function fGetAbaByCodigo(const ACodigo: integer):integer ;
    procedure SetSimplificado(const Value: Boolean);
    procedure pProcessarPrimeiraAba(const aExercicio: integer; const ALstEmpresas: TStringList; var cdsExercicioAtual, cdsExercicioAnterior, cdsCtDmpl: TUniClientDataSet; ACodigoParametroConta: integer = 0);
    function fListToStrEmpresas: String ;
  public
    property AnoExercicio : integer read FAnoExercicio write FAnoExercicio ;
    property Empresas : TStringList read FEmpresas write FEmpresas ;
    property Progresso : TcxProgressBar read FProgresso write FProgresso ;
    property Simplificado : Boolean   read FSimplificado write SetSimplificado;
    property NaoMostrarColunasSemLancamento : Boolean read FNaoMostrarColunasSemLancamento write FNaoMostrarColunasSemLancamento ;
    property NaoMostrarLinhasSemLancamento : Boolean read FNaoMostrarLinhasSemLancamento write FNaoMostrarLinhasSemLancamento ;
    property cdsColunas : TUniClientDataSet read FcdsColunas ;
    property cdsBandas : TUniClientDataSet read FcdsBandas ;
    function Processar:TUniClientDataset ;
    function fCalculaValorPatrimonioLiquidoPrimeiraAba(const aExercicio: integer; const ALstEmpresas: TStringList):double ;
    constructor Create;
    destructor Destroy; override;
  end;

  TDemonstracaoMutacaoPatrimonioLiquidoParametros = class
  private
    class function fGetSqlInsertPRDMPL: string;
    class function fGetSqlInsertCTDMPL: string;
    class function fGetSqlDeleteCTDMPL: string;
    class function fGetSqlDeletePRDMPL: string;
  public
    class procedure Carregar(const AExercicio: integer; const ACodEmp: String; var cdsParametros, cdsParametrosContas : TUniClientDataSet) ;
    class function Gravar(const AExercicio: integer; const cdsParametros, cdsParametrosContas : TUniClientDataSet; const ModoInsert: Boolean; const ACodEmp: String):boolean ;
    class function Deletar(const AExercicio: integer; const ACodEmp: String):boolean ;
    class procedure IncluirDe(const AExercicio: integer; const ACodEmp: String; var qryDmpl : TUniquery; var cdsCon : TUniClientDataSet) ;
  end;

  TDemonstracaoMutacaoPatrimonioLiquidoExercicio = class
  private
    class function fRetornaNomeTabela(const ATipo: TTipoExercicio):String ;
  public
    class function Listar(const ACodEmp: String; const ATipo: TTipoExercicio):TStringList ;
    class function VerificarExistente(const AExercicio: integer; const AModoInsert: Boolean; const ATipo: TTipoExercicio; const ACodEmp: String):boolean ;
  end;

  TDemonstracaoMutacaoPatrimonioLiquidoNotasExplicativas = class
  private
    class function fGetSqlInsert: string;
    class function fGetSqlDelete: string;
  public
    class procedure Carregar(const AExercicio: integer; const ACodEmp: String; var cdsNotasExplicativas: TUniClientDataSet) ;
    class function Gravar(const AExercicio: integer; const cdsNotasExplicativas: TUniClientDataSet; const ModoInsert: Boolean; const ACodEmp: String):boolean ;
    class function Deletar(const AExercicio: integer; const ACodEmp: String):boolean ;
    class procedure IncluirDe(const AExercicio: integer; const ACodEmp: String; var qryNotasExplicativas: TUniquery) ;
  end;

  TDemonstracaoMutacaoPatrimonioLiquidoMovimentacao = class
  private
    class function fGetSqlInsertMVDMPL: string;
    class function fGetSqlDeleteMVDMPL: string;
    class function fGetSqlInsertDTDMPL: string;
    class function fGetSqlInsertDT2DMP: string;
  public
    class procedure Carregar(const AExercicio: integer; const ACodEmp: String; var cdsMovimentacao, cdsContasCre, cdsContasDeb, cdsNotas: TUniClientDataSet) ;
    class function  Gravar(const AExercicio: integer; const cdsMovimentacao, cdsContasCre, cdsContasDeb, cdsNotas: TUniClientDataSet; const ModoInsert: Boolean; const ACodEmp: String):boolean ;
    class function  Deletar(const AExercicio: integer; const ACodEmp: String):boolean ;
    class procedure IncluirDe(const AExercicio: integer; const ACodEmp: String; var qryMovimentacao : TUniquery; var cdsConCre, cdsConDeb, cdsNotas : TUniClientDataSet) ;
  end;

implementation

uses untFuncoesSimples, SysUtils, DB, VCL.Forms, System.JSON,  System.Character,
     Contabilidade.Funcoes, StrUtils ;

{ TDemonstracaoMutacaoPatrimonioLiquidoGerar }

procedure TDemonstracaoMutacaoPatrimonioLiquidoGerar.pAdicionaInfoColuna(
  const ACodigo: integer);
begin
  if not cdsColunas.Locate('CODIGO', ACodigo, [loCaseInsensitive]) then
  begin
    cdsColunas.Append ;
    cdsColunas.FieldByName('CODIGO').AsInteger := ACodigo ;
    cdsColunas.FieldByName('DESCRI').AsString := fGetDescricaoByCodigo(ACodigo) ;
    cdsColunas.FieldByName('ABACOD').AsInteger := fGetAbaByCodigo(ACodigo) ;
    cdsColunas.Post ;
    ///
  end;
end;

procedure TDemonstracaoMutacaoPatrimonioLiquidoGerar.pApagaColunasSemValor(
  var cdsGerar: TUniClientDataSet);
var
  lstTemValor : TStringList ;
  intCnt : integer ;
  strCodigoParametro, strFieldName : string ;
begin
  if FNaoMostrarColunasSemLancamento then
  begin

    lstTemValor := TStringList.Create ;
    try
      lstTemValor.Sorted := True ;
      cdsGerar.First ;
      while not cdsGerar.Eof do
      begin
        for intCnt := 0 to cdsGerar.FieldCount-1 do
        begin
          strFieldName := cdsGerar.Fields.Fields[intCnt].FieldName ;
          strCodigoParametro := fFieldNameValidoValorMPL(strFieldName) ;
          if strCodigoParametro <> '0' then
          begin
            if cdsGerar.Fields.Fields[intCnt].AsFloat <> 0.00 then
            begin
              if lstTemValor.IndexOf(strCodigoParametro) = -1 then
              begin
                lstTemValor.Add(strCodigoParametro) ;
              end;
            end;
          end;
        end;
        cdsGerar.Next ;
      end;
      /////exclui as colunas sem valor
      for intCnt := cdsGerar.FieldCount-1 downto 0 do
      begin
        strFieldName := cdsGerar.Fields.Fields[intCnt].FieldName ;
        strCodigoParametro := fFieldNameValidoValorMPL(strFieldName) ;
        if strCodigoParametro <> '0' then
        begin
          if lstTemValor.IndexOf(strCodigoParametro) = -1 then
          begin
            cdsGerar.Fields.Remove(cdsGerar.Fields.Fields[intCnt]);
            pRemoveInfoColuna(StrToInt(strCodigoParametro));
          end;
        end;
      end;
      /////exclui as Bandas(grupos) não usados (caso tenha)
      pRemoveInfoAba ;
      /////
    finally
      FreeAndNil(lstTemValor) ;
    end;
  end;
end;

procedure TDemonstracaoMutacaoPatrimonioLiquidoGerar.pApagaLinhasSemValor(
  var cdsGerar: TUniClientDataSet);
begin
  if FNaoMostrarLinhasSemLancamento then
  begin
    cdsGerar.First ;
    while not cdsGerar.Eof do
    begin
      if cdsGerar.FieldByName('TMP_TOTAL_').AsFloat = 0.00 then
      begin
        cdsGerar.Delete ;
        continue ;
      end;
      cdsGerar.Next ;
    end;
  end;
end;

procedure TDemonstracaoMutacaoPatrimonioLiquidoGerar.pCalculaValorColunas(
  var cdsGerar: TUniClientDataSet; const cdsCtDmpl, cdsLanAtu,
  cdsLanAnt, cdsCtaMovime: TUniClientDataSet);
var
  intCnt : integer ;
  strFieldName : string ;
  strCodigoParametro : string ;
  fltExercicioAtual, fltExercicioAnterior : double ;
begin
  for intCnt := 0 to cdsGerar.FieldCount-1 do
  begin
    strFieldName := cdsGerar.Fields.Fields[intCnt].FieldName ;
    strCodigoParametro := fFieldNameValidoValorMPL(strFieldName) ;
    if strCodigoParametro <> '0' then
    begin
      ///metadados para criação da grid
      pAdicionaInfoColuna(strtoint(strCodigoParametro)) ;
      ////busca as contas associadas para a coluna
      if cdsCtDmpl.FindKey([strtoint(strCodigoParametro)]) then
      begin
        while (strtoint(strCodigoParametro) = cdsCtDmpl.FieldByName('DMP_ORDEM_').AsInteger) and (not cdsCtDmpl.Eof) do
        begin
          if cdsCtaMovime.FieldByName('DMP_CODCON').AsString = cdsCtDmpl.FieldByName('DMP_CODCON').AsString then
          begin
            fltExercicioAtual := 0.00 ;
            fltExercicioAnterior := 0.00 ;
            if cdsLanAtu.FindKey([cdsCtDmpl.FieldByName('NCO_CODCON').AsString]) then
            begin
              while (cdsLanAtu.FieldByName('CODCON').AsString=cdsCtDmpl.FieldByName('NCO_CODCON').AsString) and (not cdsLanAtu.Eof) do
              begin
                fltExercicioAtual := fltExercicioAtual + cdsLanAtu.FieldByName('VALOR').AsFloat ;
                cdsLanAtu.Next ;
              end;
            end;

            if cdsLanAnt.FindKey([cdsCtDmpl.FieldByName('NCO_CODCON').AsString]) then
            begin
              while (cdsLanAnt.FieldByName('CODCON').AsString=cdsCtDmpl.FieldByName('NCO_CODCON').AsString) and (not cdsLanAnt.Eof) do
              begin
                fltExercicioAnterior := fltExercicioAnterior + cdsLanAnt.FieldByName('VALOR').AsFloat ;
                cdsLanAnt.Next ;
              end;
            end;

            cdsGerar.FieldByName(strFieldName).AsFloat := cdsGerar.FieldByName(strFieldName).AsFloat + (fltExercicioAnterior + fltExercicioAtual) ;
            ///totaliza
            cdsGerar.FieldByName('TMP_TOTAL_').AsFloat := cdsGerar.FieldByName('TMP_TOTAL_').AsFloat + (fltExercicioAnterior + fltExercicioAtual) ;
          end;
          cdsCtDmpl.Next ;
        end;
      end;
    end;
  end;
end;

procedure TDemonstracaoMutacaoPatrimonioLiquidoGerar.pCarregaValoresContaContabil(
  const AExercicio: integer; const ALstEmpresas: TStringList;
  var cdsGerar: TUniClientDataSet);
var
  cdsCtDmpl : TUniClientDataSet ;

  qryCtaMovime : TUniQuery ;
  cdsCtaMovime : TUniClientDataSet ;

  qryMovime : TUniQuery ;

  qryNtExplMovime : TUniQuery ;
  cdsNtExplMovime : TUniClientDataSet ;

  strSqlCta : String ;
  strSql : String ;

  cdsLanAtu : TUniClientDataSet ;
  cdsLanAnt : TUniClientDataSet ;

  intId : integer ;
  strTplaco : String ;
begin
  qryCtaMovime := fCriaQuery() ;
  qryNtExplMovime := fCriaQuery() ;
  qryMovime := fCriaQuery() ;
  try
    /////1ª Aba
    pProcessarPrimeiraAba(AExercicio, ALstEmpresas, cdsLanAtu, cdsLanAnt, cdsCtDmpl) ;

    FProgresso.Position := Progresso.Position + 1 ;
    Application.ProcessMessages ;

    ////2ª aba
    strSql := '' ;
    strSql := strSql + ' SELECT DMP_CODMOV, GROUP_CONCAT(LPAD(TRIM(CAST(DMP_CODEXP AS CHAR(3))),3,"0") SEPARATOR ",") AS DMP_CODEXP ' ;
    strSql := strSql + ' FROM MVDMPL INNER JOIN DT2DMP ON MVDMPL.AUTOINCREM = DT2DMP.DMP_SEQDMP ' ;
    strSql := strSql + ' WHERE MVDMPL.DMP_EXERCI = :EXERCI ' ;
    strSql := strSql + ' GROUP BY DMP_CODMOV ' ;
    strSql := strSql + ' ORDER BY DMP_CODMOV, DMP_CODEXP  ' ;

    qryNtExplMovime.Close ;
    qryNtExplMovime.SQL.Clear ;
    qryNtExplMovime.SQL.Add(strSql) ;
    qryNtExplMovime.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryNtExplMovime.Open ;

    cdsNtExplMovime := fCriaClientDatset(qryNtExplMovime) ;
    cdsNtExplMovime.IndexFieldNames := 'DMP_CODMOV' ;

    FProgresso.Position := Progresso.Position + 1 ;
    Application.ProcessMessages ;

    ////3ª aba
    strTplaco := fRetTplacoEmpresaLogada ;
    strSqlCta := '' ;
    strSqlCta := strSqlCta + ' SELECT DMP_CODMOV, DMP_CREDEB, DMP_CODCON, PLANCO.NCO_CODCON ' ;
    strSqlCta := strSqlCta + '  FROM MVDMPL ' ;
    strSqlCta := strSqlCta + '       INNER JOIN DTDMPL ON DTDMPL.DMP_SEQDMP = MVDMPL.AUTOINCREM ' ;
    strSqlCta := strSqlCta + '       LEFT JOIN PLANCO ON NCO_CODCON LIKE CONCAT(DMP_CODCON,"%") AND NCO_NATURE = "A" AND NCO_TPLACO = '+ strTplaco.QuotedString ;
    strSqlCta := strSqlCta + '  WHERE MVDMPL.DMP_EXERCI = :EXERCI ' ;
    strSqlCta := strSqlCta + '  ORDER BY DMP_CODMOV, DMP_CODCON, PLANCO.NCO_CODCON ' ;

    qryCtaMovime.Close ;
    qryCtaMovime.SQL.Clear ;
    qryCtaMovime.SQL.Add(strSqlCta) ;
    qryCtaMovime.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryCtaMovime.Open ;

    cdsCtaMovime := fCriaClientDatset(qryCtaMovime) ;
    cdsCtaMovime.IndexFieldNames := 'DMP_CODMOV' ;

    strSql := '' ;
    strSql := strSql + ' SELECT ' ;
    strSql := strSql + '   MVDMPL.DMP_EXERCI, ' ;
    strSql := strSql + '   MVDMPL.DMP_CONTIT, ' ;
    strSql := strSql + '   MVDMPL.DMP_CODMOV, ' ;
    strSql := strSql + '   HISTMV.HST_DESCRI, ' ;
    strSql := strSql + '   MVDMPL.DMP_HISPAD, ' ;
    strSql := strSql + '   HISPAD.PAD_DESCRI ' ;
    strSql := strSql + ' FROM MVDMPL ' ;
    strSql := strSql + '   INNER JOIN HISTMV ON MVDMPL.DMP_CODMOV = HISTMV.HST_CODIGO ' ;
    strSql := strSql + '   LEFT  JOIN CADEMP ON MVDMPL.DMP_CODEMP = CADEMP.EMP_CODEMP ' ;
    strSql := strSql + '   LEFT  JOIN HISPAD ON MVDMPL.DMP_HISPAD = HISPAD.PAD_CODIGO ' ;
    if fCfgHisTpl then
      strSql := strSql + '  AND HISPAD.PAD_TPLACO = CADEMP.EMP_TPLACO '
    else
      strSql := strSql + '  AND IFNULL(HISPAD.PAD_TPLACO, "") = "" ';

    strSql := strSql + ' WHERE MVDMPL.DMP_EXERCI = :EXERCI ' ;
    strSql := strSql + ' ORDER BY MVDMPL.AUTOINCREM ' ;

    qryMovime.Close ;
    qryMovime.SQL.Clear ;
    qryMovime.SQL.Add(strSql) ;
    qryMovime.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryMovime.Open ;

    FProgresso.Position := Progresso.Position + 1 ;
    Application.ProcessMessages ;

    //////inicia o processamento
    cdsGerar.DisableControls ;
    qryMovime.DisableControls ;
    cdsCtaMovime.DisableControls ;
    cdsNtExplMovime.DisableControls ;
    cdsLanAtu.DisableControls ;
    cdsLanAnt.DisableControls ;
    try
      intId := 0 ;
      qryMovime.First ;
      while not qryMovime.Eof do
      begin
        inc(intId) ;
        cdsGerar.Append ;
        cdsGerar.FieldByName('TMP_ID').AsInteger := intId ;
        cdsGerar.FieldByName('TMP_CODMOV').AsInteger := qryMovime.FieldByName('DMP_CODMOV').AsInteger ;
        cdsGerar.FieldByName('TMP_HISTMV').AsString := qryMovime.FieldByName('HST_DESCRI').AsString ;
        ////notas explicativas do movimento
        if cdsNtExplMovime.FindKey([qryMovime.FieldByName('DMP_CODMOV').AsInteger]) then
        begin
          cdsGerar.FieldByName('TMP_NTEXPL').AsString := cdsNtExplMovime.FieldByName('DMP_CODEXP').AsString ;
        end;
        /// contas do movimento
        if cdsCtaMovime.FindKey([qryMovime.FieldByName('DMP_CODMOV').AsInteger]) then
        begin
          pCalculaValorColunas(cdsGerar, cdsCtDmpl, cdsLanAtu, cdsLanAnt, cdsCtaMovime) ;
        end;
        cdsGerar.Post ;
        qryMovime.Next ;
      end;

      FProgresso.Position := Progresso.Position + 1 ;
      Application.ProcessMessages ;

      ////apaga as linhas sem movimento
      pApagaLinhasSemValor(cdsGerar) ;

      ////apaga as colunas sem movimento
      pApagaColunasSemValor(cdsGerar) ;

      ////inverte o sinal
      pInverteSinal(cdsGerar);

      FProgresso.Position := Progresso.Position + 1 ;
      Application.ProcessMessages ;

      ////
    finally
      cdsGerar.EnableControls ;
      qryMovime.EnableControls ;
      cdsCtaMovime.EnableControls ;
      cdsNtExplMovime.EnableControls ;
      cdsLanAtu.EnableControls ;
      cdsLanAnt.EnableControls ;
    end;

  finally
    FreeAndNil(cdsCtDmpl) ;
    FreeAndNil(qryCtaMovime) ;
    FreeAndNil(cdsCtaMovime) ;
    FreeAndNil(qryMovime) ;

    FreeAndNil(cdsLanAnt) ;
    FreeAndNil(cdsLanAtu) ;

    FreeAndNil(qryNtExplMovime) ;
    FreeAndNil(cdsNtExplMovime) ;
  end;
end;

procedure TDemonstracaoMutacaoPatrimonioLiquidoGerar.pInverteSinal(
  var cdsGerar: TUniClientDataSet);
var
  intCnt : integer ;
  strFieldName, strCodigoParametro : string ;
begin
  cdsGerar.First ;
  while not cdsGerar.Eof do
  begin
    cdsGerar.Edit ;
    for intCnt := 0 to cdsGerar.FieldCount-1 do
    begin
      strFieldName := cdsGerar.Fields.Fields[intCnt].FieldName ;
      strCodigoParametro := fFieldNameValidoValorMPL(strFieldName) ;
      if (strCodigoParametro <> '0') or (strFieldName = 'TMP_TOTAL_') then
      begin
        if cdsGerar.Fields.Fields[intCnt].AsFloat <> 0.00 then
        begin
          if cdsGerar.Fields.Fields[intCnt].AsFloat > 0 then
          begin
            cdsGerar.Fields.Fields[intCnt].AsFloat := cdsGerar.Fields.Fields[intCnt].AsFloat * -1 ;
          end
          else
          begin
            cdsGerar.Fields.Fields[intCnt].AsFloat := abs(cdsGerar.Fields.Fields[intCnt].AsFloat) ;
          end;
        end;
      end;
    end;
    cdsGerar.Post ;
    cdsGerar.Next ;
  end;
end;

procedure TDemonstracaoMutacaoPatrimonioLiquidoGerar.pRemoveInfoAba();
var
  lstControle : TStringList ;
begin
  lstControle := TStringList.Create ;
  try
    lstControle.Sorted := True ;
    FcdsColunas.First ;
    while not FcdsColunas.Eof do
    begin
      if lstControle.IndexOf(FcdsColunas.FieldByName('ABACOD').AsString) = -1 then
      begin
        lstControle.Add(FcdsColunas.FieldByName('ABACOD').AsString) ;
      end;
      FcdsColunas.Next ;
    end;

    FcdsBandas.First ;
    while not FcdsBandas.Eof do
    begin
      if lstControle.IndexOf(FcdsBandas.FieldByName('CODIGO').AsString) = -1  then
      begin
        FcdsBandas.Delete ;
        Continue
      end;
      FcdsBandas.Next ;
    end;

  finally
    FreeAndNil(lstControle) ;
  end;
end;

procedure TDemonstracaoMutacaoPatrimonioLiquidoGerar.pRemoveInfoColuna(
  const ACodigo: integer);
begin
  if FcdsColunas.Locate('CODIGO', ACodigo, [loCaseInsensitive]) then
  begin
    FcdsColunas.Delete ;
  end;
end;

constructor TDemonstracaoMutacaoPatrimonioLiquidoGerar.Create;
begin
  FEmpresas := TStringList.Create;

  FcdsBandas := TUniClientDataSet.Create(nil) ;
  FcdsBandas.FieldDefs.Add('CODIGO',ftInteger, 0, False);
  FcdsBandas.FieldDefs.Add('DESCRI',ftString, 60, False);
  FcdsBandas.CreateDataSet ;

  FcdsColunas := TUniClientDataSet.Create(nil) ;
  FcdsColunas.FieldDefs.Add('CODIGO',ftInteger, 0, False);
  FcdsColunas.FieldDefs.Add('DESCRI',ftString, 60, False);
  FcdsColunas.FieldDefs.Add('ABACOD',ftInteger, 0, False);
  FcdsColunas.CreateDataSet ;
  FcdsColunas.IndexFieldNames := 'ABACOD' ;

  FLstReservaCapital   := TStringList.Create ;
  FLstReservaCapital.Sorted := True ;
  FLstReservaCapital.Add('4') ;
  FLstReservaCapital.Add('5') ;
  FLstReservaCapital.Add('6') ;
  FLstReservaCapital.Add('7') ;

  FLstReservaAvaliacao := TStringList.Create ;
  FLstReservaAvaliacao.Sorted := True ;
  FLstReservaAvaliacao.Add('9') ;
  FLstReservaAvaliacao.Add('10') ;
  FLstReservaAvaliacao.Add('11') ;

  FLstReservaLucro     := TStringList.Create ;
  FLstReservaLucro.Sorted := True ;
  FLstReservaLucro.Add('13') ;
  FLstReservaLucro.Add('14') ;
  FLstReservaLucro.Add('15') ;
  FLstReservaLucro.Add('16') ;
  FLstReservaLucro.Add('17') ;
  FLstReservaLucro.Add('18') ;

end;

destructor TDemonstracaoMutacaoPatrimonioLiquidoGerar.Destroy;
begin
  FreeAndNil(FEmpresas) ;
  FreeAndNil(FcdsBandas) ;
  FreeAndNil(FcdsColunas) ;

  FreeAndNil(FLstReservaCapital) ;
  FreeAndNil(FLstReservaAvaliacao) ;
  FreeAndNil(FLstReservaLucro) ;

  inherited;
end;

function TDemonstracaoMutacaoPatrimonioLiquidoGerar.fCalculaValorPatrimonioLiquidoPrimeiraAba(
  const aExercicio: integer; const ALstEmpresas: TStringList): double;
var
  cdsLanAtu: TUniClientDataSet ;
  cdsLanAnt: TUniClientDataSet ;
  cdsCtDmpl: TUniClientDataSet ;
  fltExercicio, fltExercicioAnt: double ;
begin
  try
    pProcessarPrimeiraAba(AExercicio, ALstEmpresas, cdsLanAtu, cdsLanAnt, cdsCtDmpl, CODIGO_PATRIMONIO_LIQUIDO) ;
    fltExercicio := 0.00;
    fltExercicioAnt := 0.00;
    cdsLanAtu.First ;
    while not cdsLanAtu.Eof do
    begin
      fltExercicio := fltExercicio + cdsLanAtu.FieldByName('VALOR').AsFloat ;
      cdsLanAtu.Next ;
    end;

    cdsLanAnt.First ;
    while not cdsLanAnt.Eof do
    begin
      fltExercicioAnt := fltExercicioAnt + cdsLanAnt.FieldByName('VALOR').AsFloat ;
      cdsLanAnt.Next ;
    end;

    result := fltExercicioAnt + fltExercicio ;

  finally
    FreeAndNil(cdsLanAtu) ;
    FreeAndNil(cdsLanAnt) ;
    FreeAndNil(cdsCtDmpl) ;
  end;
end;

function TDemonstracaoMutacaoPatrimonioLiquidoGerar.fEmpresasToStr(const ALstEmpresas: TStringList): string;
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

function TDemonstracaoMutacaoPatrimonioLiquidoGerar.fFieldNameValidoValorMPL(
  const AFieldName: string): string;
var
  LFieldName: string ;
  ch : Char ;
begin
  result := '0' ;
  LFieldName := trim(AFieldName.Replace('TMP_', '')) ;
  for ch in LFieldName do
  begin
    if not TCharacter.IsNumber(ch) then
    begin
      exit ;
    end;
  end;
  result := LFieldName ;
end;

function TDemonstracaoMutacaoPatrimonioLiquidoGerar.fGetAbaByCodigo(
  const ACodigo: integer): integer;
var
  intFound : integer ;
  intCodigoBanda : integer ;
  intMult: integer ;
begin
  intCodigoBanda := 0 ;
  intMult := 1 ; ///banda com descrição
  if not FSimplificado then
  begin
    intMult := -1 ; ///banda sem descrição
  end;
  intFound := FLstReservaCapital.IndexOf(intToStr(ACodigo)) ;
  if intFound <> -1 then
  begin
    intCodigoBanda := CODIGO_RESERVA_CAPITAL ;
  end;

  intFound := FLstReservaAvaliacao.IndexOf(intToStr(ACodigo)) ;
  if intFound <> -1 then
  begin
    intCodigoBanda := CODIGO_RESERVA_AVALIACAO ;
  end;

  intFound := FLstReservaLucro.IndexOf(intToStr(ACodigo)) ;
  if intFound <> -1 then
  begin
    intCodigoBanda := CODIGO_RESERVA_LUCRO ;
  end;

  //// colunas com bandas sem descrição
  if ACodigo = 2 then
  begin
    intCodigoBanda := ACodigo*intMult ;
  end;
  if ACodigo = 19 then
  begin
    intCodigoBanda := ACodigo*intMult ;
  end;

  if not FcdsBandas.Locate('CODIGO', intCodigoBanda, [loCaseInsensitive]) then
  begin
    FcdsBandas.Append ;
    FcdsBandas.FieldByName('CODIGO').AsInteger := intCodigoBanda ;
    FcdsBandas.FieldByName('DESCRI').AsString := fGetDescricaoByCodigo(intCodigoBanda) ;
    FcdsBandas.Post ;
  end;

  result := intCodigoBanda ;

end;

function TDemonstracaoMutacaoPatrimonioLiquidoGerar.fGetDescricaoByCodigo(
  const ACodigo: integer): string;
var
  intCnt : integer ;
begin
  result := '' ;
  for intCnt := Low(PARAMETROS_PADRAO) to High(PARAMETROS_PADRAO) do
  begin
    if strToInt(PARAMETROS_PADRAO[intCnt, PARAMETROS_ORDEM_]) = ACodigo then
    begin
      if strToInt(PARAMETROS_PADRAO[intCnt, PARAMETROS_EDITAV]) = 1 then
      begin
        result := fCampoTabela('DMP_DESCRI', 'PRDMPL', ['DMP_EXERCI', 'DMP_ORDEM_'], [FAnoExercicio, ACodigo], False) ;
      end
      else
      begin
        result := PARAMETROS_PADRAO[intCnt, PARAMETROS_DESCRI] ;
      end;
      break ;
    end;
  end;
end;

function TDemonstracaoMutacaoPatrimonioLiquidoGerar.fListToStrEmpresas: String;
var
  LCnt: Integer ;
begin
  Result := '' ;
  for LCnt := 0 to FEmpresas.Count-1 do
    Result := Result + IfThen(fEmptyStr(Result), '', ',') + QuotedStr(FEmpresas.Strings[LCnt]) ;
end;

function TDemonstracaoMutacaoPatrimonioLiquidoGerar.fPreparaFiltroEmpresa(
  const ANomerabela, AColEmpresa: string; const ALstEmpresas: TStringList): string;
begin
  result := fEmpresasToStr(ALstEmpresas) ;
  if not fEmptyStr(result) then
  begin
    result := ' AND ' + ANomerabela + '.' + AColEmpresa + ' IN ('+result+') ' ;
  end;
end;

procedure TDemonstracaoMutacaoPatrimonioLiquidoGerar.pProcessarPrimeiraAba(
  const aExercicio: integer; const ALstEmpresas: TStringList;
  var cdsExercicioAtual, cdsExercicioAnterior, cdsCtDmpl: TUniClientDataSet;
  ACodigoParametroConta: integer);
var
  strSqlCta : string ;
  strCta : string ;
  strFiltro : string ;
  strSql : string ;
  qryCtDmpl : TUniQuery ;
  qryLan : TUniQuery ;
  JsonArr : TJSONArray ;
  strTplaco : String ;
  LEmpresas: String ;
begin

  qryCtDmpl := fCriaQuery() ;
  qryLan := fCriaQuery() ;
  JsonArr := TJSONArray.Create;
  strTplaco := fRetTplacoEmpresaLogada ;
  LEmpresas := fListToStrEmpresas ;
  try
    strSqlCta := '' ;
    strSqlCta := strSqlCta + ' SELECT DMP_ORDEM_, DMP_CODCON, PLANCO.NCO_CODCON ' ;
    strSqlCta := strSqlCta + '  FROM PRDMPL ' ;
    strSqlCta := strSqlCta + '       INNER JOIN CTDMPL ON CTDMPL.DMP_SEQLAN = PRDMPL.AUTOINCREM ' ;
    strSqlCta := strSqlCta + '       LEFT JOIN PLANCO ON NCO_CODCON LIKE CONCAT(DMP_CODCON,"%") AND NCO_NATURE = "A" AND NCO_TPLACO = '+ strTplaco.QuotedString ;
    strSqlCta := strSqlCta + '  WHERE PRDMPL.DMP_EXERCI = :EXERCI AND COALESCE(PRDMPL.DMP_CODEMP, "") IN (' + LEmpresas + ') ' ;
    if ACodigoParametroConta <> 0 then
    begin
      strSqlCta := strSqlCta + '  AND DMP_ORDEM_ = :ORDEM_ ' ;
    end;
    strSqlCta := strSqlCta + '  ORDER BY DMP_ORDEM_, DMP_CODCON, PLANCO.NCO_CODCON  ' ;

    qryCtDmpl.Close ;
    qryCtDmpl.SQL.Clear ;
    qryCtDmpl.SQL.Add(strSqlCta) ;
    qryCtDmpl.ParamByName('EXERCI').AsInteger := AExercicio ;
    if ACodigoParametroConta <> 0 then
    begin
      qryCtDmpl.ParamByName('ORDEM_').AsInteger := ACodigoParametroConta ;
    end;
    qryCtDmpl.Open ;

    cdsCtDmpl := fCriaClientDatset(qryCtDmpl) ;
    cdsCtDmpl.IndexFieldNames := 'DMP_ORDEM_' ;

    ////separa as contas para buscar os valores na lancon
    cdsCtDmpl.DisableControls ;
    try
      cdsCtDmpl.First ;
      while not cdsCtDmpl.Eof do
      begin
        JsonArr.AddElement(TJSONString.Create(cdsCtDmpl.FieldByName('NCO_CODCON').AsString));
        cdsCtDmpl.Next ;
      end;
    finally
      cdsCtDmpl.EnableControls ;
    end;
    strCta := JsonArr.ToString.Replace('[','').Replace(']','') ;

    if fEmptyStr(strCta) then
    begin
      exit ;
    end;

    strFiltro := fPreparaFiltroEmpresa('LANBAL', 'BAL_CODEMP', ALstEmpresas) ;

    strSql := '' ;
    strSql := strSql + '  SELECT LANBAL.BAL_CODCON AS CODCON, SUM(COALESCE(CASE WHEN LANBAL.BAL_CRDEFI = "C" THEN -LANBAL.BAL_SALFIN ELSE LANBAL.BAL_SALFIN END, 0.00)) AS VALOR ' ;
    strSql := strSql + '  FROM LANBAL ' ;
    strSql := strSql + '  WHERE EXTRACT(YEAR FROM LANBAL.BAL_DTAMOV) = :EXERCI AND EXTRACT(MONTH FROM LANBAL.BAL_DTAMOV) = 12 ' ;
    strSql := strSql + '        AND LANBAL.BAL_CODCON IN (' + strCta + ') ' ;
    strSql := strSql + ' 			                 ' + strFiltro ;
    strSql := strSql + '  GROUP BY LANBAL.BAL_CODCON ' ;

    qryLan.Close ;
    qryLan.SQL.Clear ;
    qryLan.SQL.Add(strSql) ;
    qryLan.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryLan.Open ;

    cdsExercicioAtual := fCriaClientDatset(qryLan) ;
    cdsExercicioAtual.IndexFieldNames := 'CODCON' ;

    qryLan.Close ;
    qryLan.ParamByName('EXERCI').AsInteger := AExercicio-1 ;
    qryLan.Open ;

    cdsExercicioAnterior := fCriaClientDatset(qryLan) ;
    cdsExercicioAnterior.IndexFieldNames := 'CODCON' ;
  finally
    FreeAndNil(qryCtDmpl) ;
    FreeAndNil(qryLan) ;
    FreeAndNil(JsonArr) ;
  end;
end;

function TDemonstracaoMutacaoPatrimonioLiquidoGerar.Processar: TUniClientDataset;
var
  qryColunas : TUniQuery ;
  cdsGerar : TUniClientDataset ;
  strCodigoColunas : String ;
  LEmpresas: String ;
begin
  result := nil ;

  if FAnoExercicio <= 0 then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não selecionado!' , ['&Ok']);
    exit ;
  end;

  LEmpresas := fListToStrEmpresas ;

  if fEmptyStr(LEmpresas) then
  begin
    fMensagem('ATENÇÃO!', 'Empresa não selecionada!' , ['&Ok']);
    exit ;
  end ;

  if FSimplificado then  ///sintética
  begin
    strCodigoColunas := '2,3,8,12,19' ;
  end
  else ///analitica
  begin
    strCodigoColunas := '2,4,5,6,7,9,10,11,13,14,15,16,17,18,19' ;
  end;

  qryColunas := fCriaQuery() ;
  try
    qryColunas.Close ;
    qryColunas.SQL.Clear ;
    qryColunas.SQL.Add(' SELECT DMP_ORDEM_, DMP_DESCRI ') ;
    qryColunas.SQL.Add(' FROM PRDMPL ') ;
    qryColunas.SQL.Add(' WHERE DMP_EXERCI = :EXERCI ') ;
    qryColunas.SQL.Add(' AND DMP_CODEMP IN (' + LEmpresas + ') ') ;
    qryColunas.SQL.Add(' AND DMP_ORDEM_ IN (' + strCodigoColunas + ') ') ;
    qryColunas.SQL.Add(' ORDER BY DMP_ORDEM_ ') ;
    qryColunas.ParamByName('EXERCI').AsInteger := FAnoExercicio ;
    qryColunas.Open ;
    /////monta o cds de retorno de acordo com as colunas

    cdsGerar := TUniClientDataset.Create(nil) ;
    cdsGerar.FieldDefs.Clear ;
    cdsGerar.FieldDefs.Add('TMP_ID',ftInteger, 0, False); ///campo virtual
    cdsGerar.FieldDefs.Add('TMP_CODMOV',ftInteger, 0, False);
    cdsGerar.FieldDefs.Add('TMP_HISTMV',ftString, 60, False);
    cdsGerar.FieldDefs.Add('TMP_NTEXPL',ftString, 60, False);
    ////cria as colunas
    qryColunas.First ;
    while not qryColunas.Eof do
    begin
      cdsGerar.FieldDefs.Add('TMP_'+fStrZero(qryColunas.FieldByName('DMP_ORDEM_').AsString, 6),ftFloat , 0, False);
      qryColunas.Next ;
    end;
    cdsGerar.FieldDefs.Add('TMP_TOTAL_',ftFloat , 0, False);
    cdsGerar.CreateDataSet ;

    FProgresso.Position := Progresso.Position + 1 ;
    Application.ProcessMessages ;

    pCarregaValoresContaContabil(FAnoExercicio, FEmpresas, cdsGerar) ;

    result := cdsGerar ;
  finally
    FreeAndNil(qryColunas) ;
  end;
end;

procedure TDemonstracaoMutacaoPatrimonioLiquidoGerar.SetSimplificado(
  const Value: Boolean);
begin
  FSimplificado := Value;
  if FSimplificado then
  begin
    FLstReservaCapital.Add('3') ;
    FLstReservaAvaliacao.Add('8') ;
    FLstReservaLucro.Add('12') ;
  end;
end;

{ TDemonstracaoMutacaoPatrimonioLiquidoParametros }

class procedure TDemonstracaoMutacaoPatrimonioLiquidoParametros.Carregar(
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
  strSql := strSql + '  DMP_EXERCI, ' ;
  strSql := strSql + '  DMP_CODEMP, ' ;
  strSql := strSql + '  CAST(CONCAT(REPEAT(" ",DMP_NIVEL_*3), DMP_DESCRI) AS CHAR(150)) AS DMP_DESCRI, ' ;
  strSql := strSql + '  DMP_NIVEL_, ' ;
  strSql := strSql + '  DMP_ORDEM_, ' ;
  strSql := strSql + '  DMP_EDITAV, ' ;
  strSql := strSql + '  DMP_NEGRIT, ' ;
  strSql := strSql + '  DMP_CONTAS, ' ;
  strSql := strSql + '  (CAST(NULL AS CHAR(4))) AS CNT_BTN ' ;
  strSql := strSql + ' FROM PRDMPL ' ;
  strSql := strSql + ' WHERE DMP_EXERCI = :EXERCI AND COALESCE(DMP_CODEMP, "") = :CODEMP ' ;
  strSql := strSql + ' ORDER BY DMP_ORDEM_' ;

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
  strSql := strSql + ' CTDMPL.AUTOINCREM, ' ;
  strSql := strSql + ' CTDMPL.DMP_SEQLAN, ' ;
  strSql := strSql + ' CTDMPL.DMP_CODCON, ' ;
  strSql := strSql + ' PLANCO.NCO_DESCRI ' ;
  strSql := strSql + ' FROM CTDMPL INNER JOIN PLANCO ON CTDMPL.DMP_CODCON = PLANCO.NCO_CODCON AND PLANCO.NCO_TPLACO = '+ strTplaco.QuotedString ;
  strSql := strSql + ' WHERE CTDMPL.DMP_SEQLAN in ('+ strCnt +') ' ;
  strSql := strSql + ' ORDER BY CTDMPL.AUTOINCREM ' ;

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
    cdsParametrosContas.IndexFieldNames := 'DMP_CODCON;DMP_SEQLAN' ;
  finally
    FreeAndNil(qryParametrosContas);
  end;

end;

class function TDemonstracaoMutacaoPatrimonioLiquidoParametros.Deletar(
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
      qryExec.SQL.Add(fGetSqlDeletePRDMPL);
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

class function TDemonstracaoMutacaoPatrimonioLiquidoParametros.fGetSqlDeleteCTDMPL: string;
begin
  result := 'DELETE FROM CTDMPL WHERE DMP_SEQLAN IN (SELECT AUTOINCREM FROM PRDMPL WHERE DMP_EXERCI = :EXERCI AND COALESCE(DMP_CODEMP, "") = :CODEMP) ;' ;
end;

class function TDemonstracaoMutacaoPatrimonioLiquidoParametros.fGetSqlDeletePRDMPL: string;
begin
  result := 'DELETE FROM PRDMPL WHERE DMP_EXERCI = :EXERCI AND COALESCE(DMP_CODEMP, "") = :CODEMP ; ' ;
end;

class function TDemonstracaoMutacaoPatrimonioLiquidoParametros.fGetSqlInsertCTDMPL: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO CTDMPL ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' AUTOINCREM, ' ;
  strSql := strSql + ' DMP_SEQLAN, ' ;
  strSql := strSql + ' DMP_CODCON ' ;
  strSql := strSql + ' ) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' :AUTOINCREM, ' ;
  strSql := strSql + ' :SEQLAN, ' ;
  strSql := strSql + ' :CODCON ' ;
  strSql := strSql + ' ); ' ;

  result := strSql ;
end;

class function TDemonstracaoMutacaoPatrimonioLiquidoParametros.fGetSqlInsertPRDMPL: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO PRDMPL ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' AUTOINCREM, ' ;
  strSql := strSql + ' DMP_EXERCI, ' ;
  strSql := strSql + ' DMP_DESCRI, ' ;
  strSql := strSql + ' DMP_NIVEL_, ' ;
  strSql := strSql + ' DMP_ORDEM_, ' ;
  strSql := strSql + ' DMP_EDITAV, ' ;
  strSql := strSql + ' DMP_NEGRIT, ' ;
  strSql := strSql + ' DMP_CONTAS, ' ;
  strSql := strSql + ' DMP_CODEMP ' ;
  strSql := strSql + ' ) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' :AUTOINCREM, ' ;
  strSql := strSql + ' :EXERCI, ' ;
  strSql := strSql + ' :DESCRI, ' ;
  strSql := strSql + ' :NIVEL_, ' ;
  strSql := strSql + ' :ORDEM_, ' ;
  strSql := strSql + ' :EDITAV, ' ;
  strSql := strSql + ' :NEGRIT, ' ;
  strSql := strSql + ' :CONTAS, ' ;
  strSql := strSql + ' :CODEMP ' ;
  strSql := strSql + ' ); ' ;
  result := strSql ;
end;

class function TDemonstracaoMutacaoPatrimonioLiquidoParametros.Gravar(const AExercicio: integer; const cdsParametros,
  cdsParametrosContas: TUniClientDataSet; const ModoInsert: Boolean; const ACodEmp: String): boolean;
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
        qryExec.SQL.Add(fGetSqlInsertPRDMPL);
        cdsParametros.DisableControls;
        cdsParametrosContas.DisableControls;
        try
          cdsParametros.First ;
          while not cdsParametros.Eof do
          begin
            qryExec.ParamByName('AUTOINCREM').AsString := cdsParametros.FieldByName('AUTOINCREM').AsString  ;
            qryExec.ParamByName('EXERCI').AsInteger := cdsParametros.FieldByName('DMP_EXERCI').AsInteger  ;
            qryExec.ParamByName('DESCRI').AsString :=  trim(cdsParametros.FieldByName('DMP_DESCRI').AsString)  ;
            qryExec.ParamByName('NIVEL_').AsInteger := cdsParametros.FieldByName('DMP_NIVEL_').AsInteger  ;
            qryExec.ParamByName('ORDEM_').AsInteger := cdsParametros.FieldByName('DMP_ORDEM_').AsInteger  ;
            qryExec.ParamByName('EDITAV').AsInteger := cdsParametros.FieldByName('DMP_EDITAV').AsInteger  ;
            qryExec.ParamByName('NEGRIT').AsInteger := cdsParametros.FieldByName('DMP_NEGRIT').AsInteger  ;
            qryExec.ParamByName('CONTAS').AsInteger := cdsParametros.FieldByName('DMP_CONTAS').AsInteger  ;
            qryExec.ParamByName('CODEMP').AsString := cdsParametros.FieldByName('DMP_CODEMP').AsString  ;
            qryExec.ExecSQL ;
            cdsParametros.Next ;
          end;

          qryExec.Close ;
          qryExec.SQL.Clear ;
          qryExec.SQL.Add(fGetSqlInsertCTDMPL) ;
          cdsParametrosContas.First;
          while not cdsParametrosContas.Eof do
          begin
            qryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CTDMPL',Vs_strCodEmp) ;
            qryExec.ParamByName('SEQLAN').AsString := cdsParametrosContas.FieldByName('DMP_SEQLAN').AsString ;
            qryExec.ParamByName('CODCON').AsString := cdsParametrosContas.FieldByName('DMP_CODCON').AsString ;
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
          qryExec.SQL.Add(fGetSqlDeleteCTDMPL) ;
          qryExec.ParamByName('EXERCI').AsInteger := AExercicio ;
          qryExec.ParamByName('CODEMP').AsString := ACodEmp ;
          qryExec.ExecSQL ;
          /////
          qryExec.Close ;
          qryExec.SQL.Clear ;
          qryExec.SQL.Add(fGetSqlInsertCTDMPL) ;
          cdsParametrosContas.First;
          while not cdsParametrosContas.Eof do
          begin
            qryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CTDMPL',Vs_strCodEmp) ;
            qryExec.ParamByName('SEQLAN').AsString := cdsParametrosContas.FieldByName('DMP_SEQLAN').AsString ;
            qryExec.ParamByName('CODCON').AsString := cdsParametrosContas.FieldByName('DMP_CODCON').AsString ;
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

class procedure TDemonstracaoMutacaoPatrimonioLiquidoParametros.IncluirDe(
  const AExercicio: integer; const ACodEmp: String; var qryDmpl: TUniquery;
  var cdsCon: TUniClientDataSet);
var
  qryCon : TUniquery ;
begin
  qryCon := fCriaQuery() ;
  try
    qryDmpl.Close ;
    qryDmpl.SQL.Clear ;
    qryDmpl.SQL.Add(' SELECT') ;
    qryDmpl.SQL.Add(' AUTOINCREM,') ;
    qryDmpl.SQL.Add(' DMP_DESCRI,') ;
    qryDmpl.SQL.Add(' DMP_NIVEL_,') ;
    qryDmpl.SQL.Add(' DMP_ORDEM_,') ;
    qryDmpl.SQL.Add(' DMP_EDITAV,') ;
    qryDmpl.SQL.Add(' DMP_NEGRIT,') ;
    qryDmpl.SQL.Add(' DMP_CONTAS') ;
    qryDmpl.SQL.Add(' FROM PRDMPL') ;
    qryDmpl.SQL.Add(' WHERE DMP_EXERCI = :EXERCI AND COALESCE(DMP_CODEMP, "") = :CODEMP ') ;
    qryDmpl.SQL.Add(' ORDER BY DMP_ORDEM_') ;
    qryDmpl.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryDmpl.ParamByName('CODEMP').AsString := ACodEmp ;
    qryDmpl.Open ;
    qryDmpl.First ;

    qryCon.Close ;
    qryCon.SQL.Clear ;
    qryCon.SQL.Add(' SELECT ') ;
    qryCon.SQL.Add('   CTDMPL.DMP_SEQLAN, ') ;
    qryCon.SQL.Add('   CTDMPL.DMP_CODCON ') ;
    qryCon.SQL.Add(' FROM CTDMPL ') ;
    qryCon.SQL.Add(' WHERE DMP_SEQLAN IN (SELECT AUTOINCREM FROM PRDMPL WHERE DMP_EXERCI = :EXERCI  AND COALESCE(DMP_CODEMP, "") = :CODEMP ) ') ;
    qryCon.SQL.Add(' ORDER BY CTDMPL.AUTOINCREM ') ;
    qryCon.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryCon.ParamByName('CODEMP').AsString := ACodEmp ;
    qryCon.Open ;

    cdsCon := fCriaClientDatset(qryCon);
    cdsCon.Open;
    cdsCon.IndexFieldNames := 'DMP_SEQLAN' ;

  finally
    FreeAndNil(qryCon) ;
  end;
end;

{ TDemonstracaoMutacaoPatrimonioLiquidoExercicio }

class function TDemonstracaoMutacaoPatrimonioLiquidoExercicio.fRetornaNomeTabela(
  const ATipo: TTipoExercicio): String;
begin
  if ATipo = teNotaExplicativa then
  begin
    result := 'NEDMPL' ;
  end
  else if ATipo = teMovimentacao then
  begin
    result := 'MVDMPL' ;
  end
  else ///default
  begin
    result := 'PRDMPL' ;
  end;
end;

class function TDemonstracaoMutacaoPatrimonioLiquidoExercicio.Listar(const ACodEmp: String; const ATipo: TTipoExercicio): TStringList;
var
  qryExercicio : TUniquery ;
  strNomeTabela : String ;
begin
  result := TStringList.Create ;
  result.Sorted := True ;

  strNomeTabela := fRetornaNomeTabela(ATipo) ;

  qryExercicio := fCriaQuery() ;
  try
    qryExercicio.Close ;
    qryExercicio.SQL.Clear ;
    qryExercicio.SQL.Add('SELECT DISTINCT DMP_EXERCI FROM ' + strNomeTabela + ' WHERE COALESCE(DMP_CODEMP, "") = :CODEMP ') ;
    qryExercicio.ParamByName('CODEMP').AsString := ACodEmp ;
    qryExercicio.Open ;
    qryExercicio.First ;
    while not qryExercicio.Eof do
    begin
      result.Add( qryExercicio.FieldByName('DMP_EXERCI').AsString ) ;
      qryExercicio.Next ;
    end;
  finally
    FreeAndNil(qryExercicio) ;
  end;
end;

class function TDemonstracaoMutacaoPatrimonioLiquidoExercicio.VerificarExistente(
  const AExercicio: integer; const AModoInsert: Boolean; const ATipo: TTipoExercicio;
  const ACodEmp: String): boolean;
var
  qryExerc : TUniQuery ;
  strNomeTabela : String ;
begin
  result := False ;
  if not AModoInsert then
  begin
    exit ;
  end;

  strNomeTabela := fRetornaNomeTabela(ATipo) ;
  
  qryExerc := fCriaQuery() ;
  try
    qryExerc.Close ;
    qryExerc.SQL.Clear ;
    qryExerc.SQL.Add('SELECT DMP_EXERCI FROM ' + strNomeTabela + ' WHERE DMP_EXERCI = :EXERCI AND COALESCE(DMP_CODEMP, "") = :CODEMP LIMIT 1') ;
    qryExerc.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryExerc.ParamByName('CODEMP').AsString := ACodEmp ;
    qryExerc.Open ;

    result := not qryExerc.IsEmpty ;
  finally
    FreeAndNil(qryExerc) ;
  end;
end;

{ TDemonstracaoMutacaoPatrimonioLiquidoNotasExplicativas }

class procedure TDemonstracaoMutacaoPatrimonioLiquidoNotasExplicativas.Carregar(
  const AExercicio: integer; const ACodEmp: String; var cdsNotasExplicativas: TUniClientDataSet);
var
  strSql : string ;
  qryParametrosNotas: TUniQuery;
begin
  ////notas explicativas associadas ao exercicio.
  strSql := '' ;
  strSql := strSql + '  SELECT ' ;
  strSql := strSql + '  NEDMPL.AUTOINCREM, ' ;
  strSql := strSql + '  NEDMPL.DMP_EXERCI, ' ;
  strSql := strSql + '  NEDMPL.DMP_CODEXP, ' ;
  strSql := strSql + '  NTEXPL.EXP_NOTEXP, ' ;
  strSql := strSql + '  NEDMPL.DMP_CODEMP ' ;
  strSql := strSql + '  FROM NEDMPL INNER JOIN NTEXPL ON NEDMPL.DMP_CODEXP = NTEXPL.EXP_CODIGO ' ;
  strSql := strSql + '  WHERE NEDMPL.DMP_EXERCI = :EXERCI AND COALESCE(NEDMPL.DMP_CODEMP, "") = :CODEMP ' ;
  strSql := strSql + '  ORDER BY NEDMPL.AUTOINCREM  ' ;

  qryParametrosNotas := fCriaQuery;
  try
    qryParametrosNotas.Close ;
    qryParametrosNotas.SQL.Clear ;
    qryParametrosNotas.SQL.Add(strSql) ;
    qryParametrosNotas.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryParametrosNotas.ParamByName('CODEMP').AsString := ACodEmp ;
    qryParametrosNotas.Open ;

    If Assigned(cdsNotasExplicativas) Then
      FreeAndNil(cdsNotasExplicativas);

    cdsNotasExplicativas := fCriaClientDatset(qryParametrosNotas);
    cdsNotasExplicativas.Open;
    ////campos com valor obrigatório
    cdsNotasExplicativas.FieldByName('DMP_CODEXP').Required := True ;
    ////cria o indice unico
    cdsNotasExplicativas.AddIndex('IndiceUnico','DMP_EXERCI;DMP_CODEMP;DMP_CODEXP', [ixUnique]);
    cdsNotasExplicativas.IndexName := 'IndiceUnico' ;
    ////
  finally
    FreeAndNil(qryParametrosNotas);
  end;

end;

class function TDemonstracaoMutacaoPatrimonioLiquidoNotasExplicativas.Deletar(
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
      qryExec.SQL.Add(fGetSqlDelete);
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

class function TDemonstracaoMutacaoPatrimonioLiquidoNotasExplicativas.fGetSqlDelete: string;
begin
  result := 'DELETE FROM NEDMPL WHERE DMP_EXERCI = :EXERCI AND COALESCE(DMP_CODEMP, "") = :CODEMP; ' ;
end;

class function TDemonstracaoMutacaoPatrimonioLiquidoNotasExplicativas.fGetSqlInsert: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO NEDMPL ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' AUTOINCREM, ' ;
  strSql := strSql + ' DMP_EXERCI, ' ;
  strSql := strSql + ' DMP_CODEMP, ' ;
  strSql := strSql + ' DMP_CODEXP ' ;
  strSql := strSql + ' ) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' :AUTOINCREM, ' ;
  strSql := strSql + ' :EXERCI, ' ;
  strSql := strSql + ' :CODEMP, ' ;
  strSql := strSql + ' :CODEXP ' ;
  strSql := strSql + ' ); ' ;
  result := strSql ;
end;

class function TDemonstracaoMutacaoPatrimonioLiquidoNotasExplicativas.Gravar(
  const AExercicio: integer; const cdsNotasExplicativas: TUniClientDataSet;
  const ModoInsert: Boolean; const ACodEmp: String): boolean;
var
  qryExec : TUniQuery ;
begin
  fStartTransaction;
  try
    qryExec := fCriaQuery ;
    cdsNotasExplicativas.DisableControls;
    try
      /////modo edição
      if not ModoInsert then
      begin
        /////exclui e relança os dados das contas contabeis
        qryExec.Close ;
        qryExec.SQL.Clear ;
        qryExec.SQL.Add(fGetSqlDelete) ;
        qryExec.ParamByName('EXERCI').AsInteger := AExercicio  ;
        qryExec.ParamByName('CODEMP').AsString := ACodEmp  ;
        qryExec.ExecSQL ;
      end;
      qryExec.Close ;
      qryExec.SQL.Clear ;
      qryExec.SQL.Add(fGetSqlInsert);
      cdsNotasExplicativas.First ;
      while not cdsNotasExplicativas.Eof do
      begin
        qryExec.ParamByName('AUTOINCREM').AsString := cdsNotasExplicativas.FieldByName('AUTOINCREM').AsString  ;
        qryExec.ParamByName('EXERCI').AsInteger := cdsNotasExplicativas.FieldByName('DMP_EXERCI').AsInteger  ;
        qryExec.ParamByName('CODEMP').AsString :=  cdsNotasExplicativas.FieldByName('DMP_CODEMP').AsString  ;
        qryExec.ParamByName('CODEXP').AsInteger :=  cdsNotasExplicativas.FieldByName('DMP_CODEXP').AsInteger  ;
        qryExec.ExecSQL ;
        cdsNotasExplicativas.Next ;
      end;
    finally
      cdsNotasExplicativas.EnableControls;
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

class procedure TDemonstracaoMutacaoPatrimonioLiquidoNotasExplicativas.IncluirDe(
  const AExercicio: integer; const ACodEmp: String; var qryNotasExplicativas: TUniquery);
begin
  qryNotasExplicativas.Close ;
  qryNotasExplicativas.SQL.Clear ;
  qryNotasExplicativas.SQL.Add(' SELECT') ;
  qryNotasExplicativas.SQL.Add('  NEDMPL.AUTOINCREM,') ;
  qryNotasExplicativas.SQL.Add('  NEDMPL.DMP_EXERCI,') ;
  qryNotasExplicativas.SQL.Add('  NEDMPL.DMP_CODEMP,') ;
  qryNotasExplicativas.SQL.Add('  NEDMPL.DMP_CODEXP,') ;
  qryNotasExplicativas.SQL.Add('  NTEXPL.EXP_NOTEXP ') ;
  qryNotasExplicativas.SQL.Add(' FROM NEDMPL INNER JOIN NTEXPL ON NEDMPL.DMP_CODEXP = NTEXPL.EXP_CODIGO ') ;
  qryNotasExplicativas.SQL.Add(' WHERE NEDMPL.DMP_EXERCI = :EXERCI AND NEDMPL.DMP_CODEMP = :CODEMP ') ;
  qryNotasExplicativas.SQL.Add(' ORDER BY NEDMPL.AUTOINCREM ') ;
  qryNotasExplicativas.ParamByName('EXERCI').AsInteger := AExercicio ;
  qryNotasExplicativas.ParamByName('CODEMP').AsString := ACodEmp ;
  qryNotasExplicativas.Open ;
  qryNotasExplicativas.First ;
end;

{ TDemonstracaoMutacaoPatrimonioLiquidoMovimentacao }

class procedure TDemonstracaoMutacaoPatrimonioLiquidoMovimentacao.Carregar(
  const AExercicio: integer; const ACodEmp: String; var cdsMovimentacao, cdsContasCre, cdsContasDeb,
  cdsNotas: TUniClientDataSet);
var
  strSql : string ;
  qryMovimentacao: TUniQuery;
  qryMovimentacaoContas: TUniQuery;
  qryMovimentacaoNotas: TUniQuery;
  strCnt : string ;
  strTplaco : string ;
begin
  strSql := '' ;
  strSql := strSql + ' SELECT ' ;
  strSql := strSql + '  MVDMPL.AUTOINCREM, ' ;
  strSql := strSql + '  MVDMPL.DMP_EXERCI, ' ;
  strSql := strSql + '  MVDMPL.DMP_CODEMP, ' ;
  strSql := strSql + '  MVDMPL.DMP_CONTIT, ' ;
  strSql := strSql + '  MVDMPL.DMP_CODMOV, ' ;
  strSql := strSql + '  HISTMV.HST_DESCRI, ' ;
  strSql := strSql + '  MVDMPL.DMP_HISPAD, ' ;
  strSql := strSql + '  HISPAD.PAD_DESCRI, ' ;
  strSql := strSql + '  CAST(NULL AS CHAR(10)) AS DMP_CONCRE, ' ;
  strSql := strSql + '  CAST(NULL AS CHAR(10)) AS DMP_CONDEB, ' ;
  strSql := strSql + '  CAST(NULL AS CHAR(10240)) AS DMP_NOTEXP ' ;
  strSql := strSql + ' FROM MVDMPL ' ;
  strSql := strSql + '  INNER JOIN HISTMV ON MVDMPL.DMP_CODMOV = HISTMV.HST_CODIGO ' ;
  strSql := strSql + '  LEFT JOIN CADEMP ON MVDMPL.DMP_CODEMP = CADEMP.EMP_CODEMP ';
  strSql := strSql + '  LEFT  JOIN HISPAD ON MVDMPL.DMP_HISPAD = HISPAD.PAD_CODIGO ' ;
  if fCfgHisTpl then
    strSql := strSql + '  AND HISPAD.PAD_TPLACO = CADEMP.EMP_TPLACO '
  else
    strSql := strSql + '  AND IFNULL(HISPAD.PAD_TPLACO, "") = "" ';

  strSql := strSql + ' WHERE MVDMPL.DMP_EXERCI = :EXERCI AND COALESCE(MVDMPL.DMP_CODEMP, "") = :CODEMP ' ;
  strSql := strSql + ' ORDER BY MVDMPL.AUTOINCREM ' ;

  qryMovimentacao := fCriaQuery;
  try
    qryMovimentacao.Close ;
    qryMovimentacao.SQL.Clear ;
    qryMovimentacao.SQL.Add(strSql) ;
    qryMovimentacao.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryMovimentacao.ParamByName('CODEMP').AsString := ACodEmp ;
    qryMovimentacao.Open ;

    If Assigned(cdsMovimentacao) Then
      FreeAndNil(cdsMovimentacao);

    cdsMovimentacao := fCriaClientDatset(qryMovimentacao);

    cdsMovimentacao.Open;
    ////campos com valor obrigatório
    cdsMovimentacao.FieldByName('DMP_CODMOV').Required := True ;
    ////cria o indice unico
    cdsMovimentacao.AddIndex('IndiceUnico','DMP_EXERCI;DMP_CODEMP;DMP_CODMOV', [ixUnique]);
    cdsMovimentacao.IndexName := 'IndiceUnico' ;

    cdsMovimentacao.First ;
    strCnt := QuotedStr('-1') ;
    while not cdsMovimentacao.Eof do
    begin
      strCnt := strCnt +','+ QuotedStr(cdsMovimentacao.FieldByName('AUTOINCREM').AsString) ;
      cdsMovimentacao.Next ;
    end;

  finally
    FreeAndNil(qryMovimentacao);
  end;

  ////contas associadas na movimentação.
  ///  Credito
  strTplaco := fRetTplacoEmpresaLogada ;
  strSql := '' ;
  strSql := strSql + ' SELECT ' ;
  strSql := strSql + '  DTDMPL.AUTOINCREM, ' ;
  strSql := strSql + '  DTDMPL.DMP_SEQDMP, ' ;
  strSql := strSql + '  DTDMPL.DMP_CREDEB, ' ;
  strSql := strSql + '  DTDMPL.DMP_CODCON, ' ;
  strSql := strSql + '  PLANCO.NCO_DESCRI ' ;
  strSql := strSql + ' FROM DTDMPL ' ;
  strSql := strSql + '  INNER JOIN PLANCO ON DTDMPL.DMP_CODCON = PLANCO.NCO_CODCON AND PLANCO.NCO_TPLACO = '+ strTplaco.QuotedString ;
  strSql := strSql + ' WHERE DTDMPL.DMP_CREDEB = :CREDEB AND DTDMPL.DMP_SEQDMP IN (' + strCnt + ') ' ;
  strSql := strSql + ' ORDER BY DTDMPL.AUTOINCREM ' ;

  qryMovimentacaoContas := fCriaQuery;
  try
    qryMovimentacaoContas.Close ;
    qryMovimentacaoContas.SQL.Clear ;
    qryMovimentacaoContas.SQL.Add(strSql) ;
    qryMovimentacaoContas.ParamByName('CREDEB').AsString := 'C' ;
    qryMovimentacaoContas.Open ;

    If Assigned(cdsContasCre) Then
      FreeAndNil(cdsContasCre);

    cdsContasCre := fCriaClientDatset(qryMovimentacaoContas);
    cdsContasCre.Open;
  finally
    FreeAndNil(qryMovimentacaoContas);
  end;

  ///  Debito
  qryMovimentacaoContas := fCriaQuery;
  try
    qryMovimentacaoContas.Close ;
    qryMovimentacaoContas.SQL.Clear ;
    qryMovimentacaoContas.SQL.Add(strSql) ;
    qryMovimentacaoContas.ParamByName('CREDEB').AsString := 'D' ;
    qryMovimentacaoContas.Open ;

    If Assigned(cdsContasDeb) Then
      FreeAndNil(cdsContasDeb);

    cdsContasDeb := fCriaClientDatset(qryMovimentacaoContas);
    cdsContasDeb.Open;
  finally
    FreeAndNil(qryMovimentacaoContas);
  end;

  ////Notas associadas na movimentação.
  strSql := '' ;
  strSql := strSql + ' SELECT ' ;
  strSql := strSql + '  DT2DMP.AUTOINCREM, ' ;
  strSql := strSql + '  DT2DMP.DMP_SEQDMP, ' ;
  strSql := strSql + '  DT2DMP.DMP_CODEXP, ' ;
  strSql := strSql + '  NTEXPL.EXP_NOTEXP ' ;
  strSql := strSql + ' FROM DT2DMP ' ;
  strSql := strSql + '  INNER JOIN NTEXPL ON DT2DMP.DMP_CODEXP = NTEXPL.EXP_CODIGO ' ;
  strSql := strSql + ' WHERE DT2DMP.DMP_SEQDMP IN (' + strCnt + ') ' ;
  strSql := strSql + ' ORDER BY DT2DMP.AUTOINCREM' ;

  qryMovimentacaoNotas := fCriaQuery;
  try
    qryMovimentacaoNotas.Close ;
    qryMovimentacaoNotas.SQL.Clear ;
    qryMovimentacaoNotas.SQL.Add(strSql) ;
    qryMovimentacaoNotas.Open ;

    If Assigned(cdsNotas) Then
      FreeAndNil(cdsNotas);

    cdsNotas := fCriaClientDatset(qryMovimentacaoNotas);
    cdsNotas.Open;
    cdsNotas.IndexFieldNames := 'DMP_SEQDMP' ;
  finally
    FreeAndNil(qryMovimentacaoContas);
  end;

end;

class function TDemonstracaoMutacaoPatrimonioLiquidoMovimentacao.Deletar(
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
      qryExec.SQL.Add(fGetSqlDeleteMVDMPL);
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

class function TDemonstracaoMutacaoPatrimonioLiquidoMovimentacao.fGetSqlDeleteMVDMPL: string;
begin
  result := 'DELETE FROM MVDMPL WHERE DMP_EXERCI = :EXERCI AND COALESCE(DMP_CODEMP, "") = :CODEMP ; ' ;
end;

class function TDemonstracaoMutacaoPatrimonioLiquidoMovimentacao.fGetSqlInsertDT2DMP: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO DT2DMP ';
  strSql := strSql + ' ( ';
  strSql := strSql + ' AUTOINCREM, ';
  strSql := strSql + ' DMP_SEQDMP, ';
  strSql := strSql + ' DMP_CODEXP ';
  strSql := strSql + ' ) ';
  strSql := strSql + ' VALUES ';
  strSql := strSql + ' ( ';
  strSql := strSql + ' :AUTOINCREM, ';
  strSql := strSql + ' :SEQDMP, ';
  strSql := strSql + ' :CODEXP ';
  strSql := strSql + ' ) ;' ;
  result := strSql ;
end;

class function TDemonstracaoMutacaoPatrimonioLiquidoMovimentacao.fGetSqlInsertDTDMPL: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO DTDMPL ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' AUTOINCREM, ' ;
  strSql := strSql + ' DMP_SEQDMP, ' ;
  strSql := strSql + ' DMP_CREDEB, ' ;
  strSql := strSql + ' DMP_CODCON ' ;
  strSql := strSql + ' ) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' :AUTOINCREM, ' ;
  strSql := strSql + ' :SEQDMP, ' ;
  strSql := strSql + ' :CREDEB, ' ;
  strSql := strSql + ' :CODCON ' ;
  strSql := strSql + ' ) ; ' ;
  result := strSql ;
end;

class function TDemonstracaoMutacaoPatrimonioLiquidoMovimentacao.fGetSqlInsertMVDMPL: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO MVDMPL ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' AUTOINCREM, ' ;
  strSql := strSql + ' DMP_EXERCI, ' ;
  strSql := strSql + ' DMP_CONTIT, ' ;
  strSql := strSql + ' DMP_CODMOV, ' ;
  strSql := strSql + ' DMP_HISPAD, ' ;
  strSql := strSql + ' DMP_CODEMP ' ;
  strSql := strSql + ' ) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' :AUTOINCREM, ' ;
  strSql := strSql + ' :EXERCI, ' ;
  strSql := strSql + ' :CONTIT, ' ;
  strSql := strSql + ' :CODMOV, ' ;
  strSql := strSql + ' :HISPAD, ' ;
  strSql := strSql + ' :CODEMP ' ;
  strSql := strSql + ' ) ; ' ;
  result := strSql ;
end;

class function TDemonstracaoMutacaoPatrimonioLiquidoMovimentacao.Gravar(
  const AExercicio: integer; const cdsMovimentacao, cdsContasCre, cdsContasDeb,
  cdsNotas: TUniClientDataSet; const ModoInsert: Boolean; const ACodEmp: String): boolean;
var
  qryExec : TUniQuery ;
begin
  fStartTransaction;
  try
    qryExec := fCriaQuery ;
    try
      if not ModoInsert then ///alteração
      begin
        qryExec.Close ;
        qryExec.SQL.Clear ;
        qryExec.SQL.Add(fGetSqlDeleteMVDMPL) ;
        qryExec.ParamByName('EXERCI').AsInteger := AExercicio  ;
        qryExec.ParamByName('CODEMP').AsString := ACodEmp  ;
        qryExec.ExecSQL ;
      end;

      cdsMovimentacao.DisableControls;
      cdsContasCre.DisableControls;
      cdsContasDeb.DisableControls;
      cdsNotas.DisableControls;
      cdsContasCre.IndexName := 'IndiceGrava' ;
      cdsContasDeb.IndexName := 'IndiceGrava' ;
      try
        cdsMovimentacao.First ;
        while not cdsMovimentacao.Eof do
        begin
          qryExec.Close ;
          qryExec.SQL.Clear ;
          qryExec.SQL.Add(fGetSqlInsertMVDMPL);
          qryExec.ParamByName('AUTOINCREM').AsString := cdsMovimentacao.FieldByName('AUTOINCREM').AsString  ;
          qryExec.ParamByName('EXERCI').AsInteger := cdsMovimentacao.FieldByName('DMP_EXERCI').AsInteger  ;
          qryExec.ParamByName('CODEMP').AsString := cdsMovimentacao.FieldByName('DMP_CODEMP').AsString  ;
          qryExec.ParamByName('CONTIT').AsInteger :=  cdsMovimentacao.FieldByName('DMP_CONTIT').AsInteger  ;
          qryExec.ParamByName('CODMOV').AsInteger := cdsMovimentacao.FieldByName('DMP_CODMOV').AsInteger  ;
          if cdsMovimentacao.FieldByName('DMP_HISPAD').AsInteger = 0 then
          begin
            qryExec.ParamByName('HISPAD').Clear ;
          end
          else
          begin
            qryExec.ParamByName('HISPAD').AsInteger := cdsMovimentacao.FieldByName('DMP_HISPAD').AsInteger  ;
          end;
          qryExec.ExecSQL ;

          qryExec.Close ;
          qryExec.SQL.Clear ;
          qryExec.SQL.Add(fGetSqlInsertDTDMPL) ;
          ///contas credito
          if cdsContasCre.FindKey([cdsMovimentacao.FieldByName('AUTOINCREM').AsString]) then
          begin
            while (cdsContasCre.FieldByName('DMP_SEQDMP').AsString = cdsMovimentacao.FieldByName('AUTOINCREM').AsString)
                   and (not cdsContasCre.Eof) do
            begin
              qryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DTDMPL',Vs_strCodEmp) ;
              qryExec.ParamByName('SEQDMP').AsString := cdsContasCre.FieldByName('DMP_SEQDMP').AsString ;
              qryExec.ParamByName('CREDEB').AsString := cdsContasCre.FieldByName('DMP_CREDEB').AsString ;
              qryExec.ParamByName('CODCON').AsString := cdsContasCre.FieldByName('DMP_CODCON').AsString ;
              qryExec.ExecSQL ;
              cdsContasCre.Next ;
            end;
          end;

          ///contas debito
          if cdsContasDeb.FindKey([cdsMovimentacao.FieldByName('AUTOINCREM').AsString]) then
          begin
            while (cdsContasDeb.FieldByName('DMP_SEQDMP').AsString = cdsMovimentacao.FieldByName('AUTOINCREM').AsString)
                   and (not cdsContasDeb.Eof) do
            begin
              qryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DTDMPL',Vs_strCodEmp) ;
              qryExec.ParamByName('SEQDMP').AsString := cdsContasDeb.FieldByName('DMP_SEQDMP').AsString ;
              qryExec.ParamByName('CREDEB').AsString := cdsContasDeb.FieldByName('DMP_CREDEB').AsString ;
              qryExec.ParamByName('CODCON').AsString := cdsContasDeb.FieldByName('DMP_CODCON').AsString ;
              qryExec.ExecSQL ;
              cdsContasDeb.Next ;
            end;
          end;

          qryExec.Close ;
          qryExec.SQL.Clear ;
          qryExec.SQL.Add(fGetSqlInsertDT2DMP) ;
          ///notas
          if cdsNotas.FindKey([cdsMovimentacao.FieldByName('AUTOINCREM').AsString]) then
          begin
            while (cdsNotas.FieldByName('DMP_SEQDMP').AsString = cdsMovimentacao.FieldByName('AUTOINCREM').AsString)
                   and (not cdsNotas.Eof) do
            begin
              qryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DT2DMP',Vs_strCodEmp) ;
              qryExec.ParamByName('SEQDMP').AsString := cdsNotas.FieldByName('DMP_SEQDMP').AsString ;
              qryExec.ParamByName('CODEXP').AsString := cdsNotas.FieldByName('DMP_CODEXP').AsString ;
              qryExec.ExecSQL ;
              cdsNotas.Next ;
            end;
          end;

          cdsMovimentacao.Next ;
        end;

      finally
        cdsContasCre.IndexName := 'IndiceSincroniza' ;
        cdsContasDeb.IndexName := 'IndiceSincroniza' ;
        cdsMovimentacao.EnableControls;
        cdsContasCre.EnableControls;
        cdsContasDeb.EnableControls;
        cdsNotas.EnableControls;
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

class procedure TDemonstracaoMutacaoPatrimonioLiquidoMovimentacao.IncluirDe(
  const AExercicio: integer; const ACodEmp: String; var qryMovimentacao: TUniquery; var cdsConCre,
  cdsConDeb, cdsNotas: TUniClientDataSet);
var
  qryConCre : TUniquery ;
  qryConDeb : TUniquery ;
  qryNotas : TUniquery ;
begin
  qryConCre := fCriaQuery() ;
  qryConDeb := fCriaQuery() ;
  qryNotas := fCriaQuery() ;
  try
    qryMovimentacao.Close ;
    qryMovimentacao.SQL.Clear ;
    qryMovimentacao.SQL.Add(' SELECT ') ;
    qryMovimentacao.SQL.Add('  MVDMPL.AUTOINCREM,') ;
    qryMovimentacao.SQL.Add('  MVDMPL.DMP_EXERCI,') ;
    qryMovimentacao.SQL.Add('  MVDMPL.DMP_CODEMP,') ;
    qryMovimentacao.SQL.Add('  MVDMPL.DMP_CONTIT,') ;
    qryMovimentacao.SQL.Add('  MVDMPL.DMP_CODMOV,') ;
    qryMovimentacao.SQL.Add('  HISTMV.HST_DESCRI,') ;
    qryMovimentacao.SQL.Add('  MVDMPL.DMP_HISPAD,') ;
    qryMovimentacao.SQL.Add('  HISPAD.PAD_DESCRI ') ;
    qryMovimentacao.SQL.Add(' FROM MVDMPL ') ;
    qryMovimentacao.SQL.Add('  INNER JOIN HISTMV ON MVDMPL.DMP_CODMOV = HISTMV.HST_CODIGO ') ;
    qryMovimentacao.SQL.Add('  LEFT JOIN CADEMP ON MVDMPL.DMP_CODEMP = CADEMP.EMP_CODEMP ' );
    qryMovimentacao.SQL.Add('  LEFT  JOIN HISPAD ON MVDMPL.DMP_HISPAD = HISPAD.PAD_CODIGO ') ;
    if fCfgHisTpl then
      qryMovimentacao.SQL.Add('  AND HISPAD.PAD_TPLACO = CADEMP.EMP_TPLACO ')
    else
      qryMovimentacao.SQL.Add('  AND IFNULL(HISPAD.PAD_TPLACO, "") = "" ');

    qryMovimentacao.SQL.Add(' WHERE MVDMPL.DMP_EXERCI = :EXERCI AND COALESCE(MVDMPL.DMP_CODEMP, "") = :CODEMP ') ;
    qryMovimentacao.SQL.Add(' ORDER BY MVDMPL.AUTOINCREM ') ;
    qryMovimentacao.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryMovimentacao.ParamByName('CODEMP').AsString := ACodEmp ;
    qryMovimentacao.Open ;
    qryMovimentacao.First ;

    /////Conta contabil
    ///  credito
    qryConCre.Close ;
    qryConCre.SQL.Clear ;
    qryConCre.SQL.Add(' SELECT ') ;
    qryConCre.SQL.Add('   DMP_SEQDMP, ') ;
    qryConCre.SQL.Add('   DMP_CREDEB, ') ;
    qryConCre.SQL.Add('   DMP_CODCON ') ;
    qryConCre.SQL.Add(' FROM DTDMPL ') ;
    qryConCre.SQL.Add(' WHERE DMP_CREDEB = :CREDEB AND DMP_SEQDMP IN (SELECT AUTOINCREM FROM MVDMPL WHERE DMP_EXERCI = :EXERCI AND COALESCE(DMP_CODEMP, "") = :CODEMP ) ') ;
    qryConCre.SQL.Add(' ORDER BY AUTOINCREM ') ;
    qryConCre.ParamByName('CREDEB').AsString := 'C' ;
    qryConCre.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryConCre.ParamByName('CODEMP').AsString := ACodEmp ;
    qryConCre.Open ;

    cdsConCre := fCriaClientDatset(qryConCre);
    cdsConCre.Open;
    cdsConCre.IndexFieldNames := 'DMP_SEQDMP' ;

    ///  debito
    qryConDeb.Close ;
    qryConDeb.SQL.Clear ;
    qryConDeb.SQL.Add(' SELECT ') ;
    qryConDeb.SQL.Add('   DMP_SEQDMP, ') ;
    qryConDeb.SQL.Add('   DMP_CREDEB, ') ;
    qryConDeb.SQL.Add('   DMP_CODCON ') ;
    qryConDeb.SQL.Add(' FROM DTDMPL ') ;
    qryConDeb.SQL.Add(' WHERE DMP_CREDEB = :CREDEB AND DMP_SEQDMP IN (SELECT AUTOINCREM FROM MVDMPL WHERE DMP_EXERCI = :EXERCI AND COALESCE(DMP_CODEMP, "") = :CODEMP ) ') ;
    qryConDeb.SQL.Add(' ORDER BY AUTOINCREM ') ;
    qryConDeb.ParamByName('CREDEB').AsString := 'D' ;
    qryConDeb.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryConDeb.ParamByName('CODEMP').AsString := ACodEmp ;
    qryConDeb.Open ;

    cdsConDeb := fCriaClientDatset(qryConDeb);
    cdsConDeb.Open;
    cdsConDeb.IndexFieldNames := 'DMP_SEQDMP' ;

    /////Notas Explicativas
    qryNotas.Close ;
    qryNotas.SQL.Clear ;
    qryNotas.SQL.Add(' SELECT ') ;
    qryNotas.SQL.Add('   DT2DMP.DMP_SEQDMP, ') ;
    qryNotas.SQL.Add('   DT2DMP.DMP_CODEXP, ') ;
    qryNotas.SQL.Add('   NTEXPL.EXP_NOTEXP ') ;
    qryNotas.SQL.Add(' FROM DT2DMP ') ;
    qryNotas.SQL.Add('   INNER JOIN NTEXPL ON DT2DMP.DMP_CODEXP = NTEXPL.EXP_CODIGO ') ;
    qryNotas.SQL.Add(' WHERE DT2DMP.DMP_SEQDMP IN (SELECT AUTOINCREM FROM MVDMPL WHERE DMP_EXERCI = :EXERCI AND COALESCE(DMP_CODEMP, "") = :CODEMP) ') ;
    qryNotas.SQL.Add(' ORDER BY DT2DMP.AUTOINCREM ') ;
    qryNotas.ParamByName('EXERCI').AsInteger := AExercicio ;
    qryNotas.ParamByName('CODEMP').AsString := ACodEmp ;
    qryNotas.Open ;

    cdsNotas := fCriaClientDatset(qryNotas);
    cdsNotas.Open;
    cdsNotas.IndexFieldNames := 'DMP_SEQDMP' ;

  finally
    FreeAndNil(qryConCre) ;
    FreeAndNil(qryConDeb) ;
    FreeAndNil(qryNotas) ;
  end;
end;

end.
