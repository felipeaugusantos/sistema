unit untExportaTintometricosTerceirosAdvanceTintoSystem;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, Windows, Messages,
  cxProgressBar, UniClientDataSet,
  FireDAC.VCLUI.Wait,
{$ENDIF}
  Uni, SysUtils, Variants, Classes, Math, strUtils,
  untExportaTintometricosTerceirosIndustrial,
  untThreadExportacaoTerceiros, DateUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TExportaTintometricosTerceirosAdvanceTintoSystem = Class(TExportaTintometricosTerceirosIndustrial)
  Private
    strAcrMob: String;
    function fRetValorAcrMobCfgTin(): String;
    function fRetValorAcrMob(qryGen: TUniQuery; fltQuantidade: Double): Double;
  Protected
    procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
      strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Override;
  Public
    function fNomeTabela(): String; Override;
    function fQuantidadeFormulacao(): Integer; Override;
    function fFatorTinta(): Double; Override;
    function fRetDescricao(): String; Override;
    function fRetItemBase(): String; Override;
    function fRetMD5KEY(): String; Override;
    function fRetFormula(intCont: Integer): String; Override;
    function fRetQuantidade(intCont: Integer): String; Override;
    function fRetEmbalagem(qryColorantes: TUniQuery): Double; Override;
    function fCamposTabela(): String; Override;
    function fCamposSelect(): String; Override;
    function fSQLInsert(): String; Override;
    function fRetornaColorantes(): String; Override;
    function fRetornaBases(): String; Override;
    function fPrefixoQuantCatalisador(): String; Override;
    function fPrefixoCatalisador(): String; Override;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTintas: TUniQuery; fltPreVen: Double; intParam: Integer = 0); Override;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pGravaTintometricoTabelasTerceirosPorTinta(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); Override;
    procedure Execute; Override;
    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); override;
    destructor Destroy; Override;
  End;

implementation

{ TExportaTintometricosTerceirosAdvanceTintoSystem }

constructor TExportaTintometricosTerceirosAdvanceTintoSystem.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited Create(pgbProgresso, strIdePro, blnAuto);
  dicPrecosCatalisador := TDicionario.Create();
  dicPrecosVendaCusto := TDicionario.Create();
  stlTabPreco := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosAdvanceTintoSystem.Destroy;
begin
  inherited;

  If Assigned(dicPrecosCatalisador) Then
    FreeAndNil(dicPrecosCatalisador);

  If Assigned(dicPrecosVendaCusto) Then
    FreeAndNil(dicPrecosVendaCusto);

  If Assigned(stlTabPreco) Then
    FreeAndNil(stlTabPreco);
end;
procedure TExportaTintometricosTerceirosAdvanceTintoSystem.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '   SELECT                 ';
  Result := Result + '     ADT_IDFORM,          ';
  Result := Result + '     ADT_CODCOR,          ';
  Result := Result + '     ADT_CODTEC,          ';
  Result := Result + '     ADT_PRODUT,          ';
  Result := Result + '     ADT_CODBAS,          ';
  Result := Result + '     ADT_CODEMB,          ';
  Result := Result + '     ADT_CODCAT,          ';
  Result := Result + '     ADT_QTDFIN,          ';
  Result := Result + '     ADT_QTDBAS,          ';
  Result := Result + '     ADT_QTDCAT,          ';
  Result := Result + '     ADT_QTD_ML,          ';
  Result := Result + '     BAS_DESCRI,          ';
  Result := Result + '     BAS_CODEMB,          ';
  Result := Result + '     ITE_CODITE,          ';
  Result := Result + '     ITE_DESITE,          ';
  Result := Result + '     ITE_REFERE,          ';
  Result := Result + '     EMB_DESCRI,          ';
  Result := Result + '     UNI_CODUNI,          ';
  Result := Result + '     UNI_DESUNI,          ';
  Result := Result + '     UNI_SIGUNI,          ';
  Result := Result + '     ADT_ACRMOB,          ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '     ADT_CODC' + fStrZero(intContador, 2) + ',    ';
    Result := Result + '     ADT_QTDC' + fStrZero(intContador, 2) + ',    ';
  End;

  Result := Result + '     ADT_MD5KEY           ';
  Result := Result + '   FROM                   ';
  Result := Result + '     ADT_CADADT           ';
  Result := Result + '   INNER JOIN ADT_CADBAS ON         ';
  Result := Result + '     ADT_CODBAS = BAS_CODBAS AND            ';
  Result := Result + '     ADT_PRODUT = BAS_PRODUT AND            ';
  Result := Result + '     ADT_CODEMB = BAS_CODEMB                ';
  Result := Result + '   INNER JOIN ADT_CADEMB ON         ';
  Result := Result + '     BAS_CODEMB = EMB_CODEMB                ';
  Result := Result + '   INNER JOIN CADUNI ON             ';
  Result := Result + '     EMB_CODUNI = UNI_CODUNI                ';
  Result := Result + '   INNER JOIN CADITE ON             ';
  Result := Result + '     BAS_CODITE = ITE_CODITE                ';
  Result := Result + '     AND ITE_ITEATI = "S"                   ';
  Result := Result + '   WHERE                  ';
  Result := Result + '     TRUE;                ';
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE  ' + fNomeTabela() + '   (     ';
  Result := Result + '    ADT_IDFORM VARCHAR(15),         ';
  Result := Result + '    ADT_CODCOR VARCHAR(50),         ';
  Result := Result + '    ADT_CODTEC VARCHAR(50),         ';
  Result := Result + '    ADT_PRODUT VARCHAR(50),         ';
  Result := Result + '    ADT_CODBAS VARCHAR(10),         ';
  Result := Result + '    ADT_CATALI VARCHAR(10),         ';
  Result := Result + '    ADT_CODEMB CHAR(3),             ';
  Result := Result + '    ADT_UNIDAD CHAR(2),             ';
  Result := Result + '    ADT_VOLUME DECIMAL(12,4),       ';
  Result := Result + '    ADT_CODITE VARCHAR(' + fTamCodIte.ToString() + '),          ';
  Result := Result + '    ADT_DESITE VARCHAR(70),         ';
  Result := Result + '    ADT_REFERE VARCHAR(20),         ';
  Result := Result + '    ADT_MD5KEY VARCHAR(32),         ';
  Result := Result + '    ADT_PREVSC DECIMAL(12,4),       ';  // Preço de Venda sem catalisador
  Result := Result + '    ADT_PREVCC DECIMAL(12,4),       ';  // Preço de Venda com catalisador
  Result := Result + '    ADT_PRCUSC DECIMAL(12,4),       ';  // Preço de Custo sem catalisador
  Result := Result + '    ADT_PRCUCC DECIMAL(12,4),       ';  // Preço de Custo com catalisador
  Result := Result + '    ADT_PREVS1 DECIMAL(12,4),       ';  // Preço de Venda 1 sem catalisador
  Result := Result + '    ADT_PREVS2 DECIMAL(12,4),       ';  // Preço de Venda 2 sem catalisador
  Result := Result + '    ADT_PREVS3 DECIMAL(12,4),       ';  // Preço de Venda 3 sem catalisador
  Result := Result + '    ADT_PREVS4 DECIMAL(12,4),       ';  // Preço de Venda 4 sem catalisador
  Result := Result + '    ADT_PREVS5 DECIMAL(12,4),       ';  // Preço de Venda 5 sem catalisador
  Result := Result + '    ADT_PREVS6 DECIMAL(12,4),       ';  // Preço de Venda 6 sem catalisador
  Result := Result + '    ADT_PREVS7 DECIMAL(12,4),       ';  // Preço de Venda 7 sem catalisador
  Result := Result + '    ADT_PREVC1 DECIMAL(12,4),       ';  // Preço de Venda 1 com catalisador
  Result := Result + '    ADT_PREVC2 DECIMAL(12,4),       ';  // Preço de Venda 2 com catalisador
  Result := Result + '    ADT_PREVC3 DECIMAL(12,4),       ';  // Preço de Venda 3 com catalisador
  Result := Result + '    ADT_PREVC4 DECIMAL(12,4),       ';  // Preço de Venda 4 com catalisador
  Result := Result + '    ADT_PREVC5 DECIMAL(12,4),       ';  // Preço de Venda 5 com catalisador
  Result := Result + '    ADT_PREVC6 DECIMAL(12,4),       ';  // Preço de Venda 6 com catalisador
  Result := Result + '    ADT_PREVC7 DECIMAL(12,4)        ';  // Preço de Venda 7 com catalisador
  Result := Result + '                  );                          ';
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fFatorTinta: Double;
begin
  Result := 1;
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fGetTipoFormula(
  qryGen, qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('ADT_CODC' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('COL_CODCOL', qryGen.FieldByName('ADT_CODC' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fNomeTabela: String;
begin
  Result := 'ADT_CADADT_SIT';
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fPrefixoCatalisador: String;
begin
  Result := 'ADT_CODCAT';
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fPrefixoQuantCatalisador: String;
begin
  Result := 'ADT_QTDCAT';
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fRetDescricao: String;
begin
  Result := 'ADT_CODCOR';
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'ADT_CODC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fRetItemBase: String;
begin
  Result := 'ITE_CODITE';
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fRetMD5KEY: String;
begin
  Result := 'ADT_MD5KEY';
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    BAS_CODBAS,         ';
  Result := Result + '    BAS_CODITE,         ';
  Result := Result + '    BAS_CODEMB,         ';
  Result := Result + '    BAS_CODEMP,         ';
  Result := Result + '    BAS_PRODUT,         ';
  Result := Result + '    BAS_DESCRI,         ';
  Result := Result + '    BAS_PESESP,         ';
  Result := Result + '    EMB_CODUNI,         ';
  Result := Result + '    EMB_DESCRI,         ';
  Result := Result + '    I.ITE_CODITE,       ';
  Result := Result + '    G.ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,       ';
  Result := Result + '    G.ITE_PRECUS  AS ITE_PRECUS,       ';
  Result := Result + '    G.ITE_PREVE1  AS ITE_PREVE1,       ';
  Result := Result + '    G.ITE_PREVE2  AS ITE_PREVE2,       ';
  Result := Result + '    G.ITE_PREVE3  AS ITE_PREVE3,       ';
  Result := Result + '    G.ITE_PREVE4  AS ITE_PREVE4,       ';
  Result := Result + '    G.ITE_PREVE5  AS ITE_PREVE5,       ';
  Result := Result + '    G.ITE_PREVE6  AS ITE_PREVE6,       ';
  Result := Result + '    G.ITE_PREVE7  AS ITE_PREVE7      ';
  Result := Result + '  FROM                  ';
  Result := Result + '    ADT_CADBAS B        ';
  Result := Result + '  LEFT JOIN ADT_CADEMB E ON         ';
  Result := Result + '    B.BAS_CODEMB = E.EMB_CODEMB             ';
  Result := Result + '  LEFT JOIN CADITE I ON             ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE             ';
  Result := Result + '  LEFT JOIN ITEGER G ON             ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE             ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"   ';
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fRetornaColorantes: String;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    COL_CODCOL,             ';
  Result := Result + '    COL_CODITE,             ';
  Result := Result + '    COL_EMBALA,             ';
  Result := Result + '    COL_PESESP,             ';
  Result := Result + '    I.ITE_CODITE,           ';
  Result := Result + '    G.ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,      ';
  Result := Result + '    G.ITE_PRECUS  AS ITE_PRECUS,           ';
  Result := Result + '    G.ITE_PREVE1  AS ITE_PREVE1,           ';
  Result := Result + '    G.ITE_PREVE2  AS ITE_PREVE2,           ';
  Result := Result + '    G.ITE_PREVE3  AS ITE_PREVE3,           ';
  Result := Result + '    G.ITE_PREVE4  AS ITE_PREVE4,           ';
  Result := Result + '    G.ITE_PREVE5  AS ITE_PREVE5,           ';
  Result := Result + '    G.ITE_PREVE6  AS ITE_PREVE6,           ';
  Result := Result + '    G.ITE_PREVE7  AS ITE_PREVE7            ';
  Result := Result + '  FROM                      ';
  Result := Result + '    ADT_CADCOL CO           ';
  Result := Result + '  JOIN ITEGER G ON                  ';
  Result := Result + '    G.ITE_CODITE = CO.COL_CODITE            ';
  Result := Result + '  JOIN CADITE I ON                  ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE             ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"   ';
  Result := Result + '  AND I.ITE_ITEATI = "S"          ';
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
Var
  strSQL: String;
  qryGen: TUniQuery;
begin
  Try
    Result := 0;

    strSQL := '';
    strSQL := strSQL + '  SELECT              ';
    strSQL := strSQL + '    CFG_VALCFG        ';
    strSQL := strSQL + '  FROM                ';
    strSQL := strSQL + '    CFGTIN            ';
    strSQL := strSQL + '  WHERE               ';
    strSQL := strSQL + '    CFG_IDEPRO = "ADT" AND        ';
    strSQL := strSQL + '    CFG_CODCFG = "APREVE" AND     ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"     ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    If Not fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := fStrToFloat(qryGen.FieldByName('CFG_VALCFG').AsString);
  Finally
    If Assigned(qryGen) Then
      FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'ADT_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fRetValorAcrMob(
  qryGen: TUniQuery; fltQuantidade: Double): Double;
begin
  If fltQuantidade <= 0 Then
    Exit(0);

  If strAcrMob = '1' Then
    Result := (1 + qryGen.FieldByName('ADT_ACRMOB').AsFloat / 100)
  Else
    Result := qryGen.FieldByName('ADT_ACRMOB').AsFloat;
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "ADT" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosAdvanceTintoSystem.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO   ' + fNomeTabela + '   (       ';
  Result := Result + '    ADT_IDFORM,           ';
  Result := Result + '    ADT_CODCOR,           ';
  Result := Result + '    ADT_CODTEC,           ';
  Result := Result + '    ADT_PRODUT,           ';
  Result := Result + '    ADT_CODBAS,           ';
  Result := Result + '    ADT_CATALI,           ';
  Result := Result + '    ADT_CODEMB,           ';
  Result := Result + '    ADT_UNIDAD,           ';
  Result := Result + '    ADT_VOLUME,           ';
  Result := Result + '    ADT_CODITE,           ';
  Result := Result + '    ADT_DESITE,           ';
  Result := Result + '    ADT_REFERE,           ';
  Result := Result + '    ADT_MD5KEY,           ';
  Result := Result + '    ADT_PREVSC,           ';  // Preço de Venda sem catalisador
  Result := Result + '    ADT_PREVCC,           ';  // Preço de Venda com catalisador
  Result := Result + '    ADT_PRCUSC,           ';  // Preço de Custo sem catalisador
  Result := Result + '    ADT_PRCUCC,           ';  // Preço de Custo com catalisador
  Result := Result + '    ADT_PREVS1,           ';  // Preço de Venda 1 sem catalisador
  Result := Result + '    ADT_PREVS2,           ';  // Preço de Venda 2 sem catalisador
  Result := Result + '    ADT_PREVS3,           ';  // Preço de Venda 3 sem catalisador
  Result := Result + '    ADT_PREVS4,           ';  // Preço de Venda 4 sem catalisador
  Result := Result + '    ADT_PREVS5,           ';  // Preço de Venda 5 sem catalisador
  Result := Result + '    ADT_PREVS6,           ';  // Preço de Venda 6 sem Catalisador
  Result := Result + '    ADT_PREVS7,           ';  // Preço de Venda 7 sem Catalisador
  Result := Result + '    ADT_PREVC1,           ';  // Preço de Venda 1 com catalisador
  Result := Result + '    ADT_PREVC2,           ';  // Preço de Venda 2 com catalisador
  Result := Result + '    ADT_PREVC3,           ';  // Preço de Venda 3 com catalisador
  Result := Result + '    ADT_PREVC4,           ';  // Preço de Venda 4 com catalisador
  Result := Result + '    ADT_PREVC5,           ';  // Preço de Venda 5 com catalisador
  Result := Result + '    ADT_PREVC6,           ';  // Preço de Venda 6 com catalisador
  Result := Result + '    ADT_PREVC7            ';  // Preço de Venda 7 com catalisador
  Result := Result + '                        )                     ';
  Result := Result + '  VALUES              (                       ';
  Result := Result + '    :IDFORM,              ';
  Result := Result + '    :CODCOR,              ';
  Result := Result + '    :CODTEC,              ';
  Result := Result + '    :PRODUT,              ';
  Result := Result + '    :CODBAS,              ';
  Result := Result + '    :CATALI,              ';
  Result := Result + '    :CODEMB,              ';
  Result := Result + '    :UNIDAD,              ';
  Result := Result + '    :VOLUME,              ';
  Result := Result + '    :CODITE,              ';
  Result := Result + '    :DESITE,              ';
  Result := Result + '    :REFERE,              ';
  Result := Result + '    :MD5KEY,              ';
  Result := Result + '    :PREVSC,              ';  // Preço de Venda sem catalisador
  Result := Result + '    :PREVCC,              ';  // Preço de Venda com catalisador
  Result := Result + '    :PRCUSC,              ';  // Preço de Custo sem catalisador
  Result := Result + '    :PRCUCC,              ';  // Preço de Custo com catalisador
  Result := Result + '    :PREVS1,              ';  // Preço de Venda 1 sem catalisador
  Result := Result + '    :PREVS2,              ';  // Preço de Venda 2 sem catalisador
  Result := Result + '    :PREVS3,              ';  // Preço de Venda 3 sem catalisador
  Result := Result + '    :PREVS4,              ';  // Preço de Venda 4 sem catalisador
  Result := Result + '    :PREVS5,              ';  // Preço de Venda 5 sem catalisador
  Result := Result + '    :PREVS6,              ';  // Preço de Venda 6 sem catalisador
  Result := Result + '    :PREVS7,              ';  // Preço de Venda 7 sem catalisador
  Result := Result + '    :PREVC1,              ';  // Preço de Venda 1 com catalisador
  Result := Result + '    :PREVC2,              ';  // Preço de Venda 2 com catalisador
  Result := Result + '    :PREVC3,              ';  // Preço de Venda 3 com catalisador
  Result := Result + '    :PREVC4,              ';  // Preço de Venda 4 com catalisador
  Result := Result + '    :PREVC5,              ';  // Preço de Venda 5 com catalisador
  Result := Result + '    :PREVC6,              ';  // Preço de Venda 6 com catalisador
  Result := Result + '    :PREVC7               ';  // Preço de Venda 7 com catalisador
  Result := Result + '              );                              ';
end;

procedure TExportaTintometricosTerceirosAdvanceTintoSystem.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTintas: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intPreVen: Integer;
begin
  DataSet.ParamByName('IDFORM').AsStrings[intParam] := fRemoveAcento(qryTintas.FieldByName('ADT_IDFORM').AsString);
  DataSet.ParamByName('CODCOR').AsStrings[intParam] := fRemoveAcento(qryTintas.FieldByName('ADT_CODCOR').AsString);
  DataSet.ParamByName('CODTEC').AsStrings[intParam] := fRemoveAcento(qryTintas.FieldByName('ADT_CODTEC').AsString);
  DataSet.ParamByName('PRODUT').AsStrings[intParam] := fRemoveAcento(qryTintas.FieldByName('ADT_PRODUT').AsString);
  DataSet.ParamByName('CODBAS').AsStrings[intParam] := fRemoveAcento(qryTintas.FieldByName('ADT_CODBAS').AsString);
  DataSet.ParamByName('CATALI').AsStrings[intParam] := fRemoveAcento(qryTintas.FieldByName('ADT_CODCAT').AsString);
  DataSet.ParamByName('CODEMB').AsStrings[intParam] := fRemoveAcento(qryTintas.FieldByName('ADT_CODEMB').AsString);
  DataSet.ParamByName('UNIDAD').AsStrings[intParam] := fRemoveAcento(qryTintas.FieldByName('UNI_CODUNI').AsString);
  DataSet.ParamByName('VOLUME').AsFloats[intParam]  := qryTintas.FieldByName('ADT_QTDFIN').AsFloat;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := qryTintas.FieldByName('ITE_CODITE').AsString;
  DataSet.ParamByName('DESITE').AsStrings[intParam] := fRemoveAcento(qryTintas.FieldByName('ITE_DESITE').AsString);
  DataSet.ParamByName('REFERE').AsStrings[intParam] := fRemoveAcento(qryTintas.FieldByName('ITE_REFERE').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTintas.FieldByName('ADT_MD5KEY').AsString;
  DataSet.ParamByName('PRCUSC').AsFloats[intParam] := IfNull(dicPrecosVendaCusto['PRECUS'], 0.0);
  DataSet.ParamByName('PRCUCC').AsFloats[intParam] := IfNull(dicPrecosVendaCusto['PRECUS_CATALISADOR'], 0.0);

  If strAcrMob = '1' Then
  Begin
    DataSet.ParamByName('PREVSC').AsFloats[intParam]  := fltPreVen * (1 + qryTintas.FieldByName('ADT_ACRMOB').AsFloat / 100);
    DataSet.ParamByName('PREVCC').AsFloats[intParam]  := IfNull(dicPrecosCatalisador['PRECO_CATALISADOR'], 0.0) * (1 + qryTintas.FieldByName('ADT_ACRMOB').AsFloat / 100);
  End
  Else
  Begin
    DataSet.ParamByName('PREVSC').AsFloats[intParam]  := fltPreVen + qryTintas.FieldByName('ADT_ACRMOB').AsFloat;
    DataSet.ParamByName('PREVCC').AsFloats[intParam]  := IfNull(dicPrecosCatalisador['PRECO_CATALISADOR'], 0.0) + qryTintas.FieldByName('ADT_ACRMOB').AsFloat;
  End;

  For intPreVen := 1 To 7 Do
  Begin
    If stlTabPreco[intPreVen] <> 'S' Then
    Begin
      DataSet.ParamByName('PREVS' + IntToStr(intPreVen)).AsFloats[intParam] := IfNull(dicPrecosVendaCusto['PREVE' + fStrZero(intPreVen, 2)], 0.0);
      DataSet.ParamByName('PREVC' + IntToStr(intPreVen)).AsFloats[intParam] := IfNull(dicPrecosVendaCusto['PREVE' + fStrZero(intPreVen, 2) + '_CATALISADOR'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PREVS' + IntToStr(intPreVen)).AsFloats[intParam] := IfNull(dicPrecosVendaCusto['PREVE' + fStrZero(intPreVen, 2)], 0.0) * (1 + qryTintas.FieldByName('ADT_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PREVC' + IntToStr(intPreVen)).AsFloats[intParam] := IfNull(dicPrecosVendaCusto['PREVE' + fStrZero(intPreVen, 2) + '_CATALISADOR'], 0.0) * (1 + qryTintas.FieldByName('ADT_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PREVS' + IntToStr(intPreVen)).AsFloats[intParam] := IfNull(dicPrecosVendaCusto['PREVE' + fStrZero(intPreVen, 2)], 0.0) + qryTintas.FieldByName('ADT_ACRMOB').AsFloat;
        DataSet.ParamByName('PREVC' + IntToStr(intPreVen)).AsFloats[intParam] := IfNull(dicPrecosVendaCusto['PREVE' + fStrZero(intPreVen, 2) + '_CATALISADOR'], 0.0) + qryTintas.FieldByName('ADT_ACRMOB').AsFloat;
      End;
    End;
  End;
end;


procedure TExportaTintometricosTerceirosAdvanceTintoSystem.pGravaTintometricoTabelasTerceirosPorTinta(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery;
  intParam: Integer);
begin
  pAdicionaParamentros(qryInsert, qryTinta, fltPreVen, intParam);
end;

procedure TExportaTintometricosTerceirosAdvanceTintoSystem.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  strSQL: String;
  qryGen: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "ADT"     ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ExecSQL;

    strSQL := '';
    strSQL := strSQL + '  INSERT INTO LOGTIN_SIT  (           ';
    strSQL := strSQL + '    LOG_IDEPRO,           ';
    strSQL := strSQL + '    LOG_HOREXE,           ';
    strSQL := strSQL + '    LOG_DTAEXE,           ';
    strSQL := strSQL + '    LOG_EXECUT            ';
    strSQL := strSQL + '                            )         ';
    strSQL := strSQL + '  VALUES                  (           ';
    strSQL := strSQL + '    :IDEPRO,              ';
    strSQL := strSQL + '    :HOREXE,              ';
    strSQL := strSQL + '    :DTAEXE,              ';
    strSQL := strSQL + '    :EXECUT               ';
    strSQL := strSQL + '                             );       ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('IDEPRO').AsString := 'ADT';
    qryGen.ParamByName('HOREXE').AsDateTime := Time;
    qryGen.ParamByName('DTAEXE').AsDateTime := VS_Date;
    qryGen.ParamByName('EXECUT').AsString := strStatus;
    qryGen.ExecSQL;
  Finally
    If Assigned(qryGen) Then
      FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosAdvanceTintoSystem.pProcessaTabelaCores(
  qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery; strTabUni,
  strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario);
Var
{$IFDEF LINUX}
  LValInfo: TValidateInf;
{$ENDIF}
  fltPreVen   : Double;
  intContador : Integer;
  intRegistros: Integer;
begin
  qryGen.First;

  If Not FAutoma Then
    FProgresso.Position := 0;

{$IFDEF LINUX}
  FInicioExportacao := Now;
{$ENDIF}

{$IFDEF LINUX}
  pGerarArrayValidacao(Trunc(qryGen.RecordCount / 6));
{$ENDIF}


  While Not qryGen.Eof Do
  Begin
    qryInsert.Params.ClearValues();
    qryInsert.Params.ArraySize := BATCH_SIZE;
    intContador := 0;

  {$IFDEF LINUX}
    If VS_ExitProcessSignal Then
      Break;
  {$ENDIF}

  {$IFDEF LINUX}
    pEscreverAguardeCalculando();
  {$ENDIF}

    For intRegistros := 0 To Pred(BATCH_SIZE) Do
    Begin
    {$IFDEF LINUX}
      If VS_ExitProcessSignal Then
        Break;
    {$ENDIF}

      If fGetTipoFormula(qryGen, qryColorantes) = 3 Then
      Begin
        If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
          Synchronize(pStep);

        qryGen.Next;
        Continue;
      End;

      dicRetorno.Limpar;

      pPreencheDicRetorno(dicRetorno, qryGen, strTabUni, strTabPre);
      pRetornaQuantidadeFormulacao(dicRetorno, qryGen, qryBases);
      pRetornaPrecoTinta(dicRetorno, qryColorantes, qryBases, fltPerAcr);

      If strAcrMob = '1' Then
        fltPreven := IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0) * fRetValorAcrMob(qryGen, IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0))
      Else
        fltPreVen := IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0) + fRetValorAcrMob(qryGen, IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0));

      pGravaTintometricoTabelasTerceiros(qryInsert, fltPreven, qryGen, intContador);

      If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
          Synchronize(pStep);

    {$IFDEF LINUX}
      If FValidateIndexList.Contains(qryGen.RecNo) Then
      Begin
        LValInfo.strIdePro := FIdePro;
        LValInfo.strMD5Key := qryGen.FieldByName(fRetMD5KEY).AsString;
        LValInfo.strTabPre := fRetornaTabelaPreco;
        LValInfo.fltPreVen := fltPreven;
        LValInfo.fltPreCus := IfNull(dicPrecosVendaCusto['PRECUS'], 0);

        If strAcrMob = '1' Then
        Begin
          LValInfo.fltPreVe1 := IfNull(dicPrecosVendaCusto['PREVE01'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecosVendaCusto['PREVE01'], 0));
          LValInfo.fltPreVe2 := IfNull(dicPrecosVendaCusto['PREVE02'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecosVendaCusto['PREVE02'], 0));
          LValInfo.fltPreVe3 := IfNull(dicPrecosVendaCusto['PREVE03'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecosVendaCusto['PREVE03'], 0));
          LValInfo.fltPreVe4 := IfNull(dicPrecosVendaCusto['PREVE04'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecosVendaCusto['PREVE04'], 0));
          LValInfo.fltPreVe5 := IfNull(dicPrecosVendaCusto['PREVE05'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecosVendaCusto['PREVE05'], 0));
          LValInfo.fltPreVe6 := IfNull(dicPrecosVendaCusto['PREVE06'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecosVendaCusto['PREVE06'], 0));
          LValInfo.fltPreVe7 := IfNull(dicPrecosVendaCusto['PREVE07'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecosVendaCusto['PREVE07'], 0));
        End
        Else
        Begin
          LValInfo.fltPreVe1 := IfNull(dicPrecosVendaCusto['PREVE01'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecosVendaCusto['PREVE01'], 0));
          LValInfo.fltPreVe2 := IfNull(dicPrecosVendaCusto['PREVE02'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecosVendaCusto['PREVE02'], 0));
          LValInfo.fltPreVe3 := IfNull(dicPrecosVendaCusto['PREVE03'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecosVendaCusto['PREVE03'], 0));
          LValInfo.fltPreVe4 := IfNull(dicPrecosVendaCusto['PREVE04'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecosVendaCusto['PREVE04'], 0));
          LValInfo.fltPreVe5 := IfNull(dicPrecosVendaCusto['PREVE05'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecosVendaCusto['PREVE05'], 0));
          LValInfo.fltPreVe6 := IfNull(dicPrecosVendaCusto['PREVE06'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecosVendaCusto['PREVE06'], 0));
          LValInfo.fltPreVe7 := IfNull(dicPrecosVendaCusto['PREVE07'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecosVendaCusto['PREVE07'], 0));
        End;

        pValidacaoFormula(LValInfo, VS_strCodEmp);
      End;
    {$ENDIF}

      If Not qryGen.Eof Then
        qryGen.Next
      Else
        Break;

      Inc(intContador, 1);
    End;

  {$IFDEF LINUX}
    If Not fValidarPrecosCalculado(False, 999) Then
      Break;
  {$ENDIF}

  {$IFDEF LINUX}
    pEscreverAguardeInserindo();
  {$ENDIF}

    qryInsert.Execute(intContador, 0);

  {$IFDEF LINUX}
    pEscreverLogProgresso(qryGen);
  {$ENDIF}
  End;

{$IFDEF LINUX}
  fValidarPrecosCalculado(True);
{$ENDIF}
end;

procedure TExportaTintometricosTerceirosAdvanceTintoSystem.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
Var
  strSQL: String;
  qryGen: TUniQuery;
  intContador: Integer;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                ';
    strSQL := strSQL + '    SIS_VALCFG          ';
    strSQL := strSQL + '  FROM                  ';
    strSQL := strSQL + '    CFGSIS              ';
    strSQL := strSQL + '  WHERE                 ';
    strSQL := strSQL + '    SIS_CODEMP = "' + VS_strCodEmp + '" AND       ';
    strSQL := strSQL + '    SIS_CODCFG = "CFG_TABPRC"   AND               ';
    strSQL := strSQL + '    SIS_GRUCFG = "PRODUTOS"                       ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    stlTabPreco.Clear;
    stlTabPreco.Add(qryGen.FieldByName('SIS_VALCFG').AsString);

    For intContador := 1 To 7 Do
      stlTabPreco.Add(Copy(qryGen.FieldByName('SIS_VALCFG').AsString, intContador, 1));
  Finally
    FreeAndNil(qryGen);
  End;
end;

end.
