unit untGeraXMLPAF;

interface

uses
  Classes, SysUtils, Variants, untTypesSistema,
  Controls, StdCtrls, StrUtils, Printers,
  Uni, DB, untFuncoesSimples,
  cxProgressBar, Forms,
  untCalcHash,
  untFuncEditorRel, untZClient, Math,
  untInterfaceRelatorio, untGeraFR3;

Type
  TGeraXMLPAF = class(TComponent)
    private
      FPathArq: String;
      FInterfaceGera: TInterfaceRelatorio;

      FData,
      FHora,
      FNroArquivo,
      FArquivoBase64,
      FDigestValue: String;
      FLinhas: String;

      FCertificadoPublico,
      FCertificadoPrivado: String;
      objCalcHash: TCalcHash;

      Procedure pSalvaArquivo;

      Function fHashMenuFiscal: String;
      Function fHashAtributosArquivo: String;
      Function fXMLAtributosArquivo: String;

      Function fHashSignedInfo: String;
      Function fXMLSignedInfo: String;

      Function fGetEmpresaCertificado: String;
      Function fGetNumeroArquivo: String;
      Function fGetCerficadoDigital(strArqPen, strBegin, strEnd: String): String;
      Function fTiraQuebrasLinha(strInfo: String): String;

      Function fGetHash(strXml: String; blnAssinar: Boolean): String;

      function fCarregaCertificadoDigital: Boolean;

      Procedure pAdd(strInfo: String);

      Procedure pMontaMenuFiscal;

    public

      constructor Create(AOwner: TComponent; APathArq: String; AInterfaceGera: TInterfaceRelatorio);  Reintroduce;
      destructor Destroy; override;

      Function fGeraXMLPaf: Boolean;

    published

  end;

implementation

constructor TGeraXMLPAF.Create(AOwner: TComponent; APathArq: String; AInterfaceGera: TInterfaceRelatorio);
begin
  inherited Create(AOwner);

  FPathArq := APathArq;

  FInterfaceGera := AInterfaceGera;

  objCalcHash := TCalcHash.Create;
End;

destructor TGeraXMLPAF.Destroy;
begin
  inherited;

  FreeAndNil(objCalcHash);
end;

Function TGeraXMLPAF.fGetHash(strXml: String; blnAssinar: Boolean): String;
Begin
  Result := String(objCalcHash.fCalcHash(AnsiString(strXML), dgstSHA1, outBase64, blnAssinar));
End;

Function TGeraXMLPAF.fGetCerficadoDigital(strArqPen, strBegin, strEnd: String): String;
Begin
  Result := strArqPen;

  Delete(Result, 1, Pos(strBegin, Result) + Length(strBegin) - 1);

  Result := Trim(Result);

  Result := Trim(Copy(Result, 1, Pos(strEnd, Result) - 1));
End;

function TGeraXMLPAF.fCarregaCertificadoDigital: Boolean;
 Var
   qryCadEmp: TUniQuery;
   strErroCertificado: String;
Begin
  strErroCertificado := '';

  Try
    qryCadEmp := FInterfaceGera.fCriaQueryRelarorio;
    qryCadEmp.SQL.Text := 'SELECT CER_ARQPEM, CER_ARQPFX, CER_DTAVAL, CER_SENHA_ FROM CADCER WHERE CER_CODEMP = :CODEMP';
    qryCadEmp.ParamByName('CODEMP').AsString := fGetEmpresaCertificado;
    qryCadEmp.Open;

    FCertificadoPublico := fGetCerficadoDigital(qryCadEmp.FieldByName('CER_ARQPEM').AsString, '-----BEGIN CERTIFICATE-----', '-----END CERTIFICATE-----');
    FCertificadoPrivado := fGetCerficadoDigital(qryCadEmp.FieldByName('CER_ARQPEM').AsString, '-----BEGIN ENCRYPTED PRIVATE KEY-----', '-----END ENCRYPTED PRIVATE KEY-----');

    If qryCadEmp.FieldByName('CER_ARQPEM').IsNull Then
    Begin
      Result := False;
      pMensagemOk('Certificado A1 não foi localizado no Cad.Empresas. Favor fazer upload no botão do certificado dentro do Cad.Empresas.');
      FInterfaceGera.pGravaLogPaf('N', 'Certificado A1 não foi localizado no Cad.Empresas. Favor fazer upload no botão do certificado dentro do Cad.Empresas.');
      Exit;
    End;

    If FCertificadoPublico.IsEmpty Or FCertificadoPrivado.IsEmpty Then
    Begin
      Result := False;
      pMensagemOk('Certificado A1 não foi localizado no Cad.Empresas. Favor fazer upload no botão do certificado dentro do Cad.Empresas.');
      FInterfaceGera.pGravaLogPaf('N', 'Certificado A1 não foi localizado no Cad.Empresas. Favor fazer upload no botão do certificado dentro do Cad.Empresas.');
      Exit;
    End;

    If qryCadEmp.FieldByName('CER_DTAVAL').AsDateTime < VS_Date Then
    Begin
      Result := False;
      pMensagemOk('Data de validade do certificado digital (' + qryCadEmp.FieldByName('CER_DTAVAL').AsString + ') expirada!');
      FInterfaceGera.pGravaLogPaf('N', 'Data de validade do certificado digital (' + qryCadEmp.FieldByName('CER_DTAVAL').AsString + ') expirada!');
      Exit;
    End;

    Result := objCalcHash.fCarregarCertificadoDeArquivoPFX(qryCadEmp, strErroCertificado);

    if not fEmptyStr(strErroCertificado) then
      FInterfaceGera.pGravaLogPaf('N', strErroCertificado);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagemOk('Erro ao carregar certificado digital: ' + E.Message);
      FInterfaceGera.pGravaLogPaf('N', 'Erro ao carregar certificado digital: ' + E.Message);
    End;
  End;

  FreeAndNil(qryCadEmp);
End;

Function TGeraXMLPAF.fTiraQuebrasLinha(strInfo: String): String;
Begin
  Result := strInfo;
  Result := AnsiReplaceStr(Result, #13, '');
  Result := AnsiReplaceStr(Result, #10, '');
End;

Function TGeraXMLPAF.fGetEmpresaCertificado: String;
 Var
   qryCadEmp: TUniQuery;
Begin
  qryCadEmp := FInterfaceGera.fCriaQueryRelarorio;
  qryCadEmp.SQL.Text := 'SELECT @EMPRESA AS CODEMP ';
  qryCadEmp.Open;

  If qryCadEmp.FieldByName('CODEMP').IsNull Then
    Result := VS_strCodEmp
  Else
    Result := qryCadEmp.FieldByName('CODEMP').AsString;

  FreeAndNil(qryCadEmp);
End;

Function TGeraXMLPAF.fGetNumeroArquivo: String;
 Var
   qryDados: TUniQuery;
Begin
  qryDados := FInterfaceGera.fCriaQueryRelarorio;
  qryDados.SQL.Text := 'SELECT @NUMERO_ARQUIVO AS NROARQ ';
  qryDados.Open;

  Result := qryDados.FieldByName('NROARQ').AsString;

  FreeAndNil(qryDados);
End;

Procedure TGeraXMLPAF.pAdd(strInfo: String);
Begin
  FLinhas := FLinhas + strInfo;
End;

Function TGeraXMLPAF.fHashSignedInfo: String;
Begin
  Result :=
    '<SignedInfo xmlns="http://www.w3.org/2000/09/xmldsig#"><CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"></CanonicalizationMethod><SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"></SignatureMethod>' +
    '<Reference URI=""><Transforms><Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"></Transform><Transform ' +
    'Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"></Transform></Transforms><DigestMethod Algorithm="http://www.w3.org/2000/09/' +
    'xmldsig#sha1"></DigestMethod><DigestValue>' + FDigestValue + '</DigestValue></Reference></SignedInfo>';
End;

Function TGeraXMLPAF.fXMLSignedInfo: String;
Begin
  Result :=
   '<SignedInfo><CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>' +
   '<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/><Reference URI=""><Transforms>' +
   '<Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/><Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>' +
   '</Transforms><DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/><DigestValue>' + FDigestValue + '</DigestValue></Reference>' +
   '</SignedInfo>';
End;

Function TGeraXMLPAF.fHashAtributosArquivo: String;
Begin
  Result := 'arqBD="Banco de dados interno" arqSist="PAF-NFC-e interno" data="' + FData + '" hora="' + FHora + '" nroArquivo="' + FNroArquivo + '">';
End;

Function TGeraXMLPAF.fHashMenuFiscal: String;
Begin
  Result := '';
  Result := Result + '<menuFiscal xmlns="http://www.sef.sc.gov.br/nfce">';
  Result := Result + '<arquivo ';
  Result := Result + fHashAtributosArquivo;
  Result := Result + FArquivoBase64;
  Result := Result + '</arquivo>';
  Result := Result + '</menuFiscal>';
End;

Function TGeraXMLPAF.fXMLAtributosArquivo: String;
Begin
  Result := 'nroArquivo="' + FNroArquivo + '" data="' + FData + '" hora="' + FHora + '" arqBD="Banco de dados interno" arqSist="PAF-NFC-e interno">';
End;

Procedure TGeraXMLPAF.pMontaMenuFiscal;
Begin
  pAdd('<menuFiscal xmlns="http://www.sef.sc.gov.br/nfce">');

    pAdd('<arquivo ');
    pAdd(fXMLAtributosArquivo);
    pAdd(FArquivoBase64);
    pAdd('</arquivo>');

    pAdd('<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">');

      pAdd(fXMLSignedInfo);

      pAdd('<SignatureValue>');
      pAdd(fGetHash(fHashSignedInfo, True));
      pAdd('</SignatureValue>');

      pAdd('<KeyInfo>');

        pAdd('<X509Data>');

          pAdd('<X509Certificate>');
          pAdd(fTiraQuebrasLinha(FCertificadoPublico));
          pAdd('</X509Certificate>');

        pAdd('</X509Data>');

      pAdd('</KeyInfo>');

    pAdd('</Signature>');

  pAdd('</menuFiscal>');
End;

Procedure TGeraXMLPAF.pSalvaArquivo;
  Var
    txtArquivo: TextFile;
Begin
  AssignFile(txtArquivo, ChangeFileExt(FPathArq, '.XML'));
  Rewrite(txtArquivo);

  Write(txtArquivo, FLinhas);

  Flush(txtArquivo);
  Close(txtArquivo);
End;

Function TGeraXMLPAF.fGeraXMLPaf: Boolean;
Begin
  Try
    FLinhas := '';

    Result := fCarregaCertificadoDigital;

    If Not Result Then
      Exit;

    FData := FormatDateTime('DDMMYYYY', VS_Date);
    FHora := FormatDateTime('HHNNSS', fTime());
    FNroArquivo := fGetNumeroArquivo;
    FArquivoBase64 := RetornaArquivoBase64(FPathArq);
    FDigestValue := fGetHash(fHashMenuFiscal, False);

    pMontaMenuFiscal;

    FLinhas := '<?xml version="1.0" encoding="UTF-8"?>' + FLinhas;

    pSalvaArquivo;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagemOk('Erro ao gerar o xml: ' + E.Message);
      FInterfaceGera.pGravaLogPaf('N', 'Erro ao gerar o xml: ' + E.Message);
    End;
  End;

End;

end.
