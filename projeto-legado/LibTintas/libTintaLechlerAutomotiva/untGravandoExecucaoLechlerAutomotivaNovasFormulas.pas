{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta LechlerAutomotiva *}
{*******************************************************************************PH*}
unit untGravandoExecucaoLechlerAutomotivaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoLechlerAutomotivaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoLechlerAutomotivaNovasFormulas }

constructor TGravandoExecucaoLechlerAutomotivaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
end;

procedure TGravandoExecucaoLechlerAutomotivaNovasFormulas.Executar(const gravando: IGravando);
Var
  intContador: Integer;
  qryCadLec, qryCadNfm: IDataSet;
  strMd5: String;
begin
  Try
    Try
      Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := '  SELECT * FROM LCA_CADNFM    ';


      If Not TStrUtils.fEmptyStr(strCodNfm) Then
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODNFM = '  + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();

      qryCadLec := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadLec.SQL :=  '   SELECT * FROM LCA_CADLCA WHERE FALSE      ';
      qryCadLec.Open;


      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('LCA_CADLCA');
      Gravando.Texto := 'PROCOD verificado com sucesso...';


      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Processando Novas Fórmulas...';

      While Not qryCadNfm.Eof Do
      Begin
        Begin
          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadLec.Insert;
          qryCadLec.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LCA_CADLCA', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadLec.FieldByName('LCA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadLec.FieldByName('LCA_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
          qryCadLec.FieldByName('LCA_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
          qryCadLec.FieldByName('LCA_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
          qryCadLec.FieldByName('LCA_A_N_O_').AsString := qryCadNfm.FieldByName('NFM_A_N_O_').AsString;
          qryCadLec.FieldByName('LCA_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
          qryCadLec.FieldByName('LCA_PROCHA').AsString := qryCadNfm.FieldByName('NFM_PROCHA').AsString;
          qryCadLec.FieldByName('LCA_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
          qryCadLec.FieldByName('LCA_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;

          strMd5 := qryCadLec.FieldByName('LCA_CODIGO').AsString +
                    qryCadLec.FieldByName('LCA_DESCRI').AsString +
                    qryCadLec.FieldByName('LCA_NOMCOR').AsString +
                    qryCadLec.FieldByName('LCA_A_N_O_').AsString;

          For intContador := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
              Break;

            qryCadLec.FieldByName('LCA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString);
            qryCadLec.FieldByName('LCA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

            strMd5 := strMd5 +  qryCadLec.FieldByName('LCA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
            strMd5 := strMd5 +  qryCadLec.FieldByName('LCA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsString;
          End;

          qryCadLec.FieldByName('LCA_MD5KEY').AsString := GetMD5(strMd5);
          qryCadLec.Post;
        End;

        qryCadNfm.Next;
        Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally

  End;
end;

function TGravandoExecucaoLechlerAutomotivaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoLechlerAutomotivaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoLechlerAutomotivaNovasFormulas.RemoverNovasFormulas;
Var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      If TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryGen.SQL :=
          ' DELETE                        ' +
          ' FROM                          ' +
          '   LCA_CADLCA                  ' +
          ' WHERE LCA_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     LCA_CADNFM)               ';
      End
      Else
      Begin
        qryGen.SQL :=
          ' DELETE LCA_CADLCA                      ' +
          ' FROM                                   ' +
          '   LCA_CADLCA JOIN LCA_CADNFM ON LCA_CADNFM.NFM_CODNFM = LCA_CADLCA.LCA_CODIGO    ' +
          '   WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);
      End;

      qryGen.ExecSQL;
    Except
      On E: Exception Do
        Raise;
    End;
  Finally
  End;
end;

end.
