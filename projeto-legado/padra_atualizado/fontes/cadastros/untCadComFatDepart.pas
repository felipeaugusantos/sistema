unit untCadComFatDepart;

interface

uses
  Windows, Classes, Controls,
  untPaiCad, StdCtrls, EditFocus, DBCtrls, DBEditFocus, AppEvnts,
  Menus, ComCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, Uni,
  BitBtnLockedIncrem, Mask, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadComFatDepart = class(TfrmPaiCad)
    pnl1: TPanel;
    pnlTopo: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    dbeCodTab: TDBEditFocus;
    dbeDesTab: TDBEditFocus;
    pnlComDep: TPanel;
    lbl7: TLabel;
    edtPerCom: TEditFocus;
    grdComDep: TDBGridCitel;
    dtsComDep: TDataSource;
    dtsTabela: TDataSource;
    cdsComDep: TUniClientDataSet;
    cdsComDepAUTOIN: TStringField;
    cdsComDepSEQCOM: TStringField;
    cdsComDepPERCOM: TFloatField;
    lblCodDep: TLabel;
    edtDesDep: TEditFocus;
    Label1: TLabel;
    edtDesIni: TEditFocus;
    Label2: TLabel;
    edtDesFin: TEditFocus;
    cdsComDepDESINI: TFloatField;
    cdsComDepDESFIN: TFloatField;
    edtCodDep: TDBEditFocus;
    btnAdicionar: TBitBtnLocked;
    pnlComCnd: TPanel;
    btnAdicionarCnd: TBitBtnLocked;
    grdComCnd: TDBGridCitel;
    lblCndPag: TLabel;
    edtCodCnd: TEditFocus;
    edtDesCndPag: TEditFocus;
    cdsComCnd: TUniClientDataSet;
    cdsComCndAUTOIN: TStringField;
    cdsComCndSEQCOM: TStringField;
    dtsComCnd: TDataSource;
    cdsComCndCODCND: TStringField;
    cdsComCndDESCRI: TStringField;
    cdsComCndCNDPAG: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdComDepKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarCndClick(Sender: TObject);
    procedure grdComCndKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodCndExit(Sender: TObject);
    procedure cdsComCndCNDPAGGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    qryComFat: TUniQuery;
    procedure pCarregaGrid;
    procedure pLimparPanelComDep;
    procedure pDeletaComDep;
    procedure pHabilitaCampos(blnHabilita: Boolean);

    function fInserirComDep: Boolean;
    function fGravarComDep(strSeqCom: String): Boolean;
    function fFaixaCadastrada(fltDesIni, fltDesFin: Double): Boolean;
    function fCndCadastrada(strCodCnd: String): Boolean;
    function fGravarComCnd(strSeqCom: String): Boolean;
    function fInserirComCnd: Boolean;
    procedure pCarregaComCnd;
    procedure pCarregaComDep;
    procedure pDeletaComCnd;
    procedure pLimparPanelComCnd;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

uses SysUtils, Forms, untConstantes, untFuncoesSimples, untConsultas, untTypesSistema, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmCadComFatDepart.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If (Not fVerificaCampos) Or
     (Not fValidaCampos(edtDesFin, True)) Then
    Exit;
  If fInserirComDep Then
    pLimparPanelComDep;
end;

procedure TfrmCadComFatDepart.btnAdicionarCndClick(Sender: TObject);
begin
  inherited;
  If (Not fVerificaCampos) Or
     (Not fValidaCampos(edtCodCnd, True)) Then
    Exit;

  If fInserirComCnd Then
    pLimparPanelComCnd;
end;

procedure TfrmCadComFatDepart.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCampos(True);
  pHabilitaCodigo(dbeCodTab, dbeCodTab, True);
end;

procedure TfrmCadComFatDepart.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If qryTabela.Active Then
    pCarregaGrid;

  pHabilitaCampos(edtCodDep.Enabled);
end;

procedure TfrmCadComFatDepart.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadComFatDepart.btnExcluirClick]');
    End;
  End;

  If blnExcluiu then
  begin
    cdsComDep.EmptyDataSet;
    cdsComCnd.EmptyDataSet;
    fCommit
  end
  Else
    fRollBack;
end;

procedure TfrmCadComFatDepart.btnGravarClick(Sender: TObject);
  Var
    strAutoIn: String;
begin

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If fEmptyStr(edtCodDep.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O departamento deve ser preenchido!', ['&Ok']);
    pSetFocus(edtCodDep);
    Exit;
  End;

  If Not fValidaCampos(edtCodDep, True) Then
    Exit;

  qryTabela.FieldByName('COM_CODDEP').AsString := edtCodDep.Text;

  Try
    inherited;

    If blnGravou Then
    Begin
      strAutoIn := qryTabela.FieldByName('AUTOINCREM').AsString;
      fGravarComDep(strAutoIn);
      fGravarComCnd(strAutoIn);
      pHabilitaCampos(False);
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
end;

procedure TfrmCadComFatDepart.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCampos(True);
  pHabilitaCodigo(dbeCodTab, dbeCodTab, True);
  cdsComDep.EmptyDataSet;
  cdsComCnd.EmptyDataSet;
end;

procedure TfrmCadComFatDepart.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  chrKey := '/';
  If fPesqComissaoFatDepart(conSimples,
                            Self,
                            nil,
                            nil,
                            qryTabela,
                            chrKey,
                            arrSel) Then
  Begin
    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
      pSetFocus(btnAlterar);

    fValidaCampos(edtCodDep, True);
  End;
  If qryTabela.Active Then
    pCarregaGrid;
end;

procedure TfrmCadComFatDepart.cdsComCndCNDPAGGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := fFormataCondPag(Sender.AsString);
end;

procedure TfrmCadComFatDepart.edtCodCndExit(Sender: TObject);
var
  arrCnd: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodCnd, edtDesCndPag, arrCnd, fRetDesConPag, Nil, 'da Condição de Pagamento');
end;

procedure TfrmCadComFatDepart.edtCodCndKeyPress(Sender: TObject; var Key: Char);
var
  arrCnd: TConsultasArray;
begin
  inherited;
  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCndPag, Nil, Key, arrCnd) Then
  Begin
    If fValidaCampos(edtCodCnd, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadComFatDepart.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrDep: TConsultasArray;
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDep) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadComFatDepart.FormCreate(Sender: TObject);
begin
  inherited;
  qryComFat           := fCriaQuery(Self);
  strNomeTabela       := 'COMDPG';
  strNomeCampo        := 'COM_CODTAB';
  qryTabela           := qryComFat;
  dtsTabela.DataSet   := qryTabela;
  cdsComDep.CreateDataSet;
  cdsComCnd.CreateDataSet;
  SetLength(arrCamposChave, 1);
  arrCamposChave[0]   := dbeCodTab;

  pnlComCnd.Visible := fCfgSis('CNDFAI', varBoolean);
  if not pnlComCnd.Visible then
    Self.Height := Self.Height - pnlComCnd.Height;
end;

procedure TfrmCadComFatDepart.FormShow(Sender: TObject);
begin
  inherited;
  pHabilitaCampos(False);
end;

function TfrmCadComFatDepart.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Try

    If Sender = dbeCodTab Then
    Begin
      If fEmptyStr(dbeCodTab.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If Sender = dbeDesTab Then
    Begin
      If fEmptyStr(dbeDesTab.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtDesIni) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtDesIni.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de desconto inicial deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(edtDesIni.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de desconto inicial não pode ser menor que zero!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtDesFin) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtDesFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de desconto final deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(edtDesFin.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de desconto final não pode ser menor que zero!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(edtDesIni.Text) > fStrToFloat(edtDesFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de desconto final não pode ser menor que o percentual de desconto inicial!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodDep) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtCodDep.Text) Then
      Begin
        edtDesDep.Clear;
        pSetFocus(btnGravar);
        blnMudarFoco := False;
      End
      Else
      Begin
        edtDesDep.Text := fCampoTabela('DEP_DESCRI', 'CADDEP', ['DEP_CODIGO'], [edtCodDep.Text]);
        If fEmptyStr(edtDesDep.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Esse departamento não está cadastrado!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtPerCom) And blnBuscaPorChave And (Not fEmptyStr(edtCodDep.Text)) Then
    Begin
      If fEmptyStr(edtPerCom.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O % de comissão deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodCnd) and blnBuscaPorChave and (pnlComCnd.Visible) Then
    Begin
      If Not fEmptyStr(edtCodCnd.Text) Then
      Begin
        If fEmptyStr(fRetDesConPag(edtCodCnd.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Condição não cadastrada!', ['&Ok']);
          Result := False;
        End
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'A Condição de Pagamento deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    end;
  Except
    On E: ExceptionAutCom Do
    Begin
			pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadComFatDepart.grdComCndKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
    pDeletaComCnd;
end;

procedure TfrmCadComFatDepart.grdComDepKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_DELETE) Then
    pDeletaComDep;

end;

procedure TfrmCadComFatDepart.pCarregaGrid;
begin
  pCarregaComDep;
  pCarregaComCnd;
end;

procedure TfrmCadComFatDepart.pCarregaComDep;
Var
  strSQL   : String;
  qryComDep: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT          ';
  strSQL := strSQL + '  C.AUTOINCREM, ';
  strSQL := strSQL + '  C.COM_SEQCOM, ';
  strSQL := strSQL + '  C.COM_DESINI, ';
  strSQL := strSQL + '  C.COM_DESFIN, ';
  strSQL := strSQL + '  C.COM_PERCOM  ';
  strSQL := strSQL + 'FROM            ';
  strSQL := strSQL + '  COMDPD C      ';
  strSQL := strSQL + 'WHERE           ';
  strSQL := strSQL + '  C.COM_SEQCOM = :AUTOIN ';

  qryComDep := fCriaQuery(Self);
  Try
    With qryComDep Do
    Begin
      Close;
      SQL.Text := strSQL;
      ParamByName('AUTOIN').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      Open;
      cdsComDep.EmptyDataSet;
      While Not Eof Do
      Begin
        cdsComDep.Append;
        cdsComDepAUTOIN.AsString := FieldByName('AUTOINCREM').AsString;
        cdsComDepSEQCOM.AsString := FieldByName('COM_SEQCOM').AsString;
        cdsComDepDESINI.AsFloat  := FieldByName('COM_DESINI').AsFloat;
        cdsComDepDESFIN.AsFloat  := FieldByName('COM_DESFIN').AsFloat;
        cdsComDepPERCOM.AsFloat  := FieldByName('COM_PERCOM').AsFloat;
        cdsComDep.Post;
        Next;
      End;

      cdsComDep.IndexFieldNames := 'DESINI;DESFIN';
    End;
  Finally
    FreeAndNil(qryComDep);
  End;
end;

procedure TfrmCadComFatDepart.pCarregaComCnd;
Var
  strSQL   : String;
  qryComCnd: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT          ';
  strSQL := strSQL + '  C.AUTOINCREM, ';
  strSQL := strSQL + '  C.COM_SEQCOM, ';
  strSQL := strSQL + '  C.COM_CODCND, ';
  strSQL := strSQL + '  CND_DESCRI, ';
  strSQL := strSQL + '  CND_CNDPAG  ';
  strSQL := strSQL + 'FROM            ';
  strSQL := strSQL + '  COMDPC C      ';
  strSQL := strSQL + 'LEFT JOIN CADCND ON CND_CODIGO = COM_CODCND ';
  strSQL := strSQL + 'WHERE           ';
  strSQL := strSQL + '  C.COM_SEQCOM = :AUTOIN ';

  qryComCnd := fCriaQuery(Self);
  Try

    With qryComCnd Do
    Begin
      Close;
      SQL.Text := strSQL;
      ParamByName('AUTOIN').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      Open;
      cdsComCnd.EmptyDataSet;
      While Not Eof Do
      Begin
        cdsComCnd.Append;
        cdsComCndAUTOIN.AsString := FieldByName('AUTOINCREM').AsString;
        cdsComCndSEQCOM.AsString := FieldByName('COM_SEQCOM').AsString;
        cdsComCndCODCND.AsString := FieldByName('COM_CODCND').AsString;
        cdsComCndDESCRI.AsString := FieldByName('CND_DESCRI').AsString;
        cdsComCndCNDPAG.AsString := FieldByName('CND_CNDPAG').AsString;

        cdsComCnd.Post;
        Next;
      End;
    End;
  Finally
    FreeAndNil(qryComCnd);
  End;
end;

procedure TfrmCadComFatDepart.pDeletaComDep;
begin
  If (cdsComDep.IsEmpty) Then
    Exit;

  If (fMensagem('ATENÇÃO!', 'Deseja realmente excluir essa faixa?', ['&S i m', '&N ã o'], 2) = 1) Then
    cdsComDep.Delete;
end;

procedure TfrmCadComFatDepart.pDeletaComCnd;
begin
  If (cdsComCnd.IsEmpty) Then
    Exit;

  If (fMensagem('ATENÇÃO!', 'Deseja realmente excluir essa condição de pagamento?', ['&S i m', '&N ã o'], 2) = 1) Then
    cdsComCnd.Delete;
end;

procedure TfrmCadComFatDepart.pHabilitaCampos(blnHabilita: Boolean);
begin
  pnlComDep.Enabled := blnHabilita;
  grdComDep.Enabled := blnHabilita;

  pnlComCnd.Enabled := blnHabilita;
  grdComCnd.Enabled := blnHabilita;
end;

procedure TfrmCadComFatDepart.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COM_CODTAB');
  stlCampos.Add('COM_DESCRI');
  stlCampos.Add('COM_FATINI');
  stlCampos.Add('COM_FATFIN');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COM_CODTAB+COM_FATINI+COM_FATFIN');
  stlCamInd.Add('COM_DESCRI');
  stlCamInd.Add('COM_CODTAB');

  stlDesInd.Add('Código/Faturamento Inicial/Faturamento Final');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

function TfrmCadComFatDepart.fCndCadastrada(strCodCnd: String): Boolean;
Var
  qryTmp : TUniQuery;
  cdsFaiTmp: TUniClientDataSet;
begin
  Result := False;

  cdsFaiTmp := TUniClientDataSet.Create(nil);
  Try
    cdsFaiTmp.Data := cdsComDep.Data;
    cdsFaiTmp.Open;

    qryTmp := fCriaQuery(Nil);
    Try
      qryTmp.SQL.Add('SELECT COM_CODTAB, COM_DESCRI FROM COMDPG ');
      qryTmp.SQL.Add('  INNER JOIN COMDPD ON COMDPD.COM_SEQCOM = COMDPG.AUTOINCREM ');
      qryTmp.SQL.Add('  INNER JOIN COMDPC ON COMDPC.COM_SEQCOM = COMDPG.AUTOINCREM ');
      qryTmp.SQL.Add('  WHERE ((:DESINI BETWEEN COM_DESINI AND COM_DESFIN) OR');
      qryTmp.SQL.Add('         (:DESFIN BETWEEN COM_DESINI AND COM_DESFIN))');
      qryTmp.SQL.Add('    AND COM_CODDEP = :CODDEP ');
      qryTmp.SQL.Add('    AND COM_CODCND = :CODCND ');

      cdsFaiTmp.First;
      while not cdsFaiTmp.Eof do
      begin
        qryTmp.Close;
        qryTmp.ParamByName('CODDEP').AsString := edtCodDep.Text;
        qryTmp.ParamByName('CODCND').AsString := strCodCnd;
        qryTmp.ParamByName('DESINI').AsFloat  := cdsFaiTmp.FieldByName('DESINI').AsFloat;
        qryTmp.ParamByName('DESFIN').AsFloat  := cdsFaiTmp.FieldByName('DESFIN').AsFloat;
        qryTmp.Open;

        Result := not qryTmp.IsEmpty;

        if Result then
        begin
          fMensagem('ATENÇÃO!', 'Condição de pagamento já cadastrada para a Faixa "' +
            qryTmp.FieldByName('COM_CODTAB').AsString + ' - ' +
            qryTmp.FieldByName('COM_DESCRI').AsString + '" !', ['&Ok']);
          Break;
        end;

        cdsFaiTmp.Next;
      end;
    Finally
      FreeAndNil(qryTmp);
    End;

    if Result then
      Exit;

    cdsFaiTmp.Data := cdsComCnd.Data;
    cdsFaiTmp.First;
    While Not cdsFaiTmp.Eof Do
    Begin
      If (cdsFaiTmp.FieldByName('CODCND').AsString = strCodCnd) Then
      Begin
        Result := True;
        fMensagem('ATENÇÃO!', 'Condição de pagamento já cadastrada para esta Faixa!', ['&Ok']);
        Break;
      End;

      cdsFaiTmp.Next;
    End;
  Finally
    FreeAndNil(cdsFaiTmp);
  End;


end;

function TfrmCadComFatDepart.fFaixaCadastrada(fltDesIni,
  fltDesFin: Double): Boolean;
Var
  cdsFaiTmp: TUniClientDataSet;
begin

  Result := False;

  Try

    cdsFaiTmp := TUniClientDataSet.Create(Self);
    cdsFaiTmp.Data := cdsComDep.Data;
    cdsFaiTmp.Open;

    With cdsFaiTmp Do
    Begin
      First;

      While Not Eof Do
      Begin
        If (FieldByName('DESINI').AsFloat = fltDesIni) And
           (FieldByName('DESFIN').AsFloat = fltDesFin) Then
        Begin
          Result := True;
          Break;
        End;

        Next;
      End;
    End;

  Finally
    FreeAndNil(cdsFaiTmp);
  End;

end;

function TfrmCadComFatDepart.fGravarComDep(strSeqCom: String): Boolean;
  Var
    strSQL   : String;
    qryComDep: TUniQuery;
begin
  Result := True;
  Try
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  COMDPD    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  COM_SEQCOM = :AUTOIN ';
    qryComDep := fCriaQuery(Self);

    With qryComDep Do
    Begin
      Close;
      SQL.Text := strSQL;
      ParamByName('AUTOIN').AsString := strSeqCom;
      ExecSQL;
    End;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO   ';
    strSQL := strSQL + '  COMDPD     (';
    strSQL := strSQL + '  AUTOINCREM, ';
    strSQL := strSQL + '  COM_SEQCOM, ';
    strSQL := strSQL + '  COM_DESINI, ';
    strSQL := strSQL + '  COM_DESFIN, ';
    strSQL := strSQL + '  COM_PERCOM) ';
    strSQL := strSQL + 'VALUES       (';
    strSQL := strSQL + '  :AUTOIN,    ';
    strSQL := strSQL + '  :SEQCOM,    ';
    strSQL := strSQL + '  :DESINI,    ';
    strSQL := strSQL + '  :DESFIN,    ';
    strSQL := strSQL + '  :PERCOM)    ';

    With qryComDep Do
    Begin
      cdsComDep.First;
      While Not cdsComDep.Eof Do
      Begin
        Close;
        SQL.Text := strSQL;
        ParamByName('AUTOIN').AsString := fRetAutoIncrem('COMDPD',VS_strCodEmp);
        ParamByName('SEQCOM').AsString := strSeqCom;
        ParamByName('DESINI').AsFloat  := cdsComDepDESINI.AsFloat;
        ParamByName('DESFIN').AsFloat  := cdsComDepDESFIN.AsFloat;
        ParamByName('PERCOM').AsFloat  := cdsComDepPERCOM.AsFloat;
        ExecSQL;
        cdsComDep.Next;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
end;

function TfrmCadComFatDepart.fGravarComCnd(strSeqCom: String): Boolean;
Var
  strSQL   : String;
  qryComCnd: TUniQuery;
begin
  Result := True;
  Try
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  COMDPC    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  COM_SEQCOM = :AUTOIN ';

    qryComCnd := fCriaQuery(Self);

    With qryComCnd Do
    Begin
      Close;
      SQL.Text := strSQL;
      ParamByName('AUTOIN').AsString := strSeqCom;
      ExecSQL;
    End;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO   ';
    strSQL := strSQL + '  COMDPC     (';
    strSQL := strSQL + '  AUTOINCREM, ';
    strSQL := strSQL + '  COM_SEQCOM, ';
    strSQL := strSQL + '  COM_CODCND) ';
    strSQL := strSQL + 'VALUES       (';
    strSQL := strSQL + '  :AUTOIN,    ';
    strSQL := strSQL + '  :SEQCOM,    ';
    strSQL := strSQL + '  :CODCND)    ';

    With qryComCnd Do
    Begin
      cdsComCnd.First;
      While Not cdsComCnd.Eof Do
      Begin
        Close;
        SQL.Text := strSQL;
        ParamByName('AUTOIN').AsString := fRetAutoIncrem('COMDPC',VS_strCodEmp);
        ParamByName('SEQCOM').AsString := strSeqCom;
        ParamByName('CODCND').AsString := cdsComCndCODCND.AsString;
        ExecSQL;
        cdsComCnd.Next;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
end;

function TfrmCadComFatDepart.fInserirComDep: Boolean;
begin
  If fEmptyStr(edtCodDep.Text) Then
  Begin
    Result := True;
    Exit;
  End;
  Result := True;
  With qryTabela Do
  Begin
    If (fFaixaCadastrada(fStrToFloat(edtDesIni.Text), fStrToFloat(edtDesFin.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Departamento já cadastrado para esta Faixa!', ['&Ok']);
      pLimparPanelComDep;
      Result := False;
    End
    Else
    Begin
      cdsComDep.Append;
      cdsComDepSEQCOM.AsString := FieldByName('AUTOINCREM').AsString;
      cdsComDepDESINI.AsFloat  := fStrToFloat(edtDesIni.Text);
      cdsComDepDESFIN.AsFloat  := fStrToFloat(edtDesFin.Text);
      cdsComDepPERCOM.AsFloat  := fStrToFloat(edtPerCom.Text);
      cdsComDep.Post;
    End;
  End;
end;


function TfrmCadComFatDepart.fInserirComCnd: Boolean;
begin
  If fEmptyStr(edtCodCnd.Text) Then
  Begin
    Result := True;
    Exit;
  End;

  Result := True;
  With qryTabela Do
  Begin
    If (fCndCadastrada(edtCodCnd.Text)) Then
    Begin
      pLimparPanelComCnd;
      Result := False;
    End
    Else
    Begin
      cdsComCnd.Append;
      cdsComCndSEQCOM.AsString := FieldByName('AUTOINCREM').AsString;
      cdsComCndCODCND.AsString := edtCodCnd.Text;
      cdsComCndDESCRI.AsString := edtDesCndPag.Text;
      cdsComCndCNDPAG.AsString := fRetConPag(edtCodCnd.Text);
      cdsComCnd.Post;
    End;
  End;
end;

procedure TfrmCadComFatDepart.pLimparPanelComDep;
begin
  edtDesIni.Text := '0,00';
  edtDesFin.Text := '0,00';
  edtPerCom.Text := '0,0000';

  pSetFocus(edtDesIni);
    
end;


procedure TfrmCadComFatDepart.pLimparPanelComCnd;
begin
  edtCodCnd.Clear;
  edtDesCndPag.Clear;

  pSetFocus(edtCodCnd);
end;



end.

