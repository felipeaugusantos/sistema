unit untRelCtrAgrupDupRecibo;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint;

Type
  TRelCtrAgrupDupRecibo = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FCtrAgrupDupRecibo: TUniClientDataSet;
      FCadRec: TUniClientDataSet;
      FDupJun: TUniClientDataSet;
      FGen: TUniClientDataSet;
      FListaFuncoes: TStringList;
      FDataSetCtrAgrupDupRecibo: TfrxDBDataset;
      FDataSetCadRec: TfrxDBDataset;
      FDataSetDupJun: TfrxDBDataset;
      FDataSetGen: TfrxDBDataset;
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
      constructor CreateInstance(cdsCtrAgrupDupRecibo: TUniClientDataSet);
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
      function fVerificaComponenteRelExiste(strComponente,
                                            strInformacao : String;
                                            blnVisible : Boolean = True) : Boolean;
      function fMontaVencimentos(strNumDoc, strEspDoc, strCodEmp: String): String;
      function fRetornaParcelasAgrupamento(ANumDup, ACodCli, ACodEmp : String): String;
      function fMontaEmissao(strNumDoc, strEspDoc, strCodEmp: String): String;
      function fRetQtdReg: Integer;
      function fMontaDataVenctoAgr(strNumDoc, strEspDoc, strCodEmp: String): String;
  end;

  function fCriaClientDatasetRelCtrAgrupDupRecibo: TUniClientDataSet;
  function fCriaClientDatasetCadRec: TUniClientDataSet;
  function fCriaClientDatasetDupJun: TUniClientDataSet;
  function fCriaClientDatasetGen: TUniClientDataSet;

Const
  FILA_IMPRESSAO_AG_CTR = 'frmAgrupDuplicatas';

implementation

uses untCfgRel, untValorPorExtenso;

{ TRelCtrAgrupDupRecibo}

constructor TRelCtrAgrupDupRecibo.Create;
begin
  FModoDesigner := True;

  FPais   := fSetaPais;
  FCtrAgrupDupRecibo := fCriaClientDatasetRelCtrAgrupDupRecibo;
  If fCfgSis('MODAGR', varInteger) = 2 Then
  Begin
    FCadRec := fCriaClientDatasetCadRec;
    FDupJun := fCriaClientDatasetDupJun;
  End;
  FGen := fCriaClientDatasetGen;

  With FCtrAgrupDupRecibo Do
  Begin
    Append;
    FieldByName('CTR_NUMDUP').AsString   := '20111901090001';
    FieldByName('CTR_PARCEL').AsString   := 'A';
    FieldByName('NUMDOC').AsString       := '201901090001-A-NF-001';
    FieldByName('NOMEMP').AsString       := '001-EMPRESA 001';
    FieldByName('NOMCLI').AsString       := '00059920-CLIENTE TESTE';
    FieldByName('CLI_CODCLI').AsString   := '00059920';
    FieldByName('CLI_NOMCLI').AsString   := 'CLIENTE TESTE';
    FieldByName('CLI_FANSOB').AsString   := 'CLIENTE TESTE';
    FieldByName('CLI_DESCON').AsFloat    := 12.87;
    FieldByName('CTR_CODEMP').AsString   := '001';
    FieldByName('CTR_DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CTR_DTACAD').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CTR_VALDUP').AsFloat    := 50;
    FieldByName('CTR_VALORI').AsFloat    := 50;
    FieldByName('CTR_TOTJUR').AsFloat    := 25;
    FieldByName('CTR_NUMAGR').AsString   := '000000141005';
    FieldByName('CTR_EMPAGR').AsString   := '001';
    FieldByName('CTR_CONPAG').AsString   := '02030060';
    FieldByName('CTR_HIST01').AsString   := 'HISTORICO 01';
    FieldByName('CTR_HIST02').AsString   := 'HISTORICO 02';
    FieldByName('CTR_JURSUJ').AsFloat    := 89.52;
    FieldByName('CTR_DESSUJ').AsFloat    := 65.54;
    FieldByName('CTR_DESCOB').AsFloat    := 5.65;
    FieldByName('CTR_VALJUR').AsFloat    := 7.56;
    FieldByName('CTR_VALDES').AsFloat    := 2.35;
    FieldByName('NUMAGR').AsString       := '000000141005-AG';
    FieldByName('NOMCID').AsString       := 'RIBEIRÃO PRETO';
    FieldByName('DESREG').AsString       := 'REGIÃO DE ARARAQUARA';
    FieldByName('CTR_ESPDOC').AsString   := 'AG';
    Post;
  End;

  If fCfgSis('MODAGR', varInteger) = 2 Then
  Begin
    With FCadRec Do
    Begin
      Append;
      FieldByName('VALDUP').AsFloat    := 7.56;
      FieldByName('NUMDOC').AsString   := '201901090001';
      FieldByName('NUMAGR').AsString   := '000000141005-AG';
      FieldByName('DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
      FieldByName('CODCND').AsString   := '001';
      FieldByName('DESCND').AsString   := 'DINHEIRO';
      Post;
    End;

    With FDupJun Do
    Begin
      Append;
      FieldByName('VALJUN').AsFloat    := 7.56;
      FieldByName('DUPAGR').AsString   := '201901090001';
      FieldByName('DTACAD').AsDateTime := StrToDateTime('01/01/2000');
      Post;
    End;

  End;

  With FGen Do
  Begin
    Append;
    FieldByName('EMP_NOMEMP').AsString   := 'EMPRESSA PREVIEW';
    FieldByName('REL_NOMREL').AsString   := 'COMPROVANTE - DUPLICATAS AGRUPADAS';
    FieldByName('REL_TITREL').AsString   := 'COMPROVANTE - DUPLICATAS AGRUPADAS';
    Post;
  End;

  pIniciaObjetos;
end;

constructor TRelCtrAgrupDupRecibo.CreateInstance(cdsCtrAgrupDupRecibo: TUniClientDataSet);
begin
  FModoDesigner := False;

  FCtrAgrupDupRecibo      := TUniClientDataSet.Create(Nil);
  FCtrAgrupDupRecibo.Data := cdsCtrAgrupDupRecibo.Data;

  pIniciaObjetos;
end;

procedure TRelCtrAgrupDupRecibo.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetCtrAgrupDupRecibo := TfrxDBDataset.Create(nil);
  FDataSetCtrAgrupDupRecibo.Name := 'frxRelatorio';
  FDataSetCtrAgrupDupRecibo.DataSet := FCtrAgrupDupRecibo;

 If fCfgSis('MODAGR', varInteger) = 2 Then
 Begin
   FDataSetCadRec := TfrxDBDataset.Create(nil);
   FDataSetCadRec.Name := 'frxCadRec';
   FDataSetCadRec.DataSet := FCadRec;

   FDataSetDupJun := TfrxDBDataset.Create(nil);
   FDataSetDupJun.Name := 'frxDupJun';
   FDataSetDupJun.DataSet := FDupJun;
 End;

  FDataSetGen := TfrxDBDataset.Create(nil);
  FDataSetGen.Name := 'frxGen';
  FDataSetGen.DataSet := FGen;

  If fCfgSis('MODAGR', varInteger) = 2 Then
  Begin
    SetLength(FArrDBDataSet, 4);
    FArrDBDataSet[0] := FDataSetCtrAgrupDupRecibo;
    FArrDBDataSet[1] := FDataSetCadRec;
    FArrDBDataSet[2] := FDataSetGen;
    FArrDBDataSet[3] := FDataSetDupJun;
  End
  Else
  Begin
    SetLength(FArrDBDataSet, 2);
    FArrDBDataSet[0] := FDataSetCtrAgrupDupRecibo;
    FArrDBDataSet[1] := FDataSetGen;
  End;
  pDefineFilaImpressao(False);
end;

destructor TRelCtrAgrupDupRecibo.Destroy;
begin
  FreeAndNil(FCtrAgrupDupRecibo);
  If fCfgSis('MODAGR', varInteger) = 2 Then
  Begin
    FreeAndNil(FCadRec);
    FreeAndNil(FDataSetCadRec);
    FreeAndNil(FDupJun);
    FreeAndNil(FDataSetDupJun);
  End;
  FreeAndNil(FDataSetCtrAgrupDupRecibo);
  FreeAndNil(FDataSetGen);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TRelCtrAgrupDupRecibo.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fRetornaDescricaoVeic(strPlaVei: String): String;');
  FListaFuncoes.Add('function fRetNomFornecedor(strCodFor: String): String;');
  FListaFuncoes.Add('function fRetNomeMotorista(strCodMot: String): String;');
  FListaFuncoes.Add('function fRetNomeEmpresaSelec(strCodEmp: String): String');
  FListaFuncoes.Add('function fRetNomeEmpresaSelec(strCodEmp: String): String');
  FListaFuncoes.Add('function fVerificaComponenteRelExiste(strComponente,strInformacao : String; blnVisible : Boolean = True) : Boolean;');
  FListaFuncoes.Add('function fMontaVencimentos(strNumDoc, strEspDoc, strCodEmp: String): String;');
  FListaFuncoes.Add('function fFormataCondPag(strCond: String): String');
  FListaFuncoes.Add('function fMontaEmissao(strNumDoc, strEspDoc, strCodEmp: String): String;');
  FListaFuncoes.Add('function fRetQtdReg: Integer');
  FListaFuncoes.Add('function fMontaDataVenctoAgr(strNumDoc, strEspDoc, strCodEmp: String): String;');
  FListaFuncoes.Add('function fRetornaParcelasAgrupamento(ANumDup, ACodCli, ACodEmp: String): String;');
end;

procedure TRelCtrAgrupDupRecibo.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRelCtrAgrupDupRecibo.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_AG_CTR);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_AG_CTR);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

function TRelCtrAgrupDupRecibo.fOnUserFunctionEvent(
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

  If SameText('fVerificaComponenteRelExiste', MethodName) Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1],Params[2]);

  If SameText('fFormataCondPag', MethodName) Then
    Result := fFormataCondPag(Params[0]);

  If SameText('fMontaVencimentos', MethodName) Then
    Result := fMontaVencimentos(Params[0],Params[1],Params[2]);

  If SameText('fMontaEmissao', MethodName) Then
    Result := fMontaEmissao(Params[0],Params[1],Params[2]);

  If SameText('fRetQtdReg', MethodName) Then
    Result := fRetQtdReg;

  If SameText('fMontaDataVenctoAgr', MethodName) Then
    Result := fMontaDataVenctoAgr(Params[0],Params[1],Params[2]);

  If SameText('fRetornaParcelasAgrupamento', MethodName) Then
    Result := fRetornaParcelasAgrupamento(Params[0],Params[1],Params[2]);

end;

function TRelCtrAgrupDupRecibo.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;


function TRelCtrAgrupDupRecibo.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TRelCtrAgrupDupRecibo.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TRelCtrAgrupDupRecibo.fGetIsEmpty: Boolean;
begin
  Result := FCtrAgrupDupRecibo.IsEmpty;
end;

function TRelCtrAgrupDupRecibo.fGetKey: String;
begin
  If fCfgSis('MODAGR', varInteger) = 1 Then
  Begin
    Result := 'AGCTR1';
  End
  Else If fCfgSis('MODAGR', varInteger) = 2 Then
  Begin
    Result := 'AGCTR2';
  End
  Else If fCfgSis('MODAGR', varInteger) = 3 Then
  Begin
    Result := 'AGCTR3';
  End
  Else
    Result := 'AGCTR4';
end;

function TRelCtrAgrupDupRecibo.fGetName: String;
begin
  If fCfgSis('MODAGR', varInteger) = 1 Then
  Begin
    Result := 'RECIBO DE AGRUPAMENTOS - CONTAS A RECEBER - MODELO 1';
  End
  Else If fCfgSis('MODAGR', varInteger) = 2 Then
  Begin
    Result := 'RECIBO DE AGRUPAMENTOS - CONTAS A RECEBER - MODELO 2';
  End
  Else If fCfgSis('MODAGR', varInteger) = 3 Then
  Begin
    Result := 'RECIBO DE AGRUPAMENTOS - CONTAS A RECEBER - MODELO 3';
  End
  Else
    Result := 'RECIBO DE AGRUPAMENTOS - CONTAS A RECEBER - MODELO 4 (40c)';
end;

function TRelCtrAgrupDupRecibo.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRelCtrAgrupDupRecibo.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRelCtrAgrupDupRecibo.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRelCtrAgrupDupRecibo.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TRelCtrAgrupDupRecibo.fMontaEmissao(strNumDoc, strEspDoc,
  strCodEmp: String): String;
begin
  Result := '01/01/2001';
end;

function TRelCtrAgrupDupRecibo.fMontaDataVenctoAgr(strNumDoc, strEspDoc,
  strCodEmp: String): String;
begin
  Result := '01/01/2001';
end;

function TRelCtrAgrupDupRecibo.fMontaVencimentos(strNumDoc, strEspDoc,
  strCodEmp: String): String;
begin
Result := '01/01/2001';
end;

function TRelCtrAgrupDupRecibo.fPrepareDataSetsAndVariables: Boolean;

  procedure pCarregaVariaveis;
  begin
    FDicVar.AddOrSetValue('VS_Date', VS_Date);
    FDicVar.AddOrSetValue('CFG_COMAGR', fCfgSis('COMAGR', varString));
    FDicVar.AddOrSetValue('NOMEMP','EMPRESSA 001');
    FDicVar.AddOrSetValue('ENDEMP','RUA DAS FLORES');
    FDicVar.AddOrSetValue('CIDEMP','RIBEIRÃO PRETO');
    FDicVar.AddOrSetValue('BAIEMP','NOVA ROMA');
    FDicVar.AddOrSetValue('ESTEMP','SP');
    FDicVar.AddOrSetValue('TELEMP','1639545998');
    FDicVar.AddOrSetValue('CEPEMP','14270000');
    FDicVar.AddOrSetValue('IESEMP','562039002114');
    FDicVar.AddOrSetValue('CGCEMP','52688892000169' );

    FDicVar.AddOrSetValue('NOMCLI','JULIANO HIROSHI ENDO' );
    FDicVar.AddOrSetValue('NOMFAN','JULIANO HIROSHI ENDO' );
    FDicVar.AddOrSetValue('ENDCLI','RUA DAS FLORES' );
    FDicVar.AddOrSetValue('CIDCLI','SÃO SIMÃO' );
    FDicVar.AddOrSetValue('BAICLI','HOPE' );
    FDicVar.AddOrSetValue('ESTCLI','SP' );

    FDicVar.AddOrSetValue('TELCLI','16993335992' );
    FDicVar.AddOrSetValue('CEPCLI','14270000' );
    FDicVar.AddOrSetValue('IESCLI','582034600111' );
    FDicVar.AddOrSetValue('CGCCLI','08346159000174' );
    FDicVar.AddOrSetValue('DTAEMI','01/01/2019' );

    FDicVar.AddOrSetValue('TOTGER',12.54 );
    FDicVar.AddOrSetValue('NUMAGR','4569823571258' );
    FDicVar.AddOrSetValue('VALEXT',152.54 );

    FDicVar.AddOrSetValue('MSGAGR','MENSAGEM AGRUPAMENTO');
    FDicVar.AddOrSetValue('QTDREG','1' );
    FDicVar.AddOrSetValue('DTAEXT','01/01/2001' );
  end;

begin
  pCarregaVariaveis;
  pCarregaListaFuncoes;
  Result := True;
end;



function TRelCtrAgrupDupRecibo.fRetornaParcelasAgrupamento(ANumDup, ACodCli,
  ACodEmp: String): String;
begin
  Result := '';
end;

function TRelCtrAgrupDupRecibo.fRetQtdReg: Integer;
begin
Result := 10;
end;

function TRelCtrAgrupDupRecibo.fVerificaComponenteRelExiste(strComponente,
                                                            strInformacao: String;
                                                            blnVisible : Boolean = True): Boolean;
begin
Result := False;
end;

function fCriaClientDatasetRelCtrAgrupDupRecibo: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_NUMDUP';
    DataType := ftString;
    Size     := 12;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_PARCEL';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NUMDOC';
    DataType := ftString;
    Size     := 23;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOMEMP';
    DataType := ftString;
    Size     := 64;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOMCLI';
    DataType := ftString;
    Size     := 64;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CLI_CODCLI';
    DataType := ftString;
    Size     := 8;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CLI_NOMCLI';
    DataType := ftString;
    Size     := 60;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CLI_FANSOB';
    DataType := ftString;
    Size     := 60;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CLI_DESCON';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_CODEMP';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_DTAVEN';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_DTACAD';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_VALDUP';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_VALORI';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_TOTJUR';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_NUMAGR';
    DataType := ftString;
    Size     := 12;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_EMPAGR';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_CONPAG';
    DataType := ftString;
    Size     := 12;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_HIST01';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_HIST02';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_JURSUJ';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_DESSUJ';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_DESCOB';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_VALJUR';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NUMAGR';
    DataType := ftString;
    Size     := 16;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_VALDES';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NOMCID';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DESREG';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTR_ESPDOC';
    DataType := ftString;
    Size     := 2;
  end;

  Result.CreateDataSet;
end;

function fCriaClientDatasetCadRec: TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Nil);
  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NUMDOC';
    DataType := ftString;
    Size     := 16;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NUMAGR';
    DataType := ftString;
    Size     := 16;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DTAVEN';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'VALDUP';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CODCND';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DESCND';
    DataType := ftString;
    Size     := 70;
  end;

  Result.CreateDataSet;
End;

function fCriaClientDatasetDupJun: TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Nil);
  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DUPAGR';
    DataType := ftString;
    Size     := 16;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DTACAD';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'VALJUN';
    DataType := ftFloat;
  end;
  Result.CreateDataSet;
End;

function fCriaClientDatasetGen: TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Nil);
  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMP_NOMEMP';
    DataType := ftString;
    Size     := 60;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'REL_NOMREL';
    DataType := ftString;
    Size     := 60;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'REL_TITREL';
    DataType := ftString;
    Size     := 60;
  end;

  Result.CreateDataSet;
End;

end.
