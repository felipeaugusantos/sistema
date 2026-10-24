{**************************************************************************}
{* IMPRESSAO DA FICHA CADASTRAL DO FUNCIONARIO CUSTOMIZADA DO FAST REPORT *}
{***********************************************************************LM*}

unit untRelFichaCadFuncionarioCtr;

interface

uses
  Classes, SysUtils, frxClass, frxDBSet, System.Generics.Collections, System.Variants,
  Uni, UniClientDataSet, DB, untFastPrintEditor, untFuncoesSimples, untFuncoesGenerica,
  untTypesSistema, untIFastPrint;

Type
  TFichaCadFuncionarioCtr = class(TInterfacedObject, IFastPrintFile)
    private
      FPais: TPais;
      FDicVar: TDictionary<String,Variant>;
      FDicTot: TDicionario;
      FListaFuncoes: TStringList;
      FUniClientDataset: TUniClientDataSet;
      frxGen: TUniClientDataSet;
      frxBeneficia: TUniClientDataSet;
      frxFerias: TUniClientDataSet;
      FCadEmp_: TUniQuery;
      FDataSetCadFuncionario: TfrxDBDataset;
      FDataSetEmp: TfrxDBDataset;
      FDataSetBeneficia: TfrxDBDataset;
      FDataSetFerias: TfrxDBDataset;
      FArrDBDataSet: TArrFrxDBDataSet;
      FNomImp: String;
      FTipImp: String;
      FModoDesigner: Boolean;
      procedure pDefineFilaImpressao(blnConfigurar: Boolean);
      procedure pCarregaListaFuncoes;
      procedure pIniciaObjetos;
      function fGetIsEmpty: Boolean;
      function fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      function fFormataFonePaisInterna(strFone: String): String;
      procedure pCarregaDadosEmpresa;
      procedure pCarregaVariaveis;
      function FrFileExists(FileName : string):boolean;
    function fFormataCpfCgcInterna(strValor: String): String;
    function fFormataCEPInterna(strValor: String): String;
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
      constructor CreateInstance;
      destructor Destroy; override;

      property IsEmpty: Boolean read fGetIsEmpty;
      property NomImp: string read FNomImp write FNomImp;
  end;

  function fCriaClientDatasetFichaCTR: TUniClientDataSet;
  function fCriaClientDatasetfrxGen: TUniClientDataSet;
  function fCriaClientDataSetfrxBeneficia: TUniClientDataSet;
  function fCriaClientDataSetfrxFerias: TUniClientDataSet;

Const
  FILA_IMPRESSAO_CTR = 'impressao_ficha_cad_funcionario_ctr';

implementation

uses
  untCfgRel, untValorPorExtenso;

{ TFichaCadFuncionarioCtr }

constructor TFichaCadFuncionarioCtr.Create;
CONST
  NUMERO_REG = 11;
  NUM_REGFERIAS = 1;
var
  intRegis,
  intCorre: integer;
begin
  FModoDesigner := True;
  FPais := fSetaPais;

  FUniClientDataset := fCriaClientDatasetFichaCTR;
  FUniClientDataset.Append;
  FUniClientDataset.FieldByName('FUN_CODEMP').AsString := VS_strCodEmp;
  FUniClientDataset.FieldByName('FUN_CODFUN').AsString := '000000000001';
  FUniClientDataset.FieldByName('FUN_NOMFUN').AsString := 'NOME FUNCIONARIO';
  FUniClientDataset.FieldByName('FUN_FUNCAO').AsString := 'FUNÇÃO FUNÇÃO';
  FUniClientDataset.FieldByName('FUN_PISPAS').AsString := '9999999999';
  FUniClientDataset.FieldByName('FUN_BANCO_').AsString := '999';
  FUniClientDataset.FieldByName('FUN_AGENCI').AsString := '88888';
  FUniClientDataset.FieldByName('FUN_CONTA_').AsString := '7777777777';
  FUniClientDataset.FieldByName('FUN_CARPON').AsString := 'SIM';
  FUniClientDataset.FieldByName('FUN_REGIST').AsString := 'NÃO';
  FUniClientDataset.FieldByName('FUN_DTAADM').AsDateTime := StrToDateTime('01/01/2000');
  FUniClientDataset.FieldByName('FUN_DTADEM').AsDateTime := StrToDateTime('01/01/2020');
  FUniClientDataset.FieldByName('FUN_SALBAS').AsFloat := 999999.99;
  FUniClientDataset.FieldByName('FUN_OBSERV').AsString := 'OBSERVAÇÃO TESTE OBSERVAÇÃO TESTE OBSERVAÇÃO TESTE ';
  FUniClientDataset.FieldByName('EMP_C_G_C_').AsString := '11111111000101';
  FUniClientDataset.FieldByName('FUN_C_E_P_').AsString := '18190123';
  FUniClientDataset.FieldByName('FUN_EMEXPE').AsString := 'S';
  FUniClientDataset.FieldByName('FUN_EXP45D').AsString := 'S';
  FUniClientDataset.FieldByName('FUN_EXPM45').AsString := 'N';
  FUniClientDataset.Post;

  frxGen := fCriaClientDatasetFrxGen;
  frxGen.Append;
  frxGen.FieldByName('EMP_NOMEMP').AsString := 'EMPRESA TESTE';
  frxGen.FieldByName('REL_NOMREL').AsString := 'frmRelFichaCadFuncionario';
  frxGen.Post;

  frxBeneficia := fCriaClientDataSetfrxBeneficia;
  frxBeneficia.Append;
  frxBeneficia.FieldByName('AUTOINCREM').AsString := '00000000000000105001';
  frxBeneficia.FieldByName('BNF_NOMBEN').AsString := 'BENEFICIARIO1';
  frxBeneficia.FieldByName('BNF_GRAPAR').AsString := 'FILHO(A)';
  frxBeneficia.FieldByName('BNF_CODFUN').AsString := '000337';
  frxBeneficia.FieldByName('BNF_CODEMP').AsString := '002';
  frxBeneficia.FieldByName('BNF_NUMCPF').AsString := '11111111111';
  frxBeneficia.FieldByName('BNF_DTANAS').AsDateTime := StrToDateTime('01/01/2020');
  frxBeneficia.FieldByName('BNF_NUMRG').AsString := '212511212';
  frxBeneficia.FieldByName('BNF_AUTFUN').AsString := '00000000000000205001';
  frxBeneficia.Post;

  For intRegis := frxBeneficia.RecordCount to NUMERO_REG -1 do
  Begin
    frxBeneficia.Append;
    for intCorre := 0 to frxBeneficia.Fields.Count - 1 do
      frxBeneficia.Fields[intCorre].AsVariant := null;

    frxBeneficia.Post;
  End;


  frxFerias := fCriaClientDataSetfrxFerias;
  frxFerias.Append;
  frxFerias.FieldByName('AUTOINCREM').AsString := '00000000006070148001';
  frxFerias.FieldByName('FER_AQUINI').AsDateTime := StrToDateTime('01/02/2023');
  frxFerias.FieldByName('FER_AQUFIN').AsDateTime := StrToDateTime('10/02/2023');
  frxFerias.FieldByName('FER_GOZINI').AsDateTime := StrToDateTime('11/02/2023');
  frxFerias.FieldByName('FER_GOZFIN').AsDateTime := StrToDateTime('14/02/2023');
  frxFerias.FieldByName('FER_DTAREC').AsDateTime := StrToDateTime('30/01/2023');
  frxFerias.FieldByName('FER_VALREC').AsFloat := 4500.85;
  frxFerias.Post;

  For intRegis := frxFerias.RecordCount to NUM_REGFERIAS -1 do
  Begin
    frxFerias.Append;
    for intCorre := 0 to frxFerias.Fields.Count -1 do
      frxFerias.Fields[intCorre].AsVariant := null;

    frxFerias.Post;
  End;

  pIniciaObjetos;
end;

constructor TFichaCadFuncionarioCtr.CreateInstance;
begin
  FModoDesigner := False;

  FUniClientDataset := TUniClientDataSet.Create(Nil);
  frxBeneficia := TUniClientDataSet.Create(Nil);
  frxFerias := TUniClientDataSet.Create(Nil);

  pIniciaObjetos;
end;

procedure TFichaCadFuncionarioCtr.pIniciaObjetos;
begin
  FDicVar := TDictionary<String,Variant>.Create;
  FDicTot := TDicionario.Create;

  FListaFuncoes := TStringList.Create;

  FDataSetCadFuncionario := TfrxDBDataset.Create(nil);
  FDataSetCadFuncionario.Name := 'frxRelatorio';
  FDataSetCadFuncionario.DataSet := FUniClientDataset;

  FDataSetEmp := TfrxDBDataset.Create(nil);
  FDataSetEmp.Name := 'frxGen';
  FDataSetEmp.DataSet := frxGen;

  FDataSetBeneficia := TfrxDBDataset.Create(nil);
  FDataSetBeneficia.Name := 'frxBeneficia';
  FDataSetBeneficia.DataSet := frxBeneficia;

  FDataSetFerias := TfrxDBDataset.Create(nil);
  FDataSetFerias.Name := 'frxFerias';
  FDataSetFerias.DataSet := frxFerias;

  SetLength(FArrDBDataSet, 4);
  FArrDBDataSet[0] := FDataSetEmp;
  FArrDBDataSet[1] := FDataSetCadFuncionario;
  FArrDBDataSet[2] := FDataSetBeneficia;
  FArrDBDataSet[3] := FDataSetFerias;

  pDefineFilaImpressao(False);
end;

destructor TFichaCadFuncionarioCtr.Destroy;
begin
  FreeAndNil(FUniClientDataset);
  FreeAndNil(FDataSetCadFuncionario);
  FreeAndNil(FCadEmp_);
  FreeAndNil(FDataSetEmp);
  FreeAndNil(frxBeneficia);
  FreeAndNil(frxFerias);
  FreeAndNil(FDataSetBeneficia);
  FreeAndNil(FDataSetFerias);
  FreeAndNil(FDicVar);
  FreeAndNil(FDicTot);
  FreeAndNil(FListaFuncoes);

  inherited;
end;

procedure TFichaCadFuncionarioCtr.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TFichaCadFuncionarioCtr.pDefineFilaImpressao(blnConfigurar: Boolean);
var
  qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_CTR);

  If blnConfigurar Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_CTR);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

procedure TFichaCadFuncionarioCtr.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fFormataFonePaisInterna(strFone: String): String;');
  FListaFuncoes.Add('function FrFileExists(FileName : string):boolean;');
  FListaFuncoes.Add('function fFormataCpfCgcInterna(strValor: String): String;');
  FListaFuncoes.Add('function fFormataCEPInterna(strCEP: String): String;');
end;

function TFichaCadFuncionarioCtr.fFormataCEPInterna(strValor: String): String;
begin
  Result := fFormataCep(strValor);
end;

function TFichaCadFuncionarioCtr.fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fFormataFonePaisInterna') Then
    Result := fFormataFonePaisInterna(Params[0]);

  If SameText(MethodName, 'fFormataCpfCgcInterna') Then
    Result := fFormataCpfCgcInterna(Params[0]);

  If SameText(MethodName, 'fFormataCEPInterna') Then
    Result := fFormataCEPInterna(Params[0]);

  If SameText(MethodName, 'FrFileExists') Then
    Result := FrFileExists(Params[0]);
end;

function TFichaCadFuncionarioCtr.fFormataCpfCgcInterna(strValor: String): String;
begin
  Result := fFormataCpfCgc(strValor, FPais);
end;

function TFichaCadFuncionarioCtr.fFormataFonePaisInterna(strFone: String): String;
begin
    Result := fFormataFone(strFone);
end;

{********************************}
{********************************}
{********************************}

function TFichaCadFuncionarioCtr.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TFichaCadFuncionarioCtr.fGetFastType: TFastFileType;
begin
  If FTipImp <> 'M' Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TFichaCadFuncionarioCtr.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TFichaCadFuncionarioCtr.fGetIsEmpty: Boolean;
begin
  Result := FUniClientDataset.IsEmpty;
end;

function TFichaCadFuncionarioCtr.fGetKey: String;
begin
  Result := 'FICFUN';
end;

function TFichaCadFuncionarioCtr.fGetName: String;
begin
  Result := 'FICHA CADASTRAL - FUNCIONÁRIO';
end;

function TFichaCadFuncionarioCtr.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TFichaCadFuncionarioCtr.fGetUserDataSets: TArrFrxUserDataSet;
begin
  //
end;

function TFichaCadFuncionarioCtr.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TFichaCadFuncionarioCtr.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

procedure TFichaCadFuncionarioCtr.pCarregaVariaveis;
begin
  FDicVar.AddOrSetValue('VS_Date', VS_Date);
  FDicVar.AddOrSetValue('VS_strCodEmp', VS_strCodEmp);
  FDicVar.AddOrSetValue('LOGOTIPO', fCfgSis('PATLOG'));
  FDicVar.AddOrSetValue('strLoginUsuarioLogado', strLoginUsuarioLogado);
  FDicVar.AddOrSetValue('strEmpAcessoUsuarioLogado', strEmpAcessoUsuarioLogado);
  FDicVar.AddOrSetValue('NOMREL', 'FICHA CADASTRAL - FUNCIONÁRIO');
  FDicVar.AddOrSetValue('REL_NOMREL', 'FICHA CADASTRAL');
end;

procedure TFichaCadFuncionarioCtr.pCarregaDadosEmpresa;
begin
//    fCadEmp('NOMEMP', FCadEmp_);
end;

function TFichaCadFuncionarioCtr.fPrepareDataSetsAndVariables: Boolean;
begin
  result := true;

  FDicTot.Limpar;
  pCarregaVariaveis;
  pCarregaDadosEmpresa;
  pCarregaListaFuncoes;
end;

function TFichaCadFuncionarioCtr.FrFileExists(FileName: string): boolean;
begin
  Result := FileExists(FileName);
end;

function fCriaClientDatasetFichaCTR: TUniClientDataSet;
var
  i1: integer;
  strSql: string;
  qryGenerica : TUniQuery;
begin
  Result := TUniClientDataSet.Create(nil);

  qryGenerica := fCriaQuery;

  strSql :=          'SELECT SQL_NO_CACHE';
  strSql := strSql + '       FUN_CODEMP,';
  strSql := strSql + '       FUN_CODFUN,';
  strSql := strSql + '       FUN_NOMFUN,';
  strSql := strSql + '       FNC_NOMFNC AS FUN_FUNCAO,';
  strSql := strSql + '       FUN_DTAADM,';
  strSql := strSql + '       FUN_DTADEM,';
  strSql := strSql + '       FUN_SALBAS,';
  strSql := strSql + '       FUN_BANCO_,';
  strSql := strSql + '       FUN_AGENCI,';
  strSql := strSql + '       FUN_CONTA_,';
  strSql := strSql + '       FUN_PISPAS,';
  strSql := strSql + '       FUN_CARPON,';
  strSql := strSql + '       FUN_REGIST,';
  strSql := strSql + '       FUN_OBSERV,';
  strSql := strSql + '       FUN_N_CTPS,';
  strSql := strSql + '       FUN_NUMSER,';
  strSql := strSql + '       FUN_C_P_F_,';
  strSql := strSql + '       FUN_NUM_RG,';
  strSql := strSql + '       FUN_HT1DOM,';
  strSql := strSql + '       FUN_HT2DOM,';
  strSql := strSql + '       FUN_HT3DOM,';
  strSql := strSql + '       FUN_HT4DOM,';
  strSql := strSql + '       FUN_HT1SEG,';
  strSql := strSql + '       FUN_HT2SEG,';
  strSql := strSql + '       FUN_HT3SEG,';
  strSql := strSql + '       FUN_HT4SEG,';
  strSql := strSql + '       FUN_HT1TER,';
  strSql := strSql + '       FUN_HT2TER,';
  strSql := strSql + '       FUN_HT3TER,';
  strSql := strSql + '       FUN_HT4TER,';
  strSql := strSql + '       FUN_HT1QUA,';
  strSql := strSql + '       FUN_HT2QUA,';
  strSql := strSql + '       FUN_HT3QUA,';
  strSql := strSql + '       FUN_HT4QUA,';
  strSql := strSql + '       FUN_HT1QUI,';
  strSql := strSql + '       FUN_HT2QUI,';
  strSql := strSql + '       FUN_HT3QUI,';
  strSql := strSql + '       FUN_HT4QUI,';
  strSql := strSql + '       FUN_HT1SEX,';
  strSql := strSql + '       FUN_HT2SEX,';
  strSql := strSql + '       FUN_HT3SEX,';
  strSql := strSql + '       FUN_HT4SEX,';
  strSql := strSql + '       FUN_HT1SAB,';
  strSql := strSql + '       FUN_HT2SAB,';
  strSql := strSql + '       FUN_HT3SAB,';
  strSql := strSql + '       FUN_HT4SAB,';
  strSql := strSql + '       FUN_GRAINS,';
  strSql := strSql + '       FUN_NACION,';
  strSql := strSql + '       FUN_NOMPAI,';
  strSql := strSql + '       FUN_NOMMAE,';
  strSql := strSql + '       FUN_LOCNAS,';
  strSql := strSql + '       FUN_DTANAS,';
  strSql := strSql + '       FUN_ESTCIV,';
  strSql := strSql + '       FUN_CERMIL,';
  strSql := strSql + '       FUN_CARHAB,';
  strSql := strSql + '       FUN_MOTDES,';
  strSql := strSql + '       FUN_NUMTIT,';
  strSql := strSql + '       FUN_ZONTIT,';
  strSql := strSql + '       FUN_SECTIT,';
  strSql := strSql + '       FUN_CATHAB,';
  strSql := strSql + '       FUN_VALHAB,';
  strSql := strSql + '       FUN_CODVEN,';
  strSql := strSql + '       FUN_NUMTEL,';
  strSql := strSql + '       FUN_NUMCEL,';
  strSql := strSql + '       EMP_NOMEMP,';
  strSql := strSql + '       EMP_C_G_C_,';
  strSql := strSql + '       OPE_NOMOPE,';
  strSql := strSql + '       CI.CID_NOMCID,';
  strSql := strSql + '       FUN_ENDERE,';
  strSql := strSql + '       FUN_ENDNUM,';
  strSql := strSql + '       FUN_BAIRRO,';
  strSql := strSql + '       BCO_NOMBCO,';
  strSql := strSql + '       FUN_FOTO01,';
  strSql := strSql + '       FUN_FOTO02,';
  strSql := strSql + '       FUN_NRGEXP,';
  strSql := strSql + '       FUN_RG_CUF,';
  strSql := strSql + '       FUN_SEXOFU,';
  strSql := strSql + '       FUN_CODCBO,';
  strSql := strSql + '       FUN_CTPSUF,';
  strSql := strSql + '       FUN_CPFDEM,';
  strSql := strSql + '       FUNC_RGDEM,';
  strSql := strSql + '       FUN_DTAEXA,';
  strSql := strSql + '       FUN_CORFUN,';
  strSql := strSql + '       C.CID_ESTADO AS FUN_ESTADO,';
  strSql := strSql + '       C.CID_NOMCID AS FUN_CIDADE,';
  strSql := strSql + '       CP.CID_NOMCID AS EMP_CIDADE,';
  strSql := strSql + '       CP.CID_ESTADO AS EMP_ESTADO,';
  strSql := strSql + '       FUN_FILHOS,';
  strSql := strSql + '       FUN_QTDFIL,';
  strSql := strSql + '       FUN_TAMANH,';
  strSql := strSql + '       FUN_ALTURA,';
  strSql := strSql + '       FUN_PESFUN,';
  strSql := strSql + '       FUN_COMPLE, ';
  strSql := strSql + '       FUN_EMEXPE, ';
  strSql := strSql + '       FUN_EXP45D, ';
  strSql := strSql + '       FUN_EXPM45, ';
  strSql := strSql + '       FUN_C_E_P_ ';

  strSql := strSql + '  FROM CADFUN     ';

  strSql := strSql + '  LEFT JOIN CADEMP ON EMP_CODEMP = FUN_CODEMP ';
  strSql := strSql + '  LEFT JOIN CADOPE ON OPE_CODOPE = FUN_CODVEN ';
  strSql := strSql + '  LEFT JOIN CADCID CI ON CI.CID_CODCID = FUN_LOCNAS ';
  strSql := strSql + '  LEFT JOIN CADBCO ON BCO_CODBCO = FUN_BANCO_ ';
  strSql := strSql + '  LEFT JOIN CADFNC ON FNC_CODFNC = FUN_FUNATU ';
  strSql := strSql + '  LEFT JOIN CADCID C ON C.CID_CODCID = FUN_CODCID ';
  strSql := strSql + '  LEFT JOIN CADCID CP ON CP.CID_CODCID = EMP_CODCID ';

  strSql := strSql + ' WHERE FALSE';

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

function fCriaClientDatasetfrxGen: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);
  Result.Name := 'frxGen';

  Result.FieldDefs.Add('EMP_NOMEMP',ftString,200);
  Result.FieldDefs.Add('REL_NOMREL',ftString,100);

  Result.CreateDataSet;
end;

function fCriaClientDataSetfrxBeneficia: TUniClientDataSet;
var
  i1: integer;
  strSql: string;
  qryGenerica : TUniQuery;
begin
  Result := TUniClientDataSet.Create(nil);
  Result.Name := 'frxBeneficia';

  qryGenerica := fCriaQuery;

  strSql :=          'SELECT SQL_NO_CACHE';
  strSql := strSql + '       *';
  strSql := strSql + '  FROM FUNBNF ';
  strSql := strSql + ' WHERE FALSE';

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

function fCriaClientDataSetfrxFerias: TUniClientDataSet;
var
  i1: integer;
  strSql: string;
  qryGenerica : TUniQuery;
begin
  Result := TUniClientDataSet.Create(nil);
  Result.Name := 'frxFerias';

  qryGenerica := fCriaQuery;

  strSql :=          'SELECT SQL_NO_CACHE';
  strSql := strSql + '       *';
  strSql := strSql + '  FROM FUNFER ';
  strSql := strSql + ' WHERE FALSE';

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

end.
