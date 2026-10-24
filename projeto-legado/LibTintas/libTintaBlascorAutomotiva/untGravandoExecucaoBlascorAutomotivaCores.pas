{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta BlascorAutomotiva *}
{**********************************************************************PH*}
unit untGravandoExecucaoBlascorAutomotivaCores;

interface

uses
  untAbstractGravandoExecucaoBlascorAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  Uni;
type
  TGravandoExecucaoBlascorAutomotivaCores = class(TAbstractGravandoExecucaoBlascorAutomotiva)
  Private
     //Alteração MD5KEY
    FNameConsKey: String;
    FNameColumn: String;
    FNameBanco: String;
    FNameTable: String;
    function fRetQuantidade(AQryDestino: IDataSet): Integer;
    function fRetRetConstraintUniqueKey(): String;
    Procedure pRemoveAddUniqueKey(blnRemover: Boolean);
    procedure DeletarMd5KeyDuplicado(Gravando :IGravando);
    Procedure pUpdateMD5KEYBlascor(Const AGravando: IGravando);
    function IsRegistroExistenteDiluentes(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
    procedure pProcessarDiluentes(Const AGravando: IGravando);
    procedure IsDeletarRegistros();
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function fGetPath(): String; override;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean; override;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList; AContador: Integer); Reintroduce;
    procedure EditarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList; AContador: Integer);
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;


{ TGravandoExecucaoBlascorAutomotivaCores }

procedure TGravandoExecucaoBlascorAutomotivaCores.DeletarMd5KeyDuplicado(
  Gravando: IGravando);
Var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD,    ' +
                '        BLA_MD5KEY          ' +
                '   FROM BLA_CADBLA          ' +
                '  GROUP BY BLA_MD5KEY       ' +
                ' HAVING COUNT(*) > 1        ';

  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    Gravando.Texto := 'Excluindo arquivos duplicados BLA_CADBLA...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE                   ' +
                    '   FROM BLA_CADBLA     ' +
                    '  WHERE BLA_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('BLA_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);
      qryGen.Next;
    End;
  End;
end;
procedure TGravandoExecucaoBlascorAutomotivaCores.EditarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList; AContador: Integer);
Var
  fltQuantidade: Double;
begin
  fltQuantidade := StrToFloat(AnsiReplaceStr(ArquivoText[17], '.', ','));
  fltQuantidade := (fltQuantidade * 0.9) / 100;

  qryDestino.Edit;
  qryDestino.FieldByName('BLA_BASE' + TStrUtils.fStrZero(AContador, 2)).AsString := LimpaTexto(ArquivoText[14]);
  qryDestino.FieldByName('BLA_QTDB' + TStrUtils.fStrZero(AContador, 2)).AsFloat := fltQuantidade;
  qryDestino.Post;
End;

procedure TGravandoExecucaoBlascorAutomotivaCores.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: String;
  iRecordCount: Integer;
  intLinha: Integer;
  intQuantidade: Integer;
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

      Gravando.Texto := 'Deletando Registros da tabela BLA_CADBLA...';
      IsDeletarRegistros();

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BLA_CADBLA');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      FNameConsKey := fRetRetConstraintUniqueKey;
      Gravando.Texto := 'Removendo UNIQUE KEY...';
      pRemoveAddUniqueKey(True);
      Gravando.Texto := 'UNIQUE KEY removida...';

      Gravando.Texto := 'Carregando Dados...';
      iRecordCount := fContaLinhas(fGetPath);
      intLinha := 1;
      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;

      stlCsv := TStringList.Create();
      stlCsv.StrictDelimiter := True;
      stlCsv.Delimiter := ',';

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
        Begin
          qryDestino.Close;
          qryDestino.SQL := GetSqlDestino;
          qryDestino.ParamByName('CODIGO').AsString := LimpaTexto(stlCsv[0]);
          qryDestino.Open;

          If qryDestino.IsEmpty Then
          Begin
            intQuantidade := 1;
            GravarRegistro(qryDestino, stlCsv, intQuantidade)
          End
          Else
          Begin
            intQuantidade := fRetQuantidade(qryDestino);
            EditarRegistro(qryDestino, stlCsv, intQuantidade);
          End;
        End;

        Inc(intLinha);
        Gravando.RegistrarProgresso(0, intLinha, iRecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := strLinha;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(stlCsv) Then FreeAndNil(stlCsv);
    CloseFile(Arquivo);
    pProcessarDiluentes(Gravando);
    pUpdateMD5KEYBlascor(Gravando);
    DeletarMd5KeyDuplicado(Gravando);
    Gravando.Texto := 'Adicionando UNIQUE KEY...';
    pRemoveAddUniqueKey(False);
  End;
end;


function TGravandoExecucaoBlascorAutomotivaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoBlascorAutomotivaCores.fGetPath(): String;
begin
  Result := Conf.fGet('PATBLA');
end;


function TGravandoExecucaoBlascorAutomotivaCores.fRetQuantidade(AQryDestino: IDataSet): Integer;
Var
  LResult: Integer;
begin
  Result := 2;

  For LResult := 2 To 20 Do
  Begin
    If TStrUtils.fEmptyStr(AQryDestino.FieldByName('BLA_BASE' + TStrUtils.fStrZero(LResult, 2)).AsString) Then
    Begin
      Result := LResult;
      Break;
    End;
  End;
end;

function TGravandoExecucaoBlascorAutomotivaCores.fRetRetConstraintUniqueKey: String;
Var
  FQuery: TUniQuery;
  FSQL: String;
begin
  Try
    Try
      FQuery := TAutcomTintaFactory.Get.fCriaQuery();
      FNameColumn := 'BLA_MD5KEY';
      FNameTable := 'BLA_CADBLA';
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

function TGravandoExecucaoBlascorAutomotivaCores.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
begin
  Result := Nil;
end;



function TGravandoExecucaoBlascorAutomotivaCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM BLA_CADBLA WHERE BLA_CODIGO = :CODIGO    ';
end;

function TGravandoExecucaoBlascorAutomotivaCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoBlascorAutomotivaCores.GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList; AContador: Integer);
Var
  fltQuantidade: Double;
begin
  fltQuantidade := StrToFloat(AnsiReplaceStr(ArquivoText[17], '.', ','));
  fltQuantidade := (fltQuantidade * 0.9) / 100;

  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('BLA_CADBLA', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BLA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BLA_CODIGO').AsString := LimpaTexto(ArquivoText[0]);
  qryDestino.FieldByName('BLA_CODUNI').AsString := LimpaTexto(ArquivoText[1]);
  qryDestino.FieldByName('BLA_DESCRI').AsString := LimpaTexto(ArquivoText[2]);
  qryDestino.FieldByName('BLA_ANOINI').AsString := LimpaTexto(ArquivoText[3]);
  qryDestino.FieldByName('BLA_ANOFIM').AsString := LimpaTexto(ArquivoText[4]);
  qryDestino.FieldByName('BLA_CODLIN').AsString := LimpaTexto(ArquivoText[5]);
  qryDestino.FieldByName('BLA_CODMON').AsString := LimpaTexto(ArquivoText[10]);
  qryDestino.FieldByName('BLA_ATIVAD').AsString := 'S';
  qryDestino.FieldByName('BLA_PROCHA').AsString := 'N';
  qryDestino.FieldByName('BLA_BASE' + TStrUtils.fStrZero(AContador, 2)).AsString := LimpaTexto(ArquivoText[14]);
  qryDestino.FieldByName('BLA_QTDB' + TStrUtils.fStrZero(AContador, 2)).AsFloat := fltQuantidade;
  qryDestino.Post;
end;

procedure TGravandoExecucaoBlascorAutomotivaCores.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM BLA_CADBLA        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoBlascorAutomotivaCores.IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
begin
  If ArquivoText[0] = 'codInterno' Then
    Exit(True);

  If Trim(ArquivoText[14]) = 'TH 10000' Then
    Exit(True);

  If Trim(ArquivoText[14]) = 'TH 040' Then
    Exit(True);

  Result := False;
end;

function TGravandoExecucaoBlascorAutomotivaCores.IsRegistroExistenteDiluentes(
  const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
begin
  If ArquivoText[0] = 'codInterno' Then
    Exit(True);

  If (Trim(ArquivoText[14]) <> 'TH 10000') And (Trim(ArquivoText[14]) <> 'TH 040') Then
    Exit(True);

  Result := False;
end;

procedure TGravandoExecucaoBlascorAutomotivaCores.pProcessarDiluentes(Const AGravando: IGravando);
Var
  qryDestino: IDataSet;
  Arquivo: TextFile;
  stlCsv: TStringList;
  strLinha: String;
  iRecordCount: Integer;
  intLinha: Integer;
  intQuantidade: Integer;
begin
  Try
    Try
      If (AGravando.Status <> sgGravando) Then
        Exit;

      AGravando.Texto := 'Carregando Diluentes...';
      iRecordCount := fContaLinhas(fGetPath);
      intLinha := 1;
      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;

      stlCsv := TStringList.Create();
      stlCsv.StrictDelimiter := True;
      stlCsv.Delimiter := ',';

      AssignFile(Arquivo, fGetPath);
      Reset(Arquivo);

      If (AGravando.Status <> sgGravando) Then
        Exit;

      AGravando.Texto := Format('Processando Diluentes: [%s]', [AnsiReplaceStr(fGetPath, '"', '')]);
      AGravando.RegistrarProgresso(0, 0, 0);

      While Not Eof(Arquivo) Do
      Begin
        If (AGravando.Status <> sgGravando) Then
          Break;

        ReadLn(Arquivo, strLinha);
        stlCsv.DelimitedText := strLinha;


        If Not IsRegistroExistenteDiluentes(qryDestino, stlCsv) Then
        Begin
          qryDestino.Close;
          qryDestino.SQL := GetSqlDestino;
          qryDestino.ParamByName('CODIGO').AsString := LimpaTexto(stlCsv[0]);
          qryDestino.Open;

          If qryDestino.IsEmpty Then
          Begin
            intQuantidade := 1;
            GravarRegistro(qryDestino, stlCsv, intQuantidade)
          End
          Else
          Begin
            intQuantidade := fRetQuantidade(qryDestino);
            EditarRegistro(qryDestino, stlCsv, intQuantidade);
          End;
        End;

        Inc(intLinha);
        AGravando.RegistrarProgresso(0, intLinha, iRecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        AGravando.Texto := strLinha;
        AGravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(stlCsv) Then FreeAndNil(stlCsv);
    CloseFile(Arquivo);
  End;
end;

procedure TGravandoExecucaoBlascorAutomotivaCores.pRemoveAddUniqueKey(
  blnRemover: Boolean);
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

procedure TGravandoExecucaoBlascorAutomotivaCores.pUpdateMD5KEYBlascor(
  const AGravando: IGravando);
Var
  qryGen: IDataSet;
  strMd5: String;
  intContador: Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT * FROM BLA_CADBLA ';
  qryGen.Open;
  qryGen.First;

  AGravando.Texto := 'Atualizando Md5Key...';

  While Not qryGen.Eof Do
  Begin
    strMd5 := '';
    strMd5 := strMd5 + qryGen.FieldByName('BLA_CODIGO').AsString;
    strMd5 := strMd5 + qryGen.FieldByName('BLA_CODUNI').AsString;
    strMd5 := strMd5 + qryGen.FieldByName('BLA_DESCRI').AsString;
    strMd5 := strMd5 + qryGen.FieldByName('BLA_ANOINI').AsString;
    strMd5 := strMd5 + qryGen.FieldByName('BLA_ANOFIM').AsString;
    strMd5 := strMd5 + qryGen.FieldByName('BLA_CODLIN').AsString;
    strMd5 := strMd5 + qryGen.FieldByName('BLA_CODMON').AsString;

    For intContador := 1 To 20 Do
    Begin
      strMd5 := strMd5 + qryGen.FieldByName('BLA_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
      strMd5 := strMd5 + qryGen.FieldByName('BLA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsString;
    End;

    qryGen.Edit;
    qryGen.FieldByName('BLA_MD5KEY').AsString := GetMD5(strMd5);
    qryGen.Post;

    qryGen.Next;
    AGravando.RegistrarProgresso(1, qryGen.RecNo, qryGen.RecordCount);
  End;
end;

end.
