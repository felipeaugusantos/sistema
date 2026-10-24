unit untProcessadorGravandoPpgMontadoras;

interface

uses
  untAbstractProcessadorGravandoPpg, Classes, DB, SysUtils, untIGravando,
  Variants, Uni, StrUtils;

type
  TProcessadorGravandoPpgMontadoras = class(TAbstractProcessadorGravandoPpg)
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
    procedure LimparTabelas; override;
    constructor Create(); reintroduce;
  end;

implementation

uses
  untFuncoesSimples;

{ TProcessadorGravandoPpgMontadoras }

constructor TProcessadorGravandoPpgMontadoras.Create;
begin
  inherited Create('PPG', 'PATPPG', 'PPG');
end;

function TProcessadorGravandoPpgMontadoras.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Montadoras';
end;

function TProcessadorGravandoPpgMontadoras.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM PPG_CADMON';
end;

function TProcessadorGravandoPpgMontadoras.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT DISTINCT                       ' +
    '   [MANUFACTURER KEY CODE] AS CODMON             ' +
    '   , [MANUFACTURER DESCRIPTION] AS DESCRI        ' +
    ' FROM                                  ' +
    '   ' + StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll]) + '        ' +
    ' WHERE [MANUFACTURER KEY CODE] <> '''' AND (NOT [MANUFACTURER KEY CODE] LIKE ''%,%'') ' +
    ' AND UCase([Brand Description]) = ' + AnsiUpperCase(QuotedStr(strMarca));
end;

procedure TProcessadorGravandoPpgMontadoras.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'PPG_CADMON';
end;

procedure TProcessadorGravandoPpgMontadoras.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('MON_CODMON').AsString := qryOrigem.FieldByName('CODMON').AsString;
  qryDestino.FieldByName('MON_DESCRI').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('DESCRI').AsString)))));
  qryDestino.FieldByName('MON_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PPG_CADMON', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoPpgMontadoras.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('MON_CODMON', VarArrayOf([Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('CODMON').AsString)))))]),
    []);
end;

procedure TProcessadorGravandoPpgMontadoras.LimparTabelas;
begin
  inherited;

end;

procedure TProcessadorGravandoPpgMontadoras.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel gravar a montadora [%s - %s][%s: %s]', [
    qryOrigem.FieldByName('CODMON').AsString,
    Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('DESCRI').AsString))))),
    E.ClassName, E.Message
  ])
end;

end.
