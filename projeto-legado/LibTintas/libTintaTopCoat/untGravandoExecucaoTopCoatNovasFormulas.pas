{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta TopCoat *}
{********************************************************************************AC*}
unit untGravandoExecucaoTopCoatNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoTopCoatNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoTopCoatNovasFormulas }

constructor TGravandoExecucaoTopCoatNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoTopCoatNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryCOA: IDataSet;
  intCont: Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM COA_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('COA_CADCOA');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryCOA := TAutcomTintaFactory.Get.fGetDataSet;

      While (Not qryCadNfm.Eof) do
      begin
        If gravando.Status <> sgGravando Then
          Break;

        qryCOA.SQL := TAutcomTintaFactory.Get.GetInsert('COA_CADCOA');

        qryCOA.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('COA_CADCOA', TAutcomTintaFactory.Get.GetCodEmp);
        qryCOA.ParamByName('COA_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
        qryCOA.ParamByName('COA_CODIGO').AsString   := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
        qryCOA.ParamByName('COA_DESCRI').AsString   := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryCOA.ParamByName('COA_ANOCOR').AsString   := qryCadNfm.FieldByName('NFM_ANOCOR').AsString;
        qryCOA.ParamByName('COA_MONTAD').AsString   := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
        qryCOA.ParamByName('COA_REFERE').AsString   := qryCadNfm.FieldByName('NFM_REFERE').AsString;
        qryCOA.ParamByName('COA_CODCLI').AsString   := qryCadNfm.FieldByName('NFM_CODCLI').AsString;
        qryCOA.ParamByName('COA_CLIENT').AsString   := qryCadNfm.FieldByName('NFM_CLIENT').AsString;
        qryCOA.ParamByName('COA_LINHA_').AsString   := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
        qryCOA.ParamByName('COA_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
        qryCOA.ParamByName('COA_ACRMOB').AsFloat    := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
        qryCOA.ParamByName('COA_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;

        For intCont := 1 To 20 Do
        Begin
          qryCOA.ParamByName('COA_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryCOA.ParamByName('COA_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
          qryCOA.ParamByName('COA_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        qryCOA.ParamByName('COA_MD5KEY').AsString := GetMD5(qryCOA.ParamByName('COA_CODIGO').AsString +
                                                            qryCOA.ParamByName('COA_DESCRI').AsString +
                                                            qryCOA.ParamByName('COA_ANOCOR').AsString +
                                                            qryCOA.ParamByName('COA_MONTAD').AsString +
                                                            qryCOA.ParamByName('COA_REFERE').AsString +
                                                            qryCOA.ParamByName('COA_CLIENT').AsString +
                                                            qryCOA.ParamByName('COA_LINHA_').AsString);


        qryCOA.ExecSQL;

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

function TGravandoExecucaoTopCoatNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoTopCoatNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoTopCoatNovasFormulas.RemoverNovasFormulas;
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
          '   COA_CADCOA                  ' +
          ' WHERE COA_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODIGO                ' +
          '   FROM                        ' +
          '     COA_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   COA_CADCOA                           ' +
          ' WHERE COA_CODIGO IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODIGO                         ' +
          '   FROM                                 ' +
          '     COA_CADNFM                         ' +
          '   WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm) + ') ';
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

