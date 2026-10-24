{***************************************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Standox *}
{***************************************************************************************************}
unit untGravandoExecucaoStandoxNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, System.StrUtils;

type
  TGravandoExecucaoStandoxNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    function fRetCodSeq: Integer;

  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoStandoxNovasFormulas }

constructor TGravandoExecucaoStandoxNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoStandoxNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm : IDataSet;
  qryCadDOX : IDataSet;
  intCont   : Integer;
begin
  Try
    Try
      Gravando.Texto := 'Procesando Cadastro de Novas Fórmulas...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadDOX := TAutcomTintaFactory.Get.fGetDataSet;

      qryCadNfm.SQL := '  SELECT * FROM DOX_CADNFM    ';
      qryCadDOX.SQL := '  DELETE FROM DOX_CADDOX    ';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);
        qryCadDOX.SQL := qryCadDOX.SQL + '  WHERE DOX_CODNFM = ' + QuotedStr(strCodNfm);
      End
      Else
      Begin
        qryCadDOX.SQL := qryCadDOX.SQL + ' WHERE DOX_CODNFM LIKE ''ESP%'' ';
      End;

      qryCadNfm.Open;
      qryCadDOX.ExecSQL;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      qryCadDOX.SQL.Empty;
      qryCadDOX.SQL := '  SELECT * FROM DOX_CADDOX ORDER BY AUTOINCREM DESC LIMIT 1  ';
      qryCadDOX.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DOX_CADDOX');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Processando Novas Fórmulas...';

      While Not qryCadNfm.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryCadDOX.Insert;
        qryCadDOX.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DOX_CADDOX', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadDOX.FieldByName('DOX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadDOX.FieldByName('DOX_CODSEQ').AsString := TStrUtils.fStrZero(fRetCodSeq, 6);
        qryCadDOX.FieldByName('DOX_CODDOX').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadDOX.FieldByName('DOX_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadDOX.FieldByName('DOX_VERSAO').AsString := qryCadNfm.FieldByName('NFM_VERSAO').AsString;
        qryCadDOX.FieldByName('DOX_QUALID').AsString := qryCadNfm.FieldByName('NFM_QUALID').AsString;
        qryCadDOX.FieldByName('DOX_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryCadDOX.FieldByName('DOX_MONTAD').AsString := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
        qryCadDOX.FieldByName('DOX_ANOINI').AsString := qryCadNfm.FieldByName('NFM_ANOINI').AsString;
        qryCadDOX.FieldByName('DOX_ANOFIN').AsString := qryCadNfm.FieldByName('NFM_ANOFIN').AsString;
        qryCadDOX.FieldByName('DOX_CATEGO').AsString := qryCadNfm.FieldByName('NFM_CATEGO').AsString;
        qryCadDOX.FieldByName('DOX_PAIS__').AsString := qryCadNfm.FieldByName('NFM_PAIS__').AsString;
        qryCadDOX.FieldByName('DOX_VARIAN').AsString := qryCadNfm.FieldByName('NFM_VARIAN').AsString;
        qryCadDOX.FieldByName('DOX_ATIVO_').AsString := qryCadNfm.FieldByName('NFM_ATIVO_').AsString;
        qryCadDOX.FieldByName('DOX_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
        qryCadDOX.FieldByName('DOX_DTACAD').AsDate   := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
        qryCadDOX.FieldByName('DOX_PROCHA').AsString := qryCadNfm.FieldByName('NFM_PROCHA').AsString;


        For intCont := 1 To 20 Do
        Begin

          If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
            Break;

          qryCadDOX.FieldByName('DOX_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryCadDOX.FieldByName('DOX_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        qryCadDOX.FieldByName('DOX_MD5KEY').AsString := GetMD5(qryCadDox.FieldByName('DOX_MONTAD').AsString + qryCadDox.FieldByName('DOX_CODDOX').AsString +
                                                               qryCadDox.FieldByName('DOX_DESCRI').AsString + qryCadDox.FieldByName('DOX_VERSAO').AsString +
                                                               qryCadDox.FieldByName('DOX_ANOINI').AsString + qryCadDox.FieldByName('DOX_ANOFIN').AsString +
                                                               qryCadDox.FieldByName('DOX_PAINEL').AsString + qryCadDox.FieldByName('DOX_CATEGO').AsString +
                                                               qryCadDox.FieldByName('DOX_PAIS__').AsString + qryCadDox.FieldByName('DOX_VARIAN').AsString +
                                                               qryCadDox.FieldByName('DOX_QUALID').AsString + qryCadDox.FieldByName('DOX_INFCOR').AsString +
              qryCadDox.FieldByName('DOX_BASE01').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC01').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE02').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC02').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE03').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC03').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE04').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC04').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE05').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC05').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE06').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC06').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE07').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC07').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE08').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC08').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE09').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC09').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE10').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC10').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE11').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC11').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE12').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC12').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE13').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC13').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE14').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC14').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE15').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC15').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE16').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC16').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE17').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC17').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE18').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC18').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE19').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC19').AsFloat), ',', '.') +
              qryCadDox.FieldByName('DOX_BASE20').AsString + AnsiReplaceStr(FormatFloat('0.00000', qryCadDox.FieldByName('DOX_QTDC20').AsFloat), ',', '.'));

        qryCadDOX.Post;
        qryCadNfm.Next;
        Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message])
      End;
    End;
  Finally
    Gravando.Texto := 'Novas Fórmulas processadas com sucesso!';
  End;
end;

function TGravandoExecucaoStandoxNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoStandoxNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoStandoxNovasFormulas.fRetCodSeq: Integer;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;

  qryGen.SQL := 'SELECT DOX_CODSEQ '+
                '  FROM DOX_CADDOX '+
                ' ORDER BY DOX_CODSEQ '+
                '  DESC LIMIT 1;';
  qryGen.Open;

  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('DOX_CODSEQ').AsInteger + 1;
end;


end.
