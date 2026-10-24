unit untSaoJoseDoRioPretoXML;

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
  TSaoJoseDoRioPretoXML = class

    public

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

implementation

class procedure TSaoJoseDoRioPretoXML.pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
var
  strDadosRPS,
  strDadosPrestador,
  strDadosTomador,
  strDetalhesDoServico,
  strDadosPrestadorEndere,
  strDadosTomaEndere,
  strOrgaoGerador,
  strPrefixo : String;

begin
  Strprefixo := 'ns4';
  cdsNFS.Append;

  cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<'+strPrefixo+':Numero>', '</'+strPrefixo+':Numero>');
  cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(strXML, '<'+strPrefixo+':CodigoVerificacao>', '</'+strPrefixo+':CodigoVerificacao>');
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(RetornaTexto(strXML, '<'+strPrefixo+':DataEmissao>', '</'+strPrefixo+':DataEmissao>'), 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(RetornaTexto(strXML, '<'+strPrefixo+':DataEmissao>', '</'+strPrefixo+':DataEmissao>'), 9, 2)+'/'+
                                           Copy(RetornaTexto(strXML, '<'+strPrefixo+':DataEmissao>', '</'+strPrefixo+':DataEmissao>'), 6, 2)+'/'+
                                           Copy(RetornaTexto(strXML, '<'+strPrefixo+':DataEmissao>', '</'+strPrefixo+':DataEmissao>'), 1, 4);

  strDadosRPS := RetornaTexto(strXML, '<'+strPrefixo+':IdentificacaoRps>', '</'+strPrefixo+':IdentificacaoRps>');
  cdsNFS.FieldByName('NUMRPS').AsString := RetornaTexto(strDadosRPS, '<'+strPrefixo+':Numero>', '</'+strPrefixo+':Numero>');
  cdsNFS.FieldByName('SERRPS').AsString := RetornaTexto(strDadosRPS, '<'+strPrefixo+':Serie>', '</'+strPrefixo+':Serie>');
  cdsNFS.FieldByName('TPORPS').AsString := RetornaTexto(strDadosRPS, '<'+strPrefixo+':Tipo>', '</'+strPrefixo+':Tipo>');
  cdsNFS.FieldByName('EMIRPS').AsString := Copy(RetornaTexto(strXML, '<'+strPrefixo+':DataEmissaoRps>', '</'+strPrefixo+':DataEmissaoRps>'), 9, 2)+'/'+
                                           Copy(RetornaTexto(strXML, '<'+strPrefixo+':DataEmissaoRps>', '</'+strPrefixo+':DataEmissaoRps>'), 6, 2)+'/'+
                                           Copy(RetornaTexto(strXML, '<'+strPrefixo+':DataEmissaoRps>', '</'+strPrefixo+':DataEmissaoRps>'), 1, 4);

  cdsNFS.FieldByName('NATOPE').AsString := RetornaTexto(strXML, '<'+strPrefixo+':NaturezaOperacao>', '</'+strPrefixo+':NaturezaOperacao>');
  cdsNFS.FieldByName('CODRET').AsString := RetornaTexto(strXML, '<'+strPrefixo+':RegimeEspecialTributacao>', '</'+strPrefixo+':RegimeEspecialTributacao>');
  cdsNFS.FieldByName('EMIOSN').AsString := RetornaTexto(strXML, '<'+strPrefixo+':OptanteSimplesNacional>', '</'+strPrefixo+':OptanteSimplesNacional>');
  cdsNFS.FieldByName('EMIICC').AsString := RetornaTexto(strXML, '<'+strPrefixo+':IncentivadorCultural>', '</'+strPrefixo+':IncentivadorCultural>');
  cdsNFS.FieldByName('COMPET').AsString := Copy(RetornaTexto(strXML, '<'+strPrefixo+':Competencia>', '</'+strPrefixo+':Competencia>'), 9, 2)+'/'+
                                           Copy(RetornaTexto(strXML, '<'+strPrefixo+':Competencia>', '</'+strPrefixo+':Competencia>'), 6, 2)+'/'+
                                           Copy(RetornaTexto(strXML, '<'+strPrefixo+':Competencia>', '</'+strPrefixo+':Competencia>'), 1, 4);
  cdsNFS.FieldByName('NFSSUB').AsString := '';
  cdsNFS.FieldByName('OUTINF').AsString := RetornaTexto(strXML, '<'+strPrefixo+':OutrasInformacoes>', '</'+strPrefixo+':OutrasInformacoes>');

  strDetalhesDoServico := RetornaTexto(strXML, '<'+strPrefixo+':Servico>', '</'+strPrefixo+':Servico>');
  cdsNFS.FieldByName('CODSER').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ItemListaServico>', '</'+strPrefixo+':ItemListaServico>');
  cdsNFS.FieldByName('CDCNAE').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':CodigoCnae>', '</'+strPrefixo+':CodigoCnae>');
  cdsNFS.FieldByName('CODTRI').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':CodigoTributacaoMunicipio>', '</'+strPrefixo+':CodigoTributacaoMunicipio>');
  cdsNFS.FieldByName('DISCRI').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':Discriminacao>', '</'+strPrefixo+':Discriminacao>');
  cdsNFS.FieldByName('MUNPRE').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':CodigoMunicipio>', '</'+strPrefixo+':CodigoMunicipio>');
  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ValorServicos>', '</'+strPrefixo+':ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ValorDeducoes>', '</'+strPrefixo+':ValorDeducoes>'),'.',','), 0);
  cdsNFS.FieldByName('VLRPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ValorPis>', '</'+strPrefixo+':ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VLRCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ValorCofins>', '</'+strPrefixo+':ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VLRINS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ValorInss>', '</'+strPrefixo+':ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VLRIR_').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ValorIr>', '</'+strPrefixo+':ValorIr>'),'.',','), 0);
  cdsNFS.FieldByName('VLRCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ValorCsll>', '</'+strPrefixo+':ValorCsll>'),'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ValorPis>', '</'+strPrefixo+':ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ValorCofins>', '</'+strPrefixo+':ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ValorInss>', '</'+strPrefixo+':ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ValorIr>', '</'+strPrefixo+':ValorIr>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ValorCsll>', '</'+strPrefixo+':ValorCsll>'),'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsString := RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':IssRetido>', '</'+strPrefixo+':IssRetido>');
  cdsNFS.FieldByName('OUT_RET').AsFloat := 0;
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':BaseCalculo>', '</'+strPrefixo+':BaseCalculo>'),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':Aliquota>', '</'+strPrefixo+':Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ValorLiquidoNfse>', '</'+strPrefixo+':ValorLiquidoNfse>'),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':ValorIss>', '</'+strPrefixo+':ValorIss>'),'.',','), 0);
  cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':DescontoCondicionado>', '</'+strPrefixo+':DescontoCondicionado>'),'.',','), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<'+strPrefixo+':DescontoIncondicionado>', '</'+strPrefixo+':DescontoIncondicionado>'),'.',','), 0);

  strDadosPrestador := RetornaTexto(strXML, '<'+strPrefixo+':PrestadorServico>', '</'+strPrefixo+':PrestadorServico>');
  cdsNFS.FieldByName('PSVCNPJ').AsString := RetornaTexto(strDadosPrestador, '<'+strPrefixo+':Cnpj>', '</'+strPrefixo+':Cnpj>');
  cdsNFS.FieldByName('PSVIM').AsString := RetornaTexto(strDadosPrestador, '<'+strPrefixo+':InscricaoMunicipal>', '</'+strPrefixo+':InscricaoMunicipal>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strDadosPrestador, '<'+strPrefixo+':RazaoSocial>', '</'+strPrefixo+':RazaoSocial>');
  cdsNFS.FieldByName('PSVFANT').AsString := '';

  strDadosPrestadorEndere := RetornaTexto(strDadosPrestador, '<'+strPrefixo+':Endereco>', '</'+strPrefixo+':Contato>');
  cdsNFS.FieldByName('PSVEND').AsString := RetornaTexto(strDadosPrestadorEndere, '<'+strPrefixo+':Endereco>', '</'+strPrefixo+':Endereco>');
  cdsNFS.FieldByName('PSVNUM').AsString := RetornaTexto(strDadosPrestadorEndere, '<'+strPrefixo+':Numero>', '</'+strPrefixo+':Numero>');
  cdsNFS.FieldByName('PSVCOMPL').AsString := RetornaTexto(strDadosPrestadorEndere, '<'+strPrefixo+':Complemento>', '</'+strPrefixo+':Complemento>');
  cdsNFS.FieldByName('PSVBAIR').AsString := RetornaTexto(strDadosPrestadorEndere, '<'+strPrefixo+':Bairro>', '</'+strPrefixo+':Bairro>');
  cdsNFS.FieldByName('PSVMUN').AsString := '';

  cdsNFS.FieldByName('PSVUF').AsString := RetornaTexto(strDadosPrestadorEndere, '<'+strPrefixo+':Uf>', '</'+strPrefixo+':Uf>');
  cdsNFS.FieldByName('PSVCEP').AsString := RetornaTexto(strDadosPrestadorEndere, '<'+strPrefixo+':Cep>', '</'+strPrefixo+':Cep>');
  cdsNFS.FieldByName('PSVFONE').AsString := RetornaTexto(strDadosPrestador, '<'+strPrefixo+':Telefone>', '</'+strPrefixo+':Telefone>');
  cdsNFS.FieldByName('PSVEMAIL').AsString := RetornaTexto(strDadosPrestador, '<'+strPrefixo+':Email>', '</'+strPrefixo+':Email>');

  strDadosTomador := RetornaTexto(strXML, '<'+strPrefixo+':TomadorServico>', '</'+strPrefixo+':TomadorServico>');
  strDadosTomaEndere := RetornaTexto(strDadosTomador, '<'+strPrefixo+':Endereco>', '</'+strPrefixo+':Contato>');

  cdsNFS.FieldByName('TMSCNPJ').AsString := iif(RetornaTexto(strDadosTomador, '<'+strPrefixo+':Cnpj>', '</'+strPrefixo+':Cnpj>') = '',
                                                RetornaTexto(strDadosTomador, '<'+strPrefixo+':Cpf>', '</'+strPrefixo+':Cpf>'),
                                                RetornaTexto(strDadosTomador, '<'+strPrefixo+':Cnpj>', '</'+strPrefixo+':Cnpj>'));
  cdsNFS.FieldByName('TMSIM').AsString := '';
  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(strDadosTomador, '<'+strPrefixo+':RazaoSocial>', '</'+strPrefixo+':RazaoSocial>');

  cdsNFS.FieldByName('TMSEND').AsString := RetornaTexto(strDadosTomaEndere, '<'+strPrefixo+':Endereco>', '</'+strPrefixo+':Endereco>');
  cdsNFS.FieldByName('TMSNUM').AsString := RetornaTexto(strDadosTomaEndere, '<'+strPrefixo+':Numero>', '</'+strPrefixo+':Numero>');
  cdsNFS.FieldByName('TMSCOMPL').AsString := '';
  cdsNFS.FieldByName('TMSBAIR').AsString := RetornaTexto(strDadosTomaEndere, '<'+strPrefixo+':Bairro>', '</'+strPrefixo+':Bairro>');
  cdsNFS.FieldByName('TMSMUN').AsString := '';
  cdsNFS.FieldByName('TMSUF').AsString := RetornaTexto(strDadosTomaEndere, '<'+strPrefixo+':Uf>', '</'+strPrefixo+':Uf>');
  cdsNFS.FieldByName('TMSCEP').AsString := RetornaTexto(strDadosTomaEndere, '<'+strPrefixo+':Cep>', '</'+strPrefixo+':Cep>');
  cdsNFS.FieldByName('TMSFONE').AsString := RetornaTexto(strDadosTomador, '<'+strPrefixo+':Telefone>', '</'+strPrefixo+':Telefone>');
  cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(strDadosTomador, '<'+strPrefixo+':Email>', '</'+strPrefixo+':Email>');

  strOrgaoGerador := RetornaTexto(strXML, '<'+strPrefixo+':OrgaoGerador>', '</'+strPrefixo+':OrgaoGerador>');
  cdsNFS.FieldByName('ORGMUN').AsString := RetornaTexto(strOrgaoGerador, '<'+strPrefixo+':CodigoMunicipio>', '</'+strPrefixo+':CodigoMunicipio>');
  cdsNFS.FieldByName('ORG_UF').AsString := RetornaTexto(strOrgaoGerador, '<'+strPrefixo+':Uf>', '</'+strPrefixo+':Uf>');

  cdsNFS.Post;

end;


end.
