unit untProcessadorGravandoPpgBases;

interface

uses
  untAbstractProcessadorGravandoPpg, Classes, DB, SysUtils, untIGravando,
  Variants, Uni, StrUtils;

type
  TProcessadorGravandoPpgBases = class(TAbstractProcessadorGravandoPpg)
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

constructor TProcessadorGravandoPpgBases.Create;
begin
  inherited Create('PPG', 'PATPPG', 'PPG');
end;

function TProcessadorGravandoPpgBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TProcessadorGravandoPpgBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM PPG_CADBAS';
end;

function TProcessadorGravandoPpgBases.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
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

procedure TProcessadorGravandoPpgBases.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'PPG_CADBAS';
end;

procedure TProcessadorGravandoPpgBases.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('BAS_CODBAS').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('CODBAS').AsString)))));
  qryDestino.FieldByName('BAS_DESBAS').AsString := Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('DESBAS').AsString)))));
  qryDestino.FieldByName('BAS_PESESP').AsFloat := qryOrigem.FieldByName('PESESP').AsFloat;
  qryDestino.FieldByName('BAS_TIPO__').AsString:= qryOrigem.FieldByName('TIPO').AsString;
  qryDestino.FieldByName('BAS_BASEPO').AsString:= 'N';
  qryDestino.FieldByName('BAS_CODEMP').AsString:= VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString:= fRetAutoIncrem('PPG_CADBAS', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoPpgBases.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS', VarArrayOf([
    Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('CODBAS').AsString)))))]),
    []);
end;

procedure TProcessadorGravandoPpgBases.LimparTabelas;
begin
  inherited;
end;

procedure TProcessadorGravandoPpgBases.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando; const qryOrigem,
  qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel gravar a base [%s - %s - %S][%s: %s]',
    [Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('TIPO').AsString))))),
    Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('CODBAS').AsString))))),
    Trim(AnsiUpperCase(fRemoveAcento(Utf8ToAnsi(AnsiString(qryOrigem.FieldByName('DESBAS').AsString))))),
    E.ClassName, E.Message]);
end;

end.

