unit untSaoPauloCapitalXML;

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
  TSaoPauloCapitalXML = class

    private
      class function fRetornaCodigoServicoSP( strCodSer: String ): String ;
    public
      class procedure pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);

  end;

implementation

{ TSaoPauloCapitalXML }

class function TSaoPauloCapitalXML.fRetornaCodigoServicoSP( strCodSer: String ) : String;
const
   //ANEXO 1 DA INSTRUÇÃO NORMATIVA SF/SUREM Nº 8/2011
   ACodServPrefeituraSP : Array[0..10] Of Array[0..1] Of String = (
                         ('07285', '1406'),
                         ('07315', '1406'),
                         ('07323', '1406'),
                         ('07331', '1401'),
                         ('07366', '1401'),
                         ('07390', '1401'),
                         ('07412', '1401'),
                         ('07439', '1401'),
                         ('07447', '1401'),
                         ('07455', '1401'),
                         ('03158', '1702'));
var
  intContador: integer;
begin

  Result := EmptyStr;
  for intContador := Low(ACodServPrefeituraSP) to High(ACodServPrefeituraSP) do
  begin
    if ACodServPrefeituraSP[intContador, 0] = strCodSer then
      Result := ACodServPrefeituraSP[intContador, 1] ;
  end;

end;

class procedure TSaoPauloCapitalXML.pRetornaCDSPreenchido(var cdsNFS : TUniClientDataSet; strXML: string; strCidadeNFSe: string='';cdsItens : TUniClientDataSet=nil);
var
  strEnderPrestador,
  strEnderTomador : String;
begin

  cdsNFS.Append;

  cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(strXML, '<InscricaoPrestador>', '</InscricaoPrestador>');
  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strXML, '<NumeroNFe>', '</NumeroNFe>');
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>');
  cdsNFS.FieldByName('DTAEMI').AsString   := Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),9,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),6,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),1,4);
  cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strXML, '<SerieRPS>', '</SerieRPS>');
  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strXML, '<NumeroRPS>', '</NumeroRPS>');
  cdsNFS.FieldByName('TPORPS').AsString   := RetornaTexto(strXML, '<TipoRPS>', '</TipoRPS>');
  cdsNFS.FieldByName('EMIRPS').AsString   := Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),9,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),6,2)+'/'+
                                             Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),1,4);
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strXML, '<CPFCNPJPrestador><CNPJ>', '</CNPJ>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strXML, '<RazaoSocialPrestador>', '</RazaoSocialPrestador>');
  strEnderPrestador := RetornaTexto(strXML, '<EnderecoPrestador>', '</EnderecoPrestador>');
  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strEnderPrestador, '<Logradouro>', '</Logradouro>');
  cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strEnderPrestador, '<NumeroEndereco>', '</NumeroEndereco>');
  cdsNFS.FieldByName('PSVBAI').AsString   := RetornaTexto(strEnderPrestador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strEnderPrestador, '<Cidade>', '</Cidade>');
  cdsNFS.FieldByName('PSVCEP').AsString   := IfThen(Length(Trim(RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>')))=7, '0'+Trim(RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>')), RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>'));
  cdsNFS.FieldByName('STATUS').AsString   := RetornaTexto(strXML, '<StatusNFe>', '</StatusNFe>');
  cdsNFS.FieldByName('TRINFE').AsString   := RetornaTexto(strXML, '<TributacaoNFe>', '</TributacaoNFe>');
  cdsNFS.FieldByName('VLRSER').AsFloat    := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorServicos>', '</ValorServicos>'),'.',','));
  cdsNFS.FieldByName('VALCRE').AsFloat    := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCredito>', '</ValorCredito>'),'.',','));
  cdsNFS.FieldByName('VLRDED').AsFloat    := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorDeducoes>', '</ValorDeducoes>'),'.',','));
  cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strXML, '<CodigoServico>', '</CodigoServico>');
  cdsNFS.FieldByName('ALISER').AsFloat    := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AliquotaServicos>', '</AliquotaServicos>'),'.',','));
  cdsNFS.FieldByName('ISSRET').AsString   := RetornaTexto(strXML, '<ISSRetido>', '</ISSRetido>');
  if Length(fTiraCaracEspeciaisPonto(RetornaTexto(strXML, '<CPFCNPJTomador><CNPJ>', '</CNPJ>')))=14 then
    cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strXML, '<CPFCNPJTomador><CNPJ>', '</CNPJ>');
  if Length(fTiraCaracEspeciaisPonto(RetornaTexto(strXML, '<CPFCNPJTomador><CPF>', '</CPF>')))=11 then
    cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strXML, '<CPFCNPJTomador><CPF>', '</CPF>');
  cdsNFS.FieldByName('TOMIE').AsString    := RetornaTexto(strXML, '<InscricaoEstadualTomador>', '</InscricaoEstadualTomador>');
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strXML, '<RazaoSocialTomador>', '</RazaoSocialTomador>');
  strEnderTomador := RetornaTexto(strXML, '<EnderecoTomador>', '</EnderecoTomador>');
  cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strEnderTomador, '<Logradouro>', '</Logradouro>');
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strEnderTomador, '<NumeroEndereco>', '</NumeroEndereco>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strEnderTomador, '<Bairro>', '</Bairro>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strEnderTomador, '<Cidade>', '</Cidade>');
  cdsNFS.FieldByName('TOMCEP').AsString   := IfThen(Length(Trim(RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>')))=7, '0'+Trim(RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>')), RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>'));
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strXML, '<EmailTomador>', '</EmailTomador>');
  cdsNFS.FieldByName('DISSER').AsString   := RetornaTexto(strXML, '<Discriminacao>', '</Discriminacao>');
  cdsNFS.FieldByName('LOCMUN').AsString   := 'SÃO PAULO';
  cdsNFS.FieldByName('LOC_UF').AsString   := 'SP';
  cdsNFS.Post;
end;

class procedure TSaoPauloCapitalXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML, strCidadeNFSe: string;
  cdsItens: TUniClientDataSet);
var
  strEnderPrestador,
  strEnderTomador,
  strDoctoTomador,
  strIBSCBS,
  strRetornoComplementarIBSCBS: String;
begin

  cdsNFS.Append;

  try
    cdsNFS.FieldByName('NUMNFS').AsString   := FormatFloat('00000000', StrToInt(RetornaTexto(strXML, '<NumeroNFe>', '</NumeroNFe>')));
    cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<CodigoVerificacao>', '</CodigoVerificacao>');
    cdsNFS.FieldByName('DTAEMI').AsString   := Copy(RetornaTexto(strXML, '<DataEmissaoNFe>', '</DataEmissaoNFe>'),9,2)+'/'+
                                               Copy(RetornaTexto(strXML, '<DataEmissaoNFe>', '</DataEmissaoNFe>'),6,2)+'/'+
                                               Copy(RetornaTexto(strXML, '<DataEmissaoNFe>', '</DataEmissaoNFe>'),1,4);
    cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strXML, '<SerieRPS>', '</SerieRPS>');
    cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strXML, '<NumeroRPS>', '</NumeroRPS>');
    cdsNFS.FieldByName('TPORPS').AsString   := RetornaTexto(strXML, '<TipoRPS>', '</TipoRPS>');
    cdsNFS.FieldByName('EMIRPS').AsString   := Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),9,2)+'/'+
                                               Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),6,2)+'/'+
                                               Copy(RetornaTexto(strXML, '<DataEmissaoRPS>', '</DataEmissaoRPS>'),1,4);
    cdsNFS.FieldByName('PSVIM').AsString    := RetornaTexto(strXML, '<InscricaoPrestador>', '</InscricaoPrestador>');
    cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strXML, '<CPFCNPJPrestador><CNPJ>', '</CNPJ>');
    cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strXML, '<RazaoSocialPrestador>', '</RazaoSocialPrestador>');
    strEnderPrestador := RetornaTexto(strXML, '<EnderecoPrestador>', '</EnderecoPrestador>');
    cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strEnderPrestador, '<TipoLogradouro>', '</TipoLogradouro>')+' '+
                                               RetornaTexto(strEnderPrestador, '<Logradouro>', '</Logradouro>');
    cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strEnderPrestador, '<NumeroEndereco>', '</NumeroEndereco>');
    cdsNFS.FieldByName('PSVBAI').AsString   := RetornaTexto(strEnderPrestador, '<Bairro>', '</Bairro>');
    cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strEnderPrestador, '<Cidade>', '</Cidade>');
    cdsNFS.FieldByName('PSVUF').AsString    := RetornaTexto(strEnderPrestador, '<UF>', '</UF>');
    cdsNFS.FieldByName('PSVCEP').AsString   := IfThen(Length(Trim(RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>')))=7, '0'+Trim(RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>')), RetornaTexto(strEnderPrestador, '<CEP>', '</CEP>'));
    cdsNFS.FieldByName('STATUS').AsString   := RetornaTexto(strXML, '<StatusNFe>', '</StatusNFe>');
    cdsNFS.FieldByName('TRINFE').AsString   := RetornaTexto(strXML, '<TributacaoNFe>', '</TributacaoNFe>');
    cdsNFS.FieldByName('VLRSER').AsFloat    := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorServicos>', '</ValorServicos>'),'.',','));
    cdsNFS.FieldByName('VALCRE').AsFloat    := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCredito>', '</ValorCredito>'),'.',','));
    cdsNFS.FieldByName('VLRDED').AsFloat    := 0;
    cdsNFS.FieldByName('CODSER').AsString   := fRetornaCodigoServicoSP(FormatFloat('00000', StrToInt(RetornaTexto(strXML, '<CodigoServico>', '</CodigoServico>'))));
    cdsNFS.FieldByName('CDSRSP').AsString   := FormatFloat('00000', StrToInt(RetornaTexto(strXML, '<CodigoServico>', '</CodigoServico>')));
    cdsNFS.FieldByName('ALISER').AsFloat    := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AliquotaServicos>', '</AliquotaServicos>'),'.',','));
    cdsNFS.FieldByName('ISSRET').AsString   := RetornaTexto(strXML, '<ISSRetido>', '</ISSRetido>');
    strDoctoTomador := RetornaTexto(strXML, '<CPFCNPJTomador>', '</CPFCNPJTomador>');
    if Length(fTiraCaracEspeciaisPonto(RetornaTexto(strDoctoTomador, '<CNPJ>', '</CNPJ>')))=14 then
      cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strDoctoTomador, '<CNPJ>', '</CNPJ>');
    if Length(fTiraCaracEspeciaisPonto(RetornaTexto(strDoctoTomador, '<CPF>', '</CPF>')))=11 then
      cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strDoctoTomador, '<CPF>', '</CPF>');
    cdsNFS.FieldByName('TOMIE').AsString    := '';
    cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strXML, '<RazaoSocialTomador>', '</RazaoSocialTomador>');
    strEnderTomador := RetornaTexto(strXML, '<EnderecoTomador>', '</EnderecoTomador>');
    cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strEnderTomador, '<TipoLogradouro>', '</TipoLogradouro>')+' '+
                                               RetornaTexto(strEnderTomador, '<Logradouro>', '</Logradouro>');
    cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strEnderTomador, '<NumeroEndereco>', '</NumeroEndereco>');
    cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strEnderTomador, '<Bairro>', '</Bairro>');
    cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strEnderTomador, '<Cidade>', '</Cidade>');
    cdsNFS.FieldByName('TOMUF').AsString    := RetornaTexto(strEnderTomador, '<UF>', '</UF>');
    cdsNFS.FieldByName('TOMCEP').AsString   := IfThen(Length(Trim(RetornaTexto(strEnderTomador, '<CEP>', '</CEP>')))=7, '0'+Trim(RetornaTexto(strEnderTomador, '<CEP>', '</CEP>')), RetornaTexto(strEnderTomador, '<CEP>', '</CEP>'));
    cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strXML, '<EmailTomador>', '</EmailTomador>');
    cdsNFS.FieldByName('DISSER').AsString   := AnsiReplaceStr(RetornaTexto(strXML, '<Discriminacao>', '</Discriminacao>'), 'nn', ' ');
    cdsNFS.FieldByName('LOCMUN').AsString   := 'SÃO PAULO';
    cdsNFS.FieldByName('LOC_UF').AsString   := 'SP';
    cdsNFS.FieldByName('VALIRR').AsFloat    := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorIrrf>', '</ValorIrrf>'),'.',','));

    cdsNFS.FieldByName('VALINS').AsFloat    := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorINSS>', '</ValorINSS>'),'.',','));
    cdsNFS.FieldByName('VALPIS').AsFloat    := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorPIS>', '</ValorPIS>'),'.',','));
    cdsNFS.FieldByName('VALCOF').AsFloat    := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCOFINS>', '</ValorCOFINS>'),'.',','));
    cdsNFS.FieldByName('VALCSL').AsFloat    := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<ValorCSLL>', '</ValorCSLL>'),'.',','));

    strIBSCBS := RetornaTexto(strXML, '<IBSCBS>', '</IBSCBS>');
    cdsNFS.FieldByName('ICBSFINNFS').AsInteger := StrToIntDef(RetornaTexto(strIBSCBS, '<finNFSe>', '</finNFSe>'), 0);
    cdsNFS.FieldByName('ICBSINDFIN').AsInteger := StrToIntDef(RetornaTexto(strIBSCBS, '<indFinal>', '</indFinal>'), 0);
    cdsNFS.FieldByName('ICBSINDOP').AsString   := RetornaTexto(strIBSCBS, '<cIndOp>', '</cIndOp>');
    cdsNFS.FieldByName('ICBSINDDES').AsInteger := StrToIntDef(RetornaTexto(strIBSCBS, '<indDest>', '</indDest>'), 0);
    cdsNFS.FieldByName('ICBSCLATRI').AsString  := RetornaTexto(strIBSCBS, '<cClassTrib>', '</cClassTrib>');

    strRetornoComplementarIBSCBS := RetornaTexto(strXML, '<RetornoComplementarIBSCBS>', '</RetornoComplementarIBSCBS>');
    cdsNFS.FieldByName('ICBSADQCPF').AsString  := RetornaTexto(strRetornoComplementarIBSCBS, '<CPF>', '</CPF>');
    cdsNFS.FieldByName('ICBSADQCNP').AsString  := RetornaTexto(strRetornoComplementarIBSCBS, '<CNPJ>', '</CNPJ>');
    cdsNFS.FieldByName('ICBSADQNOM').AsString  := RetornaTexto(strRetornoComplementarIBSCBS, '<xNome>', '</xNome>');
    cdsNFS.FieldByName('ICBSADQMUN').AsString  := RetornaTexto(strRetornoComplementarIBSCBS, '<cMun>', '</cMun>');
    cdsNFS.FieldByName('ICBSADQCEP').AsString  := RetornaTexto(strRetornoComplementarIBSCBS, '<CEP>', '</CEP>');
    cdsNFS.FieldByName('ICBSADQLGR').AsString  := RetornaTexto(strRetornoComplementarIBSCBS, '<xLgr>', '</xLgr>');
    cdsNFS.FieldByName('ICBSADQNRO').AsString  := RetornaTexto(strRetornoComplementarIBSCBS, '<nro>', '</nro>');
    cdsNFS.FieldByName('ICBSADQCPL').AsString  := RetornaTexto(strRetornoComplementarIBSCBS, '<xCpl>', '</xCpl>');
    cdsNFS.FieldByName('ICBSADQBAI').AsString  := RetornaTexto(strRetornoComplementarIBSCBS, '<xBairro>', '</xBairro>');
    cdsNFS.FieldByName('ICBSADQEML').AsString  := RetornaTexto(strRetornoComplementarIBSCBS, '<email>', '</email>');
    cdsNFS.FieldByName('ICBSBASCAL').AsFloat   := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strRetornoComplementarIBSCBS, '<ValorBCIBSCBS>', '</ValorBCIBSCBS>'),'.',','));
    cdsNFS.FieldByName('ICBSALQEST').AsFloat   := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strRetornoComplementarIBSCBS, '<ValorAliqEstadualIBS>', '</ValorAliqEstadualIBS>'),'.',','));
    cdsNFS.FieldByName('ICBSALQEFE').AsFloat   := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strRetornoComplementarIBSCBS, '<ValorAliqEfetivaEstadualIBS>', '</ValorAliqEfetivaEstadualIBS>'),'.',','));
    cdsNFS.FieldByName('ICBSVALEST').AsFloat   := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strRetornoComplementarIBSCBS, '<ValorEstadualIBS>', '</ValorEstadualIBS>'),'.',','));
    cdsNFS.FieldByName('ICBSVALIBS').AsFloat   := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strRetornoComplementarIBSCBS, '<ValorIBS>', '</ValorIBS>'),'.',','));
    cdsNFS.FieldByName('ICBSALQCBS').AsFloat   := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strRetornoComplementarIBSCBS, '<ValorAliqCBS>', '</ValorAliqCBS>'),'.',','));
    cdsNFS.FieldByName('ICBSALEFCB').AsFloat   := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strRetornoComplementarIBSCBS, '<ValorAliqEfetivaCBS>', '</ValorAliqEfetivaCBS>'),'.',','));
    cdsNFS.FieldByName('ICBSVALCBS').AsFloat   := fStrToFloatDef(AnsiReplaceStr(RetornaTexto(strRetornoComplementarIBSCBS, '<ValorCBS>', '</ValorCBS>'),'.',','));

    cdsNFS.Post;
  except
    cdsNFS.Cancel;
    raise;
  end;

end;

end.
