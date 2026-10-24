unit untMagazineLuizaTipos;

interface

Uses System.Generics.Collections, System.SysUtils;

Const
  NOME_CONCILIACAO = 'MAGAZINE LUIZA';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

Type
  TTiposLancamentosMkt = (tlmVendas, tlmAjustes, tlmLiquido, tlmTransferencias);

  TRegistroPgto = Record
    strTipReg: String;
    strDtaPed: String;
    strDtaPag: String;
    strID_Mlz: String;
    strID_Sel: String;
    strID_Tra: String;
    strNum_NF: String;
    strNomCli: String;
    strNumPar: String;
    strTotPar: String;
    fltValBru: Double;
    fltValLiq: Double;
    fltValAnt: Double;
    fltValPed: Double;
    fltValCom: Double;
    strOrigem: String;
    strObserv: String;
    strNomArq: String;
    strDtaArq: String;

    PedidoEvento,
    CodigoEmpresa,
    TipoEvento,
    IDRepasse,
    Versao2026: String;

    TaxaTransferencia,
    ValorFixoParcela,
    ValorFixoPedido,
    ValorMDR,
    ValorSubsidio: Double;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroMagazineLuizaPgto  = Array Of TRegistroPgto;

  TArrEstruturaMagazineLuizaPgto = Array Of TEstruturaPgto;

  TParcelasModalidades = class
    QuatidadeParcelas: Integer;

    ValorBruto,
    ValorLiquido,
    ValorTaxas,
    ValorFrete,
    ValorCupom: Double;
  end;

  TParcelasCadastrar = Class
    ChavePrimariaImportacao,
    AutoIncremMovCar,

    IDSeller,
    IDPedido,
    ParcelasConciliadas,
    TotalParcelas: String;

    ParcelasModalidades: TObjectList<TParcelasModalidades>;

    constructor Create;
    destructor Destroy; override;
  End;

implementation

{ TParcelasCadastrar }

constructor TParcelasCadastrar.Create;
begin
  ParcelasModalidades := TObjectList<TParcelasModalidades>.Create;
end;

destructor TParcelasCadastrar.Destroy;
begin
  FreeAndNil(ParcelasModalidades);
end;

end.
