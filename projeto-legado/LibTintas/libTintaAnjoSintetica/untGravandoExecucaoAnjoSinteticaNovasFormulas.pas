{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta AnjoSintetica *}
{*******************************************************************************PH*}
unit untGravandoExecucaoAnjoSinteticaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoAnjoSinteticaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fRetProximoCodSeq(): Integer;
    function fRetFatorUnidade(strUnidade,strUniOrigem:String; intRegistro:Integer): Double;
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

{ TGravandoExecucaoAnjoSinteticaNovasFormulas }

constructor TGravandoExecucaoAnjoSinteticaNovasFormulas.Create(const strCodNfm: string  = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
end;

procedure TGravandoExecucaoAnjoSinteticaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm, qryCadAja: IDataSet;
  qryBases: IDataSet;
  intContador: Integer;
  fltFator: Double;
  strMd5Key:String;
Begin
  Try
    Try
      Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';

      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadAja := TAutcomTintaFactory.Get.fGetDataSet;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      qryCadNfm.SQL := '  SELECT * FROM AJA_CADNFM  ';
      qryCadAja.SQL := '  DELETE FROM AJA_CADAJA  ';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + '    WHERE NFM_CODPRO = ' + QuotedStr(strCodNfm);
        qryCadAja.SQL := qryCadAja.SQL + '    WHERE AJA_CODIGO = ' + QuotedStr(strCodNfm);
      End
      Else
      Begin
        qryCadAja.SQL := qryCadAja.SQL + '  WHERE AJA_CODIGO LIKE ''%ESP%''   ';
      End;

      qryCadNfm.Open;
      qryCadAja.ExecSQL;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('AJA_CADAJA');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      qryCadAja.SQL.Empty;
      qryCadAja.SQL := '  SELECT * FROM AJA_CADAJA  WHERE FALSE   ';
      qryCadAja.Open;

      Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      While Not qryCadNfm.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := '   SELECT *          ' +
                        '     FROM AJA_CADBAS     ' +
                        '   INNER JOIN CADITE ON  ' +
                        '     ITE_CODITE = BAS_CODITE ' +
                        '   WHERE BAS_BASE__ = :BASE    ' +
                        '     AND BAS_PROKEY = :PKEY    ' +
                        '     AND BAS_SUBKEY = :SKEY    ';


        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD = :UNID    ';

        If Not (blnAtualizarUnidade) And Not (TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.SQL := qryBases.SQL + '    AND BAS_UNIDAD <> :UNID   ';

         If TStrUtils.fEmptyStr(strCodNfm) Then
          qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

         qryBases.ParamByName('BASE').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
         qryBases.ParamByName('PKEY').AsString := qryCadNfm.FieldByName('NFM_PROKEY').AsString;
         qryBases.ParamByName('SKEY').AsString := qryCadNfm.FieldByName('NFM_SUBKEY').AsString;

         If Not blnGerarUnidades Then
           qryBases.ParamByName('UNID').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

         If Not (blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.ParamByName('UNID').AsString := strUnidadeMenor;

         qryBases.Open;
         qryBases.First;

         While Not qryBases.Eof Do
         Begin

           If (Gravando.Status <> sgGravando) Then
             Break;

           qryCadAja.Insert;
           qryCadAja.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('AJA_CADAJA', TAutcomTintaFactory.Get.GetCodEmp);
           qryCadAja.FieldByName('AJA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
           qryCadAja.FieldByName('AJA_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryCadNfm.FieldByName('NFM_CODPRO').AsString;
           qryCadAja.FieldByName('AJA_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
           qryCadAja.FieldByName('AJA_CODIG2').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
           qryCadAja.FieldByName('AJA_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
           qryCadAja.FieldByName('AJA_CODITE').AsString := qryBases.FieldByName('BAS_CODITE').AsString;
           qryCadAja.FieldByName('AJA_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
           qryCadAja.FieldByName('AJA_BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
           qryCadAja.FieldByName('AJA_PROKEY').AsString := qryCadNfm.FieldByName('NFM_PROKEY').AsString;
           qryCadAja.FieldByName('AJA_SUBKEY').AsString := qryCadNfm.FieldByName('NFM_SUBKEY').AsString;
           qryCadAja.FieldByName('AJA_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
           qryCadAja.FieldByName('AJA_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
           qryCadAja.FieldByName('AJA_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

           strMd5Key := qryCadAja.FieldByName('AJA_DESCRI').AsString +
                        qryCadAja.FieldByName('AJA_CODIGO').AsString +
                        qryCadAja.FieldByName('AJA_CODIG2').AsString +
                        qryCadAja.FieldByName('AJA_UNIDAD').AsString +
                        qryCadAja.FieldByName('AJA_PROKEY').AsString +
                        qryCadAja.FieldByName('AJA_SUBKEY').AsString +
                        qryCadAja.FieldByName('AJA_BASE__').AsString ;

           fltFator := fRetFatorUnidade(qryBases.FieldByName('BAS_UNIDAD').AsString, qryCadNfm.FieldByName('NFM_UNIDAD').AsString, qryBases.RecordCount);

           For intContador := 1 To 20 Do
           Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
              Break;

             qryCadAja.FieldByName('AJA_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_COL0' + TStrUtils.fStrZero(intContador, 2)).AsString);

             qryCadAja.FieldByName('AJA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
              qryCadNfm.FieldByName('NFM_QTD0' + TStrUtils.fStrZero(intCOntador, 2)).AsFloat * fltFator;

             strMd5Key := strMd5Key + qryCadAja.FieldByName('AJA_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
             strMd5Key := strMd5Key + StringReplace(FormatFloat('0.0000', qryCadAja.FieldByName('AJA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat), ',' , '.' , []);

           End;

           qryCadAja.FieldByName('AJA_MD5KEY').AsString := GetMD5(strMd5Key);
           qryCadAja.Post;
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

  End;

End;

function TGravandoExecucaoAnjoSinteticaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;





function TGravandoExecucaoAnjoSinteticaNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoAnjoSinteticaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoAnjoSinteticaNovasFormulas.fRetFatorUnidade(strUnidade,strUniOrigem:String; intRegistro:Integer): Double;
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


function TGravandoExecucaoAnjoSinteticaNovasFormulas.fRetProximoCodSeq: Integer;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT IFNULL(MAX(AJA_CODSEQ), 0) + 1 AS MAXIMO FROM AJA_CADAJA; ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;

end;

end.
