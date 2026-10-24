 unit untDefinePosicaoGrafico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untGeraFr3, cxGrid, cxGridDBChartView,
  untChartRelatorioFrame, untGridRelatorio, untModuloGrid,
  untZClient, Vcl.Printers;

type
  TfrmDefinePosicaoGrafico = class(TfrmPaiConfirma)
    btnImprimir: TBitBtnLocked;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    intQtdX,
    intLargura,
    intAltura,
    intTop,
    intLeft,
    intLinhaAtual,
    intColunasSave: Integer;

    pnlLinha: TPanel;
    pnlGrafico: TPanel;
    splAjuste: TSplitter;

    blnMontouTela,
    blnCarregarLinhas,
    blnTemAjusteAltura: Boolean;

    frmChart: TfrmChartRelatorioFrame;

    arrGridRelatorioGeral: TArrGridRelatorioGeral;

    dtmModuloGrid: TdtmModuloGrid;

    procedure pSplitterMoved(Sender: TObject);

    procedure pDesenhaGrade;
    procedure pPanelLinhaResize(Sender: TObject);
    Function fGetNumeroColunas(intLinha: Integer): Integer;

    procedure pAjustaAlturaLinhas(blnResize: Boolean);

    procedure pInicializaLinhaColuna(blnResize: Boolean);
    procedure pCriaPaineisdeLinhas(blnResize: Boolean);
    procedure pCriaBorasArredondadas(imgSupEsq: TImage;
                                     imgSupDir: TImage;
                                     imgInfEsq: TImage;
                                     imgInfDir: TImage);
    procedure pAtualizaPosicoes(intGraficoAtual: Integer);
    procedure pCriaChart(blnResize: Boolean; intGraficoAtual: Integer);
    procedure pCriaGrid(blnResize: Boolean; intGraficoAtual: Integer);
    procedure pSetaTituloGrid(pnlTitulo: TPanel; intGraficoAtual: Integer);
    procedure pCriaPanelGrafico(intGraficoAtual: Integer);
    procedure pSetaPosicaoPanelGrafico;
    procedure pLiberaGrids;
    procedure pAtualizaAlturaLinhas;
    procedure pImprimeGrafico(CanvasOrigem: TCanvas; Largura, Altura: Integer);

  public
    { Public declarations }
    blnMontagem,
    blnLayOut: Boolean;
    intGraficos,
    intLinhas,
    intColunas,
    intMoldura: Integer;

    objGeraFr3: TGeraFR3;

    procedure pCriaGraficos(blnResize: Boolean);
  end;

var
  frmDefinePosicaoGrafico: TfrmDefinePosicaoGrafico;

implementation

{$R *.dfm}

Uses
  Math,
  untFuncEditorRel,
  untFuncoesSimples,
  untInterfaceRelatorio,
  untRelatorio;

procedure TfrmDefinePosicaoGrafico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  objGeraFr3.intAlturaGrafico  := Self.Height;
  objGeraFr3.intLarguraGrafico := Self.Width;
  objGeraFr3.blnMaximizado     := Self.WindowState = wsMaximized;

  pAtualizaAlturaLinhas;

  pLiberaGrids;
end;

procedure TfrmDefinePosicaoGrafico.pAtualizaAlturaLinhas;
  Var
    intContador: Integer;
    pnlLinha: TPanel;
Begin
  If blnMontouTela And blnMontagem And blnTemAjusteAltura Then
  Begin
    objGeraFr3.stlAlturaLinhas.Clear;

    For intContador := 1 To intLinhas Do
    Begin
      pnlLinha := TPanel(FindComponent('pnlLinha' + intContador.ToString()));

      If Assigned(pnlLinha) Then
        objGeraFr3.stlAlturaLinhas.Add(pnlLinha.Height.ToString())
      Else
        objGeraFr3.stlAlturaLinhas.Add('0');
    End;
  End;
End;

procedure TfrmDefinePosicaoGrafico.FormCreate(Sender: TObject);
begin
  inherited;

  objGeraFr3 := Nil;

  intLinhas  := 0;
  intColunas := 0;

  blnMontouTela := False;
  blnMontagem := True;
  blnLayOut := True;
  intGraficos := 5;
  intMoldura := 40;

  SetLength(arrGridRelatorioGeral, 0);

  dtmModuloGrid := TdtmModuloGrid.Create(Self);
end;

procedure TfrmDefinePosicaoGrafico.FormPaint(Sender: TObject);
begin
  inherited;

  If blnLayOut Then
    pDesenhaGrade;
end;

procedure TfrmDefinePosicaoGrafico.FormResize(Sender: TObject);
begin
  inherited;

  pCriaGraficos(True);
end;

procedure TfrmDefinePosicaoGrafico.FormShow(Sender: TObject);
begin
  inherited;

  blnTemAjusteAltura := SameText(objGeraFr3.arrCadRel[0].FieldByName('REL_INFALT').AsString, 'S');

  If objGeraFr3.intAlturaGrafico > 0 Then
  Begin
    If blnMontagem  Then
      Self.Height := objGeraFr3.intAlturaGrafico
    Else
      Self.Height := objGeraFr3.intAlturaGrafico - (intLinhas - 1) * 3 {Altura dos splitter} - 10 {BordaSingle};

    Self.Width  := objGeraFr3.intLarguraGrafico;

    If objGeraFr3.blnMaximizado Then
      Self.WindowState := wsMaximized;
  End;

  If Not blnLayOut Then
  Begin
    btnConfirma.Visible := False;
    btnSair.Caption := 'Sair';
  End;

  If Not blnMontagem Then
    BorderStyle := bsDialog;

  pCriaGraficos(False);
end;

procedure TfrmDefinePosicaoGrafico.pDesenhaGrade;
  Var
    intContador: Integer;
begin
  Canvas.Pen.Color := clWhite;

  intContador := 20;
  While intContador <= Height Do
  Begin
    Canvas.MoveTo(0, intContador);
    Canvas.LineTo(Width, intContador);
    intContador := intContador + 20;
  End;

  intContador := 20;
  While intContador <= Width Do
  Begin
    Canvas.MoveTo(intContador, 0);
    Canvas.LineTo(intContador, Height);
    intContador := intContador + 20;
  End;

  Canvas.Refresh;
  Application.ProcessMessages;
end;

procedure TfrmDefinePosicaoGrafico.pPanelLinhaResize(Sender: TObject);
  Var
    intContador: Integer;
    pnlPanelLinha: TPanel;
Begin
  pnlPanelLinha := TPanel(Sender);

  If Assigned(pnlPanelLinha) Then
  Begin
    For intContador := 0 To pnlPanelLinha.ControlCount - 1 Do
      If pnlPanelLinha.Controls[intContador] Is TPanel Then
      Begin
        If pnlPanelLinha.Height - intMoldura >= 0 Then
          TPanel(pnlPanelLinha.Controls[intContador]).Height := pnlPanelLinha.Height - intMoldura;
      End;
  End;
End;

procedure TfrmDefinePosicaoGrafico.pImprimeGrafico(CanvasOrigem: TCanvas; Largura, Altura: Integer);
var
  BitmapOriginal, BitmapRedimensionado: TBitmap;
  EscalaX, EscalaY, Escala: Double;
  intMarHor, intMarVer: Integer;
begin

  // Definindo espaçamentos de margem horiozontal e vertical
  intMarHor := 200;
  intMarVer := 300;

  // Criar o bitmap original e capturar o conteúdo do Canvas
  BitmapOriginal := TBitmap.Create;
  BitmapRedimensionado := TBitmap.Create;
  try
    // Definir o tamanho do Bitmap original
    BitmapOriginal.Width := Largura;
    BitmapOriginal.Height := Altura;

    // Copiar o conteúdo do Canvas para o Bitmap
    BitmapOriginal.Canvas.CopyRect(Rect(0, 0, Largura, Altura), CanvasOrigem, Rect(0, 0, Largura, Altura));

    // Criar o bitmap redimensionado
    BitmapRedimensionado.Width := Printer.PageWidth - intMarHor;
    BitmapRedimensionado.Height := Printer.PageHeight - intMarVer;

    // Calcular a escala proporcional
    EscalaX := (Printer.PageWidth - intMarHor) / BitmapOriginal.Width;
    EscalaY := (Printer.PageHeight - intMarVer) / BitmapOriginal.Height;
    Escala := Min(EscalaX, EscalaY);

    // Redimensionar usando StretchDraw
    BitmapRedimensionado.Canvas.StretchDraw(Rect(Round(intMarHor / 2), Round(intMarVer / 2), Round(BitmapOriginal.Width * Escala), Round(BitmapOriginal.Height * Escala)), BitmapOriginal);

    Printer.BeginDoc;
    try
      Printer.Canvas.Draw(0, 0, BitmapRedimensionado);
    finally
      Printer.EndDoc;
    end;

  finally
    BitmapOriginal.Free;
    BitmapRedimensionado.Free;
  end;
end;

procedure TfrmDefinePosicaoGrafico.btnImprimirClick(Sender: TObject);
begin
  inherited;
  if frmChart.dlgImprimir.Execute then
    pImprimeGrafico(frmChart.cxgGrafico.ActiveView.Site.Canvas.Canvas, frmChart.cxgGrafico.ActiveView.Site.Width, frmChart.cxgGrafico.ActiveView.Site.Height);
end;

Function TfrmDefinePosicaoGrafico.fGetNumeroColunas(intLinha: Integer): Integer;
Begin
  If TInterfaceRelatorio(objGeraFr3.objInterfaceGera).cdsColunasPorLinha.FindKey([intLinha]) Then
    Result := TInterfaceRelatorio(objGeraFr3.objInterfaceGera).cdsColunasPorLinha.FieldByName('QTDCOL').AsInteger
  Else
    Result := 1;
End;

procedure TfrmDefinePosicaoGrafico.pInicializaLinhaColuna(blnResize: Boolean);
Begin
  intLinhaAtual := 1;

  intColunasSave := intColunas;

  If (intColunas = 0) Then
    intColunas := Ceil(Sqrt(intGraficos));

  If (intLinhas = 0) Then
  Begin
    intLinhas :=  Floor(Sqrt(intGraficos));

    While intColunas * intLinhas < intGraficos Do
      Inc(intLinhas);
  End;

  If Not SameText(objGeraFr3.arrCadRel[0].FieldByName('REL_INFCOL').AsString, 'S') Then
  Begin
    If intColunas > intGraficos Then
      intColunas := intGraficos;

    While (intLinhas > 1) And (intColunas * intLinhas - intColunas >= intGraficos) Do
      Dec(intLinhas);
  End;

  intLargura := (ClientWidth - (intColunas + 1) * intMoldura) Div intColunas;
  intAltura  := (ClientHeight - pnlBotoes.Height - pnlStatus.Height  - (intLinhas + 1) * intMoldura) Div intLinhas;

  blnCarregarLinhas := (objGeraFr3.stlAlturaLinhas.Count = intLinhas) And blnTemAjusteAltura;

  pAjustaAlturaLinhas(blnResize);
End;

procedure TfrmDefinePosicaoGrafico.pAjustaAlturaLinhas(blnResize: Boolean);
  Var
    intContador,
    intSomaAlturaLinhas: Integer;
Begin
  If (blnMontagem And blnCarregarLinhas And blnResize And Assigned(FindComponent('pnlLinha1'))) Or
     ((Not blnMontagem) And blnCarregarLinhas And (Not blnResize) And (Self.WindowState = wsMaximized)) Then
  Begin
    intSomaAlturaLinhas := 0;
    For intContador := 0 To objGeraFr3.stlAlturaLinhas.Count - 1 Do
      Inc(intSomaAlturaLinhas, StrToIntDef(objGeraFr3.stlAlturaLinhas[intContador], 0));

    If intSomaAlturaLinhas > 0 Then
    For intContador := 0 To objGeraFr3.stlAlturaLinhas.Count - 1 Do
      objGeraFr3.stlAlturaLinhas[intContador] :=  Trunc(StrToIntDef(objGeraFr3.stlAlturaLinhas[intContador], 0) /
                                                        intSomaAlturaLinhas *
                                                              // SPLITTER           // pnlRodape
        (ClientHeight - pnlBotoes.Height - pnlStatus.Height - (intLinhas - 1) * 3 - intMoldura)).ToString();
  End;

End;

procedure TfrmDefinePosicaoGrafico.pSplitterMoved(Sender: TObject);
begin
  pAtualizaAlturaLinhas;
end;

procedure TfrmDefinePosicaoGrafico.pCriaPaineisdeLinhas(blnResize: Boolean);
  Var
    intContador: Integer;
Begin
  If (Not blnLayOut) And (Not blnResize) And blnMontagem And blnTemAjusteAltura Then
  Begin
    pnlGrafico := TPanel.Create(Self);
    pnlGrafico.Height := intMoldura;
    pnlGrafico.Align := alBottom;
    pnlGrafico.Name := 'pnlRodape';
    pnlGrafico.Parent := Self;
    pnlGrafico.BevelOuter := bvNone;
    pnlGrafico.ShowCaption := False;
    pnlGrafico.StyleElements := [];
    pnlGrafico.Color := Self.Color;

    intTop  :=  0;

    For intContador := 1 To intLinhas Do
    Begin
      pnlGrafico := TPanel.Create(Self);
      pnlGrafico.Top := intTop;

      If blnCarregarLinhas Then
        pnlGrafico.Height := objGeraFr3.stlAlturaLinhas[Pred(intContador)].ToInteger()
      Else
        pnlGrafico.Height := intAltura + intMoldura;

      pnlGrafico.Align := alTop;
      pnlGrafico.Name := 'pnlLinha' + intContador.ToString();
      pnlGrafico.Parent := Self;
      pnlGrafico.BevelOuter := bvNone;
      pnlGrafico.ShowCaption := False;
      pnlGrafico.StyleElements := [];
      pnlGrafico.OnResize := pPanelLinhaResize;
      pnlGrafico.Color := Self.Color;

      Inc(intTop, pnlGrafico.Height);

      If intContador = intLinhas Then
      Begin
        pnlGrafico.Align := alClient;
      End Else
      Begin
        splAjuste := TSplitter.Create(Self);
        splAjuste.Top := intTop;
        splAjuste.Height := intAltura;
        splAjuste.Align := alTop;
        splAjuste.Name := 'splAjuste' + intContador.ToString();
        splAjuste.Parent := Self;
        splAjuste.Color := clYellow;

        splAjuste.OnMoved := pSplitterMoved;

        Inc(intTop, splAjuste.Height);

      End;
    End;
  End;
End;

procedure TfrmDefinePosicaoGrafico.pCriaBorasArredondadas(imgSupEsq: TImage;
                                                          imgSupDir: TImage;
                                                          imgInfEsq: TImage;
                                                          imgInfDir: TImage);
 Const
   arrSE: Array[0..6] Of Integer = (7, 5, 3, 2, 2, 1, 1);
   arrIE: Array[0..6] Of Integer = (1, 1, 2, 2, 3, 5, 7);
 Var
    intX,
    intY: Integer;
Begin
  imgSupEsq.Visible := True;
  imgSupEsq.Picture.Assign(Nil);
  imgSupEsq.Canvas.Brush.Color := clWhite;
  imgSupEsq.Canvas.FloodFill(2, 2, clWhite, fsSurface);

  imgSupDir.Visible := True;
  imgSupDir.Picture.Assign(Nil);
  imgSupDir.Canvas.Brush.Color := clWhite;
  imgSupDir.Canvas.FloodFill(2, 2, clWhite, fsSurface);

  imgInfEsq.Visible := True;
  imgInfEsq.Picture.Assign(Nil);
  imgInfEsq.Canvas.Brush.Color := clWhite;
  imgInfEsq.Canvas.FloodFill(2, 2, clWhite, fsSurface);

  imgInfDir.Visible := True;
  imgInfDir.Picture.Assign(Nil);
  imgInfDir.Canvas.Brush.Color := clWhite;
  imgInfDir.Canvas.FloodFill(2, 2, clWhite, fsSurface);

  // SE
  For Inty := 0 To 6 Do
    For IntX := 0 To arrSE[Inty] - 1 Do
      imgSupEsq.Canvas.Pixels[intX, intY] := Self.Color;
  (****************************************************************************)

  // IE
  intQtdX := 0;
  For Inty := imgInfEsq.Height - 7 To imgInfEsq.Height - 1 Do
  Begin
    For IntX := 0 To arrIE[intQtdX] - 1 Do
      imgInfEsq.Canvas.Pixels[intX, intY] := Self.Color;

    Inc(intQtdX);
  End;
  (****************************************************************************)

  // SD
  For Inty := 0 To 6 Do
    For IntX := imgSupDir.Width - 1 - (arrSE[IntY] - 1) To imgSupDir.Width - 1 Do
      imgSupDir.Canvas.Pixels[intX, intY] := Self.Color;
  (****************************************************************************)

  // ID
  intQtdX := 0;
  For Inty := imgInfDir.Height - 7 To imgInfDir.Height - 1 Do
  Begin
    For IntX := imgInfDir.Width - 1 DownTo imgInfDir.Width - 1 - (arrIE[intQtdX] - 1) Do
      imgInfDir.Canvas.Pixels[intX, intY] := Self.Color;

     Inc(intQtdX);
  End;
End;

procedure TfrmDefinePosicaoGrafico.pAtualizaPosicoes(intGraficoAtual: Integer);
Begin
  intLeft := intLeft + intMoldura + intLargura;

  If intLeft + intLargura > ClientWidth Then
  Begin
    intLeft := intMoldura;

    If blnCarregarLinhas And (objGeraFr3.stlAlturaLinhas[Pred(intLinhaAtual)].ToInteger() - intMoldura > 0) Then
    Begin
      intTop := intTop + objGeraFr3.stlAlturaLinhas[Pred(intLinhaAtual)].ToInteger();

      If Not blnMontagem Then
        intTop  := intTop;
    End Else
    Begin
      intTop := intTop + intMoldura + intAltura;
    End;

    Inc(intLinhaAtual);

    If (intLinhaAtual = intLinhas) Then
    Begin

      If intGraficos > intGraficoAtual Then
      Begin
        intColunas := (intGraficos - intGraficoAtual);
        intLargura := (ClientWidth - (intColunas + 1) * intMoldura) Div intColunas;
      End;

    End;

  End;
End;

procedure TfrmDefinePosicaoGrafico.pCriaChart(blnResize: Boolean; intGraficoAtual: Integer);
Begin
  If (Not blnLayOut) And (Not blnResize) Then
  Begin
    frmChart := TfrmChartRelatorioFrame.Create(Self);
    frmChart.intRelatorio := Pred(intGraficoAtual);
    frmChart.objGeraFr3 := objGeraFr3;

    frmChart.Name := 'frmGrafico' + intGraficoAtual.ToString();
    frmChart.pnlChart.Color := Self.Color;
    frmChart.Parent := pnlGrafico;

    pCriaBorasArredondadas(frmChart.imgSupEsq, frmChart.imgSupDir, frmChart.imgInfEsq, frmChart.imgInfDir);

    If intGraficoAtual = 1 Then
    Begin
      objGeraFr3.pMontaGrafico(frmChart.cxgGrafico,
                               frmChart.cxvGrafico,
                               frmChart,
                               objGeraFr3.cdsCamposG,
                               Pred(intGraficoAtual),
                               frmChart.dtsGrafico,
                               frmChart.shpGrafico);

    End Else
    Begin
      objGeraFr3.pMontaGrafico(frmChart.cxgGrafico,
                               frmChart.cxvGrafico,
                               frmChart,
                               TRelatorio(objGeraFr3.arrSalvaComplementos[Pred(intGraficoAtual) - 1]).objInterface.cdsCampos,
                               Pred(intGraficoAtual),
                               frmChart.dtsGrafico,
                               frmChart.shpGrafico);
    End;

    frmChart.strtTituloEixoX := objGeraFr3.arrCadRel[Pred(intGraficoAtual)].FieldByName('REL_CATTIT').AsString;

    If objGeraFr3.arrCadRel[Pred(intGraficoAtual)].FieldByName('REL_TEMREF').AsInteger > 0 Then
    Begin
      frmChart.tmrRefreshDados.Interval := 1000 * objGeraFr3.arrCadRel[Pred(intGraficoAtual)].FieldByName('REL_TEMREF').AsInteger;
      frmChart.tmrRefreshDados.Enabled := True;
    End;

    frmChart.pIniciaDiagrama;
  End;
End;

procedure TfrmDefinePosicaoGrafico.pCriaPanelGrafico(intGraficoAtual: Integer);
Begin
  pnlGrafico := TPanel.Create(Self);

  pnlGrafico.Name := 'pnlGrafico' + intGraficoAtual.ToString();

  pnlGrafico.BevelOuter := bvNone;
  pnlGrafico.ShowCaption := False;
  pnlGrafico.StyleElements := [];
  pnlGrafico.Color := clWhite;

  If blnMontagem And blnTemAjusteAltura Then
    pnlGrafico.Parent := TWinControl(FindComponent('pnlLinha' + intLinhaAtual.ToString()))
  Else
    pnlGrafico.Parent := Self;
End;

procedure TfrmDefinePosicaoGrafico.pSetaPosicaoPanelGrafico;
Begin
  If Assigned(pnlGrafico) Then
  Begin
    pnlGrafico.Left := intLeft;

    If blnMontagem And blnTemAjusteAltura Then
      pnlGrafico.Top  := intMoldura
    Else
      pnlGrafico.Top  := intTop;

    pnlGrafico.Width := intLargura;

    If blnCarregarLinhas And (objGeraFr3.stlAlturaLinhas[Pred(intLinhaAtual)].ToInteger() - intMoldura > 0) Then
      pnlGrafico.Height := objGeraFr3.stlAlturaLinhas[Pred(intLinhaAtual)].ToInteger() - intMoldura
    Else
      pnlGrafico.Height := intAltura;

    If Assigned(pnlLinha) Then
      pnlLinha.Height := pnlGrafico.Height + intMoldura;
  End;
End;

procedure TfrmDefinePosicaoGrafico.pSetaTituloGrid(pnlTitulo: TPanel; intGraficoAtual: Integer);
  Var
    fonFont: TFont;
Begin
  pnlTitulo.Visible := True;
  pnlTitulo.Caption := objGeraFr3.arrCadRel[Pred(intGraficoAtual)].FieldByName('REL_DESCRI').AsString;

  If Not fEmptyStr(objGeraFr3.arrCadRel[Pred(intGraficoAtual)].FieldByName('REL_FONTIT').AsString) Then
    pnlTitulo.Font := TInterfaceRelatorio.StrToFont(objGeraFr3.arrCadRel[Pred(intGraficoAtual)].FieldByName('REL_FONTIT').AsString);

  fonFont := TFont.Create;
  fonFont := TInterfaceRelatorio.StrToFont(TInterfaceRelatorio.FontToStr(Self.Font), fonFont);

  Self.Font := TInterfaceRelatorio.StrToFont(TInterfaceRelatorio.FontToStr(pnlTitulo.Font), Self.Font);
  pnlTitulo.Height := Self.Canvas.TextHeight(pnlTitulo.Caption) + 20;

  Self.Font := TInterfaceRelatorio.StrToFont(TInterfaceRelatorio.FontToStr(fonFont), Self.Font);
End;

procedure TfrmDefinePosicaoGrafico.pCriaGrid(blnResize: Boolean; intGraficoAtual: Integer);
Begin
  If Not blnResize Then
  Begin
    SetLength(arrGridRelatorioGeral, Succ(Length(arrGridRelatorioGeral)));
    arrGridRelatorioGeral[High(arrGridRelatorioGeral)] := TGridRelatorioGeral.Create(Self, Pred(intGraficoAtual));
    arrGridRelatorioGeral[High(arrGridRelatorioGeral)].dtmModuloGrid := dtmModuloGrid;
    arrGridRelatorioGeral[High(arrGridRelatorioGeral)].objGeraFr3 := objGeraFr3;
    arrGridRelatorioGeral[High(arrGridRelatorioGeral)].fCriaGrid(pnlGrafico, Self);

    If Assigned(arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraGridFrm) Then
    Begin
      pSetaTituloGrid(arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraGridFrm.pnlTitulo, intGraficoAtual);

      If objGeraFr3.arrCadRel[Pred(intGraficoAtual)].FieldByName('REL_MOLGRA').AsString = 'A' Then
      Begin
        arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraGridFrm.pnlRodape.Visible := True;

        pCriaBorasArredondadas(arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraGridFrm.imgSupEsq,
                               arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraGridFrm.imgSupDir,
                               arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraGridFrm.imgInfEsq,
                               arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraGridFrm.imgInfDir);
      End;

      If objGeraFr3.arrCadRel[Pred(intGraficoAtual)].FieldByName('REL_TEMREF').AsInteger > 0 Then
      Begin
        arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraGridFrm.tmrRefreshDados.Interval := 1000 * objGeraFr3.arrCadRel[Pred(intGraficoAtual)].FieldByName('REL_TEMREF').AsInteger;
        arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraGridFrm.tmrRefreshDados.Enabled := True;
      End;
    End

    Else If Assigned(arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraBandedGridFrm) Then
    Begin
      pSetaTituloGrid(arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraBandedGridFrm.pnlTitulo, intGraficoAtual);

      If objGeraFr3.arrCadRel[Pred(intGraficoAtual)].FieldByName('REL_MOLGRA').AsString = 'A' Then
      Begin
        arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraBandedGridFrm.pnlRodape.Visible := True;

        pCriaBorasArredondadas(arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraBandedGridFrm.imgSupEsq,
                               arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraBandedGridFrm.imgSupDir,
                               arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraBandedGridFrm.imgInfEsq,
                               arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraBandedGridFrm.imgInfDir);
      End;

      If objGeraFr3.arrCadRel[Pred(intGraficoAtual)].FieldByName('REL_TEMREF').AsInteger > 0 Then
      Begin
        arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraBandedGridFrm.tmrRefreshDados.Interval := 1000 * objGeraFr3.arrCadRel[Pred(intGraficoAtual)].FieldByName('REL_TEMREF').AsInteger;
        arrGridRelatorioGeral[High(arrGridRelatorioGeral)].arrGrid[0].fraBandedGridFrm.tmrRefreshDados.Enabled := True;
      End;
    End

  End;
End;

procedure TfrmDefinePosicaoGrafico.pLiberaGrids;
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrGridRelatorioGeral) To High(arrGridRelatorioGeral) Do
    FreeAndNil(arrGridRelatorioGeral[intContador]);

  SetLength(arrGridRelatorioGeral, 0);
End;

procedure TfrmDefinePosicaoGrafico.pCriaGraficos(blnResize: Boolean);
  Var
    intContador: Integer;
Begin
  pInicializaLinhaColuna(blnResize);

  pCriaPaineisdeLinhas(blnResize);

  intTop  := intMoldura;
  intLeft := intMoldura;

  pnlLinha := Nil;

  For intContador := 1 To intGraficos Do
  Begin
    If SameText(objGeraFr3.arrCadRel[0].FieldByName('REL_INFCOL').AsString, 'S') Then
    Begin
      intColunas := fGetNumeroColunas(intLinhaAtual);
      intLargura := (ClientWidth - (intColunas + 1) * intMoldura) Div intColunas;
    End;

    If blnResize Then
    Begin
      pnlGrafico := TPanel(FindComponent('pnlGrafico' + intContador.ToString()));
      pnlLinha   := TPanel(FindComponent('pnlLinha' + intLinhaAtual.ToString()));
    End Else
    Begin
      pCriaPanelGrafico(intContador);
    End;

    pSetaPosicaoPanelGrafico;

    If TInterfaceRelatorio.fDestinoToTipo(objGeraFr3.arrCadRel[Pred(intContador)].FieldByName('REL_DESTIN').AsString) = desGrid Then
      pCriaGrid(blnResize, intContador)
    Else
      pCriaChart(blnResize, intContador);

    pAtualizaPosicoes(intContador);
  End;

  intColunas := intColunasSave;

  If Not blnResize Then
  Begin
    blnMontouTela := True;
    pAtualizaAlturaLinhas;
  End;
End;

end.
