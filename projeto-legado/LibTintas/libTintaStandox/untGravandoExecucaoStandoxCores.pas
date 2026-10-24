{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Standox *}
{**********************************************************************PH*}
unit untGravandoExecucaoStandoxCores;

interface

uses
  untAbstractGravandoExecucaoStandox, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela, ADODB,
  StrUtils, untTipoCadastro, untFloatUtils, Classes, Math, Uni,UniClientDataSet,
  InterBaseUniProvider, UniDataSetProvider;

type
  TGravandoExecucaoStandoxCores = class(TAbstractGravandoExecucaoStandox)
  private
    cdsMd5: TUniClientDataSet;
    function fGerarStandoxTipoUm(qryCadDox: IDataSet; stlFormulas: TStringList; Gravando: IGravando; Var intTipoUm: Integer): Boolean;
    function fGerarStandoxTipoDois(qryCadDox: IDataSet; stlFormulas: TStringList; Gravando: IGravando; Var intTipoUm: Integer): Boolean;
    function fGerarStandoxEuropeTipoUm(qryCadDox: IDataSet; stlFormulas: TStringList; Gravando: IGravando; Var intTipoUm: Integer): Boolean;
    function fGerarStandoxEuropeTipoDois(qryCadDox: IDataSet; stlFormulas: TStringList; Gravando: IGravando; Var intTipoUm: Integer): Boolean;
    function fGetSelect():String;
    procedure ExecutarEurope(const gravando: IGravando);
    procedure DeletarMD5DuplicadoStandox(Gravando:IGravando);
  public

    constructor Create(const strCodNfm: string = '');
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoStandoxCores }

constructor TGravandoExecucaoStandoxCores.Create(const strCodNfm: string);
begin
  inherited Create();
end;

procedure TGravandoExecucaoStandoxCores.DeletarMD5DuplicadoStandox(
  Gravando: IGravando);
Var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD, ' +
                '        DOX_MD5KEY       ' +
                '   FROM DOX_CADDOX       ' +
                '  GROUP BY DOX_MD5KEY    ' +
                ' HAVING COUNT(*) > 1     ';
  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    Gravando.Texto := 'Excluindo registros duplicados...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE '+
                    '   FROM DOX_CADDOX ' +
                    '  WHERE DOX_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);
      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('DOX_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);

      qryGen.Next;
    End;
  End;

end;

procedure TGravandoExecucaoStandoxCores.Executar(const gravando: IGravando);
Var
  stlFormulas: TStringList;
  qryCadDox: IDataSet;
  IntTipoUm: Integer;
  strLinha:String;
  txtArq: TextFile;
begin
  Gravando.Texto := 'Verificando Path do arquivo Brazil.txt...';

  If Not fValidaPath Then
  Begin
    Gravando.Texto := Format('O arquivo %s não existe!', [AnsiReplaceStr(GetPath, '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Path verificado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  cdsMd5 := TUniClientDataSet.Create(Nil);
  With cdsMd5.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MD5KEY';
    DataType := ftString;
    Size := 32;
  End;
  cdsMd5.CreateDataSet;

  Try
    Try
      IntTipoUm := 0;
      Gravando.Texto := ' Deletando Cadastro de Fórmulas...';
      qryCadDox := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadDox.SQL := '  DELETE FROM DOX_CADDOX  ';
      qryCadDox.ExecSQL;
      Gravando.Texto := ' Cadastro de Fórmulas deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DOX_CADDOX');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      If (Gravando.Status <> sgGravando) Then
        Exit;

      stlFormulas := TStringList.Create;
      AssignFile(txtArq, GetPath);
      Reset(txtArq);

      While Not Eof(txtArq) Do
      Begin
        ReadLn(txtArq, strLinha);
        stlFormulas.Add(strLinha);
      End;
      CloseFile(txtArq);

      qryCadDox.SQL.Empty;
      qryCadDox.SQL := fGetSelect;

      If Not fGerarStandoxTipoUm(qryCadDox, stlFormulas, Gravando, intTipoUm) Then
        Exit;

      If Not fGerarStandoxTipoDois(qryCadDox, stlFormulas, Gravando, IntTipoUm) Then
        Exit;


    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(stlFormulas) Then
      FreeAndNil(stlFormulas);
    If Assigned(cdsMd5) Then
      FreeAndNil(cdsMd5);
  End;

  Try
    If Conf.fGet('DOXARQ') = '1' Then
      ExecutarEurope(Gravando);
  Except
    Raise;
  End;

  Gravando.Texto := 'Verificando registros duplicados...';

  DeletarMD5DuplicadoStandox(Gravando);

  Gravando.Texto := Format('Cadastro de %s processado com sucesso!', ['Formulas']);


end;

procedure TGravandoExecucaoStandoxCores.ExecutarEurope(
  const gravando: IGravando);
Var
  stlFormulas: TStringList;
  qryCadDox: IDataSet;
  IntTipoUm: Integer;
  strLinha:String;
  txtArq: TextFile;
begin
  Gravando.Texto := 'Verificando Path do arquivo Europe...';

  If Not fValidaPathEurope Then
  Begin
    Gravando.Texto := Format('O arquivo %s não existe!',[AnsiReplaceStr(GetPathEur, '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Path verificado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  cdsMd5 := TUniClientDataSet.Create(Nil);
  With cdsMd5.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MD5KEY';
    DataType := ftString;
    Size := 32;
  End;
  cdsMd5.CreateDataSet;

  Try
    Try
      IntTipoUm := 0;
      Gravando.Texto := Format('Processando Arquivos: [%s]', [AnsiReplaceStr(GetPathEur, '"', '')]);

      stlFormulas := TStringList.Create;
      AssignFile(txtArq, GetPathEur);
      Reset(txtArq);

      While Not Eof(txtArq) Do
      Begin
        ReadLn(txtArq, strLinha);
        stlFormulas.Add(strLinha);
      End;
      CloseFile(txtArq);

      qryCadDox := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadDox.SQL := fGetSelect;

      If Not fGerarStandoxEuropeTipoUm(qryCadDox, stlFormulas, Gravando, intTipoUm) Then
        Exit;

      If Not fGerarStandoxEuropeTipoDois(qryCadDox, stlFormulas, Gravando, IntTipoUm) Then
        Exit;

    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(stlFormulas) Then
      FreeAndNil(stlFormulas);

    If Assigned(cdsMd5) Then
      FreeAndNil(cdsMd5);
  End;


end;

function TGravandoExecucaoStandoxCores.fGerarStandoxEuropeTipoDois(
  qryCadDox: IDataSet; stlFormulas: TStringList; Gravando: IGravando;
  var intTipoUm: Integer): Boolean;
Var
  strMontad,
  strCodigo,
  strDescri,
  strVersao,
  strAnoIni,
  strAnoFin,
  strPainel,
  strCatego,
  strPais,
  strVarian,
  strQualidade,
  strInfCor,
  strBase,
  strLinha: String;
  intCodSeq,
  intBase,
  intContador,
  intLinha: Integer;
  blnStandBlue:Boolean;
  qryGen: IDataSet;
begin
  Result := True;
  blnStandBlue := False;
  strBase := '';
  intLinha := 0;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '     SELECT MAX(DOX_CODSEQ) AS CODSEQ     ' +
                '       FROM DOX_CADDOX                    ' +
                '     WHERE DOX_CODEMP = :EMPRESA          ';
  qryGen.ParamByName('EMPRESA').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryGen.Open;

  intCodSeq := qryGen.FieldByName('CODSEQ').AsInteger;

  While (intLinha < stlFormulas.Count) Do
  Begin

    If (Gravando.Status <> sgGravando) Then
      Break;

    strLinha          := stlFormulas[intLinha];
    strMontad         := Trim(fRetCampoBas('MONTAD', intLinha, strLinha));
    strCodigo         := Trim(fRetCampoBas('CODIGO', intLinha, strLinha));
    strDescri         := Trim(fRetCampoBas('DESCRI', intLinha, strLinha));
    strVersao         := Trim(fRetCampoBas('VERSAO', intLinha, strLinha));
    strAnoIni         := Trim(fRetCampoBas('ANOINI', intLinha, strLinha));
    strAnoFin         := Trim(fRetCampoBas('ANOFIN', intLinha, strLinha));
    strPainel         := Trim(fRetCampoBas('PAINEL', intLinha, strLinha));
    strCatego         := Trim(fRetCampoBas('CATEGO', intLinha, strLinha));
    strPais           := Trim(fRetCampoBas('PAIS', intLinha, strLinha));
    strVarian         := Trim(fRetCampoBas('VARIAN', intLinha, strLinha));
    strQualidade      := Trim(fRetCampoBas('QUALID', intLinha, strLinha));
    strInfCor         := Trim(fRetCampoBas('INFCOR', intLinha, strLinha));

    If (strQualidade <> 'STANDOBLUE BASECOAT') Then
    Begin
      If (Pos('0', strMontad) <= 0) And (Not TStrUtils.fEmptyStr(strMontad)) Then
      Begin
        Inc(intCodSeq);

        qryCadDox.Close;
        qryCadDox.ParamByName('DOX_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq+1, 6);
        qryCadDox.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DOX_CADDOX', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadDox.ParamByName('DOX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadDox.ParamByName('DOX_CODDOX').AsString := strCodigo;
        qryCadDox.ParamByName('DOX_MONTAD').AsString := strMontad;
        qryCadDox.ParamByName('DOX_DESCRI').AsString := strDescri;
        qryCadDox.ParamByName('DOX_VERSAO').AsString := strVersao;
        qryCadDox.ParamByName('DOX_ANOINI').AsString := strAnoIni;
        qryCadDox.ParamByName('DOX_ANOFIN').AsString := strAnoFin;
        qryCadDox.ParamByName('DOX_PAINEL').AsString := strPainel;
        qryCadDox.ParamByName('DOX_CATEGO').AsString := strCatego;
        qryCadDox.ParamByName('DOX_PAIS__').AsString := strPais;
        qryCadDox.ParamByName('DOX_VARIAN').AsString := strVarian;
        qryCadDox.ParamByName('DOX_QUALID').AsString := strQualidade;
        qryCadDox.ParamByName('DOX_INFCOR').AsString := strInfCor;
        qryCadDox.ParamByName('DOX_ATIVO_').AsString := 'S';

        intBase := 0;
        For intContador := 0 To 19 Do
        Begin

          qryCadDox.ParamByName('DOX_BASE' + TStrUtils.fStrZero(intContador+1, 2)).AsString := '';
          qryCadDox.ParamByName('DOX_QTDC' + TStrUtils.fStrZero(intContador+1, 2)).AsFloat  := 0.0;

          strBase := fRetCampoBas('CODBAS', intContador+1, strLinha);

          If Pos('STBLUE', strBase) > 0 Then
          Begin
            qryCadDox.ParamByName('DOX_BASE' + TStrUtils.fStrZero(intBase+1, 2)).AsString := fRetCampoBas('CODBAS', intContador+1, strLinha);
            qryCadDox.ParamByName('DOX_QTDC' + TStrUtils.fStrZero(intBase+1, 2)).AsFloat  :=
              TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(fRetCampoBas('QTDBAS', intContador+1, strLinha), '.', ','));

            Inc(intBase);
            blnStandBlue := True;
          End;
        End;

        qryCadDox.ParamByName('DOX_MD5KEY').AsString := GetMD5(qryCadDox.ParamByName('DOX_MONTAD').AsString + qryCadDox.ParamByName('DOX_CODDOX').AsString +
                                                               qryCadDox.ParamByName('DOX_DESCRI').AsString + qryCadDox.ParamByName('DOX_VERSAO').AsString +
                                                               qryCadDox.ParamByName('DOX_ANOINI').AsString + qryCadDox.ParamByName('DOX_ANOFIN').AsString +
                                                               qryCadDox.ParamByName('DOX_PAINEL').AsString + qryCadDox.ParamByName('DOX_CATEGO').AsString +
                                                               qryCadDox.ParamByName('DOX_PAIS__').AsString + qryCadDox.ParamByName('DOX_VARIAN').AsString +
                                                               qryCadDox.ParamByName('DOX_QUALID').AsString + qryCadDox.ParamByName('DOX_INFCOR').AsString +
              qryCadDox.ParamByName('DOX_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC01').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC02').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC03').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC04').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC05').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC06').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC07').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC08').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC09').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC10').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC11').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC12').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC13').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC14').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC15').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC16').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC17').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC18').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC19').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC20').AsFloat), ',', '.'));

        If blnStandBlue Then
        Begin
          If Not cdsMd5.Locate('MD5KEY', qryCadDox.ParamByName('DOX_MD5KEY').AsString, []) Then
          Begin
            qryCadDox.ExecSQL;

            cdsMd5.Append;
            cdsMd5.FieldByName('MD5KEY').AsString := qryCadDox.ParamByName('DOX_MD5KEY').AsString;
            cdsMd5.Post;
          End;

          blnStandBlue := False;
        End;
        Gravando.RegistrarProgresso(0, intLinha, stlFormulas.Count);
      End;
    End;
    Inc(intLinha);
  End;


end;

function TGravandoExecucaoStandoxCores.fGerarStandoxEuropeTipoUm(
  qryCadDox: IDataSet; stlFormulas: TStringList; Gravando: IGravando;
  var intTipoUm: Integer): Boolean;
Var
  strMontad,
  strCodigo,
  strDescri,
  strVersao,
  strAnoIni,
  strAnoFin,
  strPainel,
  strCatego,
  strPais,
  strVarian,
  strQualidade,
  strLinha,
  strInfCor: String;
  intLinha,
  intContador,
  IntCodSeq: Integer;
  qryGen:IDataSet;
begin
  Result := True;
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT MAX(DOX_CODSEQ) AS CODSEQ  ' +
              '     FROM DOX_CADDOX WHERE           ' +
              '   DOX_CODEMP = :EMPRESA             ';
  qryGen.ParamByName('EMPRESA').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryGen.Open;

  intCodSeq := qryGen.FieldByName('CODSEQ').AsInteger;
  intLinha := 0;

  While (intLinha < stlFormulas.Count) Do
  Begin

    If (Gravando.Status <> sgGravando) Then
      Break;

    If qryCadDox.IsEmpty Then
    Begin
      strLinha          := stlFormulas[intLinha];
      strMontad         := Trim(fRetCampoBas('MONTAD', intLinha, strLinha));
      strCodigo         := Trim(fRetCampoBas('CODIGO', intLinha, strLinha));
      strDescri         := Trim(fRetCampoBas('DESCRI', intLinha, strLinha));
      strVersao         := Trim(fRetCampoBas('VERSAO', intLinha, strLinha));
      strAnoIni         := Trim(fRetCampoBas('ANOINI', intLinha, strLinha));
      strAnoFin         := Trim(fRetCampoBas('ANOFIN', intLinha, strLinha));
      strPainel         := Trim(fRetCampoBas('PAINEL', intLinha, strLinha));
      strCatego         := Trim(fRetCampoBas('CATEGO', intLinha, strLinha));
      strPais           := Trim(fRetCampoBas('PAIS', intLinha, strLinha));
      strVarian         := Trim(fRetCampoBas('VARIAN', intLinha, strLinha));
      strQualidade      := Trim(fRetCampoBas('QUALID', intLinha, strLinha));
      strInfCor         := Trim(fRetCampoBas('INFCOR', intLinha, strLinha));

      If (Pos('0', strMontad) <= 0) And Not (TStrUtils.fEmptyStr(strMontad)) Then
      Begin
        Inc(intCodSeq);

        qryCadDox.Close;
        qryCadDox.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DOX_CADDOX', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadDox.ParamByName('DOX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadDox.ParamByName('DOX_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq+1, 6);
        qryCadDox.ParamByName('DOX_MONTAD').AsString := strMontad;
        qryCadDox.ParamByName('DOX_CODDOX').AsString := strCodigo;
        qryCadDox.ParamByName('DOX_DESCRI').AsString := strDescri;
        qryCadDox.ParamByName('DOX_VERSAO').AsString := strVersao;
        qryCadDox.ParamByName('DOX_ANOINI').AsString := strAnoIni;
        qryCadDox.ParamByName('DOX_ANOFIN').AsString := strAnoFin;
        qryCadDox.ParamByName('DOX_PAINEL').AsString := strPainel;
        qryCadDox.ParamByName('DOX_CATEGO').AsString := strCatego;
        qryCadDox.ParamByName('DOX_PAIS__').AsString := strPais;
        qryCadDox.ParamByName('DOX_VARIAN').AsString := strVarian;
        qryCadDox.ParamByName('DOX_QUALID').AsString := strQualidade;
        qryCadDox.ParamByName('DOX_INFCOR').AsString := strInfCor;
        qryCadDox.ParamByName('DOX_ATIVO_').AsString := 'S';

        For intContador := 0 To 19 Do
        Begin
          qryCadDox.ParamByName('DOX_BASE' + TStrUtils.fStrZero(intContador+1, 2)).AsString := fRetCampoBas('CODBAS', intContador+1, strLinha);
          qryCadDox.ParamByName('DOX_QTDC' + TStrUtils.fStrZero(intContador+1, 2)).AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(fRetCampoBas('QTDBAS', intContador+1, strLinha), '.', ','));
        End;

        qryCadDox.ParamByName('DOX_MD5KEY').AsString := GetMD5(qryCadDox.ParamByName('DOX_MONTAD').AsString + qryCadDox.ParamByName('DOX_CODDOX').AsString +
                                                               qryCadDox.ParamByName('DOX_DESCRI').AsString + qryCadDox.ParamByName('DOX_VERSAO').AsString +
                                                               qryCadDox.ParamByName('DOX_ANOINI').AsString + qryCadDox.ParamByName('DOX_ANOFIN').AsString +
                                                               qryCadDox.ParamByName('DOX_PAINEL').AsString + qryCadDox.ParamByName('DOX_CATEGO').AsString +
                                                               qryCadDox.ParamByName('DOX_PAIS__').AsString + qryCadDox.ParamByName('DOX_VARIAN').AsString +
                                                               qryCadDox.ParamByName('DOX_QUALID').AsString + qryCadDox.ParamByName('DOX_INFCOR').AsString +
              qryCadDox.ParamByName('DOX_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC01').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC02').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC03').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC04').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC05').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC06').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC07').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC08').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC09').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC10').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC11').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC12').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC13').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC14').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC15').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC16').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC17').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC18').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC19').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC20').AsFloat), ',', '.'));

        If Not cdsMd5.Locate('MD5KEY', qryCadDox.ParamByName('DOX_MD5KEY').AsString, []) Then
        Begin
          qryCadDox.ExecSQL;

          cdsMd5.Append;
          cdsMd5.FieldByName('MD5KEY').AsString := qryCadDox.ParamByName('DOX_MD5KEY').AsString;
          cdsMd5.Post;
        End;
        Gravando.RegistrarProgresso(0, intLinha, stlFormulas.Count);
      End;

    End;
    Inc(IntLinha);
  End;

  intTipoUm := intLinha;
end;

function TGravandoExecucaoStandoxCores.fGerarStandoxTipoDois(qryCadDox: IDataSet;
  stlFormulas: TStringList; Gravando: IGravando; var intTipoUm: Integer): Boolean;
Var
  strMontad,
  strCodigo,
  strDescri,
  strVersao,
  strAnoIni,
  strAnoFin,
  strPainel,
  strCatego,
  strPais,
  strVarian,
  strQualidade,
  strInfCor: String;

  intLinha: Integer;
  strLinha: String;
  intContador: Integer;
  intBase: Integer;
  blnStandBlue: Boolean;
  strBase: String;
begin
  Result := True;
  blnStandBlue := False;
  strBase := '';
  intLinha := 0;
  While (intLinha < stlFormulas.Count) Do
  Begin

    If (Gravando.Status <> sgGravando) Then
      Break;

    strLinha     := stlFormulas[intLinha];
    strMontad    := Trim(fRetCampoBas('MONTAD', intLinha, strLinha));
    strCodigo    := Trim(fRetCampoBas('CODIGO', intLinha, strLinha));
    strDescri    := Trim(fRetCampoBas('DESCRI', intLinha, strLinha));
    strVersao    := Trim(fRetCampoBas('VERSAO', intLinha, strLinha));
    strAnoIni    := Trim(fRetCampoBas('ANOINI', intLinha, strLinha));
    strAnoFin    := Trim(fRetCampoBas('ANOFIN', intLinha, strLinha));
    strPainel    := Trim(fRetCampoBas('PAINEL', intLinha, strLinha));
    strCatego    := Trim(fRetCampoBas('CATEGO', intLinha, strLinha));
    strPais      := Trim(fRetCampoBas('PAIS', intLinha, strLinha));
    strVarian    := Trim(fRetCampoBas('VARIAN', intLinha, strLinha));
    strQualidade := Trim(fRetCampoBas('QUALID', intLinha, strLinha));
    strInfCor    := Trim(fRetCampoBas('INFCOR', intLinha, strLinha));

    If (strQualidade <> 'STANDOBLUE BASECOAT') Then
    Begin
      If (Pos('0', strMontad) <= 0) And (Not TStrUtils.fEmptyStr(strMontad)) And (strPais = 'BRASIL') Or (strPais = 'BRAZIL') Then
      Begin
        qryCadDox.Close;
        qryCadDox.ParamByName('DOX_CODSEQ').AsString := TStrUtils.fStrZero(intTipoUm+1, 6);
        qryCadDox.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DOX_CADDOX', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadDox.ParamByName('DOX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadDox.ParamByName('DOX_MONTAD').AsString := strMontad;
        qryCadDox.ParamByName('DOX_CODDOX').AsString := strCodigo;
        qryCadDox.ParamByName('DOX_DESCRI').AsString := strDescri;
        qryCadDox.ParamByName('DOX_VERSAO').AsString := strVersao;
        qryCadDox.ParamByName('DOX_ANOINI').AsString := strAnoIni;
        qryCadDox.ParamByName('DOX_ANOFIN').AsString := strAnoFin;
        qryCadDox.ParamByName('DOX_PAINEL').AsString := strPainel;
        qryCadDox.ParamByName('DOX_CATEGO').AsString := strCatego;
        qryCadDox.ParamByName('DOX_PAIS__').AsString := strPais;
        qryCadDox.ParamByName('DOX_VARIAN').AsString := strVarian;
        qryCadDox.ParamByName('DOX_QUALID').AsString := 'STANDOBLUE BASECOAT';
        qryCadDox.ParamByName('DOX_INFCOR').AsString := strInfCor;
        qryCadDox.ParamByName('DOX_ATIVO_').AsString := 'S';

        intBase := 0;

        For intContador := 0 To 19 Do
        Begin
          qryCadDox.ParamByName('DOX_BASE' + TStrUtils.fStrZero(intContador+1, 2)).AsString := '';
          qryCadDox.ParamByName('DOX_QTDC' + TStrUtils.fStrZero(intContador+1, 2)).AsFloat  := 0.0;

          strBase := fRetCampoBas('CODBAS', intContador+1, strLinha);

          If Pos('STBLUE', strBase) > 0 Then
          Begin
            qryCadDox.ParamByName('DOX_BASE' + TStrUtils.fStrZero(intBase+1, 2)).AsString :=
              fRetCampoBas('CODBAS', intContador+1, strLinha);
            qryCadDox.ParamByName('DOX_QTDC' + TStrUtils.fStrZero(intBase+1, 2)).AsFloat :=
              TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(fRetCampoBas('QTDBAS', intContador+1, strLinha), '.', ','));

            Inc(intBase);
            blnStandBlue := True;
          End;
        End;

        qryCadDox.ParamByName('DOX_MD5KEY').AsString := GetMD5(qryCadDox.ParamByName('DOX_MONTAD').AsString + qryCadDox.ParamByName('DOX_CODDOX').AsString +
                                                               qryCadDox.ParamByName('DOX_DESCRI').AsString + qryCadDox.ParamByName('DOX_VERSAO').AsString +
                                                               qryCadDox.ParamByName('DOX_ANOINI').AsString + qryCadDox.ParamByName('DOX_ANOFIN').AsString +
                                                               qryCadDox.ParamByName('DOX_PAINEL').AsString + qryCadDox.ParamByName('DOX_CATEGO').AsString +
                                                               qryCadDox.ParamByName('DOX_PAIS__').AsString + qryCadDox.ParamByName('DOX_VARIAN').AsString +
                                                               qryCadDox.ParamByName('DOX_QUALID').AsString + qryCadDox.ParamByName('DOX_INFCOR').AsString +
              qryCadDox.ParamByName('DOX_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC01').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC02').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC03').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC04').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC05').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC06').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC07').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC08').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC09').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC10').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC11').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC12').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC13').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC14').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC15').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC16').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC17').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC18').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC19').AsFloat), ',', '.') +
              qryCadDox.ParamByName('DOX_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC20').AsFloat), ',', '.'));

        If blnStandBlue Then
        Begin
          If Not qryCadDox.Locate('MD5KEY', qryCadDox.ParamByName('DOX_MD5KEY').AsString, []) Then
          Begin
            qryCadDox.ExecSQL;

            cdsMd5.Append;
            cdsMd5.FieldByName('MD5KEY').AsString := qryCadDox.ParamByName('DOX_MD5KEY').AsString;
            cdsMd5.Post;
          End;
          blnStandBlue := False;
        End;

        Gravando.RegistrarProgresso(0, intLinha, stlFormulas.Count);
      End;
    End;
    Inc(intLinha);

  End;


end;

function TGravandoExecucaoStandoxCores.fGerarStandoxTipoUm(qryCadDox: IDataSet;
  stlFormulas: TStringList; Gravando: IGravando; var intTipoUm: Integer): Boolean;
Var
  strMontad,
  strCodigo,
  strDescri,
  strVersao,
  strAnoIni,
  strAnoFin,
  strPainel,
  strCatego,
  strPais,
  strVarian,
  strQualidade,
  strInfCor: String;

  intLinha: Integer;
  strLinha: String;
  intContador: Integer;
begin
  Result := True;
  intLinha := 0;
  While (intLinha < stlFormulas.Count) Do
  Begin

    If (Gravando.Status <> sgGravando) Then
      Break;

    strLinha      := stlFormulas[intLinha];
    strMontad     := Trim(fRetCampoBas('MONTAD', intLinha, strLinha));
    strCodigo     := Trim(fRetCampoBas('CODIGO', intLinha, strLinha));
    strDescri     := Trim(fRetCampoBas('DESCRI', intLinha, strLinha));
    strVersao     := Trim(fRetCampoBas('VERSAO', intLinha, strLinha));
    strAnoIni     := Trim(fRetCampoBas('ANOINI', intLinha, strLinha));
    strAnoFin     := Trim(fRetCampoBas('ANOFIN', intLinha, strLinha));
    strPainel     := Trim(fRetCampoBas('PAINEL', intLinha, strLinha));
    strCatego     := Trim(fRetCampoBas('CATEGO', intLinha, strLinha));
    strPais       := Trim(fRetCampoBas('PAIS', intLinha, strLinha));
    strVarian     := Trim(fRetCampoBas('VARIAN', intLinha, strLinha));
    strQualidade  := Trim(fRetCampoBas('QUALID', intLinha, strLinha));
    strInfCor     := Trim(fRetCampoBas('INFCOR', intLinha, strLinha));

    If (Pos('0', strMontad) <= 0) And (Not TStrUtils.fEmptyStr(strMontad)) And (strPais = 'BRASIL') Or (strPais = 'BRAZIL') Then
    Begin
      qryCadDox.Close;
      qryCadDox.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DOX_CADDOX', TAutcomTintaFactory.Get.GetCodEmp);
      qryCadDox.ParamByName('DOX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryCadDox.ParamByName('DOX_CODSEQ').AsString := TStrUtils.fStrZero(intLinha+1, 6);
      qryCadDox.ParamByName('DOX_MONTAD').AsString := strMontad;
      qryCadDox.ParamByName('DOX_CODDOX').AsString := strCodigo;
      qryCadDox.ParamByName('DOX_DESCRI').AsString := strDescri;
      qryCadDox.ParamByName('DOX_VERSAO').AsString := strVersao;
      qryCadDox.ParamByName('DOX_ANOINI').AsString := strAnoIni;
      qryCadDox.ParamByName('DOX_ANOFIN').AsString := strAnoFin;
      qryCadDox.ParamByName('DOX_PAINEL').AsString := strPainel;
      qryCadDox.ParamByName('DOX_CATEGO').AsString := strCatego;
      qryCadDox.ParamByName('DOX_PAIS__').AsString := strPais;
      qryCadDox.ParamByName('DOX_VARIAN').AsString := strVarian;
      qryCadDox.ParamByName('DOX_QUALID').AsString := strQualidade;
      qryCadDox.ParamByName('DOX_INFCOR').AsString := strInfCor;
      qryCadDox.ParamByName('DOX_ATIVO_').AsString := 'S';

      For intContador := 0 To 19 Do
      Begin
        qryCadDox.ParamByName('DOX_BASE' + TStrUtils.fStrZero(intContador+1, 2)).AsString := fRetCampoBas('CODBAS', intContador+1, strLinha);
        qryCadDox.ParamByName('DOX_QTDC' + TStrUtils.fStrZero(intContador+1, 2)).AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(fRetCampoBas('QTDBAS', intContador+1, strLinha), '.', ','));

        If (strQualidade <> 'STANDOBLUE BASECOAT') Then
        Begin
          If Pos('STBLUE',qryCadDox.ParamByName('DOX_BASE' + TStrUtils.fStrZero(intContador+1, 2)).AsString) > 0 Then
          Begin
            qryCadDox.ParamByName('DOX_BASE' + TStrUtils.fStrZero(intContador+1, 2)).AsString := '';
            qryCadDox.ParamByName('DOX_QTDC' + TStrUtils.fStrZero(intContador+1, 2)).AsFloat  := 0.0;

          End;
        End;
      End;

      qryCadDox.ParamByName('DOX_MD5KEY').AsString := GetMD5(qryCadDox.ParamByName('DOX_MONTAD').AsString + qryCadDox.ParamByName('DOX_CODDOX').AsString +
                                                             qryCadDox.ParamByName('DOX_DESCRI').AsString + qryCadDox.ParamByName('DOX_VERSAO').AsString +
                                                             qryCadDox.ParamByName('DOX_ANOINI').AsString + qryCadDox.ParamByName('DOX_ANOFIN').AsString +
                                                             qryCadDox.ParamByName('DOX_PAINEL').AsString + qryCadDox.ParamByName('DOX_CATEGO').AsString +
                                                             qryCadDox.ParamByName('DOX_PAIS__').AsString + qryCadDox.ParamByName('DOX_VARIAN').AsString +
                                                             qryCadDox.ParamByName('DOX_QUALID').AsString + qryCadDox.ParamByName('DOX_INFCOR').AsString +
            qryCadDox.ParamByName('DOX_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC01').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC02').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC03').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC04').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC05').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC06').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC07').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC08').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC09').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC10').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC11').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC12').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC13').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC14').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC15').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC16').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC17').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC18').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC19').AsFloat), ',', '.') +
            qryCadDox.ParamByName('DOX_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.ParamByName('DOX_QTDC20').AsFloat), ',', '.'));

      If Not cdsMd5.Locate('MD5KEY', qryCadDox.ParamByName('DOX_MD5KEY').AsString, []) Then
      Begin
        qryCadDox.ExecSQL;

        cdsMd5.Append;
        cdsMd5.FieldByName('MD5KEY').AsString := qryCadDox.ParamByName('DOX_MD5KEY').AsString;
        cdsMd5.Post;
      End;

      Gravando.RegistrarProgresso(0, intLinha, stlFormulas.Count);
    End;
    Inc(intLinha);
  End;
  intTipoUm := intLinha;
end;

function TGravandoExecucaoStandoxCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;



function TGravandoExecucaoStandoxCores.fGetSelect: String;
//Var
//  intContador: Integer;
begin
  Result := TAutcomTintaFactory.Get.GetInsert('DOX_CADDOX');


  {' INSERT INTO DOX_CADDOX (  ' +
            '   DOX_CODSEQ,             ' +
            '   DOX_MONTAD,             ' +
            '   DOX_CODDOX,             ' +
            '   DOX_DESCRI,             ' +
            '   DOX_VERSAO,             ' +
            '   DOX_ANOINI,             ' +
            '   DOX_ANOFIN,             ' +
            '   DOX_PAINEL,             ' +
            '   DOX_CATEGO,             ' +
            '   DOX_PAIS__,             ' +
            '   DOX_VARIAN,             ' +
            '   DOX_QUALID,             ' +
            '   DOX_INFCOR,             ' +
            '   DOX_MD5KEY,             ' +
            '   DOX_CODEMP              ' ;

  For intContador := 1 To 20 Do
  Begin
    Result := Result + ' , ' + '  DOX_BASE' + TStrUtils.fStrZero(intContador, 2);
    Result := Result + ' , ' + '  DOX_QTDC' + TStrUtils.fStrZero(intContador, 2);
  End;

  Result := Result +  ' , ' + ' AUTOINCREM)  ';

  Result := Result +  '      VALUES (                   ' +
                      '   :DOX_CODSEQ,                  ' +
                      '   :DOX_MONTAD,                  ' +
                      '   :DOX_CODDOX,                  ' +
                      '   :DOX_DESCRI,                  ' +
                      '   :DOX_VERSAO,                  ' +
                      '   :DOX_ANOINI,                  ' +
                      '   :DOX_ANOFIN,                  ' +
                      '   :DOX_PAINEL,                  ' +
                      '   :DOX_CATEGO,                  ' +
                      '   :DOX_PAIS__,                  ' +
                      '   :DOX_VARIAN,                  ' +
                      '   :DOX_QUALID,                  ' +
                      '   :DOX_INFCOR,                  ' +
                      '   :DOX_MD5KEY,                  ' +
                      '   :DOX_CODEMP                   ' ;

  For intContador := 1 To 20 Do
  Begin
    Result := Result +  ' , ' + '   :DOX_BASE' + TStrUtils.fStrZero(intContador, 2);
    Result := Result +  ' , ' + '   :DOX_QTDC' + TStrUtils.fStrZero(intContador, 2);
  End;

  Result := Result + '  , ' + '   :AUTOINCREM) ';     }



end;

end.
