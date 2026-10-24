unit Contabilidade.Model.TDadosImportacaoContabil;

interface

uses System.Generics.Collections, Contabilidade.Model.Empresa;

type
  TDadosSequencialDoLote = class
  private
    FIncDoc: string;
    FTipLan: string;
    FCompet: string;
    FEmpLan: string;
    FDtaLan: TDate;
    FAutoma: Integer;
    FSequen: Integer;
  public
    property strIncDoc: string read FIncDoc write FIncDoc;
    property strTipLan: string read FTipLan write FTipLan;
    property strCompet: string read FCompet write FCompet;
    property strEmpLan: string read FEmpLan write FEmpLan;
    property dtaDtaLan: TDate read FDtaLan write FDtaLan;
    property intAutoma: integer read FAutoma write FAutoma;
    property intSequen: integer read FSequen write FSequen;
    function Equals(Other: TObject): boolean; overload; override;
  end;

  TInfoPersistirTransfCnt = class
  private
    FintLancon: Int64 ;
    FstrContaContabil: String ;
    FstrCreDeb: String ;
    FdtaDtaTrn: TDate ;
    FstrHraTrn: String ;
    FstrCodOpe: String ;
  public
    property Lancon: Int64 read FintLancon write FintLancon;
    property ContaContabil: String read FstrContaContabil write FstrContaContabil ;
    property CreDeb: String read FstrCreDeb write FstrCreDeb ;
    property DtaTrn: TDate read FdtaDtaTrn write FdtaDtaTrn ;
    property HraTrn: String read FstrHraTrn write FstrHraTrn ;
    property CodOpe: String read FstrCodOpe write FstrCodOpe ;
  end ;

type
  TDadosImportacaoContabil = class
  private
    FSeqLan: string;
    FEmpresa: TEmpresa;
    FEmpresaCtpDet: TEmpresa;
    FDtaLancamento: TDateTime;
    FTipoLancamento: string; //tipo do lançamento CTR, CTP, ENT....
    FCfopConfig: string; //cfops configuradas para exportação
    FNaturezaOperacao: string; //a vista, a prazo ou todos
    FDescricaoValor: string; //descrição do valor, Vr.Recebido, Vr.Pago....
    FContaCredito: string; //conta de crédito
    FContaDebito: string; //conta de débito
    FHistorico: string;
    FCodigoHistoricoPadrao: integer;
    FValorLancamento: double;
    FParametrizouCredito: Boolean;
    FParametrizouDebito: Boolean;
    FCCusto: String;
    FOrigemCredito: String;
    FOrigemDebito: String;
    FCtpInc: String;
    FstrIncDocAg: String;
    FAutomatico: integer;
    FCodigoOperador: string;
    FCodigoEmpresa: string;
    FCodigoEmpDesmem: string;
    FTabela: string;
    FCodigoContabilizavelCredito: string;
    FCodigoContabilizavelDebito: string;
    FCCustoCredito: string;
    FstrMensagemUsuario: string;
    fstrFormaPagamento: string;
    FstrPagamento: string;
    FblnIsCtpDet: Boolean;
    FblnIsAgrup: Boolean;
    FblnLancamentoDuploEmpDif: Boolean;
    FstrVersaoSistema: String;
    FstrCliFor: String;
    FstrTip_fc: String;
    FCodigoEmpLogada: String;
    FForPgo: string;
    FSeqPar: string;
    FInvNco: string;
    FTpOriD: string;
    FCdOriD: string;
    FOpBcDb: string;
    FTpOriC: string;
    FCdOriC: string;
    FOpBcCr: string;
    FNumDoc: string;
  public
    constructor Create(const AstrVerSis, AstrEmpLog: String); Reintroduce;
    property strSeqLan: string read FSeqLan write FSeqLan;
    property empresa: TEmpresa read FEmpresa write FEmpresa;
    property empresaCtpDet: TEmpresa read FEmpresaCtpDet write FEmpresaCtpDet;
    property dtaLancamento: TDateTime read FDtaLancamento write FDtaLancamento;
    property strTipoLancamento: string read FTipoLancamento write FTipoLancamento;
    property strCfopConfig: string read FCfopConfig write FCfopConfig;
    property strNaturezaOperacao: string read FNaturezaOperacao write FNaturezaOperacao;
    property strDescricaoValor: string read FDescricaoValor write FDescricaoValor; //descrição do valor, Vr.Recebido, Vr.Pago....
    property strContaCredito: string read FContaCredito write FContaCredito; //conta de crédito
    property strContaDebito: string read FContaDebito write FContaDebito; //conta de débito
    property strHistorico: string read FHistorico write FHistorico;
    property intCodigoHistoricoPadrao: integer read FCodigoHistoricoPadrao write FCodigoHistoricoPadrao;
    property fltValorLancamento: double read FValorLancamento write FValorLancamento;
    property blnParametrizouCredito: Boolean read FParametrizouCredito write FParametrizouCredito;
    property blnParametrizouDebito: Boolean read FParametrizouDebito write FParametrizouDebito;
    property strCCusto: String read FCCusto write FCCusto;
    property strOrigemCredito: string read FOrigemCredito write FOrigemCredito;
    property strOrigemDebito: string read FOrigemDebito write FOrigemDebito;
    property strCtpInc: String read FCtpInc write FCtpInc;
    property intAutomatico: integer read FAutomatico write FAutomatico;
    property strCodigoOperador: string read FCodigoOperador write FCodigoOperador;
    property strCodigoEmpresa: string read FCodigoEmpresa write FCodigoEmpresa;
    property strCodigoEmpDesmem: string read FCodigoEmpDesmem write FCodigoEmpDesmem;
    property strTabela: string read FTabela write FTabela;
    property strCodigoContabilizavelCredito: string read FCodigoContabilizavelCredito write FCodigoContabilizavelCredito;
    property strCodigoContabilizavelDebito: string read FCodigoContabilizavelDebito write FCodigoContabilizavelDebito;
    property strCCustoCredito: string read FCCustoCredito write FCCustoCredito;
    property strMensagemUsuario: string read FstrMensagemUsuario write FstrMensagemUsuario;
    property strFormaPagamento: string read FstrFormaPagamento write FstrFormaPagamento;
    property strPagamento: string read FstrPagamento write FstrPagamento ;
    property blnIsCtpDet: boolean read FblnIsCtpDet write FblnIsCtpDet ;
    property blnIsAgrup: boolean read FblnIsAgrup write FblnIsAgrup ;
    property blnLancamentoDuploEmpDif: boolean read FblnLancamentoDuploEmpDif write FblnLancamentoDuploEmpDif;
    property strIncDocAg: String read FstrIncDocAg write FstrIncDocAg;
    property strVersaoSistema: String read FstrVersaoSistema write FstrVersaoSistema ;
    property strCliFor: String read FstrCliFor write FstrCliFor;
    property strTip_fc: String read FstrTip_fc write FstrTip_fc;
    property strCodEmpLogada: String read FCodigoEmpLogada write FCodigoEmpLogada;
    property strForPgo: String read FForPgo write FForPgo;
    property strSeqPar: string read FSeqPar write FSeqPar;
    property strInvNco: string read FInvNco write FInvNco;
    property strTpOriD: string read FTpOriD write FTpOriD;
    property strCdOriD: string read FCdOriD write FCdOriD;
    property strOpBcDb: string read FOpBcDb write FOpBcDb;
    property strTpOriC: string read FTpOriC write FTpOriC;
    property strCdOriC: string read FCdOriC write FCdOriC;
    property strOpBcCr: string read FOpBcCr write FOpBcCr;
    property strNumDoc: string read FNumDoc write FNumDoc;
  end;

  TInfoContraPartidaAgrupadaNoDesmembramentoValores = class
  private
    FRefDadosImportacaoContabil : TDadosImportacaoContabil ;
  public
    property RefDadosImportacaoContabil : TDadosImportacaoContabil read FRefDadosImportacaoContabil write FRefDadosImportacaoContabil ;
  end ;

  TDadosFechamentoContabilPlaMes = class
  private
    FstrCCusto: String ;
    FstrCodCon: String ;
    FstrCodEmp: String ;
    FstrCreDeb: String ;
    FdtaDtaSal: TDateTime ;
    FfltSalIni: double ;
  public
    property CCusto: string read FstrCCusto write FstrCCusto;
    property CodCon: string read FstrCodCon write FstrCodCon;
    property CodEmp: string read FstrCodEmp write FstrCodEmp;
    property CreDeb: string read FstrCreDeb write FstrCreDeb;
    property DtaSal: TDateTime read FdtaDtaSal write FdtaDtaSal;
    property SalIni: double read FfltSalIni write FfltSalIni;
  end ;

  TSaldosLanDet = record
    SalAnt: Double;
    SalFin: Double;
    CrDeAn: string;
    CrDeFi: String;
    Credit: Double;
    Debito: Double;
  end ;

  TDictLanDet = TDictionary<string, TSaldosLanDet>;
  TPairLanDet = TPair<string, TSaldosLanDet>;

  TDadosFechamentoContabilLanBal = class
  private
    FstrCCusto: string ;
    FstrCodCon: string ;
    FstrCodEmp: string ;
    FstrCrDeAn: string ;
    FstrCrDeFi: string ;
    FfltCredit: double ;
    FfltDebito: double ;
    FdtaDtaMov: TDateTime ;
    FfltSalAnt: double ;
    FfltSalFin: double ;
    FdictLanDet: TDictLanDet ;
  public
    property CCusto: string read FstrCCusto write FstrCCusto;
    property CodCon: string read FstrCodCon write FstrCodCon ;
    property CodEmp: string read FstrCodEmp write FstrCodEmp ;
    property CrDeAn: string read FstrCrDeAn write FstrCrDeAn ;
    property CrDeFi: string read FstrCrDeFi write FstrCrDeFi ;
    property Credit: double read FfltCredit write FfltCredit ;
    property Debito: double read FfltDebito write FfltDebito ;
    property DtaMov: TDateTime read FdtaDtaMov write FdtaDtaMov ;
    property SalAnt: double read FfltSalAnt write FfltSalAnt ;
    property SalFin: double read FfltSalFin write FfltSalFin ;
    property LanDet: TDictLanDet read FdictLanDet;

    constructor Create;
    destructor Destroy; override;
  end ;

  TDadosFechamentoContabilFecMes = class
  private
    FstrCodOpe: string ;
    FdtaDtaFec: TDateTime ;
    FdtaMesDta: TDateTime ;
    FstrCodEmp: string ;
    FstrEmpGrv: string ;
  public
    property CodOpe: string read FstrCodOpe write FstrCodOpe ;
    property DtaFec: TDateTime read FdtaDtaFec write FdtaDtaFec ;
    property MesDta: TDateTime read FdtaMesDta write FdtaMesDta ;
    property CodEmp: string read FstrCodEmp write FstrCodEmp ;
    property EmpGrv: string read FstrEmpGrv write FstrEmpGrv ;
  end ;

  TLogAjcItem = class
  private
    FCodEmp: string;
    FCodOpe: string;
    FDtaAlt: TDate;
    FHraAlt: TTime;
    FTabela: String;
    FIncdoc: String;
    FTipaju: String;
    FColuna: String;
    FValAnt: String;
    FValAtu: String;
    FNomFrm: String;
    FSeqAju: String;
  public
    property CodEmp: string read FCodEmp write FCodEmp;
    property CodOpe: string read FCodOpe write FCodOpe;
    property DtaAlt: TDate  read FDtaAlt write FDtaAlt;
    property HraAlt: TTime  read FHraAlt write FHraAlt;
    property Tabela: String read FTabela write FTabela;
    property Incdoc: String read FIncdoc write FIncdoc;
    property Tipaju: String read FTipaju write FTipaju;
    property Coluna: String read FColuna write FColuna;
    property ValAnt: String read FValAnt write FValAnt;
    property ValAtu: String read FValAtu write FValAtu;
    property NomFrm: String read FNomFrm write FNomFrm;
    property SeqAju: String read FSeqAju write FSeqAju;
  end;

implementation

uses
  System.SysUtils;

{ TDadosSequencialDoLote }

function TDadosSequencialDoLote.Equals(Other: TObject): boolean;
begin
  if (not Assigned(Other)) then
    Exit(False);

  if (not (Other Is TDadosSequencialDoLote)) then
    Exit(False);

  Result := (Self.strIncDoc = TDadosSequencialDoLote(Other).strIncDoc) and
            (Self.strTipLan = TDadosSequencialDoLote(Other).strTipLan) and
            (Self.strEmpLan = TDadosSequencialDoLote(Other).strEmpLan);
end;

{ TDadosImportacaoContabil }

constructor TDadosImportacaoContabil.Create(const AstrVerSis, AstrEmpLog: String);
begin
  FstrVersaoSistema := AstrVerSis ;
  FCodigoEmpLogada := AstrEmpLog ;
end;

{ TDadosFechamentoContabilLanBal }

constructor TDadosFechamentoContabilLanBal.Create;
begin
  inherited;
  FdictLanDet := TDictLanDet.Create();
end;

destructor TDadosFechamentoContabilLanBal.Destroy;
begin
  FreeAndNil(FdictLanDet);
  inherited;
end;

end.
