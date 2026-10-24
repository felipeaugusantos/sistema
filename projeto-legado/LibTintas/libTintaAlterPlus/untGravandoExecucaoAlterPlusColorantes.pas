{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta AlterPlus *}
{***************************************************************************PH*}
unit untGravandoExecucaoAlterPlusColorantes;

interface

uses
  untAbstractGravandoExecucaoAlterPlus, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, dialogs, Classes;
type
  TGravandoExecucaoAlterPlusColorantes = class(TAbstractGravandoExecucaoAlterPlus)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoAlterPlusCores }

procedure TGravandoExecucaoAlterPlusColorantes.Executar(const gravando: IGravando);
var
  qryDestino : IDataSet;
  Conexao    : TADOConnection;
  Table      : TADODataSet;
begin
  Try
    gravando.Texto := 'Validando Path de Arquivos ...';

    If (Not fValidaPath) Then
    Begin
      gravando.Texto := 'Path para o geração do arquivo de Colorantes não é válido...';
      gravando.Cancelar;
      Exit;
    End;

    gravando.Texto := 'Path validado com sucesso ...';

    gravando.Texto := 'Carregando dados...';

    gravando.Texto := 'Dados carregados com sucesso!';

    gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('ALP_CADCOL');
    gravando.Texto := 'PROCOD verificado com sucesso!';

    if gravando.Status <> sgGravando then
      Exit;

    Try
      Conexao                  := TADOConnection.Create(nil);
      Conexao.LoginPrompt      := False;
      Conexao.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;' +
                                  'Data Source=' + GetPath + ';' + 'Persist Security Info=False;' +
                                  'Jet OLEDB:Database Password=flordavida64836082';
      Conexao.Open;

      Table := TADODataSet.Create(nil);

      Table.Connection := Conexao;
      Table.CommandText := 'SELECT * FROM TB_CANISTER';
      Table.Open;

      gravando.Texto := 'Carregando os registros do arquivo de colorantes...';

      Table.First;

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;

      While not (Table.Eof) do
      begin
        qryDestino.Close;
        qryDestino.SQL := 'SELECT * '+
                          '  FROM ALP_CADCOL'+
                          ' WHERE COL_CODCOL = :CODCOL '+
                          '   AND COL_CODEMP = :CODEMP ';

        qryDestino.ParamByName('CODCOL').AsString := Table.FieldByName('NM_CANISTER').AsString;
        qryDestino.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryDestino.Open;

        if (qryDestino.IsEmpty) then
        begin
          qryDestino.Insert;
          qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ALP_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
          qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryDestino.FieldByName('COL_CODCOL').AsString := Table.FieldByName('NM_CANISTER').AsString;
          qryDestino.FieldByName('COL_DESCRI').AsString := Table.FieldByName('NM_COR').AsString;
          qryDestino.FieldByName('COL_EMBALA').AsFloat  := Table.FieldByName('QTDE_CORANTE').AsFloat;
          qryDestino.Post;
        end;

        gravando.RegistrarProgresso(0, Table.RecNo, Table.RecordCount);

        Table.Next;
      end;

    except
      on e : Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    end;

  finally
    if Assigned(Conexao) then FreeAndNil(Conexao);
    if Assigned(Table)   then FreeAndNil(Table);
  end;

end;

function TGravandoExecucaoAlterPlusColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;


end.

