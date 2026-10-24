{**************************************************************************}
{* Classe responsável pela geração do cadastro de Montadoras da tinta SkyMixAutomotiva *}
{***********************************************************************AC*}
unit untGravandoExecucaoSkyMixAutomotivaGrupos;

interface

uses
  untAbstractGravandoExecucaoSkyMixAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj;

  type
    TGravandoExecucaoSkyMixAutomotivaGrupos = class(TAbstractGravandoExecucaoSkyMixAutomotiva)
    public
      function fGetNomeGravacao: string; override;
      procedure Executar(const gravando: IGravando); override;
  End;


implementation

uses
  untIConfTinta, untStrUtils, untFuncoesGenerica;

{ TGravandoExecucaoSkyMixAutomotivaGrupos }

procedure TGravandoExecucaoSkyMixAutomotivaGrupos.Executar(const gravando: IGravando);
Var
  slArquivo    : TStringList;
  qryCadCor    : IDataSet;
  intCont      : integer;
  intProcesso  : Integer;
  slQuebra     : TStringList;
begin
  Try
    Try
      Gravando.Texto := 'Validando Arquivo de Geração...';

      If Not DirectoryExists(GetPath)  Then
      Begin
        gravando.Texto := 'Arquivo para a geração dos grupos não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      Gravando.Texto := 'Arquivo Validado com Sucesso ...';

      qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;
      Gravando.Texto := 'Deletando Registros SKY_CADGRU...';
      qryCadCor.Close;
      qryCadCor.SQL := '  DELETE FROM SKY_CADGRU    ';
      qryCadCor.ExecSQL;
      Gravando.Texto := 'Registros deletados com sucesso...';

      qryCadCor.SQL := '  SELECT * FROM SKY_CADGRU WHERE FALSE  ';
      qryCadCor.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SKY_CADGRU');
      Gravando.Texto := 'PROCOD verificado com sucesso!';
      Gravando.Texto := 'Iniciando Geração do Cadastro de Grupo...';

      slArquivo     := TStringList.Create;
      slQuebra      := TStringList.Create;

      slArquivo.LoadFromFile(GetPath + '\' + 'InfGrupo.txt');
      intProcesso := 0;

      For intCont := 0 To slArquivo.Count - 1 Do
      Begin
        If gravando.Status <> sgGravando Then
          Exit;

        slQuebra.Delimiter := '|';
        slQuebra.StrictDelimiter := True;
        slQuebra.DelimitedText := slArquivo[intCont];

        qryCadCor.Insert;
        qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SKY_CADGRU', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadCor.FieldByName('GRU_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadCor.FieldByName('GRU_CODGRU').AsString := Trim(slQuebra[0]);
        qryCadCor.FieldByName('GRU_VALIDA').AsString := Trim(slQuebra[4]);
        qryCadCor.FieldByName('GRU_LINHA_').AsString := Trim(slQuebra[1]);
        qryCadCor.FieldByName('GRU_MARCA_').AsString := Trim(slQuebra[2]);
        qryCadCor.FieldByName('GRU_QUANTI').AsFloat := StrToFloat(Trim(slQuebra[3]));
        qryCadCor.Post;

        Inc(intProcesso);
        Gravando.RegistrarProgresso(0, intProcesso, slArquivo.Count);
      End;

      FreeAndNil(slArquivo);
      FreeAndNil(slQuebra);

      Gravando.Texto := 'Deletando Registros SKY_CADSGR...';
      qryCadCor.Close;
      qryCadCor.SQL := '  DELETE FROM SKY_CADSGR    ';
      qryCadCor.ExecSQL;
      Gravando.Texto := 'Registros deletados com sucesso...';

      qryCadCor.SQL := '  SELECT * FROM SKY_CADSGR WHERE FALSE  ';
      qryCadCor.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SKY_CADSGR');
      Gravando.Texto := 'PROCOD verificado com sucesso!';
      Gravando.Texto := 'Iniciando Geração do Cadastro de SubGrupos...';

      slArquivo     := TStringList.Create;
      slQuebra      := TStringList.Create;

      slArquivo.LoadFromFile(GetPath + '\' + 'InfsGrupo.txt');
      intProcesso := 0;
      Gravando.RegistrarProgresso(0, 0, 0);

      For intCont := 0 To slArquivo.Count - 1 Do
      Begin
        If gravando.Status <> sgGravando Then
          Exit;

        slQuebra.Delimiter := '|';
        slQuebra.StrictDelimiter := True;
        slQuebra.DelimitedText := slArquivo[intCont];

        qryCadCor.Insert;
        qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SKY_CADSGR', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadCor.FieldByName('SGR_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadCor.FieldByName('SGR_CODSGR').AsString := Trim(slQuebra[1]);
        qryCadCor.FieldByName('SGR_ASPECT').AsString := Trim(slQuebra[0]);
        qryCadCor.Post;

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

function TGravandoExecucaoSkyMixAutomotivaGrupos.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Grupos e Subgrupos';
end;

end.
