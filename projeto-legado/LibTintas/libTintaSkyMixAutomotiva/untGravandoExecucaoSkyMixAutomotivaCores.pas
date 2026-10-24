{**************************************************************************}
{* Classe responsável pela geração do cadastro de Montadoras da tinta SkyMixAutomotiva *}
{***********************************************************************AC*}
unit untGravandoExecucaoSkyMixAutomotivaCores;

interface

uses
  untAbstractGravandoExecucaoSkyMixAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj, DB;

  type
    TGravandoExecucaoSkyMixAutomotivaCores = class(TAbstractGravandoExecucaoSkyMixAutomotiva)
    Private
      procedure EditarBasesQuantidades(const Gravando: IGravando);
      function fQuantidadeRepeticao(qryGen: IDataSet): Integer;
      function fBaseMaiorQuantidade(qryGen: IDataSet; blnDiluido: Boolean): String;
      function fMaiorQuantidade(qryGen: IDataSet; blnDiluido: Boolean): Double;
    public
      function fGetNomeGravacao: string; override;
      procedure Executar(const gravando: IGravando); override;

    End;



implementation

uses
  untIConfTinta, untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoSkyMixAutomotivaCores }

procedure TGravandoExecucaoSkyMixAutomotivaCores.EditarBasesQuantidades(const Gravando: IGravando);
Var
  qryGen: IDataSet;
  slQuantidade,
  slBases: TStringList;
  intContador: Integer;
  fltValorInicial, //Quantidade Inicial
  fltValorFinal: Double; //Quantidade Final
  intRepetir: Integer;
  intCont: Integer;
  strBases: String;
  strBaseAtual: String;
  blnDiluido: Boolean;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT * FROM SKY_CADSKY  ';
  qryGen.Open;

  Gravando.Texto := 'Ajustando Bases e Quantidades...';
  Gravando.RegistrarProgresso(0, 0, 0);

  slQuantidade := TStringList.Create;
  slBases := TStringList.Create;

  While Not qryGen.Eof Do
  Begin
    slQuantidade.Clear;
    slBases.Clear;

    strBases := '';

    blnDiluido :=  (qryGen.FieldByName('SKY_CONDIL').AsString = 'DILUIDO');


    intRepetir := fQuantidadeRepeticao(qryGen);

    For intCont := 1 To intRepetir Do
    Begin
      strBaseAtual := fBaseMaiorQuantidade(qryGen, blnDiluido);
      fltValorInicial := fMaiorQuantidade(qryGen, blnDiluido);


      For intContador := 1 To 20 Do
      Begin
        If TStrUtils.fEmptyStr(qryGen.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
          Break;

        If blnDiluido Then
        Begin
          fltValorFinal := qryGen.FieldByName('SKY_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

          If (fltValorFinal <= fltValorInicial) And (Pos(qryGen.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString, strBases) <= 0) Then
          Begin
            fltValorInicial := fltValorFinal;
            strBaseAtual := qryGen.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
          End;
        End
        Else
        Begin
          fltValorFinal := qryGen.FieldByName('SKY_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

          If (fltValorFinal <= fltValorInicial) And (Pos(qryGen.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString, strBases) <= 0) Then
          Begin
            fltValorInicial := fltValorFinal;
            strBaseAtual := qryGen.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
          End;
        End;
      End;

      strBases := strBases + strBaseAtual + '_';
      slBases.Add(strBaseAtual);
      slQuantidade.Add(FloatToStr(fltValorInicial));
    End;

    For intContador := 0 To slBases.Count - 1 Do
    Begin
      qryGen.Edit;
      qryGen.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador + 1, 2)).AsString := slBases[intContador];

      If blnDiluido Then
        qryGen.FieldByName('SKY_QTDB' + TStrUtils.fStrZero(intContador + 1, 2)).AsFloat := StrToFloat(slQuantidade[intContador])
      Else
        qryGen.FieldByName('SKY_QTDC' + TStrUtils.fStrZero(intContador + 1, 2)).AsFloat := StrToFloat(slQuantidade[intContador]);

      qryGen.Post;
    End;

    Gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);
    qryGen.Next;
  End;

  FreeAndNil(slBases);
  FreeAndNil(slQuantidade);
end;

procedure TGravandoExecucaoSkyMixAutomotivaCores.Executar(const gravando: IGravando);
Var
  slArquivo    : TStringList;
  qryCadCor    : IDataSet;
  intCont      : integer;
  intProcesso  : Integer;
  slQuebra     : TStringList;
  intQuantidade: Integer;
  fltFator     : Double;
begin
  Try
    Try
      Gravando.Texto := 'Validando Arquivo de Geração...';

      If Not DirectoryExists(GetPath)  Then
      Begin
        gravando.Texto := 'Arquivo para a geração das formulas não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      Gravando.Texto := 'Arquivo Validado com Sucesso ...';

      qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Registros SKY_CADSKY...';
      qryCadCor.Close;
      qryCadCor.SQL := '  DELETE FROM SKY_CADSKY    ';
      qryCadCor.ExecSQL;
      Gravando.Texto := 'Registros deletados com sucesso...';

      qryCadCor.SQL := '  SELECT * FROM SKY_CADSKY WHERE FALSE  ';
      qryCadCor.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SKY_CADSKY');
      Gravando.Texto := 'PROCOD verificado com sucesso!';
      Gravando.Texto := 'Iniciando Geração do Cadastro de Cores...';

      slArquivo     := TStringList.Create;
      slQuebra      := TStringList.Create;

      slArquivo.LoadFromFile(GetPath + '\' + 'Formula.txt');
      intProcesso := 0;

      Gravando.Texto := 'Processando arquivos das Formulas...';

      For intCont := 0 To slArquivo.Count - 1 Do
      Begin
        If gravando.Status <> sgGravando Then
          Exit;

        slQuebra.Delimiter := '|';
        slQuebra.StrictDelimiter := True;
        slQuebra.DelimitedText := slArquivo[intCont];

        qryCadCor.Close;
        qryCadCor.SQL := '  SELECT * FROM SKY_CADSKY WHERE SKY_CODPRO = :CODPRO AND SKY_CONDIL = :CONDIL AND SKY_VERSAO = :VERSAO AND SKY_DTACAD = :DTACAD';
        qryCadCor.ParamByName('CODPRO').AsString := Trim(slQuebra[0]);
        qryCadCor.ParamByName('CONDIL').AsString := Trim(slQuebra[1]);
        qryCadCor.ParamByName('VERSAO').AsString := Trim(slQuebra[5]);
        qryCadCor.ParamByName('DTACAD').AsDateTime := StrToDate(Trim(slQuebra[6]));
        qryCadCor.Open;

        If Trim(slQuebra[3]) = 'TH700' Then
        Begin
          Inc(intProcesso);
          Gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
          Continue;
        End;

        If qryCadCor.IsEmpty Then
        Begin
          qryCadCor.Insert;
          qryCadCor.FieldByName('SKY_CODPRO').AsString := Trim(slQuebra[0]);
          qryCadCor.FieldByName('SKY_VERSAO').AsString := Trim(slQuebra[5]);
          qryCadCor.FieldByName('SKY_DTACAD').AsDate   := StrToDate(Trim(slQuebra[6]));
          qryCadCor.FieldByName('SKY_CONDIL').AsString := Trim(slQuebra[1]);
          qryCadCor.FieldByName('SKY_FORM01').AsString := Trim(slQuebra[3]);
          qryCadCor.FieldByName('SKY_MD5KEY').AsString := GetMd5(qryCadCor.FieldByName('SKY_CODPRO').AsString +
                                                                 qryCadCor.FieldByName('SKY_VERSAO').AsString +
                                                                 qryCadCor.FieldByName('SKY_DTACAD').AsString +
                                                                 qryCadCor.FieldByName('SKY_CONDIL').AsString);

          If qryCadCor.FieldByName('SKY_CONDIL').AsString = 'DILUIDO' Then
            qryCadCor.FieldByName('SKY_QTDB01').AsFloat := StrToFloat(AnsiReplaceStr(Trim(slQuebra[4]), '.', ''))
          Else
            qryCadCor.FieldByName('SKY_QTDC01').AsFloat := StrToFloat(AnsiReplaceStr(Trim(slQuebra[4]), '.', ''));

          qryCadCor.Post;
        End
        Else
        Begin
          For intQuantidade := 2 To 20 Do
          Begin
            If qryCadCor.FieldByName('SKY_CONDIL').AsString = 'DILUIDO' Then
            Begin
              If TStrUtils.fEmptyStr(qryCadCor.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intQuantidade, 2)).AsString) Then
              Begin
                qryCadCor.Edit;
                qryCadCor.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intQuantidade, 2)).AsString := Trim(slQuebra[3]);
                qryCadCor.FieldByName('SKY_QTDB' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat := StrToFloat(AnsiReplaceStr(Trim(slQuebra[4]), '.', ''));
                qryCadCor.Post;
                Break;
              End;
            End
            Else
            Begin
              If TStrUtils.fEmptyStr(qryCadCor.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intQuantidade, 2)).AsString) Then
              Begin
                qryCadCor.Edit;
                qryCadCor.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intQuantidade, 2)).AsString := Trim(slQuebra[3]);
                qryCadCor.FieldByName('SKY_QTDC' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat := StrToFloat(AnsiReplaceStr(Trim(slQuebra[4]), '.', ''));
                qryCadCor.Post;
                Break;
              End;
            End;
          End;
        End;

        Inc(intProcesso);
        Gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
      End;

      EditarBasesQuantidades(Gravando);

      Gravando.Texto := 'Gravando Quantidades TH700...';
      Gravando.RegistrarProgresso(0, 0, 0);
      intProcesso := 0;

      For intCont := 0 To slArquivo.Count - 1 Do
      Begin
        If gravando.Status <> sgGravando Then
          Exit;

        slQuebra.Delimiter := '|';
        slQuebra.StrictDelimiter := True;
        slQuebra.DelimitedText := slArquivo[intCont];

        qryCadCor.Close;
        qryCadCor.SQL := '  SELECT * FROM SKY_CADSKY WHERE SKY_CODPRO = :CODPRO AND SKY_CONDIL = :CONDIL AND SKY_VERSAO = :VERSAO AND SKY_DTACAD = :DTACAD';
        qryCadCor.ParamByName('CODPRO').AsString := Trim(slQuebra[0]);
        qryCadCor.ParamByName('CONDIL').AsString := Trim(slQuebra[1]);
        qryCadCor.ParamByName('VERSAO').AsString := Trim(slQuebra[5]);
        qryCadCor.ParamByName('DTACAD').AsDateTime := StrToDate(Trim(slQuebra[6]));
        qryCadCor.Open;

        If Trim(slQuebra[3]) <> 'TH700' Then
        Begin
          Inc(intProcesso);
          Gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
          Continue;
        End;

        If qryCadCor.IsEmpty Then
        Begin
          qryCadCor.Insert;
          qryCadCor.FieldByName('SKY_CODPRO').AsString := Trim(slQuebra[0]);
          qryCadCor.FieldByName('SKY_VERSAO').AsString := Trim(slQuebra[5]);
          qryCadCor.FieldByName('SKY_DTACAD').AsDate   := StrToDate(Trim(slQuebra[6]));
          qryCadCor.FieldByName('SKY_CONDIL').AsString := Trim(slQuebra[1]);
          qryCadCor.FieldByName('SKY_FORM01').AsString := Trim(slQuebra[3]);
          qryCadCor.FieldByName('SKY_MD5KEY').AsString := GetMd5(qryCadCor.FieldByName('SKY_CODPRO').AsString +
                                                                 qryCadCor.FieldByName('SKY_VERSAO').AsString +
                                                                 qryCadCor.FieldByName('SKY_DTACAD').AsString +
                                                                 qryCadCor.FieldByName('SKY_CONDIL').AsString);

          If qryCadCor.FieldByName('SKY_CONDIL').AsString = 'DILUIDO' Then
            qryCadCor.FieldByName('SKY_QTDB01').AsFloat := StrToFloat(AnsiReplaceStr(Trim(slQuebra[4]), '.', ''))
          Else
            qryCadCor.FieldByName('SKY_QTDC01').AsFloat := StrToFloat(AnsiReplaceStr(Trim(slQuebra[4]), '.', ''));

          qryCadCor.Post;
        End
        Else
        Begin
          For intQuantidade := 2 To 20 Do
          Begin
            If qryCadCor.FieldByName('SKY_CONDIL').AsString = 'DILUIDO' Then
            Begin
              If TStrUtils.fEmptyStr(qryCadCor.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intQuantidade, 2)).AsString) Then
              Begin
                qryCadCor.Edit;
                qryCadCor.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intQuantidade, 2)).AsString := Trim(slQuebra[3]);
                qryCadCor.FieldByName('SKY_QTDB' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat := StrToFloat(AnsiReplaceStr(Trim(slQuebra[4]), '.', ''));
                qryCadCor.Post;
                Break;
              End;
            End
            Else
            Begin
              If TStrUtils.fEmptyStr(qryCadCor.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intQuantidade, 2)).AsString) Then
              Begin
                qryCadCor.Edit;
                qryCadCor.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intQuantidade, 2)).AsString := Trim(slQuebra[3]);
                qryCadCor.FieldByName('SKY_QTDC' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat := StrToFloat(AnsiReplaceStr(Trim(slQuebra[4]), '.', ''));
                qryCadCor.Post;
                Break;
              End;
            End;
          End;
        End;

        Inc(intProcesso);
        Gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
      End;

      FreeAndNil(slArquivo);
      FreeAndNil(slQuebra);

      slArquivo     := TStringList.Create;
      slQuebra      := TStringList.Create;

      Gravando.Texto := 'Processando arquivos dos Produtos...';

      slArquivo.LoadFromFile(GetPath + '\' + 'Produto.txt');

      intProcesso := 0;
      Gravando.RegistrarProgresso(0, 0, 0);


      For intCont := 0 To slArquivo.Count - 1 Do
      Begin
        If gravando.Status <> sgGravando Then
          Exit;

        slQuebra.Delimiter := '|';
        slQuebra.StrictDelimiter := True;
        slQuebra.DelimitedText := slArquivo[intCont];

        qryCadCor.Close;
        qryCadCor.SQL := '  SELECT * FROM SKY_CADSKY WHERE SKY_CODPRO = :CODPRO  ';
        qryCadCor.ParamByName('CODPRO').AsString := Trim(slQuebra[0]);
        qryCadCor.Open;

        While Not qryCadCor.Eof Do
        Begin
          qryCadCor.Edit;
          qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SKY_CADSKY', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadCor.FieldByName('SKY_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadCor.FieldByName('SKY_DESCRI').AsString := Trim(slQuebra[1]);
          qryCadCor.FieldByName('SKY_ANOFAB').AsString := Trim(slQuebra[2]);
          qryCadCor.FieldByName('SKY_CODUNI').AsString := Trim(slQuebra[3]);
          qryCadCor.FieldByName('SKY_ANUANC').AsString := Trim(slQuebra[4]);
          qryCadCor.FieldByName('SKY_CORPAI').AsString := Trim(slQuebra[5]);
          qryCadCor.FieldByName('SKY_NACIMP').AsString := Trim(slQuebra[6]);
          qryCadCor.FieldByName('SKY_CODMON').AsString := Trim(slQuebra[7]);
          qryCadCor.FieldByName('SKY_CODGRU').AsString := Trim(slQuebra[10]);
          qryCadCor.FieldByName('SKY_CODSGR').AsString := Trim(slQuebra[11]);

          If qryCadCor.FieldByName('SKY_CONDIL').AsString = 'DILUIDO' Then
            qryCadCor.FieldByName('SKY_OBS001').AsString := Trim(slQuebra[9])
          Else
            qryCadCor.FieldByName('SKY_OBS001').AsString := Trim(slQuebra[8]);

          qryCadCor.FieldByName('SKY_VARIAN').AsString := fRetVariante(Trim(slQuebra[4]));
          qryCadCor.FieldByName('SKY_ATIVAD').AsString := 'S';
          qryCadCor.Post;

          qryCadCor.Next;
        End;

        Inc(intProcesso);
        Gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
      End;

      Gravando.Texto := 'Aplicando fator para as formulas PU...';
      Gravando.RegistrarProgresso(0, 0, 0);

      qryCadCor.Close;
      qryCadCor.SQL := '  SELECT * FROM SKY_CADSKY WHERE SKY_CODGRU = "6" ';
      qryCadCor.Open;
      qryCadCor.First;

      fltFator := 900 / 675;

      While Not qryCadCor.Eof Do
      Begin
        qryCadCor.Edit;
        For intCont := 1 To 20 Do
        Begin
          If qryCadCor.FieldByName('SKY_CONDIL').AsString = 'DILUIDO' Then
          Begin
            qryCadCor.FieldByName('SKY_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat := qryCadCor.FieldByName('SKY_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fltFator;
          End
          Else
          Begin
            If qryCadCor.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString = 'TH700' Then
            Begin
              qryCadCor.FieldByName('SKY_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat := qryCadCor.FieldByName('SKY_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fltFator;
            End;
          End;
        End;
        qryCadCor.Post;

        qryCadCor.Next;

        Gravando.RegistrarProgresso(0, qryCadCor.RecNo, qryCadCor.RecordCount);
      End;
    Except
      On E: Exception Do
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
    FreeAndNil(slArquivo);
    FreeAndNil(slQuebra);
  End;
end;

function TGravandoExecucaoSkyMixAutomotivaCores.fBaseMaiorQuantidade(
  qryGen: IDataSet; blnDiluido: Boolean): String;
Var
  intContador: Integer;
  fltQuantidade: Double;
  strBase: String;
begin
  If blnDiluido Then
    fltQuantidade := qryGen.FieldByName('SKY_QTDB01').AsFloat
  Else
    fltQuantidade := qryGen.FieldByName('SKY_QTDC01').AsFloat;

  For intContador := 2 To 20 Do
  Begin
    If TStrUtils.fEmptyStr(qryGen.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
      Break;

    If blnDiluido Then
    Begin
      If qryGen.FieldByName('SKY_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat > fltQuantidade Then
      Begin
        strBase := qryGen.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
        fltQuantidade := qryGen.FieldByName('SKY_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
      End;
    End
    Else
    Begin
      If qryGen.FieldByName('SKY_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat > fltQuantidade Then
      Begin
        strBase := qryGen.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
        fltQuantidade := qryGen.FieldByName('SKY_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
      End;
    End;
  End;

  Result := strBase;
end;

function TGravandoExecucaoSkyMixAutomotivaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoSkyMixAutomotivaCores.fMaiorQuantidade(
  qryGen: IDataSet; blnDiluido: Boolean): Double;
Var
  intContador: Integer;
  fltQuantidade: Double;
begin
  If blnDiluido Then
    fltQuantidade := qryGen.FieldByName('SKY_QTDB01').AsFloat
  Else
    fltQuantidade := qryGen.FieldByName('SKY_QTDC01').AsFloat;

  For intContador := 2 To 20 Do
  Begin
    If TStrUtils.fEmptyStr(qryGen.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
      Break;

    If blnDiluido Then
    Begin
      If qryGen.FieldByName('SKY_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat > fltQuantidade Then
        fltQuantidade := qryGen.FieldByName('SKY_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    End
    Else
    Begin
      If qryGen.FieldByName('SKY_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat > fltQuantidade Then
        fltQuantidade := qryGen.FieldByName('SKY_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    End;
  End;

  Result := fltQuantidade;
end;

function TGravandoExecucaoSkyMixAutomotivaCores.fQuantidadeRepeticao(
  qryGen: IDataSet): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To 20 Do
  Begin
    If TStrUtils.fEmptyStr(qryGen.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
      Break;

    Result := Result + 1;
  End;
end;

end.
