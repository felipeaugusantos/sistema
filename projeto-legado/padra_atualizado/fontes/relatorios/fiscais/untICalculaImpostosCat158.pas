unit untICalculaImpostosCat158;

interface

uses untIDadosAdicionaisCalculaImpostosCat158,
     Data.DB;

type
  ICalculaImpostosCat158 = interface
  ['{9B73E641-FCD9-4ADC-9DD0-04D55898DBE9}']
    function fRetBaseStUnitaria: double;
    function fRetBaseSt: double;
    function fRetAlqSt: double;
    function fRetValorSt: double;

    procedure pSetDadosAdicionais(dados: IDadosAdicionaisCalculaImpostosCat158);
    procedure pSetQuantidadeUtilizada(fltQuantidadeUtilizada: double);
    procedure pSetQuantidadeComprada(fltQuantidadeComprada: double);
    procedure pSetBaseStUnitaria(fltBaseStUnitaria: double);
    procedure pSetBaseSt(fltBaseSt: double);
    procedure pSetAlqSt(fltAlqSt: double);
    procedure pSetValorSt(fltValorSt: double);
    procedure pSetValorN15Vbc(fltValorN15Vbc: double);
    procedure pSetValorN17Vicms(fltValorN17Vicms: double);
    procedure pSetValorN21VbcSt(fltValorN21VbcSt: double);
    procedure pSetValorN23VicmsSt(fltValorN23VicmsSt: double);
    procedure pSetValorIcmUnitar(fltValorIcmUnitar: double);
    procedure pSetBaseIcmsStEntrada(fltBaseIcmsStEntrada: double);
    procedure pSetAlqIcmsStEntrada(fltAlqIcmsStEntrada: double);

  end;

implementation

end.
