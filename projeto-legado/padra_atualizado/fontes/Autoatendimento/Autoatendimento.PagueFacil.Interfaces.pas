unit Autoatendimento.PagueFacil.Interfaces;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections;

Type
  IAutoatendimentoPagueFacilEndereco = Interface
    ['{88D7B340-C5E8-466C-BBAE-F008D7CA8DDC}']
    function Logradouro: String;
    function Bairro: String;
    function Complemento: String;
    function Cep: String;
    function Cidade: String;
    function Estado: String;
  end;

  IAutoatendimentoPagueFacilCliente = interface
    ['{B341BA13-5282-47BE-B365-AAEDA65EEAC8}']
    function Codigo: String;
    function Nome: String;
    function Documento: String;
    function Telefone: String;
    function Endereco: IAutoatendimentoPagueFacilEndereco;
    function EhConsumidor: Boolean;
  end;

  IAutoatendimentoPagueFacilEntrega = interface
    ['{617A1882-27B1-42EB-B157-485BC8196B23}']
    function Endereco: IAutoatendimentoPagueFacilEndereco;
  end;

  IAutoatendimentoPagueFacilPagamento = interface
    ['{CB2D5437-DB93-4401-A4D2-141D6D23C646}']
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

  IAutoatendimentoPagueFacilPedidoItens = interface
    ['{BA8F9DAE-6A39-48C8-857A-225200C5C785}']
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

  IAutoatendimentoPagueFacilPedido = interface
    ['{9F51455C-A891-46A7-AB55-0DF2CAB1FA1E}']
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
    function Cliente: IAutoatendimentoPagueFacilCliente;
    function Entrega: IAutoatendimentoPagueFacilEntrega;
    function Pagamento: IAutoatendimentoPagueFacilPagamento;
    function Produtos: TList<IAutoatendimentoPagueFacilPedidoItens>;
    function AutoIncremPixVinculadoAoPedido: String;
  end;

  IAutoatendimentoPagueFacilRecebimentoPedido = interface
    ['{A1BA74C6-BBB5-4E70-B190-437D06FC0A1E}']
    function Pedido: IAutoatendimentoPagueFacilPedido;
    function CarregarPedido(ANumeroPedido: String): IAutoatendimentoPagueFacilRecebimentoPedido;
    function RealizarAdiantamento: IAutoatendimentoPagueFacilRecebimentoPedido;
    function ModoEmitirNFCe: Boolean;
    function EmitirNFCe: IAutoatendimentoPagueFacilRecebimentoPedido;
    function TipoCartao: string;
    function Parcelas: Integer;
    procedure SetTipoCartao(AValue: string);
    procedure SetParcelas(AValue: Integer);
    function SolicitaDadosCartao: Boolean;
    function NumeroMaximoParcelas: Integer;
    function UsaComanda: Boolean;
    function TravaFormaNegociada: Boolean;
    function TravaFormaNegociadaPelaConPag : Boolean;
    function CPFValido(ACPF : String): Boolean;
    function FormataCPF(ACPF : String) : String;
    function NFCeAutorizada: Boolean;
  end;

  EAutoatendimentoPagueFacilError = Class(Exception);

  TCallLogTot = reference to procedure(const AstrMenssagem: String; const AobjPagueFacil : IAutoatendimentoPagueFacilRecebimentoPedido; const AException: Exception = Nil) ; // of object;

implementation

end.
