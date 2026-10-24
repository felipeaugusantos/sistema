unit untExportaTintometricosTerceirosResicolor;

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
  untThreadExportacaoTerceiros, DateUtils, DB,
  untExportaTintometricosTerceirosImobiliaria,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TExportaTintometricosTerceirosResicolor = Class(TExportaTintometricosTerceirosImobiliaria)
  Private
    arrResicolor: TArrExcel;
    strAcrMob: String;
    function fRetValorAcrMobCfgTin(): String;
    function fRetValorAcrMob(qryGen: TUniQuery; fltQuantidade: Double): Double;
  Protected
    procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
      strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Override;
  Public
    function fNomeTabela(): String; Override;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;
    function fQuantidadeFormulacao(): Integer; Override;
    function fFatorTinta(): Double; Override;
    function fRetDescricao(): String; Override;
    function fRetItemBase(): String; Override;
    function fRetMD5KEY(): String; Override;
    function fRetFormula(intCont: Integer):String; Override;
    function fRetQuantidade(intCont: Integer): String; Override;
    function fRetEmbalagem(qryColorantes: TUniQuery): Double; Override;
    function fCamposTabela(): String; Override;
    function fCamposSelect(): String; Override;
    function fSQLInsert(): String; Override;
    function fRetornaColorantes(): String; Override;
    function fRetornaBases(): String; Override;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; Override;
    function fGetPorLinha(): Integer; Override;


    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery;
      fltPreVen: Double; intParam: Integer = 0); override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); override;
    procedure pCarregarPrecosAdicionais(dicRetorno: TDicionario; qryColorantes: TUniQuery;
      qryBases: TUniQuery; fltPerAcr: Double); Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;

    procedure pGravaTintometricoTabelasTerceirosPorTinta(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); Override;

    procedure Execute; override;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); override;
    destructor Destroy; override;
  End;

implementation

{ TExportaTintometricosTerceirosResicolor }

constructor TExportaTintometricosTerceirosResicolor.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited Create(pgbProgresso, strIdePro, blnAuto);
  dicPrecoAdicional := TDicionario.Create;
  stlTabPre := TStringList.Create;
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosResicolor.Destroy;
begin
  inherited;
  If Assigned(dicPrecoAdicional) Then FreeAndNil(dicPrecoAdicional);
  If Assigned(stlTabPre) Then FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosResicolor.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosResicolor.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    RSI_DESCRI,       ';
  Result := Result + '    RSI_CODIGO,       ';
  Result := Result + '    RSI_CODIG2,       ';
  Result := Result + '    RSI_UNIDAD,       ';
  Result := Result + '    RSI_BASE__,       ';
  Result := Result + '    RSI_PROKEY,       ';
  Result := Result + '    RSI_SUBKEY,       ';
  Result := Result + '    ITE_CODITE,       ';
  Result := Result + '    ITE_DESITE,       ';
  Result := Result + '    ITE_REFERE,       ';
  Result := Result + '    RSI_ACRMOB,       ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    RSI_FORM' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    RSI_QTDB' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    RSI_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    RSI_CADRSI        ';
  Result := Result + '  INNER JOIN RSI_CADBAS ON        ';
  Result := Result + '    RSI_BASE__ = BAS_BASE__ AND           ';
  Result := Result + '    RSI_PROKEY = BAS_PROKEY AND           ';
  Result := Result + '    RSI_SUBKEY = BAS_SUBKEY AND           ';
  Result := Result + '    RSI_UNIDAD = BAS_UNIDAD               ';
  Result := Result + '  INNER JOIN CADITE ON            ';
  Result := Result + '    BAS_CODITE = ITE_CODITE               ';
  Result := Result + '    AND ITE_ITEATI = "S"                  ';
  Result := Result + '  WHERE               ';
  Result := Result + '    RSI_PROKEY = "' + arrResicolor[intLinha].Produto + '" AND     ';
  Result := Result + '    RSI_SUBKEY = "' + arrResicolor[intLinha].SubProduto + '"      ';
end;

function TExportaTintometricosTerceirosResicolor.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE  ' + fNomeTabela() + '   (   ';
  Result := Result + '    RSI_BASE__ CHAR(2),         ';
  Result := Result + '    RSI_PROKEY CHAR(2),         ';
  Result := Result + '    RSI_SUBKEY CHAR(2),         ';
  Result := Result + '    RSI_UNIDAD CHAR(2),         ';
  Result := Result + '    RSI_DESCRI VARCHAR(60),     ';
  Result := Result + '    RSI_CODIGO VARCHAR(25),     ';
  Result := Result + '    RSI_CODIG2 VARCHAR(25),     ';
  Result := Result + '    RSI_CODITE VARCHAR(' + fTamCodIte.ToString() + '),      ';
  Result := Result + '    RSI_DESITE VARCHAR(70),     ';
  Result := Result + '    RSI_REFERE VARCHAR(20),     ';
  Result := Result + '    RSI_MD5KEY VARCHAR(32),     ';
  Result := Result + '    RSI_PREVEN DECIMAL(12,4),   ';
  Result := Result + '    RSI_PRECUS DECIMAL(12,4),   ';
  Result := Result + '    RSI_PREVE1 DECIMAL(12,4),   ';
  Result := Result + '    RSI_PREVE2 DECIMAL(12,4),   ';
  Result := Result + '    RSI_PREVE3 DECIMAL(12,4),   ';
  Result := Result + '    RSI_PREVE4 DECIMAL(12,4),   ';
  Result := Result + '    RSI_PREVE5 DECIMAL(12,4),   ';
  Result := Result + '    RSI_PREVE6 DECIMAL(12,4),   ';
  Result := Result + '    RSI_PREVE7 DECIMAL(12,4)    ';
  Result := Result + '              );                            ';
end;

function TExportaTintometricosTerceirosResicolor.fFatorTinta: Double;
begin
  Result := 1;
end;

function TExportaTintometricosTerceirosResicolor.fGetPorLinha: Integer;
Var
  qryBases: TUniQuery;
  strSQL: String;
begin
  Try
    SetLength(arrResicolor, 0);

    strSQL := '';
    strSQL := strSQL + '  SELECT DISTINCT       ';
    strSQL := strSQL + '    BAS_PROKEY,         ';
    strSQL := strSQL + '    BAS_SUBKEY          ';
    strSQL := strSQL + '  FROM                  ';
    strSQL := strSQL + '    RSI_CADBAS          ';
    strSQL := strSQL + '  INNER JOIN CADITE ON            ';
    strSQL := strSQL + '    BAS_CODITE = ITE_CODITE             ';

    qryBases := fCriaQuery();
    qryBases.Close;
    qryBases.SQL.Clear;
    qryBases.SQL.Add(strSQL);
    qryBases.Open;

    If qryBases.IsEmpty Then
    Begin
      Result := 1;
      Exit;
    End;

    qryBases.First;

    While Not qryBases.Eof Do
    Begin
      SetLength(arrResicolor, Length(arrResicolor) + 1);
      arrResicolor[Length(arrResicolor) - 1].Produto := qryBases.FieldByName('BAS_PROKEY').AsString;
      arrResicolor[Length(arrResicolor) - 1].SubProduto := qryBases.FieldByName('BAS_SUBKEY').AsString;

      qryBases.Next;
    End;

    Result := Length(arrResicolor);
  Finally
    FreeAndNil(qryBases);
  End;
end;

function TExportaTintometricosTerceirosResicolor.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('RSI_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('COL_CODCOL', qryGen.FieldByName('RSI_FORM' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosResicolor.fNomeTabela: String;
begin
  Result := 'RSI_CADRSI_SIT';
end;

function TExportaTintometricosTerceirosResicolor.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosResicolor.fRetDescricao: String;
begin
  Result := 'RSI_DESCRI';
end;

function TExportaTintometricosTerceirosResicolor.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

function TExportaTintometricosTerceirosResicolor.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'RSI_FORM' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosResicolor.fRetItemBase: String;
begin
  Result := 'ITE_CODITE';
end;

function TExportaTintometricosTerceirosResicolor.fRetMD5KEY: String;
begin
  Result := 'RSI_MD5KEY';
end;

function TExportaTintometricosTerceirosResicolor.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    I.ITE_CODITE,       ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,   ';
  Result := Result + '    ITE_PRECUS AS PRECUS,       ';
  Result := Result + '    ITE_PREVE1 AS PREVE1,       ';
  Result := Result + '    ITE_PREVE2 AS PREVE2,       ';
  Result := Result + '    ITE_PREVE3 AS PREVE3,       ';
  Result := Result + '    ITE_PREVE4 AS PREVE4,       ';
  Result := Result + '    ITE_PREVE5 AS PREVE5,       ';
  Result := Result + '    ITE_PREVE6 AS PREVE6,       ';
  Result := Result + '    ITE_PREVE7 AS PREVE7        ';
  Result := Result + '  FROM                  ';
  Result := Result + '    RSI_CADBAS  B       ';
  Result := Result + '  INNER JOIN CADITE I ON              ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE             ';
  Result := Result + '  INNER JOIN ITEGER G ON              ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE             ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"   ';
end;

function TExportaTintometricosTerceirosResicolor.fRetornaColorantes: String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    COL_CODCOL,         ';
  Result := Result + '    COL_CODITE,         ';
  Result := Result + '    COL_DESCRI,         ';
  Result := Result + '    COL_EMBALA,         ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,     ';
  Result := Result + '    ITE_PRECUS AS PRECUS,         ';
  Result := Result + '    ITE_PREVE1 AS PREVE1,         ';
  Result := Result + '    ITE_PREVE2 AS PREVE2,         ';
  Result := Result + '    ITE_PREVE3 AS PREVE3,         ';
  Result := Result + '    ITE_PREVE4 AS PREVE4,         ';
  Result := Result + '    ITE_PREVE5 AS PREVE5,         ';
  Result := Result + '    ITE_PREVE6 AS PREVE6,         ';
  Result := Result + '    ITE_PREVE7 AS PREVE7          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    RSI_CADCOL C        ';
  Result := Result + '  JOIN ITEGER G ON              ';
  Result := Result + '    G.ITE_CODITE = C.COL_CODITE       ';
  Result := Result + '  JOIN CADITE I ON              ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE       ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"   ';
  Result := Result + '  AND I.ITE_ITEATI = "S"            ';
end;

function TExportaTintometricosTerceirosResicolor.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    Result := 0;

    strSQL := '';
    strSQL := strSQL + '    SELECT                  ';
    strSQL := strSQL + '      CFG_VALCFG            ';
    strSQL := strSQL + '    FROM                    ';
    strSQL := strSQL + '      CFGTIN                ';
    strSQL := strSQL + '    WHERE                   ';
    strSQL := strSQL + '      CFG_IDEPRO = "INK" AND          ';
    strSQL := strSQL + '      CFG_CODCFG = "APREVE" AND       ';
    strSQL := strSQL + '      CFG_CODEMP = "' + VS_strCodEmp + '"   ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    If Not fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := (fStrToFloat(qryGen.FieldByName('CFG_VALCFG').AsString)) / 100.0;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosResicolor.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'RSI_QTDB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosResicolor.fRetValorAcrMob(
  qryGen: TUniQuery; fltQuantidade: Double): Double;
begin
  If fltQuantidade <= 0 Then
    Exit(0);

  If strAcrMob = '1' Then
    Result := (1 + qryGen.FieldByName('RSI_ACRMOB').AsFloat / 100)
  Else
    Result := qryGen.FieldByName('RSI_ACRMOB').AsFloat;
end;

function TExportaTintometricosTerceirosResicolor.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "RSI" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosResicolor.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO     ' + fNomeTabela + ' (   ';
  Result := Result + '    RSI_BASE__,     ';
  Result := Result + '    RSI_PROKEY,     ';
  Result := Result + '    RSI_SUBKEY,     ';
  Result := Result + '    RSI_UNIDAD,     ';
  Result := Result + '    RSI_DESCRI,     ';
  Result := Result + '    RSI_CODIGO,     ';
  Result := Result + '    RSI_CODIG2,     ';
  Result := Result + '    RSI_CODITE,     ';
  Result := Result + '    RSI_DESITE,     ';
  Result := Result + '    RSI_REFERE,     ';
  Result := Result + '    RSI_MD5KEY,     ';
  Result := Result + '    RSI_PREVEN,     ';
  Result := Result + '    RSI_PRECUS,     ';
  Result := Result + '    RSI_PREVE1,     ';
  Result := Result + '    RSI_PREVE2,     ';
  Result := Result + '    RSI_PREVE3,     ';
  Result := Result + '    RSI_PREVE4,     ';
  Result := Result + '    RSI_PREVE5,     ';
  Result := Result + '    RSI_PREVE6,     ';
  Result := Result + '    RSI_PREVE7      ';
  Result := Result + '              )                           ';
  Result := Result + '  VALUES        (                         ';
  Result := Result + '    :BASE__,        ';
  Result := Result + '    :PROKEY,        ';
  Result := Result + '    :SUBKEY,        ';
  Result := Result + '    :UNIDAD,        ';
  Result := Result + '    :DESCRI,        ';
  Result := Result + '    :CODIGO,        ';
  Result := Result + '    :CODIG2,        ';
  Result := Result + '    :CODITE,        ';
  Result := Result + '    :DESITE,        ';
  Result := Result + '    :REFERE,        ';
  Result := Result + '    :MD5KEY,        ';
  Result := Result + '    :PREVEN,        ';
  Result := Result + '    :PRECUS,        ';
  Result := Result + '    :PREVE1,        ';
  Result := Result + '    :PREVE2,        ';
  Result := Result + '    :PREVE3,        ';
  Result := Result + '    :PREVE4,        ';
  Result := Result + '    :PREVE5,        ';
  Result := Result + '    :PREVE6,        ';
  Result := Result + '    :PREVE7         ';
  Result := Result + '              );                          ';
end;

procedure TExportaTintometricosTerceirosResicolor.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
begin
  DataSet.ParamByName('BASE__').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('RSI_BASE__').AsString);
  DataSet.ParamByName('PROKEY').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('RSI_PROKEY').AsString);
  DataSet.ParamByName('SUBKEY').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('RSI_SUBKEY').AsString);
  DataSet.ParamByName('UNIDAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('RSI_UNIDAD').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('RSI_DESCRI').AsString);
  DataSet.ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('RSI_CODIGO').AsString);
  DataSet.ParamByName('CODIG2').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('RSI_CODIG2').AsString);
  DataSet.ParamByName('CODITE').AsStrings[intParam] := qryTinta.FieldByName('ITE_CODITE').AsString;
  DataSet.ParamByName('DESITE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ITE_DESITE').AsString);
  DataSet.ParamByName('REFERE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ITE_REFERE').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('RSI_MD5KEY').AsString;
  DataSet.ParamByName('PRECUS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['precus'], 0);

  If strAcrMob = '1' Then
    DataSet.ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen * (1 + qryTinta.FieldByName('RSI_ACRMOB').AsFloat / 100)
  Else
    DataSet.ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen + qryTinta.FieldByName('RSI_ACRMOB').AsFloat;

  For intContador := 1 To 7 Do
  Begin
    If stlTabPre[intContador] <> 'S' Then
      DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0)
    Else
    Begin
      If strAcrMob = '1' Then
        DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] :=  IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) * (1 + qryTinta.FieldByName('RSI_ACRMOB').AsFloat / 100)
      Else
        DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) + qryTinta.FieldByName('RSI_ACRMOB').AsFloat;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosResicolor.pCarregarPrecosAdicionais(
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

procedure TExportaTintometricosTerceirosResicolor.pGravaTintometricoTabelasTerceirosPorTinta(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery;
  intParam: Integer);
begin
  pAdicionaParamentros(qryInsert, qryTinta, fltPreVen, intParam);
end;

procedure TExportaTintometricosTerceirosResicolor.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "RSI"     ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ExecSQL;

    strSQL := '';
    strSQL := strSQL + '  INSERT INTO LOGTIN_SIT (            ';
    strSQL := strSQL + '    LOG_IDEPRO,           ';
    strSQL := strSQL + '    LOG_DTAEXE,           ';
    strSQL := strSQL + '    LOG_HOREXE,           ';
    strSQL := strSQL + '    LOG_EXECUT            ';
    strSQL := strSQL + '              )                       ';
    strSQL := strSQL + '  VALUES        (                     ';
    strSQL := strSQL + '    "RSI",                ';
    strSQL := strSQL + '    :DTAEXE,              ';
    strSQL := strSQL + '    :HOREXE,              ';
    strSQL := strSQL + '    :EXECUT               ';
    strSQL := strSQL + '                );                    ';

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

procedure TExportaTintometricosTerceirosResicolor.pProcessaTabelaCores(
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

procedure TExportaTintometricosTerceirosResicolor.pSetaParametrosEspecificos(
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
