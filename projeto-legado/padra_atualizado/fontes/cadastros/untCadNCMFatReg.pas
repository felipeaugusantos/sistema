unit untCadNCMFatReg;

interface

Uses
  Classes,
  SysUtils,
  Controls,
  DB,
  UniClientDataSet,
  Forms,
  Uni,
  untZClient,
  cxEdit,
  cxGridDBTableView,
  cxGridCustomTableView,
  Winapi.Windows;

type
  TCadNcmFatReg = class(TZClient)
    private
      FOwner: TWinControl;
      FView: TcxGridDBTableView;

      procedure pOnViewEditKeyDown(Sender: TcxCustomGridTableView;
        AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
        Shift: TShiftState);

      procedure pOnViewEditKeyPress(Sender: TcxCustomGridTableView;
        AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);

      function fNCMCadastrado(strCodigo: string): Boolean;
      function fPesquisarNCM(Var strCodigo, strDescricao: String): Boolean;
      function fDescricaoNCM(strCodigo: String): String;
      function fSQLNCM: String;
      function fNCMCadastradoEmOutroFatorRegional(strCodigo: string): Boolean;
      procedure pBeforePost(dataSet: TDataSet);

    public
      constructor Create(Owner: TWinControl; cxgView: TcxGridDBTableView); reintroduce;

      procedure pExcluiNCM;
      function fCarregaNCM(strCodFatReg: String): Boolean;
      function fSalvaNCM(strCodFatReg: String): Boolean;
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{ TCadNcmFatReg }

function TCadNcmFatReg.fNCMCadastrado(strCodigo: string): Boolean;
Var
  intRecordIndex: Integer;
begin
  Result := False;

  If Not Assigned(FView) Then
    Exit;

  For intRecordIndex := 0 to FView.DataController.RowCount - 1 do
  begin
    Result := SameText(FView.DataController.DisplayTexts[intRecordIndex, 0], strCodigo)
      and (intRecordIndex <> FView.DataController.FocusedRowIndex);
    If Result then
      Exit;
  end;

  Result := fNCMCadastradoEmOutroFatorRegional(strCodigo);
end;

function TCadNcmFatReg.fNCMCadastradoEmOutroFatorRegional(
  strCodigo: string): Boolean;
var
  qryNCM: TUniQuery;
begin
  qryNCM := fCriaQuery;

  try
    Result := False;

    qryNCM.Close;
    qryNCM.SQL.Clear;
    qryNCM.SQL.Add('SELECT FRE_CODNCM');
    qryNCM.SQL.Add('FROM NCMFRE');
    qryNCM.SQL.Add('WHERE FRE_CODNCM = :CODNCM');
    qryNCM.SQL.Add('AND FRE_CODEMP = :CODEMP');

    qryNCM.ParamByName('CODNCM').AsString := strCodigo;
    qryNCM.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryNCM.Open;

    Result := not qryNCM.IsEmpty;
  finally
    FreeAndNil(qryNCM);
  end;
end;

constructor TCadNcmFatReg.Create(Owner: TWinControl;
  cxgView: TcxGridDBTableView);
begin
  Inherited Create(Owner, fSQLNCM);
  FOwner := Owner;
  FView := cxgView;
  FView.OnEditKeyDown := pOnViewEditKeyDown;
  FView.OnEditKeyPress := pOnViewEditKeyPress;

  BeforePost := pBeforePost;
end;

function TCadNcmFatReg.fCarregaNCM(strCodFatReg: String): Boolean;
begin
  Try
    qryQuery.Sql.Text := fSQLNCM;
    qryQuery.ParamByName('CODFRE').AsString := strCodFatReg;
    qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
    Result := fAbreClient(True, 'TCadFatReg.fCarregaNCM');

    qryQuery.FieldByName('FRE_DESNCM').ProviderFlags := [];
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadFatReg.fCarregaNCM]');
    End;
  End;
end;

function TCadNcmFatReg.fDescricaoNCM(strCodigo: String): String;
begin
  Result := fRetDescricaoNcm(strCodigo);
end;

function TCadNcmFatReg.fPesquisarNCM(var strCodigo,
  strDescricao: String): Boolean;
Var
  Key: Char;
  qryTab: TUniQuery;
  arrNCM: TConsultasArray;
begin
  Key := '?';
  qryTab := fCriaQuery(nil);
  Try
    Result := fPesqNCM((GetParentForm(FOwner) as TForm).Name, qryTab, Key, arrNCM);
    If Result Then
    Begin
      strCodigo := qryTab.FieldByName('NCM_CODNCM').AsString;
      strDescricao := fRetDescricaoNcm(qryTab.FieldByName('NCM_CODNCM').AsString);
    End;
  Finally
    FreeAndNil(qryTab);
  End;
end;

function TCadNcmFatReg.fSalvaNCM(strCodFatReg: String): Boolean;
begin
  Try
    DisableControls;
    First;
    Result := True;

    BeforePost := Nil;

    While Not Eof Do
    Begin

      If fEmptyStr(FieldbyName('FRE_CODFRE').AsString) Then
      Begin
        Edit;
        FieldbyName('FRE_CODFRE').AsString := strCodFatReg;
        FieldbyName('FRE_CODEMP').AsString := VS_strCodEmp;
        FieldbyName('AUTOINCREM').AsString := fRetAutoIncrem('NCMFRE', VS_strCodEmp);
        Post;
      End;

      Next;
    End;

    Result := Result And fSalva;

    BeforePost := pBeforePost;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadFatReg.fSalvaNCM]');
    End;
  End;

  EnableControls;
end;

function TCadNcmFatReg.fSQLNCM: String;
begin
  Result := ' SELECT * FROM NCMFRE WHERE FRE_CODFRE = :CODFRE AND FRE_CODEMP = :CODEMP ';
end;

procedure TCadNcmFatReg.pBeforePost(dataSet: TDataSet);
Var
  strDesNCM: String;
Begin
  If fEmptyStr(dataSet.FieldByName('FRE_CODNCM').AsString) Then
  Begin
    dataSet.Cancel;
    Abort;
  End;

  If fNCMCadastrado(dataSet.FieldByName('FRE_CODNCM').AsString) Then
  begin
    pMensagemOk('NCM já cadastrado para outro fator regional!');
    dataSet.Cancel;
    Abort;
  End;

  strDesNCM := Self.fDescricaoNCM(dataSet.FieldByName('FRE_CODNCM').AsString);

  If fEmptyStr(strDesNCM)  Then
  begin
    pMensagemOk('NCM não encontrado!');
    dataSet.Cancel;
    Abort;
  End;

  dataSet.FieldByName('FRE_DESNCM').AsString := strDesNCM;
End;

procedure TCadNcmFatReg.pExcluiNCM;
begin
  If (Not IsEmpty) And fPergunta('Confirma a exclusão do NCM "' + FieldbyName('FRE_DESNCM').AsString + '" ?') Then
    Delete;
end;

procedure TCadNcmFatReg.pOnViewEditKeyDown(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_RETURN: Begin
                 If Not Assigned(AItem) then
                   Exit;

                 If Not (AItem is TcxGridDBColumn) then
                   Exit;

                 If (AItem as TcxGridDBColumn).DataBinding.FieldName <> 'FRE_CODNCM' then
                   Exit;

                 Try
                   AItem.GridView.NavigatorButtons.Post.Click;
                 Finally
                   AItem.GridView.NavigatorButtons.Insert.Click;
                 End;
               End;
  End;
end;

procedure TCadNcmFatReg.pOnViewEditKeyPress(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
Var
  strCodigo: String;
  strDescricao: String;
begin
  inherited;

  If Not Assigned(AItem) then
    Exit;

  If Not (AItem is TcxGridDBColumn) then
    Exit;

  If (AItem as TcxGridDBColumn).DataBinding.FieldName <> 'FRE_CODNCM' then
    Exit;

  If Not fEntraCons(Key) Then
    Exit;

  Key := #0;

  If Not fPesquisarNCM(strCodigo, strDescricao) Then
    Exit;

  AItem.EditValue := strCodigo;

  If (AItem.Index + 1) < (AItem.GridView.ItemCount) then
    AItem.GridView.Items[AItem.Index + 1].EditValue := strDescricao;
end;

end.
