unit untRelacaoDocsBaixados;

interface

uses
  Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint, untFuncoes;

Type
  TRelacaoDocsBaixados = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FCadRelatorio: TUniClientDataSet;
      FCadCheAvi: TUniClientDataSet;
      FCadChePre: TUniClientDataSet;
      FCadGen: TUniClientDataSet;
      FCadEmp_: TUniQuery;
      FDataSetChePre: TfrxDBDataset;
      FListaFuncoes: TStringList;
      FDataSetRelatorio: TfrxDBDataset;
      FDataSetCheAvi: TfrxDBDataset;
      FDataSetGen: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      FCreditoTroco: String;
      FRecebidoBruto: String;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      function fGetIsEmpty: Boolean;
      procedure pIniciaObjetos;
    function fOnUserFunctionEvent(const MethodName: String;
      var Params: Variant): Variant;
    function fPrepareDataSetsAndVariables: Boolean;
    protected
      function fGetKey: String;
      function fGetName: String;
      function fGetDBDataSets: TArrFrxDBDataSet;
      function fGetUserDataSets: TArrFrxUserDataSet;
      function fGetVariables: TDictionary<String,Variant>;
      function fGetUserFunction: TfrxUserFunctionEvent;
      function fGetFunctionsList: TStringList;
      function fGetPrinterName: String;
      function fGetFastType: TFastFileType;
      procedure pConfigTypeAndPrinterName;
    public
      constructor Create;
      constructor CreateInstance(cdsRecibo: TUniClientDataSet;
                                 vltCreditoTroco: Double = 0;
                                 vltRecebidoBruto: Double = 0;
                                 cdsReciboCG: TUniClientDataSet = Nil);
      destructor Destroy; override;
  end;

  function fCriaClientDatasetRelacaoDoc: TUniClientDataSet;
  function fCriaClientDatasetCheq: TUniClientDataSet;
  function fCriaClientDatasetGen: TUniClientDataSet;

Const
  FILA_IMPRESSAO_RECIBO_CTR = 'impressao_recibo_ctr';

implementation

{ TRelacaoDocsBaixados }

constructor TRelacaoDocsBaixados.Create;
begin
  FModoDesigner := True;

  FPais   := fSetaPais;
  FCadRelatorio := fCriaClientDatasetRelacaoDoc;
  FCadCheAvi := fCriaClientDatasetCheq;
  FCadChePre := fCriaClientDatasetCheq;
  FCadGen := fCriaClientDatasetGen;

  FCadRelatorio.Append;
  FCadRelatorio.FieldByName('DESCRI').AsString     := 'REFENTE A RECEBIMENTO';
  FCadRelatorio.FieldByName('NUMDOC').AsString     := '000000000456';
  FCadRelatorio.FieldByName('ESPDOC').AsString     := 'NF';
  FCadRelatorio.FieldByName('PARCEL').AsString     := 'A';
  FCadRelatorio.FieldByName('CODEMP').AsString     := VS_strCodEmp;
  FCadRelatorio.FieldByName('DTAVEN').AsDateTime   := StrToDateTime('01/01/2000');
  FCadRelatorio.FieldByName('VALJUR').AsFloat      := 1;
  FCadRelatorio.FieldByName('VALCOB').AsFloat      := 1;
  FCadRelatorio.FieldByName('VALDES').AsFloat      := 1;
  FCadRelatorio.FieldByName('DESCOB').AsFloat      := 1;
  FCadRelatorio.FieldByName('VALDOC').AsFloat      := 256;
  FCadRelatorio.FieldByName('VALREC').AsFloat      := 256;
  FCadRelatorio.FieldByName('VALORI').AsFloat      := 256;
  FCadRelatorio.FieldByName('CODCLI').AsString     := '000000456';
  FCadRelatorio.FieldByName('NOMCLI').AsString     := 'MARIA APARECIDA';
  FCadRelatorio.FieldByName('NOMCON').AsString     := 'CONSUMIDOR FINAL';
  FCadRelatorio.FieldByName('CODCTA').AsString     := '02002002';
  FCadRelatorio.FieldByName('CODVEN').AsString     := '999';
  FCadRelatorio.FieldByName('DTAREC').AsDateTime   := StrToDateTime('01/01/2000');
  FCadRelatorio.FieldByName('HORREC').AsDateTime   := fTime();
  FCadRelatorio.FieldByName('DTACAD').AsDateTime   := StrToDateTime('01/01/2000');
  FCadRelatorio.FieldByName('DESCTA').AsString     := 'PLANO DE CONTAS';
  FCadRelatorio.FieldByName('ENDERE').AsString     := 'RUA TAMOIOS';
  FCadRelatorio.FieldByName('ENDNUM').AsString     := '45';
  FCadRelatorio.FieldByName('ENDCMP').AsString     := 'AP. 21';
  FCadRelatorio.FieldByName('BAIRRO').AsString     := 'CENTRO';
  FCadRelatorio.FieldByName('CIDADE').AsString     := 'RIBEIRAO PRETO';
  FCadRelatorio.FieldByName('ESTADO').AsString     := 'SP';
  FCadRelatorio.FieldByName('C_E_P_').AsString     := '14000000';
  FCadRelatorio.FieldByName('C_G_C_').AsString     := '11111111111';
  FCadRelatorio.FieldByName('FONE01').AsString     := '02139363636';
  FCadRelatorio.FieldByName('CTR_CREDITO').AsFloat := 1;
  FCadRelatorio.FieldByName('CTR_ABERTO').AsFloat  := 1;
  FCadRelatorio.FieldByName('HIST01').AsString     := 'TESTE HISTÓRICO 1/DESCRIÇÃO';
  FCadRelatorio.FieldByName('HIST02').AsString     := 'TESTE HISTÓRICO 2';
  FCadRelatorio.FieldByName('RCX_DESCRI').AsString := 'DESCRIÇÃO DO LANCAMENTO';
  FCadRelatorio.FieldByName('TOTCLI').AsFloat      := 256;
  FCadRelatorio.FieldByName('NOMCTA').AsString     := '01.01.001 - Plano de Contas';
  FCadRelatorio.FieldByName('NOMEVE').AsString     := '00001 - Evento';
  FCadRelatorio.FieldByName('CTR_VALCRE').AsFloat  := 356.00;
  FCadRelatorio.FieldByName('DESCPORBAI').AsString := '00005 - PORTADOR DA BAIXA';
  FCadRelatorio.FieldByName('DESCOPEBAI').AsString := '998 - OPERADOR DA BAIXA';
  FCadRelatorio.FieldByName('DESCHISBAI').AsString := 'HISTÓRICO DA BAIXA';
  FCadRelatorio.FieldByName('RECPIX').AsString     := 'N';
  FCadRelatorio.FieldByName('CTR_TOTBLT').AsFloat  := 1000;
  FCadRelatorio.FieldByName('CTR_TOTCRD').AsFloat  := 250;
  FCadRelatorio.FieldByName('CTR_TOTCHD').AsFloat  := 120;
  FCadRelatorio.Post;

  FCadCheAvi.Append;
  FCadCheAvi.FieldByName('CHQ_VALCHQ').AsFloat    := 350.01;
  FCadCheAvi.FieldByName('CHQ_TIPCHQ').AsString   := 'CHEQUE EMPRESA';
  FCadCheAvi.FieldByName('CHQ_DTAEMI').AsString   := '01/11/2020';
  FCadCheAvi.FieldByName('CHQ_BOMPAR').AsString   := '05/11/2020';
  FCadCheAvi.FieldByName('CHQ_DTAVEN').AsDateTime := StrToDateTime('01/01/2000');
  FCadCheAvi.FieldByName('CHQ_NOMEMI').AsString   := 'EMPRESA TESTE';
  FCadCheAvi.FieldByName('CHQ_CODBCO').AsString   := '237';
  FCadCheAvi.FieldByName('CHQ_CONCOR').AsString   := 'CONCOR TESTE';
  FCadCheAvi.FieldByName('CHQ_NUMAGE').AsString   := '3890';
  FCadCheAvi.FieldByName('CHQ_NUMCHQ').AsString   := '9853256454871';
  FCadCheAvi.FieldByName('CHQ_DTAREP').AsDateTime := StrToDateTime('01/01/2000');
  FCadCheAvi.FieldByName('CHQ_C_G_C_').AsString   := '03704662000130';
  FCadCheAvi.FieldByName('CHQ_CGCCPF').AsString   := '1';
  FCadCheAvi.Post;

  FCadGen.Append;
  FCadGen.FieldByName('NOMEMP').AsString := 'EMPRESA TESTE LTDA';
  FCadGen.FieldByName('FONE01').AsString := '1699451230';
  FCadGen.FieldByName('CIDEMP').AsString := 'RIBEIRÃO PRETO';
  FCadGen.FieldByName('FORPAG').AsString := 'DINHEIRO';
  FCadGen.Post;

  pIniciaObjetos;
end;

constructor TRelacaoDocsBaixados.CreateInstance(cdsRecibo: TUniClientDataSet;
  vltCreditoTroco, vltRecebidoBruto: Double; cdsReciboCG: TUniClientDataSet);
begin
  FModoDesigner := False;

  FCadRelatorio        := TUniClientDataSet.Create(Nil);
  FCadRelatorio.Data   := cdsRecibo.Data;

  FCreditoTroco  := FormatFloat(fMskDigitos(2), vltCreditoTroco);
  FRecebidoBruto := FormatFloat(fMskDigitos(2), vltRecebidoBruto);

  pIniciaObjetos;
end;

destructor TRelacaoDocsBaixados.Destroy;
begin
  FreeAndNil(FCadRelatorio);
  FreeAndNil(FDataSetRelatorio);
  FreeAndNil(FDataSetCheAvi);
  FreeAndNil(FCadEmp_);
  FreeAndNil(FDataSetChePre);
  FreeAndNil(FCadGen);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  FreeAndNil(FDataSetGen);
  inherited;
end;

function TRelacaoDocsBaixados.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TRelacaoDocsBaixados.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TRelacaoDocsBaixados.fGetFunctionsList: TStringList;
begin
  Result := FListaFuncoes;
end;

function TRelacaoDocsBaixados.fGetIsEmpty: Boolean;
begin
  Result := FCadRelatorio.IsEmpty;
end;

function TRelacaoDocsBaixados.fGetKey: String;
begin
  Result := 'RELDOC';
end;

function TRelacaoDocsBaixados.fGetName: String;
begin
  Result := 'RELAÇÃO DE DOCUMENTOS BAIXADOS';
end;

function TRelacaoDocsBaixados.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRelacaoDocsBaixados.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRelacaoDocsBaixados.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRelacaoDocsBaixados.fGetVariables: TDictionary<String, Variant>;
begin
  Result := FDicVar;
end;

function TRelacaoDocsBaixados.fOnUserFunctionEvent(const MethodName: String;
  var Params: Variant): Variant;
begin
  //
end;

function TRelacaoDocsBaixados.fPrepareDataSetsAndVariables: Boolean;
begin

  FDicVar.AddOrSetValue('RELACAO', 'RELAÇÃO DE DOCUMENTOS BAIXADOS');
  FDicVar.AddOrSetValue('CNPJ', 'CNPJ/RUC');
  FDicVar.AddOrSetValue('VENC', 'DTA. VENC./MADUREZ');
  FDicVar.AddOrSetValue('DESCRICAO', 'DESCRIÇÃO');
  FDicVar.AddOrSetValue('SEQBAI', '7');
  FDicVar.AddOrSetValue('RESPONSAVEL', 'RESPONSÁVEL');
  FDicVar.AddOrSetValue('COMPENSACAO', 'COMPENSAÇÃO');
  FDicVar.AddOrSetValue('VS_Date', VS_Date);
  FDicVar.AddOrSetValue('VS_strCodEmp', VS_strCodEmp);

  Result := True;
end;

procedure TRelacaoDocsBaixados.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRelacaoDocsBaixados.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_RECIBO_CTR);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_RECIBO_CTR);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

procedure TRelacaoDocsBaixados.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FDataSetRelatorio := TfrxDBDataset.Create(nil);
  FDataSetRelatorio.Name := 'frxRelatorio';
  FDataSetRelatorio.DataSet := FCadRelatorio;

  FDataSetCheAvi := TfrxDBDataset.Create(nil);
  FDataSetCheAvi.Name := 'frxCheAvi';
  FDataSetCheAvi.DataSet := FCadCheAvi;

  FDataSetChePre := TfrxDBDataset.Create(nil);
  FDataSetChePre.Name := 'frxChePre';
  FDataSetChePre.DataSet := FCadChePre;

  FDataSetGen := TfrxDBDataset.Create(nil);
  FDataSetGen.Name := 'frxGenRec';
  FDataSetGen.DataSet := FCadGen;

  SetLength(FArrDBDataSet, 4);
  FArrDBDataSet[0] := FDataSetRelatorio;
  FArrDBDataSet[1] := FDataSetCheAvi;
  FArrDBDataSet[2] := FDataSetChePre;
  FArrDBDataSet[3] := FDataSetGen;

  pDefineFilaImpressao(False);
end;

function fCriaClientDatasetRelacaoDoc: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  Result.FieldDefs.Add('DESCRI', ftString, 200);
  Result.FieldDefs.Add('NUMDOC', ftString, 12);
  Result.FieldDefs.Add('ESPDOC', ftString, 2);
  Result.FieldDefs.Add('PARCEL', ftString, 3);
  Result.FieldDefs.Add('CODEMP', ftString, 3);
  Result.FieldDefs.Add('DTAVEN', ftDateTime);
  Result.FieldDefs.Add('VALJUR', ftFloat);
  Result.FieldDefs.Add('VALCOB', ftFloat);
  Result.FieldDefs.Add('VALDES', ftFloat);
  Result.FieldDefs.Add('DESCOB', ftFloat);
  Result.FieldDefs.Add('VALDOC', ftFloat);
  Result.FieldDefs.Add('VALREC', ftFloat);
  Result.FieldDefs.Add('VALORI', ftFloat);
  Result.FieldDefs.Add('CODCLI', ftString, 8);
  Result.FieldDefs.Add('NOMCLI', ftString, 100);
  Result.FieldDefs.Add('NOMCON', ftString, 100);
  Result.FieldDefs.Add('CODCTA', ftString, 7);
  Result.FieldDefs.Add('CODVEN', ftString, 3);
  Result.FieldDefs.Add('DTAREC', ftDateTime);
  Result.FieldDefs.Add('HORREC', ftDateTime);
  Result.FieldDefs.Add('DTACAD', ftDateTime);
  Result.FieldDefs.Add('DESCTA', ftString, 100);
  Result.FieldDefs.Add('HIST01', ftString, 300);
  Result.FieldDefs.Add('HIST02', ftString, 150);
  Result.FieldDefs.Add('NOSNUM', ftString, 15);
  Result.FieldDefs.Add('FONE01', ftString, 15);
  Result.FieldDefs.Add('F_A_X_', ftString, 15);
  Result.FieldDefs.Add('ENDERE', ftString, 100);
  Result.FieldDefs.Add('ENDNUM', ftString, 10);
  Result.FieldDefs.Add('ENDCMP', ftString, 100);
  Result.FieldDefs.Add('BAIRRO', ftString, 100);
  Result.FieldDefs.Add('CIDADE', ftString, 100);
  Result.FieldDefs.Add('C_E_P_', ftString, 20);
  Result.FieldDefs.Add('C_G_C_', ftString, 20);
  Result.FieldDefs.Add('ESTADO', ftString, 2);
  Result.FieldDefs.Add('SEQBAI', ftInteger);
  Result.FieldDefs.Add('OPEBAI', ftString, 3);
  Result.FieldDefs.Add('SEQCON', ftInteger);
  Result.FieldDefs.Add('CTR_DINHEI', ftFloat);
  Result.FieldDefs.Add('CTR_CHQAVI', ftFloat);
  Result.FieldDefs.Add('CTR_CHQPRE', ftFloat);
  Result.FieldDefs.Add('CTR_CARTAO', ftFloat);
  Result.FieldDefs.Add('CTR_ORDPAG', ftFloat);
  Result.FieldDefs.Add('CTR_CREDITO', ftFloat);
  Result.FieldDefs.Add('CTR_ABERTO', ftFloat);
  Result.FieldDefs.Add('RCX_DESCRI', ftString, 100);
  Result.FieldDefs.Add('PORBAI', ftString, 5);
  Result.FieldDefs.Add('DESCPORBAI', ftString, 100);
  Result.FieldDefs.Add('DESCOPEBAI', ftString, 100);
  Result.FieldDefs.Add('DESCHISBAI', ftString, 100);
  Result.FieldDefs.Add('TOTCLI', ftFloat);
  Result.FieldDefs.Add('NOMCTA', ftString, 100);
  Result.FieldDefs.Add('NOMEVE', ftString, 100);
  Result.FieldDefs.Add('CTR_VALCRE', ftFloat);
  Result.FieldDefs.Add('EMPBAI', ftString, 3);
  Result.FieldDefs.Add('RESCAI', ftString, 1);
  Result.FieldDefs.Add('RECPIX', ftString, 1);
  Result.FieldDefs.Add('CTR_TOTBLT', ftFloat);
  Result.FieldDefs.Add('CTR_TOTCRD', ftFloat);
  Result.FieldDefs.Add('CTR_TOTCHD', ftFloat);

  Result.CreateDataSet;

end;

function fCriaClientDatasetCheq: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  Result.FieldDefs.Add('CHQ_VALCHQ', ftFloat);
  Result.FieldDefs.Add('CHQ_TIPCHQ', ftString, 30);
  Result.FieldDefs.Add('CHQ_DTAEMI', ftString, 30);
  Result.FieldDefs.Add('CHQ_BOMPAR', ftString, 30);
  Result.FieldDefs.Add('CHQ_DTAVEN', ftDateTime);
  Result.FieldDefs.Add('CHQ_NOMEMI', ftString, 60);
  Result.FieldDefs.Add('CHQ_CODBCO', ftString, 3);
  Result.FieldDefs.Add('CHQ_CONCOR', ftString, 12);
  Result.FieldDefs.Add('CHQ_NUMAGE', ftString, 5);
  Result.FieldDefs.Add('CHQ_NUMCHQ', ftString, 10);
  Result.FieldDefs.Add('CHQ_DTAREP', ftDateTime);
  Result.FieldDefs.Add('CHQ_C_G_C_', ftString, 21);
  Result.FieldDefs.Add('CHQ_CGCCPF', ftString, 1);

  Result.CreateDataSet;
end;

function fCriaClientDatasetGen: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  Result.FieldDefs.Add('NOMEMP', ftString, 100);
  Result.FieldDefs.Add('FONE01', ftString, 15);
  Result.FieldDefs.Add('CIDEMP', ftString, 100);
  Result.FieldDefs.Add('FORPAG', ftString, 80);

  Result.CreateDataSet;
end;

end.
