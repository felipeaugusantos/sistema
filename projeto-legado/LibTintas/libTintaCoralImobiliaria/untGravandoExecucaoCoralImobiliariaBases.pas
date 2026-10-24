{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta CoralImobiliaria *}
{*******************************************************************************AC*}
unit untGravandoExecucaoCoralImobiliariaBases;

interface

uses
  untAbstractGravandoExecucaoCoralImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, ComObj, Dialogs,
  StrUtils, Uni, PostgreSQLUniProvider, DB;

type
  TGravandoExecucaoCoralImobiliariaBases = class(TAbstractGravandoExecucaoCoralImobiliaria)
  Private
    function fRetUnidade(fltEmbalagem: Double): String;
    procedure IsDeletarRegistros();
  Protected
    function IsRegistroExistente(const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean; Override;
    procedure GravarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery); Override;
    function GetSqlDestino(): String; Override;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoCoralImobiliariaBases }

procedure TGravandoExecucaoCoralImobiliariaBases.Executar(const gravando: IGravando);
var
  qryBases: TUniQuery;
  qryCadBas: IDataSet;
  strSQL: String;
begin
  Try
    If (Gravando.Status <> sgGravando) Then
      Exit;

    strSQL := ' SELECT                         ' +
              '   B.codigo AS CODIGO,          ' +
              '   L.descr  AS PRODUT,          ' +
              '   E.nominal AS EMBAL           ' +
              ' FROM produtobase AS PB         ' +
              ' INNER JOIN bases AS B ON       ' +
              '   B.id_base = PB.id_base       ' +
              ' INNER JOIN linha AS L ON       ' +
              '   L.id_linha = PB.id_linha     ' +
              ' INNER JOIN embalagens AS E ON  ' +
              '   E.id_emb = PB.id_emb         ' +
              ' ORDER BY B.codigo, L.descr     ' ;

    Gravando.Texto := 'Carregando dados do Cadastro de Bases...';
    qryBases := TUniQuery.Create(Nil);
    qryBases.Connection := fConexaoPostgreSQL;
    qryBases.Close;
    qryBases.SQL.Clear;
    qryBases.SQL.Add(strSQL);
    qryBases.Open;
    qryBases.First;

    If qryBases.IsEmpty Then
    Begin
      Gravando.Texto := 'O cadastro de bases está vazio. Verificar!';
      Exit;
    End;

    Gravando.Texto := 'Deletando Cadastro de Bases...';
    IsDeletarRegistros();
    Gravando.Texto := 'Cadastro de Bases deletado...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('CORIMO_CADBAS');
    Gravando.Texto := 'PROCOD verificado com sucesso!';

    Gravando.Texto := 'Abrindo Cadastro de Bases...';
    qryCadBas := GetDataSetDestino();

    If (Gravando.Status <> sgGravando) Then
      Exit;

    Try
      While Not qryBases.Eof Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        If Not IsRegistroExistente(qryCadBas, qryBases) Then
          GravarRegistro(qryCadBas, qryBases);

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

function TGravandoExecucaoCoralImobiliariaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoCoralImobiliariaBases.fRetUnidade(
  fltEmbalagem: Double): String;
begin
  Result := 'LT';

  If fltEmbalagem < 1500 Then
    Result := 'LT'
  Else If fltEmbalagem < 8500 Then
    Result := 'GL'
  Else If fltEmbalagem < 20000 Then
    Result := 'LA';
end;

function TGravandoExecucaoCoralImobiliariaBases.GetSqlDestino: String;
begin
  Result := ' SELECT * FROM CORIMO_CADBAS ';
end;

procedure TGravandoExecucaoCoralImobiliariaBases.GravarRegistro(
  const qryDestino: IDataSet; qryOrigem: TUniQuery);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CORIMO_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('BAS_BASE__').AsString := qryOrigem.FieldByName('CODIGO').AsString;
  qryDestino.FieldByName('BAS_DESCRI').AsString := qryOrigem.FieldByName('PRODUT').AsString;
  qryDestino.FieldByName('BAS_UNIDAD').AsString := fRetUnidade(qryOrigem.FieldByName('EMBAL').AsFloat);
  qryDestino.Post;
end;

procedure TGravandoExecucaoCoralImobiliariaBases.IsDeletarRegistros;
begin
  TAutcomTintaFactory.Get.TruncateTable('CORIMO_CADBAS');
end;

function TGravandoExecucaoCoralImobiliariaBases.IsRegistroExistente(
  const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean;
begin
  Result := qryDestino.Locate('BAS_BASE__;BAS_DESCRI;BAS_UNIDAD', VarArrayOf([qryOrigem.FieldByName('CODIGO').AsString, qryOrigem.FieldByName('PRODUT').AsString,
    fRetUnidade(qryOrigem.FieldByName('EMBAL').AsFloat)]), []);
end;

end.
