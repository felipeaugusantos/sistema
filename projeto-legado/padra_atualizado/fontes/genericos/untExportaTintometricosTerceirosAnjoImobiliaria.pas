unit untExportaTintometricosTerceirosAnjoImobiliaria;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, Windows, Messages,
  cxProgressBar, UniClientDataSet,
  FireDAC.VCLUI.Wait,
{$ENDIF}
  Uni, SysUtils, Variants, Classes, Math,
  untThreadExportacaoTerceiros, DateUtils,
  untExportaTintometricosTerceirosImobiliaria,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TExportaTintometricosTerceirosAnjoImobiliaria = Class(TExportaTintometricosTerceirosImobiliaria)
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
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; Override;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;

    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery;
      fltPreVen: Double; intParam: Integer = 0); override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection;
      strStatus: String); override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pCarregarPrecosAdicionais(dicRetorno: TDicionario; qryColorantes: TUniQuery;
      qryBases: TUniQuery; fltPerAcr: Double); Override;

    procedure pGravaTintometricoTabelasTerceirosPorTinta(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); Override;

    procedure Execute; override;
    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); override;
    destructor Destroy; override;
  End;

implementation

{ TExportaTintometricosTerceirosAnjoImobiliaria }

constructor TExportaTintometricosTerceirosAnjoImobiliaria.Create
  (pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited Create(pgbProgresso, strIdePro, blnAuto);
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosAnjoImobiliaria.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosAnjoImobiliaria.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    ANJ_DESCRI,       ';
  Result := Result + '    ANJ_CODIGO,       ';
  Result := Result + '    ANJ_CODIG2,       ';
  Result := Result + '    BAS_DESCRI,       ';
  Result := Result + '    ANJ_UNIDAD,       ';
  Result := Result + '    ANJ_DTACAD,       ';
  Result := Result + '    ANJ_SUBKEY,       ';
  Result := Result + '    ANJ_PROKEY,       ';
  Result := Result + '    ANJ_BASE__,       ';
  Result := Result + '    ITE_CODITE,       ';
  Result := Result + '    ITE_DESITE,       ';
  Result := Result + '    ITE_REFERE,       ';
  Result := Result + '    ANJ_ACRMOB,       ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    ANJ_FORM' + fStrZero(intContador, 2) + ',    ';
    Result := Result + '    ANJ_QTDB' + fStrZero(intContador, 2) + ',    ';
  End;

  Result := Result + '    ANJ_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    ANJ_CADANJ        ';
  Result := Result + '  INNER JOIN ANJ_CADBAS ON   ';
  Result := Result + '    ANJ_PROKEY = BAS_PROKEY AND   ';
  Result := Result + '    ANJ_SUBKEY = BAS_SUBKEY AND   ';
  Result := Result + '    ANJ_UNIDAD = BAS_UNIDAD AND   ';
  Result := Result + '    ANJ_BASE__ = BAS_BASE__       ';
  Result := Result + '  INNER JOIN CADITE I ON     ';
  Result := Result + '    BAS_CODITE = I.ITE_CODITE     ';
  Result := Result + '    AND I.ITE_ITEATI = "S"        ';
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE ' + fNomeTabela() + '   (      ';
  Result := Result + '    ANJ_CODIGO VARCHAR(25),           ';
  Result := Result + '    ANJ_CODIG2 VARCHAR(25),           ';
  Result := Result + '    ANJ_BASE__ CHAR(2),               ';
  Result := Result + '    ANJ_PROKEY CHAR(2),               ';
  Result := Result + '    ANJ_SUBKEY CHAR(2),               ';
  Result := Result + '    ANJ_UNIDAD CHAR(3),               ';
  Result := Result + '    ANJ_DESCRI VARCHAR(60),           ';
  Result := Result + '    ANJ_CODITE VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    ANJ_DESITE VARCHAR(70),           ';
  Result := Result + '    ANJ_REFERE VARCHAR(20),           ';
  Result := Result + '    ANJ_MD5KEY VARCHAR(32),           ';
  Result := Result + '    ANJ_PREVEN DECIMAL(12, 4),        ';
  Result := Result + '    ANJ_PRECUS DECIMAL(12, 4),        ';
  Result := Result + '    ANJ_PREVE1 DECIMAL(12, 4),        ';
  Result := Result + '    ANJ_PREVE2 DECIMAL(12, 4),        ';
  Result := Result + '    ANJ_PREVE3 DECIMAL(12, 4),        ';
  Result := Result + '    ANJ_PREVE4 DECIMAL(12, 4),        ';
  Result := Result + '    ANJ_PREVE5 DECIMAL(12, 4),        ';
  Result := Result + '    ANJ_PREVE6 DECIMAL(12, 4),        ';
  Result := Result + '    ANJ_PREVE7 DECIMAL(12, 4)         ';
  Result := Result + '    );                                ';

end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fFatorTinta: Double;
begin
  Result := 1;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('ANJ_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('COL_CODCOL', qryGen.FieldByName('ANJ_FORM' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fNomeTabela: String;
begin
  Result := 'ANJ_CADANJ_SIT';
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.
  fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fRetDescricao: String;
begin
  Result := 'ANJ_DESCRI';
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fRetEmbalagem
  (qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fRetFormula
  (intCont: Integer): String;
begin
  Result := 'ANJ_FORM' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fRetItemBase: String;
begin
  Result := 'ITE_CODITE';
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fRetMD5KEY: String;
begin
  Result := 'ANJ_MD5KEY';
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    I.ITE_CODITE,     ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,    ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,       ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,       ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,       ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,       ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,       ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,       ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,       ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7        ';
  Result := Result + '  FROM                ';
  Result := Result + '    ANJ_CADBAS B      ';
  Result := Result + '  INNER JOIN CADITE I ON      ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE     ';
  Result := Result + '  INNER JOIN ITEGER G ON      ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE     ';
  Result := Result + '  WHERE               ';
  Result := Result + '    G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.
  fRetornaColorantes: String;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    COL_CODCOL,       ';
  Result := Result + '    COL_CODITE,       ';
  Result := Result + '    COL_EMBALA,       ';
  Result := Result + '    COL_DESCRI,       ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,    ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,     ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,     ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,     ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,     ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,     ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,     ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,     ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7      ';
  Result := Result + '  FROM                ';
  Result := Result + '    ANJ_CADCOL        ';
  Result := Result + '  JOIN ITEGER G ON    ';
  Result := Result + '    G.ITE_CODITE = COL_CODITE     ';
  Result := Result + '  JOIN CADITE I ON    ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE   ';
  Result := Result + '  WHERE               ';
  Result := Result + '    G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '  AND I.ITE_ITEATI = "S"          ';
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.
  fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
  strSql: String;
begin
  Try
    strSql := '';
    strSql := strSql + '  SELECT                ';
    strSql := strSql + '    CFG_VALCFG          ';
    strSql := strSql + '  FROM                  ';
    strSql := strSql + '    CFGTIN              ';
    strSql := strSql + '  WHERE                 ';
    strSql := strSql + '    CFG_IDEPRO = "ANJ"  AND     ';
    strSql := strSql + '    CFG_GRUCFG = "CONFIGURACOES"  AND     ';
    strSql := strSql + '    CFG_CODCFG = "APREVE" AND   ';
    strSql := strSql + '    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp);

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSql);
    qryGen.Open;

    If fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := 0
    Else
      Result := fStrToFloat(qryGen.FieldByName('CFG_VALCFG').AsString);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fRetQuantidade
  (intCont: Integer): String;
begin
  Result := 'ANJ_QTDB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fRetValorAcrMob(
  qryGen: TUniQuery; fltQuantidade: Double): Double;
begin
  If fltQuantidade <= 0 Then
    Exit(0);

  If strAcrMob = '1' Then
    Result := (1 + qryGen.FieldByName('ANJ_ACRMOB').AsFloat / 100)
  Else
    Result := qryGen.FieldByName('ANJ_ACRMOB').AsFloat;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "ANJ" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosAnjoImobiliaria.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO ' + fNomeTabela() + '   (     ';
  Result := Result + '    ANJ_CODIGO,           ';
  Result := Result + '    ANJ_CODIG2,           ';
  Result := Result + '    ANJ_BASE__,           ';
  Result := Result + '    ANJ_PROKEY,           ';
  Result := Result + '    ANJ_SUBKEY,           ';
  Result := Result + '    ANJ_UNIDAD,           ';
  Result := Result + '    ANJ_DESCRI,           ';
  Result := Result + '    ANJ_CODITE,           ';
  Result := Result + '    ANJ_DESITE,           ';
  Result := Result + '    ANJ_REFERE,           ';
  Result := Result + '    ANJ_MD5KEY,           ';
  Result := Result + '    ANJ_PREVEN,           ';
  Result := Result + '    ANJ_PRECUS,           ';
  Result := Result + '    ANJ_PREVE1,           ';
  Result := Result + '    ANJ_PREVE2,           ';
  Result := Result + '    ANJ_PREVE3,           ';
  Result := Result + '    ANJ_PREVE4,           ';
  Result := Result + '    ANJ_PREVE5,           ';
  Result := Result + '    ANJ_PREVE6,           ';
  Result := Result + '    ANJ_PREVE7            ';
  Result := Result + '    )                     ';
  Result := Result + '    VALUES ' + ' (       ';
  Result := Result + '    :CODIGO,              ';
  Result := Result + '    :CODIG2,              ';
  Result := Result + '    :BASE__,              ';
  Result := Result + '    :PROKEY,              ';
  Result := Result + '    :SUBKEY,              ';
  Result := Result + '    :UNIDAD,              ';
  Result := Result + '    :DESCRI,              ';
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
  Result := Result + '    );                    ';
end;

procedure TExportaTintometricosTerceirosAnjoImobiliaria.pAdicionaParamentros
  (var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
var
  intContador: Integer;
begin
  DataSet.ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ANJ_CODIGO').AsString);
  DataSet.ParamByName('CODIG2').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ANJ_CODIG2').AsString);
  DataSet.ParamByName('BASE__').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ANJ_BASE__').AsString);
  DataSet.ParamByName('PROKEY').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ANJ_PROKEY').AsString);
  DataSet.ParamByName('SUBKEY').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ANJ_SUBKEY').AsString);
  DataSet.ParamByName('UNIDAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ANJ_UNIDAD').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ANJ_DESCRI').AsString);
  DataSet.ParamByName('CODITE').AsStrings[intParam] := qryTinta.FieldByName('ITE_CODITE').AsString;
  DataSet.ParamByName('DESITE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ITE_DESITE').AsString);
  DataSet.ParamByName('REFERE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ITE_REFERE').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('ANJ_MD5KEY').AsString;
  DataSet.ParamByName('PRECUS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['precus'], 0.0);

  If strAcrMob = '1' Then
    DataSet.ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen * (1 + qryTinta.FieldByName('ANJ_ACRMOB').AsFloat / 100)
  Else
    DataSet.ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen + qryTinta.FieldByName('ANJ_ACRMOB').AsFloat;

  DataSet.ParamByName('PRECUS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['precus'], 0);

  For intContador := 1 To 7 Do
  Begin
    If stlTabPre[intContador] <> 'S' Then
      DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0)
    Else
    Begin
      If strAcrMob = '1' Then
        DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] :=  IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) * (1 + qryTinta.FieldByName('ANJ_ACRMOB').AsFloat / 100)
      Else
        DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) + qryTinta.FieldByName('ANJ_ACRMOB').AsFloat;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosAnjoImobiliaria.pCarregarPrecosAdicionais(
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

procedure TExportaTintometricosTerceirosAnjoImobiliaria.pGravaTintometricoTabelasTerceirosPorTinta(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery;
  intParam: Integer);
begin
  pAdicionaParamentros(qryInsert, qryTinta, fltPreVen, intParam);
end;

procedure TExportaTintometricosTerceirosAnjoImobiliaria.pIncluirLogTinSite
  (Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSql: String;
begin
  Try
    strSql := '';
    strSql := ' DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "ANJ" ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSql);
    qryGen.ExecSQL;

    strSql := '';
    strSql := ' INSERT INTO ' + ' LOGTIN_SIT  ' + ' ( ';
    strSql := strSql + '  LOG_IDEPRO,       ';
    strSql := strSql + '  LOG_DTAEXE,       ';
    strSql := strSql + '  LOG_HOREXE,       ';
    strSql := strSql + '  LOG_EXECUT        ';
    strSql := strSql + '        )           ';
    strSql := strSql + '  VALUES  ' + ' (     ';
    strSql := strSql + '  "ANJ",            ';
    strSql := strSql + '  :DTAEXE,          ';
    strSql := strSql + '  :HOREXE,          ';
    strSql := strSql + '  :EXECUT           ';
    strSql := strSql + '      );            ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSql);
    qryGen.ParamByName('DTAEXE').AsDateTime := VS_Date;
    qryGen.ParamByName('HOREXE').AsDateTime := Time;
    qryGen.ParamByName('EXECUT').AsString := strStatus;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosAnjoImobiliaria.pProcessaTabelaCores(
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
    If Not fValidarPrecosCalculado() Then
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

procedure TExportaTintometricosTerceirosAnjoImobiliaria.pSetaParametrosEspecificos(
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

end.
