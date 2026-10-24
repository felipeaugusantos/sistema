unit untParaDeMinasXML;

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
  TParaDeMinasXML = class

    private

    public
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);
  end;
implementation

{ TParaDeMinasXML }

class procedure TParaDeMinasXML.pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);
var
  strPrestador,
  strRps,
  strServico,
  strTomador: String;
begin

  cdsNFS.Append;
  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strXML, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<CodigoControle>', '</CodigoControle>');
  cdsNFS.FieldByName('DTAHRA').AsString   := '';
  cdsNFS.FieldByName('DTAEMI').AsString   := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),1,4);

  cdsNFS.FieldByName('COMPET').AsString   := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),1,4);

  cdsNFS.FieldByName('OUTINF').AsString   := '';

  cdsNFS.FieldByName('BSCISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<BaseCalculo>', '</BaseCalculo>'),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Aliquota>', '</Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIss>', '</ValorIss>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'),'.',','), 0);

  strPrestador := RetornaTexto(strXML, '<PrestadorServico>', '</PrestadorServico>');
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strPrestador, '<Cnpj>', '</Cnpj>');
  cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(strPrestador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strPrestador, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('PSVFANT').AsString  := '';
  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strPrestador, '<Endereco><Endereco>', '</Endereco>');
  cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strPrestador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('PSVBAIR').AsString  := RetornaTexto(strPrestador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('PSVMUN').AsString   := '';
  cdsNFS.FieldByName('PSVUF').AsString    := RetornaTexto(strPrestador, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strPrestador, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('PSVEMAIL').AsString := RetornaTexto(strPrestador, '<Email>', '</Email>');
  cdsNFS.FieldByName('FONPRE').AsString   := RetornaTexto(strPrestador, '<Telefone>', '</Telefone>');

  strRps := RetornaTexto(strXML, '<Rps>', '</Rps>');
  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strRps, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strRps, '<Serie>', '</Serie>');
  cdsNFS.FieldByName('TPORPS').AsString   := RetornaTexto(strRps, '<Tipo>', '</Tipo>');
  cdsNFS.FieldByName('EMIRPS').AsString   := Copy(RetornaTexto(strRps, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                             Copy(RetornaTexto(strRps, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                             Copy(RetornaTexto(strRps, '<DataEmissao>', '</DataEmissao>'),1,4);

  strServico := RetornaTexto(strXML, '<Servico>', '</Servico>');
  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorDeducoes>', '</ValorDeducoes>'),'.',','), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat   := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<DescontoIncondicionado>', '</DescontoIncondicionado>'),'.',','), 0);
  cdsNFS.FieldByName('DESCONC').AsFloat   := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<DescontoCondicionado>', '</DescontoCondicionado>'),'.',','), 0);
  cdsNFS.FieldByName('VALPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorPis>', '</ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorCofins>', '</ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorInss>', '</ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorIr>', '</ValorIr>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorCsll>', '</ValorCsll>'),'.',','), 0);
  cdsNFS.FieldByName('OUT_RET').AsFloat   := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<OutrasRetencoes>', '</OutrasRetencoes>'),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strServico, '<ItemListaServico>', '</ItemListaServico>');
  cdsNFS.FieldByName('CDCNAE').AsString   := RetornaTexto(strServico, '<CodigoCnae>', '</CodigoCnae>');
  cdsNFS.FieldByName('DISCRI').AsString   := RetornaTexto(strServico, '<Discriminacao>', '</Discriminacao>');
  cdsNFS.FieldByName('ISS_RET').AsString  := RetornaTexto(strServico, '<IssRetido>', '</IssRetido>');
  cdsNFS.FieldByName('CODTRI').AsString   := '';
  cdsNFS.FieldByName('EXIGIB').AsString   := RetornaTexto(strServico, '<ExigibilidadeISS>', '</ExigibilidadeISS>');
  cdsNFS.FieldByName('MUNINC').AsString   := RetornaTexto(strServico, '<MunicipioIncidencia>', '</MunicipioIncidencia>');
  cdsNFS.FieldByName('ISSRET').AsString   := RetornaTexto(strServico, '<IssRetido>', '</IssRetido>');

  strTomador := RetornaTexto(strXML, '<Tomador>', '</Tomador>');
  cdsNFS.FieldByName('TMSCNPJ').AsString  := IIF(fEmptyStr(RetornaTexto(strTomador, '<Cnpj>', '</Cnpj>')),
                                                           RetornaTexto(strTomador, '<Cpf>', '</Cpf>'),
                                                           RetornaTexto(strTomador, '<Cnpj>', '</Cnpj>'));
  cdsNFS.FieldByName('TMSIM').AsString    := RetornaTexto(strTomador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('TMSIE').AsString    := RetornaTexto(strTomador, '<InscricaoEstadual>', '</InscricaoEstadual>');
  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(strTomador, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('TMSEND').AsString   := RetornaTexto(strTomador, '<Endereco><Endereco>', '</Endereco>');
  cdsNFS.FieldByName('TMSNUM').AsString   := RetornaTexto(strTomador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TMSBAIR').AsString  := RetornaTexto(strTomador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TMSMUN').AsString   := RetornaTexto(strTomador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('TMSUF').AsString    := RetornaTexto(strTomador, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('TMSCEP').AsString   := RetornaTexto(strTomador, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('TMSFONE').AsString  := RetornaTexto(strTomador, '<Telefone>', '</Telefone>');
  cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(strTomador, '<Email>', '</Email>');

  cdsNFS.FieldByName('CODRET').AsString   := '';
  cdsNFS.FieldByName('EMIOSN').AsString   := RetornaTexto(strXML, '<OptanteSimplesNacional>', '</OptanteSimplesNacional>');
  cdsNFS.FieldByName('EMIICC').AsString   := RetornaTexto(strXML, '<IncentivoFiscal>', '</IncentivoFiscal>');

  cdsNFS.Post;

end;

end.
