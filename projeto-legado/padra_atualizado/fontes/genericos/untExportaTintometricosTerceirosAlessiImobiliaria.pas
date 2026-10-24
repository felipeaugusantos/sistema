unit untExportaTintometricosTerceirosAlessiImobiliaria;

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
  TExportaTintometricosTerceirosAlessiImobiliaria = Class(TExportaTintometricosTerceirosImobiliaria)
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
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pRetornaQuantidadeFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pCarregarPrecosAdicionais(dicRetorno: TDicionario; qryColorantes: TUniQuery;
      qryBases: TUniQuery; fltPerAcr: Double); Override;

    procedure pGravaTintometricoTabelasTerceirosPorTinta(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); Override;

    procedure Execute; Override;
    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); Override;

    destructor Destroy; Override;
  End;

implementation

{ TExportaTintometricosTerceirosAlessiImobiliaria }

constructor TExportaTintometricosTerceirosAlessiImobiliaria.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited Create(pgbProgresso, strIdePro, blnAuto);
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosAlessiImobiliaria.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosAlessiImobiliaria.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    ALE_PRODUT,             ';
  Result := Result + '    ALE_CODIGO,             ';
  Result := Result + '    ALE_BASE__,             ';
  Result := Result + '    EMB_CODUNI,             ';
  Result := Result + '    ALE_EMBALA,             ';
  Result := Result + '    ALE_NOMCOR,             ';
  Result := Result + '    ALE_NOMLON,             ';
  Result := Result + '    BAS_CODITE,             ';
  Result := Result + '    ITE_DESITE,             ';
  Result := Result + '    ALE_DTACAD,             ';
  Result := Result + '    ALE_CODNFM,             ';
  Result := Result + '    ITE_CODITE,             ';
  Result := Result + '    ITE_REFERE,             ';
  Result := Result + '    ALE_COLECA,             ';
  Result := Result + '    ALE_ACRMOB,             ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    ALE_CODC' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    ALE_QTOZ' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    ALE_QSHO' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    ALE_MD5KEY              ';
  Result := Result + '  FROM                      ';
  Result := Result + '    ALE_CADALE              ';
  Result := Result + '  INNER JOIN ALE_CADBAS ON          ';
  Result := Result + '    ALE_PRODUT = BAS_PRODUT AND     ';
  Result := Result + '    ALE_BASE__ = BAS_BASE__ AND     ';
  Result := Result + '    ALE_EMBALA = BAS_EMBALA         ';
  Result := Result + '  INNER JOIN CADITE ON              ';
  Result := Result + '    BAS_CODITE = ITE_CODITE         ';
  Result := Result + '    AND ITE_ITEATI = "S"            ';
  Result := Result + '  INNER JOIN ALE_CADEMB ON          ';
  Result := Result + '    BAS_EMBALA = EMB_NOME__         ';
  Result := Result + '  INNER JOIN CADUNI ON              ';
  Result := Result + '    EMB_CODUNI = UNI_CODUNI         ';
  Result := Result + '  WHERE                             ';
  Result := Result + '    TRUE;                           ';
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE ' + fNomeTabela() + '  (       ';
  Result := Result + '    ALE_CODIGO VARCHAR(8) DEFAULT NULL,             ';
  Result := Result + '    ALE_BASE__ VARCHAR(10) DEFAULT NULL,            ';
  Result := Result + '    ALE_PRODUT VARCHAR(50) DEFAULT NULL,            ';
  Result := Result + '    ALE_CODUNI CHAR(2) DEFAULT NULL,                ';
  Result := Result + '    ALE_EMBALA VARCHAR(10) DEFAULT NULL,            ';
  Result := Result + '    ALE_NOMCOR VARCHAR(50) DEFAULT NULL,            ';
  Result := Result + '    ALE_NOMLON VARCHAR(50) DEFAULT NULL,            ';
  Result := Result + '    ALE_CODITE VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,             ';
  Result := Result + '    ALE_DESITE VARCHAR(70) DEFAULT NULL,            ';
  Result := Result + '    ALE_REFERE VARCHAR(20) DEFAULT NULL,            ';
  Result := Result + '    ALE_MD5KEY VARCHAR(32) DEFAULT NULL,            ';
  Result := Result + '    ALE_PREVEN DECIMAL(12,4) DEFAULT 0.0000,        ';
  Result := Result + '    ALE_PRECUS DECIMAL(12,4) DEFAULT 0.0000,        ';
  Result := Result + '    ALE_PREVE1 DECIMAL(12,4) DEFAULT 0.0000,        ';
  Result := Result + '    ALE_PREVE2 DECIMAL(12,4) DEFAULT 0.0000,        ';
  Result := Result + '    ALE_PREVE3 DECIMAL(12,4) DEFAULT 0.0000,        ';
  Result := Result + '    ALE_PREVE4 DECIMAL(12,4) DEFAULT 0.0000,        ';
  Result := Result + '    ALE_PREVE5 DECIMAL(12,4) DEFAULT 0.0000,        ';
  Result := Result + '    ALE_PREVE6 DECIMAL(12,4) DEFAULT 0.0000,        ';
  Result := Result + '    ALE_PREVE7 DECIMAL(12,4) DEFAULT 0.0000         ';
  Result := Result + '                  );                                ';
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fFatorTinta: Double;
begin
  Result := 1;
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('ALE_CODC' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('COL_CODCOL', qryGen.FieldByName('ALE_CODC' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fNomeTabela: String;
begin
  Result := 'ALE_CADALE_SIT';
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fRetDescricao: String;
begin
  Result := 'ALE_PRODUT';
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'ALE_CODC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fRetItemBase: String;
begin
  Result := 'BAS_CODITE';
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fRetMD5KEY: String;
begin
  Result := 'ALE_MD5KEY';
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    I.ITE_CODITE,           ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,    ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,   ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,   ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,   ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,   ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,   ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,   ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,   ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7    ';
  Result := Result + '  FROM                      ';
  Result := Result + '    ALE_CADBAS B            ';
  Result := Result + '  INNER JOIN CADITE I ON    ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE     ';
  Result := Result + '  INNER JOIN ITEGER G ON    ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE     ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fRetornaColorantes: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    COL_CODCOL,               ';
  Result := Result + '    COL_CODITE,               ';
  Result := Result + '    COL_EMBALA,               ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,    ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,     ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,     ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,     ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,     ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,     ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,     ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,     ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7      ';
  Result := Result + '  FROM                        ';
  Result := Result + '    ALE_CADCOL                ';
  Result := Result + '  INNER JOIN ITEGER G ON      ';
  Result := Result + '    G.ITE_CODITE = COL_CODITE     ';
  Result := Result + '  INNER JOIN CADITE I ON      ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE   ';
  Result := Result + '  WHERE                       ';
  Result := Result + '    G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '  AND I.ITE_ITEATI = "S"          ';
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('    SELECT  CFG_VALCFG          ');
    qryGen.SQL.Add('      FROM CFGTIN               ');
    qryGen.SQL.Add('    WHERE CFG_IDEPRO = "ALE"  AND   ');
    qryGen.SQL.Add('          CFG_CODCFG = "APREVE" AND ');
    qryGen.SQL.Add('          CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    If fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := 0
    Else
      Result := fStrToFloat(qryGen.FieldByName('CFG_VALCFG').AsString);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fRetValorAcrMob(
  qryGen: TUniQuery; fltQuantidade: Double): Double;
begin
  If fltQuantidade <= 0 Then
    Exit(0);

  If strAcrMob = '1' Then
    Result := (1 + qryGen.FieldByName('ALE_ACRMOB').AsFloat / 100)
  Else
    Result := qryGen.FieldByName('ALE_ACRMOB').AsFloat;
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "ALE" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosAlessiImobiliaria.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO ' + fNomeTabela() + '   (   ';
  Result := Result + '    ALE_CODIGO,                   ';
  Result := Result + '    ALE_BASE__,                   ';
  Result := Result + '    ALE_PRODUT,                   ';
  Result := Result + '    ALE_CODUNI,                   ';
  Result := Result + '    ALE_EMBALA,                   ';
  Result := Result + '    ALE_NOMCOR,                   ';
  Result := Result + '    ALE_NOMLON,                   ';
  Result := Result + '    ALE_CODITE,                   ';
  Result := Result + '    ALE_DESITE,                   ';
  Result := Result + '    ALE_REFERE,                   ';
  Result := Result + '    ALE_MD5KEY,                   ';
  Result := Result + '    ALE_PREVEN,                   ';
  Result := Result + '    ALE_PRECUS,                   ';
  Result := Result + '    ALE_PREVE1,                   ';
  Result := Result + '    ALE_PREVE2,                   ';
  Result := Result + '    ALE_PREVE3,                   ';
  Result := Result + '    ALE_PREVE4,                   ';
  Result := Result + '    ALE_PREVE5,                   ';
  Result := Result + '    ALE_PREVE6,                   ';
  Result := Result + '    ALE_PREVE7                    ';
  Result := Result + '        )                         ';
  Result := Result + '  VALUES  ' + '       (           ';
  Result := Result + '    :CODIGO,                      ';
  Result := Result + '    :BASE__,                      ';
  Result := Result + '    :PRODUT,                      ';
  Result := Result + '    :CODUNI,                      ';
  Result := Result + '    :EMBALA,                      ';
  Result := Result + '    :NOMCOR,                      ';
  Result := Result + '    :NOMLON,                      ';
  Result := Result + '    :CODITE,                      ';
  Result := Result + '    :DESITE,                      ';
  Result := Result + '    :REFERE,                      ';
  Result := Result + '    :MD5KEY,                      ';
  Result := Result + '    :PREVEN,                      ';
  Result := Result + '    :PRECUS,                      ';
  Result := Result + '    :PREVE1,                      ';
  Result := Result + '    :PREVE2,                      ';
  Result := Result + '    :PREVE3,                      ';
  Result := Result + '    :PREVE4,                      ';
  Result := Result + '    :PREVE5,                      ';
  Result := Result + '    :PREVE6,                      ';
  Result := Result + '    :PREVE7                       ';
  Result := Result + '              );                  ';
end;

procedure TExportaTintometricosTerceirosAlessiImobiliaria.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
var
  intContador: Integer;
begin
  DataSet.ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ALE_CODIGO').AsString);
  DataSet.ParamByName('BASE__').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ALE_BASE__').AsString);
  DataSet.ParamByName('PRODUT').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ALE_PRODUT').AsString);
  DataSet.ParamByName('CODUNI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('EMB_CODUNI').AsString);
  DataSet.ParamByName('EMBALA').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ALE_EMBALA').AsString);
  DataSet.ParamByName('NOMCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ALE_NOMCOR').AsString);
  DataSet.ParamByName('NOMLON').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ALE_NOMLON').AsString);
  DataSet.ParamByName('CODITE').AsStrings[intParam] := qryTinta.FieldByName('ITE_CODITE').AsString;
  DataSet.ParamByName('DESITE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ITE_DESITE').AsString);
  DataSet.ParamByName('REFERE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ITE_REFERE').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('ALE_MD5KEY').AsString;
  DataSet.ParamByName('PRECUS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['precus'], 0.0);

  If strAcrMob = '1' Then
    DataSet.ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen * (1 + qryTinta.FieldByName('ALE_ACRMOB').AsFloat / 100)
  Else
    DataSet.ParamByName('PREVEN').AsFloats[intParam]  := fltPreVen + qryTinta.FieldByName('ALE_ACRMOB').AsFloat;

  DataSet.ParamByName('PRECUS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['precus'], 0);

  For intContador := 1 To 7 Do
  Begin
    If stlTabPre[intContador] <> 'S' Then
      DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0)
    Else
    Begin
      If strAcrMob = '1' Then
        DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] :=  IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) * (1 + qryTinta.FieldByName('ALE_ACRMOB').AsFloat / 100)
      Else
        DataSet.ParamByName('PREVE' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['preve' + IntToStr(intContador)], 0) + qryTinta.FieldByName('ALE_ACRMOB').AsFloat;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosAlessiImobiliaria.pCarregarPrecosAdicionais(
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

procedure TExportaTintometricosTerceirosAlessiImobiliaria.pGravaTintometricoTabelasTerceirosPorTinta(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery;
  intParam: Integer);
begin
  pAdicionaParamentros(qryInsert, qryTinta, fltPreVen, intParam);
end;

procedure TExportaTintometricosTerceirosAlessiImobiliaria.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('    DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "ALE"   ');
    qryGen.ExecSQL;

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  INSERT INTO LOGTIN_SIT(LOG_IDEPRO, LOG_DTAEXE, LOG_HOREXE, LOG_EXECUT)  ');
    qryGen.SQL.Add('    VALUES ("ALE", :DTAEXE, :HOREXE, :EXECUT)     ');
    qryGen.ParamByName('DTAEXE').AsDateTime := Vs_Date;
    qryGen.ParamByName('HOREXE').AsDateTime := Time;
    qryGen.ParamByName('EXECUT').AsString   := strStatus;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosAlessiImobiliaria.pProcessaTabelaCores(
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

procedure TExportaTintometricosTerceirosAlessiImobiliaria.pRetornaQuantidadeFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
var
  intContador: Integer;
begin
  For intContador := 1 To fQuantidadeFormulacao Do
  Begin
    If fEmptyStr(qryGen.FieldByName(fRetFormula(intContador)).AsString) Then
      Break;

    dicRetorno['base' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetFormula(intContador)).AsString;
    dicRetorno['qtdb' + fStrZero(intContador, 2)] := ((qryGen.FieldByName('ALE_QTOZ' + fStrZero(intContador, 2)).AsFloat * 29.574) +
      (qryGen.FieldByName('ALE_QSHO'+ fStrZero(intContador, 2)).AsFloat * 0.616125) * fFatorTinta);
  End;
end;

procedure TExportaTintometricosTerceirosAlessiImobiliaria.pSetaParametrosEspecificos(
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
