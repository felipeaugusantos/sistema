unit untProcessadorGravandoExecucaoCalamarEmbalagens;

interface

uses
   Classes, DB, SysUtils, untIGravando,
   Variants, untAbstractProcessadorGravandoExecucaoCalamar;

type
  TProcessadorGravandoExecucaoCalamarEmbalagens = class abstract(TAbstractProcessadorGravandoExecucaoCalamar)
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

{ TProcessadorGravandoExecucaoCalamarEmbalagens }

function TProcessadorGravandoExecucaoCalamarEmbalagens.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagens';
end;

function TProcessadorGravandoExecucaoCalamarEmbalagens.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM CAL_CADEMB';
end;

function TProcessadorGravandoExecucaoCalamarEmbalagens.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; 
begin
  Result :=
    ' SELECT DISTINCT ' +
    '   ID            ' +
    '   , DESCRIPTION ' +
    '   , CAPACITY    ' +
    ' FROM            ' +
    '   CANS          ';
end;

procedure TProcessadorGravandoExecucaoCalamarEmbalagens.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'CAL_CADEMB';
end;

procedure TProcessadorGravandoExecucaoCalamarEmbalagens.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CAL_CADEMB', VS_strCodEmp);
  qryDestino.FieldByName('EMB_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('EMB_CODEMB').AsString := fStrZero(LimpaTexto(qryOrigem.FieldByName('ID').AsString), 3);
  qryDestino.FieldByName('EMB_DESCRI').AsString := LimpaTexto(qryOrigem.FieldByName('DESCRIPTION').AsString);
  qryDestino.FieldByName('EMB_TAMEMB').AsFloat := qryOrigem.FieldByName('CAPACITY').AsFloat;
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoCalamarEmbalagens.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('EMB_CODEMB', VarArrayOf([
    fStrZero(LimpaTexto(qryOrigem.FieldByName('ID').AsString), 3)]), []);
end;

procedure TProcessadorGravandoExecucaoCalamarEmbalagens.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a embalagem: [%s], [%s: %s]',
    [LimpaTexto(qryOrigem.FieldByName('ID').AsString),
    E.ClassName,
    E.Message]);
end;

end.

