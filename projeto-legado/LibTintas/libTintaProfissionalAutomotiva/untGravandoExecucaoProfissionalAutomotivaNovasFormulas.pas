{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta ProfissionalAutomotiva *}
{*******************************************************************************PH*}
unit untGravandoExecucaoProfissionalAutomotivaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoProfissionalAutomotivaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoProfissionalAutomotivaNovasFormulas }

constructor TGravandoExecucaoProfissionalAutomotivaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
end;

procedure TGravandoExecucaoProfissionalAutomotivaNovasFormulas.Executar(const gravando: IGravando);
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
      qryCadNfm.SQL := '  SELECT * FROM PFA_CADNFM    ';


      If Not TStrUtils.fEmptyStr(strCodNfm) Then
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODNFM = '  + QuotedStr(strCodNfm);

      qryCadNfm.Open;
      RemoverNovasFormulas();

      qryCadLec := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadLec.SQL :=  '   SELECT * FROM PFA_CADPFA WHERE FALSE      ';
      qryCadLec.Open;


      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('PFA_CADPFA');
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
          qryCadLec.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PFA_CADPFA', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadLec.FieldByName('PFA_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadLec.FieldByName('PFA_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
          qryCadLec.FieldByName('PFA_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
          qryCadLec.FieldByName('PFA_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
          qryCadLec.FieldByName('PFA_A_N_O_').AsString := qryCadNfm.FieldByName('NFM_A_N_O_').AsString;
          qryCadLec.FieldByName('PFA_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
          qryCadLec.FieldByName('PFA_PROCHA').AsString := qryCadNfm.FieldByName('NFM_PROCHA').AsString;
          qryCadLec.FieldByName('PFA_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
          qryCadLec.FieldByName('PFA_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;

          strMd5 := qryCadLec.FieldByName('PFA_CODIGO').AsString +
                    qryCadLec.FieldByName('PFA_DESCRI').AsString +
                    qryCadLec.FieldByName('PFA_NOMCOR').AsString +
                    qryCadLec.FieldByName('PFA_A_N_O_').AsString;

          For intContador := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
              Break;

            qryCadLec.FieldByName('PFA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString);
            qryCadLec.FieldByName('PFA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

            strMd5 := strMd5 +  qryCadLec.FieldByName('PFA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
            strMd5 := strMd5 +  qryCadLec.FieldByName('PFA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsString;
          End;

          qryCadLec.FieldByName('PFA_MD5KEY').AsString := GetMD5(strMd5);
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

function TGravandoExecucaoProfissionalAutomotivaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoProfissionalAutomotivaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoProfissionalAutomotivaNovasFormulas.RemoverNovasFormulas;
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
          '   PFA_CADPFA                  ' +
          ' WHERE PFA_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     PFA_CADNFM)               ';
      End
      Else
      Begin
        qryGen.SQL :=
          ' DELETE PFA_CADPFA                      ' +
          ' FROM                                   ' +
          '   PFA_CADPFA JOIN PFA_CADNFM ON PFA_CADNFM.NFM_CODNFM = PFA_CADPFA.PFA_CODIGO    ' +
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
