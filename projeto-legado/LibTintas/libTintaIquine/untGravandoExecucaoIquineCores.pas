{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Iquine *}
{**********************************************************************PH*}
unit untGravandoExecucaoIquineCores;

interface

uses
  untAbstractGravandoExecucaoIquine, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  Variants, ADODB, System.Classes;

type
  TGravandoExecucaoIquineCores = class(TAbstractGravandoExecucaoIquine)
  Private
    function fRetProximoCodSeq(): Integer;
    function fRetCodEmbalagem(strCodEmbOrigem, strUniDes:String; strQtdEmb: String):String;
    procedure DeletarFormulaQtdMin(cdsDados: IDataSet);
    function fRetCodUni(fltValor : Double) : String;
    function fVerificaProximaFormula(strBasAnt, strUniAnt, strCodAnt, strProAnt, strEmbAnt: String; cdsDados: IDataSet): Boolean;
    procedure ProcessarCores(qryCadCor, cdsDados: IDataSet; const gravando: IGravando; intColorante: Integer);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoIquineCores }

procedure TGravandoExecucaoIquineCores.DeletarFormulaQtdMin(cdsDados: IDataSet);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL +  ' SELECT *          ';
  qryGen.SQL := qryGen.SQL +  '   FROM  IQU_CADIQU      ';
  qryGen.SQL := qryGen.SQL +  ' WHERE             ';
  qryGen.SQL := qryGen.SQL +  '   IQU_CODBAS = :BASE  AND       ';
  qryGen.SQL := qryGen.SQL +  '   IQU_UNIDAD = :UNID  AND       ';
  qryGen.SQL := qryGen.SQL +  '   IQU_CODIGO = :CODI  AND       ';
  qryGen.SQL := qryGen.SQL +  '   IQU_PRODUT = :PROD  AND       ';
  qryGen.SQL := qryGen.SQL +  '   IQU_EMBALA = :EMBA            ';

  qryGen.ParamByName('BASE').AsString := cdsDados.FieldByName('BASE').AsString;
  qryGen.ParamByName('UNID').AsString := fRetCodUni(cdsDados.FieldByName('CAPACIDADE').AsFloat);
  qryGen.ParamByName('CODI').AsString := cdsDados.FieldByName('COD_COR').AsString;
  qryGen.ParamByName('PROD').AsString := cdsDados.FieldByName('PRODUTO').AsString;
  qryGen.ParamByName('EMBA').AsString := cdsDados.FieldByName('CAPACIDADE').AsString;
  qryGen.Open;

  If qryGen.IsEmpty Then
    Exit;

  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL +  '  DELETE                ';
  qryGen.SQL := qryGen.SQL +  '    FROM IQU_CADIQU            ';
  qryGen.SQL := qryGen.SQL +  '  WHERE                 ';
  qryGen.SQL := qryGen.SQL +  '    IQU_CODBAS = :BASE AND     ';
  qryGen.SQL := qryGen.SQL +  '    IQU_UNIDAD = :UNID AND     ';
  qryGen.SQL := qryGen.SQL +  '    IQU_CODIGO = :CODI AND     ';
  qryGen.SQL := qryGen.SQL +  '    IQU_PRODUT = :PROD AND     ';
  qryGen.SQL := qryGen.SQL +  '    IQU_EMBALA = :EMBA         ';

  qryGen.ParamByName('BASE').AsString := cdsDados.FieldByName('BASE').AsString;
  qryGen.ParamByName('UNID').AsString := fRetCodUni(cdsDados.FieldByName('CAPACIDADE').AsFloat);
  qryGen.ParamByName('CODI').AsString := cdsDados.FieldByName('COD_COR').AsString;
  qryGen.ParamByName('PROD').AsString := cdsDados.FieldByName('PRODUTO').AsString;
  qryGen.ParamByName('EMBA').AsString := cdsDados.FieldByName('CAPACIDADE').AsString;
  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoIquineCores.Executar(const gravando: IGravando);
var
  qryCadCor    : IDataSet;
  qryDelCor    : IDataSet;
  cdsDados     : IDataSet;
  strBasAnt, strCodAnt,
  strProAnt, strUniAnt,
  strEmbAnt: String;
  fltMinVol    : Double;
  intColorante: Integer;
begin
  Try
    Try
      CarregarDados(gravando);
      fltMinVol := 0.0;
      intColorante := 0;
      qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('IQU_CADIQU');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Apagando os registros da tabela IQU_CADIQU...';
      qryDelCor := TAutcomTintaFactory.Get.fGetDataSet;
      qryDelCor.SQL := 'DELETE FROM IQU_CADIQU';
      qryDelCor.ExecSQL;
      gravando.Texto := 'Registros apagados com sucesso!';

      gravando.Texto := 'Iniciando Geração do Cadastro de Cores...';

      cdsDados := TAutcomTintaFactory.Get.fGetDataSet;
      cdsDados.SQL := 'SELECT * FROM TMP_CORES_IQU';
      cdsDados.Open;

      cdsDados.First;


      While Not cdsDados.Eof Do
      Begin

        if gravando.Status <> sgGravando then
          Exit;

        If StrToFloat(StringReplace(cdsDados.FieldByName('MLS').AsString,'.',',',[])) < fltMinVol Then
        Begin
          DeletarFormulaQtdMin(cdsDados);
          strBasAnt := cdsDados.FieldByName('BASE').AsString;
          strCodAnt := cdsDados.FieldByName('COD_COR').AsString;
          strUniAnt := fRetCodUni(cdsDados.FieldByName('CAPACIDADE').AsFloat);
          strProAnt := cdsDados.FieldByName('PRODUTO').AsString;
          strEmbAnt := cdsDados.FieldByName('CAPACIDADE').AsString;
          cdsDados.Next;
          Continue;
        End;

        If fVerificaProximaFormula(strBasAnt, strUniAnt, strCodAnt, strProAnt, strEmbAnt, cdsDados) Then
        Begin
          cdsDados.Next;
          Continue;
        End;

        qryCadCor.Close;
        qryCadCor.SQL := 'SELECT * '+
                         '  FROM IQU_CADIQU '+
                         ' WHERE IQU_CODBAS = :CODBAS '+
                         '   AND IQU_UNIDAD = :CODUNI '+
                         '   AND IQU_CODIGO = :CODIGO '+
                         '   AND IQU_PRODUT = :PRODUT '+
                         '   AND IQU_EMBALA = :EMBALA ';

        qryCadCor.ParamByName('CODBAS').AsString := cdsDados.FieldByName('BASE').AsString;
        qryCadCor.ParamByName('CODUNI').AsString := fRetCodUni(cdsDados.FieldByName('CAPACIDADE').AsFloat);
        qryCadCor.ParamByName('CODIGO').AsString := cdsDados.FieldByName('COD_COR').AsString;
        qryCadCor.ParamByName('PRODUT').AsString := cdsDados.FieldByName('PRODUTO').AsString;
        qryCadCor.ParamByName('EMBALA').AsString := cdsDados.FieldByName('CAPACIDADE').AsString;
        qryCadCor.Open;

        If qryCadCor.IsEmpty Then
          intColorante := 1
        Else
          Inc(intColorante);

        ProcessarCores(qryCadCor, cdsDados, Gravando, intColorante);
        cdsDados.Next;

      End;
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoIquineCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoIquineCores.fRetCodEmbalagem(strCodEmbOrigem,
  strUniDes: String; strQtdEmb: String): String;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT * FROM IQU_CADEMB';
    qryGen.Open;

    If qryGen.Locate('EMB_UNIDAD;EMB_QTDEMB', VarArrayOf([strUniDes, strQtdEmb]), []) Then
      Result := qryGen.FieldByName('EMB_CODEMB').AsString
    Else
      Result := strCodEmbOrigem;

  Except
    Raise;
  End;
end;

function TGravandoExecucaoIquineCores.fRetCodUni(fltValor : Double): String;
begin
  Result := 'LT';

  If fltValor < 1000 Then
    Result := 'LT'
  Else If fltValor < 5000 Then
    Result := 'GL'
  Else If fltValor > 5000 Then
    Result := 'LA';
end;

function TGravandoExecucaoIquineCores.fRetProximoCodSeq: Integer;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT IFNULL(MAX(CONVERT(IQU_CODSEQ, SIGNED)), 0) + 1 AS MAXIMO FROM IQU_CADIQU    ';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
  Except
    Raise;
  End;
end;

function TGravandoExecucaoIquineCores.fVerificaProximaFormula(strBasAnt,
  strUniAnt, strCodAnt, strProAnt, strEmbAnt: String; cdsDados: IDataSet): Boolean;
begin
  Result := False;

  If cdsDados.FieldByName('BASE').AsString = strBasAnt Then
  Begin
    If (fRetCodUni(cdsDados.FieldByName('CAPACIDADE').AsFloat) = strUniAnt) Then
    Begin
      If (cdsDados.FieldByName('COD_COR').AsString = strCodAnt) Then
      Begin
        If (cdsDados.FieldByName('PRODUTO').AsString = strProAnt) Then
        Begin
          If (cdsDados.FieldByName('CAPACIDADE').AsString = strEmbAnt) Then
          Begin
            Result := True;
            Exit;
          End;
        End;
      End;
    End;
  End;
end;

procedure TGravandoExecucaoIquineCores.ProcessarCores(qryCadCor,
  cdsDados: IDataSet; const gravando: IGravando;  intColorante: Integer);
begin
  If (qryCadCor.IsEmpty) Then
  Begin
    qryCadCor.Insert;
    qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('IQU_CADIQU', TAutcomTintaFactory.Get.GetCodEmp);
    qryCadCor.FieldByName('IQU_CODSEQ').AsString := TStrUtils.fStrZero(fRetProximoCodSeq, 6);
    qryCadCor.FieldByName('IQU_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryCadCor.FieldByName('IQU_DESCRI').AsString   := AnsiUpperCase(cdsDados.FieldByName('NOME_COR').AsString);
    qryCadCor.FieldByName('IQU_CODIGO').AsString := cdsDados.FieldByName('COD_COR').AsString;
    qryCadCor.FieldByName('IQU_UNIDAD').AsString := fRetCodUni(cdsDados.FieldByName('CAPACIDADE').AsFloat);
    qryCadCor.FieldByName('IQU_CODUNI').AsString := fRetCodUni(cdsDados.FieldByName('CAPACIDADE').AsFloat);
    qryCadCor.FieldByName('IQU_CODBAS').AsString := cdsDados.FieldByName('BASE').AsString;
    qryCadCor.FieldByName('IQU_CODEMB').AsString := fRetCodEmbalagem('1', fRetCodUni(cdsDados.FieldByName('CAPACIDADE').AsFloat),
                                                                     cdsDados.FieldByName('CAPACIDADE').AsString);
    qryCadCor.FieldByName('IQU_CODCOL').AsString := cdsDados.FieldByName('COLECAO').AsString;
    qryCadCor.FieldByName('IQU_CODCOR').AsString := cdsDados.FieldByName('COD_COR').AsString;
    qryCadCor.FieldByName('IQU_CORFOR').AsString := cdsDados.FieldByName('COD_COR').AsString;
    qryCadCor.FieldByName('IQU_PRODUT').AsString := cdsDados.FieldByName('PRODUTO').AsString;
    qryCadCor.FieldByName('IQU_EMBALA').AsFloat  := cdsDados.FieldByName('CAPACIDADE').AsFloat;
    qryCadCor.FieldByName('IQU_MD5KEY').AsString := GetMD5(qryCadCor.FieldByName('IQU_CODIGO').AsString +
                                                           qryCadCor.FieldByName('IQU_DESCRI').AsString +
                                                           qryCadCor.FieldByName('IQU_PRODUT').AsString +
                                                           qryCadCor.FieldByName('IQU_CODBAS').AsString +
                                                           qryCadCor.FieldByName('IQU_UNIDAD').AsString +
                                                           qryCadCor.FieldByName('IQU_EMBALA').AsString);

    qryCadCor.FieldByName('IQU_FORM' + TStrUtils.fStrZero(intColorante, 2)).AsString := cdsDados.FieldByName('CORANTE').AsString;
    qryCadCor.FieldByName('IQU_QTDC' + TStrUtils.fStrZero(intColorante, 2)).AsFloat  := StrToFloat(StringReplace(cdsDados.FieldByName('MLS').AsString,'.',',',[]));
    qryCadCor.Post;
  End
  else
  begin
    If intColorante <= 20 Then
    Begin
      qryCadCor.Edit;
      qryCadCor.FieldByName('IQU_FORM'+ TStrUtils.fStrZero(IntToStr(intColorante), 2)).AsString := cdsDados.FieldByName('CORANTE').AsString;
      qryCadCor.FieldByName('IQU_QTDC'+ TStrUtils.fStrZero(IntToStr(intColorante), 2)).AsFloat  := StrToFloat(StringReplace(cdsDados.FieldByName('MLS').AsString,'.',',',[]));
      qryCadCor.Post;
    End
  end;

  gravando.RegistrarProgresso(0, cdsDados.RecNo, cdsDados.RecordCount);
end;

end.
