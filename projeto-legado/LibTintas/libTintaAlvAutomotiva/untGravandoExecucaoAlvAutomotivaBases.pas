{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Alv *}
{*******************************************************************************AC*}
unit untGravandoExecucaoAlvAutomotivaBases;

interface

uses
  untAbstractGravandoExecucaoAlvAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  System.JSON;
type
  TGravandoExecucaoAlvAutomotivaBases = class(TAbstractGravandoExecucaoAlvAutomotiva)
  Private
    function fRetornaTipoFormulacao(ADescri: String): String;
    function fQtdEmbalagemMl(strEmbalagem: String): String;
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

{ TGravandoExecucaoAlvAutomotivaBases }

procedure TGravandoExecucaoAlvAutomotivaBases.Executar(const gravando: IGravando);
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

      Gravando.Texto := 'Deletando Registros da tabela ALA_CADBAS...';
      IsDeletarRegistros();

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALA_CADBAS');
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

      Gravando.Texto := Format('Processando Bases: [%s]', [AnsiReplaceStr(fGetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      For iPrincipal := 0 To arrPrincipal.Count - 1 Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        objPrincipal := arrPrincipal.Items[iPrincipal] As TJSONObject;
        arrFormulacao := objPrincipal.GetValue<TJSONArray>('formulacoes');

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

    pProcessarDiluentes(Gravando, QryDestino);
    pProcessarCatalisadores(Gravando, QryDestino);
  Finally
    If Assigned(LTextJson) Then FreeAndNil(LTextJson);
    If Assigned(arrPrincipal) Then FreeAndNil(arrPrincipal);
  End;
end;

function TGravandoExecucaoAlvAutomotivaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoAlvAutomotivaBases.fGetPath(): String;
begin
  Result := Conf.fGet('PATALA');
end;

function TGravandoExecucaoAlvAutomotivaBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

function TGravandoExecucaoAlvAutomotivaBases.fRetornaTipoFormulacao(
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

function TGravandoExecucaoAlvAutomotivaBases.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM ALA_CADBAS';
end;


procedure TGravandoExecucaoAlvAutomotivaBases.GravarRegistro(const ADestino: IDataSet; AJson: TJSONObject);
begin
  If Not ADestino.Locate('BAS_CODBAS', AJson.GetValue<string>('abbreviattion'), []) Then
  Begin
    ADestino.Insert;
    ADestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALA_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    ADestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    ADestino.FieldByName('BAS_CODBAS').AsString := AJson.GetValue<string>('abbreviattion');
    ADestino.FieldByName('BAS_DESCRI').AsString := AJson.GetValue<string>('descricao_do_componente');
    ADestino.FieldByName('BAS_EMBALA').AsFloat  := 900.0;
    ADestino.FieldByName('BAS_PESESP').AsFloat  := AJson.GetValue<Double>('peso_especifico');
    ADestino.FieldByName('BAS_TIPO__').AsString := fRetornaTipoFormulacao(ADestino.FieldByName('BAS_DESCRI').AsString);
    ADestino.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(ADestino.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
    ADestino.Post;
  End;
end;

procedure TGravandoExecucaoAlvAutomotivaBases.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM ALA_CADBAS        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoAlvAutomotivaBases.IsRegistroExistente(const ADestino: IDataSet; AJson: TJSONObject): Boolean;
begin
  Result := False;
end;

procedure TGravandoExecucaoAlvAutomotivaBases.pProcessarCatalisadores(
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

    If Not AQryDestino.Locate('BAS_CODBAS', objPrincipal.GetValue<string>('abbreviation'), []) Then
    Begin
      AQryDestino.Insert;
      AQryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALA_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
      AQryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      AQryDestino.FieldByName('BAS_CODBAS').AsString := objPrincipal.GetValue<string>('abbreviation');
      AQryDestino.FieldByName('BAS_DESCRI').AsString := objPrincipal.GetValue<string>('descricao');
      AQryDestino.FieldByName('BAS_EMBALA').AsFloat  := 900.0;
      AQryDestino.FieldByName('BAS_PESESP').AsFloat  := objPrincipal.GetValue<Double>('peso_especifico');
      AQryDestino.FieldByName('BAS_TIPO__').AsString := fRetornaTipoFormulacao(AQryDestino.FieldByName('BAS_DESCRI').AsString);
      AQryDestino.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(AQryDestino.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
      AQryDestino.Post;
    End;

    AGravando.RegistrarProgresso(0, iPrincipal, arrPrincipal.Count - 1);
  End;

  If Assigned(arrPrincipal) Then
    FreeAndNil(arrPrincipal);
end;

procedure TGravandoExecucaoAlvAutomotivaBases.pProcessarDiluentes(const AGravando: IGravando; AQryDestino: IDataSet);
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

    If Not AQryDestino.Locate('BAS_CODBAS', objPrincipal.GetValue<string>('abbreviation'), []) Then
    Begin
      AQryDestino.Insert;
      AQryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALA_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
      AQryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      AQryDestino.FieldByName('BAS_CODBAS').AsString := objPrincipal.GetValue<string>('abbreviation');
      AQryDestino.FieldByName('BAS_DESCRI').AsString := objPrincipal.GetValue<string>('descricao');
      AQryDestino.FieldByName('BAS_EMBALA').AsFloat  := 900.0;
      AQryDestino.FieldByName('BAS_PESESP').AsFloat  := objPrincipal.GetValue<Double>('peso_especifico');
      AQryDestino.FieldByName('BAS_TIPO__').AsString := fRetornaTipoFormulacao(AQryDestino.FieldByName('BAS_DESCRI').AsString);
      AQryDestino.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(AQryDestino.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
      AQryDestino.Post;
    End;

    AGravando.RegistrarProgresso(0, iPrincipal, arrPrincipal.Count - 1);
  End;

  If Assigned(arrPrincipal) Then
    FreeAndNil(arrPrincipal);
end;

end.
