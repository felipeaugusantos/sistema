unit untAcessoTotal;

interface

uses Windows, Classes, StrUtils, SysUtils, Controls, Uni, UniClientDataSet,
  UniDataSetProvider, DB, Forms, Variants, StdCtrls, untFuncoesSimples,
  untGravando, cxProgressBar, untTypesSistema, untIGravaDireitoAcesso;


Type
  TAceTot = Class(TInterfacedObject, IGravaDireitoAcesso)
  private
    qryGeneri: TUniQuery;
    qryCadOpe: TUniQuery;
    qryCadGpo: TUniQuery;
    cdsCadOpe: TUniClientDataSet;
    cdsCadGpo: TUniClientDataSet;
    dspCadOpe: TUniDataSetProvider;
    dspCadGpo: TUniDataSetProvider;

    blnMarcar: Boolean;
    stlNomFrm: TStringList;
    tipTipDir: TTipDir;

    FEditPesqOpe: TEdit;
    FEditPesqGpo: TEdit;

    procedure  OnFilterRecordCadOpe(DataSet: TDataSet; var Accept: Boolean);
    procedure  OnFilterRecordCadGpo(DataSet: TDataSet; var Accept: Boolean);

    procedure  pPreparaComponentes;
    procedure  pDestroiComponentes;
    procedure  pPreparaDados;

    function   fGetSQLOperador: String;
    function   fGetSQLGrupo: String;

    function   fGetSQLApagaDirOperador: String;
    function   fGetSQLApagaDirOperadorAutBan: String;
    function   fGetSQLApagaDirOperadorAutTin: String;
    function   fGetSQLApagaDirGrupo: String;

    function   fGravarLogDir(ADirAce, ATabela, ACodOpe, ACodGpo, ADirEsp: String): Boolean;

    function   fGetValuesInsertOperador(strDirAce: String): String;
    function   fGetValuesInsertOperadorAutBan(strDirAce: String): String;
    function   fGetValuesInsertOperadorAutTin(strDirAce: String): String;
    function   fGetValuesInsertGrupo(strDirAce: String): String;

    function   fGetSQLInsertOperador(strValues: String): String;
    function   fGetSQLInsertOperadorAutBan(strValues: String): String;
    function   fGetSQLInsertOperadorAutTin(strValues: String): String;
    function   fGetSQLInsertGrupo(strValues: String): String;

    function   fMarcaDesmarcaTotalOperador(pgbProgresso: TcxProgressBar): Boolean;
    function   fMarcaDesmarcaTotalGrupo(pgbProgresso: TcxProgressBar): Boolean;

    function   fOperadorSelecionado: Boolean;
    function   fGrupoSelecionado: Boolean;

    function   fGravarOperadores: Boolean;
    function   fGravarOperadoresInterna(pgbProgresso: TcxProgressBar): Boolean;
    function   fInsereDireitoOperador(strSQLIns: String): Boolean;

    function   fGravarOperadoresAutBan: Boolean;
    function   fGravarOperadoresAutBanInterna(pgbProgresso: TcxProgressBar): Boolean;
    function   fInsereDireitoOperadorAutBan(strSQLIns: String): Boolean;

    function   fGravarOperadoresAutTin: Boolean;
    function   fGravarOperadoresAutTinInterna(pgbProgresso: TcxProgressBar): Boolean;
    function   fInsereDireitoOperadorAutTin(strSQLIns: String): Boolean;

    function   fGravarGrupos: Boolean;
    function   fGravarGruposInterna(pgbProgresso: TcxProgressBar): Boolean;
    function   fInsereDireitoGrupo(strSQLIns: String): Boolean;

    function   fApagaDireitosAtuaisDoOperador(strCodOpe: String): Boolean;
    function   fApagaDireitosAtuaisDoOperadorAutBan(strCodOpe: String): Boolean;
    function   fApagaDireitosAtuaisDoOperadorAutTin(strCodOpe: String): Boolean;
    function   fApagaDireitosAtuaisDoGrupo(strCodGru: String): Boolean;

    function   fGravaLogDirOpe(strCodOpe: String): Boolean;
    function   fGravaLogDirGrupo(strCodGru: String): Boolean;
    function   fGravaLogDirAcessoTotal(strSQlInsLog, strTabela: String): Boolean;
    function   fGetSQLInsertCamposLogDir: String;
  public
    function getCdsOpe: TDataSet;
    function getCdsGpo: TDataSet;

    function getMarcarOpe: Boolean;
    function getMarcarGpo: Boolean;

    procedure SetPesqOperador(AEdit: TEdit);
    procedure SetPesqGrupo(AEdit: TEdit);

    function TemPesquisa(): Boolean;

    function fTemRegistroSelecionado: Boolean;

    procedure pMarcaDesmarcaOperador(blnMarcar: Boolean);
    procedure pMarcaDesmarcaGrupo(blnMarcar: Boolean);

    procedure pMarcaDesmarcaTotalOperador(blnMarcar: Boolean);
    procedure pMarcaDesmarcaTotalGrupo(blnMarcar: Boolean);

    function  fGravar: Boolean;

    function fVerificaSeExisteDireitoDeAcessoVinculadoAoOperador(strCodOpe: String): Boolean;
    function fVerificaSeExisteDireitoDeAcessoVinculadoAoGrupo(strCodGpo: String): Boolean;

    function getTipoOperacao: TTipDir;

    Constructor Create(stlNomFrm: TStringList; tipDirAce: TTipDir); reintroduce;
    Destructor  Destroy; override;
  End;

implementation

Const
  INFO_PESQUISA = 'Ctrl+L Pesquisar';

{ TAceTot }

constructor TAceTot.Create(stlNomFrm: TStringList; tipDirAce: TTipDir);
begin
  inherited create();
  Self.stlNomFrm := stlNomFrm;
  Self.tipTipDir := tipDirAce;
  pPreparaComponentes;
  pPreparaDados;
end;

destructor TAceTot.Destroy;
begin
  pDestroiComponentes;
  inherited destroy;
end;

function TAceTot.fApagaDireitosAtuaisDoGrupo(strCodGru: String): Boolean;
begin
  Result := False;

  Try

    fGravaLogDirGrupo(strCodGru);

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLApagaDirGrupo);
      ParamByName('CODGPO').AsString := strCodGru;
      ExecSQL;
      Result := True;

    End;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fApagaDireitosAtuaisDoGrupo]');
  End;
end;

function TAceTot.fGravaLogDirGrupo(strCodGru: String): Boolean;
Var
    strSql : String;
begin
  Result := False;

  Try

    strSql := '';
    strSql := strSql + ' INSERT INTO LOGDIR (AUTOINCREM,LOG_DTAALT, LOG_HORALT, LOG_CODOPE, LOG_TABELA, LOG_NOMFRM, LOG_CODGPO, LOG_ACAOUS) ';
    strSql := strSql + ' ( SELECT fRetAutoincrem (''LOGDIR'', :CODEMP), ';
    strSql := strSql + ' CURRENT_DATE, ';
    strSql := strSql + ' CURRENT_TIME, ';
    strSql := strSql + ' :OPELOG,      ';
    strSql := strSql + ' :TABELA,      ';
    strSql := strSql + ' DIR_NOMFRM,   ';
    strSql := strSql + ' GPO_CODGPO,   ';
    strSql := strSql + ' :ACAO         ';
    strSql := strSql + ' FROM DIRGPO WHERE GPO_CODGPO = :CODGPO) ';

    With qryGeneri Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSql);
      Parambyname('CODGPO').AsString := strCodGru;
      Parambyname('CODEMP').AsString := VS_strCodEmp;
      Parambyname('OPELOG').AsString := strLoginUsuarioLogado;
      Parambyname('TABELA').AsString := 'DIRGPO';
      Parambyname('ACAO').AsString   := 'DEL';

      ExecSQL;
      Result := True;

    End;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fGravaLogDir]');
  End;
end;

function TAceTot.fApagaDireitosAtuaisDoOperador(strCodOpe: String): Boolean;
begin
  Result := False;

  Try

    fGravaLogDirOpe(strCodOpe);

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLApagaDirOperador);
      ParamByName('CODOPE').AsString := strCodOpe;
      ExecSQL;
      Result := True;

    End;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fApagaDireitosAtuaisDoOperador]');
  End;
end;

function TAceTot.fGravaLogDirOpe(strCodOpe: String): Boolean;
Var
    strSql : String;
begin
  Result := False;

  Try

    strSql := '';
    strSql := strSql + 'INSERT INTO LOGDIR( ';
    strSql := strSql + '  AUTOINCREM, ';
    strSql := strSql + '  LOG_DTAALT, ';
    strSql := strSql + '  LOG_HORALT, ';
    strSql := strSql + '  LOG_CODOPE, ';
    strSql := strSql + '  LOG_TABELA, ';
    strSql := strSql + '  LOG_NOMFRM, ';
    strSql := strSql + '  LOG_OPEDIR, ';
    strSql := strSql + '  LOG_ACAOUS) ';
    strSql := strSql + 'SELECT fRetAutoincrem(''LOGDIR'', :CODEMP), ';
    strSql := strSql + ' CURRENT_DATE, ';
    strSql := strSql + ' CURRENT_TIME, ';
    strSql := strSql + ' :OPELOG,      ';
    strSql := strSql + ' :TABELA,      ';
    strSql := strSql + ' DIR_NOMFRM,   ';
    strSql := strSql + ' :CODOPE,      ';
    strSql := strSql + ' :ACAO         ';
    strSql := strSql + 'FROM DIROPE WHERE OPE_CODOPE = :CODOPE ';

    With qryGeneri Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSql);
      Parambyname('CODOPE').AsString := strCodOpe;
      Parambyname('CODEMP').AsString := VS_strCodEmp;
      Parambyname('OPELOG').AsString := strLoginUsuarioLogado;
      Parambyname('TABELA').AsString := 'DIROPE';
      Parambyname('ACAO').AsString   := 'DEL';

      ExecSQL;
      Result := True;

    End;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fGravaLogDir]');
  End;
end;

function TAceTot.fApagaDireitosAtuaisDoOperadorAutBan(
  strCodOpe: String): Boolean;
begin
  Result := False;

  Try
    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLApagaDirOperadorAutBan);
      ParamByName('CODOPE').AsString := strCodOpe;
      ExecSQL;
      Result := fGravarLogDir('REMOCAO TOTAL', 'DIRBAN', strCodOpe, '', 'DEL');
    End;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fApagaDireitosAtuaisDoOperadorAutBan]');
  End;
end;

function TAceTot.fApagaDireitosAtuaisDoOperadorAutTin(
  strCodOpe: String): Boolean;
begin
  Result := False;

  Try
    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLApagaDirOperadorAutTin);
      ParamByName('CODOPE').AsString := strCodOpe;
      ExecSQL;
      Result := fGravarLogDir('REMOCAO TOTAL', 'DIRTIN', strCodOpe, '', 'DEL');
    End;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fApagaDireitosAtuaisDoOperadorAutTin]');
  End;
end;

function TAceTot.fGetSQLApagaDirGrupo: String;
begin
  Result := '';
  Result := Result + 'DELETE FROM DIRGPO WHERE GPO_CODGPO = :CODGPO';
end;

function TAceTot.fGetSQLApagaDirOperador: String;
begin
  Result := '';
  Result := Result + 'DELETE FROM DIROPE WHERE OPE_CODOPE = :CODOPE';
end;

function TAceTot.fGetSQLApagaDirOperadorAutBan: String;
begin
  Result := '';
  Result := Result + 'DELETE FROM DIRBAN WHERE BAN_CODOPE = :CODOPE';
end;

function TAceTot.fGetSQLApagaDirOperadorAutTin: String;
begin
  Result := '';
  Result := Result + 'DELETE FROM DIRTIN WHERE TIN_CODOPE = :CODOPE';
end;

function TAceTot.fGetSQLGrupo: String;
begin
  Result := '';
  Result := Result + 'SELECT              ';
  Result := Result + '  GPO_CODGPO,       ';
  Result := Result + '  GPO_DESCRI,       ';
  Result := Result + '  "N" AS GPO_MARDES ';
  Result := Result + 'FROM                ';
  Result := Result + '  CADGPO            ';
  Result := Result + 'ORDER BY            ';
  Result := Result + '  GPO_DESCRI        ';
end;

function TAceTot.fGetSQLInsertGrupo(strValues: String): String;
begin
  Result := '';
  Result := Result + 'INSERT INTO          ';
  Result := Result + '  DIRGPO(DIR_NOMFRM, ';
  Result := Result + '         GPO_CODGPO, ';
  Result := Result + '         DIR_ACAOUS) ';
  Result := Result + '  VALUES' + strValues;
end;

function TAceTot.fGetSQLInsertOperador(strValues: String): String;
begin
  Result := '';
  Result := Result + 'INSERT INTO          ';
  Result := Result + '  DIROPE(DIR_NOMFRM, ';
  Result := Result + '         OPE_CODOPE, ';
  Result := Result + '         DIR_ACAOUS) ';
  Result := Result + '  VALUES' + strValues;
end;

function TAceTot.fGetSQLInsertOperadorAutBan(strValues: String): String;
begin
  Result := '';
  Result := Result + 'INSERT INTO          ';
  Result := Result + '  DIRBAN(BAN_CODOPE, ';
  Result := Result + '         BAN_NOMFRM) ';
  Result := Result + '  VALUES' + strValues;
end;

function TAceTot.fGetSQLInsertOperadorAutTin(strValues: String): String;
begin
  Result := '';
  Result := Result + 'INSERT INTO          ';
  Result := Result + '  DIRTIN(TIN_CODOPE, ';
  Result := Result + '         TIN_NOMFRM) ';
  Result := Result + '  VALUES' + strValues;
end;

function TAceTot.fGetSQLInsertCamposLogDir(): String;
begin
  Result := '';
  Result := Result + '(fRetAutoincrem (''LOGDIR'', :CODEMP),';
  Result := Result + ' CURRENT_DATE, ';
  Result := Result + ' CURRENT_TIME, ';
  Result := Result + ' :OPELOG,      ';
  Result := Result + ' :TABELA,      ';
end;

function TAceTot.fGetSQLOperador: String;
begin
  Result := '';
  Result := Result + 'SELECT              ';
  Result := Result + '  OPE_CODOPE,       ';
  Result := Result + '  OPE_NOMOPE,       ';
  Result := Result + '  "N" AS OPE_MARDES ';
  Result := Result + 'FROM                ';
  Result := Result + '  CADOPE            ';
  Result := Result + 'WHERE               ';
  Result := Result + '  OPE_STATUS <> "I" ';
  Result := Result + 'ORDER BY            ';
  Result := Result + '  OPE_NOMOPE        ';
end;

function TAceTot.fGetValuesInsertGrupo(strDirAce: String): String;
begin
  Result := '';
  Result := Result + '(' + QuotedStr(strDirAce) + ',';
  Result := Result +       QuotedStr('CODGPO')  + ',';
  Result := Result +       QuotedStr('IAE')     + ')';
end;

function TAceTot.fGravarLogDir(ADirAce, ATabela, ACodOpe, ACodGpo, ADirEsp: String): Boolean;
Var
  LSQL: String;
begin
  LSQL := '';
  LSQL := LSQL + 'INSERT INTO LOGDIR ( ';
  LSQL := LSQL + '  AUTOINCREM,        ';
  LSQL := LSQL + '  LOG_DTAALT,        ';
  LSQL := LSQL + '  LOG_HORALT,        ';
  LSQL := LSQL + '  LOG_CODOPE,        ';
  LSQL := LSQL + '  LOG_TABELA,        ';
  LSQL := LSQL + '  LOG_NOMFRM,        ';
  LSQL := LSQL + '  LOG_OPEDIR,        ';
  LSQL := LSQL + '  LOG_CODGPO,        ';
  LSQL := LSQL + '  LOG_ACAOUS         ';
  LSQL := LSQL + ') VALUES             ';
  LSQL := LSQL + '(' + QuotedStr(fRetAutoIncrem('LOGDIR', VS_strCodEmp)) + ',';
  LSQL := LSQL       + QuotedStr(FormatDateTime('yyyy-MM-dd', VS_Date))  + ',';
  LSQL := LSQL       + QuotedStr(TimeToStr(fTime()))                     + ',';
  LSQL := LSQL       + QuotedStr(strLoginUsuarioLogado)                  + ',';
  LSQL := LSQL       + QuotedStr(ATabela)                                + ',';
  LSQL := LSQL       + QuotedStr(ADirAce)                                + ',';
  LSQL := LSQL       + IIF(ACodOpe = '', 'NULL', QuotedStr(ACodOpe))     + ',';
  LSQL := LSQL       + IIF(ACodGpo = '', 'NULL', QuotedStr(ACodGpo))     + ',';
  LSQL := LSQL       + QuotedStr(ADirEsp)                                + ')';

  Result := fExecutaSQL(LSQL);
end;

function TAceTot.fGetValuesInsertOperador(strDirAce: String): String;
begin
  Result := '';
  Result := Result + '(' + QuotedStr(strDirAce) + ',';
  Result := Result +       QuotedStr('CODOPE')  + ',';
  Result := Result +       QuotedStr('IAE')     + ')';
end;

function TAceTot.fGetValuesInsertOperadorAutBan(strDirAce: String): String;
begin
  Result := '';
  Result := Result + '(' + QuotedStr('CODOPE')  + ',';
  Result := Result +       QuotedStr(strDirAce) + ')';
end;

function TAceTot.fGetValuesInsertOperadorAutTin(strDirAce: String): String;
begin
  Result := '';
  Result := Result + '(' + QuotedStr('CODOPE')  + ',';
  Result := Result +       QuotedStr(strDirAce) + ')';
end;

function TAceTot.fInsereDireitoGrupo(strSQLIns: String): Boolean;
begin
  Result := False;

  Try

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQLIns);
      ExecSQL;
      Result := True;
    End;

    fGravaLogDirAcessoTotal(strSQLIns,'DIRGPO');

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fGravaDireitoGrupo]');
  End;

end;

function TAceTot.fGravaLogDirAcessoTotal(strSQlInsLog, strTabela: String): Boolean;
 Var
    strSql,
    strInsert,
    strCmplog : String;
    strSqlInsTipoTabela : String;
begin
  Result := False;

  Try

    If strTabela = 'DIROPE' Then
       strSqlInsTipoTabela := fGetSQLInsertOperador('')
    Else
    if strTabela = 'DIRGPO' Then
       strSqlInsTipoTabela := fGetSQLInsertGrupo('');

    strSQlInsLog := AnsiReplaceStr(strSQlInsLog, strSqlInsTipoTabela, '');

    strCmplog := fGetSQLInsertCamposLogDir();

       strInsert := AnsiReplaceStr(strSQlInsLog, '(', strCmplog);

    strSql := '';
    strSql := strSql + ' INSERT INTO LOGDIR ( ';
    strSql := strSql + ' AUTOINCREM, ';
    strSql := strSql + ' LOG_DTAALT, ';
    strSql := strSql + ' LOG_HORALT, ';
    strSql := strSql + ' LOG_CODOPE, ';
    strSql := strSql + ' LOG_TABELA, ';
    strSql := strSql + ' LOG_NOMFRM, ';

    If strTabela = 'DIROPE' Then
       strSql := strSql + ' LOG_OPEDIR, ';

    If strTabela = 'DIRGPO' Then
       strSql := strSql + ' LOG_CODGPO, ';

    strSql := strSql + ' LOG_ACAOUS) ';
    strSql := strSql + ' VALUES      ';

    strSql := strSql + strInsert;

    With qryGeneri Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSql);
      Parambyname('CODEMP').AsString := VS_strCodEmp;
      Parambyname('OPELOG').AsString := strLoginUsuarioLogado;
      Parambyname('TABELA').AsString := strTabela;

      ExecSQL;
      Result := True;

    End;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fGravaLogDirAcessoTotal]');
  End;
end;

function TAceTot.fInsereDireitoOperador(strSQLIns: String): Boolean;
begin
  Result := False;

  Try

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQLIns);
      ExecSQL;
      Result := True;
    End;

    fGravaLogDirAcessoTotal(strSQLIns,'DIROPE');

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fGravaDireitoOperador]');
  End;

end;

function TAceTot.fInsereDireitoOperadorAutBan(strSQLIns: String): Boolean;
begin
  Result := False;

  Try

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQLIns);
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fGravaDireitoOperadorAutBan]');
  End;

end;

function TAceTot.fInsereDireitoOperadorAutTin(strSQLIns: String): Boolean;
begin
  Result := False;

  Try

    With qryGeneri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQLIns);
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fGravaDireitoOperadorAutTin]');
  End;

end;

function TAceTot.fGravar: Boolean;
Var
  strMensag: String;
begin
  If (tipTipDir = tdiAutcom) Then
    strMensag := 'Deseja realmente dar direito de acesso total ao Sistema para todos os Operadores/Grupos selecionados?'
  Else
  If (tipTipDir = tdiAutcomRemocao) Then
    strMensag := 'Deseja realmente remover direito de acesso total ao Sistema para todos os Operadores/Grupos selecionados?'
  Else
    strMensag := 'Deseja realmente dar direito de acesso total ao Sistema para todos os Operadores selecionados?';

  Result := False;
  If (fMensagem('ATENÇÃO', strMensag, ['&S i m', '&N ã o'], 1) = 1) Then
  Begin
    fStartTransaction;

    If (tipTipDir = tdiAutcom) Then
    Begin
      Result := fGravarOperadores And
                fGravarGrupos;
    End
    Else If (tipTipDir = tdiAutBan) Then
    Begin
      Result := fGravarOperadoresAutBan;
    End
    Else If (tipTipDir = tdiAutTin) Then
    Begin
      Result := fGravarOperadoresAutTin;
    End
    Else
    If (tipTipDir = tdiAutcomRemocao) Then
    Begin
      Result := fGravarOperadores And
                fGravarGrupos;
    End;

    If (Result) Then
    Begin
      fCommit;
      If (tipTipDir = tdiAutcomRemocao) Then
        fMensagem('', 'Remoção de Acesso gravada com sucesso!', ['&O k'])
      Else
        fMensagem('', 'Direitos de Acesso gravados com sucesso!', ['&O k']);
    End
    Else
    Begin
      fRollBack;
      If (tipTipDir = tdiAutcomRemocao) Then
        fMensagem('', 'Não foi possível gravar a Remoção de Acesso.', ['&O k'])
      Else
        fMensagem('', 'Não foi possível gravar os Direitos de Acesso.', ['&O k']);
    End;
  End;
end;

function TAceTot.fGravarGrupos: Boolean;
begin
  Result := False;

  If (fGrupoSelecionado) Then
  Begin

    Try

      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando. fExecutarAcao := fGravarGruposInterna;
      frmGravando.showModal;
      Result := frmGravando.blnConfirma;

    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TAceTot.fGravarGrupos]');
    End;

    pFreeAndNil(frmGravando);
  End
  Else
    Result := True;

end;

function TAceTot.fGravarGruposInterna(pgbProgresso: TcxProgressBar): Boolean;
Var
  intRecNo   : Integer;
  intContador: Integer;
  blnConfirma: Boolean;
  strDirIns  : String;
  strValues  : String;
  strValOri  : String;
begin
  Result      := False;
  blnConfirma := False;
  intRecNo    := 0;
  strDirIns   := EmptyStr;
  strValues   := EmptyStr;
  strValOri   := EmptyStr;

  Try
    cdsCadGpo.DisableControls;
    intRecNo := cdsCadGpo.RecNo;

    With cdsCadGpo Do
    Begin
      Filtered := False;
      OnFilterRecord := Nil;
      Filter   := 'GPO_MARDES = ' + QuotedStr('S');
      Filtered := True;
      First;
      pgbProgresso.Properties.Max := RecordCount;

      While Not Eof Do
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde... Removendo Direitos de Acessos Atuais do Grupo: ' + FieldByName('GPO_CODGPO').AsString);
        pStepStatusGravacao(pgbProgresso);

        blnConfirma := fApagaDireitosAtuaisDoGrupo(FieldByName('GPO_CODGPO').AsString);

        If (blnConfirma) And (tipTipDir <> tdiAutcomRemocao) Then
        Begin
          If (strValOri = EmptyStr) Then
          Begin
            For intContador := 0 To stlNomFrm.Count -1 Do
            Begin
              pInfoStatusGravacao(pgbProgresso, 'Aguarde...Preparando Direitos de Acesso do Grupo...' + #13#10  + intToStr(intContador + 1) + '/' + IntToStr(stlNomFrm.Count));

              If (Not fEmptyStr(stlNomFrm[intContador])) And (Pos(','+stlNomFrm[intContador]+',', strDirIns) <= 0) Then
              Begin
                If (strValOri = EmptyStr) Then
                  strValOri := fGetValuesInsertGrupo(stlNomFrm[intContador])
                Else
                  strValOri := strValOri + ',' + fGetValuesInsertGrupo(stlNomFrm[intContador]);

                strDirIns := strDirIns + ',' + stlNomFrm[intContador] + ',';
              End;
            End;
          End;

          If (strValOri <> EmptyStr) Then
          Begin
            strValues := AnsiReplaceStr(strValOri, QuotedStr('CODGPO'), QuotedStr(FieldByName('GPO_CODGPO').AsString));

            pInfoStatusGravacao(pgbProgresso, 'Aguarde...Inserindo Direitos de Acesso do Grupo: ' + FieldByName('GPO_CODGPO').AsString);
            blnConfirma := fInsereDireitoGrupo(fGetSQLInsertGrupo(strValues));

            If (Not blnConfirma) Then
              Break;
          End;

        End;

        If Not blnConfirma Then
          Break;

        Next;
      End;

      Result := blnConfirma;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fGravarGruposInterna]');
  End;

  cdsCadGpo.Filtered := False;
  cdsCadGpo.OnFilterRecord := OnFilterRecordCadGpo;
  cdsCadGpo.Filter   := '';
  cdsCadGpo.Filtered := True;
  cdsCadGpo.RecNo    := intRecNo;
  cdsCadGpo.EnableControls;

end;

function TAceTot.fGravarOperadores: Boolean;
begin

  Result := False;

  If (fOperadorSelecionado) Then
  Begin
    Try

      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando. fExecutarAcao := fGravarOperadoresInterna;
      frmGravando.showModal;
      Result := frmGravando.blnConfirma;

    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TAceTot.fGravarOperadores]');
    End;

    pFreeAndNil(frmGravando);
  End
  Else
    Result := True;

end;

function TAceTot.fGravarOperadoresAutBan: Boolean;
begin

  Result := False;

  If (fOperadorSelecionado) Then
  Begin
    Try

      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando. fExecutarAcao := fGravarOperadoresAutBanInterna;
      frmGravando.showModal;
      Result := frmGravando.blnConfirma;

    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TAceTot.fGravarOperadoresAutBan]');
    End;

    pFreeAndNil(frmGravando);
  End
  Else
    Result := True;
end;

function TAceTot.fGravarOperadoresAutBanInterna(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  intRecNo   : Integer;
  intContador: Integer;
  blnConfirma: Boolean;
  strDirIns  : String;
  strValues  : String;
  strValOri  : String;
begin
  Result      := False;
  blnConfirma := False;
  intRecNo    := 0;
  strDirIns   := EmptyStr;
  strValues   := EmptyStr;
  strValOri   := EmptyStr;

  Try
    cdsCadOpe.DisableControls;
    intRecNo := cdsCadOpe.RecNo;

    With cdsCadOpe Do
    Begin
      Filtered := False;
      OnFilterRecord := Nil;
      Filter   := 'OPE_MARDES = ' + QuotedStr('S');
      Filtered := True;
      First;
      pgbProgresso.Properties.Max := RecordCount;

      While Not Eof Do
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde... Removendo Direitos de Acessos Atuais do Operador: ' + FieldByName('OPE_CODOPE').AsString);
        pStepStatusGravacao(pgbProgresso);

        blnConfirma := fApagaDireitosAtuaisDoOperadorAutBan(FieldByName('OPE_CODOPE').AsString);

        If (blnConfirma) Then
        Begin
          If (strValOri = EmptyStr) Then
          Begin
            For intContador := 0 To stlNomFrm.Count -1 Do
            Begin
              pInfoStatusGravacao(pgbProgresso, 'Aguarde...Preparando Direitos de Acesso...' + #13#10  + intToStr(intContador + 1) + '/' + IntToStr(stlNomFrm.Count));

              If (Not fEmptyStr(stlNomFrm[intContador])) And (Pos(','+stlNomFrm[intContador]+',', strDirIns) <= 0) Then
              Begin
                If (strValOri = EmptyStr) Then
                  strValOri := fGetValuesInsertOperadorAutBan(stlNomFrm[intContador])
                Else
                  strValOri := strValOri + ',' + fGetValuesInsertOperadorAutBan(stlNomFrm[intContador]);

                strDirIns := strDirIns + ',' + stlNomFrm[intContador] + ',';
              End;
            End;
          End;

          If (strValOri <> EmptyStr) Then
          Begin
            strValues := AnsiReplaceStr(strValOri, QuotedStr('CODOPE'), QuotedStr(FieldByName('OPE_CODOPE').AsString));

            pInfoStatusGravacao(pgbProgresso, 'Aguarde...Inserindo Direitos de Acesso do Operador: ' + FieldByName('OPE_CODOPE').AsString);
            blnConfirma := fInsereDireitoOperadorAutBan(fGetSQLInsertOperadorAutBan(strValues)) And
                           fGravarLogDir('ACESSO TOTAL', 'DIRBAN', FieldByName('OPE_CODOPE').AsString, '', 'IAE');

            If (Not blnConfirma) Then
              Break;
          End;

        End
        Else
          Break;

        Next;
      End;

      Result := blnConfirma;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fGravarOperadoresAutBanInterna]');
  End;

  cdsCadOpe.Filtered := False;
  cdsCadOpe.OnFilterRecord := OnFilterRecordCadOpe;
  cdsCadOpe.Filter   := '';
  cdsCadOpe.Filtered := True;
  cdsCadOpe.RecNo    := intRecNo;
  cdsCadOpe.EnableControls;

end;

function TAceTot.fGravarOperadoresAutTin: Boolean;
begin

  Result := False;

  If (fOperadorSelecionado) Then
  Begin
    Try

      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando. fExecutarAcao := fGravarOperadoresAutTinInterna;
      frmGravando.showModal;
      Result := frmGravando.blnConfirma;

    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TAceTot.fGravarOperadoresAutTin]');
    End;

    pFreeAndNil(frmGravando);
  End
  Else
    Result := True;
end;

function TAceTot.fGravarOperadoresAutTinInterna(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  intRecNo   : Integer;
  intContador: Integer;
  blnConfirma: Boolean;
  strDirIns  : String;
  strValues  : String;
  strValOri  : String;
begin
  Result      := False;
  blnConfirma := False;
  intRecNo    := 0;
  strDirIns   := EmptyStr;
  strValues   := EmptyStr;
  strValOri   := EmptyStr;

  Try
    cdsCadOpe.DisableControls;
    intRecNo := cdsCadOpe.RecNo;

    With cdsCadOpe Do
    Begin
      Filtered := False;
      OnFilterRecord := Nil;
      Filter   := 'OPE_MARDES = ' + QuotedStr('S');
      Filtered := True;
      First;
      pgbProgresso.Properties.Max := RecordCount;

      While Not Eof Do
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde... Removendo Direitos de Acessos Atuais do Operador: ' + FieldByName('OPE_CODOPE').AsString);
        pStepStatusGravacao(pgbProgresso);

        blnConfirma := fApagaDireitosAtuaisDoOperadorAutTin(FieldByName('OPE_CODOPE').AsString);

        If (blnConfirma) Then
        Begin
          If (strValOri = EmptyStr) Then
          Begin
            For intContador := 0 To stlNomFrm.Count -1 Do
            Begin
              pInfoStatusGravacao(pgbProgresso, 'Aguarde...Preparando Direitos de Acesso...' + #13#10  + intToStr(intContador + 1) + '/' + IntToStr(stlNomFrm.Count));

              If (Not fEmptyStr(stlNomFrm[intContador])) And (Pos(','+stlNomFrm[intContador]+',', strDirIns) <= 0) Then
              Begin
                If (strValOri = EmptyStr) Then
                  strValOri := fGetValuesInsertOperadorAutTin(stlNomFrm[intContador])
                Else
                  strValOri := strValOri + ',' + fGetValuesInsertOperadorAutTin(stlNomFrm[intContador]);

                strDirIns := strDirIns + ',' + stlNomFrm[intContador] + ',';
              End;
            End;
          End;

          If (strValOri <> EmptyStr) Then
          Begin
            strValues := AnsiReplaceStr(strValOri, QuotedStr('CODOPE'), QuotedStr(FieldByName('OPE_CODOPE').AsString));

            pInfoStatusGravacao(pgbProgresso, 'Aguarde...Inserindo Direitos de Acesso do Operador: ' + FieldByName('OPE_CODOPE').AsString);
            blnConfirma := fInsereDireitoOperadorAutTin(fGetSQLInsertOperadorAutTin(strValues)) And
                           fGravarLogDir('ACESSO TOTAL', 'DIRTIN', FieldByName('OPE_CODOPE').AsString, '', 'IAE');

            If (Not blnConfirma) Then
              Break;
          End;

        End
        Else
          Break;

        Next;
      End;

      Result := blnConfirma;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fGravarOperadoresAutTinInterna]');
  End;

  cdsCadOpe.Filtered := False;
  cdsCadOpe.OnFilterRecord := OnFilterRecordCadOpe;
  cdsCadOpe.Filter   := '';
  cdsCadOpe.Filtered := True;
  cdsCadOpe.RecNo    := intRecNo;
  cdsCadOpe.EnableControls;


end;

function TAceTot.fGravarOperadoresInterna(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  intRecNo   : Integer;
  intContador: Integer;
  blnConfirma: Boolean;
  strDirIns  : String;
  strValues  : String;
  strValOri  : String;
begin
  Result      := False;
  blnConfirma := False;
  intRecNo    := 0;
  strDirIns   := EmptyStr;
  strValues   := EmptyStr;
  strValOri   := EmptyStr;

  Try
    cdsCadOpe.DisableControls;
    intRecNo := cdsCadOpe.RecNo;

    With cdsCadOpe Do
    Begin
      Filtered := False;
      OnFilterRecord := nil;
      Filter   := 'OPE_MARDES = ' + QuotedStr('S');
      Filtered := True;
      First;
      pgbProgresso.Properties.Max := RecordCount;

      While Not Eof Do
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde... Removendo Direitos de Acessos Atuais do Operador: ' + FieldByName('OPE_CODOPE').AsString);
        pStepStatusGravacao(pgbProgresso);

        blnConfirma := fApagaDireitosAtuaisDoOperador(FieldByName('OPE_CODOPE').AsString);

        If (blnConfirma) And (tipTipDir <> tdiAutcomRemocao) Then
        Begin
          If (strValOri = EmptyStr) Then
          Begin
            For intContador := 0 To stlNomFrm.Count -1 Do
            Begin
              pInfoStatusGravacao(pgbProgresso, 'Aguarde...Preparando Direitos de Acesso...' + #13#10  + intToStr(intContador + 1) + '/' + IntToStr(stlNomFrm.Count));

              If (Not fEmptyStr(stlNomFrm[intContador])) And (Pos(','+stlNomFrm[intContador]+',', strDirIns) <= 0) Then
              Begin
                If (strValOri = EmptyStr) Then
                  strValOri := fGetValuesInsertOperador(stlNomFrm[intContador])
                Else
                  strValOri := strValOri + ',' + fGetValuesInsertOperador(stlNomFrm[intContador]);

                strDirIns := strDirIns + ',' + stlNomFrm[intContador] + ',';
              End;
            End;
          End;

          If (strValOri <> EmptyStr) Then
          Begin
            strValues := AnsiReplaceStr(strValOri, QuotedStr('CODOPE'), QuotedStr(FieldByName('OPE_CODOPE').AsString));

            pInfoStatusGravacao(pgbProgresso, 'Aguarde...Inserindo Direitos de Acesso do Operador: ' + FieldByName('OPE_CODOPE').AsString);
            blnConfirma := fInsereDireitoOperador(fGetSQLInsertOperador(strValues));

            If (Not blnConfirma) Then
              Break;
          End;

        End;

        If (Not blnConfirma) Then
          Break;

        Next;
      End;

      Result := blnConfirma;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fGravarOperadoresInterna]');
  End;

  cdsCadOpe.Filtered := False;
  cdsCadOpe.OnFilterRecord := OnFilterRecordCadOpe;
  cdsCadOpe.Filter   := '';
  cdsCadOpe.Filtered := True;
  cdsCadOpe.RecNo    := intRecNo;
  cdsCadOpe.EnableControls;

end;

function TAceTot.fGrupoSelecionado: Boolean;
Var
  cdsTmp: TUniClientDataSet;
begin
  Result := False;

  Try
    cdsTmp := TUniClientDataSet.Create(Nil);
    cdsTmp.Data     := cdsCadGpo.Data;
    cdsTmp.Filter   := 'GPO_MARDES = ' + QuotedStr('S');
    cdsTmp.Filtered := True;
    cdsTmp.Open;
    Result := cdsTmp.RecordCount > 0;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fGrupoSelecionado]');
  End;

  FreeAndNil(cdsTmp);
end;

procedure TAceTot.OnFilterRecordCadGpo(DataSet: TDataSet; var Accept: Boolean);
Var
  LPalavra: String;
  LPalavras: TStringList;
begin
  inherited;
  Accept := True;

  If Not Assigned(FEditPesqGpo) Then
    Exit;

  LPalavras := fGetPalavras(FEditPesqGpo);
  Try
    If FEditPesqGpo.Text <> INFO_PESQUISA Then
      For LPalavra In LPalavras Do
        Accept := Accept And fRemoveAcento(DataSet.FieldByName('GPO_CODGPO').AsString + ' ' +
          DataSet.FieldByName('GPO_DESCRI').AsString).ToUpper.Contains(fRemoveAcento(LPalavra).ToUpper);
  Finally
    FreeAndNil(LPalavras);
  End;
end;

procedure TAceTot.OnFilterRecordCadOpe(DataSet: TDataSet; var Accept: Boolean);
Var
  LPalavra: String;
  LPalavras: TStringList;
begin
  inherited;
  Accept := True;

  If Not Assigned(FEditPesqOpe) Then
    Exit;

  LPalavras := fGetPalavras(FEditPesqOpe);
  Try
    If FEditPesqOpe.Text <> INFO_PESQUISA Then
      For LPalavra In LPalavras Do
        Accept := Accept And fRemoveAcento(DataSet.FieldByName('OPE_CODOPE').AsString + ' ' +
          DataSet.FieldByName('OPE_NOMOPE').AsString).ToUpper.Contains(fRemoveAcento(LPalavra).ToUpper);
  Finally
    FreeAndNil(LPalavras);
  End;
end;

function TAceTot.fMarcaDesmarcaTotalGrupo(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  intRecNo: Integer;
begin
  intRecNo := cdsCadGpo.RecNo;

  Try
    cdsCadGpo.DisableControls;
    pgbProgresso.Properties.Max := cdsCadGpo.RecordCount;

    With cdsCadGpo Do
    Begin
      First;

      While Not Eof Do
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde...' + IfThen(Self.blnMarcar, 'Marcando', 'Desmarcando')+ ' Grupos ' + IntToStr(RecNo) + ' de ' + IntToStr(RecordCount));
        pStepStatusGravacao(pgbProgresso);

        If (tipTipDir = tdiAutcomRemocao) Then
        Begin
          If fVerificaSeExisteDireitoDeAcessoVinculadoAoGrupo(FieldByName('GPO_CODGPO').AsString) Then
          Begin
            Edit;
            FieldByName('GPO_MARDES').AsString := IfThen(Self.blnMarcar, 'S', 'N');
            Post;
          End;
        End
        Else
        Begin
          Edit;
          FieldByName('GPO_MARDES').AsString := IfThen(Self.blnMarcar, 'S', 'N');
          Post;
        End;

        Next;
      End;

      Result := True;
    End;
  Finally
    cdsCadGpo.RecNo := intRecNo;
    cdsCadGpo.EnableControls;
  End;
end;

function TAceTot.fMarcaDesmarcaTotalOperador(pgbProgresso: TcxProgressBar): Boolean;
Var
  intRecNo: Integer;
begin
  intRecNo := cdsCadOpe.RecNo;

  Try
    cdsCadOpe.DisableControls;
    pgbProgresso.Properties.Max := cdsCadOpe.RecordCount;

    With cdsCadOpe Do
    Begin
      First;

      While Not Eof Do
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde...' + IfThen(Self.blnMarcar, 'Marcando', 'Desmarcando')+ ' Operadores ' + IntToStr(RecNo) + ' de ' + IntToStr(RecordCount));
        pStepStatusGravacao(pgbProgresso);

        If (tipTipDir = tdiAutcomRemocao) Then
        Begin
          If fVerificaSeExisteDireitoDeAcessoVinculadoAoOperador(FieldByName('OPE_CODOPE').AsString) Then
          Begin
            Edit;
            FieldByName('OPE_MARDES').AsString := IfThen(Self.blnMarcar, 'S', 'N');
            Post;
          End;
        End
        Else
        Begin
          Edit;
          FieldByName('OPE_MARDES').AsString := IfThen(Self.blnMarcar, 'S', 'N');
          Post;
        End;

        Next;
      End;

      Result := True;
    End;
  Finally
    cdsCadOpe.RecNo := intRecNo;
    cdsCadOpe.EnableControls;
  End;
end;

function TAceTot.fOperadorSelecionado: Boolean;
Var
  cdsTmp: TUniClientDataSet;
begin
  Result := False;

  Try
    cdsTmp := TUniClientDataSet.Create(Nil);
    cdsTmp.Data     := cdsCadOpe.Data;
    cdsTmp.Filter   := 'OPE_MARDES = ' + QuotedStr('S');
    cdsTmp.Filtered := True;
    cdsTmp.Open;
    Result := cdsTmp.RecordCount > 0;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TAceTot.fOperadorSelecionado]');
  End;

  FreeAndNil(cdsTmp);
end;


function TAceTot.fTemRegistroSelecionado: Boolean;
begin
  Result := fOperadorSelecionado;

  If (Not Result) Then
    Result := fGrupoSelecionado;
end;

function TAceTot.fVerificaSeExisteDireitoDeAcessoVinculadoAoGrupo(
  strCodGpo: String): Boolean;
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery();
  Try
    qryAux.Close;
    qryAux.Sql.Clear;
    qryAux.Sql.Add(' SELECT COUNT(1) AS QTD     ');
    qryAux.Sql.Add('  FROM DIRGPO               ');
    qryAux.Sql.Add(' WHERE GPO_CODGPO = :CODOPE ');

    qryAux.ParamByName('CODOPE').AsString := strCodGpo;

    qryAux.Open;

    Result := qryAux.FieldByName('QTD').AsFloat > 0;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TAceTot.fVerificaSeExisteDireitoDeAcessoVinculadoAoOperador(
  strCodOpe: String): Boolean;
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery();
  Try
    qryAux.Close;
    qryAux.Sql.Clear;
    qryAux.Sql.Add(' SELECT COUNT(1) AS QTD     ');
    qryAux.Sql.Add('  FROM DIROPE               ');
    qryAux.Sql.Add(' WHERE OPE_CODOPE = :CODOPE ');

    qryAux.ParamByName('CODOPE').AsString := strCodOpe;

    qryAux.Open;

    Result := qryAux.FieldByName('QTD').AsFloat > 0;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TAceTot.getCdsGpo: TDataSet;
begin
  Result := cdsCadGpo;
end;

function TAceTot.getCdsOpe: TDataSet;
begin
  Result := cdsCadOpe;
end;

function TAceTot.getMarcarGpo: Boolean;
begin
  Result := True;

  If (cdsCadGpo.FieldByName('GPO_MARDES').AsString = 'S') Then
    Result := False;
end;

function TAceTot.getMarcarOpe: Boolean;
begin
  Result := True;

  If (cdsCadOpe.FieldByName('OPE_MARDES').AsString = 'S') Then
    Result := False;
end;

function TAceTot.getTipoOperacao: TTipDir;
begin
  Result := tipTipDir;
end;

procedure TAceTot.pDestroiComponentes;
begin
  FreeAndNil(cdsCadOpe);
  FreeAndNil(cdsCadGpo);
  FreeAndNil(dspCadOpe);
  FreeAndNil(dspCadGpo);
  FreeAndNil(qryCadOpe);
  FreeAndNil(qryCadGpo);
  FreeAndNil(qryGeneri);
end;

procedure TAceTot.pMarcaDesmarcaGrupo(blnMarcar: Boolean);
begin
  If (Not cdsCadGpo.IsEmpty) Then
  Begin
    cdsCadGpo.Edit;
    cdsCadGpo.FieldByName('GPO_MARDES').AsString := IfThen(blnMarcar, 'S', 'N');
    cdsCadGpo.Post;
  End;
end;

procedure TAceTot.pMarcaDesmarcaOperador(blnMarcar: Boolean);
begin
  If (Not cdsCadOpe.IsEmpty) Then
  Begin
    cdsCadOpe.Edit;
    cdsCadOpe.FieldByName('OPE_MARDES').AsString := IfThen(blnMarcar, 'S', 'N');
    cdsCadOpe.Post;
  End;
end;

procedure TAceTot.pMarcaDesmarcaTotalGrupo(blnMarcar: Boolean);
begin

  Try

    Self.blnMarcar := blnMarcar;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fMarcaDesmarcaTotalGrupo;
    frmGravando.ShowModal;

  Except
    On E: Exception Do
      pMensagensErro(e.message, '[TAceTot.pMarcaDesmarcaTotalGrupo]');
  End;

  pFreeAndNil(frmGravando);

end;

procedure TAceTot.pMarcaDesmarcaTotalOperador(blnMarcar: Boolean);
begin

  Try

    Self.blnMarcar := blnMarcar;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fMarcaDesmarcaTotalOperador;
    frmGravando.ShowModal;

  Except
    On E: Exception Do
      pMensagensErro(e.message, '[TAceTot.pMarcaDesmarcaTotalOperador]');
  End;

  pFreeAndNil(frmGravando);

end;

procedure TAceTot.pPreparaComponentes;
begin
  qryGeneri := fCriaQuery(Nil);
  qryCadOpe := fCriaQuery(Nil);
  qryCadGpo := fCriaQuery(Nil);

  cdsCadOpe := TUniClientDataSet.Create(Nil);
  cdsCadGpo := TUniClientDataSet.Create(Nil);

  dspCadOpe := TUniDataSetProvider.Create(Nil);
  dspCadGpo := TUniDataSetProvider.Create(Nil);

  dspCadOpe.DataSet := qryCadOpe;
  dspCadGpo.DataSet := qryCadGpo;

  cdsCadOpe.SetProvider(dspCadOpe);
  cdsCadGpo.SetProvider(dspCadGpo);
end;

procedure TAceTot.pPreparaDados;
begin
  Try

    With qryCadOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLOperador);
      Open;
      pSetaClient(qryCadOpe);
      cdsCadOpe.Open;
      pSetaClient(cdsCadOpe);
    End;

    cdsCadOpe.OnFilterRecord := OnFilterRecordCadOpe;

    With qryCadGpo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLGrupo);
      Open;
      pSetaClient(qryCadGpo);
      cdsCadGpo.Open;
      pSetaClient(cdsCadGpo);
    End;

    cdsCadGpo.OnFilterRecord := OnFilterRecordCadGpo;

  Except
    On E: Exception DO
      pMensagensErro(e.Message, '[TAceTot.pPreparaDados]');
  End;
end;

procedure TAceTot.SetPesqGrupo(AEdit: TEdit);
begin
  FEditPesqGpo := AEdit;
end;

procedure TAceTot.SetPesqOperador(AEdit: TEdit);
begin
  FEditPesqOpe := AEdit;
end;

function TAceTot.TemPesquisa: Boolean;
begin
  Result := True;
end;

end.
