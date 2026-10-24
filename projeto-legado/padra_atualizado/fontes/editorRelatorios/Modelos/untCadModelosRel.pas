unit untCadModelosRel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, untModeloFast;

type
  TfrmCadModelosRel = class(TfrmPaiCad)
    pnlDados: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    rdgTipImp: TRadioGroup;
    btnModelo: TBitBtnLocked;
    dtsCadMod: TDataSource;
    btnSalvaBackup: TBitBtnLocked;
    btnRestaura: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnModeloClick(Sender: TObject);
    procedure rdgTipImpClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSalvaBackupClick(Sender: TObject);
    procedure btnRestauraClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    objFast: TModeloFast;

    blnRestaurou: Boolean;

    procedure pCarregaDados;

  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

{$R *.dfm}

Uses
  StrUtils, untFuncoesSimples, untPai, untConsultas, untTypesSistema,
  untFuncEditorRel;

procedure TfrmCadModelosRel.btnAlterarClick(Sender: TObject);
begin
  If dbeCodigo.Text > LIMITE_MODELO_USUARIO Then
  Begin
    pMensagemOk('Modelos com código acima de 500000 são modelos padrão de relatórios e não podem ser alterados!')
  End Else
  Begin
    inherited;

    pHabilitaCodigo(dbeCodigo, dbeDescri, False);

    btnModelo.Enabled := True;
    rdgTipImp.Enabled := False;

    pCarregaDados;
  End;
end;

procedure TfrmCadModelosRel.btnCancelaClick(Sender: TObject);
begin
  inherited;

  btnModelo.Enabled := False;
  rdgTipImp.Enabled := False;

  pCarregaDados;
end;

procedure TfrmCadModelosRel.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If dbeCodigo.Text > LIMITE_MODELO_USUARIO Then
  Begin
    pMensagemOk('Modelos com código acima de 500000 são modelos padrão de relatórios e não podem ser excluídos!')
  End Else
  Begin
    Try
      inherited;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadModelosRel.btnExcluirClick]');
      End;
    End;

    If blnExcluiu Then
      fCommit
    Else
      fRollBack;
  End;

end;

procedure TfrmCadModelosRel.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If (Not objFast.blnEditou) And
     (Not blnRestaurou) And
     (qryTabela.State = dsInsert) Then
  Begin
    pMensagemOk('Defina o Modelo do Layout!');
    Exit;
  End;

  qryTabela.FieldByName('MOD_DTAALT').AsDateTime := VS_Date;
  qryTabela.FieldByName('MOD_HORALT').AsDateTime := fTime();

  objFast.fSaveReport;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadModelosRel.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  btnModelo.Enabled := False;
  rdgTipImp.Enabled := False;
end;

procedure TfrmCadModelosRel.btnIncluirClick(Sender: TObject);
begin
  inherited;

  blnRestaurou := False;

  qryTabela.FieldByName('MOD_TIPIMP').AsString := 'J';

  objFast.pClear;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  btnModelo.Enabled   := True;
  rdgTipImp.Enabled   := True;
  rdgTipImp.ItemIndex := 0;
end;

procedure TfrmCadModelosRel.btnModeloClick(Sender: TObject);
begin
  inherited;

  objFast.fLoadReport(rdgTipImp.ItemIndex = 1);
  objFast.pEditLayout;

end;

procedure TfrmCadModelosRel.pCarregaDados;
Begin
  If qryTabela.FieldByName('MOD_TIPIMP').AsString = 'J' Then
    rdgTipImp.ItemIndex := 0
  Else
    rdgTipImp.ItemIndex := 1;

  objFast.fLoadReport(rdgTipImp.ItemIndex = 1);
End;

procedure TfrmCadModelosRel.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrModelo: TConsultasArray;
begin
  chrKey := '/';

  If fPesqModeloRelatorio(Self, Nil, Nil, qryTabela, False, '', chrKey, arrModelo) Then
  Begin
    pCarregaDados;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadModelosRel.btnRestauraClick(Sender: TObject);
  Var
    chrKey: Char;
    arrModelo: TConsultasArray;
begin
  inherited;

  If Not (qryTabela.State In dsEditModes) Then
  Begin
    pMensagemOk('Há dois modos de restaurar um modelo:' + #13#10 +
                '1) Selecione um modelo já existente, clique em "Alterar" e depois em "Restaurar"' + #13#10 +
                '2) Clique em "Incluir" e depois em "Restaurar"');
    Exit;
  End;

  chrKey := '/';

  If fPesqModeloRelatorio(Self, Nil, Nil, Nil, True, '', chrKey, arrModelo, True, dbeCodigo.Text) Then
  Begin
    pgcDados.ActivePageIndex := 0;
    objFast.fRestauraBackup(qryTabela, arrModelo[0].strCodigo);
    pCarregaDados;

    blnRestaurou := True;
  End;

end;

procedure TfrmCadModelosRel.btnSalvaBackupClick(Sender: TObject);
begin
  inherited;

  If qryTabela.IsEmpty Then
  Begin
    pMensagemOk('Carregue um modelo para a fazer o backup!');
    Exit;
  End;

  If qryTabela.State In dsEditModes Then
  Begin
    pMensagemOk('Salve o modelo para poder fazer o backup!');
    Exit;
  End;

  If objFast.fSalvaBackup(qryTabela) Then
    pMensagemOk('Cópia salva com sucesso!');
end;

procedure TfrmCadModelosRel.FormCreate(Sender: TObject);
begin
  inherited;

  blnRestaurou          := False;

  strNomeTabela         := 'CADMOD';
  strNomeCampo          := 'MOD_CODMOD';

  qryTabela             := fCriaQuery(Self);;
  dtsCadMod.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0]     := dbeCodigo;

  objFast := TModeloFast.Create(Self, qryTabela);
end;

procedure TfrmCadModelosRel.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);
end;

procedure TfrmCadModelosRel.FormShow(Sender: TObject);
begin
  inherited;

  If btnIncluir.Enabled Then
    pSetFocus(btnIncluir);
end;

function TfrmCadModelosRel.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Modelo deve ser preenchido!', ['&Ok']);
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
        fMensagem('ATENÇÃO!', 'A Descrição do Modelo deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadModelosRel.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

procedure TfrmCadModelosRel.rdgTipImpClick(Sender: TObject);
begin
  inherited;

  If qryTabela.State In [dsEdit, dsInsert] Then
  Begin
    If rdgTipImp.ItemIndex = 0 Then
      qryTabela.FieldByName('MOD_TIPIMP').AsString := 'J'
    Else
      qryTabela.FieldByName('MOD_TIPIMP').AsString := 'M';
  End;

end;

end.
