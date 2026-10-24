{******************************************************************************}
{* Classe responsável pela geração do cadastro de Montadora da tinta falcão*}
{***************************************************************************PH*}
unit untGravandoExecucaoAnjoAutomotivaMontadora;

interface

uses
  untAbstractGravandoExecucaoAnjoAutomotiva, untIGravando, SysUtils, untIDataSet,System.Classes,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  Variants, Uni, PostgreSQLUniProvider, DB;
type
  TGravandoExecucaoAnjoAutomotivaMontadora = class(TAbstractGravandoExecucaoAnjoAutomotiva)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoAnjoAutomotivaMontadora}

procedure TGravandoExecucaoAnjoAutomotivaMontadora.Executar(const gravando: IGravando);
Var
  qryCadMon: IDataSet;
  qryMontadora: TUniQuery;
  sSQL: String;
begin
  Try
    Try
      sSQL := sSQL + '  SELECT              ';
      sSQL := sSQL + '    mon_id AS IDMON,  ';
      sSQL := sSQL + '    mon_descricao as DESMON ';
      sSQL := sSQL + '  FROM                ';
      sSQL := sSQL + '    montadora         ';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Deletando Cadastro de Montadora...';
      qryCadMon := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadMon.SQL := '  DELETE FROM AJT_CADMON   ';
      qryCadMon.ExecSQL;
      Gravando.Texto := 'Cadastro de Montadora deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('AJT_CADMON');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Montadora..';
      qryCadMon.SQL := '   SELECT * FROM AJT_CADMON   ';
      qryCadMon.Open;

      Gravando.Texto := 'Processando dados...';

      qryMontadora := TUniQuery.Create(Nil);
      qryMontadora.Connection := fConexaoPostgreSQL;
      qryMontadora.Close;
      qryMontadora.SQL.Clear;
      qryMontadora.SQL.Add(sSQL);
      qryMontadora.Open;
      qryMontadora.First;

      If qryMontadora.IsEmpty Then
      Begin
        Gravando.Texto := 'O cadastro de montadora está vazio. Verificar!';
        Exit;
      End;

      While Not qryMontadora.Eof Do
      Begin
        qryCadMon.Insert;
        qryCadMon.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('AJT_CADMON', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadMon.FieldByName('MON_CODMON').AsInteger := qryMontadora.FieldByName('IDMON').AsInteger;
        qryCadMon.FieldByName('MON_DESCRI').AsString  := qryMontadora.FieldByName('DESMON').AsString;
        qryCadMon.Post;

        qryMontadora.Next;
        Gravando.RegistrarProgresso(0, qryMontadora.RecNo, qryMontadora.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(qryMontadora) Then
      FreeAndNil(qryMontadora);
  End;
end;


function TGravandoExecucaoAnjoAutomotivaMontadora.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Montadora';
end;


end.


