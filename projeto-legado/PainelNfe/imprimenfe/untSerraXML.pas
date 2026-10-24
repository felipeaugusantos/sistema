unit untSerraXML;

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
  TSerraXML = class
    public
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsItens: TUniClientDataSet; strXML: string);
  end;

implementation

{ TSerraXML }

class procedure TSerraXML.pRetornaCDSPreenchidoComENotas(var cdsNFS,
  cdsItens: TUniClientDataSet; strXML: string);
var
  strDadosPrestador,
  strDadosRPS,
  strServico,
  strDadosTomador,
  strValorLiquidoNfse : String;
begin

  cdsNFS.Append;
  cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>');
  cdsNFS.FieldByName('DTAHRA').AsString := '';
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),1,4);
  strDadosRPS := RetornaTexto(strXML, '<IdentificacaoRps>', '</IdentificacaoRps>');
  cdsNFS.FieldByName('NUMRPS').AsString := RetornaTexto(strDadosRPS, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('SERRPS').AsString := RetornaTexto(strDadosRPS, '<Serie>', '</Serie>');
  cdsNFS.FieldByName('TPORPS').AsString := RetornaTexto(strDadosRPS, '<Tipo>', '</Tipo>');
  cdsNFS.FieldByName('EMIRPS').AsString := Copy(RetornaTexto(strXML, '<DataEmissaoRps>', '</DataEmissaoRps>'),9,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissaoRps>', '</DataEmissaoRps>'),6,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissaoRps>', '</DataEmissaoRps>'),1,4);

  cdsNFS.FieldByName('NATOPE').AsString := '';
  cdsNFS.FieldByName('CODRET').AsString := '';
  cdsNFS.FieldByName('EMIOSN').AsString := '';
  cdsNFS.FieldByName('EMIICC').AsString := '';
  cdsNFS.FieldByName('COMPET').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),1,4);
  cdsNFS.FieldByName('OUTINF').AsString := '';

  strValorLiquidoNfse := RetornaTexto(strXML, '<ValoresNfse>', '</ValoresNfse>');
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strValorLiquidoNfse, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'),'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strValorLiquidoNfse, '<BaseCalculo>', '</BaseCalculo>'),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strValorLiquidoNfse, '<Aliquota>', '</Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strValorLiquidoNfse, '<ValorIss>', '</ValorIss>'),'.',','), 0);

  strServico := RetornaTexto(strXML, '<Servico>', '</Servico>');
  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('ISS_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ISSRetido>', '</ISSRetido>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorIr>', '</ValorIr>'),'.',','), 0);
  cdsNFS.FieldByName('VLRCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorCofins>', '</ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VLRINS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorInss>', '</ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VLRCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorCsll>', '</ValorCsll>'),'.',','), 0);
  cdsNFS.FieldByName('VLRPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorPis>', '</ValorPis>'),'.',','), 0);

  cdsNFS.FieldByName('CODSER').AsString := RetornaTexto(strServico, '<ItemListaServico>', '</ItemListaServico>');
  cdsNFS.FieldByName('CDCNAE').AsString := RetornaTexto(strServico, '<CodigoCnae>', '</CodigoCnae>');
  cdsNFS.FieldByName('CODTRI').AsString := RetornaTexto(strServico, '<CodigoTributacaoMunicipio >', '</CodigoTributacaoMunicipio >');
  cdsNFS.FieldByName('DISCRI').AsString := RetornaTexto(strServico, '<Discriminacao >', '</Discriminacao >');
  cdsNFS.FieldByName('CODMUN').AsString := RetornaTexto(strServico, '<CodigoMunicipio >', '</CodigoMunicipio >');
  cdsNFS.FieldByName('ITEDESC').AsString := '';
  cdsNFS.FieldByName('ITEQTD').AsFloat := 0;
  cdsNFS.FieldByName('ITEVLU').AsFloat := 0;

  strDadosTomador := RetornaTexto(strXML, '<TomadorServico>', '</TomadorServico>');
  if Length(RetornaTexto(strDadosTomador, '<Cnpj>', '</Cnpj>')) > 0 then
    cdsNFS.FieldByName('TMSCNPJ').AsString  := RetornaTexto(strDadosTomador, '<CpfCnpj><Cnpj>', '</Cnpj>')
  else
    cdsNFS.FieldByName('TMSCNPJ').AsString  := RetornaTexto(strDadosTomador, '<CpfCnpj><Cpf>', '</Cpf>');
  cdsNFS.FieldByName('TMSIM').AsString := RetornaTexto(strDadosTomador, '<InscricaoMunicipal >', '</InscricaoMunicipal >');
  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(strDadosTomador, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('TMSEND').AsString := RetornaTexto(strDadosTomador, '<Endereco><Endereco>', '</Endereco>');
  cdsNFS.FieldByName('TMSNUM').AsString := RetornaTexto(strDadosTomador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TMSCOMPL').AsString := RetornaTexto(strDadosTomador, '<Complemento >', '</Complemento >');
  cdsNFS.FieldByName('TMSBAIR').AsString := RetornaTexto(strDadosTomador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TMSMUN').AsString := RetornaTexto(strDadosTomador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('TMSUF').AsString := RetornaTexto(strDadosTomador, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('TMSCEP').AsString := RetornaTexto(strDadosTomador, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('TMSFONE').AsString := RetornaTexto(strDadosTomador, '<Telefone >', '</Telefone >');
  cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(strDadosTomador, '<Email>', '</Email>');

  cdsNFS.FieldByName('ORGMUN').AsString := '';
  cdsNFS.FieldByName('ORG_UF').AsString := '';

  cdsNFS.Post;

  cdsItens.Append;
  cdsItens.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<Numero>', '</Numero>');
  cdsItens.FieldByName('ITEDES').AsString := RetornaTexto(strServico, '<Discriminacao>', '</Discriminacao>');
  cdsItens.FieldByName('ITEQTD').AsFloat  := 1;
  cdsItens.FieldByName('VLRUNT').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsItens.FieldByName('VLRTOT').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsItens.Post;

end;

end.
