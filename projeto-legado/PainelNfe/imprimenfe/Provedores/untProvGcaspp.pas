unit untProvGcaspp;

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
  TProvGcaspp = class
    private
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet;
       strXML: string);
  end;
implementation

{ TProvGcaspp }

class procedure TProvGcaspp.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet;
 strXML: string);
var
  XmlDoc : IXMLDocument;
  XmlNodePrincipal,
  NoInfDeclaracaoPrestacaoServico: IXMLNode;
begin
  XmlDoc := TXMLDocument.Create(Application);

  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;

  XmlNodePrincipal := XmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'];
  NoInfDeclaracaoPrestacaoServico :=  XmlNodePrincipal.ChildNodes['DeclaracaoPrestacaoServico']
                                                      .ChildNodes['InfDeclaracaoPrestacaoServico'];

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('NUMNFS').AsString := fStrZero(cdsNFS.FieldByName('NUMNFS').AsString, 8);

  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('CodigoVerificacao'));
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')), 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),9,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),6,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),1,4);

  cdsNFS.FieldByName('EMIOSN').AsString   := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['OptanteSimplesNacional']);
  cdsNFS.FieldByName('RESPTRIB').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['RegimeEspecialTributacao']);
  cdsNFS.FieldByName('EMIICC').AsString   := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['IncentivoFiscal']);
  cdsNFS.FieldByName('COMPET').AsString   := Copy(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes.FindNode('Competencia')),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes.FindNode('Competencia')),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes.FindNode('Competencia')),1,4);

  cdsNFS.FieldByName('OUTINF').AsString   := StringReplace(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OutrasInformacoes']), '\s\n', ' |', [rfReplaceAll]);
  cdsNFS.FieldByName('ORGMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('ORG_UF').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OrgaoGerador'].ChildNodes['Uf']);

  // RPS
  cdsNFS.FieldByName('NUMRPS').AsString  := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero']);
  cdsNFS.FieldByName('SERRPS').AsString  := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie']);
  cdsNFS.FieldByName('TPORPS').AsString  := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo']);

  //Valores
  cdsNFS.FieldByName('VLRISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['ValorIss']));
  cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo']));
  cdsNFS.FieldByName('ALIISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['Aliquota']));
  cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse']));
  cdsNFS.FieldByName('VLRDED').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes']));

  //Valores Serviço
  cdsNFS.FieldByName('VALINS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['ValorInss']));
  cdsNFS.FieldByName('VLRSER').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos']));
  cdsNFS.FieldByName('ISS_RET').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['IssRetido']);
  cdsNFS.FieldByName('DESCONC').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['DescontoIncondicionado']));
  cdsNFS.FieldByName('DESCONI').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['DescontoCondicionado']));
  cdsNFS.FieldByName('VALPIS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis']));
  cdsNFS.FieldByName('VALCOF').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins']));
  cdsNFS.FieldByName('VALIRR').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr']));
  cdsNFS.FieldByName('VALCSL').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll']));
  cdsNFS.FieldByName('OUT_RET').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['OutrasRetencoes']));

  //Informações de Serviço
  cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoTributacaoMunicipio']);
  cdsNFS.FieldByName('CDCNAE').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoCnae']);
  cdsNFS.FieldByName('DISCRI').AsString := StringReplace(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Discriminacao']), 'n', sLineBreak, [rfReplaceAll]);
  cdsNFS.FieldByName('CODMUN').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('EXIISS').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['ExigibilidadeISS']);
  cdsNFS.FieldByName('MUNINC').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['MunicipioIncidencia']);
  cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['ItemListaServico']);

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Prestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj']);
  cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Prestador'].ChildNodes['InscricaoMunicipal']);
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial']);
  cdsNFS.FieldByName('PSVFANT').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia']);
  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['EnderecoPrestadorServico'].ChildNodes['Endereco']);
  cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['EnderecoPrestadorServico'].ChildNodes['Numero']);
  cdsNFS.FieldByName('PSVCOMPL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['EnderecoPrestadorServico'].ChildNodes['Complemento']);
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['EnderecoPrestadorServico'].ChildNodes['Bairro']);
  cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['EnderecoPrestadorServico'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['EnderecoPrestadorServico'].ChildNodes['Uf']);
  cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['EnderecoPrestadorServico'].ChildNodes['Cep']);
  cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['EnderecoPrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone']);
  cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['EnderecoPrestadorServico'].ChildNodes['Contato'].ChildNodes['Email']);

  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'])),
                                                          fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf']),
                                                          fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj']));

  cdsNFS.FieldByName('TMSIM').AsString   := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['InscricaoMunicipal']);

  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['RazaoSocial']);
  cdsNFS.FieldByName('TMSFANTA').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['NomeFantasia']);
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Endereco']);
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Numero']);
  cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Complemento']);
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Bairro']);
  cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Uf']);
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Cep']);
  cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Telefone']);
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Email']);

  cdsNFS.Post;

end;

end.
