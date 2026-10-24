unit untProvSoftPlan;

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
  TProvSoftPlan = class
  private
  public
    class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
  end;
implementation

{ TProvSoftPlan }

class procedure TProvSoftPlan.pRetornaCDSPreenchido(
  var cdsNFS: TUniClientDataSet; strXML: string);
var
  strDtaEMi: String;

  XmlDoc: IXMLDocument;
  XmlNodePrincipal,
  XmlNodeItens: IXMLNode;
begin
  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;
  XmlNodePrincipal := XmlDoc.ChildNodes['xmlNfpse'];

  cdsNFS.Append;
  //Cabeçalho
  cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['numeroAEDF']);
  cdsNFS.FieldByName('SERRPS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['numeroSerie']);
  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['codigoVerificacao']);

  strDtaEMi := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['dataEmissao']);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(strDtaEMi,9,2)+'/'+
                                           Copy(strDtaEMi,6,2)+'/'+
                                           Copy(strDtaEMi,1,4);

  cdsNFS.FieldByName('DTHRCA').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['dataProcessamento']);
  cdsNFS.FieldByName('STATUS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['statusNFPSe']);
  cdsNFS.FieldByName('BCINSS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['baseCalculo']));
  cdsNFS.FieldByName('VLRSER').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorISSQN']));
  cdsNFS.FieldByName('VLRISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorTotalServicos']));
  cdsNFS.FieldByName('CODTRI').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['cfps']);
  cdsNFS.FieldByName('OUTINF').AsString := StringReplace(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['dadosAdicionais']),
                                                        'n', sLineBreak, [rfReplaceAll]);

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['cnpjPrestador']);
  cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['inscricaoMunicipalPrestador']);
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['razaoSocialPrestador']);
  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['logradouroPrestador']);
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['bairroPrestador']);
  cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['nomeMunicipioPrestador']);
  cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['codigoPostalPrestador']);
  cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ufPrestador']);
  cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emailPrestador']);

  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['identificacaoTomador']);
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['razaoSocialTomador']);
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['logradouroTomador']);
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['numeroEnderecoTomador']);
  cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['complementoEnderecoTomador']);
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['bairroTomador']);
  cdsNFS.FieldByName('TMSIBGE').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['codigoMunicipioTomador']);
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['codigoPostalTomador']);
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ufTomador']);
  cdsNFS.FieldByName('TMSPAIS').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['paisTomador']);
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emailTomador']);
  cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['telefoneTomador']);

  //Produto Serviço
  XmlNodeItens := XmlNodePrincipal.ChildNodes['itensServico'].ChildNodes['itemServico'];
  cdsNFS.FieldByName('ALIISS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeItens.ChildNodes['aliquota']));
  cdsNFS.FieldByName('BSCISS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeItens.ChildNodes['baseCalculo']));
  cdsNFS.FieldByName('CODSER').AsString  := fRetornaValorTagXml(XmlNodeItens.ChildNodes['codigoCNAE']);
  cdsNFS.FieldByName('TMSFONE').AsString := fRetornaValorTagXml(XmlNodeItens.ChildNodes['cst']);
  cdsNFS.FieldByName('DESSER').AsString  := fRetornaValorTagXml(XmlNodeItens.ChildNodes['descricaoCNAE']);
  cdsNFS.FieldByName('DISSER').AsString  := fRetornaValorTagXml(XmlNodeItens.ChildNodes['descricaoServico']);
  cdsNFS.FieldByName('CDCNAE').AsString  := fRetornaValorTagXml(XmlNodeItens.ChildNodes['idCNAE']);

  cdsNFS.FieldByName('ITEQTD').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeItens.ChildNodes['quantidade']));
  cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeItens.ChildNodes['valorTotal']));
  cdsNFS.FieldByName('ITEVLU').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeItens.ChildNodes['valorUnitario']));
  cdsNFS.Post;
end;

end.
