unit untConfigNFE;

interface

Type
  TConfiguracoesNFE = class(TInterfacedObject, IInterface)
      strCodEmp: String;
      blnSimPau: Boolean;
      strClaSub: String;
      strClaVen: String;
      blnNFEFab: Boolean;
      blnNfeMFi: Boolean;
      blnVendad: Boolean;
      strNfeEmp: String;
      blnNfeDse: Boolean;
      blnHomolo: Boolean;
      blnCclNfe: Boolean;
      strNfeIte: String;
      strPatOph: String;
      strIteSer: String;
      blnUsaSer: Boolean;
      blnCdpNfe: Boolean;
      blnOrgDfi: Boolean;
      strEndPrc: String;
      strTelPrc: String;
      strEndAle: String;
      strTelAle: String;
      strCliPro: String;
      blnConIpi: Boolean;
      blnRIcmPr: Boolean;
      strPatNES: String;
      strCliNES: String;
      strReEsTr: String;

      //CONFIGURA합ES CARREGADAS INTERNAMENTE
      fltAlqPis: Double;
      fltAlqCof: Double;
      blnDesFab: Boolean;
      strClaDev: String;
      strCstSimSubs: String;
      strCstSimTrib: String;
      strCstSimTribCI: String;
      strOpcImpValIpi: String;
      strVS_CliAti: string;
      strEmaTra: string;
      strNtOpNS: String;
      blnSimISS: Boolean;
      blnCstIpiOutras: Boolean;
      blnFabNfe: Boolean;
      blnClaOnu: Boolean;
      blnVenMad: Boolean;

      //Config FIT
      strFitLicenca: String;
      strFitUsuario: String;
      strFitSenha: String;
      strFitUrlWebService: String;
      strFitImpressoraPadrao: String;
      intFitViasDanfe: Integer;

      blnNFEMar: Boolean;

      strImpPag: String;

      strImpIcmsOpeProprias: String;

      strCstSimSubsForaEstado: String;

      blnNFELoc: Boolean;
      strFitUrlWebServiceManifesto: String;

      blnInfGar: Boolean;

      strTpNfCr: String;

      strClaCif: String;
      blnImpCif: Boolean;

      strEmpNFSe: String;

      {******************************************************************}
      {* N홒 CRIAR MAIS CONFIGURA합ES AQUI. USAR TConfiguracoesInternas *}
      {***************************************************************MV*}
      strIteTax: String;

      blnAutCen: Boolean;

      blnVenMtl: Boolean;

      blnNfeFCI: Boolean;

      strAPCSOS: String;
      blnPRFCFB: Boolean;

      blnAgrDoc: Boolean;

      strFitUrlWebServiceConhecimento: String;

      strCfoIPI: String;

      strEmpLog: String;

      strPCitel: String;

      strPathSatCitel: String;

      blnNfiMdf: Boolean;

      {*******************************************************************}
      {* ATEN플O ATEN플O ATEN플O ATEN플O ATEN플O ATEN플O ATEN플O ATEN플O *}
      {*                                                                 *}
      {*                   N홒 CRIAR MAIS NADA AQUI                      *}
      {*                                                                 *}
      {* ATEN플O ATEN플O ATEN플O ATEN플O ATEN플O ATEN플O ATEN플O ATEN플O *}
      {****************************************************REQ-265224**VA*}

    public
      procedure pValoresDefault;
      procedure pCarregaConfiguracoesFit;
  End;

Type
  TConfiguracaoProxy = Record
    strFitUsuarioProxy: String;
    strFitSenhaProxy: String;
    strFitProxy: String;
    strFitProxyByPass: String;
  End;

implementation

{ TConfiguracoesNFE }

procedure TConfiguracoesNFE.pValoresDefault;
begin
  fltAlqPis := 0.0;
  fltAlqCof := 0.0;
  blnDesFab := True;
end;

procedure TConfiguracoesNFE.pCarregaConfiguracoesFit;
begin

end;

end.
