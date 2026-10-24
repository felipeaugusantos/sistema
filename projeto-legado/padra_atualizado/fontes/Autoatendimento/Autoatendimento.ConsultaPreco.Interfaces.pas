unit Autoatendimento.ConsultaPreco.Interfaces;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections;

type
  IAutoatendimentoConsultaAtributos = interface
    ['{421C39F9-CB7B-44D5-9DD0-BBB037F24A41}']
    function Grupo(): String;
    function Descricao(): String;
    function Valor: String;
  end;

  IAutoatendimentoConsultaEmbalagem = interface
    ['{FE87611E-0A19-4A88-AA95-F96F9F411030}']
    function TabelaPreco: String;
    function PrecoVenda: Double;
    function Quantidade: Double;
  end;

  IAutoatendimentoConsultaProduto = interface
    ['{DACBA1A5-CD41-459F-9F8A-88E03A9D1F07}']
    function Codigo(): String;
    function Descricao(): String;
    function PrecoVenda(): Double;
    function UnidadeVenda(): String;
    function PrecoTabela(): Double;
    function TextoAdicionalPreco(): String;
    function PathImagemPrincipal(): String;
    function PathVideoApresentacao(): String;
    function DetalhesUtilizacao(): String;
    function EmbalagemFechada(): Boolean;
    function QuantidadeEmbalagem(): Double;
    function EmPromocao(): Boolean;
    function DadosTecnicos(): TList<IAutoatendimentoConsultaAtributos>;
    function ProdutosSimilares: TList<IAutoatendimentoConsultaProduto>;
    function ProdutosAgregados: TList<IAutoatendimentoConsultaProduto>;
  end;

  IAutoatendimentoConsultaPreco = interface
    ['{89CC7552-1759-4791-8290-67794F78B8B2}']
    function Consultar(ACodBarras: String): IAutoatendimentoConsultaProduto;
    function PathLogotipoEmpresa(): String;
    function SegmentoCliente(): String;
  end;

  EAutoatendimentoConsultaPrecoError = Class(Exception);

implementation

end.
