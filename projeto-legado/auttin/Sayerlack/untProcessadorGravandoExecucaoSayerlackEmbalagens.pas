unit untProcessadorGravandoExecucaoSayerlackEmbalagens;

interface

uses
  untAbstractProcessadorGravandoExecucaoSayerlack, SysUtils, Classes, DB,
  Variants, untIGravando;

type
  TProcessadorGravandoExecucaoSayerlackEmbalagens = class(TAbstractProcessadorGravandoExecucaoSayerlack)
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
uses untFuncoesSimples,untSayerLackComuns;
{ TProcessadorGravandoExecucaoSayerlackEmbalagens }

function TProcessadorGravandoExecucaoSayerlackEmbalagens.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagens';
end;

function TProcessadorGravandoExecucaoSayerlackEmbalagens.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM SAY_CADEMB';
end;

function TProcessadorGravandoExecucaoSayerlackEmbalagens.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT DISTINCT                        ' +
    '   B.F6 AS [EMBALA]                     ' +
    ' FROM                                   ' +
    '   [BASEPACK$] AS B                     ' +
    ' WHERE NOT B.F6 IN ('''', ''PackCode'') ';
end;

procedure TProcessadorGravandoExecucaoSayerlackEmbalagens.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'SAY_CADEMB';
end;

procedure TProcessadorGravandoExecucaoSayerlackEmbalagens.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SAY_CADEMB', VS_strCodEmp);
  qryDestino.FieldByName('EMB_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('EMB_CODUNI').AsString := qryOrigem.FieldByName('EMBALA').AsString;
  qryDestino.FieldByName('EMB_DESEMB').AsString := TSayerLackComuns.fRetornaDesUni(qryOrigem.FieldByName('EMBALA').AsString);
  qryDestino.FieldByName('EMB_EMBALA').AsFloat  := TSayerLackComuns.GetEmbala(qryOrigem.FieldByName('EMBALA').AsString);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoSayerlackEmbalagens.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('EMB_DESEMB', qryOrigem.FieldByName('EMBALA').AsString, []);
end;

procedure TProcessadorGravandoExecucaoSayerlackEmbalagens.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a embalagem [%s], [%s: %s]',
    [qryOrigem.FieldByName('EMBALA').AsString, E.ClassName, E.Message]);
end;

end.
