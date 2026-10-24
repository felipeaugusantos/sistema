{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Calamar *}
{***************************************************************************PH*}
unit untGravandoExecucaoCalamarColorantes;

interface

uses
  untAbstractGravandoExecucaoCalamar, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;
type
  TGravandoExecucaoCalamarColorantes = class(TAbstractGravandoExecucaoCalamar)
  private
    qryAdoColorantes: TADOQuery;
    qryAdoEmbalagens: TADOQuery;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils;
{ TGravandoExecucaoCalamarCores }

procedure TGravandoExecucaoCalamarColorantes.Executar(const gravando: IGravando);
var
  qryCadCol: IDataSet;
  qryCadEmb: IDataSet;
begin
  Try
    Try
      If Not FileExists(GetPath) Then
      Begin
        gravando.texto := Format('O arquivo %s não existe',
          [AnsiReplaceStr(GetPath, '"', '')]);
        gravando.Cancelar;
      End;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando dados do Cadastro de Colorantes...';
      qryAdoColorantes := TADOQuery.Create(Nil);
      qryAdoColorantes.Connection := fConexaoCalamar(GetPath);

      qryAdoColorantes.SQL.Add('    SELECT DISTINCT   ');
      qryAdoColorantes.SQL.Add('      CODE,     ');
      qryAdoColorantes.SQL.Add('      DESCRIPTION,      ');
      qryAdoColorantes.SQL.Add('      SW      ');
      qryAdoColorantes.SQL.Add('    FROM    ');
      qryAdoColorantes.SQL.Add('      COMPONENTS      ');
      qryAdoColorantes.Open;

      qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Cadastro de Colorantes...';
      qryCadCol.SQL := '    DELETE FROM CAL_CADCOL    ';
      qryCadCol.ExecSQL;
      qryCadCol.SQL.Empty;
      Gravando.Texto := 'Cadastro de Colorantes deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('CAL_CADCOL');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Colorantes...';
      qryCadCol.SQL := '    SELECT * FROM CAL_CADCOL    ';
      qryCadCol.Open;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      Try
        While Not qryAdoColorantes.Eof Do
        Begin
          If Not qryCadCol.Locate('COL_CODCOL', VarArrayOf([qryAdoColorantes.FieldByName('CODE').AsString]), []) Then
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            qryCadCol.Insert;
            qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CAL_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadCol.FieldByName('COL_CODCOL').AsString := qryAdoColorantes.FieldByName('CODE').AsString;
            qryCadCol.FieldByName('COL_DESCRI').AsString := qryAdoColorantes.FieldByName('DESCRIPTION').AsString;
            qryCadCol.FieldByName('COL_EMBALA').AsFloat := 1000;
            qryCadCol.FieldByName('COL_PESESP').AsFloat := qryAdoColorantes.FieldByName('SW').AsFloat;
            qryCadCol.Post;
          End;
          qryAdoColorantes.Next;
          gravando.RegistrarProgresso(0, qryAdoColorantes.RecNo, qryAdoColorantes.RecordCount);
        End;
      Except
        On E: Exception Do
        Begin
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;
      End;

      Gravando.Texto := 'Cadastro de Colorantes processado com sucesso!';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando dados do Cadastro de Embalagens...';
      qryAdoEmbalagens := TADOQuery.Create(Nil);
      qryAdoEmbalagens.Connection := fConexaoCalamar(GetPath);

      qryAdoEmbalagens.SQL.Add('    SELECT  DISTINCT    ');
      qryAdoEmbalagens.SQL.Add('      ID,     ');
      qryAdoEmbalagens.SQL.Add('      DESCRIPTION,      ');
      qryAdoEmbalagens.SQL.Add('      CAPACITY      ');
      qryAdoEmbalagens.SQL.Add('    FROM    ');
      qryAdoEmbalagens.SQL.Add('      CANS    ');
      qryAdoEmbalagens.Open;

      qryCadEmb := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Cadastro de Embalagens...';
      qryCadEmb.SQL := '    DELETE FROM CAL_CADEMB    ';
      qryCadEmb.ExecSQL;
      qryCadEmb.SQL.Empty;
      Gravando.Texto := 'Cadastro de Embalagens deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('CAL_CADEMB');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Embalagens...';
      qryCadEmb.SQL := '    SELECT * FROM CAL_CADEMB    ';
      qryCadEmb.Open;

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      Try
        While Not qryAdoEmbalagens.Eof Do
        Begin
          If Not qryCadEmb.Locate('EMB_CODEMB', VarArrayOf([TStrUtils.fStrZero(qryAdoEmbalagens.FieldByName('ID').AsString, 3)]), []) Then
          Begin
            If (Gravando.Status <> sgGravando) Then
              Break;

            qryCadEmb.Insert;
            qryCadEmb.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CAL_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadEmb.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadEmb.FieldByName('EMB_CODEMB').AsString := TStrUtils.fStrZero(qryAdoEmbalagens.FieldByName('ID').AsString, 3);
            qryCadEmb.FieldByName('EMB_DESCRI').AsString := qryAdoEmbalagens.FieldByName('DESCRIPTION').AsString;
            qryCadEmb.FieldByName('EMB_TAMEMB').AsFloat  := qryAdoEmbalagens.FieldByName('CAPACITY').AsFloat;
            qryCadEmb.Post;
          End;
          qryAdoEmbalagens.Next;
        End;
      Except
        On E: Exception Do
        Begin
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;

      End;
    Except
      On E: Exception Do
      Begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally
    Gravando.Texto := 'Cadastro de Embalagens processado com sucesso!';
    gravando.RegistrarProgresso(0, qryAdoEmbalagens.RecNo, qryAdoEmbalagens.RecordCount);
  End;
end;

function TGravandoExecucaoCalamarColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes/Embalagens';
end;



end.

