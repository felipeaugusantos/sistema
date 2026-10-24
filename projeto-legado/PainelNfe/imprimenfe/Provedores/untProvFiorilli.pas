unit untProvFiorilli;

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
  TProvFiorilli = class
    private
      class procedure pCarregaNoPrincipal( strXML : string; var varXmlDoc : IXMLDocument; var varNoElmento : IXMLNode );
      class procedure pCarregaNoInfNfse(var varNoElemento: IXMLNode; var varNoInfNfse: IXMLNode  );
      class procedure pCarregaNoDeclaracaoPrestacaoServico(var varNoInfNfse : IXMLNode ; var varNoDeclaracaoPrestacaoServico : IXMLNode );
      class procedure pCarregaNoInfDeclaracaoPrestacaoServico( var varNoDeclaracaoPrestacaoServico : IXMLNode;  var varNoInfDeclaracaoPrestacaoServico : IXMLNode  );
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
  end;

const
  ns2 = 'http://www.abrasf.org.br/nfse.xsd';
implementation

{ TProvFiorilli }

class procedure TProvFiorilli.pCarregaNoPrincipal( strXML : string; var varXmlDoc : IXMLDocument; var varNoElmento : IXMLNode );
begin

  varXmlDoc := TXMLDocument.Create(Application);
  varXmlDoc.LoadFromXML(strXML);
  varXmlDoc.Active := True;

  varNoElmento := varXmlDoc.DocumentElement;

end;

class procedure TProvFiorilli.pCarregaNoInfNfse(var varNoElemento: IXMLNode; var varNoInfNfse: IXMLNode  );
begin
  If not ( varNoElemento = nil ) Then
  Begin
    varNoInfNfse := varNoElemento.ChildNodes.FindNode('InfNfse', ns2);
    varNoInfNfse.ChildNodes.First;
  End;
end;

class procedure TProvFiorilli.pCarregaNoDeclaracaoPrestacaoServico(var varNoInfNfse : IXMLNode ; var varNoDeclaracaoPrestacaoServico : IXMLNode );
begin
  If not ( varNoInfNfse = nil ) Then
  Begin
    varNoDeclaracaoPrestacaoServico := varNoInfNfse.childNodes.FindNode('DeclaracaoPrestacaoServico', ns2);
    varNoDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TProvFiorilli.pCarregaNoInfDeclaracaoPrestacaoServico( var varNoDeclaracaoPrestacaoServico : IXMLNode;  var varNoInfDeclaracaoPrestacaoServico : IXMLNode  );
begin
  If not ( varNoDeclaracaoPrestacaoServico = nil ) Then
  Begin
    varNoInfDeclaracaoPrestacaoServico := varNoDeclaracaoPrestacaoServico.childNodes.FindNode('InfDeclaracaoPrestacaoServico', ns2);
    varNoInfDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TProvFiorilli.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
var
  XmlDoc : IXMLDocument;
  NoElemento,
  NoInfNfse,
  NoDeclaracaoPrestacaoServico,
  NoInfDeclaracaoPrestacaoServico : IXMLNode;
begin

  pCarregaNoPrincipal( strXML,  XmlDoc, NoElemento);
  pCarregaNoInfNfse( NoElemento, NoInfNfse );
  pCarregaNoDeclaracaoPrestacaoServico( NoInfNfse, NoDeclaracaoPrestacaoServico );
  pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico, NoInfDeclaracaoPrestacaoServico );

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes.FindNode('Numero'));
  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes.FindNode('CodigoVerificacao'));
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(fRetornaValorTagXml(NoInfNfse.ChildNodes.FindNode('DataEmissao')), 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(fRetornaValorTagXml(NoInfNfse.ChildNodes.FindNode('DataEmissao')),9,2)+'/'+
                                           Copy(fRetornaValorTagXml(NoInfNfse.ChildNodes.FindNode('DataEmissao')),6,2)+'/'+
                                           Copy(fRetornaValorTagXml(NoInfNfse.ChildNodes.FindNode('DataEmissao')),1,4);

  cdsNFS.FieldByName('EMIOSN').AsString   := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['OptanteSimplesNacional']);
  cdsNFS.FieldByName('RESPTRIB').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['RegimeEspecialTributacao']);
  cdsNFS.FieldByName('EMIICC').AsString   := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['IncentivoFiscal']);
  cdsNFS.FieldByName('COMPET').AsString   := Copy(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes.FindNode('Competencia')),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes.FindNode('Competencia')),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes.FindNode('Competencia')),1,4);

  cdsNFS.FieldByName('OUTINF').AsString   := StringReplace(fRetornaValorTagXml(NoInfNfse.ChildNodes['OutrasInformacoes']), '\s\n', ' |', [rfReplaceAll]);
  cdsNFS.FieldByName('ORGMUN').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('ORG_UF').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['Uf']);

  //Valores
  cdsNFS.FieldByName('VLRISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorIss']),'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo']),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['Aliquota']),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse']),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes']),'.',','), 0);

  //Valores Serviço
  cdsNFS.FieldByName('VALINS').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['ValorInss']),'.',','), 0);
  cdsNFS.FieldByName('VLRSER').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos']),'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['IssRetido']);
  cdsNFS.FieldByName('DESCONC').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['DescontoIncondicionado']),'.',','), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['DescontoCondicionado']),'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis']),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins']),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr']),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll']),'.',','), 0);
  cdsNFS.FieldByName('OUT_RET').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['OutrasRetencoes']),'.',','), 0);

  //Informações de Serviço
  cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoTributacaoMunicipio']);
  cdsNFS.FieldByName('CDCNAE').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoCnae']);
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := StringReplace(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Discriminacao']), '\s\n', ' |', [rfReplaceAll]);
  cdsNFS.FieldByName('CODMUN').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('EXIISS').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['ExigibilidadeISS']);
  cdsNFS.FieldByName('MUNINC').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['MunicipioIncidencia']);
  cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['ItemListaServico']);

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Prestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj']);
  cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Prestador'].ChildNodes['InscricaoMunicipal']);
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial']);
  cdsNFS.FieldByName('PSVFANT').AsString  := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia']);
  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco']);
  cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero']);
  cdsNFS.FieldByName('PSVCOMPL').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento']);
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro']);
  cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf']);
  cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep']);
  cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone']);
  cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email']);

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
