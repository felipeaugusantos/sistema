unit untFusionRomaneio;

interface

uses
  System.Generics.Collections, REST.Json.Types, System.Json, REST.Json;

{$M+}

type
  TFusionEntregas = class
  private
    [JSONName('t12_carga_primaria')]
    FT12CargaPrimaria: string;
    [JSONName('t12_data_prevista_entrega')]
    FT12DataPrevistaEntrega: string;
    [JSONName('t12_data_prevista_entrega_atualizada')]
    FT12DataPrevistaEntregaAtualizada: string;
    [JSONName('t12_destino_divisao_carga')]
    FT12DestinoDivisaoCarga: string;
    [JSONName('t12_num_divisao_carga')]
    FT12NumDivisaoCarga: string;
    [JSONName('t12_obs_divisao_carga')]
    FT12ObsDivisaoCarga: string;
    [JSONName('t12_ordemEntrega')]
    FT12OrdemEntrega: string;
    [JSONName('t32_carga_erp')]
    FT32CargaErp: string;
    [JSONName('t32_latitude')]
    FT32Latitude: string;
    [JSONName('t32_longitude')]
    FT32Longitude: string;
    [JSONName('t32_nf')]
    FT32Nf: string;
    [JSONName('t32_num_ped_conf')]
    FT32NumPedConf: string;
    [JSONName('t32_pedido_original')]
    FT32PedidoOriginal: string;
    [JSONName('t32_peso')]
    FT32Peso: string;
    [JSONName('t32_qtd_itens_pedido')]
    FT32QtdItensPedido: string;
    [JSONName('t32_sn_end_entrega_dif')]
    FT32SnEndEntregaDif: string;
    [JSONName('t32_tipo_nf')]
    FT32TipoNf: string;
    [JSONName('t32_valor')]
    FT32Valor: string;
    [JSONName('t32_volume_m3')]
    FT32VolumeM3: string;
    [JSONName('t43_codigo_filial_erp')]
    FT43CodigoFilialErp: string;
    [JSONName('t44_codigo_erp')]
    FT44CodigoErp: string;
  published
    property T12CargaPrimaria: string read FT12CargaPrimaria write FT12CargaPrimaria;
    property T12DataPrevistaEntrega: string read FT12DataPrevistaEntrega write FT12DataPrevistaEntrega;
    property T12DataPrevistaEntregaAtualizada: string read FT12DataPrevistaEntregaAtualizada write FT12DataPrevistaEntregaAtualizada;
    property T12DestinoDivisaoCarga: string read FT12DestinoDivisaoCarga write FT12DestinoDivisaoCarga;
    property T12NumDivisaoCarga: string read FT12NumDivisaoCarga write FT12NumDivisaoCarga;
    property T12ObsDivisaoCarga: string read FT12ObsDivisaoCarga write FT12ObsDivisaoCarga;
    property T12OrdemEntrega: string read FT12OrdemEntrega write FT12OrdemEntrega;
    property T32CargaErp: string read FT32CargaErp write FT32CargaErp;
    property T32Latitude: string read FT32Latitude write FT32Latitude;
    property T32Longitude: string read FT32Longitude write FT32Longitude;
    property T32Nf: string read FT32Nf write FT32Nf;
    property T32NumPedConf: string read FT32NumPedConf write FT32NumPedConf;
    property T32PedidoOriginal: string read FT32PedidoOriginal write FT32PedidoOriginal;
    property T32Peso: string read FT32Peso write FT32Peso;
    property T32QtdItensPedido: string read FT32QtdItensPedido write FT32QtdItensPedido;
    property T32SnEndEntregaDif: string read FT32SnEndEntregaDif write FT32SnEndEntregaDif;
    property T32TipoNf: string read FT32TipoNf write FT32TipoNf;
    property T32Valor: string read FT32Valor write FT32Valor;
    property T32VolumeM3: string read FT32VolumeM3 write FT32VolumeM3;
    property T43CodigoFilialErp: string read FT43CodigoFilialErp write FT43CodigoFilialErp;
    property T44CodigoErp: string read FT44CodigoErp write FT44CodigoErp;
  end;

  TFusionRomaneio = class
  private
    [JSONName('CODIGO_INT')]
    FCODIGOINT: string;
    FClientes: string;
    [JSONName('cnpj_transportadora')]
    FCnpjTransportadora: string;
    [JSONName('cod_erp_usuario')]
    FCodErpUsuario: string;
    FCodajudantes: string;
    FCodpracaprinc: string;
    FCodrotaprinc: string;
    FCusto: string;
    [JSONName('ENTREGAS'), JSONMarshalled(False)]
    FENTREGASArray: TArray<TFusionEntregas>;
    [JSONName('km_previsto')]
    FKmPrevisto: string;
    FNumcidades: string;
    FNumclientes: string;
    FNumitens: string;
    FPeso: string;
    FPlaca: string;
    [JSONName('t05_codigo_erp')]
    FT05CodigoErp: string;
    [JSONName('t05_nome')]
    FT05Nome: string;
    [JSONName('t06_codigo_erp')]
    FT06CodigoErp: string;
    [JSONName('t06_peso_max_entregas')]
    FT06PesoMaxEntregas: string;
    [JSONName('t06_qtd_pallets_veiculo')]
    FT06QtdPalletsVeiculo: string;
    [JSONName('t06_volume_max_entregas')]
    FT06VolumeMaxEntregas: string;
    [JSONName('t10_carga_formada_erp')]
    FT10CargaFormadaErp: string;
    [JSONName('t10_cargas_erp')]
    FT10CargasErp: string;
    [JSONName('t10_custo_estimado')]
    FT10CustoEstimado: string;
    [JSONName('t10_custo_pedagio')]
    FT10CustoPedagio: string;
    [JSONName('t10_data_grava')]
    FT10DataGrava: string;
    [JSONName('t10_data_prevista_termino')]
    FT10DataPrevistaTermino: string;
    [JSONName('t10_data_saida')]
    FT10DataSaida: string;
    [JSONName('t10_destino')]
    FT10Destino: string;
    [JSONName('t10_diarias_completas')]
    FT10DiariasCompletas: string;
    [JSONName('t10_diarias_simples')]
    FT10DiariasSimples: string;
    [JSONName('t10_id')]
    FT10Id: string;
    [JSONName('t10_kmRealizado')]
    FT10KmRealizado: string;
    [JSONName('t10_kmTotal')]
    FT10KmTotal: string;
    [JSONName('t10_modo_rota')]
    FT10ModoRota: string;
    [JSONName('t10_obs')]
    FT10Obs: string;
    [JSONName('t10_qtd_almoco')]
    FT10QtdAlmoco: string;
    [JSONName('t10_qtd_cafe_manha')]
    FT10QtdCafeManha: string;
    [JSONName('t10_qtd_hospedagens')]
    FT10QtdHospedagens: string;
    [JSONName('t10_qtd_jantar')]
    FT10QtdJantar: string;
    [JSONName('t10_qtd_pallets_carga')]
    FT10QtdPalletsCarga: string;
    [JSONName('t10_senha_mobile_cast')]
    FT10SenhaMobileCast: string;
    [JSONName('t10_situacao')]
    FT10Situacao: string;
    [JSONName('t10_sn_frete_negociado')]
    FT10SnFreteNegociado: string;
    [JSONName('t10_sn_houveram_avarias')]
    FT10SnHouveramAvarias: string;
    [JSONName('t10_sn_planejada')]
    FT10SnPlanejada: string;
    [JSONName('t10_sn_tem_transferencia')]
    FT10SnTemTransferencia: string;
    [JSONName('t10_sn_utiliza_chapa')]
    FT10SnUtilizaChapa: string;
    [JSONName('t10_sn_verificado_avarias')]
    FT10SnVerificadoAvarias: string;
    [JSONName('t10_tempoMovimento')]
    FT10TempoMovimento: string;
    [JSONName('t10_tempoTotal')]
    FT10TempoTotal: string;
    [JSONName('t10_tipo_chapa')]
    FT10TipoChapa: string;
    [JSONName('t10_valor_adiantado_motorista')]
    FT10ValorAdiantadoMotorista: string;
    [JSONName('t10_valor_adiantamento_extra')]
    FT10ValorAdiantamentoExtra: string;
    [JSONName('t10_valor_chapa')]
    FT10ValorChapa: string;
    [JSONName('t10_valor_descarrego')]
    FT10ValorDescarrego: string;
    [JSONName('t10_valor_frete_autonomo')]
    FT10ValorFreteAutonomo: string;
    [JSONName('t10_valor_frete_negociado')]
    FT10ValorFreteNegociado: string;
    [JSONName('t43_codigo_filial_erp')]
    FT43CodigoFilialErp: string;
    [JSONName('TIPO_INT')]
    FTIPOINT: string;
    [JSONName('VEICULO_ERP')]
    FVEICULOERP: string;
    FValortotal: string;
    FVolume: string;
  published
    property CODIGOINT: string read FCODIGOINT write FCODIGOINT;
    property Clientes: string read FClientes write FClientes;
    property CnpjTransportadora: string read FCnpjTransportadora write FCnpjTransportadora;
    property CodErpUsuario: string read FCodErpUsuario write FCodErpUsuario;
    property Codajudantes: string read FCodajudantes write FCodajudantes;
    property Codpracaprinc: string read FCodpracaprinc write FCodpracaprinc;
    property Codrotaprinc: string read FCodrotaprinc write FCodrotaprinc;
    property Custo: string read FCusto write FCusto;
    property ENTREGAS: TArray<TFusionEntregas> read FENTREGASArray;
    property KmPrevisto: string read FKmPrevisto write FKmPrevisto;
    property Numcidades: string read FNumcidades write FNumcidades;
    property Numclientes: string read FNumclientes write FNumclientes;
    property Numitens: string read FNumitens write FNumitens;
    property Peso: string read FPeso write FPeso;
    property Placa: string read FPlaca write FPlaca;
    property T05CodigoErp: string read FT05CodigoErp write FT05CodigoErp;
    property T05Nome: string read FT05Nome write FT05Nome;
    property T06CodigoErp: string read FT06CodigoErp write FT06CodigoErp;
    property T06PesoMaxEntregas: string read FT06PesoMaxEntregas write FT06PesoMaxEntregas;
    property T06QtdPalletsVeiculo: string read FT06QtdPalletsVeiculo write FT06QtdPalletsVeiculo;
    property T06VolumeMaxEntregas: string read FT06VolumeMaxEntregas write FT06VolumeMaxEntregas;
    property T10CargaFormadaErp: string read FT10CargaFormadaErp write FT10CargaFormadaErp;
    property T10CargasErp: string read FT10CargasErp write FT10CargasErp;
    property T10CustoEstimado: string read FT10CustoEstimado write FT10CustoEstimado;
    property T10CustoPedagio: string read FT10CustoPedagio write FT10CustoPedagio;
    property T10DataGrava: string read FT10DataGrava write FT10DataGrava;
    property T10DataPrevistaTermino: string read FT10DataPrevistaTermino write FT10DataPrevistaTermino;
    property T10DataSaida: string read FT10DataSaida write FT10DataSaida;
    property T10Destino: string read FT10Destino write FT10Destino;
    property T10DiariasCompletas: string read FT10DiariasCompletas write FT10DiariasCompletas;
    property T10DiariasSimples: string read FT10DiariasSimples write FT10DiariasSimples;
    property T10Id: string read FT10Id write FT10Id;
    property T10KmRealizado: string read FT10KmRealizado write FT10KmRealizado;
    property T10KmTotal: string read FT10KmTotal write FT10KmTotal;
    property T10ModoRota: string read FT10ModoRota write FT10ModoRota;
    property T10Obs: string read FT10Obs write FT10Obs;
    property T10QtdAlmoco: string read FT10QtdAlmoco write FT10QtdAlmoco;
    property T10QtdCafeManha: string read FT10QtdCafeManha write FT10QtdCafeManha;
    property T10QtdHospedagens: string read FT10QtdHospedagens write FT10QtdHospedagens;
    property T10QtdJantar: string read FT10QtdJantar write FT10QtdJantar;
    property T10QtdPalletsCarga: string read FT10QtdPalletsCarga write FT10QtdPalletsCarga;
    property T10SenhaMobileCast: string read FT10SenhaMobileCast write FT10SenhaMobileCast;
    property T10Situacao: string read FT10Situacao write FT10Situacao;
    property T10SnFreteNegociado: string read FT10SnFreteNegociado write FT10SnFreteNegociado;
    property T10SnHouveramAvarias: string read FT10SnHouveramAvarias write FT10SnHouveramAvarias;
    property T10SnPlanejada: string read FT10SnPlanejada write FT10SnPlanejada;
    property T10SnTemTransferencia: string read FT10SnTemTransferencia write FT10SnTemTransferencia;
    property T10SnUtilizaChapa: string read FT10SnUtilizaChapa write FT10SnUtilizaChapa;
    property T10SnVerificadoAvarias: string read FT10SnVerificadoAvarias write FT10SnVerificadoAvarias;
    property T10TempoMovimento: string read FT10TempoMovimento write FT10TempoMovimento;
    property T10TempoTotal: string read FT10TempoTotal write FT10TempoTotal;
    property T10TipoChapa: string read FT10TipoChapa write FT10TipoChapa;
    property T10ValorAdiantadoMotorista: string read FT10ValorAdiantadoMotorista write FT10ValorAdiantadoMotorista;
    property T10ValorAdiantamentoExtra: string read FT10ValorAdiantamentoExtra write FT10ValorAdiantamentoExtra;
    property T10ValorChapa: string read FT10ValorChapa write FT10ValorChapa;
    property T10ValorDescarrego: string read FT10ValorDescarrego write FT10ValorDescarrego;
    property T10ValorFreteAutonomo: string read FT10ValorFreteAutonomo write FT10ValorFreteAutonomo;
    property T10ValorFreteNegociado: string read FT10ValorFreteNegociado write FT10ValorFreteNegociado;
    property T43CodigoFilialErp: string read FT43CodigoFilialErp write FT43CodigoFilialErp;
    property TIPOINT: string read FTIPOINT write FTIPOINT;
    property VEICULOERP: string read FVEICULOERP write FVEICULOERP;
    property Valortotal: string read FValortotal write FValortotal;
    property Volume: string read FVolume write FVolume;
  public
    destructor Destroy; override;
    procedure pJsonToObject(const AstrJson: String; var AarrFusionRomaneio: TArray<TFusionRomaneio>);
  end;

implementation

destructor TFusionRomaneio.Destroy;
var
  LEntregas: TFusionEntregas;
begin
  for LEntregas in Self.ENTREGAS do
    LEntregas.Free;

  inherited;
end;

procedure TFusionRomaneio.pJsonToObject(const AstrJson: String; var AarrFusionRomaneio: TArray<TFusionRomaneio>);
var
  LjsonArray: TJSONArray;
  LObjec: TJSONObject;
  LArrayElement: TJSONValue;
  LCont: Integer;
begin
  LjsonArray := TJSONObject.ParseJSONValue(AstrJson) as TJSONArray;

  for LArrayElement in LjsonArray do
  begin
    LObjec := (LArrayElement as TJSONObject);
    LCont := Length(AarrFusionRomaneio);
    SetLength(AarrFusionRomaneio, LCont + 1);
    AarrFusionRomaneio[LCont] := TJson.JsonToObject<TFusionRomaneio>(LObjec);
  end;
end;

end.
