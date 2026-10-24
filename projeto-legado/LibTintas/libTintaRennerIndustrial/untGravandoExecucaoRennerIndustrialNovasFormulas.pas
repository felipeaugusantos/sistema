{ ********************************************************************************** }
{ * Classe responsável pela geração do cadastro de novas fórmulas da tinta RennerIndustrial * }
{ *******************************************************************************PH* }
unit untGravandoExecucaoRennerIndustrialNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoRennerIndustrialNovasFormulas = class(TInterfacedObject,
    IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades: Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fRetProximoCodSeq(): Integer;
    function fRetFatorUnidade(strUnidade, strUniOrigem:String; intRegistro:Integer): Double;
    function fRetCodigoEmbalagem(strCodUni:String):String;
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

{ TGravandoExecucaoRennerIndustrialNovasFormulas }

constructor TGravandoExecucaoRennerIndustrialNovasFormulas.Create(const strCodNfm
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

procedure TGravandoExecucaoRennerIndustrialNovasFormulas.Executar(const gravando
  : IGravando);
var
  qryCadNfm: IDataSet;
  qryCadRen: IDataSet;
  qryBases: IDataSet;
  intContador: Integer;
  fltFator: Double;
begin
  Try
    Try

      Gravando.Texto := 'Carregando dados...';

      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadRen := TAutcomTintaFactory.Get.fGetDataSet;

      qryCadNfm.SQL := '  SELECT * FROM REN_CADNFM    ';
      qryCadRen.SQL := '  DELETE FROM REN_CADREN    ';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);
        qryCadRen.SQL := qryCadRen.SQL + '  WHERE REN_CODIGO = ' + QuotedStr(strCodNfm);
      End
      Else
      Begin
        qryCadRen.SQL := qryCadRen.SQL + ' WHERE REN_CODIGO LIKE ''%ESP%''    ';
      End;

      qryCadNfm.Open;
      qryCadRen.ExecSQL;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REN_CADREN');
      gravando.Texto := 'PROCOD verificado com sucesso...';

      qryCadRen.SQL.Empty;
      qryCadRen.SQL := '    SELECT * FROM REN_CADREN  WHERE FALSE   ';
      qryCadRen.Open;

      Gravando.Texto := 'Processando Novas Fórmulas...';

      While Not qryCadNfm.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := '   SELECT *                   ' +
                        '     FROM REN_CADBAS          ' +
                        '   INNER JOIN CADITE ON       ' +
                        '     ITE_CODITE = BAS_CODITE  ' +
                        '   WHERE BAS_BASE__ = :BASE   ' +
                        '     AND BAS_DESCRI = :DESCRI ' ;

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + '  AND BAS_UNIDAD  = :UNIDADE    ';

        If Not (blnAtualizarUnidade) And Not (TStrUtils.fEmptyStr(strUnidadeMenor)) And (blnGerarUnidades) Then
          qryBases.SQL := qryBases.SQL + '  AND BAS_UNIDAD <> :UNIDADE    ';


        qryBases.ParamByName('BASE').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
        qryBases.ParamByName('DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESPRO').AsString;

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

          qryCadRen.Insert;
          qryCadRen.FieldByName('REN_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
          qryCadRen.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REN_CADREN', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadRen.FieldByName('REN_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
          qryCadRen.FieldByName('REN_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadRen.FieldByName('REN_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
          qryCadRen.FieldByName('REN_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
          qryCadRen.FieldByName('REN_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryCadRen.FieldByName('REN_CODEMB').AsString := fRetCodigoEmbalagem(qryCadRen.FieldByName('REN_UNIDAD').AsString);
          qryCadRen.FieldByName('REN_CODUNI').AsString := qryCadRen.FieldByName('REN_UNIDAD').AsString;
          qryCadRen.FieldByName('REN_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
          qryCadRen.FieldByName('REN_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

          fltFator := fRetFatorUnidade(qryBases.FieldByName('BAS_UNIDAD').AsString,
                                     qryCadNfm.FieldByName('NFM_UNIDAD').AsString,
                                     qryBases.RecordCount);


          For intContador := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
              Break;

            qryCadRen.FieldByName('REN_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);

            qryCadRen.FieldByName('REN_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
              qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fltFator;
          End;

          qryCadRen.FieldByName('REN_MD5KEY').AsString := GetMD5(qryCadRen.FieldByName('REN_DESCRI').AsString +
                                                                 qryCadRen.FieldByName('REN_CODIGO').AsString +
                                                                 qryCadRen.FieldByName('REN_UNIDAD').AsString +
                                                                 qryCadRen.FieldByName('REN_CODBAS').AsString +
                                                                 qryCadRen.FieldByName('REN_CODEMB').AsString +
                                                                 qryCadRen.FieldByName('REN_CODUNI').AsString);

          qryCadRen.Post;
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
end;

function TGravandoExecucaoRennerIndustrialNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;



function TGravandoExecucaoRennerIndustrialNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoRennerIndustrialNovasFormulas.fRetCodigoEmbalagem(
  strCodUni: String): String;
Var
  qryGen: IDataSet;
  strGL, strLT, strLA:String;
begin
  Try
    strGL := '';
    strLT := '';
    strLA := '';
    Result := '';

    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := 'SELECT * FROM REN_CADEMB ';
    qryGen.Open;

    While Not qryGen.Eof Do
    Begin
      If qryGen.FieldByName('EMB_UNIDAD').AsString = 'LT' Then
        strLT := qryGen.FieldByName('EMB_CODEMB').AsString;

      If qryGen.FieldByName('EMB_UNIDAD').AsString = 'GL' Then
        strGL := qryGen.FieldByName('EMB_CODEMB').AsString;

      If qryGen.FieldByName('EMB_UNIDAD').AsString = 'LA' Then
        strLA := qryGen.FieldByName('EMB_CODEMB').AsString;

      qryGen.Next;
    End;

    If Not TStrUtils.fEmptyStr(strLT) Then
      Result := strLT
    Else If Not TStrUtils.fEmptyStr(strGL) Then
      Result := strGL
    Else If Not TStrUtils.fEmptyStr(strLA) Then
      Result := strLA;

  Except
    Raise;
  End;
end;

function TGravandoExecucaoRennerIndustrialNovasFormulas.fRetFatorUnidade(strUnidade,
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

function TGravandoExecucaoRennerIndustrialNovasFormulas.fRetProximoCodSeq: Integer;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT IFNULL(MAX(CONVERT(REN_CODSEQ, SIGNED)), 0) + 1 AS MAXIMO FROM REN_CADREN;  ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;
end;

end.
