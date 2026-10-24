unit untRelCtpCompPgtoMod;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint;

Type
  TRelCtpCompPgtoMod = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FRelCtpCompPgtoMod: TUniClientDataSet;
      FCadPag: TUniClientDataSet;
      FListaFuncoes: TStringList;
      FDataSetRelCtpCompPgtoMod: TfrxDBDataset;
      FDataSetCadPag: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      FDataSetCadChq: TfrxDBDataset;
      FCadPagChq: TUniClientDataSet;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      function fGetIsEmpty: Boolean;
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      procedure pIniciaObjetos;
      function fRemoveAcentos(strHistor: String): String;
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
      constructor CreateInstance(cdsRelCtpCompPgtoMod: TUniClientDataSet);
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
      function fVerificaComponenteRelExiste(strComponente,
                                            strInformacao : String;
                                            blnVisible : Boolean = True) : Boolean;
  end;

  function fCriaClientDatasetRelCtpCompPgtoMod : TUniClientDataSet;
  function fCriaClientDatasetCadPag: TUniClientDataSet;
  function fCriaClientDatasetCadPagChq: TUniClientDataSet;

Const
  FILA_IMPRESSAO_CP_CTP = 'untCadPag';

implementation

uses untCfgRel, untValorPorExtenso;

{ TRelCtpCompPgtoMod }

constructor TRelCtpCompPgtoMod.Create;
begin
  FModoDesigner := True;

  FPais   := fSetaPais;
  FRelCtpCompPgtoMod := fCriaClientDatasetRelCtpCompPgtoMod;
  FCadPagChq := fCriaClientDatasetCadPagChq;
  If fCfgSis('LAY_CP', varInteger) <> '3' Then
    FCadPag := fCriaClientDatasetCadPag;

  With FRelCtpCompPgtoMod Do
  Begin
    Append;
    FieldByName('CODFOR').AsString        := '00000001';
    FieldByName('PARCEL').AsString        := 'PARCELAS';
    FieldByName('CODEMP').AsString        := '001';
    FieldByName('SERIE_').AsString        := '1';
    FieldByName('NOMEMP').AsString        := '001-EMPRESA 001';
    FieldByName('NOMFOR').AsString        := 'FORNECEDOR BRASIL LTDA(SP)';
    FieldByName('NOMEVE').AsString        := 'EVENTO';
    FieldByName('NOMPOR').AsString        := 'PORTADOR CONVERSAO';
    FieldByName('DESCUS').AsString        := 'TRANSFERENCIA VALORES CAIXA';
    FieldByName('DESCRE').AsString        := 'DESPESAS BANCARIAS / FINANCEIRAS';
    FieldByName('DTACAD').AsDateTime      := StrToDateTime('01/01/2000');
    FieldByName('DTADOC').AsDateTime      := StrToDateTime('01/01/2000');
    FieldByName('CHAVE').AsString         := '029';
    FieldByName('NUMDUP').AsString        := '000000000122';
    FieldByName('DTAVEN').AsDateTime      := StrToDateTime('01/01/2000');
    FieldByName('VEIONF').AsString        := 'NAO';
    FieldByName('CENCUS').AsString        := '0101001';
    FieldByName('VEIOBO').AsString        := 'N';
    FieldByName('HIST01').AsString        := 'Pgto. ¿gua (475)';
    FieldByName('HIST02').AsString        := 'EXEMPLO HISTORICO 2';
    FieldByName('DUPLIC').AsFloat         := 650;
    FieldByName('VALTOT').AsFloat         := 650;
    FieldByName('JURSUJ').AsFloat         := 1.30;
    FieldByName('MULSUJ').AsFloat         := 12.45;
    FieldByName('DESSUJ').AsFloat         := 10.00;
    FieldByName('VENDOR').AsFloat         := 30.00;
    FieldByName('OUTENT').AsFloat         := 0.00;
    FieldByName('NUMVIA').AsInteger       := 1;
    FieldByName('CONTADEPOSITO').AsString := 'BCO: 033 AG: 0003-3 CONTA: 0000000003-3';
    FieldByName('CONTABANCO').AsString    := 'BCO: 420-BANORTE NACIONAL DO NORTE SA AG: 64412-1 CONTA: 54124-2';
    FieldByName('DEPOSITO').AsString      := 'NAO';
    FieldByName('CHEQUE').AsString        := 'NAO';
    FieldByName('GUIDES').AsString        := 'DARF NORMAL';

    Post;
  End;

  With FCadPagChq Do
  Begin
    Append;
    FieldByName('CHQBCO').AsString        := '077';
    FieldByName('CHQAGE').AsString        := '268';
    FieldByName('CHQCOR').AsString        := '6569';
    FieldByName('NUMCHQ').AsString        := '5621';
    FieldByName('CHQCLI').AsString        := '00097489';
    FieldByName('CHQVEN').AsDateTime      := StrToDateTime('03/07/2018');
    Post;
  End;

  If fCfgSis('LAY_CP', varInteger) <> '3' Then
  Begin
    With FCadPag Do
    Begin
      Append;
      FieldByName('CTP_CODFOR').AsString  := '00000001';
      FieldByName('CTP_NUMDUP').AsString  := '201901090001';
      FieldByName('CTP_PARCEL').AsString  := 'A';
      FieldByName('CTP_EMPORI').AsString  := '001';
      FieldByName('CTP_SERIE_').AsString  := '01';
      FieldByName('CTP_CODCTA').AsString  := '0101001';
      FieldByName('CTA_DESCTA').AsString  := 'TRANSFERENCIAS';
      FieldByName('CTP_CODEMP').AsString  := '001';
      FieldByName('CTP_CODEVE').AsString  := '00005';
      FieldByName('EVE_DESEVE').AsString  := 'ENVIADO SPC';
      FieldByName('CTP_FATCAL').AsFloat   := 0.457588983165713;
      Post;
    End;
  End;

  pIniciaObjetos;
end;

constructor TRelCtpCompPgtoMod.CreateInstance(cdsRelCtpCompPgtoMod: TUniClientDataSet);
begin
  FModoDesigner := False;

  FRelCtpCompPgtoMod      := TUniClientDataSet.Create(Nil);
  FRelCtpCompPgtoMod.Data := cdsRelCtpCompPgtoMod.Data;

  pIniciaObjetos;
end;

procedure TRelCtpCompPgtoMod.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetRelCtpCompPgtoMod := TfrxDBDataset.Create(nil);
  FDataSetRelCtpCompPgtoMod.Name := 'frxDataCtp';
  FDataSetRelCtpCompPgtoMod.DataSet := FRelCtpCompPgtoMod;

  If fCfgSis('LAY_CP', varInteger) <> '3' Then
  Begin
    FDataSetCadPag := TfrxDBDataset.Create(nil);
    FDataSetCadPag.Name := 'frxCtpDet';
    FDataSetCadPag.DataSet := FCadPag;

    FDataSetCadChq := TfrxDBDataset.Create(nil);
    FDataSetCadChq.Name := 'frxCtpChq';
    FDataSetCadChq.DataSet := FCadPagChq;

    SetLength(FArrDBDataSet, 3);
    FArrDBDataSet[0] := FDataSetRelCtpCompPgtoMod;
    FArrDBDataSet[1] := FDataSetCadPag;
    FArrDBDataSet[2] := FDataSetCadChq;
  End
  Else
  Begin
    SetLength(FArrDBDataSet, 1);
    FArrDBDataSet[0] := FDataSetRelCtpCompPgtoMod;
  End;

  pDefineFilaImpressao(False);
end;

destructor TRelCtpCompPgtoMod.Destroy;
begin
  FreeAndNil(FRelCtpCompPgtoMod);
  If fCfgSis('LAY_CP', varInteger) <> '3' Then
  Begin
    FreeAndNil(FDataSetCadPag);
    FreeAndNil(FDataSetCadChq);
    FreeAndNil(FCadPag);
    FreeAndNil(FCadPagChq);
  End;
  FreeAndNil(FDataSetRelCtpCompPgtoMod);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TRelCtpCompPgtoMod.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fRemoveAcentos(strHistor: String): String;');
  FListaFuncoes.Add('function fVerificaComponenteRelExiste(strComponente,strInformacao : String; blnVisible : Boolean = True) : Boolean;');
end;

procedure TRelCtpCompPgtoMod.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRelCtpCompPgtoMod.pDefineFilaImpressao(blnConfigurar: Boolean);
  var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_CP_CTP);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_CP_CTP);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

function TRelCtpCompPgtoMod.fOnUserFunctionEvent(
  const MethodName: String; var Params: Variant): Variant;
begin
  If SameText('fRemoveAcentos', MethodName) Then
    Result := fRemoveAcentos(Params[0]);

  If SameText('fVerificaComponenteRelExiste', MethodName) Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1],Params[2]);
end;

function TRelCtpCompPgtoMod.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;


function TRelCtpCompPgtoMod.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TRelCtpCompPgtoMod.fGetFunctionsList: TStringList;
begin
  Result := FListaFuncoes;
end;

function TRelCtpCompPgtoMod.fGetIsEmpty: Boolean;
begin
  Result := FRelCtpCompPgtoMod.IsEmpty;
end;

function TRelCtpCompPgtoMod.fGetKey: String;
begin
  If fCfgSis('LAY_CP', varInteger) = 1 Then
  Begin
    Result := 'CPCTP1';
  End
  Else If fCfgSis('LAY_CP', varInteger) = 2 Then
  Begin
    Result := 'CPCTP2';
  End
  Else
    Result := 'CPCTP3';
end;

function TRelCtpCompPgtoMod.fGetName: String;
begin
  If fCfgSis('LAY_CP', varInteger) = 1 Then
  Begin
    Result := 'CONTROLE DE PAGAMENTO - CONTAS A PAGAR - MEIA FOLHA'
  End
  Else If fCfgSis('LAY_CP', varInteger) = 2 Then
  Begin
    Result := 'CONTROLE DE PAGAMENTO - CONTAS A PAGAR - FOLHA INTEIRA'
  End
  Else
    Result := 'CONTROLE DE PAGAMENTO - CONTAS A PAGAR - FOLHA INTEIRA COM 3 POR P¡GINA';
end;

function TRelCtpCompPgtoMod.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRelCtpCompPgtoMod.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRelCtpCompPgtoMod.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRelCtpCompPgtoMod.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TRelCtpCompPgtoMod.fPrepareDataSetsAndVariables: Boolean;
  procedure pCarregaVariaveis;
  begin
    FDicVar.AddOrSetValue('NOMREL', 'C.P. CONTROLE DE PAGAMENTO');
  end;

begin
  pCarregaVariaveis;
  pCarregaListaFuncoes;
  Result := True;
end;



function TRelCtpCompPgtoMod.fRemoveAcentos(strHistor: String): String;
	Const
		ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹"¥';
		SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
	Var
		x : Integer;
Begin
	For x := 1 to Length(strHistor) do
		If Pos(strHistor[x],ComAcento)<>0 Then
			strHistor[x] := SemAcento[Pos(strHistor[x],ComAcento)];
  Result := strHistor;

end;

function TRelCtpCompPgtoMod.fVerificaComponenteRelExiste(strComponente,
                                                            strInformacao: String;
                                                            blnVisible : Boolean = True): Boolean;
begin
  Result := False;
end;

function fCriaClientDatasetRelCtpCompPgtoMod: TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODFOR';
    DataType := ftString;
    Size := 8;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PARCEL';
    DataType := ftString;
    Size := 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;
    Size := 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SERIE_';
    DataType := ftString;
    Size := 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMEMP';
    DataType := ftString;
    Size := 50;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMFOR';
    DataType := ftString;
    Size := 50;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMEVE';
    DataType := ftString;
    Size := 50;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMPOR';
    DataType := ftString;
    Size := 50;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESCUS';
    DataType := ftString;
    Size := 50;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESCRE';
    DataType := ftString;
    Size := 48;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTACAD';
    DataType := ftDate;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTADOC';
    DataType := ftDate;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CHAVE';
    DataType := ftString;
    Size := 30;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMDUP';
    DataType := ftString;
    Size := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTAVEN';
    DataType := ftDate;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VEIONF';
    DataType := ftString;
    Size := 5;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CENCUS';
    DataType := ftString;
    Size := 50;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VEIOBO';
    DataType := ftString;
    Size := 5;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'HIST01';
    DataType := ftMemo;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'HIST02';
    DataType := ftString;
    Size := 50;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DUPLIC';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALTOT';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'JURSUJ';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESSUJ';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MULSUJ';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VENDOR';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'OUTENT';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMVIA';
    DataType := ftInteger;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CONTADEPOSITO';
    DataType := ftString;
    Size := 50
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CONTABANCO';
    DataType := ftString;
    Size := 90
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DEPOSITO';
    DataType := ftString;
    Size := 5;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CHEQUE';
    DataType := ftString;
    Size := 5;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'GUIDES';
    DataType := ftString;
    Size := 50;
  End;

  Result.CreateDataSet;
End;

function fCriaClientDatasetCadPag: TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CTP_CODFOR';
    DataType := ftString;
    Size     := 8;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_NUMDUP';
    DataType := ftString;
    Size := 12;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_PARCEL';
    DataType := ftString;
    Size := 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_EMPORI';
    DataType := ftString;
    Size := 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_SERIE_';
    DataType := ftString;
    Size := 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_CODCTA';
    DataType := ftString;
    Size := 7;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTA_DESCTA';
    DataType := ftString;
    Size := 30;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_CODEMP';
    DataType := ftString;
    Size := 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_CODEVE';
    DataType := ftString;
    Size := 5;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'EVE_DESEVE';
    DataType := ftString;
    Size := 40;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_FATCAL';
    DataType := ftFloat;
  End;

  Result.CreateDataSet;
End;

function fCriaClientDatasetCadPagChq: TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CHQBCO';
    DataType := ftString;
    Size := 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CHQAGE';
    DataType := ftString;
    Size := 5;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CHQCOR';
    DataType := ftString;
    Size := 12;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMCHQ';
    DataType := ftString;
    Size := 10;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CHQCLI';
    DataType := ftString;
    Size := 8;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CHQVEN';
    DataType := ftDate;
  End;

  Result.CreateDataSet;
End;

end.
