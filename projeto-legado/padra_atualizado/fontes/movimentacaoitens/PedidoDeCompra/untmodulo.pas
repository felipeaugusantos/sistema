unit untModulo;

interface

uses
  SysUtils, Classes, DB, DBAccess, Uni, UniProvider, MySQLUniProvider, frxclass;

type
  TfrmModulo = class(TDataModule)
    Database: TUniConnection;
    MySQLUniProvider: TMySQLUniProvider;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FMainThreadID: Cardinal;
  public
    function fGravarRelErro(strMensagemErro, strRelatorio: String; conexao: TUniConnection = nil): Integer;

    constructor Create(Owner: TComponent); Override;
    constructor CreateInstance(Owner: TComponent; blnConectar: Boolean);

    function GetCurrentConnection: TUniConnection; overload;
    function GetCurrentConnection(AThreadId: Cardinal): TUniConnection; overload;
  end;

var
  frmModulo: TfrmModulo;

implementation

uses untFuncoesSimples, untConexaoThread, Windows;

{$R *.dfm}

constructor TfrmModulo.Create(Owner: TComponent);
begin
  CreateInstance(Owner, True);
end;

constructor TfrmModulo.CreateInstance(Owner: TComponent; blnConectar: Boolean);
begin
  inherited Create(Owner);
  FMainThreadID := GetCurrentThreadId;
  If blnConectar Then
    pAbrirBanco(Database);

end;

procedure TfrmModulo.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

end;

function TfrmModulo.fGravarRelErro(strMensagemErro, strRelatorio: String; conexao: TUniConnection): Integer;
  Var
    qryLogErr: TUniQuery;
    intLogErr: Integer;
    strMoreInfo: String;
begin
  If (Pos('Unknown.', strRelatorio) > 0) And (Not VS_strError.IsEmpty) Then
  Begin
    strMoreInfo  := '';

    If Not VS_strMensagemErro.IsEmpty Then
    Begin
      strMoreInfo := strMoreInfo + #13#10;
      strMoreInfo := strMoreInfo + '--------------------------------------------------------------------------' + #13#10;
      strMoreInfo := strMoreInfo + #13#10;
      strMoreInfo := strMoreInfo + VS_strMensagemErro + #13#10;
      strMoreInfo := strMoreInfo + #13#10;
      strMoreInfo := strMoreInfo + '--------------------------------------------------------------------------' + #13#10;
    End;

    strRelatorio := strRelatorio.Replace('Unknown.' + #13#10, VS_strError + #13#10 + strMoreInfo);
    strRelatorio := strRelatorio.Replace('Unknown', 'Exception ' + VS_strLocalErro);
  End;

  intLogErr := 0;

  Try
    qryLogErr := fCriaQuery(nil, conexao);
    qryLogErr.SQL.Add('SELECT * FROM LOGERR WHERE FALSE');

    With qryLogErr Do
    Begin
      Open;
      Insert;
      FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
      FieldByName('LOG_LOGOPE').AsString   := strLoginUsuarioLogado;
      FieldByName('LOG_DTAERR').AsDateTime := VS_Date;
      FieldByName('LOG_HORERR').AsDateTime := Time;
      FieldByName('LOG_DESCRI').AsString   := strMensagemErro;
      FieldByName('LOG_RELERR').AsString   := strRelatorio;
      Post;
      intLogErr := FieldByName('AUTOINCREM').AsInteger;
      Close;
    End;

  Finally
    Result := intLogErr;
    FreeAndNil(qryLogErr);
  End;
end;

function TfrmModulo.GetCurrentConnection: TUniConnection;
begin
  If GetCurrentThreadId = FMainThreadID Then
    Result := Self.Database
  Else If VS_objConexaoThread.HasConnection(GetCurrentThreadId) Then
    Result := VS_objConexaoThread.GetConnection(GetCurrentThreadId, 'TfrmModulo.GetCurrentConnection')
  Else
    Result := Self.Database;
end;

function TfrmModulo.GetCurrentConnection(AThreadId: Cardinal): TUniConnection;
begin
  If AThreadId = 0 Then
    Result := Self.Database
  Else If AThreadId = FMainThreadID Then
    Result := Self.Database
  Else If VS_objConexaoThread.HasConnection(AThreadId) Then
    Result := VS_objConexaoThread.GetConnection(AThreadId, 'TfrmModulo.GetCurrentConnection')
  Else
    Result := Self.GetCurrentConnection;
end;

end.
