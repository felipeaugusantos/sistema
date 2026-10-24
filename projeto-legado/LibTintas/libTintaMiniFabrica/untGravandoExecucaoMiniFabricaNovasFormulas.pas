{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta MiniFabrica *}
{********************************************************************************AC*}
unit untGravandoExecucaoMiniFabricaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoMiniFabricaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoMiniFabricaNovasFormulas }

constructor TGravandoExecucaoMiniFabricaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoMiniFabricaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryMIF: IDataSet;
  intCont: Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM MIF_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('MIF_CADMIF');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryMIF := TAutcomTintaFactory.Get.fGetDataSet;

      While (Not qryCadNfm.Eof) do
      begin
        If gravando.Status <> sgGravando Then
          Break;

        qryMIF.SQL := TAutcomTintaFactory.Get.GetInsert('MIF_CADMIF');

        qryMIF.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('MIF_CADMIF', TAutcomTintaFactory.Get.GetCodEmp);
        qryMIF.ParamByName('MIF_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
        qryMIF.ParamByName('MIF_CODIGO').AsString   := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
        qryMIF.ParamByName('MIF_DESCRI').AsString   := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryMIF.ParamByName('MIF_ANOCOR').AsString   := qryCadNfm.FieldByName('NFM_ANOCOR').AsString;
        qryMIF.ParamByName('MIF_MONTAD').AsString   := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
        qryMIF.ParamByName('MIF_REFERE').AsString   := qryCadNfm.FieldByName('NFM_REFERE').AsString;
        qryMIF.ParamByName('MIF_CODCLI').AsString   := qryCadNfm.FieldByName('NFM_CODCLI').AsString;
        qryMIF.ParamByName('MIF_CLIENT').AsString   := qryCadNfm.FieldByName('NFM_CLIENT').AsString;
        qryMIF.ParamByName('MIF_LINHA_').AsString   := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
        qryMIF.ParamByName('MIF_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
        qryMIF.ParamByName('MIF_ACRMOB').AsFloat    := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
        qryMIF.ParamByName('MIF_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;
        qryMIF.ParamByName('MIF_PADREF').AsString   := qryCadNfm.FieldByName('NFM_PADREF').AsString;
        qryMIF.ParamByName('MIF_ORIGEM').AsString   := qryCadNfm.FieldByName('NFM_ORIGEM').AsString;
        qryMIF.ParamByName('MIF_ESPDEM').AsString   := qryCadNfm.FieldByName('NFM_ESPDEM').AsString;
        qryMIF.ParamByName('MIF_ESPSEC').AsString   := qryCadNfm.FieldByName('NFM_ESPSEC').AsString;
        qryMIF.ParamByName('MIF_SECAGD').AsString   := qryCadNfm.FieldByName('NFM_SECAGD').AsString;
        qryMIF.ParamByName('MIF_SECAGM').AsString   := qryCadNfm.FieldByName('NFM_SECAGM').AsString;
        qryMIF.ParamByName('MIF_SECAGT').AsString   := qryCadNfm.FieldByName('NFM_SECAGT').AsString;
        qryMIF.ParamByName('MIF_CATALI').AsString   := qryCadNfm.FieldByName('NFM_CATALI').AsString;
        qryMIF.ParamByName('MIF_ITEMCB').AsString   := qryCadNfm.FieldByName('NFM_ITEMCB').AsString;
        qryMIF.ParamByName('MIF_ITEMCC').AsString   := qryCadNfm.FieldByName('NFM_ITEMCC').AsString;
        qryMIF.ParamByName('MIF_NUMLOT').AsString   := qryCadNfm.FieldByName('NFM_NUMLOT').AsString;
        qryMIF.ParamByName('MIF_OBSERV').AsString   := qryCadNfm.FieldByName('NFM_OBSERV').AsString;
        qryMIF.ParamByName('MIF_TMPCF4').AsFloat    := qryCadNfm.FieldByName('NFM_TMPCF4').AsFloat;
        qryMIF.ParamByName('MIF_BRIL20').AsFloat    := qryCadNfm.FieldByName('NFM_BRIL20').AsFloat;
        qryMIF.ParamByName('MIF_BRIL60').AsFloat    := qryCadNfm.FieldByName('NFM_BRIL60').AsFloat;
        qryMIF.ParamByName('MIF_BRIL85').AsFloat    := qryCadNfm.FieldByName('NFM_BRIL85').AsFloat;

        For intCont := 1 To 20 Do
        Begin
          qryMIF.ParamByName('MIF_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryMIF.ParamByName('MIF_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
          qryMIF.ParamByName('MIF_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        qryMIF.ParamByName('MIF_MD5KEY').AsString := GetMD5(qryMIF.ParamByName('MIF_CODIGO').AsString +
                                                            qryMIF.ParamByName('MIF_DESCRI').AsString +
                                                            qryMIF.ParamByName('MIF_ANOCOR').AsString +
                                                            qryMIF.ParamByName('MIF_MONTAD').AsString +
                                                            qryMIF.ParamByName('MIF_REFERE').AsString +
                                                            qryMIF.ParamByName('MIF_CLIENT').AsString +
                                                            qryMIF.ParamByName('MIF_LINHA_').AsString);


        qryMIF.ExecSQL;

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

function TGravandoExecucaoMiniFabricaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoMiniFabricaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoMiniFabricaNovasFormulas.RemoverNovasFormulas;
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
          '   MIF_CADMIF                  ' +
          ' WHERE MIF_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODIGO                ' +
          '   FROM                        ' +
          '     MIF_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   MIF_CADMIF                           ' +
          ' WHERE MIF_CODIGO IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODIGO                         ' +
          '   FROM                                 ' +
          '     MIF_CADNFM                         ' +
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

