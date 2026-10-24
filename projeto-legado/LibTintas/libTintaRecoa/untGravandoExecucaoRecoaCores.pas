{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Recoa *}
{**********************************************************************PH*}
unit untGravandoExecucaoRecoaCores;

interface

uses
  untAbstractGravandoExecucaoRecoa, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  Variants, Math, ADODB;

type
  TGravandoExecucaoRecoaCores = class(TAbstractGravandoExecucaoRecoa)
  private
    qryAdoCores: TADOQuery;
    function fRetornaProximoCodSeq():Integer;
    function fRetFatorUnidade(strUnidade:String):Double;
    function fRetCodEmbalagem(strCodEmbOrigem,strUniDes: String): String;
    function fStrToFloatRecoa(strValorUnico:String): Double;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoRecoaCores }

procedure TGravandoExecucaoRecoaCores.Executar(const gravando: IGravando);
var
  qryCadRec: IDataSet;
  fltFator: Double;
  intUnidade: Integer;
const
  ArrayUnidade: Array[0..2] Of String = ('LT', 'GL', 'LA');
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

      qryAdoCores := TADOQuery.Create(Nil);
      qryAdoCores.Connection := fConexaoRecoa;

      qryAdoCores.Close;
      qryAdoCores.SQL.Clear;
      qryAdoCores.SQL.Add('   SELECT    ');
      qryAdoCores.SQL.Add('     FORMULAS.F1,      ');
      qryAdoCores.SQL.Add('     FORMULAS.F2,      ');
      qryAdoCores.SQL.Add('     FORMULAS.F3,      ');
      qryAdoCores.SQL.Add('     FORMULAS.F4,      ');
      qryAdoCores.SQL.Add('     FORMULAS.F5,      ');
      qryAdoCores.SQL.Add('     FORMULAS.F6,      ');
      qryAdoCores.SQL.Add('     FORMULAS.F7,      ');
      qryAdoCores.SQL.Add('     FORMULAS.F8,      ');
      qryAdoCores.SQL.Add('     FORMULAS.F9,      ');
      qryAdoCores.SQL.Add('     FORMULAS.F10,     ');
      qryAdoCores.SQL.Add('     FORMULAS.F11,     ');
      qryAdoCores.SQL.Add('     BASES.COD_BASE    ');
      qryAdoCores.SQL.Add('   FROM    ');
      qryAdoCores.SQL.Add('     FORMULAS,         ');
      qryAdoCores.SQL.Add('     BASES             ');
      qryAdoCores.SQL.Add('   WHERE   ');
      qryAdoCores.SQL.Add('     FORMULAS.F1 = BASES.PRODUTO    ');
      qryAdoCores.SQL.Add('   AND   ');
      qryAdoCores.SQL.Add('     FORMULAS.F4 = BASES.BASE       ');
      qryAdoCores.Open;

      qryCadRec := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando o Cadastro de Cores...';
      qryCadRec.SQL := '    DELETE FROM REC_CADREC    ';
      qryCadRec.ExecSQL;
      Gravando.Texto := 'Cadastro de Cores Deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REC_CADREC');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Abrindo Cadastro de Cores...';
      qryCadRec.SQL.Empty;
      qryCadRec.SQL := '    SELECT *  FROM  REC_CADREC    ';
      qryCadRec.Open;

      Gravando.texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      Try
        While Not qryAdoCores.Eof Do
        Begin
          If (Gravando.Status <> sgGravando) Then
            Break;
          For intUnidade := 0 To 2 Do
          Begin
            qryCadRec.Insert;
            qryCadRec.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REC_CADREC', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadRec.FieldByName('REC_CODSEQ').AsString := TStrUtils.fStrZero(fRetornaProximoCodSeq, 6);
            qryCadRec.FieldByName('REC_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadRec.FieldByName('REC_DESCRI').AsString := AnsiUpperCase(qryAdoCores.FieldByName('F1').AsString);
            qryCadRec.FieldByName('REC_CODIGO').AsString := AnsiUpperCase(qryAdoCores.FieldByName('F2').AsString);
            qryCadRec.FieldByName('REC_UNIDAD').AsString := ArrayUnidade[intUnidade];
            qryCadRec.FieldByName('REC_CODUNI').AsString := ArrayUnidade[intUnidade];
            qryCadRec.FieldByName('REC_CODBAS').AsString := AnsiUpperCase(qryAdoCores.FieldByName('COD_BASE').AsString);
            qryCadRec.FieldByName('REC_CODEMB').AsString := fRetCodEmbalagem('1', ArrayUnidade[intUnidade]);
            qryCadRec.FieldByName('REC_MD5KEY').AsString := GetMd5(qryCadRec.FieldByName('REC_DESCRI').AsString +
                                                                   qryCadRec.FieldByName('REC_CODIGO').AsString +
                                                                   qryCadRec.FieldByName('REC_UNIDAD').AsString +
                                                                   qryCadRec.FieldByName('REC_CODBAS').AsString +
                                                                   qryCadRec.FieldByName('REC_CODEMB').AsString +
                                                                   qryCadRec.FieldByName('REC_CODUNI').AsString);


            fltFator := fRetFatorUnidade(ArrayUnidade[intUnidade]);

            If Not TStrUtils.fEmptyStr(qryAdoCores.FieldByName('F5').AsString) Then
            Begin
              qryCadRec.FieldByName('REC_FORM01').AsString := LeftStr(qryAdoCores.FieldByName('F5').AsString, 2);
              qryCadRec.FieldByName('REC_QTDC01').AsFloat := RoundTo(fStrToFloatRecoa(Copy(qryAdoCores.FieldByName('F5').AsString, 4, 17)) * 0.616125 * fltFator / 0.81, -4);
            End;

            If Not TStrUtils.fEmptyStr(qryAdoCores.FieldByName('F6').AsString) Then
            Begin
              qryCadRec.FieldByName('REC_FORM02').AsString := LeftStr(qryAdoCores.FieldByName('F6').AsString, 2);
              qryCadRec.FieldByName('REC_QTDC02').AsFloat := RoundTo(fStrToFloatRecoa(Copy(qryAdoCores.FieldByName('F6').AsString, 4, 17)) * 0.616125 * fltFator / 0.81, -4);
            End;

            If Not TStrUtils.fEmptyStr(qryAdoCores.FieldByName('F7').AsString) Then
            Begin
              qryCadRec.FieldByName('REC_FORM03').AsString := LeftStr(qryAdoCores.FieldByName('F7').AsString, 2);
              qryCadRec.FieldByName('REC_QTDC03').AsFloat := RoundTo(fStrToFloatRecoa(Copy(qryAdoCores.FieldByName('F7').AsString, 4, 17)) * 0.616125 * fltFator / 0.81, -4);
            End;

            If Not TStrUtils.fEmptyStr(qryAdoCores.FieldByName('F8').AsString) Then
            Begin
              qryCadRec.FieldByName('REC_FORM04').AsString := LeftStr(qryAdoCores.FieldByName('F8').AsString, 2);
              qryCadRec.FieldByName('REC_QTDC04').AsFloat := RoundTo(fStrToFloatRecoa(Copy(qryAdoCores.FieldByName('F8').AsString, 4, 17)) * 0.616125 * fltFator / 0.81, -4);
            End;

            If Not TStrUtils.fEmptyStr(qryAdoCores.FieldByName('F9').AsString) Then
            Begin
              qryCadRec.FieldByName('REC_FORM05').AsString := LeftStr(qryAdoCores.FieldByName('F9').AsString, 2);
              qryCadRec.FieldByName('REC_QTDC05').AsFloat := RoundTo(fStrToFloatRecoa(Copy(qryAdoCores.FieldByName('F9').AsString, 4, 17)) * 0.616125 * fltFator / 0.81, -4);
            End;

            If Not TStrUtils.fEmptyStr(qryAdoCores.FieldByName('F10').AsString) Then
            Begin
              qryCadRec.FieldByName('REC_FORM06').AsString := LeftStr(qryAdoCores.FieldByName('F10').AsString, 2);
              qryCadRec.FieldByName('REC_QTDC06').AsFloat := RoundTo(fStrToFloatRecoa(Copy(qryAdoCores.FieldByName('F10').AsString, 4, 17)) * 0.616125 * fltFator / 0.81, -4);
            End;
            qryCadRec.Post;
          End;
          qryAdoCores.Next;
          Gravando.RegistrarProgresso(0, qryAdoCores.RecNo, qryAdoCores.RecordCount);
        End;
      Except
        On E: Exception Do
        Begin
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;

      End;

    Except
      On  E: Exception Do
      Begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally
    Gravando.Texto := 'Cadastro de fórmulas processado com sucesso!';
  End;
end;


function TGravandoExecucaoRecoaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoRecoaCores.fRetFatorUnidade(
  strUnidade: String): Double;
begin
  Result := 0.81;
  If strUnidade = 'LT' Then
    Result := 0.81
  Else If strUnidade = 'GL' Then
    Result := 3.24
  Else If strUnidade = 'LA' Then
    Result := 16.2;
end;

function TGravandoExecucaoRecoaCores.fRetornaProximoCodSeq: Integer;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT IFNULL(MAX(CONVERT(REC_CODSEQ,SIGNED)), 0) + 1 AS MAXIMO FROM REC_CADREC;  ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;
end;

function TGravandoExecucaoRecoaCores.fStrToFloatRecoa(
  strValorUnico: String): Double;
begin
  Result := StrToFloatDef(AnsiReplaceStr(strValorUnico, '.', ','), 0);
end;

function TGravandoExecucaoRecoaCores.fRetCodEmbalagem(strCodEmbOrigem,
  strUniDes: String): String;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT EMB_CODEMB, EMB_UNIDAD FROM REC_CADEMB WHERE EMB_QTDEMB IN (810, 3240, 16200)   ';
    qryGen.Open;

    If qryGen.Locate('EMB_UNIDAD', strUniDes, []) Then
      Result := qryGen.FieldByName('EMB_CODEMB').AsString
    Else
      Result := strCodEmbOrigem;

  Except
    Raise;
  End;
end;

end.
