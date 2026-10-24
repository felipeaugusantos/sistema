{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Dupont *}
{********************************************************************************AC*}
unit untGravandoExecucaoDupontNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, DateUtils, strUtils;

type
  TGravandoExecucaoDupontNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
    function fRetProCodSeq: Integer;
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoDupontNovasFormulas }

constructor TGravandoExecucaoDupontNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoDupontNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm  : IDataSet;
  qryCadDup  : IDataSet;
  intCont    : Integer;
  intCodSeq  : Integer;
  intContador: Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM DUP_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DUP_CADDUP');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryCadDup := TAutcomTintaFactory.Get.fGetDataSet;

      intCodSeq := fRetProCodSeq;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        qryCadDup.SQL := TAutcomTintaFactory.Get.GetInsert('DUP_CADDUP');

        qryCadDup.ParamByName('DUP_CODSEQ').AsString  := TStrUtils.fStrZero(intCodSeq,6);
        qryCadDup.ParamByName('DUP_CODDUP').AsString  := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadDup.ParamByName('DUP_CODNFM').AsString  := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadDup.ParamByName('DUP_CODOEM').AsString  := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadDup.ParamByName('DUP_LINHA_').AsString  := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
        qryCadDup.ParamByName('DUP_QUALID').AsString  := qryCadNfm.FieldByName('NFM_QUALID').AsString;
        qryCadDup.ParamByName('DUP_ALTERN').AsString  := qryCadNfm.FieldByName('NFM_ALTERN').AsString;
        qryCadDup.ParamByName('DUP_DTACAD').AsDateTime:= qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
        qryCadDup.ParamByName('DUP_REGIAO').AsString  := '';
        qryCadDup.ParamByName('DUP_DESCRI').AsString  := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryCadDup.ParamByName('DUP_MONTAD').AsString  := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
        qryCadDup.ParamByName('DUP_ANOCOR').AsString  := IntToStr(YearOf(qryCadNfm.FieldByName('NFM_DTACAD').AsDate));
        qryCadDup.ParamByName('DUP_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadDup.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('DUP_CADDUP', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadDup.ParamByName('DUP_PROCHA').AsString  := qryCadNfm.FieldByName('NFM_PROCHA').AsString;
        qryCadDup.ParamByName('DUP_LITRAG').AsFloat   := 900;
        qryCadDup.ParamByName('DUP_ATIVO_').AsString  := qryCadNfm.FieldByName('NFM_ATIVO_').AsString;
        qryCadDup.ParamByName('DUP_CATALI').AsString  := qryCadNfm.FieldByName('NFM_CATALI').AsString;
        qryCadDup.ParamByName('DUP_ACRMOB').AsFloat   := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
        intContador := 1;

        For intCont := 1 To 20 Do
        Begin
          If (TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
          Begin
            Break;
          End;

          qryCadDup.ParamByName('DUP_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString);
          qryCadDup.ParamByName('DUP_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
          qryCadDup.ParamByName('DUP_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
          qryCadDup.ParamByName('DUP_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString := 'B';

          Inc(intContador);
        End;

        qryCadDup.ParamByName('DUP_MD5KEY').AsString := GetMD5(qryCadDup.ParamByName('DUP_CODDUP').AsString + qryCadDup.ParamByName('DUP_CODOEM').AsString +
                                                               qryCadDup.ParamByName('DUP_LINHA_').AsString + qryCadDup.ParamByName('DUP_QUALID').AsString +
                                                               qryCadDup.ParamByName('DUP_ALTERN').AsString + qryCadDup.ParamByName('DUP_REGIAO').AsString +
                                                               qryCadDup.ParamByName('DUP_DESCRI').AsString + qryCadDup.ParamByName('DUP_MONTAD').AsString +
                                                               qryCadDup.ParamByName('DUP_ANOCOR').AsString +
                                      qryCadDup.ParamByName('DUP_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC01').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD01').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB01').AsString +
                                      qryCadDup.ParamByName('DUP_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC02').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD02').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB02').AsString +
                                      qryCadDup.ParamByName('DUP_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC03').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD03').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB03').AsString +
                                      qryCadDup.ParamByName('DUP_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC04').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD04').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB04').AsString +
                                      qryCadDup.ParamByName('DUP_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC05').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD05').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB05').AsString +
                                      qryCadDup.ParamByName('DUP_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC06').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD06').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB06').AsString +
                                      qryCadDup.ParamByName('DUP_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC07').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD07').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB07').AsString +
                                      qryCadDup.ParamByName('DUP_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC08').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD08').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB08').AsString +
                                      qryCadDup.ParamByName('DUP_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC09').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD09').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB09').AsString +
                                      qryCadDup.ParamByName('DUP_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC10').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD10').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB10').AsString +
                                      qryCadDup.ParamByName('DUP_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC11').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD11').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB11').AsString +
                                      qryCadDup.ParamByName('DUP_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC12').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD12').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB12').AsString +
                                      qryCadDup.ParamByName('DUP_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC13').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD13').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB13').AsString +
                                      qryCadDup.ParamByName('DUP_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC14').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD14').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB14').AsString +
                                      qryCadDup.ParamByName('DUP_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC15').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD15').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB15').AsString +
                                      qryCadDup.ParamByName('DUP_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC16').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD16').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB16').AsString +
                                      qryCadDup.ParamByName('DUP_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC17').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD17').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB17').AsString +
                                      qryCadDup.ParamByName('DUP_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC18').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD18').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB18').AsString +
                                      qryCadDup.ParamByName('DUP_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC19').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD19').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB19').AsString +
                                      qryCadDup.ParamByName('DUP_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDC20').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCadDup.ParamByName('DUP_QTDD20').AsFloat), ',', '.') + qryCadDup.ParamByName('DUP_TIPB20').AsString);

        If (Not TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODCAT').AsString)) Then
        Begin
          qryCadDup.ParamByName('DUP_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadNfm.FieldByName('NFM_CODCAT').AsString;
          qryCadDup.ParamByName('DUP_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := 0.0;
          qryCadDup.ParamByName('DUP_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDCAT').AsFloat;
          qryCadDup.ParamByName('DUP_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString := 'C';
          Inc(intContador);
        End;

        If (Not TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODDIL').AsString)) Then
        Begin
          qryCadDup.ParamByName('DUP_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadNfm.FieldByName('NFM_CODDIL').AsString;
          qryCadDup.ParamByName('DUP_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := 0.0;
          qryCadDup.ParamByName('DUP_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDDIL').AsFloat;
          qryCadDup.ParamByName('DUP_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString := 'D';
        End;

        qryCadDup.ExecSQL;

        gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);

        qryCadNfm.Next;

        Inc(intCodSeq);
      end;
    Except
      on E: Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoDupontNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoDupontNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoDupontNovasFormulas.fRetProCodSeq: Integer;
  Var
    qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT IFNULL(MAX(DUP_CODSEQ),0) + 1 PROX FROM DUP_CADDUP;';
  qryGen.Open;

  Result := qryGen.FieldByName('PROX').AsInteger;
end;

procedure TGravandoExecucaoDupontNovasFormulas.RemoverNovasFormulas;
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
          '   DUP_CADDUP                  ' +
          ' WHERE DUP_CODNFM IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     DUP_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   DUP_CADDUP                           ' +
          ' WHERE DUP_CODNFM IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     DUP_CADNFM                         ' +
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
