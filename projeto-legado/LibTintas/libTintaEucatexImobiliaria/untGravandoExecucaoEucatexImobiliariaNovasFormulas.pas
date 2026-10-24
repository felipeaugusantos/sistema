{**********************************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Eucatex Imobiliaria *}
{*******************************************************************************************PH*}
unit untGravandoExecucaoEucatexImobiliariaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, untIConfTinta;

type
  TGravandoExecucaoEucatexImobiliariaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    conf: IConfTinta;

    function fFloatMd5(v: Double): string;
    procedure RemoverNovasFormulas();
    function fRetPesoUnidade(fltBasEmb: Double; fltBasNfm: Double): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
    function fGetProxCodSeq: Integer;
//    function fRetFatorUnidade(strUnidade: String): Double;
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

{ TGravandoExecucaoEucatexImobiliariaNovasFormulas }

constructor TGravandoExecucaoEucatexImobiliariaNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True; const blnAtualizarUnidade: Boolean = False;
  const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('EUC');
end;

procedure TGravandoExecucaoEucatexImobiliariaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryCadEuc: IDataSet;
  qryBases : IDataSet;
  qryVolumeEspecifico: IDataSet;
  intCont: Integer;
  strMd5: String;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM EUC_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadEuc := TAutcomTintaFactory.Get.fGetDataSet;
      qryVolumeEspecifico := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('EUC_CADEUC');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT *              ' +
                        '   FROM EUC_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_PRODUT = :PRODUT    ' +
                        '    AND BAS_DESCRI = :CODBAS    ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_DESBAS').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        Try
          Try
            qryBases.First;
            While Not qryBases.Eof Do
            Begin
              qryCadEuc.SQL := TAutcomTintaFactory.Get.GetInsert('EUC_CADEUC');
              qryCadEuc.ParamByName('EUC_CODSEQ').AsString  := TStrUtils.fStrZero(fGetProxCodSeq, 6);
              qryCadEuc.ParamByName('EUC_CODNFM').AsString := AnsiUpperCase(qryCadNfm.FieldByName('NFM_CODNFM').AsString);
              qryCadEuc.ParamByName('EUC_CODCOR').AsString := AnsiUpperCase(qryCadNfm.FieldByName('NFM_CODNFM').AsString);
              qryCadEuc.ParamByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('EUC_CADEUC', qryCadNfm.FieldByName('NFM_CODEMP').AsString);
              qryCadEuc.ParamByName('EUC_CODEMP').AsString  := qryCadNfm.FieldByName('NFM_CODEMP').AsString;
              qryCadEuc.ParamByName('EUC_DESCOR').AsString  := AnsiUpperCase(qryCadNfm.FieldByName('NFM_DESCOR').AsString);
              qryCadEuc.ParamByName('EUC_PRODUT').AsString  := AnsiUpperCase(qryCadNfm.FieldByName('NFM_PRODUT').AsString);
              qryCadEuc.ParamByName('EUC_OBSCOR').AsString  := AnsiUpperCase(qryCadNfm.FieldByName('NFM_OBSCOR').AsString);
              qryCadEuc.ParamByName('EUC_DESBAS').AsString  := AnsiUpperCase(qryCadNfm.FieldByName('NFM_DESBAS').AsString);
              qryCadEuc.ParamByName('EUC_UNIDAD').AsString  := AnsiUpperCase(qryBases.FieldByName('BAS_CODUNI').AsString);
              qryCadEuc.ParamByName('EUC_DTACAD').AsDateTime:= qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
              qryCadEuc.ParamByName('EUC_ACRMOB').AsFloat   := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
              qryCadEuc.ParamByName('EUC_EMBALA').AsFloat   := qryBases.FieldByName('BAS_EMBALA').AsFloat;
              qryCadEuc.ParamByName('EUC_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;

              strMd5 := '';
              strMd5 := strMd5 + qryCadEuc.ParamByName('EUC_CODNFM').AsString;
              strMd5 := strMd5 + qryCadEuc.ParamByName('EUC_CODCOR').AsString;
              strMd5 := strMd5 + qryCadEuc.ParamByName('EUC_DESCOR').AsString;
              strMd5 := strMd5 + qryCadEuc.ParamByName('EUC_PRODUT').AsString;
              strMd5 := strMd5 + qryCadEuc.ParamByName('EUC_OBSCOR').AsString;
              strMd5 := strMd5 + qryCadEuc.ParamByName('EUC_DESBAS').AsString;
              strMd5 := strMd5 + qryCadEuc.ParamByName('EUC_UNIDAD').AsString;
              strMd5 := strMd5 + fFloatMd5(qryCadEuc.ParamByName('EUC_EMBALA').AsFloat);

              For intCont := 1 To 20 Do
              Begin
                If (TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString)) Then
                  Break;

                qryCadEuc.ParamByName('EUC_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);
                qryCadEuc.ParamByName('EUC_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat
                  * fRetPesoUnidade(qryBases.FieldByName('BAS_EMBALA').AsFloat, qryCadNfm.FieldByName('NFM_EMBALA').AsFloat);

                strMd5 := strMd5 + qryCadEuc.ParamByName('EUC_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString;
                strMd5 := strMd5 + fFloatMd5(qryCadEuc.ParamByName('EUC_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat);
              End;

              qryCadEuc.ParamByName('EUC_MD5KEY').AsString := GetMD5(strMd5);
              qryCadEuc.ExecSQL;

              if not (blnGerarUnidades) then
                Break;

              qryBases.Next;
            End;
          Except
            on E: Exception do
            begin
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          qryCadNfm.Next;
          gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
        End;
      end;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoEucatexImobiliariaNovasFormulas.fFloatMd5(
  v: Double): string;
begin
  Result := FormatFloat('0.0000', v, TFormatSettings.Invariant);
end;

function TGravandoExecucaoEucatexImobiliariaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoEucatexImobiliariaNovasFormulas.fGetProxCodSeq: Integer;
  Var
    qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT IFNULL(MAX(EUC_CODSEQ) + 1,1) AS "PROX" FROM EUC_CADEUC';
  qryGen.Open;

  Result := qryGen.FieldByName('PROX').AsInteger;
end;

function TGravandoExecucaoEucatexImobiliariaNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_CODUNI = "LA" ';
end;

function TGravandoExecucaoEucatexImobiliariaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

{function TGravandoExecucaoEucatexImobiliariaNovasFormulas.fRetFatorUnidade(
  strUnidade: String): Double;
begin
  Result := 1;
  If (strUnidade = conf.fGet('EUCGAL')) Then
    Result := 3.6
  Else If (strUnidade = conf.fGet('EUCQUA')) Then
    Result := 0.9
  Else If (strUnidade = conf.fGet('EUCLAT')) Then
    Result := 18;
end;}

function TGravandoExecucaoEucatexImobiliariaNovasFormulas.fRetPesoUnidade(fltBasEmb: Double; fltBasNfm: Double): Double;
begin
  if SameValue(fltBasNfm, 0) then
    raise Exception.Create('NFM_EMBALA Zerado para a fórmula em processamento.')
  else
    Result := fltBasEmb / fltBasNfm;
end;

procedure TGravandoExecucaoEucatexImobiliariaNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  if TStrUtils.fEmptyStr(strCodNfm) then
  begin
    qryGen.SQL :=
      ' DELETE               ' +
      ' FROM                 ' +
      '   EUC_CADEUC         ' +
      ' WHERE EUC_CODNFM IN  ' +
      '   (SELECT            ' +
      '     NFM_CODNFM       ' +
      '   FROM               ' +
      '     EUC_CADNFM)      ';
  end
  else
  begin
    qryGen.SQL :=
      ' DELETE               ' +
      ' FROM                 ' +
      '   EUC_CADEUC         ' +
      ' WHERE EUC_CODNFM IN  ' +
      '   (SELECT            ' +
      '     NFM_CODNFM       ' +
      '   FROM               ' +
      '     EUC_CADNFM       ' +
      '   WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm) + ') ';
  end;

  qryGen.ExecSQL;
end;

end.
