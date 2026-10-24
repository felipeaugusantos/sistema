{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Dacar    *}
{********************************************************************************AC*}
unit untGravandoExecucaoDacarNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, strUtils;

type
  TGravandoExecucaoDacarNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;

    procedure RemoverNovasFormulas();
    function fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
    function fProxCodSeq: Integer;
    function fOncasParaMl(Oncas: String): Double;
    function fDescUnid(CodUni : String): String;
  public
    constructor Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
      const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoDacarNovasFormulas }

constructor TGravandoExecucaoDacarNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoDacarNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryCadDac: IDataSet;
  qryBases : IDataSet;
  qryVolumeEspecifico: IDataSet;
  intCont: Integer;
  intCodSeq: Integer;
  fltQtdCol: Double;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM DAC_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadDac := TAutcomTintaFactory.Get.fGetDataSet;
      qryVolumeEspecifico := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DAC_CADDAC');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_UNIDAD,                ' +
                        '        BAS_DESCRI                 ' +
                        '   FROM DAC_CADBAS                 ' +
                        '  INNER JOIN CADITE                ' +
                        '     ON ITE_CODITE = BAS_CODITE    ' +
                        '  WHERE BAS_CODFML = :PRODUT       ' +
                        '    AND BAS_BASE__ = :CODBAS       ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        intCodSeq := fProxCodSeq;

        Try
          Try
            qryBases.First;
            While Not qryBases.Eof Do
            Begin

              qryCadDac.SQL := TAutcomTintaFactory.Get.GetInsert('DAC_CADDAC');

              qryCadDac.ParamByName('DAC_CODSEQ').AsString := Format('%.6d', [intCodSeq + 1]);
              qryCadDac.ParamByName('DAC_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
              qryCadDac.ParamByName('DAC_REFERE').AsString := qryBases.fieldByName('BAS_DESCRI').AsString + ' ' + qryCadNfm.FieldByName('NFM_BASE__').AsString;

              qryCadDac.ParamByName('DAC_CODUNI').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
              qryCadDac.ParamByName('DAC_DESUNI').AsString := fDescUnid(qryCadDac.ParamByName('DAC_CODUNI').AsString);

{              If TStrUtils.fEmptyStr(qryBases.FieldByName('BAS_CODITE').AsString) Then
                qryCadDac.ParamByName('DAC_CODITE').Value := Null
              Else
                qryCadDac.ParamByName('DAC_CODITE').AsString := qryBases.FieldByName('BAS_CODITE').AsString;}

              qryCadDac.ParamByName('DAC_CODCOR').AsString := qryCadNfm.FieldByName('NFM_CODCOR').AsString;
              qryCadDac.ParamByName('DAC_COLECA').AsString := qryCadNfm.FieldByName('NFM_COLECA').AsString;

              qryCadDac.ParamByName('DAC_PROCOD').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
              qryCadDac.ParamByName('DAC_CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
              qryCadDac.ParamByName('DAC_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadDac.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DAC_CADDAC', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadDac.ParamByName('DAC_CODFML').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
              qryCadDac.ParamByName('DAC_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

              For intCont := 1 To 20 Do
              Begin
                If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_QTDC' + Format('%.2d', [intCont])).AsString) Then
                  Break;

                qryCadDac.ParamByName('DAC_FORM' + Format('%.2d', [intCont])).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + Format('%.2d', [intCont])).AsString);
                If qryCadNfm.FieldByName('NFM_TIPMED').AsString = 'M' Then
                  qryCadDac.ParamByName('DAC_QTDB' + Format('%.2d', [intCont])).AsFloat := qryCadNfm.FieldByName('NFM_QTDC' + Format('%.2d', [intCont])).AsFloat
                Else
                  qryCadDac.ParamByName('DAC_QTDB' + Format('%.2d', [intCont])).AsFloat := fOncasParaMl(qryCadNfm.FieldByName('NFM_QTDC' + Format('%.2d', [intCont])).AsString);

                fltQtdCol := qryCadDac.ParamByName('DAC_QTDB' + Format('%.2d', [intCont])).AsFloat;
                fltQtdCol := fltQtdCol * fRetPesoUnidade(qryBases.FieldByName('BAS_UNIDAD').AsString, qryBases.RecordCount, qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

                qryCadDac.ParamByName('DAC_QTDB' + Format('%.2d', [intCont])).AsFloat := fltQtdCol;
              End;

              qryCadDac.ParamByName('DAC_MD5KEY').AsString := GetMD5(qryCadDac.ParamByName('DAC_DESCRI').AsString +
                                                                     qryCadDac.ParamByName('DAC_REFERE').AsString +
                                                                     qryCadDac.ParamByName('DAC_CODUNI').AsString +
                                                                     qryCadDac.ParamByName('DAC_DESUNI').AsString +
                                                                     qryCadDac.ParamByName('DAC_CODITE').AsString +
                                                                     qryCadDac.ParamByName('DAC_CODBAS').AsString +
                                                                     qryCadDac.ParamByName('DAC_CODFML').AsString +
                                                                     qryCadDac.ParamByName('DAC_PROCOD').AsString);

              qryCadDac.ParamByName('DAC_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;

              qryCadDac.ExecSQL;

              if not (blnGerarUnidades) then
                Break;

              qryBases.Next;
            End;
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

function TGravandoExecucaoDacarNovasFormulas.fDescUnid(CodUni: String): String;
begin
  Result :=
    TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT       ' +
      '   UNI_DESUNI ' +
      ' FROM         ' +
      '   CADUNI     ' +
      ' WHERE UNI_CODUNI = :CODUNI ', 'UNI_DESUNI', [CodUni]);
end;

function TGravandoExecucaoDacarNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoDacarNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoDacarNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoDacarNovasFormulas.fRetPesoUnidade(
  strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
begin
  Result := 1;
  If intRegistros = 3 Then
  Begin
    If Pos(strCodUni, 'LT_QT_') > 0 Then
      Result := 1
    Else If strCodUni = 'GL' Then
      Result := 4
    Else If strCodUni = 'LA' Then
      Result := 20;
  End
  Else If intRegistros = 2 Then
  Begin
    If strCodUni = 'LT' Then
      Result := 1
    Else If (strCodUni = 'GL') And (strUniOri = 'GL') Then
      Result := 1
    Else If strCodUni = 'GL' Then
      Result := 4
    Else If (strCodUni = 'LA') And (strUniOri = 'LT') Then
      Result := 20
    Else If strCodUni = 'LA' Then
      Result := 5;
  End;
end;

function TGravandoExecucaoDacarNovasFormulas.fProxCodSeq: Integer;
  Var
    qryGen: IDataSet;
begin
  Result := 1;
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := 'SELECT DAC_CODSEQ FROM DAC_CADDAC ORDER BY DAC_CODSEQ DESC LIMIT 1';
    qryGen.Open;
    If Not qryGen.IsEmpty Then
      Result := qryGen.fieldByName('DAC_CODSEQ').AsInteger;
  Except
    on E: Exception do
    begin
      raise;
    end;
  End;
end;

function TGravandoExecucaoDacarNovasFormulas.fOncasParaMl(Oncas: String): Double;
  Var
    strInteira  : String;
    strFracao   : String;
    strOncas    : String;
begin
  strOncas   := AnsiReplaceStr(Oncas,'.',',');
  strInteira := Copy(strOncas, 0, Pos('Y', strOncas) - 1);
  strFracao  := Copy(strOncas, Pos('Y', strOncas) + 1, Length(strOncas));
  Result     := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.000000',
    TAutcomTintaFactory.Get.fStrToFloat(strInteira) * 29.5735295625 +
    TAutcomTintaFactory.Get.fStrToFloat(strFracao) * 0.61611520));
end;

procedure TGravandoExecucaoDacarNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL :=
          ' DELETE                ' +
          ' FROM                  ' +
          '   DAC_CADDAC          ' +
          ' WHERE DAC_PROCOD IN   ' +
          '   (SELECT             ' +
          '     NFM_CODNFM        ' +
          '   FROM                ' +
          '     DAC_CADNFM)       ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE               ' +
          ' FROM                 ' +
          '   DAC_CADDAC         ' +
          ' WHERE DAC_PROCOD IN  ' +
          '  (SELECT             ' +
          '     NFM_CODNFM       ' +
          '   FROM               ' +
          '     DAC_CADNFM       ' +
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

end.
