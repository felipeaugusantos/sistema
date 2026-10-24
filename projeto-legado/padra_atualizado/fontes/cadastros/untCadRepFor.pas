unit untCadRepFor;

interface

Uses
  Classes, Uni, untZClient;

Type
  TCadRepFor = Class(TZClient)
    Private

      Function fSQLRepFor: String;

    Public

      constructor Create(Owner: TComponent); Reintroduce;
      Destructor Destroy; override;

      Function fCarregaRepresentante(strCodFor: String): Boolean;
      Function fSalvaRepresentante(strCodFor: String): Boolean;

      Procedure pLimpaCampos;
      Procedure pEdita;
  End;

implementation

uses UniClientDataSet, DB, untFuncoesGenerica, untFuncoesSimples;

Function TCadRepFor.fSQLRepFor: String;
Begin
  Result :=          'SELECT SQL_NO_CACHE           ';
  Result := Result + '  *                           ';
  Result := Result + 'FROM                          ';
  Result := Result + '  REPFOR                      ';
  Result := Result + 'WHERE                         ';
  Result := Result + '   REP_CODFOR = :CODFOR       ';
  Result := Result + ' LIMIT 1                      ';
End;

constructor TCadRepFor.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLRepFor);

End;

Destructor TCadRepFor.Destroy;
Begin
  Inherited;

End;

Function TCadRepFor.fCarregaRepresentante(strCodFor: String): Boolean;
Begin
  With qryQuery Do
  Begin
    ParamByName('CODFOR').AsString := strCodFor;
  End;

  Result := fAbreClient(True, 'TCadRepFor.pCarregaRepresentante');

  If Result And IsEmpty Then
    Insert;

  TStringField(FieldByName('REP_C_E_P_')).EditMask := '99999-999;0;_';
  TStringField(FieldByName('REP_FONE01')).EditMask := fRetMascaraFonePais;
  TStringField(FieldByName('REP_F_A_X_')).EditMask := fRetMascaraFonePais;
  TStringField(FieldByName('REP_NUMCEL')).EditMask := fRetMascaraFonePais;

  If (FieldByName('REP_CGCCPF').AsString = '1') Then
    FieldByName('REP_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else
    FieldByName('REP_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);

End;

Function TCadRepFor.fSalvaRepresentante(strCodFor: String): Boolean;
Begin
  If fEmptyStr(FieldByName('REP_CODFOR').AsString) Then
  Begin
    If Not (self.State In [dsEdit, dsInsert]) Then
      Self.Edit;

    FieldByName('REP_CODFOR').AsString := strCodFor;
    FieldByName('REP_CODEMP').AsString := VS_strCodEmp;
    FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('REPFOR', VS_strCodEmp);

    If self.State In [dsEdit, dsInsert] Then
      Post;

  End;

  Result := fSalva;
End;

Procedure TCadRepFor.pLimpaCampos;
Begin
  pLimpaDados('REP_CODFOR');
End;

Procedure TCadRepFor.pEdita;
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
