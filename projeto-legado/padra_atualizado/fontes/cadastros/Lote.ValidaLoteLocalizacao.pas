unit Lote.ValidaLoteLocalizacao;

interface

uses classes;

Type
  TValidaLoteLocalizacao = class

  private
    FCfgLoteEnderecamento: String;

  public

    property strCfgLoteEnderecamento: String read FCfgLoteEnderecamento  write FCfgLoteEnderecamento;

    function fValidaCfgLoteEnderecamento: Boolean;

End;

  CONST
    INFORMA_LOTE_MANUALMENTE     = '1';
    INFORMA_LOTE_AUTOMATICAMENTE = '2';

implementation

{ TValidaLoteLocalizacao }

function TValidaLoteLocalizacao.fValidaCfgLoteEnderecamento: Boolean;
begin

  Result:= False;

  if FCfgLoteEnderecamento <> INFORMA_LOTE_AUTOMATICAMENTE then
    Result:= True;

end;

end.
