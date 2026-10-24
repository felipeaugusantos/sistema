{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Advance *}
{*******************************************************************************PH*}
unit untGravandoExecucaoAdvanceNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoAdvanceNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fRetProximoCodSeq(): Integer;
//    function fRetFatorUnidade(strUnidade,strUniOrigem:String; intRegistro:Integer): Double;
    function fRetQtdEmbalagem(strCodUni:String):Double;
    function fFatorQtd(fltQtdOri, fltQtdAtu:Double):Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade:String): String;
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

{ TGravandoExecucaoAdvanceNovasFormulas }

constructor TGravandoExecucaoAdvanceNovasFormulas.Create(const strCodNfm: string  = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;

procedure TGravandoExecucaoAdvanceNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm, qryCadAdv: IDataSet;
  qryBases: IDataSet;
  strMd5Key:String;
  intCont: Integer;
  fltFator: Double;
  fltAtual,
  fltOrigem:Double;
Begin
  Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';
  qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadAdv := TAutcomTintaFactory.Get.fGetDataSet;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  qryCadNfm.SQL := '    SELECT * FROM ADVCOR_CADNFM     ';
  qryCadAdv.SQL := '    DELETE FROM ADVCOR_CADADV     ';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
  Begin
    qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODPRO = ' + QuotedStr(strCodNfm);
    qryCadAdv.SQL := qryCadAdv.SQL + '  WHERE ADV_CODIGO = ' + QuotedStr(strCodNfm);
  End
  Else
  Begin
    qryCadAdv.SQL := qryCadAdv.SQL + '  WHERE ADV_CODIGO LIKE ''%ESP%''   ';
  End;

  qryCadNfm.Open;
  qryCadAdv.ExecSQL;
  qryCadAdv.SQL.Empty;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('ADVCOR_CADADV');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';
  Gravando.RegistrarProgresso(0, 0, 0);

  qryCadAdv.SQL := '  SELECT * FROM ADVCOR_CADADV   ';
  qryCadAdv.Open;

  Try
    Try
      While Not qryCadNfm.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := '   SELECT * FROM ADVCOR_CADBAS         ' +
                        '     INNER JOIN CADITE ON              ' +
                        '       ITE_CODITE = BAS_CODITE         ' +
                        '   WHERE BAS_BASE__ = :BASE__  AND     ' +
                        '         BAS_PROKEY = :PROKEY  AND     ' +
                        '         BAS_SUBKEY = :SUBKEY          ';



        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD = :UNIDAD    ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD <> :UNIDAD   ';

        If TStrUtils.fEmptyStr(strCodNfm) Then
          qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
        qryBases.ParamByName('PROKEY').AsString := qryCadNfm.FieldByName('NFM_PROKEY').AsString;
        qryBases.ParamByName('SUBKEY').AsString := qryCadNfm.FieldByName('NFM_SUBKEY').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('UNIDAD').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.ParamByName('UNIDAD').AsString := strUnidadeMenor;

        qryBases.Open;


        While Not qryBases.Eof Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadAdv.Insert;
          qryCadAdv.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ADVCOR_CADADV', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadAdv.FieldByName('ADV_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadAdv.FieldByName('ADV_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryCadNfm.FieldByName('NFM_CODPRO').AsString;
          qryCadAdv.FieldByName('ADV_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
          qryCadAdv.FieldByName('ADV_CODIG2').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
          qryCadAdv.FieldByName('ADV_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryCadAdv.FieldByName('ADV_CODITE').AsString := qryBases.FieldByName('BAS_CODITE').AsString;
          qryCadAdv.FieldByName('ADV_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
          qryCadAdv.FieldByName('ADV_BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
          qryCadAdv.FieldByName('ADV_PROKEY').AsString := qryCadNfm.FieldByName('NFM_PROKEY').AsString;
          qryCadAdv.FieldByName('ADV_SUBKEY').AsString := qryCadNfm.FieldByName('NFM_SUBKEY').AsString;
          qryCadAdv.FieldByName('ADV_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
          qryCadAdv.FieldByName('ADV_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

          strMd5Key := strMd5Key + qryCadAdv.FieldByName('ADV_DESCRI').AsString;
          strMd5Key := strMd5Key + qryCadAdv.FieldByName('ADV_CODIGO').AsString;
          strMd5Key := strMd5Key + qryCadAdv.FieldByName('ADV_CODIG2').AsString;
          strMd5Key := strMd5Key + qryCadAdv.FieldByName('ADV_UNIDAD').AsString;

          fltOrigem := fRetQtdEmbalagem(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);
          fltAtual  := fRetQtdEmbalagem(qryBases.FieldByName('BAS_UNIDAD').AsString);

          fltFator := fFatorQtd(fltOrigem, fltAtual);

          For intCont := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
              Break;

            qryCadAdv.FieldByName('ADV_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intCont, 2)).AsString);
            qryCadAdv.FieldByName('ADV_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
              qryCadNfm.FieldByName('NFM_QTD0' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fltFator;

            strMd5Key := strMd5Key + qryCadAdv.FieldByName('ADV_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString;
            strMd5Key := strMd5Key + StringReplace(Format('%.4f', [qryCadAdv.FieldByName('ADV_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat]), ',', '.', [rfReplaceAll]);
          End;


          qryCadAdv.FieldByName('ADV_MD5KEY').AsString := GetMD5(strMd5Key);
          qryCadAdv.Post;

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
    Gravando.Texto := Format('Cadastro de %s processado com sucesso!', ['Novas Fórmulas']);
  End;


End;

function TGravandoExecucaoAdvanceNovasFormulas.fFatorQtd(fltQtdOri,
  fltQtdAtu: Double): Double;
begin
  Result := fltQtdAtu / fltQtdOri;
end;

function TGravandoExecucaoAdvanceNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;





function TGravandoExecucaoAdvanceNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoAdvanceNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

{function TGravandoExecucaoAdvanceNovasFormulas.fRetFatorUnidade(strUnidade,strUniOrigem:String; intRegistro:Integer): Double;
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
end;     }


function TGravandoExecucaoAdvanceNovasFormulas.fRetProximoCodSeq: Integer;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT IFNULL(MAX(ADV_CODSEQ), 0) + 1 AS MAXIMO FROM ADVCOR_CADADV; ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;

end;

function TGravandoExecucaoAdvanceNovasFormulas.fRetQtdEmbalagem(
  strCodUni: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT EMB_QTDEMB AS QTD FROM ADVCOR_CADEMB WHERE EMB_UNIDAD = :UNIDADE    ';
  qryGen.ParamByName('UNIDADE').AsString := strCodUni;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsFloat;
end;

end.
