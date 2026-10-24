unit untSaoCarlosXML;

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
  TSaoCarlosXML = class

    private

    public
      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil; strFusoHorario: string='');

  end;

implementation

{ TSaoCarlosXML }

class procedure TSaoCarlosXML.pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
var
  strDadosPrestador,
  strDadosTomador,
  strDetalhesDoServico,
  strLocalServico,
  strTotais : String;
begin

  cdsNFS.Append;
  cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(strXML, '<im>', '</im>');
  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strXML, '<numeroNota>', '</numeroNota>');
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<codigoAutenticacao>', '</codigoAutenticacao>');
  cdsNFS.FieldByName('DTAEMI').AsString   := RetornaTexto(strXML, '<dataEmissao>', '</dataEmissao>');
  cdsNFS.FieldByName('SERRPS').AsString   := '2';
  cdsNFS.FieldByName('TPORPS').AsString   := '';
  cdsNFS.FieldByName('EMIRPS').AsString   := '';
  cdsNFS.FieldByName('STATUS').AsString   := '';

  strLocalServico := RetornaTexto(strXML, '<localServico>', '</localServico>');
  cdsNFS.FieldByName('LOCMUN').AsString   := RetornaTexto(strLocalServico, '<cidade>', '</cidade>');
  cdsNFS.FieldByName('LOC_UF').AsString   := RetornaTexto(strLocalServico, '<uf>', '</uf>');

  strDadosPrestador := RetornaTexto(strXML, '<DadosPrestador>', '</DadosPrestador>');
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strDadosPrestador, '<documento>', '</documento>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strDadosPrestador, '<razaoSocial>', '</razaoSocial>');
  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strDadosPrestador, '<Logradouro>', '</Logradouro>');
  cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strDadosPrestador, '<endereco>', '</endereco>');
  cdsNFS.FieldByName('PSVBAI').AsString   := RetornaTexto(strDadosPrestador, '<bairro>', '</bairro>');
  cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strDadosPrestador, '<municipio>', '</municipio>');
  cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strDadosPrestador, '<cep>', '</cep>');
  cdsNFS.FieldByName('CDCNAE').AsString   := '';

  strDadosTomador := RetornaTexto(strXML, '<DadosTomador>', '</DadosTomador>');
  cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strDadosTomador, '<documento>', '</documento>');
  cdsNFS.FieldByName('TOMIE').AsString    := RetornaTexto(strDadosTomador, '<ie>', '</ie>');
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strDadosTomador, '<razaoSocial>', '</razaoSocial>');
  cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strDadosTomador, '<logradouro>', '</logradouro>');
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strDadosTomador, '<numero>', '</numero>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strDadosTomador, '<bairro>', '</bairro>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strDadosTomador, '<cidade>', '</cidade>');
  cdsNFS.FieldByName('TOMCEP').AsString   := RetornaTexto(strDadosTomador, '<cep>', '</cep>');
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strDadosTomador, '<email>', '</email>');

  strDetalhesDoServico := RetornaTexto(strXML, '<DetalhesServico>', '</DetalhesServico>');
  cdsNFS.FieldByName('DISSER').AsString   := RetornaTexto(strDetalhesDoServico, '<descricao>', '</descricao>');
  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<valorServico>', '</valorServico>'),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strDetalhesDoServico, '<codigo>', '</codigo>');
  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<aliquota>', '</aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strDetalhesDoServico, '<numRps>', '</numRps>');
  cdsNFS.FieldByName('VALINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<inss>', '</inss>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<ir>', '</ir>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<csll>', '</csll>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<cofins>', '</cofins>'),'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strDetalhesDoServico, '<pispasep>', '</pispasep>'),'.',','), 0);

  strTotais := RetornaTexto(strXML, '<Totais>', '</Totais>');
  cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strTotais, '<valorIss>', '</valorIss>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strTotais, '<valorLiquidoNota>', '</valorLiquidoNota>'),'.',','), 0);

  cdsNFS.Post;
end;

class procedure TSaoCarlosXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string;
  cdsItens: TUniClientDataSet; strFusoHorario: string);
var
  strDadosPrestador,
  strDadosTomador,
  strDataEmissao : String;
begin

  strDataEmissao := RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>');

  cdsNFS.Append;

  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strXML, '<ConsultaNfse NumeroNfse="', '"><NumeroVerificacao');
  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strXML, '<NumeroRps>', '</NumeroRps>');
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<NumeroVerificacao>', '</NumeroVerificacao>');
  cdsNFS.FieldByName('DTHRCA').AsString   := fAplicaFusoHorarioENotas(RetornaTexto(strXML, '<HoraEmissao>', '</HoraEmissao>'), strFusoHorario, strDataEmissao);
  cdsNFS.FieldByName('DTAEMI').AsString   := strDataEmissao;

  cdsNFS.FieldByName('SERRPS').AsString   := '2';
  cdsNFS.FieldByName('TPORPS').AsString   := '';
  cdsNFS.FieldByName('EMIRPS').AsString   := '';
  cdsNFS.FieldByName('STATUS').AsString   := '';

  strDadosPrestador := RetornaTexto(strXML, '<PrestadorServico>', '</PrestadorServico>');
  cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(strXML, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strDadosPrestador, '<CnpjCpf>', '</CnpjCpf>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strDadosPrestador, '<RazaoSocialNome>', '</RazaoSocialNome>');
  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strDadosPrestador, '<Endereco>', '</Endereco>');
  cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strDadosPrestador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('PSVBAI').AsString   := RetornaTexto(strDadosPrestador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strDadosPrestador, '<Cidade>', '</Cidade>')+'-'+
                                             RetornaTexto(strDadosPrestador, '<Uf>', '</Uf>');;
  cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strDadosPrestador, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('LOCMUN').AsString   := RetornaTexto(strDadosPrestador, '<CodigoIbgeCidadePrestacao>', '</CodigoIbgeCidadePrestacao>');
  cdsNFS.FieldByName('LOC_UF').AsString   := RetornaTexto(strDadosPrestador, '<Uf>', '</Uf>');

  strDadosTomador := RetornaTexto(strXML, '<TomadorServico>', '</TomadorServico>');
  cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strDadosTomador, '<CnpjCpf>', '</CnpjCpf>');
  cdsNFS.FieldByName('TOMIE').AsString    := '';
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strDadosTomador, '<RazaoSocialNome>', '</RazaoSocialNome>');
  cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strDadosTomador, '<Logradouro>', '</Logradouro>');
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strDadosTomador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strDadosTomador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strDadosTomador, '<Cidade>', '</Cidade>')+'-'+
                                             RetornaTexto(strDadosTomador, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('TOMCEP').AsString   := RetornaTexto(strDadosTomador, '<CodigoPostal>', '</CodigoPostal>');
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strDadosTomador, '<Email>', '</Email>');
  cdsNFS.FieldByName('DISSER').AsString   := RetornaTexto(strXML, '<DiscriminacaoServico>', '</DiscriminacaoServico>');
  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorNfse>', '</ValorNfse>'),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strXML, '<CodigoAtividade>', '</CodigoAtividade>');
  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Aliquota>', '</Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorInss>', '</ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIrrf>', '</ValorIrrf>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIsll>', '</ValorIsll>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCofins>', '</ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorPis>', '</ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIss>', '</ValorIss>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'),'.',','), 0);
  cdsNFS.Post;

end;

end.
