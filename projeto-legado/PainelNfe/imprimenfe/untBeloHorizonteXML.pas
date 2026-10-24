unit untBeloHorizonteXML;

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
  TBeloHorizonteXML = class
    private
      class procedure fNoinfNFSe(var ANoElementoOri, ANoElementoDest: IXMLNode);
      class procedure fNoIdenRps(var ANoElementoOri, ANoElementoDest: IXMLNode);
      class procedure fNoServico(var ANoElementoOri, ANoElementoDest: IXMLNode);
      class procedure fNoServValores(var ANoElementoOri, ANoElementoDest: IXMLNode);
      class procedure fNoPrestServ(var ANoElementoOri, ANoElementoDest: IXMLNode);
      class procedure fNoTomador(var ANoElementoOri, ANoElementoDest: IXMLNode);
      class procedure fNoElemento(var AXmlDoc: IXMLDocument; var ANoElementoDest: IXMLNode);
    public
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);
    end;

const
  ns2 = 'http://www.abrasf.org.br/nfse.xsd';

implementation

{ TBeloHorizonteXML }

class procedure TBeloHorizonteXML.fNoElemento(var AXmlDoc: IXMLDocument; var ANoElementoDest: IXMLNode);
begin
  ANoElementoDest := AXmlDoc.DocumentElement;
end;

class procedure TBeloHorizonteXML.fNoIdenRps(var ANoElementoOri, ANoElementoDest: IXMLNode);
begin
  If ANoElementoOri <> Nil Then
    ANoElementoDest := ANoElementoOri.ChildNodes.FindNode('IdentificacaoRps',ns2);
end;

class procedure TBeloHorizonteXML.fNoinfNFSe(var ANoElementoOri, ANoElementoDest: IXMLNode);
begin
  If ANoElementoOri <> Nil Then
  Begin
    ANoElementoDest := ANoElementoOri.ChildNodes.FindNode('Nfse')
                                     .ChildNodes.FindNode('InfNfse');
    ANoElementoDest.ChildNodes.First;
  End;
end;

class procedure TBeloHorizonteXML.fNoPrestServ(var ANoElementoOri, ANoElementoDest: IXMLNode);
begin
  If ANoElementoOri <> Nil Then
    ANoElementoDest := ANoElementoOri.ChildNodes.FindNode('PrestadorServico',ns2);
end;

class procedure TBeloHorizonteXML.fNoServico(var ANoElementoOri, ANoElementoDest: IXMLNode);
begin
  If ANoElementoOri <> Nil Then
    ANoElementoDest := ANoElementoOri.ChildNodes.FindNode('Servico',ns2);
end;

class procedure TBeloHorizonteXML.fNoServValores(var ANoElementoOri, ANoElementoDest: IXMLNode);
begin
  If ANoElementoOri <> Nil Then
    ANoElementoDest := ANoElementoOri.ChildNodes.FindNode('Valores',ns2);
end;

class procedure TBeloHorizonteXML.fNoTomador(var ANoElementoOri, ANoElementoDest: IXMLNode);
begin
  If ANoElementoOri <> Nil Then
    ANoElementoDest := ANoElementoOri.ChildNodes.FindNode('TomadorServico',ns2);
end;

class procedure TBeloHorizonteXML.pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);
var
  LXmlDoc: IXMLDocument;

  LNoElemento,
  LNoinfNFSe,
  LNoIdenRps,
  LNoServico,
  LNoServValores,
  LNoPrestServ,
  LNoTomador: IXMLNode;

  strNumero: String;
begin
  LXmlDoc := TXMLDocument.Create(Application);
  LXmlDoc.LoadFromXML(strXML);
  LXmlDoc.Active := True;
  LXmlDoc.ChildNodes.First;

  fNoElemento(LXmlDoc, LNoElemento);
  fNoinfNFSe(LNoElemento,LNoinfNFSe);
  fNoIdenRps(LNoinfNFSe,LNoIdenRps);
  fNoServico(LNoinfNFSe,LNoServico);
  fNoServValores(LNoServico,LNoServValores);
  fNoPrestServ(LNoinfNFSe,LNoPrestServ);
  fNoTomador(LNoinfNFSe,LNoTomador);

  cdsNFS.Append;
  // Dados da NFS

  strNumero := LNoinfNFSe.ChildNodes.FindNode('Numero').Text;
  cdsNFS.FieldByName('NUMNFS').AsString := Copy(strNumero, 1, 4) +'/'+
                                           FormatFloat('0', StrToFloatDef(Copy(strNumero, 5, Length(strNumero)),0));

  cdsNFS.FieldByName('CODVER').AsString := LNoinfNFSe.ChildNodes.FindNode('CodigoVerificacao').Text;
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(LNoinfNFSe.ChildNodes.FindNode('DataEmissao').Text, 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(LNoinfNFSe.ChildNodes.FindNode('DataEmissao').Text,9,2)+'/'+
                                           Copy(LNoinfNFSe.ChildNodes.FindNode('DataEmissao').Text,6,2)+'/'+
                                           Copy(LNoinfNFSe.ChildNodes.FindNode('DataEmissao').Text,1,4);

  cdsNFS.FieldByName('NUMRPS').AsString := LNoIdenRps.ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('SERRPS').AsString := LNoIdenRps.ChildNodes['Serie'].Text;
  cdsNFS.FieldByName('TPORPS').AsString := LNoIdenRps.ChildNodes['Tipo'].Text;
  cdsNFS.FieldByName('EMIRPS').AsString := Copy(LNoinfNFSe.ChildNodes['DataEmissaoRps'].Text,9,2)+'/'+
                                           Copy(LNoinfNFSe.ChildNodes['DataEmissaoRps'].Text,6,2)+'/'+
                                           Copy(LNoinfNFSe.ChildNodes['DataEmissaoRps'].Text,1,4);

  cdsNFS.FieldByName('NATOPE').AsString := LNoinfNFSe.ChildNodes['NaturezaOperacao'].Text;
  cdsNFS.FieldByName('EMIOSN').AsString  := LNoinfNFSe.ChildNodes['OptanteSimplesNacional'].Text;
  cdsNFS.FieldByName('EMIICC').AsString  := LNoinfNFSe.ChildNodes['IncentivadorCultural'].Text;

  cdsNFS.FieldByName('COMPET').AsString  := Copy(LNoinfNFSe.ChildNodes['Competencia'].Text,9,2)+'/'+
                                            Copy(LNoinfNFSe.ChildNodes['Competencia'].Text,6,2)+'/'+
                                            Copy(LNoinfNFSe.ChildNodes['Competencia'].Text,1,4);

  cdsNFS.FieldByName('OUTINF').AsString  := StringReplace(LNoinfNFSe.ChildNodes['OutrasInformacoes'].Text, '\s\n', ' |', [rfReplaceAll]);

  //Valores
  cdsNFS.FieldByName('VLRSER').AsFloat   := StrToFloatDef(AnsiReplaceStr(LNoServValores.ChildNodes['ValorServicos'].Text,'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat  := StrToFloatDef(AnsiReplaceStr(LNoServValores.ChildNodes['IssRetido'].Text,'.',','), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat  := StrToFloatDef(AnsiReplaceStr(LNoServValores.ChildNodes['DescontoIncondicionado'].Text,'.',','), 0);
  cdsNFS.FieldByName('DESCONC').AsFloat  := StrToFloatDef(AnsiReplaceStr(LNoServValores.ChildNodes['DescontoCondicionado'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(LNoServValores.ChildNodes['ValorIss'].Text,'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(LNoServValores.ChildNodes['BaseCalculo'].Text,'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(LNoServValores.ChildNodes['Aliquota'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat   := StrToFloatDef(AnsiReplaceStr(LNoServValores.ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat   := StrToFloatDef(AnsiReplaceStr(LNoServValores.ChildNodes['ValorDeducoes'].Text,'.',','), 0);

  cdsNFS.FieldByName('VLRPIS').AsFloat   := StrToFloatDef(AnsiReplaceStr(LNoServValores.ChildNodes['ValorPis'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRCOF').AsFloat   := StrToFloatDef(AnsiReplaceStr(LNoServValores.ChildNodes['ValorCofins'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRINS').AsFloat   := StrToFloatDef(AnsiReplaceStr(LNoServValores.ChildNodes['ValorInss'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRIR_').AsFloat   := StrToFloatDef(AnsiReplaceStr(LNoServValores.ChildNodes['ValorIr'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRCSL').AsFloat   := StrToFloatDef(AnsiReplaceStr(LNoServValores.ChildNodes['ValorCsll'].Text,'.',','), 0);

  cdsNFS.FieldByName('CODSER').AsString  := LNoServico.ChildNodes['ItemListaServico'].Text;
  cdsNFS.FieldByName('CODTRI').AsString  := LNoServico.ChildNodes['CodigoTributacaoMunicipio'].Text;
  cdsNFS.FieldByName('DISCRI').AsString  := LNoServico.ChildNodes['Discriminacao'].Text;
  cdsNFS.FieldByName('CODMUN').AsString  := LNoServico.ChildNodes['CodigoMunicipio'].Text;

  //Prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := LNoPrestServ.ChildNodes['IdentificacaoPrestador'].ChildNodes['Cnpj'].Text;
  cdsNFS.FieldByName('PSVIM').AsString    := LNoPrestServ.ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
  cdsNFS.FieldByName('PSVRAZAO').AsString := LNoPrestServ.ChildNodes['RazaoSocial'].Text;
  cdsNFS.FieldByName('PSVFANT').AsString  := LNoPrestServ.ChildNodes['NomeFantasia'].Text;
  cdsNFS.FieldByName('PSVEND').AsString   := LNoPrestServ.ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
  cdsNFS.FieldByName('PSVNUM').AsString   := LNoPrestServ.ChildNodes['Endereco'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('PSVBAIR').AsString  := LNoPrestServ.ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
  cdsNFS.FieldByName('PSVMUN').AsString   := LNoPrestServ.ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('PSVUF').AsString    := LNoPrestServ.ChildNodes['Endereco'].ChildNodes['Uf'].Text;
  cdsNFS.FieldByName('PSVCEP').AsString   := LNoPrestServ.ChildNodes['Endereco'].ChildNodes['Cep'].Text;
  cdsNFS.FieldByName('PSVFONE').AsString  := LNoPrestServ.ChildNodes['Contato'].ChildNodes['Telefone'].Text;
  cdsNFS.FieldByName('PSVEMAIL').AsString := LNoPrestServ.ChildNodes['Contato'].ChildNodes['Email'].Text;

  //Tomador
  cdsNFS.FieldByName('TMSCNPJ').AsString  := IIF(fEmptyStr(LNoTomador.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text),
                                                           LNoTomador.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text,
                                                           LNoTomador.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text);

  cdsNFS.FieldByName('TMSRAZAO').AsString := LNoTomador.ChildNodes['RazaoSocial'].Text;
  cdsNFS.FieldByName('TMSFANTA').AsString := LNoTomador.ChildNodes['IdentificacaoTomador'].ChildNodes['NomeFantasia'].Text;
  cdsNFS.FieldByName('TMSEND').AsString   := LNoTomador.ChildNodes['IdentificacaoTomador'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
  cdsNFS.FieldByName('TMSNUM').AsString   := LNoTomador.ChildNodes['Endereco'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('TMSCOMPL').AsString := LNoTomador.ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
  cdsNFS.FieldByName('TMSBAIR').AsString  := LNoTomador.ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
  cdsNFS.FieldByName('TMSMUN').AsString   := LNoTomador.ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('TMSUF').AsString    := LNoTomador.ChildNodes['Endereco'].ChildNodes['Uf'].Text;
  cdsNFS.FieldByName('TMSCEP').AsString   := LNoTomador.ChildNodes['Endereco'].ChildNodes['Cep'].Text;
  cdsNFS.FieldByName('TMSFONE').AsString  := LNoTomador.ChildNodes['Contato'].ChildNodes['Telefone'].Text;
  cdsNFS.FieldByName('TMSEMAIL').AsString := LNoTomador.ChildNodes['Contato'].ChildNodes['Email'].Text;

  cdsNFS.Post;
end;

end.
