Unit untComponentMovel;

interface

Uses
  StrUtils, SysUtils, Classes, Forms, Variants, VCL.Controls,
  Winapi.Messages,
  Windows, Graphics, ExtCtrls, Contnrs, StdCtrls, untConstantes,
  frxDesgnCtrls, untReguaEditor, Uni, untTypesSistema,
  Dialogs, UniClientDataSet, frxClass, fs_iinterpreter, TypesRel,
  frxBarCod, frxBarCode, frxBarCode2D, ExtDlgs, DB, cxVGrid, Math, untFuncoesEditorFast;

Const
  BGBRANCO = clWhite;

Type
  TProcCampoToEditor = Procedure Of Object;

  TTipoCampoEditor = (camSemCampo, camNormal, camExpressao, camImagem);

  TTipoRotacao = (tpr0, tpr90, tpr270, tpr180);

  TTipoApresentacao = (aprTexto, aprCodeBar, aprQRCODE, aprImagem, aprVazio);

  TTipoAlinhamento = (tpaTopo, tpaEsquerda, tpaDireita, tpaEmBaixo);

  TLayStaticText = Class(TPanel)
  Private
    FTipImp: String;

    FRepAux: TfrxReport;
    FfrxRot: Integer;

    FTipApr: TTipoApresentacao;

    FTipDad: TFieldType;
    FCasDec: Integer;

    FBarCod: TfrxBarcodeType;
    FBarTxt: Boolean;
    FBarZoo: Double;
    FChkSum: Boolean;

    FBarCQR: TfrxBarcode2DType;

    FFilImg: String;
    FCenImg,
    FStretc: Boolean;

    FAutWid: Boolean;
    FAutHei: Boolean;

    FStaCmp: TStaticText;

    FImgCmp: TImage;
    FImgLgf: TLogFont;
    FImgFnt: TFont;

    FPanel: TPanel;

    FLeft: Double;

    FfrxTop,
    FfrxLeft,
    FfrxWidth,
    FfrxHeight: Double;

    FBColBK: TColor;
    FBColor: TColor;

    FBorTop,
    FBorLef,
    FBorRig,
    FBorBot: Boolean;
    FBorEsp: Double;

    FShaTop,
    FShaLef,
    FShaRig,
    FShaBot: TShape;

    FTipCam: TTipoCampoEditor;
    FCapCam: String;
    FCodCam: String;
    FFrxSet: String;
    FWorWra: Boolean;
    FHidZer: Boolean;
    FHAlign: TFrxHAlign;
    FEditor: TReguaEditor;

    FFonMat: TcolMatricial;

    Function getTop: Double;
    Function getLeft: Double;
    Function getWidth: Double;
    Function getHeight: Double;
    Function getTipRot: TTipoRotacao;

    Procedure SetTop(Value: Double);
    Procedure SetLeft(Value: Double);
    Procedure SetWidth(Value: Double);
    Procedure SetHeight(Value: Double);

    Procedure SetfrxTop(Value: Double);
    Procedure SetfrxLeft(Value: Double);
    Procedure SetfrxWidth(Value: Double);
    Procedure SetfrxHeight(Value: Double);
    Procedure setBColor(Value: TColor);

    Procedure SetHAlign(Value: TFrxHAlign);

    Procedure SetOriTop(Value: Integer);
    Procedure SetOriLeft(Value: Integer);
    Procedure SetOriWidth(Value: Integer);
    Procedure SetOriHeight(Value: Integer);
    Procedure setfrxRot(Value: Integer);
    Procedure setCapCam(Value: String);
    Procedure setTipRot(Value: TTipoRotacao);
    Procedure setTipApr(Value: TTipoApresentacao);
    Procedure setBarCod(Value: TfrxBarcodeType);
    Procedure setBarCQR(Value: TfrxBarcode2DType);
    Procedure setBarTxt(Value: Boolean);
    procedure setChkSum(Value: Boolean);
    Procedure setCenImg(Value: Boolean);
    Procedure setStretc(Value: Boolean);
    Procedure setFilImg(Value: String);
    Procedure setCodCam(Value: String);
    Procedure setFrxSet(Value: String);

    Procedure setBorTop(Value: Boolean);
    Procedure setBorBot(Value: Boolean);
    Procedure setBorLef(Value: Boolean);
    Procedure setBorRig(Value: Boolean);
    Procedure setBorEsp(Value: Double);

    Procedure setAutHei(Value: Boolean);
    Procedure setWorWra(Value: Boolean);
    Procedure setHidZer(Value: Boolean);

    Procedure setFonMat(Value: TcolMatricial);

    procedure pLimpaImagem;
    procedure pCriaCompAuxiliar;
    procedure pDesenhaTexto;
    procedure pDesenhaCodeBar(fonFonte: TFont = Nil);
    procedure pDesenhaQRCODE(fonFonte: TFont = Nil);
    procedure pDesenhaImagem;
    procedure pDesenhaBordas;

   Public

    constructor Create(Owner: TComponent;
                       PEditor: TReguaEditor); reintroduce;

    destructor Destroy; Override;

    procedure pRedesenha(fonFonte: TFont = Nil);

  published

    property strCapCam: String     Read FCapCam Write setCapCam;
    property strCodCam: String     Read FCodCam Write setCodCam;
    property strFrxSet: String     Read FFrxSet Write setFrxSet;
    property tcpTipCam: TTipoCampoEditor Read FTipCam Write FTipCam;
    property blnWorWra: Boolean    Read FWorWra Write setWorWra;
    property blnHidZer: Boolean    Read FHidZer Write setHidZer;
    property aliHAlign: TFrxHAlign Read FHAlign Write SetHAlign;

    property fltTop   : Double Read getTop    Write SetTop;
    property fltLeft  : Double Read getLeft   Write SetLeft;
    property fltWidth : Double Read getWidth  Write SetWidth;
    property fltHeight: Double Read getHeight Write SetHeight;

    property colBColor: TColor Read FBColor   Write setBColor;

    property fltfrxTop   : Double Read FfrxTop    Write SetfrxTop;
    property fltfrxLeft  : Double Read FfrxLeft   Write SetfrxLeft;
    property fltfrxWidth : Double Read FfrxWidth  Write SetfrxWidth;
    property fltfrxHeight: Double Read FfrxHeight Write SetfrxHeight;

    property intOriTop   : Integer Write setOriTop;
    property intOriLeft  : Integer Write setOriLeft;
    property intOriWidth : Integer Write setOriWidth;
    property intOriHeight: Integer Write setOriHeight;

    property intfrxRot: Integer           Read FfrxRot   Write setfrxRot;
    property tprTipRot: TTipoRotacao      Read getTipRot Write setTipRot;
    property tpaTipApr: TTipoApresentacao Read FTipApr   Write setTipApr;
    property bctBarCod: TfrxBarcodeType   Read FBarCod   Write setBarCod;
    property bcqBarCQR: TfrxBarcode2DType Read FBarCQR   Write setBarCQR;
    property blnBarTxt: Boolean           Read FBarTxt   Write setBarTxt;
    property fltBarZoo: Double            Read FBarZoo   Write FBarZoo;
    property blnChkSum: Boolean           Read FChkSum   Write setChkSum;

    property blnCenImg: Boolean           Read FCenImg   Write setCenImg;
    property blnStretc: Boolean           Read FStretc   Write setStretc;
    property strFilImg: String            Read FFilImg   Write setFilImg;

    property imgImgCmp: TImage            Read FImgCmp   Write FImgCmp;

    property intCasDec: Integer           Read FCasDec   Write FCasDec;
    property fdtTipDad: TFieldType        Read FTipDad   Write FTipDad;

    property blnAutWid: Boolean           Read FAutWid   Write FAutWid;
    property blnAutHei: Boolean           Read FAutHei   Write setAutHei;

    property blnBorTop: Boolean           Read FBorTop   Write setBorTop;
    property blnBorBot: Boolean           Read FBorBot   Write setBorBot;
    property blnBorLef: Boolean           Read FBorLef   Write setBorLef;
    property blnBorRig: Boolean           Read FBorRig   Write setBorRig;

    property fltBorEsp: Double            Read FBorEsp   Write setBorEsp;

    property colFonMat: TcolMatricial     Read FFonMat  Write  setFonMat;
  End;

  TArrLarguraLinha    = Array Of Double;
  TArrQuantidadeLinha = Array Of Integer;

  TComponentMovel = Class(TComponent)
  Private
    FLisSel: TObjectList;

    FLarLin: TArrLarguraLinha;
    FQtdCol: TArrQuantidadeLinha;

    FTipImp: String;
    FReport: TfrxReport;
    FExpCam: TUniQuery;
    FCodEti: TTipoEtiqueta;
    FScript: TfsScript;
    FFonte : TFontDialog;

    FLasLar,
    FLasAlt: Double;

    FNewFil: TTipoCampoEditor;
    FTabCam: TUniQuery;
    FDadCam: TcxVerticalGrid;
    FscrPag: TScrollBox;
    FEditor: TReguaEditor;
    pCampoToEditor: TProcCampoToEditor;

    oldPos: TPoint;
    FNodes: TObjectList;
    FCamObj: TObjectList;
    inReposition : boolean;
    FNodePositioning: Boolean;

    FAlinhaGrade: Boolean;

    Function CallMethod(Instance: TObject; ClassType: TClass;
      Const MethodName: String; Var Params: Variant): Variant;

    Function fAlinhamento(strAlinha: String): TFrxHAlign;

    Function fRetornaFonteLinha(intTop: Double; staCampo: TLayStaticText; Var blnTemCompLinha: Boolean): TcolMatricial;

    procedure pGetFonteCampo;
    procedure CreateNodes;
    procedure pAbreDefCampos(qryTabCam: TUniQuery);

    procedure NodeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure NodeMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure NodeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure ControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ControlDblClick(Sender: TObject);

    procedure pAddSelecao(staInfo: TLayStaticText);
    procedure pAddLista(staInfo: TLayStaticText);

    procedure pPaginaMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    Procedure pEditorToCampoFonte;

    procedure pCriaNovaExpressao(intLeft, intTop: Integer; cmpParent: TWinControl);
    procedure pCriaNovaImagem(intLeft, intTop: Integer; cmpParent: TWinControl);

    procedure SetNodesVisible(Visible: Boolean);

    procedure pLiberaCampos;
    Procedure pInicializaScript;
    procedure pCriaReport;
    procedure pMouseUp(X, Y: Integer; cmpParent: TWinControl);
  Public

    FCurrentNodeControl: TWinControl;

    constructor Create(Owner: TComponent;
                       prcCampoToEditor: TProcCampoToEditor;
                       PDadCam: TcxVerticalGrid;
                       PscrPag: TScrollBox;
                       PEditor: TReguaEditor;
                       PTabCam: TUniQuery;
                       tpeCodEti: TTipoEtiqueta;
                       strTipImp: String);  reintroduce;

     Destructor Destroy; Override;

     Function fRetTipoDado(strTipDad: String): TFieldType;
     Function fAvaliaExpressao(mmoExpressao: TMemo): Boolean;
     Function fTextToBarCode(strValue: String): TfrxBarcodeType;
     Function fTextToQRCode(strValue: String): TfrxBarcode2DType;

     Function fRetLarguraColuna(intLinha: Integer): Double;
     Function fQuantidadeColunas(intLinha: Integer): Integer;

     Procedure pAlteraFonteLinha(staCampo: TLayStaticText);

     Procedure pMontaLinhaHeader;
     procedure pCriaNovoCampo(cmpParent: TWinControl;
                              fltPixLef,
                              fltPixTop: Double;
                              strCaptio,
                              strCdgCmp,
                              strFrxCmp: String;
                              tpcTpoCam: TTipoCampoEditor;

                              fltBordas: Double;
                              blnSupBor,
                              blnInfBor,
                              blnEsqBor,
                              blnDirBor: Boolean;

                              fntFonte : TFont;
                              colFonte : TcolMatricial;

                              halHAlign: TFrxHAlign;
                              blnWrdWra: Boolean;
                              blnHideZeros: Boolean;

                              tpaTpoApr: TTipoApresentacao = aprTexto;
                              intRotati: Integer = 0;
                              fltPixLar: Double = 200;
                              fltPixAlt: Double = 0;
                              colCorFun: TColor = BGBRANCO;
                              blnBarTex: Boolean = False;
                              bctBarCde: TfrxBarcodeType = bcCodeEAN13;
                              bcqBarQRC: TfrxBarcode2DType = bcCodeQR;
                              fltBCZoom: Double = 1;
                              fltBCZooFix: Double = 0;
                              blnCentra: Boolean = True;
                              blnEstica: Boolean = True;
                              picImagem: TPicture = Nil;
                              intNroDec: Integer = 2;
                              fdtTipFil: TFieldType = ftString;
                              blnLarAut: Boolean = False;
                              blnAltAut: Boolean = False;
                              intTag   : Integer = 0;
                              blnChekSu: Boolean = False);

     procedure PositionNodes(AroundControl: TWinControl);
     procedure pApagaCampo;
     procedure pCancelaInclusao;
     procedure pSetaInclusaoCampo;
     procedure pSetaInclusaoExpressao;
     procedure pSetaInclusaoImagem;
     procedure pAlteraFonte;
     procedure pNovoLayout(blnRefresh: Boolean = True);
     procedure pAlteraExpressao;
     procedure pAlteraImagem;
     Procedure pReposicionaCamposMarSup(intVerAnt, intHorAnt: Integer);
     Procedure pReposicionaCamposMarInf(fltMarInfAnt, fltMarInfAtu: Double);
     Procedure pReposicionaCamposMarLeft(intVerAnt, intHorAnt: Integer);
     Procedure pReposicionaCamposHeader(fltAltAnt, fltAltAtu: Double; intIniVer, intIniFoo: Integer);
     Procedure pReposicionaCamposHeaderData(fltAltAnt, fltAltAtu: Double; intIniVer, intIniFoo: Integer);
     Procedure pReposicionaCamposRodape(intIniFooAnt: Integer);
     Procedure pReposicionaFooterData(intIniFooAnt: Integer; fltAltFooAnt: Double; blnFooPag: Boolean);
     procedure pReposicionaCampoMatricial(AroundControl: TWinControl; blnTamanho: Boolean);
     procedure pLimpaSelecao;
     procedure pAlinhamento(tipoAlinh: TTipoAlinhamento);
  published

    property oblCamObj :TObjectList Read FCamObj;
    
    property blnAlinhaGrade: Boolean Write FAlinhaGrade;
  End;

implementation

Uses
  untImagemBase64,
  untDigExpressao, System.UITypes, System.Types, untFuncoesSimples;

constructor TLayStaticText.Create(Owner: TComponent; PEditor: TReguaEditor);
Begin
  Inherited Create(Owner);

  FTipImp := PEditor.strTipImp;

  Visible     := False;
  FBorEsp     := -1;
  FTipApr     := aprVazio;
  AutoSize    := False;
  BevelOuter  := bvNone;
  ctl3D       := False;
  Color       := BGBRANCO;

  FPanel             := TPanel.Create(Self);
  FPanel.Parent      := Self;
  FPanel.BevelOuter  := bvNone;
  FPanel.Align       := alClient;
  FPanel.Enabled     := False;
  FPanel.ParentColor := True;
  FPanel.ParentFont  := True;
  FPanel.ctl3D       := False;

  If FTipImp = 'M' Then
  Begin
    FPanel.Font.Size          := MATRIACIAL_FONT_SIZE;
    FPanel.Font.Name          := MATRIACIAL_FONT_NAME;
    FPanel.Font.PixelsPerInch := MATRIACIAL_FONT_PPI;

    FPanel.Height    := Abs(FPanel.Font.Height);
  End;

  FfrxRot := -1;
  FImgCmp := Nil;
  FStaCmp := Nil;

  FEditor := PEditor;

  Visible := True;
End;

Procedure TLayStaticText.SetHAlign(Value: TFrxHAlign);
Begin
  FHAlign := Value;

  Case Value Of
    TfrxHAlign.haLeft  : Self.Alignment := taLeftJustify;
    TfrxHAlign.haRight : Self.Alignment := taRightJustify;
    TfrxHAlign.haCenter: Self.Alignment := taCenter;
  End;

  pRedesenha;
End;

Procedure TLayStaticText.SetOriTop(Value: Integer);
Begin
  If Value <> Top Then
  Begin
    Top := Value;
    FfrxTop := Top - FEditor.intIniVer + FEditor.scrScroll.VertScrollBar.Position;
  End;
End;

Procedure TLayStaticText.SetOriLeft(Value: Integer);
// VALUE É O VALOR DO PONTO X EM PIXELS
Begin
  If Value <> Left Then
  Begin

    If FTipImp = 'M' Then
    Begin
      Left := Value;
      FLeft := Trunc( (Value - FEditor.intIniHor + FEditor.scrScroll.HorzScrollBar.Position) / fLarguraColuna(FEditor.fColFontePagina, FFonMat, FTipImp));
    End Else
    Begin
      Left := Value;
      FfrxLeft := Left - FEditor.intIniHor + FEditor.scrScroll.HorzScrollBar.Position;
    End;

  End;
End;

Procedure TLayStaticText.SetOriWidth(Value: Integer);
Begin
  If FTipImp = 'M' Then
    FfrxWidth := Trunc((Value / fLarguraColuna(FEditor.fColFontePagina, FFonMat, FTipImp)) * LARGURA_FONTE_MATRICIAL_PIXEL)
  Else
    FfrxWidth := Value;
End;

Procedure TLayStaticText.SetOriHeight(Value: Integer);
Begin
  FfrxHeight := Value
End;

Function TLayStaticText.getTop: Double;
Begin
  Result := fPixelToCmColuna(FfrxTop, True, FTipImp);
  If Result < - FEditor.scrScroll.VertScrollBar.Position Then
    Result := 0;

  If FTipImp = 'M' Then
  Begin
   If Result <= 0 Then
     Result := 1;
  End;
End;

Function TLayStaticText.getLeft: Double;
// VALOR DA COLUNA DO CAMPO EM COORDENADAS DO EDITOR 0 A 79 POR EXEMPLO
Begin
  If FTipImp = 'M' Then
  Begin
    Result := FLeft;
  End Else
  Begin
    Result := fPixelToCmColuna(FfrxLeft, False, FTipImp);
  End;  

  If Result < - FEditor.scrScroll.HorzScrollBar.Position Then
    Result := 0;
End;

Function TLayStaticText.getWidth: Double;
Begin
  If FTipImp = 'M' Then
    Result := Ceil(FfrxWidth / LARGURA_FONTE_MATRICIAL_PIXEL)
  Else
    Result := fPixelToCmColuna(FfrxWidth, False, FTipImp);
End;

destructor TLayStaticText.Destroy;
begin

  inherited;
end;

Function TLayStaticText.getHeight: Double;
Begin
  Result := fPixelToCmColuna(FfrxHeight, True, FTipImp);
End;

Procedure TLayStaticText.SetTop(Value: Double);
Begin
  FfrxTop := fCmColunaToPixel(Value, True, FTipImp, False);

  If FfrxTop < 0 Then
    FfrxTop := 0;

  Top := Round(FfrxTop + FEditor.intIniVer - FEditor.scrScroll.VertScrollBar.Position);

  If Top < FEditor.intIniVeV - FEditor.scrScroll.VertScrollBar.Position Then
    Top := FEditor.intIniVeV - FEditor.scrScroll.VertScrollBar.Position;
End;

Procedure TLayStaticText.SetLeft(Value: Double);
// VALUE TEM O VALOR DA COLUNA DO CAMPO EM COORDENADAS DO EDITOR 0 A 79 POR EXEMPLO
Begin
  If FTipImp = 'M' Then
  Begin
    // SOMENTE PARA POSICIONAR NO INICIO DA COLUNA
    FLeft := Value;
    Left := Round(Value * fLarguraColuna(FEditor.fColFontePagina, FFonMat, FTipImp) + FEditor.intIniHor - FEditor.scrScroll.HorzScrollBar.Position)
  End Else
  Begin

    FfrxLeft := fCmColunaToPixel(Value, False, FTipImp, False);

    If FfrxLeft < 0 Then
      FfrxLeft := 0;

    Left := Round(FfrxLeft + FEditor.intIniHor - FEditor.scrScroll.HorzScrollBar.Position);
  End;

  If Left < FEditor.intIniHoV - FEditor.scrScroll.HorzScrollBar.Position Then
    Left := FEditor.intIniHoV - FEditor.scrScroll.HorzScrollBar.Position;
End;

Procedure TLayStaticText.SetWidth(Value: Double);
Begin
  If FTipImp = 'M' Then
  Begin

    If Value <> Width Then
    Begin
      FfrxWidth := fCmColunaToPixel(Value, False, FTipImp, False);
      Width := Trunc(Value * fLarguraColuna(FEditor.fColFontePagina, FFonMat, FTipImp));
    End;

  End Else
  Begin

    If Value <> fPixelToCmColuna(FfrxWidth, False, FTipImp) Then
    Begin
      FfrxWidth := fCmColunaToPixel(Value, False, FTipImp, False);
      Width := Round(FfrxWidth);
    End;

  End;
End;

Procedure TLayStaticText.SetHeight(Value: Double);
Begin
  If Value <> fPixelToCmColuna(FfrxHeight, True, FTipImp) Then
  Begin
    FfrxHeight := fCmColunaToPixel(Value, True, FTipImp, False);

    Height := Round(FfrxHeight);
  End;
End;

Procedure TLayStaticText.SetfrxTop(Value: Double);
Begin
  FfrxTop := Value + FEditor.scrScroll.VertScrollBar.Position;

  If FfrxTop < - FEditor.scrScroll.VertScrollBar.Position Then
    FfrxTop := - FEditor.scrScroll.VertScrollBar.Position;

  Top := Round(Value + FEditor.intIniVer);

  If Top < FEditor.intIniVeV - FEditor.scrScroll.VertScrollBar.Position Then
    Top := FEditor.intIniVeV - FEditor.scrScroll.VertScrollBar.Position;
End;

Procedure TLayStaticText.SetfrxLeft(Value: Double);
Begin
  FfrxLeft := Value + FEditor.scrScroll.HorzScrollBar.Position;

  If FfrxLeft < - FEditor.scrScroll.HorzScrollBar.Position Then
    FfrxLeft := - FEditor.scrScroll.HorzScrollBar.Position;

  Left := Round(Value + FEditor.intIniHor);

  If Left < FEditor.intIniHoV - FEditor.scrScroll.HorzScrollBar.Position Then
    Left := FEditor.intIniHoV - FEditor.scrScroll.HorzScrollBar.Position;
End;

Procedure TLayStaticText.SetfrxWidth(Value: Double);
Begin
  If Value <> FfrxWidth Then
  Begin
    FfrxWidth := Value;

    If FTipImp = 'M' Then
      Width := Trunc(fPixelToCmColuna(FfrxWidth, False, FTipImp) * fLarguraColuna(FEditor.fColFontePagina, FFonMat, FTipImp))
    Else
      Width := Round(FfrxWidth);
  End;
End;

Procedure TLayStaticText.SetfrxHeight(Value: Double);
Begin
  If Value <> FfrxHeight Then
  Begin
    FfrxHeight := Value;
    Height := Round(FfrxHeight);
  End;
End;

Procedure TLayStaticText.setBColor(Value: TColor);
Begin
  If Value <> FBColor Then
  Begin
    FBColor := Value;
    pRedesenha;
  End;
End;

procedure TLayStaticText.pLimpaImagem;
  Var
    rctPagina: TRect;
Begin
  With FImgCmp Do
  Begin
    Top    := 0;
    Left   := 0;
    Width  := 1000;
    Height := 1000;

    With rctPagina Do
    Begin
      Left   := 0;
      Top    := 0;
      Bottom := 1000;
      Right  := 1000;
    End;

    Canvas.Brush.Color := clWhite;
    Canvas.FillRect(rctPagina);

  End;
End;

procedure TLayStaticText.pDesenhaBordas;
Begin
  If Assigned(FShaTop) And ((Not FBorTop) Or (FBorEsp = 0)) Then
    FreeAndNil(FShaTop);

  If Assigned(FShaLef) And ((Not FBorLef) Or (FBorEsp = 0)) Then
    FreeAndNil(FShaLef);

  If Assigned(FShaRig) And ((Not FBorRig) Or (FBorEsp = 0)) Then
    FreeAndNil(FShaRig);

  If Assigned(FShaBot) And ((Not FBorBot) Or (FBorEsp = 0)) Then
    FreeAndNil(FShaBot);

  If FBorEsp > 0 Then
  Begin
  
    If FBorTop Then
    Begin
      If Not Assigned(FShaTop) Then
      Begin
        FShaTop := TShape.Create(FPanel);
        FShaTop.Parent := FPanel;
        FShaTop.Align  := alTop;
        FShaTop.Brush.Color := clBlack;
      End;
      FShaTop.Height := Trunc(FBorEsp);
    End;

    If FBorBot Then
    Begin
      If Not Assigned(FShaBot) Then
      Begin
        FShaBot := TShape.Create(FPanel);
        FShaBot.Parent := FPanel;
        FShaBot.Align  := alBottom;
        FShaBot.Brush.Color := clBlack;
      End;
      FShaBot.Height := Trunc(FBorEsp);
    End;

    If FBorLef Then
    Begin
      If Not Assigned(FShaLef) Then
      Begin
        FShaLef := TShape.Create(FPanel);
        FShaLef.Parent := FPanel;
        FShaLef.Align  := alLeft;
        FShaLef.Brush.Color := clBlack;
      End;
      FShaLef.Width := Trunc(FBorEsp);
    End;

    If FBorRig Then
    Begin
      If Not Assigned(FShaRig) Then
      Begin
        FShaRig := TShape.Create(FPanel);
        FShaRig.Parent := FPanel;
        FShaRig.Align  := alRight;
        FShaRig.Brush.Color := clBlack;
      End;
      FShaRig.Width := Trunc(FBorEsp);
    End;
  End;
End;

procedure TLayStaticText.pDesenhaTexto;
  Var
    rctPagina: TRect;
Begin
  pDesenhaBordas;

  If FfrxRot < 0 Then
  Begin
    Exit;
  End;

  If (FfrxRot = 0) Or (FfrxRot = 180) Then
  Begin
    FStaCmp.Alignment := Self.Alignment;
    FStaCmp.Color     := FBColor;

    If FTipImp = 'M' Then
      FStaCmp.Font.Style := Self.Font.Style;

    Exit;
  End;

  With rctPagina Do
  Begin
    Left   := 0;
    Top    := 0;
    Bottom := 1000;
    Right  := 1000;
  End;

  FImgFnt.Assign(Self.Font);
  GetObject(FImgFnt.Handle, sizeof(FImgLgf), @FImgLgf);

  Case FfrxRot Of
    90 : FImgLgf.lfEscapement :=  900;
    270: FImgLgf.lfEscapement := -900;
  End;

  FImgFnt.Handle := CreateFontIndirect(FImgLgf);

  With FImgCmp.Canvas Do
  Begin
    Brush.Color := FBColor;
    FillRect(rctPagina);
    Font.Assign(FImgFnt);

    Case FfrxRot Of
      270 : Case FHAlign Of
             TfrxHAlign.haLeft  : TextOut(Width, 0, FCapCam);
             TfrxHAlign.haRight : TextOut(Width, Height - TextWidth(FCapCam), FCapCam);
             TfrxHAlign.haCenter: TextOut(Width, (Height - TextWidth(FCapCam)) Div 2, FCapCam);
           End;
      90 : Case FHAlign Of
             TfrxHAlign.haLeft  : TextOut(0, Height, FCapCam);
             TfrxHAlign.haRight : TextOut(0, TextWidth(FCapCam), FCapCam);
             TfrxHAlign.haCenter: TextOut(0, Height - (Height - TextWidth(FCapCam)) Div 2, FCapCam);
           End;
    End;
  End;
End;

procedure TLayStaticText.pDesenhaCodeBar(fonFonte: TFont = Nil);
  Var
    bcvCodBar: TfrxbarCodeView;
    rctRect: TRect;
Begin
  bcvCodBar := TfrxbarCodeView(FRepAux.FindObject('barcode'));

  If Assigned(bcvCodBar) Then
  With bcvCodBar.BarCode Do
  Begin
    bcvCodBar.BarCode.Color := FBColor;

    If Assigned(fonFonte) Then
    Begin
      bcvCodBar.Font.Assign(fonFonte);
      bcvCodBar.BarCode.Font.Assign(fonFonte);
    End;

    Angle:= FfrxRot;
    Text := '12345678';
    Typ  := FBarCod;

    If FEditor.dblZooFix = 0 Then
    Begin
      If (bcvCodBar.Rotation = 270) Or (bcvCodBar.Rotation = 90) Then
        bcvCodBar.Zoom := Height / fZoomBarCode(FBarCod, Height)
      Else
        bcvCodBar.Zoom := Width / fZoomBarCode(FBarCod, Width);
    End
    Else
      bcvCodBar.Zoom := FEditor.dblZooFix;

    rctRect := FImgCmp.BoundsRect;

    DrawBarcode(FImgCmp.Canvas, rctRect, FBarTxt, 0, 0);
  End;
End;

procedure TLayStaticText.pDesenhaQRCODE(fonFonte: TFont = Nil);
  Var
    bcvCodBar: TfrxbarCode2DView;
    rctRect: TRect;
Begin
  bcvCodBar := TfrxbarCode2DView(FRepAux.FindObject('barcode2D'));

  If Assigned(bcvCodBar) Then
  Begin

    If Assigned(fonFonte) Then
    Begin
      bcvCodBar.Font.Assign(fonFonte);
    End;

    bcvCodBar.BarType := FBarCQR;

    bcvCodBar.Text := '12345678';

    bcvCodBar.Zoom := fPixelToCmColuna(FImgCmp.Width, False, FTipImp, False)  / 2.22;

    rctRect := FImgCmp.BoundsRect;

    bcvCodBar.Draw(FImgCmp.Canvas, rctRect.Left, rctRect.Top,  0, 0);
  End;
End;


Procedure TLayStaticText.setCenImg(Value: Boolean);
Begin
  If Value <> FCenImg Then
  Begin
    FCenImg := Value;
    If Assigned(FImgCmp) Then
      FImgCmp.Center := Value;
  End;
End;

procedure TLayStaticText.setChkSum(Value: Boolean);
begin
  If Value <> FChkSum Then
    FChkSum := Value;

end;

Procedure TLayStaticText.setStretc(Value: Boolean);
Begin
  If Value <> FStretc Then
  Begin
    FStretc := Value;
    If Assigned(FImgCmp) Then
      FImgCmp.Stretch := Value;
  End;
End;

Procedure TLayStaticText.setFilImg(Value: String);
Begin
  If (Not fEmptyStr(Value)) And (Value <> FFilImg) Then
  Begin
    FFilImg := Value;
    FImgCmp.Picture.LoadFromFile(FFilImg);
  End;
End;

procedure TLayStaticText.pDesenhaImagem;
Var
  strImg: String;
  objPicture : TPicture;
Begin
  If FImgCmp.Picture.Bitmap.Empty And FileExists(FCodCam) Then
  Begin
    strImg := fBase64FromFile(FCodCam);

    If (Length(strImg) > 0) And (Length(strImg) > fCfgSis('TAMIMG', varDouble) * 1024) Then
    Begin
      If FEditor.blnNovaImagem Then
        pMensagemOk('O tamanho da imagem ultrapassa o limite informado em CFG_TAMIMG, portanto a imagem será reduzida.');

      Try
        objPicture := TPicture.Create;

        If fOtimizaImagem(strImg) Then
        Begin
          pImagemFromBase64(strImg, objPicture);
          FImgCmp.Picture.Assign(objPicture);
        End Else
        Begin
          pMensagemOk('Imagem não pode ser reduzida, será mantido o tamanho original!');

          FImgCmp.Picture.LoadFromFile(FCodCam);
        End;

      Finally
        FreeAndNil(objPicture)
      End;
    End

    Else FImgCmp.Picture.LoadFromFile(FCodCam);
  End;
End;

procedure TLayStaticText.pRedesenha(fonFonte: TFont = Nil);
Begin
  Case FTipApr Of
    aprTexto  : pDesenhaTexto;
    aprCodeBar: pDesenhaCodeBar(fonFonte);
    aprQRCODE : pDesenhaQRCODE(fonFonte);
    aprImagem : pDesenhaImagem;
  End;
End;                            

procedure TLayStaticText.pCriaCompAuxiliar;
Begin
  If (FfrxRot In [0, 180]) And (FTipApr = aprTexto) Then
  Begin
    If Assigned(FImgCmp) Then
    Begin
      FreeAndNil(FImgCmp);
      FreeAndNil(FImgFnt);
    End;

    FStaCmp            := TStaticText.Create(Self);
    FStaCmp.Transparent:= False;
    FStaCmp.Parent     := FPanel;
    FStaCmp.Align      := alClient;
    FStaCmp.Caption    := FCapCam;
    FStaCmp.Alignment  := Self.Alignment;
    FStaCmp.ParentFont := True;
    FStaCmp.BevelOuter := bvNone;
    FStaCmp.BevelInner := bvNone;
    FStaCmp.Color      := FBColor;
  End Else
  Begin
    If Assigned(FStaCmp) Then
      FreeAndNil(FStaCmp);

    If Assigned(FImgCmp) Then
      FreeAndNil(FImgCmp);

    If Assigned(FImgFnt) Then
      FreeAndNil(FImgFnt);

    FImgCmp := TImage.Create(Self);
    FImgCmp.Parent:= FPanel;

    Case FTipApr Of
      aprTexto,
      aprCodeBar: pLimpaImagem;
    End;

    FImgCmp.Align := alClient;

    FImgFnt := TFont.Create;

  End;

  pRedesenha;
End;

Procedure TLayStaticText.setCapCam(Value: String);
Begin
  If Value <> FCapCam Then
  Begin
    FCapCam := Value;

    If Assigned(FStaCmp) Then
      FStaCmp.Caption := FCapCam

    Else If Assigned(FImgCmp) Then
      pRedesenha;

  End;
End;

Procedure TLayStaticText.setfrxRot(Value: Integer);
Begin
  If Value <> FfrxRot Then
  Begin
    FfrxRot := Value;
    pCriaCompAuxiliar;
  End;
End;

Function TLayStaticText.getTipRot: TTipoRotacao;
Begin
  Case FfrxRot Of
     90: Result := tpr90;
    180: Result := tpr180;
    270: Result := tpr270;
    Else Result := tpr0;
  End;
End;

Procedure TLayStaticText.setTipRot(Value: TTipoRotacao);
Begin
  Case Value Of
    tpr90  : setfrxRot(90);
    tpr270 : setfrxRot(270);
    tpr180 : setfrxRot(180);
    Else     setfrxRot(0);
  End;
End;

Procedure TLayStaticText.setTipApr(Value: TTipoApresentacao);
Begin
  If Value <> FTipApr Then
  Begin
    FTipApr := Value;
    pCriaCompAuxiliar;
  End;
End;

Procedure TLayStaticText.setBarCod(Value: TfrxBarcodeType);
Begin
  If Value <> FBarCod Then
  Begin
    FBarCod := Value;
    pRedesenha;
  End;
End;

Procedure TLayStaticText.setBarCQR(Value: TfrxBarcode2DType);
Begin
  If Value <> FBarCQR Then
  Begin
    FBarCQR := Value;
    pRedesenha;
  End;
End;


Procedure TLayStaticText.setBarTxt(Value: Boolean);
Begin
  If Value <> FBarTxt Then
  Begin
    FBarTxt := Value;
    pRedesenha;
  End;
End;

Procedure TLayStaticText.setAutHei(Value: Boolean);
Begin
  If Value <> FAutHei Then
    FAutHei := Value;

  If FAutHei Then
    FWorWra := True;
End;

Procedure TLayStaticText.setWorWra(Value: Boolean);
Begin
  If Value <> FWorWra Then
    FWorWra := Value;

  If Not FWorWra Then
    FAutHei := False;
End;

Procedure TLayStaticText.setHidZer(Value: Boolean);
Begin
  If Value <> FHidZer Then
    FHidZer := Value;
End;

Procedure TLayStaticText.setCodCam(Value: String);
Begin
  If Value <> FCodCam Then
    FCodCam := Value;
End;

Procedure TLayStaticText.setFrxSet(Value: String);
Begin
  If Value <> FFrxSet Then
    FFrxSet := Value;
End;

Procedure TLayStaticText.setBorTop(Value: Boolean);
Begin
  If Value <> FBorTop Then
  Begin
    FBorTop := Value;
    pRedesenha;
  End;
End;

Procedure TLayStaticText.setBorBot(Value: Boolean);
Begin
  If Value <> FBorBot Then
  Begin
    FBorBot := Value;
    pRedesenha;
  End;
End;

Procedure TLayStaticText.setBorLef(Value: Boolean);
Begin
  If Value <> FBorLef Then
  Begin
    FBorLef := Value;
    pRedesenha;
  End;
End;

Procedure TLayStaticText.setBorRig(Value: Boolean);
Begin
  If Value <> FBorRig Then
  Begin
    FBorRig := Value;
    pRedesenha;
  End;
End;

Procedure TLayStaticText.setBorEsp(Value: Double);
Begin
  If Value <> FBorEsp Then
  Begin
    FBorEsp := Value;
    pRedesenha;
  End;
End;

Procedure TLayStaticText.setFonMat(Value: TcolMatricial);
Begin
  If Value <> FFonMat Then
  Begin
    FFonMat := Value;
  End;
End;

(****************************************************************************)
(* DEFINICAO                                                                *)
(****************************************************************************)
constructor TComponentMovel.Create(Owner: TComponent;
                                   prcCampoToEditor: TProcCampoToEditor;
                                   PDadCam: TcxVerticalGrid;
                                   PscrPag: TScrollBox;
                                   PEditor: TReguaEditor;
                                   PTabCam: TUniQuery;
                                   tpeCodEti: TTipoEtiqueta;
                                   strTipImp: String);
begin
  Inherited Create(Nil); //Owner

  pCriaReport;

  FLisSel := TObjectList.Create(False);

  FTipImp := strTipImp;
  FCodEti := tpeCodEti;
  FExpCam := fCriaQuery(Self);
  pAbreDefCampos(FExpCam);

  FLasLar := 100;

  FFonte  := TFontDialog.Create(Self);

  If FTipImp = 'J'  Then
  Begin
    FFonte.Font.Name := 'Arial';
    FFonte.Font.Size := 10;
    FLasAlt := MEIOCMPIXEL;
  End Else
  Begin
    FFonte.Font.Size := MATRIACIAL_FONT_SIZE;
    FFonte.Font.Name := MATRIACIAL_FONT_NAME;
    FFonte.Font.PixelsPerInch := MATRIACIAL_FONT_PPI;

    FLasAlt := Abs(FFonte.Font.Height);
  End;

  FTabCam := PTabCam;
  FDadCam := PDadCam;
  FscrPag := PscrPag;
  FEditor := PEditor;
  pCampoToEditor := prcCampoToEditor;
  FNewFil := camSemCampo;

  FCurrentNodeControl := Nil;
  FNodes := TObjectList.Create(False);
  CreateNodes;

  FCamObj := TObjectList.Create(False);

  FEditor.imgPagina.OnMouseUp := pPaginaMouseUp;

  FScript := TfsScript.Create(Self);
  FScript.Parent := fsGlobalUnit;
end;

Procedure TComponentMovel.pMontaLinhaHeader;
  Var
    fltLarPag,
    fltLarMin: Double;

    intLinha,
    intIndice: Integer;
    layCmpMvl: TLayStaticText;
Begin
  If FTipImp = 'J' Then
    Exit;

  With FEditor.ppzPapSiz Do
  Begin
    SetLength(FLarLin, Trunc(FArrPpz[intPapCur].fltAltura));
    SetLength(FQtdCol, Trunc(FArrPpz[intPapCur].fltAltura));
  End;

  fltLarMin := fCmColunaToPixel(1, False, FTipImp, False);

  For intIndice := Low(FLarLin) To High(FLarLin) Do
  Begin
    FLarLin[intIndice] := fltLarMin;

    Case FEditor.fColFontePagina Of
      col40 : FQtdCol[intIndice] := 39;
      col80 : FQtdCol[intIndice] := 79;
      col96 : FQtdCol[intIndice] := 95;
      col137: FQtdCol[intIndice] := 136;
      Else    FQtdCol[intIndice] := 159;
    End;

  End;

  Case FEditor.fColFontePagina Of
    col40 : fltLarPag := 39  * fltLarMin;
    col80 : fltLarPag := 79  * fltLarMin;
    col96 : fltLarPag := 95  * fltLarMin;
    col137: fltLarPag := 136 * fltLarMin;
    Else    fltLarPag := 159 * fltLarMin;
  End;

  For intIndice := 0 To FCamObj.Count - 1 Do
  Begin
    layCmpMvl := TLayStaticText(FCamObj[intIndice]);

    intLinha := Trunc(fPixelToCmColuna(layCmpMvl.fltfrxTop, True, FTipImp));
    If intLinha = 0 Then
      intLinha := 1;

  //  If FEditor.fGetLocalizacao(intLinha) = locPageHeader Then
    Begin

      If intLinha <= High(FLarLin) Then
        Case layCmpMvl.colFonMat Of
          col40 : Begin
                    If fltLarMin < fltLarPag / 39 Then
                      FLarLin[intLinha] := fltLarPag / 39;

                    FQtdCol[intLinha] := 39;
                  End;

          col80 : Begin
                    If fltLarMin < fltLarPag / 79 Then
                      FLarLin[intLinha] := fltLarPag / 79;

                    FQtdCol[intLinha] := 79;
                  End;

          col96 : Begin
                    If fltLarMin < fltLarPag / 95 Then
                      FLarLin[intLinha] := fltLarPag / 95;

                    FQtdCol[intLinha] := 95;
                  End;

          col137: Begin
                    If fltLarMin < fltLarPag / 136 Then
                      FLarLin[intLinha] := fltLarPag / 136;

                    FQtdCol[intLinha] := 137;
                  End;

          col160: Begin
                    If fltLarMin < fltLarPag / 159 Then
                      FLarLin[intLinha] := fltLarPag / 159;

                    FQtdCol[intLinha] := 159;
                  End;
        End;

    End;

  End;

End;

Function TComponentMovel.fRetLarguraColuna(intLinha: Integer): Double;
Begin
  If intLinha <= High(FLarLin) Then
    Result := FLarLin[intLinha]
  Else
    Result := fCmColunaToPixel(1, False, FTipImp, False);
End;

Function TComponentMovel.fQuantidadeColunas(intLinha: Integer): Integer;
Begin
  If intLinha <= High(FLarLin) Then
    Result := FQtdCol[intLinha]
  Else
    Result := 0;
End;

procedure TComponentMovel.pCriaReport;
  Var
    bcvCodBar: TfrxbarCodeView;
    bcvCodBar2d: TfrxbarCode2dView;
Begin
  FReport          := TfrxReport.Create(Self);

  bcvCodBar        := TfrxbarCodeView.Create(FReport);
  bcvCodBar.Parent := FReport;
  bcvCodBar.Name   := 'barcode';

  bcvCodBar2d          := TfrxBarcode2DView.Create(FReport);
  bcvCodBar2d.Parent   := FReport;
  bcvCodBar2d.Name     := 'barcode2D';
  bcvCodBar2d.BarType  := bcCodeQR;
  bcvCodBar2d.ShowText := False;
End;

procedure TComponentMovel.SetNodesVisible(Visible: Boolean);
var
  Node: Integer;
begin
  for Node := 0 to 7 do
    TWinControl(FNodes.Items[Node]).Visible := Visible;
  FDadCam.Visible := Visible;
end;

procedure TComponentMovel.pReposicionaCampoMatricial(AroundControl: TWinControl; blnTamanho: Boolean);
  Var
    colFontAnt: TcolMatricial;
    fltTopo: Double;
    staCampo: TLayStaticText;
    blnTemCompLinha: Boolean;
Begin
  If FTipImp = 'M' Then
  Begin
    staCampo := (AroundControl As TLayStaticText);

    fltTopo  := staCampo.Top;

    staCampo.fltTop    := Trunc(staCampo.fltTop);

    If fltTopo <> staCampo.Top Then
    Begin
      colFontAnt := staCampo.colFonMat;
      staCampo.colFonMat := fRetornaFonteLinha(staCampo.Top, staCampo, blnTemCompLinha);

      If colFontAnt <> staCampo.colFonMat Then
        FEditor.pSetaRegua;
    End;

    staCampo.fltLeft := Trunc( (staCampo.Left + 1 - FEditor.intIniHor + FEditor.scrScroll.HorzScrollBar.Position) / fLarguraColuna(FEditor.fColFontePagina, staCampo.colFonMat, FTipImp));

    If blnTamanho Then
    Begin
      staCampo.fltWidth  := Ceil(staCampo.fltWidth);
      staCampo.fltHeight := Ceil(staCampo.fltHeight);
    End;

  End;

End;

procedure TComponentMovel.PositionNodes(AroundControl: TWinControl);
var
  Node,T,L,CT,CL,FR,FB,FT,FL: Integer;
  TopLeft: TPoint;
begin
  FCurrentNodeControl := nil;
  for Node := 0 to 7 do
  begin
    with AroundControl do
    begin
      CL := (Width div 2) + Left -2;
      CT := (Height div 2) + Top -2;
      FR := Left + Width - 2;
      FB := Top + Height - 2;
      FT := Top - 2;
      FL := Left - 2;
      case Node of
        0: begin
             T := FT;
             L := FL;
           end;
        1: begin
             T := FT;
             L := CL;
           end;
        2: begin
             T := FT;
             L := FR;
           end;
        3: begin
             T := CT;
             L := FR;
           end;
        4: begin
             T := FB;
             L := FR;
           end;
        5: begin
             T := FB;
             L := CL;
           end;
        6: begin
             T := FB;
             L := FL;
           end;
        7: begin
             T := CT;
             L := FL;
           end;
        else
          T := 0;
          L := 0;
      end;
      TopLeft := Parent.ClientToScreen(Point(L,T));
    end;

    with TPanel(FNodes[Node]) do
    begin
      TopLeft := Parent.ScreenToClient(TopLeft);
      Top := TopLeft.Y;
      Left := TopLeft.X;
    end;

  end;

  FCurrentNodeControl := AroundControl;
  SetNodesVisible(True);

  pCampoToEditor;

  FDadCam.Visible := True;
end; (*PositionNodes*)

procedure TComponentMovel.CreateNodes;
var
  Node: Integer;
  Panel: TPanel;
begin
  for Node := 0 to 7 do
  begin
    Panel := TPanel.Create(Self);
    FNodes.Add(Panel);
    with Panel do
    begin
      BevelOuter := bvNone;
      Color := clBlack;
      Name := 'Node' + IntToStr(Node);
      Width := 5;
      Height := 5;
      Parent := FscrPag;
      Visible := False;

      case Node of
        0,4: Cursor := crSizeNWSE;
        1,5: Cursor := crSizeNS;
        2,6: Cursor := crSizeNESW;
        3,7: Cursor := crSizeWE;
      end;
      OnMouseDown := NodeMouseDown;
      OnMouseMove := NodeMouseMove;
      OnMouseUp := NodeMouseUp;
    end;
  end;
end;

procedure TComponentMovel.NodeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Sender is TWinControl) then
  begin
    FNodePositioning:=True;
    SetCapture(TWinControl(Sender).Handle);
    GetCursorPos(oldPos);
  end;
end; (*NodeMouseDown*)

procedure TComponentMovel.NodeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  newPos: TPoint;
  frmPoint : TPoint;
  OldRect: TRect;
  AdjL,AdjR,AdjT,AdjB: Boolean;
begin
  if FNodePositioning then
  begin
    with TWinControl(Sender) do
    begin
      GetCursorPos(newPos);
      with FCurrentNodeControl do
      begin //resize
        frmPoint := FCurrentNodeControl.Parent.ScreenToClient(Mouse.CursorPos);
        OldRect := FCurrentNodeControl.BoundsRect;
        AdjL := False;
        AdjR := False;
        AdjT := False;
        AdjB := False;
        case FNodes.IndexOf(TWinControl(Sender)) of
          0: begin
               AdjL := True;
               AdjT := True;
             end;
          1: begin
               AdjT := True;
             end;
          2: begin
               AdjR := True;
               AdjT := True;
             end;
          3: begin
               AdjR := True;
             end;
          4: begin
               AdjR := True;
               AdjB := True;
             end;
          5: begin
               AdjB := True;
             end;
          6: begin
               AdjL := True;
               AdjB := True;
             end;
          7: begin
               AdjL := True;
             end;
        end;

        if AdjL then
          OldRect.Left := frmPoint.X;
        if AdjR then
          OldRect.Right := frmPoint.X;
        if AdjT then
          OldRect.Top := frmPoint.Y;
        if AdjB then
          OldRect.Bottom := frmPoint.Y;

        With TLayStaticText(FCurrentNodeControl) do
        Begin
          intOriTop    := OldRect.Top;
          intOriLeft   := OldRect.Left;
        End;

        SetBounds(OldRect.Left,
                  OldRect.Top,
                  OldRect.Right - OldRect.Left,
                  OldRect.Bottom - OldRect.Top);

        With TLayStaticText(FCurrentNodeControl) do
        Begin
          intOriWidth  := Width;
          intOriHeight := Height;
        End;

      end;

      Left := Left - oldPos.X + newPos.X;
      Top := Top - oldPos.Y + newPos.Y;

      oldPos := newPos;
    end;

    TLayStaticText(FCurrentNodeControl).pRedesenha;
        
    PositionNodes(FCurrentNodeControl);
  end;
end; (*NodeMouseMove*)

procedure TComponentMovel.NodeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If FNodePositioning then
  begin
    Screen.Cursor := crDefault;
    ReleaseCapture;
    FNodePositioning := False;
  end;

  pReposicionaCampoMatricial(FCurrentNodeControl, True);
  PositionNodes(FCurrentNodeControl);
end; (*NodeMouseUp*)

procedure TComponentMovel.ControlMouseDown(
  Sender: TObject;
  Button: TMouseButton;
  Shift: TShiftState;
  X, Y: Integer);
begin
  If Not (ssShift In Shift) Then
  Begin

    If (Sender Is TWinControl) then
    begin
      inReposition:=True;

      FCurrentNodeControl := (Sender As TWinControl); (*****)

      SetCapture(TWinControl(Sender).Handle);
      GetCursorPos(oldPos);
    end;

  End;
end; (*ControlMouseDown*)

procedure TComponentMovel.ControlMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
 Var
   newPos: TPoint;
   SavPos: TPoint;
   intLimEsq: Integer;
   intLimDir: Integer;
   intLimInf: Integer;
   intLimSup: Integer;
   intContador: Integer;
begin

  If inReposition then
  begin
    SetNodesVisible(False);

    With TLayStaticText(Sender), FEditor do
    Begin
      SavPos.X := Left;
      SavPos.Y := Top;

      GetCursorPos(newPos);
      Screen.Cursor := crSize;

      intLimEsq := intIniHor - FscrPag.HorzScrollBar.Position;
      intLimInf := intIniVer - FscrPag.VertScrollBar.Position;

      If (Not blnHeader) And (Not blnFooter) And (Not blnHeaderData) Then
      Begin
        intLimDir := intIniHor - FEditor.scrScroll.HorzScrollBar.Position + Trunc(fltLarEPx);
        intLimSup := intIniVer - FEditor.scrScroll.VertScrollBar.Position + Trunc(fltAltEPx);
      End Else
      Begin
        intLimDir := intIniHor - FEditor.scrScroll.HorzScrollBar.Position + Trunc(ppzPapSiz.recPapPix.fltLargur);
        intLimSup := intIniVer - FEditor.scrScroll.VertScrollBar.Position + Trunc(ppzPapSiz.recPapPix.fltAltura);
      End;

      If FAlinhaGrade Then
      Begin
        If (newPos.X - intLimEsq) mod 3 <> 0 Then
          newPos.X := oldPos.X;

        If (newPos.Y - intLimSup) mod 3 <> 0 Then
          newPos.Y := oldPos.Y;
      End;

      If ((Left - oldPos.X + newPos.X) >= (intLimDir - 3)) Then
      Begin
        intOriLeft := Trunc(intLimDir - 3)
      End

      Else If (Left - oldPos.X + newPos.X < intLimEsq) Then
      Begin
        intOriLeft := intLimEsq
      End

      Else
      Begin
        intOriLeft := Left - oldPos.X + newPos.X;
      End;

      If (Top - oldPos.Y + newPos.Y < intLimInf) Then
      Begin
        intOriTop := intLimInf
      End

      Else If (Top - oldPos.Y + newPos.Y >= (intLimSup - 3)) Then
      Begin
        intOriTop := Trunc(intLimSup - 3)
      End

      Else
      Begin
        intOriTop := Top - oldPos.Y + newPos.Y;
      End;

      For intContador := 0 To FLisSel.Count - 1 Do
      Begin

        If FLisSel[intContador] <> FCurrentNodeControl Then
        Begin

          If SavPos.Y <> Top Then
            TLayStaticText(FLisSel[intContador]).intOriTop := TStaticText(FLisSel[intContador]).Top  + newPos.Y - oldPos.Y;

          If SavPos.X <> Left Then
            TLayStaticText(FLisSel[intContador]).intOriLeft := TStaticText(FLisSel[intContador]).Left + newPos.X - oldPos.X;

        End;
      End;

      oldPos := newPos;

    end; {with TLayStaticText(Sender), FEditor do}

  end;

end; (*ControlMouseMove*)

procedure TComponentMovel.pAddLista(staInfo: TLayStaticText);
Begin
  FLisSel.Add(staInfo);
  staInfo.FBColBK := staInfo.FBColor;
  staInfo.colBColor := clGray;
End;

procedure TComponentMovel.pAddSelecao(staInfo: TLayStaticText);
Begin

  If FLisSel.IndexOf(staInfo) > -1 Then
  Begin

    FLisSel.Remove(staInfo);
    staInfo.colBColor := staInfo.FBColBK;

    If (staInfo = FCurrentNodeControl) And (FLisSel.Count > 0) Then
    Begin
      SetNodesVisible(False);
      FCurrentNodeControl := TWinControl(FLisSel[0]);
      pReposicionaCampoMatricial(FCurrentNodeControl, True);
      PositionNodes(FCurrentNodeControl);
      SetNodesVisible(True);
    End;

  End Else
  Begin

    pAddLista(staInfo);

  End;

  If Assigned(FCurrentNodeControl) Then
  Begin

    If FLisSel.IndexOf(FCurrentNodeControl) <= -1 Then
    Begin

      pAddLista(FCurrentNodeControl As TLayStaticText);

    End;

  End;

End;

procedure TComponentMovel.pLimpaSelecao;
  Var
    intContador: Integer;
Begin
   For intContador := 0 To FLisSel.Count - 1 Do
     TLayStaticText(FLisSel[intContador]).colBColor := TLayStaticText(FLisSel[intContador]).FBColBK;

   FLisSel.Clear;
End;

procedure TComponentMovel.ControlMouseUp(
  Sender: TObject;
  Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If (ssShift In Shift) And (FTipImp = 'J') Then
  Begin

    If (Sender Is TLayStaticText) Then
      pAddSelecao(Sender As TLayStaticText);

  End Else
  Begin
    If FLisSel.IndexOf(Sender) <= -1 Then
      pLimpaSelecao;

    If inReposition then
    begin
      Screen.Cursor := crDefault;
      ReleaseCapture;
      inReposition := False;

      pReposicionaCampoMatricial(TWinControl(Sender), True);
      PositionNodes(TWinControl(Sender));

      pGetFonteCampo;
    end;

  End;
end; (*ControlMouseUp*)

procedure TComponentMovel.pGetFonteCampo;
Begin
  If Assigned(FCurrentNodeControl) Then
  Begin
    FLasLar := (FCurrentNodeControl As TLayStaticText).Width;
    FLasAlt := (FCurrentNodeControl As TLayStaticText).Height;
    FFonte.Font.Assign((FCurrentNodeControl As TLayStaticText).Font);
  End;
End;

procedure TComponentMovel.pCriaNovoCampo(cmpParent: TWinControl;
                                         fltPixLef,
                                         fltPixTop: Double;
                                         strCaptio,
                                         strCdgCmp,
                                         strFrxCmp: String;
                                         tpcTpoCam: TTipoCampoEditor;

                                         fltBordas: Double;
                                         blnSupBor,
                                         blnInfBor,
                                         blnEsqBor,
                                         blnDirBor: Boolean;

                                         fntFonte : TFont;

                                         colFonte : TcolMatricial;

                                         halHAlign: TFrxHAlign;
                                         blnWrdWra: Boolean;
                                         blnHideZeros: Boolean;

                                         tpaTpoApr: TTipoApresentacao = aprTexto;
                                         intRotati: Integer = 0;
                                         fltPixLar: Double = 200;
                                         fltPixAlt: Double  = 0;
                                         colCorFun: TColor  = BGBRANCO;
                                         blnBarTex: Boolean = False;
                                         bctBarCde: TfrxBarcodeType = bcCodeEAN13;
                                         bcqBarQRC: TfrxBarcode2DType = bcCodeQR;
                                         fltBCZoom: Double = 1;
                                         fltBCZooFix: Double = 0;
                                         blnCentra: Boolean = True;
                                         blnEstica: Boolean = True;
                                         picImagem: TPicture = Nil;
                                         intNroDec: Integer = 2;
                                         fdtTipFil: TFieldType = ftString;
                                         blnLarAut: Boolean = False;
                                         blnAltAut: Boolean = False;
                                         intTag   : Integer = 0;
                                         blnChekSu: Boolean = False);
  Var
    lblNovCam: TLayStaticText;
    bcvCodBar: TfrxbarCodeView;
    bcvCodBar2d: TfrxbarCode2dView;
    blnTemCompLinha: Boolean;
Begin
  lblNovCam := TLayStaticText.Create(cmpParent, FEditor);
  With lblNovCam Do
  Begin
    If FTipImp = 'M' Then
    Begin
      If fltPixTop < ALTURA_FONTE_MATRICIAL_PIXEL Then
        fltPixTop := ALTURA_FONTE_MATRICIAL_PIXEL;

      FFonMat := colFonte;
    End;

    Visible     := False;
    Parent      := cmpParent;
    FRepAux     := FReport;

    FTipDad     := fdtTipFil;

    fltfrxLeft  := fltPixLef;
    fltfrxTop   := fltPixTop;

    If FTipImp = 'M' Then
    Begin
      fltTop    := Trunc(fltTop);

      If FFonMat = colVazio Then
      Begin
        FFonMat := fRetornaFonteLinha(Top, lblNovCam, blnTemCompLinha);
      End;  

      fltfrxWidth := fltPixLar;

      If intTag > 0 Then
        fltLeft     := intTag
      Else
        fltLeft     := Trunc(fltfrxLeft / fLarguraColuna(FEditor.fColFontePagina, FFonMat, FTipImp));

      fltWidth    := Ceil(fltWidth);
      fltHeight   := Ceil(fltHeight);
    End;

    fltfrxWidth := fltPixLar;

    If fltPixAlt = 0 Then
    Begin
      If FTipImp = 'J' Then
        fltfrxHeight := MEIOCMPIXEL
      Else
        fltfrxHeight := ALTURA_FONTE_MATRICIAL_PIXEL;
    End

    Else fltfrxHeight := fltPixAlt;

    strCodCam   := strCdgCmp;
    strFrxSet   := strFrxCmp;
    tcpTipCam   := tpcTpoCam;
    aliHAlign   := halHAlign;
    blnWorWra   := blnWrdWra;
    blnHidZer   := blnHideZeros;

    blnAutWid   := blnLarAut;
    blnAutHei   := blnAltAut;

    Font.Assign(fntFonte);

    intCasDec := intNroDec;

    intfrxRot := intRotati;
    strCapCam := strCaptio;

    blnBorTop := blnSupBor;
    blnBorBot := blnInfBor;
    blnBorLef := blnEsqBor;
    blnBorRig := blnDirBor;

    fltBorEsp := fltBordas;

    Case tpaTpoApr Of
      aprCodeBar: Begin
                    blnBarTxt := blnBarTex;
                    bctBarCod := bctBarCde;
                    bcqBarCQR := bcqBarQRC;
                    fltBarZoo := fltBCZoom;
                    FEditor.dblZooFix := fltBCZooFix;
                    blnChkSum := blnChekSu;
                  End;
      aprQRCODE: Begin
                    blnBarTxt := blnBarTex;
                    bctBarCod := bctBarCde;
                    bcqBarCQR := bcqBarQRC;
                    fltBarZoo := fltBCZoom;
                    blnChkSum := blnChekSu;
                  End;
    End;

    If colCorFun = 536870911 Then
      colBColor := clWhite
    Else
      colBColor := colCorFun;

    tpaTipApr := tpaTpoApr;

    Case tpaTpoApr Of
      aprImagem: Begin
                   FImgCmp.AutoSize     := False;
                   FImgCmp.Proportional := True;
                   blnCenImg := blnCentra;
                   blnStretc := blnEstica;

                   If Assigned(picImagem) Then
                     FImgCmp.Picture.Assign(picImagem);
                 End;

      aprCodeBar:Begin
                   bcvCodBar := TfrxbarCodeView(FRepAux.FindObject('barcode'));
                   If Assigned(bcvCodBar) Then
                   Begin
                     pRedesenha(fntFonte);
                   End;
                 End;

      aprQRCODE:Begin
                  bcvCodBar2d := TfrxbarCode2dView(FRepAux.FindObject('barcode2D'));
                  If Assigned(bcvCodBar2D) Then
                  Begin
                    pRedesenha(fntFonte);
                  End;
                End;

    End;

    lblNovCam.OnMouseDown := ControlMouseDown;
    lblNovCam.OnMouseMove := ControlMouseMove;
    lblNovCam.OnMouseUp   := ControlMouseUp;
    lblNovCam.OnDblClick  := ControlDblClick;
    lblNovCam.BringToFront;

    Visible     := True;

    pReposicionaCampoMatricial(TWinControl(lblNovCam), True);
    PositionNodes(TWinControl(lblNovCam));
  End;

  FCamObj.Add(lblNovCam);
End;

procedure TComponentMovel.pCriaNovaImagem(intLeft, intTop: Integer;
                                          cmpParent: TWinControl);
  Var
    opeOpePic: TOpenPictureDialog;
Begin
  FEditor.blnNovaImagem := True;

  opeOpePic := TOpenPictureDialog.Create(Self);

  If opeOpePic.Execute Then
    pCriaNovoCampo(cmpParent,
                   intLeft,
                   intTop,
                   '',
                   opeOpePic.FileName,
                   '',
                   camImagem,
                   0,
                   False,
                   False,
                   False,
                   False,
                   FFonte.Font,
                   colVazio,
                   TfrxHAlign.haLeft,
                   True,
                   False,
                   aprImagem,
                   0,
                   100,
                   100);

  FreeAndNil(opeOpePic);

  FEditor.blnNovaImagem := False;
End;

Function TComponentMovel.fRetornaFonteLinha(intTop: Double; staCampo: TLayStaticText; Var blnTemCompLinha: Boolean): TcolMatricial;
  Var
    intIndice: Integer;
    layCmpMvl: TLayStaticText;
Begin
  blnTemCompLinha := False;

  If (staCampo.colFonMat = colVazio) Or FEditor.fCampoTemFonteDaPagina(staCampo.fltfrxTop) Then
    Result := FEditor.fColFontePagina
  Else
    Result := staCampo.colFonMat;

  For intIndice := 0 To FCamObj.Count - 1 Do
  Begin
    layCmpMvl := TLayStaticText(FCamObj[intIndice]);

    If (layCmpMvl.Top = intTop) And (staCampo <> layCmpMvl) Then
    begin
      blnTemCompLinha := True;
      Result := layCmpMvl.colFonMat;
      Break;
    End;
  End;

End;

Procedure TComponentMovel.pAlteraFonteLinha(staCampo: TLayStaticText);
  Var
    intIndice: Integer;
    layCmpMvl: TLayStaticText;
Begin

  For intIndice := 0 To FCamObj.Count - 1 Do
  Begin
    layCmpMvl := TLayStaticText(FCamObj[intIndice]);

    If (layCmpMvl.Top = staCampo.Top) Then
    Begin
      If (layCmpMvl <> staCampo) Then
        layCmpMvl.colFonMat := staCampo.colFonMat;

      layCmpMvl.Width   := Trunc(layCmpMvl.fltWidth * fLarguraColuna(FEditor.fColFontePagina, layCmpMvl.FFonMat, FTipImp));
      layCmpMvl.fltLeft := Trunc( (layCmpMvl.Left + 1 - FEditor.intIniHor + FEditor.scrScroll.HorzScrollBar.Position) / fLarguraColuna(FEditor.fColFontePagina, layCmpMvl.colFonMat, FTipImp));
    End;
  End;

End;

procedure TComponentMovel.pCriaNovaExpressao(intLeft, intTop: Integer; cmpParent: TWinControl);
Begin
  pCriarFormularios(TfrmDigExpressao, frmDigExpressao);

  frmDigExpressao.objComMov := Self;

  If frmDigExpressao.ShowModal = mrOk Then
    pCriaNovoCampo(cmpParent,
                   intLeft, intTop,
                   frmDigExpressao.mmoExpressao.Text,
                   frmDigExpressao.mmoExpressao.Text,
                   '',
                   camExpressao,
                   0,
                   False,
                   False,
                   False,
                   False,
                   FFonte.Font,
                   colVazio,
                   TfrxHAlign.haLeft,
                   False,
                   False,
                   aprTexto,
                   0,
                   200,
                   0{MEIOCMPIXEL},
                   BGBRANCO,
                   False,
                   bcCodeEAN13,
                   bcCodeQR,
                   1,
                   0,
                   True,
                   True,
                   Nil,
                   -1);

  FreeAndNil(frmDigExpressao);
End;

procedure TComponentMovel.pApagaCampo;
  Var
    intContador: Integer;
    staCampo: TStaticText;
Begin
  If (FLisSel.Count > 0) Then
  Begin

    If fPergunta('Deseja excluir todos os campos selecionados?') Then
    Begin
      SetNodesVisible(False);

      For intContador := 0 To FLisSel.Count - 1 Do
      Begin
        staCampo := TStaticText(FLisSel[intContador]);
        FCamObj.Extract(staCampo);
        FreeAndNil(staCampo);
      End;

      FLisSel.Clear;
    End;

  End

  Else If Assigned(FCurrentNodeControl) And TWinControl(FNodes.Items[0]).Visible And
          fPergunta('Deseja excluir o campo ' + TLayStaticText(FCurrentNodeControl).strCapCam + '?') Then
  Begin
    FCamObj.Extract(FCurrentNodeControl);
    FreeAndNil(FCurrentNodeControl);
    SetNodesVisible(False);
  End;
End;

Destructor TComponentMovel.Destroy;
begin
  FreeAndNil(FNodes);
  FreeAndNil(FCamObj);
  FreeAndNil(FLisSel);
  inherited;
end;

procedure TComponentMovel.pMouseUp(X, Y: Integer; cmpParent: TWinControl);
   Var
     bcdBarCod: TfrxBarcodeType;
     tpaTipApr: TTipoApresentacao;
     fltLarCmp,
     fltAltCmp: Double;
     blnBarCod: Boolean;
     TipoCampoEditor: TTipoCampoEditor;
Begin
  With FEditor Do
  Begin
    TipoCampoEditor := camNormal;
    Case FNewFil Of
      camNormal   : Begin
                      If Not fEmptyStr(FTabCam.FieldByName('CAM_CODBAR').AsString) Then
                      Begin
                        bcdBarCod := fTextToBarCode(FTabCam.FieldByName('CAM_CODBAR').AsString);
                        tpaTipApr := aprCodeBar;
                        fltLarCmp := 100;
                        fltAltCmp := 80;
                        blnBarCod := True;
                      End
                      Else If Not fEmptyStr(FTabCam.FieldByName('CAM_TIPIMG').AsString) Then
                      Begin
                        tpaTipApr := aprImagem;
                        blnBarCod := False;
                        bcdBarCod := fTextToBarCode('');
                        fltLarCmp := 100;
                        fltAltCmp := 80;
                        TipoCampoEditor := camImagem;
                      End
                      Else
                      Begin
                        tpaTipApr := aprTexto;
                        If FTipImp = 'M' Then
                        Begin
                           fltLarCmp := 100;
                           fltAltCmp := 17;
                        End Else
                        Begin
                          fltLarCmp := FLasLar;
                          fltAltCmp := FLasAlt;
                        End;

                        blnBarCod := False;
                        bcdBarCod := fTextToBarCode('');

                      End;

                      pCriaNovoCampo(cmpParent,
                                     X, Y + IfThen(strTipImp = 'M', ALTURA_FONTE_MATRICIAL_PIXEL, 0),
                                     FTabCam.FieldByName('CAM_DESCAM').AsString,
                                     FTabCam.FieldByName('CAM_CODCAM').AsString,
                                     FTabCam.FieldByName('CAM_FRXSET').AsString,
                                     TipoCampoEditor,
                                     0,
                                     False,
                                     False,
                                     False,
                                     False,
                                     FFonte.Font,
                                     colVazio,
                                     fAlinhamento(FTabCam.FieldByName('CAM_ALINHA').AsString),
                                     True,
                                     False,
                                     tpaTipApr,
                                     0,
                                     fltLarCmp,
                                     fltAltCmp,
                                     BGBRANCO,
                                     blnBarCod,
                                     bcdBarCod,
                                     bcCodeQR,
                                     1,
                                     0,
                                     True,
                                     True,
                                     Nil,
                                     2,
                                     fRetTipoDado(FTabCam.FieldByName('CAM_TIPCAM').AsString),
                                     False,
                                     False,
                                     0,
                                     FTabCam.FieldByName('CAM_CODCAM').AsString = 'BARDOC');
                    End;


      camExpressao: pCriaNovaExpressao(X, Y + IfThen(strTipImp = 'M', ALTURA_FONTE_MATRICIAL_PIXEL, 0), cmpParent);

      camImagem   : pCriaNovaImagem(X, Y, cmpParent);

    End;

    FNewFil := camSemCampo;

  End;
End;

procedure TComponentMovel.pPaginaMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  With FEditor Do
  Begin
    SetNodesVisible(False);
    pLimpaSelecao;

    If blnFooter Or blnHeader Or blnHeaderData Or
       ((X >= intIniHor - FscrPag.HorzScrollBar.Position) And
        (X < (intIniHoV - FscrPag.HorzScrollBar.Position + fltLarEPx - 3)) And
        (Y >= intIniVer - FscrPag.VertScrollBar.Position) And
        (Y < (intIniVeV - FscrPag.VertScrollBar.Position + fltAltEPx - 3))) Then
    Begin

      X := X - FEditor.intIniHoV - FscrPag.HorzScrollBar.Position;
      Y := Y - FEditor.intIniVeV - FscrPag.VertScrollBar.Position;

      pMouseUp(X, Y, FscrPag);
    End;
  End;

end;

procedure TComponentMovel.pSetaInclusaoCampo;
Begin
  FNewFil := camNormal;
End;

procedure TComponentMovel.pCancelaInclusao;
Begin
  FNewFil := camSemCampo;
End;

procedure TComponentMovel.pSetaInclusaoExpressao;
Begin
  FNewFil := camExpressao;
End;

procedure TComponentMovel.pSetaInclusaoImagem;
Begin
  FNewFil := camImagem;
End;

procedure TComponentMovel.pAlteraFonte;
Begin
  If FTipImp = 'J' Then
  Begin
    FFonte.Font.Assign((FCurrentNodeControl As TLayStaticText).Font);
    If FFonte.Execute() Then
      pEditorToCampoFonte;
  End;
End;

Procedure TComponentMovel.pEditorToCampoFonte;
Begin
  If Assigned(FCurrentNodeControl) Then
  Begin
    (FCurrentNodeControl As TLayStaticText).Font.Assign(FFonte.Font);
    (FCurrentNodeControl As TLayStaticText).pRedesenha(FFonte.Font);
  End;
End;

procedure TComponentMovel.ControlDblClick(Sender: TObject);
begin
end;

procedure TComponentMovel.pLiberaCampos;
  Var
    intIndice: Integer;
    layCmpMvl: TLayStaticText;
Begin
  For intIndice := 0 To FCamObj.Count - 1 Do
  Begin
    layCmpMvl := TLayStaticText(FCamObj[intIndice]);
    FreeAndNil(layCmpMvl);
  End;

  FCamObj.Clear;
End;

procedure TComponentMovel.pNovoLayout(blnRefresh: Boolean = True);
Begin
  pLiberaCampos;
  SetNodesVisible(False);
  FEditor.pNovaRegua(blnRefresh);
End;

procedure TComponentMovel.pAlteraImagem;
  Var
    opeOpePic: TOpenPictureDialog;
Begin
  opeOpePic := TOpenPictureDialog.Create(Self);

  If opeOpePic.Execute Then
  Begin
    TLayStaticText(FCurrentNodeControl).strFilImg := opeOpePic.FileName;
    If opeOpePic.FileName <> '' Then
    Begin
      TLayStaticText(FCurrentNodeControl).FCapCam := '';
      TLayStaticText(FCurrentNodeControl).FCodCam := '';
    End;
  End;
End;

procedure TComponentMovel.pAlinhamento(tipoAlinh: TTipoAlinhamento);
  Var
    intCnt : Integer;
    intUlt : Integer;
begin
  If (FLisSel.Count <= 0) Or
     (FLisSel.IndexOf(FCurrentNodeControl) < 0) Then
    Exit;

  intUlt := FLisSel.IndexOf(FCurrentNodeControl);

  For intCnt := 0 To (FLisSel.Count-1) Do
  Begin
    If intCnt = intUlt Then
      Continue;

    If (FLisSel[intCnt] Is TLayStaticText) Then
    Begin
      Case tipoAlinh Of
        tpaTopo: Begin
          (FLisSel[intCnt] As TLayStaticText).fltTop := (FLisSel[intUlt] As TLayStaticText).fltTop;
        End;
        tpaEsquerda: Begin
          (FLisSel[intCnt] As TLayStaticText).fltLeft := (FLisSel[intUlt] As TLayStaticText).fltLeft;
        End;

        tpaDireita: Begin
          (FLisSel[intCnt] As TLayStaticText).fltLeft := (FLisSel[intUlt] As TLayStaticText).fltLeft;

          If (FLisSel[intCnt] As TLayStaticText).fltWidth < (FLisSel[intUlt] As TLayStaticText).fltWidth Then
            (FLisSel[intCnt] As TLayStaticText).fltLeft := (FLisSel[intCnt] As TLayStaticText).fltLeft + ((FLisSel[intUlt] As TLayStaticText).fltWidth - (FLisSel[intCnt] As TLayStaticText).fltWidth)
          Else
            (FLisSel[intCnt] As TLayStaticText).fltLeft := (FLisSel[intCnt] As TLayStaticText).fltLeft - ((FLisSel[intCnt] As TLayStaticText).fltWidth - (FLisSel[intUlt] As TLayStaticText).fltWidth);

          (FLisSel[intCnt] As TLayStaticText).fltLeft := (FLisSel[intCnt] As TLayStaticText).fltLeft;
        End;

        tpaEmBaixo: Begin
          (FLisSel[intCnt] As TLayStaticText).fltTop := (FLisSel[intUlt] As TLayStaticText).fltTop;

          If (FLisSel[intCnt] As TLayStaticText).fltHeight < (FLisSel[intUlt] As TLayStaticText).fltHeight Then
            (FLisSel[intCnt] As TLayStaticText).fltTop := (FLisSel[intCnt] As TLayStaticText).fltTop + ((FLisSel[intUlt] As TLayStaticText).fltHeight - (FLisSel[intCnt] As TLayStaticText).fltHeight)
          Else
            (FLisSel[intCnt] As TLayStaticText).fltTop := (FLisSel[intCnt] As TLayStaticText).fltTop - ((FLisSel[intCnt] As TLayStaticText).fltHeight - (FLisSel[intUlt] As TLayStaticText).fltHeight);

          (FLisSel[intCnt] As TLayStaticText).fltTop := (FLisSel[intCnt] As TLayStaticText).fltTop;
        End;
      End;
    End;
  End;
end;

procedure TComponentMovel.pAlteraExpressao;
Begin
  pCriarFormularios(TfrmDigExpressao, frmDigExpressao);

  With frmDigExpressao Do
  Begin
    objComMov := Self;
    mmoExpressao.Text := TLayStaticText(FCurrentNodeControl).strCodCam;

    If ShowModal = mrOk Then
    Begin
      TLayStaticText(FCurrentNodeControl).strCapCam := mmoExpressao.Text;
      TLayStaticText(FCurrentNodeControl).strCodCam := mmoExpressao.Text;
    End;
  End;

  FreeAndNil(frmDigExpressao);
End;

Function TComponentMovel.fAlinhamento(strAlinha: String): TFrxHAlign;
Begin
  If Length(strAlinha) = 0 Then
    Result := TfrxHAlign.haLeft
  Else
  Begin
    Case strAlinha[1] Of
      'E': Result := TfrxHAlign.haLeft;
      'D': Result := TfrxHAlign.haRight;
      'C': Result := TfrxHAlign.haCenter;
      Else Result := TfrxHAlign.haLeft;
    End;
  End;
End;

procedure TComponentMovel.pAbreDefCampos(qryTabCam: TUniQuery);
Begin
  With qryTabCam, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT C.*, CONCAT(CAM_POSCAM, CAM_DESCAM) AS CAM_POSDES FROM CAMETI C ');
    Add('WHERE');

    Add(fSQLFiltroCamposDocumento(ARR_CODIGO_ETIQUETA[FCodEti]));

    If FCodEti In CONJ_LASER Then
      Add('AND CAM_LASER_ = "S"')

    Else If FCodEti In CONJ_ARGOX Then
      Add('AND CAM_ARGOX_ = "S"');

    Add('ORDER BY ');
    Add('  CAM_POSCAM, CAM_DESCAM ');

    ParamByName('CODETI').AsInteger := ARR_CODIGO_ETIQUETA[FCodEti];
    Open;
  End;
End;

Procedure TComponentMovel.pInicializaScript;
Begin

  With FScript Do
  Begin
    Clear;
    AddType('Integer', fvtInt);
    AddType('Boolean', fvtBool);
    AddType('Double' , fvtFloat);
    AddType('Char',    fvtChar);
    AddType('String',  fvtString);
    AddType('Variant', fvtVariant);
  End;

  With FExpCam, FScript Do
  Begin
    First;
    While Not Eof Do
    Begin

      If Length(FieldByName('CAM_TIPCAM').AsString) > 0 Then
        Case FieldByName('CAM_TIPCAM').AsString[1] Of
          'T': AddConst(FieldByName('CAM_CODCAM').AsString, 'Double',  1);
          'D': AddConst(FieldByName('CAM_CODCAM').AsString, 'Integer', 1);
          'I': AddConst(FieldByName('CAM_CODCAM').AsString, 'Integer', 1);
          'F': AddConst(FieldByName('CAM_CODCAM').AsString, 'Double',  1.11);
          'S': AddConst(FieldByName('CAM_CODCAM').AsString, 'String',  'AAAA');
        End;

      Next;
    End;

  End;

End;

Function TComponentMovel.CallMethod(Instance: TObject; ClassType: TClass;
  Const MethodName: String; Var Params: Variant): Variant;
Begin
  If Boolean(Params[0]) Then Result := Params[1]
  Else Result := Params[2];
End;

Function TComponentMovel.fAvaliaExpressao(mmoExpressao: TMemo): Boolean;
  Var
    strExpres,
    strMsgErr: String;
Begin
  If fEmptyStr(mmoExpressao.Text) Then
  Begin
    Result := True;
    Exit;
  End;

  With FScript Do
  Begin

    pInicializaScript;

    AddMethod('Function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant', CallMethod);

    strExpres := Trim(mmoExpressao.Text);

    Lines.Clear;
    Lines.Add('Function Expressao: Variant;');
    Lines.Add('Begin');
    Lines.Add('  Result := ');
    Lines.Add(strExpres);
    Lines.Add('End;');
    Lines.Add('Begin');
    Lines.Add('End.');

    Result := Compile;

    If Result And
      (  CharInSet( RightStr(strExpres, 1)[1], [';', '+', '-'] )) Then
    Begin
      ErrorMsg := ' "' + RightStr(strExpres, 1) +'" inesperado';
      Result := False;
    End;

    If Not Result Then
    Begin
      strMsgErr := ErrorMsg;

      If SameText(strMsgErr, 'Incompatible types') Then
        strMsgErr := 'Tipos incompatíveis'

      Else If Pos('Undeclared identifier', strMsgErr) > 0 Then
      Begin
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Undeclared identifier:', 'Campo desconhecido: ');
      End

      Else If SameText(strMsgErr, ''';'' expected') Then
        strMsgErr := 'Expressão inválida'

      Else
      Begin
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Expression expected', 'Expressão esperada');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'expected', 'esperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Expected', 'Esperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'unexpected', 'inesperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Unexpected', 'Inesperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Identifier', 'Identificador');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'identifier', 'identificador');
      End;

      pMensagemOk(strMsgErr + '!' + '  Pos: [' + FScript.ErrorPos + ']');
    End;

  End;
End;

Procedure TComponentMovel.pReposicionaCamposMarSup(intVerAnt, intHorAnt: Integer);
  Var
    intIndice: Integer;
    layCmpMvl: TLayStaticText;
Begin
  For intIndice := 0 To FCamObj.Count - 1 Do
  Begin
    layCmpMvl := TLayStaticText(FCamObj[intIndice]);

    If layCmpMvl.Top < FEditor.intIniFoD Then
    Begin
      layCmpMvl.Top  := layCmpMvl.Top  + FEditor.intIniVer - FEditor.scrScroll.VertScrollBar.Position - intVerAnt;
      layCmpMvl.Left := layCmpMvl.Left + FEditor.intIniHor - FEditor.scrScroll.HorzScrollBar.Position - intHorAnt;
    End Else
    Begin
      layCmpMvl.fltTop  := layCmpMvl.fltTop - fPixelToCmColuna(FEditor.intIniVer - FEditor.scrScroll.VertScrollBar.Position - intVerAnt, True, FTipImp);
    End;

  End;

  If FTipImp = 'M' Then
    FEditor.pSetaRegua;

  SetNodesVisible(False);
End;

Procedure TComponentMovel.pReposicionaCamposMarInf(fltMarInfAnt, fltMarInfAtu: Double);
  Var
    intIndice: Integer;
    layCmpMvl: TLayStaticText;
Begin
  For intIndice := 0 To FCamObj.Count - 1 Do
  Begin
    layCmpMvl := TLayStaticText(FCamObj[intIndice]);

    If layCmpMvl.Top > FEditor.intIniFoD - Trunc(fCmColunaToPixel(fltMarInfAnt - fltMarInfAtu, True, FTipImp, True)) Then
    Begin
      layCmpMvl.Top       := layCmpMvl.Top + Trunc(fCmColunaToPixel(fltMarInfAnt - fltMarInfAtu, True, FTipImp, True));
      layCmpMvl.fltfrxTop := layCmpMvl.fltfrxTop + fCmColunaToPixel(fltMarInfAnt - fltMarInfAtu, True, FTipImp, True);
    End;

  End;

  If FTipImp = 'M' Then
    FEditor.pSetaRegua;

  SetNodesVisible(False);
End;


Procedure TComponentMovel.pReposicionaCamposMarLeft(intVerAnt, intHorAnt: Integer);
  Var
    intIndice: Integer;
    layCmpMvl: TLayStaticText;
Begin
  For intIndice := 0 To FCamObj.Count - 1 Do
  Begin
    layCmpMvl := TLayStaticText(FCamObj[intIndice]);

    layCmpMvl.Top  := layCmpMvl.Top  + FEditor.intIniVer - FEditor.scrScroll.VertScrollBar.Position - intVerAnt;
    layCmpMvl.Left := layCmpMvl.Left + FEditor.intIniHor - FEditor.scrScroll.HorzScrollBar.Position - intHorAnt;

  End;

  If FTipImp = 'M' Then
    FEditor.pSetaRegua;

  SetNodesVisible(False);
End;


(*********************************************************************************)
(* REPOSICIONA TODOS OS CAMPOS QUE ESTAO ABAIXO DO HEADER                        *)
(******************************************************************************LA*)
Procedure TComponentMovel.pReposicionaCamposHeader(fltAltAnt, fltAltAtu: Double; intIniVer, intIniFoo: Integer);
  Var
    intIndice: Integer;
    layCmpMvl: TLayStaticText;
Begin
 // QUANDA HÁ BARRA DE ROLAGEM NA TELA AS POSIÇÕES DOS CAMPOS FICAM ERRADAS
 // VER SE POSICIONANDO NO ZERO ANTES DE GRAVAR FICARÁ CERTO
  For intIndice := 0 To FCamObj.Count - 1 Do
  Begin
    layCmpMvl := TLayStaticText(FCamObj[intIndice]);

    If (layCmpMvl.Top >= Trunc(fCmColunaToPixel(fltAltAnt, True, FTipImp)) + intIniVer - FEditor.scrScroll.VertScrollBar.Position) And
       // SE NAO ESTÁ NO RADAPE DE PAGINA NAO MEXE NA ALTURA
       (layCmpMvl.Top < intIniFoo) Then
    Begin
      layCmpMvl.Top       := layCmpMvl.Top  + Trunc(fCmColunaToPixel(fltAltAtu - fltAltAnt, True, FTipImp));
      layCmpMvl.fltfrxTop := layCmpMvl.fltfrxTop + (fCmColunaToPixel(fltAltAtu - fltAltAnt, True, FTipImp));
    End;
  End;

  If FTipImp = 'M' Then
    FEditor.pSetaRegua;

  SetNodesVisible(False);
End;

(*********************************************************************************)
(* REPOSICIONA TODOS OS CAMPOS QUE ESTAO ABAIXO DO HEADER DATA                   *)
(******************************************************************************LA*)
Procedure TComponentMovel.pReposicionaCamposHeaderData(fltAltAnt, fltAltAtu: Double; intIniVer, intIniFoo: Integer);
  Var
    intIndice: Integer;
    layCmpMvl: TLayStaticText;
Begin
 // QUANDA HÁ BARRA DE ROLAGEM NA TELA AS POSIÇÕES DOS CAMPOS FICAM ERRADAS
 // VER SE POSICIONANDO NO ZERO ANTES DE GRAVAR FICARÁ CERTO
  For intIndice := 0 To FCamObj.Count - 1 Do
  Begin
    layCmpMvl := TLayStaticText(FCamObj[intIndice]);

    If (layCmpMvl.Top > Trunc(fCmColunaToPixel(fltAltAnt + FEditor.fltHeaAlt, True, FTipImp)) + intIniVer - FEditor.scrScroll.VertScrollBar.Position) And
       // SE NAO ESTÁ NO RADAPE DE PAGINA NAO MEXE NA ALTURA
       (layCmpMvl.Top < intIniFoo) Then
    Begin
      layCmpMvl.Top       := layCmpMvl.Top  + Trunc(fCmColunaToPixel(fltAltAtu - fltAltAnt, True, FTipImp));
      layCmpMvl.fltfrxTop := layCmpMvl.fltfrxTop + (fCmColunaToPixel(fltAltAtu - fltAltAnt, True, FTipImp));
    End;
  End;

  If FTipImp = 'M' Then
    FEditor.pSetaRegua;

  SetNodesVisible(False);
End;

Procedure TComponentMovel.pReposicionaCamposRodape(intIniFooAnt: Integer);
  Var
    intIniFooAntComp,
    intIndice: Integer;
    layCmpMvl: TLayStaticText;
Begin
  intIniFooAntComp := intIniFooAnt;

  If FTipImp = 'M' Then
    intIniFooAntComp := intIniFooAnt - ALTURA_FONTE_MATRICIAL_PIXEL;

  For intIndice := 0 To FCamObj.Count - 1 Do
  Begin
    layCmpMvl := TLayStaticText(FCamObj[intIndice]);

    If (layCmpMvl.Top >= intIniFooAntComp) Then
    Begin
      layCmpMvl.Top       := layCmpMvl.Top       + FEditor.intIniFoD - intIniFooAnt;
      layCmpMvl.fltfrxTop := layCmpMvl.fltfrxTop + FEditor.intIniFoD - intIniFooAnt;
    End;

  End;

  If FTipImp = 'M' Then
    FEditor.pSetaRegua;

  SetNodesVisible(False);
End;

Procedure TComponentMovel.pReposicionaFooterData(intIniFooAnt: Integer; fltAltFooAnt: Double; blnFooPag: Boolean);
  Var
    intIndice: Integer;
    layCmpMvl: TLayStaticText;
Begin
  For intIndice := 0 To FCamObj.Count - 1 Do
  Begin
    layCmpMvl := TLayStaticText(FCamObj[intIndice]);

    If (layCmpMvl.Top >= intIniFooAnt) And
       (blnFooPag Or (layCmpMvl.Top < intIniFooAnt + Trunc(fCmColunaToPixel(fltAltFooAnt, True, FTipImp)))) Then
    Begin
      layCmpMvl.Top       := layCmpMvl.Top       - intIniFooAnt + FEditor.intIniFoD;
      layCmpMvl.fltfrxTop := layCmpMvl.fltfrxTop - intIniFooAnt + FEditor.intIniFoD;
    End;

  End;

  If FTipImp = 'M' Then
    FEditor.pSetaRegua;

  SetNodesVisible(False);
End;

Function TComponentMovel.fTextToQRCode(strValue: String): TfrxBarcode2DType;
Begin
  If SameText(strValue, 'PDF417') Then
    Result := bcCodePDF417
  Else If SameText(strValue, 'DataMatrix') Then
    Result := bcCodeDataMatrix
  Else
    Result := bcCodeQR;
End;

Function TComponentMovel.fTextToBarCode(strValue: String): TfrxBarcodeType;
Begin
  If SameText(strValue, '2_5_interleaved') Then
    Result := bcCode_2_5_interleaved

  Else If SameText(strValue, '2_5_industrial') Then
    Result := bcCode_2_5_industrial

  Else If SameText(strValue, '2_5_matrix') Then
    Result := bcCode_2_5_matrix

  Else If SameText(strValue, '39') Then
    Result := bcCode39

  Else If SameText(strValue, '39Extended') Then
    Result := bcCode39Extended

  Else If SameText(strValue, '128') Then
    Result := bcCode128

  Else If SameText(strValue, '128A') Then
    Result := bcCode128A

  Else If SameText(strValue, '128B') Then
    Result := bcCode128B

  Else If SameText(strValue, '128C') Then
    Result := bcCode128C

  Else If SameText(strValue, '93') Then
    Result := bcCode93

  Else If SameText(strValue, '93Extended') Then
    Result := bcCode93Extended

  Else If SameText(strValue, 'MSI') Then
    Result := bcCodeMSI

  Else If SameText(strValue, 'PostNet') Then
    Result := bcCodePostNet

  Else If SameText(strValue, 'Codabar') Then
    Result := bcCodeCodabar

  Else If SameText(strValue, 'EAN8') Then
    Result := bcCodeEAN8

  Else If SameText(strValue, 'EAN13') Then
    Result := bcCodeEAN13

  Else If SameText(strValue, 'UPC_A') Then
    Result := bcCodeUPC_A

  Else If SameText(strValue, 'UPC_E0') Then
    Result := bcCodeUPC_E0

  Else If SameText(strValue, 'UPC_E1') Then
    Result := bcCodeUPC_E1

  Else If SameText(strValue, 'UPC_Supp2') Then
    Result := bcCodeUPC_Supp2

  Else If SameText(strValue, 'UPC_Supp5') Then
    Result := bcCodeUPC_Supp5

  Else If SameText(strValue, 'EAN128A') Then
    Result := bcCodeEAN128A

  Else If SameText(strValue, 'EAN128B') Then
    Result := bcCodeEAN128B

  Else If SameText(strValue, 'EAN128C') Then
    Result := bcCodeEAN128C

  Else Result := bcCodeEAN13;
End;

Function TComponentMovel.fRetTipoDado(strTipDad: String): TFieldType;
Begin
  If fEmptyStr(strTipDad) Then
  Begin
    Result := ftString;
    Exit;
  End;

  Case strTipDad[1] Of
    'S': Result := ftString;
    'D': Result := ftDate;
    'T': Result := ftTime;
    'F': Result := ftFloat;
    'I': Result := ftInteger;
    'M': Result := ftMemo;
    Else Result := ftString;
  End;
End;

end.




