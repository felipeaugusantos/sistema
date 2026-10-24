unit untCadFasesEquip;

interface

Uses
  Classes, SysUtils, Controls, DB,
  untFuncoesSimples, untZClient;

  Type
  TCadFasesEquip = Class(TZClient)
    Private

      Function fSQLEquipamentos: String;

    Public

      constructor Create(Owner: TComponent); Reintroduce; Overload;
      Destructor Destroy; override;

      Function fCarregaEquipamentos(strCodFas: String): Boolean;
      Function fIncluiEquipamento(strCodEqp: String): Boolean;
      Function fExcluiEquipamento: Boolean;
      Function fSalvaEquipamentos(strCodFas: String): Boolean;
      Function fTemEquipamento(strCodEqp: String): Boolean;
  End;

implementation

constructor TCadFasesEquip.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLEquipamentos);
End;

Function TCadFasesEquip.fSQLEquipamentos: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   F.*, ';
  Result := Result + '  (SELECT C.EQP_DESCRI FROM CADEQP C WHERE C.EQP_CODEQP = F.EQP_CODEQP) AS EQP_DESCRI ';
  Result := Result + ' FROM EQPFAS F         ';
  Result := Result + ' WHERE ';
  Result := Result + '   EQP_CODFAS = :CODFAS ';
End;

Function TCadFasesEquip.fCarregaEquipamentos(strCodFas: String): Boolean;
Begin
  Try
    With qryQuery Do
    Begin
      ParamByName('CODFAS').AsString := strCodFas;

      Result := fAbreClient(True, 'TCadFasesEquip.fCarregaEquipamentos');

      FieldByName('EQP_DESCRI').ProviderFlags := [];

    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TLocFisAdicionais.fCarregaLocalizacoes]');
    End;
  End;
End;

Function TCadFasesEquip.fIncluiEquipamento(strCodEqp: String): Boolean;
Begin
  Try
    If fEmptyStr(strCodEqp) Then
    Begin
      Result := False;
      pMensagemOk('Código do Equipamento em branco!');
    End

    Else If fTemEquipamento(strCodEqp) Then
    Begin
      Result := False;
      pMensagemOk('O Equipamento ' + strCodEqp + ' já existe!');
    End Else

    Begin
      Append;
      FieldByName('EQP_CODEQP').AsString := strCodEqp;
      FieldByName('EQP_DESCRI').AsString := fRetNomEquipamento(strCodEqp);
      Post;

      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadFasesEquip.fIncluiEquipamento]');
    End;
  End;
End;

Function TCadFasesEquip.fExcluiEquipamento: Boolean;
Begin
  Try

    If Not IsEmpty then
     Delete;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadFasesEquip.fExcluiEquipamento]');
    End;
  End;
End;

Function TCadFasesEquip.fSalvaEquipamentos(strCodFas: String): Boolean;
Begin
  Try
    DisableControls;
    First;

    While Not Eof Do
    Begin
      Edit;

      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EQPFAS', VS_strCodEmp);

      FieldByName('EQP_CODFAS').AsString := strCodFas;
      Post;

      Next;
    End;

    Result := fSalva;

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadFasesEquip.fSalvaEquipamentos]');
    End;
  End;

  EnableControls;
End;

Destructor TCadFasesEquip.Destroy;
Begin
  Inherited;

End;

Function TCadFasesEquip.fTemEquipamento(strCodEqp: String): Boolean;
Begin
  Result := Locate('EQP_CODEQP', strCodEqp, []);
End;

end.
