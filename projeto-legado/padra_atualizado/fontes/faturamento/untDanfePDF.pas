unit untDanfePDF;

interface

  function fGerarPDFDanfe(strAcesso,
                          strCodEmp,
                          strEspDoc: String;
                          strNumDoc: String = '';
                          strCodCli: String = '';
                          strSerie_: String = '';
                          blnGerandoParaDisparoDeGatilho: Boolean = False): String; overload;

  function fGerarPDFDanfe(strAcesso, strCodEmp: String; blnGerandoParaDisparoDeGatilho: Boolean): String; overload;

  function fRetDanfeBase64(AChaveAcesso: String): String;

implementation

uses untLibNfe, untQckFatImpNFCe, untFuncoesSimples, System.SysUtils, Uni;

{**********************************************************}
{*** strNumDoc, strCodCli, strSerie_                    ***}
{*** Devem ser informados apenas se quiser gerar pdf de ***}
{*** uma NFCE quando não utiliza o NfeImpressao.exe     ***}
{*******************************************************BL*}
function fGerarPDFDanfe(strAcesso,
                        strCodEmp,
                        strEspDoc: String;
                        strNumDoc: String = '';
                        strCodCli: String = '';
                        strSerie_: String = '';
                        blnGerandoParaDisparoDeGatilho: Boolean = False): String; overload;

var
  libNfe: TLibNfe;
  frmQckFatImpNFCe: TfrmQckFatImpNFCe;

  strDirCompleto: String;

  blnEhEmissaoDeNotaDeServicoPeloNfeImpressao,
  blnEhEmissaoDeNotaDeProdutoPeloNfeImpressao,
  blnEhEmissaoDeNFCEPeloNfeImpressao: Boolean;
  LDiretorioDanfe: String;
begin
  Result := '';

  if (fCfgSis('CITINF', varBoolean)) and
     (not FileExists(TImpressaoDiretaCitel.fRetNomeNfeImprimirExeCitel)) then
    Exit;

  blnEhEmissaoDeNotaDeServicoPeloNfeImpressao := IIF(fCfgSis('NFSENO', varBoolean),
                                                     ((fCfgSis('IMPNFS', varBoolean)) and (strEspDoc = 'NS')),
                                                     ((fCfgSis('IMPNFS', varBoolean)) and (fPrefeituraComLayoutNfse(fCfgSis('CIDNFS'))) and (strEspDoc = 'NS')));

  blnEhEmissaoDeNotaDeProdutoPeloNfeImpressao := (fCfgSis('CITINF', varBoolean) and (strEspDoc = 'NF'));

  blnEhEmissaoDeNFCEPeloNfeImpressao := (fCfgSis('CITINF', varBoolean) and (strEspDoc = 'IF'));

  LDiretorioDanfe := fRetornaDiretorioDanfe(blnGerandoParaDisparoDeGatilho);

  if not DirectoryExists(LDiretorioDanfe) then
    CreateDir(LDiretorioDanfe);

  strDirCompleto := LDiretorioDanfe + strAcesso + '.pdf';

  if blnEhEmissaoDeNotaDeServicoPeloNfeImpressao then
    TImpressaoDiretaCitel.pImprimirPDF(strCodEmp,
                                       'ImpressaoPDF',
                                       strAcesso,
                                       'NFS',
                                       False,
                                       strDirCompleto,
                                       False,
                                       blnGerandoParaDisparoDeGatilho)

  else if blnEhEmissaoDeNotaDeProdutoPeloNfeImpressao then
    TImpressaoDiretaCitel.pImprimirPDF(strCodEmp,
                                       'ImpressaoPDF',
                                       strAcesso,
                                       'NFE',
                                       False,
                                       strDirCompleto,
                                       False,
                                       blnGerandoParaDisparoDeGatilho)

  else if blnEhEmissaoDeNFCEPeloNfeImpressao then
    TImpressaoDiretaCitel.pImprimirPDF(strCodEmp,
                                       'ImpressaoPDF',
                                       strAcesso,
                                       'NFCE',
                                       False,
                                       strDirCompleto,
                                       False,
                                       blnGerandoParaDisparoDeGatilho)
  else
  begin
    if Pos(strEspDoc, 'NF_NS_') > 0 then
    begin
      libNfe := TLibNfe.Create(strCodEmp);
      try
        strDirCompleto := libNfe.fCarregarNfePdf(strAcesso, strDirCompleto, False);
      finally
        FreeAndNil(libNfe);
      end;
    end
    else if strEspDoc = 'IF' then
    begin
      frmQckFatImpNFCe := TfrmQckFatImpNFCe.Create(nil);
      try
        frmQckFatImpNFCe.pImprimirDanfeNFCe(strNumDoc,
                                            strEspDoc,
                                            strCodEmp,
                                            strCodCli,
                                            strSerie_,
                                            'C',
                                            '',
                                            True,
                                            strAcesso,
                                            False,
                                            strDirCompleto);

        if (FileExists(frmQckFatImpNFCe.frxExpPDF.FileName)) then
          strDirCompleto := frmQckFatImpNFCe.frxExpPDF.FileName;
      finally
        pFreeAndNil(frmQckFatImpNFCe);
      end;
    end;
  end;

  Result := strDirCompleto;
end;

function fGerarPDFDanfe(strAcesso, strCodEmp: String; blnGerandoParaDisparoDeGatilho: Boolean): String; overload;
var
  libNfe: TLibNfe;
  strDirCompleto: String;
  LDiretorioDanfe: String;
begin

  LDiretorioDanfe := fRetornaDiretorioDanfe(blnGerandoParaDisparoDeGatilho);

  if not DirectoryExists(LDiretorioDanfe) then
    CreateDir(LDiretorioDanfe);

  strDirCompleto := LDiretorioDanfe + strAcesso + '.pdf';

  libNfe := TLibNfe.Create(strCodEmp);
  try
    Result := libNfe.fCarregarNfePdf(strAcesso, strDirCompleto, False);
  finally
    FreeAndNil(libNfe);
  end;
end;

function fRetDanfeBase64(AChaveAcesso: String): String;
var
  qryPDF: TUniQuery;
begin
  qryPDF := fCriaQuery(nil);
  try
    qryPDF.Close;
    qryPDF.SQL.Text :=
      ' SELECT '+
      '   NFE_ARQPDF '+
      ' FROM  '+
      '   PDFNFE '+
      ' WHERE '+
      '   NFE_ACESSO = :ACESSO';

    qryPDF.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryPDF.Open;

    Result := qryPDF.FieldByName('NFE_ARQPDF').AsString;
  finally
    FreeAndNil(qryPDF);
  end;
end;


end.
