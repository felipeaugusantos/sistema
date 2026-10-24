unit untRecBaixaBocaCaixa;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint,StrUtils;

Type
  TRecBaixaBocaCaixa = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FcdsBXDET: TUniClientDataSet;
      FDBDatasetBXDET: TfrxDBDataset;
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
      function fCriaClientDatasetBXDET: TUniClientDataSet;
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
      procedure pCarregaVariaveis;
    public
      ModoProducao: Boolean;
      constructor Create;
      constructor CreateInstance(cdsRecBx : TUniClientDataSet);

      destructor Destroy; override;

      procedure pSetFastType(AType: String);

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
      function fVerificaComponenteRelExiste(strComponente,
                                            strInformacao : String) : Boolean;
      function fFormataCpfCgcLOCAL(pCPFCGC : String): String;
      function fReplaceStrLOCAL(strTexto, strOLD, strNew : String) : String;
  end;



Const
  FILA_IMPRESSAO_REC_BAIXA_BOCA_CAIXA = 'frmBaixaBocaCaixa';

implementation

uses untCfgRel, untValorPorExtenso, UniDataSetProvider;

{ TRecBaixaBocaCaixa }

constructor TRecBaixaBocaCaixa.Create;
begin
  FModoDesigner := True;
  FPais         := fSetaPais;

  FcdsBXDET    := fCriaClientDatasetBXDET;

  FcdsBXDET.Append;
  FcdsBXDET.FieldByName('CODEMP').AsString   := '001';
  FcdsBXDET.FieldByName('NOMEMP').AsString   := 'EMPRESA TESTE';
  FcdsBXDET.FieldByName('ENDERE').AsString   := 'ENDEREÇO: RUA TESTE DE TESTE, 234, CENTRO';
  FcdsBXDET.FieldByName('NOMCID').AsString   := 'RIBEIRÃO PRETO';
  FcdsBXDET.FieldByName('FONE'  ).AsString   := '1699999999';
  FcdsBXDET.FieldByName('CNPJ').AsString     := '52.688.892.0001/69';
  FcdsBXDET.FieldByName('IES').AsString      := '111.111.111-11';
  FcdsBXDET.FieldByName('VENDEDOR').AsString := '001-FULANO DE TAL';
  FcdsBXDET.FieldByName('NOMVEN').AsString   := 'FULANO DE TAL';
  FcdsBXDET.FieldByName('NUMDOC').AsString   := '1234567';
  FcdsBXDET.FieldByName('DTAENT').AsString   := '01/10/2021';
  FcdsBXDET.FieldByName('CODITE').AsString   := '12541';
  FcdsBXDET.FieldByName('ITEM').AsString     := '12541-ITEM TESTE';
  FcdsBXDET.FieldByName('UNIDAD').AsString   := 'UN';
  FcdsBXDET.FieldByName('QTDITE').AsFloat    := 1.00;
  FcdsBXDET.FieldByName('VLRUNI').AsFloat    := 12.19;
  FcdsBXDET.FieldByName('VLRTOT').AsFloat    := 12.19;
  FcdsBXDET.FieldByName('VLRCOM').AsFloat    := 1.21;

  FcdsBXDET.Post;

  pIniciaObjetos;
end;

constructor TRecBaixaBocaCaixa.CreateInstance(cdsRecBx : TUniClientDataSet);
begin
  FModoDesigner := False;

  FcdsBXDET      := TUniClientDataSet.Create(Nil);
  FcdsBXDET.Data := cdsRecBx.Data;

  pIniciaObjetos;
end;

procedure TRecBaixaBocaCaixa.pSetFastType(AType: String);
begin
  FTipImp := AType;
end;

procedure TRecBaixaBocaCaixa.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDBDatasetBXDET         := TfrxDBDataset.Create(nil);
  FDBDatasetBXDET.Name    := 'frxDBDatasetBXDET';
  FDBDatasetBXDET.DataSet := FcdsBXDET;

  SetLength(FArrDBDataSet, 1);
  FArrDBDataSet[0] := FDBDatasetBXDET;

  ModoProducao := False;

  pDefineFilaImpressao(False);
end;

destructor TRecBaixaBocaCaixa.Destroy;
begin
  FreeAndNil(FDBDatasetBXDET);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TRecBaixaBocaCaixa.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRecBaixaBocaCaixa.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
    strNomeFila,strTipImp : String;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_REC_BAIXA_BOCA_CAIXA);

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
        pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_REC_BAIXA_BOCA_CAIXA);
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

function TRecBaixaBocaCaixa.fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
begin
  If SameText('fFormataCpfCgcLOCAL', MethodName) Then
    Result := fFormataCpfCgcLOCAL(Params[0]);

  If SameText('fReplaceStrLOCAL', MethodName) Then
    Result := fReplaceStrLOCAL(Params[0], Params[1], Params[2]);

  If SameText('fVerificaComponenteRelExiste', MethodName) Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1]);
end;



function TRecBaixaBocaCaixa.fFormataCpfCgcLOCAL(pCPFCGC: String): String;
begin
  Result := fFormataCpfCgc(pCPFCGC, fSetaPais);
end;

function TRecBaixaBocaCaixa.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TRecBaixaBocaCaixa.fGetIsEmpty: Boolean;
begin
  Result := FcdsBXDET.IsEmpty;
end;

function TRecBaixaBocaCaixa.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TRecBaixaBocaCaixa.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TRecBaixaBocaCaixa.fGetKey: String;
begin

  If FTipImp <> 'M' Then
  Begin

    If fCfgSis('ORBXBC') = '1' Then
    Begin
      Result := 'RECBB1'; // IMPRIME RETRATO;
    End
    Else
      Result := 'RECBB2'; // IMPRIME PAISAGEM;

  End
  Else
      Result := 'RECBB2'; // IMPRIME PAISAGEM;

end;

function TRecBaixaBocaCaixa.fGetName: String;
begin

  If FTipImp <> 'M' Then
  Begin

    If fCfgSis('ORBXBC') = '1' Then
    Begin
      Result := 'RECIBO DE BAIXA BOCA DE CAIXA - RETRATO'
    End
    Else
      Result := 'RECIBO DE BAIXA BOCA DE CAIXA - PAISAGEM';

  End
  Else
      Result := 'RECIBO DE BAIXA BOCA DE CAIXA - MATRICIAL';

end;

function TRecBaixaBocaCaixa.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRecBaixaBocaCaixa.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRecBaixaBocaCaixa.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRecBaixaBocaCaixa.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TRecBaixaBocaCaixa.fPrepareDataSetsAndVariables: Boolean;
begin
  Result := True;
  pCarregaVariaveis;
  pCarregaListaFuncoes;
end;

function TRecBaixaBocaCaixa.fReplaceStrLOCAL(strTexto, strOLD,
  strNew: String): String;
begin
  Result := ReplaceStr(strTexto, strOLD, strNew);
end;

function TRecBaixaBocaCaixa.fVerificaComponenteRelExiste(strComponente, strInformacao : String ): Boolean;
begin
  Result := False;
end;

function TRecBaixaBocaCaixa.fCriaClientDatasetBXDET: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  Result.FieldDefs.Add('CODEMP'  ,ftString,10);
  Result.FieldDefs.Add('NOMEMP'  ,ftString,100);
  Result.FieldDefs.Add('ENDERE'  ,ftString,100);
  Result.FieldDefs.Add('NOMCID'  ,ftString,40);
  Result.FieldDefs.Add('FONE'    ,ftString,40);
  Result.FieldDefs.Add('CNPJ'    ,ftString,40);
  Result.FieldDefs.Add('IES'     ,ftString,40);
  Result.FieldDefs.Add('VENDEDOR',ftString,40);
  Result.FieldDefs.Add('NOMVEN'  ,ftString,40);
  Result.FieldDefs.Add('NUMDOC'  ,ftString,40);
  Result.FieldDefs.Add('DTAENT'  ,ftString,15);
  Result.FieldDefs.Add('CODITE'  ,ftString,20);
  Result.FieldDefs.Add('ITEM'    ,ftString,20);
  Result.FieldDefs.Add('UNIDAD'  ,ftString,20);
  Result.FieldDefs.Add('QTDITE'  ,ftFloat);
  Result.FieldDefs.Add('VLRUNI'  ,ftFloat);
  Result.FieldDefs.Add('VLRTOT'  ,ftFloat);
  Result.FieldDefs.Add('VLRCOM'  ,ftFloat);

  Result.CreateDataSet;
end;

procedure TRecBaixaBocaCaixa.pCarregaVariaveis;
begin
  FDicVar.AddOrSetValue('VS_Date'     , VS_Date);
  FDicVar.AddOrSetValue('VS_strCodEmp', VS_strCodEmp);
  FDicVar.AddOrSetValue('LOGOTIPO'    , fCfgSis('PATLOG'));
  FDicVar.AddOrSetValue('strLoginUsuarioLogado'    , strLoginUsuarioLogado);
  FDicVar.AddOrSetValue('strEmpAcessoUsuarioLogado', strEmpAcessoUsuarioLogado);
end;

procedure TRecBaixaBocaCaixa.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fFormataCpfCgcLOCAL(pCPFCGC : String): String');
  FListaFuncoes.Add('function fVerificaComponenteRelExiste(strComponente, strInformacao : String) : Boolean');
end;

end.
