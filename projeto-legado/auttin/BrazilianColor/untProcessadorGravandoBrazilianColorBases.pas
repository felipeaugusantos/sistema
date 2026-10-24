unit untProcessadorGravandoBrazilianColorBases;

interface

uses
  untAbstractProcessadorGravandoBrazilianColor, Classes, DB, SysUtils, untIGravando,
  Variants;

type
  TProcessadorGravandoBrazilianColorBases = class(TAbstractProcessadorGravandoBrazilianColor)
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

{ TProcessadorGravandoBrazilianColorBases }

function TProcessadorGravandoBrazilianColorBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TProcessadorGravandoBrazilianColorBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM BZC_CADBAS';
end;

function TProcessadorGravandoBrazilianColorBases.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := 'SELECT * FROM MIX_Bases';
end;

procedure TProcessadorGravandoBrazilianColorBases.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'BZC_CADBAS';
end;

procedure TProcessadorGravandoBrazilianColorBases.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('BAS_CODBAS').AsString := Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('Codigo').AsString)));
  qryDestino.FieldByName('BAS_DESBAS').AsString := Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('Descricao').AsString)));
  qryDestino.FieldByName('BAS_ESPECI').AsString := Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('Especificacao').AsString)));
  qryDestino.FieldByName('BAS_PESESP').AsFloat := qryOrigem.FieldByName('PesoEspecifico').AsFloat;
  qryDestino.FieldByName('BAS_EMBALA').AsFloat := qryOrigem.FieldByName('EmbCompra').AsFloat * 1000;
  qryDestino.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('BZC_CADBAS', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoBrazilianColorBases.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS', VarArrayOf([Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('Codigo').AsString)))]), []);
end;

procedure TProcessadorGravandoBrazilianColorBases.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('não foi possivel cadastrar a base [%s - %s - %s][%s: %s]',
    [Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('Codigo').AsString))),
    Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('Descricao').AsString))),
    Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('Especificacao').AsString))),
    E.ClassName, E.Message]);
end;

end.
