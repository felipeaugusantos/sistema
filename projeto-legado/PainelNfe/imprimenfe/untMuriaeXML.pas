unit untMuriaeXML;

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
  TMuriaeXML = class

    public

      class procedure pNoElemento( strXML : string; var varXmlDoc : IXMLDocument; var varNoElemento : IXMLNode );
      class procedure pNoInfNfse(var varNoElemento : IXMLNode; var varNoInfNfse : IXMLNode );

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

const
  ns3 = 'http://www.ginfes.com.br/servico_consultar_lote_rps_resposta_v03.xsd';
  ns4 = 'http://www.ginfes.com.br/tipos_v03.xsd';

implementation

class procedure TMuriaeXML.pNoElemento( strXML : string; var varXmlDoc : IXMLDocument; var varNoElemento : IXMLNode );
begin

  varXmlDoc := TXMLDocument.Create(Application);
  varXmlDoc.LoadFromXML(strXML);
  varXmlDoc.Active := True;

  varNoElemento := varXmlDoc.DocumentElement;

end;

class procedure TMuriaeXML.pNoInfNfse(var varNoElemento : IXMLNode; var varNoInfNfse : IXMLNode );
begin
  If varNoElemento <> Nil then
  begin
    varNoInfNfse := varNoElemento.ChildNodes.FindNode('ns4:InfNfse', ns4);
    varNoInfNfse.ChildNodes.First;
  end;
end;

class procedure TMuriaeXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string;
  cdsItens: TUniClientDataSet);
var
  prefixo: string;
  XmlDoc : IXMLDocument;
  NoElemento,
  NoInfNfse : IXMLNode;
begin

  pNoElemento(strXML, XmlDoc, NoElemento);
  pNoInfNfse(NoElemento, NoInfNfse);

  If NoInfNfse <> Nil Then
  Begin

    prefixo := IfThen(strCidadeNFSe='CITEL', '', 'ns4:');

    //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS

    cdsNFS.Append;

    cdsNFS.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes[prefixo+'Numero'].Text;
    cdsNFS.FieldByName('CODVER').AsString := NoInfNfse.ChildNodes[prefixo+'CodigoVerificacao'].Text;
    cdsNFS.FieldByName('DTAHRA').AsString := NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text;
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text,9,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text,6,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text,1,4);

    cdsNFS.FieldByName('NUMRPS').AsString := NoInfNfse.ChildNodes[prefixo+'IdentificacaoRps'].ChildNodes[prefixo+'Numero'].Text;
    cdsNFS.FieldByName('SERRPS').AsString := NoInfNfse.ChildNodes[prefixo+'IdentificacaoRps'].ChildNodes[prefixo+'Serie'].Text;
    cdsNFS.FieldByName('TPORPS').AsString := NoInfNfse.ChildNodes[prefixo+'IdentificacaoRps'].ChildNodes[prefixo+'Tipo'].Text;

    cdsNFS.FieldByName('EMIRPS').AsString := NoInfNfse.ChildNodes[prefixo+'DataEmissaoRps'].Text;
    cdsNFS.FieldByName('NATOPE').AsString := NoInfNfse.ChildNodes[prefixo+'NaturezaOperacao'].Text;
    cdsNFS.FieldByName('CODRET').AsString := NoInfNfse.ChildNodes[prefixo+'RegimeEspecialTributacao'].Text;
    cdsNFS.FieldByName('EMIOSN').AsString := NoInfNfse.ChildNodes[prefixo+'OptanteSimplesNacional'].Text;
    cdsNFS.FieldByName('EMIICC').AsString := NoInfNfse.ChildNodes[prefixo+'IncentivadorCultural'].Text;
    cdsNFS.FieldByName('COMPET').AsString := Copy(NoInfNfse.ChildNodes[prefixo+'Competencia'].Text,9,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes[prefixo+'Competencia'].Text,6,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes[prefixo+'Competencia'].Text,1,4);
    //SERVIÇOS

    cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorServicos'].Text,'.',','), 0);
    cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'IssRetido'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorIss'].Text,'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'BaseCalculo'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'Aliquota'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorIssRetido'].Text,'.',','), 0);

    cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorPis'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorCofins'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorIr'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorInss'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorCsll'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorLiquidoNfse'].Text,'.',','), 0);

    cdsNFS.FieldByName('CODSER').AsString := NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'ItemListaServico'].Text;
    cdsNFS.FieldByName('CODTRI').AsString := NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'CodigoTributacaoMunicipio'].Text;
    cdsNFS.FieldByName('DISCRI').AsString := NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Discriminacao'].Text;
    cdsNFS.FieldByName('CODMUN').AsString := NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'CodigoMunicipio'].Text;

    //PRESTADOR DO SERVIÇO

    cdsNFS.FieldByName('PSVCNPJ').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'IdentificacaoPrestador'].ChildNodes[prefixo+'Cnpj'].Text;
    cdsNFS.FieldByName('PSVIM').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'IdentificacaoPrestador'].ChildNodes[prefixo+'InscricaoMunicipal'].Text;
    cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'RazaoSocial'].Text;
    cdsNFS.FieldByName('PSVEND').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Endereco'].Text;
    cdsNFS.FieldByName('PSVNUM').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Numero'].Text;
    cdsNFS.FieldByName('PSVBAIR').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Bairro'].Text;
    cdsNFS.FieldByName('PSVMUN').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'CodigoMunicipio'].Text;
    cdsNFS.FieldByName('PSVUF').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Uf'].Text;
    cdsNFS.FieldByName('PSVCEP').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Cep'].Text;
    cdsNFS.FieldByName('PSVFONE').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Telefone'].Text;
    cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Email'].Text;

    //TOMADOR DO SERVIÇO

    cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'CpfCnpj'].ChildNodes[prefixo+'Cnpj'].Text),
                                                            NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'CpfCnpj'].ChildNodes[prefixo+'Cpf'].Text,
                                                            NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'CpfCnpj'].ChildNodes[prefixo+'Cnpj'].Text);

    cdsNFS.FieldByName('TMSRAZAO').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'RazaoSocial'].Text;
    cdsNFS.FieldByName('TMSEND').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Endereco'].Text;
    cdsNFS.FieldByName('TMSNUM').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Numero'].Text;
    cdsNFS.FieldByName('TMSBAIR').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Bairro'].Text;
    cdsNFS.FieldByName('TMSMUN').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'CodigoMunicipio'].Text;
    cdsNFS.FieldByName('TMSUF').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Uf'].Text;
    cdsNFS.FieldByName('TMSCEP').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Cep'].Text;
    cdsNFS.FieldByName('TMSFONE').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Telefone'].Text;
    cdsNFS.FieldByName('TMSEMAIL').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Email'].Text;

    // ORGÃO GERADOR

    cdsNFS.FieldByName('ORGMUN').AsString := NoInfNfse.ChildNodes[prefixo+'OrgaoGerador'].ChildNodes[prefixo+'CodigoMunicipio'].Text;
    cdsNFS.FieldByName('ORG_UF').AsString := NoInfNfse.ChildNodes[prefixo+'OrgaoGerador'].ChildNodes[prefixo+'Uf'].Text;

    cdsNFS.Post;

  end;

end;

end.
