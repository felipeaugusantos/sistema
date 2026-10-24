unit untModulo;

interface

uses
  {$IFDEF MSWINDOWS}
  Forms, madExceptVcl, madExcept, Dialogs, frxClass, Winapi.Windows,
  {$ENDIF}
  SysUtils, Classes, DB, Uni, StrUtils, MemDS,
  DBAccess, MySQLUniProvider, UniProvider,  ODBCUniProvider,
  DBFUniProvider,  untTypesSistema;

type
  TfrmModulo = class(TDataModule)
    Database: TUniConnection;
    {$IFDEF MSWINDOWS}
    MadException: TMadExceptionHandler;
    procedure DatabaseAfterConnect(Sender: TObject);
    {$ENDIF}

  private
    { Private declarations }
  public
    VersionTitle: String;
    constructor Create(Owner: TComponent); Override;
    constructor CreateInstance(Owner: TComponent; blnConectar: Boolean);

  end;

  TModuloEvents = class
    class procedure AfterConnect(Sender: TObject);
  End;

  TDiretivasDaConexao = class
    class procedure DefineIsolationLevel(const ADatabase: TUniConnection);
  End;

var
  frmModulo: TfrmModulo;
  ProcReconectarModulo : TProcReconectarModulo;

Const
  SEM_MAD = 'youdonthavemadexcept';

implementation

uses  untfuncoes, untHorarioSistema, untConstantes;

{$R *.dfm}

constructor TfrmModulo.Create(Owner: TComponent);
begin
  CreateInstance(Owner, True);

  {$IFDEF MSWINDOWS}
  MadException :=  TMadExceptionHandler.Create(Owner);
  {$ENDIF}
end;

constructor TfrmModulo.CreateInstance(Owner: TComponent; blnConectar: Boolean);
begin
  inherited Create(Owner);

  If blnConectar Then
  Begin
    {$IFDEF MSWINDOWS}
    pAbrirBanco(Database);

    Sleep(100);

    Application.ProcessMessages;
    {$ENDIF}
//    blnTemMad := False;
//    Try
//      Raise Exception.Create(SEM_MAD);
//    Except
//      HandleException;
//
//      If Not blnTemMad Then
//      Begin
//        pMensagemOk('Não foi encontrado o módulo MadExcept no sistema!' + #13 +
//                    'Ligue imediatamente para a Citel.');
//        Application.Terminate;
//      End;
//    End;
  End;

end;

procedure TfrmModulo.DatabaseAfterConnect(Sender: TObject);
begin
  TModuloEvents.AfterConnect(Sender);
end;

{ TModuloEvents }

class procedure TModuloEvents.AfterConnect(Sender: TObject);
begin
  If (Not Assigned(Sender)) Then
    Exit;
  If (Not (Sender Is TUniConnection)) Then
    Exit;
  DefinirTimeZoneEmSessaoMySql(TUniConnection(Sender), VS_strCodEmp);
  TDiretivasDaConexao.DefineIsolationLevel(TUniConnection(Sender));
end;

{ TDiretivasDaConexao }

class procedure TDiretivasDaConexao.DefineIsolationLevel(const ADatabase: TUniConnection);
  Var
    LQuery : TUniQuery;
begin
  LQuery := fCriaQuery(Nil, ADatabase);
  Try
    LQuery.Close;
    LQuery.SQL.Text := DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
    LQuery.ExecSQL;
  Finally
    FreeAndNil(LQuery);
  End;
end;

end.
