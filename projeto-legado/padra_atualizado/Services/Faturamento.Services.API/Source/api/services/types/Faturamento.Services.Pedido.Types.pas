unit Faturamento.Services.Pedido.Types;

interface

uses
  System.Classes,
  System.Generics.Collections,
  untFuncFatTypes,
  MVCFramework.Swagger.Commons,
  Services.Core.JsonCitel.Serializer,
  Services.Core.Converter.Attribute,
  Faturamento.Classes.TFatVendaBase;

type
  TPedidoItemBasic = class
  private
    Fid: Integer;
    FcodigoItem: string;
    Fquantidade: Double;
    FprecoUnitario: Double;
    FsiglaTinta: String;
    FTabPreco: String;
    FhashMD5Tinta: String;
    FembalagemProduzida: String;
    FmodoVenda: String;
  public
    [MVCSwagJsonSchemaField(stInteger, 'id', 'Identificador do item '+
      '(deve ser maior que zero)', True, False)]
    property id: Integer read Fid write Fid;

    [MVCSwagJsonSchemaField(stString, 'codigoItem', 'Código do Produto '+
      '(Não obrigatório quando tinta de máquina)', True, False)]
    property codigoItem: string read FcodigoItem write FcodigoItem;

    [MVCSwagJsonSchemaField(stString, 'siglaTinta', 'Sigla da Tinta (ex: "SUV", "LAZ")',
      False, False)]
    property siglaTinta: string read FsiglaTinta write FsiglaTinta;

    [MVCSwagJsonSchemaField(stString, 'TabPreco', 'Tabela de Preço (ex: 1 a 7)',
      False, False)]
    property tabPreco: string read FTabPreco Write FTabPreco;

    [MVCSwagJsonSchemaField(stString, 'embalagemProduzida', 'Embalagem Produzida (ex: "Litro", "Galão")',
      False, False)]
    property embalagemProduzida: string read FembalagemProduzida Write FembalagemProduzida;

    [MVCSwagJsonSchemaField(stString, 'modoVenda', 'Modo de Venda (ex: "C", "D")',
      False, False)]
    property modoVenda: String Read FmodoVenda Write FmodoVenda;

    [MVCSwagJsonSchemaField(stString, 'hashMD5Tinta', 'Chave MD5 da Tinta',
      False, False)]
    property hashMD5Tinta: string read FhashMD5Tinta write FhashMD5Tinta;

    [MVCSwagJsonSchemaField(stNumber, 'quantidade', 'Quantidade do Produto',
      True, False)]
    property quantidade: Double read Fquantidade write Fquantidade;

    [MVCSwagJsonSchemaField(stNumber, 'precoUnitario', 'Preço Unitário',
      True, False)]
    property precoUnitario: Double read FprecoUnitario write FprecoUnitario;
  end;

type
  TPedidoItemBasicList = TList<TPedidoItemBasic>;

type
  TPedidoItemBasicListConverter = class(TJsonListConverter)
  public
    function ToJson(AInstance: TObject): String; override;
    procedure FromJson(AInstance: TObject; AJson: String); override;
  end;

type
  TPedidoBasic = class
  private
    FcodigoCliente: string;
    FenderecoEntregaID: string;
    FvendaPresencial: Boolean;
    FtipoOperacao: string;
    FdescontoEspecial: Double;
    FdespesasAcessorias: Double;
    FvalorFrete: Double;
    [TPedidoItemBasicListConverter()]
    FItems: TPedidoItemBasicList;
  public
    constructor Create;
    destructor Destroy; override;
    class function FromJsonstring(AJsonstring: string): TPedidoBasic;
  public
    function ToJsonString: string;
  public
    [MVCSwagJsonSchemaField(stString, 'codigoCliente', 'Código do Cliente',
      True, False)]
    property codigoCliente: string read FcodigoCliente write FcodigoCliente;

    [MVCSwagJsonSchemaField(stString, 'enderecoEntregaID',
      'Endereço de Entrega (Autoincremento)', True, False)]
    property enderecoEntregaID: string read FenderecoEntregaID
      write FenderecoEntregaID;

    [MVCSwagJsonSchemaField(stBoolean, 'vendaPresencial', 'Venda é Presencial?',
      True, False)]
    property vendaPresencial: Boolean read FvendaPresencial
      write FvendaPresencial;

    [MVCSwagJsonSchemaField(stString, 'tipoOperacao', 'Tipo de operação: "USO/CONSUMO", '+
      '"REVENDA" ou "INDUSTRIALIZAÇÃO" (CFG_USOREV)', False, False)]
    property tipoOperacao: string read FtipoOperacao write FtipoOperacao;

    [MVCSwagJsonSchemaField(stNumber, 'descontoEspecial',
      'Desconto Especial (em valor R$)', True, False)]
    property descontoEspecial: Double read FdescontoEspecial
      write FdescontoEspecial;

    [MVCSwagJsonSchemaField(stNumber, 'despesasAcessorias',
      'Despesas Acessórias', True, False)]
    property despesasAcessorias: Double read FdespesasAcessorias
      write FdespesasAcessorias;

    [MVCSwagJsonSchemaField(stNumber, 'valorFrete', 'Valor do Frete',
      True, False)]
    property valorFrete: Double read FvalorFrete write FvalorFrete;

    [MVCSwagJsonSchemaField(stArray, 'items', 'Array de Produtos', True, False)]
    property Items: TPedidoItemBasicList read FItems write FItems;
  end;

type
  TPedidoCalculadoItem = class
  private
    Fid: Integer;
    FcodigoItem: string;
    Fquantidade: Double;
    FprecoUnitario: Double;
    FtotalProduto: Double;
    FdescontoEspecial: Double;
    FdespesaAcessoria: Double;
    FvalorFrete: Double;
    FbaseCalculoST: Double;
    FvalorST: Double;
    FbaseCalculoIPI: Double;
    FaliquotaIPI: Double;
    FvalorIPI: Double;
    FvalorFCPST: Double;
    FvalorTotal: Double;
    FbaseCalculoICMS: Double;
    FaliquotaICMS: Double;
    FvalorICMS: Double;
    FbaseCalculoFCP: Double;
    FaliquotaFCP: Double;
    FvalorFCP: Double;
    FvalorDifalDestino: Double;
  public
    [MVCSwagJsonSchemaField(stInteger, 'id', 'Identificador do item', True, False)]
    property id: Integer read Fid write Fid;

    [MVCSwagJsonSchemaField(stString, 'codigoItem', 'Código do Produto',
      True, False)]
    property codigoItem: string read FcodigoItem write FcodigoItem;

    [MVCSwagJsonSchemaField(stNumber, 'quantidade', 'Quantidade do Produto',
      True, False)]
    property quantidade: Double read Fquantidade write Fquantidade;

    [MVCSwagJsonSchemaField(stNumber, 'precoUnitario', 'Preço Unitário',
      True, False)]
    property precoUnitario: Double read FprecoUnitario write FprecoUnitario;

    [MVCSwagJsonSchemaField(stNumber, 'totalProduto', 'Total do Produto',
      True, False)]
    property totalProduto: Double read FtotalProduto write FtotalProduto;

    [MVCSwagJsonSchemaField(stNumber, 'descontoEspecial', 'Desconto Especial',
      True, False)]
    property descontoEspecial: Double read FdescontoEspecial
      write FdescontoEspecial;

    [MVCSwagJsonSchemaField(stNumber, 'valorFrete', 'Valor do Frete',
      True, False)]
    property valorFrete: Double read FvalorFrete write FvalorFrete;

    [MVCSwagJsonSchemaField(stNumber, 'despesaAcessoria', 'Despesas Acessórias',
      True, False)]
    property despesaAcessoria: Double read FdespesaAcessoria
      write FdespesaAcessoria;

    [MVCSwagJsonSchemaField(stNumber, 'baseCalculoST', 'Base de cálculo do ST',
      True, False)]
    property baseCalculoST: Double read FbaseCalculoST write FbaseCalculoST;

    [MVCSwagJsonSchemaField(stNumber, 'valorST', 'Valor da ST', True, False)]
    property valorST: Double read FvalorST write FvalorST;

    [MVCSwagJsonSchemaField(stNumber, 'baseCalculoIPI',
      'Base de cálculo do IPI', True, False)]
    property baseCalculoIPI: Double read FbaseCalculoIPI write FbaseCalculoIPI;

    [MVCSwagJsonSchemaField(stNumber, 'aliquotaIPI', 'Alíquota do IPI',
      True, False)]
    property aliquotaIPI: Double read FaliquotaIPI write FaliquotaIPI;

    [MVCSwagJsonSchemaField(stNumber, 'valorIPI', 'Valor do IPI', True, False)]
    property valorIPI: Double read FvalorIPI write FvalorIPI;

    [MVCSwagJsonSchemaField(stNumber, 'valorFCPST', 'Valor do FCPST',
      True, False)]
    property valorFCPST: Double read FvalorFCPST write FvalorFCPST;

    [MVCSwagJsonSchemaField(stNumber, 'valorTotal', 'Total Geral', True, False)]
    property valorTotal: Double read FvalorTotal write FvalorTotal;

    [MVCSwagJsonSchemaField(stNumber, 'baseCalculoICMS',
      'Base de cálculo do ICMS', True, False)]
    property baseCalculoICMS: Double read FbaseCalculoICMS
      write FbaseCalculoICMS;

    [MVCSwagJsonSchemaField(stNumber, 'aliquotaICMS', 'Alíquota do ICMS',
      True, False)]
    property aliquotaICMS: Double read FaliquotaICMS write FaliquotaICMS;

    [MVCSwagJsonSchemaField(stNumber, 'valorICMS', 'Valor do ICMS',
      True, False)]
    property valorICMS: Double read FvalorICMS write FvalorICMS;

    [MVCSwagJsonSchemaField(stNumber, 'baseCalculoFCP',
      'Base de cálculo do FCP', True, False)]
    property baseCalculoFCP: Double read FbaseCalculoFCP write FbaseCalculoFCP;

    [MVCSwagJsonSchemaField(stNumber, 'aliquotaFCP', 'Alíquota do FCP',
      True, False)]
    property aliquotaFCP: Double read FaliquotaFCP write FaliquotaFCP;

    [MVCSwagJsonSchemaField(stNumber, 'valorFCP', 'Valor do FCP', True, False)]
    property valorFCP: Double read FvalorFCP write FvalorFCP;

    [MVCSwagJsonSchemaField(stNumber, 'valorDifalDestino',
      'Valor do DIFAL (Destino)', True, False)]
    property valorDifalDestino: Double read FvalorDifalDestino
      write FvalorDifalDestino;
  end;

type
  TPedidoCalculadoItemList = TList<TPedidoCalculadoItem>;

type
  TPedidoCalculadoItemListConverter = class(TJsonListConverter)
  public
    function ToJson(AInstance: TObject): String; override;
    procedure FromJson(AInstance: TObject; AJson: String); override;
  end;

type
  TPedidoCalculado = class
  strict private
    FtotalProdutos: Double;
    FdescontoEspecial: Double;
    FdespesasAcessorias: Double;
    FvalorFrete: Double;
    FbaseCalculoST: Double;
    FvalorST: Double;
    FbaseCalculoIPI: Double;
    FvalorIPI: Double;
    FvalorFCPST: Double;
    FvalorTotal: Double;
    FbaseCalculoICMS: Double;
    FvalorICMS: Double;
    FbaseCalculoFCP: Double;
    FvalorFCP: Double;
    FvalorDifalDestino: Double;
    [TPedidoCalculadoItemListConverter()]
    FItems: TPedidoCalculadoItemList;
  public
    constructor Create;
    destructor Destroy; override;
    class function FromFatVenda(AObjVenda: TFatVendaBase): TPedidoCalculado;
  public
    function ToJsonString: string;
  public
    [MVCSwagJsonSchemaField(stNumber, 'totalProdutos', 'Total dos Produtos',
      True, False)]
    property totalProdutos: Double read FtotalProdutos write FtotalProdutos;

    [MVCSwagJsonSchemaField(stNumber, 'descontoEspecial', 'Desconto Especial',
      True, False)]
    property descontoEspecial: Double read FdescontoEspecial
      write FdescontoEspecial;

    [MVCSwagJsonSchemaField(stNumber, 'valorFrete', 'Valor do Frete',
      True, False)]
    property valorFrete: Double read FvalorFrete write FvalorFrete;

    [MVCSwagJsonSchemaField(stNumber, 'despesasAcessorias',
      'Despesas Acessórias', True, False)]
    property despesasAcessorias: Double read FdespesasAcessorias
      write FdespesasAcessorias;

    [MVCSwagJsonSchemaField(stNumber, 'baseCalculoST', 'Base de cálculo do ST',
      True, False)]
    property baseCalculoST: Double read FbaseCalculoST write FbaseCalculoST;

    [MVCSwagJsonSchemaField(stNumber, 'valorST', 'Valor da ST', True, False)]
    property valorST: Double read FvalorST write FvalorST;

    [MVCSwagJsonSchemaField(stNumber, 'baseCalculoIPI',
      'Base de cálculo do IPI', True, False)]
    property baseCalculoIPI: Double read FbaseCalculoIPI write FbaseCalculoIPI;

    [MVCSwagJsonSchemaField(stNumber, 'valorIPI', 'Valor do IPI', True, False)]
    property valorIPI: Double read FvalorIPI write FvalorIPI;

    [MVCSwagJsonSchemaField(stNumber, 'valorFCPST', 'Valor do FCPST',
      True, False)]
    property valorFCPST: Double read FvalorFCPST write FvalorFCPST;

    [MVCSwagJsonSchemaField(stNumber, 'valorTotal', 'Total Geral', True, False)]
    property valorTotal: Double read FvalorTotal write FvalorTotal;

    [MVCSwagJsonSchemaField(stNumber, 'baseCalculoICMS',
      'Base de cálculo do ICMS', True, False)]
    property baseCalculoICMS: Double read FbaseCalculoICMS
      write FbaseCalculoICMS;

    [MVCSwagJsonSchemaField(stNumber, 'valorICMS', 'Valor do ICMS',
      True, False)]
    property valorICMS: Double read FvalorICMS write FvalorICMS;

    [MVCSwagJsonSchemaField(stNumber, 'baseCalculoFCP',
      'Base de cálculo do FCP', True, False)]
    property baseCalculoFCP: Double read FbaseCalculoFCP write FbaseCalculoFCP;

    [MVCSwagJsonSchemaField(stNumber, 'valorFCP', 'Valor do FCP', True, False)]
    property valorFCP: Double read FvalorFCP write FvalorFCP;

    [MVCSwagJsonSchemaField(stNumber, 'valorDifalDestino',
      'Valor do DIFAL (Destino)', True, False)]
    property valorDifalDestino: Double read FvalorDifalDestino
      write FvalorDifalDestino;

    [MVCSwagJsonSchemaField(stArray, 'items', 'Array de Produtos', True, False)]
    property Items: TPedidoCalculadoItemList read FItems write FItems;
  end;

implementation

{ TPedidoBasic }

constructor TPedidoBasic.Create;
begin
  inherited;
  FItems := TPedidoItemBasicList.Create;
end;

destructor TPedidoBasic.Destroy;
var
  LItem: TPedidoItemBasic;
begin
  for LItem in FItems do
    LItem.Free;
  FItems.Free;
  inherited;
end;

class function TPedidoBasic.FromJsonstring(AJsonstring: string): TPedidoBasic;
begin
  Result := TJSONCitel.JSONToObject<TPedidoBasic>(AJsonstring);
end;

function TPedidoBasic.ToJsonString: string;
begin
  Result := TJSONCitel.ObjectToJSON(Self);
end;

{ TPedidoItemBasicListConverter }

procedure TPedidoItemBasicListConverter.FromJson(AInstance: TObject;
  AJson: String);
begin
  inherited;
  TJsonCitelConverter.ListOfObjectFromJson<TPedidoItemBasic>
    (TPedidoItemBasicList(AInstance), AJson);
end;

function TPedidoItemBasicListConverter.ToJson(AInstance: TObject): String;
begin
  Result := TJsonCitelConverter.ListOfObjectToJson<TPedidoItemBasic>
    (TPedidoItemBasicList(AInstance));
end;

{ TPedidoCalculadoItemListConverter }

procedure TPedidoCalculadoItemListConverter.FromJson(AInstance: TObject;
  AJson: String);
begin
  TJsonCitelConverter.ListOfObjectFromJson<TPedidoCalculadoItem>
    (TPedidoCalculadoItemList(AInstance), AJson);
  inherited;
end;

function TPedidoCalculadoItemListConverter.ToJson(AInstance: TObject): String;
begin
  Result := TJsonCitelConverter.ListOfObjectToJson<TPedidoCalculadoItem>
    (TPedidoCalculadoItemList(AInstance));
end;

{ TPedidoCalculado }

constructor TPedidoCalculado.Create;
begin
  inherited;
  FItems := TPedidoCalculadoItemList.Create;
end;

destructor TPedidoCalculado.Destroy;
var
  LItem: TPedidoCalculadoItem;
begin
  for LItem in FItems do
    LItem.Free;
  FItems.Free;
  inherited;
end;

class function TPedidoCalculado.FromFatVenda(AObjVenda: TFatVendaBase)
  : TPedidoCalculado;
var
  LItem: TPedidoCalculadoItem;
  LItemVenda: TDadosFechamento;
begin
  Result := TPedidoCalculado.Create;
  { TOTAIS }
  Result.totalProdutos := AObjVenda.fltTotPro;
  Result.descontoEspecial := AObjVenda.fltDesEsp;
  Result.valorFrete := AObjVenda.fltValFre;
  Result.despesasAcessorias := AObjVenda.fltDesAce;
  { IPI }
  Result.baseCalculoIPI := AObjVenda.fltBasIpi;
  Result.valorIPI := AObjVenda.fltTotIpi;
  { ST }
  Result.baseCalculoST := AObjVenda.fltBasRet;
  Result.valorST := AObjVenda.fltTotRet;
  { FCPST }
  Result.valorFCPST := AObjVenda.fltTotFcpST;
  { VLRCON }
  Result.valorTotal := AObjVenda.fltTotGer;
  { ICMS }
  Result.baseCalculoICMS := AObjVenda.fltBasIcm;
  Result.valorICMS := AObjVenda.fltTotIcm;
  { FCP }
  Result.baseCalculoFCP := AObjVenda.fltBasFcp;
  Result.valorFCP := AObjVenda.fltTotFcp;
  { ICMS DIFAL DESTINO }
  Result.valorDifalDestino := AObjVenda.fltTotIcmsDifalDestino;

  for LItemVenda in AObjVenda.arrMatItens do
  begin
    LItem := TPedidoCalculadoItem.Create;

    LItem.id := LItemVenda.intSeqInc;
    LItem.codigoItem := LItemVenda.strCodIte;
    LItem.quantidade := LItemVenda.fltQtdIte;
    LItem.precoUnitario := LItemVenda.fltUnitar;
    { TOTAIS }
    LItem.totalProduto := LItemVenda.fltTotIte; { + }
    LItem.descontoEspecial := LItemVenda.fltDesEsp; { - }
    LItem.valorFrete := LItemVenda.fltValFre; { + }
    LItem.despesaAcessoria := LItemVenda.fltDesAce; { + }
    { IPI }
    LItem.baseCalculoIPI := LItemVenda.fltBasIpi;
    LItem.aliquotaIPI := LItemVenda.fltAlqIpi;
    LItem.valorIPI := LItemVenda.fltValIpi; { + }
    { ST }
    LItem.baseCalculoST := LItemVenda.fltBasRet;
    LItem.valorST := LItemVenda.fltValRet; { + }
    { FCPST }
    LItem.valorFCPST := LItemVenda.GetValFcpST; { + }
    { VLRCON }
    LItem.valorTotal := LItemVenda.fltVlrCon; { = }
    { ICMS }
    LItem.baseCalculoICMS := LItemVenda.fltBasIcm;
    LItem.aliquotaICMS := LItemVenda.fltAlqIcm;
    LItem.valorICMS := LItemVenda.fltValIcm;
    { FCP }
    LItem.baseCalculoFCP := LItemVenda.GetBasFcp;
    LItem.aliquotaFCP := LItemVenda.GetAlqFcp;
    LItem.valorFCP := LItemVenda.GetValFcp;
    { ICMS DIFAL DESTINO }
    LItem.valorDifalDestino := LItemVenda.fltIcmsDifalDestino;
    { ADD ITEM CALCULADO }
    Result.Items.Add(LItem);
  end;
end;

function TPedidoCalculado.ToJsonString: string;
begin
  Result := TJSONCitel.ObjectToJSON(Self);
end;

end.
