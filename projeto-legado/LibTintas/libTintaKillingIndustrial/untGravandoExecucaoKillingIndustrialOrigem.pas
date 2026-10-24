{**************************************************************************}
{* Classe responsável pela geração do cadastro de Montadoras da tinta KillingIndustrial *}
{***********************************************************************AC*}
unit untGravandoExecucaoKillingIndustrialOrigem;

interface

uses
  untAbstractGravandoExecucaoKillingIndustrial, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  DBFUniProvider, StrUtils,System.Variants;

type
  TGravandoExecucaoKillingIndustrialOrigem = class(TAbstractGravandoExecucaoKillingIndustrial)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoKillingIndustrialOrigem }

procedure TGravandoExecucaoKillingIndustrialOrigem.Executar(const gravando: IGravando);
Var
  qryUniOrigem: TUniQuery;
  qryCadOri: IDataSet;
  strSQL: String;
begin
  Try
    Try
      Gravando.Texto := 'Verificando Path...';

      If Not fValidaPath Then
      Begin
        Gravando.Texto := Format('O arquivo %s não foi encontrado! Rever configurações.', [AnsiReplaceStr(fGetPath, '"', '')]);
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
      strSQL := strSQL + '    ORIGEM            ';

      qryUniOrigem := TUniQuery.Create(Nil);
      qryUniOrigem.Connection := fConexaoKilling;
      qryUniOrigem.Close;
      qryUniOrigem.SQL.Clear;
      qryUniOrigem.SQL.Add(strSQL);
      qryUniOrigem.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('KIN_CADORI');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      qryCadOri := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadOri.Close;
      qryCadOri.SQL := '  SELECT * FROM KIN_CADORI      ';
      qryCadOri.Open;

      gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      While Not qryUniOrigem.Eof Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        If Not qryCadOri.Locate('ORI_CODIGO', VarArrayOf([qryUniOrigem.FieldByName('CODIGO').AsString]), []) Then
        Begin
          qryCadOri.Insert;
          qryCadOri.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('KIN_CADORI', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadOri.FieldByName('ORI_CODIGO').AsString := qryUniOrigem.FieldByName('CODIGO').AsString;
          qryCadOri.FieldByName('ORI_DESCRI').AsString := qryUniOrigem.FieldByName('NOME').AsString;
          qryCadOri.Post;
        End;
        qryUniOrigem.Next;
        Gravando.RegistrarProgresso(0, qryUniOrigem.RecNo, qryUniOrigem.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(qryUniOrigem) Then
      FreeAndNil(qryUniOrigem);
  End;
End;

function TGravandoExecucaoKillingIndustrialOrigem.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Origem';
end;

end.
