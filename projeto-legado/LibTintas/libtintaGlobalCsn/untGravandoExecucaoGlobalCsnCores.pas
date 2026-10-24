{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta GlobalCsn *}
{**********************************************************************PH*}
unit untGravandoExecucaoGlobalCsnCores;

interface

uses
  untAbstractGravandoExecucaoGlobalCsn, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoGlobalCsnCores = class(TAbstractGravandoExecucaoGlobalCsn)
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
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


{ TGravandoExecucaoGlobalCsnCores }

procedure TGravandoExecucaoGlobalCsnCores.Executar(const gravando: IGravando);
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
    ListarArquivo(Conf.fGet('PATCSN') + '\' + stlPastas[intContador]);

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
            Gravando.Texto := 'Deletando Registros da tabela CSN_CADCSN...';
            IsDeletarRegistros();
            blnExcluir := False;
          End;

          Gravando.Texto := 'Path verificado com sucesso...';
          Gravando.Texto := 'Verificando PROCOD...';
          TAutcomTintaFactory.Get.fInsereProCod('CSN_CADCSN');
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


function TGravandoExecucaoGlobalCsnCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoGlobalCsnCores.fGetPath(intContador,
  intDiretorio: Integer): String;
begin
  Result := Conf.fGet('PATCSN') + '\' + stlPastas[intDiretorio] + '\' + stlArquivos[intContador];
end;

function TGravandoExecucaoGlobalCsnCores.fRetUnidade(fltVolume: Double): String;
begin
  If fltVolume <= 1.000 Then
    Result := 'LT'
  Else If (fltVolume <= 7.000) Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoGlobalCsnCores.GetAdoQuery(
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

function TGravandoExecucaoGlobalCsnCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM CSN_CADCSN    ';
end;

function TGravandoExecucaoGlobalCsnCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoGlobalCsnCores.GravarRegistro(
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
  strProduto := Copy(stlArquivos[intArquivo], Pos('_', stlArquivos[intArquivo]) + 1, Length(stlArquivos[intArquivo]));

  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CSN_CADCSN', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('CSN_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('CSN_CODIGO').AsString := ArquivoText[0];
  qryDestino.FieldByName('CSN_CODBAS').AsString := ArquivoText[1];
  qryDestino.FieldByName('CSN_DESCOR').AsString := ArquivoText[2];

  If TStrUtils.fEmptyStr(qryDestino.FieldByName('CSN_DESCOR').AsString) Then
    qryDestino.FieldByName('CSN_DESCOR').AsString := ArquivoText[0];

  qryDestino.FieldByName('CSN_PRODUT').AsString := Copy(stlArquivos[intArquivo], Pos('_', stlArquivos[intArquivo]) + 1, Length(strProduto) - 4);
  qryDestino.FieldByName('CSN_COLECA').AsString := stlPastas[intDiretorio];
  qryDestino.FieldByName('CSN_UNIDAD').AsString := fRetUnidade(StrToFloat(ArquivoText[3]));

  intColorante := 4;
  intQuantidade := 5;

  For intContador := 1 To 6 Do
  Begin

    If TStrUtils.fEmptyStr(ArquivoText[intColorante]) Then
      Break;

    strQtd := AnsiReplaceStr(ArquivoText[intQuantidade], '.', '');

    qryDestino.FieldByName('CSN_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := ArquivoText[intColorante];
    qryDestino.FieldByName('CSN_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := StrToFloat(strQtd);

    Inc(intColorante, 2);
    Inc(intQuantidade, 2);
  End;

  strMd5 := '';
  strMd5 := strMd5 + qryDestino.FieldByName('CSN_CODIGO').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('CSN_DESCOR').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('CSN_CODBAS').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('CSN_PRODUT').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('CSN_UNIDAD').AsString;
  strMd5 := strMd5 + qryDestino.FieldByName('CSN_COLECA').AsString;

  qryDestino.FieldByName('CSN_MD5KEY').AsString := GetMD5(strMd5);
  qryDestino.Post;
end;

procedure TGravandoExecucaoGlobalCsnCores.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM CSN_CADCSN       ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoGlobalCsnCores.IsRegistroExistente(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo,
  intDiretorio: Integer): Boolean;
begin
  Result := False;

  If ArquivoText[0] = 'Cod. cor' Then
    Result := True;
end;

end.
