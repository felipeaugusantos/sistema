unit untPosicaoEstDataThread;

interface

uses
  Classes , Windows, Dialogs, Uni, SysUtils, strUtils,
  UniClientDataSet, Variants, DB,
  untRelEstPosicaoEstDataFuncoes, Forms, UniDataSetProvider, cxProgressBar,
  untIFuncoes;

type
  TPosicaoEstDataThread = Class
  private
    FQrySql        : TUniQuery;

    FQryRes        : TUniQuery;

    FMin_DtaBal,
    FMax_DtaBal    : TDateTime;
    recParametros  : ^TParPosicaoEstDataThread;
    ResultThread   : Boolean;
    conConnection  : TUniConnection;

    FResult: TDataSet;

    FPrgBar: TcxProgressBar;

    Function fSetTamTabela: Boolean;
    Function fSetMinDtaBal: Boolean;
    Function fCriaTemporarias: Boolean;
    Function fDropTemporarias: Boolean;
    Function fSelecionaMovimento: Boolean;
    Function fAbreDadosRelatorio : Boolean;
    function fRetEmpresaCusto: String;
    Function fSqlDados(blnVazio: Boolean = False): String;
    Function fExecuteRelat(pgbProgresso: TcxProgressBar): Boolean;
    Function fSQLInsertKardex: String;

    Procedure pSetaTituloPrg(strTitulo: String);

  protected
  Public
    Constructor Create(Var recParRel : TParPosicaoEstDataThread; conConexao : TUniConnection );
    destructor Destroy; Reintroduce;

    Function fGetDados : TDataSet;

    Function fExecute: Boolean;
  end;

implementation

{ TPosicaoEstDataThread }

Uses untFuncoesFactory, untGravando;

constructor TPosicaoEstDataThread.Create(Var recParRel : TParPosicaoEstDataThread; conConexao : TUniConnection);
begin

  conConnection := TUniConnection.Create(Nil);
  With conConnection Do
  Begin
    Database := conConexao.Database;
    Server   := conConexao.Server;
    Username := conConexao.Username;
    Password := conConexao.Password;
    Port     := conConexao.Port;
    ProviderName := conConexao.ProviderName;
    Connect;
  End;

  FQryRes := fCriaQuery(Nil);

  FQrySql := TUniQuery.Create(nil);
  FQrySql.Connection  := conConnection;

  recParametros := @recParRel;

  FMin_DtaBal := 0;
  FMax_DtaBal := StrToDate(recParametros.mskDtaSal.Text);

  FResult := Nil;

end;

destructor TPosicaoEstDataThread.Destroy;
begin
  FreeAndNil(FQrySql);
  FreeAndNil(FQryRes);
  conConnection.Disconnect;
  FreeAndNil(conConnection);
  inherited Destroy;
end;

Function TPosicaoEstDataThread.fExecute: Boolean;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde...';
  frmGravando.fExecutarAcao := fExecuteRelat;
  frmGravando.ShowModal;
  Result := frmGravando.blnConfirma;
  pFreeAndNil(frmGravando);
End;

Function TPosicaoEstDataThread.fExecuteRelat(pgbProgresso: TcxProgressBar): Boolean;
begin
  Try
    FPrgBar := pgbProgresso;

    ResultThread := False;
    Result := fSetTamTabela;

    If Result Then
      Result := fSetMinDtaBal;

    If Result Then
      Result := fDropTemporarias;

    If Result Then
      Result := fCriaTemporarias;

    If Result Then
      Result := fSelecionaMovimento;

    If Result Then
      Result := fAbreDadosRelatorio;

    fDropTemporarias;

    conConnection.Disconnect;

    ResultThread := Result;
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TPosicaoEstDataThread.fExecuteRelat' );
      //Raise Exception.Create(E.Message);
    End;
  End;

end;

function TPosicaoEstDataThread.fRetEmpresaCusto: String;
  Var
    intContador: Integer;
Begin
  With recParametros^ Do
  If Not (fEmptyStr(edtCodEmpresa.Text)) Or (edtCodEmpresa.Text = '000') Then
  Begin
    Result := edtCodEmpresa.Text
  End Else
  Begin
    Result := VS_strCodEmp;

    If Length(arrEmpresa) > 0 Then
    Begin
      Result := arrEmpresa[0].strCodigo;

      For intContador := Low(arrEmpresa) To High(arrEmpresa) Do
       If arrEmpresa[intContador].strCodigo = VS_strCodEmp Then
         Result := VS_strCodEmp;
    End;

  End;
End;

function TPosicaoEstDataThread.fAbreDadosRelatorio: Boolean;
Begin
  try
    pSetaTituloPrg('carregando movimentação para a memória');

    With recParametros^ Do
    Begin
      Result := True;
      With FQryRes Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fSQLDados);

        ParamByName('MAX_DTABAL').AsDateTime := StrToDate(mskDtaSal.Text);

        If Params.FindParam('EMPLOG') <> Nil Then
          ParamByName('EMPLOG').AsString := fRetEmpresaCusto;

        If Params.FindParam('SALABA') <> Nil Then
          ParamByName('SALABA').AsFloat := fStrToFloat(edtSalAba.Text);

        If Params.FindParam('SALACI') <> Nil Then
          ParamByName('SALACI').AsFloat := fStrToFloat(edtSalAci.Text);

        pSetParametros(recParametros^, FQryRes);

        Open;

        FResult := FQryRes;
      End;
    End;
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TPosicaoEstDataThread.fAbreDadosRelatorio');
//      Raise Exception.Create(E.Message);
    End;

  End;

end;

function TPosicaoEstDataThread.fCriaTemporarias: Boolean;
begin
  Result := True;
  With FQrySql, Sql Do
  begin
    pSetaTituloPrg('criando tabela temporária');

    Close;
    Clear;
    Add(' CREATE TABLE TMP_KARDEX2 ( ');
    Add('   DET_CODEMP CHAR(03), ');
    Add('   DET_CODITE CHAR(07), ');
    Add(' 	DET_NUMLOT VARCHAR(20), ');
    Add('   DET_QTDITE DECIMAL (14, 4), ');
    Add('   INDEX `IDX_KARDEX_01` (`DET_CODITE`, `DET_CODEMP`), ');
    Add('   INDEX `IDX_KARDEX_02` (`DET_CODITE`, `DET_CODEMP`, `DET_NUMLOT`) ');
    Add(' ) ENGINE=MEMORY ');

    try
      ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TPosicaoEstDataThread.fCriaTemporarias');
//        Raise Exception.Create();
      End;
    End;
  End;

end;

function TPosicaoEstDataThread.fDropTemporarias: Boolean;
  Var
    FQryDel: TUniQuery;
begin
  Result := True;
  pSetaTituloPrg('apagando tabela temporária');

  FQryDel := fCriaQuery;

  With FQryDel, Sql Do
  begin
    Close;
    Clear;
    Add(' DROP TABLE IF EXISTS TMP_KARDEX2 ');
    try
      ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TPosicaoEstDataThread.fDropTemporarias');
//        Raise Exception.Create(E.Message);
      End;
    End;

  End;

  FreeAndNil(FQryDel);
end;

function TPosicaoEstDataThread.fSQLInsertKardex: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' INSERT INTO TMP_KARDEX2 ';
  strSQL := strSQL + ' (DET_CODEMP, DET_CODITE, DET_NUMLOT, DET_QTDITE) VALUES ';
  strSQL := strSQL + ' (:CODEMP, :CODITE, :NUMLOT, :QTDITE) ';
  Result := strSQL;
End;

function TPosicaoEstDataThread.fGetDados: TDataSet;
begin
  If ResultThread Then
    Result := FResult
  Else
    Result := Nil;
end;

function TPosicaoEstDataThread.fSelecionaMovimento: Boolean;
  Var
    strSQLSum,
    strSQL : String;
    qryKardex: TUniQuery;
begin
  pSetaTituloPrg('lendo movimentação');

  With FQrySql, Sql Do
  begin
    Result := True;
    strSQL := '';
    strSQL := strSql + ' SELECT SQL_NO_CACHE ';
    strSQL := strSql + '   DET_CODEMP, ';
    strSQL := strSql + '   DET_CODITE, ';
    strSQL := strSql + '   IFNULL(DET_NUMLOT,"") AS DET_NUMLOT, ';
    strSQL := strSql + '   SUM((IF( ITE_CNV_ML > 0, ';
    strSQL := strSql + '         IF( LEFT( DET_CLAFIS,1 ) >= 5, ';
    strSQL := strSql + '           -IF( DET_ESPDOC = "ML", ROUND( DET_QTDITE, 4 ), ROUND( ITE_CNV_ML * DET_QTDITE, ' + fCfgSis('DECQTD') + ') ), ';
    strSQL := strSql + '            IF( DET_ESPDOC = "ML", ROUND( DET_QTDITE, 4 ), ROUND( ITE_CNV_ML * DET_QTDITE, ' + fCfgSis('DECQTD') + ') ) ), ';
    strSQL := strSql + '         IF( LEFT( DET_CLAFIS,1 ) >= 5, -DET_QTDITE, DET_QTDITE ) ) ) ) AS DET_QTDITE ';


    strSQL := strSql + ' FROM MOVDET D ';

    strSQL := strSql + ' LEFT JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE ';
    strSQL := strSql + ' LEFT JOIN ITEGER G ON G.ITE_CODITE = D.DET_CODITE AND G.ITE_CODEMP = D.DET_CODEMP ';

    strSQL := strSql + ' LEFT JOIN CADLOT ON LOT_CODITE = DET_CODITE  ';
    strSQL := strSql + '                  AND LOT_CODEMP = DET_CODEMP ';
    strSQL := strSql + '                  AND LOT_NUMLOT = DET_NUMLOT ';

    strSQL := strSql + ' WHERE ';
    strSQL := strSql + '   DET_ESPDOC <> "TM"         AND ';
    strSQL := strSql + '   DET_FILKAR = "FALSE"       AND ';

    strSQL := strSql + '   DET_DTAENT BETWEEN ADDDATE(IF( IFNULL(LOT_NUMLOT,"") <> "", LOT_DTABAL, ITE_DTABAL),1) AND :MAX_DTABAL ';

    strSQL := strSql + fGetFiltros(recParametros^);

    strSQL := strSql + ' GROUP BY ';
    strSQL := strSql + '   DET_CODEMP,';
    strSQL := strSql + '   DET_CODITE, ';
    strSQL := strSql + '   DET_NUMLOT  ';

    strSQLSum := strSQL;

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSql + '   DET_CODEMP, ';
    strSQL := strSql + '   DET_CODITE, ';
    strSQL := strSql + '   DET_NUMLOT, ';
    strSQL := strSQL + '   SUM(DET_QTDITE) AS DET_QTDITE  ';
    strSQL := strSQL + '  FROM (             ';

    strSQL := strSQL + strSQLSum;

    strSQL := strSQL + ') AS TAB ';

    strSQL := strSql + ' GROUP BY ';
    strSQL := strSql + '   DET_CODEMP, ';
    strSQL := strSql + '   DET_CODITE, ';
    strSQL := strSql + '   DET_NUMLOT  ';

    Close;
    Clear;
    Add(strSQL);

    ParamByName('MAX_DTABAL').AsDateTime := FMax_DtaBal;

    pSetParametros(recParametros^, FQrySql);

    qryKardex := fCriaQuery;
    qryKardex.SQL.Text := fSQLInsertKardex;

    Try
      Open;

      FPrgBar.Position := 0;
      FPrgBar.Properties.Max := RecordCount;
      Application.ProcessMessages;

      While Not Eof Do
      Begin
        qryKardex.Close;
        qryKardex.ParamByName('CODEMP').AsString := FieldByName('DET_CODEMP').AsString;
        qryKardex.ParamByName('CODITE').AsString := FieldByName('DET_CODITE').AsString;
        qryKardex.ParamByName('NUMLOT').AsString := FieldByName('DET_NUMLOT').AsString;
        qryKardex.ParamByName('QTDITE').AsFloat  := FieldByName('DET_QTDITE').AsFloat;
        qryKardex.ExecSQL;

        Next;

        FPrgBar.Position := FPrgBar.Position + 1;
        Application.ProcessMessages;
      End;

    Except
      On E : Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

    FreeAndNil(qryKardex);

  End;

end;

function TPosicaoEstDataThread.fSetMinDtaBal: Boolean;
begin
  pSetaTituloPrg('lendo data de balanço inicial');

  With FQrySql, Sql Do
  begin
    Result := True;

    Close;
    Clear;
    Add(' SELECT MIN( ITE_DTABAL ) AS DTABAL FROM ITEGER ');
    try
      Open;

      If Not IsEmpty Then
        FMin_DtaBal := FieldByName('DTABAL').AsDateTime
      Else
        Result := False;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TPosicaoEstDataThread.fSetMinDtaBal');
//        Raise Exception.Create(E.Message);
      End;

    End;

  End;
end;

function TPosicaoEstDataThread.fSetTamTabela: Boolean;
begin
  With FQrySql, Sql Do
  begin
    Result := True;

    pSetaTituloPrg('inicializando configurações');

    Close;
    Clear;
    Add('SET @@max_heap_table_size = 536870912');
    try
      ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TPosicaoEstDataThread.fSetTamTabela');
//        Raise Exception.Create(E.Message);
      End;
    End;

    Close;
    Clear;
      Add('SET @@tmp_table_size      = 536870912');
    try
      ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TPosicaoEstDataThread.fSetTamTabela');
//        Raise Exception.Create(E.Message);
      End;
    End;

  End;

end;

Procedure TPosicaoEstDataThread.pSetaTituloPrg(strTitulo: String);
Begin
  If Assigned(frmGravando) Then
    frmGravando.lblGravando.Caption := 'Aguarde, ' + strTitulo + '...';
  Application.ProcessMessages;

  If Assigned(FPrgBar) Then
    FPrgBar.Position := 0;
End;

Function TPosicaoEstDataThread.fSqlDados(blnVazio: Boolean = False): String;

  Function fSaldos : String;
  Begin
    Result := '';
    Result := Result + '  IF( IFNULL(LOT_DTABAL,G.ITE_DTABAL) <= :MAX_DTABAL ';
    Result := Result + '  	 ,ROUND(((IFNULL(LOT_SALBAL,G.ITE_SALBAL) * IF(ITE_CNV_ML > 0,ITE_CNV_ML,1) ) + IF(ITE_CNV_ML > 0, ITE_ML_BAL,0) + ';
    Result := Result + '  	          IFNULL(K.DET_QTDITE,0)) / IF(ITE_CNV_ML > 0,ITE_CNV_ML,1),' + fCfgSis('DECQTD') + ') ';
    Result := Result + '  	 ,NULL) ';

    Result := '(' + Result + ')';
  End;

  Function fSalEmb(blnCaixas:Boolean = True): String;
  Begin
    With recParametros^ Do
    Begin
      If blnQtdCai And blnCaixas Then
        Result := Result + ' ROUND(IF(I.ITE_MLTVEN > 0,' + fSaldos + ' / I.ITE_MLTVEN, 0),2) '
      Else
        Result := Result +  fSaldos + ' ';
    End;

    Result := '(' + Result + ')';
  End;

  Function fValCus : String;
  Begin
    Result := ' ROUND(' + fSQLPrecoCusto(recParametros^, 'G') + ' / IF(I.ITE_FATCNV = 0, 1, I.ITE_FATCNV), ' + fCfgSis('DECUNI') + ')';
    Result := '(' + Result + ')';
  End;

  Function fValVen : String;
  Begin
    With recParametros^ Do
      If Not fEmptyStr(edtTabPre.Text) then
        Result := 'IF(G.ITE_PREVE' + edtTabPre.Text + ' IS NULL, 0, G.ITE_PREVE' + edtTabPre.Text + ')'
      else
        Result := '0';
      Result := '(' + Result + ')';
  End;

  function fIfNull : String;
  Begin
    Result := 'IF( ' + fSaldos + ' IS NOT NULL,';
  End;

  Var
    strSQLItens,
    strSQL : String;
begin

  With recParametros^ Do
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  LEFT(I.ITE_CODGRU,2) AS LINHA, ';
    strSQL := strSQL + '  I.ITE_CODGRU AS GRUPO,         ';
    strSQL := strSQL + '  L.GRU_DESGRU AS NOMLIN, ';
    strSQL := strSQL + '  C.GRU_DESGRU AS NOMGRU, ';
    strSQL := strSQL + '  I.ITE_CODITE AS CODIGO, ';
    strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '  U.UNI_SIGUNI AS UNIDAD, ';
    strSQL := strSQL + '  I.ITE_CODMAR AS CODMAR, ';
    strSQL := strSQL + '  M.MAR_DESMAR AS MARCA,  ';
    strSQL := strSQL + '  G.ITE_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  I.ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '    FOR_NOMFOR AS NOMFOR, ';

    // Req 122910 (DO)
    strSQL := strSQL + '  I.ITE_CLAIPI AS CLAIPI, ';
    strSQL := strSQL + '  G.ITE_TIPPRO AS TIPPRO, ';
    strSQL := strSQL + '  G.ITE_PREVE1 AS PREVE1, ';

    If (fEmptyStr(edtCodEmpresa.Text)) Or (edtCodEmpresa.Text = '000') Then
    Begin
      strSQL := strSQL + '  SUM(IF(G.ITE_CODEMP = :EMPLOG, ' + fSQLPrecoCusto(recParametros^, 'G') + ', 0)) AS PRECUS, ';
      strSQL := strSQL + '  SUM(IF(G.ITE_CODEMP = :EMPLOG, ' + fValVen +                             ', 0)) AS VALVEN, ';
      strSQL := strSQL + '  SUM(IF(G.ITE_CODEMP = :EMPLOG, IF(G.ITE_PREULT IS NULL,0,G.ITE_PREULT), 0))     AS VALULT, ';
      strSQL := strSQL + '  SUM(IF(G.ITE_CODEMP = :EMPLOG, ' + fIfNull + fValCus + ',0), 0))                AS VALCUS, ';
    End Else
    Begin
      strSQL := strSQL + '  ' + fSQLPrecoCusto(recParametros^, 'G') + ' AS PRECUS, ';
      strSQL := strSQL + fValVen +                                    ' AS VALVEN, ';
      strSQL := strSQL + '  IF(G.ITE_PREULT IS NULL,0,G.ITE_PREULT)     AS VALULT, ';
      strSQL := strSQL + fIfNull + fValCus + ',0)                       AS VALCUS, ';
    End;

    strSQL := strSQL + '  CONCAT(IF(IFNULL(LOT_NUMLOT, "") = "", "", CONCAT(LOT_NUMLOT, " / ")), I.ITE_DESITE) AS LOTDES, ';
    strSQL := strSQL + '  IFNULL(LOT_NUMLOT, "") AS NUMLOT, ';

    strSQL := strSQL + '  IF(LOT_NUMLOT IS NULL, G.ITE_LOCFIS, LOT_LOCFIS) AS LOCFIS, ';

    If blnQtdCai Then
    Begin
      strSQL := strSQL + ' (IFNULL(LOT_QTEF_A, 0) + IFNULL(LOT_QTEF_F, 0) + IFNULL(LOT_QTEF_P, 0)) ';
      strSQL := strSQL + ' / IF(I.ITE_MLTVEN <> 0, I.ITE_MLTVEN, 1) AS QTDPEN, ';
    End Else
    Begin
      strSQL := strSQL + '  0.000 AS QTDPEN, ';
    End;

    strSQL := strSQL + 'SUM(' + fSaldos + ')                                                                                AS SALDOS, ';
    strSQL := strSQL + 'SUM(' + fIfNull + fSalEmb + ',0))                                                                   AS SALEMB, ';
    strSQL := strSQL + 'SUM(' + '  IF( COALESCE(IF(TRIM(U.UNI_KILLIT) = "", "L", U.UNI_KILLIT), "L") = "K", ' + fIfNull + fSalEmb + ',0) * U.UNI_PESLIT, 0)) AS TOTKIL, ';
    strSQL := strSQL + 'SUM(' + '  IF( COALESCE(IF(TRIM(U.UNI_KILLIT) = "", "L", U.UNI_KILLIT), "L") = "L", ' + fIfNull + fSalEmb + ',0) * U.UNI_PESLIT, 0)) AS TOTLIT, ';
    strSQL := strSQL + 'SUM(' + fIfNull + fSalEmb + ' * U.UNI_PESLIT ,0))                                                   AS LITRAG, ';
    strSQL := strSQL + 'SUM(' + fIfNull + fSalEmb(False) + ' * IF(G.ITE_PREULT IS NULL,0,G.ITE_PREULT) ,0))                 AS TOTULT, ';
    strSQL := strSQL + 'SUM(' + fIfNull + fSalEmb(False) + ' * ' + fValCus + ' ,0))                                         AS TOTCUS, ';
    strSQL := strSQL + 'SUM(' + fIfNull + fSalEmb(False) + ' * ' + fValVen + ' ,0))                                         AS TOTVEN ';

    strSQL := strSQL + 'FROM ';

    strSQL := strSQL + '  CADITE I ';
    strSQL := strSQL + '  JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';
    strSQL := strSQL + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';
    strSQL := strSQL + '  JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR ';

    strSQL := strSQL + '  LEFT JOIN CADLOT ON LOT_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '                      LOT_CODEMP = G.ITE_CODEMP     ';

    strSQL := strSQL + '  INNER JOIN CADGRU C ON C.GRU_CODGRU = I.ITE_CODGRU ';
    strSQL := strSQL + '  INNER JOIN CADGRU L ON L.GRU_CODGRU = CONCAT(LEFT(I.ITE_CODGRU,3), "000") ';

    strSQL := strSQL + '  LEFT  JOIN CADFOR   ON I.ITE_CODFOR = FOR_CODFOR ';


    strSQL := strSQL + '  LEFT JOIN TMP_KARDEX2 K ON ';

    If blnVazio Then
      strSQL := strSQL + '  FALSE AND ';

    strSQL := strSQL + '        K.DET_CODITE = G.ITE_CODITE ';
    strSQL := strSQL + '    AND K.DET_CODEMP = G.ITE_CODEMP ';
    strSQL := strSQL + '    AND K.DET_NUMLOT = IFNULL(LOT_NUMLOT,"") ';

    strSQL := strSQL + 'WHERE ';

    If blnVazio Then
      strSQL := strSQL + '  FALSE AND ';

    strSQL := strSQL + '  I.ITE_CODITE <> "' + fCfgSis('ITESER') + '" AND ';
    strSQL := strSQL + '  I.ITE_CODITE <> "' + fCfgSis('SERTER') + '"     ';

    strSQL := strSQL + fGetFiltros(recParametros^);

    Case edtSaldos.Text[1] Of
      'P': strSQL := strSQL + ' AND ' + fSaldos + ' > 0 ';
      'N': strSQL := strSQL + ' AND ' + fSaldos + ' < 0 ';
      'Z': strSQL := strSQL + ' AND ' + fSaldos + ' = 0 ';
    End;

    If chkSalAba.Checked Then
      strSQL := strSQL + ' AND ' + fSaldos + ' < :SALABA ';

    If chkSalAci.Checked Then
      strSQL := strSQL + ' AND ' + fSaldos + ' > :SALACI ';

    strSQL := strSQL + ' GROUP BY ';

    strSQL := strSQL + '   I.ITE_CODITE, LOT_NUMLOT ';

    If (edtOpcao.Text = 'S') And (cbxOpcaoSint.ItemIndex = 1) Then
      strSQL := strSQL + ', G.ITE_CODEMP ';

    If edtOpcao.Text = 'S' Then
    Begin
      strSQLItens := strSQL;

      strSQL := '';
      strSQL := strSQL + ' SELECT SQL_NO_CACHE ';

      strSQL := strSQL + '  CODEMP, ';
      strSQL := strSQL + '  CODFOR, ';

      strSQL := strSQL + '  (SELECT  ';
      strSQL := strSQL + '     EMP_NOMEMP ';
      strSQL := strSQL + '   FROM ';
      strSQL := strSQL + '     CADEMP ';
      strSQL := strSQL + '  WHERE EMP_CODEMP = CODEMP ';
      strSQL := strSQL + '    LIMIT 1) AS NOMEMP, ';

      strSQL := strSQL + '  (SELECT  ';
      strSQL := strSQL + '     FOR_NOMFOR ';
      strSQL := strSQL + '   FROM ';
      strSQL := strSQL + '     CADFOR ';
      strSQL := strSQL + '  WHERE FOR_CODFOR = CODFOR ';
      strSQL := strSQL + '    LIMIT 1) AS NOMFOR, ';

      strSQL := strSQL + '  CODMAR, ';
      strSQL := strSQL + '  MARCA, ';

      strSQL := strSQL + ' SUM(IFNULL(SALDOS, 0)) AS SALDOS, ';
      strSQL := strSQL + ' SUM(IFNULL(SALEMB, 0)) AS SALEMB, ';
      strSQL := strSQL + ' SUM(IFNULL(TOTKIL, 0)) AS TOTKIL, ';
      strSQL := strSQL + ' SUM(IFNULL(TOTLIT, 0)) AS TOTLIT, ';
      strSQL := strSQL + ' SUM(IFNULL(LITRAG, 0)) AS LITRAG, ';
      strSQL := strSQL + ' SUM(IFNULL(TOTULT, 0)) AS TOTULT, ';
      strSQL := strSQL + ' SUM(IFNULL(TOTCUS, 0)) AS TOTCUS, ';
      strSQL := strSQL + ' SUM(IFNULL(TOTVEN, 0)) AS TOTVEN ';

      strSQL := strSQL + ' FROM ( ';

      strSQL := strSQL + strSQLItens;

      strSQL := strSQL + ' ) AS TABGRUP ';

      strSQL := strSQL + ' GROUP BY ';

      If cbxOpcaoSint.ItemIndex = 0 Then
        strSQL := strSQL + ' CODFOR '
      Else If cbxOpcaoSint.ItemIndex = 1 Then
        strSQL := strSQL + ' CODEMP '
      Else
        strSQL := strSQL + ' CODMAR ';

    End;

    strSQL := strSQL + ' ORDER BY ';

    If edtOpcao.Text = 'S' Then
    Begin
      If cbxOpcaoSint.ItemIndex = 0 Then
        strSQL := strSQL + ' CODFOR '
      Else If cbxOpcaoSint.ItemIndex = 1 Then
        strSQL := strSQL + ' CODEMP '
      Else
        strSQL := strSQL + ' CODMAR ';

    End Else
    Begin
      Case cbxQuebra.ItemIndex Of
        1: strSQL := strSQL + '  I.ITE_CODGRU, ';
        2: strSQL := strSQL + '  NOMFOR,       ';
        3: strSQL := strSQL + '  MARCA,        ';
      End;

      strSQL := strSQL + '  I.ITE_DESITE ';
    End;

  End;

  Result := strSQL;
End;

end.

