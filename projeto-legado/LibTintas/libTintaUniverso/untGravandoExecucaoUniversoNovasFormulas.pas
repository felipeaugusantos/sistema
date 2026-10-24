{**********************************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Universo Imobiliaria *}
{*******************************************************************************************PH*}
unit untGravandoExecucaoUniversoNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, untIConfTinta;

type
  TGravandoExecucaoUniversoNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    conf: IConfTinta;

    procedure RemoverNovasFormulas();
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
  public
    constructor Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
      const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    function fRetFatorMedida(strUnidade, strUnidadeOrigem:String; intRegistro:Integer): Double;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoUniversoNovasFormulas }

constructor TGravandoExecucaoUniversoNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('UNI');
end;

procedure TGravandoExecucaoUniversoNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryCadUni: IDataSet;
  qryBases : IDataSet;
  qryVolumeEspecifico: IDataSet;
  intCont: Integer;
  fltFator: Double;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM UNI_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadUni := TAutcomTintaFactory.Get.fGetDataSet;
      qryVolumeEspecifico := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('UNI_CADUNI');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_UNIDAD              ' +
                        '   FROM UNI_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_PRODUT = :PRODUT    ' +
                        '    AND BAS_CODBAS = :CODBAS    ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_CODUNI').AsString);

        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_CODUNI').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        qryCadUni.SQL := 'SELECT * FROM UNI_CADUNI';
        qryCadUni.Open;

        Try
          Try
            //qryBases.First;
            While Not qryBases.Eof Do
            Begin

              qryCadUni.Insert;

              qryCadUni.FieldByName('UNI_GRUPO_').AsString  := AnsiUpperCase(qryCadNfm.FieldByName('NFM_GRUPO_').AsString);
              qryCadUni.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('UNI_CADUNI', TAutcomTintaFactory.Get.GetCodEmp);//qryCadNfm.FieldByName('AUTOINCREM').AsString;
              qryCadUni.FieldByName('UNI_PRODUT').AsString  := AnsiUpperCase(qryCadNfm.FieldByName('NFM_PRODUT').AsString);
              qryCadUni.FieldByName('UNI_CODTIN').AsString  := AnsiUpperCase(qryCadNfm.FieldByName('NFM_CODTIN').AsString);
              qryCadUni.FieldByName('UNI_DESCOR').AsString  := AnsiUpperCase(qryCadNfm.FieldByName('NFM_DESCOR').AsString);
              qryCadUni.FieldByName('UNI_CODBAS').AsString  := AnsiUpperCase(qryCadNfm.FieldByName('NFM_CODBAS').AsString);
              qryCadUni.FieldByName('UNI_CODUNI').AsString  := AnsiUpperCase(qryBases.FieldByName('BAS_UNIDAD').AsString);

              fltFator := fRetFatorMedida(qryCadUni.FieldByName('UNI_CODUNI').AsString, qryCadNfm.FieldByName('NFM_CODUNI').AsString, qryBases.RecordCount);

              For intCont := 1 To 20 Do
              Begin

                If (TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString)) Then
                  Break;

                qryCadUni.FieldByName('UNI_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(AnsiUpperCase(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString));
                qryCadUni.FieldByName('UNI_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fltFator;
              End;

              qryCadUni.FieldByName('UNI_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
              qryCadUni.FieldByName('UNI_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

              qryCadUni.FieldByName('UNI_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
              qryCadUni.FieldByName('UNI_MD5KEY').AsString := GetMD5(qryCadUni.FieldByName('UNI_DESCOR').AsString + qryCadUni.FieldByName('UNI_CODBAS').AsString  +
                                                                     qryCadUni.FieldByName('UNI_PRODUT').AsString + qryCadUni.FieldByName('UNI_CODUNI').AsString  +
                                                                     qryCadUni.FieldByName('UNI_GRUPO_').AsString + qryCadUni.FieldByName('UNI_CODNFM').AsString);


              qryCadUni.Post;

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

function TGravandoExecucaoUniversoNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Novas Fórmulas';
end;
function TGravandoExecucaoUniversoNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoUniversoNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoUniversoNovasFormulas.fRetFatorMedida(
  strUnidade, strUnidadeOrigem: String; intRegistro:Integer): Double;
begin
  Result := 1;
  If intRegistro = 1 Then
  Begin
    If strUnidade = 'TT' Then
      Result := 1
    Else If (strUnidade = 'LT') Or (strUnidade = 'QT') Then
      Result := 1
    Else
      Result := 1;
  End
  Else If intRegistro >= 2 Then
  Begin
    If strUnidadeOrigem = 'TT' Then
    Begin
      If strUnidade = 'TT' Then
        Result := 1
      Else If (strUnidade = 'LT') Or (strUnidade = 'QT') Then
        Result := 4
      Else If strUnidade = 'GL' Then
        Result := 16
      Else
        Result := 80;
    End
    Else If strUnidadeOrigem = 'QT' Then
    Begin
      If (strUnidade = 'LT') Or (strUnidade = 'QT') Then
        Result := 1
      Else If strUnidade = 'GL' Then
        Result := 4
      Else
        Result := 20;
    End
    Else
    Begin
      If strUnidade = 'GL' Then
        Result := 1
      Else
        Result := 5;
    End;
  End;
end;

{function TGravandoExecucaoUniversoNovasFormulas.fRetFatorUnidade(
  strUnidade: String): Double;
begin
  Result := 1;
  If (strUnidade = conf.fGet('UNIGAL')) Then
    Result := 3.6
  Else If (strUnidade = conf.fGet('UNIQUA')) Then
    Result := 0.9
  Else If (strUnidade = conf.fGet('UNILAT')) Then
    Result := 18;
end;}

procedure TGravandoExecucaoUniversoNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL :=
          ' DELETE               ' +
          ' FROM                 ' +
          '   UNI_CADUNI         ' +
          ' WHERE UNI_CODNFM IN  ' +
          '   (SELECT            ' +
          '     NFM_CODNFM       ' +
          '   FROM               ' +
          '     UNI_CADNFM)      ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE               ' +
          ' FROM                 ' +
          '   UNI_CADUNI         ' +
          ' WHERE UNI_CODNFM IN  ' +
          '   (SELECT            ' +
          '     NFM_CODNFM       ' +
          '   FROM               ' +
          '     UNI_CADNFM       ' +
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
