unit untCadMetasCentroCusto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, EditFocus, cxCurrencyEdit,
  untFuncoesSimples, untTypesSistema, untFuncoesConsulta, untConsultas,
  untCadMetasCtaDet, MaskEditFocus, cxMaskEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  untFramePlanoDeContasMaskEdit, uni;

type
  TfrmCadMetasCentroCusto = class(TfrmPaiCad)
    pnlDados: TPanel;
    pnlConta: TPanel;
    pnlEmpres: TPanel;
    cxgCustosView: TcxGridDBTableView;
    cxgCustosLevel1: TcxGridLevel;
    cxgCustos: TcxGrid;
    cxgCustosCODCTA: TcxGridDBColumn;
    cxgCustosDESCTA: TcxGridDBColumn;
    cxgCustosVALMET: TcxGridDBColumn;
    dtsTabela: TDataSource;
    lblEmpres: TLabel;
    dbeCodEmp: TDBEditFocus;
    Label2: TLabel;
    dbeDtaIni: TDBEditFocus;
    Label3: TLabel;
    dbeDtaFin: TDBEditFocus;
    edtNomEmp: TEditFocus;
    Label12: TLabel;
    edtValMet: TEditFocus;
    Panel3: TPanel;
    btnExcCta: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnHeranca: TBitBtnLocked;
    Label1: TLabel;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    cxgCustosCODOPE: TcxGridDBColumn;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    Label5: TLabel;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcCtaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure cxgCustosViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    objContas: TCadMetasCtaDet;
    FblnTodasEmpresas: Boolean;

    procedure pAfterScroll(Dataset: TDataset);
    procedure SetblnTodasEmpresas(const Value: Boolean);

    Function fAlterouValores: Boolean;

  public
    { Public declarations }
    property blnTodasEmpresas: Boolean read FblnTodasEmpresas write SetblnTodasEmpresas;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

{$R *.dfm}

procedure TfrmCadMetasCentroCusto.btnAlterarClick(Sender: TObject);
begin
  inherited;

  objContas.fCarregaMetas(qryTabela.FieldByName('AUTOINCREM').AsString);

  if FblnTodasEmpresas then
     pHabilitaCodigo(dbeDtaIni, dbeDtaIni, True)
  Else
  Begin
     pHabilitaCodigo(dbeCodEmp, dbeDtaIni, True);
     edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
  End;

  btnExcCta.Enabled := True;
  pnlConta.Enabled  := True;
end;

procedure TfrmCadMetasCentroCusto.btnCancelaClick(Sender: TObject);
begin
  inherited;
  objContas.pCancela;

  if not FblnTodasEmpresas then
    edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);

  btnHeranca.Enabled := False;
  btnExcCta.Enabled  := False;
  pnlConta.Enabled   := False;
end;

procedure TfrmCadMetasCentroCusto.btnExcCtaClick(Sender: TObject);
begin
  inherited;

  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  If (Not objContas.IsEmpty) And fPergunta('Deseja excluir o Plano de Contas ' + objContas.FieldByName('MCP_CODCTA').AsString + '?') Then
    objContas.fExcluiMeta;
end;

procedure TfrmCadMetasCentroCusto.btnExcluirClick(Sender: TObject);
begin
  inherited;

  objContas.fCarregaMetas(qryTabela.FieldByName('AUTOINCREM').AsString);
  if not blnTodasEmpresas then
    edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
end;

procedure TfrmCadMetasCentroCusto.btnGravarClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If objContas.IsEmpty Then
  Begin
    pMensagemOk('Cadastre os Planos de Contas da Meta!');
    Exit;
  End;

  If Not objContas.fValidaContasPeriodo(dbeCodEmp.Text,
                                        qryTabela.FieldByName('AUTOINCREM').AsString,
                                        StrToDateDef(dbeDtaIni.Text, 0),
                                        StrToDateDef(dbeDtaFin.Text, 0),
                                        FblnTodasEmpresas) Then
    Exit;

  If Not fValidacoesBotaoGravarPai Then
    Exit;

  If FblnTodasEmpresas Then
  Begin
    strCampoEmp := '';
    qryTabela.FieldByName('MCP_CODEMP').Clear;
  End;


  Try
    inherited;

    If Not objContas.fSalvaMetas(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Begin
      fRollBack;
      Exit;
    End

    Else fCommit;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFases.btnGravarClick]');
    End;
  End;

  btnExcCta.Enabled  := False;
  pnlConta.Enabled   := False;
  btnHeranca.Enabled := False;
end;

procedure TfrmCadMetasCentroCusto.btnHerancaClick(Sender: TObject);
  Var
    strCodEmp: String;
begin
  inherited;

  If (qryTabela.State In [dsEdit, dsInsert]) And objContas.fHeranca(Self, strCodEmp) Then
  Begin
    If  FblnTodasEmpresas Then
    Begin
      dbeCodEmp.Field.Value := strCodEmp;
      edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
    End;
    pSetFocus(dbeDtaIni);
  End;
end;

procedure TfrmCadMetasCentroCusto.btnIncluirClick(Sender: TObject);
begin
  inherited;
  objContas.fCarregaMetas('');
  If Not FblnTodasEmpresas Then
  Begin
    pSetFocus(dbeCodEmp);
    dbeCodEmp.Field.Value := VS_strCodEmp;
    edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
  End
  Else
  Begin
    dbeCodEmp.Field.Clear;
    pSetFocus(dbeDtaIni);
  End;
  dbeDtaIni.Field.Value := VS_Date;

  btnExcCta.Enabled := True;
  pnlConta.Enabled  := True;

  btnHeranca.Enabled := True;
end;

procedure TfrmCadMetasCentroCusto.btnPesquisaClick(Sender: TObject);
  Var
    arrMetas : TConsultasArray;
    chrKey   : Char;
Begin
  chrKey := '/';
  if fPesqMetasCentroCustoPedidoCompra(Self, qryTabela, chrKey, arrMetas) then
  Begin
    objContas.fCarregaMetas(qryTabela.FieldByName('AUTOINCREM').AsString);
    If Not FblnTodasEmpresas Then
      edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadMetasCentroCusto.cxgCustosViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_RETURN: If (qryTabela.State In [dsEdit, dsInsert]) And (Not objContas.IsEmpty) Then
               Begin
                 edtCodOpe.Text := objContas.FieldByName('MCP_CODOPE').AsString;
                 fraPlanoDeContas.MskCodCta.Text := objContas.FieldByName('MCP_CODCTA').AsString;
                 fraPlanoDeContas.edtDesCta.Text := objContas.FieldByName('MCP_DESCTA').AsString;
                 edtCodEve.Text := objContas.FieldByName('MCP_CODEVE').AsString;
                 edtDesEve.Text := objContas.FieldByName('MCP_DESEVE').AsString;
                 edtValMet.Text := FormatFloat('#0.00', objContas.FieldByName('MCP_VALMET').AsFloat);
                 pSetFocus(edtCodOpe);
               End;

    VK_DELETE: btnExcCta.Click;
  end;

end;

procedure TfrmCadMetasCentroCusto.dbeCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(dbeCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadMetasCentroCusto.edtCodEveKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEvento: TConsultasArray;
begin
  inherited;

  If fPesqEventos(Self, edtCodEve, edtDesEve, Nil, Key, arrEvento, False) Then
  Begin
    If fValidaCampos(edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadMetasCentroCusto.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  if fPesqOperador(Self, edtCodOpe, edtNomOpe, Nil, Key, arrSel) then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadMetasCentroCusto.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'MCPGER';
  strNomeCampo      := 'AUTOINCREM';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  qryTabela.AfterScroll := pAfterScroll;

  SetLength(arrCamposChave, 3);
  arrCamposChave[0] := dbeCodEmp;
  arrCamposChave[1] := dbeDtaIni;
  arrCamposChave[2] := dbeDtaFin;

  objContas :=  TCadMetasCtaDet.Create(Self);

  cxgCustosView.DataController.DataSource := objContas.dtsSource;

  blnIncluiBuscaPorChave := False;
end;

procedure TfrmCadMetasCentroCusto.FormShow(Sender: TObject);
begin
  blnIgnorarCodEmp := FblnTodasEmpresas;

  inherited;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
  pSetFocus(btnIncluir);
end;

Function TfrmCadMetasCentroCusto.fAlterouValores: Boolean;
Begin
  Result := qryTabela.Modified;
End;

procedure TfrmCadMetasCentroCusto.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  inherited;

  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) And
     fValidaCampos(fraPlanoDeContas.MskCodCta, True) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmCadMetasCentroCusto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodEmp) and (not (fblnTodasEmpresas)) Then
    Begin

      If fEmptyStr(dbeCodEmp.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Informe o Código da Empresa da Meta!', ['&Ok']);
      End Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);

        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          pMensagemOk('Empresa não encontrada!');
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeDtaIni) Then
    Begin
      If fEmptyDate(dbeDtaIni.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Informe a Data Inicial da Meta!', ['&Ok']);
      End

      Else If StrToDateDef(dbeDtaIni.Text, 0) = 0 Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Data Inicial inválida!', ['&Ok']);
      End;

    End

    Else If (Sender = dbeDtaFin) Then
    Begin
      If fEmptyDate(dbeDtaFin.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Informe a Data Final da Meta!', ['&Ok']);
      End

      Else If StrToDateDef(dbeDtaFin.Text, 0) = 0 Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Data Final inválida!', ['&Ok']);
      End

      Else If StrToDateDef(dbeDtaIni.Text, 0) > StrToDateDef(dbeDtaFin.Text, 0) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&Ok']);
      End

      Else If blnBuscaPorChave Then
      Begin
        If fAlterouValores And fBuscaPorCamposChave Then
        Begin
          objContas.fCarregaMetas(qryTabela.FieldByName('AUTOINCREM').AsString);
          if not FblnTodasEmpresas then
            edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
        End;
      End;
    End

    Else If (Sender = edtCodOpe) Then
    Begin

      If blnBuscaPorChave Then
      Begin
        If fEmptyStr(edtCodOpe.Text) Then
        Begin
          Result := False;
          pMensagemOk('Informe o operador responsável pelo plano de contas!');
        End Else
        begin
          edtNomOpe.Text := fRetNomeOperador(edtCodOpe.Text);

           If fEmptyStr(edtNomOpe.Text) Then
           Begin
             Result := False;
             pMensagemOk('Operador não encontrado!');
           End;
        End;
      End;

    End

    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin

      If Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fraPlanoDeContas.edtDesCta.Text := fRetNomeConta(fraPlanoDeContas.MskCodCta.Text);

        If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Plano de Contas não Cadastrado!', ['&Ok']);
        End
        Else If PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True) = False then
          Result := False
        Else Result := objContas.fValidaConta(dbeCodEmp.Text,
                                              fraPlanoDeContas.MskCodCta.Text,
                                              qryTabela.FieldByName('AUTOINCREM').AsString,
                                              dbeDtaIni.Field.Value,
                                              dbeDtaFin.Field.Value,
                                              FblnTodasEmpresas,
                                              edtCodEve.Text);


      End
      Else If blnBuscaPorChave Then
      Begin
        If (fCfgSis('METPED', varString) = '5') Or
          (fCfgSis('METPED', varString) = '6') Then
        Begin

          If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
          Begin
            Result := False;
            fMensagem('ATENÇÃO!', 'O Campo: Plano de Contas deve ser preenchido!', ['&Ok']);
            Exit;
          End;


        End;

        pSetFocus(btnGravar);
        blnMudarFoco := False;
      End;

      edtValMet.Enabled := Result And (Not fEmptyStr(fraPlanoDeContas.edtDesCta.Text));
    End


    Else


    If (Sender = edtCodEve) Then
    Begin

      If blnBuscaPorChave Then
      Begin
        If (fCfgSis('METPED', varString) = '5') Or
          (fCfgSis('METPED', varString) = '6') Then
        Begin

          If fEmptyStr(edtCodEve.Text) Then
          Begin
            Result := False;
            fMensagem('ATENÇÃO!', 'O Campo: Centro de Custo deve ser preenchido!', ['&Ok']);
            Exit;
          End;


        End;

        If Not fEmptyStr(edtCodEve.Text) Then
        Begin

          edtDesEve.Text:= fRetNomEvento(edtCodEve.Text);

          If fEmptyStr(edtDesEve.Text) Then
          Begin
            Result := False;
            fMensagem('ATENÇÃO!', 'Evento não Cadastrado!', ['&Ok']);
          End;


        End
        Else

          edtDesEve.Text := '';

      End;

    End



    Else If (Sender = edtValMet) Then
    Begin

      If edtValMet.Enabled And blnBuscaPorChave Then
      Begin

        If fStrToFloat(edtValMet.Text) <= 0 Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'O Valor da Meta deve ser maior que zero!', ['&Ok']);
        End

        Else If fValidaCampos(fraPlanoDeContas.MskCodCta, True) And
                fValidaCampos(edtCodOpe, True) And
                objContas.fIncluiMeta(fraPlanoDeContas.MskCodCta.Text, edtCodOpe.Text, fStrToFloat(edtValMet.Text), edtCodEve.Text) Then
        Begin
          fraPlanoDeContas.MskCodCta.Clear;
          fraPlanoDeContas.edtDesCta.Clear;
          edtValMet.Clear;
          edtCodOpe.Clear;
          edtCodEve.Clear;
          edtDesEve.Clear;
          pSetFocus(edtCodOpe);
          blnMudarFoco := False;
        End;

      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadMetasCentroCusto.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

procedure TfrmCadMetasCentroCusto.SetblnTodasEmpresas(const Value: Boolean);
begin
  FblnTodasEmpresas:= Value;
  dbeCodEmp.Visible := not Value;
  edtNomEmp.Visible := not Value;
  lblEmpres.Visible := not Value;
  if Value Then
    pnlEmpres.Height := pnlEmpres.Height - 22
  Else
    pnlEmpres.Height := 65;
end;

procedure TfrmCadMetasCentroCusto.pAfterScroll(Dataset: TDataset);
begin
  With Dataset Do
  Begin
    TDateField(FieldByName('MCP_DTAINI')).EditMask := '99/99/9999';
    TDateField(FieldByName('MCP_DTAFIN')).EditMask := '99/99/9999';
  End;
end;

end.
