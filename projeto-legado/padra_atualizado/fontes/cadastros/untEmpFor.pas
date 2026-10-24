unit untEmpFor;

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
  cxGridDBTableView;

Type

  TEmpFornecedores = Class(TZClient)
    Private
      FForViw: TcxGridDBTableView;
      FCodEmp: String;

      Function fSQLFornecedores: String;
      function fFornecedorCadastrado(strCodFor: string): Boolean;
      function fFornecedorOutraEmpresa(strCodFor: String): Boolean;

      Procedure pBeforePost(dataSet: TDataSet);

    Public
      constructor Create(Owner: TComponent; cxgForViw: TcxGridDBTableView); Reintroduce;

      Procedure pExcluiFornecedor;
      function fCarregaFornecedores(strCodEmp: String): Boolean;
      Function fSalvaFornecedores(strCodEmp: String): Boolean;
  End;

implementation

uses untFuncoesSimples;

constructor TEmpFornecedores.Create(Owner: TComponent; cxgForViw: TcxGridDBTableView);
Begin
  Inherited Create(Owner, fSQLFornecedores);

  FForViw := cxgForViw;

  BeforePost := pBeforePost;
End;

Function TEmpFornecedores.fSQLFornecedores: String;
Begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '   F.*,  ';
  Result := Result + '   (SELECT FOR_NOMFOR FROM CADFOR WHERE FOR_CODFOR = F.EFR_CODFOR) AS NOMFOR  ';
  Result := Result + ' FROM ';
  Result := Result + '   EMPFOR F ';
  Result := Result + ' WHERE ';
  Result := Result + '   F.EFR_CODEMP = :CODEMP ';
End;

function TEmpFornecedores.fCarregaFornecedores(strCodEmp: String): Boolean;
Begin
  Try
    With qryQuery Do
    Begin
      FCodEmp := strCodEmp;
      
      Sql.Text := fSQLFornecedores;
      ParamByName('CODEMP').AsString := strCodEmp;
      Result := fAbreClient(True, 'TEmpFornecedores.fCarregaFornecedores');

      FieldByName('NOMFOR').ProviderFlags := [];
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEmpFornecedores.fCarregaFornecedores]');
    End;
  End;
End;

Function TEmpFornecedores.fSalvaFornecedores(strCodEmp: String): Boolean;
Begin
  Try
    DisableControls;
    First;
    Result := True;

    BeforePost := Nil;

    While Not Eof Do
    Begin

      If fFornecedorOutraEmpresa(FieldByName('EFR_CODFOR').AsString) Then
      begin
        Result := False;
        Break;
      End;

      If fEmptyStr(FieldbyName('EFR_CODEMP').AsString) Then
      Begin
        Edit;
        FieldbyName('EFR_CODEMP').AsString := strCodEmp;
        FieldbyName('AUTOINCREM').AsString := fRetAutoIncrem('EMPFOR', VS_strCodEmp);
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
      pMensagensErro(E.Message, '[TEmpFornecedores.fSalvaFornecedores]');
    End;
  End;

  EnableControls;
End;

Procedure TEmpFornecedores.pExcluiFornecedor;
Begin
  If (Not IsEmpty) And fPergunta('Confirma a exclusão do fornecedor ' + FieldbyName('EFR_CODFOR').AsString + ' ?') Then
    Delete;
End;

function TEmpFornecedores.fFornecedorCadastrado(strCodFor: string): Boolean;
  Var
    intRecordIndex: Integer;
begin
  Result := False;

  If Not Assigned(FForViw) Then
    Exit;

  With FForViw.DataController Do
  for intRecordIndex := 0 to RowCount - 1 do
  begin
    Result := SameText(DisplayTexts[intRecordIndex, 0], strCodFor)
      and (intRecordIndex <> FocusedRowIndex);
    If Result then
      Exit;
  end;
end;

function TEmpFornecedores.fFornecedorOutraEmpresa(strCodFor: String): Boolean;
  Var
    qryEmpFor: TUniQuery;
Begin
  qryEmpFor := fCriaQuery(Self);
  With qryEmpFor, SQL Do
  Begin
    Clear;
    Add('SELECT EFR_CODEMP FROM EMPFOR');
    Add('WHERE EFR_CODEMP <> :CODEMP AND');
    Add('      EFR_CODFOR =  :CODFOR    ');
    Add('LIMIT 1');

    ParamByName('CODEMP').AsString := FCodEmp;
    ParamByName('CODFOR').AsString := strCodFor;

    Open;

    If Not IsEmpty Then
    Begin
      Result := True;
      pMensagemOk('Fornecedor ' + strCodFor + ' já cadastrado para a empresa ' + FieldByName('EFR_CODEMP').AsString + '!');
    End

    Else Result := False;

  End;
  FreeAndNil(qryEmpFor);
End;

Procedure TEmpFornecedores.pBeforePost(dataSet: TDataSet);
  Var
    strNomFor: String;
Begin
  With dataSet Do
  Begin
    If fEmptyStr(FieldByName('EFR_CODFOR').AsString) Then
    Begin
      Cancel;
      Abort;
      Exit;
    End;

    FieldByName('EFR_CODFOR').AsString := fStrZero(FieldByName('EFR_CODFOR').AsString, 8);

    If fFornecedorCadastrado(FieldByName('EFR_CODFOR').AsString) Then
    begin
      pMensagemOk('Fornecedor já cadastrado!');
      Cancel;
      Abort;
      Exit;
    End;

    strNomFor := fRetNomFornecedor(FieldByName('EFR_CODFOR').AsString);

    If fEmptyStr(strNomFor)  Then
    begin
      pMensagemOk('Fornecedor não econtrado!');
      Cancel;
      Abort;
      Exit;
    End;

    If fFornecedorOutraEmpresa(FieldByName('EFR_CODFOR').AsString) Then
    begin
      Cancel;
      Abort;
      Exit;
    End;

    FieldByName('NOMFOR').AsString := strNomFor;

  End;
End;


end.
