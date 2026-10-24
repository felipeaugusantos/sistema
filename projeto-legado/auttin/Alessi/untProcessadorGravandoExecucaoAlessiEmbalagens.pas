unit untProcessadorGravandoExecucaoAlessiEmbalagens;

interface

uses
  untAbstractProcessadorGravandoExecucaoAlessi, Classes, DB,  Variants, SysUtils,
  untIGravando;

type
  TProcessadorGravandoExecucaoAlessiEmbalagens = class(TAbstractProcessadorGravandoExecucaoAlessi)
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

{ TProcessadorGravandoExecucaoAlessiEmbalagens }

function TProcessadorGravandoExecucaoAlessiEmbalagens.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagens';
end;

function TProcessadorGravandoExecucaoAlessiEmbalagens.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM ALE_CADEMB';
end;

function TProcessadorGravandoExecucaoAlessiEmbalagens.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT DISTINCT  ' +
    '   [NOME]         ' +
    '   , [LT]         ' +
    ' FROM             ' +
    '   [EMBALAGENS$]  ' +
    ' WHERE NOME <> "" ';
end;

procedure TProcessadorGravandoExecucaoAlessiEmbalagens.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'ALE_CADEMB';
end;

procedure TProcessadorGravandoExecucaoAlessiEmbalagens.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ALE_CADEMB', VS_strCodEmp);
  qryDestino.FieldByName('EMB_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('EMB_NOME__').AsString := LimpaTexto(qryOrigem.FieldByName('NOME').AsString);
  qryDestino.FieldByName('EMB_QTDEMB').AsFloat := qryOrigem.FieldByName('LT').AsFloat;
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoAlessiEmbalagens.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('EMB_NOME__', VarArrayOf([LimpaTexto(qryOrigem.FieldByName('NOME').AsString)]), []);
end;

procedure TProcessadorGravandoExecucaoAlessiEmbalagens.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não é possivel gravar a embalagem [%s], [%s: %s]',
    [LimpaTexto(qryOrigem.FieldByName('NOME').AsString), E.ClassName, E.Message]);
end;

end.
