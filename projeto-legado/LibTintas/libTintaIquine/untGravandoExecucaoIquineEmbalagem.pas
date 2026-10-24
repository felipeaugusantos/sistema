{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Iquine *}
{***************************************************************************PH*}
unit untGravandoExecucaoIquineEmbalagem;

interface

uses
  untAbstractGravandoExecucaoIquine, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  System.Classes;
type
  TGravandoExecucaoIquineEmbalagem = class(TAbstractGravandoExecucaoIquine)
  Private
    function fRetCodUni(fltValor : Double) : String;
    function fRetCodEmb(fltValor : Double): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoIquineCores }

procedure TGravandoExecucaoIquineEmbalagem.Executar(const gravando: IGravando);
var
  qryCadEmb : IDataSet;
  qryDelEmb : IDataSet;
  cdsDados  : IDataSet;
begin
  Try
    Try
      CarregarDados(gravando);

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('IQU_CADEMB');
      gravando.Texto := 'PROCOD verificado com sucesso!';


      gravando.Texto := 'Apagando os registros da tabela IQU_CADEMB...';
      qryDelEmb := TAutcomTintaFactory.Get.fGetDataSet;
      qryDelEmb.SQL := 'DELETE FROM IQU_CADEMB';
      qryDelEmb.ExecSQL;
      gravando.Texto := 'Registros apagados com sucesso!';


      gravando.Texto := 'Iniciando Geração do Cadastro de Embalagem...';

      cdsDados := TAutcomTintaFactory.Get.fGetDataSet;
      cdsDados.SQL := 'SELECT DISTINCT ' +
                      '   CAPACIDADE   ' +
                      '  FROM TMP_CORES_IQU';
      cdsDados.Open;

      cdsDados.First;

      While Not cdsDados.Eof Do
      Begin

        if gravando.Status <> sgGravando then
          Exit;

        If Not Assigned(qryCadEmb) Then
          qryCadEmb := TAutcomTintaFactory.Get.fGetDataSet;

        qryCadEmb.Close;
        qryCadEmb.SQL := 'SELECT * FROM IQU_CADEMB ';
        qryCadEmb.Open;

        qryCadEmb.Insert;
        qryCadEmb.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('IQU_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadEmb.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadEmb.FieldByName('EMB_CODEMB').AsString := fRetCodEmb(cdsDados.FieldByName('CAPACIDADE').AsFloat);
        qryCadEmb.FieldByName('EMB_QTDEMB').AsFloat  := cdsDados.FieldByName('CAPACIDADE').AsFloat;
        qryCadEmb.FieldByName('EMB_UNIDAD').AsString := fRetCodUni(cdsDados.FieldByName('CAPACIDADE').AsFloat);
        qryCadEmb.Post;

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

function TGravandoExecucaoIquineEmbalagem.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagem';
end;

function TGravandoExecucaoIquineEmbalagem.fRetCodEmb(fltValor: Double): String;
begin
  Result := '1';

  If fltValor = 800 Then
    Result := '1'
  Else If fltValor = 3200 Then
    Result := '2'
  Else If fltValor = 16000 Then
    Result := '3'
  Else If fltValor = 14815 Then
    Result := '5'
  Else If fltValor = 2963 Then
    Result := '4';
end;

function TGravandoExecucaoIquineEmbalagem.fRetCodUni(fltValor : Double): String;
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

