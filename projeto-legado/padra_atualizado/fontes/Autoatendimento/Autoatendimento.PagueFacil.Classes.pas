unit Autoatendimento.PagueFacil.Classes;

interface

uses
  System.SysUtils, System.StrUtils, System.Classes, Autoatendimento.PagueFacil.Interfaces,
  Shared.Functions.Core, Shared.Functions.DataSet, System.Generics.Collections, untFuncFat,
  Faturamento.Classes.TFaturador.EmitirNFCe, untTiposPix;

type
  TAutoatendimentoPagueFacilEndereco = class(TInterfacedObject, IAutoatendimentoPagueFacilEndereco)
  private
    FLogradouro: String;
    FBairro: String;
    FCep: String;
    FComplemento: String;
    FCidade: String;
    FEstado: String;
  protected
    constructor Create(ALogradouro, ABairro, ACep, AComplemento, ACidade, AEstado: String);
  public
    function Logradouro: String;
    function Bairro: String;
    function Cep: String;
    function Complemento: String;
    function Cidade: String;
    function Estado: String;
  end;

  TAutoatendimentoPagueFacilCliente = class(TInterfacedObject, IAutoatendimentoPagueFacilCliente)
  private
    FDados: IMyCampoTabela;
    FEndereco: IAutoatendimentoPagueFacilEndereco;
  protected
    constructor Create(ACodigo, ADocumento, AEmpresa: String);
  public
    function Codigo: String;
    function Nome: String;
    function Documento: String;
    function Telefone: String;
    function Endereco: IAutoatendimentoPagueFacilEndereco;
    function EhConsumidor: Boolean;
  end;

  TAutoatendimentoPagueFacilEntrega = class(TInterfacedObject, IAutoatendimentoPagueFacilEntrega)
  private
    FEndereco: IAutoatendimentoPagueFacilEndereco;
  protected
    constructor Create(ACodigoCliente, AEnderecoID: String);
  public
    function Endereco: IAutoatendimentoPagueFacilEndereco;
  end;

  TAutoatendimentoPagueFacilPagamento = class(TInterfacedObject,
    IAutoatendimentoPagueFacilPagamento)
  private
    FCondicaoCodigo: String;
    FCondicaoDescricao: String;
    FCondicaoRecPix: String;
    FParcelas: String;
    FFormaCodigo: String;
    FFormaDescricao: String;
    FFgo_QtdPac: Integer;
    FCar_TipCar: string;

    FPermiteReceberPix: Boolean;
    FAutoIncremChavePix: String;

    function PermiteUtilizacaoDoPixCitel: Boolean;
  protected
    Constructor Create(AParcelas, ACondicaoCodigo, AFormaCodigo, ACodCar: String;
      AQtdeParc: Integer);
  public
    function CondicaoCodigo: String;
    function CondicaoDescricao: String;
    function Parcelas: String;
    function FormaCodigo: String;
    function FormaDescricao: String;
    function QtdeParcelasCartao: Integer;
    function TipoCartao: string;
    function PermiteReceberPix: Boolean;
    function AutoIncremChavePix: String;
    function CondicaoRecPix: String;
  end;

  TAutoatendimentoPagueFacilPedidoItens = class(TInterfacedObject,
    IAutoatendimentoPagueFacilPedidoItens)
  private
    FDados: IMyCampoTabela;
  protected
    constructor Create(AItemPedidoId: String);
  public
    function Codigo: String;
    function Descricao: String;
    function Unidade: String;
    function ValorUnitario: Double;
    function Quantidade: Double;
    function ValorTotal: Double;
    function DescontoEspecial: Double;
    function DespesasAcessorias: Double;
    function ValorFrete: Double;
    function ValorIPI: Double;
    function ValorST: Double;
    function ValorFCP_ST: Double;
    function ValorContabil: Double;
  end;

  TAutoatendimentoPagueFacilPedido = class(TInterfacedObject, IAutoatendimentoPagueFacilPedido)
  private
    FDados: IMyCampoTabela;
    FCliente: IAutoatendimentoPagueFacilCliente;
    FEntrega: IAutoatendimentoPagueFacilEntrega;
    FPagamento: IAutoatendimentoPagueFacilPagamento;
    FProdutos: TList<IAutoatendimentoPagueFacilPedidoItens>;

    FAutoIncremPixVinculadoAoPedido: String;

    procedure CarregarProdutos;
  protected
    constructor Create(APedido, AEmpresa: String);
  public
    destructor Destroy; override;
    procedure AlteraCPFConsumidor(ACPF : String);
    procedure AlterarNotaFiscalPaulista(ANotPau: String);
    function PerguntaCPFNaVenda: Boolean;
    function Numero: String;
    function Especie: String;
    function Empresa: String;
    function DataEmissao: TDateTime;
    function HoraEmissao: TDateTime;
    function TotalProdutos: Double;
    function DescontoEspecial: Double;
    function DespesasAcessorias: Double;
    function ValorFrete: Double;
    function TotalIPI: Double;
    function TotalST: Double;
    function TotalFCP_ST: Double;
    function ValorContabil: Double;
    function Faturado: Boolean;
    function TemAdiantamento: Boolean;
    function CodigoBarras: String;
    function NotaFiscalPaulista: String;
    function AutoIncremPixVinculadoAoPedido: String;
    function Cliente: IAutoatendimentoPagueFacilCliente;
    function Entrega: IAutoatendimentoPagueFacilEntrega;
    function Pagamento: IAutoatendimentoPagueFacilPagamento;
    function Produtos: TList<IAutoatendimentoPagueFacilPedidoItens>;
  end;

type
  TAutoatendimentoPagueFacilEmitirNFCe = class(TEmitirNFCe)
  protected
    procedure OnSetParametros; override;
  end;

  TAutoatendimentoPagueFacilRecebimentoPedido = class(TInterfacedObject,
    IAutoatendimentoPagueFacilRecebimentoPedido)
  private const
    FOrigem = 'CTR';
    FRotinaPagueFacil = True;
  private
    FEmpresa: String;
    FCodigoBarras: String;
    FPedido: IAutoatendimentoPagueFacilPedido;
    FAdiantamentoRealizado: Boolean;
    FTipoCartao: string;
    FParcelas: Integer;
  private
    procedure IniciarObjetos;
    procedure LimparObjetos;
    procedure ValidarPortador;
    procedure ValidarPlanoContas;
    procedure ValidarTef;
    procedure ValidarPedido;
    procedure ValidarEmitirNFCe;
    procedure ValidarCodBarras;
    procedure ValidarAdiantamento;
    procedure ValidarQtdParcelas;
    procedure ValidarPedidoComPix;
    procedure ExecutarValidacoes;
    procedure RaiseError(AMsg: String);

    function RetornaDadosPedidoGeracaoPix: TDadosRequisicaoPixAVista;
    function ReceberPixQRCode(var ADadosRequisicao: String): String;
    procedure CarregaDadosObjetoPix(var APixRecebido: TDadosRetornoPixConsulta;
                                    LJsonRetorno,
                                    LJsonRequisicao: String);
  public
    constructor Create();
    destructor Destroy; override;
    function Pedido: IAutoatendimentoPagueFacilPedido;
    function CarregarPedido(APedido: String): IAutoatendimentoPagueFacilRecebimentoPedido;
    function RealizarAdiantamento: IAutoatendimentoPagueFacilRecebimentoPedido;
    function EmitirNFCe: IAutoatendimentoPagueFacilRecebimentoPedido;
    function ModoEmitirNFCe: Boolean;
    function TipoCartao: string;
    function Parcelas: Integer;
    procedure SetTipoCartao(AValue: string);
    procedure SetParcelas(AValue: Integer);
    function SolicitaDadosCartao: Boolean;
    function NumeroMaximoParcelas: Integer;
    function UsaComanda: Boolean;
    function TravaFormaNegociada : Boolean;
    function TravaFormaNegociadaPelaConPag : Boolean;
    function CPFValido(ACPF : String): Boolean;
    function FormataCPF(ACPF : String) : String;
    function NFCeAutorizada: Boolean;
  end;

  function fBuscaQtdParcelasConPag(strConPag : String) : Integer;
  function fBuscaTipCarConPag(strConPag : String) : String;
  function fVerificaConfigQtdParcelasPagueFacil : Boolean;

implementation

uses
  untFuncoesSimples, untFuncoesGenerica, untAdiantamentoCliente,
  untTypesSistema, untFatDigCodBarrasComanda, untTFuncoesPixAutcom,
  untTFuncoesAuxiliaresPix, untTPixDao;

const
  CADCLI_CAMPOS: Array [0 .. 9] Of String =
    ('CLI_CODCLI as CODCLI',
     'CLI_NOMCLI AS NOMCLI',
     'CLI_C_G_C_ AS C_G_C_',
     'CLI_FONE01 AS FONE01',
     'CLI_CODCID AS CODCID',
     'CLI_C_E_P_ AS C_E_P_',
     'CLI_ENDERE AS ENDERE',
     'CLI_BAIRRO AS BAIRRO',
     'CLI_ENDNUM AS ENDNUM',
     'CLI_ENDCOM AS ENDCOM');

  CLICON_CAMPOS: Array [0 .. 07] Of String =
    ('FGO_CODCLI AS CODCLI',
     'FGO_NOMCON AS NOMCLI',
     'FGO_CGCCON AS C_G_C_',
     'FGO_TELCON AS FONE01',
     'FGO_CIDCON AS CODCID',
     'FGO_CEPCON AS C_E_P_',
     'FGO_ENDCON AS ENDERE',
     'FGO_BAICON AS BAIRRO');

  ENTCLI_CAMPOS: Array [0 .. 06] Of String = ('ETC_CODCLI', 'ETC_ENDFAT', 'ETC_CIDENT',
    'ETC_ENDENT', 'ETC_BAIENT', 'ETC_REFENT', 'ETC_CEPENT');

  FATGOR_CAMPOS: Array [0 .. 23] Of String = ('AUTOINCREM', 'FGO_NUMDOC', 'FGO_ESPDOC',
    'FGO_CODEMP', 'FGO_CODCLI', 'FGO_DTAENT', 'FGO_HORENT', 'FGO_TOTPRO', 'FGO_DESESP',
    'FGO_DESACE', 'FGO_TOTFRE', 'FGO_TOTIPI', 'FGO_TOTRET', 'FGO_VLRCON', 'FGO_CONPAG',
    'FGO_CODCND', 'FGO_CODFPG', 'AUX_ENTGER', 'FGO_JAFATU', 'FGO_CODCAR', 'FGO_QTDPAC',
    'FGO_EMPPIX', 'FGO_TX_PIX', 'FGO_NOTPAU');

  FATDOR_CAMPOS: Array [0 .. 12] Of String = ('FDO_CODITE', 'FDO_DESCRI', 'FDO_UNIDAD',
    'FDO_QTDITE', 'FDO_UNITAR', 'FDO_TOTITE', 'FDO_DESESP', 'FDO_DESACE', 'FDO_TOTFRE',
    'FDO_VALIPI', 'FDO_VALRET', 'FDO_VALFCP', 'FDO_VLRCON');

  FATGOR_JOIN_AUXGOR_EXTGOR =
    'FATGOR JOIN AUXGOR ON AUX_SEQGER = FATGOR.AUTOINCREM JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM';

  FATDOR_JOIN_EXTDOR = 'FATDOR JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM';

  SQL_AUTINC_ITENS_PEDIDO = 'SELECT AUTOINCREM FROM FATDOR WHERE ' +
    'FDO_NUMDOC = "%s" AND FDO_ESPDOC = "%s" AND FDO_CODEMP = "%s" ';

  SQL_TOTAL_ADIANTAMENTO = 'SELECT SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) AS VALLAN ' +
    'FROM ADTCLI WHERE ADT_NUMDOC = "%s" AND ADT_ESPDOC = "%s" AND ADT_CODEMP = "%s" ';

  PAGUE_FACIL_MODO_EMITIR_NFCE = '2';

function fBuscaQtdParcelasConPag(strConPag : String) : Integer;
begin
  Result := StrToInt(LeftStr(strConPag, 2));
end;

function fBuscaTipCarConPag(strConPag : String) : String;
begin
  Result := 'D';

  If (fBuscaQtdParcelasConPag(strConPag) > 1) Then
    Result := 'C'
  else if (Copy(strConPag, 3, 3) <> '000') then
    Result := 'CA'; // Crédito A Vista
end;

function fVerificaConfigQtdParcelasPagueFacil : Boolean;
begin
  Result := True;

  If fEmptyStr(fCfgSis('MXPPGF', VarString)) Then
    Exit(False);

  If (fCfgSis('MXPPGF', VarInteger) > 12) Then
    Exit(False);

  If (fCfgSis('MXPPGF', VarInteger) = 0) Then
    Exit(False);
end;

  { TAutoatendimentoPagueFacilEndereco }

function TAutoatendimentoPagueFacilEndereco.Bairro: String;
begin
  Result := FBairro;
end;

function TAutoatendimentoPagueFacilEndereco.Cep: String;
begin
  Result := fFormataCEP(FCep);
end;

function TAutoatendimentoPagueFacilEndereco.Cidade: String;
begin
  Result := FCidade;
end;

function TAutoatendimentoPagueFacilEndereco.Complemento: String;
begin
  Result := FComplemento;
end;

constructor TAutoatendimentoPagueFacilEndereco.Create(ALogradouro, ABairro, ACep, AComplemento,
  ACidade, AEstado: String);
begin
  FLogradouro := ALogradouro;
  FBairro := ABairro;
  FCep := ACep;
  FComplemento := AComplemento;
  FCidade := ACidade;
  FEstado := AEstado;
end;

function TAutoatendimentoPagueFacilEndereco.Estado: String;
begin
  Result := FEstado;
end;

function TAutoatendimentoPagueFacilEndereco.Logradouro: String;
begin
  Result := FLogradouro;
end;

{ TAutoatendimentoPagueFacilCliente }

function TAutoatendimentoPagueFacilCliente.Codigo: String;
begin
  Result := FDados.FieldByName('CODCLI').AsString;
end;

constructor TAutoatendimentoPagueFacilCliente.Create(ACodigo, ADocumento, AEmpresa: String);
begin
  If ACodigo.IsEmpty Then
    Exit;

  If fClienteConsumidor(fRetNomCliente(ACodigo)) Then
  Begin
    FDados := fCampoTabela(CLICON_CAMPOS, 'FATGOR',
                          ['FGO_CODCLI','FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'],
                          [ACodigo, ADocumento, 'PD', AEmpresa]);

    FEndereco :=
      TAutoatendimentoPagueFacilEndereco.Create(
        FDados.FieldByName('ENDERE').AsString,
        FDados.FieldByName('BAIRRO').AsString,
        FDados.FieldByName('C_E_P_').AsString,
        FDados.FieldByName('ENDCOM').AsString,
        fRetNomCidade(FDados.FieldByName('CODCID').AsString, 0),
        fRetNomCidade(FDados.FieldByName('CODCID').AsString, 1));
  End
  Else
  Begin
    FDados := fCampoTabela(CADCLI_CAMPOS, 'CADCLI', ['CLI_CODCLI'], [ACodigo]);

    FEndereco :=
      TAutoatendimentoPagueFacilEndereco.Create(
        Concat(FDados.FieldByName('ENDERE').AsString, ', ', FDados.FieldByName('ENDNUM').AsString),
        FDados.FieldByName('BAIRRO').AsString,
        FDados.FieldByName('C_E_P_').AsString,
        FDados.FieldByName('ENDCOM').AsString,
        fRetNomCidade(FDados.FieldByName('CODCID').AsString, 0),
        fRetNomCidade(FDados.FieldByName('CODCID').AsString, 1));
  End;
end;

function TAutoatendimentoPagueFacilCliente.EhConsumidor: Boolean;
begin
  Result := False;

  If Self.Codigo.IsEmpty Then
    Exit;

  Result := fClienteConsumidor(fRetNomCliente(Self.Codigo));
end;

function TAutoatendimentoPagueFacilCliente.Endereco: IAutoatendimentoPagueFacilEndereco;
begin
  Result := FEndereco;
end;

function TAutoatendimentoPagueFacilCliente.Nome: String;
begin
  Result := FDados.FieldByName('NOMCLI').AsString;
end;

function TAutoatendimentoPagueFacilCliente.Documento: String;
begin
  Result := fFormataCpfCgc(FDados.FieldByName('C_G_C_').AsString, fSetaPais);
end;

function TAutoatendimentoPagueFacilCliente.Telefone: String;
begin
  Result := fFormataFone(FDados.FieldByName('FONE01').AsString);
end;

{ TAutoatendimentoPagueFacilEntrega }

constructor TAutoatendimentoPagueFacilEntrega.Create(ACodigoCliente, AEnderecoID: String);
var
  FDados: IMyCampoTabela;
begin
  If AEnderecoID.IsEmpty Then
    FDados := fCampoTabela(ENTCLI_CAMPOS, 'ENTCLI', ['ETC_CODCLI', 'ETC_ENDFAT'],
      [ACodigoCliente, 'S'])
  Else
    FDados := fCampoTabela(ENTCLI_CAMPOS, 'ENTCLI', ['ETC_CODCLI', 'AUTOINCREM'],
      [ACodigoCliente, AEnderecoID]);

  FEndereco := TAutoatendimentoPagueFacilEndereco.Create(FDados.FieldByName('ETC_ENDENT').AsString,
    FDados.FieldByName('ETC_BAIENT').AsString, FDados.FieldByName('ETC_CEPENT').AsString,
    FDados.FieldByName('ETC_REFENT').AsString,
    fRetNomCidade(FDados.FieldByName('ETC_CIDENT').AsString, 0),
    fRetNomCidade(FDados.FieldByName('ETC_CIDENT').AsString, 1));
end;

function TAutoatendimentoPagueFacilEntrega.Endereco: IAutoatendimentoPagueFacilEndereco;
begin
  Result := FEndereco;
end;

{ TAutoatendimentoPagueFacilPagamento }

function TAutoatendimentoPagueFacilPagamento.Parcelas: String;
begin
  Result := fFormataCondPag(FParcelas);
end;

function TAutoatendimentoPagueFacilPagamento.PermiteUtilizacaoDoPixCitel: Boolean;
begin
  If Not fCfgSis('USAPIX', varBoolean) Then
    Exit(False);

  If Not fCfgSis('TOTPIX', varBoolean) Then
    Exit(False);

  If fEmptyStr(fCfgSis('CHAPIX', varString)) THen
    Exit(False);

  Result := True;
end;

function TAutoatendimentoPagueFacilPagamento.QtdeParcelasCartao: Integer;
begin
  Result := FFgo_QtdPac;
end;

function TAutoatendimentoPagueFacilPagamento.TipoCartao: string;
begin
  Result := FCar_TipCar;
end;

function TAutoatendimentoPagueFacilPagamento.AutoIncremChavePix: String;
begin
  Result := FAutoIncremChavePix;
end;

function TAutoatendimentoPagueFacilPagamento.CondicaoCodigo: String;
begin
  Result := FCondicaoCodigo;
end;

function TAutoatendimentoPagueFacilPagamento.CondicaoDescricao: String;
begin
  Result := FCondicaoDescricao;
end;

function TAutoatendimentoPagueFacilPagamento.CondicaoRecPix: String;
begin
  Result := FCondicaoRecPix;
end;

function TAutoatendimentoPagueFacilPagamento.PermiteReceberPix: Boolean;
begin
  Result := FPermiteReceberPix;
end;

Constructor TAutoatendimentoPagueFacilPagamento.Create(AParcelas, ACondicaoCodigo, AFormaCodigo,
  ACodCar: String; AQtdeParc: Integer);
begin
  FParcelas := AParcelas;
  FCondicaoCodigo := ACondicaoCodigo;
  FFormaCodigo := AFormaCodigo;
  FCondicaoDescricao := fRetDesConPag(ACondicaoCodigo);
  FFormaDescricao := fRetDesForPag(AFormaCodigo);
  FCondicaoRecPix := fCampoTabela('CND_RECPIX', 'CADCND', ['CND_CODIGO'], [ACondicaoCodigo]);
  FFgo_QtdPac := 0;
  FCar_TipCar := '';
  FAutoIncremChavePix := EmptyStr;

  if fCfgSis('SOLCAR', varBoolean) then
  begin
    FFgo_QtdPac := AQtdeParc;
    FCar_TipCar := fCampoTabela('CAR_TIPCAR', 'CADCAR', ['CAR_CODCAR'], [ACodCar]);
  end
  else if fCfgSis('TFPCPG', varBoolean) then
  begin
    if Trim(AParcelas) <> '' then
    begin
      FFgo_QtdPac := fBuscaQtdParcelasConPag(AParcelas);
      FCar_TipCar := fBuscaTipCarConPag(AParcelas);
    end;
  end;

  FPermiteReceberPix := PermiteUtilizacaoDoPixCitel;
  If FPermiteReceberPix Then
    FAutoIncremChavePix := fCfgSis('CHAPIX', varString);
end;

function TAutoatendimentoPagueFacilPagamento.FormaCodigo: String;
begin
  Result := FFormaCodigo;
end;

function TAutoatendimentoPagueFacilPagamento.FormaDescricao: String;
begin
  Result := FFormaDescricao;
end;

{ TAutoatendimentoPagueFacilPedido }

procedure TAutoatendimentoPagueFacilPedido.AlteraCPFConsumidor(ACPF : String);
Var
  LQuery: IMyQuery;
begin
  LQuery := objCore.fCriarQuery;
  LQuery.SQL.Add('UPDATE FATGOR ');
  LQuery.SQL.Add('SET    FGO_CGCCON = :CPFCON, ');
  LQuery.SQL.Add('       FGO_CGCCPF = 2        ');
  LQuery.SQL.Add('WHERE  FGO_NUMDOC = :NUMDOC  ');
  LQuery.SQL.Add('AND    FGO_ESPDOC = :ESPDOC  ');
  LQuery.SQL.Add('AND    FGO_CODEMP = :CODEMP  ');
  LQuery.SQL.Add('AND    FGO_CODCLI = :CODCLI  ');
  LQuery.ParamByName('CPFCON').AsString := ACPF;
  LQuery.ParamByName('NUMDOC').AsString := Numero;
  LQuery.ParamByName('ESPDOC').AsString := Especie;
  LQuery.ParamByName('CODEMP').AsString := Empresa;
  LQuery.ParamByName('CODCLI').AsString := Cliente.Codigo;
  LQuery.ExecSQL;
end;

procedure TAutoatendimentoPagueFacilPedido.AlterarNotaFiscalPaulista(
  ANotPau: String);
Var
  LQuery: IMyQuery;
begin
  LQuery := objCore.fCriarQuery;
  LQuery.SQL.Text := 'UPDATE EXTGOR '+
                     'SET    FGO_NOTPAU = :NOTPAU ' +
                     'WHERE  FGO_SEQFGO = (SELECT AUTOINCREM ' +
                     '                     FROM   FATGOR ' +
                     '                     WHERE  FGO_NUMDOC = :NUMDOC ' +
                     '                       AND  FGO_ESPDOC = :ESPDOC ' +
                     '                       AND  FGO_CODEMP = :CODEMP ' +
                     '                       AND  FGO_CODCLI = :CODCLI )';
  LQuery.ParamByName('NOTPAU').AsString := ANotPau;
  LQuery.ParamByName('NUMDOC').AsString := Numero;
  LQuery.ParamByName('ESPDOC').AsString := Especie;
  LQuery.ParamByName('CODEMP').AsString := Empresa;
  LQuery.ParamByName('CODCLI').AsString := Cliente.Codigo;
  LQuery.ExecSQL;
end;

function TAutoatendimentoPagueFacilPedido.AutoIncremPixVinculadoAoPedido: String;
begin
  Result := FAutoIncremPixVinculadoAoPedido;
end;

procedure TAutoatendimentoPagueFacilPedido.CarregarProdutos;
Var
  LQuery: IMyQuery;
begin
  LQuery := objCore.fCriarQuery;
  LQuery.SQL.Add(Format(SQL_AUTINC_ITENS_PEDIDO, [Numero, Especie, Empresa]));
  LQuery.Open;
  While Not LQuery.Eof Do
  Begin
    FProdutos.Add(TAutoatendimentoPagueFacilPedidoItens.Create(LQuery.FieldByName('AUTOINCREM')
      .AsString));
    LQuery.Next;
  End;
end;

function TAutoatendimentoPagueFacilPedido.Cliente: IAutoatendimentoPagueFacilCliente;
begin
  Result := FCliente;
end;

function TAutoatendimentoPagueFacilPedido.CodigoBarras: String;
begin
  Result := fCampoTabela(fSQLBarDoc('FGO'), 'FATGOR', ['AUTOINCREM'],
    [FDados.FieldByName('AUTOINCREM').AsString], False);
end;

constructor TAutoatendimentoPagueFacilPedido.Create(APedido, AEmpresa: String);
begin

  fAjustaDataSistema ;

  FDados := fCampoTabela(FATGOR_CAMPOS, FATGOR_JOIN_AUXGOR_EXTGOR,
    ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [APedido, 'PD', AEmpresa]);

  FCliente := TAutoatendimentoPagueFacilCliente.Create(FDados.FieldByName('FGO_CODCLI').AsString, APedido, AEmpresa);

    FPagamento := TAutoatendimentoPagueFacilPagamento.Create(FDados.FieldByName('FGO_CONPAG')
    .AsString, FDados.FieldByName('FGO_CODCND').AsString, FDados.FieldByName('FGO_CODFPG').AsString,
    FDados.FieldByName('FGO_CODCAR').AsString, FDados.FieldByName('FGO_QTDPAC').AsInteger);

  FEntrega := TAutoatendimentoPagueFacilEntrega.Create(FDados.FieldByName('FGO_CODCLI').AsString,
    FDados.FieldByName('AUX_ENTGER').AsString);

  FProdutos := TList<IAutoatendimentoPagueFacilPedidoItens>.Create;

  If Not FDados.FieldByName('FGO_TX_PIX').AsString.IsEmpty Then
    FAutoIncremPixVinculadoAoPedido := fCampotabela('AUTOINCREM',
                                                    'MOVPIX',
                                                    ['MPX_CODEMP', 'MPX_TX_ID_'],
                                                    [FDados.FieldByName('FGO_EMPPIX').AsString, FDados.FieldByName('FGO_TX_PIX').AsString]);

  CarregarProdutos;
end;

function TAutoatendimentoPagueFacilPedido.DataEmissao: TDateTime;
begin
  Result := FDados.FieldByName('FGO_DTAENT').AsDateTime;
end;

function TAutoatendimentoPagueFacilPedido.DescontoEspecial: Double;
begin
  Result := FDados.FieldByName('FGO_DESESP').AsFloat;
end;

function TAutoatendimentoPagueFacilPedido.DespesasAcessorias: Double;
begin
  Result := FDados.FieldByName('FGO_DESACE').AsFloat;
end;

destructor TAutoatendimentoPagueFacilPedido.Destroy;
begin
  FreeAndNil(FProdutos);
  inherited;
end;

function TAutoatendimentoPagueFacilPedido.Empresa: String;
begin
  Result := FDados.FieldByName('FGO_CODEMP').AsString;
end;

function TAutoatendimentoPagueFacilPedido.Entrega: IAutoatendimentoPagueFacilEntrega;
begin
  Result := FEntrega;
end;

function TAutoatendimentoPagueFacilPedido.Especie: String;
begin
  Result := FDados.FieldByName('FGO_ESPDOC').AsString;
end;

function TAutoatendimentoPagueFacilPedido.Faturado: Boolean;
begin
  Result := FDados.FieldByName('FGO_JAFATU').AsInteger = 1;
end;

function TAutoatendimentoPagueFacilPedido.HoraEmissao: TDateTime;
begin
  Result := FDados.FieldByName('FGO_HORENT').AsDateTime;
end;

function TAutoatendimentoPagueFacilPedido.NotaFiscalPaulista: String;
begin
  Result := FDados.FieldByName('FGO_NOTPAU').AsString;
end;

function TAutoatendimentoPagueFacilPedido.Numero: String;
begin
  Result := FDados.FieldByName('FGO_NUMDOC').AsString;
end;

function TAutoatendimentoPagueFacilPedido.Pagamento: IAutoatendimentoPagueFacilPagamento;
begin
  Result := FPagamento;
end;

function TAutoatendimentoPagueFacilPedido.PerguntaCPFNaVenda: Boolean;
begin
  Result := False;

  If fCfgSis('NFPCLI', VarBoolean) And (fRetUFEmpresa = 'SP') Then
  Begin
    Result := (Not Cliente.EhConsumidor) And
              (Not fEmptyStr(Cliente.Codigo)) And
              (Not fEmptyStr(Cliente.Documento)) And
              (Length(fTiraCaracEspeciaisPonto(Cliente.Documento)) <= 11);
  End;
end;

function TAutoatendimentoPagueFacilPedido.Produtos: TList<IAutoatendimentoPagueFacilPedidoItens>;
begin
  Result := FProdutos;
end;

function TAutoatendimentoPagueFacilPedido.TemAdiantamento: Boolean;
Var
  LQuery: IMyQuery;
begin
  LQuery := objCore.fCriarQuery;
  LQuery.SQL.Add(Format(SQL_TOTAL_ADIANTAMENTO, [Numero, Especie, Empresa]));
  LQuery.Open;

  Result := LQuery.FieldByName('VALLAN').AsFloat > 0;
end;

function TAutoatendimentoPagueFacilPedido.TotalFCP_ST: Double;
Var
  LProduto: IAutoatendimentoPagueFacilPedidoItens;
begin
  Result := 0;
  For LProduto In FProdutos Do
    Result := Result + LProduto.ValorFCP_ST;
end;

function TAutoatendimentoPagueFacilPedido.TotalIPI: Double;
begin
  Result := FDados.FieldByName('FGO_TOTIPI').AsFloat;
end;

function TAutoatendimentoPagueFacilPedido.TotalProdutos: Double;
begin
  Result := FDados.FieldByName('FGO_TOTPRO').AsFloat;
end;

function TAutoatendimentoPagueFacilPedido.TotalST: Double;
begin
  Result := FDados.FieldByName('FGO_TOTRET').AsFloat;
end;

function TAutoatendimentoPagueFacilPedido.ValorContabil: Double;
begin
  Result := FDados.FieldByName('FGO_VLRCON').AsFloat;
end;

function TAutoatendimentoPagueFacilPedido.ValorFrete: Double;
begin
  Result := FDados.FieldByName('FGO_TOTFRE').AsFloat;
end;

{ TAutoatendimentoPagueFacilRecebimentoPedido }

procedure TAutoatendimentoPagueFacilRecebimentoPedido.CarregaDadosObjetoPix(
  var APixRecebido: TDadosRetornoPixConsulta; LJsonRetorno, LJsonRequisicao: String);
begin
  APixRecebido.JsonRetorno := LJsonRetorno;

  If Pedido.AutoIncremPixVinculadoAoPedido.IsEmpty Then
  Begin
    APixRecebido.JSonRequisicao := LJsonRequisicao;
    APixRecebido.CodigoEmpresa := VS_strCodEmp;
    APixRecebido.AutoIncremChavePix := Pedido.Pagamento.AutoIncremChavePix;
    APixRecebido.CodigoPortador := TPixDao.Create.RetornaPortadorChavePix(Pedido.Pagamento.AutoIncremChavePix);

    APixRecebido.PlanoDeContas := fCfgSis('CTAPIX', varString, APixRecebido.CodigoEmpresa);
    If APixRecebido.PlanoDeContas.IsEmpty Then
      APixRecebido.PlanoDeContas := fCfgSis('CTAAVI', varString, APixRecebido.CodigoEmpresa);

    APixRecebido.OrigemAdiantamento := 'CTR';
    APixRecebido.RecebidoPeloF11 := 'N';

    APixRecebido.JsonRetorno := LJsonRetorno;

    Exit;
  End;

  TPixDao.CarregaDadosMovPixObjetoPix(Pedido.AutoIncremPixVinculadoAoPedido, APixRecebido);
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.CarregarPedido(APedido: String)
  : IAutoatendimentoPagueFacilRecebimentoPedido;
Var
  Documento: untTypesSistema.TDocumento;
begin
  pLimparTrilhaMensagensTotem;

  LimparObjetos;

  Result := Self;
  FEmpresa := VS_strCodEmp;
  FCodigoBarras := '';

  If Length(APedido) > 12 Then
  Begin
    If UsaComanda Then
    Begin
      Documento := TfrmFatDigCodBarrasComanda.fRetPDEmAberto_Comanda(APedido);
      APedido := Documento.strNumDoc;
      FEmpresa := Documento.strCodEmp;
    End
    Else
    Begin
      FCodigoBarras := APedido;
      APedido := MidStr(FCodigoBarras, 2, 12);
      FEmpresa := MidStr(FCodigoBarras, 16, 3);
    End;
  End;

  FPedido := TAutoatendimentoPagueFacilPedido.Create(APedido, FEmpresa);

  ExecutarValidacoes;
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.CPFValido(
  ACPF: String): Boolean;
begin
  Result := untFuncoesSimples.fValidaCPF(ACPF);
end;

constructor TAutoatendimentoPagueFacilRecebimentoPedido.Create;
begin
  IniciarObjetos;
end;

destructor TAutoatendimentoPagueFacilRecebimentoPedido.Destroy;
begin
  inherited;
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.EmitirNFCe: IAutoatendimentoPagueFacilRecebimentoPedido;
var
  objEmiNFCe: TAutoatendimentoPagueFacilEmitirNFCe;
begin
  Result := Self;

  if not Self.ModoEmitirNFCe then
    Exit;

  objEmiNFCe :=
    TAutoatendimentoPagueFacilEmitirNFCe.Create(
      FPedido.Numero,
      FPedido.Especie,
      FPedido.Empresa);

  try
    objEmiNFCe.FaturarDocumento();
  finally
    objEmiNFCe.Free;
  end;
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.ExecutarValidacoes;
begin
  ValidarPortador;
  ValidarPlanoContas;
  ValidarTef;
  ValidarPedido;
  ValidarPedidoComPix;
  ValidarCodBarras;
  ValidarAdiantamento;
  ValidarQtdParcelas;
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.FormataCPF(
  ACPF: String): String;
begin
  Result := untFuncoesSimples.fFormataCpfCgc(ACPF, fSetaPais);
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.IniciarObjetos;
begin
  LimparObjetos;
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.LimparObjetos;
begin
  FAdiantamentoRealizado := False;
  FTipoCartao := '';
  FParcelas := 1;
  FPedido := TAutoatendimentoPagueFacilPedido.Create('', '');
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.ModoEmitirNFCe: Boolean;
begin
  Result := fCfgSis('MODPGF') = PAGUE_FACIL_MODO_EMITIR_NFCE;
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.NFCeAutorizada: Boolean;
Var
  LQuery : IMyQuery;
  LDados : IMyCampoTabela;
begin
  If Not ModoEmitirNFCe Then
  Begin
    Result := True;
    Exit;
  End;

  LDados := fCampoTabela(['FGO_NUMFAT','FGO_EMPFAT','FGO_TIPFAT'],
                         'FATGOR',
                         ['FGO_NUMDOC','FGO_CODEMP','FGO_ESPDOC','FGO_CODCLI'],
                         [Pedido.Numero, Pedido.Empresa, Pedido.Especie, Pedido.Cliente.Codigo]);

  If (LDados.FieldByName('FGO_TIPFAT').AsString = 'PD') Then
  Begin
    Result := True;
    Exit;
  End;

  If (LDados.FieldByName('FGO_NUMFAT').AsString.IsEmpty) Then
  Begin
    Result := False;
    Exit;
  End;

  LQuery := objCore.fCriarQuery;
  LQuery.SQL.Clear;
  LQuery.SQL.Add(' SELECT FIS_ACESSO FROM CADFIS ');
  LQuery.SQL.Add('  WHERE FIS_NUMDOC = :NUMDOC   ');
  LQuery.SQL.Add('    AND FIS_ESPDOC = :ESPDOC   ');
  LQuery.SQL.Add('    AND FIS_CODEMP = :CODEMP   ');
  LQuery.SQL.Add('    AND FIS_FORCLI = :CODCLI   ');
  LQuery.ParamByName('NUMDOC').AsString := LDados.FieldByName('FGO_NUMFAT').AsString;
  LQuery.ParamByName('ESPDOC').AsString := 'IF';
  LQuery.ParamByName('CODEMP').AsString := LDados.FieldByName('FGO_EMPFAT').AsString;
  LQuery.ParamByName('CODCLI').AsString := Pedido.Cliente.Codigo;
  LQuery.Open;

  Result := Not LQuery.FieldByName('FIS_ACESSO').AsString.IsEmpty;
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.NumeroMaximoParcelas: Integer;
  const
    intMaxParcelas = 12;
  var
    blnParcNegociadaNoPedido : Boolean;
begin
  Result := fCfgSis('MXPPGF', varInteger);

  blnParcNegociadaNoPedido := (SolicitaDadosCartao or TravaFormaNegociadaPelaConPag);

  if blnParcNegociadaNoPedido then
    Result := intMaxParcelas;
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.RealizarAdiantamento
  : IAutoatendimentoPagueFacilRecebimentoPedido;
  Var
    LRequisicaoPix,
    LRetornoPix: String;

    LDadosPix: TDadosRetornoPixConsulta;
begin
  Result := Self;

  ExecutarValidacoes;

  If FTipoCartao.Equals('P') Then
  Begin
    FAdiantamentoRealizado := False;

    LRetornoPix := ReceberPixQRCode(LRequisicaoPix);

    LDadosPix := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LRetornoPix);

    If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(LDadosPix) Then
    Begin
      CarregaDadosObjetoPix(LDadosPix, LRetornoPix, LRequisicaoPix);

      FAdiantamentoRealizado := TAdiantamento.RealizarAdiantamentoClientePix(Self.ClassName,
                                                                             LDadosPix,
                                                                             True,
                                                                             Concat(Pedido.Numero, '-',
                                                                                    Pedido.Especie, '-',
                                                                                    Pedido.Empresa, '-',
                                                                                    Pedido.Cliente.Codigo)
                                                                             ) <> 0;
    End
    Else
      Raise EAbort.Create('Pagamento cancelado');
  End
  Else
    FAdiantamentoRealizado := TAdiantamento.fRealizarAdiantamentoCliente(Self.ClassName,
      strLoginUsuarioLogado, '', Pedido.Numero, Pedido.Especie, Pedido.Empresa, FOrigem,
      FRotinaPagueFacil, FTipoCartao, FParcelas);

  If Not FAdiantamentoRealizado Then
    RaiseError('Não foi possível realizar o recebimento do pedido!');
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.ReceberPixQRCode(var ADadosRequisicao: String): String;
begin
   Result := EmptyStr;

   If Pedido.AutoIncremPixVinculadoAoPedido.IsEmpty Then
   Begin
     ADadosRequisicao := TFuncoesPix.RetornaJsonDadosRequisicao(RetornaDadosPedidoGeracaoPix);

     Exit(TFuncoesPixAutcom.PagarPixViaQRCodeGerandoNovoPix(Pedido.Pagamento.AutoIncremChavePix,
                                                            ADadosRequisicao,
                                                            EmptyStr,
                                                            Pedido.Cliente.Codigo,
                                                            True,
                                                            Concat(Pedido.Numero, '-', Pedido.Especie, '-A-', Pedido.Empresa, '|',
                                                                   fStrZero(Pedido.Produtos.Count.ToString, 3) + ' item(ns)|Auto Atendimento'),
                                                            Pedido.ValorContabil));
   End;

   Result := TFuncoesPixAutcom.PagarPixViaPorQRCode(TPixDao.RetornaDadosDoPix(Pedido.AutoIncremPixVinculadoAoPedido),
                                                    Self.ClassName,
                                                    True,
                                                    'CTR',
                                                    EmptyStr,
                                                    EmptyStr,
                                                    True,
                                                    True);
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.RetornaDadosPedidoGeracaoPix: TDadosRequisicaoPixAVista;
  Var
    LExpiracao: Integer;
begin
  Result := TDadosRequisicaoPixAVista.Create;
  Result.Expiracao := 86400;

  LExpiracao := fCfgSis('EXPPIX', varInteger);
  If LExpiracao > 0 Then
    Result.Expiracao := LExpiracao * 3600;

  Result.TipoDevedor := '2';
  Result.NomeDevedor := '';
  Result.CPFCNPJDevedor := '';
  If Not fClienteConsumidor(Pedido.Cliente.Nome) Then
  Begin
    Result.CPFCNPJDevedor := fTiraCaracEspeciaisPonto(Pedido.Cliente.Documento);
    Result.NomeDevedor := Pedido.Cliente.Nome;

    If Result.CPFCNPJDevedor.Length > 11 Then
      Result.TipoDevedor := '1';
  End;

  If Result.CPFCNPJDevedor.IsEmpty Then
    Result.NomeDevedor := '';

  Result.Valor := ReplaceStr(FormatFloat(',0.00', Pedido.ValorContabil), '.', EmptyStr);
  Result.Valor := ReplaceStr(Result.Valor, ',', '.');

  Result.SolicitacaoPagador := 'Pix gerado pelo totem referente ao pedido ' + Pedido.Numero;
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.Parcelas: Integer;
begin
  Result := FParcelas;
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.SetParcelas(AValue: Integer);
begin
  FParcelas := AValue;
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.SetTipoCartao(AValue: string);
begin
  FTipoCartao := AValue;
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.SolicitaDadosCartao: Boolean;
begin
  Result := fCfgSis('SOLCAR', VarBoolean);
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.TravaFormaNegociadaPelaConPag: Boolean;
begin
  Result := fCfgSis('TFPCPG', VarBoolean);
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.TipoCartao: string;
begin
  Result := FTipoCartao;
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.TravaFormaNegociada: Boolean;
begin
  Result := (SolicitaDadosCartao or TravaFormaNegociadaPelaConPag);
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.UsaComanda: Boolean;
begin
  Result := fCfgSis('COMAND', VarBoolean);
end;

function TAutoatendimentoPagueFacilRecebimentoPedido.Pedido: IAutoatendimentoPagueFacilPedido;
begin
  Result := FPedido;
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.ValidarPedido;
begin
  If Pedido.Numero.IsEmpty Then
    RaiseError('Pedido não encontrado!');

  If Not Pedido.Especie.Equals('PD') Then
    RaiseError('Documento não é um pedido de venda!');

  If Pedido.TemAdiantamento Then
    RaiseError('Pedido já tem um adiantamento efetuado!');

  If Pedido.Faturado Then
    RaiseError('Pedido já foi faturado!');

  If Pedido.ValorContabil <= 0 Then
    RaiseError('Documento não é um pedido de venda válido!');

  If Self.ModoEmitirNFCe Then
    Self.ValidarEmitirNFCe;
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.ValidarPedidoComPix;
begin
  If Pedido.Pagamento.PermiteReceberPix Then
    Exit;

  If Pedido.Pagamento.CondicaoRecPix.Equals('S') Then
    RaiseError('Esse pedido só pode ser recebido através de Pix QRCode!');

  If Pedido.AutoIncremPixVinculadoAoPedido.IsEmpty Then
    Exit;

  If Not Pedido.Pagamento.PermiteReceberPix Then
    RaiseError('Esse pedido só pode ser recebido através de Pix QRCode!');
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.ValidarPlanoContas;
begin
  If fEmptyStr(fCfgSis('CTAPGF')) Then
    RaiseError('A configuração "CFG_CTAPGF - ' + fRetNomCfg('CTAPGF') +
      '" deve ser informada corretamente!');

  If fEmptyStr(fRetDescCentroCusto(fCfgSis('CTAPGF'))) Then
    RaiseError('A configuração "CFG_CTAPGF - ' + fRetNomCfg('CTAPGF') +
      '" deve ser informada corretamente!');
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.ValidarPortador;
begin
  If fEmptyStr(fCfgSis('PORPGF')) Then
    RaiseError('A configuração "CFG_PORPGF - ' + fRetNomCfg('PORPGF') +
      '" deve ser informada corretamente!');

  If fEmptyStr(fRetNomPortador(fCfgSis('PORPGF'))) Then
    RaiseError('A configuração "CFG_PORPGF - ' + fRetNomCfg('PORPGF') +
      '" deve ser informada corretamente!');
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.ValidarQtdParcelas;
  var
    blnParcNegociadaNoPedido : Boolean;
begin
  blnParcNegociadaNoPedido := (SolicitaDadosCartao or TravaFormaNegociadaPelaConPag);

  if not blnParcNegociadaNoPedido then
  begin
    if not fVerificaConfigQtdParcelasPagueFacil then
      RaiseError('A configuração "CFG_MXPPGF - ' + fRetNomCfg('MXPPGF') + '" deve ser configurada corretamente!');
  end;
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.ValidarTef;
begin
  {* Flag utilizada para testes apenas *}
  If Not (fArqIni(0, 'GERAL', 'TESTE_TOTEM_SEM_TEF', '') = 'S') Then
    If Not VS_strUsaTef.Equals('S') Then
      RaiseError('TEF não configurado corretamente. Verifique!');

  If Not fCfgSis('TEFREC', VarBoolean) Then
    RaiseError('A configuração "CFG_TEFREC - ' + fRetNomCfg('TEFREC') + '" deve ser ativada!');

  If Not fCfgSis('USACTC', VarBoolean) Then
    RaiseError('A configuração "CFG_USACTC - ' + fRetNomCfg('USACTC') + '" deve ser ativada!');
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.ValidarAdiantamento;
begin
  If Not Pedido.Pagamento.FormaCodigo.Equals('007') Then
  Begin
    If Not Pedido.Pagamento.PermiteReceberPix Then
      RaiseError('Forma de pagamento do pedido é diferente de cartão!');

    If Not Pedido.Pagamento.FormaCodigo.Equals('012') Then
      RaiseError('Forma de pagamento do pedido é diferente de cartão e Pix!');
  End;

  If Not fCfgSis('ADTALL', VarBoolean) Then
    If Not Pedido.Empresa.Equals(VS_strCodEmp) Then
      RaiseError('Não é permitido realizar o recebimento um pedido de outra loja!');

  If Not TAdiantamento.fPermiteSelecionarPedido(Pedido.Numero, Pedido.Especie, Pedido.Empresa,
    FOrigem) Then
    RaiseError('Não é possível selecionar este pedido para realizar o recebimento!');

  If FAdiantamentoRealizado Then
    RaiseError('Recebimento já foi realizado!');
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.ValidarCodBarras;
begin
  If Not FCodigoBarras.IsEmpty Then
    If Not Pedido.CodigoBarras.Equals(FCodigoBarras) Then
      RaiseError('Pedido localizado porém código de barras é inválido!');
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.ValidarEmitirNFCe;
var
  objEmiNFCe: TAutoatendimentoPagueFacilEmitirNFCe;
begin
  if not Self.ModoEmitirNFCe then
    Exit;
  objEmiNFCe := TAutoatendimentoPagueFacilEmitirNFCe.Create(
    FPedido.Numero, FPedido.Especie, FPedido.Empresa);
  try
    objEmiNFCe.ValidarDocumento();
  finally
    objEmiNFCe.Free;
  end;
end;

procedure TAutoatendimentoPagueFacilRecebimentoPedido.RaiseError(AMsg: String);
begin
  Raise EAutoatendimentoPagueFacilError.Create(AMsg);
end;

{ TAutoatendimentoPagueFacilPedidoItens }

function TAutoatendimentoPagueFacilPedidoItens.Codigo: String;
begin
  Result := FDados.FieldByName('FDO_CODITE').AsString;
end;

constructor TAutoatendimentoPagueFacilPedidoItens.Create(AItemPedidoId: String);
begin
  FDados := fCampoTabela(FATDOR_CAMPOS, FATDOR_JOIN_EXTDOR, ['AUTOINCREM'], [AItemPedidoId]);
end;

function TAutoatendimentoPagueFacilPedidoItens.DescontoEspecial: Double;
begin
  Result := FDados.FieldByName('FDO_DESESP').AsFloat;
end;

function TAutoatendimentoPagueFacilPedidoItens.Descricao: String;
begin
  Result := FDados.FieldByName('FDO_DESCRI').AsString;
end;

function TAutoatendimentoPagueFacilPedidoItens.DespesasAcessorias: Double;
begin
  Result := FDados.FieldByName('FDO_DESACE').AsFloat;
end;

function TAutoatendimentoPagueFacilPedidoItens.Quantidade: Double;
begin
  Result := FDados.FieldByName('FDO_QTDITE').AsFloat;
end;

function TAutoatendimentoPagueFacilPedidoItens.Unidade: String;
begin
  Result := fRetSiglaUnidade(FDados.FieldByName('FDO_UNIDAD').AsString);
end;

function TAutoatendimentoPagueFacilPedidoItens.ValorContabil: Double;
begin
  Result := FDados.FieldByName('FDO_VLRCON').AsFloat;
end;

function TAutoatendimentoPagueFacilPedidoItens.ValorFCP_ST: Double;
begin
  Result := FDados.FieldByName('FDO_VALFCP').AsFloat;
end;

function TAutoatendimentoPagueFacilPedidoItens.ValorFrete: Double;
begin
  Result := FDados.FieldByName('FDO_TOTFRE').AsFloat;
end;

function TAutoatendimentoPagueFacilPedidoItens.ValorIPI: Double;
begin
  Result := FDados.FieldByName('FDO_VALIPI').AsFloat;
end;

function TAutoatendimentoPagueFacilPedidoItens.ValorST: Double;
begin
  Result := FDados.FieldByName('FDO_VALRET').AsFloat;
end;

function TAutoatendimentoPagueFacilPedidoItens.ValorTotal: Double;
begin
  Result := FDados.FieldByName('FDO_TOTITE').AsFloat;
end;

function TAutoatendimentoPagueFacilPedidoItens.ValorUnitario: Double;
begin
  Result := FDados.FieldByName('FDO_UNITAR').AsFloat;
end;

{ TAutoatendimentoPagueFacilEmitirNFCe }
procedure TAutoatendimentoPagueFacilEmitirNFCe.OnSetParametros;
begin
  inherited;
  Self.SetPagFac(True);
end;

end.
