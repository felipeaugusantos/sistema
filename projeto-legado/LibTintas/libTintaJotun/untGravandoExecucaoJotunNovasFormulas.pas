{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Jotun *}
{*******************************************************************************PH*}
unit untGravandoExecucaoJotunNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoJotunNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
//    function fBaseProduto(strCodBas, strCodUni: String): String;
    function fRetFatorUnidade(fltVolOri, fltVolAtu: Double): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
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

{ TGravandoExecucaoJotunNovasFormulas }

constructor TGravandoExecucaoJotunNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True;
  const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoJotunNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm          : IDataSet;
  qryCadJOT          : IDataSet;
  qryBases           : IDataSet;
  intCont            : Integer;
  strMd5             : String;
  fltFator           : double;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM JOT_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadJOT := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('JOT_CADJOT', false);
      gravando.Texto := 'PROCOD verificado com sucesso!';


      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_CODUNI              ' +
                        '      , BAS_DESCRI              ' +
                        '      , BAS_CODBAS              ' +
                        '      , BAS_EMBALA              ' +
                        '   FROM JOT_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_CODBAS = :CODBAS    ' +
                        '    AND BAS_TIPO__ = :TIPO__    ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);

       qryBases.SQL := qryBases.SQL + ' ORDER BY BAS_EMBALA ';

        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
        qryBases.ParamByName('TIPO__').AsString := qryCadNfm.FieldByName('NFM_TIPO__').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_UNIDAD').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        qryBases.First;
        While Not qryBases.Eof Do
        Begin
          Try
            qryCadJOT.SQL := 'SELECT * FROM JOT_CADJOT WHERE FALSE';
            qryCadJOT.Open;

            qryCadJOT.Insert;
            qryCadJOT.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('JOT_CADJOT',TAutcomTintaFactory.Get.GetCodEmp);
            qryCadJOT.FieldByName('JOT_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadJOT.FieldByName('JOT_CODUNI').AsString := qryBases.FieldByName('BAS_CODUNI').AsString;
            qryCadJOT.FieldByName('JOT_DESCRI').AsString := qryBases.FieldByName('BAS_DESCRI').AsString + ' - '+ qryBases.FieldByName('BAS_CODBAS').AsString;
            qryCadJOT.FieldByName('JOT_REFERE').AsString := qryCadNfm.FieldByName('NFM_REFERE').AsString;
            qryCadJOT.FieldByName('JOT_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
            qryCadJOT.FieldByName('JOT_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
            qryCadJOT.FieldByName('JOT_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
            qryCadJOT.FieldByName('JOT_TIPO__').AsString := qryCadNfm.FieldByName('NFM_TIPO__').AsString;
            qryCadJOT.FieldByName('JOT_BASE__').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
            qryCadJOT.FieldByName('JOT_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
            qryCadJOT.FieldByName('JOT_EMBALA').AsString := qryBases.FieldByName('BAS_EMBALA').AsString;
            qryCadJOT.FieldByName('JOT_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

            fltFator := fRetFatorUnidade(StrToFloat(qryCadNfm.FieldByName('NFM_EMBALA').AsString), StrToFloat(qryBases.FieldByName('BAS_EMBALA').AsString));

            for intCont := 1 to 20 do
            begin
              if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                Break;

              if qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 then
                Break;

              qryCadJOT.FieldByName('JOT_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

              qryCadJOT.FieldByName('JOT_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
              TAutcomTintaFactory.Get.fFormataFloat(qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fltFator, 1);
            end;

            strMd5 := '';
            strMd5 := strMd5 + qryCadJOT.FieldByName('JOT_CODUNI').AsString;
            strMd5 := strMd5 + qryCadJOT.FieldByName('JOT_DESCRI').AsString;
            strMd5 := strMd5 + qryCadJOT.FieldByName('JOT_REFERE').AsString;
            strMd5 := strMd5 + qryCadJOT.FieldByName('JOT_NOMCOR').AsString;
            strMd5 := strMd5 + qryCadJOT.FieldByName('JOT_TIPO__').AsString;
            strMd5 := strMd5 + qryCadJOT.FieldByName('JOT_BASE__').AsString;

            for intCont := 1 to 20 do
            begin
              strMd5 := strMd5 + qryCadJOT.FieldByName('JOT_FORM' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsString;
              strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qryCadJOT.FieldByName('JOT_QTDB' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsFloat ),
                ',', '.', [rfReplaceAll]);
            end;

            qryCadJOT.FieldByName('JOT_MD5KEY').AsString := GetMD5(strMd5);

            qryCadJOT.Post;
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

function TGravandoExecucaoJotunNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoJotunNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_CODUNI = "LA" ';
end;

function TGravandoExecucaoJotunNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoJotunNovasFormulas.fRetFatorUnidade(fltVolOri,
  fltVolAtu: Double): Double;
begin
  Result := fltVolAtu / fltVolOri;
end;

procedure TGravandoExecucaoJotunNovasFormulas.RemoverNovasFormulas;
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryGen.SQL :=
          ' DELETE                        ' +
          ' FROM                          ' +
          '   JOT_CADJOT                  ' +
          ' WHERE LEFT(JOT_CODNFM, 13) IN ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     JOT_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   JOT_CADJOT                           ' +
          ' WHERE LEFT(JOT_CODNFM, 13) IN          ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     JOT_CADNFM                         ' +
          '   WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm) + ') ';
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
