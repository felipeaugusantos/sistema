{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Salcomix *}
{**********************************************************************PH*}
unit untGravandoExecucaoSalcomixCores;

interface

uses
  untAbstractGravandoExecucaoSalcomix, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela, ADODB,
  StrUtils, untTipoCadastro, untFloatUtils, Classes, Math, Uni,UniClientDataSet,
  InterBaseUniProvider, UniDataSetProvider, untSalcomixSQLServer;

type
  TGravandoExecucaoSalcomixCores = class(TAbstractGravandoExecucaoSalcomix)
  private
    procedure pImportarFormulasAmerica(qrySalcoMix: IDataSet; strPath:String; Gravando: IGravando);
    procedure pImportarFormulasEspeciais(qrySalcoMix: IDataSet; strPath: String; fltFVen:Double; Gravando: IGravando);
    procedure pImportarFormulas(qrySalcoMix: IDataSet; strPath:String; Gravando: IGravando);
    procedure pImportarFormulasSQLServer(qryCadSal: IDataSet; intAutInc: Integer; Gravando: IGravando);
    function  fGravarFormulas(qrySalcoMix: IDataSet; strCodPro: String; strLinha: String; strMaisCo: String; strDescri: String;
      strVariac: String; strMontad: String; strAnoCor: String; strPasso: String; strMd5Key: String; fltPreCus: Double;
      fltPreVen: Double; arrBasSal: Array Of TBasSal): Boolean;
    function fRetCodSeq(): Integer;
  public

    constructor Create(const strCodNfm: string = '');
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoSalcomixCores }

constructor TGravandoExecucaoSalcomixCores.Create(const strCodNfm: string);
begin
  inherited Create();
end;

procedure TGravandoExecucaoSalcomixCores.Executar(const gravando: IGravando);
Var
  qrySalcoMix: IDataSet;
  fltFveSal: Double;
  intAutInc: Integer;

begin
  Gravando.Texto := 'Carregando dados do Cadastro de Fórmulas...';
  qrySalcoMix := TAutcomTintaFactory.Get.fGetDataSet;

  fltFveSal := Conf.fGetDouble('FVESAL');
  intAutInc := 1;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Deletando Cadastro de Fórmulas...';
  qrySalcoMix.SQL := ' DELETE FROM SAL_CADSAL  ';
  qrySalcoMix.ExecSQL;

  qrySalcoMix.SQL.Empty;
  qrySalcoMix.SQL := '    SELECT * FROM SAL_CADSAL    ';
  qrySalcoMix.Open;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('SAL_CADSAL');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Verificando Calculo de formulação para iniciar Gravação...';

  Try
    Try
      If conf.fGet('CALFOR') = '0' Then
      Begin
        pImportarFormulasAmerica(qrySalcoMix, SalcomixPath, Gravando);
        pImportarFormulas(qrySalcoMix, SalcomixPath, Gravando);
        pImportarFormulasEspeciais(qrySalcoMix, SalcomixPath, fltFveSal, Gravando);
      End
      Else
      Begin
        pImportarFormulasSQLServer(qrySalcoMix, intAutInc, Gravando);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    Gravando.Texto := 'Cadastro de Fórmulas processado com sucesso!';
  End;


end;

function TGravandoExecucaoSalcomixCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;



function TGravandoExecucaoSalcomixCores.fGravarFormulas(qrySalcoMix: IDataSet;
  strCodPro, strLinha, strMaisCo, strDescri, strVariac, strMontad, strAnoCor,
  strPasso, strMd5Key: String; fltPreCus, fltPreVen: Double;
  arrBasSal: array of TBasSal): Boolean;
Var
  intContador: Integer;
begin
  qrySalcoMix.Insert;
  qrySalcoMix.FieldByName('SAL_CODSEQ').AsString := TStrUtils.fStrZero(fRetCodSeq, 6);
  qrySalcoMix.FieldByName('SAL_LINHA_').AsString := strLinha;
  qrySalcoMix.FieldByName('SAL_MONTAD').AsString := strMontad;
  qrySalcoMix.FieldByName('SAL_DESCRI').AsString := strDescri + TAutcomTintaFactory.Get.IIF(Not TStrUtils.fEmptyStr(strMaisCo), ' ' + strMaisCo, '');
  qrySalcoMix.FieldByName('SAL_CODPRO').AsString := strCodPro;
  qrySalcoMix.FieldByName('SAL_PRECUS').AsFloat  := fltPreCus;
  qrySalcoMix.FieldByName('SAL_PREVEN').AsFloat  := fltPreCus;
  qrySalcoMix.FieldByName('SAL_ANOCOR').AsString := strAnoCor;
  qrySalcoMix.FieldByName('SAL_VARIAC').AsString := strVariac;
  qrySalcoMix.FieldByName('SAL_PASSO_').AsString := strPasso;

  For intContador := Low(arrBasSal) To High(arrBasSal) Do
  Begin
    qrySalcoMix.FieldByName('SAL_FORM' + TStrUtils.fStrZero(intContador+1, 2)).AsString := arrBasSal[intContador].strCodBas;
    qrySalcoMix.FieldByName('SAL_QTDB' + TStrUtils.fStrZero(intContador+1, 2)).AsFloat  := arrBasSal[intContador].fltQtdBas;
  End;

  qrySalcoMix.FieldByName('SAL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qrySalcoMix.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SAL_CADSAL', TAutcomTintaFactory.Get.GetCodEmp);
  qrySalcoMix.FieldByName('SAL_MD5KEY').AsString := GetMD5(qrySalcoMix.FieldByName('SAL_CODSEQ').AsString + strMd5Key);
  qrySalcoMix.Post;

  Result := True;

end;

function TGravandoExecucaoSalcomixCores.fRetCodSeq: Integer;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT IFNULL(MAX(CONVERT(SAL_CODSEQ, SIGNED)), 0) + 1 AS MAXIMO FROM SAL_CADSAL  ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;
end;

procedure TGravandoExecucaoSalcomixCores.pImportarFormulas(
  qrySalcoMix: IDataSet; strPath: String; Gravando: IGravando);
Var
  stlImporta: TStringList;
  intContador: Integer;
  intIdxBase: Integer;
  intIndTxt: Integer;
  strLinTxt: String;
  arrBasSal: Array [1..20] Of TBasSal;

  strCodPro: String;
  strLinha : String;
  strMaisCo: String;
  strDescri: String;
  strVariac: String;
  strMontad: String;
  strAnoCor: String;
  strPasso : String;
  strMd5Key: String;
begin
  Gravando.Texto := 'Verificando Path do arquivo IMPORTA.TXT...';

  If Not(FileExists(strPath + '\IMPORTA.TXT')) Then
  Begin
    Gravando.Texto := Format('O path %s não existe ou não está configurado corretamente!', [AnsiReplaceStr(strPath + '\IMPORTA.TXT', '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Path verificado com sucesso...';

  stlImporta := TStringList.Create;
  Try
    Try
      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(strPath + '\IMPORTA.TXT', '"', '')]);

      stlImporta.LoadFromFile(SalcomixPath + '\IMPORTA.TXT');
      For intContador := 0 To stlImporta.Count - 1 Do
      Begin
        strLinTxt := stlImporta[intContador];

        strLinha  := Trim(Copy(strLinTxt, 001, 04));
        strMontad := Trim(Copy(strLinTxt, 005, 03));
        strDescri := Trim(Copy(strLinTxt, 008, 45));
        strCodPro := Trim(Copy(strLinTxt, 050, 15));
        strAnoCor := Trim(Copy(strLinTxt, 056, 04));
        strVariac := Trim(Copy(strLinTxt, 452, 05));
        strPasso  := Trim(Copy(strLinTxt, 075, 34));

        strMd5Key := strCodPro + strLinha + strDescri + strMontad + strAnoCor + strVariac;

        For intIdxBase := 1 To 20 Do
        Begin
          arrBasSal[intIdxBase].strCodBas := '';
          arrBasSal[intIdxBase].fltQtdBas := 0.00;
        End;

        intIndTxt := 119;

        For intIdxBase := 1 To 20 Do
        Begin
          arrBasSal[intIdxBase].strCodBas := Trim(Copy(strLinTxt, intIndTxt, 08));

          If TStrUtils.fEmptyStr(arrBasSal[intIdxBase].strCodBas) Then
            Continue;

          If arrBasSal[intIdxBase].strCodBas = 'E 057000' Then
            arrBasSal[intIdxBase].strCodBas := ''
          Else
            arrBasSal[intIdxBase].fltQtdBas := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strLinTxt, intIndTxt+08, 06), '.', ','));


          Inc(intIndTxt, 22);
        End;

        If Not fGravarFormulas(qrySalcoMix, strCodPro, strLinha, strMaisCo, strDescri, strVariac, strMontad, strAnoCor, strPasso,
          strMd5Key, 0.00, 0.00, arrBasSal) Then
          Break;
      End;
    Except
      On E: Exception  Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    If Assigned(stlImporta) Then
      FreeAndNil(stlImporta);
  End;
end;

procedure TGravandoExecucaoSalcomixCores.pImportarFormulasAmerica(
  qrySalcoMix: IDataSet; strPath: String; Gravando: IGravando);
Var
  stlAmerica: TStringList;
  intContador: Integer;
  intIdxBase: Integer;
  intIndTxt: Integer;
  strLinTxt: String;
  arrBasSal: Array [1..20] Of TBasSal;

  strCodPro: String;
  strLinha : String;
  strMaisCo: String;
  strDescri: String;
  strVariac: String;
  strMontad: String;
  strAnoCor: String;
  strPasso: String;
  strMd5Key: String;
begin
  Gravando.Texto := 'Verificando Path do arquivo AMERICA.TXT...';

  If Not (FileExists(strPath + '\AMERICA.TXT')) Then
  Begin
    Gravando.Texto := Format('O path %s não existe ou não está configurado corretamente!', [AnsiReplaceStr(SalcomixPath + '\AMERICA.TXT', '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Path verificado com sucesso...';

  Try
    Try
      stlAmerica := TStringList.Create;

      stlAmerica.LoadFromFile(strPath + '\AMERICA.TXT');

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(strPath + '\AMERICA.TXT', '"', '')]);

      For intContador := 0 To stlAmerica.Count - 1 Do
      Begin
        strLinTxt := stlAmerica[intContador];

        strCodPro := Trim(Copy(strLinTxt, 053, 08));
        strLinha  := Trim(Copy(strLinTxt, 001, 04));
        strMaisCo := Trim(Copy(strLinTxt, 072, 02));
        strDescri := Trim(Copy(strLinTxt, 008, 45));
        strVariac := Trim(Copy(strLinTxt, 064, 04));
        strMontad := Trim(Copy(strLinTxt, 005, 03));
        strAnoCor := Trim(Copy(strLinTxt, 068, 04));
        strPasso  := Trim(Copy(strLinTxt, 072, 34));

        strMd5Key := strCodPro + strLinha + strDescri + strMontad + strAnoCor + strVariac;

        For intIdxBase := 1 To 20 Do
        Begin
          arrBasSal[intIdxBase].strCodBas := '';
          arrBasSal[intIdxBase].fltQtdBas := 0.00;
        End;

        intIndTxt := 116;
        For intIdxBase := 1 To 20  Do
        Begin

          arrBasSal[intIdxBase].strCodBas := Trim(Copy(strLinTxt, intIndTxt, 08));

          If TStrUtils.fEmptyStr(arrBasSal[intIdxBase].strCodBas) Then
            Continue;

          If arrBasSal[intIdxBase].strCodBas = 'E 057000' Then
            arrBasSal[intIdxBase].strCodBas := ''
          Else
            arrBasSal[intIdxBase].fltQtdBas := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strLinTxt, intIndTxt+08, 06), '.', ','));

          Inc(intIndTxt, 22);
        End;

        If Not fGravarFormulas(qrySalcoMix, strCodPro, strLinha, strMaisCo, strDescri, strVariac, strMontad, strAnoCor, strPasso,
          strMd5Key, 0.0, 0.0, arrBasSal) Then
          Break;

      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    If Assigned(stlAmerica) Then
      FreeAndNil(stlAmerica);
  End;
end;

procedure TGravandoExecucaoSalcomixCores.pImportarFormulasEspeciais(
  qrySalcoMix: IDataSet; strPath: String; fltFVen:Double; Gravando: IGravando);
Var
  stlEspecial: TStringList;
  intContador: Integer;
  intIdxBase: Integer;
  strLinTxt: String;
  arrBasSal: Array [1..20] Of TBasSal;

  strCodPro: String;
  strLinha : String;
  strMaisCo: String;
  strDescri: String;
  strVariac: String;
  strMontad: String;
  strAnoCor: String;
  strPasso : String;
  strMd5Key: String;
  fltPreCus: Double;
  fltPreVen: Double;
begin
  Gravando.Texto := 'Verificando Path do arquivo ESPECIAL.TXT...';

  If Not (FileExists(strPath + '\ESPECIAL.TXT')) Then
  Begin
    Gravando.Texto := Format('O path %s não existe ou não está configurado corretamente!', [AnsiReplaceStr(strPath + '\ESPECIAL.TXT', '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Path verificado com sucesso...';

  stlEspecial := TStringList.Create;
  Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(strPath + '\ESPECIAL.TXT', '"', '')]);

  Try
    Try

      For intIdxBase := 1 To 20 Do
      Begin
        arrBasSal[intIdxBase].strCodBas := '';
        arrBasSal[intIdxBase].fltQtdBas := 0.0;
      End;

      stlEspecial.LoadFromFile(SalcomixPath + '\ESPECIAL.TXT');
      For intContador := 0 to stlEspecial.Count - 1 Do
      Begin
        strLinTxt := stlEspecial[intContador];

        strLinha  := Trim(Copy(strLinTxt, 001, 04));
        strMontad := '';
        strDescri := Trim(Copy(strLinTxt, 005, 48));
        strCodPro := Trim(Copy(strLinTxt, 053, 04));
        strVariac := '';
        strAnoCor := '';

        strMd5Key := strCodPro + strLinha + strDescri + strMontad + strAnoCor + strVariac;

        fltPreCus := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strLinTxt, 064, 12), '.', ','));
        fltPreVen := fltPreCus * fltFVen;

        If Not fGravarFormulas(qrySalcoMix, strCodPro, strlinha, strMaisCo, strDescri, strVariac, strMontad, strAnoCor, strPasso, strMd5Key,
          fltPreCus, fltPreVen, arrBasSal) Then
          Break;
      End;

    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally

  End;
end;

procedure TGravandoExecucaoSalcomixCores.pImportarFormulasSQLServer(
  qryCadSal: IDataSet; intAutInc: Integer; Gravando: IGravando);
Var
  Salcomix: TSalcomixSQLServer;
begin
  Gravando.Texto := 'Processando Fórmulas SQLServer...';

  Salcomix := TSalcomixSQLServer.Create(qryCadSal, intAutInc);
  Try
    Try
      Salcomix.pGerarCores(Gravando);
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    FreeAndNil(Salcomix);
  End;

end;

end.
