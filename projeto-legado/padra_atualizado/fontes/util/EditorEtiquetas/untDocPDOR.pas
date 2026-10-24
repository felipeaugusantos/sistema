unit untDocPDOR;

interface

uses Classes, StrUtils, SysUtils, frxClass, frxDBSet, UniClientDataSet, Controls,
  untTypesSistema, untLeDocumento, untFuncoesSimples, untZClient, Uni,
  System.Variants, untFuncoesEditorFast, untFuncoesGenerica, untValorPorExtenso,
  untSaldoLojas, untFuncTinta, System.NetEncoding, Vcl.Graphics,
  Vcl.Imaging.jpeg, Winapi.Windows;

Type

  TLeDocumentoPDOR = Class(TLeDocumento)
  Private
    FPais: TPais;
    FClaIpi: TStringList;
    FLegIPI: String;
    strTotUni : String;

    FSetores: TStringList;

    cdsFatGor,
    cdsFatDor: TZClient;

    function fRetLotDor : String;

    Function fSQLFatGor: String;
    Function fSQLTabPre: String;
    function fGetSqlGroupByPedOrc: String;
    function fSqlCampoSetor: String;

    Function fInsereClientFatGor: Boolean;
    Function fInsereClientFatDor: Boolean;
    Function fMarcaPedidoComoImpresso: Boolean;

    Procedure pSetaNomeTabela;
    Procedure pSetaTotalUni;
    Procedure pSetaNumeroItens(intNroItens: Integer);
    procedure pCarregaItensLogSeparacaoImpressao(cdsLogSep       : TUniClientDataSet;
                                                 cdsImpLogSep    : TZClient;
                                                 blnEnt_CD,
                                                 blnLocFisEmpEmi : Boolean;
                                                 blnTemServico   : Boolean = False);
    procedure pCriaListaSetores;
    Procedure pCriaListaClassificacao;
    Procedure pMontaListaClassificacao;
    Procedure pMontaDuplicatas;
    Procedure pMontaListaCadRec;
    Procedure pDescontoItensPromoção;
    Procedure pMontaFormaPagamento;
    Procedure pCarregarNCM;
    procedure pOtimizaImagensProduto(strNumdoc, strEspdoc, strCodemp, strCodCli: String);
    function fRetEmpresaCabecalho(strCodEmp: String): String;

    procedure pMontaDesmembramento;
    procedure pMontaMensagemClassificacaoFiscal;

    function fRetTiposEmbalagensItem(pQtdIte : Double; pCodIte : String) : String;
    procedure pMontaItensEstrutura;
    procedure pMontaItensEstruturaVidro;
    function fRetCampoValorItem(strCmpOri, strCalQtd, strNomFin: String; blnPorQtd: Boolean = False): String;

    function fUtilizaImagemOtimizada: Boolean;
  Public
    class var blnOcultarMarca: Boolean;
    constructor Create(Owner: TComponent); Override;
    Destructor  Destroy; Override;

    procedure pSetaParametrosFr3Adicioanais(FReport: TfrxReport); Override;
    Function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; Override;

    {** Funções em class function para ser possível exportar a "fSQLQtdIte" **}
    class function fSQLQtdIte(const recDocume : TRecDocumento):String;
    class function fRetEhReimpressaoDeDocumentoCanceladoWMS(const recDocume : TRecDocumento) : Boolean;
    class function fRetEhImpressaoDeDocumentoBaixadoWMS(const recDocume : TRecDocumento): Boolean;
    class function fGetSqlQtdItePedOrc(const recDocume : TRecDocumento): String;
    class function fGetSQLQtdBaixada(const recDocume : TRecDocumento): String;
    class function fGetSqlQtdEmbPedOrc(const recDocume : TRecDocumento): String;
    class function fRetPedidoBaixadoNaoSeraEntregue(const recDocume : TRecDocumento): Boolean;
    class function fTemDel_LotDor(const recDocume : TRecDocumento) : Boolean;

    Function fSQLItems: String; override;

  protected
    Procedure pSetaParametrosCadcli; Override;
  End;

implementation

uses untConstantes, Data.DB, Math, untQckSintetizaItensSep, System.RegularExpressions,
  untImagemBase64, untFuncoesImagem;

constructor TLeDocumentoPDOR.Create(Owner: TComponent);
Begin
  Inherited Create(Owner);
  pSetaNomeTabela;
  pCriaListaSetores;
  pCriaListaClassificacao;
End;

class function TLeDocumentoPDOR.fGetSQLQtdBaixada(const recDocume : TRecDocumento): String;
begin
  {********************************************************}
  {* CFG_IMSEPO DEFINE SE A QUANTIDADE SERÁ CALCULADA POR *}
  {* PRODUTOS EXPEDIDOS PARCIALMENTE OU                   *}
  {* PRODUTOS FATURADOS PARCIALMENTE                      *}
  {*****************************************************MM*}
  If recDocume.blnDocSep And fPermiteImprimirSeparacaoParcial Then
    Result := 'FDO_QTDBAI'
  Else If recDocume.blnDocSep Then
    Result := IIF(fCfgSis('IMSEPO', varString) = 'F', 'FDO_QTDBAI', '(FDO_QTDBAI + FDO_QTDEXP)')
  Else
    Result := 'FDO_QTDBAI';

  Result := 'IF(FDO_JAFATU = 1, FDO_QTDITE, ' + Result + ')';
end;

Destructor TLeDocumentoPDOR.Destroy;
Begin
  Inherited;

  FreeAndNil(FClaIpi);
  FreeAndNil(FSetores);
End;

Function TLeDocumentoPDOR.fSqlFatGor: String;
  Var
    strFatGor, strSQLMecGo: String;
Begin
  strFatGor := '';
  strFatGor := strFatGor + 'SELECT SQL_NO_CACHE     ';

  strFatGor := strFatGor + '  IF(FGO_NUMFAT IS NULL OR FGO_NUMFAT = "", " ", CONCAT(FGO_NUMFAT, "-", FGO_TIPFAT, "-", FGO_EMPFAT)) AS NROFAT, ';

  strFatGor := strFatGor + '  (SELECT GROUP_CONCAT( IF(F2.FGO_NUMFAT IS NULL OR F2.FGO_NUMFAT = "", " ", CONCAT(F2.FGO_NUMDOC, "-", F2.FGO_ESPDOC, "-", F2.FGO_CODEMP))) FROM ';
  strFatGor := strFatGor + '    FATGOR F2 WHERE F2.FGO_TIPFAT = F.FGO_ESPDOC AND F2.FGO_NUMFAT = F.FGO_NUMDOC AND F2.FGO_EMPFAT = F.FGO_CODEMP) AS NROORC, ';

  strFatGor := strFatGor + 'TT.CLI_TELCTT AS TELCTA, ';
  strFatGor := strFatGor + 'TT.CLI_EMACTT AS EMACTA, ';
  strFatGor := strFatGor + 'TT.CLI_CELCTT AS CELCTT, ';
  strFatGor := strFatGor + 'TT.CLI_FAXCTT AS FAXCTT, ';
  strFatGor := strFatGor + 'CCID.CID_NOMCID AS CIDCTT, ';
  strFatGor := strFatGor + 'CCID.CID_ESTADO AS ESTCTT, ';
  strFatGor := strFatGor + 'TT.CLI_CGOCTT AS CGOCTT, ';
  strFatGor := strFatGor + 'TT.CLI_DPTCTT AS DPTCTT, ';
  strFatGor := strFatGor + 'TT.CLI_DEPCTT AS DEPCTT, ';
  strFatGor := strFatGor + 'TT.CLI_OBSERV AS OBSERV, ';

  strFatGor := strFatGor + '  " " AS DOCCAN, ';
  strFatGor := strFatGor + '  " " AS MOTDEL, ';
  strFatGor := strFatGor + '  " " AS DTADEL, ';
  strFatGor := strFatGor + '  " " AS OPEDEL, ';

  strFatGor := strFatGor + '  IF ( C.CLI_ZONFRA = "S", FGO_DESESP, 0 ) AS DESC_IMP, ';
  strFatGor := strFatGor + '  ADDDATE(FGO_DTAENT, :ORCVEN) AS VENC_ORC, ';

  strFatGor := strFatGor + '  FGO_CODDIG    AS CODDIG, ';
  strFatGor := strFatGor + '  OD.OPE_NOMOPE AS NOMDIG, ';
  strFatGor := strFatGor + '  FGO_PREVIS AS PREVIS, ';
  strFatGor := strFatGor + '  FGO_DTAENT AS DTAENT, ';
  strFatGor := strFatGor + '  DATE_FORMAT(FGO_DTAENT, "%d/%b/%y") AS DTADOC, ';
  strFatGor := strFatGor + '  FGO_NUMDOC AS NUMDOC, ';
  strFatGor := strFatGor + '  CONCAT(FGO_NUMDOC, "-", YEAR(CURRENT_DATE)) AS DOCANO, ';
  strFatGor := strFatGor + '  FGO_ESPDOC AS ESPDOC, ';
  strFatGor := strFatGor + '  FGO_CODEMP AS CODEMP, ';
  strFatGor := strFatGor + '  FGO_SERIE_ AS SERDOC, ';
  strFatGor := strFatGor + '  FGO_CODCLI AS CODCLI, ';
  strFatGor := strFatGor + '  FGO_NUMPOK AS NUMPOK, ';
  strFatGor := strFatGor + '  FGO_DTAORI AS DTAORI, ';
  strFatGor := strFatGor + '  FGO_TIPOPE AS TIPOPE, ';
  strFatGor := strFatGor + '  FGO_NUMGUI AS NUMGUI, ';
  strFatGor := strFatGor + '  FGO_NTRAVA AS NTRAVA, ';

  strFatGor := strFatGor + '  FGO_DTALIB AS DTALIB, ';
  strFatGor := strFatGor + '  FGO_HORLIB AS HORLIB, ';
  strFatGor := strFatGor + '  FGO_DIGLIB AS DIGLIB, ';

  strFatGor := strFatGor + '     FGO_CODVEN AS CODVEN, ';
  strFatGor := strFatGor + '  OV.OPE_NOMOPE AS NOMVEN, ';
  strFatGor := strFatGor + '  OV.OPE_E_MAIL AS EMAVEN, ';
  strFatGor := strFatGor + '  OV.OPE_FONE01 AS FO1VEN, ';
  strFatGor := strFatGor + '  OV.OPE_FONE02 AS FO2VEN, ';

  strFatGor := strFatGor + '     FGO_OPEEXP AS OPEEXP, ';
  strFatGor := strFatGor + '  OX.OPE_NOMOPE AS NOPEEX, ';
  strFatGor := strFatGor + '     FGO_SEPEXP AS SEPEXP, ';

  If (fUsaRotinaWMS And recDocume.blnDocSep) Or (fRetEhReimpressaoDeDocumentoCanceladoWMS(recDocume)) Then
    strFatGor := strFatGor + '(SELECT IFNULL(  GROUP_CONCAT(DISTINCT CADOPE.OPE_NOMOPE ), OS.OPE_NOMOPE ) FROM ' + fRetLotDor +
                             ' INNER JOIN FATDOR ON FATDOR.AUTOINCREM = LDO_SEQFDO '+
                             ' LEFT  JOIN CADOPE ON CADOPE.OPE_CODOPE = LDO_CODSEP '+
                             ' WHERE FATDOR.FDO_SEQGER = F.AUTOINCREM) AS NSEPEX, '
  Else
    strFatGor := strFatGor + '  OS.OPE_NOMOPE AS NSEPEX, ';

  strFatGor := strFatGor + '  FGO_CONPAG AS CONPAG, ';
  strFatGor := strFatGor + '  "S"        AS AVISTA, ';

  If recDocume.blnPenExp Then
    strFatGor := strFatGor + ' "S" AS IMPDPN, '
  Else
    strFatGor := strFatGor + ' "N" AS IMPDPN, ';

  strFatGor := strFatGor + '  FGO_CODCND AS CODCND, ';
  strFatGor := strFatGor + '  CND_DESCRI AS DESCND, ';
  strFatGor := strFatGor + '  CND_PRZMED AS CNDPRZ, ';

  strFatGor := strFatGor + '  FGO_CODFPG AS CODFPG, ';
  strFatGor := strFatGor + '  FPG_DESCRI AS DESFPG, ';

  strFatGor := strFatGor + '  FGO_TOTPRO AS TOTPRO, ';
  strFatGor := strFatGor + '  FGO_TOTCUS AS TOTCUS, ';
  strFatGor := strFatGor + '  FGO_DESESP AS DESESP, ';
  strFatGor := strFatGor + '  FGO_PORDES AS PORDES, ';
  strFatGor := strFatGor + '  FGO_BASRET AS BASRET, ';
  strFatGor := strFatGor + '  FGO_ALQRET AS ALQRET, ';
  strFatGor := strFatGor + '  FGO_TOTRET AS TOTRET, ';
  strFatGor := strFatGor + '  FGO_BASICM AS BASICM, ';
  strFatGor := strFatGor + '  FGO_ALQICM AS ALQICM, ';
  strFatGor := strFatGor + '  FGO_TOTICM AS TOTICM, ';
  strFatGor := strFatGor + '  FGO_BASIPI AS BASIPI, ';
  strFatGor := strFatGor + '  FGO_ALQIPI AS ALQIPI, ';
  strFatGor := strFatGor + '  FGO_TOTIPI AS TOTIPI, ';
  strFatGor := strFatGor + '  IFNULL(EG.FGO_TOTCBS, 0) AS TOTCBS, ';
  strFatGor := strFatGor + '  IFNULL(EG.FGO_TOTIBS, 0) AS TOTIBS, ';
  strFatGor := strFatGor + '  IFNULL(EG.FGO_TOT_IS, 0) AS TOT_IS, ';

  strFatGor := strFatGor + '  FGO_CODTRA    AS CODTRA, ';
  strFatGor := strFatGor + '  T.TRA_NOMTRA  AS NOMTRA, ';
  strFatGor := strFatGor + '  T.TRA_ENDERE  AS ENDTRA, ';
  strFatGor := strFatGor + '  T.TRA_BAIRRO  AS BAITRA, ';
  strFatGor := strFatGor + '  T.TRA_C_E_P_  AS CEPTRA, ';
  strFatGor := strFatGor + '  T.TRA_FONE01  AS FONTRA, ';
  strFatGor := strFatGor + '  CT.CID_NOMCID AS CIDTRA, ';
  strFatGor := strFatGor + '  CT.CID_ESTADO AS ESTTRA, ';
  strFatGor := strFatGor + '  T.TRA_C_G_C_  AS CGCTRA, ';
  strFatGor := strFatGor + '  T.TRA_NOMFAN  AS FANTRA, ';

  strFatGor := strFatGor + '  FGO_TIPFRE AS TIPFRE, ';
  strFatGor := strFatGor +    fSQLTipoFrete('FGO_TIPFRE') + ' AS DESFRE, ';
  strFatGor := strFatGor + '  FGO_TOTFRE AS TOTFRE, ';
  strFatGor := strFatGor + '  FGO_PESBRU AS PESBRU, ';
  strFatGor := strFatGor + '  FGO_PESLIQ AS PESLIQ, ';
  strFatGor := strFatGor + '  FGO_VOLUME AS VOLUME, ';
  strFatGor := strFatGor + '  FGO_VOLUME AS VOLDIG, ';

  strFatGor := strFatGor + '  FGO_BASSIM AS BASSIM, '; // ?
  strFatGor := strFatGor + '  FGO_MARCA_ AS MARCA_, '; // ?
  strFatGor := strFatGor + '  FGO_ESPECI AS ESPECI, '; // ?

  strFatGor := strFatGor + '  FGO_MEN001 AS MEN001, ';
  strFatGor := strFatGor + '  FGO_MEN002 AS MEN002, ';

  strFatGor := strFatGor + '  AUX_MEN003 AS MEN003, ';
  strFatGor := strFatGor + '  AUX_MEN004 AS MEN004, ';
  strFatGor := strFatGor + '  AUX_MEN005 AS MEN005, ';

  strFatGor := strFatGor + '  F.AUTOINCREM AS AUTGER, ';

  strFatGor := strFatGor + '  FGO_CODS01 AS CODS01, ';
  strFatGor := strFatGor + '  FGO_CODS02 AS CODS02, ';
  strFatGor := strFatGor + '  FGO_CODS03 AS CODS03, ';
  strFatGor := strFatGor + '  FGO_CODS04 AS CODS04, ';
  strFatGor := strFatGor + '  FGO_CODS05 AS CODS05, ';
  strFatGor := strFatGor + '  FGO_CODS06 AS CODS06, ';
  strFatGor := strFatGor + '  FGO_CODS07 AS CODS07, ';
  strFatGor := strFatGor + '  FGO_CODS08 AS CODS08, ';
  strFatGor := strFatGor + '  FGO_CODS09 AS CODS09, ';
  strFatGor := strFatGor + '  FGO_CODS10 AS CODS10, ';
  strFatGor := strFatGor + '  FGO_CODS11 AS CODS11, ';
  strFatGor := strFatGor + '  FGO_CODS12 AS CODS12, ';
  strFatGor := strFatGor + '  FGO_CODS13 AS CODS13, ';
  strFatGor := strFatGor + '  FGO_CODS14 AS CODS14, ';
  strFatGor := strFatGor + '  FGO_CODS15 AS CODS15, ';
  strFatGor := strFatGor + '  FGO_CODS16 AS CODS16, ';
  strFatGor := strFatGor + '  FGO_CODS17 AS CODS17, ';
  strFatGor := strFatGor + '  FGO_CODS18 AS CODS18, ';
  strFatGor := strFatGor + '  FGO_CODS19 AS CODS19, ';
  strFatGor := strFatGor + '  FGO_CODS20 AS CODS20, ';
  strFatGor := strFatGor + '  FGO_CODS21 AS CODS21, ';
  strFatGor := strFatGor + '  FGO_CODS22 AS CODS22, ';
  strFatGor := strFatGor + '  FGO_CODS23 AS CODS23, ';
  strFatGor := strFatGor + '  FGO_CODS24 AS CODS24, ';
  strFatGor := strFatGor + '  FGO_CODS25 AS CODS25, ';
  strFatGor := strFatGor + '  FGO_CODS26 AS CODS26, ';
  strFatGor := strFatGor + '  FGO_CODS27 AS CODS27, ';
  strFatGor := strFatGor + '  FGO_CODS28 AS CODS28, ';
  strFatGor := strFatGor + '  FGO_CODS29 AS CODS29, ';
  strFatGor := strFatGor + '  FGO_CODS30 AS CODS30, ';

  strFatGor := strFatGor + '  FGO_DESS01 AS DESS01, ';
  strFatGor := strFatGor + '  FGO_DESS02 AS DESS02, ';
  strFatGor := strFatGor + '  FGO_DESS03 AS DESS03, ';
  strFatGor := strFatGor + '  FGO_DESS04 AS DESS04, ';
  strFatGor := strFatGor + '  FGO_DESS05 AS DESS05, ';
  strFatGor := strFatGor + '  FGO_DESS06 AS DESS06, ';
  strFatGor := strFatGor + '  FGO_DESS07 AS DESS07, ';
  strFatGor := strFatGor + '  FGO_DESS08 AS DESS08, ';
  strFatGor := strFatGor + '  FGO_DESS09 AS DESS09, ';
  strFatGor := strFatGor + '  FGO_DESS10 AS DESS10, ';
  strFatGor := strFatGor + '  FGO_DESS11 AS DESS11, ';
  strFatGor := strFatGor + '  FGO_DESS12 AS DESS12, ';
  strFatGor := strFatGor + '  FGO_DESS13 AS DESS13, ';
  strFatGor := strFatGor + '  FGO_DESS14 AS DESS14, ';
  strFatGor := strFatGor + '  FGO_DESS15 AS DESS15, ';
  strFatGor := strFatGor + '  FGO_DESS16 AS DESS16, ';
  strFatGor := strFatGor + '  FGO_DESS17 AS DESS17, ';
  strFatGor := strFatGor + '  FGO_DESS18 AS DESS18, ';
  strFatGor := strFatGor + '  FGO_DESS19 AS DESS19, ';
  strFatGor := strFatGor + '  FGO_DESS20 AS DESS20, ';
  strFatGor := strFatGor + '  FGO_DESS21 AS DESS21, ';
  strFatGor := strFatGor + '  FGO_DESS22 AS DESS22, ';
  strFatGor := strFatGor + '  FGO_DESS23 AS DESS23, ';
  strFatGor := strFatGor + '  FGO_DESS24 AS DESS24, ';
  strFatGor := strFatGor + '  FGO_DESS25 AS DESS25, ';
  strFatGor := strFatGor + '  FGO_DESS26 AS DESS26, ';
  strFatGor := strFatGor + '  FGO_DESS27 AS DESS27, ';
  strFatGor := strFatGor + '  FGO_DESS28 AS DESS28, ';
  strFatGor := strFatGor + '  FGO_DESS29 AS DESS29, ';
  strFatGor := strFatGor + '  FGO_DESS30 AS DESS30, ';

  strFatGor := strFatGor + '  FGO_VALS01 AS VALS01, ';
  strFatGor := strFatGor + '  FGO_VALS02 AS VALS02, ';
  strFatGor := strFatGor + '  FGO_VALS03 AS VALS03, ';
  strFatGor := strFatGor + '  FGO_VALS04 AS VALS04, ';
  strFatGor := strFatGor + '  FGO_VALS05 AS VALS05, ';
  strFatGor := strFatGor + '  FGO_VALS06 AS VALS06, ';
  strFatGor := strFatGor + '  FGO_VALS07 AS VALS07, ';
  strFatGor := strFatGor + '  FGO_VALS08 AS VALS08, ';
  strFatGor := strFatGor + '  FGO_VALS09 AS VALS09, ';
  strFatGor := strFatGor + '  FGO_VALS10 AS VALS10, ';
  strFatGor := strFatGor + '  FGO_VALS11 AS VALS11, ';
  strFatGor := strFatGor + '  FGO_VALS12 AS VALS12, ';
  strFatGor := strFatGor + '  FGO_VALS13 AS VALS13, ';
  strFatGor := strFatGor + '  FGO_VALS14 AS VALS14, ';
  strFatGor := strFatGor + '  FGO_VALS15 AS VALS15, ';
  strFatGor := strFatGor + '  FGO_VALS16 AS VALS16, ';
  strFatGor := strFatGor + '  FGO_VALS17 AS VALS17, ';
  strFatGor := strFatGor + '  FGO_VALS18 AS VALS18, ';
  strFatGor := strFatGor + '  FGO_VALS19 AS VALS19, ';
  strFatGor := strFatGor + '  FGO_VALS20 AS VALS20, ';
  strFatGor := strFatGor + '  FGO_VALS21 AS VALS21, ';
  strFatGor := strFatGor + '  FGO_VALS22 AS VALS22, ';
  strFatGor := strFatGor + '  FGO_VALS23 AS VALS23, ';
  strFatGor := strFatGor + '  FGO_VALS24 AS VALS24, ';
  strFatGor := strFatGor + '  FGO_VALS25 AS VALS25, ';
  strFatGor := strFatGor + '  FGO_VALS26 AS VALS26, ';
  strFatGor := strFatGor + '  FGO_VALS27 AS VALS27, ';
  strFatGor := strFatGor + '  FGO_VALS28 AS VALS28, ';
  strFatGor := strFatGor + '  FGO_VALS29 AS VALS29, ';
  strFatGor := strFatGor + '  FGO_VALS30 AS VALS30, ';

  strFatGor := strFatGor + '  FGO_QTDS01 AS QTDS01, ';
  strFatGor := strFatGor + '  FGO_QTDS02 AS QTDS02, ';
  strFatGor := strFatGor + '  FGO_QTDS03 AS QTDS03, ';
  strFatGor := strFatGor + '  FGO_QTDS04 AS QTDS04, ';
  strFatGor := strFatGor + '  FGO_QTDS05 AS QTDS05, ';
  strFatGor := strFatGor + '  FGO_QTDS06 AS QTDS06, ';
  strFatGor := strFatGor + '  FGO_QTDS07 AS QTDS07, ';
  strFatGor := strFatGor + '  FGO_QTDS08 AS QTDS08, ';
  strFatGor := strFatGor + '  FGO_QTDS09 AS QTDS09, ';
  strFatGor := strFatGor + '  FGO_QTDS10 AS QTDS10, ';
  strFatGor := strFatGor + '  FGO_QTDS11 AS QTDS11, ';
  strFatGor := strFatGor + '  FGO_QTDS12 AS QTDS12, ';
  strFatGor := strFatGor + '  FGO_QTDS13 AS QTDS13, ';
  strFatGor := strFatGor + '  FGO_QTDS14 AS QTDS14, ';
  strFatGor := strFatGor + '  FGO_QTDS15 AS QTDS15, ';
  strFatGor := strFatGor + '  FGO_QTDS16 AS QTDS16, ';
  strFatGor := strFatGor + '  FGO_QTDS17 AS QTDS17, ';
  strFatGor := strFatGor + '  FGO_QTDS18 AS QTDS18, ';
  strFatGor := strFatGor + '  FGO_QTDS19 AS QTDS19, ';
  strFatGor := strFatGor + '  FGO_QTDS20 AS QTDS20, ';
  strFatGor := strFatGor + '  FGO_QTDS21 AS QTDS21, ';
  strFatGor := strFatGor + '  FGO_QTDS22 AS QTDS22, ';
  strFatGor := strFatGor + '  FGO_QTDS23 AS QTDS23, ';
  strFatGor := strFatGor + '  FGO_QTDS24 AS QTDS24, ';
  strFatGor := strFatGor + '  FGO_QTDS25 AS QTDS25, ';
  strFatGor := strFatGor + '  FGO_QTDS26 AS QTDS26, ';
  strFatGor := strFatGor + '  FGO_QTDS27 AS QTDS27, ';
  strFatGor := strFatGor + '  FGO_QTDS28 AS QTDS28, ';
  strFatGor := strFatGor + '  FGO_QTDS29 AS QTDS29, ';
  strFatGor := strFatGor + '  FGO_QTDS30 AS QTDS30, ';

  strFatGor := strFatGor + '  FGO_UNIS01 AS UNIS01, ';
  strFatGor := strFatGor + '  FGO_UNIS02 AS UNIS02, ';
  strFatGor := strFatGor + '  FGO_UNIS03 AS UNIS03, ';
  strFatGor := strFatGor + '  FGO_UNIS04 AS UNIS04, ';
  strFatGor := strFatGor + '  FGO_UNIS05 AS UNIS05, ';
  strFatGor := strFatGor + '  FGO_UNIS06 AS UNIS06, ';
  strFatGor := strFatGor + '  FGO_UNIS07 AS UNIS07, ';
  strFatGor := strFatGor + '  FGO_UNIS08 AS UNIS08, ';
  strFatGor := strFatGor + '  FGO_UNIS09 AS UNIS09, ';
  strFatGor := strFatGor + '  FGO_UNIS10 AS UNIS10, ';
  strFatGor := strFatGor + '  FGO_UNIS11 AS UNIS11, ';
  strFatGor := strFatGor + '  FGO_UNIS12 AS UNIS12, ';
  strFatGor := strFatGor + '  FGO_UNIS13 AS UNIS13, ';
  strFatGor := strFatGor + '  FGO_UNIS14 AS UNIS14, ';
  strFatGor := strFatGor + '  FGO_UNIS15 AS UNIS15, ';
  strFatGor := strFatGor + '  FGO_UNIS16 AS UNIS16, ';
  strFatGor := strFatGor + '  FGO_UNIS17 AS UNIS17, ';
  strFatGor := strFatGor + '  FGO_UNIS18 AS UNIS18, ';
  strFatGor := strFatGor + '  FGO_UNIS19 AS UNIS19, ';
  strFatGor := strFatGor + '  FGO_UNIS20 AS UNIS20, ';
  strFatGor := strFatGor + '  FGO_UNIS21 AS UNIS21, ';
  strFatGor := strFatGor + '  FGO_UNIS22 AS UNIS22, ';
  strFatGor := strFatGor + '  FGO_UNIS23 AS UNIS23, ';
  strFatGor := strFatGor + '  FGO_UNIS24 AS UNIS24, ';
  strFatGor := strFatGor + '  FGO_UNIS25 AS UNIS25, ';
  strFatGor := strFatGor + '  FGO_UNIS26 AS UNIS26, ';
  strFatGor := strFatGor + '  FGO_UNIS27 AS UNIS27, ';
  strFatGor := strFatGor + '  FGO_UNIS28 AS UNIS28, ';
  strFatGor := strFatGor + '  FGO_UNIS29 AS UNIS29, ';
  strFatGor := strFatGor + '  FGO_UNIS30 AS UNIS30, ';

  strFatGor := strFatGor + '  FGO_BRIS01 AS BRIS01, ';
  strFatGor := strFatGor + '  FGO_BRIS02 AS BRIS02, ';
  strFatGor := strFatGor + '  FGO_BRIS03 AS BRIS03, ';
  strFatGor := strFatGor + '  FGO_BRIS04 AS BRIS04, ';
  strFatGor := strFatGor + '  FGO_BRIS05 AS BRIS05, ';
  strFatGor := strFatGor + '  FGO_BRIS06 AS BRIS06, ';
  strFatGor := strFatGor + '  FGO_BRIS07 AS BRIS07, ';
  strFatGor := strFatGor + '  FGO_BRIS08 AS BRIS08, ';
  strFatGor := strFatGor + '  FGO_BRIS09 AS BRIS09, ';
  strFatGor := strFatGor + '  FGO_BRIS10 AS BRIS10, ';
  strFatGor := strFatGor + '  FGO_BRIS11 AS BRIS11, ';
  strFatGor := strFatGor + '  FGO_BRIS12 AS BRIS12, ';
  strFatGor := strFatGor + '  FGO_BRIS13 AS BRIS13, ';
  strFatGor := strFatGor + '  FGO_BRIS14 AS BRIS14, ';
  strFatGor := strFatGor + '  FGO_BRIS15 AS BRIS15, ';
  strFatGor := strFatGor + '  FGO_BRIS16 AS BRIS16, ';
  strFatGor := strFatGor + '  FGO_BRIS17 AS BRIS17, ';
  strFatGor := strFatGor + '  FGO_BRIS18 AS BRIS18, ';
  strFatGor := strFatGor + '  FGO_BRIS19 AS BRIS19, ';
  strFatGor := strFatGor + '  FGO_BRIS20 AS BRIS20, ';
  strFatGor := strFatGor + '  FGO_BRIS21 AS BRIS21, ';
  strFatGor := strFatGor + '  FGO_BRIS22 AS BRIS22, ';
  strFatGor := strFatGor + '  FGO_BRIS23 AS BRIS23, ';
  strFatGor := strFatGor + '  FGO_BRIS24 AS BRIS24, ';
  strFatGor := strFatGor + '  FGO_BRIS25 AS BRIS25, ';
  strFatGor := strFatGor + '  FGO_BRIS26 AS BRIS26, ';
  strFatGor := strFatGor + '  FGO_BRIS27 AS BRIS27, ';
  strFatGor := strFatGor + '  FGO_BRIS28 AS BRIS28, ';
  strFatGor := strFatGor + '  FGO_BRIS29 AS BRIS29, ';
  strFatGor := strFatGor + '  FGO_BRIS30 AS BRIS30, ';

  strFatGor := strFatGor + '  FGO_IDES01 AS IDES01, ';
  strFatGor := strFatGor + '  FGO_IDES02 AS IDES02, ';
  strFatGor := strFatGor + '  FGO_IDES03 AS IDES03, ';
  strFatGor := strFatGor + '  FGO_IDES04 AS IDES04, ';
  strFatGor := strFatGor + '  FGO_IDES05 AS IDES05, ';
  strFatGor := strFatGor + '  FGO_IDES06 AS IDES06, ';
  strFatGor := strFatGor + '  FGO_IDES07 AS IDES07, ';
  strFatGor := strFatGor + '  FGO_IDES08 AS IDES08, ';
  strFatGor := strFatGor + '  FGO_IDES09 AS IDES09, ';
  strFatGor := strFatGor + '  FGO_IDES10 AS IDES10, ';
  strFatGor := strFatGor + '  FGO_IDES11 AS IDES11, ';
  strFatGor := strFatGor + '  FGO_IDES12 AS IDES12, ';
  strFatGor := strFatGor + '  FGO_IDES13 AS IDES13, ';
  strFatGor := strFatGor + '  FGO_IDES14 AS IDES14, ';
  strFatGor := strFatGor + '  FGO_IDES15 AS IDES15, ';
  strFatGor := strFatGor + '  FGO_IDES16 AS IDES16, ';
  strFatGor := strFatGor + '  FGO_IDES17 AS IDES17, ';
  strFatGor := strFatGor + '  FGO_IDES18 AS IDES18, ';
  strFatGor := strFatGor + '  FGO_IDES19 AS IDES19, ';
  strFatGor := strFatGor + '  FGO_IDES20 AS IDES20, ';
  strFatGor := strFatGor + '  FGO_IDES21 AS IDES21, ';
  strFatGor := strFatGor + '  FGO_IDES22 AS IDES22, ';
  strFatGor := strFatGor + '  FGO_IDES23 AS IDES23, ';
  strFatGor := strFatGor + '  FGO_IDES24 AS IDES24, ';
  strFatGor := strFatGor + '  FGO_IDES25 AS IDES25, ';
  strFatGor := strFatGor + '  FGO_IDES26 AS IDES26, ';
  strFatGor := strFatGor + '  FGO_IDES27 AS IDES27, ';
  strFatGor := strFatGor + '  FGO_IDES28 AS IDES28, ';
  strFatGor := strFatGor + '  FGO_IDES29 AS IDES29, ';
  strFatGor := strFatGor + '  FGO_IDES30 AS IDES30, ';

  strFatGor := strFatGor + '  FGO_PRAENT AS PRAENT, ';
  strFatGor := strFatGor + '  FGO_TOTSER AS TOTSER, ';
  strFatGor := strFatGor + '  FGO_VALISS AS VALISS, ';
  strFatGor := strFatGor + '  FGO_PERISS AS PERISS, ';
  strFatGor := strFatGor + '  FGO_HORENT AS HORENT, ';
  strFatGor := strFatGor + '  FGO_ENTFAT AS ENTFAT, ';
  strFatGor := strFatGor + '  FGO_VLRCON AS VLRCON, ';
  strFatGor := strFatGor + '  FGO_VLRCON AS VLCONT, ';

  strFatGor := strFatGor + '  FGO_ENTURG AS ENTURG, ';
  strFatGor := strFatGor + '  FGO_MENEXP AS MENEXP, ';
  strFatGor := strFatGor + '  FGO_MENEX2 AS MENEX2, ';
  strFatGor := strFatGor + '  FGO_MENEX3 AS MENEX3, ';
  strFatGor := strFatGor + '  FGO_MENEX4 AS MENEX4, ';

  strFatGor := strFatGor + '  FGO_SEQDMP AS SEQDMP, ';

  strFatGor := strFatGor + '  FGO_DESACE AS DESACE, ';
  strFatGor := strFatGor + '  CAST(0.00 AS DECIMAL(12,2)) AS TOSEOR, ';
  strFatGor := strFatGor + '  IF(FGO_ENT_CD = ''S'', ''Sim'', ''Não'') AS ENT_CD, ';

  strFatGor := strFatGor + '  CONCAT(FGO_OBSL01, '' '', FGO_OBSL02) AS OBSLIB , ';

  strFatGor := strFatGor + '  (SELECT GROUP_CONCAT(ORD_NUMORD ORDER BY ORD_NUMORD ASC SEPARATOR ",") ';
  strFatGor := strFatGor + '     FROM ORDSER WHERE ORD_NUMDOC = FGO_NUMDOC) AS NUMOSG, ';

  strFatGor := strFatGor + '  (SELECT GROUP_CONCAT(FDO_ORDPRO ORDER BY FDO_ORDPRO ASC SEPARATOR ",") ';
  strFatGor := strFatGor + '     FROM FATDOR WHERE FDO_NUMDOC = FGO_NUMDOC AND FDO_CODEMP = FGO_CODEMP AND FDO_CODCLI = FGO_CODCLI) AS NUMOPG, ';

  strFatGor := strFatGor + '  0          AS NROITE, ';
  strFatGor := strFatGor + '  0.00       AS TOTQTD, ';
  strFatGor := strFatGor + '  0.00       AS TOTGER, ';
  strFatGor := strFatGor + '  0.00       AS TOTCPR, ';
  strFatGor := strFatGor + '  0.00       AS TOTSPR, ';

  // REVER COM O ABAIXO
  strFatGor := strFatGor + '  0.00       AS TOTUNI, ';
  strFatGor := strFatGor + '  0.00       AS TOTORI, ';
  strFatGor := strFatGor + '  0.00       AS TOTDIG, ';

  strFatGor := strFatGor + '  0.00       AS TOTTAB, ';

  strFatGor := strFatGor + '  0.00       AS TOTLIT, ';

  strFatGor := strFatGor + '  0.00       AS VALBRU, ';

  strFatGor := strFatGor + '  0.00       AS BRUDIG, ';

  strFatGor := strFatGor + '  0.00       AS DESTOT, ';

  strFatGor := strFatGor + '  CAST("" AS CHAR(1000)) AS VRBREX, ';
  strFatGor := strFatGor + '  CAST("" AS CHAR(1000)) AS VRCOEX, ';

  strFatGor := strFatGor + '  0.00       AS TDPORI, ';
  strFatGor := strFatGor + '  0.00       AS TDPDES, ';
  strFatGor := strFatGor + '  0.00       AS TOTMAI, ';

  strFatGor := strFatGor + '  CAST("" AS CHAR(1000)) AS DUPLIC, ';
  strFatGor := strFatGor + '  CAST("" AS CHAR(1000)) AS LSTREC, ';
  strFatGor := strFatGor + '  CAST("" AS CHAR(1000)) AS DESMEM, ';
  strFatGor := strFatGor + '  0.00                  AS PRZMED, ';

  strFatGor := strFatGor + '  CAST("" AS CHAR(999)) AS LEGIPI, ';
  strFatGor := strFatGor + '  CAST("" AS CHAR(600)) AS TOTAUN, ';
  strFatGor := strFatGor + '  CAST("" AS CHAR(300)) AS SETORG, ';

  strFatGor := strFatGor + '  EG.FGO_REGCON AS REGCON, ';
  strFatGor := strFatGor + '  EG.FGO_CODPRJ AS CODPRJ, ';
  strFatGor := strFatGor + '  PR.PRJ_DESPRJ AS NOMPRJ, ';

  {*******************************************}
  {* DADOS VALORES POR CONDIÇÃO DE PAGAMENTO *}
  {****************************************MA*}

  strFatGor := strFatGor + '  CAST("" AS CHAR(1000)) AS DSCPGO, ';
  strFatGor := strFatGor + '  CAST("" AS CHAR(1000)) AS TOTPGO, ';
  strFatGor := strFatGor + '  CAST("" AS CHAR(1000)) AS VALPGO, ';

  {********************}
  {* DADOS FINANCEIRA *}
  {*****************FC*}
  strFatGor := strFatGor + '  CAST("" AS CHAR(1000)) AS FINDES, ';
  strFatGor := strFatGor + '  CAST("" AS CHAR(1000)) AS VALFIN, ';
  strFatGor := strFatGor + '  CAST("" AS CHAR(1000)) AS QTDPAR, ';
  strFatGor := strFatGor + '  CAST("" AS CHAR(1000)) AS VALOPE, ';
  strFatGor := strFatGor + '  CAST("" AS CHAR(1000)) AS VALPAR, ';
  strFatGor := strFatGor + '  CAST("" AS CHAR(1000)) AS CARTAO, ';

  strFatGor := strFatGor + '  FGO_BOLADT AS BOLADT, ';
  strFatGor := strFatGor + '  FGO_BOLVEN AS BOLVEN, ';

  strFatGor := strFatGor + '  FGO_VPAR01 AS VPAR01, ';
  strFatGor := strFatGor + '  FGO_VPAR02 AS VPAR02, ';
  strFatGor := strFatGor + '  FGO_VPAR03 AS VPAR03, ';
  strFatGor := strFatGor + '  FGO_VPAR04 AS VPAR04, ';
  strFatGor := strFatGor + '  FGO_VPAR05 AS VPAR05, ';
  strFatGor := strFatGor + '  FGO_VPAR06 AS VPAR06, ';
  strFatGor := strFatGor + '  FGO_VPAR07 AS VPAR07, ';
  strFatGor := strFatGor + '  FGO_VPAR08 AS VPAR08, ';
  strFatGor := strFatGor + '  FGO_VPAR09 AS VPAR09, ';
  strFatGor := strFatGor + '  FGO_VPAR10 AS VPAR10, ';
  strFatGor := strFatGor + '  FGO_VPAR11 AS VPAR11, ';
  strFatGor := strFatGor + '  FGO_VPAR12 AS VPAR12, ';
  strFatGor := strFatGor + '  0.00       AS VPAR13, ';
  strFatGor := strFatGor + '  0.00       AS VPAR14, ';
  strFatGor := strFatGor + '  0.00       AS VPAR15, ';
  strFatGor := strFatGor + '  0.00       AS VPAR16, ';
  strFatGor := strFatGor + '  0.00       AS VPAR17, ';
  strFatGor := strFatGor + '  0.00       AS VPAR18, ';
  strFatGor := strFatGor + '  0.00       AS VPAR19, ';
  strFatGor := strFatGor + '  0.00       AS VPAR20, ';
  strFatGor := strFatGor + '  0.00       AS VPAR21, ';
  strFatGor := strFatGor + '  0.00       AS VPAR22, ';
  strFatGor := strFatGor + '  0.00       AS VPAR23, ';
  strFatGor := strFatGor + '  0.00       AS VPAR24, ';

  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV01, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV02, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV03, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV04, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV05, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV06, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV07, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV08, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV09, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV10, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV11, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV12, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV13, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV14, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV15, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV16, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV17, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV18, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV19, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV20, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV21, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV22, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV23, ';
  strFatGor := strFatGor + '  CAST(NULL AS DATE) AS DTAV24, ';

  strFatGor := strFatGor + '  FGO_CIDCON, ';
  strFatGor := strFatGor + '  FGO_ENDCON, ';
  strFatGor := strFatGor + '  FGO_BAICON, ';
  strFatGor := strFatGor + '  FGO_CEPCON, ';
  strFatGor := strFatGor + '  FGO_TELCON, ';
  strFatGor := strFatGor + '  FGO_R_GCON, ';
  strFatGor := strFatGor + '  FGO_CGCCPF, ';
  strFatGor := strFatGor + '  FGO_CGCCON, ';
  strFatGor := strFatGor + '  FGO_IESCON, ';
  strFatGor := strFatGor + '  FGO_NOMCON, ';
  strFatGor := strFatGor + '  CAST(IF(LOCATE("GARANTIA PEDIDO REPOSICAO CLIENTE", FGO_MEN001), "S", "N") AS CHAR(1)) AS GARANT, ';

  strFatGor := strFatGor + '  FGO_CODFAZ, ';

  strFatGor := strFatGor + '  CONCAT(LEFT(EG.FGO_PLAVEI,3),"-",RIGHT(EG.FGO_PLAVEI,4)) AS PLAVEI, ';
  strFatGor := strFatGor + '  EG.FGO_KM_VEI AS KM_VEI,    ';
  strFatGor := strFatGor + '  EG.FGO_PRISMA AS PRISVE, ';
  if blnOcultarMarca then
    strFatGor := strFatGor + '  " " AS MARVEI, '
  else
    strFatGor := strFatGor + '  MV.MAR_DESMAR AS MARVEI, ';

  strFatGor := strFatGor + '  MO.MOD_DESMOD AS MODVEI, ';
  strFatGor := strFatGor + '  CO.COR_DESCOR AS CORVEI, ';
  strFatGor := strFatGor + '  VE.VEI_ANOVEI AS ANOVEI, ';
  strFatGor := strFatGor + '  VE.VEI_CHASSI AS CHASSI, ';

  strFatGor := strFatGor + '  EG.FGO_TRARDP AS TRARDP, ';
  strFatGor := strFatGor + '  TR.TRA_NOMTRA AS RDPNOM, ';
  strFatGor := strFatGor + '  TR.TRA_ENDERE AS RDPEND, ';
  strFatGor := strFatGor + '  TR.TRA_I_E_S_ AS RDPIES, ';
  strFatGor := strFatGor + '  TR.TRA_C_G_C_ AS RDPCGC, ';
  strFatGor := strFatGor + '  TR.TRA_FONE01 AS RDPFON, ';
  strFatGor := strFatGor + '  TR.TRA_BAIRRO AS RDPBAI, ';
  strFatGor := strFatGor + '  TR.TRA_C_E_P_ AS RDPCEP, ';
  strFatGor := strFatGor + '  CTR.CID_NOMCID AS RDPCID, ';
  strFatGor := strFatGor + '  CTR.CID_ESTADO AS RDPEST, ';

  strFatGor := strFatGor + '  FGO_MOTBAI AS MOTBAI, ';
  strFatGor := strFatGor + '  FGO_CODOCO AS CODOCO, ';
  strFatGor := strFatGor + '  OCO_DESOCO AS DESOCO, ';
  strFatGor := strFatGor + '  FGO_ALTERA AS ALTERA, ';
  strFatGor := strFatGor + '  TPA_DESCRI AS DESTPA, ';

  strFatGor := strFatGor + '  EG.FGO_CODROT AS CODROT, ';
  strFatGor := strFatGor + '   F.FGO_DTENTR AS DTENTR, ';
  strFatGor := strFatGor + '  RG.REG_CODREG AS CODREG, ';
  strFatGor := strFatGor + '  RG.REG_DESREG AS DESREG, ';
  strFatGor := strFatGor + '  RG.REG_DESREG AS NOMRRP, ';
  strFatGor := strFatGor + '  ER.ENT_DTAENT AS ENTREG, ';
  strFatGor := strFatGor + '  ER.ENT_DTAENT AS DTAERP, ';

  {Consumo/Revenda}
  strFatGor := strFatGor + '  CASE EG.FGO_CONSUM            ';
  strFatGor := strFatGor + '    WHEN "S" THEN "USO/CONSUMO" ';
  strFatGor := strFatGor + '    WHEN "N" THEN "REVENDA"     ';
  strFatGor := strFatGor + '  END AS CONSUM,                ';

  {Industrialização/Comercialização}
  strFatGor := strFatGor + '  CASE EG.FGO_INDCOM                 ';
  strFatGor := strFatGor + '    WHEN "C" THEN "COMERCIALIZACAO"  ';
  strFatGor := strFatGor + '    WHEN "I" THEN "INDUSTRIALIZACAO" ';
  strFatGor := strFatGor + '  END AS INDCOM,                     ';

  {Comanda}
  strFatGor := strFatGor + '  EG.FGO_BARCOM AS BARCOM,           ';

  {Cliente está na loja?}
  strFatGor := strFatGor + '  IF(EG.FGO_CLILOJ = "S", "Sim", "Não") AS CLILOJ, ';

  strFatGor := strFatGor + '  FGO_FATNOT AS FATNOT, ';
  strFatGor := strFatGor + '  CASE FGO_TIPPED                    ';
  strFatGor := strFatGor + '    WHEN "A" THEN "A - NOTA FISCAL"  ';
  strFatGor := strFatGor + '    WHEN "B" THEN "B - MI/FF"        ';
  strFatGor := strFatGor + '    WHEN "C" THEN "C - CUPOM FISCAL" ';
  strFatGor := strFatGor + '    WHEN "D" THEN "D - DIVISIVEL"    ';
  strFatGor := strFatGor + '  END AS TIPPED,                     ';

  strFatGor := strFatGor + '  CONCAT(IFNULL(CLI_NOMCTT, ""), ' +
    ' IF(IFNULL(CLI_TELCTT, "") = "", "", CONCAT("  TEL.: ", CONCAT("(", LEFT(CLI_TELCTT, 2), ")", SUBSTR(CLI_TELCTT, 3,5), "-", RIGHT(CLI_TELCTT, 4)))), ' +
    ' IF(IFNULL(CLI_CELCTT, "") = "", "", CONCAT("  CEL.: ", CONCAT("(", LEFT(CLI_CELCTT, 2), ")", SUBSTR(CLI_CELCTT, 3,5), "-", RIGHT(CLI_CELCTT, 4))))) AS CLICTT, ';

  strFatGor := strFatGor + '  TT.CLI_NOMCTT AS NOMCTT,                     ';
  strFatGor := strFatGor + '  TT.CLI_NUMCPF AS CPFCTT,                     ';
  strFatGor := strFatGor + '  TT.CLI_NUMR_G AS RG_CTT,                     ';

  strFatGor := strFatGor + '  (SELECT GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR " - ") ';
  strFatGor := strFatGor + '   FROM NUMCMP ';
  strFatGor := strFatGor + '   WHERE CMP_SEQGER = F.AUTOINCREM ) AS NUMCMP, ';

  strFatGor := strFatGor + '   (SELECT CONCAT(MOVGER.GER_NUMDOC, "-G")                ';
  strFatGor := strFatGor + '    FROM FATDOR                                           ';
  strFatGor := strFatGor + '    JOIN MOVGPV ON MOVGPV.GPV_SEQFDO = FATDOR.AUTOINCREM  ';
  strFatGor := strFatGor + '    JOIN MOVGAD ON MOVGAD.AUTOINCREM = MOVGPV.GPV_SEQGAD  ';
  strFatGor := strFatGor + '    JOIN MOVGRC ON MOVGRC.GRC_SEQGAD = MOVGAD.AUTOINCREM  ';
  strFatGor := strFatGor + '    JOIN MOVDET ON MOVDET.AUTOINCREM = MOVGRC.GRC_SEQDET  ';
  strFatGor := strFatGor + '    JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER  ';
  strFatGor := strFatGor + '    WHERE FATDOR.FDO_NUMDOC = :NUMDOC            ';
  strFatGor := strFatGor + '    AND FATDOR.FDO_ESPDOC = :ESPDOC            ';
  strFatGor := strFatGor + '    AND FATDOR.FDO_CODEMP = :CODEMP LIMIT 1) AS NUMGAR ,';

  strFatGor := strFatGor + '  CONCAT(FORMAT(FGO_FATNOT * 100,0) , "/", FORMAT(100  - FGO_FATNOT * 100,0)) AS FATOR_, ';

  strFatGor := strFatGor + '  (SELECT ';
  strFatGor := strFatGor + '     REPLACE(GROUP_CONCAT(FPN_CODFPG, "-", RPAD(FPG_DESCRI, 25, " "), ';
  strFatGor := strFatGor + '             IF(FPN_CODFPG = "007", RPAD(CONCAT(RPAD(CONCAT(COALESCE(CAR_CODCAR, ""), "-", COALESCE(CAR_DESCAR, "")), 28 ," "), " - QTD.PARC.: ", FPN_QTDPAR), 45, " "), ';
  strFatGor := strFatGor + '                RPAD(" ", 45, " ")), "    - R$ ", LPAD(FPN_VALFPG, 9, " ")), ",", CHAR(13)) ';
  strFatGor := strFatGor + '   FROM ';
  strFatGor := strFatGor + '     FPGNEG ';
  strFatGor := strFatGor + '        JOIN CADFPG ON (CADFPG.FPG_CODIGO = FPGNEG.FPN_CODFPG) ';
  strFatGor := strFatGor + '   LEFT JOIN CADCAR ON (CADCAR.CAR_CODCAR = FPGNEG.FPN_CODCAR) ';
  strFatGor := strFatGor + '   WHERE ';
  strFatGor := strFatGor + '     FPGNEG.FPN_SEQFGO = F.AUTOINCREM) AS FORNEG, ';

  strFatGor := strFatGor + ' (SELECT ';
  strFatGor := strFatGor + '    GROUP_CONCAT(DISTINCT FD2.FDO_NUMFAT, "-", FD2.FDO_TIPFAT, "-", FD2.FDO_EMPFAT) ';
  strFatGor := strFatGor + '  FROM ';
  strFatGor := strFatGor + '    FATDOR FD2 ';
  strFatGor := strFatGor + '  JOIN ';
  strFatGor := strFatGor + '    (SELECT ';
  strFatGor := strFatGor + '       DISTINCT ';
  strFatGor := strFatGor + '       FG.FGO_NUMDOC, ';
  strFatGor := strFatGor + '       FG.FGO_ESPDOC, ';
  strFatGor := strFatGor + '       FG.FGO_CODEMP, ';
  strFatGor := strFatGor + '       FD.FDO_NUMDOC, ';
  strFatGor := strFatGor + '       FD.FDO_ESPDOC, ';
  strFatGor := strFatGor + '       FD.FDO_CODEMP  ';
  strFatGor := strFatGor + '     FROM ';
  strFatGor := strFatGor + '       FATGOR FG ';
  strFatGor := strFatGor + '     LEFT JOIN FATDOR FD ON (FD.FDO_NUMFAT = FG.FGO_NUMDOC AND ';
  strFatGor := strFatGor + '                             FD.FDO_TIPFAT = FG.FGO_ESPDOC AND ';
  strFatGor := strFatGor + '                             FD.FDO_EMPFAT = FG.FGO_CODEMP) ';
  strFatGor := strFatGor + '     WHERE FG.FGO_NUMDOC = :NUMDOC AND ';
  strFatGor := strFatGor + '           FG.FGO_ESPDOC = :ESPDOC AND ';
  strFatGor := strFatGor + '           FG.FGO_CODCLI = :CODCLI AND ';
  strFatGor := strFatGor + '           FG.FGO_CODEMP = :CODEMP) AS TAB ON ';
  strFatGor := strFatGor + '       (FD2.FDO_NUMDOC = TAB.FDO_NUMDOC AND ';
  strFatGor := strFatGor + '        FD2.FDO_ESPDOC = TAB.FDO_ESPDOC AND ';
  strFatGor := strFatGor + '        FD2.FDO_CODEMP = TAB.FDO_CODEMP AND ';
  strFatGor := strFatGor + '        FD2.FDO_NUMFAT <> :NUMDOC)) AS DOCFAT, ';

  strFatGor := strFatGor + '  "FATGOR" AS TABELA, ';

  strFatGor := strFatGor + '  " " AS ORCVEN, ';
  strFatGor := strFatGor + '  " " AS VALORC, ';

  strFatGor := strFatGor + '  (SELECT ';
  strFatGor := strFatGor + '    GROUP_CONCAT( ';
  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    strFatGor := strFatGor + '      DISTINCT IF(IFNULL(FATDOR.FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) SEPARATOR " | " '
  else
    strFatGor := strFatGor + '      DISTINCT LSE_DESCRI SEPARATOR " | " ';

  strFatGor := strFatGor + '    ) AS SEPPED ';
  strFatGor := strFatGor + '  FROM ';
  strFatGor := strFatGor + '    FATDOR ';
  strFatGor := strFatGor + '    INNER JOIN ITEGER ON FDO_CODITE = ITE_CODITE ';
  strFatGor := strFatGor + '                     AND FDO_CODEMP = ITE_CODEMP ';

  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
  begin
    strFatGor := strFatGor + ' LEFT JOIN CADLOT LT ON LT.LOT_CODITE = FATDOR.FDO_CODITE AND LT.LOT_CODEMP = FATDOR.FDO_CODEMP AND LT.LOT_NUMLOT = FATDOR.FDO_NUMLOT ';
    strFatGor := strFatGor + ' LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LT.LOT_LOCFIS AND CL1.LOC_CODEMP = LT.LOT_CODEMP ';
    strFatGor := strFatGor + ' LEFT JOIN CADLOC CL2 ON CL2.LOC_CODLOC = ITEGER.ITE_LOCFIS AND CL2.LOC_CODEMP = ITEGER.ITE_CODEMP ';
    strFatGor := strFatGor + ' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ';
    strFatGor := strFatGor + ' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = CL2.LOC_CODLSE ';
  end
  else
    strFatGor := strFatGor + '    LEFT JOIN CADLSE ON ITE_CODLSE = LSE_CODIGO ';

  strFatGor := strFatGor + '  WHERE FDO_SEQGER = F.AUTOINCREM ';
  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    strFatGor := strFatGor + '  ORDER BY IF(IFNULL(FATDOR.FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI)) AS SEPPED, '
  else
    strFatGor := strFatGor + '  ORDER BY LSE_DESCRI) AS SEPPED, ';

  strFatGor := strFatGor + '  (CASE WHEN EQ.EQU_AUTDES = "S" THEN "Sim" ELSE "Não" END) AS AUT_OS, ';
  strFatGor := strFatGor + '  EQ.EQU_NUMOSE AS NUM_OS, ';
  strFatGor := strFatGor + '  EQ.EQU_STATUS AS STA_OS, ';
  strFatGor := strFatGor + '  EQ.EQU_SUBSTA AS SBS_OS, ';
  strFatGor := strFatGor + '  EQ.EQU_GARANT AS GAR_OS, ';
  strFatGor := strFatGor + '  EQ.EQU_PROTOC AS PRT_OS, ';
  strFatGor := strFatGor + '  EQ.EQU_OBSERV AS OBS_OS, ';
  strFatGor := strFatGor + '  IF(EQ.EQU_NUMOSE <> "", IF(EQ.EQU_GARANT = "N", "NÃO", "SIM"), "") AS EMG_OS, ';

  strFatGor := strFatGor + '  IF(FGO_ESPDOC="PR",(SELECT GROUP_CONCAT(DISTINCT " ",FDO_DOCDEV,"-",FDO_ESPDEV,"-",FDO_EMPDEV) FROM FATDOR WHERE FDO_SEQGER= F.AUTOINCREM),"") AS DCDVPR, ';
  strFatGor := strFatGor + '  FGO_PEDSIT AS PEDSIT, ';

  strFatGor := strFatGor + '  IF(IFNULL(EG.FGO_EMP_TE, "") = "", "", CONCAT(EG.FGO_EMP_TE, "-", EM.EMP_NOMEMP)) AS EMP_TE, ';

  strFatGor := strFatGor + '  FGO_DTCTVN AS DTCTVN, ';
  strFatGor := strFatGor + '  FGO_VLCTVN AS VLCTVN, ';
  strFatGor := strFatGor + '  (SELECT MAX(MOE_DTAMOE) FROM CADMOE) AS DTCTAT, ';
  strFatGor := strFatGor + '  (SELECT MOE_DOLVEN FROM CADMOE WHERE MOE_DTAMOE = (SELECT MAX(MOE_DTAMOE) FROM CADMOE)) AS VLCTAT, ';

  strFatGor := strFatGor + '  (SELECT MOE_EURCOM FROM CADMOE WHERE MOE_DTAMOE = (SELECT MAX(MOE_DTAMOE) FROM CADMOE)) AS EURCOM, ';
  strFatGor := strFatGor + '  (SELECT MOE_EURVEN FROM CADMOE WHERE MOE_DTAMOE = (SELECT MAX(MOE_DTAMOE) FROM CADMOE)) AS EURVEN, ';

  strFatGor := strFatGor + '  IF(F.FGO_NOMCON IS NULL OR F.FGO_NOMCON = "", IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "",  C.CLI_ENDERE, EC.ETC_ENDENT), F.FGO_ENDCON) AS ENDENT, ';
  strFatGor := strFatGor + '  IF(F.FGO_NOMCON IS NULL OR F.FGO_NOMCON = "", IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "",  C.CLI_C_E_P_, EC.ETC_CEPENT), F.FGO_CEPCON) AS CEPENT, ';
  strFatGor := strFatGor + '  IF(F.FGO_NOMCON IS NULL OR F.FGO_NOMCON = "", IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CF.CID_NOMCID, CE.CID_NOMCID), CC.CID_NOMCID) AS CIDENT, ';
  strFatGor := strFatGor + '  IF(F.FGO_NOMCON IS NULL OR F.FGO_NOMCON = "", IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CF.CID_ESTADO, CE.CID_ESTADO), CC.CID_ESTADO) AS ESTENT, ';

  strFatGor := strFatGor + ' (SELECT SUM(E1.FDO_VALFCP) AS TOTFCP ';
  strFatGor := strFatGor + '    FROM ';
  strFatGor := strFatGor + '  FATDOR F1 ';
  strFatGor := strFatGor + '   INNER JOIN EXTDOR E1 ';
  strFatGor := strFatGor + '      ON F1.AUTOINCREM = E1.FDO_SEQFDO ';
  strFatGor := strFatGor + '   WHERE F1.FDO_NUMDOC = F.FGO_NUMDOC ';
  strFatGor := strFatGor + '     AND F1.FDO_CODEMP = F.FGO_CODEMP ';
  strFatGor := strFatGor + '     AND F1.FDO_ESPDOC = F.FGO_ESPDOC ';
  strFatGor := strFatGor + '     AND F1.FDO_CODCLI = F.FGO_CODCLI) AS TOTFCP, ';

  strFatGor := strFatGor + ' SG.FGO_DTENTS AS DTENTS, ';
  strFatGor := strFatGor + ' SG.FGO_HRENTS AS HRENTS, ';
  strFatGor := strFatGor + ' SG.FGO_SEROBS AS SEROBS, ';
  strFatGor := strFatGor + ' SG.FGO_NROPRO AS NROPRO, ';
  strFatGor := strFatGor + ' SG.FGO_SERINI AS SERINI, ';
  strFatGor := strFatGor + ' SG.FGO_SERFIN AS SERFIN, ';

  strFatGor := strFatGor + ' SG.FGO_DISSER AS DSSERV, ';

  strFatGor := strFatGor + ' COALESCE((SELECT SUM(IF(CLU1.FID_CREDEB = "C", CLU1.FID_QTDPTO, -CLU1.FID_QTDPTO)) FROM CLUFID CLU1 ';
  strFatGor := strFatGor + ' JOIN CADCLI CLI2 ON CLI2.CLI_CODCLI = CLU1.FID_CODCLI ';
  strFatGor := strFatGor + '  WHERE CLU1.FID_CODCLI = F.FGO_CODCLI ';
  strFatGor := strFatGor + '  AND   CLU1.FID_DTACAD <= F.FGO_DTAENT ';
  strFatGor := strFatGor + '  AND   CLI2.CLI_CLUFID = "S"  ';
  strFatGor := strFatGor + '  AND   CLU1.FID_DTABAI IS NULL ';
  strFatGor := strFatGor + '  AND   CLU1.FID_HRABAI IS NULL ';
  strFatGor := strFatGor + '  AND   CLU1.AUTOINCREM <> CF.AUTOINCREM ';
  strFatGor := strFatGor + ' ),0) AS PTOANT, ';

  If (fCfgSis('VLPCCL', varDouble) > 0) Then
  Begin
    strFatGor := strFatGor + ' (F.FGO_TOTPRO - F.FGO_DESESP - F.FGO_DESFIN)/'+floattostr(fCfgSis('VLPCCL', varDouble))+' AS PTOVEN ';
  End
  Else
  Begin
    strFatGor := strFatGor + ' (0) AS PTOVEN ';
  End;

  strFatGor := strFatGor + ' ,0.00 AS TOPEBR ';
  strFatGor := strFatGor + ' ,0.00 AS TOPELQ ';

  strFatGor := strFatGor + ' ,PA.PRD_DESAMO AS DESAMO ';
  strFatGor := strFatGor + ' ,PA.PRD_NOMCLI AS NOMAMO ';

  strFatGor := strFatGor + ' , (SELECT GROUP_CONCAT( CONCAT(TAB.UNIDAD, "-", TAB.QTDUNI) SEPARATOR "\r\n" ) ';
  strFatGor := strFatGor + '      FROM (SELECT CONCAT(U.UNI_CODUNI, "-", U.UNI_DESUNI) AS UNIDAD, ';
  strFatGor := strFatGor + '                   ROUND(SUM(D.FDO_QTDITE),'+IntToStr(StrToIntDef(fCfgSis('DECUNI', varInteger),2))+') AS QTDUNI ';
  strFatGor := strFatGor + '              FROM FATGOR G ';
  strFatGor := strFatGor + '             INNER JOIN FATDOR D ON D.FDO_SEQGER = G.AUTOINCREM ';
  strFatGor := strFatGor + '             INNER JOIN CADUNI U ON U.UNI_CODUNI = D.FDO_UNIDAD ';
  strFatGor := strFatGor + '             WHERE G.FGO_NUMDOC = :NUMDOC ';
  strFatGor := strFatGor + '               AND G.FGO_ESPDOC = :ESPDOC ';
  strFatGor := strFatGor + '               AND G.FGO_CODCLI = :CODCLI ';
  strFatGor := strFatGor + '               AND G.FGO_CODEMP = :CODEMP ';
  strFatGor := strFatGor + '             GROUP BY U.UNI_CODUNI ';
  strFatGor := strFatGor + '             ORDER BY U.UNI_DESUNI) AS TAB) AS DSUNPD ';

  strFatGor := strFatGor + ' , EG.FGO_HPREVI AS HPREVI ';

  strFatGor := strFatGor + ' , (SELECT GROUP_CONCAT( CONCAT(TAB.UNIDAD, " ", TAB.QTDUNI) SEPARATOR "@" ) ';
  strFatGor := strFatGor + '      FROM (SELECT U.UNI_SIGUNI AS UNIDAD, ';
  strFatGor := strFatGor + '                   CAST( FORMAT( SUM(D.FDO_QTDITE), 2, "de_DE") AS CHAR(10) )  AS QTDUNI ';
  strFatGor := strFatGor + '              FROM FATGOR G ';
  strFatGor := strFatGor + '             INNER JOIN FATDOR D ON D.FDO_SEQGER = G.AUTOINCREM ';
  strFatGor := strFatGor + '             INNER JOIN CADUNI U ON U.UNI_CODUNI = D.FDO_UNIDAD ';
  strFatGor := strFatGor + '             WHERE G.FGO_NUMDOC = :NUMDOC ';
  strFatGor := strFatGor + '               AND G.FGO_ESPDOC = :ESPDOC ';
  strFatGor := strFatGor + '               AND G.FGO_CODCLI = :CODCLI ';
  strFatGor := strFatGor + '               AND G.FGO_CODEMP = :CODEMP ';
  strFatGor := strFatGor + '             GROUP BY U.UNI_SIGUNI ';
  strFatGor := strFatGor + '             ORDER BY U.UNI_SIGUNI) AS TAB) AS GRPUNI ';

  strFatGor := strFatGor + ' , C.CLI_CELULA AS CELULA ';

  If fCfgSis('PDPENC', varBoolean) Then
  Begin
    strFatGor := strFatGor + ' ,(SELECT COUNT(*) ';
    strFatGor := strFatGor + '     FROM FATGOR ';
    strFatGor := strFatGor + '    WHERE FGO_CODCLI = F.FGO_CODCLI ';
    strFatGor := strFatGor + '      AND FGO_ESPDOC = "PD" ';
    strFatGor := strFatGor + '      AND FGO_JAFATU = 0 ';
    strFatGor := strFatGor + '      AND FGO_CODEMP = '+QuotedStr(VS_strCodEmp)+' ) AS PDPDEM ';

    strFatGor := strFatGor + ' ,(SELECT COUNT(*) ';
    strFatGor := strFatGor + '     FROM FATGOR ';
    strFatGor := strFatGor + '    WHERE FGO_CODCLI = F.FGO_CODCLI ';
    strFatGor := strFatGor + '      AND FGO_ESPDOC = "PD" ';
    strFatGor := strFatGor + '      AND FGO_JAFATU = 0 ) AS PDPDGR ';
  End
  Else
  Begin
    strFatGor := strFatGor + ' ,"0" AS PDPDEM ';
    strFatGor := strFatGor + ' ,"0" AS PDPDGR ';
  End;

  strFatGor := strFatGor + ' ,(SELECT MOVOCO.OCO_PROTOC ';
  strFatGor := strFatGor + '     FROM MOVOCO ';
  strFatGor := strFatGor + '    WHERE MOVOCO.OCO_ESPDOC = F.FGO_ESPDOC ';
  strFatGor := strFatGor + '      AND MOVOCO.OCO_NUMDOC = F.FGO_NUMDOC ';
  strFatGor := strFatGor + '      AND MOVOCO.OCO_CODEMP = F.FGO_CODEMP ';
  strFatGor := strFatGor + '    ORDER BY MOVOCO.OCO_DTAINC +  MOVOCO.OCO_HORINC ASC ';
  strFatGor := strFatGor + '    LIMIT 1) PROTOC ';

  strFatGor := strFatGor + ' ,(SELECT GROUP_CONCAT(DISTINCT LAR_DESLAR SEPARATOR ", ") ';
  strFatGor := strFatGor + '     FROM EXTLAR ';
  strFatGor := strFatGor + '    INNER JOIN CADLAR ON SEQ_CODLAR = CADLAR.AUTOINCREM ';
  strFatGor := strFatGor + '    WHERE COD_FATGOR = F.AUTOINCREM ) AS LOCARM ';

  strFatGor := strFatGor + ' ,0.00 AS ECMCBG ';

  strFatGor := strFatGor + ' ,C.CLI_FONE02 AS FONE02 ';

  strFatGor := strFatGor + ' ,"'+fCfgSis('MENBCO', varString)+'" AS MENBCO ';

  strFatGor := strFatGor + ' ,IF(F.FGO_JAFATU=0, "NÃO FATURADO", "FATURADO") AS JAFATU ';

  strFatGor := strFatGor + ' ,FGO_NUMORI AS NUMORI ';
  strFatGor := strFatGor + ' ,FGO_ESPORI AS ESPORI ';
  strFatGor := strFatGor + ' ,FGO_EMPORI AS EMPORI ';

  strFatGor := strFatGor + ' , C.CLI_CONTAT AS CONCTT ';

  strFatGor := strFatGor + ' , C.CLI_CATEGO AS CLICTG '; //Categoria do Cliente

  strFatGor := strFatGor + ' , C.CLI_CODRED AS CODRED ';
  strFatGor := strFatGor + ' ,CR.RED_DESRED AS DSCRED ';
  strFatGor := strFatGor + ' , C.CLI_CODCAC AS CODCAC ';
  strFatGor := strFatGor + ' ,CA.CAC_NOMCAC AS DSCCAC ';

  strFatGor := strFatGor + ' , 0.00 AS TOTRAT ';

  strFatGor := strFatGor + ' , CQ.EQU_DESCRI AS DSEQOS ';

  strFatGor := strFatGor + ' ,EQ.EQU_NSERIE AS NSERIE ';
  strFatGor := strFatGor + ' ,EQ.EQU_DADFAB AS DADFAB ';
  strFatGor := strFatGor + ' ,EQ.EQU_NUMPAT AS NUMPAT ';
  strFatGor := strFatGor + ' ,EU.EQU_TECSER AS TECSER ';
  strFatGor := strFatGor + ' ,TE.OPE_NOMOPE AS NOMTEC ';

  strFatGor := strFatGor + ',  COALESCE((SELECT ';
  strFatGor := strFatGor + '             CONCAT(EQU_NUMOSE,"-","OS") AS DOCORI ';//NUMERO DA ORDEM DE SERVIÇO CASO FOI GERADO ESSE PEDIDO DO CONSERTO DE EQUIPAMENTOS
  strFatGor := strFatGor + '             FROM EQUGER ';
  strFatGor := strFatGor + '             WHERE (EQU_TIPPED = "PD"       AND ';
  strFatGor := strFatGor + '                    EQU_NUMPED = FGO_NUMDOC AND ';
  strFatGor := strFatGor + '                    EQU_EMPPED = FGO_CODEMP AND ';
  strFatGor := strFatGor + '                    EQU_TIPPED = FGO_ESPDOC) ';
  strFatGor := strFatGor + '             UNION  ';
  strFatGor := strFatGor + '             SELECT CONCAT(EQU_NUMOSE,"-","OS") AS DOCORI ';
  strFatGor := strFatGor + '             FROM EQUGER ';
  strFatGor := strFatGor + '             INNER JOIN EQUGOR ON FGO_SEQEQU = EQUGER.AUTOINCREM ';
  strFatGor := strFatGor + '             WHERE FGO_SEQFGO = F.AUTOINCREM ';
  strFatGor := strFatGor + '             LIMIT 1), ';

  strFatGor := strFatGor + '           COALESCE((SELECT ';
  strFatGor := strFatGor + '                     CONCAT(FDO_NUMDOC,"-",FDO_ESPDOC) AS DOCORI ';//DOCUMENTO DE ORIGEM FATURAMENTO (OR)
  strFatGor := strFatGor + '                     FROM FATDOR ';
  strFatGor := strFatGor + '                    WHERE FDO_TIPFAT = FGO_ESPDOC AND ';
  strFatGor := strFatGor + '                          FDO_NUMFAT = FGO_NUMDOC AND ';
  strFatGor := strFatGor + '                          FDO_EMPFAT = FGO_CODEMP AND ';
  strFatGor := strFatGor + '                          FDO_JAFATU = 1 ';
  strFatGor := strFatGor + '                    LIMIT 1), "")  ';
  strFatGor := strFatGor + '            ) AS DOCORI  ';

  strFatGor := strFatGor + ' ,T.TRA_FONE02 AS TRAFO2 ';
  strFatGor := strFatGor + ' ,T.TRA_F_A_X_ AS TRAFAX ';

  strFatGor := strFatGor + ' ,IV.INV_INCTER AS INCTER ';
  strFatGor := strFatGor + ' ,IV.INV_PORDES AS INVDES ';
  strFatGor := strFatGor + ' ,IV.INV_POREMB AS INVEMB ';
  strFatGor := strFatGor + ' ,IV.INV_AEROPO AS AEROPO ';
  strFatGor := strFatGor + ' ,IV.INV_TARIFA AS TARINV ';
  strFatGor := strFatGor + ' ,IV.INV_SEGURO AS SEGINV ';
  strFatGor := strFatGor + ' ,IV.INV_FRETE_ AS FREINV ';
  strFatGor := strFatGor + ' ,IV.INV_NOTIFY AS NOTIFY ';
  strFatGor := strFatGor + ' ,IV.INV_EWORKS AS EWORKS ';
  strFatGor := strFatGor + ' ,IV.INV_CONTAI AS CONTAI ';
  strFatGor := strFatGor + ' ,IV.INV_PACKIN AS PACKIN ';

  strFatGor := strFatGor + ' ,IC.ICT_CODICT AS CODICT ';
  strFatGor := strFatGor + ' ,IC.ICT_DESCRI AS DESICT ';
  strFatGor := strFatGor + ' ,IC.ICT_SIGLA_ AS SIGICT ';
  strFatGor := strFatGor + ' ,IC.ICT_TPTERM AS TPTERM ';
  strFatGor := strFatGor + ' ,IC.ICT_LAYETI AS LAYETI ';
  strFatGor := strFatGor + ' ,IC.ICT_TARIFA AS TRFEMB ';
  strFatGor := strFatGor + ' ,IC.ICT_SEGURO AS SGMARI ';
  strFatGor := strFatGor + ' ,IC.ICT_FRETE_ AS FRTOCE ';

  strFatGor := strFatGor + ' ,P1.PRT_CODPRT AS CODPR1 ';
  strFatGor := strFatGor + ' ,P1.PRT_DESCRI AS DESPR1 ';
  strFatGor := strFatGor + ' ,CP1.CID_NOMCID AS CIDAP1 ';
  strFatGor := strFatGor + ' ,CP1.CID_ESTADO AS ESTAP1 ';
  strFatGor := strFatGor + ' ,(SELECT DISTINCT IFNULL(IBG_NOMPAI, "") FROM IBG_CADPAI WHERE IBG_CODPAI = P1.PRT_CODPAI) AS PAISP1 ';

  strFatGor := strFatGor + ' ,P2.PRT_CODPRT AS CODPR2 ';
  strFatGor := strFatGor + ' ,P2.PRT_DESCRI AS DESPR2 ';
  strFatGor := strFatGor + ' ,CP2.CID_NOMCID AS CIDAP2 ';
  strFatGor := strFatGor + ' ,CP2.CID_ESTADO AS ESTAP2 ';
  strFatGor := strFatGor + ' ,(SELECT DISTINCT IFNULL(IBG_NOMPAI, "") FROM IBG_CADPAI WHERE IBG_CODPAI = P2.PRT_CODPAI) AS PAISP2 ';

  strFatGor := strFatGor + ' ,AR.AER_CODAER AS CODAER ';
  strFatGor := strFatGor + ' ,AR.AER_DESCRI AS DESAER ';
  strFatGor := strFatGor + ' ,AER.CID_NOMCID AS CIDAER ';
  strFatGor := strFatGor + ' ,AER.CID_ESTADO AS ESTAER ';
  strFatGor := strFatGor + ' ,(SELECT DISTINCT IFNULL(IBG_NOMPAI, "") FROM IBG_CADPAI WHERE IBG_CODPAI = AR.AER_CODPAI) AS PAIAER ';

  strFatGor := strFatGor + ' ,CAST(DATEDIFF(FGO_DTAENT, FGO_PREVIS) AS CHAR(5)) AS QTDIAS ';

  strFatGor := strFatGor + ' ,0.00 AS TOTCHP ';

  strFatGor := strFatGor + ' ,(SELECT GER_NUMROM FROM ROMGERX ';
  strFatGor := strFatGor + '  WHERE GER_NUMDOC = :NUMDOC AND ';
  strFatGor := strFatGor + '        GER_ESPDOC = :ESPDOC AND ';
  strFatGor := strFatGor + '        GER_CODEMP = :CODEMP AND ';
  strFatGor := strFatGor + '        GER_OPEBAI IS NULL   AND ';
  strFatGor := strFatGor + '        GER_DTABAI IS NULL LIMIT 1) AS ROMDOC ';

  strFatGor := strFatGor + ' ,(SELECT MOT_NOMMOT FROM ROMGERX RX ';
  strFatGor := strFatGor + '  LEFT JOIN CADMOT MT ON RX.GER_CODMOT = MT.MOT_CODMOT ';
  strFatGor := strFatGor + '  WHERE GER_NUMDOC = :NUMDOC AND ';
  strFatGor := strFatGor + '        GER_ESPDOC = :ESPDOC AND ';
  strFatGor := strFatGor + '        GER_CODEMP = :CODEMP AND ';
  strFatGor := strFatGor + '        GER_OPEBAI IS NULL   AND ';
  strFatGor := strFatGor + '        GER_DTABAI IS NULL LIMIT 1) AS NOMMOT ';
  strFatGor := strFatGor + ' ,C.CLI_OBSERV AS OBSERV ';
  strFatGor := strFatGor + ' ,EG.FGO_VALCRE AS VALCRE ';
  strFatGor := strFatGor + ' ,EG.FGO_CODPOR AS PORREC ';
  strFatGor := strFatGor + ' ,CPO.POR_NOMPOR AS NOMREC ';

  strSQLMecGo := fRetornarTodosMecanicosServicos('FATGOR',
                                                 recDocume.strNumDoc,
                                                 recDocume.strEspDoc,
                                                 recDocume.strCodCli,
                                                 recDocume.strCodEmp);
  if (not fEmptyStr(strSQLMecGo)) then
    strFatGor := strFatGor + ' ,MEC.MESEGO AS MESEGO '
  else
    strFatGor := strFatGor + ' ,CAST("" AS CHAR(20)) AS MESEGO ';

  strFatGor := strFatGor + '  ,0.00       AS MARBRU ';
  strFatGor := strFatGor + '  ,0.00       AS MARLIQ ';
  strFatGor := strFatGor + '  ,0.00       AS TOTCU2 ';

  strFatGor := strFatGor + '  ,0.00       AS DESCTO ';

  strFatGor := strFatGor + ',    OV.OPE_NOMFAN AS NOFAOP, ';
  strFatGor := strFatGor + '     EP.EMP_HOMEPA AS HOMEPG,  ';

  strFatGor := strFatGor + ' (SELECT CONCAT(MT.DET_NUMDOC, "-" , MT.DET_ESPDOC)   ';
  strFatGor := strFatGor + ' FROM FATGOR F                                        ';
  strFatGor := strFatGor + ' JOIN FATDOR FR ON F.AUTOINCREM = FR.FDO_SEQGER       ';
  strFatGor := strFatGor + ' JOIN EXTDOR ER ON FR.AUTOINCREM = ER.FDO_SEQFDO      ';
  strFatGor := strFatGor + ' JOIN MOVDET MT ON MT.AUTOINCREM = ER.FDO_INCDEV      ';
  strFatGor := strFatGor + '   WHERE F.FGO_NUMDOC = :NUMDOC            ';
  strFatGor := strFatGor + '    AND F.FGO_ESPDOC = :ESPDOC            ';
  strFatGor := strFatGor + '    AND F.FGO_CODEMP = :CODEMP LIMIT 1) AS NRORIG ';

  //IIF ( TOTDIG <> TOTORI , DSVLDG , DSVLOR )
  strFatGor := strFatGor + ' ,(SELECT ';
  strFatGor := strFatGor + '   SUM(X.VLRDSC) FROM ';
  strFatGor := strFatGor + '   (SELECT (F.FDO_QTDITE * F.FDO_UNIDIG) * (F.FDO_DESCON / 100) AS VLRDSC ';
  strFatGor := strFatGor + '      FROM ';
  strFatGor := strFatGor + '    FATDOR F ';
  strFatGor := strFatGor + '     WHERE F.FDO_NUMDOC = :NUMDOC ';
  strFatGor := strFatGor + '       AND F.FDO_ESPDOC = :ESPDOC ';
  strFatGor := strFatGor + '       AND F.FDO_CODEMP = :CODEMP) AS X) AS DSVLDG ';

  strFatGor := strFatGor + ' ,(SELECT ';
  strFatGor := strFatGor + '   SUM(X.VLRDSC) FROM ';
  strFatGor := strFatGor + '   (SELECT (F.FDO_QTDITE * F.FDO_UNIORI) * (F.FDO_DESCON / 100) AS VLRDSC ';
  strFatGor := strFatGor + '      FROM ';
  strFatGor := strFatGor + '    FATDOR F ';
  strFatGor := strFatGor + '     WHERE F.FDO_NUMDOC = :NUMDOC ';
  strFatGor := strFatGor + '       AND F.FDO_ESPDOC = :ESPDOC ';
  strFatGor := strFatGor + '       AND F.FDO_CODEMP = :CODEMP) AS X) AS DSVLOR, ';

  strFatGor := strFatGor + ' " ' + fRetDesTipoAbf('C',recDocume.strCodCli) + '" AS TIPABF ';

  strFatGor := strFatGor + '  ,CONCAT(LL.LOG_CODOPE, " - ", CD.OPE_NOMOPE) AS IDEOPE ';

  strFatGor := strFatGor + '  ,C.CLI_DESCON AS CLIDES ';
  strFatGor := strFatGor + ' ,CDR.REG_DESREG AS REGENT ';

  strFatGor := strFatGor + ' ,EG.FGO_CELCON AS CELCON ';

  strFatGor := strFatGor + ' ,IF(EG.FGO_VENPRE = "S", "VENDA PRESENCIAL"," ") AS VENPRE ';
  strFatGor := strFatGor + ',IFNULL(EG.FGO_FRECOT, 0) AS FRECOT ';
  strFatGor := strFatGor + ' ,IFNULL(C.CLI_MSGPED, " ") AS MSGPED ';
  strFatGor := strFatGor + ' ,F.FGO_NUMREG AS NUMREG ';
  strFatGor := strFatGor + ' , 0.00       AS TOTMT3 ';

  strFatGor := strFatGor + ' ,EG.FGO_DTCOAG AS DTCOAG ';
  strFatGor := strFatGor + ' ,IFNULL(EG.FGO_EMPEXP, "") AS EMPEXP ';

  strFatGor := strFatGor + 'FROM ';

  strFatGor := strFatGor + '  FATGOR F ';
  strFatGor := strFatGor + '  LEFT JOIN CADOPE OV ON OV.OPE_CODOPE   = FGO_CODVEN    ';
  strFatGor := strFatGor + '  LEFT JOIN CADOPE OD ON OD.OPE_CODOPE   = FGO_CODDIG    ';
  strFatGor := strFatGor + '  LEFT JOIN CADEMP EP ON EP.EMP_CODEMP   = F.FGO_CODEMP    ';
  strFatGor := strFatGor + '       JOIN CADCLI C  ON FGO_CODCLI      = C.CLI_CODCLI  ';

  strFatGor := strFatGor + '  LEFT JOIN EXTGOR EG ON EG.FGO_SEQFGO   = F.AUTOINCREM  ';
  strFatGor := strFatGor + '  LEFT JOIN CADPRJ PR ON PR.PRJ_CODPRJ   = EG.FGO_CODPRJ ';
  strFatGor := strFatGor + '  LEFT JOIN ENTREG ER  ON EG.FGO_CODROT  = ER.ENT_CODIGO ';
  if fCfgSis('ROTEMP', varBoolean) then
  begin
    strFatGor := strFatGor + '  AND ER.ENT_CODEMP = F.FGO_CODEMP ';
  end;
  strFatGor := strFatGor + '  LEFT JOIN CADREG RG  ON RG.REG_CODREG  = IFNULL(ER.ENT_CODREG, C.CLI_CODREG) ';

  strFatGor := strFatGor + '  LEFT JOIN CADTRA T   ON FGO_CODTRA     = T.TRA_CODTRA  ';
  strFatGor := strFatGor + '  LEFT JOIN CADTRA TR ON EG.FGO_TRARDP   = TR.TRA_CODTRA ';
  strFatGor := strFatGor + '  LEFT JOIN CADCID CTR ON CTR.CID_CODCID = TR.TRA_CODCID ';
  strFatGor := strFatGor + '  LEFT JOIN CADCID CT ON CT.CID_CODCID   = T.TRA_CODCID  ';
  strFatGor := strFatGor + '  LEFT JOIN CADCND    ON FGO_CODCND      = CND_CODIGO    ';
  strFatGor := strFatGor + '  LEFT JOIN CADFPG    ON FPG_CODIGO      = FGO_CODFPG    ';
  strFatGor := strFatGor + '  LEFT JOIN CADOPE OS ON OS.OPE_CODOPE   = FGO_SEPEXP    ';
  strFatGor := strFatGor + '  LEFT JOIN CADOPE OX ON OX.OPE_CODOPE   = FGO_OPEEXP    ';
  strFatGor := strFatGor + '  LEFT JOIN CADVEI VE ON VE.VEI_PLAVEI   = EG.FGO_PLAVEI ';
  strFatGor := strFatGor + '  LEFT JOIN MARVEI MV ON MV.MAR_CODMAR   = VE.VEI_CODMAR ';
  strFatGor := strFatGor + '  LEFT JOIN MODVEI MO ON MO.MOD_CODMOD   = VE.VEI_CODMOD ';
  strFatGor := strFatGor + '  LEFT JOIN CORVEI CO ON CO.COR_CODCOR   = VE.VEI_CODCOR ';
  strFatGor := strFatGor + '  LEFT JOIN CADOCO OC ON OC.OCO_CODOCO   = FGO_CODOCO    ';
  strFatGor := strFatGor + '  LEFT JOIN SERGOR SG ON SG.FGO_SEQFGO   = F.AUTOINCREM  ';
  strFatGor := strFatGor + '  LEFT JOIN CADTPA TP ON TP.TPA_CODIGO   = EG.FGO_CODTPA ';
  strFatGor := strFatGor + '  LEFT JOIN CLICTT TT ON F.FGO_CLICTT    = TT.AUTOINCREM ';
  strFatGor := strFatGor + '  LEFT JOIN CADEMP EM ON EM.EMP_CODEMP   = EG.FGO_EMP_TE ';
  strFatGor := strFatGor + '  __EQUGER__ ';
  strFatGor := strFatGor + '  LEFT JOIN CADEQU CQ ON (CQ.EQU_CODIGO  = EQ.EQU_CODEQU) ';
  strFatGor := strFatGor + '  LEFT JOIN AUXGOR AG ON F.AUTOINCREM = AG.AUX_SEQGER     ';
  strFatGor := strFatGor + '  LEFT JOIN ENTCLI EC ON EC.ETC_CODCLI = F.FGO_CODCLI  AND IF(IFNULL(AG.AUX_ENTGER, "") <> "", EC.AUTOINCREM = AG.AUX_ENTGER, EC.ETC_SEQIND = ';
  strFatGor := strFatGor + '         (SELECT MIN(ETC_SEQIND)  FROM ENTCLI  WHERE ETC_CODCLI = F.FGO_CODCLI) ) ';
  strFatGor := strFatGor + '    LEFT JOIN CADCID CE ON CE.CID_CODCID = EC.ETC_CIDENT ';
  strFatGor := strFatGor + '    LEFT JOIN CADCID CC ON CC.CID_CODCID = F.FGO_CIDCON ';
  strFatGor := strFatGor + '    LEFT JOIN CADCID CF ON CF.CID_CODCID =  C.CLI_CODCID ';
  strFatGor := strFatGor + '    LEFT JOIN PRDAMO PA ON PA.PRD_SEQGER =  F.AUTOINCREM ';
  strFatGor := strFatGor + ' LEFT JOIN CADRED CR ON CR.RED_CODRED = C.CLI_CODRED ';
  strFatGor := strFatGor + ' LEFT JOIN CADCAC CA ON CA.CAC_CODCAC = C.CLI_CODCAC ';
  strFatGor := strFatGor + ' LEFT JOIN EQUSER EU ON EU.EQU_SEQGER = EQ.AUTOINCREM ';
  strFatGor := strFatGor + ' LEFT JOIN CADOPE TE ON EU.EQU_TECSER = TE.OPE_CODOPE ';
  strFatGor := strFatGor + ' LEFT JOIN INVOIC IV ON IV.INV_SEQFGO = F.AUTOINCREM ';
  strFatGor := strFatGor + ' LEFT JOIN CADICT IC ON IC.ICT_CODICT = IV.INV_INCTER ';
  strFatGor := strFatGor + ' LEFT JOIN CADPRT P1 ON P1.PRT_CODPRT = IV.INV_PORDES ';
  strFatGor := strFatGor + ' LEFT JOIN CADPRT P2 ON P2.PRT_CODPRT = IV.INV_POREMB ';
  strFatGor := strFatGor + ' LEFT JOIN CADCID CP1 ON CP1.CID_CODCID = P1.PRT_CODCID ';
  strFatGor := strFatGor + ' LEFT JOIN CADCID CP2 ON CP2.CID_CODCID = P2.PRT_CODCID ';
  strFatGor := strFatGor + ' LEFT JOIN CADAER AR ON AR.AER_CODAER = IV.INV_AEROPO ';
  strFatGor := strFatGor + ' LEFT JOIN CADCID AER ON AER.CID_CODCID = AR.AER_CODCID ';
  strFatGor := strFatGor + ' LEFT JOIN CADCID CCID ON CCID.CID_CODCID = TT.CLI_CIDCTT ';
  strFatGor := strFatGor + ' LEFT JOIN CADPOR CPO ON CPO.POR_CODPOR = EG.FGO_CODPOR ';
  strFatGor := strFatGor + ' LEFT JOIN LOGLIB LL ON LL.LOG_NUMDOC = F.FGO_NUMDOC AND ';
  strFatGor := strFatGor + '                        LL.LOG_CODEMP = F.FGO_CODEMP AND ';
  strFatGor := strFatGor + '                        LL.LOG_CODVEN = F.FGO_CODVEN AND ';
  strFatGor := strFatGor + '                        LL.LOG_ESPDOC = F.FGO_ESPDOC     ';
  strFatGor := strFatGor + ' LEFT JOIN CADOPE CD ON CD.OPE_CODOPE = LL.LOG_CODOPE ';
  strFatGor := strFatGor + ' LEFT JOIN CADREG CDR ON CDR.REG_CODREG = EC.ETC_CODREG ';

  If (Not fEmptyStr(strSQLMecGo)) Then
    strFatGor := strFatGor + ' LEFT JOIN ( ' + strSQLMecGo + ' ) AS MEC ON F.AUTOINCREM = MEC.SEQFGO ';

  strFatGor := strFatGor + 'WHERE ';
  strFatGor := strFatGor + '  FGO_NUMDOC = :NUMDOC AND ';
  strFatGor := strFatGor + '  FGO_ESPDOC = :ESPDOC AND ';
  strFatGor := strFatGor + '  FGO_CODCLI = :CODCLI AND ';
  strFatGor := strFatGor + '  FGO_CODEMP = :CODEMP     ';

  If recDocume.blnCancelamento Then
  Begin
    If recDocume.strEspSel = 'NE' Then
      strFatGor := strFatGor + ' AND IFNULL(FGO_SERIE_, "") = :SERIE_ ';
  End;

  If recDocume.blnDocCan Then
  Begin
    strFatGor := TRegEx.Replace(strFatGor, '\bFATGOR\b', 'DEL_FATGOR'); // Faz replace com RegExp pra usar "Whole words" devido ao campo COD_FATGOR
    strFatGor := AnsiReplaceStr(strFatGor, 'FATDOR', 'DEL_FATDOR');
    strFatGor := AnsiReplaceStr(strFatGor, '" " AS DOCCAN','"C" AS DOCCAN');
    strFatGor := AnsiReplaceStr(strFatGor, '" " AS MOTDEL','MOTDEL AS MOTDEL');
    strFatGor := AnsiReplaceStr(strFatGor, '" " AS OPEDEL','OPEDEL AS OPEDEL');
    strFatGor := AnsiReplaceStr(strFatGor, '" " AS DTADEL','DATE_FORMAT(DTADEL,"%d/%m/%Y") AS DTADEL');
  End;

  If fCfgSis('IFVLOR', varBoolean) Then
  Begin
    strFatGor := AnsiReplaceStr(strFatGor, '" " AS ORCVEN', 'DATEDIFF(EG.FGO_VALORC, F.FGO_DTAENT) AS ORCVEN');
    strFatGor := AnsiReplaceStr(strFatGor, '" " AS VALORC', 'EG.FGO_VALORC AS VALORC');
  End
  Else
  Begin
    strFatGor := AnsiReplaceStr(strFatGor, '" " AS ORCVEN', QuotedStr(fCfgSis('ORCVEN',varString, recDocume.strCodEmp))+ ' AS ORCVEN');
    strFatGor := AnsiReplaceStr(strFatGor, '" " AS VALORC', 'DATE_ADD(F.FGO_DTAENT, INTERVAL ' + fCfgSis('ORCVEN',varString, recDocume.strCodEmp) + ' DAY) AS VALORC');
  End;

  Result := AnsiReplaceStr(strFatGor, '__EQUGER__', ' LEFT JOIN EQUGER EQ ON (EQ.EQU_NUMPED  = F.FGO_NUMDOC AND EQ.EQU_TIPPED = F.FGO_ESPDOC AND EQ.EQU_EMPPED = F.FGO_CODEMP) ') +
            ' UNION ' +
            AnsiReplaceStr(strFatGor, '__EQUGER__', ' LEFT JOIN EQUGOR ON F.AUTOINCREM       = EQUGOR.FGO_SEQFGO ' +
                                                    ' LEFT JOIN EQUGER EQ ON (EQ.AUTOINCREM  = EQUGOR.FGO_SEQEQU) ');
End;

Function TLeDocumentoPDOR.fSQLTabPre: String;
Begin
  With recDocume Do
  If (fCfgSis('TABITE', varBoolean)) And (fCfgSis('IPTPFT', varBoolean)) And (Pos(strEspDoc, fCfgSis('ESPITP')) > 0) Then
    Result := 'IF(FDO_PROMOC = "S", "PR", FDO_TABPRE), "-", '
  Else
    Result := '';
End;

class function TLeDocumentoPDOR.fTemDel_LotDor(const recDocume : TRecDocumento) : Boolean;
  const
    SQL_ITENS = 'SELECT AUTOINCREM FROM DEL_FATDOR WHERE FDO_NUMDOC = :NUMDOC AND FDO_ESPDOC = :ESPDOC AND FDO_CODEMP = :CODEMP';
  var
    qryDel : TUniQuery;
begin

  qryDel := fCriaQuery;

  Try

    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add('SELECT COUNT(*) AS TOT FROM DEL_LOTDOR WHERE LDO_SEQFDO IN ('+SQL_ITENS+')');
    qryDel.ParamByName('NUMDOC').AsString := recDocume.strNumDoc;
    qryDel.ParamByName('ESPDOC').AsString := recDocume.strEspDoc;
    qryDel.ParamByName('CODEMP').AsString := recDocume.strCodEmp;
    qryDel.Open;

    Result := (Not qryDel.IsEmpty) And (qryDel.FieldByName('TOT').AsInteger > 0);

  Finally
    FreeAndNil(qryDel);
  End;

end;

function TLeDocumentoPDOR.fUtilizaImagemOtimizada: Boolean;
begin
  Result := (VS_SpoolImpressaoCitel) and (fCfgSis('SPOOTM', VarBoolean));
end;

class function TLeDocumentoPDOR.fGetSqlQtdItePedOrc(const recDocume : TRecDocumento): String;
begin
  With recDocume Do
  Begin
    Result := '';

    If blnAgruparItensSeparacao Then
      Result := Result + ' SUM( ';

    If recDocume.blnDocSep And recDocume.blnImpExpedicao And (recDocume.intSeqSepPar > 0) Then
      Result := Result + ' SEP_QTDSEP '
    Else If blnDocSep And fPermiteImprimirSeparacaoParcial Then
      Result := Result + ' (FDO_QTDSEP - ' + fGetSQLQtdBaixada(recDocume) + ') '
    Else If blnQtdOri Or recDocume.blnFatAut Then
      Result := Result + ' FDO_QTDITE '
    Else If (blnOpcFat) Then
      Result := Result + ' FDO_QTDBAI '
    Else
      Result := Result + ' (FDO_QTDITE - ' + fGetSQLQtdBaixada(recDocume) + ') ';

    If blnAgruparItensSeparacao Then
      Result := Result + ' ) ';
  End;    
end;

class function TLeDocumentoPDOR.fGetSqlQtdEmbPedOrc(const recDocume : TRecDocumento): String;
begin
  Result := ' IF(ITE_MLTVEN > 0, ' + fGetSqlQtdItePedOrc(recDocume) + ' / ITE_MLTVEN, 0) ';
end;

function TLeDocumentoPDOR.fGetSqlGroupByPedOrc: String;
  var
    LstrCFGItensSintetizacao : String;
    LintIdx                  : Integer;
    LstrAgrupamento1,
    LstrAgrupamento2         : String;
begin
  Result := '';
  LstrAgrupamento1 := '';
  LstrAgrupamento2 := '';

  With recDocume Do
  If blnAgruparItensSeparacao Then
  Begin
    LstrCFGItensSintetizacao := fCfgSis('ITESIN');
    for LintIdx := 1 to 7 do
    Begin
      if LstrCFGItensSintetizacao[LintIdx] = '1' then
      Begin
        case LintIdx of
          1 : LstrAgrupamento1 := LstrAgrupamento1 + ' FDO_CODITE,';
          2 : LstrAgrupamento1 := LstrAgrupamento1 + ' FDO_DESCRI,';
          3 : LstrAgrupamento1 := LstrAgrupamento1 + ' FDO_COMPLE,';
          4 : LstrAgrupamento1 := LstrAgrupamento1 + ' FDO_IDEPRO,';
          5 :
            Begin
              If (fUsaRotinaWMS And recDocume.blnDocSep) Or (fRetEhReimpressaoDeDocumentoCanceladoWMS(recDocume)) Or (fRetEhImpressaoDeDocumentoBaixadoWMS(recDocume)) Then
                LstrAgrupamento1 := LstrAgrupamento1 + ' IFNULL(LD.LDO_NUMLOT, L.LDO_NUMLOT),'
              Else
                LstrAgrupamento1 := LstrAgrupamento1 + ' FDO_NUMLOT,'
            End;
          6 : LstrAgrupamento1 := LstrAgrupamento1 + ' FDO_ENTRET,';
          7 : LstrAgrupamento1 := LstrAgrupamento1 + ' FDO_PEGOU_,';
        end;
      End;
    End;

    LstrAgrupamento1 := Copy(LstrAgrupamento1, 1, Length(LstrAgrupamento1)-1);

    If (fCfgSis('VENMTL',varBoolean)) And (recDocume.blnDocSep) Then
      LstrAgrupamento2 := ' FDO_COMPEC, FDO_LARPEC, FDO_ESPPEC ';

    if not fEmptyStr(LstrAgrupamento1) or not fEmptyStr(LstrAgrupamento2) then
    Begin
      Result :=' GROUP BY ';

      if not fEmptyStr(LstrAgrupamento1) then
        Result := Result + LstrAgrupamento1;

     if not fEmptyStr(LstrAgrupamento2) then
       Result := Result + IIF(not fEmptyStr(LstrAgrupamento1), ', '+LstrAgrupamento2, LstrAgrupamento2);
    End;

    If Not fEmptyStr(Result) And recDocume.blnDocSep Then
      Result := Result + ' ,MT.DET_LOCFIS';
  End;

end;

function TLeDocumentoPDOR.fSqlCampoSetor: String;
Begin
  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    Result := 'IF(IFNULL(FD.FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) '
  else
  If (fCfgSis('GRUSEP', VarString) = 'S') then
    Result := 'LSE_DESCRI'
  Else
    Result := 'LEFT(ITE_LOCFIS, 1)';
End;

Function TLeDocumentoPDOR.fSQLItems: String;
Var
  strSQL,
  strEntRet,
  strSQLEntRet,
  strSQLMec: String;
  intTab: integer;

  function fSum: String;
  begin
    Result := IIF(recDocume.blnAgruparItensSeparacao, ' SUM', ' ');
  end;

Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   (@ROW := @ROW + 1) AS SEQDET, ';
  strSQL := strSQL + '   IF ( ( FDO_DTENTR - CURRENT_DATE ) > 0 , ( FDO_DTENTR - (SELECT FATGOR.FGO_PREVIS FROM FATGOR WHERE FATGOR.AUTOINCREM = FD.FDO_SEQGER) ) + " DIAS" , "IMEDIATO" ) AS PRAZO_ENTREGA, ';
  strSQL := strSQL + '    FDO_UNIDOL AS VLR_DOLAR, ';
  strSQL := strSQL + '    FDO_TOTDOL AS TOT_DOLAR, ';
  strSQL := strSQL + '    FDO_NUMDOC AS NUMDOC, ';

  strSQL := strSQL + '    FDO_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '    FDO_CODEMP AS CODEMP, ';
  strSQL := strSQL + '    (SELECT FATGOR.FGO_DTAENT FROM FATGOR WHERE FATGOR.AUTOINCREM = FD.FDO_SEQGER) AS DTAENT, ';
  strSQL := strSQL + '    FDO_CODCLI, ';
  strSQL := strSQL + '    (SELECT CLI_NOMCLI FROM CADCLI WHERE CLI_CODCLI = FDO_CODCLI) AS CLI_NOMCLI, ';

  strSQL := strSQL + '    FDO_CLAFIS AS CLAFIS, ';
  strSQL := strSQL + '  I.ITE_DIAFOR AS DIAFOR, ';
  strSQL := strSQL + '  I.ITE_DESSIM AS DESSIM, ';
  strSQL := strSQL + '  I.ITE_DESITE AS DESCAD, ';
  strSQL := strSQL + '  IFNULL(S.ITE_EXPALT, 0) AS EXPALT, ';
  strSQL := strSQL + '  IFNULL(S.ITE_EXPLAR, 0) AS EXPLAR, ';
  strSQL := strSQL + '  IFNULL(S.ITE_EXPPRO, 0) AS EXPPRO, ';
  strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '  I.ITE_CODBAR AS CODBAR, ';

  If (fCfgSis('CUSESP', varBoolean)) then
  begin
    strSQL := strSQL + '  IF( LOCATE("ITEM ESPECIAL", I.ITE_DESITE) > 0, E.TRI_NCMTIN, I.ITE_CLAIPI ) AS CLAIPI, ';
  end
  else
  begin
    strSQL := strSQL + '  I.ITE_CLAIPI AS CLAIPI, ';
  end;

  strSQL := strSQL + '  I.ITE_APLICA AS APLICA, ';
  strSQL := strSQL + '  I.ITE_MLTCOM AS MLTCOM, ';
  strSQL := strSQL + fRetSTRCampoBlobToCast255('I.ITE_APLICA', 'APLICA');
  strSQL := strSQL + '    ITE_EMBALA AS EMBALA, ';

  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    strSQL := strSQL + '    IF(IFNULL(FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI)  AS LOCSEP, '
  else
  If (fUsaRotinaWMS And recDocume.blnDocSep) Or (fRetEhReimpressaoDeDocumentoCanceladoWMS(recDocume)) Then
    strSQL := strSQL + '    CL.LOT_LOCSEP AS LOCSEP, '
  Else
    strSQL := strSQL + '    LSE_DESCRI AS LOCSEP, ';

  strSQL := strSQL + '  FDO_VALFCP AS VFCPST, ';
  strSQL := strSQL + '  ID.ICD_VALFCP AS FCPDOR, ';

  strSQL := strSQL + '  I.ITE_MLTVEN AS MLTVEN, ';

  strSQL := strSQL + '  I.ITE_CODGRU AS CODGRU, ';

  If (recDocume.blnDocSep) And ((Not fEmptyStr(Trim(recDocume.strSetor))) Or fCfgSis('SEPSST', varBoolean)) Then
  Begin
    strSQL := strSQL + '  (SELECT G2.ITE_SALDOS ';
    strSQL := strSQL + '     FROM ITEGER G2 ';
    strSQL := strSQL + '    WHERE G2.ITE_CODITE = FDO_CODITE ';
    strSQL := strSQL + '      AND G2.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp)+') AS SALDOS,'
  End
  Else
    strSQL := strSQL + '  G.ITE_SALDOS AS SALDOS, ';

  strSQL := strSQL + '  G.ITE_LOCSUP AS LOCSUP, ';

  If fCfgSis('CLIPRO', varBoolean) then
  begin
    strSQL := strSQL + ' CLIPRO.CLI_COD_NF, ';
    strSQL := strSQL + ' CLIPRO.CLI_DES_NF, ';
    strSQL := strSQL + ' CLIPRO.CLI_CODBAR AS CODBRR, ';
  end
  else
  begin
    strSQL := strSQL + ' CAST("" AS CHAR(20)) AS CLI_COD_NF, ';
    strSQL := strSQL + ' CAST("" AS CHAR(70)) AS CLI_DES_NF, ';
    strSQL := strSQL + ' CAST("" AS CHAR(20)) AS CODBRR, ';
  end;

  strSQL := strSQL + '    DEP_DESCRI AS NOMDEP, ';

  strSQL := strSQL + '  I.ITE_CODONU AS CODONU, ';
  strSQL := strSQL + '    ONU_DESCRI AS DESONU, ';
  strSQL := strSQL + '    ONU_CODIGO AS CADONU, ';
  strSQL := strSQL + '    ONU_CLARIS AS CLAONU, ';
  strSQL := strSQL + '    ONU_GRUEMB AS EMBONU, ';

  strSQL := strSQL + '    GRU_DESGRU AS DESGRU, ';

  strSQL := strSQL + ' IF(IFNULL(GRU_TIPGRU, "9") = "0", "OUTROS", IF(IFNULL(GRU_TIPGRU, "9") = "1", "PEÇAS", IF(IFNULL(GRU_TIPGRU, "9"), "PNEUS", ""))) AS TIPGRU, ';
  If (fUsaRotinaWMS And recDocume.blnDocSep) Or (fRetEhReimpressaoDeDocumentoCanceladoWMS(recDocume)) Or (fRetEhImpressaoDeDocumentoBaixadoWMS(recDocume)) Then
  Begin

    With recDocume Do
    If blnEnt_CD Then
    Begin
      strSQL := strSQL + fRetLocFisicaEmpCD('IFNULL(IFNULL(LD.LDO_NUMLOT, L.LDO_NUMLOT), FDO_NUMLOT)', 'I.ITE_CODITE', 'FDO_CODEMP', True, True, fCfgSis('SPPLFI', varBoolean));
      strSQL := strSQL + fRetDesFisicaEmpCD('IFNULL(IFNULL(LD.LDO_NUMLOT, L.LDO_NUMLOT), FDO_NUMLOT)', 'I.ITE_CODITE', 'FDO_CODEMP', True, True, fCfgSis('SPPLFI', varBoolean));
    End
    Else If blnLocFisEmpEmi Then
    Begin
      strSQL := strSQL + fRetLocFisicaEmpEmissora('IFNULL(IFNULL(LD.LDO_NUMLOT, L.LDO_NUMLOT), FDO_NUMLOT)', 'I.ITE_CODITE', 'FDO_CODEMP', True, True, fCfgSis('SPPLFI', varBoolean));
      strSQL := strSQL + fRetDesFisicaEmpEmissora('IFNULL(IFNULL(LD.LDO_NUMLOT, L.LDO_NUMLOT), FDO_NUMLOT)', 'I.ITE_CODITE', 'FDO_CODEMP', True, True, fCfgSis('SPPLFI', varBoolean));
    End
    Else
    Begin
      strSQL := strSQL + ' IF(IFNULL(E.FDO_REPGAR,"0") = "2", "GARANTIA", ' + IIF(fCfgSis('SPPLFI', varBoolean), 'ITE_LOCFIS', 'IF(IFNULL(IFNULL(IFNULL(LD.LDO_NUMLOT, L.LDO_NUMLOT), FDO_NUMLOT), "") = "", ITE_LOCFIS, CL.LOT_LOCFIS)') + ') AS LOCFIS, ';
      strSQL := strSQL + ' IF(IFNULL(E.FDO_REPGAR,"0") = "2", "GARANTIA", ' + IIF(fCfgSis('SPPLFI', varBoolean), 'L2.LOC_DESCRI', 'IF(IFNULL(IFNULL(IFNULL(LD.LDO_NUMLOT, L.LDO_NUMLOT), FDO_NUMLOT), "") = "", L2.LOC_DESCRI, L1.LOC_DESCRI)') + ') AS DESFIS, ';
    End;

  End
  Else
  Begin

    With recDocume Do
    If blnEnt_CD Then
    Begin
      strSQL := strSQL + fRetLocFisicaEmpCD('FDO_NUMLOT', 'I.ITE_CODITE', 'FDO_CODEMP', True, True, fCfgSis('SPPLFI', varBoolean));
      strSQL := strSQL + fRetDesFisicaEmpCD('FDO_NUMLOT', 'I.ITE_CODITE', 'FDO_CODEMP', True, True, fCfgSis('SPPLFI', varBoolean));
    End
    Else If blnLocFisEmpEmi Then
    Begin
      strSQL := strSQL + fRetLocFisicaEmpEmissora('FDO_NUMLOT', 'I.ITE_CODITE', 'FDO_CODEMP', True, True, fCfgSis('SPPLFI', varBoolean));
      strSQL := strSQL + fRetDesFisicaEmpEmissora('FDO_NUMLOT', 'I.ITE_CODITE', 'FDO_CODEMP', True, True, fCfgSis('SPPLFI', varBoolean));
    End
    Else
    Begin
      strSQL := strSQL + ' IF(IFNULL(E.FDO_REPGAR,"0") = "2", "GARANTIA", ' + IIF(fCfgSis('SPPLFI', varBoolean), 'ITE_LOCFIS', 'IF(IFNULL(FDO_NUMLOT, "") = "", ITE_LOCFIS, CL.LOT_LOCFIS)') + ') AS LOCFIS, ';
      strSQL := strSQL + ' IF(IFNULL(E.FDO_REPGAR,"0") = "2", "GARANTIA", ' + IIF(fCfgSis('SPPLFI', varBoolean), 'L2.LOC_DESCRI', 'IF(IFNULL(FDO_NUMLOT, "") = "", L2.LOC_DESCRI, L1.LOC_DESCRI)') + ') AS DESFIS, ';
    End;

  End;

  strSQL := strSQL + '    UN.UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '    UN.UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '    UN.UNI_DESUNI AS DESUNI, ';

  strSQL := strSQL + '    CAST("" AS CHAR(10)) AS RESUNI, ';

  strSQL := strSQL + '    UC.UNI_DESUNI AS UNICOM, ';

  strSQL := strSQL + '    FDO_CODITE AS CODITE, ';
  strSQL := strSQL + '    FDO_TABPRE AS TABPVE, ';
  strSQL := strSQL + '    FDO_PROMOC AS PROMOC, ';
  strSQL := strSQL + '    IFNULL(FDO_EMPITE, FDO_CODEMP) AS EMPITE, ';

  If (fUsaRotinaWMS And recDocume.blnDocSep) Or (fRetEhReimpressaoDeDocumentoCanceladoWMS(recDocume)) Or (fRetEhImpressaoDeDocumentoBaixadoWMS(recDocume)) Then
    strSQL := strSQL + '    IFNULL(IFNULL(LD.LDO_NUMLOT, L.LDO_NUMLOT), FDO_NUMLOT) AS NUMLOT, '
  Else
    strSQL := strSQL + '    FDO_NUMLOT AS NUMLOT, ';

  strSQL := strSQL + '    FDO_CODACA AS CODACA, ';
  strSQL := strSQL + '    FDO_EMPACA AS EMPACA, ';
  strSQL := strSQL + '    FDO_IDEPRO AS IDEPRO, ';

  If (recDocume.strEspDoc = 'OR') And (fImpDescriSimplificada(recDocume.strCodCli)) Then
    strSQL := strSQL + '  IF(IFNULL(ITE_DESSIM, "") <> "", ITE_DESSIM, FDO_DESCRI) AS DESITE, '
  Else
    strSQL := strSQL + '  FDO_DESCRI AS DESITE, ';

  strSQL := strSQL + '    FDO_DESCRI AS DESCRI, ';
  strSQL := strSQL + '    FDO_DESNES AS DESNES, ';

  strSQL := strSQL + '    FDO_SEQIND AS SEQIND, ';
  strSQL := strSQL + '    FDO_COMPLE AS COMPLE, ';

  strSQL := strSQL + '    CONCAT(' + fSQLTabPre + 'IF(FDO_IDEPRO <> "NOR", CONCAT(FDO_IDEPRO, " - "), ""), IF(FDO_IDEPRO <> "NOR" OR LOCATE("ITEM ESPECIAL", FDO_DESCRI) > 0, CONCAT(FDO_DESCRI, " ", IFNULL(FDO_COMPLE, "")), CONCAT(I.ITE_DESITE, " ", ITE_REFERE)), ' ;
  strSQL := strSQL + '      IF(IFNULL(ITE_CODFAB, "") <> "", CONCAT(" - ", TRIM(LEADING 0 FROM ITE_CODFAB)), "")) AS DESIT1, ';

  strSQL := strSQL + '    CONCAT(' + fSQLTabPre + 'IF(FDO_IDEPRO <> "NOR", CONCAT(FDO_IDEPRO, " - "), ""), IF(FDO_IDEPRO <> "NOR" OR LOCATE("ITEM ESPECIAL", FDO_DESCRI) > 0, CONCAT(FDO_DESCRI, " ", IFNULL(FDO_COMPLE, "")), CONCAT(I.ITE_DESITE, " ", ITE_REFERE))) AS DESIT2, ';

  strSQL := strSQL + '    CONCAT(' + fSQLTabPre + 'IF(FDO_IDEPRO <> "NOR", CONCAT(FDO_IDEPRO, " - "), ""), FDO_DESCRI, " ", IFNULL(FDO_COMPLE, ""), IF(IFNULL(ITE_CODFAB, "") <> "", CONCAT(" - ", TRIM(LEADING 0 FROM ITE_CODFAB)), "")) AS DESIT3, ';

  strSQL := strSQL + '    CONCAT(' + fSQLTabPre + 'IF(FDO_IDEPRO <> "NOR", CONCAT(FDO_IDEPRO, " - "), ""), FDO_DESCRI, " ", IFNULL(FDO_COMPLE, "")) AS DESIT4, ';

  strSQL := strSQL + '    CONCAT(FDO_DESCRI, " - ", TRIM( LEADING 0 FROM IFNULL(ITE_CODFAB, ""))) AS DESFAB, '; //LEADING 0 - retira os zeros a esquerda
  strSQL := strSQL + '    FDO_REFERE AS REFERE, ';
  strSQL := strSQL + '    FDO_UNITAR AS VALUNI, ';
  strSQL := strSQL + '    FDO_UNIORI AS UNIORI, ';
  strSQL := strSQL + '    FDO_CODFIS AS CODFIS, ';
  strSQL := strSQL + '    FDO_ENTRET AS ENTRET, ';

  strSQL := strSQL + '    IF( ';
  strSQL := strSQL + '      FDO_ENTRET = "R", ';
  strSQL := strSQL + '      CONCAT(FDO_ENTRET, IFNULL(FDO_LOCRET,"")), ';
  strSQL := strSQL + '      IF( ';
  strSQL := strSQL + '        FDO_ENTRET = "E" ';
  strSQL := strSQL + '        AND FDO_ENTFUT = "S", ';
  strSQL := strSQL + '        "EF", ';
  strSQL := strSQL + '        "EI" ';
  strSQL := strSQL + '      ) ';
  strSQL := strSQL + '    ) AS SIGDES, ';

  strSQL := strSQL + '    FDO_LOCRET AS LOCRET, ';
  strSQL := strSQL + '    FDO_ENTFUT AS ENTFUT, ';
  strSQL := strSQL + '    FDO_MOTFUT AS MOTFUT, ';
  strSQL := strSQL + '    FDO_PESLIQ AS PESLQD, ';
  strSQL := strSQL + '    FDO_PESBRU AS PESBRT, ';

  If (recDocume.blnAgruparItensSeparacao) And (fCfgSis('VENMTL',varBoolean)) And (recDocume.blnDocSep) Then
    strSQL := strSQL + '  SUM(FDO_QTDPEC) AS QTDPEC, '
  Else
    strSQL := strSQL + '  FDO_QTDPEC AS QTDPEC, ';

  strSQL := strSQL + '    FDO_COMPEC AS COMPEC, ';
  strSQL := strSQL + '    FDO_LARPEC AS LARPEC, ';
  strSQL := strSQL + '    FDO_ESPPEC AS ESPPEC, ';
  strSQL := strSQL + '    FDO_APAREL AS APAREL, ';
  strSQL := strSQL + '    FDO_BENEFI AS BENEFI, ';
  strSQL := strSQL + '    IF(FDO_DESCON < 0, 0.00, FDO_DESCON)       AS DESCON, ';
  strSQL := strSQL + '    IF(FDO_DESCON < 0, FDO_UNITAR, FDO_UNIDIG) AS UNIDIG, ';
  strSQL := strSQL + '    (FDO_QTDITE * (IF(FDO_DESCON < 0, FDO_UNITAR, FDO_UNIDIG))) AS VALDIG, ';

  strSQL := strSQL + '    FDO_CODVEN AS VENITE, ';
  strSQL := strSQL + ' V1.OPE_NOMOPE AS NVENIT, ';

  strSQL := strSQL + '    FDO_CODVE2 AS CODVE2, ';
  strSQL := strSQL + ' V2.OPE_NOMOPE AS NOMVE2, ';

  strSQL := strSQL + '    FDO_CODDIV AS CODDIV, ';
  strSQL := strSQL + ' DI.DIV_NOMDIV AS NOMDIV, ';

  Case VarToStr(fCfgSis('NROPRO', VarString))[1] Of
    '2':strSQL := strSQL + ' CONCAT(FDO_CODDIV,"-",DI.DIV_NOMDIV) AS LISDIV, ';
    '3':strSQL := strSQL + ' (SELECT TRIM(GROUP_CONCAT(CONCAT(" ",CADDIV.DIV_CODDIV,"-",CADDIV.DIV_NOMDIV))) '+
                               '     FROM DIVFAT INNER JOIN CADDIV ON DIVFAT.DIV_CODDIV = CADDIV.DIV_CODDIV '+
                               '     WHERE DIVFAT.DIV_SEQGER = FD.FDO_SEQGER) AS LISDIV, ';
    Else strSQL := strSQL + ' CAST("" AS CHAR(1)) AS LISDIV, ';
  End;

  strSQL := strSQL + '    FDO_CODREP AS CODREP, ';
  strSQL := strSQL + ' OP.OPE_NOMOPE AS NOMREP, ';

  if blnOcultarMarca then
    strSQL := strSQL + '    CAST("" AS CHAR(1)) AS DESMAR, '
  else
    strSQL := strSQL + '    MAR_DESMAR AS DESMAR, ';

  strSQL := strSQL + '    FDO_CODMAR AS CODMAR, ';

  strSQL := strSQL + fSQLQtdIte(recDocume) + ' AS QTDITE, ';

  strSQL := strSQL + fGetSqlQtdEmbPedOrc(recDocume) + ' AS QTDEMB, ';

  With recDocume Do
  Begin
    If (fUsaRotinaWMS And recDocume.blnDocSep) Or (fRetEhReimpressaoDeDocumentoCanceladoWMS(recDocume)) Then
    Begin
      strSQL := strSQL + fSum + '(FDO_UNITAR * L.LDO_QTDITE)                AS VALITE, ';
      strSQL := strSQL + fSum + '((FDO_VALIPI / FDO_QTDITE) * L.LDO_QTDITE) AS VALIPI, ';
      strSQL := strSQL + fSum + '((FDO_VALRET / FDO_QTDITE) * L.LDO_QTDITE) AS VALRET, ';
      strSQL := strSQL + fSum + '(((0' + fSqlValorReformaFdoRef('FD.AUTOINCREM') + ') / FDO_QTDITE) * L.LDO_QTDITE) AS VALREF, ';
      strSQL := strSQL + fSum + '(((0.00 + ' + fSqlCampoReformaRef('FDOREF', 'REF_CBSVAL', 'FD.AUTOINCREM') + ') / FDO_QTDITE) * L.LDO_QTDITE) AS VALCBS, ';
      strSQL := strSQL + fSum + '(((0.00 + ' + fSqlCampoReformaRef('FDOREF', 'REF_VALIBS', 'FD.AUTOINCREM') + ') / FDO_QTDITE) * L.LDO_QTDITE) AS VALIBS, ';
      strSQL := strSQL + fSum + '(((0.00 + ' + fSqlCampoReformaRef('FDOREF', 'REF_SELVAL', 'FD.AUTOINCREM') + ') / FDO_QTDITE) * L.LDO_QTDITE) AS VAL_IS, ';
      strSQL := strSQL + fSum + '((FDO_TOTFRE / FDO_QTDITE) * L.LDO_QTDITE) AS VALFRE, ';
      strSQL := strSQL + fSum + '((FDO_DESESP / FDO_QTDITE) * L.LDO_QTDITE) AS DESESI, ';
      strSQL := strSQL + fSum + '((FDO_BASIPI / FDO_QTDITE) * L.LDO_QTDITE) AS IBASIP, ';
      strSQL := strSQL + fSum + '((FDO_BASRET / FDO_QTDITE) * L.LDO_QTDITE) AS IBASRE, ';
      strSQL := strSQL + fSum + '((FDO_BASICM / FDO_QTDITE) * L.LDO_QTDITE) AS IBASIC, ';
      strSQL := strSQL + fSum + '((FDO_VALICM / FDO_QTDITE) * L.LDO_QTDITE) AS IVALIC, ';
      strSQL := strSQL + fSum + '((FDO_DESACE / FDO_QTDITE) * L.LDO_QTDITE) AS DESACE, ';
      strSQL := strSQL + fSum + '((FDO_VLRCON / FDO_QTDITE) * L.LDO_QTDITE) AS VLRCON, ';
      strSQL := strSQL + fSum + '((FDO_VLRCON / FDO_QTDITE) * L.LDO_QTDITE) AS CONVLR, ';
      strSQL := strSQL + fSum + '(((FDO_VLRCON / FDO_QTDITE) * L.LDO_QTDITE) / FDO_QTDITE) AS ITECON, ';
    End
    Else
    Begin
      strSQL := strSQL + fSum + fRetCampoValorItem('FDO_TOTITE', 'FDO_UNITAR', 'VALITE');
      strSQL := strSQL + fSum + fRetCampoValorItem('FDO_VALIPI', '(FDO_VALIPI / FDO_QTDITE)', 'VALIPI');
      strSQL := strSQL + fSum + fRetCampoValorItem('FDO_VALRET', '(FDO_VALRET / FDO_QTDITE)', 'VALRET');
      strSQL := strSQL + fSum + fRetCampoValorItem('(0' + fSqlValorReformaFdoRef('FD.AUTOINCREM') + ')', '((0' + fSqlValorReformaFdoRef('FD.AUTOINCREM') + ') / FDO_QTDITE)', 'VALREF');
      strSQL := strSQL + fSum + fRetCampoValorItem('(0.00 + ' + fSqlCampoReformaRef('FDOREF', 'REF_CBSVAL', 'FD.AUTOINCREM') + ')', '((0.00 + ' + fSqlCampoReformaRef('FDOREF', 'REF_CBSVAL', 'FD.AUTOINCREM') + ') / FDO_QTDITE)', 'VALCBS');
      strSQL := strSQL + fSum + fRetCampoValorItem('(0.00 + ' + fSqlCampoReformaRef('FDOREF', 'REF_VALIBS', 'FD.AUTOINCREM') + ')', '((0.00 + ' + fSqlCampoReformaRef('FDOREF', 'REF_VALIBS', 'FD.AUTOINCREM') + ') / FDO_QTDITE)', 'VALIBS');
      strSQL := strSQL + fSum + fRetCampoValorItem('(0.00 + ' + fSqlCampoReformaRef('FDOREF', 'REF_SELVAL', 'FD.AUTOINCREM') + ')', '((0.00 + ' + fSqlCampoReformaRef('FDOREF', 'REF_SELVAL', 'FD.AUTOINCREM') + ') / FDO_QTDITE)', 'VAL_IS');
      strSQL := strSQL + fSum + fRetCampoValorItem('FDO_TOTFRE', '(FDO_TOTFRE / FDO_QTDITE)', 'VALFRE');
      strSQL := strSQL + fSum + fRetCampoValorItem('FDO_DESESP', '(FDO_DESESP / FDO_QTDITE)', 'DESESI');
      strSQL := strSQL + fSum + fRetCampoValorItem('FDO_BASIPI', '(FDO_BASIPI / FDO_QTDITE)', 'IBASIP');
      strSQL := strSQL + fSum + fRetCampoValorItem('FDO_BASRET', '(FDO_BASRET / FDO_QTDITE)', 'IBASRE');
      strSQL := strSQL + fSum + fRetCampoValorItem('FDO_BASICM', '(FDO_BASICM / FDO_QTDITE)', 'IBASIC');
      strSQL := strSQL + fSum + fRetCampoValorItem('FDO_VALICM', '(FDO_VALICM / FDO_QTDITE)', 'IVALIC');
      strSQL := strSQL + fSum + fRetCampoValorItem('FDO_DESACE', '(FDO_DESACE / FDO_QTDITE)', 'DESACE');
      strSQL := strSQL + fSum + fRetCampoValorItem('FDO_VLRCON', '(FDO_VLRCON / FDO_QTDITE)', 'VLRCON');
      strSQL := strSQL + fSum + fRetCampoValorItem('FDO_VLRCON', '(FDO_VLRCON / FDO_QTDITE)', 'CONVLR');
      strSQL := strSQL + fSum + fRetCampoValorItem('FDO_VLRCON / FDO_QTDITE', '(FDO_VLRCON / FDO_QTDITE)', 'ITECON', True);
    End;

    strSQL := strSQL + ' FDO_ALQIPI AS IALQIP, ';
    strSQL := strSQL + ' FDO_ALQRET AS IALQRE, ';
    strSQL := strSQL + ' FDO_ALQICM AS IALQIC, ';
    strSQL := strSQL + ' FDO_QTDROM AS QTBAIP, ';
  End;

  strSQL := strSQL + '   ' + fSqlCampoSetor + ' AS SETOR_, ';
  strSQL := strSQL + '  C.CLI_CODCID, ';
  strSQL := strSQL + '  (SELECT CADCID.CID_ESTADO ';
  strSQL := strSQL + '   FROM CADCID ';
  strSQL := strSQL + '   WHERE CADCID.CID_CODCID = C.CLI_CODCID) AS CID_ESTADO, ';

  strSQL := strSQL + '  IF( IFNULL(E.TRI_NCMTIN,"") = "", I.ITE_CLAIPI, E.TRI_NCMTIN) AS CODNCM, ';
  strSQL := strSQL + '  CAST("" AS CHAR(100)) AS LEGEND, ';
  strSQL := strSQL + '  0.00                  AS ITETOT, ';

  strSQL := strSQL + '  FDO_INSALT AS INSALT, ';

  strSQL := strSQL + fSQLBarDoc('FDO') + ' AS BARDOC, ';
  strSQL := strSQL + ' CONCAT(IFNULL(FDO_NUMCMP,"")," ", IFNULL(FDO_NITCMP,"")) AS NUMCMI, ';

  strSQL := strSQL + '      ( SELECT CONCAT( IF( IFNULL(I.ITE_CODFAB,"") <> "", CONCAT(I.ITE_CODFAB, ","), ""), GROUP_CONCAT(IFNULL(IFNULL(ITEFOR.ITE_CODFAB, ITE_CODITF),""))) ';
  strSQL := strSQL + '        FROM ITEFOR    ';
  strSQL := strSQL + '        WHERE ITEFOR.ITE_CODITE = I.ITE_CODITE ) AS CDFABS, ';

  strSQL := strSQL + '      (                                        ';
  strSQL := strSQL + '      SELECT GROUP_CONCAT(IFNULL(ITEBAR.BAR_CODBAR,""))   ';
  strSQL := strSQL + '      FROM ITEBAR                              ';
  strSQL := strSQL + '      WHERE ITEBAR.BAR_CODITE = I.ITE_CODITE   ';
  strSQL := strSQL + '      ) AS CDBARS,                             ';

  If recDocume.blnDocSep Then
  Begin
    strSQL := strSQL + ' ITE_CNV_ML,      ';
    strSQL := strSQL + ' ITE_SAL_ML,      ';
    strSQL := strSQL + ' 0.000 AS SALDIS, ';
  End;

  strSQL := strSQL + '  IFNULL(ICD_VALORI, 0) AS VDPORI, '; //VALOR DIFAL ORIGEM PD/OR
  strSQL := strSQL + '  IFNULL(ICD_VALDES, 0) AS VDPDES, '; //VALOR DIFAL DESTIN PD/OR
//  strSQL := strSQL + '  IFNULL(IF(LOCATE("9999", FDO_DTENTR) > 0, NULL, DATE_FORMAT(FDO_DTENTR,"%d/%m/%Y")), "") AS DTENTI, '; // DATA DE ENTREGA DO PEDIDO

  strSQL := strSQL + '  FDO_DTENTR AS DTENTI, '; // DATA DE ENTREGA DO PEDIDO

  strSQL := strSQL + '  FD.AUTOINCREM AS AUTDET, ';

  strSQL := strSQL + '  E.FDO_EMPFOR AS EMPFOR, '; //Empresa que irá abastecer o item

  strSQLMec := fRetornarMecanicos(strTabDet,
                                  recDocume.strNumDoc,
                                  recDocume.strEspDoc,
                                  recDocume.strCodCli,
                                  recDocume.strCodEmp);

  If (Not fEmptyStr(strSQLMec)) Then
    strSQL := strSQL + ' NM.CODMEC AS MECPED, '
  Else
    strSQL := strSQL + ' CAST("" AS CHAR(20)) AS MECPED, ';

  strSQL := strSQL + ' CAST("" AS CHAR(20)) AS MECSER, ';

  strSQL := strSQL + ' (SELECT GROUP_CONCAT( CONCAT(O.OPE_NOMOPE,": ",MEC.FDO_OBSMEC), " ") ';
  strSQL := strSQL + ' FROM MECDOR MEC ';
  strSQL := strSQL + '  INNER JOIN CADOPE O ON O.OPE_CODOPE = MEC.FDO_CODMEC ';
  strSQL := strSQL + '  WHERE MEC.FDO_SEQFDO = FD.AUTOINCREM ';
  strSQL := strSQL + ' GROUP BY MEC.FDO_SEQFDO ';
  strSQL := strSQL + ' ORDER BY O.OPE_CODOPE ) AS OBMEPD, ';

  strSQL := strSQL + ' CAST("" AS CHAR(20)) AS OBMESR, ';

  strSQL := strSQL + ' "0" AS QTDEXP, ';
  strSQL := strSQL + ' E.FDO_TURENT AS TURENT,  ';
  strSQL := strSQL + ' CASE WHEN IFNULL(BRI_SEQDET, "N") = "N" THEN "NÃO" ELSE "SIM" END AS BRINDE, ';
  strSQL := strSQL + ' CASE WHEN IFNULL(FDO_PEGOU_, "N") = "N" THEN "NÃO" ELSE "SIM" END AS PEGOU_, ';
  strSQL := strSQL + ' CASE WHEN IFNULL(ITE_PREDOL, "N") = "N" THEN "NÃO" ELSE "SIM" END AS PREDOL, ';

  strSQL := strSQL + ' CL.LOT_NUMLOT AS CODAMZ, ';
  strSQL := strSQL + ' IFNULL(CADAMZ.AMZ_DESCRI, "") AS DESAMZ, ';
  strSQL := strSQL + ' CL.LOT_LOCFIS AS LCFSAZ, ';
  strSQL := strSQL + ' DATE_FORMAT(IFNULL(CL.LOT_DTAFAB, ""), "%d/%m/%Y") AS DTAFAB, ';
  strSQL := strSQL + ' DATE_FORMAT(IFNULL(CL.LOT_DTAVAL, ""), "%d/%m/%Y") AS DTAVAL, ';
  strSQL := strSQL + ' CL.LOT_CAPACI AS CAPACI, ';
  strSQL := strSQL + ' CL.LOT_PONREP AS PONREP, ';
  strSQL := strSQL + ' LC.LOT_NUMLOT AS CDAMZC, ';
  strSQL := strSQL + ' LV.LOT_NUMLOT AS CDAMZV, ';

  {Preço da tabela de preço}
  strSQL := strSQL + ' CASE FD.FDO_TABPRE ';
  strSQL := strSQL + '   WHEN "1" THEN G.ITE_PREVE1 ';
  strSQL := strSQL + '   WHEN "2" THEN G.ITE_PREVE2 ';
  strSQL := strSQL + '   WHEN "3" THEN G.ITE_PREVE3 ';
  strSQL := strSQL + '   WHEN "4" THEN G.ITE_PREVE4 ';
  strSQL := strSQL + '   WHEN "5" THEN G.ITE_PREVE5 ';
  strSQL := strSQL + '   WHEN "6" THEN G.ITE_PREVE6 ';
  strSQL := strSQL + '   WHEN "7" THEN G.ITE_PREVE7 ';
  strSQL := strSQL + ' END AS PRETAB,               ';

  strSQL := strSQL + '( '+fSQLQtdIte(recDocume)+' * (CASE FD.FDO_TABPRE ';
  strSQL := strSQL + '                     WHEN "1" THEN G.ITE_PREVE1 ';
  strSQL := strSQL + '                     WHEN "2" THEN G.ITE_PREVE2 ';
  strSQL := strSQL + '                     WHEN "3" THEN G.ITE_PREVE3 ';
  strSQL := strSQL + '                     WHEN "4" THEN G.ITE_PREVE4 ';
  strSQL := strSQL + '                     WHEN "5" THEN G.ITE_PREVE5 ';
  strSQL := strSQL + '                     WHEN "6" THEN G.ITE_PREVE6 ';
  strSQL := strSQL + '                     WHEN "7" THEN G.ITE_PREVE7 END)) AS VALTAB, ';

  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
  begin
    strSQL := strSQL + ' IF(IFNULL(FDO_NUMLOT, "") = "", LS2.LSE_CODIGO, LS1.LSE_CODIGO) AS LSECOD, ';
    strSQL := strSQL + ' IF(IFNULL(FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) AS LSEDES, ';
  end
  else
  begin
    strSQL := strSQL + ' LSE_CODIGO AS LSECOD,';
    strSQL := strSQL + ' LSE_DESCRI AS LSEDES,';
  end;

   If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '     I.ITE_CODABF AS CODABF, '
  Else
    strSQL := strSQL + '     G.ITE_CODABF AS CODABF, ';

  strSQL := strSQL + ' FDO_ORDPRO AS NUMOPD,';
  strSQL := strSQL + ' (SELECT GROUP_CONCAT(ORD_NUMORD ORDER BY ORD_NUMORD ASC SEPARATOR ",") ';
  strSQL := strSQL + '  FROM ORDSER WHERE ORD_NUMDOC = FDO_NUMDOC AND ORD_CODITE = FDO_CODITE) AS NUMOSD,';

  strSQL := strSQL + ' FDO_DTAFUT AS DTAFUT, ';

  {Localizações Adicionais}
  If fCfgSis('CADLOC', varBoolean) Then
  Begin
    strSQL := strSQL + ' (SELECT                                 ';
    strSQL := strSQL + '    GROUP_CONCAT(CADLOC.LOC_DESCRI)      ';
    strSQL := strSQL + '  FROM                                   ';
    strSQL := strSQL + '    LOCFIS                               ';
    strSQL := strSQL + '    INNER JOIN CADLOC ON (CADLOC.LOC_CODLOC = LOCFIS.LOC_LOCFIS AND ';
    strSQL := strSQL + '                          CADLOC.LOC_CODEMP = LOCFIS.LOC_CODEMP)    ';
    strSQL := strSQL + '  WHERE                                  ';
    strSQL := strSQL + '    LOCFIS.LOC_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '    LOCFIS.LOC_CODEMP = EG.FGO_EMPEXP AND ';
    strSQL := strSQL + '    CADLOC.LOC_ATIVO_ <> "N") AS LOCADI  ';
  End
  Else
  Begin
    strSQL := strSQL + ' (SELECT                                 ';
    strSQL := strSQL + '    GROUP_CONCAT(LOC_LOCFIS)             ';
    strSQL := strSQL + '  FROM                                   ';
    strSQL := strSQL + '    LOCFIS                               ';
    strSQL := strSQL + '  WHERE                                  ';
    strSQL := strSQL + '    LOC_CODITE = G.ITE_CODITE AND        ';
    strSQL := strSQL + '    LOC_CODEMP = EG.FGO_EMPEXP) AS LOCADI ';
  End;

  strSQL := strSQL + ' ,((FDO_TOTPES/FDO_QTDITE)*'+fSQLQtdIte(recDocume)+') AS ITPEBR ';
  strSQL := strSQL + ' ,((FDO_PESLIQ/FDO_QTDITE)*'+fSQLQtdIte(recDocume)+') AS ITPELQ ';

  strSQL := strSQL + ' ,(IFNULL(FDO_CUBAGE, 0)) AS ECMCUB ';

  strSQL := strSQL + ' ,IF(FDO_PROACA="S" AND FDO_IDEPRO="NOR","PRODUTO ACABADO", IF(FDO_PROACA="N" AND FDO_IDEPRO<>"NOR", "TINTA DE MÁQUINA", "PRODUTO NORMAL")) AS TPPROD ';

  If (fUtilizaImagemOtimizada) Then
    strSQL := strSQL + ' ,(SELECT FROM_BASE64(IFNULL(ITE_SPOB64, ITE_IMGB64)) FROM ITEIMG WHERE ITEIMG.ITE_CODITE = I.ITE_CODITE AND ITEIMG.ITE_PRINCI = "S" ORDER BY ITEIMG.AUTOINCREM DESC LIMIT 1) AS PROIMG '
  Else
    strSQL := strSQL + ' ,(SELECT FROM_BASE64(IFNULL(ITE_THUB64, ITE_IMGB64)) FROM ITEIMG WHERE ITEIMG.ITE_CODITE = I.ITE_CODITE AND ITEIMG.ITE_PRINCI = "S" ORDER BY ITEIMG.AUTOINCREM DESC LIMIT 1) AS PROIMG ';

  strSQL := strSQL + ' ,IF(FDO_UNIDIG > FDO_UNIORI, (FDO_UNIDIG * FDO_QTDITE), (FDO_UNIORI * FDO_QTDITE))  AS MAIVAL ';

  strSQL := strSQL + ' ,(SELECT MIN(ITEEMB.ITB_QTDEMB) FROM ITEEMB WHERE ITEEMB.ITB_CODEMP = G.ITE_CODEMP AND ITEEMB.ITB_CODITE = G.ITE_CODITE) AS QTEMB2 ';


  strSQL := strSQL + ' ,CAST((SELECT GROUP_CONCAT(DISTINCT FDO_ENTRET SEPARATOR "") ';
  strSQL := strSQL + '          FROM EXTDOR ';
  strSQL := strSQL + '          JOIN FATDOR ON FDO_SEQFDO = AUTOINCREM ';
  strSQL := strSQL + '         WHERE FDO_CODEMP = :CODEMP ';
  strSQL := strSQL + '           AND FDO_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '           AND FDO_NUMDOC = :NUMDOC) AS CHAR(02)) AS INFOER ';

  for intTab := 1 to 7 do
    strSQL := strSQL + ' ,G.ITE_PREVE'+IntToStr(intTab)+' AS TBPRE'+IntToStr(intTab);

  strSQL := strSQL + ' ,IFNULL(E.FDO_FRERAT, 0) AS FRERAT ';

  strSQL := strSQL + ' ,' + fSQLSaldoDisponivel('G', True) + ' AS SLDDIS ';
  
  strSQL := strSQL + ' , IFNULL((SELECT SUM(' + fSQLSaldoDisponivel('G2', True) + ') FROM ITEGER G2 WHERE G2.ITE_CODEMP = IFNULL(IF(FD.FDO_IDEPRO = "NOR", FD.FDO_EMPITE, FD.FDO_EMPPRD), G.ITE_CODEMP) AND G2.ITE_CODITE = G.ITE_CODITE), 0) AS SDIABA ';

  strSQL := strSQL + ' , (SELECT FGO_MENEX4 FROM FATGOR WHERE AUTOINCREM = FD.FDO_SEQGER) AS CBMEX4 ';

  strSQL := strSQL + ' ,G.ITE_DTAULT AS DTAULT ';
  strSQL := strSQL + ' ,I.ITE_MSGLV1 AS MSGLV1 ';
  strSQL := strSQL + ' ,I.ITE_MSGLV2 AS MSGLV2 ';

  strSQL := strSQL + ' ,CAST("" AS CHAR(80)) AS MNAT01 ';
  strSQL := strSQL + ' ,CAST("" AS CHAR(80)) AS MNAT02 ';
  strSQL := strSQL + ' ,CAST("" AS CHAR(80)) AS MNAT03 ';

  strSQL := strSQL + ' ,' + fSQLSaldoDisponivel('G', True, False, True,
                                                fCfgSis('ENTFUT', varBoolean),
                                                fCfgSis('ORDPRO', varBoolean)) + ' AS NSLDIS ';

  strSQL := strSQL + ' ,I.ITE_EXPSIT AS EXPSIT ';

  strSQL := strSQL + ' ,COALESCE(FC.FDO_MEDB_L, CL.LOT_MEDB_L) AS MEDB_L ';
  strSQL := strSQL + ' ,COALESCE(FC.FDO_MEDB_A, CL.LOT_MEDB_A) AS MEDB_A ';
  strSQL := strSQL + ' ,COALESCE(FC.FDO_MEDL_L, CL.LOT_MEDL_L) AS MEDL_L ';
  strSQL := strSQL + ' ,COALESCE(FC.FDO_MEDL_A, CL.LOT_MEDL_A) AS MEDL_A ';
  strSQL := strSQL + ' ,COALESCE(FC.FDO_ESPESS, CL.LOT_ESPESS) AS ESPESS ';

  strSQL := strSQL + ' , E.FDO_SEQINV AS SEQINV ';

  if (fCfgSis('MARMOR') = 'S') then
  begin
    if (fCfgSis('CTRLCH') = '2') then
    begin
      strSQL := strSQL + ' ,IF( CL.LOT_MEDL_L <> 0 AND CL.LOT_MEDL_A <> 0, FDO_QTDITE / CL.LOT_MEDL_L / CL.LOT_MEDL_A, 0 ) AS QTDCHP ';
    end
    else
    begin
      strSQL := strSQL + ' ,FDO_QTDITE AS QTDCHP ';
    end;
  end
  else
  begin
    strSQL := strSQL + ' ,0.00 AS QTDCHP ';
  end;

  strSQL := strSQL + ' ,(IF(FD.FDO_IDEPRO="NOR", ""            ' ;
  strSQL := strSQL + ' ,(SELECT                                ' ;
  strSQL := strSQL + '    T1.FDO_TIPFOR                        ' ;
  strSQL := strSQL + '  FROM                                   ' ;
  strSQL := strSQL + '    FATDOR M3                            ' ;
  strSQL := strSQL + '    INNER JOIN TINDOR T1                 ' ;
  strSQL := strSQL + '      ON  M3.FDO_NUMDOC = T1.FDO_NUMDOC  ' ;
  strSQL := strSQL + '      AND M3.FDO_ESPDOC = T1.FDO_ESPDOC  ' ;
  strSQL := strSQL + '      AND M3.FDO_CODEMP = T1.FDO_CODEMP  ' ;
  strSQL := strSQL + '      AND M3.FDO_EMPACA = T1.FDO_EMPACA  ' ;
  strSQL := strSQL + '      AND M3.FDO_CODACA = T1.FDO_CODACA  ' ;
  strSQL := strSQL + '      AND M3.FDO_PROEMB = "N"            ' ;
  strSQL := strSQL + '  WHERE M3.FDO_NUMDOC = FD.FDO_NUMDOC    ' ;
  strSQL := strSQL + '    AND M3.FDO_CODEMP = FD.FDO_CODEMP    ' ;
  strSQL := strSQL + '    AND M3.FDO_ESPDOC = FD.FDO_ESPDOC    ' ;
  strSQL := strSQL + '    AND M3.FDO_CODCLI = FD.FDO_CODCLI    ' ;
  strSQL := strSQL + '    AND M3.FDO_ITETIN = FD.FDO_ITETIN    ' ;
  strSQL := strSQL + '    AND M3.FDO_CODACA = FD.FDO_CODACA    ' ;
  strSQL := strSQL + '    AND M3.FDO_EMPACA = FD.FDO_EMPACA    ' ;
  strSQL := strSQL + '    AND M3.FDO_PROEMB = "N" LIMIT 1))) AS TIPFOR ' ;

  strSQL := strSQL + ' ,E.FDO_NUMCMP AS NUMPDC ' ;
  strSQL := strSQL + ' ,E.FDO_NITCMP AS NITCMP ' ;
  strSQL := strSQL + ' ,E.FDO_NUMPLA AS NUMPLA ' ;
  strSQL := strSQL + ' ,E.FDO_PARNUM AS PARNUM ' ;
  strSQL := strSQL + ' ,E.FDO_REQCOM AS REQCOM ' ;
  strSQL := strSQL + ' ,(SELECT FGO_BARCOM FROM EXTGOR WHERE FGO_SEQFGO = FD.FDO_SEQGER) AS BARCOM ';
  strSQL := strSQL + ' ,I.ITE_VALOBR AS VALOBR   ';
  strSQL := strSQL + ' ,I.ITE_VALIDA AS VALIDA   ';
  strSQL := strSQL + ' ,FDO_TOTCU2 AS TOTCU2   ';

  strSQL := strSQL + ' ,FDO_PROACA AS PROACA   ';

  strSQL := strSQL + ' ,E.FDO_HRBXSE AS HRBXSE ';
  strSQL := strSQL + ' ,E.FDO_DTBXSE AS DTBXSE ';
  strSQL := strSQL + ' ,E.FDO_ITEEST AS ITPEST ';
  strSQL := strSQL + ', IF ( COALESCE(E.FDO_QTDSBI, 0) > 0, FDO_QTDITE / E.FDO_QTDSBI, 0) AS ESTQTD  ';
  strSQL := strSQL + ' ,E.FDO_IMPFED AS IMPFED ';
  strSQL := strSQL + ' ,CURRENT_DATE AS DTIMSE ';
  strSQL := strSQL + ' ,CURRENT_TIME AS HRIMSE ';
  strSQL := strSQL + ' , IF( COALESCE(I.ITE_CODPAG, 0) <> 0, I.ITE_CODPAG, (SELECT GER.GMT_CODITE '+
                                                                            ' FROM GERMAT GER '+
                                                                            ' INNER JOIN DETMAT DET ON DET.DMT_SEQGER = GER.AUTOINCREM '+
                                                                            ' WHERE DET.DMT_ITESUB = I.ITE_CODITE LIMIT 1) ) AS ITESGR ';

  strSQL := strSQL + '  , CAST("" AS CHAR(10)) AS EMBITE ';
  strSQL := strSQL + '  , E.FDO_ORDITE AS ORDITE ';

  strSQL := strSQL + '  , (  SELECT ';
  strSQL := strSQL + '         GT.ITE_LOCFIS ';
  strSQL := strSQL + '       FROM ';
  strSQL := strSQL + '       ITEGER GT ';
  strSQL := strSQL + '       WHERE GT.ITE_CODITE = FD.FDO_CODITE ';
  strSQL := strSQL + '         AND GT.ITE_CODEMP = IF(FG.FGO_ENT_CD = "S", EG.FGO_EMP_CD, IF(IFNULL(FD.FDO_EMPITE, "") = "", FD.FDO_CODEMP, FD.FDO_EMPITE ) ) ) AS LOCTRA ';

  strSQL := strSQL + ' ,CAST("" AS CHAR(3000)) AS ESTRUT ';

  strSQL := strSQL + ' ,IF(COALESCE(IF(TRIM(UN.UNI_KILLIT) = "", "L", UN.UNI_KILLIT), "L") = "L",FD.FDO_QTDITE * (IFNULL(UN.UNI_PESLIT, 0)/ ' + IIF(fCfgSis('LITGAL', varString) = 'L', '1', '3.600') + ' ),0) AS LITITE ';

  strSQL := strSQL + ' ,I.ITE_DESFAB AS DSFABR ';

  strSQL := strSQL + ' ,I.ITE_CEREPI AS CEREPI ';

  strSQL := strSQL + ' ,I.ITE_FATPM3 AS FATPM3 ';

  strSQL := strSQL + ' ,I.ITE_DTAEPI AS DTAEPI ';

  strSQL := strSQL + ' ,CAST("" AS CHAR(3000)) AS ESTVID ';

  strSQL := strSQL + ' ,I.ITE_CODDEP AS CODDEP ';

  strSQL := strSQL + ' ,(SELECT CONCAT(SER_CODITE, " - ", ';
  strSQL := strSQL + '              GROUP_CONCAT(SER_NUMSER SEPARATOR ", ")) AS SER_NUMSER ';
  strSQL := strSQL + '  FROM PROSER ';
  strSQL := strSQL + '  WHERE SER_CODITE = FD.FDO_CODITE  ';
  strSQL := strSQL + '   AND SER_CODEMP  = FD.FDO_CODEMP) AS NUMSER  ';

  strSQL := strSQL + ' ,MT.DET_LOCFIS AS LOCFEF ';

  strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS SITUAC ';
  strSQL := strSQL + ' ,FDO_QTDITE AS QTDORI ';

  strSQL := strSQL + ' ,( SELECT ';
  strSQL := strSQL + '      ITE_DESITE ';
  strSQL := strSQL + '    FROM ';
  strSQL := strSQL + '      CADITE ';
  strSQL := strSQL + '    WHERE ITE_CODITE = IF( ';
  strSQL := strSQL + '        COALESCE(I.ITE_CODPAG, 0) <> 0, ';
  strSQL := strSQL + '        I.ITE_CODPAG, ';
  strSQL := strSQL + '        (SELECT ';
  strSQL := strSQL + '          GER.GMT_CODITE ';
  strSQL := strSQL + '        FROM ';
  strSQL := strSQL + '          GERMAT GER ';
  strSQL := strSQL + '          INNER JOIN DETMAT DET ';
  strSQL := strSQL + '            ON DET.DMT_SEQGER = GER.AUTOINCREM ';
  strSQL := strSQL + '        WHERE DET.DMT_ITESUB = I.ITE_CODITE ';
  strSQL := strSQL + '        LIMIT 1) ';
  strSQL := strSQL + '      ) ) AS ITEMAT ';

  strSQL := strSQL + ' ,IFNULL(FD.FDO_EMPPRD, FD.FDO_CODEMP) AS EMPPRD ';

  strSQL := strSQL + ' , FD.FDO_VLRCON AS VLRCTB ';

  strSQL := strSQL + ' FROM ';

  strSQL := strSQL + strTabDet + ' FD ';

  If (fUsaRotinaWMS And recDocume.blnDocSep) Or (fRetEhReimpressaoDeDocumentoCanceladoWMS(recDocume)) Or (fRetEhImpressaoDeDocumentoBaixadoWMS(recDocume)) Then
  begin
    strSQL := strSQL + '  LEFT JOIN LOTDOR L ON L.LDO_SEQFDO = FD.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN DEL_LOTDOR LD ON LD.LDO_SEQFDO = FD.AUTOINCREM ' + IfThen(recDocume.blnDocSep, ' AND FALSE ', '');
  end;

  strSQL := strSQL + ' INNER JOIN CADMAR    ON FDO_CODMAR   =    MAR_CODMAR ';
  strSQL := strSQL + ' INNER JOIN CADITE I  ON FDO_CODITE   =  I.ITE_CODITE ';
  strSQL := strSQL + ' LEFT  JOIN CADUNI UC ON I.ITE_UNICOM = UC.UNI_CODUNI ';
  strSQL := strSQL + ' LEFT JOIN DESSIT S ON S.ITE_CODITE   = I.ITE_CODITE ';

  If fCfgSis('CLIPRO', varBoolean) then
  begin
    strSQL := strSQL + ' LEFT JOIN CLIPRO ON FDO_CODITE = CLIPRO.CLI_CODITE AND ';
    strSQL := strSQL + '                     FDO_CODCLI = CLIPRO.CLI_CODCLI ';
    strSQL := strSQL + ' INNER JOIN CADUNI UN ON COALESCE(CLI_CODUNI, FDO_UNIDAD)   = UN.UNI_CODUNI ';
  end
  else
    strSQL := strSQL + ' INNER JOIN CADUNI UN ON FDO_UNIDAD   = UN.UNI_CODUNI ';

  If (Not fEmptyStr(strSQLMec)) Then
    strSQL := strSQL + ' LEFT JOIN ( ' + strSQLMec + ' ) AS NM ON FD.AUTOINCREM = NM.SEQFDO';

  strSQL := strSQL + ' LEFT JOIN CADGRU ON GRU_CODGRU = I.ITE_CODGRU ';

  strSQL := strSQL + ' LEFT JOIN CADDIV DI ON DI.DIV_CODDIV = FDO_CODDIV ';
  strSQL := strSQL + ' LEFT JOIN CADOPE OP ON OP.OPE_CODOPE = FDO_CODREP ';
  strSQL := strSQL + ' LEFT JOIN CADOPE V1 ON V1.OPE_CODOPE = FDO_CODVEN ';
  strSQL := strSQL + ' LEFT JOIN CADOPE V2 ON V2.OPE_CODOPE = FDO_CODVE2 ';

  strSQL := strSQL + ' LEFT JOIN ITEGER G ON ';
  strSQL := strSQL + '   G.ITE_CODITE = I.ITE_CODITE AND ';

  If fCfgSis('SPLCIT', varBoolean) And (recDocume.blnDocSep) And (Not recDocume.blnLocFisEmpEmi) Then
    strSQL := strSQL + '   G.ITE_CODEMP = FDO_CODEMP       '
  Else
  begin
    If (recDocume.blnDocSep) And (Not fEmptyStr(Trim(recDocume.strSetor))) Then
      strSQL := strSQL + '   G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp)
    Else
      strSQL := strSQL + '   G.ITE_CODEMP = FDO_CODEMP       ';
  End;

//  If blnUtilizaVendaMadeira Then
    strSQL := strSQL + ' LEFT JOIN ORCMAD M ON M.FDO_SEQGER = FD.AUTOINCREM  ';

  strSQL := strSQL + ' LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = FD.AUTOINCREM  ';

  strSQL := strSQL + ' LEFT JOIN CADCLI C ON C.CLI_CODCLI = FD.FDO_CODCLI  ';

  If (fUsaRotinaWMS And recDocume.blnDocSep) Or (fRetEhReimpressaoDeDocumentoCanceladoWMS(recDocume)) Or (fRetEhImpressaoDeDocumentoBaixadoWMS(recDocume)) Then
    strSQL := strSQL + ' LEFT JOIN CADLOT CL ON IFNULL(IFNULL(LD.LDO_NUMLOT, L.LDO_NUMLOT), FDO_NUMLOT) = CL.LOT_NUMLOT AND '
  Else
    strSQL := strSQL + ' LEFT JOIN CADLOT CL ON FDO_NUMLOT = CL.LOT_NUMLOT AND ';

  strSQL := strSQL + '                     FDO_CODITE = CL.LOT_CODITE AND ';
  strSQL := strSQL + '                     IF(IFNULL(FDO_EMPITE, "") = "", FDO_CODEMP, FDO_EMPITE) = CL.LOT_CODEMP ';

  strSQL := strSQL + ' LEFT JOIN CADDEP ON DEP_CODIGO = I.ITE_CODDEP ';

  strSQL := strSQL + ' LEFT JOIN CADLOC L1 ON L1.LOC_CODLOC = CL.LOT_LOCFIS AND L1.LOC_CODEMP = CL.LOT_CODEMP  ';
  strSQL := strSQL + ' LEFT JOIN CADLOC L2 ON L2.LOC_CODLOC = G.ITE_LOCFIS      AND L2.LOC_CODEMP = G.ITE_CODEMP ';

  strSQL := strSQL + ' LEFT JOIN CADLOT LC ON LC.AUTOINCREM = (SELECT C.AUTOINCREM FROM CADLOT C WHERE ';
  strSQL := strSQL + '                                           FDO_CODITE = LOT_CODITE AND ';
  strSQL := strSQL + '                                           IF(IFNULL(FDO_EMPITE, "") = "", FDO_CODEMP, FDO_EMPITE) = LOT_CODEMP ';
  strSQL := strSQL + '                                          AND LOT_ARMPRC  = "S" LIMIT 1) ';

  strSQL := strSQL + ' LEFT JOIN CADLOT LV ON LV.AUTOINCREM = (SELECT C.AUTOINCREM FROM CADLOT C WHERE ';
  strSQL := strSQL + '                                           FDO_CODITE = LOT_CODITE AND ';
  strSQL := strSQL + '                                           IF(IFNULL(FDO_EMPITE, "") = "", FDO_CODEMP, FDO_EMPITE) = LOT_CODEMP ';
  strSQL := strSQL + '                                          AND LOT_ARMPRI  = "S" LIMIT 1) ';

  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
  begin
    strSQL := strSQL + ' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = L1.LOC_CODLSE ';
    strSQL := strSQL + ' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = L2.LOC_CODLSE ';
  end
  else
  If (recDocume.blnDocSep) And (Not fEmptyStr(Trim(recDocume.strWhereSep))) Then
  Begin  
    strSQL := strSQL + ' LEFT JOIN CADLSE LS ' +
                       '     ON LS.LSE_CODIGO = (SELECT IG_SP.ITE_CODLSE FROM ITEGER IG_SP '+
                       '                          WHERE IG_SP.ITE_CODITE = I.ITE_CODITE    '+
                       '                            AND IG_SP.ITE_CODEMP = IF(IFNULL(FDO_EMPITE, "") = "", FDO_CODEMP, FDO_EMPITE)) ';
  End  
  Else
  Begin
    strSQL := strSQL + ' LEFT JOIN CADLSE LS ON LS.LSE_CODIGO = G.ITE_CODLSE  ';
  End;  

  strSQL := strSQL + ' LEFT JOIN DORICD ID ON ID.ICD_SEQFDO = FD.AUTOINCREM ';
  strSQL := strSQL + ' LEFT JOIN BRIDOR BD ON BD.BRI_SEQDET = FD.AUTOINCREM ';

  strSQL := strSQL + ' LEFT JOIN CADONU ON I.ITE_CODONU = CADONU.ONU_CODONU ';

  strSQL := strSQL + ' LEFT JOIN CADAMZ ON (CADAMZ.AMZ_CODAMZ = FD.FDO_NUMLOT AND CADAMZ.AMZ_CODEMP = FD.FDO_CODEMP) ';

  strSQL := strSQL + ' LEFT JOIN EXTGOR EG ON EG.FGO_SEQFGO = FD.FDO_SEQGER  ';

  strSQL := strSQL + ' LEFT JOIN FDOCHA FC ON FC.FDO_SEQFDO = FD.AUTOINCREM  ';
  strSQL := strSQL + ' LEFT JOIN FATGOR FG ON FG.AUTOINCREM = FD.FDO_SEQGER  ';
  strSQL := strSQL + ' LEFT JOIN MOVTRI MT ON MT.DET_SEQGER = E.FDO_INCFUT   ';

  If recDocume.blnDocSep And recDocume.blnImpExpedicao And (recDocume.intSeqSepPar > 0) Then
    strSQL := strSQL + ' LEFT JOIN SEPPAR SP ON SP.SEP_SEQFDO = FD.AUTOINCREM AND SP.SEP_SEQSEP = '+ IntToStr(recDocume.intSeqSepPar) +' ';

  strSQL := strSQL + ' WHERE ';

  With recDocume Do
  If (Not blnQtdOri) And (Not VS_ImprimeSepFaturados) And (not recDocume.blnFatAut) Then
  Begin
    If recDocume.blnDocSep And recDocume.blnImpExpedicao And (recDocume.intSeqSepPar > 0) Then
      strSQL := strSQL + ' SEP_QTDSEP > 0 AND '
    Else If blnDocSep And fPermiteImprimirSeparacaoParcial Then
      strSQL := strSQL + ' (ROUND(FDO_QTDSEP,'+IntToStr(StrToIntDef(fCfgSis('DECUNI', varInteger),2))+') - ROUND(' + fGetSQLQtdBaixada(recDocume) + ','+IntToStr(StrToIntDef(fCfgSis('DECUNI', varInteger),2))+')) > 0 AND '
    Else If (blnOpcFat) Then
    Begin
      strSQL := strSQL + ' (ROUND(FDO_QTDBAI, ' + IntToStr(StrToIntDef(fCfgSis('DECUNI', varInteger),2)) + ')) > 0 AND '+
                         ' FDO_NUMFAT IS NOT NULL AND ';
    End
    Else
      strSQL := strSQL + ' (ROUND(FDO_QTDITE,'+IntToStr(StrToIntDef(fCfgSis('DECUNI', varInteger),2))+') - ROUND(' + fGetSQLQtdBaixada(recDocume) + ','+IntToStr(StrToIntDef(fCfgSis('DECUNI', varInteger),2))+')) > 0 AND ';
  End;

  strSQL := strSQL + '   FDO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '   FDO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   FDO_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   FDO_CODCLI = :CODCLI AND ';

  {
  PEGPED = Perguntar se pegou o produto na tela de pedidos?
  IMPPEG = Quando informar na tela da venda, que "já pegou" o produto, imprimi-lo na separação do Pedido de Venda?
  }
  if (recDocume.blnDocSep) and (recDocume.strEspDoc = 'PD') and (fCfgSis('PEGPED', varBoolean)) then
  begin
    if not fCfgSis('IMPPEG', varBoolean) then
    begin
      strSQL := strSQL + '   E.FDO_PEGOU_ = "N" AND ';
    end;
  end;

  {
  USABRI = Permitir informar produtos Brinde nos Pedidos de Venda?
  IMPBRI = Quando realizar venda de Brindes juntamente com Produtos Normais, imprimi-los na separação do Pedido de Venda?
  }
  if (recDocume.blnDocSep) and (recDocume.strEspDoc = 'PD') and (fCfgSis('USABRI', varBoolean)) then
  begin
    if not fCfgSis('IMPBRI', varBoolean) then
    begin
      strSQL := strSQL + '   (BRI_SEQDET IS NULL) AND ';
    end;
  end;

  If (recDocume.blnDocSep) And (recDocume.strEspDoc = 'PD') And fUsaRotinaExpedicaoConferenciaRetiraCaixa Then
  Begin
    strSQL := strSQL + '   FDO_EXIBSE = "S" AND ';
  End;

  strSQL := strSQL + '   IFNULL(FDO_PROEMB, "N") <> "S"    AND ';
  strSQL := strSQL + '   FDO_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' AND ';
  strSQL := strSQL + '   FDO_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + ' ';

  If recDocume.blnDocSep And fUsaSepAvulsaTintaAutomotivaWMS Then
  Begin
    If recDocume.blnTinAut Then
      strSQL := strSQL + '  AND LOCATE(FDO_IDEPRO, "'+ fGetTintasdeMaquina.fGetAutomotivas +'") > 0 '
    Else
      strSQL := strSQL + '  AND LOCATE(FDO_IDEPRO, "'+ fGetTintasdeMaquina.fGetAutomotivas +'") = 0 ';
  End;

  With recDocume Do
  Begin
    If (strEspDoc = 'PD') And blnDocSep And Not blnImpExpedicao Then
    Begin
      strEntRet := fCfgSis('TPSPPV',varString);

      If (Pos(strSepPedEntregaOuRetira, 'R_E_') > 0) Then
      Begin
       strSQL := strSQL + ' AND IFNULL(FDO_ENTRET, "") = ' + QuotedStr(strSepPedEntregaOuRetira) + ' ';
       If (strSepPedEntregaOuRetira = 'E') And (Copy(strEntRet,3,1) = 'N') Then
         strSQL := strSQL + ' AND FDO_ENTFUT = "N" ';
      End
      Else
      Begin
        strSQLEntRet := '';

        {**********}
        {* RETIRA *}
        {**********}
        If (Copy(strEntRet,1,1) = 'R') Then
          strSQLEntRet := strSQLEntRet + ' (FDO_ENTRET = "R") OR ';

        {*****************}
        {* ENT. IMEDIATA *}
        {*****************}
        If (Copy(strEntRet,2,1) = 'E') Then
          strSQLEntRet := strSQLEntRet + ' (FDO_ENTRET = "E" AND FDO_ENTFUT = "N") OR ';

        {***************}
        {* ENT. FUTURA *}
        {***************}
        If (Copy(strEntRet,3,1) = 'F') Then
          strSQLEntRet := strSQLEntRet + ' (FDO_ENTFUT = "S") OR ';

        {* Remove o último OR *}
        strSQLEntRet := Copy(strSQLEntRet, 1, Length(strSQLEntRet)-3);

        If Not fEmptyStr(strSQLEntRet) Then
          strSQL := strSQL + ' AND (' + strSQLEntRet + ') ';
      End;

      if fCfgSis('EPDEXR', VarBoolean) and (recDocume.blnDocSep) then
        strSQL := strSQL + ' AND FDO_EMPITE = FDO_CODEMP ';

    End;
  End;

  With recDocume Do
  If blnDocSep Then
  Begin
    Case opcAbastecimento Of
      opcSolicitado:
        Begin
          If blnSomenteEmpDifSep Then
            strSQL := strSQL + ' AND IFNULL(NULLIF(FDO_EMPFOR, IFNULL(FDO_EMPITE, FDO_CODEMP)), "") <> "" '
          Else
            strSQL := strSQL + ' AND IFNULL(FDO_EMPFOR, "") <> "" ';
        End;
      opcNaoSolicitado:
        Begin
          If blnSomenteEmpDifSep Then
            strSQL := strSQL + ' AND IFNULL(NULLIF(FDO_EMPFOR, IFNULL(FDO_EMPITE, FDO_CODEMP)), "") = "" '
          Else
            strSQL := strSQL + ' AND IFNULL(FDO_EMPFOR, "") = "" ';
        End;
    End;

    If Not fEmptyStr(strWhereSep) Then
      strSQL := strSQL + IIF(LeftStr(Trim(strWhereSep), 3) = 'AND', '', ' AND ') + strWhereSep;
  End;

  strSQL := strSQL + fGetSqlGroupByPedOrc;

  With recDocume Do
  If blnDocSep And (Not fEmptyStr(Trim(strSetor))) Then
    strSQL := strSQL + ' HAVING SETOR_ = ' + QuotedStr(strSetor);

  strSQL := strSQL + ' ORDER BY ';

  If Not fEmptyStr(recDocume.strOrdem) Then
  Begin

    If recDocume.blnDocSep Then
    Begin

      {** CFG_ORDSEP **}
      Case recDocume.strOrdem[1] Of
        '1': strSQL := strSQL + '   FD.FDO_DESCRI ';
        '2': strSQL := strSQL + '   LOCFIS, FD.FDO_DESCRI ';
        '3': strSQL := strSQL + '   ORDITE, FD.AUTOINCREM ';
        '4': strSQL := strSQL + '   DEP_DESCRI, FD.FDO_DESCRI ';
        '5': strSQL := strSQL + '   IF(IFNULL(FDO_ENTRET, "R") = "R",0, IF(IFNULL(FDO_ENTFUT, "N") = "N", 1, 2)), FDO_DESCRI ';
        Else strSQL := strSQL + '   IFNULL(IF(IFNULL(CL.LOT_NUMLOT, "") = "", ITE_LOCFIS, CL.LOT_LOCFIS), ""),  FD.FDO_DESCRI ';
      End;

    End
    Else
    Begin

      {** CFG_ORDPDV **}
      Case recDocume.strOrdem[1] Of
        '1': strSQL := strSQL + '   FD.FDO_DESCRI ';
        '2': strSQL := strSQL + '   UN.UNI_SIGUNI, FD.FDO_DESCRI ';
        '3': strSQL := strSQL + '   ORDITE, FD.AUTOINCREM ';
        '4': strSQL := strSQL + '   IFNULL(IF(IFNULL(CL.LOT_NUMLOT, "") = "", ITE_LOCFIS, CL.LOT_LOCFIS), ""),  FD.FDO_DESCRI ';
        '5': strSQL := strSQL + '   DEP_DESCRI, FD.FDO_DESCRI ';
        '6': strSQL := strSQL + '   IF(IFNULL(FDO_ENTRET, "R") = "R",0, IF(IFNULL(FDO_ENTFUT, "N") = "N", 1, 2)), FDO_DESCRI ';
        Else strSQL := strSQL + '   IFNULL(IF(IFNULL(CL.LOT_NUMLOT, "") = "", ITE_LOCFIS, CL.LOT_LOCFIS), ""),  FD.FDO_DESCRI ';
      End;

    End;

  End
  Else
    strSQL := strSQL + '   FD.AUTOINCREM ';

  Result := strSQL;

End;

class function TLeDocumentoPDOR.fSQLQtdIte(const recDocume: TRecDocumento): String;
begin

  If (fUsaRotinaWMS And recDocume.blnDocSep) Or (fRetEhReimpressaoDeDocumentoCanceladoWMS(recDocume)) Or (fRetEhImpressaoDeDocumentoBaixadoWMS(recDocume)) Then
  begin
    if (recDocume.blnAgruparItensSeparacao) then
      Result := ' SUM(IFNULL(IFNULL(LD.LDO_QTDITE, L.LDO_QTDITE), FDO_QTDITE)) '
    else
      Result := ' IFNULL(IFNULL(LD.LDO_QTDITE, L.LDO_QTDITE), FDO_QTDITE) ';
  end
  Else
    Result := fGetSqlQtdItePedOrc(recDocume);

end;

Procedure TLeDocumentoPDOR.pSetaNomeTabela;
Begin
  strTabGer := 'FATGOR';
  strTabDet := 'FATDOR';

  With recDocume Do
  If blnDocCan Then
  Begin
    strTabGer := 'DEL_' + strTabGer;
    strTabDet := 'DEL_' + strTabDet;
  End;
End;

Function TLeDocumentoPDOR.fInsereClientFatDor: Boolean;
  Var
    intTab: integer;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLItems);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet  := cdsDados;
    frxDados.Name     := 'frxMovdet';
    frxDados.UserName := 'frxMovdet';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;

    pCriaSoma('', 'TOTQTD', 'SUM(QTDITE)');
    pCriaSoma('', 'TOTGER', 'SUM(ITETOT)');

    pCriaSoma('', 'TOTUNI', 'SUM(QTDITE * VALUNI)');
    pCriaSoma('', 'TOTORI', 'SUM(QTDITE * UNIORI)');
    pCriaSoma('', 'TOTDIG', 'SUM(QTDITE * UNIDIG)');

    pCriaSoma('', 'TDPORI', 'SUM(VDPORI)');
    pCriaSoma('', 'TDPDES', 'SUM(VDPDES)');
    pCriaSoma('', 'TOTITE', 'SUM(VALITE)');

    pCriaSoma('', 'TOTDES', 'SUM(DESCON)');

    pCriaSoma('', 'ITPEBR', 'SUM(ITPEBR)');
    pCriaSoma('', 'ITPELQ', 'SUM(ITPELQ)');

    pCriaSoma('', 'TOTTAB', 'SUM(QTDITE * PRETAB)');

    pCriaSoma('', 'TOTLIT', 'SUM(LITITE)');

    PCriaSoma('', 'ECMCBG', 'SUM( ( ( ( EXPALT * EXPLAR * EXPPRO ) / 100 ) * QTDITE ) )');

    {*********************************************}
    { SE FOR 'PENDENTES' OS TOTAIS SAO DIFERENTES }
    { NOME DOS AGGREGATES TEM QUE SER DIFERENTE   }
    {*******************************************LE}
    If Not blnQtdOri Then
    Begin
      pCriaSoma('', 'PENDESESP', 'SUM(DESESI)');
      pCriaSoma('', 'PENRET',    'SUM(VALRET)');
      pCriaSoma('', 'PENFRE',    'SUM(VALFRE)');
      pCriaSoma('', 'PENIPI',    'SUM(VALIPI)');
      pCriaSoma('', 'PENCBS',    'SUM(VALCBS)');
      pCriaSoma('', 'PENIBS',    'SUM(VALIBS)');
      pCriaSoma('', 'PEN_IS',    'SUM(VAL_IS)');
      pCriaSoma('', 'PENBASIPI', 'SUM(IBASIP)');
      pCriaSoma('', 'PENBASRET', 'SUM(IBASRE)');
      pCriaSoma('', 'PENBASICM', 'SUM(IBASIC)');
      pCriaSoma('', 'PENICM',    'SUM(IVALIC)');
      pCriaSoma('', 'PENDESACE', 'SUM(DESACE)');
      pCriaSoma('', 'PENVLRCON', 'SUM(VLRCON)');
    End;

    pCriaSoma('', 'TOTMAI', 'SUM(MAIVAL)');
    pCriaSoma('', 'TOTRAT', 'SUM(FRERAT)');

    for intTab := 1 to 7 do
      pCriaSoma('', 'TOTTB'+IntToStr(intTab), 'SUM(QTDITE * TBPRE'+IntToStr(intTab)+')');

    pCriaSoma('', 'TOTCHP', 'SUM(QTDCHP)');

    pCriaSoma('', 'TOCUS2', 'SUM(TOTCU2)');
    pCriaSoma('', 'TOTMT3', 'SUM(QTDITE * FATPM3)');

    If (fUtilizaImagemOtimizada) Then
      pOtimizaImagensProduto(strNumDoc, strEspDoc, strCodEmp, strCodCli);

    pOtimizaImagensProduto(strNumDoc, strEspDoc, strCodEmp, strCodCli);

    Result := fAbreClient(True, 'fInsereClientFatDor');
  End;

End;

Function TLeDocumentoPDOR.fInsereClientFatGor: Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLFatGor);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet  := cdsDados;
    frxDados.Name     := 'frxMovGer';
    frxDados.UserName := 'frxMovGer';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;

    If Not fEmptyStr(fCfgSis('ORCVEN', varString, strCodEmp)) Then
      ParamByName('ORCVEN').AsString := fCfgSis('ORCVEN', varString, strCodEmp)
    Else
      ParamByName('ORCVEN').AsString := '0';

    Result := fAbreClient(True, 'fInsereClientFatGor');
  End;
End;

Function TLeDocumentoPDOR.fMarcaPedidoComoImpresso: Boolean;
Begin
  Result := True;
  With recDocume Do
  If (strEspDoc = 'PD') Or blnDocSep Then
  Begin
    Result := fMarcarPedidoComoImpresso(strNumDoc, strEspDoc, strCodEmp, blnDocSep, blnImpExpedicao);
  End;
End;  

procedure TLeDocumentoPDOR.pCarregaItensLogSeparacaoImpressao(cdsLogSep       : TUniClientDataSet;
                                                              cdsImpLogSep    : TZClient;
                                                              blnEnt_CD,
                                                              blnLocFisEmpEmi : Boolean;
                                                              blnTemServico   : Boolean = False);
  Var
    cdsLogSepTmp: TUniClientDataSet;
    fltQtdDigItem: Double;

  procedure pDefineLocalizacaoFisica;
    Var
      strCodIte: String;
      strNumLot: String;
      strEmpIte: String;
  begin
    With cdsLogSepTmp Do
    Begin
      First;

      While Not Eof Do
      Begin
        Edit;

        strCodIte := FieldByName('ITE_CODITE').AsString;
        strNumLot := FieldByName('ITE_NUMLOT').AsString;
        strEmpIte := FieldByName('ITE_EMPITE').AsString;

        If blnEnt_CD Then
        Begin
          FieldByName('ITE_LOCFIS').AsString :=
            fCampoTabela(fRetLocFisicaEmpCD(QuotedStr(strNumLot), 'CADITE.ITE_CODITE',
              QuotedStr(strEmpIte), False, False, fCfgSis('SPPLFI', varBoolean)), 'CADITE', ['ITE_CODITE'], [strCodIte]);

          FieldByName('ITE_DESFIS').AsString :=
            fCampoTabela(fRetDesFisicaEmpCD(QuotedStr(strNumLot), 'CADITE.ITE_CODITE',
              QuotedStr(strEmpIte), False, False, fCfgSis('SPPLFI', varBoolean)), 'CADITE', ['ITE_CODITE'], [strCodIte]);

        End
        Else If blnLocFisEmpEmi Then
        Begin
          FieldByName('ITE_LOCFIS').AsString :=
            fCampoTabela(fRetLocFisicaEmpEmissora(QuotedStr(strNumLot), 'CADITE.ITE_CODITE',
              QuotedStr(strEmpIte), False, False, fCfgSis('SPPLFI', varBoolean)), 'CADITE', ['ITE_CODITE'], [strCodIte]);

          FieldByName('ITE_DESFIS').AsString :=
            fCampoTabela(fRetDesFisicaEmpEmissora(QuotedStr(strNumLot), 'CADITE.ITE_CODITE',
              QuotedStr(strEmpIte), False, False, fCfgSis('SPPLFI', varBoolean)), 'CADITE', ['ITE_CODITE'], [strCodIte]);

        End
        Else If ((fEmptyStr(strNumLot)) Or (fCfgSis('SPPLFI', varBoolean))) Then
        Begin
          FieldByName('ITE_LOCFIS').AsString :=
            fCampoTabela('ITE_LOCFIS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, strEmpIte]);

          FieldByName('ITE_DESFIS').AsString :=
            fCampoTabela('ITE_LOCFIS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, strEmpIte]);
        End
        Else
        Begin
          FieldByName('ITE_LOCFIS').AsString :=
            fCampoTabela('LOT_LOCFIS', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'], [strCodIte, strEmpIte, strNumLot]);

          FieldByName('ITE_DESFIS').AsString :=
            fCampoTabela('LOT_LOCFIS', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'], [strCodIte, strEmpIte, strNumLot]);
        End;

        Post;
        Next;
      End;
    End;
  end;

  procedure pInsereItensSeparacao;
    Var
      strCodIte: String;
      strNumLot: String;
      strEmpIte: String;
      strCodLoc: String;
      strCodLse: String;
      fltMltVen: Double;
  begin
    With cdsLogSepTmp Do
    Begin
      First;

      While Not Eof Do
      Begin
        If Not cdsImpLogSep.Locate('SEQIND', FieldByName('AUTOINCREM').AsString, []) Then
        Begin
          cdsImpLogSep.Append;

          strCodIte := FieldByName('ITE_CODITE').AsString;
          strNumLot := FieldByName('ITE_NUMLOT').AsString;
          strEmpIte := FieldByName('ITE_EMPITE').AsString;
          fltMltVen := fRetMltVenItem(strCodIte);

          cdsImpLogSep.FieldByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
          cdsImpLogSep.FieldByName('TABPVE').AsString := FieldByName('ITE_TABPRE').AsString;
          cdsImpLogSep.FieldByName('PROMOC').AsString := FieldByName('ITE_PROMOC').AsString;
          cdsImpLogSep.FieldByName('EMPITE').AsString := FieldByName('ITE_EMPITE').AsString;
          cdsImpLogSep.FieldByName('NUMLOT').AsString := FieldByName('ITE_NUMLOT').AsString;
          cdsImpLogSep.FieldByName('CODACA').AsString := FieldByName('ITE_CODACA').AsString;
          cdsImpLogSep.FieldByName('EMPACA').AsString := FieldByName('ITE_EMPACA').AsString;
          cdsImpLogSep.FieldByName('CODFAB').AsString := FieldByName('ITE_CODFAB').AsString;
          cdsImpLogSep.FieldByName('CODBAR').AsString := FieldByName('ITE_CODBAR').AsString;
          cdsImpLogSep.FieldByName('CLAIPI').AsString := FieldByName('ITE_CLAIPI').AsString;

          cdsImpLogSep.FieldByName('DESITE').AsString := FieldByName('ITE_DESITE').AsString;
          cdsImpLogSep.FieldByName('DESSIM').AsString := FieldByName('ITE_DESSIM').AsString;
          cdsImpLogSep.FieldByName('DESCAD').AsString := FieldByName('ITE_DESITE').AsString;
          cdsImpLogSep.FieldByName('EXPALT').AsString := fCampoTabela('ITE_EXPALT', 'DESSIT', ['ITE_CODITE'], [FieldByName('ITE_CODITE').AsString]);
          cdsImpLogSep.FieldByName('EXPLAR').AsString := fCampoTabela('ITE_EXPLAR', 'DESSIT', ['ITE_CODITE'], [FieldByName('ITE_CODITE').AsString]);
          cdsImpLogSep.FieldByName('EXPPRO').AsString := fCampoTabela('ITE_EXPPRO', 'DESSIT', ['ITE_CODITE'], [FieldByName('ITE_CODITE').AsString]);
          cdsImpLogSep.FieldByName('DESFAB').AsString := FieldByName('ITE_DESITE').AsString + ' - ' + fRetiraZerosEsquerda(FieldByName('ITE_CODFAB').AsString);
          cdsImpLogSep.FieldByName('DESIT1').AsString := FieldByName('ITE_DESITE').AsString;
          cdsImpLogSep.FieldByName('DESIT2').AsString := FieldByName('ITE_DESITE').AsString;
          cdsImpLogSep.FieldByName('DESIT3').AsString := FieldByName('ITE_DESITE').AsString;
          cdsImpLogSep.FieldByName('DESIT4').AsString := FieldByName('ITE_DESITE').AsString;

          cdsImpLogSep.FieldByName('REFERE').AsString := FieldByName('ITE_REFERE').AsString;
          cdsImpLogSep.FieldByName('QTDITE').AsFloat  := FieldByName('ITE_QTDITE').AsFloat;

          If fltMltVen > 0 Then
            cdsImpLogSep.FieldByName('QTDEMB').AsFloat := FieldByName('ITE_QTDITE').AsFloat / fltMltVen
          Else
            cdsImpLogSep.FieldByName('QTDEMB').AsFloat := 0.00;

          cdsImpLogSep.FieldByName('SIGUNI').AsString := FieldByName('ITE_SIGUNI').AsString;
          cdsImpLogSep.FieldByName('DESUNI').AsString := FieldByName('ITE_DESUNI').AsString;
          cdsImpLogSep.FieldByName('VALUNI').AsFloat  := FieldByName('ITE_UNITAR').AsFloat;
          cdsImpLogSep.FieldByName('UNIORI').AsFloat  := FieldByName('ITE_UNIORI').AsFloat;
          cdsImpLogSep.FieldByName('VALITE').AsFloat  := FieldByName('ITE_TOTITE').AsFloat;

          cdsImpLogSep.FieldByName('EMPITE').AsString   := FieldByName('ITE_EMPITE').AsString;
          cdsImpLogSep.FieldByName('CODDIV').AsString   := '';

          cdsImpLogSep.FieldByName('EMBALA').AsFloat  := FieldByName('ITE_EMBALA').AsFloat;
          cdsImpLogSep.FieldByName('SALDOS').AsFloat  := FieldByName('ITE_SALDOS').AsFloat;
          cdsImpLogSep.FieldByName('MLTVEN').AsFloat  := fltMltVen;
          cdsImpLogSep.FieldByName('DESMAR').AsString := fRetNomeMarca(FieldByName('ITE_CODMAR').AsString);
          cdsImpLogSep.FieldByName('CODFIS').AsString := '';
          cdsImpLogSep.FieldByName('VALIPI').AsFloat  := FieldByName('ITE_VALIPI').AsFloat;
          cdsImpLogSep.FieldByName('VALRET').AsFloat  := FieldByName('ITE_VALRET').AsFloat;

          cdsImpLogSep.FieldByName('LOCFIS').AsString := FieldByName('ITE_LOCFIS').AsString;
          cdsImpLogSep.FieldByName('DESFIS').AsString := FieldByName('ITE_DESFIS').AsString;
          cdsImpLogSep.FieldByName('LOCSUP').AsString := fCampoTabela('ITE_LOCSUP', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, strEmpIte]);

          cdsImpLogSep.FieldByName('ENTRET').AsString := FieldByName('ITE_ENTRET').AsString;
          cdsImpLogSep.FieldByName('LOCRET').AsString := FieldByName('ITE_LOCRET').AsString;
          cdsImpLogSep.FieldByName('ENTFUT').AsString := FieldByName('ITE_ENTFUT').AsString;
          cdsImpLogSep.FieldByName('MOTFUT').AsString := FieldByName('ITE_MOTFUT').AsString;

          cdsImpLogSep.FieldByName('DESCON').AsFloat  := IfThen(FieldByName('ITE_DESCON').AsFloat < 0, 0, FieldByName('ITE_DESCON').AsFloat);
          cdsImpLogSep.FieldByName('VALFRE').AsFloat := FieldByName('ITE_TOTFRE').AsFloat;
          cdsImpLogSep.FieldByName('DESESI').AsFloat := FieldByName('ITE_DESESP').AsFloat;
          cdsImpLogSep.FieldByName('UNIDIG').AsFloat := IfThen(FieldByName('ITE_DESCON').AsFloat < 0, FieldByName('ITE_UNITAR').AsFloat, FieldByName('ITE_UNIDIG').AsFloat);
          cdsImpLogSep.FieldByName('VALDIG').AsFloat := cdsImpLogSep.FieldByName('UNIDIG').AsFloat * cdsImpLogSep.FieldByName('QTDITE').AsFloat;

          if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
          begin
            if fEmptyStr(strNumLot) then
              strCodLoc := fCampoTabela('ITE_LOCFIS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, strEmpIte])
            else
              strCodLoc := fCampoTabela('LOT_LOCFIS', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'], [strCodIte, strEmpIte, strNumLot]);

            strCodLse := fCampoTabela('LOC_CODLSE', 'CADLOC', ['LOC_CODLOC', 'LOC_CODEMP'], [strCodLoc, strEmpIte]);
            cdsImpLogSep.FieldByName('SETOR_').AsString := fCampoTabela('LSE_DESCRI', 'CADLSE', ['LSE_CODIGO'], [strCodLse]);
          end
          else
          If (fCfgSis('GRUSEP', VarString) = 'S') then
          Begin
            strCodLse := fCampoTabela('ITE_CODLSE', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, strEmpIte]);
            cdsImpLogSep.FieldByName('SETOR_').AsString := fCampoTabela('LSE_DESCRI', 'CADLSE', ['LSE_CODIGO'], [strCodLse]);
          End
          Else
            cdsImpLogSep.FieldByName('SETOR_').AsString := LeftStr(cdsImpLogSep.FieldByName('LOCFIS').AsString, 1);

          cdsImpLogSep.FieldByName('COMPLE').AsString := FieldByName('ITE_COMPLE').AsString;

          If fCfgSis('VENMAD', varBoolean) Or fCfgSis('VENVID', varBoolean) Or fCfgSis('VENMTL', varBoolean) Then
          Begin
            cdsImpLogSep.FieldByName('QTDPEC').AsFloat  := FieldByName('ITE_QTDPEC').AsFloat;
            cdsImpLogSep.FieldByName('COMPEC').AsFloat  := FieldByName('ITE_COMPEC').AsFloat;
            cdsImpLogSep.FieldByName('LARPEC').AsFloat  := FieldByName('ITE_LARPEC').AsFloat;
            cdsImpLogSep.FieldByName('ESPPEC').AsFloat  := FieldByName('ITE_ESPPEC').AsFloat;
            cdsImpLogSep.FieldByName('APAREL').AsString := FieldByName('ITE_APAREL').AsString;
            cdsImpLogSep.FieldByName('BENEFI').AsString := FieldByName('ITE_BENEFI').AsString;
          End;

          if not fEmptyStr(strNumLot) then
            cdsImpLogSep.FieldByName('LCFSAZ').AsString := fCampoTabela('LOT_LOCFIS', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'], [strCodIte, strEmpIte, strNumLot])
          else
            cdsImpLogSep.FieldByName('LCFSAZ').AsString := '';

          cdsImpLogSep.FieldByName('SITUAC').AsString := FieldByName('ITE_STALOG').AsString;
          cdsImpLogSep.FieldByName('APLICA').AsString := FieldByName('ITE_APLICA').AsString;

          cdsImpLogSep.Post;
        End;

        cdsLogSepTmp.Next;
      End;
    End;
  end;

begin
  cdsImpLogSep.EmptyDataSet;
  cdsLogSepTmp := TUniClientDataSet.Create(nil);
  pCloneDataSet(cdsLogSepTmp, cdsLogSep);

  pDefineLocalizacaoFisica;//Define a localizacao fisica neste ponto pois precisa ordenar pela mesma

  With cdsLogSepTmp Do
  Begin
    First;

    While Not Eof Do
    Begin
      Edit;

      fltQtdDigItem := FieldByName('ITE_QTDITE').AsFloat;

      If FieldByName('ITE_STALOG').AsString = 'A' Then
      Begin
        If FieldByName('ITE_QTDITE').AsFloat > FieldByName('ITE_QTDANT').AsFloat Then
        Begin
          FieldByName('ITE_STALOG').AsString := 'I';
          FieldByName('ITE_QTDITE').AsFloat  := FieldByName('ITE_QTDITE').AsFloat - FieldByName('ITE_QTDANT').AsFloat;
        end
        Else
        If FieldByName('ITE_QTDITE').AsFloat < FieldByName('ITE_QTDANT').AsFloat Then
        Begin
          FieldByName('ITE_STALOG').AsString := 'E';
          FieldByName('ITE_QTDITE').AsFloat  := FieldByName('ITE_QTDANT').AsFloat - FieldByName('ITE_QTDITE').AsFloat;
        end;
      End
      Else If FieldByName('ITE_STALOG').AsString = 'E' Then
      Begin
        FieldByName('ITE_QTDITE').AsFloat := FieldByName('ITE_QTDANT').AsFloat;
      End;

      FieldByName('ITE_TOTITE').AsFloat := FieldByName('ITE_TOTITE').AsFloat / fltQtdDigItem * FieldByName('ITE_QTDITE').AsFloat;
      FieldByName('ITE_DESESP').AsFloat := FieldByName('ITE_DESESP').AsFloat / fltQtdDigItem * FieldByName('ITE_QTDITE').AsFloat;
      FieldByName('ITE_VALIPI').AsFloat := FieldByName('ITE_VALIPI').AsFloat / fltQtdDigItem * FieldByName('ITE_QTDITE').AsFloat;
      FieldByName('ITE_VALRET').AsFloat := FieldByName('ITE_VALRET').AsFloat / fltQtdDigItem * FieldByName('ITE_QTDITE').AsFloat;
      FieldByName('ITE_TOTFRE').AsFloat := FieldByName('ITE_TOTFRE').AsFloat / fltQtdDigItem * FieldByName('ITE_QTDITE').AsFloat;                        

      Post;
      Next;
    End;

    IndexFieldNames := 'ITE_LOCFIS;AUTOINCREM';//Deve imprimir a separação ordenada por localização fisica

    Filtered := False;
    Filter   := 'ITE_STALOG = ' + QuotedStr('I');
    Filtered := True;

    If Not IsEmpty Then
    Begin

      If (blnTemServico) Or (Not fEmptyStr(recDocume.strMensNovo)) Or (Not fCfgSis('IMPQSV', varBoolean)) Or (fCfgSis('RETDEV', varBoolean)) Then
      Begin
        cdsImpLogSep.Append;
        cdsImpLogSep.FieldByName('DESITE').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensNovo), INF_RETIRAR_ALMOXARIFADO, recDocume.strMensNovo) + ' ******';
        cdsImpLogSep.FieldByName('DESSIM').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensNovo), INF_RETIRAR_ALMOXARIFADO, recDocume.strMensNovo) + ' ******';
        cdsImpLogSep.FieldByName('DESCAD').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensNovo), INF_RETIRAR_ALMOXARIFADO, recDocume.strMensNovo) + ' ******';
        cdsImpLogSep.FieldByName('DESIT1').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensNovo), INF_RETIRAR_ALMOXARIFADO, recDocume.strMensNovo) + ' ******';
        cdsImpLogSep.FieldByName('DESIT2').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensNovo), INF_RETIRAR_ALMOXARIFADO, recDocume.strMensNovo) + ' ******';
        cdsImpLogSep.FieldByName('DESIT3').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensNovo), INF_RETIRAR_ALMOXARIFADO, recDocume.strMensNovo) + ' ******';
        cdsImpLogSep.FieldByName('DESIT4').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensNovo), INF_RETIRAR_ALMOXARIFADO, recDocume.strMensNovo) + ' ******';
        cdsImpLogSep.FieldByName('DESFAB').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensNovo), INF_RETIRAR_ALMOXARIFADO, recDocume.strMensNovo) + ' ******';
        cdsImpLogSep.Post;
      End;

      pInsereItensSeparacao;

    End;

    Filtered := False;
    Filter   := 'ITE_STALOG = ' + QuotedStr('E');
    Filtered := True;

    If Not IsEmpty Then
    Begin

      If (blnTemServico) Or (Not fEmptyStr(recDocume.strMensExcluido)) Or (Not fCfgSis('IMPQSV', varBoolean)) Or (fCfgSis('RETDEV', varBoolean)) Then
      Begin
        cdsImpLogSep.Append;
        cdsImpLogSep.FieldByName('DESITE').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensExcluido), INF_DEVOLVER_ALMOXARIFADO, recDocume.strMensExcluido) + ' ******';
        cdsImpLogSep.FieldByName('DESSIM').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensExcluido), INF_DEVOLVER_ALMOXARIFADO, recDocume.strMensExcluido) + ' ******';
        cdsImpLogSep.FieldByName('DESCAD').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensExcluido), INF_DEVOLVER_ALMOXARIFADO, recDocume.strMensExcluido) + ' ******';
        cdsImpLogSep.FieldByName('DESIT1').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensExcluido), INF_DEVOLVER_ALMOXARIFADO, recDocume.strMensExcluido) + ' ******';
        cdsImpLogSep.FieldByName('DESIT2').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensExcluido), INF_DEVOLVER_ALMOXARIFADO, recDocume.strMensExcluido) + ' ******';
        cdsImpLogSep.FieldByName('DESIT3').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensExcluido), INF_DEVOLVER_ALMOXARIFADO, recDocume.strMensExcluido) + ' ******';
        cdsImpLogSep.FieldByName('DESIT4').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensExcluido), INF_DEVOLVER_ALMOXARIFADO, recDocume.strMensExcluido) + ' ******';
        cdsImpLogSep.FieldByName('DESFAB').AsString  := '****** ' + IIF(fEmptyStr(recDocume.strMensExcluido), INF_DEVOLVER_ALMOXARIFADO, recDocume.strMensExcluido) + ' ******';
        cdsImpLogSep.Post;
      End;

      pInsereItensSeparacao;

    End;

    Filtered := False;
    Filter   := '';
  End;

  FreeAndNil(cdsLogSepTmp);
end;

procedure TLeDocumentoPDOR.pCarregarNCM;
begin
  cdsFatDor.First;

  While Not cdsFatDor.Eof Do
  Begin
    cdsFatDor.Edit;
    cdsFatDor.FieldByName('CODNCM').AsString := fRetornaNCM(cdsFatDor.FieldByName('CODNCM').AsString,
                                                            cdsFatDor.FieldByName('CID_ESTADO').AsString,
                                                            cdsFatDor.FieldByName('CLI_CODCID').AsString,
                                                            cdsFatDor.FieldByName('CODITE').AsString,
                                                            cdsFatDor.FieldByName('CODEMP').AsString);
    cdsFatDor.Post;

    cdsFatDor.Next;
  End;
end;

Procedure TLeDocumentoPDOR.pSetaNumeroItens(intNroItens: Integer);
Begin
  With cdsFatGor, recDocume Do
  Begin
    Edit;
    FieldByname('NROITE').AsInteger := intNroItens;

    FieldByName('TOTQTD').AsFloat  := cdsFatDor.fRetSoma('TOTQTD');
    FieldByName('TOTGER').AsFloat  := cdsFatDor.fRetSoma('TOTGER');
    FieldByName('TOTUNI').AsFloat  := cdsFatDor.fRetSoma('TOTUNI');
    FieldByName('TOTORI').AsFloat  := cdsFatDor.fRetSoma('TOTORI');
    FieldByName('TOTDIG').AsFloat  := cdsFatDor.fRetSoma('TOTDIG');
    FieldByName('TOTTAB').AsFloat  := cdsFatDor.fRetSoma('TOTTAB');
    FieldByName('TOTLIT').AsFloat  := cdsFatDor.fRetSoma('TOTLIT');

    cdsFatDor.Filtered            := False;
    cdsFatDor.Filter              := 'PROMOC = ' + QuotedStr('S');
    cdsFatDor.Filtered            := True;
    FieldByName('TOTCPR').AsFloat := cdsFatDor.fRetSoma('TOTITE');

    cdsFatDor.Filtered            := False;
    cdsFatDor.Filter              := 'PROMOC <> ' + QuotedStr('S');
    cdsFatDor.Filtered            := True;
    FieldByName('TOTSPR').AsFloat := cdsFatDor.fRetSoma('TOTITE');

    cdsFatDor.Filter   := '';
    cdsFatDor.Filtered := False;

    FieldByName('TOPEBR').AsFloat  := cdsFatDor.fRetSoma('ITPEBR');
    FieldByName('TOPELQ').AsFloat  := cdsFatDor.fRetSoma('ITPELQ');
    FieldByName('TOTMAI').AsFloat  := cdsFatDor.fRetSoma('TOTMAI');

    If Not recDocume.blnQtdOri Then
    Begin
      FieldByName('TOTPRO').AsFloat  := cdsFatDor.fRetSoma('TOTITE');
      FieldByName('DESESP').AsFloat  := cdsFatDor.fRetSoma('PENDESESP');
      FieldByName('TOTRET').AsFloat  := cdsFatDor.fRetSoma('PENRET');
      FieldByName('TOTFRE').AsFloat  := cdsFatDor.fRetSoma('PENFRE');
      FieldByName('TOTIPI').AsFloat  := cdsFatDor.fRetSoma('PENIPI');
      FieldByName('TOTCBS').AsFloat  := cdsFatDor.fRetSoma('PENCBS');
      FieldByName('TOTIBS').AsFloat  := cdsFatDor.fRetSoma('PENIBS');
      FieldByName('TOT_IS').AsFloat  := cdsFatDor.fRetSoma('PEN_IS');
      FieldByName('BASIPI').AsFloat  := cdsFatDor.fRetSoma('PENBASIPI');
      FieldByName('BASRET').AsFloat  := cdsFatDor.fRetSoma('PENBASRET');
      FieldByName('BASICM').AsFloat  := cdsFatDor.fRetSoma('PENBASICM');
      FieldByName('TOTICM').AsFloat  := cdsFatDor.fRetSoma('PENICM');
      FieldByName('DESACE').AsFloat  := cdsFatDor.fRetSoma('PENDESACE');

      If fServicosDoPedidoJaForamFaturados(strNumDoc, strEspDoc, strCodEmp) Then
        FieldByName('TOTSER').AsFloat := 0.00;

      FieldByName('VLRCON').AsFloat  := cdsFatDor.fRetSoma('PENVLRCON') + FieldByName('TOTSER').AsFloat;
    End;

    FPais := fSetaPais;

    FieldByName('LEGIPI').AsString := FLegIPI;
    FieldByName('SETORG').AsString := FSetores.CommaText.Replace('"', '');
    FieldByName('CGCTRA').AsString := fFormataCpfCgc(FieldByName('CGCTRA').AsString, FPais);

    FieldByName('TOTCHP').AsFloat := cdsFatDor.fRetSoma('TOTCHP');
    FieldByName('TOTCU2').AsFloat := cdsFatDor.fRetSoma('TOCUS2');

    FieldByName('MARBRU').AsFloat := fFormataFloat(fCalculaPrecoVenda(2,
                                                                      FieldByName('TOTCUS').AsFloat,
                                                                      FieldByName('TOTPRO').AsFloat - FieldByName('DESESP').AsFloat ,
                                                                      0, 0, 0, 0, 0, fMarMpkParaVenda(fCfgSis('MARMKP')),
                                                                      fCfgSis('PCMPRO'), fCfgSis('DECUNI'), 0, False, 0, 0, 0, False), 2);

    FieldByName('MARLIQ').AsFloat := fFormataFloat(fCalculaPrecoVenda(2,
                                                                      FieldByName('TOTCU2').AsFloat,
                                                                      FieldByName('TOTPRO').AsFloat,
                                                                      0, 0, 0, 0, 0, fMarMpkParaVenda(fCfgSis('MARMKP')),
                                                                      fCfgSis('PCMPRO'), fCfgSis('DECUNI'), 0, False, 0, 0, 0, False), 2);
    FieldByName('TOTMT3').AsFloat  := cdsFatDor.fRetSoma('TOTMT3');
    Post;
  End;
End;

procedure TLeDocumentoPDOR.pSetaParametrosCadcli;
begin
  inherited;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('CIDCON').AsString := cdsFatGor.FieldByName('FGO_CIDCON').AsString;
    ParamByName('ENDCON').AsString := cdsFatGor.FieldByName('FGO_ENDCON').AsString;
    ParamByName('BAICON').AsString := cdsFatGor.FieldByName('FGO_BAICON').AsString;
    ParamByName('CEPCON').AsString := cdsFatGor.FieldByName('FGO_CEPCON').AsString;
    ParamByName('TELCON').AsString := cdsFatGor.FieldByName('FGO_TELCON').AsString;
    ParamByName('R_GCON').AsString := cdsFatGor.FieldByName('FGO_R_GCON').AsString;
    ParamByName('CGCCPF').AsString := cdsFatGor.FieldByName('FGO_CGCCPF').AsString;
    ParamByName('CGCCON').AsString := cdsFatGor.FieldByName('FGO_CGCCON').AsString;
    ParamByName('IESCON').AsString := cdsFatGor.FieldByName('FGO_IESCON').AsString;
    ParamByName('NOMCON').AsString := cdsFatGor.FieldByName('FGO_NOMCON').AsString;
    ParamByName('CODFAZ').AsString := cdsFatGor.FieldByName('FGO_CODFAZ').AsString;
  End;
end;

procedure TLeDocumentoPDOR.pSetaParametrosFr3Adicioanais(FReport: TfrxReport);
begin
  with recDocume do
  begin
    If (Pos(strEspDoc, 'PD_') > 0) And fTemParametro(FReport, 'MSGPED') Then
      FReport.Script.Variables['MSGPED'] := fCfgSis('MSGPED');
    If (Pos(strEspDoc, 'OR_') > 0) And fTemParametro(FReport, 'MSGORC') Then
      FReport.Script.Variables['MSGORC'] := fCfgSis('MSGORC');
  end;
end;

procedure TLeDocumentoPDOR.pSetaTotalUni;
begin
  With cdsFatGor, recDocume Do
  Begin
    Edit;
    cdsFatgor.FieldByName('TOTAUN').AsString := strTotUni;
  End;
end;

Function TLeDocumentoPDOR.fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean;

  function fMontaResumoUnidades: Boolean;
    var
      intContador: Integer;
      stlResumoUnidade: TStringList;
  Begin
    stlResumoUnidade := TStringList.Create;
    strTotUni := '';
    Try
      ExtractStrings(['@'], [], PChar(cdsFatGor.FieldByName('GRPUNI').AsString), stlResumoUnidade);

      if not cdsFatDor.IsEmpty then
      begin
        cdsFatDor.First;
        for intContador := 0 to Pred(stlResumoUnidade.Count) do
        begin
          cdsFatDor.Edit;
          cdsFatDor.FieldByName('RESUNI').AsString := stlResumoUnidade.Strings[intContador];
          strTotUni := strTotUni + stlResumoUnidade.Strings[intContador] + #13#10;
          strTotUni := AnsiReplaceStr(strTotUni, ' ', '=');
          cdsFatDor.Post;
          cdsFatDor.Next;

          if cdsFatDor.Eof then
            Break;
        end;
      end;

      Result := True;
    Finally
      FreeAndNil(stlResumoUnidade);
    End;
  End;

Begin
  Try
    Result := True;

    SetLength(arrClients, 0);

    pSetaNomeTabela;

    Result    := Result And fInsereClientFatDor;

    If Not Result Then
      Exit;

    cdsFatDor := arrClients[0].cdsDados;

    {- A ordenacao deve definida antes de inserir as informacoes dos itens de Madeira
     - Req: 103091 - A procedure "pSetaOrdenacao" estava ocasionando duplicidade de valores,
       por esse motivo trouxe ela para essa posição, pois estava ocorrendo falhas nos campos agregados!
    }
    If fEmptyStr(recDocume.strOrdem) Then
      pSetaOrdenacao;

    pMontaListaClassificacao;

    recDocume.strEntFut := cdsFatDor.FieldByName('ENTFUT').AsString;

    Result    := Result And fInsereClientFatGor;
    cdsFatGor := arrClients[1].cdsDados;

    With recDocume Do
      If Assigned(cdsLogSeparacao) Then
        {Carrega os itens do client de Log para Impressao}
        pCarregaItensLogSeparacaoImpressao(cdsLogSeparacao,
                                           cdsFatDor,
                                           blnEnt_CD,
                                           blnLocFisEmpEmi,
                                           (cdsFatGor.FieldByName('TOTSER').AsFloat > 0));

    cdsFatDor.First;

    pSetaNumeroItens(cdsFatDor.RecordCount);

    recDocume.strGerRom := cdsFatGor.FieldByName('ENTFAT').AsString;

    pMontaDadosFinanceira(cdsFatGor);

    If Not Result Then
      Exit;

    With recDocume Do
    Begin
      If blnDocSep Then
        pCalculaSaldoDisponivelItens(cdsFatDor)
      Else If blnQtdOri Or (Not fServicosDoPedidoJaForamFaturados(strNumDoc, strEspDoc, strCodEmp)) Then
        pInsereItensServico(cdsFatDor, cdsFatGor);
    End;

    pInsereTotalServicoValorOriginal(cdsFatGor);

    If (Not recDocume.blnQtdOri) Or (fUsaRotinaWMS And recDocume.blnDocSep) Then
      pAjustaPesoVolumeLiquido(cdsFatGor, cdsFatDor, recDocume.blnDocSep);

    pInsereItensMadeireira(cdsFatDor);

    pCarregarNCM;

    pMontaDuplicatas;

    pMontaListaCadRec;

    pDescontoItensPromoção;

    pMontaFormaPagamento;

    pMontaDesmembramento;

    pMontaMensagemClassificacaoFiscal;

    pMontaItensEstrutura;

    if recDocume.blnDocSep then
      pMontaItensEstruturaVidro;

    Result := Result And Not cdsFatDor.IsEmpty;

    If (fCfgSis('EMPFAT', varBoolean)) Then
    begin
      recDocume.strEmpDoctoVenda := '';
      if (recDocume.blnDocSep) then
        recDocume.strEmpDoctoVenda := iif(cdsFatGor.FieldByName('EMPEXP').asString = '',
                                          cdsFatGor.FieldByName('CODEMP').asString,
                                          cdsFatGor.FieldByName('EMPEXP').asString)
      else if (fCfgSis('EMPCAB', varString) = '2') then
        recDocume.strEmpDoctoVenda := fRetEmpresaCabecalho(cdsFatGor.FieldByName('CODEMP').asString);
    end
    Else
      recDocume.strEmpDoctoVenda := '';



    Result := Result And fInsereClientEmpresa;

    Result := Result And fInsereClientEmpresa_CD;

    Result := Result And fInsereOperadorLogado;

    Result := Result And fInsereClientCliente;

    Result := Result And fInsereClientEnderecoEntrega(cdsFatGor.FieldByName('AUTGER').AsString,
                                                      cdsFatGor.FieldByName('TABELA').AsString,
                                                      cdsFatGor.FieldByName('FGO_CODFAZ').AsString);

    Result := Result And fPreparaImpressaoDocumentos;

    Result := Result And fMarcaPedidoComoImpresso;

    Result := Result And fMontaResumoUnidades;

    pSetaTotalUni;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;

End;

procedure TLeDocumentoPDOR.pMontaDesmembramento;
var
  strDesmem: String;
  qryDesmem: TUniQuery;
begin
  If cdsFatGor.IsEmpty Then
    Exit;

  If fEmptyStr(cdsFatGor.FieldByName('SEQDMP').AsString) Then
    Exit;

  qryDesmem := fCriaQuery();
  try
    qryDesmem.SQL.Add('SELECT FG.FGO_NUMDOC, FG.FGO_ESPDOC, FG.FGO_CODEMP');
    qryDesmem.SQL.Add('FROM FATGOR FG');
    qryDesmem.SQL.Add('INNER JOIN EXTGOR EG ON EG.FGO_SEQFGO = FG.AUTOINCREM');
    qryDesmem.SQL.Add('WHERE EG.FGO_SEQDMP = :SEQDMP AND NOT ( FG.FGO_NUMDOC = :NUMDOC AND FG.FGO_ESPDOC = :ESPDOC AND FG.FGO_CODEMP = :CODEMP ) ');

    qryDesmem.SQL.Add('UNION ALL');

    qryDesmem.SQL.Add('SELECT MG.GER_NUMDOC, MG.GER_ESPDOC, MG.GER_CODEMP');
    qryDesmem.SQL.Add('FROM MOVGER MG');
    qryDesmem.SQL.Add('INNER JOIN AUXMOV AM ON AM.AUX_SEQGER = MG.AUTOINCREM');
    qryDesmem.SQL.Add('WHERE AM.AUX_SEQDMP = :SEQDMP AND NOT ( MG.GER_NUMDOC = :NUMDOC AND MG.GER_ESPDOC = :ESPDOC AND MG.GER_CODEMP = :CODEMP ) ');

    qryDesmem.ParamByName('SEQDMP').AsString := cdsFatGor.FieldByName('SEQDMP').AsString;
    qryDesmem.ParamByName('NUMDOC').AsString := cdsFatGor.FieldByName('NUMDOC').AsString;
    qryDesmem.ParamByName('ESPDOC').AsString := cdsFatGor.FieldByName('ESPDOC').AsString;
    qryDesmem.ParamByName('CODEMP').AsString := cdsFatGor.FieldByName('CODEMP').AsString;

    qryDesmem.Open;

    while not qryDesmem.Eof do
    begin
      strDesmem := strDesmem + ', ' +
        qryDesmem.FieldByName('FGO_NUMDOC').AsString + '-' +
        qryDesmem.FieldByName('FGO_ESPDOC').AsString + '-' +
        qryDesmem.FieldByName('FGO_CODEMP').AsString;
      qryDesmem.Next;
    end;

    if not fEmptyStr(strDesmem) then
      Delete(strDesmem, 1, 2);
  finally
    FreeAndNil(qryDesmem);
  end;

  if fEmptyStr(strDesmem) then
    Exit;

  cdsFatGor.Edit;
  cdsFatGor.FieldByName('DESMEM').AsString := Trim(strDesmem);
  cdsFatGor.Post;

end;

Procedure TLeDocumentoPDOR.pCriaListaClassificacao;
Begin
  FClaIpi := TStringList.Create;
  FClaIpi.Sorted := True;
  FClaIpi.Duplicates := dupIgnore;

  FLegIPI := '';
End;

procedure TLeDocumentoPDOR.pCriaListaSetores;
begin
  FSetores := TStringList.Create;
  FSetores.Sorted := True;
  FSetores.Duplicates := dupIgnore;
end;

procedure TLeDocumentoPDOR.pDescontoItensPromoção;
Var strSQL: String;
    qryCND: TUniQuery;
    fltTotOri, fltTotUni : Double;

begin
  cdsFatGor.edit;

  strSQL := 'SELECT SUM(FDO_UNIORI * FDO_QTDITE) AS UNIORI, SUM(FDO_UNITAR * FDO_QTDITE) AS UNITAR FROM FATDOR '+
                'WHERE FDO_NUMDOC = :NUMDOC                                   '+
                '  AND FDO_ESPDOC = :ESPDOC                                   '+
                '  AND FDO_CODEMP = :CODEMP                                   '+
                '  AND FDO_PROMOC = "S"                                       ';

  Try
    qryCND := fCriaQuery;
    qryCND.Close;
    qryCND.SQL.Clear;
    qryCND.SQL.Add(strSQL);
    qryCND.ParamByName('NUMDOC').AsString := recDocume.strNumDoc ;
    qryCND.ParamByName('ESPDOC').AsString := recDocume.strEspDoc ;
    qryCND.ParamByName('CODEMP').AsString := recDocume.strCodEmp ;
    qryCND.Open;

    fltTotOri := qryCND.FieldByName('UNIORI').AsFloat;
    fltTotUni := qryCND.FieldByName('UNITAR').AsFloat;


    If fltTotOri > fltTotUni Then
      cdsFatGor.FieldByName('DESCTO').AsFloat :=  fltTotOri - fltTotUni
    Else
      cdsFatGor.FieldByName('DESCTO').AsFloat := 0;
  Finally
    FreeAndNil(qryCND);
  End;
End;


Procedure TLeDocumentoPDOR.pMontaListaClassificacao;
   Var
     intCount: Integer;
Begin
  With cdsFatDor Do
  Begin
    First;
    While Not Eof Do
    Begin
      If Not fEmptyStr(FieldByName('CLAIPI').AsString) Then
        FClaIpi.Add(FieldByName('CLAIPI').AsString);

      If Not fEmptyStr(FieldByName('SETOR_').AsString) Then
        FSetores.Add(FieldByName('SETOR_').AsString);

      Next;
    End;
    First;

    While Not Eof Do
    Begin
      Edit;

      FieldByName('LEGEND').AsString := IfThen(FClaIpi.IndexOf(FieldByName('CLAIPI').AsString) >= 0, fGetLetraAlfa(FClaIpi.IndexOf(FieldByName('CLAIPI').AsString) + 1), '');

      FieldByName('ITETOT').AsFloat := fFormataFloat(FieldByName('VALITE').AsFloat - FieldByName('DESESI').AsFloat + FieldByName('VALIPI').AsFloat + FieldByName('VALRET').AsFloat + FieldByName('VALREF').AsFloat, 2);

      FieldByName('EMBITE').AsString := fRetTiposEmbalagensItem(FieldByName('QTDITE').AsFloat, FieldByName('CODITE').AsString);
      If Not recDocume.blnQtdOri Then
      Begin
        FieldByName('VALITE').AsFloat := fFormataFloat(FieldByName('VALITE').AsFloat, 2);
        FieldByName('VALIPI').AsFloat := fFormataFloat(FieldByName('VALIPI').AsFloat, 2);
        FieldByName('VALRET').AsFloat := fFormataFloat(FieldByName('VALRET').AsFloat, 2);
        FieldByName('VALFRE').AsFloat := fFormataFloat(FieldByName('VALFRE').AsFloat, 2);
        FieldByName('DESESI').AsFloat := fFormataFloat(FieldByName('DESESI').AsFloat, 2);
        FieldByName('IBASIP').AsFloat := fFormataFloat(FieldByName('IBASIP').AsFloat, 2);
        FieldByName('IBASRE').AsFloat := fFormataFloat(FieldByName('IBASRE').AsFloat, 2);
        FieldByName('IBASIC').AsFloat := fFormataFloat(FieldByName('IBASIC').AsFloat, 2);
        FieldByName('IVALIC').AsFloat := fFormataFloat(FieldByName('IVALIC').AsFloat, 2);
        FieldByName('DESACE').AsFloat := fFormataFloat(FieldByName('DESACE').AsFloat, 2);
        FieldByName('VALREF').AsFloat := fFormataFloat(FieldByName('VALREF').AsFloat, 2);
        FieldByName('VALCBS').AsFloat := fFormataFloat(FieldByName('VALCBS').AsFloat, 2);
        FieldByName('VALIBS').AsFloat := fFormataFloat(FieldByName('VALIBS').AsFloat, 2);
        FieldByName('VAL_IS').AsFloat := fFormataFloat(FieldByName('VAL_IS').AsFloat, 2);

        FieldByName('VLRCON').AsFloat := fFormataFloat(FieldByName('VALITE').AsFloat -
                                                       FieldByName('DESESI').AsFloat +
                                                       FieldByName('VALIPI').AsFloat +
                                                       FieldByName('VALRET').AsFloat +
                                                       FieldByName('VALFRE').AsFloat +
                                                       FieldByName('DESACE').AsFloat +
                                                       FieldByName('VALREF').AsFloat +
                                                       IIF((FieldByName('VALRET').AsFloat > 0), FieldByName('VFCPST').AsFloat, 0), 2);
      End;

      Post;

      Next;
    End;

    First;
  End;

  FLegIPI := '';
  For intCount := 1 To FClaIpi.Count Do
  Begin
    FLegIPI := FLegIPI + ' ' + fGetLetraAlfa(intCount) + ': ' + FClaIpi[intCount - 1];
  End;

End;

procedure TLeDocumentoPDOR.pMontaMensagemClassificacaoFiscal;
Var
  strSQL: string;
  LQuery: TUniQuery;
begin

  If cdsFatDor.IsEmpty Then
    Exit;

  try

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  C.CFO_MNAT01, ';
    strSQL := strSQL + '  C.CFO_MNAT02, ';
    strSQL := strSQL + '  C.CFO_MNAT03  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCFO C ';
    strSQL := strSQL + 'WHERE C.CFO_CODCFO = :CLAFIS ';

    LQuery := fCriaQuery;
    LQuery.SQL.Clear;
    LQuery.SQL.Add(strSQL);

    LQuery.ParamByName('CLAFIS').AsString := cdsFatDor.FieldByName('CLAFIS').AsString;
    LQuery.Open;

    cdsFatDor.Edit;
    cdsFatDor.FieldByName('MNAT01').AsString := LQuery.FieldByName('CFO_MNAT01').AsString;
    cdsFatDor.FieldByName('MNAT02').AsString := LQuery.FieldByName('CFO_MNAT02').AsString;
    cdsFatDor.FieldByName('MNAT03').AsString := LQuery.FieldByName('CFO_MNAT03').AsString;
    cdsFatDor.Post;

  finally
    FreeAndNil(LQuery);
  end;

end;

procedure TLeDocumentoPDOR.pOtimizaImagensProduto(strNumdoc, strEspdoc, strCodemp, strCodCli: String);
var
  qryAux: TUniQuery;
  strBase64, strAutInc: String;
begin
  try
    qryAux := fCriaQuery;
    qryAux.SQL.Text := '  SELECT ' +
                       '     ITEIMG.* ' +
                       '  FROM FATDOR ' +
                       '  INNER JOIN ITEIMG ON ITEIMG.ITE_CODITE = FATDOR.FDO_CODITE ' +
                       '                   AND ITEIMG.ITE_PRINCI = "S" ' +
                       '  WHERE TRUE ' +
                       '   AND FDO_NUMDOC = :NUMDOC ' +
                       '   AND FDO_ESPDOC = :ESPDOC ' +
                       '   AND FDO_CODEMP = :CODEMP ' +
                       '   AND FDO_CODCLI = :CODCLI ';
    qryAux.ParamByName('NUMDOC').AsString := strNumdoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspdoc;
    qryAux.ParamByName('CODEMP').AsString := strCodemp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;

    qryAux.Open;
    while not qryAux.Eof do
    Begin
      strBase64 := qryAux.FieldByName('ITE_IMGB64').AsString;
      fOtimizaImagemTam(strBase64, 150);
      strAutInc := qryAux.FieldByName('AUTOINCREM').AsString;

      pGravarThumbItemSPO(strBase64, strAutInc);
      qryAux.Next;
    end;

  finally
    FreeAndNil(qryAux);
  end;
end;

Procedure TLeDocumentoPDOR.pMontaListaCadRec;
  Var
    qryListaCadRec: TUniQuery;
    strCadRec: string;
Begin

  With cdsFatGor Do
  Begin
    If IsEmpty Then
      Exit;

    qryListaCadRec := fCriaQuery(Nil);
    Try
      qryListaCadRec.SQL.Text := ' SELECT CTR_PARCEL, CTR_VALORI FROM CADREC ' +
                                 '  WHERE CTR_NUMDUP = ' + QuotedStr(cdsFatGor.FieldByName('NUMDOC').asString) +
                                 '    AND CTR_ESPDOC = ' + QuotedStr(cdsFatGor.FieldByName('ESPDOC').asString) +
                                 '    AND CTR_CODEMP = ' + QuotedStr(cdsFatGor.FieldByName('CODEMP').asString);
      qryListaCadRec.Open;
      qryListaCadRec.First;
      strCadRec := '';
      While Not qryListaCadRec.Eof Do
      Begin
        strCadRec := strCadRec + qryListaCadRec.FieldByName('CTR_PARCEL').asString + ') '+
                                 FormatFloat( '#,##0.00', qryListaCadRec.FieldByName('CTR_VALORI').asFloat) + '  ';
        qryListaCadRec.Next;
      End;
    Finally
      FreeAndNil(qryListaCadRec);
    End;

    Edit;
    FieldByName('LSTREC').AsString := Trim(strCadRec);
    Post;

  End;

End;


Procedure TLeDocumentoPDOR.pMontaDuplicatas;
  Var
    intQtdDup,
    intContador: Integer;
    strDuplic: String;
    fltTotRes: Currency;
    ArrValPar: Array Of Double;
    blnManPar: Boolean;
    arrDuplicata: TarrDuplicata;

    function fRetFormasNegociadas(strSeqFatGor: String): String;
      Const
        arrLetra : Array[0..25] Of Char = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
      Var
        qryGen: TUniQuery;
        intIdx: Integer;
    begin
      Result := '';
      intIdx := 0;
      qryGen := fCriaQuery(Nil);
      Try
        qryGen.SQL.Text := ' SELECT CONCAT(FPN_CODFPG, "-", FPG_DESCRI, ":", ' +
                           '    IF(FPN_CODFPG = "007", CONCAT(CONCAT(" ",COALESCE(CAR_CODCAR, ""), "-", COALESCE(CAR_DESCAR, "")), " - QTD.PARC.: ", FPN_QTDPAR," -"),""), '+
                           '    CONCAT(" R$ ", FPN_VALFPG)) '+
                           ' FROM FPGNEG INNER JOIN CADFPG ON (CADFPG.FPG_CODIGO = FPGNEG.FPN_CODFPG) '+
                           '              LEFT JOIN CADCAR ON (CADCAR.CAR_CODCAR = FPGNEG.FPN_CODCAR) '+
                           ' WHERE FPGNEG.FPN_SEQFGO = '+QuotedStr(strSeqFatGor);
        qryGen.Open;
        qryGen.First;

        While Not qryGen.Eof Do
        Begin
          Result := Result + arrLetra[intIdx] + ') '+ qryGen.Fields[0].Text + '  ';
          Inc(intIdx);
          qryGen.Next;
        End;
      Finally
        FreeAndNil(qryGen);
      End;
    end;

    procedure pCarregaDuplicatasCND(strNumDoc, strEspDoc, strSerDoc, strCodEmp, strCodCli:String);
    var strSQL: String;
        qryCND: TUniQuery;
      intIndex: Integer;
    Begin
      strSQL := 'SELECT GER_PARCEL AS PARCEL, GER_VALPAR AS VALPAR FROM GERCND '+
                'INNER JOIN MOVGER ON GER_SEQGER = AUTOINCREM                  '+
                'WHERE GER_NUMDOC = :NUMDOC                                    '+
                '  AND GER_ESPDOC = :ESPDOC                                    '+
                '  AND GER_SERIE_ = :SERDOC                                    '+
                '  AND GER_CODCLI = :CODCLI                                    '+
                '  AND GER_CODEMP = :CODEMP                                    '+
                'UNION ALL                                                     '+
                'SELECT GER_PARCEL AS PARCEL, GER_VALPAR AS VALPAR FROM NOTCND '+
                'INNER JOIN MOVGER ON GER_SEQGER = AUTOINCREM                  '+
                'WHERE GER_NUMDOC = :NUMDOC                                    '+
                '  AND GER_ESPDOC = :ESPDOC                                    '+
                '  AND GER_SERIE_ = :SERDOC                                    '+
                '  AND GER_CODCLI = :CODCLI                                    '+
                '  AND GER_CODEMP = :CODEMP                                    '+
                'ORDER BY PARCEL                                               ';
      Try
        qryCND := fCriaQuery;

        with qryCND, SQL do
        Begin
          Clear;
          Add(strSQL);
          ParamByName('NUMDOC').AsString := strNumDoc ;
          ParamByName('ESPDOC').AsString := strEspDoc ;
          ParamByName('SERDOC').AsString := strSerDoc ;
          ParamByName('CODCLI').AsString := strCodCli ;
          ParamByName('CODEMP').AsString := strCodEmp ;
          Open;

          intIndex := 1;
          While not eof do
          Begin
            cdsFatGor.FieldByName('VPAR' + RightStr('0' + IntToStr(intIndex), 2)).AsFloat := fFormataFloat(FieldByName('VALPAR').AsFloat, 2);
            Inc(intIndex);

            Next;
          End;

        End;

      Finally
        FreeAndNil(qryCND);
      End;

    End;

Begin
  pZeraDigDuplic(arrDuplicata);
  With cdsFatGor Do
  Begin
    If IsEmpty Then
      Exit;

    Edit;

    If cdsFatDor.fRetSoma('TOTUNI') > cdsFatDor.fRetSoma('TOTORI') Then
      FieldByName('VALBRU').AsFloat := cdsFatDor.fRetSoma('TOTUNI')
    Else
      FieldByName('VALBRU').AsFloat := cdsFatDor.fRetSoma('TOTORI');

    FieldByName('BRUDIG').AsFloat := cdsFatDor.fRetSoma('TOTDIG');

    FieldByName('VRBREX').AsString := fRetExtensoNumero(FloatToStrF(FieldByName('VALBRU').AsFloat,ffNumber,12,2));
    FieldByName('VRCOEX').AsString := fRetExtensoNumero(FloatToStrF(FieldByName('VLRCON').AsFloat,ffNumber,12,2));

    If cdsFatDor.fRetSoma('TOTORI') > cdsFatDor.fRetSoma('TOTUNI') Then
      FieldByName('DESTOT').AsFloat := cdsFatDor.fRetSoma('TOTORI') - cdsFatDor.fRetSoma('TOTUNI')
    Else
      FieldByName('DESTOT').AsFloat := 0;

    FieldByName('PRZMED').AsFloat  := fCalcMediaPagto(FieldByName('CONPAG').AsString);

    If fStatusCndPag(FieldByName('CONPAG').AsString) = A_VISTA Then
      FieldByName('AVISTA').AsString := 'S'
    Else
      FieldByName('AVISTA').AsString := 'N';

    SetLength(ArrValPar, 0);

    For intContador := 0 To 23 Do
    Begin
      If fFormataFloat(FieldByName('VPAR' + fStrZero(intContador + 1, 2)).AsFloat, 2) = 0.00 Then
        Break;

      SetLength(ArrValPar, Length(ArrValPar) + 1);
      ArrValPar[Length(ArrValPar) - 1] := FieldByName('VPAR' + fStrZero(intContador + 1, 2)).AsFloat;
    End;

    blnManPar := ((fFormataFloat(FieldByName('VLRCON').AsFloat, 2) = fFormataFloat(Sum(ArrValPar), 2))) Or (fEhClienteOrgaoPublico(FieldByName('CODCLI').AsString));

    If blnManPar Then
      If (FieldByName('BOLADT').AsFloat > 0) And (FieldByName('BOLVEN').AsString <> 'S') Then
        blnManPar := (strToIntDef(LeftStr(FieldByName('CONPAG').AsString, 2), 0) = Length(ArrValPar) - 1)
      Else
        blnManPar := (strToIntDef(LeftStr(FieldByName('CONPAG').AsString, 2), 0) = Length(ArrValPar));

    strDuplic := '';

    fDigDuplicSemTela(arrDuplicata,
                      intQtdDup,
                      fltTotRes,
                      FieldByName('CONPAG').AsString,
                      123,
                      FieldByName('VLRCON').AsFloat - IIF(blnManPar And (FieldByName('BOLVEN').AsString <> 'S'), FieldByName('BOLADT').AsFloat, 0),
                      False,
                      False,
                      FieldByName('PREVIS').AsDateTime,
                      False);

    pCarregaDuplicatasCND(FieldByName('NUMDOC').AsString,
                          FieldByName('ESPDOC').AsString,
                          FieldByName('SERDOC').AsString,
                          FieldByName('CODEMP').AsString,
                          FieldByName('CODCLI').AsString);

    If (FieldByName('BOLADT').AsFloat > 0) And (FieldByName('BOLVEN').AsString <> 'S') Then
    Begin
      For intContador := High(arrDuplicata) Downto 1 Do
      Begin
        arrDuplicata[intContador] := arrDuplicata[intContador-1];
        If Not fEmptyStr(arrDuplicata[intContador].strSequen) Then
          arrDuplicata[intContador].strSequen := fIncAlfaNumerico(arrDuplicata[intContador].strSequen);
      End;
      arrDuplicata[0].curValor  := FieldByName('BOLADT').AsFloat;
      arrDuplicata[0].dtaDtaVen := FieldByName('PREVIS').AsString;
      arrDuplicata[0].strSequen := 'A';
    End;

    If Not (fStatusCndPag(FieldByName('CONPAG').AsString) = A_VISTA) Then
    Begin

      For intContador := 0 To Length(arrDuplicata)-1 Do
      Begin
        If Not fEmptyStr(arrDuplicata[intContador].dtaDtaVen) Then
        Begin
          FieldByName('DTAV' + RightStr('0' + IntToStr(intContador+1), 2) ).AsDateTime := StrToDateDef(arrDuplicata[intContador].dtaDtaVen, 0);

          If Not blnManPar Then
            FieldByName('VPAR' + RightStr('0' + IntToStr(intContador+1), 2)).AsFloat := arrDuplicata[intContador].curValor;

          strDuplic := strDuplic + '  ' + arrDuplicata[intContador].strSequen + ')' +
                       FormatDateTime('DD/MM/YYYY', FieldByName('DTAV' + RightStr('0' + IntToStr(intContador+1), 2) ).AsDateTime) + ' ' +
                       fstrEspaco(FloatToStrF(FieldByName('VPAR' + RightStr('0' + IntToStr(intContador+1), 2)).AsFloat, ffNumber, 15, 2), 12, 2);

        End Else
        Begin
          FieldByName('DTAV' + RightStr('0' + IntToStr(intContador+1), 2) ).Clear;
          FieldByName('VPAR' + RightStr('0' + IntToStr(intContador+1), 2)).AsFloat := 0;
        End;

      End;

      {************************************************************************}
      {* SE TIVER FORMAS NEGOCIADAS DO PD/OR UTILIZA ELAS NO FORMATO LINHA NO *}
      {* LUGAR DAS DUPLICATAS                                                 *}
      {**********************************************************************VA}
      If Not fEmptyStr(FieldByName('FORNEG').AsString) Then
        strDuplic := fRetFormasNegociadas(FieldByName('AUTGER').AsString);

      FieldByName('DUPLIC').AsString := Trim(strDuplic);

    End;

    Post;
  End;

End;

  {***********************************************}
  {* VALORES DAS CONDICOES PAGAMENTO HABILITADAS *}
  {********************************************MA*}

Procedure TLeDocumentoPDOR.pMontaFormaPagamento;
Var
  qryFgoCnd: TUniQuery;
  stlTexto: TStringList;
  stlPagto: TStringList;
  stlValParcela: TStringList;
  intQtdPar: integer;
Begin
  stlTexto := TStringList.Create;
  stlPagto := TStringList.Create;
  stlValParcela := TStringList.Create;

  With cdsFatGor Do
  Begin
    If IsEmpty Then
      Exit;
    Try
      Edit;
      qryFgoCnd := fCriaQuery(Nil);

      If (fCfgSis('VLRCND', varBoolean)) Then
      Begin
        With qryFgoCnd Do
        Begin
          SQL.Clear;
          SQL.Add(' SELECT DISTINCT ');
          SQL.Add('     CND_CODIGO, ');
          SQL.Add('     CND_DESCRI, ');
          SQL.Add('     C.CND_CNDPAG AS CNDPAG, ');
          SQL.Add('     F.FGO_TOTCND AS TOTCND ');
          SQL.Add(' FROM ');
          SQL.Add('     FGOCND F INNER JOIN CADCND C ON (F.FGO_CODCND = C.CND_CODIGO) ');
          SQL.Add('                                 AND POSITION('+ QuotedStr(VS_strCodEmp) +' IN C.CND_EMPACE) > 0 ');
          SQL.Add('              INNER JOIN FATGOR G ON (G.AUTOINCREM = F.FGO_SEQGER) ');
          SQL.Add('              LEFT  JOIN CLICND P ON (P.CND_CODCLI = G.FGO_CODCLI) ');
          SQL.Add('                                     AND (P.CND_CODCND = F.FGO_CODCND) ');
          SQL.Add(' WHERE ');
          SQL.Add('     F.FGO_SEQGER = :AUTINC ');
          SQL.Add(' ORDER BY CND_CODIGO ');
          ParamByName('AUTINC').AsString := cdsFatGor.FieldByName('AUTGER').AsString;
          Open;
        End;

        qryFgoCnd.First;
        While Not qryFgoCnd.Eof do
        Begin

          intQtdPar := StrToIntDef( Trim( Copy( qryFgoCnd.FieldByName('CNDPAG').AsString, 1, 2 ) ), 0 );

          stlTexto.Add(fPadL(qryFgoCnd.FieldByName('CND_CODIGO').AsString, 3, '0') +  '-' +
                       fPadR(qryFgoCnd.FieldByName('CND_DESCRI').AsString, 60, ' '));
          stlPagto.Add(fPadL(FloatToStrF(qryFgoCnd.FieldByName('TOTCND').AsFloat,ffFixed,12,2), 10));
          stlValParcela.Add(fPadL(FloatToStrF((qryFgoCnd.FieldByName('TOTCND').AsFloat / intQtdPar) ,ffFixed,12,2), 10));

          qryFgoCnd.Next;
        End;

        cdsFatGor.FieldByName('DSCPGO').AsString := stlTexto.Text;
        cdsFatGor.FieldByName('TOTPGO').AsString := stlPagto.Text;
        cdsFatGor.FieldByName('VALPGO').AsString := stlValParcela.Text;

        FreeAndNil(stlTexto);
        FreeAndNil(stlPagto);
      End;

      Post;
      FreeAndNil(qryFgoCnd);

    Except
      On E: Exception Do
      Begin
        fRollBack;
        FreeAndNil(qryFgoCnd);
        pMensagensErro(E.Message, '[TLeDocumentoPDOR.pMontaFormaPagamento]');
      End;
    End;
  End;
End;

procedure TLeDocumentoPDOR.pMontaItensEstrutura;
var
  qryItensEstrutura: TUniQuery;
  stlItensEstrutura: TStringList;
  intSeqPer: Integer;

  function fEhEstruturaPersonalizada():Boolean;
  begin
    Result := (intSeqPer > -1);
  end;

begin

  if cdsFatDor.IsEmpty then
    Exit;

  stlItensEstrutura := TStringList.Create;
  qryItensEstrutura := fCriaQuery(Nil);

  Try
    cdsFatDor.First;
    while not cdsFatDor.Eof Do
    Begin
      intSeqPer := fRetornaSeqPerEstruturaPersonalizadaItemPedido(cdsFatDor.FieldByName('AUTDET').AsString);

      qryItensEstrutura.SQL.Clear;
      qryItensEstrutura.SQL.Add('SELECT                                   ');
      qryItensEstrutura.SQL.Add('  DMT_ITESUB,                            ');
      qryItensEstrutura.SQL.Add('  ITE2.ITE_DESITE,                       ');
      qryItensEstrutura.SQL.Add('  ROUND(DMT_QTDITE,'+IntToStr(StrToIntDef(fCfgSis('DECUNI', varInteger),2))+') AS DMT_QTDITE, ');
      qryItensEstrutura.SQL.Add('  ITG.ITE_LOCFIS                         ');
      qryItensEstrutura.SQL.Add('FROM                                     ');
      qryItensEstrutura.SQL.Add('  ' + IIF(fEhEstruturaPersonalizada, 'DETPER', 'DETMAT') + ' DMT                             ');
      qryItensEstrutura.SQL.Add('  LEFT JOIN ' + IIF(fEhEstruturaPersonalizada, 'GERPER', 'GERMAT') + ' GMT                   ');
      qryItensEstrutura.SQL.Add('    ON GMT.AUTOINCREM = DMT.DMT_SEQGER   ');
      qryItensEstrutura.SQL.Add('  LEFT JOIN CADITE ITE1                  ');
      qryItensEstrutura.SQL.Add('    ON ITE1.ITE_CODITE = GMT.GMT_CODITE  ');
      qryItensEstrutura.SQL.Add('  LEFT JOIN ITEGER ITG                   ');
      qryItensEstrutura.SQL.Add('    ON ITG.ITE_CODITE = DMT.DMT_ITESUB   ');
      qryItensEstrutura.SQL.Add('    AND ITG.ITE_CODEMP = DMT.DMT_CODEMP  ');
      qryItensEstrutura.SQL.Add('  LEFT JOIN CADITE ITE2                  ');
      qryItensEstrutura.SQL.Add('    ON ITE2.ITE_CODITE = DMT.DMT_ITESUB  ');
      qryItensEstrutura.SQL.Add('WHERE ITE1.ITE_CODITE = :CODITE          ');

      If (fEhEstruturaPersonalizada) Then
      Begin
        qryItensEstrutura.SQL.Add('  AND GMT.GMT_NUMDOC=:NUMDOC           ');
        qryItensEstrutura.SQL.Add('  AND GMT.GMT_ESPDOC=:ESPDOC           ');
        qryItensEstrutura.SQL.Add('  AND GMT.GMT_EMPDOC=:EMPDOC           ');
        qryItensEstrutura.SQL.Add('  AND GMT.GMT_SEQPER=:SEQPER           ');

        qryItensEstrutura.ParamByName('NUMDOC').AsString := cdsFatdor.FieldByName('NUMDOC').AsString;
        qryItensEstrutura.ParamByName('ESPDOC').AsString := cdsFatdor.FieldByName('ESPDOC').AsString;
        qryItensEstrutura.ParamByName('EMPDOC').AsString := cdsFatdor.FieldByName('CODEMP').AsString;
        qryItensEstrutura.ParamByName('SEQPER').AsInteger := intSeqPer;
      End;

      qryItensEstrutura.ParamByName('CODITE').AsString := cdsFatdor.FieldByName('CODITE').AsString;
      qryItensEstrutura.Open;

      qryItensEstrutura.First;
      While Not qryItensEstrutura.Eof do
      Begin
        stlItensEstrutura.Add(qryItensEstrutura.FieldByName('DMT_ITESUB').AsString+' | '+
                              fPadR(qryItensEstrutura.FieldByName('ITE_DESITE').AsString, 60, ' ')+' | '+
                              qryItensEstrutura.FieldByName('DMT_QTDITE').AsString+' | '+
                              qryItensEstrutura.FieldByName('ITE_LOCFIS').AsString);
        qryItensEstrutura.Next;
      End;

      cdsFatDor.Edit;
      cdsFatDor.FieldByName('ESTRUT').AsString := stlItensEstrutura.Text;
      cdsFatDor.Post;

      cdsFatDor.Next;
      stlItensEstrutura.Clear;

    end;

    FreeAndNil(stlItensEstrutura);
    FreeAndNil(qryItensEstrutura);

  except
    on E: Exception do
    begin
      fRollBack;
      FreeAndNil(stlItensEstrutura);
      FreeAndNil(qryItensEstrutura);
      pMensagensErro(E.Message, '[TLeDocumentoPDOR.pMontaItensEstrutura]');
    end;
  end;

end;

procedure TLeDocumentoPDOR.pMontaItensEstruturaVidro;
var
  qryItensEstruturaVidro: TUniQuery;
  stlItensEstruturaVidro: TStringList;
begin

  if cdsFatDor.IsEmpty then
    Exit;

  stlItensEstruturaVidro := TStringList.Create;
  qryItensEstruturaVidro := fCriaQuery(Nil);

  Try
    cdsFatDor.First;
    while not cdsFatDor.Eof Do
    Begin

      qryItensEstruturaVidro.SQL.Clear;
      qryItensEstruturaVidro.SQL.Add('SELECT                                                                                      ');
      qryItensEstruturaVidro.SQL.Add('  VID_CODITE AS CODITE,                                                                     ');
      qryItensEstruturaVidro.SQL.Add('  ITE_DESITE AS DESITE,                                                                     ');
      qryItensEstruturaVidro.SQL.Add('  ROUND(VID_QTDITE,'+IntToStr(StrToIntDef(fCfgSis('DECUNI', varInteger),2))+') AS QTDITE,   ');
      qryItensEstruturaVidro.SQL.Add('  ITG.ITE_LOCFIS AS LOCFIS                                                                  ');
      qryItensEstruturaVidro.SQL.Add('FROM                                                                                        ');
      qryItensEstruturaVidro.SQL.Add('  ORCVID VID                                                                                ');
      qryItensEstruturaVidro.SQL.Add('  LEFT JOIN CADITE ITE                                                                      ');
      qryItensEstruturaVidro.SQL.Add('    ON ITE.ITE_CODITE = VID.VID_CODITE                                                      ');
      qryItensEstruturaVidro.SQL.Add('  LEFT JOIN ITEGER ITG                                                                      ');
      qryItensEstruturaVidro.SQL.Add('    ON ITG.ITE_CODITE = ITE.ITE_CODITE                                                      ');
      qryItensEstruturaVidro.SQL.Add('   AND ITG.ITE_CODEMP = '+QuotedStr(VS_strCodEmp)                                            );
      qryItensEstruturaVidro.SQL.Add('WHERE VID.VID_SEQGER = '+QuotedStr(cdsFatDor.FieldByName('AUTDET').asString)                 );
      qryItensEstruturaVidro.Open;

      qryItensEstruturaVidro.First;
      While Not qryItensEstruturaVidro.Eof do
      Begin
        stlItensEstruturaVidro.Add(qryItensEstruturaVidro.FieldByName('CODITE').AsString+' | '+
                              fPadR(qryItensEstruturaVidro.FieldByName('DESITE').AsString, 60, ' ')+' | '+
                              qryItensEstruturaVidro.FieldByName('QTDITE').AsString+' | '+
                              qryItensEstruturaVidro.FieldByName('LOCFIS').AsString);
        qryItensEstruturaVidro.Next;
      End;

      cdsFatDor.Edit;
      cdsFatDor.FieldByName('ESTVID').AsString := stlItensEstruturaVidro.Text;
      cdsFatDor.Post;

      cdsFatDor.Next;
      stlItensEstruturaVidro.Clear;

    end;

    FreeAndNil(stlItensEstruturaVidro);
    FreeAndNil(qryItensEstruturaVidro);

  except
    on E: Exception do
    begin
      fRollBack;
      FreeAndNil(stlItensEstruturaVidro);
      FreeAndNil(qryItensEstruturaVidro);
      pMensagensErro(E.Message, '[TLeDocumentoPDOR.pMontaItensEstruturaVidro]');
    end;
  end;

end;

class function TLeDocumentoPDOR.fRetEhImpressaoDeDocumentoBaixadoWMS(const recDocume : TRecDocumento): Boolean;
  Var
    qryLotDor: TUniQuery;
begin
  Result := False;

  If Not fUsaRotinaWMS Then
    Exit;

  If Not recDocume.blnReimpr Then
    Exit;

  If Not fRetPedidoBaixadoNaoSeraEntregue(recDocume) Then
    Exit;

  qryLotDor := fCriaQuery;
  Try
    qryLotDor.Close;
    qryLotDor.SQL.Clear;
    qryLotDor.SQL.Add('SELECT DEL_LOTDOR.* FROM DEL_LOTDOR ');
    qryLotDor.SQL.Add('INNER JOIN FATDOR ON DEL_LOTDOR.LDO_SEQFDO = FATDOR.AUTOINCREM ');
    qryLotDor.SQL.Add('WHERE FDO_NUMDOC = :NUMDOC AND FDO_ESPDOC = :ESPDOC AND FDO_CODEMP = :CODEMP');
    qryLotDor.ParamByName('NUMDOC').AsString := recDocume.strNumDoc;
    qryLotDor.ParamByName('ESPDOC').AsString := recDocume.strEspDoc;
    qryLotDor.ParamByName('CODEMP').AsString := recDocume.strCodEmp;
    qryLotDor.Open;

    If Not qryLotDor.IsEmpty Then
      Result := True;
  Finally
    FreeAndNil(qryLotDor);
  End;
end;

class function TLeDocumentoPDOR.fRetEhReimpressaoDeDocumentoCanceladoWMS(const recDocume : TRecDocumento): Boolean;
begin

  Result := False;

  If Not fUsaRotinaWMS Then
    Exit;

  If Not recDocume.blnReimpr Then
    Exit;

  If Not recDocume.blnDocCan Then
    Exit;

  If Not fTemDel_LotDor(recDocume) Then
    Exit;

  Result := True;

end;

function TLeDocumentoPDOR.fRetEmpresaCabecalho(strCodEmp: String): String;
  Var
    strEmpDoItem: String;
begin

  strEmpDoItem := '';

  cdsFatDor.DisableControls;
  try
    cdsFatDor.First;
    strEmpDoItem := cdsFatDor.FieldByName('EMPITE').AsString;
    While Not cdsFatDor.Eof do
    Begin
      If (strEmpDoItem = cdsFatDor.FieldByName('EMPITE').asString) Then
        Result := strEmpDoItem
      Else
        Exit(strCodEmp);

      cdsFatDor.Next;
    End;
  finally
    cdsFatDor.First;
    cdsFatDor.EnableControls;
  end;

end;

function TLeDocumentoPDOR.fRetLotDor: String;
  const
    TAB_LOTDOR     = 'LOTDOR';
    TAB_DEL_LOTDOR = 'DEL_LOTDOR';
begin
  Result := IIF((fRetEhReimpressaoDeDocumentoCanceladoWMS(recDocume)) Or (fRetEhImpressaoDeDocumentoBaixadoWMS(recDocume)), TAB_DEL_LOTDOR, TAB_LOTDOR);
end;

class function TLeDocumentoPDOR.fRetPedidoBaixadoNaoSeraEntregue(const recDocume : TRecDocumento): Boolean;
  Var
    qryPedidoBaixado : TUniQuery;
begin
  Result := False;

  qryPedidoBaixado := fCriaQuery;
  Try
    qryPedidoBaixado.Close;
    qryPedidoBaixado.SQL.Clear;
    qryPedidoBaixado.SQL.Add('SELECT AUTOINCREM FROM FATGOR ');
    qryPedidoBaixado.SQL.Add('WHERE FGO_NUMDOC = :NUMDOC AND FGO_ESPDOC = :ESPDOC AND FGO_CODEMP = :CODEMP ');
    qryPedidoBaixado.SQL.Add('AND FGO_JAFATU = 1 AND IFNULL(FGO_MOTBAI, "") <> "" ');
    qryPedidoBaixado.ParamByName('NUMDOC').AsString := recDocume.strNumDoc;
    qryPedidoBaixado.ParamByName('ESPDOC').AsString := recDocume.strEspDoc;
    qryPedidoBaixado.ParamByName('CODEMP').AsString := recDocume.strCodEmp;
    qryPedidoBaixado.Open;

    If Not qryPedidoBaixado.IsEmpty Then
      Result := True;
  Finally
    FreeAndNil(qryPedidoBaixado);
  End;
end;

function TLeDocumentoPDOR.fRetTiposEmbalagensItem(pQtdIte: Double;
  pCodIte: String): String;
var
  qryEmb : TUniQuery;
  strEmb : String;
  pQtdeEmb : integer;
begin
  qryEmb := fCriaQuery(Nil);
  try
    result := EmptyStr;
    With qryEmb, SQL Do
    Begin
      Clear;
      Add(' SELECT BAR_EMBALA ');
      Add('   FROM ITEBAR ');
      Add('  INNER JOIN CADITE C ');
      Add('     ON C.ITE_CODITE = ITEBAR.BAR_CODITE ');
      Add('  WHERE C.ITE_CODITE = :CODITE ');
      Add('    AND ITEBAR.BAR_EMBALA > 1 ');
      Add('  ORDER BY BAR_EMBALA DESC  ');

      ParamByName('CODITE').AsString := pCodIte;

      Open;
      if Not(IsEmpty) then
      begin
        strEmb := EmptyStr;
        while not Eof do
        begin
          if strEmb <> '' then
            strEmb := strEmb +'/';

          if pQtdIte >= qryEmb.FieldByName('BAR_EMBALA').AsFloat then
          begin
            pQtdeEmb := Trunc(pQtdIte / FieldByName('BAR_EMBALA').AsFloat);
            strEmb := strEmb + format('%s', [IntToStr(pQtdeEmb)]);
            pQtdIte := pQtdIte - (pQtdeEmb * FieldByName('BAR_EMBALA').AsFloat);
          end
          else
            strEmb := strEmb + '0';

          Next;
        end;
        result := strEmb;
      end;
    end;
  finally
    FreeAndNil(qryEmb);
  end;
end;

function TLeDocumentoPDOR.fRetCampoValorItem(strCmpOri, strCalQtd, strNomFin: String; blnPorQtd: Boolean = False): String;
  Var
    strSQL: String;
begin
  If (recDocume.blnQtdOri) Then
  Begin
    strSQL := strCmpOri;
  End
  Else
  Begin
    If recDocume.blnDocSep And recDocume.blnImpExpedicao And (recDocume.intSeqSepPar > 0) Then
      strSQL := strCalQtd + ' * SEP_QTDSEP '
    Else If recDocume.blnDocSep And fPermiteImprimirSeparacaoParcial Then
      strSQL := strCalQtd + ' * (FDO_QTDSEP - ' + fGetSQLQtdBaixada(recDocume) + ')'
    Else If (recDocume.blnOpcFat) Then
      strSQL := strCalQtd + ' * FDO_QTDBAI '
    Else
      strSQL := strCalQtd + ' * (FDO_QTDITE - ' + fGetSQLQtdBaixada(recDocume) + ')';
  End;

  If (blnPorQtd) Then
    strSQL := '('+ strSQL + ') / FDO_QTDITE ';

  Result :=  '('+ strSQL + ') AS '+ strNomFin + ', ';
end;

end.



