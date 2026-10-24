unit untCampinasXML;

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
  TCampinasXML = class

    private

    public

      class procedure pRetornaCDSPreenchido(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string);

  end;

implementation

{ TCampinasXML }

class procedure TCampinasXML.pRetornaCDSPreenchido(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string);
var
  xmlDoc: TXMLDocument;
  NoPrincipal,
  NoCompl: string;
begin

  xmlDoc := TXMLDocument.Create(Application);
  NoPrincipal := 'ListaNfse';
  NoCompl := 'CompNfse';

  try

    XmlDoc.LoadFromXML(strXML);
    XmlDoc.Active := True;

    cdsNFS.Append;

    cdsNFS.FieldByName('NUMNFS').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('CODVER').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CodigoVerificacao'].Text;
    cdsNFS.FieldByName('ASSPRE').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['AssinaturaPrestadorTomador'].Text;
    cdsNFS.FieldByName('DTAHRA').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text;
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,1,4);

    cdsNFS.FieldByName('NUMRPS').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('SERRPS').AsString := 'E'; //Segundo o Leandro (FIT)... "tem algumas prefeituras que usam fixo... apesar de mandarmos 001 eles usam essa "E" para sair no PDF
    cdsNFS.FieldByName('TPORPS').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;

    cdsNFS.FieldByName('EMIRPS').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissaoRps'].Text;
    cdsNFS.FieldByName('NATOPE').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['NaturezaOperacao'].Text;
    cdsNFS.FieldByName('CODRET').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['RegimeEspecialTributacao'].Text;
    cdsNFS.FieldByName('EMIOSN').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OptanteSimplesNacional'].Text;
    cdsNFS.FieldByName('EMIICC').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IncentivadorCultural'].Text;
    cdsNFS.FieldByName('COMPET').AsString := Copy(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Competencia'].Text,1,10);
    cdsNFS.FieldByName('OUTINF').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OutrasInformacoes'].Text;

    cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['IssRetido'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIss'].Text,'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['Aliquota'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
    cdsNFS.FieldByName('CODSER').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
    cdsNFS.FieldByName('CDCNAE').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['CodigoCnae'].Text;
    cdsNFS.FieldByName('CODTRI').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['CodigoTributacaoMunicipio'].Text;
    cdsNFS.FieldByName('DISCRI').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
    cdsNFS.FieldByName('CODMUN').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('ITEDESC').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItensServico'].ChildNodes['Descricao'].Text;
    cdsNFS.FieldByName('ITEQTD').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItensServico'].ChildNodes['Quantidade'].Text,'.',','), 0);
    cdsNFS.FieldByName('ITEVLU').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItensServico'].ChildNodes['ValorUnitario'].Text,'.',','), 0);

    cdsNFS.FieldByName('PSVCNPJ').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['Cnpj'].Text;

    cdsNFS.FieldByName('PSVIM').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
    cdsNFS.FieldByName('PSVRAZAO').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('PSVFANT').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia'].Text;
    cdsNFS.FieldByName('PSVEND').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('PSVNUM').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('PSVCOMPL').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
    cdsNFS.FieldByName('PSVBAIR').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('PSVMUN').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('PSVUF').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('PSVCEP').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('PSVFONE').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('PSVEMAIL').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;

    cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                            xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                            xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);
    cdsNFS.FieldByName('TMSIM').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['InscricaoMunicipal'].Text;
    cdsNFS.FieldByName('TMSRAZAO').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('TMSEND').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('TMSNUM').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('TMSCOMPL').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
    cdsNFS.FieldByName('TMSBAIR').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('TMSMUN').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('TMSUF').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('TMSCEP').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('TMSFONE').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('TMSEMAIL').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;
    cdsNFS.FieldByName('ORGMUN').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('ORG_UF').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;

    cdsNFS.Post;

    cdsItens.Append;
    cdsItens.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
    cdsItens.FieldByName('ITEDES').AsString := xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItensServico'].ChildNodes['Descricao'].Text;
    cdsItens.FieldByName('ITEQTD').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItensServico'].ChildNodes['Quantidade'].Text,'.',','), 0);
    cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItensServico'].ChildNodes['ValorUnitario'].Text,'.',','), 0);
    cdsItens.FieldByName('VLRTOT').AsFloat  := (StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItensServico'].ChildNodes['ValorUnitario'].Text,'.',','), 0) * StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes[NoPrincipal].ChildNodes['ListaNfse'].ChildNodes[NoCompl].ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItensServico'].ChildNodes['Quantidade'].Text,'.',','), 0));
    cdsItens.Post;

  finally
    FreeAndNil(XmlDoc);
  end;

end;

class procedure TCampinasXML.pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string);
begin

  cdsNFS.Append;

  cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<NumeroNota>', '</NumeroNota>');
  cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>');
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(RetornaTexto(strXML, '<DataProcessamento>', '</DataProcessamento>'), 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(RetornaTexto(strXML, '<DataProcessamento>', '</DataProcessamento>'),9,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataProcessamento>', '</DataProcessamento>'),6,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataProcessamento>', '</DataProcessamento>'),1,4);
  cdsNFS.FieldByName('NUMRPS').AsString := RetornaTexto(strXML, '<NumeroRPS>', '</NumeroRPS>');
  cdsNFS.FieldByName('SERRPS').AsString := RetornaTexto(strXML, '<SeriePrestacao>', '</SeriePrestacao>');
  cdsNFS.FieldByName('TPORPS').AsString := RetornaTexto(strXML, '<TipoRPS>', '</TipoRPS>');
  cdsNFS.FieldByName('EMIRPS').AsString := Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),9,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),6,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),1,4);
  cdsNFS.FieldByName('NATOPE').AsString := '';
  cdsNFS.FieldByName('CODRET').AsString := '';
  cdsNFS.FieldByName('EMIOSN').AsString := '';
  cdsNFS.FieldByName('EMIICC').AsString := '';
  cdsNFS.FieldByName('COMPET').AsString := '';
  cdsNFS.FieldByName('OUTINF').AsString := '';

  cdsNFS.FieldByName('PSVCNPJ').AsString  := '';
  cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(strXML, '<InscricaoMunicipalPrestador>', '</InscricaoMunicipalPrestador>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strXML, '<RazaoSocialPrestador>', '</RazaoSocialPrestador>');
  cdsNFS.FieldByName('PSVFANT').AsString  := '';
  cdsNFS.FieldByName('PSVEND').AsString   := '';
  cdsNFS.FieldByName('PSVNUM').AsString   := '';
  cdsNFS.FieldByName('PSVCOMPL').AsString := '';
  cdsNFS.FieldByName('PSVBAIR').AsString  := '';
  cdsNFS.FieldByName('PSVMUN').AsString   := '';
  cdsNFS.FieldByName('PSVUF').AsString    := '';
  cdsNFS.FieldByName('PSVCEP').AsString   := '';
  cdsNFS.FieldByName('PSVEMAIL').AsString := '';
  cdsNFS.FieldByName('PSVFONE').AsString  := RetornaTexto(strXML, '<DDDPrestador>', '</DDDPrestador>') +
                                             RetornaTexto(strXML, '<TelefonePrestador>', '</TelefonePrestador>');

  cdsNFS.FieldByName('TMSCNPJ').AsString  := RetornaTexto(strXML, '<CPFCNPJTomador>', '</CPFCNPJTomador>');
  cdsNFS.FieldByName('TMSIM').AsString    := RetornaTexto(strXML, '<InscricaoMunicipalTomador >', '</InscricaoMunicipalTomador >');
  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(strXML, '<RazaoSocialTomador>', '</RazaoSocialTomador>');
  cdsNFS.FieldByName('TMSEND').AsString   := RetornaTexto(strXML, '<LogradouroTomador>', '</LogradouroTomador>');
  cdsNFS.FieldByName('TMSNUM').AsString   := RetornaTexto(strXML, '<NumeroEnderecoTomador>', '</NumeroEnderecoTomador>');
  cdsNFS.FieldByName('TMSCOMPL').AsString := RetornaTexto(strXML, '<ComplementoEnderecoTomador >', '</ComplementoEnderecoTomador >');
  cdsNFS.FieldByName('TMSBAIR').AsString  := RetornaTexto(strXML, '<BairroTomador >', '</BairroTomador >');
  cdsNFS.FieldByName('TMSMUN').AsString   := RetornaTexto(strXML, '<CidadeTomadorDescricao>', '</CidadeTomadorDescricao>');
  cdsNFS.FieldByName('TMSUF').AsString    := '';
  cdsNFS.FieldByName('TMSCEP').AsString   := RetornaTexto(strXML, '<CEPTomador>', '</CEPTomador>');
  cdsNFS.FieldByName('TMSFONE').AsString  := '';
  cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(strXML, '<EmailTomador>', '</EmailTomador>');

  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorTotal>', '</ValorTotal>'),'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat   := 0;
  cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorTotal>', '</ValorTotal>'),'.',','), 0) *
                                             (StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AliquotaAtividade>', '</AliquotaAtividade>'),'.',','), 0)/100);
  cdsNFS.FieldByName('BSCISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorTotal>', '</ValorTotal>'),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AliquotaAtividade>', '</AliquotaAtividade>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorTotal>', '</ValorTotal>'),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString   := '1401';
  cdsNFS.FieldByName('CDCNAE').AsString   := '';
  cdsNFS.FieldByName('CNAEFI').AsString   := RetornaTexto(strXML, '<CodigoAtividade>', '</CodigoAtividade>');
  cdsNFS.FieldByName('CODTRI').AsString   := '';
  cdsNFS.FieldByName('DISCRI').AsString   := RetornaTexto(strXML, '<DiscriminacaoServico>', '</DiscriminacaoServico>');
  cdsNFS.FieldByName('CODMUN').AsString   := RetornaTexto(strXML, '<MunicipioPrestacaoDescricao>', '</MunicipioPrestacaoDescricao>');
  cdsNFS.FieldByName('ITEDESC').AsString  := RetornaTexto(strXML, '<DiscriminacaoServico>', '</DiscriminacaoServico>');
  cdsNFS.FieldByName('ITEQTD').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Quantidade>', '</Quantidade>'),'.',','), 0);
  cdsNFS.FieldByName('ITEVLU').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorUnitario>', '</ValorUnitario>'),'.',','), 0);

  cdsNFS.FieldByName('ORGMUN').AsString   := RetornaTexto(strXML, '<MunicipioPrestacaoDescricao>', '</MunicipioPrestacaoDescricao>');
  cdsNFS.FieldByName('ORG_UF').AsString   := 'SP';

  cdsNFS.FieldByName('BCINSS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorTotal>', '</ValorTotal>'),'.',','), 0);
  cdsNFS.FieldByName('ALQINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AliquotaINSS>', '</AliquotaINSS>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorINSS>', '</ValorINSS>'),'.',','), 0);

  cdsNFS.FieldByName('BC_PIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorTotal>', '</ValorTotal>'),'.',','), 0);
  cdsNFS.FieldByName('ALQPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AliquotaPIS>', '</AliquotaPIS>'),'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorPIS>', '</ValorPIS>'),'.',','), 0);

  cdsNFS.FieldByName('BCCOFI').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorTotal>', '</ValorTotal>'),'.',','), 0);
  cdsNFS.FieldByName('ALQCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCOFINS>', '</ValorCOFINS>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AliquotaCOFINS>', '</AliquotaCOFINS>'),'.',','), 0);

  cdsNFS.FieldByName('BCIRRF').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorTotal>', '</ValorTotal>'),'.',','), 0);
  cdsNFS.FieldByName('ALQIRR').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIR>', '</ValorIR>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AliquotaIR>', '</AliquotaIR>'),'.',','), 0);

  cdsNFS.FieldByName('BCCSLL').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorTotal>', '</ValorTotal>'),'.',','), 0);
  cdsNFS.FieldByName('ALQCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCSLL>', '</ValorCSLL>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AliquotaCSLL>', '</AliquotaCSLL>'),'.',','), 0);
  cdsNFS.FieldByName('TIPREC').AsString   := RetornaTexto(strXML, '<TipoRecolhimento>', '</TipoRecolhimento>');

  cdsNFS.Post;

  cdsItens.Append;
  cdsItens.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<NumeroNota>', '</NumeroNota>');
  cdsItens.FieldByName('ITEDES').AsString := '';
  cdsItens.FieldByName('ITEQTD').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Quantidade>', '</Quantidade>'),'.',','), 0);
  cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorUnitario>', '</ValorUnitario>'),'.',','), 0);
  cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorTotal>', '</ValorTotal>'),'.',','), 0);
  cdsItens.Post;

end;

end.
