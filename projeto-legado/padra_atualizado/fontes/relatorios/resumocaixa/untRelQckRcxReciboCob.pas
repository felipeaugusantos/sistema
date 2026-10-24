unit untRelQckRcxReciboCob;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint,System.DateUtils;

Type
  TRelQckRcxReciboCob = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FCdsRecibo: TUniClientDataSet;
      FCadEmp_: TUniQuery;
      FDataSetEmp: TfrxDBDataset;
      FListaFuncoes: TStringList;
      FDataSetCdsRecibo: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      function fGetIsEmpty: Boolean;
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      procedure pIniciaObjetos;
      procedure pCarregaDadosEmpresa;
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
      ModoProducao : Boolean;
      constructor Create;
      constructor CreateInstance(cdsCdsRecibo: TUniClientDataSet; strCodCli:String);
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
      function fVerificaComponenteRelExiste(strComponente,
                                            strInformacao : String;
                                            blnVisible : Boolean = True) : Boolean;
      function fMontaVencimentos(strNumDoc, strEspDoc, strCodEmp: String): String;
      function fMontaEmissao(strNumDoc, strEspDoc, strCodEmp: String): String;
      function fRetQtdReg: Integer;
      procedure pCarregaVariaveis;
  end;

  function fCriaClientDatasetRelQckRcxReciboCob: TUniClientDataSet;

Const
  FILA_IMPRESSAO = 'frmBaixaReceber';

implementation

uses untCfgRel, untValorPorExtenso;

{ TRelQckRcxReciboCob}

constructor TRelQckRcxReciboCob.Create;
begin
  FModoDesigner := True;

  FPais   := fSetaPais;
  FCdsRecibo := fCriaClientDatasetRelQckRcxReciboCob;

  FCdsRecibo.Append;

  FCdsRecibo.FieldByName('CODCLI').AsString   := '00059920';
  FCdsRecibo.FieldByName('NUMDUP').AsString   := '123456789190';
  FCdsRecibo.FieldByName('CODEMP').AsString   := '001';
  FCdsRecibo.FieldByName('DTAEMI').AsDateTime := VS_DATE;
  FCdsRecibo.FieldByName('DTAVEN').AsDateTime := VS_DATE;
  FCdsRecibo.FieldByName('VALORI').AsFloat    := 12.87;
  FCdsRecibo.FieldByName('VALJUR').AsFloat    := 1.87;
  FCdsRecibo.FieldByName('DESCON').AsFloat    := 0.87;
  FCdsRecibo.FieldByName('VALTOT').AsFloat    := 13.87;

  FCdsRecibo.FieldByName('NOMCLI').AsString   := 'Carlos Eduardo';
  FCdsRecibo.FieldByName('ENDCLI').AsString   := 'Rua Dom Pedro II';
  FCdsRecibo.FieldByName('CIDCLI').AsString   := 'Ribeirão Preto';
  FCdsRecibo.FieldByName('CGCCLI').AsString   := '56.866.284/0001-58';
  FCdsRecibo.FieldByName('FONCLI').AsString   := '(16) 99278-6503';
  FCdsRecibo.FieldByName('BAICLI').AsString   := 'Nova Roma';
  FCdsRecibo.FieldByName('CEPCLI').AsString   := '14010-000';
  FCdsRecibo.FieldByName('IRGCLI').AsString   := '001';
  FCdsRecibo.FieldByName('FONCLI2').AsString  := '(16) 3954-7896';

  FCdsRecibo.Post;

  pIniciaObjetos;
end;

constructor TRelQckRcxReciboCob.CreateInstance(cdsCdsRecibo: TUniClientDataSet; strCodCli:String);
begin
  FModoDesigner := False;

  FCdsRecibo      := TUniClientDataSet.Create(Nil);
  FCdsRecibo.Data := cdsCdsRecibo.Data;

  FCdsRecibo.Filtered := False;
  FCdsRecibo.Filter   := 'CODCLI = ' + QuotedStr(strCodCli);
  FCdsRecibo.Filtered := True;

  pIniciaObjetos;
end;

procedure TRelQckRcxReciboCob.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetCdsRecibo := TfrxDBDataset.Create(nil);
  FDataSetCdsRecibo.Name := 'frxRelatorio';
  FDataSetCdsRecibo.DataSet := FCdsRecibo;

  FCadEmp_ := fCriaQuery(nil);
  FDataSetEmp := TfrxDBDataset.Create(nil);
  FDataSetEmp.Name := 'frxDataSetEmpresa';
  FDataSetEmp.DataSet := FCadEmp_;

  SetLength(FArrDBDataSet, 2);
  FArrDBDataSet[0] := FDataSetCdsRecibo;
  FArrDBDataSet[1] := FDataSetEmp;

  ModoProducao := False;

  pDefineFilaImpressao(False);
end;

destructor TRelQckRcxReciboCob.Destroy;
begin
  FreeAndNil(FCadEmp_);
  FreeAndNil(FDataSetEmp);
  FreeAndNil(FCdsRecibo);
  FreeAndNil(FDataSetCdsRecibo);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TRelQckRcxReciboCob.pCarregaDadosEmpresa;
begin
  fCadEmp('NOMEMP', FCadEmp_);
end;

procedure TRelQckRcxReciboCob.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fValorPorExtenso(Valor : String):String;');
  FListaFuncoes.Add('function fRetNomCidade(strCodigo: String; intOpcao: Integer = 0): String;');
end;

procedure TRelQckRcxReciboCob.pCarregaVariaveis;
begin
  FDicVar.AddOrSetValue('NOMEMP', 'CITEL SOFTWARE');
  FDicVar.AddOrSetValue('FONE','FONE: (16) 3302-6789');
  FDicVar.AddOrSetValue('NOMCID','CIDADE: RIBEIRÃO PRETO - SP');
  FDicVar.AddOrSetValue('NOMEND','ENDEREÇO: AVENIDA DOUTOR FRANCISCO JUNQUEIRA, 457');
  FDicVar.AddOrSetValue('BAICID','BAIRRO: VILA SEIXAS');
  FDicVar.AddOrSetValue('ENDCEP','CEP: 14270-000');
  fAtuCfgSis( 'CONREC', IIF( fCfgSisL('CONREC') = '', fStrZero( '1', 6), fStrZero( IntToStr( fCfgSisL('CONREC', varInteger) + 1 ), 6) ) );
  FDicVar.AddOrSetValue('CONREC', 'RECIBO DE COBRANCA No - ' + fCfgSisL('CONREC') + ' - ' + VS_strCodEmp);
  FDicVar.AddOrSetValue('ENDEMP','Endereço da Empresa');
  FDicVar.AddOrSetValue('CGCEMP','04.562.779/0001-90');
  FDicVar.AddOrSetValue('DATA',AnsiUpperCase(fRetDataExtenso(VS_Date,True)));
  FDicVar.AddOrSetValue('DTAINI',DateToStr(VS_DATE));
  FDicVar.AddOrSetValue('DTAFIN',DateToStr(VS_DATE+1));
  FDicVar.AddOrSetValue('CIDEMP','Cidade da Empresa');
  FDicVar.AddOrSetValue('OPELIB',fRetNomeOperador(strLoginUsuarioLogado));
  FDicVar.AddOrSetValue('PERIMP',fCfgSis('PESGSO'));
  FDicVar.AddOrSetValue('INSINSS','Nº INSCRIÇÃO NO INSS');
  FDicVar.AddOrSetValue('RETINSS','RETENÇÃO DE INSS');
  FDicVar.AddOrSetValue('%','%');
  FDicVar.AddOrSetValue('..','..');
  FDicVar.AddOrSetValue('-','-');
  FDicVar.AddOrSetValue('CODLIB', strLoginUsuarioLogado);
end;

procedure TRelQckRcxReciboCob.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRelQckRcxReciboCob.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
    strNomeFila,strTipImp : String;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO);

  If blnConfigurar Then
  Begin
     if ModoProducao then
     Begin
        fPreImpressao(qryCfgRel,strNomeFila,strTipImp,False);
        FTipImp := strTipImp;
        FNomImp := strNomeFila;
     End
     Else
     Begin
        pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO);
        FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
        FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
     End;
  End;

  if ModoProducao then
  Begin
     FTipImp := strTipImp;
     FNomImp := strNomeFila;
  End
  Else
  Begin
     FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
     FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  End;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

function TRelQckRcxReciboCob.fOnUserFunctionEvent(
  const MethodName: String; var Params: Variant): Variant;
begin
  If SameText('fValorPorExtenso', MethodName) Then
    Result := fValorPorExtenso(Params[0]);
  If SameText('fRetNomCidade', MethodName) Then
    Result := fRetNomCidade(Params[0],Params[1]);
end;

function TRelQckRcxReciboCob.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;


function TRelQckRcxReciboCob.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TRelQckRcxReciboCob.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TRelQckRcxReciboCob.fGetIsEmpty: Boolean;
begin
  Result := FCdsRecibo.IsEmpty;
end;

function TRelQckRcxReciboCob.fGetKey: String;
begin
  Result := 'RECCOB';
end;

function TRelQckRcxReciboCob.fGetName: String;
begin
  Result := 'RECIBO DE COBRANÇA';
end;

function TRelQckRcxReciboCob.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRelQckRcxReciboCob.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRelQckRcxReciboCob.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRelQckRcxReciboCob.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TRelQckRcxReciboCob.fMontaEmissao(strNumDoc, strEspDoc,
  strCodEmp: String): String;
begin
  Result := '01/01/2001';
end;

function TRelQckRcxReciboCob.fMontaVencimentos(strNumDoc, strEspDoc,
  strCodEmp: String): String;
begin
Result := '01/01/2001';
end;

function TRelQckRcxReciboCob.fPrepareDataSetsAndVariables: Boolean;
begin
  pCarregaVariaveis;
  pCarregaDadosEmpresa;
  pCarregaListaFuncoes;
  Result := True;
end;

function TRelQckRcxReciboCob.fRetQtdReg: Integer;
begin
Result := 10;
end;

function TRelQckRcxReciboCob.fVerificaComponenteRelExiste(strComponente,
                                                            strInformacao: String;
                                                            blnVisible : Boolean = True): Boolean;
begin
Result := False;
end;

function fCriaClientDatasetRelQckRcxReciboCob: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  Result.FieldDefs.Add('CODCLI',ftString,08);
  Result.FieldDefs.Add('NUMDUP',ftString,20);
  Result.FieldDefs.Add('CODEMP',ftString,03);
  Result.FieldDefs.Add('DTAEMI',ftDate);
  Result.FieldDefs.Add('DTAVEN',ftDate);
  Result.FieldDefs.Add('VALORI',ftFloat);
  Result.FieldDefs.Add('VALJUR',ftFloat);
  Result.FieldDefs.Add('DESCON',ftFloat);
  Result.FieldDefs.Add('VALTOT',ftFloat);

  Result.FieldDefs.Add('NOMCLI',ftString,200);
  Result.FieldDefs.Add('ENDCLI',ftString,100);
  Result.FieldDefs.Add('CIDCLI',ftString,100);
  Result.FieldDefs.Add('CGCCLI',ftString,15);
  Result.FieldDefs.Add('FONCLI',ftString,20);
  Result.FieldDefs.Add('BAICLI',ftString,100);
  Result.FieldDefs.Add('CEPCLI',ftString,15);
  Result.FieldDefs.Add('IRGCLI',ftString,20);
  Result.FieldDefs.Add('FONCLI2',ftString,20);

  Result.CreateDataSet;
end;

end.
