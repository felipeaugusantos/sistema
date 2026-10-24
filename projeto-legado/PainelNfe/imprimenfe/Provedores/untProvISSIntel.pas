unit untProvISSIntel;

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
  TProvISSIntel = class
  private
  public
    class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
  end;
implementation

{ TProvISSIntel }

class procedure TProvISSIntel.pRetornaCDSPreenchido(
  var cdsNFS: TUniClientDataSet; strXML: string);
var
  strDtaEmiNFS: String;
  strDtaEmiRPS: String;
  XmlDoc: IXMLDocument;
  XmlNodePrincipal,
  XmlNodeItens: IXMLNode;
begin
  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;
  XmlNodePrincipal := XmlDoc.ChildNodes['Notas'].ChildNodes['Nota'];

  cdsNFS.Append;
  //Cabeçalho
  cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['numeroNota']);
  cdsNFS.FieldByName('SERNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['serieNota']);
  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['codigoVerificacao']);
  strDtaEmiNFS := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['dataEmissao']);
  strDtaEmiRPS := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['dataEmissaoRps']);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(strDtaEmiNFS,9,2)+'/'+
                                           Copy(strDtaEmiNFS,6,2)+'/'+
                                           Copy(strDtaEmiNFS,1,4);
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(strDtaEmiNFS,12,8);
  cdsNFS.FieldByName('DTHRCA').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['dataEmissao']);
  cdsNFS.FieldByName('STATUS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['situacaoNota']);
  cdsNFS.FieldByName('NUMRPS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['numeroRps']);
  cdsNFS.FieldByName('SERRPS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['serieRps']);
  cdsNFS.FieldByName('TPORPS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['tipoRps']);
  cdsNFS.FieldByName('EMIRPS').AsString := Copy(strDtaEmiRPS,9,2)+'/'+
                                           Copy(strDtaEmiRPS,6,2)+'/'+
                                           Copy(strDtaEmiRPS,1,4);
  cdsNFS.FieldByName('COMPET').AsString :=Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['competencia']),5,2)+'/'+
                                          Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['competencia']),1,4);
  cdsNFS.FieldByName('BCINSS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorBruto']));
  cdsNFS.FieldByName('VLRSER').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorLiquidoNfse']));
  cdsNFS.FieldByName('VLRISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorIss']));
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('OUTINF').AsString := '';

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['cpfCnpjPrestador']);
  cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['inscricaoAtividade']);
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['razaoSocialPrestador']);
  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['enderecoPrestador']);
  cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['numeroEnderecoPrestador']);
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['bairroPrestador']);
  cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['descricaoCidadeTomador']);
  cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['cepPrestador']);
  cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ufPrestador']);
  cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emailPrestador']);

  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['cpfCnpjTomador']);
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['razaoSocialTomador']);
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['enderecoTomador']);
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['numeroEnderecoTomador']);
  cdsNFS.FieldByName('TMSCOMPL').AsString := '';
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['bairroTomador']);
  cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['descricaoCidadeTomador']);
  cdsNFS.FieldByName('TMSIBGE').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['cidadeTomador']);
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['cepTomador']);
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ufTomador']);
  cdsNFS.FieldByName('TMSPAIS').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['paisTomador']);
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emailTomador']);
  cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['telefoneTomador']);

  //Produto Serviço
  cdsNFS.FieldByName('ALIISS').AsFloat   := ( fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['aliquotaServicos'])) * 100 );
  cdsNFS.FieldByName('BSCISS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['baseDeCalculo']));
  cdsNFS.FieldByName('CODSER').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['itemListaServico']);
  cdsNFS.FieldByName('DESSER').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['descricaoCnae']);
  cdsNFS.FieldByName('DISCRI').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['discriminacao']);
  cdsNFS.FieldByName('CDCNAE').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['codigoCnae']);
  cdsNFS.FieldByName('NATOPE').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['naturezaOperacao']);
  cdsNFS.FieldByName('NATOPE_XML').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['naturezaOperacao']);

  cdsNFS.FieldByName('ITEQTD').AsFloat  := 1;
  cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorLiquidoNfse']));
  cdsNFS.FieldByName('ITEVLU').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valorBruto']));

  cdsNFS.FieldByName('EMIOSN').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['optanteSimplesNacional']);

  cdsNFS.Post;
end;

end.
