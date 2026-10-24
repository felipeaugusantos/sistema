unit Garantia.TValidacaoNotaRecebimentoCliente;

interface

uses
  Classes,
  SysUtils;

Type
  TValidacaoNotaRecebimentoCliente = class
    private
      FAliquotaIPI: Boolean;
      FValorSubstituicaoTributaria: Boolean;
      FBaseCalculoIPI: Boolean;
      FAliquotaICMS: Boolean;
      FBaseCalculoICMS: Boolean;
      FValorIPI: Boolean;
      FBaseCalculoSubstituicaoTributaria: Boolean;
      FCodigoSituacaoTributaria: Boolean;
      FValorICMS: Boolean;
      FQuantidade: Boolean;
      FValorBruto: Boolean;
      FValorFundoCombatePobrezaST: Boolean;
      FCST: Boolean;
      FAliquotaFundoCombatePobrezaST: Boolean;
      FDesconto: Boolean;
      FBaseCalculoFundoCombatePobrezaST: Boolean;
      FClassificacaoFiscal: Boolean;
      FDescricao: Boolean;
      FValorFundoCombatePobreza: Boolean;
      FAliquotaFundoCombatePobreza: Boolean;
      FBaseCalculoFundoCombatePobreza: Boolean;

    public
      property blnDescricao : Boolean                             read FDescricao                              write FDescricao;
      property blnValorBruto: Boolean                             read FValorBruto                             write FValorBruto;
      property blnQuantidade: Boolean                             read FQuantidade                             write FQuantidade;
      property blnCodigoSituacaoTributaria: Boolean               read FCodigoSituacaoTributaria               write FCodigoSituacaoTributaria;
      property blnBaseCalculoICMS: Boolean                        read FBaseCalculoICMS                        write FBaseCalculoICMS;
      property blnAliquotaICMS: Boolean                           read FAliquotaICMS                           write FAliquotaICMS;
      property blnValorICMS: Boolean                              read FValorICMS                              write FValorICMS;
      property blnBaseCalculoSubstituicaoTributaria: Boolean      read FBaseCalculoSubstituicaoTributaria      write FBaseCalculoSubstituicaoTributaria;
      property blnValorSubstituicaoTributaria: Boolean            read FValorSubstituicaoTributaria            write FValorSubstituicaoTributaria;
      property blnBaseCalculoIPI: Boolean                         read FBaseCalculoIPI                         write FBaseCalculoIPI;
      property blnAliquotaIPI: Boolean                            read FAliquotaIPI                            write FAliquotaIPI;
      property blnValorIPI: Boolean                               read FValorIPI                               write FValorIPI;
      property blnCST : Boolean                                   read FCST                                    write FCST;
      property blnDesconto : Boolean                              read FDesconto                               write FDesconto;
      property blnBaseCalculoFundoCombatePobreza : Boolean        read FBaseCalculoFundoCombatePobreza         write FBaseCalculoFundoCombatePobreza;
      property blnAliquotaFundoCombatePobreza : Boolean           read FAliquotaFundoCombatePobreza            write FAliquotaFundoCombatePobreza;
      property blnValorFundoCombatePobreza : Boolean              read FValorFundoCombatePobreza               write FValorFundoCombatePobreza;
      property blnBaseCalculoFundoCombatePobrezaST : Boolean      read FBaseCalculoFundoCombatePobrezaST       write FBaseCalculoFundoCombatePobrezaST;
      property blnAliquotaFundoCombatePobrezaST : Boolean         read FAliquotaFundoCombatePobrezaST          write FAliquotaFundoCombatePobrezaST;
      property blnValorFundoCombatePobrezaST : Boolean            read FValorFundoCombatePobrezaST             write FValorFundoCombatePobrezaST;
      property blnClassificacaoFiscal : Boolean                   read FClassificacaoFiscal                    write FClassificacaoFiscal;

      function fExisteInconscistencia: boolean;

      constructor Create;

  End;

implementation

{ TValidacaoNotaRecebimentoCliente }

constructor TValidacaoNotaRecebimentoCliente.Create;
begin

  FDescricao := False;
  FAliquotaIPI := False;
  FValorSubstituicaoTributaria := False;
  FBaseCalculoIPI := False;
  FAliquotaICMS := False;
  FBaseCalculoICMS := False;
  FValorIPI := False;
  FBaseCalculoSubstituicaoTributaria := False;
  FCodigoSituacaoTributaria := False;
  FValorICMS := False;
  FQuantidade := False;
  FValorBruto := False;
  FCST := False;
  FBaseCalculoFundoCombatePobrezaST := False;
  FAliquotaFundoCombatePobrezaST := False;
  FValorFundoCombatePobrezaST := False;
  FBaseCalculoFundoCombatePobreza := False;
  FAliquotaFundoCombatePobreza := False;
  FValorFundoCombatePobreza := False;
  FDesconto := False;
  FClassificacaoFiscal := False;
end;

function TValidacaoNotaRecebimentoCliente.fExisteInconscistencia : boolean;
begin
  Result := False;
  Result := Result or ( not FDescricao );
  Result := Result or ( not FAliquotaIPI );
  Result := Result or ( not FValorSubstituicaoTributaria );
  Result := Result or ( not FBaseCalculoIPI );
  Result := Result or ( not FAliquotaICMS );
  Result := Result or ( not FBaseCalculoICMS );
  Result := Result or ( not FValorIPI );
  Result := Result or ( not FBaseCalculoSubstituicaoTributaria );
  Result := Result or ( not FCodigoSituacaoTributaria );
  Result := Result or ( not FValorICMS );
  Result := Result or ( not FQuantidade );
  Result := Result or ( not FValorBruto );
  Result := Result or ( not FCST );
  Result := Result or ( not FDesconto );
  Result := Result or ( not FAliquotaFundoCombatePobrezaST );
  Result := Result or ( not FBaseCalculoFundoCombatePobrezaST );
  Result := Result or ( not FValorFundoCombatePobrezaST );
  Result := Result or ( not FAliquotaFundoCombatePobreza );
  Result := Result or ( not FBaseCalculoFundoCombatePobreza );
  Result := Result or ( not FValorFundoCombatePobreza );
  Result := Result or ( not FClassificacaoFiscal );
end;

end.
