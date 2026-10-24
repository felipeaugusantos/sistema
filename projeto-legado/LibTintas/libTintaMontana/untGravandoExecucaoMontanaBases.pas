{******************************************************************************}
{* Classe responsável pela geração do cadastro de Bases da tinta Montana *}
{***************************************************************************PH*}
unit untGravandoExecucaoMontanaBases;

interface

uses
  untAbstractGravandoExecucaoMontana, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoMontanaBases = class(TAbstractGravandoExecucaoMontana)
  Private
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

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoMontanaCores }

procedure TGravandoExecucaoMontanaBases.Executar(const gravando: IGravando);
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
          Gravando.Texto := 'Deletando Registros da tabela MON_CADBAS...';
          IsDeletarRegistros();
          blnExcluir := False;
        End;

        Gravando.Texto := 'Path verificado com sucesso...';
        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('MON_CADBAS');
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

function TGravandoExecucaoMontanaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoMontanaBases.fGetPath(intContador,
  intDiretorio: Integer): String;
begin
  Result := Conf.fGet('TXTMON') + '\' + stlArquivos[intContador];
end;

function TGravandoExecucaoMontanaBases.fRetUnidade(
  intEmbalagem: Double): String;
begin
  If intEmbalagem < 1500 Then
    Result := 'QT'
  Else If intEmbalagem < 5000 Then
    Result := 'GL'
  Else
    Result := 'BL';
end;

function TGravandoExecucaoMontanaBases.GetAdoQuery(
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

function TGravandoExecucaoMontanaBases.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM MON_CADBAS';
end;

function TGravandoExecucaoMontanaBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoMontanaBases.GravarRegistro(
  const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo,
  intDiretorio: Integer);
begin
  If Not qryDestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_UNIDAD;BAS_ACABAM', VarArrayOf([ArquivoText[6], ArquivoText[4],
    fRetUnidade(StrToFloat(ArquivoText[10])),  ArquivoText[8]]), []) Then
  Begin
    qryDestino.Insert;
    qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MON_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryDestino.FieldByName('BAS_CODBAS').AsString := ArquivoText[6];
    qryDestino.FieldByName('BAS_UNIDAD').AsString := fRetUnidade(StrToFloat(ArquivoText[10]));
    qryDestino.FieldByName('BAS_ACABAM').AsString := ArquivoText[8];
    qryDestino.FieldByName('BAS_PRODUT').AsString := ArquivoText[4];
    qryDestino.FieldByName('BAS_DESCRI').AsString := ArquivoText[5];
    qryDestino.Post;
  End;
end;

procedure TGravandoExecucaoMontanaBases.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM MON_CADBAS        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoMontanaBases.IsRegistroExistente(
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

