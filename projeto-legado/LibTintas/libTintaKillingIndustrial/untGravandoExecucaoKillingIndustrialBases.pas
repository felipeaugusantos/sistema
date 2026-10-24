{**************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta KillingIndustrial *}
{***********************************************************************AC*}
unit untGravandoExecucaoKillingIndustrialBases;

interface

uses
  untAbstractGravandoExecucaoKillingIndustrial, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  DBFUniProvider, StrUtils,System.Variants;

type
  TGravandoExecucaoKillingIndustrialBases = class(TAbstractGravandoExecucaoKillingIndustrial)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

Uses untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoKillingIndustrialBases }

procedure TGravandoExecucaoKillingIndustrialBases.Executar(const gravando: IGravando);
var
  qryUniBases: TUniQuery;
  qryCadBas: IDataSet;
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
      strSQL := strSQL + '  SELECT                    ';
      strSQL := strSQL + '    NOME AS DESCRI,         ';
      strSQL := strSQL + '    CODIGO_MP AS BASE,      ';
      strSQL := strSQL + '    PE AS PESO_ESP          ';
      strSQL := strSQL + '  FROM                      ';
      strSQL := strSQL + '    MATERIAS_PRIMAS         ';
      strSQL := strSQL + '  WHERE                     ';
      strSQL := strSQL + '    CODIGO_MP <> ''''       ';

      qryUniBases := TUniQuery.Create(Nil);
      qryUniBases.Connection := fConexaoKilling;
      qryUniBases.Close;
      qryUniBases.SQL.Clear;
      qryUniBases.SQL.Add(strSQL);
      qryUniBases.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('KIN_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadBas.Close;
      qryCadBas.SQL := '  SELECT * FROM KIN_CADBAS      ';
      qryCadBas.Open;

      Gravando.Texto := Format('Processando Arquivo: [%s]', [AnsiReplaceStr(fGetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      While Not qryUniBases.Eof Do
      Begin
        If Not qryCadBas.Locate('BAS_CODBAS', VarArrayOf([qryUniBases.FieldByName('BASE').AsString]), []) Then
        Begin
          If (Gravando.Status <> sgGravando) Then
            Break;

          qryCadBas.Insert;
          qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('KIN_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadBas.FieldByName('BAS_CODBAS').AsString := qryUniBases.FieldByName('BASE').AsString;
          qryCadBas.FieldByName('BAS_DESCRI').AsString := qryUniBases.FieldByName('DESCRI').AsString;
          qryCadBas.FieldByName('BAS_PESESP').AsFloat  := qryUniBases.FieldByName('PESO_ESP').AsFloat;
          qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := 3600;
          qryCadBas.FieldByName('BAS_QTDEMB').AsString := '3600 ML';
          qryCadBas.Post;
        End;
        qryUniBases.Next;
        Gravando.RegistrarProgresso(0, qryUniBases.RecNo, qryUniBases.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto :=  Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(qryUniBases) Then
      FreeAndNil(qryUniBases);
  End;
End;

function TGravandoExecucaoKillingIndustrialBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


end.
