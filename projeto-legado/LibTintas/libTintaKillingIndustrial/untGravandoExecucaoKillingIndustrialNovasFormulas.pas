{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta KillingIndustrial *}
{********************************************************************************AC*}
unit untGravandoExecucaoKillingIndustrialNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoKillingIndustrialNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    function fRetornaDesMontadora(strCodMon: String): String;
    function fRetornaDesLinha(strCodLin: String): String;
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;

  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoKillingIndustrialNovasFormulas }

constructor TGravandoExecucaoKillingIndustrialNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;


procedure TGravandoExecucaoKillingIndustrialNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryCadKin: IDataSet;
  intCont: Integer;
begin
  Try
    Try
      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Excluindo registros de novas fórmulas da tabela KIN_CADKIN...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadKin := TAutcomTintaFactory.Get.fGetDataSet;

      qryCadNfm.SQL := '  SELECT * FROM KIN_CADNFM      ';
      qryCadKin.SQL := '  DELETE FROM KIN_CADKIN        ';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);
        qryCadKin.SQL := qryCadKin.SQL + '  WHERE KIN_CODIGO = ' + QuotedStr(strCodNfm);
      End
      Else
        qryCadKin.SQL := qryCadKin.SQL + '  WHERE KIN_CODIGO LIKE ''%ESP%''       ';

      qryCadKin.ExecSQL;
      qryCadNfm.Open;

      Gravando.Texto := 'Abrindo Cadastro de Novas Fórmulas...';
      qryCadKin.Close;
      qryCadKin.SQL := '  SELECT * FROM KIN_CADKIN WHERE FALSE    ';
      qryCadKin.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('KIN_CADKIN');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Processando Novas Fórmulas...';
      Gravando.RegistrarProgresso(0, 0, 0);

      While Not qryCadNfm.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryCadKin.Insert;
        qryCadKin.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('KIN_CADKIN', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadKin.FieldByName('KIN_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadKin.FieldByName('KIN_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
        qryCadKin.FieldByName('KIN_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
        qryCadKin.FieldByName('KIN_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryCadKin.FieldByName('KIN_SISTEM').AsString := qryCadNfm.FieldByName('NFM_SISTEM').AsString;
        qryCadKin.FieldByName('KIN_CODMON').AsString := qryCadNfm.FieldByName('NFM_CODMON').AsString;
        qryCadKin.FieldByName('KIN_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
        qryCadKin.FieldByName('KIN_DESMON').AsString := fRetornaDesMontadora(qryCadNfm.FieldByName('NFM_CODMON').AsString);
        qryCadKin.FieldByName('KIN_DESLIN').AsString := fRetornaDesLinha(qryCadNfm.FieldByName('NFM_LINHA_').AsString);
        qryCadKin.FieldByName('KIN_ANOCOR').AsString := qryCadNfm.FieldByName('NFM_ANOCOR').AsString;
        qryCadKin.FieldByName('KIN_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryCadKin.FieldByName('KIN_ATIVO_').AsString := qryCadNfm.FieldByName('NFM_ATIVO_').AsString;
        qryCadKin.FieldByName('KIN_DTACAD').AsDate := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
        qryCadKin.FieldByName('KIN_ACRMOB').AsFloat := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;


        For intCont := 1 To 20 Do
        Begin

          If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
            Break;

          If qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 Then
            Break;

          qryCadKin.FieldByName('KIN_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString);

          qryCadKin.FieldByName('KIN_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
            qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        qryCadKin.FieldByName('KIN_MD5KEY').AsString := GetMD5(qryCadKin.FieldByName('KIN_CODIGO').AsString +
                                                               qryCadKin.FieldByName('KIN_NOMCOR').AsString +
                                                               qryCadKin.FieldByName('KIN_PRODUT').AsString +
                                                               qryCadKin.FieldByName('KIN_SISTEM').AsString +
                                                               qryCadKin.FieldByName('KIN_ORIGEM').AsString);
        qryCadKin.Post;
        qryCadNfm.Next;
        Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally

  End;

  end;

function TGravandoExecucaoKillingIndustrialNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoKillingIndustrialNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoKillingIndustrialNovasFormulas.fRetornaDesLinha(
  strCodLin: String): String;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := '  SELECT             ' +
                  '    *                ' +
                  '  FROM               ' +
                  '    KIN_CADLIN       ' +
                  '  WHERE              ' +
                  '    LIN_CODIGO = :CODIGO     ';

    qryGen.ParamByName('CODIGO').AsString := strCodLin;
    qryGen.Open;

    Result := qryGen.FieldByName('LIN_DESCRI').AsString;
  Except
    Raise;
  End;
end;

function TGravandoExecucaoKillingIndustrialNovasFormulas.fRetornaDesMontadora(
  strCodMon: String): String;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := '   SELECT              ' +
                  '     *                 ' +
                  '   FROM                ' +
                  '     KIN_CADMON        ' +
                  '   WHERE               ' +
                  '     MON_CODMON = :CODMON      ';
    qryGen.ParamByName('CODMON').AsString := strCodMon;
    qryGen.Open;

    Result := qryGen.FieldByName('MON_DESCRI').AsString;
  Except
    Raise;
  End;
end;

end.
