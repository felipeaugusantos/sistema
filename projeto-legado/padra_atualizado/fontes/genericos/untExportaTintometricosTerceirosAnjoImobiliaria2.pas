unit untExportaTintometricosTerceirosAnjoImobiliaria2;

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
  untThreadExportacaoTerceiros, DateUtils,
  untExportaTintometricosTerceirosImobiliaria,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TExportaTintometricosTerceirosAnjoImobiliaria2 = Class(TExportaTintometricosTerceirosImobiliaria)
  Private
    strAcrMob: String;
    function fRetValorAcrMobCfgTin(): String;
    procedure pCarregarPrecoCusto(dicRetorno: TDicionario; qryColorantes: TUniQuery;
      qryBases: TUniQuery; fltPerAcr: Double);
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
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;
    function fRetornaBases(): String; Override;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; Override;

    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery;
      fltPreVen: Double; intParam: Integer = 0); override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pCarregarPrecosAdicionais(dicRetorno: TDicionario; qryColorantes: TUniQuery;
      qryBases: TUniQuery; fltPerAcr: Double); Override;

    procedure pGravaTintometricoTabelasTerceirosPorTinta(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); Override;

    procedure Execute; override;
    function fRetValorEmbalagem(qryBases: TUniQuery; dicRetorno: TDicionario; intPreVen: Integer; fltPerAcr: Double): Double;
    function fRetValorCustoBase(qryBases: TUniQuery; dicRetorno: TDicionario; intPreVen: Integer; fltPerAcr: Double): Double;
    function fRetValorCustoColorante(qryColorantes: TUniQuery; strCodCol: String; dicRetorno: TDicionario; intPreVen: Integer; fltPerAcr: Double): Double;
    function fRetValorVendaColorante(qryColorantes: TUniQuery; strCodCol: String; dicRetorno: TDicionario; intPreVen: Integer; fltPerAcr: Double): Double;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); override;
    destructor Destroy; override;
  End;

implementation

{ TExportaTintometricosTerceirosAnjoImobiliaria2 }

constructor TExportaTintometricosTerceirosAnjoImobiliaria2.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited Create(pgbProgresso, strIdePro, blnAuto);
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosAnjoImobiliaria2.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosAnjoImobiliaria2.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fCamposSelect: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    AN2_CODIGO,                   ';
  Result := Result + '    AN2_CODBAS,                   ';
  Result := Result + '    AN2_PRODUT,                   ';
  Result := Result + '    AN2_COLECA,                   ';
  Result := Result + '    AN2_UNIDAD,                   ';
  Result := Result + '    AN2_NOMCOR,                   ';
  Result := Result + '    ITE_CODITE,                   ';
  Result := Result + '    ITE_DESITE,                   ';
  Result := Result + '    ITE_REFERE,                   ';
  Result := Result + '    AN2_ACRMOB,                   ';

  For intCont := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    AN2_FORM' + fStrZero(intCont, 2) + ',     ';
    Result := Result + '    AN2_QTDC' + fStrZero(intCont, 2) + ',     ';
  End;

  Result := Result + '    AN2_MD5KEY                    ';
  Result := Result + '  FROM                            ';
  Result := Result + '    AN2_CADAN2                    ';
  Result := Result + '  INNER JOIN AN2_CADBAS ON              ';
  Result := Result + '    AN2_CODBAS = BAS_CODBAS AND               ';
  Result := Result + '    AN2_UNIDAD = BAS_UNIDAD AND               ';
  Result := Result + '    AN2_PRODUT = BAS_PRODUT                   ';
  Result := Result + '  INNER JOIN CADITE ON                  ';
  Result := Result + '    BAS_CODITE = ITE_CODITE                   ';
  Result := Result + '    AND ITE_ITEATI = "S"                      ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    TRUE;                         ';
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE    ' + fNomeTabela() + '   (     ';
  Result := Result + '    AN2_CODIGO VARCHAR(50),         ';
  Result := Result + '    AN2_CODBAS VARCHAR(40),         ';
  Result := Result + '    AN2_PRODUT VARCHAR(50),         ';
  Result := Result + '    AN2_COLECA VARCHAR(50),         ';
  Result := Result + '    AN2_UNIDAD CHAR(2),             ';
  Result := Result + '    AN2_NOMCOR VARCHAR(50),         ';
  Result := Result + '    AN2_CODITE VARCHAR(' + fTamCodIte.ToString() + '),          ';
  Result := Result + '    AN2_DESITE VARCHAR(70),         ';
  Result := Result + '    AN2_REFERE VARCHAR(2),          ';
  Result := Result + '    AN2_MD5KEY VARCHAR(32),         ';
  Result := Result + '    AN2_PREVEN DECIMAL(12,4),       ';
  Result := Result + '    AN2_PRECUS DECIMAL(12,4),       ';
  Result := Result + '    AN2_PREVE1 DECIMAL(12,4),       ';
  Result := Result + '    AN2_PREVE2 DECIMAL(12,4),       ';
  Result := Result + '    AN2_PREVE3 DECIMAL(12,4),       ';
  Result := Result + '    AN2_PREVE4 DECIMAL(12,4),       ';
  Result := Result + '    AN2_PREVE5 DECIMAL(12,4),       ';
  Result := Result + '    AN2_PREVE6 DECIMAL(12,4),       ';
  Result := Result + '    AN2_PREVE7 DECIMAL(12,4)        ';
  Result := Result + '          );                                    ';
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fFatorTinta: Double;
begin
  Result := 1;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('AN2_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('COL_CODCOL', qryGen.FieldByName('AN2_FORM' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fNomeTabela: String;
begin
  Result := 'AN2_CADAN2_SIT';
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetDescricao: String;
begin
  Result := 'AN2_PRODUT';
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'AN2_FORM' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetItemBase: String;
begin
  Result := 'ITE_CODITE';
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetMD5KEY: String;
begin
  Result := 'AN2_MD5KEY';
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    I.ITE_CODITE,                 ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,      ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,     ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,     ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,     ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,     ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,     ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,     ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,     ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7      ';
  Result := Result + '  FROM                            ';
  Result := Result + '    AN2_CADBAS B                  ';
  Result := Result + '  INNER JOIN CADITE I ON                ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE               ';
  Result := Result + '  INNER JOIN ITEGER G ON                ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE               ';
  Result := Result + '  WHERE                           ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"     ';
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetornaColorantes: String;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    COL_CODCOL,           ';
  Result := Result + '    COL_CODITE,           ';
  Result := Result + '    COL_EMBALA,           ';
  Result := Result + '    ITE_PREVE'  + fRetornaTabelaPreco + ' AS ITE_PREVEN,       ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,       ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,       ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,       ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,       ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,       ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,       ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,       ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7        ';
  Result := Result + '  FROM                    ';
  Result := Result + '    AN2_CADCOL C          ';
  Result := Result + '  JOIN ITEGER G ON              ';
  Result := Result + '    G.ITE_CODITE = C.COL_CODITE         ';
  Result := Result + '  JOIN CADITE I ON              ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE         ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"   ';
  Result := Result + '    AND I.ITE_ITEATI = "S"      ';
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    Result := 0;

    strSQL := '';
    strSQL := strSQL + '  SELECT            ';
    strSQL := strSQL + '    CFG_VALCFG      ';
    strSQL := strSQL + '  FROM              ';
    strSQL := strSQL + '    CFGTIN          ';
    strSQL := strSQL + '  WHERE             ';
    strSQL := strSQL + '    CFG_IDEPRO = "AN2" AND              ';
    strSQL := strSQL + '    CFG_CODCFG = "APREVE" AND           ';
    strSQL := strSQL + '    CFG_CODEMP = "'+ VS_strCodEmp + '"  ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    If Not fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := fStrToFloat(qryGen.FieldByName('CFG_VALCFG').AsString);

  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'AN2_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetValorAcrMob(qryGen: TUniQuery;
  fltQuantidade: Double): Double;
begin
  If fltQuantidade <= 0 Then
    Exit(0);

  If strAcrMob = '1' Then
    Result := (1 + qryGen.FieldByName('AN2_ACRMOB').AsFloat / 100)
  Else
    Result := qryGen.FieldByName('AN2_ACRMOB').AsFloat;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "AN2" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetValorCustoBase(
  qryBases: TUniQuery; dicRetorno: TDicionario; intPreVen: Integer;
  fltPerAcr: Double): Double;
Var
  strCodCli,
  strCodCnd: String;
  intPrzMed: Integer;
  fltPreCusPro,
  fltPreVenPro: Double;
begin
  strCodCli := '';
  strCodCnd := '';
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  intPrzMed := 0;
  Result := 0;

  If qryBases.Locate('ITE_CODITE', dicRetorno['itebas'],[]) Then
  Begin
    If fCarregaPromocao(dicRetorno['itebas'], '1', strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
    Begin
      Result := fltPreCusPro + (fltPerAcr * fltPreCusPro);

      If Result = 0 Then
        Result := qryBases.FieldByName('PRECUS').AsFloat + (fltPerAcr * qryBases.FieldByName('PRECUS').AsFloat);
    End
    Else
      Result := qryBases.FieldByName('PRECUS').AsFloat + (fltPerAcr * qryBases.FieldByName('PRECUS').AsFloat);
  End;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetValorCustoColorante(
  qryColorantes: TUniQuery; strCodCol: String; dicRetorno: TDicionario; intPreVen: Integer;
  fltPerAcr: Double): Double;
Var
  strCodCli,
  strCodCnd: String;
  intPrzMed: Integer;
  fltPreCusPro,
  fltPreVenPro: Double;
  strTabelaUnica: String;
begin
  strCodCli := '';
  strCodCnd := '';
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  intPrzMed := 0;
  Result := 0;
  strTabelaUnica := dicRetorno['tabelaunica'];

  If qryColorantes.Locate('COL_CODCOL', strCodCol, []) Then
  Begin
    If fCarregaPromocao(qryColorantes.FieldByName('COL_CODITE').AsString, strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
    Begin
      Result := fltPreCusPro;

      If Result = 0 Then
        Result := qryColorantes.FieldByName('PRECUS').AsFloat;
    End
    Else
      Result := qryColorantes.FieldByName('PRECUS').AsFloat;
  End;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetValorEmbalagem(
  qryBases: TUniQuery; dicRetorno: TDicionario; intPreVen: Integer; fltPerAcr: Double): Double;
Var
  strCodCli,
  strCodCnd: String;
  intPrzMed: Integer;
  fltPreCusPro,
  fltPreVenPro: Double;

begin
  strCodCli := '';
  strCodCnd := '';
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  intPrzMed := 0;
  Result := 0;

  If qryBases.Locate('ITE_CODITE', dicRetorno['itebas'],[]) Then
  Begin
    If fCarregaPromocao(dicRetorno['itebas'], IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
      Result := fltPreVenPro + (fltPerAcr * fltPreVenPro)
    Else
     Result  := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat + (fltPerAcr * qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat);
  End;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fRetValorVendaColorante(
  qryColorantes: TUniQuery; strCodCol: String; dicRetorno: TDicionario;
  intPreVen: Integer; fltPerAcr: Double): Double;
Var
  strCodCli,
  strCodCnd: String;
  intPrzMed: Integer;
  fltPreCusPro,
  fltPreVenPro: Double;
begin
  strCodCli := '';
  strCodCnd := '';
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  intPrzMed := 0;
  Result := 0;

  If qryColorantes.Locate('COL_CODCOL', strCodCol,[]) Then
  Begin
    If fCarregaPromocao(qryColorantes.FieldByName('COL_CODITE').AsString, IntToStr(intPreVen),  strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
      Result := fltPreVenPro
    Else
      Result := qryColorantes.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
  End;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria2.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO   ' + fNomeTabela() + '   (       ';
  Result := Result + '    AN2_CODIGO,           ';
  Result := Result + '    AN2_CODBAS,           ';
  Result := Result + '    AN2_PRODUT,           ';
  Result := Result + '    AN2_COLECA,           ';
  Result := Result + '    AN2_UNIDAD,           ';
  Result := Result + '    AN2_NOMCOR,           ';
  Result := Result + '    AN2_CODITE,           ';
  Result := Result + '    AN2_DESITE,           ';
  Result := Result + '    AN2_REFERE,           ';
  Result := Result + '    AN2_MD5KEY,           ';
  Result := Result + '    AN2_PREVEN,           ';
  Result := Result + '    AN2_PRECUS,           ';
  Result := Result + '    AN2_PREVE1,           ';
  Result := Result + '    AN2_PREVE2,           ';
  Result := Result + '    AN2_PREVE3,           ';
  Result := Result + '    AN2_PREVE4,           ';
  Result := Result + '    AN2_PREVE5,           ';
  Result := Result + '    AN2_PREVE6,           ';
  Result := Result + '    AN2_PREVE7            ';
  Result := Result + '          )                                     ';
  Result := Result + '  VALUES                  ' + '     (           ';
  Result := Result + '    :CODIGO,              ';
  Result := Result + '    :CODBAS,              ';
  Result := Result + '    :PRODUT,              ';
  Result := Result + '    :COLECA,              ';
  Result := Result + '    :UNIDAD,              ';
  Result := Result + '    :NOMCOR,              ';
  Result := Result + '    :CODITE,              ';
  Result := Result + '    :DESITE,              ';
  Result := Result + '    :REFERE,              ';
  Result := Result + '    :MD5KEY,              ';
  Result := Result + '    :PREVEN,              ';
  Result := Result + '    :PRECUS,              ';
  Result := Result + '    :PREVE1,              ';
  Result := Result + '    :PREVE2,              ';
  Result := Result + '    :PREVE3,              ';
  Result := Result + '    :PREVE4,              ';
  Result := Result + '    :PREVE5,              ';
  Result := Result + '    :PREVE6,              ';
  Result := Result + '    :PREVE7               ';
  Result := Result + '          );                                    ';
end;

procedure TExportaTintometricosTerceirosAnjoImobiliaria2.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
begin
  DataSet.ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AN2_CODIGO').AsString);
  DataSet.ParamByName('CODBAS').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AN2_CODBAS').AsString);
  DataSet.ParamByName('PRODUT').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AN2_PRODUT').AsString);
  DataSet.ParamByName('UNIDAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AN2_UNIDAD').AsString);
  DataSet.ParamByName('COLECA').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AN2_COLECA').AsString);
  DataSet.ParamByName('CODITE').AsStrings[intParam] := qryTinta.FieldByName('ITE_CODITE').AsString;
  DataSet.ParamByName('DESITE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ITE_DESITE').AsString);
  DataSet.ParamByName('REFERE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ITE_REFERE').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('AN2_MD5KEY').AsString;
  DataSet.ParamByName('NOMCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AN2_NOMCOR').AsString);
  DataSet.ParamByName('PRECUS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['precus'], 0.0);

  If strAcrMob = '1' Then
    DataSet.ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen * (1 + qryTinta.FieldByName('AN2_ACRMOB').AsFloat / 100)
  Else
    DataSet.ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen + qryTinta.FieldByName('AN2_ACRMOB').AsFloat;

  For intContador := 1 To 7 Do
  Begin
    If stlTabPre[intContador] <> 'S' Then
      DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0)
    Else
    Begin
      If strAcrMob = '1' Then
        DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] :=  IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) * (1 + qryTinta.FieldByName('AN2_ACRMOB').AsFloat / 100)
      Else
        DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) + qryTinta.FieldByName('AN2_ACRMOB').AsFloat;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosAnjoImobiliaria2.pCarregarPrecoCusto(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
Var
  intContador: Integer;
  ArrComponentes: array of TComp;
  fltQuantidade,
  fltPrecoColorante,
  fltPrecoCusto,
  fltPrecoCustoTotal,
  fltPrecoCustoBase: Double;
begin
  Try
    SetLength(ArrComponentes, fQuantidadeFormulacao);

    //Adiciona a formulacao no array
    For intContador := 1 To fQuantidadeFormulacao Do
    Begin
      If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
        Break;

      ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
      ArrComponentes[intContador].Quantidade := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)] / fFatorTinta, 3);
    End;

    fltPrecoCustoTotal := 0;

    //Calculando o Preço de Custo
    For intContador := 1 To Length(ArrComponentes) Do
    Begin
      If fEmptyStr(ArrComponentes[intContador].Componente) Then
        Break;

      fltPrecoColorante := fRetValorCustoColorante(qryColorantes, ArrComponentes[intContador].Componente, dicRetorno, 1, fltPerAcr);
      fltQuantidade := ArrComponentes[intContador].Quantidade * fFatorTinta;
      fltPrecoCusto := fltQuantidade * (fltPrecoColorante / fRetEmbalagem(qryColorantes));
      fltPrecoCustoTotal := fltPrecoCustoTotal + fltPrecoCusto;
    End;

    fltPrecoCustoBase := fRetValorCustoBase(qryBases, dicRetorno, 1, fltPerAcr);
    dicPrecoAdicional['precus'] := fltPrecoCustoTotal + fltPrecoCustoBase;
  Finally
    SetLength(arrComponentes, 0);
  End;
end;

procedure TExportaTintometricosTerceirosAnjoImobiliaria2.pCarregarPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
Var
  intPreVen: Integer;
  strCodCli, strCodCnd: String;
  fltQuantidade,
  fltPrecoVenda,
  fltPrecoVendaTotal,
  fltPrecoColorante,
  fltPrecoEmbalagem: Double;
  intContador: Integer;
  strTabelaUnica: String;
  ArrComponentes: array of TComp;
begin
  dicPrecoAdicional.Limpar;
  strTabelaUnica := dicRetorno['tabelaunica'];

  Try
    SetLength(ArrComponentes, fQuantidadeFormulacao);

    //Adiciona a formulacao no array
    For intContador := 1 To fQuantidadeFormulacao Do
    Begin
      If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
        Break;

      ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
      ArrComponentes[intContador].Quantidade := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)] / fFatorTinta, 3);
    End;

    For intPreVen := 1 To 7 Do
    Begin

      If stlTabPre[intPreVen] <> 'S' Then
        Continue;

      fltPrecoVendaTotal := 0;
      strCodCli          := '';
      strCodCnd          := '';

      //Calcula o preco de venda
      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        fltPrecoColorante := fRetValorVendaColorante(qryColorantes, ArrComponentes[intContador].Componente, dicRetorno, intPreVen, fltPerAcr);
        fltQuantidade := ArrComponentes[intContador].Quantidade * fFatorTinta;
        fltPrecoVenda := fltQuantidade * (fltPrecoColorante / fRetEmbalagem(qryColorantes));
        fltPrecoVendaTotal := fltPrecoVendaTotal + fltPrecoVenda;
      End;

      fltPrecoEmbalagem := fRetValorEmbalagem(qryBases, dicRetorno, intPreVen, fltPerAcr);

      fltPrecoVendaTotal := fltPrecoVendaTotal + (fltPerAcr * fltPrecoVendaTotal) + fltPrecoEmbalagem;

      dicPrecoAdicional['preve' + IntToStr(intPreVen)] := fltPrecoVendaTotal;
    End;

    strCodCli          := '';
    strCodCnd          := '';

    pCarregarPrecoCusto(dicRetorno, qryColorantes, qryBases, fltPerAcr);
  Finally
    SetLength(arrComponentes, 0);
  End;
end;

procedure TExportaTintometricosTerceirosAnjoImobiliaria2.pGravaTintometricoTabelasTerceirosPorTinta(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery;
  intParam: Integer);
begin
  pAdicionaParamentros(qryInsert, qryTinta, fltPreVen, intParam);
end;

procedure TExportaTintometricosTerceirosAnjoImobiliaria2.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + ' DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "AN2"      ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ExecSQL;

    strSQL := '';
    strSQL := strSQL + '  INSERT INTO LOGTIN_SIT  (         ';
    strSQL := strSQL + '    LOG_IDEPRO,         ';
    strSQL := strSQL + '    LOG_DTAEXE,         ';
    strSQL := strSQL + '    LOG_HOREXE,         ';
    strSQL := strSQL + '    LOG_EXECUT          ';
    strSQL := strSQL + '        )                           ';
    strSQL := strSQL + '  VALUES      ' + '   (             ';
    strSQL := strSQL + '    "AN2",              ';
    strSQL := strSQL + '    :DTAEXE,            ';
    strSQL := strSQL + '    :HOREXE,            ';
    strSQL := strSQL + '    :EXECUT             ';
    strSQL := strSQL + '        );                          ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('DTAEXE').AsDateTime := VS_Date;
    qryGen.ParamByName('HOREXE').AsDateTime := Time;
    qryGen.ParamByName('EXECUT').AsString   := strStatus;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosAnjoImobiliaria2.pProcessaTabelaCores(
  qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery; strTabUni,
  strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario);
Var
{$IFDEF LINUX}
  LValInfo: TValidateInf;
{$ENDIF}
  fltPreven: Double;
  intContador: Integer;
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
    if VS_ExitProcessSignal then
      Break;
  {$ENDIF}

   {$IFDEF LINUX}
    pEscreverAguardeCalculando;
   {$ENDIF}

    For intRegistros := 0 To Pred(BATCH_SIZE) Do
    Begin
     {$IFDEF LINUX}
      if VS_ExitProcessSignal then
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
      if FValidateIndexList.Contains(qryGen.RecNo) then
      begin
        LValInfo.strIdePro := FIdePro;
        LValInfo.strMD5Key := qryGen.FieldByName(fRetMD5KEY).AsString;
        LValInfo.strTabPre := fRetornaTabelaPreco;
        LValInfo.fltPreVen := fltPreven;
        LValInfo.fltPreCus := IfNull(dicPrecoAdicional['precus'], 0);

        If strAcrMob = '1' Then
        Begin
          LValInfo.fltPreVe1 := IfNull(dicPrecoAdicional['preve1'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve1'], 0));
          LValInfo.fltPreVe2 := IfNull(dicPrecoAdicional['preve2'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve2'], 0));
          LValInfo.fltPreVe3 := IfNull(dicPrecoAdicional['preve3'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve3'], 0));
          LValInfo.fltPreVe4 := IfNull(dicPrecoAdicional['preve4'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve4'], 0));
          LValInfo.fltPreVe5 := IfNull(dicPrecoAdicional['preve5'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve5'], 0));
          LValInfo.fltPreVe6 := IfNull(dicPrecoAdicional['preve6'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve6'], 0));
          LValInfo.fltPreVe7 := IfNull(dicPrecoAdicional['preve7'], 0) * fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve7'], 0));
        End
        Else
        Begin
          LValInfo.fltPreVe1 := IfNull(dicPrecoAdicional['preve1'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve1'], 0));
          LValInfo.fltPreVe2 := IfNull(dicPrecoAdicional['preve2'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve2'], 0));
          LValInfo.fltPreVe3 := IfNull(dicPrecoAdicional['preve3'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve3'], 0));
          LValInfo.fltPreVe4 := IfNull(dicPrecoAdicional['preve4'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve4'], 0));
          LValInfo.fltPreVe5 := IfNull(dicPrecoAdicional['preve5'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve5'], 0));
          LValInfo.fltPreVe6 := IfNull(dicPrecoAdicional['preve6'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve6'], 0));
          LValInfo.fltPreVe7 := IfNull(dicPrecoAdicional['preve7'], 0) + fRetValorAcrMob(qryGen, IfNull(dicPrecoAdicional['preve7'], 0));
        End;

        pValidacaoFormula(LValInfo, VS_strCodEmp);
      end;
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
    pEscreverAguardeInserindo;
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

procedure TExportaTintometricosTerceirosAnjoImobiliaria2.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
Var
  qryGen: TUniQuery;
  strSQL: String;
  intContador: Integer;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                ';
    strSQL := strSQL + '    SIS_VALCFG          ';
    strSQL := strSQL + '  FROM                  ';
    strSQL := strSQL + '    CFGSIS              ';
    strSQL := strSQL + '  WHERE                 ';
    strSQL := strSQL + '    SIS_CODEMP = "' + VS_strCodEmp + '"  AND        ';
    strSQL := strSQL + '    SIS_CODCFG = "CFG_TABPRC" AND                   ';
    strSQL := strSQL + '    SIS_GRUCFG = "PRODUTOS"                         ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    strCfgPre := qryGen.FieldByName('SIS_VALCFG').AsString;
    stlTabPre.Clear;
    stlTabPre.Add(strCfgPre);

    For intContador := 1 To 7 Do
      stlTabPre.Add(Copy(strCfgPre, intContador, 1));
  Finally
    If Assigned(qryGen) Then
      FreeAndNil(qryGen);
  End;
end;

end.
