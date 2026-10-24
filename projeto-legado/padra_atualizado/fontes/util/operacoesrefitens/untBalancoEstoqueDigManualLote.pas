unit untBalancoEstoqueDigManualLote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, untModulo,
  untConstantes, untCadLote, untBalancoEstoqueDigManual,
  untBalancoEstoqueDigManualLista, BitBtnLockedIncrem, MemDS, DBAccess,
  Datasnap.Provider, frxClass, frxExportCSVTestabilidade, untTypesSistema,
  Datasnap.DBClient;

 type
  TfrmBalancoEstoqueDigManualLote = class(TfrmPaiOrdena)
    qryCadIte: TUniQuery;
    cdsConsultaTOT_PARCON: TAggregateField;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    cdsConsultaTOT_MLPCON: TAggregateField;
    Label1: TLabel;
    edtSalTot: TEditFocus;
    lblSldMl: TLabel;
    edtSldMl: TEditFocus;
    shpRed: TShape;
    lbllegLotInativo: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgConsultaExit(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure dbgConsultaEnter(Sender: TObject);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure cdsConsultaSetText(Sender: TField; const Text: string);
    procedure cdsConsultaAfterEdit(DataSet: TDataSet);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure pMostraTotal;
    Function fValidaSaldos: Boolean;
    Function fGravaLotesDigManual(cdsSalLot: TUniClientDataSet): Boolean;
    procedure pConsultaAfterPost(DataSet: TDataSet);
    procedure pConsultaBeforePost(DataSet: TDataSet);
    procedure pSetCnvMl(const Value: Boolean);
  public
    { Public declarations }
    objCadLot: TCadLot;
    strCodIte: String;
    strCodLote: String;
    blnUsarInativos: Boolean;


    frmBalancoEstoqueDigManual: TfrmBalancoEstoqueDigManual;
    frmBalancoEstoqueDigManualLista : TfrmBalancoEstoqueDigManualLista;
    pOnCancel : TGenericProcedure;

    procedure pAbreConsulta;
    property blnUsaCNV_ML: Boolean write pSetCnvMl;



  protected
    function fGetSql(blnLike: Boolean): String; Override;
  end;

var
  frmBalancoEstoqueDigManualLote: TfrmBalancoEstoqueDigManualLote;

implementation

uses untFuncoesSimples, untCadLoteItens;

{$R *.dfm}

function TfrmBalancoEstoqueDigManualLote.fGetSql(blnLike: Boolean): String;
  Var
    strArmazens: String;

Begin
  strArmazens := TCadLot.fRetLotesContagemAberta;

  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   CADLOT.*, ';
  Result := Result + '   0.000 AS LOT_PARCON, ';
  Result := Result + '   0.000 AS LOT_MLPCON, ';
  Result := Result + '   0  LOT_QTDCHA ';
  Result := Result + ' FROM   ';
  Result := Result + '   CADLOT ';

  Result := Result + ' WHERE ';
  Result := Result + '   LOT_CODITE = ' + QuotedStr(strCodIte);
  Result := Result + '   AND LOT_CODEMP = ' + QuotedStr(VS_strCodEmp);

  If blnUsarInativos Then
    Result := Result + '   AND (LOT_STATUS = "N" OR LOT_STATUS = "S")'
  Else
    Result := Result + '   AND LOT_STATUS = "S" ';

  Result := Result + '   AND LOT_NUMLOT <> "A DEFINIR" ';

  if not fEmptyStr(strCodLote) then
    Result := Result + ' AND LOT_NUMLOT = ' + QuotedStr(strCodLote);
  If Not fEmptyStr(strArmazens) Then
    Result := Result + ' AND (LOT_NUMLOT IN (' + strArmazens + ')) ';

  Result := Result + '   AND LOT_TRANSI = "N" ';

end;

procedure TfrmBalancoEstoqueDigManualLote.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  qryCadIte.Close;

end;

procedure TfrmBalancoEstoqueDigManualLote.pMostraTotal;
Begin
  If TAggregateField(cdsConsulta.FieldByName('TOT_PARCON')).Value = Null Then
    edtSalTot.Text := ''
  Else
    edtSalTot.Text := FloatToStrF(TAggregateField(cdsConsulta.FieldByName('TOT_PARCON')).Value, ffNumber, 12, 3);

  If TAggregateField(cdsConsulta.FieldByName('TOT_MLPCON')).Value = Null Then
    edtSldMl.Text := ''
  Else
    edtSldMl.Text := FloatToStrF(TAggregateField(cdsConsulta.FieldByName('TOT_MLPCON')).Value, ffNumber, 12, 3);
End;

procedure TfrmBalancoEstoqueDigManualLote.pSetCnvMl(const Value: Boolean);
begin
  lblSldMl.Visible := Value;
  edtSldMl.Visible := Value;
  //LOT_MLPCON
  dbgConsulta.Columns[4].Visible := Value;
end;

procedure TfrmBalancoEstoqueDigManualLote.FormShow(Sender: TObject);
begin
  inherited;

  blnSempreRelerBanco := False;
  blnTemSelecao       := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  dbgConsulta.Columns[0].Title.Caption := objCadLot.strTitLab;

  pSetFocus(dbgConsulta);
end;

procedure TfrmBalancoEstoqueDigManualLote.pAbreConsulta;
Begin
  cdsConsulta.AfterPost := Nil;
  cdsConsulta.BeforePost := Nil;
  
  fAbreConsulta(True);

  (cdsConsulta.FieldByName('LOT_PARCON') As TFloatField).OnSetText :=  cdsConsultaSetText;
  (cdsConsulta.FieldByName('LOT_PARCON') As TFloatField).DisplayFormat := '#0.000';

  (cdsConsulta.FieldByName('LOT_MLPCON') As TFloatField).OnSetText :=  cdsConsultaSetText;
  (cdsConsulta.FieldByName('LOT_MLPCON') As TFloatField).DisplayFormat := '#0.000';

  dbgConsulta.Columns[2].Visible := False;
  If (fCfgSis('MARMOR', VarBoolean)) And (fCfgSis('CTRLCH') = '2') Then
    If cdsConsulta.FieldByName('LOT_CHAPA_').AsString = 'S' then
    begin
      dbgConsulta.Columns[2].Visible := True;
      cdsConsulta.beforePost := pConsultaBeforePost;
    end;


  pMostraTotal;
  cdsConsulta.AfterPost := pConsultaAfterPost;
End;

procedure TfrmBalancoEstoqueDigManualLote.btnIncluirClick(Sender: TObject);
  Var
    frmCadLoteItens : TfrmCadLoteItens;
begin
  inherited;

  Try
    pCriarFormularios(TfrmCadLoteItens, frmCadLoteItens);
    If Assigned(frmCadLoteItens) Then
    Begin
      cdsConsulta.Tag := 1;
      frmCadLoteItens.cdsSalLot := cdsConsulta;
      frmCadLoteItens.ShowModal;
      FreeAndNil(frmCadLoteItens);
      cdsConsulta.Tag := 0;
    End;

  Except
    cdsConsulta.Tag := 0;
  End;
end;

Function TfrmBalancoEstoqueDigManualLote.fValidaSaldos: Boolean;
Begin
  With cdsConsulta Do
  Try
    Begin
      DisableControls;
      First;
      While Not eof Do
      Begin
        Edit;
        Post;
        Next;
      End;
      EnableControls;
      Result := True;
    End;
  Except
    Result := False;
    EnableControls;
  End;
End;


procedure TfrmBalancoEstoqueDigManualLote.btnGravarClick(Sender: TObject);
begin
  inherited;

  If Not btnGravar.Enabled Then
    Exit;

  If Not btnGravar.Visible Then
    Exit;

  If cdsConsulta.State = dsEdit Then
    cdsConsulta.post;

  pLimpaPesquisa;

  If fValidaSaldos And
    (fMensagem('', 'Confirma a gravação dos saldos?', ['&Sim', '&Não']) = 1) Then
    fGravaLotesDigManual(cdsConsulta);

end;

procedure TfrmBalancoEstoqueDigManualLote.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10:    btnGravar.Click;
    VK_RETURN: If (Not pnlPesquisa.Visible) And
                  (cdsConsulta.State = dsEdit) Then
                 cdsConsulta.post;
  End;

end;

procedure TfrmBalancoEstoqueDigManualLote.pConsultaAfterPost(DataSet: TDataSet);
begin
  pMostraTotal;
end;

procedure TfrmBalancoEstoqueDigManualLote.pConsultaBeforePost(DataSet: TDataSet);
begin
  If cdsConsulta.FieldByName('LOT_QTDCHA').AsInteger > 0 Then
    cdsConsulta.FieldByName('LOT_PARCON').AsFloat :=  cdsConsulta.FieldByName('LOT_QTDCHA').AsInteger
                                              * cdsConsulta.FieldByName('LOT_MEDL_A').AsFloat
                                              * cdsConsulta.FieldByName('LOT_MEDL_L').AsFloat
end;

procedure TfrmBalancoEstoqueDigManualLote.dbgConsultaExit(Sender: TObject);
begin
  inherited;

  If cdsConsulta.State = dsEdit Then
    cdsConsulta.post;

end;

procedure TfrmBalancoEstoqueDigManualLote.btnSairClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.Active Then
    cdsConsulta.CancelUpdates;

  if Assigned(pOnCancel) then
    pOnCancel;

end;

procedure TfrmBalancoEstoqueDigManualLote.dbgConsultaDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

    With dbgConsulta.Canvas Do
  Begin
    If cdsConsulta.IsEmpty Then
      Exit;

    If cdsConsulta.FieldByName('LOT_STATUS').AsString = 'N' Then
    Begin
      Brush.Color := $008080FF;
    End;
  End;
  dbgConsulta.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmBalancoEstoqueDigManualLote.dbgConsultaEnter(Sender: TObject);
begin
  inherited;

  If Not cdsConsulta.IsEmpty Then
    cdsConsulta.FieldByName('LOT_PARCON').FocusControl;
end;

procedure TfrmBalancoEstoqueDigManualLote.cdsConsultaAfterEdit(DataSet: TDataSet);
begin
  inherited;
  (cdsConsulta.FieldByName('LOT_PARCON') As TFloatField).OnSetText := cdsConsultaSetText;
  (cdsConsulta.FieldByName('LOT_MLPCON') As TFloatField).OnSetText := cdsConsultaSetText;

end;

procedure TfrmBalancoEstoqueDigManualLote.cdsConsultaBeforePost(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    If (FieldByName('LOT_PARCON').AsFloat < 0) Or
       (FieldByName('LOT_MLPCON').AsFloat < 0) Then
    Begin
      fMensagem('', 'O Saldo não pode ser negativo!', ['&Ok']);
      Abort;
    End;

  End;

end;

procedure TfrmBalancoEstoqueDigManualLote.cdsConsultaSetText(Sender: TField; const Text: string);
begin
  if Sender.DataSet.State = dsEdit then
  Begin
    if Text <> '' then
      Sender.AsString := FormatFloat('#0.00', fStrToFloat(Text));
  end;
end;

Function TfrmBalancoEstoqueDigManualLote.fGravaLotesDigManual(cdsSalLot: TUniClientDataSet): Boolean;
  Var
    intOrdCon: Integer;
    blnTemContagem: Boolean;
Begin
  Try
    intOrdCon := 1;
    Result := True;

    blnTemContagem := False;

    fStartTransaction;

    With cdsSalLot Do
    Begin
      DisableConstraints;

      First;
      While Not eof Do
      Begin

          If (FieldByName('LOT_PARCON').AsFloat > 0) Or
             (FieldByName('LOT_MLPCON').AsFloat > 0) Then
        Begin
          blnTemContagem := True;

          intOrdCon := objCadLot.fRetOrdemItem;

          Result := objCadLot.fSalvaContagemLote(FieldByName('AUTOINCREM').AsString, '', '',
                                                 frmBalancoEstoqueDigManual.strCodDig,
                                                 '',
                                                 FieldByName('LOT_PARCON').AsFloat,
                                                 FieldByName('LOT_MLPCON').AsFloat,
                                                 intOrdCon,
                                                 '',
                                                 frmBalancoEstoqueDigManual.strOperCfg);

          If Not Result Then
            Break;

          If FieldByName('LOT_STATUS').AsString = 'N' Then
          Begin
            If Not objCadLot.fAtivarLote(FieldByName('AUTOINCREM').AsString) Then
              Exit;
          End;

          frmBalancoEstoqueDigManualLista.pAtualiza(strCodIte, FieldByName('AUTOINCREM').AsString);

          fGravaLogContEst(frmBalancoEstoqueDigManual.strCodDig,
                           strCodIte,
                           FieldByName('LOT_NUMLOT').AsString,
                           FieldByName('LOT_PARCON').AsFloat,
                           FieldByName('LOT_MLPCON').AsFloat);
        End;

        Next;
      End;

      EnableControls;
    End;

    If Result And blnTemContagem And ((TAggregateField(cdsSalLot.FieldByName('TOT_PARCON')).Value <> Null) Or
                                      (TAggregateField(cdsSalLot.FieldByName('TOT_MLPCON')).Value <> Null)) Then
    Begin
      With frmBalancoEstoqueDigManual Do
        Result :=  fSalvaContagemManual(edtCodIte.Text,
                     TAggregateField(cdsSalLot.FieldByName('TOT_PARCON')).Value,
                     TAggregateField(cdsSalLot.FieldByName('LOT_MLPCON')).Value, intOrdCon, False, False, '', frmBalancoEstoqueDigManual.strOperCfg);
    End;

    If Result Then
    Begin
      fCommit;
      frmBalancoEstoqueDigManual.pMostraLote(False);
      pSetFocus(frmBalancoEstoqueDigManual.edtCodIte);
    End

    Else fRollBack;

  Except
    On E: Exception Do
    Begin
      Result   := False;
      fRollBack;
      pMensagensErro(E.Message, '[fGravaLotesCont]');

      cdsSalLot.EnableControls;
    End;
  End;

End;

end.
