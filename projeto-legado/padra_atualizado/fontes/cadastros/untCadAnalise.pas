unit untCadAnalise;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, untConsultas, untFuncoesSimples, untTypesSistema,
  ComboBoxFocus, DBComboBoxFocus, strUtils;

type
  TfrmCadAnalise = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    pnlDados: TPanel;
    Label1: TLabel;
    dbeCodAna: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    lblPeriod: TLabel;
    dbePeriod: TDBEditFocus;
    cbxTipAna: TComboBoxFocus;
    Label6: TLabel;
    Label3: TLabel;
    DBEditFocus1: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    Label4: TLabel;
    DBEditFocus3: TDBEditFocus;
    Label5: TLabel;
    Label7: TLabel;
    dbeTipRes: TDBComboBoxFocus;
    Label8: TLabel;
    DBEditFocus4: TDBEditFocus;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbxTipAnaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregaDadosAdicionais(blnHabilita: Boolean = True);
    procedure pHablitaCampos(blnHabilita: Boolean);
    procedure pOnGetTextTipRes(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure pOnSetTextTipRes(Field: TField; const Text: String);
    procedure pQryAfterOpen(DataSet: TDataSet);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

{$R *.dfm}

uses untAnaliseMov;

procedure TfrmCadAnalise.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodAna, dbeDescri, False);

  pCarregaDadosAdicionais;
  pHablitaCampos(True);
end;

procedure TfrmCadAnalise.btnCancelaClick(Sender: TObject);
begin
  inherited;

  pCarregaDadosAdicionais(False);

  pHablitaCampos(False);
end;

procedure TfrmCadAnalise.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAnalise.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAnalise.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadAnalise.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    pHablitaCampos(False);
    fCommit
  End
  Else
    fRollBack;
end;

procedure TfrmCadAnalise.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodAna, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodAna, dbeCodAna, True);

  qryTabela.FieldByName('ANA_PERIOD').AsInteger := 1;
  qryTabela.FieldByName('ANA_TIPRES').AsInteger := 1;

  pCarregaDadosAdicionais;

  pHablitaCampos(True);
end;

procedure TfrmCadAnalise.btnPesquisaClick(Sender: TObject);
  Var
    arrAna : TConsultasArray;
    chrKey   : Char;
Begin
  chrKey := '/';
  if fPesqAnalises(Self, Nil, Nil, qryTabela, chrKey, arrAna) then
    pSetFocus(btnAlterar);

  pCarregaDadosAdicionais(False);
  pHablitaCampos(False);
end;

procedure TfrmCadAnalise.cbxTipAnaClick(Sender: TObject);
begin
  inherited;

  If qryTabela.State In [dsEdit, dsInsert] Then
  Begin
    Case cbxTipAna.ItemIndex Of
      0:   qryTabela.FieldByName('ANA_TIPANA').AsInteger := 1;
      1:   qryTabela.FieldByName('ANA_TIPANA').AsInteger := 2;
    End;
  End;
end;

procedure TfrmCadAnalise.pCarregaDadosAdicionais(blnHabilita: Boolean = True);
Begin
  Case qryTabela.FieldByName('ANA_TIPANA').AsInteger Of
    1:   cbxTipAna.ItemIndex := 0;
    2:   cbxTipAna.ItemIndex := 1;
    Else cbxTipAna.ItemIndex := -1;
  End;
End;

procedure TfrmCadAnalise.FormCreate(Sender: TObject);
Var
  i : Integer;
begin
  inherited;

  strNomeTabela     := 'CADANA';
  strNomeCampo      := 'ANA_CODANA';
  qryTabela         := fCriaQuery(Self);
  qryTabela.SpecificOptions.Add('EnableBoolean=False');
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodAna;

  qryTabela.AfterOpen := pQryAfterOpen;

  pHablitaCampos(False);

  dbeTipRes.Items.Clear;
  For i := 1 to High(ARR_TIPRESANA) do
    dbeTipRes.Items.Add(ARR_TIPRESANA[i]);


end;

procedure TfrmCadAnalise.FormShow(Sender: TObject);
begin
  inherited;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

end;

procedure TfrmCadAnalise.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

procedure TfrmCadAnalise.pHablitaCampos(blnHabilita: Boolean);
Begin
  cbxTipAna.Enabled := blnHabilita;
End;

function TfrmCadAnalise.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodAna) Then
    Begin
      If (fEmptyStr(dbeCodAna.Text)) And (dbeCodAna.Enabled) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código do Análise deve ser preenchido!', ['&Ok']);
      End
      Else If blnBuscaPorChave Then
      Begin

      End;
    End

    else If (Sender = dbeTipRes) Then
    Begin
      If fEmptyStr(dbeTipRes.Text) then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Escolha o Tipo de Resultado!', ['&Ok']);
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A Descrição da Análise deve ser preenchida!', ['&Ok']);
      End;
    End

    Else If (Sender = cbxTipAna) Then
    Begin

      If cbxTipAna.ItemIndex = -1 Then
      Begin
        Result := False;
        pMensagemOk('Escolha o Tipo de Análise!');
      End;

    End

    Else If (Sender = dbePeriod) Then
    Begin

      If dbePeriod.Enabled Then
      Begin
        If fEmptyStr(dbePeriod.Text) Then
        Begin
          dbePeriod.Field.Value := 0;
        End;

        If fStrToFloat(dbePeriod.Text) < 1 Then
        Begin
          Result := False;
          pMensagemOk('A Periodicidade deve ser maior ou igual a 1!');
        End;
      End;

    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadAnalise.pQryAfterOpen(DataSet: TDataSet);
begin
  qryTabela.FieldByName('ANA_TIPRES').OnGetText := pOnGetTextTipRes;
  qryTabela.FieldByName('ANA_TIPRES').OnSetText := pOnSetTextTipRes;
end;

procedure TfrmCadAnalise.pOnGetTextTipRes(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.AsInteger > 0 then
    Text := ARR_TIPRESANA[Sender.AsInteger]
  Else
    Text := '';

end;

procedure TfrmCadAnalise.pOnSetTextTipRes(Field: TField; const Text: String);
begin
  Case fStringToTipoResultadoAnalise(Text) of
    traNull             : Field.Clear;
    traIntervaloValores : Field.AsInteger := 1;
    traDescricaoAberta  : Field.AsInteger := 2;
  end;
end;

end.
