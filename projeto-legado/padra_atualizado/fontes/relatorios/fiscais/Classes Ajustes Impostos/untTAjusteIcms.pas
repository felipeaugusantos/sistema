unit untTAjusteIcms;

interface

type
  TAjusteIcms = class
  private
    FObservacao: string;
    FTipo: string;
    FValor: double;
  public
    property strObservacao: string read FObservacao write FObservacao;
    property strTipo: string read FTipo write FTipo;
    property fltValor: double read FValor write FValor;
  end;

const OUTROS_DEBITOS = '0';
      ESTORNO_CREDITO = '1';
      OUTROS_CREDITOS = '2';
      ESTORNO_DEBITO = '3';
      DEDUCAO_IMPOSTO = '4';
      DEBITOS_ESPECIAIS = '5';

implementation

end.
