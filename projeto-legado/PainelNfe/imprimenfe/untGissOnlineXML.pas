unit untGissOnlineXML;

interface

uses
{$IF Defined(LINUX)}
  Uni,
  NFe.Modulo,
  FMX.frxClass,
  FMX.frxBarcode,
  FMX.frxDBSet,
  FMX.frxDelphiZXingQRCode,
  FMX.frxDesgn,
  FMX.frxExportPDF,
  untUniClientDataSet,
{$ELSE}
  Windows, Messages, Graphics,
  Controls, Forms, frxClass, ComCtrls, StdCtrls, ExtCtrls,
  {$IF Defined(UNIDAC)}
    UniClientDataSet, Uni, MySQLUniProvider, UniProvider,
  {$ELSE}
   ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  DBCtrls, DB, MemDS, Dialogs,
  frxBarcode, frxDBSet, frxDelphiZXingQRCode, frxDesgn,
  untUniClientDataSet,
{$IFEND}
  XMLDoc, SysUtils, Variants, Classes, DBClient, untUtil, StrUtils, untConexaoBD;

type
  TGissOnlineXML = class
    private
    public
      Class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML: string; strNumDoc, strCodEmp, strEspDoc: string; cdsFaturas: TUniClientDataSet);
      Class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS: TUniClientDataSet; strXML: string; strNumDoc, strCodEmp, strEspDoc: string; cdsFaturas: TUniClientDataSet);
  end;

implementation

{ TGissOnlineXML }

class procedure TGissOnlineXML.pRetornaCDSPreenchido(
  var cdsNFS: TUniClientDataSet; strXML: string; strNumDoc, strCodEmp, strEspDoc: string; cdsFaturas: TUniClientDataSet);
var
  xmlDoc: TXMLDocument;
  strValor, strDeducao: string;
  strXMLCorrigido: string;
  qryDuplicata: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  xmlDoc := TXMLDocument.Create(Application);
  try

    strXMLCorrigido := AnsiReplaceStr(strXML,'>n','>');
    xmlDoc.LoadFromXML(strXMLCorrigido);
    xmlDoc.Active := True;

    cdsNFS.Append;
    cdsNFS.FieldByName('DOCPRE').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['cnpj_cpf_prestador'].Text;
    cdsNFS.FieldByName('PESPRE').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['pessoa_prestador'].Text;
    cdsNFS.FieldByName('IEPRES').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['ie_prestador'].Text;
    cdsNFS.FieldByName('IMPRES').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['im_prestador'].Text;
    cdsNFS.FieldByName('NOMPRE').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['razao_social_prestador'].Text;
    cdsNFS.FieldByName('ENDPRE').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['endereco_prestador'].Text;
    cdsNFS.FieldByName('NUENPR').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['numero_ende_prestador'].Text;
    cdsNFS.FieldByName('BAIPRE').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['bairro_prestador'].Text;
    cdsNFS.FieldByName('CEPPRE').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['cep_prestador'].Text;
    cdsNFS.FieldByName('CIDPRE').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['cidade_prestador'].Text;
    cdsNFS.FieldByName('UFPRES').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['uf_prestador'].Text;
    cdsNFS.FieldByName('EXTDES').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['exterior_dest'].Text;
    cdsNFS.FieldByName('DOCDES').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['cnpj_cpf_destinatario'].Text;
    cdsNFS.FieldByName('PESDES').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['pessoa_destinatario'].Text;
    cdsNFS.FieldByName('IEDEST').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['ie_destinatario'].Text;
    cdsNFS.FieldByName('IMDEST').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['im_destinatario'].Text;
    cdsNFS.FieldByName('NOMDES').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['razao_social_destinatario'].Text;
    cdsNFS.FieldByName('ENDDES').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['endereco_destinatario'].Text;
    cdsNFS.FieldByName('NUENDE').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['numero_ende_destinatario'].Text;
    cdsNFS.FieldByName('COMPDE').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['complemento_ende_destinatario'].Text;
    cdsNFS.FieldByName('BAIDES').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['bairro_destinatario'].Text;
    cdsNFS.FieldByName('CEPDES').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['cep_destinatario'].Text;
    cdsNFS.FieldByName('CIDDES').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['cidade_destinatario'].Text;
    cdsNFS.FieldByName('UFDEST').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['uf_destinatario'].Text;
    cdsNFS.FieldByName('PAISDE').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['pais_destinatario'].Text;
    cdsNFS.FieldByName('FONDES').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['fone_destinatario'].Text;
    cdsNFS.FieldByName('EMADES').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['email_destinatario'].Text;
    cdsNFS.FieldByName('NUMNFS').AsString := fStrZero(xmlDoc.ChildNodes['notafiscal'].ChildNodes['numero_nf'].Text, 8);
    cdsNFS.FieldByName('SERIE').AsString  := xmlDoc.ChildNodes['notafiscal'].ChildNodes['serie'].Text;
    cdsNFS.FieldByName('DEDUCA').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['deducao'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALSER').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['valor_servico'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALNFS').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['valor_nf'].Text,'.',','), 0);
    cdsNFS.FieldByName('DTAEMI').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['data_emissao'].Text;
    cdsNFS.FieldByName('FPAGTO').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['forma_de_pagamento'].Text;
    cdsNFS.FieldByName('DESCRI').AsString := AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['descricao'].Text, 'rnrn', '');
    cdsNFS.FieldByName('CODSER').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['id_codigo_servico'].Text;
    cdsNFS.FieldByName('REGIME').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['regime'].Text;
    cdsNFS.FieldByName('CANCEL').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['cancelada'].Text;
    cdsNFS.FieldByName('ISSRET').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['iss_retido'].Text;
    cdsNFS.FieldByName('ALQISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['aliq_iss'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALISS').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['valor_iss'].Text,'.',','), 0);
    cdsNFS.FieldByName('BC_PIS').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['bc_pis'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALQPIS').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['aliq_pis'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALPIS').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['valor_pis'].Text,'.',','), 0);
    cdsNFS.FieldByName('BC_COF').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['bc_cofins'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALQCOF').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['aliq_cofins'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCOF').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['valor_cofins'].Text,'.',','), 0);
    cdsNFS.FieldByName('BCCSLL').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['bc_csll'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALQCSL').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['aliq_csll'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCSL').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['valor_csll'].Text,'.',','), 0);
    cdsNFS.FieldByName('BCIRRF').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['bc_irrf'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALQIRR').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['aliq_irrf'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALIRR').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['valor_irrf'].Text,'.',','), 0);
    cdsNFS.FieldByName('BCINSS').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['bc_inss'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALQINS').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['aliq_inss'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALINS').AsFloat  := StrToFloatDef(AnsiReplaceStr(xmlDoc.ChildNodes['notafiscal'].ChildNodes['valor_inss'].Text,'.',','), 0);
    cdsNFS.FieldByName('NFAVUL').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['nf_avulsa'].Text;
    cdsNFS.FieldByName('SISGER').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['sistema_gerador'].Text;
    cdsNFS.FieldByName('SERRPS').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['serie_rps'].Text;
    cdsNFS.FieldByName('NUMRPS').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['rps'].Text;
    cdsNFS.FieldByName('NUMDAN').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['codigo'].Text;
    cdsNFS.FieldByName('LOCPRE').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['cidade_local_prest'].Text + '-' +
                                             xmlDoc.ChildNodes['notafiscal'].ChildNodes['uf_local_prest'].Text;
    cdsNFS.FieldByName('PAIPRE').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['pais_local_prest'].Text;
    cdsNFS.FieldByName('CODNBS').AsString := xmlDoc.ChildNodes['notafiscal'].ChildNodes['codigo_nbs'].Text;
    cdsNFS.Post;

    qryDuplicata := fCriaQuery;
    Try
      if Assigned(cdsFaturas) then
      Begin
        qryDuplicata.Close;
        qryDuplicata.SQL.Clear;
        qryDuplicata.SQL.Add('SET @SEQDET := 0; ');
        qryDuplicata.SQL.Add('');
        qryDuplicata.SQL.Add('SELECT CTR_DTAVEN, ');
        qryDuplicata.SQL.Add('       IF(CTR_VALDUP = 0, CTR_VALORI, CTR_VALDUP) AS VALDUP, ');
        qryDuplicata.SQL.Add('       @SEQDET := IFNULL(@SEQDET,0) + 1 AS SEQDET ');
        qryDuplicata.SQL.Add('FROM CADREC ');
        qryDuplicata.SQL.Add('WHERE CTR_NUMDUP = :NUMDOC ');
        qryDuplicata.SQL.Add('  AND CTR_CODEMP = :CODEMP ');
        qryDuplicata.SQL.Add('  AND CTR_ESPDOC = :ESPDOC ');
        qryDuplicata.SQL.Add('ORDER BY CTR_DTAVEN ');

        qryDuplicata.ParamByName('NUMDOC').AsString := strNumdoc;
        qryDuplicata.ParamByName('CODEMP').AsString := strCodEmp;
        qryDuplicata.ParamByName('ESPDOC').AsString := strEspDoc;

        qryDuplicata.Open;

        qryDuplicata.First;
        while not qryDuplicata.Eof do
        Begin
          cdsFaturas.Append;
          cdsFaturas.FieldByName('FATNUM').AsString := qryDuplicata.FieldByName('SEQDET').asString;
          cdsFaturas.FieldByName('DTAVEN').AsString := qryDuplicata.FieldByName('CTR_DTAVEN').asString;
          cdsFaturas.FieldByName('VALFAT').AsFloat  := qryDuplicata.FieldByName('VALDUP').asFloat;
          cdsFaturas.Post;

          qryDuplicata.Next;
        End;
      End;
    Finally
      FreeAndNil(qryDuplicata);
    End;

  finally
    FreeAndNil(xmlDoc);
  end;

end;

class procedure TGissOnlineXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML: string; strNumDoc, strCodEmp, strEspDoc: string; cdsFaturas: TUniClientDataSet);
var
  strDadosPrestador,
  strEnderPrestador,
  strDadosTomador,
  strEnderTomador : String;
  qryDuplicata: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
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
  cdsNFS.FieldByName('EMADES').AsString := '';

  cdsNFS.FieldByName('NUMNFS').AsString := RetornaTexto(strXML, '<numero_nf>', '</numero_nf>');
  cdsNFS.FieldByName('SERIE').AsString  := RetornaTexto(strXML, '<serie>', '</serie>');

  cdsNFS.FieldByName('DEDUCA').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<deducao>', '</deducao>'));
  cdsNFS.FieldByName('VALSER').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<valor_servico>', '</valor_servico>'));
  cdsNFS.FieldByName('VALNFS').AsFloat  := fRetornaValor(RetornaTexto(strXML, '<valor_nf>', '</valor_nf>'));

  cdsNFS.FieldByName('DTAEMI').AsString := RetornaTexto(strXML, '<data_emissao>', '</data_emissao>');
  cdsNFS.FieldByName('FPAGTO').AsString := RetornaTexto(strXML, '<forma_de_pagamento>', '</forma_de_pagamento>');
  cdsNFS.FieldByName('DESCRI').AsString := AnsiReplaceStr(RetornaTexto(strXML, '<descricao>', '</descricao>'), 'rnrn', '');
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
  cdsNFS.FieldByName('LOCPRE').AsString := RetornaTexto(strXML, '<cidade_local_prest>', '</cidade_local_prest>') + '-' +
                                           RetornaTexto(strXML, '<uf_local_prest>', '</uf_local_prest>');
  cdsNFS.FieldByName('PAIPRE').AsString := RetornaTexto(strXML, '<pais_local_prest>', '</pais_local_prest>');
  cdsNFS.FieldByName('CODNBS').AsString := RetornaTexto(strXML, '<codigo_nbs>', '</codigo_nbs>');

  cdsNFS.Post;

  qryDuplicata := fCriaQuery;
  Try
    if Assigned(cdsFaturas) then
    Begin
      qryDuplicata.Close;
      qryDuplicata.SQL.Clear;
      qryDuplicata.SQL.Add('SET @SEQDET := 0; ');
      qryDuplicata.SQL.Add('');
      qryDuplicata.SQL.Add('SELECT CTR_DTAVEN, ');
      qryDuplicata.SQL.Add('       IF(CTR_VALDUP = 0, CTR_VALORI, CTR_VALDUP) AS VALDUP, ');
      qryDuplicata.SQL.Add('       @SEQDET := IFNULL(@SEQDET,0) + 1 AS SEQDET ');
      qryDuplicata.SQL.Add('FROM CADREC ');
      qryDuplicata.SQL.Add('WHERE CTR_NUMDUP = :NUMDOC ');
      qryDuplicata.SQL.Add('  AND CTR_CODEMP = :CODEMP ');
      qryDuplicata.SQL.Add('  AND CTR_ESPDOC = :ESPDOC ');
      qryDuplicata.SQL.Add('ORDER BY CTR_DTAVEN ');

      qryDuplicata.ParamByName('NUMDOC').AsString := strNumdoc;
      qryDuplicata.ParamByName('CODEMP').AsString := strCodEmp;
      qryDuplicata.ParamByName('ESPDOC').AsString := strEspDoc;

      qryDuplicata.Open;

      qryDuplicata.First;
      while not qryDuplicata.Eof do
      Begin
        cdsFaturas.Append;
        cdsFaturas.FieldByName('FATNUM').AsString := qryDuplicata.FieldByName('SEQDET').asString;
        cdsFaturas.FieldByName('DTAVEN').AsString := qryDuplicata.FieldByName('CTR_DTAVEN').asString;
        cdsFaturas.FieldByName('VALFAT').AsFloat  := qryDuplicata.FieldByName('VALDUP').asFloat;
        cdsFaturas.Post;

        qryDuplicata.Next;
      End;
    End;
  Finally
    FreeAndNil(qryDuplicata);
  End;
end;

end.
