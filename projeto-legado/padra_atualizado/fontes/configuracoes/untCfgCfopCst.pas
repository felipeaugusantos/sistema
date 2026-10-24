unit untCfgCfopCst;

interface

Uses
  Classes,
  untZClient,
  DB,
  CxProgressBar;

Type
  TCfgCfopCst = Class(TZClient)
  Private

    Function fSQLDados: String;

    Procedure pBeforePost(dataSet: TDataSet);

  Public
    blnIsentas,
    blnEntrada: Boolean;

    constructor Create(Owner: TComponent; blnEhEntrada: Boolean); Reintroduce; Overload;

    Destructor Destroy; override;

    Function fCarregaDados: Boolean;

    Function fSalvaDados: Boolean;

    Function fIncluiExcecao(strCFOP, strCST, strOpcao: String): Boolean;

    Function fExcluiExcecao: Boolean;

    Function fExcecaoDefinida(strCFOP, strCST: String): Boolean;

  End;

implementation

Uses
  SysUtils,
  untGravando,
  untFuncoesSimples,
  untFuncoesRel;

constructor TCfgCfopCst.Create(Owner: TComponent; blnEhEntrada: Boolean);
Begin
  blnEntrada := blnEhEntrada;

  Inherited Create(Owner, fSQLDados);
  Self.IndexFieldNames := 'CFG_CODCFO;CFG_CODCST';
  Self.BeforePost := pBeforePost;
End;

Destructor TCfgCfopCst.Destroy;
Begin

  Inherited;
End;

Function TCfgCfopCst.fSQLDados: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                      ';
  strSQL := strSQL + '   C.*,                      ';
  strSQL := strSQL + '   CASE C.CFG_ISEOUT         ';
  strSQL := strSQL + '     WHEN "O" THEN "Outras"  ';
  strSQL := strSQL + '     WHEN "I" THEN "Isentas" ';
  strSQL := strSQL + '   END AS OPCAO ';
  strSQL := strSQL + ' FROM            ';
  strSQL := strSQL + '   CFOPCST C      ';
  strSQL := strSQL + ' WHERE           ';
  strSQL := strSQL + '   CFG_CODEMP =  ' + QuotedStr(VS_strCodEmp);

  If blnEntrada Then
    strSQL := strSQL + '   AND CFG_CODCFO < "5000" '
  Else
    strSQL := strSQL + '   AND CFG_CODCFO >= "5000" ';

  Result := strSQL;
End;

Function TCfgCfopCst.fCarregaDados: Boolean;
Begin
  Result := fLeDados('TCfgCfopCst.fCarregaOpcoes');
End;

Function TCfgCfopCst.fSalvaDados: Boolean;
  Var
    strAutInc: String;
Begin
  Self.DisableControls;

  Try
    Self.Filter   := 'AUTOINCREM IS NULL';
    Self.Filtered := True;

    strAutInc := fRetAutoIncrem('CFOPCST', VS_strCodEmp, Self.RecordCount);
    Self.First;
    While Not Self.Eof Do
    Begin
      Self.Edit;
      Self.FieldByName('CFG_CODEMP').AsString := VS_strCodEmp;
      Self.FieldByName('AUTOINCREM').AsString := strAutInc;
      Self.Post;

      strAutInc := fNextAutoIncrem(strAutInc);
    End;

    Result := Self.fSalva;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCfgCfopCst.fSalvaDados]');
    End;
  End;

  Self.Filtered := False;
  Self.EnableControls;
End;

Function TCfgCfopCst.fIncluiExcecao(strCFOP, strCST, strOpcao: String): Boolean;
Begin
  If Self.FindKey([strCFOP, strCST]) Then
    Self.Edit
  Else
    Self.Append;

  Self.FieldByName('CFG_CODCFO').AsString := strCFOP;
  Self.FieldByName('CFG_CODCST').AsString := strCST;
  Self.FieldByName('OPCAO').AsString := strOpcao;

  Self.Post;

  Result := True;
End;

Function TCfgCfopCst.fExcluiExcecao: Boolean;
Begin
  Result := False;
  If Self.IsEmpty Then
    Exit;

  If Not fPergunta('Confirma a exclusão da exceção CFOP/CST ' + Self.FieldByName('CFG_CODCFO').AsString + '/' + Self.FieldByName('CFG_CODCST').AsString + '?') Then
    Exit;

  Self.Delete;

  Result := True;
End;

Procedure TCfgCfopCst.pBeforePost(dataSet: TDataSet);
Begin
  If SameText(Self.FieldByName('OPCAO').AsString, 'ISENTAS') Then
    Self.FieldByName('CFG_ISEOUT').AsString := 'I'
  Else
    Self.FieldByName('CFG_ISEOUT').AsString := 'O';
End;

Function TCfgCfopCst.fExcecaoDefinida(strCFOP, strCST: String): Boolean;
Begin
  Result := Self.FindKey([strCFOP, strCST]);

  If Result Then
    blnIsentas := SameText(Self.FieldByName('CFG_ISEOUT').AsString, 'I');
End;

end.
