unit untExportaTintometricosTerceirosFutura;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, Windows, Messages,
  cxProgressBar, UniClientDataSet,
  FireDAC.VCLUI.Wait,
{$ENDIF}
  Uni, SysUtils, Variants, Classes,
  untThreadExportacaoTerceiros, Math, DateUtils,
  untExportaTintometricosTerceirosImobiliaria,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

type
  TExportaTintometricosTerceirosFutura = class(TExportaTintometricosTerceirosImobiliaria)
  private
    strAcrMob: String;
    function fRetValorAcrMobCfgTin(): String;
    function fRetValorAcrMob(qryGen: TUniQuery; fltQuantidade: Double): Double;
  Protected
    procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
      strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Override;
  public
    function fNomeTabela: String; override;
    function fCamposTabela: String; override;
    function fCamposSelect: String; override;
    function fQuantidadeFormulacao: Integer; override;
    function fFatorTinta: Double; override;

    function fRetDescricao: String; override;
    function fRetItemBase: String; override;
    function fRetMD5KEY: String; override;
    function fRetFormula(intCont: Integer): String; override;
    function fRetQuantidade(intCont: Integer): String; override;

    function fSQLInsert: String; override;
    procedure pAdicionaParamentros(
      Var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0); override;
      function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;

    function fRetornaColorantes: String; override;
    function fRetornaBases: String; override;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; override;

    function fRetEmbalagem(qryColorantes: TUniQuery): Double; override;

    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pCarregarPrecosAdicionais(dicRetorno: TDicionario; qryColorantes: TUniQuery;
      qryBases: TUniQuery; fltPerAcr: Double); Override;

    procedure pGravaTintometricoTabelasTerceirosPorTinta(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); Override;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); override;
    destructor Destroy; override;

    procedure Execute; override;
 End;


Type
  TComp = Record
    Componente: String;
    Quantidade: Double;
End;

implementation

{ TExportaTintometricosTerceirosFutura }

constructor TExportaTintometricosTerceirosFutura.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean = False);
begin
  inherited  Create(pgbProgresso, strIdePro, blnAuto);
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosFutura.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

function TExportaTintometricosTerceirosFutura.fCamposSelect: String;
begin
  Result := '';
  Result := Result + ' SELECT  ';
  Result := Result + '   FUT_CODEMP, ';
  Result := Result + '   FUT_NOMCOR, ';
  Result := Result + '   FUT_DESCRI, ';
  Result := Result + '   FUT_REFERE, ';
  Result := Result + '   FUT_UNIDAD, ';
  Result := Result + '   FUT_PRODUT, ';
  Result := Result + '   FUT_SPRODU, ';
  Result := Result + '   FUT_CODBAS, ';
  Result := Result + '   FUT_MD5KEY, ';
  Result := Result + '   FUT_ACRMOB, ';
  Result := Result + '   FUT_RED___, ';
  Result := Result + '   FUT_GREEN_, ';
  Result := Result + '   FUT_BLUE__, ';
  Result := Result + '   FUT_FAMILI, ';
  Result := Result + '   FUT_R_G_B_, ';
  Result := Result + '   FUT_CADFUT.AUTOINCREM, ';
  Result := Result + '   ITE_CODITE, ';
  Result := Result + '   ITE_DESITE, ';
  Result := Result + '   FUT_FORM01, ';
  Result := Result + '   FUT_QTDB01, ';
  Result := Result + '   FUT_FORM02, ';
  Result := Result + '   FUT_QTDB02, ';
  Result := Result + '   FUT_FORM03, ';
  Result := Result + '   FUT_QTDB03, ';
  Result := Result + '   FUT_FORM04, ';
  Result := Result + '   FUT_QTDB04, ';
  Result := Result + '   FUT_FORM05, ';
  Result := Result + '   FUT_QTDB05, ';
  Result := Result + '   FUT_FORM06, ';
  Result := Result + '   FUT_QTDB06, ';
  Result := Result + '   FUT_FORM07, ';
  Result := Result + '   FUT_QTDB07, ';
  Result := Result + '   FUT_FORM08, ';
  Result := Result + '   FUT_QTDB08, ';
  Result := Result + '   FUT_FORM09, ';
  Result := Result + '   FUT_QTDB09, ';
  Result := Result + '   FUT_FORM10, ';
  Result := Result + '   FUT_QTDB10, ';
  Result := Result + '   FUT_FORM11, ';
  Result := Result + '   FUT_QTDB11, ';
  Result := Result + '   FUT_FORM12, ';
  Result := Result + '   FUT_QTDB12, ';
  Result := Result + '   FUT_FORM13, ';
  Result := Result + '   FUT_QTDB13, ';
  Result := Result + '   FUT_FORM14, ';
  Result := Result + '   FUT_QTDB14, ';
  Result := Result + '   FUT_FORM15, ';
  Result := Result + '   FUT_QTDB15, ';
  Result := Result + '   FUT_FORM16, ';
  Result := Result + '   FUT_FORM17, ';
  Result := Result + '   FUT_FORM18, ';
  Result := Result + '   FUT_FORM19, ';
  Result := Result + '   FUT_FORM20, ';
  Result := Result + '   FUT_QTDB16, ';
  Result := Result + '   FUT_QTDB17, ';
  Result := Result + '   FUT_QTDB18, ';
  Result := Result + '   FUT_QTDB19, ';
  Result := Result + '   FUT_QTDB20  ';

  Result := Result + ' FROM FUT_CADFUT  ';
  Result := Result + '   INNER JOIN FUT_CADBAS  ';
  Result := Result + '     ON FUT_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND FUT_UNIDAD = BAS_CODUNI ';
  Result := Result + '       AND FUT_PRODUT = BAS_PRODUT ';
  Result := Result + '   INNER JOIN CADITE  ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
  Result := Result + '      AND ITE_ITEATI = "S"      ';
  Result := Result + ' WHERE TRUE ';
end;

function TExportaTintometricosTerceirosFutura.fCamposTabela: String;
begin
  Result := '';
  Result := Result + ' CREATE TABLE ' + fNomeTabela;
  Result := Result + ' ( FUT_CODEMP CHAR(3),        ';
  Result := Result + '   FUT_DESCRI VARCHAR(75),    ';
  Result := Result + '   FUT_NOMCOR VARCHAR(100),   ';
  Result := Result + '   FUT_REFERE VARCHAR(105),   ';
  Result := Result + '   FUT_UNIDAD CHAR(2),        ';
  Result := Result + '   FUT_PRODUT VARCHAR(75),    ';
  Result := Result + '   FUT_SPRODU VARCHAR(75),    ';
  Result := Result + '   FUT_CODBAS VARCHAR(30),    ';
  Result := Result + '   FUT_RED___ INT,            ';
  Result := Result + '   FUT_GREEN_ INT,            ';
  Result := Result + '   FUT_BLUE__ INT,            ';
  Result := Result + '   FUT_FAMILI VARCHAR(50),    ';
  Result := Result + '   FUT_R_G_B_ VARCHAR(6),     ';
  Result := Result + '   FUT_MD5KEY VARCHAR(32),    ';
  Result := Result + '   FUT_CODITE CHAR('+IntToStr(fTamCodIte)+'),  '; //Tabela cadite
  Result := Result + '   FUT_DESITE VARCHAR(70),    '; //Tabela cadite
  Result := Result + '   FUT_PREVEN DECIMAL(12,4),  ';
  Result := Result + '   FUT_PRECUS DECIMAL(12,4),  ';
  Result := Result + '   FUT_PREVE1 DECIMAL(12,4),  ';
  Result := Result + '   FUT_PREVE2 DECIMAL(12,4),  ';
  Result := Result + '   FUT_PREVE3 DECIMAL(12,4),  ';
  Result := Result + '   FUT_PREVE4 DECIMAL(12,4),  ';
  Result := Result + '   FUT_PREVE5 DECIMAL(12,4),  ';
  Result := Result + '   FUT_PREVE6 DECIMAL(12,4),  ';
  Result := Result + '   FUT_PREVE7 DECIMAL(12,4)   ';
  Result := Result + '      );                      ';
end;

function TExportaTintometricosTerceirosFutura.fFatorTinta: Double;
begin
  Result := 1;
end;

function TExportaTintometricosTerceirosFutura.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('FUT_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('COL_CODCOL', qryGen.FieldByName('FUT_FORM' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosFutura.fNomeTabela: String;
begin
  Result := 'FUT_CADFUT_SIT';
end;

function TExportaTintometricosTerceirosFutura.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosFutura.fRetDescricao: String;
begin
  Result := 'FUT_DESCRI';
end;

function TExportaTintometricosTerceirosFutura.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

function TExportaTintometricosTerceirosFutura.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'FUT_FORM' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosFutura.fRetItemBase: String;
begin
  Result := 'ITE_CODITE';
end;

function TExportaTintometricosTerceirosFutura.fRetMD5KEY: String;
begin
  Result := 'FUT_MD5KEY';
end;

function TExportaTintometricosTerceirosFutura.fRetornaBases: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   I.ITE_CODITE, ';
  Result := Result + '   ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN, ';
  Result := Result + '   G.ITE_PRECUS AS PRECUS,      ';
  Result := Result + '   G.ITE_PREVE1 AS PREVE1,      ';
  Result := Result + '   G.ITE_PREVE2 AS PREVE2,      ';
  Result := Result + '   G.ITE_PREVE3 AS PREVE3,      ';
  Result := Result + '   G.ITE_PREVE4 AS PREVE4,      ';
  Result := Result + '   G.ITE_PREVE5 AS PREVE5,      ';
  Result := Result + '   G.ITE_PREVE6 AS PREVE6,      ';
  Result := Result + '   G.ITE_PREVE7 AS PREVE7       ';
  Result := Result + '  FROM                                 ';
  Result := Result + '    FUT_CADBAS B                    ';
  Result := Result + '    INNER JOIN CADITE I                ';
  Result := Result + '      ON B.BAS_CODITE = I.ITE_CODITE   ';
  Result := Result + '    INNER JOIN ITEGER G                ';
  Result := Result + '      ON I.ITE_CODITE = G.ITE_CODITE   ';
  Result := Result + '  WHERE G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;

function TExportaTintometricosTerceirosFutura.fRetornaColorantes: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '    COL_CODCOL, ';
  Result := Result + '    COL_CODITE, ';
  Result := Result + '    COL_EMBALA, ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN, ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,     ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,     ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,     ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,     ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,     ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,     ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,     ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7      ';
  Result := Result + ' FROM                               ';
  Result := Result + '   FUT_CADCOL                    ';
  Result := Result + '   JOIN ITEGER G                    ';
  Result := Result + '     ON G.ITE_CODITE = COL_CODITE   ';
  Result := Result + '   JOIN CADITE I               ';
  Result := Result + '     ON I.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + ' WHERE G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '    AND I.ITE_ITEATI = "S"      ';
end;

function TExportaTintometricosTerceirosFutura.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
var
  qryGen: TUniQuery;
begin
  Result := 0;
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CFG_VALCFG ');
      SQL.Add('   FROM CFGTIN ');
      SQL.Add('  WHERE CFG_IDEPRO = "FUT" ');
      SQL.Add('    AND CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
      SQL.Add('    AND CFG_CODCFG = "APREVE" ');
      Open;

      If Not fEmptyStr(FieldByName('CFG_VALCFG').AsString) Then
        Result := fStrToFloat(FieldByName('CFG_VALCFG').AsString) / 100.0;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosFutura.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'FUT_QTDB' + fStrZero(intCont, 2)
end;

function TExportaTintometricosTerceirosFutura.fRetValorAcrMob(qryGen: TUniQuery;
  fltQuantidade: Double): Double;
begin
  If fltQuantidade <= 0 Then
    Exit(0);

  If strAcrMob = '1' Then
    Result := (1 + qryGen.FieldByName('FUT_ACRMOB').AsFloat / 100)
  Else
    Result := qryGen.FieldByName('FUT_ACRMOB').AsFloat;
end;

function TExportaTintometricosTerceirosFutura.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "FUT" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosFutura.fSQLInsert: String;
begin
  Result := '';
  Result := Result + ' INSERT INTO ' + fNomeTabela;
  Result := Result + ' (                ';
  Result := Result + '   FUT_CODEMP,    ';
  Result := Result + '   FUT_DESCRI,    ';
  Result := Result + '   FUT_REFERE,    ';
  Result := Result + '   FUT_UNIDAD,    ';
  Result := Result + '   FUT_NOMCOR,    ';
  Result := Result + '   FUT_PRODUT,    ';
  Result := Result + '   FUT_SPRODU,    ';
  Result := Result + '   FUT_CODBAS,    ';
  Result := Result + '   FUT_RED___,    ';
  Result := Result + '   FUT_GREEN_,    ';
  Result := Result + '   FUT_BLUE__,    ';
  Result := Result + '   FUT_FAMILI,    ';
  Result := Result + '   FUT_R_G_B_,    ';
  Result := Result + '   FUT_MD5KEY,    ';
  Result := Result + '   FUT_CODITE,    '; //Tabela cadite
  Result := Result + '   FUT_DESITE,    '; //Tabela cadite
  Result := Result + '   FUT_PREVEN,    ';
  Result := Result + '   FUT_PRECUS,    ';
  Result := Result + '   FUT_PREVE1,    ';
  Result := Result + '   FUT_PREVE2,    ';
  Result := Result + '   FUT_PREVE3,    ';
  Result := Result + '   FUT_PREVE4,    ';
  Result := Result + '   FUT_PREVE5,    ';
  Result := Result + '   FUT_PREVE6,    ';
  Result := Result + '   FUT_PREVE7     ';
  Result := Result + ' )                ';

  Result := Result + ' VALUES           ';
  Result := Result + ' (                ';
  Result := Result + '     :CODEMP,     ';
  Result := Result + '     :DESCRI,     ';
  Result := Result + '     :REFERE,     ';
  Result := Result + '     :UNIDAD,     ';
  Result := Result + '     :NOMCOR,     ';
  Result := Result + '     :PRODUT,     ';
  Result := Result + '     :SPRODU,     ';
  Result := Result + '     :CODBAS,     ';
  Result := Result + '     :RED___,     ';
  Result := Result + '     :GREEN_,     ';
  Result := Result + '     :BLUE__,     ';
  Result := Result + '     :FAMILI,     ';
  Result := Result + '     :R_G_B_,     ';
  Result := Result + '     :MD5KEY,     ';
  Result := Result + '     :CODITE,     '; //Tabela cadite
  Result := Result + '     :DESITE,     '; //Tabela cadite
  Result := Result + '     :PREVEN,     ';
  Result := Result + '     :PRECUS,     ';
  Result := Result + '     :PREVE1,     ';
  Result := Result + '     :PREVE2,     ';
  Result := Result + '     :PREVE3,     ';
  Result := Result + '     :PREVE4,     ';
  Result := Result + '     :PREVE5,     ';
  Result := Result + '     :PREVE6,     ';
  Result := Result + '     :PREVE7      ';
  Result := Result + ' )                ';
end;

procedure TExportaTintometricosTerceirosFutura.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
var
  intContador: Integer;
begin
  With DataSet Do
  Begin
    ParamByName('CODEMP').AsStrings[intParam] := VS_strCodEmp;
    ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FUT_DESCRI').AsString);
    ParamByName('REFERE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FUT_REFERE').AsString);
    ParamByName('UNIDAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FUT_UNIDAD').AsString);
    ParamByName('PRODUT').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FUT_PRODUT').AsString);
    ParamByName('SPRODU').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FUT_SPRODU').AsString);
    ParamByName('CODBAS').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FUT_CODBAS').AsString);
    ParamByName('RED___').AsIntegers[intParam] := qryTinta.FieldByName('FUT_RED___').AsInteger;
    ParamByName('GREEN_').AsIntegers[intParam] := qryTinta.FieldByName('FUT_GREEN_').AsInteger;
    ParamByName('BLUE__').AsIntegers[intParam] := qryTinta.FieldByName('FUT_BLUE__').AsInteger;
    ParamByName('FAMILI').AsStrings[intParam]:= fRemoveAcento(qryTinta.FieldByName('FUT_FAMILI').AsString);
    ParamByName('R_G_B_').AsStrings[intParam]:= qryTinta.FieldByName('FUT_R_G_B_').AsString;
    ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('FUT_MD5KEY').AsString;
    ParamByName('CODITE').AsStrings[intParam] := qryTinta.FieldByName('ITE_CODITE').AsString;
    ParamByName('DESITE').AsStrings[intParam] := qryTinta.FieldByName('ITE_DESITE').AsString;
    ParamByName('NOMCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FUT_NOMCOR').AsString);
    ParamByName('PRECUS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['precus'], 0.0);

    If strAcrMob = '1' Then
      ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen * (1 + qryTinta.FieldByName('FUT_ACRMOB').AsFloat / 100)
    Else
      ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen + qryTinta.FieldByName('FUT_ACRMOB').AsFloat;

    For intContador := 1 To 7 Do
    Begin
      If stlTabPre[intContador] <> 'S' Then
        ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0)
      Else
      Begin
        If strAcrMob = '1' Then
          ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] :=  IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) * (1 + qryTinta.FieldByName('FUT_ACRMOB').AsFloat / 100)
        Else
          ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) + qryTinta.FieldByName('FUT_ACRMOB').AsFloat;
      End;
    End;

  End;
end;

procedure TExportaTintometricosTerceirosFutura.pCarregarPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
Var
  intPreVen: Integer;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  fltQuantidade,
  fltPrecoVenda,
  fltPrecoVendaTotal,
  fltPrecoCusto,
  fltPrecoCustoTotal,
  fltPrecoColorante,
  fltPrecoEmbalagem: Double;
  fltPrecoCustoBase: Double;
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
      fltPrecoColorante  := 0;
      fltPrecoEmbalagem  := 0;
      fltPreCusPro       := 0;
      fltPreVenPro       := 0;
      strCodCli          := '';
      strCodCnd          := '';
      intPrzMed          := 0;

      //Calcula o preco de venda
      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryColorantes.Locate('COL_CODCOL', ArrComponentes[intContador].Componente,[]) Then
        Begin
          If fCarregaPromocao(qryColorantes.FieldByName('COL_CODITE').AsString, IntToStr(intPreVen),  strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoColorante := fltPreVenPro
          Else
            fltPrecoColorante := qryColorantes.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
        End;

        fltQuantidade := ArrComponentes[intContador].Quantidade * fFatorTinta;
        fltPrecoVenda := fltQuantidade * (fltPrecoColorante / fRetEmbalagem(qryColorantes));

        fltPrecoVendaTotal := fltPrecoVendaTotal + fltPrecoVenda;
      End;

      If qryBases.Locate('ITE_CODITE', dicRetorno['itebas'],[]) Then
      Begin
        If fCarregaPromocao(dicRetorno['itebas'], IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
        Else
          fltPrecoEmbalagem := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat + (fltPerAcr * qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat);
      End;

      fltPrecoVendaTotal := fltPrecoVendaTotal + (fltPerAcr * fltPrecoVendaTotal) + fltPrecoEmbalagem;

      dicPrecoAdicional['preve' + IntToStr(intPreVen)] := fltPrecoVendaTotal;
    End;

    fltPrecoCustoTotal := 0;
    fltPrecoColorante  := 0;
    fltPrecoCustoBase  := 0;
    fltPreCusPro       := 0;
    fltPreVenPro       := 0;
    strCodCli          := '';
    strCodCnd          := '';
    intPrzMed          := 0;

    //Calculando o Preço de Custo
    For intContador := 1 To Length(ArrComponentes) Do
    Begin
      If fEmptyStr(ArrComponentes[intContador].Componente) Then
        Break;

      If qryColorantes.Locate('COL_CODCOL', ArrComponentes[intContador].Componente,[]) Then
      Begin
        If fCarregaPromocao(qryColorantes.FieldByName('COL_CODITE').AsString, strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        Begin
          fltPrecoColorante := fltPreCusPro;

          If fltPrecoColorante = 0 Then
            fltPrecoColorante := qryColorantes.FieldByName('PRECUS').AsFloat;
        End
        Else
          fltPrecoColorante := qryColorantes.FieldByName('PRECUS').AsFloat;
      End;

      fltQuantidade := ArrComponentes[intContador].Quantidade * fFatorTinta;
      fltPrecoCusto := fltQuantidade * (fltPrecoColorante / fRetEmbalagem(qryColorantes));

      fltPrecoCustoTotal := fltPrecoCustoTotal + fltPrecoCusto;
    End;

    If qryBases.Locate('ITE_CODITE', dicRetorno['itebas'],[]) Then
    Begin
      If fCarregaPromocao(dicRetorno['itebas'], '1', strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
      Begin
        fltPrecoCustoBase := fltPreCusPro + (fltPerAcr * fltPreCusPro);

        If fltPrecoCustoBase = 0 Then
          fltPrecoCustoBase := qryBases.FieldByName('PRECUS').AsFloat + (fltPerAcr * qryBases.FieldByName('PRECUS').AsFloat);
      End
      Else
        fltPrecoCustoBase := qryBases.FieldByName('PRECUS').AsFloat + (fltPerAcr * qryBases.FieldByName('PRECUS').AsFloat);
    End;

    dicPrecoAdicional['precus'] := fltPrecoCustoTotal + fltPrecoCustoBase;
  Finally
    SetLength(arrComponentes, 0);
  End;
end;

procedure TExportaTintometricosTerceirosFutura.pGravaTintometricoTabelasTerceirosPorTinta(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery;
  intParam: Integer);
begin
  pAdicionaParamentros(qryInsert, qryTinta, fltPreVen, intParam);
end;

procedure TExportaTintometricosTerceirosFutura.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' DELETE FROM LOGTIN_SIT    ');
      SQL.Add('  WHERE LOG_IDEPRO = "FUT" ');
      ExecSQL;
    End;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' INSERT INTO LOGTIN_SIT (LOG_IDEPRO, LOG_DTAEXE, LOG_HOREXE, LOG_EXECUT) ');
      SQL.Add('                 VALUES ("FUT", :DTAEXE, :HOREXE, :EXECUT) ');
      ParamByName('DTAEXE').AsDateTime := VS_Date;
      ParamByName('HOREXE').AsDateTime := Time;
      ParamByName('EXECUT').AsString   := strStatus;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosFutura.pProcessaTabelaCores(
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

      pGravaTintometricoTabelasTerceiros(qryInsert, fltPreVen, qryGen, intContador);

      If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
          Synchronize(pStep);

    {$IFDEF LINUX}
      If FValidateIndexList.Contains(qryGen.RecNo) Then
      Begin
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

procedure TExportaTintometricosTerceirosFutura.pSetaParametrosEspecificos(
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
    strSQL := strSQL + '    SIS_CODEMP = "' + VS_strCodEmp + '" AND       ';
    strSQL := strSQL + '    SIS_CODCFG = "CFG_TABPRC"   AND               ';
    strSQL := strSQL + '    SIS_GRUCFG = "PRODUTOS"                       ';

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
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosFutura.Execute;
begin
  inherited Execute;
end;

end.
