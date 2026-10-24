unit untDigFinanceira;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
     Forms, Dialogs, untPaiConfirma, StdCtrls, ComboBoxFocus, EditFocus,
     AppEvnts, Menus, Buttons, ExtCtrls, Uni, untFuncFat, untTypesSistema,
     Math, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
     cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
     cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
     cxGridDBTableView, cxGrid, UniClientDataSet, cxDBLookupComboBox,
     untFinanceira, BitBtnLockedIncrem, cxLookAndFeels,
     cxLookAndFeelPainters,
     cxNavigator, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmDigFinanceira = class(TfrmPaiConfirma)
    pnlDados: TPanel;
    Label1: TLabel;
    edtCodFin: TEditFocus;
    edtDesFin: TEditFocus;
    Label2: TLabel;
    cbxQtdPar: TComboBoxFocus;
    Label3: TLabel;
    edtValOpe: TEditFocus;
    Label4: TLabel;
    edtValPar: TEditFocus;
    Panel1: TPanel;
    Label7: TLabel;
    edtEntrada: TEditFocus;
    Label5: TLabel;
    edtTotFin: TEditFocus;
    Label8: TLabel;
    edtValFin: TEditFocus;
    cxgFinanView: TcxGridDBTableView;
    cxgFinanLevel1: TcxGridLevel;
    cxgFinan: TcxGrid;
    cxgFinanViewColumn1: TcxGridDBColumn;
    cxgFinanViewColumn2: TcxGridDBColumn;
    cxgFinanViewColumn3: TcxGridDBColumn;
    cxgFinanViewColumn4: TcxGridDBColumn;
    cxgFinanViewColumn5: TcxGridDBColumn;
    dtsFinanc: TDataSource;
    cdsSelFin: TUniClientDataSet;
    dtsLisFin: TDataSource;
    cdsSelFinFIN_TOTFIN: TAggregateField;
    cxgFinanViewColumn6: TcxGridDBColumn;
    cdsSelFinFIN_TOTOPE: TAggregateField;
    btnExcluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnCartoes: TBitBtnLocked;
    lblValAdt: TLabel;
    edtValAdt: TEditFocus;
    cdsSelFinFIN_TOTADT: TAggregateField;
    procedure edtCodFinKeyPress(Sender: TObject; var Key: Char);
    procedure cbxQtdParChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgFinanViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCartoesClick(Sender: TObject);
    procedure cdsSelFinAfterPost(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }

    blnPedCar: Boolean;
    qryCadFin: TUniQuery;
    qryLisFin: TUniQuery;

    function fValidaDesAce(strDesAce: String): Boolean;
    function fValidaDesAceFinal: Boolean;

    procedure pCarregaDados;
    procedure pCarregaDadosAux;
    procedure pMontaListaCombo;
    procedure pLimpaCampos;
    Procedure pCalculaDados;
  public
    { Public declarations }
    arrCarFin: TCartoesFinanceira;
    fltEntrada: Double;
    fatVenda: TFatVenda;

  protected
    { Protected declarations }
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmDigFinanceira: TfrmDigFinanceira;

implementation

uses untFuncoesSimples, untConsultas, untFatFormasPagamento;

{$R *.dfm}


Procedure TfrmDigFinanceira.pCalculaDados;
  Var
    fltIndFin,
    fltOpeFin,
    fltParFin,
    fltTotFin: Double;
    intQtdFin: Integer;
Begin
  With qryCadFin Do
  Begin
    fltTotFin := fStrToFloat(edtValFin.Text);

    If (Not Active) Or IsEmpty Then
    Begin
      edtValOpe.Clear;
      edtValPar.Clear;
    End Else
    Begin
      intQtdFin := StrToIntDef(cbxQtdPar.Text, 0);

      fltIndFin := fatVenda.objFinanc.fRetIndiceFin(edtCodFin.Text, intQtdFin);

      fltParFin := fatVenda.objFinanc.fValorParcela(fltTotFin, FieldByName('FIN_TAXRET').AsFloat,
          FieldByName('FIN_TAXCAD').AsFloat, fltIndFin, FieldByName('FIN_TAXBOL').AsFloat, intQtdFin);

      fltOpeFin := fatVenda.objFinanc.fValorOperacao(fltParFin, intQtdFin);

      edtValOpe.Text := FormatFloat('#,##0.00', fltOpeFin);
      edtValPar.Text := FormatFloat('#,##0.00', fltParFin);
    End;

  End;
End;

procedure TfrmDigFinanceira.btnCartoesClick(Sender: TObject);
  Var
    arrCartoes: TCartoesResumoCaixaArray;
    frmFatFormasPagamento: TfrmFatFormasPagamento;
begin
  inherited;

  If fEmptyStr(edtCodFin.Text) Then
  Begin
    pMensagemOk('Informe o código da financeira!');
    pSetFocus(edtCodFin);
    Exit;
  End;

  If fVerificaCampos Then
  Begin
    arrCartoes := fatVenda.objFinanc.fRetArrCartoes(edtCodFin.Text, arrCarFin);

    pCriarFormularios(TfrmFatFormasPagamento, frmFatFormasPagamento);

    if Assigned(fatVenda.objTefRecebimento) then //'TEFVN_'
    Begin
      frmFatFormasPagamento.objTefRecebimento            := fatVenda.objTefRecebimento;
      frmFatFormasPagamento.strSessaoTef                 := fatVenda.strSessaoTef;
      frmFatFormasPagamento.blnExecutandoPeloFaturamento := True;
    End;

    If frmFatFormasPagamento.fDigitacaoCartoes(IIF(qryCadFin.FieldByName('FIN_DESACE').AsString = 'S',
                                                   fStrToFloat(edtValOpe.Text),
                                                   fStrToFloat(edtValFin.Text)),
                                               arrCartoes,
                                               fatVenda.objFinanc.fRetCartaoFinanceira(edtCodFin.Text, StrToIntDef(cbxQtdPar.Text, 0)),
                                               edtCodFin.Text,
                                               StrToIntDef(cbxQtdPar.Text, 0)) And
       frmFatFormasPagamento.blnConfCartoes Then
    Begin
      fatVenda.objFinanc.pCopiaArrCartoesDig(edtCodFin.Text, arrCartoes, arrCarFin);
      btnGravar.Click;
    End;

    FreeAndNil(frmFatFormasPagamento);

  End;
end;

procedure TfrmDigFinanceira.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If Not cdsSelFin.IsEmpty Then
  Begin
    cdsSelFin.Delete;
    fatVenda.objFinanc.pDeleteCartoesNaoEncontrados(arrCarFin, cdsSelFin);
  End;
end;

procedure TfrmDigFinanceira.btnGravarClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodFin.Text) Then
  Begin
    pMensagemOk('Informe o código da financeira!');
    pSetFocus(edtCodFin);
    Exit;
  End;

  With qryCadFin Do
  If fVerificaCampos Then
  Begin

    If blnPedCar And
       (FieldByName('FIN_TIPRET').AsString = 'P') And
       (Not fatVenda.objFinanc.fValidaCartao(IIF(FieldByName('FIN_DESACE').AsString = 'S',
                                                 fStrToFloat(edtValOpe.Text),
                                                 fStrToFloat(edtValFin.Text)),
            fatVenda.objFinanc.fRetArrCartoes(edtCodFin.Text, arrCarFin))) Then
    Begin
      btnCartoes.Click;
    End Else
    Begin
      fatVenda.objFinanc.pRegistraItem(cdsSelFin,
                                       edtCodFin.Text,
                                       fatVenda.objFinanc.fRetCartaoFinanceira(edtCodFin.Text, StrToIntDef(cbxQtdPar.Text, 0)),
                                       FieldByName('FIN_TIPRET').AsString,
                                       FieldByName('FIN_DESACE').AsString,
                                       fStrToFloat(edtValFin.Text),
                                       StrToIntDef(cbxQtdPar.Text, 0),
                                       fStrToFloat(edtValOpe.Text),
                                       fStrToFloat(edtValPar.Text),
                                       FieldByName('FIN_CODCLI').AsString,
                                       FieldByName('FIN_DIAREC').AsInteger,
                                       fStrToFloat(edtValAdt.Text));
      pLimpaCampos;
      pSetFocus(edtCodFin);
    End;
  End;
end;

procedure TfrmDigFinanceira.pLimpaCampos;
Begin
  edtCodFin.Clear;
  edtDesFin.Clear;
  edtValFin.Clear;
  edtValAdt.Clear;
  cbxQtdPar.Items.Clear;
  edtValPar.Clear;
  edtValOpe.Clear;
End;

procedure TfrmDigFinanceira.cbxQtdParChange(Sender: TObject);
begin
  inherited;

  pCalculaDados;
end;

procedure TfrmDigFinanceira.cdsSelFinAfterPost(DataSet: TDataSet);
begin
  inherited;

  fatVenda.objFinanc.pDeleteCartoesNaoEncontrados(arrCarFin, cdsSelFin);
end;

procedure TfrmDigFinanceira.cxgFinanViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: pCarregaDados;
  End;
end;

procedure TfrmDigFinanceira.pCarregaDadosAux;
Begin
  With cdsSelFin Do
  Begin
    edtValFin.Text      := FormatFloat('#0.00', FieldByName('FIN_VALFIN').AsFloat);
    edtValAdt.Text      := FormatFloat('#0.00', FieldByName('FIN_VALADT').AsFloat);
    edtValOpe.Text      := FormatFloat('#0.00', FieldByName('FIN_VALOPE').AsFloat);
    edtValPar.Text      := FormatFloat('#0.00', FieldByName('FIN_VALPAR').AsFloat);
    cbxQtdPar.ItemIndex := cbxQtdPar.Items.IndexOf(FieldByName('FIN_QTDPAR').AsString);
    btnCartoes.Enabled  := FieldByName('FIN_TIPRET').AsString = 'P';
  End;
End;

procedure TfrmDigFinanceira.pCarregaDados;
Begin
  If Not pnlDados.Visible Then
    Exit;

  With cdsSelFin Do
  If Not IsEmpty Then
  Begin
    edtCodFin.Text := FieldByName('FIN_CODFIN').AsString;
    cbxQtdPar.Items.CommaText := fatVenda.objFinanc.fParcelasFinanc(qryCadFin, edtCodFin.Text);
    pCarregaDadosAux;
    pSetFocus(edtCodFin);
  End;
End;

procedure TfrmDigFinanceira.edtCodFinKeyPress(Sender: TObject; var Key: Char);
 Var
   arrSel: TConsultasArray;
begin
  inherited;

  If fPesqFinanceira(Self,
                     edtCodFin,
                     edtDesFin,
                     Nil,
                     Key,
                     arrSel,
                     True) Then
  Begin
    If fValidaCampos(edtCodFin, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigFinanceira.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtValAdt);
end;

procedure TfrmDigFinanceira.FormClose(Sender: TObject;
  var Action: TCloseAction);
  Var
    fltValRes : Double;
begin

  If (ModalResult = mrok) And Assigned(fatVenda) Then
  Begin
    pLimpaCampos;

    If Not fValidaDesAceFinal Then
    Begin
      Action := canone;
    End

    Else If blnPedCar And (Not fatVenda.objFinanc.fValidaCartoes(arrCarFin, cdsSelFin)) Then
    Begin
      Action := canone;
      pCarregaDados;
      btnCartoes.Click;
    End
    Else
    Begin
      fltValRes := fatVenda.objFinanc.fValorRestante(cdsSelFin, fStrToFloat(edtTotFin.Text));

      If (fltValRes <> 0) Then
      Begin
        pMensagemOk('O valor a ser financiado deve ser igual a ' + FormatFloat('#0.00', fltValRes) + '!');
        Action := caNone;
        pSetFocus(edtCodFin);
      End
      Else
      Begin
        fatVenda.objFinanc.pSalvaDados(arrCarFin, cdsSelFin);

        If fatVenda.objFinanc.fRetDespesasAcessorias > 0 Then
        Begin
          fatVenda.pRecalculaTotGerFinanceira;
        End;
      End;
    End;

  End;
end;

procedure TfrmDigFinanceira.pMontaListaCombo;
Begin
  qryLisFin  := fCriaQuery(Self);
  With qryLisFin, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  FIN_CODIGO,');
    Add('  CONCAT(FIN_CODIGO, "-", FIN_DESCRI) AS FIN_DESCRI');
    Add('FROM ');
    Add('  CADFIN');
    Open;
  End;
  dtsLisFin.DataSet := qryLisFin;
End;

procedure TfrmDigFinanceira.FormCreate(Sender: TObject);
begin
  inherited;

  fatVenda   := Nil;
  fltEntrada := 0;
  qryCadFin  := fCriaQuery(Self);

  pMontaListaCombo;
end;

procedure TfrmDigFinanceira.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10   : Begin
                 If btnConfirma.Visible Then
                   btnConfirma.Click;
                 Key := 0;
               End;
  End;

end;

procedure TfrmDigFinanceira.FormShow(Sender: TObject);
begin
  inherited;

  edtEntrada.Text := FormatFloat('#0.00', fltEntrada);

  If Assigned(fatVenda) Then
  Begin
    If fatVenda.objFinanc.fRetDespesasAcessorias > 0 Then
    Begin
      fatVenda.fltDesAce := 0;
      fatVenda.pCalculaTotGer;
    End;

    If fatVenda.fltValFin > 0 Then
      edtTotFin.Text := FormatFloat('#0.00', fatVenda.fltValFin)
    Else
      edtTotFin.Text := FormatFloat('#0.00', fatVenda.fltTotGer);

    fatVenda.objFinanc.pCarregaDados(arrCarFin, cdsSelFin);

    blnPedCar := (Pos(fatVenda.strEspDoc, 'PD_OR_') <= 0);
  End
  Else
  Begin
    edtTotFin.Text := FormatFloat('#0.00', fDoubleAggregate(cdsSelFin, 'FIN_TOTFIN'));
  End;

  If Not blnPedCar Then
  Begin
    btnCartoes.Visible := False;
    btnGravar.Left     := btnCartoes.Left;
  End;
end;

function TfrmDigFinanceira.fValidaDesAce(strDesAce: String): Boolean;
Begin
  Result := True;

  With cdsSelFin Do
  Begin
    If IsEmpty Then
      Exit;

    Result := FieldByName('FIN_DESACE').AsString = strDesAce;
  End;
End;

function TfrmDigFinanceira.fValidaDesAceFinal: Boolean;
  Var
    strDesAce: String;
Begin
  Result := True;

  With cdsSelFin Do
  Begin
    If IsEmpty Then
      Exit;

    DisableControls;
    First;
    strDesAce := FieldByName('FIN_DESACE').AsString;
    Next;

    While Not Eof Do
    Begin
      Result := FieldByName('FIN_DESACE').AsString = strDesAce;

      If Not Result Then
      Begin
        pMensagemOk('A configuração "Informar taxas e encargos em Despesas Acessórias no Faturamento" deve ser a mesma para todas as financeiras!');
        Break;
      End;
        
      Next;
    End;


    EnableControls;
  End;
End;

function TfrmDigFinanceira.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    strQtdPar: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodFin) Then
    Begin

      If fEmptyStr(edtCodFin.Text) Then
      Begin
        pLimpaCampos;
        blnMudarFoco := False;
        pSetFocus(btnConfirma);
      End Else
      Begin

        edtDesFin.Text := fRetDescricao(edtCodFin.Text, 'CADFIN', 'FIN_CODIGO', 'FIN_DESCRI');

        If fEmptyStr(edtDesFin.Text) Then
        Begin
          pMensagemOk('Financeira não encontrada!');
          Result := False;
        End

        Else
        Begin
          strQtdPar := cbxQtdPar.Text;
          cbxQtdPar.Items.CommaText := fatVenda.objFinanc.fParcelasFinanc(qryCadFin, edtCodFin.Text);
          btnCartoes.Enabled        := qryCadFin.FieldByName('FIN_TIPRET').AsString = 'P';
          cbxQtdPar.ItemIndex       := cbxQtdPar.Items.IndexOf(strQtdPar);

          If Not fValidaDesAce(qryCadFin.FieldByName('FIN_DESACE').AsString) Then
          Begin
            Result := False;
            pMensagemOk('A configuração "Informar taxas e encargos em Despesas Acessórias no Faturamento" deve ser a mesma para todas as financeiras!');
          End

          Else If blnBuscaPorChave Then
          With fatVenda.objFinanc, cdsSelFin Do
          Begin
            If Locate('FIN_CODFIN', edtCodFin.Text, []) Then
            Begin
              pCarregaDadosAux;
            End
            Else
            Begin
              edtValFin.Text := FormatFloat('#0.00', fValorRestante(cdsSelFin, fStrToFloat(edtTotFin.Text) - fStrToFloat(edtValAdt.Text)));
              pCalculaDados;
            End;
          End;
        End;

      End;

    End

    Else If (Sender = edtValFin) Then
    Begin

      If fStrToFloat(edtValFin.Text) <= 0 Then
      Begin
        pMensagemOk('O Valor a ser Financiado deve ser maior que zero!');
        Result := False;
      End

      Else If fStrToFloat(edtValFin.Text) > fStrToFloat(edtTotFin.Text) Then
      Begin
        pMensagemOk('O Valor a ser Financiado deve ser menor ou igual a ' + edtTotFin.Text + '!');
        Result := False;
      End

      Else edtValFin.Text := FormatFloat('#0.00', fStrToFloat(edtValFin.Text));

    End

    Else If (Sender = edtValAdt) Then
    Begin

      If fStrToFloat(edtValAdt.Text) < 0 Then
      Begin
        pMensagemOk('O Valor do Adiantamento deve ser maior ou igual a zero!');
        Result := False;
      End

      Else If fStrToFloat(edtValAdt.Text) >= fStrToFloat(edtTotFin.Text) Then
      Begin
        pMensagemOk('O Valor do Adiantamento deve ser menor que ' + edtTotFin.Text + '!');
        Result := False;
      End

      Else
        edtValAdt.Text := FormatFloat('#0.00', fStrToFloat(edtValAdt.Text));

    End

    Else If (Sender = cbxQtdPar) Then
    Begin

      If cbxQtdPar.ItemIndex < 0 Then
      Begin
        pMensagemOk('Informe a quantidade de parcelas!');
        Result := False;
      End;

    End;

  End;

  If Not Result Then
  Begin
    If pnlDados.Visible Then
      pSetFocus(Sender);
  End;
end;


end.
