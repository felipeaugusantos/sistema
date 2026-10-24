unit untProvConam;

interface

uses
{$IF Defined(LINUX)}
  untUniClientDataSet,
{$ELSE}
  {$IF Defined(UNIDAC)}
    UniClientDataSet, Uni, MySQLUniProvider, UniProvider,
  {$ELSE}
   ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  Windows, Messages, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, DBCtrls, MemDS, Dialogs,
  frxClass, frxBarcode, frxDBSet, frxDelphiZXingQRCode,
  frxDesgn, untUniClientDataSet,
{$IFEND}
  SysUtils, Variants, Classes, StrUtils, untConexaoBD,
  untUtil, XMLIntf, XMLDoc, DB, DBClient;

type
  TProvConam = class
    private
      class procedure pCarregaTagPrincipal(const ATagPrincipalValidacao : IXMLNode;  var ATagPrincipalRetorno : IXMLNode);
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
  end;

implementation

class procedure TProvConam.pCarregaTagPrincipal(const ATagPrincipalValidacao : IXMLNode;  var ATagPrincipalRetorno : IXMLNode);
begin
  If ATagPrincipalValidacao <> nil Then
    ATagPrincipalRetorno := ATagPrincipalValidacao;
end;

class procedure TProvConam.pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
var
  NoInfNfse         : IXMLDocument;
  NoPrincipal       : IXMLNode;
  dtDataVenIss      : TDateTime;
begin
  NoInfNfse := TXMLDocument.Create(Application);

  NoInfNfse.LoadFromXML(strXML);
  NoInfNfse.Active := True;
  pCarregaTagPrincipal(NoInfNfse.ChildNodes['Reg20Item'], NoPrincipal);

  cdsNFS.Append;
  dtDataVenIss := StrToDateTime(fRetornaValorTagXml(NoPrincipal.ChildNodes['DtEmiRps']));
  IncMonth(dtDataVenIss, 1);

  // INFOS NFS
  cdsNFS.FieldByName('DTVENISS').AsString := DateTimeToStr(dtDataVenIss);
  cdsNFS.FieldByName('NUMNFS').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['NumNf']);
  cdsNFS.FieldByName('SERNFS').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['SerNf']);
  cdsNFS.FieldByName('CODVER').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['CodVernf']);
  cdsNFS.FieldByName('DTAEMI').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['DtHrGerNf']);
  cdsNFS.FieldByName('SERRPS').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['SerRps']);
  cdsNFS.FieldByName('NUMRPS').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['NumRps']);
  cdsNFS.FieldByName('EMIRPS').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['DtEmiRps']);

  // PRESTADOR
  cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(NoPrincipal.ChildNodes['CpfCnpjPre']);
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['RazSocPre']);
  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['LogPre']);
  cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['NumEndPre']);
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(NoPrincipal.ChildNodes['BairroPre']);
  cdsNFS.FieldByName('PSVCID').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['MunPre']);
  cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['CepPre']);
  cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(NoPrincipal.ChildNodes['SiglaUFPre']);

  // TRIBUTAÇÃO E DISCRIMINAÇÃO
  cdsNFS.FieldByName('TRBSIT').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['TipoTribPre']);
  cdsNFS.FieldByName('DISSER').AsString   := StringReplace(fRetornaValorTagXml(NoPrincipal.ChildNodes['DiscrSrv']), 'n', sLineBreak, [rfReplaceAll]);

  cdsNFS.FieldByName('CODSER').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['CodSrv']);
  cdsNFS.FieldByName('DISCRDED').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['DiscrDed']);

  cdsNFS.FieldByName('ALIISS').AsFloat    := StrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['AlqIss']), 0);
  cdsNFS.FieldByName('ISSRET').AsFloat    := StrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['VlIssRet']), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['VlIss']), 0);
  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['VlNFS']), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat    := StrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['VlBasCalc']), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['VlDed']), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat   := 0;
  cdsNFS.FieldByName('TOTRIB').AsFloat    := StrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['ValorTributos']), 0);

  // TOMADOR
  cdsNFS.FieldByName('TMSCNPJ').AsString  := fRetornaValorTagXml(NoPrincipal.ChildNodes['CpfCnpjTom']);
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['RazSocTom']);
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['LogTom']);
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['NumEndTom']);
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(NoPrincipal.ChildNodes['BairroTom']);
  cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['MunTom']);
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['CepTom']);
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(NoPrincipal.ChildNodes['SiglaUFTom']);
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(NoPrincipal.ChildNodes['EMailTom']);

  // LOCAL DE PRESTAÇÃO
  cdsNFS.FieldByName('LOCPRE').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['LogLocPre']);
  cdsNFS.FieldByName('LOCNUM').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['NumEndLocPre']);
  cdsNFS.FieldByName('LOCCPL').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['ComplEndLocPre']);
  cdsNFS.FieldByName('LOCBAI').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['BairroLocPre']);
  cdsNFS.FieldByName('LOCMUN').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['MunLocPre']);
  cdsNFS.FieldByName('LOC_UF').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['SiglaUFLocpre']);
  cdsNFS.FieldByName('LOCCEP').AsString   := fRetornaValorTagXml(NoPrincipal.ChildNodes['CepLocPre']);



  cdsNFS.FieldByName('_LINK_').AsString   := 'Nota: '        + fRetornaValorTagXml(NoPrincipal.ChildNodes['NumNf']) + '/' + fRetornaValorTagXml(NoPrincipal.ChildNodes['SerNf']) +
                                             ', Emissao:'    + fRetornaValorTagXml(NoPrincipal.ChildNodes['DtHrGerNf']) +
                                             ', CodVerif: '  + fRetornaValorTagXml(NoPrincipal.ChildNodes['CodVernf'])+
                                             ', Prestador: ' + fRetornaValorTagXml(NoPrincipal.ChildNodes['CpfCnpjPre']) + '-' + fRetornaValorTagXml(NoPrincipal.ChildNodes['RazSocPre']) +
                                             ', Tomador: '   + fRetornaValorTagXml(NoPrincipal.ChildNodes['CpfCnpjTom']) + '-' + fRetornaValorTagXml(NoPrincipal.ChildNodes['RazSocTom']) +
                                             ', Valor NFES: '+ FormatFloat('00.00', StrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['VlNFS']), 0)) +
                                             ', ValorISS: '  + FormatFloat('00.00', StrToFloatDef(fRetornaValorTagXml(NoPrincipal.ChildNodes['VlIss']), 0));
  cdsNFS.Post;
end;

end.
