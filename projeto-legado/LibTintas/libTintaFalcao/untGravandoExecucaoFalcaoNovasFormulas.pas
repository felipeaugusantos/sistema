{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Falcao *}
{*******************************************************************************PH*}
unit untGravandoExecucaoFalcaoNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoFalcaoNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
//    function fBaseProduto(strCodBas, strCodUni: String): String;
    function fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
    function fRetDescricaoLinha(strCodBas, strCodUni, strCodLin : String ) : String;
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

{ TGravandoExecucaoFalcaoNovasFormulas }

constructor TGravandoExecucaoFalcaoNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True;
  const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoFalcaoNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm          : IDataSet;
  qryCadFAL          : IDataSet;
  qryBases           : IDataSet;
  intCont            : Integer;
  strMd5             : String;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM FAL_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadFAL := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('FAL_CADFAL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_CODUNI              ' +
                        '   FROM FAL_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_LINHA_ = :LINHA_    ' +
                        '    AND BAS_DESCRI = :CODBAS    ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_CODUNI').AsString);

        qryBases.ParamByName('LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_CODUNI').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        qryBases.First;
        While Not qryBases.Eof Do
        Begin
          Try
            qryCadFAL.SQL := 'SELECT * FROM FAL_CADFAL WHERE FALSE';
            qryCadFAL.Open;

            qryCadFAL.Insert;
            qryCadFAL.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('FAL_CADFAL',TAutcomTintaFactory.Get.GetCodEmp);
            qryCadFAL.FieldByName('FAL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadFAL.FieldByName('FAL_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
            qryCadFAL.FieldByName('FAL_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
            qryCadFAL.FieldByName('FAL_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
            qryCadFAL.FieldByName('FAL_BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
            qryCadFAL.FieldByName('FAL_CODUNI').AsString := qryBases.FieldByName('BAS_CODUNI').AsString;
            qryCadFAL.FieldByName('FAL_DESCRI').AsString := fRetDescricaoLinha(qryCadNfm.FieldByName('NFM_BASE__').AsString
                                                                              ,qryBases.FieldByName('BAS_CODUNI').AsString
                                                                              ,qryCadNfm.FieldByName('NFM_LINHA_').AsString)+ ' '+qryCadNfm.FieldByName('NFM_DESCRI').AsString;

            qryCadFAL.FieldByName('FAL_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
            qryCadFAL.FieldByName('FAL_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

            for intCont := 1 to 20 do
            begin
              if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                Break;

              if qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 then
                Break;

              qryCadFAL.FieldByName('FAL_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

              qryCadFAL.FieldByName('FAL_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat
                  * fRetPesoUnidade(qryBases.FieldByName('BAS_CODUNI').AsString
                                  , qryBases.RecordCount, qryCadNfm.FieldByName('NFM_CODUNI').AsString);
            end;

            strMd5 := '';
            strMd5 := (qryCadFAL.FieldByName('FAL_CODIGO').AsString +
                       qryCadFAL.FieldByName('FAL_BASE__').AsString +
                       qryCadFAL.FieldByName('FAL_CODUNI').AsString +
                       qryCadFAL.FieldByName('FAL_LINHA_').AsString);

            qryCadFAL.FieldByName('FAL_MD5KEY').AsString := GetMD5(strMd5);

            qryCadFAL.Post;
          Except
            On E : Exception do
              gravando.Texto := 'Erro ao gerar o cadastro de Novas Fórmulas! ' + e.Message;
          end;
        //end;
          qryBases.Next;
        End;
        qryCadNfm.Next;
        gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
      end;
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
  End;
end;

function TGravandoExecucaoFalcaoNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoFalcaoNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","BD") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_CODUNI = "BD" ';
end;

function TGravandoExecucaoFalcaoNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoFalcaoNovasFormulas.fRetDescricaoLinha(strCodBas,strCodUni, strCodLin: String): String;
Var
  qryCadBas : IDataSet;
begin
  qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadBas.SQL := 'SELECT BAS_DESLIN '+
                   '  FROM FAL_CADBAS'+
                   ' WHERE BAS_DESCRI = :CODBAS'+
                   '   AND BAS_CODUNI = :CODUNI'+
                   '   AND BAS_LINHA_ = :LINHA_';
  qryCadBas.ParamByName('CODBAS').AsString := strCodBas;
  qryCadBas.ParamByName('CODUNI').AsString := strCodUni;
  qryCadBas.ParamByName('LINHA_').AsString := strCodLin;
  qryCadBas.Open;

  Result := qryCadBas.FieldByName('BAS_DESLIN').AsString;
end;

function TGravandoExecucaoFalcaoNovasFormulas.fRetPesoUnidade(
  strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
begin
  Result := 1;
  If intRegistros = 3 Then
  Begin
    If Pos(strCodUni, 'LT_QT_') > 0 Then
      Result := 1
    Else If strCodUni = 'GL' Then
      Result := 4
    Else If strCodUni = 'BD' Then
      Result := 20;
  End
  Else If intRegistros = 2 Then
  Begin
    If strCodUni = 'LT' Then
      Result := 1
    Else If (strCodUni = 'GL') And (strUniOri = 'GL') Then
      Result := 1
    Else If strCodUni = 'GL' Then
      Result := 4
    Else If (strCodUni = 'BD') And (strUniOri = 'LT') Then
      Result := 20
    Else If strCodUni = 'BD' Then
      Result := 5;
  End;
end;

procedure TGravandoExecucaoFalcaoNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL :=
          ' DELETE              ' +
          ' FROM                ' +
          '   FAL_CADFAL        ' +
          ' WHERE FAL_CODIGO IN ' +
          '   (SELECT           ' +
          '     NFM_CODIGO      ' +
          '   FROM              ' +
          '     FAL_CADNFM)     ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE              ' +
          ' FROM                ' +
          '   FAL_CADFAL        ' +
          ' WHERE FAL_CODIGO IN ' +
          '   (SELECT           ' +
          '     NFM_CODIGO      ' +
          '   FROM              ' +
          '     FAL_CADNFM      ' +
          '   WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm) + ') ';
      end;

      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

end.
