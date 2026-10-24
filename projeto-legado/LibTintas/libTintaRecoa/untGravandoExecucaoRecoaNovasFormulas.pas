{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Recoa *}
{*******************************************************************************PH*}
unit untGravandoExecucaoRecoaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoRecoaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoRecoaNovasFormulas }

constructor TGravandoExecucaoRecoaNovasFormulas.Create(const strCodNfm: string  = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;

procedure TGravandoExecucaoRecoaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm, qryCadRec: IDataSet;
  qryBases: IDataSet;
  intCont: Integer;
  fltFator: Double;
Begin
  Try
    Try
      gravando.Texto := 'Carregando Dados... ';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadRec := TAutcomTintaFactory.Get.fGetDataSet;

      qryCadNfm.SQL := '    SELECT * FROM REC_CADNFM    ';
      qryCadRec.SQL := '     DELETE FROM REC_CADREC     ';
      If strCodNfm <> '' Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);
        qryCadRec.SQL := qryCadRec.SQL + ' WHERE REC_CODIGO = ' + QuotedStr(strCodNfm);
        qryCadRec.ExecSQL;
      End
      Else
      Begin
        qryCadRec.SQL := qryCadRec.SQL + ' WHERE REC_CODIGO LIKE ''%ESP%'' ';
        qryCadRec.ExecSQL;
      End;

      qryCadRec.SQL.Empty;
      qryCadRec.SQL := '    SELECT * FROM REC_CADREC WHERE FALSE    ';


      qryCadNfm.Open;
      qryCadRec.Open;

      gravando.Texto := 'Dados carregados com sucesso...';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REC_CADREC');
      gravando.Texto := 'PROCOD verificado com sucesso...';

      qryCadNfm.First;

      While Not qryCadNfm.Eof Do
      Begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_UNIDAD                ' +
                          '   FROM REC_CADBAS              ' +
                          '  INNER JOIN CADITE             ' +
                          '     ON ITE_CODITE = BAS_CODITE ' +
                          '  WHERE BAS_DESCRI LIKE :PRODUT ' +
                          '    AND BAS_BASE__ = :CODBAS    ';

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

        Try
          Begin
            qryBases.First;
            While Not qryBases.Eof Do
            Begin
              qryCadRec.Insert;
              qryCadRec.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('REC_CADREC', TAutcomTintaFactory.Get.GetCodEmp);
              qryCadRec.FieldByName('REC_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
              qryCadRec.FieldByName('REC_CODSEQ').AsString := TstrUtils.fStrZero(fRetProximoCodSeq, 6);
              qryCadRec.FieldByName('REC_ATIVAD').AsString  := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
              qryCadRec.FieldByName('REC_DTACAD').AsDate    := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
              qryCadRec.FieldByName('REC_DESCRI').AsString  := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
              qryCadRec.FieldByName('REC_CODIGO').AsString  := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
              qryCadRec.FieldByName('REC_UNIDAD').AsString  := qryBases.FieldByName('BAS_UNIDAD').AsString;
              qryCadRec.FieldByName('REC_CODUNI').AsString  := qryCadRec.FieldByName('REC_UNIDAD').AsString;
              qryCadRec.FieldByName('REC_CODEMB').AsString  := fRetornaCodEmbalagem(qryBases.FieldByName('BAS_UNIDAD').AsString);
              qryCadRec.FieldByName('REC_CODBAS').AsString  := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
              qryCadRec.FieldByName('REC_ACRMOB').AsFloat   := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

              fltFator := fRetFatorUnidade(qryBases.FieldByName('BAS_UNIDAD').AsString,qryCadNfm.FieldByName('NFM_UNIDAD').AsString, qryBases.RecordCount);

              For intCont := 1 To 20 Do
              Begin
                If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
                  Break;

                qryCadRec.FieldByName('REC_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

                qryCadRec.FieldByName('REC_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                  qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fltFator;

              End;

              qryCadRec.FieldByName('REC_MD5KEY').AsString := GetMD5(qryCadRec.FieldByName('REC_DESCRI').AsString +
                                                                     qryCadRec.FieldByName('REC_CODIGO').AsString +
                                                                     qryCadRec.FieldByName('REC_UNIDAD').AsString +
                                                                     qryCadRec.FieldByName('REC_CODBAS').AsString +
                                                                     qryCadRec.FieldByName('REC_CODEMB').AsString +
                                                                     qryCadRec.FieldByName('REC_CODUNI').AsString);

              qryCadRec.Post;

              If Not blnGerarUnidades Then
                Break;

              qryBases.Next;


            End;
          End;
        Except
          On E: Exception Do
          Begin
            gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
          End;

        End;

        gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);

        qryCadNfm.Next;

      End;
    Except
      On  E: Exception Do
      Begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally
    Gravando.Texto := 'Novas Formulas geradas com sucesso...';
  End;

End;

function TGravandoExecucaoRecoaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;





function TGravandoExecucaoRecoaNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoRecoaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoRecoaNovasFormulas.fRetFatorUnidade(strUnidade,strUniOrigem:String; intRegistro:Integer): Double;
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

function TGravandoExecucaoRecoaNovasFormulas.fRetornaCodEmbalagem(
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

function TGravandoExecucaoRecoaNovasFormulas.fRetProximoCodSeq: Integer;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT IFNULL(MAX(REC_CODSEQ), 0) + 1 AS MAXIMO FROM REC_CADREC; ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;

end;

end.
