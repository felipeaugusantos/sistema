unit untProcessadorGravandoExecucaoAdvanceTintoSystemColorantes;

interface

uses ADODB,Classes,DB, SysUtils,Variants,
  untIGravando,untAbstractAdoProcessadorGravandoExecucaoArquivos;

type
  TProcessadorGravandoExecucaoAdvanceTintoSystemColorantes = class (TAbstractAdoProcessadorGravandoExecucaoArquivos)
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override; 
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery;  override;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    procedure GetArquivosProcessar(const stlArquivos: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
  end;

implementation

uses untIDefinicaoTxt, untGenericDefinicaoTxt,
  untGenericDefinicaoTxtCampo, untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo,
  untDefinicaoTxtCampoTipo, untFuncTinta, untADOTxtFactory,
  untFuncoesSimples;

{ TProcessadorGravandoExecucaoAdvanceTintoSystemColorantes }

function TProcessadorGravandoExecucaoAdvanceTintoSystemColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemColorantes.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
var
  definicao: IDefinicaoTxt;
begin
  definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, True, ';', dtcsDefault, '.', '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
      TGenericDefinicaoTxtCampo.Create('IdCorante', dtctText),
      TGenericDefinicaoTxtCampo.Create('Codigo', dtctText),
      TGenericDefinicaoTxtCampo.Create('Descricao', dtctText),
      TGenericDefinicaoTxtCampo.Create('Embalagem', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Peso Especif', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Código Barra', dtctText),
      TGenericDefinicaoTxtCampo.Create('Data', dtctDate)
    ]));

  TADOTxtFactory.Registrar(definicao);
  strNomeArquivo := definicao.NomeArquivo;
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemColorantes.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := fGetConfTinta('ADT').fGet('PATADV') +  '\Corantes.csv';
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemColorantes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM ADT_CADCOL';
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemColorantes.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; 
begin
  Result := 'SELECT * FROM Corantes#csv';
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemColorantes.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'ADT_CADCOL';
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemColorantes.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ADT_CADCOL', VS_strCodEmp);
  qryDestino.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('COL_CODCOL').AsString := LimpaTexto(qryOrigem.FieldByName('Codigo').AsString);
  qryDestino.FieldByName('COL_DESCRI').AsString := LimpaTexto(qryOrigem.FieldByName('Descricao').AsString);
  qryDestino.FieldByName('COL_PESESP').AsFloat := qryOrigem.FieldByName('Peso Especif').AsFloat;
  qryDestino.FieldByName('COL_EMBALA').AsFloat := qryOrigem.FieldByName('Embalagem').AsFloat;
//  qryDestino.FieldByName('COL_CATALI').AsString := 'N';
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemColorantes.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', VarArrayOf([LimpaTexto(qryOrigem.FieldByName('Codigo').AsString)]), []);
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemColorantes.RegistrarImpossivelGravarRegistro(const E: Exception;
  const gravando: IGravando; const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível cadastrar o colorante [%s - %s - %.2f][%s: %s]',
    [LimpaTexto(qryOrigem.FieldByName('Codigo').AsString),
    LimpaTexto(qryOrigem.FieldByName('Descricao').AsString),
    qryOrigem.FieldByName('Embalagem').AsFloat,
    E.ClassName, E.Message]);
end;

end.
