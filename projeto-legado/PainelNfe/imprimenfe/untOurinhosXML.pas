unit untOurinhosXML;

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
  TOurinhosXML = class

    private

    public

      class function fNoElemento(strXML: string): IXMLNode;
      class function fNoInfNfse(NoNfse: IXMLNode): IXMLNode;
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; cdsItens : TUniClientDataSet=nil);

  end;

implementation

class function TOurinhosXML.fNoElemento(strXML: string): IXMLNode;
var
  XmlDoc : IXMLDocument;
begin

  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;

  Result := XmlDoc.DocumentElement;

end;

class function TOurinhosXML.fNoInfNfse(NoNfse: IXMLNode): IXMLNode;
begin
  If NoNfse <> Nil then
    Result := NoNfse.ChildNodes.FindNode('InfNfse');
end;

class procedure TOurinhosXML.pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string;  cdsItens: TUniClientDataSet);
var
  XmlDoc : IXMLDocument;
  NoElemento,
  NoInfNfse : IXMLNode;

begin

  NoElemento := fNoElemento(strXML);
  NoInfNfse  := fNoInfNfse(NoElemento);

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
    cdsNFS.FieldByName('HRAEMI').AsString := Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,12,8);

    cdsNFS.FieldByName('NUMRPS').AsString := '';
    cdsNFS.FieldByName('SERRPS').AsString := '';
    cdsNFS.FieldByName('TPORPS').AsString := '';

    cdsNFS.FieldByName('EMIRPS').AsString := '';
    cdsNFS.FieldByName('NATOPE').AsString := '';
    cdsNFS.FieldByName('CODRET').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['RegimeEspecialTributacao'].Text;
    cdsNFS.FieldByName('EMIOSN').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['OptanteSimplesNacional'].Text;
    cdsNFS.FieldByName('OUTINF').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['InformacoesComplementares'].Text;
    cdsNFS.FieldByName('EMIICC').AsString := '';
    cdsNFS.FieldByName('COMPET').AsString := Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes['DataEmissao'].Text,1,4);
    cdsNFS.FieldByName('ISSRET').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['IssRetido'].Text;

    //SERVIÇOS
    cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
    cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['IssRetido'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIss'].Text,'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['Aliquota'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIssRetido'].Text,'.',','), 0);

    cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorIr'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorInss'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);

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

    // CONSTRUÇÃO CIVIL
    cdsNFS.FieldByName('CODOBR').AsString := '';
    cdsNFS.FieldByName('CODART').AsString := '';

    cdsNFS.Post;

    if Assigned(cdsItens) then
    begin
      cdsItens.Append;
      cdsItens.FieldByName('NUMNFS').AsString := NoInfNfse.ChildNodes['Numero'].Text;
      cdsItens.FieldByName('ITEDES').AsString := NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text;
      cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
      cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
      cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);
      cdsItens.Post;
    end;

  End;

end;

end.
