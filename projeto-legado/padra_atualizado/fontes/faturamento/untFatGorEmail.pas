unit untFatGorEmail;

interface

uses
  SysUtils, Classes, frxClass, frxExportPDF, DB, UniClientDataSet, frxDBSet, Uni,
  UntTypesSistema, Forms, frxExportXLS, frxExportODF, Windows, Datasnap.DBClient;

type
  TfrmFatGorEmail = class(TForm)
    frxExportaPDF_R: TfrxReport;
    frxParametros: TfrxUserDataSet;
    frxTitulo: TfrxDBDataset;
    frxCabecalho: TfrxDBDataset;
    frxItens: TfrxDBDataset;
    frxTotais: TfrxDBDataset;
    frxDuplicatas: TfrxDBDataset;
    cdsDuplicatas: TUniClientDataSet;
    cdsDuplicatasVALOR: TFloatField;
    cdsDuplicatasVENCIMENTO: TStringField;
    cdsDuplicatasSEQUENCIA: TStringField;
    cdsTotais: TUniClientDataSet;
    cdsTotaisTOTAL_PROD: TFloatField;
    cdsTotaisTOTAL_DESC: TFloatField;
    cdsTotaisTOTAL_IPI: TFloatField;
    cdsTotaisTOTAL_PEDORC: TFloatField;
    cdsTotaisCOM_IPI: TStringField;
    frxComplementares: TfrxDBDataset;
    cdsComplementares: TUniClientDataSet;
    cdsComplementaresMENS01: TStringField;
    cdsComplementaresMENS02: TStringField;
    cdsComplementaresDATA: TDateField;
    frxExportaPDF: TfrxPDFExport;
    frxExportaXLS: TfrxXLSExport;
    cdsComplementaresPREVIS: TDateField;
    cdsServicos: TUniClientDataSet;
    cdsServicosCODSER: TStringField;
    cdsServicosDESSER: TStringField;
    cdsServicosTOTSER: TFloatField;
    cdsServicosPERISS: TFloatField;
    cdsServicosVALISS: TFloatField;
    frxServicos: TfrxDBDataset;
    cdsServicosVALSER: TFloatField;
    cdsTotaisTOTAL_FRETE: TFloatField;
    cdsTotaisTOTAL_RET: TFloatField;
    cdsComplementaresVALID: TDateField;
    frxExportaODS: TfrxODSExport;
    frxExportaPDF_P: TfrxReport;
    cdsTotaisPESBRU: TFloatField;
    cdsTotaisTOTAL_DESACE: TFloatField;
    cdsComplementaresMSGORC: TStringField;
    cdsComplementaresREPRES: TStringField;
    cdsComplementaresFRETE: TStringField;
    procedure frxParametrosGetValue(const VarName: String;
      var Value: Variant);
    procedure DataModuleCreate(Sender: TObject);
    function frxExportaPDF_RUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    procedure DataModuleDestroy(Sender: TObject);
    function fRetornaTotalDesconto(strNumDoc,strEspDoc,strCodEmp : String) : Double;
  private
    { Private declarations }
    strMskDecUnit: String;
    strDirImagem: String;
    strDirImgGde: String;
    strDocumento: String;
    blnPreco    : Boolean;
    strStatus   : String;
    stlClaIpi   : TStringList;

    function fDadosMetragem(strAparel, strBenefi: String; fltQtdPec, fltComPec, fltLarPec, fltEspPec: Double): String;
    function fFormataFoneInterna(strFone: String): String;
    function fDescontoCliente: Boolean;
    function fGetDesCli: Double;
  public
    { Public declarations }
    FstrEspDoc: String;
    FstrCodCli: String;
    FfltDesCli: Double;

    function fGeraEmail(strNumDoc,
                        strEspDoc: String;
                        opcComSemPreco: TImpressaoComSemPrecoOrPd;
                        blnComMarca: Boolean;
                        strTipExp: String;
                        strModo: String = 'R';
                        strOrdem        : String  = '';
                        strCodEmpPar    : String  = '';
                        blnLocFis       : Boolean = False;
                        strNomEmp       : String  = 'R';
                        strCodCli       : String  = '';
                        blnCabecalhoCD  : Boolean = False;
                        blnDocCancelado : Boolean = False;
                        blnQtdOri       : Boolean = True): String;

    class function fGerarEmail(strNumDoc,
                        strEspDoc: String;
                        opcComSemPreco: TImpressaoComSemPrecoOrPd;
                        blnComMarca: Boolean;
                        strTipExp: String;
                        strModo: String = 'R';
                        strOrdem        : String  = '';
                        strCodEmpPar    : String  = '';
                        blnLocFis       : Boolean = False;
                        strNomEmp       : String  = 'R';
                        strCodCli       : String  = '';
                        blnCabecalhoCD  : Boolean = False;
                        blnDocCancelado : Boolean = False;
                        blnQtdOri       : Boolean = True): String;
  end;

var
  frmFatGorEmail: TfrmFatGorEmail;

implementation

uses  untConstantes, untFuncoesSimples, untMovGer, untFuncoesEditorFast, untFuncoesGenerica,
  untDocPDOR_Excel, untFatImpressao;

{$R *.dfm}

function TfrmFatGorEmail.fGeraEmail(strNumDoc,
                                    strEspDoc: String;
                                    opcComSemPreco: TImpressaoComSemPrecoOrPd;
                                    blnComMarca: Boolean;
                                    strTipExp: String;
                                    strModo: String = 'R';
                                    strOrdem        : String = '';
                                    strCodEmpPar    : String = '';
                                    blnLocFis       : Boolean = False;
                                    strNomEmp       : String = 'R';
                                    strCodCli       : String = '';
                                    blnCabecalhoCD  : Boolean = False;
                                    blnDocCancelado : Boolean = False;
                                    blnQtdOri       : Boolean = True): String;
  Var
    qryTitulo: TUniQuery;
    qryCabecalho: TUniQuery;
    qryItens: TUniQuery;
    qryDuplicatas: TUniQuery;
    qryComplementares: TUniQuery;
    qryTotais: TUniQuery;
    strSQL: String;
    strExecutavel: String;
    strNomeArquivo: String;
    blnSomenteServ: Boolean;
    blnTemServicos: Boolean;
    intContador: Integer;
    intQtdDup: Integer;
    curTotalRes: Currency;
    fltTotGeral: Double;
    intQtdSer  : Integer;
    blnImpVol  : Boolean;
    intCount   : Integer;
    strClaIpi  : String;
    frxPDF     : TfrxReport;
    blnEmpFat  : Boolean;
    blnLayoutAtivo: Boolean;
    strEmp_CD : String;
    strEmpCabecalho_CD : String;
    strPathEti : String;
    blnArquivoPatEtiExiste : Boolean;
    arrDuplicata: TarrDuplicata;
    arrDuplicataCND: TarrDuplicata;
begin
  pZeraDigDuplic(arrDuplicata);
  pZeraDigDuplic(arrDuplicataCND);
  Result := '';
  strEmp_CD := '';
  strEmpCabecalho_CD := '';
  strPathEti := fCfgSis('PATETI', varString);
  strPathEti := '';
  blnArquivoPatEtiExiste := False;

  If Not fEmptyStr(strPathEti) Then
    blnArquivoPatEtiExiste := (FileExists(strPathEti + '\frxOrcPedFatFutProdServ.fr3'));

  blnLayoutAtivo := fLayoutAtivoPdfPedidoOrcamento(strNumDoc, strEspDoc, VS_strCodEmp);

  If ((strTipExp = 'P') And (Not blnArquivoPatEtiExiste)) Or ((strTipExp = 'E') And (TDocPDOR_Excel.fUtilizaLayOutExcel)) Then
  Begin
    strNomeArquivo := '';

    If (Not blnLayoutAtivo) and (Not fCfgSis('UTIDEF', varBoolean)) Then
      fMensagem('ATENÇÃO', 'Não há Layout Disponível para gerar PDF!', ['&O k'])
    Else
    Begin
      If fEmptyStr(strCodEmpPar) Then
        strCodEmpPar := VS_strCodEmp;

      strEmpCabecalho_CD := fCfgSis('EMP_CD', varString, strCodEmpPar);

      If (blnLayoutAtivo) Or
         (fCfgSis('UTIDEF', varBoolean) And (fGetUtilizaLayoutFR3EspecificoImpDefAmbiente(strEspDoc))) Then
      Begin
        pImprimeFatImp('FATDOR',
                        strNumDoc,
                        strEspDoc,
                        strCodEmpPar,
                        strCodCli,
                        'C',
                        '',
                        False,
                        strNomeArquivo,
                        False,
                        strTipExp, //P=PDF, E=Excel, C=CalcBrOffice
                        1,
                        opcComSemPreco,
                        0,
                        False,
                        False,
                        True,
                        blnQtdOri,
                        '',
                        '',
                        blnDocCancelado, {Documento Cancelado}
                        False,
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
                        strNomEmp,
                        strOrdem,
                        False,
                        opcNaoAgrupa,
                        False,
                        '',
                        '',
                        False,
                        False,
                        False,
                        'PedidoOrcamento',
                        False,
                        True,
                        False,
                        False,
                        False,
                        True,
                        False,
                        '',
                        '',
                        strEmpCabecalho_CD,
                        blnCabecalhoCD);
      End;

      Result := strNomeArquivo;

      If (fEmptyStr(Result)) Then
      Begin
        pImprimeFatImp('FATDOR',
                       strNumDoc,
                       strEspDoc,
                       strCodEmpPar,
                       strCodCli,
                       'C',
                       '',
                       False,
                       strNomeArquivo,
                       False,
                       'V', //P=PDF, E=Excel, C=CalcBrOffice
                       1,
                       opcComSemPreco,
                       0,
                       False,
                       False,
                       True,
                       blnQtdOri,
                       '',
                       '',
                       blnDocCancelado, {Documento Cancelado}
                       False,
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
                       strNomEmp,
                       strOrdem,
                       False,
                       opcNaoAgrupa,
                       False,
                       '',
                       '',
                       False,
                       False,
                       True,
                       'PedidoOrcamento',
                       False,
                       True,
                       False,
                       False,
                       False,
                       True,
                       False,
                       '',
                       '',
                       strEmpCabecalho_CD,
                       blnCabecalhoCD);

      End;

      Result := strNomeArquivo;

    End;
  End
  Else
  Begin
    blnTemServicos := False;

    strMskDecUnit := fMskDigitos(fCfgSis('DECUNI', varInteger));

    FstrEspDoc := strEspDoc;

    If fEmptyStr(strCodEmpPar) Then
      strCodEmpPar := VS_strCodEmp;

    strEmp_CD := fCfgSis('EMP_CD', varString, strCodEmpPar);

    blnEmpFat := fCfgSis('EMPFAT', varBoolean);

    blnPreco := opcComSemPreco In [impComPrecoGeral, impComPrecoSemMarca];

    blnImpVol := SameText(strEspDoc, 'PD') And (fCfgSis('TIPVOL') = '2');

    Try

      qryTitulo         := fCriaQuery;
      qryCabecalho      := fCriaQuery;
      qryItens          := fCriaQuery;
      qryDuplicatas     := fCriaQuery;
      qryComplementares := fCriaQuery;
      qryTotais         := fCriaQuery;

      frxCabecalho.DataSet := qryCabecalho;
      frxTitulo.DataSet    := qryTitulo;
      frxItens.DataSet     := qryItens;

      {*******************************************}
      {* TITULO : INFORMAÇÕES DA EMPRESA         *}
      {****************************************JB*}
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

      {********************************************}
      {* VERIFICA SE IRÁ IMPRIMIR O NOME FANTASIA *}
      {* OU RAZÃO SOCIAL DA EMPRESA.              *}
      {*****************************************PZ*}
      If (strNomEmp = 'F') Then
        strSQL := strSQL + '  EMP_NOMFAN AS EMP_NOMEMP, '
      Else
        strSQL := strSQL + '  EMP_NOMEMP, ';

      strSQL := strSQL + '  CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP)), " - ", EMP_BAIRRO) AS EMP_ENDERE, ';
      strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, "-", CADCID.CID_ESTADO, "   CEP: ", EMP_C_E_P_) AS EMP_NOMCID, ';
      strSQL := strSQL + '  EMP_FONE01, ';
      strSQL := strSQL + '  EMP_F_A_X_, ';
      strSQL := strSQL + '  EMP_C_G_C_, ';
      strSQL := strSQL + '  EMP_EMAILV AS EMP_EMAIL_ ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADEMP, ';
      strSQL := strSQL + '  CADCID ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CADEMP.EMP_CODCID = CADCID.CID_CODCID AND ';
      strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

      With qryTitulo Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        If (blnCabecalhoCD) And (Not fEmptyStr(strEmp_CD)) Then
          ParamByName('CODEMP').AsString := strEmp_CD
        Else
          ParamByName('CODEMP').AsString := strCodEmpPar;

        Open;
      End;

      {*******************************************}
      {* CABEÇALHO : INFORMAÇÕES DO CLIENTE      *}
      {****************************************AC*}
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  G.AUTOINCREM, ';
      strSQL := strSQL + '  FGO_CODEMP AS CODEMP, ';
      strSQL := strSQL + '  FGO_CODCLI AS CODCLI, ';
      strSQL := strSQL + '  IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "", C.CLI_NOMCLI, G.FGO_NOMCON) AS NOMCLI, ';
      strSQL := strSQL + '  IF(C.CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR C.CLI_NOMCLI LIKE "%SEGURADORA%", "", C.CLI_FANSOB) AS FANSOB, ';
      strSQL := strSQL + '  IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "", CONCAT(C.CLI_ENDERE, IF(IFNULL(C.CLI_ENDNUM, "") = "", "", CONCAT(", ", C.CLI_ENDNUM)) ), G.FGO_ENDCON) AS ENDERE, ';
      strSQL := strSQL + '  I.CID_NOMCID AS NOMCID, ';
      strSQL := strSQL + '  I.CID_ESTADO AS ESTADO, ';
      strSQL := strSQL + '  IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "", C.CLI_CGCCPF, G.FGO_CGCCPF) AS CGCCPF, ';
      strSQL := strSQL + '  IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "", C.CLI_C_G_C_, G.FGO_CGCCON) AS C_G_C_, ';
      strSQL := strSQL + '  IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "", C.CLI_FONE01, G.FGO_TELCON) AS FONE01, ';
      strSQL := strSQL + '  IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "", C.CLI_BAIRRO, G.FGO_BAICON) AS BAIRRO, ';
      strSQL := strSQL + '  IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "", C.CLI_C_E_P_, G.FGO_CEPCON) AS C_E_P_, ';
      strSQL := strSQL + '  IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "", IF(COALESCE(C.CLI_I_E_S_, "") = "", C.CLI_NUMR_G, C.CLI_I_E_S_), IF(COALESCE(G.FGO_IESCON, "") = "", G.FGO_R_GCON, G.FGO_IESCON)) AS I_E_S_, ';
      strSQL := strSQL + '  O.OPE_NOMOPE AS NOMOPE, ';
      strSQL := strSQL + '  IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "", C.CLI_EMAIL_, G.FGO_EMLCON) AS EMAIL_, ';
      strSQL := strSQL + '  C.CLI_ORGPUB AS ORGPUB, ';
      strSQL := strSQL + '  G.FGO_NUMDOC AS NUMDOC, ';
      strSQL := strSQL + '  G.FGO_ESPDOC AS ESPDOC, ';
      strSQL := strSQL + '  G.FGO_VLRCON AS VLRCON, ';
      strSQL := strSQL + '  G.FGO_TOTPRO AS TOTPRO, ';
      strSQL := strSQL + '  G.FGO_TOTIPI AS TOTIPI, ';
      strSQL := strSQL + '  G.FGO_TOTRET AS TOTRET, ';

      If fSomarNovosImpostosDaReformaAoValorContabil Then
        strSQL := strSQL + '  IFNULL(E.FGO_TOTCBS, 0) + IFNULL(E.FGO_TOTIBS, 0) + IFNULL(E.FGO_TOT_IS, 0) AS TOTREF, '
      Else
        strSQL := strSQL + '  0.00 AS TOTREF, ';

      strSQL := strSQL + '  G.FGO_DESESP AS DESESP, ';
      strSQL := strSQL + '  G.FGO_PORDES AS PORDES, ';
      strSQL := strSQL + '  G.FGO_CONPAG AS CONPAG, ';

      strSQL := strSQL + '  G.FGO_VPAR01 AS VPAR01, ';
      strSQL := strSQL + '  G.FGO_VPAR02 AS VPAR02, ';
      strSQL := strSQL + '  G.FGO_VPAR03 AS VPAR03, ';
      strSQL := strSQL + '  G.FGO_VPAR04 AS VPAR04, ';
      strSQL := strSQL + '  G.FGO_VPAR05 AS VPAR05, ';
      strSQL := strSQL + '  G.FGO_VPAR06 AS VPAR06, ';
      strSQL := strSQL + '  G.FGO_VPAR07 AS VPAR07, ';
      strSQL := strSQL + '  G.FGO_VPAR08 AS VPAR08, ';
      strSQL := strSQL + '  G.FGO_VPAR09 AS VPAR09, ';
      strSQL := strSQL + '  G.FGO_VPAR10 AS VPAR10, ';
      strSQL := strSQL + '  G.FGO_VPAR11 AS VPAR11, ';
      strSQL := strSQL + '  G.FGO_VPAR12 AS VPAR12, ';

      strSQL := strSQL + '  G.FGO_TOTFRE AS TOTFRE, ';
      strSQL := strSQL + '  G.FGO_MEN001 AS MEN001, ';
      strSQL := strSQL + '  G.FGO_MEN002 AS MEN002, ';
      strSQL := strSQL + '  E.FGO_VALORC AS VALORC, ';

      {***********************************************}
      {* MOSTRANDO TIPO DE FRETE NO PEDIDO/ORÇAMENTO *}
      {********************************************RV*}
      strSQL := strSQL + '  CASE G.FGO_TIPFRE              ';
      strSQL := strSQL + '    WHEN "1" THEN "EMITENTE(CIF)"     ';
      strSQL := strSQL + '    WHEN "2" THEN "DESTINATARIO(FOB)" ';
      strSQL := strSQL + '    WHEN "3" THEN "TERCEIROS" ';
      strSQL := strSQL + '    WHEN "9" THEN "SEM FRETE" ';
      strSQL := strSQL + '  END AS TIPFRE,                 ';

      strSQL := strSQL + '  G.FGO_DTAENT AS DTAENT, ';
      strSQL := strSQL + '  G.FGO_PREVIS AS PREVIS, ';
      strSQL := strSQL + '  G.FGO_TIPFAT AS TIPFAT, ';
      strSQL := strSQL + '  G.FGO_JAFATU AS JAFATU, ';
      strSQL := strSQL + '  G.FGO_NUMFAT AS NUMFAT, ';
      strSQL := strSQL + '  G.FGO_EMPFAT AS EMPFAT, ';

      strSQL := strSQL + '  C.CLI_CODREP AS CODREP, ';
      strSQL := strSQL + '  R.OPE_NOMOPE AS REPRES, ';
      {*******************************}
      {* CAMPOS REFERENTE AO SERVIÇO *}
      {****************************JB*}
      strSQL := strSQL + '  G.FGO_CODS01 AS CODS01, ';
      strSQL := strSQL + '  G.FGO_CODS02 AS CODS02, ';
      strSQL := strSQL + '  G.FGO_CODS03 AS CODS03, ';
      strSQL := strSQL + '  G.FGO_CODS04 AS CODS04, ';
      strSQL := strSQL + '  G.FGO_CODS05 AS CODS05, ';
      strSQL := strSQL + '  G.FGO_CODS06 AS CODS06, ';
      strSQL := strSQL + '  S.FGO_CODS07 AS CODS07, ';
      strSQL := strSQL + '  S.FGO_CODS08 AS CODS08, ';
      strSQL := strSQL + '  S.FGO_CODS09 AS CODS09, ';
      strSQL := strSQL + '  S.FGO_CODS10 AS CODS10, ';
      strSQL := strSQL + '  S.FGO_CODS11 AS CODS11, ';
      strSQL := strSQL + '  S.FGO_CODS12 AS CODS12, ';
      strSQL := strSQL + '  S.FGO_CODS13 AS CODS13, ';
      strSQL := strSQL + '  S.FGO_CODS14 AS CODS14, ';
      strSQL := strSQL + '  S.FGO_CODS15 AS CODS15, ';
      strSQL := strSQL + '  S.FGO_CODS16 AS CODS16, ';
      strSQL := strSQL + '  S.FGO_CODS17 AS CODS17, ';
      strSQL := strSQL + '  S.FGO_CODS18 AS CODS18, ';
      strSQL := strSQL + '  S.FGO_CODS19 AS CODS19, ';
      strSQL := strSQL + '  S.FGO_CODS20 AS CODS20, ';
      strSQL := strSQL + '  S.FGO_CODS21 AS CODS21, ';
      strSQL := strSQL + '  S.FGO_CODS22 AS CODS22, ';
      strSQL := strSQL + '  S.FGO_CODS23 AS CODS23, ';
      strSQL := strSQL + '  S.FGO_CODS24 AS CODS24, ';
      strSQL := strSQL + '  S.FGO_CODS25 AS CODS25, ';
      strSQL := strSQL + '  S.FGO_CODS26 AS CODS26, ';
      strSQL := strSQL + '  S.FGO_CODS27 AS CODS27, ';
      strSQL := strSQL + '  S.FGO_CODS28 AS CODS28, ';
      strSQL := strSQL + '  S.FGO_CODS29 AS CODS29, ';
      strSQL := strSQL + '  S.FGO_CODS30 AS CODS30, ';

      strSQL := strSQL + '  G.FGO_DESS01 AS DESS01, ';
      strSQL := strSQL + '  G.FGO_DESS02 AS DESS02, ';
      strSQL := strSQL + '  G.FGO_DESS03 AS DESS03, ';
      strSQL := strSQL + '  G.FGO_DESS04 AS DESS04, ';
      strSQL := strSQL + '  G.FGO_DESS05 AS DESS05, ';
      strSQL := strSQL + '  G.FGO_DESS06 AS DESS06, ';
      strSQL := strSQL + '  S.FGO_DESS07 AS DESS07, ';
      strSQL := strSQL + '  S.FGO_DESS08 AS DESS08, ';
      strSQL := strSQL + '  S.FGO_DESS09 AS DESS09, ';
      strSQL := strSQL + '  S.FGO_DESS10 AS DESS10, ';
      strSQL := strSQL + '  S.FGO_DESS11 AS DESS11, ';
      strSQL := strSQL + '  S.FGO_DESS12 AS DESS12, ';
      strSQL := strSQL + '  S.FGO_DESS13 AS DESS13, ';
      strSQL := strSQL + '  S.FGO_DESS14 AS DESS14, ';
      strSQL := strSQL + '  S.FGO_DESS15 AS DESS15, ';
      strSQL := strSQL + '  S.FGO_DESS16 AS DESS16, ';
      strSQL := strSQL + '  S.FGO_DESS17 AS DESS17, ';
      strSQL := strSQL + '  S.FGO_DESS18 AS DESS18, ';
      strSQL := strSQL + '  S.FGO_DESS19 AS DESS19, ';
      strSQL := strSQL + '  S.FGO_DESS20 AS DESS20, ';
      strSQL := strSQL + '  S.FGO_DESS21 AS DESS21, ';
      strSQL := strSQL + '  S.FGO_DESS22 AS DESS22, ';
      strSQL := strSQL + '  S.FGO_DESS23 AS DESS23, ';
      strSQL := strSQL + '  S.FGO_DESS24 AS DESS24, ';
      strSQL := strSQL + '  S.FGO_DESS25 AS DESS25, ';
      strSQL := strSQL + '  S.FGO_DESS26 AS DESS26, ';
      strSQL := strSQL + '  S.FGO_DESS27 AS DESS27, ';
      strSQL := strSQL + '  S.FGO_DESS28 AS DESS28, ';
      strSQL := strSQL + '  S.FGO_DESS29 AS DESS29, ';
      strSQL := strSQL + '  S.FGO_DESS30 AS DESS30, ';

      strSQL := strSQL + '  G.FGO_VALS01 AS VALS01, ';
      strSQL := strSQL + '  G.FGO_VALS02 AS VALS02, ';
      strSQL := strSQL + '  G.FGO_VALS03 AS VALS03, ';
      strSQL := strSQL + '  G.FGO_VALS04 AS VALS04, ';
      strSQL := strSQL + '  G.FGO_VALS05 AS VALS05, ';
      strSQL := strSQL + '  G.FGO_VALS06 AS VALS06, ';
      strSQL := strSQL + '  S.FGO_VALS07 AS VALS07, ';
      strSQL := strSQL + '  S.FGO_VALS08 AS VALS08, ';
      strSQL := strSQL + '  S.FGO_VALS09 AS VALS09, ';
      strSQL := strSQL + '  S.FGO_VALS10 AS VALS10, ';
      strSQL := strSQL + '  S.FGO_VALS11 AS VALS11, ';
      strSQL := strSQL + '  S.FGO_VALS12 AS VALS12, ';
      strSQL := strSQL + '  S.FGO_VALS13 AS VALS13, ';
      strSQL := strSQL + '  S.FGO_VALS14 AS VALS14, ';
      strSQL := strSQL + '  S.FGO_VALS15 AS VALS15, ';
      strSQL := strSQL + '  S.FGO_VALS16 AS VALS16, ';
      strSQL := strSQL + '  S.FGO_VALS17 AS VALS17, ';
      strSQL := strSQL + '  S.FGO_VALS18 AS VALS18, ';
      strSQL := strSQL + '  S.FGO_VALS19 AS VALS19, ';
      strSQL := strSQL + '  S.FGO_VALS20 AS VALS20, ';
      strSQL := strSQL + '  S.FGO_VALS21 AS VALS21, ';
      strSQL := strSQL + '  S.FGO_VALS22 AS VALS22, ';
      strSQL := strSQL + '  S.FGO_VALS23 AS VALS23, ';
      strSQL := strSQL + '  S.FGO_VALS24 AS VALS24, ';
      strSQL := strSQL + '  S.FGO_VALS25 AS VALS25, ';
      strSQL := strSQL + '  S.FGO_VALS26 AS VALS26, ';
      strSQL := strSQL + '  S.FGO_VALS27 AS VALS27, ';
      strSQL := strSQL + '  S.FGO_VALS28 AS VALS28, ';
      strSQL := strSQL + '  S.FGO_VALS29 AS VALS29, ';
      strSQL := strSQL + '  S.FGO_VALS30 AS VALS30, ';

      strSQL := strSQL + '  G.FGO_TOTSER AS TOTSER, ';
      strSQL := strSQL + '  G.FGO_PERISS AS PERISS, ';
      strSQL := strSQL + '  G.FGO_VALISS AS VALISS, ';
      strSQL := strSQL + '  G.FGO_PESBRU AS PESBRU, ';
      strSQL := strSQL + '  G.FGO_DESACE AS DESACE, ';
      strSQL := strSQL + '  CONCAT(G.FGO_CODTRA,"-",T.TRA_NOMTRA) AS TRANSP, ';
      strSQL := strSQL + '  T.TRA_ENDERE AS ENDTRA, ';
      strSQL := strSQL + '  T.TRA_BAIRRO AS BAITRA, ';
      strSQL := strSQL + '  T.TRA_C_E_P_ AS CEPTRA, ';
      strSQL := strSQL + '  CT.CID_NOMCID AS CIDTRA, ';
      strSQL := strSQL + '  CT.CID_ESTADO AS ESTTRA  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  FATGOR G ';
      strSQL := strSQL + '  JOIN EXTGOR E ON (E.FGO_SEQFGO = G.AUTOINCREM) ';
      strSQL := strSQL + '  JOIN CADCLI C ON G.FGO_CODCLI = C.CLI_CODCLI ';
      strSQL := strSQL + '  JOIN CADOPE O ON G.FGO_CODVEN = O.OPE_CODOPE ';
      strSQL := strSQL + '  JOIN CADCID I ON IF(G.FGO_NOMCON IS NULL OR G.FGO_NOMCON = "",C.CLI_CODCID,G.FGO_CIDCON) = I.CID_CODCID ';
      strSQL := strSQL + '  LEFT JOIN SERGOR S ON S.FGO_SEQFGO = G.AUTOINCREM ';
      strSQL := strSQL + '  LEFT JOIN CADTRA AS T ON G.FGO_CODTRA = T.TRA_CODTRA ';
      strSQL := strSQL + '  LEFT JOIN CADCID AS CT ON T.TRA_CODCID = CT.CID_CODCID ';
      strSQL := strSQL + '  LEFT JOIN CADOPE AS R ON R.OPE_CODOPE = C.CLI_CODREP ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  G.FGO_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  G.FGO_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  G.FGO_CODEMP = :CODEMP ';

      With qryCabecalho Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmpPar;
        Open;

        FfltDesCli := 0;
        FstrCodCli := FieldByName('CODCLI').AsString;

        If (Pos(FstrEspDoc, 'OR_PD_') > 0) And (fDescontoCliente) Then
        Begin
          If fCfgSis('PDVLBR') = '1' Then
            FfltDesCli := fRetPorDesDocVenda(strNumDoc, strEspDoc, strCodEmpPar, FieldByName('CODCLI').AsString)
          Else If fCfgSis('PDVLBR') = '2' Then
            FfltDesCli := fRetDescontoCliente(FieldByName('CODCLI').AsString);
        End;

        {******************************}
        {* CARREGA OS SERVIÇOS        *}
        {***************************JB*}
        If Not cdsServicos.Active Then
          cdsServicos.CreateDataSet;

        For intQtdSer := 1 To 30 Do
        Begin
          If Not fEmptyStr(FieldByName('CODS' + fStrZero(intQtdSer, 2)).AsString) Then
          Begin
            cdsServicos.Append;
            cdsServicosCODSER.AsString := FieldByName('CODS' + fStrZero(intQtdSer, 2)).AsString;
            cdsServicosDESSER.AsString := FieldByName('DESS' + fStrZero(intQtdSer, 2)).AsString;
            cdsServicosVALSER.AsFloat  := FieldByName('VALS' + fStrZero(intQtdSer, 2)).AsFloat;
            cdsServicosTOTSER.AsFloat  := FieldByName('TOTSER').AsFloat;
            cdsServicosPERISS.AsFloat  := FieldByName('PERISS').AsFloat;
            cdsServicosVALISS.AsFloat  := FieldByName('VALISS').AsFloat;
            cdsServicos.Post;
          End;
        End;

        First;

        cdsServicos.Open;

      End;

      {*******************************************}
      {* ITENS : INFORMAÇÕES DOS ITENS           *}
      {****************************************AC*}
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

      If fCfgSis('CLIPRO',varBoolean) And (opcPdOrNf in fRetUtilizaCliPro) Then
      Begin
        If blnEmpFat Then
          strSQL := strSQL + '  CONCAT(IFNULL(FDO_EMPITE, FDO_CODEMP), "  ", IFNULL(P.CLI_COD_NF,D.FDO_CODITE)) AS CODITE, '
        Else
          strSQL := strSQL + '  IFNULL(P.CLI_COD_NF,D.FDO_CODITE) AS CODITE, ';
      End
      Else
      Begin
        If blnEmpFat Then
          strSQL := strSQL + '  CONCAT(IFNULL(FDO_EMPITE, FDO_CODEMP), "  ", D.FDO_CODITE) AS CODITE, '
        Else
          strSQL := strSQL + '  D.FDO_CODITE AS CODITE, ';
      End;

      strSQL := strSQL + 'IFNULL(I.ITE_CODFAB, '+
                         ' (SELECT CONCAT( IF( IFNULL(I.ITE_CODFAB,"") <> "", CONCAT(I.ITE_CODFAB, ","), ""), GROUP_CONCAT(IFNULL(IFNULL(ITEFOR.ITE_CODFAB, ITE_CODITF),""))) '+
                         '    FROM ITEFOR '+
                         '   WHERE ITEFOR.ITE_CODITE = I.ITE_CODITE )) CODFAB, ';

      If Not blnLocFis Then Begin
        If fCfgSis('CLIPRO',varBoolean) And (opcPdOrNf in fRetUtilizaCliPro) Then
          strSQL := strSQL + '  CONCAT(IFNULL(P.CLI_DES_NF, D.FDO_DESCRI), IF(IFNULL(D.FDO_COMPLE,"") <> "", CONCAT(" ", D.FDO_COMPLE), "")) AS DESCRI, '
        Else
          strSQL := strSQL + '  CONCAT(D.FDO_DESCRI, IF(IFNULL(D.FDO_COMPLE,"") <> "", CONCAT(" ", D.FDO_COMPLE), "")) AS DESCRI, ';
      End Else Begin
        If fCfgSis('CLIPRO',varBoolean) And (opcPdOrNf in fRetUtilizaCliPro) Then
          strSQL := strSQL + '  CONCAT(IFNULL(P.CLI_DES_NF, D.FDO_DESCRI), '
        Else
          strSQL := strSQL + '  CONCAT(D.FDO_DESCRI, ';

        strSQL := strSQL + '           IF(IFNULL(D.FDO_COMPLE,"") <> "", CONCAT(" ", D.FDO_COMPLE), ""), ';
        strSQL := strSQL + '           IF(IFNULL(ITE_LOCFIS, "") = "", "", CONCAT(" - LOC. FISICA: ", ITE_LOCFIS, IF(IFNULL(ITE_LOCSUP, "") = "","",CONCAT(" / LOC. SUPER ESTOQUE: ", ITE_LOCSUP)))) ';
        strSQL := strSQL + '        ) AS DESCRI, ';
      End;

      strSQL := strSQL + '  M.MAR_DESMAR AS DESMAR, ';
      strSQL := strSQL + '  U.UNI_SIGUNI AS SIGUNI, ';
      strSQL := strSQL + '  D.FDO_QTDITE AS QTDITE, ';

      strSQL := strSQL + '  MD.FDO_APAREL AS APAREL, ';
      strSQL := strSQL + '  MD.FDO_BENEFI AS BENEFI, ';
      strSQL := strSQL + '  MD.FDO_QTDPEC AS QTDPEC, ';
      strSQL := strSQL + '  MD.FDO_COMPEC AS COMPEC, ';
      strSQL := strSQL + '  MD.FDO_LARPEC AS LARPEC, ';
      strSQL := strSQL + '  MD.FDO_ESPPEC AS ESPPEC, ';
      strSQL := strSQL + '  D.FDO_UNITAR  AS UNITAR, ';

      If fCfgSis('TIPDES') = '%' Then
        strSQL := strSQL + '  IF(D.FDO_DESCON < 0, D.FDO_UNIDIG + (((D.FDO_UNIDIG * D.FDO_DESCON) / 100) * -1), D.FDO_UNIDIG) AS UNIDIG, '
      Else
        strSQL := strSQL + '  D.FDO_UNIDIG + ABS(D.FDO_DESCON) AS UNIDIG,  ';

      If (fCfgSis('MODORD',varString) = '3') Then
        strSQL := strSQL + ' FDO_UNIORI - IF(D.FDO_DESCON > 0, D.FDO_UNITAR, D.FDO_UNIDIG) AS DESCON, '
      Else
        strSQL := strSQL + '  IF(D.FDO_DESCON < 0, 0.00, D.FDO_DESCON) AS DESCON, ';

      strSQL := strSQL + '  D.FDO_TOTITE AS TOTITE, ';
      strSQL := strSQL + '  I.ITE_CLAIPI AS CLAIPI, ';
      strSQL := strSQL + '  I.ITE_DESSIM AS DESSIM, ';
      strSQL := strSQL + '  FATGOR.FGO_TOTFRE AS TOTFRE, ';
      strSQL := strSQL + '  D.FDO_SEQGER,                ';
      strSQL := strSQL + '  D.FDO_ALQIPI AS ALQIPI, ';
      strSQL := strSQL + '  D.FDO_VALIPI AS VALIPI, ';
      strSQL := strSQL + '  D.FDO_ALQICM AS ALQICM, ';
      strSQL := strSQL + '  D.FDO_CODFIS AS CODFIS, ';
      strSQL := strSQL + '  IF(ITE_MLTVEN > 0, D.FDO_QTDITE / ITE_MLTVEN, 0) AS VOLITE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  FATDOR D ';
      strSQL := strSQL + '  JOIN CADITE I ON D.FDO_CODITE = I.ITE_CODITE ';
      strSQL := strSQL + '  JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR ';
      strSQL := strSQL + '  JOIN FATGOR ON FATGOR.AUTOINCREM = D.FDO_SEQGER ';
      strSQL := strSQL + '  JOIN ITEGER ON ITEGER.ITE_CODITE = D.FDO_CODITE AND ';
      strSQL := strSQL + '                 ITEGER.ITE_CODEMP = D.FDO_CODEMP ';
      strSQL := strSQL + '  LEFT JOIN ORCMAD MD ON MD.FDO_SEQGER = D.AUTOINCREM  ';

      If fCfgSis('CLIPRO',varBoolean) And (opcPdOrNf in fRetUtilizaCliPro) Then
      Begin
        strSQL := strSQL + '  LEFT JOIN CLIPRO P ON P.CLI_CODCLI = D.FDO_CODCLI AND ';
        strSQL := strSQL + '                        P.CLI_CODITE = D.FDO_CODITE AND ';
        strSQL := strSQL + '                        P.CLI_CODEMP = D.FDO_CODEMP ';
        strSQL := strSQL + '  JOIN CADUNI U ON COALESCE(P.CLI_CODUNI, I.ITE_CODUNI) = U.UNI_CODUNI ';
      End
      else
        strSQL := strSQL + '  JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  D.FDO_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  D.FDO_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  D.FDO_CODEMP = :CODEMP ';
      strSQL := strSQL + 'GROUP BY ';
      strSQL := strSQL + '  CODITE ';

      With qryItens Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmpPar;
        Open;
      End;

      blnSomenteServ := True;
      With qryItens Do
      Begin
        First;
        While Not Eof Do
        Begin
          If Not fEhItemServico(qryItens.FieldByName('CODITE').AsString) Then
          Begin
            blnSomenteServ := False;
            Break;
          End
          Else
            blnTemServicos := True;
          Next;
        End;
        First;
      End;

      If Not (blnTemServicos And blnSomenteServ) Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

        If fCfgSis('CLIPRO',varBoolean) And (opcPdOrNf in fRetUtilizaCliPro) Then
        Begin
          If blnEmpFat Then
            strSQL := strSQL + '  CONCAT(IFNULL(FDO_EMPITE, FDO_CODEMP), "  ", IFNULL(P.CLI_COD_NF,D.FDO_CODITE)) AS CODITE, '
          Else
            strSQL := strSQL + '  IFNULL(P.CLI_COD_NF,D.FDO_CODITE) AS CODITE, ';
        End
        Else
        Begin
          If blnEmpFat Then
            strSQL := strSQL + '  CONCAT(IFNULL(FDO_EMPITE, FDO_CODEMP), "  ", D.FDO_CODITE) AS CODITE, '
          Else
            strSQL := strSQL + '  D.FDO_CODITE AS CODITE, ';
        End;

        strSQL := strSQL + 'IFNULL(I.ITE_CODFAB, '+
                           ' (SELECT CONCAT( IF( IFNULL(I.ITE_CODFAB,"") <> "", CONCAT(I.ITE_CODFAB, ","), ""), GROUP_CONCAT(IFNULL(IFNULL(ITEFOR.ITE_CODFAB, ITE_CODITF),""))) '+
                           '    FROM ITEFOR '+
                           '   WHERE ITEFOR.ITE_CODITE = I.ITE_CODITE )) CODFAB, ';

        If Not blnLocFis Then Begin
          If fCfgSis('CLIPRO', varBoolean) And (opcPdOrNf in fRetUtilizaCliPro) Then
            strSQL := strSQL + ' CONCAT(IFNULL(P.CLI_DES_NF, D.FDO_DESCRI), IF(IFNULL(D.FDO_COMPLE,"") <> "", CONCAT(" ", D.FDO_COMPLE), "")) AS DESCRI, '
          Else
            strSQL := strSQL + ' CONCAT(D.FDO_DESCRI, IF(IFNULL(D.FDO_COMPLE,"") <> "", CONCAT(" ", D.FDO_COMPLE), "")) AS DESCRI, ';
        End Else Begin
          If fCfgSis('CLIPRO', varBoolean) And (opcPdOrNf in fRetUtilizaCliPro) Then
            strSQL := strSQL + '  CONCAT(IFNULL(P.CLI_DES_NF, D.FDO_DESCRI), '
          Else
            strSQL := strSQL + '  CONCAT(D.FDO_DESCRI, ';

          strSQL := strSQL + '           IF(IFNULL(D.FDO_COMPLE,"") <> "", CONCAT(" ", D.FDO_COMPLE), ""), ';
          strSQL := strSQL + '           IF(IFNULL(ITE_LOCFIS, "") = "", "", CONCAT(" - LOC. FISICA: ", ITE_LOCFIS, IF(IFNULL(ITE_LOCSUP, "") = "","",CONCAT(" / LOC. SUPER ESTOQUE: ", ITE_LOCSUP)))) ';
          strSQL := strSQL + '        ) AS DESCRI, ';
        end;

        strSQL := strSQL + '  M.MAR_DESMAR AS DESMAR, ';
        strSQL := strSQL + '  U.UNI_SIGUNI AS SIGUNI, ';
        strSQL := strSQL + '  D.FDO_QTDITE AS QTDITE, ';

        strSQL := strSQL + '  MD.FDO_APAREL AS APAREL, ';
        strSQL := strSQL + '  MD.FDO_BENEFI AS BENEFI, ';
        strSQL := strSQL + '  MD.FDO_QTDPEC AS QTDPEC, ';
        strSQL := strSQL + '  MD.FDO_COMPEC AS COMPEC, ';
        strSQL := strSQL + '  MD.FDO_LARPEC AS LARPEC, ';
        strSQL := strSQL + '  MD.FDO_ESPPEC AS ESPPEC, ';
        strSQL := strSQL + '  D.FDO_UNITAR  AS UNITAR, ';

        If fCfgSis('TIPDES') = '%' Then
          strSQL := strSQL + '  IF(D.FDO_DESCON < 0, D.FDO_UNIDIG + (((D.FDO_UNIDIG * D.FDO_DESCON) / 100) * -1), D.FDO_UNIDIG) AS UNIDIG, '
        Else
          strSQL := strSQL + '  D.FDO_UNIDIG + ABS(D.FDO_DESCON) AS UNIDIG,  ';

        If (fCfgSis('MODORD',varString) = '3') Then
          strSQL := strSQL + ' FDO_UNIORI - IF(D.FDO_DESCON > 0, D.FDO_UNITAR, D.FDO_UNIDIG) AS DESCON, '
        Else
          strSQL := strSQL + '  IF(D.FDO_DESCON < 0, 0.00, D.FDO_DESCON) AS DESCON, ';

        strSQL := strSQL + '  I.ITE_DESSIM AS DESSIM, ';
        strSQL := strSQL + '  D.FDO_TOTITE AS TOTITE, ';
        strSQL := strSQL + '  D.FDO_ALQIPI AS ALQIPI, ';
        strSQL := strSQL + '  D.FDO_VALIPI AS VALIPI, ';
        strSQL := strSQL + '  D.FDO_ALQICM AS ALQICM, ';
        strSQL := strSQL + '  D.FDO_CODFIS AS CODFIS, ';
        strSQL := strSQL + '  I.ITE_CLAIPI AS CLAIPI, ';
        strSQL := strSQL + '  IF(ITE_MLTVEN > 0, D.FDO_QTDITE / ITE_MLTVEN, 0) AS VOLITE ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  FATDOR D ';
        strSQL := strSQL + '  JOIN CADITE I ON D.FDO_CODITE = I.ITE_CODITE ';
        strSQL := strSQL + '  JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR ';
        strSQL := strSQL + '  LEFT JOIN FATGOR ON FATGOR.AUTOINCREM = D.FDO_SEQGER ';
        strSQL := strSQL + '  LEFT JOIN ORCMAD MD ON MD.FDO_SEQGER = D.AUTOINCREM ';
        strSQL := strSQL + '  JOIN ITEGER ON ITEGER.ITE_CODITE = D.FDO_CODITE AND ';
        strSQL := strSQL + '                 ITEGER.ITE_CODEMP = D.FDO_CODEMP ';

        If fCfgSis('CLIPRO',varBoolean) And (opcPdOrNf in fRetUtilizaCliPro) Then
        Begin
          strSQL := strSQL + '  LEFT JOIN CLIPRO P ON P.CLI_CODCLI = D.FDO_CODCLI AND ';
          strSQL := strSQL + '                        P.CLI_CODITE = D.FDO_CODITE AND ';
          strSQL := strSQL + '                        P.CLI_CODEMP = D.FDO_CODEMP ';
          strSQL := strSQL + '  JOIN CADUNI U ON COALESCE(P.CLI_CODUNI, I.ITE_CODUNI) = U.UNI_CODUNI ';
        End
        Else
          strSQL := strSQL + '  JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';

        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  D.FDO_NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + '  D.FDO_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '  D.FDO_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '  D.FDO_CODITE <> :ITESER AND ';
        strSQL := strSQL + '  D.FDO_CODITE <> :SERTER     ';


        If Not fEmptyStr(strOrdem) Then
        Begin
          strSQL := strSQL + '  ORDER BY ';

          Case strOrdem[1] Of
            '1': strSQL := strSQL + '   D.AUTOINCREM ';
            '2': strSQL := strSQL + '   D.FDO_DESCRI ';
            '3': strSQL := strSQL + '   U.UNI_SIGUNI, D.FDO_DESCRI ';
            Else strSQL := strSQL + '   D.FDO_DESCRI ';
          End;

        End;

        With qryItens Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NUMDOC').AsString := strNumDoc;
          ParamByName('ESPDOC').AsString := strEspDoc;
          ParamByName('CODEMP').AsString := strCodEmpPar;
          ParamByName('ITESER').AsString := fCfgSis('ITESER');
          ParamByName('SERTER').AsString := fCfgSis('SERTER');
          Open;
        End;
      End;

      {***********************************}
      {* MONTA CLASSIFICAÇÃO DE IPI      *}
      {********************************AF*}
      qryItens.First;
      While Not qryItens.Eof Do
      Begin
        If Not fEmptyStr(qryItens.FieldByName('CLAIPI').AsString) Then
          stlClaIpi.Add(qryItens.FieldByName('CLAIPI').AsString);

        qryItens.Next;
      End;
        qryItens.First;

      {*******************************************}
      {* GERA MATRIZ DE DUPLICATAS               *}
      {****************************************MV*}
      If (fEmptyStr(qryCabecalho.FieldByName('CONPAG').AsString))               Or
         (fStatusCndPag(qryCabecalho.FieldByName('CONPAG').AsString) = A_VISTA) Then
      Begin
        pZeraDigDuplic(arrDuplicata);
      End
      Else
      Begin
        fltTotGeral := qryCabecalho.FieldByName('VLRCON').AsFloat;

        If fDescontoCliente Then
          fltTotGeral := qryCabecalho.FieldByName('VLRCON').AsFloat -
                         qryCabecalho.FieldByName('TOTPRO').AsFloat +
                         qryCabecalho.FieldByName('TOTPRO').AsFloat / (1 - FFltDesCli / 100);

        fDigDuplicSemTela( arrDuplicata,
                           intQtdDup,
                           curTotalRes,
                           qryCabecalho.FieldByName('CONPAG').AsString,
                           qryCabecalho.FieldByName('NUMDOC').AsInteger,
                           fltTotGeral,
                           True,
                           False,
                           qryCabecalho.FieldByName('PREVIS').AsDateTime,
                           False );

        If Not fDescontoCliente Then
        Begin
          pCarregaDuplicatasCND(1,qryCabecalho.FieldByName('AUTOINCREM').AsString, arrDuplicataCND);

          For intContador := 0 To 23 Do
            arrDuplicata[intContador].curValor := arrDuplicataCND[intContador].curValor;
        End;
      End;

      If Not cdsDuplicatas.Active Then
        cdsDuplicatas.CreateDataSet;

      For intContador := 0 To 5 Do
      Begin

        If (Not fEmptyStr(arrDuplicata[intContador].strSequen)) Or
           ((fStatusCndPag(qryCabecalho.FieldByName('CONPAG').AsString) = A_VISTA) And (IntContador = 0)) Then
        Begin
          cdsDuplicatas.Append;
          If (fStatusCndPag(qryCabecalho.FieldByName('CONPAG').AsString) = A_VISTA) Then
          Begin
            cdsDuplicatasSEQUENCIA.AsString  := 'A VISTA';
            cdsDuplicatasVENCIMENTO.AsString := '';
            cdsDuplicatasVALOR.AsFloat       := qryCabecalho.FieldByName('TOTPRO').AsFloat -
                                                qryCabecalho.FieldByName('DESESP').AsFloat +
                                                qryCabecalho.FieldByName('TOTRET').AsFloat +
                                                cdsServicosTOTSER.AsFloat                  +
                                                qryCabecalho.FieldByName('TOTFRE').AsFloat +
                                                qryCabecalho.FieldByName('DESACE').AsFloat +
                                                qryCabecalho.FieldByName('TOTIPI').AsFloat +
                                                qryCabecalho.FieldByName('TOTREF').AsFloat;
            cdsDuplicatas.Post;
            Break;
          End
          Else
          Begin
            cdsDuplicatasSEQUENCIA.AsString  := IIF(fEmptyStr(arrDuplicata[intContador].strSequen), '', arrDuplicata[intContador].strSequen + ')');
            cdsDuplicatasVENCIMENTO.AsString := IIF(fEmptyStr(arrDuplicata[intContador].dtaDtaVen), '', arrDuplicata[intContador].dtaDtaVen);
            cdsDuplicatasVALOR.AsFloat       := IIF(fEmptyStr(arrDuplicata[intContador].strSequen), 0, FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2));
          End;
          cdsDuplicatas.Post;
        End;

      End;

      {*******************************************}
      {* INFORMAÇÕES COMPLEMENTARES              *}
      {****************************************AC*}
      If Not cdsComplementares.Active Then
        cdsComplementares.CreateDataSet;

      cdsComplementares.Append;

      If Not fEmptyStr(qryCabecalho.FieldByName('MEN001').AsString) Then
        cdsComplementaresMSGORC.AsString := cdsComplementaresMSGORC.AsString + qryCabecalho.FieldByName('MEN001').AsString + #13;

      If Not fEmptyStr(qryCabecalho.FieldByName('MEN002').AsString) Then
        cdsComplementaresMSGORC.AsString := cdsComplementaresMSGORC.AsString + qryCabecalho.FieldByName('MEN002').AsString + #13;

      If Not fEmptyStr(fCfgSis('MSGORC')) Then
        cdsComplementaresMSGORC.AsString := cdsComplementaresMSGORC.AsString + fCfgSis('MSGORC') + #13;

    {***********************************************}
    {* MOSTRANDO TIPO DE FRETE NO PEDIDO/ORÇAMENTO *}
    {********************************************RV*}
      cdsComplementaresFRETE.AsString    := qryCabecalho.FieldByName('TIPFRE').AsString;
      cdsComplementaresDATA.AsDateTime   := qryCabecalho.FieldByName('DTAENT').AsDateTime;
      cdsComplementaresPREVIS.AsDateTime := qryCabecalho.FieldByName('PREVIS').AsDateTime;
      If fCfgSis('IFVLOR', varBoolean) Then
        cdsComplementaresVALID.AsDateTime  := qryCabecalho.FieldByName('VALORC').AsDateTime
      Else
        cdsComplementaresVALID.AsDateTime  := qryCabecalho.FieldByName('DTAENT').AsDateTime + fCfgSis('ORCVEN');
      cdsComplementaresREPRES.AsString   := qryCabecalho.FieldByName('CODREP').AsString + '-' + qryCabecalho.FieldByName('REPRES').AsString;
      cdsComplementares.Post;

      If cdsDuplicatas.RecordCount > 0 Then
        cdsDuplicatas.Open;
      If cdsComplementares.RecordCount > 0 Then
        cdsComplementares.Open;

      {*******************************************}
      {* TOTAIS                                  *}
      {****************************************AC*}
      If Not cdsTotais.Active Then
        cdsTotais.CreateDataSet;

      cdsTotais.Append;

      cdsTotaisPESBRU.AsFloat := qryCabecalho.FieldByName('PESBRU').AsFloat;

      If (qryCabecalho.FieldByName('DESESP').AsFloat > 0) Then
      Begin
        cdsTotaisTOTAL_PROD.AsFloat := qryCabecalho.FieldByName('TOTPRO').AsFloat;
        cdsTotaisTOTAL_DESC.AsFloat := qryCabecalho.FieldByName('DESESP').AsFloat;
      End
      Else
      Begin
        cdsTotaisTOTAL_PROD.AsFloat := qryCabecalho.FieldByName('TOTPRO').AsFloat;
        cdsTotaisTOTAL_DESC.AsFloat := 0;
      End;

      If (qryCabecalho.FieldByName('TOTFRE').AsFloat > 0) Then
      Begin
        cdsTotaisTOTAL_FRETE.AsFloat := qryCabecalho.FieldByName('TOTFRE').AsFloat;
      End
      Else
        cdsTotaisTOTAL_FRETE.AsFloat := 0;

      cdsTotaisTOTAL_IPI.AsFloat  := qryCabecalho.FieldByName('TOTIPI').AsFloat;

      cdsTotaisTOTAL_RET.AsFloat    := qryCabecalho.FieldByName('TOTRET').AsFloat;

      cdsTotaisTOTAL_DESACE.AsFloat := qryCabecalho.FieldByName('DESACE').AsFloat;

      cdsTotaisTOTAL_PEDORC.AsFloat := qryCabecalho.FieldByName('TOTPRO').AsFloat -
                   qryCabecalho.FieldByName('DESESP').AsFloat +
                   qryCabecalho.FieldByName('TOTRET').AsFloat +
                   cdsServicosTOTSER.AsFloat                  +
                   qryCabecalho.FieldByName('TOTFRE').AsFloat +
                   qryCabecalho.FieldByName('DESACE').AsFloat +
                   qryCabecalho.FieldByName('TOTIPI').AsFloat +
                   qryCabecalho.FieldByName('TOTREF').AsFloat;

      cdsTotaisCOM_IPI.AsString := IIF(cdsTotaisTOTAL_IPI.AsFloat <> 0, 'S', 'N');
      cdsTotais.Post;

      {*******************************************}
      {* SE EXISTIR O ARQUIVO..............      *}
      {* CARREGA O ARQUIVO DA LOGO NO RELATORIO  *}
      {****************************************IV*}
      If FileExists(fCfgSis('PATLOG')) Then
        strDirImagem := fCfgSis('PATLOG')
      Else
        strDirImagem := '';

      If FileExists(fCfgSis('PATCAB')) Then
        strDirImgGde := fCfgSis('PATCAB')
      Else
        strDirImgGde := '';

      {***********************************}
      {* MONTA CLASSIFICAÇÕES DE IPI     *}
      {********************************AF*}
      strClaIpi := '';
      For intCount := 1 To stlClaIpi.Count Do
        strClaIpi := strClaIpi + ' ' + fGetLetraAlfa(intCount) + ': ' + stlClaIpi[intCount - 1];

      If strModo = 'R' Then
      Begin
        frxPDF := frxExportaPDF_R;

        TfrxReportPage(frxExportaPDF_R.FindObject('Relatorio')).PaperSize := DMPAPER_A4;
        TfrxReportPage(frxExportaPDF_R.FindObject('Page1')).PaperSize     := DMPAPER_A4;
        TfrxReportPage(frxExportaPDF_R.FindObject('Page2')).PaperSize     := DMPAPER_A4;
      End
      Else
        frxPDF := frxExportaPDF_P;

      frxPDF.Script.Variables['CLAIPI'] := strClaIpi;

      {*******************************************}
      {* PEGA O ENDEREÇO CORRENTE DO EXECUTÁVEL  *}
      {****************************************LU*}
      strExecutavel := ExtractFilePath(Application.ExeName);

      {*******************************************}
      {* SE NÃO EXISTIR O DIRETÓRIO ELE CRIA     *}
      {****************************************AC*}
      If Not DirectoryExists(strExecutavel+'PedidoOrcamento') Then
        CreateDir(strExecutavel+'PedidoOrcamento');

      {*******************************************}
      {* O ARQUIVO SERÁ GERADO COM ESSE NOME     *}
      {****************************************AC*}
      If (qryCabecalho.FieldByName('ESPDOC').AsString = 'PD') Then
      Begin
        If (fCfgSis('EXPDOR') = 1) Then
           strNomeArquivo := 'PD_' + qryCabecalho.FieldByName('NUMDOC').AsString + IIF(strTipExp = 'P','.pdf','.xls')
        Else
          strNomeArquivo := 'PD_' + qryCabecalho.FieldByName('NUMDOC').AsString + IIF(strTipExp = 'P','.pdf','.ods');

        strDocumento   := 'Pedido Nº : ' + qryCabecalho.FieldByName('NUMDOC').AsString;
      End
      Else
      Begin
        If (fCfgSis('EXPDOR') = 1) Then
          strNomeArquivo := 'OR_' + qryCabecalho.FieldByName('NUMDOC').AsString + IIF(strTipExp = 'P','.pdf','.xls')
        Else
          strNomeArquivo := 'OR_' + qryCabecalho.FieldByName('NUMDOC').AsString + IIF(strTipExp = 'P','.pdf','.ods');

        strDocumento   := 'Orçamento Nº : '+qryCabecalho.FieldByName('NUMDOC').AsString;
      End;

      //Status do Pedido
      strStatus := IIF(qryCabecalho.FieldByName('JAFATU').AsInteger = 1, 'Status : Já Faturado - Documento : ' +
                       qryCabecalho.FieldByName('NUMFAT').AsString + ' - ' + qryCabecalho.FieldByName('TIPFAT').AsString + ' - ' +
                       qryCabecalho.FieldByName('EMPFAT').AsString, 'Status : Não Faturado.');

      frxExportaPDF_P.FindObject('rlbUrgente').Visible :=
        fDocumentoComEntregaUrgente( qryCabecalho.FieldByName('NUMDOC').AsString,
                                     qryCabecalho.FieldByName('ESPDOC').AsString,
                                     qryCabecalho.FieldByName('CODEMP').AsString,
                                     qryCabecalho.FieldByName('CODCLI').AsString );

      frxExportaPDF_R.FindObject('rlbUrgente').Visible := frxExportaPDF_P.FindObject('rlbUrgente').Visible;

      TfrxChild(frxExportaPDF_P.FindObject('CDespesasAces')).Visible := qryCabecalho.FieldByName('DESACE').AsFloat > 0;
      TfrxChild(frxExportaPDF_R.FindObject('CDespesasAces')).Visible := qryCabecalho.FieldByName('DESACE').AsFloat > 0;

      If blnTemServicos Then
      Begin
        If blnSomenteServ Then
        Begin
          TfrxChild(frxPDF.FindObject('CTituloItens')).Visible        := False;
          TfrxChild(frxPDF.FindObject('CTituloItensVolume')).Visible  := False;
          TfrxChild(frxPDF.FindObject('MDItens')).Visible             := False;
          TfrxChild(frxPDF.FindObject('MDItensVolume')).Visible       := False;
          TfrxChild(frxPDF.FindObject('FTotalProdutos')).Visible      := False;
        End
        Else
        Begin
          TfrxChild(frxPDF.FindObject('CTituloItens')).Visible       := Not blnImpVol;
          TfrxChild(frxPDF.FindObject('MDItens')).Visible            := Not blnImpVol;

          TfrxChild(frxPDF.FindObject('CTituloItensVolume')).Visible := blnImpVol;
          TfrxChild(frxPDF.FindObject('MDItensVolume')).Visible      := blnImpVol;
          TfrxChild(frxPDF.FindObject('CTotalVolumes')).Visible      := blnImpVol;

          TfrxChild(frxPDF.FindObject('FTotalProdutos')).Visible     := True;
        End;
      End
      Else
      Begin
        TfrxChild(frxPDF.FindObject('CTituloItens')).Visible       := Not blnImpVol;
        TfrxChild(frxPDF.FindObject('MDItens')).Visible            := Not blnImpVol;

        TfrxChild(frxPDF.FindObject('CTituloItensVolume')).Visible := blnImpVol;
        TfrxChild(frxPDF.FindObject('MDItensVolume')).Visible      := blnImpVol;
        TfrxChild(frxPDF.FindObject('CTotalVolumes')).Visible      := blnImpVol;
      End;

      If cdsServicos.RecordCount > 0 Then
      Begin
        cdsServicos.Open;
        TfrxChild(frxPDF.FindObject('CServicos')).Visible := True;
      End
      Else
        TfrxChild(frxPDF.FindObject('CServicos')).Visible := False;

      TfrxLineView(frxPDF.FindObject('linMarca')).Visible    := blnComMarca;
      TfrxMemoView(frxPDF.FindObject('mmoDesMar')).Visible   := blnComMarca;
      TfrxMemoView(frxPDF.FindObject('mmoMarca')).Visible    := blnComMarca;

      TfrxLineView(frxPDF.FindObject('linMarcaVol')).Visible  := blnComMarca;
      TfrxMemoView(frxPDF.FindObject('mmoDesMarVol')).Visible := blnComMarca;
      TfrxMemoView(frxPDF.FindObject('mmoMarcaVol')).Visible  := blnComMarca;

      TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Visible    := blnPreco;
      TfrxMemoView(frxPDF.FindObject('mmDescontoTituloVolume')).Visible  := blnPreco;
      TfrxMemoView(frxPDF.FindObject('mmDescontoDetalhe')).Visible       := blnPreco;
      TfrxMemoView(frxPDF.FindObject('mmDescontoDetalheVolume')).Visible := blnPreco;
      TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Text := fCfgSis('TIPDES') + 'Desc';
      TfrxMemoView(frxPDF.FindObject('mmDescontoTituloVolume')).Text := fCfgSis('TIPDES') + 'Desc';

      {********************************************************}
      {* SE FOR ORÇAMENTO E ESTIVER CONFIGURADO PARA UTILIZAR *}
      {* A DESCRIÇÃO SIMPLES                                  *}
      {*****************************************************RV*}
      If ((qryCabecalho.FieldByName('ESPDOC').AsString  = 'OR') And
          (qryCabecalho.FieldByName('ORGPUB').AsString <> 'S' ) And
          ((fCfgSis('IDSORC') = 'S') or ((fCfgSis('IDSORC') = 'P') And (fGetMenu('Descrição do Produto:', ['Completa','Simplificada'], 2) = 2)) )
         ) Then
      Begin
        TfrxMemoView(frxPDF.FindObject('mmoDescri')).Text     := '[frxItens."DESSIM"]';
        TfrxMemoView(frxPDF.FindObject('mmoDescriVol')).Text  := '[frxItens."DESSIM"]';
      End;

      If Not blnComMarca Then
        TfrxMemoView(frxPDF.FindObject('mmoDescri')).Width    := TfrxMemoView(frxPDF.FindObject('mmoDescri')).Width +
                                                                 TfrxMemoView(frxPDF.FindObject('mmoDesMar')).Width;

      If Not blnComMarca Then
        TfrxMemoView(frxPDF.FindObject('mmoDescriVol')).Width := TfrxMemoView(frxPDF.FindObject('mmoDescriVol')).Width +
                                                                 TfrxMemoView(frxPDF.FindObject('mmoDesMarVol')).Width;

      TfrxMemoView(frxPDF.FindObject('dbeIpi')).Visible      := blnPreco;
      TfrxMemoView(frxPDF.FindObject('dbeTotIte')).Visible   := blnPreco;
      TfrxMemoView(frxPDF.FindObject('dbePrecoUni')).Visible := blnPreco;
      TfrxMemoView(frxPDF.FindObject('dbePrecoDig')).Visible := blnPreco;
      TfrxMemoView(frxPDF.FindObject('dbePrecoUni')).DisplayFormat.FormatStr := strMskDecUnit;
      TfrxMemoView(frxPDF.FindObject('dbePrecoDig')).DisplayFormat.FormatStr := strMskDecUnit;

      TfrxMemoView(frxPDF.FindObject('lblIpi')).Visible      := blnPreco;
      TfrxMemoView(frxPDF.FindObject('lblTotIte')).Visible   := blnPreco;
      TfrxMemoView(frxPDF.FindObject('lblPrecoUni')).Visible := blnPreco;
      TfrxMemoView(frxPDF.FindObject('lblPrecoDig')).Visible := blnPreco;

      TfrxMemoView(frxPDF.FindObject('dbeIpiVol')).Visible      := blnPreco;
      TfrxMemoView(frxPDF.FindObject('dbeTotIteVol')).Visible   := blnPreco;
      TfrxMemoView(frxPDF.FindObject('dbePrecoUniVol')).Visible := blnPreco;
      TfrxMemoView(frxPDF.FindObject('dbePrecoDigVol')).Visible := blnPreco;
      TfrxMemoView(frxPDF.FindObject('dbePrecoUniVol')).DisplayFormat.FormatStr := strMskDecUnit;
      TfrxMemoView(frxPDF.FindObject('dbePrecoDigVol')).DisplayFormat.FormatStr := strMskDecUnit;

      TfrxMemoView(frxPDF.FindObject('lblIpiVol')).Visible      := blnPreco;
      TfrxMemoView(frxPDF.FindObject('lblTotIteVol')).Visible   := blnPreco;
      TfrxMemoView(frxPDF.FindObject('lblPrecoUniVol')).Visible := blnPreco;
      TfrxMemoView(frxPDF.FindObject('lblPrecoDigVol')).Visible := blnPreco;

      TfrxBand(frxPDF.FindObject('FTotalProdutos')).Visible  := blnPreco;
      TfrxBand(frxPDF.FindObject('CTotalDescontos')).Visible := blnPreco;
      TfrxBand(frxPDF.FindObject('CTotaIPI')).Visible        := blnPreco;
      TfrxBand(frxPDF.FindObject('CTotalGeral')).Visible     := blnPreco;

      {*******************************************************}
      {* CASO NAO EXISTA DESCONTO, ENTÃO NÃO MOSTRA A COLUNA *}
      {**25/02/2011-15:13**********************************DP*}
      If fRetornaTotalDesconto(strNumDoc,strEspDoc,VS_strCodEmp) = 0 Then
      Begin
        TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Visible    := False;
        TfrxMemoView(frxPDF.FindObject('mmDescontoTituloVolume')).Visible  := False;
        TfrxMemoView(frxPDF.FindObject('mmDescontoDetalhe')).Visible       := False;
        TfrxMemoView(frxPDF.FindObject('mmDescontoDetalheVolume')).Visible := False;
        TfrxLineView(frxPDF.FindObject('ln1')).Visible                     := False;
        TfrxLineView(frxPDF.FindObject('ln2')).Visible                     := False;

        {******************************************************************************}
        {* NO MODO RETRATO, QUANDO OCULTA A COLUNA DO DESCONTO, AUMENTO A QUANTIDADE  *}
        {* E O UNIT. BRUTO, NO CASO DE QTD E UNITÁRIO COM 4 CASAS ESTAVA CORTANDO.    *}
        {***************************************************************************RN*}
        If (strModo = 'R') Then
        Begin
          TfrxMemoView(frxPDF.FindObject('lblQtd')).Width := TfrxMemoView(frxPDF.FindObject('lblQtd')).Width + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Width / 2);
          TfrxMemoView(frxPDF.FindObject('lblQtdVol')).Width := TfrxMemoView(frxPDF.FindObject('lblQtdVol')).Width + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloVolume')).Width / 2);
          TfrxMemoView(frxPDF.FindObject('dbeQtd')).Width := TfrxMemoView(frxPDF.FindObject('dbeQtd')).Width + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Width / 2);
          TfrxMemoView(frxPDF.FindObject('dbeQtdVol')).Width := TfrxMemoView(frxPDF.FindObject('dbeQtdVol')).Width + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloVolume')).Width / 2);
          // -----
          TfrxLineView(frxPDF.FindObject('line13')).Left := TfrxLineView(frxPDF.FindObject('line13')).Left + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Width / 2);
          TfrxLineView(frxPDF.FindObject('line26')).Left := TfrxLineView(frxPDF.FindObject('line26')).Left + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloVolume')).Width / 2);
          // -----
          TfrxMemoView(frxPDF.FindObject('lblPrecoDig')).Width := TfrxMemoView(frxPDF.FindObject('lblPrecoDig')).Width + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Width / 2);
          TfrxMemoView(frxPDF.FindObject('lblPrecoDigVol')).Width := TfrxMemoView(frxPDF.FindObject('lblPrecoDigVol')).Width + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloVolume')).Width / 2);
          TfrxMemoView(frxPDF.FindObject('dbePrecoDig')).Width := TfrxMemoView(frxPDF.FindObject('dbePrecoDig')).Width + (TfrxMemoView(frxPDF.FindObject('mmDescontoDetalhe')).Width / 2);
          TfrxMemoView(frxPDF.FindObject('dbePrecoDigVol')).Width := TfrxMemoView(frxPDF.FindObject('dbePrecoDigVol')).Width + (TfrxMemoView(frxPDF.FindObject('mmDescontoDetalheVolume')).Width / 2);
          // -----
          TfrxMemoView(frxPDF.FindObject('lblPrecoDig')).Left       := TfrxMemoView(frxPDF.FindObject('lblPrecoDig')).Left + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Width / 2);
          TfrxMemoView(frxPDF.FindObject('lblPrecoDigVol')).Left    := TfrxMemoView(frxPDF.FindObject('lblPrecoDigVol')).Left + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Width / 2);
          TfrxMemoView(frxPDF.FindObject('dbePrecoDig')).Left       := TfrxMemoView(frxPDF.FindObject('dbePrecoDig')).Left + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Width / 2);
          TfrxMemoView(frxPDF.FindObject('dbePrecoDigVol')).Left    := TfrxMemoView(frxPDF.FindObject('dbePrecoDigVol')).Left + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Width / 2);
        End
        Else
        Begin
          TfrxMemoView(frxPDF.FindObject('lblPrecoDig')).Left       := TfrxMemoView(frxPDF.FindObject('lblPrecoDig')).Left + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Width / 2);
          TfrxMemoView(frxPDF.FindObject('lblPrecoDigVol')).Left    := TfrxMemoView(frxPDF.FindObject('lblPrecoDigVol')).Left + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Width / 2);
          TfrxMemoView(frxPDF.FindObject('dbePrecoDig')).Left       := TfrxMemoView(frxPDF.FindObject('dbePrecoDig')).Left + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Width / 2);
          TfrxMemoView(frxPDF.FindObject('dbePrecoDigVol')).Left    := TfrxMemoView(frxPDF.FindObject('dbePrecoDigVol')).Left + (TfrxMemoView(frxPDF.FindObject('mmDescontoTituloItem')).Width / 2);
        End;
      End;

      If fCfgSis('MSDSOR',varBoolean) And
         (Not ((Pos(FstrEspDoc, 'OR_PD_') > 0) And (fDescontoCliente))) Then
        TfrxChild(frxPDF.FindObject('CPorDes')).Visible := qryCabecalho.FieldByName('PORDES').AsFloat > 0
      Else
        TfrxChild(frxPDF.FindObject('CPorDes')).Visible := False;

      If blnEmpFat Then
      Begin
        TfrxMemoView(frxPDF.FindObject('mmoTitCodIte')).Text    := 'Emp-Código';
        TfrxMemoView(frxPDF.FindObject('mmoTitCodIteVol')).Text := 'Emp-Código';
      End;

      If (fCfgSis('VENMET') = '1') Then
        TfrxMemoView(frxPDF.FindObject('rllTitVen')).Text := 'Vendedor:'
      Else
        TfrxMemoView(frxPDF.FindObject('rllTitVen')).Text := 'Repres.(I):';

      TfrxMemoView(frxPDF.FindObject('rllTitRep')).Visible := fCfgSis('IREPOP', varBoolean);
      TfrxMemoView(frxPDF.FindObject('rdbNomRep')).Visible := fCfgSis('IREPOP', varBoolean);

      frxPDF.Script.Variables['MSGPED'] := fCfgSis('MSGPED', varString);
      TfrxChild(frxPDF.FindObject('CMsgPed')).Visible := (strEspDoc = 'PD');


      If (strTipExp = 'P') And blnArquivoPatEtiExiste Then
      Begin
        frxPDF.PrepareReport;
        frxExportaPDF.FileName    := strNomeArquivo;
        frxExportaPDF.DefaultPath := strExecutavel + 'PedidoOrcamento';
        frxExportaPDF.ShowDialog  := False;
        frxPDF.Export(frxExportaPDF);
      End
      Else
      Begin

        frxPDF.PrepareReport;

        If ((fCfgSis('EXPDOR')) = 1) Then
        Begin
          frxExportaXLS.FileName    := strNomeArquivo;
          frxExportaXLS.DefaultPath := strExecutavel + 'PedidoOrcamento';
          frxExportaXLS.ShowDialog  := False;
          frxPDF.Export(frxExportaXLS);
        End
        Else
        Begin
          frxExportaODS.FileName    := strNomeArquivo;
          frxExportaODS.DefaultPath := strExecutavel + 'PedidoOrcamento';
          frxExportaODS.ShowDialog  := False;
          frxPDF.Export(frxExportaODS);
        End;
      End;

      {**************************}
      {* GERA O ANEXO NO EMAIL  *}
      {***********************AC*}
      strNomeArquivo := strExecutavel+'PedidoOrcamento\'+strNomeArquivo;

      Result := strNomeArquivo;



    Finally
      FreeAndNil(qryTitulo);
      FreeAndNil(qryCabecalho);
      FreeAndNil(qryItens);
      FreeAndNil(qryDuplicatas);
      FreeAndNil(qryComplementares);
      FreeAndNil(qryTotais);
      cdsDuplicatas.Close;
      cdsComplementares.Close;
      cdsTotais.Close;
    End;
  End;
end;

class function TfrmFatGorEmail.fGerarEmail(strNumDoc,
                                    strEspDoc: String;
                                    opcComSemPreco: TImpressaoComSemPrecoOrPd;
                                    blnComMarca: Boolean;
                                    strTipExp: String;
                                    strModo: String = 'R';
                                    strOrdem        : String = '';
                                    strCodEmpPar    : String = '';
                                    blnLocFis       : Boolean = False;
                                    strNomEmp       : String = 'R';
                                    strCodCli       : String = '';
                                    blnCabecalhoCD  : Boolean = False;
                                    blnDocCancelado : Boolean = False;
                                    blnQtdOri       : Boolean = True): String;
begin
  pCriarFormularios(TfrmFatGorEmail, frmFatGorEmail);
  Try
    Application.ProcessMessages;
    result := frmFatGorEmail.fGeraEmail(strNumDoc,
                                            strEspDoc,
                                            opcComSemPreco,
                                            blnComMarca,
                                            strTipExp, {P = PDF | E = Excel}
                                            strModo,
                                            strOrdem,
                                            strCodEmpPar,
                                            blnLocFis,
                                            strNomEmp,
                                            strCodCli,
                                            blnCabecalhoCD,
                                            blnDocCancelado,
                                            blnQtdOri);
  Finally
    pDestroiModulo(frmFatGorEmail);
  End;
end;

function TfrmFatGorEmail.fGetDesCli: Double;
begin
  Result := FfltDesCli;
end;

procedure TfrmFatGorEmail.frxParametrosGetValue(const VarName: String;
  var Value: Variant);
begin
  If SameText('IMAGEM',VarName) Then
  Begin
    If fCfgSis('MODLOG') = '1' Then
      Value := strDirImagem
    Else Value := strDirImgGde;
  End
  Else If SameText('MODELO',VarName) Then
    Value := fCfgSis('MODLOG')
  Else If SameText('DOCUMENTO',VarName) Then
    Value := strDocumento
  Else If SameText('PRECO',VarName) Then
    Value := blnPreco
  Else If SameText('STATUS',VarName) Then
    Value := strStatus;
end;

{****************************************}
{* FUNCAO TRAZ O TOTAL DE DESCONTO      *}
{* DE UM DETERMINADO PEDIDO / ORÇAMENTO *}
{**25/02/2011-16:32*******************DP*}
function TfrmFatGorEmail.fRetornaTotalDesconto(strNumDoc, strEspDoc,
  strCodEmp: String): Double;
  Var
    qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.Close;
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT IFNULL(SUM(FDO_DESCON),0) DESCON ');
  qryAux.SQL.Add('  FROM FATDOR ');
  qryAux.SQL.Add(' WHERE FDO_NUMDOC = :NUMDOC ');
  qryAux.SQL.Add('   AND FDO_ESPDOC = :ESPDOC ');
  qryAux.SQL.Add('   AND FDO_CODEMP = :CODEMP ');
  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.Open;
  Result := qryAux.FieldByName('DESCON').AsFloat;
  qryAux.Close;
  FreeAndNil(qryAux);
end;

procedure TfrmFatGorEmail.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

  stlClaIpi := TStringList.Create;
  stlClaIpi.Sorted := True;
  stlClaIpi.Duplicates := dupIgnore;

  frxExportaPDF_R.AddFunction('function fFormataCondPag(strCond : String): String');
  frxExportaPDF_R.AddFunction('function fRetClaIpi(strClaIpi : String): String');
  frxExportaPDF_R.AddFunction('function fDadosMetragem(strAparel, strBenefi: String; fltQtdPec, fltComPec, fltLarPec, fltEspPec: Double): String');
  frxExportaPDF_R.AddFunction('function fFormataFoneInterna(strFone: String): String');
  frxExportaPDF_R.AddFunction('function fDescontoCliente: Boolean;');
  frxExportaPDF_R.AddFunction('function fGetDesCli: Double;');

  frxExportaPDF_P.AddFunction('function fFormataCondPag(strCond : String): String');
  frxExportaPDF_P.AddFunction('function fDadosMetragem(strAparel, strBenefi: String; fltQtdPec, fltComPec, fltLarPec, fltEspPec: Double): String');
  frxExportaPDF_P.AddFunction('function fFormataFoneInterna(strFone: String): String');
  frxExportaPDF_P.AddFunction('function fDescontoCliente: Boolean;');
  frxExportaPDF_P.AddFunction('function fGetDesCli: Double;');
end;

function TfrmFatGorEmail.frxExportaPDF_RUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACONDPAG' Then
    Result := UpperCase(fFormataCondPag(Params[0]))

  Else If MethodName = 'FRETCLAIPI' Then
  Begin

    If stlClaIpi.IndexOf(Params[0]) >= 0 Then
      Result := fGetLetraAlfa(stlClaIpi.IndexOf(Params[0]) + 1)
    Else
      Result := '';

  End

  Else If (SameText(MethodName, 'fFormataFoneInterna')) Then
    Result := fFormataFoneInterna(Trim(Params[0]))

  Else If SameText(MethodName, 'fDadosMetragem') Then
    Result := fDadosMetragem(Params[0], Params[1], Params[2], Params[3], Params[4], Params[5])

  Else If (SameText(MethodName, 'fDescontoCliente')) Then
    Result := fDescontoCliente

  Else If (SameText(MethodName, 'fGetDesCli')) Then
    Result := fGetDesCli;
end;

procedure TfrmFatGorEmail.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(stlClaIpi);
end;

function TfrmFatGorEmail.fDadosMetragem(strAparel, strBenefi: String; fltQtdPec, fltComPec, fltLarPec, fltEspPec: Double): String;
begin

  Result := '';

  If (fltQtdPec > 0) Then
  Begin
    If fCfgSis('VENMAD',varBoolean) Then
    Begin
      If strAparel = 'S'       Then Result := Result + '/APARELHADA';
      If strBenefi = 'S'       Then Result := Result + '/BENEFICIADA';
      If Not fEmptyStr(Result) Then System.Delete(Result, 1, 1);

      Result := 'QTD.: '   + FloatToStrF( fltQtdPec, ffFixed, 12, 02 ) + ' ' +
                'COMP.: '  + FloatToStrF( fltComPec, ffFixed, 12, 05 ) + ' ' +
                'LARG.: '  + FloatToStrF( fltLarPec, ffFixed, 12, 05 ) + ' ' +
                'ESPES.: ' + FloatToStrF( fltEspPec, ffFixed, 12, 05 ) + ' ' + Result;
    End
    Else If fCfgSis('VENMTL',varBoolean) Then
    Begin
      Result := FloatToStrF( fltQtdPec, ffFixed, 12, 05 ) + ' PECAS DE ' +
                FloatToStrF( fltComPec, ffFixed, 12, 05 ) + ' MTS = ' +
                FloatToStrF( fltQtdPec *
                             fltComPec, ffFixed, 12, 05 );
    End
    Else
    Begin
      Result := 'QTD.: '   + FloatToStrF( fltQtdPec, ffFixed, 12, 02 ) + ' ' +
                'LARG.: '  + FloatToStrF( fltLarPec, ffFixed, 12, StrToIntDef(fFormataCasaDecimalVIDRO(5),0)) + ' ' +
                UpperCase(fRetornaInfMedVIDRO(True,True,False,False,True))  +
                FloatToStrF( fltComPec, ffFixed, 12, StrToIntDef(fFormataCasaDecimalVIDRO(5),0) ) + ' ' ;
    End;
  End;

end;


function TfrmFatGorEmail.fDescontoCliente: Boolean;
begin
  Result := fDescontoClienteProfissional(FstrCodCli) And (Pos(FstrEspDoc, 'OR_PD_') > 0);
end;

function TfrmFatGorEmail.fFormataFoneInterna(strFone: String): String;
begin
  Result := fFormataFone(strFone);
end;

end.
