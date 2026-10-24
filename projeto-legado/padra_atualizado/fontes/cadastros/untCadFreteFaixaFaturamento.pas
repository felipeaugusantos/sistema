unit untCadFreteFaixaFaturamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Vcl.Grids, Vcl.DBGrids, Datasnap.Provider, Datasnap.DBClient, Uni,
  DBGridCitel, UniClientDataSet, UniDataSetProvider, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxCustomListBox,
  cxCheckListBox, cxDBCheckListBox, cxCheckBox;

type
  TfrmCadFreteFaixaFaturamento = class(TfrmPaiCad)
    dtsFreFai: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeCodFrg: TDBEditFocus;
    dbeDesFrg: TDBEditFocus;
    dtsFaixas: TDataSource;
    pnlFaixas: TPanel;
    Panel2: TPanel;
    dbnFaixas: TDBNavigator;
    dbgFaixas: TDBGridCitel;
    cdsFaixas: TUniClientDataSet;
    cdsFaixasFRD_SEQGER: TStringField;
    cdsFaixasAUTOINCREM: TStringField;
    cdsFaixasFRD_VALINI: TFloatField;
    cdsFaixasFRD_VALFIN: TFloatField;
    cdsFaixasFRD_VALFRE: TFloatField;
    clbTipFre: TcxDBCheckListBox;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cdsFaixas_BeforePost(DataSet: TDataSet);
    procedure cdsFaixas_AfterPost(DataSet: TDataSet);
    procedure cdsFaixas_AfterInsert(DataSet: TDataSet);
    procedure btnAlterarClick(Sender: TObject);
    procedure clbTipFreCheckStatesToEditValue(Sender: TObject;
      const ACheckStates: TcxCheckStates; out AEditValue: Variant);
    procedure clbTipFreEditValueToCheckStates(Sender: TObject;
      const AEditValue: Variant; var ACheckStates: TcxCheckStates);
    procedure cdsFaixasAfterEdit(DataSet: TDataSet);
    procedure cdsFaixasNewRecord(DataSet: TDataSet);
  private
    procedure pCarregaFaixas;
    procedure pExcluiFaixas(DataSet: TDataSet);
    procedure pIncluiFaixas(DataSet: TDataSet);
    procedure pIncluiUmaFaixa(DataSet: TDataSet; cdsFaixas: TClientDataSet);
    procedure pHabilitaFaixas(blnHab: Boolean);

    function fFaixasOk: Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public

  end;

implementation

uses
  untConsultas,
  untTypesSistema,
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadFreteFaixaFaturamento.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodFrg, dbeDesFrg, False);
  pHabilitaFaixas(True);
end;

procedure TfrmCadFreteFaixaFaturamento.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitaFaixas(False);
  pCarregaFaixas();
end;

procedure TfrmCadFreteFaixaFaturamento.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFreteFaixaFaturamento.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pHabilitaFaixas(False);
  pCarregaFaixas();
end;

procedure TfrmCadFreteFaixaFaturamento.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;


  try
    If cdsFaixas.State in [dsEdit, dsInsert] Then
      cdsFaixas.Post;
  except
    on E: EAbort do
      Exit;
  end;


  if qryTabela.FieldByName('FRG_TIPFRE').AsString = 'NNNNNN' then
  begin
    fMensagem('ATENÇÃO!', 'Selecionar ao menos um Tipo de Frete para Cálculo no faturamento!', ['&Ok']);
    pSetFocus(clbTipFre);
    Exit;
  end;

  if cdsFaixas.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Inserir ao menos uma Faixa de Frete!', ['&Ok']);
    cdsFaixas.Insert;
    Exit;
  end;

  if not fFaixasOk then
    Exit;

  Try
    Try
      inherited;
      pExcluiFaixas(qryTabela);
      pIncluiFaixas(qryTabela);

      If blnGravou Then
        fCommit()
      Else
        fRollBack;
    Except
      On E: Exception Do
      Begin
        fRollBack();
        pMensagensErro(E.Message, '[TfrmCadFreteFaixaFaturamento.btnGravarClick]');
      End;
    End;
  Finally
    pHabilitaFaixas(False);
  End;

end;

procedure TfrmCadFreteFaixaFaturamento.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodFrg, dbeDesFrg, Not blnUsaProCodigo);
  pCarregaFaixas();
  pHabilitaFaixas(True);

  qryTabela.FieldByName('FRG_TIPFRE').AsString := 'SNNNNN';
end;

procedure TfrmCadFreteFaixaFaturamento.btnPesquisaClick(Sender: TObject);
var
  arrAca : TConsultasArray;
  chrKey : Char;
begin
  inherited;

  chrKey := '/';
  If fPesqFreteFaixaFaturamento(Self, Nil, Nil, qryTabela, chrKey, arrAca) Then
  Begin
    pSetFocus(btnAlterar);
    pHabilitaFaixas(False);
    pCarregaFaixas();
  End;
end;

procedure TfrmCadFreteFaixaFaturamento.cdsFaixasAfterEdit(DataSet: TDataSet);
begin
  inherited;
  pSetFocus(dbgFaixas);
  dbgFaixas.SelectedField := cdsFaixasFRD_VALINI;
end;

procedure TfrmCadFreteFaixaFaturamento.cdsFaixasNewRecord(DataSet: TDataSet);
begin
  inherited;
  pSetFocus(dbgFaixas);
  dbgFaixas.SelectedField := cdsFaixasFRD_VALINI;
end;

procedure TfrmCadFreteFaixaFaturamento.cdsFaixas_AfterInsert(DataSet: TDataSet);
begin
  inherited;

  DataSet.FieldByName('FRD_SEQGER').AsString := '*';
  DataSet.FieldByName('AUTOINCREM').AsString := '*';
end;

procedure TfrmCadFreteFaixaFaturamento.cdsFaixas_AfterPost(DataSet: TDataSet);
begin
  inherited;
  With DataSet Do
  Begin
    If (FieldByName('FRD_VALINI').AsFloat = 0) And
       (FieldByName('FRD_VALFIN').AsFloat = 0) And
       (FieldByName('FRD_VALFRE').AsFloat = 0) Then
      Delete;
  End;
end;

procedure TfrmCadFreteFaixaFaturamento.cdsFaixas_BeforePost(DataSet: TDataSet);
begin
  If (DataSet.FieldByName('FRD_VALINI').AsFloat  < 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Valor Inicial da Faixa deve ser maior ou igual a zero', ['&Ok']);
    Abort;
    Exit;
  End;

  If (DataSet.FieldByName('FRD_VALFIN').AsFloat  < 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Valor Final da Faixa deve ser maior que zero', ['&Ok']);
    Abort;
    Exit;
  End;

  If (DataSet.FieldByName('FRD_VALFRE').AsFloat < 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Valor do Frete deve ser maior ou igual a zero', ['&Ok']);
    Abort;
    Exit;
  End;

  If (DataSet.FieldByName('FRD_VALFIN').AsFloat  = 0) And
     ((DataSet.FieldByName('FRD_VALFRE').AsFloat  <> 0) Or (DataSet.FieldByName('FRD_VALINI').AsFloat <> 0)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Valor Final da Faixa deve ser maior que zero', ['&Ok']);
    Abort;
    Exit;
  End;

  If (Not ((DataSet.FieldByName('FRD_VALINI').AsFloat = 0) And
           (DataSet.FieldByName('FRD_VALFIN').AsFloat = 0) And
           (DataSet.FieldByName('FRD_VALFRE').AsFloat = 0))) And
     (DataSet.FieldByName('FRD_VALFIN').AsFloat  <= DataSet.FieldByName('FRD_VALINI').AsFloat) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Valor Final da Faixa deve ser maior que o inicial', ['&Ok']);
    Abort;
    Exit;
  End;

  inherited;
end;

procedure TfrmCadFreteFaixaFaturamento.clbTipFreCheckStatesToEditValue(
  Sender: TObject; const ACheckStates: TcxCheckStates; out AEditValue: Variant);
var
  intIndice: Integer;
begin
  inherited;
  AEditValue := '';
  for intIndice := 0 to clbTipFre.Items.Count - 1 do
  begin
    if ACheckStates[intIndice] = cbsChecked then
      AEditValue := AEditValue + 'S'
    else
      AEditValue := AEditValue + 'N';
  end;
end;

procedure TfrmCadFreteFaixaFaturamento.clbTipFreEditValueToCheckStates(
  Sender: TObject; const AEditValue: Variant; var ACheckStates: TcxCheckStates);
var
  intIndice: Integer;
begin
  inherited;
  if AEditValue = Null then
    Exit;

  for intIndice := 0 to Length(AEditValue) - 1 do
  begin
    if VarToStr(AEditValue)[intIndice+1] = 'S' then
      ACheckStates[intIndice] := cbsChecked
    else
      ACheckStates[intIndice] := cbsUnChecked;
  end;
end;

function TfrmCadFreteFaixaFaturamento.fFaixasOk: Boolean;
var
  fltValFin: Double;
Begin
  Result := False;
  cdsFaixas.DisableControls;
  cdsFaixas.First;
  While Not cdsFaixas.Eof Do
  Begin
    fltValFin := cdsFaixas.FieldByName('FRD_VALFIN').AsFloat;

    cdsFaixas.Next;

    If Not cdsFaixas.Eof Then
    Begin
      fltValFin := fltValFin + 0.01;

      If (fltValFin > cdsFaixas.FieldByName('FRD_VALINI').AsFloat) Then
      Begin
        fMensagem('ATENÇÃO!', 'As Faixas estão em conflito.  O Valor Inicial de uma faixa deve ser um centavo maior que o Valor Final da anterior.', ['&Ok']);
        cdsFaixas.EnableControls;
        cdsFaixas.FieldByName('FRD_VALINI').FocusControl;
        cdsFaixas.Edit;
        Exit;
      end;

      If (fltValFin < cdsFaixas.FieldByName('FRD_VALINI').AsFloat) Then
      Begin
        fMensagem('ATENÇÃO!', 'As Faixas contém lacunas de valores. O Valor Inicial de uma faixa deve ser um centavo maior que o Valor Final da anterior.', ['&Ok']);
        cdsFaixas.EnableControls;
        cdsFaixas.FieldByName('FRD_VALINI').FocusControl;
        cdsFaixas.Edit;
        Exit;
      end;

    End;

  End;
  cdsFaixas.EnableControls;
  Result := True;
end;

procedure TfrmCadFreteFaixaFaturamento.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela := fCriaQuery(Self);
  strNomeTabela := 'CADFRG';
  dtsFreFai.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodFrg;

  strNomeCampo := 'FRG_CODFRG';
  cdsFaixas.CreateDataSet();
end;

procedure TfrmCadFreteFaixaFaturamento.FormShow(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodFrg, dbeDesFrg, False);
  pCarregaFaixas();
end;

function TfrmCadFreteFaixaFaturamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO DO FRETE              *}
    {**************************************LA*}
    If (Sender = dbeCodFrg) Then
    Begin
      If (fEmptyStr(dbeCodFrg.Text)) And (dbeCodFrg.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Frete deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
        begin
          pLimparCampos;
          pCarregaFaixas;
        end;
      End;
    End

    {*****************************************}
    {* VALIDA A DESCRICAO                    *}
    {**************************************LA*}
    Else If (Sender = dbeDesFrg) Then
    Begin
      If fEmptyStr(dbeDesFrg.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Frete deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadFreteFaixaFaturamento.pCarregaFaixas;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  Try
    cdsFaixas.EmptyDataSet();

    qryGen.SQL.Add('SELECT * FROM CADFRD WHERE FRD_SEQGER = :SEQGER');
    qryGen.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

    qryGen.Open();

    While (Not qryGen.Eof) Do
    Begin
      cdsFaixas.AppendRecord([qryGen.FieldByName('FRD_SEQGER').AsString,
                              qryGen.FieldByName('AUTOINCREM').AsString,
                              qryGen.FieldByName('FRD_VALINI').AsFloat,
                              qryGen.FieldByName('FRD_VALFIN').AsFloat,
                              qryGen.FieldByName('FRD_VALFRE').AsFloat]);
      qryGen.Next();
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadFreteFaixaFaturamento.pExcluiFaixas(DataSet: TDataSet);
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('DELETE FROM CADFRD');
    qryGen.SQL.Add('WHERE');
    qryGen.SQL.Add('FRD_SEQGER = :SEQGER');

    qryGen.ParamByName('SEQGER').AsString := DataSet.FieldByName('AUTOINCREM').AsString;

    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadFreteFaixaFaturamento.pHabilitaFaixas(blnHab: Boolean);
begin
  pnlFaixas.Enabled := blnHab;
  dbgFaixas.Enabled := blnHab;
  dbnFaixas.Enabled := blnHab;
  dbgFaixas.Refresh;

  clbTipFre.Enabled := blnHab;
end;

procedure TfrmCadFreteFaixaFaturamento.pIncluiFaixas(DataSet: TDataSet);
begin
  Try
    cdsFaixas.DisableControls;
    cdsFaixas.First;
    While Not cdsFaixas.Eof Do
    Begin
      pIncluiUmaFaixa(DataSet, cdsFaixas);
      cdsFaixas.Next;
    End;
  Finally
    cdsFaixas.EnableControls;
  End;
end;

procedure TfrmCadFreteFaixaFaturamento.pIncluiUmaFaixa(DataSet: TDataSet;
  cdsFaixas: TClientDataSet);
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('INSERT INTO CADFRD');
    qryGen.SQL.Add('(FRD_SEQGER,');
    qryGen.SQL.Add(' AUTOINCREM,');
    qryGen.SQL.Add(' FRD_VALINI,');
    qryGen.SQL.Add(' FRD_VALFIN,');
    qryGen.SQL.Add(' FRD_VALFRE)');
    qryGen.SQL.Add('VALUES ');
    qryGen.SQL.Add('(:SEQGER,');
    qryGen.SQL.Add(' :AUTOIN,');
    qryGen.SQL.Add(' :VALINI,');
    qryGen.SQL.Add(' :VALFIN,');
    qryGen.SQL.Add(' :VALFRE)');

    qryGen.ParamByName('SEQGER').AsString := DataSet.FieldByName('AUTOINCREM').AsString;
    qryGen.ParamByName('AUTOIN').AsString := fRetAutoIncrem('CADFRD', VS_strCodEmp);
    qryGen.ParamByName('VALINI').AsFloat  := cdsFaixas.FieldByName('FRD_VALINI').AsFloat;
    qryGen.ParamByName('VALFIN').AsFloat  := cdsFaixas.FieldByName('FRD_VALFIN').AsFloat;
    qryGen.ParamByName('VALFRE').AsFloat  := cdsFaixas.FieldByName('FRD_VALFRE').AsFloat;

    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadFreteFaixaFaturamento.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('FRG_CODFRG');
  stlCampos.Add('FRG_DESFRG');
  stlCampos.Add('FRG_CODEMP');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('FRG_CODFRG');
  stlCamInd.Add('FRG_DESFRG');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

end.
