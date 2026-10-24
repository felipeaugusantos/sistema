unit untValidaEmailOperador;

interface

uses Uni, untTEnvioEmail;

type
  TValidaEmailOperador = class
  private
    FOperador: String;
    FDadosOperador: TUniQuery;
    FAutenticacaoEmail : TAutenticacaoEmail;
    procedure pCarregarDadosOperador;
    function fValidoudadosOperador: Boolean;
    procedure pSetaAutenticacaoOperador;
    function fRetSQLEmailOperador: String;
    function fRetSQLEmailPorEmpresa: String;
  public
    constructor Create(const AOperador: String);
    destructor Destroy; override;
    function Validar: Boolean;
  End;

implementation

uses untFuncoesSimples, SysUtils, untTypesSistema;

{ TValidaEmailOperador }

constructor TValidaEmailOperador.Create(const AOperador: String);
begin
  FOperador := AOperador;
  FDadosOperador := fCriaQuery(Nil);
end;

destructor TValidaEmailOperador.Destroy;
begin
  FreeAndNil(FDadosOperador);
  If (Assigned(FAutenticacaoEmail)) Then
    FreeAndNil(FAutenticacaoEmail);
  inherited;
end;

procedure TValidaEmailOperador.pSetaAutenticacaoOperador;
begin
  If Assigned(FAutenticacaoEmail) Then
    FreeAndNil(FAutenticacaoEmail);

  FAutenticacaoEmail := TAutenticacaoEmail.Create(FOperador,
                                                  FDadosOperador.FieldByName('OPE_E_MAIL').AsString,
                                                  FDadosOperador.FieldByName('OPE_EMALOG').AsString,
                                                  '',
                                                  CriptografarSenhaEmail(FDadosOperador.FieldByName('OPE_PRVSEN').AsString),
                                                  FDadosOperador.FieldByName('OPE_CODPRV').AsInteger,
                                                  Not FDadosOperador.FieldByName('PRV_USAOA2').AsString.Equals('S'));
end;

function TValidaEmailOperador.fValidoudadosOperador: Boolean;
begin
  Result := False;

  If FDadosOperador.IsEmpty Then
    Exit;

  If (FDadosOperador.FieldByName('OPE_CODPRV').IsNull) Then
    Exit;

  If Not FDadosOperador.FieldByName('PRV_USAOA2').AsString.Equals('S') Then
  Begin
    If fEmptyStr(FDadosOperador.FieldByName('OPE_E_MAIL').AsString) Then
      Exit;
  End;

  If fEmptyStr(FDadosOperador.FieldByName('OPE_EMALOG').AsString) Then
    Exit;

  If fEmptyStr(FDadosOperador.FieldByName('OPE_PRVSEN').AsString) Then
    Exit;

  Result := True;
end;

procedure TValidaEmailOperador.pCarregarDadosOperador;
begin
  FDadosOperador.Close;
  FDadosOperador.SQL.Clear;

  If (fCfgSis('EMLEMP', varBoolean)) Then
    FDadosOperador.SQL.Text := fRetSQLEmailPorEmpresa
  Else
    FDadosOperador.SQL.Text := fRetSQLEmailOperador;

  FDadosOperador.ParamByName('CODOPE').AsString := FOperador;
  FDadosOperador.Open;
end;

function TValidaEmailOperador.fRetSQLEmailPorEmpresa: String;
begin
  Result := ' SELECT EML_E_MAIL AS OPE_E_MAIL,             '+
            '        EML_EMALOG AS OPE_EMALOG,             '+
            '        EML_PRVSEN AS OPE_PRVSEN,             '+
            '        EML_CODPRV AS OPE_CODPRV,             '+
            '        COALESCE(PRV_USAOA2,"N") AS PRV_USAOA2'+
            '   FROM OPEEML                                '+
            '   LEFT JOIN CADPRV ON PRV_CODPRV=EML_CODPRV  '+
            ' WHERE EML_CODOPE = :CODOPE                   '+
            '   AND EML_CODEMP = ' + QuotedStr(Vs_strCodEmp);
end;

function TValidaEmailOperador.fRetSQLEmailOperador: String;
begin
  Result := ' SELECT OPE_E_MAIL, OPE_EMALOG, OPE_PRVSEN, OPE_CODPRV,'+
            '        COALESCE(PRV_USAOA2,"N") AS PRV_USAOA2         '+
            '   FROM CADOPE                                         '+
            '   LEFT JOIN CADPRV ON PRV_CODPRV=OPE_CODPRV           '+
            ' WHERE OPE_CODOPE = :CODOPE                            ';
end;

function TValidaEmailOperador.Validar: Boolean;
  Var
    blnConexaoProvedor : Boolean;
    blnExibirMensagemAoUsuario : Boolean;
begin
  Result := False;

  pCarregarDadosOperador;

  If (Not fValidouDadosOperador) Then
    Exit;

  pSetaAutenticacaoOperador;

  blnExibirMensagemAoUsuario := VS_ExibirMensagemAoUsuario;
  Try
    VS_ExibirMensagemAoUsuario := False;
    Try
      Result := TAutenticacaoEmail.fValidarAutenticacaoSmtp(Nil, FAutenticacaoEmail, blnConexaoProvedor);
    Except
      Result := False;
    End;
  Finally
    VS_ExibirMensagemAoUsuario := blnExibirMensagemAoUsuario;
  End;
end;

end.
