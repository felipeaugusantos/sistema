unit untValinhosXML;

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
  TValinhosXML = class
    private
    public
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string);
  end;

implementation

{ TValinhosXML }


class procedure TValinhosXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML: string);
begin

  cdsNFS.Append;

  cdsNFS.FieldByName('DOCPRE').AsString := RetornaTexto(strXML, '<cnpj_cpf_prestador>', '</cnpj_cpf_prestador>');
  cdsNFS.FieldByName('PESPRE').AsString := RetornaTexto(strXML, '<pessoa_prestador>', '</pessoa_prestador>');
  cdsNFS.FieldByName('IEPRES').AsString := RetornaTexto(strXML, '<ie_prestador>', '</ie_prestador>');
  cdsNFS.FieldByName('IMPRES').AsString := RetornaTexto(strXML, '<im_prestador>', '</im_prestador>');
  cdsNFS.FieldByName('NOMPRE').AsString := RetornaTexto(strXML, '<razao_social_prestador>', '</razao_social_prestador>');

  cdsNFS.FieldByName('ENDPRE').AsString := RetornaTexto(strXML, '<endereco_prestador>', '</endereco_prestador>');
  cdsNFS.FieldByName('NUENPR').AsString := RetornaTexto(strXML, '<numero_ende_prestador>', '</numero_ende_prestador>');
  cdsNFS.FieldByName('BAIPRE').AsString := RetornaTexto(strXML, '<bairro_prestador>', '</bairro_prestador>');
  cdsNFS.FieldByName('CEPPRE').AsString := RetornaTexto(strXML, '<cep_prestador>', '</cep_prestador>');
  cdsNFS.FieldByName('CIDPRE').AsString := RetornaTexto(strXML, '<cidade_prestador>', '</cidade_prestador>');
  cdsNFS.FieldByName('UFPRES').AsString := RetornaTexto(strXML, '<uf_prestador>', '</uf_prestador>');

  cdsNFS.FieldByName('EXTDES').AsString := '';
  cdsNFS.FieldByName('DOCDES').AsString := RetornaTexto(strXML, '<cnpj_cpf_destinatario>', '</cnpj_cpf_destinatario>');
  cdsNFS.FieldByName('PESDES').AsString := RetornaTexto(strXML, '<pessoa_destinatario>', '</pessoa_destinatario>');
  cdsNFS.FieldByName('IEDEST').AsString := RetornaTexto(strXML, '<ie_destinatario>', '</ie_destinatario>');
  cdsNFS.FieldByName('IMDEST').AsString := RetornaTexto(strXML, '<im_destinatario>', '</im_destinatario>');
  cdsNFS.FieldByName('NOMDES').AsString := RetornaTexto(strXML, '<razao_social_destinatario>', '</razao_social_destinatario>');
  cdsNFS.FieldByName('EMADES').AsString := RetornaTexto(strXML, '<email_destinatario>', '</email_destinatario>');
  cdsNFS.FieldByName('FONDES').AsString := RetornaTexto(strXML, '<fone_destinatario>', '</fone_destinatario>');

  cdsNFS.FieldByName('ENDDES').AsString := RetornaTexto(strXML, '<endereco_destinatario>', '</endereco_destinatario>');
  cdsNFS.FieldByName('NUENDE').AsString := RetornaTexto(strXML, '<numero_ende_destinatario>', '</numero_ende_destinatario>');
  cdsNFS.FieldByName('COMPDE').AsString := RetornaTexto(strXML, '<complemento_destinatario>', '</complemento_destinatario>');
  cdsNFS.FieldByName('BAIDES').AsString := RetornaTexto(strXML, '<bairro_destinatario>', '</bairro_destinatario>');
  cdsNFS.FieldByName('CEPDES').AsString := RetornaTexto(strXML, '<cep_destinatario>', '</cep_destinatario>');
  cdsNFS.FieldByName('CIDDES').AsString := RetornaTexto(strXML, '<cidade_destinatario>', '</cidade_destinatario>');
  cdsNFS.FieldByName('UFDEST').AsString := RetornaTexto(strXML, '<uf_destinatario>', '</uf_destinatario>');
  cdsNFS.FieldByName('PAISDE').AsString := RetornaTexto(strXML, '<pais_destinatario>', '</pais_destinatario>');


  cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<numero_nf>', '</numero_nf>');
  cdsNFS.FieldByName('SERIE').AsString  := RetornaTexto(strXML, '<serie>', '</serie>');

  cdsNFS.FieldByName('DEDUCA').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<deducao>', '</deducao>'));
  cdsNFS.FieldByName('VALSER').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<valor_servico>', '</valor_servico>'));
  cdsNFS.FieldByName('VALNFS').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<valor_nf>', '</valor_nf>'));

  cdsNFS.FieldByName('DTAEMI').AsString := RetornaTexto(strXML, '<data_emissao>', '</data_emissao>');
  cdsNFS.FieldByName('DTHRCA').AsString := RetornaTexto(strXML, '<data_cadastro>', '</data_cadastro>');
  cdsNFS.FieldByName('FPAGTO').AsString := RetornaTexto(strXML, '<forma_de_pagamento>', '</forma_de_pagamento>');
  cdsNFS.FieldByName('DESCRI').AsString := RetornaTexto(strXML, '<descricao>', '</descricao>');
  cdsNFS.FieldByName('CODSER').AsString := RetornaTexto(strXML, '<id_codigo_servico>', '</id_codigo_servico>');
  cdsNFS.FieldByName('REGIME').AsString := RetornaTexto(strXML, '<regime>', '</regime>');
  cdsNFS.FieldByName('CANCEL').AsString := RetornaTexto(strXML, '<cancelada>', '</cancelada>');
  cdsNFS.FieldByName('ISSRET').AsString := RetornaTexto(strXML, '<iss_retido>', '</iss_retido>');
  cdsNFS.FieldByName('ALQISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<aliq_iss>', '</aliq_iss>'),'.',','), 0);

  cdsNFS.FieldByName('VALISS').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<valor_iss>', '</valor_iss>'));
  cdsNFS.FieldByName('BC_PIS').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<bc_pis>', '</bc_pis>'));
  cdsNFS.FieldByName('ALQPIS').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<aliq_pis>', '</aliq_pis>'));
  cdsNFS.FieldByName('VALPIS').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<valor_pis>', '</valor_pis>'));
  cdsNFS.FieldByName('BC_COF').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<bc_cofins>', '</bc_cofins>'));
  cdsNFS.FieldByName('ALQCOF').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<aliq_cofins>', '</aliq_cofins>'));
  cdsNFS.FieldByName('VALCOF').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<valor_cofins>', '</valor_cofins>'));
  cdsNFS.FieldByName('BCCSLL').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<bc_csll>', '</bc_csll>'));
  cdsNFS.FieldByName('ALQCSL').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<aliq_csll>', '</aliq_csll>'));
  cdsNFS.FieldByName('VALCSL').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<valor_csll>', '</valor_csll>'));
  cdsNFS.FieldByName('BCIRRF').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<bc_irrf>', '</bc_irrf>'));
  cdsNFS.FieldByName('ALQIRR').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<aliq_irrf>', '</aliq_irrf>'));
  cdsNFS.FieldByName('VALIRR').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<valor_irrf>', '</valor_irrf>'));
  cdsNFS.FieldByName('BCINSS').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<bc_inss>', '</bc_inss>'));
  cdsNFS.FieldByName('ALQINS').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<aliq_inss>', '</aliq_inss>'));
  cdsNFS.FieldByName('VALINS').AsFloat  := fStrToFloatDef(RetornaTexto(strXML, '<valor_inss>', '</valor_inss>'));

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
