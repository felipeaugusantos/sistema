{***************************************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Salcomix *}
{***************************************************************************************************}
unit untGravandoExecucaoSalcomixNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, StrUtils, DateUtils;

type
  TGravandoExecucaoSalcomixNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoSalcomixNovasFormulas }

constructor TGravandoExecucaoSalcomixNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoSalcomixNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm : IDataSet;
  qryCadSal : IDataSet;
  intCont   : Integer;
  strMd5    : String;
  strBase   : String;
  strCodSeq : String;
begin
  Try
    Try
      Gravando.Texto := 'Carregando Dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadSal := TAutcomTintaFactory.Get.fGetDataSet;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      qryCadNfm.SQL := '  SELECT * FROM SAL_CADNFM    ';
      qryCadSal.SQL := '  DELETE FROM SAL_CADSAL      ';

      Gravando.Texto := 'Deletando Novas Fórmulas...';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);
        qryCadSal.SQL := qryCadSal.SQL + '  WHERE SAL_CODPRO = ' + QuotedStr(strCodNfm);
      End
      Else
      Begin
        qryCadSal.SQL := qryCadSal.SQL + '  WHERE SAL_CODPRO LIKE ''%ESP%'' ';
      End;

      qryCadNfm.Open;
      qryCadSal.ExecSQL;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SAL_CADSAL');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      qryCadSal.SQL.Empty;
      qryCadSal.SQL := '  SELECT * FROM SAL_CADSAL WHERE AUTOINCREM = -1  ';
      qryCadSal.Open;

      Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';

      While Not qryCadNfm.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        strCodSeq := TAutcomTintaFactory.Get.fRetAutoIncrem('SAL_CADSAL', TAutcomTintaFactory.Get.GetCodEmp);

        qryCadSal.Insert;
        qryCadSal.FieldByName('AUTOINCREM').AsString := strCodSeq;
        qryCadSal.FieldByName('SAL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadSal.FieldByName('SAL_CODSEQ').AsString := RightStr(LeftStr(strCodSeq, 17), 6);
        qryCadSal.FieldByName('SAL_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
        qryCadSal.FieldByName('SAL_MONTAD').AsString := 'GERAL';
        qryCadSal.FieldByName('SAL_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryCadSal.FieldByName('SAL_CODPRO').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadSal.FieldByName('SAL_ATIVO_').AsString := TAutcomTintaFactory.Get.IIF(TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_ATIVO_').AsString), 'S', qryCadNfm.FieldByName('NFM_ATIVO_').AsString);
        qryCadSal.FieldByName('SAL_ANOCOR').AsString := IntToStr(YearOf(qryCadNfm.FieldByName('NFM_DTACAD').AsDate));
        qryCadSal.FieldByName('SAL_VARIAC').AsString := '';
        qryCadSal.FieldByName('SAL_ACRMOB').AsFloat := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
        qryCadSal.FieldByName('SAL_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;

        For intCont := 1 To 20 Do
        Begin
          strBase := qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString;

          If TStrUtils.fEmptyStr(strBase) Then
            Break;

          If (strBase = 'E 057000') Then
            Continue;

          qryCadSal.FieldByName('SAL_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString := strBase;
          qryCadSal.FieldByName('SAL_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
          qryCadSal.FieldByName('SAL_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        qryCadSal.FieldByName('SAL_PRECUS').AsFloat := 0.0;
        qryCadSal.FieldByName('SAL_PREVEN').AsFloat := 0.0;

        strMd5 := '';
        strMd5 := strMd5 + qryCadSal.FieldByName('SAL_CODSEQ').AsString;
        strMd5 := strMd5 + qryCadSal.FieldByName('SAL_CODPRO').AsString;
        strMd5 := strMd5 + qryCadSal.FieldByName('SAL_LINHA_').AsString;
        strMd5 := strMd5 + qryCadSal.FieldByName('SAL_DESCRI').AsString;
        strMd5 := strMd5 + qryCadSal.FieldByName('SAL_MONTAD').AsString;
        strMd5 := strMd5 + qryCadSal.FieldByName('SAL_ANOCOR').AsString;
        strMd5 := strMd5 + qryCadSal.FieldByName('SAL_VARIAC').AsString;

        qryCadSal.FieldByName('SAL_MD5KEY').AsString := GetMD5(strMd5);
        qryCadSal.Post;

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

function TGravandoExecucaoSalcomixNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

end.
