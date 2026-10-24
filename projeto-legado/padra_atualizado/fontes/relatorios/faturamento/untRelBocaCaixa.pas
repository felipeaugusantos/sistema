{*************************************************}
{* CLASSE PARA BOCA DE CAIXA                     *}
{* (MANUTENÇÃO / RELATORIO)                      *}
{*                                               *}
{* DATA......: 19/05/2008                        *}
{* AUTOR.....: LUCIENE                           *}
{*                                               *}
{**********************************************LU*}
unit untRelBocaCaixa;

interface

uses Classes, DB, Uni;

Type
  TBcaCai = Class(TComponent)
  Private
    FqryBcaCai: TUniQuery;
    FCodVen: String;
    FCodEmp: String;
    FCodIte: String;
    FCodFor: String;
    FCodUni: String;
    FDtaIni: String;
    FDtaFin: String;
    FCodGru: String;
    FDesIni: String;
    FDesFin: String;
    FRefere: String;
    FRefFin: String;
    FCodMar: String;
  Public

    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;

    property strCodEmp: String Read FCodEmp   Write FCodEmp;
    property strCodVen: String Read FCodVen   Write FCodVen;
    property strDtaIni: String Read FDtaIni   Write FDtaIni;
    property strDtaFin: String Read FDtaFin   Write FDtaFin;
    property strCodIte: String Read FCodIte   Write FCodIte;
    property strCodFor: String Read FCodFor   Write FCodFor;
    property strCodUni: String Read FCodUni   Write FCodUni;
    property strCodGru: String Read FCodGru   Write FCodGru;
    property strDesIni: String Read FDesIni   Write FDesIni;
    property strDesFin: String Read FDesFin   Write FDesFin;
    property strRefere: String Read FRefere   Write FRefere;
    property strRefFin: String Read FRefFin   Write FRefFin;
    property strCodMar: String Read FCodMar   Write FCodMar;

    procedure pGeraRelatorioComissaoVendedor(intOpcao, intTipRel: Integer; intOpcData : Integer = 0; intIntVen: Integer=0); // relatorio de boca de caixa por vendedor - comissao
    procedure pGeraRelatorioBocaCaixa(intOrdem: Integer);

    function getQryBcaCai: TUniQuery;
    procedure setQryBcaCai(Value: TUniQuery);
    function fStrTaxRep: String;

    property qryBcaCai: TUniQuery Read getQryBcaCai Write setQryBcaCai;

  End;

implementation

uses untFuncoesFactory, untIFuncoes, SysUtils, Forms, StrUtils;

{**************************************************************}
{* GERA O RELATÓRIO DE BOCA DE CAIXA - POR VENDEDOR - COMISSÃO*}
{***********************************************************LU*}
constructor TBcaCai.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  FqryBcaCai := fCriaQuery(Self);
end;

destructor TBcaCai.Destroy;
begin
  FreeAndNil(FqryBcaCai);

  inherited Destroy;
end;

function TBcaCai.fStrTaxRep: String;
begin
  Result := '';

  If fCfgSis('REPVEN', varBoolean) Then
    If fCfgSis('TAXREP', varDouble) <> 0.00 Then
      Result := '('+AnsiReplaceStr(FloatToStrF(fCfgSis('TAXREP', varDouble), ffFixed,12,2),',','.')+' / 100)';
end;

function TBcaCai.getQryBcaCai: TUniQuery;
begin
  Result := FqryBcaCai;
end;

procedure TBcaCai.pGeraRelatorioComissaoVendedor(intOpcao, intTipRel: Integer; intOpcData : Integer = 0; intIntVen: Integer=0);
  Var
    strSQL,
    strSQLGroup : String;

  function fSQLFator: String;
  begin
    Result := ' IF(LEFT(DET_CLAFIS,1)<5,-1,1) ';
  end;

  function fSQLTotIte: String;
  begin
    Result := ' (DET_TOTITE - DET_DESESP - DET_DESCFF) ';
  end;

  function fSQLTotCom: String;
  begin
    Result := '(DET_BCACOM * '+fSQLFator+')';
    If (fStrTaxRep <> '') Then
    Begin
      If intIntVen = 0 Then
        Result := ' IF(DET_CODVE2 IS NULL, ' + Result + ', ((' + Result + ') - (' + Result + ' * ' + fStrTaxRep + '))) '
      Else
        Result := ' IF(DET_CODVE2 IS NULL, 0, (' + Result + ' * ' + fStrTaxRep + ')) '
    End;
  end;

begin
  With qryBcaCai Do
  Begin
    Close;
    SQL.Clear;
  End;

  strSQL := '';

  Case intTipRel Of
  0:
    Begin
      strSQL := strSQL + ' SELECT SQL_NO_CACHE     ';
      strSQL := strSQL + '   OPE_CODOPE AS CODVEN, ';
      strSQL := strSQL + '   OPE_NOMOPE AS NOMVEN, ';
      strSQL := strSQL + '   DET_CODEMP AS CODEMP, ';
      strSQL := strSQL + '   DET_NUMDOC AS NRODOC, ';
      strSQL := strSQL + '   DET_ESPDOC AS ESPDOC, ';
      strSQL := strSQL + '   CONCAT(DET_NUMDOC,"-",DET_ESPDOC,"-",DET_CODEMP) AS NUMDOC, ';
      strSQL := strSQL + '   DET_DTAENT AS DTAENT, ';
      strSQL := strSQL + '   DET_DTABCA AS DTABCA, ';
      strSQL := strSQL + '   DET_CODITE AS CODITE, ';
      strSQL := strSQL + '   DET_DESCRI AS DESCRI, ';
      strSQL := strSQL + '   DET_REFERE AS REFERE, ';
      strSQL := strSQL + '   UNI_SIGUNI AS UNIDAD, ';
      strSQL := strSQL + '   (DET_QTDITE * '+fSQLFator+')                    AS QTDITE, ';
      strSQL := strSQL + '   (('+fSQLTotIte+' / DET_QTDITE) * '+fSQLFator+') AS VLRUNI, ';
      strSQL := strSQL + '   ('+fSQLTotIte+' * '+fSQLFator+')                AS VLRTOT, ';
      strSQL := strSQL + fSQLTotCom+'                                        AS VLRCOM  ';
    end;
  1:
    Begin
      strSQL := strSQL + ' SELECT SQL_NO_CACHE     ';
      strSQL := strSQL + '   OPE_CODOPE AS CODVEN, ';
      strSQL := strSQL + '   OPE_NOMOPE AS NOMVEN, ';
      strSQL := strSQL + '   SUM('+fSQLTotIte+' * '+fSQLFator+') AS VLRTOT, ';
      strSQL := strSQL + '   SUM('+fSQLTotCom+')                 AS VLRCOM  ';
    end;
  2:
    Begin
      strSQL := strSQL + ' SELECT SQL_NO_CACHE          ';
      strSQL := strSQL + '   OPE_CODOPE AS CODVEN,      ';
      strSQL := strSQL + '   OPE_NOMOPE AS NOMVEN,      ';
      strSQL := strSQL + '   ITE_CODMAR AS CODMAR,      ';
      strSQL := strSQL + '   MAR_DESMAR AS DESMAR,      ';
      strSQL := strSQL + '   SUM(DET_QTDITE * '+fSQLFator+')     AS QTDITE, ';
      strSQL := strSQL + '   SUM('+fSQLTotIte+' * '+fSQLFator+') AS VLRTOT, ';
      strSQL := strSQL + '   SUM('+fSQLTotCom+')                 AS VLRCOM  ';
    end;
  End;

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   MOVDET ';
  strSQL := strSQL + '   JOIN CADUNI ON (DET_UNIDAD = UNI_CODUNI) ';
  strSQL := strSQL + '   JOIN CADITE ON (ITE_CODITE = DET_CODITE) ';
  Case intIntVen Of
    0: strSQL := strSQL + '  JOIN CADOPE ON (DET_CODVEN = OPE_CODOPE) ';
    1: strSQL := strSQL + '  JOIN CADOPE ON (DET_CODVE2 = OPE_CODOPE) ';
  End;

  If (intTipRel = 2) Then
    strSQL := strSQL + ' JOIN CADMAR ON (MAR_CODMAR = ITE_CODMAR) ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   (DET_BCACOM <> 0)                          AND ';
  strSQL := strSQL + '   (DET_CODCLI NOT IN (' + VS_strCliFil + ')) AND ';
  strSQL := strSQL + '   (LOCATE(DET_CLAFIS, ' + QuotedStr(fCfgSis('CLAVEN')) + ') > 0) ';

  { FILTRA POR DTAENT OU DTABCA ***RL***}
  if (Not fEmptyStr(fTiraCaracEspeciais(FDtaIni))) and (Not fEmptyStr(fTiraCaracEspeciais(FDtaFin))) then
    case intOpcData of
      0 : strSQL := strSQL + ' AND (DET_DTAENT BETWEEN :DTAINI AND :DTAFIN) ';
      1 : strSQL := strSQL + ' AND (DET_DTABCA BETWEEN :DTAINI AND :DTAFIN) ';
    end;

  If Not fEmptyStr(strCodEmp) Then
    strSQL := strSQL + '   AND DET_CODEMP = :CODEMP '
  Else
    strSQL := strSQL + '   AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If Not fEmptyStr(strCodVen) Then
    strSQL := strSQL + '   AND OPE_CODOPE = :CODVEN ';

  If Not fEmptyStr(strCodIte) Then
    strSQL := strSQL + '   AND DET_CODITE = :CODITE ';

  If Not fEmptyStr(strCodUni) Then
    strSQL := strSQL + '   AND ITE_CODUNI = :UNIDAD ';

  If Not fEmptyStr(strCodFor) Then
    strSQL := strSQL + '   AND ITE_CODFOR = :CODFOR ';

  Case intOpcao Of
    1: strSQL := strSQL + ' AND DET_DTABCA IS NOT NULL ';
    2: strSQL := strSQL + ' AND DET_DTABCA IS NULL ';
    3: strSQL := strSQL + ' ';
  End;

  If (intTipRel = 1) Then
    strSQL := strSQL + ' GROUP BY CODVEN '
  Else If (intTipRel = 2) Then
    strSQL := strSQL + ' GROUP BY CODVEN, CODMAR ';

  Case intTipRel Of
    0:
      strSQL := strSQL + ' ORDER BY CODVEN, NRODOC, CODITE ';
    1:
      Begin
        strSQLGroup := '';
        strSQLGroup := strSQLGroup + 'SELECT SQL_NO_CACHE        ';
        strSQLGroup := strSQLGroup + '  CODVEN,                  ';
        strSQLGroup := strSQLGroup + '  NOMVEN,                  ';
        strSQLGroup := strSQLGroup + '  SUM(VLRTOT) AS VLRTOT,   ';
        strSQLGroup := strSQLGroup + '  SUM(VLRCOM) AS VLRCOM    ';
        strSQLGroup := strSQLGroup + 'FROM (' + strSQL + ') AS VW ';
        strSQLGroup := strSQLGroup + 'GROUP BY CODVEN            ';
        strSQLGroup := strSQLGroup + 'ORDER BY CODVEN            ';
        strSQL      := strSQLGroup;
      End;
    2:
      Begin
        strSQLGroup := '';
        strSQLGroup := strSQLGroup + 'SELECT SQL_NO_CACHE        ';
        strSQLGroup := strSQLGroup + '  CODVEN,                  ';
        strSQLGroup := strSQLGroup + '  NOMVEN,                  ';
        strSQLGroup := strSQLGroup + '  CODMAR,                  ';
        strSQLGroup := strSQLGroup + '  DESMAR,                  ';
        strSQLGroup := strSQLGroup + '  SUM(QTDITE) AS QTDITE,   ';
        strSQLGroup := strSQLGroup + '  SUM(VLRTOT) AS VLRTOT,   ';
        strSQLGroup := strSQLGroup + '  SUM(VLRCOM) AS VLRCOM    ';
        strSQLGroup := strSQLGroup + 'FROM (' + strSQL + ') AS VW ';
        strSQLGroup := strSQLGroup + 'GROUP BY CODVEN, CODMAR    ';
        strSQLGroup := strSQLGroup + 'ORDER BY CODVEN, CODMAR    ';
        strSQL      := strSQLGroup;
      End;
  End;

  With qryBcaCai Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    if (Not fEmptyStr(fTiraCaracEspeciais(FDtaIni))) and (Not fEmptyStr(fTiraCaracEspeciais(FDtaFin))) then
    begin
      ParamByName('DTAINI').AsDate   := StrToDate(FDtaIni);
      ParamByName('DTAFIN').AsDate   := StrToDate(FDtaFin);
    end;

    If Not fEmptyStr(strCodEmp) Then
      ParamByName('CODEMP').AsString := FCodEmp;

    If Not fEmptyStr(strCodVen) Then
      ParamByName('CODVEN').AsString := FCodVen;

    If Not fEmptyStr(strCodIte) Then
      ParamByName('CODITE').AsString := FCodIte;

    If Not fEmptyStr(strCodUni) Then
      ParamByName('UNIDAD').AsString := FCodUni;

    If Not fEmptyStr(strCodFor) Then
      ParamByName('CODFOR').AsString := FCodFor;

    Open;

    If IsEmpty Then
      Raise Exception.Create('Não há dados para gerar relatório!');

  End;

end;


procedure TBcaCai.pGeraRelatorioBocaCaixa(intOrdem: Integer);
Var
  strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  LEFT(ITE_CODGRU,3) AS LINHA, ';
  strSQL := strSQL + '  LEFT(I.ITE_CODGRU,3) AS LINHA, ';
  strSQL := strSQL + '  CONCAT(LEFT(I.ITE_CODGRU,3), ".", RIGHT(I.ITE_CODGRU,3)) AS CODGRU, ';
  strSQL := strSQL + '  B.BCA_CODITE AS CODITE, ';
  strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '  U.UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '  B.BCA_PREMIN AS PREMIN, ';
  strSQL := strSQL + '  B.BCA_COMVAR AS COMVAR, ';
  strSQL := strSQL + '  B.BCA_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  G.ITE_SALDOS AS SALDOS, ';
  strSQL := strSQL + '  G.ITE_PRECUS AS PRECUS, ';
  strSQL := strSQL + '  G.ITE_PREVE1 AS PREVEN, ';
  strSQL := strSQL + '  G.ITE_MARBR1 AS MARBRU, ';
  strSQL := strSQL + '  CONCAT(B.BCA_CODEMP, "-", E.EMP_NOMEMP) AS NOMEMP ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADBCA B';
  strSQL := strSQL + '  JOIN CADITE I ON (B.BCA_CODITE=I.ITE_CODITE) ';
  strSQL := strSQL + '  JOIN CADUNI U ON (I.ITE_CODUNI=U.UNI_CODUNI) ';
  strSQL := strSQL + '  JOIN CADEMP E ON (B.BCA_CODEMP=E.EMP_CODEMP) ';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND G.ITE_CODEMP = B.BCA_CODEMP ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRUE ';

  If Not fEmptyStr(strCodGru) Then
  Begin
    If RightStr(strCodGru,3) = '000' Then
      strSQL := strSQL + '  AND LEFT(I.ITE_CODGRU,3) = LEFT(:CODGRU,3) '
    Else
      strSQL := strSQL + '  AND I.ITE_CODGRU = :CODGRU ';
  End;

  If Not fEmptyStr(strCodEmp) Then
    strSQL := strSQL + '  AND B.BCA_CODEMP = :CODEMP '
  Else
    strSQL := strSQL + '  AND LOCATE(B.BCA_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If Not fEmptyStr(strCodFor) Then
    strSQL := strSQL + '  AND I.ITE_CODFOR = :CODFOR ';

  If Not fEmptyStr(strCodMar) Then
    strSQL := strSQL + '  AND I.ITE_CODMAR = :CODMAR ';

  If Not fEmptyStr(strDesIni) Then
  Begin
    If (Not fEmptyStr(strDesFin)) Then
      strSQL := strSQL + ' AND LEFT(I.ITE_DESITE, LENGTH(:MAIORDES)) BETWEEN :DESITE AND :DESFIN '
    Else
      strSQL := strSQL + '  AND I.ITE_DESITE LIKE :DESITE ';
  End;

  If Not fEmptyStr(strRefere) Then
  Begin
    If (Not fEmptyStr(strRefFin)) Then
      strSQL := strSQL + ' AND LEFT(I.ITE_REFERE, LENGTH(:MAIORREF)) BETWEEN :REFERE AND :REFFIN '
    Else
      strSQL := strSQL + '  AND I.ITE_REFERE LIKE :REFERE ';
  End;

  strSQL := strSQL + ' ORDER BY ';

  Case intOrdem Of
    1: strSQL := strSQL + ' CODEMP, DESITE ';
    2: strSQL := strSQL + ' CODEMP, LINHA, CODGRU, CODITE, DESITE ';
  End;

  With qryBcaCai Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(strCodEmp) Then
      ParamByName('CODEMP').AsString := FCodEmp;

    If Not fEmptyStr(strCodGru) Then
      ParamByName('CODGRU').AsString := FCodGru;

    If Not fEmptyStr(strCodFor) Then
      ParamByName('CODFOR').AsString := FCodFor;

    If Not fEmptyStr(strCodMar) Then
      ParamByName('CODMAR').AsString := FCodMar;

    If Not fEmptyStr(strDesIni) Then
    Begin
      If (Not fEmptyStr(strDesFin)) Then
      Begin
        ParamByName('DESITE').AsString := strDesIni;
        ParamByName('DESFIN').AsString := strDesFin;

        If Length(strDesIni) > Length(strDesFin) Then
          ParamByName('MAIORDES').AsString := strDesIni
        Else
          ParamByName('MAIORDES').AsString := strDesFin;

      End
      Else
        ParamByName('DESITE').AsString := strDesIni + '%';
    End;

    If Not fEmptyStr(strRefere) Then
    Begin
      If (Not fEmptyStr(strRefFin)) Then
      Begin
        ParamByName('REFERE').AsString := strRefere;
        ParamByName('REFFIN').AsString := strRefFin;

        If Length(strRefere) > Length(strRefFin) Then
          ParamByName('MAIORREF').AsString := strRefere
        Else
          ParamByName('MAIORREF').AsString := strRefFin;

      End
      Else
        ParamByName('REFERE').AsString := strRefere + '%';
    End;

    Open;

    If IsEmpty Then
      Raise Exception.Create('Não há dados para gerar relatório!');

  End;

end;


procedure TBcaCai.setQryBcaCai(Value: TUniQuery);
begin
  FqryBcaCai := Value;
end;

end.
