unit untCadVerbasCliFor;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, Menus, AppEvnts, BitBtnLockedIncrem, EditFocus, Db,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadVerbasCliFor = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDtaLan: TDBEditFocus;
    Label2: TLabel;
    pnlFundo: TPanel;
    lbl1: TLabel;
    dbeCodFor: TDBEditFocus;
    lbl2: TLabel;
    dbeCodCli: TDBEditFocus;
    lbl3: TLabel;
    dbeCodVen: TDBEditFocus;
    lbl4: TLabel;
    dbeValVba: TDBEditFocus;
    lbl5: TLabel;
    dbeValMin: TDBEditFocus;
    lbl6: TLabel;
    dbeCodMot: TDBEditFocus;
    edtNomFor: TEditFocus;
    edtNomCli: TEditFocus;
    edtNomVen: TEditFocus;
    edtDesMot: TEditFocus;
    dtsTabela: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodMotKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure pAtualizaCampos(DataSet: TDataSet);
    procedure pAfterOpen(DataSet: TDataSet);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadVerbasCliFor.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CADVBA';
  strNomeCampo  := 'VBA_CODVBA';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;
  qryTabela.AfterOpen := pAfterOpen;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

function TfrmCadVerbasCliFor.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;

  function fRegistroCadastrado: Boolean;
    Var
      strAutInc: string;
  begin
    Result := False;

    strAutInc := Trim(fCampoTabela('AUTOINCREM', 'CADVBA', ['VBA_CODCLI', 'VBA_CODFOR', 'VBA_DTALAN'], [dbeCodCli.Text, dbeCodFor.Text, StrToDate(dbeDtaLan.Text)]));

    If (qryTabela.State = dsInsert) Then
      Result := (Not fEmptyStr(strAutInc))
    Else If (qryTabela.State = dsEdit) Then
      Result := (Not fEmptyStr(strAutInc)) And (strAutInc <> qryTabela.FieldByName('AUTOINCREM').AsString);

    If Result Then
      fMensagem('ATENÇÃO!', 'Já existe uma verba cadastrada nesta data para o Cliente e Fornecedor informado!', ['&OK']);
  end;

begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Verba deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeCodFor) Then
    Begin
      If (fEmptyStr(dbeCodFor.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do fornecedor deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        edtNomFor.Text := fRetNomFornecedor(dbeCodFor.Text);
        If fEmptyStr(edtNomFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código do fornecedor inválido!', ['&OK']);
          Result := False;
        End;
      End;

      If Result Then
        Result := Not fRegistroCadastrado;
    End

    Else If (Sender = dbeCodCli) Then
    Begin
      If (fEmptyStr(dbeCodCli.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do cliente deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        edtNomCli.Text := fRetNomCliente(dbeCodCli.Text);
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código do cliente inválido!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeCodVen) Then
    Begin
      If (fEmptyStr(dbeCodVen.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do vendedor deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        edtNomVen.Text := fRetNomVendRep(dbeCodVen.Text);
        If fEmptyStr(edtNomVen.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código do vendedor inválido!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeValVba) Then
    Begin
      If fStrToFloat(dbeValVba.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Valor da verba deve ser maior que zero!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeValMin) Then
    Begin
      If fStrToFloat(dbeValMin.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Valor mínimo deve ser maior que zero!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodMot) Then
    Begin
      If (fEmptyStr(dbeCodMot.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do motivo da verba deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        edtDesMot.Text := fRetDesMotVba(dbeCodMot.Text);
        If fEmptyStr(edtDesMot.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código do motivo da verba inválido!', ['&OK']);
          Result := False;
        End;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadVerbasCliFor.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('VBA_CODVBA');
  stlCampos.Add('VBA_DTALAN');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('VBA_CODVBA');
  stlCamInd.Add('VBA_DTALAN');

  stlDesInd.Add('Código Verba');
  stlDesInd.Add('Data Lancto');
end;

procedure TfrmCadVerbasCliFor.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeCodFor, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodFor, True);

  If (qryTabela.State = dsInsert) Then
  Begin
    dbeDtaLan.Enabled := False;

    edtNomFor.Clear;
    edtNomCli.Clear;
    edtNomVen.Clear;
    edtDesMot.Clear;

    qryTabela.FieldByName('VBA_DTALAN').AsDateTime := fNow;
    qryTabela.FieldByName('VBA_VALVBA').AsFloat := 0;
    qryTabela.FieldByName('VBA_VALMIN').AsFloat := 0;    
  End;  
end;

procedure TfrmCadVerbasCliFor.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDtaLan, False);

  If (qryTabela.State = dsEdit) Then
    dbeDtaLan.Enabled := False;
end;

procedure TfrmCadVerbasCliFor.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadVerbasCliFor.pAtualizaCampos(DataSet: TDataSet);
begin
  edtNomFor.Text := fRetNomFornecedor(DataSet.FieldByName('VBA_CODFOR').AsString);
  edtNomCli.Text := fRetNomCliente(DataSet.FieldByName('VBA_CODCLI').AsString);
  edtNomVen.Text := fRetNomVendRep(DataSet.FieldByName('VBA_CODVEN').AsString);
  edtDesMot.Text := fRetDesMotVba(DataSet.FieldByName('VBA_CODMOT').AsString);
end;

procedure TfrmCadVerbasCliFor.btnPesquisaClick(Sender: TObject);
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  chrKey := '/';
  If fPesqVerbasCliFor(Self, dbeCodigo, qryTabela, chrKey, arrSel) Then
  Begin
    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
      pSetFocus(btnAlterar);
  End;

  pAtualizaCampos(qryTabela);
end;

procedure TfrmCadVerbasCliFor.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pAtualizaCampos(qryTabela);
end;

procedure TfrmCadVerbasCliFor.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadVerbasCliFor.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pAtualizaCampos(qryTabela);
end;

procedure TfrmCadVerbasCliFor.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadVerbasCliFor.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pAtualizaCampos(qryTabela);
end;

procedure TfrmCadVerbasCliFor.pAfterOpen(DataSet: TDataSet);
begin
  With qryTabela Do
  Begin
    (FieldByName('VBA_DTALAN') As TDateField).EditMask       := '99/99/9999';
    (FieldByName('VBA_VALVBA') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('VBA_VALVBA') As TFloatField).EditFormat    := '#,##0.00';
    (FieldByName('VBA_VALMIN') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('VBA_VALMIN') As TFloatField).EditFormat    := '#,##0.00';
  End;
end;

procedure TfrmCadVerbasCliFor.dbeCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  If fPesqFornecedor(conForSimples, Self, dbeCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbeCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadVerbasCliFor.dbeCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  If fPesqCliente(conCliSimples, Self, dbeCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(dbeCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadVerbasCliFor.dbeCodVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrVen: TConsultasArray;
begin
  If fPesqOperador(Self, dbeCodVen, edtNomVen, Nil, Key, arrVen) Then
  Begin
    If fValidaCampos(dbeCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadVerbasCliFor.dbeCodMotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrMot: TConsultasArray;
begin
  If fPesqMotivoVerbas(Self, dbeCodMot, edtDesMot, Nil, Key, arrMot) Then
  Begin
    If fValidaCampos(dbeCodMot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.

