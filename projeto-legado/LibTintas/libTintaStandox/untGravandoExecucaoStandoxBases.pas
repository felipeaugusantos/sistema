{**************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Standox *}
{***********************************************************************AC*}
unit untGravandoExecucaoStandoxBases;

interface

uses
  untAbstractGravandoExecucaoStandox, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, Uni, InterBaseUniProvider,UniDataSetProvider, UniClientDataSet, DB;

type
  TGravandoExecucaoStandoxBases = class(TAbstractGravandoExecucaoStandox)
  private
    function fGerarBases(Gravando: IGravando):Boolean;
    function fQtdEmbalagemMl(strEmbalagem: String): String;
    function fGerarDiluentes(Gravando: IGravando): Boolean;
    function fGerarBasesEurope(Gravando: IGravando):Boolean;
    function fRetEmbalagem(strEmbalagem: String): Double;
    procedure pCriaFildsStandox(cdsBases: TUniClientDataSet);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  const
    arrCodDil: Array[0..4] Of String[10] = ('MSB 10-20',
                                            'MSB 15-25',
                                            'MSB 25-35',
                                            'STBLCOATA',
                                            'STBLADJSL');

    arrCodigo: Array[0..4] Of String[12] = ('T44192002/10',
                                            'T24892002/10',
                                            'T82602002/10',
                                            'T00292000/1S',
                                            'T03012000/1S');

    arrDescri: Array[0..4] Of String[50] = ('Standox Thinner MSB 10-20',
                                            'Standox Thinner MSB 15-25',
                                            'Standox Thinner MSB 25-35',
                                            'STANDOBLUE BASECOAT VISCOSITY ADJUSTER',
                                            'STANDOBLUE VISCOSITY ADJUSTER SLOW');

    ArrPesEsp: Array[0..4] Of Double = (0.88,
                                        0.85,
                                        0.87,
                                        1.01,
                                        1.01);
  end;

implementation

uses
  untIConfTinta, untStrUtils;

{ TGravandoExecucaoStandoxBases }

procedure TGravandoExecucaoStandoxBases.Executar(const gravando: IGravando);
begin
  Try
    If Not fGerarBases(Gravando) Then
      Exit;

    If conf.fGet('DOXARQ') = '1' Then
    Begin
      If Not fGerarBasesEurope(Gravando) Then
        Exit;
    End;
  Finally
    Gravando.Texto := Format('Cadastro de %s processado com sucesso!', ['Bases'])
  End;
end;

function TGravandoExecucaoStandoxBases.fGerarBases(Gravando: IGravando): Boolean;
Var
 qryBases: IDataSet;
 strLinha, strLin:String;
 cdsBases: TUniClientDataSet;
 intContador, intLinha:Integer;
 stlFormulas: TStringList;
 txtArq: TextFile;
 strCodBas:String;
begin
  Result := True;

  Gravando.Texto := 'Verificando path do arquivo Brasil.txt...';

  If Not fValidaPath Then
  Begin
    Result := False;
    Gravando.Texto := Format('O arquivo %s não existe!', [AnsiReplaceStr(GetPath, '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Path verificado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Try
    Try
      Gravando.Texto := 'Deletando Cadastro de Bases...';

      qryBases := TAutcomTintaFactory.Get.fGetDataSet;
      qryBases.SQL := '   DELETE FROM DOX_CADBAS  ';
      qryBases.ExecSQL;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DOX_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      stlFormulas := TStringList.Create;
      AssignFile(txtArq, GetPath);
      Reset(txtArq);

      While Not Eof(txtArq) Do
      Begin
        Readln(txtArq, strLin);
        stlFormulas.Add(strLin);
      End;
      CloseFile(txtArq);

      cdsBases := TUniClientDataSet.Create(Nil);
      pCriaFildsStandox(cdsBases);
      cdsBases.CreateDataSet;

      qryBases.SQL.Empty;
      qryBases.SQL := ' INSERT INTO DOX_CADBAS ( ' +
                      '   BAS_CODBAS, ' +
                      '   BAS_CODEMP, ' +
                      '   BAS_PESESP, ' +
                      '   BAS_DESBAS, ' +
                      '   BAS_EMBALA, ' +
                      '   BAS_QTDEMB, ' +
                      '   BAS_PESGRA, ' +
                      '   AUTOINCREM) ' +
                      ' VALUES                 ( ' +
                      '  :CODBAS, ' +
                      '  :CODEMP, ' +
                      '  :PESESP, ' +
                      '  :DESBAS, ' +
                      '  :EMBALA, ' +
                      '  :QTDEMB, ' +
                      '  :PESGRA, ' +
                      '  :INCREM) ';

      intLinha := 0;

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      While (intLinha < stlFormulas.Count) Do
      Begin
        strLinha := stlFormulas[intLinha];

        If ((Trim(fRetCampoBas('PAIS', 0, strLinha)) = 'BRAZIL') Or (Trim(fRetCampoBas('PAIS', 0, strLinha)) = 'BRASIL')) Then
        Begin
          For intContador := 1 To 20 Do
          Begin

            strCodbas := fRetCampoBas('CODBAS', intContador, strLinha);

            If Not cdsBases.Locate('BAS_CODBAS',strCodbas,[]) Then
            Begin
              If Not TStrUtils.fEmptyStr(fRetCampoBas('CODBAS', intContador, strLinha)) Then
              Begin
                cdsBases.Append;
                cdsBases.FieldByName('BAS_PESGRA').AsString := 'N';
                cdsBases.FieldByName('BAS_CODBAS').AsString := strCodbas;
                cdsBases.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
                cdsBases.FieldByName('BAS_PESESP').AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(fRetCampoBas('PESESP', intContador, strLinha), '.', ','));
                cdsBases.FieldByName('BAS_DESBAS').AsString := UpperCase(fRetCampoBas('DESBAS', intContador, strLinha));
                cdsBases.FieldByName('BAS_EMBALA').AsFloat  := fRetEmbalagem(fRetCampoBas('EMBALA', intContador, strLinha));
                cdsBases.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(cdsBases.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
                cdsBases.Post;
              End;
            End;
          End;
        End;

        Inc(intLinha);
      End;

      cdsBases.First;
      While Not cdsBases.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryBases.ParamByName('CODBAS').AsString := cdsBases.FieldByName('BAS_CODBAS').AsString;
        qryBases.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryBases.ParamByName('PESESP').AsFloat  := cdsBases.FieldByName('BAS_PESESP').AsFloat;
        qryBases.ParamByName('DESBAS').AsString := cdsBases.FieldByName('BAS_DESBAS').AsString;
        qryBases.ParamByName('EMBALA').AsFloat  := cdsBases.FieldByName('BAS_EMBALA').AsFloat;
        qryBases.ParamByName('PESGRA').AsString := cdsBases.FieldByName('BAS_PESGRA').AsString;
        qryBases.ParamByName('QTDEMB').AsString := cdsBases.FieldByName('BAS_QTDEMB').AsString;
        qryBases.ParamByName('INCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DOX_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
        qryBases.ExecSQL;

        cdsBases.Next;
        Gravando.RegistrarProgresso(0, cdsBases.RecNo, cdsBases.RecordCount);
      End;

      If Not (fGerarDiluentes(Gravando)) Then
        Exit;

    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally
    Gravando.Texto := 'Cadastro de Bases Brasil processado com sucesso!';
    FreeAndNil(stlFormulas);
    FreeAndNil(cdsBases);
  End;

end;

function TGravandoExecucaoStandoxBases.fGerarBasesEurope(Gravando: IGravando): Boolean;
Var
  qryGen,
  qryBasesEurope: IDataSet;
  strLinha, strLin: String;
  strCodBas: String;
  intContador, intLinha:Integer;
  stlFormulas: TStringList;
  txtArq: TextFile;
begin
  Result := True;

  Gravando.Texto := 'Verificando path do arquivo Europe...';

  If Not fValidaPathEurope() Then
  Begin
    Gravando.Texto := Format('O path %s não existe!', [AnsiReplaceStr(GetPathEur, '"', '')]);
    Result := False;
    Exit;
  End;

  Gravando.Texto := 'Path Europe validado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Try
    Try
      Gravando.Texto := 'Carregando dados do arquivo Europe...';

      stlFormulas := TStringList.Create;
      AssignFile(txtArq, GetPathEur);
      Reset(txtArq);

      While Not Eof(txtArq) Do
      Begin
        Readln(txtArq, strLin);
        stlFormulas.Add(strLin);
      End;
      CloseFile(txtArq);

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DOX_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso...';


      intLinha := 0;

      qryGen := TAutcomTintaFactory.Get.fGetDataSet;


      qryBasesEurope := TAutcomTintaFactory.Get.fGetDataSet;
      qryBasesEurope.SQL := '   SELECT * FROM DOX_CADBAS WHERE FALSE   ';
      qryBasesEurope.Open;

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(GetPathEur, '"', '')]);

      While (intLinha < stlFormulas.Count) Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        strLinha := stlFormulas[intLinha];

        Inc(intLinha);

        For intContador := 1 To 20 Do
        Begin
          strCodBas := fRetCampoBas('CODBAS', intContador, strLinha);

          If (Gravando.Status <> sgGravando) Then
            Break;

          If TStrUtils.fEmptyStr(strCodBas) Then
            Continue;

          qryGen.Close;
          qryGen.SQL.Empty;
          qryGen.SQL := ' SELECT * FROM DOX_CADBAS ' +
                        '   WHERE BAS_CODEMP = :CODEMP  ' +
                        '   AND BAS_CODBAS = :CODBAS    ';
          qryGen.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryGen.ParamByName('CODBAS').AsString := strCodBas;
          qryGen.Open;

          If qryGen.IsEmpty Then
          Begin
            qryBasesEurope.Insert;
            qryBasesEurope.FieldByName('BAS_PESGRA').AsString := 'N';
            qryBasesEurope.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryBasesEurope.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DOX_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
            qryBasesEurope.FieldByName('BAS_PESESP').AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(fRetCampoBas('PESESP', intContador, strLinha), '.', ','));
            qryBasesEurope.FieldByName('BAS_DESBAS').AsString := UpperCase(fRetCampoBas('DESBAS',intContador,strLinha));
            qryBasesEurope.FieldByName('BAS_EMBALA').AsFloat  := fRetEmbalagem(fRetCampoBas('EMBALA',intContador,strLinha));
            qryBasesEurope.FieldByName('BAS_CODBAS').AsString := strCodBas;
            qryBasesEurope.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryBasesEurope.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
            qryBasesEurope.Post;

          End;


        End;
        Gravando.RegistrarProgresso(0, intLinha, stlFormulas.Count -1);
      End;

      If Not fGerarDiluentes(Gravando) Then
        Exit;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    FreeAndNil(stlFormulas);
  End;


end;

function TGravandoExecucaoStandoxBases.fGerarDiluentes(
  Gravando: IGravando): Boolean;
Var
  intContador:Integer;
  qryBases,
  qryDiluentes: IDataSet;
begin
  Result := True;
  Gravando.Texto := 'Carregando dados do Cadastro de Diluentes...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Deletando Cadastro de Diluentes...';
  qryDiluentes := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases := TAutcomTintaFactory.Get.fGetDataSet;
  qryDiluentes.SQL := '   DELETE FROM DOX_CADDIL    ';
  qryDiluentes.ExecSQL;
  qryDiluentes.SQL.Empty;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('DOX_CADDIL');
  Gravando.Texto := 'PROCOD Verificado com sucesso...';

  Gravando.Texto := 'Processando Cadastro de Diluentes...';

  For intContador := 0 To Length(arrCodDil) -1 Do
  Begin

    If (Gravando.Status <> sgGravando) Then
      Break;

    qryBases.Close;
    qryBases.SQL.Empty;
    qryBases.SQL := '   SELECT * FROM DOX_CADBAS   ' +
                    '     WHERE BAS_CODBAS = :CODBAS ';

    qryBases.ParamByName('CODBAS').AsString := String(arrCodDil[intContador]);
    qryBases.Open;

    If Not qryBases.IsEmpty Then
      Continue;

    qryBases.Insert;
    qryBases.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DOX_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
    qryBases.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryBases.FieldByName('BAS_CODBAS').AsString := String(arrCodDil[intContador]);
    qryBases.FieldByName('BAS_DESBAS').AsString := UpperCase(String(arrDescri[intContador]));
    qryBases.FieldByName('BAS_PESESP').AsFloat  := ArrPesEsp[intContador];

    If intContador <= 2 Then
    Begin
      qryBases.FieldByName('BAS_EMBALA').AsFloat := 1000;
      qryBases.FieldByName('BAS_QTDEMB').AsString := '1000 ML';
    End
    Else
    Begin
      qryBases.FieldByName('BAS_EMBALA').AsFloat := 3500;
      qryBases.FieldByName('BAS_QTDEMB').AsString := '3500 ML';
    End;


    qryBases.FieldByName('BAS_PESGRA').AsString := 'N';
    qryBases.Post;
  End;

  qryDiluentes.SQL := '   SELECT * FROM DOX_CADDIL WHERE FALSE   ';
  qryDiluentes.Open;

  For intContador := 0 To Length(arrCodDil) - 1 Do
  Begin

    If (Gravando.Status <> sgGravando) Then
      Break;

    qryDiluentes.Insert;
    qryDiluentes.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DOX_CADDIL', TAutcomTintaFactory.Get.GetCodEmp);
    qryDiluentes.FieldByName('DIL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryDiluentes.FieldByName('DIL_CODDIL').AsString := String(arrCodDil[intContador]);
    qryDiluentes.FieldByName('DIL_DESCRI').AsString := String(arrDescri[intContador]);
    qryDiluentes.FieldByName('DIL_PESESP').AsFloat  := ArrPesEsp[intContador];
    qryDiluentes.FieldByName('DIL_CODIGO').AsString := String(arrCodigo[intContador]);
    qryDiluentes.Post;

  End;

  Gravando.Texto := Format('Cadastro de %s processado com sucesso!', ['Diluentes']);
end;

function TGravandoExecucaoStandoxBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoStandoxBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

function TGravandoExecucaoStandoxBases.fRetEmbalagem(
  strEmbalagem: String): Double;
begin
  Result := 0;
  If strEmbalagem = '1 LITRE' Then
    Result := 1000;
end;

procedure TGravandoExecucaoStandoxBases.pCriaFildsStandox(
  cdsBases: TUniClientDataSet);
begin
  With cdsBases.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BAS_CODBAS';
    DataType := ftString;
    Size := 10;
  End;

  With cdsBases.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BAS_CODEMP';
    DataType := ftString;
    Size := 3;
  End;

  With cdsBases.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BAS_PESESP';
    DataType := ftFloat;
  End;

  With cdsBases.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BAS_DESBAS';
    DataType := ftString;
    Size := 40;
  End;

  With cdsBases.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BAS_EMBALA';
    DataType := ftFloat;
  End;

  With cdsBases.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BAS_PESGRA';
    DataType := ftString;
    Size := 1;
  End;

  With cdsBases.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BAS_QTDEMB';
    DataType := ftString;
    Size := 12;
  End;
end;

end.
