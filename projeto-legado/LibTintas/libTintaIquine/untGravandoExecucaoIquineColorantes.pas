{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Iquine *}
{***************************************************************************PH*}
unit untGravandoExecucaoIquineColorantes;

interface

uses
  untAbstractGravandoExecucaoIquine, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  System.Classes;
type
  TGravandoExecucaoIquineColorantes = class(TAbstractGravandoExecucaoIquine)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoIquineCores }

procedure TGravandoExecucaoIquineColorantes.Executar(const gravando: IGravando);
var
  qryCadCol : IDataSet;
  qryDelCol : IDataSet;
  cdsDados  : IDataSet;
begin
  Try
    Try
      CarregarDados(gravando);

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('IQU_CADCOL');
      gravando.Texto := 'PROCOD verificado com sucesso!';


      gravando.Texto := 'Apagando os registros da tabela IQU_CADCOL...';
      qryDelCol := TAutcomTintaFactory.Get.fGetDataSet;
      qryDelCol.SQL := 'DELETE FROM IQU_CADCOL';
      qryDelCol.ExecSQL;
      gravando.Texto := 'Registros apagados com sucesso!';


      gravando.Texto := 'Iniciando Geração do Cadastro de Colorantes...';

      cdsDados := TAutcomTintaFactory.Get.fGetDataSet;
      cdsDados.SQL := 'SELECT DISTINCT CORANTE '+
                      '  FROM TMP_CORES_IQU';
      cdsDados.Open;

      cdsDados.First;

      While Not cdsDados.Eof Do
      Begin

        if gravando.Status <> sgGravando then
          Exit;

        If Not Assigned(qryCadCol) Then
          qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;

        qryCadCol.Close;
        qryCadCol.SQL := 'SELECT * '+
                         '  FROM IQU_CADCOL '+
                         ' WHERE COL_CODCOL = :CODCOL ';
        qryCadCol.ParamByName('CODCOL').AsString := cdsDados.FieldByName('CORANTE').AsString;
        qryCadCol.Open;

        If (qryCadCol.IsEmpty) Then
        Begin
          qryCadCol.Insert;
          qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('IQU_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadCol.FieldByName('COL_CODCOL').AsString := cdsDados.FieldByName('CORANTE').AsString;
          qryCadCol.FieldByName('COL_EMBALA').AsFloat  := 800;
          qryCadCol.Post;
        End;

        cdsDados.Next;

        gravando.RegistrarProgresso(0, cdsDados.RecNo, cdsDados.RecordCount);
      End;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoIquineColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

end.

