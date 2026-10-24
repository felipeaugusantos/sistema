unit untProcessadorGravandoBrazilianColorMontadoras;

interface

uses
  untAbstractProcessadorGravandoBrazilianColor, Classes, DB, SysUtils, untIGravando,
  Variants;

type
  TProcessadorGravandoBrazilianColorMontadoras = class(TAbstractProcessadorGravandoBrazilianColor)
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

{ TProcessadorGravandoBrazilianColorMontadoras }

function TProcessadorGravandoBrazilianColorMontadoras.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Montadoras';
end;

function TProcessadorGravandoBrazilianColorMontadoras.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM BZC_CADMON';
end;

function TProcessadorGravandoBrazilianColorMontadoras.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := 'SELECT * FROM MIX_Montadoras';
end;

procedure TProcessadorGravandoBrazilianColorMontadoras.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'BZC_CADMON';
end;

procedure TProcessadorGravandoBrazilianColorMontadoras.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('MON_CODMON').AsString :=
    fStrZero(Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('id_MIX_Montadora').AsString))), 5);
  qryDestino.FieldByName('MON_DESCRI').AsString := Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('Montadora').AsString)));
  qryDestino.FieldByName('MON_SIGLA_').AsString := Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('Sigla').AsString)));
  qryDestino.FieldByName('MON_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('BZC_CADMON', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoBrazilianColorMontadoras.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('MON_CODMON',
    VarArrayOf([fStrZero(Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('id_MIX_Montadora').AsString))), 5)]),
    []);
end;

procedure TProcessadorGravandoBrazilianColorMontadoras.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel cadastrar a montadora [%s - %s - %s] [%s: %s]',
    [fStrZero(Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('id_MIX_Montadora').AsString))), 5),
    Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('Montadora').AsString))),
    Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('Sigla').AsString))),
    E.ClassName, E.Message])
end;

end.
