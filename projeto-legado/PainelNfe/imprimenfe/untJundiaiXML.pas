unit untJundiaiXML;

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
  TJundiaiXML = class

    public

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

implementation

class procedure TJundiaiXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string;
  cdsItens: TUniClientDataSet);
var
  prefixo,
  IdentificacaoNfse,
  IdentificacaoRps,
  Servico,
  Valores,
  PrestadorServico,
  IdentificacaoPrestador,
  Endereco,
  Contato,
  TomadorServico,
  IdentificacaoTomador,
  OrgaoGerador,
  CpfCnpj,
  strCodtri : string;
begin
  prefixo := '';

  //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS

  cdsNFS.Append;

  IdentificacaoNfse := RetornaTexto(strXML, '<'+prefixo+'Nfse>', '</'+prefixo+'Nfse>');
  cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(IdentificacaoNfse, '<'+prefixo+'Numero>', '</'+prefixo+'Numero>');
  cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(IdentificacaoNfse, '<'+prefixo+'CodigoVerificacao>', '</'+prefixo+'CodigoVerificacao>');


  cdsNFS.FieldByName('DTAHRA').AsString := RetornaTexto(strXML, '<'+prefixo+'DataEmissao>', '</'+prefixo+'DataEmissao>');
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(RetornaTexto(strXML, '<'+prefixo+'DataEmissao>', '</'+prefixo+'DataEmissao>'),9,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<'+prefixo+'DataEmissao>', '</'+prefixo+'DataEmissao>'),6,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<'+prefixo+'DataEmissao>', '</'+prefixo+'DataEmissao>'),1,4);

  IdentificacaoRps := RetornaTexto(strXML, '<'+prefixo+'IdentificacaoRps>', '</'+prefixo+'IdentificacaoRps>');
  cdsNFS.FieldByName('NUMRPS').AsString := RetornaTexto(IdentificacaoRps, '<'+prefixo+'Numero>', '</'+prefixo+'Numero>');
  cdsNFS.FieldByName('SERRPS').AsString := RetornaTexto(IdentificacaoRps, '<'+prefixo+'Serie>', '</'+prefixo+'Serie>');
  cdsNFS.FieldByName('TPORPS').AsString := RetornaTexto(IdentificacaoRps, '<'+prefixo+'Tipo>', '</'+prefixo+'Tipo>');

  cdsNFS.FieldByName('EMIRPS').AsString := RetornaTexto(strXML, '<'+prefixo+'DataEmissaoRps>', '</'+prefixo+'DataEmissaoRps>');
  cdsNFS.FieldByName('NATOPE').AsString := RetornaTexto(strXML, '<'+prefixo+'NaturezaOperacao>', '</'+prefixo+'NaturezaOperacao>');
  cdsNFS.FieldByName('CODRET').AsString := RetornaTexto(strXML, '<'+prefixo+'RegimeEspecialTributacao>', '</'+prefixo+'RegimeEspecialTributacao>');
  cdsNFS.FieldByName('EMIOSN').AsString := RetornaTexto(strXML, '<'+prefixo+'OptanteSimplesNacional>', '</'+prefixo+'OptanteSimplesNacional>');
  cdsNFS.FieldByName('EMIICC').AsString := RetornaTexto(strXML, '<'+prefixo+'IncetivadorCultural>', '</'+prefixo+'IncetivadorCultural>');
  cdsNFS.FieldByName('COMPET').AsString := Copy(RetornaTexto(strXML, '<'+prefixo+'Competencia>', '</'+prefixo+'Competencia>'),9,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<'+prefixo+'Competencia>', '</'+prefixo+'Competencia>'),6,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<'+prefixo+'Competencia>', '</'+prefixo+'Competencia>'),1,4);
  //SERVIÇOS
  Servico := RetornaTexto(strXML, '<'+prefixo+'Servico>', '</'+prefixo+'Servico>');
  Valores := RetornaTexto(Servico, '<'+prefixo+'Valores>', '</'+prefixo+'Valores>');
  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<'+prefixo+'ValorServicos>', '</'+prefixo+'ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<'+prefixo+'IssRetido>', '</'+prefixo+'IssRetido>'),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<'+prefixo+'ValorIss>', '</'+prefixo+'ValorIss>'),'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<'+prefixo+'BaseCalculo>', '</'+prefixo+'BaseCalculo>'),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<'+prefixo+'Aliquota>', '</'+prefixo+'Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<'+prefixo+'ValorIssRetido>', '</'+prefixo+'ValorIssRetido>'),'.',','), 0);

  cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<'+prefixo+'ValorPis>', '</'+prefixo+'ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<'+prefixo+'ValorCofins>', '</'+prefixo+'ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<'+prefixo+'ValorIr>', '</'+prefixo+'ValorIr>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<'+prefixo+'ValorInss>', '</'+prefixo+'ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<'+prefixo+'ValorCsll>', '</'+prefixo+'ValorCsll>'),'.',','), 0);
  if (StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<'+prefixo+'ValorLiquidoNfse>', '</'+prefixo+'ValorLiquidoNfse>'),'.',','), 0) = 0) then
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<'+prefixo+'ValorServicos>', '</'+prefixo+'ValorServicos>'),'.',','), 0)
  else
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<'+prefixo+'ValorLiquidoNfse>', '</'+prefixo+'ValorLiquidoNfse>'),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString := RetornaTexto(Servico, '<'+prefixo+'ItemListaServico>', '</'+prefixo+'ItemListaServico>');

  cdsNFS.FieldByName('CODTRI').AsString := RetornaTexto(Servico, '<'+prefixo+'CodigoTributacaoMunicipio>', '</'+prefixo+'CodigoTributacaoMunicipio>');
  cdsNFS.FieldByName('DISCRI').AsString := RetornaTexto(Servico, '<'+prefixo+'Discriminacao>', '</'+prefixo+'Discriminacao>');
  cdsNFS.FieldByName('CODMUN').AsString := RetornaTexto(Servico, '<'+prefixo+'MunicipioPrestacaoServico>', '</'+prefixo+'MunicipioPrestacaoServico>');

  //PRESTADOR DO SERVIÇO
  PrestadorServico := RetornaTexto(strXML, '<'+prefixo+'PrestadorServico>', '</'+prefixo+'PrestadorServico>');
  IdentificacaoPrestador := RetornaTexto(PrestadorServico, '<'+prefixo+'IdentificacaoPrestador>', '</'+prefixo+'IdentificacaoPrestador>');
  cdsNFS.FieldByName('PSVCNPJ').AsString := RetornaTexto(IdentificacaoPrestador, '<'+prefixo+'Cnpj>', '</'+prefixo+'Cnpj>');
  cdsNFS.FieldByName('PSVIM').AsString := RetornaTexto(IdentificacaoPrestador, '<'+prefixo+'InscricaoMunicipal>', '</'+prefixo+'InscricaoMunicipal>');

  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(PrestadorServico, '<'+prefixo+'RazaoSocial>', '</'+prefixo+'RazaoSocial>');

  cdsNFS.FieldByName('PSVEND').AsString := StringReplace(RetornaTexto(PrestadorServico, '<'+prefixo+'Endereco>', '</'+prefixo+'Endereco>'), '<'+prefixo+'Endereco>', '', [rfReplaceAll]);
  cdsNFS.FieldByName('PSVNUM').AsString := RetornaTexto(PrestadorServico, '<'+prefixo+'Numero>', '</'+prefixo+'Numero>');
  cdsNFS.FieldByName('PSVBAIR').AsString := RetornaTexto(PrestadorServico, '<'+prefixo+'Bairro>', '</'+prefixo+'Bairro>');
  cdsNFS.FieldByName('PSVMUN').AsString := RetornaTexto(PrestadorServico, '<'+prefixo+'CodigoMunicipio>', '</'+prefixo+'CodigoMunicipio>');
  cdsNFS.FieldByName('PSVUF').AsString := RetornaTexto(PrestadorServico, '<'+prefixo+'Estado>', '</'+prefixo+'Estado>');
  cdsNFS.FieldByName('PSVCEP').AsString := RetornaTexto(PrestadorServico, '<'+prefixo+'Cep>', '</'+prefixo+'Cep>');

  Contato := RetornaTexto(PrestadorServico, '<'+prefixo+'Contato>', '</'+prefixo+'Contato>');
  cdsNFS.FieldByName('PSVFONE').AsString := RetornaTexto(Contato, '<'+prefixo+'Telefone>', '</'+prefixo+'Telefone>');
  cdsNFS.FieldByName('PSVEMAIL').AsString := RetornaTexto(Contato, '<'+prefixo+'Email>', '</'+prefixo+'Numero>');

  //TOMADOR DO SERVIÇO
  TomadorServico := RetornaTexto(strXML, '<'+prefixo+'TomadorServico>', '</'+prefixo+'TomadorServico>');
  IdentificacaoTomador := RetornaTexto(TomadorServico, '<'+prefixo+'IdentificacaoTomador>', '</'+prefixo+'IdentificacaoTomador>');
  CpfCnpj := RetornaTexto(IdentificacaoTomador, '<'+prefixo+'CpfCnpj>', '</'+prefixo+'CpfCnpj>');
  cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(RetornaTexto(CpfCnpj, '<'+prefixo+'Cnpj>', '</'+prefixo+'Cnpj>')),
                                                          RetornaTexto(CpfCnpj, '<'+prefixo+'Cpf>', '</'+prefixo+'Cpf>'),
                                                          RetornaTexto(CpfCnpj, '<'+prefixo+'Cnpj>', '</'+prefixo+'Cnpj>'));

  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(TomadorServico, '<'+prefixo+'RazaoSocial>', '</'+prefixo+'RazaoSocial>');

  cdsNFS.FieldByName('TMSEND').AsString := StringReplace(RetornaTexto(TomadorServico, '<'+prefixo+'Endereco>', '</'+prefixo+'Endereco>'), '<'+prefixo+'Endereco>', '', [rfReplaceAll]);
  cdsNFS.FieldByName('TMSNUM').AsString := RetornaTexto(TomadorServico, '<'+prefixo+'Numero>', '</'+prefixo+'Numero>');
  cdsNFS.FieldByName('TMSBAIR').AsString := RetornaTexto(TomadorServico, '<'+prefixo+'Bairro>', '</'+prefixo+'Bairro>');
  cdsNFS.FieldByName('TMSMUN').AsString := RetornaTexto(TomadorServico, '<'+prefixo+'CodigoMunicipio>', '</'+prefixo+'CodigoMunicipio>');
  cdsNFS.FieldByName('TMSUF').AsString := RetornaTexto(TomadorServico, '<'+prefixo+'Estado>', '</'+prefixo+'Estado>');
  cdsNFS.FieldByName('TMSCEP').AsString := RetornaTexto(TomadorServico, '<'+prefixo+'Cep>', '</'+prefixo+'Cep>');

  Contato := RetornaTexto(TomadorServico, '<'+prefixo+'Contato>', '</'+prefixo+'Contato>');
  cdsNFS.FieldByName('TMSFONE').AsString := RetornaTexto(Contato, '<'+prefixo+'Telefone>', '</'+prefixo+'Telefone>');
  cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(Contato, '<'+prefixo+'Email>', '</'+prefixo+'Email>');

  // ORGÃO GERADOR
  OrgaoGerador := RetornaTexto(strXML, '<'+prefixo+'OrgaoGerador>', '</'+prefixo+'OrgaoGerador>');
  cdsNFS.FieldByName('ORGMUN').AsString := RetornaTexto(OrgaoGerador, '<'+prefixo+'CodigoMunicipio>', '</'+prefixo+'CodigoMunicipio>');
  cdsNFS.FieldByName('ORG_UF').AsString := RetornaTexto(OrgaoGerador, '<'+prefixo+'Uf>', '</'+prefixo+'Uf>');

  cdsNFS.Post;
end;


end.
