unit untEunapolisXML;

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
  TEunapolisXML = class

    private
      class function fRetornaCodigoServicoEunapolis( strCodSer: String ): String ;
    public

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

implementation

class function TEunapolisXML.fRetornaCodigoServicoEunapolis(
  strCodSer: String): String;
const
   ACodServPrefeituraEunapolis : Array[0..35] Of Array[0..1] Of String = (
                         ('14.01'   , '1401'),
                         ('14.01.01', '1401'),
                         ('14.01.02', '1401'),
                         ('14.01.03', '1401'),
                         ('14.01.04', '1401'),
                         ('14.01.05', '1401'),
                         ('14.01.06', '1401'),
                         ('14.01.07', '1401'),
                         ('14.02.01', '1402'),
                         ('14.02.02', '1402'),
                         ('14.03.01', '1403'),
                         ('14.03.02', '1403'),
                         ('14.04.01', '1404'),
                         ('14.04.02', '1404'),
                         ('14.05.01', '1405'),
                         ('14.05.02', '1405'),
                         ('14.05.03', '1405'),
                         ('14.06.01', '1406'),
                         ('14.06.02', '1406'),
                         ('14.06.03', '1406'),
                         ('14.06.04', '1406'),
                         ('14.06.05', '1406'),
                         ('14.06.06', '1406'),
                         ('14.07.01', '1407'),
                         ('14.08.01', '1408'),
                         ('14.09.01', '1409'),
                         ('14.09.02', '1409'),
                         ('14.09.03', '1409'),
                         ('14.10.01', '1410'),
                         ('14.11.01', '1411'),
                         ('14.12.01', '1412'),
                         ('14.12.02', '1412'),
                         ('14.13.01', '1413'),
                         ('14.13.02', '1413'),
                         ('14.13.03', '1413'),
                         ('14.14.01', '1414'));
var
  intContador: integer;
begin

  Result := EmptyStr;
  for intContador := Low(ACodServPrefeituraEunapolis) to High(ACodServPrefeituraEunapolis) do
  begin
    if ACodServPrefeituraEunapolis[intContador, 0] = strCodSer then
      Result := ACodServPrefeituraEunapolis[intContador, 1] ;
  end;

end;


class procedure TEunapolisXML.pRetornaCDSPreenchidoComENotas(
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

  function MesPorExtenso(n: Integer): String;
  begin
   Case n Of
      01 : Result := 'Janeiro';
      02 : Result := 'Fevereiro';
      03 : Result := 'Março';
      04 : Result := 'Abril';
      05 : Result := 'Maio';
      06 : Result := 'Junho';
      07 : Result := 'Julho';
      08 : Result := 'Agosto';
      09 : Result := 'Setembro';
      10 : Result := 'Outubro';
      11 : Result := 'Novembro';
      12 : Result := 'Dezembro';
    end;
   end;

begin

  //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS

  cdsNFS.Append;

  IdentificacaoNfse := RetornaTexto(strXML, '<Nfse>', '</Nfse>');
  cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(IdentificacaoNfse, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('CODVER').AsString := RetornaTexto(IdentificacaoNfse, '<CodigoVerificacao>', '</CodigoVerificacao>');


  cdsNFS.FieldByName('DTAHRA').AsString := RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>');
  cdsNFS.FieldByName('DTAEMI').AsString := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                           Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),1,4);

  IdentificacaoRps := RetornaTexto(strXML, '<IdentificacaoRps>', '</IdentificacaoRps>');
  cdsNFS.FieldByName('NUMRPS').AsString := RetornaTexto(IdentificacaoRps, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('SERRPS').AsString := RetornaTexto(IdentificacaoRps, '<Serie>', '</Serie>');
  cdsNFS.FieldByName('TPORPS').AsString := RetornaTexto(IdentificacaoRps, '<Tipo>', '</Tipo>');

  cdsNFS.FieldByName('CODRET').AsString := RetornaTexto(strXML, '<RegimeEspecialTributacao>', '</RegimeEspecialTributacao>');
  cdsNFS.FieldByName('EMIOSN').AsString := RetornaTexto(strXML, '<OptanteSimplesNacional>', '</OptanteSimplesNacional>');
  cdsNFS.FieldByName('EMIICC').AsString := RetornaTexto(strXML, '<IncetivadorCultural>', '</IncetivadorCultural>');
  cdsNFS.FieldByName('COMPET').AsString := MesPorExtenso(StrToInt(Copy(RetornaTexto(strXML, '<Competencia>', '</Competencia>'),4,2)))+'/'+
                                           Copy(RetornaTexto(strXML, '<Competencia>', '</Competencia>'),7,4);
  cdsNFS.FieldByName('EXIGIB').AsString := RetornaTexto(strXML, '<ExigibilidadeISS>', '</ExigibilidadeISS>');
  cdsNFS.FieldByName('ISS_RET').AsString := RetornaTexto(strXML, '<IssRetido>', '</IssRetido>');
  cdsNFS.FieldByName('CODMUN').AsString := RetornaTexto(strXML, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('MUNINC').AsString := RetornaTexto(strXML, '<MunicipioIncidencia>', '</MunicipioIncidencia>');

  //SERVIÇOS
  Servico := RetornaTexto(strXML, '<Servico>', '</Servico>');
  Valores := RetornaTexto(Servico, '<Valores>', '</Valores>');
  cdsNFS.FieldByName('VLRSER').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorDeducoes>', '</ValorDeducoes>'),'.',','), 0);
  cdsNFS.FieldByName('DESCONI').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<DescontoIncondicionado>', '</DescontoIncondicionado>'),'.',','), 0);
  cdsNFS.FieldByName('DESCONC').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<DescontoCondicionado>', '</DescontoCondicionado>'),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorIss>', '</ValorIss>'),'.',','), 0);
  cdsNFS.FieldByName('BSCISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<BaseCalculo>', '</BaseCalculo>'),'.',','), 0);
  cdsNFS.FieldByName('ALIISS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<Aliquota>', '</Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('VLISSR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorIssRetido>', '</ValorIssRetido>'),'.',','), 0);

  cdsNFS.FieldByName('VALPIS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorPis>', '</ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VALCOF').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorCofins>', '</ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VALIRR').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorIr>', '</ValorIr>'),'.',','), 0);
  cdsNFS.FieldByName('VALINS').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorInss>', '</ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VALCSL').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<ValorCsll>', '</ValorCsll>'),'.',','), 0);
  cdsNFS.FieldByName('OUT_RET').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(Valores, '<OutrasRetencoes>', '</OutrasRetencoes>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorLiquidoNfse>', '</ValorLiquidoNfse>'),'.',','), 0);
  cdsNFS.FieldByName('CODSER').AsString := fRetornaCodigoServicoEunapolis(RetornaTexto(Servico, '<ItemListaServico>', '</ItemListaServico>'));
  cdsNFS.FieldByName('CODPRE').AsString := RetornaTexto(Servico, '<ItemListaServico>', '</ItemListaServico>');

  cdsNFS.FieldByName('CDCNAE').AsString := RetornaTexto(Servico, '<CodigoCnae>', '</CodigoCnae>');

  cdsNFS.FieldByName('CODTRI').AsString := RetornaTexto(Servico, '<CodigoTributacaoMunicipio>', '</CodigoTributacaoMunicipio>');
  cdsNFS.FieldByName('DISCRI').AsString := RetornaTexto(Servico, '<Discriminacao>', '</Discriminacao>');


  //PRESTADOR DO SERVIÇO
  PrestadorServico := RetornaTexto(strXML, '<PrestadorServico>', '</PrestadorServico>');
  IdentificacaoPrestador := RetornaTexto(PrestadorServico, '<IdentificacaoPrestador>', '</IdentificacaoPrestador>');
  cdsNFS.FieldByName('PSVCNPJ').AsString := RetornaTexto(IdentificacaoPrestador, '<Cnpj>', '</Cnpj>');
  cdsNFS.FieldByName('PSVIM').AsString := RetornaTexto(IdentificacaoPrestador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(PrestadorServico, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('PSVFANT').AsString := RetornaTexto(PrestadorServico, '<NomeFantasia>', '</NomeFantasia>');

  Endereco := RetornaTexto(PrestadorServico, '<Endereco>', '<Contato>');
  cdsNFS.FieldByName('PSVEND').AsString := RetornaTexto(Endereco,'<Endereco>', '</Endereco>');
  cdsNFS.FieldByName('PSVNUM').AsString := RetornaTexto(Endereco, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('PSVBAIR').AsString := RetornaTexto(Endereco, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('PSVMUN').AsString := RetornaTexto(Endereco, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('PSVUF').AsString := RetornaTexto(Endereco, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('PSVCEP').AsString := RetornaTexto(Endereco, '<Cep>', '</Cep>');

  Contato := RetornaTexto(PrestadorServico, '<Contato>', '</Contato>');
  cdsNFS.FieldByName('PSVFONE').AsString := RetornaTexto(Contato, '<Telefone>', '</Telefone>');
  cdsNFS.FieldByName('PSVEMAIL').AsString := RetornaTexto(Contato, '<Email>', '</Email>');
  cdsNFS.FieldByName('IEPRES').AsString := '';


  //TOMADOR DO SERVIÇO
  TomadorServico := RetornaTexto(strXML, '<Tomador>', '</Tomador>');
  IdentificacaoTomador := RetornaTexto(TomadorServico, '<IdentificacaoTomador>', '</IdentificacaoTomador>');
  CpfCnpj := RetornaTexto(IdentificacaoTomador, '<CpfCnpj>', '</CpfCnpj>');
  cdsNFS.FieldByName('TMSCNPJ').AsString := Iif(fEmptyStr(RetornaTexto(CpfCnpj, '<Cnpj>', '</Cnpj>')),
                                                          RetornaTexto(CpfCnpj, '<Cpf>', '</Cpf>'),
                                                          RetornaTexto(CpfCnpj, '<Cnpj>', '</Cnpj>'));

  cdsNFS.FieldByName('TMSRAZAO').AsString := RetornaTexto(TomadorServico, '<RazaoSocial>', '</RazaoSocial>');

  Endereco := RetornaTexto(TomadorServico, '<Endereco>', '<Contato>');
  cdsNFS.FieldByName('TMSEND').AsString := RetornaTexto(Endereco, '<Endereco>', '</Endereco>');
  cdsNFS.FieldByName('TMSNUM').AsString := RetornaTexto(Endereco, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TMSBAIR').AsString := RetornaTexto(Endereco, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TMSMUN').AsString := RetornaTexto(Endereco, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('TMSUF').AsString := RetornaTexto(Endereco, '<Estado>', '</Estado>');
  cdsNFS.FieldByName('TMSCEP').AsString := RetornaTexto(Endereco, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('TMSIM').AsString := RetornaTexto(IdentificacaoTomador, '<InscricaoMunicipal >', '</InscricaoMunicipal >');
  cdsNFS.FieldByName('TMSIE').AsString := '';

  Contato := RetornaTexto(TomadorServico, '<Contato>', '</Contato>');
  cdsNFS.FieldByName('TMSFONE').AsString := RetornaTexto(Contato, '<Telefone>', '</Telefone>');
  cdsNFS.FieldByName('TMSEMAIL').AsString := RetornaTexto(Contato, '<Email>', '</Email>');

  // ORGÃO GERADOR
  OrgaoGerador := RetornaTexto(strXML, '<OrgaoGerador>', '</OrgaoGerador>');
  cdsNFS.FieldByName('ORGMUN').AsString := RetornaTexto(OrgaoGerador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('ORG_UF').AsString := RetornaTexto(OrgaoGerador, '<Uf>', '</Uf>');

  cdsNFS.Post;
end;


end.

