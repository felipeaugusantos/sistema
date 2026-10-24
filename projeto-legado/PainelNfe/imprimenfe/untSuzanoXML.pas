unit untSuzanoXML;

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
  TSuzanoXML = class

    private
      class function fEfetuarTratamentoXML(strCidadeNFSe, strNFSENO: string): boolean; static;

    public

      class procedure pNoElemento(strXML: string; strCidadeNFSe: string=''; strNFSENO: string='');
      class procedure pNoListaNfse;
      class procedure pNoCompNfse;
      class procedure pNfse;
      class procedure pNoInfNfse(strCidadeNFSe: string=''; strNFSENO: string='');

      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

const
  ns3 = 'http://www.ginfes.com.br/servico_consultar_lote_rps_resposta_v03.xsd';
  ns4 = 'http://www.ginfes.com.br/tipos_v03.xsd';

var
  XmlDoc : IXMLDocument;
  NoElemento,
  NoListaNfse,
  NoCompNfse,
  NoNfse,
  NoInfNfse : IXMLNode;

implementation

class procedure TSuzanoXML.pNoElemento(strXML: string; strCidadeNFSe: string=''; strNFSENO: string='');
var
  strXMLCorrigido : String;
begin

  XmlDoc := TXMLDocument.Create(Application);
  strXMLCorrigido := strXML;

  if fEfetuarTratamentoXML(strCidadeNFSe, strNFSENO) then
  begin
    if Copy( strXMLCorrigido, 1, 1) = '"' then
    begin
      strXMLCorrigido := Copy( strXMLCorrigido, 2, Length(strXML)-2 );
      strXMLCorrigido := StringReplace(strXMLCorrigido, '\"', '"', [rfReplaceAll]);
    end;
  end;
  XmlDoc.LoadFromXML(strXMLCorrigido);
  XmlDoc.Active := True;

  NoElemento := XmlDoc.DocumentElement;

end;

class procedure TSuzanoXML.pNoListaNfse;
begin
  If NoElemento <> Nil Then
    NoListaNfse := NoElemento.ChildNodes.FindNode('ListaNfse');
end;

class procedure TSuzanoXML.pNoCompNfse;
begin
  If NoListaNfse <> Nil Then
    NoCompNfse := NoListaNfse.ChildNodes.FindNode('CompNfse');
end;

class procedure TSuzanoXML.pNfse;
begin
  If NoCompNfse <> Nil Then
    NoNfse := NoCompNfse.ChildNodes.FindNode('Nfse');
end;

class procedure TSuzanoXML.pNoInfNfse(strCidadeNFSe: string=''; strNFSENO: string='');
begin
  if fEfetuarTratamentoXML(strCidadeNFSe, strNFSENO) then
  begin
    If NoElemento <> Nil then
    begin
      if (strCidadeNFSe = 'PREFEITURA DE SUZANO-SP') Then
        NoInfNfse := NoElemento.ChildNodes.FindNode('InfNfse'); // Removido prefixo ns4 provisoriamente
      if (strCidadeNFSe = 'CITEL') then
        NoInfNfse := NoElemento.ChildNodes.FindNode('InfNfse');
    end;
  end
  else
  begin
    If NoNfse <> Nil Then
      NoInfNfse := NoNfse.ChildNodes.FindNode('InfNfse');
  end;
end;


class function TSuzanoXML.fEfetuarTratamentoXML(strCidadeNFSe,
  strNFSENO: string): boolean;
begin

  If (strNFSENO <> 'S') Then
  Begin
    Result := False;
    Exit;
  End;

  Result := True;

  If (strCidadeNFSe = 'PREFEITURA DE SUZANO-SP') Then
    Exit;

  If (strCidadeNFSe = 'CITEL') Then
    Exit;

  Result := False;
end;

class procedure TSuzanoXML.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
begin

  pNoElemento(strXML);
  pNoListaNfse;
  pNoCompNfse;
  pNfse;
  pNoInfNfse;

  If NoInfNfse <> Nil Then
  Begin

    cdsNFS.Append;

    //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS

    cdsNFS.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('CODVER').AsString := NoInfNfse.ChildNodes['CodigoVerificacao'].Text;
    cdsNFS.FieldByName('DTAHRA').AsString := NoInfNfse.ChildNodes['DataEmissao'].Text;
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,1,4);

    cdsNFS.FieldByName('NUMRPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('SERRPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
    cdsNFS.FieldByName('TPORPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;

    cdsNFS.FieldByName('EMIRPS').AsString := NoInfNfse.ChildNodes['DataEmissaoRps'].Text;
    cdsNFS.FieldByName('NATOPE').AsString := NoInfNfse.ChildNodes['NaturezaOperacao'].Text;
    cdsNFS.FieldByName('CODRET').AsString := NoInfNfse.ChildNodes['RegimeEspecialTributacao'].Text;
    cdsNFS.FieldByName('EMIOSN').AsString := NoInfNfse.ChildNodes['OptanteSimplesNacional'].Text;
    cdsNFS.FieldByName('EMIICC').AsString := NoInfNfse.ChildNodes['IncentivadorCultural'].Text;
    cdsNFS.FieldByName('COMPET').AsString := Copy(NoInfNfse.ChildNodes['Competencia'].Text,1,10);

    //SERVIÇOS

    cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['IssRetido'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIss'].Text,'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['Aliquota'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIssRetido'].Text,'.',','), 0);

    cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorInss'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);

    cdsNFS.FieldByName('CODSER').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
    cdsNFS.FieldByName('CODTRI').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['CodigoTributacaoMunicipio'].Text;
    cdsNFS.FieldByName('DISCRI').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
    cdsNFS.FieldByName('CODMUN').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;

    //PRESTADOR DO SERVIÇO

    cdsNFS.FieldByName('PSVCNPJ').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Prestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
    cdsNFS.FieldByName('PSVIM').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Prestador'].ChildNodes['InscricaoMunicipal'].Text;
    cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('PSVEND').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('PSVNUM').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('PSVBAIR').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('PSVMUN').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('PSVUF').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('PSVCEP').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('PSVFONE').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;

    //TOMADOR DO SERVIÇO

    cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                            NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                            NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);

    cdsNFS.FieldByName('TMSRAZAO').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('TMSEND').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('TMSNUM').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('TMSBAIR').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('TMSMUN').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('TMSUF').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('TMSCEP').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('TMSFONE').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('TMSEMAIL').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;

    // ORGÃO GERADOR

    cdsNFS.FieldByName('ORGMUN').AsString := NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('ORG_UF').AsString := NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;

    cdsNFS.Post;

  End;

end;

class procedure TSuzanoXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string;
  cdsItens: TUniClientDataSet);
var
  prefixo: string;
begin

  pNoElemento(strXML, strCidadeNFSe, 'S');
  pNoInfNfse(strCidadeNFSe, 'S');

  If NoInfNfse <> Nil Then
  Begin

    prefixo := IfThen(strCidadeNFSe='CITEL', '', ''); // Removido prefixo ns4 provisoriamente

    //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS

    cdsNFS.Append;

    cdsNFS.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes[prefixo+'Numero'].Text;
    cdsNFS.FieldByName('CODVER').AsString := NoInfNfse.ChildNodes[prefixo+'CodigoVerificacao'].Text;
    cdsNFS.FieldByName('DTAHRA').AsString := NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text;
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text,9,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text,6,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text,1,4);

    cdsNFS.FieldByName('NUMRPS').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Rps'].ChildNodes[prefixo+'IdentificacaoRps'].ChildNodes[prefixo+'Numero'].Text;
    cdsNFS.FieldByName('SERRPS').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Rps'].ChildNodes[prefixo+'IdentificacaoRps'].ChildNodes[prefixo+'Serie'].Text;
    cdsNFS.FieldByName('TPORPS').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Rps'].ChildNodes[prefixo+'IdentificacaoRps'].ChildNodes[prefixo+'Tipo'].Text;

    cdsNFS.FieldByName('EMIRPS').AsString := NoInfNfse.ChildNodes[prefixo+'DataEmissaoRps'].Text;
    cdsNFS.FieldByName('NATOPE').AsString := NoInfNfse.ChildNodes[prefixo+'NaturezaOperacao'].Text;
    cdsNFS.FieldByName('CODRET').AsString := NoInfNfse.ChildNodes[prefixo+'RegimeEspecialTributacao'].Text;
    cdsNFS.FieldByName('EMIOSN').AsString := NoInfNfse.ChildNodes[prefixo+'OptanteSimplesNacional'].Text;
    cdsNFS.FieldByName('EMIICC').AsString := NoInfNfse.ChildNodes[prefixo+'IncentivadorCultural'].Text;
    cdsNFS.FieldByName('COMPET').AsString := Copy(NoInfNfse.ChildNodes[prefixo+'Competencia'].Text,1,10);

    //SERVIÇOS

    cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorServicos'].Text,'.',','), 0);
    cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'IssRetido'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorIss'].Text,'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'BaseCalculo'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'Aliquota'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorIssRetido'].Text,'.',','), 0);

    cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorPis'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorCofins'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorIr'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorInss'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorCsll'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorLiquidoNfse'].Text,'.',','), 0);

    cdsNFS.FieldByName('CODSER').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'ItemListaServico'].Text;
    cdsNFS.FieldByName('CODTRI').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'CodigoTributacaoMunicipio'].Text;
    cdsNFS.FieldByName('DISCRI').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Discriminacao'].Text;
    cdsNFS.FieldByName('CODMUN').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'CodigoMunicipio'].Text;

    //PRESTADOR DO SERVIÇO

    cdsNFS.FieldByName('PSVCNPJ').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Prestador'].ChildNodes[prefixo+'CpfCnpj'].ChildNodes[prefixo+'Cnpj'].Text;
    cdsNFS.FieldByName('PSVIM').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Prestador'].ChildNodes[prefixo+'InscricaoMunicipal'].Text;
    cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'RazaoSocial'].Text;
    cdsNFS.FieldByName('PSVFANT').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'NomeFantasia'].Text;
    cdsNFS.FieldByName('PSVEND').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Endereco'].Text;
    cdsNFS.FieldByName('PSVNUM').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Numero'].Text;
    cdsNFS.FieldByName('PSVBAIR').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Bairro'].Text;
    cdsNFS.FieldByName('PSVMUN').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'CodigoMunicipio'].Text;
    cdsNFS.FieldByName('PSVUF').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Uf'].Text;
    cdsNFS.FieldByName('PSVCEP').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Cep'].Text;
    cdsNFS.FieldByName('PSVFONE').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Telefone'].Text;
    cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Email'].Text;

    //TOMADOR DO SERVIÇO

    cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'CpfCnpj'].ChildNodes[prefixo+'Cnpj'].Text),
                                                            NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'CpfCnpj'].ChildNodes[prefixo+'Cpf'].Text,
                                                            NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'CpfCnpj'].ChildNodes[prefixo+'Cnpj'].Text);

    cdsNFS.FieldByName('TMSRAZAO').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'RazaoSocial'].Text;
    cdsNFS.FieldByName('TMSEND').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Endereco'].Text;
    cdsNFS.FieldByName('TMSNUM').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Numero'].Text;
    cdsNFS.FieldByName('TMSBAIR').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Bairro'].Text;
    cdsNFS.FieldByName('TMSMUN').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'CodigoMunicipio'].Text;
    cdsNFS.FieldByName('TMSUF').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Uf'].Text;
    cdsNFS.FieldByName('TMSCEP').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Cep'].Text;
    cdsNFS.FieldByName('TMSFONE').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Telefone'].Text;
    cdsNFS.FieldByName('TMSEMAIL').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Email'].Text;

    // ORGÃO GERADOR

    cdsNFS.FieldByName('ORGMUN').AsString := NoInfNfse.ChildNodes[prefixo+'OrgaoGerador'].ChildNodes[prefixo+'CodigoMunicipio'].Text;
    cdsNFS.FieldByName('ORG_UF').AsString := NoInfNfse.ChildNodes[prefixo+'OrgaoGerador'].ChildNodes[prefixo+'Uf'].Text;

    cdsNFS.Post;

  end;

end;
end.
