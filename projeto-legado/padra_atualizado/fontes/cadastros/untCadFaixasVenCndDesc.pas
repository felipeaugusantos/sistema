unit untCadFaixasVenCndDesc;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Mask, DBCtrls, DBEditFocus, UniDataSetProvider, UniClientDataSet, Uni,
  untFuncoesSimples, BitBtnLockedIncrem, cxLookAndFeels, untTypesSistema,
  cxLookAndFeelPainters, cxNavigator,
  Provider, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient;

type
  TfrmCadFaixasVenCndDesc = class(TfrmPaiCad)
    pnlDados: TPanel;
    Panel1: TPanel;
    pnlFaixas: TPanel;
    Label12: TLabel;
    edtDesIni: TEditFocus;
    Label1: TLabel;
    edtDesFin: TEditFocus;
    Label2: TLabel;
    edtPerCom: TEditFocus;
    cxgFavDesDBTableView1: TcxGridDBTableView;
    cxgFavDesLevel1: TcxGridLevel;
    cxgFavDes: TcxGrid;
    cxgFavDesDBTableView1Column1: TcxGridDBColumn;
    cxgFavDesDBTableView1Column2: TcxGridDBColumn;
    cxgFavDesDBTableView1Column3: TcxGridDBColumn;
    dtsFavDes: TDataSource;
    Label4: TLabel;
    dbeCodCnd: TDBEditFocus;
    cdsFavDes: TUniClientDataSet;
    dspFavDes: TUniDataSetProvider;
    dtsTabela: TDataSource;
    cxStyleRepository: TcxStyleRepository;
    cxsWhite: TcxStyle;
    cxsGreen: TcxStyle;
    edtDesCnd: TEditFocus;
    Label3: TLabel;
    dbeCodVen: TDBEditFocus;
    edtNomVen: TEditFocus;
    btnHerFai: TBitBtnLocked;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgFavDesDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtDesIniExit(Sender: TObject);
    procedure edtDesFinExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure edtPerComExit(Sender: TObject);
    procedure dbeCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure btnHerFaiClick(Sender: TObject);
  private
    { Private declarations }
    qryFavDes: TUniQuery;
    qryAux   : TUniQuery;

    intRecNo : Integer;

    arrCnd,
    arrVendedor : TConsultasArray;

    function fValidaFaixa(fltValor: Double): Boolean;

    procedure pCarregaFaixa;
    procedure pLimpaEdits;
    procedure pAbreFaixas(strCodigo: String);
    procedure pSalvaReferencia;
    Procedure pAdicionaFaixa(fltValIni, fltValFin, fltPerCom: Double);
    procedure pCarregaCadCnd;
    procedure pCarregaCadOpe;
  public
    { Public declarations }
  protected
    { Protected declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    procedure pInicializaIndices; override;    

  end;

implementation

{$R *.dfm}

Uses
  SysUtils, Math, Forms, untConsultas, untHerancaFaixaDescontoVenCnd;

procedure TfrmCadFaixasVenCndDesc.pInicializaIndices;
Begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('FXA_CODOPE');
  stlCamInd.Add('FXA_CODCND');

  stlDesInd.Add('Cód. Vendedor');
  stlDesInd.Add('Cód. Condição Pagamento');
end;

procedure TfrmCadFaixasVenCndDesc.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pnlFaixas.Enabled := True;
  btnHerFai.Enabled := False;  

  pHabilitaCodigo(dbeCodVen, dbeCodVen, True);
end;

procedure TfrmCadFaixasVenCndDesc.pLimpaEdits;
Begin
  If fEmptyStr(dbeCodCnd.Text) Then
    edtDesCnd.Clear
  Else
    pCarregaCadCnd;

  If fEmptyStr(dbeCodVen.Text) Then
    edtNomVen.Clear
  Else
    pCarregaCadOpe;
    
  edtDesIni.Clear;
  edtDesFin.Clear;
  edtPerCom.Clear;

  intRecNo := -1;
End;

procedure TfrmCadFaixasVenCndDesc.pSalvaReferencia;
Begin
  With cdsFavDes Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;

      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FAVDES', VS_strCodEmp);

      If fEmptyStr(FieldByName('FAV_SEQFXA').AsString) Then
        FieldByName('FAV_SEQFXA').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

      Post;

      Next;
    End;

    EnableControls;
  End;

End;

procedure TfrmCadFaixasVenCndDesc.btnCancelaClick(Sender: TObject);
begin
  inherited;

  cdsFavDes.CancelUpdates;

  pLimpaEdits;
  pAbreFaixas('');

  pnlFaixas.Enabled := False;
  btnHerFai.Enabled := True;  
end;

procedure TfrmCadFaixasVenCndDesc.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFaixasVenCndDesc.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pLimpaEdits;
  pAbreFaixas('');
end;

procedure TfrmCadFaixasVenCndDesc.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If cdsFavDes.IsEmpty Then
  Begin
    pMensagemOk('Informe as faixas de desconto!');
    pSetFocus(edtDesIni);
  End
  Else
  Begin
    inherited;

    pSalvaReferencia;

    Try
      If blnGravou Then
      Begin
        cdsFavDes.ApplyUpdates(0);
        fCommit;
      End
      Else
        fRollBack;
    except
      On E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadFaixasVenCndDesc.btnGravarClick]');
      End;
    end;

    pnlFaixas.Enabled := False;
    btnHerFai.Enabled := True;    
  End;

end;

procedure TfrmCadFaixasVenCndDesc.btnHerFaiClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmHerancaFaixaDescontoVenCnd, frmHerancaFaixaDescontoVenCnd);

  qryTabela.Close;
  cdsFavDes.Close;
  pLimpaEdits;

  pFreeAndNil(frmHerancaFaixaDescontoVenCnd);

  pSetFocus(btnIncluir);
end;

procedure TfrmCadFaixasVenCndDesc.btnIncluirClick(Sender: TObject);
begin
  inherited;

  edtDesCnd.Clear;

  pHabilitaCodigo(dbeCodVen, dbeCodVen, True);

  pAbreFaixas('');

  pnlFaixas.Enabled := True;
  btnHerFai.Enabled := False;  
end;

procedure TfrmCadFaixasVenCndDesc.pAbreFaixas(strCodigo: String);
Begin
  With qryFavDes, SQL Do
  Begin
    cdsFavDes.Close;
    Close;

    Clear;
    Add('SELECT * FROM FAVDES');
    Add('WHERE');

    If fEmptyStr(strCodigo) Then
      Add('FALSE')
    Else
      Add('FAV_SEQFXA = ' + QuotedStr(strCodigo));

    dspFavDes.DataSet := qryFavDes;
    cdsFavDes.SetProvider(dspFavDes);

    Open;

    pSetaClient(qryFavDes);
    pSetaClient(cdsFavDes);

    cdsFavDes.IndexFieldNames := 'FAV_DESINI';
    cdsFavDes.Open;

    TFloatField(cdsFavDes.FieldbyName('FAV_DESINI')).DisplayFormat := '#0.000';
    TFloatField(cdsFavDes.FieldbyName('FAV_DESFIN')).DisplayFormat := '#0.000';
    TFloatField(cdsFavDes.FieldbyName('FAV_PERCOM')).DisplayFormat := '#0.00';
  End;
End;

procedure TfrmCadFaixasVenCndDesc.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
//  inherited;

  chrKey := '?';
  If fPesqFaixasVenCndDesc(Self, Nil, Nil, qryTabela, chrKey, arrSel) Then
  Begin
    pLimpaEdits;
    pCarregaCadOpe;
    pCarregaCadCnd;
    pAbreFaixas(qryTabela.FieldByName('AUTOINCREM').AsString);

    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadFaixasVenCndDesc.pCarregaCadCnd;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT * FROM CADCND WHERE CND_CODIGO = :CODCND');
  qryAux.ParamByName('CODCND').AsString := dbeCodCnd.Text;
  qryAux.Open;
  edtDesCnd.Text := qryAux.FieldByName('CND_DESCRI').AsString;

  FreeAndNil(qryAux);
end;

procedure TfrmCadFaixasVenCndDesc.pCarregaCadOpe;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT * FROM CADOPE WHERE OPE_CODOPE = :CODOPE');
  qryAux.ParamByName('CODOPE').AsString := dbeCodVen.Text;
  qryAux.Open;
  edtNomVen.Text := qryAux.FieldByName('OPE_NOMOPE').AsString;

  FreeAndNil(qryAux);
end;

procedure TfrmCadFaixasVenCndDesc.pCarregaFaixa;
Begin
  If Not pnlFaixas.Enabled Then
    Exit;

  With cdsFavDes Do
  Begin
    If IsEmpty Then
      Exit;

    edtDesIni.Text := FormatFloat('#0.000', FieldByName('FAV_DESINI').AsFloat);
    edtDesFin.Text := FormatFloat('#0.000', FieldByName('FAV_DESFIN').AsFloat);
    edtPerCom.Text := FormatFloat('#0.00', FieldByName('FAV_PERCOM').AsFloat);

    intRecNo := RecNo;

    pSetFocus(edtDesIni);
  End;
End;

procedure TfrmCadFaixasVenCndDesc.cxgFavDesDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: pCarregaFaixa;
  End;
end;

procedure TfrmCadFaixasVenCndDesc.dbeCodCndKeyPress(Sender: TObject;
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

procedure TfrmCadFaixasVenCndDesc.dbeCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqOperador(Self, dbeCodVen, edtNomVen, nil, Key, arrVendedor) Then
    Begin
      If fValidaCampos(dbeCodVen, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadFaixasVenCndDesc.edtDesFinExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtDesFin.Text) Then
    edtDesFin.Text := FormatFloat('#,##0.000', fStrToFloat(edtDesFin.Text));
end;

procedure TfrmCadFaixasVenCndDesc.edtDesIniExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtDesIni.Text) Then
    edtDesIni.Text := FormatFloat('#,##0.000', fStrToFloat(edtDesIni.Text));
end;

procedure TfrmCadFaixasVenCndDesc.edtPerComExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtPerCom.Text) Then
    edtPerCom.Text := FormatFloat('#,##0.00', fStrToFloat(edtPerCom.Text));
end;

procedure TfrmCadFaixasVenCndDesc.FormCreate(Sender: TObject);
begin
  inherited;

  intRecNo := -1;
  
  strNomeTabela := 'FXAVEN';
  strNomeCampo  := 'AUTOINCREM';

  qryTabela := fCriarQuery('SELECT * FROM FXAVEN WHERE FALSE', Self);

  dtsTabela.DataSet   := qryTabela;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodVen;
  arrCamposChave[1] := dbeCodCnd;

  qryFavDes := fCriaQuery(Self);

  btnHerFai.Enabled := True;
end;

Procedure TfrmCadFaixasVenCndDesc.pAdicionaFaixa(fltValIni, fltValFin, fltPerCom: Double);
Begin
  with cdsFavDes Do
  Begin
    If (RecNo = intRecNo) Or Locate('FAV_DESINI', fltValIni, []) Then
      Edit
    Else
      Insert;

    FieldByName('FAV_DESINI').AsFloat := RoundTo(fltValIni, -3);
    FieldByName('FAV_DESFIN').AsFloat := RoundTo(fltValFin, -3);
    FieldByName('FAV_PERCOM').AsFloat := RoundTo(fltPerCom, -2);

    Post;

    pLimpaEdits;

    pSetFocus(edtDesIni);
  End;
End;

function TfrmCadFaixasVenCndDesc.fValidaFaixa(fltValor: Double): Boolean;
  Var
    intRecSav: Integer;
Begin
  Result := True;
  With cdsFavDes Do
  Begin
    intRecSav := RecNo;
    
    DisableControls;

    First;
    While Not Eof Do
    Begin
      If (intRecNo <> RecNo) And
         (RoundTo(fltValor, -3) >= RoundTo(FieldByName('FAV_DESINI').AsFloat, -3)) And
         (RoundTo(fltValor, -3) <= RoundTo(FieldByName('FAV_DESFIN').AsFloat, -3)) Then
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

function TfrmCadFaixasVenCndDesc.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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
    {* VENDEDOR              *)
    {*************************}
    Else If (Sender = dbeCodVen) Then
    Begin
      If fEmptyStr(dbeCodVen.Text) Then
      Begin
        fMensagem('', 'O Vendedor deve ser preechido!', ['&Ok']);
        Result := False;
      End;

      pCarregaCadOpe;

      If fEmptyStr(edtNomVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&Ok']);
        Result := False;
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

          With cdsFavDes Do
          Begin

            If Locate('FAV_DESINI', fStrToFloat(edtDesIni.Text), []) Then
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

