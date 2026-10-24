unit untProvISSIntegra;

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
  TProvISSIntegra = class
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
  end;

implementation

class procedure TProvISSIntegra.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet;
  strXML: string);
var
  XmlDoc : IXMLDocument;

  XmlNodePrincipal,
  XmlNodeRps,
  XmlNodeServico,
  XmlNodePrestador,
  XMLNodeTomador : IXMLNode;

begin
  xmlDoc := TXMLDocument.Create(Application);

  xmlDoc.LoadFromXML(strXML);
  xmlDoc.Active := True;

  XmlNodePrincipal := XmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'];
  XmlNodeRps       := XmlNodePrincipal.ChildNodes['IdentificacaoRps'];
  XmlNodeServico   := XmlNodePrincipal.ChildNodes['Servico'];
  XmlNodePrestador := XmlNodePrincipal.ChildNodes['PrestadorServico'];
  XmlNodeTomador   := XmlNodePrincipal.ChildNodes['TomadorServico'];

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString :=  fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('SERNFS').AsString := '1';
  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('CodigoVerificacao'));
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')), 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),9,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),6,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),1,4);
  cdsNFS.FieldByName('EMIOSN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OptanteSimplesNacional']);
  cdsNFS.FieldByName('RESPTRIB').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['RegimeEspecialTributacao']);
  cdsNFS.FieldByName('EMIICC').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['IncentivadorCultural']);
  cdsNFS.FieldByName('COMPET').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Competencia'));
  cdsNFS.FieldByName('NUMRPS').AsString := fRetornaValorTagXml(XmlNodeRps.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('SERRPS').AsString := fRetornaValorTagXml(XmlNodeRps.ChildNodes.FindNode('Serie'));
  cdsNFS.FieldByName('EMIRPS').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissaoRps')),9,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissaoRps')),6,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissaoRps')),1,4);
  cdsNFS.FieldByName('OUTINF').AsString   := StringReplace(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OutrasInformacoes']), '\s\n', ' |', [rfReplaceAll]);
  cdsNFS.FieldByName('ORGMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('ORG_UF').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OrgaoGerador'].ChildNodes['Uf']);

  //Valores
  cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['Valores'].ChildNodes['BaseCalculo']));
  cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['Valores'].ChildNodes['ValorLiquidoNfse']));
  cdsNFS.FieldByName('VLRDED').AsFloat  := 0;

  //Valores Serviço
  cdsNFS.FieldByName('VALINS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['Valores'].ChildNodes['ValorInss']));
  cdsNFS.FieldByName('VLRSER').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['Valores'].ChildNodes['ValorServicos']));
  cdsNFS.FieldByName('ISS_RET').AsString := fRetornaValorTagXml(XmlNodeServico.ChildNodes['Valores'].ChildNodes['IssRetido']);
  cdsNFS.FieldByName('DESCONC').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['Valores'].ChildNodes['DescontoCondicionado']));
  cdsNFS.FieldByName('DESCONI').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['Valores'].ChildNodes['DescontoIncondicionado']));
  cdsNFS.FieldByName('VALPIS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['Valores'].ChildNodes['ValorPis']));
  cdsNFS.FieldByName('VALCOF').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['Valores'].ChildNodes['ValorCofins']));
  cdsNFS.FieldByName('VALIRR').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['Valores'].ChildNodes['ValorIr']));
  cdsNFS.FieldByName('VALCSL').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['Valores'].ChildNodes['ValorCsll']));
  cdsNFS.FieldByName('OUT_RET').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['Valores'].ChildNodes['OutrasRetencoes']));
  cdsNFS.FieldByName('VLRISS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['Valores'].ChildNodes['ValorIss']));
  cdsNFS.FieldByName('ALIISS').AsFloat   := ( fStrToFloatDef(fRetornaValorTagXml(XmlNodeServico.ChildNodes['Valores'].ChildNodes['Aliquota'])) * 100 );

  //Informações de Serviço
  cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(XmlNodeServico.ChildNodes['ItemListaServico']);
  cdsNFS.FieldByName('CDCNAE').AsString := fRetornaValorTagXml(XmlNodeServico.ChildNodes['CodigoCnae']);
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := StringReplace(fRetornaValorTagXml(XmlNodeServico.ChildNodes['Discriminacao']), '\s\n', ' |', [rfReplaceAll]);
  cdsNFS.FieldByName('CODMUN').AsString := fRetornaValorTagXml(XmlNodeServico.ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('EXIISS').AsString := '';
  cdsNFS.FieldByName('MUNINC').AsString := '';
  cdsNFS.FieldByName('NATOPE').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['NaturezaOperacao']);

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['IdentificacaoPrestador'].ChildNodes['Cnpj']);
  cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal']);
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['RazaoSocial']);
  cdsNFS.FieldByName('PSVFANT').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['NomeFantasia']);
  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['Endereco'].ChildNodes['Endereco']);
  cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['Endereco'].ChildNodes['Numero']);
  cdsNFS.FieldByName('PSVCOMPL').AsString := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['Endereco'].ChildNodes['Complemento']);
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['Endereco'].ChildNodes['Bairro']);
  cdsNFS.FieldByName('PSVMUN').AsString   := '';
  cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['Endereco'].ChildNodes['Uf']);
  cdsNFS.FieldByName('PSVCEP').AsString   := fFormataCEP(fRetornaValorTagXml(XmlNodePrestador.ChildNodes['Endereco'].ChildNodes['Cep']));
  cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['Contato'].ChildNodes['Telefone']);
  cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['Contato'].ChildNodes['Email']);

  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString  := IIF(fEmptyStr(fRetornaValorTagXml(XmlNodeTomador.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'])),
                                                           fRetornaValorTagXml(XmlNodeTomador.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf']),
                                                           fRetornaValorTagXml(XmlNodeTomador.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj']));
  cdsNFS.FieldByName('TMSIM').AsString    := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['IdentificacaoTomador'].ChildNodes['InscricaoMunicipal']);
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['RazaoSocial']);
  cdsNFS.FieldByName('TMSFANTA').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['NomeFantasia']);
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['Endereco'].ChildNodes['Endereco']);
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['Endereco'].ChildNodes['Numero']);
  cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['Endereco'].ChildNodes['Complemento']);
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['Endereco'].ChildNodes['Bairro']);
  cdsNFS.FieldByName('TMSMUN').AsString   := '';
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['Endereco'].ChildNodes['Uf']);
  cdsNFS.FieldByName('TMSCEP').AsString   := fFormataCEP(fRetornaValorTagXml(XmlNodeTomador.ChildNodes['Endereco'].ChildNodes['Cep']));
  cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['Contato'].ChildNodes['Telefone']);
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['Contato'].ChildNodes['Email']);

  cdsNFS.Post;
end;

end.
