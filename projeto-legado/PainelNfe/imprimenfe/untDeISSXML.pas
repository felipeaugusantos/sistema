unit untDeISSXML;

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
  TDeISSXML = class
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);
  end;

implementation

{ TDeISSXML }

class procedure TDeISSXML.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string);
begin
  //
end;

class procedure TDeISSXML.pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string);
var
  strDadosPrestador,
  strDadosRPS,
  strServico,
  strDadosTomador,
  strOrgaoGerador : String;
begin

  cdsNFS.Append;

  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strXML, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('CODVER').AsString   := Copy(RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>'),1,3)+'.'+
                                             Copy(RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>'),4,3)+'.'+
                                             Copy(RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>'),7,3);
  cdsNFS.FieldByName('DTAEMI').AsString   := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),1,4);
  cdsNFS.FieldByName('HRAEMI').AsString   := Copy(RetornaTexto(strXML, '<DataEmissao>', '</DataEmissao>'),12,8);
  cdsNFS.FieldByName('OUTINF').AsString   := RetornaTexto(strXML, '<OutrasInformacoes>', '</OutrasInformacoes>');
  cdsNFS.FieldByName('COMPET').AsString   := Copy(RetornaTexto(strXML, '<Competencia>', '</Competencia>'),9,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<Competencia>', '</Competencia>'),6,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<Competencia>', '</Competencia>'),1,4);

  strDadosRPS := RetornaTexto(strXML, '<Rps>', '</Rps>');
  cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strDadosRPS, '<Serie>', '</Serie>');
  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strDadosRPS, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TPORPS').AsString   := RetornaTexto(strDadosRPS, '<Tipo>', '</Tipo>');
  cdsNFS.FieldByName('EMIRPS').AsString   := Copy(RetornaTexto(strDadosRPS, '<DataEmissao>', '</DataEmissao>'),9,2)+'/'+
                                             Copy(RetornaTexto(strDadosRPS, '<DataEmissao>', '</DataEmissao>'),6,2)+'/'+
                                             Copy(RetornaTexto(strDadosRPS, '<DataEmissao>', '</DataEmissao>'),1,4);
  cdsNFS.FieldByName('STSRPS').AsString   := RetornaTexto(strXML, '<Status>', '</Status>');

  strDadosPrestador := RetornaTexto(strXML, '<PrestadorServico>', '</PrestadorServico>');
  cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(strDadosPrestador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strDadosPrestador, '<Cnpj>', '</Cnpj>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strDadosPrestador, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('PSVFANTA').AsString := RetornaTexto(strDadosPrestador, '<NomeFantasia>', '</NomeFantasia>');

  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strDadosPrestador, '<Endereco><Endereco>', '</Endereco>');
  cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strDadosPrestador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('PSVBAI').AsString   := RetornaTexto(strDadosPrestador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strDadosPrestador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strDadosPrestador, '<Cep>', '</Cep>');

  cdsNFS.FieldByName('STATUS').AsString   := '';
  cdsNFS.FieldByName('TRINFE').AsString   := '';

  strServico := RetornaTexto(strXML, '<Servico>', '</Servico>');
  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorDeducoes>', '</ValorDeducoes>'),'.',','), 0);
  cdsNFS.FieldByName('VLRPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorPis>', '</ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VLRCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorCofins>', '</ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VLRINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorInss>', '</ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VLRIRR').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorIr>', '</ValorIr>'),'.',','), 0);
  cdsNFS.FieldByName('VLRCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorCsll>', '</ValorCsll>'),'.',','), 0);
  cdsNFS.FieldByName('VLROUT').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<OutrasRetencoes>', '</OutrasRetencoes>'),'.',','), 0);
  cdsNFS.FieldByName('VLRTTR').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValTotTributos>', '</ValTotTributos>'),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIss>', '</ValorIss>'),'.',','), 0);
  cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strServico, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);

  cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strServico, '<ItemListaServico>', '</ItemListaServico>');
  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<Aliquota>', '</Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('ISSRET').AsString   := RetornaTexto(strServico, '<IssRetido>', '</IssRetido>');
  cdsNFS.FieldByName('DISSER').AsString   := RetornaTexto(strServico, '<Discriminacao>', '</Discriminacao>');
  cdsNFS.FieldByName('ISSEXI').AsString   := RetornaTexto(strServico, '<ExigibilidadeISS>', '</ExigibilidadeISS>');
  cdsNFS.FieldByName('MUNINC').AsString   := RetornaTexto(strServico, '<MunicipioIncidencia>', '</MunicipioIncidencia>');

  strDadosTomador := RetornaTexto(strXML, '<Tomador>', '</Tomador>');
  if Length(RetornaTexto(strDadosTomador, '<Cnpj>', '</Cnpj>')) > 0 then
    cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strDadosTomador, '<IdentificacaoTomador><CpfCnpj><Cnpj>', '</Cnpj>')
  else
    cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strDadosTomador, '<IdentificacaoTomador><CpfCnpj><Cpf>', '</Cpf>');
  cdsNFS.FieldByName('TOMIE').AsString    := '';
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strDadosTomador, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strDadosTomador, '<Endereco><Endereco>', '</Endereco>');
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strDadosTomador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strDadosTomador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strDadosTomador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('TOMCEP').AsString   := RetornaTexto(strDadosTomador, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strDadosTomador, '<Email>', '</Email>');
  cdsNFS.FieldByName('OPCSN_').AsString   := RetornaTexto(strXML, '<OptanteSimplesNacional>', '</OptanteSimplesNacional>');
  cdsNFS.FieldByName('INCFIS').AsString   := RetornaTexto(strXML, '<IncentivoFiscal>', '</IncentivoFiscal>');
  cdsNFS.FieldByName('TOMCOM').AsString   := RetornaTexto(strDadosTomador, '<Complemento>', '</Complemento>');

  cdsNFS.FieldByName('VALCRE').AsFloat    := 0;
  cdsNFS.FieldByName('LOCMUN').AsString   := 'INDAIATUBA';
  cdsNFS.FieldByName('LOC_UF').AsString   := 'SP';

  strOrgaoGerador := RetornaTexto(strXML, '<OrgaoGerador>', '</OrgaoGerador>');
  cdsNFS.FieldByName('ORGMUN').AsString   := RetornaTexto(strOrgaoGerador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('ORG_UF').AsString   := RetornaTexto(strOrgaoGerador, '<Uf>', '</Uf>');

  cdsNFS.Post;
end;

end.
