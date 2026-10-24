unit untProvGovBrISS;

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
  TProvGovBrISS = class
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
  end;

type
  TProvGovBrISSReforma = class
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
  end;

implementation

{ TProvGovBrISS }

class procedure TProvGovBrISS.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet;
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

  XmlNodePrincipal := XmlDoc.ChildNodes['Nfse']
                            .ChildNodes['InfNfse'];

  XmlNodeInfDecPresServ := XmlNodePrincipal.ChildNodes['DeclaracaoPrestacaoServico']
                                           .ChildNodes['InfDeclaracaoPrestacaoServico'];

  XmlNodeInfDecPresServServ := XmlNodeInfDecPresServ.ChildNodes['Servico'];
  XmlNodeDecPresServValServ := XmlNodeInfDecPresServServ.ChildNodes['Valores'];

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('CodigoVerificacao'));
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')), 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),9,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),6,2)+'/'+
                                           Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('DataEmissao')),1,4);

  cdsNFS.FieldByName('NUMRPS').AsString := XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('SERRPS').AsString := XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
  cdsNFS.FieldByName('TPORPS').AsString := XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;
  cdsNFS.FieldByName('EMIRPS').AsString := Copy(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                           Copy(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                           Copy(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,1,4)+' '+
                                           Copy(XmlNodeInfDecPresServ.ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,12,8);

  cdsNFS.FieldByName('EMIOSN').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['OptanteSimplesNacional']);
  cdsNFS.FieldByName('RESPTRIB').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['RegimeEspecialTributacao']);
  cdsNFS.FieldByName('EMIICC').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['IncentivoFiscal']);
  cdsNFS.FieldByName('COMPET').AsString   := Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes.FindNode('Competencia')),1,4);

  cdsNFS.FieldByName('OUTINF').AsString   := StringReplace(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OutrasInformacoes']), '\s\n', ' |', [rfReplaceAll]);
  cdsNFS.FieldByName('OUTINF').AsString   := StringReplace(cdsNFS.FieldByName('OUTINF').AsString, '\n', sLineBreak, [rfReplaceAll]);
  cdsNFS.FieldByName('ORGMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('ORG_UF').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['OrgaoGerador'].ChildNodes['Uf']);

  //Valores
  cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo']));
  cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse']));
  cdsNFS.FieldByName('VLRDED').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorDeducoes']));

  //Valores Serviço
  cdsNFS.FieldByName('VALINS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorInss']));
  cdsNFS.FieldByName('VLRSER').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDecPresServValServ.ChildNodes['ValorServicos']));
  cdsNFS.FieldByName('ISS_RET').AsString := iif(XmlNodeInfDecPresServServ.ChildNodes['IssRetido'].Text = '0.00', '', fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['IssRetido']));
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
  cdsNFS.FieldByName('DESSER').AsString := fRetDescClassificacaoServico(fStrZero(AnsiReplaceStr(cdsNFS.FieldByName('CODSER').AsString, '.', ''),4));

  cdsNFS.FieldByName('CDCNAE').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['CodigoCnae']);
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := StringReplace(fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['Discriminacao']), '\s\n', ' |', [rfReplaceAll]);
  cdsNFS.FieldByName('DISCRI').AsString := StringReplace(cdsNFS.FieldByName('DISCRI').AsString, 'nn-.', sLineBreak, [rfReplaceAll]);

  cdsNFS.FieldByName('CODMUN').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('EXIISS').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServServ.ChildNodes['ExigibilidadeISS']);
  cdsNFS.FieldByName('MUNINC').AsString := '';


  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Prestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj']);
  cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Prestador'].ChildNodes['InscricaoMunicipal']);
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial']);
  cdsNFS.FieldByName('PSVFANT').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia']);
  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco']);
  cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero']);
  cdsNFS.FieldByName('PSVCOMPL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento']);
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro']);
  cdsNFS.FieldByName('PSVMUN').AsString   := '';
  cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf']);
  cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep']);
  cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone']);
  cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email']);

  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString := IIF(fEmptyStr(fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'])),
                                                          fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf']),
                                                          fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj']));

  cdsNFS.FieldByName('TMSIM').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['InscricaoMunicipal']);

  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['RazaoSocial']);
  cdsNFS.FieldByName('TMSFANTA').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['RazaoSocial']);
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Endereco']);
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Numero']);
  cdsNFS.FieldByName('TMSCOMPL').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Complemento']);
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Bairro']);
  cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Uf']);
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Cep']);
  cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Telefone']);
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodeInfDecPresServ.ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Email']);

  cdsNFS.Post;
end;

{ TProvGovBrISSReforma }

class procedure TProvGovBrISSReforma.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet;
  strXML: string);
var
  XmlDoc : IXMLDocument;
  XmlNodePrincipal : IXMLNode;
  XmlNodePrestador : IXMLNode;
  XmlNodeDPS : IXMLNode;
  XmlNodeTomador : IXMLNode;
  blnPortalNacional : Boolean;
  XmlNodeRegTrib : IXMLNode;
  XmlNodeVTotTrib : IXMLNode;
  LUF: String;
begin
  xmlDoc := TXMLDocument.Create(Application);
  xmlDoc.LoadFromXML(strXML);
  xmlDoc.Active := True;
  blnPortalNacional := True;
  if (POS('http://www.sped.fazenda.gov.br/nfse', strXML) = 0) then
  begin
    XmlNodePrincipal := XmlDoc.ChildNodes['Nfse'].ChildNodes['infNFSe'];
    blnPortalNacional := False;
  end
  else
    XmlNodePrincipal := XmlDoc.ChildNodes['NFSe'].ChildNodes['infNFSe'];
  XmlNodePrestador := XmlNodePrincipal.ChildNodes['emit'];
  XmlNodeDPS := XmlNodePrincipal.ChildNodes['DPS']
                                    .ChildNodes['infDPS'];
  XmlNodeTomador := XmlNodeDPS.ChildNodes['toma'];

  cdsNFS.Append;
  try
    // Dados da NFS
    if blnPortalNacional then
      cdsNFS.FieldByName('ChaveNFSeNacional').AsString := Copy(XmlNodePrincipal.XML, 61, 50)
    else
      cdsNFS.FieldByName('ChaveNFSeNacional').AsString := Copy(XmlNodePrincipal.XML, 59, 50);
    cdsNFS.FieldByName('CODNBS').AsString  := fRetornaValorTagXml(XmlNodeDPS.ChildNodes['serv'].ChildNodes['cServ'].ChildNodes.FindNode('cNBS'));
    cdsNFS.FieldByName('CDTRNAC').AsString := fRetornaValorTagXml(XmlNodeDPS.ChildNodes['serv'].ChildNodes['cServ'].ChildNodes.FindNode('cTribNac'));
    cdsNFS.FieldByName('cIntContrib').AsString := fRetornaValorTagXml(XmlNodeDPS.ChildNodes['serv'].ChildNodes['cServ'].ChildNodes.FindNode('cIntContrib'));
    cdsNFS.FieldByName('DSTRMUN').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('xTribMun') );
    cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('nNFSe'));
    cdsNFS.FieldByName('CODVER').AsString := '';

    if Assigned(XmlNodeDPS.ChildNodes.FindNode('dhEmi')) then
    begin
      cdsNFS.FieldByName('DTAHRA').AsString := Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dhEmi')), 12, 8);
      cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dhEmi')),9,2)+'/'+
                                               Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dhEmi')),6,2)+'/'+
                                               Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dhEmi')),1,4);
    end
    else if Assigned(XmlNodePrincipal.ChildNodes.FindNode('dhProc')) then
    begin
      cdsNFS.FieldByName('DTAHRA').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('dhProc')), 12, 8);
      cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('dhProc')),9,2)+'/'+
                                               Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('dhProc')),6,2)+'/'+
                                               Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('dhProc')),1,4);
    end;

    cdsNFS.FieldByName('INFCPL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('xOutInf'));
    cdsNFS.FieldByName('NUMRPS').AsString := fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('nDPS'));
    cdsNFS.FieldByName('SERRPS').AsString := fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('serie'));
    cdsNFS.FieldByName('TPORPS').AsString := '';
    cdsNFS.FieldByName('EMIRPS').AsString := Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dhEmi')),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dhEmi')),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dhEmi')),1,4)+' '+
                                             Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dhEmi')), 12, 8);
    cdsNFS.FieldByName('NUMDPS').AsString := fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('nDPS'));
    cdsNFS.FieldByName('SERDPS').AsString := fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('serie'));
    cdsNFS.FieldByName('DTADPS').AsString := Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dhEmi')),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dhEmi')),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dhEmi')),1,4);
    cdsNFS.FieldByName('HRADPS').AsString := Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dhEmi')),12,8);

    cdsNFS.FieldByName('EMIOSN').AsString   := fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('opSimpNac'));
    cdsNFS.FieldByName('RESPTRIB').AsString := fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('regEspTrib'));
    cdsNFS.FieldByName('EMIICC').AsString   := '';
    cdsNFS.FieldByName('COMPET').AsString   := Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dCompet')),9,2)+'/'+
                                               Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dCompet')),6,2)+'/'+
                                               Copy(fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('dCompet')),1,4);

    cdsNFS.FieldByName('OUTINF').AsString   := fRetornaValorTagXml(XmlNodeDPS.ChildNodes.FindNode('xInfComp'));
    cdsNFS.FieldByName('ORGMUN').AsString   := '';
    cdsNFS.FieldByName('ORG_UF').AsString   := '';

    //Valores
    cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valores'].ChildNodes.FindNode('vBC')));
    cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valores'].ChildNodes.FindNode('vLiq')));
    cdsNFS.FieldByName('VLRDED').AsFloat  := 0;

    //Valores Serviço
    cdsNFS.FieldByName('VALINS').AsFloat   := 0;
    cdsNFS.FieldByName('VLRSER').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodeDPS.ChildNodes['valores'].ChildNodes['vServPrest'].ChildNodes.FindNode('vServ')));
    if blnPortalNacional then
      cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(fRetornaValorTagXml(XmlNodeDPS.ChildNodes['valores'].ChildNodes['trib'].ChildNodes['tribMun'].ChildNodes.FindNode('tpRetISSQN')), 0)
    else
      cdsNFS.FieldByName('ISSRETIDO').AsString := fRetornaValorTagXml(XmlNodeDPS.ChildNodes['valores'].ChildNodes['trib'].ChildNodes['tribMun'].ChildNodes.FindNode('tpRetISSQN'));
    cdsNFS.FieldByName('CDISSQN').AsString := fRetornaValorTagXml(XmlNodeDPS.ChildNodes['valores'].ChildNodes['trib'].ChildNodes['tribMun'].ChildNodes.FindNode('tribISSQN'));
    cdsNFS.FieldByName('DESCONC').AsFloat  := 0;
    cdsNFS.FieldByName('DESCONI').AsFloat  := 0;
    cdsNFS.FieldByName('VALPIS').AsFloat   := 0;
    cdsNFS.FieldByName('VALCOF').AsFloat   := 0;
    cdsNFS.FieldByName('VALIRR').AsFloat   := 0;
    cdsNFS.FieldByName('VALCSL').AsFloat   := 0;
    cdsNFS.FieldByName('OUT_RET').AsFloat  := 0;

    cdsNFS.FieldByName('VLRISS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valores'].ChildNodes.FindNode('vISSQN')));
    cdsNFS.FieldByName('ALIISS').AsFloat   := fStrToFloatDef(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valores'].ChildNodes.FindNode('pAliqAplic')));

    XmlNodeVTotTrib := nil;
    if Assigned(XmlNodeDPS.ChildNodes['valores'].ChildNodes['trib'].ChildNodes.FindNode('totTrib')) then
      XmlNodeVTotTrib := XmlNodeDPS.ChildNodes['valores'].ChildNodes['trib'].ChildNodes['totTrib'].ChildNodes.FindNode('vTotTrib');

    if Assigned(XmlNodeVTotTrib) then
    begin
      cdsNFS.FieldByName('VLTFED').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeVTotTrib.ChildNodes.FindNode('vTotTribFed')),'.',','), 0);
      cdsNFS.FieldByName('VLTEST').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeVTotTrib.ChildNodes.FindNode('vTotTribEst')),'.',','), 0);
      cdsNFS.FieldByName('VLTMUN').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeVTotTrib.ChildNodes.FindNode('vTotTribMun')),'.',','), 0);
    end;

    //Informações de Serviço
    cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(XmlNodeDPS.ChildNodes['serv'].ChildNodes['cServ'].ChildNodes.FindNode('cTribNac'));
    cdsNFS.FieldByName('DESSER').AsString := fRetDescClassificacaoServico(fStrZero(AnsiReplaceStr(cdsNFS.FieldByName('CODSER').AsString, '.', ''),4));

    cdsNFS.FieldByName('CDCNAE').AsString := '';
    cdsNFS.FieldByName('CODTRI').AsString := '';
    cdsNFS.FieldByName('DISCRI').AsString := fRetornaValorTagXml(XmlNodeDPS.ChildNodes['serv'].ChildNodes['cServ'].ChildNodes.FindNode('xDescServ'));
    cdsNFS.FieldByName('CODMUN').AsString := '';
    cdsNFS.FieldByName('EXIISS').AsString := '';
    cdsNFS.FieldByName('MUNINC').AsString := '';

    //Prestador
    cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('CNPJ'));
    cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('IM'));
    cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('xNome'));
    cdsNFS.FieldByName('PSVFANT').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('xNome'));
    cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['enderNac'].ChildNodes.FindNode('xLgr'));
    cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['enderNac'].ChildNodes.FindNode('nro'));
    cdsNFS.FieldByName('PSVCOMPL').AsString := '';
    cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['enderNac'].ChildNodes.FindNode('xBairro'));
    cdsNFS.FieldByName('PSVMUN').AsString   := '';
    cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['enderNac'].ChildNodes.FindNode('UF'));
    cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['enderNac'].ChildNodes.FindNode('CEP'));
    cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('fone'));
    cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodePrestador.ChildNodes.FindNode('email'));
    cdsNFS.FieldByName('PSVIBGE').AsString  := fRetornaValorTagXml(XmlNodePrestador.ChildNodes['enderNac'].ChildNodes.FindNode('cMun'));

    XmlNodeRegTrib := nil;
    if Assigned(XmlNodeDPS.ChildNodes.FindNode('prest')) then
      XmlNodeRegTrib := XmlNodeDPS.ChildNodes['prest'].ChildNodes.FindNode('regTrib');

    if Assigned(XmlNodeRegTrib) then
    begin
      cdsNFS.FieldByName('PSVOSN').AsString := fRetornaValorTagXml(XmlNodeRegTrib.ChildNodes.FindNode('opSimpNac'));
      cdsNFS.FieldByName('PSVREG').AsString := fRetornaValorTagXml(XmlNodeRegTrib.ChildNodes.FindNode('regApTribSN'));
      cdsNFS.FieldByName('REGESP').AsString := fRetornaValorTagXml(XmlNodeRegTrib.ChildNodes.FindNode('regEspTrib'));
    end;

    //Tomador
    cdsNFS.FieldByName('TMSCNPJ').AsString := IIF(fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('CNPJ'))='',
                                                  fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('CPF')),
                                                  fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('CNPJ')));
    cdsNFS.FieldByName('TMSIM').AsString   := '';
    cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('xNome'));
    cdsNFS.FieldByName('TMSFANTA').AsString := fRetornaValorTagXml(XmlNodeTomador.ChildNodes.FindNode('xNome'));
    cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['end'].ChildNodes.FindNode('xLgr'));
    cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['end'].ChildNodes.FindNode('nro'));
    cdsNFS.FieldByName('TMSCOMPL').AsString := '';
    cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['end'].ChildNodes.FindNode('xBairro'));
    cdsNFS.FieldByName('TMSMUN').AsString   := '';
    cdsNFS.FieldByName('TMSUF').AsString    := '';
    cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['end'].ChildNodes['endNac'].ChildNodes.FindNode('CEP'));
    cdsNFS.FieldByName('TMSFONE').AsString  := '';
    cdsNFS.FieldByName('TMSEMAIL').AsString := '';
    cdsNFS.FieldByName('TMSIBGE').AsString  := fRetornaValorTagXml(XmlNodeTomador.ChildNodes['end'].ChildNodes['endNac'].ChildNodes.FindNode('cMun'));

    if Assigned(XmlNodePrincipal.ChildNodes.FindNode('xLocPrestacao'))
       and Assigned(XmlNodeDPS.ChildNodes['serv'].ChildNodes['locPrest'].ChildNodes.FindNode('cLocPrestacao')) then
      LUF := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_NOMCID', 'CID_COIBGE'],
               [fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('xLocPrestacao')),
                fRetornaValorTagXml(XmlNodeDPS.ChildNodes['serv'].ChildNodes['locPrest'].ChildNodes.FindNode('cLocPrestacao'))])
    else
      LUF := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_NOMCID'],
               [fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('xLocPrestacao'))]);

    cdsNFS.FieldByName('LOCPRE').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('xLocPrestacao'))+
                                             IfThen(not VarIsNull(LUF) and (VarToStr(LUF) <> ''), '-' + VarToStr(LUF), '');

    cdsNFS.Post;
  except
    cdsNFS.Cancel;
    raise;
  end;

end;

end.
