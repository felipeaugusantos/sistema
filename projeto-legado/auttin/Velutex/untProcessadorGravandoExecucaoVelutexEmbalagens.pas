unit untProcessadorGravandoExecucaoVelutexEmbalagens;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils, untIGravando, untIConfTinta,
  Variants;

type
  TProcessadorGravandoExecucaoVelutexEmbalagens = class(TAbstractAdoProcessadorGravandoExecucaoArquivos)
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
    constructor Create();
    class function GetEmbalagem(const strTexto: string): double;
  end;

implementation
uses untFuncoesSimples,untFuncTinta;
{ TProcessadorGravandoExecucaoVelutexEmbalagens }

constructor TProcessadorGravandoExecucaoVelutexEmbalagens.Create;
begin
  inherited Create();
  conf := fGetConfTinta('VEL');
end;

function TProcessadorGravandoExecucaoVelutexEmbalagens.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagens';
end;

procedure TProcessadorGravandoExecucaoVelutexEmbalagens.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := conf.fGet('VELPAT');
end;

class function TProcessadorGravandoExecucaoVelutexEmbalagens.GetEmbalagem(const strTexto: string): double;
begin
  Result := 0;
  if fStrToFloat(strTexto) > 0 then
    Result := fStrToFloat(strTexto)
  else
  begin
    if Trim(UpperCase(AnsiDequotedStr(strTexto, '"'))) = 'QUARTO' then
      Result := 810
    else if Trim(UpperCase(AnsiDequotedStr(strTexto, '"'))) = 'GALãO' then
      Result := 3200
    else if Trim(UpperCase(AnsiDequotedStr(strTexto, '"'))) = 'LATA' then
      Result := 16200;
  end;
end;

function TProcessadorGravandoExecucaoVelutexEmbalagens.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM VEL_EMBALA';
end;

function TProcessadorGravandoExecucaoVelutexEmbalagens.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := 'SELECT * FROM [HEADING$] WHERE NOT [SIZE] IS NULL';
end;

procedure TProcessadorGravandoExecucaoVelutexEmbalagens.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'VEL_EMBALA';
end;

procedure TProcessadorGravandoExecucaoVelutexEmbalagens.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('EMB_TAMEMB').AsFloat := GetEmbalagem(qryOrigem.FieldByName('size').AsString);
  qryDestino.FieldByName('EMB_PRODUT').AsString := Trim(UpperCase(qryOrigem.FieldByName('product name').AsString));
  qryDestino.FieldByName('EMB_TAMPAD').AsFloat := qryOrigem.FieldByName('default can size').AsFloat;
  qryDestino.FieldByName('EMB_MULTPL').AsFloat := qryOrigem.FieldByName('multiplier').AsFloat;
  qryDestino.FieldByName('EMB_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('VEL_EMBALA', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoVelutexEmbalagens.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('EMB_TAMEMB;EMB_PRODUT', VarArrayOf([
    GetEmbalagem(qryOrigem.FieldByName('size').AsString), Trim(UpperCase(qryOrigem.FieldByName('product name').AsString))]), []);
end;

procedure TProcessadorGravandoExecucaoVelutexEmbalagens.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar o registro [%f %s %f %f] [%s - %s]',
    [qryOrigem.FieldByName('size').AsFloat, qryOrigem.FieldByName('product name').AsString,
    qryOrigem.FieldByName('default can size').AsFloat, qryOrigem.FieldByName('multiplier').AsFloat,
    E.ClassName, E.Message]);
end;

end.
