{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Liko *}
{**********************************************************************PH*}
unit untGravandoExecucaoLikoCores;

interface

uses
  untAbstractGravandoExecucaoLiko, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  Variants;

type
  TGravandoExecucaoLikoCores = class(TAbstractGravandoExecucaoLiko)
  private
    function fRetornaFatorUnidade(strUnidade:String):Double;
    function fRetProximoCodSeq():Integer;
    function fRetCodEmbalagem(strCodEmbOrigem, strUniDes: String):String;
    function fStrToFloatLiko(strValorUnico:String): Double;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoLikoCores }

procedure TGravandoExecucaoLikoCores.Executar(const gravando: IGravando);
var
  OlePlanilha, oleSheet: OleVariant;
  intLinha, intUltimaLinha: Integer;
  qryCadLik: IDataSet;
  fltFator: Double;
  intForm, intUnidade : Integer;
  blnFimPlanilha: Boolean;
const
  ArrUnidade: Array[1..3] Of String = ('LT', 'GL', 'LA');
begin
  Try
    Try
      If Not FileExists(GetPath) Then
      Begin
        gravando.texto := Format('O arquivo %s não existe', [AnsiReplaceStr(GetPath, '"', '')]);
        gravando.Cancelar;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando Dados do Cadastro de Cores...';
      olePlanilha := CreateOleObject('Excel.Application');
      olePlanilha.Visible := False;
      olePlanilha.WorkBooks.Open(GetPath);
      oleSheet := olePlanilha.WorkSheets[1];

      intUltimaLinha := 2;
      blnFimPlanilha := False;
      While Not blnFimPlanilha Do
      Begin
        Inc(intUltimaLinha);
        If oleSheet.Cells[intUltimaLinha, 1].Text = '' Then
        Begin
          blnFimPlanilha := True;
          Dec(intUltimaLinha);
        End;
      End;

      qryCadLik := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Cadastro de Cores...';
      qryCadLik.SQL := '    DELETE FROM LIK_CADLIK    ';
      qryCadLik.ExecSQL;
      qryCadLik.SQL.Empty;
      Gravando.Texto := 'Cadastro de Cores Deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('LIK_CADLIK');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Cores...';
      qryCadLik.SQL := '    SELECT * FROM LIK_CADLIK    ';
      qryCadLik.Open;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      Try
        For intLinha := 2 To intUltimaLinha Do
        Begin
          For intUnidade := 1 To 3 Do
          Begin
            If Not qryCadLik.Locate('LIK_DESCRI;LIK_UNIDAD;LIK_CODIGO;LIK_CODBAS', VarArrayOf([AnsiUpperCase(oleSheet.Cells[intLinha, 4].Text), arrUnidade[intUnidade],
                                    oleSheet.Cells[intLinha, 3].Text, oleSheet.Cells[intLinha, 5].Text]), []) Then
            Begin
              qryCadLik.Insert;
              qryCadLik.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LIK_CADLIK', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadLik.FieldByName('LIK_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
              qryCadLik.FieldByName('LIK_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadLik.FieldByName('LIK_DESCRI').AsString := AnsiUpperCase(oleSheet.Cells[intLinha, 4].Text);
              qryCadLik.FieldByName('LIK_CODIGO').AsString := oleSheet.Cells[intLinha, 3].Text;
              qryCadLik.FieldByName('LIK_UNIDAD').AsString := ArrUnidade[intUnidade];
              qryCadLik.FieldByName('LIK_CODUNI').AsString := qryCadLik.FieldByName('LIK_UNIDAD').AsString;
              qryCadLik.FieldByName('LIK_CODBAS').AsString := oleSheet.Cells[intLinha, 5].Text;
              qryCadLik.FieldByName('LIK_CODEMB').AsString := fRetCodEmbalagem('2', qryCadLik.FieldByName('LIK_CODUNI').AsString);
              qryCadLik.FieldByName('LIK_PRODUT').AsString := oleSheet.Cells[intLinha, 1].Text;
              qryCadLik.FieldByName('LIK_ACABAM').AsString := oleSheet.Cells[intLinha, 2].Text;
              qryCadLik.FieldByName('LIK_MD5KEY').AsString := GetMD5(qryCadLik.FieldByName('LIK_DESCRI').AsString +
                                                                     qryCadLik.FieldByName('LIK_CODIGO').AsString +
                                                                     qryCadLik.FieldByName('LIK_UNIDAD').AsString +
                                                                     qryCadLik.FieldByName('LIK_CODBAS').AsString +
                                                                     qryCadLik.FieldByName('LIK_CODEMB').AsString +
                                                                     qryCadLik.FieldByName('LIK_CODUNI').AsString +
                                                                     qryCadLik.FieldByName('LIK_PRODUT').AsString +
                                                                     qryCadLik.FieldByName('LIK_ACABAM').AsString);

              If Not TStrUtils.fEmptyStr(oleSheet.Cells[intLinha, 7].Text) Then
              Begin
                qryCadLik.FieldByName('LIK_FORM01').AsString := oleSheet.Cells[intLinha, 7].Text;
                qryCadLik.FieldByName('LIK_QTDC01').AsFloat :=  fStrToFloatLiko(oleSheet.Cells[intLinha, 8].Text);
              End;

              If Not TStrUtils.fEmptyStr(oleSheet.Cells[intLinha, 9].Text) Then
              Begin
                qryCadLik.FieldByName('LIK_FORM02').AsString := oleSheet.Cells[intLinha, 9].Text;
                qryCadLik.FieldByName('LIK_QTDC02').AsFloat := fStrToFloatLiko(oleSheet.Cells[intLinha, 10].Text);
              End;

              If Not TStrUtils.fEmptyStr(oleSheet.Cells[intLinha, 11].Text) Then
              Begin
                qryCadLik.FieldByName('LIK_FORM03').AsString := oleSheet.Cells[intLinha, 11].Text;
                qryCadLik.FieldByName('LIK_QTDC03').AsFloat := fStrToFloatLiko(oleSheet.Cells[intLinha, 12].Text);
              End;

              If Not TStrUtils.fEmptyStr(oleSheet.Cells[intLinha, 13].Text) Then
              Begin
                qryCadLik.FieldByName('LIK_FORM04').AsString := oleSheet.Cells[intLinha, 13].Text;
                qryCadLik.FieldByName('LIK_QTDC04').AsFloat := fStrToFloatLiko(oleSheet.Cells[intLinha, 14].Text);
              End;

              If Not TStrUtils.fEmptyStr(oleSheet.Cells[intLinha, 15]) Then
              Begin
                qryCadLik.FieldByName('LIK_FORM05').AsString := oleSheet.Cells[intLinha, 15].Text;
                qryCadLik.FieldByName('LIK_QTDC05').AsFloat := fStrToFloatLiko(oleSheet.Cells[intLinha, 16].Text);
              End;

              If Not TStrUtils.fEmptyStr(oleSheet.Cells[intLinha, 17].Text) Then
              Begin
                qryCadLik.FieldByName('LIK_FORM06').AsString := oleSheet.Cells[intLinha, 17].Text;
                qryCadLik.FieldByName('LIK_QTDC06').AsFloat := fStrToFloatLiko(oleSheet.Cells[intLinha, 18].Text);
              End;

              If Not TStrUtils.fEmptyStr(oleSheet.Cells[intLinha, 19].Text) Then
              Begin
                qryCadLik.FieldByName('LIK_FORM07').AsString := oleSheet.Cells[intLinha, 19].Text;
                qryCadLik.FieldByName('LIK_QTDC07').AsFloat := fStrToFloatLiko(oleSheet.Cells[intLinha, 20].Text);
              End;

              If Not TStrUtils.fEmptyStr(oleSheet.Cells[intLinha, 21].Text) Then
              Begin
                qryCadLik.FieldByName('LIK_FORM08').AsString := oleSheet.Cells[intLinha, 21].Text;
                qryCadLik.FieldByName('LIK_QTDC08').AsFloat := fStrToFloatLiko(oleSheet.Cells[intLinha, 22].Text);
              End;



              fltFator := fRetornaFatorUnidade(ArrUnidade[intUnidade]);

              For intForm := 1 To 8 Do
              Begin
                If (qryCadLik.FieldByName('LIK_QTDC' + TStrUtils.fStrZero(intForm, 2)).AsFloat <> 0) Then
                  qryCadLik.FieldByName('LIK_QTDC' + TStrUtils.fStrZero(intForm, 2)).AsFloat :=
                    qryCadLik.FieldByName('LIK_QTDC' + TStrUtils.fStrZero(intForm, 2)).AsFloat * fltFator;
              End;

              qryCadLik.Post;
            End;
          End;
          Gravando.RegistrarProgresso(0, intLinha - 1, intUltimaLinha - 1);
        End;
      Except
        On E: Exception Do
        Begin
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;

      End;

    Except
      On  E: Exception  Do
      Begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally
    If Not VarIsEmpty(olePlanilha) Then
    Begin
      olePlanilha.Quit;
      olePlanilha := Unassigned;
      oleSheet := Unassigned;
    End;

    Gravando.Texto := 'Cadastro de Cores foi processado...';
  End;
end;


function TGravandoExecucaoLikoCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoLikoCores.fRetCodEmbalagem(strCodEmbOrigem,
  strUniDes: String): String;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT EMB_CODEMB, EMB_UNIDAD FROM LIK_CADEMB WHERE EMB_QTDEMB IN (900, 3600, 18000)    ';
    qryGen.Open;

    If qryGen.Locate('EMB_UNIDAD', strUniDes, []) Then
      Result := qryGen.FieldByName('EMB_CODEMB').AsString
    Else
      Result := strCodEmbOrigem;

  Except
    Raise;
  End;
end;

function TGravandoExecucaoLikoCores.fRetornaFatorUnidade(
  strUnidade: String): Double;
begin
  If strUnidade = 'LT' Then
    Result := 0.25
  Else If strUnidade = 'GL' Then
    Result := 1
  Else
    Result := 5;
end;

function TGravandoExecucaoLikoCores.fRetProximoCodSeq: Integer;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT IFNULL(MAX(CONVERT(LIK_CODSEQ, SIGNED)), 0) + 1 AS MAXIMO FROM LIK_CADLIK;    ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;

end;


function TGravandoExecucaoLikoCores.fStrToFloatLiko(
  strValorUnico: String): Double;
begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',','),0);
end;

end.
