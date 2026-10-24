unit untProcessadorGravandoExecucaoVelutexColorantes;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils, untIGravando, untIConfTinta,
  Variants;

type
  TProcessadorGravandoExecucaoVelutexColorantes = class(TAbstractAdoProcessadorGravandoExecucaoArquivos)
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
  end;

implementation
uses untFuncoesSimples,untFuncTinta;
{ TProcessadorGravandoExecucaoVelutexColorantes }

constructor TProcessadorGravandoExecucaoVelutexColorantes.Create;
begin
  inherited Create();
  conf := fGetConfTinta('VEL');
end;

function TProcessadorGravandoExecucaoVelutexColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

procedure TProcessadorGravandoExecucaoVelutexColorantes.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := conf.fGet('VELPAT');
end;

function TProcessadorGravandoExecucaoVelutexColorantes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM VEL_CADCOL';
end;

function TProcessadorGravandoExecucaoVelutexColorantes.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
var
  arrUnidades: array[1..3] of string;
  intCont: Integer;
begin
  arrUnidades[1] := conf.fGet('UNIGL');
  arrUnidades[2] := conf.fGet('UNILA');
  arrUnidades[3] := conf.fGet('UNIQT');
  Result := '';

  for intCont := 1 to 6 do
  begin
    Result := Result +
      ' UNION                        ' +
      ' SELECT                       ' +
      '   CANISTER' + IntToStr(intCont) + ' AS COL   ' +
      ' FROM                         ' +
      '   [PRODUCTS$]                ' +
      ' WHERE NOT CANISTER' + IntToStr(intCont) + ' IS NULL ' +
      ' AND CANISTER' + IntToStr(intCont) + ' <> '''' ';
  end;

  Result := Trim(Result);
  Result := Trim(Copy(Result, Length('UNION') + 1, Length(Result)));
end;

procedure TProcessadorGravandoExecucaoVelutexColorantes.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'VEL_CADCOL';
end;

procedure TProcessadorGravandoExecucaoVelutexColorantes.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('COL_CODCOL').AsString := Trim(UpperCase(qryOrigem.FieldByName('COL').AsString));
  qryDestino.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('VEL_CADBAS', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoVelutexColorantes.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', VarArrayOf([Trim(UpperCase(qryOrigem.FieldByName('COL').AsString))]), []);
end;

procedure TProcessadorGravandoExecucaoVelutexColorantes.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel cadastrar o colorante [%s], [%s - %s]',
    [qryOrigem.FieldByName('COL').AsString, E.ClassName, E.Message]);
end;

end.

