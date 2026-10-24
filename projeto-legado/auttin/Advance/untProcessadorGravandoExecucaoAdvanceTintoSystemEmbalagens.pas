unit untProcessadorGravandoExecucaoAdvanceTintoSystemEmbalagens;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, ADODB, Classes, DB, SysUtils,
  untIGravando,Variants,
  Uni;

type
  TProcessadorGravandoExecucaoAdvanceTintoSystemEmbalagens = class (TAbstractAdoProcessadorGravandoExecucaoArquivos)
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
uses untFuncoesSimples, untFuncTinta,untDefinicaoTxtCampoTipo, untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo, untIDefinicaoTxt,untADOTxtFactory, untGenericDefinicaoTxt,untGenericDefinicaoTxtCampo;
{ TProcessadorGravandoExecucaoAdvanceTintoSystemEmbalagens }

function TProcessadorGravandoExecucaoAdvanceTintoSystemEmbalagens.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagens';
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemEmbalagens.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
var
  definicao: IDefinicaoTxt;
begin
  definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, True, ';', dtcsDefault, '.', '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
      TGenericDefinicaoTxtCampo.Create('IdProdBas', dtctText),
      TGenericDefinicaoTxtCampo.Create('Embalagem', dtctText),
      TGenericDefinicaoTxtCampo.Create('Conteudo', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('IdEmb', dtctText),
      TGenericDefinicaoTxtCampo.Create('Produto', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdProduto', dtctText),
      TGenericDefinicaoTxtCampo.Create('Base', dtctText),
      TGenericDefinicaoTxtCampo.Create('Cod Base', dtctText),
      TGenericDefinicaoTxtCampo.Create('Id_Base', dtctText),
      TGenericDefinicaoTxtCampo.Create('Peso Especif', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Código Barra', dtctText),
      TGenericDefinicaoTxtCampo.Create('Data', dtctDate)
    ]));

  TADOTxtFactory.Registrar(definicao);
  strNomeArquivo := definicao.NomeArquivo;
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemEmbalagens.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := fGetConfTinta('ADT').fGet('PATADV') +  '\Bases.csv';
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemEmbalagens.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM ADT_CADEMB';
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemEmbalagens.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; 
begin
  Result := 'SELECT DISTINCT IDEMB, EMBALAGEM FROM Bases#csv';
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemEmbalagens.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'ADT_CADEMB';
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemEmbalagens.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ADT_CADEMB', VS_strCodEmp);
  qryDestino.FieldByName('EMB_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('EMB_CODEMB').AsString := fStrZero(LimpaTexto(qryOrigem.FieldByName('IDEMB').AsString), 3);
  qryDestino.FieldByName('EMB_DESCRI').AsString := LimpaTexto(qryOrigem.FieldByName('EMBALAGEM').AsString);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemEmbalagens.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('EMB_CODEMB', VarArrayOf([fStrZero(LimpaTexto(qryOrigem.FieldByName('IDEMB').AsString), 3)]), [])
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemEmbalagens.RegistrarImpossivelGravarRegistro(const E: Exception;
  const gravando: IGravando; const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível cadastrar a embalagem [%s - %s][%s: %s]',
    [fStrZero(LimpaTexto(qryOrigem.FieldByName('IDEMB').AsString), 3),
     LimpaTexto(qryOrigem.FieldByName('EMBALAGEM').AsString),
     E.ClassName, E.Message]);
end;

end.
