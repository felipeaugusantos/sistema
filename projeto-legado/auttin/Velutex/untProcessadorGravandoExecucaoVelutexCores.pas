unit untProcessadorGravandoExecucaoVelutexCores;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils, untIGravando, untIConfTinta;

type
  TProcessadorGravandoExecucaoVelutexCores = class(TAbstractAdoProcessadorGravandoExecucaoArquivos)
  private
    conf: IConfTinta;
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    procedure GetArquivosProcessar(const stlArquivos: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
    procedure LimparTabelas; override;
    constructor Create();
  end;

implementation

uses
  untProcessadorGravandoExecucaoVelutexEmbalagens,untFuncoesSimples,untFuncTinta;

{ TProcessadorGravandoExecucaoVelutexCores }

constructor TProcessadorGravandoExecucaoVelutexCores.Create;
begin
  inherited Create();
  conf := fGetConfTinta('VEL');
end;

function TProcessadorGravandoExecucaoVelutexCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

procedure TProcessadorGravandoExecucaoVelutexCores.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := conf.fGet('VELPAT');
end;

function TProcessadorGravandoExecucaoVelutexCores.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM VEL_CADVEL WHERE FALSE';
end;

function TProcessadorGravandoExecucaoVelutexCores.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT DISTINCT            ' +
    '   *                        ' +
    ' FROM                       ' +
    '   [PRODUCTS$]              ' +
    '   , [HEADING$]             ' +
    ' WHERE NOT BASE IS NULL     ' +
    '   AND NOT [SIZE] IS NULL   ' +
    ' ORDER BY [COLOR CODE]      ';
end;

procedure TProcessadorGravandoExecucaoVelutexCores.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'VEL_CADVEL';
end;

procedure TProcessadorGravandoExecucaoVelutexCores.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
var
  intCont: Integer;
begin
  qryDestino.Insert;
  qryDestino.FieldByName('VEL_CORCOD').AsString := Trim(UpperCase(qryOrigem.FieldByName('color code').AsString));
  qryDestino.FieldByName('VEL_CODBAS').AsString := Trim(UpperCase(qryOrigem.FieldByName('base').AsString));
  qryDestino.FieldByName('VEL_COLECA').AsString := Trim(UpperCase(qryOrigem.FieldByName('coleção').AsString));
  qryDestino.FieldByName('VEL_PRODUT').AsString := Trim(UpperCase(qryOrigem.FieldByName('product name').AsString));
  qryDestino.FieldByName('VEL_TAMEMB').AsFloat := TProcessadorGravandoExecucaoVelutexEmbalagens.GetEmbalagem(qryOrigem.FieldByName('size').AsString);
  qryDestino.FieldByName('VEL_CODEMP').AsString := VS_strCodEmp;

  for intCont := 1 to 6 do
  begin
    if fEmptyStr(qryOrigem.FieldByName('canister' + IntToStr(intCont)).AsString) then
      Break;

    qryDestino.FieldByName('VEL_CODC' + fStrZero(intCont, 2)).AsString := Trim(UpperCase(qryOrigem.FieldByName('canister' + IntToStr(intCont)).AsString));
    qryDestino.FieldByName('VEL_QTDC' + fStrZero(intCont, 2)).AsFloat := fStrToFloat(qryOrigem.FieldByName('multiplier').AsString) *
      fStrToFloat(qryOrigem.FieldByName(IntToStr(intCont) + '-384/oz').AsString) * 29.573529 / 384;
  end;

  qryDestino.FieldByName('VEL_MD5KEY').AsString := GetMD5(qryDestino.FieldByName('VEL_CORCOD').AsString +
    qryDestino.FieldByName('VEL_CODBAS').AsString + qryDestino.FieldByName('VEL_COLECA').AsString +
    qryDestino.FieldByName('VEL_PRODUT').AsString +
    StringReplace(FormatFloat('0.0000', qryDestino.FieldByName('VEL_TAMEMB').AsFloat), ',', '.', [rfReplaceAll]));

  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('VEL_CADVEL', VS_strCodEmp);
  qryDestino.FieldByName('VEL_NOTA__').AsString := Trim(UpperCase(qryOrigem.FieldByName('note').AsString));
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoVelutexCores.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoVelutexCores.LimparTabelas;
begin
  fExecutaSQL('TRUNCATE VEL_CADVEL');
end;

procedure TProcessadorGravandoExecucaoVelutexCores.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar o registro [%s - %s - %s - %s - %s] [%s - %s]',
    [qryOrigem.FieldByName('color code').AsString, qryOrigem.FieldByName('base').AsString,
    qryOrigem.FieldByName('fandeck').AsString, qryOrigem.FieldByName('product name').AsString,
    qryOrigem.FieldByName('size').AsString, E.ClassName, E.Message]);
end;

end.
