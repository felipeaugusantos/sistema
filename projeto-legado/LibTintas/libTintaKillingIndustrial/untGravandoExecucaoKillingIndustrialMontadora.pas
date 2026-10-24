{**************************************************************************}
{* Classe responsável pela geração do cadastro de Montadoras da tinta KillingIndustrial *}
{***********************************************************************AC*}
unit untGravandoExecucaoKillingIndustrialMontadora;

interface

uses
  untAbstractGravandoExecucaoKillingIndustrial, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  DBFUniProvider, StrUtils,System.Variants;

type
  TGravandoExecucaoKillingIndustrialMontadora = class(TAbstractGravandoExecucaoKillingIndustrial)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoKillingIndustrialMontadora }

procedure TGravandoExecucaoKillingIndustrialMontadora.Executar(const gravando: IGravando);
Var
  qryUniMontadora: TUniQuery;
  qryCadMon: IDataSet;
  strSQL: String;
begin
  Try
    Try
      Gravando.Texto := 'Verificando Path...';

      If Not fValidaPath Then
      Begin
        Gravando.Texto := Format('O arquivo %s não foi encontrado! Rever Configurações.', [AnsiReplaceStr(fGetPath, '"', '')]);
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando Dados...';
      strSQL := '';
      strSQL := strSQL + '  SELECT              ';
      strSQL := strSQL + '    CODIGO,           ';
      strSQL := strSQL + '    NOME              ';
      strSQL := strSQL + '  FROM                ';
      strSQL := strSQL + '    MONTADORAS        ';

      qryUniMontadora := TUniQuery.Create(Nil);
      qryUniMontadora.Connection := fConexaoKilling;
      qryUniMontadora.Close;
      qryUniMontadora.SQL.Clear;
      qryUniMontadora.SQL.Add(strSQL);
      qryUniMontadora.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('KIN_CADMON');
      gravando.Texto := 'PROCOD verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      qryCadMon := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadMon.Close;
      qryCadMon.SQL := '  SELECT * FROM KIN_CADMON      ';
      qryCadMon.Open;

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      While Not qryUniMontadora.Eof Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;


        If Not qryCadMon.Locate('MON_CODMON', VarArrayOf([qryUniMontadora.FieldByName('CODIGO').AsString]), []) Then
        Begin
          qryCadMon.Insert;
          qryCadMon.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('KIN_CADMON', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadMon.FieldByName('MON_CODMON').AsString := qryUniMontadora.FieldByName('CODIGO').AsString;
          qryCadMon.FieldByName('MON_DESCRI').AsString := qryUniMontadora.FieldByName('NOME').AsString;
          qryCadMon.Post;
        End;
        qryUniMontadora.Next;
        Gravando.RegistrarProgresso(0, qryUniMontadora.RecNo, qryUniMontadora.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally
    If Assigned(qryUniMontadora) Then
      FreeAndNil(qryUniMontadora);
  End;
End;

function TGravandoExecucaoKillingIndustrialMontadora.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Montadora';
end;

end.
