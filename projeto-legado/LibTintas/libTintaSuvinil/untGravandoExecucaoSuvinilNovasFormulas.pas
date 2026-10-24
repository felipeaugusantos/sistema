{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta suvinil *}
{*******************************************************************************PH*}
unit untGravandoExecucaoSuvinilNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoSuvinilNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fRetSiglaUnidade(strUnidade: String): String;
    function TemVolumeEspecifico(const qryCadNfm: IDataSet; const qryVolumeEspecifico: IDataSet): Boolean;
    procedure RemoverNovasFormulas();
    function fRetPesoUnidade(strCodUni: String; strUniOri: String; strCodFml: String): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
    function fRetVolumeUnidade(strUnidade: String; strCodFml: String): Double;
    function fRetVolumeLatas(strUnidade: String): Double;
    function fRetornaVolumeGalao(strUnidade: String; strCodFml: String): Double;
  public
    constructor Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
      const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    function fHabilitaOpcao(): Boolean;
    procedure Executar(const gravando: IGravando);
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoSuvinilNovasFormulas }

constructor TGravandoExecucaoSuvinilNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoSuvinilNovasFormulas.Executar(const gravando: IGravando);
//const
//  arrUnidades: array[0..2] of string = ('LT', 'GL', 'LA');
//  arrPesos: array[0..2] of Double = (1, 4, 20);
var
  qryCadNfm: IDataSet;
  qryCadSuv: IDataSet;
  qryBases : IDataSet;
  qryVolumeEspecifico: IDataSet;
  intCont: Integer;
//  intUnidade: Integer;
  fltFatorEspecifico: Double;
  strMd5: String;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM SUV_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadSuv := TAutcomTintaFactory.Get.fGetDataSet;
      qryVolumeEspecifico := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SUV_CADSUV');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT SUV_CODUNI              ' +
                        '   ,    SUV_CODFML              ' +
                        '   FROM SUV_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = SUV_CODITE ' +
                        '  WHERE SUV_CODFML = :CODFML    ' +
                        '    AND SUV_CODBAS = :CODBAS    ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND SUV_CODUNI = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND SUV_CODUNI <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('CODFML').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        Try
          Try
            if TemVolumeEspecifico(qryCadNfm, qryVolumeEspecifico) then
            begin
              fltFatorEspecifico := qryVolumeEspecifico.FieldByName('NFM_VOLUME').AsFloat;
              while not qryVolumeEspecifico.Eof do
              begin
                Try
                  Try
                    qryCadSuv.SQL := TAutcomTintaFactory.Get.GetInsert('SUV_CADSUV');

                    qryCadSuv.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SUV_CADSUV',
                                                                      TAutcomTintaFactory.Get.GetCodEmp);

                    qryCadSuv.ParamByName('SUV_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
                    qryCadSuv.ParamByName('SUV_DESCRI').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
                    qryCadSuv.ParamByName('SUV_REFERE').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
                    qryCadSuv.ParamByName('SUV_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
                    qryCadSuv.ParamByName('SUV_UNIDAD').AsString := fRetSiglaUnidade(qryVolumeEspecifico.FieldByName('NFM_UNIDAD').AsString);
                    qryCadSuv.ParamByName('SUV_PREVEN').AsFloat  := 0;
                    qryCadSuv.ParamByName('SUV_PRECUS').AsFloat  := 0;
                    qryCadSuv.ParamByName('SUV_CODFML').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
                    qryCadSuv.ParamByName('SUV_CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
                    qryCadSuv.ParamByName('SUV_CODUNI').AsString := qryVolumeEspecifico.FieldByName('NFM_UNIDAD').AsString;
                    qryCadSuv.ParamByName('SUV_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
                    qryCadSuv.ParamByName('SUV_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
                    qryCadSuv.ParamByName('SUV_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

                    for intCont := 1 to 20 do
                    begin
                      if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                        Break;

                      if qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 then
                        Break;

                      qryCadSuv.ParamByName('SUV_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

                      qryCadSuv.ParamByName('SUV_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                        qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat *
                        qryVolumeEspecifico.FieldByName('NFM_VOLUME').AsFloat / fltFatorEspecifico;
                    end;

                    strMd5 := '';
                    strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_CODFML').AsString;
                    strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_CODBAS').AsString;
                    strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_CODUNI').AsString;
                    strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_NOMCOR').AsString;
                    strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_DESCRI').AsString;
                    strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_REFERE').AsString;
                    strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_UNIDAD').AsString;
                    for intCont := 1 to 20 do
                    begin
                      strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_FORM' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsString;
                      strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qryCadSuv.ParamByName('SUV_QTDB' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsFloat),
                        ',', '.', [rfReplaceAll]);
                    end;

                    qryCadSuv.ParamByName('SUV_MD5KEY').AsString := GetMD5(strMd5);

                    qryCadSuv.ExecSQL;

                    if not (blnGerarUnidades) then
                      Break;
                  Except
                    on E: Exception do
                    begin
                      gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
                    end;
                  End;
                Finally
                  qryVolumeEspecifico.Next;
                End;
              end;
            end
            else
            begin
              qryBases.First;
              While Not qryBases.Eof Do
              Begin
//              for intUnidade := 0 to 2 do
//              begin
                qryCadSuv.SQL := TAutcomTintaFactory.Get.GetInsert('SUV_CADSUV');

                qryCadSuv.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SUV_CADSUV',
                                                                  TAutcomTintaFactory.Get.GetCodEmp);

                qryCadSuv.ParamByName('SUV_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
                qryCadSuv.ParamByName('SUV_DESCRI').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
                qryCadSuv.ParamByName('SUV_REFERE').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
                qryCadSuv.ParamByName('SUV_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
                qryCadSuv.ParamByName('SUV_UNIDAD').AsString := fRetSiglaUnidade(qryBases.FieldByName('SUV_CODUNI').AsString);
                qryCadSuv.ParamByName('SUV_PREVEN').AsFloat  := 0;
                qryCadSuv.ParamByName('SUV_PRECUS').AsFloat  := 0;
                qryCadSuv.ParamByName('SUV_CODFML').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
                qryCadSuv.ParamByName('SUV_CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
                qryCadSuv.ParamByName('SUV_CODUNI').AsString := qryBases.FieldByName('SUV_CODUNI').AsString; //arrUnidades[intUnidade];
                qryCadSuv.ParamByName('SUV_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
                qryCadSuv.ParamByName('SUV_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
                qryCadSuv.ParamByName('SUV_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

                for intCont := 1 to 20 do
                begin
                  if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                    Break;

                  if qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 then
                    Break;

                  qryCadSuv.ParamByName('SUV_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString :=
                    qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString;

                  qryCadSuv.ParamByName('SUV_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                    qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fRetPesoUnidade(qryBases.FieldByName('SUV_CODUNI').AsString, qryCadNfm.FieldByName('NFM_UNIDAD').AsString, qryBases.FieldByName('SUV_CODFML').AsString);
                end;

                strMd5 := '';
                strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_CODFML').AsString;
                strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_CODBAS').AsString;
                strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_CODUNI').AsString;
                strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_NOMCOR').AsString;
                strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_DESCRI').AsString;
                strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_REFERE').AsString;
                strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_UNIDAD').AsString;
                for intCont := 1 to 20 do
                begin
                  strMd5 := strMd5 + qryCadSuv.ParamByName('SUV_FORM' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsString;
                  strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qryCadSuv.ParamByName('SUV_QTDB' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsFloat),
                    ',', '.', [rfReplaceAll]);
                end;

                qryCadSuv.ParamByName('SUV_MD5KEY').AsString := GetMD5(strMd5);

                qryCadSuv.ExecSQL;

                if not (blnGerarUnidades) then
                  Break;
//              end;

                qryBases.Next;
              End;
            end;
          Except
            on E: Exception do
            begin
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          qryCadNfm.Next;
          gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
        End;
      end;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoSuvinilNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoSuvinilNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND SUV_CODUNI IN ("GL", "BD","LA", "1J", "2J", "3J", "4J", "5J", "6J") '
  Else If strUnidade = 'BD' Then
    Result := ' AND SUV_CODUNI IN ("BD", "LA", "1J", "2J", "3J", "4J", "5J", "6J") '
  Else If Pos(strUnidade, 'LA_1J_2J_3J_4J_5J_6J_') > 0 Then
    Result := ' AND SUV_CODUNI IN ("LA", "1J", "2J", "3J", "4J", "5J", "6J") ';
end;

function TGravandoExecucaoSuvinilNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoSuvinilNovasFormulas.fRetornaVolumeGalao(strUnidade,
  strCodFml: String): Double;
begin
  If strCodFml = '4507' Then
    Result := 4.800
  Else If strCodFml = '4509' Then
    Result := 5.800
  Else If strCodFml = '4511' Then
    Result := 5.200
  Else
    Result := 3.200;
end;

function TGravandoExecucaoSuvinilNovasFormulas.fRetPesoUnidade(strCodUni: String; strUniOri: String; strCodFml: String): Double;
begin
  Result := fRetVolumeUnidade(strCodUni, strCodFml) / fRetVolumeUnidade(strUniOri, strCodFml);
end;

function TGravandoExecucaoSuvinilNovasFormulas.fRetSiglaUnidade(
  strUnidade: String): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT UNI_SIGUNI FROM CADUNI WHERE UNI_CODUNI = :CODUNI  ';
  qryGen.ParamByName('CODUNI').AsString := strUnidade;
  qryGen.Open;

  Result := qryGen.FieldByName('UNI_SIGUNI').AsString;
end;

function TGravandoExecucaoSuvinilNovasFormulas.fRetVolumeLatas(
  strUnidade: String): Double;
begin
  If strUnidade = '1J' Then
    Result := 21.000
  Else If strUnidade = '2J' Then
    Result := 22.000
  Else If strUnidade = '3J' Then
    Result := 24.000
  Else If strUnidade = '4J' Then
    Result := 25.000
  Else If strUnidade = '5J' Then
    Result := 26.000
  Else If strUnidade = '6J' Then
    Result := 29.000
  Else
    Result := 16.000;
end;

function TGravandoExecucaoSuvinilNovasFormulas.fRetVolumeUnidade(
  strUnidade: String; strCodFml: String): Double;
begin
  Result := 0;

  If strUnidade = 'LT' Then
    Result := 0.800
  Else If strUnidade = 'GL' Then
    Result := fRetornaVolumeGalao(strUnidade, strCodFml)
  Else If strUnidade = 'BD' Then
    Result := 4.400
  Else If Pos(strUnidade, 'LA_1J_2J_3J_4J_5J_6J_') > 0 Then
    Result := fRetVolumeLatas(strUnidade);
end;

procedure TGravandoExecucaoSuvinilNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL :=
          ' DELETE                        ' +
          ' FROM                          ' +
          '   SUV_CADSUV                  ' +
          ' WHERE LEFT(SUV_DESCRI, 12) IN ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     SUV_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   SUV_CADSUV                           ' +
          ' WHERE LEFT(SUV_DESCRI, 12) IN          ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     SUV_CADNFM                         ' +
          '   WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm) + ') ';
      end;

      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoSuvinilNovasFormulas.TemVolumeEspecifico(const qryCadNfm: IDataSet; const qryVolumeEspecifico: IDataSet): Boolean;
begin
  Result := False;
  Try
    Try
      if qryCadNfm.FieldByName('NFM_CODNFM').AsString = 'N' then
        Exit;

      qryVolumeEspecifico.Close;
      qryVolumeEspecifico.SQL :=
        ' SELECT                         ' +
        '   *                            ' +
        ' FROM                           ' +
        '   SUV_NFMEMB                   ' +
        ' WHERE NFM_CODNFM = :NFM_CODNFM ' +
        '   AND NFM_CODFML = :NFM_CODFML ' +
        '   AND NFM_CODBAS = :NFM_CODBAS ' +
        '   AND NFM_VOLUME > 0           ' +
        ' ORDER BY NFM_VOLUME            ';

      qryVolumeEspecifico.ParamByName('NFM_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
      qryVolumeEspecifico.ParamByName('NFM_CODFML').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
      qryVolumeEspecifico.ParamByName('NFM_CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
      qryVolumeEspecifico.Open;
      qryVolumeEspecifico.First;

      Result := qryVolumeEspecifico.RecordCount > 0;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

end.

