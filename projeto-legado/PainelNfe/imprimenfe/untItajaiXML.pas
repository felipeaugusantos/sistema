unit untItajaiXML;

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
  TItajaiXML = class
    private
    public
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string);
  end;

implementation

{ TItajaíXML }

class procedure TItajaiXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML: string);
var
  xmlDoc : TXMLDocument;
  begin
    xmlDoc := TXMLDocument.Create(Application);
    try
      xmlDoc.LoadFromXML(strXML);
      xmlDoc.Active := True;

      cdsNFS.Append;

      //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS
      cdsNFS.FieldByName('NUMNFS').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('SERIE_').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Serie'].Text;
      cdsNFS.FieldByName('CODVER').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CodigoVerificacao'].Text;

      cdsNFS.FieldByName('DTAHRA').AsString   := Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,12,8);
      cdsNFS.FieldByName('DTAEMI').AsString   := Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,1,4);

      cdsNFS.FieldByName('DTARPS').AsString   := Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissaoRps'].Text,9,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissaoRps'].Text,6,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissaoRps'].Text,1,4);

      cdsNFS.FieldByName('NUMRPS').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('SERRPS').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
      cdsNFS.FieldByName('TPORPS').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;

      cdsNFS.FieldByName('NATOPE').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['NaturezaOperacao'].Text;
      cdsNFS.FieldByName('OPTASN').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OptanteSimplesNacional'].Text;
      cdsNFS.FieldByName('INCCUL').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['IncentivadorCultural'].Text;

      cdsNFS.FieldByName('DTACMP').AsString   := Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Competencia'].Text,6,2)+'/'+
                                                 Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Competencia'].Text,1,4);

      cdsNFS.FieldByName('OUTINF').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OutrasInformacoes'].Text;

      // Serviços
      cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorInss'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALIRR').AsFloat    := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIss'].Text,'.',','), 0);
      cdsNFS.FieldByName('BSCISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
      cdsNFS.FieldByName('ALIISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['Aliquota'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
      cdsNFS.FieldByName('DESCONI').AsFloat   := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoIncondicionado'].Text,'.',','), 0);
      cdsNFS.FieldByName('OUT_RET').AsFloat   := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['OutrasRetencoes'].Text,'.',','), 0);
      cdsNFS.FieldByName('DESCONC').AsFloat   := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoCondicionado'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLISRT').AsFloat    := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIssRetido'].Text,'.',','), 0);

      cdsNFS.FieldByName('CODSER').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
      cdsNFS.FieldByName('ORGMUN').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
      cdsNFS.FieldByName('DISCRI').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
      cdsNFS.FieldByName('INFCOM').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['InformacoesComplementares'].Text;
      // Prestador
      cdsNFS.FieldByName('PSVCNPJ').AsString  := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['Cnpj'].Text;
      cdsNFS.FieldByName('PSVIM').AsString    := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
      cdsNFS.FieldByName('PSVRAZAO').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
      cdsNFS.FieldByName('PSVNMFA').AsString  := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia'].Text;
      cdsNFS.FieldByName('PSVEND').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
      cdsNFS.FieldByName('PSVNUM').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('PSVBAIR').AsString  := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
      cdsNFS.FieldByName('PSVMUN').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
      cdsNFS.FieldByName('PSVUF').AsString    := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
      cdsNFS.FieldByName('PSVCEP').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
      cdsNFS.FieldByName('PSVCOMPL').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
      cdsNFS.FieldByName('PSVEMAIL').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;
      cdsNFS.FieldByName('PSVFONE').AsString  := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
      // Tomador
      cdsNFS.FieldByName('TMSCNPJ').AsString  := Iif(fEmptyStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                               xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                               xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);

      cdsNFS.FieldByName('TMSRAZAO').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['RazaoSocial'].Text;
      cdsNFS.FieldByName('TMSNMFA').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['NomeFantasia'].Text;

      cdsNFS.FieldByName('TMSEND').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
      cdsNFS.FieldByName('TMSNUM').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('TMSBAIR').AsString  := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
      cdsNFS.FieldByName('TMSMUN').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
      cdsNFS.FieldByName('TMSUF').AsString    := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
      cdsNFS.FieldByName('TMSCEP').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
      cdsNFS.FieldByName('TMSCDPAIS').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoPais'].Text;

      cdsNFS.FieldByName('TMSEMAIL').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;
      cdsNFS.FieldByName('TMSFONE').AsString  := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
      cdsNFS.FieldByName('TMSIM').AsString    := '';

      // Orgão Gerador
      cdsNFS.FieldByName('ORGMUN').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
      cdsNFS.FieldByName('ORG_UF').AsString   := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;

      cdsNFS.Post;

    finally
      FreeAndNil(xmlDoc);
    end;
  End;
end.
