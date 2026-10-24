unit Services.Core.Task.Lock;

interface

uses System.SysUtils, System.StrUtils;

Type
  TTaskLock = class(TInterfacedObject, IInterface)
  public
    class function fGetIdConnectionLock(strNomeTabela: String): String;
    class function fGetIPConnectionLock(strNomeTabela: String): String;
    class function fRetOrigemLock(strNomeTabela: String): String;
    class function fGetTempoDuracaoLock(strNomeTabela: String): Double;

    class function fGetHostLock(strNomeTabela: String;
      blnSohIP: Boolean = False): String;

    class function fGetTentativasLock(strNomeTabela: String): Integer;

    class procedure pZerarTentativasLock(strNomeTabela: String);

    class procedure pDestravaLockForcado(strNomeTabela: String;
      intTentat: Integer = 10);

    class function fLock_Unlock(ANomeTabela: String; ATrava: Boolean;
      ALoopTravamento: Boolean = True; ACon_Id: String = '';
      AOrigem: String = ''): Boolean;
  end;

function fGetTentativasLock(strNomeTabela: String): Integer;

procedure pDestravaLockForcado(strNomeTabela: String; intTentat: Integer = 10);

procedure pZerarTentativasLock(strNomeTabela: String);

procedure pDestravaLCKATC(const strPrefixo : String; const strConexao : String);

function fVerificaLCKATCNomeParcial(const AstrNomeTrava: String): Boolean ;

function fGetHostLock(strNomeTabela: String; blnSohIP: Boolean = False): String;

function fLock_Unlock(ANomeTabela: String; ATrava: Boolean; ALoopTravamento
  : Boolean = True; ACon_Id: String = ''; AOrigem: String = ''): Boolean;

function fGetIdConnectionLock(strNomeTabela: String): String;

implementation

uses Services.Core.Connection.Interfaces, Services.Core.Connection.Manager,
  Services.Core.Settings, Services.Core.Utils;

function fGetIdConnectionLock(strNomeTabela: String): String;
begin
  Result := TTaskLock.fGetIdConnectionLock(strNomeTabela);
end;

function fLock_Unlock(ANomeTabela: String; ATrava: Boolean; ALoopTravamento
  : Boolean = True; ACon_Id: String = ''; AOrigem: String = ''): Boolean;
begin
  Result := TTaskLock.fLock_Unlock(ANomeTabela, ATrava, ALoopTravamento, ACon_Id, AOrigem);
end;

function fGetHostLock(strNomeTabela: String; blnSohIP: Boolean = False): String;
begin
  Result := TTaskLock.fGetHostLock(strNomeTabela, blnSohIP);
end;

function fGetTentativasLock(strNomeTabela: String): Integer;
begin
  Result := TTaskLock.fGetTentativasLock(strNomeTabela);
end;

procedure pDestravaLockForcado(strNomeTabela: String; intTentat: Integer = 10);
begin
  TTaskLock.pDestravaLockForcado(strNomeTabela, intTentat);
end;

procedure pZerarTentativasLock(strNomeTabela: String);
begin
  TTaskLock.pZerarTentativasLock(strNomeTabela);
end;

procedure pDestravaLCKATC(const strPrefixo : String; const strConexao : String);
  Var
    qryLckAtc : IQuery;
begin
  If fEmptyStr(strPrefixo) Then
    Exit;

  If Length(strPrefixo) <= 3 Then
    Exit;

  qryLckAtc := fCriaQuery;
  qryLckAtc.SQL.Add('DELETE FROM LCKATC WHERE LCK_CHAACE LIKE :CHAACE AND LCK_CON_ID = :CON_ID');
  qryLckAtc.ParamByName('CON_ID').AsString := strConexao;
  qryLckAtc.ParamByName('CHAACE').AsString := objConnectionsManager.CurrentConnection.Database + '.' + strPrefixo + '%';
  qryLckAtc.ExecSQL;
end;

function fVerificaLCKATCNomeParcial(const AstrNomeTrava: String): Boolean ;
var
  LqryVerifica: IQuery ;
begin
  LqryVerifica := fCriaQuery;
  LqryVerifica.Close;
  LqryVerifica.SQL.Clear;
  LqryVerifica.SQL.Add('SELECT LCK_CON_ID FROM LCKATC WHERE LCK_CHAACE LIKE :LCK_CHAACE');
  LqryVerifica.ParamByName('LCK_CHAACE').AsString := '%' + AstrNomeTrava + '%' ;
  LqryVerifica.Open;
  Result := not LqryVerifica.IsEmpty;
end;

{ TTaskLock }

class function TTaskLock.fGetHostLock(strNomeTabela: String;
  blnSohIP: Boolean): String;
Var
  qryGen: IQuery;
  strSQL: String;
Begin
  Result := '';

  strNomeTabela := objConnectionsManager.CurrentConnection.Database + '.' +
    strNomeTabela;
  qryGen := objConnectionsManager.CurrentConnection.CreateQuery;

  strSQL := strSQL + '';
  strSQL := strSQL + 'SELECT ';
  If blnSohIP Then
    strSQL := strSQL + '  LCK_NUM_IP '
  Else
    strSQL := strSQL +
      '  CONCAT(LCK_NUM_IP, " - ", " Operador: ", LCK_CODOPE, "-", OPE_NOMOPE) AS LCK_NUM_IP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LCKATC';
  strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = LCK_CODOPE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LCK_CHAACE '+
    IfThen(strNomeTabela.Contains('%'), ' LIKE ', ' = ') + ' :CHAACE ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.Open;

  Result := qryGen.FieldByName('LCK_NUM_IP').AsString;
end;

class function TTaskLock.fGetIdConnectionLock(strNomeTabela: String): String;
Var
  qryGen: IQuery;
  strSQL: String;
Begin
  Result := '';

  strNomeTabela := objConnectionsManager.CurrentConnection.Database + '.' +
    strNomeTabela;
  qryGen := objConnectionsManager.CurrentConnection.CreateQuery;
  // qryGen.SQL.Add('SELECT LCK_NUM_IP FROM LCKATC WHERE LCK_CHAACE LIKE :CHAACE');

  strSQL := strSQL + '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  LCK_CON_ID ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LCKATC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LCK_CHAACE ' +
    IfThen(strNomeTabela.Contains('%'), ' LIKE ', ' = ') + ' :CHAACE ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.Open;

  Result := qryGen.FieldByName('LCK_CON_ID').AsString;
end;

class function TTaskLock.fGetIPConnectionLock(strNomeTabela: String): String;
Var
  qryGen: IQuery;
  strSQL: String;
Begin
  Result := '';

  strNomeTabela := objConnectionsManager.CurrentConnection.Database + '.' +
    strNomeTabela;
  qryGen := objConnectionsManager.CurrentConnection.CreateQuery;

  strSQL := strSQL + '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  LCK_NUM_IP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LCKATC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LCK_CHAACE ' +
    IfThen(strNomeTabela.Contains('%'), ' LIKE ', ' = ') + ' :CHAACE ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.Open;

  Result := qryGen.FieldByName('LCK_NUM_IP').AsString;
end;

class function TTaskLock.fGetTempoDuracaoLock(strNomeTabela: String): Double;
Var
  qryLock: IQuery;
Begin
  qryLock := objConnectionsManager.CurrentConnection.CreateQuery;
  Result := 0;
  With qryLock Do
  Begin
    SQL.Add('SELECT LCK_DTALCK, LCK_HRALCK FROM LCKATC WHERE LCK_CHAACE = :CHAACE');
    ParamByName('CHAACE').AsString := objConnectionsManager.CurrentConnection.Database
      + '.' + strNomeTabela;
    Open;
    If Not IsEmpty Then
      Result := fNow - (FieldByName('LCK_DTALCK').AsDateTime +
        FieldByName('LCK_HRALCK').AsDateTime);
  End;
end;

class function TTaskLock.fGetTentativasLock(strNomeTabela: String): Integer;
Var
  qryGen: IQuery;
  strSQL: String;
Begin
  strNomeTabela := objConnectionsManager.CurrentConnection.Database + '.' +
    strNomeTabela;
  qryGen := objConnectionsManager.CurrentConnection.CreateQuery;
  // qryGen.SQL.Add('SELECT LCK_NUM_IP FROM LCKATC WHERE LCK_CHAACE LIKE :CHAACE');

  strSQL := strSQL + '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  LCK_TENTAT ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LCKATC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LCK_CHAACE ' +
    IfThen(strNomeTabela.Contains('%'), ' LIKE ', ' = ') + ' :CHAACE ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.Open;

  Result := qryGen.FieldByName('LCK_TENTAT').AsInteger;
end;

class function TTaskLock.fLock_Unlock(ANomeTabela: String; ATrava: Boolean;
  ALoopTravamento: Boolean = True; ACon_Id: String = '';
  AOrigem: String = ''): Boolean;
Var
  strLock: String;
  qryLock_Unlock: IQuery;
  blnComitar: Boolean;
Const
  TEMPO_ESPERA = 3000;

  procedure pAtualizaContador;
  begin
    qryLock_Unlock.Close;
    qryLock_Unlock.SQL.Clear;
    qryLock_Unlock.SQL.Add
      ('UPDATE LCKATC SET LCK_TENTAT = LCK_TENTAT + 1 WHERE LCK_CHAACE = :CHAACE');
    qryLock_Unlock.ParamByName('CHAACE').AsString := ANomeTabela;
    qryLock_Unlock.ExecSQL;
  end;

  procedure pIncrementaTrava(blnIncrementa: Boolean);
  begin
    qryLock_Unlock.Close;
    qryLock_Unlock.SQL.Clear;
    If blnIncrementa Then
      qryLock_Unlock.SQL.Add
        ('UPDATE LCKATC SET LCK_QTDTRA = LCK_QTDTRA + 1 WHERE LCK_CHAACE = :CHAACE')
    Else
      qryLock_Unlock.SQL.Add
        ('UPDATE LCKATC SET LCK_QTDTRA = LCK_QTDTRA - 1 WHERE LCK_CHAACE = :CHAACE');

    qryLock_Unlock.ParamByName('CHAACE').AsString := ANomeTabela;
    qryLock_Unlock.ExecSQL;
  end;

  function fExecutaLock: Boolean;
  begin

    Result := False;
    If (blnComitar) Then
      objConnectionsManager.CurrentConnection.StartTransaction;

    qryLock_Unlock.Close;
    qryLock_Unlock.SQL.Clear;
    qryLock_Unlock.SQL.Add(strLock);
    qryLock_Unlock.ParamByName('CHAACE').AsString := ANomeTabela;

    qryLock_Unlock.ParamByName('DTALCK').AsDate := VS_Date;
    qryLock_Unlock.ParamByName('HRALCK').AsDateTime := Time;
    qryLock_Unlock.ParamByName('CON_ID').AsString := ACon_Id;
    qryLock_Unlock.ParamByName('NUM_IP').AsString := VS_IPAddressAsString;
    qryLock_Unlock.ParamByName('MACADD').AsString := VS_MacAddress;
    qryLock_Unlock.ParamByName('NOMMAQ').AsString := VS_ComputerNetName;
    qryLock_Unlock.ParamByName('NOMUSU').AsString := VS_ComputerUser;
    qryLock_Unlock.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryLock_Unlock.ParamByName('ORIGEM').AsString := AOrigem;
    qryLock_Unlock.ParamByName('QTDTRA').AsInteger := 1;

    Try
      qryLock_Unlock.ExecSQL;
      Result := True;
    Except
      On E: Exception Do
      Begin
        If (Pos('DUPLICADA', UpperCase(E.Message)) > 0) Or
          (Pos('DUPLICATE', UpperCase(E.Message)) > 0) Then
        Begin
          pAtualizaContador;

          If (Not AOrigem.IsEmpty) And SameText(fRetOrigemLock(ANomeTabela),
            AOrigem) Then
          Begin
            pIncrementaTrava(True);
            Result := True;
          End;

        End
        Else
          Raise Exception.Create('[fExecutaLock] - ' + E.Message);
      End;
    End;

    If (blnComitar) Then
      objConnectionsManager.CurrentConnection.Commit;
  end;

Begin
  ACon_Id := IfThen(ACon_Id.IsEmpty,
    objConnectionsManager.CurrentConnection.ConnectionID, ACon_Id);

  Try
    ANomeTabela := objConnectionsManager.CurrentConnection.Database + '.' +
      ANomeTabela;
    qryLock_Unlock := objConnectionsManager.CurrentConnection.CreateQuery();

    blnComitar := False;
    If (Not objConnectionsManager.CurrentConnection.InTransaction) Then
    Begin
      blnComitar := True;
    End;

    Result := True;
    If ATrava Then
    Begin

      strLock :=
        'INSERT INTO LCKATC (LCK_DTALCK, LCK_HRALCK, LCK_NUM_IP, LCK_CON_ID, LCK_CHAACE, LCK_CODOPE, LCK_ORIGEM, LCK_QTDTRA,LCK_MACADD,LCK_NOMMAQ,LCK_NOMUSU) '
        + 'VALUES (:DTALCK, :HRALCK, :NUM_IP, :CON_ID, :CHAACE, :CODOPE, :ORIGEM, :QTDTRA,:MACADD,:NOMMAQ,:NOMUSU)';

      With qryLock_Unlock Do
      Begin

        While Not fExecutaLock Do
        Begin

          If (Not ALoopTravamento) Then
          Begin
            Result := False;
            Break;
          End;

          WriteLog('O arquivo ' + ANomeTabela +
            ' esta sendo ' + 'utilizado no momento.' + #13#10 +
            'Aguarde Liberacao!');

          Sleep(TEMPO_ESPERA);
        End;
        Close;
      End;
    End
    Else
    Begin

      If AOrigem.IsEmpty Then
        strLock :=
          'DELETE FROM LCKATC WHERE LCK_CHAACE = :CHAACE AND LCK_CON_ID = :CON_ID'
      Else
      Begin
        pIncrementaTrava(False);
        strLock :=
          'DELETE FROM LCKATC WHERE LCK_CHAACE = :CHAACE AND LCK_QTDTRA <= 0';
      End;

      With qryLock_Unlock Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strLock);
        ParamByName('CHAACE').AsString := ANomeTabela;

        If AOrigem.IsEmpty Then
          ParamByName('CON_ID').AsString := ACon_Id;

        ExecSQL;
        Close;
      End;
    End;

  Finally

  End;

end;

class function TTaskLock.fRetOrigemLock(strNomeTabela: String): String;
Var
  qryLock: IQuery;
Begin
  qryLock := objConnectionsManager.CurrentConnection.CreateQuery();
  With qryLock, SQL Do
  Begin
    Add('SELECT LCK_ORIGEM FROM LCKATC WHERE LCK_CHAACE = :CHAACE');
    ParamByName('CHAACE').AsString := strNomeTabela;
    Open;
    If IsEmpty Then
      Result := ''
    Else
      Result := FieldByName('LCK_ORIGEM').AsString;
  End;
End;

class procedure TTaskLock.pDestravaLockForcado(strNomeTabela: String;
  intTentat: Integer);
Var
  qryAux: IQuery;
begin
  qryAux := objConnectionsManager.CurrentConnection.CreateQuery;
  qryAux.SQL.Add
    ('DELETE FROM LCKATC WHERE LCK_CHAACE = :CHAACE AND LCK_TENTAT >= ' +
    IntToStr(intTentat));
  qryAux.ParamByName('CHAACE').AsString :=
    objConnectionsManager.CurrentConnection.Database + '.' + strNomeTabela;
  qryAux.ExecSQL;
end;

class procedure TTaskLock.pZerarTentativasLock(strNomeTabela: String);
Var
  qryGen: IQuery;
  strSQL: String;
Begin

  strNomeTabela := objConnectionsManager.CurrentConnection.Database + '.' +
    strNomeTabela;
  qryGen := objConnectionsManager.CurrentConnection.CreateQuery;
  // qryGen.SQL.Add('SELECT LCK_NUM_IP FROM LCKATC WHERE LCK_CHAACE LIKE :CHAACE');

  strSQL := strSQL + '';
  strSQL := strSQL + 'UPDATE LCKATC SET  ';
  strSQL := strSQL + '  LCK_TENTAT = 0 ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LCK_CHAACE ' +
    IfThen(strNomeTabela.Contains('%'), ' LIKE ', ' = ') + ' :CHAACE ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.ExecSQL;
end;

end.
