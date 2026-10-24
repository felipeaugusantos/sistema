unit untRelCtrCompRecbMod;

interface

uses
  Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint;

type
  TRelCtrCompRecbMod = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FRelCtrCompRecbMod: TUniClientDataSet;
      FListaFuncoes: TStringList;
      FDataSetRelCtrCompRecebMod: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;

      function fGetIsEmpty: Boolean;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      function fRemoveAcentos(strHistor: String): String;
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
      constructor CreateInstance(cdsRelCtrCompRecbMod: TUniClientDataSet);
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
end;

function fCriaClientDatasetRelCtrCompRcebMod : TUniClientDataSet;

Const
  FILA_IMPRESSAO_DUP_CTR = 'impressao_duplicata_ctr';

implementation

{ TRelCtrCompRecbMod }

constructor TRelCtrCompRecbMod.Create;
begin
  FModoDesigner := True;

  FPais   := fSetaPais;
  FRelCtrCompRecbMod := fCriaClientDatasetRelCtrCompRcebMod;

  FRelCtrCompRecbMod.Append;
  FRelCtrCompRecbMod.FieldByName('CTR_NUMDUP').AsString        := '00000001';
  FRelCtrCompRecbMod.FieldByName('CTR_PARCEL').AsString        := 'A';
  FRelCtrCompRecbMod.FieldByName('CTR_ESPDOC').AsString        := 'RE';
  FRelCtrCompRecbMod.FieldByName('CLIENTE').AsString           := 'CLIENTE BRASIL LTDA(SP)';
  FRelCtrCompRecbMod.FieldByName('CLI_ENDERE').AsString        := 'RUA 1';
  FRelCtrCompRecbMod.FieldByName('CLI_BAIRRO').AsString        := 'CENTRO';
  FRelCtrCompRecbMod.FieldByName('CID_NOMCID').AsString        := 'CIDADE X';
  FRelCtrCompRecbMod.FieldByName('CLI_FONE01').AsString        := '(XX) XXXX-XXXX';
  FRelCtrCompRecbMod.FieldByName('VENDEDOR').AsString          := '999 - ADMINISTRA«√O CITEL';
  FRelCtrCompRecbMod.FieldByName('CTR_DTACAD').AsDateTime      := StrToDateTime('01/01/2000');
  FRelCtrCompRecbMod.FieldByName('CTR_VALDUP').AsFloat         := 10;
  FRelCtrCompRecbMod.FieldByName('CTR_DESSUJ').AsFloat         := 1;
  FRelCtrCompRecbMod.FieldByName('CTR_DTAVEN').AsDateTime      := StrToDateTime('01/01/2000');
  FRelCtrCompRecbMod.FieldByName('CTR_DESCOB').AsFloat         := 0;
  FRelCtrCompRecbMod.FieldByName('CTR_NOSNUM').AsString        := '';
  FRelCtrCompRecbMod.FieldByName('PORTADOR').AsString          := '500 - BANCO B';
  FRelCtrCompRecbMod.FieldByName('EVENTO').AsString            := '';
  FRelCtrCompRecbMod.FieldByName('HIST01').AsString            := 'Receb. Conta 22';
  FRelCtrCompRecbMod.FieldByName('CTR_HIST02').AsString        := 'EXEMPLO HIST”RICO 2';
  FRelCtrCompRecbMod.FieldByName('CTR_CODVEL').AsString        := '';
  FRelCtrCompRecbMod.FieldByName('CTR_DTAREC').AsDateTime      := StrToDateTime('01/01/2000');
  FRelCtrCompRecbMod.FieldByName('PORBAI').AsString            := '500 - BANCO B';
  FRelCtrCompRecbMod.FieldByName('CTR_CTABAI').AsString        := '';
  FRelCtrCompRecbMod.FieldByName('OPEBAI').AsString            := '999 - ADMINISTRA«√O CITEL';
  FRelCtrCompRecbMod.FieldByName('CTR_SEQBAI').AsInteger       := 0;
  FRelCtrCompRecbMod.FieldByName('CTR_VALORI').AsFloat         := 10;
  FRelCtrCompRecbMod.FieldByName('CTR_VALREC').AsFloat         := 9;
  FRelCtrCompRecbMod.FieldByName('CTR_DOCBAI').AsString        := '00000001';
  FRelCtrCompRecbMod.FieldByName('CTR_HISBAI').AsString        := 'EXEMPLO HIST”RICO BAIXA';
  FRelCtrCompRecbMod.FieldByName('CTR_DESCON').AsString        := '00000001';
  FRelCtrCompRecbMod.FieldByName('CLI_CGCCPF').AsString        := '';
  FRelCtrCompRecbMod.FieldByName('CLI_C_G_C_').AsString        := '';
  FRelCtrCompRecbMod.FieldByName('PLANOCONTA').AsString        := '0000001 - OUTRAS RECEITAS';
  FRelCtrCompRecbMod.FieldByName('EMP_NOMEMP').AsString        := '001-EMPRESA 001';

  FRelCtrCompRecbMod.Post;

  pIniciaObjetos;

end;

constructor TRelCtrCompRecbMod.CreateInstance(cdsRelCtrCompRecbMod: TUniClientDataSet);
begin
  FModoDesigner := False;

  FRelCtrCompRecbMod      := TUniClientDataSet.Create(Nil);
  FRelCtrCompRecbMod.Data := cdsRelCtrCompRecbMod.Data;

  pIniciaObjetos;
end;

procedure TRelCtrCompRecbMod.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetRelCtrCompRecebMod := TfrxDBDataset.Create(nil);
  FDataSetRelCtrCompRecebMod.Name := 'frxDBDataset1';
  FDataSetRelCtrCompRecebMod.DataSet := FRelCtrCompRecbMod;

  SetLength(FArrDBDataSet, 1);
  FArrDBDataSet[0] := FDataSetRelCtrCompRecebMod;

  pDefineFilaImpressao(False);
end;

destructor TRelCtrCompRecbMod.Destroy;
begin
  FreeAndNil(FRelCtrCompRecbMod);
  FreeAndNil(FDataSetRelCtrCompRecebMod);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TRelCtrCompRecbMod.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRelCtrCompRecbMod.pDefineFilaImpressao(blnConfigurar: Boolean);
var
  qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_DUP_CTR);

  if blnConfigurar then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_DUP_CTR);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  if fEmptyStr(FTipImp) then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

function TRelCtrCompRecbMod.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TRelCtrCompRecbMod.fGetFastType: TFastFileType;
begin
  if FTipImp <> 'M' then
    Result := ffLaser
  else
    Result := ffMatrix;
end;

function TRelCtrCompRecbMod.fGetFunctionsList: TStringList;
begin
  Result := FListaFuncoes;
end;

function TRelCtrCompRecbMod.fGetIsEmpty: Boolean;
begin
  Result := FRelCtrCompRecbMod.IsEmpty;
end;

function TRelCtrCompRecbMod.fGetKey: String;
begin
  Result := 'DUPCTR';
end;

function TRelCtrCompRecbMod.fGetName: String;
begin
  Result := 'DUPLICATA - CONTAS A RECEBER';
end;

function TRelCtrCompRecbMod.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRelCtrCompRecbMod.fGetUserDataSets: TArrFrxUserDataSet;
begin

end;

function TRelCtrCompRecbMod.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRelCtrCompRecbMod.fGetVariables: TDictionary<String, Variant>;
begin
  Result := FDicVar;
end;

procedure TRelCtrCompRecbMod.pCarregaVariaveis;
begin
  FDicVar.AddOrSetValue('NOMREL', 'C.R. DUPLICATA');
  FDicVar.AddOrSetValue('DATAHORA', '');
  FDicVar.AddOrSetValue('NOMEFORM', '');
  FDicVar.AddOrSetValue('FONE01', '');
  FDicVar.AddOrSetValue('CGCCPF', '');
  FDicVar.AddOrSetValue('CGCCPF', '');
  FDicVar.AddOrSetValue('DUPDESCONTADA', '');
  FDicVar.AddOrSetValue('TIPOBAIXA', '');
  FDicVar.AddOrSetValue('JUROSAODIA', '');
end;

function TRelCtrCompRecbMod.fPrepareDataSetsAndVariables: Boolean;
begin
  pCarregaVariaveis;
  pCarregaListaFuncoes;
  Result := True;
end;

function TRelCtrCompRecbMod.fOnUserFunctionEvent(const MethodName: String;
  var Params: Variant): Variant;
begin
  if SameText('fRemoveAcentos', MethodName) then
    Result := fRemoveAcentos(Params[0]);
end;

procedure TRelCtrCompRecbMod.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fRemoveAcentos(strHistor: String): String;');
end;

function TRelCtrCompRecbMod.fRemoveAcentos(strHistor: String): String;
const
ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹"¥';
SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
var
		x : Integer;
begin
	for x := 1 to Length(strHistor) do
		if Pos(strHistor[x],ComAcento)<>0 then
			strHistor[x] := SemAcento[Pos(strHistor[x],ComAcento)];
  Result := strHistor;
end;

function fCriaClientDatasetRelCtrCompRcebMod: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);

  Result.FieldDefs.Add('CTR_NUMDUP',ftString,12);
  Result.FieldDefs.Add('CTR_PARCEL',ftString,3);
  Result.FieldDefs.Add('CTR_ESPDOC',ftString,2);
  Result.FieldDefs.Add('CLIENTE',ftString,68);
  Result.FieldDefs.Add('CLI_ENDERE',ftString,60);
  Result.FieldDefs.Add('CLI_BAIRRO',ftString,60);
  Result.FieldDefs.Add('CID_NOMCID',ftString,40);
  Result.FieldDefs.Add('CLI_FONE01',ftString,15);
  Result.FieldDefs.Add('VENDEDOR',ftString,33);
  Result.FieldDefs.Add('CTR_DTACAD',ftDate);
  Result.FieldDefs.Add('CTR_VALDUP',ftFloat);
  Result.FieldDefs.Add('CTR_DESSUJ',ftFloat);
  Result.FieldDefs.Add('CTR_DTAVEN',ftDate);
  Result.FieldDefs.Add('CTR_DESCOB',ftfloat);
  Result.FieldDefs.Add('CTR_NOSNUM',ftString,12);
  Result.FieldDefs.Add('PORTADOR',ftString,45);
  Result.FieldDefs.Add('EVENTO',ftString,45);
  Result.FieldDefs.Add('HIST01',ftMemo);
  Result.FieldDefs.Add('CTR_HIST02',ftString,50);
  Result.FieldDefs.Add('CTR_CODVEL',ftString,20);
  Result.FieldDefs.Add('CTR_DTAREC',ftDate);
  Result.FieldDefs.Add('PORBAI',ftString,45);
  Result.FieldDefs.Add('CTR_CTABAI',ftString,7);
  Result.FieldDefs.Add('OPEBAI',ftString,33);
  Result.FieldDefs.Add('CTR_SEQBAI',ftInteger);
  Result.FieldDefs.Add('CTR_VALORI',ftfloat);
  Result.FieldDefs.Add('CTR_VALREC',ftfloat);
  Result.FieldDefs.Add('CTR_DOCBAI',ftString,13);
  Result.FieldDefs.Add('CTR_HISBAI',ftString,50);
  Result.FieldDefs.Add('CTR_DESCON',ftString,1);
  Result.FieldDefs.Add('CLI_CGCCPF',ftString,8);
  Result.FieldDefs.Add('CLI_C_G_C_',ftString,8);
  Result.FieldDefs.Add('PLANOCONTA',ftString,47);
  Result.FieldDefs.Add('EMP_NOMEMP',ftString,60);

  Result.CreateDataSet;
end;

end.
