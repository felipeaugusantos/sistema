unit untInterfacesManifestoEletronico;

interface

uses
 {$IF Defined(UNIDAC)}
  Uni,
 {$IFEND}
  untManifestoEletronico, untInterfaces, DB;

Type
  IFonteDadosManifesto = Interface(IInterface)
    function fGetManifesto(strNumeroManifesto: String): TManifestoEletronico;
    function fGetManifestoCompacto(strNumeroManifesto: String): TManifestoEletronico;
    function fExecutaQuery(strSQL: String; arrParametros: Array Of String; arrValores: Array Of Variant): TDataSet;
    function fSuportaOperacaoBanco: Boolean;
    {$IF Defined(UNIDAC)}
    function fRetDataBase: TUniConnection;
    {$IFEND}
  End;

Type
  IIntegracaoManifestoEletronico = Interface(IInterface)
    function fEnviarManifesto(manifesto: TManifestoEletronico): Boolean;
    function fProcessarManifesto(manifesto: TManifestoEletronico): TRetornoNFE; overload;
    function fProcessarManifesto(manifesto: TManifestoEletronico; strImpressora: String): TRetornoNFE; overload;
    procedure pImprimirManifesto(manifesto: TManifestoEletronico; strImpressora: String);
    function fEncerrarManifesto(manifesto: TManifestoEletronico): Boolean;
    function fCancelarManifesto(manifesto: TManifestoEletronico; strJustificativa: String): Boolean;
    function fEnviarDocsCarregadosManifesto(manifesto: TManifestoEletronico; strListaAutoIncrem: string): Boolean;
    function fEnviarManifestoEventoPagamento(manifesto: TManifestoEletronico): Boolean;
  End;

implementation

end.
