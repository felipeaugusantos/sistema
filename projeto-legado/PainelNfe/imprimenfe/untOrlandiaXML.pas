unit untOrlandiaXML;

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
  TOrlandiaXML = class
    private
    public

      class function fRetDiscriminacaoServico( strItem: String ): String;
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string);
  end;

implementation

{ TOrlandiaXML }


class function TOrlandiaXML.fRetDiscriminacaoServico(strItem: String): String;
var
  strDiscriminacao: string;
  intLaco: integer;
begin
  result := '';
  if fEmptyStr(strItem) then
    exit;
  for intLaco := 14 to Length(strItem)-1 do
  begin
    if (Copy(strItem,intLaco,1) <> ']') then
    begin
      strDiscriminacao := strDiscriminacao + Copy(strItem,intLaco,1) ;
    end
    else
    begin
      break;
    end;
  end;
  result := strDiscriminacao;
end;

class procedure TOrlandiaXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML: string);
var
  xmlDoc : TXMLDocument;
  begin
    xmlDoc := TXMLDocument.Create(Application);
    try
      xmlDoc.LoadFromXML(strXML);
      xmlDoc.Active := True;

      cdsNFS.Append;


      cdsNFS.FieldByName('NUMNFS').AsString := fStrZero(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Numero'].Text, 8);
      cdsNFS.FieldByName('DTAEMI').AsString := Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                               Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                               Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,1,4);

      cdsNFS.FieldByName('DTAHRA').AsString := Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,12,8);
      cdsNFS.FieldByName('CODVER').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CodigoVerificacao'].Text;

      cdsNFS.FieldByName('PSVCNPJ').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['Cnpj'].Text;
      cdsNFS.FieldByName('PSVIM').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
      cdsNFS.FieldByName('PSVRAZAO').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
      cdsNFS.FieldByName('PSVFANT').AsString := '';
      cdsNFS.FieldByName('PSVEND').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
      cdsNFS.FieldByName('PSVNUM').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('PSVCOMPL').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
      cdsNFS.FieldByName('PSVBAIR').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
      cdsNFS.FieldByName('PSVMUN').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
      cdsNFS.FieldByName('PSVUF').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
      cdsNFS.FieldByName('PSVCEP').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
      cdsNFS.FieldByName('PSVFONE').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
      cdsNFS.FieldByName('PSVEMAIL').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;

      cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text),
                                                              xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text,
                                                              xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text);
      cdsNFS.FieldByName('TMSIM').AsString := '';
      cdsNFS.FieldByName('TMSRAZAO').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['RazaoSocial'].Text;
      cdsNFS.FieldByName('TMSEND').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
      cdsNFS.FieldByName('TMSNUM').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
      cdsNFS.FieldByName('TMSCOMPL').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
      cdsNFS.FieldByName('TMSBAIR').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
      cdsNFS.FieldByName('TMSMUN').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
      cdsNFS.FieldByName('TMSUF').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
      cdsNFS.FieldByName('TMSCEP').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;

      cdsNFS.FieldByName('TMSFONE').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
      cdsNFS.FieldByName('TMSEMAIL').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['TomadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;

      cdsNFS.FieldByName('DISCRI').AsString := fRetDiscriminacaoServico(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text);
      cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIss'].Text,'.',','), 0);
      cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
      cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['Aliquota'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
      cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoCondicionado'].Text,'.',','), 0);
      cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoIncondicionado'].Text,'.',','), 0);
      cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes'].Text,'.',','), 0);
      cdsNFS.FieldByName('VALPIS').AsFloat := 0;
      cdsNFS.FieldByName('VALCOF').AsFloat := 0;
      cdsNFS.FieldByName('VALIRR').AsFloat := 0;
      cdsNFS.FieldByName('VALINS').AsFloat := 0;
      cdsNFS.FieldByName('VALCSL').AsFloat := 0;
      cdsNFS.FieldByName('OUT_RET').AsFloat := 0;

      cdsNFS.FieldByName('CODSER').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
      cdsNFS.FieldByName('NATOPE').AsString := '';
      cdsNFS.FieldByName('MUNPRE').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoIncondicionado'].Text;

      cdsNFS.FieldByName('NUMPAR').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CondicaoPagamento'].ChildNodes['Parcelas'].ChildNodes['Parcela'].Text;
      cdsNFS.FieldByName('CONDPA').AsString := xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CondicaoPagamento'].ChildNodes['Condicao'].Text;
      cdsNFS.FieldByName('VENCTO').AsString := Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CondicaoPagamento'].ChildNodes['Parcelas'].ChildNodes['DataVencimento'].Text,9,2)+'/'+
                                               Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CondicaoPagamento'].ChildNodes['Parcelas'].ChildNodes['DataVencimento'].Text,6,2)+'/'+
                                               Copy(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CondicaoPagamento'].ChildNodes['Parcelas'].ChildNodes['DataVencimento'].Text,1,4);
      cdsNFS.FieldByName('VALPAR').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CondicaoPagamento'].ChildNodes['Parcelas'].ChildNodes['Valor'].Text,'.',','), 0);

      cdsNFS.Post;

    finally
      FreeAndNil(xmlDoc);
    end;


  End;
end.
