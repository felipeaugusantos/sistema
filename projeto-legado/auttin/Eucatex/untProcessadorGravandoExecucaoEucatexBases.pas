unit untProcessadorGravandoExecucaoEucatexBases;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils, untIGravando, untIConfTinta,
  Variants,  ADODB, Windows;

type
  TProcessadorGravandoExecucaoEucatexBases = class(TAbstractAdoProcessadorGravandoExecucaoArquivos)
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
uses untFuncoesSimples,untFuncTinta, untDefinicaoTxtFormato,untDefinicaoTxtCharacterSet,untIDefinicaoTxtCampo, untIDefinicaoTxt, untADOTxtFactory,untGenericDefinicaoTxt;
{ TProcessadorGravandoExecucaoEucatexBases }

constructor TProcessadorGravandoExecucaoEucatexBases.Create;
begin
  inherited Create();
  conf := fGetConfTinta('EUC');
end;

function TProcessadorGravandoExecucaoEucatexBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TProcessadorGravandoExecucaoEucatexBases.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
var
  definicao: IDefinicaoTxt;
begin
  definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, dtfCustom, ',', dtcsAnsi, '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([]));
  strNomeArquivo := definicao.NomeArquivo;
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

procedure TProcessadorGravandoExecucaoEucatexBases.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := conf.fGet('EUCPAT');
end;

function TProcessadorGravandoExecucaoEucatexBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM EUC_CADBAS';
end;

function TProcessadorGravandoExecucaoEucatexBases.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
var
  arrUnidades: array[0..2] of string;
  intCont: Integer;
begin
  arrUnidades[0] := conf.fGet('EUCQUA');
  arrUnidades[1] := conf.fGet('EUCGAL');
  arrUnidades[2] := conf.fGet('EUCLAT');

  Result := '';
  for intCont := 0 to Length(arrUnidades) - 1 do
  begin
    Result := Result + Format(
      ' UNION                    ' +
      ' SELECT DISTINCT          ' +
      '   BASE                   ' +
      '   , SUBP                 ' +
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

procedure TProcessadorGravandoExecucaoEucatexBases.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'EUC_CADBAS';
end;

procedure TProcessadorGravandoExecucaoEucatexBases.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('BAS_DESCRI').AsString := Trim(AnsiUpperCase(qryOrigem.FieldByName('BASE').AsString));
  qryDestino.FieldByName('BAS_PRODUT').AsString := Trim(AnsiUpperCase(qryOrigem.FieldByName('SUBP').AsString));
  qryDestino.FieldByName('BAS_CODUNI').AsString := Trim(AnsiUpperCase(qryOrigem.FieldByName('CODUNI').AsString));
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EUC_CADBAS', VS_strCodEmp);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoEucatexBases.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_DESCRI;BAS_PRODUT;BAS_CODUNI',
    VarArrayOf([Trim(AnsiUpperCase(qryOrigem.FieldByName('BASE').AsString)),
      Trim(AnsiUpperCase(qryOrigem.FieldByName('SUBP').AsString)),
      Trim(AnsiUpperCase(qryOrigem.FieldByName('CODUNI').AsString))]), []);
end;

procedure TProcessadorGravandoExecucaoEucatexBases.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel cadastrar a base [%s - %s - %s], [%s - %s]',
    [Trim(AnsiUpperCase(qryOrigem.FieldByName('BASE').AsString)),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('SUBP').AsString)),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('CODUNI').AsString)), E.ClassName, E.Message]);
end;

end.
