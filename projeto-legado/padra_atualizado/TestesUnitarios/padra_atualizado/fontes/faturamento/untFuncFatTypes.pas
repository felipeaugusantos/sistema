unit untFuncFatTypes;

interface

uses Shared.Functions.Types;

Type
  TDadosFechamento = Record
    strCodIte : String;
    strClaFis : String;
    fltAlqIpi : Double;
    fltValipi : Double;
    fltBasIpi : Double;
    fltTotIte : Double;
    fltValFre : Double;
    fltDesAce : Double;
    fltDesEsp : Double;
    strEspDev : String;
    strCodFis : String;
    strCodSit : String;
    intOrdem  : Integer;
    strNotUlt : String;
    fltPICMEF : Double;
    fltBICMEF : Double;
    fltAICMEF : Double;
    fltVICMEF : Double;
    fltSICMEF : Double;
    fltBSTANT : Double;
    fltVSTANT : Double;
    fltQtdIte : Double;
    fltAlqIcm : Double;
    strIdePro : String;
    strCodAbf : String;
    strIteAbf : String; //
    fltBasIcm : Double; //
    strDocDev : String; //
    fltBasRet : Double; //
    strIndRev : String; //Industrialização ou revenda
    fltValRet : Double; //
    strEntFut : String;
    strEmpDev : String; //
    fltBas__S : Double; //
    strCodFor : String;
    fltAlq__S : Double;
    fltUniTar : Double;
    fltPreCus : Double;
    fltPreUlt : Double;
    fltImpUlt : Double;
    fltPrcTin : Double;
    fltCusIte : Double;
    strClaIpi : String;
    strRICMPR : String;
    fltValIcm : Double;
    fltPerBas : Double;
    fltValDif : Double;
    fltAlqAnt : Double;
    fltBIcAnt : Double;
    fltIcmAnt : Double;
    fltPerRed : Double;
    fltValIva : Double;
    fltIVA_ST : Double;
    fltAlqRet : Double;
    fltPeBaST : Double;
    fltBasOrg : Double;
    fltIcmOrg : Double;
    fltBaRtSp : Double;
    fltVaRtSp : Double;
    fltIcOpPr : Double;

    fltTotGerIteParaCalcIcmEfetivo : Double;
    fltAlqIcmIntParaCalcIcmEfetivo : Double;
    opcINFesp                      : TopcItensNFespTinta;
    blnMeiaNotaFatorExpedicao      : Boolean;
    recDifalFCP                    : TRecDifalFCP;

    fltIpiCon: Double;
    fltComLiq: Double;

    fltBaseOperacaoPropriaICMSEntrada     : Double;
    fltAliquotaOperacaoPropriaICMSEntrada : Double;
    fltValorOperacaoPropriaIMCSEntrada    : Double;
    strEmpIte                             : String;

    fltValorCalculadoSTConsignacao : Double;
    strProEmb: String;
    blnAtoDeclaratorioDF: Boolean;

    fltOrgPubIcm: Double;
    fltOrgPubPis: Double;
    fltOrgPubCof: Double;

    fltOrgPubAlqIcm: Double;
    fltOrgPubAlqPis: Double;
    fltOrgPubAlqCof: Double;

    strImpDir: String;

    fltVDesST: Double;
    strMDesST: String;
    blnSTAtribuidaPorRegimeEspecial: Boolean;
    fltBasIcmBenST: Double;
    fltDesEspBaiFut: Double;
  End;

type
  TMatrizFechamento = Array Of TDadosFechamento;

implementation

end.
