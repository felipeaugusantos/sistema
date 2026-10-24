{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Alv *}
{**********************************************************************PH*}
unit untGravandoExecucaoAlvAutomotivaCores;

interface

uses
  untAbstractGravandoExecucaoAlvAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  System.JSON, Uni;
type
  TGravandoExecucaoAlvAutomotivaCores = class(TAbstractGravandoExecucaoAlvAutomotiva)
  Private
    //Alteração MD5KEY
    FNameConsKey: String;
    FNameColumn: String;
    FNameBanco: String;
    FNameTable: String;
    function fRetRetConstraintUniqueKey(): String;
    Procedure pRemoveAddUniqueKey(blnRemover: Boolean);
    procedure DeletarMd5KeyDuplicado(Gravando :IGravando);
    procedure IsDeletarRegistros();
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function fGetPath(): String; override;
    function IsRegistroExistente(const ADestino: IDataSet; AJson: TJSONObject): Boolean; Reintroduce;
    procedure GravarRegistro(const ADestino: IDataSet; AJson: TJSONObject); Reintroduce;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;


{ TGravandoExecucaoAlvAutomotivaCores }

procedure TGravandoExecucaoAlvAutomotivaCores.DeletarMd5KeyDuplicado(Gravando: IGravando);
Var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD,    ' +
                '        ALA_MD5KEY          ' +
                '   FROM ALA_CADALA          ' +
                '  GROUP BY ALA_MD5KEY       ' +
                ' HAVING COUNT(*) > 1        ';

  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    Gravando.Texto := 'Excluindo arquivos duplicados ALA_CADALA...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE                   ' +
                    '   FROM ALA_CADALA     ' +
                    '  WHERE ALA_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('ALA_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);
      qryGen.Next;
    End;
  End;
end;

procedure TGravandoExecucaoAlvAutomotivaCores.Executar(const gravando: IGravando);
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

      Gravando.Texto := 'Deletando Registros da tabela ALA_CADALA...';
      IsDeletarRegistros();

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALA_CADALA');
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


function TGravandoExecucaoAlvAutomotivaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoAlvAutomotivaCores.fGetPath(): String;
begin
  Result := Conf.fGet('PATALA');
end;


function TGravandoExecucaoAlvAutomotivaCores.fRetRetConstraintUniqueKey: String;
Var
  FQuery: TUniQuery;
  FSQL: String;
begin
  Try
    Try
      FQuery := TAutcomTintaFactory.Get.fCriaQuery();
      FNameColumn := 'ALA_MD5KEY';
      FNameTable := 'ALA_CADALA';
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

function TGravandoExecucaoAlvAutomotivaCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM ALA_CADALA    ';
end;


procedure TGravandoExecucaoAlvAutomotivaCores.GravarRegistro(const ADestino: IDataSet; AJson: TJSONObject);
Var
  iFormulacao: Integer;
  objFormulacao: TJSONObject;
  arrFormulacao: TJSONArray;
  intFormula: Integer;
  strMd5: String;
begin
  ADestino.Insert;
  ADestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALA_CADALA', TAutcomTintaFactory.Get.GetCodEmp);
  ADestino.FieldByName('ALA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  ADestino.FieldByName('ALA_CODIGO').AsString := LimpaTexto(AJson.GetValue<string>('codigo'));
  ADestino.FieldByName('ALA_DESCRI').AsString := LimpaTexto(AJson.GetValue<string>('descricao'));
  ADestino.FieldByName('ALA_TECNOL').AsString := LimpaTexto(AJson.GetValue<string>('tecnologia'));
  ADestino.FieldByName('ALA_SYSTEM').AsString := LimpaTexto(AJson.GetValue<string>('sistema'));
  ADestino.FieldByName('ALA_TONALI').AsString := LimpaTexto(AJson.GetValue<string>('tonalidade'));
  ADestino.FieldByName('ALA_ATIVAD').AsString := 'S';


  strMd5 := '';
  strMd5 := strMd5 + ADestino.FieldByName('ALA_CODIGO').AsString;
  strMd5 := strMd5 + ADestino.FieldByName('ALA_DESCRI').AsString;
  strMd5 := strMd5 + ADestino.FieldByName('ALA_TECNOL').AsString;
  strMd5 := strMd5 + ADestino.FieldByName('ALA_SYSTEM').AsString;
  strMd5 := strMd5 + ADestino.FieldByName('ALA_TONALI').AsString;

  arrFormulacao := AJson.GetValue<TJSONArray>('formulacoes');
  intFormula := 1;

  For iFormulacao := 0 To arrFormulacao.Count - 1 Do
  Begin
    objFormulacao := arrFormulacao.Items[iFormulacao] As TJSONObject;

    ADestino.FieldByName('ALA_CODB' + TStrUtils.fStrZero(intFormula, 2)).AsString := Trim(objFormulacao.GetValue<string>('abbreviattion'));
    ADestino.FieldByName('ALA_QTDB' + TStrUtils.fStrZero(intFormula, 2)).AsFloat  := (objFormulacao.GetValue<Double>('volume_em_100') * objFormulacao.GetValue<Double>('peso_especifico')) * 9; //900ML EM GRAMA
    strMd5 := strMd5 + ADestino.FieldByName('ALA_CODB' + TStrUtils.fStrZero(intFormula, 2)).AsString;
    strMd5 := strMd5 + ADestino.FieldByName('ALA_QTDB' + TStrUtils.fStrZero(intFormula, 2)).AsString;
    Inc(intFormula, 1);
  End;

  ADestino.FieldByName('ALA_MD5KEY').AsString := GetMD5(strMd5);
  ADestino.Post;
end;

procedure TGravandoExecucaoAlvAutomotivaCores.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM ALA_CADALA        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoAlvAutomotivaCores.IsRegistroExistente(const ADestino: IDataSet; AJson: TJSONObject): Boolean;
begin
  Result := False;
end;

procedure TGravandoExecucaoAlvAutomotivaCores.pRemoveAddUniqueKey(blnRemover: Boolean);
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
