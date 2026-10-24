unit untSumareXML;

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
  TSumareXML = class
    private
    public
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string);
  end;

implementation

{ TSumareXML }


class procedure TSumareXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML: string);
var
  strDadosPrestador,
  strEnderPrestador,
  strDadosTomador,
  strEnderTomador : String;
  begin

    cdsNFS.Append;

    strDadosPrestador := RetornaTexto(strXML, '<PRESTADOR>', '</PRESTADOR>');
    cdsNFS.FieldByName('DOCPRE').AsString := RetornaTexto(strDadosPrestador, '<cnpj_cpf>', '</cnpj_cpf>');
    cdsNFS.FieldByName('PESPRE').AsString := RetornaTexto(strDadosPrestador, '<pessoa>', '</pessoa>');
    cdsNFS.FieldByName('IEPRES').AsString := RetornaTexto(strDadosPrestador, '<ie>', '</ie>');
    cdsNFS.FieldByName('IMPRES').AsString := RetornaTexto(strDadosPrestador, '<im>', '</im>');
    cdsNFS.FieldByName('NOMPRE').AsString := RetornaTexto(strDadosPrestador, '<razao_social>', '</razao_social>');

    strEnderPrestador := RetornaTexto(strDadosPrestador, '<endereco>', '</endereco>');
    cdsNFS.FieldByName('ENDPRE').AsString := RetornaTexto(strEnderPrestador, '<logradouro>', '</logradouro>');
    cdsNFS.FieldByName('NUENPR').AsString := RetornaTexto(strEnderPrestador, '<numero>', '</numero>');
    cdsNFS.FieldByName('BAIPRE').AsString := RetornaTexto(strEnderPrestador, '<bairro>', '</bairro>');
    cdsNFS.FieldByName('CEPPRE').AsString := RetornaTexto(strEnderPrestador, '<cep>', '</cep>');
    cdsNFS.FieldByName('CIDPRE').AsString := RetornaTexto(strEnderPrestador, '<cidade>', '</cidade>');
    cdsNFS.FieldByName('UFPRES').AsString := RetornaTexto(strEnderPrestador, '<uf>', '</uf>');

    strDadosTomador := RetornaTexto(strXML, '<DESTINATARIO>', '</DESTINATARIO>');
    cdsNFS.FieldByName('EXTDES').AsString := '';
    cdsNFS.FieldByName('DOCDES').AsString := RetornaTexto(strDadosTomador, '<cnpj_cpf>', '</cnpj_cpf>');
    cdsNFS.FieldByName('PESDES').AsString := RetornaTexto(strDadosTomador, '<pessoa>', '</pessoa>');
    cdsNFS.FieldByName('IEDEST').AsString := RetornaTexto(strDadosTomador, '<ie>', '</ie>');
    cdsNFS.FieldByName('IMDEST').AsString := RetornaTexto(strDadosTomador, '<im>', '</im>');
    cdsNFS.FieldByName('NOMDES').AsString := RetornaTexto(strDadosTomador, '<razao_social>', '</razao_social>');
    cdsNFS.FieldByName('EMADES').AsString := RetornaTexto(strDadosTomador, '<email>', '</email>');

    strEnderTomador := RetornaTexto(strDadosTomador, '<endereco>', '</endereco>');
    cdsNFS.FieldByName('ENDDES').AsString := RetornaTexto(strDadosTomador, '<logradouro>', '</logradouro>');
    cdsNFS.FieldByName('NUENDE').AsString := RetornaTexto(strDadosTomador, '<numero>', '</numero>');
    cdsNFS.FieldByName('COMPDE').AsString := RetornaTexto(strDadosTomador, '<complemento>', '</complemento>');
    cdsNFS.FieldByName('BAIDES').AsString := RetornaTexto(strDadosTomador, '<bairro>', '</bairro>');
    cdsNFS.FieldByName('CEPDES').AsString := RetornaTexto(strDadosTomador, '<cep>', '</cep>');
    cdsNFS.FieldByName('CIDDES').AsString := RetornaTexto(strDadosTomador, '<cidade>', '</cidade>');
    cdsNFS.FieldByName('UFDEST').AsString := RetornaTexto(strDadosTomador, '<uf>', '</uf>');
    cdsNFS.FieldByName('PAISDE').AsString := RetornaTexto(strDadosTomador, '<pais>', '</pais>');
    cdsNFS.FieldByName('FONDES').AsString := '';

    cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<numero_nf>', '</numero_nf>');
    cdsNFS.FieldByName('SERIE').AsString  := RetornaTexto(strXML, '<serie>', '</serie>');

    cdsNFS.FieldByName('DEDUCA').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<deducao>', '</deducao>'));
    cdsNFS.FieldByName('VALSER').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<valor_servico>', '</valor_servico>'));
    cdsNFS.FieldByName('VALNFS').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<valor_nf>', '</valor_nf>'));

    cdsNFS.FieldByName('DTAEMI').AsString := RetornaTexto(strXML, '<data_emissao>', '</data_emissao>');
    cdsNFS.FieldByName('DTHRCA').AsString := RetornaTexto(strXML, '<data_cadastro>', '</data_cadastro>');
    cdsNFS.FieldByName('FPAGTO').AsString := RetornaTexto(strXML, '<forma_de_pagamento>', '</forma_de_pagamento>');
    cdsNFS.FieldByName('DESCRI').AsString := RetornaTexto(strXML, '<descricao>', '</descricao>');
    cdsNFS.FieldByName('CODSER').AsString := RetornaTexto(strXML, '<id_codigo_servico>', '</id_codigo_servico>');
    cdsNFS.FieldByName('REGIME').AsString := RetornaTexto(strXML, '<regime>', '</regime>');
    cdsNFS.FieldByName('CANCEL').AsString := RetornaTexto(strXML, '<cancelada>', '</cancelada>');
    cdsNFS.FieldByName('ISSRET').AsString := RetornaTexto(strXML, '<iss_retido>', '</iss_retido>');
    cdsNFS.FieldByName('ALQISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<aliq_iss>', '</aliq_iss>'),'.',','), 0);

    cdsNFS.FieldByName('VALISS').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<valor_iss>', '</valor_iss>'));
    cdsNFS.FieldByName('BC_PIS').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<bc_pis>', '</bc_pis>'));
    cdsNFS.FieldByName('ALQPIS').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<aliq_pis>', '</aliq_pis>'));
    cdsNFS.FieldByName('VALPIS').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<valor_pis>', '</valor_pis>'));
    cdsNFS.FieldByName('BC_COF').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<bc_cofins>', '</bc_cofins>'));
    cdsNFS.FieldByName('ALQCOF').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<aliq_cofins>', '</aliq_cofins>'));
    cdsNFS.FieldByName('VALCOF').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<valor_cofins>', '</valor_cofins>'));
    cdsNFS.FieldByName('BCCSLL').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<bc_csll>', '</bc_csll>'));
    cdsNFS.FieldByName('ALQCSL').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<aliq_csll>', '</aliq_csll>'));
    cdsNFS.FieldByName('VALCSL').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<valor_csll>', '</valor_csll>'));
    cdsNFS.FieldByName('BCIRRF').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<bc_irrf>', '</bc_irrf>'));
    cdsNFS.FieldByName('ALQIRR').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<aliq_irrf>', '</aliq_irrf>'));
    cdsNFS.FieldByName('VALIRR').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<valor_irrf>', '</valor_irrf>'));
    cdsNFS.FieldByName('BCINSS').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<bc_inss>', '</bc_inss>'));
    cdsNFS.FieldByName('ALQINS').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<aliq_inss>', '</aliq_inss>'));
    cdsNFS.FieldByName('VALINS').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<valor_inss>', '</valor_inss>'));
    cdsNFS.FieldByName('NFAVUL').AsString := RetornaTexto(strXML, '<nf_avulsa>', '</nf_avulsa>');
    cdsNFS.FieldByName('SISGER').AsString := RetornaTexto(strXML, '<sistema_gerador>', '</sistema_gerador>');
    cdsNFS.FieldByName('SERRPS').AsString := RetornaTexto(strXML, '<serie_rps>', '</serie_rps>');
    cdsNFS.FieldByName('NUMRPS').AsString := RetornaTexto(strXML, '<rps>', '</rps>');
    cdsNFS.FieldByName('NUMDAN').AsString := RetornaTexto(strXML, '<codigo>', '</codigo>');
    cdsNFS.FieldByName('NFUTI').AsString := '';
    cdsNFS.FieldByName('NUMOS').AsString := '';
    cdsNFS.Post;

  End;
end.
