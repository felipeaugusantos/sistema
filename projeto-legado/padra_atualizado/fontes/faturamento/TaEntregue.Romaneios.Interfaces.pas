unit TaEntregue.Romaneios.Interfaces;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, untMaplinkTripClasses;

type
  IStatus = (rmFinalizado, rmNaoIniciado, rmACaminho, rmNaoEntregue, rmTemPendencia);

  ITipoRota = (tpPlanejada, tpEfetuada, tpAproximada);

  IMotorista = interface
    ['{7693ACCE-FD16-4EFB-8805-009F57A1633C}']
    function CodigoMotorista: String;
    function NomeMotorista: String;
  end;

  IVeiculo = interface
    ['{1B705547-3D2A-4261-BE35-78F8A1C8215D}']
    function MarcaVeiculo: String;
    function ModeloVeiculo: String;
    function PlacaVeiculo: String;
    function CorVeiculo: String;
  end;

  IEmpresa = interface
    ['{BDCF8572-6954-4A24-8BA3-7668B612A6AA}']
    function CodigoEmpresa: String;
    function NomeEmpresa: String;
  end;

  ICliente = interface
    ['{04A3AF31-BF2B-4497-ABE3-ED09FE2B36BE}']
    function CodigoCliente: String;
    function NomeCliente: String;
    procedure AbrirCadastro;
  end;

  IEnderecoEntrega = interface
    ['{31446EB6-8F61-4821-A419-E73C7A65E18E}']
    function Endereco: String;
    function Bairro: String;
    function Cep: String;
    function CodigoCidade: String;
    function Cidade: String;
    function Uf: String;
    function Coordenadas: String;
    function EnderecoAlterado: Boolean;
  end;

  IFoto = Interface
    ['{6DB54FEF-8EA2-4A02-8EDE-EEC060BD2CF2}']
    function SeqGer: String;
    function FotoBase64: String;
    function FotoStream: TBytesStream;
  End;

  IAssinatura = interface
    ['{C89751BA-EB69-4B5C-B595-1F5CFF657A64}']
    function SeqGer: String;
    function AssinaturaBase64: String;
    function AssinaturaStream: TBytesStream;
  End;

  IOcorrencia = interface
    ['{14080A12-2BF6-407D-8E2C-9FECD7E2BC61}']
    function SeqGer: String;
    function CodigoOcorrencia: String;
    function Ocorrencia: String;
    function StatusEntregue: String;
    function Mensagem: AnsiString;
    function DataHoraOcorrencia: TDateTime;
  end;

  IRastreamento = interface
    ['{A609FE43-5F80-4CB6-B8AF-133AD710E287}']
    function Coordenadas: String;
    function DataHoraCoordenadas: TDateTime;
  end;

  IRotaGPX = interface
    ['{79697E45-0DC6-4B6B-86E0-BAF89E5EAD33}']
    function TipoRota: ITipoRota;
    function Distancia: Double;
    function Tempo: Integer;
    function GPXFile: String;
  end;

  IItem = interface
    ['{ED776932-6102-46A5-8332-E89C7F087A30}']
    function Autoincrem: String;
    function DetAutInc: String;
    function CodigoItem: String;
    function Item: String;
    function UnidadeDeMedida: String;
    function TotalItem: Double;
    function Quantidade: Double;
    function QuantidadeEntregue: Double;
    function QuantidadeAvariada: Double;
    function QuantidadeFaltante: Double;
    function LiberarItem: Boolean;
    procedure SetLiberarItem(blnLiberar: Boolean);
  end;

  IAlerta = interface
    ['{0FA9182B-CCC0-43F4-A57B-F1E3A9D4C31D}']
    function IdentificacaoAlerta: String;
    function Alerta: String;
    function ObservacaoAlerta: String;
    function DataHoraAlerta: TDateTime;
  end;

  IDocumento = interface
    ['{C63E7347-5EC6-4C78-BCB0-DE265EA6720A}']
    procedure ImprimirDocumento;
    function AutoIncrem: String;
    function NumeroRomaneio: String;
    function NumeroDocumento: String;
    function EspecieDocumento: String;
    function StatusDocumento: IStatus;
    function QuantidadeItens: Integer;
    function DataHoraInicioEntrega: TDateTime;
    function DataHoraBaixaEntrega: TDateTime;
    function RotaOrdem: String;
    function PercursoKm: Double;
    function TempoPercurso: Integer;
    function Motorista: IMotorista;
    function Empresa: IEmpresa;
    function Cliente: ICliente;
    function EnderecoEntrega: IEnderecoEntrega;
    function Fotos: TList<IFoto>;
    function Assinaturas: TList<IAssinatura>;
    function Ocorrencias: TList<IOcorrencia>;
    function NomeRecebedor: String;
    function Itens: TList<IItem>;
    function Alertas: TList<IAlerta>;
    function DataHoraEntregaPrevista: TDateTime;
    function PontoEntregaPrevista: IRastreamento;
    function PontoEntregaEfetuada: IRastreamento;
    procedure CarregaImagens;
    procedure CarregaOcorrencias;
    procedure CarregaItens;
    procedure CarregaPontosEntrega;
    procedure AlteraOrdemEntrega(strOrdem: String);
    procedure SalvarCoordenadaGeografica(strNumRom, strCodemp, strCoordenadas: String);
    function DocumentoDeEntrega: Boolean;
  end;

  ITransportadora = interface
    ['{E0491632-7431-4951-97CE-E9E57E11F60F}']
    function CodigoTransportadora: String;
    function NomeTransportadora: String;
  end;

  IRomaneio = interface
    ['{23AAFC8D-641C-43DA-A72D-49C352991985}']
    function SequencialAtivacao: String;
    function NumeroRomaneio: String;
    function EmpresaRomaneio: String;
    function StatusRomaneio: IStatus;
    function QuantidadeEntregas: Integer;
    function QuantidadeOcorrencias: Integer;
    function DataHoraRomaneio: TDateTime;
    function DataHoraInicioRomaneio: TDateTime;
    function DataHoraBaixaRomaneio: TDateTime;
    function QuantidadeEntregasConcluidas: Integer;
    function PercentualConcluido: Double;
    function Motorista: IMotorista;
    function Documentos: TList<IDocumento>;
    function Ocorrencias: TList<IOcorrencia>;
    function Alertas: TList<IAlerta>;
    function Rastreamentos: TList<IRastreamento>;
    function RotasGPX: TList<IRotaGPX>;
    function NivelPrioridade: Integer;
    procedure AtualizaRota;
    procedure AlteraStatusOcorrencia;
    function Veiculo: IVeiculo;
    function PontoPartida: IRastreamento;
    function PontoChegada: IRastreamento;
    function PontoMotorista: IRastreamento;
    function DistanciaRetorno: Double;
    function TempoRetorno: Integer;
    procedure ExportarRotaGPX(tpRota: ITipoRota; strGPX: String; intTempo: integer; fltDistancia: double);
    procedure RecalcularRotaEfetuada;
    procedure CarregaOcorrenciasRomaneio;
    procedure CarregaDocumentos;
    procedure CarregaRastreamentos;
    procedure CarregaRotasGPX;
    procedure LimparRotasGPX;
    function UltimaCoordenadaGPX : IRastreamento;
    function fRetRotaPlanejada: TRetornoMaplinkTrip;
    function fRetRotaEfetuada: TRetornoMaplinkTrip;
    function OpcaoCaminho: String;
    procedure AdicionarTarefa;
    function Transportadora: ITransportadora;
    function OperadorRomaneio: String;
    function OperadorSolicitante: String;
    function NumeroBox: String;
    function Cancelado: Boolean;
    function fRetRotaPlanejadaMaplinkArray: TArray<TArray<String>>;
    function fRetRotaEfetuadaMaplinkArray: TArray<TArray<String>>;
    function fRetRotaPlanejadaCitelOsrmArray: TArray<TArray<String>>;
    function fRetRotaEfetuadaCitelOsrmArray: TArray<TArray<String>>;
    procedure AlteraStatusRotaEfetuada;
    function RotaRecalculada: Boolean;
    { No fim da interface, e nao no lugar de AtualizaRota: o painel (.bpl) e o
      TRomaneio (.exe) sao binarios separados, e mudar a assinatura de um metodo
      existente faria um .bpl novo ler retorno indefinido de um .exe antigo. }
    function AtualizaRotaComRetorno: Boolean;
  end;

  IConversa = interface
    ['{A2B04B28-F0F1-486A-BC2B-08FA1D565F9A}']
    function Autoincrem: String;
    function Mensagem: AnsiString;
    function Destinatario: String;
    function Remetente: String;
    function DataHora: TDateTime;
    function ComunicacaoVia: String;
  end;

  IContato = interface
    ['{D7AB4761-0502-4EE7-B6BF-E6D6254AFA7B}']
    function CodigoContato: String;
    function NomeContato: String;
    function QuantidadeMensagensNaoLidas: Integer;
    function Conversas: TList<IConversa>;
    function UltimaMensagem: String;
    function DataHoraUltimaMensagem: TDatetime;
    procedure CarregaConversa(strCodOpe: String);
    procedure EnviarMensagem(strCodOpe: String; ansMensagem: AnsiString);
  end;

  IChat = interface
    ['{C3A98424-3E0F-40BE-9B21-2CA0365EB998}']
    function Contatos: TList<IContato>;
    function ContatosRecentes: TList<IContato>;
    function QuantidadeNovasMensagens: Integer;
    procedure VerificaNovasMensagens(strCodOpe: String);
  end;

  IPendencia = interface
    ['{7D25E8D5-5163-43D8-8E16-B1372996799C}']
    function DocsComItensBaixadosParcialmente: TList<IDocumento>;
    function LiberarItensBaixadosParcialmenteParaNovoRomaneio(Documento: IDocumento): Boolean;
    function LiberarItensBaixadosParcialmenteParaDevolucao(Documento: IDocumento): Boolean;
    function LiberarItensBaixadosParcialmente(Documento: IDocumento; blnStartTransaction: Boolean = True): Boolean;
  end;

  ITaEntregue = interface
    ['{41D50D31-6176-49E4-8FD4-A561123B4114}']
    procedure pGravaLogUsoGoogleMaps(strNumRom, strAtividade: String);
    function fGetRomaneios(strRomMot: String; strExceto: String; dtaDtaDe, dtaDtaAte: TDate): TList<IRomaneio>;
    function fGetChat(strCodOpe: String): IChat;
    function fGetMotoristas(strFiltro: String): TList<IMotorista>;
    function fGetLocalizacao(strCodMot: String): IRastreamento;
    function fGetPendencias(const strFiltro: String): IPendencia;
    function fCriaMsgLiberacao(DirAcesso, Mensagem: String): Boolean;
    function fHabilitaAtualizacaoAutomatica: Boolean;
    function fCountPendencias: Integer;
    function fMensagem(strTitulo: String;
                       strTexto: String;
                       arrOpcoes: Array Of String;
                       intFocoBotao: Integer = 1;
                       blnSaiComEsc: Boolean = False;
                       intEstFon: Integer = 1;
                       intWidBut: Integer = 0;
                       blnAutosize: Boolean = False;
                       intSomarTop: Integer=0;
                       blnObrigaEsc: Boolean = False;
                       blnOcultPainelBtn: Boolean = False;
                       blnBtnSemImg : Boolean = False;
                       intHeightOpc: Integer = 0;
                       intFormWidth: Integer = 0): Integer;
  end;

implementation

end.
