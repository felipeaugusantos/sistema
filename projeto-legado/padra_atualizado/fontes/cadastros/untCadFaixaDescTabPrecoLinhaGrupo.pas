unit untCadFaixaDescTabPrecoLinhaGrupo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, EditFocus, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  untTFaixaDescTabPrecoLinhaGrupo.Classes, ComboBoxFocus, DBComboBoxFocus, dxScreenTip,
  dxCustomHint, cxHint, QColorLabel;

type
  TfrmCadFaixaDescTabPrecoLinhaGrupo = class(TfrmPaiCad)
    pnlGrid: TPanel;
    Label12: TLabel;
    dbgDados: TDBGridCitel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    edtDesIni: TEditFocus;
    edtDesFin: TEditFocus;
    edtComPra: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    edtComVis: TEditFocus;
    pnlLinhaGrupo: TPanel;
    pnlLinhaGrupoFiltro: TPanel;
    Label5: TLabel;
    edtDescLinhaGrupo: TEditFocus;
    btnAddLinhaGrupo: TBitBtnLocked;
    edtLinhaGrupo: TEditFocus;
    pnlLinhaGrupoGrid: TPanel;
    Label6: TLabel;
    grdLinhaGrupo: TcxGridCitel;
    grdLinhaGrupoDBTable: TcxGridDBTableViewCitel;
    grdLinhaGrupoDBTableViewCitelFTG_CODGRU: TcxGridDBColumn;
    grdLinhaGrupoDBTableViewCitelGRU_DESGRU: TcxGridDBColumn;
    grdLinhaGrupoLevel1: TcxGridLevel;
    pnlTopo: TPanel;
    Label1: TLabel;
    Label7: TLabel;
    dbeCodTab: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dtsComFat: TDataSource;
    dtsDados: TDataSource;
    dtsLinhaGrupo: TDataSource;
    Label9: TLabel;
    dbeTabPre: TDBEditFocus;
    clbPrcVenda: TColorLabel;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodTabExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgDadosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdLinhaGrupoDBTableKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAddLinhaGrupoClick(Sender: TObject);

    procedure edtLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    objComissao  : TComissaoFaixaDescTabPrecoLinhaGrupoBuilder;
    blnUsaProCod : Boolean;
    strVrfTpr    : string;

    procedure pLimpaCampos;
    procedure pCarregaTabelaPrecos;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; Override;
  end;

implementation

uses untCadGru, untPesqAux, untFuncoesSimples, untTypesSistema,
     Uni, untConsultas, untConstantes, StrUtils;

{$R *.dfm}

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.FormCreate(Sender: TObject);
begin
  inherited;
  {Se resolução disponível for inferior ou igual à (1366 x 768), ajusta a tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;
end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objComissao);
  inherited;
end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.FormShow(Sender: TObject);
begin
  objComissao := TComissaoFaixaDescTabPrecoLinhaGrupoBuilder.Create(Self);

  strNomeTabela     := 'COMFLG';
  strNomeCampo      := 'COM_CODTAB';
  qryTabela         := objComissao.qryTabela;
  dtsComFat.DataSet := qryTabela;

  dtsDados.DataSet  := objComissao.cdsDados;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodTab;

  blnUsaProCod := fUsaProCodigo('COMFLG');
  pHabilitaCodigo(dbeCodTab, dbeCodTab, Not blnUsaProCod);
  objComissao.blnUsaProCod := blnUsaProCod;

  objComissao.pCarregaDadosLinhaGrupo;
  dtsLinhaGrupo.DataSet := objComissao.cdsLinhaGrupo;

  pCarregaTabelaPrecos;

  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.pCarregaTabelaPrecos;
  Var
    intCon: Integer;
begin
  strVrfTpr := EmptyStr;
  clbPrcVenda.Caption := EmptyStr;

  For intCon:= 1 To Length(Trim(VS_strTabPrc)) Do
  Begin
    strVrfTpr := strVrfTpr + IfThen(SameText(VS_strTabPrc[intCon], 'S'), IntToStr(intCon), '');
    If (VS_strTabPrc[intCon] = 'S') Then
    Begin
      If intCon <> Length(Trim(VS_strTabPrc)) Then
        clbPrcVenda.Caption := clbPrcVenda.Caption + ' (' + IntToStr(intCon) + ')'
      Else
        clbPrcVenda.Caption := clbPrcVenda.Caption + ' (' + IntToStr(intCon) + ')';
    End;
  End;
end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COM_CODTAB');
  stlCampos.Add('COM_DESCRI');
  stlCampos.Add('COM_DESINI');
  stlCampos.Add('COM_DESFIM');
  stlCampos.Add('COM_COMAVI');
  stlCampos.Add('COM_COMAPR');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COM_CODTAB+COM_DESINI+COM_DESFIM');
  stlCamInd.Add('COM_DESCRI');
  stlCamInd.Add('COM_CODTAB');

  stlDesInd.Add('Código/Desconto Inicial/Desconto Final');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
  objComissao.cdsDados.EmptyDataSet;
  objComissao.cdsLinhaGrupo.EmptyDataSet;

  objComissao.objTipoAcao := aoInserindo;
  If blnUsaProCod Then
    pSetFocus(dbeDescricao)
  Else
    pSetFocus(dbeCodTab);
end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
  objComissao.objTipoAcao := aoEditando;
  pHabilitaCodigo(dbeCodTab, dbeCodTab, Not blnUsaProCod);
  If blnUsaProCod Then
    pSetFocus(dbeDescricao)
  Else
    pSetFocus(dbeCodTab);
end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.pLimpaCampos;
begin
  edtDesIni.Text         := '0,000';
  edtDesFin.Text         := '0,000';
  edtComVis.Text         := '0,000';
  edtComPra.Text         := '0,000';
  edtLinhaGrupo.Text     := '';
  edtDescLinhaGrupo.Text := '';
  objComissao.AutInc     := '';
end;

function TfrmCadFaixaDescTabPrecoLinhaGrupo.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  var
    LMensagem : String;
    LQuery    : TUniQuery;
begin
  Result := True;

  Try

    If Sender = dbeCodTab Then
    Begin
      objComissao.CodigoTabela := dbeCodTab.Text;
      If fEmptyStr(dbeCodTab.Text) And (Not blnUsaProCod) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If Sender = dbeDescricao Then
    Begin
      objComissao.Descricao := dbeDescricao.Text;
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End
    Else If Sender = edtDesIni Then
    Begin
      Result := objComissao.fValidaDesconto(fStrToFloat(edtDesIni.Text));
      objComissao.DescontoInicial := fStrToFloat(edtDesIni.Text);
    End
    Else If Sender = edtDesFin Then
    Begin
      Result := objComissao.fValidaDesconto(fStrToFloat(edtDesFin.Text));
      objComissao.DescontoFinal := fStrToFloat(edtDesFin.Text);
    End
    Else If (Sender = edtComVis) Then
    Begin
      objComissao.ComissaoVista := fStrToFloat(edtComVis.Text);
      If (fStrToFloat(edtComVis.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O % de Comissão deve ser maior que zero!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtComPra) Then
    Begin
      objComissao.ComissaoPrazo := fStrToFloat(edtComPra.Text);
      If (fStrToFloat(edtComPra.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O % de Comissão deve ser maior que zero!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeTabPre) Then
    Begin
      If fEmptyStr(dbeTabPre.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Tabela de Preço deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      else If Pos( dbeTabPre.Text, strVrfTpr ) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Tabela de Preço deve ser ' + clbPrcVenda.Caption + '!', ['&Ok']);
        Result := False;
      End
      else
      begin
        if not objComissao.fValidarTabelaPreco(dbeCodTab.Text, dbeTabPre.Text, LMensagem) then
        Begin
          fMensagem('ATENÇÃO!', LMensagem, ['&Ok']);
          Result := False;
        End;
      end;

      objComissao.CodigoTabelaPreco := dbeTabPre.Text;
    End
   Else If (Sender = edtLinhaGrupo) Then
    Begin
      If fEmptyStr(edtLinhaGrupo.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Linha / Grupo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Not fValidaLinhaGrupoCadGru(edtLinhaGrupo.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha não é permitida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        LQuery := fCriaQuery(Nil);
        Try
          pPesquisaLinGru(LQuery, LQuery, edtLinhaGrupo.Text);
          With LQuery Do
          Begin
            edtDescLinhaGrupo.Text := LQuery.FieldByName('GRU_DESGRU').AsString;
          End;
        Finally
          FreeAndNil(LQuery);
        End;

        If fEmptyStr(edtDescLinhaGrupo.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse grupo não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;

      if objComissao.fValidarLinhaGrupoJaExiste(edtLinhaGrupo.Text, LMensagem) then
      begin
        fMensagem('ATENÇÃO!', LMensagem, ['&Ok']);
        Result := False;
      end;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadFaixaDescTabPrecoLinhaGrupo.fValidaCampos]');
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.grdLinhaGrupoDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
    Case Key Of
    VK_DELETE:
      If btnGravar.Enabled Then
      begin
        objComissao.pExcluiLinhaGrupo;
        grdLinhaGrupoDBTable.ApplyBestFit();
      end;
    VK_ESCAPE: pEscapePressed;
  End;
end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.dbgDadosDblClick(Sender: TObject);
begin
  inherited;
  If btnGravar.Enabled Then
  Begin
    edtDesIni.Text        := FormatFloat('#,##0.000', objComissao.cdsDados.FieldByName('COM_DESINI').AsFloat);
    edtDesFin.Text        := FormatFloat('#,##0.000', objComissao.cdsDados.FieldByName('COM_DESFIM').AsFloat);
    edtComVis.Text        := FormatFloat('#,##0.000', objComissao.cdsDados.FieldByName('COM_COMAVI').AsFloat);
    edtComPra.Text        := FormatFloat('#,##0.000', objComissao.cdsDados.FieldByName('COM_COMAPR').AsFloat);
    objComissao.AutInc    := objComissao.cdsDados.FieldByName('AUTOINCREM').AsString;
    pSetFocus(edtDesIni);
    Application.ProcessMessages;
  End;
end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.dbgDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE: If btnGravar.Enabled Then objComissao.pDeletaItem;
    VK_ESCAPE: pEscapePressed;
    VK_RETURN: dbgDadosDblClick(Sender);
  End;

end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.edtLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrGrupos: TConsultasArray;
    LqryConGru : TUniQuery;
begin
  inherited;
  LqryConGru := fCriaQuery(Nil);
  If fPesqGrupo(Self, edtLinhaGrupo, Nil, LqryConGru, Key, arrGrupos) Then
  Begin
    If fValidaCampos(edtLinhaGrupo) Then
      SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(LqryConGru);
end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.btnGravarClick(Sender: TObject);
  var
    LMensagem : String;
begin
//  inherited;

  Try
    pnlInfo.Caption := 'Gravando registro! Aguarde....';
    If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
    Begin
      If blnUsaProCod And (qryTabela.State = dsInsert) And fEmptyStr(dbeCodTab.Text) Then
      Begin
        dbeCodTab.Text := fPadL(fAtualizaProCod('COMFLG', ''), fRetTamCampo('COMFLG'), '0');

        While objComissao.fExisteProCodCadastrado(dbeCodTab.Text) Do
          dbeCodTab.Text := fPadL(fAtualizaProCod('COMFLG', ''), fRetTamCampo('COMFLG'), '0');

        objComissao.CodigoTabela := dbeCodTab.Text;
      End;

      If (fValidaCampos(dbeCodTab)) And
         (fValidaCampos(dbeDescricao))And
         (fValidaCampos(dbeTabPre)) Then
      Begin
        if not objComissao.fAtualizaRegistros(LMensagem) then
        begin
          pMensagemOk(LMensagem);
          pnlInfo.Caption := '';
          Exit;
        end;

        objComissao.cdsDados.ApplyUpdates(0);
        objComissao.pSalvarDadosLinhaGrupo;

        qryTabela.Cancel;
        objComissao.pAtualizaTabela;

        pOnStateChange;
        pEnabled(Self, False);
        If btnIncluir.CanFocus Then
          pSetFocus(btnIncluir)
        Else If btnPesquisa.CanFocus Then
          pSetFocus(btnPesquisa);

        blnGravou := True;
      End;

      pLimpaCampos;
      pnlInfo.Caption := '';
    End;
  Except
    On E: EUniError Do
    Begin
      If E.ErrorCode = ERROR_PRIMARY_KEY_INSERT Then
      Begin
        pMensagensErro(E.Message, '[TfrmCadFaixaDescTabPrecoLinhaGrupo.btnGravarClick]');
      End
      Else
      Begin
        pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[ Gravar registro ]');
      End;
      blnGravou := False;
    End;

    On E: Exception Do
    Begin
      blnGravou := False;
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, '[TfrmCadFaixaDescTabPrecoLinhaGrupo.btnGravarClick]');
    End;
  End;

end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.btnAddLinhaGrupoClick(
  Sender: TObject);
  var
    LMensagem : String;
begin
  inherited;
  If (Not btnGravar.Enabled) or (fEmptyStr(edtLinhaGrupo.Text)) Then
    Exit;

  Try
    If fValidaCampos(edtLinhaGrupo) And
       fValidaCampos(dbeTabPre) Then
    Begin
      objComissao.CodigoTabela      := dbeCodTab.Text;
      objComissao.CodigoLinhaGrupo  := edtLinhaGrupo.Text;
      objComissao.NomeLinhaGrupo    := edtDescLinhaGrupo.Text;
      objComissao.CodigoTabelaPreco := dbeTabPre.Text;
      if not objComissao.fAdicionarLinhaGrupo(LMensagem) then
      begin
        fMensagem('AVISO', LMensagem, ['&Ok']);
        Exit;
      end;
      pLimpaCampos;
      pSetFocus(edtLinhaGrupo);
      grdLinhaGrupoDBTable.ApplyBestFit();
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadFaixaDescTabPrecoLinhaGrupo.btnAddMecanico]');
    End;
  End;

end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If Not btnGravar.Enabled Then
    Exit;

  Try
    objComissao.CodigoTabela      := dbeCodTab.Text;
    objComissao.Descricao         := dbeDescricao.Text;
    objComissao.CodigoTabelapreco := dbeTabPre.Text;
    objComissao.DescontoInicial   := fStrToFloat(edtDesIni.Text);
    objComissao.DescontoFinal     := fStrToFloat(edtDesFin.Text);
    objComissao.ComissaoVista     := fStrToFloat(edtComVis.Text);
    objComissao.ComissaoPrazo     := fStrToFloat(edtComPra.Text);

    If (Not fEmptyStr(objComissao.AutInc)) Then
      objComissao.pAlteraDados
    Else
      objComissao.pInsereDados;

    pLimpaCampos;
    pSetFocus(edtDesIni);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadFaixaDescTabPrecoLinhaGrupo.btnAdicionarClick]');
    End;
  End;

end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.btnCancelaClick(Sender: TObject);
begin
  inherited;
  objComissao.pAtualizaDados;
  dtsLinhaGrupo.DataSet := objComissao.cdsLinhaGrupo;
  pLimpaCampos;
end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
    qryPesq: TUniQuery;
begin
  chrKey := '/';
  qryPesq := fCriaQuery(Self);

  if fPesqComissaoFat(conSimples,
                     Self,
                     nil,
                     nil,
                     qryPesq,
                     chrKey,
                     arrsel,
                     True,
                     'Faixas de Desconta por Tabela de Preço por Linha\Grupo',
                     'COMFLG') then
  Begin
    If (qryPesq.Active) And (Not qryPesq.IsEmpty) Then
    Begin
      With qryTabela Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM COMFLG WHERE COM_CODTAB = :CODTAB');
        ParamByName('CODTAB').AsString := qryPesq.FieldByName('COM_CODTAB').AsString;
        Open;
      End;

      If (Not qryTabela.IsEmpty) Then
      begin
        objComissao.pAtualizaDados;
        dtsLinhaGrupo.DataSet := objComissao.cdsLinhaGrupo;
        grdLinhaGrupoDBTable.ApplyBestFit();
      end;
    End
    Else
      objComissao.cdsDados.EmptyDataSet;

    pLimpaCampos;
    pSetFocus(btnAlterar);
  End;

  FreeAndNil(qryPesq);
end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.btnExcluirClick(Sender: TObject);
begin
  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
  Begin
    objComissao.objTipoAcao  := aoDeletando;
    objComissao.CodigoTabela := dbeCodTab.Text;
    If objComissao.fExcluiRegistro Then
    Begin
      objComissao.cdsDados.EmptyDataSet;
      objComissao.cdsLinhaGrupo.EmptyDataSet;
      qryTabela.Close;
      qryTabela.Open;
      pLimpaCampos;
    End;
  End;
end;

procedure TfrmCadFaixaDescTabPrecoLinhaGrupo.dbeCodTabExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(dbeCodTab.Text) Then
  begin
    objComissao.pAtualizaDados;
    dtsLinhaGrupo.DataSet := objComissao.cdsLinhaGrupo;
  end;

end;

end.
