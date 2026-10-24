unit untSQLItensPedido;

interface

uses Shared.Functions.Types;

type
  TInputSQLItensPedido = record
    blnHerancaOrcamentoPedido: Boolean;
    blnCarregarClassificacao : Boolean;
    strEspOrc : String;
    blnWMS : Boolean;
    blnExpedi : Boolean;
    strEmpCfg : String;
    blnVazio : Boolean;
    strIncFdo : String;
    strLeftJoinCadLotItensPedido: String;
    blnBaiEntFut: Boolean;
    strOpcDoc: String;
    blnCliFil: Boolean;
    strNumRom: String;
    blnOrigemTelaDesmembrarPedidoConfiguracaoDPDAFPLigada: Boolean;
    strEmpPrd: String;
    blnAlteraOrcamentoOutraLoja: Boolean;
    blnEmpFat: Boolean;
    OpcItensNFespTinta : TOpcItensNFespTinta;
    strCodVen: String;
    blnPedidoTransferenciaSolicitacaoEntreLojas: Boolean;
  End;

  TSQLItensPedido = class
  private
    FInput: TInputSQLItensPedido;
    function fGetOrderBy(const strOrdPdv, strOrdOrc: String): String;
    function fVariasChapasPorLote: Boolean;
    function fFatDorCampos: String;
    function fUsaCampoDoLoteDefinidoNoPedido: Boolean;
    function fSQLCampoLotePedido: String;
    function fSugestaoEntregaQuandoVazio: String;
    function fQuantidadeDeChapas: String;
    function fQuantidadeDoItem: String;
    function fQuantidadeDoItemBaixada: String;
    function fQuantidadeOriginalDoItem: String;
    function fComissaoTabelaPreco: String;
    function fEntraCdsVenda: String;
    function fEntraCdsBaixados: String;
    function fUsaDocumentoEmSuaFormaOriginal: Boolean;
    function fClassificacaoFiscal: String;
    function fAlteraPercentualDeComissao: String;
    function fEntregaRetira: String;
    function fEntregaRetiraDescricao: String;
    function fEmpresaDeProducaoDeTinta: String;
    function fQuantidadeBaixadaCdsBaixados: String;
    function fQuantidadeBaixadaCdsVenda: String;
    function fEmpresaDoItem: String;
    function fLoteDoItem: String;
    function fLeftJoinVariasChapasPorLote: String;
    function fLocalDeRetiraDoItem: String;
    function fItemDivisivel: String;
    function fGetItensDeControleInterno: String;
    function fIndustrializacaoRevenda: String;
    function fNotaEspecialTinta: String;
    function fOpcaoAbastecimentoItem: String;
    function fExibeDescontoCondicaoCampoDescontoItem: String;
    function fQuantidadeEstruturaItem_ITE: String;
    function fQuantidadeEstruturaItem_BAI: String;
    function fQuantidadeTotalEntregaFuturaItemSemLote: String;
    function fCodigoVendedorItem: String;
    function fSQLClienteConsumidor: String;
    function fEstadoCliente: String;
    function fInscricaoEstadualCliente: String;
    function fEhExpedicaoPorRomaneio(): Boolean;
    function fGetWhereSomenteItensNoRomaneio: String;
  public
    function fGetSQL: String;
    constructor Create(const AInput: TInputSQLItensPedido);
  End;

implementation

{ TSQLItensPedido }

uses untFuncoesSimples, Uni, SysUtils, untTPickingCheckOut, StrUtils, untFuncFatTypes;

constructor TSQLItensPedido.Create(const AInput: TInputSQLItensPedido);
begin
  FInput := AInput;
end;

function TSQLItensPedido.fAlteraPercentualDeComissao: String;
begin
  If (Not fCfgSis('ALTPCO', VarBoolean)) Then
    Result := '"N"'
  Else
    Result := 'IF(EXTDOR.FDO_ALTPCO = "", "N", EXTDOR.FDO_ALTPCO)';
end;

function TSQLItensPedido.fClassificacaoFiscal: String;
begin
  If (FInput.blnCarregarClassificacao) Then
    Result := 'FDO_CLAFIS'
  Else
    Result := 'CAST("" AS CHAR(4))';
end;

function TSQLItensPedido.fCodigoVendedorItem: String;
begin
  Result := Format('IF(IFNULL(FDO_CODVEN, "") = "", %s, FDO_CODVEN)', [QuotedStr(FInput.strCodVen)]);
end;

function TSQLItensPedido.fComissaoTabelaPreco: String;
begin
  Result := EmptyStr;
  If fCfgSis('PCMPRO') = '1' Then
    Result := Result + '0.00'
  Else
  Begin
    Result := Result + 'IFNULL((CASE IF(IFNULL(FDO_TABPRE, "") = "", FATGOR.FGO_TABPRE, FDO_TABPRE) ';
    Result := Result + '          WHEN "1" THEN G.ITE_COMTB1 ';
    Result := Result + '          WHEN "2" THEN G.ITE_COMTB2 ';
    Result := Result + '          WHEN "3" THEN G.ITE_COMTB3 ';
    Result := Result + '          WHEN "4" THEN G.ITE_COMTB4 ';
    Result := Result + '          WHEN "5" THEN G.ITE_COMTB5 ';
    Result := Result + '          WHEN "6" THEN G.ITE_COMTB6 ';
    Result := Result + '          WHEN "7" THEN G.ITE_COMTB7 ';
    Result := Result + '        END ), 0)';
  End;
end;

function TSQLItensPedido.fEmpresaDeProducaoDeTinta: String;
begin
  If fEmptyStr(FInput.strEmpPrd) Then
    Result := 'FDO_EMPPRD'
  Else
    Result := Format('IF(IFNULL(FDO_EMPPRD,"") = "", %s, FDO_EMPPRD)', [QuotedStr(FInput.strEmpPrd)]);
end;

function TSQLItensPedido.fEmpresaDoItem: String;
begin
  If (FInput.blnAlteraOrcamentoOutraLoja) And (Not FInput.blnEmpFat) Then
    Result := QuotedStr(VS_strCodEmp)
  Else
  Begin
    If (FInput.blnEmpFat) Then
      Result := 'IF(IFNULL(FDO_EMPITE,"") = "", FDO_CODEMP, FDO_EMPITE)'
    Else
      Result := Format('IF(IFNULL(FDO_EMPITE,"") = "", %s, FDO_EMPITE)', [QuotedStr(VS_strCodEmp)]);
  End;
end;

function TSQLItensPedido.fEntraCdsBaixados: String;
begin
  If fUsaDocumentoEmSuaFormaOriginal Then
    Result := 'FALSE'
  Else
    Result := 'IF(' + fQuantidadeDoItemBaixada + ' > 0, TRUE, FALSE)';
end;

function TSQLItensPedido.fEntraCdsVenda: String;
begin
  If fUsaDocumentoEmSuaFormaOriginal Then
    Result := 'TRUE'
  Else
    Result := 'IF(FDO_JAFATU = 0, TRUE, FALSE)';
end;

function TSQLItensPedido.fEntregaRetira: String;
begin
  Result := Format('IF(EXTDOR.FDO_ENTRET = "", %s, EXTDOR.FDO_ENTRET)', [QuotedStr(fSugestaoEntregaQuandoVazio)]);
end;

function TSQLItensPedido.fEntregaRetiraDescricao: String;
begin
  Result := 'IF(' + fEntregaRetira + ' = "E", "ENT", "RET")';
end;

function TSQLItensPedido.fInscricaoEstadualCliente: String;
begin
  Result := Format('IF(%s, FGO_IESCON, CLI_I_E_S_)', [fSQLClienteConsumidor]);
end;

function TSQLItensPedido.fEstadoCliente: String;
begin
  Result := Format('IF(%s, FGO_ESTCON, CIDCLI.CID_ESTADO)', [fSQLClienteConsumidor]);
end;

function TSQLItensPedido.fExibeDescontoCondicaoCampoDescontoItem: String;
begin
  Result := 'FALSE';
  If fDestacarDescontoDaCondicaoPagamentoNoCampoDescontoDosItensEmPromocao Then
    Result := 'IF(FDO_PROMOC = "S", IF(FDO_DESCON > 0, TRUE, FALSE), FALSE)';
end;

function TSQLItensPedido.fFatDorCampos: String;
  Var
    qryAux: TUniQuery;
Begin
  Result := '';
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('DESC FATDOR');
    qryAux.Open;
    qryAux.First;
    While Not qryAux.EOF Do
    Begin
      If (qryAux.FieldByName('Field').AsString = 'FDO_QTDITE') And
         (FInput.blnExpedi) Then
        Result := Result + fSQLQtde('FATDOR') + ' AS FDO_QTDITE, '
      Else
        Result := Result + ' FATDOR.' + qryAux.FieldByName('Field').AsString + ', ';

      qryAux.Next;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TSQLItensPedido.fGetSQL: String;
  Var
    strSQL: String;
    strOrdPdv: String;
    strOrdOrc: String;
begin
  strOrdPdv := fCfgSis('ORDPDV', VarString, FInput.strEmpCfg);
  strOrdOrc := fCfgSis('ORDORC', VarString, FInput.strEmpCfg);

  strSQL := EmptyStr;
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '    "S" AS ITE_ITENOV, ';
  strSQL := strSQL + '    0 AS PED_SEQENC, ';
  strSQL := strSQL + '    0 AS ITE_ORDITE, ';

  If (FInput.blnHerancaOrcamentoPedido) Then
  Begin
    strSQL := strSQL + '  CAST("" AS CHAR(3)) AS FDO_OPESEP, ';
    strSQL := strSQL + '  CAST("" AS CHAR(3)) AS FDO_OPEEXP, ';
    strSQL := strSQL + '  CAST("" AS CHAR(3)) AS ITE_CONEXP, ';
    strSQL := strSQL + '  CAST("" AS CHAR(6)) AS FDO_CODCMG, ';
    strSQL := strSQL + '  FALSE AS ITE_JAFATU, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(2)) AS ITE_TIPFAT, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(12)) AS ITE_NUMFAT, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(3)) AS ITE_EMPFAT, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(3)) AS ITE_VENFAT, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(3)) AS ITE_CNDFAT, ';
    strSQL := strSQL + '  CAST(NULL AS DATE) AS ITE_DTAFAT, ';
    strSQL := strSQL + '  0.00 AS ITE_VALFAT, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(12)) AS ITE_NUMORC, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(2)) AS ITE_ESPORC, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(3)) AS ITE_EMPORC, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(20)) AS ITE_SEQDET, ';
    strSQL := strSQL + '  CAST("" AS CHAR(3)) AS FDO_SEPEXP, ';
    strSQL := strSQL + '  0.00 AS FDO_QTDEXP, ';
    strSQL := strSQL + '  0.00 AS FDO_QTDSEP, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(3)) AS FDO_OPBXSE, ';
    strSQL := strSQL + '  CAST(NULL AS DATE) AS FDO_DTBXSE, ';
    strSQL := strSQL + '  CAST(NULL AS TIME) AS FDO_HRBXSE, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(20)) AS FDO_SEQRCD, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(3)) AS FDO_OPSEEX, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(3)) AS FDO_EMBEXP, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(50)) AS FDO_OBSEXP, ';
  End
  Else
  Begin
    strSQL := strSQL + '  EXTDOR.FDO_OPESEP, ';
    strSQL := strSQL + '  EXTDOR.FDO_OPEEXP, ';
    strSQL := strSQL + '  EXTDOR.FDO_OPEEXP AS ITE_CONEXP, ';
    strSQL := strSQL + '  EXTDOR.FDO_CODCMG, ';
    strSQL := strSQL + '  IF(FDO_JAFATU > 0, TRUE, FALSE) AS ITE_JAFATU, ';
    strSQL := strSQL + '  FDO_TIPFAT AS ITE_TIPFAT, ';
    strSQL := strSQL + '  FDO_NUMFAT AS ITE_NUMFAT, ';
    strSQL := strSQL + '  FDO_EMPFAT AS ITE_EMPFAT, ';
    strSQL := strSQL + '  FDO_VENFAT AS ITE_VENFAT, ';
    strSQL := strSQL + '  FDO_CNDFAT AS ITE_CNDFAT, ';
    strSQL := strSQL + '  FDO_DTAFAT AS ITE_DTAFAT, ';
    strSQL := strSQL + '  FDO_VALFAT AS ITE_VALFAT, ';
    strSQL := strSQL + '  FDO_NUMDOC AS ITE_NUMORC, ';
    strSQL := strSQL + '  FDO_ESPDOC AS ITE_ESPORC, ';
    strSQL := strSQL + '  FDO_CODEMP AS ITE_EMPORC, ';
    strSQL := strSQL + '  FATDOR.AUTOINCREM AS ITE_SEQDET, ';
    strSQL := strSQL + '  EXTDOR.FDO_SEPEXP, ';
    strSQL := strSQL + '  EXTDOR.FDO_QTDEXP, ';
    strSQL := strSQL + '  IFNULL(EXTDOR.FDO_QTDSEP, 0) AS FDO_QTDSEP, ';
    strSQL := strSQL + '  EXTDOR.FDO_OPBXSE, ';
    strSQL := strSQL + '  EXTDOR.FDO_DTBXSE, ';
    strSQL := strSQL + '  EXTDOR.FDO_HRBXSE, ';
    strSQL := strSQL + '  EXTDOR.FDO_SEQRCD, ';
    strSQL := strSQL + '  EXTDOR.FDO_OPSEEX, ';
    strSQL := strSQL + '  EXTDOR.FDO_EMBEXP, ';
    strSQL := strSQL + '  EXTDOR.FDO_OBSEXP, ';
  End;

  strSQL := strSQL + '  FATDOR.AUTOINCREM AS ITE_CHVUNI, ';
  strSQL := strSQL + '  IF(LOCATE("ITEM ESPECIAL", I.ITE_DESITE) > 0, I.ITE_DESITE, FDO_DESCRI) AS ITE_DESORI, ';
  strSQL := strSQL + '  IF(EXTDOR.FDO_UNIVIS = 0, 0.00, EXTDOR.FDO_TAXJUR) AS ITE_TAXJUR, ';
  strSQL := strSQL + '  IF(EXTDOR.FDO_UNIVIS = 0, FDO_UNIORI, EXTDOR.FDO_UNIVIS) AS ITE_UNIVIS, ';
  strSQL := strSQL + '  FDO_UNIDAD AS ITE_UNIDAD, ';
  strSQL := strSQL + '  FDO_UNIDAD AS ITE_CODUNI, ';

  strSQL := strSQL + ' "S" AS ITE_ENTSAI, ';
  strSQL := strSQL + ' "S" AS ITE_RATDES, ';
  strSQL := strSQL + ' "S" AS ITE_RESERV, ';
  strSQL := strSQL + ' "N" AS ITE_LIBUNI, ';
  strSQL := strSQL + ' "N" AS ITE_PIGBAS, ';
  strSQL := strSQL + ' "N" AS ITE_LIBEST, ';
  strSQL := strSQL + ' "N" AS ITE_FDOITERECALC, ';
  strSQL := strSQL + ' FGO_UPSEML AS ITE_UPSEML, ';
  strSQL := strSQL + ' IF(FGO_UPSEML = "S" AND (IFNULL(FGO_EMPEPE, "") <> ""), FGO_EMPEPE, FGO_EMPEXP) FGO_EMPEXP, ';
  strSQL := strSQL + ' "N" AS ITE_ALTERA, ';
  strSQL := strSQL + ' IF(EXTDOR.FDO_ATIVAC = "", "N", EXTDOR.FDO_ATIVAC) AS ITE_ATIVAC, ';
  strSQL := strSQL + ' "N" AS ITE_INSERE, ';
  strSQL := strSQL + ' 0 AS ITE_ESCPRD, ';
  strSQL := strSQL + ' FALSE AS ITE_ITETRA, ';

  strSQL := strSQL + ' (SELECT COUNT(*) FROM ITEEMB WHERE ITEEMB.ITB_CODITE = FDO_CODITE AND ITEEMB.ITB_CODEMP = ' + QuotedStr(VS_strCodEmp) + ') AS ITE_CNTEMB, ';
  strSQL := strSQL + ' IF(FDO_DESMAX <> 0, FDO_DESMAX, G.ITE_DESMAX) AS PED_DESMAX, ';
  strSQL := strSQL + ' IF(LOCATE("ITEM ESPECIAL", I.ITE_DESITE) > 0 AND FDO_ESPDOC = "OR", TRI_NCMTIN, I.ITE_CLAIPI) AS PED_CLAIPI, ';
  strSQL := strSQL + ' IF(FDO_QTDEMB > 0, FDO_PREEMB / FDO_QTDEMB, 0.00) AS ITE_UNIEMB, ';
  strSQL := strSQL + ' FDO_CODITE AS PED_ITEABF, ';
  strSQL := strSQL + ' IF(IFNULL(FDO_SEQTIN, "") = "", "", "2") AS ITE_TIPTIN, ';
  strSQL := strSQL + ' CADFOR.FOR_PERCOM, ';
  strSQL := strSQL + ' CADMAR.MAR_DESMAR, ';
  strSQL := strSQL + ' IF(FDO_PROACA = "S", TRUE, FALSE) AS ITE_PROACA, ';
  strSQL := strSQL + ' IF(FDO_BXSBIT = "S", "S", "N") AS ITE_BXSBIT,    ';
  strSQL := strSQL + ' "NOR" AS ITE_IDEDEV, ';
  strSQL := strSQL + ' IF(EXTDOR.FDO_PEGOU_ = "S", EXTDOR.FDO_PEGOU_, " ") AS ITE_VPEGOU, ';
  strSQL := strSQL + ' IF(EXTDOR.FDO_ATIVAC = "", "N", EXTDOR.FDO_ATIVAC) AS FDO_ATIVAC, ';

  strSQL := strSQL + fEntregaRetira + ' AS ITE_ENTRET, ';
  strSQL := strSQL + fEntregaRetiraDescricao + ' AS ITE_ENTDSC, ';
  strSQL := strSQL + fQuantidadeDoItem + ' AS ITE_QTDITE, ';
  strSQL := strSQL + fQuantidadeDoItem + ' AS ITE_QTDPRI_ITE, ';
  strSQL := strSQL + fQuantidadeDoItemBaixada + ' AS ITE_QTDBAI, ';
  strSQL := strSQL + fQuantidadeDoItemBaixada + ' AS ITE_QTDPRI_BAI, ';
  strSQL := strSQL + fQuantidadeOriginalDoItem + ' AS ITE_QTDORI, ';
  strSQL := strSQL + fQuantidadeDeChapas + ' AS ITE_QTDCHA, ';
  strSQL := strSQL + fComissaoTabelaPreco + ' AS ITE_COMTBL, ';
  strSQL := strSQL + fEntraCdsBaixados + ' AS ITE_BAIXADOS, ';
  strSQL := strSQL + fEntraCdsVenda + ' AS ITE_CDSVENDA, ';
  strSQL := strSQL + fClassificacaoFiscal + ' AS ITE_CLAFIS, ';
  strSQL := strSQL + fAlteraPercentualDeComissao + ' AS FDO_ALTPCO, ';
  strSQL := strSQL + fEmpresaDeProducaoDeTinta + ' AS ITE_EMPPRD, ';
  strSQL := strSQL + fQuantidadeBaixadaCdsBaixados + ' AS ITE_QTDBAI_CDSBAIXADOS, ';
  strSQL := strSQL + fQuantidadeBaixadaCdsVenda + ' AS ITE_QTDBAI_CDSVENDA, ';
  strSQL := strSQL + fEmpresaDoItem + ' AS ITE_EMPITE, ';
  strSQL := strSQL + fLoteDoItem + ' AS LOT_NUMLOT, ';
  strSQL := strSQL + fLocalDeRetiraDoItem + ' AS ITE_LOCRET, ';
  strSQL := strSQL + fItemDivisivel + ' AS ITE_NOTESP, ';
  strSQL := strSQL + fIndustrializacaoRevenda + ' AS ITE_INDREV, ';
  strSQL := strSQL + fNotaEspecialTinta + ' AS ITE_NFESTI, ';
  strSQL := strSQL + fOpcaoAbastecimentoItem + ' AS ITE_OPCABS, ';
  strSQL := strSQL + fExibeDescontoCondicaoCampoDescontoItem + ' AS ITE_PROCND, ';
  strSQL := strSQL + fQuantidadeEstruturaItem_ITE + ' AS ITE_ESTQTD_ITE, ';
  strSQL := strSQL + fQuantidadeEstruturaItem_BAI + ' AS ITE_ESTQTD_BAI, ';
  strSQL := strSQL + fQuantidadeTotalEntregaFuturaItemSemLote + ' AS QTDPEN_ENTFUT, ';
  strSQL := strSQL + fCodigoVendedorItem + ' AS ITE_CODVEN, ';
  strSQL := strSQL + ' VENITE.OPE_NOMOPE AS ITE_NOMVEN, ';

  strSQL := strSQL + ' G.ITE_PREULT * ' + fQuantidadeDoItemBaixada + ' AS ITE_TOTULT_QTDBAI, ';
  strSQL := strSQL + ' G.ITE_PREULT * ' + fQuantidadeDoItem + ' AS ITE_TOTULT_QTDITE, ';
  strSQL := strSQL + ' G.ITE_IMPULT * ' + fQuantidadeDoItemBaixada + ' AS ITE_TOTIMP_QTDBAI, ';
  strSQL := strSQL + ' G.ITE_IMPULT * ' + fQuantidadeDoItem + ' AS ITE_TOTIMP_QTDITE, ';

  strSQL := strSQL + ' DORICD.ICD_VALDES AS ITE_VDIFAL, ';
  strSQL := strSQL + ' DORICD.ICD_PERFCP, ';
  strSQL := strSQL + ' FATDOR.FDO_CODFIS AS ABF_CODFIS, ';
  strSQL := strSQL + ' FATDOR.FDO_ALQIPI AS ITE_ALQIPI, ';

  strSQL := strSQL + ' CLIPRO.CLI_COD_NF AS ITE_COD_NF, ';
  strSQL := strSQL + ' CLIPRO.CLI_CODBAR AS ITE_CLIBAR, ';
  strSQL := strSQL + ' CLIPRO.CLI_DES_NF AS ITE_DES_NF, ';

  strSQL := strSQL + ' FATGOR.FGO_VLRCON, ';
  strSQL := strSQL + ' FATGOR.FGO_PANUTI, ';
  strSQL := strSQL + ' FATGOR.FGO_DESESP, ';
  strSQL := strSQL + ' FATGOR.FGO_TOTFRE, ';
  strSQL := strSQL + ' IF(EXTGOR.FGO_EDIPES = "S", TRUE, FALSE) AS ITE_EDIPES, ';

  strSQL := strSQL + ' CADUNI_CADITE.UNI_ITEFRA, ';
  strSQL := strSQL + ' IF(CADUNI_CADITE.UNI_KILLIT = "L" OR CADUNI_CADITE.UNI_KILLIT = "", CADUNI_CADITE.UNI_PESLIT, 0) AS UNI_LITRAG, ';
  strSQL := strSQL + ' CAST((SELECT GROUP_CONCAT(FDO_CODMEC) FROM MECDOR WHERE FATDOR.AUTOINCREM = MECDOR.FDO_SEQFDO) AS CHAR(255)) AS ITE_CODMEC, ';

  strSQL := strSQL + '   FDO_CODPRO, ';
  strSQL := strSQL + '   FDO_UNIVIS, ';
  strSQL := strSQL + '   FDO_TAXJUR, ';
  strSQL := strSQL + '   FDO_VAL_RT, ';
  strSQL := strSQL + '   FDO_SOMCOL, ';
  strSQL := strSQL + '   IF( IFNULL(FDO_TABPRE, "") = "", FGO_TABPRE, FDO_TABPRE) AS TABPRE, ';
  strSQL := strSQL + '   FDO_PROMOC AS PROMOC, ';
  strSQL := strSQL + '   GRU_CODGRU, ';
  strSQL := strSQL + '   GRU_PERCOM, ';
  strSQL := strSQL + '   CADUNI_FATDOR.UNI_SIGUNI, ';
  strSQL := strSQL + '   FORTIN.FOR_EMPACA, ';
  strSQL := strSQL + '   IFNULL(FORTIN.FOR_MODDIL, 0)   FOR_MODDIL, ';
  strSQL := strSQL + '   IFNULL(FORTIN.FOR_TEXBAS, "")  FOR_TEXBAS, ';
  strSQL := strSQL + '   IFNULL(FORTIN.FOR_TIPCOR, "")  FOR_TIPCOR, ';
  strSQL := strSQL + '   IFNULL(FORTIN.FOR_ITECOB, "")  FOR_ITECOB, ';
  strSQL := strSQL + '   IFNULL(FORTIN.FOR_CODACA, "")  FOR_CODACA, ';
  strSQL := strSQL + '   IFNULL(FORTIN.FOR_UNIVER, "")  FOR_UNIVER, ';
  strSQL := strSQL + '   IFNULL(FORTIN.FOR_FATACE, 1)   FOR_FATACE, ';
  strSQL := strSQL + '   IFNULL(FORTIN.FOR_CATALI, "")  FOR_CATALI, ';
  strSQL := strSQL + '   IFNULL(LOT_PREVEN,         0)  LOT_PREVEN, ';
  strSQL := strSQL + '   IFNULL(LOT_PRECUS,         0)  LOT_PRECUS, ';
  strSQL := strSQL + '   IF(FDO_EMPFOR IS NULL, 1, 0)   FDO_PODALT, ';
  strSQL := strSQL + '   FDO_EMPFOR, ';
  strSQL := strSQL + '   FDO_NUMCMP, ';
  strSQL := strSQL + '   FDO_NITCMP, ';
  strSQL := strSQL + '   FDO_DTACMP, ';
  strSQL := strSQL + '   FDO_SEQINC, ';
  strSQL := strSQL + '   FDO_ORDITE, ';
  strSQL := strSQL + '   FDO_SEQEST, ';
  strSQL := strSQL + '   FDO_ITEEST, ';
  strSQL := strSQL + '   FDO_UNIEST, ';
  strSQL := strSQL + '   FDO_QTDSBI, ';
  strSQL := strSQL + '   FDO_UNISBI, ';
  strSQL := strSQL + '   FDO_FREMKP, ';
  strSQL := strSQL + '   FDO_COMMKP, ';
  strSQL := strSQL + '   FDO_DTENTR, ';
  strSQL := strSQL + '   FDO_QDENTR, ';
  strSQL := strSQL + '   FDO_LOCRET, ';
  strSQL := strSQL + '   FDO_ENTFUT, ';
  strSQL := strSQL + '   FDO_BAREMB, ';
  strSQL := strSQL + '   FDO_CLIBUS, ';
  strSQL := strSQL + '   FDO_TURENT, ';
  strSQL := strSQL + '   FDO_DESMAX, ';

  If fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
  Begin
    strSQL := strSQL + '  FDO_COMPEC, ';
    strSQL := strSQL + '  FDO_LARPEC, ';
    strSQL := strSQL + '  FDO_ESPPEC, ';

    strSQL := strSQL + '  FDO_APAREL, ';
    strSQL := strSQL + '  FDO_PERAPA, ';
    strSQL := strSQL + '  FDO_BENEFI, ';
    strSQL := strSQL + '  FDO_PERBEN, ';
  End;

  strSQL := strSQL + '  I.ITE_CEREPI, ';
  strSQL := strSQL + '  I.ITE_PROEMB, ';
  strSQL := strSQL + '  I.ITE_APLICA, ';
  strSQL := strSQL + '  I.ITE_INFLAM, ';
  strSQL := strSQL + '  I.ITE_PRDGRU, ';
  strSQL := strSQL + '  I.ITE_USABON, ';
  strSQL := strSQL + '  I.ITE_OBRIBA, ';
  strSQL := strSQL + '  I.ITE_ATICOM, ';
  strSQL := strSQL + '  I.ITE_CLAIPI, ';
  strSQL := strSQL + '  I.ITE_EXCIPI, ';
  strSQL := strSQL + '  I.ITE_CODITE, ';
  strSQL := strSQL + '  I.ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_DESSIM, ';
  strSQL := strSQL + '  I.ITE_DESFAB, ';
  strSQL := strSQL + '  I.ITE_COMLUB, ';
  strSQL := strSQL + '  I.ITE_CODFAB, ';
  strSQL := strSQL + '  I.ITE_CODBAR, ';
  strSQL := strSQL + '  I.ITE_PESOIT, ';
  strSQL := strSQL + '  I.ITE_PESLIQ, ';
  strSQL := strSQL + '  I.ITE_OBRCPF, ';
  strSQL := strSQL + '  I.ITE_EMBALA, ';
  strSQL := strSQL + '  I.ITE_INCPIS, ';
  strSQL := strSQL + '  I.ITE_CODFOR, ';
  strSQL := strSQL + '  I.ITE_CILVAS,  ';

  strSQL := strSQL + '  G.ITE_RECDEV, ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_ICMSAI, ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_PREULT, ';
  strSQL := strSQL + '  G.ITE_IMPULT, ';
  strSQL := strSQL + '  G.ITE_QTDUCO, ';
  strSQL := strSQL + '  G.ITE_PREVE1, ';
  strSQL := strSQL + '  G.ITE_PREVE2, ';
  strSQL := strSQL + '  G.ITE_PREVE3, ';
  strSQL := strSQL + '  G.ITE_PREVE4, ';
  strSQL := strSQL + '  G.ITE_PREVE5, ';
  strSQL := strSQL + '  G.ITE_PREVE6, ';
  strSQL := strSQL + '  G.ITE_PREVE7, ';
  strSQL := strSQL + '  G.ITE_COMTB1, ';
  strSQL := strSQL + '  G.ITE_COMTB2, ';
  strSQL := strSQL + '  G.ITE_COMTB3, ';
  strSQL := strSQL + '  G.ITE_COMTB4, ';
  strSQL := strSQL + '  G.ITE_COMTB5, ';
  strSQL := strSQL + '  G.ITE_COMTB6, ';
  strSQL := strSQL + '  G.ITE_COMTB7, ';
  strSQL := strSQL + '  G.ITE_IPISAI, ';
  strSQL := strSQL + '  G.ITE_DESMAX, ';
  strSQL := strSQL + '  G.ITE_DESMGE, ';
  strSQL := strSQL + '  G.ITE_DESMSU, ';
  strSQL := strSQL + '  G.ITE_SALDOS, ';
  strSQL := strSQL + '  G.ITE_COMVAR, ';
  strSQL := strSQL + '  G.ITE_COMATA, ';
  strSQL := strSQL + '  G.ITE_COMDIS, ';
  strSQL := strSQL + '  G.ITE_COMDIG, ';
  strSQL := strSQL + '  G.ITE_MARMIN, ';
  strSQL := strSQL + '  G.ITE_MARMSG, ';
  strSQL := strSQL + '  G.ITE_MARMGE, ';
  strSQL := strSQL + '  G.ITE_DESMVM, ';
  strSQL := strSQL + '  G.ITE_DESMSM, ';
  strSQL := strSQL + '  G.ITE_DESMGM, ';
  strSQL := strSQL + '  G.ITE_MARMMV, ';
  strSQL := strSQL + '  G.ITE_MARMMS, ';
  strSQL := strSQL + '  G.ITE_MARMMG, ';
  strSQL := strSQL + '  G.ITE_PRECOM, ';
  strSQL := strSQL + '  G.ITE_IPIENT, ';
  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_LOCFIS, ';
  strSQL := strSQL + '  G.ITE_QTPPRO, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';
  strSQL := strSQL + '  G.ITE_SOBENC,  ';
  strSQL := strSQL + '  G2.ITE_RECDEV AS PED_RECDEV, ';
  strSQL := strSQL + '  G2.ITE_DTAVAL AS ITE_DTAVAL, ';

  strSQL := strSQL + '  CADLOC.LOC_DESCRI, ';

  If fCfgSis('TIPABF', VarString, FInput.strEmpCfg) = '1' Then
    strSQL := strSQL + '  I.ITE_CODABF AS ABF_CODABF, '
  Else
    strSQL := strSQL + '  G.ITE_CODABF AS ABF_CODABF, ';

  If fCfgSis('IMPDIG', VarString, FInput.strEmpCfg) = '1' Then
    strSQL := strSQL + '  IF(I.ITE_IMPDIR = "", "N", I.ITE_IMPDIR) AS ITE_IMPDIR, '
  Else
    strSQL := strSQL + '  IF(G.ITE_IMPDIR = "", "N", G.ITE_IMPDIR) AS ITE_IMPDIR, ';

  strSQL := strSQL + '  EXTDOR.FDO_LOTABA, ';
  strSQL := strSQL + '  EXTDOR.FDO_INCFUT, ';
  strSQL := strSQL + '  EXTDOR.FDO_LOTANT, ';
  strSQL := strSQL + '  EXTDOR.FDO_BAQTZE, ';
  strSQL := strSQL + '  EXTDOR.FDO_PEGOU_, ';
  strSQL := strSQL + '  EXTDOR.FDO_DESNES, ';
  strSQL := strSQL + '  EXTDOR.TRI_NCMTIN, ';
  strSQL := strSQL + '  EXTDOR.FDO_VDESST, ';
  strSQL := strSQL + '  EXTDOR.FDO_MDESST, ';
  strSQL := strSQL + '  EXTDOR.FDO_SEQINV, ';
  strSQL := strSQL + '  EXTDOR.FDO_VALFCP, ';
  strSQL := strSQL + '  EXTDOR.FDO_OUTVAL AS ITE_OUTVALPD, ';
  strSQL := strSQL + '  EXTDOR.FDO_FREENT AS ITE_FREENTPD, ';
  strSQL := strSQL + '  EXTDOR.FDO_ACPPRO AS ITE_ACPPROPD, ';
  strSQL := strSQL + '  EXTDOR.FDO_ACPTXC AS ITE_ACPTXCPD, ';
  strSQL := strSQL + '  EXTDOR.FDO_ACPVCT AS ITE_ACPVCTPD, ';
  strSQL := strSQL + '  EXTDOR.FDO_ACPRES AS ITE_ACPRESPD, ';
  strSQL := strSQL + '  EXTDOR.FDO_ACPMAR AS ITE_ACPMARPD, ';
  strSQL := strSQL + '  IF(IFNULL(EXTDOR.FDO_UNDIDE, 0) = 0, FATDOR.FDO_UNIDIG, EXTDOR.FDO_UNDIDE) AS FDO_UNDIDE, ';
  strSQL := strSQL + '  FDO_VALRET AS ITE_VALRET, ';

  If fSomarNovosImpostosDaReformaAoValorContabil Then
  Begin
    strSQL := strSQL + '  IFNULL(FDOREF.REF_CBSVAL, 0) AS REF_CBSVAL, ';
    strSQL := strSQL + '  IFNULL(FDOREF.REF_VALIBS, 0) AS REF_VALIBS, ';
    strSQL := strSQL + '  IFNULL(FDOREF.REF_SELVAL, 0) AS REF_SELVAL, ';
  End
  Else
  Begin
    strSQL := strSQL + '  0.0 AS REF_CBSVAL, ';
    strSQL := strSQL + '  0.0 AS REF_VALIBS, ';
    strSQL := strSQL + '  0.0 AS REF_SELVAL, ';
  End;

  if (fVariasChapasPorLote) then
  begin
    strSQL := strSQL + '  CADLOT.LOT_MEDL_A, ';
    strSQL := strSQL + '  CADLOT.LOT_MEDL_L, ';
  end;

  strSQL := strSQL + '  FDO_SEQOPI,    ';
  strSQL := strSQL + '  FDO_TOTPES,    ';
  strSQL := strSQL + '  FDO_PESLIQ,    ';
  strSQL := strSQL + '  FDO_SEQCOM,    ';
  strSQL := strSQL + '  FDO_QTDATI,    ';
  strSQL := strSQL + '  FDO_QTDCOM,    ';
  strSQL := strSQL + '  FDO_TABCOM,    ';
  strSQL := strSQL + '  FDO_DESCND,    ';
  strSQL := strSQL + '  FDO_CODDIG,    ';
  strSQL := strSQL + '  (SELECT LDO_NUMLOT FROM LOTDOR WHERE LDO_SEQFDO = FATDOR.AUTOINCREM LIMIT 1) AS LOTSEP, ';
  strSQL := strSQL + '  FDO_CODFIS, ';
  strSQL := strSQL + '  IFNULL(FDO_ICMPAV, 0) AS FDO_ICMPAV, ';
  strSQL := strSQL + '  EXTDOR.FDO_PROESP, ';
  strSQL := strSQL + '  EXTDOR.FDO_EXIBSE, ';
  strSQL := strSQL + '  EXTDOR.FDO_PROKIT, ';
  strSQL := strSQL + '  EXTDOR.FDO_EMPCAR, ';
  strSQL := strSQL + '  EXTDOR.FDO_SEQEQL, ';
  strSQL := strSQL + '  EXTDOR.FDO_NUMDRW, ';
  strSQL := strSQL + '  EXTDOR.FDO_QTDRET, ';
  strSQL := strSQL + '  EXTDOR.FDO_NUMPLA, ';
  strSQL := strSQL + '  EXTDOR.FDO_PARNUM, ';
  strSQL := strSQL + '  EXTDOR.FDO_REQCOM, ';
  strSQL := strSQL + '  EXTDOR.FDO_REGESP, ';
  strSQL := strSQL + '  EXTDOR.FDO_ALTEST, ';
  strSQL := strSQL + '  EXTDOR.FDO_SEQPER, ';
  strSQL := strSQL + '  EXTDOR.FDO_EMPDMP, ';
  strSQL := strSQL + '  EXTDOR.FDO_RATEST, ';
  strSQL := strSQL + '  EXTDOR.FDO_BASTRO, ';
  strSQL := strSQL + '  IF(EXTDOR.FDO_TEMNSE = "", "N", EXTDOR.FDO_TEMNSE) AS FDO_TEMNSE, ';
  strSQL := strSQL + '  IF(EXTDOR.FDO_MNTPRC = "", "N", EXTDOR.FDO_MNTPRC) AS FDO_MNTPRC, ';
  strSQL := strSQL + '  EXTDOR.FDO_ALTEST ITE_ALTEST, ';
  strSQL := strSQL + '  IF(EXTDOR.FDO_RATEST = "S", TRUE, FALSE) AS ITE_RATEST, ';
  strSQL := strSQL + '  IFNULL(BRIDOR.BRI_CODPAR,"") AS ITE_CODPAR, ';
  strSQL := strSQL + '  IFNULL(BRIDOR.BRI_TIPBRI,"") AS ITE_TIPBRI, ';
  strSQL := strSQL + fFatDorCampos;
  strSQL := strSQL + '  IF(BRIDOR.BRI_SEQDET IS NULL, "N", "S") AS ITE_BRINDE, ';
  strSQL := strSQL + '  CADCLI.CLI_INDUST, ';
  strSQL := strSQL + '  CADCLI.CLI_SIBICM, ';
  strSQL := strSQL + '  CADCLI.CLI_CEDESP, ';
  strSQL := strSQL + '  CADCLI.CLI_IVAESP, ';
  strSQL := strSQL + fInscricaoEstadualCliente + ' AS CLI_I_E_S_, ';
  strSQL := strSQL + fEstadoCliente + ' AS CLI_ESTADO, ';
  strSQL := strSQL + '  FDO_TCKQBT AS ITE_TCKQBT, ';
  strSQL := strSQL + '  EXTDOR.FDO_FRERAT AS ITE_FRERAT ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATDOR ';
  strSQL := strSQL + '  JOIN FATGOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ';
  strSQL := strSQL + '  LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';
  strSQL := strSQL + '  LEFT JOIN FORTIN ON FATDOR.FDO_CODACA = FORTIN.FOR_CODACA AND FORTIN.FOR_EMPACA = FATDOR.FDO_EMPACA ';
  strSQL := strSQL + '  JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE ';
  strSQL := strSQL + '  JOIN CADGRU ON GRU_CODGRU = I.ITE_CODGRU ';
  strSQL := strSQL + '  JOIN CADCLI ON CADCLI.CLI_CODCLI = FATDOR.FDO_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADCID CIDCLI ON CIDCLI.CID_CODCID = CADCLI.CLI_CODCID ';

  if (strOrdPdv[1] = '5') or (strOrdOrc[1] = '5') then
    strSQL := strSQL + '  LEFT JOIN CADDEP ON DEP_CODIGO = I.ITE_CODDEP ';

  strSQL := strSQL + FInput.strLeftJoinCadLotItensPedido;

  strSQL := strSQL + '  LEFT JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';

  If fSomarNovosImpostosDaReformaAoValorContabil Then
    strSQL := strSQL + '  LEFT JOIN FDOREF ON FDOREF.REF_SEQFDO = FATDOR.AUTOINCREM ';

  If fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
    strSQL := strSQL + ' LEFT JOIN ORCMAD M ON M.FDO_SEQGER = FATDOR.AUTOINCREM  ';

  strSQL := strSQL + '  LEFT JOIN CADUNI CADUNI_FATDOR ON CADUNI_FATDOR.UNI_CODUNI = FATDOR.FDO_UNIDAD ';
  strSQL := strSQL + '  LEFT JOIN CADUNI CADUNI_CADITE ON CADUNI_CADITE.UNI_CODUNI = I.ITE_CODUNI ';

  strSQL := strSQL + '  JOIN ITEGER G ON G.ITE_CODITE = FDO_CODITE AND G.ITE_CODEMP = :CODEMP ';
  strSQL := strSQL + '  LEFT JOIN ITEGER G2 ON G2.ITE_CODITE = FDO_CODITE ';
  strSQL := strSQL + '                     AND G2.ITE_CODEMP = ' + fEmpresaDoItem;
  strSQL := strSQL + '  LEFT JOIN CADFOR ON CADFOR.FOR_CODFOR = FDO_FORITE ';
  strSQL := strSQL + '  LEFT JOIN CADMAR ON CADMAR.MAR_CODMAR = I.ITE_CODMAR ';
  strSQL := strSQL + '  LEFT JOIN CADLOC ON CADLOC.LOC_CODLOC = G.ITE_LOCFIS ';
  strSQL := strSQL + '                  AND CADLOC.LOC_CODEMP = ' + QuotedStr(VS_strCodEmp);
  strSQL := strSQL + '  LEFT JOIN BRIDOR ON BRIDOR.BRI_SEQDET = FATDOR.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN CLIPRO ON CLIPRO.CLI_CODCLI = FATDOR.FDO_CODCLI ';
  strSQL := strSQL + '                  AND CLIPRO.CLI_CODITE = FATDOR.FDO_CODITE ';
  strSQL := strSQL + '  LEFT JOIN CADOPE VENITE ON VENITE.OPE_CODOPE = ' + fCodigoVendedorItem;
  strSQL := strSQL + '  LEFT JOIN DORICD ON DORICD.ICD_SEQFDO = FATDOR.AUTOINCREM ';
  strSQL := strSQL + fLeftJoinVariasChapasPorLote;
  strSQL := strSQL + 'WHERE FDO_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '  AND FDO_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '  AND FDO_CODEMP = :EMPDOC ';
  strSQL := strSQL + '  AND FDO_PROEMB <> "S" ';
  strSQL := strSQL + '  AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITEMAN', varString, FInput.strEmpCfg));
  strSQL := strSQL + '  AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITELAN', varString, FInput.strEmpCfg));
  strSQL := strSQL + '  AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITEBOM', varString, FInput.strEmpCfg));
  strSQL := strSQL + '  AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITETAX', varString, FInput.strEmpCfg));
  strSQL := strSQL + '  AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITESER', VarString, FInput.strEmpCfg));
  strSQL := strSQL + '  AND FDO_CODITE <> ' + QuotedStr(fCfgSis('SERTER', VarString, FInput.strEmpCfg));
  strSQL := strSQL + fGetWhereSomenteItensNoRomaneio;

  If (Not fEmptyStr(FInput.strIncFdo)) Then
    strSQL := strSQL + '  AND FATDOR.AUTOINCREM = "' + FInput.strIncFdo + '" ';

  If (FInput.blnVazio) Then
    strSQL := strSQL + '  AND FALSE ';

  strSQL := strSQL + fGetOrderBy(strOrdPdv, strOrdOrc);

  Result := strSQL;
end;

function TSQLItensPedido.fGetWhereSomenteItensNoRomaneio: String;
begin
  Result := EmptyStr;

  if fEmptyStr(FInput.strNumRom) then
    Exit;

  if (not fCfgSis('USPRRO', varBoolean)) then
    Exit;

  if (not fCfgSis('RMPDPA', varBoolean)) then
    Exit;

  Result := Result + '  AND EXISTS ';
  Result := Result + '   (SELECT DET_QTDITE ';
  Result := Result + '    FROM ROMDETX ';
  Result := Result + '    WHERE DET_AUTINC = FATDOR.AUTOINCREM ';
  Result := Result + '      AND DET_NUMROM = ' + QuotedStr(FInput.strNumRom);
  Result := Result + '      AND DET_EMPROM = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '   ) ';
end;

function TSQLItensPedido.fGetItensDeControleInterno: String;
begin
  Result := EmptyStr;

  If (Not fEmptyStr(fCfgSis('ITESER', varString))) Then
  Begin
    If fEmptyStr(Result) Then
      Result := QuotedStr(fCfgSis('ITESER', varString))
    Else
      Result := Result + ', ' + QuotedStr(fCfgSis('ITESER', varString));
  End;

  If (Not fEmptyStr(fCfgSis('SERTER', varString))) Then
  Begin
    If fEmptyStr(Result) Then
      Result := QuotedStr(fCfgSis('SERTER', varString))
    Else
      Result := Result + ', ' + QuotedStr(fCfgSis('SERTER', varString));
  End;
end;

function TSQLItensPedido.fGetOrderBy(const strOrdPdv, strOrdOrc: String): String;
begin
  Result := EmptyStr;
  Result := Result + 'ORDER BY ';

  If (FInput.strEspOrc = 'PD') Then
  Begin
    Case strOrdPdv[1] Of
      '1': Result := Result + '  FATDOR.FDO_DESCRI ';
      '2': Result := Result + '  CADUNI_CADITE.UNI_SIGUNI, FATDOR.FDO_DESCRI ';
      '3': Result := Result + '  EXTDOR.FDO_ORDITE, FATDOR.AUTOINCREM  ';
      '5': Result := Result + '  DEP_DESCRI, FATDOR.FDO_DESCRI ';
      '6': Result := Result + '  IF(IFNULL(FDO_ENTRET, "R") = "R",0, IF(IFNULL(FDO_ENTFUT, "N") = "N", 1, 2)), FDO_DESCRI ';
      Else Result := Result + '  IFNULL(IF(IFNULL(LOT_NUMLOT, "") = "", G.ITE_LOCFIS, LOT_LOCFIS), ""),  FATDOR.FDO_DESCRI ';
    End;
  End
  Else If (FInput.strEspOrc = 'OR') Then
  Begin
    Case strOrdOrc[1] Of
      '1': Result := Result + '  FATDOR.FDO_DESCRI ';
      '2': Result := Result + '  CADUNI_CADITE.UNI_SIGUNI, FATDOR.FDO_DESCRI ';
      '3': Result := Result + '  EXTDOR.FDO_ORDITE, FATDOR.AUTOINCREM  ';
      '5': Result := Result + '  DEP_DESCRI, FATDOR.FDO_DESCRI ';
      '6': Result := Result + '  IF(IFNULL(FDO_ENTRET, "R") = "R",0, IF(IFNULL(FDO_ENTFUT, "N") = "N", 1, 2)), FDO_DESCRI ';
      Else Result := Result + '  IFNULL(IF(IFNULL(LOT_NUMLOT, "") = "", G.ITE_LOCFIS, LOT_LOCFIS), ""),  FATDOR.FDO_DESCRI ';
    End;
  End
  Else
    Result := Result + '  FATDOR.AUTOINCREM ';
end;

function TSQLItensPedido.fIndustrializacaoRevenda: String;
begin
  If fCfgSis('INDREV') = '1' Then
    Result := 'I.ITE_INDREV'
  Else
    Result := 'G2.ITE_INDREV';
end;

function TSQLItensPedido.fItemDivisivel: String;
  var
    strItensControle : String;
begin
  strItensControle := fGetItensDeControleInterno;
  If fEmptyStr(strItensControle) Then
    Result := 'I.ITE_NOTESP'
  Else
    Result := Format('IF(FDO_CODITE IN (%s), "N", I.ITE_NOTESP)', [strItensControle]);
end;

function TSQLItensPedido.fLeftJoinVariasChapasPorLote: String;
begin
  Result := EmptyStr;
  If (fVariasChapasPorLote) and
     (Pos(FInput.strOpcDoc, 'PD_OR_VN_') > 0) then
  begin
    Result := ' LEFT JOIN FDOCHA ON FDOCHA.FDO_SEQFDO = FATDOR.AUTOINCREM ';
  End;
end;

function TSQLItensPedido.fLocalDeRetiraDoItem: String;
begin
  If (Not fCfgSis('LOCRET', VarBoolean)) Then
    Result := 'CAST("" AS CHAR(1))'
  Else
    Result := Format('IF( %s <> "R", " ", IF(IFNULL(FDO_LOCRET,"") = "", "C", FDO_LOCRET))', [fEntregaRetira]);
end;

function TSQLItensPedido.fLoteDoItem: String;
begin
  If TPickingCheckOut.fWMSUtilizaPickingCheckOut Then
    Result := 'IF(FDO_ENTRET = "R" AND FDO_LOCRET = "C", FDO_NUMLOT, ' + fSQLCampoLotePedido + ')'
  Else If fUsaCampoDoLoteDefinidoNoPedido Then
    Result := 'FDO_NUMLOT'
  Else
    Result := 'LOT_NUMLOT';
end;

function TSQLItensPedido.fNotaEspecialTinta: String;
begin
  Result := Format(' %d ', [Ord(FInput.OpcItensNFespTinta)]);
end;

function TSQLItensPedido.fOpcaoAbastecimentoItem: String;
begin
  Result := Format(' %d ', [Integer(oaTodos)]);
end;

function TSQLItensPedido.fQuantidadeDoItemBaixada: String;
begin
  Result := 'IF(FDO_JAFATU > 0, IFNULL(FDO_QTDITE,0), IFNULL(FDO_QTDBAI,0))';
end;

function TSQLItensPedido.fQuantidadeOriginalDoItem: String;
begin
  Result := 'IF(FDO_QTDITE <= 0, IFNULL(FDO_QTDBAI,0), IFNULL(FDO_QTDITE,0))';
end;

function TSQLItensPedido.fQuantidadeTotalEntregaFuturaItemSemLote: String;
begin
  Result := '((G2.ITE_QTPDBF + G2.ITE_QTEF_P + G2.ITE_QTEF_F + G2.ITE_QTEF_A) * IF(IFNULL(I.ITE_CNV_ML, 0) <= 0, 1, I.ITE_CNV_ML))';
end;

function TSQLItensPedido.fQuantidadeBaixadaCdsBaixados: String;
begin
  If (Pos(FInput.strOpcDoc,'VN_CS_PD_OR_') > 0) Then
    Result := '0.00'
  Else
    Result := fQuantidadeDoItemBaixada;
end;

function TSQLItensPedido.fQuantidadeBaixadaCdsVenda: String;
begin
  If (FInput.blnOrigemTelaDesmembrarPedidoConfiguracaoDPDAFPLigada) Then
    Result := fQuantidadeDoItemBaixada
  Else If (Pos(FInput.strOpcDoc,'VN_CS_PD_OR_') > 0) Then
    Result := '0.00'
  Else
    Result := fQuantidadeDoItemBaixada;
end;

function TSQLItensPedido.fQuantidadeDeChapas: String;
begin
  Result := '0.00';

  If Not fVariasChapasPorLote Then
    Exit;

  If (Pos(FInput.strOpcDoc, 'PD_OR_VN_') = 0) then
    Exit;

  Result := EmptyStr;
  Result := Result + 'IF(IFNULL(FDOCHA.FDO_QTDCHA, 0) <> 0, ';
  Result := Result + '  FDOCHA.FDO_QTDCHA, ';
  Result := Result + '  IF((IFNULL(LOT_MEDL_L, 0) <> 0) AND (IFNULL(LOT_MEDL_A, 0) <> 0), FDO_QTDITE / LOT_MEDL_L / LOT_MEDL_A, 0.00) ';
  Result := Result + '  )';
end;

function TSQLItensPedido.fQuantidadeDoItem: String;
begin
  Result := 'FDO_QTDITE';

  If (Not FInput.blnHerancaOrcamentoPedido) And (Not FInput.blnOrigemTelaDesmembrarPedidoConfiguracaoDPDAFPLigada) Then
    Result := Result + ' - ' + fQuantidadeDoItemBaixada;

  If fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) and (not fEmptyStr(FInput.strNumRom)) Then
  Begin
    Result := EmptyStr;
    Result := Result + ' ( SELECT DET_QTDITE ';
    Result := Result + '     FROM ROMDETX ';
    Result := Result + '    WHERE DET_AUTINC = FATDOR.AUTOINCREM ';
    Result := Result + '      AND DET_NUMROM = ' + QuotedStr(FInput.strNumRom);
    Result := Result + '      AND DET_EMPROM = ' + QuotedStr(VS_strCodEmp);
    Result := Result + '      LIMIT 1 ';
    Result := Result + ' ) ';
  End;
end;

function TSQLItensPedido.fSQLCampoLotePedido: String;
begin
  If fUsaCampoDoLoteDefinidoNoPedido Then
    Result := 'FDO_NUMLOT'
  Else
    Result := 'LOT_NUMLOT';
end;

function TSQLItensPedido.fSQLClienteConsumidor: String;
begin
  Result := 'CADCLI.CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CADCLI.CLI_NOMCLI LIKE "%BALCAO%" OR CADCLI.CLI_NOMCLI LIKE "%BALCÃO%" OR CADCLI.CLI_NOMCLI LIKE "%SEGURADORA%"';
end;

function TSQLItensPedido.fSugestaoEntregaQuandoVazio: String;
begin
  If FInput.blnBaiEntFut Then
    Result := 'E'
  Else
  Begin
    If Not (Pos(FInput.strOpcDoc, IfThen(fCfgSis('COENRE', varBoolean), 'CF_CI_CT_', '')) > 0) Then
    Begin
      If (FInput.blnCliFil) Then
      Begin
        If fCfgSis('SUG_TE', varBoolean) Then
          Result := 'E'
        Else
          Result := 'R';
      End
      Else
      Begin
        If fCfgSis('SUJROM', varBoolean) Then
          Result := 'E'
        Else
          Result := 'R';
      End;
    End;
  End;
end;

function TSQLItensPedido.fQuantidadeEstruturaItem_BAI: String;
begin
  Result := Format('IF(IFNULL(FDO_QTDSBI, 0) > 0, %s / FDO_QTDSBI, 0.00)', [fQuantidadeDoItemBaixada]);
end;

function TSQLItensPedido.fQuantidadeEstruturaItem_ITE: String;
begin
  Result := Format('IF(IFNULL(FDO_QTDSBI, 0) > 0, ( %s ) / FDO_QTDSBI, 0.00)', [fQuantidadeDoItem]);
end;

function TSQLItensPedido.fEhExpedicaoPorRomaneio(): Boolean;
begin
  Result := (FInput.strOpcDoc = 'CP') And
            (FInput.blnExpedi) And
            (VS_strTipExp = '5') And
            (Not fEmptyStr(FInput.strNumRom));
end;

function TSQLItensPedido.fUsaCampoDoLoteDefinidoNoPedido: Boolean;
begin
  Result := False;

  If fEhExpedicaoPorRomaneio() Then
    Exit(True);

  If (FInput.blnWMS) Then
    Exit;

  If (FInput.blnPedidoTransferenciaSolicitacaoEntreLojas) Then
    Exit(True);

  If (fCfgSis('TMQLOT', varBoolean, FInput.strEmpCfg)) Then
    Exit(True);
end;

function TSQLItensPedido.fUsaDocumentoEmSuaFormaOriginal: Boolean;
begin
  Result := True;

  If (FInput.blnHerancaOrcamentoPedido) Then
    Exit;

  If (FInput.blnOrigemTelaDesmembrarPedidoConfiguracaoDPDAFPLigada) Then
    Exit;

  Result := False;
end;

function TSQLItensPedido.fVariasChapasPorLote: Boolean;
begin
  Result := False;

  If (fCfgSis('MARMOR', varString, FInput.strEmpCfg) <> 'S') Then
    Exit;

  If (fCfgSis('CTRLCH', varString, FInput.strEmpCfg) <> '2') Then
    Exit;

  Result := True;
end;

end.
