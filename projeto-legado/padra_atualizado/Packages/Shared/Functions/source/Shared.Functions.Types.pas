unit Shared.Functions.Types;

interface

Type
  TSituacaoIPI = (sitTributado,
                  sitIsento,
                  sitNaoTributado,
                  sitImune,
                  sitSuspenso);


type
  TOpcItensNFespTinta = (opcVazio,
                         opcProdutoAcabado,
                         opcBasesColorantesSemDestaqueImpostos,
                         opcBasesColorantesComDestaqueImpostos,
                         opcColorantesTributados,
                         opcColorantesNaoTributados);

Type
  TMetodoArredondamentoICMSECF = function(AValor: Double): Double of object;


Type
  TRecDifalFCP = record
    fltAlDifa: Double;
    fltDifDes: Double;
    fltDifOri: Double;
    fltValFcp: Double;
    fltPerFcp: Double;
    fltAlqIne: Double;
    fltAlqUfd: Double;
    fltBcuFde: Double;
    fltPerPar: Double;
    fltBasFcp: Double;
    blnGrvInf: Boolean;
  End;

Type
  TTipoNotaComplemento = (tncCreditoICMS,
                          tncComplementoICMS,
                          tncComplementoIPI,
                          tncComplementoFrete,
                          tncTransferenciaCredorICMS,
                          tncTransferenciaDevedorICMS,
                          tncComplementoValor,
                          tncRestIcmsStEstoque,
                          tncEstornoDeCredito,
                          tncComplementoDifalFcp,
                          tncComplementoStPerfilCnc,
                          tncNFAjusteICMSaMaior,
                          tncReformaTributariaDebito,
                          tncReformaTributariaCredito,
                          tncNenhum);

{*******************************************}
{* INFORMACOES PARA NFe DE COMPLEMENTO     *}
{****************************************PH*}
Type
  TNfeComplementoItem = Record
    strAutInc: String;
    strCodIte: String;
    strDesIte: String;
    strRefere: String;
    strClaFis: String;
    strUnidad: String;
    strSigUni: String;
    strComLub: String;
    strCstOri: String;
    strCodFis: String;
    strClaIpi: String;

    fltDesEsp: Double;
    fltValUni: Double;
    fltQtdIte: Double;
    fltTotIte: Double;

    fltBasIcm: Double;
    fltAlqIcm: Double;
    fltValIcm: Double;

    fltBasRet: Double;
    fltAlqRet: Double;
    fltValRet: Double;

    fltBasFcp: Double;
    fltAlqFcp: Double;
    fltValFcp: Double;

    fltBasFcpST: Double;
    fltAlqFcpST: Double;
    fltValFcpST: Double;

    fltBasIpi: Double;
    fltAlqIpi: Double;
    fltValIpi: Double;

    fltValCom: Double;

    fltBasIcmOri: Double;
    fltAlqIcmOri: Double;
    fltValIcmOri: Double;

    fltBasRetOri: Double;
    fltAlqRetOri: Double;
    fltValRetOri: Double;

    fltBasIpiOri: Double;
    fltAlqIpiOri: Double;
    fltValIpiOri: Double;

    strCstPis: String;
    fltBasPis: Double;
    fltAlqPis: Double;
    fltValPis: Double;

    strCstCof: String;
    fltBasCof: Double;
    fltAlqCof: Double;
    fltValCof: Double;

    strIncPis: String;

    dtaDtaEnt: TDateTime;

    fltUnitar: Double;

    tncTipoItemNotaComplemento: TTipoNotaComplemento;

    recDifalFCP : TRecDifalFCP;

    fltSICMEF: Double;
    fltBSTANT: Double;
    fltVSTANT: Double;

    fltOutIcm: Double;
    fltIseIcm: Double;
    fltIcmsOp: Double;
    fltPerDif: Double;
    fltIcmDif: Double;

    strNum_DI: String;
    dtaDta_DI: TDate;
    strLcdEse: String;
    strUfdEse: String;
    dtaDtdEse: TDate;
    strVtrInt: String;
    fltVaFRMM: Double;
    strForImp: String;
    strCgcAdq: String;
    strUf_Adq: String;

  end;

Type
  TNfeComplementoItens = Array Of TNfeComplementoItem;

Type
  ArrOfString = Array Of String;
  ArrOfVariant = Array Of Variant;

Type
  TOpcTipoOperacaoPedidoVenda = (Venda, Bonificacao, ContaOrdem, Amostra, RemessaContaOrdem);


type
  TDadosFechamentoIcmsEfetivo = Record
    strCodFis : String;
    strCodSit : String;
    strCodIte : String;
    strClaFis : String;
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
    fltTotIte : Double;
    fltAlqIcm : Double;
    fltDesEsp : Double;
    fltValFre : Double;
    fltDesAce : Double;
    fltTotGerIteParaCalcIcmEfetivo : Double;
    fltAlqIcmIntParaCalcIcmEfetivo : Double;
    opcINFesp : TopcItensNFespTinta;
    strIdePro : String;
    fltComLiq : Double;
    fltBaseOperacaoPropriaICMSEntrada,
    fltAliquotaOperacaoPropriaICMSEntrada,
    fltValorOperacaoPropriaIMCSEntrada : Double;
    strEmpIte : string;
//    strTipoTinta: String;
  End;

Type
  TMatrizFechamentoIcmsEfetivo = Array Of TDadosFechamentoIcmsEfetivo;


Type
  TOpcIndustrializacaoOuRevenda = (OpcIndustrializacao, OpcRevenda);

Type
  TTipoMoeda = (moeDolar, moePeso, moeGuaranie, moeEuro, moeReal);

implementation

end.
