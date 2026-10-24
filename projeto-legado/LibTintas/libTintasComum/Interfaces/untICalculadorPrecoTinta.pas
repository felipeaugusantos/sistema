{*********************************************************************************************}
{* Interface que representa um calculador de preço da tinta ao todo, onde retorna os valores *}
{* para o Autcom                                                                             *}
{******************************************************************************************PH*}
unit untICalculadorPrecoTinta;

interface

uses
  untIDicionario, untIDataSet, Classes;

type
  ICalculadorPrecoTinta = interface
    ['{5E0A6871-3E22-4DD5-8167-58E2447936BB}']
    function fRetornaPreco(const Sender: TObject; dicRetorno: IDicionario; const dtsCadTin: IDataSet;
      blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil;
      strMD5Key: String = ''; blnSemTela: Boolean = False; strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean;
  end;


implementation

end.
