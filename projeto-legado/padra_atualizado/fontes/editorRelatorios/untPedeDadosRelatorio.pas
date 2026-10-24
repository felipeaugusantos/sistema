unit untPedeDadosRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxEdit, cxTextEdit, cxVGrid, cxInplaceContainer, cxClasses,
  untInterfaceRelatorio, cxRadioGroup, cxDropDownEdit, cxCheckBox, cxCalendar,
  cxMaskEdit, DB, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxProgressBar, untGravando, Clipbrd, untCfgRel;

type
  TfrmPedeDadosRelatorio = class(TfrmPaiEdit)
    cxsrConsulta: TcxStyleRepository;
    cxStyleTitulo: TcxStyle;
    cxStyleEven: TcxStyle;
    cxStyleSort: TcxStyle;
    cxStyleContent: TcxStyle;
    cxStyleHeader: TcxStyle;
    cxvFiltros: TcxVerticalGrid;
    cxStyleVerVer: TcxStyleRepository;
    cxStyleVermelho: TcxStyle;
    cxStyleVermelhoSelec: TcxStyle;
    cxStyleVerde: TcxStyle;
    cxStyleVerdeSelec: TcxStyle;
    cxStyleTituloBold: TcxStyle;
    cxStyleTituloBoldSelection: TcxStyle;
    cxStyleTituloSelection: TcxStyle;
    cxStyleCategory: TcxStyle;
    cxStyleCombo: TcxStyle;
    cxStyleComplemento: TcxStyle;
    cxStyleTituloComplemento: TcxStyle;
    btnReseta: TBitBtnLocked;
    cxStyleReadOnly: TcxStyle;
    btnSalvarFiltros: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    btnGerarLinhaComando: TBitBtnLocked;
    btnExpFil: TBitBtnLocked;
    btnImpFil: TBitBtnLocked;
    popFiltros: TPopupMenu;
    mnuSelecionartodos: TMenuItem;
    mnuDesmarcaTodos: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnSalvarFiltrosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxvFiltrosKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfigurarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure cxvFiltrosItemChanged(Sender: TObject; AOldRow: TcxCustomRow;
      AOldCellIndex: Integer);
    procedure FormCreate(Sender: TObject);
    procedure cxvFiltrosMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cxvFiltrosMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cxvFiltrosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxvFiltrosEdited(Sender: TObject;
      ARowProperties: TcxCustomEditorRowProperties);
    procedure btnResetaClick(Sender: TObject);
    procedure btnGerarLinhaComandoClick(Sender: TObject);
    procedure btnExpFilClick(Sender: TObject);
    procedure btnImpFilClick(Sender: TObject);
    procedure mnuSelecionartodosClick(Sender: TObject);
    procedure mnuDesmarcaTodosClick(Sender: TObject);
  private
    { Private declarations }
    FLarguraBotoes: Integer;

    procedure pMarcaDesmarcaTodos(blnMarcar: Boolean);

    procedure pFocoInicio(blnFocoInicio: Boolean = True);
    procedure pFormShow(blnFocoInicio: Boolean = True);
    function fRestauraFiltrosPadrao(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pRemoveDestinosGatilho;
    procedure pVerificaFila;

    Function fCriaBotoesTelaFiltros: Boolean;

    procedure pLimitaTamanhoTela;

  public
    { Public declarations }
    blnValidarObrigatorio: Boolean;
    objInteface: TInterfaceRelatorio;
  end;

implementation

{$R *.dfm}

Uses
  cxCheckComboBox,
  untFuncoesSimples, untFuncoesRel, untCadConfRelatorios, untConstantes;

Const
  INT_ESPACAMENTO_BOTAO = 1;

procedure TfrmPedeDadosRelatorio.btnImpFilClick(Sender: TObject);
begin
  inherited;
  objInteface.pImportaFiltros;
end;

procedure TfrmPedeDadosRelatorio.btnConfigurarClick(Sender: TObject);
begin
  inherited;

  Try
    if (Not fVerificaAcessoSistema('FrmCadConfRelatorios', strLoginUsuarioLogado)) then
    begin
      pMensagemOk('Usuário sem direito de acesso a esta opção!');
      Exit;
    end;

    pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);

    frmCadConfRelatorios.strNomeForm := objInteface.strIdentRel;

    frmCadConfRelatorios.showModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmPedeDadosRelatorio.btnConfigurarClick]');
    End;
  End;
  pFreeAndNil(frmCadConfRelatorios);

end;

procedure TfrmPedeDadosRelatorio.btnExpFilClick(Sender: TObject);
begin
  inherited;

  objInteface.pExportaFiltros;
end;

procedure TfrmPedeDadosRelatorio.btnGerarLinhaComandoClick(Sender: TObject);
  Var
    strLinha : String;
begin
  inherited;

  strLinha := objInteface.strLinhaComando;

  If strLinha = '' Then
    Exit;

  Clipboard.AsText := strLinha;
  pMensagemOk('Linha de Comando copiada para Área de Transferência');
end;

procedure TfrmPedeDadosRelatorio.btnImprimirClick(Sender: TObject);
begin
  inherited;

  Try
    blnValidarObrigatorio := False;

    If objInteface.fExecutaRelatorio Then
    Begin
      pFocoInicio;

      If objInteface.blnDestinoJson Then
        Close;

      PostMessage(objInteface.HndSelPedidoCompra,WM_EXECUTOUEXPORTACAO, 0, 0);

      If objInteface.fecharJanelaDeDadosAoImprimir then
        Close;
    End;

   Except
     On E: Exception Do
     Begin
       pMensagensErro(E.Message, 'TfrmPedeDadosRelatorio.btnImprimirClick');
     End;
   End;

  blnValidarObrigatorio := True;
end;

function TfrmPedeDadosRelatorio.fRestauraFiltrosPadrao(pgbStatus: TcxProgressBar): Boolean;
var
  intWidth: Integer;
  intHeight: Integer;
begin
  intWidth := Width;
  intHeight := Height;

  try
    with objInteface do
    begin
      pApagaCadVal(arrCadRel[0].FieldByName('AUTOINCREM').AsString);
      blnValidarObrigatorio := False;
      cxvFiltros.ClearRows;
      blnValidarObrigatorio := True;
      pPedeDados(False, True);
      pFormShow(False);
      Width := intWidth;
      Height := intHeight;
    end;
  finally
    Result := True;
  end;
end;

procedure TfrmPedeDadosRelatorio.mnuDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  pMarcaDesmarcaTodos(False);
end;

procedure TfrmPedeDadosRelatorio.mnuSelecionartodosClick(Sender: TObject);
begin
  inherited;

  pMarcaDesmarcaTodos(True);
end;

procedure TfrmPedeDadosRelatorio.btnResetaClick(Sender: TObject);
var
  LfrmGravando : TfrmGravando;
begin
  inherited;

  if fPergunta('Deseja restaurar os valores padrão dos filtros?') then
  begin
    try
      pCriarFormularios(TfrmGravando, LfrmGravando);
      LfrmGravando.lblGravando.Caption := 'Restaurando valores padrão dos filtros...';
      LfrmGravando.pgbStatus.Visible := False;
      LfrmGravando.fExecutarAcao := fRestauraFiltrosPadrao;
      LfrmGravando.ShowModal;
    except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[TfrmPedeDadosRelatorio.btnResetaClick]');
      end;
    end;

    pFreeAndNil(LfrmGravando);
  end;
end;

procedure TfrmPedeDadosRelatorio.btnSalvarFiltrosClick(Sender: TObject);
begin
  inherited;
  Try
    blnValidarObrigatorio := False;
    Try
      If objInteface.fSalvarFiltrosRelatorio Then
      Begin
        Self.Close;
        ModalResult := mrOk;
      End;
    Finally
      blnValidarObrigatorio := True;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TfrmPedeDadosRelatorio.btnSalvarFiltrosClick');
  End;
end;

procedure TfrmPedeDadosRelatorio.cxvFiltrosEdited(Sender: TObject;
  ARowProperties: TcxCustomEditorRowProperties);
begin
  inherited;

  objInteface.fVeSeExecutaComFil(TcxEditorRow(cxvFiltros.FocusedRow).Name);

end;

procedure TfrmPedeDadosRelatorio.cxvFiltrosItemChanged(Sender: TObject;
  AOldRow: TcxCustomRow; AOldCellIndex: Integer);
begin
  inherited;

  If blnValidarObrigatorio And
     Assigned(AOldRow) And
     (Not AOldRow.IsCategory) And
     (TcxEditorRow(AOldRow).Tag = 1) And
     (Not objInteface.fValidaDado(TcxEditorRow(AOldRow).AbsoluteIndex)) Then
  Begin
    blnValidarObrigatorio := False;
    cxvFiltros.FocusRow(AOldRow);
    blnValidarObrigatorio := True;
    Exit;
  End;

  If Not Assigned(cxvFiltros.FocusedRow) Then
    Exit;

  If Not Assigned(TcxEditorRow(cxvFiltros.FocusedRow).Styles) Then
    Exit;

  If TcxEditorRow(cxvFiltros.FocusedRow).Styles.Header = Self.cxStyleVermelho Then
    cxvFiltros.Styles.Selection := cxStyleVermelhoSelec

  Else If TcxEditorRow(cxvFiltros.FocusedRow).Styles.Header = Self.cxStyleVerde Then
    cxvFiltros.Styles.Selection := cxStyleVerdeSelec

  Else If TcxEditorRow(cxvFiltros.FocusedRow).Styles.Header = Self.cxStyleTituloBold Then
    cxvFiltros.Styles.Selection := cxStyleTituloBoldSelection

  Else
    cxvFiltros.Styles.Selection := cxStyleTituloSelection;

  If Assigned(AOldRow) And
     (Not AOldRow.IsCategory) Then
  Begin
    If TcxEditorRow(AOldRow).Properties.Options.Editing Then
      TcxEditorRow(AOldRow).Styles.Content := Nil
    Else
      TcxEditorRow(AOldRow).Styles.Content := cxStyleReadOnly;
  End;

  If (Not cxvFiltros.FocusedRow.IsCategory) And
     TcxEditorRow(cxvFiltros.FocusedRow).Properties.Options.Editing And
     ((TcxEditorRow(cxvFiltros.FocusedRow).Properties.EditPropertiesClass = TcxComboBoxProperties) Or
      (TcxEditorRow(cxvFiltros.FocusedRow).Properties.EditPropertiesClass = TcxDateEditProperties)) Then
    TcxEditorRow(cxvFiltros.FocusedRow).Styles.Content := cxStyleCombo;

  If Assigned(AOldRow) And (Not AOldRow.IsCategory) Then
  Begin
    objInteface.pAvaliaComboBoxConfig(AOldRow.Name);
    objInteface.pAvaliaSQLVisibilParametro(AOldRow.Name);

    If TcxEditorRow(AOldRow).Properties.EditPropertiesClass <> TcxComboBoxProperties Then
      objInteface.pAvaliaCheckListCustomizado(AOldRow.Name);
  End;

  If Assigned(cxvFiltros.FocusedRow) And (Not cxvFiltros.FocusedRow.IsCategory) Then
  Begin
    If TcxEditorRow(cxvFiltros.FocusedRow).Properties.EditPropertiesClass = TcxCheckComboBoxProperties Then
    Begin
      cxvFiltros.PopupMenu := popFiltros;
      pnlNomeForm.Caption := '<Alt + T/S> Marca/Desmarca todos';
    End Else
    Begin
      cxvFiltros.PopupMenu := Nil;
      pnlNomeForm.Caption := Self.Name;
    End;
  End;
end;

procedure TfrmPedeDadosRelatorio.cxvFiltrosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  objInteface.pKeyDown(Sender, Key, Shift);
end;

procedure TfrmPedeDadosRelatorio.cxvFiltrosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  objInteface.pKeyPress(Key);
end;

procedure TfrmPedeDadosRelatorio.cxvFiltrosMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  blnValidarObrigatorio := False;
end;

procedure TfrmPedeDadosRelatorio.cxvFiltrosMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  blnValidarObrigatorio := True;
end;

procedure TfrmPedeDadosRelatorio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  objInteface.intAlturaTela  := Height;
  objInteface.intLarguraTela := Width;

  objInteface.intValWid      := cxvFiltros.OptionsView.ValueWidth;
  objInteface.intHeaWid      := cxvFiltros.OptionsView.RowHeaderWidth;

  If Assigned(objInteface.arrCadRel[0]) And Assigned(objInteface.arrCadRel[0].FindField('AUTOINCREM')) Then
    objInteface.pSalvaValores(objInteface.arrCadRel[0].FieldByName('AUTOINCREM').AsString);
end;

procedure TfrmPedeDadosRelatorio.FormCreate(Sender: TObject);
begin
  inherited;

  FLarguraBotoes := btnImprimir.Width + INT_ESPACAMENTO_BOTAO + btnSair.Width + INT_ESPACAMENTO_BOTAO + btnExpFil.Width + INT_ESPACAMENTO_BOTAO +
                    btnImpFil.Width + INT_ESPACAMENTO_BOTAO;

  blnValidarObrigatorio := True;
end;

procedure TfrmPedeDadosRelatorio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  Case Key Of
    VK_RETURN: Begin
                 If cxvFiltros.FocusedRow = cxvFiltros.LastVisibleRow Then
                   pSetFocus(btnImprimir);
               End;
    76:        Begin
                 If (Shift = [ssAlt]) Then
                   btnReseta.Click;
               End;

    83: If (Shift = [ssAlt]) Then
          pMarcaDesmarcaTodos(False);

    84: If (Shift = [ssAlt]) Then
          pMarcaDesmarcaTodos(True);
  End;

  If (Key <> VK_RETURN) and (Key <> VK_ESCAPE) Then
    objInteface.objRotinasFiltro.pExecutaRotinaTeclaAtalho(Key, Shift, Self.FlwBotoes);

  inherited;
end;

procedure TfrmPedeDadosRelatorio.FormResize(Sender: TObject);
begin
  inherited;

  If Width < 500 Then
    Width := 500;

  pLimitaTamanhoTela;
end;

procedure TfrmPedeDadosRelatorio.pLimitaTamanhoTela;
Begin
  If WindowState = wsMaximized Then
    Exit;

  If Width > Screen.Width - 50 Then
    Width := Screen.Width - 50;

  If Height > Screen.Height - 50 Then
    Height := Screen.Height - 50;
end;

Function TfrmPedeDadosRelatorio.fCriaBotoesTelaFiltros: Boolean;
Begin
  If Assigned(objInteface) And Assigned(objInteface.objRotinasFiltro) Then
  Begin
    objInteface.objRotinasFiltro.pCriaBotoes(Self, Self.FlwBotoes, Nil, Nil);
    FLarguraBotoes := FLarguraBotoes + objInteface.objRotinasFiltro.intLarguraBotoes;
  End;

  Result := True;
End;

procedure TfrmPedeDadosRelatorio.pFormShow(blnFocoInicio: Boolean = True);
  Var
    intCliWidth,
    intCliHeigth: Integer;
begin
  try
    blnPassarRadioButtonComEnter := False;

    fCriaBotoesTelaFiltros;

    pFocoInicio(blnFocoInicio);

    If objInteface.intAlturaTela > 0 Then
    Begin
      Height := objInteface.intAlturaTela;
      Width  := objInteface.intLarguraTela;

      If objInteface.intValWid > 0 Then
        cxvFiltros.OptionsView.ValueWidth     := objInteface.intValWid;

      If objInteface.intHeaWid > 0 Then
        cxvFiltros.OptionsView.RowHeaderWidth := objInteface.intHeaWid;

      cxvFiltros.OptionsView.ScrollBars := ssNone;
    End;

    If (Not (Assigned(objInteface.arrCadRel[0]) And (objInteface.arrCadRel[0].State In [dsEdit, dsInsert]))) And
       (Not (Assigned(objInteface.objRelatorioRetorno) And objInteface.objRelatorioRetorno.blnExecutandoPeloBotao And
             objInteface.objRelatorioRetorno.blnPaiEmEdicao)) Then
    Begin
      intCliWidth  := ClientWidth;
      intCliHeigth := ClientHeight;

      BorderStyle := bsDialog;

      cxvFiltros.OptionsBehavior.BandSizing   := False;
      cxvFiltros.OptionsBehavior.HeaderSizing := False;

      ClientWidth  := intCliWidth;
      ClientHeight := intCliHeigth;
    End;

    objInteface.fVeSeExecutaComFilShow;

    objInteface.pAvaliaParametrosShow;

    pnlInfo.Alignment := taLeftJustify;
    If Assigned(objInteface.arrCadRel[0]) Then
    with objInteface.arrCadRel[0] do
    begin
      pnlInfo.Caption   := ' Rel: ' + FieldByName('REL_CODREL').AsString + IIF(FieldByName('REL_MD5NEW').AsString <> FieldByName('REL_MD5OLD').AsString, ' *', '')
                           + '   ( * ) Campos obrigatórios  ' + IIF(FieldByName('REL_PADRAO').AsString = 'S', '(Rel. Padrão)', '');
    end;

    If fUsaLayoutNovo And fUsaDoisMonitores Then
      pCentralizarForm(Self);

    btnSalvarFiltros.Visible := False;
    btnGerarLinhaComando.Visible := False;

    If objInteface.blnApenasEditarFiltros Then
    Begin
      btnReseta.Visible := False;
      btnConfigurar.Visible := False;
      btnSalvarFiltros.Visible := True;
    End;

    If objInteface.blnGerarLinhaComando Then
      btnGerarLinhaComando.Visible := True;

    If btnReseta.Visible Then
      FLarguraBotoes := FLarguraBotoes + btnReseta.Width + INT_ESPACAMENTO_BOTAO;

    If btnConfigurar.Visible Then
      FLarguraBotoes := FLarguraBotoes + btnConfigurar.Width + INT_ESPACAMENTO_BOTAO;

    If btnSalvarFiltros.Visible Then
      FLarguraBotoes := FLarguraBotoes + btnSalvarFiltros.Width + INT_ESPACAMENTO_BOTAO;

    If btnGerarLinhaComando.Visible Then
      FLarguraBotoes := FLarguraBotoes + btnGerarLinhaComando.Width + INT_ESPACAMENTO_BOTAO;

    If FLarguraBotoes > Self.ClientWidth Then
      Self.ClientWidth := FLarguraBotoes;

    If objInteface.blnEditarGatilho then
      pRemoveDestinosGatilho;

    If objInteface.blnApenasSalvar Then
    Begin
      btnImprimir.Enabled := False;
      btnImprimir.Visible := False;
    End;

    pVerificaFila;

    pLimitaTamanhoTela;
  except
    on E: Exception do
      Raise;
  end;
end;

procedure TfrmPedeDadosRelatorio.FormShow(Sender: TObject);
begin
  inherited;

  pFormShow;
end;

procedure TfrmPedeDadosRelatorio.pFocoInicio(blnFocoInicio: Boolean = True);
begin
  If Not Assigned(cxvFiltros) Then
    Exit;

  pSetFocus(cxvFiltros);

  If (cxvFiltros.Rows.Count > 0) Then
    cxvFiltros.FocusRow(cxvFiltros.Rows[0]);
end;

procedure TfrmPedeDadosRelatorio.pRemoveDestinosGatilho;
var
  intDestino: Integer;
  stlLista: TStringList;
  intContador: Integer;
begin
  If Not Assigned(cxvFiltros) Then
    Exit;

  intDestino := objInteface.intIndexDestino;

  if intDestino < 0 then
    Exit;

  stlLista   := TStringList.Create;
  stlLista.AddStrings(TcxComboBoxProperties(TcxEditorRow(cxvFiltros.Rows[intDestino]).Properties.EditProperties).Items);
  TcxComboBoxProperties(TcxEditorRow(cxvFiltros.Rows[intDestino]).Properties.EditProperties).Items.Clear;

  For intContador := 0 to stlLista.Count - 1 do
  Begin
    If (stlLista[intContador] = 'PDF')
      or (Pos('Dashboard', stlLista[intContador]) > 0)
      or (stlLista[intContador] = 'Vídeo') then
      TcxComboBoxProperties(TcxEditorRow(cxvFiltros.Rows[intDestino]).Properties.EditProperties).Items.Add(stlLista[intContador]);
  End;
end;

procedure TfrmPedeDadosRelatorio.pVerificaFila;
var
  intDestino: Integer;
  stlLista: TStringList;
  strNomImp, strTipImp: String;
begin
  If Not Assigned(cxvFiltros) Then
    Exit;

  If (not Assigned(objInteface.arrCadRel[0])) or
     (not Assigned(objInteface.arrCadRel[0].FindField('REL_FILIMP'))) or
     (objInteface.arrCadRel[0].FindField('REL_FILIMP').AsString = '') Then
    Exit;

  intDestino := objInteface.intIndexDestino;

  if intDestino < 0 then
    Exit;

  stlLista   := TStringList.Create;
  stlLista.AddStrings(TcxComboBoxProperties(TcxEditorRow(cxvFiltros.Rows[intDestino]).Properties.EditProperties).Items);

  if stlLista.IndexOf('Impressora') = -1 Then
    Exit;

  strFilRel := objInteface.arrCadRel[0].FieldByName('REL_FILIMP').AsString;

  pCarregaConfImprRel(objInteface.arrCadRel[0].FieldByName('REL_FILIMP').AsString, strNomImp, strTipImp);

  If fEmptyStr(strNomImp) Then
    Exit;

  TcxEditorRow(cxvFiltros.Rows[intDestino]).Properties.Value := 'Impressora';
end;

procedure TfrmPedeDadosRelatorio.pMarcaDesmarcaTodos(blnMarcar: Boolean);
  Var
    intContador: Integer;
begin

  If Not Assigned(cxvFiltros.FocusedRow) Then
    Exit;

  If (TcxEditorRow(cxvFiltros.FocusedRow).Properties.EditPropertiesClass = TcxCheckComboBoxProperties) Then
  Begin
    cxvFiltros.ShowEdit;

    If Assigned(cxvFiltros.InplaceEditor) Then
    Begin
      For intContador := 0 To TcxCheckComboBox(cxvFiltros.InplaceEditor).Properties.Items.Count - 1 Do
        If blnMarcar Then
          TcxCheckComboBox(cxvFiltros.InplaceEditor).States[intContador] := cbsChecked
        Else
          TcxCheckComboBox(cxvFiltros.InplaceEditor).States[intContador] := cbsUnchecked;

      TcxCheckComboBox(cxvFiltros.InplaceEditor).PostEditValue;

      objInteface.pCheckListCloseUp(cxvFiltros.InplaceEditor);
    End;
  End;
end;

end.

