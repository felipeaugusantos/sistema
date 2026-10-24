unit untSilvaJardimXML;

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
  TSilvaJardimXML = class

    private

    public

      class procedure pNoElemento(strXML: string);
      class procedure pNoInfNfse;
      class procedure pNoTomador;
      class procedure pNoServico;
      class procedure pNoInfDeclaracaoPrestacaoServico;
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

var
  XmlDoc : IXMLDocument;
  NoElemento,
  NoCompNfse,
  NoNfse,
  NoInfNfse,
  NoTomador,
  NoServico,
  NoInfDeclaracaoPrestacaoServico: IXMLNode;

implementation

class procedure TSilvaJardimXML.pNoElemento(strXML: string);
begin
  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;
  NoElemento := XmlDoc.DocumentElement;
end;

class procedure TSilvaJardimXML.pNoInfDeclaracaoPrestacaoServico;
begin
  NoInfDeclaracaoPrestacaoServico := NoInfNfse.ChildNodes.FindNode('DeclaracaoPrestacaoServico')
                                              .ChildNodes.FindNode('InfDeclaracaoPrestacaoServico');
end;

class procedure TSilvaJardimXML.pNoInfNfse;
begin
  If NoElemento <> Nil Then
    NoInfNfse := NoElemento.ChildNodes.FindNode('InfNfse')
end;

class procedure TSilvaJardimXML.pNoServico;
begin
  NoServico := NoInfDeclaracaoPrestacaoServico.ChildNodes.FindNode('Servico');
end;

class procedure TSilvaJardimXML.pNoTomador;
begin
  NoTomador := NoInfDeclaracaoPrestacaoServico.ChildNodes.FindNode('Tomador');
end;

class procedure TSilvaJardimXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string;
  cdsItens: TUniClientDataSet);
begin

  pNoElemento(strXML);
  pNoInfNfse;
  pNoInfDeclaracaoPrestacaoServico;
  pNoTomador;
  pNoServico;

  If NoInfNfse <> Nil Then
  Begin

    //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS

    cdsNFS.Append;

    cdsNFS.FieldByName('NUMNFS').AsString := FormatFloat('000000000000000', StrToFloat(NoInfNfse.ChildNodes.FindNode('Numero').Text));
    cdsNFS.FieldByName('SERNFS').AsString := 'E';
    cdsNFS.FieldByName('CODVER').AsString := NoInfNfse.ChildNodes['CodigoVerificacao'].Text;
    cdsNFS.FieldByName('HRAEMI').AsString := Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,12,8);
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,1,4);

    cdsNFS.FieldByName('NUMRPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('SERRPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
    cdsNFS.FieldByName('TPORPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;
    cdsNFS.FieldByName('EMIRPS').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissaoRps'].Text;

    cdsNFS.FieldByName('NATOPE').AsInteger := 0;
    cdsNFS.FieldByName('EMIOSN').AsInteger := StrToInt(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['OptanteSimplesNacional'].Text);
    cdsNFS.FieldByName('EMIICC').AsInteger := StrToInt(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['IncentivoFiscal'].Text);
    cdsNFS.FieldByName('COMPET').AsString  := Copy(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Competencia'].Text,9,2)+'/'+
                                              Copy(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Competencia'].Text,6,2)+'/'+
                                              Copy(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Competencia'].Text,1,4);

    cdsNFS.FieldByName('OUTINF').AsString  := NoInfNfse.ChildNodes['OutrasInformacoes'].Text;

    //SERVIÇOS

    cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoServico.ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsNFS.FieldByName('ISS_RET').AsInteger := StrToInt(NoServico.ChildNodes['IssRetido'].Text);
    cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoServico.ChildNodes['Valores'].ChildNodes['ValorIss'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoServico.ChildNodes['Valores'].ChildNodes['Aliquota'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLISSR').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoServico.ChildNodes['Valores'].ChildNodes['ValorIssRetido'].Text,'.',','), 0);

    cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoServico.ChildNodes['Valores'].ChildNodes['ValorPis'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(NoServico.ChildNodes['Valores'].ChildNodes['ValorCofins'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoServico.ChildNodes['Valores'].ChildNodes['ValorIr'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoServico.ChildNodes['Valores'].ChildNodes['ValorInss'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(NoServico.ChildNodes['Valores'].ChildNodes['ValorCsll'].Text,'.',','), 0);


    cdsNFS.FieldByName('CODSER').AsString := NoServico.ChildNodes['ItemListaServico'].Text;
    cdsNFS.FieldByName('CODTRI').AsString := NoServico.ChildNodes['CodigoTributacaoMunicipio'].Text;
    cdsNFS.FieldByName('DISCRI').AsString := NoServico.ChildNodes['Discriminacao'].Text;
    cdsNFS.FieldByName('CODMUN').AsString := NoServico.ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('EXIGIB').AsString := NoServico.ChildNodes['ExigibilidadeISS'].Text;

    // VALORES NFSE
    cdsNFS.FieldByName('VLRLIQ').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoServico.ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo'].Text,'.',','), 0);

    //PRESTADOR DO SERVIÇO

    cdsNFS.FieldByName('PSVCNPJ').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
    cdsNFS.FieldByName('PSVIM').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
    cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('PSVFANTA').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia'].Text;
    cdsNFS.FieldByName('PSVEND').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('PSVNUM').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('PSVBAI').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('PSVMUN').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('PSVUF').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('PSVCEP').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('PSVFONE').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;

    //TOMADOR DO SERVIÇO

    cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(NoTomador.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                            NoTomador.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                            NoTomador.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);
    cdsNFS.FieldByName('TMSIM').AsString    := NoTomador.ChildNodes['IdentificacaoTomador'].ChildNodes['InscricaoMunicipal'].Text;
    cdsNFS.FieldByName('TMSRAZAO').AsString := NoTomador.ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('TMSEND').AsString   := NoTomador.ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('TMSNUM').AsString   := NoTomador.ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('TMSBAIR').AsString  := NoTomador.ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('TMSMUN').AsString   := NoTomador.ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('TMSUF').AsString    := NoTomador.ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('TMSCEP').AsString   := NoTomador.ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('TMSFONE').AsString  := NoTomador.ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('TMSEMAIL').AsString := NoTomador.ChildNodes['Contato'].ChildNodes['Email'].Text;

    // ORGÃO GERADOR

    cdsNFS.FieldByName('ORGMUN').AsString := NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('ORG_UF').AsString := NoInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('IMPDTA').AsString := DateToStr(Date);
    cdsNFS.FieldByName('IMPHRA').AsString := TimeToStr(Time);
    cdsNFS.Post;

  end;

end;

end.
