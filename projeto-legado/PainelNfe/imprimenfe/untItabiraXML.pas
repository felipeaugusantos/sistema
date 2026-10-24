unit untItabiraXML;

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
  TItabiraXML = class

    private

    public

      class procedure pCarregaNoPrincipal( strXML : string; var varXmlDoc : IXMLDocument; var varNoElmento : IXMLNode );
      class procedure pCarregaNoNfse(var varNoElemento: IXMLNode; var varNoNfse: IXMLNode  );
      class procedure pCarregaNoInfNfse(var varNoNfse: IXMLNode; var varNoElmento : IXMLNode; var varNoInfNfse: IXMLNode  );
      class procedure pCarregaNoDeclaracaoPrestacaoServico(var varNoInfNfse : IXMLNode ; var varNoDeclaracaoPrestacaoServico : IXMLNode );
      class procedure pCarregaNoInfDeclaracaoPrestacaoServico( var varNoDeclaracaoPrestacaoServico : IXMLNode;  var varNoInfDeclaracaoPrestacaoServico : IXMLNode  );

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string);

  end;

const
  ns2 = 'http://www.abrasf.org.br/nfse.xsd';

implementation

{ TItabiraXML }

class procedure TItabiraXML.pCarregaNoPrincipal( strXML : string; var varXmlDoc : IXMLDocument; var varNoElmento : IXMLNode );
begin

  varXmlDoc := TXMLDocument.Create(Application);
  varXmlDoc.LoadFromXML(strXML);
  varXmlDoc.Active := True;

  varNoElmento := varXmlDoc.DocumentElement;

end;

class procedure TItabiraXML.pCarregaNoInfNfse(var varNoNfse: IXMLNode; var varNoElmento : IXMLNode; var varNoInfNfse: IXMLNode  );
begin
  If not ( varNoNfse = nil ) Then
  Begin
    varNoInfNfse := varNoNfse.childNodes.FindNode('InfNfse');
    varNoInfNfse.ChildNodes.First;
  End
  Else If not ( varNoElmento = nil ) Then
  begin
    varNoInfNfse := varNoElmento.childNodes.FindNode('InfNfse');
    varNoInfNfse.ChildNodes.First;
  end;
end;

class procedure TItabiraXML.pCarregaNoNfse(var varNoElemento,
  varNoNfse: IXMLNode);
begin
  If not ( varNoElemento = nil ) Then
  Begin
    varNoNfse := varNoElemento.childNodes.FindNode('Nfse');
    if not (varNoNfse = nil ) then
      varNoNfse.ChildNodes.First;
  End;
end;

class procedure TItabiraXML.pCarregaNoDeclaracaoPrestacaoServico(var varNoInfNfse : IXMLNode ; var varNoDeclaracaoPrestacaoServico : IXMLNode );
begin
  If not ( varNoInfNfse = nil ) Then
  Begin
    varNoDeclaracaoPrestacaoServico := varNoInfNfse.childNodes.FindNode('DeclaracaoPrestacaoServico');
    varNoDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TItabiraXML.pCarregaNoInfDeclaracaoPrestacaoServico( var varNoDeclaracaoPrestacaoServico : IXMLNode;  var varNoInfDeclaracaoPrestacaoServico : IXMLNode  );
begin
  If not ( varNoDeclaracaoPrestacaoServico = nil ) Then
  Begin
    varNoInfDeclaracaoPrestacaoServico := varNoDeclaracaoPrestacaoServico.childNodes.FindNode('InfDeclaracaoPrestacaoServico');
    varNoInfDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TItabiraXML.pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string);
var
  XmlDoc : IXMLDocument;
  NoElemento,
  NoNfse,
  NoInfNfse,
  NoDeclaracaoPrestacaoServico,
  NoInfDeclaracaoPrestacaoServico : IXMLNode;
begin

  pCarregaNoPrincipal( strXML,  XmlDoc, NoElemento);
  pCarregaNoNfse( NoElemento, NoNfse );
  pCarregaNoInfNfse( NoNfse, NoElemento, NoInfNfse );
  pCarregaNoDeclaracaoPrestacaoServico( NoInfNfse, NoDeclaracaoPrestacaoServico );
  pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico, NoInfDeclaracaoPrestacaoServico );

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes.FindNode('Numero').Text;
  cdsNFS.FieldByName('SERIE').AsString  := '1';
  cdsNFS.FieldByName('CODVER').AsString := NoInfNfse.ChildNodes.FindNode('CodigoVerificacao').Text;
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(NoInfNfse.ChildNodes.FindNode('DataEmissao').Text, 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(NoInfNfse.ChildNodes.FindNode('DataEmissao').Text,9,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes.FindNode('DataEmissao').Text,6,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes.FindNode('DataEmissao').Text,1,4);

  cdsNFS.FieldByName('NUMRPS').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('SERRPS').AsString  := NoInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;

  cdsNFS.FieldByName('NATOPE').AsInteger := 0;
  cdsNFS.FieldByName('CODRET').AsInteger := 0;
  cdsNFS.FieldByName('EMIOSN').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['OptanteSimplesNacional'].Text;
  cdsNFS.FieldByName('EMIICC').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['IncentivoFiscal'].Text;
  cdsNFS.FieldByName('COMPET').AsString := Copy(NoInfDeclaracaoPrestacaoServico.ChildNodes.FindNode('Competencia').Text,9,2)+'/'+
                                           Copy(NoInfDeclaracaoPrestacaoServico.ChildNodes.FindNode('Competencia').Text,6,2)+'/'+
                                           Copy(NoInfDeclaracaoPrestacaoServico.ChildNodes.FindNode('Competencia').Text,1,4);
  cdsNFS.FieldByName('OUTINF').AsString := StringReplace(NoInfNfse.ChildNodes['OutrasInformacoes'].Text, '|', sLineBreak, [rfReplaceAll]);
  cdsNFS.FieldByName('ORGMUN').AsString := NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('ORG_UF').AsString := NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;

  //Valores
  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['IssRetido'].Text,'.',','), 0);
  cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['DescontoIncondicionado'].Text,'.',','), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['DescontoCondicionado'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorIss'].Text,'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['Aliquota'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes'].Text,'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
  cdsNFS.FieldByName('CDCNAE').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoCnae'].Text;
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := StringReplace(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Discriminacao'].Text, '\s\n', ' |', [rfReplaceAll]);
  cdsNFS.FieldByName('CODMUN').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('MUNINC').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['MunicipioIncidencia'].Text;
  cdsNFS.FieldByName('EXIISS').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['ExigibilidadeISS'].Text;
  cdsNFS.FieldByName('ITEDESC').AsString := '';
  cdsNFS.FieldByName('ITEQTD').AsFloat := 0;
  cdsNFS.FieldByName('ITEVLU').AsFloat := 0;
  cdsNFS.FieldByName('VLRPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis'].Text,'.',','), 0);

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Prestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
  cdsNFS.FieldByName('PSVIM').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Prestador'].ChildNodes['InscricaoMunicipal'].Text;
  cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
  cdsNFS.FieldByName('PSVFANT').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia'].Text;
  cdsNFS.FieldByName('PSVEND').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
  cdsNFS.FieldByName('PSVNUM').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('PSVCOMPL').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
  cdsNFS.FieldByName('PSVBAIR').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
  cdsNFS.FieldByName('PSVMUN').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('PSVUF').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
  cdsNFS.FieldByName('PSVCEP').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
  cdsNFS.FieldByName('PSVFONE').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
  cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;
  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                          NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                          NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);
  cdsNFS.FieldByName('TMSIM').AsString := '';
  cdsNFS.FieldByName('TMSRAZAO').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['RazaoSocial'].Text;
  cdsNFS.FieldByName('TMSFANTA').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['NomeFantasia'].Text;
  cdsNFS.FieldByName('TMSEND').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
  cdsNFS.FieldByName('TMSNUM').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('TMSCOMPL').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
  cdsNFS.FieldByName('TMSBAIR').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
  cdsNFS.FieldByName('TMSMUN').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('TMSUF').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
  cdsNFS.FieldByName('TMSCEP').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
  cdsNFS.FieldByName('TMSFONE').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
  cdsNFS.FieldByName('TMSEMAIL').AsString := NoInfDeclaracaoPrestacaoServico.ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Email'].Text;


  cdsNFS.Post;

  if Assigned(cdsItens) then
  begin
    cdsItens.Append;
    cdsItens.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes.FindNode('Numero').Text;
    cdsItens.FieldByName('ITEDES').AsString := AnsiReplaceStr(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Discriminacao'].Text, '|', sLineBreak);
    cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
    cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsItens.Post;
  end;

end;

end.
