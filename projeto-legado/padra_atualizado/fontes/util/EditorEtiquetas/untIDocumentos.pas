unit untIDocumentos;

interface

uses untTypesSistema, untIZClient;

Type
  IDocumentos = Interface(IZClient)
  ['{C3D3009F-96ED-4AB4-BDFD-8E726E415CF0}']
    procedure pIncluiDocumento(blnInclui: Boolean; srTipImp: String);
    procedure pExcluiDocumento;
    procedure pAtualizaNaoPadrao(strCodLay: String; intTipLay: Integer; tpaTipArq: TTipoArquivo);
    procedure pRefresh(strNumDoc: String);
  End;

implementation

end.
