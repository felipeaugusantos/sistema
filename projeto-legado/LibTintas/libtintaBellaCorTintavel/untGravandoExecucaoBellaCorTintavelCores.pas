{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta BellaCorTintavel *}
{**********************************************************************PH*}
unit untGravandoExecucaoBellaCorTintavelCores;

interface

uses
  untAbstractGravandoExecucaoBellaCorTintavel, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, untFloatUtils;

type
  TGravandoExecucaoBellaCorTintavelCores = class(TAbstractGravandoExecucaoBellaCorTintavel)
  Private
    function fRetUnidade(fltVolume: Double): String;
    procedure IsDeletarRegistros();
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function fGetPath(intContador: Integer; intDiretorio: Integer): String; override;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList;  intArquivo: Integer; intDiretorio: Integer): Boolean; override;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList;  intArquivo: Integer; intDiretorio: Integer); override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;



{ TGravandoExecucaoBellaCorTintavelCores }

procedure TGravandoExecucaoBellaCorTintavelCores.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  intContador: Integer;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: String;
  iRecordCount: Integer;
  intLinha: Integer;
  intArquivo: Integer;
  blnExcluir: Boolean;
begin
  blnExcluir := True;

  For intContador := 0 To stlPastas.Count - 1 Do
  Begin
    ListarArquivo(Conf.fGet('PATBLT') + '\' + stlPastas[intContador]);

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
            Gravando.Texto := 'Deletando Registros da tabela BLT_CADBLT...';
            IsDeletarRegistros();
            blnExcluir := False;
          End;

          Gravando.Texto := 'Path verificado com sucesso...';
          Gravando.Texto := 'Verificando PROCOD...';
          TAutcomTintaFactory.Get.fInsereProCod('BLT_CADBLT');
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
            stlCsv.DelimitedText := strLinha;

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


function TGravandoExecucaoBellaCorTintavelCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoBellaCorTintavelCores.fGetPath(intContador,
  intDiretorio: Integer): String;
begin
  Result := Conf.fGet('PATBLT') + '\' + stlPastas[intDiretorio] + '\' + stlArquivos[intContador];
end;

function TGravandoExecucaoBellaCorTintavelCores.fRetUnidade(
  fltVolume: Double): String;
begin
  If fltVolume <= 1.000 Then
    Result := 'LT'
  Else If (fltVolume <= 7.000) Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoBellaCorTintavelCores.GetAdoQuery(
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

function TGravandoExecucaoBellaCorTintavelCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM BLT_CADBLT    ';
end;

function TGravandoExecucaoBellaCorTintavelCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoBellaCorTintavelCores.GravarRegistro(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo,
  intDiretorio: Integer);
Var
  intContador: Integer;
  strMd5: String;
  strQtd: String;
  intColorante: Integer;
  intQuantidade: Integer;
  strProduto: String;
begin
  strProduto := stlArquivos[intArquivo];

  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BLT_CADBLT', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BLT_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BLT_CODIGO').AsString := ArquivoText[0];
  qryDestino.FieldByName('BLT_CODBAS').AsString := ArquivoText[1];
  qryDestino.FieldByName('BLT_DESCOR').AsString := ArquivoText[2];
  qryDestino.FieldByName('BLT_PRODUT').AsString := Copy(strProduto, 0, Length(strProduto) - 4);
  qryDestino.FieldByName('BLT_COLECA').AsString := stlPastas[intDiretorio];
  qryDestino.FieldByName('BLT_UNIDAD').AsString := fRetUnidade(StrToFloat(ArquivoText[3]));

  intColorante := 4;
  intQuantidade := 5;

  For intContador := 1 To 6 Do
  Begin
    If TStrUtils.fEmptyStr(ArquivoText[intColorante]) Then
      Break;

    strQtd := AnsiReplaceStr(ArquivoText[intQuantidade], '.', '');

    qryDestino.FieldByName('BLT_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := ArquivoText[intColorante];
    qryDestino.FieldByName('BLT_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := StrToFloat(strQtd);

    Inc(intColorante, 2);
    Inc(intQuantidade, 2);
  End;

  strMd5 := '';
  strMd5 := strMd5 + qryDestino.FieldByName('BLT_CODIGO').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('BLT_DESCOR').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('BLT_CODBAS').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('BLT_PRODUT').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('BLT_UNIDAD').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('BLT_COLECA').AsString;

  qryDestino.FieldByName('BLT_MD5KEY').AsString := GetMD5(strMd5);
  qryDestino.Post;
end;

procedure TGravandoExecucaoBellaCorTintavelCores.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM BLT_CADBLT        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoBellaCorTintavelCores.IsRegistroExistente(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo,
  intDiretorio: Integer): Boolean;
begin
  Result := False;

  If ArquivoText[0] = 'Cod. cor' Then
    Result := True;
end;

end.

