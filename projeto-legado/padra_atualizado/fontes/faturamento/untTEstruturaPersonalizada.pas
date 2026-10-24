 unit untTEstruturaPersonalizada;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core,
  untFuncoesGenerica,
{$ELSE}
  untFuncoesSimples, VCL.Controls,
{$ENDIF}
  Classes, untTypesSistema, SysUtils, Data.DB, Uni;

Type
  TEstruturaPersonalizada = Class
  Private

    Const

      ALTEST = 'ALTEST';

      COLUNAS_GER = 'AUTOINCREM, '+
                    'GMT_CODEMP, '+
                    'GMT_CODITE, '+
                    'GMT_REFERE, '+
                    'GMT_OBS001, '+
                    'GMT_OBS002, '+
                    'GMT_OBS003, '+
                    'GMT_OBS004, '+
                    'GMT_QTDETI, '+
                    'GMT_ULTALT, '+
                    'GMT_TIPQTD, '+
                    'GMT_LAYORD, '+
                    'GMT_OBS005, '+
                    'GMT_OBS006, '+
                    'GMT_OBS007, '+
                    'GMT_MEETES  ';

      COLUNAS_DET = 'AUTOINCREM, '+
                    'DMT_SEQGER, '+
                    'DMT_SEQUEN, '+
                    'DMT_CODEMP, '+
                    'DMT_ITESUB, '+
                    'DMT_DESCRI, '+
                    'DMT_REFERE, '+
                    'DMT_QTDITE, '+
                    'DMT_CUSITE, '+
                    'DMT_DESPCA, '+
                    'DMT_APAREL, '+
                    'DMT_ACUMOP, '+
                    'DMT_BENEFI, '+
                    'DMT_COMPEC, '+
                    'DMT_ESPPEC, '+
                    'DMT_LARPEC, '+
                    'DMT_PERAPA, '+
                    'DMT_PERBEN, '+
                    'DMT_QTDPEC, '+
                    'DMT_ULTALT, '+
                    'DMT_PRESUB  ';

  Private

    FEstruturaSeraPersonalizada : Boolean;
    FTabTmpGer : String;
    FTabTmpDet : String;

    FSequencialDaEstruturaPersonalizada : Integer;

    function fPermiteEstruturaPersonalizada : Boolean;

    procedure pSetValDefaultVars;
    procedure pCreateTable;

    procedure pGerarSequencial;

  Public

    Constructor Create;
    Destructor  Destroy; Override;

    function fUsuarioDesejaAlterarEstrutura : Boolean;

    {$IFNDEF LINUX}
    function fCarregarEstruturaOriginalParaPersonalizacao(AIteEst : String) : Boolean;
    {$ENDIF}

    function fRetAutInc(AIteEst, ATabela : String) : String;
    function fRetAutIncByPerSeq(APerSEQ : Integer; ATabela : String) : String;

    procedure pCarregarItemEstruturaParaTabelasTemporarias(AIteEst : String);
    procedure pItemDeletadoSincronizar(AIteDel : String; ASeqPer : Integer);
    procedure pGravarEstruturaPersonalizada(ANumDoc, AEspDoc, AEmpDoc : String);

    property strTabTmpGer : String read FTabTmpGer;
    property strTabTmpDet : String read FTabTmpDet;

    property blnEstruturaFoiPersonalizada          : Boolean read FEstruturaSeraPersonalizada;
    property intSequencialDaEstruturaPersonalizada : Integer read FSequencialDaEstruturaPersonalizada;

  End;

implementation

{$IFNDEF LINUX}
uses
  untCadEstruturas, untMostraEstruturas;
{$ENDIF}

{ TEstruturaPersonalizada }

constructor TEstruturaPersonalizada.Create;
begin
  pSetValDefaultVars;
end;

destructor TEstruturaPersonalizada.Destroy;
begin

  If fTabelaExiste(FTabTmpGer) Then
    fDropTable(FTabTmpGer);

  If fTabelaExiste(FTabTmpDet) Then
    fDropTable(FTabTmpDet);

end;

{$IFNDEF LINUX}
function TEstruturaPersonalizada.fCarregarEstruturaOriginalParaPersonalizacao(AIteEst : String): Boolean;
  var
    frmCadEstruturas : TfrmCadEstruturas;
begin

  If AIteEst.IsEmpty Then
    Exit(False);

  If Not fItemEstrutura(AIteEst) Then
    Exit(False);

  frmCadEstruturas := TfrmCadEstruturas.Create(Nil);
  Try
    frmCadEstruturas.pCarregarEstruturaParaPersonalizacao(AIteEst, Self);
    Self.FEstruturaSeraPersonalizada := (frmCadEstruturas.ShowModal = mrOk);
    Result := Self.FEstruturaSeraPersonalizada;
  Finally
    pFreeAndNil(frmCadEstruturas);
  End;

end;
{$ENDIF}

function TEstruturaPersonalizada.fPermiteEstruturaPersonalizada: Boolean;
begin

  Result := False;

  If Not fCfgSis(ALTEST, varBoolean) Then
    Exit;

  If Not fVerificaAcessoSistema(ALTEST) Then
    Exit;

  Result := True;

end;

function TEstruturaPersonalizada.fRetAutInc(AIteEst, ATabela : String): String;
  const
    SQL = 'SELECT AUTOINCREM FROM [TABELA] WHERE GMT_CODITE = :CODITE';
  var
    LQry : TUniQuery;
begin

  LQry := fCriaQuery();

  Try

    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add(SQL.Replace('[TABELA]', ATabela));
    LQry.ParamByName('CODITE').AsString := AIteEst;
    LQry.Open;

    If LQry.IsEmpty Then
      Exit('');

    Result := LQry.FieldByName('AUTOINCREM').AsString;

  Finally
    FreeAndNil(LQry);
  End;

end;

function TEstruturaPersonalizada.fRetAutIncByPerSeq(APerSEQ: Integer; ATabela: String): String;
  const
    SQL = 'SELECT AUTOINCREM FROM [TABELA] WHERE GMT_SEQPER = :SEQPER';
  var
    LQry : TUniQuery;
begin

  LQry := fCriaQuery();

  Try

    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add(SQL.Replace('[TABELA]', ATabela));
    LQry.ParamByName('SEQPER').AsInteger := APerSeq;
    LQry.Open;

    If LQry.IsEmpty Then
      Exit('');

    Result := LQry.FieldByName('AUTOINCREM').AsString;

  Finally
    FreeAndNil(LQry);
  End;

end;

function TEstruturaPersonalizada.fUsuarioDesejaAlterarEstrutura: Boolean;
  Const
    MSG = 'Deseja alterar sub-produtos?';
begin

  If Not fPermiteEstruturaPersonalizada Then
    Exit(False);

  Self.FEstruturaSeraPersonalizada := (fMensagem('', MSG, ['&Sim', '&Não'], 2) = 1);
  Result := Self.FEstruturaSeraPersonalizada;

end;

procedure TEstruturaPersonalizada.pCarregarItemEstruturaParaTabelasTemporarias(AIteEst : String);
  var
    LSQLExc : String;
    LAutInc : String;
begin

   If Not fTabelaExiste(FTabTmpGer) Then
    pCreateTable;

  LAutInc := fRetAutInc(AIteEst, 'GERMAT');

  If LAutInc.IsEmpty Then
    Exit;

  Try

    pGerarSequencial;

    LSQLExc := 'INSERT INTO ' + FTabTmpGer + ' (' + COLUNAS_GER + ') ';
    LSQLExc := LSQLExc + 'SELECT ' + COLUNAS_GER + ' FROM GERMAT WHERE GERMAT.AUTOINCREM = ' + LAutInc.QuotedString + ';';
    LSQLExc := LSQLExc + 'UPDATE ' + FTabTmpGer + ' SET GMT_SEQPER = ' + FSequencialDaEstruturaPersonalizada.ToString + ' WHERE GMT_SEQPER IS NULL;';
    fExecutaSQL(LSQLExc);

    LSQLExc := 'INSERT INTO ' + FTabTmpDet + ' (' + COLUNAS_DET + ') ';
    LSQLExc := LSQLExc + 'SELECT ' + COLUNAS_DET + ' FROM DETMAT WHERE DETMAT.DMT_SEQGER = ' + LAutInc.QuotedString + ';';
    LSQLExc := LSQLExc + 'UPDATE ' + FTabTmpDet + ' SET DMT_SEQPER = ' + FSequencialDaEstruturaPersonalizada.ToString + ' WHERE DMT_SEQPER IS NULL;';
    fExecutaSQL(LSQLExc);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TEstruturaPersonalizada.pCarregarItemEstruturaParaTabelasTemporarias]');
    End;
  End;

end;

procedure TEstruturaPersonalizada.pCreateTable;
  Var
    LSQL : String;
begin

  Try

    LSQL := '';
    LSQL := LSQL + 'CREATE TABLE `'+FTabTmpGer+'` (                        ';
    LSQL := LSQL + '    `AUTOINCREM` varchar(20) NOT NULL DEFAULT '''',    ';
    LSQL := LSQL + '    `GMT_CODEMP` char(3) NOT NULL DEFAULT '''',        ';
    LSQL := LSQL + '    `GMT_CODITE` varchar(5) NOT NULL DEFAULT '''',     ';
    LSQL := LSQL + '    `GMT_REFERE` varchar(20) DEFAULT NULL,             ';
    LSQL := LSQL + '    `GMT_OBS001` varchar(140) DEFAULT NULL,            ';
    LSQL := LSQL + '    `GMT_OBS002` varchar(140) DEFAULT NULL,            ';
    LSQL := LSQL + '    `GMT_OBS003` varchar(140) DEFAULT NULL,            ';
    LSQL := LSQL + '    `GMT_OBS004` varchar(140) DEFAULT NULL,            ';
    LSQL := LSQL + '    `GMT_QTDETI` int(11) DEFAULT NULL,                 ';
    LSQL := LSQL + '    `GMT_ULTALT` date DEFAULT NULL,                    ';
    LSQL := LSQL + '    `GMT_TIPQTD` char(1) DEFAULT ''Q'',                ';
    LSQL := LSQL + '    `GMT_LAYORD` varchar(6) DEFAULT NULL,              ';
    LSQL := LSQL + '    `GMT_OBS005` varchar(140) DEFAULT NULL,            ';
    LSQL := LSQL + '    `GMT_OBS006` varchar(140) DEFAULT NULL,            ';
    LSQL := LSQL + '    `GMT_OBS007` varchar(140) DEFAULT NULL,            ';
    LSQL := LSQL + '    `GMT_MEETES` char(1) DEFAULT ''N'',                ';
    LSQL := LSQL + '    `GMT_NUMDOC` varchar(12) DEFAULT NULL,             ';
    LSQL := LSQL + '    `GMT_ESPDOC` varchar(2) DEFAULT NULL,              ';
    LSQL := LSQL + '    `GMT_EMPDOC` char(3) DEFAULT NULL,                 ';
    LSQL := LSQL + '    `GMT_SEQPER` int(11) DEFAULT NULL                  ';
    LSQL := LSQL + '  ) ENGINE = MEMORY DEFAULT CHARSET=LATIN1             ';

    fExecutaSQL(LSQL);

    LSQL := '';
    LSQL := LSQL + '  CREATE TABLE `'+FTabTmpDet+'` (                      ';
    LSQL := LSQL + '    `AUTOINCREM` VARCHAR(20) NOT NULL DEFAULT '''',    ';
    LSQL := LSQL + '    `DMT_SEQGER` varchar(20) NOT NULL DEFAULT '''',    ';
    LSQL := LSQL + '    `DMT_SEQUEN` int(11) NOT NULL,                     ';
    LSQL := LSQL + '    `DMT_CODEMP` char(3) NOT NULL DEFAULT '''',        ';
    LSQL := LSQL + '    `DMT_ITESUB` varchar(5) DEFAULT NULL,              ';
    LSQL := LSQL + '    `DMT_DESCRI` varchar(50) DEFAULT NULL,             ';
    LSQL := LSQL + '    `DMT_REFERE` varchar(70) DEFAULT NULL,             ';
    LSQL := LSQL + '    `DMT_QTDITE` decimal(14,6) DEFAULT ''0.000000'',   ';
    LSQL := LSQL + '    `DMT_CUSITE` decimal(12,2) DEFAULT NULL,           ';
    LSQL := LSQL + '    `DMT_DESPCA` varchar(30) DEFAULT NULL,             ';
    LSQL := LSQL + '    `DMT_APAREL` char(1) DEFAULT ''N'',                ';
    LSQL := LSQL + '    `DMT_ACUMOP` char(1) DEFAULT ''S'',                ';
    LSQL := LSQL + '    `DMT_BENEFI` char(1) DEFAULT ''N'',                ';
    LSQL := LSQL + '    `DMT_COMPEC` decimal(12,5) DEFAULT ''0.00000'',    ';
    LSQL := LSQL + '    `DMT_ESPPEC` decimal(12,5) DEFAULT ''0.00000'',    ';
    LSQL := LSQL + '    `DMT_LARPEC` decimal(12,5) DEFAULT ''0.00000'',    ';
    LSQL := LSQL + '    `DMT_PERAPA` decimal(12,2) DEFAULT ''0.00'',       ';
    LSQL := LSQL + '    `DMT_PERBEN` decimal(12,2) DEFAULT ''0.00'',       ';
    LSQL := LSQL + '    `DMT_QTDPEC` decimal(12,5) DEFAULT ''0.00000'',    ';
    LSQL := LSQL + '    `DMT_ULTALT` date DEFAULT NULL,                    ';
    LSQL := LSQL + '    `DMT_PRESUB` decimal(10,3) DEFAULT ''1.000'',      ';
    LSQL := LSQL + '    `DMT_SEQPER` int(11) DEFAULT NULL                  ';
    LSQL := LSQL + '  ) ENGINE = MEMORY DEFAULT CHARSET=LATIN1 ';

    fExecutaSQL(LSQL);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TEstruturaPersonalizada.pCreateTable]');
    End;
  End;

end;

procedure TEstruturaPersonalizada.pGerarSequencial;
begin
  FSequencialDaEstruturaPersonalizada := fRetSequencial('SEQPER').ToInteger;
end;

procedure TEstruturaPersonalizada.pGravarEstruturaPersonalizada(ANumDoc, AEspDoc, AEmpDoc: String);
  const
    SQL_GER = 'SELECT * FROM GERPER WHERE FALSE';
    SQL_DET = 'SELECT * FROM DETPER WHERE FALSE';
  var
    LQryTmpGer : TUniQuery;
    LQryTmpDet : TUniQuery;

    LQryGer : TUniQuery;
    LQryDet : TUniQuery;

    strAutIncGer : String;
begin

  Try

    LQryTmpGer := fCriaQuery;
    LQryTmpDet := fCriaQuery;

    LQryGer := fCriaQuery;
    LQryDet := fCriaQuery;

    Try

      LQryTmpGer.Close;
      LQryTmpGer.SQL.Clear;
      LQryTmpGer.SQL.Add('SELECT * FROM ' + FTabTmpGer);
      LQryTmpGer.Open;

      LQryTmpDet.Close;
      LQryTmpDet.SQL.Clear;
      LQryTmpDet.SQL.Add('SELECT * FROM ' + FTabTmpDet);
      LQryTmpDet.Open;

      If LQryTmpGer.IsEmpty Then
        Exit;

      If LQryTmpDet.IsEmpty Then
        Exit;

      LQryGer.Close;
      LQryGer.SQL.Clear;
      LQryGer.SQL.Add(SQL_GER);
      LQryGer.Open;

      LQryDet.Close;
      LQryDet.SQL.Clear;
      LQryDet.SQL.Add(SQL_DET);
      LQryDet.Open;

      LQryTmpGer.First;
      While Not LQryTmpGer.Eof Do
      Begin

        strAutIncGer := fRetAutoIncrem('GERPER', VS_strCodEmp);

        LQryGer.Append;
        LQryGer.FieldByName('AUTOINCREM').Value := strAutIncGer;

        LQryGer.FieldByName('GMT_NUMDOC').Value := ANumDoc;
        LQryGer.FieldByName('GMT_ESPDOC').Value := AEspDoc;
        LQryGer.FieldByName('GMT_EMPDOC').Value := AEmpDoc;

        LQryGer.FieldByName('GMT_CODEMP').Value := LQryTmpGer.FieldByName('GMT_CODEMP').Value;
        LQryGer.FieldByName('GMT_CODITE').Value := LQryTmpGer.FieldByName('GMT_CODITE').Value;
        LQryGer.FieldByName('GMT_REFERE').Value := LQryTmpGer.FieldByName('GMT_REFERE').Value;
        LQryGer.FieldByName('GMT_OBS001').Value := LQryTmpGer.FieldByName('GMT_OBS001').Value;
        LQryGer.FieldByName('GMT_OBS002').Value := LQryTmpGer.FieldByName('GMT_OBS002').Value;
        LQryGer.FieldByName('GMT_OBS003').Value := LQryTmpGer.FieldByName('GMT_OBS003').Value;
        LQryGer.FieldByName('GMT_OBS004').Value := LQryTmpGer.FieldByName('GMT_OBS004').Value;
        LQryGer.FieldByName('GMT_OBS005').Value := LQryTmpGer.FieldByName('GMT_OBS005').Value;
        LQryGer.FieldByName('GMT_OBS006').Value := LQryTmpGer.FieldByName('GMT_OBS006').Value;
        LQryGer.FieldByName('GMT_OBS007').Value := LQryTmpGer.FieldByName('GMT_OBS007').Value;
        LQryGer.FieldByName('GMT_QTDETI').Value := LQryTmpGer.FieldByName('GMT_QTDETI').Value;
        LQryGer.FieldByName('GMT_ULTALT').Value := LQryTmpGer.FieldByName('GMT_ULTALT').Value;
        LQryGer.FieldByName('GMT_TIPQTD').Value := LQryTmpGer.FieldByName('GMT_TIPQTD').Value;
        LQryGer.FieldByName('GMT_LAYORD').Value := LQryTmpGer.FieldByName('GMT_LAYORD').Value;
        LQryGer.FieldByName('GMT_MEETES').Value := LQryTmpGer.FieldByName('GMT_MEETES').Value;
        LQryGer.FieldByName('GMT_SEQPER').Value := LQryTmpGer.FieldByName('GMT_SEQPER').Value;
        LQryGer.Post;

        LQryTmpDet.Filtered := False;
        LQryTmpDet.Filter   := 'DMT_SEQPER = ' + LQryTmpGer.FieldByName('GMT_SEQPER').AsString;
        LQryTmpDet.Filtered := True;

        LQryTmpDet.First;
        While Not LQryTmpDet.Eof Do
        Begin

          LQryDet.Append;
          LQryDet.FieldByName('AUTOINCREM').Value := fRetAutoIncrem('DETPER', VS_strCodEmp);
          LQryDet.FieldByName('DMT_SEQGER').Value := strAutIncGer;
          LQryDet.FieldByName('DMT_SEQUEN').Value := LQryTmpDet.FieldByName('DMT_SEQUEN').Value;
          LQryDet.FieldByName('DMT_CODEMP').Value := LQryTmpDet.FieldByName('DMT_CODEMP').Value;
          LQryDet.FieldByName('DMT_ITESUB').Value := LQryTmpDet.FieldByName('DMT_ITESUB').Value;
          LQryDet.FieldByName('DMT_DESCRI').Value := LQryTmpDet.FieldByName('DMT_DESCRI').Value;
          LQryDet.FieldByName('DMT_REFERE').Value := LQryTmpDet.FieldByName('DMT_REFERE').Value;
          LQryDet.FieldByName('DMT_QTDITE').Value := LQryTmpDet.FieldByName('DMT_QTDITE').Value;
          LQryDet.FieldByName('DMT_CUSITE').Value := LQryTmpDet.FieldByName('DMT_CUSITE').Value;
          LQryDet.FieldByName('DMT_DESPCA').Value := LQryTmpDet.FieldByName('DMT_DESPCA').Value;
          LQryDet.FieldByName('DMT_APAREL').Value := LQryTmpDet.FieldByName('DMT_APAREL').Value;
          LQryDet.FieldByName('DMT_ACUMOP').Value := LQryTmpDet.FieldByName('DMT_ACUMOP').Value;
          LQryDet.FieldByName('DMT_BENEFI').Value := LQryTmpDet.FieldByName('DMT_BENEFI').Value;
          LQryDet.FieldByName('DMT_COMPEC').Value := LQryTmpDet.FieldByName('DMT_COMPEC').Value;
          LQryDet.FieldByName('DMT_ESPPEC').Value := LQryTmpDet.FieldByName('DMT_ESPPEC').Value;
          LQryDet.FieldByName('DMT_LARPEC').Value := LQryTmpDet.FieldByName('DMT_LARPEC').Value;
          LQryDet.FieldByName('DMT_PERAPA').Value := LQryTmpDet.FieldByName('DMT_PERAPA').Value;
          LQryDet.FieldByName('DMT_PERBEN').Value := LQryTmpDet.FieldByName('DMT_PERBEN').Value;
          LQryDet.FieldByName('DMT_QTDPEC').Value := LQryTmpDet.FieldByName('DMT_QTDPEC').Value;
          LQryDet.FieldByName('DMT_ULTALT').Value := LQryTmpDet.FieldByName('DMT_ULTALT').Value;
          LQryDet.FieldByName('DMT_PRESUB').Value := LQryTmpDet.FieldByName('DMT_PRESUB').Value;
          LQryDet.FieldByName('DMT_SEQPER').Value := LQryTmpDet.FieldByName('DMT_SEQPER').Value;
          LQryDet.Post;

          LQryTmpDet.Next;

        End;

        LQryTmpGer.Next;

      End;

    Finally

      FreeAndNil(LQryTmpGer);
      FreeAndNil(LQryTmpDet);

      FreeAndNil(LQryGer);
      FreeAndNil(LQryDet);

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TEstruturaPersonalizada.pGravarEstruturaPersonalizada]');
    End;
  End;

end;

procedure TEstruturaPersonalizada.pItemDeletadoSincronizar(AIteDel : String; ASeqPer : Integer);
  var
    LEstrut : TItemEstru;
begin

  LEstrut := fEhOuCompoeEstrutura(AIteDel, VS_strCodEmp);

  If Not (LEstrut.blnEstrutura) Then
    Exit;

  If (LEstrut.blnPrincipal) Then
  Begin
    fExecutaSQL('DELETE FROM ' + FTabTmpGer + ' WHERE GMT_SEQPER = ' + ASeqPer.ToString);
    fExecutaSQL('DELETE FROM ' + FTabTmpDet + ' WHERE DMT_SEQPER = ' + ASeqPer.ToString);
    Exit;
  End;

  fExecutaSQL('DELETE FROM ' + FTabTmpDet + ' WHERE DMT_ITESUB = ' + AIteDel.QuotedString + ' AND ' +
                                                   'DMT_SEQPER = ' + ASeqPer.ToString);

end;

procedure TEstruturaPersonalizada.pSetValDefaultVars;
begin
  Self.FEstruturaSeraPersonalizada := False;
  Self.FTabTmpGer := fGetMemoryTableName('GERPER');
  Self.FTabTmpDet := fGetMemoryTableName('DETPER');

  Self.FSequencialDaEstruturaPersonalizada := -1;
end;

end.
