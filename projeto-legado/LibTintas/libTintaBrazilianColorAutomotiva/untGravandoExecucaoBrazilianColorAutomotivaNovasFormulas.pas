{***************************************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta BrazilianColorAutomotiva *}
{***************************************************************************************************}
unit untGravandoExecucaoBrazilianColorAutomotivaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoBrazilianColorAutomotivaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoBrazilianColorAutomotivaNovasFormulas }

constructor TGravandoExecucaoBrazilianColorAutomotivaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoBrazilianColorAutomotivaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryCadBZC: IDataSet;
  intCont: Integer;
  strMd5    : String;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM BZC_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadBZC := TAutcomTintaFactory.Get.fGetDataSet;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        qryCadBZC.SQL := TAutcomTintaFactory.Get.GetInsert('BZC_CADBZC');

        qryCadBZC.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('BZC_CADBZC', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadBZC.ParamByName('BZC_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadBZC.ParamByName('BZC_CODIGO').AsString   := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadBZC.ParamByName('BZC_CODNFM').AsString   := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadBZC.ParamByName('BZC_DESCRI').AsString   := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryCadBZC.ParamByName('BZC_LINHA_').AsString   := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
        qryCadBZC.ParamByName('BZC_TIPO__').AsString   := qryCadNfm.FieldByName('NFM_TIPO__').AsString;
        qryCadBZC.ParamByName('BZC_DTACAD').AsDateTime := Date;
        qryCadBZC.ParamByName('BZC_A_N_O_').AsString   := qryCadNfm.FieldByName('NFM_A_N_O_').AsString;
        qryCadBZC.ParamByName('BZC_CODMON').AsString   := qryCadNfm.FieldByName('NFM_CODMON').AsString;
        qryCadBZC.ParamByName('BZC_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
        qryCadBZC.ParamByName('BZC_ACRMOB').AsFloat    := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

        For intCont := 1 To 20 Do
        Begin
          qryCadBZC.ParamByName('BZC_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryCadBZC.ParamByName('BZC_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
          qryCadBZC.ParamByName('BZC_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;


        strMd5 := '';
        strMd5 := strMd5 + qryCadNfm.FieldByName('NFM_CODIGO').AsString +
                           qryCadBZC.ParamByName('BZC_CODIGO').AsString +
                           qryCadNfm.FieldByName('NFM_CODUNI').AsString +
                           qryCadNfm.FieldByName('NFM_DESCRI').AsString +
                           qryCadNfm.FieldByName('NFM_A_N_O_').AsString +
                           qryCadNfm.FieldByName('NFM_TIPO__').AsString;

        For intCont := 1 To 20 Do
        Begin
          strMd5 := strMd5 + qryCadBZC.ParamByName('BZC_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString +
            StringReplace(FormatFloat('0.00000', qryCadBZC.ParamByName('BZC_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat), ',', '.', [rfReplaceAll]) +
            StringReplace(FormatFloat('0.00000', qryCadBZC.ParamByName('BZC_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat), ',', '.', [rfReplaceAll]);
        End;

        qryCadBZC.ParamByName('BZC_MD5KEY').AsString := GetMd5(strMd5);

        qryCadBZC.ExecSQL;

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

function TGravandoExecucaoBrazilianColorAutomotivaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoBrazilianColorAutomotivaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoBrazilianColorAutomotivaNovasFormulas.RemoverNovasFormulas;
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
          '   BZC_CADBZC                  ' +
          ' WHERE BZC_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     BZC_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   BZC_CADBZC                           ' +
          ' WHERE BZC_CODIGO IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     BZC_CADNFM                         ' +
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
