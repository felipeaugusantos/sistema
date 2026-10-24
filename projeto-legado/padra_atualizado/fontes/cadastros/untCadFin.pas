unit untCadFin;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, Mask, DBCtrls, DBEditFocus, EditFocus, DB, Uni, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, UniClientDataSet, UniDataSetProvider,
  cxMaskEdit, cxTextEdit, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, Provider, Datasnap.DBClient,
  DBComboBoxFocus, frxClass, frxExportCSVTestabilidade, ComboBoxFocus,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadFin = class(TfrmPaiCad)
    pnlDados: TPanel;
    dtsTabela: TDataSource;
    Panel2: TPanel;
    Label8: TLabel;
    dbeCodFin: TDBEditFocus;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    Label5: TLabel;
    dbeCodCli: TDBEditFocus;
    Label2: TLabel;
    dbeTaxRet: TDBEditFocus;
    Label4: TLabel;
    dbeTaxBol: TDBEditFocus;
    Label3: TLabel;
    dbeTaxCad: TDBEditFocus;
    Label6: TLabel;
    dbeDiaRec: TDBEditFocus;
    Label7: TLabel;
    edtNomCli: TEditFocus;
    dtsIndFin: TDataSource;
    cdsIndFin: TUniClientDataSet;
    dspIndFin: TUniDataSetProvider;
    pnlIndices: TPanel;
    cxgIndFin: TcxGrid;
    cxgIndFinTab: TcxGridDBTableView;
    cxgIndFinTabQtdPar: TcxGridDBColumn;
    cxgIndFinTabIndFin: TcxGridDBColumn;
    cxgIndFinLevel1: TcxGridLevel;
    cxStyleRepository: TcxStyleRepository;
    cxsWhite: TcxStyle;
    cxsGreen: TcxStyle;
    Label12: TLabel;
    Label11: TLabel;
    Panel4: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    edtQtdPar: TEditFocus;
    edtIndFin: TEditFocus;
    edtDesCar: TEditFocus;
    lblCodCar: TLabel;
    edtCodCar: TEditFocus;
    cxgIndFinTabCodCar: TcxGridDBColumn;
    cdsIndFinAUTOINCREM: TStringField;
    cdsIndFinIND_CODFIN: TStringField;
    cdsIndFinIND_INDFIN: TFloatField;
    cdsIndFinIND_CODCAR: TStringField;
    cdsIndFinIND_QTDPAR: TIntegerField;
    cdsIndFinIND_NOMCAR: TStringField;
    DBCheckBox1: TDBCheckBox;
    cmbTipRet: TComboBoxFocus;
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtIndFinKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCarKeyPress(Sender: TObject; var Key: Char);
    procedure cxgIndFinTabKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure cmbTipRetChange(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryIndFin: TUniQuery;

    Function fSalvaIndice: Boolean;
    Function fValidaCartoes: Boolean;

    procedure pLimpaCamposIndice;
    procedure pCarregaDadosAdicionais;
    procedure pSalvaReferencia;
    Procedure pAdicionaIncice(intQtdPar: Integer; fltIndFin: Double;
                              strCodCar, strNomCar: String);
    procedure pAbreIndices(strCodFin: String);
    procedure pAtualizaCodCar;

    procedure pCarregaIndice;
  public
    { Public declarations }
  protected
    { Protected declarations }
    procedure pInicializaIndices; override;
    procedure pAfterOpen(DataSet: TDataSet);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

{$R *.dfm}

uses SysUtils, Forms, untFuncoesSimples, untConsultas, untTypesSistema;

procedure TfrmCadFin.pInicializaIndices;
Begin

end;

procedure TfrmCadFin.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pnlIndices.Enabled := True;

  pHabilitaCodigo(dbeCodFin, dbeDescri, False);

  If (blnAlterou) Then
    cmbTipRet.Enabled := True;

  pAtualizaCodCar;
end;

procedure TfrmCadFin.btnCancelaClick(Sender: TObject);
begin
  inherited;

  cdsIndFin.CancelUpdates;

  pCarregaDadosAdicionais;

  If (qryTabela.Active) Then
    pAbreIndices(qryTabela.FieldByName('FIN_CODIGO').AsString);

  pnlIndices.Enabled := False;
  cmbTipRet.Enabled  := False;
end;

procedure TfrmCadFin.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFin.btnExcluirClick]');
    End;
  End;

  If (blnExcluiu) Then
  Begin
    cmbTipRet.Enabled := False;
    fCommit
  End
  Else
    fRollBack;

  pCarregaDadosAdicionais;
  pAbreIndices(qryTabela.FieldByName('FIN_CODIGO').AsString);

end;

procedure TfrmCadFin.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If cdsIndFin.IsEmpty Then
  Begin
    pMensagemOk('Informe os índices da Financeira!');
    pSetFocus(edtQtdPar);
    Exit;
  End;

  If Not fValidaCartoes Then
    Exit;

  If (cmbTipRet.ItemIndex = 0) Then
    qryTabela.FieldByName('FIN_TIPRET').AsString := 'D'
  Else If (cmbTipRet.ItemIndex = 1) Then
    qryTabela.FieldByName('FIN_TIPRET').AsString := 'P';

  inherited;

  Try
    pLimpaCamposIndice;

    pSalvaReferencia;

    If blnGravou Then
    Begin
      cdsIndFin.ApplyUpdates(0);
      cmbTipRet.Enabled := False;
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;
  pnlIndices.Enabled := False;
end;

procedure TfrmCadFin.btnIncluirClick(Sender: TObject);
begin
  inherited;

  With qryTabela Do
  Begin
    FieldByName('FIN_TAXRET').AsFloat   := 0;
    FieldByName('FIN_TAXCAD').AsFloat   := 0;
    FieldByName('FIN_TAXBOL').AsFloat   := 0;
    FieldByName('FIN_DIAREC').AsInteger := 0;
    FieldByName('FIN_TIPRET').AsString  := 'P';
    FieldByName('FIN_DESACE').AsString  := 'N';
    cmbTipRet.ItemIndex := 1;
    cmbTipRetChange(Sender);
  End;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodFin, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodFin, dbeDescri, True);

  cmbTipRet.Enabled := True;

  pAbreIndices('');

  edtNomCli.Clear;

  pnlIndices.Enabled := True;
end;

procedure TfrmCadFin.pLimpaCamposIndice;
Begin
  edtQtdPar.Clear;
  edtIndFin.Clear;
  edtCodCar.Clear;
  edtDesCar.Clear;
End;

procedure TfrmCadFin.pCarregaDadosAdicionais;
Begin
  edtNomCli.Text := fRetNomCliente(dbeCodCli.Text);

  If (qryTabela.FieldByName('FIN_TIPRET').AsString = 'D' ) Then
    cmbTipRet.ItemIndex := 0
  Else If (qryTabela.FieldByName('FIN_TIPRET').AsString = 'P' ) Then
    cmbTipRet.ItemIndex := 1;

  pLimpaCamposIndice;
End;

procedure TfrmCadFin.btnPesquisaClick(Sender: TObject);
  Var
    arrFinan: TConsultasArray;
    chrKey: Char;
begin
  //inherited;

  chrKey := '/';
  If fPesqFinanceira(Self, Nil, Nil, qryTabela, chrKey, arrFinan) Then
  Begin
    pCarregaDadosAdicionais;
    pAbreIndices(qryTabela.FieldByName('FIN_CODIGO').AsString);
  End;

  If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadFin.btnSairClick(Sender: TObject);
begin
  inherited;
  cmbTipRet.Enabled := False;
end;

procedure TfrmCadFin.cxgIndFinTabKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If pnlIndices.Enabled Then
               Begin
                 pCarregaIndice;
                 pSetFocus(edtQtdPar);
               End;
  End;

end;

procedure TfrmCadFin.pSalvaReferencia;
Begin
  With cdsIndFin Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;

      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('INDFIN', VS_strCodEmp);

      If fEmptyStr(FieldByName('IND_CODFIN').AsString) Then
        FieldByName('IND_CODFIN').AsString := qryTabela.FieldByName('FIN_CODIGO').AsString;

      Post;

      Next;
    End;

    EnableControls;
  End;

End;

procedure TfrmCadFin.dbeCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, dbeCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(dbeCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadFin.pAtualizaCodCar;
Begin
  lblCodCar.Enabled := cmbTipRet.ItemIndex = 1;
  edtCodCar.Enabled := cmbTipRet.ItemIndex = 1;

  If Not edtCodCar.Enabled Then
  Begin
    edtCodCar.Clear;
    edtDesCar.Clear;
  End;
End;

procedure TfrmCadFin.cmbTipRetChange(Sender: TObject);
begin
  inherited;
  pAtualizaCodCar;
end;

procedure TfrmCadFin.edtCodCarKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCartao : TConsultasArray;
begin
  inherited;

  If edtCodCar.Enabled And
     fPesqCartao(Self, edtCodCar, edtDesCar, Nil, Key, arrCartao) Then
  Begin
    If (fValidaCampos(edtCodCar, True)) Then ;
  End;
end;

procedure TfrmCadFin.edtIndFinKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If Key = '.' Then
    Key := ',';
end;

procedure TfrmCadFin.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela := 'CADFIN';
  strNomeCampo := 'FIN_CODIGO';

  qryTabela := fCriarQuery('SELECT * FROM CADFIN WHERE FALSE', Self);
  dtsTabela.DataSet   := qryTabela;
  qryTabela.AfterOpen := pAfterOpen;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodFin;

  qryIndFin := fCriaQuery(Self);
end;

procedure TfrmCadFin.FormShow(Sender: TObject);
begin
  inherited;
  cmbTipRet.Enabled := False;
end;

procedure TfrmCadFin.pAbreIndices(strCodFin: String);
Begin
  With qryIndFin, SQL Do
  Begin
    cdsIndFin.Close;
    Close;

    Clear;
    Add('SELECT');
    Add('  AUTOINCREM, ');
    Add('  IND_CODFIN, ');
    Add('  IND_QTDPAR, ');
    Add('  IND_INDFIN, ');
    Add('  IND_CODCAR, ');
    Add('  (SELECT CONCAT(CAR_CODCAR, " - ", CAR_DESCAR) FROM CADCAR WHERE CAR_CODCAR = IND_CODCAR) AS IND_NOMCAR ');
    Add('FROM INDFIN');
    Add('WHERE');

    If fEmptyStr(strCodFin) Then
      Add('FALSE')
    Else
      Add('IND_CODFIN = ' + QuotedStr(strCodFin));

    dspIndFin.DataSet := qryIndFin;
    cdsIndFin.SetProvider(dspIndFin);

    Open;

    pSetaClient(qryIndFin);
    pSetaClient(cdsIndFin);

    cdsIndFin.IndexFieldNames := 'IND_QTDPAR';
    cdsIndFin.Open;

    TFloatField(cdsIndFin.FieldbyName('IND_INDFIN')).DisplayFormat := '#0.00000000';
  End;
End;

procedure TfrmCadFin.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    TFloatField(FieldbyName('FIN_TAXRET')).DisplayFormat := '#,##0.00';
    TFloatField(FieldbyName('FIN_TAXCAD')).DisplayFormat := '#,##0.00';
    TFloatField(FieldbyName('FIN_TAXBOL')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TfrmCadFin.pCarregaIndice;
Begin
  with cdsIndFin Do
  Begin
    If IsEmpty Then
      Exit;

    edtQtdPar.Text := FieldByName('IND_QTDPAR').AsString;
    edtIndFin.Text := FormatFloat('', FieldByName('IND_INDFIN').AsFloat);
    edtCodCar.Text := FieldByName('IND_CODCAR').AsString;
    edtDesCar.Text := fRetNomeCartao(edtCodCar.Text);
  End;
End;

Procedure TfrmCadFin.pAdicionaIncice(intQtdPar: Integer;
                                     fltIndFin: Double;
                                     strCodCar,
                                     strNomCar: String);
Begin
  with cdsIndFin Do
  Begin
    If Locate('IND_QTDPAR', intQtdPar, []) Then
      Edit
    Else
      Insert;

    FieldByName('IND_QTDPAR').AsInteger := intQtdPar;
    FieldByName('IND_INDFIN').AsFloat   := fltIndFin;

    If fEmptyStr(strCodCar) Then
    Begin
      FieldByName('IND_CODCAR').Clear;
      FieldByName('IND_NOMCAR').Clear;
    End Else
    Begin
      FieldByName('IND_CODCAR').AsString  := strCodCar;
      FieldByName('IND_NOMCAR').AsString  := strNomCar;
    End;

    Post;
  End;
End;

function TfrmCadFin.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodFin) Then
    Begin
      If dbeCodFin.Enabled And fEmptyStr(dbeCodFin.Text) Then
      Begin
        pMensagemOk('Informe o código da financeira');
        Result := False;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        pMensagemOk('Informe a descrição da financeira');
        Result := False;
      End;
    End

    Else If (Sender = dbeCodCli) Then
    Begin
      If fEmptyStr(dbeCodCli.Text) Then
      Begin
        pMensagemOk('Informe o código do cliente');
        Result := False;
      End Else
      Begin
        edtNomCli.Text := fRetNomCliente(dbeCodCli.Text);

        If fEmptyStr(edtNomCli.Text) Then
        Begin
          pMensagemOk('Cliente não encontrado');
          Result := False;
        End

      End;
    End

    Else If (Sender = dbeTaxRet) Then
    Begin
      If fStrToFloat(dbeTaxRet.Text) < 0 Then
      Begin
        pMensagemOk('A taxa de retorno deve ser maior ou igual a zero');
        Result := False;
      End
    End

    Else If (Sender = dbeTaxCad) Then
    Begin
      If fStrToFloat(dbeTaxCad.Text) < 0 Then
      Begin
        pMensagemOk('A taxa de cadastro deve ser maior ou igual a zero');
        Result := False;
      End
    End

    Else If (Sender = dbeTaxBol) Then
    Begin
      If fStrToFloat(dbeTaxBol.Text) < 0 Then
      Begin
        pMensagemOk('A taxa de boleto deve ser maior ou igual a zero');
        Result := False;
      End
    End

    Else If (Sender = dbeDiaRec) Then
    Begin
      If StrToIntDef(dbeDiaRec.Text, -1) < 0 Then
      Begin
        pMensagemOk('Dias para recebimento deve ser maior ou igual a zero');
        Result := False;
      End
    End

    Else If (Sender = edtQtdPar) Then
    Begin

      If blnBuscaPorChave Then
      Begin

        If fEmptyStr(edtQtdPar.Text) Then
        Begin
          edtIndFin.Clear;
          If btnGravar.CanFocus Then
          Begin
            blnMudarFoco := False;
            pSetFocus(btnGravar);
          End;
        End

        Else If StrToIntDef(edtQtdPar.Text, 0) <= 0 Then
        Begin
          pMensagemOk('A quantidade deve ser maior que zero');
          Result := False;
        End

        Else If cdsIndFin.Locate('IND_QTDPAR', StrToIntDef(edtQtdPar.Text, 0), []) Then
          pCarregaIndice;

      End;
    End

    Else If (Sender = edtIndFin) Then
    Begin

      If blnBuscaPorChave Then
      Begin

        If fStrToFloat(edtIndFin.Text) < 0 Then
        Begin
          pMensagemOk('O índice de financiamento deve ser maior ou igual a zero');
          Result := False;
        End

        Else If (Not edtCodCar.Enabled) Then
           Result := fSalvaIndice;
      End;

    End

    Else If (Sender = edtCodCar) Then
    Begin

      If edtCodCar.Enabled Then
      Begin

        If blnBuscaPorChave Then
        Begin
          If fEmptyStr(edtCodCar.Text) Then
          Begin
            pMensagemOk('Informe o código do cartão');
            Result := False;
          End Else
          Begin
            edtDesCar.Text := fRetNomeCartao(edtCodCar.Text);

            If fEmptyStr(edtDesCar.Text) Then
            Begin
              pMensagemOk('Cartão não encontrado');
              Result := False;
            End

            Else Result := fSalvaIndice;

          End;
        End;

      End Else
      Begin
        edtCodCar.Clear;
        edtDesCar.Clear;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmCadFin.fSalvaIndice: Boolean;
Begin
  Result := True;

  If StrToIntDef(edtQtdPar.Text, 0) <= 0 Then
  Begin
    pMensagemOk('A quantidade deve ser maior que zero');
    Result := False;
    Exit;
  End

  Else If edtCodCar.Enabled Then
    Result := Result And fValidaCampos(edtIndFin, True);

  If Result Then
  Begin
    pAdicionaIncice(StrToIntDef(edtQtdPar.Text, 0), fStrToFloat(edtIndFin.Text),
                    edtCodCar.Text, edtCodCar.Text + ' - ' + edtDesCar.Text);

    pLimpaCamposIndice;

    pSetFocus(edtQtdPar);
    blnMudarFoco := False;
  End;

End;

Function TfrmCadFin.fValidaCartoes: Boolean;
Begin
  Result := True;

  With cdsIndFin Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin

      If cmbTipRet.ItemIndex = 1 {Parcelado} Then
      Begin

        If fEmptyStr(FieldByName('IND_CODCAR').AsString) Then
        Begin
          pMensagemOk('Informe o código do cartão!');
          pCarregaIndice;
          pSetFocus(edtCodCar);
          Result := False;
          Break;
        End;

      End Else
      Begin
        Edit;
        FieldByName('IND_CODCAR').Clear;
        FieldByName('IND_NOMCAR').Clear;
        Post;
      End;

      Next;
    End;

    EnableControls;
  End;

End;

end.
