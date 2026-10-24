unit untCadFornecedoresNeoGrid;

interface

Uses
  Classes,
  SysUtils,
  Controls,
  ComCtrls,
  DB,
  DBClient,
  Forms,
  Uni,
  untZClient,
  StrUtils,
  Math,
  frxClass,
  DBEditFocus,
  Variants,
  untFuncoesSimples;

Type
  TCadFornecedoresNeoGrid = Class(TZClient)

     Function fSQLDados: String;

  Public

      constructor Create(Owner: TComponent); Reintroduce;

      Destructor Destroy; override;

      Function fCarregaDados(strCodFor: String): Boolean;
      Function fSalvaDados(strCodFor, strPatArq: String): Boolean;
      Procedure pEdita;
  End;

implementation

constructor TCadFornecedoresNeoGrid.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLDados);
End;

Destructor TCadFornecedoresNeoGrid.Destroy;
Begin
  Inherited;

End;

Function TCadFornecedoresNeoGrid.fSQLDados: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT * FROM FORNEO';
  strSQL := strSQL + ' WHERE NEO_CODFOR = :CODFOR';
  Result := strSQL;
End;

Function TCadFornecedoresNeoGrid.fCarregaDados(strCodFor: String): Boolean;
Begin
  With qryQuery Do
  Begin
    ParamByName('CODFOR').AsString := strCodFor;
    Result := fAbreClient(True, 'TCadFornecedoresNeoGrid.fCarregaDados');
  End;

  TDateField(FieldByName('NEO_DTASEQ')).EditMask := '99/99/9999';
End;

Function TCadFornecedoresNeoGrid.fSalvaDados(strCodFor, strPatArq: String): Boolean;
Begin

  If Self.State In [dsEdit, dsInsert] Then
  Begin
    FieldByName('NEO_CODFOR').AsString := strCodFor;
    FieldByName('NEO_PATARQ').AsString := strPatArq;

    If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FORNEO', VS_strCodEmp);

    Post;

    Result := fSalva;
  End Else
  Begin
    Result := False;
    pMensagemOk('Erro interno. A Tabela Neogrid não está em edição!')
  End;

End;

Procedure TCadFornecedoresNeoGrid.pEdita;
Begin
  If Not (Self.State In [dsEdit, dsInsert]) Then
  Begin
    If IsEmpty Then
      Insert
    Else
      Edit;
  End;    
End;

end.

