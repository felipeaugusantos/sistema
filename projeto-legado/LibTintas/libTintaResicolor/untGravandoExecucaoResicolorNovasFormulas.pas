{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Resicolor *}
{*******************************************************************************PH*}
unit untGravandoExecucaoResicolorNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoResicolorNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fRetProximoCodSeq(): Integer;
    function fGetUnidadesGeracaoCadNfm(strUnidade:String): String;
    function fConverteQtdEmb(fltQtd : Double; strUniOri, strUniNov: String; strCodOri, strCodNov: String): Double;
    function fRetCodEmbalagem(strDescri: String; strUnidade: String): String;
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

{ TGravandoExecucaoResicolorNovasFormulas }

constructor TGravandoExecucaoResicolorNovasFormulas.Create(const strCodNfm: string  = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;

procedure TGravandoExecucaoResicolorNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm, qryCadRsi: IDataSet;
  qryBases: IDataSet;
  intCont: Integer;
  fltFator: Double;
  strEmbOri: String;
  strEmbAtu: String;
Begin
  Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';

  qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadRsi := TAutcomTintaFactory.Get.fGetDataSet;

  qryCadNfm.SQL := '    SELECT * FROM RSI_CADNFM    ';
  qryCadRsi.SQL := '    DELETE FROM RSI_CADRSI    ';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Gravando.Texto := 'Deletando Cadastro de Novas Fórmulas...';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
  Begin
    qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODPRO = ' + QuotedStr(strCodNfm);
    qryCadRsi.SQL := qryCadRsi.SQL + '  WHERE RSI_CODIGO = ' + QuotedStr(strCodNfm);
  End
  Else
  Begin
    qryCadRsi.SQL := qryCadRsi.SQL + '  WHERE RSI_CODIGO LIKE ''%ESP%'' ';
  End;

  qryCadRsi.ExecSQL;
  qryCadRsi.SQL.Empty;
  Gravando.Texto := 'Cadastro de Novas Fórmulas deletado...';

  qryCadNfm.Open;

  qryCadRsi.SQL := '  SELECT * FROM RSI_CADRSI WHERE FALSE  ';
  qryCadRsi.Open;

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('RSI_CADRSI');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Try
    Try
      Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';

      While Not qryCadNfm.Eof Do
      Begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := '   SELECT * FROM RSI_CADBAS             ' +
                        '     INNER JOIN CADITE ON BAS_CODITE = ITE_CODITE              ' +
                        '   WHERE BAS_BASE__ = :BASE  AND     ' +
                        '     BAS_PROKEY = :PROKEY AND BAS_SUBKEY = :SUBKEY             ' ;

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD = :UNIDADE                 ';

        If Not (blnAtualizarUnidade) And Not (TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD <> :UNIDADE                ';

        If TStrUtils.fEmptyStr(strCodNfm) Then
          qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('BASE').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
        qryBases.ParamByName('PROKEY').AsString := qryCadNfm.FieldByName('NFM_PROKEY').AsString;
        qryBases.ParamByName('SUBKEY').AsString := qryCadNfm.FieldByName('NFM_SUBKEY').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('UNIDADE').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If Not (blnAtualizarUnidade) And Not (TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.ParamByName('UNIDADE').AsString := strUnidadeMenor;

        qryBases.Open;
        qryBases.First;

        While Not qryBases.Eof Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadRsi.Insert;
          qryCadRsi.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('RSI_CADRSI', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadRsi.FieldByName('RSI_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadRsi.FieldByName('RSI_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 15);
          qryCadRsi.FieldByName('RSI_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryCadNfm.FieldByName('NFM_CODPRO').AsString;
          qryCadRsi.FieldByName('RSI_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
          qryCadRsi.FieldByName('RSI_CODIG2').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
          qryCadRsi.FieldByName('RSI_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryCadRsi.FieldByName('RSI_CODITE').AsString := qryBases.FieldByName('BAS_CODITE').AsString;
          qryCadRsi.FieldByName('RSI_BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
          qryCadRsi.FieldByName('RSI_PROKEY').AsString := qryCadNfm.FieldByName('NFM_PROKEY').AsString;
          qryCadRsi.FieldByName('RSI_SUBKEY').AsString := qryCadNfm.FieldByName('NFM_SUBKEY').AsString;
          qryCadRsi.FieldByName('RSI_DTACAD').AsString := qryCadNfm.FieldByName('NFM_DTACAD').AsString;
          qryCadRsi.FieldByName('RSI_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
          qryCadRsi.FieldByName('RSI_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

          strEmbOri := fRetCodEmbalagem(qryCadNfm.FieldByName('NFM_DESCRI').AsString, qryCadNfm.FieldByName('NFM_UNIDAD').AsString);
          strEmbAtu := fRetCodEmbalagem(qryCadNfm.FieldByName('NFM_DESCRI').AsString, qryBases.FieldByName('BAS_UNIDAD').AsString);


          For intCont := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
              Break;

            qryCadRsi.FieldByName('RSI_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intCont, 2)).AsString);


            fltFator := fConverteQtdEmb(qryCadNfm.FieldByName('NFM_QTD0' + TStrUtils.fStrZero(intCont, 2)).AsFloat,
              qryCadNfm.FieldByName('NFM_UNIDAD').AsString, qryBases.FieldByName('BAS_UNIDAD').AsString, strEmbOri, strEmbAtu);

            qryCadRsi.FieldByName('RSI_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat := fltFator;
          End;

          qryCadRsi.FieldByName('RSI_MD5KEY').AsString := GetMD5(qryCadRsi.FieldByName('RSI_DESCRI').AsString +
                                                                 qryCadRsi.FieldByName('RSI_BASE__').AsString +
                                                                 qryCadRsi.FieldByName('RSI_CODIGO').AsString +
                                                                 qryCadRsi.FieldByName('RSI_CODIG2').AsString +
                                                                 qryCadRsi.FieldByName('RSI_PROKEY').AsString +
                                                                 qryCadRsi.FieldByName('RSI_SUBKEY').AsString +
                                                                 qryCadRsi.FieldByName('RSI_UNIDAD').AsString);

          qryCadRsi.Post;
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

function TGravandoExecucaoResicolorNovasFormulas.fConverteQtdEmb(fltQtd: Double;
  strUniOri, strUniNov: String; strCodOri, strCodNov: String): Double;
Var
  qryGen: IDataSet;
  fltUniOri: Double;
  fltUniNov: Double;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := 'SELECT * FROM RSI_CADEMB';
    qryGen.Open;

    qryGen.Locate('EMB_CODEMB;EMB_UNIDAD', VarArrayOf([strCodOri, strUniOri]), []);
    fltUniOri := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

    qryGen.Locate('EMB_CODEMB;EMB_UNIDAD', VarArrayOf([strCodNov, strUniNov]), []);
    fltUniNov := qryGen.FieldByName('EMB_QTDEMB').AsFloat;

    Result := fltUniNov * fltQtd / fltUniOri;
  Except
    Raise;
  End;
end;

function TGravandoExecucaoResicolorNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoResicolorNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoResicolorNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoResicolorNovasFormulas.fRetCodEmbalagem(strDescri,
  strUnidade: String): String;
begin
  Result := '04';

  If (Pos('TEXTURA', strDescri) > 0) And (strUnidade = 'GL') Then
    Result := '08'
  Else If (Pos('TEXTURA', strDescri) > 0) And (strUnidade = 'LA') Then
    Result := '07'
  Else If (Pos('RAFIATTO', strDescri) > 0) And (strUnidade = 'GL') Then
    Result := '09'
  Else If (Pos('RAFIATTO', strDescri) > 0) And (strUnidade = 'LA') Then
    Result := '10'
  Else If (Pos('TEXTURA_RAFIATTO_', strDescri) <= 0) And (strUnidade = 'LT') Then
    Result := '04'
  Else If (Pos('TEXTURA_RAFIATTO_', strDescri) <= 0) And (strUnidade = 'GL') Then
    Result := '05'
  Else If (Pos('TEXTURA_RAFIATTO_', strDEscri) <= 0) And (strUnidade = 'LA') Then
    Result := '06';
end;

function TGravandoExecucaoResicolorNovasFormulas.fRetProximoCodSeq: Integer;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT IFNULL(MAX(RSI_CODSEQ), 0) + 1 AS MAXIMO FROM RSI_CADRSI; ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;

end;

end.
