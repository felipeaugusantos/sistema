{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Lechler *}
{*******************************************************************************PH*}
unit untGravandoExecucaoLechlerNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoLechlerNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoLechlerNovasFormulas }

constructor TGravandoExecucaoLechlerNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
end;

procedure TGravandoExecucaoLechlerNovasFormulas.Executar(const gravando: IGravando);
Var
  intContador: Integer;
  qryCadLec, qryCadNfm: IDataSet;
  strMd5Key: String;
  fltQtdTotal: Double;
begin
  Try
    Try
      Gravando.Texto := 'Carregando dados do Cadastro de Novas Fórmulas...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      qryCadLec := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;

      qryCadNfm.SQL := '  SELECT * FROM LEC_CADNFM    ';
      qryCadLec.SQL := '  DELETE FROM LEC_CADLEC      ';


      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODNFM = '  + QuotedStr(strCodNfm);
        qryCadLec.SQL := qryCadLec.SQL + '  WHERE LEC_CODNFM = '  + QuotedStr(strCodNfm);
      End
      Else
      Begin
        qryCadLec.SQL := qryCadLec.SQL + '  WHERE LEC_CODNFM LIKE  ''%ESP%''  ';
      End;

      qryCadNfm.Open;
      qryCadLec.ExecSQL;

      qryCadLec.SQL.Empty;
      qryCadLec.SQL :=  '   SELECT * FROM LEC_CADLEC      ';
      qryCadLec.Open;


      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('LEC_CADLEC');
      Gravando.Texto := 'PROCOD verificado com sucesso...';


      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Processando Novas Fórmulas...';

      While Not qryCadNfm.Eof Do
      Begin
        Begin

          strMd5Key := '';
          fltQtdTotal := 0;

          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadLec.Insert;
          qryCadLec.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('LEC_CADLEC', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadLec.FieldByName('LEC_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadLec.FieldByName('LEC_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
          qryCadLec.FieldByName('LEC_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
          qryCadLec.FieldByName('LEC_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
          qryCadLec.FieldByName('LEC_DESCOR').AsString := qryCadNfm.FieldByName('NFM_DESCOR').AsString;
          qryCadLec.FieldByName('LEC_CODCOR').AsString := qryCadNfm.FieldByName('NFM_CODCOR').AsString;
          qryCadLec.FieldByName('LEC_EFECOR').AsString := qryCadNfm.FieldByName('NFM_EFECOR').AsString;
          qryCadLec.FieldByName('LEC_MASIND').AsString := qryCadNfm.FieldByName('NFM_MASIND').AsString;
          qryCadLec.FieldByName('LEC_ANOINI').AsString := qryCadNfm.FieldByName('NFM_ANOINI').AsString;
          qryCadLec.FieldByName('LEC_ANOFIN').AsString := qryCadNfm.FieldByName('NFM_ANOFIN').AsString;
          qryCadLec.FieldByName('LEC_FABRIC').AsString := qryCadNfm.FieldByName('NFM_FABRIC').AsString;
          qryCadLec.FieldByName('LEC_VARIAN').AsString := qryCadNfm.FieldByName('NFM_VARIAN').AsString;
          qryCadLec.FieldByName('LEC_CATALI').AsString := qryCadNfm.FieldByName('NFM_CATALI').AsString;
          qryCadLec.FieldByName('LEC_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
          qryCadLec.FieldByName('LEC_QTDB01').AsFloat  := qryCadNfm.FieldByName('NFM_QTDB01').AsFloat;

          strMd5Key := strMd5Key + qryCadLec.FieldByName('LEC_CODNFM').AsString;
          strMd5Key := strMd5Key + qryCadLec.FieldByName('LEC_CODBAS').AsString;
          strMd5Key := strMd5Key + qryCadLec.FieldByName('LEC_CODEMB').AsString;
          strMd5Key := strMd5Key + qryCadLec.FieldByName('LEC_FABRIC').AsString;
          strMd5Key := strMd5Key + qryCadLec.FieldByName('LEC_CODCOR').AsString;
          strMd5Key := strMd5Key + qryCadLec.FieldByName('LEC_DESCOR').AsString;
          strMd5Key := strMd5Key + qryCadLec.FieldByName('LEC_MASIND').AsString;
          strMd5Key := strMd5Key + qryCadLec.FieldByName('LEC_VARIAN').AsString;

          For intContador := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
              Break;

            qryCadLec.FieldByName('LEC_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);

            qryCadLec.FieldByName('LEC_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
              qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

            fltQtdTotal := fltQtdTotal + qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
          End;


          qryCadLec.FieldByName('LEC_QTDTOT').AsFloat := fltQtdTotal + qryCadLec.FieldByName('LEC_QTDB01').AsFloat;

          For intContador := 1 To 20 Do
          Begin

            If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
              Break;

            qryCadLec.FieldByName('LEC_PERC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
              (qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat / qryCadLec.FieldByName('LEC_QTDTOT').AsFloat) * 100;

          End;

          qryCadLec.FieldByName('LEC_PERB01').AsFloat := (qryCadNfm.FieldByName('NFM_QTDB01').AsFloat / qryCadLec.FieldByName('LEC_QTDTOT').AsFloat) * 100;
          qryCadLec.FieldByName('LEC_MD5KEY').AsString := GetMD5(strMd5Key);
          qryCadLec.FieldByName('LEC_ATIVAD').AsString := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
          qryCadLec.FieldByName('LEC_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;

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

function TGravandoExecucaoLechlerNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoLechlerNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

end.
