{***************************************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta FarbenAutomotiva *}
{***************************************************************************************************}
unit untGravandoExecucaoFarbenAutomotivaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoFarbenAutomotivaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
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

{ TGravandoExecucaoFarbenAutomotivaNovasFormulas }

constructor TGravandoExecucaoFarbenAutomotivaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoFarbenAutomotivaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm : IDataSet;
  qryCadFAR : IDataSet;
  intCont   : Integer;
  strMd5    : String;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM FAR_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadFAR := TAutcomTintaFactory.Get.fGetDataSet;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        qryCadFAR.SQL := TAutcomTintaFactory.Get.GetInsert('FAR_CADFAR');

        qryCadFAR.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('FAR_CADFAR', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadFAR.ParamByName('FAR_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadFAR.ParamByName('FAR_CODSEQ').AsInteger  := fRetCodSeq;
        qryCadFAR.ParamByName('FAR_CODNFM').AsString   := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadFAR.ParamByName('FAR_DESCRI').AsString   := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryCadFAR.ParamByName('FAR_LINHA_').AsString   := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
        qryCadFAR.ParamByName('FAR_O_E_M_').AsString   := qryCadNfm.FieldByName('NFM_O_E_M_').AsString;
        qryCadFAR.ParamByName('FAR_DTACAD').AsDateTime := Date;
        qryCadFAR.ParamByName('FAR_A_N_O_').AsString   := qryCadNfm.FieldByName('NFM_A_N_O_').AsString;
        qryCadFAR.ParamByName('FAR_MONTAD').AsString   := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
        qryCadFAR.ParamByName('FAR_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
        qryCadFAR.ParamByName('FAR_ACRMOB').AsFloat    := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
        qryCadFAR.ParamByName('FAR_PROCHA').AsString   := qryCadNfm.FieldByName('NFM_PROCHA').AsString;

        For intCont := 1 To 20 Do
        Begin
          qryCadFAR.ParamByName('FAR_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryCadFAR.ParamByName('FAR_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
          qryCadFAR.ParamByName('FAR_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        strMd5 := qryCadFar.ParamByName('FAR_MONTAD').AsString + qryCadFar.ParamByName('FAR_O_E_M_').AsString +
                  qryCadFar.ParamByName('FAR_A_N_O_').AsString + qryCadFar.ParamByName('FAR_DESCRI').AsString +
                  qryCadFar.ParamByName('FAR_SETOR_').AsString + qryCadFar.ParamByName('FAR_LINHA_').AsString;

        for intCont := 1 to 20 do
        begin
          strMd5 := strMd5 + qryCadFar.ParamByName('FAR_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString +
            StringReplace(FormatFloat('0.00000', qryCadFar.ParamByName('FAR_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat), ',', '.', [rfReplaceAll]) +
            StringReplace(FormatFloat('0.00000', qryCadFar.ParamByName('FAR_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat), ',', '.', [rfReplaceAll]);
        end;

        qryCadFAR.ParamByName('FAR_MD5KEY').AsString := GetMD5(strMd5);
        qryCadFAR.ExecSQL;

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

function TGravandoExecucaoFarbenAutomotivaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoFarbenAutomotivaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoFarbenAutomotivaNovasFormulas.fRetCodSeq: Integer;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;

  qryGen.SQL := 'SELECT FAR_CODSEQ '+
                '  FROM FAR_CADFAR '+
                ' ORDER BY FAR_CODSEQ '+
                '  DESC LIMIT 1;';
  qryGen.Open;

  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('FAR_CODSEQ').AsInteger + 1;
end;

procedure TGravandoExecucaoFarbenAutomotivaNovasFormulas.RemoverNovasFormulas;
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
          '   FAR_CADFAR                  ' +
          ' WHERE FAR_CODNFM IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     FAR_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   FAR_CADFAR                           ' +
          ' WHERE FAR_CODNFM IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     FAR_CADNFM                         ' +
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
