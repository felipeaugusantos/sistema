unit untProvSigCorp;

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
  TProvSigCorp = class
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
  end;

implementation

class procedure TProvSigCorp.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet;
  strXML: string);
var
  XmlDoc : IXMLDocument;

  XmlNodePrincipal,
  XmlNodeInfDecPresServ,
  XmlNodeInfDecPresServServ,
  XmlNodeDecPresServValServ: IXMLNode;

  fltTgVlNfsIss,
  fltTgVlNfsAli: Double;
begin
  xmlDoc := TXMLDocument.Create(Application);

  xmlDoc.LoadFromXML(strXML);
  xmlDoc.Active := True;

  XmlNodePrincipal := XmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'];

  XmlNodeInfDecPresServ := XmlNodePrincipal.ChildNodes['DeclaracaoPrestacaoServico']
                                           .ChildNodes['InfDeclaracaoPrestacaoServico'];

  XmlNodeInfDecPresServServ := XmlNodeInfDecPresServ.ChildNodes['Servico'];
  XmlNodeDecPresServValServ := XmlNodeInfDecPresServServ.ChildNodes['Valores'];

  cdsNFS.Append;
  // Dados da NFS
  try
    cdsNFS.FieldByName('NUMNFS').AsString :=  fPadL(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Numero')), 10, '0');
    cdsNFS.FieldByName('SERNFS').AsString := '1';
    cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('CodigoVerificacao'));
    cdsNFS.FieldByName('DTAHRA').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')), 12, 8);
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),1,4);

    cdsNFS.FieldByName('EMIOSN').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['OptanteSimplesNacional']);
    cdsNFS.FieldByName('RESPTRIB').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['RegimeEspecialTributacao']);
    cdsNFS.FieldByName('EMIICC').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['IncentivoFiscal']);
    cdsNFS.FieldByName('COMPET').AsString   := Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),6,2)+'/'+
                                               Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),1,4);

    cdsNFS.FieldByName('OUTINF').AsString   := StringReplace(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OutrasInformacoes']), '\s\n', ' |', [rfReplaceAll]);
    cdsNFS.FieldByName('ORGMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio']);
    cdsNFS.FieldByName('ORG_UF').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OrgaoGerador'].ChildNodes['Uf']);

    //Valores
    cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo']));
    cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse']));
    cdsNFS.FieldByName('VLRDED').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorDeducoes']));

    //Valores Serviço
    cdsNFS.FieldByName('VALINS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorInss']));
    cdsNFS.FieldByName('VLRSER').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorServicos']));
    cdsNFS.FieldByName('ISS_RET').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['IssRetido']);
    cdsNFS.FieldByName('DESCONC').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['DescontoCondicionado']));
    cdsNFS.FieldByName('DESCONI').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['DescontoIncondicionado']));
    cdsNFS.FieldByName('VALPIS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorPis']));
    cdsNFS.FieldByName('VALCOF').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorCofins']));
    cdsNFS.FieldByName('VALIRR').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorIr']));
    cdsNFS.FieldByName('VALCSL').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorCsll']));
    cdsNFS.FieldByName('OUT_RET').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['OutrasRetencoes']));

    fltTgVlNfsIss := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['ValorIss']));
    fltTgVlNfsAli := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['Aliquota']));
    cdsNFS.FieldByName('VLRISS').AsFloat   := IIF(fltTgVlNfsIss = 00.00,
                                                 fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorIss'])),
                                                 fltTgVlNfsIss);

    cdsNFS.FieldByName('ALIISS').AsFloat   := IIF(fltTgVlNfsAli = 00.00,
                                                 fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['Aliquota'])),
                                                 fltTgVlNfsAli);
    //Informações de Serviço
    cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['ItemListaServico']);
    cdsNFS.FieldByName('CDCNAE').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['CodigoCnae']);
    cdsNFS.FieldByName('CODTRI').AsString := '';
    cdsNFS.FieldByName('DISCRI').AsString := StringReplace(fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['Discriminacao']), '\s\n', ' |', [rfReplaceAll]);
    cdsNFS.FieldByName('CODMUN').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['CodigoMunicipio']);
    cdsNFS.FieldByName('EXIISS').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['ExigibilidadeISS']);
    cdsNFS.FieldByName('MUNINC').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['MunicipioIncidencia']);
    cdsNFS.FieldByName('NATOPE').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['OptanteSimplesNacional']);

    //Prestador
    cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Prestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj']);
    cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Prestador'].ChildNodes['InscricaoMunicipal']);
    cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial']);
    cdsNFS.FieldByName('PSVFANT').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia']);
    cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco']);
    cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero']);
    cdsNFS.FieldByName('PSVCOMPL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento']);
    cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro']);
    cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio']);
    cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf']);
    cdsNFS.FieldByName('PSVCEP').AsString   := fFormataCEP(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep']));
    cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone']);
    cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email']);

    //Tomador
    cdsNFS.FieldByName('TMSCNPJ').AsString := IIF(fEmptyStr(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'])),
                                                            fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf']),
                                                            fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj']));

    cdsNFS.FieldByName('TMSIM').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['InscricaoMunicipal']);

    cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['RazaoSocial']);
    cdsNFS.FieldByName('TMSFANTA').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['NomeFantasia']);
    cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco']);
    cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Numero']);
    cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento']);
    cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro']);
    cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio']);
    cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Uf']);
    cdsNFS.FieldByName('TMSCEP').AsString   := fFormataCEP(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cep']));
    cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Telefone']);
    cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Email']);


    // RPS
    cdsNFS.FieldByName('NUMRPS').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero']);
    cdsNFS.FieldByName('SERRPS').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie']);
    cdsNFS.FieldByName('TPORPS').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo']);

    cdsNFS.FieldByName('EMIRPS').AsString  := Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['DataEmissao']),9,2)+'/'+
                                              Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['DataEmissao']),6,2)+'/'+
                                              Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['DataEmissao']),1,4);

    cdsNFS.FieldByName('ChaveNFSeNacional').asString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('ChaveAcesso'));
    cdsNFS.FieldByName('_LINK_').asString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('LinkNota'));
    cdsNFS.Post;
  except
    cdsNFS.Cancel;
    raise;
  end;

end;

end.
