{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Duxone *}
{********************************************************************************AC*}
unit untGravandoExecucaoDuxoneNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, DateUtils, strUtils;

type
  TGravandoExecucaoDuxoneNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoDuxoneNovasFormulas }

constructor TGravandoExecucaoDuxoneNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoDuxoneNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm  : IDataSet;
  qryCadDUX  : IDataSet;
  strTipFor: String;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM DUX_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DUX_CADDUX');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryCadDUX := TAutcomTintaFactory.Get.fGetDataSet;

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

        fGerarTipoFormula(qryCadNfm, qryCadDUX, strTipFor);

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

procedure TGravandoExecucaoDuxoneNovasFormulas.fGerarTipoFormula(qryCadNfm,
  qryCores: IDataSet; strTipoFormula: String);
Var
  intAux     : Integer;
  intCodSeq  : Integer;
  intContador: Integer;
begin
  intCodSeq := fRetProCodSeq;

  If strTipoFormula = 'C/D' Then //Concentrado e Diluido
  Begin
    For intAux := 0 To 1 Do
    Begin
      qryCores.SQL := TAutcomTintaFactory.Get.GetInsert('DUX_CADDUX');
      qryCores.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DUX_CADDUX', TAutcomTintaFactory.Get.GetCodEmp);
      qryCores.ParamByName('DUX_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
      qryCores.ParamByName('DUX_CODDUX').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
      qryCores.ParamByName('DUX_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
      qryCores.ParamByName('DUX_CODOEM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
      qryCores.ParamByName('DUX_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
      qryCores.ParamByName('DUX_QUALID').AsString := qryCadNfm.FieldByName('NFM_QUALID').AsString;
      qryCores.ParamByName('DUX_ALTERN').AsString := qryCadNfm.FieldByName('NFM_ALTERN').AsString;
      qryCores.ParamByName('DUX_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
      qryCores.ParamByName('DUX_REGIAO').AsString := '';
      qryCores.ParamByName('DUX_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString + ' ' +
        TAutcomTintaFactory.Get.IIF(intAux = 0, 'CONCENTRADO', 'DILUIDO');
      qryCores.ParamByName('DUX_MONTAD').AsString := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
      qryCores.ParamByName('DUX_ANOCOR').AsString := IntToStr(YearOf(qryCadNfm.FieldByName('NFM_DTACAD').AsDate));
      qryCores.ParamByName('DUX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryCores.ParamByName('DUX_PROCHA').AsString  := qryCadNfm.FieldByName('NFM_PROCHA').AsString;

      If TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('GERDIL') = '2' Then
        qryCores.ParamByName('DUX_LITRAG').AsFloat := TAutcomTintaFactory.Get.IIF(intAux = 0, 1000, 2000)
      Else
        qryCores.ParamByName('DUX_LITRAG').AsFloat := TAutcomTintaFactory.Get.IIF(intAux = 0, 1000, 1800);

      qryCores.ParamByName('DUX_ATIVO_').AsString := qryCadNfm.FieldByName('NFM_ATIVO_').AsString;
      qryCores.ParamByName('DUX_ACRMOB').AsFloat := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

      Inc(intCodSeq);

      For intContador := 1 To 20 Do
      Begin
        If Not TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
        Begin
          qryCores.ParamByName('DUX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString :=
            TrimRight(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString);

          If (intAux = 0) Then
            qryCores.ParamByName('DUX_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
              qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat
          Else
            qryCores.ParamByName('DUX_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
              qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

          qryCores.ParamByName('DUX_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString := 'B';

        End
        Else If (intAux > 0) Then
        Begin
          qryCores.ParamByName('DUX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString := 'DX32';

          If TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('GERDIL') = '2' Then
            qryCores.ParamByName('DUX_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := 880
          Else
            qryCores.ParamByName('DUX_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := 704;

          qryCores.ParamByName('DUX_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString := 'D';

          Break;
        End
        Else
          Break;
      End;

      qryCores.ParamByName('DUX_MD5KEY').AsString := GetMD5(qryCores.ParamByName('DUX_CODNFM').AsString +
                                                          qryCores.ParamByName('DUX_CODOEM').AsString +
                                                          qryCores.ParamByName('DUX_DESCRI').AsString +
                                                          qryCores.ParamByName('DUX_LINHA_').AsString +
                                                          qryCores.ParamByName('DUX_LITRAG').AsString +
                                      qryCores.ParamByName('DUX_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC01').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD01').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB01').AsString +
                                      qryCores.ParamByName('DUX_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC02').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD02').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB02').AsString +
                                      qryCores.ParamByName('DUX_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC03').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD03').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB03').AsString +
                                      qryCores.ParamByName('DUX_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC04').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD04').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB04').AsString +
                                      qryCores.ParamByName('DUX_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC05').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD05').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB05').AsString +
                                      qryCores.ParamByName('DUX_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC06').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD06').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB06').AsString +
                                      qryCores.ParamByName('DUX_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC07').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD07').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB07').AsString +
                                      qryCores.ParamByName('DUX_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC08').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD08').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB08').AsString +
                                      qryCores.ParamByName('DUX_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC09').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD09').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB09').AsString +
                                      qryCores.ParamByName('DUX_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC10').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD10').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB10').AsString +
                                      qryCores.ParamByName('DUX_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC11').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD11').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB11').AsString +
                                      qryCores.ParamByName('DUX_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC12').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD12').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB12').AsString +
                                      qryCores.ParamByName('DUX_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC13').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD13').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB13').AsString +
                                      qryCores.ParamByName('DUX_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC14').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD14').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB14').AsString +
                                      qryCores.ParamByName('DUX_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC15').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD15').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB15').AsString +
                                      qryCores.ParamByName('DUX_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC16').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD16').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB16').AsString +
                                      qryCores.ParamByName('DUX_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC17').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD17').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB17').AsString +
                                      qryCores.ParamByName('DUX_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC18').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD18').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB18').AsString +
                                      qryCores.ParamByName('DUX_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC19').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD19').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB19').AsString +
                                      qryCores.ParamByName('DUX_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC20').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD20').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB20').AsString);

      qryCores.ExecSQL;
    End
  End
  Else
  Begin
    qryCores.SQL := TAutcomTintaFactory.Get.GetInsert('DUX_CADDUX');
    qryCores.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DUX_CADDUX', TAutcomTintaFactory.Get.GetCodEmp);
    qryCores.ParamByName('DUX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryCores.ParamByName('DUX_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
    qryCores.ParamByName('DUX_CODDUX').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
    qryCores.ParamByName('DUX_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
    qryCores.ParamByName('DUX_CODOEM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
    qryCores.ParamByName('DUX_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
    qryCores.ParamByName('DUX_QUALID').AsString := qryCadNfm.FieldByName('NFM_QUALID').AsString;
    qryCores.ParamByName('DUX_ALTERN').AsString := qryCadNfm.FieldByName('NFM_ALTERN').AsString;
    qryCores.ParamByName('DUX_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
    qryCores.ParamByName('DUX_REGIAO').AsString := '';
    qryCores.ParamByName('DUX_MONTAD').AsString := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
    qryCores.ParamByName('DUX_ANOCOR').AsString := IntToStr(YearOf(qryCadNfm.FieldByName('NFM_DTACAD').AsDate));
    qryCores.ParamByName('DUX_ATIVO_').AsString := qryCadNfm.FieldByName('NFM_ATIVO_').AsString;
    qryCores.ParamByName('DUX_ACRMOB').AsFloat := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
    qryCores.ParamByName('DUX_PROCHA').AsString  := qryCadNfm.FieldByName('NFM_PROCHA').AsString;


    If strTipoFormula = 'C' Then //Somente Concentrado
    Begin
      qryCores.ParamByName('DUX_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString + ' CONCENTRADO';
      qryCores.ParamByName('DUX_LITRAG').AsFloat := 1000;

      For intContador := 1 To 20 Do
      Begin

        If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
          Break;

        qryCores.ParamByName('DUX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString);

        qryCores.ParamByName('DUX_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
          qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

        qryCores.ParamByName('DUX_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString := 'B';
      End;
    End
    Else
    Begin
      qryCores.ParamByName('DUX_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString + ' DILUIDO';

      If TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('GERDIL') = '2' Then
        qryCores.ParamByName('DUX_LITRAG').AsFloat := 2000
      Else
        qryCores.ParamByName('DUX_LITRAG').AsFloat := 1800;

      For intContador := 1 To 20 Do
      Begin
        If Not TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
        Begin
          qryCores.ParamByName('DUX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString :=
            TrimRight(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString);

          qryCores.ParamByName('DUX_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
            qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

          qryCores.ParamByName('DUX_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString := 'B';
        End
        Else
        Begin
          qryCores.ParamByName('DUX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString := 'DX32';

          If TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('GERDIL') = '2' Then
            qryCores.ParamByName('DUX_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := 880
          Else
            qryCores.ParamByName('DUX_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := 704;


          qryCores.ParamByName('DUX_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString := 'D';

          Break;
        End;
      End;
    End;

    qryCores.ParamByName('DUX_MD5KEY').AsString := GetMD5(qryCores.ParamByName('DUX_CODNFM').AsString +
                                                          qryCores.ParamByName('DUX_CODOEM').AsString +
                                                          qryCores.ParamByName('DUX_DESCRI').AsString +
                                                          qryCores.ParamByName('DUX_LINHA_').AsString +
                                                          qryCores.ParamByName('DUX_LITRAG').AsString +
                                      qryCores.ParamByName('DUX_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC01').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD01').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB01').AsString +
                                      qryCores.ParamByName('DUX_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC02').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD02').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB02').AsString +
                                      qryCores.ParamByName('DUX_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC03').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD03').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB03').AsString +
                                      qryCores.ParamByName('DUX_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC04').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD04').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB04').AsString +
                                      qryCores.ParamByName('DUX_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC05').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD05').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB05').AsString +
                                      qryCores.ParamByName('DUX_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC06').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD06').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB06').AsString +
                                      qryCores.ParamByName('DUX_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC07').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD07').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB07').AsString +
                                      qryCores.ParamByName('DUX_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC08').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD08').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB08').AsString +
                                      qryCores.ParamByName('DUX_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC09').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD09').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB09').AsString +
                                      qryCores.ParamByName('DUX_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC10').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD10').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB10').AsString +
                                      qryCores.ParamByName('DUX_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC11').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD11').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB11').AsString +
                                      qryCores.ParamByName('DUX_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC12').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD12').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB12').AsString +
                                      qryCores.ParamByName('DUX_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC13').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD13').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB13').AsString +
                                      qryCores.ParamByName('DUX_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC14').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD14').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB14').AsString +
                                      qryCores.ParamByName('DUX_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC15').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD15').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB15').AsString +
                                      qryCores.ParamByName('DUX_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC16').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD16').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB16').AsString +
                                      qryCores.ParamByName('DUX_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC17').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD17').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB17').AsString +
                                      qryCores.ParamByName('DUX_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC18').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD18').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB18').AsString +
                                      qryCores.ParamByName('DUX_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC19').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD19').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB19').AsString +
                                      qryCores.ParamByName('DUX_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDC20').AsFloat), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryCores.ParamByName('DUX_QTDD20').AsFloat), ',', '.') + qryCores.ParamByName('DUX_TIPB20').AsString);

    qryCores.ExecSQL;
  End;
end;

function TGravandoExecucaoDuxoneNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoDuxoneNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoDuxoneNovasFormulas.fRetProCodSeq: Integer;
  Var
    qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT IFNULL(MAX(DUX_CODSEQ),0) + 1 PROX FROM DUX_CADDUX;';
  qryGen.Open;

  Result := qryGen.FieldByName('PROX').AsInteger;
end;

procedure TGravandoExecucaoDuxoneNovasFormulas.RemoverNovasFormulas;
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
          '   DUX_CADDUX                  ' +
          ' WHERE DUX_CODNFM IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     DUX_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   DUX_CADDUX                           ' +
          ' WHERE DUX_CODNFM IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     DUX_CADNFM                         ' +
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
