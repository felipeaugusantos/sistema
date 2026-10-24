unit untMarianaXML;

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
  TMarianaXML = class

    private

    public

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens : TUniClientDataSet; strXML: string; strCidadeNFSe: string='');

  end;

implementation

{ TGissOnlineXML }


class procedure TMarianaXML.pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens : TUniClientDataSet; strXML: string; strCidadeNFSe: string='');
var
  strDadosPrestador,
  strEndPrestador,
  strCnpjPrestador,
  strDadosTomador,
  strEndTomador,
  strDetalhesDoServico,
  strOrgaoGerador,
  strPrefixo,
  strParcela,
  strDiscriminacaoServico : String;
  intInicioEnd,
  intFinalEnd: Integer;
begin

  cdsNFS.Append;

  cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>');
  cdsNFS.FieldByName('DTAHRA').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 12, 8);
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 9, 2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 6, 2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 1, 4);

  cdsNFS.FieldByName('NUMRPS').AsString := '';
  cdsNFS.FieldByName('SERRPS').AsString := '';
  cdsNFS.FieldByName('TPORPS').AsString := '';
  cdsNFS.FieldByName('EMIRPS').AsString := '';
  cdsNFS.FieldByName('NATOPE').AsString := '1';

  cdsNFS.FieldByName('CODRET').AsString := RetornaTexto(strXML, '<RegimeEspecialTributacao>', '</RegimeEspecialTributacao>');
  cdsNFS.FieldByName('EMIOSN').AsString := RetornaTexto(strXML, '<OptanteSimplesNacional>', '</OptanteSimplesNacional>');
  cdsNFS.FieldByName('EMIICC').AsString := RetornaTexto(strXML, '<IncentivadorCultural>', '</IncentivadorCultural>');
  cdsNFS.FieldByName('COMPET').AsString := RetornaTexto(strXML, '<Competencia>', '</Competencia>');
  cdsNFS.FieldByName('NFSSUB').AsString := '';
  cdsNFS.FieldByName('OUTINF').AsString := RetornaTexto(strXML, '<OutrasInformacoes>', '</OutrasInformacoes>');

  strDetalhesDoServico := RetornaTexto(strXML, '<Servico>', '</Servico>');
  cdsNFS.FieldByName('CODSER').AsString := RetornaTexto(strDetalhesDoServico, '<ItemListaServico>', '</ItemListaServico>');
  cdsNFS.FieldByName('CDCNAE').AsString := RetornaTexto(strDetalhesDoServico, '<CodigoCnae>', '</CodigoCnae>');
  cdsNFS.FieldByName('CODTRI').AsString := RetornaTexto(strDetalhesDoServico, '<CodigoTributacaoMunicipio>', '</CodigoTributacaoMunicipio>');
  cdsNFS.FieldByName('DISCRI').AsString := RetornaTexto(strDetalhesDoServico, '<Discriminacao>', '</Discriminacao>');
  cdsNFS.FieldByName('MUNPRE').AsString := RetornaTexto(strDetalhesDoServico, '<MunicipioPrestacaoServico>', '</MunicipioPrestacaoServico>');
  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorDeducoes>', '</ValorDeducoes>'),'.',','), 0);
  cdsNFS.FieldByName('VLRPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorPis>', '</ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VLRCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorCofins>', '</ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VLRINS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorInss>', '</ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VLRIR_').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorIr>', '</ValorIr>'),'.',','), 0);
  cdsNFS.FieldByName('VLRCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorCsll>', '</ValorCsll>'),'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorPis>', '</ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorCofins>', '</ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorInss>', '</ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorIr>', '</ValorIr>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorCsll>', '</ValorCsll>'),'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsString := RetornaTexto(strDetalhesDoServico, '<IssRetido>', '</IssRetido>');
  cdsNFS.FieldByName('OUT_RET').AsFloat := 0;
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<BaseCalculo>', '</BaseCalculo>'),'.',','), 0);
  if ( strPrefixo = '') then
  begin
    cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Aliquota>', '</Aliquota>'),'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'),'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIss>', '</ValorIss>'),'.',','), 0);
    If RetornaTexto(strXML, '<IssRetido>', '</IssRetido>') = '1' then
      cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIssRetido>', '</ValorIssRetido>'),'.',','), 0)
    else
      cdsNFS.FieldByName('VLISSR').AsFloat := 0;
  end
  else
  begin
    cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<Aliquota>', '</Aliquota>'),'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'),'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorIss>', '</ValorIss>'),'.',','), 0);
    If RetornaTexto(strDetalhesDoServico, '<IssRetido>', '</IssRetido>') = '1' then
      cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorIssRetido>', '</ValorIssRetido>'),'.',','), 0)
    Else
      cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorIss>', '</ValorIss>'),'.',','), 0);
  end;

  cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<DescontoCondicionado>', '</DescontoCondicionado>'),'.',','), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<DescontoIncondicionado>', '</DescontoIncondicionado>'),'.',','), 0);

  strDadosPrestador := RetornaTexto(strXML, '<PrestadorServico>', '</PrestadorServico>');
  strEndPrestador := RetornaTexto(strDadosPrestador, '<Endereco>', '<Contato>');
  strCnpjPrestador := RetornaTexto(strXML, '<Prestador>', '</Prestador>');

  cdsNFS.FieldByName('PSVCNPJ').AsString := RetornaTexto(strCnpjPrestador, '<Cnpj>', '</Cnpj>');
  cdsNFS.FieldByName('PSVIM').AsString := RetornaTexto(strCnpjPrestador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strDadosPrestador, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('PSVFANT').AsString := RetornaTexto(strDadosPrestador, '<NomeFantasia>', '</NomeFantasia>');
  cdsNFS.FieldByName('PSVEND').AsString := RetornaTexto(strEndPrestador, '<Endereco>', '</Endereco>');
  cdsNFS.FieldByName('PSVNUM').AsString := RetornaTexto(strDadosPrestador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('PSVCOMPL').AsString := RetornaTexto(strDadosPrestador, '<Complemento>', '</Complemento>');
  cdsNFS.FieldByName('PSVBAIR').AsString := RetornaTexto(strDadosPrestador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('PSVMUN').AsString := RetornaTexto(strDadosPrestador, '<Cidade>', '</Cidade>');
  cdsNFS.FieldByName('PSVUF').AsString := RetornaTexto(strDadosPrestador, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('PSVCEP').AsString := RetornaTexto(strDadosPrestador, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('PSVFONE').AsString := RetornaTexto(strDadosPrestador, '<Telefone>', '</Telefone>');
  cdsNFS.FieldByName('PSVEMAIL').AsString := RetornaTexto(strDadosPrestador, '<Email>', '</Email>');

  strDadosTomador := RetornaTexto(strXML, '<TomadorServico>', '</TomadorServico>');
  strEndTomador := RetornaTexto(strDadosTomador, '<Endereco>', '<Contato>');
  if fEmptyStr(strEndTomador) then
    strEndTomador := RetornaTexto(strDadosTomador, '<Endereco>', '<Contato/>');

  cdsNFS.FieldByName('TMSCNPJ').AsString := iif(RetornaTexto(strDadosTomador, '<Cnpj>', '</Cnpj>') = '',
                                                RetornaTexto(strDadosTomador, '<Cpf>', '</Cpf>'),
                                                RetornaTexto(strDadosTomador, '<Cnpj>', '</Cnpj>'));
  cdsNFS.FieldByName('TMSIM').AsString := '';
  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(strDadosTomador, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('TMSEND').AsString := RetornaTexto(strEndTomador, '<Endereco>', '</Endereco>');
  cdsNFS.FieldByName('TMSNUM').AsString := RetornaTexto(strDadosTomador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TMSCOMPL').AsString := RetornaTexto(strDadosTomador, '<Complemento>', '</Complemento>');
  cdsNFS.FieldByName('TMSBAIR').AsString := RetornaTexto(strDadosTomador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TMSMUN').AsString := RetornaTexto(strDadosTomador, '<Cidade>', '</Cidade>');
  cdsNFS.FieldByName('TMSUF').AsString := RetornaTexto(strDadosTomador, '<Estado>', '</Estado>');
  cdsNFS.FieldByName('TMSCEP').AsString := RetornaTexto(strDadosTomador, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('TMSFONE').AsString := RetornaTexto(strDadosTomador, '<Telefone>', '</Telefone>');
  cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(strDadosTomador, '<Email>', '</Email>');

  strOrgaoGerador := RetornaTexto(strXML, '<OrgaoGerador>', '</OrgaoGerador>');
  cdsNFS.FieldByName('ORGMUN').AsString := RetornaTexto(strOrgaoGerador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('MUNINC').AsString := RetornaTexto(strDetalhesDoServico, '<MunicipioIncidencia>', '</MunicipioIncidencia>');
  cdsNFS.FieldByName('EXIGIB').AsString := RetornaTexto(strDetalhesDoServico, '<ExigibilidadeISS>', '</ExigibilidadeISS>');
  cdsNFS.FieldByName('ORG_UF').AsString := RetornaTexto(strOrgaoGerador, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('INFCOM').AsString := '';

  strParcela := RetornaTexto(strXML, '<Parcelas>', '</Parcelas>');
  cdsNFS.FieldByName('PARCEL').AsString := RetornaTexto(strParcela, '<Parcela>', '</Parcela>');
  cdsNFS.FieldByName('DTAVCT').AsString := Copy(RetornaTexto(strParcela, '<DataVencimento>', '</DataVencimento>'), 9, 2)+'/'+
                                           Copy(RetornaTexto(strParcela, '<DataVencimento>', '</DataVencimento>'), 6, 2)+'/'+
                                           Copy(RetornaTexto(strParcela, '<DataVencimento>', '</DataVencimento>'), 1, 4);
  cdsNFS.FieldByName('VLRPAR').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strParcela, '<Valor>', '</Valor>'),'.',','), 0);
  cdsNFS.Post;

  strDiscriminacaoServico := RetornaTexto(strXML, '<'+strPrefixo+'Discriminacao>', '</'+strPrefixo+'Discriminacao>');
  cdsItens.Insert;
  cdsItens.FieldByName('CODSER').asString := RetornaTexto(strDetalhesDoServico, '<ItemListaServico>', '</ItemListaServico>');
  cdsItens.FieldByName('ITEDES').asString := RetornaTexto(strDiscriminacaoServico, '[Descricao=', ']');
  cdsItens.FieldByName('VLRUNT').asFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDiscriminacaoServico, '][ValorUnitario=', '][ValorServico='),'.',','), 0);
  cdsItens.FieldByName('ITEQTD').asFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDiscriminacaoServico, '][Quantidade=', '][ValorUnitario='),'.',','), 0);
  cdsItens.FieldByName('VLRSRV').asFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsItens.FieldByName('BASCAL').asFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<BaseCalculo>', '</BaseCalculo>'),'.',','), 0);
  cdsItens.FieldByName('ALIISS').asFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Aliquota>', '</Aliquota>'),'.',','), 0);
  cdsItens.FieldByName('VLRISS').asFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIss>', '</ValorIss>'),'.',','), 0);
  cdsItens.Post;

end;

end.
