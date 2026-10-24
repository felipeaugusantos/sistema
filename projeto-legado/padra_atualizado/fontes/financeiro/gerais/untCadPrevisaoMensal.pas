unit untCadPrevisaoMensal;

interface

uses
  Windows, Classes, Controls, DB, UniClientDataSet, UniDataSetProvider, Uni, AppEvnts,
  Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  CurrencyEditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGrid, cxCurrencyEdit, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Provider, untPaiOrdena, frxClass,
  frxExportCSVTestabilidade, cxContainer, cxTextEdit,
  Datasnap.DBClient, Vcl.ComCtrls,
  cxDataControllerConditionalFormattingRulesManagerDialog, untFuncoesRel,Forms,
  cxButtons, frxDBSet, frxExportPDF, Dialogs, untExcel;

type
  TfrmCadPrevisaoMensal = class(TfrmPaiOrdena)
    cdsReceitas: TUniClientDataSet;
    cdsConsultaCODEMP: TStringField;
    cdsConsultaDTALAN: TDateField;
    cdsConsultaANOPRE: TStringField;
    cdsConsultaDESREC: TStringField;
    cdsConsultaDESCRI: TStringField;
    cdsConsultaVAL001: TFloatField;
    cdsConsultaVAL002: TFloatField;
    cdsConsultaVAL003: TFloatField;
    cdsConsultaVAL004: TFloatField;
    cdsConsultaVAL005: TFloatField;
    cdsConsultaVAL006: TFloatField;
    cdsConsultaVAL007: TFloatField;
    cdsConsultaVAL008: TFloatField;
    cdsConsultaVAL009: TFloatField;
    cdsConsultaVAL010: TFloatField;
    cdsConsultaVAL011: TFloatField;
    cdsConsultaVAL012: TFloatField;
    cdsReceitasMESANO: TStringField;
    cdsReceitasDESREC: TStringField;
    cdsReceitasDESCRI: TStringField;
    cdsReceitasVAL001: TFloatField;
    cdsReceitasVAL002: TFloatField;
    cdsReceitasVAL003: TFloatField;
    cdsReceitasVAL004: TFloatField;
    cdsReceitasVAL005: TFloatField;
    cdsReceitasVAL006: TFloatField;
    cdsReceitasVAL007: TFloatField;
    cdsReceitasVAL008: TFloatField;
    cdsReceitasVAL009: TFloatField;
    cdsReceitasVAL010: TFloatField;
    cdsReceitasVAL011: TFloatField;
    cdsReceitasVAL012: TFloatField;
    cdsReceitasTotal: TFloatField;
    dtsReceitas: TDataSource;
    pnlTitRec: TPanel;
    Label4: TLabel;
    pnlTitDes: TPanel;
    Label5: TLabel;
    dtsDespesas: TDataSource;
    cdsDespesas: TUniClientDataSet;
    cdsDespesasANOPRE: TStringField;
    cdsDespesasDESREC: TStringField;
    cdsDespesasDESCRI: TStringField;
    cdsDespesasVAL001: TFloatField;
    cdsDespesasVAL002: TFloatField;
    cdsDespesasVAL003: TFloatField;
    cdsDespesasVAL004: TFloatField;
    cdsDespesasVAL005: TFloatField;
    cdsDespesasVAL006: TFloatField;
    cdsDespesasVAL007: TFloatField;
    cdsDespesasVAL008: TFloatField;
    cdsDespesasVAL009: TFloatField;
    cdsDespesasVAL010: TFloatField;
    cdsDespesasVAL011: TFloatField;
    cdsDespesasVAL012: TFloatField;
    cdsDespesasTotal: TFloatField;
    cdsDespesasCODCTA: TStringField;
    lbl1: TLabel;
    lbl3: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlTotais: TPanel;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxgViewDesp: TcxGridDBTableView;
    cxgDespL1: TcxGridLevel;
    cxgDespesas: TcxGrid;
    gdViewDespDESCRI: TcxGridDBColumn;
    gdViewDespVAL001: TcxGridDBColumn;
    gdViewDespVAL002: TcxGridDBColumn;
    gdViewDespVAL003: TcxGridDBColumn;
    gdViewDespVAL004: TcxGridDBColumn;
    gdViewDespVAL005: TcxGridDBColumn;
    gdViewDespVAL006: TcxGridDBColumn;
    gdViewDespVAL007: TcxGridDBColumn;
    gdViewDespVAL008: TcxGridDBColumn;
    gdViewDespVAL009: TcxGridDBColumn;
    gdViewDespVAL010: TcxGridDBColumn;
    gdViewDespVAL011: TcxGridDBColumn;
    gdViewDespVAL012: TcxGridDBColumn;
    gdViewDespTotal: TcxGridDBColumn;
    cdsDespesasTIPO: TStringField;
    gdViewDespTIPO: TcxGridDBColumn;
    btnConfirmar: TBitBtnLocked;
    btnHerdarPrevisao: TBitBtnLocked;
    btnCopiar: TBitBtnLocked;
    pgbProgresso: TProgressBar;
    mskAno: TEditFocus;
    dbViewDespCODCTA: TcxGridDBColumn;
    dbViewDespCODRES: TcxGridDBColumn;
    cdsDespesasCODRES: TStringField;
    btnImprimir: TBitBtnLocked;
    rdgMove: TRadioGroup;
    edtTotRec: TEditFocus;
    edtTotDes: TEditFocus;
    edtTotGer: TEditFocus;
    btnImportar: TcxButton;
    btnHlpImp: TcxButton;
    frxHelp: TfrxReport;
    frxRelatorioJ: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    cdsErros: TUniClientDataSet;
    cdsErrosDESCRICAO: TStringField;
    cdsErrosCODCTA: TStringField;
    frxDsErros: TfrxDBDataset;
    btnCarregar: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure dbgConsultaExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnHerdarPrevisaoClick(Sender: TObject);
    procedure cdsDespesasAfterPost(DataSet: TDataSet);
    procedure cdsReceitasAfterPost(DataSet: TDataSet);
    procedure cdsReceitasBeforePost(DataSet: TDataSet);
    procedure cdsDespesasBeforePost(DataSet: TDataSet);
    procedure cxgViewDespCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cdsDespesasAfterScroll(DataSet: TDataSet);
    procedure cxgDespesasExit(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCopiarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mskAnoKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImportarClick(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure cxgViewDespEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure btnHlpImpClick(Sender: TObject);
    procedure cxgViewDespEditValueChanged(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem);
  private
    { Private declarations }
    fltTotalRec : Double;
    fltTotalDes : Double;
    intMesBas   : Integer;
    blnGravando: Boolean;
    cdsDespesasAnt,
    cdsReceitasAnt: TUniClientDataSet;
    LChaveLck: String;
    blnAtualizaImportacao : boolean;
    FEmpresaCarregada : String;
    FAnoCarregado : String;

    procedure pAbreConsulta;
    procedure pIncluiRegistros;
    procedure pPreencheReceitas(strCodEmp: String; strAno: String; fltFator: Double = 1);
    procedure pPreencheDespesas(strCodEmp: String; strAno: String; fltFator: Double = 1);
    procedure PreencheDespesasFinanceiras(ACodEmp,AAno: String;AFator: Double);
    procedure PreencheDespesasVariaveis(ACodEmp,AAno: String;AFator: Double);
    procedure PreencheDespesas(ACodEmp,AAno: String;AFator: Double);
    function TemContaResultado(ACodCta: String): Boolean;
    function fFormataConta(strCodCta: String): String;
    procedure pAtualizaTotais(blnReceitas: Boolean);
    function fGravaReceitas(AControlaTransacao: Boolean = True): Boolean;
    function fGravaDespesas(AControlaTransacao: Boolean = True): Boolean;
    function fValidaAno(strAno: String): Boolean;
    procedure pLimpaEdits;
    procedure pLimpaGridsComValores;
    procedure pTotaisGruposDespesas;
    procedure pCopiaPrevisao;

    function ExisteReceitaFixaNoAno(ACodEmp, AReceitaDespesa,
      AAno: String): Boolean;
    function fRelacionaArquivo(strArqInc: String): Boolean;
    function fVerificaMovimento: Boolean;
    function fImportaArquivo : Boolean;
    function FormataValorFloat(AValor: String): Double;
    function fRetornaPlanoContas(strPlContas: String): String;
    function fRedirecionaValoresReceitasAlteradas(strReceitaAlterada : String): Boolean;
    procedure pDeleteCadPmeReceitas;
    procedure pDeleteCadPmeDespesas;
    function fTemCadPme: Boolean;
    function EmpresaAnoCarregadosBatem: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, Variants, Graphics, untFuncoesSimples, untFuncoes,
  untHerdarPrevisao, untConsultas, untCadPrevMesBase, untTypesSistema, untSubjectIntf, untGravandoObs, untSubjectClass, StrUtils;

{$R *.dfm}

procedure TfrmCadPrevisaoMensal.btnCarregarClick(Sender: TObject);
begin
  inherited;

  blnAtualizaImportacao := False;

  if Not fValidacampos(mskAno, True) Then
     Exit;

  if Not fValidacampos(edtCodEmp, True) Then
     Exit;

  pAbreConsulta;

  btnImportar.enabled := False;

end;

procedure TfrmCadPrevisaoMensal.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  blnGravando := True;

  if not fValidacampos(mskAno, True) Then
    Exit;

  if not fValidacampos(edtCodEmp, True) Then
    Exit;

  If Not EmpresaAnoCarregadosBatem Then
    Exit;

  If (cdsReceitas.IsEmpty) and (cdsDespesas.IsEmpty) Then
  Begin
    fMensagem('AVISO', 'É necessário carregar os registros para confirmar.', ['&Ok']);
    Exit;
  end;

  fStartTransaction;
  Try
    If fGravaReceitas(False) And fGravaDespesas(False) Then
    Begin
      fCommit;
      fMensagem('', 'Previsão gravada com sucesso!', ['&Ok']);
      pLimpaGridsComValores;
      btnCopiar.Enabled := False;
    End
    Else
    Begin
      fRollBack;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadPrevisaoMensal.btnConfirmarClick]');
    End;
  End;

  pLimpaEdits;
end;

procedure TfrmCadPrevisaoMensal.btnCopiarClick(Sender: TObject);
  Var
    frmCadPrevMesBase: TfrmCadPrevMesBase;
begin
  inherited;
  blnAtualizaImportacao := False;
  pCriarFormularios(TfrmCadPrevMesBase, frmCadPrevMesBase);
  frmCadPrevMesBase.ShowModal;
  intMesBas := frmCadPrevMesBase.intMesBas;

  FreeAndNil(frmCadPrevMesBase);

  If intMesBas > 0 Then
  Begin
    pnlInfo.Caption := 'Aguarde, copiando previsões com base no mês ' + IntToStr(intMesBas) + '...';
    pCopiaPrevisao;
  End;

  pnlInfo.Caption := '';

end;

procedure TfrmCadPrevisaoMensal.btnHerdarPrevisaoClick(Sender: TObject);
  Var
    qryAux : TUniQuery;
    intCont: Integer;
    blnAlteraAno: Boolean;

begin
  inherited;

  blnAtualizaImportacao := False;
  pLimpaGridsComValores;

  pCriarFormularios(TfrmHerdarPrevisao, frmHerdarPrevisao);

  With frmHerdarPrevisao Do
  Begin

    blnAlteraAno := False;
    If ShowModal = mrOk Then
    Begin
      blnAlteraAno := True;
      qryAux := fCriarQuery('SELECT * FROM CADPME ' +
                            ' WHERE PME_CODEMP =  ' + QuotedStr(edtCodEmpDest.Text) +
                            '   AND YEAR(PME_MESANO) = ' + QuotedStr(mskAnoDest.Text) + ' LIMIT 1 ');
      qryAux.Open;

      If Not qryAux.IsEmpty Then
      Begin
        If fMensagem('', 'Já existe uma previsão cadastrada para a empresa ' + edtCodEmpDest.Text +
                         '-' + edtDesEmpDest.Text + ' do ano ' + mskAnoDest.Text +
                         '. Deseja sobrescreve-la?', ['&Sim', '&Não']) = 1  Then
        Begin
          pPreencheDespesas(edtCodEmpOrig.Text, mskAnoOrig.Text, edtFatorDest.Value);
          cdsDespesas.First;
          cdsDespesas.EnableControls;
          pTotaisGruposDespesas;
          pAtualizaTotais(False);

          pPreencheReceitas(edtCodEmpOrig.Text, mskAnoOrig.Text, edtFatorDest.Value);
          cdsReceitas.First;
          cdsReceitas.EnableControls;
          pAtualizaTotais(True);

          mskAno.Text    := mskAnoDest.Text;
          edtCodEmp.Text := edtCodEmpDest.Text;
          edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
          dbgConsulta.Options := dbgConsulta.Options + [dgEditing];
        End;
      End
      Else
      Begin
        pPreencheDespesas(edtCodEmpOrig.Text, mskAnoOrig.Text, edtFatorDest.Value);
        cdsDespesas.First;
        cdsDespesas.EnableControls;
        pTotaisGruposDespesas;
        pAtualizaTotais(False);

        pPreencheReceitas(edtCodEmpOrig.Text, mskAnoOrig.Text, edtFatorDest.Value);
        cdsReceitas.First;
        cdsReceitas.EnableControls;
        pAtualizaTotais(True);

        mskAno.Text    := mskAnoDest.Text;
        edtCodEmp.Text := edtCodEmpDest.Text;
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        dbgConsulta.Options := dbgConsulta.Options + [dgEditing];
      End;

    End;

  End;

  if blnAlteraAno then
  begin
    For intCont := 1 to 12 do
    Begin
      cxgViewDesp.Columns[intCont].Caption := fStrZero(IntToStr(intCont), 02) + '/' + mskAno.Text;
      dbgConsulta.Columns[intCont].Title.Caption := fStrZero(IntToStr(intCont), 02) + '/' + mskAno.Text;
    End;
  end;

  FreeAndNil(frmHerdarPrevisao);

end;

procedure TfrmCadPrevisaoMensal.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp)
end;

procedure TfrmCadPrevisaoMensal.btnImportarClick(Sender: TObject);
begin
  inherited;

  if Not fValidacampos(mskAno, True) Then
     Exit;

  if Not fValidacampos(edtCodEmp, True) Then
     Exit;

  If Not EmpresaAnoCarregadosBatem Then
    Exit;

  If fImportaArquivo Then
  Begin
     If (fGravaReceitas And fGravaDespesas ) Then
     Begin
       fMensagem('', 'Previsão gravada com sucesso!', ['&Ok']);
       //pLimpaGridsComValores;
       blnAtualizaImportacao := False;
     End;
  End;

end;

procedure TfrmCadPrevisaoMensal.btnImprimirClick(Sender: TObject);
begin
  inherited;

  if fEmptyStr(mskAno.Text) then
    Exit;

  if fEmptyStr(edtCodEmp.Text) then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
      prcExecutaRelatorio(332, 13177, [13177],
                          ['ANO', 'CODEMP'],
                          [mskAno.Text, edtCodEmp.Text],
                          Sender);

end;

procedure TfrmCadPrevisaoMensal.btnSairClick(Sender: TObject);
begin
  If Not (cdsReceitas.IsEmpty) Or
     Not (cdsDespesas.IsEmpty) Then
  Begin
    If fMensagem('', 'Deseja cancelar este cadastro?', ['&Sim', '&Não']) = 1 Then
    Begin
      blnAtualizaImportacao := False;
      pLimpaGridsComValores;
      pLimpaEdits;
      Exit;
    End
    Else
      Exit;
  End;

  If (cdsReceitas.IsEmpty) and
     (cdsDespesas.IsEmpty) Then
  Begin
    Close;
  end;
end;

procedure TfrmCadPrevisaoMensal.cdsDespesasAfterPost(DataSet: TDataSet);
begin
  inherited;

  pAtualizaTotais(False);

end;

procedure TfrmCadPrevisaoMensal.cdsDespesasAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If cdsDespesasTIPO.Value = 'G' Then
       cxgViewDesp.OptionsData.Editing := False
  Else cxgViewDesp.OptionsData.Editing := True;

end;

procedure TfrmCadPrevisaoMensal.cdsDespesasBeforePost(DataSet: TDataSet);
begin
  inherited;

  cdsDespesas.FieldByName('Total').AsFloat := cdsDespesas.FieldByName('VAL001').AsFloat + cdsDespesas.FieldByName('VAL002').AsFloat +
                                              cdsDespesas.FieldByName('VAL003').AsFloat + cdsDespesas.FieldByName('VAL004').AsFloat +
                                              cdsDespesas.FieldByName('VAL005').AsFloat + cdsDespesas.FieldByName('VAL006').AsFloat +
                                              cdsDespesas.FieldByName('VAL007').AsFloat + cdsDespesas.FieldByName('VAL008').AsFloat +
                                              cdsDespesas.FieldByName('VAL009').AsFloat + cdsDespesas.FieldByName('VAL010').AsFloat +
                                              cdsDespesas.FieldByName('VAL011').AsFloat + cdsDespesas.FieldByName('VAL012').AsFloat ;

end;

procedure TfrmCadPrevisaoMensal.cdsReceitasAfterPost(DataSet: TDataSet);
begin
  inherited;

  pAtualizaTotais(True);

end;

procedure TfrmCadPrevisaoMensal.cdsReceitasBeforePost(DataSet: TDataSet);
begin
  inherited;

  cdsReceitas.FieldByName('Total').AsFloat := cdsReceitas.FieldByName('VAL001').AsFloat + cdsReceitas.FieldByName('VAL002').AsFloat +
                                              cdsReceitas.FieldByName('VAL003').AsFloat + cdsReceitas.FieldByName('VAL004').AsFloat +
                                              cdsReceitas.FieldByName('VAL005').AsFloat + cdsReceitas.FieldByName('VAL006').AsFloat +
                                              cdsReceitas.FieldByName('VAL007').AsFloat + cdsReceitas.FieldByName('VAL008').AsFloat +
                                              cdsReceitas.FieldByName('VAL009').AsFloat + cdsReceitas.FieldByName('VAL010').AsFloat +
                                              cdsReceitas.FieldByName('VAL011').AsFloat + cdsReceitas.FieldByName('VAL012').AsFloat ;

end;

procedure TfrmCadPrevisaoMensal.cxgDespesasExit(Sender: TObject);
begin
  inherited;
  cdsDespesas.First;
end;

procedure TfrmCadPrevisaoMensal.cxgViewDespCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var strGrupo: String;
begin
  inherited;

  strGrupo := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, gdViewDespTIPO.Index]);
  If (strGrupo = 'G') Then
    ACanvas.Brush.Color := clGray;

end;

procedure TfrmCadPrevisaoMensal.cxgViewDespEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);

  Var
      blnFimLinha : Boolean;
begin
  inherited;

  If (Key = VK_RETURN) And (Not cdsDespesas.IsEmpty) Then
  Begin

    If rdgMove.itemIndex = 0 Then // Vertical
    Begin

       If (AItem.Index > 0) And (AItem.Index <= 13) Then
       Begin

         If (cdsDespesas.RecNo = cdsDespesas.RecordCount) Then
         Begin
            cdsDespesas.First;

            If (AItem.Index <= 13) Then
            Begin
               If (AItem.Index = 13) Then
                  cxgViewDesp.Columns[1].FocusWithSelection
               Else
                  cxgViewDesp.Columns[AItem.Index + 1].FocusWithSelection
            End;

            If cdsDespesas.FieldByName('TIPO').AsString = 'G' Then
               cdsDespesas.Next;

         End
         Else
         Begin
            cdsDespesas.Next;
            If cdsDespesas.FieldByName('TIPO').AsString = 'G' Then
               cdsDespesas.Next;

            cxgViewDesp.Columns[AItem.Index].FocusWithSelection;
         End;

         Keybd_Event(13,0,0,0);

       End;

    End
    Else
    If rdgMove.itemIndex = 1 Then // Horizontal
    Begin

       blnFimLinha := False;

       If (AItem.Index > 0) And (AItem.Index <= 13) Then
       Begin

         If (AItem.Index = 13) Then
            blnFimLinha := True;

         If cdsDespesas.FieldByName('TIPO').AsString = 'G' Then
         Begin

            If Not (cdsDespesas.RecNo = cdsDespesas.RecordCount) Then
               cdsDespesas.Next
            Else
               cdsDespesas.First;

            cxgViewDesp.Columns[1].FocusWithSelection;

            Keybd_Event(13,0,0,0);

         End
         Else
         Begin

           If blnFimLinha Then
           Begin

              If Not (cdsDespesas.RecNo = cdsDespesas.RecordCount) Then
              Begin
                 cdsDespesas.Next;
                 If cdsDespesas.FieldByName('TIPO').AsString = 'G' Then
                 Begin
                    If Not (cdsDespesas.RecNo = cdsDespesas.RecordCount) Then
                       cdsDespesas.Next
                    Else
                       cdsDespesas.first;
                 End;
              End
              Else
                 cdsDespesas.First;

              cxgViewDesp.Columns[1].FocusWithSelection;
           End
           Else
              cxgViewDesp.Columns[AItem.Index + 1].FocusWithSelection;  //Focused := True;

           Keybd_Event(13,0,0,0);

         End;

       End;

    End;

  End;

end;

procedure TfrmCadPrevisaoMensal.cxgViewDespEditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  inherited;
  Keybd_Event(13,0,0,0);
end;

procedure TfrmCadPrevisaoMensal.dbgConsultaExit(Sender: TObject);
begin
  inherited;

  cdsReceitas.First;

end;

procedure TfrmCadPrevisaoMensal.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_DELETE) Or
     (Key = VK_INSERT) Or
     ((Key = VK_DOWN) And
      (cdsReceitas.RecNo = cdsReceitas.RecordCount)) Or
     ((Key = VK_TAB) And
      (cdsReceitas.RecNo = cdsReceitas.RecordCount) And
      (dbgConsulta.Columns.Items[13].Index = dbgConsulta.SelectedIndex )) Or
     ((Key = VK_RIGHT) And
      (cdsReceitas.RecNo = cdsReceitas.RecordCount) And
      (dbgConsulta.Columns.Items[13].Index = dbgConsulta.SelectedIndex )) Then
    Key := 0

  Else
  If (Key = VK_RETURN) And (Not cdsReceitas.IsEmpty) Then
  Begin

    If (dbgConsulta.SelectedIndex > 0) And (dbgConsulta.SelectedIndex <= 13) Then
    Begin

       If rdgMove.itemIndex = 0 Then // Vertical
       Begin

         If dbgConsulta.SelectedIndex = 13 Then
         Begin
            If Not (cdsReceitas.recNo = cdsReceitas.recordcount) Then
               cdsReceitas.Next
            Else
            Begin
               cdsReceitas.First;
               dbgConsulta.SelectedIndex := 1;
            End;

         End
         Else
         Begin
           If Not (cdsReceitas.recNo = cdsReceitas.recordcount) Then
              cdsReceitas.Next
           Else
           Begin
              cdsReceitas.First;
              dbgConsulta.SelectedIndex := dbgConsulta.SelectedIndex + 1;
           End;
         End;

       End
       Else  //Horizontal
       Begin

         If dbgConsulta.SelectedIndex = 13 Then
         Begin

            If Not (cdsReceitas.recordcount = cdsReceitas.recNo) Then
            Begin
               cdsReceitas.Next;
               dbgConsulta.SelectedIndex := 1;
            End
            Else
            Begin
               cdsReceitas.First;
               dbgConsulta.SelectedIndex := 1;
            End;

         End
         Else
         Begin
           If Not cdsReceitas.Eof Then
              dbgConsulta.SelectedIndex := dbgConsulta.SelectedIndex + 1
           Else
           Begin
              cdsReceitas.First;
              dbgConsulta.SelectedIndex := 1;
           End;
         End;

       End;

    End;

  End;

end;

procedure TfrmCadPrevisaoMensal.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  blnGravando := False;
  inherited;

  If ((fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp)) or (Key = #13)) Then
  Begin
    If (Not fEmptyStr(FEmpresaCarregada)) And
       (FEmpresaCarregada <> edtCodEmp.Text) Then
    Begin
      If (Not cdsReceitas.IsEmpty) Or (Not cdsDespesas.IsEmpty) Then
      Begin
        If fMensagem('ATENÇÃO',
              'Você trocou a empresa. Suas alterações atuais de ' + FEmpresaCarregada +
              ' serão descartados. Continuar?',
              ['&Sim', '&Não'], 1) <> 1 Then
        Begin
          edtCodEmp.Text := FEmpresaCarregada;
          pSetFocus(edtCodEmp);
          Exit;
        End;
      End;

      pLimpaGridsComValores;
      FEmpresaCarregada := '';
      FAnoCarregado := '';
      btnCopiar.Enabled := False;
    End;

    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadPrevisaoMensal.pCopiaPrevisao;
  Var
    intCont : Integer;
begin

  Try
    cdsReceitas.DisableControls;
    cdsReceitas.First;

    While Not cdsReceitas.Eof Do
    Begin
      For intCont := 1 To 12 Do
      Begin
        cdsReceitas.Edit;
        cdsReceitas.FieldByName('VAL' + fPadL(IntToStr(intCont), 3, '0')).AsFloat := cdsReceitas.FieldByName('VAL' + fPadL(IntToStr(intMesBas), 3, '0')).AsFloat;
        cdsReceitas.Post;
      End;

      cdsReceitas.Next;
    End;
    cdsReceitas.First;
    cdsReceitas.EnableControls;

    cdsDespesas.DisableControls;
    cdsDespesas.First;

    While Not cdsDespesas.Eof Do
    Begin
      cdsDespesas.Edit;
      For intCont := 1 To 12 Do
      Begin
        cdsDespesas.FieldByName('VAL' + fPadL(IntToStr(intCont), 3, '0')).AsFloat := cdsDespesas.FieldByName('VAL' + fPadL(IntToStr(intMesBas), 3, '0')).AsFloat;
      End;
      cdsDespesas.Post;

      cdsDespesas.Next;
    End;
    cdsDespesas.First;
    cdsDespesas.EnableControls;

    fMensagem('', 'Previsão copiada com sucesso!', ['&Ok']);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadPrevisaoMensal.pCopiaPrevisao]');
    End;
  End;

end;

procedure TfrmCadPrevisaoMensal.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskAno);
end;

function TfrmCadPrevisaoMensal.FormataValorFloat(AValor: String): Double;
var
  LDigitosDepoisUltimoDelimitador, LQtdPontos, LQtdVirgulas: Integer;
  LDelimitadorUnico, LNaoTemDigitosDecimais: Boolean;
begin
  AValor := Trim(AValor);
  LDigitosDepoisUltimoDelimitador := Length(AValor) - LastDelimiter('.,', AValor);
  LQtdPontos := AValor.CountChar('.');
  LQtdVirgulas := AValor.CountChar(',');

  LDelimitadorUnico :=
    ((LQtdPontos = 1) And (LQtdVirgulas = 0)) Or
    ((LQtdVirgulas = 1) And (LQtdPontos = 0));

  LNaoTemDigitosDecimais :=
    ((LQtdPontos + LQtdVirgulas) = 0) Or
    ((LQtdPontos > 1) And (LQtdVirgulas = 0)) Or
    ((LQtdVirgulas > 1) And (LQtdPontos = 0));

  If (LDigitosDepoisUltimoDelimitador > 2) And LDelimitadorUnico Then
    raise Exception.CreateFmt('MENSAGEM-O valor "%s" não pode ser lido, pois não segue o padrão do sistema.', [AValor])
  Else If LNaoTemDigitosDecimais Then
    AValor := AValor + '00'
  Else If (LDigitosDepoisUltimoDelimitador = 1) Then
    AValor := AValor + '0';

  AValor := AValor.Replace('.','', [rfReplaceAll]);
  AValor := AValor.Replace(',','', [rfReplaceAll]);
  Result := fFormataFloat((fStrToFloat(AValor) / 100),2);
end;

procedure TfrmCadPrevisaoMensal.FormCreate(Sender: TObject);
begin
  inherited;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
  cdsReceitas.CreateDataSet;
  cdsDespesas.CreateDataSet;
  fltTotalRec := 0;
  fltTotalDes := 0;

  cdsReceitasAnt := TUniClientDataSet.Create(Self);
  cdsDespesasAnt := TUniClientDataSet.Create(Self);
  blnSempreRelerBanco := False;
end;

procedure TfrmCadPrevisaoMensal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  blnGravando := False;
  If Shift = [ssAlt] Then
  Begin
    Case UpperCase(Chr(Key))[1] Of
      'R' : pSetFocus(dbgConsulta);
      'D' : pSetFocus(cxgDespesas);
    End;
  End;

  Case Key Of
    VK_ESCAPE : If Not (cdsReceitas.IsEmpty) Or
                   Not (cdsDespesas.IsEmpty) Then
                Begin
                  If fMensagem('', 'Deseja cancelar este cadastro?', ['&Sim', '&Não']) = 1 Then
                  Begin
                    pLimpaGridsComValores;
                    pLimpaEdits;
                    Exit;
                  End
                  Else
                    Exit;
                End;

    VK_RETURN : If (cdsDespesas.Active) And (cdsDespesas.State = dsEdit) Then
                Begin
                  cdsDespesas.Post;
                  pTotaisGruposDespesas;
                End;

    VK_F3  : Key := 0;
    VK_F5  : Key := 0;
  End;

  inherited;
  Case Key Of
    VK_F8  : btnHerdarPrevisao.Click;
    VK_F10 : Begin
               pSetFocus(btnConfirmar);
               btnConfirmar.Click;
             End;
    VK_F7  : btnCopiar.Click;
    VK_F9  : btnImprimir.Click;
  End;
end;

procedure TfrmCadPrevisaoMensal.FormShow(Sender: TObject);
begin
  inherited;

  btnMudaOrdem.Visible := False;
  btnPesquisar.Visible := False;
  pnlPesquisa.Visible  := False;

  Self.Height := Self.Height - 40;

  pSetFocus(mskAno);

  cdsReceitas.FieldByName('VAL001').EditMask := '999999999';
  cdsReceitas.FieldByName('VAL002').EditMask := '999999999';
  cdsReceitas.FieldByName('VAL003').EditMask := '999999999';
  cdsReceitas.FieldByName('VAL004').EditMask := '999999999';
  cdsReceitas.FieldByName('VAL005').EditMask := '999999999';
  cdsReceitas.FieldByName('VAL006').EditMask := '999999999';
  cdsReceitas.FieldByName('VAL007').EditMask := '999999999';
  cdsReceitas.FieldByName('VAL008').EditMask := '999999999';
  cdsReceitas.FieldByName('VAL009').EditMask := '999999999';
  cdsReceitas.FieldByName('VAL010').EditMask := '999999999';
  cdsReceitas.FieldByName('VAL011').EditMask := '999999999';
  cdsReceitas.FieldByName('VAL012').EditMask := '999999999';
  cdsReceitas.FieldByName('TOTAL').EditMask := '999999999';

  blnAtualizaImportacao := False;
end;

function TfrmCadPrevisaoMensal.fValidaAno(strAno: String): Boolean;
var
  strData: String;
begin

  Try
    strData := ('01/01/' + strAno);

    If (StrToDateDef(strData, 0) <= 0) then
      Result := False
    else
     Result := True;
  Except
    Result := False;
  End;

end;

function TfrmCadPrevisaoMensal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskAno) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskAno.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informar o ano desejado!', ['&O k']);
        Result := False;
        pSetFocus(mskAno);
      End
      Else If (Not fValidaAno(fTiraCaracEspeciais(mskAno.Text))) or (Length(Trim(fTiraCaracEspeciais(mskAno.Text))) < 4) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um ano válido!', ['&O K']);
        Result := False;
        pSetFocus(mskAno);
      End;

    End
    Else If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!','Informar a Empresa!',['&O K']);
        Result := False;
        pSetFocus(edtCodEmp);
      End
      Else
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
          pSetFocus(edtCodEmp);
        End
        Else
        Begin
          edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
          If fEmptyStr(edtDesEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!','Essa empresa não está cadastrada!',['&O K']);
            Result := False;
            pSetFocus(edtCodEmp);
          End;
        End;
      End;

      If fEmptyStr(fTiraCaracEspeciais(mskAno.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informar o ano desejado!', ['&O k']);
        Result := False;
        pSetFocus(mskAno);
      End
      Else If (Not fValidaAno(fTiraCaracEspeciais(mskAno.Text))) or (Length(Trim(fTiraCaracEspeciais(mskAno.Text))) < 4) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um ano válido!', ['&O K']);
        Result := False;
        pSetFocus(mskAno);
      End;

    End;

  End;
end;

procedure TfrmCadPrevisaoMensal.mskAnoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 Then
  begin
    blnGravando := False;
    if not fValidacampos(mskAno, True) Then
      Exit;

    If (Not fEmptyStr(FAnoCarregado)) And
       (FAnoCarregado <> mskAno.Text) Then
    Begin
      If (Not cdsReceitas.IsEmpty) Or (Not cdsDespesas.IsEmpty) Then
      Begin
        If fMensagem('ATENÇÃO',
              'Você trocou o ano. Suas alterações atuais de ' + FAnoCarregado +
              ' serão descartados. Continuar?',
              ['&Sim', '&Não'], 1) <> 1 Then
        Begin
          mskAno.Text := FAnoCarregado;
          pSetFocus(mskAno);
          Exit;
        End;
      End;

      pLimpaGridsComValores;
      FEmpresaCarregada := '';
      FAnoCarregado := '';
      btnCopiar.Enabled := False;
    End;
  end;
end;

procedure TfrmCadPrevisaoMensal.pAbreConsulta;
  Var
    intCont: Integer;
begin

  If Not fEmptyStr(LChaveLck) Then
  Begin
    fLock_Unlock(LChaveLck, False);
  End;

  LChaveLck := Concat('CADPME','_',mskAno.Text,'_',edtCodEmp.Text);
  If Not fLock_Unlock(LChaveLck, True, False) Then
  Begin
    fMensagem('ATENÇÃO', 'Previsão mensal' + ' do ano ' + mskAno.Text +
                         ' para a empresa ' + edtCodEmp.Text + '-' + edtDesEmp.Text +
                         ' já está em uso por outra estação: ' + fGetHostLock(LChaveLck), ['&OK']);
    LChaveLck := '';
    Exit;
  End;

  If cdsReceitas.Active Then
    cdsReceitas.CancelUpdates;

  If cdsDespesas.Active Then
    cdsDespesas.CancelUpdates;

  For intCont := 1 to 12 do
  Begin
    cxgViewDesp.Columns[intCont].Caption := fStrZero(IntToStr(intCont), 02) + '/' + mskAno.Text;
    dbgConsulta.Columns[intCont].Title.Caption := fStrZero(IntToStr(intCont), 02) + '/' + mskAno.Text;
  End;

  pIncluiRegistros;
  cdsDespesasAnt.Data := cdsDespesas.Data;
  cdsDespesasAnt.IndexFieldNames := 'CODRES;CODCTA';
  cdsDespesasAnt.First;

  btnCopiar.Enabled := True;
  FEmpresaCarregada  := edtCodEmp.Text;
  FAnoCarregado  := mskAno.Text;
  dbgConsulta.Options := dbgConsulta.Options + [dgEditing];

end;

procedure TfrmCadPrevisaoMensal.pAtualizaTotais(blnReceitas: Boolean);
  Var
    cdsAux : TUniClientDataSet;
begin

  cdsAux := TUniClientDataSet.Create(Self);

  If blnReceitas Then
  Begin
    cdsAux.Data := cdsReceitas.Data;
    fltTotalRec := 0;
  End
  Else
  Begin
    cdsAux.Data := cdsDespesas.Data;
    fltTotalDes := 0;
  End;

  With cdsAux Do
  Begin

    If Not blnReceitas Then
    Begin
      Filtered := False;
      Filter   := 'TIPO = ' + QuotedStr('C');
      Filtered := True;
    End;

    First;
    While Not Eof Do
    Begin
      If blnReceitas Then
        fltTotalRec := fltTotalRec + FieldByName('Total').AsFloat
      Else
        fltTotalDes := fltTotalDes + FieldByName('Total').AsFloat;

      Next;
    End;

    Filtered := False;
    Filter   := '';
  End;

  edtTotRec.text := FloatToStrF(fltTotalRec, ffNumber, 12, 2);
  edtTotDes.text := FloatToStrF(fltTotalDes, ffNumber, 12, 2);
  edtTotGer.text := FloatToStrF(fltTotalRec - fltTotalDes, ffNumber, 12, 2);

  FreeAndNil(cdsAux);

end;


function TfrmCadPrevisaoMensal.fFormataConta(strCodCta: String): String;
begin
  Result := Copy(strCodCta, 1, 2) + '.' +
            Copy(strCodCta, 3, 2) + '.' +
            Copy(strCodCta, 5, 3);
end;

function TfrmCadPrevisaoMensal.fGravaDespesas(AControlaTransacao: Boolean = True): Boolean;
Var
  LQryDespesas,
  LQryPlanoContas,
  LQryContaResultado : TUniQuery;
  LMes       : Integer;
  LPrcScroll  : TprcScroll;
  LTemCtaRes,
  LTemCadCta: Boolean;
begin
  LQryDespesas := nil;
  LQryPlanoContas := nil;
  LQryContaResultado := nil;

  Result := False;

  pgbProgresso.Visible := True;
  pgbProgresso.Max := cdsDespesas.RecordCount;

  Try
    Try
      pDisableControls(cdsDespesas, LPrcScroll);
      LQryDespesas := fCriaQuery;

      LQryPlanoContas := fCriarQuery(' SELECT CTA_CODCTA FROM CADCTA ');
      LQryPlanoContas.Open;

      LQryContaResultado := fCriarQuery(' SELECT DISTINCT CRE_CODCRE FROM CTARES ');
      LQryContaResultado.Open;

      If AControlaTransacao Then
        fStartTransaction;

      cdsDespesas.First;
      cdsDespesasAnt.First;

      pDeleteCadPmeDespesas;
      While Not cdsDespesas.Eof Do
      Begin
        LTemCadCta :=
          Not fEmptyStr(cdsDespesas.FieldByName('CODCTA').AsString) And
          LQryPlanoContas.Locate('CTA_CODCTA', fTiraPontoVirgula(cdsDespesas.FieldByName('CODCTA').AsString), []);

        LTemCtaRes :=
          Not fEmptyStr(cdsDespesas.FieldByName('CODRES').AsString) And
          LQryContaResultado.Locate('CRE_CODCRE', cdsDespesas.FieldByName('CODRES').AsString, []);

        LQryDespesas.Close;
        LQryDespesas.SQL.Clear;
        LQryDespesas.SQL.Add(
          'INSERT INTO CADPME '+
          '(PME_DESREC, PME_MESANO, PME_VALMES, '+
          ' PME_DESCRI, PME_CODEMP, AUTOINCREM ');

        if LTemCadCta then
          LQryDespesas.SQL.Add(' ,PME_CODCTA ');

        if LTemCtaRes then
          LQryDespesas.SQL.Add(' ,PME_CODRES ');

        LQryDespesas.SQL.Add(
          ' ) VALUES('+
          ':DESREC, :MESANO, :VALMES,'+
          ':DESCRI, :CODEMP, :AUTOIN ');

        if LTemCadCta then
        begin
          LQryDespesas.SQL.Add(' ,:CODCTA ');
          LQryDespesas.ParamByName('CODCTA').AsString := fTiraPontoVirgula(cdsDespesas.FieldByName('CODCTA').AsString);
        end;

        if LTemCtaRes then
        begin
          LQryDespesas.SQL.Add(' ,:CODRES ');
          LQryDespesas.ParamByName('CODRES').AsString := cdsDespesas.FieldByName('CODRES').AsString;
        end;

        LQryDespesas.SQL.Add(' ) ');

        For LMes := 1 To 12 Do
        Begin
          LQryDespesas.Close;
          LQryDespesas.ParamByName('DESREC').AsString   := 'D';
          LQryDespesas.ParamByName('MESANO').AsDateTime := StrToDate('01/' + fStrZero(IntToStr(LMes), 02) + '/' + mskAno.Text);
          LQryDespesas.ParamByName('VALMES').AsFloat    := cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(LMes), 03)).AsFloat;
          LQryDespesas.ParamByName('DESCRI').AsString   := cdsDespesas.FieldByName('DESCRI').AsString;
          LQryDespesas.ParamByName('CODEMP').AsString   := edtCodEmp.Text;
          LQryDespesas.ParamByName('AUTOIN').AsString   := fRetAutoIncrem('CADPME', edtCodEmp.Text);
          LQryDespesas.ExecSQL;
		  
          Application.ProcessMessages;
        End;

        cdsDespesas.Next;
        cdsDespesasAnt.Next;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        pgbProgresso.Repaint;
        Application.ProcessMessages;
      End;

      If AControlaTransacao Then
        fCommit;

      Result := True;
    Except
      On E: Exception Do
      Begin
        If AControlaTransacao Then
          fRollBack;

        If Pos('AUT001', E.Message) <= 0 Then
          pMensagensErro(E.Message,'[TfrmCadPrevisaoMensal.pGravaDespesas]')
        Else
          fMensagem('ATENÇÃO', Stringreplace(E.Message, 'AUT001', EmptyStr, [rfReplaceAll]), ['&OK'], 0);
      End;
    End;
  Finally
    pgbProgresso.Position := 0;
    pgbProgresso.Visible := False;
    pEnableControls(cdsDespesas, LPrcScroll);

    if Assigned(LQryDespesas) then
      FreeAndNil(LQryDespesas);

    if Assigned(LQryContaResultado) then
      FreeAndNil(LQryContaResultado);

    if Assigned(LQryPlanoContas) then
      FreeAndNil(LQryPlanoContas);
  End;
end;

function TfrmCadPrevisaoMensal.fGravaReceitas(AControlaTransacao: Boolean = True): Boolean;
Var
  qryReceitas: TUniQuery;
  intIndice  : Integer;
  LDescricoesGravadas: TStringList;
begin
  qryReceitas := nil;
  LDescricoesGravadas := nil;
  Result := True;

  pgbProgresso.Visible := True;
  pgbProgresso.Max := cdsReceitas.RecordCount;

  try
    Try
      If (fTemCadPme) And (Not blnAtualizaImportacao) Then
      Begin
        If fMensagem('', 'Já existe uma previsão mensal' + ' do ano ' + mskAno.Text +
                           ' para a empresa ' + edtCodEmp.Text + '-' + edtDesEmp.Text +
                           '. Deseja sobrescreve-la?', ['&Sim', '&Não']) <> 1 Then
        Begin
          Result := False;
          Exit;
        End;
      End;

      If AControlaTransacao Then
        fStartTransaction;

      cdsReceitas.DisableControls;
      cdsReceitas.First;
      cdsReceitasAnt.First;

      qryReceitas := fCriaQuery;
      LDescricoesGravadas := TStringList.Create;
      pDeleteCadPmeReceitas;
      While Not cdsReceitas.Eof Do
      Begin
        {********************************************************************}
        {* RECEITA REPETIDA NA GRADE GRAVA UMA VEZ SÓ: A GRAVAÇÃO APAGA O    *}
        {* ANO E REGRAVA A GRADE INTEIRA, ENTÃO UMA LINHA REPETIDA FICAVA    *}
        {* REPETIDA NA BASE E SE MULTIPLICAVA NA CARGA SEGUINTE              *}
        {**REQ 470011********************************************************}
        If LDescricoesGravadas.IndexOf(cdsReceitas.FieldByName('DESCRI').AsString) < 0 Then
        Begin
          LDescricoesGravadas.Add(cdsReceitas.FieldByName('DESCRI').AsString);

          For intIndice := 1 To 12 Do
          Begin

            With qryReceitas, SQL Do
            begin
              Close;
              Clear;
              Add('INSERT INTO CADPME ');
              Add('            (PME_DESREC, PME_MESANO, PME_VALMES, ');
              Add('             PME_DESCRI, PME_CODEMP, AUTOINCREM) ');
              Add('      VALUES(:DESREC,    :MESANO,    :VALMES,    ');
              Add('             :DESCRI,    :CODEMP,    :AUTOIN)    ');
              ParamByName('DESREC').AsString   := 'R';
              ParamByName('MESANO').AsDateTime := StrToDate('01/' + fStrZero(IntToStr(intIndice), 02) + '/' + mskAno.Text);
              ParamByName('VALMES').AsFloat    := cdsReceitas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat;
              ParamByName('DESCRI').AsString   := cdsReceitas.FieldByName('DESCRI').AsString;
              ParamByName('CODEMP').AsString   := edtCodEmp.Text;
              ParamByName('AUTOIN').AsString   := fRetAutoIncrem('CADPME', edtCodEmp.Text);
              ExecSQL;
            end;

          End;
        End;

        cdsReceitas.Next;
        cdsReceitasAnt.Next;
        pgbProgresso.Position := pgbProgresso.Position + 1;
      End;

      If AControlaTransacao Then
        fCommit;

      pgbProgresso.Position := 0;
      pgbProgresso.Visible := False;
    Except
      On E: Exception Do
      Begin
        If AControlaTransacao Then
          fRollBack;

        pMensagensErro(E.Message,'[TfrmCadPrevisaoMensal.pGravaReceitas]');
        Result := False;
      End;
    End;
  finally
    if Assigned(qryReceitas) then
      FreeAndNil(qryReceitas);

    if Assigned(LDescricoesGravadas) then
      FreeAndNil(LDescricoesGravadas);

    cdsReceitas.EnableControls;
  end;

end;

procedure TfrmCadPrevisaoMensal.pIncluiRegistros;
begin

  fltTotalRec := 0;
  fltTotalDes := 0;

  pPreencheDespesas(edtCodEmp.Text, mskAno.Text);
  cdsDespesas.First;
  cdsDespesas.EnableControls;
  pAtualizaTotais(False);
  pTotaisGruposDespesas;

  pPreencheReceitas(edtCodEmp.Text, mskAno.Text);
  cdsReceitas.First;
  cdsReceitas.EnableControls;
  pAtualizaTotais(True);

end;

procedure TfrmCadPrevisaoMensal.pPreencheDespesas(strCodEmp: String; strAno: String; fltFator: Double = 1);
  Var
    qryPrevFixas: TUniQuery;
    qryPreCtaRes: TUniQuery;
    qryCtaRes1  : TUniQuery;
    qryCtaRes2  : TUniQuery;
    strCodCre   : String;
    strSQL      : String;
    strDescri   : String;
    strConta    : String;
    AMes        : String;
    intIndice   : Integer;
    fltTotDes   : Double;

begin
  Screen.Cursor := crSQLWait;

  qryPrevFixas := fCriaQuery;

  cdsDespesas.DisableControls;
  cdsDespesas.EmptyDataSet;

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE           ';
  strSQL := strSQL + '   PME_MESANO,                 ';
  strSQL := strSQL + '   PME_VALMES,                 ';
  strSQL := strSQL + '   PME_DESCRI                  ';
  strSQL := strSQL + ' FROM                          ';
  strSQL := strSQL + '   CADPME                      ';
  strSQL := strSQL + ' WHERE                         ';
  strSQL := strSQL + '   PME_CODEMP = :CODEMP   AND  ';
  strSQL := strSQL + '   YEAR(PME_MESANO) = ' + strAno;
  strSQL := strSQL + '   AND PME_DESREC   = "D" AND  ';
  strSQL := strSQL + '  (PME_DESCRI = "DESCONTO CONCEDIDO" OR        ';
  strSQL := strSQL + '   PME_DESCRI = "CUSTO DA MERCADORIA VENDIDA") ';
  strSQL := strSQL + '     GROUP BY PME_DESCRI,   ';
  strSQL := strSQL + '     PME_MESANO             ';
  strSQL := strSQL + ' ORDER BY PME_DESCRI, PME_MESANO ,AUTOINCREM DESC ';

  With qryPrevFixas, SQL Do
  Begin
    Clear;
    Add(strSQL);
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If (RecordCount > 0) Then
    Begin
      First;

      While Not Eof Do
      Begin
        strDescri := FieldByName('PME_DESCRI').AsString;
        intIndice := 1;
        fltTotDes := 0;

        cdsDespesas.Append;
        cdsDespesas.FieldByName('DESCRI').AsString := FieldByName('PME_DESCRI').AsString;

        While (strDescri = FieldByName('PME_DESCRI').AsString) And
              (intIndice <= 12)                                Do
        Begin
          {********************************************************************}
          {* VERIFICANDO SE O INDICE É MENOR QUE O MÊS QUE TEM VALOR **********}
          {* PODE ACONTECER DE NA BASE NÃO TER TODOS OS MESES, AI PARA O GRID *}
          {* FICAR COM AS INFORMAÇÕES CORRETAS PRECISA FAZER ESSA VERIFICAÇÃO *}
          {**REQ 116628*****************************************************MO*}
          AMes := FormatDateTime('mm', FieldByName('PME_MESANO').AsDateTime);
          While fStrZero(IntToStr(intIndice), 02) < AMes do
          begin
            cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat := 0;
            Inc(intIndice);
          end;

          cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat := FieldByName('PME_VALMES').AsFloat * fltFator;
          fltTotDes  := fltTotDes + FieldByName('PME_VALMES').AsFloat;

          Inc(intIndice);
          Next;
        End;

        cdsDespesas.FieldByName('TIPO').AsString := 'C';
        cdsDespesas.FieldByName('Total').AsFloat := fltTotDes * fltFator;
        cdsDespesas.Post;
      End;

    End
    Else
    Begin

      cdsDespesas.Append;
      cdsDespesas.FieldByName('DESCRI').AsString := 'CUSTO DA MERCADORIA VENDIDA';

      For intIndice := 1 To 12 Do
        cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;

      cdsDespesas.FieldByName('TIPO').AsString := 'C';
      cdsDespesas.FieldByName('Total').AsFloat := 0;
      cdsDespesas.Post;

      cdsDespesas.Append;
      cdsDespesas.FieldByName('DESCRI').AsString := 'DESCONTO CONCEDIDO';

      For intIndice := 1 To 12 Do
        cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;

      cdsDespesas.FieldByName('TIPO').AsString := 'C';
      cdsDespesas.FieldByName('Total').AsFloat := 0;
      cdsDespesas.Post;

    End;
  End;

  FreeAndNil(qryPrevFixas);

  qryCtaRes1   := fCriaQuery;
  qryCtaRes2   := fCriaQuery;
  qryPreCtaRes := fCriaQuery;

  With qryCtaRes1 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SQL_NO_CACHE CRE_CODCRE, CRE_DESCRE FROM CTAGER ORDER BY CRE_CODCRE');
    Open;
  End;

  If Not qryCtaRes1.IsEmpty Then
  Begin
    qryCtaRes1.First;

    While Not qryCtaRes1.Eof Do
    Begin
      strCodCre := qryCtaRes1.FieldByName('CRE_CODCRE').AsString;

      strSQL := '';
      strSQL := strSQL + ' SELECT SQL_NO_CACHE        ';
      strSQL := strSQL + '   PME_MESANO,              ';
      strSQL := strSQL + '   PME_VALMES,              ';
      strSQL := strSQL + '   PME_DESCRI,              ';
      strSQL := strSQL + '   PME_CODCTA,              ';
      strSQL := strSQL + '   PME_CODRES               ';
      strSQL := strSQL + ' FROM                       ';
      strSQL := strSQL + '   CADPME                   ';
      strSQL := strSQL + ' WHERE PME_CODEMP = :CODEMP ';
      strSQL := strSQL + '   AND YEAR(PME_MESANO) = ' + strAno;
      strSQL := strSQL + '   AND PME_DESREC = "D"     ';
      strSQL := strSQL + '   AND (PME_CODRES = :CODRES ';
      strSQL := strSQL + '   OR  PME_DESCRI = :DESCRI )';

      With qryPreCtaRes, SQL Do
      Begin
        Close;
        Clear;
        Add(strSQL);
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('DESCRI').AsString := strCodCre + '-' + qryCtaRes1.FieldByName('CRE_DESCRE').AsString;
        ParamByName('CODRES').AsString := strCodCre;
        Open;
      End;

      If Not qryPreCtaRes.IsEmpty Then
      Begin
        cdsDespesas.Append;
        cdsDespesas.FieldByName('DESCRI').AsString := qryPreCtaRes.FieldByName('PME_DESCRI').AsString;

{        For intIndice := 1 To 12 Do
          cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;  }

        cdsDespesas.FieldByName('CODRES').AsString := strCodCre;
        cdsDespesas.FieldByName('TIPO').AsString   := 'G';
        cdsDespesas.Post;

        strSQL := '';
        strSQL := strSQL + ' SELECT SQL_NO_CACHE                      ';
        strSQL := strSQL + '   CRE_CODCTA AS CODIGO,                  ';
        strSQL := strSQL + '   CTA_DESCTA AS DESCRICAO,               ';
        strSQL := strSQL + '   CRE_CODCRE                             ';
        strSQL := strSQL + ' FROM CTARES                              ';
        strSQL := strSQL + '   JOIN CADCTA ON CTA_CODCTA = CRE_CODCTA ';
        strSQL := strSQL + ' WHERE CRE_CODCRE = :CODCRE               ';
        strSQL := strSQL + ' ORDER BY CRE_CODCTA                      ';

        With qryCtaRes2 Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODCRE').AsString := strCodCre;
          Open;
          First;
        End;

        While Not qryCtaRes2.Eof Do
        Begin
          strSQL := '';
          strSQL := strSQL + ' SELECT SQL_NO_CACHE        ';
          strSQL := strSQL + '   CONCAT(CRE_CODCRE, ''-'', CONCAT(SUBSTR(CTA_CODCTA, 01, 02), ''.'', ';
          strSQL := strSQL + '   SUBSTR(CTA_CODCTA, 03, 02), ''.'', SUBSTR(CTA_CODCTA, 05, 03)), ''-'', CTA_DESCTA) AS PME_DESCRI, ';
          strSQL := strSQL + '   PME_MESANO,              ';
          strSQL := strSQL + '   PME_VALMES,              ';
          strSQL := strSQL + '   PME_CODCTA,              ';
          strSQL := strSQL + '   PME_CODRES               ';
          strSQL := strSQL + ' FROM CADPME                ';
          strSQL := strSQL + '   JOIN CADCTA ON PME_CODCTA = CTA_CODCTA ';
          strSQL := strSQL + '   JOIN CTARES ON PME_CODRES = CRE_CODCRE ';
          strSQL := strSQL + ' WHERE PME_CODCTA = CTA_CODCTA ';
          strSQL := strSQL + '   AND CTA_CODCTA = CRE_CODCTA ';
          strSQL := strSQL + '   AND PME_CODEMP = :CODEMP ';
          strSQL := strSQL + '   AND YEAR(PME_MESANO) = ' + strAno;
          strSQL := strSQL + '   AND PME_DESREC = "D"     ';
          strSQL := strSQL + '   AND PME_CODCTA = :CODCTA ';
          strSQL := strSQL + '   AND PME_CODRES = :CODRES ';
          strSQL := strSQL + ' GROUP BY PME_MESANO ';
          strSQL := strSQL + ' ORDER BY PME_MESANO, PME_DESCRI ';

          strConta := strCodCre + '-' + fFormataConta(qryCtaRes2.FieldByName('CODIGO').AsString) +
                                  '-' + qryCtaRes2.FieldByName('DESCRICAO').AsString;

          With qryPreCtaRes, SQL Do
          Begin
            Close;
            Clear;
            Add(strSQL);
            ParamByName('CODEMP').AsString := strCodEmp;
            ParamByName('CODCTA').AsString := qryCtaRes2.FieldByName('CODIGO').AsString;
            ParamByName('CODRES').AsString := qryCtaRes2.FieldByName('CRE_CODCRE').AsString;
            Open;
            First;

            If Not qryPreCtaRes.IsEmpty Then
            Begin
              strDescri := FieldByName('PME_DESCRI').AsString;
              intIndice := 1;
              fltTotDes := 0;

              cdsDespesas.Append;
              cdsDespesas.FieldByName('DESCRI').AsString := FieldByName('PME_DESCRI').AsString;

              While Not qryPreCtaRes.Eof Do
              begin
                If (strDescri  = FieldByName('PME_DESCRI').AsString) And
                   (intIndice <= 12)                                      Then
                Begin
                  {********************************************************************}
                  {* VERIFICANDO SE O INDICE É MENOR QUE O MÊS QUE TEM VALOR **********}
                  {* PODE ACONTECER DE NA BASE NÃO TER TODOS OS MESES, AI PARA O GRID *}
                  {* FICAR COM AS INFORMAÇÕES CORRETAS PRECISA FAZER ESSA VERIFICAÇÃO *}
                  {**REQ 116628*****************************************************MO*}
                  AMes := FormatDateTime('mm', FieldByName('PME_MESANO').AsDateTime);
                  While fStrZero(IntToStr(intIndice), 02) < AMes do
                  begin
                    cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat := 0;
                    Inc(intIndice);
                  end;

                  cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := FieldByName('PME_VALMES').AsFloat * fltFator;
                  fltTotDes  := fltTotDes + FieldByName('PME_VALMES').AsFloat;
                End;

                Inc(intIndice);
                Next;
              end;

              While (strDescri  = FieldByName('PME_DESCRI').AsString) And
                    (intIndice <= 12)                                    Do
              Begin
                cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;
                Inc(intIndice);
              end;

              cdsDespesas.FieldByName('TIPO').AsString   := 'C';
              cdsDespesas.FieldByName('CODCTA').AsString := FieldByName('PME_CODCTA').AsString;
              cdsDespesas.FieldByName('CODRES').AsString := FieldByName('PME_CODRES').AsString;
              cdsDespesas.FieldByName('Total').AsFloat   := fltTotDes * fltFator;
              cdsDespesas.Post;
            End
            Else
            Begin
              cdsDespesas.Append;
              cdsDespesas.FieldByName('DESCRI').AsString := strConta;

              For intIndice := 1 To 12 Do
                cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;

              cdsDespesas.FieldByName('TIPO').AsString   := 'C';
              cdsDespesas.FieldByName('CODCTA').AsString := qryCtaRes2.FieldByName('CODIGO').AsString;
              cdsDespesas.FieldByName('CODRES').AsString := qryCtaRes2.FieldByName('CRE_CODCRE').AsString;
              cdsDespesas.FieldByName('Total').AsFloat   := 0;
              cdsDespesas.Post;
            End;

          End;

          qryCtaRes2.Next;
        End;

      End
      Else
      Begin

        cdsDespesas.Append;
        cdsDespesas.FieldByName('DESCRI').AsString := strCodCre + '-' + qryCtaRes1.FieldByName('CRE_DESCRE').AsString;

{        For intIndice := 1 To 12 Do
            cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0; }

        cdsDespesas.FieldByName('CODCTA').AsString := '';
        cdsDespesas.FieldByName('CODRES').AsString := strCodCre;
        cdsDespesas.FieldByName('TIPO').AsString   := 'G';
        cdsDespesas.Post;

        strSQL := '';
        strSQL := strSQL + ' SELECT SQL_NO_CACHE                      ';
        strSQL := strSQL + '   CRE_CODCTA AS CODIGO,                  ';
        strSQL := strSQL + '   CTA_DESCTA AS DESCRICAO,               ';
        strSQL := strSQL + '   CRE_CODCRE                             ';
        strSQL := strSQL + ' FROM CTARES                              ';
        strSQL := strSQL + '   JOIN CADCTA ON CTA_CODCTA = CRE_CODCTA ';
        strSQL := strSQL + ' WHERE CRE_CODCRE = :CODCRE               ';
        strSQL := strSQL + ' ORDER BY CRE_CODCTA                      ';

        With qryCtaRes2 Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODCRE').AsString := strCodCre;
          Open;
          First;
        End;

        While Not qryCtaRes2.Eof Do
        Begin

          strConta := strCodCre + '-' + fFormataConta(qryCtaRes2.FieldByName('CODIGO').AsString) +
                                  '-' + qryCtaRes2.FieldByName('DESCRICAO').AsString;

          cdsDespesas.Append;
          cdsDespesas.FieldByName('DESCRI').AsString := strConta;

          For intIndice := 1 To 12 Do
            cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;

          cdsDespesas.FieldByName('TIPO').AsString   := 'C';
          cdsDespesas.FieldByName('CODCTA').AsString := qryCtaRes2.FieldByName('CODIGO').AsString;
          cdsDespesas.FieldByName('CODRES').AsString := qryCtaRes2.FieldByName('CRE_CODCRE').AsString;
          cdsDespesas.FieldByName('Total').AsFloat   := 0;
          cdsDespesas.Post;

          qryCtaRes2.Next;
        End;

      End;

      qryCtaRes1.Next;
    End;

  End;

  cdsDespesasAnt.Data := cdsDespesas.Data;

  If fCfgSis('DESPRE', varBoolean) Then
  Begin
    PreencheDespesas(strCodEmp,strAno,fltFator);
    PreencheDespesasFinanceiras(strCodEmp,strAno,fltFator);
    PreencheDespesasVariaveis(strCodEmp,strAno,fltFator);
  End;

  FreeAndNil(qryPreCtaRes);
  FreeAndNil(qryCtaRes1);
  FreeAndNil(qryCtaRes2);

  Screen.Cursor := crDefault;

end;

procedure TfrmCadPrevisaoMensal.pPreencheReceitas(strCodEmp: String; strAno: String; fltFator: Double = 1);
  Var
    qryPrevisoes: TUniQuery;
    strDescri   : String;
    strSQL      : String;
    AMes        : String;
    intIndice   : Integer;
    fltTotRec   : Double;

begin
  Screen.Cursor := crSQLWait;

  qryPrevisoes := fCriaQuery;

  cdsReceitas.DisableControls;
  cdsReceitas.EmptyDataSet;

  strSQL := '';
  {********************************************************************}
  {* AGRUPANDO POR DESCRIÇÃO E MÊS: LINHA REPETIDA NA BASE MONTAVA UMA *}
  {* LINHA A MAIS NO GRID, E CADA GRAVAÇÃO MULTIPLICAVA A REPETIÇÃO    *}
  {**REQ 470011********************************************************}
  strSQL := strSQL + ' SELECT SQL_NO_CACHE        ';
  strSQL := strSQL + '   MAX(PME_VALMES) AS PME_VALMES, ';
  strSQL := strSQL + '   PME_DESCRI,              ';
  strSQL := strSQL + '   PME_MESANO               ';
  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   CADPME                   ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   PME_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   YEAR(PME_MESANO) = ' + QuotedStr(strAno);
  strSQL := strSQL + '   AND PME_DESREC   = "R"   ';
  strSQL := strSQL + ' GROUP BY PME_DESCRI, PME_MESANO ';
  strSQL := strSQL + ' ORDER BY PME_DESCRI DESC, PME_MESANO ';

  With qryPrevisoes, SQL Do
  Begin
    Clear;
    Add(strSQL);
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If (RecordCount > 0) Then
    Begin
      First;

      While Not (Eof) Do
      Begin
        strDescri := FieldByName('PME_DESCRI').AsString;
        intIndice := 1;
        fltTotRec := 0;

        cdsReceitas.Append;

        cdsReceitas.FieldByName('DESCRI').AsString := FieldByName('PME_DESCRI').AsString;

        While (strDescri = FieldByName('PME_DESCRI').AsString) And
              (intIndice <= 12)                                Do
        Begin
          {********************************************************************}
          {* VERIFICANDO SE O INDICE É MENOR QUE O MÊS QUE TEM VALOR **********}
          {* PODE ACONTECER DE NA BASE NÃO TER TODOS OS MESES, AI PARA O GRID *}
          {* FICAR COM AS INFORMAÇÕES CORRETAS PRECISA FAZER ESSA VERIFICAÇÃO *}
          {**REQ 116628*****************************************************MO*}
          AMes := FormatDateTime('mm', FieldByName('PME_MESANO').AsDateTime);
          While fStrZero(IntToStr(intIndice), 02) < AMes do
          begin
            cdsReceitas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat := 0;
            Inc(intIndice);
          end;

          cdsReceitas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := FieldByName('PME_VALMES').AsFloat * fltFator;
          fltTotRec  := fltTotRec + FieldByName('PME_VALMES').AsFloat;

          Inc(intIndice);
          Next;
        End;

        cdsReceitas.FieldByName('Total').AsFloat := fltTotRec * fltFator;
        cdsReceitas.Post;
      End;

      If Not ExisteReceitaFixaNoAno(strCodEmp,
                                    'SERVIÇOS E REPRESENTAÇÕES',
                                    strAno) then
      Begin
        cdsReceitas.Append;
        cdsReceitas.FieldByName('DESCRI').AsString := 'SERVIÇOS E REPRESENTAÇÕES';

        For intIndice := 1 To 12 Do
          cdsReceitas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;

        cdsReceitas.FieldByName('Total').AsFloat := 0;
        cdsReceitas.Post;
      End;

      If Not ExisteReceitaFixaNoAno(strCodEmp,
                                    'VENDAS À VISTA',
                                    strAno) then
      Begin
        cdsReceitas.Append;
        cdsReceitas.FieldByName('DESCRI').AsString := 'VENDAS À VISTA';

        For intIndice := 1 To 12 Do
          cdsReceitas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;

        cdsReceitas.FieldByName('Total').AsFloat := 0;
        cdsReceitas.Post;
      End;

      If Not fRedirecionaValoresReceitasAlteradas('VENDA BRUTA') Then
      Begin
        If Not ExisteReceitaFixaNoAno(strCodEmp,
                                      'VENDAS À PRAZO',
                                      strAno) then
        Begin
          cdsReceitas.Append;
          cdsReceitas.FieldByName('DESCRI').AsString := 'VENDAS À PRAZO';

          For intIndice := 1 To 12 Do
            cdsReceitas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;

          cdsReceitas.FieldByName('Total').AsFloat := 0;
          cdsReceitas.Post;
        End;
      End;

      If Not ExisteReceitaFixaNoAno(strCodEmp,
                                    'DEVOLUÇÕES',
                                    strAno) then
      Begin
        cdsReceitas.Append;
        cdsReceitas.FieldByName('DESCRI').AsString := 'DEVOLUÇÕES';

        For intIndice := 1 To 12 Do
          cdsReceitas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;

        cdsReceitas.FieldByName('Total').AsFloat := 0;
        cdsReceitas.Post;
      End;

    End
    Else
    Begin

      cdsReceitas.Append;
      cdsReceitas.FieldByName('DESCRI').AsString := 'VENDAS À VISTA';

      For intIndice := 1 To 12 Do
        cdsReceitas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;

      cdsReceitas.FieldByName('Total').AsFloat := 0;
      cdsReceitas.Post;

      cdsReceitas.Append;
      cdsReceitas.FieldByName('DESCRI').AsString := 'VENDAS À PRAZO';

      For intIndice := 1 To 12 Do
        cdsReceitas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;

      cdsReceitas.FieldByName('Total').AsFloat := 0;
      cdsReceitas.Post;

      cdsReceitas.Append;
      cdsReceitas.FieldByName('DESCRI').AsString := 'DEVOLUÇÕES';

      For intIndice := 1 To 12 Do
        cdsReceitas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;

      cdsReceitas.FieldByName('Total').AsFloat := 0;
      cdsReceitas.Post;

      cdsReceitas.Append;
      cdsReceitas.FieldByName('DESCRI').AsString := 'JUROS RECEBIDO';

      For intIndice := 1 To 12 Do
        cdsReceitas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;

      cdsReceitas.FieldByName('Total').AsFloat := 0;
      cdsReceitas.Post;

      cdsReceitas.Append;
      cdsReceitas.FieldByName('DESCRI').AsString := 'SERVIÇOS E REPRESENTAÇÕES';

      For intIndice := 1 To 12 Do
        cdsReceitas.FieldByName('VAL' + fStrZero(IntToStr(intIndice), 03)).AsFloat  := 0;

      cdsReceitas.FieldByName('Total').AsFloat := 0;
      cdsReceitas.Post;

    End;
  End;

  FreeAndNil(qryPrevisoes);
  cdsReceitasAnt.Data := cdsReceitas.Data;

  Screen.Cursor := crDefault

end;

procedure TfrmCadPrevisaoMensal.PreencheDespesas(ACodEmp, AAno: String;
  AFator: Double);
  Var
    LCadCta : TUniQuery;
    LCadPme : TUniQuery;
    strSQL  : String;
    LTotalDespesa : Double;
    LInc : Integer;
begin
  Try

    Try

      LCadCta := fCriarQuery('SELECT                                  '+
                             '  CTA_CODCTA,                           '+
                             '  CTA_DESCTA                            '+
                             'FROM                                    '+
                             '  CADCTA                                '+
                             'WHERE CTA_TIPCTA = 3                    '+
                             '  AND (RIGHT(CTA_CODCTA, 3) <> "000")   '+
                             '  AND (CTA_STATUS = "A")                '+
                             'ORDER BY CTA_CODCTA,                    '+
                             '  CTA_DESCTA                            ');
      LCadCta.Open;

      If LCadCta.IsEmpty Then
        Exit;

      cdsDespesas.Append;
      cdsDespesas.FieldByName('DESCRI').AsString := 'DESPESAS';
      cdsDespesas.FieldByName('TIPO').AsString   := 'G';
      cdsDespesas.Post;

      LCadPme := fCriaQuery(Nil);
      LCadCta.First;

      While Not LCadCta.Eof do
      Begin

        strSQL := '';
        strSQL := strSQL + ' SELECT                     ';
        strSQL := strSQL + '   CTA_CODCTA,              ';
        strSQL := strSQL + '   CTA_DESCTA,              ';
        strSQL := strSQL + '   PME_MESANO,              ';
        strSQL := strSQL + '   PME_VALMES,              ';
        strSQL := strSQL + '   PME_CODCTA               ';
        strSQL := strSQL + ' FROM CADPME                ';
        strSQL := strSQL + '   JOIN CADCTA ON PME_CODCTA = CTA_CODCTA ';
        strSQL := strSQL + ' WHERE PME_CODCTA = CTA_CODCTA ';
        strSQL := strSQL + '   AND PME_CODEMP = :CODEMP ';
        strSQL := strSQL + '   AND YEAR(PME_MESANO) = ' + AAno;
        strSQL := strSQL + '   AND PME_DESREC = "D"     ';
        strSQL := strSQL + '   AND PME_CODRES IS NULL  ';
        strSQL := strSQL + '   AND PME_CODCTA = :CODCTA ';
        strSQL := strSQL + ' GROUP BY PME_MESANO ';
        strSQL := strSQL + ' ORDER BY PME_MESANO, PME_DESCRI ';


        LCadPme.Close;
        LCadPme.Sql.Clear;
        LCadPme.Sql.Add(strSQL);
        LCadPme.ParamByName('CODEMP').AsString := ACodEmp;
        LCadPme.ParamByName('CODCTA').AsString := LCadCta.FieldByName('CTA_CODCTA').AsString;
        LCadPme.Open;

        If Not LCadPme.IsEmpty Then
        Begin
          LInc := 1;
          LTotalDespesa := 0;

          cdsDespesas.Append;
          cdsDespesas.FieldByName('DESCRI').AsString := fFormataConta(LCadPme.FieldByName('CTA_CODCTA').AsString) + '-' +
                                                                      LCadPme.FieldByName('CTA_DESCTA').AsString ;;

          While Not LCadPme.Eof Do
          begin
            cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(LInc), 03)).AsFloat  := (LCadPme.FieldByName('PME_VALMES').AsFloat * AFator);
            LTotalDespesa  := LTotalDespesa + LCadPme.FieldByName('PME_VALMES').AsFloat;
            Inc(LInc);
            LCadPme.Next;
          end;

          cdsDespesas.FieldByName('TIPO').AsString   := 'C';
          cdsDespesas.FieldByName('CODCTA').AsString := LCadPme.FieldByName('PME_CODCTA').AsString;
          cdsDespesas.FieldByName('Total').AsFloat   := (LTotalDespesa * AFator);
          cdsDespesas.Post;
        End
        Else If Not TemContaResultado(LCadCta.FieldByName('CTA_CODCTA').AsString) Then
        Begin
          cdsDespesas.Append;
          cdsDespesas.FieldByName('DESCRI').AsString := fFormataConta(LCadCta.FieldByName('CTA_CODCTA').AsString) + '-' +
                                                                      LCadCta.FieldByName('CTA_DESCTA').AsString ;

          For LInc := 1 To 12 Do
            cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(LInc), 03)).AsFloat  := 0;

          cdsDespesas.FieldByName('TIPO').AsString   := 'C';
          cdsDespesas.FieldByName('CODCTA').AsString := LCadCta.FieldByName('CTA_CODCTA').AsString;
          cdsDespesas.FieldByName('Total').AsFloat   := 0;
          cdsDespesas.Post;
        End;
        LCadCta.Next;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    If Assigned(LCadCta) Then
      FreeAndNil(LCadCta);

    If Assigned(LCadPme) Then
      FreeAndNil(LCadPme);
  End;
end;

procedure TfrmCadPrevisaoMensal.PreencheDespesasFinanceiras(ACodEmp,AAno: String; AFator: Double);
  Var
    LCadCta : TUniQuery;
    LCadPme : TUniQuery;
    strSQL  : String;
    LTotalDespesa : Double;
    LInc : Integer;
begin
  Try

    Try

      LCadCta := fCriarQuery('SELECT                                  '+
                             '  CTA_CODCTA,                           '+
                             '  CTA_DESCTA                            '+
                             'FROM                                    '+
                             '  CADCTA                                '+
                             'WHERE CTA_TIPCTA = 4                    '+
                             '  AND (RIGHT(CTA_CODCTA, 3) <> "000")   '+
                             '  AND (CTA_STATUS = "A")                '+
                             'ORDER BY CTA_CODCTA,                    '+
                             '  CTA_DESCTA                            ');
      LCadCta.Open;

      If LCadCta.IsEmpty Then
        Exit;

      cdsDespesas.Append;
      cdsDespesas.FieldByName('DESCRI').AsString := 'DESPESAS FINANCEIRAS';
      cdsDespesas.FieldByName('TIPO').AsString   := 'G';
      cdsDespesas.Post;

      LCadPme := fCriaQuery(Nil);
      LCadCta.First;

      While Not LCadCta.Eof do
      Begin

        strSQL := '';
        strSQL := strSQL + ' SELECT                     ';
        strSQL := strSQL + '   CTA_CODCTA,              ';
        strSQL := strSQL + '   CTA_DESCTA,              ';
        strSQL := strSQL + '   PME_MESANO,              ';
        strSQL := strSQL + '   PME_VALMES,              ';
        strSQL := strSQL + '   PME_CODCTA               ';
        strSQL := strSQL + ' FROM CADPME                ';
        strSQL := strSQL + '   JOIN CADCTA ON PME_CODCTA = CTA_CODCTA ';
        strSQL := strSQL + ' WHERE PME_CODCTA = CTA_CODCTA ';
        strSQL := strSQL + '   AND PME_CODEMP = :CODEMP ';
        strSQL := strSQL + '   AND YEAR(PME_MESANO) = ' + AAno;
        strSQL := strSQL + '   AND PME_DESREC = "D"     ';
        strSQL := strSQL + '   AND PME_CODRES IS NULL  ';
        strSQL := strSQL + '   AND PME_CODCTA = :CODCTA ';
        strSQL := strSQL + ' GROUP BY PME_MESANO ';
        strSQL := strSQL + ' ORDER BY PME_MESANO, PME_DESCRI ';


        LCadPme.Close;
        LCadPme.Sql.Clear;
        LCadPme.Sql.Add(strSQL);
        LCadPme.ParamByName('CODEMP').AsString := ACodEmp;
        LCadPme.ParamByName('CODCTA').AsString := LCadCta.FieldByName('CTA_CODCTA').AsString;
        LCadPme.Open;

        If Not LCadPme.IsEmpty Then
        Begin
          LInc := 1;
          LTotalDespesa := 0;

          cdsDespesas.Append;
          cdsDespesas.FieldByName('DESCRI').AsString := fFormataConta(LCadPme.FieldByName('CTA_CODCTA').AsString) + '-' +
                                                                      LCadPme.FieldByName('CTA_DESCTA').AsString ;;

          While Not LCadPme.Eof Do
          begin
            cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(LInc), 03)).AsFloat  := (LCadPme.FieldByName('PME_VALMES').AsFloat * AFator);
            LTotalDespesa  := LTotalDespesa + LCadPme.FieldByName('PME_VALMES').AsFloat;
            Inc(LInc);
            LCadPme.Next;
          end;

          cdsDespesas.FieldByName('TIPO').AsString   := 'C';
          cdsDespesas.FieldByName('CODCTA').AsString := LCadPme.FieldByName('PME_CODCTA').AsString;
          cdsDespesas.FieldByName('Total').AsFloat   := (LTotalDespesa * AFator);
          cdsDespesas.Post;
        End
        Else If Not TemContaResultado(LCadCta.FieldByName('CTA_CODCTA').AsString) Then
        Begin
          cdsDespesas.Append;
          cdsDespesas.FieldByName('DESCRI').AsString := fFormataConta(LCadCta.FieldByName('CTA_CODCTA').AsString) + '-' +
                                                                      LCadCta.FieldByName('CTA_DESCTA').AsString ;

          For LInc := 1 To 12 Do
            cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(LInc), 03)).AsFloat  := 0;

          cdsDespesas.FieldByName('TIPO').AsString   := 'C';
          cdsDespesas.FieldByName('CODCTA').AsString := LCadCta.FieldByName('CTA_CODCTA').AsString;
          cdsDespesas.FieldByName('Total').AsFloat   := 0;
          cdsDespesas.Post;
        End;
        LCadCta.Next;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    If Assigned(LCadCta) Then
      FreeAndNil(LCadCta);

    If Assigned(LCadPme) Then
      FreeAndNil(LCadPme);
  End;
end;

procedure TfrmCadPrevisaoMensal.PreencheDespesasVariaveis(ACodEmp, AAno: String;
  AFator: Double);
  Var
    LCadCta : TUniQuery;
    LCadPme : TUniQuery;
    strSQL  : String;
    LTotalDespesa : Double;
    LInc : Integer;
begin
  Try

    Try

      LCadCta := fCriarQuery('SELECT                                  '+
                             '  CTA_CODCTA,                           '+
                             '  CTA_DESCTA                            '+
                             'FROM                                    '+
                             '  CADCTA                                '+
                             'WHERE CTA_TIPCTA = 6                    '+
                             '  AND (RIGHT(CTA_CODCTA, 3) <> "000")   '+
                             '  AND (CTA_STATUS = "A")                '+
                             'ORDER BY CTA_CODCTA,                    '+
                             '  CTA_DESCTA                            ');
      LCadCta.Open;

      If LCadCta.IsEmpty Then
        Exit;

      cdsDespesas.Append;
      cdsDespesas.FieldByName('DESCRI').AsString := 'DESPESAS VARIÁVEIS';
      cdsDespesas.FieldByName('TIPO').AsString   := 'G';
      cdsDespesas.Post;

      LCadPme := fCriaQuery(Nil);
      LCadCta.First;

      While Not LCadCta.Eof do
      Begin

        strSQL := '';
        strSQL := strSQL + ' SELECT                     ';
        strSQL := strSQL + '   CTA_CODCTA,              ';
        strSQL := strSQL + '   CTA_DESCTA,              ';
        strSQL := strSQL + '   PME_MESANO,              ';
        strSQL := strSQL + '   PME_VALMES,              ';
        strSQL := strSQL + '   PME_CODCTA               ';
        strSQL := strSQL + ' FROM CADPME                ';
        strSQL := strSQL + '   JOIN CADCTA ON PME_CODCTA = CTA_CODCTA ';
        strSQL := strSQL + ' WHERE PME_CODCTA = CTA_CODCTA ';
        strSQL := strSQL + '   AND PME_CODEMP = :CODEMP ';
        strSQL := strSQL + '   AND YEAR(PME_MESANO) = ' + AAno;
        strSQL := strSQL + '   AND PME_DESREC = "D"     ';
        strSQL := strSQL + '   AND PME_CODRES IS NULL  ';
        strSQL := strSQL + '   AND PME_CODCTA = :CODCTA ';
        strSQL := strSQL + ' GROUP BY PME_MESANO ';
        strSQL := strSQL + ' ORDER BY PME_MESANO, PME_DESCRI ';


        LCadPme.Close;
        LCadPme.Sql.Clear;
        LCadPme.Sql.Add(strSQL);
        LCadPme.ParamByName('CODEMP').AsString := ACodEmp;
        LCadPme.ParamByName('CODCTA').AsString := LCadCta.FieldByName('CTA_CODCTA').AsString;
        LCadPme.Open;

        If Not LCadPme.IsEmpty Then
        Begin
          LInc := 1;
          LTotalDespesa := 0;

          cdsDespesas.Append;
          cdsDespesas.FieldByName('DESCRI').AsString := fFormataConta(LCadPme.FieldByName('CTA_CODCTA').AsString) + '-' +
                                                                      LCadPme.FieldByName('CTA_DESCTA').AsString ;;

          While Not LCadPme.Eof Do
          begin
            cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(LInc), 03)).AsFloat  := (LCadPme.FieldByName('PME_VALMES').AsFloat * AFator);
            LTotalDespesa  := LTotalDespesa + LCadPme.FieldByName('PME_VALMES').AsFloat;
            Inc(LInc);
            LCadPme.Next;
          end;

          cdsDespesas.FieldByName('TIPO').AsString   := 'C';
          cdsDespesas.FieldByName('CODCTA').AsString := LCadPme.FieldByName('PME_CODCTA').AsString;
          cdsDespesas.FieldByName('Total').AsFloat   := (LTotalDespesa * AFator);
          cdsDespesas.Post;
        End
        Else If Not TemContaResultado(LCadCta.FieldByName('CTA_CODCTA').AsString) Then
        Begin
          cdsDespesas.Append;
          cdsDespesas.FieldByName('DESCRI').AsString := fFormataConta(LCadCta.FieldByName('CTA_CODCTA').AsString) + '-' +
                                                                      LCadCta.FieldByName('CTA_DESCTA').AsString ;

          For LInc := 1 To 12 Do
            cdsDespesas.FieldByName('VAL' + fStrZero(IntToStr(LInc), 03)).AsFloat  := 0;

          cdsDespesas.FieldByName('TIPO').AsString   := 'C';
          cdsDespesas.FieldByName('CODCTA').AsString := LCadCta.FieldByName('CTA_CODCTA').AsString;
          cdsDespesas.FieldByName('Total').AsFloat   := 0;
          cdsDespesas.Post;
        End;
        LCadCta.Next;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    If Assigned(LCadCta) Then
      FreeAndNil(LCadCta);

    If Assigned(LCadPme) Then
      FreeAndNil(LCadPme);
  End;
end;


procedure TfrmCadPrevisaoMensal.pLimpaEdits;
begin
  dbgConsulta.Options := dbgConsulta.Options - [dgEditing];
  edtCodEmp.Clear;
  edtDesEmp.Clear;
  mskAno.Clear;
  FEmpresaCarregada := '';
  FAnoCarregado := '';
  pSetFocus(mskAno);
end;

procedure TfrmCadPrevisaoMensal.pLimpaGridsComValores;
begin
  cdsReceitas.EmptyDataSet;
  cdsDespesas.EmptyDataSet;
  fltTotalRec := 0;
  fltTotalDes := 0;
  edtTotRec.Text := '0,00';
  edtTotDes.Text := '0,00';
  edtTotGer.Text := '0,00';
  FEmpresaCarregada := '';
  FAnoCarregado := '';
end;

procedure TfrmCadPrevisaoMensal.pTotaisGruposDespesas;
  Var
    cdsAux : TUniClientDataSet;
    qryAux : TUniQuery;
    intAux : Integer;
    intRno : Integer;
    strAux : String;
    arrTot : Array[1..12] Of Double;

  procedure pZeraTot;
    var intCont: Integer;
  begin
    For intCont := 1 to 12 Do
      arrTot[intCont] := 0;
  end;
begin
  cdsAux := TUniClientDataSet.Create(Self);
  qryAux := fCriaQuery;

  pZeraTot;

  cdsAux.Data := cdsDespesas.Data;

  If (cdsAux.Active) And (cdsAux.RecordCount > 0) Then
  Begin

    intRno := cdsDespesas.RecNo;
    cdsDespesas.DisableControls;

    With qryAux Do
    Begin
      Close;
      SQL.Text := 'SELECT CRE_CODCRE AS CONTA FROM CTAGER';
      Open;
      First;

      While Not Eof Do
      Begin

        cdsAux.Filtered := False;
        cdsAux.Filter   := 'TIPO = ' + QuotedStr('C') + ' AND DESCRI LIKE ' + #39 + FieldByName('CONTA').AsString + '%' + #39;
        cdsAux.Filtered := True;

        cdsAux.First;
        While Not cdsAux.Eof Do
        Begin
          For intAux := 1 to 12 Do
            arrTot[intAux] := arrTot[intAux] + cdsAux.FieldByName('VAL' + fStrZero(intAux, 3)).AsFloat;
          cdsAux.Next;
        End;

        strAux := 'G';
        If cdsDespesas.Locate('TIPO;CODRES', VarArrayOf([strAux, FieldByName('CONTA').AsString]), []) Then
        Begin
          cdsDespesas.Edit;
          For intAux := 1 to 12 Do
            cdsDespesas.FieldByName('VAL' + fStrZero(intAux, 3)).AsFloat := arrTot[intAux];
          cdsDespesas.Post;
        End;

        pZeraTot;
        Next;

      End;

      cdsDespesas.Filtered := False;
      cdsDespesas.Filter   := '';
      cdsDespesas.RecNo    := intRno;
      cdsDespesas.EnableControls;
    End;

  End;

  FreeAndNil(arrTot);
  FreeAndNil(qryAux);
  FreeAndNil(cdsAux);
end;

function TfrmCadPrevisaoMensal.EmpresaAnoCarregadosBatem: Boolean;
begin
  Result := True;

  If fEmptyStr(FEmpresaCarregada) Or fEmptyStr(FAnoCarregado) Then
    Exit;

  If (FEmpresaCarregada <> edtCodEmp.Text) Or
     (FAnoCarregado <> mskAno.Text) Then
  Begin
    fMensagem('ATENÇÃO!',
      'A empresa/ano informados ('+ edtCodEmp.Text +'/'+ mskAno.Text +') ' +
      'são diferentes dos que estão carregados na tela ('+
      FEmpresaCarregada +'/'+ FAnoCarregado +'). ' +
      'Clique em CARREGAR novamente antes de gravar.', ['&OK']);
    Result := False;
  End;
end;

function TfrmCadPrevisaoMensal.ExisteReceitaFixaNoAno(ACodEmp, AReceitaDespesa, AAno: String): Boolean;
Var
  QryCadPme: TUniQuery;
begin
  Result    := False;
  QryCadPme := fCriaQuery;

  With QryCadPme, SQL Do
  begin
    Close;
    Clear;
    Add('SELECT *  ');
    Add('FROM CADPME ');
    Add(' WHERE PME_CODEMP       = :CODEMP AND ');
    Add('       YEAR(PME_MESANO) = :ANO AND ');
    Add('       PME_DESCRI       = :DESCRI ');
    ParamByName('CODEMP').AsString := ACodEmp;
    ParamByName('ANO'   ).AsString := AAno;
    ParamByName('DESCRI').AsString := AReceitaDespesa;
    Open;
  end;

  If Not QryCadPme.IsEmpty Then
    Result := True;
end;

function TfrmCadPrevisaoMensal.TemContaResultado(ACodCta: String): Boolean;
  Var
    LContaResultado : String;
begin
  Result := False;
  LContaResultado := fCampoTabela('CRE_CODCRE', 'CTARES', ['CRE_CODCTA'], [ACodCta], False);

  If Not fEmptyStr(LContaResultado) Then
    Result := True;
end;

procedure TfrmCadPrevisaoMensal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not fEmptyStr(LChaveLck) Then
  Begin
    fLock_Unlock(LChaveLck, False);
  End;
end;

function TfrmCadPrevisaoMensal.fRetornaPlanoContas( strPlContas : String ) : String;
Begin

  If Not fEmptyStr(strPlContas) Then
  Begin

    strPlContas := fTiraPontoVirgula( strPlContas );

    If Length(strPlContas) > 7 Then
       strPlContas := RightStr(strPlContas,7);

  End;

  Result := strPlContas;

End;

function TfrmCadPrevisaoMensal.fImportaArquivo : Boolean;
var
  opdArquiv: TOpenDialog;
  strNomArq,
  strNomArqNovo,
  strAutoIn: String;
  stlArquiv: TStringList;
  qryGrava_: TUniQuery;
  blnIniTra: Boolean;
  FGravando: IObserver_;
  FSubject_: ISubject_;
  strParam_: Array of String;

  objExcel   : TExcel;
  intConLin  : Integer;
  blnCabecalho : boolean;
  strTpOp, LTitulo, LSubtitulo : string;
begin

  Result := False;

  If Not fVerificaMovimento Then
     Exit;

  cdsErros.Active := True;
  strNomArq := '';
  strNomArqNovo := '';
  blnIniTra := False;
  opdArquiv := TOpenDialog.Create(nil);
  cdsErros.EmptyDataSet;

  Try

    FGravando := TGravandoObs.Create;
    FSubject_ := TSubject.Create;
    FSubject_.pAddObserver(FGravando);
    SetLength(strParam_, 4);

    With opdArquiv Do
    Begin

      If fCfgSis('PMPATH') <> '' Then
         InitialDir := fCfgSis('PMPATH')
      Else
         InitialDir := ExtractFileDir(Application.ExeName);

      Filter := 'Arquivos do Excel|*.xls;*.xlsx';
      If Execute Then
      Begin

         strParam_[2] := 'Abrindo Arquivo XLS...';

         //Enviando notificação que vai atualizar os observadores.
         FSubject_.pNotify(strParam_);

         strNomArq := FileName;

         Try
           objExcel := TExcel.fCriarExcel(Self);
           objExcel.AbrirArquivo(opdArquiv.FileName);
         Except
           On E: Exception Do
           Begin
             pMensagensErro(E.Message, '');

             strParam_[0] := 'Esconder';
             FSubject_.pNotify(strParam_);
             Exit;

           End;
         End;

      End;

    End;

  Finally
    FreeAndNil(opdArquiv);
  End;

  If strNomArq <> '' Then
  Begin
    Try
      //FGravando := TGravandoObs.Create;
      //FSubject_ := TSubject.Create;
      //FSubject_.pAddObserver(FGravando);
      //SetLength(strParam_, 4);

      btnImportar.enabled := False;

      If objExcel.MaximodeLinhas > 1 Then
      Begin

        fStartTransaction;
        blnIniTra := True;
        strAutoIn := '';
        qryGrava_ := fCriaQuery();

        //Preparando array de parametros que será responsavel pelas notificações com o objeto observador.
        strParam_[2] := 'Salvando Informações do Arquivo XLS...';

        //Enviando notificação que vai atualizar os observadores.
        FSubject_.pNotify(strParam_);

        With QryGrava_ Do
        Begin
          Sql.Clear;
          Sql.Text := ' INSERT INTO ' +
                      '   IMPPRV    ' +
                      ' SET         ' +
                      '   PRV_NOMARQ = :NOMARQ, ' +
                      '   PRV_DTAIMP = :DTAIMP, ' +
                      '   PRV_OPEIMP = :OPEIMP, ' +
                      '   PRV_HORIMP = :HORIMP, ' +
                      '   PRV_CODEMP = :CODEMP, ' +
                      '   PRV_ANOBAS = :ANOBAS, ' +
                      '   AUTOINCREM = :AUTOIN ';

          strAutoIn := fRetAutoIncrem('IMPPRV', edtCodEmp.Text);
          ParamByName('NOMARQ').AsString := ExtractFileName(strNomArq);
          ParamByName('DTAIMP').AsDate   := VS_Date;
          ParamByName('OPEIMP').AsString := strLoginUsuarioLogado;
          ParamByName('HORIMP').AsTime   := fTime();
          ParamByName('CODEMP').AsString := edtCodEmp.Text;
          ParamByName('ANOBAS').AsString := fTiraCaracEspeciais(mskAno.Text);
          ParamByName('AUTOIN').AsString := strAutoIn;

          ExecSql;

          Close;
        End;

        If strAutoIn <> '' Then
        Begin
          strParam_[0] := 'TcxProgressBar';
          strParam_[1] := IntToStr(objExcel.MaximodeLinhas);
          strParam_[2] := 'Salvando Informações do Arquivo XLS...';

          For intConLin := 1 To objExcel.MaximodeLinhas Do
          Begin

            // Atualizando os observadores
            strParam_[3] := IntToStr(intConLin);
            FSubject_.pNotify(strParam_);

            LTitulo := AnsiUpperCase((objExcel.Ler_Celula(fGetLetraAlfa(01) + IntToStr(intConLin))));
            LSubtitulo := fTiraCaracEspeciais(AnsiUpperCase((objExcel.Ler_Celula(fGetLetraAlfa(02) + IntToStr(intConLin)))));

            If (MatchStr(LTitulo, ['PLANO DE CONTAS', 'PLANODECONTAS'])) And (LSubtitulo.Contains('DESCRICAO')) Then
            Begin
              If intConLin = 1 Then
                Continue;
            End;

            // Verifica se eh linha em branco
            If (objExcel.Ler_Celula(fGetLetraAlfa(01) + IntToStr(intConLin)) = '') and
               (objExcel.Ler_Celula(fGetLetraAlfa(02) + IntToStr(intConLin)) = '') and
               (objExcel.Ler_Celula(fGetLetraAlfa(03) + IntToStr(intConLin)) = '') Then
               Continue;

            If (objExcel.Ler_Celula(fGetLetraAlfa(01) + IntToStr(intConLin)) = '')  and
               (objExcel.Ler_Celula(fGetLetraAlfa(02) + IntToStr(intConLin)) <> '') and
               (objExcel.Ler_Celula(fGetLetraAlfa(03) + IntToStr(intConLin)) = '')  and
               (objExcel.Ler_Celula(fGetLetraAlfa(02) + IntToStr(intConLin)) = 'RECEITAS') Then
            Begin
               strTpOp := 'R';
               blnCabecalho := True;
            End
            Else
            If (objExcel.Ler_Celula(fGetLetraAlfa(01) + IntToStr(intConLin)) = '') and
               (objExcel.Ler_Celula(fGetLetraAlfa(02) + IntToStr(intConLin)) <> '') and
               (objExcel.Ler_Celula(fGetLetraAlfa(03) + IntToStr(intConLin)) = '') and
               (objExcel.Ler_Celula(fGetLetraAlfa(02) + IntToStr(intConLin)) = 'DESPESAS') Then
            Begin
               strTpOp := 'D';
               blnCabecalho := True;
            End
            Else
            Begin
               blnCabecalho := False;

               If (objExcel.Ler_Celula(fGetLetraAlfa(02) + IntToStr(intConLin)) = 'DESPESAS') Then
                   strTpOp := 'D'
               Else
               If (objExcel.Ler_Celula(fGetLetraAlfa(02) + IntToStr(intConLin)) = 'RECEITAS') Then
                   strTpOp := 'R';

            End;

            If Not blnCabecalho Then
            Begin

              With QryGrava_ Do
              Begin
                 Close;
                 Sql.Clear;
                 Sql.Text := ' INSERT INTO ' +
                             '   DETPRV ' +
                             ' SET ' +
                             ' PRV_CODEMP = :CODEMP, ' +
                             ' PRV_TIPDES = :TIPDES, ' +
                             ' PRV_CODCTA = :CODCTA, ' +
                             ' PRV_DESCRI = :DESCRI, ' +
                             ' PRV_ANOREF = :ANOREF, ' +
                             ' PRV_MES_01 = :MES_01, ' +
                             ' PRV_MES_02 = :MES_02, ' +
                             ' PRV_MES_03 = :MES_03, ' +
                             ' PRV_MES_04 = :MES_04, ' +
                             ' PRV_MES_05 = :MES_05, ' +
                             ' PRV_MES_06 = :MES_06, ' +
                             ' PRV_MES_07 = :MES_07, ' +
                             ' PRV_MES_08 = :MES_08, ' +
                             ' PRV_MES_09 = :MES_09, ' +
                             ' PRV_MES_10 = :MES_10, ' +
                             ' PRV_MES_11 = :MES_11, ' +
                             ' PRV_MES_12 = :MES_12, ' +
                             ' PRV_ARQINC = :ARQINC, ' +
                             ' AUTOINCREM = :AUTOIN  ';

                 ParamByName('TIPDES').AsString := strTpOp;
                 ParamByName('DESCRI').AsString := objExcel.Ler_Celula(fGetLetraAlfa(02) + IntToStr(intConLin));
                 ParamByName('CODCTA').AsString := fRetornaPlanoContas( objExcel.Ler_Celula(fGetLetraAlfa(01) + IntToStr(intConLin)) ); //fTiraPontoVirgula( objExcel.Ler_Celula(fGetLetraAlfa(01) + IntToStr(intConLin)) );
                 ParamByName('ANOREF').AsString := mskAno.Text;
                 ParamByName('MES_01').Value    := IIF( objExcel.Ler_Celula(fGetLetraAlfa(03) + IntToStr(intConLin)) = '', 0.00, FormataValorFloat(objExcel.Ler_Celula(fGetLetraAlfa(03) + IntToStr(intConLin))) );
                 ParamByName('MES_02').Value    := IIF( objExcel.Ler_Celula(fGetLetraAlfa(04) + IntToStr(intConLin)) = '', 0.00, FormataValorFloat(objExcel.Ler_Celula(fGetLetraAlfa(04) + IntToStr(intConLin))) );
                 ParamByName('MES_03').Value    := IIF( objExcel.Ler_Celula(fGetLetraAlfa(05) + IntToStr(intConLin)) = '', 0.00, FormataValorFloat(objExcel.Ler_Celula(fGetLetraAlfa(05) + IntToStr(intConLin))) );
                 ParamByName('MES_04').Value    := IIF( objExcel.Ler_Celula(fGetLetraAlfa(06) + IntToStr(intConLin)) = '', 0.00, FormataValorFloat(objExcel.Ler_Celula(fGetLetraAlfa(06) + IntToStr(intConLin))) );
                 ParamByName('MES_05').Value    := IIF( objExcel.Ler_Celula(fGetLetraAlfa(07) + IntToStr(intConLin)) = '', 0.00, FormataValorFloat(objExcel.Ler_Celula(fGetLetraAlfa(07) + IntToStr(intConLin))) );
                 ParamByName('MES_06').Value    := IIF( objExcel.Ler_Celula(fGetLetraAlfa(08) + IntToStr(intConLin)) = '', 0.00, FormataValorFloat(objExcel.Ler_Celula(fGetLetraAlfa(08) + IntToStr(intConLin))) );
                 ParamByName('MES_07').Value    := IIF( objExcel.Ler_Celula(fGetLetraAlfa(09) + IntToStr(intConLin)) = '', 0.00, FormataValorFloat(objExcel.Ler_Celula(fGetLetraAlfa(09) + IntToStr(intConLin))) );
                 ParamByName('MES_08').Value    := IIF( objExcel.Ler_Celula(fGetLetraAlfa(10) + IntToStr(intConLin)) = '', 0.00, FormataValorFloat(objExcel.Ler_Celula(fGetLetraAlfa(10) + IntToStr(intConLin))) );
                 ParamByName('MES_09').Value    := IIF( objExcel.Ler_Celula(fGetLetraAlfa(11) + IntToStr(intConLin)) = '', 0.00, FormataValorFloat(objExcel.Ler_Celula(fGetLetraAlfa(11) + IntToStr(intConLin))) );
                 ParamByName('MES_10').Value    := IIF( objExcel.Ler_Celula(fGetLetraAlfa(12) + IntToStr(intConLin)) = '', 0.00, FormataValorFloat(objExcel.Ler_Celula(fGetLetraAlfa(12) + IntToStr(intConLin))) );
                 ParamByName('MES_11').Value    := IIF( objExcel.Ler_Celula(fGetLetraAlfa(13) + IntToStr(intConLin)) = '', 0.00, FormataValorFloat(objExcel.Ler_Celula(fGetLetraAlfa(13) + IntToStr(intConLin))) );
                 ParamByName('MES_12').Value    := IIF( objExcel.Ler_Celula(fGetLetraAlfa(14) + IntToStr(intConLin)) = '', 0.00, FormataValorFloat(objExcel.Ler_Celula(fGetLetraAlfa(14) + IntToStr(intConLin))) );
                 ParamByName('CODEMP').AsString := edtCodEmp.Text;
                 ParamByName('ARQINC').AsString := strAutoIn;
                 ParamByName('AUTOIN').AsString := fRetAutoIncrem('DETPRV', edtCodEmp.Text);

                 ExecSql;
              End;

            End;

          End;
        End
        Else
        Begin
          If blnIniTra Then
             fRollBack;

          strParam_[0] := 'Esconder';
          FSubject_.pNotify(strParam_);
          Finalize(strParam_);

          FreeAndNil(stlArquiv);
          FreeAndNil(qryGrava_);

          btnImportar.enabled := True;

          fMensagem('ATENÇÃO','Arquivo sem movimentação ou corrompido!' +#13+ 'Verifique o layout esperado no botão [?]', ['&O k']);

          Exit;

        End;

        FreeAndNil(qryGrava_);
      End
      Else
      Begin

        If blnIniTra Then
           fRollBack;

        strParam_[0] := 'Esconder';
        FSubject_.pNotify(strParam_);
        Finalize(strParam_);

        FreeAndNil(stlArquiv);
        FreeAndNil(qryGrava_);

        btnImportar.enabled := True;

        fMensagem('ATENÇÃO','Arquivo sem movimentação ou corrompido!' +#13+ 'Verifique o layout esperado no botão [?]', ['&O k']);
        Exit;

      End;

      objExcel.FecharArquivo;

      FreeAndNil(stlArquiv);
      FreeAndNil(objExcel);

      // Traz o grid preenchido para que seja feito relacionmento
      pAbreConsulta();

      strParam_[0] := '';
      strParam_[1] := '0';
      strParam_[2] := 'Relacionando lançamentos...';
      FSubject_.pNotify(strParam_);

      If fRelacionaArquivo(strAutoIn) Then
      Begin
         strNomArqNovo := ChangeFileExt(strNomArq,'.IMP');
         RenameFile(strNomArq, strNomArqNovo);
      End;

      pAtualizaTotais(True);

      pTotaisGruposDespesas;

      If blnIniTra Then
         fCommit;

      strParam_[0] := 'Esconder';
      FSubject_.pNotify(strParam_);

      if cdsErros.RecordCount > 0 then
      begin
        fMensagem('','Ocorreram erros na importação do arquivo, clique em Ok para emitir o relatório de inconsistências!', ['&O k']);
        frxRelatorioJ.Script.Variables['NOMEMP'] := fRetNomeEmpresaSelec(edtCodEmp.Text);
        pPreviewReport(Self.Name, Self.Caption + ' (Relatório de inconsistências)', frxRelatorioJ);
      end;

      fMensagem('','Arquivo importado com sucesso!', ['&O k']);
      Result := True;

      btnImportar.enabled := True;

      Finalize(strParam_);
    Except
      On e: Exception Do
      Begin
        If blnIniTra Then
           fRollBack;

        strParam_[0] := 'Esconder';
        FSubject_.pNotify(strParam_);
        Finalize(strParam_);

        FreeAndNil(stlArquiv);
        FreeAndNil(qryGrava_);

        btnImportar.enabled := True;

        If Copy(E.Message, 1, 9) = 'MENSAGEM-' Then
        Begin
          fMensagem('ATENÇÃO', RightStr(E.Message, E.Message.Length - 9), ['&OK']);
          Exit;
        End;

        pMensagensErro(E.Message,'[pImportaArquivo]');
      End;
    End;
  End;
end;

function TfrmCadPrevisaoMensal.fRelacionaArquivo(strArqInc: String): Boolean;
var
  qryAuxSQL: TUniQuery;
  intAux : Integer;
  strDescPesq : String;
begin
  Result := False;

  If  strArqInc <> '' Then
  Begin

    Try

      qryAuxSQL := fCriaQuery;
      With qryAuxSQL Do
      Begin
        Sql.Clear;
        Sql.Text := ' SELECT * FROM DETPRV PRV ' +
                    '  LEFT JOIN CADCTA C ON C.CTA_CODCTA = PRV.PRV_CODCTA ' +
                    '  WHERE PRV.PRV_ARQINC = :ARQINC ';

        ParamByName('ARQINC').AsString := strArqInc;
        Open;

        If RecordCount > 0 Then
        Begin

           qryAuxSQL.First;

           // Relacionados pelos plano de contas
           While Not qryAuxSQL.Eof Do
           Begin

             If qryAuxSQL.FieldByName('PRV_CODCTA').AsString <> '' Then
             Begin

                // Verifica comparando a chave da tabela contas;
                cdsDespesas.DisableControls;

                cdsDespesas.first;
                If cdsDespesas.Locate('CODCTA', qryAuxSQL.FieldByName('PRV_CODCTA').AsString, []) Then
                Begin
                   cdsDespesas.Edit;
                   For intAux := 1 to 12 Do
                       cdsDespesas.FieldByName('VAL' + fStrZero(intAux, 3)).AsFloat := qryAuxSQL.FieldByName('PRV_MES_' + fStrZero(intAux, 2)).AsFloat;
                   cdsDespesas.Post;
                End
                Else
                Begin

                   cdsErros.Append;
                   cdsErrosCODCTA.AsString    := qryAuxSQL.FieldByName('PRV_CODCTA').AsString;
                   cdsErrosDESCRICAO.AsString := 'Plano de contas não cadastrado';
                   cdsErros.Post;

                End;
                cdsDespesas.EnableControls;

             End

             Else
             // Despesas relacionadas pela decrição
             If (qryAuxSQL.FieldByName('PRV_CODCTA').AsString = '') And (qryAuxSQL.FieldByName('PRV_DESCRI').AsString <> '') Then
             Begin

               If (qryAuxSQL.FieldByName('PRV_TIPDES').AsString = 'D') And
                  ((qryAuxSQL.FieldByName('PRV_DESCRI').AsString = 'CUSTO DA MERCADORIA VENDIDA') Or
                   (qryAuxSQL.FieldByName('PRV_DESCRI').AsString = 'DESCONTO CONCEDIDO'))   Then
               Begin

                  cdsDespesas.DisableControls;

                  cdsDespesas.first;
                  If (cdsDespesas.Locate('DESCRI', qryAuxSQL.FieldByName('PRV_DESCRI').AsString, [])) And
                     (qryAuxSQL.FieldByName('PRV_TIPDES').AsString = 'D') Then
                  Begin
                     cdsDespesas.Edit;
                     For intAux := 1 to 12 Do
                         cdsDespesas.FieldByName('VAL' + fStrZero(intAux, 3)).AsFloat := qryAuxSQL.FieldByName('PRV_MES_' + fStrZero(intAux, 2)).AsFloat;
                     cdsDespesas.Post;
                  End
                  Else
                  Begin

                     cdsErros.Append;
                     cdsErrosCODCTA.AsString    := qryAuxSQL.FieldByName('PRV_DESCRI').AsString;
                     cdsErrosDESCRICAO.AsString := 'Descrição não encontrada';
                     cdsErros.Post;

                  End;

                  cdsDespesas.EnableControls;

               End
               Else
               If (qryAuxSQL.FieldByName('PRV_TIPDES').AsString = 'R') And
                  ((qryAuxSQL.FieldByName('PRV_DESCRI').AsString = 'VENDA BRUTA') Or
                   (qryAuxSQL.FieldByName('PRV_DESCRI').AsString = 'VENDAS À VISTA') Or
                   (qryAuxSQL.FieldByName('PRV_DESCRI').AsString = 'VENDAS À PRAZO') Or
                   (qryAuxSQL.FieldByName('PRV_DESCRI').AsString = 'DEVOLUÇÕES') Or
                   (qryAuxSQL.FieldByName('PRV_DESCRI').AsString = 'JUROS RECEBIDO') Or
                   (qryAuxSQL.FieldByName('PRV_DESCRI').AsString = 'SERVIÇOS E REPRESENTAÇÕES') ) Then
               Begin

                  cdsReceitas.disableControls;
                  cdsReceitas.First;

                  If qryAuxSQL.FieldByName('PRV_DESCRI').AsString = 'VENDA BRUTA' Then
                     strDescPesq := 'VENDAS À PRAZO'
                  Else
                     strDescPesq := qryAuxSQL.FieldByName('PRV_DESCRI').AsString;

                  If (cdsReceitas.Locate('DESCRI', strDescPesq, [])) Then
                  Begin
                     cdsReceitas.Edit;
                     For intAux := 1 to 12 Do
                         cdsReceitas.FieldByName('VAL' + fStrZero(intAux, 3)).AsFloat := qryAuxSQL.FieldByName('PRV_MES_' + fStrZero(intAux, 2)).AsFloat;
                     cdsReceitas.Post;
                  End
                  Else
                  Begin
                     cdsErros.Append;
                     cdsErrosCODCTA.AsString    := qryAuxSQL.FieldByName('PRV_DESCRI').AsString;
                     cdsErrosDESCRICAO.AsString := 'Descrição não encontrada';
                     cdsErros.Post;
                  End;
                  cdsReceitas.EnableControls;

               End;

             End;

             qryAuxSQL.Next;

           End;

        End;

        Result := True;

      End;

      FreeAndNil(qryAuxSQL);
    Except
      On E : Exception Do
      Begin
        Raise Exception.Create('Ocorreu um erro ao efetuar o relacionamento: ' + E.Message);
      End;
    End;

  End;

end;

function TfrmCadPrevisaoMensal.fVerificaMovimento: Boolean;
var
  qryAuxil_: TUniQuery;
  strMesBas: String;
begin
  qryAuxil_ := fCriaQuery;
  Result    := True;
  blnAtualizaImportacao := False;

  With qryAuxil_ Do
  Begin
    Sql.Clear;
    Sql.Text := ' SELECT ' +
                '   PME_MESANO ' +
                ' FROM   ' +
                ' CADPME ' +
                ' WHERE  ' +
                ' PME_CODEMP = :CODEMP AND '+
                ' YEAR(PME_MESANO) = :ANO ';

    strMesBas := fTiraCaracEspeciais(mskAno.Text);
    ParamByName('CODEMP').AsString := edtCodEmp.Text;
    ParamByName('ANO').AsString    := MskAno.Text;
    Open;

    If Not IsEmpty Then
    Begin
      If fMensagem('ATENÇÃO!','Já existem lançamentos para o movimento da empresa "' + edtCodEmp.Text + ' e ano ' + mskAno.Text + ' ". Deseja atualizar os lançamentos?' , ['&S i m', '&N ã o']) =  1 Then
      Begin
        Result := True;
        blnAtualizaImportacao := True;
        FreeAndNil(qryAuxil_);
        Exit;
      End
      Else
      Begin
        Result := False;
        FreeAndNil(qryAuxil_);
        Exit;
      End;
    End;

  End;
  FreeAndNil(qryAuxil_);
end;

function TfrmCadPrevisaoMensal.fRedirecionaValoresReceitasAlteradas( strReceitaAlterada : String ) : Boolean;
Begin

  Result := False;

  cdsReceitas.DisableControls;
  cdsReceitas.first;

  If cdsReceitas.Locate('DESCRI', strReceitaAlterada, []) Then
  Begin
     cdsReceitas.edit;
     cdsReceitas.FieldByName('DESCRI').AsString := 'VENDAS À PRAZO';
     cdsReceitas.Post;

     Result := True;
  End;

  cdsReceitas.EnableControls;

End;

procedure TfrmCadPrevisaoMensal.pDeleteCadPmeReceitas;
Var
  LQry: TUniQuery;
Begin
  LQry := fCriaQuery;
  Try
    LQry.SQL.Text :=
      ' DELETE FROM CADPME                       ' +
      ' WHERE YEAR(PME_MESANO) = :MESANO         ' +
      '   AND PME_CODEMP       = :CODEMP         ' +
      '   AND PME_DESREC       = ''R''           ';
    LQry.ParamByName('MESANO').AsInteger := StrToInt(mskAno.Text);
    LQry.ParamByName('CODEMP').AsString  := edtCodEmp.Text;
    LQry.ExecSQL;
  Finally
    FreeAndNil(LQry);
  End;
End;

procedure TfrmCadPrevisaoMensal.pDeleteCadPmeDespesas;
Var
  LQry: TUniQuery;
Begin
  LQry := fCriaQuery;
  Try
    LQry.SQL.Text :=
      ' DELETE FROM CADPME                       ' +
      ' WHERE YEAR(PME_MESANO) = :MESANO         ' +
      '   AND PME_CODEMP       = :CODEMP         ' +
      '   AND PME_DESREC       = ''D''           ';
    LQry.ParamByName('MESANO').AsInteger := StrToInt(mskAno.Text);
    LQry.ParamByName('CODEMP').AsString  := edtCodEmp.Text;
    LQry.ExecSQL;
  Finally
    FreeAndNil(LQry);
  End;
end;

function TfrmCadPrevisaoMensal.fTemCadPme: Boolean;
  Var
    qryCadPme : TUniQuery;
begin
  qryCadPme := fCriaQuery;
  Try
    qryCadPme.Close;
    qryCadPme.SQL.Clear;
    qryCadPme.SQL.Text := '  SELECT                           ' +
                          '    PME_MESANO                     ' +
                          '  FROM                             ' +
                          '    CADPME                         ' +
                          '  WHERE YEAR(PME_MESANO) = :MESANO ' +
                          '  AND PME_CODEMP = :CODEMP         ' +
                          '  LIMIT 1                          ' ;
    qryCadPme.ParamByName('MESANO').AsString := mskAno.Text;
    qryCadPme.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryCadPme.Open;
    Result := (Not qryCadPme.IsEmpty);
  Finally
    FreeAndNil(qryCadPme);
  End;
end;

end.

