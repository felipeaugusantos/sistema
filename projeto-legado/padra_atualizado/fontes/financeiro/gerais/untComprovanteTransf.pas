unit untComprovanteTransf;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint;

Type
  TComprovanteTransf = class(TInterfacedObject, IFastPrintFile)
    private
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FCheAvi: TUniClientDataSet;
      FChePre: TUniClientDataSet;
      FCarCre: TUniClientDataSet;
      FListaFuncoes: TStringList;
      FDataSetCheAvi: TfrxDBDataset;
      FDataSetChePre: TfrxDBDataset;
      FDataSetCarCre: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      function fGetIsEmpty: Boolean;
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      procedure pIniciaObjetos;
      function fRetNomOpe(strCodOpe: String): String;
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
      constructor CreateInstance(cdsCheAvi, cdsChePre, cdsCarCre: TUniClientDataSet);
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
      function fVerificaComponenteRelExiste(strComponente,
                                            strInformacao : String) : Boolean;

      procedure pCarregaVariaveis;
  end;

  function fCriaClientDatasetCheAvi: TUniClientDataSet;
  function fCriaClientDatasetChePre: TUniClientDataSet;
  function fCriaClientDatasetCarCre: TUniClientDataSet;

Const
  FILA_IMPRESSAO_COMPROVANTE_TRANSF = 'impressao_comprovante_transf';

implementation

uses untCfgRel, untValorPorExtenso;

{ TComprovanteTransf }

constructor TComprovanteTransf.Create;
begin
  FModoDesigner := True;

  FCheAvi := fCriaClientDatasetCheAvi;

  FCheAvi.Append;

  FCheAvi.FieldByName('BANCO').AsString      := '001';
  FCheAvi.FieldByName('AGENCIA').AsString    := '0553';
  FCheAvi.FieldByName('CONTA').AsString      := '123458-2';
  FCheAvi.FieldByName('NUMERO').AsString     := '4521';
  FCheAvi.FieldByName('CODCLI').AsString     := '00011110';
  FCheAvi.FieldByName('NOMEMI').AsString     := 'CLIENTE 1';
  FCheAvi.FieldByName('VALOR').AsFloat       := 300;
  FCheAvi.FieldByName('DTAVEN').AsDateTime   := StrToDateTime('01/01/2000');
  FCheAvi.FieldByName('QTDDIA').AsInteger    := 10;

  FCheAvi.Post;


  FChePre := fCriaClientDatasetChePre;

  FChePre.Append;

  FChePre.FieldByName('BANCO').AsString      := '033';
  FChePre.FieldByName('AGENCIA').AsString    := '0225';
  FChePre.FieldByName('CONTA').AsString      := '13001444-5';
  FChePre.FieldByName('NUMERO').AsString     := '35895';
  FChePre.FieldByName('CODCLI').AsString     := '00022220';
  FChePre.FieldByName('NOMEMI').AsString     := 'CLIENTE 2';
  FChePre.FieldByName('VALOR').AsFloat       := 400;
  FChePre.FieldByName('DTAVEN').AsDateTime   := StrToDateTime('01/01/2000');
  FChePre.FieldByName('QTDDIA').AsInteger    := 30;

  FChePre.Post;


  FCarCre := fCriaClientDatasetCarCre;

  FCarCre.Append;

  FCarCre.FieldByName('CODCAR').AsInteger    := 777;
  FCarCre.FieldByName('NUMCCD').AsInteger    := 1234;
  FCarCre.FieldByName('CODCLI').AsString     := '00033330';
  FCarCre.FieldByName('NOMEMI').AsString     := 'CLIENTE 3';
  FCarCre.FieldByName('VALOR').AsFloat       := 500;
  FCarCre.FieldByName('DTAVEN').AsDateTime   := StrToDateTime('01/01/2000');
  FCarCre.FieldByName('TIPCAR').AsString     := 'C'; //MF: 295418 - 07/08/23

  FCarCre.Post;

  pIniciaObjetos;
end;

constructor TComprovanteTransf.CreateInstance(cdsCheAvi, cdsChePre, cdsCarCre: TUniClientDataSet);
begin
  FModoDesigner := False;

  FCheAvi           := TUniClientDataSet.Create(Nil);
  FCheAvi.Data      := cdsCheAvi.Data;

  FChePre           := TUniClientDataSet.Create(Nil);
  FChePre.Data      := cdsChePre.Data;

  FCarCre           := TUniClientDataSet.Create(Nil);
  FCarCre.Data      := cdsCarCre.Data;

  pIniciaObjetos;
end;

destructor TComprovanteTransf.Destroy;
begin
  FreeAndNil(FCheAvi);
  FreeAndNil(FChePre);
  FreeAndNil(FCarCre);
  FreeAndNil(FDataSetCheAvi);
  FreeAndNil(FDataSetChePre);
  FreeAndNil(FDataSetCarCre);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

function TComprovanteTransf.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TComprovanteTransf.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TComprovanteTransf.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TComprovanteTransf.fGetIsEmpty: Boolean;
begin
  Result:=False;
end;

function TComprovanteTransf.fGetKey: String;
begin
  If fCfgSis('COLTRF', varInteger) = 1 Then
  Begin
    Result := 'CMPTF1';
  End
  Else If fCfgSis('COLTRF', varInteger) = 2 Then
  Begin
    Result := 'CMPTF2';
  End;
end;

function TComprovanteTransf.fGetName: String;
begin
  If fCfgSis('COLTRF', varInteger) = 1 Then
  Begin
    Result := 'COMPROVANTE TRANSFERENCIA - 40 COLUNAS';
  End
  Else If fCfgSis('COLTRF', varInteger) = 2 Then
  Begin
    Result := 'COMPROVANTE TRANSFERENCIA - 80 COLUNAS';
  End;
end;

function TComprovanteTransf.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TComprovanteTransf.fGetUserDataSets: TArrFrxUserDataSet;
begin
    //
end;

function TComprovanteTransf.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TComprovanteTransf.fGetVariables: TDictionary<String, Variant>;
begin
  Result := FDicVar;
end;

function TComprovanteTransf.fOnUserFunctionEvent(const MethodName: String;
  var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fRetNomOpe') Then
    Result := fRetNomOpe(Params[0]);
end;

function TComprovanteTransf.fPrepareDataSetsAndVariables: Boolean;
begin
  If fCfgSis('COLTRF', varInteger) = 2 Then
  Begin
    FDicTot.Limpar;
    pCarregaListaFuncoes;
  End;
  pCarregaVariaveis; //MF: 295418 - 09/08/23
  Result := True;
end;

function TComprovanteTransf.fRetNomOpe(strCodOpe: String): String;
begin
  Result := fRetNomVendRep(strCodOpe);
end;

function TComprovanteTransf.fVerificaComponenteRelExiste(strComponente,
  strInformacao: String): Boolean;
begin
  Result := False;
end;

procedure TComprovanteTransf.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fGetTotalTransferencia(intSeqCon: Integer): Double');
  FListaFuncoes.Add('function fGetDescricao(strSeqCon: String): String;');
  FListaFuncoes.Add('function fRetNomOpe(strCodOpe: String): String;');
  FListaFuncoes.Add('function fVerificaComponenteRelExiste(strComponente, strInformacao : String) : Boolean');
end;

procedure TComprovanteTransf.pCarregaVariaveis;
begin
  FDicVar.AddOrSetValue('VS_Date', VS_Date);
  FDicVar.AddOrSetValue('VS_strCodEmp', VS_strCodEmp);
  FDicVar.AddOrSetValue('LOGOTIPO', fCfgSis('PATLOG'));
  FDicVar.AddOrSetValue('strLoginUsuarioLogado', strLoginUsuarioLogado);
  FDicVar.AddOrSetValue('strEmpAcessoUsuarioLogado', strEmpAcessoUsuarioLogado);

  //MF: 295418 - 09/08/23 - INI
  FDicVar.AddOrSetValue('PORDINHEI', 'PORTADOR: 001-PORTADOR DINHEIRO');
  FDicVar.AddOrSetValue('VALDINHEI', 'VALOR: 1,00');

  FDicVar.AddOrSetValue('PORORDPAG', 'PORTADOR: 001-PORTADOR ORDEM PAG');
  FDicVar.AddOrSetValue('VALORDPAG', 'VALOR: 1,00');

  FDicVar.AddOrSetValue('VALORDPIX', 'VALOR: 1,00');

  FDicVar.AddOrSetValue('PORCHEAVI', 'PORTADOR: 001-PORTADOR CHEQUE A VISTA');
  FDicVar.AddOrSetValue('VALCHEAVI', 'VALOR: 1,00');

  FDicVar.AddOrSetValue('PORCHEPRE', 'PORTADOR: 001-PORTADOR CHEQUE PRE');
  FDicVar.AddOrSetValue('VALCHEPRE', 'VALOR: 1,00');

  FDicVar.AddOrSetValue('PORCARCRE', 'PORTADOR: 001-PORTADOR CARTAO');
  FDicVar.AddOrSetValue('VALCARCRE', 'VALOR: 1,00');

  FDicVar.AddOrSetValue('PORCARDEB', 'PORTADOR: 001-PORTADOR CARTAO');
  FDicVar.AddOrSetValue('VALCARDEB', 'VALOR: 1,00');

  FDicVar.AddOrSetValue('PORFIN', 'PORTADOR: 001-PORTADOR DINHEIRO');
  FDicVar.AddOrSetValue('VALFIN', 'VALOR: 1,00');

  FDicVar.AddOrSetValue('NOMEMP', 'EMPRESA TESTE');
  FDicVar.AddOrSetValue('FONE01', '(15) 3322-3456');
  FDicVar.AddOrSetValue('CIDEMP', 'CIDADE-UF');
  FDicVar.AddOrSetValue('OPERAD', 'OPERADOR TESTE');
  FDicVar.AddOrSetValue('SEQCON', '123');
  FDicVar.AddOrSetValue('DTACAD', '01/01/1900');
  FDicVar.AddOrSetValue('HORCAD', '01:00');
  FDicVar.AddOrSetValue('CAIXA', '9');
  //MF: 295418 - 09/08/23 - FIM
end;

procedure TComprovanteTransf.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TComprovanteTransf.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_COMPROVANTE_TRANSF);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_COMPROVANTE_TRANSF);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

procedure TComprovanteTransf.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetCheAvi := TfrxDBDataset.Create(nil);
  FDataSetCheAvi.Name := 'frxDBCheAvi';
  FDataSetCheAvi.DataSet := FCheAvi;

  FDataSetChePre := TfrxDBDataset.Create(nil);
  FDataSetChePre.Name := 'frxDBChePre';
  FDataSetChePre.DataSet := FChePre;

  FDataSetCarCre := TfrxDBDataset.Create(nil);
  FDataSetCarCre.Name := 'frxDBCarCre';
  FDataSetCarCre.DataSet := FCarCre;

  SetLength(FArrDBDataSet, 3);
  FArrDBDataSet[0] := FDataSetCheAvi;
  FArrDBDataSet[1] := FDataSetChePre;
  FArrDBDataSet[2] := FDataSetCarCre;

  pDefineFilaImpressao(False);
end;

function fCriaClientDatasetCheAvi: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  Result.FieldDefs.Add('BANCO',ftString,100);
  Result.FieldDefs.Add('AGENCIA',ftString,10);
  Result.FieldDefs.Add('CONTA',ftString,15);
  Result.FieldDefs.Add('NUMERO',ftString,15);
  Result.FieldDefs.Add('CODCLI',ftString,8);
  Result.FieldDefs.Add('NOMEMI',ftString,100);
  Result.FieldDefs.Add('VALOR',ftFloat);
  Result.FieldDefs.Add('DTAVEN',ftDateTime);
  Result.FieldDefs.Add('QTDDIA',ftInteger);

  Result.CreateDataSet;

end;

function fCriaClientDatasetChePre: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  Result.FieldDefs.Add('BANCO',ftString,100);
  Result.FieldDefs.Add('AGENCIA',ftString,10);
  Result.FieldDefs.Add('CONTA',ftString,15);
  Result.FieldDefs.Add('NUMERO',ftString,15);
  Result.FieldDefs.Add('CODCLI',ftString,8);
  Result.FieldDefs.Add('NOMEMI',ftString,100);
  Result.FieldDefs.Add('VALOR',ftFloat);
  Result.FieldDefs.Add('DTAVEN',ftDateTime);
  Result.FieldDefs.Add('QTDDIA',ftInteger);

  Result.CreateDataSet;

end;

function fCriaClientDatasetCarCre: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  Result.FieldDefs.Add('CODCAR',ftInteger);
  Result.FieldDefs.Add('NUMCCD',ftInteger);
  Result.FieldDefs.Add('CODCLI',ftString,8);
  Result.FieldDefs.Add('NOMEMI',ftString,100);
  Result.FieldDefs.Add('VALOR',ftFloat);
  Result.FieldDefs.Add('DTAVEN',ftDateTime);
  Result.FieldDefs.Add('TIPCAR',ftString,1); //MF: 295418 - 07/08/23

  Result.CreateDataSet;

end;

end.
