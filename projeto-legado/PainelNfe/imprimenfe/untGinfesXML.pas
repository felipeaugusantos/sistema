unit untGinfesXML;

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
  TGinfesXML = class

    private

    public

      class procedure pNoElemento(strXML: string; strCidadeNFSe: string=''; strNFSENO: string='');
      class procedure pNoListaNfse;
      class procedure pNoCompNfse;
      class procedure pNfse;
      class procedure pNoInfNfse(strCidadeNFSe: string=''; strNFSENO: string='');

      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

      class function fEfetuarTratamentoXML(strCidadeNFSe, strNFSENO: string): boolean;

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

class procedure TGinfesXML.pNoElemento(strXML: string; strCidadeNFSe: string=''; strNFSENO: string='');
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

class procedure TGinfesXML.pNoListaNfse;
begin
  If NoElemento <> Nil Then
    NoListaNfse := NoElemento.ChildNodes.FindNode('ns3:ListaNfse', ns3);
end;

class procedure TGinfesXML.pNoCompNfse;
begin
  If NoListaNfse <> Nil Then
    NoCompNfse := NoListaNfse.ChildNodes.FindNode('ns3:CompNfse', ns3);
end;

class function TGinfesXML.fEfetuarTratamentoXML(strCidadeNFSe,
  strNFSENO: string): boolean;
begin

  If (strNFSENO <> 'S') Then
  Begin
    Result := False;
    Exit;
  End;

  Result := True;

  If (strCidadeNFSe = 'PREFEITURA DE ITAQUAQUECETUBA-SP') Then
    Exit;

  If (strCidadeNFSe = 'CITEL') Then
    Exit;

  Result := False;
end;

class procedure TGinfesXML.pNfse;
begin
  If NoCompNfse <> Nil Then
    NoNfse := NoCompNfse.ChildNodes.FindNode('ns4:Nfse', ns4);
end;

class procedure TGinfesXML.pNoInfNfse(strCidadeNFSe: string=''; strNFSENO: string='');
begin
  if fEfetuarTratamentoXML(strCidadeNFSe, strNFSENO) then
  begin
    If NoElemento <> Nil then
    begin
      if ((strCidadeNFSe = 'CITEL') or (strCidadeNFSe = 'PREFEITURA DE ITAQUAQUECETUBA-SP')) then
        NoInfNfse := NoElemento.ChildNodes.FindNode('InfNfse');
    end;
  end
  Else If (strCidadeNFSe = 'PREFEITURA DE PORTO FERREIRA-SP') Then
  Begin
    If NoElemento <> Nil then
      NoInfNfse := NoElemento.ChildNodes.FindNode('ns4:InfNfse', ns4);
  End
  Else If (strCidadeNFSe = 'PREFEITURA DE GUARUJÁ-SP') Then
  Begin
    If NoElemento <> Nil then
      NoInfNfse := NoElemento.ChildNodes.FindNode('ns4:InfNfse', ns4);
  End
  else
  begin
    If NoNfse <> Nil Then
      NoInfNfse := NoNfse.ChildNodes.FindNode('ns4:InfNfse', ns4);
  end;
end;

class procedure TGinfesXML.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
begin

  try

    pNoElemento(strXML);
    pNoListaNfse;
    pNoCompNfse;
    pNfse;
    pNoInfNfse;

    If NoInfNfse <> Nil Then
    Begin

      cdsNFS.Append;

      //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS

      cdsNFS.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes['ns4:Numero'].Text;
      cdsNFS.FieldByName('CODVER').AsString := NoInfNfse.ChildNodes['ns4:CodigoVerificacao'].Text;
      cdsNFS.FieldByName('DTAHRA').AsString := NoInfNfse.ChildNodes['ns4:DataEmissao'].Text;
      cdsNFS.FieldByName('DTAEMI').AsString := Copy(NoInfNfse.ChildNodes['ns4:DataEmissao'].Text,9,2)+'/'+
                                               Copy(NoInfNfse.ChildNodes['ns4:DataEmissao'].Text,6,2)+'/'+
                                               Copy(NoInfNfse.ChildNodes['ns4:DataEmissao'].Text,1,4);

      cdsNFS.FieldByName('NUMRPS').AsString := NoInfNfse.ChildNodes['ns4:IdentificacaoRps'].ChildNodes['ns4:Numero'].Text;
      cdsNFS.FieldByName('SERRPS').AsString := NoInfNfse.ChildNodes['ns4:IdentificacaoRps'].ChildNodes['ns4:Serie'].Text;
      cdsNFS.FieldByName('TPORPS').AsString := NoInfNfse.ChildNodes['ns4:IdentificacaoRps'].ChildNodes['ns4:Tipo'].Text;

      cdsNFS.FieldByName('EMIRPS').AsString := NoInfNfse.ChildNodes['ns4:DataEmissaoRps'].Text;
      cdsNFS.FieldByName('NATOPE').AsString := NoInfNfse.ChildNodes['ns4:NaturezaOperacao'].Text;
      cdsNFS.FieldByName('CODRET').AsString := NoInfNfse.ChildNodes['ns4:RegimeEspecialTributacao'].Text;
      cdsNFS.FieldByName('EMIOSN').AsString := NoInfNfse.ChildNodes['ns4:OptanteSimplesNacional'].Text;
      cdsNFS.FieldByName('EMIICC').AsString := NoInfNfse.ChildNodes['ns4:IncentivadorCultural'].Text;
      cdsNFS.FieldByName('COMPET').AsString := Copy(NoInfNfse.ChildNodes['ns4:Competencia'].Text,1,10);

      //SERVIÇOS

      cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorServicos'].Text,'.',','), 0);
      cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:IssRetido'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorIss'].Text,'.',','), 0);
      cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:BaseCalculo'].Text,'.',','), 0);
      cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:Aliquota'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorIssRetido'].Text,'.',','), 0);

      cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorPis'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorCofins'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorIr'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorInss'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorCsll'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:Valores'].ChildNodes['ns4:ValorLiquidoNfse'].Text,'.',','), 0);

      cdsNFS.FieldByName('CODSER').AsString := NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:ItemListaServico'].Text;
      cdsNFS.FieldByName('CODTRI').AsString := NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:CodigoTributacaoMunicipio'].Text;
      cdsNFS.FieldByName('DISCRI').AsString := NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:Discriminacao'].Text;
      cdsNFS.FieldByName('CODMUN').AsString := NoInfNfse.ChildNodes['ns4:Servico'].ChildNodes['ns4:CodigoMunicipio'].Text;

      //PRESTADOR DO SERVIÇO

      cdsNFS.FieldByName('PSVCNPJ').AsString := NoInfNfse.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:IdentificacaoPrestador'].ChildNodes['ns4:Cnpj'].Text;
      cdsNFS.FieldByName('PSVIM').AsString := NoInfNfse.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:IdentificacaoPrestador'].ChildNodes['ns4:InscricaoMunicipal'].Text;
      cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:RazaoSocial'].Text;
      cdsNFS.FieldByName('PSVEND').AsString := NoInfNfse.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Endereco'].Text;
      cdsNFS.FieldByName('PSVNUM').AsString := NoInfNfse.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Numero'].Text;
      cdsNFS.FieldByName('PSVBAIR').AsString := NoInfNfse.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Bairro'].Text;
      cdsNFS.FieldByName('PSVMUN').AsString := NoInfNfse.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:CodigoMunicipio'].Text;
      cdsNFS.FieldByName('PSVUF').AsString := NoInfNfse.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Uf'].Text;
      cdsNFS.FieldByName('PSVCEP').AsString := NoInfNfse.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Cep'].Text;
      cdsNFS.FieldByName('PSVFONE').AsString := NoInfNfse.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Contato'].ChildNodes['ns4:Telefone'].Text;
      cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes['ns4:PrestadorServico'].ChildNodes['ns4:Contato'].ChildNodes['ns4:Email'].Text;

      //TOMADOR DO SERVIÇO

      cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(NoInfNfse.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:IdentificacaoTomador'].ChildNodes['ns4:CpfCnpj'].ChildNodes['ns4:Cnpj'].Text),
                                                              NoInfNfse.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:IdentificacaoTomador'].ChildNodes['ns4:CpfCnpj'].ChildNodes['ns4:Cpf'].Text,
                                                              NoInfNfse.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:IdentificacaoTomador'].ChildNodes['ns4:CpfCnpj'].ChildNodes['ns4:Cnpj'].Text);

      cdsNFS.FieldByName('TMSRAZAO').AsString := NoInfNfse.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:RazaoSocial'].Text;
      cdsNFS.FieldByName('TMSEND').AsString := NoInfNfse.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Endereco'].Text;
      cdsNFS.FieldByName('TMSNUM').AsString := NoInfNfse.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Numero'].Text;
      cdsNFS.FieldByName('TMSBAIR').AsString := NoInfNfse.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Bairro'].Text;
      cdsNFS.FieldByName('TMSMUN').AsString := NoInfNfse.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:CodigoMunicipio'].Text;
      cdsNFS.FieldByName('TMSUF').AsString := NoInfNfse.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Uf'].Text;
      cdsNFS.FieldByName('TMSCEP').AsString := NoInfNfse.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Endereco'].ChildNodes['ns4:Cep'].Text;
      cdsNFS.FieldByName('TMSFONE').AsString := NoInfNfse.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Contato'].ChildNodes['ns4:Telefone'].Text;
      cdsNFS.FieldByName('TMSEMAIL').AsString := NoInfNfse.ChildNodes['ns4:TomadorServico'].ChildNodes['ns4:Contato'].ChildNodes['ns4:Email'].Text;

      // ORGÃO GERADOR

      cdsNFS.FieldByName('ORGMUN').AsString := NoInfNfse.ChildNodes['ns4:OrgaoGerador'].ChildNodes['ns4:CodigoMunicipio'].Text;
      cdsNFS.FieldByName('ORG_UF').AsString := NoInfNfse.ChildNodes['ns4:OrgaoGerador'].ChildNodes['ns4:Uf'].Text;

      // CONSTRUÇÃO CIVIL
      cdsNFS.FieldByName('CODOBR').AsString := '';
      cdsNFS.FieldByName('CODART').AsString := '';

      cdsNFS.Post;

    End;

  finally
    FreeAndNil(XmlDoc);
  end;

end;

class procedure TGinfesXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string;
  cdsItens: TUniClientDataSet);
var
  prefixo: string;
begin

  if (strCidadeNFSe = 'CITEL')or
     (strCidadeNFSe = 'PREFEITURA DE PORTO FERREIRA-SP') Or
     (strCidadeNFSe = 'PREFEITURA DE GUARUJÁ-SP') then
  begin

    pNoElemento(strXML, strCidadeNFSe, 'S');
    pNoInfNfse(strCidadeNFSe, 'S');

    If NoInfNfse <> Nil Then
    Begin

      prefixo := IfThen(strCidadeNFSe='CITEL', '', 'ns4:');

      cdsNFS.Append;

      //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS

      cdsNFS.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes[prefixo+'Numero'].Text;
      cdsNFS.FieldByName('CODVER').AsString := NoInfNfse.ChildNodes[prefixo+'CodigoVerificacao'].Text;
      cdsNFS.FieldByName('DTAHRA').AsString := NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text;
      cdsNFS.FieldByName('DTAEMI').AsString := Copy(NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text,9,2)+'/'+
                                               Copy(NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text,6,2)+'/'+
                                               Copy(NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text,1,4);
      cdsNFS.FieldByName('HRAEMI').AsString := Copy(NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text,12,8);

      cdsNFS.FieldByName('NUMRPS').AsString := NoInfNfse.ChildNodes[prefixo+'IdentificacaoRps'].ChildNodes[prefixo+'Numero'].Text;
      cdsNFS.FieldByName('SERRPS').AsString := NoInfNfse.ChildNodes[prefixo+'IdentificacaoRps'].ChildNodes[prefixo+'Serie'].Text;
      cdsNFS.FieldByName('TPORPS').AsString := NoInfNfse.ChildNodes[prefixo+'IdentificacaoRps'].ChildNodes[prefixo+'Tipo'].Text;

      cdsNFS.FieldByName('EMIRPS').AsString := NoInfNfse.ChildNodes[prefixo+'DataEmissaoRps'].Text;
      cdsNFS.FieldByName('NATOPE').AsString := NoInfNfse.ChildNodes[prefixo+'NaturezaOperacao'].Text;
      cdsNFS.FieldByName('CODRET').AsString := NoInfNfse.ChildNodes[prefixo+'RegimeEspecialTributacao'].Text;
      cdsNFS.FieldByName('EMIOSN').AsString := NoInfNfse.ChildNodes[prefixo+'OptanteSimplesNacional'].Text;
      cdsNFS.FieldByName('EMIICC').AsString := NoInfNfse.ChildNodes[prefixo+'IncentivadorCultural'].Text;
      cdsNFS.FieldByName('COMPET').AsString := Copy(NoInfNfse.ChildNodes[prefixo+'Competencia'].Text,1,10);

      //SERVIÇOS

      cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorServicos'].Text,'.',','), 0);
      cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'IssRetido'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorIss'].Text,'.',','), 0);
      cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'BaseCalculo'].Text,'.',','), 0);
      cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'Aliquota'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorIssRetido'].Text,'.',','), 0);

      cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorPis'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorCofins'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorIr'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorInss'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorCsll'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorLiquidoNfse'].Text,'.',','), 0);

      cdsNFS.FieldByName('CODSER').AsString := NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'ItemListaServico'].Text;
      cdsNFS.FieldByName('CODTRI').AsString := NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'CodigoTributacaoMunicipio'].Text;
      cdsNFS.FieldByName('DISCRI').AsString := NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Discriminacao'].Text;
      cdsNFS.FieldByName('CODMUN').AsString := NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'CodigoMunicipio'].Text;

      //PRESTADOR DO SERVIÇO

      cdsNFS.FieldByName('PSVCNPJ').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'IdentificacaoPrestador'].ChildNodes[prefixo+'Cnpj'].Text;
      cdsNFS.FieldByName('PSVIM').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'IdentificacaoPrestador'].ChildNodes[prefixo+'InscricaoMunicipal'].Text;
      cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'RazaoSocial'].Text;
      cdsNFS.FieldByName('PSVEND').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Endereco'].Text;
      cdsNFS.FieldByName('PSVNUM').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Numero'].Text;
      cdsNFS.FieldByName('PSVBAIR').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Bairro'].Text;
      cdsNFS.FieldByName('PSVMUN').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'CodigoMunicipio'].Text;
      cdsNFS.FieldByName('PSVUF').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Uf'].Text;
      cdsNFS.FieldByName('PSVCEP').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Cep'].Text;
      cdsNFS.FieldByName('PSVFONE').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Telefone'].Text;
      cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Email'].Text;

      //TOMADOR DO SERVIÇO

      cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'CpfCnpj'].ChildNodes[prefixo+'Cnpj'].Text),
                                                              NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'CpfCnpj'].ChildNodes[prefixo+'Cpf'].Text,
                                                              NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'CpfCnpj'].ChildNodes[prefixo+'Cnpj'].Text);
      cdsNFS.FieldByName('TMSIM').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'InscricaoMunicipal'].Text;
      cdsNFS.FieldByName('TMSRAZAO').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'RazaoSocial'].Text;
      cdsNFS.FieldByName('TMSEND').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Endereco'].Text;
      cdsNFS.FieldByName('TMSNUM').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Numero'].Text;
      cdsNFS.FieldByName('TMSBAIR').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Bairro'].Text;
      cdsNFS.FieldByName('TMSMUN').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'CodigoMunicipio'].Text;
      cdsNFS.FieldByName('TMSUF').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Uf'].Text;
      cdsNFS.FieldByName('TMSCEP').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Cep'].Text;
      cdsNFS.FieldByName('TMSFONE').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Telefone'].Text;
      cdsNFS.FieldByName('TMSEMAIL').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Email'].Text;

      If strCidadeNFSe = 'PREFEITURA DE GUARUJÁ-SP' Then
      Begin
        cdsNFS.FieldByName('TMSCOMPL').AsString := NoInfNfse.ChildNodes[prefixo+'TomadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Complemento'].Text;
        cdsNFS.FieldByName('VALDED').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorDeducoes'].Text,'.',','), 0);
      End;

      // ORGÃO GERADOR

      cdsNFS.FieldByName('ORGMUN').AsString := NoInfNfse.ChildNodes[prefixo+'OrgaoGerador'].ChildNodes[prefixo+'CodigoMunicipio'].Text;
      cdsNFS.FieldByName('ORG_UF').AsString := NoInfNfse.ChildNodes[prefixo+'OrgaoGerador'].ChildNodes[prefixo+'Uf'].Text;

      // CONSTRUÇÃO CIVIL
      cdsNFS.FieldByName('CODOBR').AsString := NoInfNfse.ChildNodes[prefixo+'ConstrucaoCivil'].ChildNodes[prefixo+'CodigoObra'].Text;
      cdsNFS.FieldByName('CODART').AsString := NoInfNfse.ChildNodes[prefixo+'ConstrucaoCivil'].ChildNodes[prefixo+'Art'].Text;

      cdsNFS.Post;

      if Assigned(cdsItens) then
      begin
        cdsItens.Append;
        cdsItens.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes[prefixo+'Numero'].Text;
        cdsItens.FieldByName('ITEDES').AsString := NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Discriminacao'].Text;
        cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
        cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorLiquidoNfse'].Text,'.',','), 0);
        cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorLiquidoNfse'].Text,'.',','), 0);
        cdsItens.Post;
      end;

    End;

  end
  else if (strCidadeNFSe = 'PREFEITURA DE ITAQUAQUECETUBA-SP') then
  begin

    pNoElemento(strXML, strCidadeNFSe, 'S');
    pNoInfNfse(strCidadeNFSe, 'S');

    If NoInfNfse <> Nil Then
    Begin

      prefixo := '';

      cdsNFS.Append;

      //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS

      cdsNFS.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes[prefixo+'Numero'].Text;
      cdsNFS.FieldByName('CODVER').AsString := NoInfNfse.ChildNodes[prefixo+'CodigoVerificacao'].Text;
      cdsNFS.FieldByName('DTAHRA').AsString := NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text;
      cdsNFS.FieldByName('DTAEMI').AsString := Copy(NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text,9,2)+'/'+
                                               Copy(NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text,6,2)+'/'+
                                               Copy(NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text,1,4);
      cdsNFS.FieldByName('HRAEMI').AsString := Copy(NoInfNfse.ChildNodes[prefixo+'DataEmissao'].Text,12,8);

      cdsNFS.FieldByName('NUMRPS').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Rps'].ChildNodes[prefixo+'IdentificacaoRps'].ChildNodes[prefixo+'Numero'].Text;
      cdsNFS.FieldByName('SERRPS').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Rps'].ChildNodes[prefixo+'IdentificacaoRps'].ChildNodes[prefixo+'Serie'].Text;
      cdsNFS.FieldByName('TPORPS').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Rps'].ChildNodes[prefixo+'IdentificacaoRps'].ChildNodes[prefixo+'Tipo'].Text;

      cdsNFS.FieldByName('EMIRPS').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'DataEmissaoRps'].Text;
      cdsNFS.FieldByName('NATOPE').AsString := '';
      cdsNFS.FieldByName('CODRET').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'RegimeEspecialTributacao'].Text;
      cdsNFS.FieldByName('EMIOSN').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'OptanteSimplesNacional'].Text;
      cdsNFS.FieldByName('EMIICC').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'IncentivadorCultural'].Text;
      cdsNFS.FieldByName('COMPET').AsString := Copy(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Competencia'].Text,1,10);

      //SERVIÇOS

      cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorServicos'].Text,'.',','), 0);
      cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'IssRetido'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorIss'].Text,'.',','), 0);
      cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'BaseCalculo'].Text,'.',','), 0);
      cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'Aliquota'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorIssRetido'].Text,'.',','), 0);

      cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorPis'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorCofins'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorIr'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorInss'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorCsll'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorServicos'].Text,'.',','), 0);

      cdsNFS.FieldByName('CODSER').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'ItemListaServico'].Text;
      cdsNFS.FieldByName('CODTRI').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'CodigoTributacaoMunicipio'].Text;
      cdsNFS.FieldByName('DISCRI').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Discriminacao'].Text;
      cdsNFS.FieldByName('CODMUN').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'CodigoMunicipio'].Text;

      //PRESTADOR DO SERVIÇO

      cdsNFS.FieldByName('PSVCNPJ').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'IdentificacaoPrestador'].ChildNodes[prefixo+'CpfCnpj'].ChildNodes[prefixo+'Cnpj'].Text;
      cdsNFS.FieldByName('PSVIM').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'IdentificacaoPrestador'].ChildNodes[prefixo+'InscricaoMunicipal'].Text;
      cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'RazaoSocial'].Text;
      cdsNFS.FieldByName('PSVEND').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Endereco'].Text;
      cdsNFS.FieldByName('PSVNUM').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Numero'].Text;
      cdsNFS.FieldByName('PSVBAIR').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Bairro'].Text;
      cdsNFS.FieldByName('PSVMUN').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'CodigoMunicipio'].Text;
      cdsNFS.FieldByName('PSVUF').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Uf'].Text;
      cdsNFS.FieldByName('PSVCEP').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Cep'].Text;
      cdsNFS.FieldByName('PSVFONE').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Telefone'].Text;
      cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes[prefixo+'PrestadorServico'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Email'].Text;

      //TOMADOR DO SERVIÇO

      cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Tomador'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'CpfCnpj'].ChildNodes[prefixo+'Cnpj'].Text),
                                                              NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Tomador'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'CpfCnpj'].ChildNodes[prefixo+'Cpf'].Text,
                                                              NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Tomador'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'CpfCnpj'].ChildNodes[prefixo+'Cnpj'].Text);
      cdsNFS.FieldByName('TMSIM').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Tomador'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'InscricaoMunicipal'].Text;
      cdsNFS.FieldByName('TMSRAZAO').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Tomador'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'RazaoSocial'].Text;
      cdsNFS.FieldByName('TMSEND').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Tomador'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Endereco'].Text;
      cdsNFS.FieldByName('TMSNUM').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Tomador'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Numero'].Text;
      cdsNFS.FieldByName('TMSBAIR').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Tomador'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Bairro'].Text;
      cdsNFS.FieldByName('TMSMUN').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Tomador'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'CodigoMunicipio'].Text;
      cdsNFS.FieldByName('TMSUF').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Tomador'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Uf'].Text;
      cdsNFS.FieldByName('TMSCEP').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Tomador'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'Endereco'].ChildNodes[prefixo+'Cep'].Text;
      cdsNFS.FieldByName('TMSFONE').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Tomador'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Telefone'].Text;
      cdsNFS.FieldByName('TMSEMAIL').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Tomador'].ChildNodes[prefixo+'IdentificacaoTomador'].ChildNodes[prefixo+'Contato'].ChildNodes[prefixo+'Email'].Text;

      // ORGÃO GERADOR

      cdsNFS.FieldByName('ORGMUN').AsString := NoInfNfse.ChildNodes[prefixo+'OrgaoGerador'].ChildNodes[prefixo+'CodigoMunicipio'].Text;
      cdsNFS.FieldByName('ORG_UF').AsString := NoInfNfse.ChildNodes[prefixo+'OrgaoGerador'].ChildNodes[prefixo+'Uf'].Text;

      // CONSTRUÇÃO CIVIL
      cdsNFS.FieldByName('CODOBR').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'ConstrucaoCivil'].ChildNodes[prefixo+'CodigoObra'].Text;
      cdsNFS.FieldByName('CODART').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'ConstrucaoCivil'].ChildNodes[prefixo+'Art'].Text;

      cdsNFS.Post;

      if Assigned(cdsItens) then
      begin
        cdsItens.Append;
        cdsItens.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes[prefixo+'Numero'].Text;
        cdsItens.FieldByName('ITEDES').AsString := NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Discriminacao'].Text;
        cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
        cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorServicos'].Text,'.',','), 0);
        cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes[prefixo+'DeclaracaoPrestacaoServico'].ChildNodes[prefixo+'InfDeclaracaoPrestacaoServico'].ChildNodes[prefixo+'Servico'].ChildNodes[prefixo+'Valores'].ChildNodes[prefixo+'ValorServicos'].Text,'.',','), 0);
        cdsItens.Post;
      end;

    End;

  end;

end;

end.
