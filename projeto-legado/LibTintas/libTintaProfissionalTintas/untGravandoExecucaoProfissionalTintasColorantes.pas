{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta ProfissionalTintas *}
{***************************************************************************PH*}
unit untGravandoExecucaoProfissionalTintasColorantes;

interface

uses
  untAbstractGravandoExecucaoProfissionalTintas, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoProfissionalTintasColorantes = class(TAbstractGravandoExecucaoProfissionalTintas)
  Private
    procedure IsDeletarRegistros();
    function fDescColorantesMaisClaro(strCodigo: String): String;
    function fDescColorantesMaisEscuro(strCodigo: String): String;
    function fDescColorante(strCodigo: String): String;
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


{ TGravandoExecucaoProfissionalTintasCores }


procedure TGravandoExecucaoProfissionalTintasColorantes.Executar(const gravando: IGravando);
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
        Gravando.Texto := 'Deletando Registros da tabela PRT_CADCOL...';
        IsDeletarRegistros();
      End;

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('PRT_CADCOL');
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

function TGravandoExecucaoProfissionalTintasColorantes.fDescColorante(
  strCodigo: String): String;
begin
  Result := fDescColorantesMaisClaro(strCodigo);
end;

function TGravandoExecucaoProfissionalTintasColorantes.fDescColorantesMaisClaro(
  strCodigo: String): String;
begin
  If strCodigo = '2' Then
    Result := 'BRANCO'
  Else If strCodigo = '4' Then
    Result := 'AMARELO ÓXIDO'
  Else If strCodigo = '9' Then
    Result := 'AMARELO LIMÃO'
  Else If strCodigo = '25' Then
    Result := 'AMARELO CHROMO'
  Else If strCodigo = '23' Then
    Result := 'VERDE'
  Else If strCodigo = '35' Then
    Result := 'LARANJA'
  Else
    Result := fDescColorantesMaisEscuro(strCodigo);
end;

function TGravandoExecucaoProfissionalTintasColorantes.fDescColorantesMaisEscuro(
  strCodigo: String): String;
begin
  Result := '';

  If strCodigo = '5' Then
    Result := 'PRETO'
  Else If strCodigo = '1' Then
    Result := 'VERMELHO ÓXIDO'
  Else If strCodigo = '45' Then
    Result := 'VERMELHO VIVO'
  Else If strCodigo = '46' Then
    Result := 'VERMELHO ESCURO'
  Else If strCodigo = '48' Then
    Result := 'AZUL'
  Else If strCodigo = '42' Then
    Result := 'VIOLETA';
end;

function TGravandoExecucaoProfissionalTintasColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoProfissionalTintasColorantes.fGetPath(): String;
begin
  Result := Conf.fGet('PATPRT');
end;

function TGravandoExecucaoProfissionalTintasColorantes.GetAdoQuery(
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

function TGravandoExecucaoProfissionalTintasColorantes.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM PRT_CADCOL';
end;

function TGravandoExecucaoProfissionalTintasColorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoProfissionalTintasColorantes.GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList);
begin
  If Not qryDestino.Locate('COL_CODCOL', Trim(ArquivoText[7]), []) Then
  Begin
    qryDestino.Insert;
    qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PRT_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
    qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryDestino.FieldByName('COL_CODCOL').AsString := Trim(ArquivoText[7]);
    qryDestino.FieldByName('COL_DESCRI').AsString := fDescColorante(Trim(ArquivoText[7]));
    qryDestino.FieldByName('COL_EMBALA').AsFloat  := 900;
    qryDestino.Post;
  End;
end;

procedure TGravandoExecucaoProfissionalTintasColorantes.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM PRT_CADCOL        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoProfissionalTintasColorantes.IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
begin
  If ArquivoText[0] = 'LINHA' Then
  Begin
    Result := True;
    Exit;
  End;

  Result := False;
end;


end.

