{******************************************************************************}
{* Classe responsável pela geração do cadastro de Montadora da tinta falcão*}
{***************************************************************************PH*}
unit untGravandoExecucaoAutoluksMontadora;

interface

uses
  untAbstractGravandoExecucaoAutoluks, untIGravando, SysUtils, untIDataSet,System.Classes,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  Variants;
type
  TGravandoExecucaoAutoluksMontadora = class(TAbstractGravandoExecucaoAutoluks)
  private
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoAutoluksMontadora}

procedure TGravandoExecucaoAutoluksMontadora.Executar(const gravando: IGravando);
var
  slArquivo    : TStringList;
  slQuebraLinha: TStringList;
  qryCadMon    : IDataSet;
  intCont      : integer;
  intConAux    : integer;
  intProcesso  : Integer;
  intCodMon    : Integer;
begin
  Try
    Try
      gravando.Texto := 'Validando Arquivo de Geração...';

      If Not DirectoryExists(GetPath)  Then
      Begin
        gravando.Texto := 'Arquivo para a geração dos Montadora não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Arquivo Validado com Sucesso ...';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ALK_CADMON');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryCadMon := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Excluindo Registros ALK_CADMON...';
      qryCadMon.SQL := '  DELETE FROM ALK_CADMON    ';
      qryCadMon.ExecSQL;
      Gravando.Texto := 'Registros deletados com sucesso...';


      gravando.Texto := 'Iniciando Geração do Cadastro de Montadora...';

      slArquivo     := TStringList.Create;
      slQuebraLinha := TStringList.Create;

      intCodMon := 0;

      For intConAux := 0 To stlPaths.Count - 1 Do
      Begin
        slArquivo.LoadFromFile(GetPath + '\' + stlPaths[intConAux]);

        intProcesso := 0;

        For intCont := 0 to slArquivo.Count - 1 do
        Begin
          if gravando.Status <> sgGravando then
            Exit;


          slQuebraLinha.Delimiter := ';';
          slQuebraLinha.StrictDelimiter := True;
          slQuebraLinha.DelimitedText := slArquivo[intCont];

          qryCadMon.Close;
          qryCadMon.SQL := 'SELECT * '+
                           '  FROM ALK_CADMON '+
                           ' WHERE MON_DESCRI = :DESCRI ';
          qryCadMon.ParamByName('DESCRI').AsString := TrimRight(slQuebraLinha[8]);
          qryCadMon.Open;

          If (qryCadMon.IsEmpty) Then
          Begin
            If (intCont > 0) Then
            Begin
              If slQuebraLinha[8] <> '' Then
              Begin
                Inc(intCodMon);

                qryCadMon.Insert;
                qryCadMon.FieldByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('ALK_CADMON', TAutcomTintaFactory.Get.GetCodEmp);
                qryCadMon.FieldByName('MON_CODMON').AsInteger := intCodMon;
                qryCadMon.FieldByName('MON_DESCRI').AsString  := TrimRight(slQuebraLinha[8]);
                qryCadMon.Post;
              End;
            End;
          End;
          Inc(intProcesso);
          gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
        End;

      End;

      FreeAndNil(slArquivo);
      FreeAndNil(slQuebraLinha);
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
  End;
end;

function TGravandoExecucaoAutoluksMontadora.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Montadora';
end;

end.

