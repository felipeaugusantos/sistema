unit untXMLConsumoItem;

interface

uses
  System.SysUtils,
  Uni,
  untFuncoesSimples;

type
  TXMLConsumoItem = class
  private
    FqryComand: TUniQuery;

    // Variáveis de Controle e Autoincremento
    FstrMovGerAutInc: String;
    FstrAutIncMovDet: String;

    // Variáveis de Identificação do Documento
    FstrNumDoc: String;
    FstrEspDoc: String;
    FstrCodEmp: String;
    FstrCodFor: String;
    FstrSerie: String;

    // Variáveis Fiscais e de Impostos
    FstrCST: String;
    FstrcClassTrib: String;
    FClaFi1: String;
    FcurvBC: Double;
    FfloFpCBS: Double;
    FfloFpAliqEfetCBS: Double;
    FcurvCBS: Double;
    FdobpIBSUF: Double;
    FdobpAliqEfetUF: Double;
    FcurvIBSUF: Double;
    FdobpIBSMun: Double;
    FdobFpAliqEfetMun: Double;
    FcurvIBSMun: Double;
    FcurvIBSTot: Double;
    FcurvTotNF: Double;
    FstrCSTReg : String; // -> REF_CSTREG
    FdobpAliqEfetRegIBSUF : Double; // -> REF_AIUREG
    FdobvTribRegIBSUF : Double; // -> REF_TIUREG
    FdobpAliqEfetRegIBSMun : Double; // -> REF_AIMREG
    FdobvTribRegIBSMun : Double; // -> REF_TIMREG
    FdobpAliqEfetRegCBS : Double; // -> REF_CBSREG
    FdobvTribRegCBS : Double; // -> REF_TCBREG
    // gSCEE
    FstrTpPartComp : String; // -> REF_TPPCOM
    FstrIdAcessGer : String; // -> REF_IDACGE
    FdobVPotInst : Double; // -> REF_VPTINS
    FstrTpFonteEnergia : String; // -> REF_TPFENE
    FdobEnerAloc : Double; // -> REF_ENEALO
    FstrTpPosTar : String; // -> REF_TPPTAR
    FdobEnerInjet : Double; // -> REF_ENEINJ
    FstrTpPosTarInjet : String; // -> REF_TPPINJ
    procedure pMontaSQLMovDet;
    procedure pMontaSQLMovGer;
    function fRetAutoIncremNatCfo(AStrNatCfo: String): String;
  public
    constructor Create;
    destructor Destroy; override;

    function fCriarMovger: Boolean;

    // Funções de Identificação do Documento
    function NumDoc(AstrNumDoc: String): TXMLConsumoItem;
    function EspDoc(AstrEspDoc: String): TXMLConsumoItem;
    function CodEmp(AstrCodEmp: String): TXMLConsumoItem;
    function CodFor(AstrCodFor: String): TXMLConsumoItem;
    function Serie(AstrSerie: String): TXMLConsumoItem;

    // Funções Fiscais
    function CST(AstrCST: String): TXMLConsumoItem;
    function ClassTrib(AstrcClassTrib: String): TXMLConsumoItem;
    function ClaFi1(AClaFi1: String): TXMLConsumoItem;

    // Funções de Valores e Impostos
    function vBC(AcurvBC: Double): TXMLConsumoItem;
    function FpCBS(AfloFpCBS: Double): TXMLConsumoItem;
    function pAliqEfetCBS(AfloFpAliqEfetCBS: Double): TXMLConsumoItem;
    function vCBS(AcurvCBS: Double): TXMLConsumoItem;
    function pIBSUF(AdobpIBSUF: Double): TXMLConsumoItem;
    function pAliqEfetUF(AdobpAliqEfetUF: Double): TXMLConsumoItem;
    function vIBSUF(AcurvIBSUF: Double): TXMLConsumoItem;
    function pIBSMun(AdobpIBSMun: Double): TXMLConsumoItem;
    function pAliqEfetMun(AdobFpAliqEfetMun: Double): TXMLConsumoItem;
    function IBSMun(AcurvIBSMun: Double): TXMLConsumoItem;
    function IBSTot(AcurvIBSTot: Double): TXMLConsumoItem;
    function TotNF(AcurvTotNF: Double): TXMLConsumoItem;
    function CSTReg(AValue: String): TXMLConsumoItem;
    function pAliqEfetRegIBSUF(AValue: Double): TXMLConsumoItem;
    function vTribRegIBSUF(AValue: Double): TXMLConsumoItem;
    function pAliqEfetRegIBSMun(AValue: Double): TXMLConsumoItem;
    function vTribRegIBSMun(AValue: Double): TXMLConsumoItem;
    function pAliqEfetRegCBS(AValue: Double): TXMLConsumoItem;
    function vTribRegCBS(AValue: Double): TXMLConsumoItem;
    function TpPartComp(AValue: String): TXMLConsumoItem;
    function IdAcessGer(AValue: String): TXMLConsumoItem;
    function VPotInst(AValue: Double): TXMLConsumoItem;
    function TpFonteEnergia(AValue: String): TXMLConsumoItem;
    function EnerAloc(AValue: Double): TXMLConsumoItem;
    function TpPosTar(AValue: String): TXMLConsumoItem;
    function EnerInjet(AValue: Double): TXMLConsumoItem;
    function TpPosTarInjet(AValue: String): TXMLConsumoItem;
  end;

implementation

constructor TXMLConsumoItem.Create;
begin
  inherited;
  FqryComand := fCriaQuery;
end;

destructor TXMLConsumoItem.Destroy;
begin
  FqryComand.Free;
  inherited;
end;

function TXMLConsumoItem.fCriarMovger: Boolean;
begin
  try
    FstrMovGerAutInc := fRetAutoIncrem('MOVGER', VS_StrCodEmp);
    pMontaSQLMovGer;
    pMontaSQLMovDet;
    Result := True;
  except
    on E: Exception do
      raise Exception.Create('[TXMLConsumoItem.fCriarMovger] ' + E.Message);
  end;
end;

procedure TXMLConsumoItem.pMontaSQLMovDet;
begin
  FstrAutIncMovDet := fRetAutoIncrem('MOVDET', VS_StrCodEmp);

  FqryComand.SQL.Clear;
  FqryComand.SQL.Add('INSERT INTO MOVDET (');
  FqryComand.SQL.Add('            DET_SEQGER,');
  FqryComand.SQL.Add('            AUTOINCREM,');
  FqryComand.SQL.Add('            DET_CODEMP,');
  FqryComand.SQL.Add('            DET_CODVEN,');
  FqryComand.SQL.Add('            DET_CODITE,');
  FqryComand.SQL.Add('            DET_CODDIV,');
  FqryComand.SQL.Add('            DET_CODMAR,');
  FqryComand.SQL.Add('            DET_CODFOR,');
  FqryComand.SQL.Add('            DET_CODCLI,');
  FqryComand.SQL.Add('            DET_NUMDOC,');
  FqryComand.SQL.Add('            DET_ESPDOC,');
  FqryComand.SQL.Add('            DET_SERIE_,');
  FqryComand.SQL.Add('            DET_DTAENT,');
  FqryComand.SQL.Add('            DET_HORENT,');
  FqryComand.SQL.Add('            DET_DTADOC,');
  FqryComand.SQL.Add('            DET_CONPAG,');
  FqryComand.SQL.Add('            DET_TIP_FC,');
  FqryComand.SQL.Add('            DET_ESTADO,');
  FqryComand.SQL.Add('            DET_DESCRI,');
  FqryComand.SQL.Add('            DET_REFERE,');
  FqryComand.SQL.Add('            DET_UNIDAD,');
  FqryComand.SQL.Add('            DET_FORITE,');
  FqryComand.SQL.Add('            DET_QTDITE,');
  FqryComand.SQL.Add('            DET_UNITAR,');
  FqryComand.SQL.Add('            DET_UNIORI,');
  FqryComand.SQL.Add('            DET_UNIDIG,');
  FqryComand.SQL.Add('            DET_TOTITE,');
  FqryComand.SQL.Add('            DET_VLRCON,');
  FqryComand.SQL.Add('            DET_TOTCUS,');
  FqryComand.SQL.Add('            DET_TOTMED,');
  FqryComand.SQL.Add('            DET_DESCON,');
  FqryComand.SQL.Add('            DET_TOTFRE,');
  FqryComand.SQL.Add('            DET_DESESP,');
  FqryComand.SQL.Add('            DET_DESACE,');
  FqryComand.SQL.Add('            DET_CODREP,');
  FqryComand.SQL.Add('            DET_COMREP,');
  FqryComand.SQL.Add('            DET_PERREP,');
  FqryComand.SQL.Add('            DET_PERCOM,');
  FqryComand.SQL.Add('            DET_TOTCOM,');
  FqryComand.SQL.Add('            DET_CLAFIS,');
  FqryComand.SQL.Add('            DET_CODFIS,');
  FqryComand.SQL.Add('            DET_VALIPI,');
  FqryComand.SQL.Add('            DET_ALQIPI,');
  FqryComand.SQL.Add('            DET_BASIPI,');
  FqryComand.SQL.Add('            DET_VALICM,');
  FqryComand.SQL.Add('            DET_ALQICM,');
  FqryComand.SQL.Add('            DET_BASICM,');
  FqryComand.SQL.Add('            DET_VALRET,');
  FqryComand.SQL.Add('            DET_ALQRET,');
  FqryComand.SQL.Add('            DET_BASRET,');
  FqryComand.SQL.Add('            DET_TOTPES,');
  FqryComand.SQL.Add('            DET_PERBAS,');
  FqryComand.SQL.Add('            DET_PERRED,');
  FqryComand.SQL.Add('            DET_JAFATU,');
  FqryComand.SQL.Add('            DET_TIPFAT,');
  FqryComand.SQL.Add('            DET_NUMFAT,');
  FqryComand.SQL.Add('            DET_DTAFAT,');
  FqryComand.SQL.Add('            DET_VENFAT,');
  FqryComand.SQL.Add('            DET_CNDFAT,');
  FqryComand.SQL.Add('            DET_VALFAT,');
  FqryComand.SQL.Add('            DET_IDEPRO,');
  FqryComand.SQL.Add('            DET_INCPIS,');
  FqryComand.SQL.Add('            DET_NOTESP,');
  FqryComand.SQL.Add('            DET_DOCDEV,');
  FqryComand.SQL.Add('            DET_ESPDEV,');
  FqryComand.SQL.Add('            DET_EMPDEV,');
  FqryComand.SQL.Add('            DET_ITETIN,');
  FqryComand.SQL.Add('            DET_ITECHA,');
  FqryComand.SQL.Add('            DET_DESCOR,');
  FqryComand.SQL.Add('            DET_TIPEMB,');
  FqryComand.SQL.Add('            DET_QTDEMB,');
  FqryComand.SQL.Add('            DET_PREEMB,');
  FqryComand.SQL.Add('            DET_TIPPRE,');
  FqryComand.SQL.Add('            DET_PRVTIN,');
  FqryComand.SQL.Add('            DET_PRCTIN,');
  FqryComand.SQL.Add('            DET_FATTIN,');
  FqryComand.SQL.Add('            DET_PROEMB,');
  FqryComand.SQL.Add('            DET_CODDIG,');
  FqryComand.SQL.Add('            DET_CODCND,');
  FqryComand.SQL.Add('            DET_CODFPG,');
  FqryComand.SQL.Add('            DET_ITEEMB,');
  FqryComand.SQL.Add('            DET_LAZQUA,');
  FqryComand.SQL.Add('            DET_PROMOC,');
  FqryComand.SQL.Add('            DET_CODVE2,');
  FqryComand.SQL.Add('            DET_TOTCO2,');
  FqryComand.SQL.Add('            DET_SEQTIN,');
  FqryComand.SQL.Add('            DET_QTDPUL,');
  FqryComand.SQL.Add('            DET_PEDCOM,');
  FqryComand.SQL.Add('            DET_ORIDOC,');
  FqryComand.SQL.Add('            DET_IMPRES,');
  FqryComand.SQL.Add('            DET_QTDROM,');
  FqryComand.SQL.Add('            DET_NUM_PD,');
  FqryComand.SQL.Add('            DET_ESP_PD,');
  FqryComand.SQL.Add('            DET_EMP_PD,');
  FqryComand.SQL.Add('            DET_IND_PD,');
  FqryComand.SQL.Add('            DET_ORDPRO,');
  FqryComand.SQL.Add('            DET_TMPGAR,');
  FqryComand.SQL.Add('            DET_DESCFF,');
  FqryComand.SQL.Add('            DET_DESNES,');
  FqryComand.SQL.Add('            DET_CLIFAT,');
  FqryComand.SQL.Add('            DET_EMPFAT,');
  FqryComand.SQL.Add('            DET_BCAMIN,');
  FqryComand.SQL.Add('            DET_BCACOM,');
  FqryComand.SQL.Add('            DET_VOLPRO,');
  FqryComand.SQL.Add('            DET_DTABCA,');
  FqryComand.SQL.Add('            DET_CODACA,');
  FqryComand.SQL.Add('            DET_EMPACA,');
  FqryComand.SQL.Add('            DET_QTDENT,');
  FqryComand.SQL.Add('            DET_DOCFUT,');
  FqryComand.SQL.Add('            DET_ESPFUT,');
  FqryComand.SQL.Add('            DET_EMPFUT,');
  FqryComand.SQL.Add('            DET_FILKAR,');
  FqryComand.SQL.Add('            DET_PROACA,');
  FqryComand.SQL.Add('            DET_TABPRE,');
  FqryComand.SQL.Add('            DET_EMPCOM,');
  FqryComand.SQL.Add('            DET_SEGURO,');
  FqryComand.SQL.Add('            DET_LINLIN,');
  FqryComand.SQL.Add('            DET_CATALI,');
  FqryComand.SQL.Add('            DET_CODDIL,');
  FqryComand.SQL.Add('            DET_PORDIL,');
  FqryComand.SQL.Add('            DET_DILCON,');
  FqryComand.SQL.Add('            DET_PORCAT,');
  FqryComand.SQL.Add('            DET_QTDPON,');
  FqryComand.SQL.Add('            DET_ENTFUT,');
  FqryComand.SQL.Add('            DET_MOTFUT,');
  FqryComand.SQL.Add('            DET_DTAFUT,');
  FqryComand.SQL.Add('            DET_QTDEFT,');
  FqryComand.SQL.Add('            DET_DTAEFT,');
  FqryComand.SQL.Add('            DET_TOTCU2,');
  FqryComand.SQL.Add('            DET_BAIEMP,');
  FqryComand.SQL.Add('            DET_KEY_EP,');
  FqryComand.SQL.Add('            DET_NUMLOT,');
  FqryComand.SQL.Add('            DET_FUNEXP,');
  FqryComand.SQL.Add('            DET_PIGBAS,');
  FqryComand.SQL.Add('            DET_BAEIPI,');
  FqryComand.SQL.Add('            DET_ALEIPI,');
  FqryComand.SQL.Add('            DET_VAEIPI,');
  FqryComand.SQL.Add('            DET_EFBAIX,');
  FqryComand.SQL.Add('            DET_ALQIVA,');
  FqryComand.SQL.Add('            DET_VLIVA0,');
  FqryComand.SQL.Add('            DET_VLIVA5,');
  FqryComand.SQL.Add('            DET_VIVA10)');
  FqryComand.SQL.Add('(SELECT ');
  FqryComand.SQL.Add(' "' + FstrMovGerAutInc + '",  ');                           {DET_SEQGER}
  FqryComand.SQL.Add(' "' + FstrAutIncMovDet + '",  ');                           {AUTOINCREM}
  FqryComand.SQL.Add(' FIS_CODEMP,    ');                                        {DET_CODEMP}
  FqryComand.SQL.Add(' "' + strLoginUsuarioLogado + '",');                       {DET_CODVEN}
  FqryComand.SQL.Add(' ITE_CODITE, ');                                           {DET_CODITE}
  FqryComand.SQL.Add(' NULL, ');                                                 {DET_CODDIV}
  FqryComand.SQL.Add(' ITE_CODMAR, ');                                           {DET_CODMAR}
  FqryComand.SQL.Add(' "'+FstrCodFor+'", ');                                     {DET_CODFOR}
  FqryComand.SQL.Add(' NULL, ');                                                 {DET_CODCLI}
  FqryComand.SQL.Add(' FIS_NUMDOC, ');                                           {DET_NUMDOC}
  FqryComand.SQL.Add(' FIS_ESPDOC, ');                                           {DET_ESPDOC}
  FqryComand.SQL.Add(' FIS_SERIE_, ');                                           {DET_SERIE_}
  FqryComand.SQL.Add(' FIS_DTAENT, ');                                           {DET_DTAENT}
  FqryComand.SQL.Add(' "' + FormatDateTime('hh:mm:ss', fNow) + '",');            {DET_HORENT}
  FqryComand.SQL.Add(' FIS_DTADOC, ');                                           {DET_DTADOC}
  FqryComand.SQL.Add(' "01000", ');                                              {DET_CONPAG}
  FqryComand.SQL.Add(' "F", ');                                                  {DET_TIP_FC}
  FqryComand.SQL.Add(' "",  ');                                                  {DET_ESTADO}
  FqryComand.SQL.Add(' ITE_DESITE, ');                                           {DET_DESCRI}
  FqryComand.SQL.Add(' IFNULL(ITE_REFERE, ""), ');                               {DET_REFERE}
  FqryComand.SQL.Add(' ITE_CODUNI,  ');                                          {DET_UNIDAD}
  FqryComand.SQL.Add(' ITE_CODFOR,  ');                                          {DET_FORITE}
  FqryComand.SQL.Add(' 1.00, ');                                                 {DET_QTDITE}
  FqryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_UNITAR}
  FqryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_UNIORI}
  FqryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_UNIDIG}
  FqryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_TOTITE}
  FqryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_VLRCON}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTCUS}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTMED}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_DESCON}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTFRE}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_DESESP}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_DESACE}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_CODREP}
  FqryComand.SQL.Add(' 0.00, ');                                                 {DET_COMREP}
  FqryComand.SQL.Add(' 0.00, ');                                                 {DET_PERREP}
  FqryComand.SQL.Add(' 0.00, ');                                                 {DET_PERCOM}
  FqryComand.SQL.Add(' 0.00, ');                                                 {DET_TOTCOM}
  FqryComand.SQL.Add(' FIS_CLFSC1, ');                                           {DET_CLAFIS}
  FqryComand.SQL.Add(' "090",     ');                                            {DET_CODFIS}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_VALIPI}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_ALQIPI}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_BASIPI}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_VALICM}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_ALQICM}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_BASICM}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_VALRET}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_ALQRET}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_BASRET}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTPES}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_PERBAS}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_PERRED}
  FqryComand.SQL.Add(' 0,         ');                                            {DET_JAFATU}
  FqryComand.SQL.Add(' "",        ');                                            {DET_TIPFAT}
  FqryComand.SQL.Add(' "",        ');                                            {DET_NUMFAT}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_DTAFAT}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_VENFAT}
  FqryComand.SQL.Add(' "",        ');                                            {DET_CNDFAT}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_VALFAT}
  FqryComand.SQL.Add(' "NOR",     ');                                            {DET_IDEPRO}
  FqryComand.SQL.Add(' "S",       ');                                            {DET_INCPIS}
  FqryComand.SQL.Add(' "N",       ');                                            {DET_NOTESP}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_DOCDEV}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_ESPDEV}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_EMPDEV}
  FqryComand.SQL.Add(' "",        ');                                            {DET_ITETIN}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_ITECHA}
  FqryComand.SQL.Add(' "",        ');                                            {DET_DESCOR}
  FqryComand.SQL.Add(' "",        ');                                            {DET_TIPEMB}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDEMB}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_PREEMB}
  FqryComand.SQL.Add(' "",        ');                                            {DET_TIPPRE}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_PRVTIN}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_PRCTIN}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_FATTIN}
  FqryComand.SQL.Add(' "",        ');                                            {DET_PROEMB}
  FqryComand.SQL.Add('  "'+strLoginUsuarioLogado+'",');                          {DET_CODDIG}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_CODCND}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_CODFPG}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_ITEEMB}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_LAZQUA}
  FqryComand.SQL.Add(' "N",       ');                                            {DET_PROMOC}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_CODVE2}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTCO2}
  FqryComand.SQL.Add(' "",        ');                                            {DET_SEQTIN}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDPUL}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_PEDCOM}
  FqryComand.SQL.Add(' FIS_ORIDOC, ');                                           {DET_ORIDOC}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_IMPRES}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDROM}
  FqryComand.SQL.Add(' "",        ');                                            {DET_NUM_PD}
  FqryComand.SQL.Add(' "",        ');                                            {DET_ESP_PD}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_EMP_PD}
  FqryComand.SQL.Add(' 0,         ');                                            {DET_IND_PD}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_ORDPRO}
  FqryComand.SQL.Add(' 0,         ');                                            {DET_TMPGAR}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_DESCFF}
  FqryComand.SQL.Add(' "",        ');                                            {DET_DESNES}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_CLIFAT}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_EMPFAT}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_BCAMIN}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_BCACOM}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_VOLPRO}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_DTABCA}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_CODACA}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_EMPACA}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDENT}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_DOCFUT}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_ESPFUT}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_EMPFUT}
  FqryComand.SQL.Add(' 1   ,      ');                                            {DET_FILKAR}
  FqryComand.SQL.Add(' "N",       ');                                            {DET_PROACA}
  FqryComand.SQL.Add(' "",        ');                                            {DET_TABPRE}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_EMPCOM}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_SEGURO}
  FqryComand.SQL.Add(' "",        ');                                            {DET_LINLIN}
  FqryComand.SQL.Add(' "",        ');                                            {DET_CATALI}
  FqryComand.SQL.Add(' "",        ');                                            {DET_CODDIL}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_PORDIL}
  FqryComand.SQL.Add(' "",        ');                                            {DET_DILCON}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_PORCAT}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDPON}
  FqryComand.SQL.Add(' "N",       ');                                            {DET_ENTFUT}
  FqryComand.SQL.Add(' "",        ');                                            {DET_MOTFUT}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_DTAFUT}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_QTDEFT}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_DTAEFT}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTCU2}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_BAIEMP}
  FqryComand.SQL.Add(' "",        ');                                            {DET_KEY_EP}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_NUMLOT}
  FqryComand.SQL.Add(' "N",       ');                                            {DET_FUNEXP}
  FqryComand.SQL.Add(' "N",       ');                                            {DET_PIGBAS}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_BAEIPI}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_ALEIPI}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_VAEIPI}
  FqryComand.SQL.Add(' "N",       ');                                            {DET_EFBAIX}
  FqryComand.SQL.Add(' NULL,      ');                                            {DET_ALQIVA}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_VLIVA0}
  FqryComand.SQL.Add(' 0.00,      ');                                            {DET_VLIVA5}
  FqryComand.SQL.Add(' 0.00       ');                                            {DET_VIVA10}

  FqryComand.SQL.Add('  FROM CADFIS ');
  FqryComand.SQL.Add('  LEFT JOIN CADITE ON ITE_CODITE = "' + fCfgSis('ITESER') + '"');
  FqryComand.SQL.Add('  WHERE CADFIS.FIS_NUMDOC = "'+FstrNumDoc+'" ');
  FqryComand.SQL.Add('    AND CADFIS.FIS_ESPDOC = "'+FstrEspDoc+'" ');
  FqryComand.SQL.Add('    AND CADFIS.FIS_CODEMP = "'+FstrCodEmp+'" ');
  FqryComand.SQL.Add('    AND CADFIS.FIS_FORCLI = "'+FstrCodFor+'" ');
  FqryComand.SQL.Add('    AND IFNULL(CADFIS.FIS_SERIE_, "") = "'+FstrSerie+'");');
  FqryComand.ExecSQL;

  FqryComand.SQL.Clear;
  FqryComand.SQL.Add(' INSERT INTO MOVTRI ( ');
  FqryComand.SQL.Add(' DET_SEQGER,  ');
  FqryComand.SQL.Add(' DET_CSTPIS,  ');
  FqryComand.SQL.Add(' DET_BASPIS,  ');
  FqryComand.SQL.Add(' DET_ALQPIS,  ');
  FqryComand.SQL.Add(' DET_VALPIS,  ');
  FqryComand.SQL.Add(' DET_NR_PIS,  ');
  FqryComand.SQL.Add(' DET_CSTCOF,  ');
  FqryComand.SQL.Add(' DET_BASCOF,  ');
  FqryComand.SQL.Add(' DET_ALQCOF,  ');
  FqryComand.SQL.Add(' DET_VALCOF,  ');
  FqryComand.SQL.Add(' DET_NR_COF,  ');
  FqryComand.SQL.Add(' DET_NATOPE,  ');
  FqryComand.SQL.Add(' DET_OUTICM,  ');
  FqryComand.SQL.Add(' DET_ISEICM,  ');
  FqryComand.SQL.Add(' DET_VAERET,  ');
  FqryComand.SQL.Add(' DET_ALERET,  ');
  FqryComand.SQL.Add(' DET_BAERET)  ');
  FqryComand.SQL.Add(' (SELECT      ');
  FqryComand.SQL.Add(' "' + FstrAutIncMovDet + '",  ');
  FqryComand.SQL.Add(' FIS_CSTPIS, ');
  FqryComand.SQL.Add(' FIS_BASPIS, ');
  FqryComand.SQL.Add(' FIS_ALQPIS, ');
  FqryComand.SQL.Add(' FIS_TOTPIS, ');
  FqryComand.SQL.Add(' FIS_NR_PIS, ');
  FqryComand.SQL.Add(' FIS_CSTCOF, ');
  FqryComand.SQL.Add(' FIS_BASCOF, ');
  FqryComand.SQL.Add(' FIS_ALQCOF, ');
  FqryComand.SQL.Add(' FIS_TOTCOF, ');
  FqryComand.SQL.Add(' FIS_NR_COF, ');
  FqryComand.SQL.Add(' FIS_NATOPE, ');
  FqryComand.SQL.Add(' IFNULL(FIS_OUTRA1, 0.00), ');                          {DET_OUTICM}
  FqryComand.SQL.Add(' IFNULL(FIS_ISENT1, 0.00), ');                          {DET_ISEICM}
  FqryComand.SQL.Add(' IFNULL(FIS_VAERE1, 0.00), ');                          {DET_VAERET}
  FqryComand.SQL.Add(' IF(IFNULL(FIS_BAERE1, 0.00) > 0.00 AND IFNULL(FIS_VAERE1, 0.00) > 0.00, ((FIS_VAERE1 * 100) / FIS_BAERE1), 0.00), ');{DET_ALERET}
  FqryComand.SQL.Add(' IFNULL(FIS_BAERE1, 0.00)  ');                          {DET_BAERET}
  FqryComand.SQL.Add('  FROM CADFIS ');
  FqryComand.SQL.Add('  WHERE CADFIS.FIS_NUMDOC = "'+FstrNumDoc+'" ');
  FqryComand.SQL.Add('    AND CADFIS.FIS_ESPDOC = "'+FstrEspDoc+'" ');
  FqryComand.SQL.Add('    AND CADFIS.FIS_CODEMP = "'+FstrCodEmp+'" ');
  FqryComand.SQL.Add('    AND CADFIS.FIS_FORCLI = "'+FstrCodFor+'" ');
  FqryComand.SQL.Add('    AND IFNULL(CADFIS.FIS_SERIE_, "") = "'+FstrSerie+'");');
  FqryComand.ExecSQL;

  FqryComand.SQL.Clear;
  FqryComand.SQL.Add('INSERT INTO MOVREF (');
  FqryComand.SQL.Add('REF_SEQGER,');
  FqryComand.SQL.Add('REF_CODCST,');
  FqryComand.SQL.Add('REF_CLATRI,');
  FqryComand.SQL.Add('REF_BASCAL,');
  FqryComand.SQL.Add('REF_CBSALQ,');
  FqryComand.SQL.Add('REF_CBSALE,');
  FqryComand.SQL.Add('REF_CBSVAL,');
  FqryComand.SQL.Add('REF_IBSUFA,');
  FqryComand.SQL.Add('REF_IBSUFE,');
  FqryComand.SQL.Add('REF_IBSUFV,');
  FqryComand.SQL.Add('REF_IBSMNA,');
  FqryComand.SQL.Add('REF_IBSMNE,');
  FqryComand.SQL.Add('REF_IBSMNV,');
  FqryComand.SQL.Add('REF_VALIBS,');
  FqryComand.SQL.Add('REF_VALOPE,');
  FqryComand.SQL.Add('REF_CSTREG,');
  FqryComand.SQL.Add('REF_AIUREG,');
  FqryComand.SQL.Add('REF_TIUREG,');
  FqryComand.SQL.Add('REF_AIMREG,');
  FqryComand.SQL.Add('REF_TIMREG,');
  FqryComand.SQL.Add('REF_CBSREG,');
  FqryComand.SQL.Add('REF_TCBREG,');
  FqryComand.SQL.Add('REF_TPPCOM,');
  FqryComand.SQL.Add('REF_IDACGE,');
  FqryComand.SQL.Add('REF_VPTINS,');
  FqryComand.SQL.Add('REF_TPFENE,');
  FqryComand.SQL.Add('REF_ENEALO,');
  FqryComand.SQL.Add('REF_TPPTAR,');
  FqryComand.SQL.Add('REF_ENEINJ,');
  FqryComand.SQL.Add('REF_TPPINJ');
  FqryComand.SQL.Add(') VALUES (');
  FqryComand.SQL.Add(' "' + FstrAutIncMovDet + '",  ');
  FqryComand.SQL.Add(' "' + FstrCST + '",');
  FqryComand.SQL.Add(' "' + FstrcClassTrib + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FcurvBC) + '",' );
  FqryComand.SQL.Add(' "' + fFloatToSQL(FfloFpCBS) + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FfloFpAliqEfetCBS) + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FcurvCBS) + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FdobpIBSUF) + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FdobpAliqEfetUF) + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FcurvIBSUF) + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FdobpIBSMun) + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FdobFpAliqEfetMun) + '",' );
  FqryComand.SQL.Add(' "' + fFloatToSQL(FcurvIBSMun) + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FcurvIBSTot) + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FcurvTotNF) + '",');
  FqryComand.SQL.Add(' "' + FstrCSTReg + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FdobpAliqEfetRegIBSUF) + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FdobvTribRegIBSUF) + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FdobpAliqEfetRegIBSMun) + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FdobvTribRegIBSMun) + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FdobpAliqEfetRegCBS) + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FdobvTribRegCBS) + '",');
  FqryComand.SQL.Add(' "' + FstrTpPartComp + '",');
  FqryComand.SQL.Add(' "' + FstrIdAcessGer + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FdobVPotInst) + '",');
  FqryComand.SQL.Add(' "' + FstrTpFonteEnergia + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FdobEnerAloc) + '",');
  FqryComand.SQL.Add(' "' + FstrTpPosTar + '",');
  FqryComand.SQL.Add(' "' + fFloatToSQL(FdobEnerInjet) + '",');
  FqryComand.SQL.Add(' "' + FstrTpPosTarInjet + '"');
  FqryComand.SQL.Add(');');
  FqryComand.ExecSQL;
End;

procedure TXMLConsumoItem.pMontaSQLMovGer;
begin
  FqryComand.SQL.Clear;
  FqryComand.SQL.Add('INSERT INTO MOVGER (');
  FqryComand.SQL.Add('            AUTOINCREM,');
  FqryComand.SQL.Add('            GER_CODEMP,');
  FqryComand.SQL.Add('            GER_NUMDOC,');
  FqryComand.SQL.Add('            GER_ESPDOC,');
  FqryComand.SQL.Add('            GER_CODVEN,');
  FqryComand.SQL.Add('            GER_CODTRA,');
  FqryComand.SQL.Add('            GER_CODFOR,');
  FqryComand.SQL.Add('            GER_CODCLI,');
  FqryComand.SQL.Add('            GER_TIP_FC,');
  FqryComand.SQL.Add('            GER_SERIE_,');
  FqryComand.SQL.Add('            GER_DTAENT,');
  FqryComand.SQL.Add('            GER_HORENT,');
  FqryComand.SQL.Add('            GER_DTADOC,');
  FqryComand.SQL.Add('            GER_CONPAG,');
  FqryComand.SQL.Add('            GER_ESTADO,');
  FqryComand.SQL.Add('            GER_NOMCON,');
  FqryComand.SQL.Add('            GER_ENDCON,');
  FqryComand.SQL.Add('            GER_BAICON,');
  FqryComand.SQL.Add('            GER_CEPCON,');
  FqryComand.SQL.Add('            GER_CIDCON,');
  FqryComand.SQL.Add('            GER_ESTCON,');
  FqryComand.SQL.Add('            GER_TELCON,');
  FqryComand.SQL.Add('            GER_CGCCPF,');
  FqryComand.SQL.Add('            GER_CGCCON,');
  FqryComand.SQL.Add('            GER_IESCON,');
  FqryComand.SQL.Add('            GER_EMLCON,');
  FqryComand.SQL.Add('            GER_CLAFIS,');
  FqryComand.SQL.Add('            GER_BASSIM,');
  FqryComand.SQL.Add('            GER_BASIPI,');
  FqryComand.SQL.Add('            GER_ALQIPI,');
  FqryComand.SQL.Add('            GER_TOTIPI,');
  FqryComand.SQL.Add('            GER_BASICM,');
  FqryComand.SQL.Add('            GER_ALQICM,');
  FqryComand.SQL.Add('            GER_TOTICM,');
  FqryComand.SQL.Add('            GER_TOTRET,');
  FqryComand.SQL.Add('            GER_ALQRET,');
  FqryComand.SQL.Add('            GER_BASRET,');
  FqryComand.SQL.Add('            GER_DESESP,');
  FqryComand.SQL.Add('            GER_VLRCON,');
  FqryComand.SQL.Add('            GER_TOTPRO,');
  FqryComand.SQL.Add('            GER_TOTCUS,');
  FqryComand.SQL.Add('            GER_TOTMED,');
  FqryComand.SQL.Add('            GER_TIPFRE,');
  FqryComand.SQL.Add('            GER_TOTFRE,');
  FqryComand.SQL.Add('            GER_PESBRU,');
  FqryComand.SQL.Add('            GER_PESLIQ,');
  FqryComand.SQL.Add('            GER_VOLUME,');
  FqryComand.SQL.Add('            GER_ESPECI,');
  FqryComand.SQL.Add('            GER_MARCA_,');
  FqryComand.SQL.Add('            GER_MEN001,');
  FqryComand.SQL.Add('            GER_MEN002,');
  FqryComand.SQL.Add('            GER_JAFATU,');
  FqryComand.SQL.Add('            GER_TIPFAT,');
  FqryComand.SQL.Add('            GER_NUMFAT,');
  FqryComand.SQL.Add('            GER_DTAFAT,');
  FqryComand.SQL.Add('            GER_VENFAT,');
  FqryComand.SQL.Add('            GER_CNDFAT,');
  FqryComand.SQL.Add('            GER_VALFAT,');
  FqryComand.SQL.Add('            GER_VPAR01,');
  FqryComand.SQL.Add('            GER_VPAR02,');
  FqryComand.SQL.Add('            GER_VPAR03,');
  FqryComand.SQL.Add('            GER_VPAR04,');
  FqryComand.SQL.Add('            GER_VPAR05,');
  FqryComand.SQL.Add('            GER_VPAR06,');
  FqryComand.SQL.Add('            GER_VPAR07,');
  FqryComand.SQL.Add('            GER_VPAR08,');
  FqryComand.SQL.Add('            GER_VPAR09,');
  FqryComand.SQL.Add('            GER_VPAR10,');
  FqryComand.SQL.Add('            GER_VPAR11,');
  FqryComand.SQL.Add('            GER_VPAR12,');
  FqryComand.SQL.Add('            GER_NOTESP,');
  FqryComand.SQL.Add('            GER_CODDIG,');
  FqryComand.SQL.Add('            GER_PORDES,');
  FqryComand.SQL.Add('            GER_R_GCON,');
  FqryComand.SQL.Add('            GER_CODCND,');
  FqryComand.SQL.Add('            GER_CODFPG,');
  FqryComand.SQL.Add('            GER_FATNOT,');
  FqryComand.SQL.Add('            GER_CODS01,');
  FqryComand.SQL.Add('            GER_CODS02,');
  FqryComand.SQL.Add('            GER_CODS03,');
  FqryComand.SQL.Add('            GER_CODS04,');
  FqryComand.SQL.Add('            GER_CODS05,');
  FqryComand.SQL.Add('            GER_CODS06,');
  FqryComand.SQL.Add('            GER_DESS01,');
  FqryComand.SQL.Add('            GER_DESS02,');
  FqryComand.SQL.Add('            GER_DESS03,');
  FqryComand.SQL.Add('            GER_DESS04,');
  FqryComand.SQL.Add('            GER_DESS05,');
  FqryComand.SQL.Add('            GER_DESS06,');
  FqryComand.SQL.Add('            GER_VALS01,');
  FqryComand.SQL.Add('            GER_VALS02,');
  FqryComand.SQL.Add('            GER_VALS03,');
  FqryComand.SQL.Add('            GER_VALS04,');
  FqryComand.SQL.Add('            GER_VALS05,');
  FqryComand.SQL.Add('            GER_VALS06,');
  FqryComand.SQL.Add('            GER_PRAENT,');
  FqryComand.SQL.Add('            GER_TOTSER,');
  FqryComand.SQL.Add('            GER_PERISS,');
  FqryComand.SQL.Add('            GER_VALISS,');
  FqryComand.SQL.Add('            GER_CLAFI2,');
  FqryComand.SQL.Add('            GER_CLAFI3,');
  FqryComand.SQL.Add('            GER_NATOPE,');
  FqryComand.SQL.Add('            GER_DESACE,');
  FqryComand.SQL.Add('            GER_ORIDOC,');
  FqryComand.SQL.Add('            GER_DTAROM,');
  FqryComand.SQL.Add('            GER_HORROM,');
  FqryComand.SQL.Add('            GER_OPEROM,');
  FqryComand.SQL.Add('            GER_NUMROM,');
  FqryComand.SQL.Add('            GER_CONENT,');
  FqryComand.SQL.Add('            GER_IMPRES,');
  FqryComand.SQL.Add('            GER_CODREP,');
  FqryComand.SQL.Add('            GER_VALROM,');
  FqryComand.SQL.Add('            GER_ALQIRF,');
  FqryComand.SQL.Add('            GER_VALIRF,');
  FqryComand.SQL.Add('            GER_ALQPIS,');
  FqryComand.SQL.Add('            GER_VALPIS,');
  FqryComand.SQL.Add('            GER_ALQCOF,');
  FqryComand.SQL.Add('            GER_VALCOF,');
  FqryComand.SQL.Add('            GER_ALQCSL,');
  FqryComand.SQL.Add('            GER_VALCSL,');
  FqryComand.SQL.Add('            GER_IRFRET,');
  FqryComand.SQL.Add('            GER_PISRET,');
  FqryComand.SQL.Add('            GER_COFRET,');
  FqryComand.SQL.Add('            GER_CSLRET,');
  FqryComand.SQL.Add('            GER_SERRET,');
  FqryComand.SQL.Add('            GER_NOTRET,');
  FqryComand.SQL.Add('            GER_NORESE,');
  FqryComand.SQL.Add('            GER_ALIRFP,');
  FqryComand.SQL.Add('            GER_ALPISP,');
  FqryComand.SQL.Add('            GER_ALCOFP,');
  FqryComand.SQL.Add('            GER_ALCSLP,');
  FqryComand.SQL.Add('            GER_PESGSO,');
  FqryComand.SQL.Add('            GER_VLSGSO,');
  FqryComand.SQL.Add('            GER_IRPRRT,');
  FqryComand.SQL.Add('            GER_IRPRDV,');
  FqryComand.SQL.Add('            GER_IRSERT,');
  FqryComand.SQL.Add('            GER_IRSEDV,');
  FqryComand.SQL.Add('            GER_PIPRRT,');
  FqryComand.SQL.Add('            GER_PIPRDV,');
  FqryComand.SQL.Add('            GER_PISERT,');
  FqryComand.SQL.Add('            GER_PISEDV,');
  FqryComand.SQL.Add('            GER_COPRRT,');
  FqryComand.SQL.Add('            GER_COPRDV,');
  FqryComand.SQL.Add('            GER_COSERT,');
  FqryComand.SQL.Add('            GER_COSEDV,');
  FqryComand.SQL.Add('            GER_CSPRRT,');
  FqryComand.SQL.Add('            GER_CSPRDV,');
  FqryComand.SQL.Add('            GER_CSSERT,');
  FqryComand.SQL.Add('            GER_CSSEDV,');
  FqryComand.SQL.Add('            GER_ORDPRO,');
  FqryComand.SQL.Add('            GER_ROMIMP,');
  FqryComand.SQL.Add('            GER_BASORG,');
  FqryComand.SQL.Add('            GER_ICMORG,');
  FqryComand.SQL.Add('            GER_NCONHE,');
  FqryComand.SQL.Add('            GER_DESCFF,');
  FqryComand.SQL.Add('            GER_RET_SP,');
  FqryComand.SQL.Add('            GER_CONSUM,');
  FqryComand.SQL.Add('            GER_MEN003,');
  FqryComand.SQL.Add('            GER_MEN004,');
  FqryComand.SQL.Add('            GER_MEN005,');
  FqryComand.SQL.Add('            GER_ENTFAT,');
  FqryComand.SQL.Add('            GER_CLIFAT,');
  FqryComand.SQL.Add('            GER_EMPFAT,');
  FqryComand.SQL.Add('            GER_OPEEXP,');
  FqryComand.SQL.Add('            GER_SEPEXP,');
  FqryComand.SQL.Add('            GER_OPLBRC,');
  FqryComand.SQL.Add('            GER_DTLBRC,');
  FqryComand.SQL.Add('            GER_HRLBRC,');
  FqryComand.SQL.Add('            GER_TABPRE,');
  FqryComand.SQL.Add('            GER_OPLBEX,');
  FqryComand.SQL.Add('            GER_DTLBEX,');
  FqryComand.SQL.Add('            GER_HRLBEX,');
  FqryComand.SQL.Add('            GER_ENTFUT,');
  FqryComand.SQL.Add('            GER_NUM_PR,');
  FqryComand.SQL.Add('            GER_EMPROM,');
  FqryComand.SQL.Add('            GER_MARGEM,');
  FqryComand.SQL.Add('            GER_EMPORI,');
  FqryComand.SQL.Add('            GER_BARTSP,');
  FqryComand.SQL.Add('            GER_VLRTSP,');
  FqryComand.SQL.Add('            GER_OPRFLJ,');
  FqryComand.SQL.Add('            GER_SEGURO,');
  FqryComand.SQL.Add('            GER_DTALAN,');
  FqryComand.SQL.Add('            GER_NUMREG,');
  FqryComand.SQL.Add('            GER_AUTSER,');
  FqryComand.SQL.Add('            GER_DTENTR,');
  FqryComand.SQL.Add('            GER_NROCEI,');
  FqryComand.SQL.Add('            GER_CLAFI4,');
  FqryComand.SQL.Add('            GER_TOEIPI,');
  FqryComand.SQL.Add('            GER_ALEIPI,');
  FqryComand.SQL.Add('            GER_BAEIPI,');
  FqryComand.SQL.Add('            GER_CODEVE,');
  FqryComand.SQL.Add('            GER_CODOCO,');
  FqryComand.SQL.Add('            GER_VLIVA0,');
  FqryComand.SQL.Add('            GER_VLIVA5,');
  FqryComand.SQL.Add('            GER_VIVA10,');
  FqryComand.SQL.Add('            GER_MENEXP,');
  FqryComand.SQL.Add('            GER_MENEX2,');
  FqryComand.SQL.Add('            GER_MENEX3,');
  FqryComand.SQL.Add('            GER_MENEX4,');
  FqryComand.SQL.Add('            GER_PRVIMP,');
  FqryComand.SQL.Add('            GER_NROBOX');
  FqryComand.SQL.Add('            )');
  FqryComand.SQL.Add('(SELECT "' + FstrMovGerAutInc + '",');                    // AUTOINCREM
  FqryComand.SQL.Add('        FIS_CODEMP,');                                  // GER_CODEMP
  FqryComand.SQL.Add('        FIS_NUMDOC,');                                  // GER_NUMDOC
  FqryComand.SQL.Add('        FIS_ESPDOC,');                                  // GER_ESPDOC
  FqryComand.SQL.Add('        "'+strLoginUsuarioLogado+'",');                 // GER_CODVEN
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CODTRA
  FqryComand.SQL.Add('        FIS_FORCLI,');                                  // GER_CODFOR
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CODCLI
  FqryComand.SQL.Add('        "F",       ');                                  // GER_TIP_FC
  FqryComand.SQL.Add('        FIS_SERIE_,');                                  // GER_SERIE_
  FqryComand.SQL.Add('        FIS_DTAENT,');                                  // GER_DTAENT
  FqryComand.SQL.Add('        "' + FormatDateTime('hh:mm:ss', fNow) + '",');  // GER_HORENT
  FqryComand.SQL.Add('        FIS_DTADOC,');                                  // GER_DTADOC
  FqryComand.SQL.Add('        "01000",   ');                                  // GER_CONPAG
  FqryComand.SQL.Add('        "",        ');                                  // GER_ESTADO
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_NOMCON
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_ENDCON
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_BAICON
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CEPCON
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CIDCON
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_ESTCON
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_TELCON
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CGCCPF
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CGCCON
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_IESCON
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_EMLCON
  FqryComand.SQL.Add('        FIS_CLFSC1,');                                  // GER_CLAFIS
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_BASSIM
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_BASIPI
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_ALQIPI
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_TOTIPI
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_BASICM
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_ALQICM
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_TOTICM
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_TOTRET
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_ALQRET
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_BASRET
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_DESESP
  FqryComand.SQL.Add('        FIS_VLCON1,');                                  // GER_VLRCON
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_TOTPRO
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_TOTCUS
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_TOTMED
  FqryComand.SQL.Add('        "",        ');                                  // GER_TIPFRE
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_TOTFRE
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_PESBRU
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_PESLIQ
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VOLUME
  FqryComand.SQL.Add('        "",        ');                                  // GER_ESPECI
  FqryComand.SQL.Add('        "",        ');                                  // GER_MARCA_
  FqryComand.SQL.Add('        "NOTA DE SERVICO FORNECEDOR",');                // GER_MEN001
  FqryComand.SQL.Add('        "",        ');                                  // GER_MEN002
  FqryComand.SQL.Add('        "0",        ');                                 // GER_JAFATU
  FqryComand.SQL.Add('        "",        ');                                  // GER_TIPFAT
  FqryComand.SQL.Add('        "",        ');                                  // GER_NUMFAT
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_DTAFAT
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_VENFAT
  FqryComand.SQL.Add('        "",        ');                                  // GER_CNDFAT
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VALFAT
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR01
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR02
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR03
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR04
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR05
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR06
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR07
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR08
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR09
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR10
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR11
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR12
  FqryComand.SQL.Add('        "N",        ');                                 // GER_NOTESP
  FqryComand.SQL.Add('        "'+strLoginUsuarioLogado+'",');                 // GER_CODDIG
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_PORDES
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_R_GCON
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CODCND
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CODFPG
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_FATNOT
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CODS01
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CODS02
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CODS03
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CODS04
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CODS05
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CODS06
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_DESS01
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_DESS02
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_DESS03
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_DESS04
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_DESS05
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_DESS06
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VALS01
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VALS02
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VALS03
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VALS04
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VALS05
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VALS06
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_PRAENT
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_TOTSER
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_PERISS
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VALISS
  FqryComand.SQL.Add('        "",        ');                                  // GER_CLAFI2
  FqryComand.SQL.Add('        "",        ');                                  // GER_CLAFI3
  FqryComand.SQL.Add('        FIS_NATOPE,');                                  // GER_NATOPE
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_DESACE
  FqryComand.SQL.Add('        "",        ');                                  // GER_ORIDOC
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_DTAROM
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_HORROM
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_OPEROM
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_NUMROM
  FqryComand.SQL.Add('        "N",       ');                                  // GER_CONENT
  FqryComand.SQL.Add('        "1",       ');                                  // GER_IMPRES
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CODREP
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VALROM
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_ALQIRF
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VALIRF
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_ALQPIS
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VALPIS
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_ALQCOF
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VALCOF
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_ALQCSL
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VALCSL
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_IRFRET
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_PISRET
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_COFRET
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_CSLRET
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_SERRET
  FqryComand.SQL.Add('        "",        ');                                  // GER_NOTRET
  FqryComand.SQL.Add('        "",        ');                                  // GER_NORESE
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_ALIRFP
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_ALPISP
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_ALCOFP
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_ALCSLP
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_PESGSO
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VLSGSO
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_IRPRRT
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_IRPRDV
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_IRSERT
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_IRSEDV
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_PIPRRT
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_PIPRDV
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_PISERT
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_PISEDV
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_COPRRT
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_COPRDV
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_COSERT
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_COSEDV
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_CSPRRT
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_CSPRDV
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_CSSERT
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_CSSEDV
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_ORDPRO
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_ROMIMP
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_BASORG
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_ICMORG
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_NCONHE
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_DESCFF
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_RET_SP
  FqryComand.SQL.Add('        "",        ');                                  // GER_CONSUM
  FqryComand.SQL.Add('        "",        ');                                  // GER_MEN003
  FqryComand.SQL.Add('        "",        ');                                  // GER_MEN004
  FqryComand.SQL.Add('        "",        ');                                  // GER_MEN005
  FqryComand.SQL.Add('        "N",       ');                                  // GER_ENTFAT
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CLIFAT
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_EMPFAT
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_OPEEXP
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_SEPEXP
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_OPLBRC
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_DTLBRC
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_HRLBRC
  FqryComand.SQL.Add('        "",        ');                                  // GER_TABPRE
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_OPLBEX
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_DTLBEX
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_HRLBEX
  FqryComand.SQL.Add('        "N",       ');                                  // GER_ENTFUT
  FqryComand.SQL.Add('        "",        ');                                  // GER_NUM_PR
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_EMPROM
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_MARGEM
  FqryComand.SQL.Add('        "",        ');                                  // GER_EMPORI
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_BARTSP
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VLRTSP
  FqryComand.SQL.Add('        "N",       ');                                  // GER_OPRFLJ
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_SEGURO
  FqryComand.SQL.Add('        FIS_DTAENT,');                                  // GER_DTALAN
  FqryComand.SQL.Add('        "",        ');                                  // GER_NUMREG
  FqryComand.SQL.Add('        "N",       ');                                  // GER_AUTSER
  FqryComand.SQL.Add('        FIS_DTAENT,');                                  // GER_DTENTR
  FqryComand.SQL.Add('        "",        ');                                  // GER_NROCEI
  FqryComand.SQL.Add('        "",        ');                                  // GER_CLAFI4
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_TOEIPI
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_ALEIPI
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_BAEIPI
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CODEVE
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_CODOCO
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VLIVA0
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VLIVA5
  FqryComand.SQL.Add('        0.00,      ');                                  // GER_VIVA10
  FqryComand.SQL.Add('        "",        ');                                  // GER_MENEXP
  FqryComand.SQL.Add('        "",        ');                                  // GER_MENEX2
  FqryComand.SQL.Add('        "",        ');                                  // GER_MENEX3
  FqryComand.SQL.Add('        "",        ');                                  // GER_MENEX4
  FqryComand.SQL.Add('        NULL,      ');                                  // GER_PRVIMP
  FqryComand.SQL.Add('        NULL       ');                                  // GER_NROBOX
  FqryComand.SQL.Add('   FROM CADFIS ');
  FqryComand.SQL.Add('  WHERE CADFIS.FIS_NUMDOC = "'+FstrNumDoc+'" ');
  FqryComand.SQL.Add('    AND CADFIS.FIS_ESPDOC = "'+FstrEspDoc+'" ');
  FqryComand.SQL.Add('    AND CADFIS.FIS_CODEMP = "'+FstrCodEmp+'" ');
  FqryComand.SQL.Add('    AND CADFIS.FIS_FORCLI = "'+FstrCodFor+'" ');
  FqryComand.SQL.Add('    AND IFNULL(CADFIS.FIS_SERIE_, "") = "'+FstrSerie+'");');
  FqryComand.ExecSQL;

  FqryComand.SQL.Clear;
  FqryComand.SQL.Add('INSERT INTO AUXMOV (AUX_SEQGER, AUX_NATCFO) VALUES ("'+FstrMovGerAutInc+'", ' + QuotedStr(fRetAutoIncremNatCfo(FClaFi1)) + ' );');
  FqryComand.ExecSQL;
End;

function TXMLConsumoItem.fRetAutoIncremNatCfo(AStrNatCfo: String): String;
begin
  Result := fCampoTabela('AUTOINCREM', 'NATCFO', ['NAT_CODCFO'], [AStrNatCfo]);
end;

function TXMLConsumoItem.NumDoc(AstrNumDoc: String): TXMLConsumoItem;
begin
  FstrNumDoc := AstrNumDoc;
  Result := Self;
end;

function TXMLConsumoItem.EspDoc(AstrEspDoc: String): TXMLConsumoItem;
begin
  FstrEspDoc := AstrEspDoc;
  Result := Self;
end;

function TXMLConsumoItem.CodEmp(AstrCodEmp: String): TXMLConsumoItem;
begin
  FstrCodEmp := AstrCodEmp;
  Result := Self;
end;

function TXMLConsumoItem.CodFor(AstrCodFor: String): TXMLConsumoItem;
begin
  FstrCodFor := AstrCodFor;
  Result := Self;
end;

function TXMLConsumoItem.Serie(AstrSerie: String): TXMLConsumoItem;
begin
  FstrSerie := AstrSerie;
  Result := Self;
end;


function TXMLConsumoItem.CST(AstrCST: String): TXMLConsumoItem;
begin
  FstrCST := AstrCST;
  Result := Self;
end;

function TXMLConsumoItem.ClassTrib(AstrcClassTrib: String): TXMLConsumoItem;
begin
  FstrcClassTrib := AstrcClassTrib;
  Result := Self;
end;

function TXMLConsumoItem.ClaFi1(AClaFi1: String): TXMLConsumoItem;
begin
  FClaFi1 := AClaFi1;
  Result := Self;
end;

{ Funções de Valores e Impostos }

function TXMLConsumoItem.vBC(AcurvBC: Double): TXMLConsumoItem;
begin
  FcurvBC := AcurvBC;
  Result := Self;
end;

function TXMLConsumoItem.FpCBS(AfloFpCBS: Double): TXMLConsumoItem;
begin
  FfloFpCBS := AfloFpCBS;
  Result := Self;
end;

function TXMLConsumoItem.pAliqEfetCBS(AfloFpAliqEfetCBS: Double): TXMLConsumoItem;
begin
  FfloFpAliqEfetCBS := AfloFpAliqEfetCBS;
  Result := Self;
end;

function TXMLConsumoItem.vCBS(AcurvCBS: Double): TXMLConsumoItem;
begin
  FcurvCBS := AcurvCBS;
  Result := Self;
end;

function TXMLConsumoItem.pIBSUF(AdobpIBSUF: Double): TXMLConsumoItem;
begin
  FdobpIBSUF := AdobpIBSUF;
  Result := Self;
end;

function TXMLConsumoItem.pAliqEfetUF(AdobpAliqEfetUF: Double): TXMLConsumoItem;
begin
  FdobpAliqEfetUF := AdobpAliqEfetUF;
  Result := Self;
end;

function TXMLConsumoItem.vIBSUF(AcurvIBSUF: Double): TXMLConsumoItem;
begin
  FcurvIBSUF := AcurvIBSUF;
  Result := Self;
end;

function TXMLConsumoItem.pIBSMun(AdobpIBSMun: Double): TXMLConsumoItem;
begin
  FdobpIBSMun := AdobpIBSMun;
  Result := Self;
end;

function TXMLConsumoItem.pAliqEfetMun(AdobFpAliqEfetMun: Double): TXMLConsumoItem;
begin
  FdobFpAliqEfetMun := AdobFpAliqEfetMun;
  Result := Self;
end;

function TXMLConsumoItem.IBSMun(AcurvIBSMun: Double): TXMLConsumoItem;
begin
  FcurvIBSMun := AcurvIBSMun;
  Result := Self;
end;

function TXMLConsumoItem.IBSTot(AcurvIBSTot: Double): TXMLConsumoItem;
begin
  FcurvIBSTot := AcurvIBSTot;
  Result := Self;
end;

function TXMLConsumoItem.TotNF(AcurvTotNF: Double): TXMLConsumoItem;
begin
  FcurvTotNF := AcurvTotNF;
  Result := Self;
end;

function TXMLConsumoItem.CSTReg(AValue: String): TXMLConsumoItem;
begin
  FstrCSTReg := AValue;
  Result := Self;
end;

function TXMLConsumoItem.pAliqEfetRegIBSUF(AValue: Double): TXMLConsumoItem;
begin
  FdobpAliqEfetRegIBSUF := AValue;
  Result := Self;
end;

function TXMLConsumoItem.vTribRegIBSUF(AValue: Double): TXMLConsumoItem;
begin
  FdobvTribRegIBSUF := AValue;
  Result := Self;
end;

function TXMLConsumoItem.pAliqEfetRegIBSMun(AValue: Double): TXMLConsumoItem;
begin
  FdobpAliqEfetRegIBSMun := AValue;
  Result := Self;
end;

function TXMLConsumoItem.vTribRegIBSMun(AValue: Double): TXMLConsumoItem;
begin
  FdobvTribRegIBSMun := AValue;
  Result := Self;
end;

function TXMLConsumoItem.pAliqEfetRegCBS(AValue: Double): TXMLConsumoItem;
begin
  FdobpAliqEfetRegCBS := AValue;
  Result := Self;
end;

function TXMLConsumoItem.vTribRegCBS(AValue: Double): TXMLConsumoItem;
begin
  FdobvTribRegCBS := AValue;
  Result := Self;
end;

function TXMLConsumoItem.TpPartComp(AValue: String): TXMLConsumoItem;
begin
  FstrTpPartComp := AValue;
  Result := Self;
end;

function TXMLConsumoItem.IdAcessGer(AValue: String): TXMLConsumoItem;
begin
  FstrIdAcessGer := AValue;
  Result := Self;
end;

function TXMLConsumoItem.VPotInst(AValue: Double): TXMLConsumoItem;
begin
  FdobVPotInst := AValue;
  Result := Self;
end;

function TXMLConsumoItem.TpFonteEnergia(AValue: String): TXMLConsumoItem;
begin
  FstrTpFonteEnergia := AValue;
  Result := Self;
end;

function TXMLConsumoItem.EnerAloc(AValue: Double): TXMLConsumoItem;
begin
  FdobEnerAloc := AValue;
  Result := Self;
end;

function TXMLConsumoItem.TpPosTar(AValue: String): TXMLConsumoItem;
begin
  FstrTpPosTar := AValue;
  Result := Self;
end;

function TXMLConsumoItem.EnerInjet(AValue: Double): TXMLConsumoItem;
begin
  FdobEnerInjet := AValue;
  Result := Self;
end;

function TXMLConsumoItem.TpPosTarInjet(AValue: String): TXMLConsumoItem;
begin
  FstrTpPosTarInjet := AValue;
  Result := Self;
end;

end.

