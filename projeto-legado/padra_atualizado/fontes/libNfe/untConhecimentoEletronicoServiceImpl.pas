unit untConhecimentoEletronicoServiceImpl;

interface

uses untConhecimentoEletronico, untInterfaces, untInterfacesConhecimentoEletronico, untCTEFit400, untUtil;

Type
  TConhecimentoEletronicoServiceImpl = class(TInterfacedObject, IConhecimentoEletronicoService)
    private
      fonteDados: IFonteDadosConhecimento;
      integracaoConhecimento: IIntegracaoConhecimentoEletronico;
    public
      constructor Create(fonteDados: IFonteDadosConhecimento; integracaoConhecimento: IIntegracaoConhecimentoEletronico);
      function fEnviarConhecimento(strNumeroConhecimento: String): Boolean;
      function fProcessarConhecimento(strNumeroConhecimento: String): TRetornoNFE;
      procedure pImprimirConhecimento(strNumeroConhecimento: String; strForcarImpressaoPDF: String = 'N');
      function fCancelarConhecimento(strNumeroConhecimento, strJustificativa, strNomeUsuario: String): Boolean;
      function fInsucessoNaEntrega(strNumeroConhecimento, strChaveAcessoNfe, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoInsucessoNaEntrega(strNumeroConhecimento: String): TRetornoNFE;
      function fConfirmacaoDeEntrega(strNumeroConhecimento, strChaveAcessoNfe, strDocumentoRecebedor, strNomeRecebedor, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoConfirmacaoDeEntrega(strNumeroConhecimento: String): TRetornoNFE;
  end;

Type
  TConhecimentoEletronicoFactory = class(TInterfacedObject, IInterface)
    public
      class function CreateIntegracaoConhecimento(fonteDados: IFonteDados): IIntegracaoConhecimentoEletronico;
  end;

implementation

{ TConhecimentoEletronicoServiceImpl }

constructor TConhecimentoEletronicoServiceImpl.Create(fonteDados: IFonteDadosConhecimento; integracaoConhecimento: IIntegracaoConhecimentoEletronico);
begin
  Self.fonteDados := fonteDados;
  Self.integracaoConhecimento := integracaoConhecimento;
end;

function TConhecimentoEletronicoServiceImpl.fCancelarConhecimento(strNumeroConhecimento, strJustificativa, strNomeUsuario: String): Boolean;
var
  conhecimento: TConhecimentoEletronico;
begin
  conhecimento := fonteDados.fGetConhecimentoCompacto(strNumeroConhecimento);
  Result := integracaoConhecimento.fCancelarConhecimento(conhecimento, strJustificativa, strNomeUsuario);
end;

function TConhecimentoEletronicoServiceImpl.fInsucessoNaEntrega(strNumeroConhecimento, strChaveAcessoNfe, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
var
  conhecimento: TConhecimentoEletronico;
begin
  conhecimento := fonteDados.fGetConhecimentoCompacto(strNumeroConhecimento);
  Result := integracaoConhecimento.fInsucessoNaEntrega(conhecimento, strChaveAcessoNfe, strMotivo, strJustificativa, strHashEntrega, strHashData);
end;

function TConhecimentoEletronicoServiceImpl.fCancelamentoInsucessoNaEntrega(strNumeroConhecimento: String): TRetornoNFE;
var
  conhecimento: TConhecimentoEletronico;
begin
  conhecimento := fonteDados.fGetConhecimentoCompacto(strNumeroConhecimento);
  Result := integracaoConhecimento.fCancelamentoInsucessoNaEntrega(conhecimento);
end;

function TConhecimentoEletronicoServiceImpl.fConfirmacaoDeEntrega(strNumeroConhecimento, strChaveAcessoNfe, strDocumentoRecebedor, strNomeRecebedor, strHashEntrega, strHashData: String): TRetornoNFE;
var
  conhecimento: TConhecimentoEletronico;
begin
  conhecimento := fonteDados.fGetConhecimentoCompacto(strNumeroConhecimento);
  Result := integracaoConhecimento.fConfirmacaoDeEntrega(conhecimento, strChaveAcessoNfe, strDocumentoRecebedor, strNomeRecebedor, strHashEntrega, strHashData);
end;

function TConhecimentoEletronicoServiceImpl.fCancelamentoConfirmacaoDeEntrega(strNumeroConhecimento: String): TRetornoNFE;
var
  conhecimento: TConhecimentoEletronico;
begin
  conhecimento := fonteDados.fGetConhecimentoCompacto(strNumeroConhecimento);
  Result := integracaoConhecimento.fCancelamentoConfirmacaoDeEntrega(conhecimento);
end;

function TConhecimentoEletronicoServiceImpl.fEnviarConhecimento(strNumeroConhecimento: String): Boolean;
var
  conhecimento: TConhecimentoEletronico;
begin
  conhecimento := fonteDados.fGetConhecimento(strNumeroConhecimento);
  Result := integracaoConhecimento.fEnviarConhecimento(conhecimento);
end;

function TConhecimentoEletronicoServiceImpl.fProcessarConhecimento(strNumeroConhecimento: String): TRetornoNFE;
var
  conhecimento: TConhecimentoEletronico;
begin
  conhecimento := fonteDados.fGetConhecimento(strNumeroConhecimento);
  Result := integracaoConhecimento.fProcessarConhecimento(conhecimento);
end;

procedure TConhecimentoEletronicoServiceImpl.pImprimirConhecimento(strNumeroConhecimento: String; strForcarImpressaoPDF: String = 'N');
var
  conhecimento: TConhecimentoEletronico;
begin
  conhecimento := fonteDados.fGetConhecimentoCompacto(strNumeroConhecimento);
  integracaoConhecimento.pImprimirConhecimento(conhecimento, objConfig.strFitImpressoraPadrao, strForcarImpressaoPDF);
end;

{ TConhecimentoEletronicoFactory }

class function TConhecimentoEletronicoFactory.CreateIntegracaoConhecimento(fonteDados: IFonteDados): IIntegracaoConhecimentoEletronico;
begin
  //Aqui, se mudar o parceiro de NFe ou a Citel implementar, muda aqui para criar de acordo.
  Result := TIntegracaoConhecimentoFit.Create(fonteDados);
end;

end.
