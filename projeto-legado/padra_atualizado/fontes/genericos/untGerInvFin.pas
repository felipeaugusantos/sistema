unit untGerInvFin;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ZSqlMonitor, ComCtrls, ExtCtrls, DB,
  ZAbstractTable, Uni,  ZAbstractDataset;

type
  TfrmGerInvFin = class(TForm)
    pnlFundo: TPanel;
    lblGerInvCTR: TLabel;
    pgbStatus: TProgressBar;
    tmrFecha: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrFechaTimer(Sender: TObject);
  private
    { Private declarations }
    blnLibera: Boolean;
  public
    { Public declarations }
    strAnoInv, strMesInv : String;

    procedure pGeraInventarioFinanceiro;
  end;

var
  frmGerInvFin: TfrmGerInvFin;

implementation

uses untFuncBoleto, untFuncoes, untfuncoesSimples;

{$R *.dfm}

procedure TfrmGerInvFin.FormActivate(Sender: TObject);
begin

  If blnLibera Then
  Begin
    Application.ProcessMessages;
    blnLibera := False;
    pGeraInventarioFinanceiro;
    tmrFecha.Enabled := True;
  End;

end;

procedure TfrmGerInvFin.FormCreate(Sender: TObject);
begin
  blnLibera := True;
  Self.Constraints.MaxHeight := Self.Height;
  Self.Constraints.MaxWidth  := Self.Width;
  Self.Constraints.MinHeight := Self.Height;
  Self.Constraints.MinWidth  := Self.Width;
end;

procedure TfrmGerInvFin.tmrFechaTimer(Sender: TObject);
begin
  Close;
end;

procedure TfrmGerInvFin.pGeraInventarioFinanceiro;
  Var
    strSQL    : String;
    strNomTab : String;
    qryGenAux : TUniQuery;
Begin

  qryGenAux := fCriaQuery(Self);
  pgbStatus.Position := 0;
  pgbStatus.Max      := 7;

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
    pgbStatus.StepBy(1);

    {******************************}
    {* GERA INVENTARIO DE CTRX    *}
    {***************************IV*}
    strNomTab := 'CTRX_' + strAnoInv + strMesInv;

    If Not fTabelaExiste(strNomTab) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'CREATE TABLE ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *    ';
      strSQL := strSQL + '     FROM CADRECX LIMIT 0 ) ';

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
      strSQL := strSQL + '     FROM CADRECX         ';
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
    pgbStatus.StepBy(1);

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
    pgbStatus.StepBy(1);

    {******************************}
    {* GERA INVENTARIO DE CTPX    *}
    {***************************IV*}
    strNomTab := 'CTPX_' + strAnoInv + strMesInv;

    If Not fTabelaExiste(strNomTab) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'CREATE TABLE ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *    ';
      strSQL := strSQL + '     FROM CADPAGX LIMIT 0 ) ';

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
      strSQL := strSQL + '     FROM CADPAGX         ';
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
    pgbStatus.StepBy(1);

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
    pgbStatus.StepBy(1);

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
    pgbStatus.StepBy(1);

    {******************************}
    {* GERA INVENTARIO DE CHQX    *}
    {***************************IV*}
    strNomTab := 'CHQX_' + strAnoInv + strMesInv;

    If Not fTabelaExiste(strNomTab) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'CREATE TABLE ' + strNomTab;
      strSQL := strSQL + ' ( SELECT SQL_NO_CACHE *    ';
      strSQL := strSQL + '     FROM CADCHQX LIMIT 0 ) ';

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
      strSQL := strSQL + '     FROM CADCHQX         ';
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
    pgbStatus.StepBy(1);

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
    pgbStatus.StepBy(1);

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
    pgbStatus.StepBy(1);

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
    pgbStatus.StepBy(1);

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
      strSQL := strSQL + '    ( PCD_BAIXAD <> 1 OR       ';
      strSQL := strSQL + '      PCD_BAIXAD IS NULL ) AND ';
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
    pgbStatus.StepBy(1);

  Except
    fFecharTabela(qryGenAux);
  End;

  FreeAndNil(qryGenAux);

End;

End.

