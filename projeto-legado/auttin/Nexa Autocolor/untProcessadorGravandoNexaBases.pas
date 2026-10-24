unit untProcessadorGravandoNexaBases;

interface

uses
  untAbstractProcessadorGravandoPpg, Classes, DB, SysUtils, untIGravando,
  Variants, Uni, StrUtils;

type
  TProcessadorGravandoNexaBases = class(TAbstractProcessadorGravandoPpg)
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

{ TProcessadorGravandoPpgBases }

constructor TProcessadorGravandoNexaBases.Create;
begin
  inherited Create('NEX', 'PATNEXA', 'NEXA AUTOCOLOR');
end;

function TProcessadorGravandoNexaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TProcessadorGravandoNexaBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM NEX_CADBAS';
end;

function TProcessadorGravandoNexaBases.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; 
var
  intCont: Integer;
begin
  Result := '';
  for intCont := 1 to 11 do
  begin
    Result := Result +
      ' UNION                           ' +
      ' SELECT                          ' +
      '   [MIXING SCHEME DESCRIPTION] AS TIPO               ' +
      '   , [PRODUCT' + IntToStr(intCont) + ' CODE] AS CODBAS               ' +
      '   , PRODUCT' + IntToStr(intCont) + 'DESCRIPTION AS DESBAS         ' +
      '   , GRAVITYPRODUCT' + IntToStr(intCont) + ' AS PESESP             ' +
      ' FROM                            ' +
      '   ' + StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll]) + '  ' +
      ' WHERE [PRODUCT' + IntToStr(intCont) + ' CODE] <> ''''   ' +
      ' AND UCase([Brand Description]) = ' + AnsiUpperCase(QuotedStr(strMarca));
  end;

  Result := Trim(Result);
  Result := Copy(Result, Length('UNION') + 1, Length(Result));
  Result := Trim(Result);
end;

procedure TProcessadorGravandoNexaBases.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'NEX_CADBAS';
end;

procedure TProcessadorGravandoNexaBases.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('BAS_CODBAS').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('CODBAS').AsString)))));
  qryDestino.FieldByName('BAS_DESBAS').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('DESBAS').AsString)))));
  qryDestino.FieldByName('BAS_PESESP').AsFloat := qryOrigem.FieldByName('PESESP').AsFloat;
  qryDestino.FieldByName('BAS_TIPO__').AsString:= qryOrigem.FieldByName('TIPO').AsString;
  qryDestino.FieldByName('BAS_BASEPO').AsString:= 'N';
  qryDestino.FieldByName('BAS_CODEMP').AsString:= VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString:= fRetAutoIncrem('NEX_CADBAS', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoNexaBases.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS', VarArrayOf([
    Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('CODBAS').AsString)))))]),
    []);
end;

procedure TProcessadorGravandoNexaBases.LimparTabelas;
begin
  inherited;
end;

procedure TProcessadorGravandoNexaBases.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando; const qryOrigem,
  qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel gravar a base [%s - %s - %S][%s: %s]',
    [Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('TIPO').AsString))))),
    Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('CODBAS').AsString))))),
    Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('DESBAS').AsString))))),
    E.ClassName, E.Message]);
end;

end.
