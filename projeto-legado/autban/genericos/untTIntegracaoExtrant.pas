unit untTIntegracaoExtrant;

interface

uses Windows, Forms, Classes, SysUtils, Uni, StrUtils, UniClientDataSet, Data.DB,
     Variants, cxProgressBar, System.DateUtils, Math, untFuncoesSimples,IdFTP,
     untGravando, Vcl.Dialogs;

Type
  TEnviaRemessaExtrant = Class
  Private
    FIdFTP: TIdFTP;

    FHost_FTP: String;
    FSenha_FTP: String;
    FUsuario_FTP: String;
    FPorta_FTP: Integer;
    FModo_FTP: String;

    procedure CriarComponenteConexao;
    procedure CarregarDadosDeAcesso;
    procedure RealizarConexao;
    function ConectouNoServidorFTP: Boolean;
    function FTPFileExists(aFileName: string): Boolean;

  Public
    constructor Create; overload;
    destructor Destroy; override;
    function EnviarArquivo(AArquivo:TStringStream; ANomeArquivo: String): Boolean;
    function CriarPasta(ANomePasta: String):Boolean;
    procedure MarcarArquivoComoEnviado(AAutoIncrem:String);

    property Conectado: Boolean read ConectouNoServidorFTP;


  End;

implementation

{ TEnviaRemessaExtrant }

procedure TEnviaRemessaExtrant.CarregarDadosDeAcesso;
begin
  FHost_FTP      := fCfgSis('HOSEXT', VarString);
  FSenha_FTP     := fCfgSis('SENEXT', VarString);
  FUsuario_FTP   := fCfgSis('USUEXT', VarString);
  FPorta_FTP     := fCfgSis('POREXT', VarInteger);
  FModo_FTP      := fCfgSis('MODEXT', VarString);
end;

function TEnviaRemessaExtrant.ConectouNoServidorFTP: Boolean;
begin
  Result := FIdFTP.Connected;
end;

constructor TEnviaRemessaExtrant.Create;
begin
  CriarComponenteConexao;
  CarregarDadosDeAcesso;
  TfrmGravando.fExecutarModalA(RealizarConexao,'Aguarde, Realizando Conexão.', '');
end;

procedure TEnviaRemessaExtrant.CriarComponenteConexao;
begin
  Try
    FIdFTP := TIdFTP.Create();
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TEnviaRemessaExtrant.CriarPasta(ANomePasta: String): Boolean;
begin
  Try
    If FTPFileExists(ANomePasta) Then
      Exit(True);

    FIdFTP.MakeDir(ANomePasta);
    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pGravarErro(True, E.message + ' --> TEnviaRemessaExtrant.CriarPasta', fRetornaStack);
    End;
  End;
end;

function TEnviaRemessaExtrant.FTPFileExists(aFileName: string): Boolean;
begin
  try
    FIdFTP.List(nil, aFileName, False);
    Result := (FIdFTP.ListResult.Count > 0);
  except
    Result := False;
  end;
end;

procedure TEnviaRemessaExtrant.MarcarArquivoComoEnviado(AAutoIncrem: String);
  Var
    LRemGer : TUniQuery;
begin
  Try
    LRemGer := fCriaQuery(Nil);
    Try
      LRemGer.Close;
      LRemGer.SQL.Clear;
      LRemGer.SQL.Text := 'UPDATE REMGER SET GER_ENVEXT = "S" WHERE AUTOINCREM = :AUTOINC ';
      LRemGer.ParamByName('AUTOINC').AsString := AAutoIncrem;
      LRemGer.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LRemGer);
  End;
end;

destructor TEnviaRemessaExtrant.Destroy;
begin
  FIdFTP.Disconnect();
  FreeAndNil(FIdFTP);
  inherited;
end;

function TEnviaRemessaExtrant.EnviarArquivo(AArquivo: TStringStream;
  ANomeArquivo: String): Boolean;
begin
  Try
    FIdFTP.Put(AArquivo, ANomeArquivo);
    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pGravarErro(True, E.message + ' --> TEnviaRemessaExtrant.EnviarArquivo', fRetornaStack);
    End;
  End;
end;

procedure TEnviaRemessaExtrant.RealizarConexao;
begin

  Try
    FIdFTP.Host     := FHost_FTP;
    FIdFTP.Port     := FPorta_FTP;
    FIdFTP.Username := FUsuario_FTP;
    FIdFTP.Password := FSenha_FTP;
    FIdFTP.Passive  :=(FModo_FTP = 'P');

    FIdFTP.Connect();
  Except
    On E: Exception Do
    Begin
      pGravarErro(True, E.message + ' --> TEnviaRemessaExtrant.RealizarConexao', fRetornaStack);
    End;
  End;

end;

end.
