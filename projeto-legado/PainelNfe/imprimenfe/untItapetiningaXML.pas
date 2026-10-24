unit untItapetiningaXML;

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
  TItapetiningaXML = class

    private

    public
      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

implementation

{ TItapevaXML }

class procedure TItapetiningaXML.pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
begin

  cdsNFS.Append;

  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strXML, '<NumNf>', '</NumNf>');
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<CodVernf>', '</CodVernf>');
  cdsNFS.FieldByName('DTAEMI').AsString   := Copy(RetornaTexto(strXML, '<DtHrGerNf>', '</DtHrGerNf>'),1,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DtHrGerNf>', '</DtHrGerNf>'),4,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DtHrGerNf>', '</DtHrGerNf>'),7,4);
  cdsNFS.FieldByName('DTHRCA').AsString   := Copy(RetornaTexto(strXML, '<DtHrGerNf>', '</DtHrGerNf>'),12,8);

  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strXML, '<NumRps>', '</NumRps>');
  cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strXML, '<SerRps>', '</SerRps>');
  cdsNFS.FieldByName('TPORPS').AsString   := '';
  cdsNFS.FieldByName('EMIRPS').AsString   := RetornaTexto(strXML, '<DtEmiRps>', '</DtEmiRps>');
  cdsNFS.FieldByName('STATUS').AsString   := '';

  cdsNFS.FieldByName('PSVIM').AsString    := '';
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strXML, '<CpfCnpjPre>', '</CpfCnpjPre>');

  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strXML, '<LogPre>', '</LogPre>');
  cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strXML, '<NumEndPre>', '</NumEndPre>');
  cdsNFS.FieldByName('PSVBAI').AsString   := RetornaTexto(strXML, '<BairroPre>', '</BairroPre>');
  cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strXML, '<MunPre>', '</MunPre>');
  cdsNFS.FieldByName('PSVUF').AsString    := RetornaTexto(strXML, '<SiglaUFPre>', '</SiglaUFPre>');;
  cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strXML, '<CepPre>', '</CepPre>');

  cdsNFS.FieldByName('LOCMUN').AsString   := '';
  cdsNFS.FieldByName('LOC_UF').AsString   := '';

  cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strXML, '<CpfCnpjTom>', '</CpfCnpjTom>');
  cdsNFS.FieldByName('TOMIE').AsString    := '';
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strXML, '<RazSocTom>', '</RazSocTom>');
  cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strXML, '<LogTom>', '</LogTom>');
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strXML, '<NumEndTom>', '</NumEndTom>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strXML, '<BairroTom>', '</BairroTom>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strXML, '<MunTom>', '</MunTom>');
  cdsNFS.FieldByName('TOMUF').AsString    := RetornaTexto(strXML, '<SiglaUFTom>', '</SiglaUFTom>');
  cdsNFS.FieldByName('TOMCEP').AsString   := RetornaTexto(strXML, '<CepTom>', '</CepTom>');
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strXML, '<EMailTom>', '</EMailTom>');

  cdsNFS.FieldByName('DISSER').AsString   := RetornaTexto(strXML, '<DiscrSrv>', '</DiscrSrv>');
  cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strXML, '<CodSrv>', '</CodSrv>');

  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlBasCalc>', '</VlBasCalc>'),'.',','), 0);
  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AlqIss>', '</AlqIss>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat    := 0;
  cdsNFS.FieldByName('VALIRR').AsFloat    := 0;
  cdsNFS.FieldByName('VALCSL').AsFloat    := 0;
  cdsNFS.FieldByName('VALCOF').AsFloat    := 0;
  cdsNFS.FieldByName('VALPIS').AsFloat    := 0;
  cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlIss>', '</VlIss>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlNFS>', '</VlNFS>'),'.',','), 0);

  cdsNFS.Post;

end;

class procedure TItapetiningaXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string;
  cdsItens: TUniClientDataSet);
var
  strDadosPrestador,
  strEnderecoPrestador,
  strIdentificacaoTomador,
  strDadosTomador,
  strRPS,
  strDadosOrgaoGerador : String;
begin

  cdsNFS.Append;

  cdsNFS.FieldByName('NUMNFS').AsString   := FormatFloat('00000000', StrToInt(RetornaTexto(strXML, '<Numero>', '</Numero>')));
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>');
  cdsNFS.FieldByName('DTAEMI').AsString   := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),1,4);
  cdsNFS.FieldByName('DTHRCA').AsString   := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),12,8);

  strRPS := RetornaTexto(strXML, '<Rps>', '</Rps>');
  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strRPS, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strRPS, '<Serie>', '</Serie>');
  cdsNFS.FieldByName('TPORPS').AsString   := RetornaTexto(strRPS, '<Tipo>', '</Tipo>');
  cdsNFS.FieldByName('EMIRPS').AsString   := Copy(RetornaTexto(strRPS, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                             Copy(RetornaTexto(strRPS, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                             Copy(RetornaTexto(strRPS, '<DataEmissao>', '</DataEmissao>'),1,4)+' '+
                                             Copy(RetornaTexto(strRPS, '<DataEmissao>', '</DataEmissao>'),12,8);
  cdsNFS.FieldByName('STATUS').AsString   := RetornaTexto(strRPS, '<Status>', '</Status>');

  strDadosPrestador := RetornaTexto(strXML, '<Prestador>', '</Prestador>');
  cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(strDadosPrestador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strDadosPrestador, '<Cnpj>', '</Cnpj>');

  strEnderecoPrestador := RetornaTexto(strXML, '<EnderecoPrestadorServico>', '</EnderecoPrestadorServico>');
  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strEnderecoPrestador, '<Endereco>', '</Endereco>');
  cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strEnderecoPrestador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('PSVBAI').AsString   := RetornaTexto(strEnderecoPrestador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strEnderecoPrestador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('PSVUF').AsString    := RetornaTexto(strEnderecoPrestador, '<Uf>', '</Uf>');;
  cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strEnderecoPrestador, '<Cep>', '</Cep>');

  strDadosOrgaoGerador := RetornaTexto(strXML, '<OrgaoGerador>', '</OrgaoGerador>');
  cdsNFS.FieldByName('LOCMUN').AsString   := RetornaTexto(strDadosOrgaoGerador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('LOC_UF').AsString   := RetornaTexto(strDadosOrgaoGerador, '<Uf>', '</Uf>');

  strDadosTomador := RetornaTexto(strXML, '<Tomador>', '</Tomador>');
  strIdentificacaoTomador := RetornaTexto(strDadosTomador, '<IdentificacaoTomador>', '</IdentificacaoTomador>');

  cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strIdentificacaoTomador, '<Cpf>', '</Cpf>');
  cdsNFS.FieldByName('TOMIM').AsString    := RetornaTexto(strIdentificacaoTomador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strDadosTomador, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('TOMEND').AsString   := Trim(RetornaTexto(strDadosTomador, '<Endereco>', '</Endereco>'));
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strDadosTomador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strDadosTomador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strDadosTomador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('TOMUF').AsString    := RetornaTexto(strDadosTomador, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('TOMCEP').AsString   := RetornaTexto(strDadosTomador, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strDadosTomador, '<Email>', '</Email>');
  cdsNFS.FieldByName('TOMFON').AsString   := RetornaTexto(strDadosTomador, '<Telefone>', '</Telefone>');

  cdsNFS.FieldByName('DISSER').AsString   := RetornaTexto(strXML, '<Discriminacao>', '</Discriminacao>');
  cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strXML, '<ItemListaServico>', '</ItemListaServico>');

  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Aliquota>', '</Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorInss>', '</ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIr>', '</ValorIr>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCsll>', '</ValorCsll>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCofins>', '</ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorPis>', '</ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIss>', '</ValorIss>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'),'.',','), 0);
  cdsNFS.FieldByName('CDCNAE').asString   := RetornaTexto(strXML, '<CodigoCnae>', '</CodigoCnae>');
  cdsNFS.FieldByName('RGSPTR').asString   := RetornaTexto(strXML, '<RegimeEspecialTributacao>', '</RegimeEspecialTributacao>');
  cdsNFS.Post;

end;

end.

