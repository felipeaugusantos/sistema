{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Killing *}
{*******************************************************************************PH*}
unit untGravandoExecucaoKillingNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, untIConfTinta;

type
  TGravandoExecucaoKillingNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm        : string;
    blnGerarUnidades : Boolean;
    blnAtualizarUnidade: Boolean;
    strUnidadeMenor: String;
    conf : IConfTinta;
    function fRetFatorUnidade(strUnidade, strUniOrigem:String; intRegistro:Integer): Double;
    function fRetEmbalagemUnidade(AUnidade: String): Double;
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

{ TGravandoExecucaoKillingNovasFormulas }

constructor TGravandoExecucaoKillingNovasFormulas.Create(const strCodNfm: string = ''; blnGerarUnidades : Boolean = true;
  const blnAtualizarUnidade: Boolean = False; const strUnidadeMenor: String = '');
begin
  inherited Create();
  Self.strCodNfm           := strCodNfm;
  Self.blnGerarUnidades    := blnGerarUnidades;
  Self.blnAtualizarUnidade := blnAtualizarUnidade;
  Self.strUnidadeMenor     := strUnidadeMenor;

  conf := TAutcomTintaFactory.Get.fGetConfTinta('KIL');
end;

procedure TGravandoExecucaoKillingNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm,
  qryBases,
  qryCadKil: IDataSet;
  intContador: Integer;
  fltFator: Double;
begin
  Try
    Try

      Gravando.Texto := 'Carregando Dados...';

      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadKil := TAutcomTintaFactory.Get.fGetDataSet;

      qryCadNfm.SQL := '      SELECT * FROM KILD_CADNFM       ';
      qryCadKil.SQL := '     DELETE FROM KILD_CADKIL      ';

      Gravando.Texto := 'Deletando Cadastro de Novas Fórmulas...';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODCOR = ' + QuotedStr(strCodNfm);
        qryCadKil.SQL := qryCadKil.SQL + ' WHERE KIL_CODCOR = ' + QuotedStr(strCodNfm);
        qryCadKil.ExecSQL;
      End
      Else
      Begin
        qryCadKil.SQL := qryCadKil.SQL + ' WHERE KIL_CODCOR LIKE ''%ESP%'' ';
        qryCadKil.ExecSQL;
      End;

      qryCadKil.SQL.Empty;
      Gravando.Texto := 'Cadastro de Novas Fórmulas deletado...';
      qryCadKil.SQL := '    SELECT * FROM KILD_CADKIL     ';
      qryCadKil.SQL := qryCadKil.SQL + '    WHERE FALSE   ';
      qryCadKil.Open;
      qryCadNfm.Open;

      Gravando.Texto := 'Dados carregados com sucesso...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('KILD_CADKIL');
      Gravando.Texto := 'PROCOD verificado com sucesso...';




      Try
        While Not qryCadNfm.Eof Do
        Begin
          qryBases := TAutcomTintaFactory.Get.fGetDataSet;
          qryBases.SQL := '   SELECT *   ' +
                          '   FROM KILD_CADBAS  ' +
                          '   INNER JOIN CADITE ON' +
                          '     ITE_CODITE = BAS_CODITE' +
                          '     WHERE BAS_CODFML = :FORM  ' +
                          '     AND BAS_CODBAS = :BASE    ' +
                          '   ORDER BY BAS_EMBALA         ';

          If Not blnGerarUnidades Then
            qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI = :CODUNI ';

          If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
            qryBases.SQL := qryBases.SQL + ' AND BAS_CODUNI <> :CODUNI ';

          qryBases.ParamByName('FORM').AsString := qryCadNfm.FieldByName('NFM_CODFML').AsString;
          qryBases.ParamByName('BASE').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;

          If Not blnGerarUnidades Then
            qryBases.ParamByName('CODUNI').AsString := qryCadNfm.FieldByName('NFM_CODUNI').AsString;

          If (Not blnAtualizarUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) And blnGerarUnidades Then
            qryBases.ParamByName('CODUNI').AsString := strUnidadeMenor;

          qryBases.Open;
          Gravando.RegistrarProgresso(0, 0, 0);
          qryBases.First;

          While Not qryBases.Eof Do
          Begin
            qryCadKil.Insert;

            qryCadKil.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('KILD_CADKIL', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadKil.FieldByName('KIL_CODCOR').AsString := qryCadNfm.FieldByName('NFM_CODCOR').AsString;
            qryCadKil.FieldByName('KIL_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
            qryCadKil.FieldByName('KIL_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
            qryCadKil.FieldByName('KIL_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
            qryCadKil.FieldByName('KIL_REFERE').AsString := qryCadNfm.FieldByName('NFM_REFERE').AsString;
            qryCadKil.FieldByName('KIL_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
            qryCadKil.FieldByName('KIL_CODFML').AsString := qryCadNfm.FieldByName('NFM_CODFML').AsString;
            qryCadKil.FieldByName('KIL_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
            qryCadKil.FieldByName('KIL_CODUNI').AsString := qryBases.FieldByName('BAS_CODUNI').AsString;
            qryCadKil.FieldByName('KIL_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

            fltFator := fRetFatorUnidade(qryBases.FieldByName('BAS_CODUNI').AsString, qryCadNfm.FieldByName('NFM_CODUNI').AsString, qryBases.RecordCount);

            For intContador := 1 To 20 Do
            Begin

              If (TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
                Break;

              qryCadKil.FieldByName('KIL_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);

              If Conf.fGet('TIPDOS') <> '1' Then //Shot 48
              qryCadKil.FieldByName('KIL_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
                qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fltFator
              Else //Shot 192
                qryCadKil.FieldByName('KIL_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
                  (qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fltFator) / 4;
            End;

            qryCadKil.FieldByName('KIL_CODNFM').AsString := qryCadKil.FieldByName('KIL_CODCOR').AsString;
            qryCadKil.FieldByName('KIL_MD5KEY').AsString := GetMD5(qryCadKil.FieldByName('KIL_CODCOR').AsString +
                                                                   qryCadKil.FieldByName('KIL_DESCRI').AsString +
                                                                   qryCadKil.FieldByName('KIL_REFERE').AsString +
                                                                   qryCadKil.FieldByName('KIL_CODFML').AsString +
                                                                   qryCadKil.FieldByName('KIL_CODBAS').AsString +
                                                                   qryCadKil.FieldByName('KIL_CODUNI').AsString);

            qryCadKil.Post;

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
    Gravando.Texto :=  'Cadastro de Novas Fórmulas finalizado com sucesso...';
  End;
end;

function TGravandoExecucaoKillingNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;



function TGravandoExecucaoKillingNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoKillingNovasFormulas.fRetEmbalagemUnidade(
  AUnidade: String): Double;
begin
  Result := 810;

  If AUnidade = 'AMO' Then
    Result := 202
  Else If AUnidade = 'GM' Then
    Result := 3240
  Else If AUnidade = 'GP' Then
    Result := 2950
  Else If  AUnidade = 'L18.' Then
    Result := 14000
  Else If AUnidade = 'K18' Then
    Result := 14750
  Else If Pos(AUnidade, 'L18_M18_P18_H18_') > 0 Then
    Result := 16200;
end;

function TGravandoExecucaoKillingNovasFormulas.fRetFatorUnidade(strUnidade,
  strUniOrigem: String; intRegistro: Integer): Double;
begin
  Result := fRetEmbalagemUnidade(strUnidade) / fRetEmbalagemUnidade(strUniOrigem);
end;


end.
