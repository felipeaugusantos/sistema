unit untProvGissOnline;

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
  TProvGissOnline = class

    private
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string);
    end;

implementation

class procedure TProvGissOnline.pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string);

var
  xmlDoc: TXMLDocument;
  XmlNodeInfNfse: IXMLNode;
  XMLInfDeclaracaoPrestacaoServico: IXMLNode;
  XMLPrestadorServico: IXMLNode;
  XMLTomadorServico:  IXMLNode;
  XMLValores: IXMLNode;
  XMLItensServicos: IXMLNode;
  XMLIBSCBS: IXMLNode;
  XMLtrib: IXMLNode;
begin

  xmlDoc := TXMLDocument.Create(Application);

  try

    xmlDoc.LoadFromXML(strXML);
    xmlDoc.Active := True;

    XmlNodeInfNfse                   := XmlDoc.ChildNodes['Nfse']
                                              .ChildNodes['InfNfse'];
    XMLInfDeclaracaoPrestacaoServico := XmlNodeInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].
                                                       ChildNodes['InfDeclaracaoPrestacaoServico'];
    XMLPrestadorServico              := XmlNodeInfNfse.ChildNodes['PrestadorServico'];
    XMLTomadorServico                := XmlNodeInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].
                                                       ChildNodes['InfDeclaracaoPrestacaoServico'].
                                                       ChildNodes['TomadorServico'];
    XMLValores                       := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico']
                                                                        .ChildNodes['Valores'];
    XMLItensServicos                 := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico']
                                                                        .ChildNodes['ListaItensServico']
                                                                        .ChildNodes['ItemServico'];
    XMLIBSCBS                        := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico']
                                                                        .ChildNodes['Valores']
                                                                        .ChildNodes['IBSCBS'];
    XMLtrib                          := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico']
                                                                        .ChildNodes['Valores']
                                                                        .ChildNodes['trib'];

    cdsNFS.Append;

    cdsNFS.FieldByName('NUMNFS').AsString := XmlNodeInfNfse.ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('SERIE').AsString  := 'NFS';
    cdsNFS.FieldByName('CODVER').AsString := XmlNodeInfNfse.ChildNodes['CodigoVerificacao'].Text;
    cdsNFS.FieldByName('DTAHRA').AsString := Copy(XmlNodeInfNfse.ChildNodes['DataEmissao'].Text, 12, 8);
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(XmlNodeInfNfse.ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(XmlNodeInfNfse.ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(XmlNodeInfNfse.ChildNodes['DataEmissao'].Text,1,4);
    cdsNFS.FieldByName('COMPET').AsString := Copy(XMLInfDeclaracaoPrestacaoServico.ChildNodes['Competencia'].Text,6,2)+'/'+
                                             Copy(XMLInfDeclaracaoPrestacaoServico.ChildNodes['Competencia'].Text,1,4);
    cdsNFS.FieldByName('NUMRPS').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('SERRPS').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
    cdsNFS.FieldByName('TPORPS').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;
    cdsNFS.FieldByName('EMIRPS').AsString := Copy(XMLInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(XMLInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(XMLInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,1,4)+' '+
                                             Copy(XMLInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,12,8);
    cdsNFS.FieldByName('NATOPE').AsString := '';
    cdsNFS.FieldByName('CODRET').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['RegimeEspecialTributacao'].Text;
    cdsNFS.FieldByName('EMIOSN').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['OptanteSimplesNacional'].Text;
    cdsNFS.FieldByName('EMIICC').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['IncentivoFiscal'].Text;
    cdsNFS.FieldByName('NFSSUB').AsString := '';
    cdsNFS.FieldByName('OUTINF').AsString := '';
    cdsNFS.FieldByName('CODSER').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text + ' / ' +
                                             XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoTributacaoMunicipio'].Text + ' / ' +
                                             XmlNodeInfNfse.ChildNodes['DescricaoCodigoTributacaoMunicipio'].Text;
    cdsNFS.FieldByName('CDCNAE').AsString := '';
    cdsNFS.FieldByName('CODTRI').AsString := XmlNodeInfNfse.ChildNodes['DescricaoCodigoTributacaoMunicipio'].Text;
    cdsNFS.FieldByName('EXIISS').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['ExigibilidadeISS'].Text;
    cdsNFS.FieldByName('DISCRI').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
    cdsNFS.FieldByName('MUNPRE').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('VLRSER').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRDED').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorDeducoes'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRPIS').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorPis'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRCOF').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorCofins'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRINS').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorInss'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRIR_').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorIr'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRCSL').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorCsll'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRCPP').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorCpp'].Text,'.',','), 0);
    cdsNFS.FieldByName('RETPIS').AsString := '0,00';
    cdsNFS.FieldByName('RETCFS').AsString := '0,00';
    cdsNFS.FieldByName('RETINS').AsString := '0,00';
    cdsNFS.FieldByName('RETIR_').AsString := '0,00';
    cdsNFS.FieldByName('RETCSL').AsString := '0,00';
    cdsNFS.FieldByName('RETCPP').AsString := '0,00';
    cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['IssRetido'].Text,'.',','), 0);
    if XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text = '3518800' then  // Guarulhos
      cdsNFS.FieldByName('MUNINC').AsString := ''
    else
      cdsNFS.FieldByName('MUNINC').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['MunicipioIncidencia'].Text;
    cdsNFS.FieldByName('OUT_RET').AsFloat := 0;
    cdsNFS.FieldByName('BSCISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(XmlNodeInfNfse.ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(XmlNodeInfNfse.ChildNodes['ValoresNfse'].ChildNodes['Aliquota'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat  := StrToFloatDef(AnsiReplaceStr(XmlNodeInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(XmlNodeInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorIss'].Text,'.',','), 0);
    cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['DescontoCondicionado'].Text,'.',','), 0);
    cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['DescontoIncondicionado'].Text,'.',','), 0);
    cdsNFS.FieldByName('PSVCNPJ').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Prestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
    cdsNFS.FieldByName('PSVIM').AsString   := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Prestador'].ChildNodes['InscricaoMunicipal'].Text;
    cdsNFS.FieldByName('IEPRES').AsString  := '';
    cdsNFS.FieldByName('PSVRAZAO').AsString := XMLPrestadorServico.ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('PSVFANT').AsString  := XMLPrestadorServico.ChildNodes['NomeFantasia'].Text;
    cdsNFS.FieldByName('PSVEND').AsString   := XMLPrestadorServico.ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('PSVNUM').AsString   := XMLPrestadorServico.ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('PSVCOMPL').AsString := XMLPrestadorServico.ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
    cdsNFS.FieldByName('PSVBAIR').AsString  := XMLPrestadorServico.ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('PSVMUN').AsString   := XMLPrestadorServico.ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('PSVUF').AsString    := XMLPrestadorServico.ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('PSVCEP').AsString   := XMLPrestadorServico.ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('PSVFONE').AsString  := XMLPrestadorServico.ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('PSVEMAIL').AsString := XMLPrestadorServico.ChildNodes['Contato'].ChildNodes['Email'].Text;
    cdsNFS.FieldByName('TMSCNPJ').AsString  := Iif(fEmptyStr(XMLTomadorServico.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text),
                                                             XMLTomadorServico.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text,
                                                             XMLTomadorServico.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text);
    cdsNFS.FieldByName('TMSRAZAO').AsString := XMLTomadorServico.ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('TMSIM').AsString    := '';
    cdsNFS.FieldByName('TMSEND').AsString   := XMLTomadorServico.ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('TMSNUM').AsString   := XMLTomadorServico.ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('TMSCOMPL').AsString := XMLTomadorServico.ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
    cdsNFS.FieldByName('TMSBAIR').AsString  := XMLTomadorServico.ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('TMSMUN').AsString   := XMLTomadorServico.ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('TMSUF').AsString    := XMLTomadorServico.ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('TMSCEP').AsString   := XMLTomadorServico.ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('TMSFONE').AsString  := XMLTomadorServico.ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('TMSEMAIL').AsString := XMLTomadorServico.ChildNodes['Contato'].ChildNodes['Email'].Text;
    cdsNFS.FieldByName('ORGMUN').AsString   := XmlNodeInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('ORG_UF').AsString   := XmlNodeInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('RESPTRIB').AsString := 'P';
    cdsNFS.FieldByName('OBSERV').AsString   := '';

    cdsNFS.FieldByName('CODNBS').AsString := fRetornaValorTagXml(XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes.FindNode('CodigoNbs'));
    if Assigned(XMLIBSCBS) then
    begin
      cdsNFS.FieldByName('IBSCBS_cIndOp').AsString := fRetornaValorTagXml(XMLIBSCBS.ChildNodes.FindNode('cIndOp'));
      cdsNFS.FieldByName('gIBSCBS_CST').AsString := fRetornaValorTagXml(XMLIBSCBS.ChildNodes['valores'].ChildNodes['trib'].ChildNodes['gIBSCBS'].ChildNodes.FindNode('CST'));
      cdsNFS.FieldByName('gIBSCBS_cClassTrib').AsString := fRetornaValorTagXml(XMLIBSCBS.ChildNodes['valores'].ChildNodes['trib'].ChildNodes['gIBSCBS'].ChildNodes.FindNode('cClassTrib'));
    end;

    if Assigned(XMLtrib) then
    begin
      cdsNFS.FieldByName('pTotTribFed').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XMLtrib.ChildNodes['totTrib'].ChildNodes['pTotTrib'].ChildNodes.FindNode('pTotTribFed')),'.',','), 0);
      cdsNFS.FieldByName('pTotTribEst').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XMLtrib.ChildNodes['totTrib'].ChildNodes['pTotTrib'].ChildNodes.FindNode('pTotTribEst')),'.',','), 0);
      cdsNFS.FieldByName('pTotTribMun').AsFloat := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XMLtrib.ChildNodes['totTrib'].ChildNodes['pTotTrib'].ChildNodes.FindNode('pTotTribMun')),'.',','), 0);
    end;

    // CONSTRUÇÃO CIVIL
    if Assigned(XMLInfDeclaracaoPrestacaoServico.ChildNodes.FindNode('ConstrucaoCivil')) then
    begin
      cdsNFS.FieldByName('CODOBR').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['ConstrucaoCivil'].ChildNodes['CodigoObra'].Text;
      // GissOnline/Santos não expõe tag <Art> — usa CodigoObra em ambos os campos
      cdsNFS.FieldByName('CODART').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['ConstrucaoCivil'].ChildNodes['CodigoObra'].Text;
    end;

    cdsNFS.Post;

  finally
      FreeAndNil(xmlDoc);
  end;
end;

end.
