{**************************************************************************}
{* IMPRESSAO DO RECIBO DE PAGTO A FUNCIONARIOS CUSTOMIZADA DO FAST REPORT *}
{***********************************************************************LM*}

unit untRelRecPagtoFuncCtr;

interface

uses
  untValorPorExtenso,
  untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica, untTypesSistema, untIFastPrint,
  frxClass, frxDBSet, Uni, UniClientDataSet, DB,
  System.DateUtils, System.Generics.Collections, System.Variants, System.SysUtils, System.Classes;

Type
  TRecPagtoFuncCtr = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FListaFuncoes: TStringList;
      FUniClientDataSetGen: TUniClientDataSet;
      FFrxDBDataSetGen: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      {********************************}
      {* VARIAVEIS SÓ DESTE RELATORIO *}
      {********************************}
      FFrxUserDataSetEmpresa: TfrxUserDataset;
      FFrxDBDataSetEmpresa: TfrxDBDataset;
      FFrxUserDataSetComandos: TfrxUserDataset;
      FFrxDBDataSetComandos: TfrxDBDataset;
      blnMensal: boolean;
//      strTipImp: string;

      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      procedure pIniciaObjetos;
      procedure pCarregaVariaveis;
      function fGetIsEmpty: Boolean;
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      {******************************}
      {* METODOS SÓ DESTE RELATORIO *}
      {******************************}
      procedure frxComandosGetValue(const VarName: String; var Value: Variant);
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
      constructor Create(strOpcao: string);
      constructor CreateInstance;
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
  end;

function fCriaClientDatasetGenCTR(blnMensal: boolean): TUniClientDataSet;
function fCriaCdsMensal: TUniClientDataSet;
function fCriaCdsEvento: TUniClientDataSet;

function fCriaDatasetEmpresa: TfrxUserDataset;
function fCriaDatasetComandos: TfrxUserDataset;

Const
  FILA_IMPRESSAO_CTR = 'frmRelRecPagtoFunc';

implementation

{ TRecPagtoFuncCtr }

constructor TRecPagtoFuncCtr.Create(strOpcao: string);
begin
  FModoDesigner := True;
  FPais := fSetaPais;
  blnMensal := strOpcao = 'MENSAL';

  FUniClientDataSetGen := fCriaClientDatasetGenCTR(blnMensal);

  case blnMensal of
    true:
    begin
      FUniClientDataSetGen.Append;
      FUniClientDataSetGen.FieldByName('VER_DESVER').AsString := 'VER_DESVER';
      FUniClientDataSetGen.FieldByName('VER_CODVER').AsString := 'VER_CODVER';
      FUniClientDataSetGen.FieldByName('FUN_NOMFUN').AsString := 'NOME FUNCIONARIO';
      FUniClientDataSetGen.FieldByName('EMP_NOMEMP').AsString := 'WMS - NAO MUDAR - EMPRESA 001';
      FUniClientDataSetGen.FieldByName('EMP_ENDERE').AsString := 'ENDEREÇO';
      FUniClientDataSetGen.FieldByName('EMP_C_G_C_').AsString := fFormataCpfCgc('46431102000162', FPais);
      FUniClientDataSetGen.FieldByName('CODVER').AsString := 'CODVER';
      FUniClientDataSetGen.FieldByName('DESVER').AsString := '001 - SALARIO BASE';
      FUniClientDataSetGen.FieldByName('VALLAN').AsFloat  := 999999.99;
      FUniClientDataSetGen.FieldByName('CODFUN').AsString := '000305';
      FUniClientDataSetGen.FieldByName('NOMFUN').AsString := '000305 - NOME FUNCIONARIO';
      FUniClientDataSetGen.FieldByName('NUMBCO').AsString := '230 - BANCO BANDEIRANTE S.A.';
      FUniClientDataSetGen.FieldByName('AGENCI').AsString := '98765';
      FUniClientDataSetGen.FieldByName('CONTA_').AsString := '1234567890';
      FUniClientDataSetGen.FieldByName('DEBCRE').AsString := 'DEBCRE';
      FUniClientDataSetGen.FieldByName('CODDEB').AsString := 'CODDEB';
      FUniClientDataSetGen.FieldByName('DESDEB').AsString := 'DESDEB';
      FUniClientDataSetGen.FieldByName('VALDEB').AsFloat  := 111111.11;
      FUniClientDataSetGen.FieldByName('CODEMP').AsString := VS_strCodEmp;
      FUniClientDataSetGen.FieldByName('AUTFUN').AsString := 'AUTFUN';
      FUniClientDataSetGen.FieldByName('HIST01').AsString := 'JUSTIFICATIVA DE PAGAMENTO';
      FUniClientDataSetGen.Post;
    end;
    else
    begin
      FUniClientDataSetGen.Append;
      FUniClientDataSetGen.FieldByName('NOMREC').AsString := 'NOME FUNCIONARIO';
      FUniClientDataSetGen.FieldByName('VALREC').AsString := '999.999,99';
      FUniClientDataSetGen.FieldByName('CPFFUN').AsString := fFormataCpfCgc('09908807711', FPais);
      FUniClientDataSetGen.FieldByName('DTAEVE').AsString := DateToStr(Date);
      FUniClientDataSetGen.FieldByName('VLREXT').AsString := UpperCase(fRetExtensoNumero('999999,99'));
      FUniClientDataSetGen.FieldByName('HISREC').AsString := 'DESCRIÇÃO DO EVENTO';
      FUniClientDataSetGen.FieldByName('NROVIA').AsString := '1';
      FUniClientDataSetGen.FieldByName('DTAREC').AsString := fRetDataExtenso(Date, True);
      FUniClientDataSetGen.FieldByName('DTAEVEINC').AsString := DateToStr(IncDay(Date, 1));
      FUniClientDataSetGen.Post;

      FFrxUserDataSetEmpresa := fCriaDatasetEmpresa;
      FFrxUserDataSetComandos := fCriaDatasetComandos;
      FFrxUserDataSetComandos.OnGetValue := frxComandosGetValue;
    end;
  end;

  pIniciaObjetos;
end;

constructor TRecPagtoFuncCtr.CreateInstance;
begin
  FModoDesigner := False;

  FUniClientDataSetGen := TUniClientDataSet.Create(Nil);

  case blnMensal of
    false:
    begin
      FFrxUserDataSetComandos := TfrxUserDataset.Create(Nil);
      FFrxUserDataSetEmpresa := TfrxUserDataset.Create(Nil);
    end;
  end;

  pIniciaObjetos;
end;

destructor TRecPagtoFuncCtr.Destroy;
begin
  FreeAndNil(FDicVar);
  FreeAndNil(FListaFuncoes);

  FreeAndNil(FUniClientDataSetGen);
  FreeAndNil(FFrxDBDataSetGen);

  inherited;
end;

{********************************}
{********************************}
{********************************}

function TRecPagtoFuncCtr.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TRecPagtoFuncCtr.fGetFastType: TFastFileType;
begin
  case FTipImp[1] of
    'M': Result := ffMatrix;
    else Result := ffLaser;
  end;
end;

function TRecPagtoFuncCtr.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TRecPagtoFuncCtr.fGetIsEmpty: Boolean;
begin
  Result := FUniClientDataSetGen.IsEmpty;
end;

function TRecPagtoFuncCtr.fGetKey: String;
begin
  case blnMensal of
    true: Result := 'RECPFM';
    else Result := 'RECPFE';
  end;
end;

function TRecPagtoFuncCtr.fGetName: String;
begin
  case blnMensal of
    true: Result := 'RECIBO DE PAGAMENTO DE FUNCIONÁRIOS - MENSAL';
    else Result := 'RECIBO DE PAGAMENTO DE FUNCIONÁRIOS - EVENTO';
  end;
end;

function TRecPagtoFuncCtr.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TRecPagtoFuncCtr.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TRecPagtoFuncCtr.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TRecPagtoFuncCtr.fGetVariables: TDictionary<String, Variant>;
begin
  Result := FDicVar;
end;

function TRecPagtoFuncCtr.fOnUserFunctionEvent(const MethodName: String;
  var Params: Variant): Variant;
begin
  //
end;

procedure TRecPagtoFuncCtr.pCarregaVariaveis;
begin
  FDicVar.AddOrSetValue('PERIODO', '01/2020');
end;

function TRecPagtoFuncCtr.fPrepareDataSetsAndVariables: Boolean;
begin
  result := true;

  pCarregaVariaveis;
  pCarregaListaFuncoes;
end;

procedure TRecPagtoFuncCtr.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
//  FListaFuncoes.Add('function fFormataFonePaisInterna(strFone: String): String;');
end;

procedure TRecPagtoFuncCtr.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TRecPagtoFuncCtr.pDefineFilaImpressao(blnConfigurar: Boolean);
var
  qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_CTR);

  case blnConfigurar of
    true: pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_CTR);
  end;

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  case blnMensal of
    true: FTipImp := 'J';
    else case fEmptyStr(FTipImp) of True: FTipImp := 'J'; end;
  end;

  FreeAndNil(qryCfgRel);
end;

procedure TRecPagtoFuncCtr.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;

  FListaFuncoes := TStringList.Create;

  FFrxDBDataSetGen := TfrxDBDataset.Create(nil);
  FFrxDBDataSetGen.Name := 'frxRelatorio';
  FFrxDBDataSetGen.DataSet := FUniClientDataSetGen;

  SetLength(FArrDBDataSet, 1);
  FArrDBDataSet[0] := FFrxDBDataSetGen;

  case blnMensal of
    false:
    begin
      FFrxDBDataSetEmpresa := TfrxDBDataset.Create(nil);
      FFrxDBDataSetEmpresa.Name := 'frxGen';
      TfrxUserDataSet(FFrxDBDataSetEmpresa) := FFrxUserDataSetEmpresa;

      FFrxDBDataSetComandos := TfrxDBDataset.Create(nil);
      FFrxDBDataSetComandos.Name := 'frxComandos';
      TfrxUserDataSet(FFrxDBDataSetComandos) := FFrxUserDataSetComandos;
      TfrxUserDataSet(FFrxDBDataSetComandos).OnGetValue := frxComandosGetValue;

      SetLength(FArrDBDataSet, 3);
      FArrDBDataSet[1] := FFrxDBDataSetEmpresa;
      FArrDBDataSet[2] := FFrxDBDataSetComandos;
    end;
  end;

  pDefineFilaImpressao(False);
end;

procedure TRecPagtoFuncCtr.frxComandosGetValue(const VarName: String; var Value: Variant);
begin
  Value := '';

  case FTipImp[1] of
    'M':
    begin
      {****************************}
      {* ESPAÇAMENTO ENTRE LINHAS *}
      {*************************AF*}
      If VarName = 'UM_OITAVO_ON' Then
        Value := '#270'
      Else If VarName = 'UM_OITAVO_OFF' Then
        Value := '#272'

      {***********}
      {* NEGRITO *}
      {********AF*}
      Else If VarName = 'NEGRITO_ON' Then
        Value := '#27#69'
      Else If VarName = 'NEGRITO_OFF' Then
        Value := '#27#70'

      {*************}
      {* EXPANDIDO *}
      {**********AF*}
      Else If VarName = 'EXPANDIDO_ON' Then
        Value := '#27#871'
      Else If VarName = 'EXPANDIDO_OFF' Then
        Value := '#27#870'

      {*************}
      {* ITÁLICO   *}
      {**********AF*}
      Else If VarName = 'ITALICO_ON' Then
        Value := '#274'
      Else If VarName = 'ITALICO_OFF' Then
        Value := '#275'

      {*************************}
      {* CONDENSADO PARA 10CPI *}
      {**********************AF*}
      Else If VarName = 'COND_10CPI_ON' Then
        Value := '#15#27#80'
      Else If VarName = 'COND_10CPI_OFF' Then
        Value := '#18#27#80'

      {*************************}
      {* CONDENSADO PARA 12CPI *}
      {**********************AF*}
      Else If VarName = 'COND_12CPI_ON' Then
        Value := '#15#27#77'
      Else If VarName = 'COND_12CPI_OFF' Then
        Value := '#18#27#77'

      {**************************************}
      {* RESETA                             *}
      {***********************************AF*}
      Else If VarName = 'RESETA' Then
        Value := '#27#64#18#27#80';
    end;
  end;
end;

{********************}
{* FUNÇÕES ANÔNIMAS *}
{********************}

function fCriaClientDatasetGenCTR(blnMensal: boolean): TUniClientDataSet;
begin
  case blnMensal of
    true: result := fCriaCdsMensal;
    else result := fCriaCdsEvento;
  end;
end;

function fCriaCdsMensal: TUniClientDataSet;
var
  i1: integer;
  strSql: string;
  qryGenerica : TUniQuery;
begin
  Result := TUniClientDataSet.Create(nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE';
  strSQL := strSQL + '       CONCAT(VER_CODVER, " - ", VER_DESVER) AS DESVER, ';
  strSQL := strSQL + '       CONCAT(PAG_CODFUN, " - ", FUN_NOMFUN) AS NOMFUN, ';
  strSQL := strSQL + '       CONCAT(BCO_CODBCO, " - ", BCO_NOMBCO) AS NUMBCO, ';
  strSQL := strSQL + '       PAG_CODVER AS CODVER, ';
  strSQL := strSQL + '       PAG_VALLAN AS VALLAN, ';
  strSQL := strSQL + '       PAG_CODFUN AS CODFUN, ';
  strSQL := strSQL + '       VER_CODVER, ';
  strSQL := strSQL + '       VER_DEBCRE AS DEBCRE, ';
  strSQL := strSQL + '       VER_DESVER, ';
  strSQL := strSQL + '       FUN_NOMFUN, ';
  strSQL := strSQL + '       FUN_AGENCI AS AGENCI, ';
  strSQL := strSQL + '       FUN_CONTA_ AS CONTA_, ';
  strSQL := strSQL + '       "   " AS CODDEB, ';
  strSQL := strSQL + '       REPEAT(" ",30) AS DESDEB, ';
  strSQL := strSQL + '       0.00 AS VALDEB, ';
  strSQL := strSQL + '       EMP_NOMEMP, ';
  strSQL := strSQL + '       EMP_ENDERE, ';
  strSQL := strSQL + '       EMP_C_G_C_, ';
  strSQL := strSQL + '       PAG_CODEMP AS CODEMP, ';
  strSQL := strSQL + '       PAG_AUTFUN AS AUTFUN, ';
  strSQL := strSQL + '       CADPAG.CTP_HIST01 AS HIST01 ';

  strSQL := strSQL + '  FROM CTRPAG ';
  strSQL := strSQL + '  LEFT JOIN CADFUN ON CADFUN.AUTOINCREM=PAG_AUTFUN ';
  strSQL := strSQL + '  LEFT JOIN CADVER ON VER_CODVER = PAG_CODVER ';
  strSQL := strSQL + '  LEFT JOIN CADEMP ON EMP_CODEMP = PAG_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADBCO ON BCO_CODBCO = FUN_BANCO_ ';
  strSQL := strSQL + '  LEFT JOIN CADPAG ON CADPAG.AUTOINCREM  = PAG_AUTCTP ';

  strSql := strSql + ' WHERE FALSE';

  qryGenerica := fCriaQuery;
  try
    qryGenerica.SQL.Text := strSql;
    qryGenerica.Open;
    for i1 := 0 to qryGenerica.FieldDefs.Count - 1 do
    begin
      Result.FieldDefs.Add(qryGenerica.Fields[i1].FullName,qryGenerica.Fields[i1].DataType,qryGenerica.Fields[i1].Size);
    end;
  finally
    FreeAndNil(qryGenerica);
  end;

  Result.CreateDataSet;
end;

function fCriaCdsEvento: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);

  Result.FieldDefs.Add('VALREC',ftString,10);
  Result.FieldDefs.Add('NOMREC',ftString,50);
  Result.FieldDefs.Add('VLREXT',ftString,255);
  Result.FieldDefs.Add('HISREC',ftString,1000);
  Result.FieldDefs.Add('NROVIA',ftString,10);
  Result.FieldDefs.Add('DTAREC',ftString,200);
  Result.FieldDefs.Add('CPFFUN',ftString,20);
  Result.FieldDefs.Add('DTAEVE',ftString,10);
  Result.FieldDefs.Add('DTAEVEINC',ftString,20);

  Result.CreateDataSet;
end;

function fCriaDatasetEmpresa: TfrxUserDataset;
begin
  Result := TfrxUserDataset.Create(nil);
  Result.Name := 'frxGen';
  result.Fields.Add('EMP_NOMEMP');
  result.Fields.Add('REL_NOMREL');
end;

function fCriaDatasetComandos: TfrxUserDataset;
const
  arrNomes: TArray<String> = ['UM_OITAVO_OFF', 'NEGRITO_ON', 'NEGRITO_OFF',
                              'EXPANDIDO_ON', 'EXPANDIDO_OFF', 'ITALICO_ON', 'ITALICO_OFF',
                              'COND_10CPI_ON', 'COND_10CPI_OFF', 'COND_12CPI_ON', 'COND_12CPI_OFF',
                              'RESETA'];
var
  i1: integer;
begin
  result := TfrxUserDataset.Create(nil);
  result.Name := 'frxComandos';

  for i1 := 0 to High(arrNomes) do
    result.Fields.Add(arrNomes[i1]);
end;

end.
