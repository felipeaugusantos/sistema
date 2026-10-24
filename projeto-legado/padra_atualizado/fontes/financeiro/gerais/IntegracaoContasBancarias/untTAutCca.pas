unit untTAutCca;

interface

uses
  System.SysUtils, System.Classes, Uni, DBAccess;

type
  TAutCCA = class
  private
    FQuery: TUniQuery;
    FAutoincrem: string;
    FAppKey: string;
    FClientID: string;
    FClientSecret: string;
    FArquivoPfx: string;
    FSenhaCertificado: string;
    FDataValidadeCertificado: TDate;
    FAutenticacaoBasic: string;
    FArquivoCrt: string;
    FArquivoKey: string;
    function TemAlteracoes(DadosAntigos: TAutCCA): Boolean;
    procedure AtualizarContaBancaria(AContaBancaria: String);
  public
    constructor Create;
    destructor Destroy; override;

    // Propriedades
    property Autoincrem: string read FAutoincrem write FAutoincrem;
    property AppKey: string read FAppKey write FAppKey;
    property ClientID: string read FClientID write FClientID;
    property ClientSecret: string read FClientSecret write FClientSecret;
    property ArquivoPfx: string read FArquivoPfx write FArquivoPfx;
    property ArquivoCrt: string read FArquivoCrt write FArquivoCrt;
    property ArquivoKey: string read FArquivoKey write FArquivoKey;
    property SenhaCertificado: string read FSenhaCertificado write FSenhaCertificado;
    property DataValidadeCertificado: TDate read FDataValidadeCertificado write FDataValidadeCertificado;
    property AutenticacaoBasic: string read FAutenticacaoBasic write FAutenticacaoBasic;

    // Métodos CRUD
    procedure Inserir;
    procedure Atualizar;
    procedure Excluir;
    function BuscarPorID(const ID: string): Boolean;
    procedure Gravar(AContaBancaria: String);
    procedure Limpar;
  end;

implementation

uses untFuncoesSimples;

{ TAutCCA }

constructor TAutCCA.Create;
begin
  inherited Create;
  FQuery := fCriaQuery(Nil);
  Limpar;
end;

destructor TAutCCA.Destroy;
begin
  FQuery.Free;
  inherited Destroy;
end;

procedure TAutCCA.Limpar;
begin
  FAutoincrem := '';
  FAppKey := '';
  FClientID := '';
  FClientSecret := '';
  FArquivoPfx := '';
  FArquivoCrt := '';
  FArquivoKey := '';
  FSenhaCertificado := '';
  FDataValidadeCertificado := 0;
  FAutenticacaoBasic := '';
end;

function TAutCCA.TemAlteracoes(DadosAntigos: TAutCCA): Boolean;
begin
  Result := (FAppKey <> DadosAntigos.AppKey) or
            (FClientID <> DadosAntigos.ClientID) or
            (FClientSecret <> DadosAntigos.ClientSecret) or
            (FArquivoPfx <> DadosAntigos.ArquivoPfx) or
            (FArquivoCrt <> DadosAntigos.ArquivoCrt) or
            (FArquivoKey <> DadosAntigos.ArquivoKey) or
            (FSenhaCertificado <> DadosAntigos.SenhaCertificado) or
            (FDataValidadeCertificado <> DadosAntigos.DataValidadeCertificado) or
            (FAutenticacaoBasic <> DadosAntigos.AutenticacaoBasic);
end;

procedure TAutCCA.Inserir;
begin
  try
    FQuery.SQL.Text := 'INSERT INTO AUTCCA (' +
                       '  AUTOINCREM,' +
                       '  AUT_APPKEY,' +
                       '  AUT_CLI_ID,' +
                       '  AUT_CLISEC,' +
                       '  AUT_ARQPFX,' +
                       '  AUT_ARQCRT,' +
                       '  AUT_ARQKEY,' +
                       '  AUT_SENCER,' +
                       '  AUT_VALCER,' +
                       '  AUT_AUTBAS' +
                       ') VALUES (' +
                       '  :AUTOINCREM,' +
                       '  :AUT_APPKEY,' +
                       '  :AUT_CLI_ID,' +
                       '  :AUT_CLISEC,' +
                       '  :AUT_ARQPFX,' +
                       '  :AUT_ARQCRT,' +
                       '  :AUT_ARQKEY,' +
                       '  :AUT_SENCER,' +
                       '  :AUT_VALCER,' +
                       '  :AUT_AUTBAS' +
                       ')';

    FAutoincrem :=  fRetAutoIncrem('AUTCCA',VS_strCodEmp);
    FQuery.ParamByName('AUTOINCREM').AsString := FAutoincrem;
    FQuery.ParamByName('AUT_APPKEY').AsString := FAppKey;
    FQuery.ParamByName('AUT_CLI_ID').AsString := FClientID;
    FQuery.ParamByName('AUT_CLISEC').AsString := FClientSecret;
    FQuery.ParamByName('AUT_ARQPFX').AsString := FArquivoPfx;
    FQuery.ParamByName('AUT_ARQCRT').AsString := FArquivoCrt;
    FQuery.ParamByName('AUT_ARQKEY').AsString := FArquivoKey;
    FQuery.ParamByName('AUT_SENCER').AsString := FSenhaCertificado;
    FQuery.ParamByName('AUT_AUTBAS').AsString := FAutenticacaoBasic;

    FQuery.ParamByName('AUT_VALCER').Clear;
    if FDataValidadeCertificado <> 0 then
      FQuery.ParamByName('AUT_VALCER').AsDate := FDataValidadeCertificado;

    FQuery.ExecSQL;
  except
    on E: Exception do
    Begin
      raise Exception.Create('Erro ao inserir registro: ' + E.Message);
    End;
  end;
end;

procedure TAutCCA.Atualizar;
begin
  try
    FQuery.SQL.Text := 'UPDATE AUTCCA SET' +
                       '  AUT_APPKEY = :AUT_APPKEY,' +
                       '  AUT_CLI_ID = :AUT_CLI_ID,' +
                       '  AUT_CLISEC = :AUT_CLISEC,' +
                       '  AUT_ARQPFX = :AUT_ARQPFX,' +
                       '  AUT_ARQCRT = :AUT_ARQCRT,' +
                       '  AUT_ARQKEY = :AUT_ARQKEY,' +
                       '  AUT_SENCER = :AUT_SENCER,' +
                       '  AUT_VALCER = :AUT_VALCER,' +
                       '  AUT_AUTBAS = :AUT_AUTBAS' +
                       ' WHERE AUTOINCREM = :AUTOINCREM';

    FQuery.ParamByName('AUTOINCREM').AsString := FAutoincrem;
    FQuery.ParamByName('AUT_APPKEY').AsString := FAppKey;
    FQuery.ParamByName('AUT_CLI_ID').AsString := FClientID;
    FQuery.ParamByName('AUT_CLISEC').AsString := FClientSecret;
    FQuery.ParamByName('AUT_ARQPFX').AsString := FArquivoPfx;
    FQuery.ParamByName('AUT_ARQCRT').AsString := FArquivoCrt;
    FQuery.ParamByName('AUT_ARQKEY').AsString := FArquivoKey;
    FQuery.ParamByName('AUT_SENCER').AsString := FSenhaCertificado;
    FQuery.ParamByName('AUT_AUTBAS').AsString := FAutenticacaoBasic;

    FQuery.ParamByName('AUT_VALCER').Clear;
    if FDataValidadeCertificado <> 0 then
      FQuery.ParamByName('AUT_VALCER').AsDate := FDataValidadeCertificado;

    FQuery.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao atualizar registro: ' + E.Message);
  end;
end;

procedure TAutCCA.Gravar(AContaBancaria: String);
var
  DadosAntigos: TAutCCA;
begin
  if FAutoincrem.Trim.IsEmpty then
  begin
    Inserir;
    AtualizarContaBancaria(AContaBancaria);
    Exit;
  end;

  DadosAntigos := TAutCCA.Create;
  try
    if DadosAntigos.BuscarPorID(FAutoincrem) then
    begin
      if TemAlteracoes(DadosAntigos) then
        Atualizar;
    end;
  finally
    DadosAntigos.Free;
  end;
end;

procedure TAutCCA.Excluir;
begin
  If Trim(FAutoincrem).IsEmpty Then
    Exit;

  try
    FQuery.SQL.Text := 'DELETE FROM AUTCCA' +
                       ' WHERE AUTOINCREM = :AUTOINCREM';
    FQuery.ParamByName('AUTOINCREM').AsString := FAutoincrem;
    FQuery.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao excluir registro: ' + E.Message);
  end;
end;

procedure TAutCCA.AtualizarContaBancaria(AContaBancaria: String);
begin
  try
    FQuery.SQL.Text := 'UPDATE CADCCA ' +
                       ' SET CCA_AUTCCA = :AUTCCA '+
                       ' WHERE AUTOINCREM = :AUTOINCREM';

    FQuery.ParamByName('AUTCCA').AsString := FAutoincrem;
    FQuery.ParamByName('AUTOINCREM').AsString := AContaBancaria;

    FQuery.ExecSQL;
  except
    on E: Exception do
      raise Exception.Create('Erro ao atualizar conta bancaria: ' + E.Message);
  end;
end;

function TAutCCA.BuscarPorID(const ID: string): Boolean;
begin
  Result := False;
  try
    FQuery.SQL.Text := 'SELECT' +
                       '  AUTOINCREM,' +
                       '  AUT_APPKEY,' +
                       '  AUT_CLI_ID,' +
                       '  AUT_CLISEC,' +
                       '  AUT_ARQPFX,' +
                       '  AUT_ARQCRT,' +
                       '  AUT_ARQKEY,' +
                       '  AUT_SENCER,' +
                       '  AUT_VALCER,' +
                       '  AUT_AUTBAS' +
                       ' FROM AUTCCA' +
                       ' WHERE AUTOINCREM = :AUTOINCREM';
    FQuery.ParamByName('AUTOINCREM').AsString := ID;
    FQuery.Open;

    if not FQuery.IsEmpty then
    begin
      FAutoincrem := FQuery.FieldByName('AUTOINCREM').AsString;
      FAppKey := FQuery.FieldByName('AUT_APPKEY').AsString;
      FClientID := FQuery.FieldByName('AUT_CLI_ID').AsString;
      FClientSecret := FQuery.FieldByName('AUT_CLISEC').AsString;
      FArquivoPfx := FQuery.FieldByName('AUT_ARQPFX').AsString;
      FArquivoCrt := FQuery.FieldByName('AUT_ARQCRT').AsString;
      FArquivoKey := FQuery.FieldByName('AUT_ARQKEY').AsString;
      FSenhaCertificado := FQuery.FieldByName('AUT_SENCER').AsString;
      FAutenticacaoBasic := FQuery.FieldByName('AUT_AUTBAS').AsString;

      FDataValidadeCertificado := 0;
      if not FQuery.FieldByName('AUT_VALCER').IsNull then
        FDataValidadeCertificado := FQuery.FieldByName('AUT_VALCER').AsDateTime;
      Result := true;
    end;

    FQuery.Close;
  except
    on E: Exception do
      raise Exception.Create('Erro ao buscar registro: ' + E.Message);
  end;
end;

end.
