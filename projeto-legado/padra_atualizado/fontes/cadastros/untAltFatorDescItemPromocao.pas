unit untAltFatorDescItemPromocao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, EditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, UniClientDataSet, Uni, UniDataSetProvider, untTypesSistema, cxProgressBar,
  StrUtils, untConstantes, untCadPromocoes,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmAltFatorDescItemPromocao = class(TfrmPaiConfirma)
    pnlDadosItem: TPanel;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lblDescricao: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Bevel1: TBevel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtDescriIni: TEditFocus;
    edtRefere: TEditFocus;
    edtCodUnidade: TEditFocus;
    edtDescriFin: TEditFocus;
    btnAplica: TBitBtnLocked;
    Bevel2: TBevel;
    dtsCadPro: TDataSource;
    cxgItens: TcxGrid;
    cxgItensDBView: TcxGridDBTableView;
    IPR_CODITE: TcxGridDBColumn;
    IPR_DESITE: TcxGridDBColumn;
    IPR_CODUNI: TcxGridDBColumn;
    IPR_DESMAR: TcxGridDBColumn;
    AUX_VALATU: TcxGridDBColumn;
    AUX_VALANT: TcxGridDBColumn;
    cxgItenslevel: TcxGridLevel;
    edtDesUnidade: TEditFocus;
    lblFatCal: TLabel;
    edtFatCal: TEditFocus;
    IPR_PRECUS: TcxGridDBColumn;
    AUX_MODIFI: TcxGridDBColumn;
    lblCodGpr: TLabel;
    edtCodGpr: TEditFocus;
    edtDesGpr: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtCodUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUnidadeExit(Sender: TObject);
    procedure btnAplicaClick(Sender: TObject);
    procedure cxgItensDBViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodGprExit(Sender: TObject);
    procedure edtCodGprKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    dspCadPro: TUniDataSetProvider;
    qryCadPro: TUniQuery;

    intDecUni:Integer;

    arrPro,
    arrMar,
    arrGru,
    arrFor,
    arrUni,
    arrCodGpr: TConsultasArray;
    strCodGpr: String;
    function fAtualizaItem(pgbStatus: TcxProgressBar): Boolean;
    procedure pAtualizaItem;
    procedure pCarregaPadra;
    function fRetornaValorMargemLiquida: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    cdsCadPro: TUniClientDataSet;
    strSelect: String;
    opcTipDes: TTipDescPro;
    blnFatNaoApl: Boolean;
    blnAlteraPelaMargemBruta: Boolean;
    blnCalcMargemLiquida: Boolean;
    frmCadPromocoes: TfrmCadPromocoes;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesConsulta, untConsultas, untGravando, untFuncoesGenerica;

procedure TfrmAltFatorDescItemPromocao.FormShow(Sender: TObject);
begin
  inherited;

  pCarregaPadra;

  If (opcTipDes In [tdpPrecos,tdpPrecosDescAdicional]) Then
  Begin
    If (opcTipDes = tdpPrecos) And (blnAlteraPelaMargemBruta) Then
    Begin
      Self.Caption := 'Alterar preço de venda pela margem bruta';
      lblFatCal.Caption := IIF(blnCalcMargemLiquida, 'Margem Líquida:', 'Margem Bruta:');
    End
    Else
    Begin
      Self.Caption := 'Alterar preço de venda';
      lblFatCal.Caption := 'Fator sobre preço de venda:';
    End;

    With cxgItensDBView Do
    Begin
      With Columns[FindItemByName('AUX_VALANT').Index] Do
      Begin
        DataBinding.FieldName := 'IPR_PREVEN';
        Caption := 'Pre. Venda Ant.';
      End;
      Columns[FindItemByName('AUX_VALATU').Index].Caption := 'Pre. Venda Atu.';
    End;
  End
  Else
  Begin
    Self.Caption := 'Alterar percentual de desconto';
    lblFatCal.Caption := 'Percentual de desconto:';
    With cxgItensDBView Do
    Begin
      With Columns[FindItemByName('AUX_VALANT').Index] Do
      Begin
        DataBinding.FieldName := 'IPR_PERDES';
        Caption := '% Desc. Ant.';
      End;
      Columns[FindItemByName('AUX_VALATU').Index].Caption :=  '% Desc. Atu.';
      Columns[FindItemByName('IPR_PRECUS').Index].Visible := False;
    End;
  End;

  pSetFocus(mskLinhaGrupo);

  pSetaCodIte( edtCodIte );

end;

function TfrmAltFatorDescItemPromocao.fRetornaValorMargemLiquida: String;
begin
  Result := FormatFloat(fMskDigitos(intDecUni),
                        fCalculaCustoReal(frmCadPromocoes.fRetPreCus(cdsCadPro.FieldByName('ITE_PRECUS').AsFloat),
                                          frmCadPromocoes.fRetIcmSai(cdsCadPro.FieldByName('ITE_ICMSAI').AsFloat),
                                          frmCadPromocoes.fRetImpFed(cdsCadPro.FieldByName('ITE_IMPFED').AsFloat),
                                          frmCadPromocoes.fRetDesOpe(cdsCadPro.FieldByName('ITE_DESOPE').AsFloat),
                                          frmCadPromocoes.fRetOutVal(cdsCadPro.FieldByName('ITE_OUTVAL').AsFloat)));
end;

function TfrmAltFatorDescItemPromocao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDescriIni) Then
    Begin
      If fEmptyStr(edtDescriIni.Text) Then
        edtDescriFin.Enabled := False
      Else
        edtDescriFin.Enabled := True;
    End

    Else If (Sender = edtDescriFin) Then
    Begin
      If Not fEmptyStr(edtDescriIni.Text) Then
      Begin
        If fEmptyStr(edtDescriFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Descrição Final deve ser preenchida!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtFatCal) Then
    Begin
      If (fEmptyStr(edtFatCal.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O '+AnsiLowerCase(AnsiReplaceStr(lblFatCal.Caption, ':', ''))+
            ' deve ser preenchido!', ['&Ok']);
        Result := False;
      End

      Else If ((fStrToFloat(edtFatCal.Text) <= 0.0)  And (opcTipDes In [tdpPrecos,tdpPrecosDescAdicional])) Then
      Begin
        fMensagem('ATENÇÃO!', 'O '+AnsiLowerCase(AnsiReplaceStr(lblFatCal.Caption, ':', ''))+
            ' deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End

    End

    Else If (Sender = edtCodUnidade) Then
    Begin
      If Not fEmptyStr(edtCodUnidade.Text) Then
      Begin
        If fEmptyStr(fRetNomUnidade(edtCodUnidade.Text)) Then
        Begin
          fMensagem('', 'Unidade Inválida!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodGpr) And fEmptyStr(edtCodGpr.Text) Then
      pDesmarcaLista(edtCodGpr, arrCodGpr, '', 6)

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmAltFatorDescItemPromocao.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(mskLinhaGrupo, edtDesGrupo, arrGru, fRetNomeLinhaGrupo, nil, 'da linha/grupo', 6);
end;

procedure TfrmAltFatorDescItemPromocao.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrGru) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltFatorDescItemPromocao.pAtualizaItem;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.fExecutarAcao := fAtualizaItem;
      frmGravando.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmAltFatorDescItemPromocao.pCarregaPadra;
  Var
    strWhere: String;
begin

  strWhere:='';

  If Not fEmptyStr(edtCodIte.Text) Then
    strWhere := strWhere + '  AND CADITE.ITE_CODITE = :CODITE  ';

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    If RightStr(mskLinhaGrupo.Text,3) = '000' Then
      strWhere := strWhere + '  AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) '
    Else
      strWhere := strWhere + '  AND ITE_CODGRU = :CODGRU ';
  End;

  If Not fEmptyStr(edtFornecedor.Text) Then
    strWhere := strWhere + '  AND ITE_CODFOR = :CODFOR ';

  If Not fEmptyStr(edtMarca.Text) Then
    strWhere := strWhere + '  AND ITE_CODMAR = :CODMAR ';

  If (Not fEmptyStr(edtDescriIni.Text)) And (Not fEmptyStr(edtDescriFin.Text)) Then
    strWhere := strWhere + '  AND LEFT(ITE_DESITE, LENGTH(:MAIOR)) BETWEEN :DESINI AND :DESFIN ';

  If Not fEmptyStr(edtRefere.Text) Then
    strWhere := strWhere + '  AND ITE_REFERE = :REFERE ';

  If Not fEmptyStr(edtCodUnidade.Text) Then
    strWhere := strWhere + '  AND ITE_CODUNI = :CODUNI ';

  strWhere := strWhere + fStrLocate(edtCodGpr , arrCodGpr  , 'ITE_CODGPR', 'CODGPR');

  With qryCadPro Do
  Begin
    cdsCadPro.Close;
    Close;

    SQL.Text:=strSelect+strWhere;

    If FindParam('CODITE') <> NIL Then
      ParamByName('CODITE').AsString := edtCodIte.Text;

    If FindParam('CODGRU') <> NIL Then
      ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;

    If FindParam('CODFOR') <> NIL Then
      ParamByName('CODFOR').AsString := edtFornecedor.Text;

    If FindParam('CODMAR') <> NIL  Then
      ParamByName('CODMAR').AsString := edtMarca.Text;

    If FindParam('MAIOR') <> NIL  Then
    Begin
      ParamByName('MAIOR').AsString := edtDescriIni.Text;
      ParamByName('DESINI').AsString := edtDescriIni.Text ;
      ParamByName('DESFIN').AsString := edtDescriFin.Text ;
    End;

    If FindParam('REFERE') <> NIL  Then
      ParamByName('REFERE').AsString := edtRefere.Text;

    If FindParam('CODUNI') <> NIL  Then
      ParamByName('CODUNI').AsString := edtCodUnidade.Text;

    pSetaParam(edtCodGpr.Text   , arrCodGpr,     strCodGpr, 'CODGPR', qryCadPro);

    Open;
    pSetaClient(qryCadPro);

    cdsCadPro.SetProvider(dspCadPro);
    cdsCadPro.IndexFieldNames := 'AUX_MODIFI;ITE_DESITE';
    cdsCadPro.Open;
    pSetaClient(cdsCadPro);
  End;

  With cdsCadPro do
  Begin
    TFloatField(FieldByName('IPR_PRECUS')).DisplayFormat := '#,##0.00';

    If (opcTipDes In [tdpPrecos,tdpPrecosDescAdicional]) Then
    Begin
      TFloatField(FieldByName('IPR_PREVEN')).DisplayFormat := fMskDigitos(intDecUni);
      TFloatField(FieldByName('AUX_VALATU')).DisplayFormat := fMskDigitos(intDecUni);
      edtFatCal.EditFormat:=fMskDigitos(intDecUni);
    End
    Else
    Begin
      TFloatField(FieldByName('IPR_PERDES')).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('AUX_VALATU')).DisplayFormat := '#,##0.00';
      edtFatCal.EditFormat:= '#,##0.00';
    End;
  End;

end;

procedure TfrmAltFatorDescItemPromocao.btnAplicaClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    pCarregaPadra;
    pAtualizaItem;
  End;
end;

procedure TfrmAltFatorDescItemPromocao.btnConfirmaClick(Sender: TObject);
begin

  cdsCadPro.Filter:='AUX_MODIFI = ''S''';
  cdsCadPro.Filtered:=True;

  If (Not cdsCadPro.IsEmpty) And
     (fMensagem('Atenção', 'Confirma atualização dos dados na tela principal da promoção ?' + #13#10 +
                           'Será necessário gravar a promoção para confirmar todas as modificações.', ['&Sim', '&Não'], 2) = 1) Then
   ModalResult:=mrOk
  Else
   ModalResult:=mrClose;
end;

procedure TfrmAltFatorDescItemPromocao.cxgItensDBViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strModifi : String;
begin
  inherited;

  With cxgItensDBView, cdsCadPro  Do
  Begin
    If (Not Active) Or (IsEmpty) Then
      Exit;

    strModifi := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, AUX_MODIFI.Index]);
    strModifi := IfThen(fEmptyStr(strModifi), '*', strModifi);

    Case strModifi[1] Of
    '*':Begin
          ACanvas.Font.Color := clBlack;
        End;
    'S':Begin
          ACanvas.Font.Color := clBlue;
        End;
    'N':Begin
          ACanvas.Font.Color := clRed;
        End;
    End;

    If AViewInfo.Selected And (strModifi <> '*') Then
      ACanvas.Brush.Color := clMoneyGreen
    Else
      ACanvas.Brush.Color := clWhite;
  End;

end;

procedure TfrmAltFatorDescItemPromocao.edtCodGprExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodGpr, edtDesGpr,    arrCodGpr, fRetNomeGrupoPrecos, Nil, 'do Grupo de Preço');
end;

procedure TfrmAltFatorDescItemPromocao.edtCodGprKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoPrecos(Self, edtCodGpr, edtDesGpr, Nil, Key, arrCodGpr) Then
  Begin
    If fValidaCampos(edtCodGpr, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltFatorDescItemPromocao.edtCodIteExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodIte, edtDesIte, arrPro, nil, fRetNomProduto, 'do produto');
end;

procedure TfrmAltFatorDescItemPromocao.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrPro, True, nil, 'consulta de itens', '1') then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltFatorDescItemPromocao.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtFornecedor, edtDesFornecedor, arrFor, fRetNomFornecedor, nil, 'do fornecedor');
end;

procedure TfrmAltFatorDescItemPromocao.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFor) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltFatorDescItemPromocao.edtMarcaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtMarca, edtDesMarca, arrMar, fRetNomMarca, nil, 'da marca');
end;

procedure TfrmAltFatorDescItemPromocao.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtMarca, edtDesMarca, nil, Key, arrMar) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmAltFatorDescItemPromocao.fAtualizaItem(
  pgbStatus: TcxProgressBar): Boolean;
  Var
   prcScroll: TprcScroll;
   fltAux: Double;
   fltPrecoCalcMargem: Double;
   strAux: String;
begin
  pDisableControls(cdsCadPro, prcScroll);
  strAux := cdsCadPro.IndexFieldNames;
  cdsCadPro.IndexFieldNames := '';
  blnFatNaoApl := False;
  Try
    cdsCadPro.Last;
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Atualizando Itens...', cdsCadPro.RecordCount);
    cdsCadPro.First;

    While Not cdsCadPro.Eof Do
    Begin
      With cdsCadPro Do
      Begin
        pStepStatusGravacao(pgbStatus, Format('Atualizando [%s]',
                           [LeftStr(FieldByName('ITE_DESITE').AsString, 25) + '...']));
        Edit;

        FieldByName('AUX_MODIFI').AsString := 'S';

        If (opcTipDes In [tdpPrecos,tdpPrecosDescAdicional]) Then
        Begin
          If (opcTipDes = tdpPrecos) And (blnAlteraPelaMargemBruta) And (fStrToFloat(edtFatCal.Text) > 0) Then
          Begin
            If blnCalcMargemLiquida Then
              fltPrecoCalcMargem := StrToFloat(fRetornaValorMargemLiquida)
            Else
              fltPrecoCalcMargem := IIF((FieldByName('IPR_PRECUS').AsFloat <> 0), FieldByName('IPR_PRECUS').AsFloat, FieldByName('ITE_PRECUS').AsFloat);

            fltAux := fFormataFloat(fCalculaPrecoVenda(1,
                                                       fltPrecoCalcMargem,
                                                       0,
                                                       fStrToFloat(edtFatCal.Text),
                                                       0,0,0,0),intDecUni);

          End
          Else
          Begin
            fltAux := fFormataFloat(FieldByName('IPR_PREVEN').AsFloat * fStrToFloat(edtFatCal.Text), intDecUni);
          End;

          If fltAux >= fFormataFloat(FieldByName('IPR_PRECUS').AsFloat, intDecUni) Then
          Begin
            FieldByName('AUX_VALATU').AsFloat := fltAux;
          End
          Else
          Begin
            FieldByName('AUX_VALATU').AsFloat := FieldByName('IPR_PREVEN').AsFloat;
            FieldByName('AUX_MODIFI').AsString := 'N';
            blnFatNaoApl := True;
          End;
        End
        Else
        Begin
          FieldByName('AUX_VALATU').AsFloat := fFormataFloat(fStrToFloat(edtFatCal.Text), 2);
        End;

        Post;
        Next;
      End;
    End;

  Finally
    Result := True;
    cdsCadPro.IndexFieldNames := strAux;
    cdsCadPro.First;
    pEnableControls(cdsCadPro, prcScroll);
    If blnFatNaoApl Then
      fMensagem('ATENÇÃO!', 'Itens marcados em vermelho não sofreram modificações pois, a aplicação do fator de '+
                            edtFatCal.Text+', resultaria em um Valor de Venda menor que seu Valor de Custo!', ['&Ok']);
    pSetFocus(btnConfirma);
  End
end;

procedure TfrmAltFatorDescItemPromocao.edtCodUnidadeExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodUnidade, edtDesUnidade, arrUni, fRetNomUnidade, nil, 'da Unidade', edtCodUnidade.MaxLength);
end;

procedure TfrmAltFatorDescItemPromocao.edtCodUnidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self, edtCodUnidade, edtDesUnidade, nil, nil, Key, arrUni) Then
  Begin
    If fValidaCampos(edtCodUnidade, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltFatorDescItemPromocao.FormCreate(Sender: TObject);
begin
  inherited;

  dspCadPro := TUniDataSetProvider.Create(Self);
  cdsCadPro := TUniClientDataSet.Create(Self);
  qryCadPro := fCriaQuery(Self);

  dspCadPro.DataSet := qryCadPro;
  dtsCadPro.DataSet := cdsCadPro;

  intDecUni := fCfgSis('DECUNI', varInteger);
  blnFatNaoApl := False;
  blnAlteraPelaMargemBruta := False;
  blnCalcMargemLiquida := False;
end;

end.
