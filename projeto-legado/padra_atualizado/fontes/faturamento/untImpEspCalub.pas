unit untImpEspCalub;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDBSet, untZClient, System.StrUtils,
  Forms, Data.DB, frxDMPExport, Uni;

type
  TfrmImpEspCalub = class(TForm)
    frxRelatorio: TfrxDBDataset;
    frxCalub: TfrxReport;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    function frxCalubUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
  public
    { Public declarations }
    class function fTemFR3 : Boolean;
    class procedure pImprime(strNumDoc, strEspDoc, strCodCli, strCodEmp: String;
      intQtdImp: Integer);
  end;

var
  frmImpEspCalub: TfrmImpEspCalub;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses untFuncoesSimples, untFuncoesGenerica, untCfgRel;

{$R *.dfm}

{ TfrmImpEsp }

function TfrmImpEspCalub.frxCalubUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACEP' Then
    Result := fFormataCEP(Params[0])
  Else If MethodName = 'FFORMATAFONE' Then
    Result := fFormataFone(Params[0])
  Else If MethodName = 'FFORMATACPFCGC' Then
    Result := fFormataCpfCgc(Params[0], opcBrasil, '');
end;

class function TfrmImpEspCalub.fTemFR3: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + 'frxCalub.fr3');
end;

class procedure TfrmImpEspCalub.pImprime(strNumDoc, strEspDoc, strCodCli,
  strCodEmp: String; intQtdImp: Integer);
  var
    frmImpEspCalub: TfrmImpEspCalub;
    cdsRelatorio: TZClient;
    intPosicao: Integer;
    qryCfgRel: TUniQuery;
    strNomFil,
    strTipImp: String;

    function fGetSql(strEspDoc: String): String;
      Var
        strPrefix,
        strPreGer: String;
        blnPedOrc: Boolean;
    begin
      Result    := '';
      blnPedOrc := Pos(strEspDoc, 'PD_OR_') > 0;

      If blnPedOrc Then
      Begin
        strPrefix := 'FDO_';
        strPreGer := 'FGO_';
      End
      Else
      Begin
        strPrefix := 'DET_';
        strPreGer := 'GER_';
      End;

      Result := Result + ' SELECT ';
      Result := Result + strPrefix + 'CODVEN AS CODVEN, ';
      Result := Result + '  COALESCE(OPE_NOMOPE, "") AS NOMVEN, ';
      Result := Result + strPrefix + 'CODCLI AS CODCLI, ';
      Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",' + strPreGer + 'NOMCON,CLI_NOMCLI) AS NOMCLI, ';
      Result := Result + '  CLI_FANSOB       AS FANSOB, ';
      Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",' + strPreGer + 'ENDCON,CLI_ENDERE) AS ENDERE, ';
      Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",' + strPreGer + 'BAICON,CLI_BAIRRO) AS BAIRRO, ';
      Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",' + strPreGer + 'CIDCON,CLI_CODCID) AS CODCID, ';
      Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",COALESCE(Z.CID_NOMCID, ""),COALESCE(C.CID_NOMCID, "")) AS NOMCID, ';
      Result := Result + '  CAST(IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",' + strPreGer + 'CGCCPF,CLI_CGCCPF) AS UNSIGNED) AS CGCCPF, ';
      Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",' + strPreGer + 'CGCCON,CLI_C_G_C_) AS C_G_C_, ';
      Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%","", CLI_ENDNUM) AS ENDNUM, ';
      Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",' + strPreGer + 'CEPCON,CLI_C_E_P_) AS C_E_P_, ';
      Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",COALESCE(Z.CID_ESTADO, ""),COALESCE(C.CID_ESTADO, "")) AS ESTADO, ';
      Result := Result + '  IF(CLI_CGCCPF = 1, IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",' + strPreGer + 'IESCON,CLI_I_E_S_), ';
      Result := Result + '                     IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",' + strPreGer + 'R_GCON,CLI_NUMR_G)) AS NUMR_G, ';
      Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",' + strPreGer + 'TELCON,CLI_FONE01) AS FONE01, ';
      Result := Result + strPrefix + 'CODCND AS CODCND, ';
      Result := Result + '  CND_DESCRI       AS DESCND, ';
      Result := Result + '  IF(COALESCE(ETC_ENDENT, "") <> "", CONCAT(COALESCE(ETC_ENDENT, ""), " - ", COALESCE(ETC_BAIENT, ""), " - ", COALESCE(E.CID_NOMCID, "")), "") AS ENDENT, ';
      Result := Result + strPrefix + 'DTAENT AS DTAENT, ';
      Result := Result + ' IF(LEFT(' + strPrefix + 'CLAFIS, 1) >= 5, "S", "E") AS ENTSAI, ';
      Result := Result + strPrefix + 'NUMDOC AS NUMDOC, ';
      Result := Result + strPrefix + 'ESPDOC AS ESPDOC, ';
      Result := Result + '  CONCAT(' + strPrefix + 'NUMDOC, ' + strPrefix + 'ESPDOC, ' + strPrefix + 'CODEMP, ' + strPrefix + 'CODCLI) AS DOCQUEBRA, ';
      Result := Result + strPrefix + 'QTDITE AS QTDITE, ';
      Result := Result + '  UN.UNI_SIGUNI AS UNIDAD, ';
      Result := Result + strPrefix + 'DESCRI AS DESITE, ';
      Result := Result + ' IF((LEFT(' + strPrefix + 'CLAFIS, 1) < 5) AND (' + strPrefix + 'ESPDOC = "TR"), -1, 1) * ' + strPrefix + 'UNITAR AS UNITAR, ';
      Result := Result + ' IF((LEFT(' + strPrefix + 'CLAFIS, 1) < 5) AND (' + strPrefix + 'ESPDOC = "TR"), -1, 1) * ' + strPrefix + 'TOTITE AS TOTITE, ';
      Result := Result + strPrefix + 'DESESP AS DESESP, ';
      Result := Result + strPrefix + 'TOTFRE AS TOTFRE, ';
      Result := Result + IfThen(blnPedOrc, 'FGO_', 'GER_') + 'MEN001 AS MEN001, ';
      Result := Result + IfThen(blnPedOrc, 'FGO_', 'GER_') + 'MEN002 AS MEN002  ';
      Result := Result + ' FROM ';

      If blnPedOrc Then
      Begin
        Result := Result + ' FATDOR ';
        Result := Result + '        JOIN FATGOR ON (FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM) ';
        Result := Result + '   LEFT JOIN AUXGOR ON (FATGOR.AUTOINCREM = AUX_SEQGER) ';
        Result := Result + '   LEFT JOIN ENTCLI ON (AUXGOR.AUX_ENTGER = ENTCLI.AUTOINCREM) ';
      End
      Else
      Begin
        Result := Result + ' MOVDET ';
        Result := Result + '   JOIN MOVGER ON (MOVDET.DET_SEQGER = MOVGER.AUTOINCREM) ';
        Result := Result + '   LEFT JOIN AUXMOV ON (MOVGER.AUTOINCREM = AUX_SEQGER) ';
        Result := Result + '   LEFT JOIN ENTCLI ON (AUXMOV.AUX_ENTGER = ENTCLI.AUTOINCREM) ';
      End;

      Result := Result + '       JOIN CADCLI    ON (CLI_CODCLI   = ' + strPrefix + 'CODCLI) ';
      Result := Result + '  LEFT JOIN CADCID C  ON (C.CID_CODCID = CLI_CODCID) ';
      Result := Result + '  LEFT JOIN CADCID E  ON (E.CID_CODCID = ETC_CIDENT) ';
      Result := Result + '  LEFT JOIN CADCID Z  ON (Z.CID_CODCID = ' + strPreGer + 'CIDCON) ';
      Result := Result + '  LEFT JOIN CADOPE    ON (OPE_CODOPE   = ' + strPrefix + 'CODVEN) ';
      Result := Result + '  LEFT JOIN CADCND    ON (CND_CODIGO   = ' + strPrefix + 'CODCND) ';
      Result := Result + '  LEFT JOIN CADUNI UN ON(UN.UNI_CODUNI = ' + strPrefix + 'UNIDAD) ';

      Result := Result + ' WHERE ';
      Result := Result + strPrefix + 'NUMDOC = :NUMDOC AND ';
      Result := Result + strPrefix + 'ESPDOC = :ESPDOC AND ';
      Result := Result + strPrefix + 'CODEMP = :CODEMP AND ';
      Result := Result + strPrefix + 'CODCLI = :CODCLI     ';
    End;
begin
  Try
    pCriarFormularios(TfrmImpEspCalub, frmImpEspCalub);

    With frmImpEspCalub Do
    Begin
      cdsRelatorio := TZClient.Create(frmImpEspCalub, fGetSql(strEspDoc));
      cdsRelatorio.qryQuery.ParamByName('NUMDOC').AsString := strNumDoc;
      cdsRelatorio.qryQuery.ParamByName('ESPDOC').AsString := strEspDoc;
      cdsRelatorio.qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
      cdsRelatorio.qryQuery.ParamByName('CODCLI').AsString := strCodCli;
      cdsRelatorio.fAbreClient(True, 'TfrmImpEspCalub.pImprime');

      If cdsRelatorio.IsEmpty Then
        Exit;

      frxCalub.LoadFromFile(ExtractFilePath(Application.ExeName) + 'frxCalub.fr3');
      frxCalub.PrintOptions.PrintMode := pmSplit;

      frxRelatorio.DataSet := cdsRelatorio;

      frxCalub.AddFunction('function fFormataCEP(strCEP: String): String;');
      frxCalub.AddFunction('function fFormataFone(strFone: String): String;');
      frxCalub.AddFunction('function fFormataCpfCgc(strCpfCgc: String): String;');

      qryCfgRel := fCriaQuery;
      pCarregaConfImpr(qryCfgRel, 'frmFatVendas_' + strEspDoc);

      If intQtdImp > 0 Then
        fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);

      If (intQtdImp > 0) And frxCalub.PrepareReport Then
      Begin
        If fEmptyStr(strNomFil) Then
          pPrintReport('frmFatVendas_' + strEspDoc, 'Impressão específica ('+ strNumDoc + '-' + strEspDoc + ')', strNomFil, frxCalub)
        Else
        Begin
          For intPosicao := 1 To intQtdImp Do
          Begin
            frxCalub.PrintOptions.ShowDialog := False;
            frxCalub.PrintOptions.Printer    := AnsiReplaceText(strNomFil,'\\' + fRetNomeRede + '\','');
            pPrintReport('frmFatVendas_' + strEspDoc, 'Impressão específica ('+ strNumDoc + '-' + strEspDoc + ')', strNomFil, frxCalub);
          End;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryCfgRel);
    FreeAndNil(frmImpEspCalub);
  End;
end;

end.
