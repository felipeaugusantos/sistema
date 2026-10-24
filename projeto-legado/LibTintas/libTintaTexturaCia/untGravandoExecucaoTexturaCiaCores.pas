{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta TexturaCia *}
{**********************************************************************PH*}
unit untGravandoExecucaoTexturaCiaCores;

interface

uses
  untAbstractGravandoExecucaoTexturaCia, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  System.Win.ComObj;

type
  TGravandoExecucaoTexturaCiaCores = class(TAbstractGravandoExecucaoTexturaCia)
  Private
    intColorante: Integer;
    procedure LimparTabelas;
  public
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function fGetPath(): String; override;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean; override;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList); override;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; override;

  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


{ TGravandoExecucaoTexturaCiaCores }

procedure TGravandoExecucaoTexturaCiaCores.Executar(const gravando: IGravando);
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
        Gravando.Texto := 'Deletando Registros da tabela TEX_CADTEX...';
        LimparTabelas();
      End;

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('TEX_CADTEX');
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


function TGravandoExecucaoTexturaCiaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoTexturaCiaCores.fGetPath: String;
begin
  Result := Conf.fGet('PATTEX');
end;

function TGravandoExecucaoTexturaCiaCores.GetAdoQuery(
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

function TGravandoExecucaoTexturaCiaCores.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM TEX_CADTEX ';
end;

function TGravandoExecucaoTexturaCiaCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoTexturaCiaCores.GravarRegistro(
  const qryDestino: IDataSet; ArquivoText: TStringList);
begin
  If Not qryDestino.Locate('TEX_CODIGO;TEX_CODCOR;TEX_CODBAS;TEX_PRODUT;TEX_CATALO;TEX_UNIDAD;TEX_EMBALA', VarArrayOf([LimpaTexto(ArquivoText[1]),
    LimpaTexto(ArquivoText[2]), LimpaTexto(ArquivoText[4]), LimpaTexto(ArquivoText[3]), LimpaTexto(ArquivoText[0]), fRetCodUnidade(StrToFloat(ArquivoText[6])), StrToFloat(ArquivoText[6])]), []) Then
  Begin
    intColorante := 1;

    qryDestino.Insert;
    qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('TEX_CADTEX', TAutcomTintaFactory.Get.GetCodEmp);
    qryDestino.FieldByName('TEX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryDestino.FieldByName('TEX_CODIGO').AsString := LimpaTexto(ArquivoText[1]);
    qryDestino.FieldByName('TEX_CODCOR').AsString := LimpaTexto(ArquivoText[2]);
    qryDestino.FieldByName('TEX_CODBAS').AsString := LimpaTexto(ArquivoText[4]);
    qryDestino.FieldByName('TEX_PRODUT').AsString := LimpaTexto(ArquivoText[3]);
    qryDestino.FieldByName('TEX_CATALO').AsString := LimpaTexto(ArquivoText[0]);
    qryDestino.FieldByName('TEX_UNIDAD').AsString := fRetCodUnidade(StrToFloat(ArquivoText[6]));
    qryDestino.FieldByName('TEX_EMBALA').AsFloat  := StrToFloat(ArquivoText[6]);
    qryDestino.FieldByName('TEX_ATIVAD').AsString := 'S';
    qryDestino.FieldByName('TEX_MD5KEY').AsString := GetMD5(qryDestino.FieldByName('TEX_CODIGO').AsString +
                                                            qryDestino.FieldByName('TEX_CODCOR').AsString +
                                                            qryDestino.FieldByName('TEX_CODBAS').AsString +
                                                            qryDestino.FieldByName('TEX_PRODUT').AsString +
                                                            qryDestino.FieldByName('TEX_CATALO').AsString +
                                                            qryDestino.FieldByName('TEX_UNIDAD').AsString +
                                                            qryDestino.FieldByName('TEX_EMBALA').AsString);

    qryDestino.FieldByName('TEX_FORM01').AsString := Trim(ArquivoText[7]);
    qryDestino.FieldByName('TEX_QTDC01').AsFloat  := StrToFloat(AnsiReplaceStr(ArquivoText[9], '.', ','));
    qryDestino.Post;
  End
  Else
  Begin
    Inc(intColorante);

    qryDestino.Edit;
    qryDestino.FieldByName('TEX_FORM' + TStrUtils.fStrZero(intColorante, 2)).AsString := Trim(ArquivoText[7]);
    qryDestino.FieldByName('TEX_QTDC' + TStrUtils.fStrZero(intColorante, 2)).AsFloat  := StrToFloat(AnsiReplaceStr(ArquivoText[9], '.', ','));
    qryDestino.Post;
  End;
end;

function TGravandoExecucaoTexturaCiaCores.IsRegistroExistente(
  const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
begin
  If ArquivoText[0] = 'COLECAO' Then
  Begin
    Result := True;
    Exit;
  End;

  Result := False;
end;

procedure TGravandoExecucaoTexturaCiaCores.LimparTabelas;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM TEX_CADTEX';
  qryGen.ExecSQL;
end;

end.

