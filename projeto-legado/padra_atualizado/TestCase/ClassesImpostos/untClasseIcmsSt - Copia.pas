unit untClasseIcmsSt;

interface

uses
  Faturamento.Impostos.Interfaces.IcmsSt,
  Faturamento.Impostos.Tipos.IcmsSt,
  untFatCalcularImpostosService,
  untParametrosResultadoIcms, untParametrosComparacaoIcms,
  untParametrosResultadoST, untParametrosComparacaoST,
  untAbstractConsulta, untIConsulta, untFatCalcularImpostos, untFatRegrasImpostos,
  untAbstractGerarTeste, Uni, untIGerarTeste, untICasosTestesLog, untCasosTestesLog,
  untFuncoes, Shared.Functions.Configuracoes, Shared.Functions.Funcoes.Faturamento,
  Forms, untCasosTestesLogImpl, Faturamento.Impostos.Calculos.TesteUnitarioLog,
  System.SysUtils, Vcl.Dialogs, Shared.Functions.Constantes, Shared.Functions.Types,
  Faturamento.Impostos.Interfaces.Model,
  System.StrUtils, Faturamento.Impostos.Tipos.Model, System.Math,
  System.Types, Shared.Functions.FloatUtils, UniClientDataSet,
  untTypes,
  Faturamento.Impostos.Interfaces.Icms,
  Faturamento.Impostos.Interfaces.ST,
  Shared.Functions.Core,
  Faturamento.Impostos.Interfaces.IcmsOrgaoPublico,
  untParametrosComparacaoIcmsOrgaoPublico,
  Faturamento.Impostos.Interfaces.STCustoAquisicao,
  untParametrosComparacaoStCustoAquisicao;

type
  TConsultaIcms = class(TAbstractConsulta)
  public
    Class function New : IConsulta;
    function fRetornarSQLIcms : String; override;
  private
    function RetornarColunasSQL(const ADoctosConfirmacao: boolean) : String;
    function RetornarTabelasSQL(const ADoctosConfirmacao: boolean): string;
    function RetornarFiltrosSQL: string;
    function AjustaTabelasDocumentoConfirmacao(const ASQLTabelas: string): string;

    function RetornarColunaAUX_TPOPER(
      const ADoctosCOnfirmacao: boolean): string;

    function RetornarColunaAUX_CODATI(
      const ADoctosCOnfirmacao: boolean): string;
    function RetonarColunaValidacaoDentroDoEstado: string;
    function RetornarColunasCustoAquisicao(const ANomedaColuna: string): string;
  end;

type
  TGerarTesteIcms = class(TAbstractGerarTeste)
  private
    FResultadoServicosClasseIcmsSt: IResultadoServicosClasseIcmsSt;
    FQuantidadeRegistro: Integer;
    FQtdeRegistrosIcmsProcessados: integer;
    FQtdeRegistrosStProcessados: integer;
    FQtdeRegistrosIcmsOrgaoPublicoProcessados: integer;
    FQtdeRegistrosStCustoAquisicaoProcessados: integer;
    FQtdeRegistrosIcmsAcerto: integer;
    FQtdeRegistrosStAcerto: integer;
    FQtdeRegistrosIcmsOrgaoPublicoAcerto: integer;
    FQtdeRegistrosStCustoAquisicaoAcerto: integer;
    FQtdeRegistrosIcmsErro: integer;
    FQtdeRegistrosStErro: integer;
    FQtdeRegistrosIcmsOrgaoPublicoErro: integer;
    FQtdeRegistrosStCustoAquisicaoErro: integer;
    FQtdeRegistrosStDuplicados: Integer;
    FQtdeRegistrosIcmsDuplicados: Integer;
    FQtdeRegistrosIcmsOrgaoPublicoDuplicados: Integer;
    FQtdeRegistrosStCustoAquisicaoDuplicados: Integer;
    FQtdeRegistrosIcmsIgnorados: integer;
    FQtdeRegistrosStIgnorados: integer;
    FQtdeRegistrosIcmsOrgaoPublicoIgnorados: integer;
    FCfg_CalcularIpiStParaDocumentosDeFF: boolean;
    FQtdeRegistrosStCustoAquisicaoIgnorados: integer;

    Function RetornarOpcoesDeItemNotaEspiritoSanto(AClassificacaoFiscal : String) : TOpcItensNFespTinta;
    Procedure pTesteUnitarioLog(AResultadoServicosClasseIcmsSt: IResultadoServicosClasseIcmsSt; ADados: TUniClientDataSet);
//    function CalculaValorIcms(AValue: Double): Double;

    function AdicionarLogEspeciesIgnoradasIcms(
      const ADados: TUniClientDataSet;
      const AResultadoComparacao: TResultadoComparacao;
      const AResultadoCalculoIcms: IResultadoCalculoIcms): Boolean;


    function AdicionarLogEspeciesIgnoradasSt(
      const ADados: TUniClientDataSet;
      const AResultadoComparacao: TResultadoComparacao;
      const AResultadoCalculoST: IResultadoCalculoST): Boolean;


    function AdicionarLogEspeciesIgnoradasIcmsOrgaoPublico(
      const ADados: TUniClientDataSet;
      const AResultadoComparacao: TResultadoComparacao;
      const AResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico): Boolean;

    function AdicionarLogEspeciesIgnoradasStCustoAquisicao(
      const ADados: TUniClientDataSet;
      const AResultadoComparacao: TResultadoComparacao;
      const AResultadoCalculoSTCustoAquisicao: IResultadoCalculoSTCustoAquisicao): Boolean;


    function ValidarSeDeveAdicionarLogEspeciesIgnoradas(const ADados: TUniClientDataSet): Boolean;
    function ZerarPercentualDaBaseDeIcms(const ADados: TUniClientDataSet; const AResultadoCalculoIcms: IResultadoCalculoIcms): Boolean;
    function EmissaoPedidoBrinde(const ADados: TUniClientDataSet): Boolean;
    function PossuiBrindeServico(const AOpcaoDeDocumento: String): Boolean;
    function PossuiBrindeProduto(const ATipoOperacaoPedidoVenda: String): Boolean;
    function DiferencaEhNoPercentualDaBaseDeIcms(const ADados: TUniClientDataSet; const AResultadoCalculoIcms: IResultadoCalculoIcms): Boolean;
    function ValidarSeDeveAdicionarLogPercentualDaBaseDeIcms(const ADados: TUniClientDataSet; const AResultadoCalculoIcms: IResultadoCalculoIcms): Boolean;

    function PodeAdicionarLogIgnoradasIcms(const ADados: TUniClientDataSet; const AResultadoCalculoIcms: IResultadoCalculoIcms): Boolean;

    function PodeAdicionarLogIgnoradasSt(const ADados: TUniClientDataSet; const AResultadoCalculoST: IResultadoCalculoST): Boolean;

    function PodeAdicionarLogIgnoradasStCustoAquisicao(const ADados: TUniClientDataSet): Boolean;

    function ValidarSeDeveAdicionarLogRICMPRIcms(const ADados: TUniClientDataSet; const AResultadoCalculoIcms: IResultadoCalculoIcms): Boolean;
    function ValidarSeDeveAdicionarLogDiferencaVendaNormalPermitindoEditarBasesNosDadosFiscais(const ADados: TUniClientDataSet; const AResultadoCalculoIcms: IResultadoCalculoIcms): boolean;
    function ValidarSeDeveAdicionarLogDiferencaBaseValorIcmsComIpiVersao368(const ADados: TUniClientDataSet; const AResultadoCalculoIcms: IResultadoCalculoIcms): boolean;
    function CompararBaseEValorIcmsConformeCalculoNaVersão368(const ADados: TUniClientDataSet; const AResultadoCalculoIcms: IResultadoCalculoIcms): boolean;

    function RetornarResultadoComparacaoIcms(Const ADados : TUniClientDataSet): TResultadoComparacao;

    function RetornarResultadoComparacaoSt(Const ADados : TUniClientDataSet): TResultadoComparacao;

    function RetornarResultadoComparacaoIcmsOrgaoPublico(Const ADados : TUniClientDataSet): TResultadoComparacao;

    function RetornarResultadoComparacaoStCustoAquisicao(Const ADados : TUniClientDataSet): TResultadoComparacao;

    function ValidarSeDeveAdicionarLogTintadeMaquina(const ADados: TUniClientDataSet): Boolean;

    function ValidarSeDeveAdicionarLogRICMPRIST(const ADados: TUniClientDataSet; const AResultadoCalculoST: IResultadoCalculoST): Boolean;

    function ValidarSeDeveAdicionarLogIND_PD_F3_CAIXA(const ADados: TUniClientDataSet): Boolean;

    procedure ZerarRegistrosDoProcessamento;
    procedure TotalizarRegistrosProcessamentoIcms;
    procedure TotalizarRegistrosProcessamentoSt;
    procedure TotalizarRegistrosProcessamentoIcmsOrgaoPublico;
    procedure TotalizarRegistrosProcessamentoStCustoAquisicao;
    procedure SetarTotaisDoProcessamentoDoIcms;
    procedure TotalizarRegistrosProcessamentoGeral;
    procedure SetarTotaisDoProcessamentoDoSt;
    procedure SetarTotaisDoProcessamentoDoStCustoAquisicao;
    procedure SetarTotaisDoProcessamentoFinal;
    procedure InicializarVariaveisRegistros;
    function CompararCodFis(const ACodFisCalculado,
      ACodFisDoCliente: string; const AClienteOrgaoPublico: boolean): boolean;
    function ValidarClienteIndustria(const ATipoDeOperacao, AClienteIndustriaCadastro: string): boolean;
    procedure SetarTotaisDoProcessamentoDoIcmsOrgaoPublico;

    procedure CasosTestesLogIcms(ACasosTestesLogIcms: ICasosTestesLog; AResultadoComparacaoIcms: TResultadoComparacao; ADados: TUniClientDataSet);
    procedure CasosTestesLogSt(ACasosTestesLogSt: ICasosTestesLog; AResultadoComparacaoSt: TResultadoComparacao; ADados: TUniClientDataSet);
    procedure CasosTestesLogIcmsOrgaoPublico(ACasosTestesLogIcmsOrgaoPublico: ICasosTestesLog; AResultadoComparacaoIcmsOrgaoPublico: TResultadoComparacao; ADados: TUniClientDataSet);
    procedure CasosTestesLogStCustoAquisicao(ACasosTestesLogStCustoAquisicao: ICasosTestesLog; AResultadoComparacaoStCustoAquisicao: TResultadoComparacao; ADados: TUniClientDataSet);

    function ResultadoComparacaoIcms(const ADados: TUniClientDataSet): TResultadoComparacao;
    function ResultadoComparacaoSt(const ADados: TUniClientDataSet): TResultadoComparacao;
    function ResultadoComparacaoIcmsOrgaoPublico(const ADados: TUniClientDataSet): TResultadoComparacao;
    function ResultadoComparacaoStCustoAquisicao(const ADados: TUniClientDataSet): TResultadoComparacao;
    function ValidarCodFisOrgaoPublico(const AClienteOrgaoPublico: boolean;
      const ACodFisDoCliente: String): boolean;
    function ValidarSeDeveAdicionarLogFF(
      const ADados: TUniClientDataSet): boolean;
    function ForcarErroComparacaoQuandoFFeNaoCalculaSt(
      const ADados: TUniClientDataSet): boolean;
    function ValidarRegrasCalculoSTParaFF(
      const ADados: TUniClientDataSet): boolean;
    function RetornarEstadoCliente(const AEstadoClienteConsumidor,
      AEstadoCliente: String): String;
    function PodeAdicionarLogIgnoradasIcmsOrgaoPublico(
      const ADados: TUniClientDataSet): boolean;
    function CompararResultadosValorDoIcmsOperacoesProprias(
      const AValorDoIcmsOperacoesPropriasCalculado,
      AValorDoIcmsOperacoesPropriasCliente: double): boolean;
    function CompararResultadosValorDoIcmsOperacoesPropriasVersao368(
      const AValorDoIcmsOperacoesPropriasCalculado,
      AValorDoIcmsOperacoesPropriasCliente: double): boolean;
    function RetornarValorCalculadoDoCustoDeAquisicao(Const ADados : TUniClientDataSet): double;
    function CalcularValorCustoDeAquisicao(const ADados: TUniClientDataSet;
      const ATotalGeralDoItem: Double): double;
    function RetornarIvaCustoDeAquisicao(
      const ADados: TUniClientDataSet): Double;
    function RetornarTotalGeralDoItemDoCustoDeAquisicao(
      const ADados: TUniClientDataSet): double;
  public
    Class function New : IGerarTeste;

    Constructor Create;
    Destructor Destroy; override;

    function fGerarTesteIcmsSt(const ADados: OleVariant; Const AOpcao : String) : Boolean; override;
    function CompararResultadoIcms(Const AResultadoCalculoIcms  : IResultadoCalculoIcms; Const ADados : TUniClientDataSet) : Boolean;
    function CompararResultadoST(const AResultadoCalculoST: IResultadoCalculoSt; const ADados: TUniClientDataSet): Boolean;
    function CompararResultadoIcmsOrgaoPublico(Const AResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico; Const ADados : TUniClientDataSet) : Boolean;
    function CompararResultadoSTCustoAquisicao(const AResultadoCalculoSTCustoAquisicao: IResultadoCalculoStCustoAquisicao; const ADados: TUniClientDataSet): Boolean;

  end;

implementation

uses
  untModulo;

{ TConsultaIcms }

function TConsultaIcms.RetornarColunaAUX_CODATI(
  const ADoctosCOnfirmacao: boolean): string;
begin
  result := ' "" AS AUX_CODATI, ';

  if not (objCore.fCampoExiste('AUXMOV', 'AUX_CODATI')) then
    Exit;

  if (ADoctosCOnfirmacao) then
    Exit;

  result := ' A.AUX_CODATI, ';
end;

function TConsultaIcms.RetornarColunaAUX_TPOPER(const ADoctosCOnfirmacao: boolean): string;
begin
  result := ' "" AS AUX_TPOPER, ';

  if not (objCore.fCampoExiste('AUXMOV', 'AUX_TPOPER')) then
    Exit;

  if (ADoctosCOnfirmacao) then
    Exit;

  result := ' A.AUX_TPOPER, ';
end;

function TConsultaIcms.RetonarColunaValidacaoDentroDoEstado: string;
begin
  result := ' ((D.DET_ESTADO = CADCID.CID_ESTADO) OR (AUX_VENPRE = "S")), ';
end;

function TConsultaIcms.RetornarColunasCustoAquisicao(const ANomedaColuna: string): string;
begin
  result :=  '  IF(  '+
                   RetonarColunaValidacaoDentroDoEstado +
             '    (SELECT  '+
             '      SUM(  '+
             '        IF(  '+
             '          RIGHT(DET_CODFIS, 2) IN ("10", "30", "60", "70"),  '+
             '          (  '+
                            ANomedaColuna +
             '          ) / 100,  '+
             '          0  '+
             '        )  '+
             '      )  '+
             '    FROM  '+
             '      MOVDET DT  '+
             '      LEFT JOIN MOVTRI T  '+
             '        ON DT.AUTOINCREM = T.DET_SEQGER  '+
             '    WHERE DT.DET_NUMDOC = D.DET_NUMDOC   '+
             '      AND DT.DET_ESPDOC = D.DET_ESPDOC   '+
             '      AND DT.DET_CODEMP = D.DET_CODEMP   '+
             '      AND DT.DET_CODCLI = D.DET_CODCLI), '+
             '    0  '+
             '  ) ';
end;

function TConsultaIcms.RetornarColunasSQL(const ADoctosConfirmacao: boolean): String;
begin

  Result :=
    'SELECT '+
    ' G.GER_CONSUM, '+
    ' G.GER_RET_SP, '+
    ' D.DET_NUMDOC, '+
    ' D.DET_ESPDOC, '+
    ' D.DET_CODCLI, '+
    ' D.DET_CODITE, '+
    ' D.DET_CODEMP, '+
    ' D.DET_DTAENT, '+
    ' A.AUX_OPCDOC, '+
    ' D.DET_CODFIS, '+
    ' D.DET_ESTADO, '+
    ' D.DET_ENTFUT, '+
    ' D.DET_DESACE, '+
    ' D.DET_IDEPRO, '+
    ' DET_TOTITE, '+
    ' DET_TOTFRE, '+
    ' DET_DESESP, '+
    ' D.DET_CODFOR, '+
    ' E.AUTOINCREM AS SEQUENCIAL_ENDERECO, '+
    ' D.DET_CLAFIS, '+
    ' A.AUX_VENPRE, '+
    RetornarColunaAUX_TPOPER(ADoctosConfirmacao) +
    ' C.ITE_IMPDIR, '+
    ' X.FGO_EMP_TE, '+
    ' FATGOR.FGO_TIPOPE, '+
    ' D.DET_UNITAR,  '+
    ' D.DET_QTDITE,  '+
    ' T.DET_VALDIF,  '+
    ' T.DET_PEBAST,  '+
    ' D.DET_ALQICM,  '+
    ' D.DET_BASICM,  '+
    ' D.DET_VALICM,  '+
    ' T.DET_RICMPR,  '+
    ' D.DET_PERRED,  '+
    ' D.DET_TIP_FC,  '+
    ' D.DET_VALRET,  '+
    ' D.DET_BASRET, '+
    ' D.DET_ALQRET, '+
    ' D.DET_PERBAS,  '+
    ' D.DET_ESPDEV,  '+
    ' D.DET_VALIPI,  '+
    ' I.ITE_PRECUS,  '+
    ' I.ITE_PREULT,  '+
    ' I.ITE_IMPULT,  '+
    ' FATGOR.FGO_TIPPED,  '+
    ' T.DET_PFCPST,  '+
    ' T.DET_VFCPST,  '+
    ' T.DET_VALIVA,  '+
    ' L.CLI_INDCOM,  '+
    ' L.CLI_INDUST,  '+
    ' G.GER_ESTCON,  '+
    ' G.GER_IESCON,  '+
    ' G.GER_CGCCPF,  '+
    RetornarColunaAUX_CODATI(ADoctosConfirmacao) +
    ' L.CLI_CALICM,  '+
    ' L.CLI_ORGPUB,  '+
    ' L.CLI_ZONFRA,  '+
    ' T.DET_ICMORG,  '+
    ' G.GER_BASORG,  '+
    ' T.DET_EMPORI,  '+
    ' D.DET_NUM_PD,  '+
    ' T.DET_BARTSP,  '+
    ' T.DET_VLRTSP,  '+
    ' T.DET_ICOPPR,  '+
    ' D.DET_PRCTIN,  '+
    ' D.DET_IND_PD,  '+
    ' IF(T.DET_ICMORG > 0, ROUND((D.DET_TOTITE * (IF(((D.DET_PERBAS = 0) AND (T.DET_ICMORG > 0) AND (G.GER_BASORG > 0)), 100, D.DET_PERBAS))) / 100, 2), 0) AS BASORG_ITEM, ' +
    '  IF(  '+
    '    D.DET_ESTADO = CADCID.CID_ESTADO,  '+
    '    IF(  '+
    '      RIGHT(DET_CODFIS, 2) IN ("10", "30", "60", "70"),  '+
    '      (  '+
    '        (  '+
    '          (  '+
    '            (D.DET_TOTITE - D.DET_DESESP) * (  '+
    '              (T.DET_VALIVA / 100) + IF((T.DET_VALIVA / 100) > 0, 1, IF(GER_CONSUM = "S", 1 ,0))  '+
    '            )  '+
    '          ) * T.DET_PEBAST  '+
    '        ) / 100  '+
    '      ),  '+
    '      0  '+
    '    ),  '+
    '    0  '+
    '  ) AS ITE_RET_SP,  '+
      // RetornarColunasCustoAquisicao('DT.DET_TOTITE') + ' AS TOTITE_CUSTOAQUISICAO, ' +
      // RetornarColunasCustoAquisicao('DT.DET_DESESP') + ' AS DESESP_CUSTOAQUISICAO, ' +
       RetornarColunasCustoAquisicao('(D.DET_TOTITE - D.DET_DESESP) * ((T.DET_VALIVA / 100) + IF((T.DET_VALIVA / 100) > 0, 1, IF(GER_CONSUM = "S",1,0))) * T.DET_PEBAST') + ' AS TOTITE_CUSTOAQUISICAO ';
      // RetornarColunasCustoAquisicao('DT.DET_TOTFRE') + ' AS TOTFRE_CUSTOAQUISICAO, ' +
      // RetornarColunasCustoAquisicao('T.DET_VALIVA')  + ' AS VALIVA_CUSTOAQUISICAO, ' +
      // RetornarColunasCustoAquisicao('T.DET_PEBAST')  + ' AS PEBAST_CUSTOAQUISICAO, ' +
     //  RetornarColunasCustoAquisicao('DT.DET_DESACE') + ' AS DESACE_CUSTOAQUISICAO  ';

  If Not ADoctosConfirmacao Then
    Exit;

  Result := AnsiReplaceStr(Result, 'X.FGO_EMP_TE', '"" AS FGO_EMP_TE');
  Result := AnsiReplaceStr(Result, 'FATGOR.FGO_TIPOPE', '"V" AS FGO_TIPOPE');
  Result := AjustaTabelasDocumentoConfirmacao(Result);
end;


function TConsultaIcms.RetornarFiltrosSQL: string;
begin
  Result :=
    '  WHERE G.GER_CODEMP = :CODEMP       ' +
    '    AND G.GER_ORIDOC <> "D"          ' +
    '    AND G.GER_DTAENT BETWEEN :DTAINI ' +
    '                         AND :DTAFIM AND DET_NUMDOC = "000000238773" AND DET_ESPDOC = "IF" AND DET_CODEMP = "001" AND DET_CODITE = "77956" AND DET_CODCLI = "00099991" ' ;

end;

function TConsultaIcms.RetornarTabelasSQL(
  const ADoctosConfirmacao: boolean): string;
begin
  Result := ' FROM MOVGER G '+
            ' INNER JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM '+
            ' INNER JOIN CADITE C ON C.ITE_CODITE = D.DET_CODITE '+
            ' INNER JOIN ITEGER I ON I.ITE_CODITE = D.DET_CODITE '+
            '                    AND I.ITE_CODEMP = D.DET_CODEMP '+
            ' INNER JOIN CADCLI L ON L.CLI_CODCLI = D.DET_CODCLI '+
            ' LEFT  JOIN ENTCLI E ON E.ETC_CODCLI = L.CLI_CODCLI '+
            '                    AND E.ETC_SEQIND = (SELECT MIN(T.ETC_SEQIND) '+
            '                                        FROM ENTCLI T '+
            '                                        WHERE T.ETC_CODCLI = L.CLI_CODCLI) '+
            ' LEFT JOIN AUXMOV A ON A.AUX_SEQGER      = D.DET_SEQGER '+
            ' LEFT JOIN FATDOR    ON FATDOR.FDO_NUMDOC = D.DET_NUM_PD '+
            '                    AND FATDOR.FDO_ESPDOC = D.DET_ESP_PD '+
            '                    AND FATDOR.FDO_CODEMP = D.DET_EMP_PD '+
            '                    AND FATDOR.FDO_CODITE = D.DET_CODITE '+
            ' LEFT JOIN FATGOR    ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER '+
            ' LEFT JOIN EXTGOR X  ON X.FGO_SEQFGO      = FATGOR.AUTOINCREM '+
            ' LEFT JOIN MOVTRI T  ON D.AUTOINCREM      = T.DET_SEQGER '+
//            ' LEFT JOIN MOVICD MI ON D.AUTOINCREM      = MI.ICD_SEQGER '+
            ' INNER JOIN CADEMP   ON EMP_CODEMP        = D.DET_CODEMP '+
            ' INNER JOIN CADCID   ON CID_CODCID        = EMP_CODCID ';

  if (not ADoctosConfirmacao) then
    Exit;

  result := AjustaTabelasDocumentoConfirmacao(Result);
end;


function TConsultaIcms.fRetornarSQLIcms: String;
const
  UNION_ALL = ' UNION ALL ';
begin
  result := EmptyStr;
  Result := Result + RetornarColunasSQL(False);
  Result := Result + RetornarTabelasSQL(False);
  Result := Result + RetornarFiltrosSQL;
  Result := Result + UNION_ALL;
  Result := Result + RetornarColunasSQL(True);
  Result := Result + RetornarTabelasSQL(True);
  Result := Result + RetornarFiltrosSQL;
end;

class function TConsultaIcms.New: IConsulta;
begin
  Result := Self.Create;
end;

{ TGerarTesteIcms }

function TConsultaIcms.AjustaTabelasDocumentoConfirmacao(
  const ASQLTabelas: string): string;
begin
  result := ASQLTabelas;
  result := AnsiReplaceStr(result, 'MOVGER', 'NOTGER');
  result := AnsiReplaceStr(result, 'MOVDET', 'NOTDET');
  result := AnsiReplaceStr(result, 'AUXMOV', 'AUXNOT');
  result := AnsiReplaceStr(result, 'MOVTRI', 'NOTTRI');
//  result := AnsiReplaceStr(result, 'MOVICD', 'NOTICD');
end;


function TGerarTesteIcms.AdicionarLogEspeciesIgnoradasIcms(
 const ADados: TUniClientDataSet;
 const AResultadoComparacao: TResultadoComparacao;
 const AResultadoCalculoIcms: IResultadoCalculoIcms): Boolean;
begin
  Result := False;

  If (AResultadoComparacao = rcoTrue) Then
    Exit;

  If Not PodeAdicionarLogIgnoradasIcms(ADados, AResultadoCalculoIcms) Then
    Exit;

  Result := True;
end;

function TGerarTesteIcms.ValidarCodFisOrgaoPublico(const AClienteOrgaoPublico: boolean; const ACodFisDoCliente: String): boolean;
begin
  Result := False;

  if (not AClienteOrgaoPublico) then
    Exit;

  If (RightStr(ACodFisDoCliente, 2) <> '40') then
    Exit;

  Result := True;
end;

function TGerarTesteIcms.CompararCodFis(const ACodFisCalculado, ACodFisDoCliente: string; const AClienteOrgaoPublico: boolean): boolean;
begin
  result := True;

  If (ACodFisCalculado = ACodFisDoCliente) then
    Exit;

  If (RightStr(ACodFisDoCliente, 2) = '41') then
    Exit;

  if (ValidarCodFisOrgaoPublico(AClienteOrgaoPublico, ACodFisDoCliente)) then
    Exit;

  Result := False;
end;

function TGerarTesteIcms.CompararResultadoIcms(Const AResultadoCalculoIcms  : IResultadoCalculoIcms; Const ADados : TUniClientDataSet): Boolean;
begin
  Result := False;

  If Not CompararValores(AResultadoCalculoIcms.AliquotaDoIcms, ADados.FieldByName('DET_ALQICM').AsFloat) Then
  begin
    Exit;
  end;

  If Not CompararValores(AResultadoCalculoIcms.BaseDeCalculoDoIcms, ADados.FieldByName('DET_BASICM').AsFloat) Then
  begin
    Exit;
  end;

  If Not CompararValores(AResultadoCalculoIcms.ValorCalculadoDoIcms, ADados.FieldByName('DET_VALICM').AsFloat)Then
  begin
    Exit;
  end;

  If Not CompararValores(AResultadoCalculoIcms.PercentualDaBaseDeIcms, ADados.FieldByName('DET_PERBAS').AsFloat) Then
  begin
    Exit;
  end;

  If Not CompararValores(AResultadoCalculoIcms.PercentualDeReducaoDaBaseDeIcms, ADados.FieldByName('DET_PERRED').AsFloat) Then
  begin
    Exit;
  end;

  If Not CompararValores(AResultadoCalculoIcms.ValorDaDiferencaDeIcms, ADados.FieldByName('DET_VALDIF').AsFloat) Then
  begin
    Exit;
  end;

  If Not (AResultadoCalculoIcms.ReducaoRICMPR = Empty(ADados.FieldByName('DET_RICMPR').AsString, 'N'))Then
  begin
    Exit;
  end;

  If (FResultadoServicosClasseIcmsSt.CodigoDaSubstituicaoTributariaDoItem <> ADados.FieldByName('DET_CODFIS').AsString) Then
    Exit;

  Result := True;
end;


function TGerarTesteIcms.CompararResultadoIcmsOrgaoPublico(Const AResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico; Const ADados : TUniClientDataSet) : Boolean;
begin
  Result := False;

  If (TFunctionFuncoesFaturamento.DocumentosDeConfirmacaoClienteOrgaoPublicoNaoCalcularIcms(ADados.FieldByName('AUX_OPCDOC').AsString, ADados.FieldByName('CLI_ORGPUB').AsString = 'S', ADados.FieldByName('CLI_CALICM').AsString = 'S')) Then
  Begin
    If Not CompararValores(AResultadoCalculoIcmsOrgaoPublico.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao, ADados.FieldByName('DET_DESESP').AsFloat) Then
      Exit;
  End;

  If Not CompararValores(AResultadoCalculoIcmsOrgaoPublico.ValorDoIcmsDeOrgaoPublicoDoItem, ADados.FieldByName('DET_ICMORG').AsFloat) Then
    Exit;

  If Not CompararValores(AResultadoCalculoIcmsOrgaoPublico.BaseDeIcmsDeOrgaoPublicoDoItem, ADados.FieldByName('BASORG_ITEM').AsFloat) Then
    Exit;

  Result := True;
end;

function TGerarTesteIcms.ValidarRegrasCalculoSTParaFF(Const ADados : TUniClientDataSet): boolean;
begin
  Result := False;

  If (ADados.FieldByName('DET_ESPDOC').AsString <> 'FF') Then
    Exit;

  If (FCfg_CalcularIpiStParaDocumentosDeFF) Then
    Exit;

  If (ADados.FieldByName('DET_BASRET').AsFloat > 0) Then
    Exit;

  Result := True;
end;

function TGerarTesteIcms.RetornarIvaCustoDeAquisicao(Const ADados : TUniClientDataSet): Double;
begin
  result := ADados.FieldByName('VALIVA_CUSTOAQUISICAO').AsFloat;
{  result := ADados.FieldByName('VALIVA_CUSTOAQUISICAO').AsFloat / 100;

  if (result > 0) then
  begin
    result := result + 1;
    Exit;
  end;

  if (ADados.FieldByName('GER_CONSUM').AsString <> 'S') then
    Exit;

  result := result + 1;}
end;

function TGerarTesteIcms.CalcularValorCustoDeAquisicao(Const ADados : TUniClientDataSet; Const ATotalGeralDoItem: Double): double;
begin
  result := (ATotalGeralDoItem * RetornarIvaCustoDeAquisicao(ADados));
  //result := result * ADados.FieldByName('PEBAST_CUSTOAQUISICAO').AsFloat;
  result := result / 100;
end;

function TGerarTesteIcms.RetornarTotalGeralDoItemDoCustoDeAquisicao(Const ADados : TUniClientDataSet): double;
begin
  result := TFunctionFuncoesFaturamento.TotalGeralItem(ADados.FieldByName('GER_CONSUM').AsString = 'S',
                                                       ADados.FieldByName('DESESP_CUSTOAQUISICAO').AsFloat,
                                                       ADados.FieldByName('TOTFRE_CUSTOAQUISICAO').AsFloat,
                                                       ADados.FieldByName('TOTITE_CUSTOAQUISICAO').AsFloat,
                                                       ADados.FieldByName('DESACE_CUSTOAQUISICAO').AsFloat,
                                                       ADados.FieldByName('CLI_ORGPUB').AsString = 'S',
                                                       ADados.FieldByName('CLI_ZONFRA').AsString = 'S',
                                                       Pos(LeftStr(ADados.FieldByName('DET_CLAFIS').AsString, 1),'1_5') > 0,
                                                       ADados.FieldByName('AUX_OPCDOC').AsString,
                                                       True,
                                                       False);
end;

function TGerarTesteIcms.RetornarValorCalculadoDoCustoDeAquisicao(Const ADados : TUniClientDataSet): double;
var
  LTotalGeralDoItem: Double;
begin
  LTotalGeralDoItem := ADados.FieldByName('TOTITE_CUSTOAQUISICAO').AsFloat; // RetornarTotalGeralDoItemDoCustoDeAquisicao(ADados);
  result := CalcularValorCustoDeAquisicao(ADados, LTotalGeralDoItem);
end;

function TGerarTesteIcms.ForcarErroComparacaoQuandoFFeNaoCalculaSt(Const ADados : TUniClientDataSet): boolean;
begin
  result := ValidarRegrasCalculoSTParaFF(ADados);
end;

function TGerarTesteIcms.CompararResultadoST(Const AResultadoCalculoST  : IResultadoCalculoSt; Const ADados : TUniClientDataSet): Boolean;
begin
  Result := False;

  If Not CompararValores(AResultadoCalculoST.BaseDeCalculoDaSubstituicaoTributariaDoItem, ADados.FieldByName('DET_BASRET').AsFloat) Then
  begin
    Exit;
  end;

  If Not CompararValores(AResultadoCalculoST.ValorDaSubstituicaoTributariaDoItem, ADados.FieldByName('DET_VALRET').AsFloat) Then
  begin
    Exit;
  end;

  If Not CompararValores(AResultadoCalculoST.PercentualDoFCPDoItem, ADados.FieldByName('DET_PFCPST').AsFloat)Then
  begin
    Exit;
  end;

  If Not CompararValores(AResultadoCalculoST.ValorDoFCPDoItem, ADados.FieldByName('DET_VFCPST').AsFloat) Then
  begin
    Exit;
  end;

  If Not CompararValores(AResultadoCalculoST.PercentualDaSubstituicaoDaBase, ADados.FieldByName('DET_PEBAST').AsFloat) Then
  begin
    Exit;
  end;

  If Not CompararValores(objFloatUtils.fFormataFloat(RetornarValorCalculadoDoCustoDeAquisicao(ADados),2), ADados.FieldByName('GER_RET_SP').AsFloat,2,'0,02') Then
  begin
    Exit;
  end;

  If Not CompararValores(AResultadoCalculoST.ValorDoIvaMatriz, ADados.FieldByName('DET_VALIVA').AsFloat) Then
  begin
    Exit;
  end;

  If (ForcarErroComparacaoQuandoFFeNaoCalculaSt(ADados)) then
    Exit;

  Result := True;
end;

function TGerarTesteIcms.CompararResultadosValorDoIcmsOperacoesPropriasVersao368(const AValorDoIcmsOperacoesPropriasCalculado,
  AValorDoIcmsOperacoesPropriasCliente: double): boolean;
begin
  Result := True;

  if CompararValores(AValorDoIcmsOperacoesPropriasCalculado, AValorDoIcmsOperacoesPropriasCliente / 100) Then
    Exit;

  Result := False;
end;

function TGerarTesteIcms.CompararResultadosValorDoIcmsOperacoesProprias(const AValorDoIcmsOperacoesPropriasCalculado,
  AValorDoIcmsOperacoesPropriasCliente: double): boolean;
begin
  result := True;

  if CompararValores(AValorDoIcmsOperacoesPropriasCalculado, AValorDoIcmsOperacoesPropriasCliente) Then
    Exit;

  if CompararResultadosValorDoIcmsOperacoesPropriasVersao368(AValorDoIcmsOperacoesPropriasCalculado, AValorDoIcmsOperacoesPropriasCliente) Then
    Exit;

  result := False;
end;


function TGerarTesteIcms.CompararResultadoSTCustoAquisicao(
  const AResultadoCalculoSTCustoAquisicao: IResultadoCalculoStCustoAquisicao;
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := False;

  If Not CompararValores(AResultadoCalculoSTCustoAquisicao.BaseDaSTCustoAquisicao, ADados.FieldByName('DET_BARTSP').AsFloat) Then
  begin
    Exit;
  end;

  If Not CompararValores(AResultadoCalculoSTCustoAquisicao.ValorDaSTCustoAquisicao, ADados.FieldByName('DET_VLRTSP').AsFloat) Then
  begin
    Exit;
  end;

  if Not CompararResultadosValorDoIcmsOperacoesProprias(AResultadoCalculoSTCustoAquisicao.ValorDoIcmsOperacoesProprias, ADados.FieldByName('DET_ICOPPR').AsFloat) then
    Exit;


  If Not CompararValores(AResultadoCalculoSTCustoAquisicao.ValorDoIcmsOperacoesProprias, ADados.FieldByName('DET_ICOPPR').AsFloat) Then
  begin
    Exit;
  end;

  Result := True;
end;

constructor TGerarTesteIcms.Create;
begin

end;

destructor TGerarTesteIcms.Destroy;
begin

  inherited;
end;

function TGerarTesteIcms.DiferencaEhNoPercentualDaBaseDeIcms(const ADados: TUniClientDataSet; const AResultadoCalculoIcms: IResultadoCalculoIcms): Boolean;
begin
  Result := False;

  If not (CompararValores(AResultadoCalculoIcms.AliquotaDoIcms, ADados.FieldByName('DET_ALQICM').AsFloat)) Then
    Exit;

  If not (CompararValores(AResultadoCalculoIcms.BaseDeCalculoDoIcms, ADados.FieldByName('DET_BASICM').AsFloat)) Then
    Exit;

  If not (CompararValores(AResultadoCalculoIcms.ValorCalculadoDoIcms, ADados.FieldByName('DET_VALICM').AsFloat)) Then
    Exit;

  If not (CompararValores(AResultadoCalculoIcms.ValorDaDiferencaDeIcms, ADados.FieldByName('DET_VALDIF').AsFloat)) Then
    Exit;

  If not (CompararValores(AResultadoCalculoIcms.PercentualDeReducaoDaBaseDeIcms, ADados.FieldByName('DET_PERRED').AsFloat)) Then
    Exit;

  If (CompararValores(AResultadoCalculoIcms.PercentualDaBaseDeIcms, ADados.FieldByName('DET_PERBAS').AsFloat))  Then
    Exit;

  Result := True;
end;

function TGerarTesteIcms.EmissaoPedidoBrinde(
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := True;

  If PossuiBrindeServico(ADados.FieldByName('AUX_OPCDOC').AsString) Then
    Exit;

  If PossuiBrindeProduto(ADados.FieldByName('FGO_TIPOPE').AsString) Then
    Exit;

  Result := False;
end;

function TGerarTesteIcms.ValidarClienteIndustria(const ATipoDeOperacao, AClienteIndustriaCadastro: string): boolean;
begin
  result := AClienteIndustriaCadastro = 'S';

  if (not objConfiguracoes.fGetValorConfiguracao('USOREV', varBoolean)) then
    Exit;

  result := (ATipoDeOperacao = INDUSTRIALIZACAO);
end;

procedure TGerarTesteIcms.InicializarVariaveisRegistros;
begin
  FQuantidadeRegistro                       := 0;
  FQtdeRegistrosStDuplicados                := 0;
  FQtdeRegistrosIcmsDuplicados              := 0;
  FQtdeRegistrosIcmsOrgaoPublicoDuplicados  := 0;
  FQtdeRegistrosStCustoAquisicaoDuplicados  := 0;
  FQtdeRegistrosIcmsAcerto                  := 0;
  FQtdeRegistrosStAcerto                    := 0;
  FQtdeRegistrosIcmsOrgaoPublicoAcerto      := 0;
  FQtdeRegistrosStCustoAquisicaoAcerto      := 0;
  FQtdeRegistrosIcmsProcessados             := 0;
  FQtdeRegistrosStProcessados               := 0;
  FQtdeRegistrosIcmsOrgaoPublicoProcessados := 0;
  FQtdeRegistrosStCustoAquisicaoProcessados := 0;
  FQtdeRegistrosIcmsErro                    := 0;
  FQtdeRegistrosStErro                      := 0;
  FQtdeRegistrosIcmsOrgaoPublicoErro        := 0;
  FQtdeRegistrosStCustoAquisicaoErro        := 0;
  FQtdeRegistrosIcmsIgnorados               := 0;
  FQtdeRegistrosStIgnorados                 := 0;
  FQtdeRegistrosIcmsOrgaoPublicoIgnorados   := 0;
  FQtdeRegistrosStCustoAquisicaoIgnorados   := 0;
end;

function TGerarTesteIcms.RetornarEstadoCliente(Const AEstadoClienteConsumidor, AEstadoCliente : String): String;
begin
  Result := AEstadoClienteConsumidor;

  If Not objFloatUtils.fEmptyStr(Result) Then
    Exit;

  Result := AEstadoCliente;
end;

function TGerarTesteIcms.fGerarTesteIcmsSt(const ADados: OleVariant; Const AOpcao : String): Boolean;
Var
  LDados                          : TUniClientDataSet;
  LCasosTestesLogIcms             : ICasosTestesLog;
  LCasosTestesLogSt               : ICasosTestesLog;
  LCasosTestesLogIcmsOrgaoPublico : ICasosTestesLog;
  LCasosTestesLogStCustoAquisicao : ICasosTestesLog;

  LResultadoComparacaoIcms             : TResultadoComparacao;
  LResultadoComparacaoSt               : TResultadoComparacao;
  LResultadoComparacaoIcmsOrgaoPublico : TResultadoComparacao;
  LResultadoComparacaoStCustoAquisicao : TResultadoComparacao;

  FParametrosIcms               : IParametrosServicoIcmsSt;
  FMetodoArredondamentoICMSECF  : TMetodoArredondamentoICMSECF;

  LNotaEEspecialFornecedor      : Boolean;
  LUtilizarSatCFe               : Boolean;
  LClienteIndustria             : Boolean;
  LEstadoCliente                : String;

  LParametrosClienteConsumidor  : IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := True;

  FMetodoArredondamentoICMSECF := Nil;

  LCasosTestesLogIcms := TCasosTestesLog.New();
  LCasosTestesLogSt   := TCasosTestesLog.New();
  LCasosTestesLogIcmsOrgaoPublico := TCasosTestesLog.New();
  LCasosTestesLogStCustoAquisicao := TCasosTestesLog.New();

  LDados := TUniClientDataSet.Create(Nil);

  InicializarVariaveisRegistros;

  Try
    LDados.Data := ADados;
    LDados.Open;
    LDados.First;

    FQuantidadeRegistro := frmModulo.Registros;

    LUtilizarSatCFe := fGetValorConfiguracao(CFG_UTILIZAR_SAT_CFE, varBoolean);

    FCfg_CalcularIpiStParaDocumentosDeFF := fGetValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, varBoolean);

    frmModulo.Registros(frmModulo.Registros * 4);

    Try
      While Not LDados.Eof Do
      Begin
        if (ValidarPararProcessamento) then
          Break;

        pExecutarProgresso(LDados.RecordCount, LDados.RecNo);

        LNotaEEspecialFornecedor :=
          ((LDados.FieldByName('AUX_OPCDOC').AsString = 'NE') And
            (LDados.FieldByName('DET_TIP_FC').AsString = 'F'));

        LClienteIndustria := ValidarClienteIndustria(LDados.FieldByName('AUX_TPOPER').AsString, LDados.FieldByName('CLI_INDUST').AsString);

        LEstadoCliente :=
          RetornarEstadoCliente( LDados.FieldByName('GER_ESTCON').AsString,
                                 LDados.FieldByName('DET_ESTADO').AsString );

        LParametrosClienteConsumidor :=
          TParametrosFaturamentoImpostosClienteConsumidor.New
            .ClienteEstado(LEstadoCliente)
            .ClienteInscricaoEstadual(LDados.FieldByName('GER_IESCON').AsString)
            .ClienteAtividade(LDados.FieldByName('AUX_CODATI').AsString)
            .CalcularDescontoIcmsOrgaoPublico(
              TFunctionFuncoesFaturamento.
                ValidarDescontoDeICMSOrgaoPublico(
                  LDados.FieldByName('AUX_OPCDOC').AsString,
                  LDados.FieldByName('CLI_CALICM').AsString) = 'S')
            .ClienteFisicoOuJuridico(
              TFunctionFuncoesFaturamento
                .RetornarClienteFisicoOuJuridico(LDados.FieldByName('GER_CGCCPF').AsInteger));

        FParametrosIcms :=
          TParametrosServicoIcmsSt.New
            .CodigoDoCliente(LDados.FieldByName('DET_CODCLI').AsString)
            .ClienteConsumidorFinal(LDados.FieldByName('GER_CONSUM').AsString = 'S')
            .CodigoDoProduto(LDados.FieldByName('DET_CODITE').AsString)
            .CodigoDaEmpresa(LDados.FieldByName('DET_CODEMP').AsString)
            .TotalGeralDoItem(LDados.FieldByName('DET_TOTITE').AsFloat)
            .ValorFreteDoItem(LDados.FieldByName('DET_TOTFRE').AsFloat)
            .DespesaAcessoriaDoItem(LDados.FieldByName('DET_DESACE').AsFloat)
            .DescontoEspecial(LDados.FieldByName('DET_DESESP').AsFloat)
            .MetodoArredondamentoICMSECF(FMetodoArredondamentoICMSECF) // Verificar
            .NotaComplementoFornecedor(LDados.FieldByName('AUX_OPCDOC').AsString = 'OF')
            .NotaEspecialFornecedor(LNotaEEspecialFornecedor)
            .TaxaBombeamentoPedidoOrcamento(false)
            .CodigoDoFornecedor(LDados.FieldByName('DET_CODFOR').AsString)
            .SequencialEnderecoEntrega(LDados.FieldByName('SEQUENCIAL_ENDERECO').AsString)
            .OpcaoDoDocumento(LDados.FieldByName('AUX_OPCDOC').AsString)
            .EspecieDocumento(LDados.FieldByName('DET_ESPDOC').AsString)
            .ClassificacaoFiscalDoItem(LDados.FieldByName('DET_CLAFIS').AsString)
            .VendaPresencial(LDados.FieldByName('AUX_VENPRE').AsString = 'S')
            .CodigoDaSituacaoTributaria(LDados.FieldByName('DET_CODFIS').AsString) // Verificar
            .OpcaoDeItemNfEspiritoSanto(RetornarOpcoesDeItemNotaEspiritoSanto(LDados.FieldByName('DET_CLAFIS').AsString))
            .EntregaFuturaDoItem(LDados.FieldByName('DET_ENTFUT').AsString = 'S')
            .BaixaDeEntregaFutura(LDados.FieldByName('AUX_OPCDOC').AsString = 'BF')
            .CodigoDaEmpresaTE(LDados.FieldByName('FGO_EMP_TE').AsString)
            .AliquotaDeIcmsDoItem(LDados.FieldByName('DET_ALQICM').AsFloat)
            .TipoOperacaoPedidoVenda( LDados.FieldByName('FGO_TIPOPE').AsString )
            .UtilizaSat(LUtilizarSatCFe)
            .CalcularSatEcf(True)
            .ValorUnitarioDoItem(LDados.FieldByName('DET_UNITAR').AsFloat)
            .QuantidadeDoItem(LDados.FieldByName('DET_QTDITE').AsFloat)
            .EspecieDeDevolucao(LDados.FieldByName('DET_ESPDEV').AsString)
            .DesmembrarNotaProdutosServicos(false)
            .DesmembrarMeiaNotaComNotaNormal(false)
            .MeiaNotaFatorExpedicao(false)
            .PrecoDeCustoDoItem(LDados.FieldByName('ITE_PRECUS').AsFloat)
            .PrecoDeUltimaCompraDoItem(LDados.FieldByName('ITE_PREULT').AsFloat)
            .PrecoEImpostosDeUltimaCompraDoItem(LDados.FieldByName('ITE_IMPULT').AsFloat)
            .PercentualDoFcpDoItem(LDados.FieldByName('DET_PFCPST').AsFloat)
            .ValorDoFcpDoItem(LDados.FieldByName('DET_VFCPST').AsFloat)
            .TipoDePedidoFaturamento(LDados.FieldByName('FGO_TIPPED').AsString)
            .ClienteIndustria(LClienteIndustria)
            .ClienteComercializacao(LDados.FieldByName('CLI_INDCOM').AsString = 'C')
            .IdePro(LDados.FieldByName('DET_IDEPRO').AsString)
            .PrecoDeCompraDaTinta(LDados.FieldByName('DET_PRCTIN').AsFloat)
            .PrecoDeCustoDoItemSemImpostos(LDados.FieldByName('ITE_PRECUS').AsFloat)
            .OrigemF11(LDados.FieldByName('AUX_OPCDOC').AsString = '11')
            .CodigoDaEmpresaOriginal(LDados.FieldByName('DET_EMPORI').AsString)
            .NumeroDoOrcamento(LDados.FieldByName('DET_NUM_PD').AsString)
            .GerandoCasosTestes(True)
            .ParametrosClienteConsumidor(LParametrosClienteConsumidor);

        FResultadoServicosClasseIcmsSt := GetFaturamentoImpostosService.IcmsSt.CalcularValorIcmsStFinal(FParametrosIcms);

        LResultadoComparacaoIcms             := ResultadoComparacaoIcms(LDados);
        LResultadoComparacaoSt               := ResultadoComparacaoSt(LDados);
        LResultadoComparacaoIcmsOrgaoPublico := ResultadoComparacaoIcmsOrgaoPublico(LDados);
        LResultadoComparacaoStCustoAquisicao := ResultadoComparacaoStCustoAquisicao(LDados);

        pTesteUnitarioLog(FResultadoServicosClasseIcmsSt, LDados);
        ZerarRegistrosDoProcessamento;

        CasosTestesLogIcms(LCasosTestesLogIcms, LResultadoComparacaoIcms, LDados);
        TotalizarRegistrosProcessamentoIcms;
        ZerarRegistrosDoProcessamento;

        CasosTestesLogSt(LCasosTestesLogSt, LResultadoComparacaoSt, LDados);
        TotalizarRegistrosProcessamentoSt;
        ZerarRegistrosDoProcessamento;

        CasosTestesLogIcmsOrgaoPublico(LCasosTestesLogIcmsOrgaoPublico, LResultadoComparacaoIcmsOrgaoPublico, LDados);
        TotalizarRegistrosProcessamentoIcmsOrgaoPublico;
        ZerarRegistrosDoProcessamento;

        CasosTestesLogStCustoAquisicao(LCasosTestesLogStCustoAquisicao, LResultadoComparacaoStCustoAquisicao, LDados);
        TotalizarRegistrosProcessamentoStCustoAquisicao;

        TotalizarRegistrosProcessamentoGeral;

        pLimparVariaveisTesteUnitario;

        LDados.Next;
      End;

      frmModulo.Registros(FQuantidadeRegistro);

      SetarTotaisDoProcessamentoDoIcms;
      LCasosTestesLogIcms.GerarLog('Icms');

      SetarTotaisDoProcessamentoDoSt;
      LCasosTestesLogSt.GerarLog('St');

      SetarTotaisDoProcessamentoDoIcmsOrgaoPublico;
      LCasosTestesLogIcmsOrgaoPublico.GerarLog('IcmsOrgaoPublico');

      SetarTotaisDoProcessamentoDoStCustoAquisicao;
      LCasosTestesLogStCustoAquisicao.GerarLog('STCustoAquisicao');

      SetarTotaisDoProcessamentoFinal;
    Except
      On E : Exception do
        pFinalizarProcessamentoComErro(LDados, E.Message);
    End;
  Finally
    FreeAndNil(LDados);
  End;

end;

Function TGerarTesteIcms.RetornarResultadoComparacaoIcms(Const ADados : TUniClientDataSet) : TResultadoComparacao;

begin
  Result := rcoFalse;

  If CompararResultadoIcms(FResultadoServicosClasseIcmsSt.ResultadoCalculoIcms, ADados) Then
    Result := rcoTrue;

  Exit;
end;

function TGerarTesteIcms.RetornarResultadoComparacaoIcmsOrgaoPublico(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := rcoTrue;

  If CompararResultadoIcmsOrgaoPublico(FResultadoServicosClasseIcmsSt.ResultadoCalculoIcmsOrgaoPublico, ADados) Then
    Exit;

  Result := rcoFalse;
end;

function TGerarTesteIcms.PodeAdicionarLogIgnoradasIcmsOrgaoPublico(const ADados: TUniClientDataSet): boolean;
begin
  Result := True;

  If (TFunctionFuncoesFaturamento.fEhItemServico(ADados.FieldByName('DET_CODITE').AsString)) Then
    Exit;

  Result := False;
end;

function TGerarTesteIcms.AdicionarLogEspeciesIgnoradasIcmsOrgaoPublico(
  const ADados: TUniClientDataSet;
  const AResultadoComparacao: TResultadoComparacao;
  const AResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico): Boolean;
begin
  Result := False;

  If (AResultadoComparacao = rcoTrue) Then
    Exit;

  If not PodeAdicionarLogIgnoradasIcmsOrgaoPublico(ADados) then
    Exit;

  Result := True;
end;

function TGerarTesteIcms.AdicionarLogEspeciesIgnoradasSt(
  const ADados: TUniClientDataSet;
  const AResultadoComparacao: TResultadoComparacao;
  const AResultadoCalculoST: IResultadoCalculoST): Boolean;
begin
  Result := False;

  If (AResultadoComparacao = rcoTrue) Then
    Exit;

  If Not PodeAdicionarLogIgnoradasST(ADados, AResultadoCalculoST) Then
    Exit;

  Result := True;
end;

function TGerarTesteIcms.AdicionarLogEspeciesIgnoradasStCustoAquisicao(
  const ADados: TUniClientDataSet;
  const AResultadoComparacao: TResultadoComparacao;
  const AResultadoCalculoSTCustoAquisicao: IResultadoCalculoSTCustoAquisicao): Boolean;
begin
  Result := False;

  If (AResultadoComparacao = rcoTrue) Then
    Exit;

  If Not PodeAdicionarLogIgnoradasStCustoAquisicao(ADados) Then
    Exit;

  Result := True;
end;

function TGerarTesteIcms.RetornarResultadoComparacaoSt(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := rcoFalse;

  If CompararResultadoST(FResultadoServicosClasseIcmsSt.ResultadoCalculoSt, ADados) Then
    Result := rcoTrue;

  Exit;
end;

function TGerarTesteIcms.RetornarResultadoComparacaoStCustoAquisicao(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := rcoFalse;

  If Not CompararResultadoSTCustoAquisicao(FResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao, ADados) Then
    Exit;

  Result := rcoTrue;
end;

procedure TGerarTesteIcms.CasosTestesLogIcms(
  ACasosTestesLogIcms: ICasosTestesLog;
  AResultadoComparacaoIcms: TResultadoComparacao; ADados: TUniClientDataSet);
begin
  ACasosTestesLogIcms.Add(
    TParametrosCasosTestesLog.New()
      .ResultadoComparacao(AResultadoComparacaoIcms)
      .RetornarNomeOperacao('REGRA_ICMS')
      .NumeroDoDocumento(ADados.FieldByName('DET_NUMDOC').AsString)
      .EspecieDoDocumento(ADados.FieldByName('DET_ESPDOC').AsString)
      .CodigoDaEmpresa(ADados.FieldByName('DET_CODEMP').AsString)
      .CodigoDoItem(ADados.FieldByName('DET_CODITE').AsString)
      .CodigoDoCliente(ADados.FieldByName('DET_CODCLI').AsString)
      .OpcaoDocumento(ADados.FieldByName('AUX_OPCDOC').AsString)
      .DataEntrada(ADados.FieldByName('DET_DTAENT').AsDateTime)
      .ClassificacaoFiscal(ADados.FieldByName('DET_CLAFIS').AsString)
      .CodigoFiscal(ADados.FieldByName('DET_CODFIS').AsString)
      .EstadoDoDocumento(ADados.FieldByName('DET_ESTADO').AsString)
      .TipoDaAbreviacaoFiscal(FResultadoServicosClasseIcmsSt.ResultadoCalculoIcms.TipoDaAbreviacaoFiscal)
      .IdentificacaoDoProduto(ADados.FieldByName('DET_IDEPRO').AsString)
      .Log(fGetVariavelLogIcms)
  );
end;

procedure TGerarTesteIcms.CasosTestesLogIcmsOrgaoPublico(
  ACasosTestesLogIcmsOrgaoPublico: ICasosTestesLog;
  AResultadoComparacaoIcmsOrgaoPublico: TResultadoComparacao;
  ADados: TUniClientDataSet);
begin
  ACasosTestesLogIcmsOrgaoPublico.Add(
    TParametrosCasosTestesLog.New()
      .ResultadoComparacao(AResultadoComparacaoIcmsOrgaoPublico)
      .RetornarNomeOperacao('REGRA_ICMSORGAOPUBLICO')
      .NumeroDoDocumento(ADados.FieldByName('DET_NUMDOC').AsString)
      .EspecieDoDocumento(ADados.FieldByName('DET_ESPDOC').AsString)
      .CodigoDaEmpresa(ADados.FieldByName('DET_CODEMP').AsString)
      .CodigoDoItem(ADados.FieldByName('DET_CODITE').AsString)
      .CodigoDoCliente(ADados.FieldByName('DET_CODCLI').AsString)
      .OpcaoDocumento(ADados.FieldByName('AUX_OPCDOC').AsString)
      .DataEntrada(ADados.FieldByName('DET_DTAENT').AsDateTime)
      .ClassificacaoFiscal(ADados.FieldByName('DET_CLAFIS').AsString)
      .CodigoFiscal(ADados.FieldByName('DET_CODFIS').AsString)
      .EstadoDoDocumento(ADados.FieldByName('DET_ESTADO').AsString)
      .TipoDaAbreviacaoFiscal(FResultadoServicosClasseIcmsSt.ResultadoCalculoIcms.TipoDaAbreviacaoFiscal)
      .IdentificacaoDoProduto(ADados.FieldByName('DET_IDEPRO').AsString)
      .Log(fGetVariavelLogIcmsOrgaoPublico)
  );
end;

procedure TGerarTesteIcms.CasosTestesLogSt(ACasosTestesLogSt: ICasosTestesLog;
  AResultadoComparacaoSt: TResultadoComparacao; ADados: TUniClientDataSet);
begin
  ACasosTestesLogSt.Add(
    TParametrosCasosTestesLog.New()
      .ResultadoComparacao(AResultadoComparacaoSt)
      .RetornarNomeOperacao('REGRA_ST')
      .NumeroDoDocumento(ADados.FieldByName('DET_NUMDOC').AsString)
      .EspecieDoDocumento(ADados.FieldByName('DET_ESPDOC').AsString)
      .CodigoDaEmpresa(ADados.FieldByName('DET_CODEMP').AsString)
      .CodigoDoItem(ADados.FieldByName('DET_CODITE').AsString)
      .CodigoDoCliente(ADados.FieldByName('DET_CODCLI').AsString)
      .OpcaoDocumento(ADados.FieldByName('AUX_OPCDOC').AsString)
      .DataEntrada(ADados.FieldByName('DET_DTAENT').AsDateTime)
      .ClassificacaoFiscal(ADados.FieldByName('DET_CLAFIS').AsString)
      .CodigoFiscal(ADados.FieldByName('DET_CODFIS').AsString)
      .EstadoDoDocumento(ADados.FieldByName('DET_ESTADO').AsString)
      .TipoDaAbreviacaoFiscal(FResultadoServicosClasseIcmsSt.ResultadoCalculoIcms.TipoDaAbreviacaoFiscal)
      .IdentificacaoDoProduto(ADados.FieldByName('DET_IDEPRO').AsString)
      .Log(fGetVariavelLogSt)
  );
end;

procedure TGerarTesteIcms.CasosTestesLogStCustoAquisicao(
  ACasosTestesLogStCustoAquisicao: ICasosTestesLog;
  AResultadoComparacaoStCustoAquisicao: TResultadoComparacao;
  ADados: TUniClientDataSet);
begin
  ACasosTestesLogStCustoAquisicao.Add(
    TParametrosCasosTestesLog.New()
      .ResultadoComparacao(AResultadoComparacaoStCustoAquisicao)
      .RetornarNomeOperacao('REGRA_STCUSTOAQUISICAO')
      .NumeroDoDocumento(ADados.FieldByName('DET_NUMDOC').AsString)
      .EspecieDoDocumento(ADados.FieldByName('DET_ESPDOC').AsString)
      .CodigoDaEmpresa(ADados.FieldByName('DET_CODEMP').AsString)
      .CodigoDoItem(ADados.FieldByName('DET_CODITE').AsString)
      .CodigoDoCliente(ADados.FieldByName('DET_CODCLI').AsString)
      .OpcaoDocumento(ADados.FieldByName('AUX_OPCDOC').AsString)
      .DataEntrada(ADados.FieldByName('DET_DTAENT').AsDateTime)
      .ClassificacaoFiscal(ADados.FieldByName('DET_CLAFIS').AsString)
      .CodigoFiscal(ADados.FieldByName('DET_CODFIS').AsString)
      .EstadoDoDocumento(ADados.FieldByName('DET_ESTADO').AsString)
      .TipoDaAbreviacaoFiscal(FResultadoServicosClasseIcmsSt.ResultadoCalculoIcms.TipoDaAbreviacaoFiscal)
      .IdentificacaoDoProduto(ADados.FieldByName('DET_IDEPRO').AsString)
      .Log(fGetVariavelLogStCustoAquisicao)
  );
end;

function TGerarTesteIcms.CompararBaseEValorIcmsConformeCalculoNaVersão368(const ADados: TUniClientDataSet;
  const AResultadoCalculoIcms: IResultadoCalculoIcms): boolean;
var
  LBaseIcmsCalculado: Double;
  LValorIcmsCalculado: Double;
  LTotalGeralDoItem: Double;
begin
  result := False;

  LTotalGeralDoItem := ADados.FieldByName('DET_TOTITE').AsFloat - ADados.FieldByName('DET_DESESP').AsFloat;
  LValorIcmsCalculado := fFormataFloat(((((LTotalGeralDoItem + ADados.FieldByName('DET_VALIPI').AsFloat) * ADados.FieldByName('DET_PERBAS').AsFloat) / 100) * ADados.FieldByName('DET_ALQICM').AsFloat) / 100, 2);
  LBaseIcmsCalculado  := fFormataFloat((((LTotalGeralDoItem + ADados.FieldByName('DET_VALIPI').AsFloat) * ADados.FieldByName('DET_PERBAS').AsFloat) / 100), 2);

  if not (CompararValores(LValorIcmsCalculado, ADados.FieldByName('DET_VALICM').AsFloat)) then
    Exit;

  if not (CompararValores(LBaseIcmsCalculado, ADados.FieldByName('DET_BASICM').AsFloat)) then
    Exit;

  result := True;
end;

function TGerarTesteIcms.ValidarSeDeveAdicionarLogDiferencaBaseValorIcmsComIpiVersao368(const ADados: TUniClientDataSet;
  const AResultadoCalculoIcms: IResultadoCalculoIcms): boolean;
begin
  result := False;

  if (ADados.FieldByName('DET_VALIPI').AsFloat <= 0) Then
    Exit;

  if (CompararValores(ADados.FieldByName('DET_BASICM').AsFloat, AResultadoCalculoIcms.BaseDeCalculoDoIcms)) Then
    Exit;

  if (CompararValores(ADados.FieldByName('DET_VALICM').AsFloat, AResultadoCalculoIcms.BaseDeCalculoDoIcms)) Then
    Exit;

  if not (CompararValores(ADados.FieldByName('DET_ALQICM').AsFloat, AResultadoCalculoIcms.AliquotaDoIcms)) Then
    Exit;

  if not (CompararValores(ADados.FieldByName('DET_PERBAS').AsFloat, AResultadoCalculoIcms.PercentualDaBaseDeIcms)) Then
    Exit;

  if not (CompararValores(ADados.FieldByName('DET_PERRED').AsFloat, AResultadoCalculoIcms.PercentualDeReducaoDaBaseDeIcms)) Then
    Exit;

  if not (CompararValores(ADados.FieldByName('DET_VALDIF').AsFloat, AResultadoCalculoIcms.ValorDaDiferencaDeIcms)) Then
    Exit;

  if not (CompararBaseEValorIcmsConformeCalculoNaVersão368(ADados, AResultadoCalculoIcms)) then
    Exit;

  result := True;
end;

function TGerarTesteIcms.ValidarSeDeveAdicionarLogDiferencaVendaNormalPermitindoEditarBasesNosDadosFiscais(const ADados: TUniClientDataSet;
  const AResultadoCalculoIcms: IResultadoCalculoIcms): boolean;
begin
  result := False;

  if (ADados.FieldByName('DET_ESPDOC').AsString <> 'NF') then
    Exit;

  if (Pos(ADados.FieldByName('AUX_OPCDOC').AsString, 'VN_OE_') <= 0) then
    Exit;

  if (Not fGetValorConfiguracao(CFG_PERMITIR_ALTERAR_BASE_E_VALOR_IMPOSTOS_TELA_DADOS_FISCAIS, varBoolean)) then
    Exit;

  result := True;
end;

function TGerarTesteIcms.PodeAdicionarLogIgnoradasIcms(
  const ADados: TUniClientDataSet;
  const AResultadoCalculoIcms: IResultadoCalculoIcms): Boolean;
begin
  Result := True;

  if (ValidarSeDeveAdicionarLogTintadeMaquina(ADados)) then
    Exit;

  If TFunctionFuncoesFaturamento.fEhItemServico(ADados.FieldByName('DET_CODITE').AsString) Then
    Exit;

  If ValidarSeDeveAdicionarLogPercentualDaBaseDeIcms(ADados, AResultadoCalculoIcms) Then
    Exit;

  If ValidarSeDeveAdicionarLogRICMPRIcms(ADados, AResultadoCalculoIcms) Then
    Exit;

  if ValidarSeDeveAdicionarLogDiferencaVendaNormalPermitindoEditarBasesNosDadosFiscais(ADados, AResultadoCalculoIcms) then
    Exit;

  if ValidarSeDeveAdicionarLogDiferencaBaseValorIcmsComIpiVersao368(ADados, AResultadoCalculoIcms) then
    Exit;

  If ValidarSeDeveAdicionarLogEspeciesIgnoradas(ADados) Then
    Exit;

  If CompararCodFis(FResultadoServicosClasseIcmsSt.CodigoDaSubstituicaoTributariaDoItem,
                    ADados.FieldByName('DET_CODFIS').AsString,
                    ADados.FieldByName('CLI_ORGPUB').AsString = 'S') Then
  begin
    Exit;
  end;

  Result := False;
end;

function TGerarTesteIcms.ValidarSeDeveAdicionarLogFF(const ADados: TUniClientDataSet): boolean;
begin
  Result := ValidarRegrasCalculoSTParaFF(ADados);
end;

function TGerarTesteIcms.PodeAdicionarLogIgnoradasSt(
  const ADados: TUniClientDataSet;
  const AResultadoCalculoSt: IResultadoCalculoSt): Boolean;
begin
  Result := True;

  If ValidarSeDeveAdicionarLogTintaDeMaquina(ADados) Then
    Exit;

  If TFunctionFuncoesFaturamento.fEhItemServico(ADados.FieldByName('DET_CODITE').AsString) Then
    Exit;

  If ValidarSeDeveAdicionarLogRICMPRIST(ADados, AResultadoCalculoST) Then
    Exit;

  If ValidarSeDeveAdicionarLogEspeciesIgnoradas(ADados) Then
    Exit;

  If ValidarSeDeveAdicionarLogFF(ADados) Then
    Exit;

  Result := False;
end;


function TGerarTesteIcms.PodeAdicionarLogIgnoradasStCustoAquisicao(const ADados: TUniClientDataSet): Boolean;
begin
  Result := True;

  If ValidarSeDeveAdicionarLogTintadeMaquina(ADados) Then
    Exit;

  If TFunctionFuncoesFaturamento.fEhItemServico(ADados.FieldByName('DET_CODITE').AsString) Then
    Exit;

  If ValidarSeDeveAdicionarLogEspeciesIgnoradas(ADados) Then
    Exit;

  If ValidarSeDeveAdicionarLogIND_PD_F3_CAIXA(ADados) Then
    Exit;

  Result := False;
end;

function TGerarTesteIcms.ValidarSeDeveAdicionarLogTintaDeMaquina(const ADados: TUniClientDataSet) : Boolean;
begin
  Result := true;

  If (ADados.FieldByName('DET_IDEPRO').AsString <> 'NOR'  ) Then
    Exit;

  Result := false;
end;

function TGerarTesteIcms.PossuiBrindeProduto(
  const ATipoOperacaoPedidoVenda: String): Boolean;
begin
  Result := True;

  If (ATipoOperacaoPedidoVenda = 'B') Then
    Exit;

  Result := False;
end;

class function TGerarTesteIcms.New: IGerarTeste;
begin
  Result := Self.Create;
end;

function TGerarTesteIcms.PossuiBrindeServico(
  const AOpcaoDeDocumento: String): Boolean;
begin
  Result := False;
end;

procedure TGerarTesteIcms.pTesteUnitarioLog(
  AResultadoServicosClasseIcmsSt: IResultadoServicosClasseIcmsSt;
  ADados: TUniClientDataSet);
begin

  {Setando os Valores de ICMS}

  SetarResultadosComparacao(AResultadoServicosClasseIcmsSt.ResultadoCalculoIcms);

  SetarParametrosComparacao(
    TParametrosComparacaoIcms.New()
      .AliquotaDoIcms(ADados.FieldByName('DET_ALQICM').AsFloat)
      .BaseDeCalculoDoIcms(ADados.FieldByName('DET_BASICM').AsFloat)
      .ValorCalculadoDoIcms(ADados.FieldByName('DET_VALICM').AsFloat)
      .PercentualDaBaseDeIcms(ADados.FieldByName('DET_PERBAS').AsFloat)
      .ValorDaDiferencaDeIcms(ADados.FieldByName('DET_VALDIF').AsFloat)
      .PercentualDeReducaoDaBaseDeIcms(ADados.FieldByName('DET_PERRED').AsFloat)
      .ReducaoRICMPR(ADados.FieldByName('DET_RICMPR').AsString));

  pGerarLogTesteUnitario((AResultadoServicosClasseIcmsSt.ParametrosCalculoIcms as TObject),
    (AResultadoServicosClasseIcmsSt.ResultadoCalculoIcms as TObject), Nil, 'CalcularValorIcms');

  {Setando os Valores de ST}

  SetarResultadosComparacao(AResultadoServicosClasseIcmsSt.ResultadoCalculoSt);

  SetarParametrosComparacao(
    TParametrosComparacaoST.New()
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(ADados.FieldByName('DET_BASRET').AsFloat)
      .ValorDaSubstituicaoTributariaDoItem(ADados.FieldByName('DET_VALRET').AsFloat)
      .PercentualDoFCPDoItem(ADados.FieldByName('DET_PFCPST').AsFloat)
      .ValorDoFCPDoItem(ADados.FieldByName('DET_VFCPST').AsFloat)
      .BaseDaSubstituicaoTributariaSimulada(objFloatUtils.fFormataFloat(ADados.FieldByName('ITE_RET_SP').AsFloat,2))
      .ValorDoIvaMatriz(ADados.FieldByName('DET_VALIVA').AsFloat)
      .PercentualDaSubstituicaoDaBase(ADados.FieldByName('DET_PEBAST').AsFloat)
      );

  pGerarLogTesteUnitario((AResultadoServicosClasseIcmsSt.ParametrosCalculoSt as TObject),
    (AResultadoServicosClasseIcmsSt.ResultadoCalculoSt as TObject), Nil, 'CalcularValorST');

  {Setando os Valores de Icms de Orgão Publico}

  SetarResultadosComparacao(AResultadoServicosClasseIcmsSt.ResultadoCalculoIcmsOrgaoPublico);

  SetarParametrosComparacao(
    TParametrosComparacaoIcmsOrgaoPublico.New()
      .BaseDeIcmsDeOrgaoPublicoDoItem(ADados.FieldByName('BASORG_ITEM').AsFloat)
      .ValorDoIcmsDeOrgaoPublicoDoItem(ADados.FieldByName('DET_ICMORG').AsFloat)
  );

  pGerarLogTesteUnitario((AResultadoServicosClasseIcmsSt.ParametrosCalculoIcmsOrgaoPublico as TObject),
    (AResultadoServicosClasseIcmsSt.ResultadoCalculoIcmsOrgaoPublico as TObject), Nil, 'CalcularValorIcmsOrgaoPublico');

  {Setando os Valores de ST Custo Aquisicao}

  SetarResultadosComparacao(AResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao);

  SetarParametrosComparacao(
    TParametrosComparacaoSTCustoAquisicao.New()
      .BaseDaSTCustoAquisicao(ADados.FieldByName('DET_BARTSP').AsFloat)
      .ValorDaSTCustoAquisicao(ADados.FieldByName('DET_VLRTSP').AsFloat)
      .ValorDoIcmsOperacoesProprias(ADados.FieldByName('DET_ICOPPR').AsFloat)
   );

  pGerarLogTesteUnitario((AResultadoServicosClasseIcmsSt.ParametrosCalculoStCustoAquisicao as TObject),
    (AResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao as TObject), Nil, 'CalcularValorSTCustoAquisicao');
end;

function TGerarTesteIcms.ResultadoComparacaoIcms(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := RetornarResultadoComparacaoIcms(ADados);

  If AdicionarLogEspeciesIgnoradasIcms(ADados,
                                       Result,
                                       FResultadoServicosClasseIcmsSt.ResultadoCalculoIcms) Then
  Begin
    Result := rcoIgnorado;
  End;
end;

function TGerarTesteIcms.ResultadoComparacaoIcmsOrgaoPublico(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := RetornarResultadoComparacaoIcmsOrgaoPublico(ADados);

  If AdicionarLogEspeciesIgnoradasIcmsOrgaoPublico(ADados,
                                                   Result,
                                                   FResultadoServicosClasseIcmsSt.ResultadoCalculoIcmsOrgaoPublico) Then
  Begin
    Result := rcoIgnorado;
  End;
end;

function TGerarTesteIcms.ResultadoComparacaoSt(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := RetornarResultadoComparacaoSt(ADados);

  If AdicionarLogEspeciesIgnoradasSt(ADados,
                                     Result,
                                     FResultadoServicosClasseIcmsSt.ResultadoCalculoSt) Then
  Begin
    Result := rcoIgnorado;
  End;
end;

function TGerarTesteIcms.ResultadoComparacaoStCustoAquisicao(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := RetornarResultadoComparacaoStCustoAquisicao(ADados);

  If AdicionarLogEspeciesIgnoradasStCustoAquisicao(ADados,
                                                   Result,
                                                   FResultadoServicosClasseIcmsSt.ResultadoCalculoStCustoAquisicao) Then
  Begin
    Result := rcoIgnorado;
  End;
end;

function TGerarTesteIcms.RetornarOpcoesDeItemNotaEspiritoSanto(
  AClassificacaoFiscal: String): TOpcItensNFespTinta;
begin
  Result := opcProdutoAcabado;

  If AClassificacaoFiscal = '1926' Then
    Exit;

  Result := opcColorantesTributados;

  If AClassificacaoFiscal = '5926' Then
    Exit;

  Result := opcVazio;

end;

function TGerarTesteIcms.ValidarSeDeveAdicionarLogEspeciesIgnoradas(const ADados: TUniClientDataSet): Boolean;
begin
  Result := True;

  If (Pos(ADados.FieldByName('DET_ESPDOC').AsString, 'GA_GC_AJ_BE_ML_TM_PR_OI_OP_TA_') > 0) Then
    Exit;

  If (Pos(ADados.FieldByName('AUX_OPCDOC').AsString, 'OU_OE_') > 0) Then
    Exit;

  If (ADados.FieldByName('AUX_OPCDOC').AsString = '') And (ADados.FieldByName('DET_CLAFIS').AsInteger < 5000) Then
    Exit;

  Result := False;
end;

function TGerarTesteIcms.ValidarSeDeveAdicionarLogIND_PD_F3_CAIXA(const ADados: TUniClientDataSet): Boolean;
begin
  Result := True;

  If ADados.FieldByName('DET_IND_PD').AsString = '-1' Then
    Exit;

  Result := False;
end;

function TGerarTesteIcms.ValidarSeDeveAdicionarLogPercentualDaBaseDeIcms(
  const ADados: TUniClientDataSet;
  const AResultadoCalculoIcms: IResultadoCalculoIcms): Boolean;
begin
  Result := True;

  If ZerarPercentualDaBaseDeIcms(ADados, AResultadoCalculoIcms) Then
    Exit;

  Result := False;
end;

function TGerarTesteIcms.ValidarSeDeveAdicionarLogRICMPRIcms(
  const ADados: TUniClientDataSet;
  const AResultadoCalculoIcms: IResultadoCalculoIcms): Boolean;
begin
  Result := False;

  If (ADados.FieldByName('AUX_OPCDOC').AsString <> 'OU') Then
    Exit;

  If (AResultadoCalculoIcms.AliquotaDoIcms <> ADados.FieldByName('DET_ALQICM').AsFloat) Then
    Exit;

  If (AResultadoCalculoIcms.BaseDeCalculoDoIcms <> ADados.FieldByName('DET_BASICM').AsFloat) Then
    Exit;

  If (AResultadoCalculoIcms.ValorCalculadoDoIcms <> ADados.FieldByName('DET_VALICM').AsFloat) Then
    Exit;

  If (AResultadoCalculoIcms.PercentualDeReducaoDaBaseDeIcms <> ADados.FieldByName('DET_PERRED').AsFloat) Then
    Exit;

  If (AResultadoCalculoIcms.PercentualDaBaseDeIcms = ADados.FieldByName('DET_PERBAS').AsFloat)  Then
    Exit;

  If (AResultadoCalculoIcms.ValorDaDiferencaDeIcms = ADados.FieldByName('DET_VALDIF').AsFloat) Then
    Exit;

  If (AResultadoCalculoIcms.ReducaoRICMPR <> 'S') Then
    Exit;

  Result := True;
end;

function TGerarTesteIcms.ValidarSeDeveAdicionarLogRICMPRIST(
  const ADados: TUniClientDataSet;
  const AResultadoCalculoST: IResultadoCalculoST): Boolean;
begin
  Result := false;

  If Empty(ADados.FieldByName('DET_RICMPR').AsString, 'N') <> 'S' Then
    Exit;

  If ADados.FieldByName('DET_PERRED').AsString <> '33,33' Then
    Exit;

  If AResultadoCalculoST.PercentualDaSubstituicaoDaBase =  ADados.FieldByName('DET_PEBAST').AsFloat Then
    Exit;

  Result := true;
end;

function TGerarTesteIcms.ZerarPercentualDaBaseDeIcms(const ADados: TUniClientDataSet; const AResultadoCalculoIcms: IResultadoCalculoIcms): Boolean;
begin
  Result := False;

  If (Not DiferencaEhNoPercentualDaBaseDeIcms(ADados, AResultadoCalculoIcms)) Then
    Exit;

  If (Not (ADados.FieldByName('DET_ESPDOC').AsString = 'NF')) Then
    Exit;

  If (Pos(ADados.FieldByName('AUX_OPCDOC').AsString, 'EI_DV_CF_VN_OU_OE_CO_TE_UC_CP_CI_OV_BR_') <= 0) Then
    Exit;

  If (ADados.FieldByName('DET_BASICM').AsFloat > 0) Then
    Exit;

  If EmissaoPedidoBrinde(ADados) Then
    Exit;

  If (ADados.FieldByName('DET_VALRET').AsFloat > 0) Then
    Exit;

  If (ADados.FieldByName('AUX_OPCDOC').AsString = 'EI') And (Not fGetValorConfiguracao(CFG_FATURAMENTO_ANTES_EXPEDICAO_PEDIR_TELA_DADOS_FISCAIS, varBoolean)) Then
    Exit;

  Result := True;
end;

procedure TGerarTesteIcms.ZerarRegistrosDoProcessamento;
begin
  frmModulo.RegistrosProcessadosAcerto(0);
  frmModulo.RegistrosProcessadosErro(0);
  frmModulo.RegistrosProcessadosDuplicados(0);
  frmModulo.RegistrosProcessadosIgnorados(0);
end;

procedure TGerarTesteIcms.TotalizarRegistrosProcessamentoIcms;
begin
  Inc(FQtdeRegistrosIcmsProcessados);
  FQtdeRegistrosIcmsAcerto     := FQtdeRegistrosIcmsAcerto     + frmModulo.RegistrosProcessadosAcerto;
  FQtdeRegistrosIcmsErro       := FQtdeRegistrosIcmsErro       + frmModulo.RegistrosProcessadosErro;
  FQtdeRegistrosIcmsDuplicados := FQtdeRegistrosIcmsDuplicados + frmModulo.RegistrosProcessadosDuplicados;
  FQtdeRegistrosIcmsIgnorados  := FQtdeRegistrosIcmsIgnorados  + frmModulo.RegistrosProcessadosIgnorados;
end;

procedure TGerarTesteIcms.TotalizarRegistrosProcessamentoIcmsOrgaoPublico;
begin
  Inc(FQtdeRegistrosIcmsOrgaoPublicoProcessados);
  FQtdeRegistrosIcmsOrgaoPublicoAcerto     := FQtdeRegistrosIcmsOrgaoPublicoAcerto     + frmModulo.RegistrosProcessadosAcerto;
  FQtdeRegistrosIcmsOrgaoPublicoErro       := FQtdeRegistrosIcmsOrgaoPublicoErro       + frmModulo.RegistrosProcessadosErro;
  FQtdeRegistrosIcmsOrgaoPublicoDuplicados := FQtdeRegistrosIcmsOrgaoPublicoDuplicados + frmModulo.RegistrosProcessadosDuplicados;
  FQtdeRegistrosIcmsOrgaoPublicoIgnorados  := FQtdeRegistrosIcmsOrgaoPublicoIgnorados  + frmModulo.RegistrosProcessadosIgnorados;
end;

procedure TGerarTesteIcms.TotalizarRegistrosProcessamentoSt;
begin
  Inc(FQtdeRegistrosStProcessados);
  FQtdeRegistrosStAcerto     := FQtdeRegistrosStAcerto     + frmModulo.RegistrosProcessadosAcerto;
  FQtdeRegistrosStErro       := FQtdeRegistrosStErro       + frmModulo.RegistrosProcessadosErro;
  FQtdeRegistrosStDuplicados := FQtdeRegistrosStDuplicados + frmModulo.RegistrosProcessadosDuplicados;
  FQtdeRegistrosStIgnorados  := FQtdeRegistrosStIgnorados  + frmModulo.RegistrosProcessadosIgnorados;
end;

procedure TGerarTesteIcms.TotalizarRegistrosProcessamentoStCustoAquisicao;
begin
  Inc(FQtdeRegistrosStProcessados);
  FQtdeRegistrosStCustoAquisicaoAcerto     := FQtdeRegistrosStCustoAquisicaoAcerto     + frmModulo.RegistrosProcessadosAcerto;
  FQtdeRegistrosStCustoAquisicaoErro       := FQtdeRegistrosStCustoAquisicaoErro       + frmModulo.RegistrosProcessadosErro;
  FQtdeRegistrosStCustoAquisicaoDuplicados := FQtdeRegistrosStCustoAquisicaoDuplicados + frmModulo.RegistrosProcessadosDuplicados;
  FQtdeRegistrosStCustoAquisicaoIgnorados  := FQtdeRegistrosStCustoAquisicaoIgnorados  + frmModulo.RegistrosProcessadosIgnorados;
end;

procedure TGerarTesteIcms.TotalizarRegistrosProcessamentoGeral;
begin
  frmModulo.RegistrosProcessados(FQtdeRegistrosStProcessados + FQtdeRegistrosIcmsProcessados + FQtdeRegistrosIcmsOrgaoPublicoProcessados + FQtdeRegistrosStCustoAquisicaoProcessados);
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosStAcerto + FQtdeRegistrosIcmsAcerto + FQtdeRegistrosIcmsOrgaoPublicoAcerto + FQtdeRegistrosStCustoAquisicaoAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosStErro + FQtdeRegistrosIcmsErro + FQtdeRegistrosIcmsOrgaoPublicoErro + FQtdeRegistrosStCustoAquisicaoErro);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosStDuplicados + FQtdeRegistrosIcmsDuplicados + FQtdeRegistrosIcmsOrgaoPublicoDuplicados + FQtdeRegistrosStCustoAquisicaoDuplicados);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosStIgnorados + FQtdeRegistrosIcmsIgnorados + FQtdeRegistrosIcmsOrgaoPublicoIgnorados + FQtdeRegistrosStCustoAquisicaoIgnorados);
end;


procedure TGerarTesteIcms.SetarTotaisDoProcessamentoDoIcms;
begin
  frmModulo.RegistrosProcessados(FQtdeRegistrosIcmsProcessados);
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosIcmsAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosIcmsErro);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosIcmsIgnorados);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosIcmsDuplicados);
end;

procedure TGerarTesteIcms.SetarTotaisDoProcessamentoDoIcmsOrgaoPublico;
begin
  frmModulo.RegistrosProcessados(FQtdeRegistrosIcmsOrgaoPublicoProcessados);
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosIcmsOrgaoPublicoAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosIcmsOrgaoPublicoErro);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosIcmsOrgaoPublicoIgnorados);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosIcmsOrgaoPublicoDuplicados);
end;

procedure TGerarTesteIcms.SetarTotaisDoProcessamentoDoSt;
begin
  frmModulo.RegistrosProcessados(FQtdeRegistrosStProcessados);
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosStAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosStErro);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosStIgnorados);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosStDuplicados);
end;

procedure TGerarTesteIcms.SetarTotaisDoProcessamentoDoStCustoAquisicao;
begin
  frmModulo.RegistrosProcessados(FQtdeRegistrosStCustoAquisicaoProcessados);
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosStCustoAquisicaoAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosStCustoAquisicaoErro);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosStCustoAquisicaoIgnorados);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosStCustoAquisicaoDuplicados);
end;

procedure TGerarTesteIcms.SetarTotaisDoProcessamentoFinal;
begin
  frmModulo.RegistrosProcessados(FQtdeRegistrosStProcessados + FQtdeRegistrosIcmsProcessados + FQtdeRegistrosIcmsOrgaoPublicoProcessados + FQtdeRegistrosStCustoAquisicaoProcessados);
  frmModulo.Registros(FQuantidadeRegistro * 4 );
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosStAcerto + FQtdeRegistrosIcmsAcerto + FQtdeRegistrosIcmsOrgaoPublicoAcerto + FQtdeRegistrosStCustoAquisicaoAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosStErro + FQtdeRegistrosIcmsErro + FQtdeRegistrosIcmsOrgaoPublicoErro + FQtdeRegistrosStCustoAquisicaoErro);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosStIgnorados + FQtdeRegistrosIcmsIgnorados + FQtdeRegistrosIcmsOrgaoPublicoIgnorados + FQtdeRegistrosStCustoAquisicaoIgnorados);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosStDuplicados + FQtdeRegistrosIcmsDuplicados + FQtdeRegistrosIcmsOrgaoPublicoDuplicados + FQtdeRegistrosStCustoAquisicaoDuplicados);
end;


end.
