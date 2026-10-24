unit untLeDocumento;

interface

uses StrUtils, SysUtils, Classes, Forms, Variants, Controls, Windows, Graphics,
  ExtCtrls, Contnrs, StdCtrls, Uni, Dialogs, frxClass, DB, frxDBSet, UniClientDataSet,
  DateUtils, TypesRel, UntTypesSistema, untFuncoesGenerica, untOrdenacao,
  untFuncoesEditorFast, untZClient, untMadeireira, System.Math;

Type

  TLeDocumento = Class(TComponent)
  protected
    FtpeTipEtq : TTipoEtiqueta;
  Private
    FPais: TPais;

    FCliCon: Boolean;

    FTabGer,
    FTabDet: String;

    blnVendaMadOuVidOuMtL: Boolean;

    Function fSQLEmpresa: String;
    Function fSQLEmpresa_CD: String;
    Function fSQLCliente: String;
    Function fSQLEnderecoEntrega(strTabGer, strCodFaz: String): String;
    Function fSQLOperadorLogado: String;
  Public

    strEmpLay: String;

    blnMatricial: Boolean;

    objOrdena: TOrdenacao;
    frxReport: TfrxReport;
    fdbImpEti: TfrxDBDataset;

    recDocume: TRecDocumento;

    arrClients: TarrClients;

    constructor Create(Owner: TComponent); Override;

    Destructor  Destroy; Override;

    Function fInsereClientEnderecoEntrega(strSeqGer, strTabGer, strCodFaz: String): Boolean;
    Procedure pCarregaArrClients(dtsDataSet: TfrxDBDataSet); Virtual;
    Function fInsereClientCliente: Boolean;
    Procedure pInsereClientClienteDadosAdicionais(cdsDados: TZClient);
    Function fInsereClientFornecedor: Boolean;
    Function fInsereClientEmpresa: Boolean;
    Function fInsereClientEmpresa_CD: Boolean;
    Function fInsereOperadorLogado: Boolean;
    Function fPreparaImpressaoDocumentos: Boolean;
    Function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; Virtual;
    Function fSQLFornecedor: String;
    Function fSQLTipoFrete(strCamFre: String): String;

    function fSQLItems: String; virtual; abstract;

    Procedure pInsereItensServico(cdsMovDet, cdsMovGer: TZClient);
    procedure pInsereItensMadeireira(cdsItens: TZClient);
    Procedure pFiltraAcentosClient(cdsDados: TZClient);
    Procedure pFiltraAcentos;
    Procedure pInsereTotalServicoValorOriginal(cdsMovGer: TZClient);

    Procedure pSetaOrdenacao;
    Procedure pLiberaArrClients;
    procedure pAjustarSequencia;
    procedure pInsereVendedorCupomPromocao(cdsCupPro: TZClient; strCodEmp, strNumDoc, strEspDoc: String);
    Procedure pInsereQtdeDevolvidasEntregaFutura(cdsTabGer, cdsTabDet: TZClient);

  published

    Property strTabGer: String Read FTabGer Write FTabGer;
    Property strTabDet: String Read FTabDet Write FTabDet;
    property tpeTipEtq: TTipoEtiqueta read FtpeTipEtq write FtpeTipEtq;

  protected

    Function fSQLCamsposExtrasCadCli: String; Virtual;
    Function fSQLInnersExtrasCadCli: String; Virtual;

    Procedure pSetaParametrosCadcli; Virtual;
    Procedure pSetaParametrosCadFor; Virtual;
    Procedure pSetaParametrosFr3Adicioanais(FReport: TfrxReport);  Virtual;
    Procedure pMontaDadosFinanceira(cdsTabGer: TZClient);
    Procedure pCalculaSaldoDisponivelItens(cdsTabDet: TZClient);
    Procedure pAjustaPesoVolumeLiquido(cdsTabGer, cdsTabDet: TZClient; blnDocSep : Boolean = False);
  End;

  TClassLeDocumento = class of TLeDocumento;

function fEspecieToClassDocumento(strNumDoc,
                                    strEspDoc,
                                    strCodEmp,
                                    strTip_FC: String;
                                    blnDocSep,
                                    blnRequisicao,
                                    blnImpSepRomaneio: Boolean;
                            		tpeTipEtq: TTipoEtiqueta = tpeNenhum): TClassLeDocumento;

implementation

uses untDocMIFF, untDocPDOR, untConstantes, untDocGarantias, untDocROTin,
  untFuncoesSimples, untFinanceira, untDocRomaneios, untDocOrdemServico, untDocOrdemServicoImagem,
  untDocIT, untLeDocumentoReqMaterialConsumo, untDocPA, untDocOrdemProducao,
  untTFatReservaSaldo, untIFatReservaSaldo, untDocCPDP, untDocOrdProTintasImobiliaria,
  untDocOrdProTintasAutomotiva, untDocCupomServico, untDocLA, untDocLE, untDocCGC, untDocInspEntSai,
  untDocOrdProExtrusao, untDocEnderecamentoProduto, untDocPedidoCompra, untDocCupomPromo, untDocFaturaContrato,
  untDocRemessaDevolucao, untDocumentoCRFF, untDocSeparacaoGondola, untDocCupomProxDesc, untDocSolicitacaoManutencaoEquipamentos;

constructor TLeDocumento.Create(Owner: TComponent);
  var qrySetContador : TUniquery;

Begin
  Inherited Create(Owner);
  Try
    qrySetContador := fCriaQuery();
    qrySetContador.Connection.ExecSQL('(SELECT @ROW:=0)');
  Finally
    FreeAndNil(qrySetContador)
  End;

  blnVendaMadOuVidOuMtL := fCfgSis('VENMAD', varBoolean) Or
                           fCfgSis('VENVID', varBoolean) Or
                           fCfgSis('VENMTL', varBoolean);

  SetLength(arrClients, 0);

  FCliCon := False;

  FillChar(recDocume, SizeOf(recDocume), #0);
  recDocume.opcAbastecimento := opcTodos;

  FPais := fSetaPais;

  FtpeTipEtq := tpeNenhum;

  blnMatricial := False;
End;

Destructor TLeDocumento.Destroy;
Begin
  pLiberaArrClients;
End;

Function TLeDocumento.fSQLCamsposExtrasCadCli: String;
Begin
  Result := '';
End;

Function TLeDocumento.fSQLInnersExtrasCadCli: String;
Begin
  Result := '';
End;

Function TLeDocumento.fSQLOperadorLogado: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                           ';
  strSQL := strSQL + '        OPE_CODOPE AS CODOPE,                  ';
  strSQL := strSQL + '        OPE_NOMOPE AS NOMOPE,                  ';
  strSQL := strSQL + '        OPE_E_MAIL AS EMAOPE,                  ';
  strSQL := strSQL + '        OPE_FONE01 AS FO1OPE,                  ';
  strSQL := strSQL + '        OPE_RAMAL1 AS RA1OPE,                  ';
  strSQL := strSQL + '        OPE_FONE02 AS FO2OPE,                  ';
  strSQL := strSQL + '        OPE_RAMAL2 AS RA2OPE,                  ';
  strSQL := strSQL + '        OPE_NEXTEL AS NEXOPE,                  ';
  strSQL := strSQL + '        OPE_CODDEP AS CDEPOP,                  ';
  strSQL := strSQL + '        DEP_DESCRI AS DDEPOP                   ';
  strSQL := strSQL + ' FROM CADOPE                                   ';
  strSQL := strSQL + '   LEFT JOIN CADDEP ON DEP_CODIGO = OPE_CODDEP ';
  strSQL := strSQL + ' WHERE OPE_CODOPE = :CODOPE                    ';

  Result := strSQL;
End;

Function TLeDocumento.fSQLEmpresa_CD: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';

  strSQL := strSQL + ' EMP_CODEMP AS COD_CD,  ';
  strSQL := strSQL + ' EMP_NOMEMP AS NOM_CD,  ';
  strSQL := strSQL + ' EMP_NOMFAN AS FAN_CD,  ';
  strSQL := strSQL + ' EMP_CODCID AS CCI_CD,  ';
  strSQL := strSQL + ' CID_NOMCID AS NCI_CD,  ';
  strSQL := strSQL + ' CID_ESTADO AS SUF_CD,  ';

  strSQL := strSQL + ' EMP_ENDERE AS END_CD,  ';
  strSQL := strSQL + ' EMP_ENDNUM AS NUM_CD,  ';
  strSQL := strSQL + ' EMP_BAIRRO AS BAI_CD,  ';
  strSQL := strSQL + ' EMP_C_E_P_ AS CEP_CD,  ';
  strSQL := strSQL + ' EMP_FONE01 AS FO1_CD,  ';
  strSQL := strSQL + ' EMP_ENDCMP AS CMP_CD,  ';

  strSQL := strSQL + ' EMP_F_A_X_ AS FAX_CD,  ';
  strSQL := strSQL + ' EMP_EMAIL_ AS EMA_CD,  ';
  strSQL := strSQL + ' EMP_C_G_C_ AS CGC_CD,  ';
  strSQL := strSQL + ' EMP_I_E_S_ AS IES_CD   ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP ';

  strSQL := strSQL + ' INNER JOIN CADCID ON CID_CODCID = EMP_CODCID ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

  Result := strSQL;
End;


Function TLeDocumento.fSQLEmpresa: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';

  strSQL := strSQL + ' CE.EMP_NOMEMP AS NOMEMP,  ';
  strSQL := strSQL + ' CE.EMP_NOMFAN AS FANEMP,  ';
  strSQL := strSQL + ' CE.EMP_CODCID AS ECODCI,  ';
  strSQL := strSQL + ' CI.CID_NOMCID AS ENONCI,  ';
  strSQL := strSQL + ' CI.CID_ESTADO AS EESTAD,  ';

  strSQL := strSQL + ' CONCAT(CE.EMP_ENDERE, ", ", CE.EMP_ENDNUM,IF(IFNULL(CE.EMP_ENDCMP, "") = "", "", CONCAT("  ", CE.EMP_ENDCMP))) AS ENDEMP, ';
  strSQL := strSQL + ' CE.EMP_ENDERE AS EENDER,  ';
  strSQL := strSQL + ' CE.EMP_ENDNUM AS EENDNU,  ';
  strSQL := strSQL + ' CE.EMP_BAIRRO AS EBAIRR,  ';
  strSQL := strSQL + ' CE.EMP_C_E_P_ AS EMPCEP,  ';
  strSQL := strSQL + ' CE.EMP_FONE01 AS EMPFO1,  ';
  strSQL := strSQL + ' CE.EMP_FONE02 AS EMPFO2,  ';
  strSQL := strSQL + ' CE.EMP_ENDCMP AS EMPCMP,  ';

  strSQL := strSQL + ' CE.EMP_F_A_X_ AS FAXEMP,  ';
  strSQL := strSQL + ' CE.EMP_EMAIL_ AS EMAEMP,  ';
  strSQL := strSQL + ' CE.EMP_C_G_C_ AS CGCEMP,  ';
  strSQL := strSQL + ' CE.EMP_I_E_S_ AS IESEMP,  ';
  strSQL := strSQL + ' CE.EMP_EMAILV AS EMAILV,  ';
  strSQL := strSQL + ' CE.EMP_EMAILC AS EMAILC,  ';
  strSQL := strSQL + ' IFNULL(FROM_BASE64(EI.EMP_IMGB64), "") AS EMPIMG ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP CE ';

  strSQL := strSQL + ' INNER JOIN CADCID CI ON CI.CID_CODCID = CE.EMP_CODCID ';
  strSQL := strSQL + ' LEFT  JOIN EMPIMG EI ON EI.EMP_CODEMP = CE.EMP_CODEMP ';
  strSQL := strSQL + '                     AND EI.EMP_PRINCI = "S" ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CE.EMP_CODEMP = :CODEMP ';

  Result := strSQL;
End;

Function TLeDocumento.fSQLCliente: String;
Const
  STRCONSUM = ' CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%" ';

  strENDERE = ' IF(' + STRCONSUM + ', :ENDCON, IF(FAZ_CODFAZ IS NOT NULL, FAZ_NOMFAZ, CLI_ENDERE))          ';
  strENDNUM = ' IF(' + STRCONSUM + ',"", IF(FAZ_CODFAZ IS NOT NULL, NULL, CLI_ENDNUM))                      ';
  strENDCOM = ' IF(' + STRCONSUM + ',"", IF(FAZ_CODFAZ IS NOT NULL, NULL, CLI_ENDCOM))                      ';
  strBAIRRO = ' IF(' + STRCONSUM + ', :BAICON, IF(FAZ_CODFAZ IS NOT NULL, FAZ_BAIRRO, CLI_BAIRRO))          ';
  strC_E_P_ = ' IF(' + STRCONSUM + ', :CEPCON, IF(FAZ_CODFAZ IS NOT NULL, FAZ_C_E_P_, CLI_C_E_P_))          ';
  strCODCID = ' IF(' + STRCONSUM + ', :CIDCON, IF(FAZ_CODFAZ IS NOT NULL, FAZ_CODCID, CLI_CODCID))          ';
  strNOMCID = ' IF(' + STRCONSUM + ', CGER.CID_NOMCID, IF(FAZ_CODFAZ IS NOT NULL, CFAZ.CID_NOMCID, CCLI.CID_NOMCID)) ';
  strESTADO = ' IF(' + STRCONSUM + ', CGER.CID_ESTADO, IF(FAZ_CODFAZ IS NOT NULL, CFAZ.CID_ESTADO, CCLI.CID_ESTADO)) ';

  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';

  strSQL := strSQL + fSQLCamsposExtrasCadCli;

  strSQL := strSQL + '  IF(' + STRCONSUM + ', "S", "N") AS CLICON, ';
  strSQL := strSQL + '  CLI_CODCLI AS CODCLI, ';

  if (fCfgSis('SIMPAU', varBoolean) and fCfgSis('RETIMP', varBoolean)) then
  begin
    strSQL := strSQL + '  "N" AS RETPCO, ';
    strSQL := strSQL + '  "N" AS RETIRF, ';
    strSQL := strSQL + '  "N" AS CDESPI, ';
  end
  else
  begin
    strSQL := strSQL + '  CLI_RETPCO AS RETPCO, ';
    strSQL := strSQL + '  CLI_RETIRF AS RETIRF, ';
    strSQL := strSQL + '  CLI_CDESPI AS CDESPI, ';
  end;

  strSQL := strSQL + '  CLI_RETISS AS RETISS, ';
  strSQL := strSQL + '  CLI_ALQISS AS ALQISS, ';
  strSQL := strSQL + '  CLI_SEGSOC AS SEGSOC, ';
  strSQL := strSQL + '  CLI_SITIPI AS SITIPI, ';
  strSQL := strSQL + '  CLI_ENQIPI AS ENQIPI, ';
  strSQL := strSQL + '  CLI_MENIPI AS MENIPI, ';
  strSQL := strSQL + '  CLI_ORPURD AS ORPURD, ';
  strSQL := strSQL + '  CLI_CALICM AS CALICM, ';
  strSQL := strSQL + '  CLI_CODREG AS CODREG, ';
  strSQL := strSQL + '  REG_DESREG AS NOMREG, ';
  strSQL := strSQL + '  CLI_NOMCLI AS CLIORI, ';
  strSQL := strSQL + '  CLI_I_M_P_ AS I_M_P_, ';
  strSQL := strSQL + '  CLI_PRORUR AS PRORUR, ';
  strSQL := strSQL + '  CLI_MICEMP AS MICEMP, ';
  strSQL := strSQL + '  CLI_ORGPUB AS ORGPUB, ';
  strSQL := strSQL + '  CLI_ZONFRA AS ZONFRA, ';
  strSQL := strSQL + '  CLI_PERMUT AS PERMUT, ';
  strSQL := strSQL + '  CLI_SUFRAM AS SUFRAM, ';
  strSQL := strSQL + '  CLI_TABPRE AS TABPRE, ';
  strSQL := strSQL + '  CLI_DIFERI AS DIFERI, ';
  strSQL := strSQL + '  CLI_DIF_ST AS CDIFST, ';
  strSQL := strSQL + '  CLI_SITP_C AS SITP_C, ';
  strSQL := strSQL + '  CLI_MENP_C AS MENP_C, ';
  strSQL := strSQL + '  CLI_REDICM AS REDICM, ';
  strSQL := strSQL + '  CLI_CODOBR AS CODOBR, ';
  strSQL := strSQL + '  CLI_CODART AS CODART, ';
  strSQL := strSQL + '  CLI_CODCNO AS CODCNO, ';
  strSQL := strSQL + '  CLI_INSIMO AS INSIMO, ';
  strSQL := strSQL + '  CLI_CODCIB AS CODCIB, ';
  strSQL := strSQL + '  CLI_CODATI AS CODATI, ';
  strSQL := strSQL + '  ATI_DESATI AS DESATI, ';
  strSQL := strSQL + '  CLI_CELULA AS CELULA, ';
  strSQL := strSQL + '  CLI_EMAIL_ AS EMAIL_, ';
  strSQL := strSQL + '  CLI_EMAIL3 AS EMAIL3, ';
  strSQL := strSQL + '  CLI_FONE02 AS FONE02, ';
  strSQL := strSQL + '  CLI_IMPLAU AS IMPLAU, ';
  strSQL := strSQL + '  CLI_ETIDES AS ETIDES, ';

  strSQL := strSQL + '  CAST(IF(' + STRCONSUM + ', :CGCCPF, IF(FAZ_CODFAZ IS NOT NULL, FAZ_CGCCPF, CLI_CGCCPF)) AS UNSIGNED) AS CGCCPF, ';
  strSQL := strSQL + '  IF(' + STRCONSUM + ', :NOMCON, CLI_NOMCLI) AS CLINOM, ';
  strSQL := strSQL + '  IF(' + STRCONSUM + ', :NOMCON, CLI_FANSOB) AS FANSOB, ';

  strSQL := strSQL + strENDERE + ' AS ENDERE, ';
  strSQL := strSQL + strENDNUM + ' AS ENDNUM, ';
  strSQL := strSQL + strENDCOM + ' AS ENDCOM, ';
  strSQL := strSQL + strBAIRRO + ' AS BAIRRO, ';
  strSQL := strSQL + strC_E_P_ + ' AS CEPCLI, ';
  strSQL := strSQL + strCODCID + ' AS CODCID, ';
  strSQL := strSQL + strNOMCID + ' AS NOMCID, ';
  strSQL := strSQL + strESTADO + ' AS ESTADO, ';

  strSQL := strSQL + '  IF(' + STRCONSUM + ', :TELCON, IF(FAZ_CODFAZ IS NOT NULL, CLI_FONE01, CLI_FONE01)) AS FONE01, ';
  strSQL := strSQL + '  IF(' + STRCONSUM + ', :R_GCON, IF(FAZ_CODFAZ IS NOT NULL, "        ", CLI_NUMR_G)) AS NUMRGC, ';
  strSQL := strSQL + '  IF(' + STRCONSUM + ', :CGCCON, IF(FAZ_CODFAZ IS NOT NULL, FAZ_C_G_C_, CLI_C_G_C_)) AS CGCCLI, ';
  strSQL := strSQL + '  IF(' + STRCONSUM + ', :IESCON, IF(FAZ_CODFAZ IS NOT NULL, FAZ_I_E_S_, CLI_I_E_S_)) AS IESCLI, ';
  strSQL := strSQL + '  IF(' + STRCONSUM + ', :NOMCON, CLI_NOMCLI) AS NOMCLI, ';

  strSQL := strSQL + '  IF(' + STRCONSUM + ', ';
  strSQL := strSQL + '    IF(IFNULL( :IESCON, "") = "", :R_GCON, :IESCON), ';
  strSQL := strSQL + '      IF(FAZ_CODFAZ IS NOT NULL, ';
  strSQL := strSQL + '        IF(FAZ_CGCCPF = 1, FAZ_I_E_S_, " "), ';
  strSQL := strSQL + '          IF(CLI_CGCCPF = 1, CLI_I_E_S_, CLI_NUMR_G))) AS IESRGC, ';

  strSQL := strSQL + '  IF(IFNULL(CLI_ENDCOB, "") = "", ' + strENDERE + ', CLI_ENDCOB)      AS ENDCOB, ';
  strSQL := strSQL + '  IF(IFNULL(CLI_ENDCOB, "") = "", ' + strBAIRRO + ', CLI_BAICOB)      AS BAICOB, ';
  strSQL := strSQL + '  IF(IFNULL(CLI_ENDCOB, "") = "", ' + strNOMCID + ', CCOB.CID_NOMCID) AS CIDCOB, ';
  strSQL := strSQL + '  IF(IFNULL(CLI_ENDCOB, "") = "", ' + strESTADO + ', CCOB.CID_ESTADO) AS ESTCOB, ';
  strSQL := strSQL + '  IF(IFNULL(CLI_ENDCOB, "") = "", ' + strC_E_P_ + ', CLI_CEPCOB)      AS CEPCOB, ';
  strSQL := strSQL + '  CLI_EMAIL_ AS EMAIL_, ';
  strSQL := strSQL + '  CLI_CODSUB AS CODSUB, ';
  strSQL := strSQL + '  SUB_DESSUB AS DESSUB, ';
  strSQL := strSQL + '  CLI_MSGPED AS MSGPED, ';
  strSQL := strSQL + '  CLI_INDUST AS INDUST, ';
  strSQL := strSQL + '  CAST("" AS CHAR(5)) AS TIPPES, ';
  strSQL := strSQL + '  CAST("" AS CHAR(100)) AS DESPES, ';
  strSQL := strSQL + '  CLI_F_A_X_ AS F_A_X_ ';

  strSQL := strSQL + 'FROM ';

  strSQL := strSQL + '  CADCLI ';

  strSQL := strSQL + '  LEFT JOIN CADFAZ ON FAZ_CODCLI = CLI_CODCLI AND FAZ_CODFAZ = :CODFAZ ';

  strSQL := strSQL + '  LEFT JOIN CADATI ON CLI_CODATI = ATI_CODATI ';

  strSQL := strSQL + '  LEFT JOIN CADREG ON REG_CODREG = CLI_CODREG ';

  strSQL := strSQL + '  LEFT JOIN CADCID CCOB ON CCOB.CID_CODCID = CLI_CIDCOB ';

  strSQL := strSQL + '  LEFT JOIN CADCID CGER ON CGER.CID_CODCID = :CIDCON ';

  strSQL := strSQL + '  LEFT JOIN CADCID CCLI ON CCLI.CID_CODCID = CLI_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CFAZ ON CFAZ.CID_CODCID = FAZ_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADSUB ON SUB_CODSUB = CLI_CODSUB ';

  strSQL := strSQL + fSQLInnersExtrasCadCli;

  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   CLI_CODCLI = :CODCLI ';

  Result := strSQL;
End;

Function TLeDocumento.fSQLEnderecoEntrega(strTabGer, strCodFaz: String): String;
  Var
    strSQL: String;
    strTabAux: String;

  function fDocEhPDouOR(strTabela:String):Boolean;
  begin
    Result:=(Pos('FAT', strTabela) > 0);
  end;

Begin
  strSQL := '';

  If Not fEmptyStr(strCodFaz) Then
  Begin
    strSQL := strSQL + ' SELECT SQL_NO_CACHE     ';

    strSQL := strSQL + '   IF(IFNULL(FAZ_ENDNUM, "") = "", FAZ_ENDERE, CONCAT(FAZ_ENDERE, ", ", IFNULL(FAZ_ENDNUM,""), IF(IFNULL(FAZ_ENDCOM, "") = "", "", CONCAT("  ", FAZ_ENDCOM)))) AS ETENDE, ';
    strSQL := strSQL + '   FAZ_BAIRRO AS ETBAIR, ';
    strSQL := strSQL + '   FAZ_CODCID AS ETCCID, ';

    strSQL := strSQL + '   CID_NOMCID AS ETNCID,  ';
    strSQL := strSQL + '   CID_ESTADO AS ETESTA,  ';

    strSQL := strSQL + '   FAZ_C_E_P_ AS ETRCEP, ';
    strSQL := strSQL + '   FAZ_TELCON AS ETTELE, ';
    strSQL := strSQL + '   ""         AS ETREFE, ';
    strSQL := strSQL + '   FAZ_NOMCON AS ETCONT, ';
    strSQL := strSQL + '   ""         AS ETCTRA, ';
    strSQL := strSQL + '   ""         AS ETNTRA, ';
    strSQL := strSQL + '   ""         AS ETCOBR, ';
    strSQL := strSQL + '   ""         AS ETCART, ';
    strSQL := strSQL + '   ""         AS ETCCNO, ';
    strSQL := strSQL + '   ""         AS ETCIMO, ';
    strSQL := strSQL + '   ""         AS ETCCIB, ';
    strSQL := strSQL + '   ""         AS CLIREG, ';

    strSQL := strSQL + '   999999     AS ETC_SEQIND,  ';
    strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETENDC ';
    strSQL := strSQL + ' FROM                   ';
    strSQL := strSQL + '   CADFAZ               ';

    strSQL := strSQL + ' LEFT JOIN CADCID CE ON CID_CODCID = FAZ_CODCID ';

    strSQL := strSQL + ' WHERE                  ';
    strSQL := strSQL + '   FAZ_CODFAZ = :CODFAZ AND FAZ_CODCLI = :CODCLI ';
  End
  Else If (FCliCon) And (strTabGer <> 'EQUGER') Then
  Begin
    strTabAux := IfThen(fEmptyStr(strTabGer), FTabGer, strTabGer);

    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';

    If fDocEhPDouOR(strTabAux) Then
    Begin
      strSQL := strSQL + '   FGO_ENDCON AS ETENDE, ';
      strSQL := strSQL + '   FGO_BAICON AS ETBAIR, ';
      strSQL := strSQL + '   FGO_CIDCON AS ETCCID, ';

      strSQL := strSQL + '   CID_NOMCID AS ETNCID, ';
      strSQL := strSQL + '   CID_ESTADO AS ETESTA, ';

      strSQL := strSQL + '   FGO_CEPCON AS ETRCEP, ';
      strSQL := strSQL + '   FGO_TELCON AS ETTELE, ';

    End
    Else
    Begin
      strSQL := strSQL + '   GER_ENDCON AS ETENDE, ';
      strSQL := strSQL + '   GER_BAICON AS ETBAIR, ';
      strSQL := strSQL + '   GER_CIDCON AS ETCCID, ';

      strSQL := strSQL + '   CID_NOMCID AS ETNCID, ';
      strSQL := strSQL + '   CID_ESTADO AS ETESTA, ';

      strSQL := strSQL + '   GER_CEPCON AS ETRCEP, ';
      strSQL := strSQL + '   GER_TELCON AS ETTELE, ';

    End;

    strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETENDC, ';

    strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETREFE, ';
    strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETCONT, ';

    strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETCTRA, ';
    strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETNTRA, ';

    strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETCOBR, ';
    strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETCART, ';
    strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETCCNO, ';
    strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETCIMO, ';
    strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETCCIB, ';
    strSQL := strSQL + '   CAST("" AS CHAR(1)) AS CLIREG  ';

    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + strTabAux + ' G ';
    strSQL := strSQL + ' INNER JOIN CADCID ON CID_CODCID = ' + IfThen(fDocEhPDouOR(strTabAux), ' FGO_CIDCON  ', ' GER_CIDCON ');
    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '   G.AUTOINCREM = :SEQGER ';

  End
  Else
  Begin
    If SameText(strTabGer, 'ROMGERX') Then
    Begin
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   ETC_ENDENT AS ETENDE,';
      strSQL := strSQL + '   ETC_BAIENT AS ETBAIR,';
      strSQL := strSQL + '   ETC_CIDENT AS ETCCID,';
      strSQL := strSQL + '   CID_NOMCID AS ETNCID,';
      strSQL := strSQL + '   CID_ESTADO AS ETESTA,';
      strSQL := strSQL + '   ETC_CEPENT AS ETRCEP,';
      strSQL := strSQL + '   ETC_TELENT AS ETTELE,';
      strSQL := strSQL + '   ETC_REFENT AS ETREFE,';
      strSQL := strSQL + '   ETC_CONENT AS ETCONT,';
      strSQL := strSQL + '   ETC_CODTRA AS ETCTRA,';
      strSQL := strSQL + '   TRA_NOMTRA AS ETNTRA,';
      strSQL := strSQL + '   ETC_CODOBR AS ETCOBR,';
      strSQL := strSQL + '   ETC_CODART AS ETCART,';
      strSQL := strSQL + '   ETC_CODCNO AS ETCCNO,';
      strSQL := strSQL + '   ETC_INSIMO AS ETCIMO,';
      strSQL := strSQL + '   ETC_CODCIB AS ETCCIB,';
      strSQL := strSQL + '   ETC_CODREG AS CLIREG,';
      strSQL := strSQL + '   - 1 AS ETC_SEQIND,';
      strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETENDC ';
      strSQL := strSQL + ' FROM';
      strSQL := strSQL + '  ROMGERX';
      strSQL := strSQL + '  LEFT JOIN ENTCLI E ON E.ETC_CODCLI = GER_CODCLI';
      strSQL := strSQL + '  LEFT JOIN CADCID CE  ON CID_CODCID = ETC_CIDENT';
      strSQL := strSQL + '  LEFT JOIN CADTRA ON TRA_CODTRA = GER_CODTRA';
      strSQL := strSQL + '  WHERE ROMGERX.AUTOINCREM = :SEQGER';
      strSQL := strSQL + '  UNION ';
    End
    Else
    Begin
      strTabAux := fRetNomTabAuxMov(IfThen(fEmptyStr(strTabGer), FTabGer, strTabGer));
      If Not fEmptyStr(strTabAux) Then
      Begin
        strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '   ETC_ENDENT AS ETENDE, ';
        strSQL := strSQL + '   ETC_BAIENT AS ETBAIR, ';
        strSQL := strSQL + '   ETC_CIDENT AS ETCCID, ';

        strSQL := strSQL + '   CID_NOMCID AS ETNCID, ';
        strSQL := strSQL + '   CID_ESTADO AS ETESTA, ';

        strSQL := strSQL + '   ETC_CEPENT AS ETRCEP, ';
        strSQL := strSQL + '   ETC_TELENT AS ETTELE, ';
        strSQL := strSQL + '   ETC_REFENT AS ETREFE, ';
        strSQL := strSQL + '   ETC_CONENT AS ETCONT, ';

        strSQL := strSQL + '   ETC_CODTRA AS ETCTRA, ';
        strSQL := strSQL + '   TRA_NOMTRA AS ETNTRA, ';

        strSQL := strSQL + '   ETC_CODOBR AS ETCOBR, ';
        strSQL := strSQL + '   ETC_CODART AS ETCART, ';
        strSQL := strSQL + '   ETC_CODCNO AS ETCCNO, ';
        strSQL := strSQL + '   ETC_INSIMO AS ETCIMO, ';
        strSQL := strSQL + '   ETC_CODCIB AS ETCCIB, ';
        strSQL := strSQL + '   ETC_CODREG AS CLIREG, ';

        strSQL := strSQL + '   -1 AS ETC_SEQIND,    ';
        strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETENDC ';
        strSQL := strSQL + ' FROM                ';

        strSQL := strSQL + '   ENTCLI E          ';

        strSQL := strSQL + ' INNER JOIN ' + strTabAux + ' ON';
        strSQL := strSQL + '   AUX_ENTGER = E.AUTOINCREM AND ';
        strSQL := strSQL + '   AUX_SEQGER = :SEQGER          ';

        strSQL := strSQL + ' LEFT JOIN CADCID CE ON CID_CODCID = ETC_CIDENT ';

        strSQL := strSQL + ' LEFT JOIN CADTRA    ON TRA_CODTRA = ETC_CODTRA ';

        strSQL := strSQL + '  UNION ';
      End Else If (strTabGer = 'EQUGER') Then
      Begin
        If (Not FCliCon) Then Begin
          strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
          strSQL := strSQL + '   ETC_ENDENT AS ETENDE, ';
          strSQL := strSQL + '   ETC_BAIENT AS ETBAIR, ';
          strSQL := strSQL + '   ETC_CIDENT AS ETCCID, ';

          strSQL := strSQL + '   CID_NOMCID AS ETNCID, ';
          strSQL := strSQL + '   CID_ESTADO AS ETESTA, ';

          strSQL := strSQL + '   ETC_CEPENT AS ETRCEP, ';
          strSQL := strSQL + '   ETC_TELENT AS ETTELE, ';
          strSQL := strSQL + '   ETC_REFENT AS ETREFE, ';
          strSQL := strSQL + '   ETC_CONENT AS ETCONT, ';

          strSQL := strSQL + '   ETC_CODTRA AS ETCTRA, ';
          strSQL := strSQL + '   TRA_NOMTRA AS ETNTRA, ';

          strSQL := strSQL + '   ETC_CODOBR AS ETCOBR, ';
          strSQL := strSQL + '   ETC_CODART AS ETCART, ';
          strSQL := strSQL + '   ETC_CODCNO AS ETCCNO, ';
          strSQL := strSQL + '   ETC_INSIMO AS ETCIMO, ';
          strSQL := strSQL + '   ETC_CODCIB AS ETCCIB, ';
          strSQL := strSQL + '   ETC_CODREG AS CLIREG, ';

          strSQL := strSQL + '   -1 AS ETC_SEQIND,    ';
          strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETENDC ';
          strSQL := strSQL + ' FROM                ';

          strSQL := strSQL + '   ENTCLI E          ';

          strSQL := strSQL + ' LEFT JOIN CADCID CE ON CID_CODCID = ETC_CIDENT ';

          strSQL := strSQL + ' LEFT JOIN CADTRA    ON TRA_CODTRA = ETC_CODTRA ';

          strSQL := strSQL + ' WHERE E.AUTOINCREM = :SEQGER ';
        End Else Begin
          strSQL := strSQL + ' SELECT ';
          strSQL := strSQL + '  SQL_NO_CACHE EQU_ENDCON AS ETENDE, ';
          strSQL := strSQL + '    EQU_BAICON AS ETBAIR, ';
          strSQL := strSQL + '    EQU_CIDCON AS ETCCID, ';
          strSQL := strSQL + '    CID_NOMCID AS ETNCID, ';
          strSQL := strSQL + '    CID_ESTADO AS ETESTA, ';
          strSQL := strSQL + '    EQU_CEPCON AS ETRCEP, ';
          strSQL := strSQL + '    EQU_TELCON AS ETTELE, ';
          strSQL := strSQL + '    "" AS ETREFE, ';
          strSQL := strSQL + '    "" AS ETCONT, ';
          strSQL := strSQL + '    "" AS ETCTRA, ';
          strSQL := strSQL + '    "" AS ETNTRA, ';
          strSQL := strSQL + '    "" AS ETCOBR, ';
          strSQL := strSQL + '    "" AS ETCART, ';
          strSQL := strSQL + '    "" AS ETCCNO, ';
          strSQL := strSQL + '    "" AS ETCIMO, ';
          strSQL := strSQL + '    "" AS ETCCIB, ';
          strSQL := strSQL + '    "" AS CLIREG, ';
          strSQL := strSQL + '    - 1 AS ETC_SEQIND, ';
          strSQL := strSQL + '    CAST("" AS CHAR(1)) AS ETENDC ';
          strSQL := strSQL + '  FROM ';
          strSQL := strSQL + '    EQUGER ';
          strSQL := strSQL + '    LEFT JOIN CADCID CE ';
          strSQL := strSQL + '      ON CID_CODCID = EQU_CIDCON ';
          strSQL := strSQL + '  WHERE EQU_NUMOSE = :NUMOSE AND EQU_CODEMP = :CODEMP ';
        End;

        strSQL := strSQL + '  UNION ';
      End;
    End;

    strSQL := strSQL + ' SELECT * FROM ';

    strSQL := strSQL + ' (SELECT SQL_NO_CACHE ';

    strSQL := strSQL + '   ETC_ENDENT AS ETENDE, ';
    strSQL := strSQL + '   ETC_BAIENT AS ETBAIR, ';
    strSQL := strSQL + '   ETC_CIDENT AS ETCCID, ';

    strSQL := strSQL + '   CID_NOMCID AS ETNCID, ';
    strSQL := strSQL + '   CID_ESTADO AS ETESTA, ';

    strSQL := strSQL + '   ETC_CEPENT AS ETRCEP, ';
    strSQL := strSQL + '   ETC_TELENT AS ETTELE, ';
    strSQL := strSQL + '   ETC_REFENT AS ETREFE, ';
    strSQL := strSQL + '   ETC_CONENT AS ETCONT, ';

    strSQL := strSQL + '   ETC_CODTRA AS ETCTRA, ';
    strSQL := strSQL + '   TRA_NOMTRA AS ETNTRA, ';

    strSQL := strSQL + '   ETC_CODOBR AS ETCOBR, ';
    strSQL := strSQL + '   ETC_CODART AS ETCART, ';
    strSQL := strSQL + '   ETC_CODCNO AS ETCCNO, ';
    strSQL := strSQL + '   ETC_INSIMO AS ETCIMO, ';
    strSQL := strSQL + '   ETC_CODCIB AS ETCCIB, ';
    strSQL := strSQL + '   ETC_CODREG AS CLIREG, ';

    strSQL := strSQL + '   ETC_SEQIND,        ';
    strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETENDC ';

    strSQL := strSQL + ' FROM                ';
    strSQL := strSQL + '   ENTCLI E          ';

    strSQL := strSQL + ' LEFT JOIN CADCID CE ON CID_CODCID = ETC_CIDENT ';

    strSQL := strSQL + ' LEFT JOIN CADTRA    ON TRA_CODTRA = ETC_CODTRA ';

    strSQL := strSQL + ' WHERE               ';
    strSQL := strSQL + '   ETC_CODCLI = :CODCLI ';

    strSQL := strSQL + '   ORDER BY ETC_SEQIND LIMIT 1) AS TAB ';

    strSQL := strSQL + '  UNION ';

    strSQL := strSQL + ' SELECT SQL_NO_CACHE         ';

    strSQL := strSQL + '   IF(IFNULL(CLI_ENDNUM, "") = "", CLI_ENDERE, CONCAT(CLI_ENDERE, ", ", IFNULL(CLI_ENDNUM,""), IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT("  ", CLI_ENDCOM)))) AS ETENDE, ';
    strSQL := strSQL + '   CLI_BAIRRO AS ETBAIR, ';
    strSQL := strSQL + '   CLI_CODCID AS ETCCID, ';

    strSQL := strSQL + '   CID_NOMCID AS ETNCID,  ';
    strSQL := strSQL + '   CID_ESTADO AS ETESTA,  ';

    strSQL := strSQL + '   CLI_C_E_P_ AS ETRCEP, ';
    strSQL := strSQL + '   CLI_FONE01 AS ETTELE, ';
    strSQL := strSQL + '   ""         AS ETREFE, ';
    strSQL := strSQL + '   CLI_CONTAT AS ETCONT, ';
    strSQL := strSQL + '   ""         AS ETCTRA, ';
    strSQL := strSQL + '   ""         AS ETNTRA, ';
    strSQL := strSQL + '   ""         AS ETCOBR, ';
    strSQL := strSQL + '   ""         AS ETCART, ';
    strSQL := strSQL + '   ""         AS ETCCNO, ';
    strSQL := strSQL + '   ""         AS ETCIMO, ';
    strSQL := strSQL + '   ""         AS ETCCIB, ';
    strSQL := strSQL + '   ""         AS CLIREG, ';

    strSQL := strSQL + '   999999     AS ETC_SEQIND, ';
    strSQL := strSQL + '   CAST("" AS CHAR(1)) AS ETENDC ';
    strSQL := strSQL + ' FROM                   ';
    strSQL := strSQL + '   CADCLI               ';

    strSQL := strSQL + ' LEFT JOIN CADCID CE ON CID_CODCID = CLI_CODCID ';

    strSQL := strSQL + ' WHERE                  ';
    strSQL := strSQL + '   CLI_CODCLI = :CODCLI ';

    strSQL := strSQL + ' ORDER BY ETC_SEQIND LIMIT 1 ';
  End;  

  Result := strSQL;
End;

Function TLeDocumento.fInsereClientEnderecoEntrega(strSeqGer, strTabGer, strCodFaz: String): Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLEnderecoEntrega(strTabGer, strCodFaz));
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxEndEnt';
    frxDados.UserName := 'frxEndEnt';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    If Params.FindParam('SEQGER') <> Nil Then
      ParamByName('SEQGER').AsString := strSeqGer;
      
    If Params.FindParam('CODCLI') <> Nil Then
      ParamByName('CODCLI').AsString := strCodCli;

    If Params.FindParam('CODFAZ') <> Nil Then
      ParamByName('CODFAZ').AsString := strCodFaz;

    If Params.FindParam('CODEMP') <> Nil Then
      ParamByName('CODEMP').AsString := recDocume.strCodEmp;

    If Params.FindParam('NUMOSE') <> Nil Then
      ParamByName('NUMOSE').AsString := recDocume.strNumDoc;

    Result := fAbreClient(True, 'fInsereClientEnderecoEntrega');
  End;
End;

Function TLeDocumento.fInsereClientCliente: Boolean;
Begin

  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLCliente);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxCliente';
    frxDados.UserName := 'frxCliente';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery Do
  Begin

    pSetaParametrosCadcli;

    Result := fAbreClient(True, 'fInsereClientCliente');

    If Not cdsDados.IsEmpty Then
    Begin
      pInsereClientClienteDadosAdicionais(cdsDados);

      FCliCon := SameText(cdsDados.FieldByName('CLICON').AsString, 'S');
    End;  

  End;

End;

Procedure TLeDocumento.pInsereClientClienteDadosAdicionais(cdsDados: TZClient);
var
  strTipPes: String;
Begin
  strTipPes := '';

  Try
    cdsDados.Edit;

    { Tratamento para CGC }
    cdsDados.FieldByName('CGCCLI').AsString := fFormataCpfCgc(cdsDados.FieldByName('CGCCLI').AsString, FPais);

    { Tratando campos de tipo de pessoa }
    strTipPes := fRetDesTipoAbf('C', cdsDados.FieldByName('CODCLI').AsString, cdsDados.FieldByName('INDUST').AsString, cdsDados.FieldByName('PRORUR').AsString);

    If (strTipPes <> '') Then
    Begin
      cdsDados.FieldByName('TIPPES').AsString := Copy(strTipPes, 0, 3);
      cdsDados.FieldByName('DESPES').AsString := Copy(strTipPes, 7);
    End;

    cdsDados.Post;

  Except
    On E: Exception Do
    Begin
      pGravarErro(True, 'Erro [TEditorFast.fInsereClientClienteDadosAdicionais]', E.Message);
    End;
  End;
End;

procedure TLeDocumento.pSetaOrdenacao;
begin
  If Assigned(arrClients) And (Length(arrClients)> 0) Then
  Begin
    If Assigned(arrClients[0].cdsDados) Then
    Begin
      If Assigned(objOrdena) Then
        objOrdena.pOrdena(arrClients[0].cdsDados.fGetUniClientDataset);
    End;
  End;
end;

Procedure TLeDocumento.pSetaParametrosCadcli;
Begin
  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('CODCLI').AsString := strCodCli;
  End;
End;

Function TLeDocumento.fInsereClientEmpresa: Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLEmpresa);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxEmpresa';
    frxDados.UserName := 'frxEmpresa';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    If blnCabecalhoCD Then
      ParamByName('CODEMP').AsString := strEmpCabecalho_CD
    Else
    Begin
      If (Not fEmptyStr(strEmpDoctoVenda)) And (strEmpDoctoVenda <> strCodEmp) Then
        ParamByName('CODEMP').AsString := strEmpDoctoVenda
      else if fEmptyStr(strEmpLay) then
        ParamByName('CODEMP').AsString := strCodEmp
      else
        ParamByName('CODEMP').AsString := strEmpLay;
    End;

    Result := fAbreClient(True, 'fInsereClientEmpresa');

    If Not cdsDados.IsEmpty Then
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('CGCEMP').AsString := fFormataCpfCgc(FieldByName('CGCEMP').AsString, FPais);
      cdsDados.Post;
    End;

  End;
End;

Function TLeDocumento.fInsereOperadorLogado: Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLOperadorLogado);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxOperador';
    frxDados.UserName := 'frxOperador';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

    Result := fAbreClient(True, 'fInsereOperadorLogado');

  End;
End;

Function TLeDocumento.fInsereClientEmpresa_CD: Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLEmpresa_CD);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxEmpresa_CD';
    frxDados.UserName := 'frxEmpresa_CD';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('CODEMP').AsString := fCfgSis('EMP_CD');

    Result := fAbreClient(True, 'fInsereClientEmpresa_CD');

    If Not cdsDados.IsEmpty Then
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('CGC_CD').AsString := fFormataCpfCgc(FieldByName('CGC_CD').AsString, FPais);
      cdsDados.Post;
    End;

  End;
End;

Procedure TLeDocumento.pLiberaArrClients;
  Var
    intIndice: Integer;
Begin
  If Assigned(arrClients) And (Length(arrClients)> 0) Then
  Begin
    For intIndice := Low(arrClients) To High(arrClients) Do
    Begin
      With arrClients[intIndice] Do
      Begin
        If Assigned(frxDados) Then
          FreeAndNil(frxDados);

        If Assigned(cdsDados) Then
        Begin
          If cdsDados.Active Then
            cdsDados.Close;
          FreeAndNil(cdsDados);
        End;
      End;
    End;

    SetLength(arrClients, 0);
  End;
End;

procedure TLeDocumento.pMontaDadosFinanceira(cdsTabGer: TZClient);
  Var
    objFinanc: TFinanceira;
    strFinDes,
    strValFin,
    strQtdPar,
    strValOpe,
    strValPar,
    strCartao: String;
begin
  If Not cdsTabGer.Active Or cdsTabGer.IsEmpty Then
    Exit;

  cdsTabGer.First;

  objFinanc := TFinanceira.Create(Nil);

  With objFinanc, cdsMovFin Do
  Begin
    pCarregaFinanciamento(cdsTabGer.FieldByName('TABELA').AsString, cdsTabGer.FieldByName('AUTGER').AsString);
    First;

    strFinDes := '';
    strValFin := '';
    strQtdPar := '';
    strValOpe := '';
    strValPar := '';
    strCartao := '';

    While Not Eof Do
    Begin
      strFinDes := strFinDes +
                   fRetDescricao(FieldByName('FIN_CODFIN').AsString, 'CADFIN', 'FIN_CODIGO', 'FIN_DESCRI') + IfThen(RecNo < RecordCount, #13#10, '');

      strValFin := strValFin + FormatFloat('#,##0.00', FieldByName('FIN_VALFIN').AsFloat) + IfThen(RecNo < RecordCount, #13#10, '');
      strQtdPar := strQtdPar + FormatFloat('#,##0.00', FieldByName('FIN_QTDPAR').AsFloat) + IfThen(RecNo < RecordCount, #13#10, '');
      strValOpe := strValOpe + FormatFloat('#,##0.00', FieldByName('FIN_VALOPE').AsFloat) + IfThen(RecNo < RecordCount, #13#10, '');
      strValPar := strValPar + FormatFloat('#,##0.00', FieldByName('FIN_VALPAR').AsFloat) + IfThen(RecNo < RecordCount, #13#10, '');
      strCartao := strCartao + FieldByName('FIN_DIGCAR').AsString + IfThen(RecNo < RecordCount, #13#10, '');

      Next;
    End;
  End;

  With cdsTabGer Do
  Begin
    Edit;
    FieldByName('FINDES').AsString := strFinDes;
    FieldByName('VALFIN').AsString := strValFin;
    FieldByName('QTDPAR').AsString := strQtdPar;
    FieldByName('VALOPE').AsString := strValOpe;
    FieldByName('VALPAR').AsString := strValPar;
    FieldByName('CARTAO').AsString := strCartao;
    Post;
  End;

  FreeAndNil(objFinanc);
end;

procedure TLeDocumento.pCalculaSaldoDisponivelItens(cdsTabDet: TZClient);
  Var
    fltCnv_Ml,
    fltSalRes,
    fltSalReG,
    fltSalExt,
    fltSalDis: Double;
begin
  With cdsTabDet Do
  Begin
    If IsEmpty Then
      Exit;

    First;

    While Not Eof Do
    Begin
      If (FindField('ITE_CNV_ML') <> Nil) And (FindField('ITE_SAL_ML') <> Nil) Then
      Begin
        fltCnv_Ml := IIF(FindField('ITE_CNV_ML').AsFloat <= 0, 1, FindField('ITE_CNV_ML').AsFloat);
        fltSalRes := TSaldoReservado.New(
                       TReservaParametros.New()
                        .EmpresaItem(VS_strCodEmp)
                        .CodigoItem(FieldByName('CODITE').AsString)
                        .CodEmpresa(VS_strCodEmp)
                        .TipoReserva(trsPedidoVenda)
                        .ConverterML(True)
                        .DesconsideraPedidosCorte(False)
                       ).fGetQuantidade();

        fltSalReG := TSaldoReservado.New(
                       TReservaParametros.New()
                        .EmpresaItem(VS_strCodEmp)
                        .CodigoItem(FieldByName('CODITE').AsString)
                        .CodEmpresa(VS_strCodEmp)
                        .TipoReserva(trsGarantia)
                        .ConverterML(True)
                        .DesconsideraPedidosCorte(False)
                       ).fGetQuantidade();

        fltSalExt := TSaldoReservado.New(
                       TReservaParametros.New()
                        .EmpresaItem(VS_strCodEmp)
                        .CodigoItem(FieldByName('CODITE').AsString)
                        .CodEmpresa(VS_strCodEmp)
                        .TipoReserva(trsExterno)
                        .ConverterML(True)
                        .DesconsideraPedidosCorte(False)
                       ).fGetQuantidade();

        If (fltSalExt < 0) Then
          fltSalExt := 0;

        If (fCfgSis('MOVFUL', varString) = '2') Then
          fltSalExt := 0;

        If fltCnv_Ml > 0 Then
          fltSalDis := (FieldByName('SALDOS').AsFloat * fltCnv_Ml) + FieldByName('ITE_SAL_ML').AsFloat - fltSalRes - fltSalReG - fltSalExt
        Else
          fltSalDis := FieldByName('SALDOS').AsFloat - fltSalRes - fltSalReG - fltSalExt;
      End
      Else
      Begin
        fltSalRes := TSaldoReservado.New(
                       TReservaParametros.New()
                        .EmpresaItem(VS_strCodEmp)
                        .CodigoItem(FieldByName('CODITE').AsString)
                        .CodEmpresa(VS_strCodEmp)
                        .TipoReserva(trsPedidoVenda)
                        .ConverterML(True)
                        .DesconsideraPedidosCorte(False)
                       ).fGetQuantidade();

        fltSalReG := TSaldoReservado.New(
                       TReservaParametros.New()
                        .EmpresaItem(VS_strCodEmp)
                        .CodigoItem(FieldByName('CODITE').AsString)
                        .CodEmpresa(VS_strCodEmp)
                        .TipoReserva(trsGarantia)
                        .ConverterML(True)
                        .DesconsideraPedidosCorte(False)
                       ).fGetQuantidade();

        fltSalExt := TSaldoReservado.New(
                       TReservaParametros.New()
                        .EmpresaItem(VS_strCodEmp)
                        .CodigoItem(FieldByName('CODITE').AsString)
                        .CodEmpresa(VS_strCodEmp)
                        .TipoReserva(trsExterno)
                        .ConverterML(True)
                        .DesconsideraPedidosCorte(False)
                       ).fGetQuantidade();

        If (fltSalExt < 0) Then
          fltSalExt := 0;

        If (fCfgSis('MOVFUL', varString) = '2') Then
          fltSalExt := 0;

        fltSalDis := FieldByName('SALDOS').AsFloat - fltSalRes - fltSalReG - fltSalExt;
      End;

      Edit;
      FieldByName('SALDIS').AsFloat := fltSalDis;
      Post;

      Next;
    End;
  End;
end;

Procedure TLeDocumento.pCarregaArrClients(dtsDataSet: TfrxDBDataSet);
  Var
    intIndice: Integer;
Begin
  If Assigned(arrClients) And (Length(arrClients)> 0) Then
  Begin
    If Assigned(arrClients[0].cdsDados) Then
      dtsDataSet.DataSet := arrClients[0].cdsDados;

    For intIndice := Succ(Low(arrClients)) To High(arrClients) Do
      frxReport.DataSets.Add(arrClients[intIndice].frxDados);
  End;
End;

procedure TLeDocumento.pAjustaPesoVolumeLiquido(cdsTabGer, cdsTabDet: TZClient; blnDocSep : Boolean = False);

  function fRetVolumes: Double;
  Begin
    Result := 0;

    With cdsTabDet Do
    Begin
      First;
      While Not Eof Do
      Begin
        Result := Result + fCalcVolumes(
          FieldByName('CODITE').AsString,
          FieldByName('QTDITE').AsFloat,
          FieldByName('EMBALA').AsFloat);

        Next;
      End;
    End;
  End;

  procedure pCriaDataSetPeso(var cdsClient : TUniClientDataSet);
  begin

    If Assigned(cdsClient) Then
    Begin
      cdsClient.EmptyDataSet;
      Exit;
    End Else
      cdsClient := TUniClientDataSet.Create(Self);

    With cdsClient.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'PESLIQ';
      DataType := ftFloat;
      Required := False;
    End;

    With cdsClient.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'PESBRU';
      DataType := ftFloat;
      Required := False;
    End;

    With cdsClient.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'AUTDET';
      DataType := ftString;
      Required := False;
    End;

    cdsClient.CreateDataSet;

  end;

Var
  cdsPesLiqBru : TUniClientDataSet;

Begin

  pCriaDataSetPeso(cdsPesLiqBru);

  With cdsTabGer Do
  Begin
    Edit;
    FieldByName('VOLUME').AsFloat := fRetVolumes;
    FieldByName('PESBRU').AsFloat := fGetPesLiqOrBruSep(False, False,
                                                        FieldByName('NUMDOC').AsString,
                                                        FieldByName('ESPDOC').AsString,
                                                        FieldByName('CODEMP').AsString,
                                                        cdsPesLiqBru,
                                                        False,
                                                        blnDocSep);

    FieldByName('PESLIQ').AsFloat := fGetPesLiqOrBruSep(True, False,
                                                        FieldByName('NUMDOC').AsString,
                                                        FieldByName('ESPDOC').AsString,
                                                        FieldByName('CODEMP').AsString,
                                                        cdsPesLiqBru,
                                                        False,
                                                        blnDocSep);
    Post;
  End;

  fGetPesLiqOrBruSep(False,
                     False,
                     cdsTabGer.FieldByName('NUMDOC').AsString,
                     cdsTabGer.FieldByName('ESPDOC').AsString,
                     cdsTabGer.FieldByName('CODEMP').AsString,
                     cdsPesLiqBru,
                     True,
                     blnDocSep);

  If Not cdsPesLiqBru.IsEmpty Then
  Begin
    cdsPesLiqBru.First;
    While Not cdsPesLiqBru.Eof Do
    Begin
      If cdsTabDet.Locate('AUTDET', cdsPesLiqBru.FieldByName('AUTDET').AsString, []) Then
      Begin
        cdsTabDet.Edit;
        cdsTabDet.FieldByName('PESBRT').AsFloat := cdsPesLiqBru.FieldByName('PESBRU').AsFloat;
        cdsTabDet.FieldByName('PESLQD').AsFloat := cdsPesLiqBru.FieldByName('PESLIQ').AsFloat;
        cdsTabDet.Post;
      End;
      cdsPesLiqBru.Next;
    End;
  End;

End;

procedure TLeDocumento.pAjustarSequencia;
  var
    DataSet : TZClient;
    intIndice: Integer;
begin
  {Caso não tenha o campo SEQDET no fr3, sai do processo } 
  If Not fTemParametro(frxReport, 'SEQDET') Then
    Exit;
  {  Percorre os cds's para ver se algum deles tem o campo 
  seqdet, se tiver refaz a sequencia dos mesmo }
  For intIndice := Low(arrClients) To High(arrClients) Do
  Begin
    DataSet := arrClients[intIndice].cdsDados;
    If (Assigned(DataSet)) And (Assigned(DataSet.FindField('SEQDET'))) Then
    Begin
      dataSet.First;
      While not dataSet.Eof Do
      begin
        If ((dataSet.FieldByName('SEQDET').AsInteger) <> (dataSet.Recno)) Then
        Begin
          DataSet.Edit;
          DataSet.FieldByName('SEQDET').AsInteger := dataSet.Recno;
          DataSet.Post;
        End;
        DataSet.Next;
      End;
      DataSet.First;
    End;
  End;
End;


Procedure TLeDocumento.pSetaParametrosFr3Adicioanais(FReport: TfrxReport);
Begin
End;

Function TLeDocumento.fPreparaImpressaoDocumentos: Boolean;
Begin
  Try
    If blnMatricial Then
      pFiltraAcentos;

    frxReport.DataSets.Clear;

    If Assigned(fdbImpEti) Then
    Begin
      frxReport.DataSets.Add(fdbImpEti);
      pCarregaArrClients(fdbImpEti);
    End;

    If fTemParametro(frxReport, 'REIMPR') Then
      frxReport.Script.Variables['REIMPR'] := IfThen(recDocume.blnReimpr, 'S', 'N');

    If fTemParametro(frxReport, 'PERTOT') Then
      frxReport.Script.Variables['PERTOT'] := IfThen(recDocume.blnPerTot, 'S', 'N');

    If fTemParametro(frxReport, 'MSMVAL') Then
      frxReport.Script.Variables['MSMVAL'] := IfThen(fCfgSis('VFISPD', varBoolean), 'S', 'N');

    If fTemParametro(frxReport, 'VIADOC') Then
      frxReport.Script.Variables['VIADOC'] := '1';

    pSetaParametrosFr3Adicioanais(frxReport);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEditorFast.fPreparaImpressaoDocumentos]');
    End;
  End;
End;

procedure TLeDocumento.pInsereItensServico(cdsMovDet, cdsMovGer: TZClient);
  Var
    intContador: Integer;
Begin
  For intContador := 1 To 30 Do
  Begin

    If Not (fEmptyStr(cdsMovGer.FieldByName('DESS' + fStrZero(intContador, 2)).AsString)) Then
    With cdsMovDet Do
    Begin
      Insert;
      FieldByName('CODITE').AsString := cdsMovGer.FieldByName('CODS' + fStrZero(intContador, 2)).AsString;
      FieldByName('DESITE').AsString := cdsMovGer.FieldByName('DESS' + fStrZero(intContador, 2)).AsString;
      FieldByName('QTDITE').AsFloat  := cdsMovGer.FieldByName('QTDS' + fStrZero(intContador, 2)).AsFloat;
      FieldByName('VALUNI').AsFloat  := cdsMovGer.FieldByName('UNIS' + fStrZero(intContador, 2)).AsFloat;
      FieldByName('VALITE').AsFloat  := cdsMovGer.FieldByName('VALS' + fStrZero(intContador, 2)).AsFloat;
      FieldByName('UNIORI').AsFloat  := fCampoTabela('SER_VALSER', 'CADSER', ['SER_CODSER'], [cdsMovGer.FieldByName('CODS' + fStrZero(intContador, 2)).AsString], False);

      If (cdsMovGer.FindField('IDES' + fStrZero(intContador, 2)) <> Nil) And
         (MatchStr(cdsMovGer.FieldByName('IDES' + fStrZero(intContador, 2)).AsString, ['I','R'])) Then
      Begin
        FieldByName('VALUNI').Value  := Null;
        FieldByName('VALITE').Value  := Null;
      End;

      If FindField('CODPAR') <> nil Then
      Begin
        FieldByName('CODPAR').AsString := cdsMovGer.FieldByName('PARS' + fStrZero(intContador, 2)).AsString;
        FieldByName('NOMPAR').AsString := fRetNomeParceiro(FieldByName('CODPAR').AsString);
      End;

      If (Self Is TLeDocumentoPDOR) Then Begin
        FieldByName('MECPED').AsString := fRetornarMecanicosServicos('MECGOR', fStrZero(intContador, 2),
          cdsMovGer.FieldByName('AUTGER').AsString);

        If (cdsMovGer.FieldByName('BRIS' + fStrZero(intContador, 2)).AsString <> 'S') Then
          FieldByName('BRINDE').AsString := 'NÃO'
        Else
          FieldByName('BRINDE').AsString := 'SIM';
      End Else If (Self Is TLeDocumentoMIFF) Then
        FieldByName('MECSER').AsString := fRetornarMecanicosServicos('MECGER', fStrZero(intContador, 2),
          cdsMovGer.FieldByName('AUTGER').AsString);

      If (FindField('NUMDOC') <> Nil) And (cdsMovGer.FindField('NUMDOC') <> Nil) Then
        FieldByName('NUMDOC').AsString := cdsMovGer.FieldByName('NUMDOC').AsString;

      Post;
    End;

  End;
End;

procedure TLeDocumento.pInsereTotalServicoValorOriginal(cdsMovGer: TZClient);
var
  intContador: Integer;
  fltValorServico: Double;
  fltQtdServico: Double;
begin
  If cdsMovGer.FindField('TOSEOR') = Nil Then
    Exit;

  For intContador := 1 To 30 Do
  Begin
    If Not (fEmptyStr(cdsMovGer.FieldByName('DESS' + fStrZero(intContador, 2)).AsString)) Then
    Begin
      fltValorServico := fCampoTabela('SER_VALSER', 'CADSER', ['SER_CODSER'], [cdsMovGer.FieldByName('CODS' + fStrZero(intContador, 2)).AsString], False);
      fltQtdServico := cdsMovGer.FieldByName('QTDS' + fStrZero(intContador, 2)).AsFloat;

      cdsMovGer.Edit;
      cdsMovGer.FieldByName('TOSEOR').AsFloat := (cdsMovGer.FieldByName('TOSEOR').AsFloat + (fltValorServico * fltQtdServico));
      cdsMovGer.Post;
    End;
  End;
end;

procedure TLeDocumento.pInsereItensMadeireira(cdsItens: TZClient);
  Var
    cdsDados: TUniClientDataSet;
    cdsAux  : TUniClientDataSet;
Begin
  With recDocume Do
  If blnVendaMadOuVidOuMtL And (Pos(strEspDoc,'GA_GC_') <= 0) Then
  Begin
    cdsAux := fCriaClientDatset(cdsItens);
    blnVendaMadOuVidOuMtL := fCarregaItensMadeiraImpressao(cdsAux, cdsDados, blnDocSep, blnQtdOri, strEspDoc, strSaida);

    If blnVendaMadOuVidOuMtL Then
    Begin
      cdsItens.IndexName := '';//Remove a ordenacao, deve respeitar a ordem dos registros criados na funcao fCarregaItensMadeiraImpressao
      cdsItens.Data := cdsDados.Data;
      cdsItens.First;
    End;

    FreeAndNil(cdsDados);
    FreeAndNil(cdsAux);
  End;
End;

Function TLeDocumento.fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean;
Begin
  Result := False;
End;

Function fEspecieToClassDocumento(strNumDoc,
                                  strEspDoc,
                                  strCodEmp,
                                  strTip_FC: String;
                                  blnDocSep,
                                  blnRequisicao,
                                  blnImpSepRomaneio: Boolean;
                                  tpeTipEtq: TTipoEtiqueta = tpeNenhum): TClassLeDocumento;
Begin
  Case fEspecieToTipoDocumeto(strNumDoc, strEspDoc, strCodEmp, strTip_FC, blnDocSep, blnRequisicao, blnImpSepRomaneio, IIf(tpeTipEtq = tpeReqMaterialConsumo, False, True), tpeTipEtq) Of
    docMI,
    docFF,
    docBR,
    docTR,
    docDV,
    docAJ,
    docTA,
    docEP,
    docBE,
    docUS,
    docCS,
    docCR,
    docTE,
    docPI,
    docNF,
    docNS,
    docSF,
    docIF,
    docTicketNF,
    docTicketDV,
    docD1,
    docGF,
    docContGF,
    docSepSF,
    docSepNota,
    docSepNotaObs,
    docRequisicao,
    docRL,
    docRB : Result := TLeDocumentoMIFF;

    docFaturaLocacao : Result := TLeDocumentoFaturaLoc;

    docPA : Result := TLeDocumentoPA;
    docROTin : Result := TLeDocumentoROTin;
    docSeparacaoGondola: Result := TLeDocumentoSeparacaoGondola;
    docGA,
    docContGR,
    docContGRBaixa,
    docContGC  : Result := TLeDocumentoGA;
    docSolicitacaoManutencaoEquipamentos  : Result := TLeDocumentoSolicitacaoManutencaoEquipamentos;
    docPedidoCompra : Result := TLeDocumentoPedidoCompra;

    docPD,
    docOR,
    docPR,
    docRecAmostra,
    docSepPedido,
    docPDExterior,
    docORExterior : Result := TLeDocumentoPDOR;

    docOrdemServico,
    docOrdemServicoTermoResp,
    docOrdemServicoTermoDev,
    docOrdemServicoOrdExecucao: Result := TLeDocumentoOrdemServico;

    docOrdemServicoImagem: Result := TLeDocumentoOrdemServicoImagem;

    docOrdProImobiliaria: Result := TLeOrdProTintasImobiliaria;
    docOrdProAutomotiva: Result := TLeOrdProTintasAutomotiva;

    docSepItem: Result := TLeDocumentoIT;

    docSepRomaneio: Result := TLeDocumentoRO;
    docCupomServico: Result := TLeDocumentoCupomServico;
    docReqMaterialConsumo : Result := TLeDocumentoReqMaterialConsumo;
    docReqMaterialConsumoVidro : Result := TLeDocumentoMIFF;

    docOrdPro : Result := TLeDocumentoOrdemProducao;

    docCarnePagamento,
    docDuplicata: Result := TLeDocumentoCPDP;


    docComprovanteGeracaoCredito: Result := TLeDocumentoCGC;

    docProcessoDeExtrusao: Result := TLeDocumentoPE;

    docInspecaoEnt,
    docInspecaoSai : Result := TLeDocumentoINSES;

    docLiberacaoArmazenagem: Result := TLeDocumentoLA;

    docLocacaoEquipamento,
    docDevolucaoLocacao: Result := TLeDocumentoLE;

    docEnderecamentoDeProduto: Result := TLeDocEnderecamentoProduto;

    docCupomPromocao: Result := TLeDocumentoCupomPromo;

    docRemessaDevolucao: Result := TLeDocumentoRD;
    docFFDocumentosCR : Result := TLeDocumentoCRFF;
    docCupomProxDesc : Result := TLeDocCupomProxDesc;
    Else  Result := Nil;
  End;
End;

Function TLeDocumento.fSQLFornecedor: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + '  SELECT SQL_NO_CACHE                       ';

  strSQL := strSQL + '    CAST(FOR_CGCCPF AS UNSIGNED) AS COCFOC, ';
  strSQL := strSQL + '    FOR_CODFOR                   AS CODFOR, ';
  strSQL := strSQL + '    FOR_NOMFOR                   AS NOMEFC, ';
  strSQL := strSQL + '    FOR_NOMFAN                   AS FORFAN, ';
  strSQL := strSQL + '    FOR_ENDERE                   AS ENDDFC, ';
  strSQL := strSQL + '    FOR_ENDNUM                   AS NUMEFC, ';
  strSQL := strSQL + '    FOR_ENDCOM                   AS COMPFC, ';
  strSQL := strSQL + '    FOR_BAIRRO                   AS BAIRFC, ';
  strSQL := strSQL + '    FOR_C_E_P_                   AS CEP_FC, ';

  strSQL := strSQL + '    FOR_CODCID                   AS CCIDFC, ';
  strSQL := strSQL + '    C.CID_NOMCID                 AS NCIDFC, ';
  strSQL := strSQL + '    C.CID_ESTADO                 AS ESTAFC, ';

  strSQL := strSQL + '    FOR_FONE01                   AS FONEFC, ';

  strSQL := strSQL + '    FOR_C_G_C_                   AS CGC_FC, ';
  strSQL := strSQL + '    FOR_I_E_S_                   AS IES_FC, ';
  strSQL := strSQL + '    FOR_CODATI                   AS ATIFOR, ';
  strSQL := strSQL + '    ATI_DESATI                   AS DESATF, ';

  strSQL := strSQL + '    CAST(IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%", :CGCCPF, FOR_CGCCPF) AS UNSIGNED) AS COCFOR, ';
  strSQL := strSQL + '    IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",      :NOMCON, FOR_NOMFOR)              AS NOMFOR, ';
  strSQL := strSQL + '    IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",      :ENDCON, FOR_ENDERE)              AS ENDFOR, ';
  strSQL := strSQL + '    IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%","", FOR_ENDNUM)                         AS NUMFOR, ';
  strSQL := strSQL + '    IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%","", FOR_ENDCOM)                         AS COMFOR, ';
  strSQL := strSQL + '    IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",      :BAICON, FOR_BAIRRO)              AS BAIFOR, ';
  strSQL := strSQL + '    IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",      :CEPCON, FOR_C_E_P_)              AS CEPFOR, ';
  strSQL := strSQL + '    IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",      :CIDCON, FOR_CODCID)              AS CIDFOR, ';
  strSQL := strSQL + '    IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%", N.CID_NOMCID, C.CID_NOMCID)            AS NCIFOR, ';
  strSQL := strSQL + '    IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%", N.CID_ESTADO, C.CID_ESTADO)            AS ESTFOR, ';
  strSQL := strSQL + '    IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",      :TELCON, FOR_FONE01)              AS FONFOR, ';
  strSQL := strSQL + '    IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",      :R_GCON, " "        )             AS NRGFOR, ';
  strSQL := strSQL + '    IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",      :CGCCON, FOR_C_G_C_)              AS CGCFOR, ';
  strSQL := strSQL + '    IF(FOR_NOMFOR LIKE "%CONSUMIDOR%" OR FOR_NOMFOR LIKE "%BALCAO%" OR FOR_NOMFOR LIKE "%BALCÃO%" OR FOR_NOMFOR LIKE "%SEGURADORA%",      :IESCON, FOR_I_E_S_)              AS IESFOR, ';
  strSQL := strSQL + '    FOR_DTACAD AS DTCAFO, ';
  strSQL := strSQL + '    FOR_ULTALT AS ULALFO, ';
  strSQL := strSQL + '    FOR_CONTAT AS CONTFO, ';
  strSQL := strSQL + '    FOR_CAIPOS AS CAPOFO, ';
  strSQL := strSQL + '    FOR_FONE02 AS FONFC2, ';
  strSQL := strSQL + '    FOR_F_A_X_ AS FAXFOR, ';
  strSQL := strSQL + '    FOR_EMAIL_ AS EMAFOR, ';
  strSQL := strSQL + '    FOR_EMAIL2 AS EMAFO2, ';
  strSQL := strSQL + '    FOR_EMAIL3 AS EMAFO3, ';
  strSQL := strSQL + '    FOR_CNDPAG AS CNDPFO  ';

  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    CADFOR   ';

  strSQL := strSQL + '  INNER JOIN CADATI   ON   ATI_CODATI = FOR_CODATI ';
  strSQL := strSQL + '  INNER JOIN CADCID C ON C.CID_CODCID = FOR_CODCID ';
  strSQL := strSQL + '  LEFT  JOIN CADCID N ON N.CID_CODCID = :CIDCON    ';

  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    FOR_CODFOR = :CODFOR ';

  Result := strSQL;
End;

Function TLeDocumento.fInsereClientFornecedor: Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLFornecedor);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxFornecedor';
    frxDados.UserName := 'frxFornecedor';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery Do
  Begin

    pSetaParametrosCadFor;

    Result := fAbreClient(True, 'fInsereClientFornecedor');

    If Not cdsDados.IsEmpty Then
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('CGC_FC').AsString := fFormataCpfCgc(FieldByName('CGC_FC').AsString, FPais);
      cdsDados.FieldByName('CGCFOR').AsString := fFormataCpfCgc(FieldByName('CGCFOR').AsString, FPais);
      cdsDados.Post;
    End;

  End;

End;

Procedure TLeDocumento.pSetaParametrosCadFor;
Begin
  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('CODFOR').AsString := strCodCli;
 End;
End;

Function TLeDocumento.fSQLTipoFrete(strCamFre: String): String;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  strSQL := '';
  strSQL := strSQL + ' (CASE ' + strCamFre + ' ';

  For intContador := Low(TiposFrete) To High(TiposFrete) Do
      strSQL := strSQL + '   WHEN ' + intToStr(TiposFrete[intContador])  + ' THEN "' + DescricoesFrete[intContador] + '" ';

  strSQL := strSQL + ' END) ';

  Result := strSQL;
End;

Procedure TLeDocumento.pFiltraAcentosClient(cdsDados: TZClient);
  Var
    intContador: Integer;
Begin
  With cdsDados Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      For intContador := 0 To Fields.Count - 1 Do
      Begin
        If Fields[intContador].DataType = ftString Then
          Fields[intContador].AsString := fRemoveAcento(Fields[intContador].AsString);
      End;
      Post;
      Next;
    End;
    First;
  End;

End;

Procedure TLeDocumento.pFiltraAcentos;
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrClients) To High(arrClients) Do
    If Assigned(arrClients[intContador].cdsDados) Then
      pFiltraAcentosClient(arrClients[intContador].cdsDados);
End;

procedure TLeDocumento.pInsereVendedorCupomPromocao(cdsCupPro: TZClient; strCodEmp, strNumDoc, strEspDoc: String);
var
  strCodVen: String;
  LTotal: Integer;
begin

  If cdsCupPro.FindField('CODVEN') = Nil Then
    Exit;

  If Pos(cdsCupPro.FieldByName('ESPDOC').AsString, 'NF_IF_FF') > 0 then
  begin
    strCodVen := fCampoTabela('GER_CODVEN', 'MOVGER', ['GER_CODEMP', 'GER_NUMDOC', 'GER_ESPDOC'], [strCodEmp, strNumDoc, strEspDoc], False);
  end

  else
  If Pos(cdsCupPro.FieldByName('ESPDOC').AsString, 'PD') > 0 then
  begin
    strCodVen := fCampoTabela('FGO_CODVEN', 'FATGOR', ['FGO_CODEMP', 'FGO_NUMDOC', 'FGO_ESPDOC'], [strCodEmp, strNumDoc, strEspDoc], False);
  end;

  LTotal := cdsCupPro.RecordCount;

  cdsCupPro.First;
  while not cdsCupPro.Eof do
  begin
    cdsCupPro.Edit;
    cdsCupPro.FieldByName('CODVEN').AsString := strCodVen;

    if (cdsCupPro.FindField('TOTCUP') <> nil) then
      cdsCupPro.FieldByName('TOTCUP').AsInteger := LTotal;

    cdsCupPro.Post;
    cdsCupPro.Next;
  end;

end;

Procedure TLeDocumento.pInsereQtdeDevolvidasEntregaFutura(cdsTabGer, cdsTabDet: TZClient);
Var
  DataSet : TUniQuery;
begin

    If cdsTabDet.IsEmpty Then
      Exit;

    DataSet := fCriaQuery;

    try

      cdsTabDet.First;

      While Not cdsTabDet.Eof Do
      Begin

        DataSet.Close;
        DataSet.SQL.Clear;
        DataSet.SQL.Add('SELECT ');
        DataSet.SQL.Add('  SUM(DVDF.DET_QTDITE) AS QTDDEV ');
        DataSet.SQL.Add('FROM ');
        DataSet.SQL.Add('  MOVDET DF ');
        DataSet.SQL.Add('INNER JOIN MOVDET DVDF ');
        DataSet.SQL.Add('  ON DVDF.DET_DOCDEV = DF.DET_NUMDOC ');
        DataSet.SQL.Add(' AND DVDF.DET_ESPDEV = DF.DET_ESPDOC ');
        DataSet.SQL.Add(' AND DVDF.DET_EMPDEV = DF.DET_CODEMP ');
        DataSet.SQL.Add(' AND DVDF.DET_CODCLI = DF.DET_CODCLI ');
        DataSet.SQL.Add(' AND DVDF.DET_TIP_FC = DF.DET_TIP_FC ');
        DataSet.SQL.Add(' AND DVDF.DET_CODITE = DF.DET_CODITE ');
        DataSet.SQL.Add(' AND DVDF.DET_UNITAR = DF.DET_UNITAR ');
        DataSet.SQL.Add('WHERE DF.DET_DOCFUT = "'+cdsTabGer.FieldByName('NUMDOC').AsString+'"');
        DataSet.SQL.Add('  AND DF.DET_ESPFUT = "'+cdsTabGer.FieldByName('ESPDOC').AsString+'"');
        DataSet.SQL.Add('  AND DF.DET_EMPFUT = "'+cdsTabGer.FieldByName('CODEMP').AsString+'"');
        DataSet.SQL.Add('  AND DF.DET_CODCLI = "'+cdsTabGer.FieldByName('CODCLI').AsString+'"');
        DataSet.SQL.Add('  AND DF.DET_CODITE = "'+cdsTabDet.FieldByName('DET_CODITE').AsString+'"');
        DataSet.SQL.Add('  AND DF.DET_TIP_FC = "'+cdsTabDet.FieldByName('DET_TIP_FC').AsString+'"');
        DataSet.SQL.Add('  AND DF.DET_UNITAR = ' +StringReplace(cdsTabDet.FieldByName('DET_UNITAR').AsString, ',', '.',[]));
        DataSet.Open;

        if Not(DataSet.isEmpty) Then
        begin
          cdsTabDet.Edit;
          cdsTabDet.FieldByName('QTDSDV').AsFloat := DataSet.FieldByName('QTDDEV').AsFloat;
          cdsTabDet.Post;
        end;

        cdsTabDet.Next;

      End;

   finally
     FreeAndNil(DataSet);
   end;

end;

end.


