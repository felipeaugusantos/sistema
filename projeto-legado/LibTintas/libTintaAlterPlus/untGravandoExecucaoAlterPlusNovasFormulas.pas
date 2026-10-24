{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta AlterPlus *}
{*******************************************************************************PH*}
unit untGravandoExecucaoAlterPlusNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoAlterPlusNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    procedure RemoverNovasFormulas();
//    function fBaseProduto(strCodBas, strCodUni: String): String;
    function fRetPesoUnidade(fltBasEmb: Double; fltBasNfm: Double): Double;
    function fGetUnidadesGeracaoCadNfm(strUnidade: String): String;
    function fGerarUnidadesSQL(blnGerarUnidades: Boolean): String;
    function fGerarUnidadeSQL(blnGerarUnidades: Boolean; strUnidadeMenor: String; blnAtualizar: Boolean): String;
    function fGeraUnidade(blnGerarUnidades: Boolean; strUnidadeMenor: String; blnAtualizar: Boolean): Boolean;
    function fGeraTodasUnidades(strCodNfm: String; strUnidade: String): String;
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

{ TGravandoExecucaoAlterPlusNovasFormulas }

constructor TGravandoExecucaoAlterPlusNovasFormulas.Create(
  const strCodNfm: string = ''; blnGerarUnidades : Boolean = True;
  const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
  Self.blnGerarUnidades := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor := strUnidadeMenor;
end;

procedure TGravandoExecucaoAlterPlusNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm          : IDataSet;
  qryCadALP          : IDataSet;
  qryBases           : IDataSet;
  intCont            : Integer;
  strMd5             : String;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM ALP_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadALP := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALP_CADALP');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      While (Not qryCadNfm.Eof) Do
      begin

        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT BAS_CODUNI,             ' +
                        '        BAS_EMBALA              ' +
                        '   FROM ALP_CADBAS              ' +
                        '  INNER JOIN CADITE             ' +
                        '     ON ITE_CODITE = BAS_CODITE ' +
                        '  WHERE BAS_PRODUT = :PRODUT    ' +
                        '    AND BAS_CODBAS = :CODBAS    ';

        qryBases.SQL := qryBases.SQL + fGerarUnidadesSQL(blnGerarUnidades);
        qryBases.SQL := qryBases.SQL + fGerarUnidadeSQL(blnGerarUnidades, strUnidadeMenor, blnAtualizarUnidade);
        qryBases.SQL := qryBases.SQL + fGeraTodasUnidades(strCodNfm, qryCadNfm.FieldByName('NFM_CODUNI').AsString);

        qryBases.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryBases.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;

        If Not blnGerarUnidades Then
          qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_CODUNI').AsString;

        If fGeraUnidade(blnGerarUnidades, strUnidadeMenor, blnAtualizarUnidade) Then
          qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

        qryBases.Open;

        qryBases.First;
        While Not qryBases.Eof Do
        Begin
          Try
            qryCadALP.SQL := 'SELECT * FROM ALP_CADALP WHERE FALSE';
            qryCadALP.Open;

            qryCadALP.Insert;
            qryCadALP.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALP_CADALP',TAutcomTintaFactory.Get.GetCodEmp);
            qryCadALP.FieldByName('ALP_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadALP.FieldByName('ALP_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
            qryCadALP.FieldByName('ALP_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
            qryCadALP.FieldByName('ALP_COLECA').AsString := 'PERSONALIZADAS';
            qryCadALP.FieldByName('ALP_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
            qryCadALP.FieldByName('ALP_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
            qryCadALP.FieldByName('ALP_CODUNI').AsString := qryBases.FieldByName('BAS_CODUNI').AsString;
            qryCadALP.FieldByName('ALP_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
            qryCadALP.FieldByName('ALP_REFERE').AsString := qryCadNfm.FieldByName('NFM_REFERE').AsString;
            qryCadALP.FieldByName('ALP_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
            qryCadALP.FieldByName('ALP_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

            for intCont := 1 to 20 do
            begin
              qryCadALP.FieldByName('ALP_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString);

              qryCadALP.FieldByName('ALP_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
                qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * fRetPesoUnidade(qryBases.FieldByName('BAS_EMBALA').AsFloat,
                                                                                                             qryCadNfm.FieldByName('NFM_VOLUME').AsFloat);
            end;

            strMd5 := '';
            strMd5 := (qryCadALP.FieldByName('ALP_CODEMP').AsString +
                       qryCadALP.FieldByName('ALP_CODIGO').AsString +
                       qryCadALP.FieldByName('ALP_DTACAD').AsString +
                       qryCadALP.FieldByName('ALP_COLECA').AsString +
                       qryCadALP.FieldByName('ALP_PRODUT').AsString +
                       qryCadALP.FieldByName('ALP_CODBAS').AsString +
                       qryCadALP.FieldByName('ALP_CODUNI').AsString +
                       qryCadALP.FieldByName('ALP_DESCRI').AsString);

            qryCadALP.FieldByName('ALP_MD5KEY').AsString := GetMD5(strMd5);

            qryCadALP.Post;
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

function TGravandoExecucaoAlterPlusNovasFormulas.fGerarUnidadeSQL(
  blnGerarUnidades: Boolean; strUnidadeMenor: String;
  blnAtualizar: Boolean): String;
begin
  Result := '';

  If Not blnAtualizar Then
  Begin
    If Not TStrUtils.fEmptyStr(strUnidadeMenor) Then
    Begin
      If blnGerarUnidades Then
        Result := ' AND BAS_CODUNI <> :CODUNI ';
    End;
  End;
end;

function TGravandoExecucaoAlterPlusNovasFormulas.fGerarUnidadesSQL(
  blnGerarUnidades: Boolean): String;
begin
  Result := '';

  If Not blnGerarUnidades Then
    Result := ' AND BAS_CODUNI = :CODUNI  ';
end;

function TGravandoExecucaoAlterPlusNovasFormulas.fGeraTodasUnidades(strCodNfm,
  strUnidade: String): String;
begin
  Result := '';

  If Not TStrUtils.fEmptyStr(strCodNfm) Then
    Result := fGetUnidadesGeracaoCadNfm(strUnidade);
end;

function TGravandoExecucaoAlterPlusNovasFormulas.fGeraUnidade(
  blnGerarUnidades: Boolean; strUnidadeMenor: String;
  blnAtualizar: Boolean): Boolean;
begin
  Result := False;

  If Not blnAtualizar Then
  Begin
    If Not TStrUtils.fEmptyStr(strUnidadeMenor) Then
    Begin
      If blnGerarUnidades Then
        Result := True;
    End;
  End;
end;

function TGravandoExecucaoAlterPlusNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoAlterPlusNovasFormulas.fGetUnidadesGeracaoCadNfm(
  strUnidade: String): String;
begin
  Result := '';
  If strUnidade = 'GL' Then
    Result := ' AND BAS_CODUNI IN ("GL","LA", "BD") '
  Else If strUnidade = 'LA' Then
    Result := ' AND BAS_CODUNI IN ("LA", "BD") '
  Else If strUnidade = 'BD' Then
    Result := ' AND BAS_CODUNI = "BD"   ';
end;



function TGravandoExecucaoAlterPlusNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoAlterPlusNovasFormulas.fRetPesoUnidade(fltBasEmb: Double; fltBasNfm: Double): Double;
begin
  Result := fltBasEmb / fltBasNfm;
end;

procedure TGravandoExecucaoAlterPlusNovasFormulas.RemoverNovasFormulas;
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
          '   ALP_CADALP        ' +
          ' WHERE ALP_CODIGO IN ' +
          '   (SELECT           ' +
          '     NFM_CODNFM      ' +
          '   FROM              ' +
          '     ALP_CADNFM)     ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE              ' +
          ' FROM                ' +
          '   ALP_CADALP        ' +
          ' WHERE ALP_CODIGO IN ' +
          '   (SELECT           ' +
          '     NFM_CODNFM      ' +
          '   FROM              ' +
          '     ALP_CADNFM      ' +
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
