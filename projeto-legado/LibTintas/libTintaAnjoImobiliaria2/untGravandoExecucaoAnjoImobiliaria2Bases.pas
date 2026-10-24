{******************************************************************************************}
{* Classe responsável pela geração do cadastro de Bases da tinta Anjo Imobiliaria 2 *}
{***************************************************************************************PH*}
unit untGravandoExecucaoAnjoImobiliaria2Bases;

interface

uses
  untAbstractGravandoExecucaoAnjoImobiliaria2, untIGravando, SysUtils, untIDataSet, Uni,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs,Classes,
  PostgreSQLUniProvider, StrUtils,System.Variants, Data.DB;

type
  TGravandoExecucaoAnjoImobiliaria2Bases = class(TAbstractGravandoExecucaoAnjoImobiliaria2)
  Private
    function fRetUnidade(fltEmbalagem: Double): String;
    Procedure DeletarRegistros;
  Protected
    function IsRegistroExistente(const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean; Override;
    procedure GravarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery); Override;
    function GetSqlDestino(): String; Override;
  Public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils;

{ TGravandoExecucaoAnjoImobiliaria2Cores }

procedure TGravandoExecucaoAnjoImobiliaria2Bases.DeletarRegistros;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM AN2_CADBAS  ';
  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoAnjoImobiliaria2Bases.Executar(const gravando: IGravando);
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
      strSQL := strSQL + '    base.descricao as DESCBASE,     ';
      strSQL := strSQL + '    produto.descricao as DESCPRODUTO,     ';
      strSQL := strSQL + '    embalagem.conteudo AS EMBALAGEM   ';
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

      Gravando.Texto := 'Deletando registros da tabela AN2_CADBAS...';
      DeletarRegistros;
      Gravando.Texto := 'Registros excluidos com sucesso...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('AN2_CADBAS');
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

function TGravandoExecucaoAnjoImobiliaria2Bases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoAnjoImobiliaria2Bases.fRetUnidade(
  fltEmbalagem: Double): String;
begin
  If fltEmbalagem <= 1500 Then
    Result := 'LT'
  Else If fltEmbalagem <= 8000 Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TGravandoExecucaoAnjoImobiliaria2Bases.GetSqlDestino: String;
begin
  Result := ' SELECT * FROM AN2_CADBAS    ';
end;

procedure TGravandoExecucaoAnjoImobiliaria2Bases.GravarRegistro(
  const qryDestino: IDataSet; qryOrigem: TUniQuery);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('AN2_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('BAS_CODBAS').AsString  := qryOrigem.FieldByName('DESCBASE').AsString;
  qryDestino.FieldByName('BAS_PRODUT').AsString  := qryOrigem.FieldByName('DESCPRODUTO').AsString;
  qryDestino.FieldByName('BAS_UNIDAD').AsString  := fRetUnidade(qryOrigem.FieldByName('EMBALAGEM').AsFloat);
  qryDestino.FieldByName('BAS_EMBALA').AsFloat   := qryOrigem.FieldByName('EMBALAGEM').AsFloat;
  qryDestino.Post;
end;

function TGravandoExecucaoAnjoImobiliaria2Bases.IsRegistroExistente(
  const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean;
begin
  Result := qryDestino.Locate('BAS_CODBAS;BAS_PRODUT;BAS_UNIDAD', VarArrayOf([qryOrigem.FieldByName('DESCBASE').AsString, qryOrigem.FieldByName('DESCPRODUTO').AsString,
    fRetUnidade(qryOrigem.FieldByName('EMBALAGEM').AsFloat)]), []);
end;

end.


