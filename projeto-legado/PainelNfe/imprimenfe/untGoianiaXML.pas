unit untGoianiaXML;

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
  TGoianiaXML = class

    private

    public
      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

implementation

{ TGoianiaXML }

class procedure TGoianiaXML.pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
var
  strIdentRPS,
  strIdentNFS,
  strValores,
  strPrestador,
  strTomador,
  strServico : String;
begin

  cdsNFS.Append;

  strIdentRPS := RetornaTexto(strXML, '<IdentificacaoRps>', '</IdentificacaoRps>');

  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strIdentRPS, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strIdentRPS, '<Serie>', '</Serie>');
  cdsNFS.FieldByName('TPORPS').AsString   := RetornaTexto(strIdentRPS, '<Tipo>', '</Tipo>');

  strIdentNFS := RetornaTexto(strXML, '<InfNfse>', '</InfNfse>');

  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strIdentNFS, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('DTAEMI').AsString   := Copy(RetornaTexto(strIdentNFS, '<DataEmissao>', '</DataEmissao>'),9,2) + '/' +
                                             Copy(RetornaTexto(strIdentNFS, '<DataEmissao>', '</DataEmissao>'),6,2) + '/' +
                                             Copy(RetornaTexto(strIdentNFS, '<DataEmissao>', '</DataEmissao>'),1,4);
  cdsNFS.FieldByName('DTACMP').AsString   := Copy(RetornaTexto(strIdentNFS, '<Competencia>', '</Competencia>'),1,10);
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strIdentNFS, '<CodigoVerificacao>', '</CodigoVerificacao>');

  cdsNFS.FieldByName('ISSRET').AsString   := RetornaTexto(strXML, '<IssRetido>', '</IssRetido>');
  cdsNFS.FieldByName('CODTRI').AsString   := RetornaTexto(strXML, '<CodigoTributacaoMunicipio>', '</CodigoTributacaoMunicipio>');
  cdsNFS.FieldByName('OPTSMP').AsString   := RetornaTexto(strXML, '<OptanteSimplesNacional>', '</OptanteSimplesNacional>');
  cdsNFS.FieldByName('EXIISS').AsString   := RetornaTexto(strXML, '<ExigibilidadeISS>', '</ExigibilidadeISS>');
  cdsNFS.FieldByName('LOCINC').AsString   := RetornaTexto(strXML, '<MunicipioIncidencia>', '</MunicipioIncidencia>');

  strValores := RetornaTexto(strXML, '<Valores>', '</Valores>');

  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strValores, '<ValorServicos>', '</ValorServicos>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strValores, '<ValorDeducoes>', '</ValorDeducoes>'),'.',','), 0);
  cdsNFS.FieldByName('VLRPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strValores, '<ValorPis>', '</ValorPis>'),'.',','), 0);
  cdsNFS.FieldByName('VLRCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strValores, '<ValorCofins>', '</ValorCofins>'),'.',','), 0);
  cdsNFS.FieldByName('VLRINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strValores, '<ValorInss>', '</ValorInss>'),'.',','), 0);
  cdsNFS.FieldByName('VLRIR_').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strValores, '<ValorIr>', '</ValorIr>'),'.',','), 0);
  cdsNFS.FieldByName('VLRCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strValores, '<ValorCsll>', '</ValorCsll>'),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strValores, '<ValorIss>', '</ValorIss>'),'.',','), 0);
  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strValores, '<Aliquota>', '</Aliquota>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDSC').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strValores, '<DescontoIncondicionado>', '</DescontoIncondicionado>'),'.',','), 0);

  strPrestador := RetornaTexto(strXML, '<Prestador>', '</Prestador>');

  cdsNFS.FieldByName('PSVIM_').AsString   := RetornaTexto(strPrestador, '<InscricaoMunicipal>', '</InscricaoMunicipal>');
  cdsNFS.FieldByName('PSVCGC').AsString   := RetornaTexto(strPrestador, '<Cnpj>', '</Cnpj>');
  cdsNFS.FieldByName('PSVIE_').AsString   := EmptyStr;
  cdsNFS.FieldByName('PSVRAZ').AsString   := EmptyStr;
  cdsNFS.FieldByName('PSVEND').AsString   := EmptyStr;
  cdsNFS.FieldByName('PSVNUM').AsString   := EmptyStr;
  cdsNFS.FieldByName('PSVBAI').AsString   := EmptyStr;
  cdsNFS.FieldByName('PSVCID').AsString   := EmptyStr;
  cdsNFS.FieldByName('PSVCEP').AsString   := EmptyStr;
  cdsNFS.FieldByName('PSVUF_').AsString   := EmptyStr;
  cdsNFS.FieldByName('PSVCPL').AsString   := EmptyStr;
  cdsNFS.FieldByName('PSVFON').AsString   := EmptyStr;

  strTomador := RetornaTexto(strXML, '<Tomador>', '</Tomador>');

  cdsNFS.FieldByName('TOMIM_').AsString   := EmptyStr;
  cdsNFS.FieldByName('TOMCGC').AsString   := RetornaTexto(strTomador, '<Cnpj>', '</Cnpj>');
  cdsNFS.FieldByName('TOMIE_').AsString   := EmptyStr;
  cdsNFS.FieldByName('TOMRAZ').AsString   := RetornaTexto(strTomador, '<RazaoSocial>', '</RazaoSocial>');
  cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strTomador, '<Endereco><Endereco>', '</Endereco>');
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strTomador, '<Numero>', '</Numero>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strTomador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strTomador, '<CodigoMunicipio>', '</CodigoMunicipio>');
  cdsNFS.FieldByName('TOMCEP').AsString   := RetornaTexto(strTomador, '<Cep>', '</Cep>');
  cdsNFS.FieldByName('TOMUF_').AsString   := RetornaTexto(strTomador, '<Uf>', '</Uf>');
  cdsNFS.FieldByName('TOMCPL').AsString   := RetornaTexto(strTomador, '<Complemento>', '</Complemento>');

  strServico := RetornaTexto(strXML, '<Servico>', '</Servico>');

  cdsNFS.FieldByName('DISSER').AsString   := RetornaTexto(strServico, '<Discriminacao>', '</Discriminacao>');
  cdsNFS.FieldByName('CODMUN').AsString   := RetornaTexto(strServico, '<CodigoMunicipio>', '</CodigoMunicipio>');

  cdsNFS.Post;

end;

end.
