unit untGeraInventarioFin;

interface

Uses
  Classes, SysUtils, Uni, StrUtils, Controls,
  Forms, cxProgressBar;

Type

  TGeraInventarioFin = Class(TComponent)
    private
      strAnoInv, strMesInv : String;

     Function fGeraInventarioFinanceiro(pgbProgresso: TcxProgressBar): Boolean;

    protected

    public

      Procedure pGeraInventarioFinanceiro(strAno, strMes: String);
  End;


implementation

uses untFuncoesSimples,untFuncoes,untGravando;

Procedure TGeraInventarioFin.pGeraInventarioFinanceiro(strAno, strMes: String);
Begin
  strAnoInv := strAno;
  strMesInv := strMes;

  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, gerando Inventário Financeiro...';
  frmGravando.fExecutarAcao := fGeraInventarioFinanceiro;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Function TGeraInventarioFin.fGeraInventarioFinanceiro(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strSQL    : String;
    strNomTab : String;
    qryGenAux : TUniQuery;
Begin

  qryGenAux := fCriaQuery(Self);

  pgbProgresso.Position       := 0;
  pgbProgresso.Properties.Max := 9;
  Application.ProcessMessages;

  Try

    {******************************}
    {* GERA INVENTARIO DE CTR     *}
    {***************************IV*}
    strNomTab := 'CTR_'  + strAnoInv + strMesInv;

    If Not fTabelaExiste(strNomTab) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'CREATE TABLE ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *    ';
      strSQL := strSQL + '     FROM CADREC  LIMIT 0 ) ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    If Not fTemInvFin(strNomTab, 'CTR') Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *  ';
      strSQL := strSQL + '     FROM CADREC          ';
      strSQL := strSQL + '   WHERE                  ';
      strSQL := strSQL + '     CTR_DTAREC IS NULL ) ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    pgbProgresso.Position       := pgbProgresso.Position + 1;
    Application.ProcessMessages;

    {******************************}
    {* GERA INVENTARIO DE CTP     *}
    {***************************IV*}
    strNomTab := 'CTP_'  + strAnoInv + strMesInv;

    If Not fTabelaExiste(strNomTab) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'CREATE TABLE ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *    ';
      strSQL := strSQL + '     FROM CADPAG  LIMIT 0 ) ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    If Not fTemInvFin(strNomTab, 'CTP') Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *  ';
      strSQL := strSQL + '     FROM CADPAG          ';
      strSQL := strSQL + '   WHERE                  ';
      strSQL := strSQL + '     CTP_DTAPAG IS NULL ) ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    pgbProgresso.Position       := pgbProgresso.Position + 1;
    Application.ProcessMessages;

    {******************************}
    {* GERA INVENTARIO DE CTPX    *}
    {***************************IV*}
    strNomTab := 'CTPX_' + strAnoInv + strMesInv;

    If Not fTabelaExiste(strNomTab) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'CREATE TABLE ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *    ';
      strSQL := strSQL + '     FROM CADPAG LIMIT 0 ) ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    If Not fTemInvFin(strNomTab, 'CTP') Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *  ';
      strSQL := strSQL + '     FROM CADPAG         ';
      strSQL := strSQL + '   WHERE                  ';
      strSQL := strSQL + '     CTP_DTAPAG IS NULL ) ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    pgbProgresso.Position       := pgbProgresso.Position + 1;
    Application.ProcessMessages;

    {******************************}
    {* GERA INVENTARIO DE CAR     *}
    {***************************IV*}
    strNomTab := 'CAR_'  + strAnoInv + strMesInv;

    If Not fTabelaExiste(strNomTab) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'CREATE TABLE ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *    ';
      strSQL := strSQL + '     FROM MOVCAR  LIMIT 0 ) ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    If Not fTemInvFin(strNomTab, 'MCA') Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *  ';
      strSQL := strSQL + '     FROM MOVCAR          ';
      strSQL := strSQL + '   WHERE                  ';
      strSQL := strSQL + '     MCA_DTAREC IS NULL ) ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    pgbProgresso.Position       := pgbProgresso.Position + 1;
    Application.ProcessMessages;

    {******************************}
    {* GERA INVENTARIO DE CHQ     *}
    {***************************IV*}
    strNomTab := 'CHQ_'  + strAnoInv + strMesInv;

    If Not fTabelaExiste(strNomTab) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'CREATE TABLE ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *    ';
      strSQL := strSQL + '     FROM CADCHQ  LIMIT 0 ) ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    If Not fTemInvFin(strNomTab, 'CHQ') Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *  ';
      strSQL := strSQL + '     FROM CADCHQ          ';
      strSQL := strSQL + '   WHERE                  ';
      strSQL := strSQL + '     CHQ_DTADEP IS NULL ) ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    pgbProgresso.Position       := pgbProgresso.Position + 1;
    Application.ProcessMessages;

    {******************************}
    {* GERA INVENTARIO DE FGO     *}
    {***************************IV*}
    strNomTab := 'FGO_' + strAnoInv + strMesInv;

    If Not fTabelaExiste(strNomTab) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'CREATE TABLE ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *    ';
      strSQL := strSQL + '     FROM FATGOR LIMIT 0 ) ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    If Not fTemInvFin(strNomTab, 'FGO') Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *    ';
      strSQL := strSQL + '     FROM FATGOR            ';
      strSQL := strSQL + '   WHERE                    ';
      strSQL := strSQL + '     FGO_JAFATU = 0    AND  ';
      strSQL := strSQL + '     FGO_ESPDOC = "PD" )   ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    pgbProgresso.Position       := pgbProgresso.Position + 1;
    Application.ProcessMessages;

    {******************************}
    {* GERA INVENTARIO DE FDO     *}
    {***************************IV*}
    strNomTab := 'FDO_' + strAnoInv + strMesInv;

    If Not fTabelaExiste(strNomTab) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'CREATE TABLE ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *    ';
      strSQL := strSQL + '     FROM FATDOR LIMIT 0 ) ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    If Not fTemInvFin(strNomTab, 'FDO') Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *    ';
      strSQL := strSQL + '     FROM FATDOR            ';
      strSQL := strSQL + '   WHERE                    ';
      strSQL := strSQL + '     FDO_JAFATU = 0    AND  ';
      strSQL := strSQL + '     FDO_ESPDOC = "PD" )   ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    pgbProgresso.Position       := pgbProgresso.Position + 1;
    Application.ProcessMessages;

    {*********************************}
    {* GERA INVENTARIO DE PED.COMPRA *}
    {******************************IV*}
    strNomTab := 'PCG_' + strAnoInv + strMesInv;

    If Not fTabelaExiste(strNomTab) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'CREATE TABLE ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *    ';
      strSQL := strSQL + '     FROM PCMGER LIMIT 0 ) ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    If Not fTemInvFin(strNomTab, 'PCG') Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *       ';
      strSQL := strSQL + '     FROM PCMGER               ';
      strSQL := strSQL + '   WHERE                       ';
      strSQL := strSQL + '    ( PCG_BAIXAD <> 1 OR       ';
      strSQL := strSQL + '      PCG_BAIXAD IS NULL ) AND ';
      strSQL := strSQL + '     PCG_ESPDOC = "PD" )       ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    pgbProgresso.Position       := pgbProgresso.Position + 1;
    Application.ProcessMessages;

    {******************************}
    {* GERA INVENTARIO DE FDO     *}
    {***************************IV*}
    strNomTab := 'PCD_' + strAnoInv + strMesInv;

    If Not fTabelaExiste(strNomTab) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'CREATE TABLE ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *    ';
      strSQL := strSQL + '     FROM PCMDET LIMIT 0 ) ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    If Not fTemInvFin(strNomTab, 'PCD') Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *       ';
      strSQL := strSQL + '     FROM PCMDET               ';
      strSQL := strSQL + '   WHERE                       ';
      strSQL := strSQL + '     PCD_BAIXAD = 0 AND ';
      strSQL := strSQL + '     PCD_ESPDOC = "PD" )       ';

      With qryGenAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;
    End;

    pgbProgresso.Position       := pgbProgresso.Position + 1;
    Application.ProcessMessages;

    Result := True;
  Except
    Result := False;
    fFecharTabela(qryGenAux);
  End;

  FreeAndNil(qryGenAux);

End;

end.
