{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta QualyVinil *}
{*******************************************************************************PH*}
unit untGravandoExecucaoQualyVinilNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoQualyVinilNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
    function fRetPesoUnidade(strCodUni: String; intRegistros: Integer; strUniOri: String): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
//    function fBaseProduto(strCodBas, strCodUni: String): String;
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

{ TGravandoExecucaoQualyVinilNovasFormulas }

constructor TGravandoExecucaoQualyVinilNovasFormulas.Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
  const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoQualyVinilNovasFormulas.Executar(const gravando: IGravando);
//const
//  arrUnidades: array[0..2] of string = ('LT', 'GL', 'LA');
//  arrPesos: array[0..2] of Double = (1, 4, 20);
var
  qryCadNfm          : IDataSet;
  qryCadQUA          : IDataSet;
  qryBases           : IDataSet;
  qryVolumeEspecifico: IDataSet;
  intCont            : Integer;
//  intUnidade         : Integer;
  strMd5             : String;
begin

  Try
    Try

      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM QUA_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadQUA := TAutcomTintaFactory.Get.fGetDataSet;
      qryVolumeEspecifico := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('QUA_CADQUA');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_CODUNI              ' +
                        '   FROM QUA_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_PRODUT LIKE :PRODUT ' +
                        '    AND BAS_CODBAS = :CODBAS    ';

        If Not blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI = :CODUNI ';

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI <> :CODUNI ';

        //Geracao do cadastro de novas formulas
        If TStrUtils.fEmptyStr(strCodNfm) Then
           qryBases.SQL := qryBases.SQL + fGetUnidadesGeracaoCadNfm(qryCadNfm.FieldByName('NFM_CODUNI').AsString);

        qryBases.ParamByName('PRODUT').AsString := '%' + qryCadNfm.FieldByName('NFM_PRODUT').AsString + '%';
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_CODUNI').AsString;

        If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        Try
          Try
            begin
              qryBases.First;
              While Not qryBases.Eof Do
              Begin
                qryCadQUA.SQL := TAutcomTintaFactory.Get.GetInsert('QUA_CADQUA');

                qryCadQUA.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('QUA_CADQUA',TAutcomTintaFactory.Get.GetCodEmp);
                qryCadQUA.ParamByName('QUA_CODITE').AsString   := '';
                qryCadQUA.ParamByName('QUA_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
                qryCadQUA.ParamByName('QUA_DESCRI').AsString   := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
                qryCadQUA.ParamByName('QUA_PRODUT').AsString   := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
                qryCadQUA.ParamByName('QUA_CODUNI').AsString   := qryBases.FieldByName('BAS_CODUNI').AsString; //arrUnidades[intUnidade];
                qryCadQUA.ParamByName('QUA_CODBAS').AsString   := qryCadNfm.FieldByName('NFM_BASE__').AsString;
                qryCadQUA.ParamByName('QUA_NOMCOR').AsString   := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
                qryCadQUA.ParamByName('QUA_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
                qryCadQUA.ParamByName('QUA_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
                qryCadQUA.ParamByName('QUA_ACRMOB').AsFloat    := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

                for intCont := 1 to 20 do
                begin
                  if TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) then
                    Break;

                  if qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 then
                    Break;

                  qryCadQUA.ParamByName('QUA_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

                  qryCadQUA.ParamByName('QUA_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                    qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fRetPesoUnidade(qryBases.FieldByName('BAS_CODUNI').AsString, qryBases.RecordCount, qryCadNfm.FieldByName('NFM_CODUNI').AsString); //arrPesos[intUnidade];
                end;

                strMd5 := '';

                strMd5 := strMd5 + qryCadQUA.ParamByName('QUA_CODBAS').AsString;
                strMd5 := strMd5 + qryCadQUA.ParamByName('QUA_PRODUT').AsString;
                strMd5 := strMd5 + qryCadQUA.ParamByName('QUA_DESCRI').AsString;
                strMd5 := strMd5 + qryCadQUA.ParamByName('QUA_NOMCOR').AsString;
                strMd5 := strMd5 + qryCadQUA.ParamByName('QUA_CODUNI').AsString;

                For intCont := 1 to 20 do
                begin
                  strMd5 := strMd5 + qryCadQUA.ParamByName('QUA_FORM' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsString;
                  strMd5 := strMd5 + StringReplace(FormatFloat('0.0000', qryCadQUA.ParamByName('QUA_QTDB' + TStrUtils.fStrZero(IntToStr(intCont), 2)).AsFloat),
                    ',', '.', [rfReplaceAll]);
                end;

                qryCadQUA.ParamByName('QUA_MD5KEY').AsString := GetMD5(strMd5);

                qryCadQUA.ExecSQL;

                if not (blnGerarUnidades) then
                  Break;

                qryBases.Next;
              End;
            end;
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

{function TGravandoExecucaoQualyVinilNovasFormulas.fBaseProduto(strCodBas,
  strCodUni: String): String;
var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT BAS_DESCRI ' +
                  '   FROM QUA_CADBAS ' +
                  '  WHERE BAS_CODBAS = :CODBAS ' +
                  '    AND BAS_CODUNI = :CODUNI ';

    qryGen.ParamByName('CODBAS').AsString := strCodBas;
    qryGen.ParamByName('CODUNI').AsString := strCodUni;
    qryGen.Open;

    Result := qryGen.FieldByName('BAS_DESCRI').AsString;
  Except
    on E: Exception do
    begin
      raise;
    end;
  End;
end;
 }
function TGravandoExecucaoQualyVinilNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoQualyVinilNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","LA") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_CODUNI = "LA" ';
end;


function TGravandoExecucaoQualyVinilNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoQualyVinilNovasFormulas.fRetPesoUnidade(
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
    If strCodUni = 'LT' Then
      Result := 1
    Else If (strCodUni = 'GL') And (strUniOri = 'GL') Then
      Result := 1
    Else If strCodUni = 'GL' Then
      Result := 4
    Else If (strCodUni = 'LA') And (strUniOri = 'LT') Then
      Result := 20
    Else If strCodUni = 'LA' Then
      Result := 5;
  End;
end;

procedure TGravandoExecucaoQualyVinilNovasFormulas.RemoverNovasFormulas;
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
          '   QUA_CADQUA                  ' +
          ' WHERE LEFT(QUA_NOMCOR, 12) IN ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     QUA_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   QUA_CADQUA                           ' +
          ' WHERE LEFT(QUA_NOMCOR, 12) IN          ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     QUA_CADNFM                         ' +
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
