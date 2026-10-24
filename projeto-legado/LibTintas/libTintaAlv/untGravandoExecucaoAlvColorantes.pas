{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Alv *}
{***************************************************************************PH*}
unit untGravandoExecucaoAlvColorantes;

interface

uses
  untAbstractGravandoExecucaoAlv, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  System.JSON;
type
  TGravandoExecucaoAlvColorantes = class(TAbstractGravandoExecucaoAlv)
  Private
    procedure IsDeletarRegistros();
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function fGetPath(): String; override;
    function IsRegistroExistente(const ADestino: IDataSet; AJson: TJSONObject): Boolean; Reintroduce;
    procedure GravarRegistro(const ADestino: IDataSet; AJson: TJSONObject); Reintroduce;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoAlvCores }

procedure TGravandoExecucaoAlvColorantes.Executar(const gravando: IGravando);
Var
  QryDestino: IDataSet;
  LTextJson: TStringList;
  JsonString: String;
  objPrincipal, objFormulacao: TJSONObject;
  arrPrincipal, arrFormulacao: TJSONArray;
  iPrincipal, iFormulacao: Integer;
begin
  Try
    Try
      Gravando.Texto := 'Verificando Path do arquivo...';

      If Not fValidarPath Then
      Begin
        Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath, '"', '')]);
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Deletando Registros da tabela ALV_CADCOL...';
      IsDeletarRegistros();

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALV_CADCOL');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Carregando Dados...';
      QryDestino := GetDataSetDestino;

      LTextJson := TStringList.Create;
      LTextJson.LoadFromFile(fGetPath, TEncoding.UTF8);
      JsonString := LTextJson.Text;

      arrPrincipal := TJSONObject.ParseJSONValue(JsonString) As TJSONArray;

      If Not Assigned(arrPrincipal) Then
      Begin
        Gravando.Texto := 'JSON inválido ou vazio';
        Exit;
      End;

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      For iPrincipal := 0 To arrPrincipal.Count - 1 Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        objPrincipal := arrPrincipal.Items[iPrincipal] As TJSONObject;
        arrFormulacao := objPrincipal.GetValue<TJSONArray>('formulações');

        If Not Assigned(arrFormulacao) Then
        Begin
          Gravando.Texto := 'JSON inválido ou vazio';
          Exit;
        End;

        For iFormulacao := 0 To arrFormulacao.Count - 1 Do
        Begin
          objFormulacao := arrFormulacao.Items[iFormulacao] As TJSONObject;
          GravarRegistro(qryDestino, objFormulacao);
        End;

        Gravando.RegistrarProgresso(0, iPrincipal, arrPrincipal.Count - 1);
      End;
    Except
      On E: Exception Do
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
    If Assigned(LTextJson) Then FreeAndNil(LTextJson);
    If Assigned(arrPrincipal) Then FreeAndNil(arrPrincipal);
  End;
end;

function TGravandoExecucaoAlvColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoAlvColorantes.fGetPath(): String;
begin
  Result := Conf.fGet('PATALV');
end;

function TGravandoExecucaoAlvColorantes.GetAdoQuery(
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

function TGravandoExecucaoAlvColorantes.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM ALV_CADCOL  ';
end;

function TGravandoExecucaoAlvColorantes.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoAlvColorantes.GravarRegistro(const ADestino: IDataSet; AJson: TJSONObject);
Var
  intExtIfem: Integer;
  strColorante, strDescricao: String;
begin
  intExtIfem := Pos('-', AJson.GetValue<string>('descrição_do_componente'));

  If intExtIfem > 0 Then
  Begin
    strColorante := Trim(Copy(AJson.GetValue<string>('descrição_do_componente'), intExtIfem + 1, Length(AJson.GetValue<string>('descrição_do_componente'))));
    strDescricao := Trim(Copy(AJson.GetValue<string>('descrição_do_componente'), 1, intExtIfem - 1));
  End
  Else
  Begin
    strColorante := '';
    strDescricao := '';
  End;

  If Not TStrUtils.fEmptyStr(strColorante) Then
  Begin
    If Not ADestino.Locate('COL_CODCOL', strColorante, []) Then
    Begin
      ADestino.Insert;
      ADestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALV_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
      ADestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      ADestino.FieldByName('COL_CODCOL').AsString := strColorante;
      ADestino.FieldByName('COL_DESCRI').AsString := strDescricao;
      ADestino.FieldByName('COL_PESESP').AsFloat  := AJson.GetValue<Double>('peso_especifico');
      ADestino.FieldByName('COL_EMBALA').AsFloat  := 900;
      ADestino.Post;
    End;
  End;
end;

procedure TGravandoExecucaoAlvColorantes.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM ALV_CADCOL       ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoAlvColorantes.IsRegistroExistente(const ADestino: IDataSet; AJson: TJSONObject): Boolean;
begin
  Result := False;
end;


end.

