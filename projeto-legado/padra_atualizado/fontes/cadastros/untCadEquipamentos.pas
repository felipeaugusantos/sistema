unit untCadEquipamentos;

interface

uses
  Windows, Classes, Controls, untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, EditFocus, QColorLabel, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, UniClientDataSet, SysUtils, Variants;

type
  TfrmCadEquipamentos = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    Label6: TLabel;
    dbeCodMar: TDBEditFocus;
    edtDesMar: TEditFocus;
    dbeCodIte: TDBEditFocus;
    edtDesIte: TEditFocus;
    lbl1: TLabel;
    Label5: TLabel;
    dbeVoltag: TDBEditFocus;
    lblIteCcr: TLabel;
    dbeAutori: TDBEditFocus;
    clbIteCcr: TColorLabel;
    lblModelo: TLabel;
    dbeModelo: TDBEditFocus;
    gpbServicos: TGroupBox;
    pnlServicos: TPanel;
    lblServiço: TLabel;
    edtCodSer: TEditFocus;
    edtValSer: TEditFocus;
    lblValSer: TLabel;
    edtDesMax: TEditFocus;
    lblDesMax: TLabel;
    dbgGridSerEqu: TDBGridCitel;
    btnAdicionarSer: TBitBtnLocked;
    edtDesSer: TEditFocus;
    dtsSerEqu: TDataSource;
    btnCancelaSer: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodMarKeyPress(Sender: TObject; var Key: Char);
    function dbeCodMarChamaCadastro(Key: Word): string;
    function dbeCodIteChamaCadastro(Key: Word): string;
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaSerClick(Sender: TObject);
    procedure btnAdicionarSerClick(Sender: TObject);
    procedure edtCodSerKeyPress(Sender: TObject; var Key: Char);
    procedure dbgGridSerEquKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeCodIteExit(Sender: TObject);
  private
    { Private declarations }
    qryCadEqu,
    qryConMar,
    qryConIte: TUniQuery;
    dtsDados: TDataSource;
    cdsSerEqu: TUniClientDataSet;
    qrySerEqu: TUniQuery;

    procedure pCarregaMarca;
    procedure pCarregaProduto;
    procedure pLimpaEdits;
    procedure pCriaClientSerEqu;
    procedure pCarregaSerEqu;
    procedure pInicializaSerEqu;
    procedure pExcluirSerEqu;
    procedure pGravarSerEqu;
    function fPossuiOSVinculadas: Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses Forms, untPai, untConsultas, untFuncoesSimples, untTypesSistema, untPesqAux,
     untFuncIns;

{$R *.dfm}

procedure TfrmCadEquipamentos.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;

  strNomeTabela := 'CADEQU';
  strNomeCampo  := 'EQU_CODIGO';
  qryCadEqu     := fCriarQuery('SELECT * FROM CADEQU', Self);

  qryCadEqu.FieldByName('EQU_CODIGO').DisplayLabel := 'Código';
  qryCadEqu.FieldbyName('EQU_DESCRI').DisplayLabel := 'Descrição';

  qryCadEqu.FieldByName('EQU_CODEMP').Visible := False;
  qryCadEqu.FieldByName('AUTOINCREM').Visible := False;

  qryConMar := fCriarQuery('SELECT * FROM CADMAR WHERE FALSE', Self);
  qryConIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);

  dtsDados  := fCriaDataSource(qryCadEqu);
  qryTabela := qryCadEqu;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsDados;
    End;
  End;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;


procedure TfrmCadEquipamentos.FormDestroy(Sender: TObject);
begin
  inherited;

  dbgGridSerEqu.DataSource := Nil;
  dtsSerEqu.DataSet := Nil;

  if (Assigned(cdsSerEqu)) then
    FreeAndNil(cdsSerEqu);

  if (Assigned(qrySerEqu)) then
    FreeAndNil(qrySerEqu);
end;

function TfrmCadEquipamentos.fPossuiOSVinculadas: Boolean;
begin
  Result := fCampoTabela('COUNT(1)', 'EQUGER', ['EQU_CODEQU'], [qryTabela.FieldByName('EQU_CODIGO').AsString]) > 0;
end;

function TfrmCadEquipamentos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Equipamento deve ser preenchido!', ['&Ok']);
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
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição do equipamento deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DA MARCA              *}
    {**************************************MV*}
    Else If (Sender = dbeCodMar) Then
    Begin
      If fEmptyStr(dbeCodMar.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a Marca!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaMarca;
        If qryConMar.FieldByName('MAR_CODMAR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Marca não encontrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {***************************************}
    {* VALIDA O CÓDIGO DA ITEM             *}
    {************************************MM*}
    Else If (Sender = dbeCodIte) Then
    Begin
      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        pCarregaProduto;
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Produto não encontrado!', ['&Ok']);
          Result := False;
        End;
      End
      else if (fCfgSis('CONEQU', varBoolean)) and (fCfgSis('EQFLXP', varBoolean)) then
      begin
        fMensagem('ATENÇÃO!', 'Informe o Produto!', ['&Ok']);
        Result := False;
      end;
    End

    {***************************************}
    {* VALIDA O CÓDIGO DA ITEM             *}
    {************************************MM*}
    Else If (Sender = dbeAutori) Then
    Begin
      If (dbeAutori.Text <> 'S') And (dbeAutori.Text <> 'N') Then
      Begin
        fMensagem('','Informe (S)im / (N)ão para Assistência Técnica Autorizada!',['&O K'],0);
        Result := False;
      End;
    End

    else if (Sender = edtCodSer) and (blnBuscaPorChave) then
    begin
      if (gpbServicos.Visible) and (not fEmptyStr(edtCodSer.Text)) Then
      begin
        edtDesSer.Text := fRetNomeServico(edtCodSer.Text);

        if (fEmptyStr(edtDesSer.Text)) then
        begin
          fMensagem('ATENÇÃO!', 'Serviço não encontrado!', ['&Ok']);
          Result := False;
        end
        else
        begin
          if cdsSerEqu.Locate('CODSER ', edtCodSer.Text, []) then
          begin
            fMensagem('ATENÇÃO!', 'O serviço ' + edtCodSer.Text + ' - ' + edtDesSer.Text + ' já vinculado ao equipamento.', ['&Ok']);
            btnCancelaSer.Click;
            Result := False;
          end;
        end;
      end;
    end
    else if (Sender = edtValSer) and (blnBuscaPorChave) then
    begin
      if (fStrToFloat(edtValSer.Text) <= 0) then
      begin
        fMensagem('ATENÇÃO!', 'É permitido apenas valores acima de 0!', ['&Ok']);
        Result := False;
      end;
    end
    else if (Sender = edtDesMax) and (edtDesMax.Visible) and (blnBuscaPorChave) then
    begin
      if (fStrToFloat(edtDesMax.Text) < 0) or (fStrToFloat(edtDesMax.Text) > 100) then
      begin
        fMensagem('ATENÇÃO!', 'O desconto máximo deve estar entre 0 e 100%!', ['&Ok']);
        Result := False;
      end;
    end;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadEquipamentos.pCarregaMarca;
begin
  pPesquisaCadMar(qryConMar, qryConMar, dbeCodMar.Text);
  With qryConMar Do
  Begin
    edtDesMar.Text := FieldByName('MAR_DESMAR').AsString;
  End;
end;

procedure TfrmCadEquipamentos.pCarregaProduto;
begin
  pPesquisaCadIte(qryConIte, qryConIte, dbeCodIte.Text);
  With qryConIte Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;

procedure TfrmCadEquipamentos.pCarregaSerEqu;
var
  qryAux: TUniQuery;
  strSQL: String;
begin
  if (not gpbServicos.Visible) or (qryTabela.IsEmpty) then
    Exit;

  btnCancelaSer.Click;
  qryAux := fCriaQuery;
  cdsSerEqu.EmptyDataSet;

  strSQL := '';
  strSQL := strSQL + ' SELECT SEREQU.AUTOINCREM AUTINC, EQS_CODSER CODSER, CADSER.SER_DESSER DESSER, ';
  strSQL := strSQL + '     EQS_VALSER VALSER, EQS_DESMAX DESMAX ';
  strSQL := strSQL + ' FROM SEREQU ';
  strSQL := strSQL + ' INNER JOIN CADSER ON SEREQU.EQS_CODSER = CADSER.SER_CODSER ';
  strSQL := strSQL + ' WHERE EQS_CODEQU = :CODEQU ';

  try
    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('CODEQU').AsString := qryTabela.FieldByName('EQU_CODIGO').AsString;
    qryAux.Open;

    while not qryAux.Eof do
    begin
      cdsSerEqu.Append;
      cdsSerEqu.FieldByName('AUTINC').AsString := qryAux.FieldByName('AUTINC').AsString;
      cdsSerEqu.FieldByName('CODSER').AsString := qryAux.FieldByName('CODSER').AsString;
      cdsSerEqu.FieldByName('DESSER').AsString := qryAux.FieldByName('CODSER').AsString + ' - ' + qryAux.FieldByName('DESSER').AsString;
      cdsSerEqu.FieldByName('VALSER').AsFloat  := qryAux.FieldByName('VALSER').AsFloat;
      cdsSerEqu.FieldByName('DESMAX').AsFloat  := qryAux.FieldByName('DESMAX').AsFloat;
      cdsSerEqu.FieldByName('OPERAC').AsString := '';
      cdsSerEqu.Post;

      qryAux.Next;
    end;

    cdsSerEqu.First;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmCadEquipamentos.pCriaClientSerEqu;
begin
  cdsSerEqu := TUniClientDataSet.Create(Self);
  cdsSerEqu.FieldDefs.Add('AUTINC', ftString, 20);
  cdsSerEqu.FieldDefs.Add('CODSER', ftString,  5);
  cdsSerEqu.FieldDefs.Add('DESSER', ftString, 88);
  cdsSerEqu.FieldDefs.Add('VALSER', ftFloat     );
  cdsSerEqu.FieldDefs.Add('DESMAX', ftFloat     );
  cdsSerEqu.FieldDefs.Add('OPERAC', ftString,  6);
  cdsSerEqu.CreateDataSet;

  (cdsSerEqu.FieldByName('VALSER') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  (cdsSerEqu.FieldByName('VALSER') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECUNI', varInteger));
  (cdsSerEqu.FieldByName('DESMAX') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  (cdsSerEqu.FieldByName('DESMAX') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECUNI', varInteger));

  cdsSerEqu.IndexFieldNames := 'CODSER';

  cdsSerEqu.Filtered := False;
  cdsSerEqu.Filter := 'OPERAC <> ''D''';
  cdsSerEqu.Filtered := True;
end;

procedure TfrmCadEquipamentos.pExcluirSerEqu;
begin
  if not (fMensagem('AVISO', 'Confirma a exclusão do serviço vinculado?', ['&Sim', '&Não']) = 1) then
    Exit;

  if cdsSerEqu.FieldByName('OPERAC').AsString = 'I' then
    cdsSerEqu.Delete
  else
  begin
    cdsSerEqu.Edit;
    cdsSerEqu.FieldByName('OPERAC').AsString := 'D';
    cdsSerEqu.Post;
  end;

  btnCancelaSer.Click;
end;

procedure TfrmCadEquipamentos.pGravarSerEqu;
var
  strSQL: String;
  qryGravar: TUniQuery;
  cdsDados: TUniClientDataSet;
begin
  fStartTransaction;

  qryGravar := fCriaQuery;
  cdsDados  := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsDados, cdsSerEqu);

  cdsDados.Filtered := False;
  cdsDados.Filter   := 'OPERAC <> ''''';
  cdsDados.Filtered := True;

  try
    try
      cdsDados.First;

      while not cdsDados.Eof do
        begin
          if cdsDados.FieldByName('OPERAC').AsString = 'I' then
          begin
            strSQL := '';
            strSQL := strSQL + 'INSERT INTO SEREQU (AUTOINCREM, EQS_CODEQU, EQS_CODSER, EQS_VALSER, EQS_DESMAX) ';
            strSQL := strSQL + 'VALUES (:AUTINC, :CODEQU, :CODSER, :VALSER, :DESMAX)';

            qryGravar.Close;
            qryGravar.SQL.Clear;
            qryGravar.SQL.Text := strSQL;
            qryGravar.ParamByName('AUTINC').AsString := fRetAutoIncrem('SEREQU', VS_strCodEmp);
            qryGravar.ParamByName('CODEQU').AsString := qryTabela.FieldByName('EQU_CODIGO').AsString;
            qryGravar.ParamByName('CODSER').AsString := cdsDados.FieldByName('CODSER').AsString;
            qryGravar.ParamByName('VALSER').AsFloat  := cdsDados.FieldByName('VALSER').AsFloat;
            qryGravar.ParamByName('DESMAX').AsFloat  := cdsDados.FieldByName('DESMAX').AsFloat;
            qryGravar.ExecSQL;
          end
          else if cdsDados.FieldByName('OPERAC').AsString = 'D' then
          begin
            strSQL := '';
            strSQL := strSQL + 'DELETE FROM SEREQU WHERE AUTOINCREM = :AUTINC ';

            qryGravar.Close;
            qryGravar.SQL.Clear;
            qryGravar.SQL.Text := strSQL;
            qryGravar.ParamByName('AUTINC').AsString := cdsDados.FieldByName('AUTINC').AsString;
            qryGravar.ExecSQL;
          end;

          cdsDados.Next;
        end;

      fCommit;
      pCarregaSerEqu;
    except on E: Exception do
      begin
        fRollback;
        pMensagensErro(E.Message,'[TfrmCadDefeitos.btnGravarClick]');
      end;
    end;
  finally
    FreeAndNil(qryGravar);
    FreeAndNil(cdsDados);
  end;
end;

procedure TfrmCadEquipamentos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EQU_CODIGO');
  stlCampos.Add('EQU_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EQU_DESCRI');
  stlCamInd.Add('EQU_CODIGO');

  stlDesInd.Add('Equipamento');
  stlDesInd.Add('Código');
end;

procedure TfrmCadEquipamentos.pInicializaSerEqu;
begin
  pCriaClientSerEqu;
  dtsSerEqu.DataSet := cdsSerEqu;
  dbgGridSerEqu.DataSource := dtsSerEqu;

  edtDesMax.Visible := not (fCfgSis('QTDSER', VarBoolean) or fCfgSis('ALVLSE', VarBoolean));
  lblDesMax.Visible := edtDesMax.Visible;
end;

procedure TfrmCadEquipamentos.pLimpaEdits;
begin
  edtDesMar.Clear;
  edtDesIte.Clear;

  if (gpbServicos.Visible) then
    cdsSerEqu.EmptyDataSet;
end;

procedure TfrmCadEquipamentos.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  pSetaCodIte( dbeCodIte );

  if (not (fCfgSis('VSEREQ', varBoolean))) then
  begin
    Self.Height         := Self.Height - gpbServicos.Height;
    gpbServicos.Visible := False;
  end
  else
    pInicializaSerEqu;
end;


procedure TfrmCadEquipamentos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaSerEqu;
end;

procedure TfrmCadEquipamentos.btnCancelaSerClick(Sender: TObject);
begin
  inherited;
  edtCodSer.Clear;
  edtDesSer.Clear;
  edtValSer.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), 0);
  edtDesMax.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), 0);
  pSetFocus(edtCodSer);
end;

procedure TfrmCadEquipamentos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    if fPossuiOSVinculadas then
    begin
      fMensagem('ATENÇÃO!', 'Não é possível excluir o equipamento pois existem Ordens de Serviços vinculadas!', ['&Ok']);
      Exit;
    end;

    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEquipamentos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    fCommit;
    pLimpaEdits
  End
  Else
  Begin
    fRollBack;
    pCarregaSerEqu;
  end;
end;

procedure TfrmCadEquipamentos.btnGravarClick(Sender: TObject);
begin
  if fEmptyStr(dbeCodIte.Text) then
    qryTabela.FieldByName('EQU_CODITE').Value := Null;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEquipamentos.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  if (blnGravou) and (gpbServicos.Visible) then
    pGravarSerEqu;
end;

procedure TfrmCadEquipamentos.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  qryTabela.FieldByName('EQU_AUTORI').AsString := 'S';

  pLimpaEdits;
end;

procedure TfrmCadEquipamentos.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrEqup: TConsultasArray;
begin
  pLimpaEdits;

  {*********************************}
  {* NOVA CONSULTA DE EQUIPAMENTOS *}
  {*********************************}
  chrKey := '/';
  If fPesqEquipamento(Self, Nil, Nil, qryTabela, chrKey, arrEqup) Then
  Begin
    pCarregaMarca;
    pCarregaProduto;
    if (gpbServicos.Visible) then
      pCarregaSerEqu;
    pSetFocus(btnAlterar);
  End;
end;

function TfrmCadEquipamentos.dbeCodIteChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadIte(Key);
end;

procedure TfrmCadEquipamentos.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(dbeCodIte.Text) then
    edtDesIte.Clear;
end;

procedure TfrmCadEquipamentos.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
Var
  arrProduto : TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE PRODUTOS *}
  {**************************MM*}
  if fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, Nil, Key, arrProduto, True, nil, 'Consulta de Itens', '1') then
  Begin
    If fValidaCampos(dbeCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadEquipamentos.dbeCodMarChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadMar(Key);
end;

procedure TfrmCadEquipamentos.dbeCodMarKeyPress(Sender: TObject; var Key: Char);
Var
  arrMarca : TConsultasArray;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************MM*}
  If fPesqMarcas(Self, dbeCodMar, edtDesMar, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(dbeCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEquipamentos.dbgGridSerEquKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE then
    pExcluirSerEqu();
end;

procedure TfrmCadEquipamentos.edtCodSerKeyPress(Sender: TObject; var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;

  try
    if fPesqServicos(Self, edtCodSer, edtDesSer, nil, Key, arrSel, True, False, nil, False) then
    begin
      if fValidaCampos(edtCodSer, True) Then
        SelectNext(ActiveControl, True, True);
    end;
  finally
  end;
end;

procedure TfrmCadEquipamentos.btnAdicionarSerClick(Sender: TObject);
begin
  inherited;

  if (not gpbServicos.Visible) then
    Exit;

  if (not fValidaCampos(edtCodSer, True)) then
    Exit;

  if (not fValidaCampos(edtValSer, True)) then
    Exit;

  if (not fValidaCampos(edtDesMax, True)) then
    Exit;

  if (cdsSerEqu.Locate('CODSER', edtCodSer.Text, [])) then
  begin
    fMensagem('ATENÇÃO!', 'O serviço ' + edtCodSer.Text + ' - ' + edtDesSer.Text + ' já foi vinculado ao equipamento.', ['&Ok']);
    Exit;
  end;

  cdsSerEqu.Append;
  cdsSerEqu.FieldByName('CODSER').AsString := edtCodSer.Text;
  cdsSerEqu.FieldByName('DESSER').AsString := edtCodSer.Text + ' - ' + edtDesSer.Text;
  cdsSerEqu.FieldByName('VALSER').AsFloat  := fStrToFloat(edtValSer.Text);
  cdsSerEqu.FieldByName('DESMAX').AsFloat  := fStrToFloat(edtDesMax.Text);
  cdsSerEqu.FieldByName('OPERAC').AsString := 'I';
  cdsSerEqu.Post;

  btnCancelaSer.Click;
end;

procedure TfrmCadEquipamentos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

end.
