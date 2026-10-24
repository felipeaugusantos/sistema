{ ********************************************************************************** }
{ * Classe responsável pela geração do cadastro de bases da tinta Calamar * }
{ *******************************************************************************AC* }
unit untGravandoExecucaoCalamarBases;

interface

uses
  untAbstractGravandoExecucaoCalamar, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes,
  StrUtils;

type
  TGravandoExecucaoCalamarBases = class(TAbstractGravandoExecucaoCalamar)
  private
    qryAdoBases: TADOQuery;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils;
{ TGravandoExecucaoCalamarBases }

procedure TGravandoExecucaoCalamarBases.Executar(const gravando: IGravando);
var
  qryCadBas: IDataSet;
begin
  Try
    Try
      If Not FileExists(GetPath) Then
      Begin
        gravando.texto := Format('O arquivo %s não existe',
          [AnsiReplaceStr(GetPath, '"', '')]);
        gravando.Cancelar;
      End;

      If (gravando.Status <> sgGravando) Then
        Exit;

      gravando.texto := 'Carregando dados do Cadastro de Bases...';
      qryAdoBases := TADOQuery.Create(Nil);
      qryAdoBases.Connection := fConexaoCalamar(GetPath);

      qryAdoBases.SQL.Add('   SELECT DISTINCT   ');
      qryAdoBases.SQL.Add('       B.CODE,     ');
      qryAdoBases.SQL.Add('       B.DESCRIPTION,     ');
      qryAdoBases.SQL.Add('       C.ID AS ID_EMB      ');
      qryAdoBases.SQL.Add('   FROM    ');
      qryAdoBases.SQL.Add('       BASES B,      ');
      qryAdoBases.SQL.Add('       CANS C      ');
      qryAdoBases.Open;

      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      gravando.texto := 'Deletando Cadastro de Bases...';
      qryCadBas.SQL := '    DELETE FROM CAL_CADBAS    ';
      qryCadBas.ExecSQL;
      qryCadBas.SQL.Empty;
      gravando.texto := 'Cadastro de Bases deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('CAL_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Bases...';
      qryCadBas.SQL := '    SELECT * FROM CAL_CADBAS    ';
      qryCadBas.Open;

      If (Gravando.Status <> sgGravando ) Then
        Exit;

      Gravando.texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      Try
        While Not qryAdoBases.Eof Do
        Begin
          If Not qryCadBas.Locate('BAS_CODBAS;BAS_CODEMB', VarArrayOf([qryAdoBases.FieldByName('CODE').AsString,
            TStrUtils.fStrZero(qryAdoBases.FieldByName('ID_EMB').AsString, 3)]), []) Then
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            qryCadBas.Insert;
            qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('CAL_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadBas.FieldByName('BAS_DESCRI').AsString := qryAdoBases.FieldByName('DESCRIPTION').AsString;
            qryCadBas.FieldByName('BAS_CODBAS').AsString := qryAdoBases.FieldByName('CODE').AsString;
            qryCadBas.FieldByName('BAS_CODEMB').AsString := TStrUtils.fStrZero(qryAdoBases.FieldByName('ID_EMB').AsString, 3);
            qryCadBas.Post;
          End;
          qryAdoBases.Next;
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
    Gravando.RegistrarProgresso(0, qryAdoBases.RecNo, qryAdoBases.RecordCount);
  End;
end;

function TGravandoExecucaoCalamarBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

end.
