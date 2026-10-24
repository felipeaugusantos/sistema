unit untRioBrancoXML;

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
  TRioBrancoXML = class
    private
    public

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string);

    end;
implementation

{ TRioBrancoXML }

class procedure TRioBrancoXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML: string);
var
  IdentifcacaoRps,
  Servico,
  Valores,
  PrestadorServico,
  TomadorServico,
  Endereco,
  IdentificacaoTomador,
  Contato,
  CpfCnpj,
  OrgaoGerador: String;

begin

  cdsNFS.Append;
  cdsNFS.FieldByName('_LINK_').AsString := RetornaTexto(strXML, '<ChaveAcesso>', '</ChaveAcesso>');
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
  cdsNFS.FieldByName('EMIRPS').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),1,4);

  cdsNFS.FieldByName('NATOPE').AsString := RetornaTexto(strXML, '<NaturezaOperacao>', '</NaturezaOperacao>');
  cdsNFS.FieldByName('EMIOSN').AsString := RetornaTexto(strXML, '<OptanteSimplesNacional>', '</OptanteSimplesNacional>');
  cdsNFS.FieldByName('INCULT').AsString := RetornaTexto(strXML, '<OptanteSimplesNacional>', '</OptanteSimplesNacional>');
  cdsNFS.FieldByName('COMPET').AsString := Copy(RetornaTexto(strXML, '<Competencia>', '</Competencia>'),9,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<Competencia>', '</Competencia>'),6,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<Competencia>', '</Competencia>'),1,4);
  cdsNFS.FieldByName('OUTINF').AsString := RetornaTexto(strXML, '<OutrasInformacoes>', '</OutrasInformacoes>');

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
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIss>', '</ValorIss>'),'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<BaseCalculo>', '</BaseCalculo>'),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Aliquota>', '</Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'),'.',','), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<DescontoIncondicionado>', '</DescontoIncondicionado>'),'.',','), 0);
  cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<DescontoCondicionado>', '</DescontoCondicionado>'),'.',','), 0);

  cdsNFS.FieldByName('CODSER').AsString := RetornaTexto(strXML, '<ItemListaServico>', '</ItemListaServico>');
  cdsNFS.FieldByName('DISCRI').AsString := RetornaTexto(strXML, '<Discriminacao>', '</Discriminacao>');
  cdsNFS.FieldByName('CODMUN').AsString := RetornaTexto(strXML, '<CodigoMunicipio>', '</CodigoMunicipio>');

  PrestadorServico := RetornaTexto(strXML, '<Prestador>', '</Prestador>');

  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(PrestadorServico, '<Cnpj>', '</Cnpj>');
  cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(PrestadorServico, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := '';
  cdsNFS.FieldByName('PSVFANT').AsString  := '';
  cdsNFS.FieldByName('PSVEND').AsString   := '';
  cdsNFS.FieldByName('PSVNUM').AsString   := '';
  cdsNFS.FieldByName('PSVBAIR').AsString  := '';
  cdsNFS.FieldByName('PSVCEP').AsString   := '';
  cdsNFS.FieldByName('PSVMUN').AsString   := '';
  cdsNFS.FieldByName('PSVEMAIL').AsString := '';

  TomadorServico := RetornaTexto(strXML, '<Tomador>', '</Tomador>');
  IdentificacaoTomador := RetornaTexto(TomadorServico, '<IdentificacaoTomador>', '</IdentificacaoTomador>');
  CpfCnpj := RetornaTexto(IdentificacaoTomador, '<CpfCnpj>', '</CpfCnpj>');

  cdsNFS.FieldByName('TMSCNPJ').AsString := iif(RetornaTexto(CpfCnpj, '<Cpf>', '</Cpf>')='', RetornaTexto(CpfCnpj, '<Cnpj>', '</Cnpj>'), RetornaTexto(CpfCnpj, '<Cpf>', '</Cpf>'));

  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(TomadorServico, '<RazaoSocial>', '</RazaoSocial>');

  Endereco := RetornaTexto(TomadorServico, '<Endereco>', '<Contato>');

  cdsNFS.FieldByName('TMSEND').AsString := RetornaTexto(Endereco, '<Endereco>', '</Endereco>');
  cdsNFS.FieldByName('TMSNUM').AsString := RetornaTexto(Endereco, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TMSBAIR').AsString := RetornaTexto(Endereco, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TMSCEP').AsString := RetornaTexto(Endereco, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('TMSMUN').AsString := RetornaTexto(Endereco, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('TMSUF').AsString := RetornaTexto(Endereco, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('TMSCOMPL').AsString := RetornaTexto(Endereco, '<Complemento>', '</Complemento>');

  Contato := RetornaTexto(TomadorServico, '<Contato>', '</Contato>');
  cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(Contato, '<Email>', '</Email>');
  cdsNFS.FieldByName('TMSFONE').AsString := RetornaTexto(Contato, '<Telefone>', '</Telefone>');


  OrgaoGerador :=  RetornaTexto(strXML, '<OrgaoGerador>', '</OrgaoGerador>');
  cdsNFS.FieldByName('ORGMUN').AsString := RetornaTexto(OrgaoGerador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('ORG_UF').AsString := RetornaTexto(OrgaoGerador, '<Uf>', '</Uf>');

  cdsNFS.Post;

end;

end.
