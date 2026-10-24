{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Dacasa *}
{***************************************************************************PH*}
unit untGravandoExecucaoDacasaColorantes;

interface

uses
  untAbstractGravandoExecucaoDacasa, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoDacasaColorantes = class(TAbstractGravandoExecucaoDacasa)
  Private
    procedure IsDeletarRegistros();
  public
    procedure ListarArquivo(strDiretorio: String); Override;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function fGetPath(intContador: Integer; intDiretorio: Integer): String; override;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList;  intArquivo: Integer; intDiretorio: Integer): Boolean; override;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList;  intArquivo: Integer; intDiretorio: Integer); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;


{ TGravandoExecucaoDacasaCores }


procedure TGravandoExecucaoDacasaColorantes.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  intContador: Integer;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: RawByteString;
  iRecordCount: Integer;
  intLinha: Integer;
  intArquivo: Integer;
  blnExcluir: Boolean;
begin
  blnExcluir := True;

  For intContador := 0 To stlPastas.Count - 1 Do
  Begin
    ListarArquivo(Conf.fGet('PATDCA') + '\' + stlPastas[intContador]);

    For intArquivo := 0 To stlArquivos.Count - 1 Do
    Begin
      Try
        Try
          Gravando.Texto := 'Verificando Path do arquivo...';

          If Not fValidarPath(intArquivo, intContador) Then
          Begin
            Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath(intArquivo, intContador), '"', '')]);
            Exit;
          End;

          If (Gravando.Status <> sgGravando) Then
            Break;

          If (blnExcluir) Then
          Begin
            Gravando.Texto := 'Deletando Registros da tabela DCA_CADCOL...';
            IsDeletarRegistros();
            blnExcluir := False;
          End;

          Gravando.Texto := 'Path verificado com sucesso...';
          Gravando.Texto := 'Verificando PROCOD...';
          TAutcomTintaFactory.Get.fInsereProCod('DCA_CADCOL');
          Gravando.Texto := 'PROCOD verificado com sucesso...';

          Gravando.Texto := 'Carregando Dados...';
          iRecordCount := fContaLinhas(fGetPath(intArquivo ,intContador));
          intLinha := 1;
          qryDestino := GetDataSetDestino;
          stlCsv := TStringList.Create();
          stlCsv.StrictDelimiter := True;
          stlCsv.Delimiter := ';';

          AssignFile(Arquivo, fGetPath(intArquivo, intContador));
          Reset(Arquivo);

          If (Gravando.Status <> sgGravando) Then
            Break;

          Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath(intArquivo, intContador), '"', '')]);
          Gravando.RegistrarProgresso(0, 0, 0);

          While Not Eof(Arquivo) Do
          Begin
            If (Gravando.Status <> sgGravando) Then
              Break;

            ReadLn(Arquivo, strLinha);
            stlCsv.DelimitedText := UTF8ToWideString(strLinha);

            If Not IsRegistroExistente(qryDestino, stlCsv, intArquivo, intContador) Then
              GravarRegistro(qryDestino, stlCsv, intArquivo, intContador);

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
    End;

  End;
end;

function TGravandoExecucaoDacasaColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoDacasaColorantes.fGetPath(intContador,
  intDiretorio: Integer): String;
begin
  Result := Conf.fGet('PATDCA') + '\' + stlPastas[intDiretorio] + '\' + stlArquivos[intContador];
end;

function TGravandoExecucaoDacasaColorantes.GetAdoQuery(
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

function TGravandoExecucaoDacasaColorantes.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM DCA_CADCOL';
end;

function TGravandoExecucaoDacasaColorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoDacasaColorantes.GravarRegistro(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo,
  intDiretorio: Integer);
Var
  intContador: Integer;
  intColorante: Integer;
begin
  intColorante := 4;

  For intContador := 1 To 6 Do
  Begin
    If TStrUtils.fEmptyStr(ArquivoText[intColorante]) Then
        Break;

    If Not qryDestino.Locate('COL_CODCOL', Trim(ArquivoText[intColorante]), []) Then
    Begin

      qryDestino.Insert;
      qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DCA_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
      qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryDestino.FieldByName('COL_CODCOL').AsString := Trim(ArquivoText[intColorante]);
      qryDestino.FieldByName('COL_DESCRI').AsString := 'COLORANTE ' + Trim(ArquivoText[intColorante]);
      qryDestino.FieldByName('COL_EMBALA').AsFloat  := 900;
      qryDestino.Post;
    End;
    Inc(intColorante, 2);
  End;
end;

procedure TGravandoExecucaoDacasaColorantes.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM DCA_CADCOL        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoDacasaColorantes.IsRegistroExistente(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo,
  intDiretorio: Integer): Boolean;
begin
  If ArquivoText[0] = 'Cod. cor' Then
  Begin
    Result := True;
    Exit;
  End;

  Result := False;
end;

procedure TGravandoExecucaoDacasaColorantes.ListarArquivo(
  strDiretorio: String);
Var
  Pesquisa: TSearchRec;
  intContador: Integer;
  TempNome: String;
begin
  stlArquivos.Clear;
  intContador := FindFirst(strDiretorio + '\*.CSV', faAnyFile, Pesquisa);

  Try
    While intContador = 0 Do
    Begin
      If TemAtributo(Pesquisa.Attr, faDirectory) Then
      Begin
        If (Pesquisa.Name <> '.') Then
        Begin
          If (Pesquisa.Name <> '..') Then
          Begin
            TempNome := strDiretorio + '\' + Pesquisa.Name;
            ListarArquivo(TempNome);
          End;
        End;
      End
      Else
      Begin
        stlArquivos.Add(Pesquisa.Name);
      End;

      intContador := FindNext(Pesquisa);
    End;
  Finally
    SysUtils.FindClose(Pesquisa);
  End;
end;

end.

