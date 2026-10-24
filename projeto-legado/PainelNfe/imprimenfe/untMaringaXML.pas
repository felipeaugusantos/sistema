unit untMaringaXML;

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
  TMaringaXML = class

    private

    public

      class procedure pCarregaNoPrincipal( strXML : string );
      class procedure pCarregaNoInfNfse( NoElemento: IXMLNode );
      class procedure pCarregaNoDeclaracaoPrestacaoServico( NoInfNfse : IXMLNode );
      class procedure pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico : IXMLNode );
      class procedure pCarregaNoRps( NoInfDeclaracaoPrestacaoServico : IXMLNode );

      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);

  end;

var
  XmlDoc : IXMLDocument;
  NoElemento,
  NoInfNfse,
  NoDeclaracaoPrestacaoServico,
  NoInfDeclaracaoPrestacaoServico,
  NoRps : IXMLNode;

const
  ns2 = '';

implementation

{ TMaringaXML }

class procedure TMaringaXML.pCarregaNoPrincipal( strXML : string );
begin

  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;

  NoElemento := XmlDoc.DocumentElement;

end;

class procedure TMaringaXML.pCarregaNoInfNfse( NoElemento: IXMLNode );
begin
  If not ( NoElemento = nil ) Then
  Begin
    NoInfNfse := NoElemento.childNodes.FindNode('InfNfse', ns2);
    NoInfNfse.ChildNodes.First;
  End;
end;

class procedure TMaringaXML.pCarregaNoDeclaracaoPrestacaoServico( NoInfNfse: IXMLNode );
begin
  If not ( NoInfNfse = nil ) Then
  Begin
    NoDeclaracaoPrestacaoServico := NoInfNfse.childNodes.FindNode('DeclaracaoPrestacaoServico', ns2);
    NoDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TMaringaXML.pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico: IXMLNode );
begin
  If not ( NoDeclaracaoPrestacaoServico = nil ) Then
  Begin
    NoInfDeclaracaoPrestacaoServico := NoDeclaracaoPrestacaoServico.childNodes.FindNode('InfDeclaracaoPrestacaoServico', ns2);
    NoInfDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TMaringaXML.pCarregaNoRps( NoInfDeclaracaoPrestacaoServico: IXMLNode );
begin
  If not ( NoInfDeclaracaoPrestacaoServico = nil ) Then
  Begin
    NoRps := NoInfDeclaracaoPrestacaoServico.childNodes.FindNode('Rps', ns2);
    NoRps.ChildNodes.First;
  End;
end;

class procedure TMaringaXML.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
begin
  //
end;

class procedure TMaringaXML.pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);
begin

  pCarregaNoPrincipal( strXML );
  pCarregaNoInfNfse( NoElemento );
  pCarregaNoDeclaracaoPrestacaoServico( NoInfNfse );
  pCarregaNoInfDeclaracaoPrestacaoServico( NoDeclaracaoPrestacaoServico );
  pCarregaNoRps( NoInfDeclaracaoPrestacaoServico );

  cdsNFS.Append;
  // Dados da NFS
  cdsNFS.FieldByName('NUMNFS').AsString := FormatFloat('00000000', StrToFloat(NoInfNfse.ChildNodes.FindNode('Numero').Text));
  cdsNFS.FieldByName('SERIE').AsString  := '1';
  cdsNFS.FieldByName('CODVER').AsString := NoInfNfse.ChildNodes.FindNode('CodigoVerificacao').Text;
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(NoInfNfse.ChildNodes.FindNode('DataEmissao').Text, 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(NoInfNfse.ChildNodes.FindNode('DataEmissao').Text,9,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes.FindNode('DataEmissao').Text,6,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes.FindNode('DataEmissao').Text,1,4);

  cdsNFS.FieldByName('NUMRPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('SERRPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
  cdsNFS.FieldByName('TPORPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;
  cdsNFS.FieldByName('EMIRPS').AsString := Copy(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,1,4);
  cdsNFS.FieldByName('STSRPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;

  cdsNFS.FieldByName('NATOPE').AsString := '';
  cdsNFS.FieldByName('CODRET').AsString := '';
  cdsNFS.FieldByName('EMIOSN').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['OptanteSimplesNacional'].Text;
  cdsNFS.FieldByName('EMIICC').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['IncentivoFiscal'].Text;
  cdsNFS.FieldByName('COMPET').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Competencia'].Text;
  cdsNFS.FieldByName('OUTINF').AsString := '';
  cdsNFS.FieldByName('ORGMUN').AsString := NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('ORG_UF').AsString := NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;
  cdsNFS.FieldByName('_LINK_').AsString := '';

  //Valores
  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['IssRetido'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorIss'].Text,'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['Aliquota'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
  cdsNFS.FieldByName('CDCNAE').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['CodigoCnae'].Text;
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
  cdsNFS.FieldByName('CODMUN').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('MUNINC').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['MunicipioIncidencia'].Text;
  cdsNFS.FieldByName('MUNPRE').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('ITEDESC').AsString := '';
  cdsNFS.FieldByName('ITEQTD').AsFloat := 0;
  cdsNFS.FieldByName('ITEVLU').AsFloat := 0;
  cdsNFS.FieldByName('EXIGIB').AsInteger := StrToInt(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['ExigibilidadeISS'].Text);
  cdsNFS.FieldByName('DESCONC').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoCondicionado'].Text,'.',','), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoIncondicionado'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorInss'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll'].Text,'.',','), 0);
  cdsNFS.FieldByName('OUT_RET').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['OutrasRetencoes'].Text,'.',','), 0);

  //Prestador
  cdsNFS.FieldByName('IEPRES').AsString   := '';
  cdsNFS.FieldByName('PSVCNPJ').AsString  := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Prestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
  cdsNFS.FieldByName('PSVIM').AsString    := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Prestador'].ChildNodes['InscricaoMunicipal'].Text;
  cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
  cdsNFS.FieldByName('PSVFANT').AsString  := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia'].Text;
  cdsNFS.FieldByName('PSVEND').AsString   := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
  cdsNFS.FieldByName('PSVNUM').AsString   := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('PSVCOMPL').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
  cdsNFS.FieldByName('PSVBAIR').AsString  := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
  cdsNFS.FieldByName('PSVMUN').AsString   := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('PSVUF').AsString    := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
  cdsNFS.FieldByName('PSVCEP').AsString   := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
  cdsNFS.FieldByName('PSVFONE').AsString  := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
  cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;

  //Tomador
  cdsNFS.FieldByName('TMSIE').AsString   := '';
  cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                          NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                          NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);
  cdsNFS.FieldByName('TMSIM').AsString    := '';
  cdsNFS.FieldByName('TMSRAZAO').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['RazaoSocial'].Text;
  cdsNFS.FieldByName('TMSFANTA').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['NomeFantasia'].Text;
  cdsNFS.FieldByName('TMSEND').AsString   := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
  cdsNFS.FieldByName('TMSNUM').AsString   := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('TMSCOMPL').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
  cdsNFS.FieldByName('TMSBAIR').AsString  := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
  cdsNFS.FieldByName('TMSMUN').AsString   := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('TMSUF').AsString    := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
  cdsNFS.FieldByName('TMSCEP').AsString   := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
  cdsNFS.FieldByName('TMSFONE').AsString  := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
  cdsNFS.FieldByName('TMSEMAIL').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Email'].Text;

  cdsNFS.Post;

end;

end.
