unit untProcessadorGravandoBrasimixImobiliariaColorantes;

interface

uses
  untAbstractProcessadorGravandoBrasimixImobiliaria, Classes, DB, SysUtils, untIGravando,
  Variants;

type
  TProcessadorGravandoBrasimixImobiliariaColorantes = class(TAbstractProcessadorGravandoBrasimixImobiliaria)
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

function TProcessadorGravandoBrasimixImobiliariaColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TProcessadorGravandoBrasimixImobiliariaColorantes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM BZI_CADCOL'
end;

function TProcessadorGravandoBrasimixImobiliariaColorantes.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
var
  intCont: Integer;
begin
  Result := '';
  for intCont := 1 to 10 do
  begin
    Result := Result + Format(
      ' UNION                    ' +
      ' SELECT           ' +
      '   FORM' + fStrZero(intCont, 2) + ' AS CODCOL     ' +
      ' FROM                     ' +
      '   [%s]  ' +
      ' WHERE FORM' + fStrZero(intCont, 2) + ' <> ''''       ',
      [StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll])]);
  end;
  Result := Trim(Result);
  Result := Copy(Result, Length('UNION') + 1, Length(Result));
  Result := Trim(Result);
end;

procedure TProcessadorGravandoBrasimixImobiliariaColorantes.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'BZI_CADCOL';
end;

procedure TProcessadorGravandoBrasimixImobiliariaColorantes.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('COL_CODCOL').AsString := Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('CODCOL').AsString)));
  qryDestino.FieldByName('COL_PESESP').AsFloat := 1;
  qryDestino.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('BZI_CADCOL', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoBrasimixImobiliariaColorantes.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', VarArrayOf([
    Trim(AnsiUpperCase(qryOrigem.FieldByName('CODCOL').AsString))]), []);
end;

procedure TProcessadorGravandoBrasimixImobiliariaColorantes.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel cadastrar o colorante [%s], [%s - %s]',
    [Trim(AnsiUpperCase(qryOrigem.FieldByName('CODCOL').AsString)), E.ClassName, E.Message]);
end;

end.
