unit untManifestoEletronico;

interface

uses untInterfaces, Contnrs{$IF Defined(VER270) OR Defined(VER280) OR Defined(VER300)}, System.Classes{$IFEND};

Type
   TManifestoMotorista = class(TObject)
     private
       FCpfMotorista: String;
       FNomeMotorista: String;
     public
       constructor Create(strCpfMotorista, strNomeMotorista: String);
       property strCpfMotorista: String read FCpfMotorista;
       property strNomeMotorista: String read FNomeMotorista;
   end;

  TManifestoSegCar = class(TObject)
    private
      FSequen : Integer;
      FResSeg : Integer;
      FResCpf : String;
      FNomSeg : String;
      FSegCnp : String;
      FNumApo : String;
    public
      constructor Create(intSequen: Integer; intResSeg: Integer; strResCpf: String; strNomSeg: String; strSegCnp: String; strNumApo: String);
      property intSequen : Integer read FSequen;
      property intResSeg : Integer read FResSeg;
      property strResCpf : String  read FResCpf;
      property strNomSeg : String  read FNomSeg;
      property strSegCnp : String  read FSegCnp;
      property strNumApo : String  read FNumApo;
  end;

Type
  TManifestoSegCarAverb = class(TObject)
    private
      FSequen : Integer;
      FNumAve : String;
    public
      constructor Create(intSequen: Integer; strNumAve: String);
      property intSequen : Integer read FSequen;
      property strNumAve : String  read FNumAve;
  end;

type
  TManifestoInfAdiContribuinte = class(TObject)
    private
      FInfCom : String;
    public
      constructor Create(strInfCom: String);
      property strInfCom: String read FInfCom;
  end;

Type
  TCTeManifesto = class(TObject)
    private
      FChaveAcesso: String;
      FIbge: String;
      FPesoBruto: Double;
      FTotalCte: Double;
      FUf: String;
      FPercurso: String;
      FAutoIncrem: String;
    public
      constructor Create(strChave: String; strIbge: String; fltPeso, fltTotal: Double;
        strUf, strPercurso, strAutoIncrem: String);

      property strChaveAcesso: String Read FChaveAcesso;
      property strIbge: String Read FIbge;
      property fltPesoBruto: Double Read FPesoBruto;
      property fltTotalCte: Double Read FTotalCte;
      property strUf: String Read FUf;
      property strPercurso: String Read FPercurso;
      property strAutoIncrem: String Read FAutoIncrem;
  end;

Type
  TNFeManifesto = class(TObject)
    private
      FChaveAcesso: String;
      FIbge: String;
      FPesoBruto: Double;
      FTotalNfe: Double;
      FUf: String;
      FPercurso: String;
      FAutoIncrem: String;
    public
      constructor Create(strChave: String; strIbge: String; fltPeso, fltTotal: Double;
        strUf, strPercurso, strAutoIncrem: String);

      property strChaveAcesso: String Read FChaveAcesso;
      property strIbge: String Read FIbge;
      property fltPesoBruto: Double Read FPesoBruto;
      property fltTotalNfe: Double Read FTotalNfe;
      property strUf: String Read FUf;
      property strPercurso: String Read FPercurso;
      property strAutoIncrem: String Read FAutoIncrem;
  end;

Type
  TProprietarioVeiculo = class(TObject)
    private
      FCPF_CNPJ          : String;
      FRNTRC             : String;
      FNomeRazaoSocial   : String;
      FInscricaoEstadual : String;
      FEstado            : String;
      FTipoProprietario : Integer;
    public
      constructor create();
      property strCPF_CNPJ          : String  Read FCPF_CNPJ          Write FCPF_CNPJ;
      property strRNTRC             : String  Read FRNTRC             Write FRNTRC;
      property strNomeRazaoSocial   : String  Read FNomeRazaoSocial   Write FNomeRazaoSocial;
      property strInscricaoEstadual : String  Read FInscricaoEstadual Write FInscricaoEstadual;
      property strEstado            : String  Read FEstado            Write FEstado;
      property intTipoProprietario  : Integer Read FTipoProprietario  Write FTipoProprietario;
  end;

Type
  TProdutoPredominante = class(TObject)
    private
      FTipoDeCarga                         : String;
      FDescricaoProdutoPredominante        : String;
      FCEAN_GTIN                           : String;
      FNCM                                 : String;
      FCEPLocalizacaoCarregamento          : String;
      FLatitudeLocalizacaoCarregamento     : String;
      FLongitudeLocalizacaoCarregamento    : String;
      FCEPLocalizacaoDescarregamento       : String;
      FLatitudeLocalizacaoDescarregamento  : String;
      FLongitudeLocalizacaoDescarregamento : String;
    public
      constructor create();
      property strTipoDeCarga                         : String  Read FTipoDeCarga                         Write FTipoDeCarga;
      property strDescricaoProdutoPredominante        : String  Read FDescricaoProdutoPredominante        Write FDescricaoProdutoPredominante;
      property strCEAN_GTIN                           : String  Read FCEAN_GTIN                           Write FCEAN_GTIN;
      property strNCM                                 : String  Read FNCM                                 Write FNCM;
      property strCEPLocalizacaoCarregamento          : String  Read FCEPLocalizacaoCarregamento          Write FCEPLocalizacaoCarregamento;
      property strLatitudeLocalizacaoCarregamento     : String  Read FLatitudeLocalizacaoCarregamento     Write FLatitudeLocalizacaoCarregamento;
      property strLongitudeLocalizacaoCarregamento    : String  Read FLongitudeLocalizacaoCarregamento    Write FLongitudeLocalizacaoCarregamento;
      property strCEPLocalizacaoDescarregamento       : String  Read FCEPLocalizacaoDescarregamento       Write FCEPLocalizacaoDescarregamento;
      property strLatitudeLocalizacaoDescarregamento  : String  Read FLatitudeLocalizacaoDescarregamento  Write FLatitudeLocalizacaoDescarregamento;
      property strLongitudeLocalizacaoDescarregamento : String  Read FLongitudeLocalizacaoDescarregamento Write FLongitudeLocalizacaoDescarregamento;
  end;

Type
  TEventoPagamentoOperacaoTransporte = class(TObject)
  private
    FNumeroProtocolo   : Integer;
    FQuantidadeViagens : Integer;
    FNumeroViagem      : Integer;
  public
    constructor create();
    property intNumeroProtocolo   : Integer Read FNumeroProtocolo   Write FNumeroProtocolo;
    property intQuantidadeViagens : Integer Read FQuantidadeViagens Write FQuantidadeViagens;
    property intNumeroViagem      : Integer Read FNumeroViagem      Write FNumeroViagem;
  end;

Type
  TInformacoesPagamentoFrete = class(TObject)
  private
    FSeqInfPagFrete  : Integer;
    FNomeResponsavel : String;
    FCPF_CNPJ        : String;
    FIDEstrangeiro   : String;
    FValorTotal      : Real;
    FFormaPagamento  : Integer;
    FNumeroBanco     : String;
    FNumeroAgencia   : String;
    FCNPJPagamento   : String;
    FChavePix        : string;
    FValorAdiantam   : Real;
  public
    constructor create();
    property intSeqInfPagFrete  : Integer Read FSeqInfPagFrete  Write FSeqInfPagFrete;
    property strNomeResponsavel : String  Read FNomeResponsavel Write FNomeResponsavel;
    property strCPF_CNPJ        : String  Read FCPF_CNPJ        Write FCPF_CNPJ;
    property strIDEstrangeiro   : String  Read FIDEstrangeiro   Write FIDEstrangeiro;
    property fltValorTotal      : Real    Read FValorTotal      Write FValorTotal;
    property intFormaPagamento  : Integer Read FFormaPagamento  Write FFormaPagamento;
    property strNumeroBanco     : String  Read FNumeroBanco     Write FNumeroBanco;
    property strNumeroAgencia   : String  Read FNumeroAgencia   Write FNumeroAgencia;
    property strCNPJPagamento   : String  Read FCNPJPagamento   Write FCNPJPagamento;
    property strChavePix        : string  read FChavePix        write FChavePix;
    property fltValorAdiantam   : Real    read FValorAdiantam   write FValorAdiantam;
  end;

Type
  TInformacoesPagamentoFreteComponentes = class(TObject)
  private
    FSeqInfPagFrete      : Integer;
    FSeqInfPagFreteCom   : Integer;
    FTipoComponente      : String;
    FValorComponente     : Real;
    FDescricaoComponente : String;
  public
    constructor create();
    property intSeqInfPagFrete      : Integer Read FSeqInfPagFrete      Write FSeqInfPagFrete;
    property intSeqInfPagFreteCom   : Integer Read FSeqInfPagFreteCom   Write FSeqInfPagFreteCom;
    property strTipoComponente      : String  Read FTipoComponente      Write FTipoComponente;
    property fltValorComponente     : Real    Read FValorComponente     Write FValorComponente;
    property strDescricaoComponente : String  Read FDescricaoComponente Write FDescricaoComponente;
  end;

Type
  TInformacoesPagamentoFretePrazos = class(TObject)
  private
    FSeqInfPagFrete    : Integer;
    FSeqInfPagFretePra : Integer;
    FNumeroParcela     : Integer;
    FDataVencimento    : String;
    FValorParcela      : Real;
  public
    constructor create();
    property intSeqInfPagFrete    : Integer Read FSeqInfPagFrete    Write FSeqInfPagFrete;
    property intSeqInfPagFretePra : Integer Read FSeqInfPagFretePra Write FSeqInfPagFretePra;
    property intNumeroParcela     : Integer Read FNumeroParcela     Write FNumeroParcela;
    property strDataVencimento    : String  Read FDataVencimento    Write FDataVencimento;
    property fltValorParcela      : Real    Read FValorParcela      Write FValorParcela;
  end;

Type
  TInformacoesContratantes = class(TObject)
  private
    FCnpjCpf   : string;
    FRazaoNome : string;
  public
    constructor create(strCnpjCpf, strRazaoNome: string);
    property strCnpjCpf   : string  read FCnpjCpf   write FCnpjCpf;
    property strRazaoNome : string  read FRazaoNome write FRazaoNome;
  end;

Type
  TDadosVeiculo = class(TObject)
  private
    FTaraKg: Integer;
    FTipoRodado: string;
    FTipoCarroceria: string;
  public
    constructor create(intTaraKg: Integer; strTipoRodado, strTipoCarroceria: string);

    property intTaraKg        : Integer read FTaraKg         write FTaraKg        ;
    property strTipoRodado    : string  read FTipoRodado     write FTipoRodado    ;
    property strTipoCarroceria: string  read FTipoCarroceria write FTipoCarroceria;
  end;

Type
  TDadosReboque = class(TObject)
  private
    FPlaca: string;
    FTaraKg: Integer;
    FCapacidadeKG: Integer;
    FTipoCarroceria: string;
  public
    constructor create(strPlaca, strTipoCarroceria: string; intTaraKg, intCapacidadeKG: Integer);

    property strPlaca         : string  read FPlaca          write FPlaca         ;
    property intTaraKg        : Integer read FTaraKg         write FTaraKg        ;
    property intCapacidadeKG  : Integer read FCapacidadeKG   write FCapacidadeKG  ;
    property strTipoCarroceria: string  read FTipoCarroceria write FTipoCarroceria;
  end;

Type
  TManifestoEletronico = class(TInterfacedObject)
    private
      FCarregamentoCidade : String;
      FCarregamentoNomCid : String;
      FCarregamentoEstado : String;
      FCarregamento_IBGE_ : String;

      FDescarregamentoCidade : String;
      FDescarregamentoEstado : String;
      FDescarregamento_IBGE_ : String;
      FIbgeCarregamentoPosterior: String;
      FPrevisaoViagem : String;

      FNumeroManifesto : String;
      FDadosEmitente   : TDadosEmitente;
      FDataEmissao     : TDateTime;
      FPlacaVeiculo    : String;
      FCodEmp          : String;
      FChaveAcesso     : String;
      FCargaPosterior  : String;
      FVersao          : String;
      FSerie           : String;
      FTipoImpressao   : TTipoImpressao;

      FNotas      : TObjectList;
      FMotoristas : TObjectList;

      FProprietarioVeiculo                  : TProprietarioVeiculo;
      FProdutoPredominante                  : TProdutoPredominante;
      FEventoPagamentoOperacaoTransporte    : TEventoPagamentoOperacaoTransporte;
      FInformacoesPagamentoFrete            : TObjectList;
      FInformacoesPagamentoFreteComponentes : TObjectList;
      FInformacoesPagamentoFretePrazos      : TObjectList;

      FSegCarga                    : TObjectList;
      FSegCargaAverbacao           : TObjectList;
      FInfComplementarContribuinte : TObjectList;
      FTipoDocumento               : String;
      FConhecimentos               : TObjectList;
      FInformacoesContratante      : TObjectList;
      FDadosVeiculo                : TDadosVeiculo;
      FDadosReboque1               : TDadosReboque;
      FDadosReboque2               : TDadosReboque;
      FDadosReboque3               : TDadosReboque;

      function GetCnpjEmitente: String;
      function GetIbgeCarregamento: String;
      function GetIbgeCarregamentoPosterior: String;
      function GetModalidade: String;
      function GetNomeMunCarregamento: String;
      function GetPesoBrutoTotal: Double;
      function GetQtdNfe: Integer;
      function GetQtdManifesto: Integer;
      function GetTipoEmitente: String;
      function GetTotalCarga: Double;
      function GetUfCarregamento: String;
      function GetUfDescarregamento: String;
      function GetUfEmitente: String;
      function GetIdReferencia: String;
      function GetNfe(Index: Integer): TNFeManifesto;
      function GetMotorista(Index: Integer): TManifestoMotorista;
      function GetSegCar(Index: Integer): TManifestoSegCar;
      function GetSegCarAverb(Index: Integer): TManifestoSegCarAverb;
      function GetQtdSegCar: Integer;
      function GetQtdSegCarAverb: Integer;
      function GetInfComplContrib(Index: Integer): TManifestoInfAdiContribuinte;
      function GetQtdInfComplContrib: Integer;

      function GetMDFPAG(Index : Integer) : TInformacoesPagamentoFrete;
      function GetMDFCOM(Index : Integer) : TInformacoesPagamentoFreteComponentes;
      function GetMDFPRA(Index : Integer) : TInformacoesPagamentoFretePrazos;

      function GetQtdMDFPAG : Integer;
      function GetQtdMDFCOM : Integer;
      function GetQtdMDFPRA : Integer;

      function MotoristaValido(CpfMotorista, NomeMotorista: String): Boolean;

      function GetQtdCte: Integer;
      function GetCte(Index: Integer): TCTeManifesto;
      function GetContratante(Index: Integer): TInformacoesContratantes;
      function GetQtdInfContr: Integer;

    public
      procedure SetChaveAcesso(strChave: String);

      constructor Create(strNumeroManifesto : String;
                         dadosEmitente      : TDadosEmitente;
                         dtaEmissao         : TDateTime;
                         strCpfMotorista,
                         strNomeMotorista,
                         strPlacaVeiculo,
                         strCodEmp,
                         strCargaPosterior,
                         strVersao                : String;
                         strDescarregamentoCidade : String = '';
                         strDescarregamentoEstado : String = '';
                         strDescarregamento_IBGE_ : String = '';
                         strIbgeCarregamentoPosterior: String = '';
                         tipoImpressao: TTipoImpressao = tiPadrao;
                         strCarregamentoCidade : String = '';
                         strCarregamentoNomCid : String = '';
                         strCarregamentoEstado : String = '';
                         strCarregamento_IBGE_ : String = '';
                         strPrevisaoViagem : String = '');

      destructor Destroy; override;

      procedure pAddMotorista(Motorista: TManifestoMotorista);
      procedure pAddNfe(nfe: TNFeManifesto);
      procedure pAddSeqCarga(SegCar: TManifestoSegCar);
      procedure pAddSeqCargaAverb(SegCarAverb: TManifestoSegCarAverb);
      procedure pAddSeqInfComplContrib(infComplContrib: TManifestoInfAdiContribuinte);

      class function fIdRreferencia(strNumeroManifesto, strCodEmp: String): String;

      procedure pAddInfPagFretePag(InformacoesPagamentoFrete            : TInformacoesPagamentoFrete);
      procedure pAddInfPagFreteCom(InformacoesPagamentoFreteComponentes : TInformacoesPagamentoFreteComponentes);
      procedure pAddInfPagFretePra(InformacoesPagamentoFretePrazos      : TInformacoesPagamentoFretePrazos);
      procedure pAddCte(cte: TCTeManifesto);
      procedure pAddInfContratante(InformacoesContratante: TInformacoesContratantes);

      property ProprietarioVeiculo               : TProprietarioVeiculo               Read FProprietarioVeiculo               Write FProprietarioVeiculo;
      property ProdutoPredominante               : TProdutoPredominante               Read FProdutoPredominante               Write FProdutoPredominante;
      property EventoPagamentoOperacaoTransporte : TEventoPagamentoOperacaoTransporte Read FEventoPagamentoOperacaoTransporte Write FEventoPagamentoOperacaoTransporte;

      property InformacoesPagamentoFrete            : TObjectList Read FInformacoesPagamentoFrete;
      property InformacoesPagamentoFreteComponentes : TObjectList Read FInformacoesPagamentoFreteComponentes;
      property InformacoesPagamentoFretePrazos      : TObjectList Read FInformacoesPagamentoFretePrazos;

      property strIdReferencia: String Read GetIdReferencia;
      property strCodigoEmpresa: String Read FCodEmp;
      property strCnpjEmitente: String Read GetCnpjEmitente;
      property strUfEmitente: String Read GetUfEmitente;
      property strTipoEmitente: String Read GetTipoEmitente;
      property strSerie: string Read FSerie Write FSerie;
      property strNumeroManifesto: String Read FNumeroManifesto;
      property strModalidade: String Read GetModalidade;
      property dtaDataEmissao: TDateTime Read FDataEmissao;
      property strUfCarregamento: String Read GetUfCarregamento;
      property strUfDescarregamento: String Read GetUfDescarregamento;
      property strIbgeCarregamento: String Read GetIbgeCarregamento;
      property strIbgeCarregamentoPosterior: String Read GetIbgeCarregamentoPosterior;
      property strNomeMunicipioCarregamento: String Read GetNomeMunCarregamento;
      property strPlacaVeiculo: String Read FPlacaVeiculo;

      property intQtdeNfe: Integer Read GetQtdNfe;
      property intQtdeManifesto: Integer Read GetQtdManifesto;
      property fltTotalCarga: Double Read GetTotalCarga;
      property fltPesoBrutoTotal: Double Read GetPesoBrutoTotal;

      property strChaveAcesso: String Read FChaveAcesso;

      property strVersao: String Read FVersao;
      property strCargaPosterior: String Read FCargaPosterior;

      property NFe[Index: Integer]: TNFeManifesto Read GetNfe;
      property Motorista[Index: Integer]: TManifestoMotorista Read GetMotorista;

      property intQtdeSegCar: Integer Read GetQtdSegCar;
      property intQtdeSegCarAverb: Integer Read GetQtdSegCarAverb;
      property intQtdeInfComplContrib: Integer Read GetQtdInfComplContrib;
      property SeguroCarga[Index: Integer]: TManifestoSegCar Read GetSegCar;
      property SeguroCargaAverbacao[Index: Integer]: TManifestoSegCarAverb Read GetSegCarAverb;
      property InfComplementarContribuinte[Index: Integer]: TManifestoInfAdiContribuinte Read GetInfComplContrib;

      property intQtdMDFPAG : Integer Read GetQtdMDFPAG;
      property intQtdMDFCOM : Integer Read GetQtdMDFCOM;
      property intQtdMDFPRA : Integer Read GetQtdMDFPRA;

      property MDFPAG[Index : Integer] : TInformacoesPagamentoFrete            Read GetMDFPAG;
      property MDFCOM[Index : Integer] : TInformacoesPagamentoFreteComponentes Read GetMDFCOM;
      property MDFPRA[Index : Integer] : TInformacoesPagamentoFretePrazos      Read GetMDFPRA;

      property InformacoesContratante: TObjectList read FInformacoesContratante;
      property strTipoDocumento: string Read FTipoDocumento Write FTipoDocumento;
      property intQtdeCte: Integer Read GetQtdCte;
      property CTe[Index: Integer]: TCTeManifesto Read GetCte;
      property intQtdInfContr: Integer read GetQtdInfContr;
      property Contratante[Index: Integer]: TInformacoesContratantes read GetContratante;
      property DadosVeiculo: TDadosVeiculo read FDadosVeiculo write FDadosVeiculo;
      property DadosReboque1: TDadosReboque read FDadosReboque1 write FDadosReboque1;
      property DadosReboque2: TDadosReboque read FDadosReboque2 write FDadosReboque2;
      property DadosReboque3: TDadosReboque read FDadosReboque3 write FDadosReboque3;

      property strCarregamentoCidade : String Read FCarregamentoCidade;
      property strCarregamentoNomCid : String Read FCarregamentoNomCid;
      property strCarregamentoEstado : String Read FCarregamentoEstado;
      property strCarregamento_IBGE_ : String Read FCarregamento_IBGE_;

      property strDescarregamentoCidade : String Read FDescarregamentoCidade;
      property strDescarregamentoEstado : String Read FDescarregamentoEstado;
      property strDescarregamento_IBGE_ : String Read FDescarregamento_IBGE_;

      property tipoImpressao: TTipoImpressao Read FTipoImpressao;
      property strPrevisaoViagem : String Read FPrevisaoViagem;

  end;

implementation

{ TNFeManifesto }

constructor TNFeManifesto.Create(strChave, strIbge: String; fltPeso,
  fltTotal: Double; strUf, strPercurso, strAutoIncrem: String);
begin
  Self.FChaveAcesso := strChave;
  Self.FIbge := strIbge;
  Self.FPesoBruto := fltPeso;
  Self.FTotalNfe := fltTotal;
  Self.FUf := strUf;
  Self.FPercurso := strPercurso;
  Self.FAutoIncrem := strAutoIncrem;
end;

{ TManifestoEletronico }

constructor TManifestoEletronico.Create(strNumeroManifesto : String;
                                        dadosEmitente      : TDadosEmitente;
                                        dtaEmissao         : TDateTime;
                                        strCpfMotorista,
                                        strNomeMotorista,
                                        strPlacaVeiculo,
                                        strCodEmp,
                                        strCargaPosterior,
                                        strVersao                : String;
                                        strDescarregamentoCidade : String = '';
                                        strDescarregamentoEstado : String = '';
                                        strDescarregamento_IBGE_ : String = '';
                                        strIbgeCarregamentoPosterior: String = '';
                                        tipoImpressao: TTipoImpressao = tiPadrao;
                                        strCarregamentoCidade : String = '';
                                        strCarregamentoNomCid : String = '';
                                        strCarregamentoEstado : String = '';
                                        strCarregamento_IBGE_ : String = '';
                                        strPrevisaoViagem : String = '');
begin

  inherited Create;

  Self.FCarregamentoCidade := strCarregamentoCidade;
  Self.FCarregamentoNomCid := strCarregamentoNomCid;
  Self.FCarregamentoEstado := strCarregamentoEstado;
  Self.FCarregamento_IBGE_ := strCarregamento_IBGE_;

  Self.FDescarregamentoCidade := strDescarregamentoCidade;
  Self.FDescarregamentoEstado := strDescarregamentoEstado;
  Self.FDescarregamento_IBGE_ := strDescarregamento_IBGE_;
  Self.FIbgeCarregamentoPosterior := strIbgeCarregamentoPosterior;

  Self.FNumeroManifesto := strNumeroManifesto;
  Self.FDadosEmitente := dadosEmitente;
  Self.FDataEmissao := dtaEmissao;
  Self.FPlacaVeiculo := strPlacaVeiculo;
  Self.FCodEmp := strCodEmp;
  Self.FCargaPosterior := strCargaPosterior;
  Self.FVersao := strVersao;

  Self.FNotas := TObjectList.Create;
  Self.FMotoristas := TObjectList.Create;
  Self.FSegCarga := TObjectList.Create;
  Self.FSegCargaAverbacao := TObjectList.Create;
  Self.FInfComplementarContribuinte := TObjectList.Create;

  Self.FProprietarioVeiculo                  := TProprietarioVeiculo.Create;
  Self.FProdutoPredominante                  := TProdutoPredominante.Create;
  Self.FEventoPagamentoOperacaoTransporte    := TEventoPagamentoOperacaoTransporte.Create;
  Self.FInformacoesPagamentoFrete            := TObjectList.Create;
  Self.FInformacoesPagamentoFreteComponentes := TObjectList.Create;
  Self.FInformacoesPagamentoFretePrazos      := TObjectList.Create;

  if MotoristaValido(strCpfMotorista, strNomeMotorista) then
    Self.pAddMotorista(TManifestoMotorista.Create(strCpfMotorista, strNomeMotorista));

  Self.FConhecimentos          := TObjectList.Create;
  Self.FInformacoesContratante := TObjectList.Create;

  Self.FTipoImpressao := tipoImpressao;
  Self.FPrevisaoViagem := strPrevisaoViagem;

end;

destructor TManifestoEletronico.Destroy;
begin
  FNotas.Free;
  FMotoristas.Free;
  FSegCarga.Free;
  FSegCargaAverbacao.Free;
  FInfComplementarContribuinte.Free;

  FProprietarioVeiculo.Free;
  FProdutoPredominante.Free;
  FEventoPagamentoOperacaoTransporte.Free;
  FInformacoesPagamentoFrete.Free;
  FInformacoesPagamentoFreteComponentes.Free;
  FInformacoesPagamentoFretePrazos.Free;
  FConhecimentos.Free;
  FInformacoesContratante.Free;

  inherited;
end;

class function TManifestoEletronico.fIdRreferencia(strNumeroManifesto,
  strCodEmp: String): String;
begin
  Result := strNumeroManifesto + strCodEmp;
end;

function TManifestoEletronico.GetSegCar(Index: Integer): TManifestoSegCar;
begin
  Result := TManifestoSegCar(FSegCarga[Index]);
end;

function TManifestoEletronico.GetSegCarAverb(
  Index: Integer): TManifestoSegCarAverb;
begin
  Result := TManifestoSegCarAverb(FSegCargaAverbacao[Index]);
end;

function TManifestoEletronico.GetCnpjEmitente: String;
begin
  Result := FDadosEmitente.strCnpj;
end;

function TManifestoEletronico.GetContratante(Index: Integer): TInformacoesContratantes;
begin
  Result := TInformacoesContratantes(FInformacoesContratante[Index]);
end;

function TManifestoEletronico.GetCte(Index: Integer): TCTeManifesto;
begin
  Result := TCTeManifesto(FConhecimentos[Index]);
end;

function TManifestoEletronico.GetIbgeCarregamento: String;
begin
  Result := FDadosEmitente.strCodIbge;
end;

function TManifestoEletronico.GetIbgeCarregamentoPosterior: String;
begin
  Result := FDadosEmitente.strCodIbge;

  If not (FIbgeCarregamentoPosterior = '') Then
    Result := FIbgeCarregamentoPosterior;
end;

function TManifestoEletronico.GetIdReferencia: String;
begin
  Result := TManifestoEletronico.fIdRreferencia(strNumeroManifesto, strCodigoEmpresa);
end;

function TManifestoEletronico.GetInfComplContrib(
  Index: Integer): TManifestoInfAdiContribuinte;
begin
  Result := TManifestoInfAdiContribuinte(FInfComplementarContribuinte[Index]);
end;

function TManifestoEletronico.GetMDFCOM(Index: Integer): TInformacoesPagamentoFreteComponentes;
begin
  Result := TInformacoesPagamentoFreteComponentes(FInformacoesPagamentoFreteComponentes[Index]);
end;

function TManifestoEletronico.GetMDFPAG(Index: Integer): TInformacoesPagamentoFrete;
begin
  Result := TInformacoesPagamentoFrete(FInformacoesPagamentoFrete[Index]);
end;

function TManifestoEletronico.GetMDFPRA(Index: Integer): TInformacoesPagamentoFretePrazos;
begin
  Result := TInformacoesPagamentoFretePrazos(FInformacoesPagamentoFretePrazos[Index]);
end;

function TManifestoEletronico.GetModalidade: String;
begin
  Result := '1';
end;

function TManifestoEletronico.GetMotorista(Index: Integer): TManifestoMotorista;
begin
  Result := TManifestoMotorista(FMotoristas[Index]);
end;

function TManifestoEletronico.GetNfe(Index: Integer): TNFeManifesto;
begin
  Result := TNFeManifesto(FNotas[Index]);
end;

function TManifestoEletronico.GetNomeMunCarregamento: String;
begin
  Result := FDadosEmitente.strNomeCidade;
end;

function TManifestoEletronico.GetPesoBrutoTotal: Double;
  Var
    intContador: Integer;
    intQtdeCte: Integer;
    intQtdeNfe: Integer;
begin
  Result := 0;
  intQtdeCte := FConhecimentos.Count;
  intQtdeNfe := FNotas.Count;

  if (intQtdeCte > 0) then
  begin
    For intContador := 0 To intQtdeCte -1 Do
    Begin
      Result := Result + TCTeManifesto(FConhecimentos[intContador]).fltPesoBruto;
    End;
  end
  else
  begin
    For intContador := 0 To intQtdeNfe -1 Do
    Begin
      Result := Result + TNFeManifesto(FNotas[intContador]).fltPesoBruto;
    End;
  end;
end;

function TManifestoEletronico.GetQtdCte: Integer;
begin
  Result := FConhecimentos.Count;
end;

function TManifestoEletronico.GetQtdInfComplContrib: Integer;
begin
  Result := FInfComplementarContribuinte.Count;
end;

function TManifestoEletronico.GetQtdInfContr: Integer;
begin
  Result := FInformacoesContratante.Count;
end;

function TManifestoEletronico.GetQtdManifesto: Integer;
begin
  Result := FMotoristas.Count;
end;

function TManifestoEletronico.GetQtdMDFCOM: Integer;
begin
  Result := FInformacoesPagamentoFreteComponentes.Count;
end;

function TManifestoEletronico.GetQtdMDFPAG: Integer;
begin
  Result := FInformacoesPagamentoFrete.Count;
end;

function TManifestoEletronico.GetQtdMDFPRA: Integer;
begin
  Result := FInformacoesPagamentoFretePrazos.Count;
end;

function TManifestoEletronico.GetQtdNfe: Integer;
begin
  Result := FNotas.Count;
end;

function TManifestoEletronico.GetQtdSegCar: Integer;
begin
  Result := FSegCarga.Count;
end;

function TManifestoEletronico.GetQtdSegCarAverb: Integer;
begin
  Result := FSegCargaAverbacao.Count;
end;

function TManifestoEletronico.GetTipoEmitente: String;
begin
  if (Self.FTipoDocumento = 'NFe') then
    Result := '2'
  else
    Result := '1';
end;

function TManifestoEletronico.GetTotalCarga: Double;
  Var
    intContador: Integer;
    intQtdeCte: Integer;
    intQtdeNfe: Integer;
begin
  Result := 0;
  intQtdeCte := FConhecimentos.Count;
  intQtdeNfe := FNotas.Count;

  if (intQtdeCte > 0) then
  begin
    For intContador := 0 To intQtdeCte -1 Do
    Begin
      Result := Result + TCTeManifesto(FConhecimentos[intContador]).fltTotalCte;
    End;
  end
  else
  begin
    For intContador := 0 To intQtdeNfe -1 Do
    Begin
      Result := Result + TNFeManifesto(FNotas[intContador]).fltTotalNfe;
    End;
  end;
end;

function TManifestoEletronico.GetUfCarregamento: String;
begin
  Result := FDadosEmitente.strEstado;
end;

function TManifestoEletronico.GetUfDescarregamento: String;
begin
  if (FNotas.Count > 0) then
    Result := TNFeManifesto(FNotas[0]).strUf
  else
    Result := TCTeManifesto(FConhecimentos[0]).strUf;
end;

function TManifestoEletronico.GetUfEmitente: String;
begin
  Result := FDadosEmitente.strEstado;
end;

function TManifestoEletronico.MotoristaValido(CpfMotorista,
  NomeMotorista: String): Boolean;
begin
  Result := True;
  if CpfMotorista = '' then
  begin
    Result := False;
    Exit;
  end;

  if NomeMotorista = '' then
  begin
    Result := False;
    Exit;
  end;
end;

procedure TManifestoEletronico.pAddInfPagFretePag(InformacoesPagamentoFrete: TInformacoesPagamentoFrete);
begin
  If (InformacoesPagamentoFrete <> Nil) Then
    FInformacoesPagamentoFrete.Add(InformacoesPagamentoFrete);
end;

procedure TManifestoEletronico.pAddCte(cte: TCTeManifesto);
begin
  If cte <> Nil Then
    FConhecimentos.Add(cte);
end;

procedure TManifestoEletronico.pAddInfContratante(InformacoesContratante: TInformacoesContratantes);
begin
  If (InformacoesContratante <> Nil) Then
    FInformacoesContratante.Add(InformacoesContratante);
end;

procedure TManifestoEletronico.pAddInfPagFreteCom(InformacoesPagamentoFreteComponentes: TInformacoesPagamentoFreteComponentes);
begin
  If (InformacoesPagamentoFreteComponentes <> Nil) Then
    FInformacoesPagamentoFreteComponentes.Add(InformacoesPagamentoFreteComponentes);
end;

procedure TManifestoEletronico.pAddInfPagFretePra(InformacoesPagamentoFretePrazos: TInformacoesPagamentoFretePrazos);
begin
  If (InformacoesPagamentoFretePrazos <> Nil) Then
    FInformacoesPagamentoFretePrazos.Add(InformacoesPagamentoFretePrazos);
end;

procedure TManifestoEletronico.pAddMotorista(Motorista: TManifestoMotorista);
var
  I: Integer;
  MotoristaIgual: Boolean;
begin
  if Motorista = nil then
    Exit;

  if intQtdeManifesto = 10 then
    exit;

  MotoristaIgual := False;
  for I := 0 to Pred(intQtdeManifesto) do
  begin
    if ((Self.Motorista[I].strCpfMotorista = Motorista.strCpfMotorista) and
        (Self.Motorista[I].strNomeMotorista = Motorista.strNomeMotorista)) then
    begin
      MotoristaIgual := True;
      Break;
    end;
  end;

  if not MotoristaIgual then
    FMotoristas.Add(Motorista);
end;

procedure TManifestoEletronico.pAddNfe(nfe: TNFeManifesto);
begin
  If nfe <> Nil Then
    FNotas.Add(nfe);
end;

procedure TManifestoEletronico.pAddSeqCarga(SegCar: TManifestoSegCar);
begin
  If SegCar <> Nil Then
    FSegCarga.Add(SegCar);
end;

procedure TManifestoEletronico.pAddSeqCargaAverb(SegCarAverb: TManifestoSegCarAverb);
begin
  If SegCarAverb <> Nil Then
    FSegCargaAverbacao.Add(SegCarAverb);
end;

procedure TManifestoEletronico.pAddSeqInfComplContrib(
  infComplContrib: TManifestoInfAdiContribuinte);
begin
 If infComplContrib <> Nil Then
   FInfComplementarContribuinte.Add(infComplContrib);
end;

procedure TManifestoEletronico.SetChaveAcesso(strChave: String);
begin
  Self.FChaveAcesso := strChave;
end;

{ TManifestoSegCar }

constructor TManifestoSegCar.Create(intSequen, intResSeg: Integer; strResCpf,
  strNomSeg, strSegCnp, strNumApo: String);
begin
  Self.FSequen := intSequen;
  Self.FResSeg := intResSeg;
  Self.FResCpf := strResCpf;
  Self.FNomSeg := strNomSeg;
  Self.FSegCnp := strSegCnp;
  Self.FNumApo := strNumApo;
end;

{ TManifestoSegCarAverb }

constructor TManifestoSegCarAverb.Create(intSequen: Integer; strNumAve: String);
begin
  Self.FSequen := intSequen;
  Self.FNumAve := strNumAve;
end;

{ TManifestoInfAdiContribuinte }

constructor TManifestoInfAdiContribuinte.Create(strInfCom: String);
begin
  Self.FInfCom := strInfCom;
end;

{ TProdutoPredominante }

constructor TProdutoPredominante.create;
begin
  inherited Create;
  Self.FTipoDeCarga                         := '';
  Self.FDescricaoProdutoPredominante        := '';
  Self.FCEAN_GTIN                           := '';
  Self.FNCM                                 := '';
  Self.FCEPLocalizacaoCarregamento          := '';
  Self.FLatitudeLocalizacaoCarregamento     := '';
  Self.FLongitudeLocalizacaoCarregamento    := '';
  Self.FCEPLocalizacaoDescarregamento       := '';
  Self.FLatitudeLocalizacaoDescarregamento  := '';
  Self.FLongitudeLocalizacaoDescarregamento := '';
end;

{ TInformacoesPagamentoFrete }

constructor TInformacoesPagamentoFrete.create;
begin
  inherited Create;
  Self.FSeqInfPagFrete  := -1;
  Self.FNomeResponsavel := '';
  Self.FCPF_CNPJ        := '';
  Self.FIDEstrangeiro   := '';
  Self.FValorTotal      := -1;
  Self.FFormaPagamento  := -1;
  Self.FNumeroBanco     := '';
  Self.FNumeroAgencia   := '';
  Self.FCNPJPagamento   := '';
  Self.FChavePix        := '';
  Self.FValorAdiantam   := 0;
end;

{ TInformacoesPagamentoFreteComponentes }

constructor TInformacoesPagamentoFreteComponentes.Create;
begin
  inherited Create;
  Self.FSeqInfPagFrete      := -1;
  Self.FSeqInfPagFreteCom   := -1;
  Self.FTipoComponente      := '';
  Self.FValorComponente     := -1;
  Self.FDescricaoComponente := '';
end;

{ TInformacoesPagamentoFretePrazos }

constructor TInformacoesPagamentoFretePrazos.create;
begin
  inherited Create;
  Self.FSeqInfPagFrete    := -1;
  Self.FSeqInfPagFretePra := -1;
  Self.FNumeroParcela     := -1;
  Self.FDataVencimento    := '';
  Self.FValorParcela      := -1;
end;

{ TEventoPagamentoOperacaoTransporte }

constructor TEventoPagamentoOperacaoTransporte.create;
begin
  inherited Create;
  Self.FNumeroProtocolo   := 0;
  Self.FQuantidadeViagens := 0;
  Self.FNumeroViagem      := 0;
end;

{ TProprietarioVeiculo }

constructor TProprietarioVeiculo.create;
begin
  inherited Create;
  Self.FCPF_CNPJ          := '';
  Self.FRNTRC             := '';
  Self.FNomeRazaoSocial   := '';
  Self.FInscricaoEstadual := '';
  Self.FEstado            := '';
  Self.FTipoProprietario  := -1;
end;

{ TManifestoMotorista }

constructor TManifestoMotorista.Create(strCpfMotorista,
  strNomeMotorista: String);
begin
  FCpfMotorista := strCpfMotorista;
  FNomeMotorista := strNomeMotorista;
end;

{ TCTeManifesto }

constructor TCTeManifesto.Create(strChave, strIbge: String; fltPeso,
  fltTotal: Double; strUf, strPercurso, strAutoIncrem: String);
begin
  Self.FChaveAcesso := strChave;
  Self.FIbge := strIbge;
  Self.FPesoBruto := fltPeso;
  Self.FTotalCte := fltTotal;
  Self.FUf := strUf;
  Self.FPercurso := strPercurso;
  Self.FAutoIncrem := strAutoIncrem;
end;

{ TInformacoesContratantes }

constructor TInformacoesContratantes.create(strCnpjCpf, strRazaoNome: string);
begin
  inherited Create;
  Self.FCnpjCpf   := strCnpjCpf;
  Self.FRazaoNome := strRazaoNome;
end;

{ TDadosVeiculo }

constructor TDadosVeiculo.create(intTaraKg: Integer; strTipoRodado, strTipoCarroceria: string);
begin
  inherited Create;
  Self.FTaraKg         := intTaraKg;
  Self.FTipoRodado     := strTipoRodado;
  Self.FTipoCarroceria := strTipoCarroceria;
end;

{ TDadosReboque }

constructor TDadosReboque.create(strPlaca, strTipoCarroceria: string; intTaraKg, intCapacidadeKG: Integer);
begin
  inherited Create;
  Self.FPlaca          := strPlaca;
  Self.FTaraKg         := intTaraKg;
  Self.FCapacidadeKG   := intCapacidadeKG;
  Self.FTipoCarroceria := strTipoCarroceria;
end;

end.
