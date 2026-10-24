{******************************************************************************************}
{* Classes que representa uma Base Automotiva, com todos os atributos usados pelo sistema *}
{***************************************************************************************AC*}
unit untBaseAutomotiva;

interface

uses
  Classes;

type
  TBaseAutomotiva = class(TCollectionItem)
  private
    strLinBas: String;
    strCodBas: String;
    fltQtdCon: Double;
    fltQtdDil: Double; // Qtd. Diluido 1
    fltQtdDi2: Double; // Qtd. Diluido 2
    fltQtdPCo: Double; // Qtd. Padrao Concentrado (Salcomix e Glasurit)
    fltQtdPDi: Double; // Qtd. Padrao Diluido (Salcomix e Glasurit)
    strTipBas: String;
    strQualid: String;
    fltPreVen: Double;
    fltEmbala: Double;
    fltPesEsp: Double;
    fltPreCus: Double;
    fltIcmSai: Double;
    fltOutVal: Double;
    fltImpFed: Double;
    fltDesOpe: Double;
    fltPreMed: Double;
    fltPreUlt: Double;
    fltImpUlt: Double;
    fltPorcen: Double;
    fltComLiq: Double;
    fltPreCu2: Double;
    fltPreSky: Double; // Preço Original Skymix

    strImpDir: string;
    strCodIte: string;

    strPesGra: String;
    strIdePro: String;
    fltCnv_Ml: Double;
    strSystem: String;

//    fltDesCon: Double;
//    fltDesCam: Double;
  public
    property LinhaBase: String                 Read strLinBas Write strLinBas;
    property CodigoBase: String                Read strCodBas Write strCodBas;
    property QuantidadeConcentrado: Double     Read fltQtdCon Write fltQtdCon;
    property QuantidadeDiluido: Double         Read fltQtdDil Write fltQtdDil;
    property QuantidadeDiluido2: Double        Read fltQtdDi2 Write fltQtdDi2;
    property QuantidadePadraoCon: Double       Read fltQtdPCo Write fltQtdPCo;
    property QuantidadePadraoDil: Double       Read fltQtdPDi Write fltQtdPDi;
    property TipoBase: String                  Read strTipBas Write strTipBas;
    property Qualidade: String                 Read strQualid Write strQualid;
    property PrecoVenda: Double                Read fltPreVen Write fltPreVen;
    property Embalagem: Double                 Read fltEmbala Write fltEmbala;
    property PesoEspecifico: Double            Read fltPesEsp Write fltPesEsp;
    property PrecoCusto: Double                Read fltPreCus Write fltPreCus;
    property Porcen: Double                    Read fltPorcen Write fltPorcen;

    property OutrosValores: Double             Read fltOutVal Write fltOutVal;
    property IcmsSaida: Double                 Read fltIcmSai Write fltIcmSai;
    property ImpostosFederais: Double          Read fltImpFed Write fltImpFed;
    property DespesasOperacionais: Double      Read fltDesOpe Write fltDesOpe;
    property PrecoMedio: Double                Read fltPreMed write fltPreMed;

    property UltimoPrecoCompra: Double         read fltPreUlt write fltPreUlt;
    property UltimoPrecoCompraImpostos: Double read fltImpUlt write fltImpUlt;
    property PrecoCompraLiquido: Double        read fltComLiq write fltComLiq;

    property PrecoCustoReal: Double            read fltPreCu2 write fltPreCu2;

    property ImpDir: string                    read strImpDir write strImpDir;
    property CodIte: string                    read strCodIte write strCodIte;

    property PesGra: String                    read strPesGra write strPesGra;
    property IdePro: String                    read strIdePro write strIdePro;
    property Cnv_Ml: Double                    read fltCnv_Ml write fltCnv_Ml;
    property PrecoVendaSky: Double             read fltPreSky write fltPreSky;
    property System: String                    read strSystem write strSystem;
  end;

implementation

end.
