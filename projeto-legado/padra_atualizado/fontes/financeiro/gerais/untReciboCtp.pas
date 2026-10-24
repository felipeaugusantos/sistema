{**************************************************}
{* IMPRESSAO DO RECIBO CUSTOMIZADO DO FAST REPORT *}
{***********************************************JU*}

unit untReciboCtp;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint;

Type
  TReciboCtp = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FCadPag: TUniClientDataSet;
      FCadEmp_: TUniQuery;
      FListaFuncoes: TStringList;
      FDataSetEmp: TfrxDBDataset;
      FDataSetCadPag: TfrxDBDataset;
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

  function fCriaClientDatasetReciboCTP: TUniClientDataSet;

Const
  FILA_IMPRESSAO_RECIBO_CTP = 'impressao_recibo_ctp';

implementation

uses untCfgRel, untValorPorExtenso;

{ TReciboCtp }

constructor TReciboCtp.Create;
begin
  FModoDesigner := True;
  FPais := fSetaPais;

  FCadPag := fCriaClientDataseTReciboCTP;

  With FCadPag Do
  Begin
    Append;
    FieldByName('CTP_NUMDUP').AsString   := '000000000356A';
    FieldByName('NRODUP').AsString       := '000000000356';
    FieldByName('CTP_CODEMP').AsString   := '001';
    FieldByName('CTP_USACHQ').AsString   := 'SIM';
    FieldByName('CTP_CODEVE').AsString   := '02152';
    FieldByName('CTP_PORBAI').AsString   := '00235';
    FieldByName('CTP_SERIE_').AsString   := '1';
    FieldByName('CTP_VALJUR').AsFloat    := 2;
    FieldByName('CTP_VALMUL').AsFloat    := 1.56;
    FieldByName('CTP_VALDES').AsFloat    := 1;
    FieldByName('CTP_VALDUP').AsFloat    := 523;
    FieldByName('CTP_VALPAG').AsFloat    := 523;
    FieldByName('CTP_VALORI').AsFloat    := 523;
    FieldByName('CTP_TIPDOC').AsFloat    := 11111111111;
    FieldByName('CTP_DESSUJ').AsFloat    := 1;
    FieldByName('CTP_JURSUJ').AsFloat    := 1;
    FieldByName('CTP_MULSUJ').AsFloat    := 1.68;
    FieldByName('CTP_VENDOR').AsFloat    := 2;
    FieldByName('TOTDUP').AsFloat        := 523;
    FieldByName('CTP_CODFOR').AsString   := '00009632';
    FieldByName('FOR_NOMFOR').AsString   := 'INDUSTRIA DE TINTAS LTDA.';
    FieldByName('CTP_NOMFOR').AsString   := 'INDUSTRIA DE TINTAS LTDA.';
    FieldByName('EVE_DESEVE').AsString   := 'CENTRO DE CUSTO FINANCEIRO';
    FieldByName('CTP_CODCTA').AsString   := '02003004';
    FieldByName('CTP_DTAPAG').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CTP_DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CTP_DTAPAG').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CTP_DTACAD').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CTA_DESCTA').AsString   := 'PLANO DE CONTAS';
    FieldByName('CTP_HIST01').AsString   := 'REFERENTE A PAGAMENTO DE FORNECEDOR';
    FieldByName('CTP_HIST02').AsString   := 'LANCAMENTO FINANCEIRO';
    FieldByName('CTP_HISBAI').AsString   := 'HISTÓRICO DA BAIXA';
    FieldByName('FOR_FONE01').AsString   := '1639654123';
    FieldByName('FOR_F_A_X_').AsString   := '1639654124';
    FieldByName('FOR_C_G_C_').AsString   := '88888888888888';
    FieldByName('CTP_CODVEL').AsString   := '99999999999999999999';
    FieldByName('CTP_PREVIS').AsString   := 'N';
    FieldByName('CTP_VEIOBO').AsString   := 'N';
    FieldByName('CTP_MARDES').AsString   := 'M';
    FieldByName('CTP_TIPBAI').AsString   := 'T';
    FieldByName('CTP_TIPDES').AsString   := 'C';
    FieldByName('EMP_NOMEMP').AsString   := '001';
    FieldByName('POR_NOMPOR').AsString   := 'BANCO PORTADOR BAIXA';
    FieldByName('POR_LISTAR').AsString   := 'LISTA DE PORTADORES BAIXA';
    FieldByName('CTP_FORMAS').AsString   := 'COMO OS TITULOS FORAM PAGOS';
    FieldByName('CTP_DESCRI').AsString   := 'DESCRIÇÃO';
    FieldByName('FOR_ENDERE').AsString   := 'ENDEREÇO';
    FieldByName('FOR_ENDNUM').AsString   := '000';
    FieldByName('FOR_ENDCMP').AsString   := 'COMPLEMENTO';
    FieldByName('FOR_BAIRRO').AsString   := 'BAIRRO';
    FieldByName('FOR_CIDADE').AsString   := 'CIDADE';
    FieldByName('FOR_C_E_P_').AsString   := '00000-000';
    FieldByName('FOR_ESTADO').AsString   := 'SP';
    FieldByName('CTP_DTAREC').AsDateTime := StrToDateTime('01/01/2000');
    FieldByName('CTP_HORREC').AsDateTime := StrToDateTime('00:00:01');
    FieldByName('CTB_CODPOR').AsString   := '';
    FieldByName('EMI_CODBCO').AsString   := '';
    FieldByName('EMI_CONCOR').AsString   := '';
    FieldByName('EMI_NUMAGE').AsString   := '';
    FieldByName('EMI_NUMCHQ').AsString   := '';
    FieldByName('EMI_VALCHQ').AsFloat    := 0.0;
    FieldByName('EMI_NOMPOR').AsString   := '';

    FieldByName('CHQ_NUMCHQ').AsString   := '';
    FieldByName('CHQ_CODBCO').AsString   := '';
    FieldByName('CHQ_NUMAGE').AsString   := '';
    FieldByName('CHQ_CONCOR').AsString   := '';
    FieldByName('CHQ_NOMEMI').AsString   := '';
    FieldByName('CHQ_DTAVEN').AsString   := '';
    FieldByName('CHQ_DTAREP').AsString   := '';
    FieldByName('CHQ_NOMPOR').AsString   := '';
    FieldByName('CHQ_VALCHQ').AsFloat    := 0.0;

    FieldByName('CTP_OUTENT').AsFloat    := 0.0;

    FieldByName('RCX_CAIXA').AsString    := '';

    FieldByName('CTP_NOMCTA').AsString   := '01.01.001 - Plano de Contas';
    FieldByName('CTP_CTABAI').AsString   := '01.01.001 - Plano de Contas';
    FieldByName('CTP_NOMEVE').AsString   := '00001 - Evento';

    FieldByName('CTP_CHQAVI').AsFloat    := 600.00;
    FieldByName('CTP_DINHEI').AsFloat    := 20.00;
    FieldByName('CTP_ORDPAG').AsFloat    := 1.00;
    FieldByName('CTP_REPCHQ').AsFloat    := 313.0;

    FieldByName('CTP_OPEBAI').AsString   := '998 - OPERADOR DA BAIXA';

    Post;
  End;

  pIniciaObjetos;
end;

constructor TReciboCtp.CreateInstance(cdsRecibo: TUniClientDataSet);
begin
  FModoDesigner := False;

  FCadPag       := TUniClientDataSet.Create(Nil);
  FCadPag.Data  := cdsRecibo.Data;

  pIniciaObjetos;
end;

procedure TReciboCtp.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetCadPag := TfrxDBDataset.Create(nil);
  FDataSetCadPag.Name := 'frxDataSetContasPagar';
  FDataSetCadPag.DataSet := FCadPag;

  FCadEmp_ := fCriaQuery(nil);
  FDataSetEmp := TfrxDBDataset.Create(nil);
  FDataSetEmp.Name := 'frxDataSetEmpresa';
  FDataSetEmp.DataSet := FCadEmp_;

  SetLength(FArrDBDataSet, 2);
  FArrDBDataSet[0] := FDataSetEmp;
  FArrDBDataSet[1] := FDataSetCadPag;

  pDefineFilaImpressao(False);
end;

destructor TReciboCtp.Destroy;
begin
  FreeAndNil(FCadPag);
  FreeAndNil(FDataSetCadPag);
  FreeAndNil(FCadEmp_);
  FreeAndNil(FDataSetEmp);
  FreeAndNil(FDicVar);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TReciboCtp.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fFormataCpfCgcInterna(strValor: String): String;');
  FListaFuncoes.Add('function fFormataCEP(strCEP: String): String;');
  FListaFuncoes.Add('function fFormataFone(strFone: String): String;');
  FListaFuncoes.Add('function fRetExtensoNumero(Value : String):String;');
end;

procedure TReciboCtp.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TReciboCtp.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_RECIBO_CTP);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_RECIBO_CTP);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);    
end;

function TReciboCtp.fOnUserFunctionEvent(
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

function TReciboCtp.fFormataCpfCgcInterna(strValor: String): String;
begin
  Result := fFormataCpfCgc(strValor, FPais);
end;

function TReciboCtp.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TReciboCtp.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TReciboCtp.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TReciboCtp.fGetIsEmpty: Boolean;
begin
  Result := FCadPag.IsEmpty;
end;

function TReciboCtp.fGetKey: String;
begin
  Result := 'RECCTP';
end;

function TReciboCtp.fGetName: String;
begin
  Result := 'RECIBO CONTAS A PAGAR';
end;

function TReciboCtp.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TReciboCtp.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TReciboCtp.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TReciboCtp.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TReciboCtp.fPrepareDataSetsAndVariables: Boolean;
  Var
    fltTotalPago : Double;

  procedure pCarregaVariaveis;
  begin
    FDicVar.AddOrSetValue('VS_Date', VS_Date);
    FDicVar.AddOrSetValue('VS_strCodEmp', VS_strCodEmp);
    FDicVar.AddOrSetValue('LOGOTIPO', fCfgSis('PATLOG'));
    FDicVar.AddOrSetValue('strLoginUsuarioLogado', strLoginUsuarioLogado);
    FDicVar.AddOrSetValue('strEmpAcessoUsuarioLogado', strEmpAcessoUsuarioLogado);
    FDicVar.AddOrSetValue('fltTotalPago', fltTotalPago);
  end;

  procedure pCarregaDadosEmpresa;
  begin
    fCadEmp('NOMEMP', FCadEmp_);
  end;

begin

  fltTotalPago := 0;

  With FCadPag Do
  Begin
    First;
    While Not Eof Do
    Begin

      fltTotalPago := fltTotalPago + FieldByName('CTP_VALPAG').AsFloat;
      Next;

    End;
    First;

    Result := Not IsEmpty;

  End;

  pCarregaVariaveis;
  pCarregaDadosEmpresa;
  pCarregaListaFuncoes;
end;

function fCriaClientDatasetReciboCTP: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_NUMDUP';
    DataType := ftString;
    Size     := 13;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'NRODUP';
    DataType := ftString;
    Size     := 12;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'ESPDOC';
    DataType := ftString;
    Size     := 2;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'PARDUP';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_CODEMP';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_USACHQ';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_CODEVE';
    DataType := ftString;
    Size     := 5;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_PORBAI';
    DataType := ftString;
    Size     := 5;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_SERIE_';
    DataType := ftString;
    Size     := 3;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_DTAVEN';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_VALJUR';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_VALMUL';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_VALDES';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_VALDUP';
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
    Name     := 'CTP_VALORI';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_DESSUJ';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_JURSUJ';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_MULSUJ';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_VENDOR';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'TOTDUP';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_CODFOR';
    DataType := ftString;
    Size     := 8;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FOR_NOMFOR';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_NOMFOR';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EVE_DESEVE';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_CODCTA';
    DataType := ftString;
    Size     := 7;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_DTAPAG';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_DTACAD';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTA_DESCTA';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_HIST01';
    DataType := ftString;
    Size     := 300;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_HIST02';
    DataType := ftString;
    Size     := 150;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_HISBAI';
    DataType := ftString;
    Size     := 50;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FOR_FONE01';
    DataType := ftString;
    Size     := 15;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FOR_F_A_X_';
    DataType := ftString;
    Size     := 15;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FOR_C_G_C_';
    DataType := ftString;
    Size     := 20;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_CODVEL';
    DataType := ftString;
    Size     := 20;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_PREVIS';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_VEIOBO';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_MARDES';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_TIPBAI';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_TIPDES';
    DataType := ftString;
    Size     := 1;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMP_NOMEMP';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'POR_NOMPOR';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'POR_LISTAR';
    DataType := ftMemo;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'POR_LISTAR2';
    DataType := ftMemo;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_FORMAS';
    DataType := ftMemo;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_DESCRI';
    DataType := ftString;
    Size     := 200;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FOR_ENDERE';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FOR_ENDNUM';
    DataType := ftString;
    Size     := 10;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FOR_ENDCMP';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FOR_BAIRRO';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FOR_CIDADE';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FOR_C_E_P_';
    DataType := ftString;
    Size     := 20;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'FOR_ESTADO';
    DataType := ftString;
    Size     := 2;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_DTAREC';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_HORREC';
    DataType := ftDateTime;
  end;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CTB_CODPOR';
    DataType := ftString;
    Size     := 200;
  End;


  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EMI_CODBCO';
    DataType := ftString;
    Size     := 200;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EMI_CONCOR';
    DataType := ftString;
    Size     := 200;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EMI_NUMAGE';
    DataType := ftString;
    Size     := 200;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EMI_NUMCHQ';
    DataType := ftString;
    Size     := 200;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CHQ_VALCHQ';
    DataType := ftFloat;
  End;


  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CHQ_NUMCHQ';
    DataType := ftString;
    Size     := 10;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CHQ_CODBCO';
    DataType := ftString;
    Size     := 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CHQ_NUMAGE';
    DataType := ftString;
    Size     := 5;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CHQ_CONCOR';
    DataType := ftString;
    Size     := 12;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CHQ_NOMEMI';
    DataType := ftString;
    Size     := 40;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CHQ_DTAVEN';
    DataType := ftDateTime;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CHQ_DTAREP';
    DataType := ftDateTime;
  End;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMI_NOMPOR';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CHQ_NOMPOR';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'EMI_VALCHQ';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_OUTENT';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'RCX_CAIXA';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_NOMCTA';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_NOMEVE';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_CHQAVI';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_DINHEI';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_ORDPAG';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_REPCHQ';
    DataType := ftFloat;
  end;

  With Result.FieldDefs.AddFieldDef Do
  begin
    Name     := 'CTP_OPEBAI';
    DataType := ftString;
    Size     := 100;
  end;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_CTABAI';
    DataType := ftString;
    Size := 100;
  End;

  Result.CreateDataSet;
end;

end.

