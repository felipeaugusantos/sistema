{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta International *}
{***************************************************************************PH*}
unit untGravandoExecucaoInternationalColorantes;

interface

uses
  untAbstractGravandoExecucaoInternational, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoInternationalColorantes = class(TAbstractGravandoExecucaoInternational)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils;
{ TGravandoExecucaoInternationalCores }

procedure TGravandoExecucaoInternationalColorantes.Executar(const gravando: IGravando);
var
  qryAdoColorantes: TADOQuery;
  qryCadCol: IDataSet;
begin
  Try
    Try
      Gravando.Texto := 'Validando path do arquivo...';

      If Not fValidaPath Then
      Begin
        Gravando.Texto := Format('O arquivo %s não existe',[AnsiReplaceStr(GetPath, '"', '')]);
        Gravando.Cancelar;
      End;

      Gravando.Texto := 'Path validado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando Cadastro de Colorantes...';
      qryAdoColorantes := TADOQuery.Create(Nil);
      qryAdoColorantes.Connection := fGetAcessInternational(GetPath);
      qryAdoColorantes.Close;
      qryAdoColorantes.SQL.Clear;
      qryAdoColorantes.SQL.Text := '    SELECT * FROM Uso_Corante ORDER BY Corante    ';
      qryAdoColorantes.Open;

      Gravando.Texto := 'Deletando Cadastro de Colorantes...';
      qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadCol.SQL := '    DELETE FROM INT_CADCOL    ';
      qryCadCol.ExecSQL;
      Gravando.Texto := 'Cadastro de Colorantes deletado...';
      qryCadCol.SQL.Empty;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('INT_CADCOL');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Colorantes...';
      qryCadCol.SQL := '    SELECT * FROM INT_CADCOL WHERE FALSE    ';
      qryCadCol.Open;

      Gravando.Texto := Format('Processando Arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      Try
        While Not qryAdoColorantes.Eof Do
        Begin
          If Not qryCadCol.Locate('COL_CODCOL', VarArrayOf([qryAdoColorantes.FieldByName('Corante').AsString]), []) Then
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            qryCadCol.Insert;
            qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('INT_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadCol.FieldByName('COL_CODCOL').AsString := qryAdoColorantes.FieldByName('Corante').AsString;
            qryCadCol.FieldByName('COL_EMBALA').AsFloat  := 4000;
            qryCadCol.FieldByName('COL_PREVEN').AsFloat  := 0.0000;
            qryCadCol.FieldByName('COL_PRECUS').AsFloat  := 0.0000;
            qryCadCol.FieldByName('COL_MARGEM').AsFloat  := 0.0000;
            qryCadCol.Post;

          End;
          qryAdoColorantes.Next;
          Gravando.RegistrarProgresso(0, qryAdoColorantes.RecNo, qryAdoColorantes.RecordCount);
        End;
      Except
        On E: Exception Do
        Begin
          Gravando.Cancelar;
          Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;

      End;

    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally
    Gravando.Texto := 'Cadastro de Colorantes processado com sucesso!';
  End;
end;

function TGravandoExecucaoInternationalColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

end.

