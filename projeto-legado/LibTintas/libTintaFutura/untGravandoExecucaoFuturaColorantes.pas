{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Futura  *}
{***************************************************************************AC*}
unit untGravandoExecucaoFuturaColorantes;

interface

uses
  untAbstractGravandoExecucaoFutura, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, Uni, DBFUniProvider;

type
  TGravandoExecucaoFuturaColorantes = class(TAbstractGravandoExecucaoFutura)
  public
    function fGetPath(intContador: Integer): String; override;
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;

{ TGravandoExecucaoFuturaCores }

procedure TGravandoExecucaoFuturaColorantes.Executar(const gravando: IGravando);
var
  qryColorantes: TUniQuery;
  qryCadCol: IDataSet;
  strSQL: String;
Begin
  Try
    If (Gravando.Status <> sgGravando) Then
      Exit;

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
      Gravando.Texto := 'O cadastro de Colorantes esta vazio! Verificar.';
      Exit;
    End;

    Gravando.Texto := 'Deletando Cadastro de Colorantes...';
    qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
    qryCadCol.SQL := '    DELETE FROM FUT_CADCOL    ';
    qryCadCol.ExecSQL;
    qryCadCol.SQL.Empty;
    Gravando.Texto := 'Cadastro de Colorantes deletado...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('FUT_CADCOL');
    Gravando.Texto := 'PROCOD verificado com sucesso...';

    Gravando.Texto := 'Abrindo Cadastro de Colorantes...';
    qryCadCol.SQL := '      SELECT * FROM FUT_CADCOL     ';
    qryCadCol.Open;

    If (Gravando.Status <> sgGravando) Then
      Exit;

    Gravando.RegistrarProgresso(0, 0, 0);
    qryColorantes.First;

    Try
      While Not qryColorantes.Eof Do
      Begin

        If Not qryCadCol.Locate('COL_CODCOL', qryColorantes.FieldByName('codigo').AsString, []) Then
        Begin
          qryCadCol.Insert;
          qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('FUT_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadCol.FieldByName('COL_CODCOL').AsString := qryColorantes.FieldByName('codigo').AsString;
          qryCadCol.FieldByName('COL_EMBALA').AsFloat  := 946;
          qryCadCol.Post;
        End;

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

function TGravandoExecucaoFuturaColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoFuturaColorantes.fGetPath(
  intContador: Integer): String;
begin
  Result := Conf.fGet('PATFUT');
end;

end.

