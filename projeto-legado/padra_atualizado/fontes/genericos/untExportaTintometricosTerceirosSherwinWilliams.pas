unit untExportaTintometricosTerceirosSherwinWilliams;

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
  untThreadExportacaoTerceiros, DateUtils,
  untExportaTintometricosTerceirosImobiliaria,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

type
  TExportaTintometricosTerceirosSherwinWilliams = class(TExportaTintometricosTerceirosImobiliaria)
  Private
    strAcrMob: String;
    function fRetValorAcrMobCfgTin(): String;
    function fRetValorAcrMob(qryGen: TUniQuery; fltQuantidade: Double): Double;
  protected
    procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
      strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Override;
  public
    function fNomeTabela: String; override;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;
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

{ TExportaTintometricosTerceirosSherwinWilliams }

constructor TExportaTintometricosTerceirosSherwinWilliams.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean = False);
begin
  inherited  Create(pgbProgresso, strIdePro, blnAuto);
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosSherwinWilliams.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

function TExportaTintometricosTerceirosSherwinWilliams.fCamposSelect: String;
begin
  Result := '';
  Result := Result + ' SELECT  ';
  Result := Result + '   SHE_CODEMP, ';
  Result := Result + '   SHE_DESCRI, ';
  Result := Result + '   SHE_CODIGO, ';
  Result := Result + '   SHE_CODIG2, ';
  Result := Result + '   SHE_UNIDAD, ';
  Result := Result + '   SHE_BASE__, ';
  Result := Result + '   SHE_PROKEY, ';
  Result := Result + '   SHE_SUBKEY, ';
  Result := Result + '   SHE_COMMEN, ';
  Result := Result + '   SHE_ACRMOB, ';

  Result := Result + '   SHE_MD5KEY, ';

  Result := Result + '   S.AUTOINCREM, ';

  Result := Result + '   ITE_CODITE, ';
  Result := Result + '   ITE_DESITE, ';

  Result := Result + '   SHE_FORM01, ';
  Result := Result + '   SHE_QTDB01, ';
  Result := Result + '   SHE_FORM02, ';
  Result := Result + '   SHE_QTDB02, ';
  Result := Result + '   SHE_FORM03, ';
  Result := Result + '   SHE_QTDB03, ';
  Result := Result + '   SHE_FORM04, ';
  Result := Result + '   SHE_QTDB04, ';
  Result := Result + '   SHE_FORM05, ';
  Result := Result + '   SHE_QTDB05, ';
  Result := Result + '   SHE_FORM06, ';
  Result := Result + '   SHE_QTDB06, ';
  Result := Result + '   SHE_FORM07, ';
  Result := Result + '   SHE_QTDB07, ';
  Result := Result + '   SHE_FORM08, ';
  Result := Result + '   SHE_QTDB08, ';
  Result := Result + '   SHE_FORM09, ';
  Result := Result + '   SHE_QTDB09, ';
  Result := Result + '   SHE_FORM10, ';
  Result := Result + '   SHE_QTDB10, ';
  Result := Result + '   SHE_FORM11, ';
  Result := Result + '   SHE_QTDB11, ';
  Result := Result + '   SHE_FORM12, ';
  Result := Result + '   SHE_QTDB12, ';
  Result := Result + '   SHE_FORM13, ';
  Result := Result + '   SHE_QTDB13, ';
  Result := Result + '   SHE_FORM14, ';
  Result := Result + '   SHE_QTDB14, ';
  Result := Result + '   SHE_FORM15, ';
  Result := Result + '   SHE_QTDB15, ';
  Result := Result + '   SHE_FORM16, ';
  Result := Result + '   SHE_FORM17, ';
  Result := Result + '   SHE_FORM18, ';
  Result := Result + '   SHE_FORM19, ';
  Result := Result + '   SHE_FORM20, ';
  Result := Result + '   SHE_QTDB16, ';
  Result := Result + '   SHE_QTDB17, ';
  Result := Result + '   SHE_QTDB18, ';
  Result := Result + '   SHE_QTDB19, ';
  Result := Result + '   SHE_QTDB20  ';

  Result := Result + ' FROM SHE_CADSHE S ';
  Result := Result + '   INNER JOIN SHE_CADBAS B ';
  Result := Result + '     ON SHE_PROKEY = BAS_PROKEY ';
  Result := Result + '       AND SHE_SUBKEY = BAS_SUBKEY ';
  Result := Result + '       AND SHE_BASE__ = BAS_BASE__ ';
  Result := Result + '       AND SHE_UNIDAD = BAS_UNIDAD ';
  Result := Result + '   INNER JOIN CADITE I ';
  Result := Result + '     ON BAS_CODITE = I.ITE_CODITE ';
  Result := Result + '      AND I.ITE_ITEATI = "S"    ';
  Result := Result + ' WHERE TRUE ';
end;

function TExportaTintometricosTerceirosSherwinWilliams.fCamposTabela: String;
begin
  Result := '';
  Result := Result + ' CREATE TABLE ' + fNomeTabela;
  Result := Result + ' ( SHE_CODEMP CHAR(3),        ';
  Result := Result + '   SHE_DESCRI VARCHAR(60),    ';
  Result := Result + '   SHE_CODIGO VARCHAR(25),    ';
  Result := Result + '   SHE_CODIG2 VARCHAR(25),    ';
  Result := Result + '   SHE_UNIDAD CHAR(2),        ';
  Result := Result + '   SHE_BASE__ CHAR(2),        ';
  Result := Result + '   SHE_PROKEY CHAR(2),        ';
  Result := Result + '   SHE_SUBKEY CHAR(2),        ';
  Result := Result + '   SHE_COMMEN VARCHAR(100),   ';
  Result := Result + '   SHE_MD5KEY VARCHAR(32),    ';
  Result := Result + '   SHE_CODITE VARCHAR('+ fTamCodIte.ToString +'),        '; //Tabela cadite
  Result := Result + '   SHE_DESITE VARCHAR(70),    '; //Tabela cadite
  Result := Result + '   SHE_PREVEN DECIMAL(12,4),  ';
  Result := Result + '   SHE_PRECUS DECIMAL(12,4),  ';
  Result := Result + '   SHE_PREVE1 DECIMAL(12,4),  ';
  Result := Result + '   SHE_PREVE2 DECIMAL(12,4),  ';
  Result := Result + '   SHE_PREVE3 DECIMAL(12,4),  ';
  Result := Result + '   SHE_PREVE4 DECIMAL(12,4),  ';
  Result := Result + '   SHE_PREVE5 DECIMAL(12,4),  ';
  Result := Result + '   SHE_PREVE6 DECIMAL(12,4),  ';
  Result := Result + '   SHE_PREVE7 DECIMAL(12,4)   ';
  Result := Result + '        );                    ';
end;

function TExportaTintometricosTerceirosSherwinWilliams.fFatorTinta: Double;
begin
  Result := 0.924;
end;

function TExportaTintometricosTerceirosSherwinWilliams.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('SHE_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('COL_CODCOL', qryGen.FieldByName('SHE_FORM' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosSherwinWilliams.fNomeTabela: String;
begin
  Result := 'SHE_CADSHE_SIT';
end;

function TExportaTintometricosTerceirosSherwinWilliams.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosSherwinWilliams.fRetDescricao: String;
begin
  Result := 'SHE_DESCRI';
end;

function TExportaTintometricosTerceirosSherwinWilliams.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

function TExportaTintometricosTerceirosSherwinWilliams.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'SHE_FORM' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosSherwinWilliams.fRetItemBase: String;
begin
  Result := 'ITE_CODITE';
end;

function TExportaTintometricosTerceirosSherwinWilliams.fRetMD5KEY: String;
begin
  Result := 'SHE_MD5KEY';
end;

function TExportaTintometricosTerceirosSherwinWilliams.fRetornaBases: String;
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
  Result := Result + '    SHE_CADBAS B                    ';
  Result := Result + '    INNER JOIN CADITE I                ';
  Result := Result + '      ON B.BAS_CODITE = I.ITE_CODITE   ';
  Result := Result + '    INNER JOIN ITEGER G                ';
  Result := Result + '      ON I.ITE_CODITE = G.ITE_CODITE   ';
  Result := Result + '  WHERE G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;

function TExportaTintometricosTerceirosSherwinWilliams.fRetornaColorantes: String;
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
  Result := Result + '   SHE_CADCOL                    ';
  Result := Result + '   JOIN ITEGER G                    ';
  Result := Result + '     ON G.ITE_CODITE = COL_CODITE   ';
  Result := Result + '   JOIN CADITE I               ';
  Result := Result + '     ON I.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + ' WHERE G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '  AND I.ITE_ITEATI = "S"            ';
end;

function TExportaTintometricosTerceirosSherwinWilliams.fRetornaPercentualAcrescimo(
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
      SQL.Add('  WHERE CFG_IDEPRO = "SHE" ');
      SQL.Add('    AND CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
      SQL.Add('    AND CFG_CODCFG = "APREVE" ');
      Open;

      If Not fEmptyStr(FieldByName('CFG_VALCFG').AsString) Then
        Result := fStrToFloat(FieldByName('CFG_VALCFG').AsString) / 100.0;
    End;
  Finally
    FreeAndNil(qryGen);
  End;

  {//Estou retornando o tipo de embalagem aqui, por conta da forma especifica
  //que a sherwin williams utiliza a sua embalagem, nas outras integracoes a
  //maioria daa embalagens sao fixas;
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CFG_VALCFG ');
      SQL.Add('   FROM CFGTIN ');
      SQL.Add('  WHERE CFG_IDEPRO = "SHE" ');
      SQL.Add('    AND CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
      SQL.Add('    AND CFG_CODCFG = "SHEEMB" ');
      Open;

      intEmbalagem := IIF(FieldByName('CFG_VALCFG').AsInteger = 0, 946, 1000);
    End;
  Finally
    FreeAndNil(qryGen);
  End; }
end;

function TExportaTintometricosTerceirosSherwinWilliams.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'SHE_QTDB' + fStrZero(intCont, 2)
end;

function TExportaTintometricosTerceirosSherwinWilliams.fRetValorAcrMob(
  qryGen: TUniQuery; fltQuantidade: Double): Double;
begin
  If fltQuantidade <= 0 Then
    Exit(0);

  If strAcrMob = '1' Then
    Result := (1 + qryGen.FieldByName('SHE_ACRMOB').AsFloat / 100)
  Else
    Result := qryGen.FieldByName('SHE_ACRMOB').AsFloat;
end;

function TExportaTintometricosTerceirosSherwinWilliams.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "SHE" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosSherwinWilliams.fSQLInsert: String;
begin
  Result := '';
  Result := Result + ' INSERT INTO ' + fNomeTabela;
  Result := Result + ' (                ';
  Result := Result + '   SHE_CODEMP,    ';
  Result := Result + '   SHE_DESCRI,    ';
  Result := Result + '   SHE_CODIGO,    ';
  Result := Result + '   SHE_CODIG2,    ';
  Result := Result + '   SHE_UNIDAD,    ';
  Result := Result + '   SHE_BASE__,    ';
  Result := Result + '   SHE_PROKEY,    ';
  Result := Result + '   SHE_SUBKEY,    ';
  Result := Result + '   SHE_COMMEN,    ';
  Result := Result + '   SHE_MD5KEY,    ';
  Result := Result + '   SHE_CODITE,    '; //Tabela cadite
  Result := Result + '   SHE_DESITE,    '; //Tabela cadite
  Result := Result + '   SHE_PREVEN,    ';
  Result := Result + '   SHE_PRECUS,    ';
  Result := Result + '   SHE_PREVE1,    ';
  Result := Result + '   SHE_PREVE2,    ';
  Result := Result + '   SHE_PREVE3,    ';
  Result := Result + '   SHE_PREVE4,    ';
  Result := Result + '   SHE_PREVE5,    ';
  Result := Result + '   SHE_PREVE6,    ';
  Result := Result + '   SHE_PREVE7     ';
  Result := Result + ' )                ';
  Result := Result + ' VALUES           ';
  Result := Result + ' (                ';
  Result := Result + '     :CODEMP,     ';
  Result := Result + '     :DESCRI,     ';
  Result := Result + '     :CODIGO,     ';
  Result := Result + '     :CODIG2,     ';
  Result := Result + '     :UNIDAD,     ';
  Result := Result + '     :BASE__,     ';
  Result := Result + '     :PROKEY,     ';
  Result := Result + '     :SUBKEY,     ';
  Result := Result + '     :COMMEN,     ';
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

procedure TExportaTintometricosTerceirosSherwinWilliams.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
begin
  With DataSet Do
  Begin
    ParamByName('CODEMP').AsStrings[intParam] := VS_strCodEmp;
    ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SHE_DESCRI').AsString);
    ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SHE_CODIGO').AsString);
    ParamByName('CODIG2').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SHE_CODIG2').AsString);
    ParamByName('UNIDAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SHE_UNIDAD').AsString);
    ParamByName('BASE__').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SHE_BASE__').AsString);
    ParamByName('PROKEY').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SHE_PROKEY').AsString);
    ParamByName('SUBKEY').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SHE_SUBKEY').AsString);
    ParamByName('COMMEN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SHE_COMMEN').AsString);
    ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('SHE_MD5KEY').AsString;
    ParamByName('CODITE').AsStrings[intParam] := qryTinta.FieldByName('ITE_CODITE').AsString;
    ParamByName('DESITE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ITE_DESITE').AsString);
    ParamByName('PRECUS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['precus'], 0.0);

    If strAcrMob = '1' Then
      ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen * (1 + qryTinta.FieldByName('SHE_ACRMOB').AsFloat / 100)
    Else
      ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen + qryTinta.FieldByName('SHE_ACRMOB').AsFloat;

    For intContador := 1 To 7 Do
    Begin
      If stlTabPre[intContador] <> 'S' Then
        ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0)
      Else
      Begin
        If strAcrMob = '1' Then
          ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] :=  IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) * (1 + qryTinta.FieldByName('SHE_ACRMOB').AsFloat / 100)
        Else
          ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) + qryTinta.FieldByName('SHE_ACRMOB').AsFloat;
      End;
    End;

  End;
end;

procedure TExportaTintometricosTerceirosSherwinWilliams.pCarregarPrecosAdicionais(
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

procedure TExportaTintometricosTerceirosSherwinWilliams.pGravaTintometricoTabelasTerceirosPorTinta(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery;
  intParam: Integer);
begin
  pAdicionaParamentros(qryInsert, qryTinta, fltPreVen, intParam);
end;

procedure TExportaTintometricosTerceirosSherwinWilliams.pIncluirLogTinSite(
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
      SQL.Add('  WHERE LOG_IDEPRO = "SHE" ');
      ExecSQL;
    End;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' INSERT INTO LOGTIN_SIT (LOG_IDEPRO, LOG_DTAEXE, LOG_HOREXE, LOG_EXECUT) ');
      SQL.Add('                 VALUES ("SHE", :DTAEXE, :HOREXE, :EXECUT) ');
      ParamByName('DTAEXE').AsDateTime := VS_Date;
      ParamByName('HOREXE').AsDateTime := Time;
      ParamByName('EXECUT').AsString   := strStatus;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosSherwinWilliams.pProcessaTabelaCores(
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
    if VS_ExitProcessSignal then
      Break;
  {$ENDIF}

   {$IFDEF LINUX}
    pEscreverAguardeCalculando;
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

procedure TExportaTintometricosTerceirosSherwinWilliams.pSetaParametrosEspecificos(
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

procedure TExportaTintometricosTerceirosSherwinWilliams.Execute;
begin
  inherited Execute;
end;

end.
