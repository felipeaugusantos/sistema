unit untSaoJoseDosCamposXML;

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
  TSaoJoseDosCamposXML = class
    private
    public

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string);

    end;
implementation

{ TSaoJoseDosCamposXML }

class procedure TSaoJoseDosCamposXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML: string);
var
  IdentifcacaoRps,
  Servico,
  Valores,
  PrestadorServico,
  IdentificacaoPrestador,
  Endereco,
  Contato,
  TomadorServico,
  IdentificacaoTomador,
  CpfCnpj,
  OrgaoGerador: String;
begin

  try

    cdsNFS.Append;
    cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<Numero>', '</Numero>');
    cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>');
    cdsNFS.FieldByName('DTAHRA').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),12,8);;
    cdsNFS.FieldByName('DTAEMI').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),1,4);
    IdentifcacaoRps := RetornaTexto(strXML, '<IdentificacaoRps>', '</IdentificacaoRps>');
    cdsNFS.FieldByName('NUMRPS').AsString := RetornaTexto(IdentifcacaoRps, '<Numero>', '</Numero>');
    cdsNFS.FieldByName('SERRPS').AsString := RetornaTexto(IdentifcacaoRps, '<Serie>', '</Serie>');
    cdsNFS.FieldByName('TPORPS').AsString := RetornaTexto(IdentifcacaoRps, '<Tipo>', '</Tipo>');

    cdsNFS.FieldByName('EMIRPS').AsString := Copy(RetornaTexto(strXML, '<DataEmissaoRps>', '</DataEmissaoRps>'),9,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissaoRps>', '</DataEmissaoRps>'),6,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissaoRps>', '</DataEmissaoRps>'),1,4);

    cdsNFS.FieldByName('NATOPE').AsString := RetornaTexto(strXML, '<NaturezaOperacao>', '</NaturezaOperacao>');
    cdsNFS.FieldByName('EMIOSN').AsString := RetornaTexto(strXML, '<OptanteSimplesNacional>', '</OptanteSimplesNacional>');
    cdsNFS.FieldByName('INCULT').AsString := RetornaTexto(strXML, '<OptanteSimplesNacional>', '</OptanteSimplesNacional>');
    cdsNFS.FieldByName('COMPET').AsString := Copy(RetornaTexto(strXML, '<Competencia>', '</Competencia>'),9,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<Competencia>', '</Competencia>'),6,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<Competencia>', '</Competencia>'),1,4);

    Servico := RetornaTexto(strXML, '<Servico>', '</Servico>');
    Valores := RetornaTexto(Servico, '<Valores>', '</Valores>');

    cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
    cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorDeducoes>', '</ValorDeducoes>'),'.',','), 0);
    cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorPis>', '</ValorPis>'),'.',','), 0);
    cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorCofins>', '</ValorCofins>'),'.',','), 0);
    cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorInss>', '</ValorInss>'),'.',','), 0);
    cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorIr>', '</ValorIr>'),'.',','), 0);
    cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorCsll>', '</ValorCsll>'),'.',','), 0);
    cdsNFS.FieldByName('ISS_RET').AsFloat:= StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<IssRetido>', '</IssRetido>'),'.',','), 0);
    cdsNFS.FieldByName('OUT_RET').AsFloat:= StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<OutrasRetencoes>', '</OutrasRetencoes>'),'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorIss>', '</ValorIss>'),'.',','), 0);
    cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<BaseCalculo>', '</BaseCalculo>'),'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<Aliquota>', '</Aliquota>'),'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'),'.',','), 0);
    cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<DescontoIncondicionado>', '</DescontoIncondicionado>'),'.',','), 0);
    cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<DescontoCondicionado>', '</DescontoCondicionado>'),'.',','), 0);

    cdsNFS.FieldByName('CODSER').AsString := RetornaTexto(Servico, '<ItemListaServico>', '</ItemListaServico>');
    cdsNFS.FieldByName('CDCNAE').AsString := RetornaTexto(Servico, '<CodigoCnae>', '</CodigoCnae>');
    cdsNFS.FieldByName('DISCRI').AsString := RetornaTexto(Servico, '<Discriminacao>', '</Discriminacao>');
    cdsNFS.FieldByName('CODMUN').AsString := RetornaTexto(Servico, '<CodigoMunicipio>', '</CodigoMunicipio>');

    PrestadorServico := RetornaTexto(strXML, '<PrestadorServico>', '</PrestadorServico>');
    IdentificacaoPrestador := RetornaTexto(PrestadorServico, '<IdentificacaoPrestador>', '</IdentificacaoPrestador>');


    cdsNFS.FieldByName('PSVCNPJ').AsString := RetornaTexto(IdentificacaoPrestador, '<Cnpj>', '</Cnpj>');
    cdsNFS.FieldByName('PSVIM').AsString := RetornaTexto(IdentificacaoPrestador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');

    cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(PrestadorServico, '<RazaoSocial>', '</RazaoSocial>');

    Endereco := RetornaTexto(PrestadorServico, '<Endereco>', '<Contato>');

    cdsNFS.FieldByName('PSVEND').AsString := RetornaTexto(Endereco, '<Endereco>', '</Endereco>');
    cdsNFS.FieldByName('PSVNUM').AsString := RetornaTexto(Endereco, '<Numero>', '</Numero>');
    cdsNFS.FieldByName('PSVBAIR').AsString := RetornaTexto(Endereco, '<Bairro>', '</Bairro>');
    cdsNFS.FieldByName('PSVCEP').AsString := RetornaTexto(Endereco, '<Cep>', '</Cep>');
    cdsNFS.FieldByName('PSVMUN').AsString := RetornaTexto(Endereco, '<CodigoMunicipio>', '</CodigoMunicipio>');
    cdsNFS.FieldByName('PSVUF').AsString := RetornaTexto(Endereco, '<Uf>', '</Uf>');

    Contato := RetornaTexto(PrestadorServico, '<Contato>', '</Contato>');
    cdsNFS.FieldByName('PSVFONE').AsString := RetornaTexto(Contato, '<Telefone>', '</Telefone>');

    TomadorServico := RetornaTexto(strXML, '<Tomador>', '</Tomador>');
    IdentificacaoTomador := RetornaTexto(TomadorServico, '<IdentificacaoTomador>', '</IdentificacaoTomador>');
    CpfCnpj := RetornaTexto(IdentificacaoTomador, '<CpfCnpj>', '</CpfCnpj>');

    cdsNFS.FieldByName('TMSCNPJ').AsString := IIF( RetornaTexto(CpfCnpj, '<Cnpj>', '</Cnpj>') = '', RetornaTexto(CpfCnpj, '<Cpf>', '</Cpf>'), RetornaTexto(CpfCnpj, '<Cnpj>', '</Cnpj>'));

    cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(TomadorServico, '<RazaoSocial>', '</RazaoSocial>');

    Endereco := RetornaTexto(TomadorServico, '<Endereco>', '<Contato>');

    cdsNFS.FieldByName('TMSEND').AsString := RetornaTexto(Endereco, '<Endereco>', '</Endereco>');
    cdsNFS.FieldByName('TMSNUM').AsString := RetornaTexto(Endereco, '<Numero>', '</Numero>');
    cdsNFS.FieldByName('TMSBAIR').AsString := RetornaTexto(Endereco, '<Bairro>', '</Bairro>');
    cdsNFS.FieldByName('TMSCEP').AsString := RetornaTexto(Endereco, '<Cep>', '</Cep>');
    cdsNFS.FieldByName('TMSMUN').AsString := RetornaTexto(Endereco, '<CodigoMunicipio>', '</CodigoMunicipio>');
    cdsNFS.FieldByName('TMSUF').AsString := RetornaTexto(Endereco, '<Uf>', '</Uf>');

    Contato := RetornaTexto(TomadorServico, '<Contato>', '</Contato>');
    cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(Contato, '<Email>', '</Email>');
    cdsNFS.FieldByName('TMSFONE').AsString := RetornaTexto(Contato, '<Telefone>', '</Telefone>');


    OrgaoGerador :=  RetornaTexto(strXML, '<OrgaoGerador>', '</OrgaoGerador>');
    cdsNFS.FieldByName('ORGMUN').AsString := RetornaTexto(OrgaoGerador, '<CodigoMunicipio>', '</CodigoMunicipio>');
    cdsNFS.FieldByName('ORG_UF').AsString := RetornaTexto(OrgaoGerador, '<Uf>', '</Uf>');

    cdsNFS.Post;
  except
    cdsNFS.Cancel;
    raise;
  end;

end;

end.
