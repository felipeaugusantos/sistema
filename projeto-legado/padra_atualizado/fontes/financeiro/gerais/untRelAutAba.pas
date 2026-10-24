unit untRelAutAba;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint;

Type
  TRelAutAba = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FCadAutAba: TUniClientDataSet;
      FCadEmp_: TUniQuery;
      FListaFuncoes: TStringList;
      FDataSetEmp: TfrxDBDataset;
      FDataSetCadAutAba: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      function fGetIsEmpty: Boolean;
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      procedure pIniciaObjetos;
    protected
      function fGetKey: String;
      function fGetName: String;
      function fGetDBDataSets: TArrFrxDBDataSet;
      function fGetUserDataSets: TArrFrxUserDataSet;
      function fGetFunctionsList: TStringList;
      function fGetVariables: TDictionary<String,Variant>;
      function fGetUserFunction: TfrxUserFunctionEvent;
      function fPrepareDataSetsAndVariables: Boolean;
      function fGetPrinterName: String;
      function fGetFastType: TFastFileType;
      procedure pConfigTypeAndPrinterName;
    public
      constructor Create;
      constructor CreateInstance(cdsAutAba: TUniClientDataSet);
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
  end;

  function fCriaClientDatasetRelAutAba: TUniClientDataSet;

Const
  FILA_IMPRESSAO_AUTABA = 'impressao_autaba';

implementation

uses untCfgRel, untValorPorExtenso;

{ TRelAutAba }

constructor TRelAutAba.Create;
begin
  FModoDesigner := True;

  FPais   := fSetaPais;
  FCadAutAba := fCriaClientDatasetRelAutAba;

  With FCadAutAba Do
  Begin
    Append;
    FieldByName('ABA_CODEMP').AsString   := '001';
    FieldByName('ABA_DTAEMI').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('ABA_SEQABA').AsString   := '123456';
    FieldByName('ABA_CODFOR').AsString   := '12345678';
    FieldByName('ABA_PLAVEI').AsString   := 'BMW2868';
    FieldByName('ABA_COMBUS').AsString   := 'Diesel';
    FieldByName('ABA_CODMOT').AsString   := '12345';
    FieldByName('ABA_KM_VEI').AsString   := '7885';

    FieldByName('DESVEI').AsString   := 'BMW 4X4 PRETO';
    FieldByName('NOMFOR').AsString   := 'Fornecedor Teste';
    FieldByName('NOMMOT').AsString   := '12345';
    FieldByName('NOMEMP').AsString   := 'Empresa Teste';

    FieldByName('ABA_QTDLTS').AsFloat:= 50;
    FieldByName('ABA_VLRABA').AsFloat:= 100;
    Post;
  End;

  pIniciaObjetos;
end;

constructor TRelAutAba.CreateInstance(cdsAutAba: TUniClientDataSet);
begin
  FModoDesigner := False;

  FCadAutAba      := TUniClientDataSet.Create(Nil);
  FCadAutAba.Data := cdsAutAba.Data;

  pIniciaObjetos;
end;

procedure TRelAutAba.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetCadAutAba := TfrxDBDataset.Create(nil);
  FDataSetCadAutAba.Name := 'frxDataSetAutAba';
  FDataSetCadAutAba.DataSet := FCadAutAba;

  FCadEmp_ := fCriaQuery(nil);
  FDataSetEmp := TfrxDBDataset.Create(nil);
  FDataSetEmp.Name := 'frxDataSetEmpresa';
  FDataSetEmp.DataSet := FCadEmp_;

  SetLength(FArrDBDataSet, 2);
  FArrDBDataSet[0] := FDataSetEmp;
  FArrDBDataSet[1] := FDataSetCadAutAba;

  pDefineFilaImpressao(False);
end;

destructor TRelAutAba.Destroy;
begin
  FreeAndNil(FCadAutAba);
  FreeAndNil(FDataSetCadAutAba);
  FreeAndNil(FCadEmp_);
  FreeAndNil(FDataSetEmp);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TRelAutAba.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fRetornaDescricaoVeic(strPlaVei: String): String;');
  FListaFuncoes.Add('function fRetNomFornecedor(strCodFor: String): String;');
  FListaFuncoes.Add('function fRetNomeMotorista(strCodMot: String): String;');
  FListaFuncoes.Add('function fRetNomeEmpresaSelec(strCodEmp: String): String');
  FListaFuncoes.Add('function fTiraCaracEspeciaisPonto(strTexto: String): String;');
  FListaFuncoes.Add('function fRemoveAcento(Str:String): String;');
end;

procedure TRelAutAba.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRelAutAba.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_AUTABA);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_AUTABA);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

function TRelAutAba.fOnUserFunctionEvent(
  const MethodName: String; var Params: Variant): Variant;
begin
  If SameText('fRetornaDescricaoVeic', MethodName) Then
    Result := fRetornaDescricaoVeic(Params[0]);

  If SameText('fRetNomFornecedor', MethodName) Then
    Result := fRetNomFornecedor(Params[0]);

  If SameText('fRetNomeMotorista', MethodName) Then
    Result := fRetNomeMotorista(Params[0]);

  If SameText('fRetNomeEmpresaSelec', MethodName) Then
    Result := fRetNomeEmpresaSelec(Params[0]);

  If SameText('fTiraCaracEspeciaisPonto', MethodName) Then
    Result := fTiraCaracEspeciaisPonto(Params[0]);

  If SameText('fRemoveAcento', MethodName) Then
    Result := fRemoveAcento(Params[0]);
end;

function TRelAutAba.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TRelAutAba.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TRelAutAba.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TRelAutAba.fGetIsEmpty: Boolean;
begin
  Result := FCadAutAba.IsEmpty;
end;

function TRelAutAba.fGetKey: String;
begin
  Result := 'AUTABA';
end;

function TRelAutAba.fGetName: String;
begin
  Result := 'AUTORIZAÇÃO DE ABASTECIMENTO';
end;

function TRelAutAba.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRelAutAba.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRelAutAba.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRelAutAba.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TRelAutAba.fPrepareDataSetsAndVariables: Boolean;

  procedure pCarregaVariaveis;
  begin
    FDicVar.AddOrSetValue('VS_Date', VS_Date);
    FDicVar.AddOrSetValue('VS_strCodEmp', VS_strCodEmp);
    FDicVar.AddOrSetValue('LOGOTIPO', fCfgSis('PATLOG'));
    FDicVar.AddOrSetValue('strLoginUsuarioLogado', strLoginUsuarioLogado);
    FDicVar.AddOrSetValue('strEmpAcessoUsuarioLogado', strEmpAcessoUsuarioLogado);
  end;

  procedure pCarregaDadosEmpresa;
  begin
    fCadEmp('NOMEMP', FCadEmp_);
  end;

begin

  With FCadAutAba Do
  Begin
    First;
    While Not Eof Do
    Begin
      Next;
    End;
    First;

    Result := Not IsEmpty;

  End;

  pCarregaVariaveis;
  pCarregaDadosEmpresa;
  pCarregaListaFuncoes;

end;



function fCriaClientDatasetRelAutAba: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_CODEMP';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_DTAEMI';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_SEQABA';
    DataType := ftString;
    Size     := 6;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_CODFOR';
    DataType := ftString;
    Size     := 8;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_PLAVEI';
    DataType := ftString;
    Size     := 8;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_COMBUS';
    DataType := ftString;
    Size     := 8;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_CODMOT';
    DataType := ftString;
    Size     := 5;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_QTDLTS';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_VLRABA';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ABA_KM_VEI';
    DataType := ftString;
    Size     := 8;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DESVEI';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOMFOR';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOMMOT';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOMEMP';
    DataType := ftString;
    Size     := 100;
  end;

  Result.CreateDataSet;

end;

end.
