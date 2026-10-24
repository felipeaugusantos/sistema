unit untIFuncoesEditorFast;

interface

uses frxClass, untTypesSistema;

type
  IFuncoesEditorFast = Interface
  ['{AB5F71C8-E9B7-4B44-A9A0-A4AE43B52623}']
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

Implementation

end.
