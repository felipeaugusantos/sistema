{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Duxone2 *}
{********************************************************************************AC*}
unit untGravandoExecucaoDuxone2NovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, DateUtils, strUtils;

type
  TGravandoExecucaoDuxone2NovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
    function fRetProCodSeq: Integer;
    procedure fGerarTipoFormula(qryCadNfm, qryCores: IDataSet; strTipoFormula: String);
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoDuxone2NovasFormulas }

constructor TGravandoExecucaoDuxone2NovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoDuxone2NovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm  : IDataSet;
  qryCadDU2  : IDataSet;
  strTipFor: String;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM DU2_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DU2_CADDU2');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryCadDU2 := TAutcomTintaFactory.Get.fGetDataSet;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        If qryCadNfm.FieldByName('NFM_TIPFOR').AsString = 'Concentrado/Diluído' Then
          strTipFor := 'C/D'
        Else If qryCadNfm.FieldByName('NFM_TIPFOR').AsString = 'Concentrado' Then
          strTipFor := 'C'
        Else
          strTipFor := 'D';

        fGerarTipoFormula(qryCadNfm, qryCadDU2, strTipFor);

        gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);

        qryCadNfm.Next;
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

procedure TGravandoExecucaoDuxone2NovasFormulas.fGerarTipoFormula(qryCadNfm,
  qryCores: IDataSet; strTipoFormula: String);
Var
  intCodSeq  : Integer;
  intContador: Integer;
begin
  intCodSeq := fRetProCodSeq;

  qryCores.SQL := TAutcomTintaFactory.Get.GetInsert('DU2_CADDU2');
  qryCores.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DU2_CADDU2', TAutcomTintaFactory.Get.GetCodEmp);
  qryCores.ParamByName('DU2_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryCores.ParamByName('DU2_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
  qryCores.ParamByName('DU2_CODDU2').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCores.ParamByName('DU2_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCores.ParamByName('DU2_CODOEM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
  qryCores.ParamByName('DU2_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
  qryCores.ParamByName('DU2_QUALID').AsString := qryCadNfm.FieldByName('NFM_QUALID').AsString;
  qryCores.ParamByName('DU2_ALTERN').AsString := qryCadNfm.FieldByName('NFM_ALTERN').AsString;
  qryCores.ParamByName('DU2_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
  qryCores.ParamByName('DU2_REGIAO').AsString := '';
  qryCores.ParamByName('DU2_MONTAD').AsString := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
  qryCores.ParamByName('DU2_ANOCOR').AsString := IntToStr(YearOf(qryCadNfm.FieldByName('NFM_DTACAD').AsDate));
  qryCores.ParamByName('DU2_ATIVO_').AsString := qryCadNfm.FieldByName('NFM_ATIVO_').AsString;
  qryCores.ParamByName('DU2_ACRMOB').AsFloat := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
  qryCores.ParamByName('DU2_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
  qryCores.ParamByName('DU2_PROCHA').AsString  := qryCadNfm.FieldByName('NFM_PROCHA').AsString;
  qryCores.ParamByName('DU2_LITRAG').AsFloat := 1000;

  For intContador := 1 To 20 Do
  Begin

    If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
      Break;

    qryCores.ParamByName('DU2_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString);

    qryCores.ParamByName('DU2_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
      qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

    qryCores.ParamByName('DU2_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString := 'B';
  End;

  qryCores.ParamByName('DU2_MD5KEY').AsString := GetMD5(qryCores.ParamByName('DU2_CODNFM').AsString +
                                                        qryCores.ParamByName('DU2_CODOEM').AsString +
                                                        qryCores.ParamByName('DU2_DESCRI').AsString +
                                                        qryCores.ParamByName('DU2_LINHA_').AsString +
                                                        qryCores.ParamByName('DU2_LITRAG').AsString +
                                    qryCores.ParamByName('DU2_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC01').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB01').AsString +
                                    qryCores.ParamByName('DU2_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC02').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB02').AsString +
                                    qryCores.ParamByName('DU2_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC03').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB03').AsString +
                                    qryCores.ParamByName('DU2_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC04').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB04').AsString +
                                    qryCores.ParamByName('DU2_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC05').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB05').AsString +
                                    qryCores.ParamByName('DU2_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC06').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB06').AsString +
                                    qryCores.ParamByName('DU2_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC07').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB07').AsString +
                                    qryCores.ParamByName('DU2_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC08').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB08').AsString +
                                    qryCores.ParamByName('DU2_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC09').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB09').AsString +
                                    qryCores.ParamByName('DU2_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC10').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB10').AsString +
                                    qryCores.ParamByName('DU2_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC11').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB11').AsString +
                                    qryCores.ParamByName('DU2_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC12').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB12').AsString +
                                    qryCores.ParamByName('DU2_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC13').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB13').AsString +
                                    qryCores.ParamByName('DU2_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC14').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB14').AsString +
                                    qryCores.ParamByName('DU2_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC15').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB15').AsString +
                                    qryCores.ParamByName('DU2_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC16').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB16').AsString +
                                    qryCores.ParamByName('DU2_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC17').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB17').AsString +
                                    qryCores.ParamByName('DU2_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC18').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB18').AsString +
                                    qryCores.ParamByName('DU2_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC19').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB19').AsString +
                                    qryCores.ParamByName('DU2_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DU2_QTDC20').AsFloat), ',', '.') + qryCores.ParamByName('DU2_TIPB20').AsString);

  qryCores.ExecSQL;
end;

function TGravandoExecucaoDuxone2NovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoDuxone2NovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoDuxone2NovasFormulas.fRetProCodSeq: Integer;
  Var
    qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT IFNULL(MAX(DU2_CODSEQ),0) + 1 PROX FROM DU2_CADDU2;';
  qryGen.Open;

  Result := qryGen.FieldByName('PROX').AsInteger;
end;

procedure TGravandoExecucaoDuxone2NovasFormulas.RemoverNovasFormulas;
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
          '   DU2_CADDU2                  ' +
          ' WHERE DU2_CODNFM IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     DU2_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   DU2_CADDU2                           ' +
          ' WHERE DU2_CODNFM IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     DU2_CADNFM                         ' +
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
