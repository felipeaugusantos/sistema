unit untProcessadorGravandoExecucaoCalamarColorantes;

interface

uses
   Classes, DB, SysUtils, untIGravando,
   Variants, untAbstractProcessadorGravandoExecucaoCalamar;

type
  TProcessadorGravandoExecucaoCalamarColorantes = class abstract(TAbstractProcessadorGravandoExecucaoCalamar)
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
   untFuncoesSimples,untAbstractAdoProcessadorGravandoExecucaoArquivos;

{ TProcessadorGravandoExecucaoCalamarColorantes }

function TProcessadorGravandoExecucaoCalamarColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TProcessadorGravandoExecucaoCalamarColorantes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM CAL_CADCOL';
end;

function TProcessadorGravandoExecucaoCalamarColorantes.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; 
begin
  Result :=
    ' SELECT DISTINCT ' +
    '   CODE          ' +
    '   , DESCRIPTION ' +
    '   , SW          ' +
    ' FROM            ' +
    '   COMPONENTS    ';
end;

procedure TProcessadorGravandoExecucaoCalamarColorantes.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'CAL_CADCOL';
end;

procedure TProcessadorGravandoExecucaoCalamarColorantes.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CAL_CADCOL', VS_strCodEmp);
  qryDestino.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('COL_CODCOL').AsString := LimpaTexto(qryOrigem.FieldByName('CODE').AsString);
  qryDestino.FieldByName('COL_DESCRI').AsString := LimpaTexto(qryOrigem.FieldByName('DESCRIPTION').AsString);
  qryDestino.FieldByName('COL_EMBALA').AsFloat := 1000;
  qryDestino.FieldByName('COL_PESESP').AsFloat := qryOrigem.FieldByName('SW').AsFloat;
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoCalamarColorantes.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', VarArrayOf([
    LimpaTexto(qryOrigem.FieldByName('CODE').AsString)]), []);
end;

procedure TProcessadorGravandoExecucaoCalamarColorantes.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar o colorante: [%s], [%s: %s]',
    [LimpaTexto(qryOrigem.FieldByName('CODE').AsString),
    E.ClassName,
    E.Message]);
end;

end.

