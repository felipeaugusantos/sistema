{******************************************************************************}
{* Classe responsável pela geração do cadastro de Bases da tinta Killing *}
{***************************************************************************PH*}
unit untGravandoExecucaoKillingBases;

interface

uses
  untAbstractGravandoExecucaoKilling, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  DBFUniProvider, StrUtils,System.Variants, DB;
type
  TGravandoExecucaoKillingBases = class(TAbstractGravandoExecucaoKilling)
  Private
    function fRetUnidade(ADesEmb: String): String;
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

procedure TGravandoExecucaoKillingBases.DeletarRegistros;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM KILD_CADBAS  ';
  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoKillingBases.Executar(const gravando: IGravando);
Var
  qryBases: TUniQuery;
  qryDestino: IDataSet;
  strSQL: String;
begin
  Try
    Try
      Gravando.Texto := 'Carregando Dados do Cadastro de Bases...';
      qryBases := TUniQuery.Create(Nil);
      qryBases.Connection := fConexaoPostgreSQL;

      strSQL := '';
      strSQL := strSQL + '  SELECT       ';
      strSQL := strSQL + '    base.codigo as CODBASE,         ';
      strSQL := strSQL + '    produto.codigo AS CODFML,       ';
      strSQL := strSQL + '    base.descricao as DESCBASE,     ';
      strSQL := strSQL + '    produto.descricao as DESCPRODUTO,     ';
      strSQL := strSQL + '    embalagem.conteudo AS EMBALAGEM,   ';
      strSQL := strSQL + '    embalagem.descricao AS DESCRICAOEMB    ';
      strSQL := strSQL + '  FROM         ';
      strSQL := strSQL + '    produto_base_embalagem AS basemb    ';
      strSQL := strSQL + '  INNER JOIN embalagem ON     ';
      strSQL := strSQL + '    basemb.id_embalagem = embalagem.id  ';
      strSQL := strSQL + '  INNER JOIN base ON      ';
      strSQL := strSQL + '    basemb.id_base = base.id    ';
      strSQL := strSQL + '  INNER JOIN produto ON       ';
      strSQL := strSQL + '    basemb.id_produto = produto.id;   ';

      qryBases.Close;
      qryBases.SQL.Clear;
      qryBases.SQL.Add(strSQL);
      qryBases.Open;

      If qryBases.IsEmpty Then
      Begin
        Gravando.Texto := 'O cadastro de base está vazio! Verificar.';
        Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Deletando registros da tabela KILD_CADBAS...';
      DeletarRegistros;
      Gravando.Texto := 'Registros excluidos com sucesso...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('KILD_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso!';

      Gravando.Texto := 'Abrindo Cadastro de Bases...';
      qryDestino := GetDataSetDestino();

      While Not qryBases.Eof Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Exit;

        If Not IsRegistroExistente(qryDestino, qryBases) Then
          GravarRegistro(qryDestino, qryBases);

        qryBases.Next;
        Gravando.RegistrarProgresso(0, qryBases.RecNo, qryBases.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(qryBases) Then
      FreeAndNil(qryBases);
  End;
end;

function TGravandoExecucaoKillingBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoKillingBases.fRetUnidade(ADesEmb: String): String;
begin
  Result := Trim(Copy(ADesEmb, 1, 3));
end;

function TGravandoExecucaoKillingBases.GetSqlDestino: String;
begin
  Result := ' SELECT * FROM KILD_CADBAS    ';
end;

procedure TGravandoExecucaoKillingBases.GravarRegistro(
  const qryDestino: IDataSet; qryOrigem: TUniQuery);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('KILD_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_CODFML').AsString := qryOrigem.FieldByName('CODFML').AsString;
  qryDestino.FieldByName('BAS_CODBAS').AsString := qryOrigem.FieldByName('CODBASE').AsString;
  qryDestino.FieldByName('BAS_CODUNI').AsString := fRetUnidade(qryOrigem.FieldByName('DESCRICAOEMB').AsString);
  qryDestino.FieldByName('BAS_DESCRI').AsString := qryOrigem.FieldByName('DESCBASE').AsString;
  qryDestino.FieldByName('BAS_EMBALA').AsFloat  := qryOrigem.FieldByName('EMBALAGEM').AsFloat;
  qryDestino.Post;
end;

function TGravandoExecucaoKillingBases.IsRegistroExistente(
  const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODFML;BAS_CODBAS;BAS_CODUNI', VarArrayOf([qryOrigem.FieldByName('CODFML').AsString, qryOrigem.FieldByName('CODBASE').AsString,
    fRetUnidade(qryOrigem.FieldByName('DESCRICAOEMB').AsString)]), []);
end;

end.


