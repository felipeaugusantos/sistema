{**************************************************************************}
{* Classe responsável pela geração do cadastro de Montadoras da tinta SkyMixAutomotiva *}
{***********************************************************************AC*}
unit untGravandoExecucaoSkyMixAutomotivaMontadoras;

interface

uses
  untAbstractGravandoExecucaoSkyMixAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj;

  type
    TGravandoExecucaoSkyMixAutomotivaMontadoras = class(TAbstractGravandoExecucaoSkyMixAutomotiva)
    public
      function fGetNomeGravacao: string; override;
      procedure Executar(const gravando: IGravando); override;
    End;




implementation

uses
  untIConfTinta, untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoSkyMixAutomotivaMontadoras }

procedure TGravandoExecucaoSkyMixAutomotivaMontadoras.Executar(const gravando: IGravando);
Var
  slArquivo    : TStringList;
  qryCadMon    : IDataSet;
  intCont      : integer;
  intProcesso  : Integer;
  slQuebra     : TStringList;
begin
  Try
    Try
      Gravando.Texto := 'Validando Arquivo de Geração...';

      If Not DirectoryExists(GetPath)  Then
      Begin
        gravando.Texto := 'Arquivo para a geração de montadoras não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      Gravando.Texto := 'Arquivo Validado com Sucesso ...';

      qryCadMon := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Registros SKY_CADMON...';
      qryCadMon.Close;
      qryCadMon.SQL := '  DELETE FROM SKY_CADMON    ';
      qryCadMon.ExecSQL;
      Gravando.Texto := 'Registros deletados com sucesso...';

      qryCadMon.SQL := '  SELECT * FROM SKY_CADMON WHERE FALSE  ';
      qryCadMon.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SKY_CADMON');
      Gravando.Texto := 'PROCOD verificado com sucesso!';
      Gravando.Texto := 'Iniciando Geração do Cadastro de Montadoras...';

      slArquivo     := TStringList.Create;
      slQuebra      := TStringList.Create;

      slArquivo.LoadFromFile(GetPath + '\' + 'Montadora.txt');
      intProcesso := 0;

      For intCont := 0 To slArquivo.Count - 1 Do
      Begin
        If gravando.Status <> sgGravando Then
          Exit;

        slQuebra.Delimiter := '|';
        slQuebra.StrictDelimiter := True;
        slQuebra.DelimitedText := slArquivo[intCont];

        qryCadMon.Insert;
        qryCadMon.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SKY_CADMON', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadMon.FieldByName('MON_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadMon.FieldByName('MON_CODMON').AsString := Trim(slQuebra[0]);
        qryCadMon.FieldByName('MON_DESMON').AsString := Trim(slQuebra[1]);
        qryCadMon.Post;

        Inc(intProcesso);
        Gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
      End;
    Except
      On E: Exception Do
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
    FreeAndNil(slArquivo);
    FreeAndNil(slQuebra);
  End;
end;

function TGravandoExecucaoSkyMixAutomotivaMontadoras.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Montadoras';
end;

end.
