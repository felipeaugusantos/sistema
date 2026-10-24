unit untCadMetasLitragem;

interface

uses
  Windows, Classes, Controls, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, UniClientDataSet,
  UniDataSetProvider, Uni, Mask, MaskEditFocus, EditFocus, cxDBLookupComboBox,
  untModulo, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, Provider, MemDS, DBAccess,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadMetasLitragem = class(TfrmPaiEdit)
    pnlPeriodo: TPanel;
    Splitter1: TSplitter;
    qryLitGer: TUniQuery;
    dspLitGer: TUniDataSetProvider;
    cdsLitGer: TUniClientDataSet;
    dtsLitGer: TDataSource;
    Label2: TLabel;
    mskDtaAtual: TMaskEditFocus;
    Label3: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    qryCadFor: TUniQuery;
    dtsCadFor: TDataSource;
    cdsLitGerTOT_TOTLIT: TAggregateField;
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
    edtTotLit: TEditFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtLitGer: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    btnCopMet: TBitBtnLocked;
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cdsLitGerAfterScroll(DataSet: TDataSet);
    procedure btnSairClick(Sender: TObject);
    procedure cdsLitGerBeforePost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cxgFornecedoresDBTableView1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure btnCopMetClick(Sender: TObject);
    procedure cdsLitGerReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    strMesAno: String;
    strCodVen: String;
    intNumMes: Integer;
    intNumAno: Integer;

    function fAbreConsulta: Boolean;
    function fValidaMesAno: Boolean;
    function fValidaVendedor: Boolean;
    function fValidaFornecedor(blnBuscaPorChave: Boolean): Boolean;
    function fValidaTotalFornecedor: Boolean;
    function fRetTotLit: Double;
    Function fGravaMetas(blnConfirma: Boolean = True): Boolean;

    Procedure pAbreCadFor;
    Procedure pAbreLitGer;
    procedure pCarregaRegistroFornecedor;
    Procedure pLimpaDadosGer(blnSetFocus: Boolean = True);
    Procedure pAtualizaTotLit;
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
     untCadMetasLitragemCopia, untConsultas, untTypesSistema;

{$R *.dfm}

Procedure TfrmCadMetasLitragem.pAbreCadFor;
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

Procedure TfrmCadMetasLitragem.pAbreLitGer;
Begin
  With qryLitGer, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  *   ');
    Add('FROM');
    Add('  LITGER');
    Add('WHERE');
    Add('  LIT_NUMMES = :NUMMES AND ');
    Add('  LIT_NUMANO = :NUMANO AND ');
    Add('  LIT_CODVEN = :CODVEN     ');

    Close;
    ParamByName('NUMMES').AsInteger := intNumMes;
    ParamByName('NUMANO').AsInteger := intNumAno;
    ParamByName('CODVEN').AsString  := strCodVen;

    cdsLitGer.Close;
    cdsLitGer.Open;

    (cdsLitGer.FieldByName('LIT_TOTLIT') As TFloatField).DisplayFormat := '#,##0.00';

    pLimpaDadosGer(False);
  End;
End;

Procedure TfrmCadMetasLitragem.pFechaConsulta;
Begin
  If cdsLitGer.Active Then
  Begin
    cdsLitGer.CancelUpdates;
    cdsLitGer.Close;
  End;

  pAtualizaTotLit;
End;

function TfrmCadMetasLitragem.fAbreConsulta: Boolean;
Begin
  Try
    pAbreLitGer;

    blnMudarFoco := False;

    pnlPeriodo.Enabled := False;

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

function TfrmCadMetasLitragem.fValidaMesAno: Boolean;
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

function TfrmCadMetasLitragem.fValidaVendedor: Boolean;
Begin

  Result := True;

  If fEmptyStr(edtCodVen.Text) Then
  Begin
    pMensagemOk('Informe o código do Vendedor!');
    Result := False;
  End Else
  Begin
    edtNomVen.Text := fRetNomVendRep(edtCodVen.Text);

    If fEmptyStr(edtNomVen.Text) Or (Pos(fRetTipoOperador(edtCodVen.Text),'I_E_D_G_S_') <= 0) Then
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


function TfrmCadMetasLitragem.fValidaFornecedor(blnBuscaPorChave: Boolean): Boolean;
Begin
  Result := True;

  If fEmptyStr(edtCodFor.Text) Then
  Begin

    If qryLitGer.IsEmpty Then
    Begin
      pMensagemOk('Informe o código do Fornecedor!');
      Result := False;
    End Else
    Begin
      blnMudarFoco := False;
      pLimpaDadosGer(False);
    End;

  End Else
  Begin
    edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

    If fEmptyStr(edtNomFor.Text) Then
    Begin
      pMensagemOk('Fornecedor não encontrado!');
      Result := False;
    End Else
    Begin
      blnMudarFoco := False;

      If blnBuscaPorChave Then
      Begin
        pSetFocus(edtTotLit);

        If cdsLitGer.Locate('LIT_CODFOR', edtCodFor.Text, []) Then
          pCarregaRegistroFornecedor;
      End;

    End;

  End

End;

function TfrmCadMetasLitragem.fValidaTotalFornecedor: Boolean;
Begin
  Result := True;

  If (fStrToFloat(edtTotLit.Text) <= 0) Then
  Begin
    fMensagem('', 'O Litro/Kilo deve ser maior que zero!', ['&Ok']);
    Result := False;
  End

  Else If fValidaCampos(edtCodFor, False) Then
  Begin

    With cdsLitGer Do
    If Locate('LIT_CODFOR', edtCodFor.Text, []) Then
    Begin
      Edit;
      FieldByName('LIT_TOTLIT').AsFloat := fStrToFloat(edtTotLit.Text);
      Post;
    End Else
    Begin

      Insert;
      FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('LITGER', VS_strCodEmp);
      FieldByName('LIT_CODEMP').AsString  := VS_strCodEmp;                                  
      FieldByName('LIT_CODVEN').AsString  := strCodVen;
      FieldByName('LIT_CODFOR').AsString  := edtCodFor.Text;
      FieldByName('LIT_NUMANO').AsInteger := intNumAno;
      FieldByName('LIT_NUMMES').AsInteger := intNumMes;
      FieldByName('LIT_TOTLIT').AsFloat   := fStrToFloat(edtTotLit.Text);
      Post;

    End;

    If Result Then
      pLimpaDadosGer;
      pSetFocus(edtCodFor);

  End;

End;

Procedure TfrmCadMetasLitragem.pLimpaDadosGer(blnSetFocus: Boolean = True);
Begin
  edtCodFor.Clear;
  edtNomFor.Clear;

  edtTotLit.Text := FormatFloat('#,##0.00', 0);
End;

procedure TfrmCadMetasLitragem.pCarregaRegistroFornecedor;
Begin

  With cdsLitGer Do
  Begin
    edtCodFor.Text := FieldByName('LIT_CODFOR').AsString;
    edtNomFor.Text := fRetNomFornecedor(FieldByName('LIT_CODFOR').AsString);
    edtTotLit.Text := FormatFloat('#,##0.00', FieldByName('LIT_TOTLIT').AsFloat);
  End;

End;

function TfrmCadMetasLitragem.fValidaCampos(Sender: TWinControl;
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

    Else If Sender = edtTotLit Then
      Result := fValidaTotalFornecedor
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadMetasLitragem.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrSel, True, False, True, False, True, False, False, True) then
  Begin
    fValidaCampos(edtCodVen, True);
  End;

end;

procedure TfrmCadMetasLitragem.FormShow(Sender: TObject);
begin
  inherited;

  pAbreCadFor;

  mskDtaAtual.Text := FormatDateTime('mm/yyyy', VS_Date);
  fValidaCampos(mskDtaAtual);
  pSetFocus(edtCodVen);

end;

procedure TfrmCadMetasLitragem.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
    fValidaCampos(edtCodFor, True);
end;

Procedure TfrmCadMetasLitragem.pIniciaConsulta;
Begin
  pFechaConsulta;
  
  pnlPeriodo.Enabled := True;

  edtCodVen.Clear;
  edtNomVen.Clear;
  pSetFocus(edtCodVen);

End;

Function TfrmCadMetasLitragem.fGravaMetas(blnConfirma: Boolean = True): Boolean;
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

    intNroErr := cdsLitGer.ApplyUpdates(-1);

    If intNroErr = 0 Then
    Begin
      fCommit;
      Result := True;

      If blnConfirma Then
      Begin
        pMensagemOk('Metas gravadas com sucesso!');
        pIniciaConsulta;
      End;

    End Else
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

procedure TfrmCadMetasLitragem.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  fGravaMetas;

end;

function TfrmCadMetasLitragem.fRetTotLit: Double;
Begin
  If (Not cdsLitGer.Active) Or (TAggregateField(cdsLitGer.FieldByName('TOT_TOTLIT')).Value = Null) Then
    Result := 0
  Else
    Result := TAggregateField(cdsLitGer.FieldByName('TOT_TOTLIT')).Value;
End;

procedure TfrmCadMetasLitragem.pAtualizaTotLit;
Begin
  edtLitGer.Text := FormatFloat('#,##0.00', fRetTotLit);
End;

procedure TfrmCadMetasLitragem.cdsLitGerAfterScroll(DataSet: TDataSet);
begin
  inherited;

  pAtualizaTotLit;
end;

procedure TfrmCadMetasLitragem.btnSairClick(Sender: TObject);
begin
//  inherited;

  If Not cdsLitGer.Active Then
    Close;

  pIniciaConsulta;

end;

procedure TfrmCadMetasLitragem.cdsLitGerBeforePost(DataSet: TDataSet);
begin
  inherited;

  pAtualizaTotLit;
end;

procedure TfrmCadMetasLitragem.cdsLitGerReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  Action := raAbort;

  raise Exception.Create(E.Message);
end;

procedure TfrmCadMetasLitragem.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaAtual);
end;

procedure TfrmCadMetasLitragem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirmar.Click;
    VK_F5 : btnCopMet.Click;    
  End;

end;

procedure TfrmCadMetasLitragem.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;

end;

procedure TfrmCadMetasLitragem.cxgFornecedoresDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: Begin
                 pCarregaRegistroFornecedor;
                 pSetFocus(edtTotLit);
               End;
  End;

end;

procedure TfrmCadMetasLitragem.btnCopMetClick(Sender: TObject);
begin
  inherited;

  If fGravaMetas(False) Then
    pCopiaMetas;

end;

procedure TfrmCadMetasLitragem.pCopiaMetas;
  Var
    frmCadMetasLitragemCopia: TfrmCadMetasLitragemCopia;
Begin
  pCriarFormularios(TfrmCadMetasLitragemCopia, frmCadMetasLitragemCopia);

  If Assigned(frmCadMetasLitragemCopia) Then
  Begin
    With frmCadMetasLitragemCopia Do
    Begin
      strVenOri := edtCodVen.Text;
      strDtaOri := mskDtaAtual.Text;
      ShowModal;
    End;
    FreeAndNil(frmCadMetasLitragemCopia);
  End;
End;

end.

