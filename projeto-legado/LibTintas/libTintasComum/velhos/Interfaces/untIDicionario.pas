{**********************************************************************************************}
{* Interface que representa a implementação de um Dicionario, com isso é possivel realizar as *}
{* transferencias de variaveis entre autcomtinta e a dll especifica da tinta                  *}
{*******************************************************************************************PH*}
unit untIDicionario;

interface

type
  IDicionario = interface
    ['{BF345E82-0456-445B-BF3E-DCA3C50F9E26}']
    procedure Adicionar(strChave: String; Valor: Variant);
    procedure AdicionarObjeto(strChave: String; Valor: TObject);
    procedure Remove(strChave: String);
    procedure Limpar;
    function Retorna(strChave: String): Variant;
    function RetornaObjeto(strChave: String): TObject;
    property Items[Index: String]: Variant read Retorna write Adicionar; default; 
  end;


implementation

end.
