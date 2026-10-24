unit untRelFechamentoRcx;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint;

Type
  TRelFechamentoRcx = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FCadRcxx: TUniClientDataSet;
      FCadEmp_: TUniQuery;
      FListaFuncoes: TStringList;
      FDataSetEmp: TfrxDBDataset;
      FDataSetCadRcxx: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      function fGetIsEmpty: Boolean;
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      function fFormataCpfCgcInterna(strValor: String): String;
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
      constructor CreateInstance(cdsRecibo: TUniClientDataSet);
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
  end;

  function fCriaClientDatasetTFechamentoRcx: TUniClientDataSet;

Const
  FILA_IMPRESSAO_FECHAMENTO_RCX = 'impressao_fechamento_rcx';

implementation

uses untCfgRel, untValorPorExtenso;

{ TRelFechamentoRcx }

constructor TRelFechamentoRcx.Create;
begin
  FModoDesigner := True;
  FPais := fSetaPais;
  FCadRcxx := fCriaClientDatasetTFechamentoRcx;

  With FCadRcxx Do
  Begin
    Append;
    FieldByName('RCX_CODCLI').AsString   := '59920000';
    FieldByName('RCX_CODOPE').AsString   := '123';
    FieldByName('RCX_NOMOPE').AsString   := 'ROBERTO CARLOS DA SILVA';
    FieldByName('RCX_NUMDOC').AsString   := '180220200000';
    FieldByName('RCX_ESPDOC').AsString   := 'NF';
    FieldByName('RCX_CODEMP').AsString   := '001';
    FieldByName('RCX_DTACAD').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('RCX_HORCAD').AsDateTime := fTime();
    FieldByName('RCX_NUMDUP').AsString   := '180220200000';
    FieldByName('RCX_PARCEL').AsString   := 'A';
    FieldByName('RCX_DESCRI').AsString   := 'DESCRIÇÃO GENERICA';
    FieldByName('RCX_IDEFEC').AsString   := 'X';
    FieldByName('RCX_VALDOC').AsFloat    := 358.56;
    FieldByName('RCX_VALJUR').AsFloat    := 56.32;
    FieldByName('RCX_VALDES').AsFloat    := 6.32;
    FieldByName('RCX_DINREC').AsFloat    := 532.35;
    FieldByName('RCX_CHQAVI').AsFloat    := 85.98;
    FieldByName('RCX_CHQPRE').AsFloat    := 85.65;
    FieldByName('RCX_CARREC').AsFloat    := 98.65;
    FieldByName('RCX_VALCRE').AsFloat    := 78.65;
    FieldByName('RCX_OUTROS').AsFloat    := 23.25;
    FieldByName('RCX_VENPRZ').AsFloat    := 65.98;
    FieldByName('RCX_JURDES').AsString   := 'J';
    FieldByName('RCX_CODFPG').AsString   := '001';
    FieldByName('RCX_NUMROM').AsString   := '123';
    FieldByName('RCX_SEQCON').AsFloat    := 10065175;
    FieldByName('RCX_ORDREC').AsFloat    := 56.35;
    FieldByName('RCX_SEQBAI').AsFloat    := 0;
    FieldByName('RCX_SQFCRX').AsFloat    := 1;
    FieldByName('RCX_MOTDES').AsString   := 'INFORMAÇÃO GENÉRICA';
    FieldByName('RCX_EMPDUP').AsString   := '001';
    FieldByName('RCX_IDECAI').AsString   := '2';
    FieldByName('RCX_VALFIN').AsFloat    := 768.05;
    FieldByName('RCX_TOTPES').AsFloat    := 78.05;
    FieldByName('RCX_TOTDOL').AsFloat    := 8.05;
    FieldByName('RCX_TOTEUR').AsFloat    := 38.05;
    FieldByName('RCX_TOTGUA').AsFloat    := 95.05;
    FieldByName('RCX_TOTREA').AsFloat    := 68.05;
    FieldByName('RCX_TFCANC').AsString   := 'N';
    FieldByName('RCX_ID_LOC').AsString   := 'INFORMAÇÃO GENÉRICA';
    FieldByName('RCX_ID_DOC').AsString   := 'INFORMAÇÃO GENÉRICA';
    FieldByName('RCX_MOTEST').AsString   := '123';
    FieldByName('RCX_CODCAX').AsString   := '00001';
    FieldByName('RCX_DTAGRV').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('RCX_LANFEC').AsString   := 'N';
    FieldByName('RCX_NUMLAC').AsString   := '123456787896542';
    FieldByName('RCX_FECDIV').AsString   := '59920000';
    FieldByName('RCX_FUNCAX').AsFloat    := 1200.00;
    FieldByName('RCX_VALDIV').AsFloat    := 235.25;
    FieldByName('RCX_OPELIB').AsString   := '998';
    FieldByName('RCX_DTALIB').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('RCX_OPEPER').AsString   := '998';
    FieldByName('RCX_DTAPER').AsDateTime := StrToDateTime('01/01/2000');
    Post;
  End;
  pIniciaObjetos;
end;

constructor TRelFechamentoRcx.CreateInstance(cdsRecibo: TUniClientDataSet);
begin
  FModoDesigner := False;

  FCadRcxx       := TUniClientDataSet.Create(Nil);
  FCadRcxx.Data  := cdsRecibo.Data;

  pIniciaObjetos;
end;

procedure TRelFechamentoRcx.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetCadRcxx := TfrxDBDataset.Create(nil);
  FDataSetCadRcxx.Name := 'frxDataSetFechamentoCaixa';
  FDataSetCadRcxx.DataSet := FCadRcxx;

  FCadEmp_ := fCriaQuery(nil);
  FDataSetEmp := TfrxDBDataset.Create(nil);
  FDataSetEmp.Name := 'frxDataSetEmpresa';
  FDataSetEmp.DataSet := FCadEmp_;

  SetLength(FArrDBDataSet, 2);
  FArrDBDataSet[0] := FDataSetEmp;
  FArrDBDataSet[1] := FDataSetCadRcxx;

  pDefineFilaImpressao(False);
end;

destructor TRelFechamentoRcx.Destroy;
begin
  FreeAndNil(FCadRcxx);
  FreeAndNil(FDataSetCadRcxx);
  FreeAndNil(FCadEmp_);
  FreeAndNil(FDataSetEmp);
  FreeAndNil(FDicVar);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TRelFechamentoRcx.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fFormataCpfCgcInterna(strValor: String): String;');
  FListaFuncoes.Add('function fFormataCEP(strCEP: String): String;');
  FListaFuncoes.Add('function fFormataFone(strFone: String): String;');
  FListaFuncoes.Add('function fRetExtensoNumero(Value : String):String;');
end;

procedure TRelFechamentoRcx.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRelFechamentoRcx.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_FECHAMENTO_RCX);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_FECHAMENTO_RCX);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);    
end;

function TRelFechamentoRcx.fOnUserFunctionEvent(
  const MethodName: String; var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fFormataCpfCgcInterna') Then
    Result := fFormataCpfCgcInterna(Params[0]);

  If SameText(MethodName, 'fFormataCEP') Then
    Result := fFormataCEP(Params[0]);

  If SameText(MethodName, 'fFormataFone') Then
    Result := fFormataFone(Params[0]);

  If SameText(MethodName, 'fRetExtensoNumero') Then
    Result := fRetExtensoNumero(Params[0]);
end;

function TRelFechamentoRcx.fFormataCpfCgcInterna(strValor: String): String;
begin
  Result := fFormataCpfCgc(strValor, FPais);
end;

function TRelFechamentoRcx.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TRelFechamentoRcx.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TRelFechamentoRcx.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TRelFechamentoRcx.fGetIsEmpty: Boolean;
begin
  Result := FCadRcxx.IsEmpty;
end;

function TRelFechamentoRcx.fGetKey: String;
begin
  If fCfgSis('FECRCX', varInteger) = 1 Then
    Result := 'FECRC1'
  Else
    Result := 'FECRC2';
end;

function TRelFechamentoRcx.fGetName: String;
begin
  If fCfgSis('FECRCX', varInteger) = 1 Then
    Result := 'RESUMO DE CAIXA - RELATÓRIO DE FECHAMENTO (FOLHA)'
  Else
    Result := 'RESUMO DE CAIXA - RELATÓRIO DE FECHAMENTO (40C)';
end;

function TRelFechamentoRcx.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRelFechamentoRcx.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRelFechamentoRcx.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRelFechamentoRcx.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TRelFechamentoRcx.fPrepareDataSetsAndVariables: Boolean;
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
  pCarregaVariaveis;
  pCarregaDadosEmpresa;
  pCarregaListaFuncoes;
  Result := True;
end;

function fCriaClientDatasetTFechamentoRcx: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_CODCLI';
    DataType := ftString;
    Size     := 8;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_CODOPE';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_NOMOPE';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_NUMDOC';
    DataType := ftString;
    Size     := 12;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_ESPDOC';
    DataType := ftString;
    Size     := 2;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_CODEMP';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_DTACAD';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_HORCAD';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_NUMDUP';
    DataType := ftString;
    Size     := 12;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_PARCEL';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_DESCRI';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_IDEFEC';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_VALDOC';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_VALDES';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_VALJUR';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_DINREC';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_CHQAVI';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_CHQPRE';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_CARREC';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_VALCRE';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_OUTROS';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_VENPRZ';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_JURDES';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_CODFPG';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_NUMROM';
    DataType := ftString;
    Size     := 6;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_SEQCON';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_ORDREC';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_SEQBAI';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_SQFCRX';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_MOTDES';
    DataType := ftString;
    Size     := 250;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_EMPDUP';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_IDECAI';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_VALDIM';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_TOTPES';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_TOTDOL';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_TOTEUR';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_TOTGUA';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_TOTREA';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_TFCANC';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_ID_LOC';
    DataType := ftString;
    Size     := 20;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_ID_DOC';
    DataType := ftString;
    Size     := 9;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_MOTEST';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_CODCAX';
    DataType := ftString;
    Size     := 5;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_DTAGRV';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_LANFEC';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_NUMLAC';
    DataType := ftString;
    Size     := 15;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_FECDIV';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_FUNCAX';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_VALDIV';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_OPELIB';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_DTALIB';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_OPEPER';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_DTAPER';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_VALFIN';
    DataType := ftFloat;
  end;

  Result.CreateDataSet;

end;

end.

