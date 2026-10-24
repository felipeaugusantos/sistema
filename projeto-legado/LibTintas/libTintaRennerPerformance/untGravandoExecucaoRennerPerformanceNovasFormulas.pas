{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta RennerPerformance *}
{*******************************************************************************PH*}
unit untGravandoExecucaoRennerPerformanceNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoRennerPerformanceNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoRennerPerformanceNovasFormulas }

constructor TGravandoExecucaoRennerPerformanceNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
end;

procedure TGravandoExecucaoRennerPerformanceNovasFormulas.Executar(const gravando: IGravando);
Var
  intContador: Integer;
  qryCadREP, qryCadNfm: IDataSet;
  strMd5Key: String;
begin
  Try
    Try
      Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      qryCadREP := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;

      qryCadNfm.SQL := '  SELECT * FROM REP_CADNFM    ';
      qryCadREP.SQL := '  DELETE FROM REP_CADREP      ';


      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODIGO = '  + QuotedStr(strCodNfm);
        qryCadREP.SQL := qryCadREP.SQL + '  WHERE REP_CODIGO = '  + QuotedStr(strCodNfm);
      End
      Else
      Begin
        qryCadREP.SQL := qryCadREP.SQL + '  WHERE REP_CODIGO LIKE  ''%ESP%''  ';
      End;

      qryCadNfm.Open;
      qryCadREP.ExecSQL;

      qryCadREP.SQL.Empty;
      qryCadREP.SQL :=  '   SELECT * FROM REP_CADREP      ';
      qryCadREP.Open;


      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REP_CADREP');
      Gravando.Texto := 'PROCOD verificado com sucesso...';


      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Processando Novas Fórmulas...';

      While Not qryCadNfm.Eof Do
      Begin
        Begin
          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadREP.Insert;
          qryCadREP.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REP_CADREP', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadREP.FieldByName('REP_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadREP.FieldByName('REP_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
          qryCadREP.FieldByName('REP_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
          qryCadREP.FieldByName('REP_PADRAO').AsString := qryCadNfm.FieldByName('NFM_PADRAO').AsString;
          qryCadREP.FieldByName('REP_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
          qryCadREP.FieldByName('REP_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
          qryCadREP.FieldByName('REP_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
          qryCadREP.FieldByName('REP_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryCadREP.FieldByName('REP_QTDBAS').AsFloat  := qryCadNfm.FieldByName('NFM_QTDBAS').AsFloat;

          strMd5Key := '';
          strMd5Key := strMd5Key + qryCadREP.FieldByName('REP_CODIGO').AsString;
          strMd5Key := strMd5Key + qryCadREP.FieldByName('REP_NOMCOR').AsString;
          strMd5Key := strMd5Key + qryCadREP.FieldByName('REP_PADRAO').AsString;
          strMd5Key := strMd5Key + qryCadREP.FieldByName('REP_CODBAS').AsString;

          qryCadREP.FieldByName('REP_MD5KEY').AsString := GetMD5(strMd5Key);


          For intContador := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
              Break;

            qryCadREP.FieldByName('REP_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);
            qryCadREP.FieldByName('REP_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=  qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
          End;

          qryCadREP.Post;
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

function TGravandoExecucaoRennerPerformanceNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoRennerPerformanceNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

end.
