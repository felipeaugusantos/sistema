unit untTGerenciaExprAltGlobal;

interface

uses
  Vcl.ExtCtrls, System.Generics.Collections, untFrameExprAltGlobal, System.Classes, System.StrUtils, cxGroupBox,
  Vcl.StdCtrls, untFuncoesSimples, VCL.Controls, System.SysUtils, Uni,  Vcl.Forms, Vcl.Graphics,
  cxEdit, cxGraphics, Winapi.Windows, cxLookAndFeels, System.Generics.Defaults, BitBtnLockedIncrem;

type
  TPrcSetaEventosKeysPai = procedure (SelfWin: TWinControl) of object;
  TPrcValidacaoCampo = procedure (Sender: TObject; AStrCampo: String; ATagFrame: Integer; var ABlnPodeSelecionar: Boolean) of object;
  TGerenciaExprAltGlobal = class
    private
      FPanelContainer: TPanel;
      FDicFrames: TDictionary<Integer, TfrmExprAltGlobal>;
      FStlCamposUsados: TStringList;
      FEdtDiasMovimentacao: TEdit;
      FBlnCarregandoCadInt: Boolean;
      FArrCamposGlobal: TArrCampoGlobal;
      FBlnAltPorFator: Boolean;
      FFrmPai: TForm;
      FBlnExpandido: Boolean;
      FIntTopOriginalPanelParent: Integer;
      FIntLeftOriginalPanelParent: Integer;
      FPrnParentOriginalPanelParent: TWinControl;
      FBtnExpandeRecolhe: TBitBtnLocked;
      FBtnAdicionar: TBitBtnLocked;
      FPrcSetaEventos: TPrcSetaEventosKeysPai;
      FIntHeightFrame: Integer;
      FIntUltimaTagAdicionada: Integer;
      Procedure pOnRemoverFrame(AIntTag: Integer);
      Function fCriaFrame(AIntTag: Integer): TfrmExprAltGlobal;
      Procedure pReordenaFrames;
      Function fGetProximaTagDisponivel: Integer;
      Procedure pRemoveCampoDaListaPorTag(AIntTagFrame: Integer);
      Procedure pExpandir;
      function fGetMaxTagUtilizada: Integer;
    public
      Constructor Create(APanelContainer: TPanel;
                         AEdtDiasMovimentacao: TEdit;
                         ABlnCarregandoCadInt: Boolean;
                         AArrCamposGlobal: TArrCampoGlobal;
                         ABlnAltPorFator: Boolean;
                         AFrmPai: TForm;
                         ABtnEspandeRecolhe: TBitBtnLocked;
                         ABtnAdicionar: TBitBtnLocked;
                         APrcSetaEventos: TPrcSetaEventosKeysPai);
      Destructor Destroy; override;

      Procedure pVisualizar;
      Procedure pAdicionar;

      Function fGetSQLExpressoes(AStrDiasMovimentacao: String; AIndexEmpresaMovimentacaoEstoque, AIndexTipoMovimentacaoEstoque: Integer): String;
      Function fGetSQLHavingExpressoes(AStrDiasMovimentacao: String; AIndexEmpresaMovimentacaoEstoque, AIndexTipoMovimentacaoEstoque: Integer): String;
      Procedure pParametrizaQuery(AQuery: TUniQuery);

      Function fValidaCamposFrames(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;

      Function fCampoEstaSendoUsado(AStrNomeCampo: String; AIntTagFrameIgnorar: Integer = -1): Boolean;
      Procedure pAdicionaCampoNaLista(AStrNomeCampo: String; AIntTagFrame: Integer);
      Procedure pLimparListaCamposUsados;
      procedure pOnCampoSelecionadoNoFrame(AStrCampo: String; ATagFrame: Integer; var ABlnPodeSelecionar: Boolean);
      procedure pOnFrameDestroy(ATagFrame: Integer);
      procedure pSetCarregandoCadInt(AblnVal: Boolean);

      property stlCamposUsados: TStringList read FStlCamposUsados;
  end;

  const MAX_EXPR = 5;

implementation

{ TGerenciaExprAltGlobal }

constructor TGerenciaExprAltGlobal.Create(APanelContainer: TPanel;
                                          AEdtDiasMovimentacao: TEdit;
                                          ABlnCarregandoCadInt: Boolean;
                                          AArrCamposGlobal: TArrCampoGlobal;
                                          ABlnAltPorFator: Boolean;
                                          AFrmPai: TForm;
                                          ABtnEspandeRecolhe: TBitBtnLocked;
                                          ABtnAdicionar: TBitBtnLocked;
                                          APrcSetaEventos: TPrcSetaEventosKeysPai);
begin
  FPanelContainer               := APanelContainer;
  FIntTopOriginalPanelParent    := FPanelContainer.Top;
  FIntLeftOriginalPanelParent   := FPanelContainer.Left;
  FPrnParentOriginalPanelParent := APanelContainer.Parent;
  FEdtDiasMovimentacao          := AEdtDiasMovimentacao;
  FBlnCarregandoCadInt          := ABlnCarregandoCadInt;
  FArrCamposGlobal              := AArrCamposGlobal;
  FBlnAltPorFator               := ABlnAltPorFator;
  FFrmPai                       := AFrmPai;
  FBtnExpandeRecolhe            := ABtnEspandeRecolhe;
  FBtnAdicionar                 := ABtnAdicionar;
  FPrcSetaEventos               := APrcSetaEventos;

  FDicFrames       := TDictionary<Integer, TfrmExprAltGlobal>.Create;
  FStlCamposUsados := TStringList.Create;
end;

destructor TGerenciaExprAltGlobal.Destroy;
var
  intTag: Integer;
  frame: TfrmExprAltGlobal;
begin
  For intTag In FDicFrames.Keys Do
  Begin
    frame := FDicFrames[intTag];
    If Assigned(frame) Then
      FreeAndNil(frame);
  End;
  FreeAndNil(FDicFrames);
  FreeAndNil(FStlCamposUsados);
  inherited;
end;

function TGerenciaExprAltGlobal.fGetSQLExpressoes(AStrDiasMovimentacao: String; AIndexEmpresaMovimentacaoEstoque, AIndexTipoMovimentacaoEstoque: Integer): String;
var
  StrSemMovEmpVenda,
  strCampoExp,
  strSufixoParam,
  StrSemMovEmpCompra : String;
  blnAlgumCampoNaoDTAUVE: Boolean;
  I: Integer;
begin
  Result := '';
  blnAlgumCampoNaoDTAUVE := False;
  for I := 1 to MAX_EXPR do
  if FDicFrames.ContainsKey(I) then
  begin
    strCampoExp := FDicFrames[I].fRetornaNomeCampoExpressao(FDicFrames[I].cmbCampos.Text);
    if Pos('ITE_DTAUVE', strCampoExp) = 0 then
    begin
      blnAlgumCampoNaoDTAUVE := True;
      Break;
    end;
  end;

  If (Not fEmptyStr(AStrDiasMovimentacao)) And blnAlgumCampoNaoDTAUVE Then
  Begin

    If AIndexEmpresaMovimentacaoEstoque = 0 Then // Empresa Atual
    Begin
      StrSemMovEmpVenda   := ' G.ITE_DTAUVE ';
      StrSemMovEmpCompra  := ' G.ITE_DTAULT ';
    End Else // Todas as Empresas
    Begin
      StrSemMovEmpVenda   := ' (SELECT MAX(IFNULL(G2.ITE_DTAUVE,0)) FROM ITEGER G2 WHERE G2.ITE_CODITE = G.ITE_CODITE) ';
      StrSemMovEmpCompra  := ' (SELECT MAX(IFNULL(G2.ITE_DTAULT,0)) FROM ITEGER G2 WHERE G2.ITE_CODITE = G.ITE_CODITE) ';
    End;

    If AIndexTipoMovimentacaoEstoque = 0 Then // Sem Venda
      Result := Result + ' AND ' + StrSemMovEmpVenda + ' < (DATE_SUB(CURDATE(), INTERVAL ' +AStrDiasMovimentacao +' DAY)) '
    Else If AIndexTipoMovimentacaoEstoque = 1 Then // Sem Compra
      Result := Result + ' AND ' + StrSemMovEmpCompra + ' < (DATE_SUB(CURDATE(), INTERVAL ' +AStrDiasMovimentacao +' DAY)) '
    Else
    Begin // Ambos
      Result := Result + ' AND (' + StrSemMovEmpVenda + ' < (DATE_SUB(CURDATE(), INTERVAL ' +AStrDiasMovimentacao+' DAY)) ';
      Result := Result + ' AND ' + StrSemMovEmpCompra + ' < (DATE_SUB(CURDATE(), INTERVAL ' +AStrDiasMovimentacao+' DAY))' + ')';
    End;
  End;

  for I := 1 to MAX_EXPR do
  begin
    if FDicFrames.ContainsKey(I) then
    begin
      strSufixoParam := '_EXPR_' + IntToStr(I);
      strCampoExp := FDicFrames[I].fRetornaNomeCampoExpressao(FDicFrames[I].cmbCampos.Text);

      If (Not fEmptyStr(FDicFrames[I].cmbCampos.Text)) And
         (Not ((Pos('ITE_DESMA', strCampoExp) > 0) Or
               (Pos('ITE_DESMG', strCampoExp) > 0) Or
               (Pos('ITE_DESMS', strCampoExp) > 0) Or
               (Pos('SEM_REAJUSTE_CUSTO', strCampoExp) > 0) Or
               (Pos('ITE_DTAUVE', strCampoExp) > 0))) Then
      Begin
        If FDicFrames[I].cmbOperad.Text = 'Entre' Then
          Result := Result + ' AND ' + FDicFrames[I].fRetornaNomeCampoExpressao(FDicFrames[I].cmbCampos.Text) + ' BETWEEN :VALDIG' + strSufixoParam + ' AND :VALDIG_OUTRO' + strSufixoParam
        Else
          Result := Result + ' AND ' + FDicFrames[I].fRetornaNomeCampoExpressao(FDicFrames[I].cmbCampos.Text) + ' ' + FDicFrames[I].cmbOperad.Text + ' :VALDIG' + strSufixoParam

      End

      Else If (Not fEmptyStr(FDicFrames[I].cmbCampos.Text)) And
              (Pos('SEM_REAJUSTE_CUSTO', strCampoExp) > 0) Then
      Begin
        Result := Result + '  AND IFNULL((SELECT COUNT(1) FROM PREALT PA                   ';
        Result := Result + '        WHERE PA.ALT_CODITE = I.ITE_CODITE                     ';
        Result := Result + '          AND PA.ALT_CODEMP = G.ITE_CODEMP                     ';
        Result := Result + '          AND PA.ALT_DTAALT BETWEEN :DTAEXPINI' + strSufixoParam + ' AND :DTAEXPFIN' + strSufixoParam;
        Result := Result + '          AND PA.ALT_CUSANT <> PA.ALT_CUSATU), 0               ';
        Result := Result + '      ) = 0                                                    ';
      End

      Else If (Not fEmptyStr(FDicFrames[I].cmbCampos.Text)) And
              (Pos('ITE_DTAUVE', strCampoExp) > 0) Then
      Begin
        If AIndexEmpresaMovimentacaoEstoque = 0 Then // Empresa Atual
          Result := Result + ' AND G.ITE_DTAUVE BETWEEN :DTAEXPINI' + strSufixoParam + ' AND :DTAEXPFIN' + strSufixoParam
        Else
          Result := Result + ' AND (SELECT COUNT(G2.ITE_DTAUVE) FROM ITEGER G2 WHERE G2.ITE_CODITE = G.ITE_CODITE AND G2.ITE_DTAUVE BETWEEN :DTAEXPINI' + strSufixoParam + ' AND :DTAEXPFIN' + strSufixoParam + ' )  > 0 ';


      End;
    End;
  End;
end;

function TGerenciaExprAltGlobal.fGetSQLHavingExpressoes(
  AStrDiasMovimentacao: String; AIndexEmpresaMovimentacaoEstoque,
  AIndexTipoMovimentacaoEstoque: Integer): String;
var
  strCampoExp,
  strHaving,
  strSufixoParam : String;
  I: Integer;
begin
  Result := '';
  for I := 1 to MAX_EXPR do
  begin
    if FDicFrames.ContainsKey(I) then
    begin
      strSufixoParam := '_EXPR_' + IntToStr(I);
      strCampoExp := FDicFrames[I].fRetornaNomeCampoExpressao(FDicFrames[I].cmbCampos.Text);

      If (Not fEmptyStr(FDicFrames[I].cmbCampos.Text)) And (Pos('SEM_REAJUSTE_CUSTO', strCampoExp) = 0) Then
      Begin
        If FDicFrames[I].cmbOperad.Text = 'Entre' Then
        Begin		  
          strHaving := IIF(fEmptyStr(Result), ' HAVING ', ' AND ');
          If (Pos('ITE_DESMA', strCampoExp) > 0) Then
             Result := Result + strHaving + strCampoExp + ' BETWEEN :VALDIG' + strSufixoParam + ' AND :VALDIG_OUTRO' + strSufixoParam;
          If (Pos('ITE_DESMG', strCampoExp) > 0) Then
             Result := Result + strHaving + strCampoExp + ' BETWEEN :VALDIG' + strSufixoParam + ' AND :VALDIG_OUTRO' + strSufixoParam;
          If (Pos('ITE_DESMS', strCampoExp) > 0) Then
             Result := Result + strHaving + strCampoExp + ' BETWEEN :VALDIG' + strSufixoParam + ' AND :VALDIG_OUTRO' + strSufixoParam;
        End
        Else
        Begin
          strHaving := IIF(fEmptyStr(Result), ' HAVING ', ' AND ');
          If (Pos('ITE_DESMA', strCampoExp) > 0) Then
             Result := Result + strHaving + strCampoExp + ' ' + FDicFrames[I].cmbOperad.Text + ' :VALDIG' + strSufixoParam;
          If (Pos('ITE_DESMG', strCampoExp) > 0) Then
             Result := Result + strHaving + strCampoExp + ' ' + FDicFrames[I].cmbOperad.Text + ' :VALDIG' + strSufixoParam;
          If (Pos('ITE_DESMS', strCampoExp) > 0) Then
             Result := Result + strHaving + strCampoExp + ' ' + FDicFrames[I].cmbOperad.Text + ' :VALDIG' + strSufixoParam;
        End;
      End;
    End;
  End;

end;

function TGerenciaExprAltGlobal.fCriaFrame(AIntTag: Integer): TfrmExprAltGlobal;
begin
  FIntUltimaTagAdicionada := AIntTag;
  Result := TfrmExprAltGlobal.Create(FFrmPai);
  Result.BtnRemoverFrame.Tag      := AIntTag;
  Result.Name                     := 'frmExprAltGlobal_' + IntToStr(Result.BtnRemoverFrame.Tag);
  Result.Parent                   := FPanelContainer;
  Result.shpTopo.Visible := False;
  Result.shpRodape.Visible := False;
  If FDicFrames.Count = 0 Then
  Begin
    Result.shpDireita.Visible  := False;
    Result.shpEsquerda.Visible := False;
  End;

  FIntHeightFrame := Result.Height;

  Result.Color                    := FFrmPai.Color;
  Result.OnRemover                := pOnRemoverFrame;
  Result.edtDiasMovimentacao      := FEdtDiasMovimentacao;
  Result.blnCarregandoCadInt      := FBlnCarregandoCadInt;
  Result.arrCamposGlobal          := FArrCamposGlobal;
  Result.blnAltPorFator           := FBlnAltPorFator;
  Result.prcExpandir              := pExpandir;
  Result.stlCamposUtilizados      := FStlCamposUsados;

  Result.btnRemoverFrame.Visible  := Result.BtnRemoverFrame.Tag > 1;
  Result.lblNumExpr.Caption       := 'Expressão: '+ IntToStr(Result.BtnRemoverFrame.Tag) + ':';

  Result.pCarregaComboExpressao;

  // Configura os callbacks para validação de campos duplicados
  Result.OnCampoSelecionado := pOnCampoSelecionadoNoFrame; // Você precisa adicionar este evento no frame

  Result.pAjustaCamposExpressao;
  Result.pPreencheComboOperadores;

  Result.cmbOperad.Enabled:= True;
  Result.cmbOperadChange(Nil);
  Result.cmbCamposChange(Nil);


  If Assigned(FPrcSetaEventos) Then
    FPrcSetaEventos(Result);
end;

function TGerenciaExprAltGlobal.fGetProximaTagDisponivel: Integer;
var
  i: Integer;
begin
  // Procura a menor tag disponível a partir de 1
  for i := 1 to MAX_EXPR do
  begin
    if not FDicFrames.ContainsKey(i) then
      Exit(i);
  end;
  // Se todas as tags estiverem ocupadas, retorna a próxima (nunca deve chegar aqui)
  Result := FDicFrames.Count + 1;
end;

function TGerenciaExprAltGlobal.fValidaCamposFrames(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  I: Integer;
begin
  Result := True;
  for i := 1 to MAX_EXPR do
  begin
    if FDicFrames.ContainsKey(i) then
    begin
      If Not FDicFrames[I].fValidaCampos(Sender, blnBuscaPorChave) Then
        Exit(False);
    end;
  End;
end;

procedure TGerenciaExprAltGlobal.pOnRemoverFrame(AIntTag: Integer);
var
  frmFrame: TfrmExprAltGlobal;
begin
  pRemoveCampoDaListaPorTag(AIntTag);

  frmFrame := FDicFrames[AintTag];
  If Assigned(frmFrame) Then
  Begin
    frmFrame.Parent  := Nil;
    frmFrame.OnClick := Nil;
    frmFrame.Free;
  End;

  FDicFrames.Remove(AIntTag);

  FPanelContainer.Height := FPanelContainer.Height - FIntHeightFrame;

  FBtnExpandeRecolhe.Enabled := FDicFrames.Count > 1;
  FBtnAdicionar.Enabled := FDicFrames.Count < MAX_EXPR;

  FBtnExpandeRecolhe.Caption := IIF(FBlnExpandido,'Recolher','Expandir');
  If FDicFrames.Count > 1 Then
    FBtnExpandeRecolhe.Caption := IIF(FBlnExpandido,'Recolher('+IntToStr(FDicFrames.Count)+')','Expandir('+IntToStr(FDicFrames.Count)+')');
  If FDicFrames.Count = 1 Then
  Begin
    FBlnExpandido := True;
    pVisualizar;
  End;

  If AIntTag = FIntUltimaTagAdicionada  Then
    FIntUltimaTagAdicionada := fGetMaxTagUtilizada;
end;

function TGerenciaExprAltGlobal.fGetMaxTagUtilizada: Integer;
var
  intTag: Integer;
begin
  Result := 0;
  For intTag In FDicFrames.Keys Do
  Begin
    If intTag > Result Then
      Result := intTag;
  End;
end;

procedure TGerenciaExprAltGlobal.pAdicionar;
var
  intTag: Integer;
begin
  If FDicFrames.Count >= MAX_EXPR Then
  Begin
    pMensagemOk('Limite máximo de 5 expressões atingido!');
    Exit;
  End;

  intTag := fGetProximaTagDisponivel;

  FDicFrames.Add(intTag, fCriaFrame(intTag));
  FBtnExpandeRecolhe.Enabled := FDicFrames.Count > 1;
  FBtnAdicionar.Enabled := FDicFrames.Count < MAX_EXPR;
  If FDicFrames.Count > 1 Then
    pExpandir;
end;

procedure TGerenciaExprAltGlobal.pExpandir;
begin
  FBlnExpandido := False;
  pVisualizar;
end;

procedure TGerenciaExprAltGlobal.pParametrizaQuery(AQuery: TUniQuery);
var
  I:Integer;
  strCampoExp,
  strSufixoParam: String;
begin
  If Not Assigned(AQuery) Then
    Exit;

  for I := 1 to MAX_EXPR do
  begin
    if FDicFrames.ContainsKey(I) then
    begin
      strSufixoParam := '_EXPR_' + IntToStr(I);
      strCampoExp := FDicFrames[I].fRetornaNomeCampoExpressao(FDicFrames[I].cmbCampos.Text);

      If Not fEmptyStr(FDicFrames[I].cmbCampos.Text) Then
      Begin
        If (Pos('SEM_REAJUSTE_CUSTO', strCampoExp) > 0) Or (Pos('ITE_DTAUVE', strCampoExp) > 0) Then
        Begin
          AQuery.ParamByName('DTAEXPINI'+strSufixoParam).AsDate := StrToDate(FDicFrames[I].mskDtaExpIni.Text);
          AQuery.ParamByName('DTAEXPFIN'+strSufixoParam).AsDate := StrToDate(FDicFrames[I].mskDtaExpFin.Text);
        End
        Else
        Begin
          AQuery.ParamByName('VALDIG'+strSufixoParam).AsFloat       := fStrToFloat(FDicFrames[I].edtValDig.Text);
          If FDicFrames[I].cmbOperad.Text = 'Entre' Then
            AQuery.ParamByName('VALDIG_OUTRO'+strSufixoParam).AsFloat := fStrToFloat(FDicFrames[I].edtValDigOutro.Text);
        End;
      End;
    end;
  end;
end;

procedure TGerenciaExprAltGlobal.pVisualizar;
begin
  Try
    Case FBlnExpandido Of
      True:  Begin
               FPanelContainer.Height             := FIntHeightFrame;
               FPanelContainer.Parent             := FPrnParentOriginalPanelParent;
               FPanelContainer.Top                := FIntTopOriginalPanelParent;
               FPanelContainer.SendToBack;
               FBlnExpandido := Not FBlnExpandido;
             End;
      False: Begin
               FPanelContainer.Height            := FDicFrames.Count * FIntHeightFrame + 10;
               FPanelContainer.Parent            := FFrmPai;
               FPanelContainer.Top               := FIntTopOriginalPanelParent + FPrnParentOriginalPanelParent.Top;
               FPanelContainer.BringToFront;
               FBlnExpandido := Not FBlnExpandido;
             End;
    End;
  Finally
    FBtnExpandeRecolhe.Caption := IIF(FBlnExpandido,'Recolher','Expandir');
    If FDicFrames.Count > 1 Then
      FBtnExpandeRecolhe.Caption := IIF(FBlnExpandido,'Recolher('+IntToStr(FDicFrames.Count)+')','Expandir('+IntToStr(FDicFrames.Count)+')');
    pReordenaFrames;  // Mantém a reordenação
  End;
end;

procedure TGerenciaExprAltGlobal.pReordenaFrames;
var
  i: Integer;
begin
  for i := MAX_EXPR  downto 1 do
  begin
    if FDicFrames.ContainsKey(i) then
    begin
      FDicFrames[i].Parent := nil;
    end;
  end;

  for i := 1 to MAX_EXPR  do
  begin
    if FDicFrames.ContainsKey(i) then
    begin
      FDicFrames[i].Parent := FPanelContainer;
      FDicFrames[i].Align  := alTop;

      FDicFrames[i].shpDireita.Visible  := False;
      FDicFrames[i].shpEsquerda.Visible := False;
      FDicFrames[i].shpTopo.Visible     := False;
      FDicFrames[i].shpRodape.Visible   := False;

      If (i = 1) Then
      Begin
        FDicFrames[i].shpDireita.Visible  := IIF(FBlnExpandido, True, False);
        FDicFrames[i].shpEsquerda.Visible := FDicFrames[i].shpDireita.Visible;
        FDicFrames[i].shpTopo.Visible     := FDicFrames[i].shpDireita.Visible;
        FDicFrames[i].shpRodape.Visible   := FDicFrames[i].shpDireita.Visible;
      End;

      If (i > 1) And  (i <= FDicFrames.Count) Then
      Begin
        FDicFrames[i].shpDireita.Visible  := True;
        FDicFrames[i].shpEsquerda.Visible := True;
      End;

      // Último item com borda inferior
      If (i = FDicFrames.Count) And (FDicFrames.Count > 1) Then
      Begin
        FDicFrames[FIntUltimaTagAdicionada].shpDireita.Visible  := True;
        FDicFrames[FIntUltimaTagAdicionada].shpEsquerda.Visible := True;
        FDicFrames[FIntUltimaTagAdicionada].shpTopo.Visible     := False;
        FDicFrames[FIntUltimaTagAdicionada].shpRodape.Visible   := IIF(FBlnExpandido, True, False);  // Só mostra rodapé se expandido
      End;

      If FDicFrames[i].btnRemoverFrame.Visible Then
      Begin
        FDicFrames[i].btnRemoverFrame.Visible := False;
        FDicFrames[i].btnRemoverFrame.Visible := True;
      End;
    end;
  end;

  // Força o Panel a reorganizar os controles
  FPanelContainer.Realign;
end;

procedure TGerenciaExprAltGlobal.pSetCarregandoCadInt(AblnVal: Boolean);
var
  intTag: Integer;
begin
  FBlnCarregandoCadInt := AblnVal;
  For intTag In FDicFrames.Keys Do
    FDicFrames[intTag].blnCarregandoCadInt := AblnVal;
end;

function TGerenciaExprAltGlobal.fCampoEstaSendoUsado(AStrNomeCampo: String; AIntTagFrameIgnorar: Integer = -1): Boolean;
var
  I: Integer;
  strCampoAtual: String;
begin
  Result := False;

  // Percorre todos os frames
  for I := 1 to MAX_EXPR  do
  begin
    if FDicFrames.ContainsKey(I) then
    begin
      // Se for o frame que estamos ignorando (geralmente o próprio frame)
      if (AIntTagFrameIgnorar > -1) and (I = AIntTagFrameIgnorar) then
        Continue;

      strCampoAtual := FDicFrames[I].fGetCampoSelecionado; // Você precisa criar este método no frame

      // Se já existe o mesmo campo selecionado em outro frame
      if (strCampoAtual = AStrNomeCampo) and (AStrNomeCampo <> '') then
      begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

procedure TGerenciaExprAltGlobal.pAdicionaCampoNaLista(AStrNomeCampo: String; AIntTagFrame: Integer);
var
  strRegistro: String;
begin
  if AStrNomeCampo = '' then
    Exit;

  // Remove qualquer registro existente para este frame
  pRemoveCampoDaListaPorTag(AIntTagFrame);

  // Adiciona o novo registro no formato "TAG|NOME_CAMPO"
  strRegistro := Format('%d|%s', [AIntTagFrame, AStrNomeCampo]);
  FStlCamposUsados.Add(strRegistro);
end;

procedure TGerenciaExprAltGlobal.pRemoveCampoDaListaPorTag(AIntTagFrame: Integer);
var
  I: Integer;
  strPrefix: String;
begin
  strPrefix := Format('%d|', [AIntTagFrame]);

  for I := FStlCamposUsados.Count - 1 downto 0 do
  begin
    if Pos(strPrefix, FStlCamposUsados[I]) = 1 then
    begin
      FStlCamposUsados.Delete(I);
      Break;
    end;
  end;
end;

procedure TGerenciaExprAltGlobal.pLimparListaCamposUsados;
begin
  FStlCamposUsados.Clear;
end;

procedure TGerenciaExprAltGlobal.pOnCampoSelecionadoNoFrame(AStrCampo: String; ATagFrame: Integer; var ABlnPodeSelecionar: Boolean);
begin
  // Verifica se o campo já está sendo usado por outro frame
  if fCampoEstaSendoUsado(AStrCampo, ATagFrame) then
  begin
    pMensagemOk('O campo já está sendo utilizado em outra expressão!');
    ABlnPodeSelecionar := False;
  end
  else
  begin
    ABlnPodeSelecionar := True;
    // Adiciona o campo na lista de campos usados
    pAdicionaCampoNaLista(AStrCampo, ATagFrame);
  end;
end;

procedure TGerenciaExprAltGlobal.pOnFrameDestroy(ATagFrame: Integer);
begin
  // Remove todos os campos associados a este frame da lista de campos usados
  pRemoveCampoDaListaPorTag(ATagFrame);
end;

end.
