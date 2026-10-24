unit untCadNegBussiness;

interface

Uses
  System.SysUtils, Uni, System.Classes, System.DateUtils, Data.DB;

Type
  TCadNegBussiness = class
  Private
    class function fGetFiltroTabelaPrecoNegociacao(strTabPre: String): String;
    class function fSqlWhere(strCodNeg, strTabPre: String): String;
  Public
    class function fItemCadastradoNegociacao(strCodNeg, strCodCli, strCodIte, strTabPre: String;
      Var strMsgCli: String; Var strMsgPro: String): Boolean;
    class function fItemQtdCadastradoNegociacao(strCodNeg, strCodCli,
      strCodIte: String; fltQtdDig: Double): Boolean;

    class function fRetornaPrecoNegociacao(strCodCli, strCodIte, strTabPre, strCodEmp: String;
      Var fltPreVen: Double; fltQtdDig: Double = 0; Conexao: TUniConnection = Nil): Boolean;

    class function fClienteTemNegociacaoVinculada(strCodCli: String): Boolean;
    class function fItemSemNenhumaNegociacao(strCodIte: String; Conexao: TUniConnection = Nil): Boolean;
    class function fRetornaSomenteItensEmNegociacaoDaLista(strLisCodIteOrc: String; Conexao: TUniConnection = Nil): TStringList;
    class function fClienteAndProdutoTemNegociacaoVinculada(strCodCli, strCodIte: String): Boolean;
  End;

implementation

{ TCadNegBussiness }

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core, untFuncoesGenerica;
{$ELSE}
  untFuncoesSimples;
{$ENDIF}

class function TCadNegBussiness.fClienteAndProdutoTemNegociacaoVinculada(
  strCodCli, strCodIte: String): Boolean;
  Var
    qryTmp: TUniQuery;
begin
  If (fCampoTabela('COUNT(*)', 'CADNEG', ['NEG_STATUS'], ['A'], False) = 0) Then
  Begin
    Result := False;
    Exit;
  End;

  Try
    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      If (Not fEmptyStr(strCodCli)) And (Not fEmptyStr(strCodIte)) Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT   ');
        SQL.Add('   CADNEG.AUTOINCREM   ');
        SQL.Add(' FROM     ');
        SQL.Add('   CADNEG ');
        SQL.Add(' JOIN CLINEG ON (CLINEG.CLI_SEQGER = CADNEG.AUTOINCREM) ');
        SQL.Add(' JOIN ITENEG ON (ITENEG.ITE_SEQGER = CADNEG.AUTOINCREM) ');
        SQL.Add(' WHERE ');
        SQL.Add('   CLI_CODCLI = :CODCLI AND ');
        SQL.Add('   ITE_CODITE = :CODITE AND ');
        SQL.Add('   NEG_STATUS = "A"         ');

        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('CODITE').AsString := strCodIte;

        Open;

        Result := Not IsEmpty;
      End
      Else
        Result := False;

      If Not Result Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT   ');
        SQL.Add('   CADNEG.AUTOINCREM   ');
        SQL.Add(' FROM     ');
        SQL.Add('   CADNEG ');
        SQL.Add(' LEFT JOIN CLINEG ON (CLINEG.CLI_SEQGER = CADNEG.AUTOINCREM) ');
        SQL.Add(' JOIN ITENEG ON (ITENEG.ITE_SEQGER = CADNEG.AUTOINCREM) ');
        SQL.Add(' WHERE ');
        SQL.Add('   COALESCE(CLI_CODCLI, "") = "" AND ');
        SQL.Add('   ITE_CODITE = :CODITE          AND ');
        SQL.Add('   NEG_STATUS = "A"                  ');

        ParamByName('CODITE').AsString := strCodIte;

        Open;

        Result := Not IsEmpty;
      End;
    End;
  Except
    On E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(qryTmp);
end;

class function TCadNegBussiness.fClienteTemNegociacaoVinculada(
  strCodCli: String): Boolean;
  Var
    qryTmp: TUniQuery;
begin
  If (fCampoTabela('COUNT(*)', 'CADNEG', ['NEG_STATUS'], ['A'], False) = 0) Then
  Begin
    Result := False;
    Exit;
  End;

  Try
    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      If (Not fEmptyStr(strCodCli)) Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT   ');
        SQL.Add('   CADNEG.AUTOINCREM   ');
        SQL.Add(' FROM     ');
        SQL.Add('   CADNEG ');
        SQL.Add(' INNER JOIN CLINEG ON (CLINEG.CLI_SEQGER = CADNEG.AUTOINCREM) ');
        SQL.Add(' WHERE ');
        SQL.Add('   CLI_CODCLI = :CODCLI AND ');
        SQL.Add('   NEG_STATUS = "A"         ');

        ParamByName('CODCLI').AsString := strCodCli;

        Open;

        Result := Not IsEmpty;
      End
      Else
        Result := False;

      If Not Result Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT   ');
        SQL.Add('   CADNEG.AUTOINCREM   ');
        SQL.Add(' FROM     ');
        SQL.Add('   CADNEG ');
        SQL.Add(' LEFT JOIN CLINEG ON (CLINEG.CLI_SEQGER = CADNEG.AUTOINCREM) ');
        SQL.Add(' WHERE ');
        SQL.Add('   COALESCE(CLI_CODCLI, "") = "" AND ');
        SQL.Add('   NEG_STATUS = "A"                  ');
        Open;

        Result := Not IsEmpty;
      End;
    End;
  Except
    On E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(qryTmp);
end;

class function TCadNegBussiness.fGetFiltroTabelaPrecoNegociacao(
  strTabPre: String): String;
  Var
    intTab: Integer;
begin
  Result := '';
  //Negociacao da tabela de preco informada ou que nao estejam vinculadas a nenhuma tabela de preco
  If Not fEmptyStr(strTabPre) Then
  Begin
    //Caso veio por parametro o numero da tabela de preco
    If CharInSet(strTabPre[1], ['1'..'7']) Then
    Begin
      Result := ' AND MID(NEG_TABPRE, ' +  strTabPre + ', 1) = "S" '; //Exemplo: tabela 3 "NNSNNNN"
    End
    //caso veio por exemplo 'NNSNNSS' (Usa as tabelas 3, 6 e 7)
    Else If Pos('S', strTabPre) > 0 Then
    Begin
      For intTab := 1 To Length(strTabPre) Do
      Begin
        If strTabPre[intTab] = 'S' Then
        Begin
          If Not fEmptyStr(Result) Then
            Result := Result + ' OR ';
          Result := Result + ' (MID(NEG_TABPRE, ' +  intToStr(intTab) + ', 1) = "S") '; //Exemplo: Tabela 3 "NNSNNNN"
        End;
      End;

      Result := ' AND ( ' + Result + ' ) ';
    End;
  End;
end;

class function TCadNegBussiness.fItemCadastradoNegociacao(strCodNeg, strCodCli,
  strCodIte, strTabPre: String; var strMsgCli: String; Var strMsgPro: String): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
    stlCli,
    stlPro: TStringList;
begin
  stlCli := TStringList.Create;
  stlPro := TStringList.Create;

  Try
    strMsgCli := '';
    strMsgPro := '';

    strSQL := '';

    stlCli.Clear;
    stlPro.Clear;
    qryGen := fCriaQuery(nil);

    If fEmptyStr(strCodCli) Then
    Begin
      // NEGOCIACAO SEM CLIENTES (PARA TODOS)
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  DISTINCT NEG_CODNEG, ITE_CODITE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADNEG P ';
      strSQL := strSQL + '  INNER JOIN ITENEG    ON P.AUTOINCREM = ITENEG.ITE_SEQGER ';
      strSQL := strSQL + '  LEFT  JOIN CLINEG C  ON P.AUTOINCREM = C.CLI_SEQGER ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + fSqlWhere(strCodNeg, strTabPre);
      strSQL := strSQL + ' AND NEG_STATUS = "A"     ';
      strSQL := strSQL + ' AND C.CLI_CODCLI IS NULL ';
    End
    Else
    Begin
      // PROMOCOES PARA CLIENTES ESPECIFICOS
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  DISTINCT NEG_CODNEG, C.CLI_CODCLI AS CLI_CODCLI, ITE_CODITE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADNEG P ';
      strSQL := strSQL + '  INNER JOIN ITENEG    ON P.AUTOINCREM = ITENEG.ITE_SEQGER ';
      strSQL := strSQL + '  INNER JOIN CLINEG C  ON P.AUTOINCREM = C.CLI_SEQGER AND   ';
      strSQL := strSQL + '                          (LOCATE(C.CLI_CODCLI, :CODCLI) > 0) ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  NEG_STATUS = "A" AND ';
      strSQL := strSQL + fSqlWhere(strCodNeg, strTabPre);
    End;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;

      If Not fEmptyStr(strCodCli) Then
        ParamByName('CODCLI').AsString := strCodCli;

      If (Not fEmptyStr(strCodNeg)) Then
        ParamByName('CODNEG').AsString := strCodNeg;

      Open;

      If (RecordCount > 0) Then
      Begin
        Repeat
          If (Not fEmptyStr(strCodCli)) Then
          Begin
            strMsgCli := FieldByName('CLI_CODCLI').AsString + ' - ' + Trim(fRetNomCliente(FieldByName('CLI_CODCLI').AsString));

            If stlCli.IndexOf(strMsgCli) < 0 Then
              stlCli.Add(strMsgCli);
          End;

          If (Not fEmptyStr(strCodIte)) Then
          Begin
            strMsgPro := FieldByName('ITE_CODITE').AsString + ' - ' + Trim(fRetNomProduto(FieldByName('ITE_CODITE').AsString));

            If stlPro.IndexOf(strMsgPro) < 0 Then
              stlPro.Add(strMsgPro);
          End;

          Next;
        Until Eof;

        If (Not fEmptyStr(strCodCli)) And (stlCli.Count > 0) Then
          strMsgCli := stlCli.CommaText
        Else
          strMsgCli := '';

        If (Not fEmptyStr(strCodIte)) And (stlPro.Count > 0) Then
          strMsgPro := stlPro.CommaText
        Else
          strMsgPro := '';
      End;

      Result := (RecordCount > 0);
      Close;
    End;
  Finally
    FreeAndNil(qryGen);
    FreeAndNil(stlCli);
    FreeAndNil(stlPro);
  End;
end;

class function TCadNegBussiness.fItemQtdCadastradoNegociacao(strCodNeg, strCodCli,
  strCodIte: String; fltQtdDig: Double): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin

  Try

    strSQL := '';

    qryGen := fCriaQuery(nil);

    If fEmptyStr(strCodCli) Then
    Begin
      // NEGOCIACAO SEM CLIENTES (PARA TODOS)
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  DISTINCT NEG_CODNEG, ITE_CODITE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADNEG P ';
      strSQL := strSQL + '  INNER JOIN QTDNEG Q  ON P.AUTOINCREM = Q.ITE_SEQGER ';
      strSQL := strSQL + '  LEFT  JOIN CLINEG C  ON P.AUTOINCREM = C.CLI_SEQGER ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ITE_CODITE = :CODITE ';
      If (Not fEmptyStr(strCodNeg)) Then
        strSQL := strSQL + '  AND NEG_CODNEG <> :CODNEG ';
      strSQL := strSQL + ' AND NEG_STATUS = "A"     ';
      strSQL := strSQL + ' AND C.CLI_CODCLI IS NULL ';
      strSQL := strSQL + ' AND ITE_QTDITE = :QTDITE ';
    End
    Else
    Begin
      // PROMOCOES PARA CLIENTES ESPECIFICOS
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  DISTINCT NEG_CODNEG, C.CLI_CODCLI AS CLI_CODCLI, ITE_CODITE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADNEG P ';
      strSQL := strSQL + '  INNER JOIN QTDNEG Q  ON P.AUTOINCREM = Q.ITE_SEQGER ';
      strSQL := strSQL + '  INNER JOIN CLINEG C  ON P.AUTOINCREM = C.CLI_SEQGER AND   ';
      strSQL := strSQL + '                          (LOCATE(C.CLI_CODCLI, :CODCLI) > 0) ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ITE_CODITE = :CODITE ';
      If (Not fEmptyStr(strCodNeg)) Then
        strSQL := strSQL + '  AND NEG_CODNEG <> :CODNEG ';
      strSQL := strSQL + ' AND NEG_STATUS = "A"     ';
      strSQL := strSQL + ' AND ITE_QTDITE = :QTDITE ';
    End;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;

      If Not fEmptyStr(strCodCli) Then
        ParamByName('CODCLI').AsString := strCodCli;

      If (Not fEmptyStr(strCodNeg)) Then
        ParamByName('CODNEG').AsString := strCodNeg;

      ParamByName('QTDITE').AsFloat := fltQtdDig;

      Open;
      Result := (RecordCount > 0);
      Close;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

class function TCadNegBussiness.fItemSemNenhumaNegociacao(
  strCodIte: String; Conexao: TUniConnection = Nil): Boolean;
Var
  strSQL: String;
  qryTmp: TUniQuery;
begin
  If fEmptyStr(strCodIte) Then
  Begin
    Result := True;
    Exit;
  End;

  If (fCampoTabela('COUNT(*)', 'CADNEG', ['NEG_STATUS'], ['A'], False) = 0) Then
  Begin
    Result := True;
    Exit;
  End;

  Try
    If Assigned(Conexao) Then
      qryTmp := fCriaQuery(nil, Conexao)
    Else
      qryTmp := fCriaQuery(nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  NEG_CODNEG ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADNEG  ';
    strSQL := strSQL + '  INNER JOIN ITENEG ON CADNEG.AUTOINCREM = ITENEG.ITE_SEQGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  NEG_STATUS = "A" AND ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';
    strSQL := strSQL + 'LIMIT 1 ';

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;

      Open;
      Result := (RecordCount = 0);
      Close;

      If Result Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  NEG_CODNEG ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  CADNEG  ';
        strSQL := strSQL + '  INNER JOIN QTDNEG ON CADNEG.AUTOINCREM = QTDNEG.ITE_SEQGER ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  NEG_STATUS = "A" AND ';
        strSQL := strSQL + '  ITE_CODITE = :CODITE ';
        strSQL := strSQL + 'LIMIT 1 ';

        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODITE').AsString := strCodIte;

        Open;
        Result := (RecordCount = 0);
        Close;
      End;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
end;

class function TCadNegBussiness.fRetornaSomenteItensEmNegociacaoDaLista(strLisCodIteOrc: String; 
  Conexao: TUniConnection = Nil): TStringList;
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  Result := TStringList.Create;

  If fEmptyStr(strLisCodIteOrc) Then
    Exit;

  If (fCampoTabela('COUNT(*)', 'CADNEG', ['NEG_STATUS'], ['A'], False) = 0) Then
    Exit;

  Try
    If Assigned(Conexao) Then
      qryTmp := fCriaQuery(nil, Conexao)
    Else
      qryTmp := fCriaQuery(nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_CODITE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADNEG  ';
    strSQL := strSQL + '  INNER JOIN ITENEG ON CADNEG.AUTOINCREM = ITENEG.ITE_SEQGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  NEG_STATUS = "A" AND ';
    strSQL := strSQL + '  ITE_CODITE IN ('+strLisCodIteOrc+')';

    strSQL := strSQL + ' UNION ALL ';

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_CODITE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADNEG  ';
    strSQL := strSQL + '  INNER JOIN QTDNEG ON CADNEG.AUTOINCREM = QTDNEG.ITE_SEQGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  NEG_STATUS = "A" AND ';
    strSQL := strSQL + '  ITE_CODITE IN ('+strLisCodIteOrc+')';

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      Open;
      If Not qryTmp.IsEmpty Then
      Begin 
        First;

        While Not Eof Do
        Begin
          Result.Add(FieldByName('ITE_CODITE').AsString);

          Next;
        End;
      End;
      Close;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
End;  

class function TCadNegBussiness.fRetornaPrecoNegociacao(strCodCli, strCodIte,
  strTabPre, strCodEmp: String; Var fltPreVen: Double; fltQtdDig: Double = 0; Conexao: TUniConnection = Nil): Boolean;
  Var
    qryTmp: TUniQuery;
    strSQL,
    strTab: String;
    blnTemDes: Boolean;

  function fGetSQLTabPrecoClienteEspecifico: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ';
    Result := Result + '   TAB_PERCEN, ';
    Result := Result + '   TAB_TIPDES  ';
    Result := Result + ' FROM          ';
    Result := Result + '   CADNEG      ';
    Result := Result + ' JOIN TABNEG ON (CADNEG.AUTOINCREM = TABNEG.TAB_SEQGER AND TAB_TABPRE = :TABPRE) ';
    Result := Result + ' JOIN CLINEG ON (CADNEG.AUTOINCREM = CLINEG.CLI_SEQGER) ';
    Result := Result + ' JOIN ITENEG ON (CADNEG.AUTOINCREM = ITENEG.ITE_SEQGER) ';
    Result := Result + ' WHERE ';
    Result := Result + '   NEG_STATUS = "A"     AND ';
    Result := Result + '   CLI_CODCLI = :CODCLI AND ';
    Result := Result + '   ITE_CODITE = :CODITE     ';
    Result := Result + strTab;
    Result := Result + ' ORDER BY ';
    Result := Result + '   TAB_TIPDES DESC, TAB_ORDDES ASC ';
  End;

  function fGetSQLTabPrecoTodosCliente: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ';
    Result := Result + '   TAB_PERCEN, ';
    Result := Result + '   TAB_TIPDES  ';
    Result := Result + ' FROM          ';
    Result := Result + '   CADNEG      ';
    Result := Result + ' JOIN TABNEG ON (CADNEG.AUTOINCREM = TABNEG.TAB_SEQGER AND TAB_TABPRE = :TABPRE) ';
    Result := Result + ' LEFT JOIN CLINEG ON (CADNEG.AUTOINCREM = CLINEG.CLI_SEQGER) ';
    Result := Result + ' JOIN ITENEG ON (CADNEG.AUTOINCREM = ITENEG.ITE_SEQGER) ';
    Result := Result + ' WHERE ';
    Result := Result + '   NEG_STATUS = "A"                AND ';
    Result := Result + '   (COALESCE(CLI_CODCLI, "") = "") AND ';
    Result := Result + '   ITE_CODITE = :CODITE                ';
    Result := Result + strTab;
    Result := Result + ' ORDER BY ';
    Result := Result + '   TAB_TIPDES DESC, TAB_ORDDES ASC ';
  End;

  function fGetSQLCompraClienteEspecifico: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ';
    Result := Result + '   CMP_PERDES ';
    Result := Result + ' FROM          ';
    Result := Result + '   CADNEG     ';
    Result := Result + ' JOIN CMPNEG ON (CADNEG.AUTOINCREM = CMPNEG.CMP_SEQGER) ';
    Result := Result + ' JOIN CLINEG ON (CADNEG.AUTOINCREM = CLINEG.CLI_SEQGER) ';
    Result := Result + ' JOIN ITENEG ON (CADNEG.AUTOINCREM = ITENEG.ITE_SEQGER) ';
    Result := Result + ' WHERE ';
    Result := Result + '   NEG_STATUS = "A"     AND ';
    Result := Result + '   CLI_CODCLI = :CODCLI AND ';
    Result := Result + '   ITE_CODITE = :CODITE AND ';
    Result := Result + '   "' + FormatDateTime('yyyy-mm-dd', VS_Date) + '"' +
                       ' BETWEEN CONCAT("' + FormatDateTime('yyyy-mm-', VS_Date) + '", CMP_DIAINI) AND CONCAT("' + FormatDateTime('yyyy-mm-', VS_Date) + '", CMP_DIAFIM) ';
    Result := Result + ' ORDER BY ';
    Result := Result + '   CMP_ORDDES ASC ';
  End;

  function fGetSQLCompraTodosCliente: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ';
    Result := Result + '   CMP_PERDES ';
    Result := Result + ' FROM          ';
    Result := Result + '   CADNEG     ';
    Result := Result + ' JOIN CMPNEG ON (CADNEG.AUTOINCREM = CMPNEG.CMP_SEQGER) ';
    Result := Result + ' LEFT JOIN CLINEG ON (CADNEG.AUTOINCREM = CLINEG.CLI_SEQGER) ';
    Result := Result + ' JOIN ITENEG ON (CADNEG.AUTOINCREM = ITENEG.ITE_SEQGER) ';
    Result := Result + ' WHERE ';
    Result := Result + '   NEG_STATUS = "A"                AND ';
    Result := Result + '   (COALESCE(CLI_CODCLI, "") = "") AND ';
    Result := Result + '   ITE_CODITE = :CODITE            AND ';
    Result := Result + '   "' + FormatDateTime('yyyy-mm-dd', VS_Date) + '"' +
                       ' BETWEEN CONCAT("' + FormatDateTime('yyyy-mm-', VS_Date) + '", CMP_DIAINI) AND CONCAT("' + FormatDateTime('yyyy-mm-', VS_Date) + '", CMP_DIAFIM) ';
    Result := Result + ' ORDER BY ';
    Result := Result + '   CMP_ORDDES ASC ';
  End;

  function fGetSQLDescontoItemClienteEspecifico: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ';
    Result := Result + '   ITE_PERITE ';
    Result := Result + ' FROM         ';
    Result := Result + '   CADNEG     ';
    Result := Result + ' JOIN CLINEG ON (CADNEG.AUTOINCREM = CLINEG.CLI_SEQGER) ';
    Result := Result + ' JOIN ITENEG ON (CADNEG.AUTOINCREM = ITENEG.ITE_SEQGER) ';
    Result := Result + ' WHERE ';
    Result := Result + '   NEG_STATUS = "A"     AND ';
    Result := Result + '   CLI_CODCLI = :CODCLI AND ';
    Result := Result + '   ITE_CODITE = :CODITE     ';
  End;

  function fGetSQLDescontoItemTodosCliente: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ';
    Result := Result + '   ITE_PERITE ';
    Result := Result + ' FROM         ';
    Result := Result + '   CADNEG     ';
    Result := Result + ' LEFT JOIN CLINEG ON (CADNEG.AUTOINCREM = CLINEG.CLI_SEQGER) ';
    Result := Result + '      JOIN ITENEG ON (CADNEG.AUTOINCREM = ITENEG.ITE_SEQGER) ';
    Result := Result + ' WHERE ';
    Result := Result + '   NEG_STATUS = "A"                AND ';
    Result := Result + '   (COALESCE(CLI_CODCLI, "") = "") AND ';
    Result := Result + '   ITE_CODITE = :CODITE                ';
  End;

  function fGetSQLDescontoQtdItemClienteEspecifico: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ';
    Result := Result + '   ITE_PERITE,';
    Result := Result + '   ITE_QTDITE ';
    Result := Result + ' FROM         ';
    Result := Result + '   CADNEG     ';
    Result := Result + ' JOIN CLINEG ON (CADNEG.AUTOINCREM = CLINEG.CLI_SEQGER) ';
    Result := Result + ' JOIN QTDNEG ON (CADNEG.AUTOINCREM = QTDNEG.ITE_SEQGER) ';
    Result := Result + ' WHERE ';
    Result := Result + '   NEG_STATUS = "A"     AND ';
    Result := Result + '   CLI_CODCLI = :CODCLI AND ';
    Result := Result + '   ITE_CODITE = :CODITE     ';
    Result := Result + ' ORDER BY ITE_QTDITE DESC   ';
  End;

  function fGetSQLDescontoQtdItemTodosCliente: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ';
    Result := Result + '   ITE_PERITE,';
    Result := Result + '   ITE_QTDITE ';
    Result := Result + ' FROM         ';
    Result := Result + '   CADNEG     ';
    Result := Result + ' LEFT JOIN CLINEG ON (CADNEG.AUTOINCREM = CLINEG.CLI_SEQGER) ';
    Result := Result + '      JOIN QTDNEG ON (CADNEG.AUTOINCREM = QTDNEG.ITE_SEQGER) ';
    Result := Result + ' WHERE ';
    Result := Result + '   NEG_STATUS = "A"                AND ';
    Result := Result + '   (COALESCE(CLI_CODCLI, "") = "") AND ';
    Result := Result + '   ITE_CODITE = :CODITE                ';
    Result := Result + ' ORDER BY ITE_QTDITE DESC              ';
  End;

  procedure pAplicaDescontoAcrescimoTabPrecos(strTipo: String);
  Begin
    With qryTmp Do
    Begin
      First;

      While Not Eof Do
      Begin
        If Not fEmptyStr(FieldByName('TAB_TIPDES').AsString) Then
        Begin
          If SameText(strTipo, 'D') Then
          Begin
            If SameText(FieldByName('TAB_TIPDES').AsString, strTipo) Then
              fltPreVen := fltPreVen - ((fltPreVen * FieldByName('TAB_PERCEN').AsFloat) / 100);
          End
          Else
          Begin
            If SameText(FieldByName('TAB_TIPDES').AsString, strTipo) Then
              fltPreVen := fltPreVen + ((fltPreVen * FieldByName('TAB_PERCEN').AsFloat) / 100);
          End;
        End;

        Next;
      End;
    End;
  End;

begin
  Try
    Result := False;

    If fEmptyStr(strCodCli) And fEmptyStr(strCodIte) And fEmptyStr(strTabPre) Then
      Exit;

    If (fCampoTabela('COUNT(*)', 'CADNEG', ['NEG_STATUS'], ['A'], False) = 0) Then
      Exit;

    If fItemSemNenhumaNegociacao(strCodIte, Conexao) then
      Exit;

    If Assigned(Conexao) Then
      qryTmp := fCriaQuery(Nil, Conexao)
    Else
      qryTmp := fCriaQuery;

    If Not fEmptyStr(strTabPre) Then
    Begin
      If CharInSet(strTabPre[1], ['1'..'7']) Then
        strTab := ' AND (MID(NEG_TABPRE, ' +  strTabPre + ', 1) = "S") '; //Exemplo: tabela 3 "NNSNNNN"
    End;

    fltPreVen := fRetPrecoVenda(strCodIte, IIF(fEmptyStr(strTabPre), '1', strTabPre), strCodEmp, Conexao);

    strSQL := fGetSQLTabPrecoClienteEspecifico;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('TABPRE').AsString := strTabPre;
      Open;

      blnTemDes := Not IsEmpty;

      If Not blnTemDes Then
      Begin
        strSQL := fGetSQLTabPrecoTodosCliente;

        Close;
        SQL.Clear;
        Params.Clear;
        SQL.Add(strSQL);
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('TABPRE').AsString := strTabPre;
        Open;

        blnTemDes := Not IsEmpty;
      End;

      If blnTemDes Then
      Begin
        // PRIMEIRO APLICA OS DESCONTOS DA TABELA DE PREÇOS
        pAplicaDescontoAcrescimoTabPrecos('D');

        // SEGUNDO APLICA OS ACRÉSCIMOS DA TABELA DE PREÇOS
        pAplicaDescontoAcrescimoTabPrecos('A');

        Result := True;
      End;
    End;

    strSQL := fGetSQLCompraClienteEspecifico;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      Params.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      blnTemDes := Not IsEmpty;

      If Not blnTemDes Then
      Begin
        strSQL := fGetSQLCompraTodosCliente;

        Close;
        SQL.Clear;
        Params.Clear;
        SQL.Add(strSQL);
        ParamByName('CODITE').AsString := strCodIte;
        Open;

        blnTemDes := Not IsEmpty;
      End;

      If blnTemDes Then
      Begin
        // TERCEIRO APLICA OS DESCONTOS DA POR DATA DE COMPRA
        First;

        While Not Eof Do
        Begin
          fltPreVen := fltPreVen - ((fltPreVen * FieldByName('CMP_PERDES').AsFloat) / 100);

          Next;
        End;

        Result := True;
      End;
    End;

    strSQL := fGetSQLDescontoItemClienteEspecifico;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      Params.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      blnTemDes := Not IsEmpty;

      If Not blnTemDes Then
      Begin
        strSQL := fGetSQLDescontoItemTodosCliente;

        Close;
        SQL.Clear;
        Params.Clear;
        SQL.Add(strSQL);
        ParamByName('CODITE').AsString := strCodIte;
        Open;

        blnTemDes := Not IsEmpty;
      End;

      If blnTemDes And (FieldByName('ITE_PERITE').AsFloat > 0) Then
      Begin
        // QURTO APLICA OS DESCONTOS ESPECÍFICO DO ITEM
        First;

        While Not Eof Do
        Begin
          fltPreVen := fltPreVen - ((fltPreVen * FieldByName('ITE_PERITE').AsFloat) / 100);

          Next;
        End;

        Result := True;
      End;
    End;

    // verifica negociação por quantidade

    strSQL := fGetSQLDescontoQtdItemClienteEspecifico;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      Params.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      blnTemDes := Not IsEmpty;

      If Not blnTemDes Then
      Begin
        strSQL := fGetSQLDescontoQtdItemTodosCliente;

        Close;
        SQL.Clear;
        Params.Clear;
        SQL.Add(strSQL);
        ParamByName('CODITE').AsString := strCodIte;
        Open;

        blnTemDes := Not IsEmpty;
      End;

      If blnTemDes And (FieldByName('ITE_PERITE').AsFloat > 0) Then
      Begin
        // QUINTO APLICA OS DESCONTOS DO ITEM POR QUANTIDADE
        First;

        While Not Eof Do
        Begin
          If fltQtdDig >= FieldByName('ITE_QTDITE').AsFloat Then
          Begin
            fltPreVen := fltPreVen - ((fltPreVen * FieldByName('ITE_PERITE').AsFloat) / 100);

            Break;
          End;

          Next;
        End;

        Result := True;
      End;
    End;

  Except
    On E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(qryTmp);
end;

class function TCadNegBussiness.fSqlWhere(strCodNeg, strTabPre: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + '  ITE_CODITE = :CODITE ';

  If (Not fEmptyStr(strCodNeg)) Then
    strSQL := strSQL + '  AND NEG_CODNEG <> :CODNEG ';

  strSQL := strSQL + fGetFiltroTabelaPrecoNegociacao(strTabPre);

  Result := strSQL;
end;

end.
