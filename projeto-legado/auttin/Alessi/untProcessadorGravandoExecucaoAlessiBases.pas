unit untProcessadorGravandoExecucaoAlessiBases;

interface

uses
  untAbstractProcessadorGravandoExecucaoAlessi, Classes, DB,  Variants, SysUtils,
  untIGravando;

type
  TProcessadorGravandoExecucaoAlessiBases = class(TAbstractProcessadorGravandoExecucaoAlessi)
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
    function fRetCodUnidade(strEmbalagem : String ) : String;
  end;

implementation

uses untFuncoesSimples;

{ TProcessadorGravandoExecucaoAlessiBases }

function TProcessadorGravandoExecucaoAlessiBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TProcessadorGravandoExecucaoAlessiBases.fRetCodUnidade(strEmbalagem: String): String;
begin
  Result := 'LT';

  if ((strEmbalagem =  'GALAO') Or (strEmbalagem =  '5KG')) Then
    Result := 'GL'
  else
  if ((strEmbalagem =  'LATA') Or (strEmbalagem =  '25KG')) Then
    Result := 'LA'
  else
  if (strEmbalagem =  'QUARTO') Then
    Result := 'QT';
end;

function TProcessadorGravandoExecucaoAlessiBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM ALE_CADBAS';
end;

function TProcessadorGravandoExecucaoAlessiBases.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT              ' +
    '   *                 ' +
    ' FROM                ' +
    '   [BASES$]          ' +
    ' WHERE PRODUTO <> "" ';
end;

procedure TProcessadorGravandoExecucaoAlessiBases.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'ALE_CADBAS';
end;

procedure TProcessadorGravandoExecucaoAlessiBases.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ALE_CADBAS', VS_strCodEmp);
  qryDestino.FieldByName('BAS_PRODUT').AsString := LimpaTexto(qryOrigem.FieldByName('PRODUTO').AsString);
  qryDestino.FieldByName('BAS_BASE__').AsString := LimpaTexto(qryOrigem.FieldByName('BASE').AsString);
  qryDestino.FieldByName('BAS_EMBALA').AsString := LimpaTexto(qryOrigem.FieldByName('EMBALAGEM').AsString);
  qryDestino.FieldByName('BAS_CODUNI').AsString := fRetCodUnidade(LimpaTexto(qryOrigem.FieldByName('EMBALAGEM').AsString));
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoAlessiBases.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_PRODUT;BAS_BASE__;BAS_EMBALA', VarArrayOf([LimpaTexto(qryOrigem.FieldByName('PRODUTO').AsString),
    LimpaTexto(qryOrigem.FieldByName('BASE').AsString),
    LimpaTexto(qryOrigem.FieldByName('EMBALAGEM').AsString)]), []);
end;

procedure TProcessadorGravandoExecucaoAlessiBases.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel gravar a base [%s - %s - %s], [%s: %s]', [
    LimpaTexto(qryOrigem.FieldByName('PRODUTO').AsString),
    LimpaTexto(qryOrigem.FieldByName('BASE').AsString),
    LimpaTexto(qryOrigem.FieldByName('EMBALAGEM').AsString),
    E.ClassName,
    E.Message]);
end;

end.
