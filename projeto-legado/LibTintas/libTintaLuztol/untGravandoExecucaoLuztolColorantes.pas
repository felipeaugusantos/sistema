{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Luztol *}
{***************************************************************************PH*}
unit untGravandoExecucaoLuztolColorantes;

interface

uses
  untAbstractGravandoExecucaoLuztol, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoLuztolColorantes = class(TAbstractGravandoExecucaoLuztol)
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


{ TGravandoExecucaoLuztolCores }


procedure TGravandoExecucaoLuztolColorantes.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: RawByteString;
  iRecordCount: Integer;
  intLinha: Integer;
  blnExcluir: Boolean;
begin
  Try
    Try
      blnExcluir := True;

      Gravando.Texto := 'Verificando Path do arquivo...';

      If Not fValidarPath() Then
      Begin
        Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath, '"', '')]);
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      If (blnExcluir) Then
      Begin
        Gravando.Texto := 'Deletando Registros da tabela LUZ_CADCOL...';
        IsDeletarRegistros();
      End;

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('LUZ_CADCOL');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Carregando Dados...';
      iRecordCount := fContaLinhas(fGetPath);
      intLinha := 1;
      qryDestino := GetDataSetDestino;
      stlCsv := TStringList.Create();
      stlCsv.StrictDelimiter := True;
      stlCsv.Delimiter := ';';

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
        stlCsv.DelimitedText := UTF8ToWideString(strLinha);

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

function TGravandoExecucaoLuztolColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoLuztolColorantes.fGetPath(): String;
begin
  Result := Conf.fGet('PATLUZ');
end;

function TGravandoExecucaoLuztolColorantes.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
Var
  Definicao: IDefinicaoTxt;
begin
  Definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, True, ';',
  dtcsDefault, '.', '.',
  TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
  TGenericDefinicaoTxtCampo.Create('id', dtctText),
  TGenericDefinicaoTxtCampo.Create('codigo', dtctText),
  TGenericDefinicaoTxtCampo.Create('descricao', dtctText),
  TGenericDefinicaoTxtCampo.Create('volume_embalagem_ml', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('peso_especifico', dtctDouble)]));

  TADOTxtFactory.Registrar(Definicao);
  strNomeArquivo := Definicao.NomeArquivo;
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

function TGravandoExecucaoLuztolColorantes.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM LUZ_CADCOL';
end;

function TGravandoExecucaoLuztolColorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoLuztolColorantes.GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList);
begin
  If Not qryDestino.Locate('COL_CODCOL', Trim(ArquivoText[7]), []) Then
  Begin
    qryDestino.Insert;
    qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LUZ_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
    qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryDestino.FieldByName('COL_CODCOL').AsString := Trim(ArquivoText[7]);
    qryDestino.FieldByName('COL_DESCRI').AsString := 'COLORANTE ' + Trim(ArquivoText[7]);
    qryDestino.FieldByName('COL_EMBALA').AsFloat  := 1000;
    qryDestino.Post;
  End;
end;

procedure TGravandoExecucaoLuztolColorantes.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM LUZ_CADCOL        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoLuztolColorantes.IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
begin
  If ArquivoText[0] = 'COLECAO' Then
  Begin
    Result := True;
    Exit;
  End;

  Result := False;
end;


end.

