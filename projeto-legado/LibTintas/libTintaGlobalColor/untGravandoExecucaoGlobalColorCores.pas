{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta GlobalColor *}
{**********************************************************************PH*}
unit untGravandoExecucaoGlobalColorCores;

interface

uses
  untAbstractGravandoExecucaoGlobalColor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  Variants, Math, ADODB;

type
  TGravandoExecucaoGlobalColorCores = class(TAbstractGravandoExecucaoGlobalColor)
  private
    function fRetProximoCodSeq():Integer;
    function fRetFatorUnidade(strUnidade:String):Double;
    function fRetCodEmbalagem(strCodEmbOrigem, strUniDes:String):String;
    function fStrToFloatGlobalColor(strValorUnico:String):Double;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoGlobalColorCores }

procedure TGravandoExecucaoGlobalColorCores.Executar(const gravando: IGravando);
Var
  olePlanilha, oleSheet: OleVariant;
  intLinha, intUltimaLinha: Integer;
  blnFimPlanilha: Boolean;
  qryCadGlo : IDataSet;
  intFormula,
  intUnidade,
  intFolha: Integer;
  fltFator:Double;
Const
  ArrayUnidade: Array[1..3] Of String = ('LT', 'GL', 'LA');
  ArrayProduto: Array[1..15] Of String = ('ACRILICO FOSCO PREMIUM',
    'ESMALTE SINTETICO ACETINADO PREMIUM',
    'ESMALTE SINTETICO BRILHANTE PREMIUM',
    'ACRILICO SEMI BRILHO PREMIUM',
    'ACRILICO ACETINADO PREMIUM',
    'ESMALTE BRILHANTE BASE AGUA',
    'ESMALTE ACETINADO BASE AGUA',
    'LATEX VINIL ACRILICO ECONOMICO',
    'ESMALTE SINTETICO STANDARD',
    'ESMALTE SINTETICO SECAGEM RAPIDA',
    'ACRILICO ULTRA STANDARD',
    'GEL ENVELHECEDOR',
    'TEXTURA ACRILICA LISA',
    'TEXTURA ACRILICA RUSTICA',
    'TEXTURA ACRILICA DESENHO');

begin
  Gravando.Texto := 'Validando path do Arquivo...';

  If Not fValidaPath Then
  Begin
    Gravando.Texto := Format('O path configurado %s não existe', [AnsiReplaceStr(GetPath, '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Path validado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  intFormula := 0;

  Gravando.Texto := 'Carregando dados do Cadastro de Cores...';

  olePlanilha := CreateOleObject('Excel.Application');
  olePlanilha.Visible := False;
  olePlanilha.WorkBooks.Open(GetPath);

  Gravando.Texto := 'Deletando Cadastro de Cores...';
  qryCadGlo := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadGlo.SQL := 'DELETE FROM GLO_CADGLO';
  qryCadGlo.ExecSQL;
  Gravando.Texto := 'Cadastro de Cores deletado...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('GLO_CADGLO');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  qryCadGlo.SQL.Empty;
  Gravando.Texto := 'Abrindo Cadastro de Cores...';
  qryCadGlo.SQL := '    SELECT * FROM GLO_CADGLO WHERE FALSE    ';
  qryCadGlo.Open;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := Format('Processando Cadastro[%s]', [AnsiReplaceStr(GetPath, '"', '')]);
  Gravando.RegistrarProgresso(0, 0, 0);

  Try
    Try
      For intFolha := 1 To 15 Do
      Begin
        oleSheet := olePlanilha.WorkSheets[intFolha];

        intUltimaLinha := 3;
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

        For intLinha := 3 To intUltimaLinha Do
        Begin
          For intUnidade := 1 To 3 Do
          Begin
            If Not qryCadGlo.Locate('GLO_CODBAS;GLO_CODIGO;GLO_UNIDAD;GLO_PRODUT', VarArrayOf([oleSheet.Cells[intLinha, 2].Text, oleSheet.Cells[intLinha, 1].Text,
              ArrayUnidade[intUnidade], ArrayProduto[intFolha]]), []) Then
            Begin
              If (Gravando.Status <> sgGravando) Then
                Break;

              Inc(intFormula);

              qryCadGlo.Insert;
              qryCadGlo.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('GLO_CADGLO', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadGlo.FieldByName('GLO_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadGlo.FieldByName('GLO_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
              qryCadGlo.FieldByName('GLO_DESCRI').AsString := AnsiUpperCase(oleSheet.Cells[intLinha, 3].Text);
              qryCadGlo.FieldByName('GLO_CODIGO').AsString := oleSheet.Cells[intLinha, 1].Text;
              qryCadGlo.FieldByName('GLO_UNIDAD').AsString := ArrayUnidade[intUnidade];
              qryCadGlo.FieldByName('GLO_CODUNI').AsString := qryCadGlo.FieldByName('GLO_UNIDAD').AsString;
              qryCadGlo.FieldByName('GLO_CODBAS').AsString := oleSheet.Cells[intLinha, 2].Text;
              qryCadGlo.FieldByName('GLO_CODEMB').AsString := fRetCodEmbalagem('2', qryCadGlo.FieldByName('GLO_CODUNI').AsString);
              qryCadGlo.FieldByName('GLO_PRODUT').AsString := ArrayProduto[intFolha];
              qryCadGlo.FieldByName('GLO_MD5KEY').AsString := GetMD5(qryCadGlo.FieldByName('GLO_DESCRI').AsString +
                                                                     qryCadGlo.FieldByName('GLO_CODIGO').AsString +
                                                                     qryCadGlo.FieldByName('GLO_UNIDAD').AsString +
                                                                     qryCadGlo.FieldByName('GLO_CODBAS').AsString +
                                                                     qryCadGlo.FieldByName('GLO_CODEMB').AsString +
                                                                     qryCadGlo.FieldByName('GLO_CODUNI').AsString +
                                                                     qryCadGlo.FieldByName('GLO_PRODUT').AsString);

              fltFator := fRetFatorUnidade(qryCadGlo.FieldByName('GLO_UNIDAD').AsString);

              If Not TStrUtils.fEmptyStr(oleSheet.Cells[intLinha, 4].Text) Then
              Begin
                qryCadGlo.FieldByName('GLO_FORM01').AsString := oleSheet.Cells[intLinha, 4].Text;
                qryCadGlo.FieldByName('GLO_QTDC01').AsFloat  := RoundTo(((fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 5].Text) * 29.574) +
                  (fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 6].Text) * 0.616125)) * fltFator / 3.24, -4);
              End;

              If Not TStrUtils.fEmptyStr(oleSheet.Cells[intLinha, 7].Text) Then
              Begin
                qryCadGlo.FieldByName('GLO_FORM02').AsString := oleSheet.Cells[intLinha, 7].Text;
                qryCadGlo.FieldByName('GLO_QTDC02').AsFloat  := RoundTo(((fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 8].Text) * 29.574) +
                  (fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 9].Text) * 0.616125)) * fltFator / 3.24, -4);
              End;

              If Not TStrUtils.fEmptyStr(oleSheet.Cells[intLinha, 10].Text) Then
              Begin
                qryCadGlo.FieldByName('GLO_FORM03').AsString := oleSheet.Cells[intLinha, 10].Text;
                qryCadGlo.FieldByName('GLO_QTDC03').AsFloat  := RoundTo(((fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 11].Text) * 29.574) +
                  (fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 12].Text) * 0.616125)) * fltFator / 3.24, -4);
              End;

              If Not TStrUtils.fEmptyStr(oleSheet.Cells[intLinha, 13].Text) Then
              Begin
                qryCadGlo.FieldByName('GLO_FORM04').AsString := oleSheet.Cells[intLinha, 13].Text;
                qryCadGlo.FieldByName('GLO_QTDC04').AsFloat  := RoundTo(((fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 14].Text) * 29.574) +
                  (fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 15].Text) * 0.616125)) * fltFator / 3.24, -4);
              End;

              qryCadGlo.Post;
              gravando.RegistrarProgresso(0, intFormula, (intUltimaLinha - 2) * 15 * 3 );
            End;
          End;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    Gravando.Texto := 'Cadastro de Cores finalizado com sucesso...';

    If Not VarIsEmpty(olePlanilha) Then
    Begin
      olePlanilha.Quit;
      olePlanilha := Unassigned;
      oleSheet    := Unassigned;
    End;

  End;
end;


function TGravandoExecucaoGlobalColorCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoGlobalColorCores.fRetCodEmbalagem(strCodEmbOrigem,
  strUniDes: String): String;
var
  qryGen : IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT EMB_CODEMB, EMB_UNIDAD FROM GLO_CADEMB WHERE EMB_QTDEMB IN (810, 3240, 16200)';
    qryGen.Open;

    If qryGen.Locate('EMB_UNIDAD', strUniDes, []) Then
      Result := qryGen.FieldByName('EMB_CODEMB').AsString
    Else
      Result := strCodEmbOrigem;

  Except
    Raise;
  End;
end;

function TGravandoExecucaoGlobalColorCores.fRetFatorUnidade(
  strUnidade: String): Double;
begin
  Result := 1;

  If strUnidade = 'LT' Then
    Result := 0.81
  Else If strUnidade = 'GL' Then
    Result := 3.24
  Else If strUnidade = 'LA' Then
    Result := 16.2;
end;

function TGravandoExecucaoGlobalColorCores.fRetProximoCodSeq(): Integer;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT IFNULL(MAX(CONVERT(GLO_CODSEQ, SIGNED)), 0) + 1 AS MAXIMO FROM GLO_CADGLO';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;
end;

function TGravandoExecucaoGlobalColorCores.fStrToFloatGlobalColor(
  strValorUnico: String): Double;
begin
  Result := StrToFloatDef(AnsiReplaceStr(strValorUnico, '.' , ','), 0);
end;

end.
