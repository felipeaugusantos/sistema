unit untTItemNotaFiscal;

interface

uses untTParticipante, untTCadIte;

Type
  TItemNotaFiscalSintetizada = class(TObject)
    private
      FNumeroInicial: String;
      FNumeroFinal: String;
      FHistorico: String;
      FCstIcms: String;
      FCfop: String;
      FNumeroSerie: String;
      FDtaEnt: TDateTime;
      FValorContabil: Double;
      FBaseIcms: Double;
      FAliquotaIcms: Double;
      FValorIcms: Double;
      FBaseIpi: Double;
      FAliquotaIpi: Double;
      FValorIpi: Double;
      FIsentas: Double;
      FOutras: Double;
    public
      property strNumeroInicial: String read FNumeroInicial write FNumeroInicial;
      property strNumeroFinal: String read FNumeroFinal write FNumeroFinal;
      property strHistorico: String read FHistorico write FHistorico;
      property strCstIcms: String read FCstIcms write FCstIcms;
      property strCfop: String read FCfop write FCfop;
      property strNumeroSerie: String read FNumeroSerie write FNumeroSerie;
      property dtaDtaEnt: TDateTime read FDtaEnt write FDtaEnt;
      property fltValorContabil: Double read FValorContabil write FValorContabil;
      property fltBaseIcms: Double read FBaseIcms write FBaseIcms;
      property fltAliquotaIcms: Double read FAliquotaIcms write FAliquotaIcms;
      property fltValorIcms: Double read FValorIcms write FValorIcms;
      property fltBaseIpi: Double read FBaseIpi write FBaseIpi;
      property fltAliquotaIpi: Double read FAliquotaIpi write FAliquotaIpi;
      property fltValorIpi: Double read FValorIpi write FValorIpi;
      property fltIsentas: Double read FIsentas write FIsentas;
      property fltOutras: Double read FOutras write FOutras;
  end;

Type
  TItemNotaFiscal = class(TObject)
    private
      FAutoIncrem: string;
      FCodIte: String;
      FModelo: string;
      FContribuinte: boolean;
      FParticipante: TParticipante;
      FSerie: string;
      FNumDoc: string;
      FDesIte: String;
 	    FUnidade: String;
      FDtaEnt: TDateTime;
      FChaveAcesso: string;
      FCfop: String;
      FEstado: String;
      FCondicaoPagamento: String;
      FValorContabil: Double;
      FValBru: Double;
      FValFre: Double;
      FQuantidade: Double;
      FValorUnitario: Double;
      FValorIpi: Double;
      FDesconto: Double;
      FDesAce: Double;
      FCstIcm: String;
      FBasIcm: Double;
      FAlqIcm: Double;
      FValIcm: Double;
      FCstIpi: String;
      FBasIpi: Double;
      FBaseIpiNaoCreditado: Double;
      FAlqIpi: Double;
      FValIpi: Double;
      FValorIpiNaoCreditado: Double;
      FBasRet: Double;
      FAlqRet: Double;
      FValRet: Double;
      FBaseRetidoNaoCreditado: Double;
      FValorRetidoNaoCreditado: Double;
      FValorRetidoNaoCreditadoUnitario: Double;
      FOutIcm: Double;
      FCstPis: String;
      FBasPis: Double;
      FAlqPis: Double;
      FValPis: Double;
      FCstCof: String;
      FBasCof: Double;
      FAlqCof: Double;
      FValCof: Double;
      FIsentas: double;
      FReducaoBaseIcms: string;
      FBaseCalculoDestino: double;
      FAlqFcpDestino: double;
      FAlqIcmsDestino: double;
      FAqlIcmsInterEstadual: double;
      FPercentualPartilhaIcms: double;
      FValorFcpSt: double;
      FValorFcpDestino: double;
      FValorIcmsDestino: double;
      FValorIcmsOrigem: double;
      FNaturezaReceitaPis: string;
      FNaturezaReceitaCof: string;
      FDocDev: string;
      FEspDev: string;
      FEmpDev: string;
      FItem: TItem;
      FQuantidadeUtilizada: double; //variavel criada para geração de informações da CAT, com a finalidade de armazenar o valor utilizado da compra, seja total ou parcial
      FPerfilParticipante: string;
      FValorEfetivo: double;
      FBaseEfetivo: double;
      FAliqEfetivo: double;
      FTipFc: string;

      FVdProduto: string;
      FVdQuantidade: Double;
      FVdChaveAcesso: string;
      FVdCodIte: string;
      FVdModelo: string;
      FVdNumDoc: string;
      FVdSerie: string;
      FVdDtaEnt: string;
      FVdTipFc: string;
      FVdCfop: string;
      FVdBaseEfetivo: Double;
      FCpBaseEfetivo: Double;
      FVdBaseStCompr: Double;
      FVdAliqEfetivo: Double;
      FVdValorEfetivo: Double;
      FCpValorEfetivo: Double;
      FAtributosSemantica: string;

    public
      constructor Create;
      destructor Destroy; override;

      property strAutoIncrem: string read FAutoIncrem write FAutoIncrem;
      property strCodIte: String read FCodIte write FCodIte;
      property strModelo: string read FModelo write FModelo;
      property participante: TParticipante read FParticipante write FParticipante;
      property strNumDoc: string read FNumDoc write FNumDoc;
      property strSerie: string read FSerie write FSerie;
      property strDesIte: String read FDesIte write FDesIte;
      property strUnidade: String read FUnidade write FUnidade;
      property strCfop: String read FCfop write FCfop;
      property dtaDtaEnt: TDateTime read FDtaEnt write FDtaEnt;
      property strChaveAcesso: string read FChaveAcesso write FChaveAcesso;
      property strCondicaoPagamento: String read FCondicaoPagamento write FCondicaoPagamento;
      property strEstado: String read FEstado write FEstado;
      property fltValorContabil: Double read FValorContabil write FValorContabil;
      property fltValBru: Double read FValBru write FValBru;
      property fltValFre: Double read FValFre write FValFre;
      property fltQuantidade: Double read FQuantidade write FQuantidade;
      property fltValorUnitario: Double read FValorUnitario write FValorUnitario;
      property fltValorIpi: Double read FValorIpi write FValorIpi;
      property fltDesconto: Double read FDesconto write FDesconto;
      property fltDesAce: Double read FDesAce write FDesAce;
      property fltOutIcm: Double read FOutIcm write FOutIcm;
      property strCstIcm: String read FCstIcm write FCstIcm;
      property fltBasIcm: Double read FBasIcm write FBasIcm;
      property fltAlqIcm: Double read FAlqIcm write FAlqIcm;
      property fltValIcm: Double read FValIcm write FValIcm;
      property strCstIpi: String read FCstIpi write FCstIpi;
      property fltBasIpi: Double read FBasIpi write FBasIpi;
      property fltValorIpiNaoCreditado: Double read FValorIpiNaoCreditado write FValorIpiNaoCreditado;
      property fltAlqIpi: Double read FAlqIpi write FAlqIpi;
      property fltValIpi: Double read FValIpi write FValIpi;
      property fltBaseIpiNaoCreditado: Double read FBaseIpiNaoCreditado write FBaseIpiNaoCreditado;
      property fltBasRet: Double read FBasRet write FBasRet;
      property fltAlqRet: Double read FAlqRet write FAlqRet;
      property fltBaseRetidoNaoCreditado: Double read FBaseRetidoNaoCreditado write FBaseRetidoNaoCreditado;
      property fltValRet: Double read FValRet write FValRet;
      property fltValorRetidoNaoCreditado: Double read FValorRetidoNaoCreditado write FValorRetidoNaoCreditado;
      property fltValorRetidoNaoCreditadoUnitario: Double read FValorRetidoNaoCreditadoUnitario write FValorRetidoNaoCreditadoUnitario;
      property strCstPis: String read FCstPis write FCstPis;
      property fltBasPis: Double read FBasPis write FBasPis;
      property fltAlqPis: Double read FAlqPis write FAlqPis;
      property fltValPis: Double read FValPis write FValPis;
      property strCstCof: String read FCstCof write FCstCof;
      property fltBasCof: Double read FBasCof write FBasCof;
      property fltAlqCof: Double read FAlqCof write FAlqCof;
      property fltValCof: Double read FValCof write FValCof;
      property fltIsentas: double read FIsentas write FIsentas;
      property strReducaoBaseIcms: string read FReducaoBaseIcms write FReducaoBaseIcms;
      property fltBaseCalculoDestino: double read FBaseCalculoDestino write FBaseCalculoDestino;
      property fltAlqFcpDestino: double read FAlqFcpDestino write FAlqFcpDestino;
      property fltAlqIcmsDestino: double read FAlqIcmsDestino write FAlqIcmsDestino;
      property fltAqlIcmsInterEstadual: double read FAqlIcmsInterEstadual write FAqlIcmsInterEstadual;
      property fltPercentualPartilhaIcms: double read FPercentualPartilhaIcms write FPercentualPartilhaIcms;
      property fltValorFcpDestino: double read FValorFcpDestino write FValorFcpDestino;
      property fltValorFcpSt: double read FValorFcpSt write FValorFcpSt;
      property fltValorIcmsDestino: double read FValorIcmsDestino write FValorIcmsDestino;
      property fltValorIcmsOrigem: double read FValorIcmsOrigem write FValorIcmsOrigem;
      property strDocDev: string read FDocDev write FDocDev;
      property strEspDev: string read FEspDev write FEspDev;
      property strEmpDev: string read FEmpDev write FEmpDev;
      property item: TItem read FItem write FItem;
      property strNaturezaReceitaPis: string read FNaturezaReceitaPis write FNaturezaReceitaPis;
      property strNaturezaReceitaCof: string read FNaturezaReceitaCof write FNaturezaReceitaCof;
      property fltQuantidadeUtilizada: double read FQuantidadeUtilizada write FQuantidadeUtilizada;
      property strPerfilParticipante: string read FPerfilParticipante write FPerfilParticipante;
      property blnContribuinte: boolean read FContribuinte write FContribuinte;
      property fltValorEfetivo: double read FValorEfetivo write FValorEfetivo;
      property fltBaseEfetivo: double read FBaseEfetivo write FBaseEfetivo;
      property fltAliqEfetivo: double read FAliqEfetivo write FAliqEfetivo;
      property strTipFc: string read FTipFc write FTipFc;

      property fltVdProduto: string read FVdProduto write FVdProduto;
      property fltVdQuantidade: double read FVdQuantidade write FVdQuantidade;
      property strVdChaveAcesso: string read FVdChaveAcesso write FVdChaveAcesso;
      property strVdCodIte: string read FVdCodIte write FVdCodIte;
      property strVdModelo: string read FVdModelo write FVdModelo;
      property strVdNumDoc: string read FVdNumDoc write FVdNumDoc;
      property strVdSerie: string read FVdSerie write FVdSerie;
      property dtaVdDtaEnt: string read FVdDtaEnt write FVdDtaEnt;
      property strVdTipFc: string read FVdTipFc write FVdTipFc;
      property strVdCfop: string read FVdCfop write FVdCfop;
      property fltVdBaseEfetivo: Double read FVdBaseEfetivo write FVdBaseEfetivo;
      property fltCpBaseEfetivo: Double read FCpBaseEfetivo write FCpBaseEfetivo;
      property fltVdBaseStCompr: Double read FVdBaseStCompr write FVdBaseStCompr;
      property fltVdAliqEfetivo: Double read FVdAliqEfetivo write FVdAliqEfetivo;
      property fltVdValorEfetivo: Double read FVdValorEfetivo write FVdValorEfetivo;
      property fltCpValorEfetivo: Double read FCpValorEfetivo write FCpValorEfetivo;
      property strAtributosSemantica: string read FAtributosSemantica write FAtributosSemantica;

  end;

implementation

{ TItemNotaFiscal }

constructor TItemNotaFiscal.Create;
begin
  inherited;

  FParticipante := TParticipante.Create;
  FItem := TItem.Create;
end;

destructor TItemNotaFiscal.Destroy;
begin
  FParticipante.Free;
  FItem.Free;

  inherited;
end;

end.
