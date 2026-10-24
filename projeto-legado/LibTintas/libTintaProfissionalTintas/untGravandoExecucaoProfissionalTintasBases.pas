{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta ProfissionalTintas *}
{*******************************************************************************AC*}
unit untGravandoExecucaoProfissionalTintasBases;

interface

uses
  untAbstractGravandoExecucaoProfissionalTintas, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoProfissionalTintasBases = class(TAbstractGravandoExecucaoProfissionalTintas)
  Private
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

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoProfissionalTintasBases }

procedure TGravandoExecucaoProfissionalTintasBases.Executar(const gravando: IGravando);
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

      Gravando.Texto := 'Verificando Path do arquivo...';

      If Not fValidarPath() Then
      Begin
        Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath(), '"', '')]);
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      If (blnExcluir) Then
      Begin
        Gravando.Texto := 'Deletando Registros da tabela PRT_CADBAS...';
        IsDeletarRegistros();
      End;

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('PRT_CADBAS');
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

function TGravandoExecucaoProfissionalTintasBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoProfissionalTintasBases.fGetPath(): String;
begin
  Result := Conf.fGet('PATPRT');
end;

function TGravandoExecucaoProfissionalTintasBases.fRetUnidade(fltVolume: Double): String;
begin
  If fltVolume <= 1500 Then
    Result := 'LT'
  Else If (fltVolume <= 8000) Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoProfissionalTintasBases.GetAdoQuery(
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

function TGravandoExecucaoProfissionalTintasBases.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM PRT_CADBAS';
end;

function TGravandoExecucaoProfissionalTintasBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoProfissionalTintasBases.GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList);
begin


  If Not qryDestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_UNIDAD', VarArrayOf([LimpaTexto(ArquivoText[4]), LimpaTexto(ArquivoText[3]),
    fRetUnidade(StrToFloat(ArquivoText[6]))]), []) Then
  Begin
    qryDestino.Insert;
    qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PRT_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryDestino.FieldByName('BAS_CODBAS').AsString := LimpaTexto(ArquivoText[4]);
    qryDestino.FieldByName('BAS_UNIDAD').AsString := fRetUnidade(StrToFloat(ArquivoText[6]));
    qryDestino.FieldByName('BAS_EMBALA').AsFloat  := StrToFloat(ArquivoText[6]);
    qryDestino.FieldByName('BAS_PRODUT').AsString := LimpaTexto(ArquivoText[3]);
    qryDestino.Post;
  End;
end;

procedure TGravandoExecucaoProfissionalTintasBases.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM PRT_CADBAS        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoProfissionalTintasBases.IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
begin
  If ArquivoText[0] = 'LINHA' Then
  Begin
    Result := True;
    Exit;
  End;

  Result := False;
end;


end.
