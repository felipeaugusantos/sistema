unit untCadMetasFornecValFat;

interface

uses
  Windows, Classes, Controls, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, UniClientDataSet,
  UniDataSetProvider, Uni, Mask, MaskEditFocus, EditFocus,
  cxDBLookupComboBox, untModulo, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Provider, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadMetasFornecValFat = class(TfrmPaiEdit)
    pnlPeriodo: TPanel;
    Splitter1: TSplitter;
    qryValGer: TUniQuery;
    dspValGer: TUniDataSetProvider;
    cdsValGer: TUniClientDataSet;
    dtsValGer: TDataSource;
    Label2: TLabel;
    mskDtaAtual: TMaskEditFocus;
    Label3: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    qryCadFor: TUniQuery;
    dtsCadFor: TDataSource;
    cdsValGerTOT_TOTVAL: TAggregateField;
    pnlGruFor: TPanel;
    Panel2: TPanel;
    cxgFornecedores: TcxGrid;
    cxgFornecedoresDBTableView1: TcxGridDBTableView;
    cxgFornecedoresDBTableView1Column1: TcxGridDBColumn;
    cxgFornecedoresDBTableView1Column2: TcxGridDBColumn;
    cxgFornecedoresDBTableView1Column3: TcxGridDBColumn;
    cxgFornecedoresLevel1: TcxGridLevel;
    pnlFornecedor: TPanel;
    Label1: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    edtTotVal: TEditFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtValGer: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    btnCopMet: TBitBtnLocked;
    shpMultSel: TShape;
    btnImportarMetas: TBitBtnLocked;
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cdsValGerAfterScroll(DataSet: TDataSet);
    procedure btnSairClick(Sender: TObject);
    procedure cdsValGerBeforePost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cxgFornecedoresDBTableView1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure btnCopMetClick(Sender: TObject);
    procedure cdsValGerReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure edtCodForExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnImportarMetasClick(Sender: TObject);
  private
    { Private declarations }
    strMesAno: String;
    strCodVen: String;
    intNumMes: Integer;
    intNumAno: Integer;

    arrFornec: TConsultasArray;

    function fAbreConsulta: Boolean;
    function fValidaMesAno: Boolean;
    function fValidaVendedor: Boolean;
    function fValidaFornecedor(blnBuscaPorChave: Boolean): Boolean;
    function fValidaTotalFornecedor: Boolean;
    function fRetTotVal: Double;
    Function fGravaMetas(blnConfirma: Boolean = True): Boolean;

    Procedure pAbreCadFor;
    Procedure pAbreValGer;
    procedure pCarregaRegistroFornecedor;
    Procedure pLimpaDadosGer(blnSetFocus: Boolean = True);
    Procedure pAtualizaTotVal;
    Procedure pIniciaConsulta;
    Procedure pFechaConsulta;

    procedure pCopiaMetas;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses SysUtils, Variants, Forms, StrUtils, untPai, untFuncoesSimples,
     untCadMetasFornecValFatCopia, untConsultas, untFuncoesConsulta,
     untImportaPlanilhaMetaVendForn;

{$R *.dfm}

Procedure TfrmCadMetasFornecValFat.pAbreCadFor;
Begin
  With qryCadFor, SQL Do
  Begin
    Clear;
    Add('SELECT ');
    Add('  FOR_CODFOR, ');
    Add('  FOR_NOMFOR  ');
    Add('FROM          ');
    Add('  CADFOR      ');
    Open;
  End;
End;

Procedure TfrmCadMetasFornecValFat.pAbreValGer;
Begin
  With qryValGer, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  *   ');
    Add('FROM');
    Add('  VALGER');
    Add('WHERE');
    Add('  VAL_NUMMES = :NUMMES AND ');
    Add('  VAL_NUMANO = :NUMANO AND ');
    Add('  VAL_CODVEN = :CODVEN     ');

    Close;
    ParamByName('NUMMES').AsInteger := intNumMes;
    ParamByName('NUMANO').AsInteger := intNumAno;
    ParamByName('CODVEN').AsString  := strCodVen;

    cdsValGer.Close;
    cdsValGer.Open;

    TFloatField(cdsValGer.FieldByName('VAL_TOTVAL')).DisplayFormat := '#,##0.00';

    pLimpaDadosGer(False);
  End;
End;

Procedure TfrmCadMetasFornecValFat.pFechaConsulta;
Begin
  pnlGruFor.Enabled := False;

  If cdsValGer.Active Then
  Begin
    cdsValGer.CancelUpdates;
    cdsValGer.Close;
  End;

  pAtualizaTotVal;
End;

function TfrmCadMetasFornecValFat.fAbreConsulta: Boolean;
Begin
  Try
    pAbreValGer;

    blnMudarFoco := False;

    pnlPeriodo.Enabled := False;

    pnlGruFor.Enabled := True;

    pSetFocus(edtCodFor);

    Result := True;
  Except

    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAbreConsulta]');
    End;

  End;
End;

function TfrmCadMetasFornecValFat.fValidaMesAno: Boolean;
Begin

  Result := True;
  
  If fEmptyStr(fTiraCaracEspeciais(mskDtaAtual.Text)) Then
  Begin
    fMensagem('', 'Informar o mês / ano atual !', ['&O k']);
    Result := False;
  End
  Else
  Begin

    Try
      mskDtaAtual.Text := fTrataAnoDataMesAno(mskDtaAtual.Text);
      strToDate('01/' + mskDtaAtual.Text);

      If Not SameText(fTiraCaracEspeciais(mskDtaAtual.Text), strMesAno) Then
      Begin
        strMesAno := fTiraCaracEspeciais(mskDtaAtual.Text);

        pFechaConsulta;
      End;

      intNumMes := StrToIntDef(LeftStr(strMesAno, 2), 0);
      intNumAno := StrToIntDef(RightStr(strMesAno, 4), 0);

    Except
      fMensagem('', 'Mês / Ano inválido !', ['&O k']);
      Result := False;
    End;

  End;

End;

function TfrmCadMetasFornecValFat.fValidaVendedor: Boolean;
Begin

  Result := True;

  If fEmptyStr(edtCodVen.Text) Then
  Begin
    pMensagemOk('Informe o código do Vendedor!');
    Result := False;
  End Else
  Begin
    edtNomVen.Text := fRetNomVendRep(edtCodVen.Text);

    If fEmptyStr(edtNomVen.Text) Or (Pos(fRetTipoOperador(edtCodVen.Text),'I_E_D_') <= 0) Then
    Begin
      pMensagemOk('Vendedor não encontrado!');
      Result := False;
    End

    Else
    Begin
      strCodVen := edtCodVen.Text;

      fAbreConsulta;
    End;

  End

End;


function TfrmCadMetasFornecValFat.fValidaFornecedor(blnBuscaPorChave: Boolean): Boolean;
Begin
  Result := True;

  pDesmarcaLista(edtCodFor, arrFornec);

  If fEmptyStr(edtCodFor.Text) Then
  Begin
    If qryValGer.IsEmpty Then
    Begin
      pMensagemOk('Informe o código do Fornecedor!');
      Result := False;
    End
    Else
    Begin
      blnMudarFoco := False;
      pLimpaDadosGer(False);
    End;

  End
  Else
  Begin
    If (Length(arrFornec) = 0) Then
      edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

    If fEmptyStr(edtNomFor.Text) Then
    Begin
      pMensagemOk('Fornecedor não encontrado!');
      Result := False;
    End
    Else
    Begin
      blnMudarFoco := False;

      If blnBuscaPorChave Then
      Begin
        pSetFocus(edtTotVAl);

        If cdsValGer.Locate('VAL_CODFOR', edtCodFor.Text, []) Then
          pCarregaRegistroFornecedor;
      End;

    End;

  End

End;

function TfrmCadMetasFornecValFat.fValidaTotalFornecedor: Boolean;
  Var
    arrCodFor : TConsultasArray;
    intCnt : Integer;
Begin
  Result := True;

  If (fStrToFloat(edtTotVal.Text) <= 0) Then
  Begin
    fMensagem('', 'O Valor deve ser maior que zero!', ['&Ok']);
    Result := False;
  End

  Else If fValidaCampos(edtCodFor, False) Then
  Begin

    If (Length(arrFornec) = 0) Then
    Begin
      SetLength(arrCodFor, 1);
      arrCodFor[0].strCodigo := edtCodFor.Text;
      arrCodFor[0].strDescri := '';
    End
    Else
      arrCodFor := arrFornec;

    With cdsValGer Do
    Begin
      For intCnt := Low(arrCodFor) To High(arrCodFor) Do
      Begin
        If Locate('VAL_CODFOR', arrCodFor[intCnt].strCodigo, []) Then
        Begin
          Edit;
          FieldByName('VAL_TOTVAL').AsFloat := fStrToFloat(edtTotVal.Text);
          Post;
        End
        Else
        Begin

          Insert;
          FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('VALGER', VS_strCodEmp);
          FieldByName('VAL_CODEMP').AsString  := VS_strCodEmp;
          FieldByName('VAL_CODVEN').AsString  := strCodVen;
          FieldByName('VAL_CODFOR').AsString  := arrCodFor[intCnt].strCodigo;
          FieldByName('VAL_NUMANO').AsInteger := intNumAno;
          FieldByName('VAL_NUMMES').AsInteger := intNumMes;
          FieldByName('VAL_TOTVAL').AsFloat   := fStrToFloat(edtTotVal.Text);
          Post;

        End;
      End;
    End;

    If Result Then
      pLimpaDadosGer;

    pSetFocus(edtCodFor);
  End;
End;

Procedure TfrmCadMetasFornecValFat.pLimpaDadosGer(blnSetFocus: Boolean = True);
Begin
  edtCodFor.Clear;
  edtNomFor.Clear;

  edtTotVal.Text := FormatFloat('#,##0.00', 0);
End;

procedure TfrmCadMetasFornecValFat.pCarregaRegistroFornecedor;
Begin

  With cdsValGer Do
  Begin
    edtCodFor.Text := FieldByName('VAL_CODFOR').AsString;
    edtNomFor.Text := fRetNomFornecedor(FieldByName('VAL_CODFOR').AsString);
    edtTotVal.Text := FormatFloat('#,##0.00', FieldByName('VAL_TOTVAL').AsFloat);
  End;

End;

function TfrmCadMetasFornecValFat.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    blnMudarFoco := True;

    If (Sender = mskDtaAtual) Then
      Result := fValidaMesAno

    Else If Sender = edtCodVen Then
      Result := fValidaVendedor

    Else If Sender = edtCodFor Then
      Result := fValidaFornecedor(blnBuscaPorChave)

    Else If Sender = edtTotVal Then
      Result := fValidaTotalFornecedor
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadMetasFornecValFat.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrSel, True, False, False, False, True) Then
    fValidaCampos(edtCodVen, True);
end;

procedure TfrmCadMetasFornecValFat.FormShow(Sender: TObject);
begin
  inherited;
  pAbreCadFor;

  mskDtaAtual.Text := FormatDateTime('mm/yyyy', VS_Date);

  fValidaCampos(mskDtaAtual);
  pSetFocus(edtCodVen);
end;

procedure TfrmCadMetasFornecValFat.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, Nil, 'do fornecedor', edtCodFor.TamCampo);
end;

procedure TfrmCadMetasFornecValFat.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
    fValidaCampos(edtCodFor, True);
end;

Procedure TfrmCadMetasFornecValFat.pIniciaConsulta;
Begin
  pFechaConsulta;
  
  pnlPeriodo.Enabled := True;

  edtCodVen.Clear;
  edtNomVen.Clear;
  pSetFocus(edtCodVen);
End;

Function TfrmCadMetasFornecValFat.fGravaMetas(blnConfirma: Boolean = True): Boolean;
  Var
    intNroErr: Integer;
Begin
  Result := False;

  If blnConfirma Then
  Begin
    If fMensagem('','Confirma a gravação das metas?',['&Sim','&Não']) = 2 Then
      Exit;
  End;

  Try

    fStartTransaction;

    intNroErr := cdsValGer.ApplyUpdates(-1);

    If intNroErr = 0 Then
    Begin
      fCommit;
      Result := True;

      If blnConfirma Then
      Begin
        pMensagemOk('Metas gravadas com sucesso!');
        pIniciaConsulta;
      End;

    End
    Else
      fRollBack;

  Except
    On E : Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[btnConfirmarClick (Metas)]');
    End;
  End;

End;

procedure TfrmCadMetasFornecValFat.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If (Not Assigned(cdsValGer)) Or
     (Not cdsValGer.Active) Then
  Begin
    fMensagem('', 'Não há metas para confirmar!', ['&OK']);
    Exit;
  End;

  fGravaMetas;

end;

function TfrmCadMetasFornecValFat.fRetTotVal: Double;
Begin
  If (Not cdsValGer.Active) Or (TAggregateField(cdsValGer.FieldByName('TOT_TOTVAL')).Value = Null) Then
    Result := 0
  Else
    Result := TAggregateField(cdsValGer.FieldByName('TOT_TOTVAL')).Value;
End;

procedure TfrmCadMetasFornecValFat.pAtualizaTotVal;
Begin
  edtValGer.Text := FormatFloat('#,##0.00', fRetTotVal);
End;

procedure TfrmCadMetasFornecValFat.cdsValGerAfterScroll(DataSet: TDataSet);
begin
  inherited;

  pAtualizaTotVal;
end;

procedure TfrmCadMetasFornecValFat.btnSairClick(Sender: TObject);
begin
//  inherited;

  If Not cdsValGer.Active Then
    Close;

  pIniciaConsulta;

end;

procedure TfrmCadMetasFornecValFat.cdsValGerBeforePost(DataSet: TDataSet);
begin
  inherited;

  pAtualizaTotVal;
end;

procedure TfrmCadMetasFornecValFat.cdsValGerReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  Action := raAbort;

  raise Exception.Create(E.Message);
end;

procedure TfrmCadMetasFornecValFat.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaAtual);
end;

procedure TfrmCadMetasFornecValFat.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirmar.Click;
    VK_F5 : btnCopMet.Click;
    VK_F6 : btnImportarMetas.Click;
  End;

end;

procedure TfrmCadMetasFornecValFat.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;

end;

procedure TfrmCadMetasFornecValFat.cxgFornecedoresDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: Begin
                 pCarregaRegistroFornecedor;
                 pSetFocus(edtTotVal);
               End;
  End;

end;

procedure TfrmCadMetasFornecValFat.btnCopMetClick(Sender: TObject);
begin
  inherited;

  If (Not Assigned(cdsValGer)) Or
     (Not cdsValGer.Active) Then
  Begin
    fMensagem('', 'Não há metas para copiar!', ['&OK']);
    Exit;
  End;

  If fGravaMetas(False) Then
    pCopiaMetas;

end;

procedure TfrmCadMetasFornecValFat.btnImportarMetasClick(Sender: TObject);
var
  LForm: TfrmImportaPlanilhaMetaVendForn;
begin
  inherited;
  LForm := nil;
  pCriarFormularios(TfrmImportaPlanilhaMetaVendForn, LForm);
  try
    if Assigned(LForm) then
      LForm.ShowModal;
  finally
    if Assigned(LForm) then
      pFreeAndNil(LForm);
  end;
end;

procedure TfrmCadMetasFornecValFat.pCopiaMetas;
Begin
  pCriarFormularios(TfrmCadMetasFornecValFatCopia, frmCadMetasFornecValFatCopia);

  If Assigned(frmCadMetasFornecValFatCopia) Then
  Begin
    With frmCadMetasFornecValFatCopia Do
    Begin
      strVenOri := edtCodVen.Text;
      strDtaOri := mskDtaAtual.Text;
      ShowModal;
    End;
    FreeAndNil(frmCadMetasFornecValFatCopia);
  End;
End;

end.

