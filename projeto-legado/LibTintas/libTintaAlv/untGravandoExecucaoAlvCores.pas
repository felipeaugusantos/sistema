{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Alv *}
{**********************************************************************PH*}
unit untGravandoExecucaoAlvCores;

interface

uses
  untAbstractGravandoExecucaoAlv, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  System.JSON, Uni;
type
  TGravandoExecucaoAlvCores = class(TAbstractGravandoExecucaoAlv)
  Private
    //Alteração MD5KEY
    FNameConsKey: String;
    FNameColumn: String;
    FNameBanco: String;
    FNameTable: String;
    function fRetRetConstraintUniqueKey(): String;
    Procedure pRemoveAddUniqueKey(blnRemover: Boolean);
    procedure DeletarMd5KeyDuplicado(Gravando :IGravando);

    function fRetUnidade(AUnidade: Integer): String;
    function fRetEmbalagem(AUnidade: Integer): Double;
    function fFatorUnidade(AUnidade: Integer): Integer;
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

Implementation

uses
  untFuncoesGenerica, untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;


{ TGravandoExecucaoAlvCores }

procedure TGravandoExecucaoAlvCores.DeletarMd5KeyDuplicado(Gravando: IGravando);
Var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD,    ' +
                '        ALV_MD5KEY          ' +
                '   FROM ALV_CADALV          ' +
                '  GROUP BY ALV_MD5KEY       ' +
                ' HAVING COUNT(*) > 1        ';

  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    Gravando.Texto := 'Excluindo arquivos duplicados ALV_CADALV...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE                   ' +
                    '   FROM ALV_CADALV     ' +
                    '  WHERE ALV_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('ALV_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);
      qryGen.Next;
    End;
  End;
end;

procedure TGravandoExecucaoAlvCores.Executar(const gravando: IGravando);
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

      Gravando.Texto := 'Deletando Registros da tabela ALV_CADALV...';
      IsDeletarRegistros();

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALV_CADALV');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      FNameConsKey := fRetRetConstraintUniqueKey;
      Gravando.Texto := 'Removendo UNIQUE KEY...';
      pRemoveAddUniqueKey(True);
      Gravando.Texto := 'UNIQUE KEY removida...';

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
    DeletarMd5KeyDuplicado(Gravando);
    Gravando.Texto := 'Adicionando UNIQUE KEY...';
    pRemoveAddUniqueKey(False);
  End;
end;


function TGravandoExecucaoAlvCores.fFatorUnidade(AUnidade: Integer): Integer;
begin
  Result := 9;

  If AUnidade = 2 Then
    Result := 36
  Else If AUnidade = 3 Then
    Result := 180;
end;

function TGravandoExecucaoAlvCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoAlvCores.fGetPath(): String;
begin
  Result := Conf.fGet('PATALV');
end;

function TGravandoExecucaoAlvCores.fRetEmbalagem(AUnidade: Integer): Double;
begin
  Result := 900;

  If AUnidade = 2 Then
    Result := 3600
  Else If AUnidade = 3 Then
    Result := 18000;
end;

function TGravandoExecucaoAlvCores.fRetRetConstraintUniqueKey: String;
Var
  FQuery: TUniQuery;
  FSQL: String;
begin
  Try
    Try
      FQuery := TAutcomTintaFactory.Get.fCriaQuery();
      FNameColumn := 'ALV_MD5KEY';
      FNameTable := 'ALV_CADALV';
      FNameBanco := FQuery.Connection.Database;

      FSQL := '';
      FSQL := FSQL + ' SELECT  TABLE_NAME,      ' +
                     '         COLUMN_NAME,     ' +
                     '         CONSTRAINT_NAME  ' +
                     ' FROM                     ' +
                     '  INFORMATION_SCHEMA.KEY_COLUMN_USAGE   ' +
                     ' WHERE CONSTRAINT_SCHEMA = :CONSCH AND  ' +
                     '       TABLE_NAME = :TABNAM AND         ' +
                     '       COLUMN_NAME = :COLNAM            ' ;

      FQuery.Close;
      FQuery.SQL.Clear;
      FQuery.SQL.Add(FSQL);
      FQuery.ParamByName('CONSCH').AsString := FNameBanco;
      FQuery.ParamByName('TABNAM').AsString := FNameTable;
      FQuery.ParamByName('COLNAM').AsString := FNameColumn;
      FQuery.Open;

      Result := FQuery.FieldByName('CONSTRAINT_NAME').AsString;
    Except
      On E: Exception Do
        Raise;
    End;
  Finally
    If Assigned(FQuery) Then
      FreeAndNil(FQuery);
  End;
end;

function TGravandoExecucaoAlvCores.fRetUnidade(AUnidade: Integer): String;
begin
  Result := 'LT';

  If AUnidade = 2 Then
    Result := 'GL'
  Else If AUnidade = 3 Then
    Result := 'LA';
end;

function TGravandoExecucaoAlvCores.GetAdoQuery(
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


function TGravandoExecucaoAlvCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM ALV_CADALV    ';
end;

function TGravandoExecucaoAlvCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoAlvCores.GravarRegistro(const ADestino: IDataSet; AJson: TJSONObject);
Var
  iUnidade, iFormulacao: Integer;
  objFormulacao: TJSONObject;
  arrFormulacao: TJSONArray;
  intExtIfem, intFormula: Integer;
  strMd5: String;

begin

  For iUnidade := 1 To 3 Do
  Begin
    ADestino.Insert;
    ADestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALV_CADALV', TAutcomTintaFactory.Get.GetCodEmp);
    ADestino.FieldByName('ALV_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    ADestino.FieldByName('ALV_CODIGO').AsString := LimpaTexto(AJson.GetValue<string>('codigo'));
    ADestino.FieldByName('ALV_CODBAS').AsString := LimpaTexto(AJson.GetValue<string>('tecnologia'));
    ADestino.FieldByName('ALV_PRODUT').AsString := LimpaTexto(AJson.GetValue<string>('tecnologia'));
    ADestino.FieldByName('ALV_UNIDAD').AsString := fRetUnidade(IUnidade);
    ADestino.FieldByName('ALV_VOLUME').AsFloat  := fRetEmbalagem(IUnidade);
    ADestino.FieldByName('ALV_DESCOR').AsString := LimpaTexto(AJson.GetValue<string>('descrição'));
    ADestino.FieldByName('ALV_SISTEM').AsString := LimpaTexto(AJson.GetValue<string>('sistema'));


    strMd5 := '';
    strMd5 := strMd5 + ADestino.FieldByName('ALV_CODIGO').AsString;
    strMd5 := strMd5 + ADestino.FieldByName('ALV_CODBAS').AsString;
    strMd5 := strMd5 + ADestino.FieldByName('ALV_PRODUT').AsString;
    strMd5 := strMd5 + ADestino.FieldByName('ALV_UNIDAD').AsString;
    strMd5 := strMd5 + ADestino.FieldByName('ALV_VOLUME').AsString;
    strMd5 := strMd5 + ADestino.FieldByName('ALV_DESCOR').AsString;
    strMd5 := strMd5 + ADestino.FieldByName('ALV_SISTEM').AsString;

    arrFormulacao := AJson.GetValue<TJSONArray>('formulações');
    intFormula := 1;

    For iFormulacao := 0 To arrFormulacao.Count - 1 Do
    Begin
      objFormulacao := arrFormulacao.Items[iFormulacao] As TJSONObject;

      intExtIfem := Pos('-', objFormulacao.GetValue<string>('descrição_do_componente'));

      If intExtIfem > 0 Then
      Begin
        ADestino.FieldByName('ALV_FORM' + TStrUtils.fStrZero(intFormula, 2)).AsString := Trim(Copy(objFormulacao.GetValue<string>('descrição_do_componente'), intExtIfem + 1, Length(objFormulacao.GetValue<string>('descrição_do_componente'))));
        ADestino.FieldByName('ALV_QTDC' + TStrUtils.fStrZero(intFormula, 2)).AsFloat  := objFormulacao.GetValue<Double>('volume_em_100') * fFatorUnidade(iUnidade);
        strMd5 := strMd5 + ADestino.FieldByName('ALV_FORM' + TStrUtils.fStrZero(intFormula, 2)).AsString;
        strMd5 := strMd5 + ADestino.FieldByName('ALV_QTDC' + TStrUtils.fStrZero(intFormula, 2)).AsString;
        Inc(intFormula, 1);
      End;
    End;

    ADestino.FieldByName('ALV_MD5KEY').AsString := GetMD5(strMd5);
    ADestino.Post;
  End;
end;

procedure TGravandoExecucaoAlvCores.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM ALV_CADALV        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoAlvCores.IsRegistroExistente(const ADestino: IDataSet; AJson: TJSONObject): Boolean;
begin
  Result := False;
end;

procedure TGravandoExecucaoAlvCores.pRemoveAddUniqueKey(blnRemover: Boolean);
Var
  FQuery: IDataSet;
begin
  FQuery := TAutcomTintaFactory.Get.fGetDataSet;

  If BlnRemover Then
    FQuery.SQL := ' ALTER TABLE ' + FNameTable + ' DROP INDEX ' + FNameConsKey
  Else
    FQuery.SQL := ' ALTER TABLE ' + FNameTable + ' ADD CONSTRAINT ' + FNameConsKey + ' UNIQUE (' + FNameColumn + ')';
  FQuery.ExecSQL;
end;

end.
