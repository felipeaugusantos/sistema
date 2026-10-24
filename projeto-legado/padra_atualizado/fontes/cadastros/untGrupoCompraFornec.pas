unit untGrupoCompraFornec;

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
  strUtils;

Type

  TGrupoCompraFornecedor = Class(TZClient)
    Private

      Function fSQLGrupos: String;
      Function fIncluiLinha(strCodGru: String): Boolean;

    Public
      constructor Create(Owner: TComponent); Reintroduce;

      Procedure pExcluiGrupo;
      function fCarregaGrupos(strCodFor: String): Boolean;
      Function fSalvaGrupos(strCodFor: String): Boolean;
      function fIncluiGrupo(strCodGru, strDesGru: String; blnMsgErro: Boolean = True): Boolean;
  End;


implementation

uses untFuncoesSimples;

constructor TGrupoCompraFornecedor.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLGrupos);

End;

Function TGrupoCompraFornecedor.fSQLGrupos: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   G.*,  ';
  Result := Result + '   (SELECT GRU_DESGRU FROM CADGRU WHERE GRU_CODGRU = GRF_CODGRU) AS GRU_DESGRU ';
  Result := Result + ' FROM ';
  Result := Result + '   COTGRU G ';
  Result := Result + ' WHERE ';
  Result := Result + '   G.GRF_CODFOR = :CODFOR ';
End;

function TGrupoCompraFornecedor.fCarregaGrupos(strCodFor: String): Boolean;
Begin
  Try
    With qryQuery Do
    Begin
      Sql.Text := fSQLGrupos;
      ParamByName('CODFOR').AsString := strCodFor;
      Result := fAbreClient(True, 'TGrupoCompraFornecedor.fCarregaGrupos');

      FieldByName('GRU_DESGRU').ProviderFlags := [];

      pAlinhaCampoCentro('GRF_CODGRU');
    End;

    FieldByName('GRF_CODGRU').EditMask := '999.999;0;';

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TGrupoCompraFornecedor.fCarregaGrupos]');
    End;
  End;
End;

Function TGrupoCompraFornecedor.fSalvaGrupos(strCodFor: String): Boolean;
Begin
  Try
    DisableControls;
    First;
    Result := True;

    While Not Eof Do
    Begin

      If fEmptyStr(FieldbyName('GRF_CODFOR').AsString) Then
      Begin
        Edit;
        FieldbyName('GRF_CODFOR').AsString := strCodFor;
        FieldbyName('AUTOINCREM').AsString := fRetAutoIncrem('COTGRU', VS_strCodEmp);
        Post;
      End;

      Next;
    End;

    Result := Result And fSalva;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TGrupoCompraFornecedor.fSalvaGrupos]');
    End;
  End;

  EnableControls;
End;

Procedure TGrupoCompraFornecedor.pExcluiGrupo;
Begin
  If (Not IsEmpty) And fPergunta('Confirma a exclusão do grupo ' + FieldbyName('GRU_DESGRU').AsString + '?') Then
    Delete;
End;

Function TGrupoCompraFornecedor.fIncluiGrupo(strCodGru, strDesGru: String; blnMsgErro: Boolean = True): Boolean;
Begin
  Result := False;

  If fEmptyStr(strCodGru) Then
    Exit;

  If SameText(RightStr(strCodGru, 3), '000') Then
  Begin

    If fPergunta('Não é permitido incluir uma linha. Deseja incluir todos os grupos dessa linha?') Then
      Result := fIncluiLinha(strCodGru);

  End

  Else If Locate('GRF_CODGRU', strCodGru, []) Then
  Begin

    If blnMsgErro Then
      pMensagemOk('Grupo ' + strCodGru + ' já incluido!');

    Result := False;

  End Else
  Begin
    Append;
    FieldByName('GRF_CODGRU').AsString := strCodGru;
    FieldByName('GRU_DESGRU').AsString := strDesGru;
    Post;

    Result := True;
  End;

End;

Function TGrupoCompraFornecedor.fIncluiLinha(strCodGru: String): Boolean;
  Var
    qryCadGru: TUniQuery;
Begin
  DisableControls;

  qryCadGru := fCriaQuery;

  With qryCadGru, SQL Do
  Begin
    Add('SELECT GRU_CODGRU, GRU_DESGRU FROM CADGRU WHERE LEFT(GRU_CODGRU, 3) = :CODLIN ');

    ParamByName('CODLIN').AsString := LeftStr(strCodGru, 3);

    Open;

    While Not Eof Do
    Begin

      If Not SameText(RightStr(FieldByName('GRU_CODGRU').AsString, 3), '000') Then
        fIncluiGrupo(FieldByName('GRU_CODGRU').AsString, FieldByName('GRU_DESGRU').AsString, False);

      Next;
    End;

  End;
  FreeAndNil(qryCadGru);

  Result := True;

  EnableControls;
End;

end.
