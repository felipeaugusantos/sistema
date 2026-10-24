{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta AlvAutomotiva *}
{*******************************************************************************PH*}
unit untGravandoExecucaoAlvAutomotivaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoAlvAutomotivaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoAlvAutomotivaNovasFormulas }

constructor TGravandoExecucaoAlvAutomotivaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
end;

procedure TGravandoExecucaoAlvAutomotivaNovasFormulas.Executar(const gravando: IGravando);
Var
  intContador: Integer;
  qryCadAla, qryCadNfm: IDataSet;
  strMd5: String;
begin
  Try
    Try
      Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := '  SELECT * FROM ALA_CADNFM    ';


      If Not TStrUtils.fEmptyStr(strCodNfm) Then
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODIGO = '  + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();

      qryCadAla := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadAla.SQL :=  '   SELECT * FROM ALA_CADALA WHERE FALSE      ';
      qryCadAla.Open;


      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALA_CADALA');
      Gravando.Texto := 'PROCOD verificado com sucesso...';


      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Processando Novas Fórmulas...';

      While Not qryCadNfm.Eof Do
      Begin
        Begin
          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadAla.Insert;
          qryCadAla.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALA_CADALA', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadAla.FieldByName('ALA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadAla.FieldByName('ALA_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
          qryCadAla.FieldByName('ALA_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
          qryCadAla.FieldByName('ALA_SYSTEM').AsString := qryCadNfm.FieldByName('NFM_SYSTEM').AsString;
          qryCadAla.FieldByName('ALA_TONALI').AsString := qryCadNfm.FieldByName('NFM_TONALI').AsString;
          qryCadAla.FieldByName('ALA_TECNOL').AsString := qryCadNfm.FieldByName('NFM_TECNOL').AsString;
          qryCadAla.FieldByName('ALA_ANOCOR').AsString := qryCadNfm.FieldByName('NFM_ANOCOR').AsString;
          qryCadAla.FieldByName('ALA_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
          qryCadAla.FieldByName('ALA_PROCHA').AsString := qryCadNfm.FieldByName('NFM_PROCHA').AsString;
          qryCadAla.FieldByName('ALA_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
          qryCadAla.FieldByName('ALA_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;

          strMd5 := qryCadAla.FieldByName('ALA_CODIGO').AsString +
                    qryCadAla.FieldByName('ALA_DESCRI').AsString +
                    qryCadAla.FieldByName('ALA_SYSTEM').AsString +
                    qryCadAla.FieldByName('ALA_TONALI').AsString +
                    qryCadAla.FieldByName('ALA_TECNOL').AsString +
                    qryCadAla.FieldByName('ALA_ANOCOR').AsString;

          For intContador := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
              Break;

            qryCadAla.FieldByName('ALA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString);
            qryCadAla.FieldByName('ALA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

            strMd5 := strMd5 +  qryCadAla.FieldByName('ALA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
            strMd5 := strMd5 +  qryCadAla.FieldByName('ALA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsString;
          End;

          qryCadAla.FieldByName('ALA_MD5KEY').AsString := GetMD5(strMd5);
          qryCadAla.Post;
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

function TGravandoExecucaoAlvAutomotivaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoAlvAutomotivaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoAlvAutomotivaNovasFormulas.RemoverNovasFormulas;
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
          '   ALA_CADALA                  ' +
          ' WHERE ALA_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODIGO                ' +
          '   FROM                        ' +
          '     ALA_CADNFM)               ';
      End
      Else
      Begin
        qryGen.SQL :=
          ' DELETE ALA_CADALA                      ' +
          ' FROM                                   ' +
          '   ALA_CADALA JOIN ALA_CADNFM ON ALA_CADNFM.NFM_CODIGO = ALA_CADALA.ALA_CODIGO    ' +
          '   WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);
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
