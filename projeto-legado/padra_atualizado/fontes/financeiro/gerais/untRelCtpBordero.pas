unit untRelCtpBordero;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint,StrUtils;

Type
  TRelCtpBordero = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FcdsCTPDET: TUniClientDataSet;
      FcdsGenPag: TUniClientDataSet;
      FcdsChqsEmi: TUniClientDataSet;
      FcdsChqsTerceiros: TUniClientDataSet;
      FcdsMOVBAN: TUniClientDataSet;
      FcdsCADPAG: TUniClientDataSet;
      FDBDatasetCTPDET: TfrxDBDataset;
      FDBDatasetGenPag: TfrxDBDataset;
      FDBDatasetChqsEmi: TfrxDBDataset;
      FDBDatasetChqsTerceiros: TfrxDBDataset;
      FDBDatasetMOVBAN: TfrxDBDataset;
      FDBDatasetCADPAG: TfrxDBDataset;
      FListaFuncoes: TStringList;
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
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
      function fVerificaComponenteRelExiste(strComponente,
                                            strInformacao : String) : Boolean;
      function fFormataCpfCgcLOCAL(pCPFCGC : String): String;
      function fReplaceStrLOCAL(strTexto, strOLD, strNew : String) : String;
  end;

  function fCriaClientDatasetCTPDET: TUniClientDataSet;
  function fCriaClientDatasetGenPag: TUniClientDataSet;
  function fCriaClientDatasetChqsEmi: TUniClientDataSet;
  function fCriaClientDatasetChqsTerceiros: TUniClientDataSet;
  function fCriaClientDatasetMOVBAN: TUniClientDataSet;
  function fCriaClientDatasetCADPAG: TUniClientDataSet;

Const
  FILA_IMPRESSAO_BORDERO = 'frmBaixaCtaPagar';

implementation

uses untCfgRel, untValorPorExtenso, UniDataSetProvider;

{ TRelCtpBordero }

constructor TRelCtpBordero.Create;
begin
  FModoDesigner := True;
  FPais   := fSetaPais;

  FcdsCTPDET := fCriaClientDatasetCTPDET;
  With FcdsCTPDET Do
  Begin
    Append;
    FieldByName('CODEMP').AsString :='001';
    FieldByName('CODEMP').AsString :='59920';
    FieldByName('PORCENT').AsFloat :=48;
    FieldByName('DESCC').AsString  :='CONTA TESTE';
    FieldByName('VALOR').AsFloat   :=698;
    FieldByName('CODCTA').AsFloat  :=59920;
    Post;
  End;

  FcdsGenPag := fCriaClientDatasetGenPag;
  With FcdsGenPag Do
  Begin
    Append;
    FieldByName('AUTOINCREM').AsString :='00000000000000065983';
    FieldByName('CTP_CODFOR').AsString :='59920';
    FieldByName('NRODUP').AsString :='310720190000';
    FieldByName('PARDUP').AsString :='A';
    FieldByName('CTP_CODEMP').AsString :='001';
    FieldByName('CTP_SERIE_').AsString :='1';
    FieldByName('CTP_EMPBAI').AsString :='001';
    FieldByName('CTP_NUMDUP').AsString :='310720190000';
    FieldByName('CTP_PORBAI').AsString :='59920';
    FieldByName('CTP_HIST01').AsString :='REF. COMISSAO DOC. 000000000036-NF';
    FieldByName('CTP_HIST02').AsString :='REF. AO DOCUMENTO No 000000000444CT';
    FieldByName('CTP_CTABAI').AsString :='0005';
    FieldByName('CTP_EMPBAI').AsString :='001';
    FieldByName('CTA_DESCTA').AsString :='CONTA PARA BAIXA';
    FieldByName('FOR_C_G_C_').AsString :='25630302000174';
    FieldByName('FOR_NOMFOR').AsString :='FORNECEDOR TESTE';
    FieldByName('EMP_NOMEMP').AsString :='EMPRESA TESTE';
    FieldByName('POR_NOMPOR').AsString :='PORTADOR TESTE';
    FieldByName('CTP_HISBAI').AsString :='HISTORICO DA BAIXA';
    FieldByName('CTP_SEQBAI').AsFloat   :=1215232;
    FieldByName('CTP_SEQCON').AsFloat   :=8932314;
    FieldByName('CTP_VALPAG').AsFloat   :=698.58;
    FieldByName('CTP_TIPDOC').AsFloat   :=1;
    FieldByName('CTP_DTAPAG').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CTP_DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CTP_HORLOG').AsString   := '10:12:50';
    FieldByName('CTP_DTALOG').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('OPE_NOMOPE').AsString   := 'USUARIO TESTE';
    Post;
  End;

  FcdsChqsEmi := fCriaClientDatasetChqsEmi;
  With FcdsChqsEmi Do
  Begin
    Append;
    FieldByName('CTB_CODPOR').AsString :='59920';
    FieldByName('POR_NOMPOR').AsString :='PORTADOR TESTE';
    FieldByName('EMI_CODBCO').AsString :='237';
    FieldByName('EMI_CONCOR').AsString :='CONCOR TESTE';
    FieldByName('EMI_NUMAGE').AsString :='3980';
    FieldByName('EMI_NUMCHQ').AsString :='69828155852';
    FieldByName('CHQ_VALCHQ').AsFloat  :=855.65;
    FieldByName('CHQ_TIPCHQ').AsString :='CHEQUE EMPRESA';     // CHEQUE EMPRESA OU CHEQUE TERCEIRO
    FieldByName('CHQ_DTAEMI').AsString := '01/11/2020';
    FieldByName('CHQ_BOMPAR').AsString := '05/11/2020';
    FieldByName('CHQ_DTAVEN').AsDateTime := StrToDateTime('01/04/2022');
    FieldByName('CHQ_NOMEMI').AsString :='EMPRESA TESTE';
    Post;
  End;

  FcdsChqsTerceiros := fCriaClientDatasetChqsTerceiros;
  With FcdsChqsTerceiros Do
  Begin
    Append;
    FieldByName('CTB_CODPOR').AsString :='59920';
    FieldByName('CHQ_CODBCO').AsString :='237';
    FieldByName('CHQ_CONCOR').AsString :='CONCOR TESTE';
    FieldByName('CHQ_NUMAGE').AsString :='3890';
    FieldByName('CHQ_NUMCHQ').AsString :='9853256451541';
    FieldByName('CHQ_VALCHQ').AsFloat  :=451.56;
    FieldByName('POR_NOMPOR').AsString :='PORTADOR TESTE';
    FieldByName('CHQ_NOMEMI').AsString :='EMITENTE TESTE';
    FieldByName('CHQ_DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CHQ_DTAREP').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CHQ_TIPCHQ').AsString   :='CHEQUE TERCEIRO';     // CHEQUE EMPRESA OU CHEQUE TERCEIRO
    Post;
  End;

  FcdsMOVBAN := fCriaClientDatasetMOVBAN;
  With FcdsMOVBAN Do
  Begin
    Append;
    FieldByName('MOVBAN.CTB_CODPOR').AsString :='59920';
    FieldByName('POR_NOMPOR').AsString :='PORTADOR TESTE';
    FieldByName('CTP_CTABAI').AsString :='59920';
    FieldByName('CTA_DESCTA').AsString :='CONTA BAIXA TESTE';
    FieldByName('CTB_CODPOR').AsString :='59920';
    Post;
  End;

  FcdsCADPAG := fCriaClientDatasetCADPAG;
  With FcdsCADPAG Do
  Begin
    Append;
    FieldByName('CTP_SEQCON').AsInteger := 569452119;
    Post;
  End;
  pIniciaObjetos;
end;

procedure TRelCtpBordero.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDBDatasetCTPDET := TfrxDBDataset.Create(nil);
  FDBDatasetCTPDET.Name := 'frxDBDatasetCTPDET';
  FDBDatasetCTPDET.DataSet := FcdsCTPDET;

  FDBDatasetGenPag := TfrxDBDataset.Create(nil);
  FDBDatasetGenPag.Name := 'frxDBDatasetGenPag';
  FDBDatasetGenPag.DataSet := FcdsGenPag;

  FDBDatasetChqsEmi := TfrxDBDataset.Create(nil);
  FDBDatasetChqsEmi.Name := 'frxDBDatasetChqsEmi';
  FDBDatasetChqsEmi.DataSet := FcdsChqsEmi;

  FDBDatasetChqsTerceiros := TfrxDBDataset.Create(nil);
  FDBDatasetChqsTerceiros.Name := 'frxDBDatasetChqsTerceiros';
  FDBDatasetChqsTerceiros.DataSet := FcdsChqsTerceiros;

  FDBDatasetMOVBAN := TfrxDBDataset.Create(nil);
  FDBDatasetMOVBAN.Name := 'frxDBDatasetMOVBAN';
  FDBDatasetMOVBAN.DataSet := FcdsMOVBAN;

  FDBDatasetCADPAG := TfrxDBDataset.Create(nil);
  FDBDatasetCADPAG.Name := 'frxDBDatasetCADPAG';
  FDBDatasetCADPAG.DataSet := FcdsCADPAG;

  SetLength(FArrDBDataSet, 6);
  FArrDBDataSet[0] := FDBDatasetCTPDET;
  FArrDBDataSet[1] := FDBDatasetChqsEmi;
  FArrDBDataSet[2] := FDBDatasetChqsTerceiros;
  FArrDBDataSet[3] := FDBDatasetMOVBAN;
  FArrDBDataSet[4] := FDBDatasetCADPAG;
  FArrDBDataSet[5] := FDBDatasetGenPag;

  pDefineFilaImpressao(False);
end;

destructor TRelCtpBordero.Destroy;
begin
  FreeAndNil(FDBDatasetCTPDET);
  FreeAndNil(FDBDatasetChqsEmi);
  FreeAndNil(FDBDatasetChqsTerceiros);
  FreeAndNil(FDBDatasetMOVBAN);
  FreeAndNil(FDBDatasetCADPAG);
  FreeAndNil(FDBDatasetGenPag);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TRelCtpBordero.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fFormataCpfCgcLOCAL(pCPFCGC : String): String');
  FListaFuncoes.Add('function fReplaceStrLOCAL(strTexto, strOLD, strNew : String) : String');
  FListaFuncoes.Add('function fVerificaComponenteRelExiste(strComponente, strInformacao : String) : Boolean');
end;

procedure TRelCtpBordero.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRelCtpBordero.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_BORDERO);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_BORDERO);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

function TRelCtpBordero.fOnUserFunctionEvent(
  const MethodName: String; var Params: Variant): Variant;
begin
  If SameText('fFormataCpfCgcLOCAL', MethodName) Then
    Result := fFormataCpfCgcLOCAL(Params[0]);

  If SameText('fReplaceStrLOCAL', MethodName) Then
    Result := fReplaceStrLOCAL(Params[0], Params[1], Params[2]);

  If SameText('fVerificaComponenteRelExiste', MethodName) Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1]);
end;



function TRelCtpBordero.fFormataCpfCgcLOCAL(pCPFCGC: String): String;
begin
  Result := fFormataCpfCgc(pCPFCGC, fSetaPais);
end;

function TRelCtpBordero.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;


function TRelCtpBordero.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TRelCtpBordero.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TRelCtpBordero.fGetIsEmpty: Boolean;
begin
  Result := FcdsCADPAG.IsEmpty;
end;

function TRelCtpBordero.fGetKey: String;
begin
  Result := 'BORCTP';
end;

function TRelCtpBordero.fGetName: String;
begin
  Result := 'BORDERÔ - CONTAS A PAGAR';
end;

function TRelCtpBordero.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRelCtpBordero.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRelCtpBordero.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRelCtpBordero.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TRelCtpBordero.fPrepareDataSetsAndVariables: Boolean;

  procedure pCarregaVariaveis;
  begin
    FDicVar.AddOrSetValue('VS_Date', VS_Date);
    FDicVar.AddOrSetValue('VS_strCodEmp', VS_strCodEmp);
    FDicVar.AddOrSetValue('LOGOTIPO', fCfgSis('PATLOG'));
    FDicVar.AddOrSetValue('strLoginUsuarioLogado', strLoginUsuarioLogado);
    FDicVar.AddOrSetValue('strEmpAcessoUsuarioLogado', strEmpAcessoUsuarioLogado);
    FDicVar.AddOrSetValue('fltVlrDepBancario', 1.00);
    FDicVar.AddOrSetValue('fltVlrChqEmi', 1.00);
    FDicVar.AddOrSetValue('fltVlrDinheiro', 1.00);
    FDicVar.AddOrSetValue('fltVlrChqRep', 1.00);
    FDicVar.AddOrSetValue('fltVlrTotalFormasPgto', 4.00);
    FDicVar.AddOrSetValue('blnDetalhamento', 'true');
  end;


begin
  Result := True;
  pCarregaVariaveis;
  pCarregaListaFuncoes;
end;

function TRelCtpBordero.fReplaceStrLOCAL(strTexto, strOLD,
  strNew: String): String;
begin
  Result := ReplaceStr(strTexto, strOLD, strNew);
end;

function TRelCtpBordero.fVerificaComponenteRelExiste(strComponente,
                                                     strInformacao : String ): Boolean;
begin
  Result := False;
end;

function fCriaClientDatasetCTPDET: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CODEMP';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CODCTA';
    DataType := ftString;
    Size     := 7;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'PORCENT';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'DESCC';
    DataType := ftString;
    Size     := 40;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'VALOR';
    DataType := ftFloat;
  end;

  Result.CreateDataSet;
end;

function fCriaClientDatasetGenPag: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_MENSAG';
    DataType := ftString;
    Size     := 150;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'AUTOINCREM';
    DataType := ftString;
    Size     := 20;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_CODFOR';
    DataType := ftString;
    Size     := 8;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NRODUP';
    DataType := ftString;
    Size     := 12;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'PARDUP';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_CODEMP';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_SEQBAI';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_SERIE_';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_EMPBAI';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_SEQCON';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_VALPAG';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_TIPDOC';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_DTAPAG';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_NUMDUP';
    DataType := ftString;
    Size     := 12;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_PORBAI';
    DataType := ftString;
    Size     := 5;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_HIST02';
    DataType := ftString;
    Size     := 40;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_HIST01';
    DataType := ftString;
    Size     := 40;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_HISBAI';
    DataType := ftString;
    Size     := 40;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_CTABAI';
    DataType := ftString;
    Size     := 5;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTA_DESCTA';
    DataType := ftString;
    Size     := 40;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FOR_C_G_C_';
    DataType := ftString;
    Size     := 18;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FOR_NOMFOR';
    DataType := ftString;
    Size     := 60;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMP_NOMEMP';
    DataType := ftString;
    Size     := 60;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'POR_NOMPOR';
    DataType := ftString;
    Size     := 60;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_DTAVEN';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_HORLOG';
    DataType := ftString;
    Size     := 20;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_DTALOG';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'OPE_NOMOPE';
    DataType := ftString;
  end;

  Result.CreateDataSet;
end;

function fCriaClientDatasetChqsEmi: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTB_CODPOR';
    DataType := ftString;
    Size     := 5;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'POR_NOMPOR';
    DataType := ftString;
    Size     := 40;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMI_CODBCO';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMI_CONCOR';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMI_NUMAGE';
    DataType := ftString;
    Size     := 5;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMI_NUMCHQ';
    DataType := ftString;
    Size     := 10;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_VALCHQ';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_TIPCHQ';
    DataType := ftString;
    Size     := 30;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_DTAEMI';
    DataType := ftString;
    Size     := 30;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_BOMPAR';
    DataType := ftString;
    Size     := 30;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_DTAVEN';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_NOMEMI';
    DataType := ftString;
    Size     := 60;
  end;

  Result.CreateDataSet;
end;

function fCriaClientDatasetChqsTerceiros: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTB_CODPOR';
    DataType := ftString;
    Size     := 10;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_CODBCO';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_CONCOR';
    DataType := ftString;
    Size     := 12;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_NUMAGE';
    DataType := ftString;
    Size     := 5;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_NUMCHQ';
    DataType := ftString;
    Size     := 10;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_VALCHQ';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'POR_NOMPOR';
    DataType := ftString;
    Size     := 40;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_NOMEMI';
    DataType := ftString;
    Size     := 60;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_DTAVEN';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_DTAREP';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_TIPCHQ';
    DataType := ftString;
    Size     := 30;
  end;

  Result.CreateDataSet;
end;

function fCriaClientDatasetMOVBAN: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'MOVBAN.CTB_CODPOR';
    DataType := ftString;
    Size     := 5;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'POR_NOMPOR';
    DataType := ftString;
    Size     := 40;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_CTABAI';
    DataType := ftString;
    Size     := 5;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTA_DESCTA';
    DataType := ftString;
    Size     := 40;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTB_CODPOR';
    DataType := ftString;
    Size     := 5;
  end;

  Result.CreateDataSet;
end;

function fCriaClientDatasetCADPAG: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_SEQCON';
    DataType := ftFloat;
  end;

  Result.CreateDataSet;
end;

end.
