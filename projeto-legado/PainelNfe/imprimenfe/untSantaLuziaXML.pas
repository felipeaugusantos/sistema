unit untSantaLuziaXML;

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
  TSantaLuziaXML = class

    private

    public

      class procedure pCarregaNoPrincipal( strXML : string );
      class procedure pCarregaNoInfNfse( NoElemento: IXMLNode );

      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string; strCidadeNFSe: string);

  end;

var
  XmlDoc : IXMLDocument;
  NoElemento,
  NoInfNfse,
  NoDeclaracaoPrestacaoServico,
  NoInfDeclaracaoPrestacaoServico,
  NoRps : IXMLNode;

const
  ns2 = 'http://www.abrasf.org.br/nfse.xsd';

implementation

{ TSantaLuziaXML }

class procedure TSantaLuziaXML.pCarregaNoPrincipal( strXML : string );
begin

  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;

  NoElemento := XmlDoc.DocumentElement;

end;

class procedure TSantaLuziaXML.pCarregaNoInfNfse( NoElemento: IXMLNode );
begin
  If not ( NoElemento = nil ) Then
  Begin
    NoInfNfse := NoElemento.childNodes.FindNode('InfNfse', ns2);
    NoInfNfse.ChildNodes.First;
  End;
end;

class procedure TSantaLuziaXML.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
begin
  //
end;

class procedure TSantaLuziaXML.pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string; strCidadeNFSe: string);
begin

  pCarregaNoPrincipal( strXML );
  pCarregaNoInfNfse( NoElemento );

  cdsNFS.Append;

  // Dados da NFS

  cdsNFS.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('SERIE').AsString  := 'E';
  cdsNFS.FieldByName('CODVER').AsString := NoInfNfse.ChildNodes['CodigoVerificacao'].Text;
  cdsNFS.FieldByName('DTAHRA').AsString := NoInfNfse.ChildNodes['DataEmissao'].Text;
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,1,4);

  cdsNFS.FieldByName('NUMRPS').AsString := NoInfNfse.ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('SERRPS').AsString := NoInfNfse.ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
  cdsNFS.FieldByName('TPORPS').AsString := NoInfNfse.ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;

  cdsNFS.FieldByName('EMIRPS').AsString := NoInfNfse.ChildNodes['DataEmissaoRps'].Text;
  cdsNFS.FieldByName('NATOPE').AsString := NoInfNfse.ChildNodes['NaturezaOperacao'].Text;
  cdsNFS.FieldByName('CODRET').AsString := NoInfNfse.ChildNodes['RegimeEspecialTributacao'].Text;
  cdsNFS.FieldByName('EMIOSN').AsString := NoInfNfse.ChildNodes['OptanteSimplesNacional'].Text;
  cdsNFS.FieldByName('EMIICC').AsString := NoInfNfse.ChildNodes['IncentivadorCultural'].Text;
  cdsNFS.FieldByName('COMPET').AsString := Copy(NoInfNfse.ChildNodes['Competencia'].Text,1,10);
  cdsNFS.FieldByName('OUTINF').AsString := NoInfNfse.ChildNodes['OutrasInformacoes'].Text;
  cdsNFS.FieldByName('ORGMUN').AsString := NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('ORG_UF').AsString := NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;

  //Valores

  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['IssRetido'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIss'].Text,'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['Aliquota'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIssRetido'].Text,'.',','), 0);

  cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorInss'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes'].Text,'.',','), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoIncondicionado'].Text,'.',','), 0);
  cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoCondicionado'].Text,'.',','), 0);
  cdsNFS.FieldByName('OUT_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['OutrasRetencoes'].Text,'.',','), 0);

  cdsNFS.FieldByName('VALCRE').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValorCredito'].Text,'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString := NoInfNfse.ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
  cdsNFS.FieldByName('CODTRI').AsString := NoInfNfse.ChildNodes['Servico'].ChildNodes['CodigoTributacaoMunicipio'].Text;
  cdsNFS.FieldByName('DISCRI').AsString := NoInfNfse.ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
  cdsNFS.FieldByName('CODMUN').AsString := NoInfNfse.ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('CDCNAE').AsString := NoInfNfse.ChildNodes['Servico'].ChildNodes['CodigoCnae'].Text;
  //Prestador

  cdsNFS.FieldByName('PSVCNPJ').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['Cnpj'].Text;
  cdsNFS.FieldByName('PSVIM').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
  cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
  cdsNFS.FieldByName('PSVEND').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
  cdsNFS.FieldByName('PSVNUM').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('PSVBAIR').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
  cdsNFS.FieldByName('PSVMUN').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('PSVUF').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
  cdsNFS.FieldByName('PSVCEP').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
  cdsNFS.FieldByName('PSVFONE').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
  cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;
  cdsNFS.FieldByName('PSVFANT').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia'].Text;

  //Tomador

  cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                            NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                            NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);
  cdsNFS.FieldByName('TMSRAZAO').AsString := NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['RazaoSocial'].Text;
  cdsNFS.FieldByName('TMSEND').AsString := NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
  cdsNFS.FieldByName('TMSNUM').AsString := NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('TMSBAIR').AsString := NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
  cdsNFS.FieldByName('TMSMUN').AsString := NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('TMSUF').AsString := NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
  cdsNFS.FieldByName('TMSCEP').AsString := NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
  cdsNFS.FieldByName('TMSFONE').AsString := NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
  cdsNFS.FieldByName('TMSEMAIL').AsString := NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;

  cdsNFS.Post;

end;

end.
