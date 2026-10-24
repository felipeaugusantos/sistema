unit untProcessadorGravandoNexaMontadoras;

interface

uses
  untAbstractProcessadorGravandoPpg, Classes, DB, SysUtils, untIGravando,
  Variants, Uni, StrUtils;

type
  TProcessadorGravandoNexaMontadoras = class(TAbstractProcessadorGravandoPpg)
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

constructor TProcessadorGravandoNexaMontadoras.Create;
begin
  inherited Create('NEX', 'PATNEXA', 'NEXA AUTOCOLOR');
end;

function TProcessadorGravandoNexaMontadoras.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Montadoras';
end;

function TProcessadorGravandoNexaMontadoras.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM NEX_CADMON';
end;

function TProcessadorGravandoNexaMontadoras.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; 
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

procedure TProcessadorGravandoNexaMontadoras.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'NEX_CADMON';
end;

procedure TProcessadorGravandoNexaMontadoras.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('MON_CODMON').AsString := qryOrigem.FieldByName('CODMON').AsString;
  qryDestino.FieldByName('MON_DESCRI').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('DESCRI').AsString)))));
  qryDestino.FieldByName('MON_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('NEX_CADMON', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoNexaMontadoras.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('MON_CODMON', VarArrayOf([Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('CODMON').AsString)))))]),
    []);
end;

procedure TProcessadorGravandoNexaMontadoras.LimparTabelas;
begin
  inherited;

end;

procedure TProcessadorGravandoNexaMontadoras.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel gravar a montadora [%s - %s][%s: %s]', [
    qryOrigem.FieldByName('CODMON').AsString,
    Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('DESCRI').AsString))))),
    E.ClassName, E.Message
  ])
end;

end.
