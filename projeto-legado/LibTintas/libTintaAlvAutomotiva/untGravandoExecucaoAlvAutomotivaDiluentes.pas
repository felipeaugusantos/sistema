{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Alv *}
{*******************************************************************************AC*}
unit untGravandoExecucaoAlvAutomotivaDiluentes;

interface

uses
  untAbstractGravandoExecucaoAlvAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  System.JSON;
type
  TGravandoExecucaoAlvAutomotivaDiluentes = class(TAbstractGravandoExecucaoAlvAutomotiva)
  Private
    function fRetornaTipoFormulacao(ADescri: String): String;
    procedure IsDeletarRegistros();
    procedure pProcessarDiluentes(const AGravando: IGravando; AQryDestino: IDataSet);
    procedure pProcessarCatalisadores(const AGravando: IGravando; AQryDestino: IDataSet);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function fGetPath(): String; override;
    function IsRegistroExistente(const ADestino: IDataSet; AJson: TJSONObject): Boolean; Reintroduce;
    procedure GravarRegistro(const ADestino: IDataSet; AJson: TJSONObject); Reintroduce;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoAlvAutomotivaDiluentes }

procedure TGravandoExecucaoAlvAutomotivaDiluentes.Executar(const gravando: IGravando);
Var
  QryDestino: IDataSet;
begin
  Try
    Try
      Gravando.Texto := 'Deletando Registros da tabela ALA_CADDIL...';
      IsDeletarRegistros();

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALA_CADDIL');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Carregando Dados...';
      QryDestino := GetDataSetDestino;

      pProcessarDiluentes(Gravando, QryDestino);
      pProcessarCatalisadores(Gravando, QryDestino);
    Except
      On E: Exception Do
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
  End;
end;

function TGravandoExecucaoAlvAutomotivaDiluentes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Diluentes/Catalisadores';
end;


function TGravandoExecucaoAlvAutomotivaDiluentes.fGetPath(): String;
begin
  Result := Conf.fGet('PATALA');
end;


function TGravandoExecucaoAlvAutomotivaDiluentes.fRetornaTipoFormulacao(
  ADescri: String): String;
Var
  LPos: String;
begin
  Result := '';

  LPos := Copy(ADescri, 1, 2);

  If LPos = 'CO' Then
    Result := 'COLORANTE'
  Else If LPos = 'CL' Then
    Result := 'CLEAR'
  Else If Lpos = 'BA' Then
    Result := 'BASE'
  Else If LPos = 'DI' Then
    Result := 'DILUENTE'
  Else If LPos = 'TH' Then
    Result := 'DILUENTE'
  Else If LPos = 'CA' Then
    Result := 'CATALISADOR'
  Else If LPos = 'EN' Then
    Result := 'CATALISADOR';
end;

function TGravandoExecucaoAlvAutomotivaDiluentes.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM ALA_CADDIL';
end;


procedure TGravandoExecucaoAlvAutomotivaDiluentes.GravarRegistro(const ADestino: IDataSet; AJson: TJSONObject);
Var
 arrBases: TJSONArray;
 objBases: TJSONObject;
 iBases: Integer;
 AValor: String;
begin
  arrBases := AJson.GetValue<TJSONArray>('bases_relacionadas');

  For iBases := 0 To arrBases.Count - 1 Do
  Begin
    objBases := arrBases.Items[iBases] As TJSONObject;

    AValor := AnsiReplaceStr(objBases.GetValue<String>('valor'), ',', '.');

    If TStrUtils.fEmptyStr(AValor) Then
      Continue;

    If Not ADestino.Locate('DIL_CODDIL;DIL_PRODUT',  VarArrayOf([AJson.GetValue<string>('abbreviation'), objBases.GetValue<string>('abbreviation')]), []) Then
    Begin
      ADestino.Insert;
      ADestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALA_CADDIL', TAutcomTintaFactory.Get.GetCodEmp);
      ADestino.FieldByName('DIL_CODDIL').AsString := AJson.GetValue<string>('abbreviation');
      ADestino.FieldByName('DIL_PRODUT').AsString := objBases.GetValue<string>('abbreviation');
      ADestino.FieldByName('DIL_PERCEN').AsString  := AValor;
      ADestino.FieldByName('DIL_TIPO__').AsString := fRetornaTipoFormulacao(AJson.GetValue<string>('descricao'));
      ADestino.Post;
    End;
  End;
end;

procedure TGravandoExecucaoAlvAutomotivaDiluentes.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM ALA_CADDIL        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoAlvAutomotivaDiluentes.IsRegistroExistente(const ADestino: IDataSet; AJson: TJSONObject): Boolean;
begin
  Result := False;
end;

procedure TGravandoExecucaoAlvAutomotivaDiluentes.pProcessarCatalisadores(
  const AGravando: IGravando; AQryDestino: IDataSet);
Var
  LTextJson: TStringList;
  JsonString: String;
  objPrincipal: TJSONObject;
  arrPrincipal: TJSONArray;
  iPrincipal: Integer;
begin
  AGravando.Texto := 'Verificando Path do arquivo catalisadores...';

  If Not FileExists(Conf.fGet('PATCAT')) Then
  Begin
    AGravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(Conf.fGet('PATCAT'), '"', '')]);
    Exit;
  End;

  LTextJson := TStringList.Create;
  LTextJson.LoadFromFile(Conf.fGet('PATCAT'), TEncoding.UTF8);
  JsonString := LTextJson.Text;

  arrPrincipal := TJSONObject.ParseJSONValue(JsonString) As TJSONArray;

  If Not Assigned(arrPrincipal) Then
  Begin
    AGravando.Texto := 'JSON inválido ou vazio';
    Exit;
  End;

  AGravando.Texto := Format('Processando Catalisadores: [%s]', [AnsiReplaceStr(Conf.fGet('PATCAT'), '"', '')]);
  AGravando.RegistrarProgresso(0, 0, 0);

  For iPrincipal := 0 To arrPrincipal.Count - 1 Do
  Begin
    If (AGravando.Status <> sgGravando) Then
      Break;

    objPrincipal := arrPrincipal.Items[iPrincipal] As TJSONObject;
    GravarRegistro(AQryDestino, objPrincipal);
    AGravando.RegistrarProgresso(0, iPrincipal, arrPrincipal.Count - 1);
  End;

  If Assigned(arrPrincipal) Then
    FreeAndNil(arrPrincipal);
end;

procedure TGravandoExecucaoAlvAutomotivaDiluentes.pProcessarDiluentes(const AGravando: IGravando; AQryDestino: IDataSet);
Var
  LTextJson: TStringList;
  JsonString: String;
  objPrincipal: TJSONObject;
  arrPrincipal: TJSONArray;
  iPrincipal: Integer;
begin
  AGravando.Texto := 'Verificando Path do arquivo diluente...';

  If Not FileExists(Conf.fGet('PATDIL')) Then
  Begin
    AGravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(Conf.fGet('PATDIL'), '"', '')]);
    Exit;
  End;

  LTextJson := TStringList.Create;
  LTextJson.LoadFromFile(Conf.fGet('PATDIL'), TEncoding.UTF8);
  JsonString := LTextJson.Text;

  arrPrincipal := TJSONObject.ParseJSONValue(JsonString) As TJSONArray;

  If Not Assigned(arrPrincipal) Then
  Begin
    AGravando.Texto := 'JSON inválido ou vazio';
    Exit;
  End;

  AGravando.Texto := Format('Processando Diluentes: [%s]', [AnsiReplaceStr(Conf.fGet('PATDIL'), '"', '')]);
  AGravando.RegistrarProgresso(0, 0, 0);

  For iPrincipal := 0 To arrPrincipal.Count - 1 Do
  Begin
    If (AGravando.Status <> sgGravando) Then
      Break;

    objPrincipal := arrPrincipal.Items[iPrincipal] As TJSONObject;
    GravarRegistro(AQryDestino, objPrincipal);
    AGravando.RegistrarProgresso(0, iPrincipal, arrPrincipal.Count - 1);
  End;

  If Assigned(arrPrincipal) Then
    FreeAndNil(arrPrincipal);
end;

end.
