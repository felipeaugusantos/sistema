unit untProcessadorGravandoExecucaoEucatexColorantes;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils, untIGravando, untIConfTinta,
  Variants, ADODB, Windows;

type
  TProcessadorGravandoExecucaoEucatexColorantes = class(TAbstractAdoProcessadorGravandoExecucaoArquivos)
  private
    conf: IConfTinta;
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery; override;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    procedure GetArquivosProcessar(const stlArquivos: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
    constructor Create();
  end;

implementation
uses untFuncoesSimples,untFuncTinta,untDefinicaoTxtFormato,untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo,untIDefinicaoTxt, untADOTxtFactory,untGenericDefinicaoTxt;
{ TProcessadorGravandoExecucaoEucatexColorantes }

constructor TProcessadorGravandoExecucaoEucatexColorantes.Create;
begin
  inherited Create();
  conf := fGetConfTinta('EUC');  
end;

function TProcessadorGravandoExecucaoEucatexColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TProcessadorGravandoExecucaoEucatexColorantes.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
var
  definicao: IDefinicaoTxt;
begin
  definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, dtfCustom, ',', dtcsAnsi, '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([]));
  strNomeArquivo := definicao.NomeArquivo;
  TADOTxtFactory.Registrar(definicao);
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

procedure TProcessadorGravandoExecucaoEucatexColorantes.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := conf.fGet('EUCPAT');
end;

function TProcessadorGravandoExecucaoEucatexColorantes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM EUC_CADCOL';
end;

function TProcessadorGravandoExecucaoEucatexColorantes.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
var
  intCont: Integer;
begin

  Result := '';
  for intCont := 1 to 5 do
  begin
    Result := Result + Format(
      ' UNION                    ' +
      ' SELECT DISTINCT          ' +
      '   CNT' + IntToStr(intCont) + ' AS CODCOL     ' +
      ' FROM                     ' +
      '   [%s]  ' +
      ' WHERE CNT' + IntToStr(intCont) + ' <> ''''       ',
      [StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll])]);
  end;
  Result := Trim(Result);
  Result := Copy(Result, Length('UNION') + 1, Length(Result));
  Result := Trim(Result);
end;

procedure TProcessadorGravandoExecucaoEucatexColorantes.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'EUC_CADCOL';
end;

procedure TProcessadorGravandoExecucaoEucatexColorantes.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('COL_CODCOL').AsString := Trim(AnsiUpperCase(qryOrigem.FieldByName('CODCOL').AsString));
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EUC_CADCOL', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoEucatexColorantes.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL',
    VarArrayOf([Trim(AnsiUpperCase(qryOrigem.FieldByName('CODCOL').AsString))]), []);
end;

procedure TProcessadorGravandoExecucaoEucatexColorantes.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel cadastrar o colorante [%s], [%s - %s]',
    [Trim(AnsiUpperCase(qryOrigem.FieldByName('CODCOL').AsString)), E.ClassName, E.Message]);
end;

end.
