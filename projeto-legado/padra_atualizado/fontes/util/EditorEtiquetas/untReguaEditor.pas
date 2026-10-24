unit untReguaEditor;

interface

uses StrUtils, SysUtils, Classes, Forms, Variants, Controls, Windows, Graphics,
  ExtCtrls,  frxClass, Printers, frxDesgnCtrls, Math, frxBarCod, TypesRel,
  untTypesSistema, untConstantes, untFuncoesEditorFast;

Type
  TRecPaperSize = Record
    strNomPap: String[100];
    fltAltura,
    fltLargur: Double;
    intValFrx: Integer; //TfrxReportPage.PaperSize
    fltAltFrx,
    fltLarFrx: Double;  // DIMENSOES OBTIDAS PELO FAST
    strComand: String[255];
    strComan2: String[255];
    strComan3: String[255];
  End;

  TarrPaperSize = Array Of TRecPaperSize;

  TDadosMargem = Class(TInterfacedObject, IInterface)
  Public
    fltMarSup,
    fltMarInf,
    fltMarEsq,
    fltMarDir: Double;
  End;

  TPaperSize = Class(TComponent)
  Private
    FTipImp: String;
    FPapCur: Integer;
    FLisOri: TStringList;
    FOrient: TPrinterOrientation;
    FOrdOri: Integer;

    Procedure setOrdOri(Const Value: Integer);
    Procedure setOrient(Const Value: TPrinterOrientation);
    Procedure setCusWid(Const Value: Double);
    Procedure setCusHei(Const Value: Double);
    Procedure setPapCur(Const Value: Integer);

    Function getPapCur: TRecPaperSize;
    Function getPapPix: TRecPaperSize;
    Function getLisPap: String;
    Function getLisPapVias: String;
    Function getNomOri: String;
    Function getCusWid: Double;
    Function getCusHei: Double;

    Procedure pMontaListaOrientacao;

    Procedure pSetaPaper(intIndPap: Integer;
                         strNamPap: String;
                         fltAltPap,
                         fltLarPap: Double;
                         intIndFrx: Integer;
                         strContro: String = '';
                         strContr2: String = '';
                         strContr3: String = '';
                         fltAltFas: Double = 0;
                         fltLarFas: Double = 0);

  Public
    FArrPpz: TarrPaperSize;

    Constructor Create(Owner: TComponent; strTipImpP: String); Reintroduce;
    Destructor Destroy; Override;

    Function fGetIndicePapel(strNomPap: String): Integer;

    published

      property intPapCur: Integer Read FPapCur Write setPapCur;
      property stlOrient: TStringList Read FLisOri Write FLisOri;
      property porOrient: TPrinterOrientation Read FOrient Write setOrient;
      property intOrdOri: Integer Read FOrdOri Write setOrdOri;
      property recPapCur: TRecPaperSize Read getPapCur;
      property recPapPix: TRecPaperSize Read getPapPix;
      property strLisPap: String Read getLisPap;
      property strLisPapVias: String Read getLisPapVias;
      property strNomOri: String Read getNomOri;
      property fltCusWid: Double Read getCusWid Write setCusWid;
      property fltCusHei: Double Read getCusHei Write setCusHei;
  End;

  TDadosEtiqueta = Record
    fltLarEti,
    fltAltEti,
    fltGapHor,
    fltGapVer: Double;
    intNumCol: Integer;
  End;

  TFonteMatricial = Record
    colFonte  : TColMatricial;
  End;

  TReguaEditor = Class(TComponent)
  Private

     FTipImp: String;
     FCodEti: TTipoEtiqueta;
     FTipLay: TTipoLayout;

     FIniFoo: Integer; //PONTO INICIAL DO PAGE FOOTER
     FIniFoD: Integer; //PONTO INICIAL DO FOOTER DE DADOS

     FIniHor,
     FIniVer: Integer; //PONTO INICIAL DA PAGINA
     FFooNewPage: Boolean; // Nova Pagina ao Imprimir Rodape da Pagina

     FXMaste,
     FYMaste: Integer; //PONTO INICIAL DO MASTER DATA

     FGpVrPx: Double;

     FArgox : Boolean;
     FdadEti: TDadosEtiqueta;
     FPapSiz: TPaperSize;
     FEImage: TImage;
     FMarPix: TDadosMargem;
     FMargem: TDadosMargem;
     FScrBox: TScrollBox;

     FRegLat,
     FRegSup,
     FLatAux: TPanel;
     FRulSup,
     FRulLat: TfrxRuler;

     FMolLar: Integer;

     FMolSup,
     FMolInf,
     FMolEsq,
     FMolDir: Boolean;

     FShaSup,
     FShaInf,
     FShaEsq,
     FShaDir: TShape;

     FHeader,
     FHeaderData,
     FFooter,
     FImpUlt,
     FFooBra,
     FFooterData: Boolean;

     FHeaderDataMol: Integer;
     FHeaderDataCor: TColor;

     FFooterDataMol: Integer;
     FFooterDataCor: TColor;

     FZebra : Boolean;
     FZooFix : Double;
     FclrZeb: TColor;
     FexpZeb: String;
     FMolDad: Integer;

     FHeaAlt,
     FHeaDataAlt,
     FFooAlt,
     FFooDataAlt: Double;

     FNomPapVias: String;

     FAvnPag: String;

     FinfHei: String;

     FEscMod: Integer;

     FConPro: Boolean;

     FSemFim: Boolean;

     FImpPDF,
     FViaPag: Boolean;

     FEspaca: Integer;
     FLinCommand: Integer;

     // FONTES POR BLOCO MATRICIAL
     FCabPagFon,
     FCabDadFon,
     FRodDadFon,
     FRodPagFon: TFonteMatricial;

     FCmpMvl: Pointer;

     FCabPri: String;

     Function getOrinta: Integer;
     Function getPagina: Integer;
     Function getWidPag: Double;
     Function getHeiPag: Double;
     Function getMrgSup: Double;
     Function getMrgInf: Double;
     Function getMrgEsq: Double;
     Function getMrgDir: Double;
     Function getLarEtq: Double;
     Function getAltEtq: Double;
     Function getGpHrEt: Double;
     Function getGpVrEt: Double;

     Function getLarEPx: Double;
     Function getAltEPx: Double;
     Function getGpHrPx: Double;

     Function getNrCoEt: Integer;
     Function getPagFrx: Integer;
     Function getMarPix: TDadosMargem;

     Function getZebra : Boolean;
     Function getZooFix: Double;
     Function getMolDad: Integer;

     Function getclrZeb: TColor;
     Function getexpZeb: String;

     Function getIniHor: Double;
     Function getIniVer: Double;

     Function getIniHoV: Integer;
     Function getIniVeV: Integer;

     Procedure setLarEtq(Const Value: Double);
     Procedure setAltEtq(Const Value: Double);
     Procedure setGpHrEt(Const Value: Double);
     Procedure setGpVrEt(Const Value: Double);
     Procedure setNrCoEt(Const Value: Integer);
     Procedure setOrinta(Const Value: Integer);
     Procedure setPagina(Const Value: Integer);
     Procedure setWidPag(Const Value: Double);
     Procedure setHeiPag(Const Value: Double);
     Procedure setMrgSup(Const Value: Double);
     Procedure setMrgInf(Const Value: Double);
     Procedure setMrgEsq(Const Value: Double);
     Procedure setMrgDir(Const Value: Double);
     Procedure setPagFrx(Const Value: Integer);
     Procedure setLarEPx(Const Value: Double);
     Procedure setAltEPx(Const Value: Double);
     Procedure setGpHrPx(Const Value: Double);
     Procedure setGpVrPx(Const Value: Double);

     Procedure setZebra(Const Value: Boolean);
     Procedure setZooFix(Const Value: Double);
     Procedure setClrZeb(Const Value: TColor);
     Procedure setExpZeb(Const Value: String);
     Procedure setMolDad(Const Value: Integer);

     Procedure setMolSup(Const Value: Boolean);
     Procedure setMolInf(Const Value: Boolean);
     Procedure setMolDir(Const Value: Boolean);
     Procedure setMolEsq(Const Value: Boolean);
     Procedure setMolLar(Const Value: Integer);

     Procedure setHeaAlt(Const Value: Double);
     Procedure setHeaDataAlt(Const Value: Double);
     Procedure setFooAlt(Const Value: Double);
     Procedure setFooDataAlt(Const Value: Double);

     Procedure setHeader(Const Value: Boolean);
     Procedure setHeaderData(Const Value: Boolean);
     Procedure setFooter(Const Value: Boolean);
     Procedure setImpUlt(Const Value: Boolean);
     Procedure setFooBra(Const Value: Boolean);
     Procedure setFooterData(Const Value: Boolean);

     Procedure setHeaderDataMol(Const Value: Integer);
     Procedure setHeaderDataCor(Const Value: TColor);

     Procedure setFooterDataMol(Const Value: Integer);
     Procedure setFooterDataCor(Const Value: TColor);

     Procedure pInicializaReguas(PRegLat, PRegSup, PLatAux: TPanel;
                                 PRulSup, PRulLat: TfrxRuler);

     Procedure pInicializaMedidas;

     Procedure pSetaMolduraSuperior;
     Procedure pSetaMolduraInferior;
     Procedure pSetaMolduraDireita;
     Procedure pSetaMolduraEsquerda;

     Procedure pLinhasDeEscalaHeader;
     Procedure pLinhasDeEscalaFooter;

     Procedure pAjustaLarguraEtqDocumentos;

     procedure pPedeFonteMatricial(Var fonFonte: TFonteMatricial);

  Public

    blnNovaImagem: Boolean;

    constructor Create(Owner: TComponent;
                       PRegLat, PRegSup, PLatAux: TPanel;
                       PRulSup, PRulLat: TfrxRuler;
                       PArgox: Boolean;
                       PScrBox: TScrollBox;
                       PTipEti: TTipoEtiqueta;
                       PTipLay: TTipoLayout;
                       strTipImpP: String); Reintroduce;

    Destructor  Destroy; Override;

    Procedure pSetaRegua;
    Procedure pPosicionaReguas;
    Procedure pNovaRegua(blnRefresh: Boolean = True);

    procedure pPedeFonteMatricialCabPag;
    procedure pPedeFonteMatricialCabDados;

    Function fColFontePagina: TcolMatricial;

    Function fGetLocalizacao(fltTopOri: Double): TTipoLocalizacao;

    Function fCampoTemFonteDaPagina(fltfrxTop: Double): Boolean;

    procedure pSetaComponentMovel(objCmpMvl: Pointer);

    published

      property imgPagina: TImage     Read FEImage   Write FEImage;

      property intEscMod: Integer    Read FEscMod   Write FEscMod;

      property ppzPapSiz: TPaperSize Read FPapSiz;
      property intOrinta: Integer    Read getOrinta Write SetOrinta;
      property intPagina: Integer    Read getPagina Write SetPagina;
      property intEspaca: Integer    Read FEspaca   Write FEspaca;

      property intLinCommand: Integer Read FLinCommand Write FLinCommand;

      property fltWidPag: Double     Read getWidPag Write SetWidPag;
      property fltHeiPag: Double     Read getHeiPag Write SetHeiPag;
      property intPagFrx: Integer    Read getPagFrx Write SetPagFrx;

      property strInfHei: String     Read FinfHei   Write FinfHei;
      property strAvnPag: String     Read FAvnPag   Write FAvnPag;

      property blnZebra:  Boolean    Read getZebra    Write SetZebra;  // SE É LINHA ZEBRADA
      property dblZooFix: Double     Read getZooFix   Write SetZooFix; // ZOOM FIXO
      property clrZebra:  TColor     Read getclrZeb   Write SetclrZeb; // COR DA ZEBRA
      property expZebra:  String     Read getexpZeb   Write SetexpZeb; // EXPRESSÃO DA ZEBRA
      property intMolDad: Integer    Read getMolDad   Write setMolDad; // LARGURA DA MODUDA;

      property dadEtique: TDadosEtiqueta Read FdadEti;
      property dadMargem: TDadosMargem   Read FMargem;
      property dadMarPix: TDadosMargem   Read getMarPix;

      property fltMrgSup: Double  Read getMrgSup Write setMrgSup;
      property fltMrgInf: Double  Read getMrgInf Write setMrgInf;
      property fltMrgEsq: Double  Read getMrgEsq Write setMrgEsq;
      property fltMrgDir: Double  Read getMrgDir Write setMrgDir;

      property fltLarEtq: Double  Read getLarEtq Write setLarEtq;
      property fltAltEtq: Double  Read getAltEtq Write setAltEtq;
      property fltGpHrEt: Double  Read getGpHrEt Write setGpHrEt;
      property fltGpVrEt: Double  Read getGpVrEt Write setGpVrEt;

      property fltLarEPx: Double  Read getLarEPx Write setLarEPx;
      property fltAltEPx: Double  Read getAltEPx Write setAltEPx;
      property fltGpHrPx: Double  Read getGpHrPx Write setGpHrPx;
      property fltGpVrPx: Double  Read FGpVrPx   Write setGpVrPx;

      property intNrCoEt: Integer Read getNrCoEt Write setNrCoEt;

      property intIniHor: Integer Read FIniHor;
      property intIniVer: Integer Read FIniVer;

      property intIniHoV: Integer Read getIniHoV;
      property intIniVeV: Integer Read getIniVeV;

      property intIniFoo: Integer Read FIniFoo;
      property intIniFoD: Integer Read FIniFoD;

      property intXMaste: Integer Read FXMaste;
      property intYMaste: Integer Read FYMaste;

      property fltIniHor: Double Read getIniHor;
      property fltIniVer: Double Read getIniVer;

      property blnMolSup: Boolean Read FMolSup Write setMolSup;
      property blnMolInf: Boolean Read FMolInf Write setMolInf;
      property blnMolDir: Boolean Read FMolDir Write setMolDir;
      property blnMolEsq: Boolean Read FMolEsq Write setMolEsq;
      property intMolLar: Integer Read FMolLar Write setMolLar;

      property blnHeader    : Boolean Read FHeader     Write setHeader;

      property blnHeaderData   : Boolean Read FHeaderData    Write setHeaderData;
      property intHeaderDataMol: Integer Read FHeaderDataMol Write setHeaderDataMol;
      property clrHeaderDataCor: TColor  Read FHeaderDataCor Write setHeaderDataCor;

      property blnFooter       : Boolean Read FFooter     Write setFooter;
      property blnImpUlt       : Boolean Read FImpUlt     Write setImpUlt;
      property blnFooBra       : Boolean Read FFooBra     Write setFooBra;

      property blnFooterData: Boolean Read FFooterData Write setFooterData;
      property intFooterDataMol: Integer Read FFooterDataMol Write setFooterDataMol;
      property clrFooterDataCor: TColor  Read FFooterDataCor Write setFooterDataCor;

      property strCabPri    : String Read FCabPri     Write FCabPri;

      property fltHeaAlt    : Double Read FHeaAlt     Write setHeaAlt;
      property fltHeaDataAlt: Double Read FHeaDataAlt Write setHeaDataAlt;
      property fltFooAlt    : Double Read FFooAlt     Write setFooAlt;
      property fltFooDataAlt: Double Read FFooDataAlt Write setFooDataAlt;

      property scrScroll: TScrollBox Read FScrBox Write FScrBox;

      property tplTipLay: TTipoLayout Read FTipLay;

      property strTipImp: String Read FTipImp;

      property blnConPro    : Boolean Read FConPro     Write FConPro;

      property blnSemFim    : Boolean Read FSemFim     Write FSemFim;

      property blnViaPag    : Boolean Read FViaPag     Write FViaPag;

      property blnImpPDF    : Boolean Read FImpPDF     Write FImpPDF;

      property fonCabPag: TFonteMatricial Read FCabPagFon Write FCabPagFon;
      property fonCabDad: TFonteMatricial Read FCabDadFon Write FCabPagFon;
      property fonRodDad: TFonteMatricial Read FRodDadFon Write FRodDadFon;
      property fonRodPag: TFonteMatricial Read FRodPagFon Write FRodPagFon;

      property blnFooNewPage: Boolean read FFooNewPage write FFooNewPage;

      property strNomPapVias: String Read FNomPapVias Write FNomPapVias;

  End;

  Function fZoomBarCode(bctBarCod: TfrxBarcodeType; Tamanho: Double): Double;
  Function fIndiceCustom(strTipImp: String): Integer;

implementation

Uses
  cxDropDownEdit, System.UITypes,
  untPedeFonteLinhaMatricial,
  untComponentMovel, untFuncoesSimples;

Const
  MARGEM_CINZA = 10;

Function fIndiceCustom(strTipImp: String): Integer;
Begin
  If strTipImp = 'J' Then
    Result := INDICECUSTOM_JATO
  Else
    Result := INDICECUSTOM_MATR;
End;  

Function fZoomBarCode(bctBarCod: TfrxBarcodeType; Tamanho: Double): Double;
Begin
  Case bctBarCod Of
    bcCode128A,
    bcCode128B,
    bcCodeEAN128A,
    bcCodeEAN128B,
    bcCodeEAN128C : Result := Tamanho; //Para zoom ficar igual a 1
    bcCode39Extended,
    bcCode39        : Result := 233;
    Else              Result := 95;
  End;
End;


(*************************************************************************)
(* TPaperSize                                                            *)
(*************************************************************************)
Procedure TPaperSize.pSetaPaper(intIndPap: Integer;
                                strNamPap: String;
                                fltAltPap,
                                fltLarPap: Double;
                                intIndFrx: Integer;
                                strContro: String = '';
                                strContr2: String = '';
                                strContr3: String = '';
                                fltAltFas: Double = 0;
                                fltLarFas: Double = 0);
Begin
  With FArrPpz[intIndPap] Do
  Begin
    strNomPap := ShortString(strNamPap);
    fltAltura := fltAltPap;
    fltLargur := fltLarPap;
    intValFrx := intIndFrx;
    strComand := ShortString(strContro);
    strComan2 := ShortString(strContr2);
    strComan3 := ShortString(strContr3);

    fltAltFrx := fltAltFas;
    fltLarFrx := fltLarFas;
  End;
End;

constructor TPaperSize.Create(Owner: TComponent; strTipImpP: String);
begin
  Inherited Create(Owner);

  FTipImp := strTipImpP;
  FOrient := poPortrait;
  FOrdOri := 0;
  FPapCur := 0;

  If FTipImp = 'J' Then
  Begin
    SetLength(FArrPpz, MAXPAPERSIZE_JATO);
    pSetaPaper(0, 'A4',        29.7,  21,     9);
    pSetaPaper(1, 'Carta',     27.94, 21.59,  1);
    pSetaPaper(2, 'Custom',    27.94, 21,     256);
    pSetaPaper(3, 'Executivo', 26.67, 18.42,  7);
    pSetaPaper(4, 'Ofício',    21,    14.8,   190);
    pSetaPaper(5, 'Legal',     35.56, 21.59,  5);
    pSetaPaper(6, 'A5',        21,    14.8,   11);
  End Else
  Begin
    SetLength(FArrPpz, MAXPAPERSIZE_MATRICIAL);

    pSetaPaper(0, ' 79 Colunas - Folha Inteira',  85,  79,  256, '#27#67#88', STR_080COL, '#27#64#27#48', 382.322669749942, 215.899860564673);
    pSetaPaper(1, ' 95 Colunas - Folha Inteira',  85,  95,  256, '#27#67#88', STR_096COL, '#27#64#27#48', 382.322669749942, 256.539834318024);
    pSetaPaper(2, '136 Colunas - Folha Inteira',  85, 136,  256, '#27#67#88', STR_137COL, '#27#64#27#48', 382.322669749942, 358.139768701399);
    pSetaPaper(3, '159 Colunas - Folha Inteira',  85, 159,  256, '#27#67#88', STR_160COL, '#27#64#27#48', 382.322669749942, 419.099729331425);

    pSetaPaper(4, ' 79 Colunas - Meia Folha',     42,  79,  256, '#27#64#27#67#33', STR_080COL, '#27#48', 188.912377994089, 215.899860564673);
    pSetaPaper(5, ' 95 Colunas - Meia Folha',     42,  95,  256, '#27#64#27#67#33', STR_096COL, '#27#48', 188.912377994089, 256.539834318024);
    pSetaPaper(6, '136 Colunas - Meia Folha',     42, 136,  256, '#27#64#27#67#33', STR_137COL, '#27#48', 188.912377994089, 358.139768701399);
    pSetaPaper(7, '159 Colunas - Meia Folha',     42, 159,  256, '#27#64#27#67#33', STR_160COL, '#27#48', 188.912377994089, 419.099729331425);

    pSetaPaper(8, 'Custom',                       85, 136,  256, '#27#67#88', STR_137COL, '#27#64#27#48', 382.322669749942, 358.139768701399);
  End;

  pMontaListaOrientacao;
End;

Function TPaperSize.fGetIndicePapel(strNomPap: String): Integer;
  Var
    intContador: Integer;
Begin
  Result := 0; // A4
  For intContador := Low(FArrPpz) To High(FArrPpz) Do
    If SameText(string(FArrPpz[intContador].strNomPap), strNomPap) Then
    Begin
      Result := intContador;
      Exit;
    End;
End;

Procedure TPaperSize.setOrdOri(Const Value: Integer);
Begin
  If Value <> FOrdOri Then
  Begin
    FOrdOri := Value;
    If FOrdOri = 0 Then
      FOrient := poPortrait
    Else
      FOrient := poLandscape;
  End;
End;

Procedure TPaperSize.setOrient(Const Value: TPrinterOrientation);
Begin
  If Value <> FOrient Then
  Begin
    FOrdOri := Ord(Value);
    FOrient := Value;
  End;
End;

Function TPaperSize.getLisPap: String;
  Var
    intContador: Integer;
    stlPaper   : TStringList;
Begin
  stlPaper := TStringList.Create;
  stlPaper.Clear;

  For intContador := Low(FArrPpz) To High(FArrPpz) Do
    stlPaper.Add(String(FArrPpz[intContador].strNomPap));

  Result := stlPaper.Text;

  FreeAndNil(stlPaper);
End;

Function TPaperSize.getLisPapVias: String;
  Var
    intContador: Integer;
    stlPaper   : TStringList;
Begin
  stlPaper := TStringList.Create;
  stlPaper.Clear;

  For intContador := Low(FArrPpz) To High(FArrPpz) Do
    If (intContador <> High(FArrPpz)) Then // NAO ENTRA O CUSTOM PARA VIAS NA MESMA PAGINA
      stlPaper.Add(String(FArrPpz[intContador].strNomPap));

  Result := stlPaper.Text;

  FreeAndNil(stlPaper);
End;

Procedure TPaperSize.pMontaListaOrientacao;
Begin
  FLisOri := TStringList.Create;
  FLisOri.Clear;
  FLisOri.Add('Retrato');
  FLisOri.Add('Paisagem');
End;

Function TPaperSize.getPapCur: TRecPaperSize;
Begin
  Result := FArrPpz[FPapCur];

  If FOrient = poLandscape Then
  Begin
    Result.fltAltura := FArrPpz[FPapCur].fltLargur;
    Result.fltLargur := FArrPpz[FPapCur].fltAltura;
  End;
End;

Function TPaperSize.getPapPix: TRecPaperSize;
Begin
  Result := FArrPpz[FPapCur];

  If FOrient = poLandscape Then
  Begin
    Result.fltAltura := FArrPpz[FPapCur].fltLargur;
    Result.fltLargur := FArrPpz[FPapCur].fltAltura;
  End;

  With Result Do
  Begin
    fltAltura := fCmColunaToPixel(fltAltura, True,  FTipImp);
    fltLargur := fCmColunaToPixel(fltLargur, False, FTipImp);
  End;

End;

Function TPaperSize.getNomOri: String;
Begin
  Result := FLisOri[Ord(FOrient)];
End;

Procedure TPaperSize.setCusWid(Const Value: Double);
Begin
  If FArrPpz[fIndiceCustom(FTipImp)].fltLargur <> Value Then
    FArrPpz[fIndiceCustom(FTipImp)].fltLargur := Value;
End;

Procedure TPaperSize.setCusHei(Const Value: Double);
Begin
  If FArrPpz[fIndiceCustom(FTipImp)].fltAltura <> Value Then
    FArrPpz[fIndiceCustom(FTipImp)].fltAltura := Value;
End;

Function TPaperSize.getCusWid: Double;
Begin
  Result := FArrPpz[fIndiceCustom(FTipImp)].fltLargur;
End;

destructor TPaperSize.Destroy;
begin
  inherited;
end;

Function TPaperSize.getCusHei: Double;
Begin
  Result := FArrPpz[fIndiceCustom(FTipImp)].fltAltura;
End;

Procedure TPaperSize.setPapCur(Const Value: Integer);
begin
  If FPapCur <> Value Then
  Begin
    FPapCur := Value;

    If (FPapCur <> fIndiceCustom(FTipImp)) Then
    Begin
      FArrPpz[fIndiceCustom(FTipImp)].fltAltura := FArrPpz[FPapCur].fltAltura;
      FArrPpz[fIndiceCustom(FTipImp)].fltLargur := FArrPpz[FPapCur].fltLargur;
    End;
    
  End;
end;

(*************************************************************************)
(* TReguaEditor                                                          *)
(*************************************************************************)
constructor TReguaEditor.Create(Owner: TComponent;
                                PRegLat, PRegSup, PLatAux: TPanel;
                                PRulSup, PRulLat: TfrxRuler;
                                PArgox: Boolean;
                                PScrBox: TScrollBox;
                                PTipEti: TTipoEtiqueta;
                                PTipLay: TTipoLayout;
                                strTipImpP: String);
begin
  Inherited Create(Owner);

  blnNovaImagem := False;

  FFooBra := False;
  FFooNewPage := False;
  FImpUlt := False;

  FMargem := TDadosMargem.Create;
  With FMargem Do
  Begin
    fltMarSup := 0;
    fltMarInf := 0;
    fltMarEsq := 0;
    fltMarDir := 0;
  End;

  FMarPix := TDadosMargem.Create;
  With FMarPix Do
  Begin
    fltMarSup := 0;
    fltMarInf := 0;
    fltMarEsq := 0;
    fltMarDir := 0;
  End;

  FViaPag           := False;
  FEspaca           := 0;
  FLinCommand       := 0;
  FEscMod           := 1;
  FTipImp           := strTipImpP;
  FCodEti           := PTipEti;
  FTipLay           := PTipLay;

  FScrBox           := PScrBox;
  FArgox            := PArgox;
  FPapSiz           := TPaperSize.Create(Self, FTipImp);
  FEImage           := TImage.Create(Self);
  FEImage.Parent    := TWinControl(Owner);

  FShaSup := Nil;
  FShaInf := Nil;
  FShaEsq := Nil;
  FShaDir := Nil;

  // PARA DETERMINAR A AREA DO CANVAS.CLIPRECT
  With FEImage Do
  Begin
    Top    := 0;
    Left   := 0;
    Width  := 3000;
    Height := 3000;
  End;

  FCabPagFon.colFonte   := col137;
  FCabDadFon.colFonte   := col137;
  FRodDadFon.colFonte   := col137;
  FRodPagFon.colFonte   := col137;

  pInicializaMedidas;

  pInicializaReguas(PRegLat, PRegSup, PLatAux, PRulSup, PRulLat);

End;

Procedure TReguaEditor.pInicializaMedidas;
Begin
  If FTipLay = tplDocumentos Then
  Begin

    With FdadEti Do
    Begin
      If FTipImp = 'M' Then
        FPapSiz.intPapCur := 6; 

      If FTipImp = 'J' Then
        fltAltEti := 0.6
      Else
        fltAltEti := 1;

      fltGapHor := 0;
      fltGapVer := 0;
      FGpVrPx   := 0;
      intNumCol := 0;

      FHeader := True;
      FHeaAlt := 4;

      FclrZeb        := clWhite;
      FZooFix        := 0;
      FexpZeb        := '';
      FHeaderDataCor := clWhite;

      FFooterDataCor := clWhite;

      FHeaderData := True;

      If FTipImp = 'J' Then
        FHeaDataAlt := 0.8
      Else
        FHeaDataAlt := 1;

      FFooterData := False;
      FFooDataAlt := 0;

      FFooter := True;
      FFooAlt := 3;
    End;

    With FMargem Do
    Begin

      If FTipImp = 'J' Then
      Begin
        fltMarSup := 1;
        fltMarInf := 1;
        fltMarEsq := 1;
        fltMarDir := 1;
      End Else
      Begin
        fltMarSup := 0;
        fltMarInf := 0;
        fltMarEsq := 0;
        fltMarDir := 0;
      End;

    End;

  End

  Else If FArgox Then
  Begin
    ppzPapSiz.intPapCur := fIndiceCustom(FTipImp);

    With FMargem Do
    Begin
      fltMarSup := 0;
      fltMarInf := 0;
      fltMarEsq := 0;
      fltMarDir := 0;
    End;

    With FdadEti Do
    Begin
      fltLarEti := 7;
      fltAltEti := 4;
      fltGapHor := 0;
      fltGapVer := 0;
      intNumCol := 1;

      ppzPapSiz.fltCusHei := (fltAltEti + fltGapHor);
      ppzPapSiz.fltCusWid := ((fltLarEti * intNumCol) + (fltGapVer * Pred(intNumCol)));
    End;

  End Else
  Begin

    With FdadEti Do
    Begin
      fltLarEti := 9.34;
      fltAltEti := 3.2;
      fltGapHor := 0.3;
      fltGapVer := 0.3;
      FGpVrPx   := fCmColunaToPixel(0.3, False, FTipImp);
      intNumCol := 2;
    End;

    With FMargem Do
    Begin
      fltMarSup := 1;
      fltMarInf := 1;
      fltMarEsq := 1;
      fltMarDir := 1;
    End;

  End;
End;

Destructor TReguaEditor.Destroy;
begin
  inherited;

  FreeAndNil(FMarPix);
  FreeAndNil(FMargem);
end;

Procedure TReguaEditor.pLinhasDeEscalaHeader;
  Var
    fltLarCol,
    fltContador: Double;
    intPonto,
    intLinhas,
    intColunas: Integer;
Begin
  // DESENHA A REGUA INTERNA;
  TComponentMovel(FCmpMvl).pMontaLinhaHeader;

  With FEImage, ppzPapSiz, recPapPix, dadMarPix Do
  Begin
    If FTipImp = 'J' Then
      canvas.Pen.Color := $00E5E5E5
    Else
      canvas.Pen.Color := $00D7D7D7;

    // DESENHA AS LINHAS VERTICAIS DO HEADER
    If FTipImp = 'J' Then
    Begin

      fltContador := fltMarEsq + MARGEM_CINZA + fCmColunaToPixel(1, False, FTipImp) { CMPIXEL};

      While fltContador <= fltLargur - fltMarDir + MARGEM_CINZA - 1 Do
      Begin
        intPonto := Trunc(fltContador);
        Canvas.MoveTo(intPonto, Trunc(fltMarSup) +  + MARGEM_CINZA);
        Canvas.LineTo(intPonto, Trunc(fCmColunaToPixel(FHeaAlt, True, FTipImp) + fltMarSup) + MARGEM_CINZA);
        fltContador := fltContador + fCmColunaToPixel(1, False, FTipImp) { CMPIXEL}
      End;

    End Else
    Begin

      For intLinhas := 2 To Trunc({FHeaAlt} FArrPpz[intPapCur].fltAltura) Do
      Begin
        // TEM QUE PEGAR A LARGURA DA LINHA CORRENTE
        fltLarCol := TComponentMovel(FCmpMvl).fRetLarguraColuna(intLinhas - 1);

        fltContador := fltMarEsq + MARGEM_CINZA + fltLarCol { CMPIXEL};

        intColunas := 0;

        While fltContador <= fltLargur - fltMarDir + MARGEM_CINZA - 1 Do
        Begin
          If intColunas > TComponentMovel(FCmpMvl).fQuantidadeColunas(intLinhas - 1) Then
            Break;

          intPonto := Round(fltContador);

          Canvas.MoveTo(intPonto, Trunc(fCmColunaToPixel(intLinhas - 1, True, FTipImp) + fltMarSup) + MARGEM_CINZA);

          Canvas.LineTo(intPonto, Trunc(fCmColunaToPixel(intLinhas, True, FTipImp) + fltMarSup) + MARGEM_CINZA);

          If fltLarCol > 0 Then
            fltContador := fltContador + fltLarCol
          Else
            fltContador := fltContador + fCmColunaToPixel(1, False, FTipImp, False); { CMPIXEL}


          Inc(intColunas);
        End;

      End;

    End;
   // FIM DAS LINHAS VERTICAIS DO HEADER

   // DESENHA AS LINHAS HORIZONTAIS
    fltContador := fCmColunaToPixel(1, True, FTipImp) { CMPIXEL} + fltMarSup + MARGEM_CINZA;
    While fltContador <= fCmColunaToPixel(FHeaAlt, True, FTipImp) + fltMarSup + MARGEM_CINZA Do
    Begin
      intPonto := Trunc(fltContador);
      Canvas.MoveTo(Trunc(fltMarEsq) + MARGEM_CINZA, intPonto);
      Canvas.LineTo(Trunc(fltLargur - fltMarDir) + MARGEM_CINZA, intPonto);
      fltContador := fltContador + fCmColunaToPixel(1, True, FTipImp) { CMPIXEL};
    End;

    If FTipImp = 'J' Then
    Begin
      canvas.Pen.Color := $00EEEEEE;

      fltContador := fltMarEsq + MARGEM_CINZA + CMPIXEL;
      While fltContador <= fltLargur - fltMarDir + MARGEM_CINZA + MEIOCMPIXEL Do
      Begin
        intPonto := Trunc(fltContador - MEIOCMPIXEL);
        Canvas.MoveTo(intPonto, Trunc(fltMarSup) + MARGEM_CINZA);
        Canvas.LineTo(intPonto, Trunc(fCmColunaToPixel(FHeaAlt, True, FTipImp) + fltMarSup) + MARGEM_CINZA);
        fltContador := fltContador + CMPIXEL;
      End;

      fltContador := CMPIXEL + fltMarSup + MARGEM_CINZA;
      While fltContador <= fCmColunaToPixel(FHeaAlt, False, FTipImp) + fltMarSup + MARGEM_CINZA + CMPIXEL Do
      Begin
        intPonto := Trunc(fltContador - MEIOCMPIXEL);
        Canvas.MoveTo(Trunc(fltMarEsq) + MARGEM_CINZA,             intPonto);
        Canvas.LineTo(Trunc(fltLargur - fltMarDir) + MARGEM_CINZA, intPonto);
        fltContador := fltContador + CMPIXEL;
      End;
    End;
  End;
End; {pLinhasDeEscalaHeader}

Procedure TReguaEditor.pLinhasDeEscalaFooter;
  Var
    fltContador: Double;
    intPonto: Integer;
Begin
  // DESENHA A REGUA INTERNA;
  With FEImage, ppzPapSiz, recPapPix, dadMarPix Do
  Begin
    If FTipImp = 'J' Then
      canvas.Pen.Color := $00E5E5E5
    Else
      canvas.Pen.Color := $00D7D7D7;

    If FTipImp = 'J' Then
    Begin

      fltContador := fltMarEsq + MARGEM_CINZA + fCmColunaToPixel(1, False, FTipImp) { CMPIXEL};
      While fltContador <= fltLargur - fltMarDir + MARGEM_CINZA -1 Do
      Begin
        intPonto := Trunc(fltContador);
        Canvas.MoveTo(intPonto, Trunc(fltAltura - fltMarInf - fCmColunaToPixel(FFooAlt, True, FTipImp)) + MARGEM_CINZA);
        Canvas.LineTo(intPonto, Trunc(fltAltura - fltMarInf) + MARGEM_CINZA);
        fltContador := fltContador + fCmColunaToPixel(1, False, FTipImp) { CMPIXEL};
      End;

    End Else
    Begin
      (*
      fltContador := fltMarEsq + MARGEM_CINZA + fCmColunaToPixel(1, False, FTipImp, False) { CMPIXEL};
      While fltContador <= fltLargur - fltMarDir + MARGEM_CINZA -1 Do
      Begin
        intPonto := Trunc(fltContador);
        Canvas.MoveTo(intPonto, Trunc(fltAltura - fltMarInf - fCmColunaToPixel(FFooAlt, True, FTipImp)) + MARGEM_CINZA);
        Canvas.LineTo(intPonto, Trunc(fltAltura - fltMarInf) + MARGEM_CINZA);
        fltContador := fltContador + fCmColunaToPixel(1, False, FTipImp, False) { CMPIXEL};
      End;
       *)
    End;

    fltContador := fCmColunaToPixel(1, True, FTipImp) { CMPIXEL} + fltAltura - fltMarInf - fCmColunaToPixel(FFooAlt, True, FTipImp) + MARGEM_CINZA;
    While fltContador <= Trunc(fltAltura - fltMarInf) + MARGEM_CINZA Do
    Begin
      intPonto := Trunc(fltContador);
      Canvas.MoveTo(Trunc(fltMarEsq) + MARGEM_CINZA, intPonto);
      Canvas.LineTo(Trunc(fltLargur - fltMarDir) + MARGEM_CINZA, intPonto);
      fltContador := fltContador + fCmColunaToPixel(1, True, FTipImp) { CMPIXEL};
    End;

    If FTipImp = 'J' Then
    Begin
      canvas.Pen.Color := $00EEEEEE;

      fltContador := fltMarEsq + MARGEM_CINZA + CMPIXEL;
      While fltContador <= fltLargur - fltMarDir + MARGEM_CINZA + MEIOCMPIXEL Do
      Begin
        intPonto := Trunc(fltContador - MEIOCMPIXEL);
        Canvas.MoveTo(intPonto, Trunc(fltAltura - fltMarInf - fCmColunaToPixel(FFooAlt, True, FTipImp)) + MARGEM_CINZA);
        Canvas.LineTo(intPonto, Trunc(fltAltura - fltMarInf) + MARGEM_CINZA);
        fltContador := fltContador + CMPIXEL;
      End;

      fltContador := CMPIXEL + fltAltura - fltMarInf - fCmColunaToPixel(FFooAlt, True, FTipImp) + MARGEM_CINZA;
      While fltContador <= fCmColunaToPixel(FHeaAlt, True, FTipImp) + fltMarSup + MARGEM_CINZA + CMPIXEL Do
      Begin
        intPonto := Trunc(fltContador - MEIOCMPIXEL);
        Canvas.MoveTo(Trunc(fltMarEsq) + MARGEM_CINZA,             intPonto);
        Canvas.LineTo(Trunc(fltLargur - fltMarDir) + MARGEM_CINZA, intPonto);
        fltContador := fltContador + CMPIXEL;
      End;
    End;  

  End;
End;

Procedure TReguaEditor.pSetaRegua;
  Var
    rctPagina  : TRect;
    fltContador: Double;
    intPonto   : Integer;

    fltXSupEsq,
    fltYSupEsq,
    fltXInfDir,
    fltYInfDir: Double;
    blnPrimeir: Boolean;

    intHeader,
    intHeaderData,
    intFooter: Integer;

    Procedure pFundoCinza;
    Begin
      // PINTA FUNDO DA IMAGEM DE CINZA
      With rctPagina, ppzPapSiz, recPapPix Do
      Begin
        Left   := 0;
        Top    := 0;
        Bottom := Trunc(fltAltura) + 2*MARGEM_CINZA;
        Right  := Trunc(fltLargur) + 2*MARGEM_CINZA;
      End;

      With FEImage Do
      Begin
        Canvas.Brush.Color := clLtGray;
        Canvas.FillRect(rctPagina);
      End;

      FEImage.Refresh;
      FEImage.Canvas.Refresh;
      Application.ProcessMessages;
    End; {pFundoCinza;}

    Procedure pPaginaBranca;
    Begin
      // PINTA PAGINA INTEIRA DE BRANCO
      With rctPagina, ppzPapSiz, recPapPix Do
      Begin
        Left   := MARGEM_CINZA;
        Top    := MARGEM_CINZA;
        Bottom := Trunc(fltAltura) + MARGEM_CINZA;
        Right  := Trunc(fltLargur) + MARGEM_CINZA;
      End;

      With FEImage Do
      Begin
        Canvas.Brush.Color := FUNDO_FOLHA;
        Canvas.FillRect(rctPagina);
      End;
    End; {pPaginaBranca;}

    Procedure pBordasPagina;
    Begin
      // DESENHA AS BORDAS DA FOLHA CONSIDERANDO AS MARGENS;
      With FEImage, ppzPapSiz, recPapPix, dadMarPix Do
      Begin
        Canvas.Pen.Color := clLtGray;
        Canvas.Pen.Style := psDash;
        Canvas.Rectangle(Trunc(fltMarEsq) + MARGEM_CINZA - 1,
                         Trunc(fltMarSup) + MARGEM_CINZA - 1,
                         Trunc(fltLargur - fltMarDir) + MARGEM_CINZA + 1,
                         Trunc(fltAltura - fltMarInf) + MARGEM_CINZA + 1);
        Canvas.Pen.Style := psSolid;
      End;
    End; {pBordasPagina}

    Procedure pLinhasDeEscalaJato;
    Begin
      // DESENHA A REGUA INTERNA;
      With FEImage, ppzPapSiz, recPapPix, dadMarPix Do
      Begin
        If FTipImp = 'J' Then
          canvas.Pen.Color := $00E5E5E5
        Else
          canvas.Pen.Color := $00EEEEEE;

        If FTipImp = 'J' Then
        Begin

          fltContador := fltMarEsq + MARGEM_CINZA + fCmColunaToPixel(1, False, FTipImp) { CMPIXEL};
          While fltContador <= fltLargur - fltMarDir + MARGEM_CINZA Do
          Begin
            intPonto := Trunc(fltContador);
            Canvas.MoveTo(intPonto, Trunc(fltMarSup) + MARGEM_CINZA);
            Canvas.LineTo(intPonto, Trunc(fltAltura - fltMarInf) + MARGEM_CINZA);
            fltContador := fltContador + fCmColunaToPixel(1, False, FTipImp) { CMPIXEL};
          End;

        End Else
        Begin
          (*
          fltContador := fltMarEsq + MARGEM_CINZA + fCmColunaToPixel(1, False, FTipImp, False) { CMPIXEL};
          While fltContador <= fltLargur - fltMarDir + MARGEM_CINZA Do
          Begin
            intPonto := Trunc(fltContador);
            Canvas.MoveTo(intPonto, Trunc(fltMarSup) + MARGEM_CINZA);
            Canvas.LineTo(intPonto, Trunc(fltAltura - fltMarInf) + MARGEM_CINZA);
            fltContador := fltContador + fCmColunaToPixel(1, False, FTipImp, False) { CMPIXEL};
          End;
          *)
        End;


        fltContador := fCmColunaToPixel(1, True, FTipImp) { CMPIXEL} + fltMarSup + MARGEM_CINZA;
        While fltContador <= fltAltura - fltMarInf + MARGEM_CINZA Do
        Begin
          intPonto := Trunc(fltContador);
          Canvas.MoveTo(Trunc(fltMarEsq) + MARGEM_CINZA, intPonto);
          Canvas.LineTo(Trunc(fltLargur - fltMarDir) + MARGEM_CINZA, intPonto);
          fltContador := fltContador + fCmColunaToPixel(1, True, FTipImp) { CMPIXEL};
        End;

        If FTipImp = 'J' Then
        Begin
          canvas.Pen.Color := $00EEEEEE;

          fltContador := fltMarEsq + MARGEM_CINZA + CMPIXEL;
          While fltContador <= fltLargur - fltMarDir + MARGEM_CINZA + MEIOCMPIXEL Do
          Begin
            intPonto := Trunc(fltContador - MEIOCMPIXEL);
            Canvas.MoveTo(intPonto, Trunc(fltMarSup) + MARGEM_CINZA);
            Canvas.LineTo(intPonto, Trunc(fltAltura - fltMarInf) + MARGEM_CINZA);
            fltContador := fltContador + CMPIXEL;
          End;

          fltContador := CMPIXEL + fltMarSup + MARGEM_CINZA;
          While fltContador <= fltAltura - fltMarInf + MARGEM_CINZA + CMPIXEL Do
          Begin
            intPonto := Trunc(fltContador - MEIOCMPIXEL);
            Canvas.MoveTo(Trunc(fltMarEsq) + MARGEM_CINZA,             intPonto);
            Canvas.LineTo(Trunc(fltLargur - fltMarDir) + MARGEM_CINZA, intPonto);
            fltContador := fltContador + CMPIXEL;
          End;
        End;

      End;
    End; {pLinhasDeEscalaJato}

    Procedure pPintaAreaCamposMasterData;
      Var
        p1, p2, p3, p4, p5: TPoint;
        corFundo: TColor;
    Begin
      With FEImage, ppzPapSiz, recPapPix, dadMarPix Do
      Begin

        fltYSupEsq := fltMarSup + MARGEM_CINZA + intHeader + intHeaderData;
        fltYInfDir := fltMarSup + MARGEM_CINZA + intHeader + intHeaderData + fltAltEPx;

        fltXSupEsq := fltMarEsq + MARGEM_CINZA;

        fltXInfDir := fltMarEsq + MARGEM_CINZA + fltLarEPx;

        p1.X := Trunc(fltXSupEsq); p1.y := Trunc(fltYSupEsq);
        p2.X := Trunc(fltXInfDir); p2.y := Trunc(fltYSupEsq);
        p3.X := Trunc(fltXInfDir); p3.Y := Trunc(fltYInfDir);
        p4.X := Trunc(fltXSupEsq); p4.Y := Trunc(fltYInfDir);
        p5.X := Trunc(fltXSupEsq); p5.Y := Trunc(fltYSupEsq);

        corFundo := Canvas.Brush.Color;
        Canvas.Brush.Color := COR_DADOS;

        Canvas.Rectangle(p1.X, p1.y, p3.X, p4.Y);


        Canvas.Brush.Color := corFundo;

      End;
    End; {pPintaAreaCamposMasterData}

    Procedure pEtiquetas;
      Var
        intIndice: Integer;
        p1, p2, p3, p4, p5: TPoint;
        blnInicializouPontos: Boolean;
    Begin
      // DESENHA AS ETIQUETAS;
      With FEImage, ppzPapSiz, recPapPix, dadMarPix Do
      Begin
        blnInicializouPontos := False;
        canvas.Pen.Width := 1;
        canvas.Pen.Color := clGray;
        Canvas.Pen.Style := psSolid;

        fltYSupEsq := fltMarSup + MARGEM_CINZA + intHeader + intHeaderData;
        fltYInfDir := fltMarSup + MARGEM_CINZA + intHeader + intHeaderData + fltAltEPx;

        blnPrimeir := True;
        While True Do
        Begin
          fltXSupEsq := fltMarEsq + MARGEM_CINZA;
          fltXInfDir := fltMarEsq + MARGEM_CINZA + fltLarEPx;

          For intIndice := 1 To dadEtique.intNumCol Do
          Begin
            If fltXInfDir > fltLargur - fltMarDir + MARGEM_CINZA Then
              Break;

            If blnPrimeir Then
            Begin
              p1.X := Trunc(fltXSupEsq); p1.y := Trunc(fltYSupEsq);
              p2.X := Trunc(fltXInfDir); p2.y := Trunc(fltYSupEsq);
              p3.X := Trunc(fltXInfDir); p3.Y := Trunc(fltYInfDir);
              p4.X := Trunc(fltXSupEsq); p4.Y := Trunc(fltYInfDir);
              p5.X := Trunc(fltXSupEsq); p5.Y := Trunc(fltYSupEsq);

              blnInicializouPontos := True; 

              If FTipLay = tplDocumentos Then
                Break;
            End
            Else
            Begin
              canvas.Pen.Color := clGray;
              Canvas.MoveTo(Trunc(fltXSupEsq), Trunc(fltYSupEsq));
              Canvas.LineTo(Trunc(fltXInfDir)-1, Trunc(fltYSupEsq));
              Canvas.LineTo(Trunc(fltXInfDir)-1, Trunc(fltYInfDir));
              Canvas.LineTo(Trunc(fltXSupEsq), Trunc(fltYInfDir));
              Canvas.LineTo(Trunc(fltXSupEsq), Trunc(fltYSupEsq));
            End;

            fltXSupEsq := fltXSupEsq + fltLarEPx + fltGpHrPx;
            fltXInfDir := fltXInfDir + fltLarEPx + fltGpHrPx;

            blnPrimeir := False;
          End;

          fltYSupEsq := fltYSupEsq + fltAltEPx + fltGpVrPx;
          fltYInfDir := fltYInfDir + fltAltEPx + fltGpVrPx;

          If fltYInfDir > fltAltura - fltMarInf + MARGEM_CINZA - intFooter Then
            Break;

          If FTipLay = tplDocumentos Then
            Break;
        End; {While}

        If blnInicializouPontos Then
        Begin
          canvas.Pen.Color := clBlue;
          Canvas.MoveTo(p1.x, p1.y);
          Canvas.LineTo(p2.x-1, p2.y);
          Canvas.LineTo(p3.x-1, p3.y);
          Canvas.LineTo(p4.x, p4.y);
          Canvas.LineTo(p5.x, p5.y);
        End;  
      End;
    End; {pEtiquetas}

    Procedure pSetaPontoInicialPagina;
    Begin
      With dadMarPix Do
      Begin
        FIniHor := MARGEM_CINZA + Trunc(fltMarEsq);
        FIniVer := MARGEM_CINZA + Trunc(fltMarSup);

        FIniFoo := MARGEM_CINZA + Trunc(fCmColunaToPixel(ppzPapSiz.recPapCur.fltAltura, True, FTipImp) - fltMarInf - fCmColunaToPixel(FFooAlt, True, FTipImp));

        FIniFoD := MARGEM_CINZA + Trunc(fCmColunaToPixel(ppzPapSiz.recPapCur.fltAltura, True, FTipImp) - fltMarInf -
                   fCmColunaToPixel(FFooAlt, True, FTipImp) - fCmColunaToPixel(FFooDataAlt, True, FTipImp) +  IfThen(FTipImp = 'J', 0, fCmColunaToPixel(1, True, FTipImp)));

        FXMaste := MARGEM_CINZA + Trunc(fltMarEsq);
        FYMaste := MARGEM_CINZA + Trunc(fltMarSup) + intHeader + intHeaderData;
      End;
    End; {pSetaPontoInicialPagina}

    Procedure pSetaTamanhoImagem;
    Begin
      // SETA TAMANHO TOTAL DA IMAGEM
      With FEImage, FPapSiz.recPapPix Do
      Begin
        Top    := 0;
        Left   := 0;
        Width  := Trunc(fltLargur) + 2*MARGEM_CINZA;
        Height := Trunc(fltAltura) + 2*MARGEM_CINZA;
      End;
    End; {pSetaTamanhoImagem}

    Procedure pHeader;
      Var
        corFundo: TColor;
    Begin
      With FEImage, ppzPapSiz, recPapPix, dadMarPix Do
      If FHeader And (Trunc(fCmColunaToPixel(FHeaAlt, True, FTipImp)) > 0) Then
      Begin
        canvas.Pen.Width := 1;
        canvas.Pen.Color := clBlack;
        Canvas.Pen.Style := psSolid;

        corFundo := Canvas.Brush.Color;
        Canvas.Brush.Color := COR_CABEC_PAGINA;

        Canvas.Rectangle(MARGEM_CINZA + Trunc(fltMarEsq),
                         MARGEM_CINZA + Trunc(fltMarSup),
                         MARGEM_CINZA + Trunc(fltLargur - fltMarDir),
                         MARGEM_CINZA + Trunc(fltMarSup) + Trunc(fCmColunaToPixel(FHeaAlt, True, FTipImp)));

        pLinhasDeEscalaHeader;

        Canvas.Brush.Color := corFundo;
      End;
    End;

    Procedure pHeaderData;
      Var
        corFundo: TColor;
    Begin
      With FEImage, ppzPapSiz, recPapPix, dadMarPix Do
      If FHeaderData And (Trunc(fCmColunaToPixel(FHeaDataAlt, True, FTipImp)) > 0) Then
      Begin
        canvas.Pen.Width := 1;
        canvas.Pen.Color := clBlack;
        Canvas.Pen.Style := psSolid;

        corFundo := Canvas.Brush.Color;
        Canvas.Brush.Color := COR_CABEC_DADOS;

        Canvas.Rectangle(MARGEM_CINZA + Trunc(fltMarEsq),
                         MARGEM_CINZA + Trunc(fltMarSup) + Trunc(fCmColunaToPixel(FHeaAlt, True, FTipImp)) - 1,
                         MARGEM_CINZA + Trunc(fltLargur - fltMarDir),
                         MARGEM_CINZA + Trunc(fltMarSup) + Trunc(fCmColunaToPixel(FHeaAlt + FHeaDataAlt, True, FTipImp)));

        Canvas.Brush.Color := corFundo;

        If FTipImp = 'M' Then
        Begin
          canvas.Pen.Color := $00D7D7D7;
                                                                                                                                     {Uma abaixo para nao tirar a moldura}
          fltContador := MARGEM_CINZA + Trunc(fltMarSup) + Trunc(fCmColunaToPixel(FHeaAlt, True, FTipImp)) - 1 + fCmColunaToPixel(1, True, FTipImp);

                                                                                                                                 {Uma acima para nao tirar a moldura}
          While fltContador <= MARGEM_CINZA + Trunc(fltMarSup) + Trunc(fCmColunaToPixel(FHeaAlt + FHeaDataAlt, True, FTipImp)) + 1 - fCmColunaToPixel(1, True, FTipImp) Do
          Begin
            intPonto := Trunc(fltContador);
            Canvas.MoveTo(Trunc(fltMarEsq) + MARGEM_CINZA, intPonto);
            Canvas.LineTo(Trunc(fltLargur - fltMarDir) + MARGEM_CINZA, intPonto);
            fltContador := fltContador + fCmColunaToPixel(1, True, FTipImp) { CMPIXEL};
          End;

          canvas.Pen.Color := clBlack;
        End;

      End;
    End;

    Procedure pFooterData;
      Var
        corFundo: TColor;
        fltFooAltAux: Double;
    Begin
      If FFooterData And (Trunc(fCmColunaToPixel(FFooDataAlt, True, FTipImp)) > 0) Then
      With FEImage, ppzPapSiz, recPapPix, dadMarPix Do
      Begin
        If FFooter Then
          fltFooAltAux := FFooAlt
        Else
          fltFooAltAux := 0;

        canvas.Pen.Width := 1;
        canvas.Pen.Color := clBlack;
        Canvas.Pen.Style := psSolid;

        corFundo := Canvas.Brush.Color;
        Canvas.Brush.Color := COR_RODAPE_DADOS;

        Canvas.Rectangle(MARGEM_CINZA + Trunc(fltMarEsq),
                         MARGEM_CINZA + Trunc(fltAltura - fltMarInf - fCmColunaToPixel(fltFooAltAux + FFooDataAlt, True, FTipImp)),
                         MARGEM_CINZA + Trunc(fltLargur - fltMarDir),
                         MARGEM_CINZA + Trunc(fltAltura - fltMarInf - fCmColunaToPixel(fltFooAltAux, True, FTipImp)) + 1);

        Canvas.Brush.Color := corFundo;

        If FTipImp = 'M' Then
        Begin
          canvas.Pen.Color := $00D7D7D7;
                                                                                                                                     {Uma abaixo para nao tirar a moldura}
          fltContador := MARGEM_CINZA + Trunc(fltAltura - fltMarInf - fCmColunaToPixel(fltFooAltAux + FFooDataAlt, True, FTipImp)) + fCmColunaToPixel(1, True, FTipImp);

                                                                                                                                 {Uma acima para nao tirar a moldura}
          While fltContador <= MARGEM_CINZA + Trunc(fltAltura - fltMarInf - fCmColunaToPixel(fltFooAltAux, True, FTipImp)) + 1 - fCmColunaToPixel(1, True, FTipImp) Do
          Begin
            intPonto := Trunc(fltContador);
            Canvas.MoveTo(Trunc(fltMarEsq) + MARGEM_CINZA, intPonto);
            Canvas.LineTo(Trunc(fltLargur - fltMarDir) + MARGEM_CINZA, intPonto);
            fltContador := fltContador + fCmColunaToPixel(1, True, FTipImp) { CMPIXEL};
          End;

          canvas.Pen.Color := clBlack;
        End;

      End;
    End;

    Procedure pFooter;
      Var
        corFundo: TColor;
    Begin
      If FFooter And (Trunc(fCmColunaToPixel(FFooAlt, True, FTipImp)) > 0) Then
      With FEImage, ppzPapSiz, recPapPix, dadMarPix Do
      Begin
        canvas.Pen.Width := 1;
        canvas.Pen.Color := clBlack;
        Canvas.Pen.Style := psSolid;

        corFundo := Canvas.Brush.Color;
        Canvas.Brush.Color := COR_RODAPE_PAGINA;

        Canvas.Rectangle(MARGEM_CINZA + Trunc(fltMarEsq),
                         MARGEM_CINZA + Trunc(fltAltura - fltMarInf - fCmColunaToPixel(FFooAlt, True, FTipImp)),
                         MARGEM_CINZA + Trunc(fltLargur - fltMarDir),
                         MARGEM_CINZA + Trunc(fltAltura - fltMarInf));

        pLinhasDeEscalaFooter;

        Canvas.Brush.Color := corFundo;
      End;
    End;

Begin
  pAjustaLarguraEtqDocumentos;

  FScrBox.VertScrollBar.Position := 0;
  FScrBox.HorzScrollBar.Position := 0;

  With FEImage, ppzPapSiz, recPapPix, dadMarPix Do
  Begin
    If FHeader Then
      intHeader := Trunc(fCmColunaToPixel(FHeaAlt, True, FTipImp))
    Else
      intHeader := 0;

    If FHeaderData Then
      intHeaderData := Trunc(fCmColunaToPixel(FHeaDataAlt, True, FTipImp))
    Else
      intHeaderData := 0;

    If FFooter Then
      intFooter := Trunc(fCmColunaToPixel(FFooAlt, True, FTipImp))
    Else
      intFooter := 0;
  End;

  pFundoCinza;
  pPaginaBranca;
  pBordasPagina;

  pPintaAreaCamposMasterData;

  pLinhasDeEscalaJato;

  pEtiquetas;

  If FTipImp = 'J' Then
  Begin
    pHeader;
    pHeaderData;
    pFooter;
    pFooterData;
  End Else
  Begin
    pHeaderData;
    pFooter;
    pFooterData;
    pHeader;
  End;

  pSetaPontoInicialPagina;
  pSetaTamanhoImagem;

  pPosicionaReguas;

  pSetaMolduraSuperior;
  pSetaMolduraInferior;
  pSetaMolduraDireita;
  pSetaMolduraEsquerda;
End;

Procedure TReguaEditor.pInicializaReguas(PRegLat, PRegSup, PLatAux: TPanel;
                                         PRulSup, PRulLat: TfrxRuler);
Begin
  FRegLat := PRegLat;
  FRegSup := PRegSup;
  FLatAux := PLatAux;
  FRulSup := PRulSup;
  FRulLat := PRulLat;
End;

Procedure TReguaEditor.pPosicionaReguas;
Begin
  With FEImage, ppzPapSiz, recPapPix Do
  Begin
    FRegLat.Visible := True;
    FRegSup.Visible := True;
    FRulSup.Width   := Trunc(fltLargur);
    FRulSup.Left    := FIniHor + FRegLat.Width;
    FRulLat.Height  := Trunc(fltAltura);
    FLatAux.Top     := FIniVer;
    FLatAux.Height  := Trunc(fltAltura);
  End;
End;

Function TReguaEditor.getOrinta: Integer;
Begin
  Result := ppzPapSiz.intOrdOri;
End;

Function TReguaEditor.getPagina: Integer;
Begin
  Result := ppzPapSiz.intPapCur;
End;

Procedure TReguaEditor.setOrinta(Const Value: Integer);
begin
  If Value <> ppzPapSiz.intOrdOri Then
  Begin
    FPapSiz.intOrdOri := Value;
    pSetaRegua;
  End;
end;

Procedure TReguaEditor.pAjustaLarguraEtqDocumentos;
var
  fltQtdCol : Double;
Begin
  fltQtdCol := getNrCoEt;
  If (FTipLay = tplDocumentos) and ((fltQtdCol = 1) or (FCodEti <> tpeCupomPromocao)) Then
  Begin
    fltLarEPx := fCmColunaToPixel(FPapSiz.recPapCur.fltLargur - FMargem.fltMarDir - FMargem.fltMarEsq, False, FTipImp);
  End;
End;

Procedure TReguaEditor.setPagina(Const Value: Integer);
begin
  If Value <> ppzPapSiz.intPapCur Then
  Begin
    FPapSiz.intPapCur := Value;

    If (Value <> fIndiceCustom(FTipImp)) Then
      pSetaRegua;

    pAjustaLarguraEtqDocumentos;
  End;
end;

Function TReguaEditor.getWidPag: Double;
Begin
  Result := FPapSiz.recPapCur.fltLargur;
End;

Function TReguaEditor.getHeiPag: Double;
Begin
  Result := FPapSiz.recPapCur.fltAltura;
End;

Procedure TReguaEditor.setWidPag(Const Value: Double);
Begin
  If (FPapSiz.intPapCur = fIndiceCustom(FTipImp)) Then
  Begin
     FPapSiz.fltCusWid := Value;
     pSetaRegua;
  End;

  pAjustaLarguraEtqDocumentos;
End;

Procedure TReguaEditor.setHeiPag(Const Value: Double);
Begin
  If (FPapSiz.intPapCur = fIndiceCustom(FTipImp)) Then
  Begin
    FPapSiz.fltCusHei := Value;
    pSetaRegua;
  End;
End;

Function TReguaEditor.getMrgSup: Double;
Begin
  Result := FMargem.fltMarSup;
End;

Function TReguaEditor.getMrgInf: Double;
Begin
  Result := FMargem.fltMarInf;
End;

Function TReguaEditor.getMrgEsq: Double;
Begin
  Result := FMargem.fltMarEsq;
End;

Function TReguaEditor.getMrgDir: Double;
Begin
  Result := FMargem.fltMarDir;
End;

Procedure TReguaEditor.setMrgSup(Const Value: Double);
Begin
  If FMargem.fltMarSup <> Value Then
  Begin
    FMargem.fltMarSup := Value;
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setMrgInf(Const Value: Double);
Begin
  If FMargem.fltMarInf <> Value Then
  Begin
    FMargem.fltMarInf := Value;
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setMrgEsq(Const Value: Double);
Begin
  If FMargem.fltMarEsq <> Value Then
  Begin
    FMargem.fltMarEsq := Value;
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setMrgDir(Const Value: Double);
Begin
  If FMargem.fltMarDir <> Value Then
  Begin
    FMargem.fltMarDir := Value;
    pSetaRegua;
  End;
End;

Function TReguaEditor.getLarEtq: Double;
Begin
  Result := FdadEti.fltLarEti;
End;

Function TReguaEditor.getAltEtq: Double;
Begin
  Result := FdadEti.fltAltEti;
End;

Function TReguaEditor.getGpHrEt: Double;
Begin
  Result := FdadEti.fltGapHor;
End;

Function TReguaEditor.getGpVrEt: Double;
Begin
  Result := FdadEti.fltGapVer;
End;

Function TReguaEditor.getNrCoEt: Integer;
Begin
  Result := FdadEti.intNumCol;
End;

Procedure TReguaEditor.setLarEtq(Const Value: Double);
Begin
  If FdadEti.fltLarEti <> Value Then
  Begin
    FdadEti.fltLarEti := Value;
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setAltEtq(Const Value: Double);
Begin
  If FdadEti.fltAltEti <> Value Then
  Begin
    FdadEti.fltAltEti := Value;
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setGpHrEt(Const Value: Double);
Begin
  If FdadEti.fltGapHor <> Value Then
  Begin
    FdadEti.fltGapHor := Value;
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setGpVrEt(Const Value: Double);
Begin
  If fPixelToCmColuna(FGpVrPx, True, FTipImp) <> Value Then
  Begin
    FGpVrPx := fCmColunaToPixel(Value, True, FTipImp);
    FdadEti.fltGapVer := Value;
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setNrCoEt(Const Value: Integer);
Begin
  If FdadEti.intNumCol <> Value Then
  Begin
    FdadEti.intNumCol := Value;
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.pNovaRegua(blnRefresh: Boolean = True);
Begin
  FPapSiz.intOrdOri := 0;
  FPapSiz.intPapCur := 0;

  pInicializaMedidas;

  If blnRefresh Then
    pSetaRegua;
End;

Function TReguaEditor.getPagFrx: Integer;
Begin
  Result := FPapSiz.recPapCur.intValFrx;
End;

Function TReguaEditor.getZebra: Boolean;
Begin
  Result := FZebra;
End;

Function TReguaEditor.getZooFix: Double;
Begin
  Result := FZooFix;
End;

Function TReguaEditor.getclrZeb: TColor;
Begin
  Result := FclrZeb;
End;

Function TReguaEditor.getexpZeb: String;
Begin
  Result := FexpZeb;
End;

Procedure TReguaEditor.setZebra(Const Value: Boolean);
Begin
  If Value <> FZebra Then
  Begin
    FZebra := Value;
  End;
End;

Procedure TReguaEditor.setZooFix(Const Value: Double);
Begin
  If Value <> FZooFix Then
  Begin
    FZooFix := Value;
  End;
End;

Procedure TReguaEditor.setClrZeb(Const Value: TColor);
Begin
  If Value <> FClrZeb Then
  Begin
    FClrZeb := Value;
  End;
End;

Procedure TReguaEditor.setExpZeb(Const Value: String);
Begin
  If Value <> FExpZeb Then
  Begin
    FExpZeb := Value;
  End;
End;

Function TReguaEditor.getMolDad: Integer;
Begin
  Result := FMolDad;
End;

Procedure TReguaEditor.setMolDad(Const Value: Integer);
Begin
  If Value <> FMolDad Then
  Begin
    FMolDad := Value;
  End;
End;

Procedure TReguaEditor.setPagFrx(Const Value: Integer);
  Var
    intContador: Integer;
Begin
  With FPapSiz Do
  If Value <> recPapCur.intValFrx Then
  Begin
    For intContador := Low(FArrPpz) To High(FArrPpz) Do
      If Value = FArrPpz[intContador].intValFrx Then
      Begin
        FPapCur := intContador;
        Break;
      End;
  End;
End;

Function TReguaEditor.getMarPix: TDadosMargem;
Begin
  Result := FMarPix;
  With Result Do
  Begin
    fltMarSup := fCmColunaToPixel(FMargem.fltMarSup, True, FTipImp);
    fltMarInf := fCmColunaToPixel(FMargem.fltMarInf, True, FTipImp);
    fltMarEsq := fCmColunaToPixel(FMargem.fltMarEsq, False, FTipImp);
    fltMarDir := fCmColunaToPixel(FMargem.fltMarDir, False, FTipImp);
  End;
End;

Procedure TReguaEditor.setLarEPx(Const Value: Double);
Begin
  With FdadEti Do
  If fCmColunaToPixel(fltLarEti, False, FTipImp) <> Value Then
  Begin
    fltLarEti := fPixelToCmColuna(Value, False, FTipImp);
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setAltEPx(Const Value: Double);
Begin
  With FdadEti Do
  If fCmColunaToPixel(fltAltEti, True, FTipImp) <> Value Then
  Begin
    fltAltEti := fPixelToCmColuna(Value, True, FTipImp);
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setGpHrPx(Const Value: Double);
Begin
  With FdadEti Do
  If fCmColunaToPixel(fltGpHrEt, False, FTipImp) <> Value Then
  Begin
    fltGpHrEt := fPixelToCmColuna(Value, False, FTipImp);
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setGpVrPx(Const Value: Double);
Begin
  With FdadEti Do
  If FGpVrPx <> Value Then
  Begin
    FGpVrPx := Value;
    fltGpVrEt := fPixelToCmColuna(Value, True, FTipImp);
    pSetaRegua;
  End;
End;

Function TReguaEditor.getAltEPx: Double;
Begin
  With FdadEti Do
  Result := fCmColunaToPixel(fltAltEti, True, FTipImp);
End;

Function TReguaEditor.getLarEPx: Double;
Begin
  With FdadEti Do
  Result := fCmColunaToPixel(fltLarEti, False, FTipImp);
End;

Function TReguaEditor.getGpHrPx: Double;
Begin
  With FdadEti Do
  Result := fCmColunaToPixel(fltGpHrEt, False, FTipImp);
End;

Function TReguaEditor.getIniHor: Double;
Begin
  Result := fPixelToCmColuna(FIniHor, False, FTipImp);
End;

Function TReguaEditor.getIniVer: Double;
Begin
  Result := fPixelToCmColuna(FIniVer, True, FTipImp);
End;

Function TReguaEditor.getIniHoV: Integer;
Begin
  If FTipImp = 'M' Then
    Result := FIniHor (*+ Trunc(fCmColunaToPixel(1, False, FTipImp))*)
  Else
    Result := FIniHor;
End;

Function TReguaEditor.getIniVeV: Integer;
Begin
  If FTipImp = 'M' Then
    Result := FIniVer + Trunc(fCmColunaToPixel(1, True, FTipImp))
  Else
    Result := FIniVer;
End;

Procedure TReguaEditor.pSetaMolduraSuperior;
Begin
  If FMolSup And (FMolLar > 0) Then
  Begin
    If Not Assigned(FShaSup) Then
    Begin
      FShaSup := TShape.Create(FEImage);
      FShaSup.Parent := FScrBox;
      FShaSup.Brush.Color := clBlack;
    End;

    FShaSup.Height := FMolLar;
    FShaSup.Top    := FIniVer - FScrBox.VertScrollBar.Position;
    FShaSup.Left   := FIniHor - FScrBox.HorzScrollBar.Position;
    FShaSup.Width  := Trunc(FPapSiz.recPapPix.fltLargur) -
                       Trunc(dadMarPix.fltMarEsq) -
                       Trunc(dadMarPix.fltMarDir);
  End

  Else If Assigned(FShaSup) Then
         FreeAndNil(FShaSup);
End;

Procedure TReguaEditor.setMolSup(Const Value: Boolean);
Begin
  If Value <> FMolSup Then
  Begin
    FMolSup := Value;
    pSetaMolduraSuperior;
  End;
End;

Procedure TReguaEditor.pSetaMolduraInferior;
Begin
  If FMolInf And (FMolLar > 0) Then
  Begin
    If Not Assigned(FShaInf) Then
    Begin
      FShaInf := TShape.Create(FEImage);
      FShaInf.Parent := FScrBox;
      FShaInf.Brush.Color := clBlack;
    End;

    FShaInf.Height := FMolLar;

    FShaInf.Top    := MARGEM_CINZA
                       + Trunc(FPapSiz.recPapPix.fltAltura)
                       - Trunc(dadMarPix.fltMarInf)
                       - FScrBox.VertScrollBar.Position
                       - FShaInf.Height;

    FShaInf.Left   := FIniHor - FScrBox.HorzScrollBar.Position;

    FShaInf.Width  := Trunc(FPapSiz.recPapPix.fltLargur) -
                      Trunc(dadMarPix.fltMarEsq) -
                      Trunc(dadMarPix.fltMarDir);
  End

  Else If Assigned(FShaInf) Then
        FreeAndNil(FShaInf);
End;

Procedure TReguaEditor.setMolInf(Const Value: Boolean);
Begin
  If Value <> FMolInf Then
  Begin
    FMolInf := Value;
    pSetaMolduraInferior;
  End;
End;

Procedure TReguaEditor.pSetaMolduraDireita;
Begin
  If FMolDir And (FMolLar > 0) Then
  Begin
    If Not Assigned(FShaDir) Then
    Begin
      FShaDir := TShape.Create(FEImage);
      FShaDir.Parent := FScrBox;
      FShaDir.Brush.Color := clBlack;
    End;

    FShaDir.Width  := FMolLar;
    FShaDir.Top    := FIniVer - FScrBox.VertScrollBar.Position;
    FShaDir.Left   := MARGEM_CINZA + Trunc(FPapSiz.recPapPix.fltLargur) -
                      Trunc(dadMarPix.fltMarDir) - FShaDir.Width;

    FShaDir.Height := Trunc(FPapSiz.recPapPix.fltAltura) -
                      Trunc(dadMarPix.fltMarSup) -
                      Trunc(dadMarPix.fltMarInf);
  End

  Else If Assigned(FShaDir) Then
         FreeAndNil(FShaDir);

End;

Procedure TReguaEditor.setMolDir(Const Value: Boolean);
Begin
  If Value <> FMolDir Then
  Begin
    FMolDir := Value;
    pSetaMolduraDireita
  End;
End;

Procedure TReguaEditor.pSetaMolduraEsquerda;
Begin
  If FMolEsq And (FMolLar > 0) Then
  Begin
    If Not Assigned(FShaEsq) Then
    Begin
      FShaEsq := TShape.Create(FEImage);
      FShaEsq.Parent := FScrBox;
      FShaEsq.Brush.Color := clBlack;
    End;

    FShaEsq.Width  := FMolLar;
    FShaEsq.Top    := FIniVer - FScrBox.VertScrollBar.Position;
    FShaEsq.Left   := FIniHor;

    FShaEsq.Height := Trunc(FPapSiz.recPapPix.fltAltura) -
                      Trunc(dadMarPix.fltMarSup) -
                      Trunc(dadMarPix.fltMarInf);
  End

  Else If Assigned(FShaEsq) Then
         FreeAndNil(FShaEsq);
End;

Procedure TReguaEditor.setMolEsq(Const Value: Boolean);
Begin
  If Value <> FMolEsq Then
  Begin
    FMolEsq := Value;
    pSetaMolduraEsquerda;
  End;
End;

Procedure TReguaEditor.setMolLar(Const Value: Integer);
Begin
  If Value <> FMolLar Then
  Begin
    FMolLar := Value;

    pSetaMolduraSuperior;
    pSetaMolduraInferior;
    pSetaMolduraDireita;
    pSetaMolduraEsquerda;
  End;
End;

Procedure TReguaEditor.setHeaAlt(Const Value: Double);
Begin
  If Value <> FHeaAlt Then
  Begin
    FHeaAlt := Value;
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setHeaDataAlt(Const Value: Double);
Begin
  If Value <> FHeaDataAlt Then
  Begin
    FHeaDataAlt := Value;
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setFooAlt(Const Value: Double);
Begin
  If Value <> FFooAlt Then
  Begin
    FFooAlt := Value;
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setFooDataAlt(Const Value: Double);
Begin
  If Value <> FFooDataAlt Then
  Begin
    FFooDataAlt := Value;
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setHeader(Const Value: Boolean);
Begin
  If Value <> FHeader Then
  Begin
    FHeader := Value;
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setHeaderData(Const Value: Boolean);
Begin
  If Value <> FHeaderData Then
  Begin
    FHeaderData := Value;
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setHeaderDataMol(Const Value: Integer);
Begin
  If Value <> FHeaderDataMol Then
  Begin
    FHeaderDataMol := Value;
  End;
End;

Procedure TReguaEditor.setHeaderDataCor(Const Value: TColor);
Begin
  If Value <> FHeaderDataCor Then
  Begin
    FHeaderDataCor := Value;
  End;
End;

Procedure TReguaEditor.setFooterDataMol(Const Value: Integer);
Begin
  If Value <> FFooterDataMol Then
  Begin
    FFooterDataMol := Value;
  End;
End;

Procedure TReguaEditor.setFooterDataCor(Const Value: TColor);
Begin
  If Value <> FFooterDataCor Then
  Begin
    FFooterDataCor := Value;
  End;
End;

Procedure TReguaEditor.setFooter(Const Value: Boolean);
Begin
  If Value <> FFooter Then
  Begin
    FFooter := Value;
    
    If Not FFooter Then
      fltFooAlt := 0;
      
    pSetaRegua;
  End;
End;

Procedure TReguaEditor.setImpUlt(Const Value: Boolean);
Begin
  If Value <> FImpUlt Then
  Begin
    FImpUlt := Value;
  End;

  If Not FImpUlt Then
    FFooBra := False;
End;

Procedure TReguaEditor.setFooBra(Const Value: Boolean);
Begin
  If Value <> FFooBra Then
  Begin
    FFooBra := Value;
  End;
End;

Procedure TReguaEditor.setFooterData(Const Value: Boolean);
Begin
  If Value <> FFooterData Then
  Begin
    FFooterData := Value;

    If Not FFooterData Then
      FFooDataAlt := 0;

    pSetaRegua;
  End;
End;

procedure TReguaEditor.pPedeFonteMatricial(Var fonFonte: TFonteMatricial);
Begin
  pCriarFormularios(TfrmPedeFonteLinhaMatricial, frmPedeFonteLinhaMatricial);

  With frmPedeFonteLinhaMatricial, fonFonte Do
  Begin
    Case colFonte Of
      col40 : cxvFonteTamanho.Properties.Value := TcxComboBoxProperties(cxvFonteTamanho.Properties.EditProperties).Items[0];
      col80 : cxvFonteTamanho.Properties.Value := TcxComboBoxProperties(cxvFonteTamanho.Properties.EditProperties).Items[1];
      col96 : cxvFonteTamanho.Properties.Value := TcxComboBoxProperties(cxvFonteTamanho.Properties.EditProperties).Items[2];
      col137: cxvFonteTamanho.Properties.Value := TcxComboBoxProperties(cxvFonteTamanho.Properties.EditProperties).Items[3];
      col160: cxvFonteTamanho.Properties.Value := TcxComboBoxProperties(cxvFonteTamanho.Properties.EditProperties).Items[4];
    End;

    If ShowModal = mrOk Then
    Begin

      Case TcxComboBoxProperties(cxvFonteTamanho.Properties.EditProperties).Items.IndexOf(cxvFonteTamanho.Properties.Value) Of
        0: colFonte := col40;
        1: colFonte := col80;
        2: colFonte := col96;
        3: colFonte := col137;
        4: colFonte := col160;
      End;

    End;

  End;

  pFreeAndNil(frmPedeFonteLinhaMatricial);
End;

procedure TReguaEditor.pPedeFonteMatricialCabPag;
Begin
  pPedeFonteMatricial(FCabPagFon);
End;

procedure TReguaEditor.pPedeFonteMatricialCabDados;
Begin
  pPedeFonteMatricial(FCabDadFon);
End;

Function TReguaEditor.fGetLocalizacao(fltTopOri: Double): TTipoLocalizacao;
Begin
  Result := locPageHeader;

  If fltTopOri < fltHeaAlt + fltMrgSup Then
  Begin
    Result := locPageHeader
  End

  Else If fltTopOri <  fltHeaAlt + fltMrgSup + fltHeaDataAlt Then
  Begin
    Result := locHeaderData
  End

  Else If fltTopOri < fltHeaAlt + fltMrgSup + fltHeaDataAlt + fltAltEtq Then
  Begin
    Result := locMasterData
  End

  Else If blnFooter And (fltTopOri >= fltHeiPag - (fltFooAlt + fltMrgInf)) Then
  Begin

    If fltTopOri = fltHeiPag - (fltFooAlt + fltMrgInf) Then
      Result := locPageFooterLinha1
    Else
      Result := locPageFooter

  End

  Else If blnFooterData Then
  Begin

    If fltTopOri = fltHeiPag - (IfThen(blnFooter, fltFooAlt, 0) + fltMrgInf + fltFooDataAlt) Then
      Result := locFooterDataLinha1
    Else

    Result := locFooterData

  End

End;

Function TReguaEditor.fCampoTemFonteDaPagina(fltfrxTop: Double): Boolean;
  Var
    locPosicao: TTipoLocalizacao;
Begin
  locPosicao := fGetLocalizacao(fPixelToCmColuna(fltfrxTop, True, FTipImp));

  Result := (locPosicao = locMasterData) Or
            (blnFooterData And (locPosicao = locFooterDataLinha1)) Or
            (blnFooter And (Not blnFooterData) And (locPosicao = locPageFooterLinha1));
End;

procedure TReguaEditor.pSetaComponentMovel(objCmpMvl: Pointer);
Begin
  FCmpMvl := objCmpMvl;
End;

Function TReguaEditor.fColFontePagina: TcolMatricial;
Begin
  Result := fTextoToColMat(String(ppzPapSiz.FArrPpz[ppzPapSiz.intPapCur].strComan2));
End;

end.
