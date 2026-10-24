{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta CoralImobiliaria *}
{***************************************************************************PH*}
unit untGravandoExecucaoCoralImobiliariaColorantes;

interface

uses
  untAbstractGravandoExecucaoCoralImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  Uni, PostgreSQLUniProvider, DB;
type
  TGravandoExecucaoCoralImobiliariaColorantes = class(TAbstractGravandoExecucaoCoralImobiliaria)
  Private
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

{ TGravandoExecucaoCoralImobiliariaCores }

procedure TGravandoExecucaoCoralImobiliariaColorantes.Executar(const gravando: IGravando);
var
  qryColorantes: TUniQuery;
  qryCadCol: IDataSet;
  strSQL: String;
begin
  Try
    If (Gravando.Status <> sgGravando) Then
      Exit;

    strSQL := ' SELECT                    ' +
              '    codigo AS CODIGO,      ' +
              '    descr AS DESCOL,       ' +
              '    volumeemb_ml AS ML     ' +
              ' FROM corantes             ';

    Gravando.Texto := 'Carregando dados do Cadastro de Colorantes...';
    qryColorantes := TUniQuery.Create(Nil);
    qryColorantes.Connection := fConexaoPostgreSQL;
    qryColorantes.Close;
    qryColorantes.SQL.Clear;
    qryColorantes.SQL.Add(strSQL);
    qryColorantes.Open;
    qryColorantes.First;

    If qryColorantes.IsEmpty Then
    Begin
      Gravando.Texto := 'O cadastro de colorantes está vazio. Verificar!';
      Exit;
    End;

    Gravando.Texto := 'Deletando Cadastro de Colorantes...';
    IsDeletarRegistros();
    Gravando.Texto := 'Cadastro de Colorantes deletado...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('CORIMO_CADCOL');
    Gravando.Texto := 'PROCOD verificado com sucesso!';

    Gravando.Texto := 'Abrindo Cadastro de Colorantes...';
    qryCadCol := GetDataSetDestino();

    If (Gravando.Status <> sgGravando) Then
      Exit;

    Try
      While Not qryColorantes.Eof Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        If Not IsRegistroExistente(qryCadCol, qryColorantes) Then
          GravarRegistro(qryCadCol, qryColorantes);

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

function TGravandoExecucaoCoralImobiliariaColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoCoralImobiliariaColorantes.GetSqlDestino: String;
begin
  Result := ' SELECT * FROM CORIMO_CADCOL ';
end;

procedure TGravandoExecucaoCoralImobiliariaColorantes.GravarRegistro(
  const qryDestino: IDataSet; qryOrigem: TUniQuery);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CORIMO_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('COL_CODCOL').AsString := qryOrigem.FieldByName('CODIGO').AsString;
  qryDestino.FieldByName('COL_EMBALA').AsFloat  := qryOrigem.FieldByName('ML').AsFloat;
  qryDestino.Post;
end;

procedure TGravandoExecucaoCoralImobiliariaColorantes.IsDeletarRegistros;
begin
  TAutcomTintaFactory.Get.TruncateTable('CORIMO_CADCOL');
end;

function TGravandoExecucaoCoralImobiliariaColorantes.IsRegistroExistente(
  const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', qryOrigem.FieldByName('CODIGO').AsString, []);
end;


end.

