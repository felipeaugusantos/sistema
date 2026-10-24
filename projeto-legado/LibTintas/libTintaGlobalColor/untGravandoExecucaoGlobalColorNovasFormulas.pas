{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta GlobalColor *}
{*******************************************************************************PH*}
unit untGravandoExecucaoGlobalColorNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoGlobalColorNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fRetProximoCodSeq(): Integer;
    function fRetFatorUnidade(strUnidade,strUniOrigem:String; intRegistro:Integer): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade:String): String;
    function fRetornaCodEmbalagem(strUnidade:String):String;
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

{ TGravandoExecucaoGlobalColorNovasFormulas }

constructor TGravandoExecucaoGlobalColorNovasFormulas.Create(const strCodNfm: string  = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;

procedure TGravandoExecucaoGlobalColorNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm, qryCadGlo: IDataSet;
  qryBases: IDataSet;
  intCont: Integer;
  fltFator: Double;
Begin
  Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';

  qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadNfm.SQL := '    SELECT * FROM GLO_CADNFM    ';

  qryCadGlo := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadGlo.SQL := '    DELETE FROM GLO_CADGLO    ';

  If (Gravando.Status <> sgGravando) Then
    Exit;


  Gravando.Texto := 'Deletando Novas Fórmulas cadastradas...';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
  Begin
    qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);
    qryCadGlo.SQL := qryCadGlo.SQL + '  WHERE GLO_CODIGO = ' + QuotedStr(strCodNfm);
  End
  Else
  Begin
    qryCadGlo.SQL := qryCadGlo.SQL + '  WHERE GLO_CODIGO LIKE ''%ESP%''   ';
  End;

  qryCadNfm.Open;
  qryCadGlo.ExecSQL;

  Gravando.Texto := 'Cadastro de Novas Fórmulas deletado...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('GLO_CADGLO');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  qryCadGlo.SQL.Empty;
  qryCadGlo.SQL := '    SELECT * FROM GLO_CADGLO WHERE FALSE    ';
  qryCadGlo.Open;

  Try
    Try
      While Not qryCadNfm.Eof Do
      Begin
        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := '   SELECT  * FROM GLO_CADBAS          ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '     WHERE BAS_BASE__ = :BASE   AND     ' +
                        '     BAS_DESCRI = :PRODUT             ' ;

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + '  AND BAS_UNIDAD = :UNIDADE   ';

        If Not (blnAtualizarUnidade) And Not (TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.SQL := qryBases.SQL + '  AND BAS_UNIDAD <> :UNIDADE  ';

        If TStrUtils.fEmptyStr(strCodNfm) Then
          qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('BASE').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_DESPRO').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('UNIDADE').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If Not (blnAtualizarUnidade) And Not (TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.ParamByName('UNIDADE').AsString := strUnidadeMenor;

        Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';

        qryBases.Open;
        qryBases.First;

        While Not qryBases.Eof Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadGlo.Insert;
          qryCadGlo.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('GLO_CADGLO', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadGlo.FieldByName('GLO_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadGlo.FieldByName('GLO_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
          qryCadGlo.FieldByName('GLO_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
          qryCadGlo.FieldByName('GLO_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
          qryCadGlo.FieldByName('GLO_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryCadGlo.FieldByName('GLO_CODUNI').AsString := qryCadGlo.FieldByName('GLO_UNIDAD').AsString;
          qryCadGlo.FieldByName('GLO_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryCadGlo.FieldByName('GLO_PRODUT').AsString := qryCadNfm.FieldByName('NFM_DESPRO').AsString;
          qryCadGlo.FieldByName('GLO_CODEMB').AsString := fRetornaCodEmbalagem(qryCadGlo.FieldByName('GLO_CODUNI').AsString);
          qryCadGlo.FieldByName('GLO_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

          fltFator := fRetFatorUnidade(qryBases.FieldByName('BAS_UNIDAD').AsString, qryCadNfm.FieldByName('NFM_UNIDAD').AsString, qryBases.RecordCount);

          For intCont := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
              Break;

            qryCadGlo.FieldByName('GLO_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

            qryCadGlo.FieldByName('GLO_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
              qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fltFator;
          End;

          qryCadGlo.FieldByName('GLO_MD5KEY').AsString := GetMd5(qryCadGlo.FieldByName('GLO_DESCRI').AsString +
                                                                 qryCadGlo.FieldByName('GLO_CODIGO').AsString +
                                                                 qryCadGlo.FieldByName('GLO_UNIDAD').AsString +
                                                                 qryCadGlo.FieldByName('GLO_CODBAS').AsString +
                                                                 qryCadGlo.FieldByName('GLO_CODEMB').AsString +
                                                                 qryCadGlo.FieldByName('GLO_CODUNI').AsString +
                                                                 qryCadGlo.FieldByName('GLO_PRODUT').AsString);
          qryCadGlo.Post;
          qryBases.Next;
        End;
        qryCadNfm.Next;
        Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    Gravando.Texto := 'Cadastro de Novas Fórmulas processado com sucesso...';
  End;

End;

function TGravandoExecucaoGlobalColorNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;





function TGravandoExecucaoGlobalColorNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoGlobalColorNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoGlobalColorNovasFormulas.fRetFatorUnidade(strUnidade,strUniOrigem:String; intRegistro:Integer): Double;
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

function TGravandoExecucaoGlobalColorNovasFormulas.fRetornaCodEmbalagem(
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

function TGravandoExecucaoGlobalColorNovasFormulas.fRetProximoCodSeq: Integer;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT IFNULL(MAX(GLO_CODSEQ), 0) + 1 AS MAXIMO FROM GLO_CADGLO; ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;

end;

end.
