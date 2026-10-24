unit untProcessadorGravandoExecucaoCalamarBases;

interface

uses
   Classes, DB, SysUtils, untIGravando,
  Variants, untAbstractProcessadorGravandoExecucaoCalamar;

type
  TProcessadorGravandoExecucaoCalamarBases = class abstract(TAbstractProcessadorGravandoExecucaoCalamar)
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
 untAbstractAdoProcessadorGravandoExecucaoArquivos, untFuncoesSimples;

{ TProcessadorGravandoExecucaoCalamarBases }

function TProcessadorGravandoExecucaoCalamarBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TProcessadorGravandoExecucaoCalamarBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM CAL_CADBAS';
end;

function TProcessadorGravandoExecucaoCalamarBases.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT DISTINCT    ' +
    '   B.CODE           ' +
    '   , B.DESCRIPTION  ' +
    '   , C.ID AS ID_EMB ' +
    ' FROM               ' +
    '   BASES B          ' +
    '   , CANS C         ';
end;

procedure TProcessadorGravandoExecucaoCalamarBases.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'CAL_CADBAS';
end;

procedure TProcessadorGravandoExecucaoCalamarBases.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CAL_CADBAS', VS_strCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('BAS_DESCRI').AsString := LimpaTexto(qryOrigem.FieldByName('DESCRIPTION').AsString);
  qryDestino.FieldByName('BAS_CODBAS').AsString := LimpaTexto(qryOrigem.FieldByName('CODE').AsString);
  qryDestino.FieldByName('BAS_CODEMB').AsString := fStrZero(LimpaTexto(qryOrigem.FieldByName('ID_EMB').AsString), 3);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoCalamarBases.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS;BAS_CODEMB', VarArrayOf([
    LimpaTexto(qryOrigem.FieldByName('CODE').AsString),
    fStrZero(LimpaTexto(qryOrigem.FieldByName('ID_EMB').AsString), 3)]), []);
end;

procedure TProcessadorGravandoExecucaoCalamarBases.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a base: [%s - %s], [%s: %s]',
    [LimpaTexto(qryOrigem.FieldByName('CODE').AsString),
    fStrZero(LimpaTexto(qryOrigem.FieldByName('ID_EMB').AsString), 3),
    E.ClassName,
    E.Message]);
end;

end.

