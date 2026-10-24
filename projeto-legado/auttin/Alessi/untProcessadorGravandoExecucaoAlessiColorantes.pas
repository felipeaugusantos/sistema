unit untProcessadorGravandoExecucaoAlessiColorantes;

interface

uses
  untAbstractProcessadorGravandoExecucaoAlessi, Classes, DB,  Variants, SysUtils,
  untIGravando;

type
  TProcessadorGravandoExecucaoAlessiColorantes = class(TAbstractProcessadorGravandoExecucaoAlessi)
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

uses untFuncoesSimples;

{ TProcessadorGravandoExecucaoAlessiColorantes }

function TProcessadorGravandoExecucaoAlessiColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TProcessadorGravandoExecucaoAlessiColorantes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM ALE_CADCOL';
end;

function TProcessadorGravandoExecucaoAlessiColorantes.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT DISTINCT            ' +
    '   [NOME CORANTE]           ' +
    ' FROM                       ' +
    '   [CORANTES$]              ' +
    ' WHERE [NOME CORANTE] <> "" ';
end;

procedure TProcessadorGravandoExecucaoAlessiColorantes.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'ALE_CADCOL';
end;

procedure TProcessadorGravandoExecucaoAlessiColorantes.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ALE_CADCOL', VS_strCodEmp);
  qryDestino.FieldByName('COL_CODCOL').AsString := LimpaTexto(qryOrigem.FieldByName('NOME CORANTE').AsString);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoAlessiColorantes.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', VarArrayOf([LimpaTexto(qryOrigem.FieldByName('NOME CORANTE').AsString)]), []);
end;

procedure TProcessadorGravandoExecucaoAlessiColorantes.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel gravar o colorante [%s], [%s: %s]', [LimpaTexto(qryOrigem.FieldByName('NOME CORANTE').AsString),
    E.ClassName, E.Message]);
end;

end.
