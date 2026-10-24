{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Iquine *}
{*******************************************************************************AC*}
unit untGravandoExecucaoIquineBases;

interface

uses
  untAbstractGravandoExecucaoIquine, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, ComObj, Dialogs,
  StrUtils, System.Classes, untStrUtils;

type
  TGravandoExecucaoIquineBases = class(TAbstractGravandoExecucaoIquine)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function fRetCodUni(fltValor : Double) : String;
  end;

implementation

{ TGravandoExecucaoIquineBases }

procedure TGravandoExecucaoIquineBases.Executar(const gravando: IGravando);
var
  qryCadBas : IDataSet;
  qryDelBas : IDataSet;
  cdsDados  : IDataSet;
begin
  Try
    Try

      CarregarDados(gravando);

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('IQU_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';


      gravando.Texto := 'Apagando os registros da tabela IQU_CADBAS...';
      qryDelBas := TAutcomTintaFactory.Get.fGetDataSet;
      qryDelBas.SQL := 'DELETE FROM IQU_CADBAS';
      qryDelBas.ExecSQL;
      gravando.Texto := 'Registros apagados com sucesso!';


      gravando.Texto := 'Iniciando Geração do Cadastro de Bases...';

      cdsDados := TAutcomTintaFactory.Get.fGetDataSet;
      cdsDados.SQL := 'SELECT * '+
                      '  FROM TMP_CORES_IQU'+
                      ' GROUP BY BASE '+
                      '        , PRODUTO '+
                      '        , EMBALAGEM ';
      cdsDados.Open;

      cdsDados.First;

      While Not cdsDados.Eof Do
      Begin

        if gravando.Status <> sgGravando then
          Exit;

        If Not Assigned(qryCadBas) Then
          qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;

        qryCadBas.Close;
        qryCadBas.SQL := 'SELECT * '+
                         '  FROM IQU_CADBAS '+
                         ' WHERE BAS_BASE__ = :CODBAS '+
                         '   AND BAS_UNIDAD = :CODUNI '+
                         '   AND BAS_PRODUT = :PRODUT '+
                         '   AND BAS_EMBALA = :EMBALA ';

        qryCadBas.ParamByName('CODBAS').AsString := cdsDados.FieldByName('BASE').AsString;
        qryCadBas.ParamByName('CODUNI').AsString := fRetCodUni(cdsDados.FieldByName('CAPACIDADE').AsFloat);
        qryCadBas.ParamByName('PRODUT').AsString := cdsDados.FieldByName('PRODUTO').AsString;
        qryCadBas.ParamByName('EMBALA').AsString := cdsDados.FieldByName('CAPACIDADE').AsString;
        qryCadBas.Open;


        If (qryCadBas.IsEmpty) Then
        Begin
          qryCadBas.Insert;
          qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('IQU_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadBas.FieldByName('BAS_BASE__').AsString := cdsDados.FieldByName('BASE').AsString;
          qryCadBas.FieldByName('BAS_DESCRI').AsString := cdsDados.FieldByName('BASE').AsString;
          qryCadBas.FieldByName('BAS_PRODUT').AsString := cdsDados.FieldByName('PRODUTO').AsString;
          qryCadBas.FieldByName('BAS_UNIDAD').AsString := fRetCodUni(cdsDados.FieldByName('CAPACIDADE').AsFloat);
          qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := cdsDados.FieldByName('CAPACIDADE').AsFloat;
          qryCadBas.Post;
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

function TGravandoExecucaoIquineBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoIquineBases.fRetCodUni(fltValor: Double): String;
begin
  Result := 'LT';

  If fltValor < 1000 Then
    Result := 'LT'
  Else If fltValor < 5000 Then
    Result := 'GL'
  Else If fltValor > 5000 Then
    Result := 'LA';
end;

end.
