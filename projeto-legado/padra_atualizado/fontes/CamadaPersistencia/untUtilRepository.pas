{******************************************}
{* REPOSITORY DE UTILIDADES               *}
{* LOCAL DAS FUNCOES GENERICAS QUE        *}
{* UTILIZEM A CAMADA DE PERSISTÊNCIA      *}
{*17/06/2015****************************AF*}
unit untUtilRepository;

interface

uses SysUtils, untObjectManager, System.Generics.Collections, Aurelius.Mapping.Metadata,
  Aurelius.Mapping.Explorer, Aurelius.Mapping.Optimization, System.Rtti,
  Aurelius.Types.DynamicProperties, DB, Dialogs;

Type
  TUtil = class
  Public
    class procedure pClone(ASource, ADestin: TObject);
    class procedure pCriaCamposDataset(ASource: TObject; ADestin: TDataset);

    class function fRetTableName(obj: TObject): String;
    class function fMerge<E: Class>(obj: E): E;
  End;

implementation

{ TUtil }

{*******************}
{* CLONA UM OBJETO *}
{****************AF*}
class procedure TUtil.pClone(ASource, ADestin: TObject);
  Var
    I: Integer;
    Optimize: TList<TRttiOptimization>;
    blnCriou: Boolean;
    Value   : TValue;
Begin
  blnCriou  := False;
  frwk      := fCriaObjManager(blnCriou);

  Optimize := frwk.objDBManager.Explorer.GetClassStateMembers(ASource.ClassType, True, False);

  For I := 0 To Optimize.Count -1 Do
  Begin
//    Verificação se o campo existe comentado.
//    If frwk.objDBManager.Explorer.FindColumnByPropertyName(ADestin.ClassType, Optimize[I].MemberName) <> Nil Then
//    Begin
      Value := frwk.objDBManager.Explorer.GetMemberValue(ASource, Optimize[I]);
      frwk.objDBManager.Explorer.SetMemberValue(ADestin, Optimize[I], Value);
//    End;

  End;

  If blnCriou Then FreeAndNil(frwk);
end;

{************************************}
{* CRIA FIELDS DE ACORDO COM UM OBJ *}
{*********************************AF*}
class procedure TUtil.pCriaCamposDataset(ASource: TObject; ADestin: TDataset);
  Var
    I: Integer;
    Optimize: TList<TRttiOptimization>;
    blnCriou: Boolean;
Begin
  blnCriou  := False;
  frwk      := fCriaObjManager(blnCriou);

  Optimize := frwk.objDBManager.Explorer.GetClassVisibleMembers(ASource.ClassType, True);

  For I := 0 To Optimize.Count -1 Do
  Begin

    If (Pos('STRING', AnsiUpperCase(Optimize[I].MemberType.Name)) > 0) Then
    Begin
      With TStringField.Create(Nil) Do
      Begin FieldName := Optimize[I].MemberName; DataSet := ADestin; End;
    End

    Else If (Pos('INTEGER', AnsiUpperCase(Optimize[I].MemberType.Name)) > 0) Then
    Begin
      With TIntegerField.Create(Nil) Do
      Begin FieldName := Optimize[I].MemberName; DataSet := ADestin; End;
    End

    Else If (Pos('BOOLEAN', AnsiUpperCase(Optimize[I].MemberType.Name)) > 0) Then
    Begin
      With TBooleanField.Create(Nil) Do
      Begin FieldName := Optimize[I].MemberName; DataSet := ADestin; End;
    End

    Else If (Pos('TDATETIME', AnsiUpperCase(Optimize[I].MemberType.Name)) > 0) Or
            (Pos('DATE', AnsiUpperCase(Optimize[I].MemberType.Name)) > 0)      Or
            (Pos('TIME', AnsiUpperCase(Optimize[I].MemberType.Name)) > 0) Then
    Begin
      With TDateTimeField.Create(Nil) Do
      Begin FieldName := Optimize[I].MemberName; DataSet := ADestin; End;
    End

    Else If (Pos('DOUBLE', AnsiUpperCase(Optimize[I].MemberType.Name)) > 0) Or
            (Pos('FLOAT', AnsiUpperCase(Optimize[I].MemberType.Name)) > 0) Then
    Begin
      With TFloatField.Create(Nil) Do
      Begin FieldName := Optimize[I].MemberName; DataSet := ADestin; End;
    End

    Else If (Pos('BLOB', AnsiUpperCase(Optimize[I].MemberType.Name)) > 0) Then
    Begin
      With TBlobField.Create(Nil) Do
      Begin FieldName := Optimize[I].MemberName; DataSet := ADestin; End;
    End

    Else If (Pos('MEMO', AnsiUpperCase(Optimize[I].MemberType.Name)) > 0) Then
    Begin
      With TMemoField.Create(Nil) Do
      Begin FieldName := Optimize[I].MemberName; DataSet := ADestin; End;
    End;

  End;

  If blnCriou Then FreeAndNil(frwk);
End;

class function TUtil.fMerge<E>(obj: E): E;
  Var
    blnCriouObj: Boolean;
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
  Result := frwk.objDBManager.Merge<E>(obj);
  If blnCriouObj Then FreeAndNil(frwk);
end;

{*********************************}
{* PEGA O NOME DA TABELA MAPEADA *}
{* DO BANCO DE DADOS             *}
{******************************AF*}
class function TUtil.fRetTableName(obj: TObject): String;
  Var
    blnCriouObj: Boolean;
Begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
  Result := frwk.objDBManager.Explorer.GetTable(obj.ClassType).Name;
  If blnCriouObj Then FreeAndNil(frwk);
End;

end.
