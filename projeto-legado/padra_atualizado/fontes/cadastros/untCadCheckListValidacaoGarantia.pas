unit untCadCheckListValidacaoGarantia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, Uni, Datasnap.DBClient, frxDBSet, untZClient, untChkMerTypes, UniClientDataSet;

Type
  TfrmCadChecklistValidacaoGarantia = class(TfrmPaiCad)
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    pnlGrupoCkl: TPanel;
    pnlTipoRes: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    rbDescLinha: TRadioButton;
    rbDesMLi: TRadioButton;
    rbNA: TRadioButton;
    Label2: TLabel;
    Panel5: TPanel;
    rbTroca: TRadioButton;
    rbGarantia: TRadioButton;
    Panel6: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    frxReport1: TfrxReport;
    cdsRel: TUniClientDataSet;
    pnlDados: TPanel;
    btnVisualizar: TBitBtnLocked;
    frxDbRel: TfrxDBDataset;
    cdsRelAUTOINCREM: TStringField;
    cdsRelCVG_DESCRI: TStringField;
    cdsRelCVG_CODIGO: TStringField;
    cdsRelCVG_TIPORE: TStringField;
    cdsRelCVG_TIPOVG: TStringField;
    cdsRelASSOCIADO: TStringField;
    cdsRelITE_CONTEU: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);

    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
  private
    FdtsCadCVGOldStateChange: TNotifyEvent;
    QryCadCVG: TUniquery;
    dtsCadCVG: TDataSource;
    dbeCVG_TIPOVG: TDBEditFocus;
    dbeCVG_TIPORE: TDBEditFocus;
    cdsQryCadCVGCVG_TIPORE: TField;
    cdsQryCadCVGCVG_TIPOVG: TField;
    procedure pCriarQryCadCVG;
    procedure pMontarConexaoDB;
    procedure pdtaCadCVGStateChangeCustom(Sender: TObject);
    procedure pSetTipoResultado(const Value: TTipoResultado);
    procedure pSetTipoCheckList(const Value: TTipoCheckList);overload;


    procedure pOnClickRadioButton(Sender: TObject);
    procedure pQryCadCVGAfterScroll(Sender: TDataSet);
    procedure pqryCadCVG_TIPOVGOnGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pqryCadCVG_TIPOREOnGetText(Sender: TField; var Text: string; DisplayText: Boolean);

    function fDescricaoCadastrada(const strDescricao, strCodEdi: String): Boolean;
    function fPermitirEditar(const strAutInc: String): Boolean;
    procedure pAplicarEventoClickRadioButtons;

  protected
    procedure pInicializaIndices; override;


    { Private declarations }

  public
    procedure pImprimir;overload;
    procedure pImprimir(oleData: OleVariant);overload;
    procedure pImprimir(const strIncIte: String; enuGrupo: TTipoCheckList; blnSomenteAssociado: Boolean = False);overload;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    class procedure pImprimirCheckListGarantia(const strIncIte: String; enuGrupo: TTipoCheckList;
               blnSomenteAssociado: Boolean = False);

    class function fGetSQLCheckListGarantiaItem(const blnItem, blnTipo: Boolean; blnSomenteAssociado: Boolean = False): String;
    { Public declarations }
  end;


var
  frmChecklistValidacaoGarantia: TfrmCadChecklistValidacaoGarantia;

implementation
uses
  untFuncoesSimples, untConsultas, untTypesSistema, StrUtils;

{$R *.dfm}

procedure TfrmCadChecklistValidacaoGarantia.btnAlterarClick(Sender: TObject);
begin
  if Not fPermitirEditar(qryCadCVG.FieldByName('AUTOINCREM').AsString) then
  begin
    pMensagemOk('Não é permitido alterar item associado a produto!');
    Exit;
  end;
  Inherited;
end;

procedure TfrmCadChecklistValidacaoGarantia.btnExcluirClick(Sender: TObject);
begin
  inherited;
 blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmChecklistValidacaoGarantia.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadChecklistValidacaoGarantia.btnGravarClick(Sender: TObject);
begin
  if Not fValidaPanel(pnlDados) Then
    Exit;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmChecklistValidacaoGarantia.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadChecklistValidacaoGarantia.btnIncluirClick(Sender: TObject);
  Var
    enuTipoResultado: TTipoResultado;
    enuTipoChecklist: TTipoCheckList;
begin
  inherited;
  enuTipoResultado.pSetAsString('');
  enuTipoChecklist.pSetAsString('');
  pSetTipoResultado(enuTipoResultado);
  pSetTipoCheckList(enuTipoChecklist);
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmCadChecklistValidacaoGarantia.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrItem: TConsultasArray;
    strCodigo, strDescri: String;
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE PREÇOS *}
  {*********************************RV*}
  chrKey := '/';
  fPesqCadCheckListValidacaoGarantia(Self, strCodigo, strDescri, qryTabela, chrKey, arrItem);
    pSetFocus(btnAlterar);

end;

procedure TfrmCadChecklistValidacaoGarantia.btnVisualizarClick(Sender: TObject);
  Var
    enuTipoChecklist: TTipoCheckList;
begin
  inherited;
  if QryCadCVG.IsEmpty then
    Exit;

  enuTipoChecklist.pSetAsString(QryCadCVG.FieldByName('CVG_TIPOVG').AsString);

  if fEmptyStr(enuTipoChecklist.fAsString) then
    Exit;

  pImprimirCheckListGarantia('', enuTipoChecklist, False);
end;

procedure TfrmCadChecklistValidacaoGarantia.FormCreate(Sender: TObject);
begin
  tbsGeral.TabVisible := False;
  inherited;
  strNomeTabela := 'CADCVG';
  strNomeCampo  := 'CVG_CODIGO';
  pMontarConexaoDB;
  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadChecklistValidacaoGarantia.FormDestroy(Sender: TObject);
begin
  if Assigned(stlCampos) then
    FreeAndNil(stlCampos);

  if Assigned(stlCamInd) then
    FreeAndNil(stlCamInd);

  if Assigned(stlDesInd) then
    FreeAndNil(stlDesInd);

  if Assigned(stlDesInd) then
    FreeAndNil(stlDesInd);

  if Assigned(dtsCadCVG) then
    FreeAndNil(dtsCadCVG);

  if Assigned(QryCadCVG) then
    FreeAndNil(QryCadCVG);

  inherited;
end;

procedure TfrmCadChecklistValidacaoGarantia.FormShow(Sender: TObject);
begin
  inherited;
  pgcDados.ActivePage := tbsGeral;
  pAplicarEventoClickRadioButtons;
  cdsQryCadCVGCVG_TIPORE.OnGetText := pqryCadCVG_TIPOREOnGetText;
  cdsQryCadCVGCVG_TIPOVG.OnGetText := pqryCadCVG_TIPOVGOnGetText;
end;

function TfrmCadChecklistValidacaoGarantia.fPermitirEditar(const strAutInc: String): Boolean;
  CONST
    SQL: String = ' SELECT COUNT(1) AS TOTAL FROM ITECVG WHERE ITE_INCCVG = :AUTINC ';
  Var
    Qry: TUniQuery;
begin
  Qry := Nil;
  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add(SQL);
    Qry.ParamByname('AUTINC').AsString := strAutInc;
    Qry.Open;

    if Qry.IsEmpty then
      Result := True
    else
      Result := Qry.FieldByName('TOTAL').AsInteger = 0;

  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

function TfrmCadChecklistValidacaoGarantia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      if fEmptyStr(dbeDescri.Text) Then
      begin
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      end
      else if fDescricaoCadastrada(dbeDescri.Text, qryTabela.FieldByName('CVG_CODIGO').AsString) then
      begin
        fMensagem('ATENÇÃO!', 'A descrição já cadastrada!', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = dbeCVG_TIPOVG) Then
    Begin
      if fEmptyStr(dbeCVG_TIPOVG.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O grupo de checklist é obrigatório!', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = dbeCVG_TIPORE) Then
    Begin
      if fEmptyStr(dbeCVG_TIPORE.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O grupo de resultado é obrigatório!', ['&Ok']);
        Result := False;
      end;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadChecklistValidacaoGarantia.fDescricaoCadastrada(
  const strDescricao, strCodEdi: String): Boolean;
  CONST
    SQL: String = 'SELECT * FROM CADCVG WHERE CVG_CODEMP = :CODEMP AND CVG_DESCRI = :DESCRI ';
  Var
    Qry: TUniQuery;
    strSQL: String;
    blnCodigo: boolean;
begin
  Qry := Nil;
  strSQL := SQL;
  blnCodigo := Not fEmptyStr(strCodEdi);

  if blnCodigo then
    strSQL := strSQL + ' AND CVG_CODIGO <> :CODIGO ';

  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add(strSQL);
    Qry.ParamByname('CODEMP').AsString := VS_strCodEmp;
    Qry.ParamByname('DESCRI').AsString := strDescricao;

    if blnCodigo then
      Qry.ParamByName('CODIGO').AsString := strCodEdi;

    Qry.Open;
    Result := Not Qry.IsEmpty;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

class function TfrmCadChecklistValidacaoGarantia.fGetSQLCheckListGarantiaItem(const blnItem, blnTipo: Boolean;
      blnSomenteAssociado: Boolean = False): String;
begin
  Result :=          ' SELECT  C.AUTOINCREM, C.CVG_CODIGO, C.CVG_DESCRI, C.CVG_TIPORE, C.CVG_TIPOVG, ';

  Result := Result + '         IF(IFNULL(I.AUTOINCREM,"") = "","0","1") AS ASSOCIADO, ';

  Result := Result + '         CASE C.CVG_TIPORE ';
  Result := Result + '          WHEN "N" THEN "" ';
  Result := Result + '          ELSE IFNULL(I.ITE_CONTEU,"") ';
  Result := Result + '         END "ITE_CONTEU", ';

  Result := Result + '         I.AUTOINCREM AS "ITE_AUTINC", I2.ITE_CODITE ';

  Result := Result + ' FROM CADCVG C ';

  if blnItem then
  begin
    Result := Result + ' %0:s JOIN ITECVG I ON I.ITE_INCCVG = C.AUTOINCREM AND I.AUTOINCREM = :INCITE ';
    Result := Result + ' %0:s JOIN ITEGER I2 ON I2.AUTOINCREM = I.AUTOINCREM ';
    Result := format(Result,[ifthen(blnSomenteAssociado,'INNER','LEFT')]);
  end
  else begin
    Result := Result + ' LEFT JOIN ITECVG I ON I.ITE_INCCVG = C.AUTOINCREM AND FALSE ';
    Result := Result + ' LEFT JOIN ITEGER I2 ON I2.AUTOINCREM = I.AUTOINCREM AND FALSE ';
  end;

  If blnTipo then
    Result := Result + ' WHERE C.CVG_TIPOVG = :TIPOVG ';

  Result := Result + ' ORDER BY CVG_TIPOVG, CVG_TIPORE, CVG_CODIGO ';
end;

procedure TfrmCadChecklistValidacaoGarantia.pAplicarEventoClickRadioButtons;
  Var
    intIdx: Integer;
begin
  for intIdx := 0 to Self.ComponentCount -1 do
  begin
    if Components[intIdx] is TRadioButton then
      TRadioButton(Components[intIdx]).OnClick := pOnClickRadioButton;
  end;
end;

procedure TfrmCadChecklistValidacaoGarantia.pCriarQryCadCVG;
begin
  qryCadCVG  := fCriarQuery('SELECT * FROM CADCVG', Self);

  qryCadCVG.FieldByName('CVG_CODIGO').DisplayLabel := 'Código';
  qryCadCVG.FieldbyName('CVG_DESCRI').DisplayLabel := 'Descrição';
  qryCadCVG.FieldbyName('CVG_TIPOVG').DisplayLabel := 'Tipo Checklist';
  qryCadCVG.FieldbyName('CVG_TIPORE').DisplayLabel := 'Tipo Resultado';

  qryCadCVG.FieldByName('CVG_CODEMP').Visible := False;
  qryCadCVG.FieldByName('AUTOINCREM').Visible := False;

  qryTabela := qryCadCVG;
  cdsQryCadCVGCVG_TIPORE := QryCadCVG.FieldByName('CVG_TIPORE');
  cdsQryCadCVGCVG_TIPOVG := QryCadCVG.FieldByName('CVG_TIPOVG');
end;

procedure TfrmCadChecklistValidacaoGarantia.pdtaCadCVGStateChangeCustom(
  Sender: TObject);
  Var
    blnHabilitar: Boolean;
    intIdx: Integer;
begin
  if Assigned(FdtsCadCVGOldStateChange) then
    FdtsCadCVGOldStateChange(Sender);

  blnHabilitar := dtsCadCVG.State in [dsInsert, dsEdit];

  for intIdx := 0 to Self.ComponentCount -1 do
  begin
    if Components[intIdx] is TRadioButton then
     TRadioButton(Components[intIdx]).Enabled := blnHabilitar;
  end;
end;

procedure TfrmCadChecklistValidacaoGarantia.pImprimir;
  Var
    blnPodeImprimir: Boolean;
begin
  blnPodeImprimir := cdsRel.Active and (Not cdsRel.IsEmpty);
  if Not blnPodeImprimir then
  begin
     pMensagemOk('Não foram encontrados dados!');
     Exit;
  end;
  frxReport1.PrepareReport;
  frxReport1.ShowPreparedReport;

end;

procedure TfrmCadChecklistValidacaoGarantia.pImprimir(oleData: OleVariant);
begin
  if cdsRel.Active then
    cdsRel.EmptyDataSet
  else
    cdsRel.CreateDataSet;

  cdsRel.Data := oleData;

  pImprimir;
end;

procedure TfrmCadChecklistValidacaoGarantia.pImprimir(const strIncIte: String; enuGrupo: TTipoCheckList;
  blnSomenteAssociado: Boolean = False);
  Var
    Qry: TZClient;
    strSql: String;
    blnItem, blnGrupo: Boolean;
begin

  blnItem := Not fEmptyStr(strIncIte);
  blnGrupo := Not fEmptyStr(enuGrupo.fAsString);

  strSql := fGetSQLCheckListGarantiaItem(blnItem, blnGrupo, blnSomenteAssociado);

  Qry := Nil;
  Try
    Qry := TZClient.Create(Self);
    Qry.qryQuery.SQL.Clear;
    Qry.qryQuery.SQL.Add(strSql);

    if blnItem then
      Qry.qryQuery.ParamByName('INCITE').AsString := strIncIte;

    if blnGrupo Then
      Qry.qryQuery.ParamByName('TIPOVG').AsString := enuGrupo.fAsString;

    Qry.fAbreClient(True,'TfrmCadChecklistValidacaoGarantia.pImprimirCheckListGarantia');

    if Qry.IsEmpty then
    begin
      pMensagemOk('Não foram encontrados dados para impressão!');
      Exit;
    end;

    pImprimir(Qry.Data)
  Finally
    if Assigned(Qry) Then
      FreeAndNil(Qry);
  End;

end;

class procedure TfrmCadChecklistValidacaoGarantia.pImprimirCheckListGarantia(const strIncIte: String;
  enuGrupo: TTipoCheckList; blnSomenteAssociado: Boolean = False);
  Var
    frmCad:TfrmCadChecklistValidacaoGarantia;
begin
  frmCad := Nil;
  Try
    frmCad := TfrmCadChecklistValidacaoGarantia.Create(Nil);
    frmCad.pImprimir(strIncIte, enuGrupo, blnSomenteAssociado);
    frmCad.Release;
  Finally
    if Assigned(frmCad) then
      FreeandNil(frmCad);
  end;
end;

procedure TfrmCadChecklistValidacaoGarantia.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CVG_CODIGO');
  stlCampos.Add('CVG_DESCRI');
  stlCampos.Add('CVG_TIPOVG');
  stlCampos.Add('CVG_TIPORE');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CVG_DESCRI');
  stlCamInd.Add('CVG_CODIGO');
  stlCamInd.Add('CVG_TIPOVG');
  stlCamInd.Add('CVG_TIPORE');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
  stlDesInd.Add('Tipo Checklist');
  stlDesInd.Add('Tipo Resultado');
  stlDesInd.Add('AUTOINCREM');
end;

procedure TfrmCadChecklistValidacaoGarantia.pMontarConexaoDB;
var
  intCont: Integer;
begin
  inherited;
  pCriarQryCadCVG;
  dtsCadCVG  := fCriaDataSource(qryCadCVG);
  FdtsCadCVGOldStateChange := dtsCadCVG.OnStateChange;
  QryCadCVG.AfterScroll := pQryCadCVGAfterScroll;
  dtsCadCVG.OnStateChange := pdtaCadCVGStateChangeCustom;
  dbeCVG_TIPOVG := TDBEditFocus.Create(Self);
  dbeCVG_TIPOVG.DataField := 'CVG_TIPOVG';
  dbeCVG_TIPOVG.Parent := pnlDados;
  dbeCVG_TIPOVG.Visible := False;
  dbeCVG_TIPOVG.Tag := 99;

  dbeCVG_TIPORE := TDBEditFocus.Create(Self);
  dbeCVG_TIPORE.DataField := 'CVG_TIPORE';

  dbeCVG_TIPORE.Parent := pnlDados;
  dbeCVG_TIPORE.Visible := False;
  dbeCVG_TIPORE.Tag := 99;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadCVG;
    End;
  End;

end;

procedure TfrmCadChecklistValidacaoGarantia.pOnClickRadioButton(Sender: TObject);
begin
  if (Sender = rbGarantia) then
    pSetTipoCheckList(TTipoCheckList.Garantia)
  else if (Sender = rbTroca) then
    pSetTipoCheckList(TTipoCheckList.Troca)
  else if (Sender = rbDescLinha) then
    pSetTipoResultado(TTipoResultado.LinhaUnica)
  else if (Sender = rbDesMLi) then
    pSetTipoResultado(TTipoResultado.MultiplasLinhas)
  else if (Sender = rbNA) then
    pSetTipoResultado(TTipoResultado.NA);
end;

procedure TfrmCadChecklistValidacaoGarantia.pQryCadCVGAfterScroll(
  Sender: TDataSet);
  Var
    enuTipoRes: TTipoResultado;
    enuTipoChk: TTipoCheckList;
begin
  if QryCadCVG.IsEmpty then
    Exit;

  enuTipoRes.pSetAsString(cdsQryCadCVGCVG_TIPORE.AsString);
  enuTipoChk.pSetAsString(cdsQryCadCVGCVG_TIPOVG.AsString);
  pSetTipoResultado(enuTipoRes);
  pSetTipoCheckList(enuTipoChk);
end;

procedure TfrmCadChecklistValidacaoGarantia.pqryCadCVG_TIPOVGOnGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
  Var
    enuTipoCheckList: TTipoCheckList;
begin
  enuTipoCheckList.pSetAsString(Sender.AsString);
  Text := enuTipoCheckList.fAsString;
  rbTroca.Checked := enuTipoCheckList = TTipoCheckList.Troca;
  rbGarantia.Checked := enuTipoCheckList = TTipoCheckList.Garantia;
end;

procedure TfrmCadChecklistValidacaoGarantia.pqryCadCVG_TIPOREOnGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
  Var
    enuTipoResultado: TTipoResultado;
begin
  enuTipoResultado.pSetAsString(Sender.AsString);
  Text := enuTipoResultado.fAsString;
  rbDescLinha.Checked := enuTipoResultado =  TTipoResultado.LinhaUnica;
  rbDesMLi.Checked := enuTipoResultado =  TTipoResultado.MultiplasLinhas;
  rbNA.Checked := enuTipoResultado =  TTipoResultado.NA;
end;

procedure TfrmCadChecklistValidacaoGarantia.pSetTipoCheckList(
  const Value: TTipoCheckList);
begin
  dbeCVG_TIPOVG.Text := Value.fAsString;
  rbTroca.Checked := Value = TTipoCheckList.Troca;
  rbGarantia.Checked := Value = TTipoCheckList.Garantia;
end;

procedure TfrmCadChecklistValidacaoGarantia.pSetTipoResultado(
  const Value: TTipoResultado);
begin
  rbDescLinha.Checked := Value =  TTipoResultado.LinhaUnica;
  rbDesMLi.Checked := Value =  TTipoResultado.MultiplasLinhas;
  rbNA.Checked := Value =  TTipoResultado.NA;
  dbeCVG_TIPORE.Text := Value.fAsString;
end;




end.
