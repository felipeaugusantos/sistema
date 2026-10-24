unit untAmericanaXML;

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
  TAmericanaXML = class
    public
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string);
  end;
implementation

{ TBadyBassittXML }

class procedure TAmericanaXML.pRetornaCDSPreenchidoComENotas(var cdsNFS,
  cdsItens: TUniClientDataSet; strXML: string);
Var
  NoInfNfse : IXMLDocument;
  strChvAcess : String;
begin
  NoInfNfse := TXMLDocument.Create(Application);

  NoInfNfse.LoadFromXML(strXML);
  NoInfNfse.Active := True;

  strChvAcess := NoInfNfse.ChildNodes['Nfse'].ChildNodes.FindNode('InfNfse').Attributes['Id'];
  cdsNFS.Append;
  cdsNFS.FieldByName('CHANFS').AsString   := strChvAcess;
  cdsNFS.FieldByName('NUMNFS').AsString   := FormatFloat('000000000000', StrToFloatDef(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['Numero'].Text, 0));
  cdsNFS.FieldByName('CODVER').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['CodigoVerificacao'].Text;
  cdsNFS.FieldByName('DTAHRA').AsString   := Copy(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,12,8);
  cdsNFS.FieldByName('DTAEMI').AsString   := Copy(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DataEmissao'].Text,1,4);

  cdsNFS.FieldByName('OUTINF').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['OutrasInformacoes'].Text;

  cdsNFS.FieldByName('BSCISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['BaseCalculo'].Text,'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['Aliquota'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['ValorIss'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['ValoresNfse'].ChildNodes['ValorLiquidoNfse'].Text,'.',','), 0);

  cdsNFS.FieldByName('PSVCNPJ').AsString  := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
  cdsNFS.FieldByName('PSVIM').AsString    := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['IdentificacaoPrestador'].ChildNodes['InscricaoMunicipal'].Text;
  cdsNFS.FieldByName('PSVRAZAO').AsString := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['RazaoSocial'].Text;
  cdsNFS.FieldByName('PSVFANT').AsString  := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['NomeFantasia'].Text;
  cdsNFS.FieldByName('PSVEND').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
  cdsNFS.FieldByName('PSVNUM').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('PSVBAIR').AsString  := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
  cdsNFS.FieldByName('PSVMUN').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('PSVUF').AsString    := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
  cdsNFS.FieldByName('PSVCEP').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
  cdsNFS.FieldByName('PSVEMAIL').AsString := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Email'].Text;
  cdsNFS.FieldByName('FONPRE').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['PrestadorServico'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;

  cdsNFS.FieldByName('NUMRPS').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('SERRPS').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Serie'].Text;
  cdsNFS.FieldByName('TPORPS').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['IdentificacaoRps'].ChildNodes['Tipo'].Text;
  cdsNFS.FieldByName('EMIRPS').AsString   := Copy(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,9,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,6,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Rps'].ChildNodes['DataEmissao'].Text,1,4);

  cdsNFS.FieldByName('COMPET').AsString   := Copy(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Competencia'].Text,9,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Competencia'].Text,6,2)+'/'+
                                             Copy(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Competencia'].Text,1,4);

  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorDeducoes'].Text,'.',','), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoIncondicionado'].Text,'.',','), 0);
  cdsNFS.FieldByName('DESCONC').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['DescontoCondicionado'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorPis'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCofins'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorInss'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorInss'].Text,'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorCsll'].Text,'.',','), 0);
  cdsNFS.FieldByName('OUT_RET').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['OutrasRetencoes'].Text,'.',','), 0);

  cdsNFS.FieldByName('CODTRI').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['CodigoTributacaoMunicipio'].Text;
  cdsNFS.FieldByName('CDCNAE').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['CodigoCnae'].Text;
  cdsNFS.FieldByName('CODSER').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['ItemListaServico'].Text;
  cdsNFS.FieldByName('EXIGIB').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['ExigibilidadeISS'].Text;
  cdsNFS.FieldByName('MUNINC').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['MunicipioIncidencia'].Text;
  cdsNFS.FieldByName('ISSRET').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['IssRetido'].Text;

  if fEmptyStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text) then
    cdsNFS.FieldByName('TMSCNPJ').AsString  := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cpf'].Text
  else
    cdsNFS.FieldByName('TMSCNPJ').AsString  := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['IdentificacaoTomador'].ChildNodes['CpfCnpj'].ChildNodes['Cnpj'].Text;
  cdsNFS.FieldByName('TMSRAZAO').AsString := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['RazaoSocial'].Text;
  cdsNFS.FieldByName('TMSEND').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Endereco'].Text;
  cdsNFS.FieldByName('TMSNUM').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Numero'].Text;
  cdsNFS.FieldByName('TMSBAIR').AsString  := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Bairro'].Text;
  cdsNFS.FieldByName('TMSMUN').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['CodigoMunicipio'].Text;
  cdsNFS.FieldByName('TMSUF').AsString    := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Uf'].Text;
  cdsNFS.FieldByName('TMSCEP').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Endereco'].ChildNodes['Cep'].Text;
  cdsNFS.FieldByName('TMSFONE').AsString  := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Telefone'].Text;
  cdsNFS.FieldByName('TMSEMAIL').AsString := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Tomador'].ChildNodes['Contato'].ChildNodes['Email'].Text;

  cdsNFS.FieldByName('CODRET').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['RegimeEspecialTributacao'].Text;
  cdsNFS.FieldByName('EMIOSN').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['OptanteSimplesNacional'].Text;
  cdsNFS.FieldByName('EMIICC').AsString   := NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['IncentivoFiscal'].Text;

  cdsNFS.Post;

  cdsItens.Append;
  cdsItens.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
  cdsItens.FieldByName('ITEDES').AsString := AnsiReplaceStr(AnsiReplaceStr(UpperCase(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Discriminacao'].Text), '|', sLineBreak), '.SNSN', sLineBreak);
  cdsItens.FieldByName('ITEQTD').AsFloat  := StrToFloatDef(AnsiReplaceStr('1.00', '.',','),0);
  cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
  cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoInfNfse.ChildNodes['Nfse'].ChildNodes['InfNfse'].ChildNodes['DeclaracaoPrestacaoServico'].ChildNodes['InfDeclaracaoPrestacaoServico'].ChildNodes['Servico'].ChildNodes['Valores'].ChildNodes['ValorServicos'].Text,'.',','), 0);
  cdsItens.FieldByName('UNIDAD').AsString := 'UN';
  cdsItens.Post;

end;

end.
