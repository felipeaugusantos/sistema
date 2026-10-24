unit untQckRomGer;

interface

uses
  SysUtils, Classes, DB, Uni, Variants, Forms, StrUtils, rlTypes, frxClass,
  frxDBSet, frxDMPExport, frxDMPClass, UniClientDataSet, Math, Datasnap.DBClient;

type
  TfrmQckRomGer = class(TForm)
    frxItensCliM: TfrxReport;
    frxDBItensCli: TfrxDBDataset;
    dtsGenPg1: TDataSource;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxItensCliJ: TfrxReport;
    frxItensEntM: TfrxReport;
    frxItensEntj: TfrxReport;
    frxItensEntEmbSepM: TfrxReport;
    frxItensEntEmbSepJ: TfrxReport;
    frxRotaViagemM: TfrxReport;
    frxDBRotaViagem: TfrxDBDataset;
    cdsRotaViagem: TUniClientDataSet;
    cdsRotaViagemNOMCID: TStringField;
    cdsRotaViagemESTADO: TStringField;
    cdsRotaViagemNOMCLI: TStringField;
    cdsRotaViagemVLRCON: TFloatField;
    cdsRotaViagemVOLUME: TFloatField;
    cdsRotaViagemNUMFAT: TStringField;
    cdsRotaViagemNUMDOC: TStringField;
    cdsRotaViagemVENCTO: TStringField;
    cdsRotaViagemPESBRU: TFloatField;
    cdsRotaViagemNOTESP: TStringField;
    cdsRotaViagemCODVEN: TStringField;
    cdsRotaViagemDTAENT: TDateField;
    cdsRotaViagemQTDPAR: TIntegerField;
    cdsRotaViagemVLRPAR: TFloatField;
    frxRotaViagemJ: TfrxReport;
    cdsRotaViagemVLRTOT: TFloatField;
    cdsRotaViagemFERIAD: TStringField;
    strngfldRotaViagemPALET_1: TStringField;
    frxReport1: TfrxReport;
    frxDepCravinhos: TfrxReport;
    frxItensValoresCliJ: TfrxReport;
    frxItensValoresCliM: TfrxReport;
    frxItensEntMenExpM: TfrxReport;
    frxItensEntMenExpJ: TfrxReport;
    frxRotaRomaneioJ: TfrxReport;
    frxGen: TfrxUserDataSet;
    frxGenPg1: TfrxDBDataSet;
    frxGenEmb: TfrxDBDataSet;
    frxGenDoc: TfrxDBDataSet;
    frxGenPag: TfrxDBDataSet;
    frxGenIte: TfrxDBDataSet;
    frxTotDoc: TfrxDBDataSet;
    frxCarCar: TfrxDBDataSet;
    frxOutEnt: TfrxDBDataSet;
    frxRelatorio: TfrxDBDataset;
    frxRotaRomaneioM: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    function frxItensCliMUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
    blnVenMadOuVidOuMtL: Boolean;

    function fFormataFoneInterna(strFone: String): String;
    function fRetMetragemItem(AutoIncremRomDetX, strEspDoc: string): String;
  public
    { Public declarations }
  end;

  procedure pImprimeRomaneio(strNumRom: String;
                             blnPrevia: Boolean = False;
                             blnProdutos   : Boolean = True;
                             blnEmbalagens : Boolean = True;
                             blnDocumentos : Boolean = True;
                             blnFormas     : Boolean = True;
                             blnItemCl     : Boolean = False;
                             blnInfIte     : Boolean = False;
                             blnTotEspDoc  : Boolean = False;
                             blnMosMar     : Boolean = False;
                             blnCarCar     : Boolean = False;
                             blnImpKm      : Boolean = False;
                             blnVolume     : Boolean = False;
                             blnOrdLoc     : Boolean = False;
                             blnEmbVolume  : Boolean = False;
                             blnCliVolume  : Boolean = False;
                             strCliOrdUni  : String = 'D';
                             blnIteDoc     : Boolean = False;
                             blnEndEnt     : Boolean = False;
                             strOrdRel     : String = 'D';
                             blnAssRec     : Boolean = False;
                             blnRotaViagem : Boolean = False;
                             blnImpVal     : Boolean = False;
                             blnMenExp     : Boolean = False;
                             blnRomaneioSimplificado : Boolean = False);

  function fRetornaTransportadoras(strNumRom, strEmpRom : String) : String;

  function fRetornaProfissionais(strNumRom, strEmpRom : String) : String;

  function fTemItensDeSaidaNoRomaneio(strNumRom, strEmpRom: String): Boolean;
  function fTemRomaneioRetiraFilial(strNumRom, strEmpRom: String): Boolean;

var
  frmQckRomGer: TfrmQckRomGer;
  strRom : string;

const
  IF_CONS_SEG = 'IF((CLI_NOMCLI NOT LIKE "%CONSUMIDOR%") AND (CLI_NOMCLI NOT LIKE "%SEGURADORA%")';

implementation

uses untFuncoesGenerica, untModuloSPR,
     untFuncoesSimples, Controls, untConstantes, untRomGer, untTypesSistema;

{$R *.dfm}

procedure pImprimeRomaneio(strNumRom: String;
                           blnPrevia     : Boolean = False;
                           blnProdutos   : Boolean = True;
                           blnEmbalagens : Boolean = True;
                           blnDocumentos : Boolean = True;
                           blnFormas     : Boolean = True;
                           blnItemCl     : Boolean = False;
                           blnInfIte     : Boolean = False;
                           blnTotEspDoc  : Boolean = False;
                           blnMosMar     : Boolean = False;
                           blnCarCar     : Boolean = False;
                           blnImpKm      : Boolean = False;
                           blnVolume     : Boolean = False;
                           blnOrdLoc     : Boolean = False;
                           blnEmbVolume  : Boolean = False;
                           blnCliVolume  : Boolean = False;
                           strCliOrdUni  : String = 'D';
                           blnIteDoc     : Boolean = False;
                           blnEndEnt     : Boolean = False;
                           strOrdRel     : String = 'D';
                           blnAssRec     : Boolean = False;
                           blnRotaViagem : Boolean = False;
                           blnImpVal     : Boolean = False;
                           blnMenExp     : Boolean = False;
                           blnRomaneioSimplificado : Boolean = False);
  Var
    FormQckRomGer: TfrmQckRomGer;
    strSQL: String;
    strSQLIteCli: String;
    strSQLCarCar: String;
    strSQLDocCli: String;
    strSQLPorUni: String;
    strOpcRom: String;
    strDocGer: String;
    strDocDet: String;
    strTabGer: String;
    strTabDet: String;
    strSQLOut: String;
    qryGenEmb : TUniQuery;
    qryGenDoc : TUniQuery;
    qryGenPag : TUniQuery;
    qryGenIte : TUniQuery;
    qryGenPg1 : TUniQuery;
    qryGenGer : TUniQuery;
    qryGenDet : TUniQuery;
    qryTotDoc : TUniQuery;
    qryCarCar : TUniQuery;
    qryOutEnt : TUniQuery;
    qryRotVia : TUniQuery;
    strNomTra: String;
    strNomMot: String;
    strNomAj1: String;
    strNomAj2: String;
    strNomAj3: String;
    strNomAj4: String;
    strObsFec: String;
    strPlaVei: String;
    strOpeSol: String;
    frxRelItens: TfrxReport;
    strNomeFila,
    strTipImp: String;
    strRodRom : String;
    strRodPer : String;
    blnTemItensSaidaNoRomaneio : Boolean;
    intTam: Integer;
    intQtdVias,
    intPosicao: Integer;
    strProfissionais : String;
    blnRetFil: Boolean;
    frxReport: TfrxReport;

  function fSQLEndereco(strCampoEnt, strCampoNor: String): String;
  begin
    Result := 'IF(IFNULL(ETC_ENDENT, "") <> "", ' + strCampoEnt + ', ' + strCampoNor + ')';
  end;

  function fSQLReformaDocumento: String;
  begin
    // Mesma parcela que o GER_VLRCON do ROMGERX soma a partir do ROMDETX
    Result := ' - (SELECT IFNULL(SUM(IFNULL(RD.DET_VALCBS, 0) + IFNULL(RD.DET_VALIBS, 0) + IFNULL(RD.DET_VAL_IS, 0)), 0) ' +
              'FROM ROMDETX RD WHERE RD.DET_SEQGER = RG.AUTOINCREM)';
  end;

  function fSQLTelefones: String;
  begin
    Result := 'CONCAT(IF(IFNULL(CLI_FONE01, "") = "", "", CLI_FONE01), '
             +'IF(IFNULL(CLI_FONE02, "") = "", "", CONCAT(" / ", CLI_FONE02)), '
             +'IF(IFNULL(CLI_CELULA, "") = "", "", CONCAT(" / ", CLI_CELULA)))';
  end;

  procedure pTotalizaTipoDocumentos(Var qryTotDoc: TUniQuery; strNumRom: String);
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_ESPDOC,                   ';
    strSQL := strSQL + '  SUM(GER_VLRCON) AS GER_VLRCON ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ROMGERX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  GER_EMPROM = :EMPROM ';
    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  GER_ESPDOC ';

    With qryTotDoc Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := VS_strCodEmp;
      Open;
    End;
  End;

  Procedure pCarregaFila;
    Var
      qryCfgRel: TUniQuery;
  Begin
    qryCfgRel := fCriaQuery;
    pCarregaConfImpr(qryCfgRel, 'frmFatRomaneio');
    strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
    strTipImp   := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
    If Not fEmptyStr(strNomeFila) Then
      fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
    FreeAndNil(qryCfgRel);
  End;

  function fRetornaVenctos(strConPag: String;
                           strNumDoc: String;
                           curTotDup: Currency;
                           dtaDtaEnt: TDateTime): String;
    Var
      intQtdDup: Integer;
      intContad: Integer;
      strIndice: String;
      arrDuplicata: TarrDuplicata;
  begin
    Try
      pZeraDigDuplic(arrDuplicata);
      intQtdDup := StrToInt(Copy(strConPag, 1, 2));
      strIndice := Copy(strNumDoc, 1, fTamDocCadRec()) + Copy(strNumDoc, fTamDocCadRec() + 5, 3);
      fDigDuplicSemTela(arrDuplicata,
                        intQtdDup,
                        curTotDup,
                        strConPag,
                        StrToInt(Copy(strNumDoc, 1, fTamDocCadRec())),
                        curTotDup,
                        True,
                        False,
                        dtaDtaEnt,
                        False);

      For intContad := 0 To Length(arrDuplicata)-1 Do
      Begin
        If Not fEmptyStr(arrDuplicata[intContad].dtaDtaVen) Then
        Begin
          If (intContad = 0) Then
            Result := FormatDateTime('dd/mm', StrToDate(arrDuplicata[intContad].dtaDtaVen))
          Else
            Result := Result + ' ' + FormatDateTime('dd/mm', StrToDate(arrDuplicata[intContad].dtaDtaVen));
        End;
      End;

    Except
      On E: Exception Do
      Begin
        Result := '';
        pMensagensErro(E.Message, '');
      End;
    End;
  end;

  Function fRetSQLTotPesoBruto : String;
  Begin
    Result := '';
    Result := Result + ' IFNULL((SELECT SUM(DET_TOTPES)     ';
    Result := Result + '   FROM ROMDETX                     ';
    Result := Result + '  WHERE DET_NUMROM = GER_NUMROM     ';
    Result := Result + '    AND DET_EMPROM = GER_EMPROM     ';
    Result := Result + '    AND DET_NUMDOC = GER_NUMDOC     ';
    Result := Result + '    AND DET_ESPDOC = GER_ESPDOC     ';
    Result := Result + '    AND DET_CODEMP = GER_CODEMP     ';
    Result := Result + '    AND DET_CODCLI = GER_CODCLI     ';
    Result := Result + '    AND IFNULL(DET_PROEMB,"N") <> "S"),0) ';
  End;

  procedure pCarregaRotaViagem;
    Var
      strSQL    ,
      strCliAnt : String;
      fltVlrTot: Double;
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE        ';
    strSQL := strSQL + '  IF(ETC_ENDENT = "" OR ETC_ENDENT IS NULL, M.CID_NOMCID, C2.CID_NOMCID) AS NOMCID, ';
    strSQL := strSQL + '  IF(ETC_ENDENT = "" OR ETC_ENDENT IS NULL, M.CID_ESTADO, C2.CID_ESTADO) AS ESTADO, ';

    strSQL := strSQL + '  CONCAT(DET_CODCLI, "-",	'+
                       '    IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" '+
                       '      OR CLI_NOMCLI LIKE "%BALCAO%" '+
                       '      OR CLI_NOMCLI LIKE "%BALCÃO%" '+
                       '      OR CLI_NOMCLI LIKE "%SEGURADORA%",GER_NOMCON, CLI_NOMCLI)) AS NOMCLI, ';

    strSQL := strSQL + '  GER_VLRCON AS VLRCON,    ';
    strSQL := strSQL + '  GER_VOLUME AS VOLUME,    ';

    If fCfgSis('USPRRO', varBoolean) And (fCfgSis('OPCROM') = '1') Then
    Begin
      strSQL := strSQL + '  IF(G.GER_NUMFAT <> "", CONCAT(G.GER_NUMFAT, "-", G.GER_TIPFAT, "-", G.GER_CODEMP), "") AS NUMFAT, ';
    End
    Else
    Begin
      strSQL := strSQL + '  (SELECT GROUP_CONCAT(CONCAT(F.FGO_NUMDOC, "-", F.FGO_ESPDOC, "-", F.FGO_CODEMP)) ' +
                         '     FROM FATGOR F '+
                         '    WHERE F.FGO_NUMFAT = G.GER_NUMDOC '+
                         '      AND F.FGO_TIPFAT = G.GER_ESPDOC '+
                         '      AND F.FGO_EMPFAT = G.GER_CODEMP) AS NUMFAT, ';
    End;

    strSQL := strSQL + '  IF(IFNULL(DET_NUMDOC, "") = "", "", CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP)) AS NUMDOC, ';
    strSQL := strSQL + '  DET_CONPAG AS CONPAG,    ';
    strSQL := strSQL + '  LEFT(DET_CONPAG, 2) AS QTDPAR, ';
    strSQL := strSQL + '  (GER_VLRCON / LEFT(DET_CONPAG, 2)) AS VLRPAR, ';

    {*************************************************}
    {* IRÁ PEGAR SEMPRE O PRÓXIMO FERIADO CADASTRADO *}
    {***********************************************FC}

    strSQL := strSQL + '  (SELECT CONCAT(LPAD(DAY(FER_DTAFER), 2, "0"), "/", LPAD(MONTH(FER_DTAFER), 2, "0"), "/", LPAD(YEAR(FER_DTAFER), 4, "0"))'+
                       '     FROM CADFER ';
    strSQL := strSQL + '    WHERE FER_DTAFER >= CURRENT_DATE() ';
    strSQL := strSQL + '    UNION ALL ';
    strSQL := strSQL + '   SELECT CONCAT(LPAD(DAY(FCI_DTAFER), 2, "0"), "/", LPAD(MONTH(FCI_DTAFER), 2, "0"), "/", LPAD(YEAR(FCI_DTAFER), 4, "0")) '+
                       '     FROM FERCID ';
    strSQL := strSQL + '    WHERE FCI_DTAFER >= CURRENT_DATE() ';
    strSQL := strSQL + '      AND ( FCI_CODCID = IF(ETC_ENDENT = "" OR ETC_ENDENT IS NULL, M.CID_CODCID, ETC_CIDENT)) ';
    strSQL := strSQL + '    ORDER BY 1 ';
    strSQL := strSQL + '    LIMIT 1) AS FERIAD, ';

    strSQL := strSQL + '  GER_PALET_ AS PALET_,' + fRetSQLTotPesoBruto + ' AS PESBRU, ';

    strSQL := strSQL + '  GER_NOTESP AS NOTESP,    ';
    strSQL := strSQL + '  GER_DTAENT AS DTAENT,    ';
    strSQL := strSQL + '  DET_CODREP AS CODREP     ';
    strSQL := strSQL + 'FROM                       ';
    strSQL := strSQL + '  ROMDETX D                ';
    strSQL := strSQL + '  INNER JOIN ROMGERX G ON G.AUTOINCREM = D.DET_SEQGER ';
    strSQL := strSQL + '  INNER JOIN CADCLI  C ON C.CLI_CODCLI = D.DET_CODCLI ';
    strSQL := strSQL + '  INNER JOIN CADCID  M ON M.CID_CODCID = C.CLI_CODCID ';

    strSQL := strSQL + '   LEFT JOIN ENTCLI ON ETC_CODCLI = D.DET_CODCLI AND ';
    strSQL := strSQL + '        IF(IFNULL(G.GER_ENTGER, "") <> "", ENTCLI.AUTOINCREM = GER_ENTGER, ';
    strSQL := strSQL + '        ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = G.GER_CODCLI)) ';

    strSQL := strSQL + '   LEFT JOIN CADCID C2 ON ETC_CIDENT = C2.CID_CODCID ';

    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  GER_EMPROM = :EMPROM AND ';
    strSQL := strSQL + '  IFNULL(DET_PROEMB,"N") <> "S" ';
    strSQL := strSQL + 'GROUP BY                   ';
    strSQL := strSQL + '  DET_NUMDOC,              ';
    strSQL := strSQL + '  DET_ESPDOC,              ';
    strSQL := strSQL + '  DET_CODEMP,              ';
    strSQL := strSQL + '  DET_CODCLI,              ';
    strSQL := strSQL + '  GER_ENTSAI               ';
    strSQL := strSQL + 'ORDER BY                   ';
    strSQL := strSQL + '  NOMCID,                  ';
    strSQL := strSQL + '  CLI_NOMCLI,              ';
    strSQL := strSQL + '  CLI_CODCLI,              ';
    strSQL := strSQL + '  DET_NUMDOC,              ';
    strSQL := strSQL + '  DET_ESPDOC,              ';
    strSQL := strSQL + '  DET_CODEMP               ';

    With qryRotVia Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := VS_strCodEmp;
      Open;
      First;

      fltVlrTot := 0;
      strCliAnt := FieldByName('NOMCLI').AsString;

      While Not Eof Do
      Begin
        FormQckRomGer.cdsRotaViagem.Append;
        FormQckRomGer.cdsRotaViagem.FieldByName('NUMDOC').AsString   := FieldByName('NUMDOC').AsString;
        FormQckRomGer.cdsRotaViagem.FieldByName('NUMFAT').AsString   := FieldByName('NUMFAT').AsString;
        FormQckRomGer.cdsRotaViagem.FieldByName('NOMCID').AsString   := FieldByName('NOMCID').AsString;
        FormQckRomGer.cdsRotaViagem.FieldByName('ESTADO').AsString   := FieldByName('ESTADO').AsString;
        FormQckRomGer.cdsRotaViagem.FieldByName('NOMCLI').AsString   := FieldByName('NOMCLI').AsString;
        FormQckRomGer.cdsRotaViagem.FieldByName('VLRCON').AsFloat    := FieldByName('VLRCON').AsFloat;
        FormQckRomGer.cdsRotaViagem.FieldByName('VLRPAR').AsFloat    := RoundTo(FieldByName('VLRPAR').AsFloat, -2);

        {*****************************************************************}
        {* EM ALGUNS CASOS A TE NÃO GERA CADREC E GRAVA DET_CONPAG VAZIO *}
        {**************************************************************RN*}
        If fIsNumber(FieldByName('QTDPAR').AsString) Then
          FormQckRomGer.cdsRotaViagem.FieldByName('QTDPAR').AsInteger := FieldByName('QTDPAR').AsInteger;

        FormQckRomGer.cdsRotaViagem.FieldByName('VOLUME').AsFloat    := FieldByName('VOLUME').AsFloat;
        FormQckRomGer.cdsRotaViagem.FieldByName('VENCTO').AsString   := fRetornaVenctos(FieldByName('CONPAG').AsString,
                                                                                        FieldByName('NUMDOC').AsString,
                                                                                        FieldByName('VLRCON').AsFloat,
                                                                                        FieldByName('DTAENT').AsDateTime);
        FormQckRomGer.cdsRotaViagem.FieldByName('PESBRU').AsFloat    := FieldByName('PESBRU').AsFloat;
        FormQckRomGer.cdsRotaViagem.FieldByName('NOTESP').AsString   := FieldByName('NOTESP').AsString;
        FormQckRomGer.cdsRotaViagem.FieldByName('CODVEN').AsString   := FieldByName('CODREP').AsString;
        FormQckRomGer.cdsRotaViagem.FieldByName('DTAENT').AsDateTime := FieldByName('DTAENT').AsDateTime;
        FormQckRomGer.cdsRotaViagem.FieldByName('FERIAD').AsString   := FieldByName('FERIAD').AsString;
        FormQckRomGer.cdsRotaViagem.FieldByName('PALET_').AsString   := FieldByName('PALET_').AsString;
        FormQckRomGer.cdsRotaViagem.FieldByName('VLRTOT').AsFloat    := 0;

        fltVlrTot := fltVlrTot + FormQckRomGer.cdsRotaViagem.FieldByName('VLRCON').AsFloat;

        FormQckRomGer.cdsRotaViagem.Post;
        Next;

        If (strCliAnt <> FieldByName('NOMCLI').AsString) Or (Eof) Then
        Begin
          FormQckRomGer.cdsRotaViagem.Edit;
          FormQckRomGer.cdsRotaViagem.FieldByName('VLRTOT').AsFloat := fltVlrTot;
          FormQckRomGer.cdsRotaViagem.Post;
          fltVlrTot := 0;
          strCliAnt := FieldByName('NOMCLI').AsString;
        End;
      End;
    End;
  end;


  function fCampoQtdIte: String;
  begin
    if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
    begin
      Result := '';
      Result := Result + ' IF(DET_JAFATU = 0, ';
      Result := Result + '   IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDBAI, DET_QTDBAI), ';
      Result := Result + '   IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE, DET_QTDITE) ';
      Result := Result + ' ) ';
    end
    else
      Result := ' IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDBAI, DET_QTDBAI) ';
  end;

begin
  blnTemItensSaidaNoRomaneio := fTemItensDeSaidaNoRomaneio(strNumRom, VS_strCodEmp);
  strRodRom := fCfgSis('RODROM');
  strRodPer := fCfgSis('MSROPE');
  strRom := strNumRom;
  blnRetFil := fTemRomaneioRetiraFilial(strNumRom, VS_strCodEmp);

  pCarregaFila;

  pCriarFormularios(TfrmQckRomGer,FormQckRomGer);

  qryGenEmb := fCriaQuery;
  qryGenDoc := fCriaQuery;
  qryGenPag := fCriaQuery;
  qryGenIte := fCriaQuery;
  qryGenPg1 := fCriaQuery;
  qryGenGer := fCriaQuery;
  qryGenDet := fCriaQuery;
  qryCarCar := fCriaQuery;
  qryOutEnt := fCriaQuery;
  qryRotVia := fCriaQuery;

  With FormQckRomGer Do
  Begin
    Try
      cdsRotaViagem.CreateDataSet;

      strOpcRom := fCfgSis('OPCROM');

      {**********************************************}
      {* PREPARA O WHERE DOS DOCUMENTOS DO ROMANEIO *}
      {*******************************************MV*}
      strDocGer := '';
      strDocDet := '';

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  GER_NUMDOC, ';
      strSQL := strSQL + '  GER_ESPDOC, ';
      strSQL := strSQL + '  GER_CODEMP, ';
      strSQL := strSQL + '  GER_CODCLI, ';
      strSQL := strSQL + '  GER_OBSFEC, ';
      strSQL := strSQL + '  CONCAT(GER_CODTRA,"-",TRA_NOMTRA)    AS GER_NOMTRA, ';
      strSQL := strSQL + '  CONCAT(GER_CODMOT,"-",MOT_NOMMOT)    AS GER_NOMMOT, ';
      strSQL := strSQL + '  CONCAT(GER_CODAJ1,"-",A1.AJU_NOMAJU) AS GER_NOMAJ1, ';
      strSQL := strSQL + '  CONCAT(GER_CODAJ2,"-",A2.AJU_NOMAJU) AS GER_NOMAJ2, ';
      strSQL := strSQL + '  CONCAT(GER_CODAJ3,"-",A3.AJU_NOMAJU) AS GER_NOMAJ3, ';
      strSQL := strSQL + '  CONCAT(GER_CODAJ4,"-",A4.AJU_NOMAJU) AS GER_NOMAJ4, ';

      strSQL := strSQL + '  CONCAT(LEFT(VEI_PLAVEI,3),"-",RIGHT(VEI_PLAVEI,4)  , " ", ' +
                         '         IFNULL(CONCAT("MARCA.: ",   MAR_DESMAR), ""), " ", ' +
                         '         IFNULL(CONCAT("MODELO: ",   MOD_DESMOD), ""), " ", ' +
                         '         IFNULL(CONCAT("ANO/MOD.: ", VEI_ANOVEI), ""), " ", ' +
                         '         IFNULL(CONCAT("COR: ",      COR_DESCOR), "")) AS GER_PLAVEI, ';

      strSQL := strSQL + '  GER_CODVEN, ';
      strSQL := strSQL + '  OPE_NOMOPE AS GER_NOMVEN, ';
      strSQL := strSQL + '  GER_ORDIMP ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '  ROMGERX ';
      strSQL := strSQL + '  LEFT JOIN CADTRA    ON GER_CODTRA = TRA_CODTRA ';
      strSQL := strSQL + '  LEFT JOIN CADMOT    ON GER_CODMOT = MOT_CODMOT ';
      strSQL := strSQL + '  LEFT JOIN CADAJU A1 ON GER_CODAJ1 = A1.AJU_CODAJU ';
      strSQL := strSQL + '  LEFT JOIN CADAJU A2 ON GER_CODAJ2 = A2.AJU_CODAJU ';
      strSQL := strSQL + '  LEFT JOIN CADAJU A3 ON GER_CODAJ3 = A3.AJU_CODAJU ';
      strSQL := strSQL + '  LEFT JOIN CADAJU A4 ON GER_CODAJ4 = A4.AJU_CODAJU ';
      strSQL := strSQL + '  LEFT JOIN CADVEI    ON GER_PLAVEI = VEI_PLAVEI ';
      strSQL := strSQL + '  LEFT JOIN CORVEI    ON VEI_CODCOR = COR_CODCOR ';
      strSQL := strSQL + '  LEFT JOIN MARVEI    ON VEI_CODMAR = MAR_CODMAR ';
      strSQL := strSQL + '  LEFT JOIN MODVEI    ON VEI_CODMOD = MOD_CODMOD ';
      strSQL := strSQL + '       JOIN CADOPE    ON OPE_CODOPE = GER_CODVEN ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
      strSQL := strSQL + '  GER_EMPROM = :EMPROM ';
      strSQL := strSQL + ' ORDER BY ';
      strSQL := strSQL + ' GER_ORDIMP ASC ';

      With qryGenGer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;
        Open;

        strNomTra := FieldByName('GER_NOMTRA').AsString;
        strNomMot := FieldByName('GER_NOMMOT').AsString;
        strNomAj1 := FieldByName('GER_NOMAJ1').AsString;
        strNomAj2 := FieldByName('GER_NOMAJ2').AsString;
        strNomAj3 := FieldByName('GER_NOMAJ3').AsString;
        strNomAj4 := FieldByName('GER_NOMAJ4').AsString;
        strObsFec := FieldByName('GER_OBSFEC').AsString.Replace(#$D#$A, ' ');
        strPlavei := FieldByName('GER_PLAVEI').AsString;

        {*********************************************}
        {* PREPARA WHERE PARA DOCUMENTOS DO ROMANEIO *}
        {******************************************MV*}
        While (Not Eof) Do
        Begin
          strTabGer := 'MOVGER';
          strTabDet := 'MOVDET';
          strDocGer := strDocGer + '('
                                 + 'GER_NUMDOC = ' + QuotedStr(FieldByName('GER_NUMDOC').AsString) + ' AND '
                                 + 'GER_ESPDOC = ' + QuotedStr(FieldByName('GER_ESPDOC').AsString) + ' AND '
                                 + 'GER_CODCLI = ' + QuotedStr(FieldByName('GER_CODCLI').AsString) + ' AND '
                                 + 'GER_CODEMP = ' + QuotedStr(FieldByName('GER_CODEMP').AsString) + ') ';

          strDocDet := strDocDet + '('
                                 + 'DET_NUMDOC = ' + QuotedStr(FieldByName('GER_NUMDOC').AsString) + ' AND '
                                 + 'DET_ESPDOC = ' + QuotedStr(FieldByName('GER_ESPDOC').AsString) + ' AND '
                                 + 'DET_CODCLI = ' + QuotedStr(FieldByName('GER_CODCLI').AsString) + ' AND '
                                 + 'DET_CODEMP = ' + QuotedStr(FieldByName('GER_CODEMP').AsString) + ') ';

          If (RecNo < RecordCount) Then
          Begin
            strDocGer := strDocGer + ' OR ';
            strDocDet := strDocDet + ' OR ';
          End;

          Next;

        End;

        Close;
      End;

      {*******************************************}
      {* GERA TEMPORARIA DOS ITENS               *}
      {****************************************MV*}
      strSQL := '';
      If (Not blnPrevia) Or (fCfgSis('USPRRO',varBoolean)) Then
      Begin
        If fTabelaExiste('TMP_RELROMANEIO') Then
          fDropTable('TMP_RELROMANEIO');

        strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_RELROMANEIO ';
      End
      Else
      Begin
        strSQL := strSQL + 'INSERT INTO TMP_RELROMANEIO ';
      End;

      strSQL := strSQL + 'SELECT ';

      strSQL := strSQL + ' (SELECT GROUP_CONCAT(DISTINCT AUX_MSGEXP SEPARATOR " ") ';
      strSQL := strSQL + '  FROM                                    ';
      strSQL := strSQL + '    AUXROMX,                              ';
      strSQL := strSQL + '    ROMGERX RX                            ';
      strSQL := strSQL + '  WHERE                                   ';
      strSQL := strSQL + '    RX.AUTOINCREM = AUX_SEQGER AND         ';
      strSQL := strSQL + '    RX.GER_CODCLI = RG.GER_CODCLI AND ';
      strSQL := strSQL + '    RX.GER_NUMROM = RG.GER_NUMROM AND ';
      strSQL := strSQL + '    RX.GER_NUMDOC = RG.GER_NUMDOC AND ';
      strSQL := strSQL + '    RX.GER_ESPDOC = RG.GER_ESPDOC AND ';
      strSQL := strSQL + '    RX.GER_CODEMP = RG.GER_CODEMP AND ';
      strSQL := strSQL + '    RX.GER_EMPROM = RG.GER_EMPROM) AS GER_MSGEXP,  ';
      strSQL := strSQL + ' (SELECT GROUP_CONCAT(DISTINCT GER_MEN001, " ", GER_MEN002 SEPARATOR " ") ';
      strSQL := strSQL + ' FROM                                     ';
      strSQL := strSQL + '   ROMGERX RX                             ';
      strSQL := strSQL + ' WHERE                                    ';
      strSQL := strSQL + '   RX.GER_CODCLI = RG.GER_CODCLI AND ';
      strSQL := strSQL + '   RX.GER_NUMROM = RG.GER_NUMROM AND ';
      strSQL := strSQL + '   RX.GER_NUMDOC = RG.GER_NUMDOC AND ';
      strSQL := strSQL + '   RX.GER_ESPDOC = RG.GER_ESPDOC AND ';
      strSQL := strSQL + '   RX.GER_CODEMP = RG.GER_CODEMP AND ';

      strSQL := strSQL + '   RX.GER_EMPROM = RG.GER_EMPROM) AS GER_MENSAG, ';

      strSQL := strSQL + '  RG.GER_ORDIMP, ';
      strSQL := strSQL + '  DET_NUMROM, ';
      strSQL := strSQL + '  DET_EMPROM, ';
      strSQL := strSQL + '  DET_CODCLI, ';

      If fImpressaoEspecificaDepCravinhos(blnIteDoc) Then
        strSQL := strSQL + '  TRIM(LEFT(IF(RG.GER_NOMCON IS NULL, CLI_NOMCLI, RG.GER_NOMCON), 35)) AS DET_NOMCLI, '
      Else
        strSQL := strSQL + '  TRIM(LEFT(CONCAT(RG.GER_CODCLI, "-", IF(RG.GER_NOMCON IS NULL, CLI_NOMCLI, RG.GER_NOMCON)), 35)) AS DET_NOMCLI, ';

      strSQL := strSQL + '  CLI_FANSOB AS DET_FANSOB, ';

      strSQL := strSQL + '  RG.GER_CODFIL, ';

      strSQL := strSQL + '  IF(RG.GER_RETFIL = "S", ';
      strSQL := strSQL + '    CONCAT("Retirar Merc. na Filial ", RG.GER_CODFIL, IF(MG.AUTOINCREM IS NULL, "", CONCAT(" Conferido: ", IF(COALESCE(MG.GER_DTLBEX, "") = "", "Não", "Sim")))), ';
      strSQL := strSQL + '    IF(ROMTRAX.AUTOINCREM IS NOT NULL, ';
      strSQL := strSQL + '      CONCAT("Transbordo Filial ", ROMTRAX.TRA_EMPDES), ';
      strSQL := strSQL + '      "")) AS OBSFIL, ';

      strSQL := strSQL + '  IF(ROMTRAX.AUTOINCREM IS NULL, ';
      strSQL := strSQL + '    TRIM(CONCAT(' + IF_CONS_SEG + ', ' + fSQLEndereco('ETC_ENDENT', 'CONCAT(CLI_ENDERE, " ", IFNULL(CLI_ENDNUM,""), IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT("  ", CLI_ENDCOM)))') + ', RG.GER_ENDCON))), ';
      strSQL := strSQL + '    TRIM(RG.GER_ENDENT)) AS GER_ENDCLI, ';

      strSQL := strSQL + '  IF(ROMTRAX.AUTOINCREM IS NULL, ';
      strSQL := strSQL + '    TRIM(LEFT(CONCAT(' + IF_CONS_SEG + ', ' + fSQLEndereco('ETC_BAIENT', 'CLI_BAIRRO') + ', RG.GER_BAICON)), 35)), ';
      strSQL := strSQL + '    TRIM(LEFT(RG.GER_BAIENT, 35))) AS GER_BAICLI, ';

      strSQL := strSQL + '  IF(ROMTRAX.AUTOINCREM IS NULL, ';
      strSQL := strSQL + '    TRIM(LEFT(CONCAT(' + IF_CONS_SEG + ', ' + fSQLEndereco('ETC_CEPENT', 'CLI_C_E_P_') + ', RG.GER_CEPCON)), 35)), ';
      strSQL := strSQL + '    TRIM(LEFT(RG.GER_CEPENT, 35))) AS GER_CEPCLI, ';

      strSQL := strSQL + '  IF(ROMTRAX.AUTOINCREM IS NULL, ';
      strSQL := strSQL + '    CONCAT(CADCID.CID_NOMCID, "-", CADCID.CID_ESTADO), ';
      strSQL := strSQL + '    CONCAT(CIDENT.CID_NOMCID, "-", CIDENT.CID_ESTADO)) AS GER_NOMCID, ';

      strSQL := strSQL + '  IF(ROMTRAX.AUTOINCREM IS NULL, ';
      strSQL := strSQL + '    TRIM(LEFT(CONCAT(' + IF_CONS_SEG + ', ' + fSQLEndereco('ETC_REFENT', '""') + ', "")), "")), ';
      strSQL := strSQL + '    TRIM(LEFT(RG.GER_REFENT, ""))) AS GER_REFCLI, ';

      strSQL := strSQL + '  IF(ROMTRAX.AUTOINCREM IS NULL, ';
      strSQL := strSQL + '    CONCAT(TRIM(CONCAT(' + IF_CONS_SEG + ', ' + fSQLEndereco('ETC_ENDENT', 'CONCAT(CLI_ENDERE, " ", IFNULL(CLI_ENDNUM,""), IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT("  ", CLI_ENDCOM)))') + ', RG.GER_ENDCON))), LEFT(CONCAT(' + IF_CONS_SEG + ', IF(IFNULL(ETC_REFENT, "") <> "", ' + fSQLEndereco('CONCAT(" - REFERÊNCIA: ", ETC_REFENT)', '""') + ',""), "")), 60)), ';
      strSQL := strSQL + '    LEFT(CONCAT(TRIM(RG.GER_ENDENT), IF(IFNULL(RG.GER_REFENT, "") <> "", CONCAT(" - REFERÊNCIA: ", RG.GER_REFENT), "")), 60)) AS GER_ENDREF, ';

      strSQL := strSQL + '  TRIM(LEFT(CONCAT(' + IF_CONS_SEG + ', ' + fSQLEndereco('IF(IFNULL(ETC_TELENT, "") = "", CLI_FONE01, ETC_TELENT)', 'CLI_FONE01') + ', RG.GER_TELCON)), 35)) AS GER_FONE, ';
      strSQL := strSQL + '  TRIM(LEFT(CONCAT(' + IF_CONS_SEG + ', ' + fSQLTelefones + ', RG.GER_TELCON)), 100)) AS GER_FONES, ';

      if ( fCfgSis('ROMIDO') = 2 ) Or (blnIteDoc And blnImpVal) then
        strSQL := strSQL + ' DET_CODITE AS DET_ITEM, DET_UNITAR, DET_TOTITE, IFNULL(ROMDETX.DET_DESESP, 0.00) AS DET_DESESP, '
      else
        strSQL := strSQL + '  CONCAT_WS(".", LEFT(I.ITE_CODGRU, 3), RIGHT(I.ITE_CODGRU, 3), DET_CODITE) AS DET_ITEM, ';

      If (blnIteDoc And blnImpVal) Then
        strSQL := strSQL + ' RG.GER_CODFPG, FPG_DESCRI, RG.GER_CODCND, CND_DESCRI, (RG.GER_VLRCON - RG.GER_TOTIPI - RG.GER_TOTRET - RG.GER_TOTFRE' + fSQLReformaDocumento + ') AS GER_TOTMER, ';

      strSQL := strSQL + '  DET_CODITE, ';
      strSQL := strSQL + '  DET_AUTINC, ';
      strSQL := strSQL + IIF(fCfgSisL('IMPREF', varBoolean),
                             IIF(fCfgSisL('MONDES', varString) = '1',
                                 '  IF(LOCATE(DET_REFERE,DET_DESCRI)>0,DET_DESCRI,CONCAT(DET_DESCRI, IF(IFNULL(DET_REFERE,"") = "", "", CONCAT(" ",DET_REFERE)))) ',
                                 '  IF(LOCATE(DET_REFERE,DET_DESCRI)>0,DET_DESCRI,CONCAT(IF(IFNULL(DET_REFERE,"") = "", "", CONCAT(DET_REFERE," ")), DET_DESCRI)) '),
                             '  DET_DESCRI') +
                         '  AS DET_DESCRI, ';
      strSQL := strSQL + '  UNI_SIGUNI AS DET_UNIDAD, ';
      strSQL := strSQL + '  G.ITE_SALDOS, ';
      strSQL := strSQL + '  DET_CLAFIS, ';
      strSQL := strSQL + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTPES, DET_TOTPES)) AS DET_TOTPES, ';
      strSQL := strSQL + '  MAR_DESMAR, ';

      {*********************************************************}
      {* ESTA OPCAO SEMPRE IRA MOSTRAR O VOLUME DO FATURAMENTO *}
      {******************************************************JC*}
      If fCfgSis('VOLROM', varInteger) = 4 Then
        strSQL := strSQL + ' 0.0000 AS DET_VOLUME, '
      Else
      Begin
        strSQL := strSQL + '  SUM(' + fCampoQtdIte ;

        Case fCfgSis('VOLROM', varInteger) Of
          1: strSQL := strSQL + '      * IFNULL(UNI_PESLIT,0) / :LITGAL ';
          2: strSQL := strSQL + '      / IF( IFNULL(ITB_QTDEMB,0) = 0, 1, ITB_QTDEMB) ';
          3: strSQL := strSQL + '      / IF( ITE_MLTVEN = 0, 1, ITE_MLTVEN) ';
        End;

        strSQL := strSQL + ') AS DET_VOLUME, ';
      End;

      strSQL := strSQL + '  SUM(' + fCampoQtdIte + ') AS DET_QTDITE, ';
//      strSQL := strSQL + '  ITE_LOCFIS AS DET_LOCFIS, ';
      strSQL := strSQL + '  IF(IFNULL(DET_NUMLOT, "") = "", ITE_LOCFIS, LOT_LOCFIS) AS DET_LOCFIS, ';
      strSQL := strSQL + '  RG.GER_NUMDOC, RG.GER_ESPDOC, RG.GER_CODEMP, RG.GER_CODVEN, RG.GER_MEN001, RG.GER_MEN002, RG.GER_DTAENT, ';
      strSQL := strSQL + '  RG.GER_NUMFAT, RG.GER_TIPFAT, IF(RG.GER_NUMFAT <> "", RG.GER_CODEMP, "") AS GER_EMPFAT, ';
      strSQL := strSQL + '  RG.GER_CODCLI, IFNULL(RG.GER_SERIE_, "") AS GER_SERIE_, ';

      If blnEndEnt Then
        strSQL := strSQL + '  CONCAT(RG.GER_CODCLI, TRIM(CONCAT(' + IF_CONS_SEG + ', ' + fSQLEndereco('ETC_ENDENT', 'CONCAT(CLI_ENDERE, " ", IFNULL(CLI_ENDNUM,""), IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT("  ", CLI_ENDCOM)))') + ', RG.GER_ENDCON)))) AS DOCQUEBRA, '
      Else
        strSQL := strSQL + '  CONCAT(RG.GER_NUMDOC, RG.GER_ESPDOC, RG.GER_CODEMP, RG.GER_CODCLI, IFNULL(RG.GER_SERIE_, "")) AS DOCQUEBRA, ';

      strSQL := strSQL + '  CONCAT(RG.GER_CODVEN, "-", OPE_NOMOPE) GER_NOMVEN, ';

      If fImpressaoEspecificaDepCravinhos(blnIteDoc) Then
      Begin
        strSQL := strSQL + ' COALESCE(CLI_C_G_C_, "") AS GER_CPFCGC, ';
        strSQL := strSQL + ' COALESCE(CLI_I_E_S_, "") AS GER_RG_IES, ';
        strSQL := strSQL + ' IF(LEFT(DET_CLAFIS,1) < 5, "E", "S") AS DET_ENTSAI, ';
        strSQL := strSQL + ' COALESCE(AUX_MENEXP, "") AS GER_MSGPED, ';
      End;

      strSQL := strSQL + '  DET_NUMLOT, ';
      strSQL := strSQL + '  ITE_MLTVEN, ';
      strSQL := strSQL + '  RG.GER_PALET_, ';
      strSQL := strSQL + '  IFNULL(ROMDETX.DET_TOTFRE, 0.00) AS DET_TOTFRE, ';
      strSQL := strSQL + '  RG.GER_ENTSAI, ';

      If fImpressaoEspecificaDepCravinhos(blnIteDoc) Then
        strSQL := strSQL + '  DI.DIV_NOMDIV AS LISDIV, '
      Else
        strSQL := strSQL + '  CONCAT(DET_CODDIV,"-",DI.DIV_NOMDIV) AS LISDIV, ';
      strSQL := strSQL + '  RG.GER_OBSFEC AS OBSFEC ';

      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '  ROMGERX RG';

      strSQL := strSQL + '  JOIN ROMDETX ON RG.AUTOINCREM = ROMDETX.DET_SEQGER '+
                         '              AND RG.GER_CODCLI         = DET_CODCLI  '+
                         '              AND RG.GER_NUMROM         = DET_NUMROM  '+
                         '              AND RG.GER_EMPROM         = DET_EMPROM  ';


      strSQL := strSQL + ' LEFT JOIN AUXROMX ON RG.AUTOINCREM = AUXROMX.AUX_SEQGER ';

      strSQL := strSQL + '  JOIN ITEGER G ON  G.ITE_CODITE = DET_CODITE '+
                         '               AND  G.ITE_CODEMP = DET_CODEMP ';

      strSQL := strSQL + ' LEFT JOIN ITEEMB ON ITB_CODITE = G.ITE_CODITE ';
      strSQL := strSQL + '                 AND ITB_CODEMP = G.ITE_CODEMP ';
      strSQL := strSQL + '                 AND ITB_PRIROM = "S"          ';

      strSQL := strSQL + '  JOIN CADCLI ON RG.GER_CODCLI = CLI_CODCLI ';

      strSQL := strSQL + '  LEFT JOIN ENTCLI ON ETC_CODCLI = RG.GER_CODCLI AND ';
      strSQL := strSQL + '    IF(IFNULL(RG.GER_ENTGER, "") <> "", ENTCLI.AUTOINCREM = RG.GER_ENTGER, ';
      strSQL := strSQL + '       ETC_SEQIND = (SELECT MIN(ETC_SEQIND)'+
                         '                       FROM ENTCLI '+
                         '                      WHERE ETC_CODCLI = RG.GER_CODCLI)) ';

      strSQL := strSQL + '  JOIN CADCID ON CID_CODCID = IF( (CLI_NOMCLI NOT LIKE "%CONSUMIDOR%") AND (CLI_NOMCLI NOT LIKE "%SEGURADORA%"), ' +
                                                          fSQLEndereco('ETC_CIDENT', 'CLI_CODCID') + ', RG.GER_CIDCON) ';

      strSQL := strSQL + '  LEFT JOIN ROMTRAX ON RG.AUTOINCREM = ROMTRAX.TRA_SEQGER ';
      strSQL := strSQL + '  LEFT JOIN CADCID CIDENT ON CIDENT.CID_CODCID = RG.GER_CIDENT ';

      strSQL := strSQL + '  LEFT JOIN MOVGER MG ON MG.GER_NUMDOC = RG.GER_NUMDOC AND ';
      strSQL := strSQL + '                         MG.GER_ESPDOC = RG.GER_ESPDOC AND ';
      strSQL := strSQL + '                         MG.GER_CODEMP = RG.GER_CODEMP AND ';
      strSQL := strSQL + '                         MG.GER_CODCLI = RG.GER_CODCLI ';

      strSQL := strSQL + '  JOIN CADUNI ON DET_UNIDAD = UNI_CODUNI ';

      strSQL := strSQL + '  JOIN CADOPE ON OPE_CODOPE = RG.GER_CODVEN ';

      strSQL := strSQL + '  LEFT JOIN CADMAR   ON MAR_CODMAR   = DET_CODMAR ';
      strSQL := strSQL + '       JOIN CADITE I ON I.ITE_CODITE = DET_CODITE ';

      strSQL := strSQL + '  LEFT JOIN CADLOT ON DET_NUMLOT = LOT_NUMLOT  ';
      strSQL := strSQL + '                  AND DET_CODITE = LOT_CODITE  ';
      strSQL := strSQL + '                  AND DET_CODEMP = LOT_CODEMP  ';

      strSQL := strSQL + '  LEFT JOIN CADFPG ON RG.GER_CODFPG = FPG_CODIGO ';
      strSQL := strSQL + '  LEFT JOIN CADCND ON RG.GER_CODCND = CND_CODIGO ';

      strSQL := strSQL + '  LEFT JOIN CADDIV DI ON DI.DIV_CODDIV = DET_CODDIV ';

      strSQL := strSQL + 'WHERE DET_NUMROM = :NUMROM ';
      strSQL := strSQL + '  AND DET_EMPROM = :EMPROM ';
      strSQL := strSQL + '  AND IFNULL(DET_PROEMB,"N") <> "S" ';

      {*****************************************}
      {* ATENÇÃO: FAVOR NÃO TIRAR ESSA VARIÁVEL*}
      {* DAQUI, PORQUE SENÃO O RESUMO DE ITENS *}
      {* POR CLIENTE VAI FICAR ERRADO.         *}
      {**************************************MV*}
      strSQLIteCli := strSQL;
      strSQLCarCar := strSQL;
      strSQLDocCli := strSQL;
      strSQLPorUni := strSQL;

      strSQL := strSQL + 'GROUP BY ';

      If Not blnVenMadOuVidOuMtL Then
      Begin
        strSQL := strSQL + '  DET_CODITE, DET_DESCRI, IFNULL(DET_NUMLOT, ""), RG.GER_ENTSAI ';

        If blnRetFil Then
          strSQL := strSQL + ' , RG.GER_CODFIL ';
      end
      Else
        strSQL := strSQL + '  RG.GER_NUMDOC, RG.GER_ESPDOC, RG.GER_CODEMP, RG.GER_CODCLI, IFNULL(RG.GER_SERIE_, ""), DET_AUTINC ';

      If (blnTemItensSaidaNoRomaneio) Then
        strSQL := strSQL + ' HAVING ((RG.GER_ENTSAI = "S") OR (RG.GER_ENTSAI = "")) ';

      strSQL := strSQL + ' ORDER BY ';
      strSQL := strSQL + ' RG.GER_ORDIMP ';

      With qryGenDet Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;

        If Params.FindParam('LITGAL') <> Nil Then
        Begin
          If SameText(fCfgSis('LITGAL'), 'L') Then
            ParamByName('LITGAL').AsFloat := 1
          Else
            ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
        End;

        ExecSQL;
      End;

      strSQLIteCli := strSQLIteCli + 'GROUP BY ';

      If Not blnVenMadOuVidOuMtL Then
        strSQLIteCli := strSQLIteCli + '  RG.GER_CODCLI, DET_NOMCLI, DET_CODITE, DET_DESCRI '
      Else
        strSQLIteCli := strSQLIteCli + '  RG.GER_NUMDOC, RG.GER_ESPDOC, RG.GER_CODEMP, RG.GER_CODCLI, IFNULL(RG.GER_SERIE_, ""), DET_AUTINC ';

      strSQLIteCli := strSQLIteCli + ' ORDER BY ';
      strSQLIteCli := strSQLIteCli + ' RG.GER_ORDIMP ';

      strSQLIteCli := AnsiReplaceStr(strSQLIteCli, 'TMP_RELROMANEIO', 'TMP_RELROMITECLI');

      If (Pos('CREATE TEMPORARY TABLE', strSQLIteCli) <= 0) And
         (Not blnPrevia) Then
        strSQLIteCli := AnsiReplaceStr(strSQLIteCli, 'INSERT INTO', 'CREATE TEMPORARY TABLE');

      If (fTabelaExiste('TMP_RELROMITECLI')) And (Not blnPrevia) Then
        fDropTable('TMP_RELROMITECLI');

      With qryGenDet Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQLIteCli);
        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;

        If Params.FindParam('LITGAL') <> Nil Then
        Begin
          If SameText(fCfgSis('LITGAL'), 'L') Then
            ParamByName('LITGAL').AsFloat := 1
          Else
            ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
        End;

        ExecSQL;
      End;

      {*******************************************}
      {* SINTETIZA AS UNIDADES                   *}
      {****************************************MV*}
      strSQLPorUni := strSQLPorUni + ' GROUP BY ';

      If Not blnVenMadOuVidOuMtL Then
        strSQLPorUni := strSQLPorUni + '  DET_CODITE, DET_DESCRI, IFNULL(DET_NUMLOT, "") '
      Else
        strSQLPorUni := strSQLPorUni + '  RG.GER_NUMDOC, RG.GER_ESPDOC, RG.GER_CODEMP, RG.GER_CODCLI, IFNULL(RG.GER_SERIE_, ""), DET_AUTINC ';

      strSQLPorUni := AnsiReplaceStr(strSQLPorUni, 'TMP_RELROMANEIO', '');
      strSQLPorUni := AnsiReplaceStr(strSQLPorUni, 'CREATE TEMPORARY TABLE', '');
      strSQLPorUni := AnsiReplaceStr(strSQLPorUni, 'INSERT INTO', '');

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  DET_UNIDAD, ';

      If blnEmbVolume Then
        strSQL := strSQL + '  SUM(DET_VOLUME) AS DET_QTDUNI '
      Else
        strSQL := strSQL + '  SUM(DET_QTDITE) AS DET_QTDUNI ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ( ' + strSQLPorUni + ') AS TMPUNI ';
      strSQL := strSQL + 'GROUP BY ';
      strSQL := strSQL + '  DET_UNIDAD ';

      With qryGenEmb Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;

        If Params.FindParam('LITGAL') <> Nil Then
        Begin
          If SameText(fCfgSis('LITGAL'), 'L') Then
            ParamByName('LITGAL').AsFloat := 1
          Else
            ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
        End;
        Open;
      End;

      {*******************************************}
      {* CARREGA OS DOCUMENTOS                   *}
      {****************************************MV*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  RG.*, ';
      strSQL := strSQL + '  RG.GER_VLRCON - RG.GER_TOTIPI - RG.GER_TOTRET - RG.GER_TOTFRE' + fSQLReformaDocumento + ' AS GER_TOTMER, ';
      strSQL := strSQL + '  FPG_DESCRI AS GER_DESFPG, RG.GER_CONPAG, CND_DESCRI, ';
      strSQL := strSQL + '  CONCAT(RG.GER_NUMDOC, "-", RG.GER_ESPDOC) AS GER_DOCESP, ';
      strSQL := strSQL + '  CONCAT(RG.GER_NUMFAT, "-", RG.GER_TIPFAT) AS GER_DOCFAT, ';
      strSQL := strSQL + '  TRIM(LEFT(CONCAT(RG.GER_CODCLI, "-", IF(RG.GER_NOMCON IS NULL, CLI_NOMCLI, RG.GER_NOMCON)), 35)) AS GER_NOMCLI, ';

      strSQL := strSQL + '  RG.GER_CODFIL, ';

      strSQL := strSQL + '  IF(RG.GER_RETFIL = "S", ';
      strSQL := strSQL + '    CONCAT("Retirar Merc. na Filial ", RG.GER_CODFIL, IF(MG.AUTOINCREM IS NULL, "", CONCAT(" Conferido: ", IF(COALESCE(MG.GER_DTLBEX, "") = "", "Não", "Sim")))), ';
      strSQL := strSQL + '    IF(ROMTRAX.AUTOINCREM IS NOT NULL, ';
      strSQL := strSQL + '      CONCAT("Transbordo Filial ", ROMTRAX.TRA_EMPDES), ';
      strSQL := strSQL + '      "")) AS OBSFIL, ';

      strSQL := strSQL + '  IF(ROMTRAX.AUTOINCREM IS NULL, ';
      strSQL := strSQL + '  TRIM(CONCAT(' + IF_CONS_SEG + ', ' + fSQLEndereco('ETC_ENDENT', 'CONCAT(CLI_ENDERE, " ", IFNULL(CLI_ENDNUM,""), IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT("  ", CLI_ENDCOM)))') + ', RG.GER_ENDCON))), ';
      strSQL := strSQL + '  TRIM(RG.GER_ENDENT)) AS GER_ENDCLI, ';

      strSQL := strSQL + '  IF(ROMTRAX.AUTOINCREM IS NULL, ';
      strSQL := strSQL + '  TRIM(LEFT(CONCAT(' + IF_CONS_SEG + ', ' + fSQLEndereco('ETC_BAIENT', 'CLI_BAIRRO') + ', RG.GER_BAICON)), 35)), ';
      strSQL := strSQL + '  TRIM(LEFT(RG.GER_BAIENT, 35))) AS GER_BAICLI, ';

      strSQL := strSQL + '  IF(ROMTRAX.AUTOINCREM IS NULL, ';
      strSQL := strSQL + '  TRIM(LEFT(CONCAT(' + IF_CONS_SEG + ', ' + fSQLEndereco('ETC_CEPENT', 'CLI_C_E_P_') + ', RG.GER_CEPCON)), 35)), ';
      strSQL := strSQL + '  TRIM(LEFT(RG.GER_CEPENT, 35))) AS GER_CEPCLI, ';

      strSQL := strSQL + '  IF(ROMTRAX.AUTOINCREM IS NULL, ';
      strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, "-", CADCID.CID_ESTADO), ';
      strSQL := strSQL + '  CONCAT(CIDENT.CID_NOMCID, "-", CIDENT.CID_ESTADO)) AS GER_NOMCID, ';

      strSQL := strSQL + '  IF(ROMTRAX.AUTOINCREM IS NULL, ';
      strSQL := strSQL + '  TRIM(LEFT(CONCAT(' + IF_CONS_SEG + ', ' + fSQLEndereco('ETC_REFENT', '""') + ', "")), "")), ';
      strSQL := strSQL + '  TRIM(LEFT(RG.GER_REFENT, ""))) AS GER_REFCLI, ';

      strSQL := strSQL + '  IF(ROMTRAX.AUTOINCREM IS NULL, ';
      strSQL := strSQL + '  CONCAT(TRIM(CONCAT(' + IF_CONS_SEG + ', ' + fSQLEndereco('ETC_ENDENT', 'CONCAT(CLI_ENDERE, " ", IFNULL(CLI_ENDNUM,""), IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT("  ", CLI_ENDCOM)))') + ', RG.GER_ENDCON))), LEFT(CONCAT(' + IF_CONS_SEG + ', IF(IFNULL(ETC_REFENT, "") <> "", ' + fSQLEndereco('CONCAT(" - REFERÊNCIA: ", ETC_REFENT)', '""') + ',""), "")), 60)), ';
      strSQL := strSQL + '  LEFT(CONCAT(TRIM(RG.GER_ENDENT), IF(IFNULL(RG.GER_REFENT, "") <> "", CONCAT(" - REFERÊNCIA: ", RG.GER_REFENT), "")), 60)) AS GER_ENDREF, ';

      strSQL := strSQL + '  ( ';
      strSQL := strSQL + '    SELECT ';
      strSQL := strSQL + '      SUM(DET_TOTPES) ';
      strSQL := strSQL + '    FROM ';
      strSQL := strSQL + '      ROMDETX ';
      strSQL := strSQL + '    WHERE ';
      strSQL := strSQL + '      DET_NUMDOC = RG.GER_NUMDOC AND ';
      strSQL := strSQL + '      DET_ESPDOC = RG.GER_ESPDOC AND ';
      strSQL := strSQL + '      DET_CODEMP = RG.GER_CODEMP AND ';
      strSQL := strSQL + '      DET_CODCLI = RG.GER_CODCLI AND ';
      strSQL := strSQL + '      IFNULL(DET_PROEMB,"N") <> "S" AND ';
      strSQL := strSQL + '      DET_NUMROM = :NUMROM AND DET_EMPROM = :EMPROM) AS GER_TOTPES, ';

      {*********************************************************}
      {* ESTA OPCAO SEMPRE IRA MOSTRAR O VOLUME DO FATURAMENTO *}
      {******************************************************JC*}
      If fCfgSis('VOLROM', varInteger) = 4 Then
        strSQL := strSQL + ' RG.GER_VOLUME AS GER_QTDVOL, '
      Else
      Begin
        strSQL := strSQL + '  ( ';
        strSQL := strSQL + '    SELECT ';
        strSQL := strSQL + '      SUM(IFNULL(' + fCampoQtdIte + ', 0) ';

        Case fCfgSis('VOLROM', varInteger) Of
          1: strSQL := strSQL + '      * IFNULL(UNI_PESLIT,0) / :LITGAL ';
          2: strSQL := strSQL + '      / IF( IFNULL(ITB_QTDEMB,0) = 0, 1, ITB_QTDEMB) ';
          3: strSQL := strSQL + '      / IF( ITE_MLTVEN = 0, 1, ITE_MLTVEN) ';
        End;
        strSQL := strSQL + '      ) ';

        strSQL := strSQL + '    FROM ';
        strSQL := strSQL + '      ROMDETX ';
        strSQL := strSQL + '      INNER JOIN CADUNI    ON DET_UNIDAD   = UNI_CODUNI     ';
        strSQL := strSQL + '      INNER JOIN CADITE I  ON I.ITE_CODITE = DET_CODITE     ';
        strSQL := strSQL + '      INNER JOIN ITEGER G  ON G.ITE_CODITE = DET_CODITE AND ';
        strSQL := strSQL + '                              G.ITE_CODEMP = DET_CODEMP     ';
        strSQL := strSQL + '      LEFT JOIN ITEEMB     ON ITB_CODITE = DET_CODITE       ';
        strSQL := strSQL + '                          AND ITB_CODEMP = DET_CODEMP       ';
        strSQL := strSQL + '                          AND ITB_PRIROM = "S"              ';
        strSQL := strSQL + '    WHERE ';
        strSQL := strSQL + '      RG.AUTOINCREM = ROMDETX.DET_SEQGER AND ';
        strSQL := strSQL + '      DET_CODCLI = RG.GER_CODCLI AND IFNULL(DET_PROEMB,"N") <> "S" AND ';
        strSQL := strSQL + '      DET_NUMROM = :NUMROM AND DET_EMPROM = :EMPROM) AS GER_QTDVOL, ';
      End;

      strSQL := strSQL + '  RG.GER_CODVEN, ';
      strSQL := strSQL + '  IFNULL(RG.GER_FRETE_, 0.00), ';
      strSQL := strSQL + '  IFNULL(RG.GER_PERFRE, 0.00), ';
      strSQL := strSQL + '  CONCAT(RG.GER_CODVEN, "-", OPE_NOMOPE) AS GER_NOMVEN, ';

      strSQL := strSQL + ' (SELECT                                     ';
      strSQL := strSQL + '   CONCAT(FGO_NUMFAT, "-", FGO_TIPFAT)       ';
      strSQL := strSQL + '  FROM                                       ';
      strSQL := strSQL + '   FATGOR                                    ';
      strSQL := strSQL + '  WHERE FGO_CODEMP = RG.GER_CODEMP              ';
      strSQL := strSQL + '   AND FGO_NUMROM = RG.GER_NUMROM               ';
      strSQL := strSQL + '   AND FGO_EMPROM = RG.GER_EMPROM               ';
      strSQL := strSQL + '  AND FGO_OPEROM = RG.GER_OPEROM                ';
      strSQL := strSQL + '  AND FGO_NUMDOC = RG.GER_NUMDOC) AS FGO_DOCFAT ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ROMGERX RG';

      strSQL := strSQL + ' LEFT JOIN CADCLI ON RG.GER_CODCLI = CLI_CODCLI ';

      strSQL := strSQL + 'LEFT JOIN ENTCLI ON ETC_CODCLI = RG.GER_CODCLI AND                                       ';
      strSQL := strSQL + '  IF(IFNULL(RG.GER_ENTGER, "") <> "", ENTCLI.AUTOINCREM = RG.GER_ENTGER,                    ';
      strSQL := strSQL + '     ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = RG.GER_CODCLI)) ';

      strSQL := strSQL + ' LEFT JOIN CADCID ON CID_CODCID = IF( (CLI_NOMCLI NOT LIKE "%CONSUMIDOR%") AND (CLI_NOMCLI NOT LIKE "%SEGURADORA%"), ' +
                                                            fSQLEndereco('ETC_CIDENT', 'CLI_CODCID') + ', RG.GER_CIDCON) ';

      strSQL := strSQL + ' LEFT JOIN ROMTRAX ON RG.AUTOINCREM = ROMTRAX.TRA_SEQGER ';
      strSQL := strSQL + ' LEFT JOIN CADCID CIDENT ON CIDENT.CID_CODCID = RG.GER_CIDENT ';

      strSQL := strSQL + '  LEFT JOIN MOVGER MG ON MG.GER_NUMDOC = RG.GER_NUMDOC AND ';
      strSQL := strSQL + '                         MG.GER_ESPDOC = RG.GER_ESPDOC AND ';
      strSQL := strSQL + '                         MG.GER_CODEMP = RG.GER_CODEMP AND ';
      strSQL := strSQL + '                         MG.GER_CODCLI = RG.GER_CODCLI ';

      strSQL := strSQL + 'LEFT JOIN CADFPG ON RG.GER_CODFPG = FPG_CODIGO ';

      strSQL := strSQL + 'JOIN CADOPE ON OPE_CODOPE = RG.GER_CODVEN ';

      strSQL := strSQL + 'LEFT JOIN CADCND ON (CND_CODIGO = RG.GER_CODCND) ';

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  RG.GER_NUMROM = :NUMROM AND ';
      strSQL := strSQL + '  RG.GER_EMPROM = :EMPROM ';

      strSQL := strSQL + 'ORDER BY ';

      If (strOrdRel = 'E') Then
        strSQL := strSQL + '  GER_NOMCID, GER_BAICLI, GER_CEPCLI, GER_ENDCLI, RG.GER_NUMDOC, RG.GER_ESPDOC, RG.GER_CODEMP '
      Else If (strOrdRel = 'R') Then
        strSQL := strSQL + '  RG.GER_ORDIMP '
      Else
        strSQL := strSQL + '  RG.GER_CODEMP, RG.GER_ESPDOC, RG.GER_NUMDOC ';

      With qryGenDoc Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;

        If Params.FindParam('LITGAL') <> Nil Then
        Begin
          If SameText(fCfgSis('LITGAL'), 'L') Then
            ParamByName('LITGAL').AsFloat := 1
          Else
            ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
        End;

        Open;

        strOpeSol := FieldByName('GER_OPESOL').AsString;

      End;

      qryTotDoc := fCriaQuery;
      pTotalizaTipoDocumentos(qryTotDoc, strNumRom);

      {*******************************************}
      {* TOTALIZA POR FORMA DE PAGAMENTO         *}
      {****************************************MV*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  FPG_DESCRI AS GER_DESFPG, ';
      strSQL := strSQL + '  SUM(GER_VLRCON) AS GER_TOTFPG ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ROMGERX ';
      strSQL := strSQL + 'LEFT JOIN CADFPG ON GER_CODFPG = FPG_CODIGO ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
      strSQL := strSQL + '  GER_EMPROM = :EMPROM ';
      strSQL := strSQL + 'GROUP BY ';
      strSQL := strSQL + '  GER_CODFPG ';
      With qryGenPag Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;
        Open;
      End;

      {**********************************************}
      {* DADOS DO RELATÓRIO - INFORMAÇÕES DOS ITENS *}
      {*******************************************LU*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CONCAT( ';
      strSQL := strSQL + '  CONCAT_WS(".", LEFT(ITE_CODGRU, 3), RIGHT(ITE_CODGRU, 3), DET_CODITE), " - ", DET_DESCRI) ';
      strSQL := strSQL + '  AS ITEM,    ';
      strSQL := strSQL + '  DET_INFITE  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ROMDETX ';
      strSQL := strSQL + '  JOIN CADITE ON ITE_CODITE = DET_CODITE ';
      strSQL := strSQL + 'WHERE DET_NUMROM = :NUMROM ';
      strSQL := strSQL + '  AND DET_EMPROM = :EMPROM ';
      strSQL := strSQL + '  AND ITE_CODITE = DET_CODITE ';
      strSQL := strSQL + '  AND DET_INFITE IS NOT NULL ';
      strSQL := strSQL + '  AND LEFT(DET_CLAFIS,1) >= "5" AND IFNULL(DET_PROEMB,"N") <> "S" ';
      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  ITEM ';

      With qryGenIte Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;
        Open;
      End;

      If (fTabelaExiste('TMP_RELROMITEDOC')) And (Not blnPrevia) Then
        fDropTable('TMP_RELROMITEDOC');

      strSQLDocCli := AnsiReplaceStr(strSQLDocCli, 'TMP_RELROMANEIO', 'TMP_RELROMITEDOC');

      If (Pos('CREATE TEMPORARY TABLE', strSQLDocCli) <= 0) And
        (Not blnPrevia) Then
        strSQLDocCli := AnsiReplaceStr(strSQLDocCli, 'INSERT INTO', 'CREATE TEMPORARY TABLE');

      strSQLDocCli := strSQLDocCli + 'GROUP BY ';
      strSQLDocCli := strSQLDocCli + '  GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_CODCLI, IFNULL(GER_SERIE_, ""), ';

      If Not blnVenMadOuVidOuMtL Then
        strSQLDocCli := strSQLDocCli + '  DET_CODITE, DET_DESCRI, DET_NUMLOT '
      Else
        strSQLDocCli := strSQLDocCli + '  DET_AUTINC ';

      strSQLDocCli := strSQLDocCli + '  HAVING ((GER_ENTSAI = "S") OR (GER_ENTSAI = "")) ';

      strSQLDocCli := strSQLDocCli + 'ORDER BY ';
      strSQLDocCli := strSQLDocCli + '  GER_ORDIMP, GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_CODCLI, IFNULL(GER_SERIE_, ""), DET_CODITE, DET_DESCRI ';

      With qryGenPg1 Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQLDocCli);
        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;

        If Params.FindParam('LITGAL') <> Nil Then
        Begin
          If SameText(fCfgSis('LITGAL'), 'L') Then
            ParamByName('LITGAL').AsFloat := 1
          Else
            ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
        End;

        ExecSQL;
      End;

      With qryGenPg1 Do
      Begin
        Close;
        SQL.Clear;
        //SQL.Add('SELECT * FROM TMP_RELROMITEDOC ORDER BY DOCQUEBRA, '); // antigo
        SQL.Add('SELECT * FROM TMP_RELROMITEDOC ORDER BY GER_ORDIMP, DOCQUEBRA, ');

        If strCliOrdUni = 'U' Then
          SQL.Add(' DET_UNIDAD, DET_DESCRI')
        Else If strCliOrdUni = 'F' Then
          SQL.Add(' DET_AUTINC ')
        Else
          SQL.Add(' DET_DESCRI');

        Open;

        First;
      End;

      {*****************************************}
      {* DADOS PARA CARREGAMENTO DE CARGA      *}
      {**************************************MV*}
      strSQLCarCar := strSQLCarCar + 'GROUP BY ';
      strSQLCarCar := strSQLCarCar + '  GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_CODCLI, IFNULL(GER_SERIE_, ""), ';

      If Not blnVenMadOuVidOuMtL Then
        strSQLCarCar := strSQLCarCar + '  DET_ITEM, DET_DESCRI '
      Else
        strSQLCarCar := strSQLCarCar + '  DET_AUTINC ';

      strSQLCarCar := strSQLCarCar + '  HAVING ((GER_ENTSAI = "S") OR (GER_ENTSAI = "")) ';

      strSQLCarCar := strSQLCarCar + 'ORDER BY ';

      If (strOrdRel = 'E') Then
        strSQLCarCar := strSQLCarCar + '  GER_NOMCID, GER_BAICLI, GER_CEPCLI, GER_ENDCLI, GER_NUMDOC, GER_ESPDOC, GER_CODEMP '
      Else If (strOrdRel = 'R') Then
        strSQLCarCar := strSQLCarCar + '  GER_ORDIMP, GER_CODCLI, GER_NUMDOC, GER_ESPDOC, GER_CODEMP, DET_ITEM, DET_DESCRI '
      Else
        strSQLCarCar := strSQLCarCar + '  GER_CODEMP, GER_ESPDOC, GER_NUMDOC ';

      strSQLCarCar := AnsiReplaceStr(strSQLCarCar, 'TMP_RELROMANEIO', '');
      strSQLCarCar := AnsiReplaceStr(strSQLCarCar, 'CREATE TEMPORARY TABLE', '');
      strSQLCarCar := AnsiReplaceStr(strSQLCarCar, 'INSERT INTO', '');

      With qryCarCar Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQLCarCar);
        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;

        If Params.FindParam('LITGAL') <> Nil Then
        Begin
          If SameText(fCfgSis('LITGAL'), 'L') Then
            ParamByName('LITGAL').AsFloat := 1
          Else
            ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
        End;

        Open;
      End;

      strSQLOut := '';
      strSQLOut := strSQLOut + 'SELECT       ';
      strSQLOut := strSQLOut + '  OUT_DESCRI ';
      strSQLOut := strSQLOut + 'FROM         ';
      strSQLOut := strSQLOut + '  ROMOUTX    ';
      strSQLOut := strSQLOut + 'WHERE        ';
      strSQLOut := strSQLOut + '  OUT_NUMROM = :NUMROM AND ';
      strSQLOut := strSQLOut + '  OUT_ROMEMP = :ROMEMP     ';

      With qryOutEnt Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQLOut);

        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('ROMEMP').AsString := VS_strCodEmp;

        Open;
      End;

      If blnRotaViagem Then
        pCarregaRotaViagem;

      With frmModuloSPR.qryRelatorio Do
      Begin

        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  * ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  TMP_RELROMANEIO ';
        strSQL := strSQL + 'WHERE DET_NUMROM = :NUMROM ';
        strSQL := strSQL + '  AND DET_EMPROM = :EMPROM ';
        strSQL := strSQL + 'ORDER BY ';

        If blnRetFil Then
          strSQL := strSQL + ' COALESCE(GER_CODFIL, "X"), ';

        If blnOrdLoc Then
          strSQL := strSQL + ' DET_LOCFIS, ';

        strSQL := strSQL + ' DET_DESCRI ';

        {****************************************************************************}
        {* QUANDO NÃO TEM ITENS DE SAÍDA, O DATASET PRECISA DE AO MENOS UM REGISTRO *}
        {* PARA MOSTRAR AS "OUTRAS ENTRADAS", AS BANDAS DE ITENS SERÃO OCULTADAS!   *}
        {*************************************************************************RN*}
        If (Not blnTemItensSaidaNoRomaneio) Then
          strSQL := strSQL + ' LIMIT 1 ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;
        Open;

        if (not IsEmpty) or (not qryOutEnt.IsEmpty) Then
        Begin

          If (blnProdutos) Then
            blnProdutos := blnTemItensSaidaNoRomaneio;

          If (blnInfIte) Then
            blnInfIte := blnTemItensSaidaNoRomaneio;

          Try

            If (strTipImp = 'M') Then
              frxReport := frxRotaRomaneioM
            else
              frxReport := frxRotaRomaneioJ;

            frxReport.DotMatrixReport := (strTipImp = 'M');

            { CABEÇALHO }
            frxReport.Script.Variables['NOMEMP'] := fRetNomeEmpresa;

            { CFGSIS }
            frxReport.Script.Variables['RODROM'] := strRodRom;
            frxReport.Script.Variables['MSGRO1'] := fCfgSis('MSGRO1');
            frxReport.Script.Variables['MSGRO2'] := fCfgSis('MSGRO2');
            frxReport.Script.Variables['OPCROM'] := fCfgSis('OPCROM');
            frxReport.Script.Variables['USPRRO'] := fCfgSis('USPRRO');
            frxReport.Script.Variables['VENMAD'] := IIF(blnVenMadOuVidOuMtL, 'S', 'N'); {VOLTAR AQUI}
            frxReport.Script.Variables['LOFIRO'] := fCfgSis('LOFIRO');
            frxReport.Script.Variables['SALROM'] := fCfgSis('SALROM');
            frxReport.Script.Variables['PALROM'] := fCfgSis('PALROM');

            { FILTROS DE IMPRESSÃO }
            frxReport.Script.Variables['PREVIA']         := IIF(blnPrevia, 'S', 'N');
            frxReport.Script.Variables['RETFIL']         := IIF(blnRetFil, 'S', 'N');

            frxReport.Script.Variables['BLN_PRODUTOS']   := IIF(blnProdutos, 'S', 'N');
            frxReport.Script.Variables['IMP_PRODUTOS']   := IIF(blnVolume, 'V', 'Q');
            frxReport.Script.Variables['ORD_PRODUTOS']   := IIF(blnOrdLoc, 'L', 'D');
            frxReport.Script.Variables['BLN_EMBALAGENS'] := IIF(blnEmbalagens, 'S', 'N');
            frxReport.Script.Variables['IMP_EMBALAGENS'] := IIF(blnEmbVolume, 'V', 'Q');
            frxReport.Script.Variables['BLN_DOCUMENTOS'] := IIF(blnDocumentos, 'S', 'N');
            frxReport.Script.Variables['BLN_TOTESPDOC']  := IIF(blnTotEspDoc, 'S', 'N');
            frxReport.Script.Variables['BLN_FORMAS']     := IIF(blnFormas, 'S', 'N');
            frxReport.Script.Variables['BLN_CARCAR']     := IIF(blnCarCar, 'S', 'N');
            frxReport.Script.Variables['BLN_IMP_KM']     := IIF(blnImpKm, 'S', 'N');
            frxReport.Script.Variables['BLN_LOCASS']     := IIF(blnAssRec, 'S', 'N');
            frxReport.Script.Variables['BLN_INFITE']     := IIF(blnInfIte, 'S', 'N');

            frxReport.Script.Variables['BLN_MOSMAR']     := IIF(blnMosMar, 'S', 'N');

            frxReport.Script.Variables['BLN_ITEMCL']     := IIF((blnItemCl) And (Not qryGenPg1.IsEmpty), 'S', 'N');
            frxReport.Script.Variables['IMP_ITEMCL']     := IIF(blnCliVolume, 'V', 'Q');

            { DATASETS }
            frxGenPg1.DataSet := qryGenPg1;
            frxGenEmb.DataSet := qryGenEmb;
            frxGenDoc.DataSet := qryGenDoc;
            frxGenPag.DataSet := qryGenPag;
            frxGenIte.DataSet := qryGenIte;
            frxTotDoc.DataSet := qryTotDoc;
            frxCarCar.DataSet := qryCarCar;
            frxOutEnt.DataSet := qryOutEnt;
            dtsGenPg1.DataSet := qryGenPg1;

            {***************************************************************************************}
            { ADICIONADO ROLLBACK QUANDO FOR IMPRESSÃO DE PRÉVIA DO ROMANEIO.                       }
            { AO GERAR PRÉVIA, ESTÁ INCIANDO A TRANSAÇÃO NO MÉTODO UNTFATROMANEIO.FCONFIRMAROMANEIO }
            { E A MESMA PERMANECIA ABERTA ENQUANTO NÃO FECHASSE A IMPRESSÃO TRAVANDO AS CONEXÕES    }
            {***********************************************************************************DH**}
            if blnPrevia then
              fRollback;

            { COMPLEMENTOS DE CABEÇALHO }
            If fEmptyStr(strOpeSol) Then
              frxReport.Script.Variables['OPERADOR_SOLICITANTE'] := 'OPERADOR SOLICITANTE: PRÉVIA DO ROMANEIO'
            Else
              frxReport.Script.Variables['OPERADOR_SOLICITANTE'] := 'OPERADOR SOLICITANTE: ' + strOpeSol + '-' +
                                                                    fRetNomVendRep(strOpeSol);

            frxReport.Script.Variables['ROMANEIO_NUMERO_ROTA']  := 'ROMANEIO No. ' + strNumRom;
            If blnPrevia Then
              frxReport.Script.Variables['ROMANEIO_NUMERO_ROTA'] := 'PRÉVIA DE ROMANEIO';

            frxReport.Script.Variables['ROMANEIO_NUMERO_ITENS'] := 'ROMANEIO No. ' + strNumRom;
            If blnPrevia Then
              frxReport.Script.Variables['ROMANEIO_NUMERO_ITENS'] := 'PRÉVIA DE ROMANEIO - NÃO É VÁLIDO PARA ENTREGA';

            frxReport.Script.Variables['MOTORISTA'] := 'MOTORISTA: ' + strNomMot;

            If Not fEmptyStr(strNomAj1) Then
             frxReport.Script.Variables['AJUDANTE_01'] := 'AJUDANTE 01: ' + strNomAj1
            Else frxReport.Script.Variables['AJUDANTE_01'] := '';

            If Not fEmptyStr(strNomAj2) Then
             frxReport.Script.Variables['AJUDANTE_02'] := 'AJUDANTE 02: ' + strNomAj2
            Else frxReport.Script.Variables['AJUDANTE_02'] := '';

            If Not fEmptyStr(strNomAj3) Then
              frxReport.Script.Variables['AJUDANTE_03'] := 'AJUDANTE 03: ' + strNomAj3
            Else
              frxReport.Script.Variables['AJUDANTE_03'] := '';

            If Not fEmptyStr(strNomAj4) Then
              frxReport.Script.Variables['AJUDANTE_04'] := 'AJUDANTE 04: ' + strNomAj4
            Else
              frxReport.Script.Variables['AJUDANTE_04'] := '';

            If (blnRomaneioSimplificado) Then
              frxReport.Script.Variables['TRANSPORTADORA'] := 'TRANSP.: ' + fRetornaTransportadoras(strNumRom, VS_strCodEmp)
            Else
              frxReport.Script.Variables['TRANSPORTADORA'] := 'TRANSP.: ' + strNomTra + '   ' +
                                                               IIF(fEmptyStr(strPlaVei), '', 'VEICULO: ' + strPlaVei);

            frxReport.AddFunction('function fFormataCondPag(strConPag: String): String;');
            frxReport.AddFunction('function fRetMetragemItem(strDetAutInc, strEspDoc: String): String;');
            frxReport.AddFunction('function fFormataTelefone(strTelefone: String): String;');

            If Not fImpressaoEspecificaDepCravinhos(blnIteDoc) Then
            begin
              If blnProdutos Or blnEmbalagens Or blnDocumentos Or blnFormas Or blnCarCar Then
              Begin
                Try
                  If frxReport.PrepareReport Then
                  Begin
                    If fEmptyStr(strNomeFila) Then
                      pPreviewReport('frmFatRomaneio', 'Impressão Romaneio (' + strNumRom + ')', frxReport)
                    Else
                      pPrintReport('frmFatRomaneio', 'Impressão Romaneio (' + strNumRom + ')', strNomeFila, frxReport);
                  End;
                Except
                    On E: Exception Do
                    Begin
                      pMensagemOk('Não foi possível realizar a impressão. Verifique a impressora: '+strNomeFila);
                    End;
                  End;
              End

              Else If (blnItemCl) And (Not qryGenPg1.IsEmpty) Then
              Begin
                Try
                  If frxReport.PrepareReport Then
                  Begin
                    If fEmptyStr(strNomeFila) Then
                      pPreviewReport('frmFatRomaneio', 'Impressão Romaneio - Itens por Cliente (' + strNumRom + ')', frxReport)
                    Else
                      pPrintReport('frmFatRomaneio', 'Impressão Romaneio - Itens por Cliente (' + strNumRom + ')', strNomeFila, frxReport);
                  End;
                Except
                    On E: Exception Do
                    Begin
                      pMensagemOk('Não foi possível realizar a impressão. Verifique a impressora: '+strNomeFila);
                    End;
                  End;
              End;
            end;

            If (blnIteDoc Or blnEndEnt) Then
            Begin
              If fImpressaoEspecificaDepCravinhos(blnIteDoc) Then
              Begin
                frxRelItens := frxDepCravinhos;
                frxRelItens.LoadFromFile(ExtractFilePath(Application.ExeName) + '\ROMANEIO_DEP_CRAVINHOS.fr3');
                frxRelItens.PrintOptions.PrintMode := pmSplit;
                frxRelItens.Script.Variables['PERIODO'] := 'ROMANEIO: ' + strNumRom;

                strProfissionais := fRetornaProfissionais(strNumRom, VS_strCodEmp);
                frxRelItens.Script.Variables['PROFISSIONAL'] := IIF(Not fEmptyStr(strProfissionais), '- Prof: ' + strProfissionais, '');

                If Not fEmptyStr(strRodRom) Then
                Begin
                  If Length(strRodRom) > 67 Then
                  Begin
                    If frxRelItens.FindObject('mmoMsgRod1') <> Nil Then
                      TfrxMemoView(frxRelItens.FindObject('mmoMsgRod1')).Text := Copy(strRodRom, 1, 67);

                    If frxRelItens.FindObject('mmoMsgRod2') <> Nil Then
                    Begin
                      intTam := IIF((Length(strRodRom) - 67) > 57, 57, (Length(strRodRom) - 67));
                      TfrxMemoView(frxRelItens.FindObject('mmoMsgRod2')).Text := Copy(strRodRom, 68, intTam);
                    End;
                  End
                  Else
                    If frxRelItens.FindObject('mmoMsgRod1') <> Nil Then
                      TfrxMemoView(frxRelItens.FindObject('mmoMsgRod1')).Text := strRodRom;
                End;

                If frxRelItens.PrepareReport Then
                Begin
                  If fEmptyStr(strNomeFila) Then
                  Begin
                    pPreviewReport('frmFatRomaneio', 'Impressão Romaneio - Itens por Documento (' + strNumRom + ')', frxRelItens);
                  End
                  Else
                  Begin
                    intQtdVias := fGetMenu('Qtde. Vias (Sessão "Itens por Documentos")', ['Não Imprimir', '1 Via', '2 Vias', '3 Vias', '4 Vias', '5 Vias'], 2) -1;

                    For intPosicao := 1 To intQtdVias Do
                    Begin
                      frxRelItens.PrintOptions.ShowDialog := False;
                      frxRelItens.PrintOptions.Printer    := AnsiReplaceText(strNomeFila,'\\' + fRetNomeRede + '\','');
                      pPrintReport('frmFatRomaneio', 'Impressão Romaneio - Itens por Documento (' + strNumRom + ')', strNomeFila, frxRelItens);
                    End;
                  End;
                End;
              End
              Else
              Begin
                If (strTipImp = 'M') Then
                Begin

                  If blnIteDoc Then
                  begin
                    if ( FCfgSis('ROMIDO') = 2 ) then begin
                      frxRelItens :=  frxReport1; //frxItensCliM2
                    end else begin
                      If (blnImpVal) Then Begin
                        frxRelItens := frxItensValoresCliM;
                      End Else Begin
                        frxRelItens := frxItensCliM;
                      End;
                    end;
                  end Else If fCfgSis('EMBSEP', varBoolean) Then Begin
                    frxRelItens := frxItensEntEmbSepM;
                  End Else if blnMenExp Then Begin
                    frxRelItens := frxItensEntMenExpM;
                  end Else Begin
                    frxRelItens := frxItensEntM;
                  End;
                End
                Else
                Begin

                  If blnIteDoc Then Begin
                    If blnImpVal Then Begin
                      frxRelItens := frxItensValoresCliJ;
                    End Else Begin
                      frxRelItens := frxItensCliJ;
                    End;
                  End Else If fCfgSis('EMBSEP', varBoolean) Then Begin
                    frxRelItens := frxItensEntEmbSepJ;
                  End Else If blnMenExp Then Begin
                    frxRelItens := frxItensEntMenExpJ;
                  End
                  Else Begin
                    frxRelItens := frxItensEntJ;
                  End;

                  frxRelItens.DotMatrixReport           := False;
                  frxRelItens.PrintOptions.PrintMode    := pmScale;
                  frxRelItens.PrintOptions.PrintOnSheet := 9; //A4
                  TfrxMemoView(frxRelItens.FindObject('rllZebra')).Highlight.Color := fCfgSis('CORZEB');
                End;

                If frxRelItens.FindObject('childAssinatura') <> Nil Then
                  TfrxChild(frxRelItens.FindObject('childAssinatura')).Visible := blnAssRec;

                If frxRelItens.FindObject('rllPalet') <> Nil Then
                  TfrxMemoView(frxRelItens.FindObject('rllPalet')).Visible := fCfgSis('PALROM', VarBoolean) And blnIteDoc;

                If frxRelItens.FindObject('mmoMsgRod') <> Nil Then
                  TfrxMemoView(frxRelItens.FindObject('mmoMsgRod')).Text := IIF(strTipImp = 'M', fRemoveAcento(strRodRom), strRodRom);

                If frxRelItens.FindObject('childMsgPer') <> Nil Then
                Begin
                  {**********************************************************************}
                  { A GUIDULI USA UMA MENSAGEM PERSONALIZADA PARA ASSINATURA NESSE BLOCO }
                  {*******************************************************************VA*}
                  TfrxChild(frxRelItens.FindObject('childMsgPer')).Visible := False;

                  If (Not blnAssRec) And (Not fEmptyStr(strRodPer)) Then
                  Begin
                    TfrxGroupFooter(frxRelItens.FindObject('GroupFooter1')).Child := TfrxChild(frxRelItens.FindObject('childMsgPer'));
                    TfrxChild(frxRelItens.FindObject('childMsgPer')).Visible := True;
                    TfrxMemoView(frxRelItens.FindObject('mmoMsgPer')).Text := IIF(strTipImp = 'M', fRemoveAcento(strRodPer), strRodPer);
                  End;
                End;

                frxRelItens.Script.Variables['NOMEMP'] := fRetFantasiaEmpresa;
                frxRelItens.Script.Variables['NOMREL'] := 'ITENS POR DOCUMENTO';
                frxRelItens.Script.Variables['PERIODO'] := 'ROMANEIO No. ' + strNumRom + ' - MOTORISTA: ' + strNomMot;

                If frxRelItens.FindObject('mmObs') <> Nil Then
                  frxRelItens.Script.Variables['OBSERVACAO'] := 'OBSERVAÇÃO: ' + strObsFec;

                If blnPrevia Then
                  frxRelItens.Script.Variables['PERIODO'] := 'PRÉVIA DE ROMANEIO - NÃO É VÁLIDO PARA ENTREGA';

                If (blnTemItensSaidaNoRomaneio) Then
                Begin
                  try
                    If frxRelItens.PrepareReport Then Begin
                      If fEmptyStr(strNomeFila) Then Begin
                        pPreviewReport('frmFatRomaneio', 'Impressão Romaneio - Itens por Documento (' + strNumRom + ')', frxRelItens);
                      End Else Begin
                        frxRelItens.PrintOptions.ShowDialog := False;
                        frxRelItens.PrintOptions.Printer    := AnsiReplaceText(strNomeFila,'\\' + fRetNomeRede + '\','');
                        pPrintReport('frmFatRomaneio', 'Impressão Romaneio - Itens por Documento (' + strNumRom + ')', strNomeFila, frxRelItens);
                      End;
                    End;
                  except
                    On E: Exception Do Begin
                      pMensagensErro(E.Message, '');
                    End;
                  end;
                End;
              End;

              If blnRotaViagem Then
              Begin

                If (strTipImp = 'M') Then
                Begin
                  frxRelItens := frxRotaViagemM;
                End
                Else
                Begin
                  frxRelItens := frxRotaViagemJ;

                  frxRelItens.DotMatrixReport           := False;
                  frxRelItens.PrintOptions.PrintMode    := pmScale;
                  frxRelItens.PrintOptions.PrintOnSheet := 9; //A4
                  TfrxMemoView(frxRelItens.FindObject('rllZebra')).Highlight.Color := fCfgSis('CORZEB');
                End;

                If fCfgSis('USPRRO', varBoolean) And (fCfgSis('OPCROM') = '1') Then
                Begin
                  TfrxMemoView(frxRelItens.FindObject('mmoTitNumDoc')).Text := 'PEDIDO';
                  TfrxMemoView(frxRelItens.FindObject('mmoTitNumFat')).Text := 'NOTA';
                End;

                TfrxMemoView(frxRelItens.FindObject('rllTitPalet')).Visible := fCfgSis('PALROM', varBoolean);
                TfrxMemoView(frxRelItens.FindObject('rllDetPalet')).Visible := fCfgSis('PALROM', varBoolean);

                frxRelItens.Script.Variables['NOMEMP'] := fRetFantasiaEmpresa;
                frxRelItens.Script.Variables['NOMREL'] := 'ROTEIRO DE VIAGEM';
                frxRelItens.Script.Variables['PERIODO'] := 'ROMANEIO No. ' + strNumRom;

                If blnPrevia Then
                  frxRelItens.Script.Variables['PERIODO'] := 'PRÉVIA DE ROMANEIO';

                frxRelItens.Script.Variables['MOTORI'] := 'MOTORISTA: ' + strNomMot;
                frxRelItens.Script.Variables['VEICUL'] := 'VEICULO: '   + strPlaVei;

                If frxRelItens.PrepareReport Then
                  If fEmptyStr(strNomeFila) Then
                    pPreviewReport('frmFatRomaneio', 'Impressão Romaneio - Itens por Documento (' + strNumRom + ')', frxRelItens)
                  Else
                  Begin
                    frxRelItens.PrintOptions.ShowDialog := False;
                    frxRelItens.PrintOptions.Printer    := AnsiReplaceText(strNomeFila,'\\' + fRetNomeRede + '\','');
                    pPrintReport('frmFatRomaneio', 'Impressão Romaneio - Itens por Documento (' + strNumRom + ')', strNomeFila, frxRelItens);
                  End;
              End;

            End;

          Except
            On E: Exception Do
            Begin
              blnPrevia := False;
              pMensagensErro(E.Message, '[frmQckRomGer.pImprimeRomaneio]');
            End;
          End;

        End
        Else
        Begin
          fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);
        End;

        Close;
      End;

    Finally

      If (Not blnPrevia) Then
      Begin
        fDropTable('TMP_RELROMANEIO');
      End;

      FreeAndNil(qryGenPg1);
      FreeAndNil(qryGenEmb);
      FreeAndNil(qryGenDoc);
      FreeAndNil(qryGenPag);
      FreeAndNil(qryGenIte);
      FreeAndNil(qryGenGer);
      FreeAndNil(qryGenDet);
      FreeAndNil(qryTotDoc);
      FreeAndNil(qryCarCar);
      FreeAndNil(qryOutEnt);
      FreeAndNil(qryRotVia);
      FreeAndNil(FormQckRomGer);
    End;
  End;

end;

function fRetornaTransportadoras(strNumRom, strEmpRom : String): String;
Var
  qryAux : TUniQuery;
  strTra : String;
Const
  strSQL = 'SELECT                                                   '+
           '  DISTINCT IFNULL(G.GER_CODTRA, T.GER_CODTRA) AS CODTRA  '+
           'FROM                                                     '+
           '  ROMGERX X                                              '+
           '  LEFT JOIN MOVGER G ON (G.GER_NUMDOC = X.GER_NUMDOC AND '+
           '                         G.GER_ESPDOC = X.GER_ESPDOC AND '+
           '                         G.GER_CODEMP = X.GER_CODEMP AND '+
           '                         G.GER_CODCLI = X.GER_CODCLI)    '+
           '  LEFT JOIN NOTGER T ON (T.GER_NUMDOC = X.GER_NUMDOC AND '+
           '                         T.GER_ESPDOC = X.GER_ESPDOC AND '+
           '                         T.GER_CODEMP = X.GER_CODEMP AND '+
           '                         T.GER_CODCLI = X.GER_CODCLI)    '+
           'WHERE X.GER_NUMROM = :NUMROM AND X.GER_EMPROM = :EMPROM AND X.GER_ESPDOC <> "OX" ';
begin

  Result := '';

  If fEmptyStr(strNumRom) Then
    Exit;

  qryAux := fCriaQuery;

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMROM').AsString := strNumRom;
    qryAux.ParamByName('EMPROM').AsString := strEmpRom;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
    Begin
      qryAux.First;
      While Not qryAux.Eof Do
      Begin
        strTra := qryAux.FieldByName('CODTRA').AsString + '-' + fRetNomTransportadora(qryAux.FieldByName('CODTRA').AsString);
        Result := IIF(Not Result.IsEmpty, Result + ', ' + strTra, strTra);
        qryAux.Next;
      End;
    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function fRetornaProfissionais(strNumRom, strEmpRom : String): String;
Var
  qryAux : TUniQuery;
Const
  strSQL = 'SELECT GROUP_CONCAT(DIV_NOMDIV SEPARATOR '', '') AS PROFISSIONAIS FROM CADDIV WHERE DIV_CODDIV IN (SELECT DET_CODDIV FROM ROMDETX WHERE DET_NUMROM = :NUMROM AND DET_EMPROM = :EMPROM)';
begin

  Result := '';

  If fEmptyStr(strNumRom) Then
    Exit;

  qryAux := fCriaQuery;

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMROM').AsString := strNumRom;
    qryAux.ParamByName('EMPROM').AsString := strEmpRom;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
      Result := qryAux.FieldByName('PROFISSIONAIS').AsString;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function fTemItensDeSaidaNoRomaneio(strNumRom, strEmpRom: String): Boolean;
  Var
    qryRomSai : TUniQuery;
begin
  qryRomSai := fCriaQuery(Nil);
  Try
    With qryRomSai Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT DISTINCT DET_NUMROM, DET_EMPROM, DET_AUTINC, DET_CODITE ');
      SQL.Add('   FROM ROMDETX ');
      SQL.Add('  INNER JOIN ROMGERX ON GER_NUMROM = DET_NUMROM ');
      SQL.Add('                    AND GER_EMPROM = DET_EMPROM ');
      SQL.Add('  WHERE DET_NUMROM = :NUMROM ');
      SQL.Add('    AND DET_EMPROM = :EMPROM AND IFNULL(DET_PROEMB,"N") <> "S" ');
      SQL.Add('    AND ((GER_ENTSAI = "S") OR (GER_ENTSAI = "")) '); // compatibilidade
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := strEmpRom;
      Open;
      Result := Not (qryRomSai.IsEmpty);
      Close;
    End;
  Finally
    FreeAndNil(qryRomSai);
  End;
end;

function fTemRomaneioRetiraFilial(strNumRom, strEmpRom: String): Boolean;
Var
  qryRom : TUniQuery;
begin
  If Not fCfgSis('UTITDE', varBoolean) Then
    Exit(False);

  qryRom := fCriaQuery();
  Try
    qryRom.SQL.Add('SELECT AUTOINCREM');
    qryRom.SQL.Add('FROM ROMGERX');
    qryRom.SQL.Add('WHERE GER_NUMROM = :NUMROM ');
    qryRom.SQL.Add('  AND GER_EMPROM = :EMPROM ');
    qryRom.SQL.Add('  AND GER_CODFIL IS NOT NULL');

    qryRom.ParamByName('NUMROM').AsString := strNumRom;
    qryRom.ParamByName('EMPROM').AsString := strEmpRom;

    qryRom.Open;
    Result := Not (qryRom.IsEmpty);
  Finally
    FreeAndNil(qryRom);
  End;
end;

procedure TfrmQckRomGer.DataModuleCreate(Sender: TObject);
  Var
    strNumDec: String;
    intContador:integer;
begin
  blnVenMadOuVidOuMtL := fCfgSis('VENMAD', varBoolean) Or
                         fCfgSis('VENVID', varBoolean) Or
                         fCfgSis('VENMTL', varBoolean);

  strNumDec := IntToStr(fCfgSis('DECQTD', varInteger));

  With frxItensCliM Do
  Begin
    TfrxMemoView(FindObject('frxDBItensCliDET_QTDITE')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxMemoView(FindObject('rllTempTot')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxChild(FindObject('ChildMsgExp')).Visible := fCfgSis('MEXROM', varBoolean);
    AddFunction('function fFormataFoneInterna(strFone: String): String');
    AddFunction('function fRetMetragemItem(AutoIncremRomDetX, EspDoc: string): String;');
  End;

  With frxItensValoresCliM Do
  Begin
    TfrxMemoView(FindObject('frxDBItensCliDET_QTDITE')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxMemoView(FindObject('rllTempTot')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxChild(FindObject('ChildMsgExp')).Visible := fCfgSis('MEXROM', varBoolean);
    AddFunction('function fFormataFoneInterna(strFone: String): String');
    AddFunction('function fRetMetragemItem(AutoIncremRomDetX, EspDoc: string): String;');
  End;

  With frxItensCliJ Do
  Begin
    TfrxMemoView(FindObject('frxDBItensCliDET_QTDITE')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxMemoView(FindObject('rllTempTot')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxChild(FindObject('ChildMsgExp')).Visible := fCfgSis('MEXROM', varBoolean);
    AddFunction('function fFormataFoneInterna(strFone: String): String');
    AddFunction('function fRetMetragemItem(AutoIncremRomDetX, EspDoc: string): String;');
  End;

  With frxItensValoresCliJ Do
  Begin
    TfrxMemoView(FindObject('frxDBItensCliDET_QTDITE')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxMemoView(FindObject('rllTempTot')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxChild(FindObject('ChildMsgExp')).Visible := fCfgSis('MEXROM', varBoolean);
    AddFunction('function fFormataFoneInterna(strFone: String): String');
    AddFunction('function fRetMetragemItem(AutoIncremRomDetX, EspDoc: string): String;');
  End;

  With frxReport1 Do // layout 2 "cfg_romido=2"
  Begin
    AddFunction('function fFormataFoneInterna(strFone: String): String');
  End;

  With frxItensEntM Do
  Begin
    TfrxMemoView(FindObject('frxDBItensCliDET_QTDITE')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxMemoView(FindObject('rllTempTot')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxChild(FindObject('ChildMsgExp')).Visible := fCfgSis('MEXROM', varBoolean);
    AddFunction('function fFormataFoneInterna(strFone: String): String');
  End;

  With frxItensEntMenExpM Do
  Begin
    TfrxMemoView(FindObject('frxDBItensCliDET_QTDITE')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxMemoView(FindObject('rllTempTot')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    AddFunction('function fFormataFoneInterna(strFone: String): String');
  End;

  With frxItensEntJ Do
  Begin
    TfrxMemoView(FindObject('frxDBItensCliDET_QTDITE')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxMemoView(FindObject('rllTempTot')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxChild(FindObject('ChildMsgExp')).Visible := fCfgSis('MEXROM', varBoolean);
    AddFunction('function fFormataFoneInterna(strFone: String): String');
  End;

  With frxItensEntMenExpJ Do
  Begin
    TfrxMemoView(FindObject('frxDBItensCliDET_QTDITE')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxMemoView(FindObject('rllTempTot')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    AddFunction('function fFormataFoneInterna(strFone: String): String');
  End;

  With frxItensEntEmbSepJ Do
  begin
    AddFunction('function fFormataFoneInterna(strFone: String): String');
  end;

  With frxItensEntEmbSepM Do
  begin
    AddFunction('function fFormataFoneInterna(strFone: String): String');
  end;

  With frxDepCravinhos Do
  Begin
    TfrxMemoView(FindObject('frxDBItensCliDET_QTDITE')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    AddFunction('function fFormataFoneInterna(strFone: String): String');
  End;

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
end;

function TfrmQckRomGer.fFormataFoneInterna(strFone: String): String;
begin
  Result := fFormataFone(strFone);
end;

function TfrmQckRomGer.fRetMetragemItem(AutoIncremRomDetX, strEspDoc: string): String;
  var
    strSqlBase, strSQLFinal, strSQLTMP: String;
    qryGen: TUniQuery;
begin
  strSqlBase := strSqlBase + ' SELECT SQL_NO_CACHE     ';
  strSqlBase := strSqlBase + '   DET_QTDPEC AS QTDPEC, ';
  strSqlBase := strSqlBase + '   DET_COMPEC AS COMPEC, ';
  strSqlBase := strSqlBase + '   DET_LARPEC AS LARPEC, ';
  strSqlBase := strSqlBase + '   DET_ESPPEC AS ESPPEC, ';
  strSqlBase := strSqlBase + '   DET_APAREL AS APAREL, ';
  strSqlBase := strSqlBase + '   DET_BENEFI AS BENEFI,  ';
  strSqlBase := strSqlBase + '   (SELECT CONCAT(GER_MEN001, " ", GER_MEN001) ';
  strSqlBase := strSqlBase + '      FROM MOVGER ';
  strSqlBase := strSqlBase + '     WHERE AUTOINCREM = (SELECT DET_SEQGER ';
  strSqlBase := strSqlBase + '                           FROM MOVDET ';
  strSqlBase := strSqlBase + '                          WHERE AUTOINCREM = MOVMAD.DET_SEQGER)) AS MENSAGEM ';
  strSqlBase := strSqlBase + ' FROM ';
  strSqlBase := strSqlBase + '   MOVMAD ';
  strSqlBase := strSqlBase + ' WHERE ';
  strSqlBase := strSqlBase + '   DET_SEQGER = ' + QuotedStr(AutoIncremRomDetX);
  strSQLFinal := strSQLFinal + strSqlBase;
  strSQLFinal := strSQLFinal + ' UNION ALL ';

  strSQLTMP := AnsiReplaceStr(AnsiReplaceStr(strSqlBase, 'MOVMAD', 'ORCMAD'), 'DET_', 'FDO_');
  strSQLTMP := AnsiReplaceStr(AnsiReplaceStr(strSQLTMP, 'MOVGER', 'FATGOR'), 'GER_', 'FGO_');
  strSQLTMP := AnsiReplaceStr(strSQLTMP, 'MOVDET', 'FATDOR');

  strSQLFinal := strSQLFinal + strSQLTMP;
  strSQLFinal := strSQLFinal + ' UNION ALL ';

  strSQLTMP := AnsiReplaceStr(strSqlBase, 'MOVGER', 'NOTGER');
  strSQLTMP := AnsiReplaceStr(strSQLTMP, 'MOVMAD', 'NOTMAD');
  strSQLTMP := AnsiReplaceStr(strSQLTMP, 'MOVDET', 'NOTDET');

  strSQLFinal := strSQLFinal + strSQLTMP;

  qryGen := fCriaQuery(Nil);
  With qryGen, SQL Do
  begin
    Clear;
    Add(strSQLFinal);
    Open;
    Result := '';
    If (Not IsEmpty) And (FieldByName('QTDPEC').AsFloat > 0) Then
    Begin
      If fCfgSis('VENMAD',varBoolean) Then
      Begin
        Result := 'QTD.: '     + FloatToStrF( FieldByName('QTDPEC').AsFloat, ffFixed, 12, 00 ) + ' ' +
                  'COMP.: '    + FloatToStrF( FieldByName('COMPEC').AsFloat, ffFixed, 12, 05 ) + ' ' +
                  'LARG.: '    + FloatToStrF( FieldByName('LARPEC').AsFloat, ffFixed, 12, 05 ) + ' ' +
                  'ESPES.: '   + FloatToStrF( FieldByName('ESPPEC').AsFloat, ffFixed, 12, 05 ) + ' ' + #13#10 +
                  'MENSAGEM: ' + FieldByName('MENSAGEM').AsString;

        If FieldByName('APAREL').AsString = 'S' Then Result := Result + '/APARELHADA';
        If FieldByName('BENEFI').AsString = 'S' Then Result := Result + '/BENEFICIADA';
      End
      Else If fCfgSis('VENMTL',varBoolean) Then
      Begin
        Result := FloatToStrF( FieldByName('QTDPEC').AsFloat, ffFixed, 12, 05 ) + ' PECAS DE ' +
                  FloatToStrF( FieldByName('COMPEC').AsFloat, ffFixed, 12, 05 ) + ' MTS = ' +
                  FloatToStrF( FieldByName('QTDPEC').AsFloat *
                               FieldByName('COMPEC').AsFloat, ffFixed, 12, 05 ) + #13#10 +
                  'MENSAGEM:'  + FieldByName('MENSAGEM').AsString;
      End
      Else // fCfgSis('VENVID',varBoolean) VENDA VIDRO
      Begin
        Result := 'QTD.: '    + FloatToStrF( FieldByName('QTDPEC').AsFloat, ffFixed, 12, 00 ) + ' ' +
                  'LARG.: '   + FloatToStrF( FieldByName('LARPEC').AsFloat, ffFixed, 12, StrToIntDef(fFormataCasaDecimalVIDRO('5'),0)) + ' ' +
                   UpperCase(fRetornaInfMedVIDRO(True,True,False,False,True))  + FloatToStrF( FieldByName('COMPEC').AsFloat, ffFixed, 12, StrToIntDef(fFormataCasaDecimalVIDRO(5),0) ) + ' ' + #13#10 +
                  'MENSAGEM:' + FieldByName('MENSAGEM').AsString;
      End;
    End;
  end;
  FreeAndNil(qryGen);
end;

function TfrmQckRomGer.frxItensCliMUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  If (SameText(MethodName, 'fFormataFoneInterna')) Then
    Result := fFormataFoneInterna(Trim(Params[0]));
  If (SameText(MethodName, 'fRetMetragemItem')) Then
    Result := fRetMetragemItem(Trim(Params[0]), Trim(Params[1]));
end;

function TfrmQckRomGer.frxReportJUserFunction(const MethodName: string;
  var Params: Variant): Variant;begin

  If SameText(MethodName, 'fFormataCondPag') Then
    Result := fFormataCondPag(Params[0])
  Else if SameText(MethodName, 'fRetMetragemItem') Then
    Result := fRetMetragemItem(Params[0], Params[1])
  Else if SameText(MethodName, 'fFormataTelefone') Then
    Result := fFormataFoneInterna(Params[0]);


end;

end.

