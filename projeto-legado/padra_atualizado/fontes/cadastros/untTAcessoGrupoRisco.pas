unit untTAcessoGrupoRisco;

interface

uses
  Classes, DB, SysUtils, StrUtils, Uni, cxProgressBar, untZClient, untIGravaDireitoAcesso, StdCtrls, untTypesSistema;

type
  TAcessoGrupoRisco = class(TInterfacedObject, IGravaDireitoAcesso)
  private
    strAutoincGrupoRisco: String;
    cdsOperador,
    cdsGrupo: TDataSet;
    blnMarcar: Boolean;
    tipTipDir: TTipDir;
    function fMarcaDesmarcaTotalOperador(pgbProgresso: TcxProgressBar): Boolean;
    function fMarcaDesmarcaTotalGrupo(pgbProgresso: TcxProgressBar): Boolean;

    function fCriaZClientOperador(): TZClient;
    function fOperadoresExcluir(): String;
    procedure pInsereOperador(strCodOpe: String);
    procedure pExcluiOperadoresNaoSelecionados();
    procedure pInsereOperadoresSelecionados();

    function fCriaZClientGrupo(): TZClient;
    function fGruposExcluir(): String;
    procedure pInsereGrupo(intCodGpo: Integer);
    procedure pExcluiGruposNaoSelecionados();
    procedure pInsereGruposSelecionados();
  public
    constructor Create(strAutoincGrupoRisco: String);
    destructor Destroy(); override;

    function getCdsOpe: TDataSet;
    function getCdsGpo: TDataSet;

    procedure SetPesqOperador(AEdit: TEdit);
    procedure SetPesqGrupo(AEdit: TEdit);

    function TemPesquisa(): Boolean;

    function getMarcarOpe: Boolean;
    function getMarcarGpo: Boolean;

    function fTemRegistroSelecionado: Boolean;

    procedure pMarcaDesmarcaOperador(blnMarcar: Boolean);
    procedure pMarcaDesmarcaGrupo(blnMarcar: Boolean);

    procedure pMarcaDesmarcaTotalOperador(blnMarcar: Boolean);
    procedure pMarcaDesmarcaTotalGrupo(blnMarcar: Boolean);

    function  fGravar: Boolean;

    function fVerificaSeExisteDireitoDeAcessoVinculadoAoOperador(strCodOpe: String): Boolean;
    function fVerificaSeExisteDireitoDeAcessoVinculadoAoGrupo(strCodGpo: String): Boolean;

    function getTipoOperacao: TTipDir;
  end;

implementation

{ TAcessoGrupoRisco }

uses untFuncoesSimples, untGravando;

constructor TAcessoGrupoRisco.Create(strAutoincGrupoRisco: String);
begin
  Self.strAutoincGrupoRisco := strAutoincGrupoRisco;
  Self.cdsOperador := fCriaZClientOperador();
  Self.cdsGrupo    := fCriaZClientGrupo();
end;

destructor TAcessoGrupoRisco.Destroy;
begin
  FreeAndNil(cdsOperador);
  FreeAndNil(cdsGrupo);

  inherited;
end;

function TAcessoGrupoRisco.fCriaZClientGrupo: TZClient;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                       ';
  strSQL := strSQL + '  GPO_CODGPO,                ';
  strSQL := strSQL + '  GPO_DESCRI,                ';
  strSQL := strSQL + '  IF(                        ';
  strSQL := strSQL + '    GRG_CODGPO IS NULL,      ';
  strSQL := strSQL + '    "N",                     ';
  strSQL := strSQL + '    "S"                      ';
  strSQL := strSQL + '  ) AS GPO_MARDES,           ';
  strSQL := strSQL + '  IF(                        ';
  strSQL := strSQL + '    GRG_CODGPO IS NULL,      ';
  strSQL := strSQL + '    "N",                     ';
  strSQL := strSQL + '    "S"                      ';
  strSQL := strSQL + '  ) AS GPO_INSERI            ';
  strSQL := strSQL + 'FROM                         ';
  strSQL := strSQL + '  CADGPO                     ';
  strSQL := strSQL + 'LEFT JOIN GRRGRU             ';
  strSQL := strSQL + '  ON GRG_CODGPO = GPO_CODGPO ';
  strSQL := strSQL + '  AND GRG_SEQGRR = :SEQGRR   ';
  strSQL := strSQL + 'ORDER BY GPO_DESCRI          ';

  Result := TZClient.Create(Nil, strSQL);
  Result.qryQuery.Close;
  Result.qryQuery.ParamByName('SEQGRR').AsString := strAutoincGrupoRisco;
  Result.fAbreClient(True, 'fCriaZClientGrupo');
end;

function TAcessoGrupoRisco.fCriaZClientOperador: TZClient;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                       ';
  strSQL := strSQL + '  OPE_CODOPE,                ';
  strSQL := strSQL + '  OPE_NOMOPE,                ';
  strSQL := strSQL + '  IF(                        ';
  strSQL := strSQL + '    GRO_CODOPE IS NULL,      ';
  strSQL := strSQL + '    "N",                     ';
  strSQL := strSQL + '    "S"                      ';
  strSQL := strSQL + '  ) AS OPE_MARDES,           ';
  strSQL := strSQL + '  IF(                        ';
  strSQL := strSQL + '    GRO_CODOPE IS NULL,      ';
  strSQL := strSQL + '    "N",                     ';
  strSQL := strSQL + '    "S"                      ';
  strSQL := strSQL + '  ) AS OPE_INSERI            ';
  strSQL := strSQL + 'FROM                         ';
  strSQL := strSQL + '  CADOPE                     ';
  strSQL := strSQL + 'LEFT JOIN GRROPE             ';
  strSQL := strSQL + '  ON GRO_CODOPE = OPE_CODOPE ';
  strSQL := strSQL + '  AND GRO_SEQGRR = :SEQGRR   ';
  strSQL := strSQL + 'ORDER BY OPE_NOMOPE          ';

  Result := TZClient.Create(Nil, strSQL);
  Result.qryQuery.Close;
  Result.qryQuery.ParamByName('SEQGRR').AsString := strAutoincGrupoRisco;
  Result.fAbreClient(True, 'fCriaZClientOperador');
end;

function TAcessoGrupoRisco.fGravar: Boolean;
begin
  Try
    pExcluiOperadoresNaoSelecionados();
    pInsereOperadoresSelecionados();
    pExcluiGruposNaoSelecionados();
    pInsereGruposSelecionados();

    Result := True;
  Except
    On e: Exception Do
    Begin
      pMensagensErro(e.Message, '[TAcessoGrupoRisco.fGravar]');
      Result := False;
    End;
  End;
end;

function TAcessoGrupoRisco.fGruposExcluir: String;
var
  intRecNo: Integer;
begin
  With cdsGrupo Do
  Begin
    intRecNo := RecNo;
    DisableControls;
    Try
      First;
      Result := '';
      While Not Eof Do
      Begin
        If (FieldByName('GPO_MARDES').AsString = 'N') And
           (FieldByName('GPO_INSERI').AsString = 'S') Then
        Begin
          If Not fEmptyStr(Result) Then
            Result := Result + ',';

          Result := Result + FieldByName('GPO_CODGPO').AsString;
        End;

        Next;
      End;
    Finally
      RecNo := intRecNo;
      EnableControls;
    End;
  End;
end;

function TAcessoGrupoRisco.fMarcaDesmarcaTotalGrupo(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  intRecNo: Integer;
begin
  With cdsGrupo Do
  Begin
    intRecNo := RecNo;
    DisableControls;

    Try
      pgbProgresso.Properties.Max := RecordCount;

      First;
      While Not Eof Do
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde...' + IfThen(Self.blnMarcar, 'Marcando', 'Desmarcando')+ ' Grupos ' + IntToStr(RecNo) + ' de ' + IntToStr(RecordCount));
        pStepStatusGravacao(pgbProgresso);

        pMarcaDesmarcaGrupo(Self.blnMarcar);

        Next;
      End;

      Result := True;
    Finally
      RecNo := intRecNo;
      EnableControls;
    End;
  End;
end;

function TAcessoGrupoRisco.fMarcaDesmarcaTotalOperador(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  intRecNo: Integer;
begin
  With cdsOperador Do
  Begin
    intRecNo := RecNo;
    DisableControls;

    Try
      pgbProgresso.Properties.Max := RecordCount;

      First;
      While Not Eof Do
      Begin
        pInfoStatusGravacao(pgbProgresso, 'Aguarde...' + IfThen(Self.blnMarcar, 'Marcando', 'Desmarcando')+ ' Operadores ' + IntToStr(RecNo) + ' de ' + IntToStr(RecordCount));
        pStepStatusGravacao(pgbProgresso);

        pMarcaDesmarcaOperador(Self.blnMarcar);

        Next;
      End;

      Result := True;
    Finally
      RecNo := intRecNo;
      EnableControls;
    End;
  End;
end;

function TAcessoGrupoRisco.fOperadoresExcluir: String;
var
  intRecNo: Integer;
begin
  With cdsOperador Do
  Begin
    intRecNo := RecNo;
    DisableControls;
    Try
      First;
      Result := '';
      While Not Eof Do
      Begin
        If (FieldByName('OPE_MARDES').AsString = 'N') And
           (FieldByName('OPE_INSERI').AsString = 'S') Then
        Begin
          If Not fEmptyStr(Result) Then
            Result := Result + ',';

          Result := Result + QuotedStr(FieldByName('OPE_CODOPE').AsString);
        End;

        Next;
      End;
    Finally
      RecNo := intRecNo;
      EnableControls;
    End;
  End;
end;

function TAcessoGrupoRisco.fTemRegistroSelecionado: Boolean;
begin
  Result := True;
end;

function TAcessoGrupoRisco.fVerificaSeExisteDireitoDeAcessoVinculadoAoGrupo(
  strCodGpo: String): Boolean;
begin
  Result := Self.fVerificaSeExisteDireitoDeAcessoVinculadoAoGrupo(strCodGpo);
end;

function TAcessoGrupoRisco.fVerificaSeExisteDireitoDeAcessoVinculadoAoOperador(
  strCodOpe: String): Boolean;
begin
  Result := Self.fVerificaSeExisteDireitoDeAcessoVinculadoAoOperador(strCodOpe);
end;

function TAcessoGrupoRisco.getCdsGpo: TDataSet;
begin
  Result := Self.cdsGrupo;
end;

function TAcessoGrupoRisco.getCdsOpe: TDataSet;
begin
  Result := Self.cdsOperador;
end;

function TAcessoGrupoRisco.getMarcarGpo: Boolean;
begin
  Result := cdsGrupo.FieldByName('GPO_MARDES').AsString = 'N';
end;

function TAcessoGrupoRisco.getMarcarOpe: Boolean;
begin
  Result := cdsOperador.FieldByName('OPE_MARDES').AsString = 'N';
end;

function TAcessoGrupoRisco.getTipoOperacao: TTipDir;
begin
  Result := Self.tipTipDir;
end;

procedure TAcessoGrupoRisco.pExcluiGruposNaoSelecionados;
var
  strSql, strGruExc: String;
  qryAux: TUniQuery;
begin
  strGruExc := fGruposExcluir();

  If fEmptyStr(strGruExc) Then
    Exit;

  strSql := '';
  strSql := strSql + 'DELETE FROM GRRGRU ';
  strSql := strSql + 'WHERE GRG_SEQGRR = :SEQGRR ';
  strSql := strSql + '  AND GRG_CODGPO IN (' + strGruExc + ')';

  qryAux := fCriaQuery();
  Try
    With qryAux Do
    Begin
      SQL.Text := strSql;
      ParamByName('SEQGRR').AsString := strAutoincGrupoRisco;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TAcessoGrupoRisco.pExcluiOperadoresNaoSelecionados;
var
  strSql, strOpeExc: String;
  qryAux: TUniQuery;
begin
  strOpeExc := fOperadoresExcluir();

  if fEmptyStr(strOpeExc) Then
    Exit;

  strSql := '';
  strSql := strSql + 'DELETE FROM GRROPE ';
  strSql := strSql + 'WHERE GRO_SEQGRR = :SEQGRR ';
  strSql := strSql + '  AND GRO_CODOPE IN (' + strOpeExc + ')';

  qryAux := fCriaQuery();
  Try
    With qryAux Do
    Begin
      SQL.Text := strSql;
      ParamByName('SEQGRR').AsString := strAutoincGrupoRisco;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TAcessoGrupoRisco.pInsereGrupo(intCodGpo: Integer);
var
  strSql: String;
  qryAux: TUniQuery;
begin
  strSql := '';
  strSql := strSql + 'INSERT INTO GRRGRU ( ';
  strSql := strSql + '  AUTOINCREM,        ';
  strSql := strSql + '  GRG_SEQGRR,        ';
  strSql := strSql + '  GRG_CODGPO         ';
  strSql := strSql + ') VALUES (           ';
  strSql := strSql + '  :AUTOINCREM,       ';
  strSql := strSql + '  :SEQGRR,           ';
  strSql := strSql + '  :CODGPO            ';
  strSql := strSql + ')                    ';

  qryAux := fCriaQuery();
  Try
    With qryAux Do
    Begin
      SQL.Text := strSql;
      ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('GRRGRU', VS_strCodEmp);
      ParamByName('SEQGRR').AsString := strAutoincGrupoRisco;
      ParamByName('CODGPO').AsInteger := intCodGpo;

      ExecSQL;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TAcessoGrupoRisco.pInsereGruposSelecionados;
var
  intRecNo: Integer;
begin
  With cdsGrupo Do
  Begin
    intRecNo := RecNo;
    DisableControls;
    Try
      First;
      While Not Eof Do
      Begin
        If (FieldByName('GPO_MARDES').AsString = 'S') And
           (FieldByName('GPO_INSERI').AsString = 'N') Then
          pInsereGrupo(FieldByName('GPO_CODGPO').AsInteger);

        Next;
      End;
    Finally
      RecNo := intRecNo;
      EnableControls;
    End;
  End;
end;

procedure TAcessoGrupoRisco.pInsereOperador(strCodOpe: String);
var
  strSql: String;
  qryAux: TUniQuery;
begin
  strSql := '';
  strSql := strSql + 'INSERT INTO GRROPE ( ';
  strSql := strSql + '  AUTOINCREM,        ';
  strSql := strSql + '  GRO_SEQGRR,        ';
  strSql := strSql + '  GRO_CODOPE         ';
  strSql := strSql + ') VALUES (           ';
  strSql := strSql + '  :AUTOINCREM,       ';
  strSql := strSql + '  :SEQGRR,           ';
  strSql := strSql + '  :CODOPE            ';
  strSql := strSql + ')                    ';

  qryAux := fCriaQuery();
  Try
    With qryAux Do
    Begin
      SQL.Text := strSql;
      ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('GRROPE', VS_strCodEmp);
      ParamByName('SEQGRR').AsString := strAutoincGrupoRisco;
      ParamByName('CODOPE').AsString := strCodOpe;

      ExecSQL;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TAcessoGrupoRisco.pInsereOperadoresSelecionados;
var
  intRecNo: Integer;
begin
  With cdsOperador Do
  Begin
    intRecNo := RecNo;
    DisableControls;
    Try
      First;
      While Not Eof Do
      Begin
        If (FieldByName('OPE_MARDES').AsString = 'S') And
           (FieldByName('OPE_INSERI').AsString = 'N') Then
          pInsereOperador(FieldByName('OPE_CODOPE').AsString);

        Next;
      End;
    Finally
      RecNo := intRecNo;
      EnableControls;
    End;
  End;
end;

procedure TAcessoGrupoRisco.pMarcaDesmarcaGrupo(blnMarcar: Boolean);
begin
  If (Not cdsGrupo.IsEmpty) Then
  Begin
    cdsGrupo.Edit;
    cdsGrupo.FieldByName('GPO_MARDES').AsString := IfThen(blnMarcar, 'S', 'N');
    cdsGrupo.Post;
  End;
end;

procedure TAcessoGrupoRisco.pMarcaDesmarcaOperador(blnMarcar: Boolean);
begin
  If (Not cdsOperador.IsEmpty) Then
  Begin
    cdsOperador.Edit;
    cdsOperador.FieldByName('OPE_MARDES').AsString := IfThen(blnMarcar, 'S', 'N');
    cdsOperador.Post;
  End;
end;

procedure TAcessoGrupoRisco.pMarcaDesmarcaTotalGrupo(blnMarcar: Boolean);
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      Self.blnMarcar := blnMarcar;
      frmGravando.fExecutarAcao := fMarcaDesmarcaTotalGrupo;
      frmGravando.ShowModal;
    Finally
      pFreeAndNil(frmGravando);
    End;
  Except
    On E: Exception Do
      pMensagensErro(e.message, '[TAcessoGrupoRisco.pMarcaDesmarcaTotalGrupo]');
  End;
end;

procedure TAcessoGrupoRisco.pMarcaDesmarcaTotalOperador(blnMarcar: Boolean);
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      Self.blnMarcar := blnMarcar;
      frmGravando.fExecutarAcao := fMarcaDesmarcaTotalOperador;
      frmGravando.ShowModal;
    Finally
      pFreeAndNil(frmGravando);
    End;
  Except
    On E: Exception Do
      pMensagensErro(e.message, '[TAcessoGrupoRisco.pMarcaDesmarcaTotalOperador]');
  End;
end;

procedure TAcessoGrupoRisco.SetPesqGrupo(AEdit: TEdit);
begin
  //do something
end;

procedure TAcessoGrupoRisco.SetPesqOperador(AEdit: TEdit);
begin
  //do something
end;

function TAcessoGrupoRisco.TemPesquisa: Boolean;
begin
  Result := False;
end;

end.
