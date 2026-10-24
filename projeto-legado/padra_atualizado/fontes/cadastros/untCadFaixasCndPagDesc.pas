unit untCadFaixasCndPagDesc;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Mask, DBCtrls, DBEditFocus, UniDataSetProvider, UniClientDataSet,
  untFuncoesSimples, BitBtnLockedIncrem, cxLookAndFeels, untTypesSistema,
  cxLookAndFeelPainters, cxNavigator, Provider, Uni, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient;

type
  TfrmCadFaixasCndPagDesc = class(TfrmPaiCad)
    pnlDados: TPanel;
    Panel1: TPanel;
    pnlFaixas: TPanel;
    Label12: TLabel;
    edtDesIni: TEditFocus;
    Label1: TLabel;
    edtDesFin: TEditFocus;
    Label2: TLabel;
    edtPerCom: TEditFocus;
    cxgFaiDesDBTableView1: TcxGridDBTableView;
    cxgFaiDesLevel1: TcxGridLevel;
    cxgFaiDes: TcxGrid;
    cxgFaiDesDBTableView1Column1: TcxGridDBColumn;
    cxgFaiDesDBTableView1Column2: TcxGridDBColumn;
    cxgFaiDesDBTableView1Column3: TcxGridDBColumn;
    dtsFaiDes: TDataSource;
    Label4: TLabel;
    dbeCodCnd: TDBEditFocus;
    cdsFaiDes: TUniClientDataSet;
    dspFaiDes: TUniDataSetProvider;
    dtsTabela: TDataSource;
    cxStyleRepository: TcxStyleRepository;
    cxsWhite: TcxStyle;
    cxsGreen: TcxStyle;
    edtDesCnd: TEditFocus;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgFaiDesDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtDesIniExit(Sender: TObject);
    procedure edtDesFinExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure edtPerComExit(Sender: TObject);
  private
    { Private declarations }
    qryFaiDes: TUniQuery;
    qryConCnd: TUniQuery;

    intRecNo: Integer;

    arrCnd : TConsultasArray;

    function fValidaFaixa(fltValor: Double): Boolean;

    procedure pCarregaFaixa;
    procedure pLimpaEdits;
    procedure pAbreFaixas(strCodigo: String);
    procedure pSalvaReferencia;
    Procedure pAdicionaFaixa(fltValIni, fltValFin, fltPerCom: Double);
    procedure pCarregaCadCnd;
  public
    { Public declarations }
  protected
    { Protected declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

implementation

{$R *.dfm}

Uses
  SysUtils, Math, Forms, untConsultas;

procedure TfrmCadFaixasCndPagDesc.pInicializaIndices;
Begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('FXA_CODEMP');
  stlCamInd.Add('FXA_CODCND');

  stlDesInd.Add('Empresa');
  stlDesInd.Add('Código (Cond. Pagto.)');
end;

procedure TfrmCadFaixasCndPagDesc.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pnlFaixas.Enabled := True;

  pHabilitaCodigo(dbeCodCnd, dbeCodCnd, True);
end;

procedure TfrmCadFaixasCndPagDesc.pLimpaEdits;
Begin
  If fEmptyStr(dbeCodCnd.Text) Then
    edtDesCnd.Clear
  Else
    pCarregaCadCnd;
    
  edtDesIni.Clear;
  edtDesFin.Clear;
  edtPerCom.Clear;

  intRecNo := -1;
End;

procedure TfrmCadFaixasCndPagDesc.pSalvaReferencia;
Begin
  With cdsFaiDes Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;

      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FAIDES', VS_strCodEmp);

      If fEmptyStr(FieldByName('FAI_SEQFXA').AsString) Then
        FieldByName('FAI_SEQFXA').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

      Post;

      Next;
    End;

    EnableControls;
  End;

End;

procedure TfrmCadFaixasCndPagDesc.btnCancelaClick(Sender: TObject);
begin
  inherited;

  cdsFaiDes.CancelUpdates;

  pLimpaEdits;
  pAbreFaixas(dbeCodCnd.Text);

  pnlFaixas.Enabled := False;
end;

procedure TfrmCadFaixasCndPagDesc.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFaixasCndPagDesc.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pLimpaEdits;
  pAbreFaixas('');
end;

procedure TfrmCadFaixasCndPagDesc.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If cdsFaiDes.IsEmpty Then
  Begin
    pMensagemOk('Informe as faixas de desconto!');
    pSetFocus(edtDesIni);
  End
  Else
  Begin
    Try
      inherited;

      pSalvaReferencia;

      If blnGravou Then
      Begin
        cdsFaiDes.ApplyUpdates(0);
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

    pnlFaixas.Enabled := False;
  End;

end;

procedure TfrmCadFaixasCndPagDesc.btnIncluirClick(Sender: TObject);
begin
  inherited;

  edtDesCnd.Clear;

  pHabilitaCodigo(dbeCodCnd, dbeCodCnd, True);

  pAbreFaixas('');

  pnlFaixas.Enabled := True;
end;

procedure TfrmCadFaixasCndPagDesc.pAbreFaixas(strCodigo: String);
Begin
  With qryFaiDes, SQL Do
  Begin
    cdsFaiDes.Close;
    Close;

    Clear;
    Add('SELECT * FROM FAIDES');
    Add('WHERE');

    If fEmptyStr(strCodigo) Then
      Add('FALSE')
    Else
      Add('FAI_SEQFXA = ' + QuotedStr(strCodigo));

    dspFaiDes.DataSet := qryFaiDes;
    cdsFaiDes.SetProvider(dspFaiDes);

    Open;

    pSetaClient(qryFaiDes);
    pSetaClient(cdsFaiDes);

    cdsFaiDes.IndexFieldNames := 'FAI_DESINI';
    cdsFaiDes.Open;

    TFloatField(cdsFaiDes.FieldbyName('FAI_DESINI')).DisplayFormat := '#0.00';
    TFloatField(cdsFaiDes.FieldbyName('FAI_DESFIN')).DisplayFormat := '#0.00';
    TFloatField(cdsFaiDes.FieldbyName('FAI_PERCOM')).DisplayFormat := '#0.00';
  End;
End;

procedure TfrmCadFaixasCndPagDesc.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
//  inherited;

  chrKey := '?';
  If fPesqFaixasCndPagDesc(Self, Nil, Nil, qryTabela, chrKey, arrSel) Then
  Begin
    pLimpaEdits;
    pCarregaCadCnd;
    pAbreFaixas(qryTabela.FieldByName('AUTOINCREM').AsString);

    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadFaixasCndPagDesc.pCarregaCadCnd;
begin
  qryConCnd := fCriaQuery(Nil);
  qryConCnd.SQL.Clear;
  qryConCnd.SQL.Add('SELECT * FROM CADCND WHERE CND_CODIGO = :CODCND');
  qryConCnd.ParamByName('CODCND').AsString := dbeCodCnd.Text;
  qryConCnd.Open;
  edtDesCnd.Text := qryConCnd.FieldByName('CND_DESCRI').AsString;

  FreeAndNil(qryConCnd);
end;

procedure TfrmCadFaixasCndPagDesc.pCarregaFaixa;
Begin
  If Not pnlFaixas.Enabled Then
    Exit;

  With cdsFaiDes Do
  Begin
    If IsEmpty Then
      Exit;

    edtDesIni.Text := FormatFloat('#0.00', FieldByName('FAI_DESINI').AsFloat);
    edtDesFin.Text := FormatFloat('#0.00', FieldByName('FAI_DESFIN').AsFloat);
    edtPerCom.Text := FormatFloat('#0.00', FieldByName('FAI_PERCOM').AsFloat);

    intRecNo := RecNo;

    pSetFocus(edtDesIni);
  End;
End;

procedure TfrmCadFaixasCndPagDesc.cxgFaiDesDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: pCarregaFaixa;
  End;
end;

procedure TfrmCadFaixasCndPagDesc.dbeCodCndKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqCondicoesPgto(Self, dbeCodCnd, Nil, Nil, Key, arrCnd, True, False, IIF(fCfgSis('PFLCLI', varBoolean), conCndPerfil, conSimples)) Then
    Begin
      If fValidaCampos(dbeCodCnd, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadFaixasCndPagDesc.edtDesFinExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtDesFin.Text) Then
    edtDesFin.Text := FormatFloat('#,##0.00', fStrToFloat(edtDesFin.Text));
end;

procedure TfrmCadFaixasCndPagDesc.edtDesIniExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtDesIni.Text) Then
    edtDesIni.Text := FormatFloat('#,##0.00', fStrToFloat(edtDesIni.Text));
end;

procedure TfrmCadFaixasCndPagDesc.edtPerComExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtPerCom.Text) Then
    edtPerCom.Text := FormatFloat('#,##0.00', fStrToFloat(edtPerCom.Text));
end;

procedure TfrmCadFaixasCndPagDesc.FormCreate(Sender: TObject);
begin
  inherited;

  intRecNo := -1;
  
  strNomeTabela := 'FXADES';
  strNomeCampo  := 'AUTOINCREM';

  qryTabela := fCriarQuery('SELECT * FROM FXADES WHERE FALSE', Self);

  dtsTabela.DataSet   := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCnd;

  qryFaiDes := fCriaQuery(Self);

end;

Procedure TfrmCadFaixasCndPagDesc.pAdicionaFaixa(fltValIni, fltValFin, fltPerCom: Double);
Begin
  with cdsFaiDes Do
  Begin
    If (RecNo = intRecNo) Or Locate('FAI_DESINI', fltValIni, []) Then
      Edit
    Else
      Insert;

    FieldByName('FAI_DESINI').AsFloat := RoundTo(fltValIni, -2);
    FieldByName('FAI_DESFIN').AsFloat := RoundTo(fltValFin, -2);
    FieldByName('FAI_PERCOM').AsFloat := RoundTo(fltPerCom, -2);

    Post;

    pLimpaEdits;

    pSetFocus(edtDesIni);
  End;
End;

function TfrmCadFaixasCndPagDesc.fValidaFaixa(fltValor: Double): Boolean;
  Var
    intRecSav: Integer;
Begin
  Result := True;
  With cdsFaiDes Do
  Begin
    intRecSav := RecNo;
    
    DisableControls;

    First;
    While Not Eof Do
    Begin
      If (intRecNo <> RecNo) And
         (RoundTo(fltValor, -2) >= RoundTo(FieldByName('FAI_DESINI').AsFloat, -2)) And
         (RoundTo(fltValor, -2) <= RoundTo(FieldByName('FAI_DESFIN').AsFloat, -2)) Then
      Begin
        Result := False;
        Break;
      End;

      Next;
    End;

    RecNo := intRecSav;
    EnableControls;
  End;
End;

function TfrmCadFaixasCndPagDesc.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*************************}
    {* CONDIÇÃO DE PAGAMENTO *)
    {*************************}
    If (Sender = dbeCodCnd) Then
    Begin
      If fEmptyStr(dbeCodCnd.Text) Then
      Begin
        fMensagem('', 'Condição de pagamento deve ser preechida!', ['&Ok']);
        edtDesCnd.Text := '';
        Result := False;
      End
      Else
      Begin
        pCarregaCadCnd;

        If fCfgSis('USACND', varBoolean) Then
        Begin
          If fEmptyStr(edtDesCnd.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa condição não está cadastrada!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    {*************************}
    {* % DESCONTO INICIAL    *)
    {*************************}
    Else If (Sender = edtDesIni) Then
    Begin

      If fEmptyStr(edtDesIni.Text) Then
      Begin
        pLimpaEdits;

        If btnGravar.CanFocus Then
        Begin
          blnMudarFoco := False;
          pSetFocus(btnGravar);
        End;
      End

      Else If (fStrToFloat(edtDesIni.Text) >= 100)  Then
      Begin
        pMensagemOk('O desconto inicial deve ser menor que cem!');
        Result := False;
      End Else
      Begin

        If blnBuscaPorChave Then
        Begin

          With cdsFaiDes Do
          Begin

            If Locate('FAI_DESINI', fStrToFloat(edtDesIni.Text), []) Then
            Begin
              pCarregaFaixa;
            End

          End;

        End;

        If Not fValidaFaixa(fStrToFloat(edtDesIni.Text)) Then
        Begin
          pMensagemOk('O desconto inicial já está contido em outra faixa!');
          Result := False;
        End;

      End;

    End

    {*************************}
    {* % DESCONTO FINAL      *)
    {*************************}
    Else If (Sender = edtDesFin) Then
    Begin

      If Not fEmptyStr(edtDesIni.Text) Then
      Begin
        If (fStrToFloat(edtDesFin.Text) > 100) Then
        Begin
          pMensagemOk('O desconto final deve ser menor ou igual a cem!');
          Result := False;
        End

        Else If fStrToFloat(edtDesFin.Text) < fStrToFloat(edtDesIni.Text) Then
        Begin
          pMensagemOk('O desconto final deve ser maior ou igual ao valor inicial!');
          Result := False;
        End

        Else If Not fValidaFaixa(fStrToFloat(edtDesFin.Text)) Then
        Begin
          pMensagemOk('O desconto inicial já está contido em outra faixa!');
          Result := False;
        End;
      End

      Else edtDesFin.Clear;

    End

    {*************************}
    {* % COMISSÃO            *)
    {*************************}
    Else If (Sender = edtPerCom) Then
    Begin

      If Not fEmptyStr(edtDesIni.Text) Then
      Begin
        If fEmptyStr(edtPerCom.Text) Then
          edtPerCom.Text := '0';

        If (StrToIntDef(edtPerCom.Text, 0) < 0) Or
           (StrToIntDef(edtPerCom.Text, 0) > 100) Then
        Begin
          pMensagemOk('A comissão deve ser maior ou igual a zero e maior ou igual a cem!');
          Result := False;
        End;

        If (Result) And (Not fValidaCampos(edtDesIni, True)) Then
        Begin
          Result := False;
          Sender := edtDesIni;
        End;

        If (Result) And (Not fValidaCampos(edtDesFin, True)) Then
        Begin
          Result := False;
          Sender := edtDesFin;
        End;

        If Result Then
        Begin
          pAdicionaFaixa(fStrToFloat(edtDesIni.Text),
                         fStrToFloat(edtDesFin.Text),
                         fStrToFloat(edtPerCom.Text));
          blnMudarFoco := False;
        End;

      End

      Else edtPerCom.Clear;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.

