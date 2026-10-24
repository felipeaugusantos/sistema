{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta MaxVinil *}
{**********************************************************************PH*}
unit untGravandoExecucaoMaxVinilCores;

interface

uses
  untAbstractGravandoExecucaoMaxVinil, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  System.Win.ComObj;

type
  TGravandoExecucaoMaxVinilCores = class(TAbstractGravandoExecucaoMaxVinil)
  Private
    intColorante: Integer;
    function fRetUnidade(fltVolume: Double): String;
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

Implementation

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


{ TGravandoExecucaoMaxVinilCores }

procedure TGravandoExecucaoMaxVinilCores.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: String;
  iRecordCount: Integer;
  intLinha: Integer;
  blnExcluir: Boolean;
begin
  Try
    Try
      blnExcluir := True;
      intColorante := 1;

      Gravando.Texto := 'Verificando Path do arquivo...';

      If Not fValidarPath() Then
      Begin
        Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath(), '"', '')]);
        Exit;
      End;

      If (blnExcluir) Then
      Begin
        Gravando.Texto := 'Deletando Registros da tabela MAX_CADMAX...';
        IsDeletarRegistros();
      End;

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('MAX_CADMAX');
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

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath(), '"', '')]);
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

function TGravandoExecucaoMaxVinilCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoMaxVinilCores.fGetPath(): String;
begin
  Result := Conf.fGet('PATMAX');
end;


function TGravandoExecucaoMaxVinilCores.fRetUnidade(fltVolume: Double): String;
begin
  If fltVolume <= 1500 Then
    Result := 'LT'
  Else If (fltVolume <= 8000) Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoMaxVinilCores.GetAdoQuery(
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

function TGravandoExecucaoMaxVinilCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM MAX_CADMAX';
end;

function TGravandoExecucaoMaxVinilCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoMaxVinilCores.GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList);
begin
  If Not qryDestino.Locate('MAX_COLECA;MAX_CODIGO;MAX_NOMCOR;MAX_PRODUT;MAX_CODBAS;MAX_UNIDAD;MAX_EMBALA',
    VarArrayOf([ArquivoText[0], LimpaTexto(ArquivoText[1]), LimpaTexto(ArquivoText[2]), LimpaTexto(ArquivoText[3]), LimpaTexto(ArquivoText[4]), fRetUnidade(StrToFloat(ArquivoText[6])), StrToFloat(ArquivoText[6])]), []) Then
  Begin
    intColorante := 1;

    qryDestino.Insert;
    qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MAX_CADMAX', TAutcomTintaFactory.Get.GetCodEmp);
    qryDestino.FieldByName('MAX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryDestino.FieldByName('MAX_CODIGO').AsString := LimpaTexto(ArquivoText[1]);
    qryDestino.FieldByName('MAX_NOMCOR').AsString := LimpaTexto(ArquivoText[2]);
    qryDestino.FieldByName('MAX_CODBAS').AsString := LimpaTexto(ArquivoText[4]);
    qryDestino.FieldByName('MAX_UNIDAD').AsString := fRetUnidade(StrToFloat(ArquivoText[6]));
    qryDestino.FieldByName('MAX_PRODUT').AsString := LimpaTexto(ArquivoText[3]);
    qryDestino.FieldByName('MAX_EMBALA').AsFloat  := StrToFloat(ArquivoText[6]);
    qryDestino.FieldByName('MAX_COLECA').AsString := ArquivoText[0];
    qryDestino.FieldByName('MAX_ATIVO_').AsString := 'S';
    qryDestino.FieldByName('MAX_MD5KEY').AsString := GetMD5(qryDestino.FieldByName('MAX_CODIGO').AsString +
                                                            qryDestino.FieldByName('MAX_CODBAS').AsString +
                                                            qryDestino.FieldByName('MAX_PRODUT').AsString +
                                                            qryDestino.FieldByName('MAX_COLECA').AsString +
                                                            qryDestino.FieldByName('MAX_UNIDAD').AsString +
                                                            qryDestino.FieldByName('MAX_NOMCOR').AsString +
                                                            qryDestino.FieldByName('MAX_EMBALA').AsString);

    qryDestino.FieldByName('MAX_FORM' + TStrUtils.fStrZero(intColorante, 2)).AsString := Trim(ArquivoText[7]);
    qryDestino.FieldByName('MAX_QTDC' + TStrUtils.fStrZero(intColorante, 2)).AsFloat  := StrToFloat(AnsiReplaceStr(ArquivoText[9], '.', ','));
    qryDestino.Post;
  End
  Else
  Begin
    intColorante := intColorante + 1;

    qryDestino.Edit;
    qryDestino.FieldByName('MAX_FORM' + TStrUtils.fStrZero(intColorante, 2)).AsString := Trim(ArquivoText[7]);
    qryDestino.FieldByName('MAX_QTDC' + TStrUtils.fStrZero(intColorante, 2)).AsFloat  := StrToFloat(AnsiReplaceStr(ArquivoText[9], '.', ','));
    qryDestino.Post;
  End;
end;

procedure TGravandoExecucaoMaxVinilCores.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM MAX_CADMAX        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoMaxVinilCores.IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
begin
  If ArquivoText[0] = 'COLECAO' Then
  Begin
    Result := True;
    Exit;
  End;

  Result := False;
end;

end.


