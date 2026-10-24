{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Dacasa *}
{**********************************************************************PH*}
unit untGravandoExecucaoDacasaCores;

interface

uses
  untAbstractGravandoExecucaoDacasa, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  System.Win.ComObj;

type
  TGravandoExecucaoDacasaCores = class(TAbstractGravandoExecucaoDacasa)
  Private
    qryColorantes: IDataSet;
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


{ TGravandoExecucaoDacasaCores }

procedure TGravandoExecucaoDacasaCores.Executar(const gravando: IGravando);
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

          qryColorantes := TAutcomTintaFactory.Get.fGetDataSet;
          qryColorantes.SQL := '  SELECT * FROM DCA_CADCOL  ';
          qryColorantes.Open;

          If qryColorantes.IsEmpty Then
          Begin
            Gravando.Texto := 'Verifica o cadastro de Colorantes (DCA_CADCOL), pois está vazio...';
            Exit;
          End;

          If (blnExcluir) Then
          Begin
            Gravando.Texto := 'Deletando Registros da tabela DCA_CADDCA...';
            IsDeletarRegistros();
            blnExcluir := False;
          End;

          Gravando.Texto := 'Path verificado com sucesso...';
          Gravando.Texto := 'Verificando PROCOD...';
          TAutcomTintaFactory.Get.fInsereProCod('DCA_CADDCA');
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

function TGravandoExecucaoDacasaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoDacasaCores.fGetPath(intContador,
  intDiretorio: Integer): String;
begin
  Result := Conf.fGet('PATDCA') + '\' + stlPastas[intDiretorio] + '\' + stlArquivos[intContador];
end;


function TGravandoExecucaoDacasaCores.fRetUnidade(fltVolume: Double): String;
begin
  If fltVolume <= 1.000 Then
    Result := 'LT'
  Else If (fltVolume <= 8.000) Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoDacasaCores.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
Var
  Definicao: IDefinicaoTxt;
begin
  Definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, True, ';',
  dtcsDefault, '.', '.',
  TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
  TGenericDefinicaoTxtCampo.Create('id_formula', dtctText),
  TGenericDefinicaoTxtCampo.Create('codigo_cor', dtctText),
  TGenericDefinicaoTxtCampo.Create('codigo_tecnico', dtctText),
  TGenericDefinicaoTxtCampo.Create('id_produto', dtctText),
  TGenericDefinicaoTxtCampo.Create('descricao_produto', dtctText),
  TGenericDefinicaoTxtCampo.Create('id_base', dtctText),
  TGenericDefinicaoTxtCampo.Create('descricao_base', dtctText),
  TGenericDefinicaoTxtCampo.Create('id_componente_b', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente_b', dtctText),
  TGenericDefinicaoTxtCampo.Create('id_embalagem', dtctText),
  TGenericDefinicaoTxtCampo.Create('descricao_embalagem', dtctText),
  TGenericDefinicaoTxtCampo.Create('capacidade_embalagem_ml', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente1_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente2_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente3_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente4_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente5_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente6_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente7_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente8_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente9_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente10_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente11_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente12_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente13_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente14_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente15_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente1_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente2_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente3_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente4_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente5_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente6_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente7_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente8_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente9_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente10_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente11_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente12_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente13_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente14_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('componente15_gramas', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('data_atualizada', dtctDate)]));

  TADOTxtFactory.Registrar(Definicao);
  strNomeArquivo := Definicao.NomeArquivo;
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

function TGravandoExecucaoDacasaCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM DCA_CADDCA';
end;

function TGravandoExecucaoDacasaCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoDacasaCores.GravarRegistro(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo,
  intDiretorio: Integer);
Var
  strColecao: String;
  intColorante: Integer;
  intQuantidade: Integer;
  intQtdCol: Integer;
  strProduto: String;
begin
  strColecao := stlPastas[intDiretorio];
  strProduto := Copy(stlArquivos[intArquivo], Pos('_', stlArquivos[intArquivo]) + 1, Length(stlArquivos[intArquivo]));
  strProduto := AnsiReplaceStr(strProduto, '.CSV', '');

  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DCA_CADDCA', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('DCA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('DCA_CODIGO').AsString := LimpaTexto(ArquivoText[0]);
  qryDestino.FieldByName('DCA_NOMCOR').AsString := LimpaTexto(ArquivoText[2]);
  qryDestino.FieldByName('DCA_CODBAS').AsString := ArquivoText[1];
  qryDestino.FieldByName('DCA_UNIDAD').AsString := fRetUnidade(StrToFloat(ArquivoText[3]));
  qryDestino.FieldByName('DCA_PRODUT').AsString := LimpaTexto(strProduto);
  qryDestino.FieldByName('DCA_COLECA').AsString := strColecao;

  intColorante := 4;
  intQuantidade := 5;

  For intQtdCol := 1 To 6 Do
  Begin
    If TStrUtils.fEmptyStr(ArquivoText[intColorante]) Then
        Break;


    qryDestino.FieldByName('DCA_FORM' + TStrUtils.fStrZero(intQtdCol, 2)).AsString := Trim(ArquivoText[intColorante]);
    qryDestino.FieldByName('DCA_QTDC' + TStrUtils.fStrZero(intQtdCol, 2)).AsFloat  := StrToFloat(ArquivoText[intQuantidade]);

    Inc(intQuantidade, 2);
    Inc(intColorante, 2);
  End;

  qryDestino.FieldByName('DCA_MD5KEY').AsString := GetMD5(qryDestino.FieldByName('DCA_CODIGO').AsString +
                                                          qryDestino.FieldByName('DCA_NOMCOR').AsString +
                                                          qryDestino.FieldByName('DCA_CODBAS').AsString +
                                                          qryDestino.FieldByName('DCA_UNIDAD').AsString +
                                                          qryDestino.FieldByName('DCA_PRODUT').AsString +
                                                          qryDestino.FieldByName('DCA_COLECA').AsString);

  qryDestino.Post;
end;

procedure TGravandoExecucaoDacasaCores.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM DCA_CADDCA        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoDacasaCores.IsRegistroExistente(
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

end.

