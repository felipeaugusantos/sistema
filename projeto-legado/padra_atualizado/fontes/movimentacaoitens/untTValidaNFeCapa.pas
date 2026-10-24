unit untTValidaNFeCapa;

interface

uses Classes, System.SysUtils, Data.DB, Uni, UniClientDataSet, System.StrUtils,
     System.Math, System.Variants, cxProgressBar, Forms, Vcl.Controls, untFuncoesSimples, System.Rtti;

type
  TValoresItem = Record
    strCHAVE_: String;
    strCODITE: String;
    strDESITE: String;
//    fltVALCON : Double;
    fltTOTPRO: Double;
    fltBASICM: Double;
    fltVALICM: Double;
    fltALQICM: Double;
    fltBAS_ST: Double;
    fltALQ_ST: Double;
    fltVAL_ST: Double;

    fltBASIPI: Double;
    fltBasIPI_ComDesconto: Double;

    fltALQIPI: Double;

    fltVALIPI: Double;
    fltVALIPI_ComDesconto: Double;

    fltVALFRE: Double;
    fltVICMSDESON: Double;
    fltVDESC: Double;
    fltVOUTRO: Double;
    fltVSEG: Double;
    strB08_NNF: String;

  End;

  TValoresCapa = Record
    strCHAVE_: String;
//    fltVALCON: Double;
    fltTOTPRO: Double;
    fltBASICM: Double;
    fltVALICM: Double;
    fltBAS_ST: Double;
    fltVAL_ST: Double;
    fltBASIPI: Double;
    fltVALIPI: Double;
    fltVALFRE: Double;
    fltVICMSDESON: Double;
    fltVDESC: Double;
    fltVOUTRO: Double;
    fltVSEG: Double;
    strB08_NNF: String;
    strB07_SERIE: String;
    strB09_DEMI: String;


  End;


  TRecDetEle = packed Record
    strAutInc :    String[20];
    I02_NITEM :    String;
    DET_CODITE:    String[7];
    DET_CODMCO:    String;
    DET_VALIMP:    Double;
    DET_VALSIS:    Double;
    DET_CSTXML:    String[3];
    I02_CPROD:     String[60];
    CODCEST:       String[7];
    I03_CEAN:      String[14];
    I04_XPROD:     String[120];
    I05_NCM:       String[8];
    I06_EXTIPI:    String[3];
    I07_GENERO:    String[2];
    I08_CFOP:      String[4];
    I09_UCOM:      String[6];
    I10_QCOM:      Double;
    I10A_VUNCOM:   Double;
    I11_VPROD:     Double;
    I12_CEANTRIB:  String[14];
    I13_UTRIB:     String[6];
    I14_QTRIB:     Double;
    I14A_VUNTRIB:  Double;
    I15_VFRETE:    Double;
    I16_VSEG:      Double;
    I16_VSEGIMP:      Double;
    I17_VDESC:     Double;
    I23B_VAFRMM:   Double;
    I17A_VOUTRO:   Double;
    I70_NFCI:      String[50];
    N11_ORIG:      String[1];
    N12_CST:       String[2];
    N12_CSOSN:     String[3];
    N13_MODBC:     String[1];
    N14_PREDBC:    Double;
    N15_VBC:       Double;
    N16_PICMS:     Double;
    N16b_PDIF:     Double;
    N17_VICMS:     Double;
    N18_MODBCST:   String[1];
    N19_PMVAST:    Double;
    N20_PREBCST:   Double;
    LA02_CPRODANP: String[9];

    // 1) BASE_ST = vr.produto x IVA                             ( ex: 1050,00 x 1.8337 = 1925,39 )
    // 2) BASE_ST = ( vr.produto - desconto ) x IVA              ( ex: 1050,00 - 52,50 = 997,50 x 1.8337 = 1829,12 )
    // 3) BASE_ST = ( vr.produto + IPI ) x IVA                   ( ex: ( 1050,00 + 52,50 ) x 1.8337 = 2021,65 )
    // 4) BASE_ST = ( ( vr.produto - desconto ) + IPI ) x IVA    ( ex: ( 1050,00 + 49,87 ) - 52,50 = 1047,37 x 1.8337 = 1920.56 )

    N21_VBCST                    : Double;
    N21_VBCST_IPIComDesconto     : Double;
    N21_VBCST_Produto            : Double;
    N21_VBCST_Produto_ComDesconto: Double;
    N21_VBCST_Produto_ComIPI     : Double;

    N22_PICMSST:   Double;

    N23_VICMSST                    : Double;
    N23_VICMSST_IPIComDesconto     : Double;
    N23_VICMSST_Produto            : Double;
    N23_VICMSST_Produto_ComDesconto: Double;
    N23_VICMSST_Produto_ComIPI     : Double;

    N23_VICMSST_GARE                    : Double;
    N23_VICMSST_IPIComDesconto_GARE     : Double;
    N23_VICMSST_Produto_GARE            : Double;
    N23_VICMSST_Produto_ComDesconto_GARE: Double;
    N23_VICMSST_Produto_ComIPI_GARE     : Double;

    N23_VFCPST_GARE                    : Double;
    N23_VFCPST_IPIComDesconto_GARE     : Double;
    N23_VFCPST_Produto_GARE            : Double;
    N23_VFCPST_Produto_ComDesconto_GARE: Double;
    N23_VFCPST_Produto_ComIPI_GARE     : Double;


    N24_CREDSN,
    N24_CREDICMSSN,
    N27A_VICMSDESON:Double;
    N27A_MOTDESICMS: String[2];

    N28_QICMSMonoRet: Double;
    N28_AdBCMonoRet: Double;
    N28_VRemICMSRet: Double;

    O02_CLENQ:     String[5];
    O07_IPITRIB:   String[1];
    O09_CST:       String[2];
    O10_VBC:       Double;

    fltBasIPI:     Double;
    fltBasIPI_ComDesconto: Double;

    O11_QUNID:     Double;
    O12_VUNID:     Double;
    O13_PIPI:      Double;

    O14_VIPI:      Double;
    O14_VIPI_ComDesconto: Double;

    P03_VDESPADU:  Double;
    P04_VII:       Double;
    Q06_CST:       String[2];
    Q07_VBC:       Double;
    Q08_PPIS:      Double;
    Q09_VPIS:      Double;
    Q10_QBCPROD:   Double;
    Q11_VALIQPROD: Double;
    S06_CST:       String[2];
    S07_VBC:       Double;
    S08_PCOFINS:   Double;
    S09_QBCPROD:   Double;
    S10_VALIQPROD: Double;
    S11_VCOFINS:   Double;
    ITE_PER_CI:    Double;
    N17A_VBCFCP:   Double;
    N17B_PFCP:     Double;
    N17C_VFCP:     Double;
    N23A_VBCFCPST: Double;
    N23B_PFCPST:   Double;
    N23D_FCPST:    Double;

    N24_VBCUFDEST:      Double;
    N24_VBCFCPUFDEST:   Double;
    N24_PFCPUFDEST:     Double;
    N24_PICMSUFDEST:    Double;
    N24_PICMSINTER:     Double;
    N24_PICMSINTERPART: Double;
    N24_VFCPUFDEST:     Double;
    N24_VICMSUFDEST:    Double;
    N24_VICMSUFREMET:   Double;
    N26_VBCSTRET:       Double;
    N27_VICMSSTRET:     Double;
    N27_vICMSSubstituto:Double;

    N34_PREDBCEEFET:    Double; // Percentual de redução da base de cálculo efetiva
    N35_VBCEFET:        Double; // Valor da base de cálculo efetiva
    N36_PICMSEFET:      Double; // Alíquota do ICMS efetiva
    N37_VICMSEFET:      Double; // Valor do ICMS efetivo

    U02_VBC:            Double;
    U03_VALIQ:          Double;
    U04_VISSQN:         Double;
    U05_CMUNFG:         String[10];
    U06_CLISTSERV:      String[10];
    U07_VDEDUCAO:       Double;
    U09_VDESCINCOND:    Double;
    U12_INDSS:          String[10];
    U14_CMUN:           String[10];
    U15_CPAIS:          String[10];
    U17_INDINCENTIVO:   String[10];

    U51_PERCDEVOL:      Double;
    U61_VALIPIDEVOL:    Double;

    V01_infAdProd: WideString;

    XPED        :   String;
    NITEMPED    :   String;

    I19_NDI:           String[30];
    I21_XLOCDESEMB:    String[60];
    I23E_UFTERCEIRO:   String[2];
    I23D_CNPJ:         String[14];
    I20_DDI:           String[10];
    I23_DDESEMB:       String[10];
    I22_UFDESEMB:      String[2];
    I23A_TPVIATRANSP:  String[2];
    I23C_TPINTERMEDIO: String[1];
    I26_NADICAO:       Double;

    P02_VBC:           Double;
    P05_VIOF:          Double;
    DET_BASSUB:        Double;

    CAL_VLICMS:         Double;
    CAL_BASICM:        Double;
    CAL_ALQICM:        Double;
    CAL_BAS_ST:        Double;
    CAL_VR_IVA:        Double;
    CAL_VR_SUB:        Double;
    CAL_ALQINT:        Double;
    CAL_VFCPST:        Double;
    DET_CALSTU:        Integer;
    strMemCalGNRE:  String;
    strMemCalGNRE_IPIComDesconto_GARE:  String;
    strMemCalGNRE_Produto_GARE:  String;
    strMemCalGNRE_Produto_ComDesconto_GARE:  String;
    strMemCalGNRE_Produto_ComIPI_GARE:  String;

    RT_CSTIS:      String[3];
    RT_CLATRIAIS:  String[6];
    RT_VBCIS:      Double;
    RT_PAIS:       Double;
    RT_PAISESP:    Double;
    RT_UTRIB:      String[6];
    RT_QTRIB:      Double;
    RT_VIS:        Double;
    RT_CST:        String[3];
    RT_CLATRIB:    String[6];
    RT_VBC:        Double;
    RT_PIBSUF:     Double;
    RT_VDIFUF:     Double;
    RT_PDIFUF:     Double;
    RT_VDEVUF:     Double;
    RT_PREDUF:     Double;
    RT_PEFETUF:    Double;
    RT_VIBSUF:     Double;
    RT_PIBSMUN:    Double;
    RT_PDIFMUN:    Double;
    RT_VDIFMUN:    Double;
    RT_VDEVMUN:    Double;
    RT_PREDMUN:    Double;
    RT_PEFETMUN:   Double;
    RT_VIBSMUN:    Double;
    RT_VIBS:       Double;
    RT_PCBS:       Double;
    RT_PDIFCBS:    Double;
    RT_VDIFCBS:    Double;
    RT_VDEVCBS:    Double;
    RT_PREDCBS:    Double;
    RT_PEFETCBS:   Double;
    RT_VCBS:       Double;
    RT_CSTREG:     String[3];
    RT_CLATRIREG:  String[6];
    RT_PEFIBSUF:   Double;
    RT_VTRIBUF:    Double;
    RT_PEFIBSMUN:  Double;
    RT_VTRIBMUN:   Double;
    RT_PEFCBS:     Double;
    RT_VTRIBCBS:   Double;
    procedure pGeraDados(var Lista: TStringList);
  End;

  TRecDetEle_Bco = packed Record
    strAutInc :    String;
    I02_NITEM :    String;
    DET_CODITE:    String;
    DET_CODMCO:    String;
    DET_VALIMP:    Double;
    DET_VALSIS:    Double;
    DET_CSTXML:    String;
    I02_CPROD:     String;
    CODCEST:       String;
    I03_CEAN:      String;
    I04_XPROD:     String;
    I05_NCM:       String;
    I06_EXTIPI:    String;
    I07_GENERO:    String;
    I08_CFOP:      String;
    I09_UCOM:      String;
    I10_QCOM:      Double;
    I10A_VUNCOM:   Double;
    I11_VPROD:     Double;
    I12_CEANTRIB:  String;
    I13_UTRIB:     String;
    I14_QTRIB:     Double;
    I14A_VUNTRIB:  Double;
    I15_VFRETE:    Double;
    I16_VSEG:      Double;
    I17_VDESC:     Double;
    I23B_VAFRMM:   Double;
    I17A_VOUTRO:   Double;
    I70_NFCI:      String;
    N11_ORIG:      String;
    N12_CST:       String;
    N12_CSOSN:     String;
    N13_MODBC:     String;
    N14_PREDBC:    Double;
    N15_VBC:       Double;
    N16_PICMS:     Double;
    N17_VICMS:     Double;
    N18_MODBCST:   String;
    N19_PMVAST:    Double;
    N20_PREBCST:   Double;
    LA02_CPRODANP: String;

    // 1) BASE_ST = vr.produto x IVA                             ( ex: 1050,00 x 1.8337 = 1925,39 )
    // 2) BASE_ST = ( vr.produto - desconto ) x IVA              ( ex: 1050,00 - 52,50 = 997,50 x 1.8337 = 1829,12 )
    // 3) BASE_ST = ( vr.produto + IPI ) x IVA                   ( ex: ( 1050,00 + 52,50 ) x 1.8337 = 2021,65 )
    // 4) BASE_ST = ( ( vr.produto - desconto ) + IPI ) x IVA    ( ex: ( 1050,00 + 49,87 ) - 52,50 = 1047,37 x 1.8337 = 1920.56 )

    N21_VBCST                    : Double;
    N21_VBCST_IPIComDesconto     : Double;
    N21_VBCST_Produto            : Double;
    N21_VBCST_Produto_ComDesconto: Double;
    N21_VBCST_Produto_ComIPI     : Double;

    N22_PICMSST:   Double;

    N23_VICMSST                    : Double;
    N23_VICMSST_IPIComDesconto     : Double;
    N23_VICMSST_Produto            : Double;
    N23_VICMSST_Produto_ComDesconto: Double;
    N23_VICMSST_Produto_ComIPI     : Double;

    N23_VICMSST_GARE                    : Double;
    N23_VICMSST_IPIComDesconto_GARE     : Double;
    N23_VICMSST_Produto_GARE            : Double;
    N23_VICMSST_Produto_ComDesconto_GARE: Double;
    N23_VICMSST_Produto_ComIPI_GARE     : Double;

    N24_CREDSN,
    N24_CREDICMSSN,
    N27A_VICMSDESON:Double;
    N27A_MOTDESICMS: String;
    O02_CLENQ:     String;
    O07_IPITRIB:   String;
    O09_CST:       String;
    O10_VBC:       Double;

    fltBasIPI:     Double;
    fltBasIPI_ComDesconto: Double;

    O11_QUNID:     Double;
    O12_VUNID:     Double;
    O13_PIPI:      Double;

    O14_VIPI:      Double;
    O14_VIPI_ComDesconto: Double;

    P03_VDESPADU:  Double;
    P04_VII:       Double;
    Q06_CST:       String;
    Q07_VBC:       Double;
    Q08_PPIS:      Double;
    Q09_VPIS:      Double;
    Q10_QBCPROD:   Double;
    Q11_VALIQPROD: Double;
    S06_CST:       String;
    S07_VBC:       Double;
    S08_PCOFINS:   Double;
    S09_QBCPROD:   Double;
    S10_VALIQPROD: Double;
    S11_VCOFINS:   Double;
    ITE_PER_CI:    Double;
    N17A_VBCFCP:   Double;
    N17B_PFCP:     Double;
    N17C_VFCP:     Double;
    N23A_VBCFCPST: Double;
    N23B_PFCPST:   Double;
    N23D_FCPST:    Double;

    N24_VBCUFDEST:      Double;
    N24_VBCFCPUFDEST:   Double;
    N24_PFCPUFDEST:     Double;
    N24_PICMSUFDEST:    Double;
    N24_PICMSINTER:     Double;
    N24_PICMSINTERPART: Double;
    N24_VFCPUFDEST:     Double;
    N24_VICMSUFDEST:    Double;
    N24_VICMSUFREMET:   Double;
    N26_VBCSTRET:       Double;
    N27_VICMSSTRET:     Double;
    N27_vICMSSubstituto:Double;

    N34_PREDBCEEFET:    Double; // Percentual de redução da base de cálculo efetiva
    N35_VBCEFET:        Double; // Valor da base de cálculo efetiva
    N36_PICMSEFET:      Double; // Alíquota do ICMS efetiva
    N37_VICMSEFET:      Double; // Valor do ICMS efetivo

    U02_VBC:            Double;
    U03_VALIQ:          Double;
    U04_VISSQN:         Double;
    U05_CMUNFG:         String;
    U06_CLISTSERV:      String;
    U07_VDEDUCAO:       Double;
    U09_VDESCINCOND:    Double;
    U12_INDSS:          String;
    U14_CMUN:           String;
    U15_CPAIS:          String;
    U17_INDINCENTIVO:   String;

    U51_PERCDEVOL:      Double;
    U61_VALIPIDEVOL:    Double;

    V01_infAdProd: WideString;

    XPED        :   String;
    NITEMPED    :   String;

    I19_NDI:           String;
    I21_XLOCDESEMB:    String;
    I23E_UFTERCEIRO:   String;
    I23D_CNPJ:         String;
    I20_DDI:           String;
    I23_DDESEMB:       String;
    I22_UFDESEMB:      String;
    I23A_TPVIATRANSP:  String;
    I23C_TPINTERMEDIO: String;
    I26_NADICAO:       Double;

    P02_VBC:           Double;
    P05_VIOF:          Double;
    DET_BASSUB:        Double;

    CAL_VLICMS:        Double;
    CAL_BASICM:        Double;
    CAL_ALQICM:        Double;
    CAL_BAS_ST:        Double;
    CAL_VR_IVA:        Double;
    CAL_VR_SUB:        Double;
    CAL_ALQINT:        Double;
    CAL_VFCPST:        Double;
    DET_CALSTU:        Integer;

  End;

  TRecRetEle = Record
    strReferenciaNFe : string;
  end;

  TValidaNFeCapa = Class
    private
      FcdsDetalhe: TUniClientDataSet;
      FCdsCapa   : TUniClientDataSet;
      FcdsDivergente: TUniClientDataSet;
      blnHabilitaVICMSDESON: Boolean;
      procedure pMontaEtruturaCDSDestalhes;
      procedure pMontaEtruturaCdsCapa;
      function  fGetValuAggregate(strFieldAggreg: string): Double;
      procedure pValidaCapaIgualDetalhes(strField: string);
      function fTemDivergencia: integer;
      function fValidarNotasFiscaisAux(pgbProgresso: TcxProgressBar): Boolean;
      function fSetaValoresCorrigidosAux(pgbProgresso: TcxProgressBar): Boolean;
    public
      blnTemDivergencia: Boolean;
      procedure pAddValoresCapa(recValoresCapa: TValoresCapa);
      procedure pAddValoresItem(recValoresItem: TValoresItem; intSequencia: integer);
      constructor Create;
      destructor Destroy; override;
      procedure pValidarNotasFiscais;
      procedure pAjustaDivergencias;
      procedure pReset;
      function  fNotaComDivergencia(strNumeroNota, strSerie, strDataEmissao: String): boolean;
      procedure pMarcaPosicaoNotaNaLista(strNumeroNota, strSerie, strDataEmissao: String; intPosicao: integer);
      function  fNotaAtual_Eh_divergente(intIndex: integer): boolean;
      procedure pSetaValoresCorrigidos(var recDetEle: TRecDetEle; intSequen: integer); overload;
      procedure pSetaValoresCorrigidos(cdsDivergente: TUniClientDataSet); overload;
      class procedure fIniciaValoresCapa(Var ARec: TValoresCapa);
      class procedure fIniciaValoresItem(Var Arec: TValoresItem);
  End;

  var objValidaNFeCapa: TValidaNFeCapa;

implementation

{ TValidaNFeCapa }

uses untGravando, untEntEditaItensNfe;

constructor TValidaNFeCapa.Create;
begin
  BlnHabilitaVICMSDESON := False;
  blnTemDivergencia := False;
  FcdsCapa    := TUniClientDataSet.Create(Nil);
  pMontaEtruturaCdsCapa;

  FcdsDetalhe := TUniClientDataSet.Create(Nil);
  pMontaEtruturaCDSDestalhes;

  FCdsDetalhe.AggregatesActive := True;

  FcdsDetalhe.Close;

//  pCriaAggregate(FCdsDetalhe, 'VALCON', 'TOT_VALCON');
  pCriaAggregate(FCdsDetalhe, 'TOTPRO', 'TOT_TOTPRO');
  pCriaAggregate(FCdsDetalhe, 'BASICM', 'TOT_BASICM');
  pCriaAggregate(FCdsDetalhe, 'VALICM', 'TOT_VALICM');
  pCriaAggregate(FCdsDetalhe, 'BAS_ST', 'TOT_BAS_ST');
  pCriaAggregate(FCdsDetalhe, 'VAL_ST', 'TOT_VAL_ST');
  pCriaAggregate(FCdsDetalhe, 'BASIPI', 'TOT_BASIPI');
  pCriaAggregate(FCdsDetalhe, 'VALIPI', 'TOT_VALIPI');
  pCriaAggregate(FCdsDetalhe, 'VALFRE', 'TOT_VALFRE');
  pCriaAggregate(FCdsDetalhe, 'VICMSDESON', 'TOT_VICMSDESON');
  pCriaAggregate(FCdsDetalhe, 'VDESC',  'TOT_VDESC');
  pCriaAggregate(FCdsDetalhe, 'VOUTRO', 'TOT_VOUTRO');
  pCriaAggregate(FCdsDetalhe, 'VSEG',   'TOT_VSEG');


  FcdsDetalhe.Open;

end;

destructor TValidaNFeCapa.Destroy;
begin
  FreeAndNil(FcdsDetalhe);
  FreeAndNil(FcdsCapa);
end;

procedure TValidaNFeCapa.pAddValoresCapa(recValoresCapa: TValoresCapa);
begin
  FCdsCapa.Insert;
  FCdsCapa.FieldByName('CHAVE_').AsString := recValoresCapa.strCHAVE_;
//  FCdsCapa.FieldByName('VALCON').AsFloat  := recValoresCapa.fltVALCON;
//  FCdsCapa.FieldByName('DIV_VALCON').AsInteger := 1;
  FCdsCapa.FieldByName('TOTPRO').AsFloat  := recValoresCapa.fltTOTPRO;
  FCdsCapa.FieldByName('DIV_TOTPRO').AsInteger := 0;
  FCdsCapa.FieldByName('BASICM').AsFloat  := recValoresCapa.fltBASICM;
  FCdsCapa.FieldByName('DIV_BASICM').AsInteger := 0;
  FCdsCapa.FieldByName('VALICM').AsFloat  := recValoresCapa.fltVALICM;
  FCdsCapa.FieldByName('DIV_VALICM').AsInteger := 0;
  FCdsCapa.FieldByName('BAS_ST').AsFloat  := recValoresCapa.fltBAS_ST;
  FCdsCapa.FieldByName('DIV_BAS_ST').AsInteger := 0;
  FCdsCapa.FieldByName('VAL_ST').AsFloat  := recValoresCapa.fltVAL_ST;
  FCdsCapa.FieldByName('DIV_VAL_ST').AsInteger := 0;
  FCdsCapa.FieldByName('BASIPI').AsFloat  := recValoresCapa.fltBASIPI;
  FCdsCapa.FieldByName('DIV_BASIPI').AsInteger := 0;
  FCdsCapa.FieldByName('VALIPI').AsFloat  := recValoresCapa.fltVALIPI;
  FCdsCapa.FieldByName('DIV_VALIPI').AsInteger := 0;
  FCdsCapa.FieldByName('VALFRE').AsFloat  := recValoresCapa.fltVALFRE;
  FCdsCapa.FieldByName('DIV_VALFRE').AsInteger := 0;
  FCdsCapa.FieldByName('VICMSDESON').AsFloat := recValoresCapa.fltVICMSDESON;
  FCdsCapa.FieldByName('DIV_VICMSDESON').AsFloat := 0;
  FCdsCapa.FieldByName('VDESC').AsFloat := recValoresCapa.fltVDESC;
  FCdsCapa.FieldByName('DIV_VDESC').AsFloat :=  0;
  FCdsCapa.FieldByName('VOUTRO').AsFloat := recValoresCapa.fltVOUTRO;
  FCdsCapa.FieldByName('DIV_VOUTRO').AsFloat :=  0;
  FCdsCapa.FieldByName('VSEG').AsFloat := recValoresCapa.fltVSEG;
  FCdsCapa.FieldByName('DIV_VSEG').AsFloat :=  0;
  FCdsCapa.FieldByName('TEM_DIVERGENCIA').AsInteger := 0;
  FCdsCapa.FieldByName('ALTERADO').AsInteger := 0;
  FCdsCapa.FieldByName('B08_NNF').AsString   := recValoresCapa.strB08_NNF;
  FCdsCapa.FieldByName('B07_SERIE').AsString := recValoresCapa.strB07_SERIE;
  FCdsCapa.FieldByName('B09_DEMI').AsString  := recValoresCapa.strB09_DEMI;
  If (Not blnHabilitaVICMSDESON) And (recValoresCapa.fltVICMSDESON > 0) Then
    blnHabilitaVICMSDESON := True;
  FCdsCapa.Post;
end;

procedure TValidaNFeCapa.pAddValoresItem(recValoresItem: TValoresItem; intSequencia: integer);
begin
  FCdsDetalhe.Insert;
  FCdsDetalhe.FieldByName('CHAVE_').AsString := recValoresItem.strCHAVE_;
  FCdsDetalhe.FieldByName('SEQUEN').AsInteger := intSequencia;
  FCdsDetalhe.FieldByName('CODITE').AsString := recValoresItem.strCODITE;
  FCdsDetalhe.FieldByName('DESITE').AsString := recValoresItem.strDESITE;
  FCdsDetalhe.FieldByName('TOTPRO').AsFloat  := recValoresItem.fltTOTPRO;
  FCdsDetalhe.FieldByName('BASICM').AsFloat  := recValoresItem.fltBASICM;
  FCdsDetalhe.FieldByName('VALICM').AsFloat  := recValoresItem.fltVALICM;
  FCdsDetalhe.FieldByName('BAS_ST').AsFloat  := recValoresItem.fltBAS_ST;
  FCdsDetalhe.FieldByName('VAL_ST').AsFloat  := recValoresItem.fltVAL_ST;
  FCdsDetalhe.FieldByName('BASIPI').AsFloat  := recValoresItem.fltBASIPI;
  FCdsDetalhe.FieldByName('VALIPI').AsFloat  := recValoresItem.fltVALIPI;
  FCdsDetalhe.FieldByName('VALFRE').AsFloat  := recValoresItem.fltVALFRE;

  FCdsDetalhe.FieldByName('VICMSDESON').AsFloat := recValoresItem.fltVICMSDESON;
  FCdsDetalhe.FieldByName('VDESC').AsFloat := recValoresItem.fltVDESC;
  FCdsDetalhe.FieldByName('VOUTRO').AsFloat := recValoresItem.fltVOUTRO;
  FCdsDetalhe.FieldByName('VSEG').AsFloat := recValoresItem.fltVSEG;
  FCdsDetalhe.FieldByName('B08_NNF').AsString := recValoresItem.strB08_NNF;

  FCdsDetalhe.FieldByName('ALQICM').AsFloat  := recValoresItem.fltALQICM;
  FCdsDetalhe.FieldByName('ALQIPI').AsFloat  := recValoresItem.fltALQIPI;
  FCdsDetalhe.FieldByName('ALQ_ST').AsFloat  := recValoresItem.fltALQ_ST;
  FCdsDetalhe.FieldByName('ID').AsInteger    := FCdsDetalhe.RecordCount;

  If (Not blnHabilitaVICMSDESON) And (recValoresItem.fltVICMSDESON > 0) Then
    blnHabilitaVICMSDESON := True;

  FCdsDetalhe.Post;
end;

procedure TValidaNFeCapa.pAjustaDivergencias;
begin
  If Not blnTemDivergencia Then
    Exit;

  If TfrmEntEditaItensNfe.fShowModal(FCdsCapa, FCdsDetalhe, BlnHabilitaVICMSDESON) = mrOk Then
  Begin
    FCdsCapa.Filtered := False;
    Try
      FCdsCapa.Filter := 'TEM_DIVERGENCIA = 1';
      FCdsCapa.Filtered := True;
      pValidarNotasFiscais;
      blnTemDivergencia :=  Not FCdsCapa.IsEmpty;
    Finally
      FCdsCapa.Filtered := False;
      FCdsCapa.Filter := '';
    End;
  End;
end;

procedure TValidaNFeCapa.pMarcaPosicaoNotaNaLista(strNumeroNota, strSerie,
  strDataEmissao: String; intPosicao: integer);
begin
  FCdsCapa.Filtered := False;
  Try
    FCdsCapa.Filter := 'B08_NNF = ' + QuotedStr(strNumeroNota) + ' AND ' +
                       'B07_SERIE = ' + QuotedStr(strSerie) + ' AND ' +
                       'B09_DEMI = ' + QuotedStr(strDataEmissao);

    FCdsCapa.Filtered := True;
    If FCdsCapa.IsEmpty Then
      Exit;
    FCdsCapa.Edit;
    FCdsCapa.FieldByName('POSICAO').AsInteger := intPosicao;
  Finally
    FCdsCapa.Filtered := False;
  End;

end;

procedure TValidaNFeCapa.pMontaEtruturaCdsCapa;
  procedure addField(Nome: string; Tipo: TFieldType; Tamanho: Integer = 0);
  Begin
    With FcdsCapa.FieldDefs.AddFieldDef Do
    Begin
      Name := Nome;
      DataType := Tipo;
      Size := Tamanho;
    End;
  End;
Begin
  addField('CHAVE_', ftString, 44);
//  addField('VALCON', ftFloat);
//  addField('DIV_VALCON', ftInteger);
  addField('TOTPRO', ftFloat);
  addField('DIV_TOTPRO', ftInteger);
  addField('BASICM', ftFloat);
  addField('DIV_BASICM', ftInteger);
  addField('VALICM', ftFloat);
  addField('DIV_VALICM', ftInteger);
  addField('BAS_ST', ftFloat);
  addField('DIV_BAS_ST', ftInteger);
  addField('VAL_ST', ftFloat);
  addField('DIV_VAL_ST', ftInteger);
  addField('BASIPI', ftFloat);
  addField('DIV_BASIPI', ftInteger);
  addField('VALIPI', ftFloat);
  addField('DIV_VALIPI', ftInteger);
  addField('VALFRE', ftFloat);
  addField('DIV_VALFRE', ftInteger);

  addField('VICMSDESON', ftFloat);
  addField('DIV_VICMSDESON', ftInteger);
  addField('VDESC', ftFloat);
  addField('DIV_VDESC', ftInteger);
  addField('VOUTRO', ftFloat);
  addField('DIV_VOUTRO', ftInteger);
  addField('VSEG', ftFloat);
  addField('DIV_VSEG', ftInteger);

  addField('TEM_DIVERGENCIA', ftInteger);
  addField('ALTERADO', ftInteger);
  addField('POSICAO', ftInteger);
  addField('B08_NNF', ftString, 20);
  addField('B07_SERIE', ftString,3);
  addField('B09_DEMI', ftString,10);
  FcdsCapa.CreateDataSet;
end;

procedure TValidaNFeCapa.pMontaEtruturaCDSDestalhes;
  procedure addField(Nome: string; Tipo: TFieldType; Tamanho: Integer = 0);
  Begin
    With FcdsDetalhe.FieldDefs.AddFieldDef Do
    Begin
      Name := Nome;
      DataType := Tipo;
      Size := Tamanho;
    End;
  End;
Begin
  addField('CHAVE_', ftString, 44);
  addField('SEQUEN', ftInteger);
  addField('CODITE', ftString, fTamCodIte);
  addField('DESITE', ftString, 30);
//  addField('VALCON', ftFloat);
  addField('TOTPRO', ftFloat);
  addField('BASICM', ftFloat);
  addField('VALICM', ftFloat);
  addField('BAS_ST', ftFloat);
  addField('VAL_ST', ftFloat);
  addField('BASIPI', ftFloat);
  addField('VALIPI', ftFloat);
  addField('VALFRE', ftFloat);

  addField('VICMSDESON', ftFloat);
  addField('VDESC', ftFloat);
  addField('VOUTRO', ftFloat);
  addField('VSEG', ftFloat);
  addField('B08_NNF', ftFloat);


  addField('ALQICM', ftFloat);
  addField('ALQIPI', ftFloat);
  addField('ALQ_ST', ftFloat);
  addField('ID', ftInteger);
  FcdsDetalhe.CreateDataSet;
End;

procedure TValidaNFeCapa.pReset;
begin
  FcdsDetalhe.EmptyDataSet;
  FCdsCapa.EmptyDataSet;
end;

procedure TValidaNFeCapa.pSetaValoresCorrigidos(cdsDivergente: TUniClientDataSet);
begin
  FcdsDivergente := cdsDivergente;
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.fExecutarAcao := fSetaValoresCorrigidosAux;
    frmGravando.lblGravando.Caption := 'Aguarde, Ajustando divergencias para os valores acertados no xml.';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

function TValidaNFeCapa.fSetaValoresCorrigidosAux(pgbProgresso: TcxProgressBar): Boolean;
  var strFilter : string;
      strNumDoc: string;
      blnAchou,
      blnProcessouTodosItensNota: Boolean;
Begin
  Result := True;
  strFilter := '';
  If FcdsDivergente.Filtered Then
    strFilter := FcdsDivergente.Filter;

  FcdsDivergente.Filtered := False;
  Try
    FcdsDivergente.Filter   := 'MOSTRA = ' + QuotedStr('S') + ' AND  ELETRO = ' + QuotedStr('S');
    FcdsDivergente.Filtered := True;
    FcdsDivergente.First;

    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := FcdsDivergente.RecordCount -1;

    While Not FcdsDivergente.Eof Do
    Begin
      FcdsDetalhe.Filtered := False;
      FCdsDetalhe.Filter := 'B08_NNF = ' + QuotedStr(FcdsDivergente.FieldByName('NUMDOC').AsString);
      FcdsDetalhe.Filtered := True;
      //Se tiver vazio proucura o proximo documento
      strNumDoc := FcdsDivergente.FieldByName('NUMDOC').AsString;
      If FcdsDetalhe.IsEmpty Then
      Begin
        blnAchou := False;
        While ((Not FcdsDivergente.Eof) Or (blnAchou)) Do
        Begin
          If FcdsDivergente.FieldByName('NUMDOC').AsString <> strNumDoc Then
            blnAchou := True
          Else
          Begin
            FcdsDivergente.Next;
            pgbProgresso.Position := pgbProgresso.Position + FcdsDivergente.RecordCount -1;
            Application.ProcessMessages;
          End;
        End;
        Continue;
      End;

      blnProcessouTodosItensNota := False;
      While (Not blnProcessouTodosItensNota)  Do
      Begin
        If FCdsDetalhe.Locate('SEQUEN', FcdsDivergente.FieldByName('SEQUEN').AsString,  []) Then
        Begin
          FcdsDivergente.Edit;
          FcdsDivergente.FieldByName('BASICM').AsFloat := FcdsDetalhe.FieldByName('BASICM').AsFloat;
          FcdsDivergente.FieldByName('VALICM').AsFloat := FcdsDetalhe.FieldByName('VALICM').AsFloat;
          FcdsDivergente.FieldByName('BASSUB').AsFloat := FcdsDetalhe.FieldByName('BAS_ST').AsFloat;
          FcdsDivergente.FieldByName('VALSUB').AsFloat := FcdsDetalhe.FieldByName('VAL_ST').AsFloat;

          FcdsDivergente.FieldByName('BASIPI').AsFloat := FcdsDetalhe.FieldByName('BASIPI').AsFloat;

          FcdsDivergente.FieldByName('VALIPI').AsFloat := FcdsDetalhe.FieldByName('VALIPI').AsFloat;
          FcdsDivergente.Post;
        End;
        FcdsDivergente.Next;
        blnProcessouTodosItensNota := (FcdsDivergente.Eof) Or (strNumDoc <> (FcdsDivergente.FieldByName('NUMDOC').AsString));
        pgbProgresso.Position := pgbProgresso.Position + FcdsDivergente.RecordCount -1;
        Application.ProcessMessages;

      End;
    End;
  Finally
    If Not fEmptyStr(strFilter) Then
    Begin
      FcdsDivergente.Filtered := False;
      FcdsDivergente.Filter   := strFilter;
      FcdsDivergente.Filtered := True;
    End;
  End;
End;


procedure TValidaNFeCapa.pValidarNotasFiscais;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.fExecutarAcao := fValidarNotasFiscaisAux;
    frmGravando.lblGravando.Caption := 'Aguarde, comparando valores da Nota Fiscal.';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
End;


function TValidaNFeCapa.fGetValuAggregate(strFieldAggreg: string): Double;
  function fTrataNull(value: Variant): Double;
  begin
    If Value = null Then
      Exit(0);
    Exit(Value);
  end;
begin
  Result := fTrataNull(TAggregateField(FCdsDetalhe.FieldByName(strFieldAggreg)).Value);
end;

class procedure TValidaNFeCapa.fIniciaValoresCapa(Var ARec: TValoresCapa);
begin
  With ARec do
  Begin
    strCHAVE_ := '';
    fltTOTPRO := 0;
    fltBASICM := 0;
    fltVALICM := 0;
    fltBAS_ST := 0;
    fltVAL_ST := 0;
    fltBASIPI := 0;
    fltVALIPI := 0;
    fltVALFRE := 0;
    fltVICMSDESON:= 0;
    fltVDESC := 0;
    fltVOUTRO := 0;
    fltVSEG := 0;
    strB08_NNF := '';
  End;
end;

class procedure TValidaNFeCapa.fIniciaValoresItem(Var Arec: TValoresItem);
begin
  With ARec do
  Begin
    fltTOTPRO := 0;
    fltBASICM := 0;
    fltVALICM := 0;
    fltALQICM := 0;
    fltBAS_ST := 0;
    fltALQ_ST := 0;
    fltVAL_ST := 0;

    fltBASIPI := 0;
    fltBASIPI_ComDesconto := 0;

    fltALQIPI := 0;

    fltVALIPI := 0;
    fltVALIPI_ComDesconto := 0;

    fltVALFRE := 0;
    fltVICMSDESON := 0;
    fltVDESC  := 0;
    fltVOUTRO := 0;
    fltVSEG   := 0;
  End;
end;

function TValidaNFeCapa.fNotaAtual_Eh_divergente(intIndex: integer): boolean;
begin
  Result := False;
  FCdsCapa.Filtered := False;
  FCdsCapa.Filter := 'POSICAO = ' + IntToStr(intIndex);
  FCdsCapa.Filtered := True;
  If FCdsCapa.IsEmpty Then
    Exit;
  If FCdsCapa.FieldByName('ALTERADO').AsInteger = 1 Then;
    Result := True;
end;

procedure TValidaNFeCapa.pSetaValoresCorrigidos(var recDetEle: TRecDetEle; intSequen: integer);
begin
  FcdsDetalhe.Filtered := False;
  FCdsDetalhe.Filter := 'CHAVE_ = ' + QuotedStr(FCdsCapa.FieldByName('CHAVE_').AsString) + 'AND SEQUEN = ' + IntToStr(intSequen);
  FcdsDetalhe.Filtered := True;
  If FcdsDetalhe.IsEmpty Then
    Exit;

  recDetEle.I11_VPROD       := FCdsDetalhe.FieldByName('TOTPRO').AsFloat;
  recDetEle.N27A_VICMSDESON := FCdsDetalhe.FieldByName('VICMSDESON').AsFloat;
  recDetEle.I17_VDESC       := FCdsDetalhe.FieldByName('VDESC').AsFloat;
  recDetEle.I17A_VOUTRO     := FCdsDetalhe.FieldByName('VOUTRO').AsFloat;
  recDetEle.I16_VSEG        := FCdsDetalhe.FieldByName('VSEG').AsFloat;
  recDetEle.N15_VBC         := FCdsDetalhe.FieldByName('BASICM').AsFloat;
  recDetEle.N17_VICMS       := FCdsDetalhe.FieldByName('VALICM').AsFloat;
  recDetEle.N21_VBCST       := FCdsDetalhe.FieldByName('BAS_ST').AsFloat;
  recDetEle.N23_VICMSST     := FCdsDetalhe.FieldByName('VAL_ST').AsFloat;
  recDetEle.O10_VBC         := FCdsDetalhe.FieldByName('BASIPI').AsFloat;
  recDetEle.O14_VIPI        := FCdsDetalhe.FieldByName('VALIPI').AsFloat;
  recDetEle.I15_VFRETE      := FCdsDetalhe.FieldByName('VALFRE').AsFloat;
end;

function TValidaNFeCapa.fNotaComDivergencia(strNumeroNota, strSerie, strDataEmissao: String): boolean;
begin
  FCdsCapa.Filtered := False;
  FCdsCapa.Filter := 'B08_NNF = ' + QuotedStr(strNumeroNota) + ' AND ' +
                     'B07_SERIE = ' + QuotedStr(strSerie) + ' AND ' +
                     'B09_DEMI = ' + QuotedStr(strDataEmissao);
  FCdsCapa.Filtered := True;
  If FCdsCapa.IsEmpty Then
    Exit(False);

   FCdsDetalhe.Filtered := False;
   FCdsDetalhe.Filter   := 'CHAVE_ = ' + QuotedStr(FCdsCapa.FieldByname('CHAVE_').AsString);
   FCdsDetalhe.Filtered := True;

   Exit(FCdsCapa.FieldByName('TEM_DIVERGENCIA').AsInteger = 1);
end;

function TValidaNFeCapa.fTemDivergencia: integer;
begin
  Result :=0;
  If (FCdsCapa.FieldByName('DIV_TOTPRO').AsInteger = 1) Or (FCdsCapa.FieldByName('DIV_VALICM').AsInteger = 1) Or
     (FCdsCapa.FieldByName('DIV_BASICM').AsInteger = 1) Or (FCdsCapa.FieldByName('DIV_VAL_ST').AsInteger = 1) Or
     (FCdsCapa.FieldByName('DIV_BAS_ST').AsInteger = 1) Or (FCdsCapa.FieldByName('DIV_VALIPI').AsInteger = 1) Or
     (FCdsCapa.FieldByName('DIV_BASIPI').AsInteger = 1) Or (FCdsCapa.FieldByName('DIV_VALFRE').AsInteger = 1) Or
     (FCdsCapa.FieldByName('DIV_VICMSDESON').AsInteger = 1) Or (FCdsCapa.FieldByName('DIV_VDESC').AsInteger = 1) Or
     (FCdsCapa.FieldByName('DIV_VOUTRO').AsInteger = 1) Or (FCdsCapa.FieldByName('DIV_VSEG').AsInteger = 1) Then
    Result := 1;
end;

function TValidaNFeCapa.fValidarNotasFiscaisAux(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Result := True;
  Try
    blnTemDivergencia := False;
    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := FCdsDetalhe.RecordCount -1;
    FcdsCapa.First;
    While Not FcdsCapa.Eof Do
    Begin
      FCdsDetalhe.AggregatesActive := False;
      FCdsDetalhe.Filtered := False;
      FCdsDetalhe.Filter := 'CHAVE_ = ' + QuotedStr(FcdsCapa.FieldByName('CHAVE_').AsString);
      FCdsDetalhe.Filtered := True;
      FCdsDetalhe.AggregatesActive := True;

      FcdsCapa.Edit;
      pValidaCapaIgualDetalhes('TOTPRO');
      pValidaCapaIgualDetalhes('BASICM');
      pValidaCapaIgualDetalhes('VALICM');
      pValidaCapaIgualDetalhes('BAS_ST');
      pValidaCapaIgualDetalhes('VAL_ST');
      pValidaCapaIgualDetalhes('BASIPI');
      pValidaCapaIgualDetalhes('VALIPI');
      pValidaCapaIgualDetalhes('VALFRE');
      pValidaCapaIgualDetalhes('VICMSDESON');
      pValidaCapaIgualDetalhes('VDESC');
      pValidaCapaIgualDetalhes('VOUTRO');
      pValidaCapaIgualDetalhes('VSEG');

      FCdsCapa.FieldByName('TEM_DIVERGENCIA').AsInteger := fTemDivergencia;
      //Se foi econtrado Divergencia Grava
      If (FCdsCapa.FieldByName('TEM_DIVERGENCIA').AsInteger = 1) Then
      Begin
        FcdsCapa.Post;
        blnTemDivergencia := True;
        FcdsCapa.Next;
      end
      //Se não tem divergencia e não foi corrigido não precisa salvar
      Else If (FCdsCapa.FieldByName('TEM_DIVERGENCIA').AsInteger = 0) And
              (FCdsCapa.FieldByName('ALTERADO').AsInteger = 0) Then
      Begin
        FcdsCapa.Cancel;
        FcdsCapa.Delete;
      End
      Else //Não tem divergencia porque foi corrigido.
      Begin
        FcdsCapa.Post;
        FcdsCapa.Next;
      End;
     pgbProgresso.Position := pgbProgresso.Position + FCdsDetalhe.RecordCount -1;
      Application.ProcessMessages;
    End;
    FcdsCapa.Filtered := False;
    FcdsDetalhe.Filtered := False;
  Except
    On e: Exception Do
    Begin
      pMensagensErro(E.Message, '[TValidaNFeCapa.fValidarNotasFiscaisAux]');
      Result := False;
    End;
  End;
End;

procedure TValidaNFeCapa.pValidaCapaIgualDetalhes(strField: string);
begin
  If fFormataFloat(FcdsCapa.FieldByName(strField).AsFloat, 2) <> fFormataFloat(fGetValuAggregate('TOT_' + strField), 2) Then
    FCdsCapa.FieldByName('DIV_' + strField).AsInteger := 1
  Else
    FCdsCapa.FieldByName('DIV_' + strField).AsInteger := 0;

end;

{ TRecDetEle }

procedure TRecDetEle.pGeraDados(var Lista: TStringList);
var
  rtype: TRTTIType;
  fields: TArray<TRttiField>;
  i: Integer;
  strName, strFieldType, strValue: String;
  RecDetEle_Bco : TRecDetEle_Bco;
begin
  RecDetEle_Bco.strAutInc                           := String(Self.strAutInc);
  RecDetEle_Bco.I02_NITEM                           := Self.I02_NITEM;
  RecDetEle_Bco.DET_CODITE                          := String(Self.DET_CODITE);
  RecDetEle_Bco.DET_CODMCO                          := Self.DET_CODMCO;
  RecDetEle_Bco.DET_VALIMP                          := Self.DET_VALIMP;
  RecDetEle_Bco.DET_VALSIS                          := Self.DET_VALSIS;
  RecDetEle_Bco.DET_CSTXML                          := String(Self.DET_CSTXML);
  RecDetEle_Bco.I02_CPROD                           := String(Self.I02_CPROD);
  RecDetEle_Bco.CODCEST                             := String(Self.CODCEST);
  RecDetEle_Bco.I03_CEAN                            := String(Self.I03_CEAN);
  RecDetEle_Bco.I04_XPROD                           := String(Self.I04_XPROD);
  RecDetEle_Bco.I05_NCM                             := String(Self.I05_NCM);
  RecDetEle_Bco.I06_EXTIPI                          := String(Self.I06_EXTIPI);
  RecDetEle_Bco.I07_GENERO                          := String(Self.I07_GENERO);
  RecDetEle_Bco.I08_CFOP                            := String(Self.I08_CFOP);
  RecDetEle_Bco.I09_UCOM                            := String(Self.I09_UCOM);
  RecDetEle_Bco.I10_QCOM                            := Self.I10_QCOM;
  RecDetEle_Bco.I10A_VUNCOM                         := Self.I10A_VUNCOM;
  RecDetEle_Bco.I11_VPROD                           := Self.I11_VPROD;
  RecDetEle_Bco.I12_CEANTRIB                        := String(Self.I12_CEANTRIB);
  RecDetEle_Bco.I13_UTRIB                           := String(Self.I13_UTRIB);
  RecDetEle_Bco.I14_QTRIB                           := Self.I14_QTRIB;
  RecDetEle_Bco.I14A_VUNTRIB                        := Self.I14A_VUNTRIB;
  RecDetEle_Bco.I15_VFRETE                          := Self.I15_VFRETE;
  RecDetEle_Bco.I16_VSEG                            := Self.I16_VSEG;
  RecDetEle_Bco.I17_VDESC                           := Self.I17_VDESC;
  RecDetEle_Bco.I23B_VAFRMM                         := Self.I23B_VAFRMM;
  RecDetEle_Bco.I17A_VOUTRO                         := Self.I17A_VOUTRO;
  RecDetEle_Bco.I70_NFCI                            := String(Self.I70_NFCI);
  RecDetEle_Bco.N11_ORIG                            := String(Self.N11_ORIG);
  RecDetEle_Bco.N12_CST                             := String(Self.N12_CST);
  RecDetEle_Bco.N12_CSOSN                           := String(Self.N12_CSOSN);
  RecDetEle_Bco.N13_MODBC                           := String(Self.N13_MODBC);
  RecDetEle_Bco.N14_PREDBC                          := Self.N14_PREDBC;
  RecDetEle_Bco.N15_VBC                             := Self.N15_VBC;
  RecDetEle_Bco.N16_PICMS                           := Self.N16_PICMS;
  RecDetEle_Bco.N17_VICMS                           := Self.N17_VICMS;
  RecDetEle_Bco.N18_MODBCST                         := String(Self.N18_MODBCST);
  RecDetEle_Bco.N19_PMVAST                          := Self.N19_PMVAST;
  RecDetEle_Bco.N20_PREBCST                         := Self.N20_PREBCST;
  RecDetEle_Bco.LA02_CPRODANP                       := String(Self.LA02_CPRODANP);
  RecDetEle_Bco.N21_VBCST                           := Self.N21_VBCST;
  RecDetEle_Bco.N21_VBCST_IPIComDesconto            := Self.N21_VBCST_IPIComDesconto;
  RecDetEle_Bco.N21_VBCST_Produto                   := Self.N21_VBCST_Produto;
  RecDetEle_Bco.N21_VBCST_Produto_ComDesconto       := Self.N21_VBCST_Produto_ComDesconto;
  RecDetEle_Bco.N21_VBCST_Produto_ComIPI            := Self.N21_VBCST_Produto_ComIPI;
  RecDetEle_Bco.N22_PICMSST                         := Self.N22_PICMSST;
  RecDetEle_Bco.N23_VICMSST                         := Self.N23_VICMSST;
  RecDetEle_Bco.N23_VICMSST_IPIComDesconto          := Self.N23_VICMSST_IPIComDesconto;
  RecDetEle_Bco.N23_VICMSST_Produto                 := Self.N23_VICMSST_Produto;
  RecDetEle_Bco.N23_VICMSST_Produto_ComDesconto     := Self.N23_VICMSST_Produto_ComDesconto;
  RecDetEle_Bco.N23_VICMSST_Produto_ComIPI          := Self.N23_VICMSST_Produto_ComIPI;

  RecDetEle_Bco.N23_VICMSST_GARE                    := Self.N23_VICMSST_GARE;
  RecDetEle_Bco.N23_VICMSST_IPIComDesconto_GARE     := Self.N23_VICMSST_IPIComDesconto_GARE;
  RecDetEle_Bco.N23_VICMSST_Produto_GARE            := Self.N23_VICMSST_Produto_GARE;
  RecDetEle_Bco.N23_VICMSST_Produto_ComDesconto_GARE:= Self.N23_VICMSST_Produto_ComDesconto_GARE;
  RecDetEle_Bco.N23_VICMSST_Produto_ComIPI_GARE     := Self.N23_VICMSST_Produto_ComIPI_GARE;

  RecDetEle_Bco.N24_CREDSN                          := Self.N24_CREDSN;
  RecDetEle_Bco.N24_CREDICMSSN                      := Self.N24_CREDICMSSN;
  RecDetEle_Bco.N27A_VICMSDESON                     := Self.N27A_VICMSDESON;
  RecDetEle_Bco.N27A_MOTDESICMS                     := String(Self.N27A_MOTDESICMS);
  RecDetEle_Bco.O02_CLENQ                           := String(Self.O02_CLENQ);
  RecDetEle_Bco.O07_IPITRIB                         := String(Self.O07_IPITRIB);
  RecDetEle_Bco.O09_CST                             := String(Self.O09_CST);
  RecDetEle_Bco.O10_VBC                             := Self.O10_VBC;

  RecDetEle_Bco.fltBasIPI                           := Self.fltBasIPI;
  RecDetEle_Bco.fltBasIPI_ComDesconto               := Self.fltBasIPI_ComDesconto;

  RecDetEle_Bco.O11_QUNID                           := Self.O11_QUNID;
  RecDetEle_Bco.O12_VUNID                           := Self.O12_VUNID;
  RecDetEle_Bco.O13_PIPI                            := Self.O13_PIPI;

  RecDetEle_Bco.O14_VIPI                            := Self.O14_VIPI;
  RecDetEle_Bco.O14_VIPI_ComDesconto                := Self.O14_VIPI_ComDesconto;

  RecDetEle_Bco.P03_VDESPADU                        := Self.P03_VDESPADU;
  RecDetEle_Bco.P04_VII                             := Self.P04_VII;
  RecDetEle_Bco.Q06_CST                             := String(Self.Q06_CST);
  RecDetEle_Bco.Q07_VBC                             := Self.Q07_VBC;
  RecDetEle_Bco.Q08_PPIS                            := Self.Q08_PPIS;
  RecDetEle_Bco.Q09_VPIS                            := Self.Q09_VPIS;
  RecDetEle_Bco.Q10_QBCPROD                         := Self.Q10_QBCPROD;
  RecDetEle_Bco.Q11_VALIQPROD                       := Self.Q11_VALIQPROD;
  RecDetEle_Bco.S06_CST                             := String(Self.S06_CST);
  RecDetEle_Bco.S07_VBC                             := Self.S07_VBC;
  RecDetEle_Bco.S08_PCOFINS                         := Self.S08_PCOFINS;
  RecDetEle_Bco.S09_QBCPROD                         := Self.S09_QBCPROD;
  RecDetEle_Bco.S10_VALIQPROD                       := Self.S10_VALIQPROD;
  RecDetEle_Bco.S11_VCOFINS                         := Self.S11_VCOFINS;
  RecDetEle_Bco.ITE_PER_CI                          := Self.ITE_PER_CI;
  RecDetEle_Bco.N17A_VBCFCP                         := Self.N17A_VBCFCP;
  RecDetEle_Bco.N17B_PFCP                           := Self.N17B_PFCP;
  RecDetEle_Bco.N17C_VFCP                           := Self.N17C_VFCP;
  RecDetEle_Bco.N23A_VBCFCPST                       := Self.N23A_VBCFCPST;
  RecDetEle_Bco.N23B_PFCPST                         := Self.N23B_PFCPST;
  RecDetEle_Bco.N23D_FCPST                          := Self.N23D_FCPST;

  RecDetEle_Bco.N24_VBCUFDEST                       := Self.N24_VBCUFDEST;
  RecDetEle_Bco.N24_VBCFCPUFDEST                    := Self.N24_VBCFCPUFDEST;
  RecDetEle_Bco.N24_PFCPUFDEST                      := Self.N24_PFCPUFDEST;
  RecDetEle_Bco.N24_PICMSUFDEST                     := Self.N24_PICMSUFDEST;
  RecDetEle_Bco.N24_PICMSINTER                      := Self.N24_PICMSINTER;
  RecDetEle_Bco.N24_PICMSINTERPART                  := Self.N24_PICMSINTERPART;
  RecDetEle_Bco.N24_VFCPUFDEST                      := Self.N24_VFCPUFDEST;
  RecDetEle_Bco.N24_VICMSUFDEST                     := Self.N24_VICMSUFDEST;
  RecDetEle_Bco.N24_VICMSUFREMET                    := Self.N24_VICMSUFREMET;
  RecDetEle_Bco.N26_VBCSTRET                        := Self.N26_VBCSTRET;
  RecDetEle_Bco.N27_VICMSSTRET                      := Self.N27_VICMSSTRET;
  RecDetEle_Bco.N27_vICMSSubstituto                 := Self.N27_vICMSSubstituto;

  RecDetEle_Bco.N34_PREDBCEEFET                     := Self.N34_PREDBCEEFET;
  RecDetEle_Bco.N35_VBCEFET                         := Self.N35_VBCEFET;
  RecDetEle_Bco.N36_PICMSEFET                       := Self.N36_PICMSEFET;
  RecDetEle_Bco.N37_VICMSEFET                       := Self.N37_VICMSEFET;

  RecDetEle_Bco.U02_VBC                             := Self.U02_VBC;
  RecDetEle_Bco.U03_VALIQ                           := Self.U03_VALIQ;
  RecDetEle_Bco.U04_VISSQN                          := Self.U04_VISSQN;
  RecDetEle_Bco.U05_CMUNFG                          := String(Self.U05_CMUNFG);
  RecDetEle_Bco.U06_CLISTSERV                       := String(Self.U06_CLISTSERV);
  RecDetEle_Bco.U07_VDEDUCAO                        := Self.U07_VDEDUCAO;
  RecDetEle_Bco.U09_VDESCINCOND                     := Self.U09_VDESCINCOND;
  RecDetEle_Bco.U12_INDSS                           := String(Self.U12_INDSS);
  RecDetEle_Bco.U14_CMUN                            := String(Self.U14_CMUN);
  RecDetEle_Bco.U15_CPAIS                           := String(Self.U15_CPAIS);
  RecDetEle_Bco.U17_INDINCENTIVO                    := String(Self.U17_INDINCENTIVO);

  RecDetEle_Bco.U51_PERCDEVOL                       := Self.U51_PERCDEVOL;
  RecDetEle_Bco.U61_VALIPIDEVOL                     := Self.U61_VALIPIDEVOL;

  RecDetEle_Bco.V01_infAdProd                       := Self.V01_infAdProd;

  RecDetEle_Bco.XPED                                := Self.XPED;
  RecDetEle_Bco.NITEMPED                            := Self.NITEMPED;

  RecDetEle_Bco.I19_NDI                             := String(Self.I19_NDI);
  RecDetEle_Bco.I21_XLOCDESEMB                      := String(Self.I21_XLOCDESEMB);
  RecDetEle_Bco.I23E_UFTERCEIRO                     := String(Self.I23E_UFTERCEIRO);
  RecDetEle_Bco.I23D_CNPJ                           := String(Self.I23D_CNPJ);
  RecDetEle_Bco.I20_DDI                             := String(Self.I20_DDI);
  RecDetEle_Bco.I23_DDESEMB                         := String(Self.I23_DDESEMB);
  RecDetEle_Bco.I22_UFDESEMB                        := String(Self.I22_UFDESEMB);
  RecDetEle_Bco.I23A_TPVIATRANSP                    := String(Self.I23A_TPVIATRANSP);
  RecDetEle_Bco.I23C_TPINTERMEDIO                   := String(Self.I23C_TPINTERMEDIO);
  RecDetEle_Bco.I26_NADICAO                         := Self.I26_NADICAO;

  RecDetEle_Bco.P02_VBC                             := Self.P02_VBC;
  RecDetEle_Bco.P05_VIOF                            := Self.P05_VIOF;
  RecDetEle_Bco.DET_BASSUB                          := Self.DET_BASSUB;

  RecDetEle_Bco.CAL_VLICMS                          := Self.CAL_VLICMS;
  RecDetEle_Bco.CAL_BASICM                          := Self.CAL_BASICM;
  RecDetEle_Bco.CAL_ALQICM                          := Self.CAL_ALQICM;
  RecDetEle_Bco.CAL_BAS_ST                          := Self.CAL_BAS_ST;
  RecDetEle_Bco.CAL_VR_IVA                          := Self.CAL_VR_IVA;
  RecDetEle_Bco.CAL_VR_SUB                          := Self.CAL_VR_SUB;
  RecDetEle_Bco.CAL_ALQINT                          := Self.CAL_ALQINT;
  RecDetEle_Bco.CAL_VFCPST                          := Self.CAL_VFCPST;
  RecDetEle_Bco.DET_CALSTU                          := Self.DET_CALSTU;

  rtype := TRTTIContext.Create.GetType(TypeInfo(TRecDetEle_Bco));
  Lista.Add(rtype.ToString);
  fields := rtype.GetFields;
  for i := 0 to High(fields) do
  Begin
    strName := fields[i].Name;
    strFieldType := fields[i].FieldType.ToString;
    strValue := fields[i].GetValue(@RecDetEle_Bco).ToString;
    Lista.Add(Format('%s: %s : %s', [strName, strFieldType, strValue]));
  End;

end;

End.
