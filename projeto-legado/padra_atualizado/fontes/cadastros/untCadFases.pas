unit untCadFases;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, DBEditFocus, DB, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, Uni, SysUtils, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, EditFocus,
  untFuncoesConsulta, untCadFasesEquip, untOrdProIndMonitoramento,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadFases = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    btnSeqFas: TBitBtnLocked;
    pnlFundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeDesFas: TDBEditFocus;
    dbeCodFas: TDBEditFocus;
    tbsEquipamentos: TTabSheet;
    pnlInclusao: TPanel;
    cxgEquipamentos: TcxGrid;
    cxgEquipamentosView: TcxGridDBTableView;
    cxgEquipamentosCODEQP: TcxGridDBColumn;
    cxgEquipamentosDESCRI: TcxGridDBColumn;
    cxgEquipamentosLevel1: TcxGridLevel;
    edtCodEqp: TEditFocus;
    edtDesEqp: TEditFocus;
    Label3: TLabel;
    pnlDelEQP: TPanel;
    btnExcEqp: TBitBtnLocked;
    mmoTravaFases: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnSeqFasClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtCodEqpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEqpExit(Sender: TObject);
    procedure cxgEquipamentosViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcEqpClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    objEquipe: TCadFasesEquip;

    Function fRetProximaFase: Integer;
    procedure pOrdenaFases;
    procedure pChecaOperacoes;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untCadFasesOrdem;

{$R *.dfm}

procedure TfrmCadFases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodFas, dbeDesFas, False);

  objEquipe.fCarregaEquipamentos(qryTabela.FieldByName('FAS_CODFAS').AsString);

  If (qryTabela.State In [dsEdit, dsInsert]) Then
  Begin
    btnSeqFas.Enabled := False;
    btnExcEqp.Enabled := True;
    pChecaOperacoes;
  End;
end;

Function TfrmCadFases.fRetProximaFase: Integer;
  Var
    qryCadFas: TUniQuery;
Begin
  qryCadFas := fCriaQuery(Self);
  With qryCadFas, SQL Do
  Begin
    Add('SELECT IFNULL(MAX(FAS_SEQFAS), 0) + 1 AS SEQFAS FROM CADFAS');
    Open;
    Result := FieldByName('SEQFAS').AsInteger;
    Close;
  End;

  FreeAndNil(qryCadFas);
End;

procedure TfrmCadFases.btnCancelaClick(Sender: TObject);
begin
  inherited;

  btnSeqFas.Enabled := True;

  objEquipe.pCancela;
  btnExcEqp.Enabled := False;
  pChecaOperacoes;
end;

procedure TfrmCadFases.btnExcEqpClick(Sender: TObject);
begin
  inherited;

  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  If (Not objEquipe.IsEmpty) And fPergunta('Deseja excluir o equipamento ' + objEquipe.FieldByName('EQP_DESCRI').AsString + '?') Then
    objEquipe.fExcluiEquipamento;
end;


procedure TfrmCadFases.pOrdenaFases;
  Var
    qryCadFas: TUniQuery;
Begin
  qryCadFas := fCriaQuery;
  With qryCadFas, SQL Do
  Begin
    Add('SELECT * FROM CADFAS ORDER BY FAS_SEQFAS');
    Open;
    while Not Eof do
    Begin
      Edit;
      FieldByName('FAS_SEQFAS').AsInteger := RecNo;
      Post;
      Next;
    End;

  End;
  FreeAndNil(qryCadFas);
End;

procedure TfrmCadFases.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;

    If blnExcluiu Then
    Begin
      pOrdenaFases;
      fCommit;
    End

    Else fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFases.btnExcluirClick]');
    End;
  End;

end;

procedure TfrmCadFases.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If (qryTabela.State In [dsEdit, dsInsert]) And
     (qryTabela.FieldByName('FAS_SEQFAS').IsNull) Then
    qryTabela.FieldByName('FAS_SEQFAS').AsInteger := fRetProximaFase;

  Try
    inherited;

    If blnGravou And objEquipe.fSalvaEquipamentos(qryTabela.FieldByName('FAS_CODFAS').AsString) Then
    Begin
      fCommit;
    End Else
    Begin
      fRollBack;
      Exit;
    End

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFases.btnGravarClick]');
    End;
  End;

  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    btnSeqFas.Enabled := True;

  btnExcEqp.Enabled := False;
  pChecaOperacoes;
end;

procedure TfrmCadFases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodFas, dbeDesFas, False)
  Else
    pHabilitaCodigo(dbeCodFas, dbeCodFas, True);

  If (qryTabela.State In [dsEdit, dsInsert]) Then
    btnSeqFas.Enabled := False;

  objEquipe.fCarregaEquipamentos('');

  btnExcEqp.Enabled := True;
  pChecaOperacoes;
end;

procedure TfrmCadFases.btnPesquisaClick(Sender: TObject);
  Var
    arrFases : TConsultasArray;
    chrKey   : Char;
Begin
  {*****************************}
  {* NOVA CONSULTA DE FASES    *}
  {**************************PZ*}
  chrKey := '/';
  if fPesqFases(Self, Nil, Nil, qryTabela, chrKey, arrFases) then
  Begin
    objEquipe.fCarregaEquipamentos(qryTabela.FieldByName('FAS_CODFAS').AsString);
    pSetFocus(btnAlterar);
    pChecaOperacoes;
  End;
end;

procedure TfrmCadFases.btnSeqFasClick(Sender: TObject);
begin
  inherited;

  If Not btnSeqFas.Enabled Then
    Exit;

  pCriarForm(TfrmCadFasesOrdem);
end;

procedure TfrmCadFases.cxgEquipamentosViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_DELETE: btnExcEqp.Click;
  end;

end;

procedure TfrmCadFases.edtCodEqpExit(Sender: TObject);
  Var arrSel: TConsultasArray;
begin
  inherited;

  pEdtCodSelectExit(edtCodEqp, edtDesEqp, arrSel, fRetNomEquipamento, nil, 'do Equipamento');
end;

procedure TfrmCadFases.edtCodEqpKeyPress(Sender: TObject; var Key: Char);
  Var arrSel: TConsultasArray;
begin
  inherited;

  If Not edtCodEqp.Enabled Then
    Exit;

  If fPesqEquipamentosInd(Self,
                          edtCodEqp,
                          edtDesEqp,
                          Nil,
                          Key,
                          arrSel) Then
   fValidaCampos(edtCodEqp, True);
end;

procedure TfrmCadFases.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADFAS';
  strNomeCampo      := 'FAS_CODFAS';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodFas;

  objEquipe :=  TCadFasesEquip.Create(Self);

  cxgEquipamentosView.DataController.DataSource := objEquipe.dtsSource;

  pgcDados.ActivePage := tbsGeral;

  intPaginasAtivas := 2;
end;

procedure TfrmCadFases.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

function TfrmCadFases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    {***************************************}
    {* VALIDA CODIGO DA FASE               *}
    {************************************PZ*}
    If (Sender = dbeCodFas) Then
    Begin
      If (fEmptyStr(dbeCodFas.Text)) And (dbeCodFas.Enabled) Then
      Begin
        pgcDados.ActivePage := tbsGeral;
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código da Fase deve ser preenchido!', ['&Ok']);
      End
      {*****************************************}
      {* VERIFICA SE EXISTE O CODIGO INFORMADO *}
      {* CASO EXISTA TRAZ PARA EDICAO          *}
      {**************************************PZ*}
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
        Begin
          pgcDados.ActivePage := tbsGeral;
          pLimparCampos;
        End;
      End;
    End

    {****************************************}
    {* VALIDA DESCRICAO DA FASE             *}
    {*************************************PZ*}
    Else If (Sender = dbeDesFas) Then
    Begin
      If fEmptyStr(dbeDesFas.Text) Then
      Begin
        pgcDados.ActivePage := tbsGeral;
        Result := False;
        fMensagem('ATENÇÃO!', 'A Descrição da Fase deve ser preenchida!', ['&Ok']);
      End

      Else pProximaPagina;

    End

    Else If (Sender = edtCodEqp) Then
    Begin

      If Not fEmptyStr(edtCodEqp.Text) Then
      Begin
        edtDesEqp.Text := fRetNomEquipamento(edtCodEqp.Text);

        If fEmptyStr(edtDesEqp.Text) Then
        Begin
          pgcDados.ActivePage := tbsEquipamentos;
          Result := False;
          fMensagem('ATENÇÃO!', 'Equipamento não encontrado!', ['&Ok']);
        End

        Else If objEquipe.fTemEquipamento(edtCodEqp.Text) Then
        Begin
          pgcDados.ActivePage := tbsEquipamentos;
          Result := False;
          pMensagemOk('Equipamento já cadastrado!');
        End

        Else objEquipe.fIncluiEquipamento(edtCodEqp.Text);

        edtCodEqp.Clear;
        edtDesEqp.Clear;
        blnMudarFoco := False;
      End;

    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadFases.pgcDadosChange(Sender: TObject);
begin
  inherited;

  If pgcDados.ActivePage = tbsEquipamentos Then
    pChecaOperacoes;

end;

procedure TfrmCadFases.pChecaOperacoes;
Begin
   mmoTravaFases.Visible := qryTabela.Active And
                            TOrdProIndMonitoramento.fTemOperacaoIniciadaDeOPAberta(qryTabela.FieldByName('FAS_CODFAS').AsString);

  tbsEquipamentos.Enabled := btnExcEqp.Enabled And (Not mmoTravaFases.Visible);
End;

procedure TfrmCadFases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('FAS_CODFAS');
  stlCampos.Add('FAS_DESFAS');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('FAS_DESFAS');
  stlCamInd.Add('FAS_CODFAS');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.

