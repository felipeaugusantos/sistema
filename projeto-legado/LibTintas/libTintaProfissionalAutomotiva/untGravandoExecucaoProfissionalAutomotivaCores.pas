{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta ProfissionalAutomotiva *}
{**********************************************************************PH*}
unit untGravandoExecucaoProfissionalAutomotivaCores;

interface

uses
  untAbstractGravandoExecucaoProfissionalAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  untIDicionario, Uni;

  type
    TGravandoExecucaoProfissionalAutomotivaCores = class(TAbstractGravandoExecucaoProfissionalAutomotiva)
  Private
    intColorante: Integer;
    //Alteração MD5KEY
    FNameConsKey: String;
    FNameColumn: String;
    FNameBanco: String;
    FNameTable: String;
    function fRetRetConstraintUniqueKey(): String;
    Procedure pRemoveAddUniqueKey(blnRemover: Boolean);
    procedure DeletarMd5KeyDuplicado(Gravando :IGravando);
    procedure PreencherMd5Key(Gravando: IGravando);
    procedure LimparTabelas;
    procedure pGravarCadastroCores(const Gravando: IGravando; AQryDestino: IDataSet; AContador: Integer);
  Public
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetSqlDestino(): string; override;
    function fGetPath(intPasta: Integer): String; Override;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean; Override;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList); Reintroduce;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

implementation

{ TGravandoExecucaoProfissionalAutomotivaCores }

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;


procedure TGravandoExecucaoProfissionalAutomotivaCores.DeletarMd5KeyDuplicado(
  Gravando: IGravando);
Var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD,    ' +
                '        PFA_MD5KEY          ' +
                '   FROM PFA_CADPFA       ' +
                '  GROUP BY PFA_MD5KEY       ' +
                ' HAVING COUNT(*) > 1        ';

  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    Gravando.Texto := 'Excluindo arquivos duplicados PFA_CADPFA...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE                   ' +
                    '   FROM PFA_CADPFA     ' +
                    '  WHERE PFA_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('PFA_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);
      qryGen.Next;
    End;
  End;
end;

procedure TGravandoExecucaoProfissionalAutomotivaCores.Executar(const gravando: IGravando);
Var
  qryDestino: IDataSet;
  blnExcluir: Boolean;
  intContador: Integer;
begin
  Try
    Try
      blnExcluir := True;
      For intContador := 0 To FPastas.Count - 1 Do
      Begin
        ListarArquivo(Conf.fGet('PATPFA') + '\' + FPastas[intContador]);

        Gravando.Texto := 'Verificando Path do arquivo...';

        If Not fValidarPath(intContador) Then
        Begin
          Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
          Exit;
        End;

        If (Gravando.Status <> sgGravando) Then
          Exit;

        If (blnExcluir) Then
        Begin
          Gravando.Texto := 'Deletando Registros da tabela PFA_CADPFA...';
          LimparTabelas;
          FNameConsKey := fRetRetConstraintUniqueKey;
          Gravando.Texto := 'Removendo UNIQUE KEY...';
          pRemoveAddUniqueKey(True);
          Gravando.Texto := 'UNIQUE KEY removida...';
          blnExcluir := False;
        End;

        pCarregarBases(Gravando, intContador);
        Gravando.Texto := 'Path verificado com sucesso...';
        Gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('PFA_CADPFA');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        qryDestino := GetDataSetDestino;
        pCarregarCores(Gravando, fGetPath(intContador));

        Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath(intContador), '"', '')]);
        Gravando.RegistrarProgresso(0, 0, 0);
        pGravarCadastroCores(Gravando, qryDestino, intContador);
      End;
    Except
      On E: Exception Do
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
    PreencherMd5Key(Gravando);
    DeletarMd5KeyDuplicado(Gravando);
    Gravando.Texto := 'Adicionando UNIQUE KEY...';
    pRemoveAddUniqueKey(False);
  End;
end;

function TGravandoExecucaoProfissionalAutomotivaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoProfissionalAutomotivaCores.fGetPath(intPasta: Integer): String;
begin
  Result := Conf.fGet('PATPFA') + '\' + FPastas[intPasta] +  '\' + FNomeArqFormulas
end;

function TGravandoExecucaoProfissionalAutomotivaCores.fRetRetConstraintUniqueKey: String;
Var
  FQuery: TUniQuery;
  FSQL: String;
begin
  Try
    Try
      FQuery := TAutcomTintaFactory.Get.fCriaQuery();
      FNameColumn := 'PFA_MD5KEY';
      FNameTable := 'PFA_CADPFA';
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

function TGravandoExecucaoProfissionalAutomotivaCores.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
begin
  Result := Nil;
end;

function TGravandoExecucaoProfissionalAutomotivaCores.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM PFA_CADPFA  ';
end;

function TGravandoExecucaoProfissionalAutomotivaCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoProfissionalAutomotivaCores.GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList);
Var
  LQuantidade: String;
  LDescri: String;
begin
  LDescri := Trim(Copy(ArquivoText[4], Pos('-', ArquivoText[4]) + 1, Length(ArquivoText[4])));

  If Not qryDestino.Locate('PFA_CODIGO;PFA_DESCRI;PFA_NOMCOR;PFA_LINHA_',
    VarArrayOf([LimpaTexto(ArquivoText[2]),
                LimpaTexto(LDescri),
                LimpaTexto(ArquivoText[3]),
                LimpaTexto(ArquivoText[0])]), []) Then
  Begin
    intColorante := 1;

    qryDestino.Insert;
    qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PFA_CADPFA', TAutcomTintaFactory.Get.GetCodEmp);
    qryDestino.FieldByName('PFA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryDestino.FieldByName('PFA_LINHA_').AsString := LimpaTexto(ArquivoText[0]);
    qryDestino.FieldByName('PFA_CODIGO').AsString := LimpaTexto(ArquivoText[2]);
    qryDestino.FieldByName('PFA_NOMCOR').AsString := LimpaTexto(ArquivoText[3]);
    qryDestino.FieldByName('PFA_TIPLIN').AsString := LimpaTexto(ArquivoText[1]);
    qryDestino.FieldByName('PFA_DESCRI').AsString := LimpaTexto(LDescri);
    qryDestino.FieldByName('PFA_ATIVAD').AsString := 'S';



    LQuantidade :=  AnsiReplaceStr(ArquivoText[10], ',', '');
    LQuantidade :=  AnsiReplaceStr(LQuantidade, '.', ',');

    qryDestino.FieldByName('PFA_CODB' + TStrUtils.fStrZero(intColorante, 2)).AsString := cdsBases.FieldByName('BASE').AsString;
    qryDestino.FieldByName('PFA_QTDB' + TStrUtils.fStrZero(intColorante, 2)).AsFloat  := StrToFloat(LQuantidade) * cdsBases.FieldByName('PESESP').AsFloat;
    qryDestino.Post;
  End
  Else
  Begin
    intColorante := intColorante + 1;

    LQuantidade :=  AnsiReplaceStr(ArquivoText[10], ',', '');
    LQuantidade :=  AnsiReplaceStr(LQuantidade, '.', ',');

    qryDestino.Edit;
    qryDestino.FieldByName('PFA_CODB' + TStrUtils.fStrZero(intColorante, 2)).AsString := cdsBases.FieldByName('BASE').AsString;
    qryDestino.FieldByName('PFA_QTDB' + TStrUtils.fStrZero(intColorante, 2)).AsFloat  := StrToFloat(LQuantidade) * cdsBases.FieldByName('PESESP').AsFloat;
    qryDestino.Post;
  End;
end;

function TGravandoExecucaoProfissionalAutomotivaCores.IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean;
begin
  If ArquivoText[0] = 'LINHA' Then
    Exit(True);

  If ArquivoText[7] <> '900' Then
    Exit(True);

  Result := False;
end;

procedure TGravandoExecucaoProfissionalAutomotivaCores.LimparTabelas;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM PFA_CADPFA;';
  qryGen.ExecSQL;
end;


procedure TGravandoExecucaoProfissionalAutomotivaCores.pGravarCadastroCores(const Gravando: IGravando; AQryDestino: IDataSet; AContador: Integer);
Var
  qryCorBas: IDataSet;
  qryCorPig: IDataSet;
  fltVolMls: Double;
  LQuantidade: Double;
  intQuantidade: Integer;
  qryGen: IDataSet;
begin
  qryCorBas := TAutcomTintaFactory.Get.fGetDataSet;
  qryCorPig := TAutcomTintaFactory.Get.fGetDataSet;
  Gravando.Texto := 'Gravando Cores...';

  qryCorBas.Close;
  qryCorBas.SQL := 'SELECT * FROM TMP_CORES_PFA WHERE PFA_TIPPRO = "BASE"; ';
  qryCorBas.Open;


  While Not qryCorBas.Eof Do
  Begin
    qryCorPig.SQL := 'SELECT * FROM TMP_CORES_PFA WHERE  ' +
                     ' PFA_LINHA_ = :LINHA_ AND          ' +
                     ' PFA_CODCOR = :CODCOR AND          ' +
                     ' PFA_NOMCOR = :NOMCOR AND          ' +
                     ' PFA_PRODUT = :PRODUT AND          ' +
                     ' PFA_TIPPRO <> :TIPPRO;            ';

    qryCorPig.ParamByName('LINHA_').AsString := qryCorBas.FieldByName('PFA_LINHA_').AsString;
    qryCorPig.ParamByName('CODCOR').AsString := qryCorBas.FieldByName('PFA_CODCOR').AsString;
    qryCorPig.ParamByName('NOMCOR').AsString := qryCorBas.FieldByName('PFA_NOMCOR').AsString;
    qryCorPig.ParamByName('PRODUT').AsString := qryCorBas.FieldByName('PFA_PRODUT').AsString;
    qryCorPig.ParamByName('TIPPRO').AsString := 'CATALISADOR';
    qryCorPig.Open;
    qryCorPig.First;

    fltVolMls := 0;
    intQuantidade := 1;


    While Not qryCorPig.Eof Do
    Begin
      fltVolMls := fltVolMls + qryCorPig.FieldByName('PFA_QTDMLS').AsFloat;
      qryCorPig.Next;
    End;

    qryCorPig.First;

    While Not qryCorPig.Eof Do
    Begin
      If Not cdsBases.Locate('TIPO;COD_PRODUTO', VarArrayOf([qryCorPig.FieldByName('PFA_TIPPRO').AsString, qryCorPig.FieldByName('PFA_CODPRO').AsString]), []) Then
        Break;

      If (Gravando.Status <> sgGravando) Then
          Break;

      If intQuantidade = 1 Then
      Begin
        AQryDestino.Insert;
        AQryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PFA_CADPFA', TAutcomTintaFactory.Get.GetCodEmp);
        AQryDestino.FieldByName('PFA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        AQryDestino.FieldByName('PFA_LINHA_').AsString := qryCorPig.FieldByName('PFA_LINHA_').AsString;
        AQryDestino.FieldByName('PFA_CODIGO').AsString := qryCorPig.FieldByName('PFA_CODCOR').AsString;
        AQryDestino.FieldByName('PFA_NOMCOR').AsString := qryCorPig.FieldByName('PFA_NOMCOR').AsString;
        AQryDestino.FieldByName('PFA_TIPLIN').AsString := qryCorPig.FieldByName('PFA_TIPLIN').AsString;
        AQryDestino.FieldByName('PFA_DESCRI').AsString := qryCorPig.FieldByName('PFA_PRODUT').AsString;
        AQryDestino.FieldByName('PFA_ATIVAD').AsString := 'S';

        LQuantidade :=  qryCorPig.FieldByName('PFA_QTDMLS').AsFloat * (900 / fltVolMls);
        LQuantidade :=  LQuantidade * cdsBases.FieldByName('PESESP').AsFloat;
        AQryDestino.FieldByName('PFA_CODB' + TStrUtils.fStrZero(intQuantidade, 2)).AsString := cdsBases.FieldByName('BASE').AsString;
        AQryDestino.FieldByName('PFA_QTDB' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat  := LQuantidade;
        AQryDestino.Post;
      End
      Else
      Begin
        LQuantidade :=  qryCorPig.FieldByName('PFA_QTDMLS').AsFloat * (900 / fltVolMls);
        LQuantidade :=  LQuantidade * cdsBases.FieldByName('PESESP').AsFloat;

        AQryDestino.Edit;
        AQryDestino.FieldByName('PFA_CODB' + TStrUtils.fStrZero(intQuantidade, 2)).AsString := cdsBases.FieldByName('BASE').AsString;
        AQryDestino.FieldByName('PFA_QTDB' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat  := LQuantidade;
        AQryDestino.Post;
      End;

      Inc(intQuantidade);
      qryCorPig.Next;
    End;

    qryCorBas.Next;
    Gravando.RegistrarProgresso(0, qryCorBas.RecNo, qryCorBas.RecordCount);
  End;

  qryCorBas.First;
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  Gravando.Texto := 'Gravando Quantidade Catalisadores...';

  While Not qryCorBas.Eof Do
  Begin
    qryCorPig.SQL := 'SELECT * FROM TMP_CORES_PFA WHERE  ' +
                     ' PFA_LINHA_ = :LINHA_ AND          ' +
                     ' PFA_CODCOR = :CODCOR AND          ' +
                     ' PFA_NOMCOR = :NOMCOR AND          ' +
                     ' PFA_PRODUT = :PRODUT AND          ' +
                     ' PFA_TIPPRO = :TIPPRO;            ';

    qryCorPig.ParamByName('LINHA_').AsString := qryCorBas.FieldByName('PFA_LINHA_').AsString;
    qryCorPig.ParamByName('CODCOR').AsString := qryCorBas.FieldByName('PFA_CODCOR').AsString;
    qryCorPig.ParamByName('NOMCOR').AsString := qryCorBas.FieldByName('PFA_NOMCOR').AsString;
    qryCorPig.ParamByName('PRODUT').AsString := qryCorBas.FieldByName('PFA_PRODUT').AsString;
    qryCorPig.ParamByName('TIPPRO').AsString := 'CATALISADOR';
    qryCorPig.Open;
    qryCorPig.First;

    If qryCorPig.IsEmpty Then
    Begin
      qryCorBas.Next;
      Gravando.RegistrarProgresso(0, qryCorBas.RecNo, qryCorBas.RecordCount);
      Continue;
    End;

    qryGen.Close;
    qryGen.SQL := 'SELECT * FROM PFA_CADPFA WHERE ' +
                     ' PFA_LINHA_ = :LINHA_ AND          ' +
                     ' PFA_CODIGO = :CODCOR AND          ' +
                     ' PFA_NOMCOR = :NOMCOR AND          ' +
                     ' PFA_DESCRI = :PRODUT              ';

    qryGen.ParamByName('LINHA_').AsString := qryCorBas.FieldByName('PFA_LINHA_').AsString;
    qryGen.ParamByName('CODCOR').AsString := qryCorBas.FieldByName('PFA_CODCOR').AsString;
    qryGen.ParamByName('NOMCOR').AsString := qryCorBas.FieldByName('PFA_NOMCOR').AsString;
    qryGen.ParamByName('PRODUT').AsString := qryCorBas.FieldByName('PFA_PRODUT').AsString;
    qryGen.Open;

    qryGen.Edit;
    qryGen.FieldByName('PFA_QTDCAT').AsFloat := qryCorPig.FieldByName('PFA_QTDMLS').AsFloat;
    qryGen.Post;

    qryCorBas.Next;
    Gravando.RegistrarProgresso(0, qryCorBas.RecNo, qryCorBas.RecordCount);
  End;

end;

procedure TGravandoExecucaoProfissionalAutomotivaCores.PreencherMd5Key(
  Gravando: IGravando);
Var
  LqryGen: IDataSet;
  LMd5Key: String;
  LContador: Integer;
begin
  LqryGen := TAutcomTintaFactory.Get.fGetDataSet;
  LqryGen.SQL := 'SELECT * FROM PFA_CADPFA ';
  LqryGen.Open;

  Gravando.Texto := 'Gravando md5...';
  LqryGen.First;

  While Not LqryGen.Eof Do
  Begin
    LMd5Key := '';
    LMd5Key := LMd5Key + LqryGen.FieldByName('PFA_CODIGO').AsString +
                         LqryGen.FieldByName('PFA_NOMCOR').AsString +
                         LqryGen.FieldByName('PFA_DESCRI').AsString +
                         LqryGen.FieldByName('PFA_LINHA_').AsString +
                         LqryGen.FieldByName('PFA_TIPLIN').AsString;

    For LContador := 1 To 20 Do
    Begin
      LMd5Key := LMd5Key + LqryGen.FieldByName('PFA_CODB' + TStrUtils.fStrZero(LContador, 2)).AsString;
      LMd5Key := LMd5Key + LqryGen.FieldByName('PFA_QTDB' + TStrUtils.fStrZero(LContador, 2)).AsString;
    End;

    LqryGen.Edit;
    LqryGen.FieldByName('PFA_MD5KEY').AsString := GetMD5(LMd5Key);
    LqryGen.Post;

    LqryGen.Next;
    Gravando.RegistrarProgresso(0, LqryGen.RecNo, LqryGen.RecordCount);
  End;
end;

procedure TGravandoExecucaoProfissionalAutomotivaCores.pRemoveAddUniqueKey(
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


