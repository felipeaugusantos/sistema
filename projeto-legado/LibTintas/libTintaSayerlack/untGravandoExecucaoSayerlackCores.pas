{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Sayerlack *}
{**********************************************************************PH*}
unit untGravandoExecucaoSayerlackCores;

interface

uses
  untAbstractGravandoExecucaoSayerlack, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoSayerlackCores = class(TAbstractGravandoExecucaoSayerlack)
  private
    PlanilhaExcel: TStringList;
    qryAdoFormulas: TADODataSet;
    function fGetQuantidade(qryFormulas: TADODataSet; qryBases: IDataSet; intPos: Integer):Double;
    function fGetFatorUnidade(strUnidade:String):Double;
    function fRetQtdEmbalagem(strDesEmb:String):Double;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    procedure pCarregarVariaveis(strPathFile: String);
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils;

{ TGravandoExecucaoSayerlackCores }

procedure TGravandoExecucaoSayerlackCores.Executar(const gravando: IGravando);
Var
  qryBases, qryCadSay: IDataSet;
  intContador: Integer;
  fltQtd: Double;
  strMd5Key: String;
begin
  Gravando.Texto := 'Validando path do arquivo...';

  If Not fValidaPath Then
  Begin
    Gravando.Texto := Format('O arquivo %s não existe!', [AnsiReplaceStr(GetPath, '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Path validado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Carregando dados do Cadastro de Fórmulas...';
  pCarregarVariaveis(GetPath);
  qryAdoFormulas.Open;
  qryAdoFormulas.First;


  Gravando.Texto := 'Deletando Cadastro de Fórmulas...';
  qryCadSay := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadSay.SQL := '    DELETE FROM SAY_CADSAY    ';
  qryCadSay.ExecSQL;
  Gravando.Texto := 'Cadastro de Fórmulas deletado...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('SAY_CADSAY');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Abrindo Cadastro de Fórmulas...';
  qryCadSay.SQL.Empty;
  qryCadSay.SQL := '    SELECT * FROM SAY_CADSAY    ';
  qryCadSay.Open;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := Format('Processando Fórmulas [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
  Gravando.RegistrarProgresso(0, 0, 0);

  Try
    Try
      While Not qryAdoFormulas.Eof Do
      Begin
        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := '   SELECT BAS_BASE__, BAS_CODBAS, BAS_DESEMB   ' +
                        '     FROM SAY_CADBAS                           ' +
                        '   WHERE BAS_PRODUT = ''' + qryAdoFormulas.FieldByName('PROD').AsString + '''';
        qryBases.Open;
        qryBases.First;

        While Not qryBases.Eof Do
        Begin

          strMd5Key := '';

          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadSay.Insert;
          qryCadSay.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SAY_CADSAY', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadSay.FieldByName('SAY_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadSay.FieldByName('SAY_BASE__').AsString := qryBases.FieldByName('BAS_BASE__').AsString;
          qryCadSay.FieldByName('SAY_CODBAS').AsString := qryBases.FieldByName('BAS_CODBAS').AsString;
          qryCadSay.FieldByName('SAY_DESEMB').AsString := qryBases.FieldByName('BAS_DESEMB').AsString;
          qryCadSay.FieldByName('SAY_PRODUT').AsString := qryAdoFormulas.FieldByName('PROD').AsString;
          qryCadSay.FieldByName('SAY_DESCRI').AsString := qryAdoFormulas.FieldByName('DESC').AsString;
          qryCadSay.FieldByName('SAY_COMENT').AsString := qryAdoFormulas.FieldByName('COMMENT').AsString;
          qryCadSay.FieldByName('SAY_CODIGO').AsString := qryAdoFormulas.FieldByName('COLORCODE').AsString;

          strMd5Key := strMd5Key + qryCadSay.FieldByName('SAY_BASE__').AsString;
          strMd5Key := strMd5Key + qryCadSay.FieldByName('SAY_CODBAS').AsString;
          strMd5Key := strMd5Key + qryCadSay.FieldByName('SAY_PRODUT').AsString;
          strMd5Key := strMd5Key + qryCadSay.FieldByName('SAY_CODIGO').AsString;
          strMd5Key := strMd5Key + qryCadSay.FieldByName('SAY_DESEMB').AsString;

          For intContador := 1 To 7 Do
          Begin

            If TStrUtils.fEmptyStr(qryAdoFormulas.FieldByName('CNT' + IntToStr(intContador)).AsString) Then
              Break;


            qryCadSay.FieldByName('SAY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString :=
              qryAdoFormulas.FieldByName('CNT' + IntToStr(intContador)).AsString;

            fltQtd := fGetQuantidade(qryAdoFormulas, qryBases, intContador);

            qryCadSay.FieldByName('SAY_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := fltQtd;

            strMd5Key := strMd5Key + qryCadSay.FieldByName('SAY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
            strMd5Key := strMd5Key + StringReplace(FormatFloat('0.0000', qryCadSay.FieldByName('SAY_QTDC' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsFloat),
              ',', '.', [rfReplaceAll]);
          End;

          qryCadSay.FieldByName('SAY_MD5KEY').AsString := GetMd5(strMd5Key);

          qryCadSay.Post;
          qryBases.Next;
        End;
        qryAdoFormulas.Next;
        Gravando.RegistrarProgresso(0, qryAdoFormulas.RecNo, qryAdoFormulas.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    Gravando.Texto := 'Cadastro de Fórmulas processado com sucesso...';
  End;
end;

function TGravandoExecucaoSayerlackCores.fGetFatorUnidade(
  strUnidade: String): Double;
begin
  If Trim(UpperCase(strUnidade)) = 'QT' Then
    Result := 0.81
  Else If Trim(UpperCase(strUnidade)) = 'GL' Then
    Result := 3.24
  Else If Trim(UpperCase(strUnidade)) = 'BH' Then
    Result := 18
  Else
    Result := 1;

end;

function TGravandoExecucaoSayerlackCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoSayerlackCores.fGetQuantidade(
  qryFormulas: TADODataSet; qryBases: IDataSet; intPos: Integer): Double;
Var
  fltFator1, fltFator2:Double;
begin
  fltFator1 := fGetFatorUnidade(qryFormulas.FieldByName('EMBALA').AsString);
  fltFator2 := fRetQtdEmbalagem(qryBases.FieldByName('BAS_DESEMB').AsString);
  Result := TAutcomTintaFactory.Get.fStrToFloat(StringReplace(qryFormulas.FieldByName('QNT' + IntToStr(intPos)).AsString, '.', ',', [rfReplaceAll])) *
    fltFator2 / fltFator1;
end;

function TGravandoExecucaoSayerlackCores.fRetQtdEmbalagem(
  strDesEmb: String): Double;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT EMB_EMBALA FROM SAY_CADEMB WHERE EMB_DESEMB = :DESEMB    ';
    qryGen.ParamByName('DESEMB').AsString := strDesEmb;
    qryGen.Open;

    Result := qryGen.FieldByName('EMB_EMBALA').AsFloat;
  Except
    Raise;
  End;
end;

procedure TGravandoExecucaoSayerlackCores.pCarregarVariaveis(
  strPathFile: String);
begin
  qryAdoFormulas := TADODataSet.Create(Nil);
  qryAdoFormulas.Connection := fGetDataSayerlack(strPathFile);

  PlanilhaExcel := TStringList.Create;
  GetSayer.GetTableNames(PlanilhaExcel);

  qryAdoFormulas.CommandText := '   SELECT                  ' +
                                '     P.F2 AS [COLORCODE],     ' +
                                '     C.F6 AS [COMMENT],       ' +
                                '     C.F9 AS [PROD],          ' +
                                '     C.F3 AS [DESC],          ' +
                                '     P.F3 AS [EMBALA],        ' +
                                '     P.F4 AS [CNT1],         ' +
                                '     P.F6 AS [CNT2],         ' +
                                '     P.F8 AS [CNT3],         ' +
                                '     P.F10 AS [CNT4],        ' +
                                '     P.F12 AS [CNT5],        ' +
                                '     P.F14 AS [CNT6],        ' +
                                '     P.F16 AS [CNT7],        ' +
                                '     P.F5 AS [QNT1],         ' +
                                '     P.F7 AS [QNT2],         ' +
                                '     P.F9 AS [QNT3],         ' +
                                '     P.F11 AS [QNT4],        ' +
                                '     P.F13 AS [QNT5],        ' +
                                '     P.F15 AS [QNT6],        ' +
                                '     P.F17 AS [QNT7]         ' +
                                '   FROM                    ' +
                                '     [COLOR$] AS C,           ' +
                                '     [COLPIGMPACK$] AS P      ' +
                                '   WHERE                   ' +
                                '     P.F2 = C.F2              ' +
                                '   AND P.F2 <> ''ColorCode''  ' +
                                '   AND C.F2 <> ''ColorCode''  ' +
                                '   AND C.F2 <> ''9995 BS''    ' +
                                '   AND C.F2 <> ''''           ' ;
end;

end.
