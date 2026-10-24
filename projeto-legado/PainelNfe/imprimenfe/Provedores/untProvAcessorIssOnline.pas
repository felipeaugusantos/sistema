unit untProvAcessorIssOnline;

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
  TProvAcessorIssOnline = class
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string);
  end;
implementation

{ TProvAcessorIssOnline }

class procedure TProvAcessorIssOnline.pRetornaCDSPreenchido(var cdsNFS, cdsItens: TUniClientDataSet;
 strXML: string);
var
  XmlDoc : IXMLDocument;
  XmlNodePrincipal,
  XmlNodeItens: IXMLNode;
begin
  XmlDoc := TXMLDocument.Create(Application);

  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;

  XmlNodePrincipal := XmlDoc.ChildNodes['NOTA'];
  cdsNFS.Append;

  //Cabeçalho
  cdsNFS.FieldByName('_LINK_').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['LINK']);
  cdsNFS.FieldByName('NUMNFS').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['COD']);
  cdsNFS.FieldByName('CODVER').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['RPS']);
  cdsNFS.FieldByName('DTAHRA').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['HORA']);
  cdsNFS.FieldByName('DTAEMI').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['DATA']);
  cdsNFS.FieldByName('DTVENISS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['DATAVENCIMENTO']);

  // Tributações
  cdsNFS.FieldByName('VLRPIS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PIS']));
  cdsNFS.FieldByName('VLRCOF').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['COFINS']));
  cdsNFS.FieldByName('VLRINS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['INSS']));
  cdsNFS.FieldByName('VLRIR_').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['IR']));
  cdsNFS.FieldByName('VLRCSL').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['CSLL']));
  cdsNFS.FieldByName('OUT_RET').AsFloat := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OUTRASRETENCOES']));
  cdsNFS.FieldByName('ALIISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ALIQUOTA']));
  cdsNFS.FieldByName('OUTTRI').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OUTROSTRIBUTOS']));
  cdsNFS.FieldByName('VLICMS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ICMS']));
  cdsNFS.FieldByName('VLCIDE').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['CIDE']));
  cdsNFS.FieldByName('VLRIPI').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['IPI']));
  cdsNFS.FieldByName('VLRIOF').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['IOF']));

  //Serviço
  cdsNFS.FieldByName('DESSER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ATIVCOD']) + ' - ' +
                                           fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ATIVDESC']);

  cdsNFS.FieldByName('DISCRI').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OBSSERVICO']);
  cdsNFS.FieldByName('VLRISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['VALORTOTALSERVICOS']));
  cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['BASECALC']));
  cdsNFS.FieldByName('ALIISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ALIQUOTA']));
  cdsNFS.FieldByName('ISS_RET').AsFloat := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['RETENCAO']));
  cdsNFS.FieldByName('VLRDED').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['DEDUCAO']));
  cdsNFS.FieldByName('VLISSR').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['IMPOSTO']));
  cdsNFS.FieldByName('LOCPRE').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['LOCALSERV']);

  cdsNFS.FieldByName('LOCMUN').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['MUNICIPIOFORA']) + ' - ' +
                                           fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['UFFORA']);

  cdsNFS.FieldByName('DEDMAT').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['DEDMATERIAIS']);
  cdsNFS.FieldByName('EMIRPS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['SITDESC']);
  cdsNFS.FieldByName('CODRET').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['RETIDO']);

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PRESTCPFCNPJ']);
  cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PRESTINSCRICAOMUN']);
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PRESTNOMERAZAO']);

  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PRESTPREFIXODESC']) + ' - '+
                                             fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PRESTLOGDESC']);
  cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PRESTNUMERO']);
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PRESTBAIRRODESC']);
  cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PRESTMUNICIPIODESC']);
  cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PRESTCEP']);
  cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PRESTMUNICIPIOUF']);
  cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emailPrestador']);

  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['TOMCPFCNPJ']);
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['TOMNOMERAZAO']);

  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['TOMPREFIXODESC']) + ' - '+
                                             fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['TOMLOGDESC']);

  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['TOMNUMERO']);
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['TOMBAIRRODESC']);
  cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['TOMMUNICIPIODESC']);
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['TOMCEP']);
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['TOMMUNICIPIOUF']);

  XmlNodeItens := XmlNodePrincipal.ChildNodes['SERVICOS'].ChildNodes['SERVICO'];
  cdsItens.Append;
  cdsItens.FieldByName('CODSER').AsString := fRetornaValorTagXml(XmlNodeItens.ChildNodes['CODIGO']);
  cdsItens.FieldByName('ITEDES').AsString := fRetornaValorTagXml(XmlNodeItens.ChildNodes['DESCRICAO']);
  cdsItens.FieldByName('ITEQTD').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeItens.ChildNodes['QUANTIDADE']));
  cdsItens.FieldByName('VLRDES').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeItens.ChildNodes['DESCONTO']));
  cdsItens.FieldByName('VLRSRV').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeItens.ChildNodes['VALOR']));
  cdsItens.Post;

  cdsNFS.Post;
end;

end.
