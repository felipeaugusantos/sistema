unit untReimpressao;

interface

uses Uni, SysUtils, Classes, untfuncoesSimples, StrUtils, DB,
  untFuncFat, Forms, Controls, Variants, StdCtrls, untTypesSistema, Printers,
  UniClientDataSet, untFuncoesGenerica, frxClass, untFatGor, untLiberacao,
  Garantia.TSQLGarantiaFiltroCancelamentoEspecieOF, untEditorFastImpressao,
  Garantia.TSQLGarantiaRetornoFornecedor;

Type
  TOpcEditorFast = (opcPergunta, opcVideo, opcEmail);

  TOpcaoPedido = (oppPergunta, oppOriginal, oppPendente);

  TLibPed = (libAmbos, libPedido, libSeparacao);

  TDocumentosReimpressao = Class(TComponent)
    private
      FCdsDoc: TUniClientDataSet;
      FQryDoc: TUniQuery;
      FSql: String;
      procedure SetSqlDocs(Value: String);
    public
      Constructor Create(AOwner: TComponent); Override;
      Destructor Destroy; Override;
      procedure pAddFiltro(strNome: String; varValFiltro: Variant);
      procedure pCarregarDocumentos;
      property strSqlDocs: String read FSql write SetSqlDocs;
      property cdsDocumentos: TUniClientDataSet read FCdsDoc write FCdsDoc;
  End;

Type
  TReimpressao = class(TObject)
    private
      function fRetCupCon(strNumDoc, strEspDoc, strCodEmp: String): String;
      function fRetCupCha(strNumDoc, strEspDoc, strCodEmp: String): String;
      function fRetNumOrc(strNumDoc, strEspDoc, strCodEmp: String): String;
      function fRetTEsConfirmadas(strNumDoc, strEspDoc, strCodEmp: String): String;

      function fTotalRecebidoPedido(strNumDoc, strEspDoc: String): Double;

      function fRetDocsOrigFat(strNumDoc, strEspDoc, strCodEmp: String): String;

      function  fRetIPIRet(strClaIPI: String): String;
      procedure pCarregaMovRes(strAutInc, strTabela: String);
      procedure pCarregaAuxMov(strAutInc, strTabela: String);

      procedure pImprimeNota(strTabela: String);
      procedure pInsereDadosTemp(strCodEmp: String);

      procedure pAtribuiIndiceLegendaTipoSituacao(qryTemporaria: TDataset);
      procedure pReimprimeComplementoFF(strNumDoc, strEspDoc, strEmpDoc, strCodCLi, strTipFc, strSaida: String; intQtdImp: Integer);
      procedure pReimprimeCreditosFF(strNumDoc, strEspDoc, strEmpDoc, strCodCLi, strTipFc, strSaida: String; intQtdImp: Integer);

      function fGetSqlOutrasSaidasFornecedor(strNumDoc,
                                             strEspDoc: String;
                                             dtaDtaIni,
                                             dtaDtaFin: TDateTime;
                                             strCodCli,
                                             strCodEmp,
                                             strCodVen,
                                             strTip_Fc: String;
                                             intFilCla: Integer;
                                             blnCancelamento: Boolean;
                                             blnExiDocsCanc: Boolean;
                                             strNumCoo: String;
                                             strSerie : String): String;

      procedure pAtualizaQtdDocCadFis(intQtdNot: Integer;
                                      strNumDoc,
                                      strEspDoc,
                                      strCodEmp,
                                      strAutInc: String);

    protected
      FCodVen: String;
      FPergSep: Boolean;
      FAux001: TUniQuery;
      FAux002: TUniQuery;
      FFatVenda: Boolean;
      FPais: TPais;

      blnDocSep: Boolean;
      intQtdImp: Integer;

      FRecCliGar : Boolean;
      objLiberacao : TLiberacao;

      FDtaIni: TDateTime;
      FDtaFin: TDateTime;
      FCodCli: String;
      FNumDoc: String;
      FEspDoc: String;
      FCodEmp: String;
      FFiltNE: Boolean;
      FOrigemRomaneio: Boolean;

      procedure pCarregaEndEntregaCobranca(Var fatVenda: TFatVenda; strNomTab, strAutInc: String);
      function fImpLocFis(strEspDoc: string): Boolean;
      function fGetNomeTabela: String;
    public

      strDocsConf  : String;
      strDocsConfIF: String;
      strDocsConfTE: String;
      strCupCon: String;
      strCupCha: string;
      strCupConDev: String;
      strCliNFV: String;
      strCGCNFV: String;
      strIE_NFV: String;
      strNroNFV: String;
      strDtaNFV: String;
      fltValNFV: Double;
      strCodPor: String;
      strTipImp: String;

      qryCfgRel: TUniQuery;

      blnExpedicao: Boolean;

      objDocumentos: TDocumentosReimpressao;

      fatVenda: TFatVenda;

      blnSeparacaoDireto: Boolean;

      blnTemLay: Boolean;
      blnImprimiuEditor: Boolean;
      blnImprimiuAmbien: Boolean;
      strArqPDF: String;
      blnTelaReimpressao : Boolean; // Quando true indica que veio da tela de reimpressão;

      blnPreRomaneio: Boolean;

      blnReimpressaoDaSeparacaoPedido : Boolean;
      blnImpressaoColetor: Boolean;

      Constructor Create(strNumDoc,
                         strEspDoc: String;
                         dtaDtaIni,
                         dtaDtaFin: TDateTime;
                         strCodCli,
                         strCodEmp,
                         strCodVen: String;
                         blnFaturamento: Boolean;
                         strTip_Fc: String;
                         blnPergSep,
                         blnFatVenda,
                         blnCancelamento: Boolean;
                         strEspSel,
                         strSerie: String;
                         blnFiltrarNE: Boolean;
                         intFilCla: Integer;
                         blnExiDocsCanc: Boolean;
                         strOriDoc: String;
                         blnReimpr: Boolean = False;
                         blnRecClienteGar: Boolean = False;
                         strNumCoo : String = '';
                         strPlaVei: string = '';
                         blnOrigemRomaneio: Boolean = False);

      destructor Destroy; override;

      procedure pReimprimeDocumento(blnImpNFDireto: Boolean = False;
                                    blnQtdOri: Boolean = False;
                                    blnDocCan: Boolean = False;
                                    blnVerCfg: Boolean = True;
                                    blnImpPed: Boolean = False;
                                    opcEdtFst: TOpcEditorFast = opcPergunta;
                                    blnEditor: Boolean = False;
                                    tipLibPed: TLibPed = libAmbos;
                                    blnF9OrF10: Boolean = False;
                                    blnGerPdf: Boolean = False;
                                    strPasPdf: String = '';
                                    blnVisPdf: Boolean = False;
                                    blnOpcFat: Boolean = False); virtual;

      function fImprimeSeparacao(strOpcDoc: String;
                                 blnQtdOri,
                                 blnDocCan,
                                 blnVerCfg: Boolean;
                                 blnExpEnt: Boolean = False;
                                 blnImpPed: Boolean = False;
                                 opcAbastecimento: TOpcAbastecimento = opcTodos;
                                 blnLocFisEmpEmi: Boolean = False;
                                 strPedSepEntRet: String = '';
                                 blnImpBaixaSeparacao: Boolean = False;
                                 intSeqSepPar: Integer = 0): Boolean;

      function fDescontoCliente(strEspDoc, strCodCli: String): Boolean;

      procedure pImprimeNotaComp;
      procedure pSetaDocumentoOriginalConcreto(cdsDestin: TUniClientDataSet; strCampoDocOri: String; blnReimpressao: Boolean);
  End;

  Procedure pMostraDocumentoReimpressao(strNumDoc, strEspDoc, strCodEmp, strSerie: String; strCodCli: String = ''; strTipFC: String = 'C';  blnFiltrarNE: Boolean = True; blnOpcaoImpressao: Boolean = False);

implementation

uses  untConstantes, untFuncMacro, untMovGer, untValorPorExtenso, untEnderecoEntrega,
      untFuncoes, untFuncTinta, untCfgRel, untQckHTMLDocumentos, untSQLRepositorio, untGarant,
      untTipoTinta, untTCliAtiRepository, untDuplicatas, untQckFatImpNFCe,
      untFatImpressao, untImpContratoLocacao, TypesRel;

{ TReimpressao }



destructor TReimpressao.Destroy;
begin
  FreeAndNil(qryCfgRel);
  FreeAndNil(FAux001);
  FreeAndNil(FAux002);
  FreeAndNil(objDocumentos);
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited Destroy;
end;

constructor TReimpressao.Create(strNumDoc,
                                strEspDoc: String;
                                dtaDtaIni,
                                dtaDtaFin: TDateTime;
                                strCodCli,
                                strCodEmp,
                                strCodVen: String;
                                blnFaturamento: Boolean;
                                strTip_Fc: String;
                                blnPergSep,
                                blnFatVenda,
                                blnCancelamento: Boolean;
                                strEspSel,
                                strSerie: String;
                                blnFiltrarNE: Boolean;
                                intFilCla: Integer;
                                blnExiDocsCanc: Boolean;
                                strOriDoc: String;
                                blnReimpr: Boolean = False;
                                blnRecClienteGar: Boolean = False;
                                strNumCoo : String = '';
                                strPlaVei: string = '';
                                blnOrigemRomaneio: Boolean = False);
  Var
    strSQL: String;
    strSQL2: String;
    strFatGor: String;
    strImpAju: String;
    strCmpAjuMl: String;
    strCmpAju: String;
    objGarantiaFiltroCancelamentoEspecieOF: TSQLGarantiaFiltroCancelamentoEspecieOF;
    FTipoConsCli: TTipoConsCli;
   {**************************************************************************}
   {* MONTA A LISTA DE TODOS DOCUMENTOS DE ORIGEM SEM DUPLICAR. SE TIVER     *}
   {* MAIS QUE UM, JOGA O SÍMBOLO +1.                                        *}
   {* AO USAR ESSA FUNÇÃO PARA OUTROS TIPOS, CRIAR AS CORRESPONDENCIAS EM    *}
   {* fRetTipDocOri, untTypesSistema, untConstantes E TRATAR A RESPECTIVA    *}
   {* VISUALIZAÇÃO EM untReimpressaoDocsList                                 *}
   {***********************************************************************VA*}
   function fRetSQLIdentColDocOri(strTip, strCmpDoc, strCmpEsp: String; strCmpEmp: String = ''): String;
     function fNumEspDocConcat:String;
     begin
       Result := ' CONCAT('+strCmpDoc+', "-", '+strCmpEsp + IfThen(not fEmptyStr(strCmpEmp), ', "-", '+strCmpEmp, '') + ') ';
     end;
   begin
     Result := ' IF(LENGTH(GROUP_CONCAT(DISTINCT '+fNumEspDocConcat+')) - LENGTH(REPLACE(GROUP_CONCAT(DISTINCT '+fNumEspDocConcat+'), ",", "")) >= 1, "'+TIP_DOC_ORI_SIMBOL+fPadL(strTip, 50)+'", '+fNumEspDocConcat+') AS DOCORI ';
   end;

   function fRetDetFat: String;
   begin
     Result := '';
     Result := Result + ' (SELECT '+fRetSQLIdentColDocOri(TIP_NUM_FAT_DETFAT, 'DET_NUMFAT', 'DET_TIPFAT', 'DET_EMPFAT');
     Result := Result + '  FROM ';
     Result := Result + '    MOVDET ';
     Result := Result + '  WHERE DET_SEQGER = MOVGER.AUTOINCREM) ';
   end;

   function fRetFatFat: String;
   begin
     Result := ' CASE                                                     '+
               '    WHEN                                                  '+
               '    (SELECT                                               '+
               '      COUNT(DISTINCT(MOVGER.AUTOINCREM))                  '+
               '    FROM                                                  '+
               '      MOVGER                                              '+
               '    INNER JOIN MOVDET ON DET_SEQGER = MOVGER.AUTOINCREM   '+
               '    WHERE MOVDET.DET_NUM_PD = FATGOR.FGO_NUMDOC           '+
               '      AND MOVDET.DET_ESP_PD = FATGOR.FGO_ESPDOC           '+
               '      AND MOVDET.DET_EMP_PD = FATGOR.FGO_CODEMP) > 1      '+
               '    THEN "'+TIP_DOC_ORI_SIMBOL+fPadL(TIP_NUM_FAT_FATFAT, 50)+'" '+
               '    ELSE IFNULL(                                          '+
               '      (SELECT                                             '+
               '        CONCAT(                                           '+
               '          FDO_NUMFAT,                                     '+
               '          "-",                                            '+
               '          FDO_TIPFAT,                                     '+
               '          "-",                                            '+
               '          FDO_EMPFAT                                      '+
               '        )                                                 '+
               '       FROM                                               '+
               '         FATDOR                                           '+
               '       WHERE FDO_SEQGER = FATGOR.AUTOINCREM               '+
               '         AND FDO_NUMFAT IS NOT NULL                       '+
               '      LIMIT 1),                                           '+
               '      "")                                                 '+
               '  END                                                     ';
   end;

   function fRetNotFat: String;
   begin
     Result := '';
     Result := Result + ' (SELECT '+fRetSQLIdentColDocOri(TIP_NUM_FAT_NOTFAT, 'DET_NUMFAT', 'DET_TIPFAT', 'DET_EMPFAT');
     Result := Result + '  FROM ';
     Result := Result + '    NOTDET ';
     Result := Result + '  WHERE DET_SEQGER = NOTGER.AUTOINCREM) ';
   end;

   function fRetDocFat: String;
   begin
     Result := '';
     Result := Result + ' (SELECT '+fRetSQLIdentColDocOri(TIP_DOC_ORI_PEDORC, 'FDO_NUMDOC', 'FDO_ESPDOC');
     Result := Result + '  FROM ';
     Result := Result + '    FATDOR ';
     Result := Result + '  WHERE FDO_TIPFAT = GER_ESPDOC ';
     Result := Result + '    AND FDO_NUMFAT = GER_NUMDOC ';
     Result := Result + '    AND FDO_EMPFAT = GER_CODEMP ';
     Result := Result + '    AND FDO_CODCLI = GER_CODCLI ';
     Result := Result + '    AND FDO_JAFATU = 1) ';
   end;

   function fRetVendedorFat: String;
   begin
     Result := '';
     Result := Result + ' (SELECT IF(LENGTH(GROUP_CONCAT(DISTINCT FDO_CODVEN)) - LENGTH(REPLACE(GROUP_CONCAT(DISTINCT FDO_CODVEN), ",", "")) >= 1, "+1", FDO_CODVEN) AS CODVEN ';
     Result := Result + '  FROM ';
     Result := Result + '    FATDOR ';
     Result := Result + '  WHERE FDO_TIPFAT = GER_ESPDOC ';
     Result := Result + '    AND FDO_NUMFAT = GER_NUMDOC ';
     Result := Result + '    AND FDO_EMPFAT = GER_CODEMP ';
     Result := Result + '    AND FDO_CODCLI = GER_CODCLI ';
     Result := Result + '    AND FDO_JAFATU = 1) ';
   end;

   function fRetDocFut: String;
   begin
     Result := '';
     Result := Result + ' (SELECT '+fRetSQLIdentColDocOri(TIP_DOC_ORI_ENTFUT, 'DET_DOCFUT', 'DET_ESPFUT');
     Result := Result + '  FROM ';
     Result := Result + '    MOVDET ';
     Result := Result + '  WHERE DET_SEQGER = MOVGER.AUTOINCREM) ';
   end;

   function fRetVendedorFut: String;
   begin
     Result := '';
     Result := Result + ' (SELECT IF(LENGTH(GROUP_CONCAT(DISTINCT DET_CODVEN)) - LENGTH(REPLACE(GROUP_CONCAT(DISTINCT DET_CODVEN), ",", "")) >= 1, "+1", DET_CODVEN) AS CODVEN ';
     Result := Result + '  FROM ';
     Result := Result + '    MOVDET ';
     Result := Result + '  WHERE DET_SEQGER = MOVGER.AUTOINCREM) ';
   end;

   function fRetNum_Pd: String;
   begin
     Result := '';
     Result := Result + ' (SELECT '+fRetSQLIdentColDocOri(TIP_DOC_ORI_PEDORC, 'DET_NUM_PD', 'DET_ESP_PD');
     Result := Result + '  FROM ';
     Result := Result + '    MOVDET ';
     Result := Result + '  WHERE DET_SEQGER = MOVGER.AUTOINCREM AND (TRIM(IFNULL(DET_NUM_PD,"")) <> "") AND (TRIM(IFNULL(DET_ESP_PD,"")) <> "")) ';
   end;

   function fRetVendedor_Pd: String;
   begin
     Result := '';
     Result := Result + ' (SELECT IF(LENGTH(GROUP_CONCAT(DISTINCT DET_CODVEN)) - LENGTH(REPLACE(GROUP_CONCAT(DISTINCT DET_CODVEN), ",", "")) >= 1, "+1", DEt_CODVEN) AS CODVEN ';
     Result := Result + '  FROM ';
     Result := Result + '    MOVDET ';
     Result := Result + '  WHERE DET_SEQGER = MOVGER.AUTOINCREM AND (TRIM(IFNULL(DET_NUM_PD,"")) <> "") AND (TRIM(IFNULL(DET_ESP_PD,"")) <> "")) ';
   end;

  function fReDocCnf: String;
  begin
    Result := '';
    Result := Result + '    (SELECT '+fRetSQLIdentColDocOri(TIP_DOC_ORI_DOCCNF, 'DET_NUMDOC', 'DET_ESPDOC');
    Result := Result + '     FROM ';
    Result := Result + '       MOVDET ';
    Result := Result + '     WHERE DET_TIPFAT = GER_ESPDOC ';
    Result := Result + '       AND DET_NUMFAT = GER_NUMDOC ';
    Result := Result + '       AND DET_EMPFAT = GER_CODEMP) ';
  end;

  function fReDocIF: String;
  begin
    Result := '';
    Result := Result + '    (SELECT '+fRetSQLIdentColDocOri(TIP_DOC_ORI_DOCIF_, 'DET_NUMDOC', 'DET_ESPDOC');
    Result := Result + '     FROM ';
    Result := Result + '       NOTDET ';
    Result := Result + '     WHERE DET_TIPFAT = GER_ESPDOC ';
    Result := Result + '       AND DET_NUMFAT = GER_NUMDOC ';
    Result := Result + '       AND DET_EMPFAT = GER_CODEMP) ';
  end;

  function fReVendedorCnf: String;
  begin
    Result := '';
    Result := Result + '    (SELECT IF(LENGTH(GROUP_CONCAT(DISTINCT DET_CODVEN)) - LENGTH(REPLACE(GROUP_CONCAT(DISTINCT DET_CODVEN), ",", "")) >= 1, "+1", DET_CODVEN) AS CODVEN ';
    Result := Result + '     FROM ';
    Result := Result + '       MOVDET ';
    Result := Result + '     WHERE DET_TIPFAT = GER_ESPDOC ';
    Result := Result + '       AND DET_NUMFAT = GER_NUMDOC ';
    Result := Result + '       AND DET_EMPFAT = GER_CODEMP) ';
  end;

begin
  inherited Create;
  FPais := fSetaPais;

  strImpAju := fCfgSis('IMPAJU', varString);

  qryCfgRel := fCriaQuery;

  objLiberacao := TLiberacao.Create;

  blnExpedicao := False;
  blnSeparacaoDireto := False;  
  blnTelaReimpressao := False;

  FFiltNE := blnFiltrarNE;
  FNumDoc := strNumDoc;
  FEspDoc := strEspDoc;
  FDtaIni := dtaDtaIni;
  FDtaFin := dtaDtaFin;
  FCodCli := strCodCli;
  FCodEmp := strCodEmp;
  FCodVen := strCodVen;
  FRecCliGar := blnRecClienteGar;
  FOrigemRomaneio := blnOrigemRomaneio;

  objDocumentos := TDocumentosReimpressao.Create(Nil);

  FPergSep := blnPergSep;
  FFatVenda := blnFatVenda;

  FAux001 := fCriaQuery;
  FAux002 := fCriaQuery;

  blnPreRomaneio := False;
  blnTemLay := False;

  FTipoConsCli := fStrToTipoConsCli( fCfgSis('CNSCRE', varString) );

  {*******************************}
  {* SELECT NAS TABELAS MOVGER/X *}
  {****************************AF*}

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';
  strSQL := strSQL + '  GER_SERIE_ AS SERIE_, ';
  strSQL := strSQL + '  IF(GER_ESPDOC <> "ML", IF(GER_NUMFAT IS NULL OR GER_NUMFAT = "", "", IFNULL('+fRetDetFat+', CONCAT(GER_NUMFAT, "-", GER_TIPFAT, "-", GER_EMPFAT))), CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP)) AS NUMFAT, ';
  strSQL := strSQL + '  CAST(" "  AS CHAR(100)) AS SITUACAO, ';
  If blnExiDocsCanc Then
  Begin
    strSQL := strSQL + '  "C" AS DOCCAN, ';
    strSQL := strSQL + '  MOVGER.MOTDEL AS MOTDEL, ';
    strSQL := strSQL + '  DATE_FORMAT(MOVGER.DTADEL,"%d/%m/%Y") AS DTADEL, ';
    strSQL := strSQL + '  MOVGER.OPEDEL AS OPEDEL, ';
  End
  Else
  Begin
    strSQL := strSQL + '  " " AS DOCCAN, ';
    strSQL := strSQL + '  " " AS MOTDEL, ';
    strSQL := strSQL + '  " " AS DTADEL, ';
    strSQL := strSQL + '  " " AS OPEDEL, ';
  End;

  strSQL := strSQL + '  GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  IF(GER_ESPDOC = "ML", GER_NUMFAT, GER_NUMDOC) AS NUMDOC, ';
  strSQL := strSQL + '  IF(GER_ESPDOC = "ML", GER_TIPFAT, GER_ESPDOC) AS ESPDOC, ';
  strSQL := strSQL + '  IF(GER_ESPDOC = "ML" AND GER_TIPFAT = "AJ", "AJML", "") AS ESAJML, ';

  strSQL := strSQL + '  GER_CODEMP AS CODEMP, ';

  if fCfgSis('VNDSPD', varBoolean) then
    strSQL := strSQL + '  CAST(IF(GER_ESPDOC = "DV","   ",IFNULL(IFNULL('+fRetVendedorFat+', IFNULL('+fRetVendedorFut+', '+fRetVendedor_Pd+')), " ")) AS CHAR(64)) AS CODVEN, '
  else
    strSQL := strSQL + '  CAST(IF(GER_ESPDOC = "DV","   ", GER_CODVEN) AS CHAR(64)) AS CODVEN, ';

  strSQL := strSQL + '  GER_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  GER_VPAR01 AS VPAR01, ';
  strSQL := strSQL + '  GER_VPAR02 AS VPAR02, ';
  strSQL := strSQL + '  GER_VPAR03 AS VPAR03, ';
  strSQL := strSQL + '  GER_VPAR04 AS VPAR04, ';
  strSQL := strSQL + '  GER_VPAR05 AS VPAR05, ';
  strSQL := strSQL + '  GER_VPAR06 AS VPAR06, ';
  strSQL := strSQL + '  GER_VPAR07 AS VPAR07, ';
  strSQL := strSQL + '  GER_VPAR08 AS VPAR08, ';
  strSQL := strSQL + '  GER_VPAR09 AS VPAR09, ';
  strSQL := strSQL + '  GER_VPAR10 AS VPAR10, ';
  strSQL := strSQL + '  GER_VPAR11 AS VPAR11, ';
  strSQL := strSQL + '  GER_VPAR12 AS VPAR12, ';
  strSQL := strSQL + '  CLI_CODREG AS CODREG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_NOMCLI AS CLIORI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_I_M_P_ AS I_M_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_PRORUR AS PRORUR, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_MICEMP AS MICEMP, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_ORGPUB AS ORGPUB, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_DESPIS AS DESPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_ZONFRA AS ZONFRA, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_DESZON AS DESZON, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_PERMUT AS PERMUT, '; // USADO PARA REIMPRESSÃO DE NOTA  
  strSQL := strSQL + '  CLI_SUFRAM AS CODZFM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_EXPIND AS EXPIND, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CONSUM AS CONSUM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_TABPRE AS TABPRE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODDIG AS CODDIG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IFNULL((SELECT DET_CODREP FROM MOVDET        ';
  strSQL := strSQL + '          WHERE DET_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '          LIMIT 1),CLI_CODREP) AS CODREP,      '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CONPAG AS CONPAG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODCND AS CODCND, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODFPG AS CODFPG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CLAFIS AS CLAFIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_TOTPRO AS TOTPRO, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTCUS AS TOTCUS, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_DESESP AS DESESP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PORDES AS PORDES, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASRET AS BASRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQRET AS ALQRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTRET AS TOTRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_RET_SP AS RET_SP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BARTSP AS BARTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_VLRTSP AS VLRTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASICM AS BASICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQICM AS ALQICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTICM AS TOTICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASIPI AS BASIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQIPI AS ALQIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTIPI AS TOTIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_CODTRA AS CODTRA, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TIPFRE AS TIPFRE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTFRE AS TOTFRE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PESBRU AS PESBRU, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PESLIQ AS PESLIQ, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_VOLUME AS VOLUME, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_NCONHE AS NCONHE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASSIM AS BASSIM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MARCA_ AS MARCA_, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ESPECI AS ESPECI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN001 AS MEN001, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN002 AS MEN002, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN003 AS MEN003, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN004 AS MEN004, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN005 AS MEN005, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_CLAFI2 AS CLAFI2, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_CLAFI3 AS CLAFI3, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_NATOPE AS NATOPE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  MOVGER.AUTOINCREM AS AUTINC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CAST(IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_CGCCPF, CLI_CGCCPF) AS UNSIGNED) AS CGCCPF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_NOMCON, CLI_NOMCLI) AS CLINOM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_ENDCON, CLI_ENDERE) AS ENDERE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%","", CLI_ENDNUM) AS ENDNUM, ';         // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%","", CLI_ENDCOM) AS ENDCOM, ';         // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_BAICON, CLI_BAIRRO) AS BAIRRO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_CEPCON, CLI_C_E_P_) AS C_E_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_CIDCON, CLI_CODCID) AS CODCID, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_TELCON, CLI_FONE01) AS FONE01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_R_GCON, CLI_NUMR_G) AS NUM_RG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_CGCCON, CLI_C_G_C_) AS C_G_C_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_IESCON, CLI_I_E_S_) AS I_E_S_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_NOMCON, CONCAT(GER_CODCLI,"-",CLI_NOMCLI)) AS NOMCLI, ';
  strSQL := strSQL + '  CLI_DIFERI AS DIFERI, ';
  strSQL := strSQL + '  CLI_DIF_ST AS DIF_ST, ';
  strSQL := strSQL + '  CLI_SITP_C AS SITP_C, ';
  strSQL := strSQL + '  CLI_MENP_C AS MENP_C, ';
  strSQL := strSQL + '  CLI_REDICM AS REDICM, ';
  strSQL := strSQL + '  CLI_DESOPE AS DESOPE, ';
  strSQL := strSQL + '  CLI_COBISS AS COBISS, ';
  strSQL := strSQL + '  CLI_CODOBR AS CODOBR, ';
  strSQL := strSQL + '  CLI_CODART AS CODART, ';
  strSQL := strSQL + '  CLI_CODATI AS CODATI, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_CODS01 AS CODS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS02 AS CODS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS03 AS CODS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS04 AS CODS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS05 AS CODS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS06 AS CODS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS07 AS CODS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS08 AS CODS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS09 AS CODS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS10 AS CODS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS11 AS CODS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS12 AS CODS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS13 AS CODS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS14 AS CODS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS15 AS CODS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS16 AS CODS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS17 AS CODS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS18 AS CODS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS19 AS CODS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS20 AS CODS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS21 AS CODS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS22 AS CODS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS23 AS CODS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS24 AS CODS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS25 AS CODS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS26 AS CODS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS27 AS CODS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS28 AS CODS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS29 AS CODS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS30 AS CODS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_DESS01 AS DESS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS02 AS DESS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS03 AS DESS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS04 AS DESS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS05 AS DESS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS06 AS DESS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS07 AS DESS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS08 AS DESS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS09 AS DESS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS10 AS DESS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS11 AS DESS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS12 AS DESS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS13 AS DESS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS14 AS DESS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS15 AS DESS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS16 AS DESS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS17 AS DESS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS18 AS DESS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS19 AS DESS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS20 AS DESS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS21 AS DESS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS22 AS DESS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS23 AS DESS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS24 AS DESS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS25 AS DESS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS26 AS DESS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS27 AS DESS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS28 AS DESS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS29 AS DESS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS30 AS DESS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_VALS01 - IF(IFNULL(GER_DECS01,0) <> 0, (IFNULL(GER_VALS01,0) * (IFNULL(GER_DECS01,0) / 100)), 0) AS VALS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS02 - IF(IFNULL(GER_DECS03,0) <> 0, (IFNULL(GER_VALS02,0) * (IFNULL(GER_DECS02,0) / 100)), 0) AS VALS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS03 - IF(IFNULL(GER_DECS03,0) <> 0, (IFNULL(GER_VALS03,0) * (IFNULL(GER_DECS03,0) / 100)), 0) AS VALS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS04 - IF(IFNULL(GER_DECS04,0) <> 0, (IFNULL(GER_VALS04,0) * (IFNULL(GER_DECS04,0) / 100)), 0) AS VALS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS05 - IF(IFNULL(GER_DECS05,0) <> 0, (IFNULL(GER_VALS05,0) * (IFNULL(GER_DECS05,0) / 100)), 0) AS VALS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS06 - IF(IFNULL(GER_DECS06,0) <> 0, (IFNULL(GER_VALS06,0) * (IFNULL(GER_DECS06,0) / 100)), 0) AS VALS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS07 - IF(IFNULL(GER_DECS07,0) <> 0, (IFNULL(GER_VALS07,0) * (IFNULL(GER_DECS07,0) / 100)), 0) AS VALS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS08 - IF(IFNULL(GER_DECS08,0) <> 0, (IFNULL(GER_VALS08,0) * (IFNULL(GER_DECS08,0) / 100)), 0) AS VALS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS09 - IF(IFNULL(GER_DECS09,0) <> 0, (IFNULL(GER_VALS09,0) * (IFNULL(GER_DECS09,0) / 100)), 0) AS VALS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS10 - IF(IFNULL(GER_DECS10,0) <> 0, (IFNULL(GER_VALS10,0) * (IFNULL(GER_DECS10,0) / 100)), 0) AS VALS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS11 - IF(IFNULL(GER_DECS11,0) <> 0, (IFNULL(GER_VALS11,0) * (IFNULL(GER_DECS11,0) / 100)), 0) AS VALS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS12 - IF(IFNULL(GER_DECS13,0) <> 0, (IFNULL(GER_VALS12,0) * (IFNULL(GER_DECS12,0) / 100)), 0) AS VALS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS13 - IF(IFNULL(GER_DECS13,0) <> 0, (IFNULL(GER_VALS13,0) * (IFNULL(GER_DECS13,0) / 100)), 0) AS VALS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS14 - IF(IFNULL(GER_DECS14,0) <> 0, (IFNULL(GER_VALS14,0) * (IFNULL(GER_DECS14,0) / 100)), 0) AS VALS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS15 - IF(IFNULL(GER_DECS15,0) <> 0, (IFNULL(GER_VALS15,0) * (IFNULL(GER_DECS15,0) / 100)), 0) AS VALS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS16 - IF(IFNULL(GER_DECS16,0) <> 0, (IFNULL(GER_VALS16,0) * (IFNULL(GER_DECS16,0) / 100)), 0) AS VALS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS17 - IF(IFNULL(GER_DECS17,0) <> 0, (IFNULL(GER_VALS17,0) * (IFNULL(GER_DECS17,0) / 100)), 0) AS VALS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS18 - IF(IFNULL(GER_DECS18,0) <> 0, (IFNULL(GER_VALS18,0) * (IFNULL(GER_DECS18,0) / 100)), 0) AS VALS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS19 - IF(IFNULL(GER_DECS19,0) <> 0, (IFNULL(GER_VALS19,0) * (IFNULL(GER_DECS19,0) / 100)), 0) AS VALS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS20 - IF(IFNULL(GER_DECS20,0) <> 0, (IFNULL(GER_VALS20,0) * (IFNULL(GER_DECS20,0) / 100)), 0) AS VALS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS21 - IF(IFNULL(GER_DECS21,0) <> 0, (IFNULL(GER_VALS21,0) * (IFNULL(GER_DECS21,0) / 100)), 0) AS VALS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS22 - IF(IFNULL(GER_DECS23,0) <> 0, (IFNULL(GER_VALS22,0) * (IFNULL(GER_DECS22,0) / 100)), 0) AS VALS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS23 - IF(IFNULL(GER_DECS23,0) <> 0, (IFNULL(GER_VALS23,0) * (IFNULL(GER_DECS23,0) / 100)), 0) AS VALS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS24 - IF(IFNULL(GER_DECS24,0) <> 0, (IFNULL(GER_VALS24,0) * (IFNULL(GER_DECS24,0) / 100)), 0) AS VALS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS25 - IF(IFNULL(GER_DECS25,0) <> 0, (IFNULL(GER_VALS25,0) * (IFNULL(GER_DECS25,0) / 100)), 0) AS VALS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS26 - IF(IFNULL(GER_DECS26,0) <> 0, (IFNULL(GER_VALS26,0) * (IFNULL(GER_DECS26,0) / 100)), 0) AS VALS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS27 - IF(IFNULL(GER_DECS27,0) <> 0, (IFNULL(GER_VALS27,0) * (IFNULL(GER_DECS27,0) / 100)), 0) AS VALS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS28 - IF(IFNULL(GER_DECS28,0) <> 0, (IFNULL(GER_VALS28,0) * (IFNULL(GER_DECS28,0) / 100)), 0) AS VALS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS29 - IF(IFNULL(GER_DECS29,0) <> 0, (IFNULL(GER_VALS29,0) * (IFNULL(GER_DECS29,0) / 100)), 0) AS VALS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS30 - IF(IFNULL(GER_DECS30,0) <> 0, (IFNULL(GER_VALS30,0) * (IFNULL(GER_DECS30,0) / 100)), 0) AS VALS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_PRAENT AS PRAENT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_TOTSER AS TOTSER, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALISS AS VALISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PERISS AS PERISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_HORENT AS HORENT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESACE AS DESACE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQIRF AS ALQIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALIRF AS VALIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQPIS AS ALQPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALPIS AS VALPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQCOF AS ALQCOF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALCOF AS VALCOF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQCSL AS ALQCSL, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALCSL AS VALCSL, '; // USADO PARA REIMPRESSÃO DE NOTA

  if (fCfgSis('SIMPAU', varBoolean) and fCfgSis('RETIMP', varBoolean)) then
  begin
    strSQL := strSQL + '  "N" AS RETPCO, ';        // USADO PARA REIMPRESSÃO DE NOTA
    strSQL := strSQL + '  "N" AS RETIRF, ';        // USADO PARA REIMPRESSÃO DE NOTA
    strSQL := strSQL + '  "N" AS CDESPI, ';        // USADO PARA REIMPRESSÃO DE NOTA
  end
  else
  begin
    strSQL := strSQL + '  CLI_RETPCO AS RETPCO, '; // USADO PARA REIMPRESSÃO DE NOTA
    strSQL := strSQL + '  CLI_RETIRF AS RETIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
    strSQL := strSQL + '  CLI_CDESPI AS CDESPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  end;

  strSQL := strSQL + '  CLI_RETISS AS RETISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_SEGSOC AS SEGSOC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_SITIPI AS SITIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_ENQIPI AS ENQIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_MENIPI AS MENIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_ORPURD AS ORPURD, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_CALICM AS CALICM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_NOTRET AS NOTRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRFRET AS IRFRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISRET AS PISRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COFRET AS COFRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSLRET AS CSLRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_SERRET AS SERRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_NORESE AS NORESE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRPRRT AS IRPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRPRDV AS IRPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRSERT AS IRSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRSEDV AS IRSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PIPRRT AS PIPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PIPRDV AS PIPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISERT AS PISERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISEDV AS PISEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COPRRT AS COPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COPRDV AS COPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COSERT AS COSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COSEDV AS COSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSPRRT AS CSPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSPRDV AS CSPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSSERT AS CSSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSSEDV AS CSSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VLSGSO AS VLSGSO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PESGSO AS PESGSO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0000000.00 AS DUPREC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_BASORG AS BASORG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ICMORG AS ICMORG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ENTFAT AS ENTFAT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_NOTESP AS NOTESP, ';
  strSQL := strSQL + '  "MOVGER     " AS TABELA, ';
  strSQL := strSQL + '  GER_TIP_FC AS TIP_FC, ';
  strSQL := strSQL + '  GER_ORIDOC AS ORIDOC, ';

  If fEmptyStr(strImpAju) Then
  Begin
    strSQL := strSQL + '  IF(GER_ESPDOC = "ML" AND (SELECT DET_TIPFAT FROM MOVDET WHERE MOVDET.DET_SEQGER = MOVGER.AUTOINCREM LIMIT 1) = "AJ", ';
    strSQL := strSQL + '  (SELECT SUM(DET_VLRCON * IF(DET_CLAFIS < 5000,1, -1)) FROM MOVDET WHERE MOVDET.DET_SEQGER = MOVGER.AUTOINCREM), ';
    strSQL := strSQL + '  GER_VLRCON) AS VLRCON, ';
  End
  Else
  Begin
    strCmpAju := ' SELECT SUM(ABS(DET_'+strImpAju+') * IF(LEFT(DET_CLAFIS,1)>=5, -1, 1)) '+
                 '   FROM MOVDET DD '+
                 '  INNER JOIN MOVTRI TT ON DD.AUTOINCREM = TT.DET_SEQGER '+
                 '  WHERE DD.DET_SEQGER = MOVGER.AUTOINCREM ';

    strCmpAjuMl := 'IF(GER_ESPDOC="AJ", ('+strCmpAju+'),  ';
    strCmpAjuMl := strCmpAjuMl + '  IF(GER_ESPDOC = "ML" AND (SELECT DET_TIPFAT FROM MOVDET WHERE MOVDET.DET_SEQGER = MOVGER.AUTOINCREM LIMIT 1) = "AJ", ';
    strCmpAjuMl := strCmpAjuMl + '  (SELECT SUM(DET_VLRCON * IF(DET_CLAFIS < 5000,1, -1)) FROM MOVDET WHERE MOVDET.DET_SEQGER = MOVGER.AUTOINCREM), ';
    strCmpAjuMl := strCmpAjuMl + '  GER_VLRCON))  AS VLRCON, ';


    strSQL := strSQL + strCmpAjuMl;
  End;

  strSQL := strSQL + '  IFNULL(IFNULL('+fRetDocFat+', IFNULL('+fRetDocFut+', '+fRetNum_Pd+')), " ") AS DOCORI, ';
  strSQL := strSQL + '  "N" AS DOCFOR,  ';
  strSQL := strSQL + '  GER_NROCEI AS NROCEI, ';
  strSQL := strSQL + '  CAST(" " AS CHAR(20)) AS ORDPRO  ';
  strSQL := strSQL + 'FROM ';

  strSQL := strSQL + '  MOVGER ';

  //TEM QUE SER INNER JOIN, ESTAVA MOSTRANDO DOCUMENTOS DE FORNECEDOR DUPLICADOS
  //E UM DOS DOCUMENTOS ESTAVA COM NOME DO FORNECEDOR EM BRANCO
  strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN SERMOV ON SERMOV.GER_SEQGER = MOVGER.AUTOINCREM ';

  if (not fEmptyStr(strPlaVei)) and ((fEmptyStr(strNumDoc)) or ((fEmptyStr(strEspDoc)))) then
    strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';

  if not fEmptyStr(strNumCoo) Then
  Begin
    strSQL := strSQL + ' INNER JOIN CADFIS ON FIS_NUMDOC = GER_NUMDOC AND ';
    strSQL := strSQL + '                      FIS_ESPDOC = GER_ESPDOC AND ';
    strSQL := strSQL + '                      FIS_CODEMP = GER_CODEMP AND ';
    strSQL := strSQL + '                      FIS_FORCLI = IF(FIS_TIP_FC = "C", GER_CODCLI, GER_CODFOR) AND ';
    strSQL := strSQL + '                      FIS_SERIE_ = GER_SERIE_     ';
  End;

  strSQL := strSQL + 'WHERE ';

  objGarantiaFiltroCancelamentoEspecieOF:= TSQLGarantiaFiltroCancelamentoEspecieOF.Create;
  Try
    objGarantiaFiltroCancelamentoEspecieOF.strEspecieSelecionada:= strEspSel;
    strSQL:= strSQL + objGarantiaFiltroCancelamentoEspecieOF.fRetornaFiltrovGarantiaValidaOF;
  Finally
    FreeAndNil(objGarantiaFiltroCancelamentoEspecieOF);
  End;


  if not fEmptyStr(strNumCoo) Then
    strSQL := strSQL + ' FIS_NUMCOO = ' + QuotedStr(strNumCoo) + ' AND ';

  Case intFilCla Of
    1: strSQL := strSQL + '  LOCATE(GER_CLAFIS, "' + VS_strClaVen + '") > 0 AND ';
    2: strSQL := strSQL + '  LOCATE(GER_CLAFIS, "' + VS_strClaDev + '") > 0 AND ';
    3: strSQL := strSQL + ' (LOCATE(GER_CLAFIS, "' + VS_strClaVen + '") <= 0) AND (LOCATE(GER_CLAFIS, "' + VS_strClaDev + '") <= 0) AND ';
  End;

  If blnFiltrarNE Then
  Begin
    strSQL := strSQL + ' ( (GER_ORIDOC IN ("V","C")) OR (LOCATE(GER_ESPDOC, "AJ_RQ_TA_TL_TE_ML_BE_") > 0) OR (';
    strSQL := strSQL + '  SELECT COUNT(*) FROM MOVDET DT ';
    strSQL := strSQL + '            INNER JOIN MOVGRC GR ON GR.GRC_SEQDET = DT.AUTOINCREM ';
    strSQL := strSQL + '  WHERE DT.DET_SEQGER = MOVGER.AUTOINCREM AND GRC_OPCDOC = "NE") > 0 ) AND ';
  End
  Else
  Begin

    If Not fEmptyStr(strOriDoc) Then
      strSQL := strSQL + ' GER_ORIDOC = ' + QuotedStr(strOriDoc) + ' AND ';

  End;

//  If fCfgSis('PAFECF', varBoolean) Then
//    strSQL := strSQL + '  GER_ESPDOC   <> "IF"    AND ';

  strSQL := strSQL + '  GER_ESPDOC   <> "GA"    AND ';
  strSQL := strSQL + '  GER_ESPDOC   <> "PD"    AND ';
  strSQL := strSQL + '  GER_ESPDOC   <> "TM"    AND ';
  strSQL := strSQL + '  GER_ESPDOC   <> "PR"    AND ';
  strSQL := strSQL + '  IF(GER_ESPDOC = "ML" AND  GER_TIPFAT = "AJ", TRUE, GER_ESPDOC <> "ML") AND ';
  strSQL := strSQL + '  GER_ESPDOC   <> "AB"    AND ';

  If (fEmptyStr(strNumDoc)) And (fEmptyStr(strEspDoc)) Then
    strSQL := strSQL + '  GER_ESPDOC   <> "RO"    AND ';

  If Not fEmptyStr(strTip_Fc) Then
    strSQL := strSQL + '  GER_TIP_FC  = :TIP_FC AND ';

  If (Not fEmptyStr(strNumDoc)) And (Not fEmptyStr(strEspDoc)) Then
  Begin

    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC     ';

    If blnCancelamento Then
    Begin
      If (strTip_Fc = 'F') And ( Pos(strEspSel, 'NE_OF_NG_NP_') > 0 ) Then
      Begin
        strSQL := strSQL + ' AND GER_CODFOR = :CODCLI ';
        strSQL := strSQL + ' AND GER_SERIE_ = :SERIE_ ';
      End
      Else
      Begin
        strSQL := strSQL + ' AND GER_CODCLI = :CODCLI ';

        If (Pos(strEspSel, 'NF_EL_') > 0 ) Then
          strSQL := strSQL + ' AND GER_SERIE_ = :SERIE_ ';
      End;
    End
    Else
    Begin
      If (Not fEmptyStr(strSerie)) Then
        strSQL := strSQL + ' AND GER_SERIE_ = :SERIE_ ';
    End;

    If (Not fEmptyStr(strCodVen)) Then
      strSQL := strSQL + 'AND GER_CODVEN = :CODVEN ';

    If Not fEmptyStr(strCodEmp) Then
      strSQL := strSQL + 'AND GER_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + 'AND ' + fGetSQLInEmpresasReimpressao('GER_CODEMP') + ' ';

    If Not fEmptyStr(strCodCli) Then
      strSQL := strSQL + ' AND GER_CODCLI = :CODCLI ';
  End
  Else
  Begin

    strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(strNumDoc) Then
      strSQL := strSQL + 'AND GER_NUMDOC = :NUMDOC ';

    If Not fEmptyStr(strEspDoc) Then
      strSQL := strSQL + ' AND GER_ESPDOC = :ESPDOC ';

    If Not fEmptyStr(strCodEmp) Then
      strSQL := strSQL + 'AND GER_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + 'AND ' + fGetSQLInEmpresasReimpressao('GER_CODEMP') + ' ';

    If Not fEmptyStr(strCodCli) Then
      strSQL := strSQL + 'AND GER_CODCLI = :CODCLI ';

    If Not fEmptyStr(strCodVen) Then
      strSQL := strSQL + 'AND GER_CODVEN = :CODVEN ';

    if (not fEmptyStr(strPlaVei)) then
      strSQL := strSQL + 'AND AUX_PLAVEI = :PLAVEI ';

    If (Not fEmptyStr(strSerie)) Then
      strSQL := strSQL + ' AND GER_SERIE_ = :SERIE_ ';

  End;

  If (FTipoConsCli = tpLibCliVenLog) and (strTip_Fc = 'C') and fEmptyStr(strCodCli) Then
  Begin
    strSQL := strSQL + ' AND CLI_CODVEN =  ' + QuotedStr(strLoginUsuarioLogado);
  End;

  objDocumentos.strSqlDocs := strSQL + ' AND FALSE ';//CRIA O CLIENTDATASET DA REIMPRESSAO
  //objDocumentos.pCarregarDocumentos;

  If blnExiDocsCanc Then
  Begin
    strSQL2 := AnsiReplaceStr(
               AnsiReplaceStr(
               AnsiReplaceStr(
               AnsiReplaceStr(
               AnsiReplaceStr(strSQL, 'MOVGER', 'DEL_MOVGER'),
                                      'SERMOV', 'DEL_SERMOV'),
                                      'FATDOR', 'DEL_FATDOR'),
                                      'MOVDET', 'DEL_MOVDET'),
                                      'AUXMOV', 'DEL_AUXMOV');

    strSQL := AnsiReplaceStr(strSQL, '"C" AS DOCCAN', '" " AS DOCCAN');
    strSQL := AnsiReplaceStr(strSQL, 'MOVGER.MOTDEL AS MOTDEL', '" " AS MOTDEL');
    strSQL := AnsiReplaceStr(strSQL, 'MOVGER.OPEDEL AS OPEDEL', '" " AS OPEDEL');
    strSQL := AnsiReplaceStr(strSQL, 'DATE_FORMAT(MOVGER.DTADEL,"%d/%m/%Y") AS DTADEL', '" " AS DTADEL');

    strSQL  := strSQL + ' UNION ALL ' + strSQL2;
  End;

  objDocumentos.strSqlDocs := strSQL;

  If Not fEmptyStr(strTip_Fc) Then
    objDocumentos.pAddFiltro('TIP_FC', strTip_Fc);

  If (Not fEmptyStr(strNumDoc)) And (Not fEmptyStr(strEspDoc)) Then
  Begin
    objDocumentos.pAddFiltro('NUMDOC', strNumDoc);
    objDocumentos.pAddFiltro('ESPDOC', IIF(SameText(strEspDoc, 'ML'), 'AJ', strEspDoc));

    If blnCancelamento Then
    Begin
      If (strEspSel = 'NE') Or (strEspSel = 'OF') Or (strEspSel = 'NP') Or ((strTip_Fc = 'C') And (Pos(strEspSel, 'NE_EL_NF_') > 0)) Then
        objDocumentos.pAddFiltro('SERIE_', strSerie);
    End
    Else
    Begin
      If Not fEmptyStr(strSerie) Then
        objDocumentos.pAddFiltro('SERIE_', strSerie);
    End;

    If Not fEmptyStr(strCodVen) Then
      objDocumentos.pAddFiltro('CODVEN', strCodVen);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

    If Not fEmptyStr(strCodCli) Then
      objDocumentos.pAddFiltro('CODCLI', strCodCli);
  End
  Else
  Begin
    objDocumentos.pAddFiltro('DTAINI', dtaDtaIni);
    objDocumentos.pAddFiltro('DTAFIN', dtaDtaFin);

    If Not fEmptyStr(strNumDoc) Then
      objDocumentos.pAddFiltro('NUMDOC', strNumDoc);

    If Not fEmptyStr(strEspDoc) Then
      objDocumentos.pAddFiltro('ESPDOC', strEspDoc);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

    If Not fEmptyStr(strCodCli) Then
      objDocumentos.pAddFiltro('CODCLI', strCodCli);

    If Not fEmptyStr(strCodVen) Then
      objDocumentos.pAddFiltro('CODVEN', strCodVen);

    if (not fEmptyStr(strPlaVei)) then
      objDocumentos.pAddFiltro('PLAVEI', strPlaVei);

    If Not fEmptyStr(strSerie) Then
      objDocumentos.pAddFiltro('SERIE_', strSerie);
  End;

  objDocumentos.pCarregarDocumentos;

  strSQL := '';
  strSQL := strSQL + fGetSqlOutrasSaidasFornecedor(strNumDoc,
                                                   strEspDoc,
                                                   dtaDtaIni,
                                                   dtaDtaFin,
                                                   strCodCli,
                                                   strCodEmp,
                                                   strCodVen,
                                                   strTip_Fc,
                                                   intFilCla,
                                                   blnCancelamento,
                                                   blnExiDocsCanc,
                                                   strNumCoo,
                                                   strSerie);

  If blnExiDocsCanc Then
  Begin
    strSQL2 := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVGER','DEL_MOVGER'), 'SERMOV', 'DEL_SERMOV'),'MOVDET','DEL_MOVDET');

    strSQL := AnsiReplaceStr(strSQL, '"C" AS DOCCAN', '" " AS DOCCAN');
    strSQL := AnsiReplaceStr(strSQL, 'MOVGER.MOTDEL AS MOTDEL', '" " AS MOTDEL');
    strSQL := AnsiReplaceStr(strSQL, 'MOVGER.OPEDEL AS OPEDEL', '" " AS OPEDEL');
    strSQL := AnsiReplaceStr(strSQL, 'DATE_FORMAT(MOVGER.DTADEL,"%d/%m/%Y") AS DTADEL', '" " AS DTADEL');

    strSQL  := strSQL + ' UNION ALL ' + strSQL2;
  End;

  objDocumentos.strSqlDocs := strSQL;

  If (Not fEmptyStr(strNumDoc)) And (Not fEmptyStr(strEspDoc)) Then
  Begin

    objDocumentos.pAddFiltro('NUMDOC', strNumDoc);
    objDocumentos.pAddFiltro('ESPDOC', strEspDoc);

    If (blnCancelamento) And (strTip_Fc = 'F') Then
    Begin
      If strEspDoc <> 'GF' Then
        objDocumentos.pAddFiltro('SERIE_', strSerie);

      objDocumentos.pAddFiltro('CODCLI', strCodCli);
    End
    Else
    Begin
      If Not fEmptyStr(strSerie) Then
        objDocumentos.pAddFiltro('SERIE_', strSerie);

      If Not fEmptyStr(strCodCli) Then
        objDocumentos.pAddFiltro('CODCLI', strCodCli);
    End;

    If Not fEmptyStr(strCodVen) Then
      objDocumentos.pAddFiltro('CODVEN', strCodVen);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

  End
  Else
  Begin

    objDocumentos.pAddFiltro('DTAINI', dtaDtaIni);
    objDocumentos.pAddFiltro('DTAFIN', dtaDtaFin);

    If Not fEmptyStr(strNumDoc) Then
      objDocumentos.pAddFiltro('NUMDOC', strNumDoc);

    If Not fEmptyStr(strEspDoc) Then
      objDocumentos.pAddFiltro('ESPDOC', strEspDoc);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

    If Not fEmptyStr(strCodCli) Then
      objDocumentos.pAddFiltro('CODCLI', strCodCli);

    If Not fEmptyStr(strCodVen) Then
      objDocumentos.pAddFiltro('CODVEN', strCodVen);

    If Not fEmptyStr(strSerie) Then
      objDocumentos.pAddFiltro('SERIE_', strSerie);

  End;

  objDocumentos.pCarregarDocumentos;

  {****************************}
  {* SELECT NAS TABELA FATGOR *}
  {*************************AF*}
  strFatGor := '';
  strFatGor := strFatGor + 'SELECT SQL_NO_CACHE     ';
  strFatGor := strFatGor + '  FGO_SERIE_ AS SERIE_, ';
  strFatGor := strFatGor + '  ( '+ fRetFatFat +') AS NUMFAT, ';
  strFatGor := strFatGor + '  IF(FGO_MOTBAI IS NULL OR FGO_MOTBAI = "", CAST(" "  AS CHAR(100)) , ' ;
  strFatGor := strFatGor + ' CONCAT("BAIXADO-OPER: ",(SUBSTRING(FATGOR.FGO_MOTBAI,(LOCATE("OPE", FATGOR.FGO_MOTBAI))+5)))) AS SITUACAO, ';

  If blnExiDocsCanc Then
  Begin
    strFatGor := strFatGor + '  "C" AS DOCCAN, ';
    strFatGor := strFatGor + '  FATGOR.MOTDEL AS MOTDEL, ';
    strFatGor := strFatGor + '  DATE_FORMAT(FATGOR.DTADEL,"%d/%m/%Y") AS DTADEL, ';
    strFatGor := strFatGor + '  FATGOR.OPEDEL AS OPEDEL, ';
  End
  Else
  Begin
    strFatGor := strFatGor + ' IF(LOCATE("DADOS BAIXA", FATGOR.FGO_MOTBAI), "B", " ") AS DOCCAN, ';
    strFatGor := strFatGor + '  " " AS MOTDEL, ';
    strFatGor := strFatGor + '  " " AS DTADEL, ';
    strFatGor := strFatGor + '  " " AS OPEDEL, ';
  End;

  strFatGor := strFatGor + '  FGO_DTAENT AS DTAENT, ';
  strFatGor := strFatGor + '  FGO_NUMDOC AS NUMDOC, ';
  strFatGor := strFatGor + '  FGO_ESPDOC AS ESPDOC, ';
  strFatGor := strFatGor + '  " "  AS ESAJML, ';
  strFatGor := strFatGor + '  FGO_CODEMP AS CODEMP, ';

  if fCfgSis('VNDSPD', varBoolean) then
  begin
    strFatGor := strFatGor + '  (SELECT IF(LENGTH(GROUP_CONCAT(DISTINCT FDO_CODVEN)) - LENGTH(REPLACE(GROUP_CONCAT(DISTINCT FDO_CODVEN), ",", "")) >= 1, "+1", FDO_CODVEN) AS CODVEN ';
    strFatGor := strFatGor + '    FROM FATDOR ';
    strFatGor := strFatGor + '   WHERE FDO_SEQGER = FATGOR.AUTOINCREM)  AS CODVEN,  ';
  end
  else
    strFatGor := strFatGor + '  CAST(FGO_CODVEN AS CHAR(64)) AS CODVEN, ';

  strFatGor := strFatGor + '  FGO_CODCLI AS CODCLI, ';
  strFatGor := strFatGor + '  0.00       AS VPAR01, ';
  strFatGor := strFatGor + '  0.00       AS VPAR02, ';
  strFatGor := strFatGor + '  0.00       AS VPAR03, ';
  strFatGor := strFatGor + '  0.00       AS VPAR04, ';
  strFatGor := strFatGor + '  0.00       AS VPAR05, ';
  strFatGor := strFatGor + '  0.00       AS VPAR06, ';
  strFatGor := strFatGor + '  0.00       AS VPAR07, ';
  strFatGor := strFatGor + '  0.00       AS VPAR08, ';
  strFatGor := strFatGor + '  0.00       AS VPAR09, ';
  strFatGor := strFatGor + '  0.00       AS VPAR10, ';
  strFatGor := strFatGor + '  0.00       AS VPAR11, ';
  strFatGor := strFatGor + '  0.00       AS VPAR12, ';
  strFatGor := strFatGor + '  CLI_CODREG AS CODREG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  CLI_NOMCLI AS CLIORI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  CLI_I_M_P_ AS I_M_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  CLI_PRORUR AS PRORUR, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  CLI_MICEMP AS MICEMP, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  CLI_ORGPUB AS ORGPUB, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  CLI_DESPIS AS DESPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  CLI_ZONFRA AS ZONFRA, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  CLI_DESZON AS DESZON, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  CLI_PERMUT AS PERMUT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  CLI_SUFRAM AS CODZFM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  CLI_EXPIND AS EXPIND, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  CLI_CONSUM AS CONSUM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  CLI_TABPRE AS TABPRE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODDIG AS CODDIG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '    IFNULL((SELECT FDO_CODREP FROM FATDOR        ';
  strFatGor := strFatGor + '            WHERE FDO_SEQGER = FATGOR.AUTOINCREM ';
  strFatGor := strFatGor + '            LIMIT 1),CLI_CODREP) AS CODREP,      '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CONPAG AS CONPAG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODCND AS CODCND, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODFPG AS CODFPG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  ""         AS CLAFIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_TOTPRO AS TOTPRO, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_TOTCUS AS TOTCUS, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_DESESP AS DESESP, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_PORDES AS PORDES, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_BASRET AS BASRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_ALQRET AS ALQRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_TOTRET AS TOTRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  0          AS RET_SP, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  0          AS BARTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  0          AS VLRTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_BASICM AS BASICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_ALQICM AS ALQICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_TOTICM AS TOTICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_BASIPI AS BASIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_ALQIPI AS ALQIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_TOTIPI AS TOTIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_CODTRA AS CODTRA, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_TIPFRE AS TIPFRE, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_TOTFRE AS TOTFRE, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_PESBRU AS PESBRU, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_PESLIQ AS PESLIQ, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_VOLUME AS VOLUME, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  -1         AS NCONHE, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_BASSIM AS BASSIM, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_MARCA_ AS MARCA_, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_ESPECI AS ESPECI, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_MEN001 AS MEN001, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  FGO_MEN002 AS MEN002, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  " "        AS MEN003, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  " "        AS MEN004, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  " "        AS MEN005, '; // USADO PARA REIMPRESSAO DE NOTA
  strFatGor := strFatGor + '  " "        AS CLAFI2, ';
  strFatGor := strFatGor + '  " "        AS CLAFI3, ';
  strFatGor := strFatGor + '  " "        AS NATOPE, ';
  strFatGor := strFatGor + '  FATGOR.AUTOINCREM AS AUTINC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  CAST(IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_CGCCPF,CLI_CGCCPF) AS UNSIGNED) AS CGCCPF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_NOMCON,CLI_NOMCLI) AS CLINOM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_ENDCON,CLI_ENDERE) AS ENDERE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%","", CLI_ENDNUM) AS ENDNUM, ';        // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%","", CLI_ENDCOM) AS ENDCOM, ';        // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_BAICON,CLI_BAIRRO) AS BAIRRO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_CIDCON,CLI_CODCID) AS CODCID, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_CEPCON,CLI_C_E_P_) AS C_E_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_TELCON,CLI_FONE01) AS FONE01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_R_GCON,CLI_NUMR_G) AS NUM_RG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_CGCCON,CLI_C_G_C_) AS C_G_C_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_IESCON,CLI_I_E_S_) AS I_E_S_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",FGO_NOMCON,CONCAT(FGO_CODCLI,"-",CLI_NOMCLI)) AS NOMCLI, ';
  strFatGor := strFatGor + '  CLI_DIFERI AS DIFERI, ';
  strFatGor := strFatGor + '  CLI_DIF_ST AS DIF_ST, ';
  strFatGor := strFatGor + '  CLI_SITP_C AS SITP_C, ';
  strFatGor := strFatGor + '  CLI_MENP_C AS MENP_C, ';
  strFatGor := strFatGor + '  CLI_REDICM AS REDICM, ';
  strFatGor := strFatGor + '  CLI_DESOPE AS DESOPE, ';
  strFatGor := strFatGor + '  CLI_COBISS AS COBISS, ';
  strFatGor := strFatGor + '  CLI_CODOBR AS CODOBR, ';
  strFatGor := strFatGor + '  CLI_CODART AS CODART, ';
  strFatGor := strFatGor + '  CLI_CODATI AS CODATI, '; // USADO PARA REIMPRESSÃO DE NOTA

  strFatGor := strFatGor + '  FGO_CODS01 AS CODS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS02 AS CODS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS03 AS CODS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS04 AS CODS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS05 AS CODS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS06 AS CODS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS07 AS CODS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS08 AS CODS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS09 AS CODS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS10 AS CODS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS11 AS CODS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS12 AS CODS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS13 AS CODS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS14 AS CODS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS15 AS CODS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS16 AS CODS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS17 AS CODS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS18 AS CODS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS19 AS CODS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS20 AS CODS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS21 AS CODS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS22 AS CODS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS23 AS CODS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS24 AS CODS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS25 AS CODS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS26 AS CODS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS27 AS CODS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS28 AS CODS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS29 AS CODS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_CODS30 AS CODS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strFatGor := strFatGor + '  FGO_DESS01 AS DESS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS02 AS DESS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS03 AS DESS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS04 AS DESS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS05 AS DESS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS06 AS DESS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS07 AS DESS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS08 AS DESS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS09 AS DESS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS10 AS DESS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS11 AS DESS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS12 AS DESS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS13 AS DESS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS14 AS DESS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS15 AS DESS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS16 AS DESS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS17 AS DESS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS18 AS DESS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS19 AS DESS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS20 AS DESS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS21 AS DESS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS22 AS DESS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS23 AS DESS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS24 AS DESS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS25 AS DESS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS26 AS DESS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS27 AS DESS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS28 AS DESS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS29 AS DESS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_DESS30 AS DESS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strFatGor := strFatGor + '  FGO_VALS01 - IF(IFNULL(FGO_DECS01,0) <> 0, (IFNULL(FGO_VALS01,0) * (IFNULL(FGO_DECS01,0) / 100)), 0) AS VALS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS02 - IF(IFNULL(FGO_DECS03,0) <> 0, (IFNULL(FGO_VALS02,0) * (IFNULL(FGO_DECS02,0) / 100)), 0) AS VALS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS03 - IF(IFNULL(FGO_DECS03,0) <> 0, (IFNULL(FGO_VALS03,0) * (IFNULL(FGO_DECS03,0) / 100)), 0) AS VALS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS04 - IF(IFNULL(FGO_DECS04,0) <> 0, (IFNULL(FGO_VALS04,0) * (IFNULL(FGO_DECS04,0) / 100)), 0) AS VALS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS05 - IF(IFNULL(FGO_DECS05,0) <> 0, (IFNULL(FGO_VALS05,0) * (IFNULL(FGO_DECS05,0) / 100)), 0) AS VALS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS06 - IF(IFNULL(FGO_DECS06,0) <> 0, (IFNULL(FGO_VALS06,0) * (IFNULL(FGO_DECS06,0) / 100)), 0) AS VALS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS07 - IF(IFNULL(FGO_DECS07,0) <> 0, (IFNULL(FGO_VALS07,0) * (IFNULL(FGO_DECS07,0) / 100)), 0) AS VALS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS08 - IF(IFNULL(FGO_DECS08,0) <> 0, (IFNULL(FGO_VALS08,0) * (IFNULL(FGO_DECS08,0) / 100)), 0) AS VALS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS09 - IF(IFNULL(FGO_DECS09,0) <> 0, (IFNULL(FGO_VALS09,0) * (IFNULL(FGO_DECS09,0) / 100)), 0) AS VALS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS10 - IF(IFNULL(FGO_DECS10,0) <> 0, (IFNULL(FGO_VALS10,0) * (IFNULL(FGO_DECS10,0) / 100)), 0) AS VALS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS11 - IF(IFNULL(FGO_DECS11,0) <> 0, (IFNULL(FGO_VALS11,0) * (IFNULL(FGO_DECS11,0) / 100)), 0) AS VALS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS12 - IF(IFNULL(FGO_DECS13,0) <> 0, (IFNULL(FGO_VALS12,0) * (IFNULL(FGO_DECS12,0) / 100)), 0) AS VALS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS13 - IF(IFNULL(FGO_DECS13,0) <> 0, (IFNULL(FGO_VALS13,0) * (IFNULL(FGO_DECS13,0) / 100)), 0) AS VALS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS14 - IF(IFNULL(FGO_DECS14,0) <> 0, (IFNULL(FGO_VALS14,0) * (IFNULL(FGO_DECS14,0) / 100)), 0) AS VALS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS15 - IF(IFNULL(FGO_DECS15,0) <> 0, (IFNULL(FGO_VALS15,0) * (IFNULL(FGO_DECS15,0) / 100)), 0) AS VALS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS16 - IF(IFNULL(FGO_DECS16,0) <> 0, (IFNULL(FGO_VALS16,0) * (IFNULL(FGO_DECS16,0) / 100)), 0) AS VALS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS17 - IF(IFNULL(FGO_DECS17,0) <> 0, (IFNULL(FGO_VALS17,0) * (IFNULL(FGO_DECS17,0) / 100)), 0) AS VALS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS18 - IF(IFNULL(FGO_DECS18,0) <> 0, (IFNULL(FGO_VALS18,0) * (IFNULL(FGO_DECS18,0) / 100)), 0) AS VALS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS19 - IF(IFNULL(FGO_DECS19,0) <> 0, (IFNULL(FGO_VALS19,0) * (IFNULL(FGO_DECS19,0) / 100)), 0) AS VALS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS20 - IF(IFNULL(FGO_DECS20,0) <> 0, (IFNULL(FGO_VALS20,0) * (IFNULL(FGO_DECS20,0) / 100)), 0) AS VALS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS21 - IF(IFNULL(FGO_DECS21,0) <> 0, (IFNULL(FGO_VALS21,0) * (IFNULL(FGO_DECS21,0) / 100)), 0) AS VALS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS22 - IF(IFNULL(FGO_DECS23,0) <> 0, (IFNULL(FGO_VALS22,0) * (IFNULL(FGO_DECS22,0) / 100)), 0) AS VALS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS23 - IF(IFNULL(FGO_DECS23,0) <> 0, (IFNULL(FGO_VALS23,0) * (IFNULL(FGO_DECS23,0) / 100)), 0) AS VALS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS24 - IF(IFNULL(FGO_DECS24,0) <> 0, (IFNULL(FGO_VALS24,0) * (IFNULL(FGO_DECS24,0) / 100)), 0) AS VALS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS25 - IF(IFNULL(FGO_DECS25,0) <> 0, (IFNULL(FGO_VALS25,0) * (IFNULL(FGO_DECS25,0) / 100)), 0) AS VALS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS26 - IF(IFNULL(FGO_DECS26,0) <> 0, (IFNULL(FGO_VALS26,0) * (IFNULL(FGO_DECS26,0) / 100)), 0) AS VALS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS27 - IF(IFNULL(FGO_DECS27,0) <> 0, (IFNULL(FGO_VALS27,0) * (IFNULL(FGO_DECS27,0) / 100)), 0) AS VALS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS28 - IF(IFNULL(FGO_DECS28,0) <> 0, (IFNULL(FGO_VALS28,0) * (IFNULL(FGO_DECS28,0) / 100)), 0) AS VALS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS29 - IF(IFNULL(FGO_DECS29,0) <> 0, (IFNULL(FGO_VALS29,0) * (IFNULL(FGO_DECS29,0) / 100)), 0) AS VALS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALS30 - IF(IFNULL(FGO_DECS30,0) <> 0, (IFNULL(FGO_VALS30,0) * (IFNULL(FGO_DECS30,0) / 100)), 0) AS VALS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strFatGor := strFatGor + '  FGO_PRAENT AS PRAENT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_TOTSER AS TOTSER, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_VALISS AS VALISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_PERISS AS PERISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_HORENT AS HORENT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS DESACE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS ALQIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS VALIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS ALQPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS VALPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS ALQCOF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS VALCOF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS ALQCSL, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS VALCSL, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  "N"        AS RETPCO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  " "        AS RETIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  " "        AS RETISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  " "        AS SEGSOC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  " "        AS CDESPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  " "        AS SITIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  " "        AS ENQIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  " "        AS MENIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  " "        AS ORPURD, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  " "        AS CALICM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  " "        AS NOTRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS IRFRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS PISRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS COFRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS CSLRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS SERRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  " "        AS NORESE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS IRPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS IRPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS IRSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS IRSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS PIPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS PIPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS PISERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS PISEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS COPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS COPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS COSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS COSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS CSPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS CSPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS CSSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS CSSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS VLSGSO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.0        AS PESGSO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0000000.00 AS DUPREC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.00       AS BASORG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  0.00       AS ICMORG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  FGO_ENTFAT AS ENTFAT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strFatGor := strFatGor + '  "N"        AS NOTESP, ';        
  strFatGor := strFatGor + '  "FATGOR     " AS TABELA, ';
  strFatGor := strFatGor + '  " " AS TIP_FC, ';
  strFatGor := strFatGor + '  " " AS ORIDOC, ';
  strFatGor := strFatGor + '  FGO_VLRCON AS VLRCON, ';

  strFatGor := strFatGor + '  COALESCE((SELECT ';
  strFatGor := strFatGor + '            CONCAT(EQU_NUMOSE,"-","OS") AS DOCORI ';//NUMERO DA ORDEM DE SERVIÇO CASO FOI GERADO ESSE PEDIDO DO CONSERTO DE EQUIPAMENTOS
  strFatGor := strFatGor + '            FROM EQUGER ';
  strFatGor := strFatGor + '            WHERE (EQU_TIPPED = "PD"       AND ';
  strFatGor := strFatGor + '                   EQU_NUMPED = FGO_NUMDOC AND ';
  strFatGor := strFatGor + '                   EQU_EMPPED = FGO_CODEMP AND ';
  strFatGor := strFatGor + '                   EQU_TIPPED = FGO_ESPDOC) ';
  strFatGor := strFatGor + '            UNION  ';
  strFatGor := strFatGor + '            SELECT ';
  strFatGor := strFatGor + '              CONCAT(EQU_NUMOSE,"-","OS") AS DOCORI ';
  strFatGor := strFatGor + '            FROM EQUGER ';
  strFatGor := strFatGor + '            INNER JOIN EQUGOR ON FGO_SEQEQU = EQUGER.AUTOINCREM ';
  strFatGor := strFatGor + '            WHERE FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strFatGor := strFatGor + '            LIMIT 1), ';

  strFatGor := strFatGor + '          COALESCE((SELECT ';
  strFatGor := strFatGor + '                   CONCAT(FDO_NUMDOC,"-",FDO_ESPDOC) AS DOCORI ';//DOCUMENTO DE ORIGEM FATURAMENTO (OR)
  strFatGor := strFatGor + '                   FROM FATDOR ';
  strFatGor := strFatGor + '                   WHERE FDO_TIPFAT = FGO_ESPDOC AND ';
  strFatGor := strFatGor + '                         FDO_NUMFAT = FGO_NUMDOC AND ';
  strFatGor := strFatGor + '                         FDO_EMPFAT = FGO_CODEMP AND ';
  strFatGor := strFatGor + '                         FDO_JAFATU = 1 ';
  strFatGor := strFatGor + '                   LIMIT 1), "")  ';
  strFatGor := strFatGor + '           ) AS DOCORI,  ';

  strFatGor := strFatGor + '  "N" AS DOCFOR,  ';    
  strFatGor := strFatGor + '  " " AS NROCEI,  ';
  strFatGor := strFatGor + '  FGO_ORDIND AS ORDPRO ';
  strFatGor := strFatGor + 'FROM ';
  strFatGor := strFatGor + '  FATGOR  ';
  strFatGor := strFatGor + '  JOIN CADCLI ON FGO_CODCLI = CLI_CODCLI ';
  strFatGor := strFatGor + '  LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strFatGor := strFatGor + '  LEFT JOIN SERGOR ON SERGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strFatGor := strFatGor + 'WHERE ';

  {*********************************************}
  {* COMENTADO A PEDIDO DO MÁRIO EM 16/01/2013 *}
  {******************************************PZ*}
  //strFatGor := strFatGor + '  FGO_ESPDOC <> "PR" AND ';

  If (Not fEmptyStr(strNumDoc)) And (Not fEmptyStr(strEspDoc)) Then
  Begin

    strFatGor := strFatGor + '  FGO_NUMDOC = :NUMDOC AND ';
    strFatGor := strFatGor + '  FGO_ESPDOC = :ESPDOC ';

    If blnCancelamento Then
    Begin
      If strEspSel = 'NE' Then
        strFatGor := strFatGor + ' AND IFNULL(FGO_SERIE_, "") = :SERIE_ ';

      strFatGor := strFatGor + ' AND FGO_CODCLI = :CODCLI ';
    End
    Else
    Begin
      If (Not fEmptyStr(strSerie)) Then
        strFatGor := strFatGor + ' AND IFNULL(FGO_SERIE_, "") = :SERIE_ ';
    End;

    If Not fEmptyStr(strCodVen) Then
      strFatGor := strFatGor + 'AND FGO_CODVEN = :CODVEN ';

    If Not fEmptyStr(strCodEmp) Then
      strFatGor := strFatGor + 'AND FGO_CODEMP = :CODEMP '
    Else
      strFatGor := strFatGor + 'AND ' + fGetSQLInEmpresasReimpressao('FGO_CODEMP') + ' ';

  End
  Else
  Begin

    strFatGor := strFatGor + '  FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(strNumDoc) Then
      strFatGor := strFatGor + 'AND FGO_NUMDOC = :NUMDOC ';

    If Not fEmptyStr(strEspDoc) Then
      strFatGor := strFatGor + 'AND FGO_ESPDOC = :ESPDOC ';

    If Not fEmptyStr(strCodEmp) Then
      strFatGor := strFatGor + 'AND FGO_CODEMP = :CODEMP '
    Else
      strFatGor := strFatGor + 'AND ' + fGetSQLInEmpresasReimpressao('FGO_CODEMP') + ' ';

    If Not fEmptyStr(strCodCli) Then
      strFatGor := strFatGor + 'AND FGO_CODCLI = :CODCLI ';

    If Not fEmptyStr(strCodVen) Then
      strFatGor := strFatGor + 'AND FGO_CODVEN = :CODVEN ';

    if (not fEmptyStr(strPlaVei)) then
      strFatGor := strFatGor + 'AND FGO_PLAVEI = :PLAVEI ';

    If (Not fEmptyStr(strSerie)) Then
      strFatGor := strFatGor + ' AND IFNULL(FGO_SERIE_, "") = :SERIE_ ';

  End;

  If (FTipoConsCli = tpLibCliVenLog) and (strTip_Fc = 'C') and fEmptyStr(strCodCli) Then
  Begin
    strFatGor := strFatGor + ' AND CLI_CODVEN =  ' + QuotedStr(strLoginUsuarioLogado);
  End;

  If blnReimpr And (strTip_Fc = 'F') Then
      strFatGor := strFatGor + ' AND FALSE ';

  If blnExiDocsCanc Then
  Begin
    strSQL2 := AnsiReplaceStr(
               AnsiReplaceStr(
               AnsiReplaceStr(strFatGor, 'FATGOR','DEL_FATGOR'),
                                         'SERGOR', 'DEL_SERGOR'),
                                         'EXTGOR', 'DEL_EXTGOR');

    strFatGor := AnsiReplaceStr(strFatGor, '"C" AS DOCCAN', 'IF(LOCATE("DADOS BAIXA", FATGOR.FGO_MOTBAI), "B", " ") AS DOCCAN');
    strFatGor := AnsiReplaceStr(strFatGor, 'FATGOR.MOTDEL AS MOTDEL', '" " AS MOTDEL');
    strFatGor := AnsiReplaceStr(strFatGor, 'FATGOR.OPEDEL AS OPEDEL', '" " AS OPEDEL');
    strFatGor := AnsiReplaceStr(strFatGor, 'DATE_FORMAT(FATGOR.DTADEL,"%d/%m/%Y") AS DTADEL', '" " AS DTADEL');
    strFatGor  := strFatGor + ' UNION ALL ' + strSQL2;
  End;

  objDocumentos.strSqlDocs := strFatGor;

  If (Not fEmptyStr(strNumDoc)) And (Not fEmptyStr(strEspDoc)) Then
  Begin

    objDocumentos.pAddFiltro('NUMDOC', strNumDoc);
    objDocumentos.pAddFiltro('ESPDOC', strEspDoc);

    If blnCancelamento Then
    Begin
      If strEspSel = 'NE' Then
        objDocumentos.pAddFiltro('SERIE_', strSerie);

      objDocumentos.pAddFiltro('CODCLI', strCodCli);
    End
    Else
    Begin
      If Not fEmptyStr(strSerie) Then
        objDocumentos.pAddFiltro('SERIE_', strSerie);
    End;


    If Not fEmptyStr(strCodVen) Then
      objDocumentos.pAddFiltro('CODVEN', strCodVen);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

  End
  Else
  Begin
    objDocumentos.pAddFiltro('DTAINI', dtaDtaIni);
    objDocumentos.pAddFiltro('DTAFIN', dtaDtaFin);

    If Not fEmptyStr(strNumDoc) Then
      objDocumentos.pAddFiltro('NUMDOC', strNumDoc);

    If Not fEmptyStr(strEspDoc) Then
      objDocumentos.pAddFiltro('ESPDOC', strEspDoc);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

    If Not fEmptyStr(strCodCli) Then
      objDocumentos.pAddFiltro('CODCLI', strCodCli);

    If Not fEmptyStr(strCodVen) Then
      objDocumentos.pAddFiltro('CODVEN', strCodVen);

    if (not fEmptyStr(strPlaVei)) then
      objDocumentos.pAddFiltro('PLAVEI', strPlaVei);

    If Not fEmptyStr(strSerie) Then
      objDocumentos.pAddFiltro('SERIE_', strSerie);
  End;

  objDocumentos.pCarregarDocumentos;

  {******************************}
  {* SELECT NAS TABELA NOTGER/X *}
  {***************************AF*}
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';
  strSQL := strSQL + '  GER_SERIE_ AS SERIE_, ';
  strSQL := strSQL + '  IF(GER_NUMFAT IS NULL OR GER_NUMFAT = "", " ", IFNULL('+fRetNotFat+', CONCAT(GER_NUMFAT, "-", GER_TIPFAT, "-", GER_EMPFAT))) AS NUMFAT, ';
  strSQL := strSQL + '  CAST(" "  AS CHAR(100)) AS SITUACAO, ';

  If blnExiDocsCanc Then
  Begin
    strSQL := strSQL + '  "C" AS DOCCAN, ';
    strSQL := strSQL + '  NOTGER.MOTDEL AS MOTDEL, ';
    strSQL := strSQL + '  DATE_FORMAT(NOTGER.DTADEL,"%d/%m/%Y") AS DTADEL, ';
    strSQL := strSQL + '  NOTGER.OPEDEL AS OPEDEL, ';
  End
  Else
  Begin
    strSQL := strSQL + '  " " AS DOCCAN, ';
    strSQL := strSQL + '  " " AS MOTDEL, ';
    strSQL := strSQL + '  " " AS DTADEL, ';
    strSQL := strSQL + '  " " AS OPEDEL, ';
  End;

  strSQL := strSQL + '  GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  GER_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  GER_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  " " AS ESAJML, ';
  strSQL := strSQL + '  GER_CODEMP AS CODEMP, ';

  if fCfgSis('VNDSPD', varBoolean) then
    strSQL := strSQL + '  CAST(IFNULL('+fReVendedorCnf+',GER_CODVEN) AS CHAR(64)) AS CODVEN, '
  else
    strSQL := strSQL + '  CAST(GER_CODVEN AS CHAR(64)) AS CODVEN, ';

  strSQL := strSQL + '  GER_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  GER_VPAR01 AS VPAR01, ';
  strSQL := strSQL + '  GER_VPAR02 AS VPAR02, ';
  strSQL := strSQL + '  GER_VPAR03 AS VPAR03, ';
  strSQL := strSQL + '  GER_VPAR04 AS VPAR04, ';
  strSQL := strSQL + '  GER_VPAR05 AS VPAR05, ';
  strSQL := strSQL + '  GER_VPAR06 AS VPAR06, ';
  strSQL := strSQL + '  GER_VPAR07 AS VPAR07, ';
  strSQL := strSQL + '  GER_VPAR08 AS VPAR08, ';
  strSQL := strSQL + '  GER_VPAR09 AS VPAR09, ';
  strSQL := strSQL + '  GER_VPAR10 AS VPAR10, ';
  strSQL := strSQL + '  GER_VPAR11 AS VPAR11, ';
  strSQL := strSQL + '  GER_VPAR12 AS VPAR12, ';
  strSQL := strSQL + '  CLI_CODREG AS CODREG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_NOMCLI AS CLIORI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_I_M_P_ AS I_M_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_PRORUR AS PRORUR, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_MICEMP AS MICEMP, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_ORGPUB AS ORGPUB, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_DESPIS AS DESPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_ZONFRA AS ZONFRA, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_DESZON AS DESZON, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_PERMUT AS PERMUT, '; // USADO PARA REIMPRESSÃO DE NOTA  
  strSQL := strSQL + '  CLI_SUFRAM AS CODZFM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_EXPIND AS EXPIND, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CONSUM AS CONSUM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_TABPRE AS TABPRE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODDIG AS CODDIG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IFNULL((SELECT DET_CODREP FROM NOTDET        ';
  strSQL := strSQL + '          WHERE DET_SEQGER = NOTGER.AUTOINCREM ';
  strSQL := strSQL + '          LIMIT 1),CLI_CODREP) AS CODREP,      '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CONPAG AS CONPAG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODCND AS CODCND, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODFPG AS CODFPG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CLAFIS AS CLAFIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_TOTPRO AS TOTPRO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_TOTCUS AS TOTCUS, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_DESESP AS DESESP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PORDES AS PORDES, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASRET AS BASRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQRET AS ALQRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTRET AS TOTRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_RET_SP AS RET_SP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BARTSP AS BARTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_VLRTSP AS VLRTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASICM AS BASICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQICM AS ALQICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTICM AS TOTICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASIPI AS BASIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQIPI AS ALQIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTIPI AS TOTIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_CODTRA AS CODTRA, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TIPFRE AS TIPFRE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTFRE AS TOTFRE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PESBRU AS PESBRU, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PESLIQ AS PESLIQ, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_VOLUME AS VOLUME, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_NCONHE AS NCONHE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASSIM AS BASSIM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MARCA_ AS MARCA_, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ESPECI AS ESPECI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN001 AS MEN001, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN002 AS MEN002, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN003 AS MEN003, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN004 AS MEN004, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN005 AS MEN005, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_CLAFI2 AS CLAFI2, ';
  strSQL := strSQL + '  GER_CLAFI3 AS CLAFI3, ';
  strSQL := strSQL + '  GER_NATOPE AS NATOPE, ';
  strSQL := strSQL + '  NOTGER.AUTOINCREM AS AUTINC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CAST(IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_CGCCPF,CLI_CGCCPF) AS UNSIGNED) AS CGCCPF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_NOMCON,CLI_NOMCLI) AS CLINOM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_ENDCON,CLI_ENDERE) AS ENDERE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%","", CLI_ENDNUM) AS ENDNUM, ';        // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%","", CLI_ENDCOM) AS ENDCOM, ';        // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_BAICON,CLI_BAIRRO) AS BAIRRO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_CEPCON,CLI_C_E_P_) AS C_E_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_CIDCON,CLI_CODCID) AS CODCID, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_TELCON,CLI_FONE01) AS FONE01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_R_GCON,CLI_NUMR_G) AS NUM_RG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_CGCCON,CLI_C_G_C_) AS C_G_C_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_IESCON,CLI_I_E_S_) AS I_E_S_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_NOMCON,CONCAT(GER_CODCLI,"-",CLI_NOMCLI)) AS NOMCLI, ';
  strSQL := strSQL + '  CLI_DIFERI AS DIFERI, ';
  strSQL := strSQL + '  CLI_DIF_ST AS DIF_ST, ';
  strSQL := strSQL + '  CLI_SITP_C AS SITP_C, ';
  strSQL := strSQL + '  CLI_MENP_C AS MENP_C, ';
  strSQL := strSQL + '  CLI_REDICM AS REDICM, ';
  strSQL := strSQL + '  CLI_DESOPE AS DESOPE, ';
  strSQL := strSQL + '  CLI_COBISS AS COBISS, ';    
  strSQL := strSQL + '  CLI_CODOBR AS CODOBR, ';
  strSQL := strSQL + '  CLI_CODART AS CODART, ';
  strSQL := strSQL + '  CLI_CODATI AS CODATI, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_CODS01 AS CODS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS02 AS CODS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS03 AS CODS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS04 AS CODS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS05 AS CODS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS06 AS CODS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS07 AS CODS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS08 AS CODS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS09 AS CODS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS10 AS CODS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS11 AS CODS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS12 AS CODS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS13 AS CODS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS14 AS CODS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS15 AS CODS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS16 AS CODS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS17 AS CODS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS18 AS CODS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS19 AS CODS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS20 AS CODS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS21 AS CODS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS22 AS CODS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS23 AS CODS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS24 AS CODS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS25 AS CODS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS26 AS CODS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS27 AS CODS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS28 AS CODS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS29 AS CODS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS30 AS CODS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_DESS01 AS DESS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS02 AS DESS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS03 AS DESS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS04 AS DESS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS05 AS DESS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS06 AS DESS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS07 AS DESS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS08 AS DESS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS09 AS DESS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS10 AS DESS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS11 AS DESS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS12 AS DESS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS13 AS DESS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS14 AS DESS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS15 AS DESS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS16 AS DESS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS17 AS DESS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS18 AS DESS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS19 AS DESS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS20 AS DESS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS21 AS DESS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS22 AS DESS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS23 AS DESS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS24 AS DESS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS25 AS DESS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS26 AS DESS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS27 AS DESS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS28 AS DESS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS29 AS DESS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS30 AS DESS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_VALS01 - IF(IFNULL(GER_DECS01,0) <> 0, (IFNULL(GER_VALS01,0) * (IFNULL(GER_DECS01,0) / 100)), 0) AS VALS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS02 - IF(IFNULL(GER_DECS03,0) <> 0, (IFNULL(GER_VALS02,0) * (IFNULL(GER_DECS02,0) / 100)), 0) AS VALS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS03 - IF(IFNULL(GER_DECS03,0) <> 0, (IFNULL(GER_VALS03,0) * (IFNULL(GER_DECS03,0) / 100)), 0) AS VALS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS04 - IF(IFNULL(GER_DECS04,0) <> 0, (IFNULL(GER_VALS04,0) * (IFNULL(GER_DECS04,0) / 100)), 0) AS VALS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS05 - IF(IFNULL(GER_DECS05,0) <> 0, (IFNULL(GER_VALS05,0) * (IFNULL(GER_DECS05,0) / 100)), 0) AS VALS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS06 - IF(IFNULL(GER_DECS06,0) <> 0, (IFNULL(GER_VALS06,0) * (IFNULL(GER_DECS06,0) / 100)), 0) AS VALS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS07 - IF(IFNULL(GER_DECS07,0) <> 0, (IFNULL(GER_VALS07,0) * (IFNULL(GER_DECS07,0) / 100)), 0) AS VALS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS08 - IF(IFNULL(GER_DECS08,0) <> 0, (IFNULL(GER_VALS08,0) * (IFNULL(GER_DECS08,0) / 100)), 0) AS VALS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS09 - IF(IFNULL(GER_DECS09,0) <> 0, (IFNULL(GER_VALS09,0) * (IFNULL(GER_DECS09,0) / 100)), 0) AS VALS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS10 - IF(IFNULL(GER_DECS10,0) <> 0, (IFNULL(GER_VALS10,0) * (IFNULL(GER_DECS10,0) / 100)), 0) AS VALS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS11 - IF(IFNULL(GER_DECS11,0) <> 0, (IFNULL(GER_VALS11,0) * (IFNULL(GER_DECS11,0) / 100)), 0) AS VALS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS12 - IF(IFNULL(GER_DECS13,0) <> 0, (IFNULL(GER_VALS12,0) * (IFNULL(GER_DECS12,0) / 100)), 0) AS VALS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS13 - IF(IFNULL(GER_DECS13,0) <> 0, (IFNULL(GER_VALS13,0) * (IFNULL(GER_DECS13,0) / 100)), 0) AS VALS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS14 - IF(IFNULL(GER_DECS14,0) <> 0, (IFNULL(GER_VALS14,0) * (IFNULL(GER_DECS14,0) / 100)), 0) AS VALS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS15 - IF(IFNULL(GER_DECS15,0) <> 0, (IFNULL(GER_VALS15,0) * (IFNULL(GER_DECS15,0) / 100)), 0) AS VALS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS16 - IF(IFNULL(GER_DECS16,0) <> 0, (IFNULL(GER_VALS16,0) * (IFNULL(GER_DECS16,0) / 100)), 0) AS VALS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS17 - IF(IFNULL(GER_DECS17,0) <> 0, (IFNULL(GER_VALS17,0) * (IFNULL(GER_DECS17,0) / 100)), 0) AS VALS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS18 - IF(IFNULL(GER_DECS18,0) <> 0, (IFNULL(GER_VALS18,0) * (IFNULL(GER_DECS18,0) / 100)), 0) AS VALS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS19 - IF(IFNULL(GER_DECS19,0) <> 0, (IFNULL(GER_VALS19,0) * (IFNULL(GER_DECS19,0) / 100)), 0) AS VALS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS20 - IF(IFNULL(GER_DECS20,0) <> 0, (IFNULL(GER_VALS20,0) * (IFNULL(GER_DECS20,0) / 100)), 0) AS VALS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS21 - IF(IFNULL(GER_DECS21,0) <> 0, (IFNULL(GER_VALS21,0) * (IFNULL(GER_DECS21,0) / 100)), 0) AS VALS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS22 - IF(IFNULL(GER_DECS23,0) <> 0, (IFNULL(GER_VALS22,0) * (IFNULL(GER_DECS22,0) / 100)), 0) AS VALS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS23 - IF(IFNULL(GER_DECS23,0) <> 0, (IFNULL(GER_VALS23,0) * (IFNULL(GER_DECS23,0) / 100)), 0) AS VALS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS24 - IF(IFNULL(GER_DECS24,0) <> 0, (IFNULL(GER_VALS24,0) * (IFNULL(GER_DECS24,0) / 100)), 0) AS VALS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS25 - IF(IFNULL(GER_DECS25,0) <> 0, (IFNULL(GER_VALS25,0) * (IFNULL(GER_DECS25,0) / 100)), 0) AS VALS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS26 - IF(IFNULL(GER_DECS26,0) <> 0, (IFNULL(GER_VALS26,0) * (IFNULL(GER_DECS26,0) / 100)), 0) AS VALS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS27 - IF(IFNULL(GER_DECS27,0) <> 0, (IFNULL(GER_VALS27,0) * (IFNULL(GER_DECS27,0) / 100)), 0) AS VALS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS28 - IF(IFNULL(GER_DECS28,0) <> 0, (IFNULL(GER_VALS28,0) * (IFNULL(GER_DECS28,0) / 100)), 0) AS VALS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS29 - IF(IFNULL(GER_DECS29,0) <> 0, (IFNULL(GER_VALS29,0) * (IFNULL(GER_DECS29,0) / 100)), 0) AS VALS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS30 - IF(IFNULL(GER_DECS30,0) <> 0, (IFNULL(GER_VALS30,0) * (IFNULL(GER_DECS30,0) / 100)), 0) AS VALS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_PRAENT AS PRAENT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_TOTSER AS TOTSER, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALISS AS VALISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PERISS AS PERISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_HORENT AS HORENT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESACE AS DESACE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQIRF AS ALQIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALIRF AS VALIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQPIS AS ALQPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALPIS AS VALPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQCOF AS ALQCOF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALCOF AS VALCOF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQCSL AS ALQCSL, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALCSL AS VALCSL, '; // USADO PARA REIMPRESSÃO DE NOTA

  if (fCfgSis('SIMPAU', varBoolean) and fCfgSis('RETIMP', varBoolean)) then
  begin
    strSQL := strSQL + '  "N" AS RETPCO, ';        // USADO PARA REIMPRESSÃO DE NOTA
    strSQL := strSQL + '  "N" AS RETIRF, ';        // USADO PARA REIMPRESSÃO DE NOTA
    strSQL := strSQL + '  "N" AS CDESPI, ';        // USADO PARA REIMPRESSÃO DE NOTA
  end
  else
  begin
    strSQL := strSQL + '  CLI_RETPCO AS RETPCO, '; // USADO PARA REIMPRESSÃO DE NOTA
    strSQL := strSQL + '  CLI_RETIRF AS RETIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
    strSQL := strSQL + '  CLI_CDESPI AS CDESPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  end;

  strSQL := strSQL + '  CLI_RETISS AS RETISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_SEGSOC AS SEGSOC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_SITIPI AS SITIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_ENQIPI AS ENQIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_MENIPI AS MENIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_ORPURD AS ORPURD, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_CALICM AS CALICM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_NOTRET AS NOTRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRFRET AS IRFRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISRET AS PISRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COFRET AS COFRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSLRET AS CSLRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_SERRET AS SERRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_NORESE AS NORESE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRPRRT AS IRPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRPRDV AS IRPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRSERT AS IRSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRSEDV AS IRSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PIPRRT AS PIPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PIPRDV AS PIPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISERT AS PISERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISEDV AS PISEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COPRRT AS COPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COPRDV AS COPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COSERT AS COSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COSEDV AS COSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSPRRT AS CSPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSPRDV AS CSPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSSERT AS CSSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSSEDV AS CSSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VLSGSO AS VLSGSO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PESGSO AS PESGSO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DUPREC AS DUPREC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_BASORG AS BASORG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ICMORG AS ICMORG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ENTFAT AS ENTFAT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_NOTESP AS NOTESP, ';          
  strSQL := strSQL + '  "NOTGER     " AS TABELA, ';
  strSQL := strSQL + '  GER_TIP_FC AS TIP_FC, ';
  strSQL := strSQL + '  GER_ORIDOC AS ORIDOC, ';
  strSQL := strSQL + '  GER_VLRCON AS VLRCON, ';
  strSQL := strSQL + '  IFNULL('+fReDocCnf+', IFNULL('+fReDocIF+', " ")) AS DOCORI, ';
  strSQL := strSQL + '  "N" AS DOCFOR,  ';
  strSQL := strSQL + '  " " AS NROCEI,  ';
  strSQL := strSQL + '  CAST(" " AS CHAR(20)) AS ORDPRO ';
  strSQL := strSQL + ' FROM NOTGER ';

  If (strTip_Fc = 'F') And (strEspSel = 'NI') Then
    strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = GER_CODCLI '
  Else If (strEspSel <> 'NI') Then
    strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';

  strSQL := strSQL + 'LEFT JOIN SERNOT ON SERNOT.GER_SEQGER = NOTGER.AUTOINCREM ';

  if (not fEmptyStr(strPlaVei)) and ((fEmptyStr(strNumDoc)) or ((fEmptyStr(strEspDoc)))) then
    strSQL := strSQL + '  LEFT JOIN AUXNOT ON AUXNOT.AUX_SEQGER = NOTGER.AUTOINCREM ';

  if not fEmptyStr(strNumCoo) Then
  Begin
    strSQL := strSQL + ' INNER JOIN CADFIS ON FIS_NUMDOC = GER_NUMDOC AND ';
    strSQL := strSQL + '                      FIS_ESPDOC = GER_ESPDOC AND ';
    strSQL := strSQL + '                      FIS_CODEMP = GER_CODEMP AND ';
    strSQL := strSQL + '                      FIS_FORCLI = IF(FIS_TIP_FC = "C", GER_CODCLI, GER_CODFOR) AND ';
    strSQL := strSQL + '                      FIS_SERIE_ = GER_SERIE_     ';
  End;

  strSQL := strSQL + 'WHERE ';

  if not fEmptyStr(strNumCoo) Then
    strSQL := strSQL + ' FIS_NUMCOO = ' + QuotedStr(strNumCoo) + ' AND ';

//  If fCfgSis('PAFECF', varBoolean) Then
//    strSQL := strSQL + '  GER_ESPDOC   <> "IF"    AND ';

  Case intFilCla Of
    1: strSQL := strSQL + '  LOCATE(GER_CLAFIS, "' + VS_strClaVen + '") > 0 AND ';
    2: strSQL := strSQL + '  LOCATE(GER_CLAFIS, "' + VS_strClaDev + '") > 0 AND ';
    3: strSQL := strSQL + ' (LOCATE(GER_CLAFIS, "' + VS_strClaVen + '") <= 0) AND (LOCATE(GER_CLAFIS, "' + VS_strClaDev + '") <= 0) AND ';
  End;

  If blnFiltrarNE Then
    strSQL := strSQL + ' ((GER_ORIDOC IN ("V","C")) OR (GER_ESPDOC IN ("AJ", "RQ", "TA", "TL"))) AND '
  Else
  Begin

    If Not fEmptyStr(strOriDoc) Then
      strSQL := strSQL + ' GER_ORIDOC = ' + QuotedStr(strOriDoc) + ' AND ';

  End;

  If Not fEmptyStr(strTip_Fc) Then
    strSQL := strSQL + '  GER_TIP_FC  = :TIP_FC AND ';

  // Retirado mudança MySQL 5 - LS - 23-09-2014
  //If (strTip_Fc = 'C') Or (strEspSel <> 'NI') Then
  //strSQL := strSQL + '  GER_CODCLI = CLI_CODCLI AND ';

  If (Not fEmptyStr(strNumDoc)) And (Not fEmptyStr(strEspDoc)) Then
  Begin

    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC ';

    If blnCancelamento Then
    Begin
      If (strTip_Fc = 'F') And (strEspSel = 'NI') Then
        strSQL := strSQL + ' AND GER_CODFOR = :CODCLI '
      Else
        strSQL := strSQL + ' AND GER_CODCLI = :CODCLI ';
    End
    Else
    Begin
      If (Not fEmptyStr(strSerie)) Then
        strSQL := strSQL + ' AND GER_SERIE_ = :SERIE_ ';
    End;

    If Not fEmptyStr(strCodVen) Then
      strSQL := strSQL + 'AND GER_CODVEN = :CODVEN ';

    If Not fEmptyStr(strCodEmp) Then
      strSQL := strSQL + 'AND GER_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + 'AND ' + fGetSQLInEmpresasReimpressao('GER_CODEMP') + ' ';

  End
  Else
  Begin

    strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(strNumDoc) Then
      strSQL := strSQL + 'AND GER_NUMDOC = :NUMDOC ';

    If Not fEmptyStr(strEspDoc) Then
      strSQL := strSQL + 'AND GER_ESPDOC = :ESPDOC ';

    If Not fEmptyStr(strCodEmp) Then
      strSQL := strSQL + 'AND GER_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + 'AND ' + fGetSQLInEmpresasReimpressao('GER_CODEMP') + ' ';

    If Not fEmptyStr(strCodCli) Then
      strSQL := strSQL + 'AND GER_CODCLI = :CODCLI ';

    If Not fEmptyStr(strCodVen) Then
      strSQL := strSQL + 'AND GER_CODVEN = :CODVEN ';

    if (not fEmptyStr(strPlaVei)) then
      strSQL := strSQL + 'AND AUX_PLAVEI = :PLAVEI ';

    If (Not fEmptyStr(strSerie)) Then
      strSQL := strSQL + ' AND GER_SERIE_ = :SERIE_ ';

  End;

  If (FTipoConsCli = tpLibCliVenLog) and (strTip_Fc = 'C') and fEmptyStr(strCodCli) Then
  Begin
    strSQL := strSQL + ' AND CLI_CODVEN =  ' + QuotedStr(strLoginUsuarioLogado);
  End;

  If blnExiDocsCanc Then
  Begin
    strSQL2 := AnsiReplaceStr(
               AnsiReplaceStr(
               AnsiReplaceStr(strSQL, 'NOTGER', 'DEL_NOTGER'),
                                      'SERNOT', 'DEL_SERNOT'),
                                      'AUXNOT', 'DEL_AUXNOT');

    strSQL := AnsiReplaceStr(strSQL, '"C" AS DOCCAN', '" " AS DOCCAN');
    strSQL := AnsiReplaceStr(strSQL, 'NOTGER.MOTDEL AS MOTDEL', '" " AS MOTDEL');
    strSQL := AnsiReplaceStr(strSQL, 'NOTGER.OPEDEL AS OPEDEL', '" " AS OPEDEL');
    strSQL := AnsiReplaceStr(strSQL, 'DATE_FORMAT(NOTGER.DTADEL,"%d/%m/%Y") AS DTADEL', '" " AS DTADEL');

    strSQL  := strSQL + ' UNION ALL ' + strSQL2;
  End;

  objDocumentos.strSqlDocs := strSQL;

  If Not fEmptyStr(strTip_Fc) Then
    objDocumentos.pAddFiltro('TIP_FC', strTip_Fc);

  If (Not fEmptyStr(strNumDoc)) And (Not fEmptyStr(strEspDoc)) Then
  Begin

    objDocumentos.pAddFiltro('NUMDOC', strNumDoc);
    objDocumentos.pAddFiltro('ESPDOC', strEspDoc);

    If blnCancelamento Then
      objDocumentos.pAddFiltro('CODCLI', strCodCli);

    If Not fEmptyStr(strCodVen) Then
      objDocumentos.pAddFiltro('CODVEN', strCodVen);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

    If Not fEmptyStr(strSerie) Then
      objDocumentos.pAddFiltro('SERIE_', strSerie);


  End
  Else
  Begin

    objDocumentos.pAddFiltro('DTAINI', dtaDtaIni);
    objDocumentos.pAddFiltro('DTAFIN', dtaDtaFin);

    If Not fEmptyStr(strNumDoc) Then
      objDocumentos.pAddFiltro('NUMDOC', strNumDoc);

    If Not fEmptyStr(strEspDoc) Then
      objDocumentos.pAddFiltro('ESPDOC', strEspDoc);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

    If Not fEmptyStr(strCodCli) Then
      objDocumentos.pAddFiltro('CODCLI', strCodCli);

    If Not fEmptyStr(strCodVen) Then
      objDocumentos.pAddFiltro('CODVEN', strCodVen);

    if (not fEmptyStr(strPlaVei)) then
      objDocumentos.pAddFiltro('PLAVEI', strPlaVei);

    if (not fEmptyStr(strSerie)) then
      objDocumentos.pAddFiltro('SERIE_', strSerie);
  End;

  objDocumentos.pCarregarDocumentos;

  {*******************************************}
  {* CARREGA NOTAS FISCAIS DE IMPORTAÇÃO     *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';
  strSQL := strSQL + '  GER_SERIE_ AS SERIE_, ';
  strSQL := strSQL + '  IF(GER_NUMFAT IS NULL OR GER_NUMFAT = "", " ", IFNULL('+fRetNotFat+', CONCAT(GER_NUMFAT, "-", GER_TIPFAT, "-", GER_EMPFAT))) AS NUMFAT, ';
  strSQL := strSQL + '  CAST(" "  AS CHAR(100)) AS SITUACAO, ';

  If blnExiDocsCanc Then
  Begin
    strSQL := strSQL + '  "C" AS DOCCAN, ';
    strSQL := strSQL + '  NOTGER.MOTDEL AS MOTDEL, ';
    strSQL := strSQL + '  DATE_FORMAT(NOTGER.DTADEL,"%d/%m/%Y") AS DTADEL, ';
    strSQL := strSQL + '  NOTGER.OPEDEL AS OPEDEL, ';
  End
  Else
  Begin
    strSQL := strSQL + '  " " AS DOCCAN, ';
    strSQL := strSQL + '  " " AS MOTDEL, ';
    strSQL := strSQL + '  " " AS DTADEL, ';
    strSQL := strSQL + '  " " AS OPEDEL, ';
  End;

  strSQL := strSQL + '  GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  GER_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  GER_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  " " AS ESAJML, ';
  strSQL := strSQL + '  GER_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  CAST(GER_CODVEN AS CHAR(64)) AS CODVEN, ';
  strSQL := strSQL + '  GER_CODFOR AS CODCLI, ';
  strSQL := strSQL + '  GER_VPAR01 AS VPAR01, ';
  strSQL := strSQL + '  GER_VPAR02 AS VPAR02, ';
  strSQL := strSQL + '  GER_VPAR03 AS VPAR03, ';
  strSQL := strSQL + '  GER_VPAR04 AS VPAR04, ';
  strSQL := strSQL + '  GER_VPAR05 AS VPAR05, ';
  strSQL := strSQL + '  GER_VPAR06 AS VPAR06, ';
  strSQL := strSQL + '  GER_VPAR07 AS VPAR07, ';
  strSQL := strSQL + '  GER_VPAR08 AS VPAR08, ';
  strSQL := strSQL + '  GER_VPAR09 AS VPAR09, ';
  strSQL := strSQL + '  GER_VPAR10 AS VPAR10, ';
  strSQL := strSQL + '  GER_VPAR11 AS VPAR11, ';
  strSQL := strSQL + '  GER_VPAR12 AS VPAR12, ';
  strSQL := strSQL + '  " "        AS CODREG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  FOR_NOMFOR AS CLIORI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " " AS I_M_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  "" AS PRORUR, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  "" AS MICEMP, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  "N" AS ORGPUB, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  "N" AS DESPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  "N" AS ZONFRA, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  "N" AS DESZON, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  "N" AS PERMUT, '; // USADO PARA REIMPRESSÃO DE NOTA  
  strSQL := strSQL + '  " " AS CODZFM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CAST(" " AS CHAR(1)) AS EXPIND, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  "S" AS CONSUM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  "1" AS TABPRE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODDIG AS CODDIG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " " AS CODREP, ';

  strSQL := strSQL + '  GER_CONPAG AS CONPAG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODCND AS CODCND, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODFPG AS CODFPG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CLAFIS AS CLAFIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_TOTPRO AS TOTPRO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_TOTCUS AS TOTCUS, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_DESESP AS DESESP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PORDES AS PORDES, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASRET AS BASRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQRET AS ALQRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTRET AS TOTRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_RET_SP AS RET_SP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BARTSP AS BARTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_VLRTSP AS VLRTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASICM AS BASICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQICM AS ALQICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTICM AS TOTICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASIPI AS BASIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQIPI AS ALQIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTIPI AS TOTIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_CODTRA AS CODTRA, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TIPFRE AS TIPFRE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTFRE AS TOTFRE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PESBRU AS PESBRU, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PESLIQ AS PESLIQ, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_VOLUME AS VOLUME, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_NCONHE AS NCONHE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASSIM AS BASSIM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MARCA_ AS MARCA_, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ESPECI AS ESPECI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN001 AS MEN001, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN002 AS MEN002, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN003 AS MEN003, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN004 AS MEN004, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN005 AS MEN005, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_CLAFI2 AS CLAFI2, ';
  strSQL := strSQL + '  GER_CLAFI3 AS CLAFI3, ';
  strSQL := strSQL + '  GER_NATOPE AS NATOPE, ';
  strSQL := strSQL + '  NOTGER.AUTOINCREM AS AUTINC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CAST(FOR_CGCCPF AS UNSIGNED) AS CGCCPF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  FOR_NOMFOR AS CLINOM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  FOR_ENDERE AS ENDERE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  FOR_ENDNUM AS ENDNUM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  FOR_ENDCOM AS ENDCOM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  FOR_BAIRRO AS BAIRRO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  FOR_C_E_P_ AS C_E_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  FOR_CODCID AS CODCID, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  FOR_FONE01 AS FONE01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " " AS NUM_RG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  FOR_C_G_C_ AS C_G_C_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  FOR_I_E_S_ AS I_E_S_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CONCAT(FOR_CODFOR,"-",FOR_NOMFOR) AS NOMCLI, ';
  strSQL := strSQL + '  "N"        AS DIFERI, ';
  strSQL := strSQL + '  "N"        AS DIF_ST, ';
  strSQL := strSQL + '  "T"        AS SITP_C, ';
  strSQL := strSQL + '  ""         AS MENP_C, ';
  strSQL := strSQL + '  0.00       AS REDICM, ';
  strSQL := strSQL + '  0.00       AS DESOPE, ';
  strSQL := strSQL + '  ""         AS COBISS, ';    
  strSQL := strSQL + '  ""         AS CODOBR, ';
  strSQL := strSQL + '  ""         AS CODART, ';
  strSQL := strSQL + '  FOR_CODATI AS CODATI, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_CODS01 AS CODS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS02 AS CODS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS03 AS CODS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS04 AS CODS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS05 AS CODS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS06 AS CODS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS07 AS CODS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS08 AS CODS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS09 AS CODS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS10 AS CODS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS11 AS CODS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS12 AS CODS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS13 AS CODS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS14 AS CODS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS15 AS CODS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS16 AS CODS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS17 AS CODS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS18 AS CODS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS19 AS CODS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS20 AS CODS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS21 AS CODS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS22 AS CODS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS23 AS CODS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS24 AS CODS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS25 AS CODS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS26 AS CODS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS27 AS CODS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS28 AS CODS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS29 AS CODS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS30 AS CODS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_DESS01 AS DESS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS02 AS DESS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS03 AS DESS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS04 AS DESS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS05 AS DESS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS06 AS DESS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS07 AS DESS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS08 AS DESS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS09 AS DESS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS10 AS DESS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS11 AS DESS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS12 AS DESS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS13 AS DESS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS14 AS DESS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS15 AS DESS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS16 AS DESS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS17 AS DESS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS18 AS DESS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS19 AS DESS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS20 AS DESS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS21 AS DESS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS22 AS DESS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS23 AS DESS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS24 AS DESS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS25 AS DESS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS26 AS DESS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS27 AS DESS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS28 AS DESS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS29 AS DESS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS30 AS DESS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_VALS01 - IF(IFNULL(GER_DECS01,0) <> 0, (IFNULL(GER_VALS01,0) * (IFNULL(GER_DECS01,0) / 100)), 0) AS VALS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS02 - IF(IFNULL(GER_DECS03,0) <> 0, (IFNULL(GER_VALS02,0) * (IFNULL(GER_DECS02,0) / 100)), 0) AS VALS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS03 - IF(IFNULL(GER_DECS03,0) <> 0, (IFNULL(GER_VALS03,0) * (IFNULL(GER_DECS03,0) / 100)), 0) AS VALS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS04 - IF(IFNULL(GER_DECS04,0) <> 0, (IFNULL(GER_VALS04,0) * (IFNULL(GER_DECS04,0) / 100)), 0) AS VALS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS05 - IF(IFNULL(GER_DECS05,0) <> 0, (IFNULL(GER_VALS05,0) * (IFNULL(GER_DECS05,0) / 100)), 0) AS VALS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS06 - IF(IFNULL(GER_DECS06,0) <> 0, (IFNULL(GER_VALS06,0) * (IFNULL(GER_DECS06,0) / 100)), 0) AS VALS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS07 - IF(IFNULL(GER_DECS07,0) <> 0, (IFNULL(GER_VALS07,0) * (IFNULL(GER_DECS07,0) / 100)), 0) AS VALS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS08 - IF(IFNULL(GER_DECS08,0) <> 0, (IFNULL(GER_VALS08,0) * (IFNULL(GER_DECS08,0) / 100)), 0) AS VALS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS09 - IF(IFNULL(GER_DECS09,0) <> 0, (IFNULL(GER_VALS09,0) * (IFNULL(GER_DECS09,0) / 100)), 0) AS VALS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS10 - IF(IFNULL(GER_DECS10,0) <> 0, (IFNULL(GER_VALS10,0) * (IFNULL(GER_DECS10,0) / 100)), 0) AS VALS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS11 - IF(IFNULL(GER_DECS11,0) <> 0, (IFNULL(GER_VALS11,0) * (IFNULL(GER_DECS11,0) / 100)), 0) AS VALS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS12 - IF(IFNULL(GER_DECS13,0) <> 0, (IFNULL(GER_VALS12,0) * (IFNULL(GER_DECS12,0) / 100)), 0) AS VALS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS13 - IF(IFNULL(GER_DECS13,0) <> 0, (IFNULL(GER_VALS13,0) * (IFNULL(GER_DECS13,0) / 100)), 0) AS VALS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS14 - IF(IFNULL(GER_DECS14,0) <> 0, (IFNULL(GER_VALS14,0) * (IFNULL(GER_DECS14,0) / 100)), 0) AS VALS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS15 - IF(IFNULL(GER_DECS15,0) <> 0, (IFNULL(GER_VALS15,0) * (IFNULL(GER_DECS15,0) / 100)), 0) AS VALS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS16 - IF(IFNULL(GER_DECS16,0) <> 0, (IFNULL(GER_VALS16,0) * (IFNULL(GER_DECS16,0) / 100)), 0) AS VALS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS17 - IF(IFNULL(GER_DECS17,0) <> 0, (IFNULL(GER_VALS17,0) * (IFNULL(GER_DECS17,0) / 100)), 0) AS VALS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS18 - IF(IFNULL(GER_DECS18,0) <> 0, (IFNULL(GER_VALS18,0) * (IFNULL(GER_DECS18,0) / 100)), 0) AS VALS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS19 - IF(IFNULL(GER_DECS19,0) <> 0, (IFNULL(GER_VALS19,0) * (IFNULL(GER_DECS19,0) / 100)), 0) AS VALS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS20 - IF(IFNULL(GER_DECS20,0) <> 0, (IFNULL(GER_VALS20,0) * (IFNULL(GER_DECS20,0) / 100)), 0) AS VALS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS21 - IF(IFNULL(GER_DECS21,0) <> 0, (IFNULL(GER_VALS21,0) * (IFNULL(GER_DECS21,0) / 100)), 0) AS VALS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS22 - IF(IFNULL(GER_DECS23,0) <> 0, (IFNULL(GER_VALS22,0) * (IFNULL(GER_DECS22,0) / 100)), 0) AS VALS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS23 - IF(IFNULL(GER_DECS23,0) <> 0, (IFNULL(GER_VALS23,0) * (IFNULL(GER_DECS23,0) / 100)), 0) AS VALS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS24 - IF(IFNULL(GER_DECS24,0) <> 0, (IFNULL(GER_VALS24,0) * (IFNULL(GER_DECS24,0) / 100)), 0) AS VALS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS25 - IF(IFNULL(GER_DECS25,0) <> 0, (IFNULL(GER_VALS25,0) * (IFNULL(GER_DECS25,0) / 100)), 0) AS VALS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS26 - IF(IFNULL(GER_DECS26,0) <> 0, (IFNULL(GER_VALS26,0) * (IFNULL(GER_DECS26,0) / 100)), 0) AS VALS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS27 - IF(IFNULL(GER_DECS27,0) <> 0, (IFNULL(GER_VALS27,0) * (IFNULL(GER_DECS27,0) / 100)), 0) AS VALS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS28 - IF(IFNULL(GER_DECS28,0) <> 0, (IFNULL(GER_VALS28,0) * (IFNULL(GER_DECS28,0) / 100)), 0) AS VALS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS29 - IF(IFNULL(GER_DECS29,0) <> 0, (IFNULL(GER_VALS29,0) * (IFNULL(GER_DECS29,0) / 100)), 0) AS VALS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS30 - IF(IFNULL(GER_DECS30,0) <> 0, (IFNULL(GER_VALS30,0) * (IFNULL(GER_DECS30,0) / 100)), 0) AS VALS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_PRAENT AS PRAENT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_TOTSER AS TOTSER, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALISS AS VALISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PERISS AS PERISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_HORENT AS HORENT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESACE AS DESACE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQIRF AS ALQIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALIRF AS VALIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQPIS AS ALQPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALPIS AS VALPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQCOF AS ALQCOF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALCOF AS VALCOF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQCSL AS ALQCSL, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALCSL AS VALCSL, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS RETPCO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS RETIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS RETISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS SEGSOC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS CDESPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS SITIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS ENQIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS MENIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS ORPURD, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS CALICM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_NOTRET AS NOTRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRFRET AS IRFRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISRET AS PISRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COFRET AS COFRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSLRET AS CSLRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_SERRET AS SERRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_NORESE AS NORESE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRPRRT AS IRPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRPRDV AS IRPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRSERT AS IRSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRSEDV AS IRSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PIPRRT AS PIPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PIPRDV AS PIPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISERT AS PISERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISEDV AS PISEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COPRRT AS COPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COPRDV AS COPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COSERT AS COSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COSEDV AS COSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSPRRT AS CSPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSPRDV AS CSPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSSERT AS CSSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSSEDV AS CSSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VLSGSO AS VLSGSO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PESGSO AS PESGSO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DUPREC AS DUPREC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_BASORG AS BASORG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ICMORG AS ICMORG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ENTFAT AS ENTFAT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_NOTESP AS NOTESP, ';
  strSQL := strSQL + '  "NOTGER     "  AS TABELA, ';
  strSQL := strSQL + '  GER_TIP_FC AS TIP_FC, ';
  strSQL := strSQL + '  GER_ORIDOC AS ORIDOC, ';
  strSQL := strSQL + '  GER_VLRCON AS VLRCON, ';
  strSQL := strSQL + '  " " AS DOCORI, ';
  strSQL := strSQL + '  "S" AS DOCFOR,  ';  
  strSQL := strSQL + '  " " AS NROCEI,  ';
  strSQL := strSQL + '  CAST(" " AS CHAR(20)) AS ORDPRO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  NOTGER ';
  strSQL := strSQL + '  JOIN CADFOR ON GER_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '  LEFT JOIN SERNOT ON SERNOT.GER_SEQGER = NOTGER.AUTOINCREM ';
  strSQL := strSQL + 'WHERE ';

  Case intFilCla Of
    1: strSQL := strSQL + '  LOCATE(GER_CLAFIS, "' + VS_strClaVen + '") > 0 AND ';
    2: strSQL := strSQL + '  LOCATE(GER_CLAFIS, "' + VS_strClaDev + '") > 0 AND ';
    3: strSQL := strSQL + ' (LOCATE(GER_CLAFIS, "' + VS_strClaVen + '") <= 0) AND (LOCATE(GER_CLAFIS, "' + VS_strClaDev + '") <= 0) AND ';
  End;

  If blnFiltrarNE Then
    strSQL := strSQL + ' ((GER_ORIDOC IN ("V","C")) OR (GER_ESPDOC IN ("AJ", "RQ", "TA", "TL"))) AND '
  Else
  Begin

    If Not fEmptyStr(strOriDoc) Then
      strSQL := strSQL + ' GER_ORIDOC = ' + QuotedStr(strOriDoc) + ' AND ';

  End;

  If Not fEmptyStr(strTip_Fc) Then
    strSQL := strSQL + '  GER_TIP_FC = :TIP_FC AND ';

  If (Not fEmptyStr(strNumDoc)) And (Not fEmptyStr(strEspDoc)) Then
  Begin

    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC ';

    If Not fEmptyStr(strCodVen) Then
      strSQL := strSQL + 'AND GER_CODVEN = :CODVEN ';

    If Not fEmptyStr(strCodEmp) Then
      strSQL := strSQL + 'AND GER_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + 'AND ' + fGetSQLInEmpresasReimpressao('GER_CODEMP') + ' ';

    If (Not fEmptyStr(strSerie)) Then
      strSQL := strSQL + ' AND GER_SERIE_ = :SERIE_ ';

  End
  Else
  Begin

    strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(strNumDoc) Then
      strSQL := strSQL + 'AND GER_NUMDOC = :NUMDOC ';

    If Not fEmptyStr(strEspDoc) Then
      strSQL := strSQL + 'AND GER_ESPDOC = :ESPDOC ';

    If Not fEmptyStr(strCodEmp) Then
      strSQL := strSQL + 'AND GER_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + 'AND ' + fGetSQLInEmpresasReimpressao('GER_CODEMP') + ' ';

    If Not fEmptyStr(strCodCli) Then
      strSQL := strSQL + 'AND GER_CODCLI = :CODCLI ';

    If Not fEmptyStr(strCodVen) Then
      strSQL := strSQL + 'AND GER_CODVEN = :CODVEN ';

    If (Not fEmptyStr(strSerie)) Then
      strSQL := strSQL + ' AND GER_SERIE_ = :SERIE_ ';
  End;

  If blnExiDocsCanc Then
  Begin
    strSQL2 := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'NOTGER','DEL_NOTGER'), 'SERNOT', 'DEL_SERNOT');

    strSQL := AnsiReplaceStr(strSQL, '"C" AS DOCCAN', '" " AS DOCCAN');
    strSQL := AnsiReplaceStr(strSQL, 'NOTGER.MOTDEL AS MOTDEL', '" " AS MOTDEL');
    strSQL := AnsiReplaceStr(strSQL, 'NOTGER.OPEDEL AS OPEDEL', '" " AS OPEDEL');
    strSQL := AnsiReplaceStr(strSQL, 'DATE_FORMAT(NOTGER.DTADEL,"%d/%m/%Y") AS DTADEL', '" " AS DTADEL');

    strSQL  := strSQL + ' UNION ALL ' + strSQL2;
  End;

  objDocumentos.strSqlDocs := strSQL;

  If Not fEmptyStr(strTip_Fc) Then
    objDocumentos.pAddFiltro('TIP_FC', strTip_Fc);

  If (Not fEmptyStr(strNumDoc)) And (Not fEmptyStr(strEspDoc)) Then
  Begin
    objDocumentos.pAddFiltro('NUMDOC', strNumDoc);
    objDocumentos.pAddFiltro('ESPDOC', strEspDoc);

    If Not fEmptyStr(strCodVen) Then
      objDocumentos.pAddFiltro('CODVEN', strCodVen);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

    If Not fEmptyStr(strSerie) Then
      objDocumentos.pAddFiltro('SERIE_', strSerie);
  End
  Else
  Begin

    objDocumentos.pAddFiltro('DTAINI', dtaDtaIni);
    objDocumentos.pAddFiltro('DTAFIN', dtaDtaFin);

    If Not fEmptyStr(strNumDoc) Then
      objDocumentos.pAddFiltro('NUMDOC', strNumDoc);

    If Not fEmptyStr(strEspDoc) Then
      objDocumentos.pAddFiltro('ESPDOC', strEspDoc);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

    If Not fEmptyStr(strCodCli) Then
      objDocumentos.pAddFiltro('CODCLI', strCodCli);

    If Not fEmptyStr(strCodVen) Then
      objDocumentos.pAddFiltro('CODVEN', strCodVen);

    If Not fEmptyStr(strSerie) Then
      objDocumentos.pAddFiltro('SERIE_', strSerie);

  End;

  objDocumentos.pCarregarDocumentos;

  {**************************************}
  {* SELECT NAS TABELAS MOVGAG E MOVGAD *}
  {***********************************RL*}
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE DISTINCT     ';
  strSQL := strSQL + '  " " AS SERIE_, ';
  strSQL := strSQL + '  " " AS NUMFAT, ';
  strSQL := strSQL + '  CAST(" "  AS CHAR(100)) AS SITUACAO, ';
  strSQL := strSQL + '  " " AS DOCCAN, ';
  strSQL := strSQL + '  " " AS MOTDEL, ';
  strSQL := strSQL + '  " " AS DTADEL, ';
  strSQL := strSQL + '  " " AS OPEDEL, ';
  strSQL := strSQL + '  DET_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  DET_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  DET_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  " " AS ESAJML, ';
  strSQL := strSQL + '  DET_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  CAST(GROUP_CONCAT(DISTINCT DET_CODVEN) AS CHAR(64)) AS CODVEN, ';
  strSQL := strSQL + '  DET_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  0          AS VPAR01, ';
  strSQL := strSQL + '  0          AS VPAR02, ';
  strSQL := strSQL + '  0          AS VPAR03, ';
  strSQL := strSQL + '  0          AS VPAR04, ';
  strSQL := strSQL + '  0          AS VPAR05, ';
  strSQL := strSQL + '  0          AS VPAR06, ';
  strSQL := strSQL + '  0          AS VPAR07, ';
  strSQL := strSQL + '  0          AS VPAR08, ';
  strSQL := strSQL + '  0          AS VPAR09, ';
  strSQL := strSQL + '  0          AS VPAR10, ';
  strSQL := strSQL + '  0          AS VPAR11, ';
  strSQL := strSQL + '  0          AS VPAR12, ';
  strSQL := strSQL + '  CLI_CODREG AS CODREG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_NOMCLI AS CLIORI, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  CLI_I_M_P_ AS I_M_P_, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  CLI_PRORUR AS PRORUR, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  CLI_MICEMP AS MICEMP, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_ORGPUB AS ORGPUB, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  CLI_DESPIS AS DESPIS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  CLI_ZONFRA AS ZONFRA, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  CLI_DESZON AS DESZON, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  CLI_PERMUT AS PERMUT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_SUFRAM AS CODZFM, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  CLI_EXPIND AS EXPIND, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_CONSUM AS CONSUM, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  CLI_TABPRE AS TABPRE, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODDIG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODREP, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CONPAG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODCND, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODFPG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CLAFIS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS TOTPRO, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS TOTCUS, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS DESESP, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS PORDES, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS BASRET, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS ALQRET, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS TOTRET, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS RET_SP, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS BARTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  0 AS VLRTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  0 AS BASICM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS ALQICM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS TOTICM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS BASIPI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS ALQIPI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS TOTIPI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS CODTRA, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS TIPFRE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS TOTFRE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS PESBRU, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS PESLIQ, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS VOLUME, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS NCONHE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS BASSIM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS MARCA_, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS ESPECI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS MEN001, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS MEN002, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS MEN003, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  " " AS MEN004, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  " " AS MEN005, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  " " AS CLAFI2, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CLAFI3, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS NATOPE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  strSQL := strSQL + '  G.AUTOINCREM AS AUTINC, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  CAST(IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_CGCCPF, CLI_CGCCPF) AS UNSIGNED) AS CGCCPF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_NOMCON, CLI_NOMCLI) AS CLINOM, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_ENDCON, CLI_ENDERE) AS ENDERE, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%","", CLI_ENDNUM) AS ENDNUM, ';         // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%","", CLI_ENDCOM) AS ENDCOM, ';         // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_BAICON, CLI_BAIRRO) AS BAIRRO, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_CEPCON, CLI_C_E_P_) AS C_E_P_, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_CIDCON, CLI_CODCID) AS CODCID, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_TELCON, CLI_FONE01) AS FONE01, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_R_GCON, CLI_NUMR_G) AS NUM_RG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_CGCCON, CLI_C_G_C_) AS C_G_C_, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_IESCON, CLI_I_E_S_) AS I_E_S_, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_NOMCON, CONCAT(GAG_CODCLI,"-",CLI_NOMCLI)) AS NOMCLI, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  CLI_DIFERI AS DIFERI, ';
  strSQL := strSQL + '  CLI_DIF_ST AS DIF_ST, ';
  strSQL := strSQL + '  CLI_SITP_C AS SITP_C, ';
  strSQL := strSQL + '  CLI_MENP_C AS MENP_C, ';
  strSQL := strSQL + '  CLI_REDICM AS REDICM, ';
  strSQL := strSQL + '  CLI_DESOPE AS DESOPE, ';
  strSQL := strSQL + '  CLI_COBISS AS COBISS, ';
  strSQL := strSQL + '  CLI_CODOBR AS CODOBR, ';
  strSQL := strSQL + '  CLI_CODART AS CODART, ';
  strSQL := strSQL + '  CLI_CODATI AS CODATI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_DIF_ST AS DIF_ST, ';
  strSQL := strSQL + '  CLI_SITP_C AS SITP_C, ';
  strSQL := strSQL + '  CLI_MENP_C AS MENP_C, ';
  strSQL := strSQL + '  CLI_REDICM AS REDICM, ';
  strSQL := strSQL + '  CLI_DESOPE AS DESOPE, ';
  strSQL := strSQL + '  CLI_COBISS AS COBISS, ';
  strSQL := strSQL + '  CLI_CODOBR AS CODOBR, ';
  strSQL := strSQL + '  CLI_CODART AS CODART, ';
  strSQL := strSQL + '  CLI_CODATI AS CODATI, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  " " AS CODS01, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS02, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS03, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS04, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS05, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS06, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS07, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS08, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS09, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS10, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS11, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS12, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS13, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS14, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS15, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS16, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS17, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS18, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS19, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS20, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS21, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS22, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS23, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS24, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS25, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS26, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS27, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS28, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS29, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS CODS30, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA

  strSQL := strSQL + '  " " AS DESS01, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS02, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS03, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS04, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS05, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS06, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS07, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS08, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS09, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS10, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS11, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS12, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS13, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS14, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS15, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS16, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS17, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS18, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS19, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS20, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS21, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS22, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS23, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS24, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS25, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS26, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS27, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS28, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS29, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " " AS DESS30, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA

  strSQL := strSQL + '  0   AS VALS01, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS02, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS03, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS04, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS05, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS06, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS07, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS08, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS09, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS10, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS11, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS12, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS13, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS14, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS15, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS16, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS17, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS18, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS19, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS20, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS21, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS22, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS23, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS24, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS25, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS26, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS27, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS28, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS29, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALS30, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA

  strSQL := strSQL + '  0   AS PRAENT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS TOTSER, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALISS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS PERISS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  CAST(GAG_DTAENT AS TIME) AS HORENT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS DESACE, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS ALQIRF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALIRF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS ALQPIS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALPIS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS ALQCOF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALCOF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS ALQCSL, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VALCSL, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS RETPCO, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS RETIRF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS RETISS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS SEGSOC, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS CDESPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0   AS SITIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0   AS ENQIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0   AS MENIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0   AS ORPURD, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS CALICM, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " "   AS NOTRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS IRFRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS PISRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS COFRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS CSLRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS SERRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  " "   AS NORESE, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS IRPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS IRPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS IRSERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS IRSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS PIPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS PIPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS PISERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS PISEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS COPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS COPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS COSERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS COSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS CSPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS CSPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS CSSERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS CSSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS VLSGSO, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0   AS PESGSO, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0000000.00 AS DUPREC, '; // USADO PARA REIMPRESSÃO DE NOTA  DE GARANTIA
  strSQL := strSQL + '  0 AS BASORG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  0 AS ICMORG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  strSQL := strSQL + '  "N" AS ENTFAT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  "N" AS NOTESP, ';
  strSQL := strSQL + '  IF(DET_ESPDOC = "GC","MOVGER    ","MOVGAG     ")  AS TABELA, ';
  strSQL := strSQL + '  " " AS TIP_FC, ';
  strSQL := strSQL + '  " " AS ORIDOC, ';
  strSQL := strSQL + '  SUM(DET_VLRCON) AS VLRCON, ';
  strSQL := strSQL + '  " " AS DOCORI, ';
  strSQL := strSQL + '  "N" AS DOCFOR,  ';
  strSQL := strSQL + '  " " AS NROCEI,  ';
  strSQL := strSQL + '  CAST(" " AS CHAR(20)) AS ORDPRO ';
  strSQL := strSQL + 'FROM ';

  {******************************************}
  {* NOTA GARANTIA (RECEBIMENTO DE CLIENTE) *}
  {****************************************FC}
  If SameText(strEspSel, 'NW') Then
  Begin
    strSQL := strSQL + ' MOVGAG G ';
    strSQL := strSQL + ' INNER JOIN MOVGAD D ON D.GAD_SEQGAG = G.AUTOINCREM ';
    strSQL := strSQL + ' INNER JOIN MOVGRC A ON GRC_SEQGAD = D.AUTOINCREM ';
    strSQL := strSQL + ' INNER JOIN MOVDET M ON M.AUTOINCREM = GRC_SEQDET ';
    strSQL := strSQL + ' INNER JOIN CADCLI C ON G.GAG_CODCLI = C.CLI_CODCLI  ';
  End
  Else
  Begin
    strSQL := strSQL + ' MOVGAG G ';
    strSQL := strSQL + ' INNER JOIN MOVGAD D ON D.GAD_SEQGAG = G.AUTOINCREM ';
    strSQL := strSQL + ' INNER JOIN MOVTRI T ON T.DET_SEQGAD = D.AUTOINCREM ';
    strSQL := strSQL + ' INNER JOIN MOVDET M ON M.AUTOINCREM = T.DET_SEQGER ';
    strSQL := strSQL + ' INNER JOIN CADCLI C ON M.DET_CODCLI = C.CLI_CODCLI ';
    {strSQL := strSQL + ' INNER JOIN CADCLI C ON G.GAG_CODCLI = C.CLI_CODCLI ';}
    {strSQL := strSQL + '                    AND G.GAG_CODCLI = M.DET_CODCLI ';}
  End;

  strSQL := strSQL + 'WHERE IFNULL(DET_NUMDOC,"") <> "" ';

  If (Not fEmptyStr(strNumDoc)) And
     (Not fEmptyStr(strEspDoc)) And
     (Not SameText(strEspDoc, 'EP')) And
     ((SameText(strEspDoc, 'GA')) Or
      (SameText(strEspDoc, 'GC')) Or
     (SameText(strEspSel, 'NW'))) Then
  Begin

    strSQL := strSQL + ' AND DET_NUMDOC = :NUMDOC ';

    If not fEmptyStr(strEspDoc) Then
      strSQL := strSQL + ' AND DET_ESPDOC = :ESPDOC ';

    If blnCancelamento Then
    Begin
      If (strTip_Fc = 'F') Then
      Begin
        strSQL := strSQL + ' AND DET_CODFOR = :CODCLI ';
      End
      Else
        strSQL := strSQL + ' AND DET_CODCLI = :CODCLI ';
    End
    Else
    Begin
      If (strTip_Fc = 'F') Then
      Begin
        strSQL := strSQL + ' AND DET_CODFOR IS NOT NULL ';
      End
      Else
        strSQL := strSQL + ' AND DET_CODCLI IS NOT NULL ';
    End;

    If Not fEmptyStr(strSerie) Then
      strSQL := strSQL + 'AND DET_SERIE_ = :SERIE_ ';

    If Not fEmptyStr(strCodVen) Then
      strSQL := strSQL + 'AND GAG_CODVEN = :CODVEN ';

    If Not fEmptyStr(strCodEmp) Then
    begin
      strSQL := strSQL + ' AND GAG_CODEMP IN (:CODEMP) ';
      strSQL := strSQL + ' AND DET_CODEMP IN (:CODEMP) ';
    End
    Else
    begin
      strSQL := strSQL + ' AND ' + fGetSQLInEmpresasReimpressao('GAG_CODEMP') + ' ';
      strSQL := strSQL + ' AND ' + fGetSQLInEmpresasReimpressao('DET_CODEMP') + ' ';
    End;


  End
  Else
  Begin

    If Not fEmptyStr(strNumDoc) Then
      strSQL := strSQL + ' AND DET_NUMDOC IN (:NUMDOC) ';

    If not fEmptyStr(strEspDoc) Then
      strSQL := strSQL + ' AND DET_ESPDOC IN (:ESPDOC) ';

    If Not fEmptyStr(strCodCli) Then
    begin
      If (strTip_Fc = 'F') Then
      Begin
        strSQL := strSQL + ' AND DET_CODFOR IN (:CODCLI) ';
      End
      Else
        strSQL := strSQL + ' AND DET_CODCLI IN (:CODCLI) ';
    end
    else
    begin
      If (strTip_Fc = 'F') Then
        strSQL := strSQL + ' AND DET_CODFOR IS NOT NULL '
      Else
        strSQL := strSQL + ' AND DET_CODCLI IS NOT NULL ';
    end;

    If Not fEmptyStr(strSerie) Then
      strSQL := strSQL + 'AND DET_SERIE_ = :SERIE_ ';

    strSQL := strSQL + 'AND DET_DTAENT >= :DTAINI AND DET_DTAENT <= :DTAFIN ';

    If Not fEmptyStr(strCodVen) Then
      strSQL := strSQL + ' AND GAG_CODVEN IN (:CODVEN) ';

    If Not fEmptyStr(strCodEmp) Then
    begin
      strSQL := strSQL + ' AND GAG_CODEMP IN (:CODEMP) ';
      strSQL := strSQL + ' AND DET_CODEMP IN (:CODEMP) ';
    End
    Else
    begin
      strSQL := strSQL + ' AND ' + fGetSQLInEmpresasReimpressao('GAG_CODEMP') + ' ';
      strSQL := strSQL + ' AND ' + fGetSQLInEmpresasReimpressao('DET_CODEMP') + ' ';
    End;

  End;

  If (FTipoConsCli = tpLibCliVenLog) and (strTip_Fc = 'C') and fEmptyStr(strCodCli) Then
  Begin
    strSQL := strSQL + ' AND CLI_CODVEN =  ' + QuotedStr(strLoginUsuarioLogado);
  End;

  strSQL := strSQL + ' GROUP BY NUMDOC, ESPDOC, CODEMP ';

  If blnExiDocsCanc Then
  Begin
    strSQL2 := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVGAG','DEL_MOVGAG'), 'MOVGAD', 'DEL_MOVGAD'), 'MOVTRI', 'DEL_MOVTRI'),'MOVDET','DEL_MOVDET'), 'MOVGRC', 'DEL_MOVGRC');

    strSQL2 := AnsiReplaceStr(strSQL2, '" " AS DOCCAN', '"C" AS DOCCAN');
    strSQL2 := AnsiReplaceStr(strSQL2, '" " AS OPEDEL', 'M.OPEDEL AS OPEDEL');
    strSQL2 := AnsiReplaceStr(strSQL2, '" " AS DTADEL', 'DATE_FORMAT(M.DTADEL,"%d/%m/%Y") AS DTADEL');

    strSQL  := strSQL + ' UNION ALL ' + strSQL2;
  End;

  objDocumentos.strSqlDocs := strSQL;

  If (Not fEmptyStr(strNumDoc)) And
     (Not fEmptyStr(strEspDoc)) And
     (Not SameText(strEspDoc, 'EP')) And
     ((SameText(strEspDoc, 'GA')) Or
      (SameText(strEspDoc, 'GC')) Or
     (SameText(strEspSel, 'NW'))) Then
  Begin
    objDocumentos.pAddFiltro('NUMDOC', strNumDoc);

    If Not fEmptyStr(strCodVen) Then
      objDocumentos.pAddFiltro('CODVEN', strCodVen);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

    If not fEmptyStr(strEspDoc) Then
      objDocumentos.pAddFiltro('ESPDOC', strEspDoc);


    If (blnCancelamento) Then
    Begin
      If (strTip_Fc = 'F') Then
        objDocumentos.pAddFiltro('CODFOR', strCodCli)
      Else
        objDocumentos.pAddFiltro('CODCLI', strCodCli);
    End;

    If not fEmptyStr(strSerie) Then
      objDocumentos.pAddFiltro('SERIE_', strSerie);
  End
  Else
  Begin
    objDocumentos.pAddFiltro('DTAINI', dtaDtaIni);
    objDocumentos.pAddFiltro('DTAFIN', dtaDtaFin + StrToTime('23:59:59'));

    If Not fEmptyStr(strNumDoc) Then
      objDocumentos.pAddFiltro('NUMDOC', strNumDoc);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

    If Not fEmptyStr(strCodCli) Then
      objDocumentos.pAddFiltro('CODCLI', strCodCli);

    If Not fEmptyStr(strCodVen) Then
      objDocumentos.pAddFiltro('CODVEN', strCodVen);

    If not fEmptyStr(strEspDoc) Then
      objDocumentos.pAddFiltro('ESPDOC', strEspDoc);

    If not fEmptyStr(strSerie) Then
      objDocumentos.pAddFiltro('SERIE_', strSerie);
  End;

  If (Pos(strEspDoc, 'GA_') > 0) Or
     (Pos(strEspSel, 'NW_') > 0) Or
     (SameText(strEspDoc, 'GC')) Or
     (fEmptyStr(strEspDoc)) Then
    objDocumentos.pCarregarDocumentos;

  {*****************************************}
  {* CARREGA OS AJUSTES EM ML              *}
  {**************************************MV*}
  //strSQL := strSQL + ' UNION ';
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';
  strSQL := strSQL + '  GER_SERIE_ AS SERIE_, ';
  strSQL := strSQL + '  IF(GER_NUMFAT IS NULL OR GER_NUMFAT = "", " ", IFNULL('+fRetDetFat+', CONCAT(GER_NUMFAT, "-", GER_TIPFAT, "-", GER_EMPFAT))) AS NUMFAT, ';
  strSQL := strSQL + '  CAST(" "  AS CHAR(100)) AS SITUACAO, ';

  If blnExiDocsCanc Then
  Begin
    strSQL := strSQL + '  "C" AS DOCCAN, ';
    strSQL := strSQL + '  MOVGER.MOTDEL AS MOTDEL, ';
    strSQL := strSQL + '  DATE_FORMAT(MOVGER.DTADEL,"%d/%m/%Y") AS DTADEL, ';
    strSQL := strSQL + '  MOVGER.OPEDEL AS OPEDEL, ';
  End
  Else
  Begin
    strSQL := strSQL + '  " " AS DOCCAN, ';
    strSQL := strSQL + '  " " AS MOTDEL, ';
    strSQL := strSQL + '  " " AS DTADEL, ';
    strSQL := strSQL + '  " " AS OPEDEL, ';
  End;

  strSQL := strSQL + '  GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  GER_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  GER_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  " " AS ESAJML, ';
  strSQL := strSQL + '  GER_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  CAST(GER_CODVEN AS CHAR(64)) AS CODVEN, ';
  strSQL := strSQL + '  GER_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  GER_VPAR01 AS VPAR01, ';
  strSQL := strSQL + '  GER_VPAR02 AS VPAR02, ';
  strSQL := strSQL + '  GER_VPAR03 AS VPAR03, ';
  strSQL := strSQL + '  GER_VPAR04 AS VPAR04, ';
  strSQL := strSQL + '  GER_VPAR05 AS VPAR05, ';
  strSQL := strSQL + '  GER_VPAR06 AS VPAR06, ';
  strSQL := strSQL + '  GER_VPAR07 AS VPAR07, ';
  strSQL := strSQL + '  GER_VPAR08 AS VPAR08, ';
  strSQL := strSQL + '  GER_VPAR09 AS VPAR09, ';
  strSQL := strSQL + '  GER_VPAR10 AS VPAR10, ';
  strSQL := strSQL + '  GER_VPAR11 AS VPAR11, ';
  strSQL := strSQL + '  GER_VPAR12 AS VPAR12, ';
  strSQL := strSQL + '  CLI_CODREG AS CODREG, '; // USADO PARA REIMPRESSÃO DE NOTA  
  strSQL := strSQL + '  CLI_NOMCLI AS CLIORI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_I_M_P_ AS I_M_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_PRORUR AS PRORUR, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_MICEMP AS MICEMP, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_ORGPUB AS ORGPUB, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_DESPIS AS DESPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_ZONFRA AS ZONFRA, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_DESZON AS DESZON, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_PERMUT AS PERMUT, '; // USADO PARA REIMPRESSÃO DE NOTA  
  strSQL := strSQL + '  CLI_SUFRAM AS CODZFM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_EXPIND AS EXPIND, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CONSUM AS CONSUM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_TABPRE AS TABPRE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODDIG AS CODDIG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IFNULL((SELECT DET_CODREP FROM MOVDET        ';
  strSQL := strSQL + '          WHERE DET_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '          LIMIT 1),CLI_CODREP) AS CODREP,      '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CONPAG AS CONPAG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODCND AS CODCND, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODFPG AS CODFPG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CLAFIS AS CLAFIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_TOTPRO AS TOTPRO, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTCUS AS TOTCUS, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_DESESP AS DESESP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PORDES AS PORDES, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASRET AS BASRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQRET AS ALQRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTRET AS TOTRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_RET_SP AS RET_SP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BARTSP AS BARTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_VLRTSP AS VLRTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASICM AS BASICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQICM AS ALQICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTICM AS TOTICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASIPI AS BASIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQIPI AS ALQIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTIPI AS TOTIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_CODTRA AS CODTRA, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TIPFRE AS TIPFRE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTFRE AS TOTFRE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PESBRU AS PESBRU, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PESLIQ AS PESLIQ, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_VOLUME AS VOLUME, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_NCONHE AS NCONHE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASSIM AS BASSIM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MARCA_ AS MARCA_, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ESPECI AS ESPECI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN001 AS MEN001, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN002 AS MEN002, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN003 AS MEN003, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN004 AS MEN004, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN005 AS MEN005, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_CLAFI2 AS CLAFI2, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_CLAFI3 AS CLAFI3, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_NATOPE AS NATOPE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  MOVGER.AUTOINCREM AS AUTINC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%",GER_CGCCPF, CLI_CGCCPF) AS CGCCPF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%",GER_NOMCON, CLI_NOMCLI) AS CLINOM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%",GER_ENDCON, CLI_ENDERE) AS ENDERE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%","", CLI_ENDNUM) AS ENDNUM, ';         // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%","", CLI_ENDCOM) AS ENDCOM, ';         // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%",GER_BAICON, CLI_BAIRRO) AS BAIRRO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%",GER_CEPCON, CLI_C_E_P_) AS C_E_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%",GER_CIDCON, CLI_CODCID) AS CODCID, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%",GER_TELCON, CLI_FONE01) AS FONE01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%",GER_R_GCON, CLI_NUMR_G) AS NUM_RG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%",GER_CGCCON, CLI_C_G_C_) AS C_G_C_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%",GER_IESCON, CLI_I_E_S_) AS I_E_S_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%",GER_NOMCON, CONCAT(GER_CODCLI,"-",CLI_NOMCLI)) AS NOMCLI, ';
  strSQL := strSQL + '  CLI_DIFERI AS DIFERI, ';
  strSQL := strSQL + '  CLI_DIF_ST AS DIF_ST, ';
  strSQL := strSQL + '  CLI_SITP_C AS SITP_C, ';
  strSQL := strSQL + '  CLI_MENP_C AS MENP_C, ';
  strSQL := strSQL + '  CLI_REDICM AS REDICM, ';
  strSQL := strSQL + '  CLI_DESOPE AS DESOPE, ';
  strSQL := strSQL + '  CLI_COBISS AS COBISS, ';
  strSQL := strSQL + '  CLI_CODOBR AS CODOBR, ';
  strSQL := strSQL + '  CLI_CODART AS CODART, ';
  strSQL := strSQL + '  CLI_CODATI AS CODATI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS01 AS CODS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS02 AS CODS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS03 AS CODS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS04 AS CODS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS05 AS CODS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS06 AS CODS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS07 AS CODS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS08 AS CODS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS09 AS CODS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS10 AS CODS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS11 AS CODS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS12 AS CODS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS13 AS CODS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS14 AS CODS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS15 AS CODS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS16 AS CODS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS17 AS CODS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS18 AS CODS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS19 AS CODS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS20 AS CODS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS21 AS CODS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS22 AS CODS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS23 AS CODS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS24 AS CODS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS25 AS CODS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS26 AS CODS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS27 AS CODS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS28 AS CODS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS29 AS CODS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS30 AS CODS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_DESS01 AS DESS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS02 AS DESS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS03 AS DESS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS04 AS DESS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS05 AS DESS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS06 AS DESS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS07 AS DESS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS08 AS DESS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS09 AS DESS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS10 AS DESS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS11 AS DESS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS12 AS DESS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS13 AS DESS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS14 AS DESS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS15 AS DESS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS16 AS DESS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS17 AS DESS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS18 AS DESS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS19 AS DESS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS20 AS DESS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS21 AS DESS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS22 AS DESS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS23 AS DESS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS24 AS DESS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS25 AS DESS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS26 AS DESS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS27 AS DESS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS28 AS DESS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS29 AS DESS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS30 AS DESS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_VALS01 - IF(IFNULL(GER_DECS01,0) <> 0, (IFNULL(GER_VALS01,0) * (IFNULL(GER_DECS01,0) / 100)), 0) AS VALS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS02 - IF(IFNULL(GER_DECS03,0) <> 0, (IFNULL(GER_VALS02,0) * (IFNULL(GER_DECS02,0) / 100)), 0) AS VALS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS03 - IF(IFNULL(GER_DECS03,0) <> 0, (IFNULL(GER_VALS03,0) * (IFNULL(GER_DECS03,0) / 100)), 0) AS VALS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS04 - IF(IFNULL(GER_DECS04,0) <> 0, (IFNULL(GER_VALS04,0) * (IFNULL(GER_DECS04,0) / 100)), 0) AS VALS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS05 - IF(IFNULL(GER_DECS05,0) <> 0, (IFNULL(GER_VALS05,0) * (IFNULL(GER_DECS05,0) / 100)), 0) AS VALS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS06 - IF(IFNULL(GER_DECS06,0) <> 0, (IFNULL(GER_VALS06,0) * (IFNULL(GER_DECS06,0) / 100)), 0) AS VALS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS07 - IF(IFNULL(GER_DECS07,0) <> 0, (IFNULL(GER_VALS07,0) * (IFNULL(GER_DECS07,0) / 100)), 0) AS VALS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS08 - IF(IFNULL(GER_DECS08,0) <> 0, (IFNULL(GER_VALS08,0) * (IFNULL(GER_DECS08,0) / 100)), 0) AS VALS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS09 - IF(IFNULL(GER_DECS09,0) <> 0, (IFNULL(GER_VALS09,0) * (IFNULL(GER_DECS09,0) / 100)), 0) AS VALS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS10 - IF(IFNULL(GER_DECS10,0) <> 0, (IFNULL(GER_VALS10,0) * (IFNULL(GER_DECS10,0) / 100)), 0) AS VALS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS11 - IF(IFNULL(GER_DECS11,0) <> 0, (IFNULL(GER_VALS11,0) * (IFNULL(GER_DECS11,0) / 100)), 0) AS VALS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS12 - IF(IFNULL(GER_DECS13,0) <> 0, (IFNULL(GER_VALS12,0) * (IFNULL(GER_DECS12,0) / 100)), 0) AS VALS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS13 - IF(IFNULL(GER_DECS13,0) <> 0, (IFNULL(GER_VALS13,0) * (IFNULL(GER_DECS13,0) / 100)), 0) AS VALS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS14 - IF(IFNULL(GER_DECS14,0) <> 0, (IFNULL(GER_VALS14,0) * (IFNULL(GER_DECS14,0) / 100)), 0) AS VALS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS15 - IF(IFNULL(GER_DECS15,0) <> 0, (IFNULL(GER_VALS15,0) * (IFNULL(GER_DECS15,0) / 100)), 0) AS VALS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS16 - IF(IFNULL(GER_DECS16,0) <> 0, (IFNULL(GER_VALS16,0) * (IFNULL(GER_DECS16,0) / 100)), 0) AS VALS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS17 - IF(IFNULL(GER_DECS17,0) <> 0, (IFNULL(GER_VALS17,0) * (IFNULL(GER_DECS17,0) / 100)), 0) AS VALS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS18 - IF(IFNULL(GER_DECS18,0) <> 0, (IFNULL(GER_VALS18,0) * (IFNULL(GER_DECS18,0) / 100)), 0) AS VALS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS19 - IF(IFNULL(GER_DECS19,0) <> 0, (IFNULL(GER_VALS19,0) * (IFNULL(GER_DECS19,0) / 100)), 0) AS VALS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS20 - IF(IFNULL(GER_DECS20,0) <> 0, (IFNULL(GER_VALS20,0) * (IFNULL(GER_DECS20,0) / 100)), 0) AS VALS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS21 - IF(IFNULL(GER_DECS21,0) <> 0, (IFNULL(GER_VALS21,0) * (IFNULL(GER_DECS21,0) / 100)), 0) AS VALS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS22 - IF(IFNULL(GER_DECS23,0) <> 0, (IFNULL(GER_VALS22,0) * (IFNULL(GER_DECS22,0) / 100)), 0) AS VALS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS23 - IF(IFNULL(GER_DECS23,0) <> 0, (IFNULL(GER_VALS23,0) * (IFNULL(GER_DECS23,0) / 100)), 0) AS VALS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS24 - IF(IFNULL(GER_DECS24,0) <> 0, (IFNULL(GER_VALS24,0) * (IFNULL(GER_DECS24,0) / 100)), 0) AS VALS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS25 - IF(IFNULL(GER_DECS25,0) <> 0, (IFNULL(GER_VALS25,0) * (IFNULL(GER_DECS25,0) / 100)), 0) AS VALS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS26 - IF(IFNULL(GER_DECS26,0) <> 0, (IFNULL(GER_VALS26,0) * (IFNULL(GER_DECS26,0) / 100)), 0) AS VALS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS27 - IF(IFNULL(GER_DECS27,0) <> 0, (IFNULL(GER_VALS27,0) * (IFNULL(GER_DECS27,0) / 100)), 0) AS VALS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS28 - IF(IFNULL(GER_DECS28,0) <> 0, (IFNULL(GER_VALS28,0) * (IFNULL(GER_DECS28,0) / 100)), 0) AS VALS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS29 - IF(IFNULL(GER_DECS29,0) <> 0, (IFNULL(GER_VALS29,0) * (IFNULL(GER_DECS29,0) / 100)), 0) AS VALS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS30 - IF(IFNULL(GER_DECS30,0) <> 0, (IFNULL(GER_VALS30,0) * (IFNULL(GER_DECS30,0) / 100)), 0) AS VALS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_PRAENT AS PRAENT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_TOTSER AS TOTSER, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALISS AS VALISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PERISS AS PERISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_HORENT AS HORENT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESACE AS DESACE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQIRF AS ALQIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALIRF AS VALIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQPIS AS ALQPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALPIS AS VALPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQCOF AS ALQCOF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALCOF AS VALCOF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQCSL AS ALQCSL, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALCSL AS VALCSL, '; // USADO PARA REIMPRESSÃO DE NOTA

  if (fCfgSis('SIMPAU', varBoolean) and fCfgSis('RETIMP', varBoolean)) then
  begin
    strSQL := strSQL + '  "N" AS RETPCO, ';        // USADO PARA REIMPRESSÃO DE NOTA
    strSQL := strSQL + '  "N" AS RETIRF, ';        // USADO PARA REIMPRESSÃO DE NOTA
    strSQL := strSQL + '  "N" AS CDESPI, ';        // USADO PARA REIMPRESSÃO DE NOTA
  end
  else
  begin
    strSQL := strSQL + '  CLI_RETPCO AS RETPCO, '; // USADO PARA REIMPRESSÃO DE NOTA
    strSQL := strSQL + '  CLI_RETIRF AS RETIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
    strSQL := strSQL + '  CLI_CDESPI AS CDESPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  end;

  strSQL := strSQL + '  CLI_RETISS AS RETISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_SEGSOC AS SEGSOC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_SITIPI AS SITIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_ENQIPI AS ENQIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  CLI_MENIPI AS MENIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_ORPURD AS ORPURD, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CLI_CALICM AS CALICM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_NOTRET AS NOTRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRFRET AS IRFRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISRET AS PISRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COFRET AS COFRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSLRET AS CSLRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_SERRET AS SERRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_NORESE AS NORESE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRPRRT AS IRPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRPRDV AS IRPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRSERT AS IRSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRSEDV AS IRSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PIPRRT AS PIPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PIPRDV AS PIPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISERT AS PISERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISEDV AS PISEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COPRRT AS COPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COPRDV AS COPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COSERT AS COSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COSEDV AS COSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSPRRT AS CSPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSPRDV AS CSPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSSERT AS CSSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSSEDV AS CSSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VLSGSO AS VLSGSO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PESGSO AS PESGSO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0000000.00 AS DUPREC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_BASORG AS BASORG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ICMORG AS ICMORG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ENTFAT AS ENTFAT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_NOTESP AS NOTESP, ';      
  strSQL := strSQL + '  "MOVGER     "  AS TABELA, ';
  strSQL := strSQL + '  GER_TIP_FC AS TIP_FC, ';
  strSQL := strSQL + '  GER_ORIDOC AS ORIDOC, ';

  strSQL := strSQL + '  IF(GER_ESPDOC = "ML" AND (SELECT DET_TIPFAT FROM MOVDET WHERE MOVDET.DET_SEQGER = MOVGER.AUTOINCREM LIMIT 1) = "AJ", ';
  strSQL := strSQL + '  (SELECT SUM(DET_VLRCON * IF(DET_CLAFIS < 5000,1, -1)) FROM MOVDET WHERE MOVDET.DET_SEQGER = MOVGER.AUTOINCREM), ';
  strSQL := strSQL + '  GER_VLRCON) AS VLRCON, ';

  strSQL := strSQL + '  " " AS DOCORI, ';//DOCUMENTO DE ORIGEM FATURAMENTO (PD/OR)...
  strSQL := strSQL + '  "N" AS DOCFOR,  ';  
  strSQL := strSQL + '  " " AS NROCEI,  ';
  strSQL := strSQL + '  CAST(" " AS CHAR(20)) AS ORDPRO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGER ';
  strSQL := strSQL + '  JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN SERMOV ON SERMOV.GER_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + 'WHERE ';

  Case intFilCla Of
    1: strSQL := strSQL + '  LOCATE(GER_CLAFIS, "' + VS_strClaVen + '") > 0 AND ';
    2: strSQL := strSQL + '  LOCATE(GER_CLAFIS, "' + VS_strClaDev + '") > 0 AND ';
    3: strSQL := strSQL + ' (LOCATE(GER_CLAFIS, "' + VS_strClaVen + '") <= 0) AND (LOCATE(GER_CLAFIS, "' + VS_strClaDev + '") <= 0) AND ';
  End;

  strSQL := strSQL + '  GER_ESPDOC = "ML"       AND ';

  //Coloquei essa verificacao pq no ajuste de estoque em ML o sistema esta passando
  //o campo JAFATU = 1
  If (Not fEmptyStr(strNumDoc)) And (Not fEmptyStr(strEspDoc)) And ((strEspDoc = 'AJ') Or (strEspSel = 'AJ')) Then
    strSQL := strSQL + '  '
  Else
    strSQL := strSQL + '  GER_JAFATU = 0          AND ';

  If (Not fEmptyStr(strNumDoc)) And (Not fEmptyStr(strEspDoc)) Then
  Begin

    strSQL := strSQL + '  GER_NUMFAT = :NUMDOC AND ';
    strSQL := strSQL + '  GER_TIPFAT = :ESPDOC ';

    If blnCancelamento Then
    Begin
      If (strTip_Fc = 'F') And ( Pos(strEspSel, 'NE_OF_NG_NP_') > 0 ) Then
      Begin
        strSQL := strSQL + ' AND GER_CODFOR = :CODCLI ';
        strSQL := strSQL + ' AND IFNULL(GER_SERIE_, "") = :SERIE_ ';
      End
      Else
        strSQL := strSQL + ' AND GER_CODCLI = :CODCLI ';
    End
    Else
    Begin
      If (Not fEmptyStr(strSerie)) Then
        strSQL := strSQL + ' AND IFNULL(GER_SERIE_, "")  = :SERIE_ ';
    End;

    If Not fEmptyStr(strCodVen) Then
      strSQL := strSQL + 'AND GER_CODVEN = :CODVEN ';

    If Not fEmptyStr(strCodEmp) Then
      strSQL := strSQL + 'AND GER_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + 'AND ' + fGetSQLInEmpresasReimpressao('GER_CODEMP') + ' ';

  End
  Else
  Begin

    strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(strNumDoc) Then
      strSQL := strSQL + 'AND GER_NUMFAT = :NUMDOC ';

    If Not fEmptyStr(strEspDoc) Then
      strSQL := strSQL + 'AND GER_TIPFAT = :ESPDOC ';

    If Not fEmptyStr(strCodEmp) Then
      strSQL := strSQL + 'AND GER_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + 'AND ' + fGetSQLInEmpresasReimpressao('GER_CODEMP') + ' ';

    If Not fEmptyStr(strCodCli) Then
      strSQL := strSQL + 'AND GER_CODCLI = :CODCLI ';

    If Not fEmptyStr(strCodVen) Then
      strSQL := strSQL + 'AND GER_CODVEN = :CODVEN ';

    If (Not fEmptyStr(strSerie)) Then
      strSQL := strSQL + ' AND IFNULL(GER_SERIE_, "")  = :SERIE_ ';

  End;

  If (FTipoConsCli = tpLibCliVenLog) and (strTip_Fc = 'C') and fEmptyStr(strCodCli) Then
  Begin
    strSQL := strSQL + ' AND CLI_CODVEN =  ' + QuotedStr(strLoginUsuarioLogado);
  End;

  If blnExiDocsCanc Then
  Begin
    strSQL2 := AnsiReplaceStr(
                AnsiReplaceStr(
                AnsiReplaceStr(strSQL, 'MOVGER', 'DEL_MOVGER'),
                                       'MOVDET', 'DEL_MOVDET'),
                                       'SERMOV', 'DEL_SERMOV');

    strSQL := AnsiReplaceStr(strSQL, '"C" AS DOCCAN', '" " AS DOCCAN');
    strSQL := AnsiReplaceStr(strSQL, 'MOVGER.MOTDEL AS MOTDEL', '" " AS MOTDEL');
    strSQL := AnsiReplaceStr(strSQL, 'MOVGER.OPEDEL AS OPEDEL', '" " AS OPEDEL');
    strSQL := AnsiReplaceStr(strSQL, 'DATE_FORMAT(MOVGER.DTADEL,"%d/%m/%Y") AS DTADEL', '" " AS DTADEL');

    strSQL  := strSQL + ' UNION ALL ' + strSQL2;
  End;

  objDocumentos.strSqlDocs := strSql;

  If (Not fEmptyStr(strNumDoc)) And (Not fEmptyStr(strEspDoc)) Then
  Begin

    objDocumentos.pAddFiltro('NUMDOC', strNumDoc);
    objDocumentos.pAddFiltro('ESPDOC', IIF(SameText(strEspDoc, 'ML'), 'AJ', strEspDoc));

    If blnCancelamento Then
    Begin

      If (strTip_Fc = 'F') And ( Pos(strEspSel, 'NE_OF_NG_NP_') > 0 ) Then
        objDocumentos.pAddFiltro('SERIE_', strSerie);

      objDocumentos.pAddFiltro('CODCLI', strCodCli);

    End
    Else
    Begin
      If Not fEmptyStr(strSerie) Then
        objDocumentos.pAddFiltro('SERIE_', strSerie);
    End;


    If Not fEmptyStr(strCodVen) Then
      objDocumentos.pAddFiltro('CODVEN', strCodVen);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

  End
  Else
  Begin
    objDocumentos.pAddFiltro('DTAINI', dtaDtaIni);
    objDocumentos.pAddFiltro('DTAFIN', dtaDtaFin);

    If Not fEmptyStr(strNumDoc) Then
      objDocumentos.pAddFiltro('NUMDOC', strNumDoc);

    If Not fEmptyStr(strEspDoc) Then
      objDocumentos.pAddFiltro('ESPDOC', IIF(SameText(strEspDoc, 'ML'), 'AJ', strEspDoc));

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

    If Not fEmptyStr(strCodCli) Then
      objDocumentos.pAddFiltro('CODCLI', strCodCli);

    If Not fEmptyStr(strCodVen) Then
      objDocumentos.pAddFiltro('CODVEN', strCodVen);

    If Not fEmptyStr(strSerie) Then
      objDocumentos.pAddFiltro('SERIE_', strSerie);
  End;

  objDocumentos.pCarregarDocumentos;

  {**************************************}
  {* SELECT NAS TABELAS MOVCTE E NOTCTE *}
  {**************************************}
  if fEmptyStr(strEspDoc) or SameText(strEspDoc, 'CT') then
  begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE DISTINCT     ';
    strSQL := strSQL + '  CTE_SERIE_ AS SERIE_, ';
    strSQL := strSQL + '  " " AS NUMFAT, ';
    strSQL := strSQL + '  CAST(" "  AS CHAR(100)) AS SITUACAO, ';
    strSQL := strSQL + '  " " AS DOCCAN, ';
    strSQL := strSQL + '  " " AS MOTDEL, ';
    strSQL := strSQL + '  " " AS DTADEL, ';
    strSQL := strSQL + '  " " AS OPEDEL, ';
    strSQL := strSQL + '  CTE_DTAEMI AS DTAENT, ';
    strSQL := strSQL + '  CONCAT("000", CTE_NUMCTE) AS NUMDOC, ';
    strSQL := strSQL + '  "CT" AS ESPDOC, ';
    strSQL := strSQL + '  " " AS ESAJML, ';
    strSQL := strSQL + '  CTE_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  CAST(GROUP_CONCAT(DISTINCT GER_CODVEN) AS CHAR(64)) AS CODVEN, ';
    strSQL := strSQL + '  CLI_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  0          AS VPAR01, ';
    strSQL := strSQL + '  0          AS VPAR02, ';
    strSQL := strSQL + '  0          AS VPAR03, ';
    strSQL := strSQL + '  0          AS VPAR04, ';
    strSQL := strSQL + '  0          AS VPAR05, ';
    strSQL := strSQL + '  0          AS VPAR06, ';
    strSQL := strSQL + '  0          AS VPAR07, ';
    strSQL := strSQL + '  0          AS VPAR08, ';
    strSQL := strSQL + '  0          AS VPAR09, ';
    strSQL := strSQL + '  0          AS VPAR10, ';
    strSQL := strSQL + '  0          AS VPAR11, ';
    strSQL := strSQL + '  0          AS VPAR12, ';
    strSQL := strSQL + '  CLI_CODREG AS CODREG, ';
    strSQL := strSQL + '  CLI_NOMCLI AS CLIORI, ';
    strSQL := strSQL + '  CLI_I_M_P_ AS I_M_P_, ';
    strSQL := strSQL + '  CLI_PRORUR AS PRORUR, ';
    strSQL := strSQL + '  CLI_MICEMP AS MICEMP, ';
    strSQL := strSQL + '  CLI_ORGPUB AS ORGPUB, ';
    strSQL := strSQL + '  CLI_DESPIS AS DESPIS, ';
    strSQL := strSQL + '  CLI_ZONFRA AS ZONFRA, ';
    strSQL := strSQL + '  CLI_DESZON AS DESZON, ';
    strSQL := strSQL + '  CLI_PERMUT AS PERMUT, ';
    strSQL := strSQL + '  CLI_SUFRAM AS CODZFM, ';
    strSQL := strSQL + '  CLI_EXPIND AS EXPIND, ';
    strSQL := strSQL + '  CLI_CONSUM AS CONSUM, ';
    strSQL := strSQL + '  CLI_TABPRE AS TABPRE, ';
    strSQL := strSQL + '  " " AS CODDIG, ';
    strSQL := strSQL + '  " " AS CODREP, ';
    strSQL := strSQL + '  " " AS CONPAG, ';
    strSQL := strSQL + '  " " AS CODCND, ';
    strSQL := strSQL + '  " " AS CODFPG, ';
    strSQL := strSQL + '  " " AS CLAFIS, ';
    strSQL := strSQL + '  0 AS TOTPRO, ';
    strSQL := strSQL + '  0 AS TOTCUS, ';
    strSQL := strSQL + '  0 AS DESESP, ';
    strSQL := strSQL + '  0 AS PORDES, ';
    strSQL := strSQL + '  0 AS BASRET, ';
    strSQL := strSQL + '  0 AS ALQRET, ';
    strSQL := strSQL + '  0 AS TOTRET, ';
    strSQL := strSQL + '  0 AS RET_SP, ';
    strSQL := strSQL + '  0 AS BARTSP, ';
    strSQL := strSQL + '  0 AS VLRTSP, ';
    strSQL := strSQL + '  0 AS BASICM, ';
    strSQL := strSQL + '  0 AS ALQICM, ';
    strSQL := strSQL + '  0 AS TOTICM, ';
    strSQL := strSQL + '  0 AS BASIPI, ';
    strSQL := strSQL + '  0 AS ALQIPI, ';
    strSQL := strSQL + '  0 AS TOTIPI, ';
    strSQL := strSQL + '  0 AS CODTRA, ';
    strSQL := strSQL + '  0 AS TIPFRE, ';
    strSQL := strSQL + '  0 AS TOTFRE, ';
    strSQL := strSQL + '  0 AS PESBRU, ';
    strSQL := strSQL + '  0 AS PESLIQ, ';
    strSQL := strSQL + '  0 AS VOLUME, ';
    strSQL := strSQL + '  0 AS NCONHE, ';
    strSQL := strSQL + '  0 AS BASSIM, ';
    strSQL := strSQL + '  " " AS MARCA_, ';
    strSQL := strSQL + '  " " AS ESPECI, ';
    strSQL := strSQL + '  " " AS MEN001, ';
    strSQL := strSQL + '  " " AS MEN002, ';
    strSQL := strSQL + '  " " AS MEN003, ';
    strSQL := strSQL + '  " " AS MEN004, ';
    strSQL := strSQL + '  " " AS MEN005, ';
    strSQL := strSQL + '  " " AS CLAFI2, ';
    strSQL := strSQL + '  " " AS CLAFI3, ';
    strSQL := strSQL + '  " " AS NATOPE, ';
    strSQL := strSQL + '  CT.AUTOINCREM AS AUTINC, ';
    strSQL := strSQL + '  CAST(CLI_CGCCPF AS UNSIGNED) AS CGCCPF, ';
    strSQL := strSQL + '  CLI_NOMCLI AS CLINOM, ';
    strSQL := strSQL + '  CLI_ENDERE AS ENDERE, ';
    strSQL := strSQL + '  CLI_ENDNUM AS ENDNUM, ';
    strSQL := strSQL + '  CLI_ENDCOM AS ENDCOM, ';
    strSQL := strSQL + '  CLI_BAIRRO AS BAIRRO, ';
    strSQL := strSQL + '  CLI_C_E_P_ AS C_E_P_, ';
    strSQL := strSQL + '  CLI_CODCID AS CODCID, ';
    strSQL := strSQL + '  CLI_FONE01 AS FONE01, ';
    strSQL := strSQL + '  CLI_NUMR_G AS NUM_RG, ';
    strSQL := strSQL + '  CLI_C_G_C_ AS C_G_C_, ';
    strSQL := strSQL + '  CLI_I_E_S_ AS I_E_S_, ';
    strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
    strSQL := strSQL + '  CLI_DIFERI AS DIFERI, ';
    strSQL := strSQL + '  CLI_DIF_ST AS DIF_ST, ';
    strSQL := strSQL + '  CLI_SITP_C AS SITP_C, ';
    strSQL := strSQL + '  CLI_MENP_C AS MENP_C, ';
    strSQL := strSQL + '  CLI_REDICM AS REDICM, ';
    strSQL := strSQL + '  CLI_DESOPE AS DESOPE, ';
    strSQL := strSQL + '  CLI_COBISS AS COBISS, ';
    strSQL := strSQL + '  CLI_CODOBR AS CODOBR, ';
    strSQL := strSQL + '  CLI_CODART AS CODART, ';
    strSQL := strSQL + '  CLI_CODATI AS CODATI, ';
    strSQL := strSQL + '  CLI_DIF_ST AS DIF_ST, ';
    strSQL := strSQL + '  CLI_SITP_C AS SITP_C, ';
    strSQL := strSQL + '  CLI_MENP_C AS MENP_C, ';
    strSQL := strSQL + '  CLI_REDICM AS REDICM, ';
    strSQL := strSQL + '  CLI_DESOPE AS DESOPE, ';
    strSQL := strSQL + '  CLI_COBISS AS COBISS, ';
    strSQL := strSQL + '  CLI_CODOBR AS CODOBR, ';
    strSQL := strSQL + '  CLI_CODART AS CODART, ';
    strSQL := strSQL + '  CLI_CODATI AS CODATI, ';

    strSQL := strSQL + '  " " AS CODS01, ';
    strSQL := strSQL + '  " " AS CODS02, ';
    strSQL := strSQL + '  " " AS CODS03, ';
    strSQL := strSQL + '  " " AS CODS04, ';
    strSQL := strSQL + '  " " AS CODS05, ';
    strSQL := strSQL + '  " " AS CODS06, ';
    strSQL := strSQL + '  " " AS CODS07, ';
    strSQL := strSQL + '  " " AS CODS08, ';
    strSQL := strSQL + '  " " AS CODS09, ';
    strSQL := strSQL + '  " " AS CODS10, ';
    strSQL := strSQL + '  " " AS CODS11, ';
    strSQL := strSQL + '  " " AS CODS12, ';
    strSQL := strSQL + '  " " AS CODS13, ';
    strSQL := strSQL + '  " " AS CODS14, ';
    strSQL := strSQL + '  " " AS CODS15, ';
    strSQL := strSQL + '  " " AS CODS16, ';
    strSQL := strSQL + '  " " AS CODS17, ';
    strSQL := strSQL + '  " " AS CODS18, ';
    strSQL := strSQL + '  " " AS CODS19, ';
    strSQL := strSQL + '  " " AS CODS20, ';
    strSQL := strSQL + '  " " AS CODS21, ';
    strSQL := strSQL + '  " " AS CODS22, ';
    strSQL := strSQL + '  " " AS CODS23, ';
    strSQL := strSQL + '  " " AS CODS24, ';
    strSQL := strSQL + '  " " AS CODS25, ';
    strSQL := strSQL + '  " " AS CODS26, ';
    strSQL := strSQL + '  " " AS CODS27, ';
    strSQL := strSQL + '  " " AS CODS28, ';
    strSQL := strSQL + '  " " AS CODS29, ';
    strSQL := strSQL + '  " " AS CODS30, ';

    strSQL := strSQL + '  " " AS DESS01, ';
    strSQL := strSQL + '  " " AS DESS02, ';
    strSQL := strSQL + '  " " AS DESS03, ';
    strSQL := strSQL + '  " " AS DESS04, ';
    strSQL := strSQL + '  " " AS DESS05, ';
    strSQL := strSQL + '  " " AS DESS06, ';
    strSQL := strSQL + '  " " AS DESS07, ';
    strSQL := strSQL + '  " " AS DESS08, ';
    strSQL := strSQL + '  " " AS DESS09, ';
    strSQL := strSQL + '  " " AS DESS10, ';
    strSQL := strSQL + '  " " AS DESS11, ';
    strSQL := strSQL + '  " " AS DESS12, ';
    strSQL := strSQL + '  " " AS DESS13, ';
    strSQL := strSQL + '  " " AS DESS14, ';
    strSQL := strSQL + '  " " AS DESS15, ';
    strSQL := strSQL + '  " " AS DESS16, ';
    strSQL := strSQL + '  " " AS DESS17, ';
    strSQL := strSQL + '  " " AS DESS18, ';
    strSQL := strSQL + '  " " AS DESS19, ';
    strSQL := strSQL + '  " " AS DESS20, ';
    strSQL := strSQL + '  " " AS DESS21, ';
    strSQL := strSQL + '  " " AS DESS22, ';
    strSQL := strSQL + '  " " AS DESS23, ';
    strSQL := strSQL + '  " " AS DESS24, ';
    strSQL := strSQL + '  " " AS DESS25, ';
    strSQL := strSQL + '  " " AS DESS26, ';
    strSQL := strSQL + '  " " AS DESS27, ';
    strSQL := strSQL + '  " " AS DESS28, ';
    strSQL := strSQL + '  " " AS DESS29, ';
    strSQL := strSQL + '  " " AS DESS30, ';

    strSQL := strSQL + '  0   AS VALS01, ';
    strSQL := strSQL + '  0   AS VALS02, ';
    strSQL := strSQL + '  0   AS VALS03, ';
    strSQL := strSQL + '  0   AS VALS04, ';
    strSQL := strSQL + '  0   AS VALS05, ';
    strSQL := strSQL + '  0   AS VALS06, ';
    strSQL := strSQL + '  0   AS VALS07, ';
    strSQL := strSQL + '  0   AS VALS08, ';
    strSQL := strSQL + '  0   AS VALS09, ';
    strSQL := strSQL + '  0   AS VALS10, ';
    strSQL := strSQL + '  0   AS VALS11, ';
    strSQL := strSQL + '  0   AS VALS12, ';
    strSQL := strSQL + '  0   AS VALS13, ';
    strSQL := strSQL + '  0   AS VALS14, ';
    strSQL := strSQL + '  0   AS VALS15, ';
    strSQL := strSQL + '  0   AS VALS16, ';
    strSQL := strSQL + '  0   AS VALS17, ';
    strSQL := strSQL + '  0   AS VALS18, ';
    strSQL := strSQL + '  0   AS VALS19, ';
    strSQL := strSQL + '  0   AS VALS20, ';
    strSQL := strSQL + '  0   AS VALS21, ';
    strSQL := strSQL + '  0   AS VALS22, ';
    strSQL := strSQL + '  0   AS VALS23, ';
    strSQL := strSQL + '  0   AS VALS24, ';
    strSQL := strSQL + '  0   AS VALS25, ';
    strSQL := strSQL + '  0   AS VALS26, ';
    strSQL := strSQL + '  0   AS VALS27, ';
    strSQL := strSQL + '  0   AS VALS28, ';
    strSQL := strSQL + '  0   AS VALS29, ';
    strSQL := strSQL + '  0   AS VALS30, ';

    strSQL := strSQL + '  0   AS PRAENT, ';
    strSQL := strSQL + '  0   AS TOTSER, ';
    strSQL := strSQL + '  0   AS VALISS, ';
    strSQL := strSQL + '  0   AS PERISS, ';
    strSQL := strSQL + '  0   AS HORENT, ';
    strSQL := strSQL + '  0   AS DESACE, ';
    strSQL := strSQL + '  0   AS ALQIRF, ';
    strSQL := strSQL + '  0   AS VALIRF, ';
    strSQL := strSQL + '  0   AS ALQPIS, ';
    strSQL := strSQL + '  0   AS VALPIS, ';
    strSQL := strSQL + '  0   AS ALQCOF, ';
    strSQL := strSQL + '  0   AS VALCOF, ';
    strSQL := strSQL + '  0   AS ALQCSL, ';
    strSQL := strSQL + '  0   AS VALCSL, ';
    strSQL := strSQL + '  0   AS RETPCO, ';
    strSQL := strSQL + '  0   AS RETIRF, ';
    strSQL := strSQL + '  0   AS RETISS, ';
    strSQL := strSQL + '  0   AS SEGSOC, ';
    strSQL := strSQL + '  0   AS CDESPI, ';
    strSQL := strSQL + '  0   AS SITIPI, ';
    strSQL := strSQL + '  0   AS ENQIPI, ';
    strSQL := strSQL + '  0   AS MENIPI, ';
    strSQL := strSQL + '  0   AS ORPURD, ';
    strSQL := strSQL + '  0   AS CALICM, ';
    strSQL := strSQL + '  " "   AS NOTRET, ';
    strSQL := strSQL + '  0   AS IRFRET, ';
    strSQL := strSQL + '  0   AS PISRET, ';
    strSQL := strSQL + '  0   AS COFRET, ';
    strSQL := strSQL + '  0   AS CSLRET, ';
    strSQL := strSQL + '  0   AS SERRET, ';
    strSQL := strSQL + '  " "   AS NORESE, ';
    strSQL := strSQL + '  0   AS IRPRRT, ';
    strSQL := strSQL + '  0   AS IRPRDV, ';
    strSQL := strSQL + '  0   AS IRSERT, ';
    strSQL := strSQL + '  0   AS IRSEDV, ';
    strSQL := strSQL + '  0   AS PIPRRT, ';
    strSQL := strSQL + '  0   AS PIPRDV, ';
    strSQL := strSQL + '  0   AS PISERT, ';
    strSQL := strSQL + '  0   AS PISEDV, ';
    strSQL := strSQL + '  0   AS COPRRT, ';
    strSQL := strSQL + '  0   AS COPRDV, ';
    strSQL := strSQL + '  0   AS COSERT, ';
    strSQL := strSQL + '  0   AS COSEDV, ';
    strSQL := strSQL + '  0   AS CSPRRT, ';
    strSQL := strSQL + '  0   AS CSPRDV, ';
    strSQL := strSQL + '  0   AS CSSERT, ';
    strSQL := strSQL + '  0   AS CSSEDV, ';
    strSQL := strSQL + '  0   AS VLSGSO, ';
    strSQL := strSQL + '  0   AS PESGSO, ';
    strSQL := strSQL + '  0000000.00 AS DUPREC, ';
    strSQL := strSQL + '  0 AS BASORG, ';
    strSQL := strSQL + '  0 AS ICMORG, ';
    strSQL := strSQL + '  "N" AS ENTFAT, ';
    strSQL := strSQL + '  "N" AS NOTESP, ';
    strSQL := strSQL + '  "MOVCTE    "  AS TABELA, ';
    strSQL := strSQL + '  GER_TIP_FC AS TIP_FC, ';
    strSQL := strSQL + '  " " AS ORIDOC, ';
    strSQL := strSQL + '  CTE_VLRIMP AS VLRCON, ';
    strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS DOCORI, ';
    strSQL := strSQL + '  "N" AS DOCFOR,  ';
    strSQL := strSQL + '  " " AS NROCEI,  ';
    strSQL := strSQL + '  CAST(" " AS CHAR(20)) AS ORDPRO ';
    strSQL := strSQL + 'FROM ';

    strSQL := strSQL + ' MOVCTE CT                                             ';
    strSQL := strSQL + ' INNER JOIN MOVGER MG ON MG.AUTOINCREM = CT.CTE_SEQGER ';
    strSQL := strSQL + ' INNER JOIN CADEMP ON EMP_CODEMP  = MG.GER_CODEMP';
    strSQL := strSQL + ' INNER JOIN CADCLI C ON EMP_CLIFIL = C.CLI_CODCLI   ';

    strSQL := strSQL + 'WHERE TRUE ';

    If (Not fEmptyStr(strNumDoc)) then
      strSQL := strSQL + ' AND CONCAT("000", CTE_NUMCTE) = :NUMDOC ';

    If (Not fEmptyStr(strCodEmp)) then
      strSQL := strSQL + ' AND CTE_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + ' AND ' + fGetSQLInEmpresasReimpressao('CTE_CODEMP') + ' ';

    strSQL := strSQL + 'AND CTE_DTAEMI >= :DTAINI AND CTE_DTAEMI <= :DTAFIN ';

    If (FTipoConsCli = tpLibCliVenLog) and (strTip_Fc = 'C') and fEmptyStr(strCodCli) Then
    Begin
      strSQL := strSQL + ' AND CLI_CODVEN =  ' + QuotedStr(strLoginUsuarioLogado);
    End;

    strSQL := strSQL + ' GROUP BY NUMDOC, ESPDOC, CODEMP ';

    If blnExiDocsCanc Then
    Begin
      strSQL2 := strSQL;
      strSQL2 := AnsiReplaceStr(strSQL2, 'MOVCTE', 'DEL_MOVCTE');
      strSQL2 := AnsiReplaceStr(strSQL2, 'MOVGER', 'DEL_MOVGER');

      strSQL2 := AnsiReplaceStr(strSQL2, '" " AS DOCCAN', '"C" AS DOCCAN');
      strSQL2 := AnsiReplaceStr(strSQL2, '" " AS OPEDEL', 'CT.OPEDEL AS OPEDEL');
      strSQL2 := AnsiReplaceStr(strSQL2, '" " AS DTADEL', 'DATE_FORMAT(CT.DTADEL,"%d/%m/%Y") AS DTADEL');

      strSQL  := strSQL + ' UNION ALL ' + strSQL2;
    End;

    objDocumentos.strSqlDocs := strSQL;

    If (Not fEmptyStr(strNumDoc)) then
      objDocumentos.pAddFiltro('NUMDOC', strNumDoc);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

    objDocumentos.pAddFiltro('DTAINI', dtaDtaIni);
    objDocumentos.pAddFiltro('DTAFIN', dtaDtaFin);

    objDocumentos.pCarregarDocumentos;

    //NOTCTE
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE DISTINCT     ';
    strSQL := strSQL + '  CTE_SERIE_ AS SERIE_, ';
    strSQL := strSQL + '  " " AS NUMFAT, ';
    strSQL := strSQL + '  CAST(" "  AS CHAR(100)) AS SITUACAO, ';
    strSQL := strSQL + '  " " AS DOCCAN, ';
    strSQL := strSQL + '  " " AS MOTDEL, ';
    strSQL := strSQL + '  " " AS DTADEL, ';
    strSQL := strSQL + '  " " AS OPEDEL, ';
    strSQL := strSQL + '  CTE_DTAEMI AS DTAENT, ';
    strSQL := strSQL + '  CONCAT("000", CTE_NUMCTE) AS NUMDOC, ';
    strSQL := strSQL + '  "CT" AS ESPDOC, ';
    strSQL := strSQL + '  " " AS ESAJML, ';
    strSQL := strSQL + '  CTE_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  CAST(GROUP_CONCAT(DISTINCT GER_CODVEN) AS CHAR(64)) AS CODVEN, ';
    strSQL := strSQL + '  CLI_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  0          AS VPAR01, ';
    strSQL := strSQL + '  0          AS VPAR02, ';
    strSQL := strSQL + '  0          AS VPAR03, ';
    strSQL := strSQL + '  0          AS VPAR04, ';
    strSQL := strSQL + '  0          AS VPAR05, ';
    strSQL := strSQL + '  0          AS VPAR06, ';
    strSQL := strSQL + '  0          AS VPAR07, ';
    strSQL := strSQL + '  0          AS VPAR08, ';
    strSQL := strSQL + '  0          AS VPAR09, ';
    strSQL := strSQL + '  0          AS VPAR10, ';
    strSQL := strSQL + '  0          AS VPAR11, ';
    strSQL := strSQL + '  0          AS VPAR12, ';
    strSQL := strSQL + '  CLI_CODREG AS CODREG, ';
    strSQL := strSQL + '  CLI_NOMCLI AS CLIORI, ';
    strSQL := strSQL + '  CLI_I_M_P_ AS I_M_P_, ';
    strSQL := strSQL + '  CLI_PRORUR AS PRORUR, ';
    strSQL := strSQL + '  CLI_MICEMP AS MICEMP, ';
    strSQL := strSQL + '  CLI_ORGPUB AS ORGPUB, ';
    strSQL := strSQL + '  CLI_DESPIS AS DESPIS, ';
    strSQL := strSQL + '  CLI_ZONFRA AS ZONFRA, ';
    strSQL := strSQL + '  CLI_DESZON AS DESZON, ';
    strSQL := strSQL + '  CLI_PERMUT AS PERMUT, ';
    strSQL := strSQL + '  CLI_SUFRAM AS CODZFM, ';
    strSQL := strSQL + '  CLI_EXPIND AS EXPIND, ';
    strSQL := strSQL + '  CLI_CONSUM AS CONSUM, ';
    strSQL := strSQL + '  CLI_TABPRE AS TABPRE, ';
    strSQL := strSQL + '  " " AS CODDIG, ';
    strSQL := strSQL + '  " " AS CODREP, ';
    strSQL := strSQL + '  " " AS CONPAG, ';
    strSQL := strSQL + '  " " AS CODCND, ';
    strSQL := strSQL + '  " " AS CODFPG, ';
    strSQL := strSQL + '  " " AS CLAFIS, ';
    strSQL := strSQL + '  0 AS TOTPRO, ';
    strSQL := strSQL + '  0 AS TOTCUS, ';
    strSQL := strSQL + '  0 AS DESESP, ';
    strSQL := strSQL + '  0 AS PORDES, ';
    strSQL := strSQL + '  0 AS BASRET, ';
    strSQL := strSQL + '  0 AS ALQRET, ';
    strSQL := strSQL + '  0 AS TOTRET, ';
    strSQL := strSQL + '  0 AS RET_SP, ';
    strSQL := strSQL + '  0 AS BARTSP, ';
    strSQL := strSQL + '  0 AS VLRTSP, ';
    strSQL := strSQL + '  0 AS BASICM, ';
    strSQL := strSQL + '  0 AS ALQICM, ';
    strSQL := strSQL + '  0 AS TOTICM, ';
    strSQL := strSQL + '  0 AS BASIPI, ';
    strSQL := strSQL + '  0 AS ALQIPI, ';
    strSQL := strSQL + '  0 AS TOTIPI, ';
    strSQL := strSQL + '  0 AS CODTRA, ';
    strSQL := strSQL + '  0 AS TIPFRE, ';
    strSQL := strSQL + '  0 AS TOTFRE, ';
    strSQL := strSQL + '  0 AS PESBRU, ';
    strSQL := strSQL + '  0 AS PESLIQ, ';
    strSQL := strSQL + '  0 AS VOLUME, ';
    strSQL := strSQL + '  0 AS NCONHE, ';
    strSQL := strSQL + '  0 AS BASSIM, ';
    strSQL := strSQL + '  " " AS MARCA_, ';
    strSQL := strSQL + '  " " AS ESPECI, ';
    strSQL := strSQL + '  " " AS MEN001, ';
    strSQL := strSQL + '  " " AS MEN002, ';
    strSQL := strSQL + '  " " AS MEN003, ';
    strSQL := strSQL + '  " " AS MEN004, ';
    strSQL := strSQL + '  " " AS MEN005, ';
    strSQL := strSQL + '  " " AS CLAFI2, ';
    strSQL := strSQL + '  " " AS CLAFI3, ';
    strSQL := strSQL + '  " " AS NATOPE, ';
    strSQL := strSQL + '  NCT.AUTOINCREM AS AUTINC, ';
    strSQL := strSQL + '  CAST(CLI_CGCCPF AS UNSIGNED) AS CGCCPF, ';
    strSQL := strSQL + '  CLI_NOMCLI AS CLINOM, ';
    strSQL := strSQL + '  CLI_ENDERE AS ENDERE, ';
    strSQL := strSQL + '  CLI_ENDNUM AS ENDNUM, ';
    strSQL := strSQL + '  CLI_ENDCOM AS ENDCOM, ';
    strSQL := strSQL + '  CLI_BAIRRO AS BAIRRO, ';
    strSQL := strSQL + '  CLI_C_E_P_ AS C_E_P_, ';
    strSQL := strSQL + '  CLI_CODCID AS CODCID, ';
    strSQL := strSQL + '  CLI_FONE01 AS FONE01, ';
    strSQL := strSQL + '  CLI_NUMR_G AS NUM_RG, ';
    strSQL := strSQL + '  CLI_C_G_C_ AS C_G_C_, ';
    strSQL := strSQL + '  CLI_I_E_S_ AS I_E_S_, ';
    strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
    strSQL := strSQL + '  CLI_DIFERI AS DIFERI, ';
    strSQL := strSQL + '  CLI_DIF_ST AS DIF_ST, ';
    strSQL := strSQL + '  CLI_SITP_C AS SITP_C, ';
    strSQL := strSQL + '  CLI_MENP_C AS MENP_C, ';
    strSQL := strSQL + '  CLI_REDICM AS REDICM, ';
    strSQL := strSQL + '  CLI_DESOPE AS DESOPE, ';
    strSQL := strSQL + '  CLI_COBISS AS COBISS, ';
    strSQL := strSQL + '  CLI_CODOBR AS CODOBR, ';
    strSQL := strSQL + '  CLI_CODART AS CODART, ';
    strSQL := strSQL + '  CLI_CODATI AS CODATI, ';
    strSQL := strSQL + '  CLI_DIF_ST AS DIF_ST, ';
    strSQL := strSQL + '  CLI_SITP_C AS SITP_C, ';
    strSQL := strSQL + '  CLI_MENP_C AS MENP_C, ';
    strSQL := strSQL + '  CLI_REDICM AS REDICM, ';
    strSQL := strSQL + '  CLI_DESOPE AS DESOPE, ';
    strSQL := strSQL + '  CLI_COBISS AS COBISS, ';
    strSQL := strSQL + '  CLI_CODOBR AS CODOBR, ';
    strSQL := strSQL + '  CLI_CODART AS CODART, ';
    strSQL := strSQL + '  CLI_CODATI AS CODATI, ';

    strSQL := strSQL + '  " " AS CODS01, ';
    strSQL := strSQL + '  " " AS CODS02, ';
    strSQL := strSQL + '  " " AS CODS03, ';
    strSQL := strSQL + '  " " AS CODS04, ';
    strSQL := strSQL + '  " " AS CODS05, ';
    strSQL := strSQL + '  " " AS CODS06, ';
    strSQL := strSQL + '  " " AS CODS07, ';
    strSQL := strSQL + '  " " AS CODS08, ';
    strSQL := strSQL + '  " " AS CODS09, ';
    strSQL := strSQL + '  " " AS CODS10, ';
    strSQL := strSQL + '  " " AS CODS11, ';
    strSQL := strSQL + '  " " AS CODS12, ';
    strSQL := strSQL + '  " " AS CODS13, ';
    strSQL := strSQL + '  " " AS CODS14, ';
    strSQL := strSQL + '  " " AS CODS15, ';
    strSQL := strSQL + '  " " AS CODS16, ';
    strSQL := strSQL + '  " " AS CODS17, ';
    strSQL := strSQL + '  " " AS CODS18, ';
    strSQL := strSQL + '  " " AS CODS19, ';
    strSQL := strSQL + '  " " AS CODS20, ';
    strSQL := strSQL + '  " " AS CODS21, ';
    strSQL := strSQL + '  " " AS CODS22, ';
    strSQL := strSQL + '  " " AS CODS23, ';
    strSQL := strSQL + '  " " AS CODS24, ';
    strSQL := strSQL + '  " " AS CODS25, ';
    strSQL := strSQL + '  " " AS CODS26, ';
    strSQL := strSQL + '  " " AS CODS27, ';
    strSQL := strSQL + '  " " AS CODS28, ';
    strSQL := strSQL + '  " " AS CODS29, ';
    strSQL := strSQL + '  " " AS CODS30, ';

    strSQL := strSQL + '  " " AS DESS01, ';
    strSQL := strSQL + '  " " AS DESS02, ';
    strSQL := strSQL + '  " " AS DESS03, ';
    strSQL := strSQL + '  " " AS DESS04, ';
    strSQL := strSQL + '  " " AS DESS05, ';
    strSQL := strSQL + '  " " AS DESS06, ';
    strSQL := strSQL + '  " " AS DESS07, ';
    strSQL := strSQL + '  " " AS DESS08, ';
    strSQL := strSQL + '  " " AS DESS09, ';
    strSQL := strSQL + '  " " AS DESS10, ';
    strSQL := strSQL + '  " " AS DESS11, ';
    strSQL := strSQL + '  " " AS DESS12, ';
    strSQL := strSQL + '  " " AS DESS13, ';
    strSQL := strSQL + '  " " AS DESS14, ';
    strSQL := strSQL + '  " " AS DESS15, ';
    strSQL := strSQL + '  " " AS DESS16, ';
    strSQL := strSQL + '  " " AS DESS17, ';
    strSQL := strSQL + '  " " AS DESS18, ';
    strSQL := strSQL + '  " " AS DESS19, ';
    strSQL := strSQL + '  " " AS DESS20, ';
    strSQL := strSQL + '  " " AS DESS21, ';
    strSQL := strSQL + '  " " AS DESS22, ';
    strSQL := strSQL + '  " " AS DESS23, ';
    strSQL := strSQL + '  " " AS DESS24, ';
    strSQL := strSQL + '  " " AS DESS25, ';
    strSQL := strSQL + '  " " AS DESS26, ';
    strSQL := strSQL + '  " " AS DESS27, ';
    strSQL := strSQL + '  " " AS DESS28, ';
    strSQL := strSQL + '  " " AS DESS29, ';
    strSQL := strSQL + '  " " AS DESS30, ';

    strSQL := strSQL + '  0   AS VALS01, ';
    strSQL := strSQL + '  0   AS VALS02, ';
    strSQL := strSQL + '  0   AS VALS03, ';
    strSQL := strSQL + '  0   AS VALS04, ';
    strSQL := strSQL + '  0   AS VALS05, ';
    strSQL := strSQL + '  0   AS VALS06, ';
    strSQL := strSQL + '  0   AS VALS07, ';
    strSQL := strSQL + '  0   AS VALS08, ';
    strSQL := strSQL + '  0   AS VALS09, ';
    strSQL := strSQL + '  0   AS VALS10, ';
    strSQL := strSQL + '  0   AS VALS11, ';
    strSQL := strSQL + '  0   AS VALS12, ';
    strSQL := strSQL + '  0   AS VALS13, ';
    strSQL := strSQL + '  0   AS VALS14, ';
    strSQL := strSQL + '  0   AS VALS15, ';
    strSQL := strSQL + '  0   AS VALS16, ';
    strSQL := strSQL + '  0   AS VALS17, ';
    strSQL := strSQL + '  0   AS VALS18, ';
    strSQL := strSQL + '  0   AS VALS19, ';
    strSQL := strSQL + '  0   AS VALS20, ';
    strSQL := strSQL + '  0   AS VALS21, ';
    strSQL := strSQL + '  0   AS VALS22, ';
    strSQL := strSQL + '  0   AS VALS23, ';
    strSQL := strSQL + '  0   AS VALS24, ';
    strSQL := strSQL + '  0   AS VALS25, ';
    strSQL := strSQL + '  0   AS VALS26, ';
    strSQL := strSQL + '  0   AS VALS27, ';
    strSQL := strSQL + '  0   AS VALS28, ';
    strSQL := strSQL + '  0   AS VALS29, ';
    strSQL := strSQL + '  0   AS VALS30, ';

    strSQL := strSQL + '  0   AS PRAENT, ';
    strSQL := strSQL + '  0   AS TOTSER, ';
    strSQL := strSQL + '  0   AS VALISS, ';
    strSQL := strSQL + '  0   AS PERISS, ';
    strSQL := strSQL + '  0   AS HORENT, ';
    strSQL := strSQL + '  0   AS DESACE, ';
    strSQL := strSQL + '  0   AS ALQIRF, ';
    strSQL := strSQL + '  0   AS VALIRF, ';
    strSQL := strSQL + '  0   AS ALQPIS, ';
    strSQL := strSQL + '  0   AS VALPIS, ';
    strSQL := strSQL + '  0   AS ALQCOF, ';
    strSQL := strSQL + '  0   AS VALCOF, ';
    strSQL := strSQL + '  0   AS ALQCSL, ';
    strSQL := strSQL + '  0   AS VALCSL, ';
    strSQL := strSQL + '  0   AS RETPCO, ';
    strSQL := strSQL + '  0   AS RETIRF, ';
    strSQL := strSQL + '  0   AS RETISS, ';
    strSQL := strSQL + '  0   AS SEGSOC, ';
    strSQL := strSQL + '  0   AS CDESPI, ';
    strSQL := strSQL + '  0   AS SITIPI, ';
    strSQL := strSQL + '  0   AS ENQIPI, ';
    strSQL := strSQL + '  0   AS MENIPI, ';
    strSQL := strSQL + '  0   AS ORPURD, ';
    strSQL := strSQL + '  0   AS CALICM, ';
    strSQL := strSQL + '  " "   AS NOTRET, ';
    strSQL := strSQL + '  0   AS IRFRET, ';
    strSQL := strSQL + '  0   AS PISRET, ';
    strSQL := strSQL + '  0   AS COFRET, ';
    strSQL := strSQL + '  0   AS CSLRET, ';
    strSQL := strSQL + '  0   AS SERRET, ';
    strSQL := strSQL + '  " "   AS NORESE, ';
    strSQL := strSQL + '  0   AS IRPRRT, ';
    strSQL := strSQL + '  0   AS IRPRDV, ';
    strSQL := strSQL + '  0   AS IRSERT, ';
    strSQL := strSQL + '  0   AS IRSEDV, ';
    strSQL := strSQL + '  0   AS PIPRRT, ';
    strSQL := strSQL + '  0   AS PIPRDV, ';
    strSQL := strSQL + '  0   AS PISERT, ';
    strSQL := strSQL + '  0   AS PISEDV, ';
    strSQL := strSQL + '  0   AS COPRRT, ';
    strSQL := strSQL + '  0   AS COPRDV, ';
    strSQL := strSQL + '  0   AS COSERT, ';
    strSQL := strSQL + '  0   AS COSEDV, ';
    strSQL := strSQL + '  0   AS CSPRRT, ';
    strSQL := strSQL + '  0   AS CSPRDV, ';
    strSQL := strSQL + '  0   AS CSSERT, ';
    strSQL := strSQL + '  0   AS CSSEDV, ';
    strSQL := strSQL + '  0   AS VLSGSO, ';
    strSQL := strSQL + '  0   AS PESGSO, ';
    strSQL := strSQL + '  0000000.00 AS DUPREC, ';
    strSQL := strSQL + '  0 AS BASORG, ';
    strSQL := strSQL + '  0 AS ICMORG, ';
    strSQL := strSQL + '  "N" AS ENTFAT, ';
    strSQL := strSQL + '  "N" AS NOTESP, ';
    strSQL := strSQL + '  "MOVCTE    "  AS TABELA, ';
    strSQL := strSQL + '  GER_TIP_FC AS TIP_FC, ';
    strSQL := strSQL + '  " " AS ORIDOC, ';
    strSQL := strSQL + '  CTE_VLRIMP AS VLRCON, ';
    strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS DOCORI, ';
    strSQL := strSQL + '  "N" AS DOCFOR,  ';
    strSQL := strSQL + '  " " AS NROCEI,  ';
    strSQL := strSQL + '  CAST(" " AS CHAR(20)) AS ORDPRO ';
    strSQL := strSQL + 'FROM ';

    strSQL := strSQL + ' NOTCTE NCT                                             ';
    strSQL := strSQL + ' INNER JOIN NOTGER NG ON NG.AUTOINCREM = NCT.CTE_SEQGER ';
    strSQL := strSQL + ' INNER JOIN CADEMP ON EMP_CODEMP  = NG.GER_CODEMP';
    strSQL := strSQL + ' INNER JOIN CADCLI C ON EMP_CLIFIL = C.CLI_CODCLI   ';

    strSQL := strSQL + 'WHERE TRUE ';

    If (Not fEmptyStr(strNumDoc)) then
      strSQL := strSQL + ' AND CONCAT("000", CTE_NUMCTE) = :NUMDOC ';

    If (Not fEmptyStr(strCodEmp)) then
      strSQL := strSQL + ' AND CTE_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + ' AND ' + fGetSQLInEmpresasReimpressao('CTE_CODEMP') + ' ';

    strSQL := strSQL + 'AND CTE_DTAEMI >= :DTAINI AND CTE_DTAEMI <= :DTAFIN ';

    If (FTipoConsCli = tpLibCliVenLog) and (strTip_Fc = 'C') and fEmptyStr(strCodCli) Then
    Begin
      strSQL := strSQL + ' AND CLI_CODVEN =  ' + QuotedStr(strLoginUsuarioLogado);
    End;

    strSQL := strSQL + ' GROUP BY NUMDOC, ESPDOC, CODEMP ';

    If blnExiDocsCanc Then
    Begin
      strSQL2 := strSQL;
      strSQL2 := AnsiReplaceStr(strSQL2, 'NOTCTE', 'DEL_NOTCTE');
      strSQL2 := AnsiReplaceStr(strSQL2, 'NOTGER', 'DEL_NOTGER');

      strSQL2 := AnsiReplaceStr(strSQL2, '" " AS DOCCAN', '"C" AS DOCCAN');
      strSQL2 := AnsiReplaceStr(strSQL2, '" " AS OPEDEL', 'NCT.OPEDEL AS OPEDEL');
      strSQL2 := AnsiReplaceStr(strSQL2, '" " AS DTADEL', 'DATE_FORMAT(NCT.DTADEL,"%d/%m/%Y") AS DTADEL');

      strSQL  := strSQL + ' UNION ALL ' + strSQL2;
    End;

    objDocumentos.strSqlDocs := strSQL;

    If (Not fEmptyStr(strNumDoc)) then
      objDocumentos.pAddFiltro('NUMDOC', strNumDoc);

    If Not fEmptyStr(strCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', strCodEmp);

    objDocumentos.pAddFiltro('DTAINI', dtaDtaIni);
    objDocumentos.pAddFiltro('DTAFIN', dtaDtaFin);

    objDocumentos.pCarregarDocumentos;
  end;

  objDocumentos.cdsDocumentos.IndexFieldNames := 'DTAENT;NUMDOC;ESPDOC';

  (objDocumentos.cdsDocumentos.FieldByName('VLRCON') As TFloatField).DisplayFormat := '#,##0.00';

  blnReimpressaoDaSeparacaoPedido := True;
  blnImpressaoColetor := False;
end;

procedure TReimpressao.pReimprimeDocumento(blnImpNFDireto: Boolean = False;
                                           blnQtdOri: Boolean = False;
                                           blnDocCan: Boolean = False;
                                           blnVerCfg: Boolean = True;
                                           blnImpPed: Boolean = False;
                                           opcEdtFst: TOpcEditorFast = opcPergunta;
                                           blnEditor: Boolean = False;
                                           tipLibPed: TLibPed = libAmbos;
                                           blnF9OrF10: Boolean = False;
                                           blnGerPdf: Boolean = False;
                                           strPasPdf: String = '';
                                           blnVisPdf: Boolean = False;
                                           blnOpcFat: Boolean = False);
  Var
    strTabela: String;
    strSenha : String;
    strOpcDoc: String;
    blnImpTck: Boolean;
    blnAjMl: Boolean;
    strNomeArquivo: String;
    intQtdV: Integer;
    LMensagem : string;
    blnSomenteServ: Boolean;
    frmImpContratoLocacao: TfrmImpContratoLocacao;
begin

  fDocumentoPossuiServicos(objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString,
                           objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString,
                           objDocumentos.cdsDocumentos.FieldByName('CODEMP').AsString,
                           blnSomenteServ);

  With objDocumentos.cdsDocumentos Do
  Begin
    blnAjMl := False;

    If Assigned(objDocumentos.cdsDocumentos.FindField('ESAJML')) Then
      If objDocumentos.cdsDocumentos.FieldByName('ESAJML').AsString =  'AJML' Then
        blnAjMl := True;

    If (IsEmpty) Then
      Exit;

    strTabela := fGetNomeTabela;

    untFatImpressao.blnSimples := False;

    If Pos(FieldByName('ESPDOC').AsString, 'NF_EL_NS_NV_') > 0 Then
    Begin

      If (opcEdtFst = opcPergunta) And (Not blnDocCan) And ((blnImpNFDireto) Or (fMensagem('','Opção:',['Form. NF','Form.Simples']) = 1)) Then
      Begin
        untFatImpressao.blnSimples := False;

        If (Not fEmptyStr(fCfgSis('SERINF'))) And (Not FFatVenda) Then
        Begin
          ffrmSenha(strSenha);
          If strSenha = fCfgSis('SERINF') Then
            pImprimeNota(strTabela);
        End
        Else
          pImprimeNota(strTabela);
      End
      Else
      Begin
        untFatImpressao.blnSimples := True;

        If (opcEdtFst = opcPergunta) Then
        Begin
          If fMensagem('','Saída',['&Video','&Imprimir']) = 1 Then
            strTipImp := 'V'
          Else
            strTipImp := 'I';
        End
        Else
        Begin

          Case opcEdtFst Of
            opcVideo: strTipImp := 'V';
            opcEmail: strTipImp := 'P';
          End;

        End;

        intQtdV := IIf(FieldByName('ESPDOC').AsString = 'PD', fCfgSis('VIA_PD', varInteger), 1);
        If intQtdV < 1 Then
          intQtdV := 1;


        pImprimeFatImpAux(strTabela,
                          FieldByName('NUMDOC').AsString,
                          FieldByName('ESPDOC').AsString,
                          FieldByName('CODEMP').AsString,
                          FieldByName('CODCLI').AsString,
                          FieldByName('TIP_FC').AsString,
                          FieldByName('ORIDOC').AsString,
                          True,
                          strNomeArquivo,
                          False,
                          blnEditor,
                          blnImprimiuEditor,
                          blnImprimiuAmbien,
                          strArqPDF,
                          blnTemLay,
                          strTipImp,
                          intQtdV,
                          impComPrecoGeral,
                          0,
                          False,
                          False,
                          True,
                          False,
                          '',
                          '',
                          blnDocCan,
                          blnExpedicao,
                          False,
                          False,
                          False,
                          False,
                          False,
                          opcTodos,
                          False,
                          False,
                          False,
                          False,
                          False,
                          '',
                          '',
                          Nil,
                          False,
                          '',
                          '',
                          '',
                          False,
                          opcNaoAgrupa,
                          False,
                          '',
                          '',
                          False,
                          False,
                          blnGerPdf,
                          strPasPdf,
                          blnVisPdf,
                          False,
                          False,
                          False,
                          False,
                          False,
                          '',
                          '',
                          '',
                          False,
                          blnAjMl);
      End;

    End
    Else
    If Pos(FieldByName('ESPDOC').AsString, 'RL_') > 0 Then
    Begin
       pCriarFormularios(TfrmImpContratoLocacao, frmImpContratoLocacao);
       Try

         If (opcEdtFst = opcPergunta) Then
         Begin
           If fMensagem('','Saída',['&Video','&Imprimir']) = 1 Then
           begin
             opcEdtFst := opcVideo;
           End
         End;

         frmImpContratoLocacao.pImprimeContratoLocacao(FieldByName('ESPDOC').AsString,
                                                       FieldByName('CODEMP').AsString,
                                                       FieldByName('NUMDOC').AsString,
                                                       FieldByName('CODCLI').AsString,
                                                       blnF9OrF10,
                                                       False,
                                                       (opcEdtFst = opcVideo));

         strNomeArquivo := frmImpContratoLocacao.strNomeArquivo;

         Self.blnImprimiuAmbien := True;

       finally
         pFreeAndNil(frmImpContratoLocacao);
       end;
    End
    Else Begin
      If (opcEdtFst = opcPergunta) Then
      Begin
        If (tipLibPed <> libSeparacao) Then
        Begin
          If fMensagem('','Saída',['&Video','&Imprimir']) = 1 Then
            strTipImp := 'V'
          Else
            strTipImp := 'I';
        End;
      End
      Else
      Begin

        Case opcEdtFst Of
          opcVideo: strTipImp := 'V';
          opcEmail: strTipImp := 'P';
        End;

      End;

      {**************************************************************}
      {* ANTERIORMENTE ESTA PASSANDO SOMENTE ATÉ O OITAVO PARAMETRO *}
      {* POREM NA REIMPRESSAO DE IF COM IMPTCK ELE NÃO CORREGAVA    *}
      {* PARA REIMPRESSAO, SOMENTE PARA IMPRESSÃO.ENTAO INCLUI ESSE *}
      {* PARAMETRO PARA REIMPRESSAO TAMBÉM                          *}
      {***********************************************************AC*}
      If fCfgSis('IMPTCK', varBoolean) Then
        blnImpTck := True
      Else
        blnImpTck := False;

      intQtdV := IIf(FieldByName('ESPDOC').AsString = 'PD', fCfgSis('VIA_PD', varInteger), 1);
      If intQtdV < 1 Then
        intQtdV := 1;

      If (tipLibPed <> libSeparacao) Then
      Begin
        pImprimeFatImpAux(strTabela,
                         IIf(blnAjMl, objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString,
                             IIF(SameText(FieldByName('ESPDOC').AsString, 'ML'), Copy(FieldByName('NUMFAT').AsString, 1, fTamDocCadRec()), FieldByName('NUMDOC').AsString)),
                          FieldByName('ESPDOC').AsString,
                          FieldByName('CODEMP').AsString,
                          FieldByName('CODCLI').AsString,
                          FieldByName('TIP_FC').AsString,
                          FieldByName('ORIDOC').AsString,
                          True,
                          strNomeArquivo,
                          False,
                          blnEditor,
                          blnImprimiuEditor,
                          blnImprimiuAmbien,
                          strArqPDF,
                          blnTemLay,
                          strTipImp,
                          intQtdV,
                          impComPrecoGeral,
                          0,
                          False,
                          blnImpTck,
                          True,
                          blnQtdOri,
                          '',
                          '',
                          blnDocCan,
                          blnExpedicao,
                          False,
                          False,
                          False,
                          False,
                          False,
                          opcTodos,
                          False,
                          False,
                          False,
                          False,
                          False,
                          '',
                          '',
                          Nil,
                          False,
                          '',
                          '',
                          '',
                          False,
                          opcNaoAgrupa,
                          False,
                          '',
                          '',
                          blnF9OrF10,
                          False,
                          blnGerPdf,
                          strPasPdf,
                          blnVisPdf,
                          False,
                          False,
                          False,
                          False,
                          False,
                          '',
                          '',
                          '',
                          False,
                          blnAjMl,
                          '',
                          0,
                          0,
                          False,
                          '',
                          False,
                          False,
                          False,
                          '',
                          False,
                          False,
                          False,
                          False,
                          blnOpcFat);

        If fVaiImprirComplementoFF(FieldByName('ESPDOC').AsString, FieldByName('CODCLI').AsString) Then
        Begin
          If fMensagem('', 'Deseja reimprimir o layout complementar do documento FF?', ['&Sim', '&Não']) = 1 Then
          Begin
            pReimprimeComplementoFF(FieldByName('NUMDOC').AsString,
                                    FieldByName('ESPDOC').AsString,
                                    FieldByName('CODEMP').AsString,
                                    FieldByName('CODCLI').AsString,
                                    FieldByName('TIP_FC').AsString,
                                    strTipImp,
                                    intQtdV);
          End;
        End;
      End;
    End;

    if (Pos(FieldByName('ESPDOC').AsString, 'NF_IF_') > 0) and
       fCfgSis('IMPECA', varBoolean) and
       ((opcEdtFst = opcPergunta) or ((opcEdtFst <> opcPergunta) and blnImprimiuEditor)) then
    begin
      pCriarFormularios(TfrmQckFatImpNFCe, frmQckFatImpNFCe);
      Try
        if not frmQckFatImpNFCe.fImprimirEspelhoCartaoVinculado(FieldByName('NUMDOC').AsString,
                                                                FieldByName('ESPDOC').AsString,
                                                                FieldByName('CODEMP').AsString,
                                                                '',
                                                                IIF(fEmptyStr(strTipImp),'V',strTipImp),
                                                                blnGerPdf,
                                                                strArqPDF,
                                                                LMensagem) then
          fMensagem('ATENÇÃO',LMensagem,['&OK']);
      Finally
        pFreeAndNil(frmQckFatImpNFCe);
      End;
    end;

    If Pos(FieldByName('ESPDOC').AsString, 'FF_') > 0 Then
    begin
      intQtdV := fCfgSis('QTDVFV', varInteger);
      If intQtdV < 1 Then
        intQtdV := 1;

      pReimprimeCreditosFF(FieldByName('NUMDOC').AsString,
                           FieldByName('ESPDOC').AsString,
                           FieldByName('CODEMP').AsString,
                           FieldByName('CODCLI').AsString,
                           FieldByName('TIP_FC').AsString,
                           strTipImp,
                           intQtdV);
    end;

    strOpcDoc := '';
    If (Assigned(fatVenda)) Then
      strOpcDoc := fatVenda.strOpcDoc
    {********************************************************************}
    {* SE CASO FOR RECEBIMENTO DE CLIENTE (GARANTIA) E FOR UMA NF       *}
    {* EMITIDA PELAS OUTRAS SAIDAS (CLIENTE), NA REIMPRESSÃO NÃO IRÁ    *}
    {* TER O OPCDOC, E É PRECISO, POIS SÓ SERÁ IMPRESSO A SERAPÇÃO      *}
    {* SE A VARIAVEL strOpcDoc FOR = OU E FRecCliGar = TRUE E FOR UMA   *}
    {* NOTA FISCAL                                                      *}
    {*****************************************************************FC*}
    Else
    Begin
      strOpcDoc := TMovGag.fGetOpcDocFromMovGrc(FieldByName('AUTINC').AsString);
      FRecCliGar := SameText(strOpcDoc, 'OU');
    End;

    If (opcEdtFst = opcPergunta) And (Not fUsaRotinaWMS) And (tipLibPed <> libPedido) And
       (Not ((fCfgSis('MOVDAV') = '2') And (Pos(FieldByName('ESPDOC').AsString, 'OR_PD_') > 0) And (fCfgSis('PAFECF', varBoolean)))) Then
    Begin
      Self.strTipImp := '';
      if Not (blnSomenteServ) then
        fImprimeSeparacao(strOpcDoc, blnQtdOri, blnDocCan, blnVerCfg, False,
                          blnImpPed, opcTodos, FieldByName('CODEMP').AsString = VS_strCodEmp);
    End;

  End;

  If Self.blnImprimiuAmbien Then
    Self.strArqPDF := strNomeArquivo;

end;

function TReimpressao.fRetIPIRet(strClaIPI: String): String;
  Var
    intIndice: Integer;
Begin
  Result := '';
  Delete(strClaIpi, 1, 3);
  With fatVenda Do
  For intIndice := Low(arrIPIRet) To High(arrIPIRet) Do
    With arrIPIRet[intIndice] Do
      If SameText(strClaIPI, strIpiRet) Then
      Begin
        Result := ' B.SUBST.: ' + fPadL(FormatFloat('#0.00', fltBaIRet), 12) + ' VALOR: ' +
                                  fPadL(FormatFloat('#0.00', fltVaIRet), 6);
        Break;
      End;
End;

procedure TReimpressao.pCarregaMovRes(strAutInc, strTabela: String);
  Var
    qryMovRes: TUniQuery;
    strMovRes: String;
Begin
  FillChar(fatVenda.arrIpiRet, SizeOf(fatVenda.arrIpiRet), #0);

  strMovRes := fatVenda.fRetNomeMovRes(strTabela);

  If fEmptyStr(strMovRes) Then
    Exit;

  qryMovRes := fCriaQuery;
  With qryMovRes, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  RES_CLAFIS, ');
    Add('  RES_VALRET, ');
    Add('  RES_BASRET  ');
    Add('FROM');
    Add(strMovRes);
    Add('WHERE');
    Add('  RES_SEQGER = :AUTINC');

    ParamByName('AUTINC').AsString := strAutInc;

    Open;

    While Not Eof Do
    Begin
      fatVenda.pAcumulaIPIRet(FieldByName('RES_CLAFIS').AsString,
                              FieldByName('RES_BASRET').AsFloat,
                              FieldByName('RES_VALRET').AsFloat);
      Next;
    End;

    With  fatVenda Do
    Begin
      strClaIAA := IIF(Not fEmptyStr(strClaIpA), strClaIpA + fRetIPIRet(strClaIpA), '');
      strClaIAB := IIF(Not fEmptyStr(strClaIpB), strClaIpB + fRetIPIRet(strClaIpB), '');
      strClaIAC := IIF(Not fEmptyStr(strClaIpC), strClaIpC + fRetIPIRet(strClaIpC), '');
      strClaIAD := IIF(Not fEmptyStr(strClaIpD), strClaIpD + fRetIPIRet(strClaIpD), '');
      strClaIAE := IIF(Not fEmptyStr(strClaIpE), strClaIpE + fRetIPIRet(strClaIpE), '');
      strClaIAF := IIF(Not fEmptyStr(strClaIpF), strClaIpF + fRetIPIRet(strClaIpF), '');
      strClaIAG := IIF(Not fEmptyStr(strClaIpG), strClaIpG + fRetIPIRet(strClaIpG), '');
      strClaIAH := IIF(Not fEmptyStr(strClaIpH), strClaIpH + fRetIPIRet(strClaIpH), '');
      strClaIAJ := IIF(Not fEmptyStr(strClaIpJ), strClaIpJ + fRetIPIRet(strClaIpJ), '');
      strClaIAL := IIF(Not fEmptyStr(strClaIpL), strClaIpL + fRetIPIRet(strClaIpL), '');
      strClaIAM := IIF(Not fEmptyStr(strClaIpM), strClaIpM + fRetIPIRet(strClaIpM), '');
      strClaIAN := IIF(Not fEmptyStr(strClaIpN), strClaIpN + fRetIPIRet(strClaIpN), '');
    End;  

  End;
  FreeAndNil(qryMovRes);
End;

procedure TReimpressao.pCarregaAuxMov(strAutInc, strTabela: String);
  Var
    qryAuxMov: TUniQuery;
Begin
  fatVenda.fltValCre := 0;

  If Pos(strTabela, 'MOVGER_NOTGER_') > 0 Then
  Begin

    qryAuxMov := fCriaQuery;
    With qryAuxMov, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM ');
      Add(fRetNomTabAuxMov(strTabela));
      Add('WHERE');
      Add('  AUX_SEQGER =  :AUTINC');

      ParamByName('AUTINC').AsString := strAutInc;
     
      Open;

      If Not IsEmpty Then
      Begin
        fatVenda.fltValCre := - FieldByName('AUX_VALCRE').AsFloat;

        fatVenda.strCodArt := FieldByName('AUX_CODART').AsString;
        fatVenda.strCodObr := FieldByName('AUX_CODOBR').AsString;
        fatVenda.strCodCno := FieldByName('AUX_CODCNO').AsString;
        fatVenda.strInsImo := FieldByName('AUX_INSIMO').AsString;
        fatVenda.strCodCib := FieldByName('AUX_CODCIB').AsString;
        fatVenda.strCodPrj := FieldByName('AUX_CODPRJ').AsString;
        If Not fEmptyStr(fatVenda.strCodPrj) Then
          fatVenda.strNomPrj := fCampoTabela('PRJ_DESPRJ', 'CADPRJ', ['PRJ_CODPRJ'], [fatVenda.strCodPrj], False);
      End;

    End;

    FreeAndNil(qryAuxMov);
  End;
End;

procedure TReimpressao.pSetaDocumentoOriginalConcreto(cdsDestin: TUniClientDataSet; strCampoDocOri: String; blnReimpressao: Boolean);
  Var
    strDocOri: String;
    qryConcre : TUniQuery;
begin
  If Not (fCfgSis('USACCR', varBoolean) And (MatchStr(fCfgSis('TPNFCR'),[PRESTCON,SECOL]))) Then
    Exit;

  If Not Assigned(cdsDestin) Then
    Exit;

  If Not cdsDestin.Active Then
    Exit;

  If Not Assigned(cdsDestin.FindField(strCampoDocOri)) Then
    Exit;

  If (Not blnReimpressao) And (Not Assigned(cdsDestin.FindField('ITE_SEQCCR'))) Then
    Exit;

  qryConcre := fCriaQuery(Nil);
  Try
    With cdsDestin Do
    Begin
      First;
      While Not Eof Do
      Begin
        Application.ProcessMessages;

        If (blnReimpressao) Then
        Begin
          If Not fEmptyStr(FieldByName(strCampoDocOri).AsString) Then
          Begin
            Next;
            Continue;
          End;

          If (Not ('NF_NS_').Contains(cdsDestin.FieldByName('ESPDOC').AsString)) Then
          Begin
            Next;
            Continue;
          End;

          qryConcre.Close;
          qryConcre.SQL.Clear;
          qryConcre.SQL.Add(' SELECT CONCAT(DET_NUMDOC,"-",DET_ESPDOC,"-",IFNULL(DET_SERIE_,"")) AS DOCORI ');
          qryConcre.SQL.Add('   FROM MOVDET D ');
          qryConcre.SQL.Add('  INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
          qryConcre.SQL.Add('  WHERE D.DET_NUMFAT = :NUMFAT ');
          qryConcre.SQL.Add('    AND D.DET_TIPFAT = :TIPFAT ');
          qryConcre.SQL.Add('    AND D.DET_EMPFAT = :EMPFAT ');
          qryConcre.SQL.Add('  LIMIT 1 ');
          qryConcre.ParamByName('NUMFAT').AsString := cdsDestin.FieldByName('NUMDOC').AsString;
          qryConcre.ParamByName('TIPFAT').AsString := cdsDestin.FieldByName('ESPDOC').AsString;
          qryConcre.ParamByName('EMPFAT').AsString := cdsDestin.FieldByName('CODEMP').AsString;
          qryConcre.Open;
          strDocOri := qryConcre.FieldByName('DOCORI').AsString;
          qryConcre.Close;
        End
        Else
          strDocOri := fCampoTabela('CONCAT(DET_NUMDOC,"-",DET_ESPDOC,"-",IFNULL(DET_SERIE_,""))',
                            'MOVDET D INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM',
                            ['D.DET_NUMFAT','D.DET_TIPFAT','D.DET_EMPFAT','T.DET_SEQCCR'],
                            [FNumDoc, FEspDoc, FCodEmp, FieldByName('ITE_SEQCCR').AsInteger]);

        Edit;
        FieldByName(strCampoDocOri).AsString := strDocOri;
        Post;
        Next;
      End;
      First;
    End;
  Finally
    FreeAndNil(qryConcre);
  End;
end;

{************************************}
{* IMPRIME NOTA FISCAL              *}
{*********************************AF*}
procedure TReimpressao.pReimprimeComplementoFF(strNumDoc, strEspDoc, strEmpDoc,
  strCodCLi, strTipFc, strSaida: String; intQtdImp: Integer);
var
  strCodLay: String;
  objImpressao: TEditorFastImpressao;
begin
  objImpressao := TEditorFastImpressao.Create(Nil);

  try
    strCodLay := fCfgSis('CLACFF', varString);

    objImpressao.recDocume.strNumDoc := strNumDoc;
    objImpressao.recDocume.strEspDoc := strEspDoc;
    objImpressao.recDocume.strCodEmp := strEmpDoc;
    objImpressao.recDocume.strCodCli := strCodCLi;
    objImpressao.recDocume.strTipFc := strTipFc;
    objImpressao.recDocume.strSaida := strSaida;
    objImpressao.recDocume.intQtdImp := intQtdImp;
    objImpressao.recDocume.blnTemLay := True;
    objImpressao.recDocume.strCodLay := strCodLay;
    objImpressao.fImprimeDocumento(tpaNormal);
  finally
    FreeAndNil(objImpressao);
  end;
end;

procedure TReimpressao.pReimprimeCreditosFF(strNumDoc, strEspDoc, strEmpDoc,
  strCodCLi, strTipFc, strSaida: String; intQtdImp: Integer);
var
  strCodLay: String;
  objImpressao: TEditorFastImpressao;
begin
  objImpressao := TEditorFastImpressao.Create(Nil);

  try
    strCodLay := fCampoTabela('LAY_CODLAY','LAYETI',['LAY_TIPLAY', 'LAY_PADRAO', 'LAY_CODEMP'],[ARR_TIPO_LAYOUT[tpeFFDocumentosCR], 'S', VS_strCodEmp]);

    objImpressao.recDocume.strNumDoc   := strNumDoc;
    objImpressao.recDocume.strEspDoc   := strEspDoc;
    objImpressao.recDocume.strCodEmp   := strEmpDoc;
    objImpressao.recDocume.strCodCli   := strCodCLi;
    objImpressao.recDocume.strTipFc    := strTipFc;
    objImpressao.recDocume.strSaida    := strSaida;
    objImpressao.recDocume.intQtdImp   := intQtdImp;
    objImpressao.recDocume.blnTemLay   := True;
    objImpressao.recDocume.strCodLay   := strCodLay;
    objImpressao.recDocume.blnDocumentoCreditoFF := True;
    objImpressao.fImprimeDocumento(tpaNormal);
  finally
    FreeAndNil(objImpressao);
  end;
end;

procedure TReimpressao.pImprimeNota(strTabela:String);
  Var
    intContador  : Integer;
    intIndice    : Integer;
    intLinhaAtu  : Integer;
    intLinha     : Integer;
    intQtdNot    : Integer;
    intQtdImp    : Integer;
    intQtdIte    : Integer;
    intQtdDup    : Integer;
    strTipNot    : String;
    strNomeTabela: String;
    strSQL       : String;
    strNomImp    : String;
    blnAtualiza  : Boolean;
    cpuCampos    : TCamposUso;
    arrNumDup    : Array [0..11] Of String;
    arrDtaDup    : Array [0..11] Of String;
    arrValDup    : Array [0..11] Of Double;
    blnAssigned  : Boolean;
    oleDadosVenda: OleVariant;
    cdsDadosVenda: TUniClientDataSet;
    blnSintetizaParcel: Boolean;
    blnJaZerou   : Boolean;
    stlMen50p    : TStringList;

    qryGenEmp : TUniQuery;
    qryGenTra : TUniQuery;
    qryCnfNf  : TUniQuery;

    blnNotaServico: Boolean;
    intContIte: Integer;

    strTabelaTri: String;

    blnDecrementou: Boolean;

    arrDuplicata: TarrDuplicata;

    strFisNum: String;
    strFisEsp: String;
    strFisEmp: String;
    strFisInc: String;

    {*****************************************}
    {* VARIAVEIS DE IMPRESSORA DEFAULT       *}
    {**************************************AF*}
    Device: Array[0..255] Of Char;
    Driver: Array[0..255] Of Char;
    Port  : Array[0..255] Of Char;
    Handle: THandle;
    blnDocumentoFornecedor: Boolean;

    {*********************************************************}
    {* MODIFICA AS VARIVAIS DE DATA E HORA DA NOTA FISCAL    *}
    {* CONFORME INFORMADA PELO CLIENTE NO MOMENTO DA EMISSÃO *}
    {******************************************************PE*}
    procedure pDataHoraInformada;
      Var
        qryDtaHor : TUniQuery;
        strSQL : String;
    Begin
      Try
        qryDtaHor := fCriaQuery;

        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  MOV_DTESNF AS DTAINF, ';
        strSQL := strSQL + '  MOV_HRESNF AS HORINF  ';
        strSQL := strSQL + 'FROM                    ';
        strSQL := strSQL + '  MOVOBS                ';
        strSQL := strSQL + 'WHERE                   ';
        strSQL := strSQL + '  MOV_SEQGER = :SEQGER  ';

        With qryDtaHor Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('SEQGER').AsString := objDocumentos.cdsDocumentos.FieldByName('AUTINC').AsString;
          Open;

          If Not FieldByName('DTAINF').IsNull Then
            fatVenda.strDtaAtu := FieldByName('DTAINF').AsString;

          If  Not FieldByName('HORINF').IsNull Then
            fatVenda.strHorSai := FieldByName('HORINF').AsString;

          Close;
        End;

        FreeAndNil(qryDtaHor);

      Except
        On E: ExceptionAutCom Do
        Begin
          fMensagem('', E.Message, ['& O k']);
        End;
      End;
    End;

Begin
  pZeraDigDuplic(arrDuplicata);
  cdsDadosVenda := nil;
  oleDadosVenda := Null;
  cpuCampos     := nil;
  stlMen50p     := nil;
  qryCnfNf      := nil;

  intQtdNot := 0;

  strTabelaTri := '';
  If Pos('MOVDET', strTabela) > 0 Then
    strTabelaTri := AnsiReplaceStr(strTabela, 'MOVDET', 'MOVTRI')
  Else If Pos('NOTDET', strTabela) > 0 Then
    strTabelaTri := AnsiReplaceStr(strTabela, 'NOTDET', 'NOTTRI');

  blnNotaServico := (objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString = 'NS');

  strFisNum := objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString;
  strFisEsp := objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString;
  strFisEmp := objDocumentos.cdsDocumentos.FieldByName('CODEMP').AsString;
  strFisInc := objDocumentos.cdsDocumentos.FieldByName('AUTINC').AsString;

  qryGenEmp := fCriaQuery;
  qryGenTra := fCriaQuery;
  blnAssigned := True;

  // Antes do Try principal: exceção aqui não chega ao Finally dele, então as queries se liberam aqui.
  Try

    If Not blnNotaServico Then
      pCarregaConfImpr(qryCfgRel, 'frmFatVendas_NOTA')
    Else
      pCarregaConfImpr(qryCfgRel, 'frmFatVendas_NOTASERVICO');

    strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

    If qryCfgRel.FieldByName('REL_IMPPAD').AsString = 'S' Then
    Begin
      // Com a impressora padrão marcada a fila vem vazia; no spool Citel não há padrão do Windows
      // (depende do Spooler, erro 1722 com ele desligado): o ponto de impressão se pergunta.
      If TCfgRel.VS_SpoolImpressaoCitel Then
      Begin
        strNomImp := TCfgRel.fSelecionaFila('', '', True);
        If fEmptyStr(strNomImp) Then
        Begin
          FreeAndNil(qryGenEmp);
          FreeAndNil(qryGenTra);
          Exit;
        End;
      End
      Else
      Begin
        Printer.GetPrinter(Device, Driver, Port, Handle);
        strNomImp := Device;
      End;
    End;

    If Not fVerificaImpressora(strNomImp) Then
    Begin
      fMensagem('','Impressora de nota configurada incorretamente!',['&OK']);
      FreeAndNil(qryGenEmp);
      FreeAndNil(qryGenTra);
      Exit;
    End;

    pCarregaQueryEmpresa(qryGenEmp);
  Except
    FreeAndNil(qryGenEmp);
    FreeAndNil(qryGenTra);
    Raise;
  End;

  Try

    Try

      blnAssigned := True;
      If (Not Assigned(fatVenda)) Then
      Begin
        fatVenda := TFatVenda.CreateInstance(IIF(Not blnNotaServico,'NF','NS'));
        fatVenda.strOpcDoc := IIF(Not blnNotaServico,'VN','VS');
        blnAssigned := False;
      End;

      fatVenda.blnReimpressaoNotaFiscal := True;
      blnDocumentoFornecedor := (objDocumentos.cdsDocumentos.FieldByName('DOCFOR').AsString = 'S');                  

      {*******************************************}
      { RECARREGA OS CAMPOS Q NAO ESTAO PRESENTES }
      { NO BD PARA IMPRESSAO                      }
      {****************************************JB*}
      fatVenda.strDocsConf   := strDocsConf;
      fatVenda.strDocsConfIF := strDocsConfIF;
      fatVenda.strDocsConfTE := strDocsConfTE;


      If fEmptyStr(strCupCon) Then
        fatVenda.strCupCon := fRetCupCon(objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString,
                                         objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString,
                                         objDocumentos.cdsDocumentos.FieldByName('CODEMP').AsString)
      Else
        fatVenda.strCupCon := strCupCon;

      if fEmptyStr(strCupCha) then
        fatVenda.strCupCha := fRetCupCha(objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString,
                                         objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString,
                                         objDocumentos.cdsDocumentos.FieldByName('CODEMP').AsString)
      else
        fatVenda.strCupCha := strCupCha;

      If fEmptyStr(strCupConDev) Then
        fatVenda.strCupConDev := fRetCupCon(objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString,
                                            objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString,
                                            objDocumentos.cdsDocumentos.FieldByName('CODEMP').AsString)
      Else
        fatVenda.strCupConDev := strCupConDev;


      fatVenda.strCliNFV     := strCliNFV;
      fatVenda.strCGCNFV     := fFormataCpfCgc(strCGCNFV, FPais);
      fatVenda.strIE_NFV     := strIE_NFV;
      fatVenda.strNroNFV     := strNroNFV;
      fatVenda.strDtaNFV     := strDtaNFV;
      fatVenda.fltValNFV     := fltValNFV;
      fatVenda.strCodPor     := strCodPor;
      fatVenda.strNomPor     := fRetNomPortador(fatVenda.strCodPor);

      If Not blnAssigned Then
      Begin
        If (cdsVenda <> nil) Then
        Begin
          oleDadosVenda := cdsVenda.Data;
          cdsDadosVenda := cdsVenda;
        End;

        pCriarCdsVenda(Nil);

        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '  ABFICM.*, ';
        strSQL := strSQL + '  DET_TOTPES AS TOTPES, ';
        strSQL := strSQL + '  DET_IDEPRO AS IDEPRO, ';
        strSQL := strSQL + '  I.ITE_CODGRU AS CODGRU, ';
        strSQL := strSQL + '  DET_CODITE AS CODITE, ';
        strSQL := strSQL + '  P.CLI_COD_NF AS COD_NF, ';
        strSQL := strSQL + '  P.CLI_DES_NF AS DES_NF, ';
        strSQL := strSQL + '  G.ITE_LOCFIS AS LOCFIS, ';
        strSQL := strSQL + '  CONCAT(IF(DET_IDEPRO <> "NOR", CONCAT(DET_IDEPRO, " - "), ""), DET_DESCRI) AS DESITE, ';
        strSQL := strSQL + '  I.ITE_DESFAB AS DESFAB, ';
        strSQL := strSQL + '  DET_REFERE AS REFERE, ';
        strSQL := strSQL + '  DET_UNIDAD AS UNIDAD, ';
        strSQL := strSQL + '  DET_CODMAR AS CODMAR, ';
        strSQL := strSQL + '  DET_FORITE AS CODFOR, ';
        strSQL := strSQL + '  DET_VAL_RT AS VAL_RT, ';
        strSQL := strSQL + '  DET_UNIORI AS UNIORI, ';
        strSQL := strSQL + '  DET_UNIVIS AS UNIVIS, ';
        strSQL := strSQL + '  DET_TAXJUR AS TAXJUR, ';
        strSQL := strSQL + '  DET_UNITAR AS UNITAR, ';
        strSQL := strSQL + '  DET_DESCON AS DESCON, ';
        strSQL := strSQL + '  DET_QTDITE AS QTDITE, ';
        strSQL := strSQL + '  DET_TOTITE AS TOTITE, ';
        strSQL := strSQL + '  DET_DESESP AS DESESP, ';
        strSQL := strSQL + '  DET_TOTCUS AS TOTCUS, ';
        strSQL := strSQL + '  DET_TOTMED AS TOTMED, ';
        strSQL := strSQL + '  DET_CLAFIS AS CLAFIS, ';
        strSQL := strSQL + '  DET_PERRED AS PERRED, ';
        strSQL := strSQL + '  DET_PERBAS AS PERBAS, ';
        strSQL := strSQL + '  DET_INCPIS AS INCPIS, ';
        strSQL := strSQL + '  DET_DESACE AS DESACE, ';
        strSQL := strSQL + '  DET_TOTFRE AS TOTFRE, ';
        strSQL := strSQL + '  DET_TIPEMB AS TIPEMB, ';
        strSQL := strSQL + '  DET_PREEMB AS PREEMB, ';
        strSQL := strSQL + '  DET_PRVTIN AS PRVTIN, ';
        strSQL := strSQL + '  DET_PRCTIN AS PRCTIN, ';
        strSQL := strSQL + '  DET_QTDEMB AS QTDEMB, ';
        strSQL := strSQL + '  DET_ITECHA AS ITECHA, ';
        strSQL := strSQL + '  DET_ITETIN AS ITETIN, ';
        strSQL := strSQL + '  DET_FATTIN AS FATTIN, ';
        strSQL := strSQL + '  DET_PROEMB AS PROEMB, ';
        strSQL := strSQL + '  DET_DESCOR AS DESCOR, ';
        strSQL := strSQL + '  DET_TIPPRE AS TIPPRE, ';
        strSQL := strSQL + '  DET_LAZQUA AS LAZQUA, ';
        strSQL := strSQL + '  DET_VALRET AS VALRET, ';
        strSQL := strSQL + '  DET_ALQRET AS ALQRET, ';
        strSQL := strSQL + '  DET_BASRET AS BASRET, ';
        strSQL := strSQL + '  DET_BASICM AS BASICM, ';
        strSQL := strSQL + '  DET_ALQICM AS ALQICM, ';
        strSQL := strSQL + '  DET_VALIPI AS VALIPI, ';
        strSQL := strSQL + '  DET_BASIPI AS BASIPI, ';
        strSQL := strSQL + '  DET_ALQIPI AS ALQIPI, ';
        strSQL := strSQL + '  DET_VALICM AS VALICM, ';
        strSQL := strSQL + '  DET_CODFIS AS CODFIS, ';
        strSQL := strSQL + '  DET_ESTADO AS ESTADO, ';

        If Not fEmptyStr(strTabelaTri) Then
        Begin
          strSQL := strSQL + '  IFNULL(TRI.DET_BARTSP,0) AS BARTSP, ';
          strSQL := strSQL + '  IFNULL(TRI.DET_VLRTSP,0) AS VLRTSP, ';
          strSQL := strSQL + '  IFNULL(TRI.DET_ICOPPR,0) AS ICOPPR, ';
          strSQL := strSQL + '  IFNULL(TRI.DET_ICOPPR,0) AS ICOPPR, ';
          strSQL := strSQL + '  DET_SEQCCR               AS SEQCCR, '
        End
        Else
        Begin
          strSQL := strSQL + '  0.0000 AS BARTSP, ';
          strSQL := strSQL + '  0.0000 AS VLRTSP, ';
          strSQL := strSQL + '  0.0000 AS ICOPPR, ';
          strSQL := strSQL + '  0      AS SEQCCR, '          
        End;

        If (Pos('MOVDET', strTabela) > 0) Then
          strSQL := strSQL + '  DET_DESNES AS DESNES, '
        Else
          strSQL := strSQL + '  "" AS DESNES, ';

        strSQL := strSQL + '  DET_NUMLOT AS NUMLOT ';

        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  ' + strTabela;
        strSQL := strSQL + '  JOIN CADITE I ON I.ITE_CODITE = DET_CODITE ';

        If Not fEmptyStr(strTabelaTri) Then
        Begin
          strSQL := strSQL + 'LEFT JOIN ' + strTabelaTri + ' TRI ON ';
          strSQL := strSQL + '  TRI.DET_SEQGER = ' + strTabela + '.AUTOINCREM ';
        End;

        strSQL := strSQL + 'INNER JOIN ITEGER G ON ';
        strSQL := strSQL + '  G.ITE_CODITE = DET_CODITE AND ';
        strSQL := strSQL + '  G.ITE_CODEMP = DET_CODEMP     ';

        strSQL := strSQL + 'LEFT JOIN CLIPRO P ON ';
        strSQL := strSQL + '  P.CLI_CODITE = DET_CODITE AND ';
        strSQL := strSQL + '  P.CLI_CODCLI = DET_CODCLI AND ';
        strSQL := strSQL + '  P.CLI_CODEMP = DET_CODEMP     ';

        If fCfgSIs('TIPABF') = '1' Then
          strSQL := strSQL + ' JOIN ABFICM ON I.ITE_CODABF = ABF_CODABF '
        Else
          strSQL := strSQL + ' JOIN ABFICM ON G.ITE_CODABF = ABF_CODABF ';

        strSQL := strSQL + 'WHERE ';

        strSQL := strSQL + '  DET_PROEMB <> "S"       AND ';
        strSQL := strSQL + '  ABF_ESTADO = :ESTADO    AND ';
        strSQL := strSQL + '  ' + strTabela + '.DET_SEQGER = :AUTINC ';

        If (fCfgSis('USASER', varBoolean)) Then
        Begin
          strSQL := strSQL + '  AND DET_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' ';
          strSQL := strSQL + '  AND DET_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + ' ';
        End;

        strSQL := strSQL + '  ORDER BY ';
        strSQL := strSQL + ' ' + strTabela + '.AUTOINCREM ';

        fatVenda.fltTotQtd := 0;

        With FAux001 Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
          ParamByName('AUTINC').AsString := objDocumentos.cdsDocumentos.FieldByName('AUTINC').AsString;
          Open;

          While Not Eof Do
          Begin
            Application.ProcessMessages;

            pInsereDadosTemp(objDocumentos.cdsDocumentos.FieldByName('CODEMP').AsString);

            fatVenda.fltTotQtd := fatVenda.fltTotQtd + FieldByName('QTDITE').AsFloat;

            Next;
          End;

          Close;
        End;

        cdsVenda.IndexFieldNames := 'AUTOINCREM';
      End;

      //Prestcon
      pSetaDocumentoOriginalConcreto(cdsVenda, 'ITE_DOCORI', False);

      If (Pos(strTabela, 'NOTDET_') > 0) Then
        fatVenda.strConfDocs := 'S';

      fatVenda.intTemSub   := IIF(fVerificaSituacaoTributaria(fatVenda), 1, 0);

      fatVenda.intInflam   := IIF(fVerificaItemInflamavel(fatVenda), 1, 0);

      fatVenda.strNumOrc   := fRetDocsOrigFat(objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString,
                                              objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString,
                                              objDocumentos.cdsDocumentos.FieldByName('CODEMP').AsString);

      If fEmptyStr(fatVenda.strNumOrc) Then
        fatVenda.strNumOrc := fRetNumOrc(objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString,
                                         objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString,
                                         objDocumentos.cdsDocumentos.FieldByName('CODEMP').AsString);

//      fatVenda.strNumOrc   := LeftStr(objDocumentos.cdsDocumentos.FieldByName('DOCORI').AsString, Length(objDocumentos.cdsDocumentos.FieldByName('DOCORI').AsString) - 3); // DOCUMENTO ORIGEM

      fatVenda.strNumTEs := fRetTEsConfirmadas(objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString,
                                               objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString,
                                               objDocumentos.cdsDocumentos.FieldByName('CODEMP').AsString);

      fatVenda.strNroCEI   := objDocumentos.cdsDocumentos.FieldByName('NROCEI').AsString;  // CEI - Serviço

      fatVenda.strCodS01   := objDocumentos.cdsDocumentos.FieldByName('CODS01').AsString;  // Codigo Servico 1
      fatVenda.strCodS02   := objDocumentos.cdsDocumentos.FieldByName('CODS02').AsString;  // Codigo Servico 2
      fatVenda.strCodS03   := objDocumentos.cdsDocumentos.FieldByName('CODS03').AsString;  // Codigo Servico 3
      fatVenda.strCodS04   := objDocumentos.cdsDocumentos.FieldByName('CODS04').AsString;  // Codigo Servico 4
      fatVenda.strCodS05   := objDocumentos.cdsDocumentos.FieldByName('CODS05').AsString;  // Codigo Servico 5
      fatVenda.strCodS06   := objDocumentos.cdsDocumentos.FieldByName('CODS06').AsString;  // Codigo Servico 6
      fatVenda.strCodS07   := objDocumentos.cdsDocumentos.FieldByName('CODS07').AsString;  // Codigo Servico 7
      fatVenda.strCodS08   := objDocumentos.cdsDocumentos.FieldByName('CODS08').AsString;  // Codigo Servico 8
      fatVenda.strCodS09   := objDocumentos.cdsDocumentos.FieldByName('CODS09').AsString;  // Codigo Servico 9
      fatVenda.strCodS10   := objDocumentos.cdsDocumentos.FieldByName('CODS10').AsString;  // Codigo Servico 10
      fatVenda.strCodS11   := objDocumentos.cdsDocumentos.FieldByName('CODS11').AsString;  // Codigo Servico 11
      fatVenda.strCodS12   := objDocumentos.cdsDocumentos.FieldByName('CODS12').AsString;  // Codigo Servico 12
      fatVenda.strCodS13   := objDocumentos.cdsDocumentos.FieldByName('CODS13').AsString;  // Codigo Servico 13
      fatVenda.strCodS14   := objDocumentos.cdsDocumentos.FieldByName('CODS14').AsString;  // Codigo Servico 14
      fatVenda.strCodS15   := objDocumentos.cdsDocumentos.FieldByName('CODS15').AsString;  // Codigo Servico 15
      fatVenda.strCodS16   := objDocumentos.cdsDocumentos.FieldByName('CODS16').AsString;  // Codigo Servico 16
      fatVenda.strCodS17   := objDocumentos.cdsDocumentos.FieldByName('CODS17').AsString;  // Codigo Servico 17
      fatVenda.strCodS18   := objDocumentos.cdsDocumentos.FieldByName('CODS18').AsString;  // Codigo Servico 18
      fatVenda.strCodS19   := objDocumentos.cdsDocumentos.FieldByName('CODS19').AsString;  // Codigo Servico 19
      fatVenda.strCodS20   := objDocumentos.cdsDocumentos.FieldByName('CODS20').AsString;  // Codigo Servico 20
      fatVenda.strCodS21   := objDocumentos.cdsDocumentos.FieldByName('CODS21').AsString;  // Codigo Servico 21
      fatVenda.strCodS22   := objDocumentos.cdsDocumentos.FieldByName('CODS22').AsString;  // Codigo Servico 22
      fatVenda.strCodS23   := objDocumentos.cdsDocumentos.FieldByName('CODS23').AsString;  // Codigo Servico 23
      fatVenda.strCodS24   := objDocumentos.cdsDocumentos.FieldByName('CODS24').AsString;  // Codigo Servico 24
      fatVenda.strCodS25   := objDocumentos.cdsDocumentos.FieldByName('CODS25').AsString;  // Codigo Servico 25
      fatVenda.strCodS26   := objDocumentos.cdsDocumentos.FieldByName('CODS26').AsString;  // Codigo Servico 26
      fatVenda.strCodS27   := objDocumentos.cdsDocumentos.FieldByName('CODS27').AsString;  // Codigo Servico 27
      fatVenda.strCodS28   := objDocumentos.cdsDocumentos.FieldByName('CODS28').AsString;  // Codigo Servico 28
      fatVenda.strCodS29   := objDocumentos.cdsDocumentos.FieldByName('CODS29').AsString;  // Codigo Servico 29
      fatVenda.strCodS30   := objDocumentos.cdsDocumentos.FieldByName('CODS30').AsString;  // Codigo Servico 30

      fatVenda.strDesS01   := objDocumentos.cdsDocumentos.FieldByName('DESS01').AsString;  // Descricao Servico 1
      fatVenda.strDesS02   := objDocumentos.cdsDocumentos.FieldByName('DESS02').AsString;  // Descricao Servico 2
      fatVenda.strDesS03   := objDocumentos.cdsDocumentos.FieldByName('DESS03').AsString;  // Descricao Servico 3
      fatVenda.strDesS04   := objDocumentos.cdsDocumentos.FieldByName('DESS04').AsString;  // Descricao Servico 4
      fatVenda.strDesS05   := objDocumentos.cdsDocumentos.FieldByName('DESS05').AsString;  // Descricao Servico 5
      fatVenda.strDesS06   := objDocumentos.cdsDocumentos.FieldByName('DESS06').AsString;  // Descricao Servico 6
      fatVenda.strDesS07   := objDocumentos.cdsDocumentos.FieldByName('DESS07').AsString;  // Descricao Servico 7
      fatVenda.strDesS08   := objDocumentos.cdsDocumentos.FieldByName('DESS08').AsString;  // Descricao Servico 8
      fatVenda.strDesS09   := objDocumentos.cdsDocumentos.FieldByName('DESS09').AsString;  // Descricao Servico 9
      fatVenda.strDesS10   := objDocumentos.cdsDocumentos.FieldByName('DESS10').AsString;  // Descricao Servico 10
      fatVenda.strDesS11   := objDocumentos.cdsDocumentos.FieldByName('DESS11').AsString;  // Descricao Servico 11
      fatVenda.strDesS12   := objDocumentos.cdsDocumentos.FieldByName('DESS12').AsString;  // Descricao Servico 12
      fatVenda.strDesS13   := objDocumentos.cdsDocumentos.FieldByName('DESS13').AsString;  // Descricao Servico 13
      fatVenda.strDesS14   := objDocumentos.cdsDocumentos.FieldByName('DESS14').AsString;  // Descricao Servico 14
      fatVenda.strDesS15   := objDocumentos.cdsDocumentos.FieldByName('DESS15').AsString;  // Descricao Servico 15
      fatVenda.strDesS16   := objDocumentos.cdsDocumentos.FieldByName('DESS16').AsString;  // Descricao Servico 16
      fatVenda.strDesS17   := objDocumentos.cdsDocumentos.FieldByName('DESS17').AsString;  // Descricao Servico 17
      fatVenda.strDesS18   := objDocumentos.cdsDocumentos.FieldByName('DESS18').AsString;  // Descricao Servico 18
      fatVenda.strDesS19   := objDocumentos.cdsDocumentos.FieldByName('DESS19').AsString;  // Descricao Servico 19
      fatVenda.strDesS20   := objDocumentos.cdsDocumentos.FieldByName('DESS20').AsString;  // Descricao Servico 20
      fatVenda.strDesS21   := objDocumentos.cdsDocumentos.FieldByName('DESS21').AsString;  // Descricao Servico 21
      fatVenda.strDesS22   := objDocumentos.cdsDocumentos.FieldByName('DESS22').AsString;  // Descricao Servico 22
      fatVenda.strDesS23   := objDocumentos.cdsDocumentos.FieldByName('DESS23').AsString;  // Descricao Servico 23
      fatVenda.strDesS24   := objDocumentos.cdsDocumentos.FieldByName('DESS24').AsString;  // Descricao Servico 24
      fatVenda.strDesS25   := objDocumentos.cdsDocumentos.FieldByName('DESS25').AsString;  // Descricao Servico 25
      fatVenda.strDesS26   := objDocumentos.cdsDocumentos.FieldByName('DESS26').AsString;  // Descricao Servico 26
      fatVenda.strDesS27   := objDocumentos.cdsDocumentos.FieldByName('DESS27').AsString;  // Descricao Servico 27
      fatVenda.strDesS28   := objDocumentos.cdsDocumentos.FieldByName('DESS28').AsString;  // Descricao Servico 28
      fatVenda.strDesS29   := objDocumentos.cdsDocumentos.FieldByName('DESS29').AsString;  // Descricao Servico 29
      fatVenda.strDesS30   := objDocumentos.cdsDocumentos.FieldByName('DESS30').AsString;  // Descricao Servico 30

      fatVenda.fltValS01   := objDocumentos.cdsDocumentos.FieldByName('VALS01').AsFloat;   // Valor Servico 1
      fatVenda.fltValS02   := objDocumentos.cdsDocumentos.FieldByName('VALS02').AsFloat;   // Valor Servico 2
      fatVenda.fltValS03   := objDocumentos.cdsDocumentos.FieldByName('VALS03').AsFloat;   // Valor Servico 3
      fatVenda.fltValS04   := objDocumentos.cdsDocumentos.FieldByName('VALS04').AsFloat;   // Valor Servico 4
      fatVenda.fltValS05   := objDocumentos.cdsDocumentos.FieldByName('VALS05').AsFloat;   // Valor Servico 5
      fatVenda.fltValS06   := objDocumentos.cdsDocumentos.FieldByName('VALS06').AsFloat;   // Valor Servico 6
      fatVenda.fltValS07   := objDocumentos.cdsDocumentos.FieldByName('VALS07').AsFloat;   // Valor Servico 7
      fatVenda.fltValS08   := objDocumentos.cdsDocumentos.FieldByName('VALS08').AsFloat;   // Valor Servico 8
      fatVenda.fltValS09   := objDocumentos.cdsDocumentos.FieldByName('VALS09').AsFloat;   // Valor Servico 9
      fatVenda.fltValS10   := objDocumentos.cdsDocumentos.FieldByName('VALS10').AsFloat;   // Valor Servico 10
      fatVenda.fltValS11   := objDocumentos.cdsDocumentos.FieldByName('VALS11').AsFloat;   // Valor Servico 11
      fatVenda.fltValS12   := objDocumentos.cdsDocumentos.FieldByName('VALS12').AsFloat;   // Valor Servico 12
      fatVenda.fltValS13   := objDocumentos.cdsDocumentos.FieldByName('VALS13').AsFloat;   // Valor Servico 13
      fatVenda.fltValS14   := objDocumentos.cdsDocumentos.FieldByName('VALS14').AsFloat;   // Valor Servico 14
      fatVenda.fltValS15   := objDocumentos.cdsDocumentos.FieldByName('VALS15').AsFloat;   // Valor Servico 15
      fatVenda.fltValS16   := objDocumentos.cdsDocumentos.FieldByName('VALS16').AsFloat;   // Valor Servico 16
      fatVenda.fltValS17   := objDocumentos.cdsDocumentos.FieldByName('VALS17').AsFloat;   // Valor Servico 17
      fatVenda.fltValS18   := objDocumentos.cdsDocumentos.FieldByName('VALS18').AsFloat;   // Valor Servico 18
      fatVenda.fltValS19   := objDocumentos.cdsDocumentos.FieldByName('VALS19').AsFloat;   // Valor Servico 19
      fatVenda.fltValS20   := objDocumentos.cdsDocumentos.FieldByName('VALS20').AsFloat;   // Valor Servico 20
      fatVenda.fltValS21   := objDocumentos.cdsDocumentos.FieldByName('VALS21').AsFloat;   // Valor Servico 21
      fatVenda.fltValS22   := objDocumentos.cdsDocumentos.FieldByName('VALS22').AsFloat;   // Valor Servico 22
      fatVenda.fltValS23   := objDocumentos.cdsDocumentos.FieldByName('VALS23').AsFloat;   // Valor Servico 23
      fatVenda.fltValS24   := objDocumentos.cdsDocumentos.FieldByName('VALS24').AsFloat;   // Valor Servico 24
      fatVenda.fltValS25   := objDocumentos.cdsDocumentos.FieldByName('VALS25').AsFloat;   // Valor Servico 25
      fatVenda.fltValS26   := objDocumentos.cdsDocumentos.FieldByName('VALS26').AsFloat;   // Valor Servico 26
      fatVenda.fltValS27   := objDocumentos.cdsDocumentos.FieldByName('VALS27').AsFloat;   // Valor Servico 27
      fatVenda.fltValS28   := objDocumentos.cdsDocumentos.FieldByName('VALS28').AsFloat;   // Valor Servico 28
      fatVenda.fltValS29   := objDocumentos.cdsDocumentos.FieldByName('VALS29').AsFloat;   // Valor Servico 29
      fatVenda.fltValS30   := objDocumentos.cdsDocumentos.FieldByName('VALS30').AsFloat;   // Valor Servico 30

      fatVenda.intPraEnt   := objDocumentos.cdsDocumentos.FieldByName('PRAENT').AsInteger; // Prazo Entrega
      fatVenda.fltTotSer   := objDocumentos.cdsDocumentos.FieldByName('TOTSER').AsFloat;   // Total Servico
      fatVenda.fltValIss   := objDocumentos.cdsDocumentos.FieldByName('VALISS').AsFloat;   // Valor ISS
      fatVenda.fltPerIss   := objDocumentos.cdsDocumentos.FieldByName('PERISS').AsFloat;   // Percentual ISS
      fatVenda.fltDesAce   := objDocumentos.cdsDocumentos.FieldByName('DESACE').AsFloat;   // Despesa acessória

      fatVenda.strTipFat   := 'Nota Fiscal';
      fatVenda.strCndFor   := fFormataCondPag(objDocumentos.cdsDocumentos.FieldByName('CONPAG').AsString); // Condição de pagamento formatada
      fatVenda.strCodCli   := objDocumentos.cdsDocumentos.FieldByName('CODCLI').AsString;                  // Cliente - Codigo
      fatVenda.strCliNom   := objDocumentos.cdsDocumentos.FieldByName('CLINOM').AsString;                  //         - Nome
      fatVenda.strCliOri   := objDocumentos.cdsDocumentos.FieldByName('CLIORI').AsString;                  //         - Nome Original
      fatVenda.strCliEnd   := objDocumentos.cdsDocumentos.FieldByName('ENDERE').AsString;                  //         - Endereco
      fatVenda.strCliNum   := objDocumentos.cdsDocumentos.FieldByName('ENDNUM').AsString;                  //         - Número do Endereço
      fatVenda.strCliCom   := objDocumentos.cdsDocumentos.FieldByName('ENDCOM').AsString;                  //         - Complemento do Endereço

      fatVenda.strCodReg   := objDocumentos.cdsDocumentos.FieldByName('CODREG').AsString;
      fatVenda.strDesReg   := fRetDesRegiao(objDocumentos.cdsDocumentos.FieldByName('CODREG').AsString);

      {*****************************************}
      {* CASO O CAMPO NUMERO ESTEJA PREENCHIDO *}
      {* CONCATENA NO FINAL DO ENDERECO        *}
      {**************************************JB*}
      fatVenda.strCliEnd   := IIF(fEmptyStr(fatVenda.strCliNum), fatVenda.strCliEnd, Concat(fatVenda.strCliEnd, ', ', fatVenda.strCliNum, '  ', fatVenda.strCliCom));

      fatVenda.strCliBai   := objDocumentos.cdsDocumentos.FieldByName('BAIRRO').AsString;                  //         - Bairro
      fatVenda.strCliCep   := objDocumentos.cdsDocumentos.FieldByName('C_E_P_').AsString;                  //         - Cep
      fatVenda.strCodCid   := objDocumentos.cdsDocumentos.FieldByName('CODCID').AsString;                  //         - Cód. Cidade
      fatVenda.strCliCid   := fRetNomCidade(objDocumentos.cdsDocumentos.FieldByName('CODCID').AsString,0); //         - Cidade
      fatVenda.strCliEst   := fRetNomCidade(objDocumentos.cdsDocumentos.FieldByName('CODCID').AsString,1); //         - Estado
      fatVenda.strCliAti   := objDocumentos.cdsDocumentos.FieldByName('CODATI').AsString;                  // Atividade
      fatVenda.strDiferi   := objDocumentos.cdsDocumentos.FieldByName('DIFERI').AsString;
      fatVenda.strDif_ST   := objDocumentos.cdsDocumentos.FieldByName('DIF_ST').AsString;
      fatVenda.strSitP_C   := objDocumentos.cdsDocumentos.FieldByName('SITP_C').AsString;
      fatVenda.strMenP_C   := objDocumentos.cdsDocumentos.FieldByName('MENP_C').AsString;
      fatVenda.strCobIss   := objDocumentos.cdsDocumentos.FieldByName('COBISS').AsString;
      fatVenda.strCodObr   := objDocumentos.cdsDocumentos.FieldByName('CODOBR').AsString;
      fatVenda.strCodArt   := objDocumentos.cdsDocumentos.FieldByName('CODART').AsString;
      fatVenda.blnConstr   := (fAtividadeConstrutora(objDocumentos.cdsDocumentos.FieldByName('CODATI').AsString)); // Cliente Construtora?
      fatVenda.strCliTel   := objDocumentos.cdsDocumentos.FieldByName('FONE01').AsString;                  //         - Telefone
      fatVenda.strCli_Rg   := objDocumentos.cdsDocumentos.FieldByName('NUM_RG').AsString;                  //         - RG
      fatVenda.strCliCgc   := fTiraCaracEspeciais(objDocumentos.cdsDocumentos.FieldByName('C_G_C_').AsString);//      - CNPJ
      fatVenda.strCliCgc   := AnsiReplaceStr(fatVenda.strCliCgc, '.', '');

      fatVenda.fltRedIcmsCli := objDocumentos.cdsDocumentos.FieldByName('REDICM').AsFloat;

      fatVenda.pProcessarDespesasOperacionaisComplementar(objDocumentos.cdsDocumentos.FieldByName('DESOPE').AsFloat);

      fatVenda.intCgcCpf   := objDocumentos.cdsDocumentos.FieldByName('CGCCPF').AsInteger;                 //         - CGC/CPF
      fatVenda.strCliIes   := objDocumentos.cdsDocumentos.FieldByName('I_E_S_').AsString;                  //         - Ins.Estadual
      fatVenda.strCliImp   := objDocumentos.cdsDocumentos.FieldByName('I_M_P_').AsString;                  //         - Insc. Municipal Produtor
      fatVenda.strProRur   := objDocumentos.cdsDocumentos.FieldByName('PRORUR').AsString;                  //         - Produtor Rural
      fatVenda.strMicEmp   := objDocumentos.cdsDocumentos.FieldByName('MICEMP').AsString;                  //         - MEI-Micro Empreendedor Individual
      fatVenda.strCliOrg   := objDocumentos.cdsDocumentos.FieldByName('ORGPUB').AsString;                  //         - Orgao Publico
      fatVenda.strDesPIs   := objDocumentos.cdsDocumentos.FieldByName('DESPIS').AsString;                  //         - Orgao Publico
      fatVenda.strOrPuRD   := objDocumentos.cdsDocumentos.FieldbyName('ORPURD').AsString;              //         - Tipo de Desconto (Rateio / Desconto)
      fatVenda.strCalIcm   := objDocumentos.cdsDocumentos.FieldbyName('CALICM').AsString;              //         - Calcula Desconto de ICMS (Orgão Public)
      fatVenda.strZonFra   := objDocumentos.cdsDocumentos.FieldByName('ZONFRA').AsString;                  //         - Zona Francade Manaus
      fatVenda.strDesZon   := objDocumentos.cdsDocumentos.FieldByName('DESZON').AsString;                  //         - Cliente Zona Franca com desconto especial
      fatVenda.strCodZfm   := objDocumentos.cdsDocumentos.FieldByName('CODZFM').AsString;                  //         - Zona Francade Manaus
      fatVenda.blnCliExportacaoIndireta := objDocumentos.cdsDocumentos.FieldByName('EXPIND').AsString = 'S';//        - Cliente Exportação Indireta
      fatVenda.strCliCon   := objDocumentos.cdsDocumentos.FieldByName('CONSUM').AsString;                  //         - Consumidor Final (S/N)
      fatVenda.blnCliFil   := fClienteFilial(objDocumentos.cdsDocumentos.FieldByName('CODCLI').AsString);  //         - Cliente Filial
      fatVenda.strTabPre   := objDocumentos.cdsDocumentos.FieldByName('TABPRE').AsString;                  //         - Tabela de Preco
      fatVenda.strCodVen   := objDocumentos.cdsDocumentos.FieldByName('CODVEN').AsString;                  // Vendedor      - Codigo

      If fEmptyStr(fatVenda.strTabPre) And fCfgSis('HIETAB', VarBoolean) Then
        fatVenda.strTabPre := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [fatVenda.strCodVen], False);

      fatVenda.strNomVen   := fRetNomVendRep(objDocumentos.cdsDocumentos.FieldByName('CODVEN').AsString);  // Vendedor      - Nome
      fatVenda.strCodDig   := objDocumentos.cdsDocumentos.FieldByName('CODDIG').AsString;                  // Digitador     - Codigo
      fatVenda.strNomDig   := fRetNomVendRep(objDocumentos.cdsDocumentos.FieldByName('CODDIG').AsString);  // Digitador     - Nome
      fatVenda.strCodRep   := objDocumentos.cdsDocumentos.FieldByName('CODREP').AsString;                  // Representante - Codigo
      fatVenda.strCodCnd   := objDocumentos.cdsDocumentos.FieldByName('CODCND').AsString;                  // Condicao      - Codigo
      fatVenda.strDesCnd   := fRetDesConPag(objDocumentos.cdsDocumentos.FieldByName('CODCND').AsString);   // Condicao      - Descricao
      fatVenda.strCodFpg   := objDocumentos.cdsDocumentos.FieldByName('CODFPG').AsString;                  // Código da Forma de Pagamento
      fatVenda.strDesFpg   := fRetDesFpg(objDocumentos.cdsDocumentos.FieldByName('CODFPG').AsString);      // Descrição da Forma de Pagamento

      If (objDocumentos.cdsDocumentos.FieldByName('TABELA').AsString = 'MOVGER') Then
        fatVenda.strCodDiv := fRetCodDiv('MOVDET',objDocumentos.cdsDocumentos.FieldByName('AUTINC').AsString)  // Codigo Profissional (CADDIV)

      Else If (objDocumentos.cdsDocumentos.FieldByName('TABELA').AsString = 'NOTGER') Then
        fatVenda.strCodDiv := fRetCodDiv('NOTDET',objDocumentos.cdsDocumentos.FieldByName('AUTINC').AsString)  // Codigo Profissional (CADDIV)

      Else If (objDocumentos.cdsDocumentos.FieldByName('TABELA').AsString = 'FATGOR') Then
        fatVenda.strCodDiv := fRetCodDiv('FATDOR',objDocumentos.cdsDocumentos.FieldByName('AUTINC').AsString); // Codigo Profissional (CADDIV)

      fatVenda.fltTotGer   := objDocumentos.cdsDocumentos.FieldByName('VLRCON').AsFloat;  // Total Geral
      fatVenda.fltTotPro   := objDocumentos.cdsDocumentos.FieldByName('TOTPRO').AsFloat;  // Total dos Produtos
      fatVenda.fltTotCus   := objDocumentos.cdsDocumentos.FieldByName('TOTCUS').AsFloat;  // Total do Custo
      fatVenda.fltDesEsp   := objDocumentos.cdsDocumentos.FieldByName('DESESP').AsFloat;  // Desconto Especial

      fatVenda.fltIPerDs   := objDocumentos.cdsDocumentos.FieldByName('PORDES').AsFloat;  // % Desconto para impressão em CNF_NF

      {*******************************************}
      {* ESSA VARIAVEL TEM QUE SER 0 POIS SE     *}
      {* TIVER VALOR ELA RATEIA DENOVO O ARQUIVO *}
      {****************************************JB*}
      fatVenda.fltPorDes   := 0; // % de Desconto Geral

      With qryGenTra Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT SQL_NO_CACHE * FROM CADTRA WHERE TRA_CODTRA = :CODTRA');
        ParamByName('CODTRA').AsString := objDocumentos.cdsDocumentos.FieldByName('CODTRA').AsString;
       
        Open;

        fatVenda.strCodTra   := objDocumentos.cdsDocumentos.FieldByName('CODTRA').AsString; // Cod. do Transp.
        fatVenda.strNomTra   := FieldByName('TRA_NOMTRA').AsString;                    // Nome do Transp.
        fatVenda.strNumPla   := FieldByName('TRA_NUMPLA').AsString;                    // Placa do Transp.
        fatVenda.strCgcTra   := FieldByName('TRA_C_G_C_').AsString;                    // CNPJ do Transp.
        fatVenda.strEndTra   := FieldByName('TRA_ENDERE').AsString;                    // Endereço do Transp.
        fatVenda.strCidTra   := fRetNomCidade(FieldByName('TRA_CODCID').AsString);     // Cidade do Transp.
        //fatVenda.strEstTra   := fRetNomCidade(FieldByName('TRA_NUMPLA').AsString,1);   // Estado do Transp.
        fatVenda.strEstTra   := fRetNomCidade(FieldByName('TRA_CODCID').AsString,1);   // Estado do Transp.
        fatVenda.strIesTra   := FieldByName('TRA_I_E_S_').AsString;                    // IES do Transp.

        Close;
      End;

      fatVenda.strTipFre   := objDocumentos.cdsDocumentos.FieldByName('TIPFRE').AsString; // Tipo de Frete (Emitente/Dest.)
      fatVenda.fltValFre   := objDocumentos.cdsDocumentos.FieldByName('TOTFRE').AsFloat;  // Valor do Frete
      fatVenda.fltPesBru   := objDocumentos.cdsDocumentos.FieldByName('PESBRU').AsFloat;  // Peso Bruto
      fatVenda.fltPesLiq   := objDocumentos.cdsDocumentos.FieldByName('PESLIQ').AsFloat;  // Peso Liquido
      fatVenda.intQtdTra   := objDocumentos.cdsDocumentos.FieldByName('VOLUME').AsInteger;// Qtde.   a Ser Impressa na Nota Fiscal
      fatVenda.intNConhe   := objDocumentos.cdsDocumentos.FieldByName('NCONHE').AsInteger;// Número do conhecimento de frete
      fatVenda.fltBasSim   := objDocumentos.cdsDocumentos.FieldByName('BASSIM').AsFloat;  // Base de ICM Simples Paulista
      fatVenda.strMarTra   := objDocumentos.cdsDocumentos.FieldByName('MARCA_').AsString; // Marca   a Ser Impressa na Nota Fiscal
      fatVenda.strEspTra   := objDocumentos.cdsDocumentos.FieldByName('ESPECI').AsString; // Especie a Ser Impressa na Nota Fiscal

      fatVenda.strMen001   := objDocumentos.cdsDocumentos.FieldByName('MEN001').AsString; // Mensagem - 1
      fatVenda.strMen002   := objDocumentos.cdsDocumentos.FieldByName('MEN002').AsString; //          - 2
      fatVenda.strMen003   := objDocumentos.cdsDocumentos.FieldByName('MEN003').AsString; //          - 3
      fatVenda.strMen004   := objDocumentos.cdsDocumentos.FieldByName('MEN004').AsString; //          - 4
      fatVenda.strMen005   := objDocumentos.cdsDocumentos.FieldByName('MEN005').AsString; //          - 5

      stlMen50p := TStringList.Create;
      stlMen50p.Text := WrapText(fatVenda.strMen001 + ' ' + fatVenda.strMen002 + ' ' + fatVenda.strMen003 + ' ' + fatVenda.strMen004 + ' ' + fatVenda.strMen005, #13#10, [' '], 50);

      For intContador := 0 To stlMen50p.Count -1 Do
      Begin
        If intContador = 0 Then fatVenda.strMen501 := stlMen50p.Strings[intContador]
        Else If intContador = 1 Then fatVenda.strMen502 := stlMen50p.Strings[intContador]
        Else If intContador = 2 Then fatVenda.strMen503 := stlMen50p.Strings[intContador]
        Else If intContador = 3 Then fatVenda.strMen504 := stlMen50p.Strings[intContador]
        Else If intContador = 4 Then fatVenda.strMen505 := stlMen50p.Strings[intContador]
        Else If intContador = 5 Then fatVenda.strMen506 := stlMen50p.Strings[intContador]
        Else If intContador = 6 Then fatVenda.strMen507 := stlMen50p.Strings[intContador]
        Else If intContador = 7 Then fatVenda.strMen508 := stlMen50p.Strings[intContador];
      End;
      
      fatVenda.strNumDoc   := objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString; // Numero do Documento
      FNumDoc              := objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString;
      FEspDoc              := objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString;

      fatVenda.strEspDoc   := objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString; // Especie de Documento
      fatVenda.strConPag   := objDocumentos.cdsDocumentos.FieldByName('CONPAG').AsString; // Condicao de Pagamento
      fatVenda.strVlrExt   := AnsiUpperCase(fRetExtensoNumero(FloatToStrF(fatVenda.fltTotGer,ffNumber,12,2)));
      fatVenda.strHorSai   := TimeToStr(objDocumentos.cdsDocumentos.FieldByName('HORENT').AsDateTime);

      fatVenda.fltIrPrRt   := objDocumentos.cdsDocumentos.FieldByName('IRPRRT').AsFloat;
      fatVenda.fltIrPrDv   := objDocumentos.cdsDocumentos.FieldByName('IRPRDV').AsFloat;
      fatVenda.fltIrSeRt   := objDocumentos.cdsDocumentos.FieldByName('IRSERT').AsFloat;
      fatVenda.fltIrSeDv   := objDocumentos.cdsDocumentos.FieldByName('IRSEDV').AsFloat;
      fatVenda.fltPiPrRt   := objDocumentos.cdsDocumentos.FieldByName('PIPRRT').AsFloat;
      fatVenda.fltPiPrDv   := objDocumentos.cdsDocumentos.FieldByName('PIPRDV').AsFloat;
      fatVenda.fltPiSeRt   := objDocumentos.cdsDocumentos.FieldByName('PISERT').AsFloat;
      fatVenda.fltPiSeDv   := objDocumentos.cdsDocumentos.FieldByName('PISEDV').AsFloat;
      fatVenda.fltCoPrRt   := objDocumentos.cdsDocumentos.FieldByName('COPRRT').AsFloat;
      fatVenda.fltCoPrDv   := objDocumentos.cdsDocumentos.FieldByName('COPRDV').AsFloat;
      fatVenda.fltCoSeRt   := objDocumentos.cdsDocumentos.FieldByName('COSERT').AsFloat;
      fatVenda.fltCoSeDv   := objDocumentos.cdsDocumentos.FieldByName('COSEDV').AsFloat;
      fatVenda.fltCsPrRt   := objDocumentos.cdsDocumentos.FieldByName('CSPRRT').AsFloat;
      fatVenda.fltCsPrDv   := objDocumentos.cdsDocumentos.FieldByName('CSPRDV').AsFloat;
      fatVenda.fltCsSeRt   := objDocumentos.cdsDocumentos.FieldByName('CSSERT').AsFloat;
      fatVenda.fltCsSeDv   := objDocumentos.cdsDocumentos.FieldByName('CSSEDV').AsFloat;

      fatVenda.fltVlSgSo   := objDocumentos.cdsDocumentos.FieldByName('VLSGSO').AsFloat;
      fatVenda.fltPeSgSo   := objDocumentos.cdsDocumentos.FieldByName('PESGSO').AsFloat;

      fatVenda.fltDupRec   := objDocumentos.cdsDocumentos.FieldByName('DUPREC').AsFloat;
      fatVenda.fltBasOrg   := objDocumentos.cdsDocumentos.FieldByName('BASORG').AsFloat;
      fatVenda.fltIcmOrg   := objDocumentos.cdsDocumentos.FieldByName('ICMORG').AsFloat;

      fatVenda.strEntFat   := objDocumentos.cdsDocumentos.FieldByName('ENTFAT').AsString;

      fatVenda.dtaDtaEnt   := objDocumentos.cdsDocumentos.FieldByName('DTAENT').AsDateTime;      
      fatVenda.strDtaAtu   := objDocumentos.cdsDocumentos.FieldByName('DTAENT').AsString;

      if (fCfgSis('SIMPAU', varBoolean) and fCfgSis('RETIMP', varBoolean)) then
      begin
        fatVenda.strRetPCo := 'N';
        fatVenda.strRetIrf := 'N';
        fatVenda.strCDesPI := 'N';
      end
      else
      begin
        fatVenda.strRetPCo := objDocumentos.cdsDocumentos.FieldByName('RETPCO').AsString;
        fatVenda.strRetIrf := objDocumentos.cdsDocumentos.FieldByName('RETIRF').AsString;
        fatVenda.strCDesPI := objDocumentos.cdsDocumentos.FieldbyName('CDESPI').AsString;
      end;

      fatVenda.strRetIss   := objDocumentos.cdsDocumentos.FieldByName('RETISS').AsString;

      fatVenda.strSitIPI   := objDocumentos.cdsDocumentos.FieldByName('SITIPI').AsString;
      fatVenda.strEnqIPI   := objDocumentos.cdsDocumentos.FieldByName('ENQIPI').AsString;
      fatVenda.strMenIPI   := objDocumentos.cdsDocumentos.FieldByName('MENIPI').AsString;

      fatVenda.strSegSoc   := objDocumentos.cdsDocumentos.FieldByName('SEGSOC').AsString;

      fatVenda.pPreencheMatrizFechamento;

      For intContIte := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
      Begin
        if fEmptyStr(fatVenda.arrMatItens[intContIte].strCodFis) then
          fatVenda.arrMatItens[intContIte].strCodFis := fatVenda.arrMatItens[intContIte].strCodSit;
      End;

      fatVenda.pCalculaQtdCodFis;

      If Not blnDocumentoFornecedor Then
        fatVenda.pCalculaTotGer;

      fatVenda.fltVlrBru   := IIF(fCfgSis('EXIVLB',varBoolean), fatVenda.fCalculaValorBruto, 0.0);
      
      fatVenda.fltAlqIrf   := objDocumentos.cdsDocumentos.FieldByName('ALQIRF').AsFloat;
      fatVenda.fltValIrf   := objDocumentos.cdsDocumentos.FieldByName('VALIRF').AsFloat;
      fatVenda.fltAlqPis   := objDocumentos.cdsDocumentos.FieldByName('ALQPIS').AsFloat;
      fatVenda.fltValPis   := objDocumentos.cdsDocumentos.FieldByName('VALPIS').AsFloat;
      fatVenda.fltAlqCof   := objDocumentos.cdsDocumentos.FieldByName('ALQCOF').AsFloat;
      fatVenda.fltValCof   := objDocumentos.cdsDocumentos.FieldByName('VALCOF').AsFloat;
      fatVenda.fltAlqCsl   := objDocumentos.cdsDocumentos.FieldByName('ALQCSL').AsFloat;
      fatVenda.fltValCsl   := objDocumentos.cdsDocumentos.FieldByName('VALCSL').AsFloat;

      fatVenda.strNotRet   := objDocumentos.cdsDocumentos.FieldByName('NOTRET').AsString;

      fatVenda.fltRetIrf   := objDocumentos.cdsDocumentos.FieldByName('IRFRET').AsFloat;
      fatVenda.fltRetPis   := objDocumentos.cdsDocumentos.FieldByName('PISRET').AsFloat;
      fatVenda.fltRetCof   := objDocumentos.cdsDocumentos.FieldByName('COFRET').AsFloat;
      fatVenda.fltRetCsl   := objDocumentos.cdsDocumentos.FieldByName('CSLRET').AsFloat;

      fatVenda.fltRetSer   := objDocumentos.cdsDocumentos.FieldByName('SERRET').AsFloat;
      fatVenda.strNoReSe   := objDocumentos.cdsDocumentos.FieldByName('NORESE').AsString;

      fatVenda.blnDtcIrf   := (fatVenda.fltRetIrf > 0);
      fatVenda.blnDtcPis   := (fatVenda.fltRetSer > 0);
      fatVenda.blnDtcCof   := fatVenda.blnDtcPis;
      fatVenda.blnDtcCsl   := fatVenda.blnDtcPis;

      fatVenda.pCarregaAliquotasRetencao;

      fatVenda.intTemTri   := IIF(Not fatVenda.fApenasSubstituicao, 1, 0);

      fatVenda.fltBasRet    := objDocumentos.cdsDocumentos.FieldByName('BASRET').AsFloat;  // Total da Base - ICMS RETIDO
      fatVenda.fltAlqRet    := objDocumentos.cdsDocumentos.FieldByName('ALQRET').AsFloat;  // Alíquota de ICMS Retido
      fatVenda.fltTotRet    := objDocumentos.cdsDocumentos.FieldByName('TOTRET').AsFloat;  // Total - ICMS RET
      fatVenda.fltRet_SP    := objDocumentos.cdsDocumentos.FieldByName('RET_SP').AsFloat;  // Total - ICMS RET CASO TIVESSE
      fatVenda.fltBasRet_Sp := objDocumentos.cdsDocumentos.FieldByName('BARTSP').AsFloat;  // Total - ICMS RET + IPIENT + FREENT CASO TIVESSE
      fatVenda.fltValRet_Sp := objDocumentos.cdsDocumentos.FieldByName('VLRTSP').AsFloat;  // Total - VAL ICMS RET + IPIENT + FREENT CASO TIVESSE
      fatVenda.fltBasIcm    := objDocumentos.cdsDocumentos.FieldByName('BASICM').AsFloat;  // ICMS - Base
      fatVenda.fltTotIcm    := objDocumentos.cdsDocumentos.FieldByName('TOTICM').AsFloat;  //      - Total
      fatVenda.fltBasIpi    := objDocumentos.cdsDocumentos.FieldByName('BASIPI').AsFloat;  // IPI  - Base
      fatVenda.fltAlqIpi    := objDocumentos.cdsDocumentos.FieldByName('ALQIPI').AsFloat;  // IPI  - Alíquota
      fatVenda.fltTotIpi    := objDocumentos.cdsDocumentos.FieldByName('TOTIPI').AsFloat;  //      - Total
      fatVenda.fltAlqIcm    := objDocumentos.cdsDocumentos.FieldByName('ALQICM').AsFloat;  // Aliquota de Icms
      fatVenda.fltTotGer    := objDocumentos.cdsDocumentos.FieldByName('VLRCON').AsFloat;  // Total Geral
      fatVenda.strCliPer    := objDocumentos.cdsDocumentos.FieldByName('PERMUT').AsString;

      fatVenda.strDocsDevolucao := fRetDocsDev(objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString,
                                               objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString,
                                               objDocumentos.cdsDocumentos.FieldByName('CODEMP').AsString);

      If fEmptyStr(fTiraCaracEspeciais(fatVenda.strDocsDevolucao, True, True, True, True, True, True)) Then
        fatVenda.strDocsDevolucao := '';

      {******************************************}
      {* CASO FOR DOCUMENTO DE/PARA FORNECEDOR  *}
      {* NAO CHAMA A FUNCAO CALCULATOTGER, POIS *}
      {* OS DADOS DOS IMPOSTOS COMO ICMS SAO DI-*}
      {* GITADOS MANUALMENTE E QUANDO CHAMA ESTA*}
      {* FUNCAO ELA RECALCULA TUDO NOVAMENTE,   *}
      {* ESTRAGANDO ASSIM TODOS VALORES...      *}
      {* MAS COMO DENTRO DESTA FUNCAO SAO CHAMA-*}
      {* ALGUNS METODOS QUE MONTAM RESUMOS, É   *}
      {* NECESSARIO CHAMAR OS MESMOS MANUALMENTE*}
      {******************************************}
      If blnDocumentoFornecedor Then
      Begin
        fatVenda.pSintetizaClassificacoes;
        fatVenda.pGeraLegendaClassificacaoIPI;
        fatVenda.pGeraAlqIteImpressao;
        fatVenda.pSintetizaAbreviacaoFiscal;
      End;

      fatVenda.npcNumCmp := fatVenda.fBuscaNumsCmp(objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString,
                                                   objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString,
                                                   objDocumentos.cdsDocumentos.FieldByName('CODCLI').AsString,
                                                   objDocumentos.cdsDocumentos.FieldByName('CODEMP').AsString);

      pCarregaAuxMov(objDocumentos.cdsDocumentos.FieldByName('AUTINC').AsString,
                     objDocumentos.cdsDocumentos.FieldByName('TABELA').AsString);

      pCarregaMovRes(objDocumentos.cdsDocumentos.FieldByName('AUTINC').AsString,
                     objDocumentos.cdsDocumentos.FieldByName('TABELA').AsString);

      If objDocumentos.cdsDocumentos.FieldByName('TIP_FC').AsString = 'C' Then
        pCarregaEndEntregaCobranca(fatVenda, objDocumentos.cdsDocumentos.FieldByName('TABELA').AsString,
                                             objDocumentos.cdsDocumentos.FieldByName('AUTINC').AsString);

      For intContador := 0 To Length(fatVenda.arrMatItens) -1 Do
      Begin

        If fFormataFloat(fatVenda.fltBasIcm,2) <= 0.00 Then
        Begin
          fatvenda.pZerarDadosIcmsMatrizItens(True, intContador);

          fatVenda.arrMatItens[intContador].fltBas__S := 0.0;
          fatVenda.arrMatItens[intContador].fltAlq__S := 0.0;

        End;

        If fFormataFloat(fatVenda.fltBasIpi,2) <= 0.00 Then
        Begin
          fatvenda.pZerarDadosIpiMatrizItens(False, intContador);
        End;

        If fFormataFloat(fatVenda.fltBasRet,2) <= 0.00 Then
        Begin
          fatVenda.pZerarDadosStMatrizItens(intContador);
        End;

      End;

      {******************************************}
      {* CARREGA DADOS ADICIONAIS CONFORME LEI  *}
      {* 5817/10 DO ESTADO DO RJ PARA IMPRESSAO *}
      {***************************************IV*}
      fatVenda.pCarregaLei5817;

      {******************************************}
      {* MONTA O RESUMO DE CODIGOS FISCAIS PARA *}
      {* MOSTRAR NOS DADOS ADICIONAIS DA NOTA   *}
      {***************************************ER*}
      fatVenda.pCarregaResumoCodFiscal(fatVenda);

      fatVenda.strClaFis   := objDocumentos.cdsDocumentos.FieldByName('CLAFIS').AsString; // Classificacao Fiscal - Cod. 1
      fatVenda.strClaFi2   := objDocumentos.cdsDocumentos.FieldByName('CLAFI2').AsString; //                      - Cod. 2
      fatVenda.strClaFi3   := objDocumentos.cdsDocumentos.FieldByName('CLAFI3').AsString; //                      - Cod. 3
      fatVenda.strDesCla   := objDocumentos.cdsDocumentos.FieldByName('NATOPE').AsString; //                      - Descricao1

      If (Not fEmptyStr(fatVenda.strClaFi2)) Then
        fatVenda.strDesCl2 := fRetNomGeral('NAT_DESCRI','NAT_CODCFO','NATCFO',fStrToFloat(fatVenda.strClaFi2)) //                      - Descricao2
      Else
        fatVenda.strDesCl2 := '';

      If (Not fEmptyStr(fatVenda.strClaFi3)) Then
        fatVenda.strDesCl3 := fRetNomGeral('NAT_DESCRI','NAT_CODCFO','NATCFO',fStrToFloat(fatVenda.strClaFi3)) //                      - Descricao3
      Else
        fatVenda.strDesCl3 := '';        

      fatVenda.pAtualizaTemporariaItens(cdsVenda);

      {******************************************}
      {* MONTA O RESUMO DE CFOP                 *}
      {* MOSTRAR NOS DADOS ADICIONAIS DA NOTA   *}
      {***************************************JB*}
      fatVenda.pCarregaResumoCfop(fatVenda);

      {*********************************}
      {* VERIFICA SE A ITEM COM SUBTRI *}
      {******************************JB*}
      fatVenda.intTemSub   := IIF(fVerificaSituacaoTributaria(fatVenda), 1, 0);

      {*********************************}
      {* VERIFICA SE A ITEM INFLAMÁVEL *}
      {******************************PE*}
      fatVenda.intInflam := IIF(fVerificaItemInflamavel(fatVenda), 1, 0);


      fatVenda.pCalculaBaseIcmsRICMPR;

      {*********************************}
      {* CARREGA DADOS DE PARCELAMENTO *}
      {******************************AF*}
      fDigDuplic(arrDuplicata,
                 objDocumentos.cdsDocumentos.FieldByName('CONPAG').AsString,
                 123,
                 objDocumentos.cdsDocumentos.FieldByName('VLRCON').AsCurrency,
                 False,
                 False,
                 False,
                 objDocumentos.cdsDocumentos.FieldByName('DTAENT').AsDateTime,
                 False);

      // Feito dessa maneira por se tratar de nota fiscal formulário contínuo, vai ficar limitado a 12 parcelas.
      fatVenda.fltTotCadRec := 0.0;
      For intContador := 0 To 11 Do
      Begin
        arrDuplicata[intContador].curValor := objDocumentos.cdsDocumentos.FieldByName('VPAR' + fStrZero(intContador+1, 2)).AsFloat;
      End;

      If objDocumentos.cdsDocumentos.FieldByName('TABELA').AsString = 'MOVGER' then
        fatVenda.fltTotCadRec := fCampoTabela('SUM(GER_VALPAR)', 'GERCND INNER JOIN MOVGER ON GER_SEQGER = AUTOINCREM',
                                             ['GER_NUMDOC','GER_ESPDOC','GER_CODCLI','GER_CODEMP'],
                                             [objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString,
                                              objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString,
                                              objDocumentos.cdsDocumentos.FieldByName('CODCLI').AsString,
                                              objDocumentos.cdsDocumentos.FieldByName('CODEMP').AsString])
      Else
        fatVenda.fltTotCadRec := fCampoTabela('SUM(GER_VALPAR)', 'NOTCND INNER JOIN NOTGER ON GER_SEQGER = AUTOINCREM',
                                             ['GER_NUMDOC','GER_ESPDOC','GER_CODCLI','GER_CODEMP'],
                                             [objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString,
                                              objDocumentos.cdsDocumentos.FieldByName('ESPDOC').AsString,
                                              objDocumentos.cdsDocumentos.FieldByName('CODCLI').AsString,
                                              objDocumentos.cdsDocumentos.FieldByName('CODEMP').AsString]);

      fatVenda.blnConApr := (fatVenda.strConPag = '01999');

      {*****************************************}
      {* SE FOR DOCUMENTO A PRAZO              *}
      {**************************************MV*}
      blnSintetizaParcel := False;
      //If (fStatusCndPag(fatVenda.strConPag) = A_PRAZO) Then
      //Begin

        {*****************************************}
        {* MONTA AS MATRIZES COM VALORES DAS DU- *}
        {* PLICATAS                              *}
        {**************************************MV*}
        fatVenda.fltDupRec := fatVenda.fltDupRec + Self.fTotalRecebidoPedido(fatVenda.strNumDoc, fatVenda.strEspDoc);
        If (fatVenda.fltDupRec > 0.0) Then
        Begin
          arrNumDup[00] := fatVenda.strNumDoc + arrDuplicata[00].strSequen;;
          arrDtaDup[00] := DateToStr(VS_Date);
          arrValDup[00] := fatVenda.fltDupRec;
          intQtdDup     := 10;

          {*******************************************}
          {* CASO FOR CONFIRMAÇÃO, VERIFICA SE É     *}
          {* NECESSÁRIO SINTETIZAR AS PARCELAS PAGAS *}
          {* COM A NOVA DUPLICATA A VISTA            *}
          {****************************************MV*}
          If (StrToDate(arrDuplicata[00].dtaDtaVen) = VS_Date) Then
          Begin
            blnSintetizaParcel := True;
          End;

        End
        Else
          intQtdDup := 11;

        For intContador := 0 To intQtdDup Do
        Begin
          If (intContador = 0) And (fatVenda.fltDupRec <= 0.0) Then
          Begin
            blnAtualiza := True;
          End
          Else
            blnAtualiza := True;

          intIndice := intContador;
          If (fatVenda.fltDupRec > 0.0) And (Not blnSintetizaParcel) Then
            intIndice := intIndice + 1;

          {*******************************************}
          {* REALIZA SINTETIZAÇÃO (SOMENTE DA 1ª PAR)*}
          {****************************************MV*}
          If (blnSintetizaParcel) And (intContador = 0) Then
          Begin
            arrDuplicata[intContador].curValor := arrDuplicata[intContador].curValor + fatVenda.fltDupRec;
          End;

          If blnAtualiza Then
          Begin
            arrNumDup[intIndice] := fatVenda.strNumDoc + arrDuplicata[intContador].strSequen;
            arrDtaDup[intIndice] := arrDuplicata[intContador].dtaDtaVen;
            arrValDup[intIndice] := arrDuplicata[intContador].curValor;
          End;

        End;
      (*End
      Else
      Begin
        {*******************************************}
        {* DOCUMENTO A VISTA ESCREVE "A VISTA"     *}
        {****************************************MV*}
        For intContador := 0 To 11 Do
        Begin
          arrNumDup[intContador] := '';
          arrDtaDup[intContador] := '';
          arrValDup[intContador] := 0.0;
        End;
        arrNumDup[0] := 'A VISTA';
      End;*)

      {*****************************************}
      {* ALIMENTA AS VARIÁVEIS DO NÚMERO DA DU-*}
      {* PLICATA                               *}
      {**************************************MV*}
      fatVenda.strNumD01 := arrNumDup[00];
      fatVenda.strNumD02 := arrNumDup[01];
      fatVenda.strNumD03 := arrNumDup[02];
      fatVenda.strNumD04 := arrNumDup[03];
      fatVenda.strNumD05 := arrNumDup[04];
      fatVenda.strNumD06 := arrNumDup[05];
      fatVenda.strNumD07 := arrNumDup[06];
      fatVenda.strNumD08 := arrNumDup[07];
      fatVenda.strNumD09 := arrNumDup[08];
      fatVenda.strNumD10 := arrNumDup[09];
      fatVenda.strNumD11 := arrNumDup[10];
      fatVenda.strNumD12 := arrNumDup[11];

      {*****************************************}
      {* ALIMENTA AS VARIÁVEIS DA DATA DE VEN- *}
      {* CIMENTO                               *}
      {**************************************MV*}
      fatVenda.strDtaV01 := arrDtaDup[00];
      fatVenda.strDtaV02 := arrDtaDup[01];
      fatVenda.strDtaV03 := arrDtaDup[02];
      fatVenda.strDtaV04 := arrDtaDup[03];
      fatVenda.strDtaV05 := arrDtaDup[04];
      fatVenda.strDtaV06 := arrDtaDup[05];
      fatVenda.strDtaV07 := arrDtaDup[06];
      fatVenda.strDtaV08 := arrDtaDup[07];
      fatVenda.strDtaV09 := arrDtaDup[08];
      fatVenda.strDtaV10 := arrDtaDup[09];
      fatVenda.strDtaV11 := arrDtaDup[10];
      fatVenda.strDtaV12 := arrDtaDup[11];

      {*****************************************}
      {* ALIMENTA AS VARIÁVEIS DO VALOR DAS DU-*}
      {* PLICATAS                              *}
      {**************************************MV*}
      fatVenda.fltValD01 := arrValDup[00];
      fatVenda.fltValD02 := arrValDup[01];
      fatVenda.fltValD03 := arrValDup[02];
      fatVenda.fltValD04 := arrValDup[03];
      fatVenda.fltValD05 := arrValDup[04];
      fatVenda.fltValD06 := arrValDup[05];
      fatVenda.fltValD07 := arrValDup[06];
      fatVenda.fltValD08 := arrValDup[07];
      fatVenda.fltValD09 := arrValDup[08];
      fatVenda.fltValD10 := arrValDup[09];
      fatVenda.fltValD11 := arrValDup[10];
      fatVenda.fltValD12 := arrValDup[11];

      {*******************************************}
      {* CASO SEJA REIMPRESSÃO, RATEIA OS VALORES*}
      {* POIS ESSA FUNÇÃO CHAMA QUANDO CHAMA PELO*}
      {* FATURAMENTO                             *}
      {****************************************MV*}
      If (Not FFatVenda) Then
        fatVenda.pRateiaValores;

      fatVenda.pGeraAlqIcmAnt;

      pAtribuiIndiceLegendaTipoSituacao(cdsVenda);

      pDataHoraInformada;

      {*******************************************}
      {* VALIDA ITEM AGROTOXICO P/ IMPRESSAO MSG *}
      {****************************************IV*}
      If fCfgSis('RECGRO', varBoolean) Then
      Begin
        fatVenda.blnIteGro := fVerificaItemAgrotoxico(fatVenda);
        fatVenda.strMsgGro := MSG_AGROTOXICO;
      End;

      intQtdImp := 0;
      intQtdIte := Length(fatVenda.arrMatItens);

      fatVenda.fltTotPar := 0.0;

      intQtdNot := intQtdIte Div fCfgSis('ITENOT', varInteger);
      If (intQtdIte - (intQtdNot * fCfgSis('ITENOT', varInteger)) > 0) Then
      Begin
        Inc(intQtdNot);
      End;

      If (intQtdNot = 0) And (fCfgSis('USASER', varBoolean)) Then
        intQtdNot := 1;

      strTipNot := IIF(Not blnNotaServico,'NO','NS');

      intLinhaAtu := 0;
      intLinha    := 0;

      Screen.Cursor := crHourGlass;

      {**************************************}
      {* CARREGANDO AS CONFIGURACOES CNF_NF *}
      {***********************************AN*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CNF_NF ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CNF_TIPNOT = :TIPNOT AND ';
      strSQL := strSQL + '  CNF_CODEMP = :CODEMP ';
      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  CNF_IDENTI, ';
      strSQL := strSQL + '  CNF_LINIMP, ';
      strSQL := strSQL + '  CNF_COLIMP, ';
      strSQL := strSQL + '  CNF_CODSEQ  ';

      qryCnfNf := fCriarQuery(strSQL);

      fatVenda.intQtdNot     := intQtdNot;
      cdsVenda.First;

      For intContador := 1 To intQtdNot Do
      Begin

        blnDecrementou := False;

        intLinha := 0;
        fatVenda.fltTotpar := 0.0;
        fatVenda.intNotAtu := intContador;

        fatVenda.pAtualizaCamposUso(cpuCampos, qryGenEmp);

        With qryCnfNf Do
        Begin
          Close;
          ParamByName('TIPNOT').AsString := strTipNot;
          ParamByName('CODEMP').AsString := VS_strCodEmp;
         
          Open;
          First;

          intColMar := FieldByName('CNF_MARGEM').AsInteger;
          intLinTop := FieldByName('CNF_LINTOP').AsInteger;

          If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '00']), [loPartialKey]) Then
          Begin

            While (Not Eof)                                   And
                  (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                  (FieldByName('CNF_IDENTI').AsString = '00') Do
            Begin
              pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, strNomImp, qryCnfNf);
            End;

          End;

          If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '01']), [loPartialKey]) Then
          Begin

            While (Not Eof)                                   And
                  (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                  (FieldByName('CNF_IDENTI').AsString = '01') Do
            Begin
              pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, strNomImp, qryCnfNf);
            End;

          End;

          {*****************************************}
          {* FAZ IMPRESSÃO DOS ITENS               *}
          {**************************************MV*}
          cdsVenda.DisableControls;

          intLinha := qryCnfNf.FieldByName('CNF_LINIMP').AsInteger;


          If (fEmptyStr(cdsVenda.FieldByName('ITE_CODITE').AsString)) Then
            blnJaZerou := True
          Else
            blnJaZerou := False;

          While Not cdsVenda.Eof Do
          Begin

            fatVenda.pAtualizaCamposUso(cpuCampos, qryGenEmp);

            If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '02']), [loPartialKey]) Then
            Begin


              If (Not blnJaZerou) Then
              Begin

                While (Not Eof)                                   And
                      (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                      (FieldByName('CNF_IDENTI').AsString = '02') Do
                Begin
                  pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, strNomImp, qryCnfNf);
                End;

                fatVenda.fltTotPar := fatVenda.fltTotPar + cdsVenda.FieldByName('ITE_TOTITE').AsFloat;

              End;

              If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '03']), [loPartialKey]) Then
              Begin

                If Not blnJaZerou Then
                  cdsVenda.Next;

                While (Not cdsVenda.Eof)                                       And
                      (fEmptyStr(cdsVenda.FieldByName('ITE_CODITE').AsString)) And
                      ((intQtdImp + 1) < fCfgSis('ITENOT', varInteger))         Do
                Begin

                  Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '03']), [loPartialKey]);
                  fatVenda.pAtualizaCamposUso(cpuCampos, qryGenEmp);
                  While (Not Eof)                                   And
                        (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                        (FieldByName('CNF_IDENTI').AsString = '03') Do
                  Begin
                    pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, strNomImp, qryCnfNf);
                  End;
                  cdsVenda.Next;

                  If (Not blnJaZerou) Then
                    Inc(intQtdImp);

                  {*****************************************}
                  {* CASO IMPRIMIU A QUANTIDADE DE ITENS   *}
                  {* QUE CABE NA NOTA, IMPRIME OS RODAPÉS  *}
                  {**************************************MV*}
                  blnJaZerou := False;
                  If (intQtdImp = fCfgSis('ITENOT', varInteger) - 1) Then
                  Begin
                    Break;
                  End;

                  If (cdsVenda.Eof) And (intContador > 1) Then
                  Begin
                    //Dec(intLinhaAtu,2);
                    blnDecrementou := True;
                  End;

                End;

                If (Not cdsVenda.Eof) Then
                  cdsVenda.Prior;

              End;

            End;

            If (Not blnJaZerou) Then
            Begin
              Inc(intQtdImp);
              cdsVenda.Next;
            End;

            {*****************************************}
            {* CASO IMPRIMIU A QUANTIDADE DE ITENS   *}
            {* QUE CABE NA NOTA, IMPRIME OS RODAPÉS  *}
            {**************************************MV*}
            If (intQtdImp = fCfgSis('ITENOT', varInteger)) Then
            Begin
              intQtdImp := 0;
              Break;
            End;

          End; //End do While do CadIte

          cdsVenda.EnableControls;

          If (cdsVenda.Eof) And (Not blnDecrementou)Then
          Begin
            //Dec(intLinhaAtu, 2);
          End;

          If (Not blnJaZerou) Then
            Inc(intLinhaAtu, 1)
          Else
            Inc(intLinhaAtu, 2);

          If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '04']), [loPartialKey]) Then
          Begin

            While (Not Eof)                                   And
                  (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                  (FieldByName('CNF_IDENTI').AsString = '04') Do
            Begin
              pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, strNomImp, qryCnfNf);
            End;

          End;

          If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '05']), [loPartialKey]) Then
          Begin

            While (Not Eof)                                   And
                  (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                  (FieldByName('CNF_IDENTI').AsString = '05') Do
            Begin
              pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, strNomImp, qryCnfNf);
            End;
          End;

          If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '06']), [loPartialKey]) Then
          Begin

            While (Not Eof)                                   And
                  (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                  (FieldByName('CNF_IDENTI').AsString = '06') Do
            Begin
              pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, strNomImp, qryCnfNf);
            End;
          End;

          If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '99']), [loPartialKey]) Then
          Begin

            While (Not Eof)                                   And
                  (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                  (FieldByName('CNF_IDENTI').AsString = '99') Do
            Begin
              pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, strNomImp, qryCnfNf);
            End;
          End;

          {************************************************}
          {* QUANDO TIPO DE FORMULARIO FOR IGUAL A AVULSO *}
          {* MOSTRO A MENSAGEM.                           *}
          {*********************************************AC*}
          If (fCfgSis('TIPFOR') = 'A') And (intQtdNot > intContador)  Then
          Begin
            fMensagem('ATENÇÃO','INCLUA O PRÓXIMO FORMULÁRIO NA IMPRESSORA E TECLE ENTER PARA CONTINUAR!',['&OK']);
          End;

        End; // End do With

      End; // End do For

      Screen.Cursor := crDefault;

    Except

      On E: ExceptionAutCom Do
      Begin
        fMensagem('', E.Message, ['& O k']);
      End;

      On E: EInOutError Do
      Begin

        If (E.ErrorCode = 53) Then
          Raise Exception.Create('Impressora indisponível')
        Else
          Raise Exception.Create(E.Message);

      End;

    End;

    pAtualizaQtdDocCadFis(intQtdNot, strFisNum, strFisEsp, strFisEmp, strFisInc);

  Finally

    fDropTable(strNomeTabela);
    FreeAndNil(qryGenEmp);
    FreeAndNil(qryGenTra);
    FreeAndNil(stlMen50p);

    If Assigned(cpuCampos) Then
      FreeAndNil(cpuCampos);

    If (Not blnAssigned) Then
      FreeAndNil(fatVenda);

    If (cdsVenda <> nil) And (oleDadosVenda <> Null) Then
    Begin
      Try
        //cdsVenda.Data := oleDadosVenda;
        pFreeCdsVenda;
        pSetCdsVenda(cdsDadosVenda);
        oleDadosVenda := Null;
      Except
        //Apenas para não dar erro.
      End;
    End;

    If Assigned(qryCnfNf) Then
      FreeAndNil(qryCnfNf);  

  End;

End;

{************************************}
{* INSERE DADOS NA TEMPORARIA       *}
{*********************************AF*}
procedure TReimpressao.pInsereDadosTemp(strCodEmp: String);
  Var
    strSQL: String;
    intContador: Integer;
    stlObsNes: TStringList;
    blnNotMFi: Boolean;
Begin
  blnNotMFi := fCfgSis('NOTMFI', varBoolean);

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  I.ITE_PESOIT AS PESOIT, ';
  strSQL := strSQL + '  I.ITE_PESLIQ AS PESLIQ, ';
  strSQL := strSQL + '  I.ITE_MENFIS AS MENFIS, ';
  strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '  G.ITE_DESMAX AS DESMAX, ';
  strSQL := strSQL + '  G.ITE_PREVE1 AS PREVE1, ';
  strSQL := strSQL + '  G.ITE_PREVE2 AS PREVE2, ';
  strSQL := strSQL + '  G.ITE_PREVE3 AS PREVE3, ';
  strSQL := strSQL + '  G.ITE_PREVE4 AS PREVE4, ';
  strSQL := strSQL + '  G.ITE_PREVE5 AS PREVE5, ';
  strSQL := strSQL + '  G.ITE_PREVE6 AS PREVE6, ';
  strSQL := strSQL + '  G.ITE_PREVE7 AS PREVE7, ';
  strSQL := strSQL + '  G.ITE_SALDOS AS SALDOS, ';
  strSQL := strSQL + '  I.ITE_EMBALA AS EMBALA, ';
  strSQL := strSQL + '  G.ITE_IPISAI AS IPISAI, ';
  strSQL := strSQL + '  I.ITE_COMLUB AS COMLUB, ';
  strSQL := strSQL + '  I.ITE_CLAIPI AS CLAIPI, ';
  strSQL := strSQL + '  G.ITE_COMVAR AS COMVAR, ';

  If fCfgSis('IMPDIG') = '1' Then
    strSQL := strSQL + '  I.ITE_IMPDIR AS IMPDIR,  '
  Else
    strSQL := strSQL + '  G.ITE_IMPDIR AS IMPDIR, ';

  strSQL := strSQL + '  G.ITE_LOCFIS AS LOCFIS  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I, ';
  strSQL := strSQL + '  ITEGER G ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  G.ITE_CODITE = I.ITE_CODITE AND ';

  strSQL := strSQL + '  G.ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP ';

  FAux002.Close;
  FAux002.SQL.Clear;
  FAux002.SQL.Add(strSQL);
  FAux002.ParamByName('CODITE').AsString := FAux001.FieldByName('CODITE').AsString;
  FAux002.ParamByName('CODEMP').AsString := strCodEmp;
  FAux002.Open;

  With cdsVenda Do
  Begin
    Insert;

    If TAggregateField(FieldByName('MAX_AUTINC')).Value = Null Then
      FieldByName('AUTOINCREM').AsInteger := 1
    Else
      FieldByName('AUTOINCREM').AsInteger := TAggregateField(FieldByName('MAX_AUTINC')).Value + 1;

    FieldByName('ITE_IDEPRO').AsString  := FAux001.FieldByName('IDEPRO').AsString;
    FieldByName('ITE_CODGRU').AsString  := FAux001.FieldByName('CODGRU').AsString;
    FieldByName('ITE_CODITE').AsString  := FAux001.FieldByName('CODITE').AsString;
    FieldByName('ITE_COD_NF').AsString  := FAux001.FieldByName('COD_NF').AsString;
    FieldByName('ITE_DES_NF').AsString  := FAux001.FieldByName('DES_NF').AsString;
    FieldByName('ITE_DESITE').AsString  := FAux001.FieldByName('DESITE').AsString;
    FieldByName('ITE_DESORI').AsString  := FAux001.FieldByName('DESITE').AsString;
    FieldByName('ITE_DESFAB').AsString  := FAux001.FieldByName('DESFAB').AsString;
    FieldByName('ITE_REFERE').AsString  := FAux001.FieldByName('REFERE').AsString;
    FieldByName('ITE_CODUNI').AsString  := FAux001.FieldByName('UNIDAD').AsString;
    FieldByName('ITE_UNIDAD').AsString  := FAux001.FieldByName('UNIDAD').AsString;
    FieldByName('ITE_SIGUNI').AsString  := fRetSiglaUnidade(FAux001.FieldByName('UNIDAD').AsString);
    FieldByName('ITE_DESUNI').AsString  := fRetNomUnidade(FAux001.FieldByName('UNIDAD').AsString);
    FieldByName('ITE_CODMAR').AsString  := FAux001.FieldByName('CODMAR').AsString;
    FieldByName('ITE_DESMAR').AsString  := fRetNomMarca(FAux001.FieldByName('CODMAR').AsString);
    FieldByName('ITE_CODFOR').AsString  := FAux001.FieldByName('CODFOR').AsString;
    FieldByName('ITE_VAL_RT').AsFloat   := FAux001.FieldByName('VAL_RT').AsFloat;
    FieldByName('ITE_UNIORI').AsFloat   := FAux001.FieldByName('UNIORI').AsFloat;
    FieldByName('ITE_UNIVIS').AsFloat   := FAux001.FieldByName('UNIVIS').AsFloat;
    FieldByName('ITE_TAXJUR').AsFloat   := FAux001.FieldByName('TAXJUR').AsFloat;
    FieldByName('ITE_UNITAR').AsFloat   := FAux001.FieldByName('UNITAR').AsFloat;
    FieldByName('ITE_UNITMP').AsFloat   := 0;
    FieldByName('ITE_DESCON').AsFloat   := FAux001.FieldByName('DESCON').AsFloat;
    FieldByName('ITE_QTDITE').AsFloat   := FAux001.FieldByName('QTDITE').AsFloat;
    FieldByName('ITE_TOTITE').AsFloat   := FAux001.FieldByName('TOTITE').AsFloat;
    FieldByName('ITE_MARLUC').AsFloat   := 0;
    FieldByName('ITE_DESESP').AsFloat   := FAux001.FieldByName('DESESP').AsFloat;
    FieldByName('ITE_ENTSAI').AsString  := '';
    FieldByName('ITE_PRECUS').AsFloat   := FAux001.FieldByName('TOTCUS').AsFloat;
    FieldByName('ITE_TOTCUS').AsFloat   := FAux001.FieldByName('TOTCUS').AsFloat;
    FieldByName('ITE_PREMED').AsFloat   := 0;
    FieldByName('ITE_TOTMED').AsFloat   := FAux001.FieldByName('TOTMED').AsFloat;
    FieldByName('ITE_CLAFIS').AsString  := FAux001.FieldByName('CLAFIS').AsString;
    FieldByName('ITE_PERRED').AsFloat   := FAux001.FieldByName('PERRED').AsFloat;
    FieldByName('ITE_PERBAS').AsFloat   := FAux001.FieldByName('PERBAS').AsFloat;
    FieldByName('ITE_COMLUB').AsString  := FAux002.FieldByName('COMLUB').AsString;
    FieldByName('ITE_IPISAI').AsFloat   := FAux002.FieldByName('IPISAI').AsFloat;
    FieldByName('ITE_LOCFIS').AsString  := FAux002.FieldByName('LOCFIS').AsString;
    FieldByName('ITE_DESFIS').AsString  := FAux002.FieldByName('LOCFIS').AsString;

    If (Assigned(fTipoTinta))                                              And
       (fTipoTinta(FAux001.FieldByName('IDEPRO').AsString) in [ttAutomotiva, ttIndustrial]) Then
      FieldByName('ITE_PESOIT').AsFloat   := FAux001.FieldByName('TOTPES').AsFloat/FAux001.FieldByName('QTDITE').AsFloat
    Else
      FieldByName('ITE_PESOIT').AsFloat   := FAux002.FieldByName('PESOIT').AsFloat;

    FieldByName('ITE_PESLIQ').AsFloat   := FAux002.FieldByName('PESLIQ').AsFloat;

    FieldByName('ITE_DESMAX').AsFloat   := FAux002.FieldByName('DESMAX').AsFloat;
    FieldByName('ITE_PREVE1').AsFloat   := FAux002.FieldByName('PREVE1').AsFloat;
    FieldByName('ITE_PREVE2').AsFloat   := FAux002.FieldByName('PREVE2').AsFloat;
    FieldByName('ITE_PREVE3').AsFloat   := FAux002.FieldByName('PREVE3').AsFloat;
    FieldByName('ITE_PREVE4').AsFloat   := FAux002.FieldByName('PREVE4').AsFloat;
    FieldByName('ITE_PREVE5').AsFloat   := FAux002.FieldByName('PREVE5').AsFloat;
    FieldByName('ITE_PREVE6').AsFloat   := FAux002.FieldByName('PREVE6').AsFloat;
    FieldByName('ITE_PREVE7').AsFloat   := FAux002.FieldByName('PREVE7').AsFloat;
    FieldByName('ITE_SALDOS').AsFloat   := FAux002.FieldByName('SALDOS').AsFloat;
    FieldByName('ITE_COMVAR').AsFloat   := FAux002.FieldByName('COMVAR').AsFloat;
    FieldByName('ITE_INCPIS').AsString  := FAux001.FieldByName('INCPIS').AsString;
    FieldByName('ITE_DESACE').AsFloat   := FAux001.FieldByName('DESACE').AsFloat;
    FieldByName('ITE_VALFRE').AsFloat   := FAux001.FieldByName('TOTFRE').AsFloat;
    FieldByName('ITE_TIPEMB').AsString  := FAux001.FieldByName('TIPEMB').AsString;
    FieldByName('ITE_PREEMB').AsFloat   := FAux001.FieldByName('PREEMB').AsFloat;
    FieldByName('ITE_PRVTIN').AsFloat   := FAux001.FieldByName('PRVTIN').AsFloat;
    FieldByName('ITE_PRCTIN').AsFloat   := FAux001.FieldByName('PRCTIN').AsFloat;
    FieldByName('ITE_QTDEMB').AsInteger := FAux001.FieldByName('QTDEMB').AsInteger;
    FieldByName('ITE_EMBALA').AsFloat   := FAux002.FieldByName('EMBALA').AsFloat;
//    FieldByName('ITE_DOCDEV').AsString  := '';
//    FieldByName('ITE_ESPDEV').AsString  := '';
//    FieldByName('ITE_EMPDEV').AsString  := '';
//    FieldByName('ITE_QTDDEV').AsFloat   := 0;
//    FieldByName('ITE_UNIDEV').AsFloat   := 0;
//    FieldByName('ITE_INCDEV').AsInteger := 0;
    FieldByName('ITE_CLAIPI').AsString  := FAux002.FieldByName('CLAIPI').AsString;
    FieldByName('ITE_LETIPI').AsString  := '';
    FieldByName('ITE_ITECHA').AsString  := FAux001.FieldByName('ITECHA').AsString;
    FieldByName('ITE_ITETIN').AsString  := FAux001.FieldByName('ITETIN').AsString;
    FieldByName('ITE_FATTIN').AsFloat   := FAux001.FieldByName('FATTIN').AsFloat;
    FieldByName('ITE_PROEMB').AsString  := FAux001.FieldByName('PROEMB').AsString;
    FieldByName('ITE_DESCOR').AsString  := FAux001.FieldByName('DESCOR').AsString;
    FieldByName('ITE_TIPPRE').AsString  := FAux001.FieldByName('TIPPRE').AsString;
    FieldByName('ITE_LAZQUA').AsInteger := FAux001.FieldByName('LAZQUA').AsInteger;
    FieldByName('ITE_MONTAD').AsString  := '';
    FieldByName('ITE_A_N_O_').AsString  := '';
    FieldByName('ITE_ITEEMB').AsString  := '';
    Try
      FieldByName('ITE_UNIEMB').AsFloat   := fFormataFloat(FAux001.FieldByName('PREEMB').AsFloat / IIF(FAux001.FieldByName('QTDEMB').AsFloat = 0, 1, FAux001.FieldByName('QTDEMB').AsFloat), 4);
    Except
      FieldByName('ITE_UNIEMB').AsFloat   := 0.0;
    End;
    FieldByName('ITE_EMBANT').AsString  := '';

    FieldByName('ABF_CODABF').AsString  := FAux001.FieldByName('ABF_CODABF').AsString;
    FieldByName('ABF_CODFIS').AsString  := FAux001.FieldByName('CODFIS').AsString;
    FieldByName('ABF_CODSIT').AsString  := FAux001.FieldByName('CODFIS').AsString;
    FieldByName('ABF_CODMEN').AsString  := '';

    FieldByName('ITE_VALRET').AsFloat   := FAux001.FieldByName('VALRET').AsFloat;
    FieldByName('ITE_ALQRET').AsFloat   := FAux001.FieldByName('ALQRET').AsFloat;
    FieldByName('ITE_BASRET').AsFloat   := FAux001.FieldByName('BASRET').AsFloat;
    FieldByName('ITE_VALICM').AsFloat   := FAux001.FieldByName('VALICM').AsFloat;
    FieldByName('ITE_BASICM').AsFloat   := FAux001.FieldByName('BASICM').AsFloat;
    FieldByName('ITE_ALQICM').AsFloat   := FAux001.FieldByName('ALQICM').AsFloat;
    FieldByName('ITE_ALQITE').AsString  := '';
    FieldByName('ITE_VALIPI').AsFloat   := FAux001.FieldByName('VALIPI').AsFloat;
    FieldByName('ITE_BASIPI').AsFloat   := FAux001.FieldByName('BASIPI').AsFloat;
    FieldByName('ITE_ALQIPI').AsFloat   := FAux001.FieldByName('ALQIPI').AsFloat;
    FieldByName('ITE_CODFAB').AsString  := FAux002.FieldByName('CODFAB').AsString;
    FieldByName('ITE_NUMLOT').AsString  := FAux001.FieldByName('NUMLOT').AsString;
    FieldByName('ITE_DESNES').AsString  := FAux001.FieldByName('DESNES').AsString;
    FieldByName('ITE_IMPDIR').AsString  := FAux002.FieldByName('IMPDIR').AsString;

    FieldByName('ITE_BARTSP').AsFloat   := FAux001.FieldByName('BARTSP').AsFloat;
    FieldByName('ITE_VLRTSP').AsFloat   := FAux001.FieldByName('VLRTSP').AsFloat;
    FieldByName('ITE_ICOPPR').AsFloat   := FAux001.FieldByName('ICOPPR').AsFloat;

    FieldByName('ITE_SEQCCR').AsInteger := FAux001.FieldByName('SEQCCR').AsInteger;

    stlObsNes := fRetornaWordWrap(FieldByName('ITE_DESNES').AsString, 70);

    If blnNotMFi And (Not fEmptyStr(FAux002.FieldByName('MENFIS').AsString)) Then
      stlObsNes.Add(FAux002.FieldByName('MENFIS').AsString);

    If Not fEmptyStr(FAux001.FieldByName('NUMLOT').AsString) then
      stlObsNes.Add('LOTE: ' + FAux001.FieldByName('NUMLOT').AsString);

    Post;

    For intContador := 0 To stlObsNes.Count -1 Do
    Begin
      Append;

      If TAggregateField(FieldByName('MAX_AUTINC')).Value = Null Then
        FieldByName('AUTOINCREM').AsInteger := 1
      Else
        FieldByName('AUTOINCREM').AsInteger := TAggregateField(FieldByName('MAX_AUTINC')).Value + 1;

      FieldByName('ITE_DESNES').AsString := stlObsNes[intContador];
      FieldByName('ITE_QTDITE').AsFloat  := 1; // ** se deixar o item zerado, da pau na pCalculatotgerinterna 
      Post;
    End;

    If (objDocumentos.cdsDocumentos.FieldByName('DIFERI').AsString = 'S') And (FAux001.FieldByName('BARTSP').AsFloat > 0) Then
    Begin
      Append;

      If TAggregateField(FieldByName('MAX_AUTINC')).Value = Null Then
        FieldByName('AUTOINCREM').AsInteger := 1
      Else
        FieldByName('AUTOINCREM').AsInteger := TAggregateField(FieldByName('MAX_AUTINC')).Value + 1;

      FieldByName('ITE_DESNES').AsString := 'Base ST.: ' + FloatToStrF(FAux001.FieldByName('BARTSP').AsFloat, ffNumber, 12, 2) + ' / ' +
                                            'Valor ST.: ' + FloatToStrF(FAux001.FieldByName('VLRTSP').AsFloat, ffNumber, 12, 2) + ' / ' +
                                            'ICMS Oper. Prop.: ' + FloatToStrF(FAux001.FieldByName('ICOPPR').AsFloat, ffNumber, 12, 2);
      FieldByName('ITE_QTDITE').AsFloat  := 1; // ** se deixar o item zerado, da pau na pCalculatotgerinterna
      Post;
    End;
  End;

  FAux002.Close;
  If Assigned(stlObsNes) Then
    FreeAndNil(stlObsNes);

End;

{******************************************}
{* REALIZA A IMPRESSÃO DA NOTA DE COMPLEM *}
{***************************************AF*}
procedure TReimpressao.pImprimeNotaComp;
  Var
    intContador: Integer;
    intIndice: Integer;

    intLinhaAtu: Integer;
    intLinha: Integer;

    intQtdNot: Integer;
    intQtdImp: Integer;
    intQtdIte: Integer;

    fltQuantiIte: Double;
    fltQuantiPro: Double;
    cpuCampos   : TCamposUso;
    strTipNot: String;
    strNomImp: String;
    intQtdDup: Integer;

    arrNumDup: Array [0..11] Of String;
    arrDtaDup: Array [0..11] Of String;
    arrValDup: Array [0..11] Of Double;

    blnAtualiza: Boolean;

    qryGenEmp : TUniQuery;
    qryCnfNf  : TUniQuery;

    strSQL: String;

    {*****************************************}
    {* VARIAVEIS DE IMPRESSORA DEFAULT       *}
    {**************************************AF*}
    Device: Array[0..255] Of Char;
    Driver: Array[0..255] Of Char;
    Port  : Array[0..255] Of Char;
    Handle: THandle;

    arrDuplicata: TarrDuplicata;
begin
  pZeraDigDuplic(arrDuplicata);
  cpuCampos := nil;
  qryCnfNf  := nil;
  qryGenEmp := nil;
  Try
    qryGenEmp := fCriaQuery;

    pCarregaConfImpr(qryCfgRel, 'frmFatVendas_NOTA');
    strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

    If qryCfgRel.FieldByName('REL_IMPPAD').AsString = 'S' Then
    Begin
      // Com a impressora padrão marcada a fila vem vazia; no spool Citel não há padrão do Windows
      // (depende do Spooler, erro 1722 com ele desligado). A nota sai em fatVenda.strNomImp: sem
      // destino, o ponto se pergunta e passa a ser o destino da impressão.
      If TCfgRel.VS_SpoolImpressaoCitel Then
      Begin
        strNomImp := fatVenda.strNomImp;
        If fEmptyStr(strNomImp) Then
        Begin
          strNomImp := TCfgRel.fSelecionaFila('', '', True);
          If fEmptyStr(strNomImp) Then
            Exit;
          fatVenda.strNomImp := strNomImp;
        End;
      End
      Else
      Begin
        Printer.GetPrinter(Device, Driver, Port, Handle);
        strNomImp := Device;
      End;
    End;

    If Not fVerificaImpressora(strNomImp) Then
    Begin
      fMensagem('','Impressora de nota configurada incorretamente!',['&OK']);
      Exit;
    End;

    fatVenda.strNomPor := fRetNomPortador(fatVenda.strCodPor);
    fltQuantiPro       := 0;

    Try
      pCarregaQueryEmpresa(qryGenEmp);

      If fEmptyStr(fatVenda.strCliNom) And (Not fatVenda.blnNCFornecedor) Then
        fatVenda.strCliNom := fRetNomCliente(fatVenda.strCodCli)
      Else If fEmptyStr(fatVenda.strCliNom) And (fatVenda.blnNCFornecedor) Then
        fatVenda.strCliNom := fRetNomFornecedor(fatVenda.strCodCli);

      fatVenda.intTemSub := IIF(fVerificaSituacaoTributaria(fatVenda), 1, 0);
      fatVenda.intTemTri := IIF(Not fatVenda.fApenasSubstituicao, 1, 0);
      fatVenda.intInflam := IIF(fVerificaItemInflamavel(fatVenda), 1, 0);

      {*****************************************}
      {* SE FOR DOCUMENTO A PRAZO              *}
      {**************************************MV*}
      If (fStatusCndPag(fatVenda.strConPag) = A_PRAZO) Then
      Begin

        {*****************************************}
        {* MONTA AS MATRIZES COM VALORES DAS DU- *}
        {* PLICATAS                              *}
        {**************************************MV*}
        If (fatVenda.fltDupRec > 0.0) Then
        Begin
          arrNumDup[00] := fatVenda.strNumDoc + arrDuplicata[00].strSequen;;
          arrDtaDup[00] := DateToStr(VS_Date);
          arrValDup[00] := fatVenda.fltDupRec;
          intQtdDup     := 10;
        End
        Else
          intQtdDup := 11;

        If (fatVenda.blnNotEsp) Then
          fDigDuplic(arrDuplicata, fatVenda.strConPag, 0, fatVenda.fltTotGer, False, FAlse, False, VS_Date, False);

        For intContador := 0 To intQtdDup Do
        Begin
          If (intContador = 0) And (fatVenda.fltDupRec <= 0.0) Then
          Begin
            blnAtualiza := True;
          End
          Else
            blnAtualiza := True;

          intIndice := intContador;
          If (fatVenda.fltDupRec > 0.0) Then
            intIndice := intIndice + 1;

          If blnAtualiza Then
          Begin
            arrNumDup[intIndice] := fatVenda.strNumDoc + arrDuplicata[intContador].strSequen;
            arrDtaDup[intIndice] := arrDuplicata[intContador].dtaDtaVen;
            arrValDup[intIndice] := arrDuplicata[intContador].curValor;
          End;

        End;
      End
      Else
      Begin
        {*******************************************}
        {* DOCUMENTO A VISTA ESCREVE "A VISTA"     *}
        {****************************************MV*}
        For intContador := 0 To 11 Do
        Begin
          arrNumDup[intContador] := '';
          arrDtaDup[intContador] := '';
          arrValDup[intContador] := 0.0;
        End;
        arrNumDup[0] := 'A VISTA';
      End;

      {*************************************}
      {* RETORNA VALOR DA NOTA POR EXTENSO *}
      {**********************************LB*}
      fatVenda.strVlrExt := AnsiUpperCase(fRetExtensoNumero(FloatToStrF(fatVenda.fltTotGer,ffNumber,12,2)));

      {*****************************************}
      {* ALIMENTA AS VARIÁVEIS DO NÚMERO DA DU-*}
      {* PLICATA                               *}
      {**************************************MV*}
      fatVenda.strNumD01 := arrNumDup[00];
      fatVenda.strNumD02 := arrNumDup[01];
      fatVenda.strNumD03 := arrNumDup[02];
      fatVenda.strNumD04 := arrNumDup[03];
      fatVenda.strNumD05 := arrNumDup[04];
      fatVenda.strNumD06 := arrNumDup[05];
      fatVenda.strNumD07 := arrNumDup[06];
      fatVenda.strNumD08 := arrNumDup[07];
      fatVenda.strNumD09 := arrNumDup[08];
      fatVenda.strNumD10 := arrNumDup[09];
      fatVenda.strNumD11 := arrNumDup[10];
      fatVenda.strNumD12 := arrNumDup[11];

      {*****************************************}
      {* ALIMENTA AS VARIÁVEIS DA DATA DE VEN- *}
      {* CIMENTO                               *}
      {**************************************MV*}
      fatVenda.strDtaV01 := arrDtaDup[00];
      fatVenda.strDtaV02 := arrDtaDup[01];
      fatVenda.strDtaV03 := arrDtaDup[02];
      fatVenda.strDtaV04 := arrDtaDup[03];
      fatVenda.strDtaV05 := arrDtaDup[04];
      fatVenda.strDtaV06 := arrDtaDup[05];
      fatVenda.strDtaV07 := arrDtaDup[06];
      fatVenda.strDtaV08 := arrDtaDup[07];
      fatVenda.strDtaV09 := arrDtaDup[08];
      fatVenda.strDtaV10 := arrDtaDup[09];
      fatVenda.strDtaV11 := arrDtaDup[10];
      fatVenda.strDtaV12 := arrDtaDup[11];

      {*****************************************}
      {* ALIMENTA AS VARIÁVEIS DO VALOR DAS DU-*}
      {* PLICATAS                              *}
      {**************************************MV*}
      fatVenda.fltValD01 := arrValDup[00];
      fatVenda.fltValD02 := arrValDup[01];
      fatVenda.fltValD03 := arrValDup[02];
      fatVenda.fltValD04 := arrValDup[03];
      fatVenda.fltValD05 := arrValDup[04];
      fatVenda.fltValD06 := arrValDup[05];
      fatVenda.fltValD07 := arrValDup[06];
      fatVenda.fltValD08 := arrValDup[07];
      fatVenda.fltValD09 := arrValDup[08];
      fatVenda.fltValD10 := arrValDup[09];
      fatVenda.fltValD11 := arrValDup[10];
      fatVenda.fltValD12 := arrValDup[11];

      intQtdImp := 0;
      intQtdIte := Length(fatVenda.arrMatItens);
      fltQuantiIte := intQtdIte;

      fatVenda.fltTotPar := 0.0;

      intQtdNot := intQtdIte Div fCfgSis('ITENOT', varInteger);
      If (intQtdIte -  (intQtdNot * fCfgSis('ITENOT', varInteger)) > 0) Then
      Begin
        Inc(intQtdNot);
      End;

      If (intQtdNot = 0) Then
        intQtdNot := 1;

      strTipNot := 'NC';

      intLinhaAtu := 0;
      intLinha    := 0;

      fatVenda.strCndFor := fFormataCondPag(fatVenda.strConPag);

      Screen.Cursor := crHourGlass;

      {**************************************}
      {* CARREGANDO AS CONFIGURACOES CNF_NF *}
      {***********************************AN*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CNF_NF ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CNF_TIPNOT = :TIPNOT AND ';
      strSQL := strSQL + '  CNF_CODEMP = :CODEMP ';
      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  CNF_IDENTI, ';
      strSQL := strSQL + '  CNF_LINIMP, ';
      strSQL := strSQL + '  CNF_COLIMP, ';
      strSQL := strSQL + '  CNF_CODSEQ  ';

      qryCnfNf := fCriarQuery(strSQL);

      fatVenda.intQtdNot     := intQtdNot;
      cdsVenda.First;

      For intContador := 1 To intQtdNot Do
      Begin

        intLinha := 0;
        fatVenda.fltTotpar := 0.0;
        fatVenda.intNotAtu := intContador;

        fatVenda.pAtualizaCamposUso(cpuCampos, qryGenEmp);

        With qryCnfNf Do
        Begin
          Close;
          ParamByName('TIPNOT').AsString := strTipNot;
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          Open;
          First;

          intColMar := FieldByName('CNF_MARGEM').AsInteger;
          intLinTop := FieldByName('CNF_LINTOP').AsInteger;

          If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '00']), [loPartialKey]) Then
          Begin

            While (Not Eof)                                   And
                  (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                  (FieldByName('CNF_IDENTI').AsString = '00') Do
            Begin
              pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, fatVenda.strNomImp, qryCnfNf);
            End;

          End;

          If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '01']), [loPartialKey]) Then
          Begin

            While (Not Eof)                                   And
                  (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                  (FieldByName('CNF_IDENTI').AsString = '01') Do
            Begin
              pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, fatVenda.strNomImp, qryCnfNf);
            End;

          End;

          {*****************************************}
          {* FAZ IMPRESSÃO DOS ITENS               *}
          {**************************************MV*}
          cdsVenda.DisableControls;

          intLinha := qryCnfNf.FieldByName('CNF_LINIMP').AsInteger;

          While Not cdsVenda.Eof Do
          Begin

            If (fCfgSis('USASER', varBoolean)) Then
            Begin
              If fEhItemServico(cdsVenda.FieldByName('ITE_CODITE').AsString) Then
              Begin
                cdsVenda.Next;
                Continue;
              End;
            End;

            fatVenda.pAtualizaCamposUso(cpuCampos, qryGenEmp);

            If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '02']), [loPartialKey]) Then
            Begin

              While (Not Eof)                                   And
                    (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                    (FieldByName('CNF_IDENTI').AsString = '02') Do
              Begin
                pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, fatVenda.strNomImp, qryCnfNf);
              End;

            End;

            fltQuantiPro := fltQuantiPro + cdsVenda.FieldByName('ITE_QTDITE').AsFloat;
            cdsVenda.Next;

            Inc(intQtdImp);
            fatVenda.fltTotPar := fatVenda.fltTotPar + cdsVenda.FieldByName('ITE_TOTITE').AsFloat;

            {*****************************************}
            {* CASO IMPRIMIU A QUANTIDADE DE ITENS   *}
            {* QUE CABE NA NOTA, IMPRIME OS RODAPÉS  *}
            {**************************************MV*}
            If (intQtdImp = fCfgSis('ITENOT', varInteger)) Then
            Begin
              intQtdImp := 0;
              Break;
            End;

          End; //End do While do CadIte

          cdsVenda.EnableControls;
          Inc(intLinhaAtu, 1);

          fatVenda.strQtdPro := FloatToStr(fltQuantiPro);
          fatVenda.strQtdIte := FloatToStr(fltQuantiIte);

    //      intLinha := 0;

          If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '03']), [loPartialKey]) Then
          Begin

            While (Not Eof)                                   And
                  (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                  (FieldByName('CNF_IDENTI').AsString = '03') Do
            Begin
              pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, fatVenda.strNomImp, qryCnfNf);
            End;

          End;

          If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '04']), [loPartialKey]) Then
          Begin

            While (Not Eof)                                   And
                  (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                  (FieldByName('CNF_IDENTI').AsString = '04') Do
            Begin
              pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, fatVenda.strNomImp, qryCnfNf);
            End;
          End;

          If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '05']), [loPartialKey]) Then
          Begin

            While (Not Eof)                                   And
                  (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                  (FieldByName('CNF_IDENTI').AsString = '05') Do
            Begin
              pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, fatVenda.strNomImp, qryCnfNf);
            End;
          End;

          If Locate('CNF_TIPNOT;CNF_IDENTI', VarArrayOf([strTipNot, '99']), [loPartialKey]) Then
          Begin

            While (Not Eof)                                   And
                  (FieldByName('CNF_TIPNOT').AsString = strTipNot) And
                  (FieldByName('CNF_IDENTI').AsString = '99') Do
            Begin
              pI_LinhasNota(fatVenda, cpuCampos, intLinhaAtu, intLinha, fatVenda.strNomImp, qryCnfNf);
            End;
          End;

        End; // End do With

      End; // End do For

      Screen.Cursor := crDefault;

    Except

      On E: EInOutError Do
      Begin
        If (E.ErrorCode = 53) Then
        Begin
          strArqTxt := '';
          Raise Exception.Create('Impressora indisponível');
        End
        Else
        Begin
          strArqTxt := '';
          Raise Exception.Create(E.Message);
        End;
      End;

      On E: Exception Do
      Begin
        strArqTxt := '';
        Raise Exception.Create(E.Message);
      End;
    End;
    strArqTxt := '';

  Finally
    FreeAndNil(qryGenEmp);

    If Assigned(cpuCampos) Then
      FreeAndNil(cpuCampos);

    If Assigned(qryCnfNf) Then
      FreeAndNil(qryCnfNf);
  End;

end;

procedure TReimpressao.pCarregaEndEntregaCobranca(Var fatVenda: TFatVenda; strNomTab, strAutInc: String);
 Var
   qryGen: TUniQuery;
   endEntEntreg: TEnderecoEntrega;
Begin
  qryGen := fCriaQuery;

  With qryGen, Sql Do
  Begin
    Clear;
    Add('SELECT SQL_NO_CACHE ');
    Add('  CLI_ENDCOB,  ');
    Add('  CLI_BAICOB,  ');
    Add('  CLI_CIDCOB,  ');
    Add('  CLI_CEPCOB   ');

    Add('FROM           ');
    Add('  CADCLI       ');
    Add('WHERE          ');
    Add('  CLI_CODCLI = :CODCLI ');

    ParamByName('CODCLI').AsString := fatVenda.strCodCli;
    Open;

    If Not IsEmpty Then
    Begin
      fatVenda.strEndCob := FieldByName('CLI_ENDCOB').AsString;                   //         - Endereco de Cobrança
      fatVenda.strBaiCob := FieldByName('CLI_BAICOB').AsString;                   //         - Bairro de Cobrança
      fatVenda.strCidCob := fRetNomCidade(FieldByName('CLI_CIDCOB').AsString);    //         - Cidade Cobrança
      fatVenda.strEstCob := fRetNomCidade(FieldByName('CLI_CIDCOB').AsString,1 ); //         - Estado Cobrança
      fatVenda.strCepCob := FieldByName('CLI_CEPCOB').AsString;
    End;

  End;

  endEntEntreg := TEnderecoEntrega.Create(Application);
  With qryGen Do
  Begin
    Close;

    SQL.Text :=  endEntEntreg.fCarregaEnderecoEntrega(strNomTab);

    ParamByName('AUTINC').AsString := strAutInc;
    ParamByName('CODCLI').AsString := fatVenda.strCodCli;
    Open;

    First;

    If Not IsEmpty Then
    Begin
      fatVenda.strEndEnt := FieldByName('ETC_ENDENT').AsString;                   //         - Endereco de Entrega
      fatVenda.strBaiEnt := FieldByName('ETC_BAIENT').AsString;                   //         - Bairro de Entrega
      fatVenda.strCidEnt := fRetNomCidade(FieldByName('ETC_CIDENT').AsString);    //         - Cidade Entrega
      fatVenda.strEstEnt := fRetNomCidade(FieldByName('ETC_CIDENT').AsString,1 ); //         - Estado Entrega
      fatVenda.strCepEnt := FieldByName('ETC_CEPENT').AsString;
      fatVenda.strRefEnt := FieldByName('ETC_REFENT').AsString;

      If Not fEmptyStr(FieldByName('ETC_COBISS').AsString) Then
        fatVenda.strCobIss := FieldByName('ETC_COBISS').AsString;

      If Not fEmptyStr(FieldByName('ETC_CODOBR').AsString) Then
        fatVenda.strCodObr := FieldByName('ETC_CODOBR').AsString;

      If Not fEmptyStr(FieldByName('ETC_CODART').AsString) Then
        fatVenda.strCodArt := FieldByName('ETC_CODART').AsString;
    End;

  End;

  FreeAndNil(endEntEntreg);
  FreeAndNil(qryGen);
End;

function TReimpressao.fTotalRecebidoPedido(strNumDoc, strEspDoc: String): Double;
  Var
    qryAux: TUniQuery;
    strEmpPed: String;
begin
  qryAux := fCriaQuery;

  qryAux.SQL.Add('SELECT SQL_NO_CACHE        ');
  qryAux.SQL.Add('  FGO_NUMDOC,              ');
  qryAux.SQL.Add('  FGO_ESPDOC,              ');
  qryAux.SQL.Add('  FGO_CODEMP,              ');
  qryAux.SQL.Add('  FGO_CODCLI               ');
  qryAux.SQL.Add('FROM                       ');
  qryAux.SQL.Add('  FATGOR                   ');
  qryAux.SQL.Add('WHERE                      ');
  qryAux.SQL.Add('  FGO_NUMFAT = :NUMFAT AND ');
  qryAux.SQL.Add('  FGO_TIPFAT = :TIPFAT AND ');
  qryAux.SQL.Add('  FGO_EMPFAT = :CODEMP     ');

  qryAux.ParamByName('NUMFAT').AsString := strNumDoc;
  qryAux.ParamByName('TIPFAT').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.Open;

  Result := TFatVenda.fTotalDuplicataQuitada(qryAux.FieldByName('FGO_NUMDOC').AsString,
                                             qryAux.FieldByName('FGO_ESPDOC').AsString,
                                             qryAux.FieldByName('FGO_CODEMP').AsString,
                                             qryAux.FieldByName('FGO_CODCLI').AsString);
  strEmpPed := qryAux.FieldByName('FGO_CODEMP').AsString;

  qryAux.Close;
  FreeAndNil(qryAux);
end;

function TReimpressao.fGetSqlOutrasSaidasFornecedor(strNumDoc,
                                                    strEspDoc: String;
                                                    dtaDtaIni,
                                                    dtaDtaFin: TDateTime;
                                                    strCodCli,
                                                    strCodEmp,
                                                    strCodVen,
                                                    strTip_Fc: String;
                                                    intFilCla: Integer;
                                                    blnCancelamento: Boolean;
                                                    blnExiDocsCanc: Boolean;
                                                    strNumCoo: String;
                                                    strSerie : String): String;


  Var
    strSQL: String;
    objTSQLGarantiaRetornoFornecedor: TSQLGarantiaRetornoFornecedor;
Begin
  {*******************************}
  {* SELECT NAS TABELAS MOVGER/X *}
  {****************************AF*}
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  GER_SERIE_ AS SERIE_, ';
  strSQL := strSQL + '  IF(GER_NUMFAT IS NULL OR GER_NUMFAT = "", " ", CONCAT(GER_NUMFAT, "-", GER_TIPFAT, "-", GER_EMPFAT)) AS NUMFAT, ';
  strSQL := strSQL + '  CAST(" "  AS CHAR(100)) AS SITUACAO, ';

  If blnExiDocsCanc Then
  Begin
    strSQL := strSQL + '  "C" AS DOCCAN, ';
    strSQL := strSQL + '  MOVGER.MOTDEL AS MOTDEL, ';
    strSQL := strSQL + '  DATE_FORMAT(MOVGER.DTADEL,"%d/%m/%Y") AS DTADEL, ';
    strSQL := strSQL + '  MOVGER.OPEDEL AS OPEDEL, ';
  End
  Else
  Begin
    strSQL := strSQL + '  " " AS DOCCAN, ';
    strSQL := strSQL + '  " " AS MOTDEL, ';
    strSQL := strSQL + '  " " AS DTADEL, ';
    strSQL := strSQL + '  " " AS OPEDEL, ';
  End;

  strSQL := strSQL + '  GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  GER_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  GER_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  " " AS ESAJML, ';
  strSQL := strSQL + '  GER_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  CAST(GER_CODVEN AS CHAR(64)) AS CODVEN, ';
  strSQL := strSQL + '  GER_CODFOR AS CODCLI, ';
  strSQL := strSQL + '  GER_VPAR01 AS VPAR01, ';
  strSQL := strSQL + '  GER_VPAR02 AS VPAR02, ';
  strSQL := strSQL + '  GER_VPAR03 AS VPAR03, ';
  strSQL := strSQL + '  GER_VPAR04 AS VPAR04, ';
  strSQL := strSQL + '  GER_VPAR05 AS VPAR05, ';
  strSQL := strSQL + '  GER_VPAR06 AS VPAR06, ';
  strSQL := strSQL + '  GER_VPAR07 AS VPAR07, ';
  strSQL := strSQL + '  GER_VPAR08 AS VPAR08, ';
  strSQL := strSQL + '  GER_VPAR09 AS VPAR09, ';
  strSQL := strSQL + '  GER_VPAR10 AS VPAR10, ';
  strSQL := strSQL + '  GER_VPAR11 AS VPAR11, ';
  strSQL := strSQL + '  GER_VPAR12 AS VPAR12, ';
  strSQL := strSQL + '  " "         AS CODREG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  FOR_NOMFOR AS CLIORI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS I_M_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  ""         AS PRORUR, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  ""         AS MICEMP, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS ORGPUB, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS DESPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS ZONFRA, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS DESZON, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS PERMUT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS CODZFM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CAST(" " AS CHAR(1)) AS EXPIND, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS CONSUM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  1          AS TABPRE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODDIG AS CODDIG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  " "         AS CODREP, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CONPAG AS CONPAG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODCND AS CODCND, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODFPG AS CODFPG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CLAFIS AS CLAFIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_TOTPRO AS TOTPRO, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTCUS AS TOTCUS, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_DESESP AS DESESP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PORDES AS PORDES, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASRET AS BASRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQRET AS ALQRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTRET AS TOTRET, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  0          AS RET_SP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  0          AS BARTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  0          AS VLRTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASICM AS BASICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQICM AS ALQICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTICM AS TOTICM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASIPI AS BASIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ALQIPI AS ALQIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTIPI AS TOTIPI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_CODTRA AS CODTRA, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TIPFRE AS TIPFRE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_TOTFRE AS TOTFRE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PESBRU AS PESBRU, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_PESLIQ AS PESLIQ, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_VOLUME AS VOLUME, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_NCONHE AS NCONHE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_BASSIM AS BASSIM, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MARCA_ AS MARCA_, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_ESPECI AS ESPECI, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN001 AS MEN001, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN002 AS MEN002, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN003 AS MEN003, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN004 AS MEN004, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_MEN005 AS MEN005, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_CLAFI2 AS CLAFI2, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_CLAFI3 AS CLAFI3, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  GER_NATOPE AS NATOPE, '; // USADO PARA REIMPRESSAO DE NOTA
  strSQL := strSQL + '  MOVGER.AUTOINCREM AS AUTINC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  CAST(IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",GER_CGCCPF, FOR_CGCCPF) AS UNSIGNED) AS CGCCPF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",GER_NOMCON, FOR_NOMFOR) AS CLINOM, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",GER_ENDCON, FOR_ENDERE) AS ENDERE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%","", FOR_ENDNUM) AS ENDNUM, ';         // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%","", FOR_ENDCOM) AS ENDCOM, ';         // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",GER_BAICON, FOR_BAIRRO) AS BAIRRO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",GER_CEPCON, FOR_C_E_P_) AS C_E_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",GER_CIDCON, FOR_CODCID) AS CODCID, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",GER_TELCON, FOR_FONE01) AS FONE01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",GER_R_GCON, ""        ) AS NUM_RG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",GER_CGCCON, FOR_C_G_C_) AS C_G_C_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",GER_IESCON, FOR_I_E_S_) AS I_E_S_, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",GER_NOMCON, CONCAT(GER_CODFOR,"-",FOR_NOMFOR)) AS NOMCLI, ';
  strSQL := strSQL + '  "N"        AS DIFERI, ';
  strSQL := strSQL + '  "N"        AS DIF_ST, ';
  strSQL := strSQL + '  "T"        AS SITP_C, ';
  strSQL := strSQL + '  ""         AS MENP_C, ';
  strSQL := strSQL + '  0.00       AS REDICM, ';
  strSQL := strSQL + '  0.00       AS DESOPE, ';
  strSQL := strSQL + '  ""         AS COBISS, ';  
  strSQL := strSQL + '  ""         AS CODOBR, ';
  strSQL := strSQL + '  ""         AS CODART, ';
  strSQL := strSQL + '  FOR_CODATI AS CODATI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS01 AS CODS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS02 AS CODS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS03 AS CODS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS04 AS CODS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS05 AS CODS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS06 AS CODS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS07 AS CODS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS08 AS CODS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS09 AS CODS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS10 AS CODS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS11 AS CODS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS12 AS CODS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS13 AS CODS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS14 AS CODS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS15 AS CODS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS16 AS CODS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS17 AS CODS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS18 AS CODS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS19 AS CODS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS20 AS CODS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS21 AS CODS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS22 AS CODS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS23 AS CODS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS24 AS CODS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS25 AS CODS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS26 AS CODS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS27 AS CODS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS28 AS CODS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS29 AS CODS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CODS30 AS CODS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_DESS01 AS DESS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS02 AS DESS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS03 AS DESS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS04 AS DESS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS05 AS DESS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS06 AS DESS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS07 AS DESS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS08 AS DESS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS09 AS DESS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS10 AS DESS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS11 AS DESS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS12 AS DESS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS13 AS DESS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS14 AS DESS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS15 AS DESS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS16 AS DESS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS17 AS DESS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS18 AS DESS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS19 AS DESS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS20 AS DESS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS21 AS DESS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS22 AS DESS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS23 AS DESS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS24 AS DESS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS25 AS DESS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS26 AS DESS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS27 AS DESS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS28 AS DESS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS29 AS DESS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESS30 AS DESS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_VALS01 - IF(IFNULL(GER_DECS01,0) <> 0, (IFNULL(GER_VALS01,0) * (IFNULL(GER_DECS01,0) / 100)), 0) AS VALS01, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS02 - IF(IFNULL(GER_DECS03,0) <> 0, (IFNULL(GER_VALS02,0) * (IFNULL(GER_DECS02,0) / 100)), 0) AS VALS02, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS03 - IF(IFNULL(GER_DECS03,0) <> 0, (IFNULL(GER_VALS03,0) * (IFNULL(GER_DECS03,0) / 100)), 0) AS VALS03, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS04 - IF(IFNULL(GER_DECS04,0) <> 0, (IFNULL(GER_VALS04,0) * (IFNULL(GER_DECS04,0) / 100)), 0) AS VALS04, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS05 - IF(IFNULL(GER_DECS05,0) <> 0, (IFNULL(GER_VALS05,0) * (IFNULL(GER_DECS05,0) / 100)), 0) AS VALS05, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS06 - IF(IFNULL(GER_DECS06,0) <> 0, (IFNULL(GER_VALS06,0) * (IFNULL(GER_DECS06,0) / 100)), 0) AS VALS06, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS07 - IF(IFNULL(GER_DECS07,0) <> 0, (IFNULL(GER_VALS07,0) * (IFNULL(GER_DECS07,0) / 100)), 0) AS VALS07, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS08 - IF(IFNULL(GER_DECS08,0) <> 0, (IFNULL(GER_VALS08,0) * (IFNULL(GER_DECS08,0) / 100)), 0) AS VALS08, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS09 - IF(IFNULL(GER_DECS09,0) <> 0, (IFNULL(GER_VALS09,0) * (IFNULL(GER_DECS09,0) / 100)), 0) AS VALS09, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS10 - IF(IFNULL(GER_DECS10,0) <> 0, (IFNULL(GER_VALS10,0) * (IFNULL(GER_DECS10,0) / 100)), 0) AS VALS10, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS11 - IF(IFNULL(GER_DECS11,0) <> 0, (IFNULL(GER_VALS11,0) * (IFNULL(GER_DECS11,0) / 100)), 0) AS VALS11, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS12 - IF(IFNULL(GER_DECS13,0) <> 0, (IFNULL(GER_VALS12,0) * (IFNULL(GER_DECS12,0) / 100)), 0) AS VALS12, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS13 - IF(IFNULL(GER_DECS13,0) <> 0, (IFNULL(GER_VALS13,0) * (IFNULL(GER_DECS13,0) / 100)), 0) AS VALS13, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS14 - IF(IFNULL(GER_DECS14,0) <> 0, (IFNULL(GER_VALS14,0) * (IFNULL(GER_DECS14,0) / 100)), 0) AS VALS14, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS15 - IF(IFNULL(GER_DECS15,0) <> 0, (IFNULL(GER_VALS15,0) * (IFNULL(GER_DECS15,0) / 100)), 0) AS VALS15, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS16 - IF(IFNULL(GER_DECS16,0) <> 0, (IFNULL(GER_VALS16,0) * (IFNULL(GER_DECS16,0) / 100)), 0) AS VALS16, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS17 - IF(IFNULL(GER_DECS17,0) <> 0, (IFNULL(GER_VALS17,0) * (IFNULL(GER_DECS17,0) / 100)), 0) AS VALS17, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS18 - IF(IFNULL(GER_DECS18,0) <> 0, (IFNULL(GER_VALS18,0) * (IFNULL(GER_DECS18,0) / 100)), 0) AS VALS18, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS19 - IF(IFNULL(GER_DECS19,0) <> 0, (IFNULL(GER_VALS19,0) * (IFNULL(GER_DECS19,0) / 100)), 0) AS VALS19, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS20 - IF(IFNULL(GER_DECS20,0) <> 0, (IFNULL(GER_VALS20,0) * (IFNULL(GER_DECS20,0) / 100)), 0) AS VALS20, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS21 - IF(IFNULL(GER_DECS21,0) <> 0, (IFNULL(GER_VALS21,0) * (IFNULL(GER_DECS21,0) / 100)), 0) AS VALS21, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS22 - IF(IFNULL(GER_DECS23,0) <> 0, (IFNULL(GER_VALS22,0) * (IFNULL(GER_DECS22,0) / 100)), 0) AS VALS22, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS23 - IF(IFNULL(GER_DECS23,0) <> 0, (IFNULL(GER_VALS23,0) * (IFNULL(GER_DECS23,0) / 100)), 0) AS VALS23, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS24 - IF(IFNULL(GER_DECS24,0) <> 0, (IFNULL(GER_VALS24,0) * (IFNULL(GER_DECS24,0) / 100)), 0) AS VALS24, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS25 - IF(IFNULL(GER_DECS25,0) <> 0, (IFNULL(GER_VALS25,0) * (IFNULL(GER_DECS25,0) / 100)), 0) AS VALS25, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS26 - IF(IFNULL(GER_DECS26,0) <> 0, (IFNULL(GER_VALS26,0) * (IFNULL(GER_DECS26,0) / 100)), 0) AS VALS26, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS27 - IF(IFNULL(GER_DECS27,0) <> 0, (IFNULL(GER_VALS27,0) * (IFNULL(GER_DECS27,0) / 100)), 0) AS VALS27, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS28 - IF(IFNULL(GER_DECS28,0) <> 0, (IFNULL(GER_VALS28,0) * (IFNULL(GER_DECS28,0) / 100)), 0) AS VALS28, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS29 - IF(IFNULL(GER_DECS29,0) <> 0, (IFNULL(GER_VALS29,0) * (IFNULL(GER_DECS29,0) / 100)), 0) AS VALS29, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALS30 - IF(IFNULL(GER_DECS30,0) <> 0, (IFNULL(GER_VALS30,0) * (IFNULL(GER_DECS30,0) / 100)), 0) AS VALS30, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_PRAENT AS PRAENT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_TOTSER AS TOTSER, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALISS AS VALISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PERISS AS PERISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_HORENT AS HORENT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_DESACE AS DESACE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQIRF AS ALQIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALIRF AS VALIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQPIS AS ALQPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALPIS AS VALPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQCOF AS ALQCOF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALCOF AS VALCOF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ALQCSL AS ALQCSL, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VALCSL AS VALCSL, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  0  AS RETPCO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0  AS RETIRF, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0  AS RETISS, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0  AS SEGSOC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0  AS CDESPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0  AS SITIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0  AS ENQIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0  AS MENIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0  AS ORPURD, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0  AS CALICM, '; // USADO PARA REIMPRESSÃO DE NOTA

  strSQL := strSQL + '  GER_NOTRET AS NOTRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRFRET AS IRFRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISRET AS PISRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COFRET AS COFRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSLRET AS CSLRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_SERRET AS SERRET, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_NORESE AS NORESE, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRPRRT AS IRPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRPRDV AS IRPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRSERT AS IRSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_IRSEDV AS IRSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PIPRRT AS PIPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PIPRDV AS PIPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISERT AS PISERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PISEDV AS PISEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COPRRT AS COPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COPRDV AS COPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COSERT AS COSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_COSEDV AS COSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSPRRT AS CSPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSPRDV AS CSPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSSERT AS CSSERT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_CSSEDV AS CSSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_VLSGSO AS VLSGSO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_PESGSO AS PESGSO, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  0000000.00 AS DUPREC, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_BASORG AS BASORG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ICMORG AS ICMORG, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_ENTFAT AS ENTFAT, '; // USADO PARA REIMPRESSÃO DE NOTA
  strSQL := strSQL + '  GER_NOTESP AS NOTESP, ';
  strSQL := strSQL + '  "MOVGER     "  AS TABELA, ';
  strSQL := strSQL + '  GER_TIP_FC AS TIP_FC, ';
  strSQL := strSQL + '  GER_ORIDOC AS ORIDOC, ';
  strSQL := strSQL + '  GER_VLRCON AS VLRCON, ';
  strSQL := strSQL + '  " " AS DOCORI,         ';
  strSQL := strSQL + '  "S" AS DOCFOR,  ';
  strSQL := strSQL + '  GER_NROCEI AS NROCEI,  ';
  strSQL := strSQL + '  CAST(" " AS CHAR(20)) AS ORDPRO         ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGER ';
  strSQL := strSQL + '  LEFT JOIN SERMOV ON GER_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '  JOIN CADFOR ON GER_CODFOR = FOR_CODFOR ';

  if not fEmptyStr(strNumCoo) Then
  Begin
    strSQL := strSQL + ' INNER JOIN CADFIS ON FIS_NUMDOC = GER_NUMDOC AND ';
    strSQL := strSQL + '                      FIS_ESPDOC = GER_ESPDOC AND ';
    strSQL := strSQL + '                      FIS_CODEMP = GER_CODEMP AND ';
    strSQL := strSQL + '                      FIS_FORCLI = IF(FIS_TIP_FC = "C", GER_CODCLI, GER_CODFOR) AND ';
    strSQL := strSQL + '                      FIS_SERIE_ = GER_SERIE_     ';
  End;

  strSQL := strSQL + 'WHERE ';

  if not fEmptyStr(strNumCoo) Then
    strSQL := strSQL + ' FIS_NUMCOO = ' + QuotedStr(strNumCoo) + ' AND ';

  strSQL := strSQL + '  GER_ESPDOC   <> "PD"    AND ';
  strSQL := strSQL + '  GER_ESPDOC   <> "GA"    AND ';
  strSQL := strSQL + '  GER_ESPDOC   <> "TM"    AND ';
  strSQL := strSQL + '  GER_ESPDOC   <> "PR"    AND ';
  strSQL := strSQL + '  IF(GER_ESPDOC = "ML" AND  GER_TIPFAT = "AJ", TRUE, GER_ESPDOC <> "ML") AND ';
  strSQL := strSQL + '  GER_ESPDOC   <> "AB"    AND ';
  strSQL := strSQL + '  GER_ESPDOC   <> "RO"    AND ';

  Case intFilCla Of
    1: strSQL := strSQL + '  LOCATE(GER_CLAFIS, "' + VS_strClaVen + '") > 0 AND ';
    2: strSQL := strSQL + '  LOCATE(GER_CLAFIS, "' + VS_strClaDev + '") > 0 AND ';
    3: strSQL := strSQL + ' (LOCATE(GER_CLAFIS, "' + VS_strClaVen + '") <= 0) AND (LOCATE(GER_CLAFIS, "' + VS_strClaDev + '") <= 0) AND ';
  End;

  If FFiltNE Then
  Begin
    objTSQLGarantiaRetornoFornecedor:= TSQLGarantiaRetornoFornecedor.Create;
    Try
      strSQL := strSQL + ' ( ';

      strSQL := strSQL + ' (GER_ORIDOC IN ("V","C")) OR (LOCATE(GER_ESPDOC, "AJ_RQ_TA_TL_BE_GR_") > 0) OR ';

      strSQL:= strSQL + objTSQLGarantiaRetornoFornecedor.fRetornaFiltroGarantiaRetornoFornecedorNF;

      strSQL:= strSQL +' ) AND';
    Finally
      FreeAndNil(objTSQLGarantiaRetornoFornecedor);
    End;
  End;

  {****************************************************************************}
  {* Importante pois estava permitindo cancelar notas de "OF" utilizando a    *}
  {* opção "NF - Nota Fiscal" fazendo o cancelamento do painel dar update no  *}
  {* campo NFE_TIP_FC de "F" para "C"                                         *}
  {**************************************************************03-03-2014*RN*}
  If Not fEmptyStr(strTip_Fc) Then
    strSQL := strSQL + '  GER_TIP_FC = ' + QuotedStr(strTip_Fc) + ' AND '
  Else
    strSQL := strSQL + '  GER_TIP_FC = "F"  AND ';

  If (Not fEmptyStr(strNumDoc)) And (Not fEmptyStr(strEspDoc)) Then
  Begin

    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC ';

    If Not fEmptyStr(strCodVen) Then
      strSQL := strSQL + 'AND GER_CODVEN = :CODVEN ';

    If Not fEmptyStr(strCodEmp) Then
      strSQL := strSQL + 'AND GER_CODEMP = :CODEMP ';

    If (blnCancelamento) And (strTip_Fc = 'F') Then
    Begin
      If strEspDoc <> 'GF' Then
        strSQL := strSQL + ' AND IFNULL(GER_SERIE_, "") = :SERIE_ ';

      strSQL := strSQL + ' AND GER_CODFOR = :CODCLI ';
    End
    Else
    Begin
      If (Not fEmptyStr(strSerie)) Then
        strSQL := strSQL + ' AND IFNULL(GER_SERIE_, "") = :SERIE_ ';

      If Not fEmptyStr(strCodCli) Then
        strSQL := strSQL + ' AND GER_CODFOR = :CODCLI ';
    End;
  End
  Else
  Begin

    strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(strNumDoc) Then
      strSQL := strSQL + 'AND GER_NUMDOC = :NUMDOC ';

    If Not fEmptyStr(strEspDoc) Then
      strSQL := strSQL + 'AND GER_ESPDOC = :ESPDOC ';

    If Not fEmptyStr(strCodEmp) Then
      strSQL := strSQL + 'AND GER_CODEMP = :CODEMP ';

    If Not fEmptyStr(strCodCli) Then
      strSQL := strSQL + 'AND GER_CODFOR = :CODCLI ';

    If Not fEmptyStr(strCodVen) Then
      strSQL := strSQL + 'AND GER_CODVEN = :CODVEN ';

    If (Not fEmptyStr(strSerie)) Then
      strSQL := strSQL + ' AND IFNULL(GER_SERIE_, "") = :SERIE_ ';

  End;

  Result := strSQL;
End;

function TReimpressao.fRetDocsOrigFat(strNumDoc, strEspDoc, strCodEmp: String): String;
  Var
    strSql   : String;
    qryBusca : TUniQuery;
begin

  Result := '';

  strSql := '';
  strSql := strSql + ' SELECT SQL_NO_CACHE         ';
  strSql := strSql + '   FGO_NUMDOC                ';
  strSql := strSql + ' FROM                        ';
  strSql := strSql + '  FATGOR                     ';
  strSql := strSql + ' WHERE                       ';
  strSql := strSql + '   FGO_TIPFAT = :ESPDOC AND  ';
  strSql := strSql + '   FGO_NUMFAT = :NUMDOC AND  ';
  strSql := strSql + '   FGO_EMPFAT = :CODEMP AND  ';
  strSql := strSql + '   FGO_JAFATU = 1            ';
  strSql := strSql + ' ORDER BY                    ';
  strSql := strSql + '   FGO_NUMDOC                ';

  qryBusca := fCriaQuery(Nil);

  With qryBusca Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSql);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    While Not Eof Do
    Begin
      Result := Result + Fields[0].AsString + ', ';
      Next;
    End;

    Result := Copy(Result,1, length(Result) - 2);

  End;

  FreeAndNil(qryBusca);

end;

function TReimpressao.fRetCupCha(strNumDoc, strEspDoc, strCodEmp: String): String;
var
  strSQL: String;
  qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FIS_ACESSO  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + ' MOVGER ';
  strSQL := strSQL + 'JOIN CADFIS ON FIS_NUMDOC = GER_NUMDOC AND ';
  strSQL := strSQL + '               FIS_ESPDOC = GER_ESPDOC AND ';
  strSQL := strSQL + '               FIS_CODEMP = GER_CODEMP AND ';
  strSQL := strSQL + '               FIS_FORCLI = GER_CODCLI AND ';
  strSQL := strSQL + '               FIS_TIP_FC = "C" ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMFAT = :NUMDOC AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  GER_TIPFAT = :ESPDOC AND ';
  strSQL := strSQL + '  GER_ESPDOC IN ("IF", "IV") ';

  strSQL := strSQL + 'UNION ALL ' + AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');

  qryGen := fCriaQuery;
  try
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
    qryGen.ParamByName('CODEMP').AsString := strCodEmp;
    qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGen.Open;
    Result := '';
    While Not qryGen.Eof Do
    Begin
      Result := Result + qryGen.FieldByName('FIS_ACESSO').AsString + IIF(qryGen.RecNo < qryGen.RecordCount, ' - ', '');

      qryGen.Next;
    End;
    qryGen.Close;
  finally
    FreeAndNil(qryGen);
  end;
end;

function TReimpressao.fRetCupCon(strNumDoc, strEspDoc, strCodEmp: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_NUMDOC, ';
  strSQL := strSQL + '  GER_ESPDOC, ';
  strSQL := strSQL + '  GER_DTAENT, ';
  strSQL := strSQL + '  FIS_NUMCOO, ';
  strSQL := strSQL + '  FIS_NUMSER  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + ' MOVGER ';
  strSQL := strSQL + 'JOIN CADFIS ON FIS_NUMDOC = GER_NUMDOC AND ';
  strSQL := strSQL + '               FIS_ESPDOC = GER_ESPDOC AND ';
  strSQL := strSQL + '               FIS_CODEMP = GER_CODEMP AND ';
  strSQL := strSQL + '               FIS_FORCLI = GER_CODCLI AND ';
  strSQL := strSQL + '               FIS_TIP_FC = "C" ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMFAT = :NUMDOC AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  GER_TIPFAT = :ESPDOC AND ';
  strSQL := strSQL + '  GER_ESPDOC IN ("IF", "IV") ';

  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;
    Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('ESPDOC').AsString := strEspDoc;
    Open;
    Result := '';
    While Not Eof Do
    Begin
      Result := Result + FieldByName('GER_NUMDOC').AsString + '-' +
                         FieldByName('GER_ESPDOC').AsString + ' de ' +
                         DateToStr(FieldByName('GER_DTAENT').AsDateTime) + ' ' +
                         iif( FieldByName('FIS_NUMCOO').AsString = '', '', ' COO:' + FieldByName('FIS_NUMCOO').AsString ) +
                         iif( FieldByName('FIS_NUMSER').AsString = '', '', ' N.SER: ' + fPadR(FieldByName('FIS_NUMSER').AsString, 20) );

      Next;
    End;
    Close;
  End;
  FreeAndNil(qryGen);
End;

function TReimpressao.fRetTEsConfirmadas(strNumDoc, strEspDoc, strCodEmp: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GROUP_CONCAT(GER_NUMDOC) AS NUMTES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + ' MOVGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMFAT = :NUMDOC AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  GER_TIPFAT = :ESPDOC AND ';
  strSQL := strSQL + '  GER_ESPDOC = "TE" ';

  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;
    Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('ESPDOC').AsString := strEspDoc;
    Open;
    Result := FieldByName('NUMTES').AsString;
    Close;
  End;
  FreeAndNil(qryGen);
End;

function TReimpressao.fRetNumOrc(strNumDoc, strEspDoc, strCodEmp: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  O.GER_NUMDOC ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + ' MOVGER G ';
  strSQL := strSQL + 'INNER JOIN MOVGER O ON';
  strSQL := strSQL + '  O.GER_ESPDOC = "OR"         AND ';
  strSQL := strSQL + '  O.GER_NUMFAT = G.GER_NUMDOC AND ';
  strSQL := strSQL + '  O.GER_TIPFAT = G.GER_ESPDOC AND ';
  strSQL := strSQL + '  O.GER_CODEMP = G.GER_CODEMP     ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  G.GER_NUMFAT = :NUMDOC AND ';
  strSQL := strSQL + '  G.GER_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  G.GER_TIPFAT = :ESPDOC  ';

  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;
    Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('ESPDOC').AsString := strEspDoc;
    Open;
    Result := '';
    While Not Eof Do
    Begin
      Result := Result + FieldByName('GER_NUMDOC').AsString + ' ';
      Next;
    End;
    Close;
  End;
  FreeAndNil(qryGen);
End;

{**********************************************************************}
{*  ATRIBUI INDICE REFERENTE AO ITEM CONFORME LEGENDA ABAIXO          *}
{*                                                                    *}
{*  1 -> TRIBUTACAO DE ICMS   --> TODAS AS OUTRAS                     *}
{*  2 -> TRIBUTACAO DE ISS    --> NAO TEM ITENS NESTA SITUACAO        *}
{*  3 -> ISENTO               --> 040-140-240                         *}
{*  4 -> ICMS SUSPENSO        --> 050-150-250                         *}
{*  5 -> ICMS DIFERIDO        --> 051-151-251                         *}
{*  6 -> SUBSTITUICAO         --> 010-060-070-110-160-170-210-260-270 *}
{*                                                                    *}
{******************************************************************JC**}
procedure TReimpressao.pAtribuiIndiceLegendaTipoSituacao(qryTemporaria: TDataset);
  Var
    IntIndice: Integer;
begin

  With qryTemporaria Do
  Begin
    First;

    While Not Eof Do
    Begin
      If Pos(FieldByName('ABF_CODSIT').AsString, '040_140_240_') > 0 Then
        IntIndice := 3
      Else If Pos(FieldByName('ABF_CODSIT').AsString, '050_150_250_') > 0 Then
        IntIndice := 4
      Else If Pos(FieldByName('ABF_CODSIT').AsString, '051_151_251_') > 0 Then
        IntIndice := 5
      Else If Pos(FieldByName('ABF_CODSIT').AsString, CST_SUBSTITUICAO) > 0 Then
        IntIndice := 6
      Else
        IntIndice := 1;

      Edit;
      FieldByName('ITE_TIPSIT').AsInteger := IntIndice;
      Post;

      Next;
    End;

  End;

end;

function TReimpressao.fImpLocFis(strEspDoc: String): Boolean;
begin
  If (Pos(strEspDoc, 'OR_MI_FF_DV_TR_NF_GC_IF_IV_') > 0) Then
    Result := (Pos(strEspDoc, fCfgSis('IMPLOC')) > 0)
  Else
    Result := False;
end;

function TReimpressao.fImprimeSeparacao(strOpcDoc: String;
                                        blnQtdOri,
                                        blnDocCan,
                                        blnVerCfg: Boolean;
                                        blnExpEnt: Boolean = False;
                                        blnImpPed: Boolean = False;
                                        opcAbastecimento: TOpcAbastecimento = opcTodos;
                                        blnLocFisEmpEmi: Boolean = False;
                                        strPedSepEntRet: String = '';
                                        blnImpBaixaSeparacao: Boolean = False;
                                        intSeqSepPar: Integer = 0): Boolean;
  Var
    strNomeArquivo: String;
    blnPeiMse : Boolean;
    intRespostaFmensagem: integer;
    strEspImpSep: String;
    blnSepPendRomaneio: Boolean;
begin

  Result := False;

  With objDocumentos.cdsDocumentos Do
  Begin

    If (IsEmpty) Or
       ((FindField('DOCCAN') <> NIL) And (FieldByName('DOCCAN').AsString = 'C')) Then
      Exit;

    strEspImpSep := '';

    If (fCfgSis('PEDSEP', varBoolean) Or (Not blnVerCfg)) And (FieldByName('ESPDOC').AsString = 'PD') Then
      strEspImpSep := strEspImpSep + 'PD_';

    If (fCfgSis('SEPORC', varBoolean) Or (Not blnVerCfg)) And (FieldByName('ESPDOC').AsString = 'OR') Then
      strEspImpSep := strEspImpSep + 'OR_';

    If (fCfgSis('VNDSEP', varBoolean) Or (Not blnVerCfg)) Then
      strEspImpSep := strEspImpSep + 'NF_EL_IF_IV_D1_MI_FF_TE_EP_UC_BR_';

    If fCfgSis('SEP_TR', varBoolean) Then
      strEspImpSep := strEspImpSep + 'DV_PR_TR_DD_CR_';

    blnPeiMse := fCfgSis('PEIMSE', varBoolean);

    blnDocSep := False;
    If ((strEspImpSep<>'')                                      And
        (Pos(FieldByName('ESPDOC').AsString, strEspImpSep) > 0) And
        (Pos(strOpcDoc, 'OE_EF_OF_') <= 0)                      And
        (Not blnSeparacaoDireto)                                And
        (FPergSep))                                             Or

       ((FRecCliGar)                                            And
        (strOpcDoc = 'OU')                                      And
        (Pos(FieldByName('ESPDOC').AsString, 'NF_') > 0))       Then  //Se caso for Recebimento de Cliente (Garantia) tem que perguntar se deseja imprimir separação
    Begin
      If (blnPeiMse) Then
        blnDocSep := fMensagem('', 'Deseja imprimir separação?', ['&Sim', '&Não']) = 1
      Else
        blnDocSep := True;
    End;

    If blnDocSep Or blnSeparacaoDireto Then
    Begin
      If (blnTelaReimpressao) Then
      Begin
        objLiberacao.clear;
        objLiberacao.objMsgLibera.pAddTexto('Reimpressão de Separação.');

        objLiberacao.strDirAce := 'REISEP';
        objLiberacao.strSenLib := fCfgSis('REISEP');
        objLiberacao.strMsgSen := 'Reimpressão de Separação.';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := strLoginUsuarioLogado;
        objLiberacao.blnUsarSenhaFixa := False;
        objLiberacao.blnSempreVariavelUsuario := True;

        objLiberacao.pInformaNumDocEspDocCodEmp(
                            FieldByName('NUMDOC').AsString,
                            FieldByName('ESPDOC').AsString,
                            FieldByName('CODEMP').AsString);

        If Not objLiberacao.fLibera Then
          Exit;
      End;

      If (blnSeparacaoDireto) Or
         (blnImpressaoColetor) Then
      Begin
        If fEmptyStr(strTipImp) Then
          strTipImp := 'V';
      End

      Else If fEmptyStr(strTipImp) Then
      Begin
        If (fCfgSis('SEPESP', varBoolean)) And (FieldByName('ESPDOC').AsString = 'PD') Then
          strTipImp := 'V'
        Else Begin
          intRespostaFmensagem := fMensagem('','Saída',['&Video','&Imprimir','&PDF'], fCfgSis('FOCFAT', varInteger));
          if intRespostaFmensagem = 1 then
          begin
            strTipImp := 'V';
          end
          else
          if intRespostaFmensagem = 2 then
          begin
            strTipImp := 'I';
          end
          else
          begin
            strTipImp := 'P';
          end;
        End;
      End;

      If (Not blnSeparacaoDireto) Or (intQtdImp <= 0)Then
      Begin
        intQtdImp := 1;

        If strTipImp <> 'V' Then
        Begin
          If (fCfgSis('VIA_SE') = 'S') Then
          Begin
            intQtdImp := fGetMenu('Qtd. Vias', ['Não Imprimir','1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);

            If intQtdImp = 1 Then
              intQtdImp := -1
            Else
              intQtdImp := intQtdImp - 1;
          End
          Else
          Begin
            If fCfgSis('QTDVSE') > 1 Then
              intQtdImp := fCfgSis('QTDVSE');
          End;
        End;
      End;

      If intQtdImp > 0 Then
      Begin
        blnSepPendRomaneio := False;
        If FOrigemRomaneio And (Pos(fCfgSis('OPCROM'), '2_3_4_') > 0) And fCfgSis('SEPROP', varBoolean) Then
        Begin
          blnSepPendRomaneio := fMensagem('SEPARAÇÃO',
                                          'Imprimir Separação dos produtos:',
                                          ['&Sem romaneio', '&Todos produtos'],
                                          1, False, 1, 150) = 1;
        End;

        pImprimeFatImp(fGetNomeTabela,
                       FieldByName('NUMDOC').AsString,
                       FieldByName('ESPDOC').AsString,
                       FieldByName('CODEMP').AsString,
                       FieldByName('CODCLI').AsString,
                       FieldByName('TIP_FC').AsString,
                       FieldByName('ORIDOC').AsString,
                       blnReimpressaoDaSeparacaoPedido,
                       strNomeArquivo,
                       False,
                       strTipImp,
                       intQtdImp,
                       impComPrecoGeral,
                       0,
                       blnDocSep Or blnSeparacaoDireto,
                       False,
                       True,
                       blnQtdOri,
                       '',
                       '',
                       blnDocCan,
                       blnExpedicao,
                       False,
                       blnExpEnt,
                       False,
                       False,
                       blnImpPed,
                       opcAbastecimento,
                       False,
                       False,
                       False,
                       IIF(fCfgSis('SPLCIT', varBoolean), blnLocFisEmpEmi, True),
                       False,
                       strPedSepEntRet,
                       ' ',
                       Nil,
                       False,
                       '',
                       '',
                       '',
                       blnPreRomaneio,
                       opcNaoAgrupa,
                       False,
                       '',
                       '',
                       False,
                       False,
                       False,
                       '',
                       (strTipImp='P'),
                       False,
                       False,
                       False,
                       False,
                       False,
                       False,
                       '',
                       '',
                       '',
                       False,
                       '',
                       0,
                       0,
                       False,
                       '',
                       True,
                       blnImpBaixaSeparacao,
                       False,
                       EmptyStr,
                       False,
                       blnImpressaoColetor,
                       blnSepPendRomaneio,
                       False,
                       intSeqSepPar);

        Result := True;

      End;

    End;

  End;

end;

function TReimpressao.fGetNomeTabela: String;
begin

  With objDocumentos.cdsDocumentos Do
  Begin

    If IsEmpty Then
      Exit;

    If FieldByName('TABELA').AsString = 'MOVGER' Then
      Result := 'MOVDET'

    Else If FieldByName('TABELA').AsString = 'FATGOR' Then
      Result := 'FATDOR'

    Else If FieldByName('TABELA').AsString = 'NOTGER' Then
      Result := 'NOTDET'

    Else If FieldByName('TABELA').AsString = 'MOVGAG' Then
      Result := 'MOVGAD'

    Else If FieldByName('TABELA').AsString = 'DEL_MOVGER' Then
      Result := 'DEL_MOVDET'

    Else If FieldByName('TABELA').AsString = 'DEL_FATGOR' Then
      Result := 'DEL_FATDOR'

    Else If FieldByName('TABELA').AsString = 'DEL_NOTGER' Then
      Result := 'DEL_NOTDET'

    Else If FieldByName('TABELA').AsString = 'DEL_MOVGAG' Then
      Result := 'DEL_MOVGAD';
  End;

end;

Constructor TDocumentosReimpressao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCdsDoc := TUniClientDataSet.Create(Self);
  FQryDoc := fCriaQuery(Self);
end;

procedure TDocumentosReimpressao.SetSqlDocs(Value: String);
begin
  FSql := Value;
  FQryDoc.SQL.Text := FSql;
end;

destructor TDocumentosReimpressao.Destroy;
begin
  FreeAndNil(FCdsDoc);
  FreeAndNil(FQryDoc);
  inherited Destroy;
end;

procedure TDocumentosReimpressao.pAddFiltro(strNome: String; varValFiltro: Variant);
begin
  If FQryDoc.Params.FindParam(strNome) <> Nil Then
    FQryDoc.ParamByName(strNome).Value := varValFiltro;
end;

procedure TDocumentosReimpressao.pCarregarDocumentos;
  Var
    intCont: Integer;
begin
  FQryDoc.Open;

  If Not FCdsDoc.Active Then
  Begin
    For intCont := 0 To FQryDoc.Fields.Count -1 Do
      With FCdsDoc.FieldDefs.AddFieldDef Do
      Begin
        Name     := FQryDoc.Fields[intCont].FieldName;

        If FQryDoc.Fields[intCont].DataType = (ftLargeint) Then
          DataType := ftInteger
        Else
          DataType := FQryDoc.Fields[intCont].DataType;

        Size     := FQryDoc.Fields[intCont].Size;
      End;

    FCdsDoc.CreateDataSet;
    FCdsDoc.Open;
  End;

  With FQryDoc Do
  Begin
    First;
    While Not Eof Do
    Begin
      FCdsDoc.Append;
      For intCont := 0 To FCdsDoc.Fields.Count -1 Do
        FCdsDoc.Fields[intCont].Value := FieldByName(FCdsDoc.Fields[intCont].FieldName).Value;
      FCdsDoc.Post;
      Next;
    End;
    Close;
  End;

end;

procedure TReimpressao.pAtualizaQtdDocCadFis(intQtdNot: Integer;
  strNumDoc, strEspDoc, strCodEmp, strAutInc: String);
  Var
    strSQL   : String;
    qryGen   : TUniQuery;
    strOriDoc: String;
    strNSerie: String;
    strTip_FC: String;
    strForCli: String;
Begin

  strOriDoc := '';
  strNSerie := '';
  strTip_FC := '';
  strForCli := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT   ';
  strSQL := strSQL + '  SQL_NO_CACHE ';
  strSQL := strSQL + '  GER_ORIDOC,  ';
  strSQL := strSQL + '  GER_TIP_FC,  ';
  strSQL := strSQL + '  GER_SERIE_,  ';
  strSQL := strSQL + '  GER_CODCLI,  ';
  strSQL := strSQL + '  GER_CODFOR   ';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  MOVGER ';
  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  AUTOINCREM = :AUTINC     ';

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Close;
    Clear;
    Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('AUTINC').AsString := strAutInc;
    Open;

    If Not IsEmpty Then
    Begin
      strOriDoc := FieldByName('GER_ORIDOC').AsString;
      strTip_FC := FieldByName('GER_TIP_FC').AsString;
      strNSerie := FieldByName('GER_SERIE_').AsString;

      If SameText(strTip_FC, 'C') Then
        strForCli := FieldByName('GER_CODCLI').AsString
      Else strForCli := FieldByName('GER_CODFOR').AsString;
    End;

    Close;
  End;

  strSQL := '';
  strSQL := strSQL + 'UPDATE   ';
  strSQL := strSQL + '  CADFIS ';
  strSQL := strSQL + 'SET      ';
  strSQL := strSQL + '  FIS_QTDNOT = :QTDNOT     ';
  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '  FIS_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  FIS_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FIS_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  FIS_FORCLI = :FORCLI AND ';
  strSQL := strSQL + '  IFNULL(FIS_SERIE_, "") = :NSERIE AND ';
  strSQL := strSQL + '  FIS_TIP_FC = :TIP_FC AND ';
  strSQL := strSQL + '  FIS_ORIDOC = :ORIDOC     ';

  With qryGen, SQL Do
  Begin
    Close;
    Clear;
    Add(strSQL);

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('FORCLI').AsString := strForCli;
    ParamByName('NSERIE').AsString := strNSerie;
    ParamByName('TIP_FC').AsString := strTip_FC;
    ParamByName('ORIDOC').AsString := strOriDoc;

    ParamByName('QTDNOT').AsInteger := intQtdNot;

    ExecSQL;
  End;

  FreeAndNil(qryGen);
end;

function TReimpressao.fDescontoCliente(strEspDoc, strCodCli: String): Boolean;
begin
  Result := fDescontoClienteProfissional(strCodCli) And (Pos(strEspDoc, 'OR_PD_FF_DV_') > 0);
end;

Procedure pMostraDocumentoReimpressao(strNumDoc, strEspDoc, strCodEmp, strSerie: String; strCodCli: String = ''; strTipFC: String = 'C';  blnFiltrarNE: Boolean = True; blnOpcaoImpressao: Boolean = False);
Var
  reiReimpressao: TReimpressao;
  blnQtdOri     : Boolean;
Begin
  blnQtdOri := False;

  reiReimpressao := TReimpressao.Create(strNumDoc,   //  strNumDoc,
                                        strEspDoc,   //  strEspDoc: String;
                                        0,           //  dtaDtaIni,
                                        0,           //  dtaDtaFin: TDateTime;
                                        strCodCli,   //  strCodCli,
                                        strCodEmp,   //  strCodEmp,
                                        '',          //  strCodVen: String;
                                        False,       //  blnFaturamento: Boolean;
                                        strTipFC,    //  strTip_FC: String;
                                        True,        //  blnPergSep,
                                        False,       //  blnFatVenda,
                                        False,       //  blnCancelamento: Boolean;
                                        '',          //  strEspSel,
                                        strSerie,    //  strSerie: String;
                                        blnFiltrarNE,//  blnFiltrarNE: Boolean;
                                        0,           //  intFilCla: Integer;
                                        False,       //  blnExiDocsCanc: Boolean;
                                        '',          //  strOriDoc: String;
                                        True,        //  blnReimpr: Boolean = False;
                                        False,       //  blnRecClienteGar: Boolean = False;
                                        '');         //  strNumCoo : String = '');


  If SameText(strEspDoc, 'PD') Then
  Begin
    If fMensagem('','Selecione o tipo de quantidade?',['&Original','&Pendente'],2) = 1 Then
      blnQtdOri := True
    Else
      blnQtdOri := False;
  End;

  reiReimpressao.blnTelaReimpressao := True;
  If blnOpcaoImpressao Then
    reiReimpressao.pReimprimeDocumento(False, blnQtdOri, False, True, SameText(strEspDoc, 'PD'), opcPergunta)
  Else
    reiReimpressao.pReimprimeDocumento(False, blnQtdOri, False {blnDocCan}, True, SameText(strEspDoc, 'PD'), opcVideo);

  FreeAndNil(reiReimpressao);
End;

end.

