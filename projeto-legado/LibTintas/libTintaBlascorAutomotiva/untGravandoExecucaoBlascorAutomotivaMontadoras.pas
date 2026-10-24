{**********************************************************************************}
{* Classe responsável pela geração do cadastro de Montadoras da tinta BlascorAutomotiva *}
{*******************************************************************************AC*}
unit untGravandoExecucaoBlascorAutomotivaMontadoras;

interface

uses
  untAbstractGravandoExecucaoBlascorAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoBlascorAutomotivaMontadoras = class(TAbstractGravandoExecucaoBlascorAutomotiva)
  Private
    procedure IsDeletarRegistros();
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function fGetPath(): String; override;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean; override;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoBlascorAutomotivaMontadoras }

procedure TGravandoExecucaoBlascorAutomotivaMontadoras.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: String;
  iRecordCount: Integer;
  intLinha: Integer;
begin
  Try
    Try
      Gravando.Texto := 'Verificando Path do arquivo...';

      If Not fValidarPath Then
      Begin
        Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath, '"', '')]);
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Deletando Registros da tabela BLA_CADMON...';
      IsDeletarRegistros();

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BLA_CADMON');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Carregando Dados...';
      iRecordCount := fContaLinhas(fGetPath);
      intLinha := 1;
      qryDestino := GetDataSetDestino;
      stlCsv := TStringList.Create();
      stlCsv.StrictDelimiter := True;
      stlCsv.Delimiter := ',';

      AssignFile(Arquivo, fGetPath);
      Reset(Arquivo);

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      While Not Eof(Arquivo) Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        ReadLn(Arquivo, strLinha);
        stlCsv.DelimitedText := strLinha;

        If Not IsRegistroExistente(qryDestino, stlCsv) Then
          GravarRegistro(qryDestino, stlCsv);

        Inc(intLinha);
        Gravando.RegistrarProgresso(0, intLinha, iRecordCount);
      End;
    Except
      On E: Exception Do
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
    If Assigned(stlCsv) Then FreeAndNil(stlCsv);
    CloseFile(Arquivo);
  End;
end;

function TGravandoExecucaoBlascorAutomotivaMontadoras.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Montadoras';
end;


function TGravandoExecucaoBlascorAutomotivaMontadoras.fGetPath(): String;
begin
  Result := Conf.fGet('PATBLA');
end;

function TGravandoExecucaoBlascorAutomotivaMontadoras.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
Var
  Definicao: IDefinicaoTxt;
begin
  Definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, True, ';',
  dtcsDefault, '.', '.',
  TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
  TGenericDefinicaoTxtCampo.Create('Cod. cor', dtctText),
  TGenericDefinicaoTxtCampo.Create('Desc. base', dtctText),
  TGenericDefinicaoTxtCampo.Create('Desc. cor', dtctText),
  TGenericDefinicaoTxtCampo.Create('Vol. (L)', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Corante 1', dtctText),
  TGenericDefinicaoTxtCampo.Create('Corante 2', dtctText),
  TGenericDefinicaoTxtCampo.Create('Corante 3', dtctText),
  TGenericDefinicaoTxtCampo.Create('Corante 4', dtctText),
  TGenericDefinicaoTxtCampo.Create('Corante 5', dtctText),
  TGenericDefinicaoTxtCampo.Create('Corante 6', dtctText),
  TGenericDefinicaoTxtCampo.Create('Qtd ml 1', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd ml 2', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd ml 3', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd ml 4', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd ml 5', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('Qtd ml 6', dtctDouble)]));

  TADOTxtFactory.Registrar(Definicao);
  strNomeArquivo := Definicao.NomeArquivo;
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

function TGravandoExecucaoBlascorAutomotivaMontadoras.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM BLA_CADMON';
end;

function TGravandoExecucaoBlascorAutomotivaMontadoras.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoBlascorAutomotivaMontadoras.GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BLA_CADMON', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('MON_CODMON').AsString := LimpaTexto(ArquivoText[10]);
  qryDestino.FieldByName('MON_DESCRI').AsString := LimpaTexto(ArquivoText[11]);
  qryDestino.Post;
end;

procedure TGravandoExecucaoBlascorAutomotivaMontadoras.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM BLA_CADMON        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoBlascorAutomotivaMontadoras.IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
begin
  If ArquivoText[0] = 'codInterno' Then
  Begin
    Result := True;
    Exit;
  End;

  Result := qryDestino.Locate('MON_CODMON', LimpaTexto(ArquivoText[10]), []);
end;

end.
