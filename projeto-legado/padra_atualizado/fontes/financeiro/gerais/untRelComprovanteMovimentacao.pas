unit untRelComprovanteMovimentacao;

interface

uses
  Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, Uni,
  UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint;

type
  TRelComprovanteMovimentacao = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FListaFuncoes: TStringList;
      FRelComprovanteMovimentacao: TUniClientDataSet;
      FRelComprovanteMovContraPar: TUniClientDataSet;
      FDataSetRelCtrCompRecebMod: TfrxDBDataset;
      FDataSetRelCtrCompRecebCon: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;

      function fGetIsEmpty: Boolean;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      procedure pIniciaObjetos;
      procedure pCarregaVariaveis;
    protected
      function fGetKey: String;
      function fGetName: String;
      function fGetDBDataSets: TArrFrxDBDataSet;
      function fGetUserDataSets: TArrFrxUserDataSet;
      function fGetUserFunction: TfrxUserFunctionEvent;
      function fGetVariables: TDictionary<String,Variant>;
      function fPrepareDataSetsAndVariables: Boolean;
      function fGetPrinterName: String;
      function fGetFastType: TFastFileType;
      function fGetFunctionsList: TStringList;
      procedure pConfigTypeAndPrinterName;
    public
      constructor Create;
      constructor CreateInstance(cdsRelComprovanteMovimentacao, cdsRelComprovanteMovimContra: TUniClientDataSet);
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
end;

function fCriaClientDatasetRelCompMov : TUniClientDataSet;
function fCriaClientDatasetRelCompCon: TUniClientDataSet;

Const
  FILA_IMPRESSAO_COMP_MOV = 'frmMovCadBancario';

implementation

{ TRelComprovanteMovimentacao }

constructor TRelComprovanteMovimentacao.Create;
begin
  FModoDesigner := True;

  FPais   := fSetaPais;
  FRelComprovanteMovimentacao := fCriaClientDatasetRelCompMov;

  FRelComprovanteMovimentacao.Append;
  FRelComprovanteMovimentacao.FieldByName('CTB_CODPOR').AsString   := '00356';
  FRelComprovanteMovimentacao.FieldByName('POR_NOMPOR').AsString   := 'BANCO SANTANDER';
  FRelComprovanteMovimentacao.FieldByName('CTB_CODOPE').AsString   := '998';
  FRelComprovanteMovimentacao.FieldByName('OPE_NOMOPE').AsString   := 'PROGRAMAÇÃO';
  FRelComprovanteMovimentacao.FieldByName('CTB_DTALAN').AsDateTime := StrToDateTime('13/04/2020');
  FRelComprovanteMovimentacao.FieldByName('CTB_NUMDOC').AsString   := '1397596';
  FRelComprovanteMovimentacao.FieldByName('CTB_CREDEB').AsString   := 'C';
  FRelComprovanteMovimentacao.FieldByName('CTB_VALLAN').AsFloat    := 8740.00;
  FRelComprovanteMovimentacao.FieldByName('CTB_HIST01').AsString   := 'HISTÓRICO 1 DE EXEMPLOS DA LAYIMP';
  FRelComprovanteMovimentacao.FieldByName('CTB_HIST02').AsString   := 'HISTÓRICO 2 EXEMPLO';
  FRelComprovanteMovimentacao.FieldByName('CTB_CODEMP').AsString   := '001';
  FRelComprovanteMovimentacao.FieldByName('EMP_NOMEMP').AsString   := 'EMPRESA BRASILEIRA EXEMPLO LTDA';
  FRelComprovanteMovimentacao.FieldByName('CTB_CODEVE').AsString   := '00012';
  FRelComprovanteMovimentacao.FieldByName('EVE_DESEVE').AsString   := 'DESCRIÇÃO CENTRO DE CUSTO';
  FRelComprovanteMovimentacao.FieldByName('CTB_COMPET').AsString   := '04/2020';
  FRelComprovanteMovimentacao.FieldByName('CTB_GERCON').AsInteger  := 1;
  FRelComprovanteMovimentacao.FieldByName('CTB_SEQCTP').AsString   := '001274';
  FRelComprovanteMovimentacao.FieldByName('CTB_EMPTRA').AsString   := '';
  FRelComprovanteMovimentacao.FieldByName('CTB_CODCTA').AsString   := '0101001';
  FRelComprovanteMovimentacao.FieldByName('CTA_DESCTA').AsString   := 'VENDAS A VISTA';

  FRelComprovanteMovimentacao.Post;

  FRelComprovanteMovContraPar := fCriaClientDatasetRelCompCon;

  FRelComprovanteMovContraPar.Append;
  FRelComprovanteMovContraPar.FieldByName('CTB_CODPOR').AsString   := '01040';
  FRelComprovanteMovContraPar.FieldByName('POR_NOMPOR').AsString   := 'CAIXA ECONOMICA FEDERAL - JGS';
  FRelComprovanteMovContraPar.FieldByName('CTB_CODCTA').AsString   := '0205012';
  FRelComprovanteMovContraPar.FieldByName('CTA_DESCTA').AsString   := 'ENTREGAS TERCEIRIZADAS';
  FRelComprovanteMovContraPar.FieldByName('CTB_GERCON').AsInteger  := 0;
  FRelComprovanteMovContraPar.FieldByName('CTB_CODOPE').AsString   := '998';
  FRelComprovanteMovContraPar.FieldByName('OPE_NOMOPE').AsString   := 'PROGRAMAÇÃO';
  FRelComprovanteMovContraPar.FieldByName('CTB_CODEMP').AsString   := '013';
  FRelComprovanteMovContraPar.FieldByName('EMP_NOMEMP').AsString   := 'EMPRESA ARTHUR SCHOPENHAUER LTDA';

  FRelComprovanteMovContraPar.Post;

  pIniciaObjetos;
end;

constructor TRelComprovanteMovimentacao.CreateInstance(cdsRelComprovanteMovimentacao, cdsRelComprovanteMovimContra: TUniClientDataSet);
begin
  FModoDesigner := False;

  FRelComprovanteMovimentacao      := TUniClientDataSet.Create(Nil);
  FRelComprovanteMovimentacao.Data := cdsRelComprovanteMovimentacao.Data;

  FRelComprovanteMovContraPar      := TUniClientDataSet.Create(Nil);
  FRelComprovanteMovContraPar.Data := cdsRelComprovanteMovimContra.Data;

  pIniciaObjetos;
end;

procedure TRelComprovanteMovimentacao.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetRelCtrCompRecebMod := TfrxDBDataset.Create(nil);
  FDataSetRelCtrCompRecebMod.Name := 'frxDBGeral';
  FDataSetRelCtrCompRecebMod.DataSet := FRelComprovanteMovimentacao;

  FDataSetRelCtrCompRecebCon := TfrxDBDataset.Create(nil);
  FDataSetRelCtrCompRecebCon.Name := 'frxDBContra';
  FDataSetRelCtrCompRecebCon.DataSet := FRelComprovanteMovContraPar;

  SetLength(FArrDBDataSet, 2);
  FArrDBDataSet[0] := FDataSetRelCtrCompRecebMod;
  FArrDBDataSet[1] := FDataSetRelCtrCompRecebCon;

  pDefineFilaImpressao(False);
end;

destructor TRelComprovanteMovimentacao.Destroy;
begin
  FreeAndNil(FRelComprovanteMovimentacao);
  FreeAndNil(FRelComprovanteMovContraPar);
  FreeAndNil(FDataSetRelCtrCompRecebMod);
  FreeAndNil(FDataSetRelCtrCompRecebCon);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);
  inherited;
end;

procedure TRelComprovanteMovimentacao.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRelComprovanteMovimentacao.pDefineFilaImpressao(blnConfigurar: Boolean);
var
  qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_COMP_MOV);

  if blnConfigurar then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_COMP_MOV);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  if fEmptyStr(FTipImp) then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

function TRelComprovanteMovimentacao.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TRelComprovanteMovimentacao.fGetFastType: TFastFileType;
begin
  if FTipImp <> 'M' then
    Result := ffLaser
  else
    Result := ffMatrix;
end;

function TRelComprovanteMovimentacao.fGetFunctionsList: TStringList;
begin
  Result := FListaFuncoes;
end;

function TRelComprovanteMovimentacao.fGetIsEmpty: Boolean;
begin
  Result := FRelComprovanteMovimentacao.IsEmpty;
end;

function TRelComprovanteMovimentacao.fGetKey: String;
begin
  Result := 'COMPMV';
end;

function TRelComprovanteMovimentacao.fGetName: String;
begin
  Result := 'COMPROVANTE MOVIMENTAÇÃO/TRANSFERÊNCIA DE CONTA BANCO';
end;

function TRelComprovanteMovimentacao.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRelComprovanteMovimentacao.fGetUserDataSets: TArrFrxUserDataSet;
begin
//
end;

function TRelComprovanteMovimentacao.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRelComprovanteMovimentacao.fGetVariables: TDictionary<String, Variant>;
begin
  Result := FDicVar;
end;

function TRelComprovanteMovimentacao.fOnUserFunctionEvent(
  const MethodName: String; var Params: Variant): Variant;
begin
// AM
end;

procedure TRelComprovanteMovimentacao.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  //
end;

procedure TRelComprovanteMovimentacao.pCarregaVariaveis;
begin
  FDicVar.AddOrSetValue('NOMREL', 'Comprovante de Movimentação/Transferência de Conta Banco');
  FDicVar.AddOrSetValue('NOMOPE', '998 - PROGRAMAÇÃO');
end;

function TRelComprovanteMovimentacao.fPrepareDataSetsAndVariables: Boolean;
begin
  pCarregaVariaveis;
  pCarregaListaFuncoes;
  Result := True;
end;

function fCriaClientDatasetRelCompMov: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);

  Result.FieldDefs.Add('CTB_CODCTA',ftString,7);
  Result.FieldDefs.Add('CTB_CODPOR',ftString,5);
  Result.FieldDefs.Add('CTB_CODOPE',ftString,3);
  Result.FieldDefs.Add('CTB_DTALAN',ftDate);
  Result.FieldDefs.Add('CTB_NUMDOC',ftString,12);
  Result.FieldDefs.Add('CTB_CREDEB',ftString,1);
  Result.FieldDefs.Add('CTB_VALLAN',ftFloat);
  Result.FieldDefs.Add('CTB_HIST01',ftString,60);
  Result.FieldDefs.Add('CTB_HIST02',ftString,60);
  Result.FieldDefs.Add('CTB_CODEMP',ftString,3);
  Result.FieldDefs.Add('CTB_CODEVE',ftString,5);
  Result.FieldDefs.Add('CTB_COMPET',ftString,7);
  Result.FieldDefs.Add('CTB_GERCON',ftInteger);
  Result.FieldDefs.Add('CTB_SEQCTP',ftString,6);
  Result.FieldDefs.Add('CTB_EMPTRA',ftString,3);
  Result.FieldDefs.Add('EMP_NOMEMP',ftString,60);
  Result.FieldDefs.Add('POR_NOMPOR',ftString,40);
  Result.FieldDefs.Add('CTA_DESCTA',ftString,40);
  Result.FieldDefs.Add('EVE_DESEVE',ftString,70);
  Result.FieldDefs.Add('OPE_NOMOPE',ftString,30);

  Result.CreateDataSet;
end;

function fCriaClientDatasetRelCompCon: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);

  Result.FieldDefs.Add('CTB_CODPOR',ftString,5);
  Result.FieldDefs.Add('POR_NOMPOR',ftString,40);
  Result.FieldDefs.Add('CTB_CODCTA',ftString,7);
  Result.FieldDefs.Add('CTA_DESCTA',ftString,40);
  Result.FieldDefs.Add('CTB_GERCON',ftInteger);
  Result.FieldDefs.Add('CTB_CODOPE',ftString,3);
  Result.FieldDefs.Add('OPE_NOMOPE',ftString,30);
  Result.FieldDefs.Add('CTB_CODEMP',ftString,3);
  Result.FieldDefs.Add('EMP_NOMEMP',ftString,60);

  Result.CreateDataSet;
end;

end.

