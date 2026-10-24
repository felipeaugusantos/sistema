{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta SherwinWilliams 2*}
{***************************************************************************PH*}
unit untGravandoExecucaoSherwinWilliams2Bases;

interface

uses
  untAbstractGravandoExecucaoSherwinWilliams2, untIGravando, SysUtils, untIDataSet,System.Classes,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  Variants;
type
  TGravandoExecucaoSherwinWilliams2Bases = class(TAbstractGravandoExecucaoSherwinWilliams2)
  private
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function fRetCodUni(strValor : String) : String;

  end;

implementation

{ TGravandoExecucaoSherwinWilliams2Bases}

procedure TGravandoExecucaoSherwinWilliams2Bases.Executar(const gravando: IGravando);
var
  qryCadBas : IDataSet;
  qryDelBas : IDataSet;
  cdsDados  : IDataSet;
begin
  Try
    Try

      CarregarDados(gravando);

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SHW_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';


      gravando.Texto := 'Apagando os registros da tabela SHW_CADBAS...';
      qryDelBas := TAutcomTintaFactory.Get.fGetDataSet;
      qryDelBas.SQL := 'DELETE FROM SHW_CADBAS';
      qryDelBas.ExecSQL;
      gravando.Texto := 'Registros apagados com sucesso!';


      gravando.Texto := 'Iniciando Geração do Cadastro de Bases...';

      cdsDados := TAutcomTintaFactory.Get.fGetDataSet;
      cdsDados.SQL := 'SELECT * '+
                      '  FROM TMP_CORES_SHW'+
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
                         '  FROM SHW_CADBAS '+
                         ' WHERE BAS_CODBAS = :CODBAS '+
                         '   AND BAS_CODUNI = :CODUNI '+
                         '   AND BAS_PRODUT = :PRODUT';

        qryCadBas.ParamByName('CODBAS').AsString := cdsDados.FieldByName('BASE').AsString;
        qryCadBas.ParamByName('CODUNI').AsString := fRetCodUni(cdsDados.FieldByName('EMBALAGEM').AsString);
        qryCadBas.ParamByName('PRODUT').AsString := cdsDados.FieldByName('PRODUTO').AsString;
        qryCadBas.Open;


        If (qryCadBas.IsEmpty) Then
        Begin
          qryCadBas.Insert;
          qryCadBas.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SHW_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadBas.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadBas.FieldByName('BAS_CODBAS').AsString := cdsDados.FieldByName('BASE').AsString;
          qryCadBas.FieldByName('BAS_DESCRI').AsString := cdsDados.FieldByName('BASE').AsString;
          qryCadBas.FieldByName('BAS_PRODUT').AsString := cdsDados.FieldByName('PRODUTO').AsString;
          qryCadBas.FieldByName('BAS_CODUNI').AsString := fRetCodUni(cdsDados.FieldByName('EMBALAGEM').AsString);
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

function TGravandoExecucaoSherwinWilliams2Bases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;


function TGravandoExecucaoSherwinWilliams2Bases.fRetCodUni(strValor: String): String;
begin
  Result := 'QT';

  If strValor = 'QUARTO' Then
    Result := 'QT'
  Else
  If strValor = 'GALAO' Then
    Result := 'GL'
  Else
  If (strValor = 'LATA') Or (strValor = '14LTS.') Or (strValor = '12.5LTS.') Then
    Result := 'LA';
end;

end.

