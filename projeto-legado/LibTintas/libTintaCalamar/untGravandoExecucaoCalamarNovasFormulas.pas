{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Calamar *}
{*******************************************************************************PH*}
unit untGravandoExecucaoCalamarNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoCalamarNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    //function fRetornaUnidadeEmbalagem(strCodEmb:String):String;
    //function fRetornaUnidadeEmbalagemOrigem(strCodEmb:String):String;
    //function fRetornaFatorUnidade(strUnidade,strUniOrigem:String; intRegistro:Integer):Double;
    function fRetornaQtdEmbalagem(strCodEmb:String):Double;
    function fFatorUnidade(fltQtdAtual, fltQtdOrigem:Double):Double;
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

{ TGravandoExecucaoCalamarNovasFormulas }

constructor TGravandoExecucaoCalamarNovasFormulas.Create(
  const strCodNfm: string; blnGerarUnidades: Boolean;
  const blnAtualizarUnidade: Boolean; const strUnidadeMenor: String);
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoCalamarNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm   : IDataSet;
  qryCadCal   : IDataSet;
  qryCadEmb   : IDataSet;
  intCont     : Integer;
  fltFator : Double;
  fltQtdOrigem,
  fltQtdAtual:Double;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';

      qryCadCal := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;

      qryCadNfm.SQL := '    SELECT * FROM CAL_CADNFM    ';
      qryCadCal.SQL := '    DELETE FROM CAL_CADCAL    ';

      Gravando.Texto := 'Deletando Cadastro de Novas Fórmulas...';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);
        qryCadCal.SQL := qryCadCal.SQL + ' WHERE CAL_CODNFM = ' + QuotedStr(strCodNfm);
        qryCadCal.ExecSQL;
      End
      Else
      Begin
        qryCadCal.SQL := qryCadCal.SQL + ' WHERE CAL_CODNFM LIKE ''%ESP%'' ';
        qryCadCal.ExecSQL;
      End;

      qryCadCal.SQL.Empty;
      Gravando.Texto := 'Cadastro de Novas Fórmulas deletado...';

      qryCadCal.SQL := '    SELECT * FROM CAL_CADCAL    ';
      qryCadCal.Open;
      qryCadNfm.Open;

      Gravando.Texto := 'Dados carregados com sucesso...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('CAL_CADCAL');
      Gravando.Texto := 'PROCOD verificado com sucesso...';




      Try
        While Not qryCadNfm.Eof Do
        Begin
          qryCadEmb := TAutcomTintaFactory.Get.fGetDataSet;
          qryCadEmb.SQL := 'SELECT * '+
                       '   FROM CAL_CADEMB '+
                       '  INNER JOIN CAL_CADBAS ON EMB_CODEMB = BAS_CODEMB '+
                       '  WHERE BAS_CODBAS = :CODBAS '+
                       '    AND BAS_CODITE IS NOT NULL '+
                       '  ORDER BY EMB_TAMEMB ';
          qryCadEmb.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryCadEmb.Open;
          qryCadEmb.First;

          While Not qryCadEmb.Eof Do
          Begin

            //qryCadEmb.Locate('EMB_TAMEMB', VarArrayOf([qryCadEmb.FieldByName('BAS_CODEMB').AsString]), []);

            qryCadCal.Insert;
            qryCadCal.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CAL_CADCAL', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadCal.FieldByName('CAL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadCal.FieldByName('CAL_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
            qryCadCal.FieldByName('CAL_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
            qryCadCal.FieldByName('CAL_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
            qryCadCal.FieldByName('CAL_KEY1__').AsString := qryCadNfm.FieldByName('NFM_KEY1__').AsString;
            qryCadCal.FieldByName('CAL_KEY2__').AsString := qryCadNfm.FieldByName('NFM_KEY2__').AsString;
            qryCadCal.FieldByName('CAL_KEY3__').AsString := qryCadNfm.FieldByName('NFM_KEY3__').AsString;
            qryCadCal.FieldByName('CAL_CODEMB').AsString := qryCadEmb.FieldByName('BAS_CODEMB').AsString;
            qryCadCal.FieldByName('CAL_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
            qryCadCal.FieldByName('CAL_COLECA').AsString := qryCadNfm.FieldByName('NFM_COLECA').AsString;
            qryCadCal.FieldByName('CAL_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

            fltQtdOrigem := fRetornaQtdEmbalagem(qryCadNfm.FieldByName('NFM_CODEMB').AsString);
            fltQtdAtual  := fRetornaQtdEmbalagem(qryCadEmb.FieldByName('BAS_CODEMB').AsString);

            fltFator := fFatorUnidade(fltQtdAtual, fltQtdOrigem);

            For intCont := 1 To 20 Do
            Begin
              If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
                Break;

              qryCadCal.FieldByName('CAL_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODC' + TStrUtils.fStrZero(intCont, 2)).AsString);

              qryCadCal.FieldByName('CAL_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fltFator;
            End;

            qryCadCal.FieldByName('CAL_MD5KEY').AsString := GetMd5(qryCadCal.FieldByName('CAL_CODBAS').AsString +
                                                                   qryCadCal.FieldByName('CAL_CODEMB').AsString +
                                                                   qryCadCal.FieldByName('CAL_KEY1__').AsString +
                                                                   qryCadCal.FieldByName('CAL_KEY2__').AsString +
                                                                   qryCadCal.FieldByName('CAL_KEY3__').AsString +
                                                                   qryCadCal.FieldByName('CAL_PRODUT').AsString +
                                                                   qryCadCal.FieldByName('CAL_COLECA').AsString);

            qryCadCal.Post;
            qryCadEmb.Next;
          End;
          qryCadNfm.Next;
        End;
      Except
        On E: Exception Do
        Begin
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;
      End;
    Except
      On E: Exception Do
      Begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
  End;
end;

function TGravandoExecucaoCalamarNovasFormulas.fFatorUnidade(fltQtdAtual,
  fltQtdOrigem: Double): Double;
begin
  Result := fltQtdAtual / fltQtdOrigem;
end;

function TGravandoExecucaoCalamarNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoCalamarNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

{
function TGravandoExecucaoCalamarNovasFormulas.fRetornaFatorUnidade(strUnidade,
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
  End
  Else If intRegistro = 4 Then
  Begin
    If strUnidade = 'QT' Then
      Result := 0.25
    Else If strUnidade = 'LT' Then
      Result := 1
    Else If strUnidade = 'GL' Then
      Result := 4
    Else If strUnidade = 'LA' Then
      Result := 20;
  End;
end; }

function TGravandoExecucaoCalamarNovasFormulas.fRetornaQtdEmbalagem(
  strCodEmb: String): Double;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT EMB_TAMEMB  FROM CAL_CADEMB    ' +
                  '     WHERE EMB_CODEMB = :EMBALAGEM       ';

    qryGen.ParamByName('EMBALAGEM').AsString := strCodEmb;
    qryGen.Open;

    Result := qryGen.FieldByName('EMB_TAMEMB').AsFloat;

  Except
    Raise;
  End;
end;

{function TGravandoExecucaoCalamarNovasFormulas.fRetornaUnidadeEmbalagem(
strCodEmb: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT EMB_CODUNI   ' +
                '     FROM CAL_CADEMB     ' +
                '   WHERE EMB_CODEMB = :EMBALAGEM ';

  qryGen.ParamByName('EMBALAGEM').AsString := strCodEmb;
  qryGen.Open;

  Result := qryGen.FieldByName('EMB_CODUNI').AsString;

end;

function TGravandoExecucaoCalamarNovasFormulas.fRetornaUnidadeEmbalagemOrigem(
  strCodEmb: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT EMB_CODUNI   ' +
                '     FROM CAL_CADEMB     ' +
                '   WHERE EMB_CODEMB = :EMBALAGEM ';

  qryGen.ParamByName('EMBALAGEM').AsString := strCodEmb;
  qryGen.Open;

  Result := qryGen.FieldByName('EMB_CODUNI').AsString;

end;}

end.
