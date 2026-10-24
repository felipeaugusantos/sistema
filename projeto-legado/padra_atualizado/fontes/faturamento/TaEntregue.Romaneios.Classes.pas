unit TaEntregue.Romaneios.Classes;

interface

uses
  System.SysUtils, System.StrUtils, System.Classes, Uni, TaEntregue.Romaneios.Interfaces,
  Shared.Functions.Core, Shared.Functions.DataSet, System.Generics.Collections, Math,
  untFatGeraPdfEmail, untReimpressao, VCL.TMSFNCCloudBase, VCL.TMSFNCGeocoding,
  UniClientDataSet, untMapsDistanceMatrix, Data.DB,  System.DateUtils, System.Variants,
  untCadClientes, untMaplinkTripClasses, untControllerMaplinkTrip, untCitelOsrmRouteApi,
  untBucketCitel;

type
  TTipoDocumento = (tpNone, tpDocsComItensBaixadosParcialmente);

  TMotorista = class(TInterfacedObject, IMotorista)
  private
    FCodigoMotorista: String;
    FNomeMotorista: String;
  protected
    constructor Create(strCodMot, strNomMot: String);
  public
    function CodigoMotorista: String;
    function NomeMotorista: String;
  end;

  TVeiculo = class(TInterfacedObject, IVeiculo)
  private
    FMarcaVeiculo: String;
    FModeloVeiculo: String;
    FPlacaVeiculo: String;
    FCorVeiculo: String;
  protected
    constructor Create(strMarcaVeiculo, strModeloVeiculo, strPlacaVeiculo, strCorVeiculo: String);
  public
    function MarcaVeiculo: String;
    function ModeloVeiculo: String;
    function PlacaVeiculo: String;
    function CorVeiculo: String;
  end;

  TEmpresa = class(TInterfacedObject, IEmpresa)
  private
    FCodigoEmpresa: String;
    FNomeEmpresa: String;
  protected
    constructor Create(strCodEmp, strNomEmp: String);
  public
    function CodigoEmpresa: String;
    function NomeEmpresa: String;
  end;

  TCliente = class(TInterfacedObject, ICliente)
  private
    FCodigoCliente: String;
    FNomeCliente: String;
  private
    procedure pAbrirCadastro;
  protected
    constructor Create(strCodCli, strNomCli: String);
  public
    function CodigoCliente: String;
    function NomeCliente: String;
    procedure AbrirCadastro;
  end;

  TEnderecoEntrega = class(TInterfacedObject, IEnderecoEntrega)
    private
      FEndereco: String;
      FBairro: String;
      FCep: String;
      FCodigoCidade: String;
      FCidade: String;
      FUf: String;
      FCoordenadas : String;
      FAltEnd: String;
    protected
      constructor Create(strCodCid, strNomCid, strUf, strEndereco, strBairro, strCep, strCoordenadas, strAltEnd: String);
    public
      function Endereco: String;
      function Bairro: String;
      function Cep: String;
      function CodigoCidade: String;
      function Cidade: String;
      function Uf: String;
      function Coordenadas : String;
      function EnderecoAlterado : Boolean;
  end;

  TFoto = class(TInterfacedObject, IFoto)
  private
    FFotoBase64: String;
    FFotoURL: String;
    FSeqGer: String;
    FFotoStream: TBytesStream;
  protected
    constructor Create(strSeqGer: String; strFotoBase64, strFotoURL: String);
  public
    destructor Destroy; override;
    function SeqGer: String;
    function FotoBase64: String;
    function FotoURL: String;
    function FotoStream: TBytesStream;
  end;

  TAssinatura = class(TInterfacedObject, IAssinatura)
  private
    FAssinaturaBase64: String;
    FAssinaturaURL: String;
    FSeqGer: String;
    FAssinaturaStream: TBytesStream;
  protected
    constructor Create(strSeqGer: String; strAssinaturaBase64, strAssinaturaURL: String);
  public
    destructor Destroy; override;
    function SeqGer: String;
    function AssinaturaBase64: String;
    function AssinaturaURL: String;
    function AssinaturaStream: TBytesStream;
  end;

  TOcorrencia = class(TInterfacedObject, IOcorrencia)
  private
    FSeqGer: String;
    FCodigoOcorrencia: String;
    FOcorrencia: String;
    FStatusEntregue: String;
    FMensagem: AnsiString;
    FDataHoraOcorrencia: TDateTime;
  protected
    constructor Create(strSeqGer, strCodOco, strDesOco, strStatusEntregue: String;
    ansMensagem: AnsiString; dtaHorOco: TDateTime);
  public
    function SeqGer: String;
    function CodigoOcorrencia: String;
    function Ocorrencia: String;
    function StatusEntregue: String;
    function Mensagem: AnsiString;
    function DataHoraOcorrencia: TDateTime;
  end;

  TRastreamento = class(TInterfacedObject, IRastreamento)
  private
    FCoordenadas : String;
    FDataHoraCoordenadas: TDateTime;
  protected
    constructor Create(strLatLon: String; dtaDtaHor: TDateTime);
  public
    function Coordenadas: String;
    function DataHoraCoordenadas: TDateTime;
  end;

  TItem = class(TInterfacedObject, IItem)
  private
    FAutoincrem: String;
    FDetAutInc: String;
    FCodigoItem: String;
    FItem: String;
    FUnidadeDeMedida: String;
    FTotalItem: Double;
    FQuantidade: Double;
    FQuantidadeEntregue: Double;
    FQuantidadeAvariada: Double;
    FQuantidadeFaltante: Double;
    FLiberarItem: Boolean;
  protected
    constructor Create(strAutoincrem, strDetAutInc, strCodigoItem, strItem, strUnidadeDeMedida: String;
                       fltTotalitem, fltQuantidade, fltQuantidadeEntregue, fltQuantidadeAvariada,
                       fltQuantidadeFaltante: Double);
  public
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

  TAlerta = class(TInterfacedObject, IAlerta)
  private
    FIdentificacaoAlerta: String;
    FAlerta: String;
    FObservacaoAlerta: String;
    FDataHoraAlerta: TDateTime;
  protected
    constructor Create(strIdentificacao, strObservacao, strAlerta: String; dtaDataHora: TDateTime);
  public
    function IdentificacaoAlerta: String;
    function Alerta: String;
    function ObservacaoAlerta: String;
    function DataHoraAlerta: TDateTime;
  end;

  TDocumento = class(TInterfacedObject, IDocumento)
  private
    FAutoIncrem: String;
    FNumeroRomaneio: String;
    FNumeroDocumento: String;
    FEspecieDocumento: String;
    FStatusDocumento: IStatus;
    FQuantidadeItens: Integer;
    FDataHoraInicioEntrega: TDateTime;
    FDataHoraBaixaEntrega: TDateTime;
    FRotaOrdem: String;
    FPercursoKm: Double;
    FTempoPercurso: Integer;
    FNomeRecebedor: String;
    FMotorista: IMotorista;
    FEmpresa: IEmpresa;
    FCliente: ICliente;
    FEnderecoEntrega: IEnderecoEntrega;
    FFotos: TList<IFoto>;
    FAssinaturas: TList<IAssinatura>;
    FOcorrencias: TList<IOcorrencia>;
    FItens: TList<IItem>;
    FTipoDocumento: TTipoDocumento;
    FAlertas: TList<IAlerta>;
    FDataHoraEntregaPrevista: TDateTime;
    FPontoEntregaPrevista: IRastreamento;
    FPontoEntregaEfetuada: IRastreamento;
    FDocumentoDeEntrega: Boolean;

    procedure pCarregaFotos;
    procedure pCarregaAssinaturas;
    procedure pCarregaOcorrenciasDocumento;
    procedure pAlertaValorDocRecebido;
    procedure pCarregaPontosEntrega;
  protected
    constructor Create(qryDocumento: IMyQuery; TipoDocumento: TTipoDocumento = tpNone);
  public
    destructor Destroy; override;
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
    function NomeRecebedor: String;
    function Motorista: IMotorista;
    function Empresa: IEmpresa;
    function Cliente: ICliente;
    function EnderecoEntrega: IEnderecoEntrega;
    function Fotos: TList<IFoto>;
    function Assinaturas: TList<IAssinatura>;
    function Ocorrencias: TList<IOcorrencia>;
    function Itens: TList<IItem>;
    function Alertas: TList<IAlerta>;
    function DataHoraEntregaPrevista: TDateTime;
    function PontoEntregaPrevista: IRastreamento;
    function PontoEntregaEfetuada: IRastreamento;
    function DocumentoDeEntrega: Boolean;
    procedure CarregaImagens;
    procedure CarregaOcorrencias;
    procedure CarregaItens;
    procedure CarregaPontosEntrega;
    procedure pCarregaAlertas;
    procedure AlteraOrdemEntrega(strOrdem: String);
    procedure SalvarCoordenadaGeografica(strNumRom, strCodemp, strCoordenadas: String);
  end;

  TTransportadora = class(TInterfacedObject, ITransportadora)
  private
    FCodigoTransportadora: String;
    FNomeTransportadora: String;
  protected
    constructor Create(strCodTra, strNomTra: String);
  public
    function CodigoTransportadora: String;
    function NomeTransportadora: String;
  end;

  TRomaneio = class(TInterfacedObject, IRomaneio)
  private
    FSequencialAtivacao: String;
    FNumeroRomaneio: String;
    FEmpresaRomaneio: String;
    FStatusRomaneio: IStatus;
    FQuantidadeEntregas: Integer;
    FQuantidadeOcorrencias: Integer;
    FDataHoraRomaneio: TDateTime;
    FDataHoraInicioRomaneio: TDateTime;
    FDataHoraBaixaRomaneio: TDateTime;
    FQuantidadeEntregasConcluidas: Integer;
    FMotorista: IMotorista;
    FDocumentos: TList<IDocumento>;
    FOcorrencias: TList<IOcorrencia>;
    FAlertas: TList<IAlerta>;
    FRastreamentos: TList<IRastreamento>;
    FRotasGPX: TList<IRotaGPX>;
    FNivelPrioridade: Integer;
    FVeiculo: IVeiculo;
    FPontoPartida: IRastreamento;
    FPontoChegada: IRastreamento;
    FPontoMotorista: IRastreamento;
    FDistanciaRetorno: Double;
    FTempoRetorno: Integer;
    FUltimaCoordenadaGPX : IRastreamento;
    FOpcaoCaminho: String;
    FTransportadora: ITransportadora;
    FOperadorRomaneio: String;
    FOperadorSolicitante: String;
    FNumeroBox: String;
    FCancelado: Boolean;

    procedure pCarregaOcorrenciasRomaneio;
    procedure pCarregaDocumentos;
    procedure pCarregaRastreamentos(dtaBaixaRomaneio : TDateTime = 0);
    procedure pCarregaRotasGPX;
    function fRetEvitar(strAvoid: String): TAvoid;
    function fRetEvitarMaplink(strAvoid: String): TArray<String>;
    procedure pConfiguraCarregamentoNaFilial(cdsTmpDoc: TUniClientDataSet);
    procedure pCarregaAlertasMotivosDePausa;
    function fSubstituiOrdImp(var arrOrdImpOri: Array Of Integer): Integer;
    function fRetPontoInicial: String;
    procedure pCriaCdsMapsDistanceMatrix(var cdsRomRet, cdsTmpDoc : TUniClientDataSet);
    function fRetornaValorTipoRota(tpRota: ITipoRota): Integer;
    function fRetRotaPlanejada: TRetornoMaplinkTrip;
    function fRetRotaEfetuada: TRetornoMaplinkTrip;
    function fRetUltimaCoordenadaGPX: IRastreamento;
    function DocumentoComEntregaEmAndamento: IDocumento;
    function fRetornaAutoincremDaEntregaEmAndamento: String;
    function UltimaEntrega: IDocumento;
    function fRetornaOrdImpUltimaEntrega: Integer;
    function fRetRotaPlanejadaMaplinkArray: TArray<TArray<String>>;
    function fRetRotaEfetuadaMaplinkArray: TArray<TArray<String>>;
    function fRetRotaPlanejadaCitelOsrmArray: TArray<TArray<String>>;
    function fRetRotaEfetuadaCitelOsrmArray: TArray<TArray<String>>;
  protected
    constructor Create(strNumRom: String; intNivPri: Integer);
  public
    destructor Destroy; override;
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
    function AtualizaRotaComRetorno: Boolean;
    procedure AlteraStatusOcorrencia;
    function Veiculo: IVeiculo;
    function PontoPartida: IRastreamento;
    function PontoChegada: IRastreamento;
    function PontoMotorista: IRastreamento;
    function DistanciaRetorno: Double;
    function TempoRetorno: Integer;
    function UltimaCoordenadaGPX : IRastreamento;
    procedure ExportarRotaGPX(tpRota: ITipoRota; strGPX: String; intTempo: integer; fltDistancia: double);
    procedure RecalcularRotaEfetuada;
    procedure CarregaOcorrenciasRomaneio;
    procedure CarregaDocumentos;
    procedure CarregaRastreamentos;
    procedure CarregaRotasGPX;
    procedure LimparRotasGPX;
    function OpcaoCaminho: String;
    procedure AdicionarTarefa;
    function Transportadora: ITransportadora;
    function OperadorRomaneio: String;
    function OperadorSolicitante: String;
    function NumeroBox: String;
    function Cancelado: Boolean;
    procedure AlteraStatusRotaEfetuada;
    function RotaRecalculada: Boolean;
  end;

  TConversa = class(TInterfacedObject, IConversa)
  private
    FAutoincrem: String;
    FMensagem: AnsiString;
    FDestinatario: String;
    FRemetente: String;
    FDataHora: TDateTime;
    FComunicacaoVia: String;
  protected
    constructor Create(strAutInc, strDestinatario, strRemetente, strComunicacaoVia: String;
    ansMensagem: AnsiString; dtaDtaHora: TDateTime);
  public
    function Autoincrem: String;
    function Mensagem: AnsiString;
    function Destinatario: String;
    function Remetente: String;
    function DataHora: TDateTime;
    function ComunicacaoVia: String;
  end;

  TContato = class(TInterfacedObject, IContato)
  private
    FCodigoContato: String;
    FNomeContato: String;
    FQuantidadeMensagensNaoLidas: Integer;
    FConversa: TList<IConversa>;
    FUltimaMensagem: String;
    FDataHoraUltimaMensagem: TDatetime;
  protected
    constructor Create(strCodigoContato, strNomeContato, strUltimaMsg: String; intQuantidadeMensagensNaoLidas: Integer;
                       dtaDataHoraUltimaMsg: TDatetime);
  public
    destructor Destroy; override;
    function CodigoContato: String;
    function NomeContato: String;
    function QuantidadeMensagensNaoLidas: Integer;
    function Conversas: TList<IConversa>;
    function UltimaMensagem: String;
    function DataHoraUltimaMensagem: TDatetime;

    procedure CarregaConversa(strCodOpe: String);
    procedure EnviarMensagem(strCodOpe: String; ansMensagem: AnsiString);
  end;

  TChat = class(TInterfacedObject, IChat)
  private
    FContatos: TList<IContato>;
    FContatosRecentes: TList<IContato>;
    FQuantidadeNovasMensagens: Integer;

    procedure pCarregaContatos(blnContatosRecentes: Boolean; strCodOpe: String);
  protected
    constructor Create(strCodOpe: String);
  public
    destructor Destroy; override;
    function Contatos: TList<IContato>;
    function ContatosRecentes: TList<IContato>;
    function QuantidadeNovasMensagens: Integer;
    procedure VerificaNovasMensagens(strCodOpe: String);
  end;

  TPendencia = class(TInterfacedObject, IPendencia)
  private
    FDocsComItensBaixadosParcialmente: TList<IDocumento>;

    procedure CarregarDocsComItensBaixadosParcialmente(const strFiltro: String);
    function fAnalisaItensNoRomaneio(Documento: IDocumento; qryRomGerX, qryRomDetX: IMyQuery): Boolean;
  protected
    constructor Create(const strFiltro: String);
  public
    destructor Destroy; override;
    function DocsComItensBaixadosParcialmente: TList<IDocumento>;
    function LiberarItensBaixadosParcialmenteParaNovoRomaneio(Documento: IDocumento): Boolean;
    function LiberarItensBaixadosParcialmenteParaDevolucao(Documento: IDocumento): Boolean;
    function LiberarItensBaixadosParcialmente(Documento: IDocumento; blnStartTransaction: Boolean = True): Boolean;
  end;

  TRotaGPX = class(TInterfacedObject, IRotaGPX)
  private
    FTipoRota : ITipoRota;
    FDistancia : Double;
    FTempo : Integer;
    FGPXfile : String;
  protected
    constructor Create(tpRota: ITipoRota; strGPX: String; fltDistancia: Double; intTempo: Integer);
  public
    function TipoRota: ITipoRota;
    function Distancia: Double;
    function Tempo: Integer;
    function GPXFile: String;
  end;

  TTaEntregue = class(TInterfacedObject, ITaEntregue)
  private
    FRomaneios: TList<IRomaneio>;
    FMotoristas: TList<IMotorista>;
    FPendencias: TList<IPendencia>;

    function fRetRomaneios(strFiltro: String; strExceto: String; dtaDtaDe, dtaDtaAte: TDate): IMyQuery;
  public
    destructor Destroy; override;
    procedure pGravaLogUsoGoogleMaps(strNumRom, strAtividade: String);
    function fGetRomaneios(strFiltro: String; strExceto: String; dtaDtaDe, dtaDtaAte: TDate): TList<IRomaneio>;
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

  Const
    SQL_ULTROMMSG : String = '(SELECT MAX(AUTOINCREM) FROM ROMMSG MS WHERE MS.MSG_SEQGER = G.AUTOINCREM)';

implementation

uses
  untFuncoesSimples, untImagemBase64, untFuncoes, untRomGer, untLiberacao,
  untFatVendas, untMaplinkPlanning,
  untFatRomOutEntregas, untGeocodeRomaneio;

{ TTaEntregue }

destructor TTaEntregue.Destroy;
begin
  if Assigned(FRomaneios) then
    FreeAndNil(FRomaneios);

  if Assigned(FMotoristas) then
    FreeAndNil(FMotoristas);

  if Assigned(FPendencias) then
    FreeAndNil(FPendencias);

  inherited;
end;

function TTaEntregue.fCriaMsgLiberacao(DirAcesso, Mensagem: String): Boolean;
Var
  objLiberacao : TLiberacao;
begin
  objLiberacao := TLiberacao.Create;
  try
    objLiberacao.Clear;
    objLiberacao.strDirAce    := DirAcesso;
    objLiberacao.strMsgSen    := Mensagem;
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;

    objLiberacao.objMsgLibera.pAddTexto(objLiberacao.strMsgSen );

    Result := objLiberacao.fLibera;

  finally
    FreeAndNil(objLiberacao);
  end;
end;

function TTaEntregue.fGetRomaneios(strFiltro: String; strExceto: String; dtaDtaDe, dtaDtaAte: TDate): TList<IRomaneio>;
var
  qryRomaneios: IMyQuery;
begin
  if Assigned(FRomaneios) then
    FreeAndNil(FRomaneios);

  FRomaneios := TList<IRomaneio>.Create;

  qryRomaneios := fRetRomaneios(strFiltro, strExceto, dtaDtaDe, dtaDtaAte);
  while not qryRomaneios.Eof do
  begin
    FRomaneios.Add(TRomaneio.Create(qryRomaneios.FieldByName('GER_NUMROM').AsString,
                                    qryRomaneios.FieldByName('OCR_NIVPRI').AsInteger));
    qryRomaneios.Next;
  end;

  Result := FRomaneios;
end;

function TTaEntregue.fHabilitaAtualizacaoAutomatica: Boolean;
begin
  Result := fCfgSis('RFATPE') = 'S';
end;

function TTaEntregue.fMensagem(strTitulo: String;
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
begin
  Result := untFuncoesSimples.fMensagem(strTitulo,
                                        strTexto,
                                        arrOpcoes,
                                        intFocoBotao,
                                        blnSaiComEsc,
                                        intEstFon,
                                        intWidBut,
                                        blnAutosize,
                                        intSomarTop,
                                        blnObrigaEsc,
                                        blnOcultPainelBtn,
                                        blnBtnSemImg,
                                        intHeightOpc,
                                        intFormWidth);
end;

procedure TTaEntregue.pGravaLogUsoGoogleMaps(strNumRom, strAtividade: String);
Var
  qryLog : TUniQuery;
  strAutInc : String;
begin
  If (fEmptyStr(strNumRom)) Then
    Exit;

  qryLog := fCriaQuery;

  try
    qryLog.Close;
    qryLog.SQL.Text :=
    ' INSERT INTO LOGMAP '+
    '  (AUTOINCREM, '+
    '   LOG_EMPROM, '+
    '   LOG_NUMROM, '+
    '   LOG_DTAHOR, '+
    '   LOG_CODOPE, '+
    '   LOG_ATIVID) '+
    ' VALUES '+
    '  (:AUTINC, '+
    '   :EMPROM, '+
    '   :NUMROM, '+
    '   :DTAHOR, '+
    '   :CODOPE, '+
    '   :ATIVID) ';

    strAutInc := fRetAutoIncrem('LOGMAP', VS_strCodEmp);

    qryLog.ParamByName('AUTINC').AsString   := strAutInc;
    qryLog.ParamByName('EMPROM').AsString   := VS_strCodEmp;
    qryLog.ParamByName('NUMROM').AsString   := strNumRom;
    qryLog.ParamByName('DTAHOR').AsDateTime := fNow;
    qryLog.ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
    qryLog.ParamByName('ATIVID').AsString   := strAtividade;
    qryLog.ExecSql;

  Finally
    FreeAndNil(qryLog);
  End;
end;

function TTaEntregue.fRetRomaneios(strFiltro: String; strExceto: String; dtaDtaDe, dtaDtaAte: TDate): IMyQuery;
var
  qryRomaneios: IMyQuery;
  strSQLBase, strNivPri: string;
begin
  // Subselect do nível de prioridade
  strNivPri :=
    ' (SELECT ' +
    '    MAX(IF(M.MSG_RESOLV = "S", -1, O.OCR_NIVPRI)) AS OCR_NIVPRI '+
    '  FROM ' +
    '    ROMMSG M ' +
    '    LEFT JOIN ROMGERX G ON M.MSG_SEQGER = G.AUTOINCREM ' +
    '    LEFT JOIN OCOROM  O ON M.MSG_SEQOCR = O.AUTOINCREM ' +
    '  WHERE M.MSG_NUMROM = R.GER_NUMROM ' +
    '    AND M.MSG_EMPROM = R.GER_EMPROM ' +
    '    AND M.AUTOINCREM = ' + SQL_ULTROMMSG + ') ';

  // SQL base (sem ORDER BY)
  strSQLBase :=
    ' SELECT ' +
    '   R.GER_NUMROM, ' +
    '   IFNULL(SQL_NIVPRI, -1) AS OCR_NIVPRI ' +
    ' FROM ' +
    '   ROMGERX R ' +
    '   LEFT JOIN CADMOT M ON R.GER_CODMOT = M.MOT_CODMOT ' +
    '   LEFT JOIN CADCLI C ON R.GER_CODCLI = C.CLI_CODCLI ' +
    ' WHERE ' +
    '   R.GER_LIBAPP = "S" AND ' +
    IIF(fCfgSis('VENARO', varBoolean), '', ' IFNULL(R.GER_LOCALI, "") <> "" AND ') +
    '   R.GER_EMPROM = :EMPROM AND ' +
    '   R.GER_DTAROM BETWEEN :DTADE AND :DTAATE ' +
    IIF(not fEmptyStr(strFiltro),
       ' AND ( '+
       '       M.MOT_NOMMOT LIKE :FILTRO OR '+
       '       R.GER_NUMROM LIKE :FILTRO OR '+
       '       R.GER_NUMDOC LIKE :FILTRO OR '+
       '       R.GER_NOMCON LIKE :FILTRO OR '+
       '       C.CLI_NOMCLI LIKE :FILTRO '+
       '      ) ',
       '')+
    ' GROUP BY '+
    '   R.GER_NUMROM '+

    IIF(not fEmptyStr(strExceto),
       ' HAVING MAX( '+
       '       IFNULL(M.MOT_NOMMOT, "") LIKE :EXCETO OR '+
       '       IFNULL(R.GER_NUMROM, "") LIKE :EXCETO OR '+
       '       IFNULL(R.GER_NUMDOC, "") LIKE :EXCETO OR '+
       '       IFNULL(R.GER_NOMCON, "") LIKE :EXCETO OR '+
       '       IFNULL(C.CLI_NOMCLI, "") LIKE :EXCETO '+
       '            ) = 0 ',
       '');

  // Adiciona a parte da DEL_ROMGERX e substitui o marcador SQL_NIVPRI
  strSQLBase := strSQLBase + ' UNION ALL ' + AnsiReplaceStr(strSQLBase, 'ROMGERX', 'DEL_ROMGERX');
  strSQLBase := AnsiReplaceStr(strSQLBase, 'SQL_NIVPRI', strNivPri);

  // Monta query final (usa tabela temporária e depois ordena)
  qryRomaneios := objCore.fCriarQuery;
  qryRomaneios.Close;
  qryRomaneios.SQL.Clear;

  qryRomaneios.SQL.Add('DROP TEMPORARY TABLE IF EXISTS TEMP_ROMANEIOS;');
  qryRomaneios.SQL.Add('CREATE TEMPORARY TABLE TEMP_ROMANEIOS (');
  qryRomaneios.SQL.Add('  GER_NUMROM VARCHAR(20),');
  qryRomaneios.SQL.Add('  OCR_NIVPRI INT');
  qryRomaneios.SQL.Add(');');

  qryRomaneios.SQL.Add('INSERT INTO TEMP_ROMANEIOS (GER_NUMROM, OCR_NIVPRI)');
  qryRomaneios.SQL.Add(strSQLBase + ';');

  qryRomaneios.SQL.Add('CREATE INDEX IDX_TEMP_NIV ON TEMP_ROMANEIOS (OCR_NIVPRI DESC, GER_NUMROM);');

  qryRomaneios.SQL.Add('SELECT GER_NUMROM, OCR_NIVPRI');
  qryRomaneios.SQL.Add('FROM TEMP_ROMANEIOS');
  qryRomaneios.SQL.Add('GROUP BY GER_NUMROM, OCR_NIVPRI');
  qryRomaneios.SQL.Add('ORDER BY OCR_NIVPRI DESC, GER_NUMROM;');

  qryRomaneios.ParamByName('EMPROM').AsString := VS_strCodEmp;
  qryRomaneios.ParamByName('DTADE').AsDate := dtaDtaDe;
  qryRomaneios.ParamByName('DTAATE').AsDate := dtaDtaAte;
  if not fEmptyStr(strFiltro) then
    qryRomaneios.ParamByName('FILTRO').AsString := '%' + Trim(strFiltro) + '%';

  if not fEmptyStr(strExceto) then
    qryRomaneios.ParamByName('EXCETO').AsString := '%' + Trim(strExceto) + '%';

  qryRomaneios.Open;

  Result := qryRomaneios;
end;


function TTaEntregue.fCountPendencias: Integer;
var
  qryPen: TUniQuery;
begin
  Result := 0;

  qryPen := fCriaQuery;
  try
    qryPen.Close;
    qryPen.SQL.Text :=
    ' SELECT '+
    '   COUNT(*) AS TOTPEN '+
    ' FROM '+
    '   ROMGERX R '+
    '   INNER JOIN ROMDETX D ON R.AUTOINCREM = D.DET_SEQGER '+
    ' WHERE R.GER_DTABAI IS NOT NULL '+
    '   AND D.DET_QTDROM <> D.DET_QTDBAI '+
    '   AND R.GER_EMPROM = :EMPROM '+
    '   AND D.DET_LIBERA = "N" '+
    '   AND R.GER_BAIAPP = "S" '+
    ' ORDER BY GER_DTABAI, GER_HORBAI ';

    qryPen.ParamByName('EMPROM').AsString := VS_strCodEmp;
    qryPen.Open;

    If Not qryPen.IsEmpty Then
      Result := qryPen.FieldByName('TOTPEN').AsInteger;

  finally
    FreeAndNil(qryPen);
  end;
end;

function TTaEntregue.fGetChat(strCodOpe: String): IChat;
begin
  Result := TChat.Create(strCodOpe);
end;

function TTaEntregue.fGetMotoristas(strFiltro: String): TList<IMotorista>;
var
  qryMotoristas: IMyQuery;
begin
  if Assigned(FMotoristas) then
    FreeAndNil(FMotoristas);

  FMotoristas := TList<IMotorista>.Create;

  qryMotoristas := objCore.fCriarQuery;
  qryMotoristas.Close;
  qryMotoristas.SQL.Text :=
  ' SELECT '+
  '   MOT_CODMOT, '+
  '   MOT_NOMMOT '+
  ' FROM '+
  '   CADMOT '+
  ' WHERE '+
  '   MOT_CODMOT LIKE :FILTRO OR '+
  '   MOT_NOMMOT LIKE :FILTRO ';

  qryMotoristas.ParamByName('FILTRO').AsString := '%'+strFiltro+'%';
  qryMotoristas.Open;

  while not qryMotoristas.Eof do
  begin
    FMotoristas.Add(TMotorista.Create(qryMotoristas.FieldByName('MOT_CODMOT').AsString,
                                      qryMotoristas.FieldByName('MOT_NOMMOT').AsString));

    qryMotoristas.Next;
  end;

  Result := FMotoristas;
end;

function TTaEntregue.fGetPendencias(const strFiltro: String): IPendencia;
begin
  Result := TPendencia.Create(strFiltro);
end;

function TTaEntregue.fGetLocalizacao(strCodMot: String): IRastreamento;
var
  qryLocalizacao: IMyQuery;
begin
  Result := nil;

  qryLocalizacao := objCore.fCriarQuery;
  qryLocalizacao.Close;
  qryLocalizacao.SQL.Text :=
  ' SELECT '+
  '   REPLACE(R.RAS_LATLON, " ", "") AS RAS_LATLON, '+
  '   R.RAS_DTAHOR '+
  ' FROM '+
  '   RASROM R '+
  ' INNER JOIN CADMOT M '+
  '   ON R.RAS_SEQMOT = M.AUTOINCREM AND '+
  '      M.MOT_MONMOT = "S"'+
  ' WHERE '+
  '   M.MOT_CODMOT = :CODMOT '+
  ' ORDER BY '+
  '   RAS_DTAHOR DESC '+
  ' LIMIT 1 ';

  qryLocalizacao.ParamByName('CODMOT').AsString := strCodMot;
  qryLocalizacao.Open;

  if not qryLocalizacao.IsEmpty then
    Result := TRastreamento.Create(qryLocalizacao.FieldByName('RAS_LATLON').AsString,
                                   StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                                 StrToDateTime(qryLocalizacao.FieldByName('RAS_DTAHOR').AsString))));

end;

{ TRomaneio }

procedure TRomaneio.pCarregaRastreamentos(dtaBaixaRomaneio : TDateTime = 0);
var
  qryRastreamentos: IMyQuery;
  strFiltro : String;
begin
  strFiltro := '';

  If (dtaBaixaRomaneio > 0) Then
    strFiltro := ' AND R.RAS_DTAHOR <= ' + QuotedStr(FormatDateTime('yyyy-MM-dd hh:mm:ss', dtaBaixaRomaneio));

  qryRastreamentos := objCore.fCriarQuery;
  qryRastreamentos.Close;
  qryRastreamentos.SQL.Text :=
  ' SELECT '+
  '   REPLACE(R.RAS_LATLON, " ", "") AS RAS_LATLON, '+
  '   MAX(R.RAS_DTAHOR) AS RAS_DTAHOR,  '+
  '   R.RAS_EXPGPX '+
  ' FROM '+
  '   RASROM R '+
  ' INNER JOIN CADMOT M '+
  '   ON R.RAS_SEQMOT = M.AUTOINCREM AND '+
  '      M.MOT_MONMOT = "S"'+
  ' WHERE '+
  '   R.RAS_NUMROM = :NUMROM AND '+
  '   R.RAS_EMPROM = :EMPROM ' + strFiltro +
  ' GROUP BY RAS_LATLON, DATE(R.RAS_DTAHOR), RAS_EXPGPX '+
  ' ORDER BY RAS_DTAHOR LIMIT 1000 ';

  qryRastreamentos.ParamByName('NUMROM').AsString := NumeroRomaneio;
  qryRastreamentos.ParamByName('EMPROM').AsString := EmpresaRomaneio;
  qryRastreamentos.Open;

  If Not qryRastreamentos.IsEmpty Then
  Begin
    qryRastreamentos.First;

    If Not Assigned(FPontoPartida) Then
      FPontoPartida := TRastreamento.Create(qryRastreamentos.FieldByName('RAS_LATLON').AsString,
                                            StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                          StrToDateTime(qryRastreamentos.FieldByName('RAS_DTAHOR').AsString))));

    FRastreamentos.Clear;
    while not qryRastreamentos.Eof do
    begin
      If (qryRastreamentos.FieldByName('RAS_EXPGPX').AsString = 'N') Then
        FRastreamentos.Add(TRastreamento.Create(qryRastreamentos.FieldByName('RAS_LATLON').AsString,
                                                StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                                      StrToDateTime(qryRastreamentos.FieldByName('RAS_DTAHOR').AsString)))));
      qryRastreamentos.Next;
    end;

    qryRastreamentos.Last;
    FPontoMotorista := TRastreamento.Create(qryRastreamentos.FieldByName('RAS_LATLON').AsString,
                                          StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                        StrToDateTime(qryRastreamentos.FieldByName('RAS_DTAHOR').AsString))));
  End;
end;

procedure TRomaneio.pCarregaRotasGPX;
var
  qryRotasGPX: TUniQuery;
begin
  qryRotasGPX := fCriaQuery;

  try
    qryRotasGPX.Close;
    qryRotasGPX.SQL.Text :=
    ' SELECT '+
    '   R.RAS_TIPROT, '+
    '   R.RAS_DISTAN, '+
    '   R.RAS_TEMPO_, '+
    '   R.RAS_G_P_X_ '+
    ' FROM '+
    '   RASGPX R '+
    ' WHERE '+
    '   R.RAS_NUMROM = :NUMROM AND '+
    '   R.RAS_EMPROM = :EMPROM ' +
    ' ORDER BY R.RAS_TIPROT ';

    qryRotasGPX.ParamByName('NUMROM').AsString := NumeroRomaneio;
    qryRotasGPX.ParamByName('EMPROM').AsString := EmpresaRomaneio;
    qryRotasGPX.Open;

    FRotasGPX.Clear;
    while not qryRotasGPX.Eof do
    begin
      FRotasGPX.Add(TRotaGPX.Create(ITipoRota(qryRotasGPX.FieldByName('RAS_TIPROT').AsInteger),
                                    qryRotasGPX.FieldByName('RAS_G_P_X_').AsString,
                                    qryRotasGPX.FieldByName('RAS_DISTAN').AsFloat,
                                    qryRotasGPX.FieldByName('RAS_TEMPO_').AsInteger));
      qryRotasGPX.Next;
    end;
  finally
    FreeAndNil(qryRotasGPX);
  end;
end;

function TRomaneio.Cancelado: Boolean;
begin
  Result := FCancelado;
end;

procedure TRomaneio.CarregaDocumentos;
begin
  pCarregaDocumentos;
end;

procedure TRomaneio.CarregaOcorrenciasRomaneio;
begin
  pCarregaOcorrenciasRomaneio;
end;

procedure TRomaneio.CarregaRastreamentos;
begin
  pCarregaRastreamentos(FDataHoraBaixaRomaneio);
end;

procedure TRomaneio.CarregaRotasGPX;
begin
  pCarregaRotasGPX;
end;

constructor TRomaneio.Create(strNumRom: String; intNivPri: Integer);
var
  qryRomaneio: IMyQuery;
  strSQL: String;
  LTemPendencia: Boolean;
begin
  LTemPendencia := False;

  strSQL :=
  ' SELECT '+
  '   G.GER_SEQATV, '+
  '   G.GER_NUMROM, '+
  '   G.GER_EMPROM, '+
  '   G.GER_CODMOT, '+
  '   M.MOT_NOMMOT, '+
  '   G.GER_DTAROM, '+
  '   G.GER_HORROM, '+
  '   G.GER_DTAINI, '+
  '   G.GER_HORINI, '+
  '   G.GER_DTABAI, '+
  '   G.GER_HORBAI, '+
  '   G.GER_PLAVEI, '+
  '   G.GER_INIPAR, '+
  '   G.GER_FINROT, '+
  '   G.GER_FSTSHT, '+
  '   G.GER_OPEROM, '+
  '   G.GER_OPESOL, '+
  '   G.GER_NUMBOX, '+
  '  MC.MAR_DESMAR, '+
  '  MD.MOD_DESMOD, '+
  ' (SELECT COUNT(MSG_SEQGER) FROM ROMMSG '+
  '   WHERE MSG_NUMROM = G.GER_NUMROM '+
  '     AND MSG_EMPROM = G.GER_EMPROM) AS QTDOCO, '+
  '   C.COR_DESCOR, '+
  '   IFNULL(RR.RET_DISTAN,0) AS RET_DISTAN, '+
  '   IFNULL(RR.RET_TMPRET,0) AS RET_TMPRET, '+
  '   G.GER_CODTRA, '+
  '   T.TRA_NOMTRA, '+
  '   G.GER_ORDIMP, '+
  '  (SELECT DISTINCT '+
  '     IFNULL(O.OCR_TIPOCR, "") '+
  '   FROM '+
  '     ROMMSG M LEFT JOIN OCOROM O ON M.MSG_SEQOCR = O.AUTOINCREM '+
  '   WHERE M.MSG_SEQGER = G.AUTOINCREM '+
  '     AND M.AUTOINCREM = '+ SQL_ULTROMMSG +') AS OCR_TIPOCR, '+
  '   "ROMGERX" AS NOMTAB '+
  '   FROM '+
  '   ROMGERX G '+
  ' LEFT JOIN CADMOT M '+
  '   ON G.GER_CODMOT = M.MOT_CODMOT '+
  ' LEFT JOIN CADVEI V '+
  '   ON G.GER_PLAVEI = V.VEI_PLAVEI '+
  ' LEFT JOIN MARVEI MC '+
  '   ON V.VEI_CODMAR = MC.MAR_CODMAR '+
  ' LEFT JOIN MODVEI MD '+
  '   ON V.VEI_CODMOD = MD.MOD_CODMOD '+
  ' LEFT JOIN CORVEI C '+
  '   ON V.VEI_CODCOR = C.COR_CODCOR '+
  ' LEFT JOIN ROMRET RR '+
  '   ON G.GER_NUMROM = RR.RET_NUMROM AND G.GER_EMPROM = RR.RET_EMPROM '+
  ' LEFT JOIN CADTRA T '+
  '   ON G.GER_CODTRA = T.TRA_CODTRA '+
  ' WHERE '+
  '   GER_NUMROM = :NUMROM AND '+
  '   GER_EMPROM = :EMPROM ';

  strSQL := strSQL + ' UNION ' + AnsiReplaceStr(strSQL, 'ROMGERX', 'DEL_ROMGERX');

  qryRomaneio := objCore.fCriarQuery;
  qryRomaneio.Close;
  qryRomaneio.SQL.Text :=
  ' SELECT '+
  '   GER_SEQATV, '+
  '   GER_NUMROM, '+
  '   GER_EMPROM, '+
  '   GER_CODMOT, '+
  '   MOT_NOMMOT, '+
  '   GER_DTAROM, '+
  '   GER_HORROM, '+
  '   GER_DTAINI, '+
  '   GER_HORINI, '+
  '   GER_DTABAI, '+
  '   GER_HORBAI, '+
  '   GER_PLAVEI, '+
  '   GER_INIPAR, '+
  '   GER_FINROT, '+
  '   GER_FSTSHT, '+
  '   GER_OPEROM, '+
  '   GER_OPESOL, '+
  '   GER_NUMBOX, '+
  '   MAR_DESMAR, '+
  '   MOD_DESMOD, '+
  '   QTDOCO    , '+
  '   COR_DESCOR, '+
  '   RET_DISTAN, '+
  '   RET_TMPRET, '+
  '   GER_CODTRA, '+
  '   TRA_NOMTRA, '+
  '   GER_ORDIMP, '+
  '   OCR_TIPOCR, '+
  '   NOMTAB      '+
  ' FROM ( '+strSQL+') AS ROMANEIO'+
  ' ORDER BY '+
  '   GER_NUMROM, '+
  '   ISNULL(GER_DTAINI), '+
  '   GER_DTAINI, '+
  '   GER_HORINI, '+
  '   ISNULL(GER_DTABAI), '+
  '   GER_DTABAI, '+
  '   GER_HORBAI, '+
  '   GER_ORDIMP  ';

  qryRomaneio.ParamByName('NUMROM').AsString := strNumRom;
  qryRomaneio.ParamByName('EMPROM').AsString := VS_strCodEmp;
  qryRomaneio.Open;

  FSequencialAtivacao := qryRomaneio.FieldByName('GER_SEQATV').AsString;
  FNumeroRomaneio := qryRomaneio.FieldByName('GER_NUMROM').AsString;
  FEmpresaRomaneio := qryRomaneio.FieldByName('GER_EMPROM').AsString;
  FQuantidadeEntregas := qryRomaneio.RecordCount;

  FQuantidadeOcorrencias := qryRomaneio.FieldByName('QTDOCO').AsInteger;

  FDataHoraRomaneio := StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                    StrToDateTime(qryRomaneio.FieldByName('GER_DTAROM').AsString + ' ' +
                                                                  qryRomaneio.FieldByName('GER_HORROM').AsString))
                                     );

  qryRomaneio.First;
  if not fEmptyStr(qryRomaneio.FieldByName('GER_DTAINI').AsString) then
    FDataHoraInicioRomaneio := StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                            StrToDateTime(qryRomaneio.FieldByName('GER_DTAINI').AsString + ' ' +
                                                                          qryRomaneio.FieldByName('GER_HORINI').AsString))
                                             );

  qryRomaneio.Last;
  if not fEmptyStr(qryRomaneio.FieldByName('GER_DTABAI').AsString) then
    FDataHoraBaixaRomaneio := StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                            StrToDateTime(qryRomaneio.FieldByName('GER_DTABAI').AsString + ' ' +
                                                                          qryRomaneio.FieldByName('GER_HORBAI').AsString))
                                            );

  FStatusRomaneio := rmNaoIniciado;

  FNivelPrioridade := intNivPri;

  qryRomaneio.First;
  while not qryRomaneio.Eof do
  begin
    if not fEmptyStr(qryRomaneio.FieldByName('GER_DTAINI').AsString) then
    begin
      FStatusRomaneio := rmACaminho;
      Break;
    end;
    qryRomaneio.Next;
  end;

  FQuantidadeEntregasConcluidas := 0;

  FCancelado := True;

  qryRomaneio.First;
  while not qryRomaneio.Eof do
  begin
    If (qryRomaneio.FieldByName('NOMTAB').AsString = 'ROMGERX') Then
      FCancelado := False;

    if (not fEmptyStr(qryRomaneio.FieldByName('GER_DTABAI').AsString)) then
      FQuantidadeEntregasConcluidas := FQuantidadeEntregasConcluidas+1;

    if (Not LTemPendencia) And
       (qryRomaneio.FieldByName('OCR_TIPOCR').AsString = 'N') Then
      LTemPendencia := True;

    qryRomaneio.Next;
  end;

  if FQuantidadeEntregasConcluidas = FQuantidadeEntregas then
  begin
    if LTemPendencia Then
      FStatusRomaneio := rmTemPendencia
    else
      FStatusRomaneio := rmFinalizado;
  end;

  FMotorista := TMotorista.Create(qryRomaneio.FieldByName('GER_CODMOT').AsString,
                                  qryRomaneio.FieldByName('MOT_NOMMOT').AsString);

  qryRomaneio.First;
  FVeiculo := TVeiculo.Create(qryRomaneio.FieldByName('MAR_DESMAR').AsString,
                              qryRomaneio.FieldByName('MOD_DESMOD').AsString,
                              qryRomaneio.FieldByName('GER_PLAVEI').AsString,
                              qryRomaneio.FieldByName('COR_DESCOR').AsString);
  qryRomaneio.Last;

  if not fEmptyStr(qryRomaneio.FieldByName('GER_INIPAR').AsString) then
    FPontoPartida := TRastreamento.Create(qryRomaneio.FieldByName('GER_INIPAR').AsString,
                                          FDataHoraInicioRomaneio);

  if not fEmptyStr(qryRomaneio.FieldByName('GER_FINROT').AsString) then
    FPontoChegada := TRastreamento.Create(qryRomaneio.FieldByName('GER_FINROT').AsString,
                                          FDataHoraInicioRomaneio);

  FDistanciaRetorno := qryRomaneio.FieldByName('RET_DISTAN').AsFloat;
  FTempoRetorno     := qryRomaneio.FieldByName('RET_TMPRET').AsInteger;

  FAlertas := TList<IAlerta>.Create;
  pCarregaAlertasMotivosDePausa;

  FOcorrencias := TList<IOcorrencia>.Create;
  FDocumentos := TList<IDocumento>.Create;
  FRastreamentos := TList<IRastreamento>.Create;
  FRotasGPX := TList<IRotaGPX>.Create;

  FUltimaCoordenadaGPX := fRetUltimaCoordenadaGPX;

  FOpcaoCaminho := qryRomaneio.FieldByName('GER_FSTSHT').AsString;

  FTransportadora := TTransportadora.Create(qryRomaneio.FieldByName('GER_CODTRA').AsString,
                                            qryRomaneio.FieldByName('TRA_NOMTRA').AsString);

  FOperadorRomaneio := qryRomaneio.FieldByName('GER_OPEROM').AsString;
  FOperadorSolicitante := qryRomaneio.FieldByName('GER_OPESOL').AsString;
  FNumeroBox := qryRomaneio.FieldByName('GER_NUMBOX').AsString;
end;

procedure TRomaneio.AdicionarTarefa;
const
  SQL_ROMGERX = ' INSERT INTO ROMGERX '+
                '  (AUTOINCREM, '+
                '   GER_NUMROM, '+
                '   GER_CODEMP, '+
                '   GER_NUMDOC, '+
                '   GER_ESPDOC, '+
                '   GER_CODVEN, '+
                '   GER_CODTRA, '+
                '   GER_TIP_FC, '+
                '   GER_DTAENT, '+
                '   GER_HORENT, '+
                '   GER_VLRCON, '+
                '   GER_PESBRU, '+
                '   GER_MEN001, '+
                '   GER_CODMOT, '+
                '   GER_DTAROM, '+
                '   GER_HORROM, '+
                '   GER_CODREG, '+
                '   GER_ORDIMP, '+
                '   GER_OPESOL, '+
                '   GER_EMPROM, '+
                '   GER_OPEROM, '+
                '   GER_PLAVEI, '+
                '   GER_ENTSAI, '+
                '   GER_NOMTAB, '+
                '   GER_NUMBOX, '+
                '   GER_STATUS, '+
                '   GER_AUTINC, '+
                '   GER_LIBAPP, '+
                '   GER_LOCALI, '+
                '   GER_ENDENT, '+
                '   GER_BAIENT, '+
                '   GER_CEPENT, '+
                '   GER_CIDENT, '+
                '   GER_REFENT, '+
                '   GER_INIPAR, '+
                '   GER_FINROT, '+
                '   GER_FSTSHT) '+
                ' VALUES '+
                '  (:AUTOIN, '+
                '   :NUMROM, '+
                '   :CODEMP, '+
                '   :NUMDOC, '+
                '   :ESPDOC, '+
                '   :CODVEN, '+
                '   :CODTRA, '+
                '   :TIP_FC, '+
                '   :DTAENT, '+
                '   :HORENT, '+
                '   :VLRCON, '+
                '   :PESBRU, '+
                '   :MEN001, '+
                '   :CODMOT, '+
                '   :DTAROM, '+
                '   :HORROM, '+
                '   :CODREG, '+
                '   :ORDIMP, '+
                '   :OPESOL, '+
                '   :EMPROM, '+
                '   :OPEROM, '+
                '   :PLAVEI, '+
                '   :ENTSAI, '+
                '   :NOMTAB, '+
                '   :NUMBOX, '+
                '   :STATUS, '+
                '   :AUTINC, '+
                '   :LIBAPP, '+
                '   :LOCALI, '+
                '   :ENDENT, '+
                '   :BAIENT, '+
                '   :CEPENT, '+
                '   :CIDENT, '+
                '   :REFENT, '+
                '   :INIPAR, '+
                '   :FINROT, '+
                '   :FSTSHT) ';

  SQL_REOROM = ' INSERT INTO REOROM '+
               '  (AUTOINCREM, '+
               '   REO_NUMROM, '+
               '   REO_EMPROM, '+
               '   REO_SEQGER, '+
               '   REO_DTHRIS, '+
               '   REO_EXECUT) '+
               ' VALUES '+
               '  (:AUTINC, '+
               '   :NUMROM, '+
               '   :EMPROM, '+
               '   :SEQGER, '+
               '   :DTHRIS, '+
               '   :EXECUT) ';
var
  qryTarefa: IMyQuery;
begin
  qryTarefa := objCore.fCriarQuery;

  pCriarFormularios(TfrmFatRomOutEntregas, frmFatRomOutEntregas);
  try
    try
      frmFatRomOutEntregas.FNumRom := NumeroRomaneio;
      frmFatRomOutEntregas.FEmpRom := EmpresaRomaneio;
      frmFatRomOutEntregas.FDtaRom := DataHoraRomaneio;
      frmFatRomOutEntregas.FOpeRom := OperadorRomaneio;

      frmFatRomOutEntregas.ShowModal;

      if frmFatRomOutEntregas.fcdsOutEnt.IsEmpty then
        Exit;

      fStartTransaction;

      frmFatRomOutEntregas.fcdsOutEnt.First;
      while not frmFatRomOutEntregas.fcdsOutEnt.Eof do
      begin
        //ROMGERX
        qryTarefa.Close;
        qryTarefa.SQL.Text := SQL_ROMGERX;
        qryTarefa.ParamByName('AUTOIN').AsString   := fRetAutoIncrem('ROMGERX', VS_strCodEmp);
        qryTarefa.ParamByName('NUMROM').AsString   := NumeroRomaneio;
        qryTarefa.ParamByName('CODEMP').AsString   := frmFatRomOutEntregas.fcdsOutEnt.FieldByName('DIG_CODEMP').AsString;
        qryTarefa.ParamByName('NUMDOC').AsString   := frmFatRomOutEntregas.fcdsOutEnt.FieldByName('DIG_NUMDOC').AsString;
        qryTarefa.ParamByName('ESPDOC').AsString   := frmFatRomOutEntregas.fcdsOutEnt.FieldByName('DIG_ESPDOC').AsString;
        qryTarefa.ParamByName('CODVEN').AsString   := frmFatRomOutEntregas.fcdsOutEnt.FieldByName('DIG_CODVEN').AsString;
        qryTarefa.ParamByName('CODTRA').Value      := Null;
        if not fEmptyStr(Transportadora.CodigoTransportadora) then
          qryTarefa.ParamByName('CODTRA').AsString   := Transportadora.CodigoTransportadora;
        qryTarefa.ParamByName('TIP_FC').AsString   := 'C';
        qryTarefa.ParamByName('DTAENT').AsDateTime := fRetDataServidor;
        qryTarefa.ParamByName('HORENT').AsDateTime := fRetHoraServidor;
        qryTarefa.ParamByName('VLRCON').AsFloat    := frmFatRomOutEntregas.fcdsOutEnt.FieldByName('DIG_VALDOC').AsFloat;
        qryTarefa.ParamByName('PESBRU').AsFloat    := frmFatRomOutEntregas.fcdsOutEnt.FieldByName('DIG_PESBRU').AsFloat;
        qryTarefa.ParamByName('MEN001').AsString   := frmFatRomOutEntregas.fcdsOutEnt.FieldByName('DIG_DESCRI').AsString;
        qryTarefa.ParamByName('CODMOT').AsString   := Motorista.CodigoMotorista;
        qryTarefa.ParamByName('DTAROM').AsDateTime := DataHoraRomaneio;
        qryTarefa.ParamByName('HORROM').AsDateTime := DataHoraRomaneio;

        If Not frmFatRomOutEntregas.fcdsOutEnt.FieldByName('DIG_CODREG').AsString.IsEmpty Then
          qryTarefa.ParamByName('CODREG').AsString   := frmFatRomOutEntregas.fcdsOutEnt.FieldByName('DIG_CODREG').AsString;

        qryTarefa.ParamByName('ORDIMP').AsInteger  := fRetornaOrdImpUltimaEntrega+1;
        qryTarefa.ParamByName('OPESOL').AsString   := OperadorSolicitante;
        qryTarefa.ParamByName('EMPROM').AsString   := EmpresaRomaneio;
        qryTarefa.ParamByName('OPEROM').AsString   := OperadorRomaneio;

        If Not Veiculo.PlacaVeiculo.IsEmpty Then
          qryTarefa.ParamByName('PLAVEI').AsString := Veiculo.PlacaVeiculo;

        qryTarefa.ParamByName('ENTSAI').AsString   := 'S';
        qryTarefa.ParamByName('NOMTAB').AsString   := 'OUTDIGX';
        qryTarefa.ParamByName('AUTINC').AsString   := frmFatRomOutEntregas.fcdsOutEnt.FieldByName('AUTOINCREM').AsString;
        qryTarefa.ParamByName('NUMBOX').AsString   := NumeroBox;
        qryTarefa.ParamByName('STATUS').AsString   := 'A';
        qryTarefa.ParamByName('LIBAPP').AsString   := 'S';
        qryTarefa.ParamByName('LOCALI').AsString   := EmptyStr;
        qryTarefa.ParamByName('ENDENT').AsString   := frmFatRomOutEntregas.fcdsOutEnt.FieldByName('DIG_ENDCON').AsString;
        qryTarefa.ParamByName('BAIENT').AsString   := frmFatRomOutEntregas.fcdsOutEnt.FieldByName('DIG_BAIRRO').AsString;
        qryTarefa.ParamByName('CEPENT').AsString   := frmFatRomOutEntregas.fcdsOutEnt.FieldByName('DIG_CEPCON').AsString;
        qryTarefa.ParamByName('CIDENT').AsString   := frmFatRomOutEntregas.fcdsOutEnt.FieldByName('DIG_CODCID').AsString;
        qryTarefa.ParamByName('REFENT').AsString   := frmFatRomOutEntregas.fcdsOutEnt.FieldByName('DIG_REFCON').AsString;

        If Assigned(FPontoPartida) Then
          qryTarefa.ParamByName('INIPAR').AsString := PontoPartida.Coordenadas;

        If Assigned(FPontoChegada) Then
          qryTarefa.ParamByName('FINROT').AsString := PontoChegada.Coordenadas;

        qryTarefa.ParamByName('FSTSHT').AsString   := OpcaoCaminho;
        qryTarefa.ExecSQL;

        frmFatRomOutEntregas.fcdsOutEnt.Next;
      end;

      qryTarefa.Close;
      qryTarefa.SQL.Text :=
      ' DELETE '+
      '   FROM ROMGERX '+
      ' WHERE '+
      '   GER_TIPDOC = "R" AND '+
      '   GER_NUMROM = :NUMROM AND '+
      '   GER_EMPROM = :EMPROM ';
      qryTarefa.ParamByName('NUMROM').AsString := NumeroRomaneio;
      qryTarefa.ParamByName('EMPROM').AsString := EmpresaRomaneio;
      qryTarefa.ExecSQL;

      //REOROM
      qryTarefa.Close;
      qryTarefa.SQL.Text := SQL_REOROM;
      qryTarefa.ParamByName('AUTINC').AsString := fRetAutoIncrem('REOROM', VS_strCodEmp);
      qryTarefa.ParamByName('NUMROM').AsString := NumeroRomaneio;
      qryTarefa.ParamByName('EMPROM').AsString := EmpresaRomaneio;
      qryTarefa.ParamByName('SEQGER').AsString := fRetornaAutoincremDaEntregaEmAndamento;
      qryTarefa.ParamByName('DTHRIS').AsDateTime := fRetDtaHraServidor;
      qryTarefa.ParamByName('EXECUT').AsString := 'N';
      qryTarefa.ExecSQL;

      fCommit;
    except
      on E:Exception do
      begin
        if fInTransaction then
          fRollback;

        pMensagensErro(E.Message, '[TRomaneio.pAdicionarTarefa]');
      end;
    end;
  finally
    pFreeAndNil(frmFatRomOutEntregas);
  end;
end;

function TRomaneio.DocumentoComEntregaEmAndamento: IDocumento;
var
  Documento: IDocumento;
begin
  Result := nil;

  for Documento in Documentos do
  begin
    if (Documento.DataHoraInicioEntrega > 0) and (Documento.DataHoraBaixaEntrega = 0) then
    begin
      Result := Documento;
      Break;
    end;
  end;
end;

function TRomaneio.fRetornaAutoincremDaEntregaEmAndamento: String;
var
  Documento: IDocumento;
begin
  Result := EmptyStr;

  Documento := DocumentoComEntregaEmAndamento;
  if Assigned(Documento) then
    Result := Documento.AutoIncrem;
end;

function TRomaneio.UltimaEntrega: IDocumento;
var
  Documento: IDocumento;
  intOrdemEntrega: Integer;
begin
  Result := nil;
  intOrdemEntrega := 0;

  for Documento in Documentos do
  begin
    if not Documento.DocumentoDeEntrega then
      Continue;

    if StrToIntDef(Documento.RotaOrdem, 0) > intOrdemEntrega then
    begin
      Result := Documento;
      intOrdemEntrega := StrToIntDef(Documento.RotaOrdem, 0);
    end;
  end;
end;

function TRomaneio.fRetornaOrdImpUltimaEntrega: Integer;
var
  Documento: IDocumento;
begin
  Result := 0;

  Documento := UltimaEntrega;
  if Assigned(Documento) then
    Result := StrToIntDef(Documento.RotaOrdem, 0);
end;

procedure TRomaneio.pCarregaAlertasMotivosDePausa;
const
  IDENTIFICACAO_PAUSA_INICIADA = 'PAUSA_INICIADA';
var
  qryAlertas: IMyQuery;
  dtaHoraAlerta: TDateTime;
begin
  qryAlertas := objCore.fCriarQuery;
  qryAlertas.Close;
  qryAlertas.SQL.Text :=
  ' SELECT '+
  '   IFNULL(O.OCR_DESCRI, "PAUSA") AS OCR_DESCRI, '+
  '   M.MSG_SITUAC, '+
  '   M.MSG_MENSAG, '+
  '   M.MSG_DTAOCO, '+
  '   M.MSG_HOROCO  '+
  ' FROM '+
  '   ROMMSG M '+
  ' LEFT JOIN OCOROM O ON '+
  '   M.MSG_SEQOCR = O.AUTOINCREM AND '+
  '   O.OCR_MOTPAR = "S" '+
  ' WHERE '+
  '   M.MSG_NUMROM = :NUMROM AND '+
  '   M.MSG_EMPROM = :EMPROM AND '+
  '   LOCATE("PAUSA_", M.MSG_SITUAC) > 0 '+
  ' ORDER BY '+
  '   MSG_DTAOCO DESC, '+
  '   MSG_HOROCO DESC '+
  ' LIMIT 1 ';

  qryAlertas.ParamByName('NUMROM').AsString := NumeroRomaneio;
  qryAlertas.ParamByName('EMPROM').ASString := EmpresaRomaneio;
  qryAlertas.Open;

  FAlertas.Clear;
  if (not qryAlertas.IsEmpty) and
     (qryAlertas.FieldByName('MSG_SITUAC').AsString = IDENTIFICACAO_PAUSA_INICIADA) then
  begin

    dtaHoraAlerta := 0;
    if not fEmptyStr(qryAlertas.FieldByName('MSG_DTAOCO').AsString) then
      dtaHoraAlerta := StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                      StrToDateTime(qryAlertas.FieldByName('MSG_DTAOCO').AsString + ' ' +
                                                                    qryAlertas.FieldByName('MSG_HOROCO').AsString))
                                            );

    FAlertas.Add(TAlerta.Create(IDENTIFICACAO_PAUSA_INICIADA,
                                qryAlertas.FieldByName('MSG_MENSAG').AsString,
                                qryAlertas.FieldByName('OCR_DESCRI').AsString,
                                dtaHoraAlerta));
  end;
end;

procedure TRomaneio.pCarregaDocumentos;
var
  qryDocumento: IMyQuery;
  strSQL: String;
  strSQLDel: String;
begin
  FDocumentos.Clear;

  strSQL :=
  ' SELECT '+
  '   R.AUTOINCREM, '+
  '   R.GER_NUMDOC, '+
  '   R.GER_ESPDOC, '+
  '   R.GER_DTAINI, '+
  '   R.GER_HORINI, '+
  '   R.GER_DTABAI, '+
  '   R.GER_HORBAI, '+
  '   R.GER_CODEMP, '+
  '   R.GER_CODCLI, '+
  '   R.GER_CIDENT, '+
  '   R.GER_ENDENT, '+
  '   R.GER_BAIENT, '+
  '   R.GER_CEPENT, '+
  '   IFNULL(EC.ETC_LATLON, R.GER_LATLON) AS GER_LATLON, '+
  '   R.GER_ORDIMP, '+
  '   R.GER_DISTAN, '+
  '   R.GER_TMPENT, '+
  '   R.GER_NOMREC, '+
  '   R.GER_NUMROM, '+
  '   R.GER_EMPROM, '+
  '   (SUM(COALESCE(D.DET_QTDROM,0)) + (SELECT COALESCE(SUM(DD.DET_QTDROM),0) FROM DEL_ROMDETX DD WHERE R.AUTOINCREM = DD.DET_SEQGER)) AS DET_QTDROM, '+
  '   R.GER_CODMOT, '+
  '   M.MOT_NOMMOT, '+
  '   E.EMP_NOMEMP, '+
  '   R.GER_ALTEND, '+
  '   IF(R.GER_ESPDOC = "OX", '+
  '      R.GER_MEN001, '+
  '      IFNULL(' + fSQLIFClienteConsumidor('CL.CLI_NOMCLI', 'R.GER_NOMCON', 'CL.CLI_NOMCLI') + ', CE.EMP_NOMEMP)) AS CLI_NOMCLI, '+
  '   C.CID_NOMCID, '+
  '   C.CID_ESTADO, '+
  '  DATE_FORMAT( '+
  '       IF(IFNULL(PD.FGO_DTENTR,0) = 0, '+
  '          IF(IFNULL(G.GER_DTENTR,0) = 0, '+
  '                   N.GER_DTENTR, '+
  '             G.GER_DTENTR), '+
  '          PD.FGO_DTENTR), '+
  '  "%d/%m/%Y") AS GER_DTENTR, '+
  '  (SELECT DISTINCT '+
  '     IFNULL(O.OCR_TIPOCR, "") '+
  '   FROM '+
  '     ROMMSG M '+
  '        LEFT JOIN OCOROM O ON M.MSG_SEQOCR = O.AUTOINCREM '+
  '   WHERE M.MSG_SEQGER = R.AUTOINCREM '+
  '     AND M.AUTOINCREM = ' + SQL_ULTROMMSG.Replace('G.','R.') + ') AS OCR_TIPOCR, '+
  '   R.GER_TIPDOC '+
  ' FROM '+
  '   ROMGERX R '+
  ' LEFT JOIN ROMDETX D '+
  '   ON R.AUTOINCREM = D.DET_SEQGER '+
  ' LEFT JOIN CADEMP E '+
  '   ON R.GER_CODEMP = E.EMP_CODEMP '+
  ' LEFT JOIN CADCLI CL '+
  '   ON R.GER_CODCLI = CL.CLI_CODCLI AND R.GER_FILIAL = "N" '+
  ' LEFT JOIN ENTCLI EC '+
  '   ON R.GER_CODCLI = EC.ETC_CODCLI '+
  '  AND R.GER_CIDENT = EC.ETC_CIDENT '+
  '  AND R.GER_CEPENT = EC.ETC_CEPENT '+
  '  AND R.GER_ENDENT = EC.ETC_ENDENT '+
  '  AND R.GER_BAIENT = EC.ETC_BAIENT '+
  ' LEFT JOIN CADEMP CE '+
  '   ON R.GER_CODEMP = CE.EMP_CODEMP AND R.GER_FILIAL = "S" '+
  ' LEFT JOIN CADCID C '+
  '   ON R.GER_CIDENT = C.CID_CODCID '+
  ' LEFT JOIN CADMOT M '+
  '   ON R.GER_CODMOT = M.MOT_CODMOT '+
  ' LEFT JOIN MOVGER G '+
  '   ON G.GER_NUMDOC = R.GER_NUMDOC '+
  '  AND G.GER_ESPDOC = R.GER_ESPDOC '+
  '  AND G.GER_CODEMP = R.GER_CODEMP '+
  '  AND G.GER_CODCLI = R.GER_CODCLI '+
  ' LEFT JOIN NOTGER N '+
  '   ON N.GER_NUMDOC = R.GER_NUMDOC '+
  '  AND N.GER_ESPDOC = R.GER_ESPDOC '+
  '  AND N.GER_CODEMP = R.GER_CODEMP '+
  '  AND N.GER_CODCLI = R.GER_CODCLI '+
  ' LEFT JOIN FATGOR PD '+
  '   ON PD.FGO_NUMDOC = R.GER_NUMDOC '+
  '  AND PD.FGO_ESPDOC = R.GER_ESPDOC '+
  '  AND PD.FGO_CODEMP = R.GER_CODEMP '+
  '  AND PD.FGO_CODCLI = R.GER_CODCLI '+
  ' WHERE '+
  '   R.GER_NUMROM = :NUMROM AND '+
  '   R.GER_EMPROM = :EMPROM '+
  ' GROUP BY '+
  '   AUTOINCREM ';

  strSQLDel := strSQL;
  strSQLDel := AnsiReplaceStr(strSQLDel, '(SUM(COALESCE(D.DET_QTDROM,0)) + (SELECT COALESCE(SUM(DD.DET_QTDROM),0) FROM DEL_ROMDETX DD WHERE R.AUTOINCREM = DD.DET_SEQGER))', 'SUM(COALESCE(D.DET_QTDROM,0))');
  strSQLDel := AnsiReplaceStr(strSQLDel, 'ROMGERX', 'DEL_ROMGERX');
  strSQLDel := AnsiReplaceStr(strSQLDel, 'ROMDETX', 'DEL_ROMDETX');

  strSQL := strSQL + ' UNION ' + strSQLDel;

  qryDocumento := objCore.fCriarQuery;
  qryDocumento.Close;
  qryDocumento.SQL.Text :=
  ' SELECT '+
  '   AUTOINCREM, '+
  '   GER_NUMROM, '+
  '   GER_NUMDOC, '+
  '   GER_ESPDOC, '+
  '   GER_DTAINI, '+
  '   GER_HORINI, '+
  '   GER_DTABAI, '+
  '   GER_HORBAI, '+
  '   GER_CODEMP, '+
  '   GER_CODCLI, '+
  '   GER_CIDENT, '+
  '   GER_ENDENT, '+
  '   GER_BAIENT, '+
  '   GER_CEPENT, '+
  '   GER_LATLON, '+
  '   GER_ORDIMP, '+
  '   GER_DISTAN, '+
  '   GER_TMPENT, '+
  '   GER_NOMREC, '+
  '   GER_NUMROM, '+
  '   GER_EMPROM, '+
  '   DET_QTDROM, '+
  '   GER_CODMOT, '+
  '   MOT_NOMMOT, '+
  '   EMP_NOMEMP, '+
  '   GER_ALTEND, '+
  '   CLI_NOMCLI, '+
  '   CID_NOMCID, '+
  '   CID_ESTADO, '+
  '   GER_DTENTR, '+
  '   OCR_TIPOCR, '+
  '   GER_TIPDOC  '+

  ' FROM ( '+ strSQL +' ) AS DOCUMENTOS'+

  ' ORDER BY '+
  '   GER_ORDIMP ';

  qryDocumento.ParamByName('NUMROM').AsString := NumeroRomaneio;
  qryDocumento.ParamByName('EMPROM').AsString := VS_strCodEmp;
  qryDocumento.Open;

  while not qryDocumento.Eof do
  begin
    FDocumentos.Add(TDocumento.Create(qryDocumento));
    qryDocumento.Next;
  end;
end;

procedure TRomaneio.pCarregaOcorrenciasRomaneio;
var
  qryOcorrencia: IMyQuery;
  dtaDataHoraOcorrencia: TDateTime;
begin

  qryOcorrencia := objCore.fCriarQuery;
  qryOcorrencia.Close;
  qryOcorrencia.SQL.Text :=
  ' SELECT '+
  '   IF(IFNULL(DOCUMENTO, "") = "", DESCRICAO, CONCAT(DESCRICAO, " - ", DOCUMENTO, "-", ESPECIE, "-", EMPRESA)) AS DESCRICAO, '+
  '   DATA, '+
  '   HORA, '+
  '   MSG_MENSAG '+
  ' FROM ( '+

  {** RETORNA INFORMAÇOES DA ENTREGA INICIADA **}
  ' 	  SELECT '+
  '   	  "INÍCIO ENTREGA" AS DESCRICAO, '+
  '   	  IF(G.GER_NUMDOC IS NOT NULL, G.GER_NUMDOC, D.GER_NUMDOC) AS DOCUMENTO, '+
  '   	  IF(G.GER_ESPDOC IS NOT NULL, G.GER_ESPDOC, D.GER_ESPDOC) AS ESPECIE, '+
  '   	  IF(G.GER_CODEMP IS NOT NULL, G.GER_CODEMP, D.GER_CODEMP) AS EMPRESA, '+
  '   	  M.MSG_DTAINI AS DATA, '+
  '   	  M.MSG_HORINI AS HORA, '+
  '       " " AS MSG_MENSAG '+
  '   	FROM '+
  '   	  ROMMSG M '+
  '        	LEFT JOIN ROMGERX G ON M.MSG_SEQGER = G.AUTOINCREM '+
  '        	LEFT JOIN DEL_ROMGERX D ON M.MSG_SEQGER = D.AUTOINCREM '+
  '    	WHERE '+
  ' 	    M.MSG_DTAINI IS NOT NULL AND '+
  ' 	    M.MSG_NUMROM = :NUMROM AND '+
  ' 	    M.MSG_EMPROM = :EMPROM '+

  ' 	  UNION ALL '+

  {** RETORNA INFORMAÇOES DA CHEGADA AO CLIENTE **}
  '    	SELECT '+
  ' 	    "CHEGADA NO CLIENTE" AS DESCRICAO, '+
  '   	  IF(G.GER_NUMDOC IS NOT NULL, G.GER_NUMDOC, D.GER_NUMDOC) AS DOCUMENTO, '+
  '   	  IF(G.GER_ESPDOC IS NOT NULL, G.GER_ESPDOC, D.GER_ESPDOC) AS ESPECIE, '+
  '   	  IF(G.GER_CODEMP IS NOT NULL, G.GER_CODEMP, D.GER_CODEMP) AS EMPRESA, '+
  '   	  M.MSG_DTACHE AS DATA, '+
  '   	  M.MSG_HORCHE AS HORA, '+
  '       " " AS MSG_MENSAG '+
  '    	FROM '+
  ' 	    ROMMSG M '+
  '      	  LEFT JOIN ROMGERX G ON M.MSG_SEQGER = G.AUTOINCREM '+
  '         LEFT JOIN DEL_ROMGERX D ON M.MSG_SEQGER = D.AUTOINCREM '+
  '    	WHERE '+
  '    	  M.MSG_DTACHE IS NOT NULL AND '+
  '    	  M.MSG_NUMROM = :NUMROM AND '+
  ' 	    M.MSG_EMPROM = :EMPROM '+

  '    	UNION ALL '+

  {** RETORNA INFORMAÇOES DA ENTREGA FINALIZADA **}
  '    	SELECT '+
  ' 	    "ENTREGA REALIZADA" AS DESCRICAO, '+
  '   	  IF(G.GER_NUMDOC IS NOT NULL, G.GER_NUMDOC, D.GER_NUMDOC) AS DOCUMENTO, '+
  '   	  IF(G.GER_ESPDOC IS NOT NULL, G.GER_ESPDOC, D.GER_ESPDOC) AS ESPECIE, '+
  '   	  IF(G.GER_CODEMP IS NOT NULL, G.GER_CODEMP, D.GER_CODEMP) AS EMPRESA, '+
  '   	  M.MSG_DTAFIN AS DATA, '+
  '   	  M.MSG_HORFIN AS HORA, '+
  '       M.MSG_MENSAG '+
  '    	FROM '+
  '    	  ROMMSG M '+
  '      	  LEFT JOIN ROMGERX G ON M.MSG_SEQGER = G.AUTOINCREM '+
  '        	LEFT JOIN DEL_ROMGERX D ON M.MSG_SEQGER = D.AUTOINCREM '+
  '    	WHERE '+
  '    	  M.MSG_DTAFIN IS NOT NULL AND '+
  '    	  M.MSG_SEQOCR IS NULL AND '+
  '    	  M.MSG_NUMROM = :NUMROM AND '+
  '    	  M.MSG_EMPROM = :EMPROM '+

  '    	UNION ALL '+

  {** RETORNA INFORMAÇOES DE OCORRENCIAS NA ENTREGA/ROMANEIO **}
  '   	SELECT '+
  '   	  OCR_DESCRI AS DESCRICAO, '+
  '   	  IF(G.GER_NUMDOC IS NOT NULL, G.GER_NUMDOC, D.GER_NUMDOC) AS DOCUMENTO, '+
  '   	  IF(G.GER_ESPDOC IS NOT NULL, G.GER_ESPDOC, D.GER_ESPDOC) AS ESPECIE, '+
  '   	  IF(G.GER_CODEMP IS NOT NULL, G.GER_CODEMP, D.GER_CODEMP) AS EMPRESA, '+
  '	      M.MSG_DTAOCO AS DATA, '+
  '	      M.MSG_HOROCO AS HORA, '+
  '       M.MSG_MENSAG '+
  '   	FROM '+
  '    	  ROMMSG M '+
  '    	    LEFT JOIN ROMGERX G ON M.MSG_SEQGER = G.AUTOINCREM '+
  '        	LEFT JOIN DEL_ROMGERX D ON M.MSG_SEQGER = D.AUTOINCREM '+
  '    	    INNER JOIN OCOROM O ON M.MSG_SEQOCR = O.AUTOINCREM '+
  '    	WHERE '+
  '    	  M.MSG_NUMROM = :NUMROM AND '+
  '    	  M.MSG_EMPROM = :EMPROM AND '+
  '       O.OCR_MOTPAR = "N" '+

  '     UNION ALL '+

  {** RETORNA INFORMAÇOES DE PAUSAS NA ENTREGA/ROMANEIO **}
  '   	SELECT '+
  '   	  IFNULL(OCR_DESCRI, "PAUSA") AS DESCRICAO, '+
  '   	  IFNULL(IF(G.GER_NUMDOC IS NOT NULL, G.GER_NUMDOC, D.GER_NUMDOC), "") AS DOCUMENTO, '+
  '   	  IFNULL(IF(G.GER_ESPDOC IS NOT NULL, G.GER_ESPDOC, D.GER_ESPDOC), "") AS ESPECIE, '+
  '   	  IFNULL(IF(G.GER_CODEMP IS NOT NULL, G.GER_CODEMP, D.GER_CODEMP), "") AS EMPRESA, '+
  '	      M.MSG_DTAOCO AS DATA, '+
  '	      M.MSG_HOROCO AS HORA, '+
  '       M.MSG_MENSAG '+
  '   	FROM '+
  '    	  ROMMSG M '+
  '         LEFT JOIN ROMGERX G ON M.MSG_SEQGER = G.AUTOINCREM '+
  '        	LEFT JOIN DEL_ROMGERX D ON M.MSG_SEQGER = D.AUTOINCREM '+
  '    	    LEFT JOIN OCOROM O ON M.MSG_SEQOCR = O.AUTOINCREM AND O.OCR_MOTPAR = "S" '+
  '    	WHERE '+
  '    	  M.MSG_NUMROM = :NUMROM AND '+
  '    	  M.MSG_EMPROM = :EMPROM AND '+
  '       LOCATE("PAUSA_", M.MSG_SITUAC) > 0 '+

  ' ) LISTA '+

  ' ORDER BY DATA, HORA ';

  qryOcorrencia.ParamByName('NUMROM').AsString := NumeroRomaneio;
  qryOcorrencia.ParamByName('EMPROM').AsString := EmpresaRomaneio;
  qryOcorrencia.Open;

  FOcorrencias.Clear;
  while not qryOcorrencia.Eof do
  begin
    dtaDataHoraOcorrencia := 0;
    if (not fEmptyStr(qryOcorrencia.FieldByName('DATA').AsString)) and
       (not fEmptyStr(qryOcorrencia.FieldByName('HORA').AsString)) then
      dtaDataHoraOcorrencia := StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                                  StrToDateTime(qryOcorrencia.FieldByName('DATA').AsString + ' ' +
                                                                                qryOcorrencia.FieldByName('HORA').AsString)));

    FOcorrencias.Add(TOcorrencia.Create('',
                                        '',
                                        qryOcorrencia.FieldByName('DESCRICAO').AsString,
                                        '',
                                        qryOcorrencia.FieldByName('MSG_MENSAG').AsAnsiString,
                                        dtaDataHoraOcorrencia
                                        ));
    qryOcorrencia.Next;
  end;
end;

function TRomaneio.fRetEvitar(strAvoid: String): TAvoid;
begin
  Result := none;
  case AnsiIndexStr(strAvoid, ['tolls', 'highways','ferries']) of
    1: Result := tolls;
    2: Result := highways;
    3: Result := ferries;
  end;
end;

function TRomaneio.fRetEvitarMaplink(strAvoid: String): TArray<String>;
var
  strDelimitador: String;
begin
  Result := nil;

  if fEmptyStr(strAvoid) then
    Exit;

  strDelimitador := ',';

  Result := strAvoid.Split(strDelimitador);
end;

function TRomaneio.fRetornaValorTipoRota(tpRota: ITipoRota): Integer;
begin
  Result := -1;

  Case tpRota Of
    tpPlanejada : Result := 0;
    tpEfetuada  : Result := 1;
    tpAproximada: Result := 2;
  End;
end;

procedure TRomaneio.pConfiguraCarregamentoNaFilial(cdsTmpDoc: TUniClientDataSet);
var
  cdsFilial: TUniCLientDataSet;
begin
  cdsFilial := TUniClientDataSet.Create(nil);
  try
    pCloneDataSet(cdsFilial, cdsTmpDoc);

    cdsFilial.Filtered := False;
    cdsFilial.Filter := 'GER_FILIAL = '+QuotedStr('S');
    cdsFilial.Filtered := True;
    while not cdsFilial.Eof do
    begin
      cdsTmpDoc.Filtered := False;
      cdsTmpDoc.Filter := 'GER_CODEMP = '+QuotedStr(cdsFilial.FieldByName('GER_CODEMP').AsString)+' AND '+
                          'GER_FILIAL = '+QuotedStr('N');
      cdsTmpDoc.Filtered := True;

      while not cdsTmpDoc.Eof do
      begin
        cdsTmpDoc.Edit;
        cdsTmpDoc.FieldByName('CARGANAFILIAL').AsString := cdsFilial.FieldByName('GER_CODEMP').AsString;
        cdsTmpDoc.Post;

        cdsTmpDoc.Next;
      end;

      cdsFilial.Next;
    end;

  finally
    cdsTmpDoc.Filtered := False;
    FreeAndNil(cdsFilial);
  end;

end;

function TRomaneio.Alertas: TList<IAlerta>;
begin
  Result := FAlertas;
end;

procedure TRomaneio.AlteraStatusOcorrencia;
var
  qryRomMsg: IMyQuery;
  Documento: IDocumento;
  strSQL, strWhere : String;
begin
  qryRomMsg := objCore.fCriarQuery;

  strSQL   := '';
  strSQL   := strSQL + 'UPDATE ';
  strSQL   := strSQL + '  ROMMSG ';
  strSQL   := strSQL + 'SET ';
  strSQL   := strSQL + '  MSG_RESOLV = "S" ';
  strSQL   := strSQL + 'WHERE ';
  strSQL   := strSQL + '  TRUE ';

  If (FOcorrencias.Count > 0) Then
  Begin
    strWhere := '';
    strWhere := strWhere + ' AND MSG_NUMROM = :NUMROM ';
    strWhere := strWhere + ' AND MSG_EMPROM = :EMPROM ';

    qryRomMsg.Close;
    qryRomMsg.SQL.Text := strSQL + strWhere;
    qryRomMsg.ParamByName('NUMROM').AsString := FNumeroRomaneio;
    qryRomMsg.ParamByName('EMPROM').AsString := FEmpresaRomaneio;
    qryRomMsg.ExecSQL;
  End;

  for Documento in FDocumentos do
  Begin
    Documento.CarregaOcorrencias;

    if (Documento.Ocorrencias.Count > 0) Then
    Begin
      strWhere := '';
      strWhere := strWhere + 'AND MSG_SEQGER = :AUTINC ';

      qryRomMsg.Close;
      qryRomMsg.SQL.Text := strSQL + strWhere;
      qryRomMsg.ParamByName('AUTINC').AsString := Documento.AutoIncrem;
      qryRomMsg.ExecSQL;
    End;
  End;

  FNivelPrioridade := -1;
end;

procedure TRomaneio.AlteraStatusRotaEfetuada;
var
  qryRASROM : TUniQuery;
  dtaIni, dtaFim : TDatetime;
begin
  If (FRastreamentos.Count > 0) Then
  Begin
    try
      qryRASROM := fCriaQuery;

      dtaIni := FRastreamentos[0].DataHoraCoordenadas;
      dtaFim := FRastreamentos[FRastreamentos.Count - 1].DataHoraCoordenadas;

      qryRASROM.Close;
      qryRASROM.SQL.Text :=
      ' UPDATE RASROM '+
      ' SET    RAS_EXPGPX = "S" '+
      ' WHERE  RAS_NUMROM = :NUMROM '+
      ' AND    RAS_EMPROM = :EMPROM '+
      ' AND    (RAS_DTAHOR BETWEEN :DTAINI AND :DTAFIM) ';

      qryRASROM.ParamByName('NUMROM').AsString   := FNumeroRomaneio;
      qryRASROM.ParamByName('EMPROM').AsString   := FEmpresaRomaneio;
      qryRASROM.ParamByName('DTAINI').AsDateTime := dtaIni;
      qryRASROM.ParamByName('DTAFIM').AsDateTime := dtaFim;
      qryRASROM.ExecSql;

      pCarregaRastreamentos(FDataHoraBaixaRomaneio);
    Finally
      FreeAndNil(qryRASROM);
    End;
  End;
end;

function TRomaneio.fSubstituiOrdImp(var arrOrdImpOri: Array Of Integer): Integer;
var
  intCount,
  intCountOrdImp: Integer;
  intOrdImp: Integer;
begin
  intOrdImp := 999999;
  intCountOrdImp := 0;

  for intCount := 0 to Length(arrOrdImpOri)-1 do
  begin
    if (arrOrdImpOri[intCount] < intOrdImp) and
       (arrOrdImpOri[intCount] > -1) then
    begin
      intOrdImp := arrOrdImpOri[intCount];
      intCountOrdImp := intCount;
    end;
  end;

  arrOrdImpOri[intCountOrdImp] := -1;

  Result := intOrdImp;
end;

procedure TRomaneio.LimparRotasGPX;
var
  qryRasrom: IMyQuery;
  strSQL : String;
begin
  qryRasrom := objCore.fCriarQuery;

  strSQL   := '';
  strSQL   := strSQL + 'UPDATE ';
  strSQL   := strSQL + '  RASROM ';
  strSQL   := strSQL + 'SET ';
  strSQL   := strSQL + '  RAS_EXPGPX = "N" ';
  strSQL   := strSQL + 'WHERE RAS_NUMROM = :NUMROM ';
  strSQL   := strSQL + '  AND RAS_EMPROM = :EMPROM ';

  qryRasRom.Close;
  qryRasRom.SQL.Text := strSQL;
  qryRasRom.ParamByName('NUMROM').AsString := FNumeroRomaneio;
  qryRasRom.ParamByName('EMPROM').AsString := FEmpresaRomaneio;
  qryRasRom.ExecSQL;

  strSQL   := '';
  strSQL   := strSQL + 'DELETE FROM RASGPX ';
  strSQL   := strSQL + 'WHERE RAS_NUMROM = :NUMROM ';
  strSQL   := strSQL + '  AND RAS_EMPROM = :EMPROM ';

  qryRasRom.Close;
  qryRasRom.SQL.Text := strSQL;
  qryRasRom.ParamByName('NUMROM').AsString := FNumeroRomaneio;
  qryRasRom.ParamByName('EMPROM').AsString := FEmpresaRomaneio;
  qryRasRom.ExecSQL;
end;

function TRomaneio.fRetPontoInicial: String;
var
  qryPtoIni: IMyQuery;
begin
  Result := '';

  qryPtoIni := objCore.fCriarQuery;

  qryPtoIni.Close;
  qryPtoIni.SQL.Text :=
  ' SELECT '+
  '   GER_ENDENT, '+
  '   GER_BAIENT, '+
  '   GER_CEPENT, '+
  '   CID_ESTADO, '+
  '   CID_NOMCID, '+
  '   GER_LATLON '+
  ' FROM '+
  '   ROMGERX '+
  ' INNER JOIN CADCID ON '+
  '   GER_CIDENT = CID_CODCID '+
  ' WHERE '+
  '   GER_DTABAI IS NOT NULL AND '+
  '   GER_NUMROM = :NUMROM AND '+
  '   GER_EMPROM = :EMPROM '+
  ' ORDER BY '+
  '   GER_DTABAI DESC, '+
  '   GER_HORBAI DESC '+
  ' LIMIT 1 ';

  qryPtoIni.ParamByName('NUMROM').AsString := NumeroRomaneio;
  qryPtoIni.ParamByName('EMPROM').AsString := EmpresaRomaneio;
  qryPtoIni.Open;

  if fCfgSis('APIROT', varString) = 'GOOGLE' then
  begin
    if not qryPtoIni.IsEmpty then
      Result := IIF(not fEmptyStr(qryPtoIni.FieldByName('GER_ENDENT').AsString), qryPtoIni.FieldByName('GER_ENDENT').AsString+' - ', '')+
                IIF(not fEmptyStr(qryPtoIni.FieldByName('GER_BAIENT').AsString), qryPtoIni.FieldByName('GER_BAIENT').AsString+', ', '')+
                IIF(not fEmptyStr(qryPtoIni.FieldByName('CID_NOMCID').AsString), qryPtoIni.FieldByName('CID_NOMCID').AsString+' - ', '')+
                IIF(not fEmptyStr(qryPtoIni.FieldByName('CID_ESTADO').AsString), qryPtoIni.FieldByName('CID_ESTADO').AsString+', ', '')+
                IIF(not fEmptyStr(qryPtoIni.FieldByName('GER_CEPENT').AsString), qryPtoIni.FieldByName('GER_CEPENT').AsString+', ', '')+
                'Brazil';
  end
  else if fCfgSis('APIROT', varString) = 'MAPLINK' then
    Result := qryPtoIni.FieldByName('GER_LATLON').AsString
  else if fCfgSis('APIROT', varString) = 'CITEL' then
    Result := qryPtoIni.FieldByName('GER_LATLON').AsString
end;

function TRomaneio.fRetRotaEfetuada: TRetornoMaplinkTrip;
var
  qryRotaEfetuada: IMyQuery;

  strSeparator: String;
  arrWayPoints: TArray<String>;
  arravoidanceTypes: TArray<String>;
begin
  Result := nil;
  try
    qryRotaEfetuada := objCore.fCriarQuery;

    qryRotaEfetuada.Close;
    qryRotaEfetuada.SQL.Text :=
    ' SELECT '+
    '   GROUP_CONCAT(RAS_LATLON ORDER BY RAS_DTAHOR SEPARATOR "_") AS RAS_LATLON '+
    ' FROM '+
    '   RASROM '+
    ' WHERE '+
    '   RAS_NUMROM = :NUMROM AND '+
    '   RAS_EMPROM = :EMPROM ';

    qryRotaEfetuada.ParamByName('NUMROM').AsString := NumeroRomaneio;
    qryRotaEfetuada.ParamByName('EMPROM').AsString := EmpresaRomaneio;
    qryRotaEfetuada.Open;

    if not qryRotaEfetuada.IsEmpty then
    begin
      strSeparator := '_';
      arrWayPoints := qryRotaEfetuada.FieldByName('RAS_LATLON').AsString.Split(strSeparator);

      Result := TControllerMaplinkTrip.fRetPoints(arrWayPoints,
                                                  arravoidanceTypes,
                                                  fCampoTabela('GER_FSTSHT', 'ROMGERX', ['GER_NUMROM', 'GER_EMPROM'], [NumeroRomaneio, EmpresaRomaneio]));
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message, '[TRomaneio.fRetRotaEfetuada]');
  end;
end;

function TRomaneio.fRetRotaPlanejada: TRetornoMaplinkTrip;
var
  qryRotaPlanejada: IMyQuery;

  strSeparator: String;
  arrWayPoints: TArray<String>;
  arravoidanceTypes: TArray<String>;
begin
  Result := nil;
  try
    qryRotaPlanejada := objCore.fCriarQuery;

    qryRotaPlanejada.Close;
    qryRotaPlanejada.SQL.Text :=
    '  SELECT '+
    '    CONCAT(GER_INIPAR, "_", GROUP_CONCAT(GER_LATLON ORDER BY GER_ORDIMP SEPARATOR "_" ), "_", GER_FINROT) AS GER_LATLON, '+
    '    GER_FSTSHT, '+
    '    GER_EVITAR  '+
    '  FROM '+
    '    ROMGERX '+
    '  WHERE '+
    '    GER_NUMROM = :NUMROM AND '+
    '    GER_EMPROM = :EMPROM ';

    qryRotaPlanejada.ParamByName('NUMROM').AsString := NumeroRomaneio;
    qryRotaPlanejada.ParamByName('EMPROM').AsString := EmpresaRomaneio;
    qryRotaPlanejada.Open;

    if not qryRotaPlanejada.IsEmpty then
    begin
      strSeparator := '_';
      arrWayPoints := qryRotaPlanejada.FieldByName('GER_LATLON').AsString.Split(strSeparator);
      arravoidanceTypes := fRetEvitarMaplink(qryRotaPlanejada.FieldByName('GER_EVITAR').AsString);

      Result := TControllerMaplinkTrip.fRetPoints(arrWayPoints,
                                                  arravoidanceTypes,
                                                  qryRotaPlanejada.FieldByName('GER_FSTSHT').AsString);
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message, '[TRomaneio.fRetRotaPlanejada]');
  end;
end;

function TRomaneio.fRetRotaEfetuadaMaplinkArray: TArray<TArray<String>>;
var
  qryRotaEfetuada: IMyQuery;

  strSeparator: String;
  arrWayPoints: TArray<String>;
  arravoidanceTypes: TArray<String>;
begin
  try
    qryRotaEfetuada := objCore.fCriarQuery;

    qryRotaEfetuada.Close;
    qryRotaEfetuada.SQL.Text :=
    ' SELECT '+
    '   GROUP_CONCAT(RAS_LATLON ORDER BY RAS_DTAHOR SEPARATOR "_") AS RAS_LATLON '+
    ' FROM '+
    '   RASROM '+
    ' WHERE '+
    '   RAS_NUMROM = :NUMROM AND '+
    '   RAS_EMPROM = :EMPROM ';

    qryRotaEfetuada.ParamByName('NUMROM').AsString := NumeroRomaneio;
    qryRotaEfetuada.ParamByName('EMPROM').AsString := EmpresaRomaneio;
    qryRotaEfetuada.Open;

    if not qryRotaEfetuada.IsEmpty then
    begin
      strSeparator := '_';
      arrWayPoints := qryRotaEfetuada.FieldByName('RAS_LATLON').AsString.Split(strSeparator);

      Result := TControllerMaplinkTrip.fRetPointsArray(arrWayPoints,
                                                       arravoidanceTypes,
                                                       fCampoTabela('GER_FSTSHT', 'ROMGERX', ['GER_NUMROM', 'GER_EMPROM'], [NumeroRomaneio, EmpresaRomaneio]));
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message, '[TRomaneio.fRetRotaEfetuadaMaplinkArray]');
  end;
end;

function TRomaneio.fRetRotaPlanejadaMaplinkArray: TArray<TArray<String>>;
var
  qryRotaPlanejada: IMyQuery;

  strSeparator: String;
  arrWayPoints: TArray<String>;
  arravoidanceTypes: TArray<String>;
begin
  try
    qryRotaPlanejada := objCore.fCriarQuery;

    qryRotaPlanejada.Close;
    qryRotaPlanejada.SQL.Text :=
    '  SELECT '+
    '    CONCAT(GER_INIPAR, "_", GROUP_CONCAT(GER_LATLON ORDER BY GER_ORDIMP SEPARATOR "_" ), "_", GER_FINROT) AS GER_LATLON, '+
    '    GER_FSTSHT, '+
    '    GER_EVITAR  '+
    '  FROM '+
    '    ROMGERX '+
    '  WHERE '+
    '    GER_NUMROM = :NUMROM AND '+
    '    GER_EMPROM = :EMPROM ';

    qryRotaPlanejada.ParamByName('NUMROM').AsString := NumeroRomaneio;
    qryRotaPlanejada.ParamByName('EMPROM').AsString := EmpresaRomaneio;
    qryRotaPlanejada.Open;

    if not qryRotaPlanejada.IsEmpty then
    begin
      strSeparator := '_';
      arrWayPoints := qryRotaPlanejada.FieldByName('GER_LATLON').AsString.Split(strSeparator);
      arravoidanceTypes := fRetEvitarMaplink(qryRotaPlanejada.FieldByName('GER_EVITAR').AsString);

      Result := TControllerMaplinkTrip.fRetPointsArray(arrWayPoints,
                                                       arravoidanceTypes,
                                                       qryRotaPlanejada.FieldByName('GER_FSTSHT').AsString);
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message, '[TRomaneio.fRetRotaPlanejadaMaplinkArray]');
  end;
end;

function TRomaneio.fRetRotaEfetuadaCitelOsrmArray: TArray<TArray<String>>;
var
  qryRotaEfetuada: IMyQuery;

  strSeparator: String;
  arrWayPoints: TArray<String>;
begin
  try
    qryRotaEfetuada := objCore.fCriarQuery;

    qryRotaEfetuada.Close;
    qryRotaEfetuada.SQL.Text :=
    ' SELECT '+
    '   GROUP_CONCAT(CONCAT(REPLACE(TRIM(SUBSTRING_INDEX(RAS_LATLON, ", ", -1)), " ", ""),",",REPLACE(TRIM(SUBSTRING_INDEX(RAS_LATLON, ",", 1)), " ", "")) ORDER BY RAS_DTAHOR SEPARATOR "_") AS RAS_LATLON '+
    ' FROM '+
    '   RASROM '+
    ' WHERE '+
    '   RAS_NUMROM = :NUMROM AND '+
    '   RAS_EMPROM = :EMPROM ';

    qryRotaEfetuada.ParamByName('NUMROM').AsString := NumeroRomaneio;
    qryRotaEfetuada.ParamByName('EMPROM').AsString := EmpresaRomaneio;
    qryRotaEfetuada.Open;

    if not qryRotaEfetuada.IsEmpty then
    begin
      strSeparator := '_';
      arrWayPoints := qryRotaEfetuada.FieldByName('RAS_LATLON').AsString.Split(strSeparator);

      Result := TCitelOsrmRouteApi.fRetIntersectionsArray(arrWayPoints);
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message, '[TRomaneio.fRetRotaEfetuadaCitelOsrmArray]');
  end;
end;

function TRomaneio.fRetRotaPlanejadaCitelOsrmArray: TArray<TArray<String>>;
var
  qryRotaPlanejada: IMyQuery;

  strSeparator: String;
  arrWayPoints: TArray<String>;
begin
  try
    qryRotaPlanejada := objCore.fCriarQuery;

    qryRotaPlanejada.Close;
    qryRotaPlanejada.SQL.Text :=
    '  SELECT '+
    '    CONCAT(GER_INIPAR, "_", GROUP_CONCAT(REPLACE(TRIM(GER_LATLON), " ", "") ORDER BY GER_ORDIMP SEPARATOR "_" ), "_", GER_FINROT) AS GER_LATLON '+
    '  FROM '+
    '    ROMGERX '+
    '  WHERE '+
    '    GER_NUMROM = :NUMROM AND '+
    '    GER_EMPROM = :EMPROM ';

    qryRotaPlanejada.ParamByName('NUMROM').AsString := NumeroRomaneio;
    qryRotaPlanejada.ParamByName('EMPROM').AsString := EmpresaRomaneio;
    qryRotaPlanejada.Open;

    if not qryRotaPlanejada.IsEmpty then
    begin
      strSeparator := '_';
      arrWayPoints := qryRotaPlanejada.FieldByName('GER_LATLON').AsString.Split(strSeparator);

      Result := TCitelOsrmRouteApi.fRetIntersectionsArray(arrWayPoints);
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message, '[TRomaneio.fRetRotaPlanejadaCitelOsrmArray]');
  end;
end;

function TRomaneio.fRetUltimaCoordenadaGPX: IRastreamento;
var
  qryUltRas : TUniQuery;
begin
  Result := Nil;

  qryUltRas := fCriaQuery;

  try
    qryUltRas.Close;
    qryUltRas.SQL.Text :=
    ' SELECT '+
    '   RAS_LATLON, '+
    '   RAS_DTAHOR '+
    ' FROM '+
    '   RASROM '+
    ' WHERE '+
    '   RAS_NUMROM = :NUMROM AND '+
    '   RAS_EMPROM = :EMPROM AND '+
    '   RAS_EXPGPX = "S" '+
    ' ORDER BY '+
    '   RAS_DTAHOR DESC LIMIT 1 ';

    qryUltRas.ParamByName('NUMROM').AsString := NumeroRomaneio;
    qryUltRas.ParamByName('EMPROM').AsString := EmpresaRomaneio;
    qryUltRas.Open;

    If Not qryUltRas.IsEmpty Then
    Begin
      Result := TRastreamento.Create(qryUltRas.FieldByName('RAS_LATLON').AsString,
                                     qryUltRas.FieldByName('RAS_DTAHOR').AsDateTime);
    End;

  finally
    FreeAndNil(qryUltRas);
  end;
end;

procedure TRomaneio.pCriaCdsMapsDistanceMatrix(var cdsRomRet, cdsTmpDoc : TUniClientDataSet);
begin
  cdsRomRet := TUniClientDataSet.Create(nil);
  cdsRomRet.FieldDefs.Add('RET_DISTAN', ftFloat);
  cdsRomRet.FieldDefs.Add('RET_TMPRET', ftFloat);
  cdsRomRet.CreateDataSet;

  cdsTmpDoc := TUniClientDataSet.Create(nil);
  cdsTmpDoc.FieldDefs.Add('GER_MARDES',    ftString, 01);
  cdsTmpDoc.FieldDefs.Add('AUTOINCREM',    ftString, 20);
  cdsTmpDoc.FieldDefs.Add('GER_NUMDOC',    ftString, 12);
  cdsTmpDoc.FieldDefs.Add('GER_CODEMP',    ftString, 03);
  cdsTmpDoc.FieldDefs.Add('GER_ENDCON',    ftString, 80);
  cdsTmpDoc.FieldDefs.Add('GER_BAIRRO',    ftString, 30);
  cdsTmpDoc.FieldDefs.Add('GER_NOMCID',    ftString, 40);
  cdsTmpDoc.FieldDefs.Add('GER_ESTADO',    ftString, 02);
  cdsTmpDoc.FieldDefs.Add('GER_CEPCON',    ftString, 08);
  cdsTmpDoc.FieldDefs.Add('GER_LOCALI',    ftString, 30);
  cdsTmpDoc.FieldDefs.Add('GER_DISTAN',    ftFloat     );
  cdsTmpDoc.FieldDefs.Add('GER_TMPENT',    ftFloat     );
  cdsTmpDoc.FieldDefs.Add('PRIORIDADE',    ftInteger   );
  cdsTmpDoc.FieldDefs.Add('GER_EVITAR',    ftString, 150);
  cdsTmpDoc.FieldDefs.Add('CARGANAFILIAL', ftString, 03);
  cdsTmpDoc.FieldDefs.Add('GER_FILIAL',    ftString, 01);
  cdsTmpDoc.FieldDefs.Add('GER_ORDIMP',    ftInteger   );
  cdsTmpDoc.FieldDefs.Add('GER_INIPAR',    ftString, 300);
  cdsTmpDoc.FieldDefs.Add('GER_FINROT',    ftString, 300);
  cdsTmpDoc.FieldDefs.Add('GER_ALTEND',    ftString, 1);
  cdsTmpDoc.FieldDefs.Add('GER_LATLON',    ftString, 100);
  cdsTmpDoc.FieldDefs.Add('GER_FSTSHT',    ftString, 15);
  cdsTmpDoc.FieldDefs.Add('GER_ESPDOC',    ftString, 2);
  cdsTmpDoc.FieldDefs.Add('GER_AUTINC',    ftString, 20);
  cdsTmpDoc.FieldDefs.Add('GER_NOMTBL',    ftString, 20);
  cdsTmpDoc.FieldDefs.Add('GER_PESBRU',    ftFloat     );
  cdsTmpDoc.FieldDefs.Add('GER_DTADOC',    ftDateTime  );
  cdsTmpDoc.FieldDefs.Add('GER_VOLUME',    ftFloat     );
  cdsTmpDoc.CreateDataSet;

  cdsTmpDoc.IndexFieldNames := 'GER_ORDIMP';
end;

procedure TRomaneio.AtualizaRota;
begin
  AtualizaRotaComRetorno;
end;

{ True somente depois do commit. False quando a API de rota nao processa, o
  geocode falha, a gravacao faz rollback ou ocorre excecao. }
function TRomaneio.AtualizaRotaComRetorno: Boolean;
var
  blnComita: Boolean;
  cdsRomRet,
  cdsTmpDoc : TUniClientDataSet;
  qryRota: IMyQuery;
  Documento: IDocumento;

  arrOrdImpOri: Array Of Integer;

  blnProcessado: Boolean;

  strMsgRetorno: String;
begin
  Result := False;
  blnProcessado := False;
  strMsgRetorno := EmptyStr;

  pCriaCdsMapsDistanceMatrix(cdsRomRet, cdsTmpDoc);
  try
    try
      qryRota := objCore.fCriarQuery;
      for Documento in FDocumentos do
      begin
        qryRota.Close;
        qryRota.SQL.Text :=
        ' SELECT '+
        '   R.GER_ORDIMP, '+
        '   R.GER_NUMDOC, '+
        '   R.GER_CODEMP, '+
        '   R.GER_ENDENT, '+
        '   R.GER_BAIENT, '+
        '   C.CID_NOMCID, '+
        '   C.CID_ESTADO, '+
        '   R.GER_CEPENT, '+
        '   R.GER_EVITAR, '+
        '   R.GER_FILIAL, '+
        '   R.GER_INIPAR, '+
        '   R.GER_FINROT, '+
        '   R.GER_ALTEND, '+
        '   R.GER_LATLON, '+
        '   R.GER_FSTSHT, '+
        '   R.GER_ESPDOC, '+
        '   R.GER_AUTINC, '+
        '   R.GER_NOMTAB AS GER_NOMTBL, '+
        '   R.GER_PESBRU, '+
        '   R.GER_DTAENT AS GER_DTADOC, '+
        '   R.GER_VOLUME '+
        ' FROM '+
        '   ROMGERX R '+
        ' INNER JOIN CADCID C ON '+
        '   R.GER_CIDENT = C.CID_CODCID '+
        ' WHERE '+
        '   R.AUTOINCREM = :AUTINC AND '+
        '   GER_DTABAI IS NULL AND '+
        '   GER_TIPDOC = "E" ';

        qryRota.ParamByName('AUTINC').AsString := Documento.AutoIncrem;
        qryRota.Open;

        if qryRota.IsEmpty then
          Continue;

        SetLength(arrOrdImpOri, Length(arrOrdImpOri)+1);
        arrOrdImpOri[Length(arrOrdImpOri)-1] := qryRota.FieldByName('GER_ORDIMP').AsInteger;

        cdsTmpDoc.Append;
        cdsTmpDoc.FieldByName('GER_MARDES').AsString  := 'M';
        cdsTmpDoc.FieldByName('AUTOINCREM').AsString  := Documento.AutoIncrem;
        cdsTmpDoc.FieldByName('GER_NUMDOC').AsString  := qryRota.FieldByName('GER_NUMDOC').AsString;
        cdsTmpDoc.FieldByName('GER_CODEMP').AsString  := qryRota.FieldByName('GER_CODEMP').AsString;
        cdsTmpDoc.FieldByName('GER_ENDCON').AsString  := qryRota.FieldByName('GER_ENDENT').AsString;
        cdsTmpDoc.FieldByName('GER_BAIRRO').AsString  := qryRota.FieldByName('GER_BAIENT').AsString;
        cdsTmpDoc.FieldByName('GER_NOMCID').AsString  := qryRota.FieldByName('CID_NOMCID').AsString;
        cdsTmpDoc.FieldByName('GER_ESTADO').AsString  := qryRota.FieldByName('CID_ESTADO').AsString;
        cdsTmpDoc.FieldByName('GER_CEPCON').AsString  := qryRota.FieldByName('GER_CEPENT').AsString;
        cdsTmpDoc.FieldByName('GER_LOCALI').AsString  := '';
        cdsTmpDoc.FieldByName('PRIORIDADE').AsInteger := 0;
        cdsTmpDoc.FieldByName('GER_EVITAR').AsString  := qryRota.FieldByName('GER_EVITAR').AsString;
        cdsTmpDoc.FieldByName('GER_FILIAL').AsString  := qryRota.FieldByName('GER_FILIAL').AsString;
        cdsTmpDoc.FieldByName('GER_ORDIMP').AsInteger := StrToInt(Documento.RotaOrdem);
        cdsTmpDoc.FieldByName('GER_INIPAR').AsString  := qryRota.FieldByName('GER_INIPAR').AsString;
        cdsTmpDoc.FieldByName('GER_FINROT').AsString  := qryRota.FieldByName('GER_FINROT').AsString;
        cdsTmpDoc.FieldByName('GER_ALTEND').AsString  := qryRota.FieldByName('GER_ALTEND').AsString;
        cdsTmpDoc.FieldByName('GER_LATLON').AsString  := qryRota.FieldByName('GER_LATLON').AsString;
        cdsTmpDoc.FieldByName('GER_FSTSHT').AsString  := qryRota.FieldByName('GER_FSTSHT').AsString;
        cdsTmpDoc.FieldByName('GER_ESPDOC').AsString  := qryRota.FieldByName('GER_ESPDOC').AsString;
        cdsTmpDoc.FieldByName('GER_AUTINC').AsString  := qryRota.FieldByName('GER_AUTINC').AsString;
        cdsTmpDoc.FieldByName('GER_NOMTBL').AsString  := qryRota.FieldByName('GER_NOMTBL').AsString;
        cdsTmpDoc.FieldByName('GER_PESBRU').AsFloat   := qryRota.FieldByName('GER_PESBRU').AsFloat;
        cdsTmpDoc.FieldByName('GER_DTADOC').AsDateTime:= qryRota.FieldByName('GER_DTADOC').AsDate;
        cdsTmpDoc.FieldByName('GER_VOLUME').AsFloat   := qryRota.FieldByName('GER_VOLUME').AsFloat;
        cdsTmpDoc.Post;
      end;

      pConfiguraCarregamentoNaFilial(cdsTmpDoc);

      if fCfgSis('APIROT', varString) = 'GOOGLE' then
        TControllerMapsDistanceMatrix.pProcessarMapsDistanceMatrix(cdsTmpDoc,
                                                                   cdsRomRet,
                                                                   ordFixed,
                                                                   fRetEvitar(cdsTmpDoc.FieldByName('GER_EVITAR').AsString),
                                                                   blnProcessado,
                                                                   fRetPontoInicial,
                                                                   True)
      else if fCfgSis('APIROT') = 'MAPLINK' then
      begin
        if TGeocodeRomaneio.fProcessaGeocodeDosEnderecos(cdsTmpDoc, strMsgRetorno) then
          TControllerMapsDistanceMatrix.pProcessarMapsDistanceMatrix(cdsTmpDoc,
                                                                     cdsRomRet,
                                                                     ordFixed,
                                                                     fRetEvitarMaplink(cdsTmpDoc.FieldByName('GER_EVITAR').AsString),
                                                                     cdsTmpDoc.FieldByName('GER_FSTSHT').AsString,
                                                                     blnProcessado,
                                                                     fRetPontoInicial,
                                                                     True)
        else
          fMensagem('', strMsgRetorno,['&OK']);
      end
      else if fCfgSis('APIROT') = 'CITEL' then
      begin
        if TGeocodeRomaneio.fProcessaGeocodeDosEnderecos(cdsTmpDoc, strMsgRetorno) then
          TControllerMapsDistanceMatrix.pProcessarMapsDistanceMatrix(cdsTmpDoc,
                                                                     cdsRomRet,
                                                                     ordFixed,
                                                                     blnProcessado,
                                                                     EmptyStr,
                                                                     True)
        else
          fMensagem('', strMsgRetorno,['&OK']);
      end;

      if not blnProcessado then
        Exit;

      fStartTransaction;

      cdsTmpDoc.Filtered := False;
      cdsTmpDoc.First;
      while not cdsTmpDoc.Eof do
      begin
        qryRota.Close;
        qryRota.SQL.Text :=
        ' UPDATE '+
        '   ROMGERX '+
        ' SET '+
        '   GER_ORDIMP = :ORDIMP '+
        '  ,GER_DISTAN = :DISTAN '+
        '  ,GER_TMPENT = :TMPENT '+
        '  ,GER_LOCALI = :LOCALI '+
        '  ,GER_LATLON = :LATLON '+
        ' WHERE '+
        '   AUTOINCREM = :AUTINC ';

        qryRota.ParamByName('ORDIMP').AsInteger := fSubstituiOrdImp(arrOrdImpOri);
        qryRota.ParamByName('DISTAN').AsFloat   := cdsTmpDoc.FieldByName('GER_DISTAN').AsFloat;
        qryRota.ParamByName('TMPENT').AsFloat   := cdsTmpDoc.FieldByName('GER_TMPENT').AsFloat;
        qryRota.ParamByName('LOCALI').AsString  := cdsTmpDoc.FieldByName('GER_LOCALI').AsString;
        qryRota.ParamByName('LATLON').AsString  := cdsTmpDoc.FieldByName('GER_LATLON').AsString;
        qryRota.ParamByName('AUTINC').AsString  := cdsTmpDoc.FieldByName('AUTOINCREM').AsString;
        qryRota.ExecSQL;

        cdsTmpDoc.Next;
      end;

      qryRota.Close;
      qryRota.SQL.Text :=
      ' DELETE '+
      '   FROM ROMGERX '+
      ' WHERE '+
      '   GER_TIPDOC = "R" AND '+
      '   GER_NUMROM = :NUMROM AND '+
      '   GER_EMPROM = :EMPROM ';
      qryRota.ParamByName('NUMROM').AsString := NumeroRomaneio;
      qryRota.ParamByName('EMPROM').AsString := EmpresaRomaneio;
      qryRota.ExecSQL;

      //REOROM
      qryRota.Close;
      qryRota.SQL.Text :=
      ' INSERT INTO REOROM '+
      '  (AUTOINCREM, '+
      '   REO_NUMROM, '+
      '   REO_EMPROM, '+
      '   REO_SEQGER, '+
      '   REO_DTHRIS, '+
      '   REO_EXECUT) '+
      ' VALUES '+
      '  (:AUTINC, '+
      '   :NUMROM, '+
      '   :EMPROM, '+
      '   :SEQGER, '+
      '   :DTHRIS, '+
      '   :EXECUT) ';
      qryRota.ParamByName('AUTINC').AsString := fRetAutoIncrem('REOROM', VS_strCodEmp);
      qryRota.ParamByName('NUMROM').AsString := NumeroRomaneio;
      qryRota.ParamByName('EMPROM').AsString := EmpresaRomaneio;
      qryRota.ParamByName('SEQGER').AsString := fRetornaAutoincremDaEntregaEmAndamento;
      qryRota.ParamByName('DTHRIS').AsDateTime := fRetDtaHraServidor;
      qryRota.ParamByName('EXECUT').AsString := 'S';
      qryRota.ExecSQL;

      blnComita := fGravaRomRet(cdsRomRet, NumeroRomaneio, EmpresaRomaneio);

      if blnComita then
      begin
        fCommit;
        Result := True;
      end
      else
        fRollback;

    except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[TRomaneio.AtualizaRota]');
        if fInTransaction then
          fRollback;
      end;
    end;

  finally
    FreeAndNil(cdsRomRet);
    FreeAndNil(cdsTmpDoc);
  end;

end;

function TRomaneio.RotaRecalculada: Boolean;
begin
  Result := fEmptyStr((fCampoTabela('AUTOINCREM', 'REOROM', ['REO_NUMROM', 'REO_EMPROM', 'REO_EXECUT'], [Self.NumeroRomaneio, Self.EmpresaRomaneio, 'N'])));
end;

function TRomaneio.NivelPrioridade: Integer;
begin
  Result := FNivelPrioridade;
end;

function TRomaneio.NumeroBox: String;
begin
  Result := FNumeroBox;
end;

function TRomaneio.NumeroRomaneio: String;
begin
  Result := FNumeroRomaneio;
end;

function TRomaneio.Ocorrencias: TList<IOcorrencia>;
begin
  Result := FOcorrencias;
end;

function TRomaneio.OpcaoCaminho: String;
begin
  Result := FOpcaoCaminho;
end;

function TRomaneio.OperadorRomaneio: String;
begin
  Result := FOperadorRomaneio;
end;

function TRomaneio.OperadorSolicitante: String;
begin
  Result := FOperadorSolicitante;
end;

function TRomaneio.DataHoraBaixaRomaneio: TDateTime;
begin
  Result := FDataHoraBaixaRomaneio;
end;

function TRomaneio.DataHoraInicioRomaneio: TDateTime;
begin
  Result := FDataHoraInicioRomaneio;
end;

function TRomaneio.DataHoraRomaneio: TDateTime;
begin
  Result := FDataHoraRomaneio;
end;

destructor TRomaneio.Destroy;
begin
  if Assigned(FDocumentos) then
    FreeAndNil(FDocumentos);

  if Assigned(FOcorrencias) then
    FreeAndNil(FOcorrencias);

  if Assigned(FAlertas) then
    FreeAndNil(FAlertas);

  if Assigned(FRastreamentos) then
    FreeAndNil(FRastreamentos);

  if Assigned(FRotasGPX) then
    FreeAndNil(FRotasGPX);

  inherited;
end;

function TRomaneio.DistanciaRetorno: Double;
begin
  Result := FDistanciaRetorno;
end;

function TRomaneio.EmpresaRomaneio: String;
begin
  Result := FEmpresaRomaneio;
end;

procedure TRomaneio.ExportarRotaGPX(tpRota: ITipoRota; strGPX: String; intTempo: integer; fltDistancia: double);
var
  qryGPX,
  qryRASROM : TUniQuery;
  dtaIni, dtaFim : TDatetime;
  strFiltro, strSeqGer, strSQLDel : String;
begin
  strFiltro := '';
  qryGPX    := fCriaQuery;
  qryRASROM := fCriaQuery;

  strSeqGer := fCampoTabela('AUTOINCREM', 'ROMGERX', ['GER_NUMROM','GER_EMPROM'], [FNumeroRomaneio,FEmpresaRomaneio]);

  strSQLDel := ' DELETE FROM RASGPX '+
               ' WHERE  RAS_TIPROT = :TIPROT '+
               ' AND    RAS_NUMROM = :NUMROM '+
               ' AND    RAS_EMPROM = :EMPROM ';

  try
    If (fCfgSis('APIROT', varString) = 'MAPLINK') Or (tpRota <> tpPlanejada) Then
    Begin
      qryGPX.Close;
      qryGPX.SQL.Text := strSQLDel;
      qryGPX.ParamByName('TIPROT').AsInteger := fRetornaValorTipoRota(tpRota);
      qryGPX.ParamByName('EMPROM').AsString  := FEmpresaRomaneio;
      qryGPX.ParamByName('NUMROM').AsString  := FNumeroRomaneio;
      qryGPX.ExecSql;

      If (FRastreamentos.Count > 0) Then
      Begin
        dtaIni := FRastreamentos[0].DataHoraCoordenadas;
        dtaFim := FRastreamentos[FRastreamentos.Count - 1].DataHoraCoordenadas;

        If (FDataHoraBaixaRomaneio > 0) Then
          strFiltro := ' OR RAS_DTAHOR >= :DTABAI ';

        qryRASROM.Close;
        qryRASROM.SQL.Text :=
        ' UPDATE RASROM '+
        ' SET    RAS_EXPGPX = "S" '+
        ' WHERE  RAS_NUMROM = :NUMROM '+
        ' AND    RAS_EMPROM = :EMPROM '+
        ' AND    (RAS_DTAHOR BETWEEN :DTAINI AND :DTAFIM '+ strFiltro +') ';

        qryRASROM.ParamByName('NUMROM').AsString   := FNumeroRomaneio;
        qryRASROM.ParamByName('EMPROM').AsString   := FEmpresaRomaneio;
        qryRASROM.ParamByName('DTAINI').AsDateTime := dtaIni;
        qryRASROM.ParamByName('DTAFIM').AsDateTime := dtaFim;

        If (FDataHoraBaixaRomaneio > 0) Then
          qryRASROM.ParamByName('DTABAI').AsDateTime := FDataHoraBaixaRomaneio;

        qryRASROM.ExecSql;

        pCarregaRastreamentos(FDataHoraBaixaRomaneio);
      End;
    End;

    qryGPX.Close;
    qryGPX.SQL.Text :=
    ' INSERT INTO RASGPX '+
    '  (AUTOINCREM, '+
    '   RAS_SEQGER, '+
    '   RAS_EMPROM, '+
    '   RAS_NUMROM, '+
    '   RAS_TIPROT, '+
    '   RAS_DISTAN, '+
    '   RAS_TEMPO_, '+
    '   RAS_G_P_X_) '+

    ' VALUES '+
    '  (:AUTINC, '+
    '   :SEQGER, '+
    '   :EMPROM, '+
    '   :NUMROM, '+
    '   :TIPROT, '+
    '   :DISTAN, '+
    '   :TEMPO_, '+
    '   :G_P_X_) ';

    qryGPX.ParamByName('AUTINC').AsString  := fRetAutoIncrem('RASGPX', VS_strCodEmp);
    qryGPX.ParamByName('SEQGER').AsString  := strSeqGer;
    qryGPX.ParamByName('EMPROM').AsString  := FEmpresaRomaneio;
    qryGPX.ParamByName('NUMROM').AsString  := FNumeroRomaneio;
    qryGPX.ParamByName('TIPROT').AsInteger := fRetornaValorTipoRota(tpRota);
    qryGPX.ParamByName('DISTAN').AsFloat   := fltDistancia;
    qryGPX.ParamByName('TEMPO_').AsInteger := intTempo;
    qryGPX.ParamByName('G_P_X_').AsString  := strGPX;
    qryGPX.ExecSql;

    pCarregaRotasGPX;

  finally
    FreeAndNil(qryGPX);
    FreeAndNil(qryRASROM);
  end;
end;

function TRomaneio.Documentos: TList<IDocumento>;
begin
  Result := FDocumentos;
end;

function TRomaneio.Motorista: IMotorista;
begin
  Result := FMotorista;
end;

function TRomaneio.PercentualConcluido: Double;
begin
  Result := RoundTo((FQuantidadeEntregasConcluidas / FQuantidadeEntregas) * 100, -2);
end;

function TRomaneio.PontoChegada: IRastreamento;
begin
  Result := FPontoChegada;
end;

function TRomaneio.PontoMotorista: IRastreamento;
begin
  Result := FPontoMotorista;
end;

function TRomaneio.PontoPartida: IRastreamento;
begin
  Result := FPontoPartida;
end;

function TRomaneio.QuantidadeEntregas: Integer;
begin
  Result := FQuantidadeEntregas;
end;

function TRomaneio.QuantidadeEntregasConcluidas: Integer;
begin
  Result := FQuantidadeEntregasConcluidas;
end;

function TRomaneio.QuantidadeOcorrencias: Integer;
begin
  Result := FQuantidadeOcorrencias;
end;

function TRomaneio.Rastreamentos: TList<IRastreamento>;
begin
  Result := FRastreamentos;
end;

procedure TRomaneio.RecalcularRotaEfetuada;
Var
  qryUpdt : TUniQuery;
begin
  qryUpdt := fCriaQuery;

  try
    qryUpdt.Close;
    qryUpdt.SQL.Text :=
    ' UPDATE RASROM '+
    '    SET RAS_EXPGPX = "N" '+
    '  WHERE RAS_EXPGPX = "S" '+
    '    AND RAS_NUMROM = :NUMROM '+
    '    AND RAS_EMPROM = :EMPROM ';

    qryUpdt.ParamByName('NUMROM').AsString  := FNumeroRomaneio;
    qryUpdt.ParamByName('EMPROM').AsString  := FEmpresaRomaneio;
    qryUpdt.ExecSql;

    pCarregaRastreamentos(FDataHoraBaixaRomaneio);
  Finally
    FreeAndNil(qryUpdt);
  End;
end;

function TRomaneio.RotasGPX: TList<IRotaGPX>;
begin
  Result := FRotasGPX;
end;

function TRomaneio.SequencialAtivacao: String;
begin
  Result := FSequencialAtivacao;
end;

function TRomaneio.StatusRomaneio: IStatus;
begin
  Result := FStatusRomaneio;
end;

function TRomaneio.TempoRetorno: Integer;
begin
  Result := FTempoRetorno;
end;

function TRomaneio.Transportadora: ITransportadora;
begin
  Result := FTransportadora;
end;

function TRomaneio.UltimaCoordenadaGPX: IRastreamento;
begin
  Result := FUltimaCoordenadaGPX;
end;

function TRomaneio.Veiculo: IVeiculo;
begin
  Result := FVeiculo;
end;

{ TMotorista }

constructor TMotorista.Create(strCodMot, strNomMot: String);
begin
  FCodigoMotorista := strCodMot;
  FNomeMotorista := strNomMot;
end;

function TMotorista.NomeMotorista: String;
begin
  Result := FNomeMotorista;
end;

function TMotorista.CodigoMotorista: String;
begin
  Result := FCodigoMotorista;
end;

{ TDocumento }

constructor TDocumento.Create(qryDocumento: IMyQuery; TipoDocumento: TTipoDocumento = tpNone);
const
  DOCUMENTO_ENTREGA = 'E';
begin
  FTipoDocumento := TipoDocumento;

  FAutoIncrem := qryDocumento.FieldByName('AUTOINCREM').AsString;
  FNumeroRomaneio := qryDocumento.FieldByName('GER_NUMROM').AsString;
  FNumeroDocumento := qryDocumento.FieldByName('GER_NUMDOC').AsString;
  FEspecieDocumento := qryDocumento.FieldByName('GER_ESPDOC').AsString;
  FQuantidadeItens := qryDocumento.FieldByName('DET_QTDROM').AsInteger;

  if not fEmptyStr(qryDocumento.FieldByName('GER_DTAINI').AsString) then
    FDataHoraInicioEntrega := StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                            StrToDateTime(qryDocumento.FieldByName('GER_DTAINI').AsString + ' ' +
                                                                          qryDocumento.FieldByName('GER_HORINI').AsString))
                                             );

  if not fEmptyStr(qryDocumento.FieldByName('GER_DTABAI').AsString) then
    FDataHoraBaixaEntrega := StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                            StrToDateTime(qryDocumento.FieldByName('GER_DTABAI').AsString + ' ' +
                                                                          qryDocumento.FieldByName('GER_HORBAI').AsString))
                                            );

  FStatusDocumento := rmNaoIniciado;

  if not fEmptyStr(qryDocumento.FieldByName('GER_DTAINI').AsString) then
    FStatusDocumento := rmACaminho;

  if not fEmptyStr(qryDocumento.FieldByName('GER_DTABAI').AsString) then
    FStatusDocumento := rmFinalizado;

  if (qryDocumento.FieldByName('OCR_TIPOCR').AsString = 'N') then
    FStatusDocumento := rmNaoEntregue;

  FRotaOrdem := qryDocumento.FieldByName('GER_ORDIMP').AsString;
  FPercursoKm := qryDocumento.FieldByName('GER_DISTAN').AsFloat;
  FTempoPercurso := qryDocumento.FieldByName('GER_TMPENT').AsInteger;
  FNomeRecebedor := qryDocumento.FieldByName('GER_NOMREC').AsString;

  FMotorista := TMotorista.Create(qryDocumento.FieldByName('GER_CODMOT').AsString,
                                  qryDocumento.FieldByName('MOT_NOMMOT').AsString);

  FEmpresa := TEmpresa.Create(qryDocumento.FieldByName('GER_CODEMP').AsString,
                              qryDocumento.FieldByName('EMP_NOMEMP').AsString);

  FCliente := TCliente.Create(qryDocumento.FieldByName('GER_CODCLI').AsString,
                              qryDocumento.FieldByName('CLI_NOMCLI').AsString);

  FEnderecoEntrega := TEnderecoEntrega.Create(qryDocumento.FieldByName('GER_CIDENT').AsString,
                                              qryDocumento.FieldByName('CID_NOMCID').AsString,
                                              qryDocumento.FieldByName('CID_ESTADO').AsString,
                                              qryDocumento.FieldByName('GER_ENDENT').AsString,
                                              qryDocumento.FieldByName('GER_BAIENT').AsString,
                                              qryDocumento.FieldByName('GER_CEPENT').AsString,
                                              qryDocumento.FieldByName('GER_LATLON').AsString,
                                              qryDocumento.FieldByName('GER_ALTEND').AsString);

  if not fEmptyStr(qryDocumento.FieldByName('GER_DTENTR').AsString) then
    FDataHoraEntregaPrevista := StrToDateTime(FormatDateTime('dd/MM/yyyy', StrToDateTime(qryDocumento.FieldByName('GER_DTENTR').AsString)));

  FDocumentoDeEntrega := (qryDocumento.FieldByName('GER_TIPDOC').AsString = DOCUMENTO_ENTREGA);

  FAlertas := TList<IAlerta>.Create;
  pCarregaAlertas;

  FFotos       := TList<IFoto>.Create;
  FAssinaturas := TList<IAssinatura>.Create;
  FOcorrencias := TList<IOcorrencia>.Create;
  FItens       := TList<IItem>.Create;

  pCarregaPontosEntrega;
end;

procedure TDocumento.pCarregaFotos;
var
  qryFotos: IMyQuery;
begin
  qryFotos := objCore.fCriarQuery;
  qryFotos.Close;
  qryFotos.SQL.Text :=
  ' SELECT '+
  '   FOT_BASE64, '+
  '   FOT_URLFOT  '+
  ' FROM '+
  '   ROMFOT '+
  ' WHERE '+
  '   FOT_SEQGER = :SEQGER ';

  qryFotos.ParamByName('SEQGER').AsString := AutoIncrem;
  qryFotos.Open;

  FFotos.Clear;
  while not qryFotos.Eof do
  begin
    FFotos.Add(
      TFoto.Create(
        AutoIncrem,
        qryFotos.FieldByName('FOT_BASE64').AsString,
        qryFotos.FieldByName('FOT_URLFOT').AsString)
    );

    qryFotos.Next;
  end;
end;

procedure TDocumento.pAlertaValorDocRecebido;
const
  IDENTIFICACAO_DOCREC = 'DOCREC';
var
  qryDocRecebido: IMyQuery;
  dtaHoraAlerta: TDateTime;
begin
  qryDocRecebido := objCore.fCriarQuery;
  qryDocRecebido.Close;
  qryDocRecebido.SQL.Text :=
  ' SELECT '+
  '   MSG_MENSAG, '+
  '   MSG_DTAOCO, '+
  '   MSG_HOROCO '+
  ' FROM '+
  '   ROMMSG '+
  ' WHERE '+
  '   MSG_SEQGER = :SEQGER AND '+
  '   MSG_PAGREC = "S" ';

  qryDocRecebido.ParamByName('SEQGER').AsString := AutoIncrem;
  qryDocRecebido.Open;

  FAlertas.Clear;
  if not qryDocRecebido.IsEmpty then
  begin
    dtaHoraAlerta := 0;
    if not fEmptyStr(qryDocRecebido.FieldByName('MSG_DTAOCO').AsString) then
      dtaHoraAlerta := StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                      StrToDateTime(qryDocRecebido.FieldByName('MSG_DTAOCO').AsString + ' ' +
                                                                    qryDocRecebido.FieldByName('MSG_HOROCO').AsString))
                                            );

    FAlertas.Add(TAlerta.Create(IDENTIFICACAO_DOCREC,
                                qryDocRecebido.FieldByName('MSG_MENSAG').AsString,
                                'RECEBIMENTO',
                                dtaHoraAlerta));

  end;

end;

procedure TDocumento.pCarregaAlertas;
begin
  pAlertaValorDocRecebido;
end;

procedure TDocumento.pCarregaAssinaturas;
var
  qryAssinaturas: IMyQuery;
begin
  qryAssinaturas := objCore.fCriarQuery;
  qryAssinaturas.Close;
  qryAssinaturas.SQL.Text :=
  ' SELECT '+
  '   ASS_BASE64, '+
  '   ASS_URLFOT  '+
  ' FROM '+
  '   ROMASS '+
  ' WHERE '+
  '   ASS_SEQGER = :SEQGER ';;

  qryAssinaturas.ParamByName('SEQGER').AsString := AutoIncrem;
  qryAssinaturas.Open;

  FAssinaturas.Clear;
  while not qryAssinaturas.Eof do
  begin
    FAssinaturas.Add(
      TAssinatura.Create(
        AutoIncrem,
        qryAssinaturas.FieldByName('ASS_BASE64').AsString,
        qryAssinaturas.FieldByName('ASS_URLFOT').AsString)
    );

    qryAssinaturas.Next;
  end;

end;

procedure TDocumento.pCarregaOcorrenciasDocumento;
var
  qryOcorrencia: IMyQuery;
  dtaDataHoraOcorrencia: TDateTime;
begin

  qryOcorrencia := objCore.fCriarQuery;
  qryOcorrencia.Close;
  qryOcorrencia.SQL.Text :=
  ' SELECT '+
  '   IFNULL(O.OCR_TIPOCR, IF(M.MSG_DTAFIN IS NULL, "", "S")) AS OCR_TIPOCR, '+
  '   IFNULL(O.OCR_CODIGO, IF(M.MSG_DTAFIN IS NULL, "", "00000")) AS OCR_CODIGO, '+
  '   IFNULL(O.OCR_DESCRI, IF(M.MSG_DTAFIN IS NULL, "", "ENTREGUE")) AS OCR_DESCRI, '+
  '   M.MSG_DTAOCO, '+
  '   M.MSG_HOROCO, '+
  '   M.MSG_MENSAG  '+
  ' FROM '+
  '   ROMMSG M '+
  ' LEFT JOIN OCOROM O '+
  '   ON M.MSG_SEQOCR = O.AUTOINCREM '+
  ' WHERE '+
  '   M.MSG_SEQGER = :SEQGER AND '+
  '   IFNULL(O.OCR_OCOROM, "N") = "N" AND '+
  '   M.MSG_PAGREC = "N" AND '+
  '   M.MSG_DTAFIN IS NOT NULL '+
  ' ORDER BY '+
  '   M.MSG_DTAOCO, '+
  '   M.MSG_HOROCO  ';

  qryOcorrencia.ParamByName('SEQGER').AsString := AutoIncrem;
  qryOcorrencia.Open;

  FOcorrencias.Clear;
  while not qryOcorrencia.Eof do
  begin
    dtaDataHoraOcorrencia := 0;
    if (not fEmptyStr(qryOcorrencia.FieldByName('MSG_DTAOCO').AsString)) and
       (not fEmptyStr(qryOcorrencia.FieldByName('MSG_HOROCO').AsString)) then
      dtaDataHoraOcorrencia := StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                                  StrToDateTime(qryOcorrencia.FieldByName('MSG_DTAOCO').AsString + ' ' +
                                                                                qryOcorrencia.FieldByName('MSG_HOROCO').AsString)));

    FOcorrencias.Add(TOcorrencia.Create(AutoIncrem,
                                        qryOcorrencia.FieldByName('OCR_CODIGO').AsString,
                                        qryOcorrencia.FieldByName('OCR_DESCRI').AsString,
                                        qryOcorrencia.FieldByName('OCR_TIPOCR').AsString,
                                        qryOcorrencia.FieldByName('MSG_MENSAG').AsAnsiString,
                                        dtaDataHoraOcorrencia
                                        ));
    qryOcorrencia.Next;
  end;

end;

procedure TDocumento.pCarregaPontosEntrega;
var
  qryPontos : IMyQuery;
begin
  qryPontos := objCore.fCriarQuery;
  qryPontos.Close;
  qryPontos.SQL.Text :=
  ' SELECT '+
  '   RAS_NUMROM, '+
  '   RAS_DTAHOR, '+
  '   RAS_LATLON, '+
  '   GER_LATLON  '+
  ' FROM '+
  '   ROMGERX '+
  '   INNER JOIN RASROM ON ROMGERX.AUTOINCREM = RAS_SEQGER '+
  ' WHERE '+
  '   ROMGERX.AUTOINCREM = :AUTINC AND '+
  '   IFNULL(RAS_DTAHOR,0) <> 0 AND '+
  '   RAS_TIPRAS = "F" '+

  ' UNION '+

  ' SELECT '+
  '   RAS_NUMROM, '+
  '   RAS_DTAHOR, '+
  '   RAS_LATLON, '+
  '   GER_LATLON  '+
  ' FROM '+
  '   DEL_ROMGERX '+
  '   INNER JOIN RASROM ON DEL_ROMGERX.AUTOINCREM = RAS_SEQGER '+
  ' WHERE '+
  '   DEL_ROMGERX.AUTOINCREM = :AUTINC AND '+
  '   IFNULL(RAS_DTAHOR,0) <> 0 AND '+
  '   RAS_TIPRAS = "F" ';

  qryPontos.ParamByName('AUTINC').AsString := AutoIncrem;
  qryPontos.Open;

  If Not qryPontos.IsEmpty Then
  Begin
    If (Not Assigned(FPontoEntregaPrevista)) And
       (qryPontos.FieldByName('GER_LATLON').AsString <> EmptyStr) Then
      FPontoEntregaPrevista := TRastreamento.Create(qryPontos.FieldByName('GER_LATLON').AsString,
                                                    StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                    StrToDateTime(qryPontos.FieldByName('RAS_DTAHOR').AsString))));

    If (Not Assigned(FPontoEntregaEfetuada)) And
       (qryPontos.FieldByName('RAS_LATLON').AsString <> EmptyStr) Then
      FPontoEntregaEfetuada := TRastreamento.Create(qryPontos.FieldByName('RAS_LATLON').AsString,
                                                    StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                    StrToDateTime(qryPontos.FieldByName('RAS_DTAHOR').AsString))));
  End;
end;

function TDocumento.PercursoKm: Double;
begin
  Result := FPercursoKm;
end;

function TDocumento.PontoEntregaEfetuada: IRastreamento;
begin
  Result := FPontoEntregaEfetuada;
end;

function TDocumento.DocumentoDeEntrega: Boolean;
begin
  Result := FDocumentoDeEntrega;
end;

function TDocumento.PontoEntregaPrevista: IRastreamento;
begin
  Result := FPontoEntregaPrevista;
end;

function TDocumento.Alertas: TList<IAlerta>;
begin
  Result := FAlertas;
end;

procedure TDocumento.AlteraOrdemEntrega(strOrdem: String);
begin
  FRotaOrdem := strOrdem;
end;

function TDocumento.Assinaturas: TList<IAssinatura>;
begin
  Result := FAssinaturas;
end;

function TDocumento.AutoIncrem: String;
begin
  Result := FAutoIncrem;
end;

procedure TDocumento.CarregaImagens;
begin
  If (fCfgSis('CRGFOT') = 'S') Then
    pCarregaFotos;

  pCarregaAssinaturas;
end;

procedure TDocumento.CarregaItens;
var
  qryItens: IMyQuery;
  strSQLTipoDocumento: String;
begin
  strSQLTipoDocumento := '';
  if FTipoDocumento = tpDocsComItensBaixadosParcialmente then
    strSQLTipoDocumento := ' AND D.DET_QTDROM <> D.DET_QTDBAI AND  D.DET_LIBERA = "N"  ';

  qryItens := objCore.fCriarQuery;
  qryItens.Close;
  qryItens.SQL.Text :=
  ' SELECT '+
  '   D.AUTOINCREM, '+
  '   D.DET_AUTINC, '+
  '   D.DET_CODITE, '+
  '   I.ITE_DESITE, '+
  '   D.DET_UNIDAD, '+
  '  (D.DET_QTDROM * D.DET_UNITAR) - (D.DET_QTDROM * (D.DET_DESESP / D.DET_QTDITE)) AS DET_TOTITE, '+
  '   D.DET_QTDROM, '+
  '   D.DET_QTDBAI, '+
  '   D.DET_QTDAVA, '+
  '   D.DET_QTDFAL  '+
  ' FROM '+
  '   ROMDETX D '+
  ' INNER JOIN CADITE I ON '+
  '   D.DET_CODITE = I.ITE_CODITE '+
  ' WHERE '+
  '   D.DET_SEQGER = :SEQGER '+
  strSQLTipoDocumento;

  qryItens.ParamByName('SEQGER').AsString := AutoIncrem;
  qryItens.Open;

  FItens.Clear;
  while not qryItens.Eof do
  begin
    FItens.Add(TItem.Create(qryItens.FieldByName('AUTOINCREM').AsString,
                            qryItens.FieldByName('DET_AUTINC').AsString,
                            qryItens.FieldByName('DET_CODITE').AsString,
                            qryItens.FieldByName('ITE_DESITE').AsString,
                            qryItens.FieldByName('DET_UNIDAD').AsString,
                            qryItens.FieldByName('DET_TOTITE').AsFloat,
                            qryItens.FieldByName('DET_QTDROM').AsFloat,
                            qryItens.FieldByName('DET_QTDBAI').AsFloat,
                            qryItens.FieldByName('DET_QTDAVA').AsFloat,
                            qryItens.FieldByName('DET_QTDFAL').AsFloat));

    qryItens.Next;
  end;

end;

procedure TDocumento.CarregaOcorrencias;
begin
  pCarregaOcorrenciasDocumento;
end;

procedure TDocumento.CarregaPontosEntrega;
begin
  pCarregaPontosEntrega;
end;

function TDocumento.Cliente: ICliente;
begin
  Result := FCliente;
end;

function TDocumento.DataHoraBaixaEntrega: TDateTime;
begin
  Result := FDataHoraBaixaEntrega;
end;

function TDocumento.DataHoraEntregaPrevista: TDateTime;
begin
  Result := FDataHoraEntregaPrevista;
end;

function TDocumento.DataHoraInicioEntrega: TDateTime;
begin
  Result := FDataHoraInicioEntrega;
end;

destructor TDocumento.Destroy;
begin
  if Assigned(FFotos) then
    FreeAndNil(FFotos);

  if Assigned(FAssinaturas) then
    FreeAndNil(FAssinaturas);

  if Assigned(FOcorrencias) then
    FreeAndNil(FOcorrencias);

  if Assigned(FItens) then
    FreeAndNil(FItens);

  if Assigned(FAlertas) then
    FreeAndNil(FAlertas);

  inherited;
end;

function TDocumento.Empresa: IEmpresa;
begin
  Result := FEmpresa;
end;

function TDocumento.EnderecoEntrega: IEnderecoEntrega;
begin
  Result := FEnderecoEntrega;
end;

function TDocumento.EspecieDocumento: String;
begin
  Result := FEspecieDocumento;
end;

function TDocumento.Fotos: TList<IFoto>;
begin
  Result := FFotos;
end;

procedure TDocumento.ImprimirDocumento;
Var
  reiReimpressao : TReimpressao;
  objPdfEma : TPdfEma;
Begin
  Try
    reiReimpressao := TReimpressao.Create(FNumeroDocumento, FEspecieDocumento, 0,0,
      FCliente.CodigoCliente, FEmpresa.CodigoEmpresa, '', True, 'C', False,
      True, False, '', '', False, 0, False, 'V');

    objPdfEma := TPdfEma.Create(Nil);

    objPdfEma.setEdtFst(opcVideo);
    objPdfEma.setVeiF10(True);
    objPdfEma.setVisual(True);
    objPdfEma.setNumDoc(FNumeroDocumento);
    objPdfEma.setEspDoc(FEspecieDocumento);
    objPdfEma.setCodEmp(FEmpresa.CodigoEmpresa);
    objPdfEma.setDocCan('N');
    objPdfEma.setReimpr(reiReimpressao);

    objPdfEma.fReimprimeDocumento;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fReimprimeDocumento]');
    End;
  End;

  FreeAndNil(objPdfEma);
end;

function TDocumento.Itens: TList<IItem>;
begin
  Result := FItens;
end;

function TDocumento.Ocorrencias: TList<IOcorrencia>;
begin
  Result := FOcorrencias;
end;

function TDocumento.Motorista: IMotorista;
begin
  Result := FMotorista;
end;

function TDocumento.NomeRecebedor: String;
begin
  Result := FNomeRecebedor;
end;

function TDocumento.NumeroDocumento: String;
begin
  Result := FNumeroDocumento;
end;

function TDocumento.NumeroRomaneio: String;
begin
  Result := FNumeroRomaneio;
end;

function TDocumento.QuantidadeItens: Integer;
begin
  Result := FQuantidadeItens;
end;

function TDocumento.RotaOrdem: String;
begin
  Result := FRotaOrdem;
end;

procedure TDocumento.SalvarCoordenadaGeografica(strNumRom, strCodemp, strCoordenadas: String);
var
  qryUpdt : TUniQuery;
begin
  if fCfgSis('APIROT') <> 'GOOGLE' then
    Exit;

  qryUpdt := fCriaQuery;

  try
    qryUpdt.Close;
    qryUpdt.SQL.Text :=
    ' UPDATE ENTCLI '+
    '    SET ETC_LATLON = :LATLON '+
    '  WHERE ETC_CODCLI = :CODCLI '+
    '    AND ETC_CIDENT = :CIDENT '+
    '    AND ETC_CEPENT = :CEPENT '+
    '    AND ETC_ENDENT = :ENDENT '+
    '    AND ETC_BAIENT = :BAIENT ';

    qryUpdt.ParamByName('LATLON').AsString := strCoordenadas;
    qryUpdt.ParamByName('CODCLI').AsString := FCliente.CodigoCliente;
    qryUpdt.ParamByName('CIDENT').AsString := FEnderecoEntrega.CodigoCidade;
    qryUpdt.ParamByName('CEPENT').AsString := FEnderecoEntrega.Cep;
    qryUpdt.ParamByName('ENDENT').AsString := FEnderecoEntrega.Endereco;
    qryUpdt.ParamByName('BAIENT').AsString := FEnderecoEntrega.Bairro;
    qryUpdt.ExecSql;

    qryUpdt.Close;
    qryUpdt.SQL.Text :=
    ' UPDATE ROMGERX '+
    '    SET GER_LATLON = :LATLON '+
    '  WHERE GER_NUMROM = :NUMROM '+
    '    AND GER_EMPROM = :EMPROM '+
    '    AND GER_NUMDOC = :NUMDOC '+
    '    AND GER_CODEMP = :CODEMP '+
    '    AND GER_ESPDOC = :ESPDOC '+
    '    AND GER_CODCLI = :CODCLI ';

    qryUpdt.ParamByName('LATLON').AsString := strCoordenadas;
    qryUpdt.ParamByName('NUMROM').AsString := strNumRom;
    qryUpdt.ParamByName('EMPROM').AsString := strCodemp;
    qryUpdt.ParamByName('NUMDOC').AsString := FNumeroDocumento;
    qryUpdt.ParamByName('CODEMP').AsString := FEmpresa.CodigoEmpresa;
    qryUpdt.ParamByName('ESPDOC').AsString := FEspecieDocumento;
    qryUpdt.ParamByName('CODCLI').AsString := FCliente.CodigoCliente;
    qryUpdt.ExecSql;
  finally
    FreeAndNil(qryUpdt);
  end;
end;

function TDocumento.StatusDocumento: IStatus;
begin
  Result := FStatusDocumento;
end;

function TDocumento.TempoPercurso: Integer;
begin
  Result := FTempoPercurso;
end;

{ TCliente }

constructor TCliente.Create(strCodCli, strNomCli: String);
begin
  FCodigoCliente := strCodCli;
  FNomeCliente := strNomCli;
end;

procedure TCliente.AbrirCadastro;
begin
  If Not fVerificaAcessoSistema('frmCadClientes') Then
    Exit;

  fExecutarModal(pAbrirCadastro, 'Carregando cadastro de clientes, Aguarde ...', '');
end;

function TCliente.CodigoCliente: String;
begin
  Result := FCodigoCliente;
end;

function TCliente.NomeCliente: String;
begin
  Result := FNomeCliente;
end;

procedure TCliente.pAbrirCadastro;
Var
  LfrmCadClientes: TfrmCadClientes;
begin
  Try
    Try
      pCriarFormularios(TfrmCadClientes, LfrmCadClientes);
      LfrmCadClientes.strCodClienteIniciarCadastro := FCodigoCliente;
      LfrmCadClientes.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    pFreeAndNil(LfrmCadClientes);
  End;
end;

{ TEmpresa }

constructor TEmpresa.Create(strCodEmp, strNomEmp: String);
begin
  FCodigoEmpresa := strCodEmp;
  FNomeEmpresa := strNomEmp;
end;

function TEmpresa.CodigoEmpresa: String;
begin
  Result := FCodigoEmpresa;
end;

function TEmpresa.NomeEmpresa: String;
begin
  Result := FNomeEmpresa;
end;

{ TFoto }

constructor TFoto.Create(strSeqGer: String; strFotoBase64, strFotoURL: String);
begin
  FSeqGer     := strSeqGer;
  FFotoBase64 := strFotoBase64;
  FFotoURL    := strFotoURL;
  FFotoStream := Nil;

  if fURLValida(strFotoURL) then
    FFotoStream := TBucketCitel.Instance.fGetFile(FFotoURL);
end;

destructor TFoto.Destroy;
begin
  if Assigned(FFotoStream) then
    FreeAndNil(FFotoStream);
  inherited;
end;

function TFoto.FotoBase64: String;
begin
  Result := FFotoBase64;
end;

function TFoto.FotoURL: String;
begin
  Result := FFotoURL;
end;

function TFoto.FotoStream: TBytesStream;
begin
  Result := FFotoStream;
end;

function TFoto.SeqGer: String;
begin
  Result := FSeqGer;
end;

{ TEnderecoEntrega }

constructor TEnderecoEntrega.Create(strCodCid, strNomCid, strUf, strEndereco, strBairro, strCep, strCoordenadas, strAltEnd: String);
begin
  FCodigoCidade := strCodCid;
  FCidade := strNomCid;
  FUf := strUf;
  FEndereco := strEndereco;
  FBairro := strBairro;
  FCep := strCep;
  FCoordenadas := strCoordenadas;
  FAltEnd := strAltEnd;
end;

function TEnderecoEntrega.Bairro: String;
begin
  Result := FBairro;
end;

function TEnderecoEntrega.Cep: String;
begin
  Result := FCep;
end;

function TEnderecoEntrega.Cidade: String;
begin
  Result := FCidade;
end;

function TEnderecoEntrega.CodigoCidade: String;
begin
  Result := FCodigoCidade;
end;

function TEnderecoEntrega.Coordenadas: String;
begin
  Result := FCoordenadas;
end;

function TEnderecoEntrega.EnderecoAlterado: Boolean;
begin
  Result := FAltEnd = 'S';
end;

function TEnderecoEntrega.Endereco: String;
begin
  Result := FEndereco;
end;

function TEnderecoEntrega.Uf: String;
begin
  Result := FUf;
end;

{ TAssinatura }

constructor TAssinatura.Create(strSeqGer, strAssinaturaBase64, strAssinaturaURL: String);
begin
  FSeqGer           := strSeqGer;
  FAssinaturaBase64 := strAssinaturaBase64;
  FAssinaturaURL    := strAssinaturaURL;
  FAssinaturaStream := Nil;

  if fURLValida(strAssinaturaURL) then
    FAssinaturaStream := TBucketCitel.Instance.fGetFile(FAssinaturaURL);
end;

destructor TAssinatura.Destroy;
begin
  if Assigned(FAssinaturaStream) then
    FreeAndNil(FAssinaturaStream);
  inherited;
end;

function TAssinatura.AssinaturaBase64: String;
begin
  Result := FAssinaturaBase64;
end;

function TAssinatura.AssinaturaURL: String;
begin
  Result := FAssinaturaURL;
end;

function TAssinatura.AssinaturaStream: TBytesStream;
begin
  Result := FAssinaturaStream;
end;

function TAssinatura.SeqGer: String;
begin
  Result := FSeqGer;
end;

{ TOcorrencia }

constructor TOcorrencia.Create(strSeqGer, strCodOco, strDesOco, strStatusEntregue: String;
ansMensagem: AnsiString; dtaHorOco: TDateTime);
begin
  FSeqGer := strSeqGer;
  FCodigoOcorrencia := strCodOco;
  FOcorrencia := strDesOco;
  FStatusEntregue := strStatusEntregue;
  FMensagem := ansMensagem;
  FDataHoraOcorrencia := dtaHorOco;
end;

function TOcorrencia.CodigoOcorrencia: String;
begin
  Result := FCodigoOcorrencia;
end;

function TOcorrencia.DataHoraOcorrencia: TDateTime;
begin
  Result := FDataHoraOcorrencia;
end;

function TOcorrencia.Mensagem: AnsiString;
begin
  Result := FMensagem;
end;

function TOcorrencia.Ocorrencia: String;
begin
  Result := FOcorrencia;
end;

function TOcorrencia.SeqGer: String;
begin
  Result := FSeqGer;
end;

function TOcorrencia.StatusEntregue: String;
begin
  Result := FStatusEntregue;
end;

{ TChat }

constructor TChat.Create(strCodOpe: String);
begin
  FContatos := TList<IContato>.Create;
  pCarregaContatos(False, strCodOpe);

  FContatosRecentes := TList<IContato>.Create;
  pCarregaContatos(True, strCodOpe);
end;

procedure TChat.pCarregaContatos(blnContatosRecentes: Boolean; strCodOpe: String);
var
  qryContatos: IMyQuery;
  qryUltimaMsg: IMyQuery;
  strSQL : String;
begin
  qryUltimaMsg := objCore.fCriarQuery;
  qryContatos  := objCore.fCriarQuery;

  qryContatos.Close;

  strSQL :=
  ' SELECT '+
  '   MOT_CODMOT, '+
  '   MOT_NOMMOT  '+
  IIF(blnContatosRecentes,
  '   , (SELECT '+
  '        COUNT(AUTOINCREM) '+
  '      FROM '+
  '        ENVMSG '+
  '      WHERE '+
  '        MSG_DESTIN = :CODOPE AND '+
  '        MSG_REMETE = MOT_CODMOT AND '+
  '        MSG_LIDA__ = "N" AND '+
  '        MSG_COMVIA = "TAENTREGUE" ) AS MSG_QTDMSG, '+
  '  MAX(MSG_DTAHOR) as MSG_DTAHOR ',
  '')+
  ' FROM '+
  '   CADMOT '+
  IIF(blnContatosRecentes,
  ' INNER JOIN ENVMSG '+
  '   ON (MOT_CODMOT = MSG_DESTIN OR MOT_CODMOT = MSG_REMETE) AND '+
  '       MSG_COMVIA = "TAENTREGUE"'+
  ' WHERE '+
  '   MSG_REMETE = :CODOPE OR '+
  '   MSG_DESTIN = :CODOPE '+
  ' GROUP BY '+
  '   MOT_CODMOT, '+
  '   MOT_NOMMOT  ',
  '');

  {* QUANDO FOR MENSAGENS RECENTES, ORDENAR DO MAIS RECENTE PARA O MAIS ANTIGO *}
  if (blnContatosRecentes) then
  begin
    strSQL := 'SELECT * FROM (' + strSQL + ') CONREC ' +
              'ORDER BY MSG_DTAHOR DESC ';
  end;

  qryContatos.SQL.Text := strSQL;

  if blnContatosRecentes then
  begin
    qryContatos.ParamByName('CODOPE').AsString := strCodOpe;
    FContatosRecentes.Clear;
  end
  else
    FContatos.Clear;

  qryContatos.Open;
  qryContatos.First;
  while not qryContatos.Eof do
  begin
    qryUltimaMsg.Close;
    qryUltimaMsg.SQL.Clear;
    qryUltimaMsg.SQL.Text :=
    'SELECT MSG_DTAHOR, MSG_MENSAG '+
    'FROM   ENVMSG '+
    'WHERE (MSG_REMETE = :CODOPE AND MSG_DESTIN = :CODMOT) '+
    '   OR (MSG_REMETE = :CODMOT AND MSG_DESTIN = :CODOPE) '+
    'ORDER BY MSG_DTAHOR DESC LIMIT 1 ';

    qryUltimaMsg.ParamByName('CODOPE').AsString := strCodOpe;
    qryUltimaMsg.ParamByName('CODMOT').AsString := qryContatos.FieldByName('MOT_CODMOT').AsString;

    qryUltimaMsg.Open;

    if blnContatosRecentes then
      FContatosRecentes.Add(TContato.Create(qryContatos.FieldByName('MOT_CODMOT').AsString,
                                            qryContatos.FieldByName('MOT_NOMMOT').AsString,
                                            qryUltimaMsg.FieldByName('MSG_MENSAG').AsString,
                                            qryContatos.FieldByName('MSG_QTDMSG').AsInteger,
                                            qryUltimaMsg.FieldByName('MSG_DTAHOR').AsDate))
    else
      FContatos.Add(TContato.Create(qryContatos.FieldByName('MOT_CODMOT').AsString,
                                    qryContatos.FieldByName('MOT_NOMMOT').AsString,
                                    '',
                                    0,
                                    0));

    qryContatos.Next;
  end;

end;

destructor TChat.Destroy;
begin
  if Assigned(FContatos) then
    FreeAndNil(FContatos);

  if Assigned(FContatosRecentes) then
    FreeAndNil(FContatosRecentes);

  inherited;
end;

function TChat.Contatos: TList<IContato>;
begin
  Result := FContatos;
end;

function TChat.ContatosRecentes: TList<IContato>;
begin
  Result := FContatosRecentes;
end;

function TChat.QuantidadeNovasMensagens: Integer;
begin
  Result := FQuantidadeNovasMensagens;
end;

procedure TChat.VerificaNovasMensagens(strCodOpe: String);
var
  qryNovasMensagens: IMyQuery;
begin
  qryNovasMensagens := objCore.fCriarQuery;
  qryNovasMensagens.Close;
  qryNovasMensagens.SQL.Text :=
  ' SELECT '+
  '   COUNT(AUTOINCREM) AS QTDMSG '+
  ' FROM '+
  '   ENVMSG '+
  ' WHERE '+
  '   MSG_DESTIN = :CODOPE AND '+
  '   MSG_LIDA__ = "N" ';

  qryNovasMensagens.ParamByName('CODOPE').AsString := strCodOpe;
  qryNovasMensagens.Open;

  FQuantidadeNovasMensagens := qryNovasMensagens.FieldByName('QTDMSG').AsInteger;
end;

{ TConversa }

constructor TConversa.Create(strAutInc, strDestinatario, strRemetente, strComunicacaoVia: String;
ansMensagem: AnsiString; dtaDtaHora: TDateTime);
begin
  FAutoincrem := strAutInc;
  FMensagem := ansMensagem;
  FDestinatario := strDestinatario;
  FRemetente := strRemetente;
  FDataHora := dtaDtaHora;
  FComunicacaoVia := strComunicacaoVia;
end;

function TConversa.Autoincrem: String;
begin
  Result := FAutoincrem;
end;

function TConversa.DataHora: TDateTime;
begin
  Result := FDataHora;
end;

function TConversa.Destinatario: String;
begin
  Result := FDestinatario;
end;

function TConversa.Mensagem: AnsiString;
begin
  Result := FMensagem;
end;

function TConversa.Remetente: String;
begin
  Result := FRemetente;
end;

function TConversa.ComunicacaoVia: String;
begin
  Result := FComunicacaoVia;
end;

{ TContato }

constructor TContato.Create(strCodigoContato, strNomeContato, strUltimaMsg: String; intQuantidadeMensagensNaoLidas: Integer;
                       dtaDataHoraUltimaMsg: TDatetime);
begin
  FCodigoContato  := strCodigoContato;
  FNomeContato    := strNomeContato;
  FUltimaMensagem := strUltimaMsg;
  FQuantidadeMensagensNaoLidas := intQuantidadeMensagensNaoLidas;
  FDataHoraUltimaMensagem := dtaDataHoraUltimaMsg;
end;

function TContato.Conversas: TList<IConversa>;
begin
  Result := FConversa;
end;

function TContato.DataHoraUltimaMensagem: TDatetime;
begin
  Result := FDataHoraUltimaMensagem;
end;

destructor TContato.Destroy;
begin
  if Assigned(FConversa) then
    FreeAndNil(FConversa);
  inherited;
end;

procedure TContato.CarregaConversa(strCodOpe: String);
var
  qryConversa: IMyQuery;
begin
  qryConversa := objCore.fCriarQuery;
  qryConversa.Close;
  qryConversa.SQL.Text :=
  ' UPDATE '+
  '   ENVMSG '+
  ' SET '+
  '   MSG_LIDA__ = "S" '+
  ' WHERE '+
  '   MSG_DESTIN = :CODOPE AND '+
  '   MSG_REMETE = :CODREM AND '+
  '   MSG_COMVIA = "TAENTREGUE" ';

  qryConversa.ParamByName('CODOPE').AsString := strCodOpe;
  qryConversa.ParamByName('CODREM').AsString := FCodigoContato;
  qryConversa.ExecSQL;

  if Assigned(FConversa) then
    FreeAndNil(FConversa);

  FConversa := TList<IConversa>.Create;

  qryConversa.Close;
  qryConversa.SQL.Text :=
  ' SELECT '+
  '   AUTOINCREM, '+
  '   MSG_MENSAG, '+
  '   MSG_DESTIN, '+
  '   MSG_REMETE, '+
  '   MSG_DTAHOR, '+
  '   MSG_COMVIA '+
  ' FROM '+
  '   ENVMSG '+
  ' WHERE '+
  '   (MSG_REMETE = :CODOPE OR MSG_DESTIN = :CODOPE) AND '+
  '   (MSG_REMETE = :CODMOT OR MSG_DESTIN = :CODMOT) AND '+
  '    MSG_COMVIA = "TAENTREGUE" '+
  ' ORDER BY '+
  '   MSG_DTAHOR ';

  qryConversa.ParamByName('CODOPE').AsString := strCodOpe;
  qryConversa.ParamByName('CODMOT').AsString := FCodigoContato;

  qryConversa.Open;

  while not qryConversa.Eof do
  begin
    FConversa.Add(TConversa.Create(qryConversa.FieldByName('AUTOINCREM').AsString,
                                   qryConversa.FieldByName('MSG_DESTIN').AsString,
                                   qryConversa.FieldByName('MSG_REMETE').AsString,
                                   qryConversa.FieldByName('MSG_COMVIA').AsString,
                                   qryConversa.FieldByName('MSG_MENSAG').AsAnsiString,
                                   StrToDateTime(FormatDateTime('dd/MM/yyyy hh:mm:ss',
                                                     StrToDateTime(qryConversa.FieldByName('MSG_DTAHOR').AsString)))));

    qryConversa.Next;
  end;

end;

procedure TContato.EnviarMensagem(strCodOpe: String; ansMensagem: AnsiString);
var
  qryMensagem: IMyQuery;
begin
  qryMensagem := objCore.fCriarQuery;
  qryMensagem.Close;
  qryMensagem.SQL.Text :=
  ' INSERT INTO ENVMSG '+
  '  (AUTOINCREM, '+
  '   MSG_REMETE, '+
  '   MSG_DESTIN, '+
  '   MSG_MENSAG, '+
  '   MSG_LIDA__, '+
  '   MSG_NOMREM, '+
  '   MSG_DTAHOR, '+
  '   MSG_COMVIA) '+
  ' VALUES '+
  '  (:AUTINC, '+
  '   :REMETE, '+
  '   :DESTIN, '+
  '   :MENSAG, '+
  '   :LIDA__, '+
  '   :NOMREM, '+
  '   :DTAHOR, '+
  '   :COMVIA) ';

  qryMensagem.ParamByName('AUTINC').AsString     := fRetAutoIncrem('ENVMSG', VS_strCodEmp);
  qryMensagem.ParamByName('REMETE').AsString     := strCodOpe;
  qryMensagem.ParamByName('DESTIN').AsString     := FCodigoContato;
  qryMensagem.ParamByName('MENSAG').AsAnsiString := ansMensagem;
  qryMensagem.ParamByName('LIDA__').AsString     := 'N';
  qryMensagem.ParamByName('NOMREM').AsString     := fRetNomeOperador(strCodOpe);
  qryMensagem.ParamByName('DTAHOR').AsDateTime   := fNow;
  qryMensagem.ParamByName('COMVIA').AsString     := 'TAENTREGUE';
  qryMensagem.ExecSql;

  FDataHoraUltimaMensagem := fNow;
  FUltimaMensagem := String(ansMensagem);
end;

function TContato.CodigoContato: String;
begin
  Result := FCodigoContato;
end;

function TContato.NomeContato: String;
begin
  Result := FNomeContato;
end;

function TContato.QuantidadeMensagensNaoLidas: Integer;
begin
  Result := FQuantidadeMensagensNaoLidas;
end;

function TContato.UltimaMensagem: String;
begin
  Result := FUltimaMensagem;
end;

{ TRastreamento }

constructor TRastreamento.Create(strLatLon: String; dtaDtaHor: TDateTime);
begin
  FCoordenadas := strLatLon;
  FDataHoraCoordenadas := dtaDtaHor;
end;

function TRastreamento.Coordenadas: String;
begin
  Result := FCoordenadas;
end;

function TRastreamento.DataHoraCoordenadas: TDateTime;
begin
  Result := FDataHoraCoordenadas;
end;

{ TItem }

constructor TItem.Create(strAutoincrem, strDetAutInc, strCodigoItem, strItem,
  strUnidadeDeMedida: String; fltTotalitem, fltQuantidade, fltQuantidadeEntregue,
  fltQuantidadeAvariada, fltQuantidadeFaltante: Double);
begin
  FAutoincrem := strAutoincrem;
  FDetAutInc := strDetAutInc;
  FCodigoItem := strCodigoItem;
  FItem := strItem;
  FUnidadeDeMedida := strUnidadeDeMedida;
  FTotalItem := fltTotalitem;
  FQuantidade := fltQuantidade;
  FQuantidadeEntregue := fltQuantidadeEntregue;
  FQuantidadeAvariada := fltQuantidadeAvariada;
  FQuantidadeFaltante := fltQuantidadeFaltante;
  FLiberarItem := False;
end;

function TItem.DetAutInc: String;
begin
  Result := FDetAutInc;
end;

function TItem.Autoincrem: String;
begin
  Result := FAutoincrem;
end;

function TItem.CodigoItem: String;
begin
  Result := FCodigoItem;
end;

function TItem.Item: String;
begin
  Result := FItem;
end;

procedure TItem.SetLiberarItem(blnLiberar: Boolean);
begin
  FLiberarItem := blnLiberar;
end;

function TItem.LiberarItem: Boolean;
begin
  Result := FLiberarItem;
end;

function TItem.Quantidade: Double;
begin
  Result := FQuantidade;
end;

function TItem.QuantidadeAvariada: Double;
begin
  Result := FQuantidadeAvariada;
end;

function TItem.QuantidadeEntregue: Double;
begin
  Result := FQuantidadeEntregue;
end;

function TItem.QuantidadeFaltante: Double;
begin
  Result := FQuantidadeFaltante;
end;

function TItem.TotalItem: Double;
begin
  Result := FTotalItem;
end;

function TItem.UnidadeDeMedida: String;
begin
  Result := FUnidadeDeMedida;
end;

{ TPendencia }

constructor TPendencia.Create(const strFiltro: String);
begin
  CarregarDocsComItensBaixadosParcialmente(strFiltro);
end;

destructor TPendencia.Destroy;
begin
  if Assigned(FDocsComItensBaixadosParcialmente) then
    FreeAndNil(FDocsComItensBaixadosParcialmente);

  inherited;
end;

procedure TPendencia.CarregarDocsComItensBaixadosParcialmente(const strFiltro: String);
var
  qryDocumento: IMyQuery;
begin
  if Assigned(FDocsComItensBaixadosParcialmente) then
    FreeAndNil(FDocsComItensBaixadosParcialmente);

  FDocsComItensBaixadosParcialmente := TList<IDocumento>.Create;

  qryDocumento := objCore.fCriarQuery;
  qryDocumento.Close;
  qryDocumento.SQL.Text :=
  ' SELECT '+
  '   R.AUTOINCREM, '+
  '   R.GER_NUMROM, '+
  '   R.GER_NUMDOC, '+
  '   R.GER_ESPDOC, '+
  '   R.GER_DTAINI, '+
  '   R.GER_HORINI, '+
  '   R.GER_DTABAI, '+
  '   R.GER_HORBAI, '+
  '   R.GER_CODEMP, '+
  '   R.GER_CODCLI, '+
  '   R.GER_CIDENT, '+
  '   R.GER_ENDENT, '+
  '   R.GER_BAIENT, '+
  '   R.GER_CEPENT, '+
  '   R.GER_ORDIMP, '+
  '   R.GER_DISTAN, '+
  '   R.GER_TMPENT, '+
  '   R.GER_NOMREC, '+
  '   R.GER_NUMROM, '+
  '   R.GER_EMPROM, '+
  '   R.GER_LATLON, '+
  '   SUM(D.DET_QTDROM) AS DET_QTDROM, '+
  '   R.GER_CODMOT, '+
  '   M.MOT_NOMMOT, '+
  '   E.EMP_NOMEMP, '+
  '   R.GER_ALTEND, '+
  '   IF(R.GER_ESPDOC = "OX", '+
  '      R.GER_MEN001, '+
  '      IFNULL(' + fSQLIFClienteConsumidor('CL.CLI_NOMCLI', 'R.GER_NOMCON', 'CL.CLI_NOMCLI') + ', CE.EMP_NOMEMP) ) AS CLI_NOMCLI, '+
  '   C.CID_NOMCID, '+
  '   C.CID_ESTADO, '+
  '   0 AS GER_DTENTR, '+
  '   "" AS OCR_TIPOCR, '+
  '   R.GER_TIPDOC '+
  ' FROM '+
  '   ROMGERX R '+
  ' INNER JOIN CADMOT M ON '+
  '   GER_CODMOT = MOT_CODMOT '+
  ' LEFT JOIN ROMDETX D '+
  '   ON R.AUTOINCREM = D.DET_SEQGER '+
  ' LEFT JOIN CADEMP E '+
  '   ON R.GER_CODEMP = E.EMP_CODEMP '+
  ' LEFT JOIN CADCLI CL '+
  '   ON R.GER_CODCLI = CL.CLI_CODCLI AND R.GER_FILIAL = "N" '+
  ' LEFT JOIN CADEMP CE '+
  '   ON R.GER_CODEMP = CE.EMP_CODEMP AND R.GER_FILIAL = "S" '+
  ' LEFT JOIN CADCID C '+
  '   ON R.GER_CIDENT = C.CID_CODCID '+
  ' WHERE '+
  '   R.GER_DTABAI IS NOT NULL AND '+
  '   D.DET_QTDROM <> D.DET_QTDBAI AND '+
  '   R.GER_EMPROM = :EMPROM AND '+
  '   D.DET_LIBERA = "N" AND '+
  '   R.GER_BAIAPP = "S" '+
  '   AND ( '+
  '        IF(R.GER_ESPDOC = "OX", '+
  '           R.GER_MEN001, '+
  '           IFNULL(' + fSQLIFClienteConsumidor('CL.CLI_NOMCLI', 'R.GER_NOMCON', 'CL.CLI_NOMCLI') + ', CE.EMP_NOMEMP) ) LIKE :FILTRO '+
  '     OR R.GER_NUMDOC LIKE :FILTRO '+
  '   ) '+
  ' GROUP BY '+
  '   R.AUTOINCREM, '+
  '   R.GER_NUMROM, '+
  '   R.GER_NUMDOC, '+
  '   R.GER_ESPDOC, '+
  '   R.GER_DTAINI, '+
  '   R.GER_HORINI, '+
  '   R.GER_DTABAI, '+
  '   R.GER_HORBAI, '+
  '   R.GER_CODEMP, '+
  '   R.GER_CODCLI, '+
  '   R.GER_CIDENT, '+
  '   R.GER_ENDENT, '+
  '   R.GER_BAIENT, '+
  '   R.GER_CEPENT, '+
  '   R.GER_ORDIMP, '+
  '   R.GER_DISTAN, '+
  '   R.GER_TMPENT, '+
  '   R.GER_NOMREC, '+
  '   R.GER_NUMROM, '+
  '   R.GER_EMPROM, '+
  '   R.GER_LATLON, '+
  '   R.GER_CODMOT, '+
  '   M.MOT_NOMMOT, '+
  '   E.EMP_NOMEMP, '+
  '   CLI_NOMCLI,   '+
  '   C.CID_NOMCID, '+
  '   C.CID_ESTADO, '+
  '   R.GER_ALTEND, '+
  '   GER_DTENTR,   '+
  '   OCR_TIPOCR,   '+
  '   R.GER_TIPDOC  '+
  ' ORDER BY '+
  '   GER_DTABAI, '+
  '   GER_HORBAI ';

    qryDocumento.ParamByName('EMPROM').AsString := VS_strCodEmp;
    qryDocumento.ParamByName('FILTRO').AsString := '%'+strFiltro+'%';
    qryDocumento.Open;

  qryDocumento.First;
  while not qryDocumento.Eof do
  begin
    FDocsComItensBaixadosParcialmente.Add(TDocumento.Create(qryDocumento,
                                          tpDocsComItensBaixadosParcialmente));
    qryDocumento.Next;
  end;
end;

function TPendencia.LiberarItensBaixadosParcialmenteParaNovoRomaneio(Documento: IDocumento): Boolean;
var
  Item: IItem;
  qryRomGerX,
  qryRomDetX: IMyQuery;

  dtaDtaEnt,
  hraHraEnt: TDateTime;
begin
  Result := True;
  
  qryRomGerX := objCore.fCriarQuery;
  qryRomDetX := objCore.fCriarQuery;

  qryRomGerX.Close;
  qryRomGerX.SQL.Text :=
  ' SELECT '+
  '   GER_NUMROM, '+
  '   GER_CODEMP, '+
  '   GER_CODVEN, '+
  '   GER_DTAENT, '+
  '   GER_HORENT, '+
  '   GER_CODMOT, '+
  '   GER_CODMOT, '+
  '   GER_CIDCON, '+
  '   GER_CODREG, '+
  '   GER_CODAJ1, '+
  '   GER_CODAJ2, '+
  '   GER_CODAJ3, '+
  '   GER_CODAJ4, '+
  '   GER_OBSFEC, '+
  '   GER_CODTRA, '+
  '   GER_PLAVEI, '+
  '   GER_DTAROM, '+
  '   GER_HORROM, '+
  '   GER_NOMTAB, '+
  '   GER_DTAENT AS GER_DTADOC, '+
  '   GER_VOLUME  '+
  ' FROM '+
  '   ROMGERX '+
  ' WHERE '+
  '   AUTOINCREM = :AUTINC ';

  qryRomGerX.ParamByName('AUTINC').AsString := Documento.AutoIncrem;
  qryRomGerX.Open;

  if qryRomGerX.IsEmpty then
    Exit(False);

  fStartTransaction;
  Try
    for Item in Documento.Itens do
    begin
      if Item.LiberarItem then
      begin
        Result := Result And fRemoverItemDocto(Documento.NumeroDocumento,
                                               Documento.EspecieDocumento,
                                               Documento.Empresa.CodigoEmpresa,
                                               Documento.Cliente.CodigoCliente,
                                               '',
                                               Item.CodigoItem,
                                               ((Item.Quantidade - Item.QuantidadeEntregue) *
                                               (Item.TotalItem / Item.Quantidade)),
                                               (Item.Quantidade - Item.QuantidadeEntregue),
                                               Item.DetAutInc,
                                               qryRomGerX.FieldByName('GER_NOMTAB').AsString);

        if (Result) and (Item.QuantidadeEntregue = 0.00) then
        begin
          qryRomDetX.Close;
          qryRomDetX.SQL.Text :=
          ' SELECT '+
          '   DET_AUTINC '+
          ' FROM '+
          '   ROMDETX '+
          ' WHERE '+
          '   AUTOINCREM = :AUTINC ';

          qryRomDetX.ParamByName('AUTINC').AsString := Item.AutoIncrem;
          qryRomDetX.Open;

          dtaDtaEnt := 0;
          if not fEmptyStr(qryRomGerX.FieldByName('GER_DTAENT').AsString) then
            dtaDtaEnt := StrToDateTime(FormatDateTime('dd/MM/yyyy',
                                                      StrToDate(qryRomGerX.FieldByName('GER_DTAENT').AsString))
                                       );

          hraHraEnt := 0;
          if not fEmptyStr(qryRomGerX.FieldByName('GER_HORENT').AsString) then
            hraHraEnt := StrToDateTime(FormatDateTime('hh:mm:ss',
                                                      StrToTime(qryRomGerX.FieldByName('GER_HORENT').AsString))
                                       );

          Result := fRemoverRomDet(qryRomGerX.FieldByName('GER_NUMROM').AsString,
                                   Documento.AutoIncrem,
                                   qryRomGerX.FieldByName('GER_CODEMP').AsString,
                                   Item.AutoIncrem,
                                   Documento.NumeroDocumento,
                                   Documento.EspecieDocumento,
                                   Documento.Cliente.CodigoCliente,
                                   qryRomGerX.FieldByName('GER_CODVEN').AsString,
                                   Documento.Motorista.CodigoMotorista,
                                   dtaDtaEnt,
                                   hraHraEnt,
                                   Item.CodigoItem,
                                   Item.Quantidade,
                                   0.00,
                                   qryRomDetX.FieldByName('DET_AUTINC').AsString,
                                   '',
                                   '',
                                   qryRomGerX.FieldByName('GER_DTADOC').AsDate,
                                   qryRomGerX.FieldByName('GER_VOLUME').AsFloat);
        end
        else
          Result := Result and LiberarItensBaixadosParcialmente(Documento, False);
      end;

      if not Result then
        Break;
    end;

    Result := Result and fAnalisaItensNoRomaneio(Documento, qryRomGerX, qryRomDetX);

    if Result then
      fCommit
    else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollback;
      Result := False;
      pMensagensErro(E.Message, '[TPendencia.LiberarItensBaixadosParcialmenteParaNovoRomaneio]');
    End;
  End;

end;

function TPendencia.fAnalisaItensNoRomaneio(Documento: IDocumento; qryRomGerX, qryRomDetX: IMyQuery): Boolean;
var
  dtaDtaRom,
  hraHraRom: TDateTime;
  qryDelRomGerX: TUniQuery;
begin
  Result := True;

  qryRomDetX.Close;
  qryRomDetX.SQL.Text :=
  ' SELECT '+
  '   COUNT(1) AS QTD '+
  ' FROM '+
  '   ROMDETX '+
  ' WHERE '+
  '   DET_SEQGER = :SEQGER ';

  qryRomDetX.ParamByName('SEQGER').AsString := Documento.AutoIncrem;
  qryRomDetX.Open;

  if qryRomDetX.FieldByName('QTD').AsInteger = 0 then
  begin
    dtaDtaRom := 0;
    if not fEmptyStr(qryRomGerX.FieldByName('GER_DTAROM').AsString) then
      dtaDtaRom := StrToDateTime(FormatDateTime('dd/MM/yyyy',
                                                StrToDate(qryRomGerX.FieldByName('GER_DTAROM').AsString))
                                 );

    hraHraRom := 0;
    if not fEmptyStr(qryRomGerX.FieldByName('GER_HORROM').AsString) then
      hraHraRom := StrToDateTime(FormatDateTime('hh:mm:ss',
                                                StrToTime(qryRomGerX.FieldByName('GER_HORROM').AsString))
                                 );

    Result := fGravaRomDel(Documento.NumeroDocumento,
                           Documento.EspecieDocumento,
                           Documento.Empresa.CodigoEmpresa,
                           Documento.Cliente.CodigoCliente,
                           qryRomGerX.FieldByName('GER_NUMROM').AsString,
                           qryRomGerX.FieldByName('GER_CODVEN').AsString,
                           qryRomGerX.FieldByName('GER_CODMOT').AsString,
                           qryRomGerX.FieldByName('GER_CIDCON').AsString,
                           qryRomGerX.FieldByName('GER_CODREG').AsString,
                           qryRomGerX.FieldByName('GER_CODAJ1').AsString,
                           qryRomGerX.FieldByName('GER_CODAJ2').AsString,
                           qryRomGerX.FieldByName('GER_CODAJ3').AsString,
                           qryRomGerX.FieldByName('GER_CODAJ4').AsString,
                           qryRomGerX.FieldByName('GER_OBSFEC').AsString,
                           qryRomGerX.FieldByName('GER_CODTRA').AsString,
                           qryRomGerX.FieldByName('GER_PLAVEI').AsString,
                           dtaDtaRom,
                           hraHraRom,
                           '');

    qryDelRomGerX := fCriaQuery;
    try
      {*** grava documento na del_romgerx ***}
      qryDelRomGerX.Close;
      qryDelRomGerX.SQL.Text :=
      ' SELECT * FROM ROMGERX '+
      ' WHERE '+
      '   AUTOINCREM = :AUTINC ';

      qryDelRomGerX.ParamByName('AUTINC').AsString := Documento.AutoIncrem;
      qryDelRomGerX.Open;

      fVerificaIntegridade('PainelEntregas', 'ROMGERX', qryDelRomGerX);

      qryDelRomGerX.Close;
      qryDelRomGerX.SQL.Text :=
      ' DELETE FROM '+
      '   ROMGERX '+
      ' WHERE '+
      '   AUTOINCREM = :AUTINC ';

      qryDelRomGerX.ParamByName('AUTINC').AsString := Documento.AutoIncrem;
      qryDelRomGerX.ExecSql;
    finally
      FreeAndNil(qryDelRomGerX);
    end;
  end;
end;

function TPendencia.LiberarItensBaixadosParcialmenteParaDevolucao(Documento: IDocumento): Boolean;
var
  Item: IItem;
begin
  Result := LiberarItensBaixadosParcialmente(Documento);

  for Item in Documento.Itens do
  begin
    if Item.LiberarItem then
    begin
      if fPergunta('Realizar devolução agora?') then
      begin
        pCriarFormularios(TfrmFatVendas, frmFatVendas);
        try
          frmFatVendas.strOpcDoc          := 'DV';
          frmFatVendas.strTitulo          := ' > Principal > Faturamento > Emissão de Faturamento > Devolução';
          frmFatVendas.blnApenasPrazo     := False;
          frmFatVendas.blnApenasVista     := False;
          frmFatVendas.blnDevBaiEntFut    := False;
          frmFatVendas.blnSatComplementar := False;
          frmFatVendas.blnNFCeComplementar:= False;
          frmFatVendas.strCodCliDef       := Documento.Cliente.CodigoCliente;
          frmFatVendas.edtCodCli.Text     := Documento.Cliente.CodigoCliente;
          frmFatVendas.blnConEqu          := False;

          frmFatVendas.ShowModal;
        finally
          pFreeAndNil(frmFatVendas);
        end;
      end;

      Break;
    end;
  end
end;

function TPendencia.LiberarItensBaixadosParcialmente(Documento: IDocumento; blnStartTransaction: Boolean = True): Boolean;
var
  Item: IItem;
  qryLibera: IMyQuery;
begin
  Result := True;

  try
    if blnStartTransaction then
      fStartTransaction;

    qryLibera := objCore.fCriarQuery;

    for Item in Documento.Itens do
    begin
      if Item.LiberarItem then
      begin
        qryLibera.Close;
        qryLibera.SQL.Text :=
        ' UPDATE '+
        '   ROMDETX '+
        ' SET '+
        '   DET_LIBERA = "S" '+
        ' WHERE '+
        '   AUTOINCREM = :AUTINC ';

        qryLibera.ParamByName('AUTINC').AsString := Item.Autoincrem;
        qryLibera.ExecSQL;
      end;
    end;

    if blnStartTransaction then
      fCommit;

  except
    on E: Exception do
    begin
      Result := False;

      if blnStartTransaction then
        fRollback;

      pMensagensErro(E.Message, '[TPendencia.LiberarItensBaixadosParcialmente]');
    end;
  end;
end;

function TPendencia.DocsComItensBaixadosParcialmente: TList<IDocumento>;
begin
  Result := FDocsComItensBaixadosParcialmente;
end;

{ TAlerta }

function TAlerta.Alerta: String;
begin
  Result := FAlerta;
end;

constructor TAlerta.Create(strIdentificacao, strObservacao, strAlerta: String;
  dtaDataHora: TDateTime);
begin
  FIdentificacaoAlerta := strIdentificacao;
  FAlerta := strAlerta;
  FObservacaoAlerta := strObservacao;
  FDataHoraAlerta := dtaDataHora;
end;

function TAlerta.DataHoraAlerta: TDateTime;
begin
  Result := FDataHoraAlerta;
end;

function TAlerta.IdentificacaoAlerta: String;
begin
  Result := FIdentificacaoAlerta;
end;

function TAlerta.ObservacaoAlerta: String;
begin
  Result := FObservacaoAlerta;
end;

{ TVeiculo }

constructor TVeiculo.Create(strMarcaVeiculo, strModeloVeiculo, strPlacaVeiculo,
  strCorVeiculo: String);
begin
  FMarcaVeiculo := strMarcaVeiculo;
  FModeloVeiculo := strModeloVeiculo;
  FPlacaVeiculo := strPlacaVeiculo;
  FCorVeiculo := strCorVeiculo;
end;

function TVeiculo.MarcaVeiculo: String;
begin
  Result := FMarcaVeiculo;
end;

function TVeiculo.ModeloVeiculo: String;
begin
  Result := FModeloVeiculo;
end;

function TVeiculo.PlacaVeiculo: String;
begin
  Result := FPlacaVeiculo;
end;

function TVeiculo.CorVeiculo: String;
begin
  Result := FCorVeiculo;
end;

{ TRotaGPX }

constructor TRotaGPX.Create(tpRota: ITipoRota; strGPX: String; fltDistancia: Double; intTempo: Integer);
begin
  FTipoRota := tpRota;
  FGPXFile := strGPX;
  FDistancia := fltDistancia;
  FTempo := intTempo;
end;

function TRotaGPX.Distancia: Double;
begin
  Result := FDistancia;
end;

function TRotaGPX.GPXFile: String;
begin
  Result := FGPXFile;
end;

function TRotaGPX.Tempo: Integer;
begin
  Result := FTempo;
end;

function TRotaGPX.TipoRota: ITipoRota;
begin
  Result := FTipoRota;
end;

{ TTransportadora }

function TTransportadora.CodigoTransportadora: String;
begin
  Result := FCodigoTransportadora;
end;

constructor TTransportadora.Create(strCodTra, strNomTra: String);
begin
  FCodigoTransportadora := strCodTra;
  FNomeTransportadora := strNomTra;
end;

function TTransportadora.NomeTransportadora: String;
begin
  Result := FNomeTransportadora;
end;

end.
