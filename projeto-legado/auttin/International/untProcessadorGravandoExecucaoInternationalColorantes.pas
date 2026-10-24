unit untProcessadorGravandoExecucaoInternationalColorantes;

interface

uses
  untAbstractProcessadorGravandoInternational, DB, Classes, SysUtils, untIGravando,  Uni, ADODB;

type
  TProcessadorGravandoExecucaoInternationalColorantes = class (TAbstractProcessadorGravandoInternational)
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
  end;

implementation

uses
  untNovaFormulaInternational, untFuncoesSimples;

{ TProcessadorGravandoExecucaoInternationalColorantes }

function TProcessadorGravandoExecucaoInternationalColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TProcessadorGravandoExecucaoInternationalColorantes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM INT_CADCOL';
end;

procedure TProcessadorGravandoExecucaoInternationalColorantes.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'INT_CADCOL';
end;

procedure TProcessadorGravandoExecucaoInternationalColorantes.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('COL_CODCOL').AsString := qryOrigem.FieldByName('Corante').AsString;
  qryDestino.FieldByName('COL_EMBALA').AsFloat  := 4000;
  qryDestino.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('INT_CADCOL', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoInternationalColorantes.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := ((qryDestino.Locate('COL_CODCOL', qryOrigem.FieldByName('Corante').AsString, [])) Or
             (fEmptyStr(qryOrigem.FieldByName('Corante').AsString)));
end;

procedure TProcessadorGravandoExecucaoInternationalColorantes.RegistrarImpossivelGravarRegistro(const E: Exception;
  const gravando: IGravando; const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar o colorante [%s %s %s %s], [%s: %s]', [
    qryOrigem.FieldByName('COL_CODCOL').AsString,
    E.ClassName,
    E.Message
  ]);
end;

function TProcessadorGravandoExecucaoInternationalColorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := 'SELECT * FROM Uso_Corante ORDER BY Corante';
end;


end.
