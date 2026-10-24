{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Sayerlack *}
{***************************************************************************PH*}
unit untGravandoExecucaoSayerlackColorantes;

interface

uses
  untAbstractGravandoExecucaoSayerlack, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoSayerlackColorantes = class(TAbstractGravandoExecucaoSayerlack)
  private
    PlanilhaExcel: TStringList;
    qryAdoColEmb: TADODataSet;
    blnEmbalagem: Boolean;
    function fRetDesUni(strDesEmb:String):String;
    function fGetEmbalagem(strDescri:String):Double;
  public
    function fGetNomeGravacao: string; override;
    procedure pCarregarVariaveis(strPathFile: String);
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils;
{ TGravandoExecucaoSayerlackCores }

procedure TGravandoExecucaoSayerlackColorantes.Executar(const gravando: IGravando);
Var
  qryCadCol: IDataSet;
  qryCadEmb: IDataSet;
begin
  Gravando.Texto := 'Validando path do arquivo...';



  If Not fValidaPath Then
  Begin
    Gravando.Texto := Format('O arquivo %s não existe!', [AnsiReplaceStr(GetPath, '"', '')]);
    Exit;
  End;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  blnEmbalagem := False;

  Gravando.Texto := 'Path validado com sucesso...';

  Gravando.Texto := 'Carregando dados do Cadastro de Colorantes...';
  pCarregarVariaveis(GetPath);

  qryAdoColEmb.Open;
  qryAdoColEmb.First;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('SAY_CADCOL');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Abrindo Cadastro de Colorantes...';
  qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadCol.SQL := '    SELECT * FROM SAY_CADCOL    ';
  qryCadCol.Open;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  gravando.Texto := Format('Processando Colorantes [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
  Gravando.RegistrarProgresso(0, 0, 0);

  Try
    Try
      While Not qryAdoColEmb.Eof Do
      Begin
        If Not qryCadCol.Locate('COL_CODCOL', VarArrayOf([qryAdoColEmb.FieldByName('CNT').AsString]), []) Then
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadCol.Insert;
          qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SAY_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadCol.FieldByName('COL_CODCOL').AsString := qryAdoColEmb.FieldByName('CNT').AsString;
          qryCadCol.FieldByName('COL_DESCRI').AsString := qryAdoColEmb.FieldByName('DES').AsString;
          qryCadCol.FieldByName('COL_EMBALA').AsFloat := 1000;
          qryCadCol.Post;
        End;
        qryAdoColEmb.Next;
        Gravando.RegistrarProgresso(0, qryAdoColEmb.RecNo, qryAdoColEmb.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    Gravando.Texto := 'Cadastro de Colorantes processado com sucesso!';
  End;

  qryAdoColEmb.Close;
  blnEmbalagem := True;

  Gravando.Texto := 'Carregando dados do Cadastro de Embalagem...';
  pCarregarVariaveis(GetPath);

  qryAdoColEmb.Open;
  qryAdoColEmb.First;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('SAY_CADEMB');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Abrindo Cadastro de Embalagem...';
  qryCadEmb := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadEmb.SQL := '    SELECT * FROM SAY_CADEMB    ';
  qryCadEmb.Open;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := Format('Processando Embalagens [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
  Gravando.RegistrarProgresso(0 ,0, 0);

  Try
    Try
      While Not qryAdoColEmb.Eof Do
      Begin
        If Not qryCadEmb.Locate('EMB_DESEMB', VarArrayOf([fRetDesUni(qryAdoColEmb.FieldByName('EMBALA').AsString)]), []) Then
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadEmb.Insert;
          qryCadEmb.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SAY_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadEmb.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadEmb.FieldByName('EMB_CODUNI').AsString := qryAdoColEmb.FieldByName('EMBALA').AsString;
          qryCadEmb.FieldByName('EMB_DESEMB').AsString := fRetDesUni(qryCadEmb.FieldByName('EMB_CODUNI').AsString);
          qryCadEmb.FieldByName('EMB_EMBALA').AsFloat  := fGetEmbalagem(qryAdoColEmb.FieldByName('EMBALA').AsString);
          qryCadEmb.Post;

        End;

        qryAdoColEmb.Next;
        Gravando.RegistrarProgresso(0, qryAdoColEmb.RecNo, qryAdoColEmb.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;

    End;
  Finally
    Gravando.Texto := 'Cadastro de Embalagem processado com sucesso!';
  End;




end;

function TGravandoExecucaoSayerlackColorantes.fGetEmbalagem(
  strDescri: String): Double;
begin
  If Trim(UpperCase(strDescri)) = 'QT' Then
    Result := 0.81
  Else If Trim(UpperCase(strDescri)) = 'GL' Then
    Result := 3.24
  Else If Trim(UpperCase(strDescri)) = 'BH' Then
    Result := 18
  Else
    Result := 1;

end;

function TGravandoExecucaoSayerlackColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes/Embalagens';
end;

function TGravandoExecucaoSayerlackColorantes.fRetDesUni(
  strDesEmb: String): String;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT UNI_DESUNI FROM CADUNI WHERE UNI_CODUNI = :CODUNI    ';
    qryGen.ParamByName('CODUNI').AsString := strDesEmb;
    qryGen.Open;

    If qryGen.IsEmpty Then
      Result := strDesEmb
    Else
      Result := qryGen.FieldByName('UNI_DESUNI').AsString;
  Except
    Raise;
  End;
end;

procedure TGravandoExecucaoSayerlackColorantes.pCarregarVariaveis(
  strPathFile: String);
begin
  qryAdoColEmb := TADODataSet.Create(Nil);

  qryAdoColEmb.Connection := fGetDataSayerlack(strPathFile);

  PlanilhaExcel := TStringList.Create;

  GetSayer.GetTableNames(PlanilhaExcel);

  If Not blnEmbalagem Then
  Begin
  qryAdoColEmb.CommandText := '   SELECT     ' +
                                 '     F2 AS CNT,    ' +
                                 '     F3 AS DES     ' +
                                 '   FROM       ' +
                                 '     [PIGMENT$]    ' +
                                 '   WHERE      ' +
                                 '     F2 <> ''''    ' +
                                 '    AND F2 <> ''PigmentCode''     ';
  End
  Else
  Begin
    qryAdoColEmb.CommandText := '   SELECT DISTINCT          ' +
                                '     B.F6 AS [EMBALA]          ' +
                                '   FROM                     ' +
                                '     [BASEPACK$] AS B          ' +
                                '   WHERE                    ' +
                                '     NOT B.F6 IN ('''', ''PackCode'')  ';

  End;

end;

end.

