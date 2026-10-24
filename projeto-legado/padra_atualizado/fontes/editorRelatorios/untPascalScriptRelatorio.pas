unit untPascalScriptRelatorio;

interface

Uses
  DB,
  Classes,
  UniClientDataSet,
  fs_ipascal, fs_iinterpreter, fs_itools,
  PontoEntrada.Script.Classes;

Type
  TPrimeiroTotal = Function(strNomCam: String): Variant Of Object;

  TTipoScript = (tscValidate, tscBeforePost);

  TDadosRelatorio = Class
  Private
    FDados: TUniClientDataSet;

  Public
    constructor Create(ADados: TUniClientDataSet);

    Function FieldByName(FieldName: String): TField;
  End;

  TPascalScriptRelatorio = Class(TfsPascalScript)
  Private
    FTipoScript: TTipoScript;

    FDados: TDadosRelatorio;
    FScript: String;
    FNovoValorCampo: Variant;

    FPrimeiroTotal,
    FTotalGeral: TPrimeiroTotal;

    Procedure pSetaPosicaoErro;

    Function pCallMethod(Instance: TObject; ClassType: TClass;
      const MethodName: String; Caller: TfsMethodHelper): Variant;

    procedure pRegisterMethods;

    Procedure pAdicinaParamsRelatorio;

    Function fErroCompilacao: String;

  Public
     intRecNo,
     intColunaErro,
     intLinhaErro: Integer;

     varNewValue: Variant;

     strMensagemAposMarcarTodos: String;

     constructor Create(AOwner: TComponent;
                        ADados: TUniClientDataSet;
                        AScript: String;
                        ANovoValorCampo: Variant;
                        APrimeiroTotal,
                        ATotalGeral: TPrimeiroTotal;
                        ATipoScript: TTipoScript); Reintroduce;

     destructor Destroy; override;

     Function fCompilaScript: Boolean;

     Class Function fCompila(strScript: String; tpsTipoScript: TTipoScript; Var intLinhaErro, intColunaErro: Integer): Boolean;

     Function fResult(blnCompila: Boolean): Boolean;
  End;

implementation

Uses
  SysUtils,
  Variants,
  untFuncoesSimples,
  PontoEntrada.Script.Interfaces;

constructor TPascalScriptRelatorio.Create(AOwner: TComponent;
                                          ADados:TUniClientDataSet;
                                          AScript: String;
                                          ANovoValorCampo: Variant;
                                          APrimeiroTotal,
                                          ATotalGeral: TPrimeiroTotal;
                                          ATipoScript: TTipoScript);
Begin
  inherited Create(AOwner);

  intColunaErro := 0;
  intLinhaErro  := 0;
  intRecNo      := 0;

  strMensagemAposMarcarTodos := '';

  FTipoScript := ATipoScript;

  FDados := TDadosRelatorio.Create(ADados);
  FScript := AScript;
  FNovoValorCampo := ANovoValorCampo;
  FPrimeiroTotal := APrimeiroTotal;
  FTotalGeral := ATotalGeral;

  pRegisterMethods;

  pAdicinaParamsRelatorio;
End;

destructor TPascalScriptRelatorio.Destroy;
Begin
  inherited;

  FreeAndNil(FDados);
End;

Procedure TPascalScriptRelatorio.pAdicinaParamsRelatorio;
  Var
    LParams: IfsPascalScriptParams;
    LClassInfo: IfsClassInfo;
    LObjDados: IfsObjectInfo;
Begin
  LObjDados := TfsObjectInfo.Create('Relatório', 'cdsDados', FDados);

  LParams := TfsPascalScriptParams.New
    .ScriptText(FScript)
    .AddObject(LObjDados);

  LClassInfo := TfsClassInfo.Create('TField', TField);
  LParams.AddClass(LClassInfo);

  LClassInfo := TfsClassInfo.Create('TDadosRelatorio', TDadosRelatorio);
  LParams.AddClass(LClassInfo);

  If FTipoScript = tscValidate Then
  Begin
    LParams.AddVariable(TfsVariableInfo.Create('Relatório', 'ResultValidate', 'Boolean', False));
    LParams.AddVariable(TfsVariableInfo.Create('Relatório', 'NewValue', 'Variant', FNovoValorCampo));
  End Else
  Begin
    LParams.AddVariable(TfsVariableInfo.Create('Relatório', 'strMensagemAposMarcarTodos', 'String', strMensagemAposMarcarTodos));
  End;

  Self.Params := LParams;
End;

procedure TPascalScriptRelatorio.pRegisterMethods;
begin
  If FTipoScript = tscValidate Then
  Begin
    fsGlobalUnit.AddMethod('function fPrimeiroTotalGrid(strCampo: String): Variant;', pCallMethod, 'ctOther');
    fsGlobalUnit.AddMethod('function fTotalGeralGrid(strCampo: String): Variant;', pCallMethod, 'ctOther');
  End;

  fsGlobalUnit.AddMethod('function fCfgSis(strCamCfg: String; strCodEmp: String = ''): Variant;', pCallMethod, 'ctOther');
end;

Function TPascalScriptRelatorio.pCallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  If SameText(MethodName, 'fPrimeiroTotalGrid') then
    Result := FPrimeiroTotal(Caller.Params[0])

  Else If SameText(MethodName, 'fTotalGeralGrid') then
    Result := FTotalGeral(Caller.Params[0])

  Else If SameText(MethodName, 'fCfgSis') then
    Result := fCfgSis(Caller.Params[0], varString, Caller.Params[1])
end;

Function TPascalScriptRelatorio.fResult(blnCompila: Boolean): Boolean;
Begin
  Try
    Result := False;

    If (Not blnCompila) Or Compile Then
    Begin
      objScript.Variables['strMensagemAposMarcarTodos'] := strMensagemAposMarcarTodos;
      Execute;

      If FTipoScript = tscValidate Then
      Begin
        Result := objScript.Variables['ResultValidate'];
        varNewValue := objScript.Variables['NewValue'];
      End Else
      Begin
        strMensagemAposMarcarTodos := objScript.Variables['strMensagemAposMarcarTodos'];

        If (Not strMensagemAposMarcarTodos.IsEmpty) And (intRecNo = 0) Then
          intRecNo := FDados.FDados.RecNo;

        Result := True;
      End;
    End

    Else pMensagemOk('Erro no definição do Relatório: ' + ErrorMsg);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TPascalScriptRelatorio.fResult');
      Result := False;
    End;
  End;
End;

Procedure TPascalScriptRelatorio.pSetaPosicaoErro;
Begin
  intColunaErro := objScript.ErrorPos.Split([':'])[1].ToInteger;
  intLinhaErro  := objScript.ErrorPos.Split([':'])[0].ToInteger;
End;

Function TPascalScriptRelatorio.fErroCompilacao: String;
Begin
  Result := Concat('Erro ao compilar: ',
                   objScript.ErrorMsg,
                   ' (linha: ', intLinhaErro.ToString,
                   ' coluna: ', intColunaErro.ToString, ')');
End;

Function TPascalScriptRelatorio.fCompilaScript: Boolean;
Begin
  Try
    Result := Compile;

    If Not Result Then
    Begin
      pSetaPosicaoErro;
      pMensagemOk(fErroCompilacao);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TPascalScriptRelatorio.fResult');
      Result := False;
    End;
  End;
End;

Class Function TPascalScriptRelatorio.fCompila(strScript: String;
                                               tpsTipoScript: TTipoScript;
                                               Var intLinhaErro, intColunaErro: Integer): Boolean;
  Var
    objScript: TPascalScriptRelatorio;
Begin
  If tpsTipoScript = tscBeforePost Then
  Begin
    If Pos('PMENSAGEMOK', UpperCase(strScript)) > 0 Then
    Begin
      Result := False;
      pMensagemOk('Procedure pMensagemOk não pode ser chamado no beforepost!');
      Exit;
    End;

    If Pos('FPERGUNTA', UpperCase(strScript)) > 0 Then
    Begin
      Result := False;
      pMensagemOk('Função fPergunta não pode ser chamada no beforepost!');
      Exit;
    End;

  End;

  objScript := TPascalScriptRelatorio.Create(Nil, Nil, strScript, Null, Nil, Nil, tpsTipoScript);

  Result := objScript.fCompilaScript;

  intLinhaErro  := objScript.intLinhaErro;
  intColunaErro := objScript.intColunaErro;

  FreeAndNil(objScript);
End;

constructor TDadosRelatorio.Create(ADados: TUniClientDataSet);
Begin
  FDados := ADados;
End;

Function TDadosRelatorio.FieldByName(FieldName: String): TField;
Begin
  Result := FDados.FieldByName(FieldName);
End;

end.
