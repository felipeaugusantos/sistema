unit untModuloReplicacaoZeos;

interface

uses
  SysUtils, Classes, ZSqlMonitor, StrUtils, Dialogs, ZDataset, Forms;

type
  TfrmModuloReplicacao = class(TDataModule)
    sqlMonitor: TZSQLMonitor;
    procedure sqlMonitorTrace(Sender: TObject; Event: TZLoggingEvent;
      var LogTrace: Boolean);
  private
    { Private declarations }
    function fRetornaNomeTabela(strString: String): String;
    function fTabelaReplica(strNomTabela: String): Boolean;
    function fGravaLogRep(strComand, strTabela: String): Boolean;
    procedure pCarregaNre;
    function fPegaDataSistema: TDateTime;
  public
    { Public declarations }
  end;

var
  frmModuloReplicacao: TfrmModuloReplicacao;

Const
  {**************************************}
  {* MATRIZ PARA COMANDOS A SEREM GRAV. *}
  {***********************************AF*}
  arrRep1: Array[0..4] Of String = ('INSERT', 'REPLACE', 'DELETE FROM', 'UPDATE', 'SET FOREIGN_KEY_CHECKS');
  arrRep2: Array[0..4] Of String = (' INTO ', ' INTO ' , ''           , ' SET ' , ''                      );
  
implementation

uses untUtil;

{$R *.dfm}

procedure TfrmModuloReplicacao.sqlMonitorTrace(Sender: TObject; Event: TZLoggingEvent; var LogTrace: Boolean);
  Var
    strString,
    strStringComp: String;
    strTabela    : String;
    intContador  : Integer;
    blnGerar     : Boolean;
    intPosEsp    : Integer;
begin

  strString := AnsiReplaceText(Event.Message, #13#10, ' ');
  blnGerar  := False;

  strStringComp := strString;
  While Pos('  ', strStringComp) > 0 Do
  Begin
    intPosEsp := Pos('  ', strStringComp);
    Delete(strStringComp, intPosEsp, 1);
  End;
  
  For intContador := 0 To ( Length(arrRep1) - 1 ) Do
  Begin

    If (Pos( arrRep1[intContador], strStringComp ) > 0) Then
    Begin

      If (Not fEmptyStr(arrRep2[intContador]))  And
         (Pos( arrRep2[intContador], strString ) > 0) Then
      Begin
        blnGerar := True;
      End
      Else
      Begin

        If fEmptyStr(arrRep2[intContador]) Then
          blnGerar := True;

      End;

    End;
  End;

  If blnGerar Then
  Begin
    strTabela := fRetornaNomeTabela(strString);
    
    If fTabelaReplica(strTabela) Then
        fGravaLogRep(strString, strTabela);

  End;
end;

{**************************************}
{* RETORNA NOME DE TABELA             *}
{***********************************AF*}
function TfrmModuloReplicacao.fRetornaNomeTabela(strString: String): String;
  Var
    strTmp     : String;
    intPosicao : Integer;
    intContador: Integer;
Begin
  Result     := '';
  intPosicao := 0;

  strString := Trim(strString);

  If      LeftStr(strString,6) = 'INSERT' Then
  Begin
    intPosicao :=  Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := AnsiReplaceStr(strTmp, 'INTO ', '');
  End

  Else If LeftStr(strString,6) = 'UPDATE' Then
  Begin
    intPosicao :=  Pos('UPDATE ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := AnsiReplaceStr(strTmp, 'UPDATE ', '');
  End

  Else If LeftStr(strString,6) = 'DELETE' Then
  Begin
    intPosicao := Pos('FROM ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := AnsiReplaceStr(strTmp, 'FROM ', '');
  End

  Else If LeftStr(strString,7) = 'REPLACE' Then
  Begin
    intPosicao := Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := AnsiReplaceStr(strTmp, 'INTO ', '');
  End;

  If (intPosicao > 0) Then
  Begin
    strTmp := AnsiReplaceStr(strTmp,'(', ' ');
    strTmp := AnsiReplaceStr(strTmp,')', ' ');
    strTmp := AnsiReplaceStr(strTmp,',', ' ');
    strTmp := Trim(strTmp);

    For intContador := 1 To Length(strTmp) Do
    Begin
      If fEmptyStr(Copy(strTmp, intContador, 1)) Then
        Break;

      Result := Result + Copy(strTmp, intContador, 1);
    End;

    Result := Trim(Result);
  End;

  If Not fEmptyStr(Result) Then
  Begin

    intPosicao := Pos('.',Result);

    If intPosicao > 0 Then
      Result := Copy(Result, intPosicao +1, Length(Result) -intPosicao);

  End;

End;

{**************************************}
{* VERIFICA SE TABELA REPLICA OU NÃO  *}
{***********************************AF*}
function TfrmModuloReplicacao.fTabelaReplica(strNomTabela: String): Boolean;
  Var
    intContador: Integer;
Begin

  Try
    Result := True;

    {***************************************************}
    {* NÃO REPLICA A TABNRE!!!!                        *}
    {** 09/06/2008 - 09:54 **************************MV*}
    {** 09/06/2009 - 17:47 **************************JB*}
    If (strNomTabela = 'TABNRE') Or
       (strNomTabela = 'LOGREP') Or
       (strNomTabela = 'USUREP') Or
       (strNomTabela = 'DICSIS') Or
       (strNomTabela = 'LOGERR') Or
       (strNomTabela = 'LCKATC') Or
       (strNomTabela = 'CADBCO') Then
    Begin
      Result := False;
      Exit;
    End;

    If (Not Assigned(VS_stlTabNre)) Then
      pCarregaNre;

    For intContador := 0 To VS_stlTabNre.Count -1 Do
    Begin

      {**************************************}
      {* SE FOI COLOCADO NO FIM O %         *}
      {***********************************AF*}
      If Pos('%', Trim(VS_stlTabNre[intContador])) > 0 Then
      Begin

        If LeftStr(Trim(AnsiUpperCase(strNomTabela)), Length(Trim(AnsiUpperCase(VS_stlTabNre[intContador]))) - 1) = LeftStr(Trim(AnsiUpperCase(VS_stlTabNre[intContador])), Length(Trim(AnsiUpperCase(VS_stlTabNre[intContador]))) - 1) Then
        Begin
          Result := False;
          Exit;
        End;

      End
      {**************************************}
      {* SE NÃO FOI COLOCADO O %            *}
      {***********************************AF*}
      Else
      Begin

        {**************************************}
        {* SE O NOME DA TABELA FOR O MESMO DA *}
        {* CONFIGURAÇÃO ENTÃO NÃO REPLICA     *}
        {***********************************AF*}
        If Trim(AnsiUpperCase(strNomTabela)) = Trim(AnsiUpperCase(VS_stlTabNre[intContador])) Then
        Begin
          Result := False;
          Exit;
        End;

      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      MessageDlg('[TABELAREPLICA] - ' + E.Message, mtError, [mbOK], 0);
    End;
  End;

End;

{**************************************}
{* GERA O LOG DE REPLICAÇÃO           *}
{***********************************AF*}
function TfrmModuloReplicacao.fGravaLogRep(strComand, strTabela: String): Boolean;
  Var
    qryLogRep: TZQuery;
Begin

  Try
    Result := True;

    qryLogRep := fCriaQuery(Nil);

    qryLogRep.Close;
    qryLogRep.SQL.Clear;
    qryLogRep.SQL.Add('SELECT * FROM LOGREP LIMIT 0');
    qryLogRep.Open;

    With qryLogRep Do
    Begin
      Insert;
      FieldByName('LOG_DTACAD').AsDateTime := fPegaDataSistema;
      FieldByName('LOG_HRACAD').AsDateTime := Time;
      FieldByName('LOG_COMAND').AsString   := strComand;
      FieldByName('LOG_TABELA').AsString   := strTabela;
      FieldByName('LOG_CARREG').AsString   := 'N';
      Post;
    End;

    qryLogRep.Close;
    FreeAndNil(qryLogRep);

  Except
    On E: Exception Do
    Begin
      Result := False;
      MessageDlg('[GRAVALOGREP] - ' + E.message, mtError, [mbOK], 0);
      FreeAndNil(qryLogRep);
    End;
  End;

End;

procedure TfrmModuloReplicacao.pCarregaNre;
  Var
   qryTabNRE: TZQuery;
begin
  VS_stlTabNre := TStringList.Create;

  qryTabNRE := fCriaQuery(Nil);
  qryTabNRE.SQL.Add('SELECT * FROM TABNRE');
  qryTabNRE.Open;

  If (qryTabNRE.IsEmpty) Or (Not qryTabNRE.Active) Then
  Begin
    qryTabNRE.Close;
    FreeAndNil(qryTabNRE);
    MessageDlg('Tabela TABNRE vazia! Verifique!', mtInformation, [mbOK], 0);
    Application.Terminate;
  End;

  While Not qryTabNRE.Eof Do
  Begin
    VS_stlTabNre.Add(qryTabNRE.Fields[0].AsString);
    qryTabNRE.Next;
  End;

  qryTabNRE.Close;
  FreeAndNil(qryTabNRE);
end;

{********************************************}
{* AJUSTA O RELOGIO DO WINDOWS TOMANDO COMO *}
{* BASE A DATA DO SERVIDOR                  *}
{*****************************************MV*}
function TfrmModuloReplicacao.fPegaDataSistema: TDateTime;
  Var
    qryGenTmp: TZQuery;
begin

  qryGenTmp := fCriaQuery(Nil);

  Try
    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT CURRENT_DATE, CURRENT_TIME');
      Open;
      Result := FieldByName('CURRENT_DATE').AsDateTime;
      Close;
    End;

  Except
    Result := Date;
  End;

end;

end.

