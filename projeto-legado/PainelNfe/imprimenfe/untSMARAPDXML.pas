unit untSMARAPDXML;

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
  TSMARAPDXML = class
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string);
  end;

implementation

{ TSMARAPDXML }

class procedure TSMARAPDXML.pRetornaCDSPreenchido(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string);
var
  xmlDoc : TXMLDocument;
begin

  xmlDoc := TXMLDocument.Create(Application);

  try

    xmlDoc.LoadFromXML(strXML);
    xmlDoc.Active := True;

    cdsNFS.Append;

    cdsNFS.FieldByName('NUMNFS').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['NumeroNota'].Text;
    cdsNFS.FieldByName('CODVER').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ChaveValidacao'].Text;
    cdsNFS.FieldByName('DTAHRA').AsString := '';
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['DataEmissao'].Text,1,4);
    cdsNFS.FieldByName('NUMRPS').AsString := '';
    cdsNFS.FieldByName('SERRPS').AsString := '';
    cdsNFS.FieldByName('TPORPS').AsString := '';
    cdsNFS.FieldByName('EMIRPS').AsString := '';
    cdsNFS.FieldByName('NATOPE').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['NaturezaOperacao'].Text;
    cdsNFS.FieldByName('CODRET').AsString := '';
    cdsNFS.FieldByName('EMIOSN').AsString := '';
    cdsNFS.FieldByName('EMIICC').AsString := '';
    cdsNFS.FieldByName('COMPET').AsString := Copy(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['DataEmissao'].Text,1,4);
    cdsNFS.FieldByName('OUTINF').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['Observacao'].Text;
    cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
    cdsNFS.FieldByName('ISS_RET').AsFloat := 0;
    cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ISSQNTotal'].Text,'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ITENS'].ChildNodes['Aliquota'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ValorTotalNota'].Text,'.',','), 0)-
                                            StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['Irrf'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['Irrf'].Text,'.',','), 0);
    cdsNFS.FieldByName('CODSER').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['Cae'].Text;
    cdsNFS.FieldByName('CDCNAE').AsString := '';
    cdsNFS.FieldByName('CODTRI').AsString := '';
    cdsNFS.FieldByName('DISCRI').AsString := '';
    cdsNFS.FieldByName('CODMUN').AsString := '';
    cdsNFS.FieldByName('ITEDESC').AsString := '';
    cdsNFS.FieldByName('ITEQTD').AsFloat := 0;
    cdsNFS.FieldByName('ITEVLU').AsFloat := 0;

    cdsNFS.FieldByName('TMSCNPJ').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ClienteCNPJCPF'].Text;
    cdsNFS.FieldByName('TMSIM').AsString := '';
    cdsNFS.FieldByName('TMSRAZAO').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ClienteNomeRazaoSocial'].Text;
    cdsNFS.FieldByName('TMSEND').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ClienteEndereco'].Text;
    cdsNFS.FieldByName('TMSNUM').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ClienteNumeroLogradouro'].Text;
    cdsNFS.FieldByName('TMSCOMPL').AsString := '';
    cdsNFS.FieldByName('TMSBAIR').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ClienteBairro'].Text;
    cdsNFS.FieldByName('TMSMUN').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ClienteCidade'].Text;
    cdsNFS.FieldByName('TMSUF').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ClienteUF'].Text;
    cdsNFS.FieldByName('TMSCEP').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ClienteCEP'].Text;
    cdsNFS.FieldByName('TMSFONE').AsString := '';
    cdsNFS.FieldByName('TMSEMAIL').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ClienteEmail'].Text;

    cdsNFS.FieldByName('ORGMUN').AsString := '';
    cdsNFS.FieldByName('ORG_UF').AsString := '';

    cdsNFS.Post;

    cdsItens.Append;
    cdsItens.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
    cdsItens.FieldByName('ITEDES').AsString := xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ITENS'].ChildNodes['Servico'].Text;
    cdsItens.FieldByName('ITEQTD').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ITENS'].ChildNodes['Quantidade'].Text,'.',','), 0);
    cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ITENS'].ChildNodes['ValorUnitario'].Text,'.',','), 0);
    cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['tbnfd'].ChildNodes['nfdok'].ChildNodes['NewDataSet'].ChildNodes['NOTA_FISCAL'].ChildNodes['ITENS'].ChildNodes['ValorTotal'].Text,'.',','), 0);
    cdsItens.Post;

  Finally
    FreeAndNil(xmlDoc);
  End;

end;

class procedure TSMARAPDXML.pRetornaCDSPreenchidoComENotas(var cdsNFS,
  cdsItens: TUniClientDataSet; strXML: string);
var
  xmlDoc : TXMLDocument;
begin

  xmlDoc := TXMLDocument.Create(Application);

  try

    xmlDoc.LoadFromXML(strXML);
    xmlDoc.Active := True;

    cdsNFS.Append;

    cdsNFS.FieldByName('NUMNFS').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('CODVER').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CodigoVerificacao'].Text;
    cdsNFS.FieldByName('DTAHRA').AsString := Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,12,8);
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,1,4);
    cdsNFS.FieldByName('NUMRPS').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('SERRPS').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
    cdsNFS.FieldByName('TPORPS').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;
    cdsNFS.FieldByName('EMIRPS').AsString := Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,1,4);
    cdsNFS.FieldByName('NATOPE').AsString := '';
    cdsNFS.FieldByName('CODRET').AsString := '';
    cdsNFS.FieldByName('EMIOSN').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['OptanteSimplesNacional'].Text;
    cdsNFS.FieldByName('EMIICC').AsString := '';
    cdsNFS.FieldByName('COMPET').AsString := Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Competencia'].Text,6,2)+'/'+
                                             Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Competencia'].Text,1,4);
    cdsNFS.FieldByName('OUTINF').AsString := '';
    cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
    if (xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['IssRetido'].Text = '2') then
      cdsNFS.FieldByName('ISS_RET').AsFloat := 0
    else
      cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIss'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIss'].Text,'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['Aliquota'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr'].Text,'.',','), 0);
    cdsNFS.FieldByName('CODSER').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
    cdsNFS.FieldByName('CDCNAE').AsString := '';
    cdsNFS.FieldByName('CODTRI').AsString := '';
    cdsNFS.FieldByName('DISCRI').AsString := '';
    cdsNFS.FieldByName('CODMUN').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('ITEDESC').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
    cdsNFS.FieldByName('MUNINC').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['MunicipioIncidencia'].Text;
    cdsNFS.FieldByName('EXIGIB').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['ExigibilidadeISS'].Text;
    cdsNFS.FieldByName('ITEQTD').AsFloat := 1;
    cdsNFS.FieldByName('ITEVLU').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);

    cdsNFS.FieldByName('TMSCNPJ').AsString := iif(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text = '',
                                                  xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                  xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);
    cdsNFS.FieldByName('TMSIM').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['InscricaoMunicipal'].Text;
    cdsNFS.FieldByName('TMSRAZAO').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('TMSEND').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('TMSNUM').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('TMSCOMPL').AsString := '';
    cdsNFS.FieldByName('TMSBAIR').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('TMSMUN').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('TMSUF').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('TMSCEP').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('TMSFONE').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('TMSEMAIL').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['Contato'].ChildNodes['Email'].Text;

    cdsNFS.FieldByName('ORGMUN').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('ORG_UF').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;

    cdsNFS.Post;

    cdsItens.Append;
    cdsItens.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
    cdsItens.FieldByName('ITEDES').AsString := UpperCase(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text);
    cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
    cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsItens.Post;

  Finally
    FreeAndNil(xmlDoc);
  End;

end;

end.
