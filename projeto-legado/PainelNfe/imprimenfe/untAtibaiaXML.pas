unit untAtibaiaXML;

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
  TAtibaiaXML = class

    private

    public
      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

implementation

{ TItapevaXML }

class procedure TAtibaiaXML.pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
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

class procedure TAtibaiaXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string;
  cdsItens: TUniClientDataSet);
var
  strDadosPrestador,
  strDadosTomador,
  strValoresNfs,
  strRps,
  strServico: String;
begin

  cdsNFS.Append;

  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strXML, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>');
  cdsNFS.FieldByName('DTAEMI').AsString   := RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>');
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(cdsNFS.FieldByName('DTAEMI').AsString, 9, 2)+'/'+
                                           Copy(cdsNFS.FieldByName('DTAEMI').AsString, 6, 2)+'/'+
                                           Copy(cdsNFS.FieldByName('DTAEMI').AsString, 1, 4);

  cdsNFS.FieldByName('DTHRCA').AsString   := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'), 12, 8);

  cdsNFS.FieldByName('COMPET').AsString   := RetornaTexto(strXML, '<Competencia>', '</Competencia>');
  cdsNFS.FieldByName('COMPET').AsString   :=  Copy(cdsNFS.FieldByName('COMPET').AsString, 9, 2)+'/'+
                                              Copy(cdsNFS.FieldByName('COMPET').AsString, 6, 2)+'/'+
                                              Copy(cdsNFS.FieldByName('COMPET').AsString, 1, 4);

  strRps := RetornaTexto(strXML, '<Rps>', '</Rps>');
  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strRps, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strRps, '<Serie>', '</Serie>');
  cdsNFS.FieldByName('TPORPS').AsString   := '';
  cdsNFS.FieldByName('EMIRPS').AsString   := RetornaTexto(strRps, '<DataEmissao>', '</DataEmissao>');
  cdsNFS.FieldByName('STATUS').AsString   := '';

  strValoresNfs := RetornaTexto(strXML, '<ValoresNfse>', '</ValoresNfse>');
  cdsNFS.FieldByName('BSCISS').AsFloat    := fStrToFloatDef(RetornaTexto(strValoresNfs, '<BaseCalculo>', '</BaseCalculo>'));


  strDadosPrestador := RetornaTexto(strXML, '<PrestadorServico>', '</PrestadorServico>');
  cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(strDadosPrestador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strDadosPrestador, '<Cnpj>', '</Cnpj>');
  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strDadosPrestador, '<Endereco>', '</Endereco>');
  cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strDadosPrestador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('PSVBAI').AsString   := RetornaTexto(strDadosPrestador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strDadosPrestador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('PSVUF').AsString    := RetornaTexto(strDadosPrestador, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strDadosPrestador, '<Cep>', '</Cep>');

  strDadosTomador := RetornaTexto(strXML, '<Tomador>', '</Tomador>');
  cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strDadosTomador, '<Cnpj>', '</Cnpj>');
  cdsNFS.FieldByName('TOMIM').AsString    := RetornaTexto(strDadosTomador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('TOMIE').AsString    := RetornaTexto(strDadosTomador, '<InscricaoEstadual>', '</InscricaoEstadual>');
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strDadosTomador, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('TOMEND').AsString   := Trim(RetornaTexto(strDadosTomador, '<Endereco>', '</Endereco>'));
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strDadosTomador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strDadosTomador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strDadosTomador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('TOMUF').AsString    := RetornaTexto(strDadosTomador, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('TOMCEP').AsString   := RetornaTexto(strDadosTomador, '<Cep>', '</Cep>');;
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strDadosTomador, '<Email>', '</Email>');
  cdsNFS.FieldByName('TOMFON').AsString   := RetornaTexto(strDadosTomador, '<Telefone>', '</Telefone>');

  cdsNFS.FieldByName('DISSER').AsString   := RetornaTexto(strXML, '<Discriminacao>', '</Discriminacao>');
  cdsNFS.FieldByName('DISSER').AsString   := AnsiReplaceStr(RetornaTexto(cdsNFS.FieldByName('DISSER').AsString, '=', ']'), 'n', sLineBreak);
  cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strXML, '<ItemListaServico>', '</ItemListaServico>');

  strServico := RetornaTexto(strXML, '<Valores>', '</Valores>');
  cdsNFS.FieldByName('VLRSER').AsFloat    := fStrToFloatDef(RetornaTexto(strServico, '<ValorServicos>', '</ValorServicos>'));
  cdsNFS.FieldByName('ALISER').AsFloat    := fStrToFloatDef(RetornaTexto(strServico, '<Aliquota>', '</Aliquota>'));
  cdsNFS.FieldByName('VALINS').AsFloat    := fStrToFloatDef(RetornaTexto(strServico, '<ValorInss>', '</ValorInss>'));
  cdsNFS.FieldByName('VALIRR').AsFloat    := fStrToFloatDef(RetornaTexto(strServico, '<ValorIr>', '</ValorIr>'));
  cdsNFS.FieldByName('VALCSL').AsFloat    := fStrToFloatDef(RetornaTexto(strServico, '<ValorCsll>', '</ValorCsll>'));
  cdsNFS.FieldByName('VALCOF').AsFloat    := fStrToFloatDef(RetornaTexto(strServico, '<ValorCofins>', '</ValorCofins>'));
  cdsNFS.FieldByName('VALPIS').AsFloat    := fStrToFloatDef(RetornaTexto(strServico, '<ValorPis>', '</ValorPis>'));
  cdsNFS.FieldByName('VLRISS').AsFloat    := fStrToFloatDef(RetornaTexto(strServico, '<ValorIss>', '</ValorIss>'));
  cdsNFS.FieldByName('VLRLIQ').AsFloat    := fStrToFloatDef(RetornaTexto(strXML, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'));
  cdsNFS.FieldByName('DESCONC').AsFloat   := fStrToFloatDef(RetornaTexto(strServico, '<DescontoCondicionado>', '</DescontoCondicionado>'));
  cdsNFS.FieldByName('DESCONI').AsFloat   := fStrToFloatDef(RetornaTexto(strServico, '<DescontoIncondicionado>', '</DescontoIncondicionado>'));
  cdsNFS.FieldByName('VLRDED').AsFloat    := fStrToFloatDef(RetornaTexto(strServico, '<ValorDeducoes>', '</ValorDeducoes>'));

  cdsNFS.FieldByName('CDCNAE').asString   := '';
  cdsNFS.FieldByName('RGSPTR').asString   := RetornaTexto(strXML, '<RegimeEspecialTributacao>', '</RegimeEspecialTributacao>');
  cdsNFS.FieldByName('RSPISS').AsString   := RetornaTexto(strXML, '<IssPagoTomadorServico>', '</IssPagoTomadorServico>');
  cdsNFS.FieldByName('OUTINF').AsString   := RetornaTexto(strXML, '<OutrasInformacoes>', '</OutrasInformacoes>');

  cdsNFS.Post;

end;

end.
