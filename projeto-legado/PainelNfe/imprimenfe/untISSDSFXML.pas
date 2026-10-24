unit untISSDSFXML;

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
  TISSDSFXML = class

    private

    public

      class procedure pNoElemento(strXML: string);
      class procedure pNoInfNfse;

      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string; strCidadeNFSe: string = '');

  end;

var
  XmlDoc : IXMLDocument;
  NoElemento,
  NoInfNfse : IXMLNode;

implementation

{ TISSDSFXML }

class procedure TISSDSFXML.pNoElemento(strXML: string);
begin

  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;
  NoElemento := XmlDoc.DocumentElement;

end;

class procedure TISSDSFXML.pNoInfNfse;
begin
  If NoElemento <> Nil Then
    NoInfNfse := NoElemento.ChildNodes.FindNode('InfNfse');
end;


class procedure TISSDSFXML.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string);
begin
  //
end;

class procedure TISSDSFXML.pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string; strCidadeNFSe: string = '');
begin

  pNoElemento(strXML);
  pNoInfNfse;

  cdsNFS.Append;

  cdsNFS.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('CODVER').AsString := NoInfNfse.ChildNodes['CodigoVerificacao'].Text;
  cdsNFS.FieldByName('ASSPRE').AsString := '';
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,12,8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,1,4);

  cdsNFS.FieldByName('NUMRPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('SERRPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
  cdsNFS.FieldByName('TPORPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;

  cdsNFS.FieldByName('EMIRPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text;
  cdsNFS.FieldByName('NATOPE').AsString := '';
  cdsNFS.FieldByName('CODRET').AsString := '';
  cdsNFS.FieldByName('EMIOSN').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['OptanteSimplesNacional'].Text;
  cdsNFS.FieldByName('EMIICC').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['IncentivoFiscal'].Text;
  cdsNFS.FieldByName('COMPET').AsString := Copy(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Competencia'].Text,6,2)+'/'+
                                           Copy(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Competencia'].Text,1,4);
  cdsNFS.FieldByName('OUTINF').AsString := NoInfNfse.ChildNodes['OutrasInformacoes'].Text;

  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['IssRetido'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIss'].Text,'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['Aliquota'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
  cdsNFS.FieldByName('CDCNAE').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['CodigoCnae'].Text;
  cdsNFS.FieldByName('CODTRI').AsString := '';
  cdsNFS.FieldByName('DISCRI').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
  cdsNFS.FieldByName('CODMUN').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('ITEDESC').AsString := '';
  cdsNFS.FieldByName('ITEQTD').AsFloat := 0;
  cdsNFS.FieldByName('ITEVLU').AsFloat := 0;

  if (strCidadeNFSe = 'PREFEITURA DE JARINU-SP') then
  begin
    cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRINS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorInss'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRIR_').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll'].Text,'.',','), 0);
    cdsNFS.FieldByName('OUT_RET').AsFloat := 0;
  end
  else
  begin
    cdsNFS.FieldByName('VLRDED').AsFloat := 0;
    cdsNFS.FieldByName('VLRPIS').AsFloat := 0;
    cdsNFS.FieldByName('VLRCOF').AsFloat := 0;
    cdsNFS.FieldByName('VLRINS').AsFloat := 0;
    cdsNFS.FieldByName('VLRIR_').AsFloat := 0;
    cdsNFS.FieldByName('VLRCSL').AsFloat := 0;
    cdsNFS.FieldByName('OUT_RET').AsFloat := 0;
  end;

  if (strCidadeNFSe = 'CITEL') then
  begin
    cdsNFS.FieldByName('PSVCNPJ').AsString  := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Prestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
    cdsNFS.FieldByName('PSVIM').AsString    := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Prestador'].ChildNodes['InscricaoMunicipal'].Text;
  end
  else
  begin
    cdsNFS.FieldByName('PSVCNPJ').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
    cdsNFS.FieldByName('PSVIM').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
  end;

  cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
  cdsNFS.FieldByName('PSVFANT').AsString := '';
  cdsNFS.FieldByName('PSVEND').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
  cdsNFS.FieldByName('PSVNUM').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('PSVCOMPL').AsString := '';
  cdsNFS.FieldByName('PSVBAIR').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
  cdsNFS.FieldByName('PSVMUN').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('PSVUF').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
  cdsNFS.FieldByName('PSVCEP').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
  cdsNFS.FieldByName('PSVFONE').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
  cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;

  if (strCidadeNFSe = 'CITEL') then
  begin
    cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                          NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                          NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);

    cdsNFS.FieldByName('TMSIM').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['InscricaoMunicipal'].Text;

    cdsNFS.FieldByName('TMSRAZAO').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['RazaoSocial'].Text='',
                                                   NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['RazaoSocial'].Text,
                                                   NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['RazaoSocial'].Text);

    cdsNFS.FieldByName('TMSEND').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text='',
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text,
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text);

    cdsNFS.FieldByName('TMSNUM').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text='',
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Numero'].Text,
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text);

    cdsNFS.FieldByName('TMSCOMPL').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text='',
                                                   NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text,
                                                   NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text);

    cdsNFS.FieldByName('TMSBAIR').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text='',
                                                  NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text,
                                                  NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text);

    cdsNFS.FieldByName('TMSMUN').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text='',
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text,
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text);

    cdsNFS.FieldByName('TMSUF').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text='',
                                                NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Uf'].Text,
                                                NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text);

    cdsNFS.FieldByName('TMSCEP').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text='',
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Cep'].Text,
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text);

    cdsNFS.FieldByName('TMSFONE').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text='',
                                                  NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['Contato'].ChildNodes['Telefone'].Text,
                                                  NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text);

    cdsNFS.FieldByName('TMSEMAIL').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text='',
                                                   NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['Contato'].ChildNodes['Email'].Text,
                                                   NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text);
  end
  else
  begin

    cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                            NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                            NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);
    cdsNFS.FieldByName('TMSIM').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['InscricaoMunicipal'].Text;
    cdsNFS.FieldByName('TMSRAZAO').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['RazaoSocial'].Text='',
                                                   NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['RazaoSocial'].Text,
                                                   NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['RazaoSocial'].Text);
    cdsNFS.FieldByName('TMSEND').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text='',
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text,
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text);
    cdsNFS.FieldByName('TMSNUM').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Numero'].Text='',
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Numero'].Text,
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Numero'].Text);
    cdsNFS.FieldByName('TMSCOMPL').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text='',
                                                   NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text,
                                                   NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text);
    cdsNFS.FieldByName('TMSBAIR').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text='',
                                                  NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text,
                                                  NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text);
    cdsNFS.FieldByName('TMSMUN').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text='',
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text,
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text);
    cdsNFS.FieldByName('TMSUF').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Uf'].Text='',
                                                NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Uf'].Text,
                                                NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Uf'].Text);
    cdsNFS.FieldByName('TMSCEP').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Cep'].Text='',
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Cep'].Text,
                                                 NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Cep'].Text);
    cdsNFS.FieldByName('TMSFONE').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Telefone'].Text='',
                                                  NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Contato'].ChildNodes['Telefone'].Text,
                                                  NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Telefone'].Text);
    cdsNFS.FieldByName('TMSEMAIL').AsString := iif(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Email'].Text='',
                                                   NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Contato'].ChildNodes['Email'].Text,
                                                   NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Email'].Text);
  end;
  cdsNFS.FieldByName('ORGMUN').AsString := NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('ORG_UF').AsString := NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;

  cdsNFS.Post;

end;

end.
