{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Lazzumix *}
{********************************************************************************AC*}
unit untGravandoExecucaoLazzumixNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoLazzumixNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoLazzumixNovasFormulas }

constructor TGravandoExecucaoLazzumixNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoLazzumixNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryCadMix: IDataSet;
  intCont: Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM LAZ_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      qryCadMix := TAutcomTintaFactory.Get.fGetDataSet;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        qryCadMix.SQL := TAutcomTintaFactory.Get.GetInsert('LAZ_CADMIX');

        qryCadMix.ParamByName('MIX_CODIGO').AsString  := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadMix.ParamByName('MIX_CODNFM').AsString  := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadMix.ParamByName('MIX_DESCRI').AsString  := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryCadMix.ParamByName('MIX_REFERE').AsString  := qryCadNfm.FieldByName('NFM_REFERE').AsString;
        qryCadMix.ParamByName('MIX_A_N_O_').AsString  := qryCadNfm.FieldByName('NFM_A_N_O_').AsString;
        qryCadMix.ParamByName('MIX_MONTAD').AsString  := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
        qryCadMix.ParamByName('MIX_UNIVER').AsString  := qryCadNfm.FieldByName('NFM_UNIVER').AsString;
        qryCadMix.ParamByName('MIX_DTACAD').AsDateTime:= qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
        qryCadMix.ParamByName('MIX_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadMix.ParamByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('LAZ_CADMIX', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadMix.ParamByName('MIX_VOLCON').AsFloat   := qryCadNfm.FieldByName('NFM_VOLCON').AsFloat;
        qryCadMix.ParamByName('MIX_VOLDIL').AsFloat   := qryCadNfm.FieldByName('NFM_VOLDIL').AsFloat;
        qryCadMix.ParamByName('MIX_ATIVAD').AsString  := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
        qryCadMix.ParamByName('MIX_ACRMOB').AsFloat   := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

        For intCont := 1 To 20 Do
        Begin
          qryCadMix.ParamByName('MIX_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString := Trim(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryCadMix.ParamByName('MIX_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
          qryCadMix.ParamByName('MIX_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        qryCadMix.ExecSQL;

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

function TGravandoExecucaoLazzumixNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoLazzumixNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoLazzumixNovasFormulas.RemoverNovasFormulas;
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
          '   LAZ_CADMIX                  ' +
          ' WHERE MIX_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     LAZ_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   LAZ_CADMIX                           ' +
          ' WHERE MIX_CODIGO IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     LAZ_CADNFM                         ' +
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
