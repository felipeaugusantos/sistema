{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Iquine *}
{*******************************************************************************PH*}
unit untGravandoExecucaoIquineNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoIquineNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    function fRetProximoCodSeq(): Integer;
    function fRetornaFatorUnidade(fltEmbOri, fltEmbUni: Double):Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade:String):String;
    function fRetCodigoEmbalagem(strUnidade:String; fltEmbalagem: Double):String;
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

{ TGravandoExecucaoIquineNovasFormulas }

constructor TGravandoExecucaoIquineNovasFormulas.Create(const strCodNfm: string  = '';
  blnGerarUnidades : Boolean = true; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoIquineNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm, qryCadIqu, qryBases: IDataSet;
  fltfator: Double;
  intContador: Integer;
begin
  Try
    Try
      Gravando.Texto := 'Carregando Dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadIqu := TAutcomTintaFactory.Get.fGetDataSet;

      qryCadNfm.SQL := '    SELECT * FROM IQU_CADNFM    ';
      qryCadIqu.SQL := '    DELETE FROM IQU_CADIQU    ';

      gravando.Texto := 'Deletando Cadastro de Novas Fórmulas...';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);
        qryCadIqu.SQL := qryCadIqu.SQL + '  WHERE IQU_CODIGO = ' + QuotedStr(strCodNfm);
        qryCadIqu.ExecSQL;
      End
      Else
      Begin
        qryCadIqu.SQL := qryCadIqu.SQL + '    WHERE IQU_CODIGO LIKE ''%ESP%''   ';
        qryCadIqu.ExecSQL;
      End;

      qryCadIqu.SQL.Empty;
      Gravando.Texto := 'Cadastro de Novas Fórmulas Deletado...';

      qryCadIqu.SQL := '    SELECT * FROM IQU_CADIQU  WHERE FALSE   ';
      qryCadIqu.Open;
      qryCadNfm.Open;

      Gravando.Texto := 'Dados carregados com sucesso...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('IQU_CADIQU');
      Gravando.Texto := 'PROCOD verificado com sucesso...';


      Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';
      Try
        While Not qryCadNfm.Eof Do
        Begin


          qryBases := TAutcomTintaFactory.Get.fGetDataSet;
          qryBases.SQL := '   SELECT BAS_UNIDAD, BAS_PRODUT, BAS_EMBALA   ' +
                          '       FROM IQU_CADBAS          ' +
                          '   INNER JOIN CADITE ON  ' +
                          '       ITE_CODITE = BAS_CODITE  ' +
                          '   WHERE BAS_DESCRI LIKE :DESCRI ' +
                          '   AND BAS_BASE__ = :CODBAS    ' +
                          '   AND BAS_PRODUT = :PRODUT    ';

          If Not blnGerarUnidades Then
            qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD = :CODUNI ';

          If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
            qryBases.SQL := qryBases.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

          //Geracao do cadastro de novas formulas
          If TStrUtils.fEmptyStr(strCodNfm) Then
            qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

          qryBases.ParamByName('DESCRI').AsString := '%' + qryCadNfm.FieldByName('NFM_DESPRO').AsString + '%';
          qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;

          If Not blnGerarUnidades Then
            qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

          If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
            qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

          qryBases.Open;

          qryBases.First;
          While Not qryBases.Eof Do
          Begin
            qryCadIqu.Insert;
            qryCadIqu.FieldByName('IQU_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
            qryCadIqu.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('IQU_CADIQU', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadIqu.FieldByName('IQU_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadIqu.FieldByName('IQU_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
            qryCadIqu.FieldByName('IQU_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
            qryCadIqu.FieldByName('IQU_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
            qryCadIqu.FieldByName('IQU_UNIDAD').AsString := qryBases.FieldByName('BAS_UNIDAD').AsString;
            qryCadIqu.FieldByName('IQU_CODUNI').AsString := qryCadIqu.FieldByName('IQU_UNIDAD').AsString;
            qryCadIqu.FieldByName('IQU_CODEMB').AsString := fRetCodigoEmbalagem(qryBases.FieldByName('BAS_UNIDAD').AsString, qryBases.FieldByName('BAS_EMBALA').AsFloat);
            qryCadIqu.FieldByName('IQU_PRODUT').AsString := qryBases.FieldByName('BAS_PRODUT').AsString;
            qryCadIqu.FieldByName('IQU_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
            qryCadIqu.FieldByName('IQU_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
            qryCadIqu.FieldByName('IQU_EMBALA').AsFloat  := qryBases.FieldByName('BAS_EMBALA').AsFloat;

            fltFator := fRetornaFatorUnidade(qryCadNfm.FieldByName('NFM_EMBALA').AsFloat, qryBases.FieldByName('BAS_EMBALA').AsFloat);

            For intContador := 1 To 20 Do
            Begin

              If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
                Break;

              qryCadIqu.FieldByName('IQU_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);

              qryCadIqu.FieldByName('IQU_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
                qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fltFator;
            End;

            qryCadIqu.FieldByName('IQU_MD5KEY').AsString := GetMd5(qryCadIqu.FieldByName('IQU_DESCRI').AsString +
                                                                   qryCadIqu.FieldByName('IQU_CODIGO').AsString +
                                                                   qryCadIqu.FieldByName('IQU_UNIDAD').AsString +
                                                                   qryCadIqu.FieldByName('IQU_CODBAS').AsString +
                                                                   qryCadIqu.FieldByName('IQU_CODEMB').AsString +
                                                                   qryCadIqu.FieldByName('IQU_CODUNI').AsString);
            qryCadIqu.Post;
            qryBases.Next;

          End;
          qryCadNfm.Next;
          Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
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
    Gravando.Texto := 'Cadastro de Novas Fórmulas processado com sucesso!';
  End;
end;

function TGravandoExecucaoIquineNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;


function TGravandoExecucaoIquineNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_UNIDAD IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_UNIDAD = "LA" ';
end;

function TGravandoExecucaoIquineNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoIquineNovasFormulas.fRetCodigoEmbalagem(
  strUnidade: String; fltEmbalagem: Double): String;
Var
  qryGen: IDataSet;
begin
  Result := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT EMB_CODEMB FROM IQU_CADEMB WHERE EMB_UNIDAD = :UNIDAD AND EMB_QTDEMB = :QTDEMB     ';
  qryGen.ParamByName('UNIDAD').AsString := strUnidade;
  qryGen.ParamByName('QTDEMB').AsFloat := fltEmbalagem;
  qryGen.Open;

  Result := qryGen.FieldByName('EMB_CODEMB').AsString;
end;

function TGravandoExecucaoIquineNovasFormulas.fRetornaFatorUnidade(fltEmbOri, fltEmbUni: Double): Double;
begin
  Result := fltEmbUni / fltEmbOri;
end;

function TGravandoExecucaoIquineNovasFormulas.fRetProximoCodSeq: Integer;
  Var
    qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := 'SELECT IFNULL(MAX(IQU_CODSEQ), 0) + 1 AS MAXIMO FROM IQU_CADIQU;';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;
end;


end.
