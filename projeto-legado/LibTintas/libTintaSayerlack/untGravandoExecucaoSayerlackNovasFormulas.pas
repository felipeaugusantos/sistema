{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Sayerlack *}
{*******************************************************************************PH*}
unit untGravandoExecucaoSayerlackNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoSayerlackNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fRetFatorUnidade(strUnidade, strUniOrigem:String; intRegistro:Integer): Double;
    function fRetUnidadeEmb(strDesEmb: String):String;
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

{ TGravandoExecucaoSayerlackNovasFormulas }

constructor TGravandoExecucaoSayerlackNovasFormulas.Create(
  const strCodNfm: string; blnGerarUnidades: Boolean;
  const blnAtualizarUnidade: Boolean; const strUnidadeMenor: String);
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoSayerlackNovasFormulas.Executar(const gravando: IGravando);
Var
  qryBases, qryCadSay, qryCadNfm: IDataSet;
  intContador: Integer;
  fltFator: Double;
begin

  Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  qryCadSay := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;

  qryCadNfm.SQL := '    SELECT * FROM SAY_CADNFM    ';
  qryCadSay.SQL := '    DELETE FROM SAY_CADSAY    ';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
  Begin
    qryCadNfm.SQL := qryCadNfm.SQL + '    WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);
    qryCadSay.SQL := qryCadSay.SQL + '    WHERE SAY_CODNFM = ' + QuotedStr(strCodNfm);
  End
  Else
  Begin
    qryCadSay.SQL := qryCadSay.SQL + '  WHERE SAY_CODNFM LIKE ''%ESP%''    ';
  End;

  qryCadSay.ExecSQL;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('SAY_CADSAY');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  qryCadNfm.Open;
  qryCadSay.SQL.Empty;
  qryCadSay.SQL := '    SELECT * FROM SAY_CADSAY WHERE FALSE    ';
  qryCadSay.Open;

  Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Try
    Try
      While Not qryCadNfm.Eof Do
      Begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := '   SELECT * FROM SAY_CADBAS  ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_CODBAS = :CODBAS    ' +
                        '   AND BAS_PRODUT = :PRODUT     ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_DESEMB = :EMBALAGEM   ';

        If Not (blnAtualizarUnidade) And Not (TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_DESEMB <> :EMBALAGEM  ';

        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('EMBALAGEM').AsString := qryCadNfm.FieldByName('NFM_DESEMB').AsString;

        If Not (blnAtualizarUnidade) And Not (TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.ParamByName('EMBALAGEM').AsString := strUnidadeMenor;

        qryBases.Open;
        qryBases.First;

        While Not qryBases.Eof Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadSay.Insert;
          qryCadSay.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SAY_CADSAY', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadSay.FieldByName('SAY_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadSay.FieldByName('SAY_BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
          qryCadSay.FieldByName('SAY_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryCadSay.FieldByName('SAY_DESEMB').AsString := qryBases.FieldByName('BAS_DESEMB').AsString;
          qryCadSay.FieldByName('SAY_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
          qryCadSay.FieldByName('SAY_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
          qryCadSay.FieldByName('SAY_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
          qryCadSay.FieldByName('SAY_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
          qryCadSay.FieldByName('SAY_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
          qryCadSay.FieldByName('SAY_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
          qryCadSay.FieldByName('SAY_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

          fltFator := fRetFatorUnidade(fRetUnidadeEmb(qryBases.FieldByName('BAS_DESEMB').AsString),
            qryCadNfm.FieldByName('NFM_CODUNI').AsString, qryBases.RecordCount);

          For intContador := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
              Break;

            qryCadSay.FieldByName('SAY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);

            qryCadSay.FieldByName('SAY_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
              qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fltFator;
          End;

          qryCadSay.FieldByName('SAY_MD5KEY').AsString := GetMD5(qryCadSay.FieldByName('SAY_BASE__').AsString +
                                                                 qryCadSay.FieldByName('SAY_CODBAS').AsString +
                                                                 qryCadSay.FieldByName('SAY_PRODUT').AsString +
                                                                 qryCadSay.FieldByName('SAY_CODIGO').AsString +
                                                                 qryCadSay.FieldByName('SAY_DESEMB').AsString);

          qryCadSay.Post;
          qryBases.Next;
        End;
        qryCadNfm.Next;
        gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;

    End;
  Finally
    Gravando.Texto := 'Novas Fórmulas processado com sucesso!';
  End;
end;

function TGravandoExecucaoSayerlackNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoSayerlackNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoSayerlackNovasFormulas.fRetFatorUnidade(strUnidade,
  strUniOrigem: String; intRegistro: Integer): Double;
begin
  Result := 1;
  If intRegistro = 2 Then
  Begin
    If Pos(strUnidade, 'QT_') > 0 Then
      Result := 1
    Else If (strUnidade = 'BA') And (strUniOrigem = 'QT') Then
      Result := 1 / 0.810
    Else If (strUnidade = 'BA') Then
      Result := 1
    Else If (strUnidade = 'GL') And (strUniOrigem = 'GL') Then
      Result := 1
    Else If (strUnidade = 'GL') And (strUniOrigem = 'QT') Then
      Result := 4
    Else If (strUnidade = 'GL') And (strUniOrigem = 'BA') Then
      Result := 3.24
    Else If (strUnidade = 'BH') And (strUniOrigem = 'QT') Then
      Result := 18 / 0.810
    Else If (strUnidade = 'BH') And (strUniOrigem = 'BA') Then
      Result := 18
    Else If strUnidade = 'BH' Then
      Result := 18 / 3.24;
  End
  Else If intRegistro = 3 Then
   Begin
    If Pos(strUnidade, 'QT_') > 0 Then
      Result := 1
    Else If (strUnidade = 'BA') And (strUniOrigem = 'QT') Then
      Result := 1 / 0.810
    Else If strUnidade = 'BA' Then
      Result := 1
    Else If (strUnidade = 'GL') And (strUniOrigem = 'QT') Then
      Result := 4
    Else If (strUnidade = 'GL') And (strUniOrigem = 'BA') Then
      Result := 3.24
    Else If (strUnidade = 'BH') And (strUniOrigem = 'QT') Then
      Result := 18 / 0.810
    Else If strUnidade = 'BH' Then
      Result := 18;
  End
  Else If intRegistro > 3 Then
  Begin
    If strUnidade = 'QT' Then
      Result := 1
    Else If strUnidade = 'BA' Then
      Result := 1 / 0.810
    Else If strUnidade = 'GL' Then
      Result := 3.24 / 0.810
    Else If strUnidade = 'BH' Then
      Result := 18 / 0.810;
  End;
end;

function TGravandoExecucaoSayerlackNovasFormulas.fRetUnidadeEmb(
  strDesEmb: String): String;
Var
  qryGen : IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT EMB_CODUNI FROM SAY_CADEMB WHERE EMB_DESEMB = :DESEMB    ';
  qryGen.ParamByName('DESEMB').AsString := strDesEmb;
  qryGen.Open;

  Result := qryGen.FieldByName('EMB_CODUNI').AsString;
end;

end.
