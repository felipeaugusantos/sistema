unit untSJRioPardoXML;

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
  TSJRioPardoXML = class

    private

    public

      class procedure pCarregaNoPrincipal( strXML : string );
      class procedure pCarregaNoInfNfse( NoElemento: IXMLNode );
      class procedure pCarregaNoDeclaracaoPrestacaoServico( NoInfNfse : IXMLNode );
      class procedure pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico : IXMLNode );
      class procedure pCarregaNoRps( NoInfDeclaracaoPrestacaoServico : IXMLNode );

      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string; strCidadeNFSe: string='');

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

{ TSJRioPardoXML }

class procedure TSJRioPardoXML.pCarregaNoPrincipal( strXML : string );
begin

  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;

  NoElemento := XmlDoc.DocumentElement;

end;

class procedure TSJRioPardoXML.pCarregaNoInfNfse( NoElemento: IXMLNode );
begin
  If not ( NoElemento = nil ) Then
  Begin
    NoInfNfse := NoElemento.childNodes.FindNode('ns2:InfNfse', ns2);
    NoInfNfse.ChildNodes.First;
  End;
end;

class procedure TSJRioPardoXML.pCarregaNoDeclaracaoPrestacaoServico( NoInfNfse: IXMLNode );
begin
  If not ( NoInfNfse = nil ) Then
  Begin
    NoDeclaracaoPrestacaoServico := NoInfNfse.childNodes.FindNode('ns2:DeclaracaoPrestacaoServico', ns2);
    NoDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TSJRioPardoXML.pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico: IXMLNode );
begin
  If not ( NoDeclaracaoPrestacaoServico = nil ) Then
  Begin
    NoInfDeclaracaoPrestacaoServico := NoDeclaracaoPrestacaoServico.childNodes.FindNode('ns2:InfDeclaracaoPrestacaoServico', ns2);
    NoInfDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TSJRioPardoXML.pCarregaNoRps( NoInfDeclaracaoPrestacaoServico: IXMLNode );
begin
  If not ( NoInfDeclaracaoPrestacaoServico = nil ) Then
  Begin
    NoRps := NoInfDeclaracaoPrestacaoServico.childNodes.FindNode('ns2:Rps', ns2);
    NoRps.ChildNodes.First;
  End;
end;

class procedure TSJRioPardoXML.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
begin
  //
end;

class procedure TSJRioPardoXML.pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string; strCidadeNFSe: string='');
begin

  pCarregaNoPrincipal( strXML );
  pCarregaNoInfNfse( NoElemento );
  pCarregaNoDeclaracaoPrestacaoServico( NoInfNfse );
  pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico );
  pCarregaNoRps( NoInfDeclaracaoPrestacaoServico );

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes.FindNode('ns2:Numero').Text;
  cdsNFS.FieldByName('CODVER').AsString := NoInfNfse.ChildNodes.FindNode('ns2:CodigoVerificacao').Text;
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(NoInfNfse.ChildNodes.FindNode('ns2:DataEmissao').Text, 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(NoInfNfse.ChildNodes.FindNode('ns2:DataEmissao').Text,9,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes.FindNode('ns2:DataEmissao').Text,6,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes.FindNode('ns2:DataEmissao').Text,1,4);
  cdsNFS.FieldByName('NUMRPS').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Rps'].ChildNodes['ns2:IdentificacaoRps'].ChildNodes['ns2:Numero'].Text;
  cdsNFS.FieldByName('SERRPS').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Rps'].ChildNodes['ns2:IdentificacaoRps'].ChildNodes['ns2:Serie'].Text;
  cdsNFS.FieldByName('TPORPS').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Rps'].ChildNodes['ns2:IdentificacaoRps'].ChildNodes['ns2:Tipo'].Text;
  cdsNFS.FieldByName('EMIRPS').AsString := Copy(NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Rps'].ChildNodes['ns2:DataEmissao'].Text,9,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Rps'].ChildNodes['ns2:DataEmissao'].Text,6,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Rps'].ChildNodes['ns2:DataEmissao'].Text,1,4);
  cdsNFS.FieldByName('NATOPE').AsString := '';
  cdsNFS.FieldByName('CODRET').AsString := '';
  cdsNFS.FieldByName('EMIOSN').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:OptanteSimplesNacional'].Text;
  cdsNFS.FieldByName('EMIICC').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:IncentivoFiscal'].Text;
  cdsNFS.FieldByName('COMPET').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Competencia'].Text;
  cdsNFS.FieldByName('OUTINF').AsString := '';
  cdsNFS.FieldByName('ORGMUN').AsString := NoInfNfse.ChildNodes['ns2:OrgaoGerador'].ChildNodes['ns2:CodigoMunicipio'].Text;
  cdsNFS.FieldByName('ORG_UF').AsString := NoInfNfse.ChildNodes['ns2:OrgaoGerador'].ChildNodes['ns2:Uf'].Text;
  //Valores
  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Servico'].ChildNodes['ns2:Valores'].ChildNodes['ns2:ValorServicos'].Text,'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Servico'].ChildNodes['ns2:IssRetido'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns2:ValoresNfse'].ChildNodes['ns2:ValorIss'].Text,'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns2:ValoresNfse'].ChildNodes['ns2:BaseCalculo'].Text,'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns2:ValoresNfse'].ChildNodes['ns2:Aliquota'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns2:ValoresNfse'].ChildNodes['ns2:ValorLiquidoNfse'].Text,'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Servico'].ChildNodes['ns2:ItemListaServico'].Text;
  cdsNFS.FieldByName('CDCNAE').AsString := '';
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := AnsiReplaceStr(UpperCase(NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Servico'].ChildNodes['ns2:Discriminacao'].Text), 'nn', '');
  cdsNFS.FieldByName('CODMUN').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Servico'].ChildNodes['ns2:CodigoMunicipio'].Text;
  cdsNFS.FieldByName('ITEDESC').AsString := '';
  cdsNFS.FieldByName('ITEQTD').AsFloat := 0;
  cdsNFS.FieldByName('ITEVLU').AsFloat := 0;
  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString := NoInfNfse.ChildNodes['ns2:PrestadorServico'].ChildNodes['ns2:IdentificacaoPrestador'].ChildNodes['ns2:CpfCnpj'].ChildNodes['ns2:Cnpj'].Text;
  cdsNFS.FieldByName('PSVIM').AsString := NoInfNfse.ChildNodes['ns2:PrestadorServico'].ChildNodes['ns2:IdentificacaoPrestador'].ChildNodes['ns2:InscricaoMunicipal'].Text;
  cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes['ns2:PrestadorServico'].ChildNodes['ns2:RazaoSocial'].Text;
  cdsNFS.FieldByName('PSVFANT').AsString := NoInfNfse.ChildNodes['ns2:PrestadorServico'].ChildNodes['ns2:NomeFantasia'].Text;
  cdsNFS.FieldByName('PSVEND').AsString := NoInfNfse.ChildNodes['ns2:PrestadorServico'].ChildNodes['ns2:Endereco'].ChildNodes['ns2:Endereco'].Text;
  cdsNFS.FieldByName('PSVNUM').AsString := NoInfNfse.ChildNodes['ns2:PrestadorServico'].ChildNodes['ns2:Endereco'].ChildNodes['ns2:Numero'].Text;
  cdsNFS.FieldByName('PSVCOMPL').AsString := NoInfNfse.ChildNodes['ns2:PrestadorServico'].ChildNodes['ns2:Endereco'].ChildNodes['ns2:Complemento'].Text;
  cdsNFS.FieldByName('PSVBAIR').AsString := NoInfNfse.ChildNodes['ns2:PrestadorServico'].ChildNodes['ns2:Endereco'].ChildNodes['ns2:Bairro'].Text;
  cdsNFS.FieldByName('PSVMUN').AsString := NoInfNfse.ChildNodes['ns2:PrestadorServico'].ChildNodes['ns2:Endereco'].ChildNodes['ns2:CodigoMunicipio'].Text;
  cdsNFS.FieldByName('PSVUF').AsString := NoInfNfse.ChildNodes['ns2:PrestadorServico'].ChildNodes['ns2:Endereco'].ChildNodes['ns2:Uf'].Text;
  cdsNFS.FieldByName('PSVCEP').AsString := NoInfNfse.ChildNodes['ns2:PrestadorServico'].ChildNodes['ns2:Endereco'].ChildNodes['ns2:Cep'].Text;
  cdsNFS.FieldByName('PSVFONE').AsString := NoInfNfse.ChildNodes['ns2:PrestadorServico'].ChildNodes['ns2:Contato'].ChildNodes['ns2:Telefone'].Text;
  cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes['ns2:PrestadorServico'].ChildNodes['ns2:Contato'].ChildNodes['ns2:Email'].Text;
  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Tomador'].ChildNodes['ns2:IdentificacaoTomador'].ChildNodes['ns2:CpfCnpj'].ChildNodes['ns2:Cnpj'].Text),
                                                          NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Tomador'].ChildNodes['ns2:IdentificacaoTomador'].ChildNodes['ns2:CpfCnpj'].ChildNodes['ns2:Cpf'].Text,
                                                          NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Tomador'].ChildNodes['ns2:IdentificacaoTomador'].ChildNodes['ns2:CpfCnpj'].ChildNodes['ns2:Cnpj'].Text);
  cdsNFS.FieldByName('TMSIM').AsString := '';
  cdsNFS.FieldByName('TMSRAZAO').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Tomador'].ChildNodes['ns2:RazaoSocial'].Text;
  cdsNFS.FieldByName('TMSEND').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Tomador'].ChildNodes['ns2:Endereco'].ChildNodes['ns2:Endereco'].Text;
  cdsNFS.FieldByName('TMSNUM').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Tomador'].ChildNodes['ns2:Endereco'].ChildNodes['ns2:Numero'].Text;
  cdsNFS.FieldByName('TMSCOMPL').AsString := '';
  cdsNFS.FieldByName('TMSBAIR').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Tomador'].ChildNodes['ns2:Endereco'].ChildNodes['ns2:Bairro'].Text;
  cdsNFS.FieldByName('TMSMUN').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Tomador'].ChildNodes['ns2:Endereco'].ChildNodes['ns2:CodigoMunicipio'].Text;
  cdsNFS.FieldByName('TMSUF').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Tomador'].ChildNodes['ns2:Endereco'].ChildNodes['ns2:Uf'].Text;
  cdsNFS.FieldByName('TMSCEP').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Tomador'].ChildNodes['ns2:Endereco'].ChildNodes['ns2:Cep'].Text;
  cdsNFS.FieldByName('TMSFONE').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Tomador'].ChildNodes['ns2:Contato'].ChildNodes['ns2:Telefone'].Text;
  cdsNFS.FieldByName('TMSEMAIL').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Tomador'].ChildNodes['ns2:Contato'].ChildNodes['ns2:Email'].Text;

  if (strCidadeNFSe='PREFEITURA DE PARACATU-MG') then
  Begin
    cdsNFS.FieldByName('EXIGIB').AsInteger := StrToInt(NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Servico'].ChildNodes['ns2:ExigibilidadeISS'].Text);
    cdsNFS.FieldByName('MUNINC').AsString  := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Servico'].ChildNodes['ns2:MunicipioIncidencia'].Text;
  End;

  cdsNFS.Post;

  if Assigned(cdsItens) then
  begin
    cdsItens.Append;
    cdsItens.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes['ns2:Numero'].Text;
    cdsItens.FieldByName('ITEDES').AsString := NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Servico'].ChildNodes['ns2:Discriminacao'].Text;
    cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
    cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Servico'].ChildNodes['ns2:Valores'].ChildNodes['ns2:ValorServicos'].Text,'.',','), 0);
    cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns2:DeclaracaoPrestacaoServico'].ChildNodes['ns2:InfDeclaracaoPrestacaoServico'].ChildNodes['ns2:Servico'].ChildNodes['ns2:Valores'].ChildNodes['ns2:ValorServicos'].Text,'.',','), 0);
    cdsItens.Post;
  end;

end;

end.
