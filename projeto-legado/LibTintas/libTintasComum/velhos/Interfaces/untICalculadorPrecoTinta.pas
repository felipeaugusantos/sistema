{*********************************************************************************************}
{* Interface que representa um calculador de preço da tinta ao todo, onde retorna os valores *}
{* para o Autcom                                                                             *}
{******************************************************************************************PH*}
unit untICalculadorPrecoTinta;

interface

uses
  untIDicionario, untIDataSet;

type
  ICalculadorPrecoTinta = interface
    ['{5E0A6871-3E22-4DD5-8167-58E2447936BB}']
    function fRetornaPreco(const Sender: TObject; const dicRetorno: IDicionario; const dtsCadTin: IDataSet): Boolean;
  end;


implementation

end.
