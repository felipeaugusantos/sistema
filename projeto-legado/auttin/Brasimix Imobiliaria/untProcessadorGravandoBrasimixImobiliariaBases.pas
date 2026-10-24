unit untProcessadorGravandoBrasimixImobiliariaBases;

interface

uses
  untAbstractProcessadorGravandoBrasimixImobiliaria, Classes, DB, SysUtils, untIGravando,
  Variants;

type
  TProcessadorGravandoBrasimixImobiliariaBases = class(TAbstractProcessadorGravandoBrasimixImobiliaria)
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
  untFuncoesSimples;

{ TProcessadorGravandoBrasimixImobiliariaBases }

function TProcessadorGravandoBrasimixImobiliariaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TProcessadorGravandoBrasimixImobiliariaBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM BZI_CADBAS'
end;

function TProcessadorGravandoBrasimixImobiliariaBases.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
const
  arrUnidades: array[0..2] of string = ('LT', 'GL', 'LA');
var
  intCont: Integer;
begin

  Result := '';
  for intCont := 0 to Length(arrUnidades) - 1 do
  begin
    Result := Result + Format(
      ' UNION                    ' +
      ' SELECT DISTINCT          ' +
      '   LINHA                   ' +
      '   , BASE                 ' +
      '   , DESBAS                 ' +
      '   , ' + QuotedStr(arrUnidades[intCont]) + ' AS CODUNI     ' +
      ' FROM                     ' +
      '   [%s]  ' +
      ' WHERE BASE <> ''''       ',
      [StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll])]);
  end;
  Result := Trim(Result);
  Result := Copy(Result, Length('UNION') + 1, Length(Result));
  Result := Trim(Result);
end;

procedure TProcessadorGravandoBrasimixImobiliariaBases.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'BZI_CADBAS';
end;

procedure TProcessadorGravandoBrasimixImobiliariaBases.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('BAS_LINHA_').AsString := Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('LINHA').AsString)));
  qryDestino.FieldByName('BAS_BASE__').AsString := Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('BASE').AsString)));
  qryDestino.FieldByName('BAS_UNIDAD').AsString := Trim(AnsiUpperCase(qryOrigem.FieldByName('CODUNI').AsString));
  qryDestino.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('BAS_DESCRI').AsString := Trim(AnsiUpperCase(qryOrigem.FieldByName('DESBAS').AsString));
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('BZI_CADBAS', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoBrasimixImobiliariaBases.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_LINHA_;BAS_BASE__;BAS_UNIDAD', VarArrayOf([
    Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('LINHA').AsString))),
    Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('BASE').AsString))),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('CODUNI').AsString))]), []);
end;

procedure TProcessadorGravandoBrasimixImobiliariaBases.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel cadastrar a base [%s - %s - %s], [%s - %s]',
    [Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('LINHA').AsString))),
    Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('BASE').AsString))),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('CODUNI').AsString)), E.ClassName, E.Message]);
end;

end.  
