unit untProvEloTech;

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
  TProvEloTech = class

    private
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string;
        strNumDoc, strCodEmp, strEspDoc: string; cdsItens : TUniClientDataSet=nil; ATipoNFS: TTipoNFS = nfsXML;
        strCidNfse: String = '');
    end;

implementation

class procedure TProvEloTech.pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string;
  strNumDoc, strCodEmp, strEspDoc: string; cdsItens : TUniClientDataSet=nil; ATipoNFS: TTipoNFS = nfsXML;
  strCidNfse: String = '');

  function fTrataXml(strXML: String): String;
  begin
    Result := ReplaceStr(strXML, '<Email>n', '<Email>N');
    Result := ReplaceStr(Result, '>n', '>');
    Result := ReplaceStr(Result, 'E#13;nE#13;n-<', '<');
    Result := Trim(Result);
  End;

var
  xmlDoc: TXMLDocument;
  XmlNodeInfNfse: IXMLNode;
  XMLInfDeclaracaoPrestacaoServico: IXMLNode;
  XMLPrestadorServico: IXMLNode;
  XMLTomadorServico:  IXMLNode;
  XMLValores: IXMLNode;
  XMLItensServicos: IXMLNode;
begin

  xmlDoc := TXMLDocument.Create(Application);

  try

    xmlDoc.LoadFromXML(fTrataXml(strXML));
    xmlDoc.Active := True;

    XmlNodeInfNfse                   := XmlDoc.ChildNodes['CompNfse']
                                              .ChildNodes['Nfse']
                                              .ChildNodes['InfNfse'];
    XMLInfDeclaracaoPrestacaoServico := XmlNodeInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].
                                                       ChildNodes['InfDeclaracaoPrestacaoServico'];
    XMLPrestadorServico              := XmlNodeInfNfse.ChildNodes['PrestadorServico'];
    XMLTomadorServico                := XmlNodeInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].
                                                       ChildNodes['InfDeclaracaoPrestacaoServico'].
                                                       ChildNodes['Tomador'];
    XMLValores                       := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico']
                                                                        .ChildNodes['Valores'];
    XMLItensServicos                 := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico']
                                                                        .ChildNodes['ListaItensServico']
                                                                        .ChildNodes['ItemServico'];
    cdsNFS.Append;

    cdsNFS.FieldByName('NUMNFS').AsString := XmlNodeInfNfse.ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('SERIE').AsString  := 'NFS';
    cdsNFS.FieldByName('CODVER').AsString := XmlNodeInfNfse.ChildNodes['CodigoVerificacao'].Text;
    cdsNFS.FieldByName('DTAHRA').AsString := Copy(XmlNodeInfNfse.ChildNodes['DataEmissao'].Text, 12, 8);
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(XmlNodeInfNfse.ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(XmlNodeInfNfse.ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(XmlNodeInfNfse.ChildNodes['DataEmissao'].Text,1,4);
    cdsNFS.FieldByName('COMPET').AsString := Copy(XmlNodeInfNfse.ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(XmlNodeInfNfse.ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(XmlNodeInfNfse.ChildNodes['DataEmissao'].Text,1,4);
    cdsNFS.FieldByName('NUMRPS').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('SERRPS').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
    cdsNFS.FieldByName('TPORPS').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;
    cdsNFS.FieldByName('EMIRPS').AsString := Copy(XMLInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(XMLInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(XMLInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,1,4)+' '+
                                             Copy(XMLInfDeclaracaoPrestacaoServico.ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,12,8);
    cdsNFS.FieldByName('NATOPE').AsString := '';
    cdsNFS.FieldByName('CODRET').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['RegimeEspecialTributacao'].Text;
    cdsNFS.FieldByName('EMIOSN').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['OptanteSimplesNacional'].Text;
    cdsNFS.FieldByName('EMIICC').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['IncentivoFiscal'].Text;
    cdsNFS.FieldByName('COMPET').AsString := Copy(XMLInfDeclaracaoPrestacaoServico.ChildNodes['Competencia'].Text,1,10);
    cdsNFS.FieldByName('NFSSUB').AsString := '';
    cdsNFS.FieldByName('OUTINF').AsString := '';
    cdsNFS.FieldByName('CODSER').AsString := XMLItensServicos.ChildNodes['ItemListaServico'].Text;
    cdsNFS.FieldByName('CDCNAE').AsString := XMLItensServicos.ChildNodes['CodigoCnae'].Text;
    cdsNFS.FieldByName('CODTRI').AsString := '';
    cdsNFS.FieldByName('EXIISS').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['ExigibilidadeISS'].Text;
    cdsNFS.FieldByName('DISCRI').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
    cdsNFS.FieldByName('MUNPRE').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('VLRSER').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRDED').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorDeducoes'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRPIS').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorPis'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRCOF').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorCofins'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRINS').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorInss'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRIR_').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorIr'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRCSL').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorCsll'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRCPP').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorCpp'].Text,'.',','), 0);
    cdsNFS.FieldByName('RETPIS').AsString := XMLValores.ChildNodes['RetidoPis'].Text;
    cdsNFS.FieldByName('RETCFS').AsString := XMLValores.ChildNodes['RetidoCofins'].Text;
    cdsNFS.FieldByName('RETINS').AsString := XMLValores.ChildNodes['RetidoInss'].Text;
    cdsNFS.FieldByName('RETIR_').AsString := XMLValores.ChildNodes['RetidoIr'].Text;
    cdsNFS.FieldByName('RETCSL').AsString := XMLValores.ChildNodes['RetidoCsll'].Text;
    cdsNFS.FieldByName('RETCPP').AsString := XMLValores.ChildNodes['RetidoCpp'].Text;
    cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['IssRetido'].Text,'.',','), 0);
    cdsNFS.FieldByName('MUNINC').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['MunicipioIncidencia'].Text;
    cdsNFS.FieldByName('OUT_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['OutrasRetencoes'].Text,'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(XmlNodeInfNfse.ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(XmlNodeInfNfse.ChildNodes['ValoresNfse'].ChildNodes['Aliquota'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat  := StrToFloatDef(AnsiReplaceStr(XmlNodeInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(XmlNodeInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorIss'].Text,'.',','), 0);
    cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['DescontoCondicionado'].Text,'.',','), 0);
    cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['DescontoIncondicionado'].Text,'.',','), 0);
    cdsNFS.FieldByName('PSVCNPJ').AsString := XMLPrestadorServico.ChildNodes['IdentificacaoPrestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
    cdsNFS.FieldByName('PSVIM').AsString   := XMLPrestadorServico.ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
    cdsNFS.FieldByName('IEPRES').AsString  := '';
    cdsNFS.FieldByName('PSVRAZAO').AsString := XMLPrestadorServico.ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('PSVFANT').AsString  := XMLPrestadorServico.ChildNodes['NomeFantasia'].Text;
    cdsNFS.FieldByName('PSVEND').AsString   := XMLPrestadorServico.ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('PSVNUM').AsString   := XMLPrestadorServico.ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('PSVCOMPL').AsString := XMLPrestadorServico.ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
    cdsNFS.FieldByName('PSVBAIR').AsString  := XMLPrestadorServico.ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('PSVMUN').AsString   := XMLPrestadorServico.ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('PSVUF').AsString    := XMLPrestadorServico.ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('PSVCEP').AsString   := XMLPrestadorServico.ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('PSVFONE').AsString  := XMLPrestadorServico.ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('PSVEMAIL').AsString := XMLPrestadorServico.ChildNodes['Contato'].ChildNodes['Email'].Text;
    cdsNFS.FieldByName('TMSCNPJ').AsString  := Iif(fEmptyStr(XMLTomadorServico.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text),
                                                             XMLTomadorServico.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text,
                                                             XMLTomadorServico.ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text);
    cdsNFS.FieldByName('TMSRAZAO').AsString := XMLTomadorServico.ChildNodes['RazaoSocial'].Text;
    cdsNFS.FieldByName('TMSIM').AsString    := '';
    cdsNFS.FieldByName('TMSEND').AsString   := XMLTomadorServico.ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
    cdsNFS.FieldByName('TMSNUM').AsString   := XMLTomadorServico.ChildNodes['Endereco'].ChildNodes['Numero'].Text;
    cdsNFS.FieldByName('TMSCOMPL').AsString := XMLTomadorServico.ChildNodes['Endereco'].ChildNodes['Complemento'].Text;
    cdsNFS.FieldByName('TMSBAIR').AsString  := XMLTomadorServico.ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
    cdsNFS.FieldByName('TMSMUN').AsString   := XMLTomadorServico.ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('TMSUF').AsString    := XMLTomadorServico.ChildNodes['Endereco'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('TMSCEP').AsString   := XMLTomadorServico.ChildNodes['Endereco'].ChildNodes['Cep'].Text;
    cdsNFS.FieldByName('TMSFONE').AsString  := XMLTomadorServico.ChildNodes['Contato'].ChildNodes['Telefone'].Text;
    cdsNFS.FieldByName('TMSEMAIL').AsString := XMLTomadorServico.ChildNodes['Contato'].ChildNodes['Email'].Text;
    cdsNFS.FieldByName('ORGMUN').AsString   := XmlNodeInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['CodigoMunicipio'].Text;
    cdsNFS.FieldByName('ORG_UF').AsString   := XmlNodeInfNfse.ChildNodes['OrgaoGerador'].ChildNodes['Uf'].Text;
    cdsNFS.FieldByName('RESPTRIB').AsString := 'P';
    cdsNFS.FieldByName('OBSERV').AsString   := XmlNodeInfNfse.ChildNodes['observacoes'].Text;
    cdsNFS.Post;

    cdsItens.Append;
    cdsItens.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
    cdsItens.FieldByName('ITEDES').AsString := XMLInfDeclaracaoPrestacaoServico.ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
    cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
    cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(XMLValores.ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsItens.Post;

  finally
      FreeAndNil(xmlDoc);
  end;
end;

end.
