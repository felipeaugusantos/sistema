{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta BlascorAutomotiva *}
{********************************************************************************AC*}
unit untGravandoExecucaoBlascorAutomotivaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoBlascorAutomotivaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoBlascorAutomotivaNovasFormulas }

constructor TGravandoExecucaoBlascorAutomotivaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoBlascorAutomotivaNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm: IDataSet;
  qryBLA: IDataSet;
  intCont: Integer;
  strMd5: String;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM BLA_CADNFM';

      if strCodNfm <> '' then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('BLA_CADBLA');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryBLA := TAutcomTintaFactory.Get.fGetDataSet;

      While (Not qryCadNfm.Eof) do
      begin
        If gravando.Status <> sgGravando Then
          Break;

        qryBLA.SQL := TAutcomTintaFactory.Get.GetInsert('BLA_CADBLA');

        qryBLA.ParamByName('AUTOINCREM').AsString   := TAutcomTintaFactory.Get.fRetAutoIncrem('BLA_CADBLA', TAutcomTintaFactory.Get.GetCodEmp);
        qryBLA.ParamByName('BLA_CODEMP').AsString   := TAutcomTintaFactory.Get.GetCodEmp;
        qryBLA.ParamByName('BLA_CODIGO').AsString   := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
        qryBLA.ParamByName('BLA_CODUNI').AsString   := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
        qryBLA.ParamByName('BLA_DESCRI').AsString   := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryBLA.ParamByName('BLA_ANOINI').AsString   := qryCadNfm.FieldByName('NFM_ANOINI').AsString;
        qryBLA.ParamByName('BLA_ANOFIM').AsString   := qryCadNfm.FieldByName('NFM_ANOFIM').AsString;
        qryBLA.ParamByName('BLA_CODMON').AsString   := qryCadNfm.FieldByName('NFM_CODMON').AsString;
        qryBLA.ParamByName('BLA_CODLIN').AsString   := qryCadNfm.FieldByName('NFM_CODLIN').AsString;
        qryBLA.ParamByName('BLA_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
        qryBLA.ParamByName('BLA_ACRMOB').AsFloat    := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
        qryBLA.ParamByName('BLA_PROCHA').AsString   := qryCadNfm.FieldByName('NFM_PROCHA').AsString;
        qryBLA.ParamByName('BLA_ATIVAD').AsString   := qryCadNfm.FieldByName('NFM_ATIVAD').AsString;

        strMd5 := '';
        strMd5 := strMd5 + qryBLA.ParamByName('BLA_CODIGO').AsString;
        strMd5 := strMd5 + qryBLA.ParamByName('BLA_CODUNI').AsString;
        strMd5 := strMd5 + qryBLA.ParamByName('BLA_DESCRI').AsString;
        strMd5 := strMd5 + qryBLA.ParamByName('BLA_ANOINI').AsString;
        strMd5 := strMd5 + qryBLA.ParamByName('BLA_ANOFIM').AsString;
        strMd5 := strMd5 + qryBLA.ParamByName('BLA_CODLIN').AsString;
        strMd5 := strMd5 + qryBLA.ParamByName('BLA_CODMON').AsString;

        For intCont := 1 To 20 Do
        Begin
          If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
              Break;

          qryBLA.ParamByName('BLA_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryBLA.ParamByName('BLA_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat;

          strMd5 := strMd5 + qryBLA.ParamByName('BLA_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString;
          strMd5 := strMd5 + qryBLA.ParamByName('BLA_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsString;
        End;

        qryBLA.ParamByName('BLA_MD5KEY').AsString := GetMD5(strMd5);
        qryBLA.ExecSQL;

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

function TGravandoExecucaoBlascorAutomotivaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoBlascorAutomotivaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

procedure TGravandoExecucaoBlascorAutomotivaNovasFormulas.RemoverNovasFormulas;
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
          '   BLA_CADBLA                  ' +
          ' WHERE BLA_CODIGO IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODIGO                ' +
          '   FROM                        ' +
          '     BLA_CADNFM)               ';
      end
      else
      begin
        qryGen.SQL :=
          ' DELETE BLA_CADBLA                      ' +
          ' FROM                                   ' +
          '   BLA_CADBLA JOIN BLA_CADNFM ON BLA_CADNFM.NFM_CODIGO = BLA_CADBLA.BLA_CODIGO      ' +
          '   WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);
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

