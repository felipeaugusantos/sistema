{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta LechlerAutomotiva *}
{**********************************************************************PH*}
unit untGravandoExecucaoLechlerAutomotivaCores;

interface

uses
  untAbstractGravandoExecucaoLechlerAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  untIDicionario, Uni;

  type
    TGravandoExecucaoLechlerAutomotivaCores = class(TAbstractGravandoExecucaoLechlerAutomotiva)
  Private
    FQryBases: IDataSet;
    //Alteração MD5KEY
    FNameConsKey: String;
    FNameColumn: String;
    FNameBanco: String;
    FNameTable: String;
    function fRetRetConstraintUniqueKey(): String;
    Procedure pRemoveAddUniqueKey(blnRemover: Boolean);
    procedure DeletarMd5KeyDuplicado(Gravando :IGravando);

    procedure LimparTabelas;
    function fPodeGravar(ALinha: String): Boolean;
  Public
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function fGetPath(): String; override;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean; override;
    procedure GravarRegistro(const qryDestino: IDataSet; ALinha: String; const Gravando: IGravando); reintroduce;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

implementation

{ TGravandoExecucaoLechlerAutomotivaCores }

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


procedure TGravandoExecucaoLechlerAutomotivaCores.DeletarMd5KeyDuplicado(
  Gravando: IGravando);
Var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD,    ' +
                '        LCA_MD5KEY          ' +
                '   FROM LCA_CADLCA       ' +
                '  GROUP BY LCA_MD5KEY       ' +
                ' HAVING COUNT(*) > 1        ';

  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    Gravando.Texto := 'Excluindo arquivos duplicados LCA_CADLCA...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE                   ' +
                    '   FROM LCA_CADLCA     ' +
                    '  WHERE LCA_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('LCA_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);
      qryGen.Next;
    End;
  End;
end;

procedure TGravandoExecucaoLechlerAutomotivaCores.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  stlCsv: TStringList;
  intLinha: Integer;
  blnExcluir: Boolean;
  LArquivo: TStringList;
  LContador: Integer;
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

      If (blnExcluir) Then
      Begin
        Gravando.Texto := 'Deletando Registros da tabela LCA_CADLCA...';
        LimparTabelas();
      End;

      Gravando.Texto := 'Path verificado com sucesso...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('LCA_CADLCA');
      Gravando.Texto := 'PROCOD verificado com sucesso...';


      FQryBases := TAutcomTintaFactory.Get.fGetDataSet;
      FQryBases.Close;
      FQryBases.SQL := '  SELECT * FROM LCA_CADBAS  ';
      FQryBases.Open;

      If FQryBases.IsEmpty Then
      Begin
        Gravando.Texto := 'É necessario gerar o cadastro de bases para realizar a geração de fórmulas. Verifique!';
        Exit;
      End;

      Gravando.Texto := 'Carregando Dados...';
      intLinha := 0;
      qryDestino := GetDataSetDestino;

      stlCsv := TStringList.Create();
      LArquivo := TStringList.Create;
      LArquivo.LoadFromFile(fGetPath);

      If (Gravando.Status <> sgGravando) Then
        Exit;

      FNameConsKey := fRetRetConstraintUniqueKey;
      Gravando.Texto := 'Removendo UNIQUE KEY...';
      pRemoveAddUniqueKey(True);
      Gravando.Texto := 'UNIQUE KEY removida...';

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath(), '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      For LContador := 0 To LArquivo.Count - 1 Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        If Not fPodeGravar(LArquivo[LContador]) Then
          GravarRegistro(qryDestino, LArquivo[LContador], Gravando);

        Inc(intLinha);
        Gravando.RegistrarProgresso(0, intLinha, LArquivo.Count);
      End;
    Except
      On E: Exception Do
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
    If Assigned(stlCsv) Then FreeAndNil(stlCsv);
    If Assigned(LArquivo) Then FreeAndNil(LArquivo);

    DeletarMd5KeyDuplicado(Gravando);
    Gravando.Texto := 'Adicionando UNIQUE KEY...';
    pRemoveAddUniqueKey(False);
  End;
end;

function TGravandoExecucaoLechlerAutomotivaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoLechlerAutomotivaCores.fGetPath(): String;
begin
  Result := Conf.fGet('PATLCA');
end;

function TGravandoExecucaoLechlerAutomotivaCores.fPodeGravar(ALinha: String): Boolean;
begin
  If Trim(Copy(ALinha, 1, 10)) = 'RecordId' Then
    Exit(True);

  Result := False;
end;

function TGravandoExecucaoLechlerAutomotivaCores.fRetRetConstraintUniqueKey: String;
Var
  FQuery: TUniQuery;
  FSQL: String;
begin
  Try
    Try
      FQuery := TAutcomTintaFactory.Get.fCriaQuery();
      FNameColumn := 'LCA_MD5KEY';
      FNameTable := 'LCA_CADLCA';
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

function TGravandoExecucaoLechlerAutomotivaCores.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
begin
  Result := Nil;
end;

function TGravandoExecucaoLechlerAutomotivaCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM LCA_CADLCA  ';
end;

function TGravandoExecucaoLechlerAutomotivaCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoLechlerAutomotivaCores.GravarRegistro(const qryDestino: IDataSet; ALinha: String; const Gravando: IGravando);
Var
  LContador: Integer;
  LMd5Key: String;

  LStrCodBas,
  LStrQtdBas: String;
  LIndexBas,
  LIndexQtd: Integer;
  fltVolumeFormula: Double;
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LCA_CADLCA', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('LCA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('LCA_CODIGO').AsString := Trim(Copy(ALinha, 42, 50));
  qryDestino.FieldByName('LCA_DESCRI').AsString := Trim(Copy(ALinha, 115, 50));
  qryDestino.FieldByName('LCA_NOMCOR').AsString := Trim(Copy(ALinha, 607, 50));
  qryDestino.FieldByName('LCA_MONTAD').AsString := Trim(Copy(ALinha, 947, 120));
  qryDestino.FieldByName('LCA_REFCOR').AsString := Trim(Copy(ALinha, 1068, 16));
  qryDestino.FieldByName('LCA_VARIAN').AsString := Trim(Copy(ALinha, 1085, 50));

  LMd5Key := qryDestino.FieldByName('LCA_CODIGO').AsString +
             qryDestino.FieldByName('LCA_DESCRI').AsString +
             qryDestino.FieldByName('LCA_NOMCOR').AsString;

  LIndexBas := 166;
  LIndexQtd := 266;
  fltVolumeFormula := 0;


  For LContador := 1 To 10 Do
  Begin
    LStrCodBas := Trim(Copy(ALinha, LIndexBas, 9));
    LStrQtdBas := Trim(Copy(ALinha, LIndexQtd, 12));
    LStrQtdBas := AnsiReplaceStr(LStrQtdBas, '.', ',');

    If TStrUtils.fEmptyStr(Copy(ALinha, 166, 9)) Then
    Begin
      qryDestino.Delete;
      Exit;
    End;

    If TStrUtils.fEmptyStr(LStrCodBas) Then
      Break;

    If Not FQryBases.Locate('BAS_CODBAS', LStrCodBas, []) Then
    Begin
      Gravando.Texto := 'A base ' + LStrCodBas + ' não foi encontrada no cadastro de bases. Verifique! ';
      qryDestino.Delete;
      Exit;
    End;

    fltVolumeFormula := fltVolumeFormula + StrToFloat(LStrQtdBas);

    Inc(LIndexBas, 10);
    Inc(LindexQtd, 13);
  End;

  LIndexBas := 166;
  LIndexQtd := 266;

  For LContador := 1 To 10 Do
  Begin
    LStrCodBas := Trim(Copy(ALinha, LIndexBas, 9));
    LStrQtdBas := Trim(Copy(ALinha, LIndexQtd, 12));
    LStrQtdBas := AnsiReplaceStr(LStrQtdBas, '.', ',');

    If TStrUtils.fEmptyStr(Copy(ALinha, 166, 9)) Then
    Begin
      qryDestino.Delete;
      Exit;
    End;

    If TStrUtils.fEmptyStr(LStrCodBas) Then
      Break;

    If Not FQryBases.Locate('BAS_CODBAS', LStrCodBas, []) Then
    Begin
      Gravando.Texto := 'A base ' + LStrCodBas + ' não foi encontrada no cadastro de bases. Verifique! ';
      qryDestino.Delete;
      Exit;
    End;

    qryDestino.FieldByName('LCA_CODB' + TStrUtils.fStrZero(LContador, 2)).AsString := LStrCodBas;
    qryDestino.FieldByName('LCA_QTDB' + TStrUtils.fStrZero(LContador, 2)).AsFloat := (StrToFloat(LStrQtdBas) * FQryBases.FieldByName('BAS_PESESP').AsFloat) * 1000 / fltVolumeFormula;

    LMd5Key := LMd5Key + qryDestino.FieldByName('LCA_CODB' + TStrUtils.fStrZero(LContador, 2)).AsString +
                         qryDestino.FieldByName('LCA_QTDB' + TStrUtils.fStrZero(LContador, 2)).AsString;


    Inc(LIndexBas, 10);
    Inc(LindexQtd, 13);
  End;

  qryDestino.FieldByName('LCA_MD5KEY').AsString := GetMd5(LMd5Key);
  qryDestino.Post;
end;

function TGravandoExecucaoLechlerAutomotivaCores.IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
begin
  Result := False;
end;

procedure TGravandoExecucaoLechlerAutomotivaCores.LimparTabelas;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM LCA_CADLCA;';
  qryGen.ExecSQL;
end;


procedure TGravandoExecucaoLechlerAutomotivaCores.pRemoveAddUniqueKey(
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

end.
