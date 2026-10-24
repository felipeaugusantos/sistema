{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Ciacollor *}
{***************************************************************************PH*}
unit untGravandoExecucaoCiacollorColorantes;

interface

uses
  untAbstractGravandoExecucaoCiacollor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, Uni, SQLiteUniProvider;
type
  TGravandoExecucaoCiacollorColorantes = class(TAbstractGravandoExecucaoCiacollor)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function fGetPath(intContador: Integer; intDiretorio: Integer): String; override;
  end;

implementation

uses untStrUtils;

{ TGravandoExecucaoCiacollorCores }

procedure TGravandoExecucaoCiacollorColorantes.Executar(const gravando: IGravando);
Var
  qryColorantes: TuniQuery;
  strSQL: String;
  qryDestino: IDataSet;
begin
  Try
    qryColorantes := TUniQuery.Create(Nil);
    qryColorantes.Connection := fConexaoSQLiteStudio();

    strSQL := '';
    strSQL := strSQL + '  SELECT            ';
    strSQL := strSQL + '    *               ';
    strSQL := strSQL + '  FROM              ';
    strSQL := strSQL + '    CANISTER        ';
    strSQL := strSQL + '  WHERE             ';
    strSQL := strSQL + '    ATIVO = "S"     ';

    qryColorantes.Close;
    qryColorantes.SQL.Clear;
    qryColorantes.SQL.Add(strSQL);
    qryColorantes.Open;

    If qryColorantes.IsEmpty Then
    Begin
      Gravando.Texto := 'O cadastro de colorantes esta vazio! Verificar.';
      Exit;
    End;

    Gravando.Texto := 'Deletando registros da tabela CIA_CADCOL...';
    qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
    qryDestino.Close;
    qryDestino.SQL := ' DELETE FROM CIA_CADCOL  ';
    qryDestino.ExecSQL;
    Gravando.Texto := 'Registros deletados com sucesso...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('CIA_CADCOL');
    Gravando.Texto := 'PROCOD verificado com sucesso...';

    Gravando.Texto := 'Abrindo cadastro de colorantes...';
    qryDestino.SQL := ' SELECT * FROM CIA_CADCOL    ';
    qryDestino.Open;

    If (Gravando.Status <> sgGravando) Then
      Exit;

    Gravando.RegistrarProgresso(0, 0, 0);
    qryColorantes.First;

    Try
      While Not qryColorantes.Eof Do
      Begin
        If Not qryDestino.Locate('COL_CODCOL', qryColorantes.FieldByName('NOME').AsString, []) Then
        Begin
          qryDestino.Insert;
          qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CIA_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
          qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryDestino.FieldByName('COL_CODCOL').AsString := qryColorantes.FieldByName('NOME').AsString;
          qryDestino.FieldByName('COL_DESCRI').AsString := qryColorantes.FieldByName('NOME_COR').AsString;
          qryDestino.FieldByName('COL_EMBALA').AsFloat  := 940;
          qryDestino.Post;
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
End;

function TGravandoExecucaoCiacollorColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;


function TGravandoExecucaoCiacollorColorantes.fGetPath(intContador,
  intDiretorio: Integer): String;
begin
  Result := Conf.fGet('PATCIA');
end;

end.

