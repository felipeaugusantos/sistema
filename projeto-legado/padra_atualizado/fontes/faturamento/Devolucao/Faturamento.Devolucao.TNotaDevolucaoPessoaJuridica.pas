unit Faturamento.Devolucao.TNotaDevolucaoPessoaJuridica;

interface

uses
  Classes,
  SysUtils;


  type
    TVerificaAcesso = reference to function( chave: String; strOperador : String = '' ) : boolean;
    TGerericFunction = reference to function( ) : boolean;
    TPessoaJuridica  = reference to function ( strCodigoCliente : String  ) : boolean;

    TNotaDevolucaoPessoaJuridica = class
    private

      FPessoaJuridicaSemIES: TPessoaJuridica;
      FEspecieItensPermiteDevolucao: TGerericFunction;
      FVerificaAcesso: TVerificaAcesso;
      FPessoaJuridicaComIES: TPessoaJuridica;

    public

      Const
        DIREITO_DEVOLUCAO_SEM_IE = 'DVPJSI';
        CONFIGURACAO_DEVOLUCAO_SEM_IE = 'DVPJSI';

        DIREITO_DEVOLUCAO_COM_IE = 'DEVPJ';
        CONFIGURACAO_DEVOLUCAO_COM_IE = 'SEDVPJ';

        ESPECIE_MI = 'MI';
        ESPECIE_FATURAMENTO_FUTURO = 'FF';

      function fVerificaSePermiteDevolucaoEmpresaSemIES( strCodigoCliente  : String ) : Boolean;
      function fVerificaSePermiteDevolucaoEmpresaComIES( strCodigoCliente  : String ) : Boolean;
      class function fFiltroItensEspecieNaoValidaIES : String;

      property pVerificaAcesso : TVerificaAcesso read FVerificaAcesso write FVerificaAcesso;
      property pEspecieItensPermiteDevolucao : TGerericFunction  read FEspecieItensPermiteDevolucao write FEspecieItensPermiteDevolucao;
      property pPessoaJuridicaSemIES : TPessoaJuridica read FPessoaJuridicaSemIES write FPessoaJuridicaSemIES;
      property pPessoaJuridicaComIES : TPessoaJuridica read FPessoaJuridicaComIES write FPessoaJuridicaComIES;
  end;


implementation

uses
  Garantia.Constantes;



{ TNotaDevolucaoPessoaJuridica }

class function TNotaDevolucaoPessoaJuridica.fFiltroItensEspecieNaoValidaIES: String;
begin
  Result := 'ITE_ESPDEV IN (' + QuotedStr( ESPECIE_MI ) + ', ' + QuotedStr( ESPECIE_FATURAMENTO_FUTURO ) + ')';
end;

function TNotaDevolucaoPessoaJuridica.fVerificaSePermiteDevolucaoEmpresaComIES( strCodigoCliente  : String ): Boolean;
begin
  if( not FEspecieItensPermiteDevolucao() ) then
    Exit( False );

  if ( not FPessoaJuridicaComIES( strCodigoCliente) ) Then
    Exit( False );

  Result := True;
end;

function TNotaDevolucaoPessoaJuridica.fVerificaSePermiteDevolucaoEmpresaSemIES( strCodigoCliente  : String ): Boolean;
begin

  If ( FVerificaAcesso( DIREITO_DEVOLUCAO_SEM_IE ) ) Then
    Exit( False );

  If ( not FEspecieItensPermiteDevolucao() ) Then
    Exit( False );

  If ( not FPessoaJuridicaSemIES( strCodigoCliente) ) Then
    Exit( False );

  Result := True;

end;

end.
