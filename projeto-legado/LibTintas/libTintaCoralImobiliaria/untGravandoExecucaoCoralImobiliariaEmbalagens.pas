{******************************************************************************}
{* Classe responsável pela geração do cadastro de Embalagens da tinta CoralImobiliaria *}
{***************************************************************************PH*}
unit untGravandoExecucaoCoralImobiliariaEmbalagens;

interface

uses
  untAbstractGravandoExecucaoCoralImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  Uni, PostgreSQLUniProvider, DB;
type
  TGravandoExecucaoCoralImobiliariaEmbalagens = class(TAbstractGravandoExecucaoCoralImobiliaria)
  Private
    procedure IsDeletarRegistros();
    function fRetUnidade(fltEmbalagem: Double): String;
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

procedure TGravandoExecucaoCoralImobiliariaEmbalagens.Executar(const gravando: IGravando);
var
  qryEmbalagens: TUniQuery;
  qryCadEmb: IDataSet;
  strSQL: String;
begin
  Try
    If (Gravando.Status <> sgGravando) Then
      Exit;

    strSQL := ' SELECT                    ' +
              '    *                      ' +
              ' FROM embalagens           ';

    Gravando.Texto := 'Carregando dados do Cadastro de Embalagens...';
    qryEmbalagens := TUniQuery.Create(Nil);
    qryEmbalagens.Connection := fConexaoPostgreSQL;
    qryEmbalagens.Close;
    qryEmbalagens.SQL.Clear;
    qryEmbalagens.SQL.Add(strSQL);
    qryEmbalagens.Open;
    qryEmbalagens.First;

    If qryEmbalagens.IsEmpty Then
    Begin
      Gravando.Texto := 'O cadastro de Embalagens está vazio. Verificar!';
      Exit;
    End;

    Gravando.Texto := 'Deletando Cadastro de Embalagens...';
    IsDeletarRegistros();
    Gravando.Texto := 'Cadastro de Embalagens deletado...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('CORIMO_CADCOL');
    Gravando.Texto := 'PROCOD verificado com sucesso!';

    Gravando.Texto := 'Abrindo Cadastro de Embalagens...';
    qryCadEmb := GetDataSetDestino();

    If (Gravando.Status <> sgGravando) Then
      Exit;

    Try
      While Not qryEmbalagens.Eof Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        If Not IsRegistroExistente(qryCadEmb, qryEmbalagens) Then
          GravarRegistro(qryCadEmb, qryEmbalagens);

        qryEmbalagens.Next;
        Gravando.RegistrarProgresso(0, qryEmbalagens.RecNo, qryEmbalagens.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(qryEmbalagens) Then
      FreeAndNil(qryEmbalagens);
  End;
end;

function TGravandoExecucaoCoralImobiliariaEmbalagens.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagens';
end;

function TGravandoExecucaoCoralImobiliariaEmbalagens.fRetUnidade(
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

function TGravandoExecucaoCoralImobiliariaEmbalagens.GetSqlDestino: String;
begin
  Result := ' SELECT * FROM CORIMO_CADEMB ';
end;

procedure TGravandoExecucaoCoralImobiliariaEmbalagens.GravarRegistro(
  const qryDestino: IDataSet; qryOrigem: TUniQuery);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CORIMO_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('EMB_CODEMB').AsString := qryOrigem.FieldByName('nominal').AsString;
  qryDestino.FieldByName('EMB_QTDEMB').AsFloat  := qryOrigem.FieldByName('nominal').AsFloat;
  qryDestino.FieldByName('EMB_UNIDAD').AsString := fRetUnidade(qryOrigem.FieldByName('nominal').AsFloat);
  qryDestino.Post;
end;

procedure TGravandoExecucaoCoralImobiliariaEmbalagens.IsDeletarRegistros;
begin
  TAutcomTintaFactory.Get.TruncateTable('CORIMO_CADEMB');
end;

function TGravandoExecucaoCoralImobiliariaEmbalagens.IsRegistroExistente(
  const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean;
begin
  Result := qryDestino.Locate('EMB_CODEMB', qryOrigem.FieldByName('nominal').AsString, []);
end;

end.

