{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Killing *}
{***************************************************************************PH*}
unit untGravandoExecucaoKillingColorantes;

interface

uses
  untAbstractGravandoExecucaoKilling, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  DBFUniProvider, StrUtils, DB;
type
  TGravandoExecucaoKillingColorantes = class(TAbstractGravandoExecucaoKilling)
  Private
    Procedure DeletarRegistros;
  Protected
    function IsRegistroExistente(const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean; Override;
    procedure GravarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery); Override;
    function GetSqlDestino(): String; Override;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

Uses untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoKillingCores }

procedure TGravandoExecucaoKillingColorantes.DeletarRegistros;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM KILD_CADCOL  ';
  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoKillingColorantes.Executar(const gravando: IGravando);
Var
  qryColorantes: TUniQuery;
  qryDestino: IDataSet;
  strSQL: String;
begin
  Try
    Try
      Gravando.Texto := 'Carregando Dados do Cadastro de Colorantes...';
      qryColorantes := TUniQuery.Create(Nil);
      qryColorantes.Connection := fConexaoPostgreSQL;

      strSQL := '';
      strSQL := strSQL + '  SELECT              ';
      strSQL := strSQL + '    *                 ';
      strSQL := strSQL + '  FROM                ';
      strSQL := strSQL + '    corante           ';

      qryColorantes.Close;
      qryColorantes.SQL.Clear;
      qryColorantes.SQL.Add(strSQL);
      qryColorantes.Open;

      If qryColorantes.IsEmpty Then
      Begin
        Gravando.Texto := 'O cadastro de Colorantes está vazio! Verificar.';
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Deletando registros da tabela KILD_CADCOL...';
      DeletarRegistros;
      Gravando.Texto := 'Registros excluidos com sucesso...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('KILD_CADCOL');
      Gravando.Texto := 'PROCOD verificado com sucesso!';

      Gravando.Texto := 'Abrindo Cadastro de Colorantes...';
      qryDestino := GetDataSetDestino();

      While Not qryColorantes.Eof Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Exit;

        If Not IsRegistroExistente(qryDestino, qryColorantes) Then
          GravarRegistro(qryDestino, qryColorantes);

        qryColorantes.Next;
        Gravando.RegistrarProgresso(0, qryColorantes.RecNo, qryColorantes.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(qryColorantes) Then
      FreeAndNil(qryColorantes);
  End;
end;

function TGravandoExecucaoKillingColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoKillingColorantes.GetSqlDestino: String;
begin
  Result := ' SELECT * FROM KILD_CADCOL  ';
end;

procedure TGravandoExecucaoKillingColorantes.GravarRegistro(
  const qryDestino: IDataSet; qryOrigem: TUniQuery);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('KILD_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('COL_CODCOL').AsString := qryOrigem.FieldByName('codigo').AsString;
  qryDestino.FieldByName('COL_DESCRI').AsString := qryOrigem.FieldByName('descricao').AsString;
  qryDestino.FieldByName('COL_EMBALA').AsFloat  := qryOrigem.FieldByName('volume_ml').AsFloat;
  qryDestino.Post;
end;

function TGravandoExecucaoKillingColorantes.IsRegistroExistente(
  const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', qryOrigem.FieldByName('codigo').AsString, []);
end;

end.


