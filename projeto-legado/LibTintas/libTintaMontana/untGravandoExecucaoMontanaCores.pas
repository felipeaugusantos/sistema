{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Montana *}
{**********************************************************************PH*}
unit untGravandoExecucaoMontanaCores;

interface

uses
  untAbstractGravandoExecucaoMontana, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoMontanaCores = class(TAbstractGravandoExecucaoMontana)
  Private
    intCodSeq: Integer;
    //function fRetornaColorante(strId: String): String;
    function fRetUnidade(intEmbalagem: Double): String;
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

{ TGravandoExecucaoMontanaCores }

procedure TGravandoExecucaoMontanaCores.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: RawByteString;
  iRecordCount: Integer;
  intLinha: Integer;
  intArquivo: Integer;
  blnExcluir: Boolean;
begin
  blnExcluir := True;
  ListarArquivo(Conf.fGet('TXTMON'));
  intCodSeq := 1;

  For intArquivo := 0 To stlArquivos.Count - 1 Do
  Begin
    Try
      Try
        Gravando.Texto := 'Verificando Path do arquivo...';

        If Not fValidarPath(intArquivo, 1) Then
        Begin
          Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath(intArquivo, 1), '"', '')]);
          Exit;
        End;

        If (Gravando.Status <> sgGravando) Then
          Break;

        If (blnExcluir) Then
        Begin
          Gravando.Texto := 'Deletando Registros da tabela MON_CADMON...';
          IsDeletarRegistros();
          blnExcluir := False;
        End;

        Gravando.Texto := 'Path verificado com sucesso...';
        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('MON_CADMON');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        Gravando.Texto := 'Carregando Dados...';
        iRecordCount := fContaLinhas(fGetPath(intArquivo , 1));
        intLinha := 1;
        qryDestino := GetDataSetDestino;
        stlCsv := TStringList.Create();
        stlCsv.StrictDelimiter := True;
        stlCsv.Delimiter := ';';

        AssignFile(Arquivo, fGetPath(intArquivo, 1));
        Reset(Arquivo);

        If (Gravando.Status <> sgGravando) Then
          Break;

        Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath(intArquivo, 1), '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);

        While Not Eof(Arquivo) Do
        Begin
          If (Gravando.Status <> sgGravando) Then
            Break;

          ReadLn(Arquivo, strLinha);
          stlCsv.DelimitedText := UTF8ToWideString(strLinha);

          If Not IsRegistroExistente(qryDestino, stlCsv, intArquivo, 1) Then
            GravarRegistro(qryDestino, stlCsv, intArquivo, 1);

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
end;

function TGravandoExecucaoMontanaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoMontanaCores.fGetPath(intContador,
  intDiretorio: Integer): String;
begin
  Result := Conf.fGet('TXTMON') + '\' + stlArquivos[intContador];
end;

{function TGravandoExecucaoMontanaCores.fRetornaColorante(strId: String): String;
Var
  stlCsv: TStringList;
  intLinha: Integer;
  Arquivo: TextFile;
  strLinha: RawByteString;
begin
  Try
    Result := '';

    stlCsv := TStringList.Create();
    stlCsv.StrictDelimiter := True;
    stlCsv.Delimiter := ';';

    AssignFile(Arquivo, Conf.fGet('TXTMON') + '\DadosComponentes.csv');
    Reset(Arquivo);

    While Not Eof(Arquivo) Do
    Begin
      ReadLn(Arquivo, strLinha);
      stlCsv.DelimitedText := UTF8ToWideString(strLinha);

      If strId = stlCsv[0] Then
      Begin
        Result := stlCsv[1];
        Break;
      End;

      Inc(intLinha);
    End;
  Finally
    FreeAndNil(stlCsv);
    CloseFile(Arquivo);
  End;
end; }

function TGravandoExecucaoMontanaCores.fRetUnidade(
  intEmbalagem: Double): String;
begin
  If intEmbalagem < 1500 Then
    Result := 'QT'
  Else If intEmbalagem < 5000 Then
    Result := 'GL'
  Else
    Result := 'BL';
end;

function TGravandoExecucaoMontanaCores.GetAdoQuery(
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
  TGenericDefinicaoTxtCampo.Create('corante1', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante2', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante3', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante4', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante5', dtctText),
  TGenericDefinicaoTxtCampo.Create('corante6', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente7_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente8_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente9_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente10_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente11_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente12_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente13_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente14_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('componente15_id', dtctText),
  TGenericDefinicaoTxtCampo.Create('qtd1gr', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('qtd2gr', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('qtd3gr', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('qtd4gr', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('qtd5gr', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('qtd6gr', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('qtd1gr', dtctDouble),
  TGenericDefinicaoTxtCampo.Create('data_geracao', dtctDate)]));

  TADOTxtFactory.Registrar(Definicao);
  strNomeArquivo := Definicao.NomeArquivo;
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

function TGravandoExecucaoMontanaCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM MON_CADMON';
end;

function TGravandoExecucaoMontanaCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoMontanaCores.GravarRegistro(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo,
  intDiretorio: Integer);
Var
  intQtd: Integer;
  intFormula,
  intQuantidade: Integer;
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('MON_CADMON', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('MON_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('MON_DTACAD').AsDate    := Date;
  qryDestino.FieldByName('MON_CODSEQ').AsInteger := intCodSeq;
  qryDestino.FieldByName('MON_DESCOR').AsString  := ArquivoText[0];
  qryDestino.FieldByName('MON_PRODUT').AsString  := ArquivoText[4];
  qryDestino.FieldByName('MON_CODBAS').AsString  := ArquivoText[6];
  qryDestino.FieldByName('MON_DESCRI').AsString  := ArquivoText[8];
  qryDestino.FieldByName('MON_ACABAM').AsString  := ArquivoText[8];
  qryDestino.FieldByName('MON_QTDEMB').AsFloat   := StrToFloat(ArquivoText[10]);
  qryDestino.FieldByName('MON_UNIDAD').AsString  := fRetUnidade(StrToFloat(ArquivoText[10]));
  qryDestino.FieldByName('MON_MD5KEY').AsString  := GetMD5(qryDestino.FieldByName('MON_CODSEQ').AsString +
                                                           qryDestino.FieldByName('MON_CODBAS').AsString +
                                                           qryDestino.FieldByName('MON_ACABAM').AsString +
                                                           qryDestino.FieldByName('MON_DESCRI').AsString +
                                                           qryDestino.FieldByName('MON_DESCOR').AsString +
                                                           qryDestino.FieldByName('MON_PRODUT').AsString +
                                                           qryDestino.FieldByName('MON_UNIDAD').AsString);

  intFormula := 12;
  intQuantidade := 26;

  For intQtd := 1 To 12 Do
  Begin
    If TStrUtils.fEmptyStr(ArquivoText[intFormula]) Then
      Break;

    qryDestino.FieldByName('MON_FORM' + TStrUtils.fStrZero(intQtd, 2)).AsString := ArquivoText[intFormula];
    qryDestino.FieldByName('MON_QTDC' + TStrUtils.fStrZero(intQtd, 2)).AsFloat  := StrToFloat(ArquivoText[intQuantidade]);

    Inc(intFormula);
    Inc(intQuantidade);
  End;

  qryDestino.Post;
  Inc(intCodSeq);
end;

procedure TGravandoExecucaoMontanaCores.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM MON_CADMON        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoMontanaCores.IsRegistroExistente(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo,
  intDiretorio: Integer): Boolean;
begin
  If ArquivoText[0] = 'codigo_cor' Then
  Begin
    Result := True;
    Exit;
  End;

  Result := False;
end;

end.
