unit Garantia.TItemNotaRecebimentoCliente;

interface

uses
  Classes,
  SysUtils;

Type
  TItemNotaRecebimentoCliente = class
    private
      FCodigo: String;
      FDescricao: String;
      FReferencia: String;
      FBaseCalculoICMS: double;
      FValorICMS: double;
      FSiglaUnidade: String;
      FCodigoFabrica: String;
      FBaseCalculoIPI: double;
      FAliquotaIPI: double;
      FBaseCalculoSubstituicaoTributaria: double;
      FValorSubstituicaoTributaria: double;
      FClassificacaoFiscal: String;
      FValorIPI: double;
      FCodigoSituacaoTributaria: String;
      FAliquotaICMS: double;
      FQuantidade: double;
      FValorBruto: double;
      FCST: string;
      FDesconto: double;
      FAliquotaFundoCombatePobrezaST: double;
      FBaseCalculoFundoCombatePobrezaST: double;
      FValorFundoCombatePobrezaST: double;
      FTipo: integer;
      FAliquotaFundoCombatePobreza: double;
      FBaseCalculoFundoCombatePobreza: double;
      FValorFundoCombatePobreza: double;

    public

      property intTipo : integer                                 read FTipo;
      property strCodigo: String                                 read FCodigo                                 write FCodigo;
      property strCodigoFabrica: String                          read FCodigoFabrica                          write FCodigoFabrica;
      property strDescricao: String                              read FDescricao                              write FDescricao;
      property strReferencia: String                             read FReferencia                             write FReferencia;
      property strSiglaUnidade: String                           read FSiglaUnidade                           write FSiglaUnidade;
      property strCodigoSituacaoTributaria: String               read FCodigoSituacaoTributaria               write FCodigoSituacaoTributaria;
      property fltValorBruto: double                             read FValorBruto                             write FValorBruto;
      property fltQuantidade: double                             read FQuantidade                             write FQuantidade;
      property fltBaseCalculoICMS: double                        read FBaseCalculoICMS                        write FBaseCalculoICMS;
      property fltAliquotaICMS: double                           read FAliquotaICMS                           write FAliquotaICMS;
      property fltValorICMS: double                              read FValorICMS                              write FValorICMS;
      property fltBaseCalculoSubstituicaoTributaria: double      read FBaseCalculoSubstituicaoTributaria      write FBaseCalculoSubstituicaoTributaria;
      property fltValorSubstituicaoTributaria: double            read FValorSubstituicaoTributaria            write FValorSubstituicaoTributaria;
      property fltBaseCalculoIPI: double                         read FBaseCalculoIPI                         write FBaseCalculoIPI;
      property fltAliquotaIPI: double                            read FAliquotaIPI                            write FAliquotaIPI;
      property fltValorIPI: double                               read FValorIPI                               write FValorIPI;
      property strClassificacaoFiscal: String                    read FClassificacaoFiscal                    write FClassificacaoFiscal;
      property strCST : string                                   read FCST                                    write FCST;
      property fltDesconto : double                              read FDesconto                               write FDesconto;
      property fltBaseCalculoFundoCombatePobrezaST : double      read FBaseCalculoFundoCombatePobrezaST       write FBaseCalculoFundoCombatePobrezaST;
      property fltAliquotaFundoCombatePobrezaST : double         read FAliquotaFundoCombatePobrezaST          write FAliquotaFundoCombatePobrezaST;
      property fltValorFundoCombatePobrezaST : double            read FValorFundoCombatePobrezaST             write FValorFundoCombatePobrezaST;
      property fltBaseCalculoFundoCombatePobreza : double        read FBaseCalculoFundoCombatePobreza         write FBaseCalculoFundoCombatePobreza;
      property fltAliquotaFundoCombatePobreza : double           read FAliquotaFundoCombatePobreza            write FAliquotaFundoCombatePobreza;
      property fltValorFundoCombatePobreza : double              read FValorFundoCombatePobreza               write FValorFundoCombatePobreza;

      constructor Create( intTipo : integer );

  End;

implementation

{ TItemNotaRecebimentoCliente }

constructor TItemNotaRecebimentoCliente.Create( intTipo : integer );
begin

  FTipo := intTipo;
  FCodigo := '';
  FDescricao := '';
  FReferencia := '';
  FBaseCalculoICMS := 0;
  FValorICMS := 0;
  FSiglaUnidade := '';
  FCodigoFabrica := '';
  FValorBruto := 0;
  FQuantidade := 0;
  FBaseCalculoIPI := 0;
  FAliquotaIPI := 0;
  FBaseCalculoSubstituicaoTributaria := 0;
  FValorSubstituicaoTributaria := 0;
  FClassificacaoFiscal := '';
  FValorIPI := 0;
  FCodigoSituacaoTributaria := '';
  FAliquotaICMS := 0;
  FCST := '';
  FDesconto := 0;
  FAliquotaFundoCombatePobrezaST := 0;
  FBaseCalculoFundoCombatePobrezaST := 0;
  FValorFundoCombatePobrezaST := 0;
  FAliquotaFundoCombatePobreza := 0;
  FBaseCalculoFundoCombatePobreza := 0;
  FValorFundoCombatePobreza := 0;

end;

end.
