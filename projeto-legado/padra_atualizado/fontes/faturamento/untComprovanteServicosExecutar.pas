unit untComprovanteServicosExecutar;

interface

uses
  System.SysUtils, System.Classes, frxExportRTF, frxExportXLS, frxExportHTML,
  frxClass, frxExportPDF, frxDBSet, untZClient, Uni, StrUtils, Data.DB,
  Forms;

type
  TfrmComprovanteServicosExecutar = class(TForm)
    frxDBDataset: TfrxDBDataset;
    frxExpPDF: TfrxPDFExport;
    frxExpHtml: TfrxHTMLExport;
    frxExpXLS: TfrxXLSExport;
    frxExpRTF: TfrxRTFExport;
    frxReport: TfrxReport;
  private
    cdsRelatorio : TZClient;

    function fGetSQL : String;
  public
    Class Procedure pImprime(strNumDoc, strEspDoc, strCodEmp : String);
    Class function fImprimeLayoutEditor(strNumDoc, strEspDoc, strCodEmp, strCodCli: string): Boolean;
    Class function fRetornaCodLayout(strNome: string; intTipLay: integer): string;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses untFuncoesSimples, untCfgRel, untEditorFastImpressao, untTypesSistema;

{$R *.dfm}

{ TfrmComprovanteServicosExecutar }

function TfrmComprovanteServicosExecutar.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT CONCAT(                                                           ';
  Result := Result + '        IF(GER_CODS01 IS NOT NULL, CONCAT(GER_CODS01, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS02 IS NOT NULL, CONCAT(GER_CODS02, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS03 IS NOT NULL, CONCAT(GER_CODS03, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS04 IS NOT NULL, CONCAT(GER_CODS04, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS05 IS NOT NULL, CONCAT(GER_CODS05, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS06 IS NOT NULL, CONCAT(GER_CODS06, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS07 IS NOT NULL, CONCAT(GER_CODS07, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS08 IS NOT NULL, CONCAT(GER_CODS08, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS09 IS NOT NULL, CONCAT(GER_CODS09, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS10 IS NOT NULL, CONCAT(GER_CODS10, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS11 IS NOT NULL, CONCAT(GER_CODS11, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS12 IS NOT NULL, CONCAT(GER_CODS12, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS13 IS NOT NULL, CONCAT(GER_CODS13, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS14 IS NOT NULL, CONCAT(GER_CODS14, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS15 IS NOT NULL, CONCAT(GER_CODS15, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS16 IS NOT NULL, CONCAT(GER_CODS16, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS17 IS NOT NULL, CONCAT(GER_CODS17, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS18 IS NOT NULL, CONCAT(GER_CODS18, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS19 IS NOT NULL, CONCAT(GER_CODS19, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS20 IS NOT NULL, CONCAT(GER_CODS20, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS21 IS NOT NULL, CONCAT(GER_CODS21, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS22 IS NOT NULL, CONCAT(GER_CODS22, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS23 IS NOT NULL, CONCAT(GER_CODS23, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS24 IS NOT NULL, CONCAT(GER_CODS24, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS25 IS NOT NULL, CONCAT(GER_CODS25, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS26 IS NOT NULL, CONCAT(GER_CODS26, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS27 IS NOT NULL, CONCAT(GER_CODS27, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS28 IS NOT NULL, CONCAT(GER_CODS28, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS29 IS NOT NULL, CONCAT(GER_CODS29, "<<csq>>"), ""),    ';
  Result := Result + '        IF(GER_CODS30 IS NOT NULL, CONCAT(GER_CODS30, "<<csq>>"), "")     ';
  Result := Result + '        ) AS CODSER,                                                      ';

  Result := Result + '        CONCAT(                                                           ';
  Result := Result + '        IF(GER_DESS01 <> "", CONCAT(GER_DESS01, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS02 <> "", CONCAT(GER_DESS02, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS03 <> "", CONCAT(GER_DESS03, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS04 <> "", CONCAT(GER_DESS04, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS05 <> "", CONCAT(GER_DESS05, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS06 <> "", CONCAT(GER_DESS06, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS07 <> "", CONCAT(GER_DESS07, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS08 <> "", CONCAT(GER_DESS08, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS09 <> "", CONCAT(GER_DESS09, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS10 <> "", CONCAT(GER_DESS10, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS11 <> "", CONCAT(GER_DESS11, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS12 <> "", CONCAT(GER_DESS12, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS13 <> "", CONCAT(GER_DESS13, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS14 <> "", CONCAT(GER_DESS14, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS15 <> "", CONCAT(GER_DESS15, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS16 <> "", CONCAT(GER_DESS16, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS17 <> "", CONCAT(GER_DESS17, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS18 <> "", CONCAT(GER_DESS18, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS19 <> "", CONCAT(GER_DESS19, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS20 <> "", CONCAT(GER_DESS20, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS21 <> "", CONCAT(GER_DESS21, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS22 <> "", CONCAT(GER_DESS22, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS23 <> "", CONCAT(GER_DESS23, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS24 <> "", CONCAT(GER_DESS24, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS25 <> "", CONCAT(GER_DESS25, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS26 <> "", CONCAT(GER_DESS26, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS27 <> "", CONCAT(GER_DESS27, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS28 <> "", CONCAT(GER_DESS28, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS29 <> "", CONCAT(GER_DESS29, "<<csq>>"), ""),          ';
  Result := Result + '        IF(GER_DESS30 <> "", CONCAT(GER_DESS30, "<<csq>>"), "")           ';
  Result := Result + '        ) AS DESSER,                                                      ';

  Result := Result + '        CONCAT(                                                           ';
  Result := Result + '        IF(GER_VALS01 > 0, CONCAT(FORMAT(GER_VALS01,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS02 > 0, CONCAT(FORMAT(GER_VALS02,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS03 > 0, CONCAT(FORMAT(GER_VALS03,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS04 > 0, CONCAT(FORMAT(GER_VALS04,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS05 > 0, CONCAT(FORMAT(GER_VALS05,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS06 > 0, CONCAT(FORMAT(GER_VALS06,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS07 > 0, CONCAT(FORMAT(GER_VALS07,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS08 > 0, CONCAT(FORMAT(GER_VALS08,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS09 > 0, CONCAT(FORMAT(GER_VALS09,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS10 > 0, CONCAT(FORMAT(GER_VALS10,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS11 > 0, CONCAT(FORMAT(GER_VALS11,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS12 > 0, CONCAT(FORMAT(GER_VALS12,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS13 > 0, CONCAT(FORMAT(GER_VALS13,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS14 > 0, CONCAT(FORMAT(GER_VALS14,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS15 > 0, CONCAT(FORMAT(GER_VALS15,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS16 > 0, CONCAT(FORMAT(GER_VALS16,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS17 > 0, CONCAT(FORMAT(GER_VALS17,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS18 > 0, CONCAT(FORMAT(GER_VALS18,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS19 > 0, CONCAT(FORMAT(GER_VALS19,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS20 > 0, CONCAT(FORMAT(GER_VALS20,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS21 > 0, CONCAT(FORMAT(GER_VALS21,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS22 > 0, CONCAT(FORMAT(GER_VALS22,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS23 > 0, CONCAT(FORMAT(GER_VALS23,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS24 > 0, CONCAT(FORMAT(GER_VALS24,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS25 > 0, CONCAT(FORMAT(GER_VALS25,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS26 > 0, CONCAT(FORMAT(GER_VALS26,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS27 > 0, CONCAT(FORMAT(GER_VALS27,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS28 > 0, CONCAT(FORMAT(GER_VALS28,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS29 > 0, CONCAT(FORMAT(GER_VALS29,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(GER_VALS30 > 0, CONCAT(FORMAT(GER_VALS30,2), "<<csq>>"), "")   ';
  Result := Result + '        ) AS VALSER,                                                      ';

  Result := Result + '        CONCAT(                                                         ';
  Result := Result + '        IF(IFNULL(GER_CODS01,"") <> "", CONCAT(FORMAT(GER_QTDS01,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS02,"") <> "", CONCAT(FORMAT(GER_QTDS02,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS03,"") <> "", CONCAT(FORMAT(GER_QTDS03,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS04,"") <> "", CONCAT(FORMAT(GER_QTDS04,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS05,"") <> "", CONCAT(FORMAT(GER_QTDS05,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS06,"") <> "", CONCAT(FORMAT(GER_QTDS06,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS07,"") <> "", CONCAT(FORMAT(GER_QTDS07,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS08,"") <> "", CONCAT(FORMAT(GER_QTDS08,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS09,"") <> "", CONCAT(FORMAT(GER_QTDS09,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS10,"") <> "", CONCAT(FORMAT(GER_QTDS10,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS11,"") <> "", CONCAT(FORMAT(GER_QTDS11,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS12,"") <> "", CONCAT(FORMAT(GER_QTDS12,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS13,"") <> "", CONCAT(FORMAT(GER_QTDS13,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS14,"") <> "", CONCAT(FORMAT(GER_QTDS14,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS15,"") <> "", CONCAT(FORMAT(GER_QTDS15,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS16,"") <> "", CONCAT(FORMAT(GER_QTDS16,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS17,"") <> "", CONCAT(FORMAT(GER_QTDS17,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS18,"") <> "", CONCAT(FORMAT(GER_QTDS18,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS19,"") <> "", CONCAT(FORMAT(GER_QTDS19,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS20,"") <> "", CONCAT(FORMAT(GER_QTDS20,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS21,"") <> "", CONCAT(FORMAT(GER_QTDS21,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS22,"") <> "", CONCAT(FORMAT(GER_QTDS22,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS23,"") <> "", CONCAT(FORMAT(GER_QTDS23,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS24,"") <> "", CONCAT(FORMAT(GER_QTDS24,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS25,"") <> "", CONCAT(FORMAT(GER_QTDS25,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS26,"") <> "", CONCAT(FORMAT(GER_QTDS26,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS27,"") <> "", CONCAT(FORMAT(GER_QTDS27,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS28,"") <> "", CONCAT(FORMAT(GER_QTDS28,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS29,"") <> "", CONCAT(FORMAT(GER_QTDS29,2), "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS30,"") <> "", CONCAT(FORMAT(GER_QTDS30,2), "<<csq>>"), "")   ';
  Result := Result + '        ) AS QTDSER,                                                              ';

  Result := Result + '        CONCAT(                                                              ';
  Result := Result + '        IF(IFNULL(GER_CODS01,"") <> "", CONCAT(GER_PRIS01, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS02,"") <> "", CONCAT(GER_PRIS02, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS03,"") <> "", CONCAT(GER_PRIS03, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS04,"") <> "", CONCAT(GER_PRIS04, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS05,"") <> "", CONCAT(GER_PRIS05, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS06,"") <> "", CONCAT(GER_PRIS06, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS07,"") <> "", CONCAT(GER_PRIS07, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS08,"") <> "", CONCAT(GER_PRIS08, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS09,"") <> "", CONCAT(GER_PRIS09, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS10,"") <> "", CONCAT(GER_PRIS10, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS11,"") <> "", CONCAT(GER_PRIS11, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS12,"") <> "", CONCAT(GER_PRIS12, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS13,"") <> "", CONCAT(GER_PRIS13, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS14,"") <> "", CONCAT(GER_PRIS14, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS15,"") <> "", CONCAT(GER_PRIS15, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS16,"") <> "", CONCAT(GER_PRIS16, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS17,"") <> "", CONCAT(GER_PRIS17, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS18,"") <> "", CONCAT(GER_PRIS18, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS19,"") <> "", CONCAT(GER_PRIS19, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS20,"") <> "", CONCAT(GER_PRIS20, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS21,"") <> "", CONCAT(GER_PRIS21, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS22,"") <> "", CONCAT(GER_PRIS22, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS23,"") <> "", CONCAT(GER_PRIS23, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS24,"") <> "", CONCAT(GER_PRIS24, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS25,"") <> "", CONCAT(GER_PRIS25, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS26,"") <> "", CONCAT(GER_PRIS26, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS27,"") <> "", CONCAT(GER_PRIS27, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS28,"") <> "", CONCAT(GER_PRIS28, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS29,"") <> "", CONCAT(GER_PRIS29, "<<csq>>"), ""),  ';
  Result := Result + '        IF(IFNULL(GER_CODS30,"") <> "", CONCAT(GER_PRIS30, "<<csq>>"), "")   ';
  Result := Result + '        ) AS PRISMA,                                                         ';

  Result := Result + '        GER_CODEMP,                                                     ';
  Result := Result + '        EMP_NOMFAN AS EMP_NOMEMP,                                       ';
  Result := Result + '        GER_CODCLI,                                                     ';
  Result := Result + '        CLI_NOMCLI,                                                     ';
  Result := Result + '        AUX_PLAVEI,                                                     ';
  Result := Result + '        MOD_DESMOD AS VEI_DESVEI,                                       ';
  Result := Result + '        GER_CODVEN,                                                     ';
  Result := Result + '      V.OPE_NOMOPE,                                                     ';
  Result := Result + '        GER_CODDIG,                                                     ';
  Result := Result + '      D.OPE_NOMOPE AS OPE_NOMDIG,                                       ';
  Result := Result + '        GER_DTAENT,                                                     ';
  Result := Result + '        GER_HORENT,                                                     ';
  Result := Result + '        GER_NUMDOC,                                                     ';
  Result := Result + '        GER_ESPDOC                                                      ';

  Result := Result + ' FROM MOVGER                                                            ';
  Result := Result + ' INNER JOIN SERMOV G ON G.GER_SEQGER = MOVGER.AUTOINCREM                ';
  Result := Result + ' INNER JOIN AUXMOV E ON E.AUX_SEQGER = MOVGER.AUTOINCREM                ';
  Result := Result + ' INNER JOIN CADEMP   ON   EMP_CODEMP = GER_CODEMP                       ';
  Result := Result + ' INNER JOIN CADCLI   ON   CLI_CODCLI = GER_CODCLI                       ';
  Result := Result + ' LEFT  JOIN CADVEI   ON   VEI_PLAVEI = AUX_PLAVEI                       ';
  Result := Result + ' LEFT  JOIN CADOPE V ON V.OPE_CODOPE = GER_CODVEN                       ';
  Result := Result + ' LEFT  JOIN CADOPE D ON D.OPE_CODOPE = GER_CODDIG                       ';
  Result := Result + ' LEFT  JOIN MODVEI   ON   MOD_CODMOD = VEI_CODMOD                       ';
  Result := Result + ' WHERE GER_CODEMP = :CODEMP                                             ';
  Result := Result + '   AND GER_NUMDOC = :NUMDOC                                             ';
  Result := Result + '   AND GER_ESPDOC = :ESPDOC                                             ';

end;

Class function TfrmComprovanteServicosExecutar.fImprimeLayoutEditor(strNumDoc,
  strEspDoc, strCodEmp, strCodCli: string): Boolean;
var
  objImpressao: TEditorFastImpressao;
Begin
  objImpressao := TEditorFastImpressao.Create(Nil);

  try
    objImpressao.recDocume.strNumDoc        := strNumDoc;
    objImpressao.recDocume.strEspDoc        := strEspDoc;
    objImpressao.recDocume.strCodEmp        := strCodEmp;

    objImpressao.recDocume.strCodCli := strCodCli;

    objImpressao.recDocume.strSaida  := 'V';
    objImpressao.recDocume.strTipFC  := 'C';
    objImpressao.recDocume.intQtdImp := 1;

    objImpressao.recDocume.blnReimpr := True;
    objImpressao.recDocume.blnDocCan := False;


    objImpressao.recDocume.blnSimples := True;


    objImpressao.recDocume.opcAbastecimento         := opcTodos;
    objImpressao.recDocume.cdsLogSeparacao          := Nil;

    objImpressao.tpeTipoEtiqueta := tpeCupomServico;

    objImpressao.recDocume.strCodLay := fRetornaCodLayout('Cupom de Serviço', 152);


    objImpressao.fImprimeDocumento;

    Result := objImpressao.recDocume.blnTemLay and objImpressao.recDocume.blnImprimiu;
  finally
    If Assigned(objImpressao) Then
      FreeAndNil(objImpressao);
  end;
End;

Class function TfrmComprovanteServicosExecutar.fRetornaCodLayout(strNome: string;
  intTipLay: integer): string;
var
  qryCodLay: TUniQuery;
begin
  Result := EmptyStr;
  qryCodLay := fCriaQuery;

  try
    qryCodLay.Close;
    qryCodLay.SQL.Clear;
    qryCodLay.SQL.Add('SELECT LAY_CODLAY');
    qryCodLay.SQL.Add('FROM LAYETI');
    qryCodLay.SQL.Add('WHERE LAY_NOMLAY = :NOMLAY');
    qryCodLay.SQL.Add('AND LAY_TIPLAY = :TIPLAY');
    qryCodLay.SQL.Add('AND LAY_CODEMP = :CODEMP');

    qryCodLay.ParamByName('NOMLAY').AsString := strNome;
    qryCodLay.ParamByName('TIPLAY').AsInteger := intTipLay;
    qryCodLay.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryCodLay.Open;

    if not qryCodLay.IsEmpty then
    begin
      Result := qryCodLay.FieldByName('LAY_CODLAY').AsString;
    end;
  finally
    FreeAndNil(qryCodLay);
  end;
end;

class procedure TfrmComprovanteServicosExecutar.pImprime(strNumDoc, strEspDoc, strCodEmp: String);
  var
    frmCompServExec: TfrmComprovanteServicosExecutar;
    strNomImp  : String;
    strTipImp  : String;
    blnImprime : Boolean;
    qryCfgRel  : TUniQuery;
begin
  pCriarFormularios(TfrmComprovanteServicosExecutar, frmCompServExec);
  qryCfgRel := fCriaQuery(frmCompServExec);
  Try
    With frmCompServExec Do
    Begin
      cdsRelatorio := TZClient.Create(frmCompServExec, fGetSQL);

      cdsRelatorio.qryQuery.ParamByName('NUMDOC').AsString := strNumDoc;
      cdsRelatorio.qryQuery.ParamByName('ESPDOC').AsString := strEspDoc;
      cdsRelatorio.qryQuery.ParamByName('CODEMP').AsString := strCodEmp;

      cdsRelatorio.fAbreClient(True, 'TfrmComprovanteServicosExecutar.pImprime');

      If cdsRelatorio.IsEmpty Then
        Exit;

      pCarregaConfImpr(qryCfgRel, frmCompServExec.Name);
      blnImprime := fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, 'V');

      If Not blnImprime Then
        Exit;

      frxDBDataset.DataSet := cdsRelatorio;

      frxReport.PrintOptions.Printer   := AnsiReplaceStr(strNomImp,'\\' + fRetNomeRede + '\','');
      frxReport.PreviewOptions.Buttons := [pbPrint,pbLoad,pbSave,pbExport,pbZoom,pbFind,pbOutline,pbPageSetup,pbTools,pbNavigator];

      If frxReport.PrepareReport Then
      Begin
        If fEmptyStr(strNomImp) Then
          pPreviewReport(frmCompServExec.Name, 'Comprovante de Serviços', frxReport)
        Else
        Begin
          frxReport.PrintOptions.ShowDialog := False;
          pPrintReport(frmCompServExec.Name, 'Comprovante de Serviços', strNomImp, frxReport);
        End;
      End;

    End;
  Finally
    FreeAndNil(qryCfgRel);
    FreeAndNil(frmCompServExec);
  End;

end;

end.
