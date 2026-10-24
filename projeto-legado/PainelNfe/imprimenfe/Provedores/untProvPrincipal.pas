unit untProvPrincipal;

interface

uses
  SysUtils, StrUtils, Classes, untUniClientDataSet, untUtil;

const ARR_LISTA_PROV: Array[0..38] Of String = (

// NOME  PROVEDOR  // INDEX  -- pExecutaProv
  'FIORILLI',           // 0
  'CONAM',              // 1
  'NOBE',               // 2
  'PRONIM',             // 3
  'SOFTPLAN',           // 4
  'ISSNET',             // 5
  'GERAL',              // 6
  'ACESSOR_ISS_ONLINE', // 7
  'GINFES',             // 8
  'SIGCORP',            // 9
  'GCASPP',             // 10
  'EL',                 // 11
  'ELOTECH',            // 12
  'TIPLAN',             // 13
  'IMA',                // 14
  'SIMPLISS',           // 15
  'GISSONLINE',         // 16
  'GOVBRISS',           // 17
  'GIAP',               // 18
  'GINFE4',             // 19
  'ISSWEB',             // 20
  'SAATRI',             // 21
  'SIAPPA',             // 22
  'ISSINTEL',           // 23
  'RLZ',                // 24
  'APL2',               // 25
  'MEMORY',             // 26
  'IPM',                // 27
  'NOBEV2',             // 28
  'BETHA',              // 29
  'PORTAL_NACIONAL',    // 30
  'PELOTAS',            // 31
  'IPMV2',              // 32
  'ISSINTEGRA',         // 33
  'PRIMAX',             // 34
  'PROVIMPVREFORMA',    // 35
  'GOVBRISSREFORMA',    // 36
  'GINFESREFORMA',      // 37
  'GESTAOISS'           // 38
);

type
  TProvPrincipal = class
    private
      class procedure pExecutaProv(intIdx: Integer; var cdsNFS: TUniClientDataSet; strXML: String; strNumDoc: String = '';
        strCodEmp: String = ''; strEspDoc: String = ''; cdsItens: TUniClientDataSet=nil; ATipoNFS: TTipoNFS = nfsXML;
        strCidNfse: String = ''; cdsFaturas: TUniClientDataSet=nil; strNomProv: String = '');
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML, strNomProv: string; strNumDoc: String = '';
        strCodEmp: String = ''; strEspDoc: String = ''; cdsItens: TUniClientDataSet=nil; ATipoNFS: TTipoNFS = nfsXML;
        strCidNfse: String = ''; cdsFaturas: TUniClientDataSet=nil);
  end;
implementation

uses
  untProvFiorilli, untProvConam, untProvNobe, untProvPronim, untProvSoftPlan,
  untProvIssNet, untProvGeral, untProvAcessorIssOnline, untProvGinfes,
  untProvSigCorp, untProvGcaspp, untProvEl, untProvEloTech, untProvTiplan,
  untProvIMA, untProvSimpliss, untProvGissOnline, untProvGovBrISS, untProvGiap,
  untProvIssWeb, untProvSaatri, untProvSiappa, untProvISSIntel, untProvRLZ,
  untProvApl2, untProvMemory, untProvIPM, untProvBetha, untProvPortalNacional,
  untProvPelotas, untProvISSIntegra, untProvPrimax, untProvGestaoISS;

{ TProvPrincipal }

class procedure TProvPrincipal.pExecutaProv(intIdx: Integer; var cdsNFS: TUniClientDataSet; strXML: String; strNumDoc: String = '';
  strCodEmp: String = ''; strEspDoc: String = ''; cdsItens: TUniClientDataSet=nil; ATipoNFS: TTipoNFS = nfsXML;
  strCidNfse: String = ''; cdsFaturas: TUniClientDataSet=nil; strNomProv: String = '');
begin
  Case intIdx Of
    0: TProvFiorilli.pRetornaCDSPreenchido(cdsNFS, strXML);
    1: TProvConam.pRetornaCDSPreenchido(cdsNFS, strXML);
    2: TProvNobe.pRetornaCDSPreenchido(cdsNFS, strXML);
    3: TProvPronim.pRetornaCDSPreenchido(cdsNFS, strXML);
    4: TProvSoftPlan.pRetornaCDSPreenchido(cdsNFS, strXML);
    5: TProvIssNet.pRetornaCDSPreenchido(cdsNFS, strXML, strNumDoc, strCodEmp, strEspDoc);
    6: TProvGeral.pRetornaCDSPreenchido(cdsNFS, strXML, strNumDoc, strCodEmp, strEspDoc, cdsItens, ATipoNFS, strCidNfse);
    7: TProvAcessorIssOnline.pRetornaCDSPreenchido(cdsNFS, cdsItens, strXML);
    8: TProvGinfes.pRetornaCDSPreenchido(cdsNFS, strXML);
    9: TProvSigCorp.pRetornaCDSPreenchido(cdsNFS, strXML);
    10: TProvGcaspp.pRetornaCDSPreenchido(cdsNFS, strXML);
    11: TProvEl.pRetornaCDSPreenchido(cdsNFS, strXML);
    12: TProvEloTech.pRetornaCDSPreenchido(cdsNFS, strXML, strNumDoc, strCodEmp, strEspDoc, cdsItens, ATipoNFS, strCidNfse);
    13: TProvTiplan.pRetornaCDSPreenchido(cdsNFS, strXML);
    14: TProvIMA.pRetornaCDSPreenchido(cdsNFS, strXML);
    15: TProvSimpliss.pRetornaCDSPreenchidoComENotas(cdsNFS, cdsItens, strXML, strCidNfse);
    16: TProvGissOnline.pRetornaCDSPreenchido(cdsNFS, strXML);
    17: TProvGovBrISS.pRetornaCDSPreenchido(cdsNFS, strXML);
    18: TProvGiap.pRetornaCDSPreenchido(cdsNFS, strXML);
    19: TProvGinfesV4.pRetornaCDSPreenchido(cdsNFS, strXML, strCidNfse);
    20: TProvIssWeb.pRetornaCDSPreenchido(cdsNFS, strXML, strNumDoc, strCodEmp, strEspDoc, cdsItens, ATipoNFS, strCidNfse);
    21: TProvSaatri.pRetornaCDSPreenchido(cdsNFS, strXML);
    22: TProvSiappa.pRetornaCDSPreenchido(cdsNFS, strXML);
    23: TProvIssIntel.pRetornaCDSPreenchido(cdsNFS, strXML);
    24: TProvRLZ.pRetornaCDSPreenchido(cdsNFS, cdsItens, strXML, strNumDoc);
    25: TProvApl2.pRetornaCDSPreenchido(cdsNFS, strXML);
    26: TProvMemory.pRetornaCDSPreenchido(cdsNFS, strXML);
    27: TProvIPM.pRetornaCDSPreenchido(cdsNFS, strXML);
    28: TProvNobeV2.pRetornaCDSPreenchido(cdsNFS, strXML);
    29: TProvBetha.pRetornaCDSPreenchido(cdsNFS, strXML);
    30: TProvPortalNacional.pRetornaCDSPreenchido(cdsNFS, strXML, strNumDoc, strCodEmp, strEspDoc);
    31: TProvPelotas.pRetornaCDSPreenchido(cdsNFS, strXML);
    32: TProvIPMV2.pRetornaCDSPreenchido(cdsNFS, strXML);
    33: TProvISSIntegra.pRetornaCDSPreenchido(cdsNFS, strXML);
    34: TProvPrimax.pRetornaCDSPreenchido(cdsNFS, cdsItens, cdsFaturas, strXML);
    35: TProvIPMVReforma.pRetornaCDSPreenchido(cdsNFS, strXML);
    36: TProvGovBrISSReforma.pRetornaCDSPreenchido(cdsNFS, strXML);
    37: TProvGinfesReforma.pRetornaCDSPreenchido(cdsNFS, strXML, strCidNfse);
    38: TProvGestaoISS.pRetornaCDSPreenchido(cdsNFS, strXML);
    Else raise Exception.CreateFmt('Provedor não implementado no case: %s (idx=%d)', [strNomProv, intIdx]);
  End;
end;

class procedure TProvPrincipal.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML, strNomProv: string; strNumDoc: String = '';
  strCodEmp: String = ''; strEspDoc: String = ''; cdsItens: TUniClientDataSet=nil; ATipoNFS: TTipoNFS = nfsXML;
  strCidNfse: String = ''; cdsFaturas: TUniClientDataSet=nil);
begin
  If Not MatchStr(strNomProv, ARR_LISTA_PROV) Then
    raise Exception.Create('Não existe provedor na lista de provedores. untProvPricipal');

  pExecutaProv(IndexStr(strNomProv, ARR_LISTA_PROV), cdsNFS, strXML, strNumDoc, strCodEmp, strEspDoc, cdsItens, ATipoNFS, strCidNfse, cdsFaturas, strNomProv);

end;

end.
