unit untAtivaTabelaPreco;

interface

Uses
  Classes,
  Uni,
  untZClient,
  CxProgressBar,
  untGravando,
  untIteBar,
  Math,
  Data.DB,
  untParCalculaPrecoCusto;

Type
  TopcFornecedorPrincipal = (tocfopSim, tocfopNao, tocfopTodos);

  TOpcNivGir = set of (nivGirA, nivGirB, nivGirC);

  TopcMarPre = (opcMargem, opcPrecoVenda);

  TAtivaTabelaPreco = Class(TComponent)
  Private
    blnSufram :Boolean;
    strFrmCus: String;

    FMarcar: Boolean;

    objIteBar: TIteBar;

    stlLisFor,
    stlLisTab: TStringList;

    qryTabDet,
    qryIteger,
    qryDetCus,
    qryCadIte: TUniQuery;

    strAgrupadorPreAlt: String;

    Function fMarcaTodosPrg(cxProgresso: TcxProgressBar): Boolean;

    Function fSQLAtualizaDadosIteger(intTabela: integer = 1): String;
    Function fSQLAtualizaDadosCadIte: String;
    Function fSQLUpdateTabDet: String;
    Function fSQLUpdateDetCus: String;

    Function fRetEmpresasAtivacao: String;
    function fSQLCamposIteFor(strAliasIteFor, strAliasTabDet, strTipo: String): String;
    function fSQLCamposIteger(strTabela: string): String;
    function fSQLCamposCadIte: String;

    Function fSQLDados(strTabela: String): String;
    Function fRetNiveisGirFor: String;

    Function fCalculaPrecosAtivacaoPrg(cxProgresso: TcxProgressBar): Boolean;
    function fRetPrecoCusto(dataSet: TDataSet; strNov: String = '';  fltIcmEnt: Double = -1; fltSubst: Double = -1; fltSubFed: Double = -1): Double;


    Function fAtualizaPrecosPrg(cxProgresso: TcxProgressBar): Boolean;

    Function fGravaAlteracaoPreco: Boolean;
    Procedure pAtualizaDadosIteger;
    procedure pAtualizaDadosDetCus;
    Procedure pAtualizaDadosCadIte;
    procedure pAtivaTabelasParaCompra;
    procedure pAtualizaCopiaPrecoRevista(strCodTabNew, strCodIte, strCodEmp: String; fltPreRev, fltMarFec: Double);

    Function fCalculaPrecosAtivacao: Boolean;

    procedure pMarcaItem(blnMarcar: Boolean);

    Procedure pFormataCampos;

  Public
    cdsDados: TZClient;

    blnLiqNeg: Boolean;
    fltPMarLq: Double;

    intDecUni: Integer;
    strTipabf,
    strTpabpc: String;
    cpcParams: TParCalculaPrecoCusto;


    opCalculo: TopcMarPre;
    blnAtualizarPrecoRevista,
    blnMarcarAtiva: Boolean;
    strTabelasPreco: String;
    strTabelaPrecoVenda: String;
    intValArr: Integer;
    opcFornecedorPrincipal: TopcFornecedorPrincipal;
    OpcNivGir: TOpcNivGir;

    constructor Create(Owner: TComponent); override;

    Destructor Destroy; override;

    Function fMarcaTodos(blnMarcar: Boolean): Boolean;
    procedure pMarcaDesmarca;

    Function fCarregaDados: Boolean;
    Function fAtualizaPrecos: Boolean;
  End;


implementation

Uses
  Forms,
  untTypesSistema,
  untFuncoesSimples,
  untPreAlt_Trigger,
  untPreAlt,
  SysUtils, untTConfiguracao;

constructor TAtivaTabelaPreco.Create(Owner: TComponent);
Begin
  Inherited Create(Owner);
  blnSufram := fCfgSis('SUFRAM', varBoolean);
  strFrmCus := fCfgSis('FRMCUS', varString);
  intValArr := -1;
  opCalculo := opcMargem;
  blnAtualizarPrecoRevista := False;
  blnMarcarAtiva := True;
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

  cdsDados := TZClient.Create(Self);

  objIteBar := TIteBar.Create(opcOperacoes);

  stlLisFor := TStringList.Create;
  stlLisFor.Sorted := True;
  stlLisFor.Duplicates := dupIgnore;

  stlLisTab := TStringList.Create;
  stlLisTab.Sorted := True;
  stlLisTab.Duplicates := dupIgnore;

  intDecUni := fCfgSis('DECUNI', varInteger);

  strTipabf := fCfgSIs('TIPABF');
  strTpabpc := fCfgSis('TPABPC');

  blnLiqNeg := fCfgSis('LIQNEG', varBoolean);

  If blnLiqNeg Then
    fltPMarLq := fCfgSis('PMARLQ', varDouble)
  Else
    fltPMarLq := 1;
End;

Destructor TAtivaTabelaPreco.Destroy;
Begin
  Inherited;

  FreeAndNil(stlLisFor);
  FreeAndNil(stlLisTab);
End;

Function TAtivaTabelaPreco.fRetEmpresasAtivacao: String;
  Var
    qryCadEmp: TUniQuery;
Begin
  qryCadEmp := fCriaQuery;
  qryCadEmp.SQL.Add('SELECT GROUP_CONCAT(QUOTE(EMP_CODEMP)) AS CODEMP FROM CADEMP');
  qryCadEmp.SQL.Add('INNER JOIN CFGSIS ON SIS_CODEMP = EMP_CODEMP AND SIS_CODCFG = "CFG_COLTAB" AND SIS_VALCFG = "S"');
  qryCadEmp.SQL.Add('ORDER BY EMP_CODEMP');
  qryCadEmp.Open;
  Result := qryCadEmp.FieldByName('CODEMP').AsString;
  FreeAndNil(qryCadEmp);
End;

function TAtivaTabelaPreco.fRetNiveisGirFor: String;
begin

  If nivGirA in OpcNivGir then
    Result := Result + '_A';
  If nivGirB in OpcNivGir then
    Result := Result + '_B';
  If nivGirC in OpcNivGir then
    Result := Result + '_C';
end;

function  TAtivaTabelaPreco.fSQLCamposIteFor(strAliasIteFor, strAliasTabDet, strTipo: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';


  If fCfgSIs('TIPABF') = '1' Then
    strSQL := strSQL + 'IFNULL(' + strAliasIteFor + '.ITE_CODABF , ' +
                                strAliasTabDet + '.ITE_CODABF'+') AS ITE_CODABF_' + strTipo + ' , '
  Else
    strSQL := strSQL + strAliasTabDet + '.ITE_CODABF AS ITE_CODABF_' + strTipo + ', ';



  If fCfgSis('TPABPC') = '1' Then
  begin
    strSQL := strSQL + 'IFNULL(' + strAliasIteFor + '.ITE_ABFIPI , ' +
                                strAliasTabDet + '.ITE_ABFIPI'+') AS ITE_ABFIPI_' + strTipo + ' , ';

    strSQL := strSQL + 'IFNULL(' + strAliasIteFor + '.ITE_ABFCOF , ' +
                                strAliasTabDet + '.ITE_ABFCOF'+') AS ITE_ABFCOF_' + strTipo + ' , ';

    strSQL := strSQL + 'IFNULL(' + strAliasIteFor + '.ITE_ABFPIS , ' +
                                strAliasTabDet + '.ITE_ABFPIS'+') AS ITE_ABFPIS_' + strTipo + ' , ';
  End
  Else
  begin
    strSQL := strSQL + strAliasTabDet + '.ITE_ABFIPI AS ITE_ABFIPI_' + strTipo + ', ';
    strSQL := strSQL + strAliasTabDet + '.ITE_ABFCOF AS ITE_ABFCOF_' + strTipo + ', ';
    strSQL := strSQL + strAliasTabDet + '.ITE_ABFPIS AS ITE_ABFPIS_' + strTipo + ', ';
  End;


  strSQL := strSQL + strAliasIteFor + '.ITE_CODTAB AS ITE_CODTAB_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.ITE_CODFOR AS ITE_CODFOR_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.ITE_UNICOM AS ITE_UNICOM_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.ITE_MLTCOM AS ITE_MLTCOM_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.ITE_DIAFOR AS ITE_DIAFOR_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.ITE_CLAIPI AS ITE_CLAIPI_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.ITE_DESFAB AS ITE_DESFAB_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.ITE_CODFAB AS ITE_CODFAB_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.ITE_CNVCUS AS ITE_CNVCUS_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.TFO_EMBALA AS ITE_EMBALA_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.TFO_BAREMB AS ITE_BAREMB_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.TFO_REFERE AS ITE_REFERE_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.TFO_CODBAR AS ITE_CODBAR_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.TFO_PESOIT AS ITE_PESOIT_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.TFO_SITPRO AS ITE_SITPRO_' + strTipo + ', ';
  strSQL := strSQL + strAliasIteFor + '.TFO_NOTESP AS ITE_NOTESP_' + strTipo + ', ';


  strSQL := strSQL +  'CE.DET_SEQDET ,';

  If strTipo = 'NOV' Then
  Begin
    strSQL := strSQL + strAliasTabDet + '.ITE_IMPFED AS ITE_IMPFED_' + strTipo + ', ';
    strSQL := strSQL + strAliasTabDet + '.ITE_SUBFED AS ITE_SUBFED_' + strTipo + ', ';
    strSQL := strSQL +  'CE.DET_ICMSAI AS ITE_ICMSAI_' + strTipo + ', ';
    strSQL := strSQL +  'CE.DET_OUTVAL / IF(IFNULL(' + strAliasIteFor + '.ITE_CNVCUS, 0) = 0, 1, ' + strAliasIteFor + '.ITE_CNVCUS) AS ITE_OUTVAL_' + strTipo + ', ';
    strSQL := strSQL +  'CE.DET_DESOPE AS ITE_DESOPE_' + strTipo + ', ';
  End
  Else
  Begin
    strSQL := strSQL + strAliasTabDet + '.ITE_IMPFED AS ITE_IMPFED_' + strTipo + ', ';
    strSQL := strSQL + strAliasTabDet + '.ITE_SUBFED AS ITE_SUBFED_' + strTipo + ', ';
    strSQL := strSQL + 'CA.DET_ICMSAI AS ITE_ICMSAI_' + strTipo + ', ';
    strSQL := strSQL + 'CA.DET_OUTVAL / IF(IFNULL(' + strAliasIteFor + '.ITE_CNVCUS, 0) = 0, 1, ' + strAliasIteFor + '.ITE_CNVCUS) AS ITE_OUTVAL_' + strTipo + ', ';
    strSQL := strSQL + 'CA.DET_DESOPE AS ITE_DESOPE_' + strTipo + ', ';

  End;


  strSQL := strSQL + strAliasTabDet + '.ITE_PREDOL AS ITE_PREDOL_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_PRECOM / IF(IFNULL(' + strAliasIteFor + '.ITE_CNVCUS, 0) = 0, 1, ' + strAliasIteFor + '.ITE_CNVCUS) AS ITE_PRECOM_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_DESF01 AS ITE_DESF01_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_DESF02 AS ITE_DESF02_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_DESF03 AS ITE_DESF03_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_DESF04 AS ITE_DESF04_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_DESF05 AS ITE_DESF05_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_DESF06 AS ITE_DESF06_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_ICMENT AS ITE_ICMENT_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_IPIENT AS ITE_IPIENT_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_FREENT AS ITE_FREENT_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_VALFRE / IF(IFNULL(' + strAliasIteFor + '.ITE_CNVCUS, 0) = 0, 1, ' + strAliasIteFor + '.ITE_CNVCUS) AS ITE_VALFRE_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_ACRFIN AS ITE_ACRFIN_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_SUBSTI AS ITE_SUBSTI_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_DESADB AS ITE_DESADB_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_PRECUS / IF(IFNULL(' + strAliasIteFor + '.ITE_CNVCUS, 0) = 0, 1, ' + strAliasIteFor + '.ITE_CNVCUS) AS ITE_PRECUS_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_TCIFCU AS ITE_TCIFCU_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_TSCUST AS ITE_TSCUST_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_DEPICO AS ITE_DEPICO_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_DEICMS AS ITE_DEICMS_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_FATREG AS ITE_FATREG_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_EXCIPI AS ITE_EXCIPI_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_PREREV AS ITE_PREREV_' + strTipo + ', ';
  strSQL := strSQL + strAliasTabDet + '.ITE_MARFEC AS ITE_MARFEC_' + strTipo + ', ';
  Result := strSQL;
End;

function  TAtivaTabelaPreco.fSQLCamposIteger(strTabela: string): String;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  strSQL := '';
  strSQL := strSQL + '  G.ITE_CODITE, ';
  strSQL := strSQL + '  G.ITE_CODEMP, ';
  strSQL := strSQL + '  G.ITE_PREDOL, ';
  strSQL := strSQL + '  G.ITE_PRECOM, ';
  strSQL := strSQL + '  G.ITE_DESF01, ';
  strSQL := strSQL + '  G.ITE_DESF02, ';
  strSQL := strSQL + '  G.ITE_DESF03, ';
  strSQL := strSQL + '  G.ITE_DESF04, ';
  strSQL := strSQL + '  G.ITE_DESF05, ';
  strSQL := strSQL + '  G.ITE_DESF06, ';
  strSQL := strSQL + '  G.ITE_ICMENT, ';
  strSQL := strSQL + '  G.ITE_SUBFED, ';
  strSQL := strSQL + '  G.ITE_IPIENT, ';
  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_VALFRE, ';
  strSQL := strSQL + '  G.ITE_ACRFIN, ';
  strSQL := strSQL + '  G.ITE_SUBSTI, ';
  strSQL := strSQL + '  G.ITE_DESADB, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_ICMSAI, ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_TCIFCU, ';
  strSQL := strSQL + '  G.ITE_TSCUST, ';
  strSQL := strSQL + '  G.ITE_DEPICO, ';
  strSQL := strSQL + '  G.ITE_DEICMS, ';
  strSQL := strSQL + '  G.ITE_FATREG, ';
  strSQL := strSQL + ' (TA.ITE_PRECOM * (1 -  TA.ITE_DESF01 / 100) * '  +
                     '                  (1 -  TA.ITE_DESF02 / 100) * '  +
                     '                  (1 -  TA.ITE_DESF03 / 100) * '  +
                     '                  (1 -  TA.ITE_DESF04 / 100) * '  +
                     '                  (1 -  TA.ITE_DESF05 / 100) * '  +
                     '                  (1 -  TA.ITE_DESF06 / 100)) / IF(IFNULL(IA.ITE_CNVCUS, 0) = 0, 1 , IA.ITE_CNVCUS)  AS ITE_PRCLIQ_ATU, ';
  strSQL := strSQL + '  0.0 AS ITE_PRCLIQ_NOV, ';

  strSQL := strSQL + ' G.ITE_MARBR' + strTabela + ' AS ITE_MARBRU_ATU, ';
  strSQL := strSQL + ' G.ITE_PREVE' + strTabela + ' AS ITE_PREVEN_ATU, ';
  strSQL := strSQL + ' G.ITE_MARBR' + strTabela + ' AS ITE_MARBRU_NOV, ';
  strSQL := strSQL + ' G.ITE_PREVE' + strTabela + ' AS ITE_PREVEN_NOV, ';

  For intContador := 1 To 7 Do
  Begin
    strSQL := strSQL + ' G.ITE_MARBR' + intContador.ToString + ' AS ITE_MARBR' + intContador.ToString + '_ATU, ';
    strSQL := strSQL + ' G.ITE_COMTB' + intContador.ToString + ' AS ITE_COMTB' + intContador.ToString + '_ATU, ';
    strSQL := strSQL + ' G.ITE_PREVE' + intContador.ToString + ' AS ITE_PREVE' + intContador.ToString + '_ATU, ';

    strSQL := strSQL + ' CE.DET_MARBRU AS ITE_MARBR' + intContador.ToString + '_NOV, ';
    strSQL := strSQL + ' G.ITE_COMTB' + intContador.ToString + ' AS ITE_COMTB' + intContador.ToString + '_NOV, ';
    strSQL := strSQL + ' G.ITE_PREVE' + intContador.ToString + ' AS ITE_PREVE' + intContador.ToString + '_NOV, ';
  End;

  If strTipabf = '1' Then
    strSQL := strSQL + '  C.ITE_CODABF, '
  Else
    strSQL := strSQL + '  G.ITE_CODABF,';

  If strTpabpc = '1' Then
  Begin
    strSQL := strSQL + '  C.ITE_ABFPIS, ';
    strSQL := strSQL + '  C.ITE_ABFCOF, ';
    strSQL := strSQL + '  C.ITE_ABFIPI, ';
  End
  Else
  Begin
    strSQL := strSQL + '  G.ITE_ABFPIS, ';
    strSQL := strSQL + '  G.ITE_ABFCOF, ';
    strSQL := strSQL + '  G.ITE_ABFIPI, ';
  End;

  strSQL := strSQL + '  G.ITE_CODEMP ';

  Result := strSQL;
End;

function TAtivaTabelaPreco.fSQLCamposCadIte: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + '  C.ITE_DESITE, ';
  strSQL := strSQL + '  C.ITE_CODFOR, ';
  strSQL := strSQL + '  C.ITE_UNICOM, ';
  strSQL := strSQL + '  C.ITE_MLTCOM, ';
  strSQL := strSQL + '  C.ITE_DIAFOR, ';
  strSQL := strSQL + '  C.ITE_CLAIPI, ';
  strSQL := strSQL + '  C.ITE_DESFAB, ';
  strSQL := strSQL + '  C.ITE_CODFAB, ';
  strSQL := strSQL + '  C.ITE_EMBALA, ';
  strSQL := strSQL + '  C.ITE_BAREMB, ';
  strSQL := strSQL + '  C.ITE_REFERE, ';
  strSQL := strSQL + '  C.ITE_CODBAR, ';
  strSQL := strSQL + '  C.ITE_PESOIT, ';
  strSQL := strSQL + '  C.ITE_SITPRO, ';
  strSQL := strSQL + '  C.ITE_NOTESP, ';
  Result := strSQL;
End;

Function TAtivaTabelaPreco.fSQLDados(strTabela: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '  ' + strTabela + ' AS TABELA,';
  strSQL := strSQL + ' "S" AS MARCADO, ';

  strSQL := strSQL +  'UA.UNI_SIGUNI AS UNICOM_ATU, ';
  strSQL := strSQL +  ' U.UNI_SIGUNI AS UNICOM_NOV, ';
  strSQL := strSQL +  ' IF(C.ITE_CODFOR = I.ITE_CODFOR, "S", "N") AS PRINC, ';

  strSQL := strSQL + fSQLCamposIteFor('IA', 'TA', 'ATU');
  strSQL := strSQL + fSQLCamposIteFor('I',  'T',  'NOV');
  strSQL := strSQL + fSQLCamposCadIte;
  strSQL := strSQL + fSQLCamposIteger(strTabela);

  strSQL := strSQL + ' FROM   ';
  strSQL := strSQL + '   ITEFOR I ';

  strSQL := strSQL + ' INNER JOIN TABDET T ';
  strSQL := strSQL + '    ON T.ITE_CODTAB = I.ITE_CODTAB  ';
  strSQL := strSQL + '   AND T.ITE_CODITE = I.ITE_CODITE  ';
  strSQL := strSQL + '   AND T.ITE_CODFOR = I.ITE_CODFOR  ';

  strSQL := strSQL + ' INNER JOIN ITEGER G ';
  strSQL := strSQL + '    ON G.ITE_CODITE = T.ITE_CODITE ';
  strSQL := strSQL + '   AND G.ITE_CODEMP = T.ITE_CODEMP ';

  strSQL := strSQL + ' LEFT JOIN TABDET TA ';
  strSQL := strSQL + '    ON TA.ITE_CODTAB = G.ITE_TABPR' + strTabela;
  strSQL := strSQL + '   AND TA.ITE_CODITE = G.ITE_CODITE  ';
  strSQL := strSQL + '   AND TA.ITE_CODEMP = G.ITE_CODEMP ';

  strSQL := strSQL + ' LEFT JOIN ITEFOR IA ';
  strSQL := strSQL + '    ON IA.ITE_CODTAB = TA.ITE_CODTAB ';
  strSQL := strSQL + '   AND IA.ITE_CODITE = TA.ITE_CODITE  ';

  strSQL := strSQL + ' INNER JOIN CADITE C ON C.ITE_CODITE = T.ITE_CODITE ';

  strSQL := strSQL + ' LEFT JOIN CADUNI UA ON UA.UNI_CODUNI = IA.ITE_UNICOM ';

  strSQL := strSQL + ' LEFT JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_UNICOM ';

  strSQL := strSQL + ' LEFT JOIN DETCUS CE ON CE.DET_SEQDET = T.AUTOINCREM AND CE.DET_TABELA = ' + strTabela;
  strSQL := strSQL + ' LEFT JOIN DETCUS CA ON CA.DET_SEQDET = TA.AUTOINCREM AND CA.DET_TABELA = ' + strTabela;


  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '       T.ITE_CODTAB IN (' + strTabelasPreco + ') ';
  strSQL := strSQL + '   AND T.ITE_CODEMP IN (' + fRetEmpresasAtivacao + ')  ';
  strSQL := strSQL + '   AND T.ITE_PRECOM > 0                ';

  If OpcNivGir <> [] then
  strSQL := strSQL + '   AND LOCATE(LEFT(C.ITE_NVLFOR, 1), "' + fRetNiveisGirFor + '")';


  case opcFornecedorPrincipal of
    tocfopSim : strSQL := strSQL + ' HAVING PRINC = "S" ';
    tocfopNao : strSQL := strSQL + ' HAVING PRINC = "N" ';
  End;

  Result := strSQL;
End;

Function TAtivaTabelaPreco.fCarregaDados: Boolean;
var i: integer;
Begin
  Try
    cdsDados.qryQuery.SQL.Text := '';
    For i := 1 To 7 do
    begin
      If strTabelaPrecoVenda[i] = 'S' then
      Begin
        IF cdsDados.qryQuery.SQL.Text <> '' Then
          cdsDados.qryQuery.SQL.Text := cdsDados.qryQuery.SQL.Text + ' UNION ALL ';
        cdsDados.qryQuery.SQL.Text := cdsDados.qryQuery.SQL.Text + ' ' + fSQLDados(i.ToString);
      End
    End;
    Result := cdsDados.fLeDados('TAtivaTabelaPreco.fCarregaDados', True, 'Carregando produtos, aguarde...') And
              fCalculaPrecosAtivacao;

    pFormataCampos;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TAtivaTabelaPreco.fCarregaDados]');
    End;
  End;

End;

Function TAtivaTabelaPreco.fCalculaPrecosAtivacao: Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  Result := TfrmGravando.fExecuta(fCalculaPrecosAtivacaoPrg, frmGravando, 'Aguarde, recalculando '
                 + IIF(opCalculo = opcMargem, 'margens...', 'preços...'));
End;


function TAtivaTabelaPreco.fRetPrecoCusto(dataSet: TDataSet; strNov: String = '';  fltIcmEnt: Double = -1; fltSubst: Double = -1; fltSubFed: Double = -1): Double;
  Var
    blnUtilizarConversorDeMoeda: Boolean;
begin
  If fltIcmEnt = -1 Then
    fltIcmEnt := dataSet.FieldByName('ITE_ICMENT' + strNov).AsFloat;

  If fltSubst = -1 Then
    fltSubst := dataSet.FieldByName('ITE_SUBSTI' + strNov).AsFloat;

  If fltSubFed = -1 Then
    fltSubFed := dataSet.FieldByName('ITE_SUBFED' + strNov).AsFloat;

  cpcParams.curPreCom := dataSet.FieldByName('ITE_PRECOM' + strNov).AsFloat;
  cpcParams.curDesF01 := dataSet.FieldByName('ITE_DESF01' + strNov).AsFloat;
  cpcParams.curDesF02 := dataSet.FieldByName('ITE_DESF02' + strNov).AsFloat;
  cpcParams.curDesF03 := dataSet.FieldByName('ITE_DESF03' + strNov).AsFloat;
  cpcParams.curDesF04 := dataSet.FieldByName('ITE_DESF04' + strNov).AsFloat;
  cpcParams.curDesF05 := dataSet.FieldByName('ITE_DESF05' + strNov).AsFloat;
  cpcParams.curDesF06 := dataSet.FieldByName('ITE_DESF06' + strNov).AsFloat;
  cpcParams.curICMSEnt:= fltIcmEnt;
  cpcParams.curIPIEnt := dataSet.FieldByName('ITE_IPIENT' + strNov).AsFloat;
  cpcParams.curFrete  := dataSet.FieldByName('ITE_FREENT' + strNov).AsFloat;
  cpcParams.curAcrFin := dataSet.FieldByName('ITE_ACRFIN' + strNov).AsFloat;
  cpcParams.curSubsti := fltSubst;
  cpcParams.curValFre := dataSet.FieldByName('ITE_VALFRE' + strNov).AsFloat;
  cpcParams.curDesAdb := dataSet.FieldByName('ITE_DESADB' + strNov).AsFloat;
  cpcParams.curSubFed := fltSubFed;

  if blnSufram and (strFrmCus = '4') then
  begin
    cpcParams.curTCIFCu := dataSet.FieldByName('ITE_TCIFCU' + strNov).AsFloat;
    cpcParams.curTSCust := dataSet.FieldByName('ITE_TSCUST' + strNov).AsFloat;
    cpcParams.curDePiCo := dataSet.FieldByName('ITE_DEPICO' + strNov).AsFloat;
    cpcParams.curDeICMS := dataSet.FieldByName('ITE_DEICMS' + strNov).AsFloat;
    cpcParams.curFatReg := dataSet.FieldByName('ITE_FATREG' + strNov).AsFloat;
  end
  else
  begin
    cpcParams.curTCIFCu := 0;
    cpcParams.curTSCust := 0;
    cpcParams.curDePiCo := 0;
    cpcParams.curDeICMS := 0;
    cpcParams.curFatReg := 0;
  end;

  blnUtilizarConversorDeMoeda := dataSet.FieldByName('ITE_PREDOL' + strNov).AsString = 'S';

  Result := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoeda);
end;


Function TAtivaTabelaPreco.fCalculaPrecosAtivacaoPrg(cxProgresso: TcxProgressBar): Boolean;
  Var
    strCampo: String;
    intOpcCalculo: Integer;
Begin
  Try

    If opCalculo = opcMargem Then
    Begin
      strCampo := 'ITE_MARBR';
      intOpcCalculo := 2;
    End Else
    Begin
      strCampo := 'ITE_PREVE';
      intOpcCalculo := 1;
    End;

    cxProgresso.Properties.Max := cdsDados.RecordCount;
    cxProgresso.Position := 0;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;

      cdsDados.FieldByName('ITE_PRECUS_NOV').AsFloat := fRetPrecoCusto(cdsDados,
                                                                       '_NOV',
                                                                       cdsDados.FieldByName('ITE_ICMENT_NOV').AsFloat,
                                                                       cdsDados.FieldByName('ITE_SUBSTI_NOV').AsFloat,
                                                                       cdsDados.FieldByName('ITE_SUBFED_NOV').AsFloat);

      cdsDados.FieldByName(strCampo + cdsDados.FieldByName('TABELA').AsString + '_NOV').AsFloat :=
                          fCalculaPrecoVenda(intOpcCalculo,
                                             cdsDados.FieldByName('ITE_PRECUS_NOV').AsFloat + cdsDados.FieldByName('ITE_OUTVAL_NOV').AsFloat,
                                             cdsDados.FieldByName('ITE_PREVE' + cdsDados.FieldByName('TABELA').AsString + '_NOV').AsFloat,
                                             cdsDados.FieldByName('ITE_MARBR' + cdsDados.FieldByName('TABELA').AsString + '_NOV').AsFloat,
                                             cdsDados.FieldByName('ITE_ICMSAI_NOV').AsFloat,
                                             cdsDados.FieldByName('ITE_IMPFED_NOV').AsFloat,
                                             cdsDados.FieldByName('ITE_DESOPE_NOV').AsFloat,
                                             cdsDados.FieldByName('ITE_COMTB' + cdsDados.FieldByName('TABELA').AsString + '_NOV').AsFloat);

      If (intOpcCalculo = 1) And (intValArr > -1) Then
      Begin
        cdsDados.FieldByName(strCampo + cdsDados.FieldByName('TABELA').AsString + '_NOV').AsFloat := RoundTo(cdsDados.FieldByName(strCampo + cdsDados.FieldByName('TABELA').AsString + '_NOV').AsFloat,intValArr * -1);
        cdsDados.FieldByName('ITE_MARBR' + cdsDados.FieldByName('TABELA').AsString + '_NOV').AsFloat :=
                            fCalculaPrecoVenda(2,
                                               cdsDados.FieldByName('ITE_PRECUS_NOV').AsFloat + cdsDados.FieldByName('ITE_OUTVAL_NOV').AsFloat,
                                               cdsDados.FieldByName('ITE_PREVE' + cdsDados.FieldByName('TABELA').AsString + '_NOV').AsFloat,
                                               cdsDados.FieldByName('ITE_MARBR' + cdsDados.FieldByName('TABELA').AsString + '_NOV').AsFloat,
                                               cdsDados.FieldByName('ITE_ICMSAI_NOV').AsFloat,
                                               cdsDados.FieldByName('ITE_IMPFED_NOV').AsFloat,
                                               cdsDados.FieldByName('ITE_DESOPE_NOV').AsFloat,
                                               cdsDados.FieldByName('ITE_COMTB' + cdsDados.FieldByName('TABELA').AsString + '_NOV').AsFloat);

      End;

      cdsDados.FieldByName('ITE_PRCLIQ_NOV').AsFloat := fCalculaPrecoCompraLiq(cdsDados.FieldByName('ITE_PRECOM_NOV').AsFloat,
                                                                                             cdsDados.FieldByName('ITE_DESF01_NOV').AsFloat,
                                                                                             cdsDados.FieldByName('ITE_DESF02_NOV').AsFloat,
                                                                                             cdsDados.FieldByName('ITE_DESF03_NOV').AsFloat,
                                                                                             cdsDados.FieldByName('ITE_DESF04_NOV').AsFloat,
                                                                                             cdsDados.FieldByName('ITE_DESF05_NOV').AsFloat,
                                                                                             cdsDados.FieldByName('ITE_DESF06_NOV').AsFloat);

      cdsDados.FieldByName('ITE_MARBRU_NOV').AsFloat := cdsDados.FieldByName('ITE_MARBR' + cdsDados.FieldByName('TABELA').AsString + '_NOV').AsFloat;
      cdsDados.FieldByName('ITE_PREVEN_NOV').AsFloat := cdsDados.FieldByName('ITE_PREVE' + cdsDados.FieldByName('TABELA').AsString + '_NOV').AsFloat;
      cdsDados.Post;
      cdsDados.Next;

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TAtivaTabelaPreco.fCalculaPrecosAtivacaoPrg]');
    End;
  End;
End;

Function TAtivaTabelaPreco.fSQLAtualizaDadosIteger(intTabela: integer =1): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE ITEGER G SET ';

  strSQL := strSQL + '  G.ITE_PREALT = :PREALT,  ';

  strSQL := strSQL + '  G.ITE_MARBR' + intTabela.ToString + ' = :MARBRU, ';
  strSQL := strSQL + '  G.ITE_PREVE' + intTabela.ToString + ' = :PREVEN, ';
  strSQL := strSQL + '  G.ITE_TABPR' + intTabela.ToString + ' = :CODTAB';

  If fRetPrimeiraTabPrecoAtiva = intTabela Then
  Begin
    strSQL := strSQL + ', ';

    If strTipabf = '2' Then
      strSQL := strSQL + '  G.ITE_CODABF = :CODABF,';

    If strTpabpc = '2' Then
    Begin
      strSQL := strSQL + '  G.ITE_ABFPIS = :ABFPIS, ';
      strSQL := strSQL + '  G.ITE_ABFCOF = :ABFCOF, ';
      strSQL := strSQL + '  G.ITE_ABFIPI = :ABFIPI, ';
    End;

    strSQL := strSQL + '  G.ITE_PREDOL = :PREDOL, ';
    strSQL := strSQL + '  G.ITE_PRECOM = :PRECOM, ';
    strSQL := strSQL + '  G.ITE_DESF01 = :DESF01, ';
    strSQL := strSQL + '  G.ITE_DESF02 = :DESF02, ';
    strSQL := strSQL + '  G.ITE_DESF03 = :DESF03, ';
    strSQL := strSQL + '  G.ITE_DESF04 = :DESF04, ';
    strSQL := strSQL + '  G.ITE_DESF05 = :DESF05, ';
    strSQL := strSQL + '  G.ITE_DESF06 = :DESF06, ';
    strSQL := strSQL + '  G.ITE_ICMENT = :ICMENT, ';
    strSQL := strSQL + '  G.ITE_SUBFED = :SUBFED, ';
    strSQL := strSQL + '  G.ITE_IPIENT = :IPIENT, ';
    strSQL := strSQL + '  G.ITE_FREENT = :FREENT, ';
    strSQL := strSQL + '  G.ITE_VALFRE = :VALFRE, ';
    strSQL := strSQL + '  G.ITE_ACRFIN = :ACRFIN, ';
    strSQL := strSQL + '  G.ITE_SUBSTI = :SUBSTI, ';
    strSQL := strSQL + '  G.ITE_DESADB = :DESADB, ';
    strSQL := strSQL + '  G.ITE_PRECUS = :PRECUS, ';
    strSQL := strSQL + '  G.ITE_OUTVAL = :OUTVAL, ';
    strSQL := strSQL + '  G.ITE_ICMSAI = :ICMSAI, ';
    strSQL := strSQL + '  G.ITE_IMPFED = :IMPFED, ';
    strSQL := strSQL + '  G.ITE_DESOPE = :DESOPE, ';
    strSQL := strSQL + '  G.ITE_TCIFCU = :TCIFCU, ';
    strSQL := strSQL + '  G.ITE_TSCUST = :TSCUST, ';
    strSQL := strSQL + '  G.ITE_DEPICO = :DEPICO, ';
    strSQL := strSQL + '  G.ITE_DEICMS = :DEICMS, ';
    strSQL := strSQL + '  G.ITE_FATREG = :FATREG  ';
  End;

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '       ITE_CODITE = :CODITE ';
  strSQL := strSQL + '   AND ITE_CODEMP = :CODEMP ';
  Result := strSQL;
End;

Procedure TAtivaTabelaPreco.pAtualizaDadosIteger;
Begin
  qryIteger.Close;
  qryIteger.SQL.Text := fSQLAtualizaDadosIteger(cdsDados.FieldByName('TABELA').AsInteger);
  qryIteger.ParamByName('PREALT').AsString := strAgrupadorPreAlt;

  qryIteger.ParamByName('MARBRU').Value := cdsDados.FieldByName('ITE_MARBR' + cdsDados.FieldByName('TABELA').AsString + '_NOV').Value;
  qryIteger.ParamByName('PREVEN').Value := cdsDados.FieldByName('ITE_PREVE' + cdsDados.FieldByName('TABELA').AsString + '_NOV').Value;
  qryIteger.ParamByName('CODTAB').Value := cdsDados.FieldByName('ITE_CODTAB_NOV').Value;

  If fRetPrimeiraTabPrecoAtiva = cdsDados.FieldByName('TABELA').AsInteger Then
  Begin
    If strTipabf = '2' Then
      qryIteger.ParamByName('CODABF').Value := cdsDados.FieldByName('ITE_CODABF' + '_NOV').Value;

    If strTpabpc = '2' Then
    Begin
      qryIteger.ParamByName('ABFPIS').Value := cdsDados.FieldByName('ITE_ABFPIS' + '_NOV').Value;
      qryIteger.ParamByName('ABFCOF').Value := cdsDados.FieldByName('ITE_ABFCOF' + '_NOV').Value;
      qryIteger.ParamByName('ABFIPI').Value := cdsDados.FieldByName('ITE_ABFIPI' + '_NOV').Value;
    End;

    qryIteger.ParamByName('PREDOL').Value := cdsDados.FieldByName('ITE_PREDOL' + '_NOV').Value;
    qryIteger.ParamByName('PRECOM').Value := cdsDados.FieldByName('ITE_PRECOM' + '_NOV').Value;
    qryIteger.ParamByName('DESF01').Value := cdsDados.FieldByName('ITE_DESF01' + '_NOV').Value;
    qryIteger.ParamByName('DESF02').Value := cdsDados.FieldByName('ITE_DESF02' + '_NOV').Value;
    qryIteger.ParamByName('DESF03').Value := cdsDados.FieldByName('ITE_DESF03' + '_NOV').Value;
    qryIteger.ParamByName('DESF04').Value := cdsDados.FieldByName('ITE_DESF04' + '_NOV').Value;
    qryIteger.ParamByName('DESF05').Value := cdsDados.FieldByName('ITE_DESF05' + '_NOV').Value;
    qryIteger.ParamByName('DESF06').Value := cdsDados.FieldByName('ITE_DESF06' + '_NOV').Value;
    qryIteger.ParamByName('ICMENT').Value := cdsDados.FieldByName('ITE_ICMENT' + '_NOV').Value;
    qryIteger.ParamByName('SUBFED').Value := cdsDados.FieldByName('ITE_SUBFED' + '_NOV').Value;
    qryIteger.ParamByName('IPIENT').Value := cdsDados.FieldByName('ITE_IPIENT' + '_NOV').Value;
    qryIteger.ParamByName('FREENT').Value := cdsDados.FieldByName('ITE_FREENT' + '_NOV').Value;
    qryIteger.ParamByName('VALFRE').Value := cdsDados.FieldByName('ITE_VALFRE' + '_NOV').Value;
    qryIteger.ParamByName('ACRFIN').Value := cdsDados.FieldByName('ITE_ACRFIN' + '_NOV').Value;
    qryIteger.ParamByName('SUBSTI').Value := cdsDados.FieldByName('ITE_SUBSTI' + '_NOV').Value;
    qryIteger.ParamByName('DESADB').Value := cdsDados.FieldByName('ITE_DESADB' + '_NOV').Value;
    qryIteger.ParamByName('PRECUS').Value := cdsDados.FieldByName('ITE_PRECUS' + '_NOV').Value;
    qryIteger.ParamByName('OUTVAL').Value := cdsDados.FieldByName('ITE_OUTVAL' + '_NOV').Value;
    qryIteger.ParamByName('ICMSAI').Value := cdsDados.FieldByName('ITE_ICMSAI' + '_NOV').Value;
    qryIteger.ParamByName('IMPFED').Value := cdsDados.FieldByName('ITE_IMPFED' + '_NOV').Value;
    qryIteger.ParamByName('DESOPE').Value := cdsDados.FieldByName('ITE_DESOPE' + '_NOV').Value;
    qryIteger.ParamByName('TCIFCU').Value := cdsDados.FieldByName('ITE_TCIFCU' + '_NOV').Value;
    qryIteger.ParamByName('TSCUST').Value := cdsDados.FieldByName('ITE_TSCUST' + '_NOV').Value;
    qryIteger.ParamByName('DEPICO').Value := cdsDados.FieldByName('ITE_DEPICO' + '_NOV').Value;
    qryIteger.ParamByName('DEICMS').Value := cdsDados.FieldByName('ITE_DEICMS' + '_NOV').Value;
    qryIteger.ParamByName('FATREG').Value := cdsDados.FieldByName('ITE_FATREG' + '_NOV').Value;
  End;

  qryIteger.ParamByName('CODITE').Value := cdsDados.FieldByName('ITE_CODITE').Value;
  qryIteger.ParamByName('CODEMP').Value := cdsDados.FieldByName('ITE_CODEMP').Value;
  qryIteger.Execute;
End;

Function TAtivaTabelaPreco.fSQLAtualizaDadosCadIte: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE CADITE C SET ';

  If strTipabf = '1' Then
    strSQL := strSQL + '  C.ITE_CODABF = :CODABF,';

  If strTpabpc = '1' Then
  Begin
    strSQL := strSQL + '  C.ITE_ABFPIS = :ABFPIS, ';
    strSQL := strSQL + '  C.ITE_ABFCOF = :ABFCOF, ';
    strSQL := strSQL + '  C.ITE_ABFIPI = :ABFIPI, ';
  End;

  strSQL := strSQL + '  C.ITE_DESITE = :DESITE, ';
  strSQL := strSQL + '  C.ITE_CODFOR = :CODFOR, ';
  strSQL := strSQL + '  C.ITE_UNICOM = :UNICOM, ';
  strSQL := strSQL + '  C.ITE_MLTCOM = :MLTCOM, ';
  strSQL := strSQL + '  C.ITE_DIAFOR = :DIAFOR, ';
  strSQL := strSQL + '  C.ITE_CLAIPI = :CLAIPI, ';
  strSQL := strSQL + '  C.ITE_DESFAB = :DESFAB, ';
  strSQL := strSQL + '  C.ITE_CODFAB = :CODFAB, ';
  strSQL := strSQL + '  C.ITE_EMBALA = :EMBALA, ';
  strSQL := strSQL + '  C.ITE_BAREMB = :BAREMB, ';
  strSQL := strSQL + '  C.ITE_REFERE = :REFERE, ';
  strSQL := strSQL + '  C.ITE_CODBAR = :CODBAR, ';
  strSQL := strSQL + '  C.ITE_PESOIT = :PESOIT, ';
  strSQL := strSQL + '  C.ITE_SITPRO = :SITPRO, ';
  strSQL := strSQL + '  C.ITE_NOTESP = :NOTESP  ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '       ITE_CODITE = :CODITE ';
  Result := strSQL;
End;

Procedure TAtivaTabelaPreco.pAtualizaDadosCadIte;
  Var
   blnPrincipal: Boolean;
Begin
  qryCadIte.Close;

  If strTipabf = '1' Then
    qryCadIte.ParamByName('CODABF').Value := cdsDados.FieldByName('ITE_CODABF' + '_NOV').Value;

  If strTpabpc = '1' Then
  Begin
    qryCadIte.ParamByName('ABFPIS').Value := cdsDados.FieldByName('ITE_ABFPIS' + '_NOV').Value;
    qryCadIte.ParamByName('ABFCOF').Value := cdsDados.FieldByName('ITE_ABFCOF' + '_NOV').Value;
    qryCadIte.ParamByName('ABFIPI').Value := cdsDados.FieldByName('ITE_ABFIPI' + '_NOV').Value;
  End;
  qryCadIte.ParamByName('CODITE').Value := cdsDados.FieldByName('ITE_CODITE').AsString;
  qryCadIte.ParamByName('DESITE').Value := cdsDados.FieldByName('ITE_DESITE').AsString;
  qryCadIte.ParamByName('CODFOR').Value := cdsDados.FieldByName('ITE_CODFOR_NOV').Value;
  qryCadIte.ParamByName('UNICOM').Value := cdsDados.FieldByName('ITE_UNICOM_NOV').Value;
  qryCadIte.ParamByName('MLTCOM').Value := cdsDados.FieldByName('ITE_MLTCOM_NOV').Value;
  qryCadIte.ParamByName('DIAFOR').Value := cdsDados.FieldByName('ITE_DIAFOR_NOV').Value;
  qryCadIte.ParamByName('CLAIPI').Value := cdsDados.FieldByName('ITE_CLAIPI_NOV').Value;
  qryCadIte.ParamByName('DESFAB').Value := cdsDados.FieldByName('ITE_DESFAB_NOV').Value;
  qryCadIte.ParamByName('CODFAB').Value := cdsDados.FieldByName('ITE_CODFAB_NOV').Value;
  qryCadIte.ParamByName('REFERE').Value := cdsDados.FieldByName('ITE_REFERE_NOV').Value;
  qryCadIte.ParamByName('PESOIT').Value := cdsDados.FieldByName('ITE_PESOIT_NOV').Value;
  qryCadIte.ParamByName('SITPRO').Value := cdsDados.FieldByName('ITE_SITPRO_NOV').Value;
  qryCadIte.ParamByName('NOTESP').Value := cdsDados.FieldByName('ITE_NOTESP_NOV').Value;

  If Not fEmptyStr(cdsDados.FieldByName('ITE_CODBAR_NOV').AsString) Then
  Begin
    qryCadIte.ParamByName('CODBAR').Value := cdsDados.FieldByName('ITE_CODBAR_NOV').Value;

    objIteBar.pCarregaDados(cdsDados.FieldByName('ITE_CODITE').AsString);
    objIteBar.pIncluiCodigo(cdsDados.FieldByName('ITE_CODBAR_NOV').AsString,
                            1,    // fltEmbala
                            True, // blnPrinci
                            True, // blnCompra
                            True, // blnExbFat
                            0,    // fltPreVen
                            '',   // strDescri
                            '',   // strTabPre
                            cdsDados.FieldByName('ITE_CODFOR_NOV').AsString,
                            0,0,0,0,0,0,0,0);

    objIteBar.pSalvaDados(cdsDados.FieldByName('ITE_CODITE').AsString);
  End
  Else
    qryCadIte.ParamByName('CODBAR').Value := cdsDados.FieldByName('ITE_CODBAR_ATU').Value;

  If Not fEmptyStr(cdsDados.FieldByName('ITE_BAREMB_NOV').AsString) Then
  Begin
    qryCadIte.ParamByName('BAREMB').Value := cdsDados.FieldByName('ITE_BAREMB_NOV').Value;
    qryCadIte.ParamByName('EMBALA').Value := cdsDados.FieldByName('ITE_EMBALA_NOV').Value;

    objIteBar.IncluiPrincipalParaCompras(cdsDados.FieldByName('ITE_CODITE').AsString,
                                         cdsDados.FieldByName('ITE_BAREMB_NOV').AsString,
                                         cdsDados.FieldByName('ITE_EMBALA_NOV').AsFloat,
                                         blnPrincipal);

    If blnPrincipal Then
      qryCadIte.ParamByName('CODBAR').Value := cdsDados.FieldByName('ITE_BAREMB_NOV').AsString;

  End Else
    qryCadIte.ParamByName('BAREMB').Value := cdsDados.FieldByName('ITE_BAREMB_ATU').Value;

  qryCadIte.Execute;
End;

procedure TAtivaTabelaPreco.pAtualizaDadosDetCus;
begin
  qryDetCus.ParamByName('SEQDET').AsString := cdsDados.FieldByName('DET_SEQDET').AsString;
  qryDetCus.ParamByName('TABELA').AsString := cdsDados.FieldByName('TABELA').AsString;
  qryDetCus.ParamByName('PREVEN').AsFloat := cdsDados.FieldByName('ITE_PREVE' + cdsDados.FieldByName('TABELA').AsString + '_NOV').AsFloat *
                                             cdsDados.FieldByName('ITE_CNVCUS_NOV').AsFloat;
  qryDetCus.ParamByName('MARBRU').AsFloat := cdsDados.FieldByName('ITE_MARBR' + cdsDados.FieldByName('TABELA').AsString + '_NOV').AsFloat;
  qryDetCus.ExecSQL;
end;

Function TAtivaTabelaPreco.fAtualizaPrecos: Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  Result := TfrmGravando.fExecuta(fAtualizaPrecosPrg, frmGravando, 'Aguarde, atualizado preços...');
End;

Function TAtivaTabelaPreco.fAtualizaPrecosPrg(cxProgresso: TcxProgressBar): Boolean;
Begin
  Try
    pPreAltDefineVariaveisAltPre(fNow, 'ATIVAÇÃO TABELA DE PREÇOS', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

    qryIteger := fCriaQuery;
    qryIteger.SQL.Text := fSQLAtualizaDadosIteger;

    qryCadIte := fCriaQuery;
    qryCadIte.SQL.Text := fSQLAtualizaDadosCadIte;

    qryTabDet := fCriaQuery;
    qryTabDet.SQL.Text := fSQLUpdateTabDet;

    qryDetCus := fCriaQuery;
    qryDetCus.SQL.Text := fSQLUpdateDetCus;

    cdsDados.DisableControls;
    cdsDados.Filter   := 'MARCADO = ' + QuotedStr('S');
    cdsDados.Filtered := True;

    cxProgresso.Properties.Max := cdsDados.RecordCount;
    cxProgresso.Position := 0;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      fStartTransaction;

      pAtualizaDadosIteger;

      pAtualizaDadosDetCus;

      If fRetPrimeiraTabPrecoAtiva = cdsDados.FieldByName('TABELA').AsInteger Then
        pAtualizaDadosCadIte;

      If blnAtualizarPrecoRevista Then
        pAtualizaCopiaPrecoRevista(cdsDados.FieldByName('ITE_CODTAB_NOV').AsString,
                                   cdsDados.FieldByName('ITE_CODITE').AsString,
                                   cdsDados.FieldByName('ITE_CODEMP').AsString,
                                   cdsDados.FieldByName('ITE_PREREV_ATU').AsFloat,
                                   cdsDados.FieldByName('ITE_MARFEC_ATU').AsFloat);

      stlLisTab.Add(QuotedStr(cdsDados.FieldByName('ITE_CODTAB_NOV').AsString));
      stlLisFor.Add(QuotedStr(cdsDados.FieldByName('ITE_CODFOR_NOV').AsString));




      Result := fGravaAlteracaoPreco;

      If Not Result Then
      Begin
        fRollBack;
        Break;
      End;

      fCommit;

      cdsDados.Next;

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    If blnMarcarAtiva Then
      pAtivaTabelasParaCompra;

    Result := True;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[TAtivaTabelaPreco.fCalculaPrecosAtivacaoPrg]');
    End;
  End;

  cdsDados.Filtered := False;
  cdsDados.Filter   := '';
  cdsDados.EnableControls;

  FreeAndNil(qryIteger);
  FreeAndNil(qryCadIte);
  FreeAndNil(qryDetCus);

End;

procedure TAtivaTabelaPreco.pAtivaTabelasParaCompra;
  Var
    qryTabPre: TUniquery;
Begin
  qryTabPre := fCriaQuery(Self);

  If stlLisFor.Count > 0 Then
  Begin
    qryTabPre.Close;
    qryTabPre.SQL.Clear;
    qryTabPre.SQL.Add('UPDATE TABPRE SET TAB_ATICMP = "N"');
    qryTabPre.SQL.Add('WHERE');
    qryTabPre.SQL.Add('  TAB_CODFOR IN (' + stlLisFor.CommaText + ')');
    qryTabPre.ExecSQL;
  End;

  If stlLisTab.Count > 0 Then
  Begin
    qryTabPre.Close;
    qryTabPre.SQL.Clear;
    qryTabPre.SQL.Add('UPDATE TABPRE SET TAB_ATICMP = "S"');
    qryTabPre.SQL.Add('WHERE');
    qryTabPre.SQL.Add('  TAB_CODTAB IN (' + stlLisTab.CommaText + ')');
    qryTabPre.ExecSQL;
  End;

  FreeAndNil(qryTabPre);
End;

procedure TAtivaTabelaPreco.pAtualizaCopiaPrecoRevista(strCodTabNew, strCodIte, strCodEmp: String; fltPreRev, fltMarFec: Double);
Begin
  qryTabDet.Close;
  qryTabDet.ParamByName('CODITE').AsString := strCodIte;
  qryTabDet.ParamByName('CODEMP').AsString := strCodEmp;
  qryTabDet.ParamByName('CODTAB').AsString := strCodTabNew;
  qryTabDet.ParamByName('PREREV').AsFloat  := fltPreRev;
  qryTabDet.ParamByName('MARFEC').AsFloat  := fltMarFec;
  qryTabDet.ExecSQL;
End;

function TAtivaTabelaPreco.fSQLUpdateDetCus: String;
begin
  Result := '';
  Result := Result + 'UPDATE DETCUS SET ';
  Result := Result + '       DET_PREVEN = :PREVEN, ';
  Result := Result + '       DET_MARBRU = :MARBRU ';
  Result := Result + ' WHERE DET_SEQDET = :SEQDET ';
  Result := Result + '   AND DET_TABELA = :TABELA ';

end;

Function TAtivaTabelaPreco.fSQLUpdateTabDet: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE TABDET D ';
  strSQL := strSQL + ' INNER JOIN ITEFOR F ON F.AUTOINCREM = D.ITE_SEQGER ';
  strSQL := strSQL + ' SET';
  strSQL := strSQL + '   D.ITE_PREREV = :PREREV, ';
  strSQL := strSQL + '   D.ITE_MARFEC = :MARFEC  ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   F.ITE_CODTAB = :CODTAB AND ';
  strSQL := strSQL + '   F.ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '   D.ITE_CODEMP = :CODEMP     ';

  Result := strSQL;
End;

Function TAtivaTabelaPreco.fGravaAlteracaoPreco: Boolean;
Begin
  Result := True;

  If (Not VS_blnPreAltViaTrigger) Then
    Result := fGravaPreAlt(cdsDados.FieldByName('ITE_CODITE').AsString,
                           cdsDados.FieldByName('ITE_PRECUS_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_PRECUS_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_PREVE1_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_PREVE1_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_MARBR1_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_MARBR1_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_PREVE2_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_PREVE2_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_MARBR2_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_MARBR2_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_PREVE3_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_PREVE3_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_MARBR3_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_MARBR3_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_PREVE4_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_PREVE4_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_MARBR4_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_MARBR4_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_PREVE5_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_PREVE5_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_MARBR5_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_MARBR5_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_PREVE6_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_PREVE6_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_MARBR6_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_MARBR6_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_PREVE7_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_PREVE7_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_MARBR7_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_MARBR7_NOV').AsFloat,

                           cdsDados.FieldByName('ITE_PRECOM_ATU').AsFloat,
                           cdsDados.FieldByName('ITE_PRECOM_NOV').AsFloat,

                           'ATIVAÇÃO TABELA DE PREÇOS',

                           Nil,
                           '',
                           strLoginUsuarioLogado);
End;

Function TAtivaTabelaPreco.fMarcaTodos(blnMarcar: Boolean): Boolean;
  Var
    frmGravando: TfrmGravando;
begin
  FMarcar := blnMarcar;
  Result := TfrmGravando.fExecuta(fMarcaTodosPrg, frmGravando, 'Marcando itens...');
End;

procedure TAtivaTabelaPreco.pMarcaItem(blnMarcar: Boolean);
begin
  cdsDados.Edit;
  cdsDados.FieldByName('MARCADO').AsString := IIF(blnMarcar, 'S', 'N');
  cdsDados.Post;
end;

procedure TAtivaTabelaPreco.pMarcaDesmarca;
Begin
  pMarcaItem(cdsDados.FieldByName('MARCADO').AsString = 'N');
End;

Function TAtivaTabelaPreco.fMarcaTodosPrg(cxProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  If cdsDados.IsEmpty Then
    Exit;

  cdsDados.DisableControls;

  Try
    cxProgresso.Properties.Max := cdsDados.RecordCount;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      pMarcaItem(FMarcar);
      cdsDados.Next;

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  Finally
    cdsDados.EnableControls;
  End;

end;

Procedure TAtivaTabelaPreco.pFormataCampos;
  Var
    intContador: Integer;
Begin
  For intContador := 0 To cdsDados.FieldCount - 1 Do
    If cdsDados.Fields[intContador].DataType = ftFloat Then
    Begin
      If (Pos('PRECOM', cdsDados.Fields[intContador].FieldName) > 0) Or
         (Pos('VALFRE', cdsDados.Fields[intContador].FieldName) > 0) Or
         (Pos('PRECUS', cdsDados.Fields[intContador].FieldName) > 0) Or
         (Pos('OUTVAL', cdsDados.Fields[intContador].FieldName) > 0) Or
         (Pos('PREVE', cdsDados.Fields[intContador].FieldName) > 0) Then
        cdsDados.pFormataDecimal(cdsDados.Fields[intContador].FieldName, intDecUni)
      Else
        cdsDados.pFormataDecimal(cdsDados.Fields[intContador].FieldName, 2);
   End;

  cdsDados.pAlinhaCampoCentro('ITE_CODITE');
  cdsDados.pAlinhaCampoCentro('ITE_CODEMP');
  cdsDados.pAlinhaCampoCentro('ITE_CLAIPI_ATU');
  cdsDados.pAlinhaCampoCentro('ITE_CLAIPI_NOV');
  cdsDados.pAlinhaCampoCentro('ITE_EXCIPI_ATU');
  cdsDados.pAlinhaCampoCentro('ITE_EXCIPI_NOV');
  cdsDados.pAlinhaCampoCentro('TFO_NOTESP_ATU');
  cdsDados.pAlinhaCampoCentro('TFO_NOTESP_NOV');
  cdsDados.pAlinhaCampoCentro('SIGUNI_ATU');
  cdsDados.pAlinhaCampoCentro('SIGUNI_NOV');
  cdsDados.pAlinhaCampoCentro('ITE_CODABF_ATU');
  cdsDados.pAlinhaCampoCentro('ITE_CODABF_NOV');
  cdsDados.pAlinhaCampoCentro('ITE_ABFPIS_ATU');
  cdsDados.pAlinhaCampoCentro('ITE_ABFPIS_NOV');
  cdsDados.pAlinhaCampoCentro('ITE_ABFIPI_ATU');
  cdsDados.pAlinhaCampoCentro('ITE_ABFIPI_NOV');
  cdsDados.pAlinhaCampoCentro('ITE_ABFCOF_ATU');
  cdsDados.pAlinhaCampoCentro('ITE_ABFCOF_NOV');
  cdsDados.pAlinhaCampoCentro('TFO_SITPRO_ATU');
  cdsDados.pAlinhaCampoCentro('TFO_SITPRO_NOV');
  cdsDados.pAlinhaCampoCentro('TFO_PRDGRU_ATU');
  cdsDados.pAlinhaCampoCentro('TFO_PRDGRU_NOV');
  cdsDados.pAlinhaCampoCentro('ITE_CODFOR_ATU');
  cdsDados.pAlinhaCampoCentro('ITE_CODFOR_NOV');

  cdsDados.pAlinhaCampoCentro('ITE_CODTAB_ATU');
  cdsDados.pAlinhaCampoCentro('ITE_CODTAB_NOV');
End;

end.


