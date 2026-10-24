unit untProcessadorGravandoExecucaoHydronorthBases;

interface

uses
  Classes, DB, SysUtils, untIGravando,
  Variants, untAbstractProcessadorGravandoExecucaoHydronorth;

type
  TProcessadorGravandoExecucaoHydronorthBases = class abstract(TAbstractProcessadorGravandoExecucaoHydronorth)
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
   untProcessadorGravandoExecucaoHydronorthEmbalagens,untFuncoesSimples,untAbstractAdoProcessadorGravandoExecucaoArquivos;

{ TProcessadorGravandoExecucaoHydronorthBases }

function TProcessadorGravandoExecucaoHydronorthBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TProcessadorGravandoExecucaoHydronorthBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM HYD_CADBAS';
end;

function TProcessadorGravandoExecucaoHydronorthBases.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT DISTINCT         ' +
    '   PRODUTO               ' +
    '   , BASE                ' +
    '   , EMB                 ' +
    ' FROM                    ' +
    '   [Hydronorth$]         ' +
    '   ,                     ' +
    '   (' + TProcessadorGravandoExecucaoHydronorthEmbalagens.GetSqlOrigem + ') AS T ' +
    ' WHERE PRODUTO <> ''''   ';
end;

procedure TProcessadorGravandoExecucaoHydronorthBases.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'HYD_CADBAS';
end;

procedure TProcessadorGravandoExecucaoHydronorthBases.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('HYD_CADBAS', VS_strCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('BAS_PRODUT').AsString := LimpaTexto(qryOrigem.FieldByName('PRODUTO').AsString);
  qryDestino.FieldByName('BAS_BASE__').AsString := LimpaTexto(qryOrigem.FieldByName('BASE').AsString);
  qryDestino.FieldByName('BAS_CODEMB').AsString :=
    TProcessadorGravandoExecucaoHydronorthEmbalagens.GetCodigoEmbalagem(qryOrigem.FieldByName('EMB').AsString);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoHydronorthBases.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_BASE__;BAS_PRODUT;BAS_CODEMB', VarArrayOf([
    LimpaTexto(qryOrigem.FieldByName('BASE').AsString),
    LimpaTexto(qryOrigem.FieldByName('PRODUTO').AsString),
    TProcessadorGravandoExecucaoHydronorthEmbalagens.GetCodigoEmbalagem(qryOrigem.FieldByName('EMB').AsString)
  ]), []);
end;

procedure TProcessadorGravandoExecucaoHydronorthBases.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a base: [%s - %s - %s], [%s: %s]',
    [LimpaTexto(qryOrigem.FieldByName('BASE').AsString),
    LimpaTexto(qryOrigem.FieldByName('PRODUTO').AsString),
    TProcessadorGravandoExecucaoHydronorthEmbalagens.GetCodigoEmbalagem(qryOrigem.FieldByName('EMB').AsString),
    E.ClassName,
    E.Message]);
end;

end.
