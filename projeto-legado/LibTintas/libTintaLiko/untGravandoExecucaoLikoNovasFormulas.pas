{ ********************************************************************************** }
{ * Classe responsável pela geração do cadastro de novas fórmulas da tinta Liko * }
{ *******************************************************************************PH* }
unit untGravandoExecucaoLikoNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoLikoNovasFormulas = class(TInterfacedObject,
    IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades: Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fGetUnidadesGeracaoCadNfm(strUnidade:String):String;
    function fRetProximoCodSeq(): Integer;
    function fRetCodEmbalagem(strUnidade: String):String;
    function fRetFatorUnidade(strUnidade, strUniOrigem:String; intRegistro:Integer): Double;
  public
    constructor Create(const strCodNfm: string = '';
      blnGerarUnidades: Boolean = true;
      const blnAtualizarUnidade: Boolean = False;
      const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoLikoNovasFormulas }

constructor TGravandoExecucaoLikoNovasFormulas.Create(const strCodNfm
  : string = ''; blnGerarUnidades: Boolean = true;
  const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoLikoNovasFormulas.Executar(const gravando
  : IGravando);
var
  qryCadNfm: IDataSet;
  qryCadLik: IDataSet;
  qryBases: IDataSet;
  intContador: Integer;
  fltFator: Double;
begin
  Try

    Try

      gravando.Texto := 'Carregando Dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadLik := TAutcomTintaFactory.Get.fGetDataSet;
      qryBases := TAutcomTintaFactory.Get.fGetDataSet;

      qryCadNfm.SQL := '    SELECT * FROM LIK_CADNFM    ';
      qryCadLik.SQL := '    DELETE FROM LIK_CADLIK    ';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODIGO =  ' +QuotedStr(strCodNfm);
        qryCadLik.SQL := qryCadLik.SQL + '  WHERE LIK_CODIGO =  ' +QuotedStr(strCodNfm);
        qryCadLik.ExecSQL;
      End
      Else
      Begin
        qryCadLik.SQL := qryCadLik.SQL + '  WHERE LIK_CODIGO LIKE ''%ESP%'' ';
        qryCadLik.ExecSQL;
      End;


      qryCadLik.SQL.Empty;
      qryCadLik.SQL := '    SELECT * FROM LIK_CADLIK WHERE FALSE    ';
      qryCadLik.Open;

      qryCadNfm.Open;
      qryCadNfm.First;


      gravando.Texto := 'Dados Carregados com sucesso...';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('LIK_CADLIK');
      gravando.Texto := 'PROCOD verificado com sucesso...';

      While Not qryCadNfm.Eof Do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := '   SELECT BAS_UNIDAD     ' +
                        '       FROM LIK_CADBAS          ' +
                        '   INNER JOIN CADITE ON  ' +
                        '       ITE_CODITE = BAS_CODITE  ' +
                        '   WHERE BAS_DESCRI LIKE :PRODUT ' +
                        '   AND BAS_BASE__ = :CODBAS    ';


        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

         //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
          qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('PRODUT').AsString := '%' + qryCadNfm.FieldByName('NFM_DESPRO').AsString + '%';
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDADE').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        qryBases.First;

        While Not qryBases.Eof Do
        Begin
          qryCadLik.Insert;
          qryCadLik.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LIK_CADLIK', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadLik.FieldByName('LIK_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadLik.FieldByName('LIK_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
          qryCadLik.FieldByName('LIK_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
          qryCadLik.FieldByName('LIK_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryCadLik.FieldByName('LIK_CODUNI').AsString := qryCadLik.FieldByName('LIK_UNIDAD').AsString;
          qryCadLik.FieldByName('LIK_CODEMB').AsString := fRetCodEmbalagem(qryCadLik.FieldByName('LIK_CODUNI').AsString);
          qryCadLik.FieldByName('LIK_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryCadLik.FieldByName('LIK_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
          qryCadLik.FieldByName('LIK_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

          fltFator := fRetFatorUnidade(qryBases.FieldByName('BAS_UNIDAD').AsString, qryCadNfm.FieldByName('NFM_UNIDAD').AsString, qryBases.RecordCount);

          For intContador := 1 To 20 Do
          Begin
            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
                Break;

            qryCadLik.FieldByName('LIK_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);

            qryCadLik.FieldByName('LIK_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
              qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fltFator;
          End;

          qryCadLik.FieldByName('LIK_MD5KEY').AsString := GetMD5(qryCadLik.FieldByName('LIK_DESCRI').AsString +
                                                                 qryCadLik.FieldByName('LIK_CODIGO').AsString +
                                                                 qryCadLik.FieldByName('LIK_UNIDAD').AsString +
                                                                 qryCadLik.FieldByName('LIK_CODBAS').AsString +
                                                                 qryCadLik.FieldByName('LIK_CODEMB').AsString +
                                                                 qryCadLik.FieldByName('LIK_CODUNI').AsString);
          qryCadLik.Post;

          If Not blnGerarUnidades Then
              Break;

          qryBases.Next;

        End;

        qryCadNfm.Next;

        Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
      end;

    Except
      On E: Exception Do
      Begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;

  Finally
    Gravando.Texto := 'Novas Formulas geradas com sucesso...';
  End;
end;

function TGravandoExecucaoLikoNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoLikoNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoLikoNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoLikoNovasFormulas.fRetCodEmbalagem(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'LT' Then
    Result := '1'
  Else If strUnidade = 'GL' Then
    Result := '2'
  Else
    Result := '3';
end;

function TGravandoExecucaoLikoNovasFormulas.fRetFatorUnidade(strUnidade,
  strUniOrigem: String; intRegistro: Integer): Double;
begin
  Result := 1;
  If intRegistro = 2 Then
  Begin
    If StrUnidade = 'LT' Then
      Result := 1
    Else If (strUnidade = 'GL') And (strUniOrigem = 'GL') Then
      Result := 1
    Else If strUnidade = 'GL' Then
      Result := 4
    Else If (strUnidade = 'LA') And (strUniOrigem = 'LT') Then
      Result := 20
    Else If strUnidade = 'LA' Then
      Result := 5;
  End
  Else If intRegistro = 3 Then
  Begin
    If Pos(strUnidade, 'LT_QT_') > 0 Then
      Result := 1
    Else If strUnidade = 'GL' Then
      Result := 4
    Else If strUnidade = 'LA' Then
      Result := 20;
  End;
end;

function TGravandoExecucaoLikoNovasFormulas.fRetProximoCodSeq: Integer;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT IFNULL(MAX(CONVERT(LIK_CODSEQ, SIGNED)), 0) + 1 AS MAXIMO FROM LIK_CADLIK;  ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;
end;

end.
