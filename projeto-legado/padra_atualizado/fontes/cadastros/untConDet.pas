unit untConDet;

interface

uses SysUtils, Classes, Uni, untTypesSistema;

Type
  TConDet = Class(TComponent)
  Private
    FNomFor,
    FCodIte,
    FCodEmp,
    FNumLot,
    FDigCon : String;

    FSalCon,
    FGmlCon : Double;

    FDigConOld : String;
    FSalConOld,
    FGmlConOld : Double;
    FCodOpe : String;


    function fSQLInsertItens(strFiltros, strDigCon, strLeftJoin: String; blnControlaContagem: Boolean): String;
    function fSQLInsertItensCount(strFiltros, strDigCon, strLeftJoin: String; blnControlaContagem: Boolean): String;
    function fGravaConDet(blnAcumul : Boolean; strAutInc: String; AblnBalancoEstoqueImportar: Boolean = False):Boolean; overload;
    procedure pSetValoresAntigos;
    function fInserirRegistro(strAutInc: String): Boolean;
  Public
    Constructor Create(AOwner: TComponent ); override;
    Class function fGravaConDetZeraContagem(strCodite: string; AOwner: TComponent; strDigCon: string; strCodEmp, strFltFiltro: string; event_Parametros: TSetaParametros;  strArmazens: string): boolean;
    Class function fGravaConDetZeraContagemLote(strCodite: string; AOwner: TComponent; strDigCon: string; strCodEmp, strFltFiltro: string; event_Parametros: TSetaParametros;  strArmazens: string): boolean;   {Req. 456948-B - B8: blnUsaTemporaria removido}
    {Req. 456948-B - B3/B2. Versoes set-based, dirigidas por BALZER: uma passada
     para a rodada inteira no lugar de uma chamada por linha contada.}
    Class function fGravaConDetZeraItensRodada(AOwner: TComponent; const AstrConId, AstrCodCon, AstrCodEmp: String): Boolean;
    Class function fGravaConDetZeraLotesRodada(AOwner: TComponent; const AstrConId, AstrCodCon, AstrCodEmp: String): Boolean;

    Class function fGravaConDet( blnConAcu: Boolean;
                                 AOwner: TComponent;
                                 strCodIte,
                                 strCodEmp,
                                 strNumLot,
                                 strDigCon,
                                 strAutInc : String;
                                 fltSalCon,
                                 fltGmlCon : Double;
                                 blnAcumul : Boolean = False;
                                 blnBalancoEstoqueImportar: Boolean = False;
                                 strCodOpe : String = ''): Boolean; overload;

    class function fGravaConDetItens(AOwner: TComponent; strSQLFiltro, strCodEmp, strDigCon: String;
                                     pSetaParametros: TSetaParametros; strLeftJoin: String = ''; blnLimpaContagem: Boolean = False; strCodOpe : String = ''): Boolean;
  End;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core;
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untFuncoesGenerica,
  untConstantes;

{ TConDet }

constructor TConDet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

class function TConDet.fGravaConDet(blnConAcu: Boolean; AOwner: TComponent; strCodIte, strCodEmp, strNumLot,
  strDigCon, strAutInc: String; fltSalCon, fltGmlCon: Double; blnAcumul : Boolean = False; blnBalancoEstoqueImportar: Boolean = False;
  strCodOpe : String = ''): Boolean;
  Var
    objConDet : TConDet ;
begin
  objConDet := TConDet.Create(AOwner);  
  try
    with objConDet Do
    Begin
      FNomFor := Owner.Name;
      If fEmptyStr(FNomFor) Then
        FNomFor := Owner.ClassName;

      FCodIte := strCodIte;
      FCodEmp := strCodEmp;
      FNumLot := strNumLot;
      FDigCon := strDigCon;

      FSalCon := fltSalCon;
      FGmlCon := fltGmlCon;
      FCodOpe := IIF(fEmptyStr(strCodOpe), strLoginUsuarioLogado, strCodOpe);

      Result := fGravaConDet(blnAcumul And blnConAcu, strAutInc, blnBalancoEstoqueImportar);
    End;
  finally
    FreeAndNil(objConDet);
  end;
end;

function TConDet.fSQLInsertItens(strFiltros, strDigCon, strLeftJoin: String; blnControlaContagem: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'INSERT INTO CONDET (AUTOINCREM,';
  strSQL := strSQL + '                    DET_DTACAD,';
  strSQL := strSQL + '                    DET_HRACAD,';
  strSQL := strSQL + '                    DET_CODOPE,';
  strSQL := strSQL + '                    DET_NOMFRM,';
  strSQL := strSQL + '                    DET_CODITE,';
  strSQL := strSQL + '                    DET_CODEMP,';
  strSQL := strSQL + '                    DET_NUMLOT,';
  strSQL := strSQL + '                    DET_SALOLD,';
  strSQL := strSQL + '                    DET_GMLOLD,';
  strSQL := strSQL + '                    DET_DIGOLD,';
  strSQL := strSQL + '                    DET_SALNEW,';
  strSQL := strSQL + '                    DET_GMLNEW,';
  strSQL := strSQL + '                    DET_DIGNEW,';
  strSQL := strSQL + '                    DET_SALDOS,';
  strSQL := strSQL + '                    DET_QTEF_A,';
  strSQL := strSQL + '                    DET_QTEF_F,';
  strSQL := strSQL + '                    DET_QTEF_P,';
  strSQL := strSQL + '                    DET_SALFIS)';
  strSQL := strSQL + '  SELECT';
  strSQL := strSQL + '    CONCAT(:CODEMP, RIGHT(CONCAT("00000000000000", @AUTINC:=(@AUTINC+1)), 14), :CODEMP), ';
  strSQL := strSQL + '    :DTACAD, ';
  strSQL := strSQL + '    :HRACAD, ';
  strSQL := strSQL + '    :CODOPE, ';
  strSQL := strSQL + '    :NOMFRM, ';
  strSQL := strSQL + '    G.ITE_CODITE, ';
  strSQL := strSQL + '    G.ITE_CODEMP, ';
  strSQL := strSQL + '    "", ';
  strSQL := strSQL + '    G.ITE_SALCON, ';
  strSQL := strSQL + '    G.ITE_GMLCON, ';
  strSQL := strSQL + '    G.ITE_DIGCON, ';
  strSQL := strSQL + '    0, ';
  strSQL := strSQL + '    0, ';
  strSQL := strSQL + '    :DIGCON, ';
  strSQL := strSQL + '    ITE_SALDOS , ';
  strSQL := strSQL + '    ITE_QTEF_A, ';
  strSQL := strSQL + '    ITE_QTEF_F, ';
  strSQL := strSQL + '    ITE_QTEF_P, ';
  strSQL := strSQL + '    IFNULL(ITE_SALDOS, 0) + IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_F, 0) + IFNULL(ITE_QTEF_P, 0) ';
  strSQL := strSQL + '  FROM          ';
  strSQL := strSQL + '    ITEGER G    ';
  strSQL := strSQL + '  JOIN CADITE I ON G.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + strLeftJoin;
  If blnControlaContagem Then
  Begin
    strSQL := strSQL + '    LEFT JOIN BALDET ON BALDET.BLD_CODITE = G.ITE_CODITE ';
    strSQL := strSQL + '    INNER JOIN BALGER ON BALGER.AUTOINCREM = BALDET.BLD_SEQGER AND BLG_CODEMP = G.ITE_CODEMP ';
  End;
  strSQL := strSQL + '  WHERE         ';
  strSQL := strSQL + ' 	 G.ITE_DIGCON = ' + IIF(strDigCon = 'S', '"N"', '"S"') + ' AND  ';
  strSQL := strSQL + '   G.ITE_CODEMP = :CODEMP ';
  strSQL := strSQL +    strFiltros;
  If blnControlaContagem Then
     strSQL := strSQL + ' GROUP BY G.ITE_CODITE ';

  Result := strSQL;
End;


function TConDet.fSQLInsertItensCount(strFiltros, strDigCon, strLeftJoin: String; blnControlaContagem: Boolean): String;
var
  strSQL: string;
  strInner: string;
begin
  if blnControlaContagem then
  begin
    // Com GROUP BY, a query interna retorna N linhas (uma por ITE_CODITE).
    // Envolve em subquery para obter o total real de linhas que serão inseridas.
    strInner := '  SELECT G.ITE_CODITE ';
    strInner := strInner + '  FROM ITEGER G ';
    strInner := strInner + '  JOIN CADITE I ON G.ITE_CODITE = I.ITE_CODITE ';
    strInner := strInner + strLeftJoin;
    strInner := strInner + '  LEFT JOIN BALDET ON BALDET.BLD_CODITE = G.ITE_CODITE ';
    strInner := strInner + '  INNER JOIN BALGER ON BALGER.AUTOINCREM = BALDET.BLD_SEQGER AND BLG_CODEMP = G.ITE_CODEMP ';
    strInner := strInner + '  WHERE ';
    strInner := strInner + '    G.ITE_DIGCON = ' + IIF(strDigCon = 'S', '"N"', '"S"') + ' AND ';
    strInner := strInner + '    G.ITE_CODEMP = :CODEMP ';
    strInner := strInner + strFiltros;
    strInner := strInner + '  GROUP BY G.ITE_CODITE ';

    strSQL := 'SELECT COUNT(*) AS QTD FROM (' + strInner + ') sub';
  end
  else
  begin
    strSQL := '  SELECT COUNT(1) AS QTD ';
    strSQL := strSQL + '  FROM ITEGER G ';
    strSQL := strSQL + '  JOIN CADITE I ON G.ITE_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + strLeftJoin;
    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '    G.ITE_DIGCON = ' + IIF(strDigCon = 'S', '"N"', '"S"') + ' AND ';
    strSQL := strSQL + '    G.ITE_CODEMP = :CODEMP ';
    strSQL := strSQL + strFiltros;
  end;

  Result := strSQL;
end;

class function TConDet.fGravaConDetItens(AOwner: TComponent; strSQLFiltro, strCodEmp, strDigCon: String;
                                         pSetaParametros: TSetaParametros; strLeftJoin: String = ''; blnLimpaContagem: Boolean = False; strCodOpe : String = ''): Boolean;
  Var
    objConDet : TConDet;
    qryInsert: TUniQuery;
    qryCount: TUniQuery;
    intQtdCondet: integer;
    strAutInc: string;
begin
  objConDet := Nil;
  Try
    objConDet := TConDet.Create(AOwner);
    try
      with objConDet Do
      Begin
        FNomFor := Owner.Name;
        If fEmptyStr(FNomFor) Then
          FNomFor := Owner.ClassName;
        FCodOpe := IIF(fEmptyStr(strCodOpe), strLoginUsuarioLogado, strCodOpe);

        qryCount := fCriaQuery;
        Try
          qryCount.SQL.Text := fSQLInsertItensCount(strSQLFiltro, strDigCon, strLeftJoin, blnLimpaContagem);
          If Assigned(pSetaParametros) Then
            pSetaParametros(qryCount)
          Else
            qryCount.ParamByName('CODEMP').AsString   := VS_StrCodEmp;

          qryCount.Open;
          intQtdCondet := qryCount.FieldByName('QTD').AsInteger;
        finally
          FreeAndNil(qryCount);
        end;

        If intQtdCondet > 0 then
        begin
          {Req. 456948 - achado DelphAI 2026-08-31. Reservava intQtdCondet+1
           mas o SQL abaixo nao tinha o "- 1" que as demais funcoes deste
           mesmo commit usam (fGravaConDetZeraItensRodada/ZeraLotesRodada/
           ZeraContagem/ZeraContagemLote) - o INSERT ja incrementa antes de
           usar (@AUTINC := @AUTINC + 1). Sem o "- 1", o primeiro valor
           reservado (strAutInc) nunca era gravado: buraco permanente na
           sequencia de CONDET.AUTOINCREM a cada chamada.}
          strAutInc := fRetAutoIncrem('CONDET', VS_StrCodEmp, intQtdCondet);


          qryInsert := fCriaQuery;
          try
            qryInsert.SQL.Text := 'SET @AUTINC =  CAST(SUBSTRING("'+strAutInc+'", 4, 14) AS UNSIGNED) - 1;';
            qryInsert.ExecSQL;
            qryInsert.SQL.Clear;

            qryInsert.Close;
            qryInsert.SQL.Text := fSQLInsertItens(strSQLFiltro, strDigCon, strLeftJoin, blnLimpaContagem);
            qryInsert.ParamByName('DIGCON').AsString   := strDigCon;
            qryInsert.ParamByName('DTACAD').AsDateTime := VS_Date;
            qryInsert.ParamByName('HRACAD').AsDateTime := fTime();
            qryInsert.ParamByName('CODOPE').AsString   := FCodOpe;
            qryInsert.ParamByName('NOMFRM').AsString   := FNomFor;
            If Assigned(pSetaParametros) Then
              pSetaParametros(qryInsert)
            Else
              qryInsert.ParamByName('CODEMP').AsString   := VS_StrCodEmp;

            qryInsert.ExecSQL;
          finally
           FreeAndNil(qryInsert);
          end;
        end;
        Result := True;
      End;      
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TConDet.fGravaConDetItens]');   {Req. 456948 - achado DelphAI 2026-08-31, label divergia do nome real da funcao}
      End;
    End;
  finally
    FreeAndNil(objConDet);
  End;
end;

{Req. 456948-B - B2. CONDET de nivel de item, uma passada para a rodada.

 Substitui a Fase 0 de fZeraItens, que chamava fGravaConDet por item: cada
 chamada fazia um SELECT SQL_NO_CACHE em ITEGER (pSetValoresAntigos) e um
 INSERT ... SELECT (fInserirRegistro). Medido: 280 de cada numa rodada de 280
 linhas.

 O payload e copia fiel de fInserirRegistro com FNumLot vazio, FDigCon = "N",
 FSalCon = 0 e FGmlCon = 0 - que e exatamente como a Fase 0 chamava. O filtro
 de variacao (FSalConOld <> FSalCon Or FGmlConOld <> FGmlCon Or FDigConOld <>
 FDigCon) vira o WHERE sobre os valores atuais de ITEGER.

 TEM que rodar ANTES da Fase 1: e a Fase 1 que zera ITE_SALCON e ITE_DIGCON.}
class function TConDet.fGravaConDetZeraItensRodada(AOwner: TComponent;
  const AstrConId, AstrCodCon, AstrCodEmp: String): Boolean;
  Var
    qryAux  : TUniQuery;
    intQtd  : Integer;
    strAutInc: String;
    strNomFor: String;
begin
  Result := True;

  strNomFor := AOwner.Name;
  If fEmptyStr(strNomFor) Then
    strNomFor := AOwner.ClassName;

  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add(' SELECT COUNT(1) AS QTD                                   ');
    qryAux.SQL.Add('   FROM ITEGER G                                          ');
    qryAux.SQL.Add('  INNER JOIN (SELECT DISTINCT ZER_CODEMP, ZER_CODITE       ');
    qryAux.SQL.Add('                FROM BALZER                               ');
    qryAux.SQL.Add('               WHERE ZER_CON_ID = :CONID                  ');
    qryAux.SQL.Add('                 AND ZER_CODCON = :CODCON                 ');
    qryAux.SQL.Add('                 AND ZER_ORIGEM = "Z") Z                  ');
    qryAux.SQL.Add('     ON Z.ZER_CODEMP = G.ITE_CODEMP                       ');
    qryAux.SQL.Add('    AND Z.ZER_CODITE = G.ITE_CODITE                       ');
    qryAux.SQL.Add('  WHERE G.ITE_CODEMP = :CODEMP                            ');
    qryAux.SQL.Add('    AND (G.ITE_SALCON <> 0 OR G.ITE_GMLCON <> 0           ');
    qryAux.SQL.Add('         OR IFNULL(G.ITE_DIGCON, "") <> "N")              ');

    qryAux.ParamByName('CONID').AsString  := AstrConId;
    qryAux.ParamByName('CODCON').AsString := AstrCodCon;
    qryAux.ParamByName('CODEMP').AsString := AstrCodEmp;
    qryAux.Open;
    intQtd := qryAux.FieldByName('QTD').AsInteger;
    qryAux.Close;

    If intQtd = 0 Then
      Exit;

    strAutInc := fRetAutoIncrem('CONDET', AstrCodEmp, intQtd);

    qryAux.SQL.Clear;
    qryAux.SQL.Add('SET @AUTINC = CAST(SUBSTRING("'+strAutInc+'", 4, 14) AS UNSIGNED) - 1;');
    qryAux.SQL.Add('SET @EMPFIS = (SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = "MOVGER");');
    qryAux.SQL.Add(' INSERT INTO CONDET (AUTOINCREM, DET_DTACAD, DET_HRACAD,   ');
    qryAux.SQL.Add('        DET_CODOPE, DET_NOMFRM, DET_CODITE, DET_CODEMP,    ');
    qryAux.SQL.Add('        DET_NUMLOT, DET_SALOLD, DET_GMLOLD, DET_DIGOLD,    ');
    qryAux.SQL.Add('        DET_SALNEW, DET_GMLNEW, DET_DIGNEW, DET_SALDOS,    ');
    qryAux.SQL.Add('        DET_QTEF_A, DET_QTEF_F, DET_QTEF_P, DET_SALFIS)    ');
    qryAux.SQL.Add(' SELECT CONCAT(@EMPFIS, LPAD((@AUTINC := @AUTINC + 1), 14, 0), :CODEMP2), ');
    qryAux.SQL.Add('        :DTACAD, :HRACAD, :CODOPE, :NOMFRM,                ');
    qryAux.SQL.Add('        G.ITE_CODITE, G.ITE_CODEMP, NULL,                  ');
    qryAux.SQL.Add('        G.ITE_SALCON, G.ITE_GMLCON, G.ITE_DIGCON,          ');
    qryAux.SQL.Add('        0, 0, "N",                                         ');
    qryAux.SQL.Add('        G.ITE_SALDOS, G.ITE_QTEF_A, G.ITE_QTEF_F,          ');
    qryAux.SQL.Add('        G.ITE_QTEF_P,                                      ');
    qryAux.SQL.Add('        IFNULL(G.ITE_SALDOS,0) + IFNULL(G.ITE_QTEF_A,0)    ');
    qryAux.SQL.Add('        + IFNULL(G.ITE_QTEF_F,0) + IFNULL(G.ITE_QTEF_P,0)  ');
    qryAux.SQL.Add('   FROM ITEGER G                                           ');
    qryAux.SQL.Add('  INNER JOIN (SELECT DISTINCT ZER_CODEMP, ZER_CODITE        ');
    qryAux.SQL.Add('                FROM BALZER                                ');
    qryAux.SQL.Add('               WHERE ZER_CON_ID = :CONID                   ');
    qryAux.SQL.Add('                 AND ZER_CODCON = :CODCON                  ');
    qryAux.SQL.Add('                 AND ZER_ORIGEM = "Z") Z                   ');
    qryAux.SQL.Add('     ON Z.ZER_CODEMP = G.ITE_CODEMP                        ');
    qryAux.SQL.Add('    AND Z.ZER_CODITE = G.ITE_CODITE                        ');
    qryAux.SQL.Add('  WHERE G.ITE_CODEMP = :CODEMP                             ');
    qryAux.SQL.Add('    AND (G.ITE_SALCON <> 0 OR G.ITE_GMLCON <> 0            ');
    qryAux.SQL.Add('         OR IFNULL(G.ITE_DIGCON, "") <> "N")               ');

    qryAux.ParamByName('CODEMP2').AsString := AstrCodEmp;
    qryAux.ParamByName('DTACAD').AsDate    := VS_Date;
    qryAux.ParamByName('HRACAD').AsTime    := fTime();
    qryAux.ParamByName('CODOPE').AsString  := strLoginUsuarioLogado;
    qryAux.ParamByName('NOMFRM').AsString  := strNomFor;
    qryAux.ParamByName('CONID').AsString   := AstrConId;
    qryAux.ParamByName('CODCON').AsString  := AstrCodCon;
    qryAux.ParamByName('CODEMP').AsString  := AstrCodEmp;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

{Req. 456948-B - B3. CONDET de nivel de lote, uma passada para a rodada.

 Substitui a chamada por linha que fZeraContagemLote fazia a
 fGravaConDetZeraContagemLote. Medido numa rodada de 280 linhas: 215 COUNT,
 216 SET @EMPFIS, 216 INSERT, mais um fRetAutoIncrem por linha.

 O payload e copia fiel do original, CURDATE()/CURTIME() incluidos. O conjunto
 tambem: a versao por linha filtrava item + lote, e a uniao das linhas e
 exatamente o que BALZER guarda com ZER_ORIGEM = "Z" e ZER_NUMLOT <> "".

 TEM que rodar ANTES do UPDATE de CADLOT: le LOT_SALCON e LOT_DIGCON antes de
 serem zerados.}
class function TConDet.fGravaConDetZeraLotesRodada(AOwner: TComponent;
  const AstrConId, AstrCodCon, AstrCodEmp: String): Boolean;
  Var
    qryAux  : TUniQuery;
    intQtd  : Integer;
    strAutInc: String;
begin
  Result := True;

  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add(' SELECT COUNT(1) AS QTD                                   ');
    qryAux.SQL.Add('   FROM ITEGER G                                          ');
    qryAux.SQL.Add('  INNER JOIN CADLOT ON LOT_CODEMP = G.ITE_CODEMP          ');
    qryAux.SQL.Add('                   AND LOT_CODITE = G.ITE_CODITE          ');
    qryAux.SQL.Add('  INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE      ');
    qryAux.SQL.Add('  INNER JOIN BALZER Z ON Z.ZER_CODEMP = G.ITE_CODEMP      ');
    qryAux.SQL.Add('                    AND Z.ZER_CODITE = G.ITE_CODITE      ');
    qryAux.SQL.Add('                    AND Z.ZER_NUMLOT = CADLOT.LOT_NUMLOT ');
    qryAux.SQL.Add('  WHERE G.ITE_CODEMP = :CODEMP                            ');
    qryAux.SQL.Add('    AND Z.ZER_CON_ID = :CONID                             ');
    qryAux.SQL.Add('    AND Z.ZER_CODCON = :CODCON                            ');
    qryAux.SQL.Add('    AND Z.ZER_ORIGEM = "Z"                                ');
    qryAux.SQL.Add('    AND Z.ZER_NUMLOT <> ""                                ');

    qryAux.ParamByName('CODEMP').AsString := AstrCodEmp;
    qryAux.ParamByName('CONID').AsString  := AstrConId;
    qryAux.ParamByName('CODCON').AsString := AstrCodCon;
    qryAux.Open;
    intQtd := qryAux.FieldByName('QTD').AsInteger;
    qryAux.Close;

    If intQtd = 0 Then
      Exit;

    strAutInc := fRetAutoIncrem('CONDET', AstrCodEmp, intQtd);

    qryAux.SQL.Clear;
    qryAux.SQL.Add('SET @AUTINC = CAST(SUBSTRING("'+strAutInc+'", 4, 14) AS UNSIGNED) - 1;');
    qryAux.SQL.Add('SET @EMPFIS = (SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = "MOVGER");');
    qryAux.SQL.Add(' INSERT INTO CONDET (AUTOINCREM, DET_DTACAD, DET_HRACAD,   ');
    qryAux.SQL.Add('        DET_CODOPE, DET_NOMFRM, DET_CODITE, DET_CODEMP,    ');
    qryAux.SQL.Add('        DET_NUMLOT, DET_SALOLD, DET_GMLOLD, DET_DIGOLD,    ');
    qryAux.SQL.Add('        DET_SALNEW, DET_GMLNEW, DET_DIGNEW, DET_SALDOS,    ');
    qryAux.SQL.Add('        DET_QTEF_A, DET_QTEF_F, DET_QTEF_P, DET_SALFIS)    ');
    qryAux.SQL.Add(' SELECT CONCAT(@EMPFIS, LPAD((@AUTINC := @AUTINC + 1), 14, 0), :CODEMP2), ');
    qryAux.SQL.Add('        CURDATE(), CURTIME(), :CODOPE, :NOMFRM,             ');
    qryAux.SQL.Add('        G.ITE_CODITE, G.ITE_CODEMP, CADLOT.LOT_NUMLOT,     ');
    qryAux.SQL.Add('        CADLOT.LOT_SALCON, CADLOT.LOT_ML_CON,              ');
    qryAux.SQL.Add('        CADLOT.LOT_DIGCON,                                 ');
    qryAux.SQL.Add('        0, 0, "N",                                         ');
    qryAux.SQL.Add('        CADLOT.LOT_SALDOS, CADLOT.LOT_QTEF_A,              ');
    qryAux.SQL.Add('        CADLOT.LOT_QTEF_F, CADLOT.LOT_QTEF_P,              ');
    qryAux.SQL.Add('        IFNULL(CADLOT.LOT_SALDOS,0) + IFNULL(CADLOT.LOT_QTEF_A,0) ');
    qryAux.SQL.Add('        + IFNULL(CADLOT.LOT_QTEF_F,0) + IFNULL(CADLOT.LOT_QTEF_P,0) ');
    qryAux.SQL.Add('   FROM ITEGER G                                           ');
    qryAux.SQL.Add('  INNER JOIN CADLOT ON LOT_CODEMP = G.ITE_CODEMP           ');
    qryAux.SQL.Add('                   AND LOT_CODITE = G.ITE_CODITE           ');
    qryAux.SQL.Add('  INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE       ');
    qryAux.SQL.Add('  INNER JOIN BALZER Z ON Z.ZER_CODEMP = G.ITE_CODEMP       ');
    qryAux.SQL.Add('                    AND Z.ZER_CODITE = G.ITE_CODITE       ');
    qryAux.SQL.Add('                    AND Z.ZER_NUMLOT = CADLOT.LOT_NUMLOT  ');
    qryAux.SQL.Add('  WHERE G.ITE_CODEMP = :CODEMP                             ');
    qryAux.SQL.Add('    AND Z.ZER_CON_ID = :CONID                              ');
    qryAux.SQL.Add('    AND Z.ZER_CODCON = :CODCON                             ');
    qryAux.SQL.Add('    AND Z.ZER_ORIGEM = "Z"                                 ');
    qryAux.SQL.Add('    AND Z.ZER_NUMLOT <> ""                                 ');

    qryAux.ParamByName('CODEMP2').AsString := AstrCodEmp;
    qryAux.ParamByName('CODOPE').AsString  := strLoginUsuarioLogado;
    qryAux.ParamByName('NOMFRM').AsString  := AOwner.ClassName;
    qryAux.ParamByName('CODEMP').AsString  := AstrCodEmp;
    qryAux.ParamByName('CONID').AsString   := AstrConId;
    qryAux.ParamByName('CODCON').AsString  := AstrCodCon;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

class function TConDet.fGravaConDetZeraContagem(strCodite: string; AOwner: TComponent; strDigCon,
  strCodEmp, strFltFiltro: string; event_Parametros: TSetaParametros;  strArmazens: string): boolean;
  Var
    qrySelect : TUniQuery;
    qryCount: TUnIQuery;
    intQtdCondet: integer;
    strAutInc: string;

begin
  Result := True;
  qryCount := fCriaQuery;
  Try
    qryCount.SQL.Add('SELECT COUNT(1) AS QTD');
    qryCount.SQL.Add('  FROM ITEGER G ');
    qryCount.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
    qryCount.SQL.Add(' INNER JOIN CADLOT ON LOT_CODEMP = G.ITE_CODEMP AND LOT_CODITE = G.ITE_CODITE');

    qryCount.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP ');
    If strCodIte <> '' Then
       qryCount.SQL.Add('AND G.ITE_CODITE = :CODITE ');

    If Not fEmptyStr(strArmazens) Then
       qryCount.SQL.Add(' AND LOT_NUMLOT IN (' + strArmazens + ') ');

    qryCount.SQL.Add(strFltFiltro);
    If Assigned(event_Parametros) Then
      event_Parametros(qryCount)
    Else
     qryCount.ParamByName('CODEMP').AsString := strCodEmp;

    If strCodIte <> '' Then
       qryCount.ParamByName('CODITE').AsString := strCodIte;
     qryCount.Open;
     intQtdCondet := qryCount.FieldByName('QTD').AsInteger;

  finally
    FreeAndNil(qryCount)
  End;

  If intQtdCondet > 0 then
  begin

    qrySelect := fCriaQuery();
    Try
      strAutInc := fRetAutoIncrem('CONDET', VS_StrCodEmp, intQtdCondet);
      qrySelect.SQL.Add('SET @AUTINC = CAST(SUBSTRING("'+strAutInc+'", 4, 14) AS UNSIGNED) - 1;');
      qrySelect.SQL.Add('SET @EMPFIS = (SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = "MOVGER");');

      qrySelect.SQL.Add('INSERT INTO CONDET (');
      qrySelect.SQL.Add('     AUTOINCREM,');
      qrySelect.SQL.Add('     DET_DTACAD,');
      qrySelect.SQL.Add('     DET_HRACAD,');
      qrySelect.SQL.Add('     DET_CODOPE,');
      qrySelect.SQL.Add('     DET_NOMFRM,');
      qrySelect.SQL.Add('     DET_CODITE,');
      qrySelect.SQL.Add('     DET_CODEMP,');
      qrySelect.SQL.Add('     DET_NUMLOT,');
      qrySelect.SQL.Add('     DET_SALOLD,');
      qrySelect.SQL.Add('     DET_GMLOLD,');
      qrySelect.SQL.Add('     DET_DIGOLD,');
      qrySelect.SQL.Add('     DET_SALNEW,');
      qrySelect.SQL.Add('     DET_GMLNEW,');
      qrySelect.SQL.Add('     DET_DIGNEW, ');
      qrySelect.SQL.Add( '    DET_SALDOS, ');
      qrySelect.SQL.Add( '    DET_QTEF_A, ');
      qrySelect.SQL.Add( '    DET_QTEF_F, ');
      qrySelect.SQL.Add( '    DET_QTEF_P, ');
      qrySelect.SQL.Add( '    DET_SALFIS) ');
      qrySelect.SQL.Add('     (SELECT');
      qrySelect.SQL.Add('     CONCAT(@EMPFIS, LPAD((@AUTINC := @AUTINC + 1), 14, 0), ' + fQuotedStr(strCodEmp) +'),');
      qrySelect.SQL.Add('     CURDATE(),');
      qrySelect.SQL.Add('     CURTIME(),');
      qrySelect.SQL.Add('      ' + fQuotedStr(strLoginUsuarioLogado) + ',');
      qrySelect.SQL.Add('      ' + fQuotedStr(AOwner.ClassName) + ',');
      qrySelect.SQL.Add('      G.ITE_CODITE,');
      qrySelect.SQL.Add('      G.ITE_CODEMP,');
      qrySelect.SQL.Add('      LOT_NUMLOT,');
      qrySelect.SQL.Add('      ITE_SALCON,');
      qrySelect.SQL.Add('      ITE_GMLCON,');
      qrySelect.SQL.Add('      ITE_DIGCON,');
      qrySelect.SQL.Add('      0,');
      qrySelect.SQL.Add('      0,');
      qrySelect.SQL.Add('      0,');
      qrySelect.SQL.Add('      ITE_SALDOS , ');
      qrySelect.SQL.Add('      ITE_QTEF_A, ');
      qrySelect.SQL.Add('      ITE_QTEF_F, ');
      qrySelect.SQL.Add('      ITE_QTEF_P, ');
      qrySelect.SQL.Add('      IFNULL(ITE_SALDOS, 0) + IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_F, 0) + IFNULL(ITE_QTEF_P, 0) ');

      qrySelect.SQL.Add('  FROM ITEGER G ');
      qrySelect.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
      qrySelect.SQL.Add(' INNER JOIN CADLOT ON LOT_CODEMP = G.ITE_CODEMP AND LOT_CODITE = G.ITE_CODITE');

      qrySelect.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP ');
      If strCodIte <> '' Then
         qrySelect.SQL.Add('AND G.ITE_CODITE = :CODITE ');

      If Not fEmptyStr(strArmazens) Then
         qrySelect.SQL.Add(' AND LOT_NUMLOT IN (' + strArmazens + ') ');

      qrySelect.SQL.Add(  strFltFiltro + ' );');
      If Assigned(event_Parametros) Then
        event_Parametros(qrySelect)
      Else
       qrySelect.ParamByName('CODEMP').AsString := strCodEmp;

      If strCodIte <> '' Then
         qrySelect.ParamByName('CODITE').AsString := strCodIte;
      Result := True;
      Try
        qrySelect.ExecSQL;
      Except
        On E: Exception Do
        Begin
          Result := False;
          raise;
        End;
      End;
    Finally
      FreeAndNil(qrySelect);
    End;
  end;
end;

{Req. 456948-B - B8. blnUsaTemporaria saiu. O caminho que ele ligava lia as
 TMP_ITEGER_CONTAGEM / TMP_CADLOT_CONTAGEM dentro de um INSERT ... SELECT,
 e todo comando replicado que cita tabela temporaria falha na replica -
 280 por rodada, medido em 2026-08-20 na rodada 001000143.

 A leitura pela tabela real e equivalente: o payload sai todo de CADLOT, de
 ITEGER vem so CODITE e CODEMP, a chamada e restrita a um item + um lote, e
 o zeramento daquele lote acontece depois, no mesmo fZeraContagemLote.}
class function TConDet.fGravaConDetZeraContagemLote(strCodite: string;
  AOwner: TComponent; strDigCon, strCodEmp, strFltFiltro: string;
  event_Parametros: TSetaParametros; strArmazens: string): boolean;
  Var
    qrySelect : TUniQuery;
    qryCount: TUnIQuery;
    intQtdCondet: integer;
    strAutInc: string;
begin
  Result := True;
  qryCount := fCriaQuery;
  try
    qryCount.SQL.Add('SELECT COUNT(1) AS QTD');
    qryCount.SQL.Add('  FROM ITEGER G ');   {Req. 456948-B - B8}
    qryCount.SQL.Add(' INNER JOIN CADLOT ON LOT_CODEMP = G.ITE_CODEMP AND LOT_CODITE = G.ITE_CODITE');
    qryCount.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');

    qryCount.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP ');
    If strCodIte <> '' Then
       qryCount.SQL.Add('AND G.ITE_CODITE = :CODITE ');

    If Not fEmptyStr(strArmazens) Then
       qryCount.SQL.Add(' AND LOT_NUMLOT IN (' + strArmazens + ') ');

    qryCount.SQL.Add(  strFltFiltro  );
    If Assigned(event_Parametros) Then
      event_Parametros(qryCount)
    Else
     qryCount.ParamByName('CODEMP').AsString := strCodEmp;

    If strCodIte <> '' Then
       qryCount.ParamByName('CODITE').AsString := strCodIte;
    qryCount.Open;
    intQtdCondet := qryCount.FieldByName('QTD').AsInteger;
  finally
    FreeAndNil(qryCount);
  end;

  If intQtdCondet > 0 then
  begin
    qrySelect := fCriaQuery();
    Try
      strAutInc := fRetAutoIncrem('CONDET', VS_StrCodEmp, intQtdCondet);
      qrySelect.SQL.Add('SET @AUTINC = CAST(SUBSTRING("'+strAutInc+'", 4, 14) AS UNSIGNED) - 1;');
      qrySelect.SQL.Add('SET @EMPFIS = (SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = "MOVGER");');

      qrySelect.SQL.Add('INSERT INTO CONDET (');
      qrySelect.SQL.Add('     AUTOINCREM,');
      qrySelect.SQL.Add('     DET_DTACAD,');
      qrySelect.SQL.Add('     DET_HRACAD,');
      qrySelect.SQL.Add('     DET_CODOPE,');
      qrySelect.SQL.Add('     DET_NOMFRM,');
      qrySelect.SQL.Add('     DET_CODITE,');
      qrySelect.SQL.Add('     DET_CODEMP,');
      qrySelect.SQL.Add('     DET_NUMLOT,');
      qrySelect.SQL.Add('     DET_SALOLD,');
      qrySelect.SQL.Add('     DET_GMLOLD,');
      qrySelect.SQL.Add('     DET_DIGOLD,');
      qrySelect.SQL.Add('     DET_SALNEW,');
      qrySelect.SQL.Add('     DET_GMLNEW,');
      qrySelect.SQL.Add('     DET_DIGNEW, ');
      qrySelect.SQL.Add( '    DET_SALDOS, ');
      qrySelect.SQL.Add( '    DET_QTEF_A, ');
      qrySelect.SQL.Add( '    DET_QTEF_F, ');
      qrySelect.SQL.Add( '    DET_QTEF_P, ');
      qrySelect.SQL.Add( '    DET_SALFIS) ');
      qrySelect.SQL.Add('     (SELECT');
      qrySelect.SQL.Add('     CONCAT(@EMPFIS, LPAD((@AUTINC := @AUTINC + 1), 14, 0), ' + fQuotedStr(strCodEmp) +'),');
      qrySelect.SQL.Add('     CURDATE(),');
      qrySelect.SQL.Add('     CURTIME(),');
      qrySelect.SQL.Add('      ' + fQuotedStr(strLoginUsuarioLogado) + ',');
      qrySelect.SQL.Add('      ' + fQuotedStr(AOwner.ClassName) + ',');
      qrySelect.SQL.Add('      G.ITE_CODITE,');
      qrySelect.SQL.Add('      G.ITE_CODEMP,');
      qrySelect.SQL.Add('      LOT_NUMLOT,');
      qrySelect.SQL.Add('      LOT_SALCON,');
      qrySelect.SQL.Add('      LOT_ML_CON,');
      qrySelect.SQL.Add('      LOT_DIGCON,');
      qrySelect.SQL.Add('      0,');
      qrySelect.SQL.Add('      0,');
      qrySelect.SQL.Add('      "N",');
      qrySelect.SQL.Add('      LOT_SALDOS , ');
      qrySelect.SQL.Add('      LOT_QTEF_A, ');
      qrySelect.SQL.Add('      LOT_QTEF_F, ');
      qrySelect.SQL.Add('      LOT_QTEF_P, ');
      qrySelect.SQL.Add('      IFNULL(LOT_SALDOS, 0) + IFNULL(LOT_QTEF_A, 0) + IFNULL(LOT_QTEF_F, 0) + IFNULL(LOT_QTEF_P, 0) ');

      qrySelect.SQL.Add('  FROM ITEGER G ');   {Req. 456948-B - B8}
      qrySelect.SQL.Add(' INNER JOIN CADLOT ON LOT_CODEMP = G.ITE_CODEMP AND LOT_CODITE = G.ITE_CODITE');
      qrySelect.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');

      qrySelect.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP ');
      If strCodIte <> '' Then
         qrySelect.SQL.Add('AND G.ITE_CODITE = :CODITE ');

      If Not fEmptyStr(strArmazens) Then
         qrySelect.SQL.Add(' AND LOT_NUMLOT IN (' + strArmazens + ') ');

      qrySelect.SQL.Add(  strFltFiltro + ' );');
      If Assigned(event_Parametros) Then
        event_Parametros(qrySelect)
      Else
       qrySelect.ParamByName('CODEMP').AsString := strCodEmp;

      If strCodIte <> '' Then
         qrySelect.ParamByName('CODITE').AsString := strCodIte;
      Result := True;
      Try
        qrySelect.ExecSQL;
      Except
        On E: Exception Do
        Begin
          Result := False;
          raise;
        End;
      End;
    Finally
      FreeAndNil(qrySelect);
    End;
  end;
end;

procedure TConDet.pSetValoresAntigos;
  Var
    qrySelect : TUniQuery;
begin
  qrySelect := fCriaQuery(Self);
  With qrySelect Do
  Begin
    If fEmptyStr(FNumLot) Then
    Begin

      SQL.Add( ' SELECT SQL_NO_CACHE        ');
      SQL.Add( '        ITE_DIGCON,         ');
      SQL.Add( '        ITE_GMLCON,         ');
      SQL.Add( '        ITE_SALCON          ');
      SQL.Add( ' FROM ITEGER                ');
      SQL.Add( ' WHERE ITE_CODITE = :CODITE ');
      SQL.Add( '   AND ITE_CODEMP = :CODEMP ');

      ParamByName('CODITE').AsString := FCodIte;
      ParamByName('CODEMP').AsString := FCodEmp;
    End
    Else
    Begin

      SQL.Add( ' SELECT SQL_NO_CACHE              ');
      SQL.Add( '        LOT_DIGCON AS ITE_DIGCON, ');
      SQL.Add( '        0.00       AS ITE_GMLCON, ');
      SQL.Add( '        LOT_SALCON AS ITE_SALCON  ');
      SQL.Add( ' FROM CADLOT                      ');
      SQL.Add( ' WHERE LOT_CODITE = :CODITE       ');
      SQL.Add( '   AND LOT_CODEMP = :CODEMP       ');
      SQL.Add( '   AND LOT_NUMLOT = :CODLOT       ');

      ParamByName('CODITE').AsString := FCodIte;
      ParamByName('CODEMP').AsString := FCodEmp;
      ParamByName('CODLOT').AsString := FNumLot;

    End;

    Open;

    FDigConOld := FieldByName('ITE_DIGCON').AsString;
    FSalConOld := FieldByName('ITE_SALCON').AsFloat;
    FGmlConOld := FieldByName('ITE_GMLCON').AsFloat;

  End;
  FreeAndNil(qrySelect);

end;

function TConDet.fGravaConDet(blnAcumul : Boolean; strAutInc: String; AblnBalancoEstoqueImportar: Boolean = False):Boolean;
Begin
  pSetValoresAntigos;
  If blnAcumul Then
  Begin
    FSalCon := FSalCon + FSalConOld;
    If AblnBalancoEstoqueImportar Then
      FGmlCon := 0
    Else
      FGmlCon := FGmlCon + FGmlConOld;
  End;
  Result := fInserirRegistro(strAutInc);

End;

function TConDet.fInserirRegistro(strAutInc: String): Boolean;
  Var
    qryInsert : TUniQuery;
    blnTemLote: Boolean;
begin
  Try
    {Achado do Willian, 2026-08-25: sem esta branch, com lote (FNumLot
     preenchido) o INSERT gravava DET_SALDOS/QTEF_*/SALFIS de ITEGER em vez
     de CADLOT - comportamento da copia 150, portado para ca.}
    blnTemLote := Not fEmptyStr(FNumLot);

    qryInsert := fCriaQuery(Self);
    Try
      With qryInsert Do
      Begin
        SQL.Add( 'INSERT INTO CONDET ( ');
        SQL.Add( '        AUTOINCREM, ');
        SQL.Add( '        DET_DTACAD, ');
        SQL.Add( '        DET_HRACAD, ');
        SQL.Add( '        DET_CODOPE, ');
        SQL.Add( '        DET_NOMFRM, ');
        SQL.Add( '        DET_CODITE, ');
        SQL.Add( '        DET_CODEMP, ');
        SQL.Add( '        DET_NUMLOT, ');
        SQL.Add( '        DET_SALOLD, ');
        SQL.Add( '        DET_GMLOLD, ');
        SQL.Add( '        DET_DIGOLD, ');
        SQL.Add( '        DET_SALNEW, ');
        SQL.Add( '        DET_GMLNEW, ');
        SQL.Add( '        DET_DIGNEW, ');
        SQL.Add( '        DET_SALDOS, ');
        SQL.Add( '        DET_QTEF_A, ');
        SQL.Add( '        DET_QTEF_F, ');
        SQL.Add( '        DET_QTEF_P, ');
        SQL.Add( '        DET_SALFIS) ');
        SQL.Add( '        SELECT :AUTOIN AS AUTOIN, ');
        SQL.Add( '               :DTACAD AS DTACAD, ');
        SQL.Add( '               :HRACAD AS HRACAD, ');
        SQL.Add( '               :CODOPE AS CODOPE, ');
        SQL.Add( '               :NOMFRM AS NOMFRM, ');
        SQL.Add( '               G.ITE_CODITE AS CODITE, ');
        SQL.Add( '               G.ITE_CODEMP AS CODEMP, ');
        SQL.Add( '               :NUMLOT AS NUMLOT, ');
        SQL.Add( '               :SALOLD AS SALOLD, ');
        SQL.Add( '               :GMLOLD AS GMLOLD, ');
        SQL.Add( '               :DIGOLD AS DIGOLD, ');
        SQL.Add( '               :SALNEW AS SALNEW, ');
        SQL.Add( '               :GMLNEW AS GMLNEW, ');
        SQL.Add( '               :DIGNEW AS DIGNEW, ');

        If blnTemLote Then
        Begin
          SQL.Add( '               IFNULL(L.LOT_SALDOS, 0), ');
          SQL.Add( '               IFNULL(L.LOT_QTEF_A, 0), ');
          SQL.Add( '               IFNULL(L.LOT_QTEF_F, 0), ');
          SQL.Add( '               IFNULL(L.LOT_QTEF_P, 0), ');
          SQL.Add( '               IFNULL(L.LOT_SALDOS, 0) + IFNULL(L.LOT_QTEF_A, 0) + IFNULL(L.LOT_QTEF_F, 0) + IFNULL(L.LOT_QTEF_P, 0) ');
        End Else
        Begin
          SQL.Add( '               IFNULL(ITE_SALDOS, 0), ');
          SQL.Add( '               IFNULL(ITE_QTEF_A, 0), ');
          SQL.Add( '               IFNULL(ITE_QTEF_F, 0), ');
          SQL.Add( '               IFNULL(ITE_QTEF_P, 0), ');
          SQL.Add( '               IFNULL(ITE_SALDOS, 0) + IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_F, 0) + IFNULL(ITE_QTEF_P, 0) ');
        End;

        SQL.Add( '          FROM ITEGER G ');

        If blnTemLote Then
        Begin
          SQL.Add(' JOIN CADLOT L ON L.LOT_CODITE = G.ITE_CODITE ');
          SQL.Add('              AND L.LOT_CODEMP = G.ITE_CODEMP ');
          SQL.Add('              AND L.LOT_NUMLOT = :NUMLOT ');
        End;

        SQL.Add( '         WHERE G.ITE_CODITE = :CODITE ');
        SQL.Add( '           AND G.ITE_CODEMP = :CODEMP ');

        If fEmptyStr(strAutInc) Then
          strAutInc := fRetAutoIncrem('CONDET', FCodEmp);

        ParamByName('AUTOIN').AsString := strAutInc;
        ParamByName('DTACAD').AsDate   := VS_Date;
        ParamByName('HRACAD').AsTime   := fTime();
        ParamByName('CODOPE').AsString := IIf(FCodOpe = '' , strLoginUsuarioLogado, FCodOpe);
        ParamByName('NOMFRM').AsString := FNomFor;

        ParamByName('CODITE').AsString := FCodIte;
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMLOT').AsString := FNumLot;

        If fEmptyStr(FNumLot) Then
          ParamByName('NUMLOT').Clear;

        ParamByName('SALOLD').AsFloat  := FSalConOld;
        ParamByName('GMLOLD').AsFloat  := FGmlConOld;
        ParamByName('DIGOLD').AsString := FDigConOld;

        ParamByName('SALNEW').AsFloat  := FSalCon;
        ParamByName('GMLNEW').AsFloat  := FGmlCon;
        ParamByName('DIGNEW').AsString := FDigCon;


        If (FSalConOld <> FSalCon) Or
           (FGmlConOld <> FGmlCon) Or
           (FDigConOld <> FDigCon) Then
          ExecSQL;

        Result := True;

      End;

    Except
        Result := False;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;

end;

end.
