unit untQckLiberacaoArmazenamento;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, Uni, StrUtils,
  frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  MaskUtils, untIFuncoes, untCfgRel, frxDMPClass, Forms, untTypesSistema;

type
  TfrmQckLiberacaoArmazenamento = class(TForm)
    frxRelatorio: TfrxDBDataset;
    frxReportM: TfrxReport;
    frxMatricial: TfrxDotMatrixExport;
    frxReportJ: TfrxReport;
    frxReportM_Mod2: TfrxReport;
    frxReportJ_Mod2: TfrxReport;
    frxReportM_Mod3: TfrxReport;
    frxReportJ_Mod3: TfrxReport;
    frxReportJ_Mod5: TfrxReport;
    frxReportJ_Mod4: TfrxReport;
    frxReportM_Mod4: TfrxReport;
    frxReportM_Mod6: TfrxReport;
    frxReportJ_Mod6: TfrxReport;
    frxReportM_Mod7: TfrxReport;
    frxReportJ_Mod7: TfrxReport;
    frxReportJ_Mod8: TfrxReport;
    frxReportM_Mod8: TfrxReport;
    frxReportJ_Mod10: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    function frxReportMUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    qryRelatorio : TUniQuery;
    FstrEspDoc, strNomImp, strTipImp: String;
    strModeloImpressao : String;
    FstrDestino : String;
    FstrFila    : String;
    blnExiApl   : Boolean;

    fltResultAguarda, fltResultFalta : Double;
    strUltCodIte : String;

    function fGeraSqlPreNota(strIdeDig : String) : String;
    procedure pRetornaQuantidadeEntregasPendentesItem(strCodIte: String; Var fltAguarda, fltFalta : Double );
    procedure pAbreRelatorio(blnOrigemPreNota: Boolean = False);
    Function fFormataTelefone(strFone: String): String;
    function fGeraSqlPedidoCompra(strIdeDig: String): String;


  public
    blnSQLPedidoCompra: Boolean;
    blnOk: boolean;
    blnUsaCadSem: Boolean;
    procedure pUtilizarCadSem;
    function fGeraSql(intSeqPar: Integer; strCliFor : String; blnFiltroPorAutoIncrem: boolean = False; ASeqFatEnd: String = '') : String;
    procedure pImprimir(strNumDoc, strEspDoc, strSerie, strCodFor, strCodEmp, strFila : String; strDestino : String = ''; strCliFor : String = 'F'; oriLibOrigem: TOriImpressaoLiberaArmazenagem = oriLibEntradaDadosCaixa; blnCadSem: Boolean = False; ASeqFatEnd: String = ''); overload;
    procedure pImprimir(strIdeDig, strFila : String; strDestino : String = ''; oriLibOrigem: TOriImpressaoLiberaArmazenagem = oriLibEntradaDadosCaixa); overload;
    procedure pImprimir(stlListaMovGer: TStringList; strFila: String; strDestino: String; oriLibOrigem: TOriImpressaoLiberaArmazenagem = oriLibEntradaDadosCaixa); overload;
    procedure pImprimirDocumentos(stlDocumentos, stlEspecies, stlSeries, stlEmpresas, stlFornecedores, stlTipFC : TStringList; strFila : String; strDestino : String = ''; oriLibOrigem: TOriImpressaoLiberaArmazenagem = oriLibEntradaDadosCaixa; blnCadSem: Boolean = False; ASeqFatEnd: String = '');
  end;


implementation

uses untFuncoesSimples, untFuncoesGenerica, Data.DB, untEditorFastImpressao, TypesRel;

{$R *.dfm}

procedure TfrmQckLiberacaoArmazenamento.DataModuleCreate(Sender: TObject);
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

  fltResultAguarda := 0;
  fltResultFalta   := 0;
  strUltCodIte     := '';
  strModeloImpressao := fCfgSis('MODLIB', varString);
  blnOk := False;
  blnExiApl := fCfgSis('EXIAPL', varBoolean);
  blnUsaCadSem := False;
end;

function TfrmQckLiberacaoArmazenamento.fGeraSqlPreNota(strIdeDig : String): String;
  Var
    qryVencimento : TUniQuery;
    arrData : TDateArray;
    strCondicao : String;
Begin
  qryVencimento := fCriaQuery(Self);
  With qryVencimento, Sql Do
  Begin
    Add('SELECT DISTINCT DUP_DTAVEN, B09_DEMI                    ');
    Add(' FROM DIGELE D                                          ');
    Add('   INNER JOIN GERELE NE ON D.DIG_IDEDIG = NE.GER_IDEDIG ');
    Add('   INNER JOIN DUPELE ON DUP_SEQELE = NE.AUTOINCREM      ');
    Add('WHERE D.DIG_IDEDIG = :IDEDIG                            ');
    Add('ORDER BY DUP_DTAVEN                                     ');

    ParamByName('IDEDIG').AsString := strIdeDig;

    Open;

    SetLength(arrData, RecordCount);

    While Not Eof Do
    Begin
      arrData[RecNo-1] := FieldByName('DUP_DTAVEN').AsDateTime;
      Next;
    End;

    strCondicao := fRetornaCndPag(arrData, FieldByName('B09_DEMI').AsDateTime);

  End;
  FreeAndNil(qryVencimento);

  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE             ';
  Result := Result + '			  /*DADOS EMPRESA*/        ';
  Result := Result + '				EMP_NOMEMP,              ';
  Result := Result + '        CONCAT(EMP_ENDERE, CONCAT(", ", EMP_ENDNUM)) AS EMP_ENDERE, ';
  Result := Result + '			  EMP_BAIRRO,              ';
  Result := Result + '			  EMP_C_E_P_,              ';
  Result := Result + '			  EMP_FONE01,              ';
  Result := Result + '        C1.CID_NOMCID AS EMPCID, ';

  Result := Result + '			  /*DADOS FORNECEDOR*/     ';
  Result := Result + '				FOR_CODFOR,              ';
  Result := Result + '				FOR_NOMFOR,              ';
  Result := Result + '				FOR_ENDERE,              ';
  Result := Result + '				FOR_BAIRRO,              ';
  Result := Result + '				FOR_C_E_P_,              ';
  Result := Result + '				FOR_CGCCPF,              ';
  Result := Result + '				FOR_C_G_C_,              ';
  Result := Result + '				FOR_I_E_S_,              ';
  Result := Result + '				FOR_FONE01,              ';
  Result := Result + '				C2.CID_NOMCID AS FORCID, ';

  Result := Result + '				/*DADOS ENTRADA*/             ';
  If (strModeloImpressao = '6') Or (strModeloImpressao = '10') Then
    Result := Result + '				IF(GER_DOCNUM IS NULL, "ITEM CONFERIDO SEM LASTRO COM NF", CONCAT(GER_DOCNUM, " EMP: ", EMP_CODEMP)) AS GER_DOCNUM, '
  Else
    Result := Result + '				IF(GER_DOCNUM IS NULL, "ITEM CONFERIDO SEM LASTRO COM NF", CONCAT(GER_DOCNUM, "NF")) AS GER_DOCNUM, ';
  Result := Result + '				GER_DOCNUM AS GER_NUMDOC,        ';
  Result := Result + '				"NF" AS GER_ESPDOC,           ';
  Result := Result + QuotedStr(strCondicao) + ' AS GER_CONPAG,';
  Result := Result + '			  GER_OPECON AS GER_CODVEN,     ';
  Result := Result + '			  VEN.OPE_NOMOPE AS OPE_NOMOPE, ';
  Result := Result + '				GER_DTACON AS GER_DTAENT,     ';
  Result := Result + '				GER_HORCON AS GER_HORENT,     ';
  Result := Result + '				VEN.OPE_NOMOPE AS NOMDIG,     ';

  Result := Result + '				/*ITENS DA ENTRADA*/         ';
  Result := Result + '				UNI_SIGUNI,                  ';
  Result := Result + '				D.DIG_CODITE AS DET_CODITE,  ';
  Result := Result + '				ITE_DESITE,                  ';
  Result := Result + '				MAR_DESMAR,                  ';
  Result := Result + '				I.ITE_MLTVEN,                ';
  If (strModeloImpressao = '6') Or (strModeloImpressao = '10') Then
    Result := Result + '				SUM(D.DIG_QTDITE) AS DET_QTDITE, '
  Else
    Result := Result + '				D.DIG_QTDITE AS DET_QTDITE,  ';
  Result := Result + '				ITE_LOCFIS,                  ';
  Result := Result + '				ITE_REFERE,                  ';
  Result := Result + '				ITE_CODFAB,                  ';
  Result := Result + '        ITE_CODBAR,                  ';
  Result := Result + '        NULL AS DTADOC,              '; //MF: 320685 - 23/02/24
  If blnExiApl Then
    Result := Result + ' REPLACE( SUBSTRING(ITE_APLICA, 1, 255), ''<<csq>>'',''  '') AS ITE_APLICA, ';
  Result := Result + '				" " AS ENTSAI ';

  if (strModeloImpressao = '3') OR (strModeloImpressao = '4')  OR (strModeloImpressao = '5') OR (strModeloImpressao = '8') Then
  Begin
    Result := Result + '      , ';
    if not blnUsaCadSem then
    begin
      Result := Result + '      ( SELECT CONCAT( IF( IFNULL(I.ITE_CODFAB,"") <> "", CONCAT(I.ITE_CODFAB, ","), ""), GROUP_CONCAT(IFNULL(IFNULL(ITEFOR.ITE_CODFAB, ITE_CODITF),""))) ';
      Result := Result + '        FROM ITEFOR    ';
      Result := Result + '        WHERE ITEFOR.ITE_CODITE = I.ITE_CODITE ) AS ITE_CDFABS, ';
    end
    else
    begin
      Result := Result + '      ( SELECT GROUP_CONCAT(DISTINCT IFNULL(SEM_CODSEM,"")) FROM CADSEM WHERE SEM_CODITE = I.ITE_CODITE ) AS ITE_CDFABS, ';
    end;

    Result := Result + '      (                                        ';
    Result := Result + '      SELECT GROUP_CONCAT(IFNULL(ITEBAR.BAR_CODBAR,""))   ';
    Result := Result + '      FROM ITEBAR                              ';
    Result := Result + '      WHERE ITEBAR.BAR_CODITE = I.ITE_CODITE   ';
    Result := Result + '      ) AS ITE_CDBARS,                         ';
    Result := Result + '      ITE_LOCSUP, ';

    Result := Result + '      (SELECT GROUP_CONCAT(DISTINCT CONCAT(GEX.B08_NNF,"-NF") SEPARATOR " / ") ';
    Result := Result + '       FROM GERELE GEX                                                         ';
    Result := Result + '       WHERE GEX.GER_IDEDIG = :IDEDIG                                          ';
    Result := Result + '         AND GEX.GER_CODEMP = :CODEMP) AS NOTAS                                ';
  End;

  Result := Result + ' FROM          ';
  Result := Result + '   DIGELE D    ';

  Result := Result + 'LEFT JOIN (SELECT ';
  If (strModeloImpressao = '6') Or (strModeloImpressao = '10') Then
    Result := Result + '				GROUP_CONCAT(B08_NNF, " - NF - ", B07_SERIE) AS GER_DOCNUM, '
  Else
    Result := Result + '    GROUP_CONCAT(GE.B08_NNF) AS GER_DOCNUM,';
  Result := Result + '                   DE.DET_CODITE,';
  Result := Result + '                   GE.GER_CODFOR,';
  Result := Result + '                   GER_OPECON,';
  Result := Result + '                   GER_DTACON,';
  Result := Result + '                   GER_HORCON';
  Result := Result + '              FROM GERELE GE';
  Result := Result + '             INNER JOIN DETELE DE ON DE.DET_SEQGER = GE.AUTOINCREM';
  Result := Result + '             WHERE GE.GER_IDEDIG  = :IDEDIG';
  Result := Result + '             GROUP BY DE.DET_CODITE) A ON A.DET_CODITE = D.DIG_CODITE ';
  Result := Result + '  INNER JOIN CADITE I ON I.ITE_CODITE = D.DIG_CODITE ';
  Result := Result + '  INNER JOIN CADEMP ON EMP_CODEMP = :CODEMP';
  Result := Result + '  INNER JOIN ITEGER G ON G.ITE_CODITE = DIG_CODITE AND G.ITE_CODEMP = :CODEMP';
  Result := Result + '   LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';
  Result := Result + '   LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  Result := Result + '   LEFT JOIN CADCID C1 ON C1.CID_CODCID = EMP_CODCID';
  Result := Result + '   LEFT JOIN CADFOR ON FOR_CODFOR = GER_CODFOR ';
  Result := Result + '   LEFT JOIN CADCID C2 ON C2.CID_CODCID = FOR_CODCID ';
  Result := Result + '   LEFT JOIN CADOPE VEN ON VEN.OPE_CODOPE = GER_OPECON ';
  Result := Result + ' WHERE      ';
  Result := Result + '   D.DIG_IDEDIG = :IDEDIG';
  Result := Result + '   AND DIG_CODEMP = :CODEMP';
  Result := Result + ' GROUP BY       ';
  If (strModeloImpressao = '6') Or (strModeloImpressao = '10') Then
  Begin
    Result := Result + '   D.DIG_CODITE ';
    Result := Result + ' ORDER BY ITE_DESITE ';
  End
  Else
    Result := Result + '   D.AUTOINCREM ';

  if (strModeloImpressao = '3') or  (strModeloImpressao = '4') OR (strModeloImpressao = '5') OR (strModeloImpressao = '8') Then
    Result := Result + ' ORDER BY ITE_LOCFIS ';
End;

function TfrmQckLiberacaoArmazenamento.fGeraSql(intSeqPar: Integer; strCliFor : String; blnFiltroPorAutoIncrem: boolean = False; ASeqFatEnd: String = ''): String;
var
  blnNumser: Boolean;
begin
  blnNumser := fCfgSis('NUMSER', varBoolean);
  Result := '';

  Result := Result + '/*TfrmQckLiberacaoArmazenamento.fGeraSql*/ ';
  Result := Result + 'SELECT  /*DADOS EMPRESA*/  ';
  Result := Result + '				EMP_NOMEMP, ';
  Result := Result + '        CONCAT(EMP_ENDERE, CONCAT(", ", EMP_ENDNUM)) AS EMP_ENDERE, ';
  Result := Result + '			  EMP_BAIRRO, ';
  Result := Result + '			  EMP_C_E_P_, ';
  Result := Result + '			  EMP_FONE01, ';
  Result := Result + '        C1.CID_NOMCID AS EMPCID, ';

  If strCliFor = 'F' Then
  Begin
    Result := Result + '			  /*DADOS FORNECEDOR*/ ';
    Result := Result + '				FOR_CODFOR, ';
    Result := Result + '				FOR_NOMFOR, ';
    Result := Result + '				FOR_ENDERE, ';
    Result := Result + '				FOR_BAIRRO, ';
    Result := Result + '				FOR_C_E_P_, ';
    Result := Result + '				FOR_CGCCPF, ';
    Result := Result + '				FOR_C_G_C_, ';
    Result := Result + '				FOR_I_E_S_, ';
    Result := Result + '				FOR_FONE01, ';
    Result := Result + '				C2.CID_NOMCID AS FORCID, ';
  End
  Else
  Begin
    Result := Result + '			  /*DADOS CLIENTE*/ ';
    Result := Result + '				CL.CLI_CODCLI AS FOR_CODFOR, ';
    Result := Result + '				CL.CLI_NOMCLI AS FOR_NOMFOR, ';
    Result := Result + '				CL.CLI_ENDERE AS FOR_ENDERE, ';
    Result := Result + '				CL.CLI_BAIRRO AS FOR_BAIRRO, ';
    Result := Result + '				CL.CLI_C_E_P_ AS FOR_C_E_P_, ';
    Result := Result + '				CL.CLI_CGCCPF AS FOR_CGCCPF, ';
    Result := Result + '				CL.CLI_C_G_C_ AS FOR_C_G_C_, ';
    Result := Result + '				CL.CLI_I_E_S_ AS FOR_I_E_S_, ';
    Result := Result + '				CL.CLI_FONE01 AS FOR_FONE01, ';
    Result := Result + '				C2.CID_NOMCID AS FORCID,  ';
  End;

  Result := Result + '				/*DADOS ENTRADA*/ ';
  If (strModeloImpressao = '6') Or (strModeloImpressao = '10') Then
    Result := Result + '				CONCAT(GER_NUMDOC, " - ", GER_ESPDOC, " - ", IFNULL(GER_SERIE_, ""), " EMP: ", EMP_CODEMP) AS GER_DOCNUM, '
  Else
    Result := Result + '				CONCAT(GER_NUMDOC, GER_ESPDOC) AS GER_DOCNUM, ';
  Result := Result + '				GER_NUMDOC, ';
  Result := Result + '				GER_ESPDOC, ';
  Result := Result + '			  GER_CONPAG, ';
  Result := Result + '			  GER_CODVEN, ';
  Result := Result + '			  VEN.OPE_NOMOPE AS OPE_NOMOPE, ';
  Result := Result + '				GER_DTAENT, ';
  Result := Result + '				GER_HORENT, ';
  Result := Result + '				DIG.OPE_NOMOPE AS NOMDIG, ';
  Result := Result + '				GER.GER_DTADOC AS DTADOC, '; //MF: 320685 - 16/02/24

  Result := Result + '				/*ITENS DA ENTRADA*/ ';

  Result := Result + '				UNI_SIGUNI, ';
  Result := Result + '				DET_CODITE, ';
  Result := Result + '				IF(LOCATE("ITEM ESPECIAL", ITE_DESITE), DET_DESCRI, ITE_DESITE) AS ITE_DESITE, ';
  Result := Result + '				MAR_DESMAR, ';
  Result := Result + '				I.ITE_MLTVEN, ';

  If blnNumSer And (strModeloImpressao[1] = '1') Then
  Begin
    Result := Result + ' (SELECT GROUP_CONCAT(SER_NUMSER SEPARATOR ", ") AS SER_NUMSER ';
    Result := Result + '  FROM PROSER ';
    Result := Result + '  WHERE SER_CODITE = DET.DET_CODITE  ';
    Result := Result + '   AND  SER_CODEMP = DET.DET_CODEMP) AS SER_NUMSER,  ';
  End
  Else
    Result := Result + ' CAST("" AS CHAR(1)) AS SER_NUMSER, ';

  If (strModeloImpressao = '6') Or (strModeloImpressao = '10') Then
    Result := Result + '				SUM(DET_QTDITE) AS DET_QTDITE, '
  Else
  Begin
    If not fEmptyStr(ASeqFatEnd) Then
      Result := Result + ' IFNULL(FTE_QTDITE, DET_QTDITE) AS DET_QTDITE, '
    Else
      Result := Result + ' DET_QTDITE, ';
  End;

  Result := Result + '				IF(DET_CLAFIS < "5000", "ENT", "SAI") AS ENTSAI, ';

  Result := Result + '        DET_ESPDOC, ';
  Result := Result + ' IF(IFNULL(LOT_NUMLOT, "") = "", IFNULL(ITE_SALDOS, 0) + IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_F, 0) + IFNULL(ITE_QTEF_P, 0), ';
  Result := Result + '                                 IFNULL(LOT_SALDOS, 0) + IFNULL(LOT_QTEF_A, 0) + IFNULL(LOT_QTEF_F, 0) + IFNULL(LOT_QTEF_P, 0)) AS LOT_SALDOS, ';

  {************************************************************************************************}
  {   Se for TA ja pega o a localização Fisica do Lote                                             }
  {   Se exitir vinculo entre o documento e alguma TA, pega A localização fisica que estiver na TA, }
  {   Senão pega ITE_LOCFIS                                                                        }
  {**********************************************************************************************WG}

  Result := Result + '  IF(DET_ESPDOC = "TA",  IFNULL((SELECT (SELECT CONCAT(GER_CODFOR, " - ", FOR_NOMFOR) FROM CADFOR WHERE FOR_CODFOR =  GER_CODFOR)';
  Result := Result + '                                   FROM MOVGER  WHERE  MOVGER.AUTOINCREM=A.AUX_SEQDOR), ';
  Result := Result + '                         (SELECT (SELECT CONCAT(GER_CODFOR, " - ", FOR_NOMFOR) FROM CADFOR WHERE FOR_CODFOR =  GER_CODFOR) ';
  Result := Result + '                            FROM MOVGER WHERE MOVGER.AUTOINCREM=A.AUX_SEQDOR)), "") AS FORORI, ';


  Result := Result + '  IF(DET_ESPDOC = "TA",  IFNULL((SELECT CONCAT(GER_NUMDOC," - ", GER_ESPDOC," - ",GER_CODEMP)  ';
  Result := Result + '                                   FROM MOVGER  WHERE  MOVGER.AUTOINCREM=A.AUX_SEQDOR), ';
  Result := Result + '                         (SELECT CONCAT(GER_NUMDOC," - ", GER_ESPDOC," - ",GER_CODEMP) ';
  Result := Result + '                            FROM MOVGER WHERE MOVGER.AUTOINCREM=A.AUX_SEQDOR)), "") AS DOCORI_TA, ';

  Result := Result + '  IF(DET_ESPDOC = "TA" AND DET_NUMLOT <> "", ';
  Result := Result + '     IF(DET_NUMLOT = "A DEFINIR", "A DEFINIR", LOT_LOCFIS), ';
  Result := Result + '     IF((SELECT COUNT(1) ';
  Result := Result + '           FROM AUXMOV ';
  Result := Result + '          WHERE AUX_SEQDOR = GER.AUTOINCREM ) = 0,';
  Result := Result + '        ITE_LOCFIS, ';
  Result := Result + '        (SELECT GROUP_CONCAT(DISTINCT L2.LOT_LOCFIS) ';
  Result := Result + '           FROM AUXMOV, ';
  Result := Result + '                MOVDET D2, ';
  Result := Result + '                CADLOT L2 ';
  Result := Result + '          WHERE AUX_SEQDOR = GER.AUTOINCREM ';
  Result := Result + '            AND D2.DET_SEQGER = AUXMOV.AUX_SEQGER ';
  Result := Result + '            AND D2.DET_CODITE = DET.DET_CODITE ';
  Result := Result + '            AND D2.DET_ESPDOC = "TA" ';
  Result := Result + '            AND LEFT(D2.DET_CLAFIS, 1) < 5 ';
  Result := Result + '            AND D2.DET_QTDITE > 0 ';
  Result := Result + '            AND L2.LOT_NUMLOT = D2.DET_NUMLOT ';
  Result := Result + '            AND L2.LOT_CODEMP = D2.DET_CODEMP ';
  Result := Result + '            AND L2.LOT_CODITE = D2.DET_CODITE))) AS ITE_LOCFIS, ';

///  Result := Result + '        IF(DET_ESPDOC = "TA" AND DET_NUMLOT <> "", LOT_LOCFIS, ITE_LOCFIS) AS ITE_LOCFIS, ';

  Result := Result + '				ITE_REFERE, ';
  Result := Result + '				ITE_CODFAB, ';
  Result := Result + '        ITE_CODBAR, ';

  Result := Result + '        CR.CLI_NOMCLI, ';
  Result := Result + '        MR.RCD_CODIGO, ';

  Result := Result + '        ITE_LOCSUP  ';
  If blnExiApl Then
    Result := Result + ', REPLACE( SUBSTRING(ITE_APLICA, 1, 255), ''<<csq>>'',''  '') AS ITE_APLICA ';

  if (strModeloImpressao = '3') OR (strModeloImpressao = '4') OR (strModeloImpressao = '8') Then
  Begin
    Result := Result + '      , ';
    if not blnUsaCadSem then
    begin
      Result := Result + '      ( SELECT CONCAT( IF( IFNULL(I.ITE_CODFAB,"") <> "", CONCAT(I.ITE_CODFAB, ","), ""), GROUP_CONCAT(IFNULL(IFNULL(ITEFOR.ITE_CODFAB, ITE_CODITF),""))) ';
      Result := Result + '        FROM ITEFOR    ';
      Result := Result + '        WHERE ITEFOR.ITE_CODITE = I.ITE_CODITE ) AS ITE_CDFABS, ';
    end
    else
    begin
      Result := Result + '      ( SELECT GROUP_CONCAT(DISTINCT IFNULL(SEM_CODSEM,"")) FROM CADSEM WHERE SEM_CODITE = I.ITE_CODITE ) AS ITE_CDFABS, ';
    end;

    Result := Result + '      (                                        ';
    Result := Result + '      SELECT GROUP_CONCAT(IFNULL(ITEBAR.BAR_CODBAR,""))   ';
    Result := Result + '      FROM ITEBAR                              ';
    Result := Result + '      WHERE ITEBAR.BAR_CODITE = I.ITE_CODITE   ';
    Result := Result + '      ) AS ITE_CDBARS,                         ';
    Result := Result + '      CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP) AS NOTAS ';

  End;

  Result := Result + 'FROM MOVDET DET ';

  Result := Result + '  INNER JOIN MOVGER GER ON ';
  Result := Result + '    GER.AUTOINCREM = DET_SEQGER AND GER_CODEMP = DET_CODEMP ';
  Result := Result + '  LEFT JOIN AUXMOV A ON GER.AUTOINCREM = A.AUX_SEQGER ';

  If strCliFor = 'F' Then
  Begin
  Result := Result + '  INNER JOIN CADFOR ON ';
  Result := Result + '    FOR_CODFOR = GER_CODFOR ';
  End
  Else
  Begin
    Result := Result + '  INNER JOIN CADCLI CL ON ';
    Result := Result + '    CL.CLI_CODCLI = GER_CODCLI ';
  End;

  Result := Result + '  INNER JOIN CADEMP ON ';
  Result := Result + '    EMP_CODEMP = DET_CODEMP ';

  Result := Result + '  INNER JOIN CADITE I ON ';
  Result := Result + '    I.ITE_CODITE = DET_CODITE ';

  Result := Result + '  LEFT JOIN CADMAR ON ';
  Result := Result + '    MAR_CODMAR = ITE_CODMAR ';

  Result := Result + '  LEFT JOIN CADUNI ON ';
  Result := Result + '    UNI_CODUNI = ITE_CODUNI ';

  Result := Result + '  LEFT JOIN CADOPE VEN ON ';
  Result := Result + '    VEN.OPE_CODOPE = GER_CODVEN ';

  Result := Result + '  LEFT JOIN CADCID C1 ON ';
  Result := Result + '    C1.CID_CODCID = EMP_CODCID ';

  If strCliFor = 'F' Then
  Begin
  Result := Result + '  LEFT JOIN CADCID C2 ON ';
  Result := Result + '    C2.CID_CODCID = FOR_CODCID ';
  End
  Else
  Begin
    Result := Result + '  LEFT JOIN CADCID C2 ON ';
    Result := Result + '    C2.CID_CODCID = CLI_CODCID ';
  End;

  Result := Result + '  INNER JOIN ITEGER G ON ';
  Result := Result + '    G.ITE_CODITE = DET_CODITE ';
  Result := Result + '    AND G.ITE_CODEMP = DET_CODEMP ';

  Result := Result + '  LEFT JOIN CADOPE DIG ON ';
  Result := Result + '    DIG.OPE_CODOPE = GER_CODDIG ';

  Result := Result + '  LEFT JOIN CADLOT LOT ON ';
  Result := Result + '    LOT.LOT_NUMLOT = DET_NUMLOT AND LOT.LOT_CODITE = DET_CODITE AND LOT.LOT_CODEMP = DET.DET_CODEMP';

  Result := Result + '  LEFT JOIN BAIREQ BR ON BAI_AUTDET = DET.AUTOINCREM ';
  Result := Result + '  LEFT JOIN MOVRCD MR ON BAI_AUTREQ = MR.AUTOINCREM ';
  Result := Result + '  LEFT JOIN FATGOR FG ON FG.FGO_NUMDOC = MR.RCD_DOCPDV ';
  Result := Result + '                     AND FG.FGO_CODEMP = MR.RCD_EMPPDV ';
  Result := Result + '                     AND FG.FGO_ESPDOC = MR.RCD_ESPPDV ';
  Result := Result + '  LEFT JOIN CADCLI CR ON FGO_CODCLI = CR.CLI_CODCLI ';
  If not fEmptyStr(ASeqFatEnd) Then
  Begin
    Result := Result + '  LEFT JOIN (SELECT  SUM(FTE_QTDITE) AS FTE_QTDITE, FTE_CODITE, FTE_SEQGER ';
    Result := Result + '               FROM FATEND ';
    Result := Result + '              WHERE FTE_SEQUEN = "'+ASeqFatEnd+'" ';
    Result := Result + '              GROUP BY FTE_CODITE) ENDE ON ENDE.FTE_SEQGER = DET.AUTOINCREM ';
    Result := Result + '                                       AND ENDE.FTE_CODITE = DET.DET_CODITE ';
  End;


  If blnFiltroPorAutoIncrem Then
    Result := Result + ' WHERE GER.AUTOINCREM IN (:AUTOINCREM)'
  Else
  Begin
    If intSeqPar = 0 Then
    Begin
      Result := Result + ' WHERE GER_NUMDOC = :NUNDOC ';
      Result := Result + '  AND GER_ESPDOC  = :ESPDOC ';
      Result := Result + '  AND IFNULL(GER_SERIE_, "") = :SERIE  ';
      If strCliFor = 'F' Then
        Result := Result + '  AND GER_CODFOR  = :CODFOR '
      Else
        Result := Result + '  AND GER_CODCLI  = :CODFOR ';
      Result := Result + '  AND GER_CODEMP  = :CODEMP ';
      Result := Result + '  AND DET_QTDITE > 0 ';
    End
    Else
    Begin
      Result := Result + ' WHERE GER_NUMDOC = :NUNDOC'+IntToStr(intSeqPar);
      Result := Result + '  AND GER_ESPDOC  = :ESPDOC'+IntToStr(intSeqPar);
      Result := Result + '  AND IFNULL(GER_SERIE_, "") = :SERIE'+IntToStr(intSeqPar);
      If strCliFor = 'F' Then
        Result := Result + '  AND GER_CODFOR  = :CODFOR'+IntToStr(intSeqPar)
      Else
        Result := Result + '  AND GER_CODCLI  = :CODFOR'+IntToStr(intSeqPar);
      Result := Result + '  AND GER_CODEMP  = :CODEMP'+IntToStr(intSeqPar);
      Result := Result + '  AND DET_QTDITE > 0 ';
    End
  End;

  If not fEmptyStr(ASeqFatEnd) Then
    Result := Result + '  AND ENDE.FTE_SEQGER IS NOT NULL ';
  Result := Result + ' AND (DET_ESPDOC <> "TA" OR ( DET_ESPDOC = "TA" AND LEFT(DET_CLAFIS,1) < 5 )) ';

  If (strModeloImpressao = '6') Or (strModeloImpressao = '10') Then
  Begin
    Result := Result + ' GROUP BY DET_CODITE ';
    Result := Result + ' ORDER BY IF(LOCATE("ITEM ESPECIAL", ITE_DESITE), DET_DESCRI, ITE_DESITE) ';
  End;
  if (strModeloImpressao = '3') or  (strModeloImpressao = '4') OR (strModeloImpressao = '8') Then
    Result := Result + ' ORDER BY ITE_LOCFIS ';
  
end;

function TfrmQckLiberacaoArmazenamento.frxReportMUserFunction(
  const MethodName: string; var Params: Variant): Variant;

  procedure pVerificaMudouRegistro;
  Begin
    if (strUltCodIte <> qryRelatorio.FieldByName('DET_CODITE').AsString) Then
    Begin
      strUltCodIte := qryRelatorio.FieldByName('DET_CODITE').AsString;
      pRetornaQuantidadeEntregasPendentesItem(strUltCodIte, fltResultAguarda, fltResultFalta);
    End;

  end;

begin

  If SameText(MethodName, 'fQtdAgu') Then
  Begin
    pVerificaMudouRegistro;
    Result := fltResultAguarda
  End
  Else
  If SameText(MethodName, 'fQtdFal') Then
  Begin
    pVerificaMudouRegistro;
    Result := fltResultFalta;
  End
  else
  If SameText(MethodName, 'fFormataCpfCgc') Then
    Result := fFormataCpfCgc(Params[0], fSetaPais)
  Else If SameText(MethodName, 'fFormataTelefone') Then
    Result := fFormataTelefone(Params[0])
  Else If SameText(MethodName, 'fFormataCEP') Then
    Result := fFormataCEP(fTiraCaracEspeciaisPonto(Params[0]))


end;

procedure TfrmQckLiberacaoArmazenamento.pAbreRelatorio(blnOrigemPreNota: Boolean = False);
  Var
    frxReport : TfrxReport;
    intDec,
    intQtdImp : Integer;
    strNumDoc : String;
    blnAdicionou: Boolean;
begin
  frxReport := Nil;
  Try
    frxRelatorio.DataSet := qryRelatorio;

    if fEmptyStr(strModeloImpressao) then
      strModeloImpressao := '1';

    If strTipImp = 'M' Then
    Begin
      Case strModeloImpressao[1] of
        '1',
        '5' : frxReport := frxReportM;
        '2' : frxReport := frxReportM_Mod2;        
        '3' : frxReport := frxReportM_Mod3;
        '4' : frxReport := frxReportM_Mod4;
        '6' : frxReport := frxReportM_Mod6;
        '7' : frxReport := frxReportM_Mod7;
        '8' : frxReport := frxReportM_Mod8;
      End;

    End Else
    Begin
      Case StrToInt(strModeloImpressao) of
        1 : frxReport := frxReportJ;
        2 : frxReport := frxReportJ_Mod2;
        3 : frxReport := frxReportJ_Mod3;
        4 : frxReport := frxReportJ_Mod4;
        5 : frxReport := frxReportJ_Mod5;
        6 : frxReport := frxReportJ_Mod6;
        7 : frxReport := frxReportJ_Mod7;
        8 : frxReport := frxReportJ_Mod8;
        10: frxReport := frxReportJ_Mod10;
      End;

      If Assigned(frxReport.FindObject('mmoZebra')) Then
        TfrxMemoView(frxReport.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');

      If Assigned(frxReport.FindObject('mmoZebra2')) Then
        TfrxMemoView(frxReport.FindObject('mmoZebra2')).Highlight.Color := fCfgSis('CORZEB');

      If (Not blnOrigemPrenota) and ((strModeloImpressao[1] = '4') OR (strModeloImpressao = '8')) Then
      Begin
        Try
          strNumDoc := '';
          qryRelatorio.First;
          While not qryRelatorio.Eof Do
          Begin
            blnAdicionou := False;
            if Pos(qryRelatorio.FieldByName('GER_DOCNUM').AsString, strNumDoc) = 0 then
            Begin
              strNumDoc := strNumDoc + qryRelatorio.FieldByName('GER_DOCNUM').AsString;
              blnAdicionou := True;
            End;
            qryRelatorio.Next;

            if (not qryRelatorio.Eof) And blnAdicionou Then
              strNumDoc := strNumDoc + ' | ';

          End;
        Finally
          qryRelatorio.First;
        End;

        If strTipImp = 'M' Then
          TfrxDMPMemoView(frxReport.FindObject('mmoNotas')).Memo.Text := 'LIBERAÇÃO ARMAZENA ESTOQUE - ' + strNumDoc
        Else
          TfrxMemoView(frxReport.FindObject('mmoNotas')).Memo.Text := 'LIBERAÇÃO ARMAZENA ESTOQUE - ' + strNumDoc;
      End;
    End;

    if fCfgSis('OFARLA', varBoolean) then
    begin
      if ((frxReport.FindObject('rllPFalta') <> Nil) and (frxReport.FindObject('rllPAguard') <> Nil)) Then
      begin
        TfrxMemoView(frxReport.FindObject('rllPFalta')).Text := 'COD.FAB.';
        TfrxMemoView(frxReport.FindObject('rllQtdeFalta')).Text := '[frxRelatorio."ITE_CODFAB"]';
        TfrxMemoView(frxReport.FindObject('rllPFalta')).Width := TfrxMemoView(frxReport.FindObject('rllPFalta')).Width + TfrxMemoView(frxReport.FindObject('rllPAguard')).Width;
        TfrxMemoView(frxReport.FindObject('rllQtdeFalta')).Width := TfrxMemoView(frxReport.FindObject('rllQtdeFalta')).Width + TfrxMemoView(frxReport.FindObject('rllQtdeAguarda')).Width;
        TfrxMemoView(frxReport.FindObject('rllPFalta')).Align := baNone;
        TfrxMemoView(frxReport.FindObject('rllQtdeFalta')).Align := baNone;
        TfrxMemoView(frxReport.FindObject('rllPFalta')).HAlign := TfrxHAlign.haLeft;
        TfrxMemoView(frxReport.FindObject('rllQtdeFalta')).HAlign := TfrxHAlign.haLeft;
        TfrxMemoView(frxReport.FindObject('rllQtdeFalta')).DisplayFormat.FormatStr := '';
        TfrxMemoView(frxReport.FindObject('rllQtdeFalta')).DisplayFormat.Kind := fkText;
        TfrxMemoView(frxReport.FindObject('rllPAguard')).Visible := False;
        TfrxMemoView(frxReport.FindObject('rllQtdeAguarda')).Visible := False;
      end;
    end;

    with frxReport do
    Begin
      PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');
      PrintOptions.ShowDialog := fEmptyStr(strNomImp);

      intDec := fCfgSis('DEQTEM', varInteger);

      TfrxMemoView(FindObject('rllQtde')).DisplayFormat.FormatStr        := '%2.'+ IntToStr(intDec) +'f' ;

      if not fCfgSis('OFARLA', varBoolean) then
      begin
        If (strModeloImpressao <> '6') And (strModeloImpressao <> '7') And (strModeloImpressao <> '10') Then
        Begin
          TfrxMemoView(FindObject('rllQtdeFalta')).DisplayFormat.FormatStr   := '%2.'+ IntToStr(intDec) +'f' ;
          TfrxMemoView(FindObject('rllQtdeAguarda')).DisplayFormat.FormatStr := '%2.'+ IntToStr(intDec) +'f' ;
        End;
      end;

      If (strModeloImpressao <> '6') And (strModeloImpressao <> '10') And
         (qryRelatorio.FindField('DET_ESPDOC') <> Nil) And
         (qryRelatorio.FindField('DET_ESPDOC').AsString = 'TA') And
         (FindObject('mmoTitEntSai') <> Nil) Then
      Begin
        TfrxMemoView(FindObject('mmoTitEntSai')).Visible := True;

        If (FindObject('mmoEntSai') <> Nil) Then
          TfrxMemoView(FindObject('mmoEntSai')).Visible := True;
      End;

      if (not fCfgSis('NUMSER', varBoolean)) and (FindObject('MemoSerie') <> Nil) then
      begin
        If (FindObject('MemoSerie') <> Nil) Then
          TfrxMemoView(FindObject('MemoSerie')).Visible := False;

        If (FindObject('MemoSerieDados') <> Nil) Then
          TfrxMemoView(FindObject('MemoSerieDados')).Visible := False;
      end;

      If (Not blnExiApl) And (FindObject('mmoAplica') <> Nil) Then
      Begin
        TfrxMemoView(FindObject('mmoAplica')).Visible := False;
        TfrxMemoView(FindObject('mmoAplica')).Text := '';
        TfrxMasterData(FindObject('rlbDetalhes')).Height := TfrxMasterData(FindObject('rlbDetalhes')).Height - TfrxMemoView(FindObject('mmoAplica')).Height;
      End;

      If (FindObject('mmNumRequisicao') <> Nil) Then
      Begin
        If (qryRelatorio.FindField('RCD_CODIGO') <> Nil) Then
        Begin
          If qryRelatorio.FieldByName('RCD_CODIGO').AsString <> '' Then
          Begin
            If  strTipImp = 'M' Then
              TFrxDMPMemoView(FindObject('mmNumRequisicao')).Text := 'Número da Requisição: '+qryRelatorio.FieldByName('RCD_CODIGO').AsString
            Else
              TfrxMemoView(FindObject('mmNumRequisicao')).Text := 'Número da Requisição: '+qryRelatorio.FieldByName('RCD_CODIGO').AsString;
          End;

        End;
      End;

      If (FindObject('mmNomeCliente') <> Nil) Then
      Begin
        If (qryRelatorio.FindField('CLI_NOMCLI') <> Nil) Then
        Begin
          If qryRelatorio.FieldByName('CLI_NOMCLI').AsString <> '' Then
          Begin
            If strTipImp = 'M' Then
              TFrxDMPMemoView(FindObject('mmNomeCliente')).Text := 'Nome do Cliente: '+qryRelatorio.FieldByName('CLI_NOMCLI').AsString
            Else
              TfrxMemoView(FindObject('mmNomeCliente')).Text := 'Nome do Cliente: '+qryRelatorio.FieldByName('CLI_NOMCLI').AsString;
          End;
        End;
      End;

      AddFunction('function fQtdAgu:Double;');
      AddFunction('function fQtdFal:Double;');
      AddFunction('Function fFormataCpfCgc(strCGC: String): String');
      AddFunction('Function fFormataTelefone(strFone: String): String');
      AddFunction('Function fFormataCEP(strCep: String): String');

      If (strModeloImpressao = '6') Or (strModeloImpressao = '10')  Then
      Begin
        TfrxMemoView(FindObject('mmoForOri')).Visible := (FstrEspDoc = 'TA');
        TfrxMemoView(FindObject('mmolblNotOri')).Visible := (FstrEspDoc = 'TA');
        TfrxMemoView(FindObject('mmoNotOri')).Visible := (FstrEspDoc = 'TA');
        TfrxMemoView(FindObject('mmoLblFornOri')).Visible := (FstrEspDoc = 'TA');
        TfrxMemoView(FindObject('mmoDocSelec')).Visible := (FstrEspDoc = 'TA');
        If FstrEspDoc = 'NF' Then
           TfrxMemoView(FindObject('mmoDocGerado')).Text := 'DOCUMENTO SELECIONADO:';

        If (FindObject('mmoData') <> Nil) Then
          TfrxMemoView(FindObject('mmoData')).Text := FormatDateTime('dd/mm/yyyy',VS_Date);

        If (FindObject('mmoHora') <> Nil) Then
          TfrxMemoView(FindObject('mmoHora')).Text := FormatDateTime('hh:mm:ss', fTime());

        If (FindObject('mmoLabelDtaEmiss') <> Nil) Then
          TfrxMemoView(FindObject('mmoLabelDtaEmiss')).Visible := Not fEmptyStr(qryRelatorio.FindField('DTADOC').AsString);
      End;

      If PrepareReport Then
      Begin
        if fEmptyStr(strNomImp) or (FstrDestino = 'V') Then
          pPreviewReport(FstrFila, 'Liberação de armazenamento', frxReport)
        Else
        Begin
          intQtdImp := fGetMenu('Qtd. Vias', ['Não Imprimir','1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);
          intQtdImp := intQtdImp - 1;
          PrintOptions.Copies := intQtdImp;

          if intQtdImp > 0 Then
            pPrintReport(FstrFila, 'Liberação de armazenamento', strNomImp, frxReport);
        End
      End;
    end;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmQckLiberacaoArmazenamento.pAbreRelatorio]');
    End;

  End;

end;

procedure TfrmQckLiberacaoArmazenamento.pImprimir(stlListaMovGer: TStringList; strFila, strDestino: String; oriLibOrigem: TOriImpressaoLiberaArmazenagem = oriLibEntradaDadosCaixa);
  var
    strLayPadrao: string;
    objImpressao: TEditorFastImpressao;

begin
  Try

    strLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'], [ARR_TIPO_LAYOUT[tpeLiberacaoArmazenagem], VS_strCodEmp, 'S']);

    if (not fEmptyStr(strLayPadrao))  then
    begin

      objImpressao := TEditorFastImpressao.Create(Nil);

      FstrFila    := strFila;
      pCarregaConfImprRel(strFila, strNomImp, strTipImp);

      objImpressao.recDocume.strNomImp := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

      objImpressao.recDocume.stlDocumentos := stlListaMovGer;
      objImpressao.recDocume.intSeqPar := -1;
      objImpressao.recDocume.blnLiberacaoArmazenagem := True;
      objImpressao.recDocume.strModeloImpressao := fCfgSis('MODLIB', varString);
      objImpressao.recDocume.blnExiApl := fCfgSis('EXIAPL', varBoolean);
      objImpressao.recDocume.blnFiltroPorAutoIncrem := True;
      objImpressao.recDocume.oriLibOrigem := oriLibOrigem;
      objImpressao.recDocume.stlListaMovGer := stlListaMovGer;
      objImpressao.recDocume.strTipFc := 'F';
      objImpressao.recDocume.blnNaoSelImp := True;
      blnOk := objImpressao.fImprimeDocumento(tpaNormal);

      FreeAndNil(objImpressao);

    end
    else
    begin

      qryRelatorio := fCriaQuery(Self);
      With qryRelatorio Do
      Begin
        FstrDestino := strDestino;
        FstrFila    := strFila;
        pCarregaConfImprRel(strFila, strNomImp, strTipImp);

        SQL.Add(fGeraSql(-1, 'F', True));

        //Prepara as chaves que vão ser utilizadas no SQL
        If stlListaMovGer.Count = 0 Then
          stlListaMovGer.Add('');

        SQL.Text := AnsiReplaceStr(SQL.Text,':AUTOINCREM', fCommaText(stlListaMovGer, True));

        Open;

        If Not IsEmpty Then
        Begin
          pAbreRelatorio;
          blnOk := True;
        End;
        Close;

      End;

    end;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[frmQckLiberacaoArmazenamento.pImprimir]');
  End;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmQckLiberacaoArmazenamento.pImprimir(strIdeDig, strFila : String; strDestino : String = ''; oriLibOrigem: TOriImpressaoLiberaArmazenagem = oriLibEntradaDadosCaixa);
  Var
    strLayPadrao: string;
    objImpressao: TEditorFastImpressao;

begin
  Try
    strLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'], [ARR_TIPO_LAYOUT[tpeLiberacaoArmazenagem], VS_strCodEmp, 'S']);

    if (not fEmptyStr(strLayPadrao))  then
    begin

      objImpressao := TEditorFastImpressao.Create(Nil);

      FstrFila    := strFila;
      pCarregaConfImprRel(strFila, strNomImp, strTipImp);

      objImpressao.recDocume.strNomImp := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

      objImpressao.recDocume.strIdeDig := strIdeDig;
      objImpressao.recDocume.blnPedidoCompra := blnSQLPedidoCompra;
      objImpressao.recDocume.strCodEmp := VS_strCodEmp;
      objImpressao.recDocume.blnLiberacaoArmazenagem := True;
      objImpressao.recDocume.strModeloImpressao := fCfgSis('MODLIB', varString);
      objImpressao.recDocume.blnExiApl := fCfgSis('EXIAPL', varBoolean);
      objImpressao.recDocume.blnFiltroPorAutoIncrem := False;
      objImpressao.recDocume.oriLibOrigem := oriLibOrigem;
      objImpressao.recDocume.blnNaoSelImp := True;
      blnOk := objImpressao.fImprimeDocumento(tpaNormal);

      FreeAndNil(objImpressao);

    end
    else
    begin

      qryRelatorio := fCriaQuery(Self);
      With qryRelatorio Do
      Begin
        FstrDestino := strDestino;
        FstrFila    := strFila;
        pCarregaConfImprRel(strFila, strNomImp, strTipImp);

        SQL.Add(IfThen(blnSQLPedidoCompra,fGeraSqlPedidoCompra(strIdeDig), fGeraSqlPreNota(strIdeDig)));

        ParamByName('IDEDIG').AsString := strIdeDig;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        Open;

        If Not IsEmpty Then
        Begin
          pAbreRelatorio(True);
          blnOk := True;
        End
        Else
          fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);

        Close;
      End;
    end;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[frmQckLiberacaoArmazenamento.pImprimir]');

  End;

  FreeAndNil(qryRelatorio);

End;

procedure TfrmQckLiberacaoArmazenamento.pImprimir(strNumDoc, strEspDoc, strSerie, strCodFor, strCodEmp, strFila : String; strDestino : String = ''; strCliFor : String = 'F';
      oriLibOrigem: TOriImpressaoLiberaArmazenagem = oriLibEntradaDadosCaixa; blnCadSem: Boolean = False; ASeqFatEnd: String = '');
  var
    strLayPadrao: string;
    objImpressao: TEditorFastImpressao;

begin
  Try

    blnUsaCadSem := blnCadSem;

    strLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'], [ARR_TIPO_LAYOUT[tpeLiberacaoArmazenagem], VS_strCodEmp, 'S']);

    if (not fEmptyStr(strLayPadrao))  then
    begin

      objImpressao := TEditorFastImpressao.Create(Nil);

      FstrFila    := strFila;
      pCarregaConfImprRel(strFila, strNomImp, strTipImp);

      objImpressao.recDocume.strNomImp := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

      objImpressao.recDocume.strNumDoc := strNumDoc;
      objImpressao.recDocume.strEspDoc := strEspDoc;
      objImpressao.recDocume.strCodEmp := strCodEmp;
      objImpressao.recDocume.strSerie_ := strSerie;
      objImpressao.recDocume.intSeqPar := 0;
      objImpressao.recDocume.strCodCli := strCodFor;
      objImpressao.recDocume.blnLiberacaoArmazenagem := True;
      objImpressao.recDocume.strModeloImpressao := fCfgSis('MODLIB', varString);
      objImpressao.recDocume.blnExiApl := fCfgSis('EXIAPL', varBoolean);
      objImpressao.recDocume.blnFiltroPorAutoIncrem := False;
      objImpressao.recDocume.oriLibOrigem := oriLibOrigem;
      objImpressao.recDocume.strTipFc := strCliFor;
      objImpressao.recDocume.strSaida := strDestino;
      objImpressao.recDocume.SeqFatEnd := ASeqFatEnd;
      blnOk := objImpressao.fImprimeDocumento(tpaNormal);

      FreeAndNil(objImpressao);

    end
    else
    begin

      qryRelatorio := fCriaQuery(Self);
      With qryRelatorio Do
      Begin
        FstrDestino := strDestino;
        FstrFila    := strFila;
        pCarregaConfImprRel(strFila, strNomImp, strTipImp);

        SQL.Add(fGeraSql(0, strCliFor, False, ASeqFatEnd));

        ParamByName('NUNDOC').AsString := strNumDoc ;
        ParamByName('ESPDOC').AsString := strEspDoc ;
        ParamByName('SERIE').AsString  := strSerie  ;
        ParamByName('CODFOR').AsString := strCodFor ;
        ParamByName('CODEMP').AsString := strCodEmp ;

        FstrEspDoc := strEspDoc;

        Open;
        If Not IsEmpty Then
        Begin
          pAbreRelatorio;
          blnOk := True;
        End;
      (*  Else
          fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok'])*);

        Close;
      End;

      FreeAndNil(qryRelatorio);

    end;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[frmQckLiberacaoArmazenamento.pImprimir]');
  End;
  
end;


procedure TfrmQckLiberacaoArmazenamento.pRetornaQuantidadeEntregasPendentesItem(strCodIte: String; Var fltAguarda, fltFalta : Double );
  Var
    strSql: String;
    qryGen: TUniQuery;
begin

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';

  strSQL := strSQL + '  SUM( IF(A.DET_MOTFUT = "A", A.DET_QTDITE - IFNULL(A.DET_QTDENT,0), 0 )) AS DET_QTDAGU, ';
  strSQL := strSQL + '  SUM( IF(A.DET_MOTFUT = "F", A.DET_QTDITE - IFNULL(A.DET_QTDENT,0), 0 )) AS DET_QTDFAL  ';

  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   MOVDET A ';
  strSQL := strSQL + '   INNER JOIN MOVTRI T ON A.AUTOINCREM = T.DET_SEQGER ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '  A.DET_ENTFUT = "S" ';
  strSQL := strSQL + '  AND A.DET_CODEMP = ' + QuotedStr(VS_strCodEmp) ;
  strSQL := strSQL + '  AND A.DET_CODITE = ' + QuotedStr(strCodIte);
  strSQL := strSQL + '  AND A.DET_TIP_FC = "C" ';
  strSQL := strSQL + '  AND A.DET_ESPDOC NOT IN ("ML", "PR", "TM") ';
  strSQL := strSQL + '  AND A.DET_EFBAIX = "N"                     ';

  If fCfgSis('EFTEST') = '2' Then
  Begin
    strSQL := strSQL + '  AND (A.DET_PROEMB <> "S" OR T.DET_BXSBIT = "S") ';//Para exibir os sub-itens (proemb = 's' e bxsbit = 's')
    strSQL := strSQL + '  AND (A.DET_FILKAR = 0) ';//Para nao exibir o item principal (que vai estar com filkar = 1)
  End
  Else
    strSQL := strSQL + '  AND A.DET_PROEMB <> "S" ';

  strSQL := strSQL + ' GROUP BY      ';
  strSQL := strSQL + '   DET_CODITE  ';

  strSQL := strSQL + ' HAVING ';
  strSQL := strSQL + '   (DET_QTDAGU > 0) OR (DET_QTDFAL > 0) ';

  qryGen := fCriaQuery(Nil);

  With qryGen, SQL Do
  Begin
    Clear;
    Add(strSql);
    Open;

    fltAguarda := FieldByName('DET_QTDAGU').AsFloat;
    fltFalta   := FieldByName('DET_QTDFAL').AsFloat;

  End;

  FreeAndNil(qryGen);

end;

Function TfrmQckLiberacaoArmazenamento.fFormataTelefone(strFone: String): String;
Begin
  Result := fFormataFone(strFone);
End;

procedure TfrmQckLiberacaoArmazenamento.pImprimirDocumentos(stlDocumentos, stlEspecies, stlSeries, stlEmpresas, stlFornecedores, stlTipFC : TStringList; strFila : String; strDestino : String = '';
    oriLibOrigem: TOriImpressaoLiberaArmazenagem = oriLibEntradaDadosCaixa; blnCadSem: Boolean = False; ASeqFatEnd: String = '');
  Var
    i: Integer;
    strLayPadrao: string;
    objImpressao: TEditorFastImpressao;

begin
  Try

    strLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'], [ARR_TIPO_LAYOUT[tpeLiberacaoArmazenagem], VS_strCodEmp, 'S']);

    blnUsaCadSem := blnCadSem;

    if (not fEmptyStr(strLayPadrao))  then
    begin

      objImpressao := TEditorFastImpressao.Create(Nil);

      FstrFila    := strFila;
      pCarregaConfImprRel(strFila, strNomImp, strTipImp);

      objImpressao.recDocume.strNomImp := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');
      
      objImpressao.recDocume.stlDocumentos := stlDocumentos;
      objImpressao.recDocume.stlEspecies := stlEspecies;
      objImpressao.recDocume.stlSeries := stlSeries;
      objImpressao.recDocume.stlEmpresas := stlEmpresas;
      objImpressao.recDocume.stlFornecedores := stlFornecedores;
      objImpressao.recDocume.stlTipFC := stlTipFC;
      objImpressao.recDocume.intSeqPar := 0;
      objImpressao.recDocume.blnLiberacaoArmazenagem := True;
      objImpressao.recDocume.strModeloImpressao := fCfgSis('MODLIB', varString);
      objImpressao.recDocume.blnExiApl := fCfgSis('EXIAPL', varBoolean);
      objImpressao.recDocume.blnFiltroPorAutoIncrem := False;
      objImpressao.recDocume.oriLibOrigem := oriLibOrigem;
      objImpressao.recDocume.strSaida := strDestino;
      objImpressao.recDocume.SeqFatEnd := ASeqFatEnd;
      blnOk := objImpressao.fImprimeDocumento(tpaNormal);

      FreeAndNil(objImpressao);

    end
    else
    begin

      qryRelatorio := fCriaQuery(Self);
      With qryRelatorio Do
      Begin
        FstrDestino := strDestino;
        FstrFila    := strFila;
        pCarregaConfImprRel(strFila, strNomImp, strTipImp);

        SQL.Clear;

        SQL.Add('	SELECT  ');
        SQL.Add('		EMP_NOMEMP, ');
        SQL.Add('   EMP_ENDERE, ');
        SQL.Add('		EMP_BAIRRO, ');
        SQL.Add('		EMP_C_E_P_, ');
        SQL.Add('		EMP_FONE01, ');
        SQL.Add('   EMPCID, ');
        SQL.Add('		FOR_CODFOR, ');
        SQL.Add('		FOR_NOMFOR, ');
        SQL.Add('		FOR_ENDERE, ');
        SQL.Add('		FOR_BAIRRO, ');
        SQL.Add('		FOR_C_E_P_, ');
        SQL.Add('		FOR_CGCCPF, ');
        SQL.Add('		FOR_C_G_C_, ');
        SQL.Add('		FOR_I_E_S_, ');
        SQL.Add('		FOR_FONE01, ');
        SQL.Add('		FORCID, ');
        SQL.Add('		GROUP_CONCAT(GER_NUMDOC) AS GER_DOCNUM, ');
        SQL.Add('		GROUP_CONCAT(GER_NUMDOC) AS GER_NUMDOC, ');
        SQL.Add('		GER_ESPDOC, ');
        SQL.Add('		GROUP_CONCAT(GER_CONPAG) AS GER_CONPAG, ');
        SQL.Add('		GER_CODVEN, ');
        SQL.Add('		GROUP_CONCAT(OPE_NOMOPE) AS OPE_NOMOPE, ');
        SQL.Add('		GER_DTAENT, ');
        SQL.Add('		GER_HORENT, ');
        SQL.Add('		GROUP_CONCAT(NOMDIG) AS NOMDIG, ');
        SQL.Add('		UNI_SIGUNI, ');
        SQL.Add('		DET_CODITE, ');
        SQL.Add('		ITE_DESITE, ');
        SQL.Add('		MAR_DESMAR, ');
        SQL.Add('		ITE_MLTVEN, ');
        SQL.Add('		SUM(DET_QTDITE) AS DET_QTDITE, ');
        SQL.Add('		GROUP_CONCAT(ITE_LOCFIS) AS ITE_LOCFIS, ');
        SQL.Add('		ITE_REFERE, ');
        SQL.Add('		ITE_CODFAB, ');
        If blnExiApl Then
          SQL.Add('   ITE_APLICA, ');
        SQL.Add('		COUNT(GER_NUMDOC) AS QTD  ');
        SQL.Add(' FROM ( ');

        For  i := 0 to stlDocumentos.Count -1 do
        Begin
          If i = 0 Then
          Begin
            SQL.Add(fGeraSql(i, stlTipFC[i], False, ASeqFatEnd));
            ParamByName('NUNDOC').AsString := stlDocumentos[i];
            ParamByName('ESPDOC').AsString := stlEspecies[i];
            ParamByName('SERIE').AsString  := stlSeries[i];
            ParamByName('CODEMP').AsString := stlEmpresas[i];
            ParamByName('CODFOR').AsString := stlFornecedores[i];
          End
          Else
          Begin
            SQL.Add(fGeraSql(i, stlTipFC[i], False, ASeqFatEnd));
            qryRelatorio.ParamByName('NUNDOC'+IntToStr(i)).AsString := stlDocumentos[i];
            qryRelatorio.ParamByName('ESPDOC'+IntToStr(i)).AsString := stlEspecies[i];
            qryRelatorio.ParamByName('SERIE'+IntToStr(i)).AsString  := stlSeries[i];
            qryRelatorio.ParamByName('CODEMP'+IntToStr(i)).AsString := stlEmpresas[i];
            qryRelatorio.ParamByName('CODFOR'+IntToStr(i)).AsString := stlFornecedores[i];
          End;

          If (i < stlDocumentos.Count -1) Then
            SQL.Add(' UNION ALL ');
        End;

        SQL.Add(' ) AS TAB ');
        SQL.Add(' GROUP BY ');
        SQL.Add('   DET_CODITE ');
        SQL.Add(' ORDER BY ');
        SQL.Add('   QTD DESC ');

        Open;
        blnOk := Not IsEmpty;
        If blnOk Then
          pAbreRelatorio;

        Close;
      End;

      FreeAndNil(qryRelatorio);

    end;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[frmQckLiberacaoArmazenamento.pImprimir]');

  End;

end;

procedure TfrmQckLiberacaoArmazenamento.pUtilizarCadSem;
Begin
  blnUsaCadSem := False;
  If  fCfgSis('UTISEM', varBoolean) Then
    blnUsaCadSem := fMensagem('',
      'Tipo de código de barras:',
      ['&Código de barras', 'Código de barras &semelhante'],
      2,
      False,
      0,
      235,
      False,
      0,
      False,
      False,
      true,
      0,
      550
      ) = 2;
End;

function TfrmQckLiberacaoArmazenamento.fGeraSqlPedidoCompra(strIdeDig : String): String;
Begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE             ';
  Result := Result + '			  /*DADOS EMPRESA*/        ';
  Result := Result + '				EMP_NOMEMP,              ';
  Result := Result + '        CONCAT(EMP_ENDERE, CONCAT(", ", EMP_ENDNUM)) AS EMP_ENDERE, ';
  Result := Result + '			  EMP_BAIRRO,              ';
  Result := Result + '			  EMP_C_E_P_,              ';
  Result := Result + '			  EMP_FONE01,              ';
  Result := Result + '        C1.CID_NOMCID AS EMPCID, ';

  Result := Result + '			  /*DADOS FORNECEDOR*/     ';
  Result := Result + '				FOR_CODFOR,              ';
  Result := Result + '				FOR_NOMFOR,              ';
  Result := Result + '				FOR_ENDERE,              ';
  Result := Result + '				FOR_BAIRRO,              ';
  Result := Result + '				FOR_C_E_P_,              ';
  Result := Result + '				FOR_CGCCPF,              ';
  Result := Result + '				FOR_C_G_C_,              ';
  Result := Result + '				FOR_I_E_S_,              ';
  Result := Result + '				FOR_FONE01,              ';
  Result := Result + '				C2.CID_NOMCID AS FORCID, ';

  Result := Result + '				/*DADOS ENTRADA*/             ';
  If (strModeloImpressao = '6') Or (strModeloImpressao = '10') Then
    Result := Result + '				IF(PCG_NUMPED IS NULL, "ITEM CONFERIDO SEM LASTRO COM NF", CONCAT(PCG_NUMPED, " EMP: ", EMP_CODEMP)) AS GER_DOCNUM, ' //GERELE
  Else
    Result := Result + '				IF(PCG_NUMPED IS NULL, "ITEM CONFERIDO SEM LASTRO COM NF", CONCAT(PCG_NUMPED, "NF")) AS GER_DOCNUM, '; //GERELE
  Result := Result + '				PCG_NUMPED AS GER_NUMDOC,        '; //GERELE
  Result := Result + '				"PD" AS GER_ESPDOC,           ';
  Result := Result + '        PCG_CONPAG AS GER_CONPAG,';  //DIGELE
  Result := Result + '			  VEN.OPE_CODOPE AS GER_CODVEN,     '; //DIGELE
  Result := Result + '			  VEN.OPE_NOMOPE AS OPE_NOMOPE, ';
  Result := Result + '				CURRENT_DATE AS GER_DTAENT,     '; //DIGELE
  Result := Result + '				CURRENT_TIME AS GER_HORENT,     '; //DIGLEE
  Result := Result + '				VEN.OPE_NOMOPE AS NOMDIG,     ';

  Result := Result + '				/*ITENS DA ENTRADA*/         ';
  Result := Result + '				UNI_SIGUNI,                  ';
  Result := Result + '				PCD_CODITE AS DET_CODITE,  '; //DIGELE
  Result := Result + '				ITE_DESITE,                  ';
  Result := Result + '				MAR_DESMAR,                  ';
  Result := Result + '				I.ITE_MLTVEN,                ';
  If (strModeloImpressao = '6') Or (strModeloImpressao = '10') Then
    Result := Result + '				SUM(PCD_QTDITE) AS DET_QTDITE, ' //DIGELE
  Else
    Result := Result + '			PCD_QTDITE AS DET_QTDITE,  '; //DIGELE
  Result := Result + '				ITE_LOCFIS,                  ';
  Result := Result + '				ITE_REFERE,                  ';
  Result := Result + '				ITE_CODFAB,                  ';
  Result := Result + '        ITE_CODBAR,                  ';
  Result := Result + '        NULL AS DTADOC,              '; //MF: 320685 - 23/02/24
  If blnExiApl Then
    Result := Result + ' REPLACE( SUBSTRING(ITE_APLICA, 1, 255), ''<<csq>>'',''  '') AS ITE_APLICA, ';
  Result := Result + '				" " AS ENTSAI ';

  if (strModeloImpressao = '3') OR (strModeloImpressao = '4')  OR (strModeloImpressao = '5') OR (strModeloImpressao = '8') Then
  Begin
    Result := Result + '      , ';
    if not blnUsaCadSem then
    begin
      Result := Result + '      ( SELECT CONCAT( IF( IFNULL(I.ITE_CODFAB,"") <> "", CONCAT(I.ITE_CODFAB, ","), ""), GROUP_CONCAT(IFNULL(IFNULL(ITEFOR.ITE_CODFAB, ITE_CODITF),""))) ';
      Result := Result + '        FROM ITEFOR    ';
      Result := Result + '        WHERE ITEFOR.ITE_CODITE = I.ITE_CODITE ) AS ITE_CDFABS, ';
    end
    else
    begin
      Result := Result + '      ( SELECT GROUP_CONCAT(DISTINCT IFNULL(SEM_CODSEM,"")) FROM CADSEM WHERE SEM_CODITE = I.ITE_CODITE ) AS ITE_CDFABS, ';
    end;

    Result := Result + '      (                                        ';
    Result := Result + '      SELECT GROUP_CONCAT(IFNULL(ITEBAR.BAR_CODBAR,""))   ';
    Result := Result + '      FROM ITEBAR                              ';
    Result := Result + '      WHERE ITEBAR.BAR_CODITE = I.ITE_CODITE   ';
    Result := Result + '      ) AS ITE_CDBARS,                         ';
    Result := Result + '      ITE_LOCSUP, ';

    Result := Result + '      NULL AS NOTAS                                ';
  End;

  Result := Result + ' FROM          ';
  Result := Result + '   PCMDET D';
  Result := Result + '  JOIN PCMGER';
  Result := Result + '    ON PCG_NUMPED = PCD_NUMPED';
  Result := Result + '    AND PCG_ESPDOC = PCD_ESPDOC';
  Result := Result + '    AND PCG_CODEMP = PCD_CODEMP';

  Result := Result + '  INNER JOIN CADITE I ON I.ITE_CODITE = D.PCD_CODITE ';
  Result := Result + '  INNER JOIN CADEMP ON EMP_CODEMP = PCD_CODEMP';
  Result := Result + '  INNER JOIN ITEGER G ON G.ITE_CODITE = PCD_CODITE AND G.ITE_CODEMP = PCMGER.PCG_CODEMP';
  Result := Result + '   LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';
  Result := Result + '   LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  Result := Result + '   LEFT JOIN CADCID C1 ON C1.CID_CODCID = EMP_CODCID';
  Result := Result + '   LEFT JOIN CADFOR ON FOR_CODFOR = PCG_CODFOR ';
  Result := Result + '   LEFT JOIN CADCID C2 ON C2.CID_CODCID = FOR_CODCID ';
  Result := Result + '   LEFT JOIN CADOPE VEN ON VEN.OPE_CODOPE = ' + strLoginUsuarioLogado.QuotedString;
  Result := Result + ' WHERE      ';
  Result := Result + '   LOCATE(PCG_NUMPED,:IDEDIG)';
  Result := Result + '   AND PCG_CODEMP = :CODEMP';
  Result := Result + '   AND PCG_ESPDOC = "PD"';
  Result := Result + ' GROUP BY       ';
  If (strModeloImpressao = '6') Or (strModeloImpressao = '10') Then
  Begin
    Result := Result + '   D.PCD_CODITE ';
    Result := Result + ' ORDER BY ITE_DESITE ';
  End
  Else
    Result := Result + '   D.AUTOINCREM ';

  if (strModeloImpressao = '3') or  (strModeloImpressao = '4') OR (strModeloImpressao = '5') OR (strModeloImpressao = '8') Then
    Result := Result + ' ORDER BY ITE_LOCFIS ';
End;

end.
