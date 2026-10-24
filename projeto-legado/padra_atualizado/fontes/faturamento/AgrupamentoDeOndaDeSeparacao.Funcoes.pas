unit AgrupamentoDeOndaDeSeparacao.Funcoes;

interface

uses
  untFuncoesSimples, untHelperCitel, untQckSintetizaItensSep, Uni, System.SysUtils, System.Classes, System.UITypes,
  StrUtils, Data.DB, UniClientDataSet, cxProgressBar,
  FireDAC.Stan.Intf, Datasnap.DBClient,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, AgrupamentoDeOndaDeSeparacao.Types;

type
  TRecItensRemessaImp = record
    strCodIte: String;
    strLocFis: String;
  end;

  TArrRecItensRemessaImp = Array of TRecItensRemessaImp;

  procedure GravarOndImp(ARemessaDeSeparacao : String; AItens: TArrRecItensRemessaImp = Nil);
  procedure RealizarImpressao(ARemessaDeSeparacao        : String;
                              ASomenteRemessaDeSeparacao : Boolean     = False;
                              AFila                      : String      = '';
                              AItens                     : TArrRecItensRemessaImp = Nil);

  function RemessasDePedidos: String;

  function RetSQLImpressaoRemessaDeSeparacao(ARemessaDeSeparacao, ASeparador : String; AItens : TArrRecItensRemessaImp = Nil) : String;
  function RetSQLImpressaoRemessaDePedido(ARemessaDePedido, ASeparador : String) : String;

  function GerarONDSEP(const ARemessaDeSeparacao: String; pgbProgresso: TcxProgressBar = Nil): Boolean;
  function RegravarONDSEP(const ARemessaDeSeparacao: String; pgbProgresso: TcxProgressBar = Nil): Boolean;

  function RetParamImpressaoRemessaDeSeparacao(AItens: TArrRecItensRemessaImp): String;

  function UtilizaListaDePrioridadePorLocalizacaoFisica: Boolean;
  function UtilizaListaDePrioridadePorLocalDeSeparacao : Boolean;

  function RetornaIndexFieldNamesPrioridadesSugestaoOndaDeSeparacao(var ALotes : TUniClientDataSet) : String; Overload;
  function RetornaIndexFieldNamesPrioridadesSugestaoOndaDeSeparacao(var ALotes : TFDMemTable)       : String; Overload;

  function RetLista(AValor: String; ASeparador: Char): TStringList;
  function UtilizaValidade: Boolean;
  function GetSqlItensOndaDeSeparacao(AOndaDeSeparacao: String; AAgrupar: Boolean; ACodIte: String = ''): String;
  function CriaCdsItensTL: TUniClientDataSet;
  function CriaCdsLotDor: TUniClientDataSet;
  function ApagaLotDor(AOndaDeSeparacao: String): Boolean;
  function RetMotivoBloqueio(const ACodIte, ACodEmp: String): String;
  function GetQuantLotesOndaEmAberto(const ACodIte: String; out ASeqOnd: String): Double;
  function TemSaldoDisponivel(const ACodIte: String; const AQtdIte: Double; out ASalDis: TRecSalDis): Boolean;
  procedure ReprocessaItens(ACodItens, ACodEmp: String; AEntFut: Boolean = True);

implementation

uses
  AgrupamentoDeOndaDeSeparacao.Impressao.Vias, untITintasDeMaquina, untFuncTinta,
  untGravando, untSaldoLojas, untDefineLotesWMS;

const
  PADRAO = 'DTAVAL;DESLOC;LOCFIS;NUMLOT';
  LOCFIS = 'CODITE;PRIORI;SALDIS';
  LOCSEP = 'DTAVAL;PRIORI;SALDIS';
  LOCQTD = 'SALDIS;DESLOC;LOCFIS;NUMLOT';

procedure GravarOndImp(ARemessaDeSeparacao : String; AItens : TArrRecItensRemessaImp = Nil);
  var
    LItem   : TRecItensRemessaImp;
    LOndImp : TUniQuery;
begin

  If (ARemessaDeSeparacao.IsEmpty) Then
    Exit;

  If Not Assigned(AItens) Then
    Exit;

  If (Length(AItens) <= 0) Then
    Exit;

  LOndImp := fCriaQuery();

  Try

    LOndImp.Close;
    LOndImp.SQL.Add('SELECT * FROM ONDIMP WHERE FALSE');
    LOndImp.Open;

    For LItem in AItens Do
    Begin
      LOndImp.Append;
      LOndImp.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ONDIMP', VS_strCodEmp);
      LOndImp.FieldByName('OND_SEQOND').AsString := ARemessaDeSeparacao;
      LOndImp.FieldByName('OND_CODITE').AsString := fTiraCaracEspeciais(LItem.strCodIte);
      LOndImp.FieldByName('OND_LOCFIS').AsString := LItem.strLocFis;
      LOndImp.FieldByName('OND_DTAIMP').AsDateTime := fRetDataServidor;
      LOndImp.FieldByName('OND_HRAIMP').AsDateTime := fRetHoraServidor;
      LOndImp.Post;
    End;

  Finally
    FreeAndNil(LOndImp);
  End;

end;

procedure RealizarImpressao(ARemessaDeSeparacao        : String;
                            ASomenteRemessaDeSeparacao : Boolean     = False;
                            AFila                      : String      = '';
                            AItens                     : TArrRecItensRemessaImp = Nil);
  const
    SQL = 'SELECT ' +
          '  DISTINCT(EXTGOR.FGO_SEQSEP) AS FINA ' +
          'FROM                          ' +
          '  FATGOR                      ' +
          '  INNER JOIN EXTGOR ON (EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM) ' +
          'WHERE                                                          ' +
          '  FGO_SEQOND = :SEQOND                                         ' +
          'GROUP BY                                                       ' +
          '  EXTGOR.FGO_SEQSEP ';

  var
    LDestino    : String;
    LSeparador  : String;
    LOndasRemessasDePedidos : TUniQuery;
    LRemessaDePedido        : String;
    LQckSintetizaItensSep   : TfrmQckSintetizaItensSep;
    LAgrupamentoDeOndaDeSeparacaoImpressaoVias: TfrmAgrupamentoDeOndaDeSeparacaoImpressaoVias;
    LQtdVias : Integer;
    LVia     : Integer;

begin

  LAgrupamentoDeOndaDeSeparacaoImpressaoVias := TfrmAgrupamentoDeOndaDeSeparacaoImpressaoVias.Create(Nil);

  Try

    If (LAgrupamentoDeOndaDeSeparacaoImpressaoVias.ShowModal = mrOk) Then
    Begin
      LDestino := LAgrupamentoDeOndaDeSeparacaoImpressaoVias.TipoSaida;
      LQtdVias := LAgrupamentoDeOndaDeSeparacaoImpressaoVias.QtdVias;
    End Else
      Exit;

  Finally
    pFreeAndNil(LAgrupamentoDeOndaDeSeparacaoImpressaoVias);
  End;

  LSeparador := strLoginUsuarioLogado;

  pCriarFormularios(TfrmQckSintetizaItensSep, LQckSintetizaItensSep);
  LOndasRemessasDePedidos := fCriaQuery();

  Try

    For LVia := 1 To LQtdVias Do
    Begin

      pProcessMessages;

      {** Remessa De Separação **}
      LQckSintetizaItensSep.pImprimir(RetSQLImpressaoRemessaDeSeparacao(ARemessaDeSeparacao, LSeparador, AItens), AFila, LDestino, LSeparador, ARemessaDeSeparacao, True);

      If Not ASomenteRemessaDeSeparacao Then
      Begin

        LOndasRemessasDePedidos.Close;
        LOndasRemessasDePedidos.SQL.Clear;
        LOndasRemessasDePedidos.SQL.Add(SQL);
        LOndasRemessasDePedidos.ParamByName('SEQOND').AsString := ARemessaDeSeparacao;
        LOndasRemessasDePedidos.Open;

        LOndasRemessasDePedidos.First;
        While Not LOndasRemessasDePedidos.Eof Do
        Begin

          LRemessaDePedido := LOndasRemessasDePedidos.FieldByName('FINA').AsString;

          {** Remessa De Pedido **}
          LQckSintetizaItensSep.pImprimir(RetSQLImpressaoRemessaDePedido(LRemessaDePedido, LSeparador), AFila, LDestino, LSeparador, LRemessaDePedido, False, True);
          LOndasRemessasDePedidos.Next;

        End;

      End;

    End;

  Finally

    GravarOndImp(ARemessaDeSeparacao, AItens);

    If Assigned(LQckSintetizaItensSep) Then
      pFreeAndNil(LQckSintetizaItensSep);

    If Assigned(LOndasRemessasDePedidos) Then
      FreeAndNil(LOndasRemessasDePedidos);

  End;

end;

function RemessasDePedidos: String;
begin
  Result := EmptyStr;
  Result := Result + ' (SELECT GROUP_CONCAT(DISTINCT EE.FGO_SEQSEP SEPARATOR ", ") ';
  Result := Result + '    FROM FATGOR GG ';
  Result := Result + '    JOIN EXTGOR EE ON (EE.FGO_SEQFGO = GG.AUTOINCREM) ';
  Result := Result + '    JOIN FATDOR D  ON (D.FDO_SEQGER = GG.AUTOINCREM) ';
  Result := Result + '    JOIN EXTDOR E  ON (E.FDO_SEQFDO = D.AUTOINCREM) ';
  Result := Result + '   WHERE GG.FGO_CODVEN = CDVENDEDOR ';
  Result := Result + '     AND D.FDO_CODITE = CONS.FDO_CODITE ';
  Result := Result + '     AND EE.FGO_SEQOND = SEQOND)) ';
end;

function RetSQLImpressaoRemessaDeSeparacao(ARemessaDeSeparacao, ASeparador : String; AItens : TArrRecItensRemessaImp = Nil) : String;
  var
    LSQL : String;
begin

  {Onda + WMS + Agrupamento de Remessa de Pedido}
  LSQL := '';
  LSQL := LSQL + 'SELECT SEQOND, ';
  LSQL := LSQL + '       FDO_CODITE, ';
  LSQL := LSQL + '       FDO_DESCRI, ';
  LSQL := LSQL + '       FDO_UNIDAD, ';
  LSQL := LSQL + '       IFNULL(SUM(LDO_QTDITE), 0) AS FDO_QTDITE, ';
  LSQL := LSQL + '       ITE_CODFAB, ';
  LSQL := LSQL + '       ITE_LOCFIS, ';
  LSQL := LSQL + '       GROUP_CONCAT(DISTINCT CONCAT(FDO_NUMDOC, "-", FDO_ESPDOC, "-", FDO_CODEMP) SEPARATOR ", ") AS DOCUMENTOS, ';

  LSQL := LSQL + '  (                                                        ';
  LSQL := LSQL + '  SELECT                                                   ';
  LSQL := LSQL + '    GROUP_CONCAT(DISTINCT CONCAT(O.OPE_NOMOPE, " ", G.FGO_SEQSEP) SEPARATOR ", ") ';
  LSQL := LSQL + '  FROM                                                     ';
  LSQL := LSQL + '    FATGOR F                                               ';
  LSQL := LSQL + '    JOIN EXTGOR G ON (G.FGO_SEQFGO = F.AUTOINCREM)         ';
  LSQL := LSQL + '    JOIN CADOPE O ON (O.OPE_CODOPE = F.FGO_CODVEN)         ';
  LSQL := LSQL + '  WHERE                                                    ';
  LSQL := LSQL + '    G.FGO_SEQOND IN ('+ARemessaDeSeparacao.QuotedString+') ';
  LSQL := LSQL + '  ORDER BY                                                 ';
  LSQL := LSQL + '    F.FGO_CODVEN, G.FGO_SEQSEP                             ';
  LSQL := LSQL + '  ) AS ONDAS_FINAS,                                        ';

  LSQL := LSQL + '       NSEPEX, ';
  LSQL := LSQL + '       LOCSUP, ';
  LSQL := LSQL + '       SALDOS, ';
  LSQL := LSQL + '       CURRENT_DATE AS DTAIMP, ';
  LSQL := LSQL + '       CURRENT_TIME AS HORIMP, ';
  LSQL := LSQL + '      (SELECT LPAD(COUNT(FGO_SEQOND),4,''0'') ';
  LSQL := LSQL + '       FROM EXTGOR ';
  LSQL := LSQL + '       WHERE FGO_SEQOND IN('+ARemessaDeSeparacao.QuotedString+')) AS TOTPED, ';
  LSQL := LSQL + '       LDO_NUMLOT, ';
  LSQL := LSQL + '       LOT_LOCFIS, ';
  LSQL := LSQL + '       BAR_CODBAR, ';
  LSQL := LSQL + '       ORI_DESORI, ';

  LSQL := LSQL + '       NMVENDEDOR, ';
  LSQL := LSQL + '       CONCAT(NMVENDEDOR, " ", '+RemessasDePedidos+' AS NMVENREMPD ';

  LSQL := LSQL + 'FROM( ';

  LSQL := LSQL + ' SELECT FGO_SEQOND AS SEQOND, FGO_SEQSEP,   ';
  LSQL := LSQL + '        F.FDO_CODITE, ';
  LSQL := LSQL + '        F.FDO_DESCRI, ';
  LSQL := LSQL + '        UNI_SIGUNI AS "FDO_UNIDAD", ';
  LSQL := LSQL + '        F.FDO_QTDITE, ';
  LSQL := LSQL + '        C.ITE_CODFAB, ';
  LSQL := LSQL + '        I.ITE_LOCFIS, ';

  LSQL := LSQL + '        CONCAT('+ASeparador.QuotedString+',''-'',OS.OPE_NOMOPE) AS NSEPEX, ';
  LSQL := LSQL + '        O2.OPE_NOMOPE AS NMVENDEDOR, ';
  LSQL := LSQL + '        O2.OPE_CODOPE AS CDVENDEDOR, ';

  LSQL := LSQL + '        I.ITE_LOCSUP AS LOCSUP, ';
  LSQL := LSQL + '        I.ITE_SALDOS AS SALDOS, ';
  LSQL := LSQL + '        FDO_NUMDOC, ';
  LSQL := LSQL + '        FDO_ESPDOC, ';
  LSQL := LSQL + '        FDO_CODEMP, ';
  LSQL := LSQL + '        LDO_NUMLOT, ';
  LSQL := LSQL + '        CL.LOT_LOCFIS,     ';
  LSQL := LSQL + '        LT.LDO_QTDITE,     ';
  LSQL := LSQL + '        ORIFGO.ORI_DESORI, ';

  LSQL := LSQL + '        CASE WHEN COALESCE(C.ITE_CODBAR, "") = "" ';
  LSQL := LSQL + '             THEN (SELECT BAR_CODBAR FROM ITEBAR WHERE BAR_CODITE = C.ITE_CODITE AND BAR_CODEMP ="' + VS_strCodEmp + '" AND BAR_PRINCI = 1) ';
  LSQL := LSQL + '             ELSE ITE_CODBAR ';
  LSQL := LSQL + '        END AS BAR_CODBAR ';

  LSQL := LSQL + ' FROM FATDOR F ';
  LSQL := LSQL + ' INNER JOIN FATGOR G   ON G.AUTOINCREM  = F.FDO_SEQGER ';
  LSQL := LSQL + ' INNER JOIN EXTGOR E   ON FGO_SEQFGO    = F.FDO_SEQGER ';
  LSQL := LSQL + ' LEFT  JOIN LOTDOR LT  ON LT.LDO_SEQFDO = F.AUTOINCREM ';
  LSQL := LSQL + ' LEFT  JOIN CADLOT CL  ON CL.LOT_NUMLOT = LT.LDO_NUMLOT AND ';
  LSQL := LSQL + '                          CL.LOT_CODEMP = E.FGO_EMPEXP  AND ';
  LSQL := LSQL + '                          CL.LOT_CODITE = F.FDO_CODITE      ';
  LSQL := LSQL + ' INNER JOIN CADITE C   ON F.FDO_CODITE  = C.ITE_CODITE ';
  LSQL := LSQL + ' LEFT  JOIN CADUNI U   ON UNI_CODUNI    = C.ITE_CODUNI ';
  LSQL := LSQL + ' INNER JOIN ITEGER I   ON C.ITE_CODITE  = I.ITE_CODITE ';
  LSQL := LSQL + '                      AND I.ITE_CODEMP  = "' + VS_strCodEmp + '" ';

  LSQL := LSQL + ' LEFT  JOIN CADOPE OS  ON OS.OPE_CODOPE = "' + ASeparador + '" ';
  LSQL := LSQL + ' LEFT  JOIN CADOPE O2  ON O2.OPE_CODOPE = G.FGO_CODVEN ';

  LSQL := LSQL + ' LEFT  JOIN ORIFGO     ON ORIFGO.ORI_CODORI = E.FGO_CODORI ';

  If fCfgSis('FATAUT', VarBoolean) Then
    LSQL := LSQL + ' LEFT JOIN FATAUT ON FGO_NUMDOC = FATAUT.FAT_NUMDOC  AND FGO_ESPDOC = FATAUT.FAT_ESPDOC AND FGO_CODEMP = FATAUT.FAT_EMPDOC ';

  LSQL := LSQL + ' WHERE FGO_SEQOND IN('+ARemessaDeSeparacao.QuotedString+') ';

  LSQL := LSQL + IIF(fCfgSis('FATAUT', VarBoolean), ' AND ((FDO_JAFATU = 0) OR (FAT_NUMFAT IS NOT NULL AND FAT_DTLBEX IS NULL)) ', ' AND FDO_JAFATU = 0 ');

  LSQL := LSQL + '   AND IFNULL(FDO_BXSBIT,"N") = "N" ';

  LSQL := LSQL + ' UNION ALL ';

  LSQL := LSQL + ' SELECT FGO_SEQOND AS SEQOND, FGO_SEQSEP,   ';
  LSQL := LSQL + '        C.ITE_CODITE AS FDO_CODITE, ';

  If fCfgSis('IMPREF', varBoolean) Then
  Begin
    If fCfgSis('MONDES', varInteger) = 1 Then
      LSQL := LSQL + '      TRIM(CONCAT(ITE_DESITE, " ", IFNULL(ITE_REFERE,""))) AS FDO_DESCRI, '
    Else
      LSQL := LSQL + '      TRIM(CONCAT(IFNULL(ITE_REFERE,""), " ", ITE_DESITE)) AS FDO_DESCRI, ';
  End
  Else
    LSQL := LSQL + '        ITE_DESITE AS FDO_DESCRI, ';

  LSQL := LSQL + '        UNI_SIGUNI AS "FDO_UNIDAD", ';
  LSQL := LSQL + '        (F.FDO_QTDITE * DMT_QTDITE) AS FDO_QTDITE, ';
  LSQL := LSQL + '        C.ITE_CODFAB, ';
  LSQL := LSQL + '        I.ITE_LOCFIS, ';

  LSQL := LSQL + '        CONCAT('+ASeparador.QuotedString+',''-'',OS.OPE_NOMOPE) AS NSEPEX, ';
  LSQL := LSQL + '        O2.OPE_NOMOPE AS NMVENDEDOR, ';
  LSQL := LSQL + '        O2.OPE_CODOPE AS CDVENDEDOR, ';

  LSQL := LSQL + '        I.ITE_LOCSUP AS LOCSUP, ';
  LSQL := LSQL + '        I.ITE_SALDOS AS SALDOS, ';
  LSQL := LSQL + '        FDO_NUMDOC, ';
  LSQL := LSQL + '        FDO_ESPDOC, ';
  LSQL := LSQL + '        FDO_CODEMP, ';
  LSQL := LSQL + '        LDO_NUMLOT, ';
  LSQL := LSQL + '        CL.LOT_LOCFIS,     ';
  LSQL := LSQL + '        LT.LDO_QTDITE,     ';
  LSQL := LSQL + '        ORIFGO.ORI_DESORI, ';

  LSQL := LSQL + '        CASE WHEN COALESCE(C.ITE_CODBAR, "") = "" ';
  LSQL := LSQL + '             THEN (SELECT BAR_CODBAR FROM ITEBAR WHERE BAR_CODITE = C.ITE_CODITE AND BAR_CODEMP ="' + VS_strCodEmp + '" AND BAR_PRINCI = 1) ';
  LSQL := LSQL + '             ELSE ITE_CODBAR ';
  LSQL := LSQL + '        END AS BAR_CODBAR ';

  LSQL := LSQL + ' FROM FATDOR F ';
  LSQL := LSQL + ' INNER JOIN FATGOR G   ON G.AUTOINCREM  = F.FDO_SEQGER ';
  LSQL := LSQL + ' INNER JOIN EXTGOR E   ON FGO_SEQFGO    = F.FDO_SEQGER  ';
  LSQL := LSQL + ' LEFT  JOIN LOTDOR LT  ON LT.LDO_SEQFDO = F.AUTOINCREM      ';
  LSQL := LSQL + ' LEFT  JOIN CADLOT CL  ON CL.LOT_NUMLOT = LT.LDO_NUMLOT AND ';
  LSQL := LSQL + '                          CL.LOT_CODEMP = E.FGO_EMPEXP  AND ';
  LSQL := LSQL + '                          CL.LOT_CODITE = F.FDO_CODITE      ';
  LSQL := LSQL + ' INNER JOIN GERMAT GM  ON GMT_CODITE    = F.FDO_CODITE  ';
  LSQL := LSQL + ' INNER JOIN DETMAT DM  ON DMT_SEQGER    = GM.AUTOINCREM ';
  LSQL := LSQL + ' INNER JOIN CADITE C   ON DMT_ITESUB    = C.ITE_CODITE  ';
  LSQL := LSQL + ' LEFT  JOIN CADUNI U   ON UNI_CODUNI    = C.ITE_CODUNI  ';
  LSQL := LSQL + ' INNER JOIN ITEGER I   ON C.ITE_CODITE  = I.ITE_CODITE  ';
  LSQL := LSQL + '                      AND I.ITE_CODEMP  = "' + VS_strCodEmp + '" ';

  LSQL := LSQL + ' LEFT  JOIN CADOPE OS  ON OS.OPE_CODOPE = "' + ASeparador + '" ';
  LSQL := LSQL + ' LEFT  JOIN CADOPE O2  ON O2.OPE_CODOPE = G.FGO_CODVEN ';

  LSQL := LSQL + ' LEFT  JOIN ORIFGO     ON ORIFGO.ORI_CODORI = E.FGO_CODORI ';

  If fCfgSis('FATAUT', VarBoolean) Then
    LSQL := LSQL + ' LEFT JOIN FATAUT ON FGO_NUMDOC = FATAUT.FAT_NUMDOC  AND FGO_ESPDOC = FATAUT.FAT_ESPDOC AND FGO_CODEMP = FATAUT.FAT_EMPDOC ';

  LSQL := LSQL + ' WHERE FGO_SEQOND IN('+ARemessaDeSeparacao.QuotedString+') ';

  LSQL := LSQL + IIF(fCfgSis('FATAUT', VarBoolean), ' AND ((FDO_JAFATU = 0) OR (FAT_NUMFAT IS NOT NULL AND FAT_DTLBEX IS NULL)) ', ' AND FDO_JAFATU = 0 ');

  LSQL := LSQL + '   AND IFNULL(FDO_BXSBIT,"N") = "S" ';

  LSQL := LSQL + ') AS CONS ';

  If Assigned(AItens) And (Length(AItens) > 0) Then
    LSQL := LSQL + ' WHERE ' + RetParamImpressaoRemessaDeSeparacao(AItens);

  LSQL := LSQL + ' GROUP BY SEQOND, NMVENDEDOR, FDO_CODITE, FDO_DESCRI, FDO_UNIDAD, ITE_CODFAB, LDO_NUMLOT, LOT_LOCFIS';
  LSQL := LSQL + ' ORDER BY SEQOND, LOT_LOCFIS, LDO_NUMLOT ';

  Result := LSQL;

end;

function RetSQLImpressaoRemessaDePedido(ARemessaDePedido, ASeparador : String) : String;
  var
    LSQL : String;
begin

  {Onda + WMS}
  LSQL := '';
  LSQL := LSQL + 'SELECT FGO_SEQSEP, ';
  LSQL := LSQL + '       FDO_CODITE, ';
  LSQL := LSQL + '       FDO_DESCRI, ';
  LSQL := LSQL + '       FDO_UNIDAD, ';
  LSQL := LSQL + '       SUM(LDO_QTDITE) FDO_QTDITE, ';
  LSQL := LSQL + '       ITE_CODFAB, ';
  LSQL := LSQL + '       ITE_LOCFIS, ';
  LSQL := LSQL + '       OPE_NOMOPE, ';
  LSQL := LSQL + '       GROUP_CONCAT(DISTINCT CONCAT(FDO_NUMDOC, "-", FDO_ESPDOC, "-", FDO_CODEMP) SEPARATOR ", ") AS DOCUMENTOS, ';
  LSQL := LSQL + '       NSEPEX, ';
  LSQL := LSQL + '       LOCSUP, ';
  LSQL := LSQL + '       SALDOS, ';
  LSQL := LSQL + '       OPESEP, ';
  LSQL := LSQL + '       CURRENT_DATE AS DTAIMP, ';
  LSQL := LSQL + '       CURRENT_TIME AS HORIMP, ';
  LSQL := LSQL + '      (SELECT LPAD(COUNT(FGO_SEQSEP),4,''0'') ';
  LSQL := LSQL + '       FROM EXTGOR ';
  LSQL := LSQL + '       WHERE FGO_SEQSEP IN('+ARemessaDePedido.QuotedString+')) AS TOTPED, ';
  LSQL := LSQL + '       LDO_NUMLOT, ';
  LSQL := LSQL + '       LOT_LOCFIS, ';
  LSQL := LSQL + '       BAR_CODBAR ';
  LSQL := LSQL + 'FROM( ';

  LSQL := LSQL + ' SELECT FGO_SEQSEP,   ';
  LSQL := LSQL + '        F.FDO_CODITE, ';
  LSQL := LSQL + '        F.FDO_DESCRI, ';
  LSQL := LSQL + '        UNI_SIGUNI AS "FDO_UNIDAD", ';
  LSQL := LSQL + '        F.FDO_QTDITE, ';
  LSQL := LSQL + '        C.ITE_CODFAB, ';
  LSQL := LSQL + '        I.ITE_LOCFIS, ';
  LSQL := LSQL + '        OP.OPE_NOMOPE, ';
  LSQL := LSQL + '        CONCAT('+ASeparador.QuotedString+',''-'',OS.OPE_NOMOPE) AS NSEPEX, ';
  LSQL := LSQL + '        I.ITE_LOCSUP AS LOCSUP, ';
  LSQL := LSQL + '        I.ITE_SALDOS AS SALDOS, ';
  LSQL := LSQL + '  "' + StrLoginUsuarioLogado + '" "-" "' + StrDescriUsuarioLogado +'" AS OPESEP, ';
  LSQL := LSQL + '        FDO_NUMDOC, ';
  LSQL := LSQL + '        FDO_ESPDOC, ';
  LSQL := LSQL + '        FDO_CODEMP, ';
  LSQL := LSQL + '        LDO_NUMLOT, ';
  LSQL := LSQL + '        CL.LOT_LOCFIS, ';
  LSQL := LSQL + '        LT.LDO_QTDITE,  ';

  LSQL := LSQL + '        CASE WHEN COALESCE(C.ITE_CODBAR, "") = "" ';
  LSQL := LSQL + '             THEN (SELECT BAR_CODBAR FROM ITEBAR WHERE BAR_CODITE = C.ITE_CODITE AND BAR_CODEMP ="' + VS_strCodEmp + '" AND BAR_PRINCI = 1) ';
  LSQL := LSQL + '             ELSE ITE_CODBAR ';
  LSQL := LSQL + '        END AS BAR_CODBAR ';

  LSQL := LSQL + ' FROM FATDOR F ';
  LSQL := LSQL + ' INNER JOIN FATGOR G   ON G.AUTOINCREM  = F.FDO_SEQGER ';
  LSQL := LSQL + ' INNER JOIN EXTGOR E   ON FGO_SEQFGO    = F.FDO_SEQGER ';
  LSQL := LSQL + ' LEFT  JOIN LOTDOR LT  ON LT.LDO_SEQFDO = F.AUTOINCREM ';
  LSQL := LSQL + ' LEFT  JOIN CADLOT CL  ON CL.LOT_NUMLOT = LT.LDO_NUMLOT AND ';
  LSQL := LSQL + '                          CL.LOT_CODEMP = E.FGO_EMPEXP  AND ';
  LSQL := LSQL + '                          CL.LOT_CODITE = F.FDO_CODITE      ';
  LSQL := LSQL + ' INNER JOIN CADITE C   ON F.FDO_CODITE  = C.ITE_CODITE ';
  LSQL := LSQL + ' LEFT  JOIN CADUNI U   ON UNI_CODUNI    = C.ITE_CODUNI ';
  LSQL := LSQL + ' LEFT JOIN CADOPE OP  ON OPE_CODOPE    = G.FGO_CODVEN ';
  LSQL := LSQL + ' INNER JOIN ITEGER I   ON C.ITE_CODITE  = I.ITE_CODITE ';
  LSQL := LSQL + '                      AND I.ITE_CODEMP  = "' + VS_strCodEmp + '" ';
  LSQL := LSQL + ' LEFT  JOIN CADOPE OS  ON OS.OPE_CODOPE = "' + ASeparador + '" ';

  If fCfgSis('FATAUT', VarBoolean) Then
    LSQL := LSQL + ' LEFT JOIN FATAUT ON FGO_NUMDOC = FATAUT.FAT_NUMDOC  AND FGO_ESPDOC = FATAUT.FAT_ESPDOC AND FGO_CODEMP = FATAUT.FAT_EMPDOC ';

  LSQL := LSQL + ' WHERE FGO_SEQSEP IN('+ARemessaDePedido.QuotedString+') ';

  LSQL := LSQL + IIF(fCfgSis('FATAUT', VarBoolean), ' AND ((FDO_JAFATU = 0) OR (FAT_NUMFAT IS NOT NULL AND FAT_DTLBEX IS NULL)) ', ' AND FDO_JAFATU = 0 ');

  LSQL := LSQL + '   AND IFNULL(FDO_BXSBIT,"N") = "N" ';

  LSQL := LSQL + ' UNION ALL ';

  LSQL := LSQL + ' SELECT FGO_SEQSEP,   ';
  LSQL := LSQL + '        C.ITE_CODITE AS FDO_CODITE, ';

  If fCfgSis('IMPREF', varBoolean) Then
  Begin
    If fCfgSis('MONDES', varInteger) = 1 Then
      LSQL := LSQL + '      TRIM(CONCAT(ITE_DESITE, " ", IFNULL(ITE_REFERE,""))) AS FDO_DESCRI, '
    Else
      LSQL := LSQL + '      TRIM(CONCAT(IFNULL(ITE_REFERE,""), " ", ITE_DESITE)) AS FDO_DESCRI, ';
  End
  Else
    LSQL := LSQL + '        ITE_DESITE AS FDO_DESCRI, ';

  LSQL := LSQL + '        UNI_SIGUNI AS "FDO_UNIDAD", ';
  LSQL := LSQL + '        (F.FDO_QTDITE * DMT_QTDITE) AS FDO_QTDITE, ';
  LSQL := LSQL + '        C.ITE_CODFAB, ';
  LSQL := LSQL + '        I.ITE_LOCFIS, ';
  LSQL := LSQL + '        OP.OPE_NOMOPE, ';
  LSQL := LSQL + '        CONCAT('+ASeparador.QuotedString+',''-'',OS.OPE_NOMOPE) AS NSEPEX, ';
  LSQL := LSQL + '        I.ITE_LOCSUP AS LOCSUP, ';
  LSQL := LSQL + '        I.ITE_SALDOS AS SALDOS, ';
  LSQL := LSQL + '  "' + StrLoginUsuarioLogado + '" "-" "' + StrDescriUsuarioLogado +'" AS OPESEP, ';
  LSQL := LSQL + '        FDO_NUMDOC, ';
  LSQL := LSQL + '        FDO_ESPDOC, ';
  LSQL := LSQL + '        FDO_CODEMP, ';
  LSQL := LSQL + '        LDO_NUMLOT, ';
  LSQL := LSQL + '        CL.LOT_LOCFIS, ';
  LSQL := LSQL + '        LT.LDO_QTDITE, ';

  LSQL := LSQL + '        CASE WHEN COALESCE(C.ITE_CODBAR, "") = "" ';
  LSQL := LSQL + '             THEN (SELECT BAR_CODBAR FROM ITEBAR WHERE BAR_CODITE = C.ITE_CODITE AND BAR_CODEMP ="' + VS_strCodEmp + '" AND BAR_PRINCI = 1) ';
  LSQL := LSQL + '             ELSE ITE_CODBAR ';
  LSQL := LSQL + '        END AS BAR_CODBAR ';

  LSQL := LSQL + ' FROM FATDOR F ';
  LSQL := LSQL + ' INNER JOIN FATGOR G   ON G.AUTOINCREM  = F.FDO_SEQGER ';
  LSQL := LSQL + ' INNER JOIN EXTGOR E   ON FGO_SEQFGO    = F.FDO_SEQGER  ';
  LSQL := LSQL + ' LEFT  JOIN LOTDOR LT  ON LT.LDO_SEQFDO = F.AUTOINCREM      ';
  LSQL := LSQL + ' LEFT  JOIN CADLOT CL  ON CL.LOT_NUMLOT = LT.LDO_NUMLOT AND ';
  LSQL := LSQL + '                          CL.LOT_CODEMP = E.FGO_EMPEXP  AND ';
  LSQL := LSQL + '                          CL.LOT_CODITE = F.FDO_CODITE      ';
  LSQL := LSQL + ' INNER JOIN GERMAT GM  ON GMT_CODITE    = F.FDO_CODITE  ';
  LSQL := LSQL + ' INNER JOIN DETMAT DM  ON DMT_SEQGER    = GM.AUTOINCREM ';
  LSQL := LSQL + ' INNER JOIN CADITE C   ON DMT_ITESUB    = C.ITE_CODITE  ';
  LSQL := LSQL + ' LEFT  JOIN CADUNI U   ON UNI_CODUNI    = C.ITE_CODUNI  ';
  LSQL := LSQL + ' LEFT JOIN CADOPE OP ON OPE_CODOPE = G.FGO_CODVEN  ';
  LSQL := LSQL + ' INNER JOIN ITEGER I   ON C.ITE_CODITE  = I.ITE_CODITE  ';
  LSQL := LSQL + '                      AND I.ITE_CODEMP  = "' + VS_strCodEmp + '" ';
  LSQL := LSQL + ' LEFT  JOIN CADOPE OS  ON OS.OPE_CODOPE = "' + ASeparador + '" ';

  If fCfgSis('FATAUT', VarBoolean) Then
    LSQL := LSQL + ' LEFT JOIN FATAUT ON FGO_NUMDOC = FATAUT.FAT_NUMDOC  AND FGO_ESPDOC = FATAUT.FAT_ESPDOC AND FGO_CODEMP = FATAUT.FAT_EMPDOC ';

  LSQL := LSQL + ' WHERE FGO_SEQSEP IN('+ARemessaDePedido.QuotedString+') ';

  LSQL := LSQL + IIF(fCfgSis('FATAUT', VarBoolean), ' AND ((FDO_JAFATU = 0) OR (FAT_NUMFAT IS NOT NULL AND FAT_DTLBEX IS NULL)) ', ' AND FDO_JAFATU = 0 ');

  LSQL := LSQL + '   AND IFNULL(FDO_BXSBIT,"N") = "S" ';

  LSQL := LSQL + ') AS CONS ';
  LSQL := LSQL + ' GROUP BY FGO_SEQSEP, FDO_CODITE, FDO_DESCRI, FDO_UNIDAD, ITE_CODFAB, LDO_NUMLOT, LOT_LOCFIS';
  LSQL := LSQL + ' ORDER BY FGO_SEQSEP, LDO_NUMLOT, LOT_LOCFIS ';

  Result := LSQL;

end;

function GerarONDSEP(const ARemessaDeSeparacao: String; pgbProgresso: TcxProgressBar = Nil): Boolean;
  const
    SQL = 'SELECT                         ' +
          '  D.FDO_CODITE      AS CODITE, ' +
          '  SUM(L.LDO_QTDITE) AS QTDITE, ' +
          '  C.LOT_LOCFIS      AS LOCFIS  ' +
          'FROM       ' +
          '  FATGOR F ' +
          '  INNER JOIN EXTGOR E ON (E.FGO_SEQFGO = F.AUTOINCREM) ' +
          '  INNER JOIN FATDOR D ON (D.FDO_SEQGER = F.AUTOINCREM) ' +
          '  INNER JOIN LOTDOR L ON (L.LDO_SEQFDO = D.AUTOINCREM) ' +
          '  INNER JOIN CADLOT C ON (C.LOT_NUMLOT = L.LDO_NUMLOT AND ' +
          '                          C.LOT_CODEMP = E.FGO_EMPEXP AND ' +
          '                          C.LOT_CODITE = D.FDO_CODITE)    ' +
          'WHERE                    ' +
          '  E.FGO_SEQOND = :SEQOND ' +
          'GROUP BY                 ' +
          '  D.FDO_CODITE, C.LOT_LOCFIS ' +
          'ORDER BY                     ' +
          '  D.FDO_CODITE, L.LDO_QTDITE, C.LOT_LOCFIS ';

  var
    LLotDor : TUniQuery;
    LOndSep : TUniQuery;
begin

  Result := False;

  LLotDor := fCriaQuery;
  LOndSep := fCriaQuery;

  Try

    Try

      LLotDor.SQL.Add(SQL);
      LLotDor.ParamByName('SEQOND').AsString := ARemessaDeSeparacao;
      LLotDor.Open;

      If LLotDor.IsEmpty Then
        Exit;

      LOndSep.SQL.Add('SELECT * FROM ONDSEP WHERE FALSE');
      LOndSep.Open;

      LLotDor.First;
      While Not LLotDor.Eof Do
      Begin

        pProgresso(LLotDor.RecNo, LLotDor.RecordCount, pgbProgresso);

        LOndSep.Append;
        LOndSep.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ONDSEP', VS_strCodEmp);
        LOndSep.FieldByName('OND_SEQOND').AsString := ARemessaDeSeparacao;
        LOndSep.FieldByName('OND_CODITE').AsString := LLotDor.FieldByName('CODITE').AsString;
        LOndSep.FieldByName('OND_QTDITE').AsString := LLotDor.FieldByName('QTDITE').AsString;
        LOndSep.FieldByName('OND_LOCFIS').AsString := LLotDor.FieldByName('LOCFIS').AsString;
        LOndSep.FieldByName('OND_STATUS').AsString := 'A';
        LOndSep.Post;

        LLotDor.Next;

      End;

      Result := True;

    Finally
      FreeAndNil(LLotDor);
      FreeAndNil(LOndSep);
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Não foi possível gerar a tabela ONDSEP!');
    End;
  End;

end;

function RegravarONDSEP(const ARemessaDeSeparacao: String; pgbProgresso: TcxProgressBar = Nil): Boolean;
  const
    DEL = 'DELETE FROM ONDSEP WHERE OND_SEQOND = :SEQOND';
  var
    LQry : TUniQuery;
begin

  Result := False;

  If ARemessaDeSeparacao.IsEmpty Then
    Exit;

  LQry := fCriaQuery;

  Try
    LQry.SQL.Add(DEL);
    LQry.ParamByName('SEQOND').AsString := ARemessaDeSeparacao;
    LQry.ExecSQL;
  Finally
    FreeAndNil(LQry);
  End;

  Result := GerarONDSEP(ARemessaDeSeparacao, pgbProgresso);

end;

function RetParamImpressaoRemessaDeSeparacao(AItens: TArrRecItensRemessaImp): String;
var
  LItem: TRecItensRemessaImp;
begin
  Result := '';

  for LItem in AItens do
    Result := Result + '(FDO_CODITE = ' + LItem.strCodIte + ' AND LOT_LOCFIS = ' + LItem.strLocFis.QuotedString + ') OR ';

  Result := LeftStr(Result, Length(Result) - 3);
end;

function UtilizaListaDePrioridadePorLocalizacaoFisica: Boolean;
begin
  Result := False;

  If Not fUsaOndaSeparacaoExpedicaoWMS Then
    Exit;

  If Not (fCfgSis('SEGPRI', varBoolean)) Then
    Exit;

  If fEmptyStr(fCfgSis('PRIORI', varString)) Then
    Exit;

  Result := True;
end;

function UtilizaListaDePrioridadePorLocalDeSeparacao: Boolean;
begin
  Result := False;

  If Not fUsaOndaSeparacaoExpedicaoWMS Then
    Exit;

  If Not fUsaOndaSeparacaoAgrupamento Then
    Exit;

  If fEmptyStr(fCfgSis('LOCPRI', varString)) Then
    Exit;

  Result := True;
end;

function RetornaIndexFieldNamesPrioridadesSugestaoOndaDeSeparacao(var ALotes : TUniClientDataSet) : String;
  var
    LPriOri            : String;
    LPrioridades       : TStringList;
    LContador          : Integer;
    LTamPrioridade     : Integer;
    LPrioridade        : String;
    LDefinePrioridade  : Boolean;
    LCodLocalSeparacao : String;
begin

  Result := PADRAO;

  LPriOri := IIF(UtilizaListaDePrioridadePorLocalizacaoFisica, fCfgSis('PRIORI', varString),
             IIF(UtilizaListaDePrioridadePorLocalDeSeparacao , fCfgSis('LOCPRI', varString), ''));

  If (Not fEmptyStr(LPriOri)) Then
  Begin

    LPrioridades := RetLista(LPriOri, ';');

    Try

      If (LPrioridades.Count > 0) Then
      Begin

        {Define prioridade}
        For LContador := 0 to LPrioridades.Count -1 Do
        Begin

          ALotes.First;
          While Not ALotes.Eof Do
          Begin

            LPrioridade    := LPrioridades[LContador];
            LTamPrioridade := Length(LPrioridade);

            LCodLocalSeparacao := fGetLocalSeparacaoLocFis(ALotes.FieldByName('LOCFIS').AsString);
            LDefinePrioridade  := False;

            If UtilizaListaDePrioridadePorLocalizacaoFisica Then
              LDefinePrioridade := (Copy(ALotes.FieldByName('LOCFIS').AsString, 0, LTamPrioridade) = LPrioridade);

            If UtilizaListaDePrioridadePorLocalDeSeparacao Then
              LDefinePrioridade := (Copy(LCodLocalSeparacao, 0, LTamPrioridade) = LPrioridade);

            If LDefinePrioridade Then
            Begin
              ALotes.Edit;
              ALotes.FieldByName('PRIORI').AsString := LContador.ToString;
              ALotes.Post;
            End;

            ALotes.Next;

          End;

        End;

        If UtilizaListaDePrioridadePorLocalizacaoFisica Then
          Exit(LOCFIS);

        If UtilizaListaDePrioridadePorLocalDeSeparacao Then
          Exit(IIF(UtilizaValidade, LOCSEP, LOCSEP.Replace('DTAVAL;', '')));

      End;

    Finally
      If Assigned(LPrioridades) Then
        FreeAndNil(LPrioridades);
    End;

  End
  Else
  Begin

    If (Not UtilizaValidade) And (fCfgSis('SELLOT') = 'Q') Then
      Exit(LOCQTD);

  End;

end;

function RetornaIndexFieldNamesPrioridadesSugestaoOndaDeSeparacao(var ALotes : TFDMemTable) : String;
  var
    LPriOri            : String;
    LPrioridades       : TStringList;
    LContador          : Integer;
    LTamPrioridade     : Integer;
    LPrioridade        : String;
    LDefinePrioridade  : Boolean;
    LCodLocalSeparacao : String;
begin

  Result := PADRAO;

  LPriOri := IIF(UtilizaListaDePrioridadePorLocalizacaoFisica, fCfgSis('PRIORI', varString),
             IIF(UtilizaListaDePrioridadePorLocalDeSeparacao , fCfgSis('LOCPRI', varString), ''));

  If (Not fEmptyStr(LPriOri)) Then
  Begin

    LPrioridades := RetLista(LPriOri, ';');

    Try

      If (LPrioridades.Count > 0) Then
      Begin

        {Define prioridade}
        For LContador := 0 to LPrioridades.Count -1 Do
        Begin

          ALotes.First;
          While Not ALotes.Eof Do
          Begin

            LPrioridade    := LPrioridades[LContador];
            LTamPrioridade := Length(LPrioridade);

            LCodLocalSeparacao := fGetLocalSeparacaoLocFis(ALotes.FieldByName('LOCFIS').AsString);
            LDefinePrioridade  := False;

            If UtilizaListaDePrioridadePorLocalizacaoFisica Then
              LDefinePrioridade := (Copy(ALotes.FieldByName('LOCFIS').AsString, 0, LTamPrioridade) = LPrioridade);

            If UtilizaListaDePrioridadePorLocalDeSeparacao Then
              LDefinePrioridade := (Copy(LCodLocalSeparacao, 0, LTamPrioridade) = LPrioridade);

            If LDefinePrioridade Then
            Begin
              ALotes.Edit;
              ALotes.FieldByName('PRIORI').AsString := LContador.ToString;
              ALotes.Post;
            End;

            ALotes.Next;

          End;

        End;

        If UtilizaListaDePrioridadePorLocalizacaoFisica Then
          Exit(LOCFIS);

        If UtilizaListaDePrioridadePorLocalDeSeparacao Then
          Exit(IIF(UtilizaValidade, LOCSEP, LOCSEP.Replace('DTAVAL;', '')));

      End;

    Finally
      If Assigned(LPrioridades) Then
        FreeAndNil(LPrioridades);
    End;

  End
  Else
  Begin

    If (Not UtilizaValidade) And (fCfgSis('SELLOT') = 'Q') Then
      Exit(LOCQTD);

  End;

end;

function RetLista(AValor: String; ASeparador: Char): TStringList;
begin
  Result                 := TStringList.Create;
  Result.Delimiter       := ASeparador;
  Result.StrictDelimiter := True;
  Result.DelimitedText   := AValor;
end;

function UtilizaValidade: Boolean;
begin
  Result := True;

  If fCfgSis('COLVAL', varBoolean) Then
    Exit;

  If (Not fCfgSis('COLVAL', varBoolean)) And (fCfgSis('VALOBR', varBoolean)) Then
    Exit;

  Result := False;
end;

function GetSqlItensOndaDeSeparacao(AOndaDeSeparacao: String; AAgrupar: Boolean; ACodIte: String = ''): String;
Var
  tintas : ITintasDeMaquina;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '  FDO_NUMDOC,       ';
  Result := Result + '  FDO_ESPDOC,       ';
  Result := Result + '  FDO_CODEMP,       ';
  Result := Result + '  FDO_EMPITE,       ';
  Result := Result + '  FDO_IDEPRO,       ';
  Result := Result + '  FDO_PROACA,       ';
  Result := Result + '  FDO_CODITE,       ';
  Result := Result + '  LOT_NUMLOT AS FDO_NUMLOT, ';
  Result := Result + '  FDO_REFERE,       ';
  Result := Result + '  UNI_SIGUNI,       ';
  Result := Result + '  CONCAT(FDO_DESCRI, ';
  Result := Result + '         IF(IFNULL(FDO_COMPLE, "") <> "", ';
  Result := Result + '            CONCAT(" - ", IFNULL(FDO_COMPLE, "")), "")) AS FDO_DESCRI, ';

  If (AAgrupar) Then
    Result := Result + '  (SUM(FDO_QTDITE) - SUM(FDO_QTDBAI)) AS FDO_QTDITE, '
  Else
    Result := Result + '  (FDO_QTDITE - FDO_QTDBAI) AS FDO_QTDITE, ';

  Result := Result + '  I.ITE_SALDOS,     ';
  Result := Result + '  C.ITE_CODITE,     ';
  Result := Result + '  C.ITE_CODBAR,     ';
  Result := Result + '  C.ITE_CODFAB,     ';
  Result := Result + '  C.ITE_LOTEPD,     ';

  Result := Result + '  IFNULL(LOT_NUMLOT, "A DEFINIR") AS NUMLOT, ';

  Result := Result + '  "0" AS TEMLOT, '; // SE O ITEM POSSUI LOTE(S)

  Result := Result + '  FATGOR.FGO_ORIGEM,';

  Result := Result + '    IF((SELECT COUNT(0) FROM MOVLOT    ';
  Result := Result + '        WHERE MLT_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '          AND MLT_CODITE = FDO_CODITE  ';
  Result := Result + '          AND MLT_DTAREA IS NULL) = 0, "N", "S") AS TEM_MOVLOT, ';

  Result := Result + '  FGO_CODCLI,       ';
  Result := Result + '  FATDOR.AUTOINCREM,';
  Result := Result + '  FATDOR.FDO_SEQGER,';
  Result := Result + '  0 AS SALCOR,      ';
  Result := Result + '  FDO_CODACA        ';
  Result := Result + 'FROM                ';
  Result := Result + '  FATDOR            ';
  Result := Result + '  INNER JOIN FATGOR   ON FATGOR.AUTOINCREM = FDO_SEQGER   ';
  Result := Result + '  INNER JOIN EXTGOR E ON E.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  Result := Result + '  INNER JOIN CADITE C ON C.ITE_CODITE = FDO_CODITE ';
  Result := Result + '  INNER JOIN ITEGER I ON I.ITE_CODITE = FDO_CODITE AND I.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '  INNER JOIN CADUNI   ON   FDO_UNIDAD = UNI_CODUNI ';

  Result := Result + '  LEFT JOIN CADLOT ON  LOT_CODITE = FDO_CODITE AND ';
  Result := Result + '                       LOT_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
  Result := Result + '                       IF(IFNULL(FDO_NUMLOT,"") <> "", LOT_NUMLOT = FDO_NUMLOT, ';

  if (fCfgSis('TINWMS', varBoolean)) and (fCfgSis('USATMQ', varBoolean)) Then
  Begin
    tintas := fGetTintasdeMaquina;
    Result := Result + ' IF((FDO_IDEPRO = "NOR" AND FDO_PROACA <> "S") OR (LOCATE(FDO_IDEPRO,"' + tintas.fGetImobiliarias + '") > 0) , ';
  End
  Else
    Result := Result + '                                                       IF(FDO_IDEPRO = "NOR" AND FDO_PROACA <> "S", ';
  Result := Result + '                                                         LOT_NUMLOT = "A DEFINIR", LOT_PRITIN = "S")) ';

  If fCfgSis('FATAUT', VarBoolean) Then
    Result := Result + '  LEFT JOIN FATAUT ON FATAUT.FAT_NUMDOC = FATGOR.FGO_NUMDOC AND ' +
                                            ' FATAUT.FAT_ESPDOC = FATGOR.FGO_ESPDOC AND ' +
                                            ' FATAUT.FAT_EMPDOC = FATGOR.FGO_CODEMP ';

  Result := Result + 'WHERE            ';

  If (fUsaOndaSeparacaoAgrupamento) Then
    Result := Result + '  E.FGO_SEQOND = ' + QuotedStr(AOndaDeSeparacao) + ' AND '
  Else
    Result := Result + '  E.FGO_SEQSEP = ' + QuotedStr(AOndaDeSeparacao) + ' AND ';

  If Not fEmptyStr(ACodIte) Then
    Result := Result + ' FATDOR.FDO_CODITE = ' + QuotedStr(ACodIte) + ' AND ';

  Result := Result + '  FDO_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' AND ';
  Result := Result + '  FDO_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + ' AND ';
  Result := Result + '  IFNULL(FDO_ENTFUT,"N") = "N" AND  ';
  Result := Result + '  IFNULL(FDO_PROEMB,"N") <> "S" AND ';
  Result := Result + '  FDO_QTDITE > FDO_QTDBAI AND ';

  If fCfgSis('FATAUT', VarBoolean) Then
    Result := Result + '  ((FDO_JAFATU = 0) OR (FAT_NUMFAT IS NOT NULL AND FAT_DTLBEX IS NULL)) '
  Else
    Result := Result + '  FDO_JAFATU = 0 ';

  If (AAgrupar) Then
  Begin
    Result := Result + '  GROUP BY     ';
    Result := Result + '    FDO_CODITE ';
  End;
end;

function CriaCdsItensTL: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  Result.FieldDefs.Add('CODITE', ftString, fTamCodIte);
  Result.FieldDefs.Add('ARMDES', ftString, VS_Size_NumLot);
  Result.FieldDefs.Add('ARMORI', ftString, VS_Size_NumLot);
  Result.FieldDefs.Add('QTDITE', ftFloat);

  Result.CreateDataSet;
  Result.LogChanges := False;
end;

function CriaCdsLotDor: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  Result.FieldDefs.Add('AUTOINCREM', ftString, 20);
  Result.FieldDefs.Add('LDO_SEQFDO', ftString, 20);
  Result.FieldDefs.Add('LDO_NUMLOT', ftString, VS_Size_NumLot);
  Result.FieldDefs.Add('LDO_QTDITE', ftFloat);
  Result.FieldDefs.Add('LDO_SALCAL', ftFloat);
  Result.FieldDefs.Add('LDO_MOVENT', ftFloat);
  Result.FieldDefs.Add('LDO_MOVSAI', ftFloat);
  Result.FieldDefs.Add('LDO_CODSEP', ftString, 3);

  Result.CreateDataSet;
  Result.LogChanges := False;
end;

function ApagaLotDor(AOndaDeSeparacao: String): Boolean;
  Var
    LQry: TUniQuery;
begin
  Result := False;
  LQry := fCriaQuery;

  Try
    Try

      LQry.SQL.Add('DELETE FROM LOTDOR WHERE LDO_SEQFDO IN ');
      LQry.SQL.Add('(SELECT        ');
      LQry.SQL.Add('  D.AUTOINCREM ');
      LQry.SQL.Add('FROM           ');
      LQry.SQL.Add('  FATGOR G     ');
      LQry.SQL.Add('  INNER JOIN EXTGOR E ON (E.FGO_SEQFGO = G.AUTOINCREM) ');
      LQry.SQL.Add('  INNER JOIN FATDOR D ON (D.FDO_SEQGER = G.AUTOINCREM) ');
      LQry.SQL.Add('WHERE ');
      LQry.SQL.Add('  E.FGO_SEQOND = :SEQOND)');

      LQry.ParamByName('SEQOND').AsString := AOndaDeSeparacao;
      LQry.ExecSQL;

      Result := True;

    Except
      Raise;
    End;
  Finally
    FreeAndNil(LQry);
  End;
end;

procedure ReprocessaItens(ACodItens, ACodEmp: String; AEntFut: Boolean = True);
  Var
    LQry: TUniQuery;
begin

  LQry := fCriaQuery;

  Try

    LQry.SQL.Add('UPDATE ITEGER');
    LQry.SQL.Add('SET ITE_REPAUD = "S"');

    If AEntFut Then
      LQry.SQL.Add(', ITE_REPAEF = "S"');

    LQry.SQL.Add('WHERE ITE_CODITE IN ('+ ACodItens +')');
    LQry.SQL.Add('AND ITE_CODEMP = :CODEMP');

    LQry.ParamByName('CODEMP').AsString := ACodEmp;
    LQry.ExecSQL;

  Finally
    FreeAndNil(LQry);
  End;
end;

function RetMotivoBloqueio(const ACodIte, ACodEmp: String): String;
  Var
    objSalLoj: TSaldoLojas;
    recSaldos, recSaldosML: TRecSaldos;
begin
  objSalLoj := TSaldoLojas.Create(Nil);
  try
    objSalLoj.pCalculaSaldos(Nil,
                             recSaldos,
                             recSaldosML,
                             fSaldoEmpresas(ACodIte, ACodEmp),
                             ACodEmp,
                             ACodEmp,
                             ACodIte,
                             0, //fltCnvML
                             fCfgSis('ENTFUT', varBoolean),
                             False, //blnPedCorte
                             fCfgSis('ORDPRO', varBoolean),
                             fCfgSis('CALSAL', varInteger));

    Result := 'PRODUTO ('+ ACodIte +' - '+ fRetNomProduto(ACodIte) +') DO PEDIDO SEM SALDO | '+
              'SALDO DISPONÍVEL: '+ FloatToStrF(recSaldos.fltSalDis, ffNumber, 12, 3) +' | '+
              'SALDO ANALÍTICO: '+
              FloatToStrF(recSaldos.fltEstFis, ffNumber, 12, 3) +' | '+
              FloatToStrF(recSaldos.fltSalPed - recSaldos.fltPedFil, ffNumber, 12, 3) +' | '+
              FloatToStrF(recSaldos.fltPedFil, ffNumber, 12, 3) +' | '+
              FloatToStrF(recSaldos.fltSalOrd, ffNumber, 12, 3) +' | '+
              FloatToStrF(recSaldos.fltSalEnd, ffNumber, 12, 3) +' | '+
              FloatToStrF(recSaldos.fltSalGar, ffNumber, 12, 3) +' | '+
              FloatToStrF(IIF(recSaldos.fltSalExt < 0, 0, recSaldos.fltSalExt), ffNumber, 12, 3) +' | ';
  finally
    FreeAndNil(objSalLoj);
  end;
end;

function GetQuantLotesOndaEmAberto(const ACodIte: String; out ASeqOnd: String): Double;
  Var
    qryLotDor: TUniQuery;
begin
  qryLotDor := fCriaQuery;

  try

    qryLotDor.SQL.Clear;
    qryLotDor.SQL.Add('SELECT');
    qryLotDor.SQL.Add('  SUM(LDO_QTDITE) AS QTDITE,');
    qryLotDor.SQL.Add('  GROUP_CONCAT(DISTINCT FGO_SEQOND ORDER BY FGO_SEQOND) AS SEQOND');
    qryLotDor.SQL.Add('FROM');
    qryLotDor.SQL.Add('  FATGOR');
    qryLotDor.SQL.Add('  JOIN EXTGOR ON (FGO_SEQFGO = FATGOR.AUTOINCREM) ');
    qryLotDor.SQL.Add('  JOIN FATDOR ON (FDO_SEQGER = FATGOR.AUTOINCREM) ');
    qryLotDor.SQL.Add('  JOIN LOTDOR ON (LDO_SEQFDO = FATDOR.AUTOINCREM) ');
    qryLotDor.SQL.Add('  JOIN CADLOT ON (LOT_NUMLOT = LOTDOR.LDO_NUMLOT AND ');
    qryLotDor.SQL.Add('                  LOT_CODEMP = EXTGOR.FGO_EMPEXP AND ');
    qryLotDor.SQL.Add('                  LOT_CODITE = FATDOR.FDO_CODITE)    ');
    qryLotDor.SQL.Add('  JOIN CADLOC ON (CADLOC.LOC_CODLOC = CADLOT.LOT_LOCFIS AND ');
    qryLotDor.SQL.Add('                  CADLOC.LOC_CODEMP = CADLOT.LOT_CODEMP)    ');
    qryLotDor.SQL.Add('WHERE');
    qryLotDor.SQL.Add('  (FGO_EMPEXP = :CODEMP) AND ');
    qryLotDor.SQL.Add('  (FDO_CODITE = :CODITE) AND ');
    qryLotDor.SQL.Add('  (FDO_JAFATU <> 1)      AND ');
    qryLotDor.SQL.Add('  (IFNULL(FGO_SEQOND,"") <> "") AND ');
    qryLotDor.SQL.Add('  (IFNULL(FGO_SEQSEP,"") <> "") AND ');
    qryLotDor.SQL.Add('  (IFNULL(LOC_CRITIC,"N") = "N")    ');

    qryLotDor.ParamByName('CODITE').AsString := ACodIte;
    qryLotDor.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryLotDor.Open;

    ASeqOnd := '';

    If Not qryLotDor.IsEmpty Then
      ASeqOnd := qryLotDor.FieldByName('SEQOND').AsString;

    Result := qryLotDor.FieldByName('QTDITE').AsFloat;
  finally
    FreeAndNil(qryLotDor);
  end;
end;

function TemSaldoDisponivel(const ACodIte: String; const AQtdIte: Double; out ASalDis: TRecSalDis): Boolean;
Var
  LSalDis, LQtdLot: Double;
  LSeqOnd: String;
  LDecQtd: Integer;
begin
  LDecQtd := fCfgSis('DECQTD', varInteger);
  FillChar(ASalDis, SizeOf(ASalDis), #0);

  LSalDis := fRetornaSaldoDisponivel(ACodIte, //strCodIte
                                     False,   //blnCnvMl
                                     True,    //blnFaturamento
                                     '',      //strNumLot
                                     False,   //blnConsiderarPedidos
                                     '',      //strCodEmp
                                     '',      //strNumPedAlt
                                     False,   //blnConsiderarPedidoCompraPendente
                                     True,    //blnConsiderarCfgCalSal
                                     True,    //blnConsiderarOrdemProducao
                                     False,   //blnInformaSaldoGeralDisponivel
                                     False,   //blnConsiderarLocalizacaoCritica
                                     True,    //blnAplicarRegrasDeDefinicaoDeLotes
                                     TDefineLotesWMS.fGetSqlLotes(False, False, False),
                                     TDefineLotesWMS.fGetSqlWhereLotes);

  LQtdLot := 0;

  if fUsaOndaSeparacaoAgrupamento then
    LQtdLot := GetQuantLotesOndaEmAberto(ACodIte, LSeqOnd);

  Result := fFormataFloat(LSalDis - LQtdLot, LDecQtd) >= fFormataFloat(AQtdIte, LDecQtd);

  ASalDis.fltSalDis := LSalDis;
  ASalDis.fltQtdOnd := LQtdLot;
  ASalDis.strSeqOnd := LSeqOnd;
end;

end.
