unit untManifestoEletronicoServiceImpl;

interface

uses untManifestoEletronico, untInterfaces, untInterfacesManifestoEletronico, untManifestoFit;

Type
  TManifestoEletronicoServiceImpl = class(TInterfacedObject, IManifestoEletronicoSerivce)
    private
      fonteDados: IFonteDadosManifesto;
      integracaoManifesto: IIntegracaoManifestoEletronico;
    public
      constructor Create(fonteDados: IFonteDadosManifesto;
        integracaoManifesto: IIntegracaoManifestoEletronico);
      function fEnviarManifesto(strNumeroManifesto: String): Boolean;
      function fProcessarManifesto(strNumeroManifesto: String): TRetornoNFE; overload;
      function fProcessarManifesto(strNumeroManifesto: String; strImpressora: String): TRetornoNFE; overload;
      procedure pImprimirManifesto(strNumeroManifesto: String); overload;
      procedure pImprimirManifesto(strNumeroManifesto: String; strImpressora: String); overload;
      function fEncerrarManifesto(strNumeroManifesto: String): Boolean;
      function fCancelarManifesto(strNumeroManifesto, strJustificativa: String): Boolean;
      function fEnviarDocsCarregadosManifesto(strNumeroManifesto, strListaAutoIncrem: String): Boolean;
      function fEnviarManifestoEventoPagamento(strNumeroManifesto: String): Boolean;
  end;

Type
  TManifestoEletronicoFactory = class(TInterfacedObject, IInterface)
    public
      class function CreateIntegracaoManifesto(fonteDados: IFonteDadosManifesto): IIntegracaoManifestoEletronico;
  end;

implementation

{ TManifestoEletronicoServiceImpl }

uses untUtil;

constructor TManifestoEletronicoServiceImpl.Create(
  fonteDados: IFonteDadosManifesto;
  integracaoManifesto: IIntegracaoManifestoEletronico);
begin
  Self.fonteDados := fonteDados;
  Self.integracaoManifesto := integracaoManifesto;
end;

function TManifestoEletronicoServiceImpl.fCancelarManifesto(strNumeroManifesto,
  strJustificativa: String): Boolean;
  Var
    manifesto: TManifestoEletronico;
begin
  manifesto := fonteDados.fGetManifestoCompacto(strNumeroManifesto);
  Result := integracaoManifesto.fCancelarManifesto(manifesto, strJustificativa);
end;

function TManifestoEletronicoServiceImpl.fEncerrarManifesto(
  strNumeroManifesto: String): Boolean;
  Var
    manifesto: TManifestoEletronico;
begin
  manifesto := fonteDados.fGetManifestoCompacto(strNumeroManifesto);
  Result := integracaoManifesto.fEncerrarManifesto(manifesto);
end;

function TManifestoEletronicoServiceImpl.fEnviarDocsCarregadosManifesto(
  strNumeroManifesto, strListaAutoIncrem: String): Boolean;
  Var
    manifesto: TManifestoEletronico;
begin
  manifesto := fonteDados.fGetManifesto(strNumeroManifesto);
  Result := integracaoManifesto.fEnviarDocsCarregadosManifesto(manifesto, strListaAutoIncrem);
end;

function TManifestoEletronicoServiceImpl.fEnviarManifesto(
  strNumeroManifesto: String): Boolean;
  Var
    manifesto: TManifestoEletronico;
begin
  manifesto := fonteDados.fGetManifesto(strNumeroManifesto);
  Result := integracaoManifesto.fEnviarManifesto(manifesto);
end;

function TManifestoEletronicoServiceImpl.fEnviarManifestoEventoPagamento(strNumeroManifesto: String): Boolean;
Var
  manifesto: TManifestoEletronico;
begin
  manifesto := fonteDados.fGetManifesto(strNumeroManifesto);
  Result := integracaoManifesto.fEnviarManifestoEventoPagamento(manifesto);
end;

function TManifestoEletronicoServiceImpl.fProcessarManifesto(
  strNumeroManifesto: String): TRetornoNFE;
begin
  Result := fProcessarManifesto(strNumeroManifesto, '');
end;

function TManifestoEletronicoServiceImpl.fProcessarManifesto(
  strNumeroManifesto: String; strImpressora: String): TRetornoNFE;
  Var
    manifesto: TManifestoEletronico;
begin
  manifesto := fonteDados.fGetManifesto(strNumeroManifesto);
  Result := integracaoManifesto.fProcessarmanifesto(manifesto, strImpressora);
end;

procedure TManifestoEletronicoServiceImpl.pImprimirManifesto(strNumeroManifesto: String);
begin
  pImprimirManifesto(strNumeroManifesto, objConfig.strFitImpressoraPadrao);
end;

procedure TManifestoEletronicoServiceImpl.pImprimirManifesto(strNumeroManifesto: String; strImpressora: String);
  Var
    manifesto: TManifestoEletronico;
begin
  manifesto := fonteDados.fGetManifestoCompacto(strNumeroManifesto);
  integracaoManifesto.pImprimirManifesto(manifesto, strImpressora);
end;

{ TManifestoEletronicoFactory }

class function TManifestoEletronicoFactory.CreateIntegracaoManifesto(fonteDados: IFonteDadosManifesto): IIntegracaoManifestoEletronico;
begin
  //Aqui, se mudar o parceiro de NFe ou a Citel implementar, muda aqui para criar de acordo.
  Result := TIntegracaoManifestoFit.Create(fonteDados);
end;

end.
