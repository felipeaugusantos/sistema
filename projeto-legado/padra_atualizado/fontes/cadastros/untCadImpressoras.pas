unit untCadImpressoras;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, DB, Mask, DBCtrls, DBEditFocus,
  BitBtnLockedIncrem, Uni,
  DBComboBoxFocus, frxClass, frxExportCSVTestabilidade, ComboBoxFocus, SysUtils;

type
  TfrmCadImpressoras = class(TfrmPaiCad)
    pnlGeral: TPanel;
    Label1: TLabel;
    dbeCodImp: TDBEditFocus;
    Label2: TLabel;
    dbeNomImp: TDBEditFocus;
    dtsCadImp: TDataSource;
    lblTipImp: TLabel;
    cmbTipImp: TComboBoxFocus;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    function fImpressoraJaCadastrada(): Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadImpressoras.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodImp, dbeNomImp, False);
  cmbTipImp.ItemIndex := IIF(qryTabela.FieldByName('IMP_TIPIMP')
    .AsString = 'M', 0, 1);
end;

procedure TfrmCadImpressoras.btnCancelaClick(Sender: TObject);
begin
  inherited;
  cmbTipImp.ItemIndex := IIF(qryTabela.FieldByName('IMP_TIPIMP')
    .AsString = 'M', 0, 1);
end;

procedure TfrmCadImpressoras.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadImpressoras.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  cmbTipImp.ItemIndex := IIF(qryTabela.FieldByName('IMP_TIPIMP')
    .AsString = 'M', 0, 1);
end;

procedure TfrmCadImpressoras.btnGravarClick(Sender: TObject);
begin
  qryTabela.FieldByName('IMP_TIPIMP').AsString :=
    IIF(cmbTipImp.ItemIndex = 0, 'M', 'J');

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadImpressoras.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadImpressoras.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodImp, dbeNomImp, False)
  Else
    pHabilitaCodigo(dbeCodImp, dbeCodImp, True);
  cmbTipImp.ItemIndex := 1;
end;

procedure TfrmCadImpressoras.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrImp: TConsultasArray;
begin
  chrKey := '/';
  If fPesqImpressoras(Self, Nil, Nil, qryTabela, chrKey, arrImp) Then
    pSetFocus(btnAlterar);
  cmbTipImp.ItemIndex := IIF(qryTabela.FieldByName('IMP_TIPIMP')
    .AsString = 'M', 0, 1);
end;

function TfrmCadImpressoras.fImpressoraJaCadastrada: Boolean;
Var
  qryGen: TUniQuery;
begin
  inherited;
  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Text := 'SELECT IMP_CODIMP FROM CADIMP WHERE ' +
      'IMP_NOMIMP = :NOMIMP AND IMP_CODIMP <> :CODIMP LIMIT 1';

    qryGen.ParamByName('NOMIMP').AsString := dbeNomImp.Text;
    qryGen.ParamByName('CODIMP').AsString := dbeCodImp.Text;
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Finally
    qryGen.Free;
  End;
end;

procedure TfrmCadImpressoras.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CADIMP';
  strNomeCampo := 'IMP_CODIMP';
  qryTabela := fCriarQuery('SELECT * FROM CADIMP WHERE FALSE', Self);
  dtsCadImp.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodImp;
end;

procedure TfrmCadImpressoras.FormShow(Sender: TObject);
begin
  inherited;
  btnIncluir.Enabled := True;
end;

function TfrmCadImpressoras.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodImp) Then
    Begin
      If (fEmptyStr(dbeCodImp.Text)) And (dbeCodImp.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!',
          'O Código da impressora deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeNomImp) Then
    Begin
      If fEmptyStr(dbeNomImp.Text) Then
      Begin
        fMensagem('ATENÇÃO!',
          'O Nome da impressora deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fImpressoraJaCadastrada Then
      Begin
        fMensagem('ATENÇÃO!',
          'Já foi cadastrada uma impressora com esse nome!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadImpressoras.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('IMP_CODIMP');
  stlCampos.Add('IMP_DESIMP');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('IMP_DESIMP');
  stlCamInd.Add('IMP_CODIMP');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
