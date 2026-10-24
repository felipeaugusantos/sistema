unit untManutChqEmi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, Mask, MaskEditFocus, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Uni, UniClientDataSet,
  UniProvider, UniDataSetProvider, DBClient, frxClass, frxExportCSVTestabilidade, cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmManutChqEmi = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label28: TLabel;
    lblCodEmp: TLabel;
    Label24: TLabel;
    edtCodBco: TEditFocus;
    edtNomBco: TEditFocus;
    edtNumAge: TEditFocus;
    edtConCor: TEditFocus;
    edtNumChq: TEditFocus;
    cxgChequesTableView: TcxGridDBTableView;
    cxgChequesLevel1: TcxGridLevel;
    cxgCheques: TcxGrid;
    dtsCheques: TDataSource;
    btnConsultar: TBitBtnLocked;
    cxgChequesTableViewEMI_CODBCO: TcxGridDBColumn;
    cxgChequesTableViewEMI_NUMAGE: TcxGridDBColumn;
    cxgChequesTableViewEMI_CONCOR: TcxGridDBColumn;
    cxgChequesTableViewEMI_NUMCHQ: TcxGridDBColumn;
    cxgChequesTableViewEMI_DTAEMI: TcxGridDBColumn;
    cxgChequesTableViewEMI_BOMPAR: TcxGridDBColumn;
    cxgChequesTableViewEMI_FAVORE: TcxGridDBColumn;
    cxgChequesTableViewEMI_VALBAI: TcxGridDBColumn;
    btnExcluir: TBitBtnLocked;
    btnDuplic: TBitBtnLocked;
    lblLocContraPart: TLabel;
    cxgChequesTableViewEMI_MARDES: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    Label11: TLabel;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxgChequesTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgChequesTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure btnDuplicClick(Sender: TObject);
    procedure cxgChequesTableViewDblClick(Sender: TObject);
  private
    { Private declarations }
    qryCadBco : TUniQuery;
    qryChqEmi : TUniQuery;
    dspChqEmi : TUniDataSetProvider;
    cdsChqEmi : TUniClientDataSet;

    procedure pCarregaBanco;
    procedure pCriaTemporaria;
    procedure pLimpaDados;
    procedure pDeletaCheques;
    procedure pSelecionaDuplicata;
    procedure pMostraDuplicatasCheque;
    function DuplicataDoChequeEstaBaixada: Boolean;
    procedure pEstornarPagarVinculado(ADuplicata, AParcela, ASerie, ACodigoFornecedor, ACodigoEmpresa: String);
  public
    { Public declarations }
  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses untFuncoesSimples, untPesqAux, untConsultas, untFuncoesRel, untFuncoesRel2,
  untTypesSistema, untEstornoPagar;

{$R *.dfm}

{ TfrmManutChqEmi }

procedure TfrmManutChqEmi.btnConsultarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    btnConsultar.Enabled := False;
    pCriaTemporaria;
    btnConsultar.Enabled := True;

    If cdsChqEmi.IsEmpty Then
    Begin
      fMensagem('', 'Não há informações para esta consulta!', ['&Ok']);
      pSetFocus(edtCodBco);
    End
    Else
      pSetFocus(cxgCheques);
  End;

end;

procedure TfrmManutChqEmi.btnDuplicClick(Sender: TObject);
begin
  inherited;

  If Assigned(cdsChqEmi) then
  begin
    cdsChqEmi.DisableControls;
    cdsChqEmi.Filtered := False;
    cdsChqEmi.Filter   := 'EMI_MARDES = ' + QuotedStr('M');
    cdsChqEmi.Filtered := True;

    If cdsChqEmi.IsEmpty Then
    Begin
      fMensagem('','Você deve selecionar um cheque para visualizar as duplicatas!', ['&Ok']);
      cdsChqEmi.Filtered := False;
      cdsChqEmi.EnableControls;
      Exit;
    End
    Else
    If cdsChqEmi.RecordCount > 1 Then
    Begin
      fMensagem('','Você deve selecionar apenas um cheque para visualizar as duplicatas!', ['&Ok']);
      cdsChqEmi.Filtered := False;
      cdsChqEmi.EnableControls;
      Exit;
    End;

    pMostraDuplicatasCheque;


    cdsChqEmi.Filtered := False;
    cdsChqEmi.EnableControls;
  end
  else fMensagem('','Você deve selecionar um cheque para visualizar as duplicatas!', ['&Ok']);

end;

procedure TfrmManutChqEmi.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If Assigned(cdsChqEmi) then
  begin
    cdsChqEmi.DisableControls;
    cdsChqEmi.Filtered := False;
    cdsChqEmi.Filter   := 'EMI_MARDES = ' + QuotedStr('M');
    cdsChqEmi.Filtered := True;

    If cdsChqEmi.IsEmpty Then
    Begin
      fMensagem('','Você deve selecionar ao menos um cheque para excluir!', ['&Ok']);
      cdsChqEmi.Filtered := False;
      cdsChqEmi.EnableControls;
      Exit;
    End;

     If DuplicataDoChequeEstaBaixada Then
     Begin
       cdsChqEmi.Filtered := False;
       cdsChqEmi.EnableControls;
       Exit;
     End;

    If fMensagem('','Deseja excluir o(s) cheque(s) selecionado(s)?',['&Sim', '&Não']) = 1 Then
      pDeletaCheques
    Else
    Begin
      cdsChqEmi.Filtered := False;
      cdsChqEmi.EnableControls;
    End;
  end
  else fMensagem('','Você deve selecionar ao menos um cheque para excluir!', ['&Ok']);

  pSetFocus(edtCodBco);

end;

procedure TfrmManutChqEmi.cxgChequesTableViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strMarDes: String;
begin
  inherited;

  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgChequesTableViewEMI_MARDES.Index]);
  If (cdsChqEmi.IsEmpty) Or fEmptyStr(strMarDes) Then
    Exit;

  If (strMarDes = 'M') Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clLime;
  End;

end;

procedure TfrmManutChqEmi.cxgChequesTableViewDblClick(Sender: TObject);
begin
  inherited;

  pSelecionaDuplicata;

end;

procedure TfrmManutChqEmi.cxgChequesTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_RETURN Then
    pSelecionaDuplicata;

end;

function TfrmManutChqEmi.DuplicataDoChequeEstaBaixada: Boolean;
  Var
    LDuplicatasBaixadas: TUniQuery;
begin
  Result := False;

  Try
    Try
      LDuplicatasBaixadas := fCriaQuery(Nil);
      LDuplicatasBaixadas.Close;
      LDuplicatasBaixadas.SQL.Clear;
      LDuplicatasBaixadas.SQL.Text := 'SELECT                                              '+
                                      '  CONCAT(CHQEMI.EMI_CODBCO,"-",CHQEMI.EMI_NUMAGE,"-",CHQEMI.EMI_CONCOR,"-",CHQEMI.EMI_NUMCHQ) AS CHEQUE, '+
                                      '  CADPAG.CTP_NUMDUP,                                '+
                                      '  CADPAG.CTP_PARCEL,                                '+
                                      '  CADPAG.CTP_SERIE_,                                '+
                                      '  CADPAG.CTP_CODFOR,                                '+
                                      '  CADPAG.CTP_CODEMP                                 '+
                                      'FROM                                                '+
                                      '  CHQEMI                                            '+
                                      '  INNER JOIN BANCHQ                                 '+
                                      '     ON CHQEMI.EMI_CODBCO = BANCHQ.CHQ_CODBCO       '+
                                      '    AND CHQEMI.EMI_NUMAGE = BANCHQ.CHQ_NUMAGE       '+
                                      '    AND CHQEMI.EMI_CONCOR = BANCHQ.CHQ_CONCOR       '+
                                      '    AND CHQEMI.EMI_NUMCHQ = BANCHQ.CHQ_NUMCHQ       '+
                                      '  INNER JOIN MOVBAN                                 '+
                                      '    ON BANCHQ.CTB_SEQLAN = MOVBAN.CTB_SEQLAN        '+
                                      '  INNER JOIN CADPAG                                 '+
                                      '    ON MOVBAN.CTB_PAGCON = CADPAG.CTP_SEQCON AND    '+
                                      '       MOVBAN.CTB_CODEMP = CADPAG.CTP_EMPBAI        '+
                                      'WHERE CHQEMI.EMI_CODBCO = :CODBCO                   '+
                                      '  AND CHQEMI.EMI_NUMAGE = :NUMAGE                   '+
                                      '  AND CHQEMI.EMI_CONCOR = :CONCOR                   '+
                                      '  AND CHQEMI.EMI_NUMCHQ = :NUMCHQ                   '+
                                      '  AND CTP_DTABAI IS NOT NULL                        ';

      cdsChqEmi.First;
      While Not cdsChqEmi.Eof Do
      Begin
        LDuplicatasBaixadas.ParamByName('CODBCO').AsString := cdsChqEmi.FieldByName('EMI_CODBCO').AsString;
        LDuplicatasBaixadas.ParamByName('NUMAGE').AsString := cdsChqEmi.FieldByName('EMI_NUMAGE').AsString;
        LDuplicatasBaixadas.ParamByName('CONCOR').AsString := cdsChqEmi.FieldByName('EMI_CONCOR').AsString;
        LDuplicatasBaixadas.ParamByName('NUMCHQ').AsString := cdsChqEmi.FieldByName('EMI_NUMCHQ').AsString;
        LDuplicatasBaixadas.Open;

        Result := (LDuplicatasBaixadas.RecordCount > 0);

        If Result Then
        Begin
          if fMensagem('ATENÇÃO', 'O cheque '+LDuplicatasBaixadas.FieldByName('CHEQUE').AsString+' foi utilizado na baixa do contas a pagar!' + #10#13 +
                               'Deseja realizar o estorno da duplicata vinculada, para que a exclusão do cheque seja feita automaticamente?', ['&Sim', '&Não']) = 2 then
            Break;

          pEstornarPagarVinculado(LDuplicatasBaixadas.FieldByName('CTP_NUMDUP').ASString,
                                  LDuplicatasBaixadas.FieldByName('CTP_PARCEL').ASString,
                                  LDuplicatasBaixadas.FieldByName('CTP_SERIE_').ASString,
                                  LDuplicatasBaixadas.FieldByName('CTP_CODFOR').ASString,
                                  LDuplicatasBaixadas.FieldByName('CTP_CODEMP').ASString);

          LDuplicatasBaixadas.Refresh;
          Result := (LDuplicatasBaixadas.RecordCount > 0);
        End;

        cdsChqEmi.Next;
      End;

      cdsChqEmi.First;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LDuplicatasBaixadas);
  End;
end;

procedure TfrmManutChqEmi.edtCodBcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrBanco : TConsultasArray;
begin
  inherited;

  If fPesqBanco(Self, edtCodBco, edtNomBco, Nil, Key, arrBanco) Then
  Begin
    If fValidaCampos(edtCodBco, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmManutChqEmi.pEstornarPagarVinculado(ADuplicata, AParcela, ASerie, ACodigoFornecedor, ACodigoEmpresa: String);
Var
  frmEstornoPagar: TfrmEstornoPagar;
begin
  pCriarFormularios(TfrmEstornoPagar, frmEstornoPagar);
  try
    frmEstornoPagar.edtNumDup.Text := ADuplicata;
    frmEstornoPagar.edtParcel.Text := AParcela;
    frmEstornoPagar.edtSerie.Text  := ASerie;
    frmEstornoPagar.edtCodFor.Text := ACodigoFornecedor;
    frmEstornoPagar.edtNomFor.Text := fRetNomFornecedor(ACodigoFornecedor);
    frmEstornoPagar.edtCodEmp.Text := ACodigoEmpresa;
    frmEstornoPagar.edtNomEmp.Text := fRetNomeEmpresaSelec(ACodigoEmpresa);
    frmEstornoPagar.ShowModal;
  finally
    if Assigned(frmEstornoPagar) Then
      FreeAndNil(frmEstornoPagar)
  end;

end;

procedure TfrmManutChqEmi.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodBco);
end;

procedure TfrmManutChqEmi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(qryCadBco);

  If Assigned(qryChqEmi) Then
    FreeAndNil(qryChqEmi);

  If Assigned(cdsChqEmi) Then
    FreeAndNil(cdsChqEmi);

  If Assigned(dspChqEmi) Then
    FreeAndNil(dspChqEmi);

end;

procedure TfrmManutChqEmi.FormCreate(Sender: TObject);
begin
  inherited;

  qryCadBco := fCriarQuery('SELECT * FROM CADBCO WHERE FALSE', Self);

end;

procedure TfrmManutChqEmi.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If Key = VK_ESCAPE Then
  Begin
    If Assigned(cdsChqEmi) Then
      pLimpaDados
    Else
      inherited;
  End
  Else
    inherited;

  If Key = VK_F2 Then
    btnExcluir.Click;

  If Key = VK_F3 Then
    btnDuplic.Click;

end;

function TfrmManutChqEmi.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtCodBco Then
    Begin
      If Not fEmptyStr(edtCodBco.Text) Then
      Begin
        pCarregaBanco;

        If fEmptyStr(edtNomBco.Text) Then
        Begin
          fMensagem('','Este Banco não está casdastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtNomBco.Text := 'TODOS';
      End;
    End

    Else If Sender = edtNumAge Then
    Begin
      If Not fEmptyStr(edtNumAge.Text) Then
        edtNumAge.Text := fStrZero(edtNumAge.Text, edtNumAge.MaxLength);
    End

    Else If Sender = edtConCor Then
    Begin
      If Not fEmptyStr(edtConCor.Text) Then
        edtConCor.Text := fStrZero(edtConCor.Text, edtConCor.MaxLength);
    End

    Else If Sender = edtNumChq Then
    Begin
      If Not fEmptyStr(edtNumChq.Text) Then
      Begin
        edtNumChq.Text := fStrZero(edtNumChq.Text, edtNumChq.MaxLength);

        If mskDtaIni.Enabled Then
        Begin
          mskDtaIni.Enabled := False;
          mskDtaFin.Enabled := False;
          mskDtaIni.Clear;
          mskDtaFin.Clear;
        End;
      End
      Else
      Begin
        mskDtaIni.Enabled := True;
        mskDtaFin.Enabled := True;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And
             fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('','Data inicial deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If  fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And
           Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('','Data final deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And
              Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And
              (StrToDate(mskDtaFin.Text) < StrToDate(mskDtaIni.Text))Then
      Begin
        fMensagem('','Data final deve ser maior que data inicial!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmManutChqEmi.pCarregaBanco;
begin
  pPesquisaCadBco(qryCadBco, qryCadBco, edtCodBco.Text);
  With qryCadBco Do
  Begin
    edtNomBco.Text := FieldByName('BCO_NOMBCO').AsString;
  End;
end;

procedure TfrmManutChqEmi.pCriaTemporaria;
  Var
    strSQL: String;
begin

  qryChqEmi         := fCriaQuery(Self);
  dspChqEmi         := TUniDataSetProvider.Create(Self);
  dspChqEmi.DataSet := qryChqEmi;
  cdsChqEmi         := TUniClientDataSet.Create(Self);
  cdsChqEmi.SetProvider(dspChqEmi);

  strSQL := '';
  strSQL := strSQL + ' SELECT                                       ';
  strSQL := strSQL + '   EMI_CODBCO,                                ';
  strSQL := strSQL + '   EMI_NUMAGE,                                ';
  strSQL := strSQL + '   EMI_CONCOR,                                ';
  strSQL := strSQL + '   EMI_NUMCHQ,                                ';
  strSQL := strSQL + '   EMI_DTAEMI,                                ';
  strSQL := strSQL + '   EMI_BOMPAR,                                ';
  strSQL := strSQL + '   GROUP_CONCAT(DISTINCT EMI_CODEMP) AS EMI_CODEMP,    ';
  strSQL := strSQL + '   EMI_FAVORE,                                ';
  strSQL := strSQL + '   SUM(EMI_VALBAI) AS EMI_VALBAI,      ';
  strSQL := strSQL + '   ' + QuotedStr('D') + ' AS EMI_MARDES       ';
  strSQL := strSQL + ' FROM                                         ';
  strSQL := strSQL + '   CHQEMI                                     ';
  strSQL := strSQL + ' WHERE TRUE                                   ';

  If Not fEmptyStr(edtCodBco.Text) Then
    strSQL := strSQL + ' AND EMI_CODBCO = :CODBCO                   ';

  If Not fEmptyStr(edtNumAge.Text) Then
    strSQL := strSQL + ' AND EMI_NUMAGE LIKE "%' + IntToStr(StrToInt(edtNumAge.Text)) + '" ';

  If Not fEmptyStr(edtConCor.Text) Then
    strSQL := strSQL + ' AND EMI_CONCOR = :CONCOR                   ';

  If Not fEmptyStr(edtNumChq.Text) Then
    strSQL := strSQL + ' AND EMI_NUMCHQ = :NUMCHQ                   ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    strSQL := strSQL + ' AND EMI_DTAEMI BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + ' GROUP BY                                     ';
  strSQL := strSQL + '   EMI_CODBCO,                                ';
  strSQL := strSQL + '   EMI_NUMAGE,                                ';
  strSQL := strSQL + '   EMI_CONCOR,                                ';
  strSQL := strSQL + '   EMI_NUMCHQ,                                ';
  strSQL := strSQL + '   EMI_DTAEMI,                                ';
  strSQL := strSQL + '   EMI_BOMPAR,                                ';
  strSQL := strSQL + '   EMI_FAVORE                                 ';

  With qryChqEmi Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(edtCodBco.Text) Then
      ParamByName('CODBCO').AsString := edtCodBco.Text;

//    If Not fEmptyStr(edtNumAge.Text) Then
//      ParamByName('NUMAGE').AsString := IntToStr(StrToInt(edtNumAge.Text));

    If Not fEmptyStr(edtConCor.Text) Then
      ParamByName('CONCOR').AsString := edtConCor.Text;

    If Not fEmptyStr(edtNumChq.Text) Then
      ParamByName('NUMCHQ').AsString := edtNumChq.Text;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

    Open;
  End;

  pSetaClient(qryChqEmi);
  cdsChqEmi.Open;

  If Not cdsChqEmi.IsEmpty Then
    cdsChqEmi.First;

  (cdsChqEmi.FieldByName('EMI_VALBAI') As TFloatField).DisplayFormat := ',0.00';
  dtsCheques.DataSet := cdsChqEmi;

  FreeAndNil(qryChqEmi);
  FreeAndNil(dspChqEmi);

end;

procedure TfrmManutChqEmi.pDeletaCheques;
  Var
    qryDelChq: TUniQuery;
    strSQL   : String;
begin

  qryDelChq := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + ' DELETE FROM CHQEMI         ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   EMI_CODBCO = :CODBCO     ';
  strSQL := strSQL + '   AND EMI_NUMAGE = :NUMAGE ';
  strSQL := strSQL + '   AND EMI_CONCOR = :CONCOR ';
  strSQL := strSQL + '   AND EMI_NUMCHQ = :NUMCHQ ';

  cdsChqEmi.DisableControls;
  cdsChqEmi.Filtered := False;
  cdsChqEmi.Filter   := 'EMI_MARDES = ' + QuotedStr('M');
  cdsChqEmi.Filtered := True;

  cdsChqEmi.First;

  fStartTransaction;

  Try
    While Not cdsChqEmi.Eof Do
    Begin

      With qryDelChq Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := cdsChqEmi.FieldByName('EMI_CODBCO').AsString;
        ParamByName('NUMAGE').AsString := cdsChqEmi.FieldByName('EMI_NUMAGE').AsString;
        ParamByName('CONCOR').AsString := cdsChqEmi.FieldByName('EMI_CONCOR').AsString;
        ParamByName('NUMCHQ').AsString := cdsChqEmi.FieldByName('EMI_NUMCHQ').AsString;

        ExecSQL;
      End;

      cdsChqEmi.Next;
    End;

    fCommit;
  Except
    fRollBack;
    pMensagensErro('Erro ao excluir cheques!', 'TfrmManutChqEmi.pDeletaCheques') ;
  End;

  cdsChqEmi.Filtered := False;
  cdsChqEmi.EnableControls;

  pCriaTemporaria;

end;

procedure TfrmManutChqEmi.pLimpaDados;
begin

  edtCodBco.Clear;
  edtNomBco.Clear;
  edtNumAge.Clear;
  edtConCor.Clear;
  edtNumChq.Clear;
  mskDtaIni.Clear;
  mskDtaFin.Clear;

  cdsChqEmi.EmptyDataSet;
  FreeAndNil(cdsChqEmi);

  pSetFocus(edtCodBco);

end;

procedure TfrmManutChqEmi.pMostraDuplicatasCheque;
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(91, 5423, [],
                        ['CODBCO','NUMAGE','CONCOR','NUMCHQ','CODEMP'],
                        [cdsChqEmi.FieldByName('EMI_CODBCO').AsString,
                        cdsChqEmi.FieldByName('EMI_NUMAGE').AsString,
                        cdsChqEmi.FieldByName('EMI_CONCOR').AsString,
                        cdsChqEmi.FieldByName('EMI_NUMCHQ').AsString,
                        cdsChqEmi.FieldByName('EMI_CODEMP').AsString],
                        nil,
                        nil,
                        True);
  End;

end;

procedure TfrmManutChqEmi.pSelecionaDuplicata;
begin
  if Assigned(cdsChqEmi) then
  begin
    With cdsChqEmi Do
    Begin
      Edit;

      If FieldByName('EMI_MARDES').AsString = 'M' Then
        FieldByName('EMI_MARDES').AsString := 'D'
      Else
        FieldByName('EMI_MARDES').AsString := 'M';

      Post;
    End;
  end;

end;

end.
