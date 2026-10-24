unit untProcessadorGravandoExecucaoVelutexBases;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils, untIGravando, untIConfTinta,
  Variants;

type
  TProcessadorGravandoExecucaoVelutexBases = class(TAbstractAdoProcessadorGravandoExecucaoArquivos)
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

uses
  untFuncTinta, untProcessadorGravandoExecucaoVelutexEmbalagens,untFuncoesSimples;

{ TProcessadorGravandoExecucaoVelutexBases }

constructor TProcessadorGravandoExecucaoVelutexBases.Create;
begin
  inherited Create();
  conf := fGetConfTinta('VEL');
end;

function TProcessadorGravandoExecucaoVelutexBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

procedure TProcessadorGravandoExecucaoVelutexBases.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := conf.fGet('VELPAT');
end;

function TProcessadorGravandoExecucaoVelutexBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM VEL_CADBAS';
end;

function TProcessadorGravandoExecucaoVelutexBases.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT DISTINCT            ' +
    '   BASE                     ' +
    '   , [SIZE]                 ' +
    '   , [PRODUCT NAME]         ' +
    ' FROM                       ' +
    '   [PRODUCTS$]              ' +
    '   , [HEADING$]             ' +
    ' WHERE NOT BASE IS NULL     ' +
    '   AND NOT [SIZE] IS NULL   ';
end;

procedure TProcessadorGravandoExecucaoVelutexBases.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'VEL_CADBAS';
end;

procedure TProcessadorGravandoExecucaoVelutexBases.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('BAS_CODBAS').AsString := Trim(UpperCase(qryOrigem.FieldByName('BASE').AsString));
  qryDestino.FieldByName('BAS_PRODUT').AsString := Trim(UpperCase(qryOrigem.FieldByName('PRODUCT NAME').AsString));
  qryDestino.FieldByName('BAS_CODUNI').AsFloat := TProcessadorGravandoExecucaoVelutexEmbalagens.GetEmbalagem(qryOrigem.FieldByName('SIZE').AsString);
  qryDestino.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('VEL_CADBAS', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoVelutexBases.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_TAMEMB', VarArrayOf([Trim(UpperCase(qryOrigem.FieldByName('BASE').AsString)),
    Trim(UpperCase(qryOrigem.FieldByName('PRODUCT NAME').AsString)),
    TProcessadorGravandoExecucaoVelutexEmbalagens.GetEmbalagem(qryOrigem.FieldByName('SIZE').AsString)]), []);
end;

procedure TProcessadorGravandoExecucaoVelutexBases.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel cadastrar a base [%s - %s], [%s - %s]',
    [qryOrigem.FieldByName('BASE').AsString, qryOrigem.FieldByName('CODUNI').AsString, E.ClassName, E.Message]);
end;

end.

