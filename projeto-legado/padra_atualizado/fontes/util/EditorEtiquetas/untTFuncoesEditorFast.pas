unit untTFuncoesEditorFast;

interface

uses untFuncoesEditorFast, untIFuncoesEditorFast, untInterfacedObjectNoCount,
  untTypesSistema, frxClass, TypesRel;

Type
  TFuncoesEditorFast = Class (TInterfacedObjectNoCount, IFuncoesEditorFast)
    procedure pInicializaFonteMatrcial(Var recCfgFon: TRecFonteMatricial);

    function fCmColunaToPixel(fltValCm: Double; blnAltura: Boolean; strTipImp: String; blnRound: Boolean = True): Double;
    function fPixelToCmColuna(fltValPix: Double; blnAltura: Boolean; strTipImp: String; blnRound: Boolean = True): Double;

    function fLarguraColuna(colFonPag, colFonMat: TcolMatricial; strTipImp: String): Double;

    function fMargemFastToColunasMatricial(fltValCm: Double; blnAltura: Boolean): Double;
    function fMargemmFastMatricialToPixels(fltValCm: Double; blnAltura: Boolean): Double;

    function fTemParametro(frxReport: TfrxReport; strNomPar: WideString): Boolean;

    function fEspecieToTipoDocumeto(strNumDoc, strEspDoc, strCodEmp, strTip_FC: String; blnDocSep, blnRequisicao, blnImpSepRomaneio, blnVidro: Boolean): TTipoDocumento;
    function fEspecieEtqToTipoDocumentos(strNumDoc, strEspDoc, strCodEmp, strTip_FC: String; blnDocSep, blnRequisicao, blnVidro, blnImpSepRomaneio: Boolean; Var tpeTipEtq: TTipoEtiqueta): Boolean;

    function fRetNomCampoLayout(strCodigo: String; intCodEti: Integer; intPosCam: Integer = -1): String;

    function fTextoToColMat(strTexto: String): TcolMatricial;
    function fColMatToTexto(colFonte: TcolMatricial): String;
    function fLayoutAtivo(strNumDoc, strEspDoc, strCodEmp, strTip_FC: String; blnDocSep, blnPDF: Boolean):Boolean;

    function fCodigoToTipoEtiqueta(intCodLay: Integer): TTipoEtiqueta;
    function fCodLayToTipoEtiqueta(intCodLay: Integer): TTipoEtiqueta;
    function fSQLFiltroCamposDocumento(intCodEti: Integer): String;
  End;

implementation

{ TFuncoesEditorFast }

function TFuncoesEditorFast.fCmColunaToPixel(fltValCm: Double;
  blnAltura: Boolean; strTipImp: String; blnRound: Boolean): Double;
begin
  Result := untFuncoesEditorFast.fCmColunaToPixel(fltValCm, blnAltura, strTipImp, blnRound);
end;

function TFuncoesEditorFast.fCodigoToTipoEtiqueta(intCodLay: Integer): TTipoEtiqueta;
begin
  Result := untFuncoesEditorFast.fCodigoToTipoEtiqueta(intCodLay);
end;

function TFuncoesEditorFast.fCodLayToTipoEtiqueta(intCodLay: Integer): TTipoEtiqueta;
begin
  Result := untFuncoesEditorFast.fCodLayToTipoEtiqueta(intCodLay);
end;

function TFuncoesEditorFast.fColMatToTexto(colFonte: TcolMatricial): String;
begin
  Result := untFuncoesEditorFast.fColMatToTexto(colFonte);
end;

function TFuncoesEditorFast.fEspecieEtqToTipoDocumentos(strNumDoc, strEspDoc,
  strCodEmp, strTip_FC: String; blnDocSep, blnRequisicao, blnVidro, blnImpSepRomaneio: Boolean;
  var tpeTipEtq: TTipoEtiqueta): Boolean;
begin
  If tpeTipEtq = tpeReqMaterialConsumoVidro Then
    Result := untFuncoesEditorFast.fEspecieEtqToTipoDocumentos(strNumDoc, strEspDoc,
      strCodEmp, strTip_FC, blnDocSep, blnRequisicao, True ,blnImpSepRomaneio, tpeTipEtq)
  Else
    Result := untFuncoesEditorFast.fEspecieEtqToTipoDocumentos(strNumDoc, strEspDoc,
      strCodEmp, strTip_FC, blnDocSep, blnRequisicao, True,blnImpSepRomaneio, tpeTipEtq);

end;

function TFuncoesEditorFast.fEspecieToTipoDocumeto(strNumDoc, strEspDoc,
  strCodEmp, strTip_FC: String; blnDocSep, blnRequisicao, blnImpSepRomaneio, blnVidro: Boolean): TTipoDocumento;
begin
  Result := untFuncoesEditorFast.fEspecieToTipoDocumeto(strNumDoc, strEspDoc,
    strCodEmp, strTip_FC, blnDocSep, blnRequisicao, blnImpSepRomaneio, blnVidro);

end;

function TFuncoesEditorFast.fLarguraColuna(colFonPag, colFonMat: TcolMatricial;
  strTipImp: String): Double;
begin
  Result := untFuncoesEditorFast.fLarguraColuna(colFonPag, colFonMat,
    strTipImp);
end;

function TFuncoesEditorFast.fLayoutAtivo(strNumDoc, strEspDoc, strCodEmp,
  strTip_FC: String; blnDocSep, blnPDF: Boolean): Boolean;
begin
  Result := untFuncoesEditorFast.fLayoutAtivo(strNumDoc, strEspDoc, strCodEmp,
  strTip_FC, blnDocSep, blnPDF);
end;

function TFuncoesEditorFast.fMargemFastToColunasMatricial(fltValCm: Double;
  blnAltura: Boolean): Double;
begin
  Result := untFuncoesEditorFast.fMargemFastToColunasMatricial(fltValCm,
    blnAltura);
end;

function TFuncoesEditorFast.fMargemmFastMatricialToPixels(fltValCm: Double;
  blnAltura: Boolean): Double;
begin
  Result := untFuncoesEditorFast.fMargemmFastMatricialToPixels(fltValCm,
    blnAltura);
end;

function TFuncoesEditorFast.fPixelToCmColuna(fltValPix: Double;
  blnAltura: Boolean; strTipImp: String; blnRound: Boolean): Double;
begin
  Result := untFuncoesEditorFast.fPixelToCmColuna(fltValPix, blnAltura,
    strTipImp, blnRound);
end;

function TFuncoesEditorFast.fRetNomCampoLayout(strCodigo: String; intCodEti,
  intPosCam: Integer): String;
begin
  Result := untFuncoesEditorFast.fRetNomCampoLayout(strCodigo, intCodEti, intPosCam);
end;

function TFuncoesEditorFast.fSQLFiltroCamposDocumento(intCodEti: Integer): String;
begin
  Result := untFuncoesEditorFast.fSQLFiltroCamposDocumento(intCodEti);
end;

function TFuncoesEditorFast.fTemParametro(frxReport: TfrxReport;
  strNomPar: WideString): Boolean;
begin
  Result := untFuncoesEditorFast.fTemParametro(frxReport, strNomPar);
end;

function TFuncoesEditorFast.fTextoToColMat(strTexto: String): TcolMatricial;
begin
  Result := untFuncoesEditorFast.fTextoToColMat(strTexto);
end;

procedure TFuncoesEditorFast.pInicializaFonteMatrcial(
  var recCfgFon: TRecFonteMatricial);
begin
  untFuncoesEditorFast.pInicializaFonteMatrcial(recCfgFon);
end;

end.
