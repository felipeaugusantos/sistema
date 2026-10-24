unit untCadMetasValorPedCom;

interface

uses
  Windows, Classes, Controls, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls,
  MaskEditFocus, EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, UniClientDataSet, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Uni, cxLookAndFeels, cxLookAndFeelPainters,
  cxNavigator, dxScreenTip, dxCustomHint, cxHint, Mask, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient;

type
  TfrmCadMetasValorPedCom = class(TfrmPai)
    pnlCadMPC: TPanel;
    pnlPeriodo: TPanel;
    Label1: TLabel;
    lblEmpres: TLabel;
    mskDta: TMaskEditFocus;
    edtDesEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    pnlDetMPC: TPanel;
    cxgCadMPC: TcxGrid;
    cxgCadMPCView: TcxGridDBTableView;
    cxgCliCnd: TcxGridLevel;
    cdsCadMPC: TUniClientDataSet;
    cdsCadMPCCODOPE: TStringField;
    cdsCadMPCNOMOPE: TStringField;
    cdsCadMPCTOTMET: TFloatField;
    dtsCadMPC: TDataSource;
    cxgCadMPCViewCODOPE: TcxGridDBColumn;
    cxgCadMPCViewNOMOPE: TcxGridDBColumn;
    cxgCadMPCViewTOTMET: TcxGridDBColumn;
    cxgDetMPC: TcxGrid;
    cxgDetMPCView: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cdsDetMPC: TUniClientDataSet;
    dtsDetMPC: TDataSource;
    cdsDetMPCCODFOR: TStringField;
    cdsDetMPCNOMFOR: TStringField;
    cdsDetMPCPERFOR: TFloatField;
    cxgDetMPCViewCODFOR: TcxGridDBColumn;
    cxgDetMPCViewNOMFOR: TcxGridDBColumn;
    cxgDetMPCViewPERFOR: TcxGridDBColumn;
    pnlFornecedor: TPanel;
    Label2: TLabel;
    edtDesFor: TEditFocus;
    edtCodFor: TEditFocus;
    edtTotPer: TEditFocus;
    Label4: TLabel;
    btnConfirmaPeriodo: TBitBtnLocked;
    edtPerFor: TEditFocus;
    Label5: TLabel;
    btnConfirmar: TBitBtnLocked;
    Panel1: TPanel;
    shpEdit: TShape;
    Label6: TLabel;
    cxHint: TcxHintStyleController;
    procedure btnConfirmaPeriodoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cdsCadMPCAfterScroll(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cdsDetMPCAfterPost(DataSet: TDataSet);
    procedure cdsCadMPCAfterPost(DataSet: TDataSet);
    procedure cdsDetMPCAfterDelete(DataSet: TDataSet);
    procedure cxgCadMPCViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgDetMPCViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodForEnter(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mskDtaExit(Sender: TObject);
  private
    qryOpe: TUniQuery;
    qryFor: TUniQuery;
    blnModificou: Boolean;
    FblnTodasEmpresas: boolean;
    procedure pInsereFornecedor;
    procedure pApagaFornecedor;
    procedure pCarregaCompradores;
    procedure pCarregaFornecedores;

    procedure pVoltaPeriodo;
    procedure pAvancaDetalhe;
    procedure pVoltaMetas(blnExibeConfirmacao: Boolean);

    function fGetTotPer: Double;

    function fTemMetaSemFornecedor: Boolean;
    procedure pSetEdtPerTot(fltTotPer : Double);
    procedure SetblnTodasEmpresas(const Value: boolean);
  public
    property blnTodasEmpresas: boolean read FblnTodasEmpresas write SetblnTodasEmpresas;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses SysUtils, Variants, Graphics, Forms, untFuncoesSimples, untConsultas, System.UITypes,
  untTypesSistema, Math;

{$R *.dfm}

{ TfrmCadMetasValorPedCom }

procedure TfrmCadMetasValorPedCom.btnConfirmaPeriodoClick(Sender: TObject);
begin
  If fVerificaCampos Then
  Begin
    pCarregaCompradores;

    If (qryOpe.IsEmpty) then
    Begin
      pMensagemOk('Não há nenhum operador configurado com o tipo COMPRAS!');
    End;

    blnModificou := False;

    pnlPeriodo.Enabled := False;
    pnlCadMPC.Enabled := True;

    blnFecharComEscape := False;

    pSetFocus(cxgCadMPC);
    cxgCadMPCView.Navigator.Buttons.First.Click;
  End;
end;

procedure TfrmCadMetasValorPedCom.btnConfirmarClick(Sender: TObject);
  Var
    qryCadMPC,
    qryDetMPC: TUniQuery;
    cdsCad: TUniClientDataSet;

    function fLocateVen(strCodVen: String): Boolean;
    begin
      if FblnTodasEmpresas then
         Result := qryCadMPC.Locate('MPC_MESANO;MPC_CODVEN',
                                    VarArrayOf([fTiraCaracEspeciais(mskDta.Text), strCodVen]),
                                    [])
      Else
         Result := qryCadMPC.Locate('MPC_CODEMP;MPC_MESANO;MPC_CODVEN',
                                 VarArrayOf([edtCodEmp.Text, fTiraCaracEspeciais(mskDta.Text), strCodVen]),
                                 []);
    end;
begin
  If (RoundTo(fGetTotPer, -2) <> 100) And Not ((RoundTo(cdsCadMPCTOTMET.AsFloat, -2) = 0) And (RoundTo(fGetTotPer, -2) = 0)) Then
  Begin
    fMensagem('', 'O total percentual do fornecedor deve ser 100%!', ['&O k']);
    Exit;
  End;

  qryCadMPC := fCriaQuery;
  qryDetMPC := fCriaQuery;
  cdsCad := TUniClientDataSet.Create(Nil);
  Try
    fStartTransaction;
    Try
      qryCadMPC.SQL.Add('SELECT');
      qryCadMPC.SQL.Add('  *');
      qryCadMPC.SQL.Add('FROM');
      qryCadMPC.SQL.Add('  CADMPC');
      qryCadMPC.SQL.Add('WHERE');
      if FblnTodasEmpresas then
         qryCadMPC.SQL.Add('  COALESCE(MPC_CODEMP, "") = "" AND')
      else
         qryCadMPC.SQL.Add('  MPC_CODEMP = :CODEMP AND');
     qryCadMPC.SQL.Add('  MPC_MESANO = :MESANO');

      if not FblnTodasEmpresas then
         qryCadMPC.ParamByName('CODEMP').AsString := edtCodEmp.Text;
      qryCadMPC.ParamByName('MESANO').AsString := fTiraCaracEspeciais(mskDta.Text);
      qryCadMPC.Open;

      cdsCad.Data := cdsCadMPC.Data;
      cdsCad.First;
      While Not cdsCad.Eof Do
      Begin
        If fLocateVen(cdsCad.FieldByName('CODOPE').AsString) Then
          qryCadMPC.Edit
        Else
        Begin
          // Se não tiver meta não insere
          If cdsCad.FieldByName('TOTMET').AsFloat = 0 Then
          Begin
            cdsCad.Next;
            Continue;
          End;

          qryCadMPC.Append;
        End;

        if not FblnTodasEmpresas then
        Begin
           qryCadMPC.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADMPC', edtCodEmp.Text);
           qryCadMPC.FieldByName('MPC_CODEMP').AsString := edtCodEmp.Text;
        End
        else
        Begin
           qryCadMPC.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADMPC', VS_strCodEmp);
           qryCadMPC.FieldByName('MPC_CODEMP').Clear;
        End;


        qryCadMPC.FieldByName('MPC_MESANO').AsString := fTiraCaracEspeciais(mskDta.Text);
        qryCadMPC.FieldByName('MPC_CODVEN').AsString := cdsCad.FieldByName('CODOPE').AsString;
        qryCadMPC.FieldByName('MPC_TOTMET').AsFloat  := cdsCad.FieldByName('TOTMET').AsFloat;
        qryCadMPC.Post;

        cdsCad.Next;
      End;

      // Apaga todos fornecedores do vendedor atual pois irá inserir todos novamente.
      qryDetMPC.SQL.Text := 'DELETE FROM DETMPC WHERE COALESCE(MPC_CODEMP, "") = ' + iif(FblnTodasEmpresas, '"" ', ':CODEMP ') + ' AND MPC_MESANO = :MESANO AND MPC_CODVEN = :CODVEN';
      if not FblnTodasEmpresas then
        qryDetMPC.ParamByName('CODEMP').AsString := edtCodEmp.Text;
      qryDetMPC.ParamByName('MESANO').AsString := fTiraCaracEspeciais(mskDta.Text);
      qryDetMPC.ParamByName('CODVEN').AsString := cdsCadMPCCODOPE.AsString;
      qryDetMPC.ExecSQL;

      qryDetMPC.SQL.Text := 'SELECT * FROM DETMPC WHERE FALSE';
      qryDetMPC.Open;

      cdsCad.Data := cdsDetMPC.Data;
      cdsCad.First;
      While Not cdsCad.Eof Do
      Begin
        qryDetMPC.Append;
        if not FblnTodasEmpresas then
           qryDetMPC.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DETMPC', edtCodEmp.Text)
        else
          qryDetMPC.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DETMPC', VS_strCodEmp);

        qryDetMPC.FieldByName('MPC_PERFOR').AsFloat  := cdsCad.FieldByName('PERFOR').AsFloat;
        if cdsCad.FieldByName('CODFOR').AsString = '00000000' Then
          qryDetMPC.FieldByName('MPC_CODFOR').Clear
        Else
          qryDetMPC.FieldByName('MPC_CODFOR').AsString := cdsCad.FieldByName('CODFOR').AsString;
        if not FblnTodasEmpresas then
           qryDetMPC.FieldByName('MPC_CODEMP').AsString := edtCodEmp.Text
        else
           qryDetMPC.FieldByName('MPC_CODEMP').Clear;

        qryDetMPC.FieldByName('MPC_MESANO').AsString := fTiraCaracEspeciais(mskDta.Text);
        qryDetMPC.FieldByName('MPC_CODVEN').AsString := cdsCadMPC.FieldByName('CODOPE').AsString;
        qryDetMPC.Post;

        cdsCad.Next;
      End;

      fCommit;

      blnModificou := False;
      qryFor.Refresh;
      pVoltaMetas(False);
    Except
      On E:Exception Do
      Begin
        fRollback;
        pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    FreeAndNil(qryCadMPC);
    FreeAndNil(qryDetMPC);
    FreeAndNil(cdsCad);
  End;
end;

procedure TfrmCadMetasValorPedCom.cdsCadMPCAfterPost(DataSet: TDataSet);
begin
  blnModificou := True;
end;

procedure TfrmCadMetasValorPedCom.cdsCadMPCAfterScroll(DataSet: TDataSet);
begin
  If qryFor.Active Then
    pCarregaFornecedores;
end;


procedure TfrmCadMetasValorPedCom.pSetEdtPerTot(fltTotPer: Double);
begin
  edtTotPer.Text := FormatFloat('#,##0.00', fltTotPer);
  If fltTotPer < 100 then
    edtTotPer.Color := clYellow
  Else
  If fltTotPer > 100 then
    edtTotPer.Color := clRed
  Else
    edtTotPer.Color := clGreen;

  if edtTotPer.Color = clYellow Then
    edtTotPer.Font.Color := clBlack
  Else
    edtTotPer.Font.Color := clWhite;

  edtTotPer.NormalColor := edtTotPer.Color;

end;

procedure TfrmCadMetasValorPedCom.cdsDetMPCAfterDelete(DataSet: TDataSet);
begin
  pSetEdtPerTot(fGetTotPer)
end;

procedure TfrmCadMetasValorPedCom.cdsDetMPCAfterPost(DataSet: TDataSet);
begin
  pSetEdtPerTot(fGetTotPer)
end;

procedure TfrmCadMetasValorPedCom.cxgCadMPCViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (Not pnlCadMPC.Enabled) And (AViewInfo.GridRecord.Selected) Then
    ACanvas.Brush.Color := shpEdit.Brush.Color;

end;

procedure TfrmCadMetasValorPedCom.cxgDetMPCViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    edtCodFor.Text := cdsDetMPCCODFOR.AsString;
    edtDesFor.Text := cdsDetMPCNOMFOR.AsString;
    edtPerFor.Text := FormatFloat('#,##0.00', cdsDetMPCPERFOR.AsFloat );
    pSetFocus(edtCodFor);
  end;
end;

procedure TfrmCadMetasValorPedCom.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp, True, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMetasValorPedCom.edtCodForEnter(Sender: TObject);
  Var
    pntPoint : TPoint;
begin
  inherited;
  if fGetTotPer = 0 Then
  Begin
    pntPoint.X := edtCodFor.Left;
    pntPoint.Y := edtCodFor.Top;
    pntPoint   := edtCodFor.ClientToScreen( pntPoint );
    cxHint.ShowHint( pntPoint.X, pntPoint.Y, '', 'Deixar o Código do Fornecedor em Branco Para Inserir a Meta para todos os Fornecedores' );
  End;
end;

procedure TfrmCadMetasValorPedCom.edtCodForExit(Sender: TObject);
begin
  inherited;
  cxHint.HideHint;
end;

procedure TfrmCadMetasValorPedCom.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFor: TConsultasArray;
begin
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrFor) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadMetasValorPedCom.fGetTotPer: Double;
  Var
    cdsPer: TUniClientDataSet;
begin
  cdsPer := TUniClientDataSet.Create(Nil);
  Result := 0;
  Try
    cdsPer.Data := cdsDetMPC.Data;
    cdsPer.First;
    While Not cdsPer.Eof Do
    Begin
      Result := Result + cdsPer.FieldByName('PERFOR').AsFloat;
      cdsPer.Next;
    End;
  Finally
    FreeAndNil(cdsPer);
  End;

  Result := RoundTo(Result, -2);
end;

procedure TfrmCadMetasValorPedCom.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryOpe);
  FreeAndNil(qryFor);
  inherited;
end;

procedure TfrmCadMetasValorPedCom.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  If fCheckParent(ActiveControl, pnlCadMPC) Then
  Begin
    Case Key Of
      VK_ESCAPE: pVoltaPeriodo;
      VK_RETURN: pAvancaDetalhe;
    End;
  End

  Else If fCheckParent(ActiveControl, pnlDetMPC) Then
  Begin
    Case Key Of
      VK_ESCAPE: pVoltaMetas(True);
      VK_F10: If btnConfirmar.Enabled Then btnConfirmar.Click;
      VK_DELETE: pApagaFornecedor;

    End;
  End

  Else
    Inherited;
end;

procedure TfrmCadMetasValorPedCom.FormShow(Sender: TObject);
begin
  inherited;
  inherited;
  qryOpe := fCriaQuery;
  qryOpe.SQL.Add('SELECT');
  qryOpe.SQL.Add('  OPE_CODOPE,');
  qryOpe.SQL.Add('  OPE_NOMOPE,');
  qryOpe.SQL.Add('  MPC_TOTMET');
  qryOpe.SQL.Add('FROM');
  qryOpe.SQL.Add('  CADOPE');
  qryOpe.SQL.Add('  LEFT JOIN CADMPC ON MPC_CODVEN = OPE_CODOPE');
  if FblnTodasEmpresas then
    qryOpe.SQL.Add('                  AND COALESCE(MPC_CODEMP, "") = "" ')
  Else
    qryOpe.SQL.Add('                  AND MPC_CODEMP = :CODEMP');
  qryOpe.SQL.Add('                  AND MPC_MESANO = :MESANO');
  qryOpe.SQL.Add('WHERE OPE_INTEXT = "C"');
  qryOpe.SQL.Add('  AND OPE_STATUS <> "I"');
  qryOpe.SQL.Add('ORDER BY');
  qryOpe.SQL.Add('  OPE_CODOPE');

  qryFor := fCriaQuery;
  qryFor.SQL.Add('SELECT');
  qryFor.SQL.Add('  MPC_CODVEN,');
  qryFor.SQL.Add('  IFNULL(FOR_CODFOR, "00000000") AS FOR_CODFOR,');
  qryFor.SQL.Add('  IFNULL(FOR_NOMFOR, "TODOS"   ) AS FOR_NOMFOR,');
  qryFor.SQL.Add('  MPC_PERFOR');
  qryFor.SQL.Add('FROM');
  qryFor.SQL.Add('  DETMPC');
  qryFor.SQL.Add('  LEFT JOIN CADFOR ON FOR_CODFOR = MPC_CODFOR');
  qryFor.SQL.Add('WHERE');
  if not FblnTodasEmpresas then
    qryFor.SQL.Add('  MPC_CODEMP = :CODEMP AND')
  else
    qryFor.SQL.Add('  COALESCE(MPC_CODEMP, "") = "" AND');

  qryFor.SQL.Add('  MPC_MESANO = :MESANO');
  qryFor.SQL.Add('ORDER BY');
  qryFor.SQL.Add('  MPC_CODFOR');

  cdsCadMPC.CreateDataSet;
  cdsDetMPC.CreateDataSet;

  cdsCadMPC.Open;
  cdsDetMPC.Open;
end;

function TfrmCadMetasValorPedCom.fTemMetaSemFornecedor: Boolean;
  Var
    intPos: Integer;
begin
  Result := False;
  intPos := cdsCadMPC.recNo;

  cdsCadMPC.First;
  While Not cdsCadMPC.Eof Do
  Begin
    If (cdsCadMPCTOTMET.AsFloat > 0) And (RoundTo(fGetTotPer, -2) = 0) Then
    Begin
      Result := True;
      Exit;
    End;

    cdsCadMPC.Next;
  End;

  cdsCadMPC.recNo := intPos;
end;

function TfrmCadMetasValorPedCom.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strMsg: String;
begin
  Result := True;

  If pnlPeriodo.Enabled Then
  Begin
    If Sender = mskDta Then
    Begin
      If StrToDateDef('01/' + mskDta.Text, 0) = 0 Then
        strMsg := 'Digite um período válido!';
    End

    Else If (Sender = edtCodEmp ) and (not FblnTodasEmpresas) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
        strMsg := 'Código da Empresa precisa ser preenchido!'
      Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

        If fEmptyStr(edtDesEmp.Text) Then
          strMsg := 'Código da Empresa não encontrado!';
      End;
    End;
  End;

  If pnlDetMPC.Enabled Then
  Begin
    If Sender = edtCodFor Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin
        If RoundTo(fGetTotPer, -2) = 100 Then
        Begin
          pSetFocus(btnConfirmar);
          blnMudarFoco := False;
        End
        Else If RoundTo(fGetTotPer, -2) = 0 Then
        Begin
          if blnBuscaPorChave Then
            If (fMensagem('ATENÇÃO', 'Deseja Definir a Meta Para todos os Fornecedores?', ['&Sim', '&Não']) = 1) Then
            Begin
              cdsDetMPC.Insert;
              cdsDetMPCCODFOR.Value := '00000000';
              cdsDetMPCNOMFOR.Value := 'TODOS';
              cdsDetMPCPERFOR.Value := 100;
              cdsDetMPC.Post;

              pSetFocus(btnConfirmar);
              blnMudarFoco := False;
            End
            Else
              Result := False;
        End

        Else
          strMsg := 'Código do Fornecedor precisa ser preenchido!'
      End
      Else
      Begin
        edtDesFor.Text := fRetNomFornecedor(edtCodFor.Text);

        If fEmptyStr(edtDesFor.Text) Then
          strMsg := 'Código do Fornecedor não encontrado!';

        if blnBuscaPorChave And cdsDetMPC.Locate('CODFOR', edtCodFor.Text, []) then
          edtPerFor.Text := FormatFloat('#,##0.00', cdsDetMPCPERFOR.AsFloat);

      End;
    End

    Else If Sender = edtPerFor Then
    Begin
      If fStrToFloat(edtPerFor.Text) = 0 Then
        strMsg := 'Percentual deve ser maior que zero!'
      Else
      Begin
        If fValidaCampos(edtCodFor, False) Then
        Begin
          pInsereFornecedor;
          pSetFocus(edtCodFor);
          blnMudarFoco := False;
        End;
      End;
    End;
  End;

  If Not fEmptyStr(strMsg) Then
  Begin
    Result := False;
    fMensagem('', strMsg, ['&O k']);
    pSetFocus(Sender);
  End;
end;

procedure TfrmCadMetasValorPedCom.mskDtaExit(Sender: TObject);
begin
  inherited;
  mskDta.Text := fTrataAnoDataMesAno(mskDta.Text);
end;

procedure TfrmCadMetasValorPedCom.pApagaFornecedor;
begin
  If (Not cdsDetMPC.IsEmpty) And (fCheckParent(ActiveControl, cxgDetMPC)) Then
  Begin
    If fMensagem('', 'Deseja realmente apagar esse fornecedor?', ['&Sim', '&Não']) = 1 Then
      cdsDetMPC.Delete;
  End;
end;

procedure TfrmCadMetasValorPedCom.pAvancaDetalhe;
  Var
    strValor : String;
begin
  If cdsCadMPC.State In dsEditModes Then
    cdsCadMPC.Post;

  if cdsCadMPCTOTMET.AsFloat <= 0 Then
  Begin
    pMensagemOk('O Valor da Meta deve Ser Maior ou Igual a Zero!');
    strValor := '0,00';
    fInputQueryTipo('Meta', 'Digite o Valor da Meta para Continuar:', strValor, ttNumerico);

    if fStrToFloat(strValor) > 0 Then
    Begin
      cdsCadMPC.Edit;
      cdsCadMPCTOTMET.AsFloat := fStrToFloat(strValor);
      cdsCadMPC.Post;
    End
    Else
      Exit;

  End;

  pnlCadMPC.Enabled := False;
  pnlDetMPC.Enabled := True;

  btnConfirmar.Enabled := True;

  pSetFocus(edtCodFor);
  blnMudarFoco := True;

end;

procedure TfrmCadMetasValorPedCom.pCarregaCompradores;
begin
  qryOpe.Close;
  qryOpe.ParamByName('MESANO').AsString := fTiraCaracEspeciais(mskDta.Text);
  if not FblnTodasEmpresas then
     qryOpe.ParamByName('CODEMP').AsString := edtCodEmp.Text;
  qryOpe.Open;

  qryFor.Close;
  qryFor.ParamByName('MESANO').AsString := fTiraCaracEspeciais(mskDta.Text);
  if not FblnTodasEmpresas then
    qryFor.ParamByName('CODEMP').AsString := edtCodEmp.Text;

  qryFor.Open;

  cdsCadMPC.EmptyDataSet;

  While Not qryOpe.Eof Do
  Begin
    cdsCadMPC.Append;
    cdsCadMPCCODOPE.AsString := qryOpe.FieldByName('OPE_CODOPE').AsString;
    cdsCadMPCNOMOPE.AsString := qryOpe.FieldByName('OPE_NOMOPE').AsString;
    cdsCadMPCTOTMET.AsFloat  := qryOpe.FieldByName('MPC_TOTMET').AsFloat;
    cdsCadMPC.Post;
    qryOpe.Next;
  End;
end;

procedure TfrmCadMetasValorPedCom.pCarregaFornecedores;
begin
  cdsDetMPC.EmptyDataSet;

  qryFor.Filtered := False;
  qryFor.Filter := 'MPC_CODVEN = ' + QuotedStr(cdsCadMPCCODOPE.AsString);
  qryFor.Filtered := True;

  qryFor.First;
  While Not qryFor.Eof Do
  Begin
    cdsDetMPC.Append;
    cdsDetMPCCODFOR.AsString := qryFor.FieldByName('FOR_CODFOR').AsString;
    cdsDetMPCNOMFOR.AsString := qryFor.FieldByName('FOR_NOMFOR').AsString;
    cdsDetMPCPERFOR.AsFloat  := qryFor.FieldByName('MPC_PERFOR').AsFloat;
    cdsDetMPC.Post;

    qryFor.Next;
  End;
end;

procedure TfrmCadMetasValorPedCom.pInsereFornecedor;
begin
  if (edtCodFor.Text <> '00000000') And cdsDetMPC.Locate('CODFOR', '00000000', []) Then
  Begin
    pMensagemOk('Não é Permitido Inserir Fornecedores Quando Meta Definida para Todos Fornecedores!');
    Exit;
  End;

  If cdsDetMPC.Locate('CODFOR', edtCodFor.Text, []) Then
    cdsDetMPC.Edit
  Else
    cdsDetMPC.Append;
  cdsDetMPCCODFOR.AsString := edtCodFor.Text;
  cdsDetMPCNOMFOR.AsString := edtDesFor.Text;
  cdsDetMPCPERFOR.AsFloat  := fStrToFloat(edtPerFor.Text);
  cdsDetMPC.Post;

  edtCodFor.Clear;
  edtDesFor.Clear;
  edtPerFor.Clear;

end;

procedure TfrmCadMetasValorPedCom.pVoltaMetas(blnExibeConfirmacao: Boolean);
begin
  If (blnExibeConfirmacao) Then
  Begin
    If fMensagem('', 'Deseja cancelar edição dos fornecedores?', ['&Sim', '&Não']) = 2 Then
      Exit;
  End;

  If fTemMetaSemFornecedor Then
    fMensagem('', 'Preencha os fornecedores do comprador "'+ cdsCadMPCCODOPE.AsString +'"', ['&O k']);

  pCarregaFornecedores;

  pnlCadMPC.Enabled := True;
  pnlDetMPC.Enabled := False;

  btnConfirmar.Enabled := False;

  edtCodFor.Clear;
  edtDesFor.Clear;
  edtPerFor.Clear;

  blnMudarFoco := False;
  pSetFocus(cxgCadMPC);
end;

procedure TfrmCadMetasValorPedCom.pVoltaPeriodo;
begin
  If blnModificou Then
  Begin
    If fMensagem('', 'Existem alterações não salvas, deseja cancelar?', ['&Sim','&Não']) = 2 Then
      Exit;
  End;

  cdsCadMPC.EmptyDataSet;

  pnlPeriodo.Enabled := True;
  pnlCadMPC.Enabled := False;

  blnFecharComEscape := True;

  pSetFocus(mskDta);
end;

procedure TfrmCadMetasValorPedCom.SetblnTodasEmpresas(const Value: boolean);
begin
  FblnTodasEmpresas := Value;
  edtCodEmp.Visible := not Value;
  edtDesEmp.Visible := not Value;
  lblEmpres.Visible := not Value;

end;

end.
