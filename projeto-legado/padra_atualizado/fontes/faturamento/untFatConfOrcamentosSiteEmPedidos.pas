unit untFatConfOrcamentosSiteEmPedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  EditFocus, Uni,
  UniClientDataSet, UniDataSetProvider, Math, frxClass, frxDBSet, untZClient,
  BitBtnLockedIncrem, Mask, MaskEditFocus, QColorLabel, cxEditRepositoryItems,
  ImgList, cxContainer, cxProgressBar, dxCore,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxExportCSVTestabilidade, System.ImageList,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList, untTLock;

type
  TfrmFatConfOrcamentosSiteEmPedidos = class(TfrmPaiConfirma)
    pnlCabecalho: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lblCodEmp: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    btnFiltrar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    pnlDados: TPanel;
    mskCndPag: TMaskEditFocus;
    lblCndPag: TLabel;
    pnlLegendas: TPanel;
    lbl4: TLabel;
    clblbl5: TColorLabel;
    clblbl6: TColorLabel;
    clblbl7: TColorLabel;
    clblbl8: TColorLabel;
    clblbl9: TColorLabel;
    clblbl11: TColorLabel;
    cxedtRepository: TcxEditRepository;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    imgcbxTravas: TcxEditRepositoryImageComboBoxItem;
    cxmglst1: TcxImageList;
    pnlProgresso: TPanel;
    pgbProgresso: TcxProgressBar;
    pgbOrcamentos: TcxProgressBar;
    lblGravando: TLabel;
    chkSolSenhaLiberacao: TCheckBox;
    lbl5: TLabel;
    edtForPag: TEditFocus;
    pnlGrid: TPanel;
    cxgOrcamentos: TcxGrid;
    cxgOrcamentosView: TcxGridDBTableView;
    cxgOrcamentosViewColORCSEL: TcxGridDBColumn;
    cxgOrcamentosViewColDTAENT: TcxGridDBColumn;
    cxgOrcamentosViewColPEDSIT: TcxGridDBColumn;
    cxgOrcamentosViewColNUMPOK: TcxGridDBColumn;
    cxgOrcamentosViewColDOCUME: TcxGridDBColumn;
    cxgOrcamentosViewColCODEMP: TcxGridDBColumn;
    cxgOrcamentosViewColNOMCLI: TcxGridDBColumn;
    cxgOrcamentosViewColVLRCON: TcxGridDBColumn;
    cxgOrcamentosViewColT1: TcxGridDBColumn;
    cxgOrcamentosViewColT2: TcxGridDBColumn;
    cxgOrcamentosViewColT3: TcxGridDBColumn;
    cxgOrcamentosViewColT4: TcxGridDBColumn;
    cxgOrcamentosViewColT5: TcxGridDBColumn;
    cxgOrcamentosViewColTE: TcxGridDBColumn;
    cxgOrcamentosViewColPEDEMI: TcxGridDBColumn;
    cxgOrcamentosLevel: TcxGridLevel;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure cxgOrcamentosViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure cxgOrcamentosViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgOrcamentosViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgcbxEmiPedPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }

    cdsOrcamentos: TZClient;
    objLock: TLock;

    blnProcessoEmAndamento: Boolean;

    function fGetChaveBloqueio: String;

    function fConfimarOrcamentos: Boolean;
    function fConfirmarOrcamentoAtual: Boolean;

    procedure pCarregarOrcamentos;
    procedure pLimpaCampos;
    procedure pHabilitaDesabilitaTela(blnHab: Boolean);

    procedure pAfterScroll(DataSet: TDataSet);
    function fMarcarDesmarcarOrcamento(strOrcSel: String = ''): Boolean;
    procedure pMarcarDesmarcarTodosOrcamentos(strOrcSel: String);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses StrUtils, untConsultas, untGravarOrcamentoComoPedido, untFuncoesSimples,
  Faturamento.Classes.TValidarVenda, untTypesSistema, untConstantes;

{$R *.dfm}

procedure TfrmFatConfOrcamentosSiteEmPedidos.pLimpaCampos;
Begin
  cdsOrcamentos.Close;
  cdsOrcamentos.qryQuery.Close;

  objLock.pDestravarTodos;

  edtCodCli.Clear;
  edtNomCli.Text := 'TODOS';

  If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    mskDtaIni.Text := DateToStr(VS_Date);
    mskDtaFin.Text := DateToStr(VS_Date);
  End;

  If fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtCodEmp.Text := VS_strCodEmp;
    edtNomEmp.Text := fRetNomeEmpresa;
  End;

  edtCodEmp.Enabled := False;

  pSetFocus(mskDtaIni);
End;

procedure TfrmFatConfOrcamentosSiteEmPedidos.btnCancelarClick(Sender: TObject);
begin
  inherited;
  If Not blnProcessoEmAndamento Then
    pLimpaCampos;
end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.btnConfirmaClick(Sender: TObject);
begin
//  inherited;

  If blnProcessoEmAndamento Then
    Exit;

  If (Not cdsOrcamentos.IsEmpty) And
     fPergunta('Deseja confirmar os Orçamentos em Pedidos de Venda?') Then
  Begin
    If fConfimarOrcamentos Then
    Begin
      If cdsOrcamentos.IsEmpty Then
      Begin
        pMensagemOk('Todos os orçamentos foram confirmados com sucesso!');
        pLimpaCampos;
      End
      Else
        pMensagemOk('Operação concluída com sucesso, porém existem orçamentos que não foram confirmados!');
    End
    Else
      pLimpaCampos;
  End;

end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  If Not blnProcessoEmAndamento Then
    pMarcarDesmarcarTodosOrcamentos('N');
end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  If blnProcessoEmAndamento Then
    Exit;

  If fValidaPanel(pnlCabecalho, True) Then
  Begin
    pCarregarOrcamentos;
    If cdsOrcamentos.IsEmpty Then
    Begin
      pMensagemOk('Nenhum orçamento foi encontrado!');
      btnCancelar.Click;
    End
    Else
      pSetFocus(cxgOrcamentos);
  End;
end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.btnMarcarClick(Sender: TObject);
begin
  inherited;
  If Not blnProcessoEmAndamento Then
    pMarcarDesmarcarTodosOrcamentos('S');
end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.btnSairClick(Sender: TObject);
begin
  If Not blnProcessoEmAndamento Then
    inherited;
end;

function TfrmFatConfOrcamentosSiteEmPedidos.fGetChaveBloqueio: String;
begin
  With cdsOrcamentos Do
  Begin
    Result := 'FATGOR' + FieldByName('NUMDOC').AsString +
                         FieldByName('ESPDOC').AsString +
                         FieldByName('CODEMP').AsString;
  End;
end;

function TfrmFatConfOrcamentosSiteEmPedidos.fMarcarDesmarcarOrcamento(strOrcSel: String = ''): Boolean;
  Var
    blnTodos: Boolean;
begin
  Result := false;

  With cdsOrcamentos Do
  Begin
    If Not IsEmpty Then
    Begin
      Result := True;
      blnTodos := Not fEmptyStr(strOrcSel);

      If Not blnTodos Then
        strOrcSel := IIF(FieldByName('ORCSEL').AsString = 'S', 'N', 'S');

      If strOrcSel <> FieldByName('ORCSEL').AsString Then
      Begin
        If (strOrcSel = 'S') And Not objLock.fLock_Unlock(fGetChaveBloqueio, True, False) Then
        Begin
          If Not blnTodos Then
            pMensagemOk('Esse Documento está sendo utilizado em ' +
                        'Outra Estação por ' + fGetHostLock(fGetChaveBloqueio)  + '!');
          Result := False;
          Exit;
        End
        Else If strOrcSel = 'N' Then
          objLock.fLock_Unlock(fGetChaveBloqueio, False, False);
      End;

      Edit;
      FieldByName('ORCSEL').AsString := strOrcSel;
      Post;

      cxgOrcamentos.Refresh;
    End;
  End;
end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.pMarcarDesmarcarTodosOrcamentos(strOrcSel: String);
  Var
    intIndex: Integer;
    blnMarcouTodos: Boolean;
begin
  With cdsOrcamentos Do
  Begin
    Try
      blnProcessoEmAndamento := True;    
      blnMarcouTodos := True;
      Screen.Cursor  := crHourGlass;
      pHabilitaDesabilitaTela(False);

      IndexFieldNames := 'PEDSIT;NUMPOK';

      For intIndex := 0 To cxgOrcamentosView.ColumnCount -1 Do
        cxgOrcamentosView.Columns[intIndex].SortOrder := soNone;

      cxgOrcamentosViewColPEDSIT.SortOrder := soAscending;
      cxgOrcamentosViewColNUMPOK.SortOrder := soAscending;

      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          Application.ProcessMessages;
          If Not fMarcarDesmarcarOrcamento(strOrcSel) Then
            blnMarcouTodos := False;
          Next;
        End;
      End;

      cxgOrcamentosView.DataController.Controller.GoToFirst;

      If (strOrcSel= 'S') And Not blnMarcouTodos Then
        pMensagemOk('Existem orçamentos que não foram marcados!');
    Finally
      Screen.Cursor := crDefault;
      blnProcessoEmAndamento := False;      
      pHabilitaDesabilitaTela(True);      
    End;
  End;
end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.cxgOrcamentosViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  fMarcarDesmarcarOrcamento;
end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.cxgOrcamentosViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strOrcSel: String;
begin
  inherited;
  strOrcSel := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgOrcamentosViewColORCSEL.Index]);
  If (cdsOrcamentos.IsEmpty) Or fEmptyStr(strOrcSel) Then
    Exit;

  If (strOrcSel = 'S') Then
  Begin
    If AViewInfo.Selected And Assigned(ActiveControl) And fCheckParent(ActiveControl, cxgOrcamentos) Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.cxgOrcamentosViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: fMarcarDesmarcarOrcamento;
  End;
end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If blnProcessoEmAndamento Then
  Begin
    Action := caNone;
    Exit;
  End;

  FreeAndNil(objLock);
end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  blnProcessoEmAndamento := False;
  cdsOrcamentos := TZClient.Create(Self);
  cxgOrcamentosView.DataController.DataSource := cdsOrcamentos.dtsSource;
  objLock := TLock.Create;
  mskCndPag.EditMask := MASK_CONPAG;
end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6  : btnMarcar.Click;
    VK_F7  : btnDesmarcar.Click;
    VK_F10 : btnConfirma.Click;
  End;

end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.FormShow(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
end;

function TfrmFatConfOrcamentosSiteEmPedidos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

          If fEmptyStr(edtNomEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
            Result := False;
          End

        End;
      End;
    End

    Else If (Sender = mskDtaIni) Then
    Begin

    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      Begin

        If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&Ok']);
          Sender := mskDtaIni;
          Result := False;
        End
        Else If (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data final deve ser maior que a data inicial!', ['&Ok']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtCodCli) Then
    Begin

      If (fEmptyStr(edtCodCli.Text)) Then
      Begin
        edtNomCli.Text := 'TODOS';
      End
      Else
      Begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.imgcbxEmiPedPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  ShowMessage('teste')
end;

procedure TfrmFatConfOrcamentosSiteEmPedidos.pAfterScroll(DataSet: TDataSet);
begin
  mskCndPag.Text := DataSet.FieldByName('CONPAG').AsString;
  edtForPag.Text := DataSet.FieldByName('CODFPG').AsString + ' - ' + DataSet.FieldByName('DESFPG').AsString;  
end;

Procedure TfrmFatConfOrcamentosSiteEmPedidos.pCarregarOrcamentos;
Begin
  Try
    cdsOrcamentos.DisableControls;

    With cdsOrcamentos.qryQuery, SQL Do
    Begin
      cdsOrcamentos.Close;

      Close;
      Clear;

      {******************}
      {* SQL ORCAMENTOS *}
      {******************}
      Add('SELECT SQL_NO_CACHE ');
      Add('  FGO_DTAENT AS DTAENT,');
      Add('  FGO_NUMDOC AS NUMDOC,');
      Add('  FGO_ESPDOC AS ESPDOC,');
      Add('  FGO_CODEMP AS CODEMP,');
      Add('  FGO_PEDSIT AS PEDSIT,');
      Add('  FGO_NUMPOK AS NUMPOK,');
      Add('  FGO_CODCLI AS CODCLI,');
      Add('  CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS NOMCLI,');
      Add('  CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC) AS DOCUME,');
      Add('  FGO_VLRCON AS VLRCON,');
      Add('  FGO_CONPAG AS CONPAG,');
      Add('  FGO_CODFPG AS CODFPG,');
      Add('  FPG_DESCRI AS DESFPG,');
      Add('  "N" AS ORCSEL,');
      Add('  " " AS T1,');
      Add('  " " AS T2,');
      Add('  " " AS T3,');
      Add('  " " AS T4,');
      Add('  " " AS T5,');
      Add('  " " AS TE,');
      Add('  LPAD("", 14, " ") AS PEDEMI ');
      Add('FROM ');
      Add('  FATGOR ');
      Add('  JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ');
      Add('  LEFT JOIN CADFPG ON FPG_CODIGO = FGO_CODFPG ');
      Add('WHERE ');
      Add('  FGO_ESPDOC = "OR" AND  ');
      Add('  FGO_JAFATU = 0    AND  ');
      Add('  (IFNULL(FGO_PEDSIT,"") <> "" OR IFNULL(FGO_NUMPOK,"") <> "") ');

      If Not fEmptyStr(edtCodCli.Text) Then
        Add('  AND FGO_CODCLI = :CODCLI ');

      If Not fEmptyStr(edtCodEmp.Text) Then
        Add('  AND FGO_CODEMP = :CODEMP ');

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Add('  AND FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN ');

      Add('ORDER BY ');
      Add('  FGO_PEDSIT, FGO_NUMPOK ');

      {************************}
      {* DEFINE OS PARAMETROS *}
      {************************}
      If Not fEmptyStr(edtCodCli.Text) Then
        ParamByName('CODCLI').AsString := edtCodCli.Text;

      If Not fEmptyStr(edtCodEmp.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmp.Text;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('DTAINI').AsDateTime := StrToDateDef(mskDtaIni.Text,0);
        ParamByName('DTAFIN').AsDateTime := StrToDateDef(mskDtaFin.Text,0);
      End;

      {*************************}
      {* CARREGA OS ORCAMENTOS *}
      {*************************}
      cdsOrcamentos.pSetProvider;

      Open;

      pSetaClient(cdsOrcamentos.qryQuery);

      cdsOrcamentos.Open;

      TFloatField(cdsOrcamentos.FieldByName('VLRCON')).DisplayFormat := fMskDigitos(2);
    End;

    cdsOrcamentos.AfterScroll := pAfterScroll;

    pAfterScroll(cdsOrcamentos);

    objLock.pDestravarTodos;

    cdsOrcamentos.EnableControls;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFatConfOrcamentosSiteEmPedidos.pCarregarOrcamentos]');
      cdsOrcamentos.EnableControls;
    End;
  End;

End;

procedure TfrmFatConfOrcamentosSiteEmPedidos.pHabilitaDesabilitaTela(blnHab: Boolean);
begin
  pnlCabecalho.Enabled := blnHab;
  pnlBotoes.Enabled    := blnHab;
  pnlDados.Enabled     := blnHab;
  pnlGrid.Enabled      := blnHab;
end;

Function TfrmFatConfOrcamentosSiteEmPedidos.fConfimarOrcamentos: Boolean;
  Const
    OPC_TENTAR_NOVAMENTE  = 1;
    OPC_IGNORAR_ORCAMENTO = 2;
    OPC_PARAR_CONFIRMACAO = 3;
  Var
    intIndex: Integer;
    intOpcao: Integer;

  procedure pRemoveOrcamentosNaoSelecionados;
  begin
    With cdsOrcamentos Do
    Begin
      Filter := 'ORCSEL = ' + QuotedStr('N');
      Filtered := True;
      First;

      While Not IsEmpty Do
      Begin
        cdsOrcamentos.Delete;
      End;

      Filter := '';
      Filtered := False;
      First;
    End;
  end;

  procedure pRemoveOrcamentosConfirmados;
  begin
    With cdsOrcamentos Do
    Begin
      Filter := 'TRIM(PEDEMI) <> ' + QuotedStr('');
      Filtered := True;
      First;

      While Not IsEmpty Do
      Begin
        cdsOrcamentos.Delete;
      End;

      Filter := '';
      Filtered := False;
      First;
    End;
  end;

Begin

  With cdsOrcamentos Do
  Begin
    Try
      blnProcessoEmAndamento := True;

      pHabilitaDesabilitaTela(False);

      pnlProgresso.Visible := True;
      pgbProgresso.Position := 0;

      Application.ProcessMessages;

      IndexFieldNames := 'PEDSIT;NUMPOK';

      For intIndex := 0 To cxgOrcamentosView.ColumnCount -1 Do
        cxgOrcamentosView.Columns[intIndex].SortOrder := soNone;

      cxgOrcamentosViewColPEDSIT.SortOrder := soAscending;
      cxgOrcamentosViewColNUMPOK.SortOrder := soAscending;

      pRemoveOrcamentosNaoSelecionados;

      Result := False;

      pgbOrcamentos.Properties.Max := RecordCount;

      If Not IsEmpty Then
      Begin
        First;

        While Not Eof Do
        Begin
          pgbOrcamentos.Position := RecNo;
          Application.ProcessMessages;

          If Not fConfirmarOrcamentoAtual And chkSolSenhaLiberacao.Checked Then
          Begin
            intOpcao := fMensagem('','Não foi possível confirmar o Orçamento ' +
                                     'Nº ' + FieldByName('NUMDOC').AsString + '.' +
                                     #13#10 + 'Deseja tentar novamente?',
                                    ['&Sim', '&Não', '&Parar']);
            Case intOpcao Of
              OPC_TENTAR_NOVAMENTE : Continue;
              OPC_IGNORAR_ORCAMENTO: Next;
              OPC_PARAR_CONFIRMACAO: Break;
            End;
          End
          Else
            Next;
        End;

        pRemoveOrcamentosConfirmados;
        Result := True;
      End
      Else
        pMensagemOk('Não há orçamentos selecionados para confirmar!');

    Finally
      pnlProgresso.Visible := False;
      pHabilitaDesabilitaTela(True);
      blnProcessoEmAndamento := False;
    End;
  End;

End;

function TfrmFatConfOrcamentosSiteEmPedidos.fConfirmarOrcamentoAtual: Boolean;
  Type
    TFunctionValida = function(): Boolean Of Object;

  Const
    MAX_TRAVAS = 6;

  Const
    arrTravas: Array[1..6] Of String = ('T1','T2','T3','T4','T5','TE');

  Var
    objGerarPedido: TGravarOrcamentoComoPedido;

  procedure pLimpaStatusTravas;
    Var
      strTrava: String;
  begin
    cdsOrcamentos.Edit;

    For strTrava In arrTravas Do
      cdsOrcamentos.FieldByName(strTrava).Clear;

    cdsOrcamentos.Post;
  end;

  function fDefineStatusTrava(strTrava: String; fValidaTrava: TFunctionValida; intNoTrava: Integer): Boolean;
    Var
      blnValidou: Boolean;
  begin
    Result := True;

    objGerarPedido.objValidarPedido.pSetProgressValid(intNoTrava,MAX_TRAVAS);
    blnValidou := fValidaTrava;

    cdsOrcamentos.Edit;
    cdsOrcamentos.FieldByName(strTrava).AsString := IIF(blnValidou, 'L', 'B');
    cdsOrcamentos.Post;

    If objGerarPedido.objValidarPedido.blnPedirSenha And Not blnValidou Then
      Result := False;
  end;

  function fTodasAsTravasLiberadas: Boolean;
    Var
      strTrava: String;
  begin
    Result := True;
    For strTrava In arrTravas Do
      Result := Result And (cdsOrcamentos.FieldByName(strTrava).AsString = 'L');
  end;

begin
  Try
    objGerarPedido := TGravarOrcamentoComoPedido.Create(Self);

    With cdsOrcamentos, objGerarPedido, objValidarPedido Do
    Begin
      pgbProgresso  := Self.pgbProgresso;
      lblInformacao := Self.lblGravando;

      strNumOrc := FieldByName('NUMDOC').AsString;
      strEmpOrc := FieldByName('CODEMP').AsString;

      blnBloqueio := False;
      blnPedirSenha := chkSolSenhaLiberacao.Checked;

      pLimpaStatusTravas;

      Result := fCarregarOrcamento And fCarregarMatrizItens And fCalcularTotalVenda;

      If Result Then
      Begin
        objVenda.pgbStatusGravacao := Self.pgbProgresso;

        Result := fDefineStatusTrava('T1', fValidaLimiteCredito,  1) And
                  fDefineStatusTrava('T2', fValidaNaoCompra,      2) And
                  fDefineStatusTrava('T3', fValidaUnitario,       3) And
                  fDefineStatusTrava('T4', fValidaVrMinimo,       4) And
                  fDefineStatusTrava('T5', fValidaDebitosCliente, 5) And
                  fDefineStatusTrava('TE', fValidaEstoque,        6);
      End;

      Result := Result And fTodasAsTravasLiberadas And fCalcularTotalVenda And fGravarPedido;

      If Result Then
      Begin
        Edit;
        FieldByName('PEDEMI').AsString := objVenda.strNumDoc + '-' + objVenda.strEspDoc;
        Post;
      End;
    End;

  Finally
    If Assigned(objGerarPedido) Then FreeAndNil(objGerarPedido);
  End;
end;

end.
