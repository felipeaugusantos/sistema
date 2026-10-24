{ ********************************************************************************** }
{ * Classe responsável pela geração do cadastro de novas fórmulas da tinta Annetta * }
{ *******************************************************************************PH* }
unit untGravandoExecucaoAnnettaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoAnnettaNovasFormulas = class(TInterfacedObject,
    IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades: Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fGetUnidadesGeracaoCadNfm(strUnidade:String):String;
    function fRetCodEmbalagem(strUnidade:String):String;
    function fRetFatorUnidade(strUnidade,strUniOrigem:String; intRegistro: Integer):Double;
    function fRetProximoCodSeq():Integer;
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

{ TGravandoExecucaoAnnettaNovasFormulas }

constructor TGravandoExecucaoAnnettaNovasFormulas.Create(const strCodNfm
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

procedure TGravandoExecucaoAnnettaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm,
  qryCadAnn,
  qryBases: IDataSet;
  intContador: Integer;
  fltFator:Double;
begin
  Try
    Try
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadAnn := TAutcomTintaFactory.Get.fGetDataSet;

      Gravando.Texto := 'Carregando Dados...';

      qryCadNfm.SQL := '    SELECT * FROM ANN_CADNFM    ';
      qryCadAnn.SQL := '    DELETE FROM ANN_CADANN    ';

      Gravando.Texto := 'Deletando Cadastro de Novas Fórmulas';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);
        qryCadAnn.SQL := qryCadAnn.SQL + '  WHERE ANN_CODIGO = ' + QuotedStr(strCodNfm);
        qryCadAnn.ExecSQL;
      End
      Else
      Begin
        qryCadAnn.SQL := qryCadAnn.SQL + ' WHERE ANN_CODIGO LIKE ''%ESP%'' ';
        qryCadAnn.ExecSQL;
      End;

      qryCadAnn.SQL.Empty;

      Gravando.Texto := 'Cadastro de Novas Fórmulas deletado...';


      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ANN_CADANN');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Novas Fórmulas...';
      qryCadAnn.SQL := '    SELECT * FROM ANN_CADANN  WHERE FALSE  ';
      qryCadAnn.Open;
      qryCadNfm.Open;


      Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';


      Try
        While Not qryCadNfm.Eof Do
        Begin
          qryBases := TAutcomTintaFactory.Get.fGetDataSet;
          qryBases.SQL := '   SELECT    ' +
                          '     BAS_UNIDAD,      ' +
                          '     BAS_DESCRI       ' +
                          '   FROM    ' +
                          '     ANN_CADBAS      ' +
                          '   INNER JOIN CADITE ON    ' +
                          '     ITE_CODITE = BAS_CODITE     ' +
                          '   WHERE   ' +
                          '     BAS_BASE__ = :CODBAS AND      ' +
                          '     BAS_DESCRI = :DESCRI  ';

          If Not blnGerarUnidades Then
            qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD = :UNIDADE     ';

          If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
            qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDADE <> :UNIDADE     ';

          If TStrUtils.fEmptyStr(strCodNfm) Then
            qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

          qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryBases.ParamByName('DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESPRO').AsString;

          If Not blnGerarUnidades Then
            qryBases.ParamByName('UNIDADE').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

          If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
            qryBases.FieldByName('UNIDADE').AsString := strUnidadeMenor;

          qryBases.Open;
          qryBases.First;

          While Not qryBases.Eof Do
          Begin
            qryCadAnn.Insert;
            qryCadAnn.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ANN_CADANN', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadAnn.FieldByName('ANN_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadAnn.FieldByName('ANN_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
            qryCadAnn.FieldByName('ANN_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
            qryCadAnn.FieldByName('ANN_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
            qryCadAnn.FieldByName('ANN_PRODUT').AsString := qryBases.FieldByName('BAS_DESCRI').AsString;
            qryCadAnn.FieldByName('ANN_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
            qryCadAnn.FieldByName('ANN_CODUNI').AsString := qryCadAnn.FieldByName('ANN_UNIDAD').AsString;
            qryCadAnn.FieldByName('ANN_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
            qryCadAnn.FieldByName('ANN_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
            qryCadAnn.FieldByName('ANN_CODEMB').AsString := fRetCodEmbalagem(qryCadAnn.FieldByName('ANN_UNIDAD').AsString);
            qryCadAnn.FieldByName('ANN_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

            fltFator := fRetFatorUnidade(qryBases.FieldByName('BAS_UNIDAD').AsString, qryCadNfm.FieldByName('NFM_UNIDAD').AsString, qryBases.RecordCount);

            For intContador := 1 To 20 Do
            Begin

              If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
                Break;

              qryCadAnn.FieldByName('ANN_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);
              qryCadAnn.FieldByName('ANN_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=  qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fltFator;
            End;

            qryCadAnn.FieldByName('ANN_MD5KEY').AsString := GetMD5(qryCadAnn.FieldByName('ANN_DESCRI').AsString +
                                                                   qryCadAnn.FieldByName('ANN_CODIGO').AsString +
                                                                   qryCadAnn.FieldByName('ANN_UNIDAD').AsString +
                                                                   qryCadAnn.FieldByName('ANN_CODBAS').AsString +
                                                                   qryCadAnn.FieldByName('ANN_CODEMB').AsString +
                                                                   qryCadAnn.FieldByName('ANN_CODUNI').AsString +
                                                                   qryCadAnn.FieldByName('ANN_PRODUT').AsString);

            qryCadAnn.Post;
            qryBases.Next;
          End;
          qryCadNfm.Next;
          Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
        End;
      Except
        On E: Exception Do
        Begin
          Gravando.Cancelar;
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;

      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally
    Gravando.Texto := 'Cadastro de Novas Fórmulas processado com sucesso!';
  End;


end;

function TGravandoExecucaoAnnettaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;


function TGravandoExecucaoAnnettaNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoAnnettaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoAnnettaNovasFormulas.fRetCodEmbalagem(
  strUnidade: String): String;
var
  qryGen: IDataSet;
begin
  Result := '';
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT EMB_CODEMB FROM ANN_CADEMB WHERE EMB_UNIDAD = :CODUNI ';
  qryGen.ParamByName('CODUNI').AsString := strUnidade;
  qryGen.Open;

  If qryGen.ParamByName('CODUNI').AsString = 'LT' Then
    Result := qryGen.FieldByName('EMB_CODEMB').AsString
  Else If qryGen.ParamByName('CODUNI').AsString = 'GL' Then
    Result := qryGen.FieldByName('EMB_CODEMB').AsString
  Else If qryGen.ParamByName('CODUNI').AsString = 'LA' Then
    Result := qryGen.FieldByName('EMB_CODEMB').AsString;

end;

function TGravandoExecucaoAnnettaNovasFormulas.fRetFatorUnidade(strUnidade,
  strUniOrigem: String; intRegistro: Integer): Double;
begin
  Result := 1;
  If intRegistro = 2 Then
  Begin
    If strUnidade = 'LT' Then
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

function TGravandoExecucaoAnnettaNovasFormulas.fRetProximoCodSeq: Integer;
var
  qryGen: IDataset;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT IFNULL(MAX(CONVERT(ANN_CODSEQ, SIGNED)), 0) + 1 AS MAXIMO FROM ANN_CADANN  ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;
end;

end.
