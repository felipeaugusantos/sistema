unit untProvNobe;

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
  TProvNobe = class

    private

    public

      class procedure pCarregaNoPrincipal( strXML : string );
      class procedure pCarregaNoInfNfse( NoElemento: IXMLNode );
      class procedure pCarregaNoInfDeclaracaoPrestacaoServico( var varNoDeclaracaoPrestacaoServico : IXMLNode;  var varNoInfDeclaracaoPrestacaoServico : IXMLNode  );
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
  end;

type
  TProvNobeV2 = class

    private

    public

      class procedure pCarregaNoPrincipal( strXML : string );
      class procedure pCarregaNoInfNfse( NoElemento: IXMLNode );
      class procedure pCarregaNoInfDeclaracaoPrestacaoServico( var varNoDeclaracaoPrestacaoServico : IXMLNode;  var varNoInfDeclaracaoPrestacaoServico : IXMLNode  );
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
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

{ TProvNobe }

class procedure TProvNobe.pCarregaNoPrincipal( strXML : string );
begin

  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;

  NoElemento := XmlDoc.DocumentElement;

end;

class procedure TProvNobe.pCarregaNoInfNfse( NoElemento: IXMLNode );
begin
  If not ( NoElemento = nil ) Then
  Begin
    NoInfNfse := NoElemento.childNodes.FindNode('InfNfse', ns2);
    NoInfNfse.ChildNodes.First;
  End;
end;

class procedure TProvNobe.pCarregaNoInfDeclaracaoPrestacaoServico( var varNoDeclaracaoPrestacaoServico : IXMLNode;  var varNoInfDeclaracaoPrestacaoServico : IXMLNode  );
begin
  If not ( varNoDeclaracaoPrestacaoServico = nil ) Then
  Begin
    varNoInfDeclaracaoPrestacaoServico := varNoDeclaracaoPrestacaoServico.childNodes.FindNode('InfDeclaracaoPrestacaoServico', ns2);
    varNoInfDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TProvNobe.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
var
  strDtaEmi: String;
begin
  pCarregaNoPrincipal( strXML );
  pCarregaNoInfNfse( NoElemento );
  NoDeclaracaoPrestacaoServico := NoInfNfse.ChildNodes.FindNode('DeclaracaoPrestacaoServico');
  pCarregaNoInfDeclaracaoPrestacaoServico(NoDeclaracaoPrestacaoServico , NoInfDeclaracaoPrestacaoServico );
  cdsNFS.Append;

  // Dados da NFS

  cdsNFS.FieldByName('NUMNFS').AsString := FormatFloat('0000000000', StrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Numero']), 0));
  cdsNFS.FieldByName('SERIE').AsString  := 'E';
  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['CodigoVerificacao']);
  cdsNFS.FieldByName('DTAHRA').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['DataEmissao']);
  cdsNFS.FieldByName('_LINK_').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['LinkNota']);

  strDtaEmi := fRetornaValorTagXml(NoInfNfse.ChildNodes['DataEmissao']);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(strDtaEmi, 9, 2)+'/'+
                                           Copy(strDtaEmi, 6, 2)+'/'+
                                           Copy(strDtaEmi, 1, 4);

  cdsNFS.FieldByName('HRAEMI').AsString := Copy(strDtaEmi, Pos('T', strDtaEmi)+1, Length(strDtaEmi));
  cdsNFS.FieldByName('HRAEMI').AsString := Copy(cdsNFS.FieldByName('HRAEMI').AsString, 1, 8);

  cdsNFS.FieldByName('NUMRPS').AsString := FormatFloat('000000000000',StrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Rps']
                                                                                                                                       .ChildNodes['IdentificacaoRps']
                                                                                                                                       .ChildNodes['Numero']), 0));

  cdsNFS.FieldByName('SERRPS').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie']);
  cdsNFS.FieldByName('TPORPS').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo']);

  cdsNFS.FieldByName('EMIRPS').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['DataEmissaoRps']);
  cdsNFS.FieldByName('NATOPE').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['NaturezaOperacao']);
  cdsNFS.FieldByName('RESPTRIB').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['RegimeEspecialTributacao']);
  cdsNFS.FieldByName('EMIOSN').AsString   := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['OptanteSimplesNacional']);
  cdsNFS.FieldByName('EMIICC').AsString   := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['IncentivadorCultural']);
  cdsNFS.FieldByName('COMPET').AsString   := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Competencia']);
  cdsNFS.FieldByName('COMPET').AsString   := Copy(cdsNFS.FieldByName('COMPET').AsString, 9, 2)+'/'+
                                             Copy(cdsNFS.FieldByName('COMPET').AsString, 6, 2)+'/'+
                                             Copy(cdsNFS.FieldByName('COMPET').AsString, 1, 4);

  cdsNFS.FieldByName('COMPET').AsString   := Copy(cdsNFS.FieldByName('COMPET').AsString, 4, Length(cdsNFS.FieldByName('COMPET').AsString));
  cdsNFS.FieldByName('OUTINF').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['OutrasInformacoes']);
  cdsNFS.FieldByName('ORGMUN').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('ORG_UF').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['Uf']);

  //Valores
  cdsNFS.FieldByName('VLRISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorIss']));
  cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo']));
  cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse']));
  cdsNFS.FieldByName('ALIISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['Aliquota']));

  cdsNFS.FieldByName('ISS_RET').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['IssRetido']));
  cdsNFS.FieldByName('VLISSR').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIssRetido']));
  cdsNFS.FieldByName('VLRSER').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos']));
  cdsNFS.FieldByName('VALPIS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis']));
  cdsNFS.FieldByName('VALCOF').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins']));
  cdsNFS.FieldByName('VALIRR').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr']));
  cdsNFS.FieldByName('VALINS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorInss']));
  cdsNFS.FieldByName('VALCSL').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll']));

  cdsNFS.FieldByName('VLRDED').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes']));
  cdsNFS.FieldByName('DESCONI').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoIncondicionado']));
  cdsNFS.FieldByName('DESCONC').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoCondicionado']));
  cdsNFS.FieldByName('OUT_RET').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['OutrasRetencoes']));

  cdsNFS.FieldByName('VALCRE').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['ValorCredito']));


  cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['ItemListaServico']);
  cdsNFS.FieldByName('CODTRI').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoTributacaoMunicipio']);

  cdsNFS.FieldByName('DISCRI').AsString := StringReplace(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Discriminacao']), 'nn', sLineBreak+sLineBreak, [rfReplaceAll]);

  cdsNFS.FieldByName('CODMUN').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('CDCNAE').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoCnae']);

  //Prestador

  cdsNFS.FieldByName('PSVCNPJ').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['Cnpj']);
  cdsNFS.FieldByName('PSVIM').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal']);
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial']);
  cdsNFS.FieldByName('PSVEND').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco']);
  cdsNFS.FieldByName('PSVNUM').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero']);
  cdsNFS.FieldByName('PSVBAIR').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro']);
  cdsNFS.FieldByName('PSVMUN').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('PSVUF').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf']);
  cdsNFS.FieldByName('PSVCEP').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep']);
  cdsNFS.FieldByName('PSVFONE').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone']);
  cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email']);
  cdsNFS.FieldByName('PSVFANT').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia']);

  //Tomador

  cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'])),
                                                            fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf']),
                                                            fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj']));
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['TomadorServico'].ChildNodes['RazaoSocial']);
  cdsNFS.FieldByName('TMSEND').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco']);
  cdsNFS.FieldByName('TMSNUM').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Numero']);
  cdsNFS.FieldByName('TMSBAIR').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro']);
  cdsNFS.FieldByName('TMSMUN').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('TMSUF').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Uf']);
  cdsNFS.FieldByName('TMSCEP').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cep']);
  cdsNFS.FieldByName('TMSFONE').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Telefone']);
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(NoInfDeclaracaoPrestacaoServico.ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Email']);

  cdsNFS.Post;
end;

{ TProvNobeV2 }

class procedure TProvNobeV2.pCarregaNoPrincipal( strXML : string );
begin

  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;

  NoElemento := XmlDoc.DocumentElement;

end;

class procedure TProvNobeV2.pCarregaNoInfNfse( NoElemento: IXMLNode );
begin
  If not ( NoElemento = nil ) Then
  Begin
    NoInfNfse := NoElemento.childNodes.FindNode('InfNfse', ns2);
    NoInfNfse.ChildNodes.First;
  End;
end;

class procedure TProvNobeV2.pCarregaNoInfDeclaracaoPrestacaoServico( var varNoDeclaracaoPrestacaoServico : IXMLNode;  var varNoInfDeclaracaoPrestacaoServico : IXMLNode  );
begin
  If not ( varNoDeclaracaoPrestacaoServico = nil ) Then
  Begin
    varNoInfDeclaracaoPrestacaoServico := varNoDeclaracaoPrestacaoServico.childNodes.FindNode('InfDeclaracaoPrestacaoServico', ns2);
    varNoInfDeclaracaoPrestacaoServico.ChildNodes.First;
  End;
end;

class procedure TProvNobeV2.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
var
  strDtaEmi: String;
begin
  pCarregaNoPrincipal( strXML );
  pCarregaNoInfNfse( NoElemento );
  NoDeclaracaoPrestacaoServico := NoInfNfse.ChildNodes.FindNode('DeclaracaoPrestacaoServico');
  pCarregaNoInfDeclaracaoPrestacaoServico(NoDeclaracaoPrestacaoServico , NoInfDeclaracaoPrestacaoServico );
  cdsNFS.Append;

  // Dados da NFS

  cdsNFS.FieldByName('NUMNFS').AsString := FormatFloat('0000000000', StrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Numero']), 0));
  cdsNFS.FieldByName('SERIE').AsString  := 'E';
  cdsNFS.FieldByName('CODVER').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['CodigoVerificacao']);
  cdsNFS.FieldByName('DTAHRA').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['DataEmissao']);
  cdsNFS.FieldByName('_LINK_').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['LinkNota']);

  strDtaEmi := fRetornaValorTagXml(NoInfNfse.ChildNodes['DataEmissao']);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(strDtaEmi, 9, 2)+'/'+
                                           Copy(strDtaEmi, 6, 2)+'/'+
                                           Copy(strDtaEmi, 1, 4);

  cdsNFS.FieldByName('HRAEMI').AsString := Copy(strDtaEmi, Pos('T', strDtaEmi)+1, Length(strDtaEmi));
  cdsNFS.FieldByName('HRAEMI').AsString := Copy(cdsNFS.FieldByName('HRAEMI').AsString, 1, 8);

  cdsNFS.FieldByName('NUMRPS').AsString := FormatFloat('000000000000',StrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['IdentificacaoRps']
                                                                                                                 .ChildNodes['Numero']), 0));

  cdsNFS.FieldByName('SERRPS').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['IdentificacaoRps']
                                                                        .ChildNodes['Serie']);
  cdsNFS.FieldByName('TPORPS').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['IdentificacaoRps']
                                                                        .ChildNodes['Tipo']);

  cdsNFS.FieldByName('EMIRPS').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['DataEmissaoRps']);
  cdsNFS.FieldByName('NATOPE').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['NaturezaOperacao']);
  cdsNFS.FieldByName('RESPTRIB').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['OptanteSimplesNacional']);
  cdsNFS.FieldByName('EMIOSN').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['CodigoVerificacao']);
  cdsNFS.FieldByName('EMIICC').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['IncentivadorCultural']);
  cdsNFS.FieldByName('COMPET').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['Competencia']);
  cdsNFS.FieldByName('COMPET').AsString   := Copy(cdsNFS.FieldByName('COMPET').AsString, 9, 2)+'/'+
                                             Copy(cdsNFS.FieldByName('COMPET').AsString, 6, 2)+'/'+
                                             Copy(cdsNFS.FieldByName('COMPET').AsString, 1, 4);

  cdsNFS.FieldByName('COMPET').AsString := Copy(cdsNFS.FieldByName('COMPET').AsString, 4, Length(cdsNFS.FieldByName('COMPET').AsString));
  cdsNFS.FieldByName('OUTINF').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['OutrasInformacoes']);
  cdsNFS.FieldByName('ORGMUN').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('ORG_UF').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['Uf']);

  //Valores
  cdsNFS.FieldByName('VLRISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIss']));
  cdsNFS.FieldByName('BSCISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['BaseCalculo']));
  cdsNFS.FieldByName('VLRLIQ').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorLiquidoNfse']));
  cdsNFS.FieldByName('ALIISS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['Aliquota']));

  cdsNFS.FieldByName('ISS_RET').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['IssRetido']));
  cdsNFS.FieldByName('VLISSR').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIssRetido']));
  cdsNFS.FieldByName('VLRSER').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos']));
  cdsNFS.FieldByName('VALPIS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis']));
  cdsNFS.FieldByName('VALCOF').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins']));
  cdsNFS.FieldByName('VALIRR').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr']));
  cdsNFS.FieldByName('VALINS').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorInss']));
  cdsNFS.FieldByName('VALCSL').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll']));

  cdsNFS.FieldByName('VLRDED').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes']));
  cdsNFS.FieldByName('DESCONI').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoIncondicionado']));
  cdsNFS.FieldByName('DESCONC').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoCondicionado']));
  cdsNFS.FieldByName('OUT_RET').AsFloat := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['OutrasRetencoes']));
  cdsNFS.FieldByName('VALCRE').AsFloat  := fStrToFloatDef(fRetornaValorTagXml(NoInfNfse.ChildNodes['ValorCredito']));
  cdsNFS.FieldByName('CODSER').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['ItemListaServico']);
  cdsNFS.FieldByName('CODTRI').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['CodigoTributacaoMunicipio']);
  cdsNFS.FieldByName('DISCRI').AsString := StringReplace(fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['Discriminacao']), 'nn', sLineBreak+sLineBreak, [rfReplaceAll]);
  cdsNFS.FieldByName('CODMUN').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('CDCNAE').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['Servico'].ChildNodes['CodigoCnae']);

  //Prestador

  cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['Cnpj']);
  cdsNFS.FieldByName('PSVIM').AsString    := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal']);
  cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial']);
  cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco']);
  cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero']);
  cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro']);
  cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf']);
  cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep']);
  cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone']);
  cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email']);
  cdsNFS.FieldByName('PSVFANT').AsString  := fRetornaValorTagXml(NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia']);

  //Tomador

  cdsNFS.FieldByName('TMSCNPJ').AsString  := Iif(fEmptyStr(fRetornaValorTagXml(NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'])),
                                                           fRetornaValorTagXml(NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf']),
                                                           fRetornaValorTagXml(NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj']));
  cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['RazaoSocial']);
  cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco']);
  cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Numero']);
  cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro']);
  cdsNFS.FieldByName('TMSMUN').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio']);
  cdsNFS.FieldByName('TMSUF').AsString    := fRetornaValorTagXml(NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Uf']);
  cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cep']);
  cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Telefone']);
  cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(NoInfNfse.ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Email']);

  cdsNFS.Post;
end;

end.
