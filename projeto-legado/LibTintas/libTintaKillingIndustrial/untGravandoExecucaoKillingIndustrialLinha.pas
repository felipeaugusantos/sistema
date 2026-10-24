{**************************************************************************}
{* Classe responsável pela geração do cadastro de Montadoras da tinta KillingIndustrial *}
{***********************************************************************AC*}
unit untGravandoExecucaoKillingIndustrialLinha;

interface

uses
  untAbstractGravandoExecucaoKillingIndustrial, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  DBFUniProvider, StrUtils,System.Variants;


type
  TGravandoExecucaoKillingIndustrialLinha = class(TAbstractGravandoExecucaoKillingIndustrial)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoKillingIndustrialLinha }

procedure TGravandoExecucaoKillingIndustrialLinha.Executar(const gravando: IGravando);
Var
  qryUniLinha: TUniQuery;
  qryCadLin: IDataSet;
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
      strSQL := strSQL + '  SELECT                  ';
      strSQL := strSQL + '    CODIGO,               ';
      strSQL := strSQL + '    NOME                  ';
      strSQL := strSQL + '  FROM                    ';
      strSQL := strSQL + '    LINHAS;               ';

      qryUniLinha := TUniQuery.Create(Nil);
      qryUniLinha.Connection := fConexaoKilling;
      qryUniLinha.Close;
      qryUniLinha.SQL.Clear;
      qryUniLinha.SQL.Add(strSQL);
      qryUniLinha.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('KIN_CADLIN');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      qryCadLin := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadLin.Close;
      qryCadLin.SQL := '  SELECT * FROM KIN_CADLIN        ';
      qryCadLin.Open;

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      While Not qryUniLinha.Eof Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        If Not qryCadLin.Locate('LIN_CODIGO', VarArrayOf([qryUniLinha.FieldByName('CODIGO').AsString]), []) Then
        Begin
          qryCadLin.Insert;
          qryCadLin.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('KIN_CADLIN', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadLin.FieldByName('LIN_CODIGO').AsString := qryUniLinha.FieldByName('CODIGO').AsString;
          qryCadLin.FieldByName('LIN_DESCRI').AsString := qryUniLinha.FieldByName('NOME').AsString;
          qryCadLin.Post;
        End;
        qryUniLinha.Next;
        Gravando.RegistrarProgresso(0, qryUniLinha.RecNo, qryUniLinha.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(qryUniLinha) Then
      FreeAndNil(qryUniLinha);
  End;
End;

function TGravandoExecucaoKillingIndustrialLinha.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Linha';
end;

end.
