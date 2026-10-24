unit untProcessadorGravandoExecucaoInternationalBases;

interface

uses
  untAbstractProcessadorGravandoInternational, DB, Classes, SysUtils, untIGravando,  Uni, ADODB,
  Variants;

type
  TProcessadorGravandoExecucaoInternationalBases = class (TAbstractProcessadorGravandoInternational)
  private
    function fRetornaCodigoEmbalagem(strEmbala: String): String;
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

{ TProcessadorGravandoExecucaoInternationalBases }

function TProcessadorGravandoExecucaoInternationalBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TProcessadorGravandoExecucaoInternationalBases.fRetornaCodigoEmbalagem(
  strEmbala: String): String;
begin
  If strEmbala = '3,6' Then
    Result := '1'
  Else If strEmbala = '20' Then
    Result := '2'
  Else
    Result := '3';
end;

function TProcessadorGravandoExecucaoInternationalBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM INT_CADBAS';
end;

procedure TProcessadorGravandoExecucaoInternationalBases.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'INT_CADBAS';
end;

procedure TProcessadorGravandoExecucaoInternationalBases.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('BAS_CODBAS').AsString := qryOrigem.FieldByName('Base').AsString;
  qryDestino.FieldByName('BAS_CODEMB').AsString := fRetornaCodigoEmbalagem(FloatToStr(fFormataFloat(qryOrigem.FieldByName('Vasilhame').AsFloat,2)));
  qryDestino.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('INT_CADBAS', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoInternationalBases.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := ((qryDestino.Locate('BAS_CODBAS;BAS_CODEMB', VarArrayOf([
              qryOrigem.FieldByName('Base').AsString,
              fRetornaCodigoEmbalagem(FloatToStr(fFormataFloat(qryOrigem.FieldByName('Vasilhame').AsFloat,2)))]), [])) Or
             (fEmptyStr(qryOrigem.FieldByName('Base').AsString)));
end;

procedure TProcessadorGravandoExecucaoInternationalBases.RegistrarImpossivelGravarRegistro(const E: Exception;
  const gravando: IGravando; const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar o colorante [%s %s %s %s], [%s: %s]', [
    qryOrigem.FieldByName('BAS_CODBAS').AsString,
    E.ClassName,
    E.Message
  ]);
end;

function TProcessadorGravandoExecucaoInternationalBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := 'SELECT * FROM Production_History ORDER BY Base';
end;


end.
