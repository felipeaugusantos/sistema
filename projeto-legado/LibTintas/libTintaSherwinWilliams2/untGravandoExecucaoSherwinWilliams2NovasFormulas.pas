{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta SherwinWilliams2 *}
{*******************************************************************************PH*}
unit untGravandoExecucaoSherwinWilliams2NovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoSherwinWilliams2NovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
//    function fBaseProduto(strCodBas, strCodUni: String): String;
    function fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
  public
    constructor Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
     const blnAtualizarUnidade: Boolean = false; const strUnidadeMenor: String = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoSherwinWilliams2NovasFormulas }

constructor TGravandoExecucaoSherwinWilliams2NovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True;
  const blnAtualizarUnidade: Boolean = false; const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoSherwinWilliams2NovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm          : IDataSet;
  qryCadSHW          : IDataSet;
  qryBases           : IDataSet;
  intCont            : Integer;
  strMd5             : String;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM SHW_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadSHW := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SHW_CADSHW');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_CODUNI              ' +
                        '   FROM SHW_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_PRODUT = :PRODUT    ' +
                        '    AND BAS_CODBAS = :CODBAS    ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_CODUNI').AsString);

        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
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
            qryCadSHW.SQL := 'SELECT * '+
                             '  FROM SHW_CADSHW '+
                             ' WHERE FALSE';
            qryCadSHW.Open;

            qryCadSHW.Insert;
            qryCadSHW.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SHW_CADSHW',TAutcomTintaFactory.Get.GetCodEmp);
            qryCadSHW.FieldByName('SHW_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadSHW.FieldByName('SHW_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
            qryCadSHW.FieldByName('SHW_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
            qryCadSHW.FieldByName('SHW_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
            qryCadSHW.FieldByName('SHW_BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
            qryCadSHW.FieldByName('SHW_CODUNI').AsString := qryBases.FieldByName('BAS_CODUNI').AsString;
            qryCadSHW.FieldByName('SHW_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
            qryCadSHW.FieldByName('SHW_OBSERV').AsString := qryCadNfm.FieldByName('NFM_OBSERV').AsString;

            qryCadSHW.FieldByName('SHW_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
            qryCadSHW.FieldByName('SHW_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

            for intCont := 1 to 20 do
            begin
              if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                Break;

              if qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 then
                Break;

              qryCadSHW.FieldByName('SHW_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

              qryCadSHW.FieldByName('SHW_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat
                  * fRetPesoUnidade(qryBases.FieldByName('BAS_CODUNI').AsString
                                  , qryBases.RecordCount, qryCadNfm.FieldByName('NFM_CODUNI').AsString);
            end;

            strMd5 := '';
            strMd5 := ( qryCadSHW.FieldByName('SHW_CODIGO').AsString +
                        qryCadSHW.FieldByName('SHW_DESCRI').AsString +
                        qryCadSHW.FieldByName('SHW_PRODUT').AsString +
                        qryCadSHW.FieldByName('SHW_BASE__').AsString +
                        qryCadSHW.FieldByName('SHW_CODUNI').AsString );



            qryCadSHW.FieldByName('SHW_MD5KEY').AsString := GetMD5(strMd5);

            qryCadSHW.Post;
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

function TGravandoExecucaoSherwinWilliams2NovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoSherwinWilliams2NovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_CODUNI = "LA" ';
end;


function TGravandoExecucaoSherwinWilliams2NovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoSherwinWilliams2NovasFormulas.fRetPesoUnidade(
  strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
begin
  Result := 1;
  If intRegistros = 3 Then
  Begin
    If Pos(strCodUni, 'LT_QT_') > 0 Then
      Result := 1
    Else If strCodUni = 'GL' Then
      Result := 4
    Else If strCodUni = 'LA' Then
      Result := 20;
  End
  Else If intRegistros = 2 Then
  Begin
    If strCodUni = 'QT' Then
      Result := 1
    Else If (strCodUni = 'GL') And (strUniOri = 'GL') Then
      Result := 1
    Else If strCodUni = 'GL' Then
      Result := 4
    Else If (strCodUni = 'LA') And (strUniOri = 'QT') Then
      Result := 20
    Else If strCodUni = 'LA' Then
      Result := 5;
  End;
end;

procedure TGravandoExecucaoSherwinWilliams2NovasFormulas.RemoverNovasFormulas;
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
          '   SHW_CADSHW        ' +
          ' WHERE SHW_CODIGO IN ' +
          '   (SELECT           ' +
          '     NFM_CODIGO      ' +
          '   FROM              ' +
          '     SHW_CADNFM)     ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE              ' +
          ' FROM                ' +
          '   SHW_CADSHW        ' +
          ' WHERE SHW_CODIGO IN ' +
          '   (SELECT           ' +
          '     NFM_CODIGO      ' +
          '   FROM              ' +
          '     SHW_CADNFM      ' +
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
