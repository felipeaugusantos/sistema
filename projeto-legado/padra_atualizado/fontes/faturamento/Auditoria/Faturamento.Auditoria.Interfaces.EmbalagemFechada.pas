unit Faturamento.Auditoria.Interfaces.EmbalagemFechada;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'};
{$ELSE}
  UniClientDataSet;
{$ENDIF}

type
  IAuditoriaEmbFechada = interface
  ['{CB45F122-9B51-4FAC-9E38-5E220F0F7218}']

    function LocalizouItemAuditoriaEmbFechada(const ACodigoDaEmpresa, ACodigoItem, ATabelaPreco,
      ACodigoDeBarra: String; const AQuantidadeItem: Double): Boolean;

    procedure GravarClientDataSetItemAuditoriaEmbFechada(const ACodigoDaEmpresa, ACodigoItem,
      ATabelaPreco, ACodigoDeBarra: String; const AQuantidadeItem,
      APercDesEmbFec: Double);

    function RetornarValorPercentualDescontoEmbalagemFechada(
      Const ACodigoDaEmpresa, ACodigoDoItem, ATabelaDePreco, CodigoDeBarras : String ; Const AQuantidadeDoItem : Double) : Double;
  end;

implementation

end.


