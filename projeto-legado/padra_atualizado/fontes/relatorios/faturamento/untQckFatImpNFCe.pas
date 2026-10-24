unit untQckFatImpNFCe;

interface

uses
  Windows, SysUtils, Classes, frxClass, frxDBSet, Uni, StrUtils, Graphics,
  untFuncFatTypes, MaskUtils, Forms, Variants, frxBarcode, Data.DB, Winapi.ShellAPI,
  untFuncoesSimples, untCarnePagto, Vcl.Dialogs, Printers, frxExportPDF, System.TypInfo;

type
  TfrmQckFatImpNFCe = class(TForm)
    frxDbNFce: TfrxDBDataset;
    frxNFCeEntrega: TfrxReport;
    frxTEF: TfrxReport;
    frxNFCe: TfrxReport;
    frxSATCFe: TfrxReport;
    frxCancSATCFe: TfrxReport;
    frxCanc: TfrxDBDataset;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxCarneRecibo: TfrxReport;
    frxDataSetCarnePgto: TfrxUserDataSet;
    frxContrato: TfrxReport;
    frxSATCFeMod2: TfrxReport;
    frxCartaoVinculadoJ: TfrxReport;
    frxDBCartaoVinculado: TfrxDBDataset;
    frxCartaoVinculadoM: TfrxReport;
    frxExpPDF: TfrxPDFExport;
    frxNFCeReduzido: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    function frxSATCFeUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure frxDataSetCarnePgtoCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frxDataSetCarnePgtoFirst(Sender: TObject);
    procedure frxDataSetCarnePgtoGetValue(const VarName: string;
      var Value: Variant);
    procedure frxDataSetCarnePgtoNext(Sender: TObject);
  private
    { Private declarations }
    intIndiceDuplic: Integer;
    FDuplic: TArrDuplicatas;

    FDupRep: TArrDuplicatas;

    blnExibeDtaCad: Boolean;

    FBarCon: String;

    blnImpMarcas: Boolean;
    blnImpCodFab: Boolean;

    function fImpressoraKey(): String;

    procedure pCarregaModalidadesPagamento(fltTotGer: Double; strNumDoc, strEspDoc, strCodEmp, strCodCli,
      strSerie: String; Var strModalidades, strValores: String);
    procedure pCarregaDados(qryTmp: TUniQuery; blnSatComplementar: Boolean=False);

    procedure pCarregarFuncoesDllDaruma;
    function fGetInfComplementar(qryItens: TUniQuery; strQuebra: String; strDadCli: String = ''): String;
    function fConsumidorIdentificado(qryItens: TUniQuery): Boolean;

    procedure pInicializarDaruma;
    function fNumeroDoItem: String;
    function fArredondaUnit(strCampo: String): String;
    function fiImprimirTexto_DUAL_DarumaFramework(strTexto: AnsiString; intTam: Integer): Integer;

    function fRetTextoMarcaEOuCodFab(qry: TUniQuery): String;
    function fCadEmpNomeEmpresa: String;
    function fDarumaNegrito(strConteudo: String; strCmdAdicional: String=''): String;
    function fDarumaCentral(strConteudo: String; strCmdAdicional: String=''): String;
    function fDarumaRiscarL(strCaracter: String='-'; strCmdAdicional: String=''): String;
    function fDarumaQrCode_(strConteudoQrCd: String): String;
    function fDarumaTModulo(intTamanhoModul: Integer): String;
    function fDarumaGuilhot: String;
    function fDarumaAguarda: String;
    function fDarumaSaltar1: String;
    function fDarumaSaltarN(intNumeroLinhas: Integer): String;
    function fGetLayoutImpressaoEspelhoCartaoVinculado(AEspecieDocumento, AEmpresaDocumento: string) : TfrxReport;
    function fImpPorTerminalTef : Boolean;
    procedure pSalvarDanfe(ADanfe: TfrxReport; AChaveAcesso: String);
    function fRetornaSqlCodIte() : String;
  public
    { Public declarations }
    procedure pImprimirDanfeNFCeReduzido(strNumDoc,
                                         strEspDoc,
                                         strCodEmp,
                                         strCodCli,
                                         strSerie,
                                         strTip_FC: String;
                                         strImpressora: String='';
                                         blnGerarPDF: Boolean = False;
                                         strAcesso: string = '';
                                         blnMostrarPreviewQuandoPDF : Boolean = True;
                                         strPath : String = '');

    procedure pImprimirDanfeNFCe(strNumDoc,
                                 strEspDoc,
                                 strCodEmp,
                                 strCodCli,
                                 strSerie,
                                 strTip_FC: String;
                                 strImpressora: String='';
                                 blnGerarPDF: Boolean = False;
                                 strAcesso: string = '';
                                 blnMostrarPreviewQuandoPDF : Boolean = True;
                                 strPath : String = '';
                                 intQtdVias : Integer = -1;
                                 blnGerandoParaDisparoDeGatilho: Boolean = False);

    procedure pImprimirDanfeNFCeDaruma(strNumDoc, strEspDoc, strCodEmp, strCodCli,
      strSerie, strTip_FC: String; strImpressora: String='');
    procedure pImprimirDadosEntrega(dadosCupom: TDadosImpressaoVenda);
    procedure pImprimirDadosEntregaDaruma(dadosCupom: TDadosImpressaoVenda);
    procedure pImprimirTef(strTextoTef, strLinhasPicote: String; const AblnQtdViasExterna: Boolean = False);
    function fTrataTextoMultiplus(strTextoTef: String): TStringList;
    procedure pImprimirTefDaruma(strTextoTef: String);

    procedure pImprimirCancelamentoSAT(strNumDoc, strEspDoc, strCodEmp, strCodCli,
      strSerie, strTip_FC: String; strImpressora: String='');

    procedure pImprimirDanfeSAT(strNumDoc, strEspDoc, strCodEmp, strCodCli,
      strSerie, strTip_FC: String; strImpressora: String=''; blnSatComplementar:Boolean=False);

    procedure pImprimirCarnePagto(strBarCon: String; fltLimiteCredito: Double;
      strCodCli, strNomCli, strNomVen, dtaDtaCom: String; FDuplic: TArrDuplicatas);
    procedure pImprimirContrato(strBarCon: String; opcOpcCon: TOpcaoContrato;
      FDuplic, FDupRep: TArrDuplicatas; strCodCli, strNomCli, strNomVen: String;
      fltTotDup, fltTotRec: Double; strMenPed,dtaDtaCom: String);
    function fImprimirEspelhoCartaoVinculado(ANumeroDocumento, AEspecieDocumento, AEmpresaDocumento,
      AFilaImpressao, ATipoImpressao : string; AGeraPDF : boolean; var ANomeDoArquivo, AMensagem : string) : boolean;
  end;

var
  frmQckFatImpNFCe: TfrmQckFatImpNFCe;
  HandleDarumaFramework: Cardinal = 0;

  iImprimirTexto_DUAL_DarumaFramework: function(stTexto: AnsiString; iTam: Integer): Integer; StdCall;
  rStatusImpressora_DUAL_DarumaFramework: function: Integer; StdCall;
  eBuscarPortaVelocidade_DUAL_DarumaFramework: function: Integer; StdCall;


  procedure pAjustaBitmap(bitmap: TBitmap; intLargura, intAltura: Integer);

  function fRetornaChaveAcesso(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strTip_FC: String): String;
  procedure pImprimirNFCe(strNumDoc,
                          strEspDoc,
                          strCodEmp,
                          strCodCli,
                          strSerie,
                          strTip_FC: String;
                          strImpressora: String='';
                          blnSatComplementar: Boolean=False;
                          blnReimpressao: Boolean=False;
                          blnGerarPDF: Boolean = False;
                          intQtdVias: Integer = -1);
  procedure pImprimirDadosEntregaNFCe(dadosCupom: TDadosImpressaoVenda);
  procedure pImprimirTef(strTextoTef, strLinhasPicote: String; const AblnQtdViasExterna: Boolean = False);
  procedure pImprimirCancelamentoSAT(strNumDoc, strEspDoc, strCodEmp, strCodCli,
      strSerie, strTip_FC: String; strImpressora: String='');

  procedure pImprimirCarnePagto(strBarCon: String; fltLimiteCredito: Double;
    strCodCli, strNomCli, strNomVen, dtaDtaCom: String; FDuplic: TArrDuplicatas);
  procedure pImprimirContrato(strBarCon: String; opcOpcCon: TOpcaoContrato;
    FDuplic, FDupRep: TArrDuplicatas; strCodCli, strNomCli, strNomVen: String;
    fltTotDup, fltTotRec: Double; strMenPed, dtaDtaCom: String);

implementation

uses untFuncoesGenerica, frxDelphiZXingQRCode, untFuncoes, untConstantes,
  untDuplicatas, untCfgRel, frxDMPClass,  untQRCodeUtils, untTypesSistema,
  untLibNfe;

{$R *.dfm}

{ TfrmQckFatImpNFCe }

procedure pVisualizarPDFGerado(strArquivo: String);
Var
  PDir: Pchar;
begin
  GetMem(Pdir, 256);
  Try
    StrPCopy(PDir, strArquivo);
    ShellExecute(0, nil, PChar(strArquivo), nil, PDir, SW_NORMAL);
  Finally
    FreeMem(PDir, 256);
  End;
end;

procedure TfrmQckFatImpNFCe.DataModuleCreate(Sender: TObject);
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

  frxSATCFe.AddFunction('function fNumeroDoItem: String');
  frxSATCFe.AddFunction('function fArredondaUnit(strCampo: String): String');

  frxSATCFeMod2.AddFunction('function fNumeroDoItem: String');
  frxSATCFeMod2.AddFunction('function fArredondaUnit(strCampo: String): String');

  blnImpMarcas := fCfgSis('NFEMAR', varBoolean);
  blnImpCodFab := fCfgSis('NFEFAB', varBoolean);
end;

function SQL_C_G_C_: String;
begin
  If fCfgSis('NFPCLI', VarBoolean) Then
    Result := 'IF(IFNULL(AUX_NOTPAU, "") = "N", "", CLI_C_G_C_)'
  ELse
    Result := 'CLI_C_G_C_';
end;

procedure TfrmQckFatImpNFCe.pCarregaDados(qryTmp: TUniQuery; blnSatComplementar: Boolean=False);
  Const
    CLIENTE_CONSUMIDOR = 'CLI_NOMCLI LIKE "%CONSUMIDOR%" OR ' +
                         'CLI_NOMCLI LIKE "%BALCAO%"     OR ' +
                         'CLI_NOMCLI LIKE "%BALCÃO%"     OR ' +
                         'CLI_NOMCLI LIKE "%SEGURADORA%"    ' ;

    SQL_MOVCDB_CODBAR  = '(SELECT GROUP_CONCAT(DISTINCT CDB_CODBAR) AS CDB_CODBAR ' +
                         ' FROM   MOVCDB ' +
                         ' WHERE  CDB_SEQDET = MOVDET.AUTOINCREM ' +
                         ' GROUP BY CDB_SEQDET) ';
  Var
    strSQL: String;
    strOrdIte: String;
    blnCodBar: Boolean;
    intModSAT: Integer;
    strDesIteTemp: String;
begin
  If blnSatComplementar Then
  Begin
    qryTmp.SQL.Add('SELECT ');
    qryTmp.SQL.Add('  GER_DOCORI AS DOCORI, ');
    qryTmp.SQL.Add('  GER_ESPORI AS ESPORI, ');
    qryTmp.SQL.Add('  GER_EMPORI AS EMPORI, ');
    qryTmp.SQL.Add('  GER_SERORI AS SERORI, ');
    qryTmp.SQL.Add('  GER_ACEORI AS ACEORI, ');
    qryTmp.SQL.Add('  "0000" AS CODITE, ');
    qryTmp.SQL.Add('  "COMPLEMENTO DE ICMS" AS DESITE, ');
    qryTmp.SQL.Add('  "COMPLEMENTO DE ICMS" AS DESORI, ');
    qryTmp.SQL.Add('  0.00 AS QTDITE, ');
    qryTmp.SQL.Add('  0.00 AS TOTITE, ');
    qryTmp.SQL.Add('  0.00 AS DET_IMPPAG, ');
    qryTmp.SQL.Add('  0.00 AS UNITAR, ');
    qryTmp.SQL.Add('  0.00 AS UNIDIG, ');
    qryTmp.SQL.Add('  0.00 AS UNIORI, ');
    qryTmp.SQL.Add('  "UN" AS UNIDAD, ');
    qryTmp.SQL.Add('  "" AS FORITE, ');
    qryTmp.SQL.Add('  "" AS NUMLOT, ');
    qryTmp.SQL.Add('  "" AS LOCFIS, ');
    qryTmp.SQL.Add('  0.00 AS TOTITE, ');
    qryTmp.SQL.Add('  0.00 AS DET_DESESP, ');
    qryTmp.SQL.Add('  FIS_VLRIC1 AS DET_TOTLIQ, ');
    qryTmp.SQL.Add('  0.00 AS DESESP, ');
    qryTmp.SQL.Add('  FIS_BASIC1 AS TOTPRO, ');
    qryTmp.SQL.Add('  FIS_BASIC1 AS VLRCON, ');
    qryTmp.SQL.Add('  FIS_NUMDOC AS NUMDOC, ');
    qryTmp.SQL.Add('  FIS_SERIE_ AS SERIE_, ');
    qryTmp.SQL.Add('  FIS_ACESSO AS ACESSO, ');
    qryTmp.SQL.Add('  LEFT(FIS_ACESSO, 22) AS ACESSO1, ');
    qryTmp.SQL.Add('  RIGHT(FIS_ACESSO, 22) AS ACESSO2, ');
    qryTmp.SQL.Add('  FIS_NUMSER AS NUMSER, ');
    qryTmp.SQL.Add('  FIS_NUMCOO AS NUMCOO, ');
    qryTmp.SQL.Add('  FIS_ACESSO AS QRCODE, ');
    qryTmp.SQL.Add('  "" AS PROTOC, ');
    qryTmp.SQL.Add('  CURRENT_TIMESTAMP AS DPROTO, ');
    qryTmp.SQL.Add('  "" AS OBSFIS, ');
    qryTmp.SQL.Add('  "" AS PRTMSG, ');
    qryTmp.SQL.Add('  FIS_DTAENT AS DTAENT, ');
    qryTmp.SQL.Add('  CURRENT_TIME AS HORENT, ');
    qryTmp.SQL.Add('  EMP_NOMFAN AS NOMEMP, ');
    qryTmp.SQL.Add('  EMP_C_G_C_ AS C_G_C_, ');
    qryTmp.SQL.Add('  EMP_I_E_S_ AS I_E_S_, ');
    qryTmp.SQL.Add('  EMP_INSMUN AS INSMUN, ');
    qryTmp.SQL.Add('  CONCAT(EMP_ENDERE, ", ", EMP_ENDNUM, ", ", EMP_BAIRRO, " - " , CE.CID_NOMCID, "/", CE.CID_ESTADO) AS ENDEMP, ');
    qryTmp.SQL.Add('  CE.CID_ESTADO AS ESTEMP, ');
    qryTmp.SQL.Add('  EMP_C_E_P_ AS CEPEMP, ');
    qryTmp.SQL.Add('  EMP_FONE01 AS TELEMP, ');
    qryTmp.SQL.Add('  EMP_FONE02 AS TELEM2, ');
    qryTmp.SQL.Add('  EMP_FONDA1 AS TELDA1, ');
    qryTmp.SQL.Add('  0.00 AS IMPPAG, ');
    qryTmp.SQL.Add('  "" AS MEN001, ');
    qryTmp.SQL.Add('  "" AS MEN002, ');
    qryTmp.SQL.Add('  "" AS MEN003, ');
    qryTmp.SQL.Add('  "" AS MEN004, ');
    qryTmp.SQL.Add('  "" AS MEN005, ');
    qryTmp.SQL.Add('  FIS_FORCLI AS CODCLI, ');
    qryTmp.SQL.Add('  CLI_NOMCLI AS NOMCLI, ');
    qryTmp.SQL.Add('  "" AS CODVEN, ');
    qryTmp.SQL.Add('  "" AS CODDIG, ');
    qryTmp.SQL.Add('  "" AS NOMVEN, ');
    qryTmp.SQL.Add('  "" AS NOMDIG, ');
    qryTmp.SQL.Add('  CLI_C_G_C_ AS CGCCON, ');
    qryTmp.SQL.Add('  CLI_NOMCLI AS NOMCON, ');
    qryTmp.SQL.Add('  CLI_NOMCLI AS NOMFAN, ');
    qryTmp.SQL.Add('  CLI_BAIRRO AS BAICON, ');
    qryTmp.SQL.Add('  CLI_C_E_P_ AS CEPCON, ');
    qryTmp.SQL.Add('  CLI_FONE01 AS TELCON, ');
    qryTmp.SQL.Add('  CLI_CELULA AS CELCON, ');
    qryTmp.SQL.Add('  CLI_I_E_S_ AS IESCON, ');
    qryTmp.SQL.Add('  CLI_ENDERE AS ENDERE, ');
    qryTmp.SQL.Add('  CLI_ENDNUM AS ENDNUM, ');
    qryTmp.SQL.Add('  CLI_ENDCOM AS ENDCOM, ');
    qryTmp.SQL.Add('  CC.CID_ESTADO AS ESTCON, ');
    qryTmp.SQL.Add('  CC.CID_NOMCID AS CIDCON, ');

    qryTmp.SQL.Add('  "" AS BAIENT, ');
    qryTmp.SQL.Add('  "" AS CEPENT, ');
    qryTmp.SQL.Add('  "" AS TELENT, ');
    qryTmp.SQL.Add('  "" AS ENDENT, ');
    qryTmp.SQL.Add('  "" AS CIDENT, ');
    qryTmp.SQL.Add('  "" AS SITUAC, ');
    qryTmp.SQL.Add('  "" AS REFENT, ');

    qryTmp.SQL.Add('  0.00 AS TROCO_ , ');
    qryTmp.SQL.Add('  "" AS ESTIMP , ');
    qryTmp.SQL.Add('  "" AS MUNIMP , ');
    qryTmp.SQL.Add('  "" AS FEDIMP , ');
    qryTmp.SQL.Add('  "" AS DESMAR , ');
    qryTmp.SQL.Add('  "" AS CODFAB , ');
    qryTmp.SQL.Add('  0.00 AS DESACE, ');
    qryTmp.SQL.Add('  0.00 AS TOTFRE, ');
    qryTmp.SQL.Add('  0.00 AS TOTRET, ');
    qryTmp.SQL.Add('  0.00 AS TOTIPI, ');
    qryTmp.SQL.Add('  "" AS CODDIV, ');
    qryTmp.SQL.Add('  "" AS NOMDIV, ');
    qryTmp.SQL.Add('  "" AS PESBRU, ');
    qryTmp.SQL.Add('  "" AS NUMGUI, ');

    qryTmp.SQL.Add('  "" AS CONPAG, ');
    qryTmp.SQL.Add('  "" AS CODCND, ');
    qryTmp.SQL.Add('  "" AS DESCND, ');

    qryTmp.SQL.Add('  "" AS ENTRET, ');

    qryTmp.SQL.Add('  "" AS OPEEXP, ');
    qryTmp.SQL.Add('  "" AS NOMEXP, ');

    qryTmp.SQL.Add('  "" AS OPESEP, ');
    qryTmp.SQL.Add('  "" AS NOMSEP,  ');
    qryTmp.SQL.Add('  "" AS NUMPED,  ');
    qryTmp.SQL.Add('  "" AS QTDPEC, ');
    qryTmp.SQL.Add('  "" AS COMPEC, ');
    qryTmp.SQL.Add('  "" AS LARPEC, ');
    qryTmp.SQL.Add('  "" AS ESPPEC  ');
    qryTmp.SQL.Add('FROM CADFIS ');
    qryTmp.SQL.Add('  JOIN CADEMP ON EMP_CODEMP = FIS_CODEMP ');
    qryTmp.SQL.Add('  JOIN CADCID CE ON CE.CID_CODCID = EMP_CODCID ');
    qryTmp.SQL.Add('  LEFT JOIN CADCLI    ON    CLI_CODCLI = FIS_FORCLI ');
    qryTmp.SQL.Add('  LEFT JOIN CADCID CC ON CC.CID_CODCID = CLI_CODCID ');
    qryTmp.SQL.Add('  LEFT JOIN NOTCOM ON NOTCOM.GER_SEQGER = CADFIS.AUTOINCREM ');
    qryTmp.SQL.Add('WHERE ');
    qryTmp.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
    qryTmp.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
    qryTmp.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
    qryTmp.SQL.Add('  FIS_SERIE_ = :SERIE_ AND ');
    qryTmp.SQL.Add('  FIS_FORCLI = :CODCLI AND ');
    qryTmp.SQL.Add('  FIS_TIP_FC = :TIP_FC ');
  End
  Else
  Begin
    blnCodBar := fCfgSis('CBCODE', VarBoolean);
    intModSAT := fCfgSis('MODSAT', VarInteger);

    qryTmp.SQL.Add('SELECT ');
    qryTmp.SQL.Add('  '+fRetornaSqlCodIte+' AS CODITE, ');

    If blnCodBar Then
    Begin
      strDesIteTemp := '  CONCAT(DET_DESCRI, ' +
                       '    IF(IFNULL(' + SQL_MOVCDB_CODBAR + ',"") = "", ' +
                       '       IF(IFNULL(BAR_CODBAR,"") = "", "", CONCAT(" - Cod.Barra: ",BAR_CODBAR)), ' +
                       '       CONCAT(" - Cod.Barra: ",' + SQL_MOVCDB_CODBAR + ') ' +
                       '      ))';

      if (fCfgSis('NFCEMF') = 'S') then
        strDesIteTemp := '  IF(IFNULL(ITE_MENFIS, "") = "", ' + strDesIteTemp + ', CONCAT(CONCAT(' + strDesIteTemp + ', " - "), ITE_MENFIS))';

      if (fCfgSis('NFCLOT') = 'S') then
        strDesIteTemp := '  IF(IFNULL(DET_NUMLOT, "") = "", ' + strDesIteTemp + ', CONCAT(CONCAT(' + strDesIteTemp + ', " - LOTE: "), DET_NUMLOT))';

      strDesIteTemp := ' IF(MD.DET_APAREL = "S", CONCAT('+ strDesIteTemp +', " - APARELHADA"), '+ strDesIteTemp +')';

      qryTmp.SQL.Add(strDesIteTemp + ' AS DESITE, ');
    End
    Else
    begin
      strDesIteTemp := ' DET_DESCRI ';

      if (fCfgSis('NFCEMF') = 'S') then
        strDesIteTemp := '  IF(IFNULL(ITE_MENFIS, "") = "", ' + strDesIteTemp + ', CONCAT(CONCAT(' + strDesIteTemp + ', " - "), ITE_MENFIS))';

      if (fCfgSis('NFCLOT') = 'S') then
        strDesIteTemp := '  IF(IFNULL(DET_NUMLOT, "") = "", ' + strDesIteTemp + ', CONCAT(CONCAT(' + strDesIteTemp + ', " - LOTE: "), DET_NUMLOT))';

      strDesIteTemp := ' IF(MD.DET_APAREL = "S", CONCAT('+ strDesIteTemp +', " - APARELHADA"), '+ strDesIteTemp +')';

      qryTmp.SQL.Add(strDesIteTemp + ' AS DESITE, ');
    end;

    qryTmp.SQL.Add('  UNI_SIGUNI AS UNIDAD, ');
    qryTmp.SQL.Add('  DET_FORITE AS FORITE, ');

    If fTabelaExiste('CADLOT', True) Then
      qryTmp.SQL.Add('  IF(IFNULL(DET_NUMLOT, "") = "", ITE_LOCFIS, LOT_LOCFIS) AS LOCFIS, ')
    Else
      qryTmp.SQL.Add('  ITE_LOCFIS AS LOCFIS, ');

    qryTmp.SQL.Add('  UNI_PESLIT AS PESLIT, ');

    If (blnCodBar) Or (intModSAT = 2) Then
      qryTmp.SQL.Add('  MIN(MOVDET.AUTOINCREM) AS AUTINC, ')
    Else
      qryTmp.SQL.Add('  MOVDET.AUTOINCREM AS AUTINC, ');

    qryTmp.SQL.Add('  DET_DESCRI AS DESORI, ');

    If (blnCodBar) Or (intModSAT = 2) Then
    Begin
      qryTmp.SQL.Add('  SUM(DET_QTDITE) AS QTDITE, ');
      qryTmp.SQL.Add('  SUM(DET_QTDITE * DET_UNITAR) AS TOTITE, ');
      qryTmp.SQL.Add('  SUM(DET_IMPPAG) AS DET_IMPPAG, ');
    End
    Else
    Begin
      qryTmp.SQL.Add('  DET_QTDITE AS QTDITE, ');
      qryTmp.SQL.Add('  DET_TOTITE AS TOTITE, ');
      qryTmp.SQL.Add('  DET_IMPPAG, ');
    End;

    qryTmp.SQL.Add('  DET_UNITAR AS UNITAR, ');
    qryTmp.SQL.Add('  DET_UNIDIG AS UNIDIG, ');
    qryTmp.SQL.Add('  DET_UNIORI AS UNIORI, ');

    qryTmp.SQL.Add('  DET_NUMLOT AS NUMLOT, ');

    qryTmp.SQL.Add('  DET_TOTITE AS TOTITE, ');
    qryTmp.SQL.Add('  DET_DESESP, ');
    qryTmp.SQL.Add('  DET_TOTITE-DET_DESESP AS DET_TOTLIQ, ');
    qryTmp.SQL.Add('  GER_DESESP AS DESESP, ');
    qryTmp.SQL.Add('  GER_TOTPRO AS TOTPRO, ');
    qryTmp.SQL.Add('  GER_VLRCON AS VLRCON, ');
    qryTmp.SQL.Add('  DET_NUMDOC AS NUMDOC, ');
    qryTmp.SQL.Add('  DET_SERIE_ AS SERIE_, ');
    qryTmp.SQL.Add('  FIS_ACESSO AS ACESSO, ');
    qryTmp.SQL.Add('  LEFT(FIS_ACESSO, 22) AS ACESSO1, ');
    qryTmp.SQL.Add('  RIGHT(FIS_ACESSO, 22) AS ACESSO2, ');
    qryTmp.SQL.Add('  FIS_NUMSER AS NUMSER, ');
    qryTmp.SQL.Add('  FIS_NUMCOO AS NUMCOO, ');
    qryTmp.SQL.Add('  MOV_QRCODE AS QRCODE, ');
    qryTmp.SQL.Add('  MOV_PROTOC AS PROTOC, ');
    qryTmp.SQL.Add('  MOV_DPROTO AS DPROTO, ');
    qryTmp.SQL.Add('  MOV_OBSFIS AS OBSFIS, ');
    qryTmp.SQL.Add('  MOV_PRTMSG AS PRTMSG, ');
    qryTmp.SQL.Add('  DET_DTAENT AS DTAENT, ');
    qryTmp.SQL.Add('  DET_HORENT AS HORENT, ');

    If (fCfgSis('RSNFNC') = 'F') Then
      qryTmp.SQL.Add('  EMP_NOMFAN AS NOMEMP, ')
    Else
      qryTmp.SQL.Add('  EMP_NOMEMP AS NOMEMP, ');

    qryTmp.SQL.Add('  EMP_C_G_C_ AS C_G_C_, ');
    qryTmp.SQL.Add('  EMP_I_E_S_ AS I_E_S_, ');
    qryTmp.SQL.Add('  EMP_INSMUN AS INSMUN, ');
    qryTmp.SQL.Add('  CONCAT(EMP_ENDERE, ", ", EMP_ENDNUM, ", ", EMP_BAIRRO, " - " , CE.CID_NOMCID, "/", CE.CID_ESTADO) AS ENDEMP, ');
    qryTmp.SQL.Add('  CE.CID_ESTADO AS ESTEMP, ');
    qryTmp.SQL.Add('  EMP_C_E_P_ AS CEPEMP, ');
    qryTmp.SQL.Add('  EMP_FONE01 AS TELEMP, ');
    qryTmp.SQL.Add('  EMP_FONE02 AS TELEM2, ');
    qryTmp.SQL.Add('  EMP_FONDA1 AS TELDA1, ');
    qryTmp.SQL.Add('  AUX_IMPPAG AS IMPPAG, ');
    qryTmp.SQL.Add('  GER_MEN001 AS MEN001, ');
    qryTmp.SQL.Add('  GER_MEN002 AS MEN002, ');
    qryTmp.SQL.Add('  GER_MEN003 AS MEN003, ');
    qryTmp.SQL.Add('  GER_MEN004 AS MEN004, ');
    qryTmp.SQL.Add('  GER_MEN005 AS MEN005, ');
    qryTmp.SQL.Add('  GER_CODCLI AS CODCLI, ');
    qryTmp.SQL.Add('  CLI_NOMCLI AS NOMCLI, ');
    qryTmp.SQL.Add('  GER_CODVEN AS CODVEN, ');
    qryTmp.SQL.Add('  DET_PROMOC AS PROMOC, ');
    qryTmp.SQL.Add('  IFNULL(GER_CODDIG, "") AS CODDIG, ');

    If intModSAT = 2 Then
    Begin
      qryTmp.SQL.Add(' IF(IFNULL('+ SQL_MOVCDB_CODBAR +',"") = "", ');
      qryTmp.SQL.Add('   IF(IFNULL(BAR_CODBAR,"") = "", MOVDET.DET_CODITE, BAR_CODBAR), ');
      qryTmp.SQL.Add( SQL_MOVCDB_CODBAR + '  ) AS CODBAR, ');
    End;

    If fCfgSis('AUTCEN', varBoolean) Then
    Begin
      qryTmp.SQL.Add(' (SELECT ');
      qryTmp.SQL.Add('    GROUP_CONCAT(DISTINCT  " ", CONCAT(DET_CODVEN, "-", OPE_NOMOPE)) AS NOME ');
      qryTmp.SQL.Add('  FROM   ');
      qryTmp.SQL.Add('    MOVDET D INNER JOIN CADOPE O ON D.DET_CODVEN = O.OPE_CODOPE ');
      qryTmp.SQL.Add('  WHERE  ');
      qryTmp.SQL.Add('    D.DET_SEQGER = MOVGER.AUTOINCREM) AS NOMVEN,     ');
    End
    Else
      qryTmp.SQL.Add('  VE.OPE_NOMOPE AS NOMVEN, ');

    If fCfgSis('AUTCEN', varBoolean) Then
    Begin
      qryTmp.SQL.Add(' (SELECT ');
      qryTmp.SQL.Add('    GROUP_CONCAT(DISTINCT  " ", CONCAT(DET_CODDIG, "-", OPE_NOMOPE)) AS NOME ');
      qryTmp.SQL.Add('  FROM   ');
      qryTmp.SQL.Add('    MOVDET D INNER JOIN CADOPE O ON D.DET_CODDIG = O.OPE_CODOPE ');
      qryTmp.SQL.Add('  WHERE  ');
      qryTmp.SQL.Add('    D.DET_SEQGER = MOVGER.AUTOINCREM) AS NOMDIG,     ');
    End
    Else
      qryTmp.SQL.Add('  DI.OPE_NOMOPE AS NOMDIG, ');

    qryTmp.SQL.Add('  IF(' + CLIENTE_CONSUMIDOR + ', GER_CGCCON, ' + SQL_C_G_C_ + ') AS CGCCON, ');
    qryTmp.SQL.Add('  IF(' + CLIENTE_CONSUMIDOR + ', GER_NOMCON, CLI_NOMCLI) AS NOMCON, ');
    qryTmp.SQL.Add('  IF(' + CLIENTE_CONSUMIDOR + ', GER_NOMCON, CLI_NOMCLI) AS NOMFAN, ');
    qryTmp.SQL.Add('  IF(' + CLIENTE_CONSUMIDOR + ', GER_BAICON, CLI_BAIRRO) AS BAICON, ');
    qryTmp.SQL.Add('  IF(' + CLIENTE_CONSUMIDOR + ', GER_CEPCON, CLI_C_E_P_) AS CEPCON, ');
    qryTmp.SQL.Add('  IF(' + CLIENTE_CONSUMIDOR + ', GER_TELCON, CLI_FONE01) AS TELCON, ');
    qryTmp.SQL.Add('  IF(' + CLIENTE_CONSUMIDOR + ', AUX_CELCON, CLI_CELULA) AS CELCON, ');
    qryTmp.SQL.Add('  IF(' + CLIENTE_CONSUMIDOR + ', GER_IESCON, CLI_I_E_S_) AS IESCON, ');
    qryTmp.SQL.Add('  IF(' + CLIENTE_CONSUMIDOR + ', GER_ENDCON, CLI_ENDERE) AS ENDERE, ');
    qryTmp.SQL.Add('  IF(' + CLIENTE_CONSUMIDOR + ', "",         CLI_ENDNUM) AS ENDNUM, ');
    qryTmp.SQL.Add('  IF(' + CLIENTE_CONSUMIDOR + ', "",         CLI_ENDCOM) AS ENDCOM, ');

    qryTmp.SQL.Add('  CC.CID_ESTADO AS ESTCON, ');
    qryTmp.SQL.Add('  CC.CID_NOMCID AS CIDCON, ');

    qryTmp.SQL.Add('  EE.ETC_BAIENT AS BAIENT, ');
    qryTmp.SQL.Add('  EE.ETC_CEPENT AS CEPENT, ');
    qryTmp.SQL.Add('  EE.ETC_TELENT AS TELENT, ');
    qryTmp.SQL.Add('  EE.ETC_ENDENT AS ENDENT, ');
    qryTmp.SQL.Add('  CE2.CID_NOMCID AS CIDENT, ');
    qryTmp.SQL.Add('  EE.ETC_SITUAC AS SITUAC, ');
    qryTmp.SQL.Add('  EE.ETC_REFENT AS REFENT, ');

    qryTmp.SQL.Add('  AUX_TROCO_ AS TROCO_ , ');
    qryTmp.SQL.Add('  AUX_ESTIMP AS ESTIMP , ');
    qryTmp.SQL.Add('  AUX_MUNIMP AS MUNIMP , ');
    qryTmp.SQL.Add('  AUX_FEDIMP AS FEDIMP , ');
    qryTmp.SQL.Add('  MAR_DESMAR AS DESMAR , ');
    qryTmp.SQL.Add('  ITE_CODFAB AS CODFAB , ');

    qryTmp.SQL.Add('  GER_DESACE AS DESACE,   ');
    qryTmp.SQL.Add('  GER_TOTFRE AS TOTFRE,   ');
    qryTmp.SQL.Add('  GER_TOTRET AS TOTRET,   ');
    qryTmp.SQL.Add('  GER_TOTIPI AS TOTIPI,   ');

    qryTmp.SQL.Add('  DET_CODDIV AS CODDIV,   ');
    qryTmp.SQL.Add('  DIV_NOMDIV AS NOMDIV,   ');

    qryTmp.SQL.Add('  GER_PESBRU AS PESBRU,   ');

    qryTmp.SQL.Add('  AUX_NUMGUI AS NUMGUI,   ');

    qryTmp.SQL.Add('  GER_CONPAG AS CONPAG, ');
    qryTmp.SQL.Add('  GER_CODCND AS CODCND, ');
    qryTmp.SQL.Add('  CND_DESCRI AS DESCND, ');

    qryTmp.SQL.Add('  IF(MOVGER.GER_ENTFUT = "S", "F", IF(MOVGER.GER_ENTFAT = "S", "E", "R")) AS ENTRET, ');

    qryTmp.SQL.Add('  GER_OPEEXP AS OPEEXP, ');
    qryTmp.SQL.Add('  OE.OPE_NOMOPE AS NOMEXP, ');

    qryTmp.SQL.Add('  GER_SEPEXP    AS OPESEP, ');
    qryTmp.SQL.Add('  OS.OPE_NOMOPE AS NOMSEP, ');
    qryTmp.SQL.Add('  AUX_NUMRAN    AS NUMRAN, ');
    qryTmp.SQL.Add('  GER_TELCON AS CELCON,  ');

    qryTmp.SQL.Add('  @PTOVEN := COALESCE((SELECT CLU2.FID_QTDPTO FROM CLUFID CLU2 ');
    qryTmp.SQL.Add('  JOIN CADCLI CLI2 ON CLI2.CLI_CODCLI = CLU2.FID_CODCLI ');
    qryTmp.SQL.Add('  WHERE CLU2.FID_CODCLI = MOVGER.GER_CODCLI ');
    qryTmp.SQL.Add('  AND   CLU2.FID_CODEMP = MOVGER.GER_CODEMP ');
    qryTmp.SQL.Add('  AND   CLU2.FID_ESPDOC = MOVGER.GER_ESPDOC ');
    qryTmp.SQL.Add('  AND   CLU2.FID_NUMDOC = MOVGER.GER_NUMDOC ');
    qryTmp.SQL.Add('  AND   CLU2.FID_CREDEB = "C" ');
    qryTmp.SQL.Add('  AND   CLI2.CLI_CLUFID = "S"  ');
    qryTmp.SQL.Add('  ),0)- ');
    qryTmp.SQL.Add('  COALESCE((SELECT CLU2.FID_QTDPTO FROM CLUFID CLU2 ');
    qryTmp.SQL.Add('  JOIN CADCLI CLI2 ON CLI2.CLI_CODCLI = CLU2.FID_CODCLI ');
    qryTmp.SQL.Add('  WHERE CLU2.FID_CODCLI = MOVGER.GER_CODCLI ');
    qryTmp.SQL.Add('  AND   CLU2.FID_CODEMP = MOVGER.GER_CODEMP ');
    qryTmp.SQL.Add('  AND   CLU2.FID_ESPDOC = MOVGER.GER_ESPDOC ');
    qryTmp.SQL.Add('  AND   CLU2.FID_NUMDOC = MOVGER.GER_NUMDOC ');
    qryTmp.SQL.Add('  AND   CLU2.FID_CREDEB = "D" ');
    qryTmp.SQL.Add('  AND   CLI2.CLI_CLUFID = "S"  ');
    qryTmp.SQL.Add('  ),0) AS PTOVEN, ');

    qryTmp.SQL.Add('  @PTOANT := COALESCE((SELECT SUM(IF(CLU1.FID_CREDEB = "C", CLU1.FID_QTDPTO, -CLU1.FID_QTDPTO)) FROM CLUFID CLU1 ');
    qryTmp.SQL.Add('  JOIN CADCLI CLI2 ON CLI2.CLI_CODCLI = CLU1.FID_CODCLI ');
    qryTmp.SQL.Add('  WHERE CLU1.FID_CODCLI = MOVGER.GER_CODCLI ');
    qryTmp.SQL.Add('  AND   CLU1.FID_DTACAD <= MOVGER.GER_DTAENT ');
    qryTmp.SQL.Add('  AND   CLI2.CLI_CLUFID = "S"  ');
    qryTmp.SQL.Add('  AND   CLU1.FID_DTABAI IS NULL ');
    qryTmp.SQL.Add('  AND   CLU1.FID_HRABAI IS NULL ');
    qryTmp.SQL.Add('  AND CLU1.AUTOINCREM <> CF.AUTOINCREM ');
    qryTmp.SQL.Add('  ),0) AS PTOANT,  ');

    qryTmp.SQL.Add(' (@PTOVEN + @PTOANT) AS PTOSLD ');

    qryTmp.SQL.Add('  ,  CAST((SELECT GROUP_CONCAT(MCU_NUMCUP SEPARATOR ", ")      ');
    qryTmp.SQL.Add('          FROM MOVCUP                                          ');
    qryTmp.SQL.Add('        WHERE MCU_NUMDOC = DET_NUMDOC                          ');
    qryTmp.SQL.Add('          AND MCU_ESPDOC = DET_ESPDOC                          ');
    qryTmp.SQL.Add('          AND MCU_CODEMP = DET_CODEMP) AS CHAR(255)) AS NUMCUP ');

    qryTmp.SQL.Add('  ,IF(MOVDET.DET_NUM_PD <> "", CONCAT(MOVDET.DET_NUM_PD, " - ", MOVDET.DET_ESP_PD), "") AS NUMPED ');
    qryTmp.SQL.Add('  ,MD.DET_QTDPEC AS QTDPEC ');
    qryTmp.SQL.Add('  ,MD.DET_COMPEC AS COMPEC ');
    qryTmp.SQL.Add('  ,MD.DET_LARPEC AS LARPEC ');
    qryTmp.SQL.Add('  ,MD.DET_ESPPEC AS ESPPEC ');
    qryTmp.SQL.Add('FROM ');
    qryTmp.SQL.Add('  MOVDET ');
    qryTmp.SQL.Add('  JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ');
    qryTmp.SQL.Add('  JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ');
    qryTmp.SQL.Add('  JOIN CADUNI ON DET_UNIDAD = UNI_CODUNI ');

    qryTmp.SQL.Add('  JOIN ITEGER ON ITE_CODITE = DET_CODITE AND ');
    qryTmp.SQL.Add('                 ITE_CODEMP = DET_CODEMP ');

    qryTmp.SQL.Add('  JOIN CADITE I ON I.ITE_CODITE = DET_CODITE ');
    qryTmp.SQL.Add('  LEFT JOIN CADDIV ON MOVDET.DET_CODDIV = CADDIV.DIV_CODDIV ');
    qryTmp.SQL.Add('  LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ');

    qryTmp.SQL.Add('  LEFT JOIN CADFIS ON FIS_NUMDOC = DET_NUMDOC AND ');
    qryTmp.SQL.Add('                      FIS_ESPDOC = DET_ESPDOC AND ');
    qryTmp.SQL.Add('                      FIS_CODEMP = DET_CODEMP AND ');
    qryTmp.SQL.Add('                      FIS_FORCLI = DET_CODCLI AND ');
    qryTmp.SQL.Add('                      FIS_TIP_FC = DET_TIP_FC AND ');
    qryTmp.SQL.Add('                      IFNULL(FIS_SERIE_, "") = IFNULL(DET_SERIE_, "") ');

    If fTabelaExiste('CADLOT', True) Then
    Begin
      qryTmp.SQL.Add('LEFT JOIN CADLOT ON DET_NUMLOT = LOT_NUMLOT AND ');
      qryTmp.SQL.Add('                    DET_CODITE = LOT_CODITE AND ');
      qryTmp.SQL.Add('                    DET_CODEMP = LOT_CODEMP     ');
    End;

    qryTmp.SQL.Add('  JOIN MOVOBS ON MOV_SEQGER = MOVGER.AUTOINCREM ');
    qryTmp.SQL.Add('  JOIN CADEMP ON EMP_CODEMP = DET_CODEMP ');
    qryTmp.SQL.Add('  JOIN CADCID CE ON CE.CID_CODCID = EMP_CODCID ');

    qryTmp.SQL.Add('  LEFT JOIN CADOPE VE ON VE.OPE_CODOPE = GER_CODVEN ');
    qryTmp.SQL.Add('  LEFT JOIN CADOPE DI ON DI.OPE_CODOPE = GER_CODDIG ');
    qryTmp.SQL.Add('  LEFT JOIN CADCLI    ON    CLI_CODCLI = GER_CODCLI ');
    qryTmp.SQL.Add('  LEFT JOIN CADCID CC ON CC.CID_CODCID = IF(' + CLIENTE_CONSUMIDOR + ', GER_CIDCON, CLI_CODCID) ');
    qryTmp.SQL.Add('  LEFT JOIN AUXMOV    ON    AUX_SEQGER = MOVGER.AUTOINCREM ');

    If (blnCodBar) Or (intModSAT = 2) Then
    Begin
      qryTmp.SQL.Add('  LEFT JOIN ITEBAR    ON    BAR_CODITE = MOVDET.DET_CODITE ');
      qryTmp.SQL.Add('                     AND    BAR_PRINCI = 1                 ');
    End;

    qryTmp.SQL.Add('  LEFT JOIN CADCND ON CND_CODIGO = GER_CODCND ');

    qryTmp.SQL.Add('  LEFT JOIN ENTCLI EE ON EE.AUTOINCREM = AUXMOV.AUX_ENTGER ');
    qryTmp.SQL.Add('  LEFT JOIN CADCID CE2 ON CE2.CID_CODCID = EE.ETC_CIDENT ');

    qryTmp.SQL.Add('  LEFT JOIN CADOPE OE ON OE.OPE_CODOPE = GER_OPEEXP ');

    qryTmp.SQL.Add('  LEFT JOIN CADOPE OS ON OS.OPE_CODOPE = GER_SEPEXP ');

    qryTmp.SQL.Add('  LEFT JOIN CADACA ACA ON ACA.ACA_CODACA = MOVDET.DET_CODACA AND ');
    qryTmp.SQL.Add('                          ACA.ACA_CODEMP = MOVDET.DET_EMPACA     ');

    qryTmp.SQL.Add('  LEFT JOIN MOVMAD MD ON MD.DET_SEQGER = MOVDET.AUTOINCREM ');

    qryTmp.SQL.Add('  LEFT JOIN CLUFID CF ON ');
    qryTmp.SQL.Add('        CF.FID_CODEMP = MOVGER.GER_CODEMP AND ');
    qryTmp.SQL.Add('        CF.FID_ESPDOC = MOVGER.GER_ESPDOC AND ');
    qryTmp.SQL.Add('        CF.FID_NUMDOC = MOVGER.GER_NUMDOC AND ');
    qryTmp.SQL.Add('        CF.FID_CODCLI = MOVGER.GER_CODCLI ');

    qryTmp.SQL.Add('WHERE ');
    qryTmp.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
    qryTmp.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
    qryTmp.SQL.Add('  DET_CODEMP = :CODEMP AND ');
    qryTmp.SQL.Add('  DET_CODCLI = :CODCLI AND ');
    qryTmp.SQL.Add('  DET_TIP_FC = :TIP_FC AND ');
    qryTmp.SQL.Add('  IFNULL(DET_PROEMB,"N") <> "S" AND ');
    qryTmp.SQL.Add('  IFNULL(DET_SERIE_, "") = :SERIE_ ');

    If (blnCodBar) Or (intModSAT = 2) Then
      qryTmp.SQL.Add('GROUP BY NUMDOC, SERIE_, CODITE, UNITAR, DESITE ');

    strOrdIte := fCfgSis('ORDALF');

    strSQL := AnsiReplaceStr(
              AnsiReplaceStr(
              AnsiReplaceStr(
              AnsiReplaceStr(
              AnsiReplaceStr(qryTmp.SQL.Text, 'MOVGER', 'NOTGER'),
                                              'MOVDET', 'NOTDET'),
                                              'AUXMOV', 'AUXNOT'),
                                              'MOVOBS', 'NOTOBS'),
                                              'MOVTRI', 'NOTTRI');

    strSQL := AnsiReplaceStr(strSQL, 'AUX_NUMGUI', ' "" ');
    strSQL := AnsiReplaceStr(strSQL, 'GER_SEPEXP', ' "" ');
    strSQL := AnsiReplaceStr(strSQL, 'OS.OPE_NOMOPE', ' "" ');
    strSQL := AnsiReplaceStr(strSQL, 'LEFT JOIN CADOPE OS ON OS.OPE_CODOPE = GER_SEPEXP', '');

    qryTmp.SQL.Add(' UNION ALL ');
    qryTmp.SQL.Add(strSQL);

    If (strOrdIte = 'A') Then      //ORDEM (A)LFABETICA
      qryTmp.SQL.Add('  ORDER BY 2, 7 ')
    Else If (strOrdIte = 'C') Then //ORDEM (C)ODIGO DO ITEM
      qryTmp.SQL.Add('  ORDER BY 1, 7 ')
    Else If (strOrdIte = 'U') Then //ORDEM (U)NIDADE + DESCRIÇÃO
      qryTmp.SQL.Add('  ORDER BY 3, 2, 7 ')
    Else If (strOrdIte = 'F') Then // ORDEM (F)ORNECEDOR DO ITEM
      qryTmp.SQL.Add('  ORDER BY 4, 7 ')
    Else If (strOrdIte = 'L') Then // ORDEM (L)OCALIZACAO FISICA
      qryTmp.SQL.Add('  ORDER BY 5, 7 ')
    Else If (strOrdIte = 'P') Then // ORDEM (P)ESO UNIDADE + UNIDADE + DESCRIÇÃO DO PRODUTO
      qryTmp.SQL.Add('  ORDER BY 6, 3, 2, 7 ');
  End;
end;

function TfrmQckFatImpNFCe.fImpressoraKey(): String;
begin
  If VS_SpoolImpressaoCitel Then
    Result := 'PONTO_IMPRESSAO'
  Else
    Result := 'IMPRESSORA';
end;

procedure TfrmQckFatImpNFCe.pCarregaModalidadesPagamento(fltTotGer: Double; strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strSerie: String; Var strModalidades, strValores: String);
  Var
    qryMod: TUniQuery;
    fltTotMod: Double;
    strTipCar: String;
    fltValPag: Double;

    Function fFormaPagtoAPrazo(strCodFpg: String): Boolean;
      Const
        arrAPrazo : Array[0..4] Of String = ('008','010','012','014','015');
      Var
        i: Integer;
    Begin
      Result := False;

      For i := Low(arrAPrazo) To High(arrAPrazo) Do
      Begin
        If (Not Result) And (strCodFpg = arrAPrazo[i]) Then
          Result := True;
      End;
    End;

begin
  qryMod := fCriaQuery(Self);
  qryMod.SQL.Add('SELECT ');
  qryMod.SQL.Add('  FPG_CODIGO, ');
  qryMod.SQL.Add('  FPG_DESCRI, ');
  qryMod.SQL.Add('  MOD_VALMOD, ');
  qryMod.SQL.Add('  MOD_VALPAG, ');
  qryMod.SQL.Add('  MOD_VALMOD, ');
  qryMod.SQL.Add('  MCA_TIPCAR, ');
  qryMod.SQL.Add('  CASE MOD_CODMOD ');
  qryMod.SQL.Add('    WHEN "001" THEN "01" ');
  qryMod.SQL.Add('    WHEN "002" THEN "02" ');
  qryMod.SQL.Add('    WHEN "006" THEN "02" ');
  qryMod.SQL.Add('    WHEN "007" THEN IF(MOD_DOCUME <> "", IF(CAR_TIPCAR="C", "03", "04"), IF(MOD_TIPCAR="C", "03", "04")) ');
  qryMod.SQL.Add('    ELSE "99" ');
  qryMod.SQL.Add('  END AS CODMOD ');
  qryMod.SQL.Add('FROM ');
  qryMod.SQL.Add('  MOVMOD ');
  qryMod.SQL.Add('  JOIN CADFPG ON FPG_CODIGO = MOD_CODMOD ');
  qryMod.SQL.Add('  LEFT JOIN MOVCAR ON MOD_DOCUME = MCA_DOCUME ');
  qryMod.SQL.Add('                  AND MCA_PARCEL = "A" ');
  qryMod.SQL.Add('                  AND MOD_CODMOD = "007" ');
  qryMod.SQL.Add('                  AND TRIM(IFNULL(MOD_DOCUME, "")) <> "" ');
  qryMod.SQL.Add('                  AND MCA_CODCLI = :CODCLI ');
  qryMod.SQL.Add('  LEFT JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ');
  qryMod.SQL.Add('WHERE ');
  qryMod.SQL.Add('  MOD_NUMDOC = :NUMDOC AND ');
  qryMod.SQL.Add('  MOD_ESPDOC = :ESPDOC AND ');
  qryMod.SQL.Add('  MOD_CODEMP = :CODEMP AND ');
  qryMod.SQL.Add('  MOD_CODCLI = :CODCLI AND ');
  qryMod.SQL.Add('  IFNULL(MOD_SERIE_, "") = :SERIE_ ');

  qryMod.ParamByName('NUMDOC').AsString := strNumDoc;
  qryMod.ParamByName('ESPDOC').AsString := strEspDoc;
  qryMod.ParamByName('CODEMP').AsString := strCodEmp;
  qryMod.ParamByName('CODCLI').AsString := strCodCli;
  qryMod.ParamByName('SERIE_').AsString := strSerie;
  qryMod.Open;

  strModalidades := '';
  strValores := '';
  fltTotMod := 0;

  qryMod.First;
  While (Not qryMod.Eof) Do
  Begin
    strTipCar := '';

    {********************************************************************************}
    {* SE A FORMA DE PAGAMENTO FOR A PRAZO, UTILIZA O VALMOD, SE NÃO UTILIZA VALPAG *}
    {*****************************************************************************MM*}
    If fFormaPagtoAPrazo(qryMod.FieldByName('FPG_CODIGO').AsString) Then
      fltValPag := qryMod.FieldByName('MOD_VALMOD').AsFloat
    Else
      fltValPag := qryMod.FieldByName('MOD_VALPAG').AsFloat;

    If fltValPag > 0 Then
    Begin
      If Pos(qryMod.FieldByName('CODMOD').AsString, '03_04_') > 0 Then
      Begin
        If (qryMod.FieldByName('MCA_TIPCAR').AsString = 'POS') Then
        Begin
          strTipCar := 'POS';
        End
        Else
        Begin
          strTipCar := iif(qryMod.FieldByName('CODMOD').AsString = '03', 'CRÉDITO', 'DÉBITO');
        End;
      End;

      If Not fEmptyStr(strTipCar) Then
        strModalidades := strModalidades + qryMod.FieldByName('FPG_DESCRI').AsString + ' (' + strTipCar + '):'
      Else
        strModalidades := strModalidades + qryMod.FieldByName('FPG_DESCRI').AsString + ':';

      strValores     := strValores + FloatToStrF(fltValPag, ffNumber, 12, 2);
      fltTotMod      := fltTotMod + fltValPag;

      If qryMod.RecNo < qryMod.RecordCount Then
      Begin
        strModalidades := strModalidades + #13#10;
        strValores := strValores + #13#10;
      End;
    End;

    qryMod.Next;
  End;

  If fFormataFloat(fltTotGer, 2) > fFormataFloat(fltTotMod, 2) Then
  Begin
    strModalidades := strModalidades + #13#10 + 'DINHEIRO:';
    strValores     := strValores     + #13#10 + FloatToStrF(fFormataFloat(fltTotGer, 2) - fFormataFloat(fltTotMod, 2), ffNumber, 12, 2);
  End;

  FreeAndNil(qryMod);
end;

procedure TfrmQckFatImpNFCe.pCarregarFuncoesDllDaruma;
  Var
    strPatDll: String;
begin
  If HandleDarumaFramework = 0 Then
  Begin
    strPatDll := fArqIniLocal(0, 'NFCE', 'DARUMA_PATH_DLL', '', fCfgSis('PTNFCE') + '\opcoes_nfce.ini');

    HandleDarumaFramework := LoadLibrary(PChar(strPatDll));
    If HandleDarumaFramework = 0 Then
    Begin
      RaiseLastOSError;
//      Raise Exception.Create('Não foi possível carregar dll ' + strPatDll);
    End;

    iImprimirTexto_DUAL_DarumaFramework := GetProcAddress(HandleDarumaFramework, PWideChar('iImprimirTexto_DUAL_DarumaFramework'));
    rStatusImpressora_DUAL_DarumaFramework := GetProcAddress(HandleDarumaFramework, PWideChar('rStatusImpressora_DUAL_DarumaFramework'));
    eBuscarPortaVelocidade_DUAL_DarumaFramework := GetProcAddress(HandleDarumaFramework, PWideChar('eBuscarPortaVelocidade_DUAL_DarumaFramework'));
  End;

end;

procedure TfrmQckFatImpNFCe.pImprimirCancelamentoSAT(strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strSerie, strTip_FC, strImpressora: String);
  Var
    qryDados: TUniQuery;
    strNomImp: String;
    stream: TMemoryStream;
    frxQrCode: TfrxPictureView;
    intTentativas: Integer;
    bmpQrCode: TBitmap;

  procedure pAbrirQuery;
  begin
    qryDados.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDados.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDados.ParamByName('CODEMP').AsString := strCodEmp;
    qryDados.ParamByName('FORCLI').AsString := strCodCli;
    qryDados.ParamByName('TIP_FC').AsString := strTip_FC;
    qryDados.ParamByName('SERIE_').AsString := strSerie;
    qryDados.Open;
  end;
begin
  qryDados := fCriaQuery;
  qryDados.SQL.Add('SELECT ');
  qryDados.SQL.Add('  MOV_CFECAN, ');
  qryDados.SQL.Add('  FIS_NUMSER, ');
  qryDados.SQL.Add('  MOV_ACECAN, ');
  qryDados.SQL.Add('  LEFT(MOV_ACECAN, 22) AS ACESSO1, ');
  qryDados.SQL.Add('  RIGHT(MOV_ACECAN, 22) AS ACESSO2, ');
  qryDados.SQL.Add('  GER_CGCCON, ');
  qryDados.SQL.Add('  GER_VLRCON, ');
  qryDados.SQL.Add('  MOV_DPRCAN, ');
  qryDados.SQL.Add('  MOV_QRCCAN ');
  qryDados.SQL.Add('FROM ');
  qryDados.SQL.Add('  CADFIS ');
  qryDados.SQL.Add('  JOIN MOVGER ON MOVGER.GER_NUMDOC = CADFIS.FIS_NUMDOC AND ');
  qryDados.SQL.Add('                 MOVGER.GER_ESPDOC = CADFIS.FIS_ESPDOC AND ');
  qryDados.SQL.Add('                 MOVGER.GER_CODEMP = CADFIS.FIS_CODEMP AND ');
  qryDados.SQL.Add('                 MOVGER.GER_CODCLI = CADFIS.FIS_FORCLI AND ');
  qryDados.SQL.Add('                 MOVGER.GER_TIP_FC = CADFIS.FIS_TIP_FC AND ');
  qryDados.SQL.Add('                 IFNULL(MOVGER.GER_SERIE_, "") = IFNULL(CADFIS.FIS_SERIE_, "") ');

  qryDados.SQL.Add('  JOIN MOVOBS ON MOVOBS.MOV_SEQGER = MOVGER.AUTOINCREM ');

  qryDados.SQL.Add('WHERE ');
  qryDados.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
  qryDados.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
  qryDados.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
  qryDados.SQL.Add('  FIS_FORCLI = :FORCLI AND ');
  qryDados.SQL.Add('  FIS_TIP_FC = :TIP_FC AND ');
  qryDados.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ ');

  pAbrirQuery;

  If qryDados.IsEmpty Then
  Begin
    qryDados.Close;
    qryDados.SQL.Text := AnsiReplaceStr(AnsiReplaceStr(qryDados.SQL.Text, 'MOVGER', 'NOTGER'), 'MOVOBS', 'NOTOBS');
    pAbrirQuery;
  End;

  frxCancSATCFe.Script.Variables['NUMCOO'] := qryDados.FieldByName('MOV_CFECAN').AsString;
  frxCancSATCFe.Script.Variables['NUMSER'] := LeftStr(fTransform(qryDados.FieldByName('FIS_NUMSER').AsString, 3, '.'), 11);
  frxCancSATCFe.Script.Variables['ACESSO'] := fTransform(qryDados.FieldByName('MOV_ACECAN').AsString, 4, ' ');
  frxCancSATCFe.Script.Variables['VLRCON'] := FloatToStrF(qryDados.FieldByName('GER_VLRCON').AsFloat, ffNumber, 12, 2);
  frxCancSATCFe.Script.Variables['DPROTO'] := qryDados.FieldByName('MOV_DPRCAN').AsString;

  If fStringRepetida(qryDados.FieldByName('GER_CGCCON').AsString) Then
    frxCancSATCFe.Script.Variables['CPF_CONSUMIDOR'] := ''
  Else If fTestaCgc(qryDados.FieldByName('GER_CGCCON').AsString) Then
    frxCancSATCFe.Script.Variables['CPF_CONSUMIDOR'] := fFormataCpfCgc(qryDados.FieldByName('GER_CGCCON').AsString, opcBrasil)
  Else
    frxCancSATCFe.Script.Variables['CPF_CONSUMIDOR'] := fFormataCpfCgc(qryDados.FieldByName('GER_CGCCON').AsString, opcBrasil);

  TfrxBarCodeView(frxCancSATCFe.FindObject('codBarra1')).Text := qryDados.FieldByName('ACESSO1').AsString;
  TfrxBarCodeView(frxCancSATCFe.FindObject('codBarra2')).Text := qryDados.FieldByName('ACESSO2').AsString;

  frxQrCode := TfrxPictureView(frxCancSATCFe.FindObject('imgQRCode'));

  intTentativas := 0;

  While True Do
  Begin
    Try
      bmpQrCode := fGerarQRCode(qryDados.FieldByName('MOV_QRCCAN').AsString);
      Sleep(100);
      Break;
    Except
      On E: Exception Do
      Begin
        Inc(intTentativas);
        If intTentativas > 30 Then
        Begin
          Raise;
        End;
        Sleep(500);
        Application.ProcessMessages;
      End;
    End;
  End;

  stream := TMemoryStream.Create;
  bmpQrCode.SaveToStream(stream);

  frxQrCode.LoadPictureFromStream(stream);
  FreeAndNil(stream);
  FreeAndNil(bmpQrCode);

  If fEmptyStr(strImpressora) Then
    strNomImp := fArqIniLocal(0, 'SATCFE', fImpressoraKey, '', fCfgSis('PATSAT') + '\opcoes_sat.ini')
  Else
    strNomImp := strImpressora;

  strNomImp := fIdentificarNomeDaImpressora(strNomImp);

  frxCancSATCFe.PrintOptions.Printer := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
  frxCancSATCFe.PrintOptions.ShowDialog := False;

  If frxCancSATCFe.PrepareReport Then
    pPrintReport(Self.Name, 'Impressão cancelamento SAT', strNomImp, frxCancSATCFe);

  FreeAndNil(qryDados);
end;

procedure TfrmQckFatImpNFCe.pImprimirCarnePagto(strBarCon: String;
  fltLimiteCredito: Double; strCodCli, strNomCli, strNomVen,
  dtaDtaCom: String; FDuplic: TArrDuplicatas);
  Var
    strNomImp: String;
begin
  intIndiceDuplic := 0;
  Self.FDuplic := FDuplic;
  Self.FBarCon := strBarCon;
  Self.blnExibeDtaCad := False;

  If fUsaSat Then
  begin
    TfrxReportPage(frxCarneRecibo.FindObject('Page1')).LeftMargin := fStrToFloat(fArqIniLocal(0, 'SATCFE', 'MARGEM', '0', fCfgSis('PATSAT') + '\opcoes_sat.ini')) * 10;
  end
  else
  begin
    TfrxReportPage(frxCarneRecibo.FindObject('Page1')).LeftMargin := fStrToFloat(fArqIniLocal(0, 'NFCE', 'MARGEM', '0', fCfgSis('PTNFCE') + '\opcoes_nfce.ini')) * 10;
  end;

  frxCarneRecibo.Script.Variables['BARCON'] := strBarCon;
  frxCarneRecibo.Script.Variables['DATA_SALDO'] := FormatDateTime('dd/mm/yyyy', VS_Date);
  frxCarneRecibo.Script.Variables['LIMITE_CREDITO'] := FloatToStrF(fltLimiteCredito, ffNumber, 12, 2);
  frxCarneRecibo.Script.Variables['CODCLI'] := strCodCli;
  frxCarneRecibo.Script.Variables['NOMCLI'] := strNomCli;
  frxCarneRecibo.Script.Variables['NOMVEN'] := strNomVen;
  frxCarneRecibo.Script.Variables['DTACOM'] := dtaDtaCom;

  strNomImp := fLerImpressora;

  frxCarneRecibo.PrintOptions.Printer := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
  frxCarneRecibo.PrintOptions.ShowDialog := False;

  If frxCarneRecibo.PrepareReport Then
  Begin
    pPrintReport(Self.Name, 'Impressão Carnê Pagamento', strNomImp, frxCarneRecibo);
  End;
end;

function TfrmQckFatImpNFCe.fImprimirEspelhoCartaoVinculado(ANumeroDocumento, AEspecieDocumento, AEmpresaDocumento,
  AFilaImpressao, ATipoImpressao : string; AGeraPDF : boolean; var ANomeDoArquivo, AMensagem : string) : boolean;
Var LQuery : TUniQuery;
    LNomeImpressao : string;
    LReport : TfrxReport;
    LNomeDoArquivo : string;
    LNomeDaPasta   : string;
begin
  Result := True;
  Try
    LReport := fGetLayoutImpressaoEspelhoCartaoVinculado(AEspecieDocumento, AEmpresaDocumento);
    if not Assigned(LReport) then
    begin
      AMensagem := 'Erro ao localizar o layout padrão para impressão do movimento '+
      'do cartão associado ao documento';
      Exit(False);
    end;

    LQuery := fCriaQuery;
    Try
      LQuery.Sql.Text := ' SELECT CONCAT(M.MCA_CODCAR,''-'',C.CAR_DESCAR) CARTAO, '+
                         '        M.MCA_DTACAD DATA_CADASTRO, '+
                         '        M.MCA_NUMNSU NUMNSU, '+
                         '        M.MCA_NUMCCD NUMCCD, '+
                         '        M.MCA_PARCEL PARCELA,'+
                         '        M.MCA_VALSTA VALOR_VISTA,  '+
                         '        M.MCA_PERCAR PERC_DESCONTO,'+
                         '        M.MCA_VALTAX VALOR_TAXA,   '+
                         '        M.MCA_VALORI VALOR_PARCELA,'+
                         '        M.MCA_DTAVEN DATA_VENCIMENTO '+
                         '   FROM MOVCAR M '+
                         '   JOIN CADCAR C ON M.MCA_CODCAR = C.CAR_CODCAR '+
                         '   WHERE M.MCA_DOCUME LIKE "%'+ANumeroDocumento+'%"'+
                         '     AND M.MCA_DOCUME LIKE "%'+AEspecieDocumento+'%"'+
                         '     AND M.MCA_DOCUME LIKE "%'+AEmpresaDocumento+'%"';
      Lquery.Open;
      if Lquery.IsEmpty then
      begin
        Lquery.Close;
        Lquery.Sql.Text := AnsiReplaceStr(Lquery.Sql.Text, 'MOVCAR', 'DEL_MOVCAR');

        {**************************************************
        INCLUIDO ESSA CONDIÇÃO PARA GARANTIR QUE SEMPRE PEGUE
        O ULITMO LOG DA DEL_MOVCAR
        **********************************************GD**}
        Lquery.Sql.Text := Lquery.Sql.Text + ' AND M.MCA_NUMDUP = (SELECT MAX(MCA_NUMDUP) '+
                                             '                       FROM DEL_MOVCAR '+
                                             '                      WHERE MCA_DOCUME LIKE "%'+ANumeroDocumento+'%"'+
                                             '                        AND MCA_DOCUME LIKE "%'+AEspecieDocumento+'%"'+
                                             '                        AND MCA_DOCUME LIKE "%'+AEmpresaDocumento+'%") ';
        Lquery.Open;
      end;

      if not Lquery.IsEmpty then
      begin
        LReport.Script.Variables['CARTAO']        := LQuery.FieldByName('CARTAO').AsString;
        LReport.Script.Variables['DATA_CADASTRO'] := FormatDateTime('dd/mm/yyyy', LQuery.FieldByName('DATA_CADASTRO').AsDateTime);
        LReport.Script.Variables['NUMNSU']        := LQuery.FieldByName('NUMNSU').AsString;
        LReport.Script.Variables['NUMCCD']        := LQuery.FieldByName('NUMCCD').AsString;

        frxDBCartaoVinculado.DataSet := Lquery;

        LNomeImpressao := AFilaImpressao;
        if fEmptyStr(LNomeImpressao) then
        begin
          LNomeImpressao := fRetornaFilaImpressaoNFCe;
          If fExisteFilaImpressaoNFCe And fEmptyStr(LNomeImpressao) Then
            Exit;

          if fEmptyStr(LNomeImpressao) then
          begin
            // Com o spool Citel a impressora é um ponto de impressão: a padrão do Windows depende do
            // Spooler (erro 1722 com ele desligado). O ponto só se pergunta quando vai imprimir de fato.
            If Not TCfgRel.VS_SpoolImpressaoCitel Then
              LNomeImpressao := TCfgRel.fGetImpPadraoWindows
            Else If (Not AGeraPDF) And (ATipoImpressao = 'I') Then
            begin
              LNomeImpressao := TCfgRel.fSelecionaFila('', '', True);
              If fEmptyStr(LNomeImpressao) Then
                Exit;
            end;
          end;
        end;

        LNomeImpressao := fIdentificarNomeDaImpressora(LNomeImpressao);
        LReport.PrintOptions.Printer := AnsiReplaceStr(LNomeImpressao,'\\' + fRetNomeRede + '\','');
        LReport.PrintOptions.ShowDialog := False;

        if not AGeraPDF then
        begin
          if (ATipoImpressao = 'I') then
          begin
            If LReport.PrepareReport Then
              pPrintReport(Self.Name, 'Impressão Espelho Cartão Vínculado', LNomeImpressao, LReport);
          end
          else
            pPreviewReport(Self.Name, 'Impressão Espelho Cartão Vínculado', LReport);
        end
        Else
        begin
          LNomeDoArquivo := 'CARTAO_'+ANumeroDocumento+'_'+AEspecieDocumento+'_'+AEmpresaDocumento+'.pdf';
          LNomeDaPasta := ExtractFilePath(Application.ExeName) + 'Docs_Env_Reimp\';

          frxExpPDF.FileName    := LNomeDoArquivo;
          frxExpPDF.DefaultPath := LNomeDaPasta;
          frxExpPDF.ShowDialog  := Not fCriaDiretorio(LNomeDaPasta);
          LReport.PrepareReport;
          LReport.Export(frxExpPDF);

          ANomeDoArquivo := ANomeDoArquivo+';'+LNomeDaPasta+LNomeDoArquivo;
        end;
      end;

    Finally
      FreeAndNil(LQuery);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmQckFatImpNFCe.fImprimirEspelhoCartaoVinculado]');
    End;
  End;
end;

procedure TfrmQckFatImpNFCe.pImprimirContrato(strBarCon: String;
  opcOpcCon: TOpcaoContrato; FDuplic, FDupRep: TArrDuplicatas; strCodCli,
  strNomCli, strNomVen: String; fltTotDup, fltTotRec: Double; strMenPed, dtaDtaCom: String);
  Var
    strNomImp: String;
    strDupRep: String;
    intIndiceRep: Integer;
begin
  Self.intIndiceDuplic := 0;
  Self.FDuplic := FDuplic;
  Self.FDupRep := FDupRep;
  Self.blnExibeDtaCad := True;

  If fUsaSat Then
  begin
    TfrxReportPage(frxContrato.FindObject('Page1')).LeftMargin := fStrToFloat(fArqIniLocal(0, 'SATCFE', 'MARGEM', '0', fCfgSis('PATSAT') + '\opcoes_sat.ini')) * 10;
  end
  else
  begin
    TfrxReportPage(frxContrato.FindObject('Page1')).LeftMargin := fStrToFloat(fArqIniLocal(0, 'NFCE', 'MARGEM', '0', fCfgSis('PTNFCE') + '\opcoes_nfce.ini')) * 10;
  end;

  frxContrato.Script.Variables['MENPED'] := strMenPed;
  frxContrato.Script.Variables['DUPLIC'] := FDuplic[0].strNumDup + '-' + FDuplic[0].strEspDoc;
  frxContrato.Script.Variables['BARCON'] := strBarCon;
  frxContrato.Script.Variables['CODCLI'] := strCodCli;
  frxContrato.Script.Variables['NOMCLI'] := strNomCli;
  frxContrato.Script.Variables['NOMVEN'] := strNomVen;
  frxContrato.Script.Variables['TOTDUP'] := FloatToStrF(fltTotDup, ffNumber, 12, 2);
  frxContrato.Script.Variables['TOTREC'] := FloatToStrF(fltTotRec, ffNumber, 12, 2);

  frxContrato.Script.Variables['EMPRESA'] := VS_strCodEmp+'-'+fRetNomeEmpresa;
  frxContrato.Script.Variables['DTACOM'] := dtaDtaCom;

  If opcOpcCon = ContratoVenda Then
  Begin
    frxContrato.Script.Variables['TIPDOC'] := 'Cupom Fiscal:';
    frxContrato.Script.Variables['TIPOPE'] := 'Vendedor....:';
    frxContrato.Script.Variables['TIPO_REL'] := 'DEMONSTRATIVO';
    frxContrato.Script.Variables['TEXTO_OBRIG'] := 'deste Cupom Fiscal e obrigo-me a pagá-la no';
  End
  Else
  Begin
    frxContrato.Script.Variables['TIPDOC'] := 'Documento...:';
    frxContrato.Script.Variables['TIPOPE'] := 'Operador....:';
    frxContrato.Script.Variables['TIPO_REL'] := 'REPARCELAMENTO';
    frxContrato.Script.Variables['TEXTO_OBRIG'] := 'deste reparcelamento e obrigo-me a pagá-la no';
  End;

  frxContrato.FindObject('ChdParCar').Visible := Length(FDupRep) > 0;
  frxContrato.FindObject('rlbDupRep').Visible := Length(FDupRep) > 0;
  frxContrato.FindObject('FooterMenPed').Visible := (fCfgSis('CREMSG', varBoolean)) And (Not fEmptyStr(strMenPed));

  strDupRep := '';
  For intIndiceRep := Low(FDupRep) To High(FDupRep) Do
  Begin
    strDupRep := strDupRep + '-Dup: ' + FDupRep[intIndiceRep].strNumDup +
                              FDupRep[intIndiceRep].strParcel + '-' +
                              FDupRep[intIndiceRep].strEspDoc +

                   ' Ven: ' + fPadC(FDupRep[intIndiceRep].strDtaVen, 08) +
                   ' Vlr: ' + fPadL(FDupRep[intIndiceRep].strValDup, 12) + #13#10;
  End;

  frxContrato.Script.Variables['DUPREP'] := '';
  If Not fEmptyStr(strDupRep) Then
  Begin
    frxContrato.Script.Variables['DUPREP'] := strDupRep;
  End;

  strNomImp := fLerImpressora;

  frxContrato.PrintOptions.Printer := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
  frxContrato.PrintOptions.ShowDialog := False;

  If frxContrato.PrepareReport Then
  Begin
    pPrintReport(Self.Name, 'Impressão Contrato Venda/Reparcelamento', strNomImp, frxContrato);
  End;
end;

procedure TfrmQckFatImpNFCe.pImprimirDadosEntrega(
  dadosCupom: TDadosImpressaoVenda);
  Var
    qryItens: TUniQuery;
    stlMen001: TStringList;
    stlMen002: TStringList;

  strNomCli: String;
  strEndCli: String;
  strCepCli: String;
  strCgcCli: String;

  strEndEnt: String;
  strCidEnt: String;
  strVencimentos: String;

  intContador: Integer;
  strNomImp: String;
  blnExecute: Boolean;

  strMsg001: String;
  strMsg002: String;
  arrDuplicata: TarrDuplicata;
begin
  pZeraDigDuplic(arrDuplicata);

  stlMen001 := TStringList.Create;
  stlMen002 := TStringList.Create;

  If Not fEmptyStr(dadosCupom.strMen001) Then stlMen001.Text := WrapText(dadosCupom.strMen001, 45);
  If Not fEmptyStr(dadosCupom.strMen002) Then stlMen002.Text := WrapText(dadosCupom.strMen002, 45);

  If Pos('-', dadosCupom.recEndEnt.strCepEnt) = 0 Then  dadosCupom.recEndEnt.strCepEnt := FormatMaskText('99999-999;0;_', dadosCupom.recEndEnt.strCepEnt);

  strNomCli := LeftStr( dadosCupom.strCliNom, 31 ) + '-' + dadosCupom.strCodCli;
  strEndCli := LeftStr(dadosCupom.strCliEnd + ' - ' + dadosCupom.strCliBai, 48);
  strCepCli := 'CEP: ' +  dadosCupom.strCliCep + ' - ' + dadosCupom.strCliCid + '-' + dadosCupom.strCliEst;
  strCgcCli := dadosCupom.strCliCgc + ' - ' + dadosCupom.strCliIes;

  If fEmptyStr(dadosCupom.recEndEnt.strEndEnt) Then
  Begin
    strEndEnt := dadosCupom.strCliEnd + ' - ' + dadosCupom.strCliBai;
    strCidEnt := 'CEP: ' + dadosCupom.strCliCep + ' - ' + dadosCupom.strCliCid + '-' + dadosCupom.strCliEst;
  End
  Else
  Begin
    strEndEnt := dadosCupom.recEndEnt.strEndEnt + ' - ' + dadosCupom.recEndEnt.strBaiEnt;
    strCidEnt := 'CEP: ' + dadosCupom.recEndEnt.strCepEnt + ' - ' + dadosCupom.recEndEnt.strNomCid + '-' + dadosCupom.recEndEnt.strEstEnt;
  End;

  If fCfgSis('IMPDCE', varBoolean) Then
  Begin
//    visible := false nos carinhas do item
  End;

  fDigDuplic(arrDuplicata, dadosCupom.strConPag, 0, dadosCupom.fltTotGer, False, False, False, VS_Date, False);

  For intContador := 0 to 23 Do
    arrDuplicata[intContador].curValor := dadosCupom.arrDuplicatasCND[intContador].curValor;

  strVencimentos := '';
  For intContador := 0 to 23 Do
  Begin
    With arrDuplicata[intContador] Do
    If curValor > 0 Then
    Begin
      strVencimentos := strVencimentos + dtaDtaVen + '  ' + FloatToStrF( curValor, ffFixed, 12, 2 ) + #13#10;
    End
    Else
    Begin
      Break;
    End;
  End;

  qryItens := fCriaQuery(Self);
  pCarregaDados(qryItens);
  qryItens.ParamByName('NUMDOC').AsString := dadosCupom.strNumDoc;
  qryItens.ParamByName('ESPDOC').AsString := dadosCupom.strEspDoc;
  qryItens.ParamByName('CODEMP').AsString := dadosCupom.strEmpDoc;
  qryItens.ParamByName('CODCLI').AsString := dadosCupom.strCodCli;
  qryItens.ParamByName('TIP_FC').AsString := dadosCupom.strTip_FC;
  qryItens.ParamByName('SERIE_').AsString := dadosCupom.strSerFsc;
  qryItens.Open;

  frxDbNFce.DataSet := qryItens;

  If fCfgSis('USASAT', varBoolean) Then
  Begin
    strNomImp := fArqIniLocal(0, 'SATCFE', fImpressoraKey, '', fCfgSis('PATSAT') + '\opcoes_sat.ini');
    strNomImp := fIdentificarNomeDaImpressora(strNomImp);
    TfrxReportPage(frxNFCeEntrega.FindObject('Page1')).LeftMargin := fStrToFloat(fArqIniLocal(0, 'SATCFE', 'MARGEM', '0', fCfgSis('PATSAT') + '\opcoes_sat.ini')) * 10;
    frxNFCeEntrega.Script.Variables['TITULO'] := 'SAT:';
  End
  Else If fCfgSis('USNFCE', varBoolean) Then
  Begin
    strNomImp := fArqIniLocal(0, 'NFCE', fImpressoraKey, '', fCfgSis('PTNFCE') + '\opcoes_nfce.ini');
    strNomImp := fIdentificarNomeDaImpressora(strNomImp);
    TfrxReportPage(frxNFCeEntrega.FindObject('Page1')).LeftMargin := fStrToFloat(fArqIniLocal(0, 'NFCE', 'MARGEM', '0', fCfgSis('PTNFCE') + '\opcoes_nfce.ini')) * 10;
    If (dadosCupom.strEspDoc='IF') Then
      frxNFCeEntrega.Script.Variables['TITULO'] := 'NFCe:'
    Else
      frxNFCeEntrega.Script.Variables['TITULO'] := 'FF:'
  End;

  blnExecute := True;

  If fEmptyStr(strNomImp) Then
  Begin
    strNomImp := VS_strUltimaImpressoraNFCe;
  End;

  If ((fEmptyStr(strNomImp)) Or (Not fImpressoraExiste(strNomImp))) Then
  Begin
    strNomImp := EmptyStr;
    blnExecute := TCfgRel.fExecutePrintDialog(strNomImp);
    If fEmptyStr(strNomImp) Then
      strNomImp := TCfgRel.fGetImpressoraSelecionada;
  End;

  frxNFCeEntrega.Script.Variables['NOMEMP'] := qryItens.FieldByName('NOMEMP').AsString;
  frxNFCeEntrega.Script.Variables['CNPJ'] := fFormataCpfCgc(qryItens.FieldByName('C_G_C_').AsString, opcBrasil);
  frxNFCeEntrega.Script.Variables['NUMDOC'] := dadosCupom.strNumDoc;
  frxNFCeEntrega.Script.Variables['SERIE_'] := dadosCupom.strSerFsc;
  frxNFCeEntrega.Script.Variables['DTAEMI'] := FormatDateTime('dd/mm/yyyy', qryItens.FieldByName('DTAENT').AsDateTime);
  frxNFCeEntrega.Script.Variables['NOMCLI'] := strNomCli;
  frxNFCeEntrega.Script.Variables['ENDCLI'] := strEndCli;
  frxNFCeEntrega.Script.Variables['CEPCLI'] := strCepCli;
  frxNFCeEntrega.Script.Variables['CGCCLI'] := strCgcCli;
  frxNFCeEntrega.Script.Variables['TELEMP'] := 'TELEFONE: ' + fFormataFone(qryItens.FieldByName('TELEMP').AsString)+
                                                              IfThen(not fEmptyStr(qryItens.FieldByName('TELDA1').AsString), ' / ' + fFormataFone(qryItens.FieldByName('TELDA1').AsString),'');
  frxNFCeEntrega.Script.Variables['TELCLI'] := 'TELEFONE: ' + fFormataFone(qryItens.FieldByName('TELCON').AsString);
  frxNFCeEntrega.Script.Variables['CELCLI'] := 'CELULAR: ' + fFormataFone(qryItens.FieldByName('CELCON').AsString);

  frxNFCeEntrega.Script.Variables['ENDENT'] := strEndEnt;
  frxNFCeEntrega.Script.Variables['CIDENT'] := strCidEnt;

  frxNFCeEntrega.Script.Variables['VENCIMENTOS'] := strVencimentos;

  If (fStatusCndPag(dadosCupom.strConPag) <> A_VISTA) Then
    frxNFCeEntrega.Script.Variables['MENSAGEM'] := fCfgSisL('MPRAF8')
  Else
    frxNFCeEntrega.Script.Variables['MENSAGEM'] := fCfgSisL('MVISF8');

  If fEmptyStr(IfNull(frxNFCeEntrega.Script.Variables['MENSAGEM'], '')) Then
  Begin
    frxNFCeEntrega.FindObject('rlbMensagem').Visible := False;
  End;

  strMsg001 := '';
  strMsg002 := '';

  If (stlMen001.Count > 0) Or (stlMen002.Count > 0) Then
  Begin
    For intContador := 0 To stlMen001.Count -1 Do
      strMsg001 := strMsg001 + stlMen001[intContador] + #13#10;

    For intContador := 0 To stlMen002.Count -1 Do
      strMsg002 := strMsg002 + stlMen002[intContador] + #13#10;
  End;

  If fEmptyStr(strMsg001) Then
  Begin
    frxNFCeEntrega.FindObject('rlbMsg001').Visible := False;
    frxNFCeEntrega.Script.Variables['MSG001'] := '';
  End
  Else
    frxNFCeEntrega.Script.Variables['MSG001'] := strMsg001;

  If fEmptyStr(strMsg002) Then
  Begin
    frxNFCeEntrega.FindObject('rlbMsg002').Visible := False;
    frxNFCeEntrega.Script.Variables['MSG002'] := '';
  End
  Else
    frxNFCeEntrega.Script.Variables['MSG002'] := strMsg002;

  If Not fCfgSis('IMPDCE', varBoolean) Then
  Begin
    frxNFCeEntrega.FindObject('rlbCabecalhoItens').Visible := False;
    frxNFCeEntrega.FindObject('rlbItens').Visible := False;
    frxNFCeEntrega.FindObject('rlbTotais').Visible := False;
  End;

  if blnExecute then
  begin
    frxNFCeEntrega.PrintOptions.Printer := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
    frxNFCeEntrega.PrintOptions.ShowDialog := False;
    If frxNFCeEntrega.PrepareReport Then
      pPrintReport(Self.Name, 'Impressão dados de entrega', strNomImp, frxNFCeEntrega);
  end;

  FreeAndNil(qryItens);
end;

procedure TfrmQckFatImpNFCe.pImprimirDadosEntregaDaruma(
  dadosCupom: TDadosImpressaoVenda);
  Var
    qryItens: TUniQuery;
    stlMen001: TStringList;
    stlMen002: TStringList;

    strNomCli: String;
    strEndCli: String;
    strCepCli: String;
    strCgcCli: String;
    strTelCli: String;
    strCelCli: String;

    strEndEnt: String;
    strCidEnt: String;
    strVencimentos: String;

    intContador: Integer;

    strMsg001: String;
    strMsg002: String;
    strItens: String;
    fltTotQtdIte: Double;

    strCabecalho: String;
    strMensagem: String;
    strSubTotal: String;
    strTitulo : String;
    arrDuplicata: TarrDuplicata;
begin
  pCarregarFuncoesDllDaruma;
  pInicializarDaruma;

  fltTotQtdIte := 0;

  stlMen001 := TStringList.Create;
  stlMen002 := TStringList.Create;

  If Not fEmptyStr(dadosCupom.strMen001) Then
    stlMen001.Text := WrapText(dadosCupom.strMen001, 45);
  If Not fEmptyStr(dadosCupom.strMen002) Then
    stlMen002.Text := WrapText(dadosCupom.strMen002, 45);

  If Pos('-', dadosCupom.recEndEnt.strCepEnt) = 0 Then
    dadosCupom.recEndEnt.strCepEnt := FormatMaskText('99999-999;0;_', dadosCupom.recEndEnt.strCepEnt);

  strNomCli := LeftStr( dadosCupom.strCliNom, 31 ) + '-' + dadosCupom.strCodCli;
  strEndCli := LeftStr(dadosCupom.strCliEnd + ' - ' + dadosCupom.strCliBai, 48);
  strCepCli := 'CEP: ' +  dadosCupom.strCliCep + ' - ' + dadosCupom.strCliCid + '-' + dadosCupom.strCliEst;
  strCgcCli := dadosCupom.strCliCgc + ' - ' + dadosCupom.strCliIes;

  If fEmptyStr(dadosCupom.recEndEnt.strEndEnt) Then
  Begin
    strEndEnt := dadosCupom.strCliEnd + ' - ' + dadosCupom.strCliBai;
    strCidEnt := 'CEP: ' + dadosCupom.strCliCep + ' - ' + dadosCupom.strCliCid + '-' + dadosCupom.strCliEst;
  End
  Else
  Begin
    strEndEnt := dadosCupom.recEndEnt.strEndEnt + ' - ' + dadosCupom.recEndEnt.strBaiEnt;
    strCidEnt := 'CEP: ' + dadosCupom.recEndEnt.strCepEnt + ' - ' + dadosCupom.recEndEnt.strNomCid + '-' + dadosCupom.recEndEnt.strEstEnt;
  End;

  fDigDuplic(arrDuplicata, dadosCupom.strConPag, 0, dadosCupom.fltTotGer, False, False, False, VS_Date, False);

  For intContador := 0 to 23 Do
    arrDuplicata[intContador].curValor := dadosCupom.arrDuplicatasCND[intContador].curValor;

  strVencimentos := '';
  For intContador := 0 to 23 Do
  Begin
    With arrDuplicata[intContador] Do
    If curValor > 0 Then
      strVencimentos := strVencimentos + dtaDtaVen + '  ' + FloatToStrF( curValor, ffFixed, 12, 2 ) + #13#10
    Else
      Break;
  End;

  qryItens := fCriaQuery(Self);
  pCarregaDados(qryItens);
  qryItens.ParamByName('NUMDOC').AsString := dadosCupom.strNumDoc;
  qryItens.ParamByName('ESPDOC').AsString := dadosCupom.strEspDoc;
  qryItens.ParamByName('CODEMP').AsString := dadosCupom.strEmpDoc;
  qryItens.ParamByName('CODCLI').AsString := dadosCupom.strCodCli;
  qryItens.ParamByName('TIP_FC').AsString := dadosCupom.strTip_FC;
  qryItens.ParamByName('SERIE_').AsString := dadosCupom.strSerFsc;
  qryItens.Open;

  strTelCli := 'TELEFONE: ' + fFormataFone(qryItens.FieldByName('TELCON').AsString);
  strCelCli := 'CELULAR: ' + fFormataFone(qryItens.FieldByName('CELCON').AsString);

  If fUsaSat Then
    strTitulo := 'SAT: '
  Else
  Begin
    If (qryItens.FieldByName('ESPDOC').AsString = 'IF') Then
      strTitulo := 'NFCe: '
    Else
      strTitulo := 'FF: '
  End;

  strCabecalho := fDarumaCentral(fDarumaNegrito(qryItens.FieldByName('NOMEMP').AsString), fDarumaSaltar1) +
                  fDarumaCentral(fDarumaNegrito(fFormataCpfCgc(qryItens.FieldByName('C_G_C_').AsString, opcBrasil)), fDarumaSaltar1) +
                  fDarumaCentral(fDarumaNegrito('TELEFONE: ' + fFormataFone(qryItens.FieldByName('TELEMP').AsString)), fDarumaSaltar1) +
                  fDarumaCentral(fDarumaNegrito(strTitulo + dadosCupom.strNumDoc + ' - Série: ' + dadosCupom.strSerFsc), fDarumaSaltar1) +
                  fDarumaCentral(fDarumaNegrito('Data de Emissão: ' + FormatDateTime('dd/mm/yyyy', qryItens.FieldByName('DTAENT').AsDateTime)), fDarumaSaltar1) +
                  fDarumaNegrito(fDarumaRiscarL('-'), fDarumaSaltar1) +
                  fDarumaCentral(fDarumaNegrito('DADOS DO CLIENTE'), fDarumaSaltar1) +
                  strNomCli + fDarumaSaltar1 +
                  strEndCli + fDarumaSaltar1 +
                  strCepCli + fDarumaSaltar1 +
                  strCgcCli + fDarumaSaltar1 +
                  strTelCli + fDarumaSaltar1 +
                  strCelCli + fDarumaSaltar1 + fDarumaSaltar1 +
                  fDarumaCentral(fDarumaNegrito('DADOS DA ENTREGA'), fDarumaSaltar1) +
                  strEndEnt + fDarumaSaltar1 +
                  strCidEnt + fDarumaSaltar1;

  {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
  iImprimirTexto_DUAL_DarumaFramework(strCabecalho + fDarumaAguarda, 0);
  {$WARN IMPLICIT_STRING_CAST_LOSS ON}

  If fCfgSis('IMPDCE', varBoolean) Then
  Begin
    {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
    iImprimirTexto_DUAL_DarumaFramework(fDarumaRiscarL('-', fDarumaSaltar1) +
                                        'Código  Descrição Qtde.  UN   Vl.Unit.  Vl.Total<l></l>' +
                                        fDarumaRiscarL('-'), 0);
    {$WARN IMPLICIT_STRING_CAST_LOSS ON}

    strItens := '';

    While (Not qryItens.Eof) Do
    Begin
      strItens := strItens + qryItens.FieldByName('CODITE').AsString + ' ';
      strItens := strItens + qryItens.FieldByName('DESITE').AsString + fDarumaSaltar1;
      strItens := strItens + fRetTextoMarcaEOuCodFab(qryItens);
      strItens := strItens + fstrEspaco('', 5) +
                             fPadL(FloatToStrF(qryItens.FieldByName('QTDITE').AsFloat, ffNumber, 12, 2), 16) + '  ' +
                             fPadL(qryItens.FieldByName('UNIDAD').AsString, 3) + ' ' +
                             fPadL(FloatToStrF(qryItens.FieldByName('UNITAR').AsFloat, ffNumber, 12, 2), 10) + ' ' +
                             fPadL(FloatToStrF(qryItens.FieldByName('TOTITE').AsFloat, ffNumber, 12, 2), 10);

      fltTotQtdIte := fltTotQtdIte + qryItens.FieldByName('QTDITE').AsFloat;

      If (qryItens.RecNo Mod 10 = 0) Or (qryItens.RecNo = qryItens.RecordCount) Then
      Begin
        If qryItens.RecNo = qryItens.RecordCount Then
          strItens := strItens + fDarumaRiscarL('-');

        {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
        iImprimirTexto_DUAL_DarumaFramework(strItens, 0);
        {$WARN IMPLICIT_STRING_CAST_LOSS ON}
        strItens := '';
      End
      Else
         strItens := strItens + fDarumaSaltar1;

      qryItens.Next;
    End;

    strSubTotal := fDarumaNegrito('TOTAL DOS PRODUTOS R$:' + fPadL(FloatToStrF(qryItens.FieldByName('TOTPRO').AsFloat, ffNumber, 12, 2), 26), fDarumaSaltar1) +
                   fDarumaNegrito('TOTAL DE DESCONTOS R$:' + fPadL(FloatToStrF(qryItens.FieldByName('DESESP').AsFloat, ffNumber, 12, 2), 26), fDarumaSaltar1) +
                   fDarumaNegrito('TOTAL DO DOCUMENTO R$:' + fPadL(FloatToStrF(qryItens.FieldByName('VLRCON').AsFloat, ffNumber, 12, 2), 26), fDarumaSaltar1);

   {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
   iImprimirTexto_DUAL_DarumaFramework(strSubTotal, 0);
   {$WARN IMPLICIT_STRING_CAST_LOSS ON}
  End;


  If Not fEmptyStr(strVencimentos) Then
  Begin
   {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
   iImprimirTexto_DUAL_DarumaFramework(fDarumaNegrito('CONDIÇÃO DE PAGAMENTO', fDarumaSaltar1) +
                                       fDarumaNegrito('VENCIMENTO VALOR DA PARCELA', fDarumaSaltar1) +
                                       strVencimentos, 0);
   {$WARN IMPLICIT_STRING_CAST_LOSS ON}
  End;

  If (fStatusCndPag(dadosCupom.strConPag) <> A_VISTA) Then
    strMensagem := fCfgSisL('MPRAF8')
  Else
    strMensagem := fCfgSisL('MVISF8');

  {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
  iImprimirTexto_DUAL_DarumaFramework(strMensagem, 0);
  {$WARN IMPLICIT_STRING_CAST_LOSS ON}

  strMsg001 := '';
  strMsg002 := '';

  If (stlMen001.Count > 0) Or (stlMen002.Count > 0) Then
  Begin
    For intContador := 0 To stlMen001.Count -1 Do
      strMsg001 := strMsg001 + stlMen001[intContador] + #13#10;

    For intContador := 0 To stlMen002.Count -1 Do
      strMsg002 := strMsg002 + stlMen002[intContador] + #13#10;
  End;

  If Not fEmptyStr(strMsg001) Then
  Begin
    {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
    iImprimirTexto_DUAL_DarumaFramework(strMsg001, 0);
    {$WARN IMPLICIT_STRING_CAST_LOSS ON}
  End;

  If Not fEmptyStr(strMsg002) Then
  Begin
    {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
    iImprimirTexto_DUAL_DarumaFramework(strMsg001, 0);
    {$WARN IMPLICIT_STRING_CAST_LOSS ON}
  End;

  {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
  iImprimirTexto_DUAL_DarumaFramework(fDarumaSaltar1 + fDarumaSaltar1 + fDarumaSaltar1 + fDarumaSaltar1 + fDarumaSaltar1 + fDarumaSaltar1 +
                                      fDarumaRiscarL('-', fDarumaSaltar1) +
                                      fDarumaCentral(fDarumaNegrito('Assinatura'), fDarumaSaltarN(6) + fDarumaGuilhot), 0);
  {$WARN IMPLICIT_STRING_CAST_LOSS ON}

  FreeAndNil(qryItens);
end;

function TfrmQckFatImpNFCe.fGetInfComplementar(qryItens: TUniQuery; strQuebra: String; strDadCli: String = ''): String;
begin
  Result := '';
  If fCfgSis('VENDAD', VarBoolean) Then
  Begin
    If fCfgSis('AUTCEN', VarBoolean) Then
    Begin
      Result := Result + 'Vendedor: ' + qryItens.FieldByName('NOMVEN').AsString + strQuebra;
    End
    Else
      Result := Result + 'Vendedor: ' + qryItens.FieldByName('CODVEN').AsString + ' - ' +
                                        qryItens.FieldByName('NOMVEN').AsString + strQuebra;
  End;

  If (Not fEmptyStr(qryItens.FieldByName('CODDIG').AsString)) Then
  Begin
    If fCfgSis('AUTCEN', VarBoolean) Then
    Begin
      Result := Result + 'Operador: ' + qryItens.FieldByName('NOMDIG').AsString + strQuebra;
    End
    Else
      Result := Result + 'Operador: ' + qryItens.FieldByName('CODDIG').AsString + ' - ' +
                                        qryItens.FieldByName('NOMDIG').AsString + strQuebra;
  End;

  Result := Result + 'Cliente: ' + qryItens.FieldByName('CODCLI').AsString + ' - ' + qryItens.FieldByName('NOMCON').AsString + strQuebra;
  Result := Result + 'Telefone: ' + qryItens.FieldByName('CELCON').AsString + strQuebra;

  if not fEmptyStr(strDadCli) then
    Result := Result + strDadCli;

  Result := Result + 'IF: ' + qryItens.FieldByName('NUMDOC').AsString + strQuebra;

  If Not fEmptyStr(qryItens.FieldByName('MEN001').AsString) Then
    Result := Result + qryItens.FieldByName('MEN001').AsString + strQuebra;

  If Not fEmptyStr(qryItens.FieldByName('MEN002').AsString) Then
    Result := Result + qryItens.FieldByName('MEN002').AsString + strQuebra;

  If Not fEmptyStr(qryItens.FieldByName('MEN003').AsString) Then
    Result := Result + qryItens.FieldByName('MEN003').AsString + strQuebra;

  If Not fEmptyStr(qryItens.FieldByName('MEN004').AsString) Then
    Result := Result + qryItens.FieldByName('MEN004').AsString + strQuebra;

  If Not fEmptyStr(qryItens.FieldByName('MEN005').AsString) Then
    Result := Result + qryItens.FieldByName('MEN005').AsString + strQuebra;

  If fCfgSis('ORGDFI', varBoolean) Then
  Begin
    If Not fEmptyStr(fCfgSis('ENDPRC')) Then
    Begin
      Result := Result + 'PROCON-'+qryItens.FieldByName('ESTEMP').AsString+': ' + fCfgSis('ENDPRC') + strQuebra;
      Result := Result + 'TEL: ' + fCfgSis('TELPRC') + strQuebra;
    End;

    If Not fEmptyStr(fCfgSis('ENDALE')) Then
    Begin
      Result := Result + 'ALERJ: ' + fCfgSis('ENDALE') + strQuebra;
      Result := Result + 'TEL: ' + fCfgSis('TELALE') + strQuebra;
    End;
  End;

  If qryItens.FieldByName('PESBRU').asFloat > 0 Then
    Result := Result + 'PESO BRUTO: ' + FloatToStrF(qryItens.FieldByName('PESBRU').AsFloat, ffNumber, 12, 2) + strQuebra;

  If Not fEmptyStr(fCfgSis('MSGNFC')) Then
    Result := Result + fCfgSis('MSGNFC') + #13#10;

  If Not fEmptyStr(fCfgSis('IADNFC')) Then
    Result := Result + fCfgSis('IADNFC') + #13#10;

  If fCfgSis('NUMRAN', varBoolean) Then
    Result := Result + fCfgSis('MSGRAN', varString) + ' ' + FormatMaskText('999.999999;0;_', qryItens.FieldByName('NUMRAN').AsString) + #13#10;

  If Not fEmptyStr(qryItens.FieldByName('PRTMSG').AsString) Then
    Result := Result + qryItens.FieldByName('PRTMSG').AsString + strQuebra;

  If Not fEmptyStr(qryItens.FieldByName('NUMPED').AsString) Then
    Result := Result + 'PED.DE VENDA: '+ qryItens.FieldByName('NUMPED').AsString + strQuebra;
end;

function TfrmQckFatImpNFCe.fGetLayoutImpressaoEspelhoCartaoVinculado(AEspecieDocumento, AEmpresaDocumento: string): TfrxReport;
Var LQuery : TUniQuery;
begin
  Result := frxCartaoVinculadoJ;

  LQuery := fCriaQuery;
  Try
    LQuery.Sql.Text := ' SELECT LAY_TIPIMP '+
                       '  FROM LAYETI '+
                       ' WHERE LAY_CODEMP = :CODEMP '+
                       '   AND LAY_TIPLAY = :TIPLAY '+
                       '   AND LAY_PADRAO = ''S'' ';
    LQuery.ParamByName('CODEMP').AsString  := AEmpresaDocumento;
    LQuery.ParamByName('TIPLAY').AsInteger := IIF(AEspecieDocumento = 'NF', 56, 57);
    LQuery.Open;
    if not LQuery.IsEmpty then
    begin
      If LQuery.FieldByName('LAY_TIPIMP').AsString = 'M' then
        Result := frxCartaoVinculadoM
      Else
        Result := frxCartaoVinculadoJ;
    end;
    LQuery.Close;
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TfrmQckFatImpNFCe.fiImprimirTexto_DUAL_DarumaFramework(
  strTexto: AnsiString; intTam: Integer): Integer;
begin
  {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
  Result := iImprimirTexto_DUAL_DarumaFramework(AnsiString(fTiraCaracEspeciais(String(strTexto), False, False, False, False, False, False)), intTam);
  {$WARN IMPLICIT_STRING_CAST_LOSS ON}
end;

function TfrmQckFatImpNFCe.fNumeroDoItem: String;
begin
  Result := IntToStr(frxDbNFce.RecNo+1);
end;

function fRetornaChaveAcesso(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strSerie, strTip_FC: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  FIS_ACESSO, ');
  qryAux.SQL.Add('  FIS_NUMSER ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADFIS ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  FIS_FORCLI = :FORCLI AND ');
  qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ AND ');
  qryAux.SQL.Add('  FIS_TIP_FC = :TIP_FC ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('FORCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
  qryAux.Open;

  Result := qryAux.FieldByName('FIS_ACESSO').AsString;

  FreeAndNil(qryAux);
end;

function TfrmQckFatImpNFCe.fRetTextoMarcaEOuCodFab(qry: TUniQuery): String;
  Var
    strMarcasAux: String;
    strCodFabAux: String;
begin
  Result := '';

  If (blnImpMarcas Or blnImpCodFab) Then
  Begin
    strMarcasAux := IIF(blnImpMarcas And (Not fEmptyStr(qry.FieldByName('DESMAR').Text)), qry.FieldByName('DESMAR').Text, '');
    strCodFabAux := IIF(blnImpCodFab And (Not fEmptyStr(qry.FieldByName('CODFAB').Text)), qry.FieldByName('CODFAB').Text, '');

    If (Not fEmptyStr(strMarcasAux + strCodFabAux)) Then
    Begin
      If (Not fEmptyStr(strMarcasAux)) Then
        Result := Result + fPadR('Marca: ' + strMarcasAux, 24);

      If (Not fEmptyStr(strCodFabAux)) Then
        Result := Result + fPadR('Cód.Fáb.: ' + strCodFabAux, 24);

      Result := fPadR(Result, 48) + fDarumaSaltar1;
    End;
  End;
end;

procedure TfrmQckFatImpNFCe.frxDataSetCarnePgtoCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin
  Eof := intIndiceDuplic = Length(FDuplic);
end;

procedure TfrmQckFatImpNFCe.frxDataSetCarnePgtoFirst(Sender: TObject);
begin
  intIndiceDuplic := 0;
end;

procedure TfrmQckFatImpNFCe.frxDataSetCarnePgtoGetValue(const VarName: string;
  var Value: Variant);
begin

  If AnsiUpperCase(VarName) = 'DUPLICATA1' Then
  Begin

     If blnExibeDtaCad Then
     Begin
        Value := fPadC(FDuplic[intIndiceDuplic].strDtaCad, 08) + ' ' +
                 fPadR(FDuplic[intIndiceDuplic].strSequen, 03) + ' ' +
                 fPadC(FDuplic[intIndiceDuplic].strDtaVen, 10);
     End
     Else
     Begin
        Value := fPadR(FDuplic[intIndiceDuplic].strSequen, 03) + ' ' +
                 fPadC(FDuplic[intIndiceDuplic].strDtaVen, 10) + ' ' +
                 fPadL(FDuplic[intIndiceDuplic].strValDup, 10);
     End;

  End
  Else If AnsiUpperCase(VarName) = 'DUPLICATA2' Then
  Begin

     If blnExibeDtaCad Then
     Begin
        Value := fPadL(FDuplic[intIndiceDuplic].strValDup, 10) + ' ' +
                 fPadC(FDuplic[intIndiceDuplic].strDtaRec, 08) + ' ' +
                 fPadL(FDuplic[intIndiceDuplic].strValRec, 10);
     End
     Else
     Begin
        Value := fPadC(FDuplic[intIndiceDuplic].strDtaRec, 08) + ' ' +
                 fPadL(FDuplic[intIndiceDuplic].strValRec, 10);
     End;

  End
  Else If AnsiUpperCase(VarName) = 'CODIGO_BARRAS' Then
  Begin
    Value := FBarCon;
  End;
end;

procedure TfrmQckFatImpNFCe.frxDataSetCarnePgtoNext(Sender: TObject);
begin
  Inc(intIndiceDuplic);
end;

function TfrmQckFatImpNFCe.frxSATCFeUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  Result := Null;
  If AnsiUpperCase(MethodName) = AnsiUpperCase('fNumeroDoItem') Then
  Begin
    Result := fNumeroDoItem;
  End
  Else If AnsiUpperCase(MethodName) = AnsiUpperCase('fArredondaUnit') Then
  Begin
    Result := fArredondaUnit(Params[0]);
  End;
end;

function TfrmQckFatImpNFCe.fArredondaUnit(strCampo: String): String;
begin
  Result := FloatToStr(fFormataFloat(frxDbNFce.DataSet.FieldByName(strCampo).AsFloat, 2));
end;

function TfrmQckFatImpNFCe.fCadEmpNomeEmpresa: String;
begin
  If (fCfgSis('RSNFNC') = 'F') Then
    Result := fCadEmp('NOMFAN')
  Else
    Result := fCadEmp('NOMEMP')
end;

function TfrmQckFatImpNFCe.fConsumidorIdentificado(qryItens: TUniQuery): Boolean;
begin
  Result := (Not fEmptyStr(qryItens.FieldByName('CGCCON').AsString)) And
            (Not fStringRepetida(qryItens.FieldByName('CGCCON').AsString)) And
            (fTestaCgc(qryItens.FieldByName('CGCCON').AsString) Or
             fValidaCPF(qryItens.FieldByName('CGCCON').AsString));
end;

function TfrmQckFatImpNFCe.fDarumaAguarda: String;
begin
  Result := '<a></a>';
end;

function TfrmQckFatImpNFCe.fDarumaCentral(strConteudo,
  strCmdAdicional: String): String;
begin
  Result := '<ce>'+strConteudo+'</ce>'+strCmdAdicional;
end;

function TfrmQckFatImpNFCe.fDarumaGuilhot: String;
begin
  Result := '<gui></gui>';
end;

function TfrmQckFatImpNFCe.fDarumaNegrito(strConteudo,
  strCmdAdicional: String): String;
begin
  Result := '<b>'+strConteudo+'</b>'+strCmdAdicional;
end;

function TfrmQckFatImpNFCe.fDarumaQrCode_(strConteudoQrCd: String): String;
begin
  Result := '<qrcode>'+strConteudoQrCd+'</qrcode>';
end;

function TfrmQckFatImpNFCe.fDarumaRiscarL(strCaracter: String='-';
  strCmdAdicional: String=''): String;
begin
  Result := '<tc>'+strCaracter+'</tc>'+strCmdAdicional;
end;

function TfrmQckFatImpNFCe.fDarumaSaltar1: String;
begin
  Result := '<l></l>';
end;

function TfrmQckFatImpNFCe.fDarumaSaltarN(intNumeroLinhas: Integer): String;
begin
  Result := '<sl>'+IntToStr(intNumeroLinhas)+'</sl>';
end;

function TfrmQckFatImpNFCe.fDarumaTModulo(intTamanhoModul: Integer): String;
begin
  Result := '<lmodulo>'+IntToStr(intTamanhoModul)+'</lmodulo>';
end;

procedure TfrmQckFatImpNFCe.pImprimirDanfeNFCe(strNumDoc,
                            strEspDoc,
                            strCodEmp,
                            strCodCli,
                            strSerie,
                            strTip_FC: String;
                            strImpressora: String='';
                            blnGerarPDF: Boolean = False;
                            strAcesso: string = '';
                            blnMostrarPreviewQuandoPDF : Boolean = True;
                            strPath : String = '';
                            intQtdVias : Integer = -1;
                            blnGerandoParaDisparoDeGatilho: Boolean = False);
  Const
    QrCodePeq = 100;
    QrCodeMed = 130;
    QrCodeGrd = 160;
  Var
    qryItens: TUniQuery;
    strNomImp: String;
    strModalidades: String;
    strValores: String;
    bmpQrCode: TBitmap;
    strEnderecoEntrega,
    strEnderecoConsumidor: String;
    stream: TMemoryStream;
    frxQrCode: TfrxPictureView;
    intTentativas: Integer;
    strImpostos: String;
    blnExecute : Boolean;
    intQtdNps : Integer;
    i: Integer;
    strDirLogo : String;
    fltTopLocFis: Double;
    LDiretorioDanfe: String;

  function fImprimirEnderecoDeEntrega: Boolean;
  begin
    Result := (fCfgSis('ENTNFC')='S');
  end;

  function fImprimirEnderecoEntregaItensEntrega: Boolean;
  begin
    Result := ((qryItens.FieldByName('ENTRET').asString='E') Or (qryItens.FieldByName('ENTRET').asString='F'));
  end;

  function fImprimirEnderecoEntregaItensRetira: Boolean;
  begin
    Result := ((qryItens.FieldByName('ENTRET').asString='R') And (fCfgSis('ENDRET')='S'));
  end;

  function fContingencia(strAcesso: String): Boolean;
  begin
    Result := StrToIntDef(Copy(strAcesso, 35, 1), 0) In [4,6,7,9];
  end;

begin
  qryItens := fCriaQuery(Self);
  pCarregaDados(qryItens);

  TfrxReportPage(frxNFCe.FindObject('Page1')).LeftMargin := fStrToFloat(fArqIniLocal(0, 'NFCE', 'MARGEM', '0', fCfgSis('PTNFCE') + '\opcoes_nfce.ini')) * 10;

  qryItens.ParamByName('NUMDOC').AsString := strNumDoc;
  qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
  qryItens.ParamByName('CODEMP').AsString := strCodEmp;
  qryItens.ParamByName('CODCLI').AsString := strCodCli;
  qryItens.ParamByName('TIP_FC').AsString := strTip_FC;
  qryItens.ParamByName('SERIE_').AsString := strSerie;
  qryItens.Open;

  frxNFCe.Script.Variables['PROFIS'] := fCfgSis('PROFIS', varString) + ':';
  frxNFCe.Script.Variables['CODDIV'] := qryItens.FieldByName('CODDIV').AsString;
  frxNFCe.Script.Variables['NOMDIV'] := qryItens.FIeldByName('NOMDIV').AsString;

  if (fCfgSis('NFCADC', VarBoolean)) and (not fEmptyStr(qryItens.FieldByName('CODDIV').AsString)) then
  begin
    TfrxChild(frxNFCe.FindObject('ChdContribuinte')).Height  := 2.20;
    TfrxMemoView(frxNFCe.FindObject('rllProfissional')).Visible := True;
  end
  else
  begin
    frxNFCe.Script.Variables['PROFIS'] := '';
    frxNFCe.Script.Variables['CODDIV'] := '';
    frxNFCe.Script.Variables['NOMDIV'] := '';
    TfrxMemoView(frxNFCe.FindObject('rllProfissional')).Visible := False;
    TfrxMemoView(frxNFCe.FindObject('rllProfissional')).Top := 1.03;
    TfrxChild(frxNFCe.FindObject('ChdContribuinte')).Height := 1.60;
  end;

  pCarregaModalidadesPagamento(qryItens.FieldByName('VLRCON').AsFloat,
    strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strModalidades, strValores);

  TfrxChild(frxNFCe.FindObject('ChdLogo')).Visible := False;

  If (fCfgSis('LOGNFC', VarBoolean)) Then
  Begin
    strDirLogo := fCfgSis('PTLNFC');
    If (Not fEmptyStr(strDirLogo)) And (FileExists(strDirLogo)) Then
    Begin
      TfrxChild(frxNFCe.FindObject('ChdLogo')).Visible := True;
      TfrxPictureView(frxNFCe.FindObject('rllImagem')).Picture.LoadFromFile(strDirLogo);
    End;
  End;

  If fCfgSis('NFEMAR', VarBoolean) Or fCfgSis('NFEFAB', VarBoolean) Then
  begin
    TfrxMasterData(frxNFCe.FindObject('MasterData1')).Visible := False;
    TfrxMasterData(frxNFCe.FindObject('MasterData2')).Visible := True;

    TfrxChild(frxNFCe.FindObject('chdCompec1')).Visible := False;
    TfrxChild(frxNFCe.FindObject('chdCompec2')).Visible := IIF( fCfgSis('NFECOM') = 'S', True, False);

    If (fCfgSis('NFEFAB', VarBoolean)) And (Not fCfgSis('NFEMAR', VarBoolean)) Then
      TfrxMemoView(frxNFCe.FindObject('MemoCodFab')).Left := TfrxMemoView(frxNFCe.FindObject('memo5')).Left;

    If fCfgSis('NFEMAR', VarBoolean) Then
      TfrxMemoView(frxNFCe.FindObject('MemoMarca')).Visible := True
    Else
      TfrxMemoView(frxNFCe.FindObject('MemoMarca')).Visible := False;

    If fCfgSis('NFEFAB', VarBoolean) Then
      TfrxMemoView(frxNFCe.FindObject('MemoCodFab')).Visible := True
    Else
      TfrxMemoView(frxNFCe.FindObject('MemoCodFab')).Visible := False;

    if not fCfgSis('NFCLOC', VarBoolean) then
    begin
      If fCfgSis('NFEMAR', VarBoolean) Or fCfgSis('NFEFAB', VarBoolean) Then
        fltTopLocFis := TfrxMemoView(frxNFCe.FindObject('memLocFis2')).Top
      Else
        fltTopLocFis := TfrxMemoView(frxNFCe.FindObject('memLocFis2')).Top - TfrxMemoView(frxNFCe.FindObject('MemoMarca')).Height;
      TfrxMemoView(frxNFCe.FindObject('memLocFis2')).Visible := False;

      If not fCfgSis('NFEMAR', VarBoolean) and fCfgSis('NFEFAB', VarBoolean) Then
      begin
        TfrxMemoView(frxNFCe.FindObject('memQtdIte2')).Top := fltTopLocFis - 2;
        TfrxMemoView(frxNFCe.FindObject('memUnidad2')).Top := fltTopLocFis - 2;
      end
      else
      begin
        TfrxMemoView(frxNFCe.FindObject('memQtdIte2')).Top := fltTopLocFis;
        TfrxMemoView(frxNFCe.FindObject('memUnidad2')).Top := fltTopLocFis;
      end;

      TfrxMemoView(frxNFCe.FindObject('memUnitar2')).Top := fltTopLocFis;
      TfrxMemoView(frxNFCe.FindObject('memTotIte2')).Top := fltTopLocFis;
    end;

    if fCfgSis('NFDESC', varBoolean) And qryItens.FieldByName('DESESP').AsFloat > 0 then
    begin
        if not fCfgSis('NFCLOC', VarBoolean) then
          TfrxMemoView(frxNFCe.FindObject('memDesEspVal2')).Top := 40
        else
          TfrxMemoView(frxNFCe.FindObject('memDesEspVal2')).Top := 55;

      TfrxMemoView(frxNFCe.FindObject('memDesEspVal2')).Visible := True;
    end
    else
    begin
      TfrxMemoView(frxNFCe.FindObject('memDesEspVal2')).Top := TfrxMemoView(frxNFCe.FindObject('memTotIte2')).Top;
      TfrxMemoView(frxNFCe.FindObject('memDesEspVal2')).Visible := False;
    end;
  end
  Else
  begin
    TfrxMasterData(frxNFCe.FindObject('MasterData2')).Visible := False;
    TfrxMasterData(frxNFCe.FindObject('MasterData1')).Visible := True;

    TfrxChild(frxNFCe.FindObject('chdCompec2')).Visible := False;
    TfrxChild(frxNFCe.FindObject('chdCompec1')).Visible := IIF( fCfgSis('NFECOM') = 'S', True, False);

    if not fCfgSis('NFCLOC', VarBoolean) then
    begin
      fltTopLocFis := TfrxMemoView(frxNFCe.FindObject('memLocFis1')).Top;
      TfrxMemoView(frxNFCe.FindObject('memLocFis1')).Visible := False;
      TfrxMemoView(frxNFCe.FindObject('memQtdIte1')).Top := fltTopLocFis;
      TfrxMemoView(frxNFCe.FindObject('memUnidad1')).Top := fltTopLocFis;
      TfrxMemoView(frxNFCe.FindObject('memUnitar1')).Top := fltTopLocFis;
      TfrxMemoView(frxNFCe.FindObject('memTotIte1')).Top := fltTopLocFis;
    end;

    if fCfgSis('NFDESC', varBoolean) And qryItens.FieldByName('DESESP').AsFloat > 0 then
    begin
      if not fCfgSis('NFCLOC', VarBoolean) then
        TfrxMemoView(frxNFCe.FindObject('memDesEspVal1')).Top := 25
      else
        TfrxMemoView(frxNFCe.FindObject('memDesEspVal1')).Top := 40;
      TfrxMemoView(frxNFCe.FindObject('memDesEspVal1')).Visible := True;
    end
    else
    begin
      TfrxMemoView(frxNFCe.FindObject('memDesEspVal1')).Top := TfrxMemoView(frxNFCe.FindObject('memTotIte1')).Top;
      TfrxMemoView(frxNFCe.FindObject('memDesEspVal1')).Visible := False;
    end;
  end;

  if fCfgSis('DESNFC') = '2' then
  Begin
    if TfrxMasterData(frxNFCe.FindObject('MasterData1')).Visible then
    begin
      TfrxMemoView(frxNFCe.FindObject('memUnitar1')).Text := '[<frxNFce."UNIORI">]';
      TfrxMemoView(frxNFCe.FindObject('memTotIte1')).Text := '[<frxNFce."UNIORI"> * <frxNFce."QTDITE">]';
      TfrxMemoView(frxNFCe.FindObject('memo28')).Text := '[SUM(<frxNFce."QTDITE">*<frxNFce."UNIORI">,MasterData1,2)]';
      TfrxMemoView(frxNFCe.FindObject('memo30')).Text := '[SUM( ((<frxNFce."UNIORI">-<frxNFce."UNITAR">)*<frxNFce."QTDITE">),MasterData1,2 ) + <frxNFce."DESESP">]';
    end;
    if TfrxMasterData(frxNFCe.FindObject('MasterData2')).Visible then
    begin
      TfrxMemoView(frxNFCe.FindObject('memUnitar2')).Text := '[<frxNFce."UNIORI">]';
      TfrxMemoView(frxNFCe.FindObject('memTotIte2')).Text := '[<frxNFce."UNIORI"> * <frxNFce."QTDITE">]';
      TfrxMemoView(frxNFCe.FindObject('memo28')).Text := '[SUM(<frxNFce."QTDITE">*<frxNFce."UNIORI">,MasterData2,2)]';
      TfrxMemoView(frxNFCe.FindObject('memo30')).Text := '[SUM( ((<frxNFce."UNIORI">-<frxNFce."UNITAR">)*<frxNFce."QTDITE">),MasterData2,2 ) + <frxNFce."DESESP">]';
    end;
  End;

  frxNFCe.Script.Variables['NOMEMP'] := qryItens.FieldByName('NOMEMP').AsString;
  frxNFCe.Script.Variables['CNPJ']   := fFormataCpfCgc(qryItens.FieldByName('C_G_C_').AsString, opcBrasil);
  frxNFCe.Script.Variables['IE']     := qryItens.FieldByName('I_E_S_').AsString;
  frxNFCe.Script.Variables['IM']     := qryItens.FieldByName('INSMUN').AsString;
  frxNFCe.Script.Variables['ENDEMP'] := qryItens.FieldByName('ENDEMP').AsString;
  frxNFCe.Script.Variables['CEPEMP'] := fFormataCEP(AnsiReplaceStr(qryItens.FieldByName('CEPEMP').AsString, '-', ''));
  frxNFCe.Script.Variables['TELEMP'] := fFormataFone(qryItens.FieldByName('TELEMP').AsString) +
                                        IIF(Not fEmptyStr(qryItens.FieldByName('TELEM2').AsString), ' / ' + fFormataFone(qryItens.FieldByName('TELEM2').AsString), '');
  frxNFCe.Script.Variables['NUMDOC'] := qryItens.FieldByName('NUMDOC').AsString;
  frxNFCe.Script.Variables['SERIE_'] := qryItens.FieldByName('SERIE_').AsString;
  frxNFCe.Script.Variables['DTAEMI'] := FormatDateTime('dd/mm/yyyy', qryItens.FieldByName('DTAENT').AsDateTime) + ' ' + FormatDateTime('hh:mm:ss', qryItens.FieldByName('HORENT').AsDateTime);
  frxNFCe.Script.Variables['ACESSO'] := fTransform(qryItens.FieldByName('ACESSO').AsString, 4, ' ');
  frxNFCe.Script.Variables['PROTOC'] := qryItens.FieldByName('PROTOC').AsString;
  frxNFCe.Script.Variables['DPROTO'] := FormatDateTime('dd/mm/yyyy hh:nn:ss', qryItens.FieldByName('DPROTO').AsDateTime);

  frxNFCe.Script.Variables['INF_COMPLEMENTAR'] := fGetInfComplementar(qryItens, #13#10);

  If Assigned(TfrxChild(frxNFCe.FindObject('chdNumCup'))) Then
    frxNFCe.FindObject('chdNumCup').Visible := not fEmptyStr(qryItens.FieldByName('NUMCUP').AsString);

  If (fStatusCndPag(qryItens.FieldByName('CONPAG').AsString) = A_VISTA) Then
    frxNFCe.Script.Variables['CONDICAO_PAGAMENTO'] := 'A VISTA'
  Else
    frxNFCe.Script.Variables['CONDICAO_PAGAMENTO'] := fFormataCondPag(qryItens.FieldByName('CONPAG').AsString);

  frxNFCe.Script.Variables['MODALIDADES'] := strModalidades;
  frxNFCe.Script.Variables['VALORES_MOD'] := strValores;

  strImpostos := '';
  If fCfgSis('IMPPAG', VarInteger) = 1 Then
  Begin
    frxNFCe.Script.Variables['TOTAL_TRIBUTOS'] := FloatToStrF(qryItens.FieldByName('IMPPAG').AsFloat, ffNumber, 12, 2);
  End
  Else
  Begin
    If qryItens.FieldByName('FEDIMP').AsFloat + qryItens.FieldByName('ESTIMP').AsFloat + qryItens.FieldByName('MUNIMP').AsFloat = 0 Then
    Begin
      frxNFCe.Script.Variables['TOTAL_TRIBUTOS'] := '0,00';
    End
    Else
    Begin
      If qryItens.FieldByName('FEDIMP').AsFloat <> 0 Then
        strImpostos := strImpostos + FloatToStrF(qryItens.FieldByName('FEDIMP').AsFloat, ffNumber, 12, 2) + ' Fed';

      If qryItens.FieldByName('ESTIMP').AsFloat <> 0 Then
        strImpostos := strImpostos + '/' + FloatToStrF(qryItens.FieldByName('ESTIMP').AsFloat, ffNumber, 12, 2) + ' Est';

      If qryItens.FieldByName('MUNIMP').AsFloat <> 0 Then
        strImpostos := strImpostos + '/' + FloatToStrF(qryItens.FieldByName('MUNIMP').AsFloat, ffNumber, 12, 2) + ' Mun';

      frxNFCe.Script.Variables['TOTAL_TRIBUTOS'] := strImpostos + '/ Fonte:IBPT.';
    End;
  End;

  frxNFCe.Script.Variables['TROCO_'] := FloatToStrF(qryItens.FieldByName('TROCO_').AsFloat, ffNumber, 12, 2);

  If qryItens.FieldByName('TROCO_').AsFloat = 0 Then
  Begin
    TfrxMemoView(frxNFCe.FindObject('rllTroco')).Visible := False;
    TfrxMemoView(frxNFCe.FindObject('rllValTroco')).Visible := False;
    TfrxChild(frxNFCe.FindObject('Child3')).Height := 0.4;
  End;

  If qryItens.FieldByName('TOTFRE').AsFloat = 0 Then
  Begin
    TfrxChild(frxNFCe.FindObject('ChildTotFre')).Visible := False;
  End;

  If qryItens.FieldByName('DESACE').AsFloat = 0 Then
  Begin
    TfrxChild(frxNFCe.FindObject('ChildDesAce')).Visible := False;
  End;

  If qryItens.FieldByName('TOTRET').AsFloat = 0 Then
  Begin
    TfrxChild(frxNFCe.FindObject('ChildTotRet')).Visible := False;
  End;

  If qryItens.FieldByName('TOTIPI').AsFloat = 0 Then
  Begin
    TfrxChild(frxNFCe.FindObject('ChildTotIpi')).Visible := False;
  End;

  TfrxChild(frxNFCe.FindObject('Child9')).Visible := fUrlAmbienteHomologacao;

  If (fCfgSis('UTINPS', varBoolean)) And (strTip_FC = 'C') Then
    fGanhouNetpoints(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, intQtdNps)
  Else
    intQtdNps := 0;

  frxNFCe.Script.Variables['QTDNPS'] := IntToStr(intQtdNps);
  TfrxChild(frxNFCe.FindObject('ChdNetpoints')).Visible := (intQtdNps > 0);

  TfrxMemoView(frxNFCe.FindObject('rllConsumidor')).Memo.Clear;

  If fConsumidorIdentificado(qryItens) Then
  Begin
    If fTestaCgc(qryItens.FieldByName('CGCCON').AsString) Then
      TfrxMemoView(frxNFCe.FindObject('rllConsumidor')).Memo.Add('CNPJ: ' + fFormataCpfCgc(qryItens.FieldByName('CGCCON').AsString, opcBrasil))
    Else
      TfrxMemoView(frxNFCe.FindObject('rllConsumidor')).Memo.Add('CPF: '  + fFormataCpfCgc(qryItens.FieldByName('CGCCON').AsString, opcBrasil));

    If Not fEmptyStr(qryItens.FieldByName('NOMCON').AsString) Then
    Begin
      TfrxMemoView(frxNFCe.FindObject('rllConsumidor')).Memo.Add(qryItens.FieldByName('NOMCON').AsString +
                        IIF(fCfgSis('CCLNFE', varBoolean), ' ' + qryItens.FieldByName('CODCLI').AsString, ''));

      If Not fEmptyStr(qryItens.FieldByName('ENDERE').AsString) Then
      Begin
        strEnderecoConsumidor := qryItens.FieldByName('ENDERE').AsString + ', ';

        If Not fEmptyStr(qryItens.FieldByName('ENDNUM').AsString) Then
          strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('ENDNUM').AsString + ', ';

        If Not fEmptyStr(qryItens.FieldByName('ENDCOM').AsString) Then
          strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('ENDCOM').AsString + ', ';

        If Not fEmptyStr(qryItens.FieldByName('BAICON').AsString) Then
          strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('BAICON').AsString + ', ';

        strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('CIDCON').AsString + ', ';
        strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('ESTCON').AsString;

        TfrxMemoView(frxNFCe.FindObject('rllConsumidor')).Memo.Add(strEnderecoConsumidor);
      End;

      If Not fEmptyStr(qryItens.FieldByName('TELCON').AsString) Then
        TfrxMemoView(frxNFCe.FindObject('rllConsumidor')).Memo.Add('TELEFONE: ' + fFormataFone(qryItens.FieldByName('TELCON').AsString));

      If Not fEmptyStr(qryItens.FieldByName('CELCON').AsString) Then
        TfrxMemoView(frxNFCe.FindObject('rllConsumidor')).Memo.Add('CELULAR: ' + fFormataFone(qryItens.FieldByName('CELCON').AsString));

      If (fImprimirEnderecoDeEntrega) And
         (fImprimirEnderecoEntregaItensRetira Or fImprimirEnderecoEntregaItensEntrega) Then
      Begin
        If Not fEmptyStr(qryItens.FieldByName('ENDENT').AsString) Then
          strEnderecoEntrega := 'END.P/ENTREGA: ' + qryItens.FieldByName('ENDENT').AsString;

        If Not fEmptyStr(qryItens.FieldByName('BAIENT').AsString) Then
          strEnderecoEntrega := strEnderecoEntrega + ', ' + qryItens.FieldByName('BAIENT').AsString;

        If Not fEmptyStr(qryItens.FieldByName('CEPENT').AsString) then
          strEnderecoEntrega := strEnderecoEntrega + ', ' + qryItens.FieldByName('CEPENT').AsString;

        If Not fEmptyStr(qryItens.FieldByName('CIDENT').AsString) then
          strEnderecoEntrega := strEnderecoEntrega + ', ' + qryItens.FieldByName('CIDENT').AsString;

        If Not fEmptyStr(qryItens.FieldByName('REFENT').AsString) then
          strEnderecoEntrega := strEnderecoEntrega + ', REF.ENTR: ' + qryItens.FieldByName('REFENT').AsString;

        TfrxMemoView(frxNFCe.FindObject('rllConsumidor')).Memo.Add(strEnderecoEntrega);

        If Not fEmptyStr(qryItens.FieldByName('TELENT').AsString) Then
          TfrxMemoView(frxNFCe.FindObject('rllConsumidor')).Memo.Add('TELEFONE: ' + fFormataFone(qryItens.FieldByName('TELENT').AsString));

      End;

    End;
  End
  Else
  Begin
    TfrxMemoView(frxNFCe.FindObject('rllConsumidor')).Memo.Add('CONSUMIDOR NÃO IDENTIFICADO');
  End;

  TfrxMemoView(frxNFCe.FindObject('rllEnderecoConsulta')).Memo.Add(fNFCeEnderecoDeConsulta(qryItens.FieldByName('ESTEMP').AsString));

  If fContingencia(qryItens.FieldByName('ACESSO').AsString) Then
  Begin
    TfrxChild(frxNFCe.FindObject('ChildContingencia1')).Visible := True;
    TfrxChild(frxNFCe.FindObject('ChildContingencia2')).Visible := True;
    TfrxMemoView(frxNFCe.FindObject('rllAreaMensagemFiscal')).Visible := False;

    TfrxMemoView(frxNFCe.FindObject('rllLabelProtocolo')).Visible := False;
    TfrxMemoView(frxNFCe.FindObject('rllProtocolo')).Visible := False;
  End
  Else
  Begin
    TfrxChild(frxNFCe.FindObject('ChildContingencia1')).Visible := False;
    TfrxChild(frxNFCe.FindObject('ChildContingencia2')).Visible := False;
    TfrxMemoView(frxNFCe.FindObject('rllAreaMensagemFiscal')).Visible := True;
  End;

  TfrxMemoView(frxNFCe.FindObject('rllMensagemAproveitaICMS')).Visible := (fCfgSis('NFCEAC') = 'S');

  TfrxChild(frxNFCe.FindObject('ChdNumGuiche')).Visible := (Not fEmptyStr(qryItens.FieldByName('NUMGUI').AsString));
  TfrxChild(frxNFCe.FindObject('ChdNomeConferente')).Visible := ((fCfgSis('CNFNFC') = 'S') and (Not fEmptyStr(qryItens.FieldByName('OPEEXP').AsString)));

  If Assigned(TfrxChild(frxNFCe.FindObject('ChdNomeSeparador'))) Then
    TfrxChild(frxNFCe.FindObject('ChdNomeSeparador')).Visible := (Not fEmptyStr(qryItens.FieldByName('OPESEP').AsString));

  If fCfgSis('TAMQRC') = 'P' Then
  Begin
    TfrxPictureView(frxNFCe.FindObject('imgQRCode')).Height := QrCodePeq;
    TfrxPictureView(frxNFCe.FindObject('imgQRCode')).Width  := QrCodePeq;
  End
  Else If fCfgSis('TAMQRC') = 'M' Then
  Begin
    TfrxPictureView(frxNFCe.FindObject('imgQRCode')).Height := QrCodeMed;
    TfrxPictureView(frxNFCe.FindObject('imgQRCode')).Width  := QrCodeMed;
  End
  Else If fCfgSis('TAMQRC') = 'G' Then
  Begin
    TfrxPictureView(frxNFCe.FindObject('imgQRCode')).Height := QrCodeGrd;
    TfrxPictureView(frxNFCe.FindObject('imgQRCode')).Width  := QrCodeGrd;
  End;

  frxQrCode := TfrxPictureView(frxNFCe.FindObject('imgQRCode'));

  if fCfgSis('NFCETP', varBoolean) then
  begin
    if frxNFCe.FindObject('rllTotalPago') <> nil then
      TfrxMemoView(frxNFCe.FindObject('rllTotalPago')).Memo.Text := 'TOTAL';
  end;

  TfrxMemoView(frxNFCe.FindObject('memQtdIte1')).DisplayFormat.FormatStr := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TfrxMemoView(frxNFCe.FindObject('memQtdIte2')).DisplayFormat.FormatStr := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TfrxMemoView(frxNFCe.FindObject('memQtdTot')).DisplayFormat.FormatStr  := fMskDigitos(fCfgSis('DECQTD', varInteger));

  if Assigned(TfrxChild(frxNFCe.FindObject('ChildFidelidade'))) then
  begin
    if fCfgSis('NFCFID', varBoolean) Then
    begin
      frxNFCe.Script.Variables['PTOVEN'] := qryItens.FieldByName('PTOVEN').AsFloat;
      frxNFCe.Script.Variables['PTOSLD'] := qryItens.FieldByName('PTOSLD').AsFloat;
      TfrxChild(frxNFCe.FindObject('ChildFidelidade')).Visible := (qryItens.FieldByName('PTOVEN').AsFloat > 0) or
                                                                  (qryItens.FieldByName('PTOSLD').AsFloat > 0);
    end
    else
    begin
      frxNFCe.Script.Variables['PTOVEN'] := 0;
      frxNFCe.Script.Variables['PTOSLD'] := 0;
      TfrxChild(frxNFCe.FindObject('ChildFidelidade')).Visible := False;
    end;
  end;

  intTentativas := 0;

  While True Do
  Begin
    Try
      bmpQrCode := fGerarQRCode(qryItens.FieldByName('QRCODE').AsString);
      Sleep(100);
      //pAjustaBitmap(bmpQrCode, fFloatToInt(frxQrCode.Width), fFloatToInt(frxQrCode.Height));
      Break;
    Except
      On E: Exception Do
      Begin
        Inc(intTentativas);
        If intTentativas > 30 Then
        Begin
          Raise;
        End;
        Sleep(500);
        Application.ProcessMessages;
      End;
    End;
  End;

  stream := TMemoryStream.Create;
  bmpQrCode.SaveToStream(stream);


  frxQrCode.LoadPictureFromStream(stream);
  FreeAndNil(stream);
  FreeAndNil(bmpQrCode);

  frxDbNFce.DataSet := qryItens;

  If fEmptyStr(strImpressora) Then
    strNomImp := fArqIniLocal(0, 'NFCE', fImpressoraKey, '', fCfgSis('PTNFCE') + '\opcoes_nfce.ini')
  Else
    strNomImp := strImpressora;

  strNomImp := fIdentificarNomeDaImpressora(strNomImp);

  blnExecute := True;

  pSalvarDanfe(frxNFCe, qryItens.FieldByName('ACESSO').AsString);

  If ((fEmptyStr(strNomImp)) Or (Not fImpressoraExiste(strNomImp))) And (not blnGerarPDF) Then
  Begin
    strNomImp := EmptyStr;
    blnExecute := TCfgRel.fExecutePrintDialog(strNomImp);
    If fEmptyStr(strNomImp) Then
      strNomImp := TCfgRel.fGetImpressoraSelecionada;
  End;

  If (intQtdVias <= -1) Then
  Begin
    intQtdVias := fCfgSis('VIANFC', varInteger);
    If (intQtdVias <= 0) Then
      intQtdVias := 1;
  End;

  If (blnExecute) Then
  Begin
    For i := 1 To intQtdVias Do Begin
      If (blnGerarPDF) Then
      Begin
        if (fEmptyStr(strPath)) then
        begin
          LDiretorioDanfe := fRetornaDiretorioDanfe(blnGerandoParaDisparoDeGatilho);

          frxExpPDF.FileName    := 'Tela' + strAcesso + '.pdf';
          frxExpPDF.DefaultPath := LDiretorioDanfe;
          frxExpPDF.ShowDialog  := Not fCriaDiretorio(LDiretorioDanfe);
        end
        else
        begin
          frxExpPDF.FileName    := ExtractFileName(strPath);
          frxExpPDF.DefaultPath := ExtractFilePath(strPath);
          frxExpPDF.ShowDialog  := Not fCriaDiretorio(ExtractFilePath(strPath));
        end;

        frxNFCe.PrepareReport;
        frxNFCe.Export(frxExpPDF);

        if (blnMostrarPreviewQuandoPDF) then
          pVisualizarPDFGerado(frxExpPDF.FileName);
      End
      Else
      Begin
        frxNFCe.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
        frxNFCe.PrintOptions.ShowDialog := False;

        VS_strUltimaImpressoraNFCe := strNomImp;

        If (frxNFCe.PrepareReport) Then
          pPrintReport(Self.Name, 'Impressão DANFE/NFCe', strNomImp, frxNFCe);
      End;

      If (intQtdVias > 1) Then
        Sleep(1000);
    End;
  End;

  FreeAndNil(qryItens);
end;

procedure TfrmQckFatImpNFCe.pImprimirDanfeSAT(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strSerie, strTip_FC: String; strImpressora: String=''; blnSatComplementar:Boolean=False);
  Var
    qryItens: TUniQuery;
    strNomImp: String;
    strModalidades: String;
    strValores: String;
    bmpQrCode: TBitmap;
    strEnderecoConsumidor: String;
    stream: TMemoryStream;
    frxQrCode: TfrxPictureView;
    intTentativas: Integer;
    frxImprimir: TfrxReport;
    intQtdNps : Integer;

  function fContingencia(strAcesso: String): Boolean;
  begin
    Result := StrToIntDef(Copy(strAcesso, 35, 1), 0) In [6,7,9];
  end;

begin
  qryItens := fCriaQuery(Self);
  pCarregaDados(qryItens, blnSatComplementar);

  If fCfgSis('MODSAT', varInteger) <> 2 Then
    frxImprimir := frxSATCFe
  Else
    frxImprimir := frxSATCFeMod2;

  TfrxReportPage(frxImprimir.FindObject('Page1')).LeftMargin := fStrToFloat(fArqIniLocal(0, 'SATCFE', 'MARGEM', '0', fCfgSis('PATSAT') + '\opcoes_sat.ini')) * 10;

  qryItens.ParamByName('NUMDOC').AsString := strNumDoc;
  qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
  qryItens.ParamByName('CODEMP').AsString := strCodEmp;
  qryItens.ParamByName('CODCLI').AsString := strCodCli;
  qryItens.ParamByName('TIP_FC').AsString := strTip_FC;
  qryItens.ParamByName('SERIE_').AsString := strSerie;
  qryItens.Open;

  pCarregaModalidadesPagamento(qryItens.FieldByName('VLRCON').AsFloat,
    strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strModalidades, strValores);

  frxImprimir.Script.Variables['NOMEMP'] := qryItens.FieldByName('NOMEMP').AsString;
  frxImprimir.Script.Variables['CNPJ'] := fFormataCpfCgc(qryItens.FieldByName('C_G_C_').AsString, opcBrasil);
  frxImprimir.Script.Variables['IE'] := qryItens.FieldByName('I_E_S_').AsString;
  frxImprimir.Script.Variables['IM'] := qryItens.FieldByName('INSMUN').AsString;
  frxImprimir.Script.Variables['ENDEMP'] := qryItens.FieldByName('ENDEMP').AsString;
  frxImprimir.Script.Variables['CEPEMP'] := fFormataCEP(AnsiReplaceStr(qryItens.FieldByName('CEPEMP').AsString, '-', ''));
  frxImprimir.Script.Variables['TELEMP'] := fFormataFone(qryItens.FieldByName('TELEMP').AsString);
  frxImprimir.Script.Variables['NUMSER'] := LeftStr(fTransform(qryItens.FieldByName('NUMSER').AsString, 3, '.'), 11);
  frxImprimir.Script.Variables['NUMCOO'] := qryItens.FieldByName('NUMCOO').AsString;
  frxImprimir.Script.Variables['SERIE_'] := qryItens.FieldByName('SERIE_').AsString;
  frxImprimir.Script.Variables['DTAEMI'] := FormatDateTime('dd/mm/yyyy', qryItens.FieldByName('DTAENT').AsDateTime);
  frxImprimir.Script.Variables['ACESSO'] := fTransform(qryItens.FieldByName('ACESSO').AsString, 4, ' ');
  frxImprimir.Script.Variables['PROTOC'] := qryItens.FieldByName('PROTOC').AsString;
  frxImprimir.Script.Variables['DPROTO'] := FormatDateTime('dd/mm/yyyy hh:nn:ss', qryItens.FieldByName('DPROTO').AsDateTime);

  strEnderecoConsumidor := '';

  If Not fEmptyStr(qryItens.FieldByName('ENDERE').AsString) Then
  Begin
    strEnderecoConsumidor := 'END: ' + qryItens.FieldByName('ENDERE').AsString;

    If Not fEmptyStr(qryItens.FieldByName('ENDNUM').AsString) Then
      strEnderecoConsumidor := strEnderecoConsumidor + ', ' + qryItens.FieldByName('ENDNUM').AsString;

    If Not fEmptyStr(qryItens.FieldByName('ENDCOM').AsString) Then
      strEnderecoConsumidor := strEnderecoConsumidor + ', ' + qryItens.FieldByName('ENDCOM').AsString;

    If Not fEmptyStr(qryItens.FieldByName('BAICON').AsString) Then
      strEnderecoConsumidor := strEnderecoConsumidor + ', ' + qryItens.FieldByName('BAICON').AsString;

    If Not fEmptyStr(qryItens.FieldByName('CIDCON').AsString) then
      strEnderecoConsumidor := strEnderecoConsumidor + ', ' + qryItens.FieldByName('CIDCON').AsString;

    If Not fEmptyStr(qryItens.FieldByName('ESTCON').AsString) then
      strEnderecoConsumidor := strEnderecoConsumidor + ', ' + qryItens.FieldByName('ESTCON').AsString;

    If Not fEmptyStr(qryItens.FieldByName('IESCON').AsString) then
      strEnderecoConsumidor := strEnderecoConsumidor + ', IE: ' + qryItens.FieldByName('IESCON').AsString;

    strEnderecoConsumidor := strEnderecoConsumidor + sLineBreak;
  End;

  frxImprimir.Script.Variables['INF_FISCO'] := qryItens.FieldByName('OBSFIS').AsString;
  frxImprimir.Script.Variables['INF_COMPLEMENTAR'] := fGetInfComplementar(qryItens, sLineBreak, strEnderecoConsumidor);

  frxImprimir.Script.Variables['MODALIDADES'] := strModalidades;
  frxImprimir.Script.Variables['VALORES_MOD'] := strValores;
  frxImprimir.Script.Variables['TOTAL_TRIBUTOS'] := FloatToStrF(qryItens.FieldByName('IMPPAG').AsFloat, ffNumber, 12, 2);

  frxImprimir.Script.Variables['TROCO_'] := FloatToStrF(qryItens.FieldByName('TROCO_').AsFloat, ffNumber, 12, 2);
  If qryItens.FieldByName('TROCO_').AsFloat = 0 Then
    TfrxChild(frxImprimir.FindObject('Child3')).Visible := False;

  If fStringRepetida(qryItens.FieldByName('CGCCON').AsString) Then
    frxImprimir.Script.Variables['CPF_CONSUMIDOR'] := ''
  Else If fTestaCgc(qryItens.FieldByName('CGCCON').AsString) Then
    frxImprimir.Script.Variables['CPF_CONSUMIDOR'] := fFormataCpfCgc(qryItens.FieldByName('CGCCON').AsString, opcBrasil)
  Else
    frxImprimir.Script.Variables['CPF_CONSUMIDOR'] := fFormataCpfCgc(qryItens.FieldByName('CGCCON').AsString, opcBrasil);

  If (fCfgSis('UTINPS', varBoolean)) And (strTip_FC = 'C') Then
    fGanhouNetpoints(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, intQtdNps)
  Else
    intQtdNps := 0;

  frxImprimir.Script.Variables['QTDNPS'] := IntToStr(intQtdNps);
  TfrxChild(frxImprimir.FindObject('ChdNetpoints')).Visible := (intQtdNps > 0);
  TfrxChild(frxImprimir.FindObject('ChdSimNac')).Visible := (fCfgSis('SIMNAC') = 'S');

  If blnSatComplementar Then
  Begin
    frxImprimir.Script.Variables['MODALIDADES'] := '';
    frxImprimir.Script.Variables['VALORES_MOD'] := '';
    frxImprimir.Script.Variables['INF_COMPLEMENTAR'] := 'CF-e complementar '+#13+
                                                        'Cliente: ' + qryItens.FieldByName('CODCLI').AsString + ' - ' + qryItens.FieldByName('NOMCON').AsString + sLineBreak +
                                                        strEnderecoConsumidor + sLineBreak +
                                                        'IF: ' + qryItens.FieldByName('NUMDOC').AsString + sLineBreak +
                                                        'Documento fiscal Original: '+qryItens.FieldByName('ESPORI').AsString+'-'+
                                                                                      qryItens.FieldByName('DOCORI').AsString + sLineBreak +
                                                                                      'Chave: '+qryItens.FieldByName('ACEORI').AsString;
    TfrxChild(frxImprimir.FindObject('Child7')).Visible := False;
    TfrxChild(frxImprimir.FindObject('ChdSimNac')).Visible := False;
  End;

  frxQrCode := TfrxPictureView(frxImprimir.FindObject('imgQRCode'));

  intTentativas := 0;

  While True Do
  Begin
    Try
      bmpQrCode := fGerarQRCode(qryItens.FieldByName('QRCODE').AsString);
      Sleep(100);
//      pAjustaBitmap(bmpQrCode, fFloatToInt(frxQrCode.Width), fFloatToInt(frxQrCode.Height));
      Break;
    Except
      On E: Exception Do
      Begin
        Inc(intTentativas);
        If intTentativas > 30 Then
        Begin
          Raise;
        End;
        Sleep(500);
        Application.ProcessMessages;
      End;
    End;
  End;

  stream := TMemoryStream.Create;
  bmpQrCode.SaveToStream(stream);

  frxQrCode.LoadPictureFromStream(stream);
  FreeAndNil(stream);
  FreeAndNil(bmpQrCode);

  frxDbNFce.DataSet := qryItens;

  If fEmptyStr(strImpressora) Then
    strNomImp := fArqIniLocal(0, 'SATCFE', fImpressoraKey, '', fCfgSis('PATSAT') + '\opcoes_sat.ini')
  Else
    strNomImp := strImpressora;

  strNomImp := fIdentificarNomeDaImpressora(strNomImp);

  frxImprimir.PrintOptions.Printer := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
  frxImprimir.PrintOptions.ShowDialog := False;

  If frxImprimir.PrepareReport Then
    pPrintReport(Self.Name, 'Impressão DANFE/SAT', strNomImp, frxImprimir);

  FreeAndNil(qryItens);
end;

procedure TfrmQckFatImpNFCe.pImprimirDanfeNFCeDaruma(strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strSerie, strTip_FC, strImpressora: String);
  Const
    QrCodePeq = 3;
    QrCodeMed = 4;
    QrCodeGrd = 5;
  Var
    strModPag: String;
    strValoresPag: String;

    stlModalidades: TStringList;
    stlValores: TStringList;

    intContador: Integer;
    fltTotQtdIte: Double;

    strEnderecoConsumidor: String;

    strCabecalho: String;
    strItens: String;
    strSubTotal: String;
    strModalidades: String;
    strTotais: String;
    strMsgs: String;
    strConsumidor: String;
    strRodape: String;
    qryItens: TUniQuery;
    strImpostos: String;
    intTamQrCode: Integer;
    strMsgHomolog: String;
    i, intQtdVias: Integer;

begin
  pCarregarFuncoesDllDaruma;

  If (HandleDarumaFramework <> 0) And (Not Assigned(iImprimirTexto_DUAL_DarumaFramework)) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário atualizar a versão da Dll da Daruma. Caminho: ' +
      fArqIniLocal(0, 'NFCE', 'DARUMA_PATH_DLL', '', fCfgSis('PTNFCE') + '\opcoes_nfce.ini') , ['&Ok']);
    Exit;
  End;

  qryItens := fCriaQuery(Self);
  pCarregaDados(qryItens);

  qryItens.ParamByName('NUMDOC').AsString := strNumDoc;
  qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
  qryItens.ParamByName('CODEMP').AsString := strCodEmp;
  qryItens.ParamByName('CODCLI').AsString := strCodCli;
  qryItens.ParamByName('TIP_FC').AsString := strTip_FC;
  qryItens.ParamByName('SERIE_').AsString := strSerie;
  qryItens.Open;

  intQtdVias := fCfgSis('VIANFC', varInteger);
  If (intQtdVias <= 0) Then
    intQtdVias := 1;

  For i := 1 To intQtdVias Do
  Begin
    pInicializarDaruma;

    fltTotQtdIte := 0;

    stlValores     := TStringList.Create;
    stlModalidades := TStringList.Create;

    pCarregaModalidadesPagamento(qryItens.FieldByName('VLRCON').AsFloat,
      strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strModPag, strValoresPag);

    strModPag := AnsiReplaceStr(strModPag, #10, '');
    strValoresPag := AnsiReplaceStr(strValoresPag, #10, '');

    ExtractStrings([#13], [], PWideChar(strModPag), stlModalidades);
    ExtractStrings([#13], [], PWideChar(strValoresPag), stlValores);

    strCabecalho := fDarumaCentral(fDarumaNegrito(fCadEmpNomeEmpresa), fDarumaSaltar1) +
                    fDarumaNegrito('CNPJ: ' + fFormataCpfCgc(fCadEmp('C_G_C_'), opcBrasil) + ' I.E.: ' + fCadEmp('I_E_S_'), fDarumaSaltar1) +
                    fDarumaNegrito('I.M.: ' + fCadEmp('INSMUN'), fDarumaSaltar1) +
                    fDarumaCentral(fDarumaNegrito(fCadEmp('ENDERECO')), fDarumaSaltar1) +
                    fDarumaNegrito('CEP: ' + fFormataCEP(AnsiReplaceStr(fCadEmp('C_E_P_'), '-', '')) + ' - ' + 'TELEFONE: ' + fFormataFone(fCadEmp('FONE01')), fDarumaSaltar1) +
                    fDarumaCentral(fDarumaNegrito('DANFE NFC-e - Documento Auxiliar da Nota Fiscal Eletrônica para Consumidor Final'), fDarumaSaltar1 + fDarumaSaltar1) +
                    fDarumaCentral('Não permite aproveitamento de Crédito de ICMS', fDarumaSaltar1) +
                    fDarumaRiscarL('-', fDarumaSaltar1) +
                    'Código Descrição Qtde.  UN   Vl.Unit.  Vl. Total' + fDarumaSaltar1 +
                    fDarumaRiscarL('-');

    {****************************************************}
    {* NECESSÁRIO DESABILITAR O WARNING POIS, FAZENDO A *}
    {* CONVERSÃO EXPLICITA OOCORRE ACCESS VIOLATION. O  *}
    {* MESMO OCORRE SE ALTERAR O TIPO DO PARÂMETRO NA   *}
    {* FUNÇÃO. NÃO REMOVER SEM FALAR COM O DETINHO.     *}
    {*************************************************MV*}
    {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
    fiImprimirTexto_DUAL_DarumaFramework(strCabecalho + fDarumaAguarda, 0);
    {$WARN IMPLICIT_STRING_CAST_LOSS ON}

    strItens := '';
    While (Not qryItens.Eof) Do
    Begin
      strItens := strItens + qryItens.FieldByName('CODITE').AsString + ' ';
      strItens := strItens + qryItens.FieldByName('DESITE').AsString + fDarumaSaltar1;
      strItens := strItens + fRetTextoMarcaEOuCodFab(qryItens);
      strItens := strItens + fstrEspaco('', 5) +
                             fPadL(FloatToStrF(qryItens.FieldByName('QTDITE').AsFloat, ffNumber, 12, 2), 11) + '  ' +
                             fPadL(qryItens.FieldByName('UNIDAD').AsString, 4) + ' ' +
                             fPadL(FloatToStrF(qryItens.FieldByName('UNITAR').AsFloat, ffNumber, 12, 2), 11) + '  ' +
                             fPadL(FloatToStrF(qryItens.FieldByName('TOTITE').AsFloat, ffNumber, 12, 2), 12);

      fltTotQtdIte := fltTotQtdIte + qryItens.FieldByName('QTDITE').AsFloat;

      If (qryItens.RecNo Mod 10 = 0) Or (qryItens.RecNo = qryItens.RecordCount) Then
      Begin
        If qryItens.RecNo = qryItens.RecordCount Then
        Begin
          strItens := strItens + fDarumaRiscarL('-');
        End;
        {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
        fiImprimirTexto_DUAL_DarumaFramework(strItens + fDarumaAguarda, 0);
        {$WARN IMPLICIT_STRING_CAST_LOSS ON}
        strItens := '';
      End
      Else
      Begin
         strItens := strItens + fDarumaSaltar1;
      End;

      qryItens.Next;
    End;

    strSubTotal := fDarumaNegrito('QTD. TOTAL DE ITENS:' + fPadL(FloatToStrF(fltTotQtdIte, ffNumber, 12, 2), 28), fDarumaSaltar1) +
                   fDarumaNegrito('SUBTOTAL R$:' + fPadL(FloatToStrF(qryItens.FieldByName('TOTPRO').AsFloat, ffNumber, 12, 2), 36), fDarumaSaltar1) +
                   fDarumaNegrito('DESCONTOS R$:' + fPadL(FloatToStrF(qryItens.FieldByName('DESESP').AsFloat, ffNumber, 12, 2), 35), fDarumaSaltar1);

    If qryItens.FieldByName('TOTFRE').AsFloat <> 0 Then
      strSubTotal := strSubTotal + fDarumaNegrito('FRETE R$:' + fPadL(FloatToStrF(qryItens.FieldByName('TOTFRE').AsFloat, ffNumber, 12, 2), 39), fDarumaSaltar1);

    If qryItens.FieldByName('DESACE').AsFloat <> 0 Then
      strSubTotal := strSubTotal + fDarumaNegrito('DESP. ACESSORIA R$:' + fPadL(FloatToStrF(qryItens.FieldByName('DESACE').AsFloat, ffNumber, 12, 2), 39), fDarumaSaltar1);

    If qryItens.FieldByName('TOTRET').AsFloat <> 0 Then
      strSubTotal := strSubTotal + fDarumaNegrito('ICMS ST R$:' + fPadL(FloatToStrF(qryItens.FieldByName('TOTRET').AsFloat, ffNumber, 12, 2), 39), fDarumaSaltar1);

    If qryItens.FieldByName('TOTIPI').AsFloat <> 0 Then
      strSubTotal := strSubTotal + fDarumaNegrito('IPI R$:' + fPadL(FloatToStrF(qryItens.FieldByName('TOTIPI').AsFloat, ffNumber, 12, 2), 39), fDarumaSaltar1);

    strSubTotal := strSubTotal + fDarumaNegrito('VALOR TOTAL R$:' + fPadL(FloatToStrF(qryItens.FieldByName('VLRCON').AsFloat, ffNumber, 12, 2), 33), fDarumaSaltar1);

    strModalidades := fDarumaCentral(fDarumaNegrito('FORMAS DE PAGAMENTO'), fDarumaSaltar1);
    For intContador := 0 To stlModalidades.Count -1 Do
    Begin
      strModalidades := strModalidades + stlModalidades[intContador] + fPadL(stlValores[intContador], 48-Length(stlModalidades[intContador])) + fDarumaSaltar1;
    End;

    strTotais := fDarumaNegrito('TOTAL R$:' + fPadL(FloatToStrF(qryItens.FieldByName('VLRCON').AsFloat, ffNumber, 12, 2), 34), fDarumaSaltar1);

    If qryItens.FieldByName('TROCO_').AsFloat <> 0 Then
      strTotais := strTotais + fDarumaNegrito('TROCO R$:' + fPadL(FloatToStrF(qryItens.FieldByName('TROCO_').AsFloat, ffNumber, 12, 2), 39), fDarumaSaltar1);

    strTotais := strTotais + fDarumaNegrito('Tributos Totais Incidentes (Lei Federal 12.741/2012) R$:', fDarumaSaltar1);

    strImpostos := '';
    If fCfgSis('IMPPAG', VarInteger) = 1 Then
    Begin
      strTotais := strTotais + fDarumaNegrito(fPadL(FloatToStrF(qryItens.FieldByName('IMPPAG').AsFloat, ffNumber, 12, 2), 48), fDarumaSaltar1);
    End
    Else
    Begin
      If qryItens.FieldByName('FEDIMP').AsFloat + qryItens.FieldByName('ESTIMP').AsFloat + qryItens.FieldByName('MUNIMP').AsFloat = 0 Then
      Begin
        strTotais := strTotais + fDarumaNegrito(fPadL('0,00', 48), fDarumaSaltar1);
      End
      Else
      Begin
        If qryItens.FieldByName('FEDIMP').AsFloat <> 0 Then
          strImpostos := strImpostos + FloatToStrF(qryItens.FieldByName('FEDIMP').AsFloat, ffNumber, 12, 2) + ' Fed';

        If qryItens.FieldByName('ESTIMP').AsFloat <> 0 Then
          strImpostos := strImpostos + '/' + FloatToStrF(qryItens.FieldByName('ESTIMP').AsFloat, ffNumber, 12, 2) + ' Est';

        If qryItens.FieldByName('MUNIMP').AsFloat <> 0 Then
          strImpostos := strImpostos + '/' + FloatToStrF(qryItens.FieldByName('MUNIMP').AsFloat, ffNumber, 12, 2) + ' Mun';

        strTotais := strTotais + fDarumaNegrito(fPadL(strImpostos + '/ Fonte:IBPT.', 48), fDarumaSaltar1);
      End;
    End;

    If fUrlAmbienteHomologacao Then
    Begin
      strMsgHomolog := fDarumaRiscarL('-', fDarumaSaltar1);
      strMsgHomolog := strMsgHomolog + fDarumaCentral(fDarumaNegrito('NFCE EMITIDA EM AMBIENTE DE HOMOLOGAÇÃO'), fDarumaSaltar1);
      strMsgHomolog := strMsgHomolog + fDarumaCentral(fDarumaNegrito('SEM VALOR FISCAL'), fDarumaSaltar1);
      strMsgHomolog := strMsgHomolog + fDarumaRiscarL('-', fDarumaSaltar1);
    End
    Else
      strMsgHomolog := '';

    strMsgs := fDarumaCentral(fDarumaNegrito('ÁREA DE MENSAGEM DE INTERESSE DO CONTRIBUINTE'), fDarumaSaltar1) +
               fGetInfComplementar(qryItens, fDarumaSaltar1) + fDarumaSaltar1 +
               fDarumaCentral(fDarumaNegrito('ÁREA DE MENSAGEM FISCAL'), fDarumaSaltar1) +
               fDarumaNegrito('Número: ' + qryItens.FieldByName('NUMDOC').AsString + ' - Série: ' + qryItens.FieldByName('SERIE_').AsString, fDarumaSaltar1) +
               fDarumaNegrito('Emissão: ' + FormatDateTime('dd/mm/yyyy', qryItens.FieldByName('DTAENT').AsDateTime) + '-' + FormatDateTime('hh:mm:ss', qryItens.FieldByName('HORENT').AsDateTime) + ' - Via Consumidor', fDarumaSaltar1) +
               fDarumaCentral(fDarumaNegrito('CHAVE DE ACESSO'), fDarumaSaltar1) +
               fDarumaCentral(qryItens.FieldByName('ACESSO').AsString, fDarumaSaltar1) +
               fDarumaRiscarL('-', fDarumaSaltar1);

    strConsumidor := fDarumaCentral(fDarumaNegrito('CONSUMIDOR'), fDarumaSaltar1);

    If fConsumidorIdentificado(qryItens) Then
    Begin
      If fTestaCgc(qryItens.FieldByName('CGCCON').AsString) Then
        strConsumidor := strConsumidor + 'CNPJ: ' + fFormataCpfCgc(qryItens.FieldByName('CGCCON').AsString, opcBrasil) + fDarumaSaltar1
      Else
        strConsumidor := strConsumidor + 'CPF: '  + fFormataCpfCgc(qryItens.FieldByName('CGCCON').AsString, opcBrasil) + fDarumaSaltar1;

      If Not fEmptyStr(qryItens.FieldByName('NOMCON').AsString) Then
      Begin
        strConsumidor := strConsumidor + qryItens.FieldByName('NOMCON').AsString +
                                         IIF(fCfgSis('CCLNFE', varBoolean), ' ' + qryItens.FieldByName('CODCLI').AsString, '') + fDarumaSaltar1;

        If Not fEmptyStr(qryItens.FieldByName('ENDERE').AsString) Then
        Begin
          strEnderecoConsumidor := qryItens.FieldByName('ENDERE').AsString + ', ';

          If Not fEmptyStr(qryItens.FieldByName('ENDNUM').AsString) Then
            strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('ENDNUM').AsString + ', ';

          If Not fEmptyStr(qryItens.FieldByName('ENDCOM').AsString) Then
            strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('ENDCOM').AsString + ', ';

          If Not fEmptyStr(qryItens.FieldByName('BAICON').AsString) Then
          strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('BAICON').AsString + ', ';

          strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('CIDCON').AsString + ', ';
          strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('ESTCON').AsString + fDarumaSaltar1;

          strConsumidor := strConsumidor + strEnderecoConsumidor;
        End;

        If Not fEmptyStr(qryItens.FieldByName('TELCON').AsString) Then
          strConsumidor := strConsumidor + 'TELEFONE: ' + fFormataFone(qryItens.FieldByName('TELCON').AsString) + fDarumaSaltar1
        Else
          strConsumidor := strConsumidor + fDarumaSaltar1;

        If Not fEmptyStr(qryItens.FieldByName('CELCON').AsString) Then
          strConsumidor := strConsumidor + 'CELULAR: ' + fFormataFone(qryItens.FieldByName('CELCON').AsString) + fDarumaSaltar1
        Else
          strConsumidor := strConsumidor + fDarumaSaltar1;

      End;
    End
    Else
    Begin
      strConsumidor := strConsumidor + 'CONSUMIDOR NÃO IDENTIFICADO' + fDarumaSaltar1;
    End;

    intTamQrCode := QrCodePeq;
    If fCfgSis('TAMQRC') = 'P' Then
      intTamQrCode := QrCodePeq
    Else If fCfgSis('TAMQRC') = 'M' Then
      intTamQrCode := QrCodeMed
    Else If fCfgSis('TAMQRC') = 'G' Then
       intTamQrCode := QrCodeGrd;

    strRodape := fDarumaCentral(fDarumaNegrito('Consulta via leitor de QR Code'), fDarumaSaltar1) +
                 fDarumaCentral(fDarumaQrCode_(qryItens.FieldByName('QRCODE').AsString + fDarumaTModulo(intTamQrCode)), fDarumaSaltar1) +
                 fDarumaCentral(fDarumaNegrito('Protocolo de Autorização'), fDarumaSaltar1) +
                 fDarumaCentral(fDarumaNegrito(qryItens.FieldByName('PROTOC').AsString + ' - ' +
                                FormatDateTime('dd/mm/yyyy hh:nn:ss', qryItens.FieldByName('DPROTO').AsDateTime)), fDarumaSaltarN(6)+fDarumaGuilhot);

    {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
    fiImprimirTexto_DUAL_DarumaFramework(strSubTotal + strModalidades + fDarumaAguarda, 0);
    fiImprimirTexto_DUAL_DarumaFramework(strTotais + fDarumaAguarda, 0);

    If Not fEmptyStr(strMsgHomolog) Then
      fiImprimirTexto_DUAL_DarumaFramework(strMsgHomolog + fDarumaAguarda, 0);

    fiImprimirTexto_DUAL_DarumaFramework(strMsgs + strConsumidor + fDarumaAguarda, 0);
    fiImprimirTexto_DUAL_DarumaFramework(strRodape + fDarumaAguarda, 0);
    {$WARN IMPLICIT_STRING_CAST_LOSS ON}

    FreeAndNil(stlModalidades);
    FreeAndNil(stlValores);

    If (intQtdVias > 1) Then
      Sleep(1000);
  End;

  FreeAndNil(qryItens);
end;

procedure TfrmQckFatImpNFCe.pImprimirDanfeNFCeReduzido(strNumDoc,
                                                       strEspDoc,
                                                       strCodEmp,
                                                       strCodCli,
                                                       strSerie,
                                                       strTip_FC: String;
                                                       strImpressora: String='';
                                                      blnGerarPDF: Boolean = False;
                                                      strAcesso: string = '';
                                                      blnMostrarPreviewQuandoPDF : Boolean = True;
                                                      strPath : String = '');
  Const
    QrCodePeq = 100;
    QrCodeMed = 130;
    QrCodeGrd = 160;
  Var
    qryItens: TUniQuery;
    strNomImp: String;
    strModalidades: String;
    strValores: String;
    bmpQrCode: TBitmap;
    strEnderecoConsumidor: String;
    stream: TMemoryStream;
    frxQrCode: TfrxPictureView;
    intTentativas: Integer;
    strImpostos: String;
    blnExecute : Boolean;
    intQtdNps : Integer;
    i, intQtdVias: Integer;
    strDirLogo : String;
    extTopDesEspVal : Extended;

  function fContingencia(strAcesso: String): Boolean;
  begin
    Result := StrToIntDef(Copy(strAcesso, 35, 1), 0) In [4,6,7,9];
  end;

begin
  qryItens := fCriaQuery(Self);
  pCarregaDados(qryItens);

  TfrxReportPage(frxNFCeReduzido.FindObject('Page1')).LeftMargin := fStrToFloat(fArqIniLocal(0, 'NFCE', 'MARGEM', '0', fCfgSis('PTNFCE') + '\opcoes_nfce.ini')) * 10;

  qryItens.ParamByName('NUMDOC').AsString := strNumDoc;
  qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
  qryItens.ParamByName('CODEMP').AsString := strCodEmp;
  qryItens.ParamByName('CODCLI').AsString := strCodCli;
  qryItens.ParamByName('TIP_FC').AsString := strTip_FC;
  qryItens.ParamByName('SERIE_').AsString := strSerie;
  qryItens.Open;

  frxNFCeReduzido.Script.Variables['PROFIS'] := fCfgSis('PROFIS', varString) + ':';
  frxNFCeReduzido.Script.Variables['CODDIV'] := qryItens.FieldByName('CODDIV').AsString;
  frxNFCeReduzido.Script.Variables['NOMDIV'] := qryItens.FIeldByName('NOMDIV').AsString;

  if (fCfgSis('NFCADC', VarBoolean)) and (not fEmptyStr(qryItens.FieldByName('CODDIV').AsString)) then
  begin
    TfrxChild(frxNFCeReduzido.FindObject('ChdContribuinte')).Height  := 2.20;
    TfrxMemoView(frxNFCeReduzido.FindObject('rllProfissional')).Visible := True;
  end
  else
  begin
    frxNFCeReduzido.Script.Variables['PROFIS'] := '';
    frxNFCeReduzido.Script.Variables['CODDIV'] := '';
    frxNFCeReduzido.Script.Variables['NOMDIV'] := '';
    TfrxMemoView(frxNFCeReduzido.FindObject('rllProfissional')).Visible := False;
    TfrxMemoView(frxNFCeReduzido.FindObject('rllProfissional')).Top := 1.03;
    TfrxChild(frxNFCeReduzido.FindObject('ChdContribuinte')).Height := 1.60;
  end;

  pCarregaModalidadesPagamento(qryItens.FieldByName('VLRCON').AsFloat,
    strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strModalidades, strValores);

  TfrxChild(frxNFCeReduzido.FindObject('ChdLogo')).Visible := False;

  If (fCfgSis('LOGNFC', VarBoolean)) Then
  Begin
    strDirLogo := fCfgSis('PTLNFC');
    If (Not fEmptyStr(strDirLogo)) And (FileExists(strDirLogo)) Then
    Begin
      TfrxChild(frxNFCeReduzido.FindObject('ChdLogo')).Visible := True;
      TfrxPictureView(frxNFCeReduzido.FindObject('rllImagem')).Picture.LoadFromFile(strDirLogo);
    End;
  End;

  If fCfgSis('NFEMAR', VarBoolean) Or fCfgSis('NFEFAB', VarBoolean) Then
  begin
    TfrxMasterData(frxNFCeReduzido.FindObject('MasterData1')).Visible := False;
    TfrxMasterData(frxNFCeReduzido.FindObject('MasterData2')).Visible := True;

    If (fCfgSis('NFEFAB', VarBoolean)) And (Not fCfgSis('NFEMAR', VarBoolean)) Then
      TfrxMemoView(frxNFCeReduzido.FindObject('MemoCodFab')).Left := 5.3;

    If fCfgSis('NFEMAR', VarBoolean) Then
      TfrxMemoView(frxNFCeReduzido.FindObject('MemoMarca')).Visible := True
    Else
      TfrxMemoView(frxNFCeReduzido.FindObject('MemoMarca')).Visible := False;

    If fCfgSis('NFEFAB', VarBoolean) Then
      TfrxMemoView(frxNFCeReduzido.FindObject('MemoCodFab')).Visible := True
    Else
      TfrxMemoView(frxNFCeReduzido.FindObject('MemoCodFab')).Visible := False;
  end
  Else
  begin
    TfrxMasterData(frxNFCeReduzido.FindObject('MasterData2')).Visible := False;
    TfrxMasterData(frxNFCeReduzido.FindObject('MasterData1')).Visible := True;
  end;

  if fCfgSis('NFDESC', varBoolean) And qryItens.FieldByName('DESESP').AsCurrency > 0 then
  begin
    if TfrxMasterData(frxNFCeReduzido.FindObject('MasterData2')).Visible then
    begin
      extTopDesEspVal := TfrxMasterData(frxNFCeReduzido.FindObject('Memo53')).Height +
        TfrxMasterData(frxNFCeReduzido.FindObject('MemoMarca')).Height + TfrxMasterData(frxNFCeReduzido.FindObject('Memo57')).Height;
      TfrxMemoView(frxNFCeReduzido.FindObject('MemoDesEspVal2')).Top := extTopDesEspVal;
      TfrxMemoView(frxNFCeReduzido.FindObject('MemoDesEspVal2')).Visible := True;
    end;

    if TfrxMasterData(frxNFCeReduzido.FindObject('MasterData1')).Visible then
    begin
      extTopDesEspVal := TfrxMasterData(frxNFCeReduzido.FindObject('Memo17')).Height + TfrxMasterData(frxNFCeReduzido.FindObject('Memo13')).Height;
      TfrxMemoView(frxNFCeReduzido.FindObject('MemoDesEspVal1')).Top := extTopDesEspVal;
      TfrxMemoView(frxNFCeReduzido.FindObject('MemoDesEspVal1')).Visible := True;
    end;
  end
  Else
  begin
    if TfrxMasterData(frxNFCeReduzido.FindObject('MasterData2')).Visible then
    begin
      TfrxMemoView(frxNFCeReduzido.FindObject('MemoDesEspVal2')).Top := TfrxMasterData(frxNFCeReduzido.FindObject('MemoMarca')).Top;
      TfrxMemoView(frxNFCeReduzido.FindObject('MemoDesEspVal2')).Visible := False;
    end;
    if TfrxMasterData(frxNFCeReduzido.FindObject('MasterData1')).Visible then
    begin
      TfrxMemoView(frxNFCeReduzido.FindObject('MemoDesEspVal1')).Top := TfrxMasterData(frxNFCeReduzido.FindObject('Memo17')).Top;
      TfrxMemoView(frxNFCeReduzido.FindObject('MemoDesEspVal1')).Visible := False;
    end;
  end;

  if fCfgSis('DESNFC') = '2' then
  Begin
    if TfrxMasterData(frxNFCeReduzido.FindObject('MasterData1')).Visible then
    begin
      TfrxMemoView(frxNFCeReduzido.FindObject('memo15')).Text := '[<frxNFce."UNIORI">]';
      TfrxMemoView(frxNFCeReduzido.FindObject('memo17')).Text := '[<frxNFce."UNIORI"> * <frxNFce."QTDITE">]';
      TfrxMemoView(frxNFCeReduzido.FindObject('memo28')).Text := '[SUM(<frxNFce."QTDITE">*<frxNFce."UNIORI">,MasterData1,2)]';
      TfrxMemoView(frxNFCeReduzido.FindObject('memo30')).Text := '[SUM( ((<frxNFce."UNIORI">-<frxNFce."UNITAR">)*<frxNFce."QTDITE">),MasterData1,2 ) + <frxNFce."DESESP">]';
    end;
    if TfrxMasterData(frxNFCeReduzido.FindObject('MasterData2')).Visible then
    begin
      TfrxMemoView(frxNFCeReduzido.FindObject('memo55')).Text := '[<frxNFce."UNIORI">]';
      TfrxMemoView(frxNFCeReduzido.FindObject('memo57')).Text := '[<frxNFce."UNIORI"> * <frxNFce."QTDITE">]';
      TfrxMemoView(frxNFCeReduzido.FindObject('memo28')).Text := '[SUM(<frxNFce."QTDITE">*<frxNFce."UNIORI">,MasterData2,2)]';
      TfrxMemoView(frxNFCeReduzido.FindObject('memo30')).Text := '[SUM( ((<frxNFce."UNIORI">-<frxNFce."UNITAR">)*<frxNFce."QTDITE">),MasterData2,2 ) + <frxNFce."DESESP">]';
    end;

  End;

  frxNFCeReduzido.Script.Variables['NOMEMP'] := qryItens.FieldByName('NOMEMP').AsString;
  frxNFCeReduzido.Script.Variables['CNPJ']   := fFormataCpfCgc(qryItens.FieldByName('C_G_C_').AsString, opcBrasil);
  frxNFCeReduzido.Script.Variables['IE']     := qryItens.FieldByName('I_E_S_').AsString;
  frxNFCeReduzido.Script.Variables['IM']     := qryItens.FieldByName('INSMUN').AsString;
  frxNFCeReduzido.Script.Variables['ENDEMP'] := qryItens.FieldByName('ENDEMP').AsString;
  frxNFCeReduzido.Script.Variables['CEPEMP'] := fFormataCEP(AnsiReplaceStr(qryItens.FieldByName('CEPEMP').AsString, '-', ''));
  frxNFCeReduzido.Script.Variables['TELEMP'] := fFormataFone(qryItens.FieldByName('TELEMP').AsString) +
                                                IIF(Not fEmptyStr(qryItens.FieldByName('TELEM2').AsString), ' / ' + fFormataFone(qryItens.FieldByName('TELEM2').AsString), '');
  frxNFCeReduzido.Script.Variables['NUMDOC'] := qryItens.FieldByName('NUMDOC').AsString;
  frxNFCeReduzido.Script.Variables['SERIE_'] := qryItens.FieldByName('SERIE_').AsString;
  frxNFCeReduzido.Script.Variables['DTAEMI'] := FormatDateTime('dd/mm/yyyy', qryItens.FieldByName('DTAENT').AsDateTime) + ' ' + FormatDateTime('hh:mm:ss', qryItens.FieldByName('HORENT').AsDateTime);
  frxNFCeReduzido.Script.Variables['ACESSO'] := fTransform(qryItens.FieldByName('ACESSO').AsString, 4, ' ');
  frxNFCeReduzido.Script.Variables['PROTOC'] := qryItens.FieldByName('PROTOC').AsString;
  frxNFCeReduzido.Script.Variables['DPROTO'] := FormatDateTime('dd/mm/yyyy hh:nn:ss', qryItens.FieldByName('DPROTO').AsDateTime);

  frxNFCeReduzido.Script.Variables['INF_COMPLEMENTAR'] := fGetInfComplementar(qryItens, #13#10);

  If Assigned(TfrxChild(frxNFCeReduzido.FindObject('chdNumCup'))) Then
    frxNFCeReduzido.FindObject('chdNumCup').Visible := not fEmptyStr(qryItens.FieldByName('NUMCUP').AsString);

  If (fStatusCndPag(qryItens.FieldByName('CONPAG').AsString) = A_VISTA) Then
    frxNFCeReduzido.Script.Variables['CONDICAO_PAGAMENTO'] := 'A VISTA'
  Else
    frxNFCeReduzido.Script.Variables['CONDICAO_PAGAMENTO'] := fFormataCondPag(qryItens.FieldByName('CONPAG').AsString);

  frxNFCeReduzido.Script.Variables['MODALIDADES'] := strModalidades;
  frxNFCeReduzido.Script.Variables['VALORES_MOD'] := strValores;

  strImpostos := '';
  If fCfgSis('IMPPAG', VarInteger) = 1 Then
  Begin
    frxNFCeReduzido.Script.Variables['TOTAL_TRIBUTOS'] := FloatToStrF(qryItens.FieldByName('IMPPAG').AsFloat, ffNumber, 12, 2);
  End
  Else
  Begin
    If qryItens.FieldByName('FEDIMP').AsFloat + qryItens.FieldByName('ESTIMP').AsFloat + qryItens.FieldByName('MUNIMP').AsFloat = 0 Then
    Begin
      frxNFCeReduzido.Script.Variables['TOTAL_TRIBUTOS'] := '0,00';
    End
    Else
    Begin
      If qryItens.FieldByName('FEDIMP').AsFloat <> 0 Then
        strImpostos := strImpostos + FloatToStrF(qryItens.FieldByName('FEDIMP').AsFloat, ffNumber, 12, 2) + ' Fed';

      If qryItens.FieldByName('ESTIMP').AsFloat <> 0 Then
        strImpostos := strImpostos + '/' + FloatToStrF(qryItens.FieldByName('ESTIMP').AsFloat, ffNumber, 12, 2) + ' Est';

      If qryItens.FieldByName('MUNIMP').AsFloat <> 0 Then
        strImpostos := strImpostos + '/' + FloatToStrF(qryItens.FieldByName('MUNIMP').AsFloat, ffNumber, 12, 2) + ' Mun';

      frxNFCeReduzido.Script.Variables['TOTAL_TRIBUTOS'] := strImpostos + '/ Fonte:IBPT.';
    End;
  End;

  frxNFCeReduzido.Script.Variables['TROCO_'] := FloatToStrF(qryItens.FieldByName('TROCO_').AsFloat, ffNumber, 12, 2);

  If qryItens.FieldByName('TROCO_').AsFloat = 0 Then
  Begin
    TfrxMemoView(frxNFCeReduzido.FindObject('rllTroco')).Visible := False;
    TfrxMemoView(frxNFCeReduzido.FindObject('rllValTroco')).Visible := False;
    TfrxChild(frxNFCeReduzido.FindObject('Child3')).Height := 0.4;
  End;

  If qryItens.FieldByName('TOTFRE').AsFloat = 0 Then
  Begin
    TfrxChild(frxNFCeReduzido.FindObject('ChildTotFre')).Visible := False;
  End;

  If qryItens.FieldByName('DESACE').AsFloat = 0 Then
  Begin
    TfrxChild(frxNFCeReduzido.FindObject('ChildDesAce')).Visible := False;
  End;

  If qryItens.FieldByName('TOTRET').AsFloat = 0 Then
  Begin
    TfrxChild(frxNFCeReduzido.FindObject('ChildTotRet')).Visible := False;
  End;

  If qryItens.FieldByName('TOTIPI').AsFloat = 0 Then
  Begin
    TfrxChild(frxNFCeReduzido.FindObject('ChildTotIpi')).Visible := False;
  End;

  TfrxChild(frxNFCeReduzido.FindObject('Child9')).Visible := fUrlAmbienteHomologacao;

  If (fCfgSis('UTINPS', varBoolean)) And (strTip_FC = 'C') Then
    fGanhouNetpoints(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, intQtdNps)
  Else
    intQtdNps := 0;

  frxNFCeReduzido.Script.Variables['QTDNPS'] := IntToStr(intQtdNps);
  TfrxChild(frxNFCeReduzido.FindObject('ChdNetpoints')).Visible := (intQtdNps > 0);

  TfrxMemoView(frxNFCeReduzido.FindObject('rllConsumidor')).Memo.Clear;

  If fConsumidorIdentificado(qryItens) Then
  Begin
    If fTestaCgc(qryItens.FieldByName('CGCCON').AsString) Then
      TfrxMemoView(frxNFCeReduzido.FindObject('rllConsumidor')).Memo.Add('CNPJ: ' + fFormataCpfCgc(qryItens.FieldByName('CGCCON').AsString, opcBrasil))
    Else
      TfrxMemoView(frxNFCeReduzido.FindObject('rllConsumidor')).Memo.Add('CPF: '  + fFormataCpfCgc(qryItens.FieldByName('CGCCON').AsString, opcBrasil));

    If Not fEmptyStr(qryItens.FieldByName('NOMCON').AsString) Then
    Begin
      TfrxMemoView(frxNFCeReduzido.FindObject('rllConsumidor')).Memo.Add(qryItens.FieldByName('NOMCON').AsString +
                        IIF(fCfgSis('CCLNFE', varBoolean), ' ' + qryItens.FieldByName('CODCLI').AsString, ''));

      If Not fEmptyStr(qryItens.FieldByName('ENDERE').AsString) Then
      Begin
        strEnderecoConsumidor := qryItens.FieldByName('ENDERE').AsString + ', ';

        If Not fEmptyStr(qryItens.FieldByName('ENDNUM').AsString) Then
          strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('ENDNUM').AsString + ', ';

        If Not fEmptyStr(qryItens.FieldByName('ENDCOM').AsString) Then
          strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('ENDCOM').AsString + ', ';

        If Not fEmptyStr(qryItens.FieldByName('BAICON').AsString) Then
          strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('BAICON').AsString + ', ';

        strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('CIDCON').AsString + ', ';
        strEnderecoConsumidor := strEnderecoConsumidor + qryItens.FieldByName('ESTCON').AsString;

        TfrxMemoView(frxNFCeReduzido.FindObject('rllConsumidor')).Memo.Add(strEnderecoConsumidor);
      End;

      If Not fEmptyStr(qryItens.FieldByName('TELCON').AsString) Then
        TfrxMemoView(frxNFCeReduzido.FindObject('rllConsumidor')).Memo.Add('TELEFONE: ' + fFormataFone(qryItens.FieldByName('TELCON').AsString));

      If Not fEmptyStr(qryItens.FieldByName('CELCON').AsString) Then
        TfrxMemoView(frxNFCeReduzido.FindObject('rllConsumidor')).Memo.Add('CELULAR: ' + fFormataFone(qryItens.FieldByName('CELCON').AsString));

    End;
  End
  Else
  Begin
    TfrxMemoView(frxNFCeReduzido.FindObject('rllConsumidor')).Memo.Add('CONSUMIDOR NÃO IDENTIFICADO');
  End;

  TfrxMemoView(frxNFCeReduzido.FindObject('rllEnderecoConsulta')).Memo.Add(fNFCeEnderecoDeConsulta(qryItens.FieldByName('ESTEMP').AsString));

  If fContingencia(qryItens.FieldByName('ACESSO').AsString) Then
  Begin
    TfrxChild(frxNFCeReduzido.FindObject('ChildContingencia1')).Visible := True;
    TfrxChild(frxNFCeReduzido.FindObject('ChildContingencia2')).Visible := True;
    TfrxMemoView(frxNFCeReduzido.FindObject('rllAreaMensagemFiscal')).Visible := False;

    TfrxMemoView(frxNFCeReduzido.FindObject('rllLabelProtocolo')).Visible := False;
    TfrxMemoView(frxNFCeReduzido.FindObject('rllProtocolo')).Visible := False;
  End
  Else
  Begin
    TfrxChild(frxNFCeReduzido.FindObject('ChildContingencia1')).Visible := False;
    TfrxChild(frxNFCeReduzido.FindObject('ChildContingencia2')).Visible := False;
    TfrxMemoView(frxNFCeReduzido.FindObject('rllAreaMensagemFiscal')).Visible := True;
  End;

  TfrxMemoView(frxNFCeReduzido.FindObject('rllMensagemAproveitaICMS')).Visible := (fCfgSis('NFCEAC') = 'S');

  TfrxChild(frxNFCeReduzido.FindObject('ChdNumGuiche')).Visible := (Not fEmptyStr(qryItens.FieldByName('NUMGUI').AsString));
  TfrxChild(frxNFCeReduzido.FindObject('ChdNomeConferente')).Visible := (Not fEmptyStr(qryItens.FieldByName('OPEEXP').AsString));

  If fCfgSis('TAMQRC') = 'P' Then
  Begin
    TfrxPictureView(frxNFCeReduzido.FindObject('imgQRCode')).Height := QrCodePeq;
    TfrxPictureView(frxNFCeReduzido.FindObject('imgQRCode')).Width  := QrCodePeq;
  End
  Else If fCfgSis('TAMQRC') = 'M' Then
  Begin
    TfrxPictureView(frxNFCeReduzido.FindObject('imgQRCode')).Height := QrCodeMed;
    TfrxPictureView(frxNFCeReduzido.FindObject('imgQRCode')).Width  := QrCodeMed;
  End
  Else If fCfgSis('TAMQRC') = 'G' Then
  Begin
    TfrxPictureView(frxNFCeReduzido.FindObject('imgQRCode')).Height := QrCodeGrd;
    TfrxPictureView(frxNFCeReduzido.FindObject('imgQRCode')).Width  := QrCodeGrd;
  End;

  frxQrCode := TfrxPictureView(frxNFCeReduzido.FindObject('imgQRCode'));

  if fCfgSis('NFCETP', varBoolean) then
  begin
    if frxNFCeReduzido.FindObject('rllTotalPago') <> nil then
      TfrxMemoView(frxNFCeReduzido.FindObject('rllTotalPago')).Memo.Text := 'TOTAL';
  end;

  intTentativas := 0;

  While True Do
  Begin
    Try
      bmpQrCode := fGerarQRCode(qryItens.FieldByName('QRCODE').AsString);
      Sleep(100);
      //pAjustaBitmap(bmpQrCode, fFloatToInt(frxQrCode.Width), fFloatToInt(frxQrCode.Height));
      Break;
    Except
      On E: Exception Do
      Begin
        Inc(intTentativas);
        If intTentativas > 30 Then
        Begin
          Raise;
        End;
        Sleep(500);
        Application.ProcessMessages;
      End;
    End;
  End;

  stream := TMemoryStream.Create;
  bmpQrCode.SaveToStream(stream);


  frxQrCode.LoadPictureFromStream(stream);
  FreeAndNil(stream);
  FreeAndNil(bmpQrCode);

  frxDbNFce.DataSet := qryItens;

  If fEmptyStr(strImpressora) Then
    strNomImp := fArqIniLocal(0, 'NFCE', fImpressoraKey, '', fCfgSis('PTNFCE') + '\opcoes_nfce.ini')
  Else
    strNomImp := strImpressora;

  strNomImp := fIdentificarNomeDaImpressora(strNomImp);

  blnExecute := True;

  pSalvarDanfe(frxNFCeReduzido, qryItens.FieldByName('ACESSO').AsString);

  If ((fEmptyStr(strNomImp)) Or (Not fImpressoraExiste(strNomImp))) And (not blnGerarPDF) Then
  Begin
    strNomImp := EmptyStr;
    blnExecute := TCfgRel.fExecutePrintDialog(strNomImp);
    If fEmptyStr(strNomImp) Then
      strNomImp := TCfgRel.fGetImpressoraSelecionada;
  End;

  intQtdVias := fCfgSis('VIANFC', varInteger);
  If (intQtdVias <= 0) Then intQtdVias := 1;

  If (blnExecute) Then
  Begin
    For i := 1 To intQtdVias Do Begin
      If (blnGerarPDF) Then
      Begin
        if (fEmptyStr(strPath)) then
        begin
          frxExpPDF.FileName    := 'Tela' + strAcesso + '.pdf';
          frxExpPDF.DefaultPath := 'c:\NFEPRINTER\DANFE\';
          frxExpPDF.ShowDialog  := Not fCriaDiretorio('c:\NFEPRINTER\DANFE\');
        end
        else
        begin
          frxExpPDF.FileName    := ExtractFileName(strPath);
          frxExpPDF.DefaultPath := ExtractFilePath(strPath);
          frxExpPDF.ShowDialog  := Not fCriaDiretorio(ExtractFilePath(strPath));
        end;

        frxNFCeReduzido.PrepareReport;
        frxNFCeReduzido.Export(frxExpPDF);

        if (blnMostrarPreviewQuandoPDF) then
          pVisualizarPDFGerado(frxExpPDF.FileName);
      End
      Else
      Begin
        frxNFCeReduzido.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
        frxNFCeReduzido.PrintOptions.ShowDialog := False;

        VS_strUltimaImpressoraNFCe := strNomImp;

        If (frxNFCeReduzido.PrepareReport) Then
          pPrintReport(Self.Name, 'Impressão DANFE/NFCe Reduzido', strNomImp, frxNFCeReduzido);
      End;

      If (intQtdVias > 1) Then
        Sleep(1000);
    End;
  End;

  FreeAndNil(qryItens);

end;

procedure TfrmQckFatImpNFCe.pImprimirTef(strTextoTef, strLinhasPicote: String; const AblnQtdViasExterna: Boolean = False);
  Var
    strNomImp: String;
    intQtdVia,
    intPosicao: Integer;
    stlTextoPicote: TStringList;
    stlLinhasPicote: TStringList;
    stlTextoTef: TStringList;
    strLinhaTef: String;
    intLinhaTef: Integer;
    intIndiceTexto: Integer;
    intQtdeLinhasSalto: Integer;
begin
  TfrxReportPage(frxTEF.FindObject('Page1')).LeftMargin := fStrToFloat(fArqIniLocal(0, 'NFCE', 'MARGEM', '0', fCfgSis('PTNFCE') + '\opcoes_nfce.ini')) * 10;

  frxTEF.Script.Variables['NOMEMP'] := fCadEmpNomeEmpresa;
  frxTEF.Script.Variables['CNPJ'] := fFormataCpfCgc(fCadEmp('C_G_C_'), opcBrasil);
  frxTEF.Script.Variables['IE'] := fCadEmp('I_E_S_');
  frxTEF.Script.Variables['IM'] := fCadEmp('INSMUN');
  frxTEF.Script.Variables['ENDEMP'] := fCadEmp('ENDERECO');
  frxTEF.Script.Variables['TELEMP'] := 'TELEFONE: ' + fFormataFone(fCadEmp('FONE01'));

  if AblnQtdViasExterna then
    intQtdVia := 1
  else
    intQtdVia := StrToIntDef(fCfgSis('VIAVIS'), 2);

  intQtdeLinhasSalto := StrToIntDef(fCfgSis('QTLNCO'), 1);
  frxTEF.Script.Variables['TEXTO1'] := '';
  frxTEF.FindObject('rlbTitulo').Visible := True;

  if fImpPorTerminalTef then
    strNomImp := fRetNomeImpressoraTerminal
  else If fUsaSat Then
    strNomImp := fArqIniLocal(0, 'SATCFE', fImpressoraKey, '', fCfgSis('PATSAT') + '\opcoes_sat.ini')
  Else
    strNomImp := fArqIniLocal(0, 'NFCE', fImpressoraKey, '', fCfgSis('PTNFCE') + '\opcoes_nfce.ini');

  strNomImp := fIdentificarNomeDaImpressora(strNomImp);

  frxTEF.PrintOptions.Printer := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
  frxTEF.PrintOptions.ShowDialog := False;

  If fEmptyStr(strLinhasPicote) Then
  Begin
    if Pos('[cortar papel]', strTextoTef) > 0 then
    begin
      stlTextoTef := fTrataTextoMultiplus(strTextoTef);
      try
        intQtdVia := stlTextoTef.Count - 1;
        for intPosicao := 0 to intQtdVia do
        begin
          frxTEF.Script.Variables['TEXTO1'] := stlTextoTef.Strings[intPosicao] + #13#10;
          frxTEF.PrintOptions.Printer := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
          frxTEF.PrintOptions.ShowDialog := False;

          if not fCfgSis('IMPCAB', varBoolean) then
            frxTEF.FindObject('rlbTitulo').Visible := False;

          If frxTEF.PrepareReport Then
            pPrintReport(Self.Name, 'Impressão TEF', strNomImp, frxTEF);

          If (intQtdVia > intPosicao) Then
            Sleep(1000);
        end;
      finally
        FreeAndNil(stlTextoTef);
      end
    end
    else
    begin
      if (intQtdeLinhasSalto > 1) then
        strTextoTef := fRetiraLinhasEmBrancoInicio_Fim_Texto(strTextoTef);

      for intPosicao := 1 to intQtdeLinhasSalto do
        strTextoTef := strTextoTef + #13#10;

      For intPosicao := 1 To intQtdVia Do
      Begin
        frxTEF.Script.Variables['TEXTO1'] := strTextoTef;
        frxTEF.PrintOptions.Printer := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
        frxTEF.PrintOptions.ShowDialog := False;

        if not fCfgSis('IMPCAB', varBoolean) then
          frxTEF.FindObject('rlbTitulo').Visible := False;

        If frxTEF.PrepareReport Then
          pPrintReport(Self.Name, 'Impressão TEF', strNomImp, frxTEF);

        If (intQtdVia > 1) Then
          Sleep(1000);
      End;
    end
  End
  Else
  Begin
    stlTextoPicote := TStringList.Create;
    stlLinhasPicote := TStringList.Create;
    stlTextoTef := TStringList.Create;
    if (intQtdeLinhasSalto <= 1) then
      stlTextoTef.Text := strTextoTef
    else
    begin
      stlTextoTef.Text := fRetiraLinhasEmBrancoInicio_Fim_Texto(strTextoTef);
      for intPosicao := 1 to intQtdeLinhasSalto do
        stlTextoTef.Add('');
    end;

    ExtractStrings([':'], [], PWideChar(strLinhasPicote), stlLinhasPicote);

    For intLinhaTef := 0 To stlLinhasPicote.Count Do
    Begin
      stlTextoPicote.Add('');
    End;

    {******************************************************}
    {* Monta um StringList onde cada item representa uma  *}
    {* parte do texto já considerando as linhas do picote *}
    {***************************************************MV*}
    intIndiceTexto := 0;
    For intLinhaTef := 0 To stlTextoTef.Count-1 Do
    Begin
      strLinhaTef := stlTextoTef[intLinhaTef];
      stlTextoPicote[intIndiceTexto] := stlTextoPicote[intIndiceTexto] + strLinhaTef + #13#10;

      If stlLinhasPicote.IndexOf(IntToStr(intLinhaTef+1)) > -1 Then
      Begin
        Inc(intIndiceTexto);
      End;
    End;

    For intPosicao := 1 To intQtdVia Do
    Begin
      For intIndiceTexto := 0 To stlTextoPicote.Count -1 Do
      Begin
        if not fCfgSis('IMPCAB', varBoolean) then
          frxTEF.FindObject('rlbTitulo').Visible := False
        else
          frxTEF.FindObject('rlbTitulo').Visible := ((intPosicao=1) And (intIndiceTexto=0));

        frxTEF.Script.Variables['TEXTO1'] := stlTextoPicote[intIndiceTexto];

        If frxTEF.PrepareReport Then
          pPrintReport(Self.Name, 'Impressão TEF', strNomImp, frxTEF);

      End;
    End;

    FreeAndNil(stlTextoPicote);
    FreeAndNil(stlLinhasPicote);
  End;

end;

procedure TfrmQckFatImpNFCe.pImprimirTefDaruma(strTextoTef: String);
  Var
    strCabecalho: String;
    strTextoImp: String;
    strTextoTmp: String;
    intQtdVia,
    intPosicao: Integer;
    stlTextoTef: TStringList;
    intQtdeLinhasSalto: Integer;
    strSalto: string;
begin
  pCarregarFuncoesDllDaruma;

  If (HandleDarumaFramework <> 0) And (Not Assigned(iImprimirTexto_DUAL_DarumaFramework)) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário atualizar a versão da Dll da Daruma. Caminho: ' +
      fArqIniLocal(0, 'NFCE', 'DARUMA_PATH_DLL', '', fCfgSis('PTNFCE') + '\opcoes_nfce.ini') , ['&Ok']);
    Exit;
  End;

  pInicializarDaruma;

  strCabecalho := fDarumaCentral(fDarumaNegrito(fCadEmpNomeEmpresa), fDarumaSaltar1) +
                  fDarumaNegrito('CNPJ: ' + fFormataCpfCgc(fCadEmp('C_G_C_'), opcBrasil) + ' I.E.: ' + fCadEmp('I_E_S_'), fDarumaSaltar1) +
                  fDarumaNegrito('I.M.: ' + fCadEmp('INSMUN'), fDarumaSaltar1) +
                  fDarumaCentral(fDarumaNegrito(fCadEmp('ENDERECO')), fDarumaSaltar1) +
                  fDarumaNegrito('CEP: ' + fFormataCEP(AnsiReplaceStr(fCadEmp('C_E_P_'), '-', '')) + ' - ' + 'TELEFONE: ' + fFormataFone(fCadEmp('FONE01')), fDarumaSaltar1);

  {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
  fiImprimirTexto_DUAL_DarumaFramework(strCabecalho + fDarumaAguarda, 0);
  {$WARN IMPLICIT_STRING_CAST_LOSS ON}

  intQtdVia := StrToIntDef(fCfgSis('VIAVIS'), 2);
  intQtdeLinhasSalto := StrToIntDef(fCfgSis('QTLNCO'), 0);
  strTextoTmp := '';
  strSalto := '';

  if Pos('[cortar papel]', strTextoTef) > 0 then
  begin
    stlTextoTef := fTrataTextoMultiplus(strTextoTef);
    try
      intQtdVia := stlTextoTef.Count - 1;
      For intPosicao := 0 To intQtdVia Do
        strTextoTmp := strTextoTmp + stlTextoTef.Strings[intPosicao] +
                       IIF((intQtdVia > 0) And (intPosicao < intQtdVia), #13#10 + #13#10, '');

    finally
      FreeAndNil(stlTextoTef);
    end
  end
  else
  begin
    if (intQtdeLinhasSalto > 1) then
    begin
      strTextoTef := fRetiraLinhasEmBrancoInicio_Fim_Texto(strTextoTef);
      for intPosicao := 1 to intQtdeLinhasSalto do
        strSalto := strSalto + #13#10;
    end
    else
      strSalto := strSalto + #13#10 + #13#10;

    For intPosicao := 1 To intQtdVia Do
      strTextoTmp := strTextoTmp + strTextoTef +
                     IIF((intQtdVia > 1) And (intPosicao < intQtdVia), strSalto, '');
  end;

  strTextoImp := AnsiReplaceStr(strTextoTmp, #13#10, fDarumaSaltar1);

  {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
  fiImprimirTexto_DUAL_DarumaFramework(strTextoImp + fDarumaAguarda + fDarumaSaltarN(5), 0);
  fiImprimirTexto_DUAL_DarumaFramework(fDarumaSaltarN(6) + fDarumaGuilhot, 0);
  {$WARN IMPLICIT_STRING_CAST_LOSS ON}
end;

procedure TfrmQckFatImpNFCe.pInicializarDaruma;
  Var
    intRetorno: Integer;
  procedure pChecarRetorno;
  begin
    Case intRetorno Of
      0: Raise Exception.Create('[0] - Impressora desligada');
      -27: Raise Exception.Create('[-27] - Erro generico');
      -50: Raise Exception.Create('[-50] - Impressora OFFLINE');
      -51: Raise Exception.Create('[-51] - Impressora sem papel!');
      -52: Raise Exception.Create('[-52] - Impressora inicializando');
    Else
      Raise Exception.Create('Retorno não esperado');
    End;
  end;
begin
  intRetorno := rStatusImpressora_DUAL_DarumaFramework;
  If intRetorno <> 1 Then
  Begin
    intRetorno := eBuscarPortaVelocidade_DUAL_DarumaFramework;
    If intRetorno <> 1 Then
    Begin
      pChecarRetorno;
    End;

    intRetorno := rStatusImpressora_DUAL_DarumaFramework;
    If intRetorno <> 1 Then
    Begin
      pChecarRetorno;
    End;
  End;
end;

function TfrmQckFatImpNFCe.fTrataTextoMultiplus(strTextoTef: String): TStringList;
  var
    intPosIni: Integer;
    intCortarPapel: Integer;
begin
  Result := TStringList.Create;
  intCortarPapel := 1;
  intPosIni := 1;
  while intCortarPapel > 0 do
  begin
    intPosIni := intCortarPapel;
    intCortarPapel := Pos('[cortar papel]', strTextoTef, intCortarPapel);
    if intCortarPapel > 0 Then
    begin
      Result.Add(Copy(strTextoTef, intPosIni, intCortarPapel - 1));
      intCortarPapel := intCortarPapel + 14;
    end;
  end;
  Result.Add(Copy(strTextoTef, intPosIni, strTextoTef.Length));
end;

procedure pAjustaBitmap(bitmap: TBitmap; intLargura, intAltura: Integer);
  Var
    fltEscala: Double;
    tmp: TBitmap;
    vrect: TRect;
begin
  if (intLargura < intAltura) then
  begin
    fltEscala := intLargura / bitmap.Width;
  end else
  begin
    fltEscala := intAltura / bitmap.Height;
  end;

  vrect := Rect(0, 0, bitmap.Width, bitmap.Height);

  tmp := TBitmap.Create;
  tmp.Width := 138;
  tmp.Height := 138;
//  tmp.Assign(bitmap);
//  tmp.Dormant;
//  tmp.FreeImage;

  bitmap.Canvas.StretchDraw(Rect(0, 0, Trunc(fltEscala * bitmap.Width), Trunc(fltEscala * bitmap.Height)), tmp);

  FreeAndNil(tmp);
end;

procedure pImprimirNFCe(strNumDoc,
                        strEspDoc,
                        strCodEmp,
                        strCodCli,
                        strSerie,
                        strTip_FC: String;
                        strImpressora: String='';
                        blnSatComplementar: Boolean=False;
                        blnReimpressao: Boolean=False;
                        blnGerarPDF: Boolean = False;
                        intQtdVias: Integer = -1);
var
  strChaveAcesso: String;
begin
  Try
    pCriarFormularios(TfrmQckFatImpNFCe,frmQckFatImpNFCe);

    strChaveAcesso := fRetornaChaveAcesso(strNumDoc,
                                          strEspDoc,
                                          strCodEmp,
                                          strCodCli,
                                          strSerie,
                                          strTip_FC);

    If fEmptyStr(fArqIniLocal(0, 'NFCE', 'DARUMA_PATH_DLL', '', fCfgSis('PTNFCE') + '\opcoes_nfce.ini')) Then
    Begin
      if fUsaSat then
      begin
        If fCfgSis('NFISAT', varBoolean) Then
        begin
          if blnReimpressao then
            TImpressaoDiretaCitel.pImprimir(strCodEmp, strImpressora, strChaveAcesso, 'NFCE', blnReimpressao)
        end
        else
          frmQckFatImpNFCe.pImprimirDanfeSAT(strNumDoc, strEspDoc, strCodEmp, strCodCli,
            strSerie, strTip_FC, strImpressora, blnSatComplementar);
      end
      else
      begin
        If fEmptyStr(strImpressora) Then
          strImpressora := fRetornaFilaImpressaoNFCe;

        If fExisteFilaImpressaoNFCe And fEmptyStr(strImpressora) Then
          Exit;

        if fCfgSis('PRNFCE', varBoolean) Then
        begin
          if blnReimpressao then
            TImpressaoDiretaCitel.pImprimir(strCodEmp, strImpressora, strChaveAcesso, 'NFCE', blnReimpressao)
        end
        else
        begin
          If fCfgSis('NFCRED', varBoolean) Then
            frmQckFatImpNFCe.pImprimirDanfeNFCeReduzido(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strTip_FC, strImpressora, blnGerarPDF, strChaveAcesso)
          else
            frmQckFatImpNFCe.pImprimirDanfeNFCe(strNumDoc,
                                                strEspDoc,
                                                strCodEmp,
                                                strCodCli,
                                                strSerie,
                                                strTip_FC,
                                                strImpressora,
                                                blnGerarPDF,
                                                strChaveAcesso,
                                                True,
                                                '',
                                                intQtdVias);
        end;
      end;
    End
    Else
    Begin
      frmQckFatImpNFCe.pImprimirDanfeNFCeDaruma(strNumDoc, strEspDoc, strCodEmp, strCodCli,
        strSerie, strTip_FC, strImpressora);
    End;
  Finally
    pFreeAndNil(frmQckFatImpNFCe);
  End;
end;

procedure pImprimirDadosEntregaNFCe(dadosCupom: TDadosImpressaoVenda);
begin
  pCriarFormularios(TfrmQckFatImpNFCe, frmQckFatImpNFCe);

  If Not fEmptyStr(fArqIniLocal(0, 'NFCE', 'DARUMA_PATH_DLL', '', fCfgSis('PTNFCE') + '\opcoes_nfce.ini')) Then
    frmQckFatImpNFCe.pImprimirDadosEntregaDaruma(dadosCupom)
  Else
    frmQckFatImpNFCe.pImprimirDadosEntrega(dadosCupom);

  pFreeAndNil(frmQckFatImpNFCe);
end;

procedure pImprimirTef(strTextoTef, strLinhasPicote: String; const AblnQtdViasExterna: Boolean = False);
var
  frmQckFatImpNFCe : TfrmQckFatImpNFCe;
begin
  pCriarFormularios(TfrmQckFatImpNFCe,frmQckFatImpNFCe);
  Try
    If Not fEmptyStr(fArqIniLocal(0, 'NFCE', 'DARUMA_PATH_DLL', '', fCfgSis('PTNFCE') + '\opcoes_nfce.ini')) Then
    Begin
      frmQckFatImpNFCe.pImprimirTefDaruma(strTextoTef);
    End
    Else
    Begin
      frmQckFatImpNFCe.pImprimirTef(strTextoTef, strLinhasPicote, AblnQtdViasExterna);
    End;
  Finally
    pFreeAndNil(frmQckFatImpNFCe);
  End;
end;

procedure pImprimirCancelamentoSAT(strNumDoc, strEspDoc, strCodEmp, strCodCli,
  strSerie, strTip_FC: String; strImpressora: String='');
begin
  pCriarFormularios(TfrmQckFatImpNFCe, frmQckFatImpNFCe);
  frmQckFatImpNFCe.pImprimirCancelamentoSAT(strNumDoc, strEspDoc, strCodEmp, strCodCli,
    strSerie, strTip_FC, strImpressora);
  pFreeAndNil(frmQckFatImpNFCe);
end;

procedure pImprimirCarnePagto(strBarCon: String; fltLimiteCredito: Double;
  strCodCli, strNomCli, strNomVen, dtaDtaCom: String; FDuplic: TArrDuplicatas);
begin
  If Length(FDuplic) > 0 Then
  Begin
    pCriarFormularios(TfrmQckFatImpNFCe,frmQckFatImpNFCe);
    frmQckFatImpNFCe.pImprimirCarnePagto(strBarCon, fltLimiteCredito,
      strCodCli, strNomCli, strNomVen, dtaDtaCom, FDuplic);
    pFreeAndNil(frmQckFatImpNFCe);
  End;
end;

procedure pImprimirContrato(strBarCon: String; opcOpcCon: TOpcaoContrato;
  FDuplic, FDupRep: TArrDuplicatas; strCodCli, strNomCli, strNomVen: String;
  fltTotDup, fltTotRec: Double; strMenPed, dtaDtaCom: String);
begin
  If Length(FDuplic) > 0 Then
  Begin
    pCriarFormularios(TfrmQckFatImpNFCe,frmQckFatImpNFCe);
    frmQckFatImpNFCe.pImprimirContrato(strBarCon, opcOpcCon, FDuplic, FDupRep,
      strCodCli, strNomCli, strNomVen, fltTotDup, fltTotRec, strMenPed, dtaDtaCom);
    pFreeAndNil(frmQckFatImpNFCe);
  End;
end;

function TfrmQckFatImpNFCe.fImpPorTerminalTef : Boolean;
begin
  Result := True;

  if not VS_blnTefCitel then
    Result := False;

  if fEmptyStr(fRetNomeImpressoraTerminal) then
    Result := False;
end;

procedure TfrmQckFatImpNFCe.pSalvarDanfe(ADanfe: TfrxReport; AChaveAcesso: String);
var
  LPDFExport: TfrxPDFExport;
  LStreamPDF: TStringStream;
begin
  If fEmptyStr(AChaveAcesso) Then
    Exit;

  LPDFExport := TfrxPDFExport.Create(nil);
  LStreamPDF := TStringStream.Create;

  Try
    LPDFExport.Stream        := LStreamPDF;
    LPDFExport.ShowDialog    := False;
    LPDFExport.Background    := True;
    LPDFExport.EmbeddedFonts := True;
    LPDFExport.Subject       := 'Exportando DANFE para PDF';
    LPDFExport.ShowProgress  := False;

    ADanfe.PrintOptions.ShowDialog := False;
    ADanfe.PrepareReport;
    ADanfe.Export(LPDFExport);

    If not fEmptyStr(LStreamPDF.DataString) Then
    Begin
      pSalvarPDFNFeBD(AChaveAcesso, LStreamPDF.DataString);
    End;
  Finally
    FreeAndNil(LPDFExport);
    FreeAndNil(LStreamPDF);
  End;
end;

function TfrmQckFatImpNFCe.fRetornaSqlCodIte() : String;
begin
  If (fCfgSis('CODTIN') = '2') Then
    Result := 'IF(TRIM(IFNULL(DET_CODACA,"")) <> "",  CONCAT(DET_CODACA,"-",DET_EMPACA), DET_CODITE)'
  Else If (fCfgSis('CODTIN') = '3') Then
    Result := 'IF(TRIM(IFNULL(ACA_UNITIN,"")) <> "",  ACA_UNITIN, DET_CODITE)'
  Else
    Result := 'DET_CODITE';
end;

initialization

finalization
  If HandleDarumaFramework <> 0 Then
  Begin
    Try
      FreeLibrary(HandleDarumaFramework);
    Except
    End;
  End;

end.

