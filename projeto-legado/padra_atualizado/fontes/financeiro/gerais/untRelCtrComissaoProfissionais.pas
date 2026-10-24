unit untRelCtrComissaoProfissionais;

interface

uses Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint,System.DateUtils;

Type
  TRelCtrComissaoProfissionais = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FCdsRecibo: TUniClientDataSet;
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
      procedure pCarregaVariaveis;
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
      constructor CreateInstance(cdsCdsRecibo: TUniClientDataSet);
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
      function fVerificaComponenteRelExiste(strComponente,
                                            strInformacao : String;
                                            blnVisible : Boolean = True) : Boolean;
      function fMontaVencimentos(strNumDoc, strEspDoc, strCodEmp: String): String;
      function fMontaEmissao(strNumDoc, strEspDoc, strCodEmp: String): String;
      function fRetQtdReg: Integer;
  end;

  function fCriaClientDatasetRelCtrComissaoProfissionais: TUniClientDataSet;

Const
  FILA_IMPRESSAO_AG_CTR = 'frmAgrupDuplicatas';

implementation

uses untCfgRel, untValorPorExtenso;

{ TRelCtrComissaoProfissionais}

constructor TRelCtrComissaoProfissionais.Create;
begin
  FModoDesigner := True;

  FPais   := fSetaPais;
  FCdsRecibo := fCriaClientDatasetRelCtrComissaoProfissionais;

  FCdsRecibo.Append;
  FCdsRecibo.FieldByName('NOMREC').AsString   := 'Nome Preview';
  FCdsRecibo.FieldByName('VALREC').AsFloat    := 12.87;
  FCdsRecibo.FieldByName('VALEXT').AsString   := UpperCase(fRetExtensoNumero(FormatFloat('#,##0.00', 12.87)));
  FCdsRecibo.FieldByName('HISREC').AsString   := 'Histórico Recebimento';
  FCdsRecibo.FieldByName('HISREC_02').AsString:= 'Histórico Recebimento';
  FCdsRecibo.FieldByName('HISREC_03').AsString:= 'Histórico Recebimento';
  FCdsRecibo.FieldByName('NOMASS').AsString   := fRetNomeOperador(strLoginUsuarioLogado);
  FCdsRecibo.FieldByName('NROVIA').AsFloat    := 1;
  FCdsRecibo.FieldByName('DTAREC').AsString   := DateToStr(VS_DATE);
  FCdsRecibo.FieldByName('VALTOT').AsFloat    := 12.87;
  FCdsRecibo.FieldByName('VALIMP').AsFloat    := 12.87;
  FCdsRecibo.FieldByName('NOMLIB').AsString   := fRetNomeOperador(strLoginUsuarioLogado);
  FCdsRecibo.FieldByName('NROREC').AsString   :=  fRetSequencial('SEQRPA') + '/' + Copy(IntToStr(YearOf(Date)), 3, 2);
  FCdsRecibo.FieldByName('NUMPIS').AsString   := '8934900943903';
  FCdsRecibo.FieldByName('MARCA_').AsString   := '-';
  FCdsRecibo.Post;

  pIniciaObjetos;
end;

constructor TRelCtrComissaoProfissionais.CreateInstance(cdsCdsRecibo: TUniClientDataSet);
begin
  FModoDesigner := False;

  FCdsRecibo      := TUniClientDataSet.Create(Nil);
  FCdsRecibo.Data := cdsCdsRecibo.Data;

  pIniciaObjetos;
end;

procedure TRelCtrComissaoProfissionais.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetCdsRecibo := TfrxDBDataset.Create(nil);
  FDataSetCdsRecibo.Name := 'frxRelatorio';
  FDataSetCdsRecibo.DataSet := FCdsRecibo;

  SetLength(FArrDBDataSet, 1);
  FArrDBDataSet[0] := FDataSetCdsRecibo;

  pDefineFilaImpressao(False);
end;

destructor TRelCtrComissaoProfissionais.Destroy;
begin
  FreeAndNil(FCdsRecibo);
  FreeAndNil(FDataSetCdsRecibo);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TRelCtrComissaoProfissionais.pCarregaListaFuncoes;
begin
//
end;

procedure TRelCtrComissaoProfissionais.pCarregaVariaveis;
begin
  FDicVar.AddOrSetValue('VALREC', FormatFloat('#,##0.00', 189));
  FDicVar.AddOrSetValue('MOEDA','R$');
  FDicVar.AddOrSetValue('PONTO',' ');
  FDicVar.AddOrSetValue('(','(');
  FDicVar.AddOrSetValue(')',')');
  FDicVar.AddOrSetValue('VALEXT',UpperCase(fRetExtensoNumero(FormatFloat('#,##0.00', 189))));
  FDicVar.AddOrSetValue('NOMEMP','Nome da Empresa');
  FDicVar.AddOrSetValue('ENDEMP','Endereço da Empresa');
  FDicVar.AddOrSetValue('CGCEMP','04.562.779/0001-90');
  FDicVar.AddOrSetValue('IESEMP','19,87');
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
end;

procedure TRelCtrComissaoProfissionais.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRelCtrComissaoProfissionais.pDefineFilaImpressao(blnConfigurar: Boolean);
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

function TRelCtrComissaoProfissionais.fOnUserFunctionEvent(
  const MethodName: String; var Params: Variant): Variant;
begin
//
end;

function TRelCtrComissaoProfissionais.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;


function TRelCtrComissaoProfissionais.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TRelCtrComissaoProfissionais.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TRelCtrComissaoProfissionais.fGetIsEmpty: Boolean;
begin
  Result := FCdsRecibo.IsEmpty;
end;

function TRelCtrComissaoProfissionais.fGetKey: String;
begin
  If fCfgSis('MODRPA', varInteger) = 1 Then
  Begin
    Result := 'MDRPA1';
  End
  Else If fCfgSis('MODRPA', varInteger) = 2 Then
  Begin
    Result := 'MDRPA2';
  End
  Else If fCfgSis('MODRPA', varInteger) = 3 Then
  Begin
    Result := 'MDRPA3';
  End
  Else If fCfgSis('MODRPA', varInteger) = 4 Then
  Begin
    Result := 'MDRPA4';
  End;
end;

function TRelCtrComissaoProfissionais.fGetName: String;
begin
  If fCfgSis('MODRPA', varInteger) = 1 Then
  Begin
    Result := 'COMISSÃO DE PROFISSIONAIS - MODELO 1';
  End
  Else If fCfgSis('MODRPA', varInteger) = 2 Then
  Begin
    Result := 'COMISSÃO DE PROFISSIONAIS - MODELO 2';
  End
  Else If fCfgSis('MODRPA', varInteger) = 3 Then
  Begin
    Result := 'COMISSÃO DE PROFISSIONAIS - MODELO 3';
  End
  Else If fCfgSis('MODRPA', varInteger) = 4 Then
  Begin
    Result := 'COMISSÃO DE PROFISSIONAIS -  MODELO 4';
  End
end;

function TRelCtrComissaoProfissionais.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRelCtrComissaoProfissionais.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRelCtrComissaoProfissionais.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRelCtrComissaoProfissionais.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TRelCtrComissaoProfissionais.fMontaEmissao(strNumDoc, strEspDoc,
  strCodEmp: String): String;
begin
  Result := '01/01/2001';
end;

function TRelCtrComissaoProfissionais.fMontaVencimentos(strNumDoc, strEspDoc,
  strCodEmp: String): String;
begin
Result := '01/01/2001';
end;

function TRelCtrComissaoProfissionais.fPrepareDataSetsAndVariables: Boolean;
begin
  pCarregaVariaveis;
  pCarregaListaFuncoes;
  Result := True;
end;



function TRelCtrComissaoProfissionais.fRetQtdReg: Integer;
begin
Result := 10;
end;

function TRelCtrComissaoProfissionais.fVerificaComponenteRelExiste(strComponente,
                                                            strInformacao: String;
                                                            blnVisible : Boolean = True): Boolean;
begin
Result := False;
end;

function fCriaClientDatasetRelCtrComissaoProfissionais: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  Result.FieldDefs.Add('NOMREC',ftString,60);
  Result.FieldDefs.Add('VALREC',ftFloat);
  Result.FieldDefs.Add('VALEXT',ftString,1000);
  Result.FieldDefs.Add('HISREC',ftString,200);
  Result.FieldDefs.Add('HISREC_02',ftString,200);
  Result.FieldDefs.Add('HISREC_03',ftString,200);
  Result.FieldDefs.Add('DTAREC',ftString,100);
  Result.FieldDefs.Add('NOMASS',ftString,40);
  Result.FieldDefs.Add('NROVIA',ftFloat);
  Result.FieldDefs.Add('VALTOT',ftFloat);
  Result.FieldDefs.Add('VALIMP',ftFloat);
  Result.FieldDefs.Add('NOMLIB',ftString,30);
  Result.FieldDefs.Add('NROREC',ftString,10);
  Result.FieldDefs.Add('NUMPIS',ftString,15);
  Result.FieldDefs.Add('MARCA_',ftString,1);

  Result.CreateDataSet;
end;

end.
