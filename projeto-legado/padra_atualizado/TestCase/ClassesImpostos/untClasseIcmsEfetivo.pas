unit untClasseIcmsEfetivo;

interface

uses System.SysUtils, System.Variants, Vcl.Dialogs, System.StrUtils,
  untAbstractConsulta, untIConsulta, untAbstractGerarTeste, untIGerarTeste,
  untFuncoes, UniClientDataSet, Shared.Functions.Funcoes.Faturamento,
  Shared.Functions.Configuracoes,  untConstantesUtils,
  Shared.Functions.Types, Uni, UniDataSetProvider, untICasosTestesLog,
  untCasosTestesLog, untModulo, Faturamento.Impostos.Interfaces.IcmsEfetivo,
  Faturamento.Impostos.Tipos.IcmsEfetivo, untFatCalcularImpostos,
  Shared.Functions.Constantes, Data.DB, untCasosTestesLogImpl,
  Shared.Functions.FloatUtils,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Tipos.Model,
  Faturamento.Impostos.Calculos.TesteUnitarioLog,
  Shared.Functions.Core,
  untFatCalcularImpostosService,
  untParametrosComparacaoIcmsEfetivo,
  untFuncoesTintaDeMaquinaBpl,
  untTintaDeMaquinaBpl,
  untParametrosResultadoIcmsEfetivo, untTypes;

type
  TConsultaIcmsEfetivo = class(TAbstractConsulta)
  private
    function RetornarColunasSQL(const ADoctosConfirmacao: boolean) : String;
    function RetornarTabelasSQL(const ADoctosConfirmacao: boolean): string;
    function RetornarFiltrosSQL: string;
    function AjustaTabelasDocumentoConfirmacao(const ASQLTabelas: string): string;
    function RetornarOrderBySQL : string;

    function RetornarColunaAUX_TPOPER(
      const ADoctosCOnfirmacao: boolean): string;

    function RetornarColunaAUX_CODATI(
      const ADoctosCOnfirmacao: boolean): string;
    function RetornarColunaAUX_VENPRE(
      const ADoctosCOnfirmacao: boolean): string;

  public
    Class function New : IConsulta;
    function fRetornarSQLIcmsEfetivo : String; override;
  end;

type
  TGerarTesteIcmsEfetivo = class(TAbstractGerarTeste)
  private
    function RetornarMatrizItens(Const ADados : TUniClientDataSet) : TMatrizFechamentoIcmsEfetivo;
    function ParametrosClienteConsumidor(Const ADados : TUniClientDataSet) : IParametrosFaturamentoImpostosClienteConsumidor;
    function ValidarClienteIndustria(const ATipoDeOperacao, AClienteIndustriaCadastro: string): boolean;
    function RetornarEstadoCliente(const AEstadoClienteConsumidor,
      AEstadoCliente: String): String;

    function RetornarOpcoesDeItemNotaEspiritoSanto(
      AClassificacaoFiscal: String): TOpcItensNFespTinta;

    function fGetTipoAbfCliente(const ACodigoCliente, AConsumidor,
      AInscricao: String; const AClienteIndustria: Boolean;
      Const AAtividadeConstrutora : Boolean): String;

    function RetornarEmpresaClienteFilial(const ACodigoCliente,
      AClientesFiliais: string): string;

  public
    Class function New : IGerarTeste;

    Constructor Create;
    Destructor Destroy; override;

    function fGerarTesteIcmsEfetivo(const ADados: OleVariant) : Boolean; override;

  end;


implementation

{ TConsultaIcmsEfetivo }



function TConsultaIcmsEfetivo.AjustaTabelasDocumentoConfirmacao(
  const ASQLTabelas: string): string;
begin
  result := ASQLTabelas;
  result := AnsiReplaceStr(result, 'MOVGER', 'NOTGER');
  result := AnsiReplaceStr(result, 'MOVDET', 'NOTDET');
  result := AnsiReplaceStr(result, 'AUXMOV', 'AUXNOT');
  result := AnsiReplaceStr(result, 'MOVTRI', 'NOTTRI');
  result := AnsiReplaceStr(result, 'MOVAUX', 'NOTAUX');
end;

function TConsultaIcmsEfetivo.fRetornarSQLIcmsEfetivo: String;
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
  Result := Result + RetornarOrderBySQL;
end;

class function TConsultaIcmsEfetivo.New: IConsulta;
begin
  Result := Self.Create;
end;

function TConsultaIcmsEfetivo.RetornarColunasSQL(
  const ADoctosConfirmacao: boolean): String;
begin
  Result := ' SELECT '+
            '    G.GER_CONSUM,'+
            '    G.GER_ESTCON,  '+
            '    G.GER_IESCON,  '+
            '    G.GER_CGCCPF,  '+
            '    DETDOC.AUTOINCREM AS DOCUMENTO,'+
            '    DETDOC.DET_NUMDOC,'+
            '    DETDOC.DET_ESPDOC,'+
            '    DETDOC.DET_CODEMP,'+
            '    DETDOC.DET_SERIE_,'+
            '    DETDOC.DET_CODFOR,'+
            '    DETDOC.DET_CLAFIS,'+
            '    L.CLI_INDCOM,  '+
            '    L.CLI_CALICM,  '+
            '    L.CLI_DIFERI,  '+
            '    L.CLI_INDUST,  '+
            '    L.CLI_CODATI,  '+
            '    DETDOC.DET_QTDITE AS DOC_QTDITE, '+
            '    D.DET_QTDITE      AS ITE_QTDITE, '+
            '    D.DET_CODFIS      AS ITE_CODFIS, '+
            '    D.DET_ESTADO      AS ITE_ESTADO, '+
            '    D.DET_TOTITE      AS ITE_TOTITE, '+
            '    D.DET_IDEPRO, '+
            '    D.DET_TOTFRE, '+
            '    D.DET_DESESP, '+
            '    D.DET_DESACE, '+
            '    D.DET_TIP_FC,  '+
            '    D.DET_IDEPRO,  '+
            '    FATGOR.FGO_TIPOPE,  '+
            '    (D.DET_TOTITE + D.DET_VALIPI) AS TOTAL_ITEM_CALC_ICMS_EFETIVO, '+
            '    D.DET_ALQIPI AS DETITE_ALQIPI, '+
            '    D.DET_DTAENT AS DETITE_DTAENT, '+
            '    D.DET_CODCLI AS DETITE_CODCLI, '+
            '    D.DET_CODITE AS DETITE_CODITE, '+
            '    D.DET_NUMDOC AS DETITE_NUMDOC, '+
            '    D.DET_ESPDOC AS DETITE_ESPDOC, '+
            '    D.DET_CODEMP AS DETITE_CODEMP, '+
                 RetornarColunaAUX_TPOPER(ADoctosConfirmacao) +
            '    AUX_OPCDOC, ' +
                 RetornarColunaAUX_CODATI(ADoctosConfirmacao) +
                 RetornarColunaAUX_VENPRE(ADoctosCOnfirmacao) +
            '    E.AUTOINCREM AS SEQUENCIAL_ENDERECO, '+
            '    DETDOC.DET_DTAENT, '+
            '    IFNULL(DET_BAERET,  0.00) AS DET_BAERET, '+
            '    IFNULL(DET_VAERET,  0.00) AS DET_VAERET, '+
            '    IFNULL(N20_PREBCST, 0.00) AS DET_PERRED, '+
            '    IT.ITE_PRECOM * ((100-IT.ITE_DESF01)/100) * ((100-IT.ITE_DESF02)/100) * ((100-IT.ITE_DESF03)/100) * '+
            '    ((100-IT.ITE_DESF04)/100) * ((100-IT.ITE_DESF05)/100) * ((100-IT.ITE_DESF06)/100) * '+
            '    ((100+IT.ITE_IPIENT)/100) * ((100+IT.ITE_FREENT)/100) * '+
            '    AB.ABF_IVA_ST_ENT_PEJ   AS COMLIQ_IPI_FRETE_IVA, '+
            '    MOVAUX.DET_NOTULT, '+
            '    MOVAUX.DET_PICMEF, '+
            '    MOVAUX.DET_BICMEF, '+
            '    MOVAUX.DET_VICMEF, '+
            '    MOVAUX.DET_AICMEF, '+
            '    MOVAUX.DET_BSTANT, '+
            '    MOVAUX.DET_VSTANT ';

  If Not ADoctosConfirmacao Then
    Exit;

  Result := AnsiReplaceStr(Result, 'FATGOR.FGO_TIPOPE', '"V" AS FGO_TIPOPE');

  Result := AjustaTabelasDocumentoConfirmacao(Result);
end;

function TConsultaIcmsEfetivo.RetornarFiltrosSQL: string;
begin
  Result :=
    '   WHERE G.GER_CODEMP = :CODEMP '+
    '     AND G.GER_DTAENT BETWEEN :DTAINI '+
    '                          AND :DTAFIM ';

end;

function TConsultaIcmsEfetivo.RetornarOrderBySQL: string;
begin
  Result := ' ORDER BY DET_NUMDOC ';
end;

function TConsultaIcmsEfetivo.RetornarTabelasSQL(
  const ADoctosConfirmacao: boolean): string;
Var
  LTamNumDoc : Integer;
  LClassificaoCompra : String;
begin
  LTamNumDoc := fTamNumDoc;

  LClassificaoCompra :=
    TFunctionFuncoesFaturamento.
      Transform(fGetValorConfiguracao(CFG_CLASSIFICACAO_COMPRA), 4);

  Result :=
    ' FROM '+
    '    MOVGER G '+
    ' INNER JOIN MOVDET D '+
    '   ON D.DET_SEQGER = G.AUTOINCREM '+
    ' INNER JOIN CADCLI L '+
    '    ON L.CLI_CODCLI = D.DET_CODCLI '+
    ' LEFT JOIN MOVAUX '+
    '   ON MOVAUX.DET_SEQGER = D.AUTOINCREM '+
    ' LEFT JOIN MOVDET DETDOC'+
    '   ON DETDOC.DET_NUMDOC  = LEFT(MOVAUX.DET_NOTULT,  '+ IntToStr(LTamNumDoc) +')'+
    '  AND DETDOC.DET_ESPDOC  = SUBSTR(MOVAUX.DET_NOTULT,'+ IntToStr(LTamNumDoc) +' + 1, 2)'+
    '  AND DETDOC.DET_CODEMP  = SUBSTR(MOVAUX.DET_NOTULT,'+ IntToStr(LTamNumDoc) +'+ 3, 3)'+
    '  AND DETDOC.DET_SERIE_  = SUBSTR(MOVAUX.DET_NOTULT,'+ IntToStr(LTamNumDoc) +' + 6, 3)'+
    '  AND DETDOC.DET_CODFOR  = RIGHT(MOVAUX.DET_NOTULT,8)'+
    '  AND DETDOC.DET_CODITE  = D.DET_CODITE '+
    '  AND (LOCATE(DETDOC.DET_CLAFIS, '+ QuotedStr(LClassificaoCompra) +') > 0) '+
    '  AND (LOCATE(DETDOC.DET_CODFIS, '+ QuotedStr(objConstantes.fGetCstSubstituicao) +') > 0) '+
    '  LEFT JOIN AUXMOV                                               ' +
    '    ON AUXMOV.AUX_SEQGER = D.DET_SEQGER                          ' +
    ' LEFT JOIN MOVTRI TR ON TR.DET_SEQGER = DETDOC.AUTOINCREM '+
    ' LEFT JOIN GERELE GE ON GE.GER_DOCENT = DETDOC.DET_NUMDOC '+
    '                    AND GE.GER_ESPENT = DETDOC.DET_ESPDOC '+
    '                    AND GE.GER_EMPENT = DETDOC.DET_CODEMP '+
    '                    AND GE.GER_CODFOR = DETDOC.DET_CODFOR '+
    '                    AND IFNULL(GE.B07_SERIE, "") = IFNULL(DETDOC.DET_SERIE_, "") '+
    ' LEFT JOIN CADEMP CE ON DETDOC.DET_CODEMP = CE.EMP_CODEMP '+
    ' LEFT JOIN CADCID CC ON CE.EMP_CODCID     = CC.CID_CODCID '+
    ' LEFT JOIN CADITE CI ON DETDOC.DET_CODITE = CI.ITE_CODITE '+
    ' LEFT JOIN ITEGER IT ON DETDOC.DET_CODITE = IT.ITE_CODITE '+
    '                    AND DETDOC.DET_CODEMP = IT.ITE_CODEMP '+
    ' LEFT  JOIN ENTCLI E ON E.ETC_CODCLI = L.CLI_CODCLI '+
    '                    AND E.ETC_SEQIND = (SELECT MIN(T.ETC_SEQIND) '+
    '                                        FROM ENTCLI T '+
    '                                        WHERE T.ETC_CODCLI = L.CLI_CODCLI) '+
    ' LEFT JOIN FATDOR    ON FATDOR.FDO_NUMDOC = D.DET_NUM_PD '+
    '                    AND FATDOR.FDO_ESPDOC = D.DET_ESP_PD '+
    '                    AND FATDOR.FDO_CODEMP = D.DET_EMP_PD '+
    '                    AND FATDOR.FDO_CODITE = D.DET_CODITE '+
    ' LEFT JOIN FATGOR    ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ';


  If (fGetValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL) = '1') Then
  Begin
    Result := Result + '   LEFT JOIN ABFICM AB ON CI.ITE_CODABF = AB.ABF_CODABF ' +
                       '                      AND CC.CID_ESTADO = AB.ABF_ESTADO ' ;
  End
  Else
  Begin
    Result := Result + '   LEFT JOIN ABFICM AB ON IT.ITE_CODABF = AB.ABF_CODABF ' +
                       '                      AND CC.CID_ESTADO = AB.ABF_ESTADO ' ;
  End;

  Result := Result + '   LEFT JOIN DETELE DE ON DE.DET_SEQGER = GE.AUTOINCREM ' +
                     '                      AND DE.DET_CODITE = DETDOC.DET_CODITE ' ;

  If Not ADoctosConfirmacao Then
    Exit;

  Result := AjustaTabelasDocumentoConfirmacao(Result);
end;

{ TGerarTesteIcmsEfetivo }

constructor TGerarTesteIcmsEfetivo.Create;
begin

end;

destructor TGerarTesteIcmsEfetivo.Destroy;
begin

  inherited;
end;

function TConsultaIcmsEfetivo.RetornarColunaAUX_TPOPER(const ADoctosCOnfirmacao: boolean): string;
begin
  result := ' "" AS AUX_TPOPER, ';

  if not (objCore.fCampoExiste('AUXMOV', 'AUX_TPOPER')) then
    Exit;

  if (ADoctosCOnfirmacao) then
    Exit;

  result := ' AUXMOV.AUX_TPOPER, ';
end;

function TGerarTesteIcmsEfetivo.RetornarEmpresaClienteFilial(Const ACodigoCliente, AClientesFiliais: string): string;
begin
  result := EmptyStr;

  if (fEmptyStr(ACodigoCliente)) then
    Exit;

  if (Pos(ACodigoCliente, AClientesFiliais)) <= 0 Then
    Exit;

  result := fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_CLIFIL'], [ACodigoCliente], False);
end;


function TGerarTesteIcmsEfetivo.fGetTipoAbfCliente(const ACodigoCliente, AConsumidor, AInscricao: String; const AClienteIndustria: Boolean; Const AAtividadeConstrutora : Boolean ): String;
  Var
    qryCliente: TUniQuery;
    LClientesFiliais     : String;
    LCodigoClienteFilial : String;
begin
  LClientesFiliais := fCampoTabela('GROUP_CONCAT(EMP_CLIFIL)', 'CADEMP', [], [], False, '', Nil);

  LCodigoClienteFilial    := RetornarEmpresaClienteFilial(ACodigoCliente, LClientesFiliais);

  qryCliente := fCriaQuery;

  qryCliente.SQL.Text := TFunctionFuncoesFaturamento.fGetSelectTipoAbfCliente;
  qryCliente.ParamByName('CODCLI').AsString := ACodigoCliente;
  qryCliente.Open;

  Result :=
    TFunctionFuncoesFaturamento.
      fGetTipoAbfCliente(ACodigoCliente,
                         qryCliente.FieldByName('FISJUR').AsString,
                         AInscricao,
                         AConsumidor,
                         qryCliente.FieldByName('CODATI').AsString,
                         qryCliente.FieldByName('PRORUR').AsString,
                         qryCliente.FieldByName('MICEMP').AsString,
                         qryCliente.FieldByName('REGTRI').AsString,
                         '',
                         IIF(AClienteIndustria, 'S', 'N'),
                         LCodigoClienteFilial,
                         AAtividadeConstrutora);

  FreeAndNil(qryCliente);
end;

function TGerarTesteIcmsEfetivo.fGerarTesteIcmsEfetivo(const ADados: OleVariant): Boolean;
Var
  LDados                          : TUniClientDataSet;
  LCasosTestesLog                 : ICasosTestesLog;
  LResultadoComparacao            : TResultadoComparacao;
  LParametrosCalculoIcmsEfetivo   : IParametrosServicoIcmsEfetivo;
  LResultadoMatrizIcmsEfetivo     : TMatrizFechamentoIcmsEfetivo;
  LResultadoCalculoIcmsEfetivo    : IResultadoServicosClasseIcmsEfetivo;
  LResultadoCalculoIcmsEfetivoLog : IResultadoCalculoIcmsEfetivo;
  LCodigoAtividade                : String;
  LCodigoAtividadeBD              : String;
  LAtividadeConstrutora           : Boolean;
  LClienteIndustria               : Boolean;
  LTipoAbf                        : String;
begin
  Result := True;

  LCasosTestesLog := TCasosTestesLog.New();

  LDados := TUniClientDataSet.Create(Nil);


  Try
    untFuncoesTintaDeMaquinaBpl.RetornarAutcomTintaDll;
  except
    ShowMessage('Erro ao tentar carregar o AutcomTinta.DLL!!!');
  end;


  Try
    LDados.Data := ADados;
    LDados.Open;
    LDados.First;

    Try
      While Not LDados.Eof Do
      Begin
        if (ValidarPararProcessamento) then
          Break;

        frmModulo.IncrementarRegistrosProcessados;

        pExecutarProgresso(LDados.RecordCount, LDados.RecNo);

        if (LDados.FieldByName('DET_NUMDOC').IsNull) then
        Begin
          frmModulo.IncrementarRegistrosProcessadosIgnorados;
          LDados.Next;
          Continue;
        End;

        LClienteIndustria :=
          ValidarClienteIndustria(LDados.FieldByName('AUX_TPOPER').AsString,
                                  LDados.FieldByName('CLI_INDUST').AsString);

        LParametrosCalculoIcmsEfetivo :=
          TParametrosServicoIcmsEfetivo.New
            .MatItensIcmsEfetivo(RetornarMatrizItens(LDados))
            .VendaPresencial(LDados.FieldByName('AUX_VENPRE').AsString = 'S')
            .CodigoDoCliente(LDados.FieldByName('DETITE_CODCLI').AsString)
            .OpcaoDoDocumento(LDados.FieldByName('AUX_OPCDOC').AsString)
            .CodigoDaEmpresa(LDados.FieldByName('DET_CODEMP').AsString)
            .CodigoDoFornecedor(LDados.FieldByName('DET_CODFOR').AsString)
            .ClienteConsumidorFinal(LDados.FieldByName('GER_CONSUM').AsString = 'S')
            .SequencialEnderecoEntrega(LDados.FieldByName('SEQUENCIAL_ENDERECO').AsString)
            .NotaComplementoFornecedor(LDados.FieldByName('AUX_OPCDOC').AsString = 'OF')
            .EspecieDocumento(LDados.FieldByName('DET_ESPDOC').AsString)
            .TipoOperacaoPedidoVenda(LDados.FieldByName('FGO_TIPOPE').AsString)
            .CalcularSatEcf(false)
            .UtilizaSat(false)
            .NotaEspecialFornecedor((LDados.FieldByName('AUX_OPCDOC').AsString = 'NE') And
                                    (LDados.FieldByName('DET_TIP_FC').AsString = 'F'))
            .BaixaDeEntregaFutura(LDados.FieldByName('AUX_OPCDOC').AsString = 'BF')
            .GerandoCasosTestes(true)
            .ClienteIndustria(LClienteIndustria)
            .ClienteComercializacao(LDados.FieldByName('CLI_INDCOM').AsString = 'C')
            .ParametrosClienteConsumidor(ParametrosClienteConsumidor(LDados));

        LResultadoCalculoIcmsEfetivo :=
          GetFaturamentoImpostosService.IcmsEfetivo.CalcularValorIcmsEfetivo(LParametrosCalculoIcmsEfetivo);

        LResultadoMatrizIcmsEfetivo := LResultadoCalculoIcmsEfetivo.ResultadoCalculoIcmsEfetivo;

        LResultadoComparacao := rcoFalse;

        if ((LResultadoMatrizIcmsEfetivo[0].strNotUlt = LDados.FieldByName('DET_NOTULT').AsString) And
            (CompararValores(LResultadoMatrizIcmsEfetivo[0].fltPICMEF , LDados.FieldByName('DET_PICMEF').AsFloat))And
            (CompararValores(LResultadoMatrizIcmsEfetivo[0].fltBICMEF , LDados.FieldByName('DET_BICMEF').AsFloat))And
            (CompararValores(LResultadoMatrizIcmsEfetivo[0].fltAICMEF , LDados.FieldByName('DET_AICMEF').AsFloat))And
            (CompararValores(LResultadoMatrizIcmsEfetivo[0].fltVICMEF , LDados.FieldByName('DET_VICMEF').AsFloat))And
            (CompararValores(LResultadoMatrizIcmsEfetivo[0].fltBSTANT , LDados.FieldByName('DET_BSTANT').AsFloat))And
            (CompararValores(LResultadoMatrizIcmsEfetivo[0].fltVSTANT , LDados.FieldByName('DET_VSTANT').AsFloat))) Then
        begin
          LResultadoComparacao := rcoTrue;
        end;

        LResultadoCalculoIcmsEfetivoLog :=
          TResultadoCalculoIcmsEfetivo.New
            .PercentualReducaoBaseCalcEfetivaItem(LResultadoMatrizIcmsEfetivo[0].fltPICMEF)
            .ValorBaseCalculoEfetivaItem(LResultadoMatrizIcmsEfetivo[0].fltBICMEF)
            .ValorIcmsEfetivaItem(LResultadoMatrizIcmsEfetivo[0].fltVICMEF)
            .AliquotaIcmsEfetivaItem(LResultadoMatrizIcmsEfetivo[0].fltAICMEF)
            .ValorBaseCalculoIcmsStRetidoItem(LResultadoMatrizIcmsEfetivo[0].fltBSTANT)
            .ValorIcmsStRetidoItem(LResultadoMatrizIcmsEfetivo[0].fltVSTANT)
            .ValorIcmsSubstitutoItem(LResultadoMatrizIcmsEfetivo[0].fltSICMEF);

        SetarResultadosComparacao(LResultadoCalculoIcmsEfetivoLog);

        SetarParametrosComparacao(
          TParametrosComparacaoIcmsEfetivo.New()
            .PercentualReducaoBaseCalcEfetivaItem(LDados.FieldByName('DET_PICMEF').AsFloat)
            .ValorBaseCalculoEfetivaItem(LDados.FieldByName('DET_BICMEF').AsFloat)
            .ValorIcmsEfetivaItem(LDados.FieldByName('DET_VICMEF').AsFloat)
            .AliquotaIcmsEfetivaItem(LDados.FieldByName('DET_AICMEF').AsFloat)
            .ValorBaseCalculoIcmsStRetidoItem(LDados.FieldByName('DET_BSTANT').AsFloat)
            .ValorIcmsStRetidoItem(LDados.FieldByName('DET_VSTANT').AsFloat));

        pGerarLogTesteUnitario((LResultadoCalculoIcmsEfetivo.ParametrosCalculoIcmsEfetivo as TObject), (LResultadoCalculoIcmsEfetivoLog as TObject), Nil, 'CalcularValorIcmsEfetivo');

        LCodigoAtividade := LDados.FieldByName('CLI_CODATI').AsString;

        LCodigoAtividadeBD :=
            fCampoTabela('ATI_CODATI', 'CLIATI', ['ATI_CODATI', 'ATI_CODEMP'], [LCodigoAtividade, LDados.FieldByName('DET_CODEMP').AsString], False);

        LAtividadeConstrutora :=
          TFunctionFuncoesFaturamento.
            fAtividadeConstrutora(LCodigoAtividade,
                                  LCodigoAtividadeBD);

        LTipoAbf :=
          fGetTipoAbfCliente(LDados.FieldByName('DETITE_CODCLI').AsString,
                             LDados.FieldByName('GER_CONSUM').AsString,
                             LDados.FieldByName('GER_IESCON').AsString,
                             LClienteIndustria,
                             LAtividadeConstrutora);

        LCasosTestesLog.Add(
          TParametrosCasosTestesLog.New()
            .ResultadoComparacao(LResultadoComparacao)
            .RetornarNomeOperacao('CALCULO_ICMS_EFETIVO_')
            .NumeroDoDocumento(LDados.FieldByName('DETITE_NUMDOC').AsString)
            .EspecieDoDocumento(LDados.FieldByName('DETITE_ESPDOC').AsString)
            .CodigoDaEmpresa(LDados.FieldByName('DETITE_CODEMP').AsString)
            .CodigoDoItem(LResultadoMatrizIcmsEfetivo[0].strCodIte)
            .CodigoDoCliente(LDados.FieldByName('DETITE_CODCLI').AsString)
            .OpcaoDocumento(LDados.FieldByName('AUX_OPCDOC').AsString)
            .DataEntrada(LDados.FieldByName('DETITE_DTAENT').AsDateTime)
            .CodigoFiscal(LDados.FieldByName('ITE_CODFIS').AsString)
            .ClassificacaoFiscal(LDados.FieldByName('DET_CLAFIS').AsString)
            .EstadoDoDocumento(LDados.FieldByName('ITE_ESTADO').AsString)
            .IdentificacaoDoProduto(LDados.FieldByName('DET_IDEPRO').AsString)
            .TipoDaAbreviacaoFiscal(LTipoAbf)
            .Log(fGetVariavelLogIcmsEfetivo));

        pLimparVariaveisTesteUnitario;

        LDados.Next;
      End;

      LCasosTestesLog.GerarLog('IcmsEfetivo');

    Except
      On E : Exception do
        ShowMessage('Documento:'+ LDados.FieldByName('DETITE_NUMDOC').AsString +
                    '| Especie:'+ LDados.FieldByName('DETITE_ESPDOC').AsString +
                    '| Item:'+    LDados.FieldByName('DETITE_CODITE').AsString +
                    '| Empresa:'+ LDados.FieldByName('DETITE_CODEMP').AsString + #13#10 + E.Message);
    End;
  Finally
    FreeAndNil(LDados);
  End;
end;

class function TGerarTesteIcmsEfetivo.New: IGerarTeste;
begin
  Result := Self.Create;
end;

function TGerarTesteIcmsEfetivo.RetornarEstadoCliente(Const AEstadoClienteConsumidor, AEstadoCliente : String): String;
begin
  Result := AEstadoClienteConsumidor;

  If Not objFloatUtils.fEmptyStr(Result) Then
    Exit;

  Result := AEstadoCliente;
end;

function TConsultaIcmsEfetivo.RetornarColunaAUX_CODATI(
  const ADoctosCOnfirmacao: boolean): string;
begin
  result := ' "" AS AUX_CODATI, ';

  if not (objCore.fCampoExiste('AUXMOV', 'AUX_CODATI')) then
    Exit;

  if (ADoctosCOnfirmacao) then
    Exit;

  result := ' AUXMOV.AUX_CODATI, ';
end;



function TConsultaIcmsEfetivo.RetornarColunaAUX_VENPRE(
  const ADoctosCOnfirmacao: boolean): string;
begin
  result := ' "" AS AUX_VENPRE, ';

  if not (objCore.fCampoExiste('AUXMOV', 'AUX_VENPRE')) then
    Exit;

  if (ADoctosCOnfirmacao) then
    Exit;

  result := ' AUXMOV.AUX_VENPRE, ';

end;


function TGerarTesteIcmsEfetivo.ParametrosClienteConsumidor(Const ADados : TUniClientDataSet): IParametrosFaturamentoImpostosClienteConsumidor;
Var
  LEstadoCliente : String;
begin
  LEstadoCliente :=
    RetornarEstadoCliente( ADados.FieldByName('GER_ESTCON').AsString,
                           ADados.FieldByName('ITE_ESTADO').AsString );

  Result :=
    TParametrosFaturamentoImpostosClienteConsumidor.New
      .ClienteEstado(LEstadoCliente)
      .ClienteInscricaoEstadual(ADados.FieldByName('GER_IESCON').AsString)
      .ClienteAtividade(ADados.FieldByName('CLI_CODATI').AsString)
      .CalcularDescontoIcmsOrgaoPublico(
        TFunctionFuncoesFaturamento.
          ValidarDescontoDeICMSOrgaoPublico(
            ADados.FieldByName('AUX_OPCDOC').AsString,
            ADados.FieldByName('CLI_CALICM').AsString) = 'S')
      .ClienteFisicoOuJuridico(
        TFunctionFuncoesFaturamento
          .RetornarClienteFisicoOuJuridico(ADados.FieldByName('GER_CGCCPF').AsInteger));
end;

function TGerarTesteIcmsEfetivo.RetornarOpcoesDeItemNotaEspiritoSanto(
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

function TGerarTesteIcmsEfetivo.RetornarMatrizItens(
  const ADados: TUniClientDataSet): TMatrizFechamentoIcmsEfetivo;
Var
  LMatrizItens : TMatrizFechamentoIcmsEfetivo;
begin
  SetLength(LMatrizItens, 0);
  SetLength(LMatrizItens, 1);

  LMatrizItens[0].strCodFis := ADados.FieldByName('ITE_CODFIS').AsString;
  LMatrizItens[0].strCodIte := ADados.FieldByName('DETITE_CODITE').AsString;
  LMatrizItens[0].strClaFis := ADados.FieldByName('DET_CLAFIS').AsString;
  LMatrizItens[0].fltQtdIte := ADados.FieldByName('ITE_QTDITE').AsFloat;
  LMatrizItens[0].fltTotIte := ADados.FieldByName('ITE_TOTITE').AsFloat;
  LMatrizItens[0].fltAlqIcm := 0;
  LMatrizItens[0].fltDesEsp := ADados.FieldByName('DET_DESESP').AsFloat;
  LMatrizItens[0].fltValFre := ADados.FieldByName('DET_TOTFRE').AsFloat;
  LMatrizItens[0].fltDesAce := ADados.FieldByName('DET_DESACE').AsFloat;
  LMatrizItens[0].opcINFesp := RetornarOpcoesDeItemNotaEspiritoSanto(ADados.FieldByName('DET_CLAFIS').AsString);
  LMatrizItens[0].fltTotGerIteParaCalcIcmEfetivo := 0;
  LMatrizItens[0].fltAlqIcmIntParaCalcIcmEfetivo := 0;
  LMatrizItens[0].strIdePro := ADados.FieldByName('DET_IDEPRO').AsString;

  Result := LMatrizItens;
end;


function TGerarTesteIcmsEfetivo.ValidarClienteIndustria(const ATipoDeOperacao,
  AClienteIndustriaCadastro: string): boolean;
begin
  result := AClienteIndustriaCadastro = 'S';

  if (not objConfiguracoes.fGetValorConfiguracao('USOREV', varBoolean)) then
    Exit;

  result := (ATipoDeOperacao = INDUSTRIALIZACAO);
end;

end.
