{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta falcão*}
{***************************************************************************PH*}
unit untGravandoExecucaoAnjoAutomotivaBases;

interface

uses
  untAbstractGravandoExecucaoAnjoAutomotiva, untIGravando, SysUtils, untIDataSet,System.Classes,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  Variants, Uni, PostgreSQLUniProvider, DB;
type
  TGravandoExecucaoAnjoAutomotivaBases = class(TAbstractGravandoExecucaoAnjoAutomotiva)
  private
    function fQtdEmbalagemMl(strEmbalagem: String): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

implementation

{ TGravandoExecucaoAnjoAutomotivaBases}

procedure TGravandoExecucaoAnjoAutomotivaBases.Executar(const gravando: IGravando);
Var
  qryCadBas: IDataSet;
  qryBases: TUniQuery;
  sSQL: String;
begin
  Try
    Try
      sSQL := '';
      sSQL := SSQL + '  SELECT                            ';
      sSQL := SSQL + '    com_codigo AS CODIGO,           ';
      sSQL := SSQL + '    com_descricao AS DESCRICAO,     ';
      sSQL := SSQL + '    com_peso_especifico AS PESESP,  ';
      sSQL := SSQL + '    com_conteudo as EMBALAGEM       ';
      sSQL := SSQL + '  FROM                              ';
      sSQL := SSQL + '    componente                      ';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Deletando Cadastro de Bases...';
      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadBas.SQL := '  DELETE FROM AJT_CADBAS   ';
      qryCadBas.ExecSQL;
      Gravando.Texto := 'Cadastro de Bases deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('AJT_CADBAS');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Bases..';
      qryCadBas.SQL := '   SELECT * FROM AJT_CADBAS   ';
      qryCadBas.Open;

      Gravando.Texto := 'Processando dados...';

      qryBases := TUniQuery.Create(Nil);
      qryBases.Connection := fConexaoPostgreSQL;
      qryBases.Close;
      qryBases.SQL.Clear;
      qryBases.SQL.Add(sSQL);
      qryBases.Open;
      qryBases.First;

      If qryBases.IsEmpty Then
      Begin
        Gravando.Texto := 'O cadastro de bases está vazio. Verificar!';
        Exit;
      End;


      While Not qryBases.Eof Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;

        qryCadBas.Insert;
        qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('AJT_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadBas.FieldByName('BAS_CODBAS').AsString := qryBases.FieldByName('CODIGO').AsString;
        qryCadBas.FieldByName('BAS_DESCRI').AsString := qryBases.FieldByName('DESCRICAO').AsString;
        qryCadBas.FieldByName('BAS_PESESP').AsFloat  := qryBases.FieldByName('PESESP').AsFloat;
        qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := qryBases.FieldByName('EMBALAGEM').AsFloat * 1000;
        qryCadBas.FieldByName('BAS_QTDEMB').AsString := AnsiReplaceStr(fQtdEmbalagemMl(FloatToStrF(qryCadBas.FieldByName('BAS_EMBALA').AsFloat, ffNumber, 12, 0)), '.', '');
        qryCadBas.Post;

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

function TGravandoExecucaoAnjoAutomotivaBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoAnjoAutomotivaBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

end.


