unit untXMLNotaFiscal;

interface

uses
  Uni;

  function fGetXMLFIT(strCodEmp, strAcesso: String):String;
  function fMontaArquivosXML(strNumDoc,
                             strEspDoc,
                             strCodEmp,
                             strCodCli,
                             strSerie,
                             strTipFC,
                             strNumSer: String;
                             conexao: TUniConnection = nil;
                             blnRetornarBase64: Boolean = False): String;

implementation

uses untLibNfe, untFuncoesSimples, System.SysUtils;

function fGetXMLFIT(strCodEmp, strAcesso: String):String;
var
  objLibNFe : TLibNFe;
begin
  objLibNFe := TLibNfe.Create(strCodEmp);
  try
    Result := objLibNFe.fXMLNFE(strCodEmp, strAcesso);
  finally
    FreeAndNil(objLibNFe);
  end;
end;

function fMontaArquivosXML(strNumDoc,
                           strEspDoc,
                           strCodEmp,
                           strCodCli,
                           strSerie,
                           strTipFC,
                           strNumSer: String;
                           conexao: TUniConnection = nil;
                           blnRetornarBase64: Boolean = False): String;
var
  strPathXML    : String;
  strArquivoXML : String;
  strAcesso     : String;
  strPath      : String;
begin
  Result := EmptyStr;

  strAcesso := fRetornaChaveAcesso(strNumDoc,
                                   strEspDoc,
                                   strCodEmp,
                                   strCodCli,
                                   strSerie,
                                   strTipFC,
                                   strNumSer,
                                   conexao);

  If fEmptyStr(strAcesso) Then
    Exit;

  strPath := IncludeTrailingPathDelimiter( ExtractFilePath(ParamStr(0)) )+ 'Docs_Env_XML';

  if (SameText(strEspDoc, 'IF')) then
    strArquivoXML := fGetXMLFIT(strCodEmp, strAcesso)
  else if (String('NF_NS_').Contains(strEspDoc)) then
  begin
    strArquivoXML := fRetornaArquivoXMLNFe(strAcesso, conexao);

    if (fEmptyStr(strArquivoXML)) then
      strArquivoXML := fGetXMLFIT(strCodEmp, strAcesso);
  end;

  if (fEmptyStr(strArquivoXML)) then
    Exit;

  strPathXML :=  IncludeTrailingPathDelimiter(strPath) + fUpper(strEspDoc) + '_' + strNumDoc + '_'+ strCodEmp + '.xml';

  pGravarArquivoXML(strPathXML, strArquivoXML);

  Result := strPathXML;
  if blnRetornarBase64 then
    Result := RetornaArquivoBase64(Result);
end;

end.
