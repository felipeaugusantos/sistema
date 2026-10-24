unit untInterfaceGrafica;

interface

Uses
  Classes, Vcl.Controls, Vcl.ExtCtrls, Forms, StdCtrls, untFuncoesEditorFast,
  untFuncoesSimples, Graphics, untFuncEditorRel, untZClient, SysUtils, StrUtils,
  Windows, Messages, Math, untConstantes;

Type
  TInterfaceGrafica = Class(TComponent)
  Private
    FAtualizandoComps: Boolean;

    FimgFundo: TImage;

    FDeixarEspacoEntreCampos: Boolean;

    FTipImp: String;
    FFont: TFont;
    FscrLinhas: TScrollBox;
    FAlturaLinha,
    FLarguraFonteMatrial,
    FLargura: Integer;
    FNumCol: Integer;
    FMarEsq: Integer;
    FMarDir: Integer;
    FQtdCol: Integer;
    FCampos: TZClient;

    FNroPaginas,
    FLarguraPagina,
    FMargemEsquerda,
    FMargemDireita: Integer;

    FarrLeftsFolhas: Array of Record
      intEsquerda,
      intDireita: Integer;
    End;

    FArrCampos: Array Of Record
                           edtCampo: TEdit;
                           strNomCam: String;
                         End;

    procedure pLiberaComponentes;

    procedure pCtrlMouseMove(Sender:TObject; Shift: TShiftState; X, Y: Integer);

    Function fRetEspacametoColunas: Double;

    procedure pAtualizaPosicaoComponentes(Sender:TObject; blnAlteracaoGrid: Boolean);

    Function fRetTopToLinha(intTop: Integer): Integer;
    Function fRetLinhaToTop(intLinha: Integer): Integer;
    Function fRetLeftToPosicao(intLeft, intNovaLinha, intIndiceAtual: Integer): Integer;

    procedure pImprimeMargensSplit;

    procedure pAjustaLeft(edtCampo: TEdit);

  Public

    frmPai: TForm;

    arrDireitaUltimoCampo: Array of Integer;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor  Destroy; Override;

    procedure pSetaDadosSplit(intNroPaginas, intLarguraPagina, intMargemEsquerda, intMargemDireita: Word);

    procedure pCriaComponentes(scrLinhas: TScrollBox; imgFundo: TImage;
                               strTipImp: String; fonFonte: TFont;
                               cdsCampos: TZClient);

    procedure pMoldura(scrLinhas: TScrollBox; imgFundo: TImage; intLargura, intQtdCol, intMarEsq, intMarDir, intNumCol: Integer;
         strTipImp: String; fonFonte: TFont; cdsCampos: TZClient; blnDeixarEspacoEntreCampos: Boolean);

    procedure pAtualizaLarguraCampo(strTipImp: String; cdsCampos: TZClient);
  End;

implementation

Uses
  untCadRelatorios;

Const
  ALTURA_LINHA = 25;

constructor TInterfaceGrafica.Create(Owner: TComponent);
var
  intContLinhas: Integer;
Begin
  Inherited Create(Owner);

  FDeixarEspacoEntreCampos := True;

  FNroPaginas     := 1;
  FLarguraPagina  := 0;
  FMargemEsquerda := 0;
  FMargemDireita  := 0;

  SetLength(FArrCampos, 0);
  SetLength(FarrLeftsFolhas, 0);

  FAtualizandoComps := False;
  FLarguraFonteMatrial := 0;
  FLargura := 0;
  FNumCol  := 0;
  FMarEsq  := 0;
  FMarDir  := 0;
  FTipImp  := '';
  FQtdCol  := 0;

  SetLength(arrDireitaUltimoCampo, 5);
  for intContLinhas := Low(arrDireitaUltimoCampo) to High(arrDireitaUltimoCampo) do
    arrDireitaUltimoCampo[intContLinhas] := 0;
End;

destructor TInterfaceGrafica.Destroy;
Begin
  pLiberaComponentes;

  inherited Destroy;
End;

procedure TInterfaceGrafica.pSetaDadosSplit(intNroPaginas,
  intLarguraPagina, intMargemEsquerda, intMargemDireita: Word);
Begin
  FNroPaginas     := intNroPaginas;
  FLarguraPagina  := intLarguraPagina;
  FMargemEsquerda := intMargemEsquerda;
  FMargemDireita  := intMargemDireita;
End;

procedure TInterfaceGrafica.pImprimeMargensSplit;
  Var
    intPosX,
    intLargura,
    intContador: Integer;
Begin
  SetLength(FarrLeftsFolhas, FNroPaginas);
  FarrLeftsFolhas[0].intEsquerda := 0;
  FarrLeftsFolhas[0].intDireita := 0;

  With FimgFundo Do
  Begin
    Canvas.Brush.Color := clLtGray;

    intPosX := (FLarguraPagina - FMargemEsquerda - FMargemDireita);

    For intContador := 1 To FNroPaginas - 1 Do
    Begin
      If intContador = 1 Then
        intLargura := 25             // 0.66 cm
      Else
        intLargura := FMargemEsquerda; // 38  1.00 cm

      FarrLeftsFolhas[intContador].intEsquerda := intPosX;
      FarrLeftsFolhas[intContador].intDireita  := intPosX + intLargura;

      Canvas.FillRect(Rect(intPosX,
                       0,
                       intPosX + intLargura,
                       Height));

      Inc(intPosX, (FLarguraPagina - FMargemEsquerda - FMargemDireita) + intLargura)
    End;

  End;
End;

procedure TInterfaceGrafica.pMoldura(scrLinhas: TScrollBox; imgFundo: TImage;
                                     intLargura, intQtdCol, intMarEsq, intMarDir, intNumCol: Integer; strTipImp: String; fonFonte: TFont;
                                     cdsCampos: TZClient; blnDeixarEspacoEntreCampos: Boolean);
  Var
    intPontoX,
    intPontoy,
    intColunaX,
    intColunaW,
    intContador: Integer;
Begin
  FDeixarEspacoEntreCampos := blnDeixarEspacoEntreCampos;

  If strTipImp.IsEmpty Then
    Exit;

  If (FTipImp = strTipImp) And
     (FNumCol = intNumCol) And
     (FMarEsq = intMarEsq) And
     (FMarDir = intMarDir) And
     (((FLargura = intLargura) And (strTipImp = 'J')) Or
      ((FQtdCol = intQtdCol) And (strTipImp = 'M'))) Then
    Exit;

  FimgFundo  := imgFundo;
  FCampos    := cdsCampos;
  FTipImp    := strTipImp;
  FscrLinhas := scrLinhas;
  FLargura   := intLargura;
  FNumCol    := intNumCol;
  FMarEsq    := intMarEsq;
  FMarDir    := intMarDir;
  FQtdCol    := intQtdCol;
  FFont      := fonFonte;

  If FTipImp = 'M' Then
  Begin
    FAlturaLinha         := 20;
    FLarguraFonteMatrial := 10;
    FLargura             := (FQtdCol - FMarEsq - FMarDir) * FLarguraFonteMatrial;
  End Else
  Begin
    FAlturaLinha := ALTURA_LINHA;
  End;

  If Assigned(FscrLinhas) Then
  Begin
    FscrLinhas.VertScrollBar.Position := 0;
    FscrLinhas.HorzScrollBar.Position := 0;
  End;

  intPontoY := 0;
  intPontoX := 0;

  With imgFundo Do
  Begin
    Canvas.Brush.Color := clWhite;
    Canvas.Pen.Color := clLtGray;
    Canvas.Pen.Style := psSolid;

    Top    := 0;
    Left   := 0;

    If FTipImp = 'M' Then
      Width  := FLargura
    Else
      Width  := FLargura - 1;

    Height := MAX_LINHAS_DETALHE * FAlturaLinha;

    If Assigned(FscrLinhas) Then
      FscrLinhas.Height := (MAX_LINHAS_DETALHE + 1) * FAlturaLinha;

    imgFundo.Refresh;
    imgFundo.Repaint;
    imgFundo.Refresh;
    imgFundo.Repaint;

    Canvas.Rectangle(0,
                     0,
                     Width,
                     Height);

    If FTipImp = 'J' Then
    Begin
      Canvas.Pen.Style := psDash;
    End Else
    Begin
     Canvas.Pen.Style := psSolid;
    End;

    For intContador := 1 To MAX_LINHAS_DETALHE - 1 Do
    Begin
      intPontoY := intPontoY + FAlturaLinha;

      Canvas.MoveTo(intPontoX, intPontoY);
      Canvas.LineTo(intPontoX + Width, intPontoY);
    End;

    If intNumCol > 1 Then
    Begin
      Canvas.Pen.Color := clBlack;

      intColunaW := Trunc(Width / intNumCol);
      intColunaX := intColunaW;

      For intContador := 1 To intNumCol - 1 Do
      Begin
        Canvas.MoveTo(intColunaX, 0);
        Canvas.LineTo(intColunaX, Height);

        intColunaX := intColunaX + intColunaW;
      End;

      Canvas.Pen.Color := clLtGray;
    End;

    If FTipImp = 'M' Then
    Begin

      intPontoX := 0;

      For intContador := 1 To FQtdCol - 1 Do
      Begin
        intPontoX := intPontoX + FLarguraFonteMatrial;

        Canvas.MoveTo(intPontoX, 0);
        Canvas.LineTo(intPontoX, Height);
      End;

    End;

  End;

  If FNroPaginas > 1 Then
    pImprimeMargensSplit;
End;

procedure TInterfaceGrafica.pLiberaComponentes;
  Var
    intContador: Integer;
Begin
  For intContador := Low(FArrCampos) To High(FArrCampos) Do
  Begin
    FreeAndNil(FArrCampos[intContador].edtCampo);
  End;

  SetLength(FArrCampos, 0);
End;

Function TInterfaceGrafica.fRetEspacametoColunas: Double;
Begin
  If FTipImp = 'J' Then
    Result := INT_ESPACAMENTO_COLUNAS_JATO
  Else
    Result := FLarguraFonteMatrial;
End;

Function TInterfaceGrafica.fRetLinhaToTop(intLinha: Integer): Integer;
Begin
  Result := (intLinha - 1)* FAlturaLinha;

  If FTipImp = 'J' Then
    Result := Result + 2
  Else
    Result := Result + 1;
End;

procedure TInterfaceGrafica.pAjustaLeft(edtCampo: TEdit);
  Var
    intContador: Integer;
Begin
  If FNroPaginas <= 1 Then
    Exit;

  For intContador := 1 To FNroPaginas - 1 Do
  Begin
    If (edtCampo.Left >= FarrLeftsFolhas[intContador].intEsquerda - FscrLinhas.HorzScrollBar.Position) And
       (edtCampo.Left < FarrLeftsFolhas[intContador].intDireita - FscrLinhas.HorzScrollBar.Position) Then
    Begin
      edtCampo.Left := FarrLeftsFolhas[intContador].intDireita - FscrLinhas.HorzScrollBar.Position;
      Break;
    End;

  End;
End;

procedure TInterfaceGrafica.pCriaComponentes(scrLinhas: TScrollBox; imgFundo: TImage;
      strTipImp: String; fonFonte: TFont; cdsCampos: TZClient);
  Var
    strLinha: String;
    intContador, intContLinhas: Integer;
    intLeft: Integer;
    strIndex: String;
Begin
  FCampos    := cdsCampos;
  FTipImp    := strTipImp;
  FscrLinhas := scrLinhas;
  FFont      := fonFonte;

  pLiberaComponentes;

  If Assigned(FscrLinhas) Then
  Begin
    FscrLinhas.VertScrollBar.Position := 0;
    FscrLinhas.HorzScrollBar.Position := 0;
  End;

  With FCampos Do
  Begin
    strIndex := IndexFieldNames;
    IndexFieldNames := 'CAM_LISTAR;CAM_POSICA';

    SetLength(FArrCampos, RecordCount);
    First;

    strLinha := '';

    intLeft  := 1;

    for intContLinhas := Low(arrDireitaUltimoCampo) to High(arrDireitaUltimoCampo) do
      arrDireitaUltimoCampo[intContLinhas] := 0;

    intContador := 0;

    strLinha := FieldByName('CAM_LISTAR').AsString;

    While Not Eof Do
    With FArrCampos[intContador] Do
    Begin

      edtCampo := TEdit.Create(FscrLinhas);
      edtCampo.Parent := FscrLinhas;

      If Assigned(FFont) Then
        edtCampo.Font   := FFont;

      If fEmptyStr(FieldByName('CAM_LISTAR').AsString) Then
      Begin
        edtCampo.Tag     := 0;
        edtCampo.Top     := 0;
        edtCampo.Visible := False;
      End Else
      Begin
        edtCampo.Tag     := FieldByName('CAM_LISTAR').AsInteger;
        edtCampo.Top     := fRetLinhaToTop(FieldByName('CAM_LISTAR').AsInteger);
      End;

      edtCampo.Color       := clMoneyGreen;
      edtCampo.Left        := intLeft;

      pAjustaLeft(edtCampo);

      intLeft := edtCampo.Left;

      edtCampo.ReadOnly    := True;
      edtCampo.TabStop     := False;
      edtCampo.Ctl3D       := False;
      edtCampo.AutoSize    := False;

      edtCampo.Text        := FieldByName('CAM_DESCAM').AsString;

      If AnsiMatchStr(FieldByName('CAM_ALINHA').AsString, ['', 'A']) Then
      Begin
        If SameText(FieldByName('CAM_TIPCAM').AsString,  ArrDesInterface[facFloat]) Or
           SameText(FieldByName('CAM_TIPCAM').AsString,  ArrDesInterface[facInteger]) Then
          edtCampo.Alignment := taRightJustify;
      End
      Else
      Begin
        Case AnsiIndexStr(FieldByName('CAM_ALINHA').AsString, ['E', 'C', 'D']) Of
          0 : edtCampo.Alignment := taLeftJustify;
          1 : edtCampo.Alignment := taCenter;
          2 : edtCampo.Alignment := taRightJustify;
        End;
      End;

      If FTipImp = 'J' Then
      Begin
        edtCampo.Width  := Trunc(fCmColunaToPixel(FieldByName('CAM_LARGUR').AsFloat, False, FTipImp, False));
        edtCampo.Height := FAlturaLinha - 5;
      End Else
      Begin
        edtCampo.Width  := FLarguraFonteMatrial * Trunc(FieldByName('CAM_LARGUR').AsFloat);
        edtCampo.Height := FAlturaLinha - 2;

        edtCampo.Font.Size          := MATRIACIAL_FONT_SIZE;
        edtCampo.Font.Name          := MATRIACIAL_FONT_NAME;
        edtCampo.Font.PixelsPerInch := MATRIACIAL_FONT_PPI;
      End;

      edtCampo.OnMouseMove := pCtrlMouseMove;

      strNomCam            := FieldByName('CAM_NOMCAM').AsString;

      If edtCampo.Visible Then
      Begin
        intLeft := intLeft + edtCampo.Width;

        If FDeixarEspacoEntreCampos Then
          intLeft := intLeft + Trunc(fRetEspacametoColunas);
      End;

      If edtCampo.Visible Then
        If edtCampo.Left + edtCampo.Width - 1 > arrDireitaUltimoCampo[edtCampo.Tag-1] Then
          arrDireitaUltimoCampo[edtCampo.Tag-1] := edtCampo.Left + edtCampo.Width - 1;

      Inc(intContador);
      Next;

      If Not SameText(strLinha, FieldByName('CAM_LISTAR').AsString) Then
      Begin
        intLeft  := 1;
      End;

      strLinha := FieldByName('CAM_LISTAR').AsString;
    End;

    IndexFieldNames := strIndex;
  End;
End;


procedure TInterfaceGrafica.pCtrlMouseMove(Sender:TObject; Shift: TShiftState; X, Y: Integer);

  Function pCheckDif(Tamanho, Posicao, Limite: Word): Boolean;
  Begin
    Result := Abs(Tamanho - Posicao) <= Limite;
  End;

Begin
  If Not (Sender Is TForm) Then
  Begin
    //-- Redimensionar pela lateral direita
    If pCheckDif(TWinControl(Sender).Width, X, 3) Then
    Begin
      TWinControl(Sender).Cursor := crSizeWE
    End Else
    Begin
      TWinControl(Sender).Cursor := crDrag;
     End;

  End;

  If (ssLeft In Shift) and Not (Sender Is TForm) Then
  Begin
    If FNroPaginas > 1 Then
      TfrmCadRelatorios(frmPai).tmrRolagem.Enabled := True;

    ReleaseCapture;

    If (ssLeft In Shift) Then
    Begin
      //-- Redimensionar pela lateral direita
      If pCheckDif(TWinControl(Sender).Width, X, 3) Then
      Begin
        TWinControl(Sender).perform(WM_SYSCOMMAND, $f002, 0)
      End Else
      Begin
        TWinControl(Sender).Perform(WM_SYSCOMMAND, $f012, 0);
      End;

      //-- Atualizar o form
      TControl(Sender).Parent.Refresh;

      pAtualizaPosicaoComponentes(Sender, False);
    End;
  End;
End;

Function TInterfaceGrafica.fRetTopToLinha(intTop: Integer): Integer;
Begin
  Result := (IntTop Div FAlturaLinha) + 1;

  If Result <= 0 Then
    Result := 1;

  If Result > MAX_LINHAS_DETALHE Then
    Result := MAX_LINHAS_DETALHE;
End;

Function TInterfaceGrafica.fRetLeftToPosicao(intLeft, intNovaLinha, intIndiceAtual: Integer): Integer;
  Var
    intContador: Integer;
Begin
  Result := FCampos.RecordCount;

  For intContador := Low(FArrCampos) To High(FArrCampos) Do
  With FArrCampos[intContador] Do
  If (intContador <> intIndiceAtual) And (edtCampo.Tag = intNovaLinha) And
     (edtCampo.Left >= intLeft) And FCampos.Locate('CAM_NOMCAM', strNomCam, []) Then
  Begin

    Result := FCampos.FieldByName('CAM_POSICA').AsInteger;

    Break;
  End;

End;

procedure TInterfaceGrafica.pAtualizaPosicaoComponentes(Sender:TObject; blnAlteracaoGrid: Boolean);
  Var
    strNomCamAtu: String;
    intLinha,
    intRecNo,
    intPosicao,
    intLinhaAtual,
    intNovaLinha,
    intNovaPosicao,
    intIndiceAtual,
    intListar,
    intContador,
    intTop,
    intContLinhas: Integer;
    fltMinLar: Double;
    arrLefts: Array of Integer;
    prcAfterPost: TAfterPost;
    blnMudouPosicao: Boolean;
Begin
  Try
    If FAtualizandoComps Then
      Exit;

    If FNroPaginas > 1 Then
      TfrmCadRelatorios(frmPai).tmrRolagem.Enabled := False;

    for intContLinhas := Low(arrDireitaUltimoCampo) to High(arrDireitaUltimoCampo) do
      arrDireitaUltimoCampo[intContLinhas] := 0;

    FAtualizandoComps := True;

    SetLength(arrLefts, MAX_LINHAS_DETALHE + 1);

    intIndiceAtual := 0;

    blnMudouPosicao := False;

    For intContador := Low(FArrCampos) To High(FArrCampos) Do
    With FArrCampos[intContador] Do
      If (edtCampo = Sender) Then
      Begin
        intIndiceAtual := intContador;
        Break;
      End;

    If Not blnAlteracaoGrid Then
    Begin
      prcAfterPost      := FCampos.AfterPost;
      FCampos.AfterPost := Nil;

      intTop       := (Sender As TEdit).Top;
      intNovaLinha := fRetTopToLinha(intTop);
      intPosicao   := fRetLeftToPosicao((Sender As TEdit).Left, intNovaLinha, intIndiceAtual);

      If FCampos.Locate('CAM_NOMCAM',  FArrCampos[intIndiceAtual].strNomCam, []) Then
      Begin
        blnMudouPosicao := FCampos.FieldByName('CAM_POSICA').AsInteger <> intPosicao;

        FCampos.Edit;
        FCampos.FieldByName('CAM_LISTAR').AsInteger := intNovaLinha;
        FCampos.FieldByName('CAM_POSICA').AsInteger := intPosicao;
        FCampos.Post;

        (Sender As TEdit).Tag := intNovaLinha;
        (Sender As TEdit).Top := fRetLinhaToTop(FCampos.FieldByName('CAM_LISTAR').AsInteger);
      End;

      FCampos.AfterPost := prcAfterPost;
    End;

    If (FCampos.FieldByName('CAM_LISTAR').AsString <> IntToStr((Sender As TEdit).Tag)) Or
       blnMudouPosicao Then
    Begin
      strNomCamAtu   := FCampos.FieldByName('CAM_NOMCAM').AsString;
      intLinhaAtual  := StrToIntDef(FCampos.FieldByName('CAM_LISTAR').AsString, 0);
      intPosicao     := FCampos.FieldByName('CAM_POSICA').AsInteger;
      intRecNo       := FCampos.RecNo;
      intNovaPosicao := -1;

      // PROCURA UM ITEM COM A POSICAO MAIOR
      For intContador := Low(FArrCampos) To High(FArrCampos) Do
      With FArrCampos[intContador] Do
      Begin
        FCampos.Locate('CAM_NOMCAM', strNomCam, []);

        If (edtCampo <> Sender) And
           (((edtCampo.Tag = intLinhaAtual) And (FCampos.FieldByName('CAM_POSICA').AsInteger >= intPosicao)) Or
            (edtCampo.Tag > intLinhaAtual)) Then
        Begin
          intNovaPosicao := intContador;
          Break;
        End;

      End;

      Case intNovaPosicao Of
        -1:    Begin // MUDAR PARA A ULTIMA POSICAO
                 intNovaPosicao := High(FArrCampos);

                 For intContador := intIndiceAtual To Pred(intNovaPosicao) Do
                 Begin
                   FArrCampos[intContador].edtCampo  := FArrCampos[Succ(intContador)].edtCampo;
                   FArrCampos[intContador].strNomCam := FArrCampos[Succ(intContador)].strNomCam;
                 End;

               End;

         0:    Begin // MUDAR PARA A PRIMEIRA POSICAO
                 intNovaPosicao := 0;

                 For intContador := intIndiceAtual DownTo Succ(Low(FArrCampos)) Do
                 Begin
                   FArrCampos[intContador].edtCampo  := FArrCampos[Pred(intContador)].edtCampo;
                   FArrCampos[intContador].strNomCam := FArrCampos[Pred(intContador)].strNomCam;
                 End;

               End;


         Else Begin // MUDAR PARA A intNovaPosicao - 1

                If intNovaPosicao > intIndiceAtual Then
                Begin
                  intNovaPosicao := intNovaPosicao - 1;

                  For intContador := intIndiceAtual To Pred(intNovaPosicao) Do
                  Begin
                    FArrCampos[intContador].edtCampo  := FArrCampos[Succ(intContador)].edtCampo;
                    FArrCampos[intContador].strNomCam := FArrCampos[Succ(intContador)].strNomCam;
                  End;

                End Else
                Begin

                  For intContador := intIndiceAtual DownTo Succ(intNovaPosicao) Do
                  Begin
                    FArrCampos[intContador].edtCampo  := FArrCampos[Pred(intContador)].edtCampo;
                    FArrCampos[intContador].strNomCam := FArrCampos[Pred(intContador)].strNomCam;
                  End;

                End;

              End;
      End;

      FArrCampos[intNovaPosicao].edtCampo  := Sender As TEdit;
      FArrCampos[intNovaPosicao].strNomCam := strNomCamAtu;

      FCampos.RecNo := intRecNo;
    End;

    For intContador := Low(arrLefts) To High(arrLefts) Do
      arrLefts[intContador] := 1;

    intLinha := -1;

    For intContador := Low(FArrCampos) To High(FArrCampos) Do
    With FArrCampos[intContador] Do
    Begin
      If edtCampo.Tag <> intLinha Then
      Begin
        intLinha := edtCampo.Tag;
      End;

      If (Sender = edtCampo) Then
      Begin

        If blnAlteracaoGrid Then
        Begin

          intListar        := StrToIntDef(FCampos.FieldByName('CAM_LISTAR').AsString, 0);
          edtCampo.Visible := intListar > 0;

          If FTipImp = 'J' Then
            edtCampo.Width   := Trunc(fCmColunaToPixel(FCampos.FieldByName('CAM_LARGUR').AsFloat, False, FTipImp, False))
          Else
            edtCampo.Width   :=  FLarguraFonteMatrial * Trunc(FCampos.FieldByName('CAM_LARGUR').AsFloat);

          edtCampo.Tag     := intListar;

          If intListar > 0 Then
            edtCampo.Top   := fRetLinhaToTop(FCampos.FieldByName('CAM_LISTAR').AsInteger)
          Else
            edtCampo.Top   := 0;

        End Else
        Begin
          // PRESICA ATUALIZAR A LARGURA USADA - NÃO PODE TIRAR O AFERPOST

          If FCampos.Locate('CAM_NOMCAM', strNomCam, []) Then
          Begin
            FCampos.Edit;

            If FTipImp = 'J' Then
            Begin
              FCampos.FieldbyName('CAM_LARGUR').AsFloat := fPixelToCmColuna(edtCampo.Width, False, FTipImp)
            End Else
            Begin
              edtCampo.Width := Ceil(edtCampo.Width / FLarguraFonteMatrial) * FLarguraFonteMatrial;
              FCampos.FieldbyName('CAM_LARGUR').AsFloat := edtCampo.Width Div FLarguraFonteMatrial;
            End;

            If FTipImp = 'J' Then
              fltMinLar := 0.3
            Else
              fltMinLar := 1;

            If RoundTo(FCampos.FieldbyName('CAM_LARGUR').AsFloat, -2) < RoundTo(fltMinLar, -2) Then
            Begin
              FCampos.FieldbyName('CAM_LARGUR').AsFloat := fltMinLar;

              If FTipImp = 'J' Then
                edtCampo.Width := Trunc(fCmColunaToPixel(FCampos.FieldByName('CAM_LARGUR').AsFloat, False, FTipImp, False))
              Else
                edtCampo.Width := FLarguraFonteMatrial;
            End;

            FCampos.Post;
          End;

        End;

      End;

      edtCampo.Left := arrLefts[edtCampo.Tag] - FscrLinhas.HorzScrollBar.Position;

      If FNroPaginas > 0 Then
      Begin

        pAjustaLeft(edtCampo);

        (*

        If (intFolha < FNroPaginas) And (edtCampo.Left + FscrLinhas.HorzScrollBar.Position >= FarrLeftsFolhas[intFolha].intEsquerda) Then
        Begin
          edtCampo.Left := FarrLeftsFolhas[intFolha].intDireita - FscrLinhas.HorzScrollBar.Position;
          Inc(intFolha);
        End;
        *)

      End;

      If edtCampo.Visible Then
        If edtCampo.Left + edtCampo.Width - 1 + FscrLinhas.HorzScrollBar.Position > arrDireitaUltimoCampo[edtCampo.Tag-1] Then
          arrDireitaUltimoCampo[edtCampo.Tag-1] := edtCampo.Left + edtCampo.Width - 1 + FscrLinhas.HorzScrollBar.Position;

      If edtCampo.Visible Then
      Begin
        arrLefts[edtCampo.Tag] := edtCampo.Left + edtCampo.Width + FscrLinhas.HorzScrollBar.Position;

        If FDeixarEspacoEntreCampos Then
          arrLefts[edtCampo.Tag] := arrLefts[edtCampo.Tag] + Trunc(fRetEspacametoColunas);
      End;

      If blnMudouPosicao Then
      Begin
        prcAfterPost      := FCampos.AfterPost;
        FCampos.AfterPost := Nil;

        If FCampos.Locate('CAM_NOMCAM', strNomCam, []) Then
        Begin
          FCampos.Edit;
          FCampos.FieldbyName('CAM_POSICA').AsInteger := intContador;
          FCampos.Post;
        End;

        FCampos.AfterPost := prcAfterPost;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TInterfaceGrafica.pAtualizaPosicaoComponentes')
    End;
  End;


  FAtualizandoComps := False;
End;

procedure TInterfaceGrafica.pAtualizaLarguraCampo(strTipImp: String; cdsCampos: TZClient);
  Var
    intContador: Integer;
Begin
  FCampos := cdsCampos;
  FTipImp := strTipImp;

  For intContador := Low(FArrCampos) To High(FArrCampos) Do
  With FArrCampos[intContador] Do
  If SameText(FCampos.FieldByName('CAM_NOMCAM').AsString, strNomCam) Then
  Begin
    If Assigned(edtCampo) Then
    Begin
      edtCampo.Text := FCampos.FieldByName('CAM_DESCAM').AsString;

      If AnsiMatchStr(FCampos.FieldByName('CAM_ALINHA').AsString, ['', 'A']) Then
      Begin
        If SameText(FCampos.FieldByName('CAM_TIPCAM').AsString,  ArrDesInterface[facFloat]) Or
           SameText(FCampos.FieldByName('CAM_TIPCAM').AsString,  ArrDesInterface[facInteger]) Then
          edtCampo.Alignment := taRightJustify
        Else
          edtCampo.Alignment := taLeftJustify;
      End
      Else
      Begin
        Case AnsiIndexStr(FCampos.FieldByName('CAM_ALINHA').AsString, ['E', 'C', 'D']) Of
          0 : edtCampo.Alignment := taLeftJustify;
          1 : edtCampo.Alignment := taCenter;
          2 : edtCampo.Alignment := taRightJustify;
        End;
      End;
    End;
    pAtualizaPosicaoComponentes(edtCampo, True);
    Break;
  End;
End;

End.
