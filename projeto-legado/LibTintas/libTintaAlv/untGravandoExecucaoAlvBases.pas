{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Alv *}
{*******************************************************************************AC*}
unit untGravandoExecucaoAlvBases;

interface

uses
  untAbstractGravandoExecucaoAlv, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  System.JSON;
type
  TGravandoExecucaoAlvBases = class(TAbstractGravandoExecucaoAlv)
  Private
    function fRetUnidade(AUnidade: Integer): String;
    function fRetEmbalagem(AUnidade: Integer): Double;
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

{ TGravandoExecucaoAlvBases }

procedure TGravandoExecucaoAlvBases.Executar(const gravando: IGravando);
Var
  QryDestino: IDataSet;
  LTextJson: TStringList;
  JsonString: String;
  objPrincipal: TJSONObject;
  arrPrincipal: TJSONArray;
  iPrincipal: Integer;
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

      Gravando.Texto := 'Deletando Registros da tabela ALV_CADBAS...';
      IsDeletarRegistros();

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALV_CADBAS');
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
        GravarRegistro(qryDestino, objPrincipal);
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

function TGravandoExecucaoAlvBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoAlvBases.fGetPath(): String;
begin
  Result := Conf.fGet('PATALV');
end;

function TGravandoExecucaoAlvBases.fRetEmbalagem(AUnidade: Integer): Double;
begin
  Result := 900;

  If AUnidade = 2 Then
    Result := 3600
  Else If AUnidade = 3 Then
    Result := 18000;
end;

function TGravandoExecucaoAlvBases.fRetUnidade(AUnidade: Integer): String;
begin
  Result := 'LT';

  If AUnidade = 2 Then
    Result := 'GL'
  Else If AUnidade = 3 Then
    Result := 'LA';
end;

function TGravandoExecucaoAlvBases.GetAdoQuery(
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

function TGravandoExecucaoAlvBases.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM ALV_CADBAS';
end;

function TGravandoExecucaoAlvBases.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoAlvBases.GravarRegistro(const ADestino: IDataSet; AJson: TJSONObject);
Var
  iUnidade: Integer;
begin
  For iUnidade := 1 To 3 Do
  Begin
    If Not ADestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_UNIDAD;BAS_EMBALA', VarArrayOf([LimpaTexto(AJson.GetValue<string>('tecnologia')),
      LimpaTexto(AJson.GetValue<string>('tecnologia')), fRetUnidade(IUnidade), fRetEmbalagem(IUnidade)]), []) Then
    Begin
      ADestino.Insert;
      ADestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALV_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
      ADestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      ADestino.FieldByName('BAS_CODBAS').AsString := LimpaTexto(AJson.GetValue<string>('tecnologia'));
      ADestino.FieldByName('BAS_EMBALA').AsFloat  := fRetEmbalagem(IUnidade);
      ADestino.FieldByName('BAS_UNIDAD').AsString := fRetUnidade(IUnidade);
      ADestino.FieldByName('BAS_PRODUT').AsString := LimpaTexto(AJson.GetValue<string>('tecnologia'));
      ADestino.Post;
    End;
  End;
end;

procedure TGravandoExecucaoAlvBases.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM ALV_CADBAS        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoAlvBases.IsRegistroExistente(const ADestino: IDataSet; AJson: TJSONObject): Boolean;
begin
  Result := False;
end;

end.
