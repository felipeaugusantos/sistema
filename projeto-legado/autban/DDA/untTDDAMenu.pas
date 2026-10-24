unit untTDDAMenu;

interface

Uses System.Classes, System.SysUtils, Windows, Vcl.Forms, Vcl.Controls,
untConfigCtaDDA, untFuncoesSimples, untRetDDAAPI, untCtaCadDupDDA, untCtaAtuDupDDA,
untCtaRelDupDDA;

Type
  TDDAMenu = class
  private
    class function ValidaArquivosNecessariosPelaAPI(ACodigoBanco: string):
    Boolean;

    class function RetornaDescricaoBanco(ACodigoBanco: string;
                                         ABancoAPI: Boolean): string;
  public
    class procedure Configuracao(ACodigoBanco,
                                 AConfig: string;
                                 ABancoAPI: Boolean);

    class procedure ImportarBoletosApi(ACodigoBanco: String);

    class procedure RelatorioDuplicatasDDA( ACodigoBanco: string;
                                            ABancoAPI: Boolean);

    class procedure AtualizarDuplicataDDASicoob( ACodigoBanco: string;
                                                 ABancoAPI: Boolean);

    class procedure CadastroDuplicataDDANaoIdentificadas( ACodigoBanco: string;
                                                      ABancoAPI: Boolean);
end;

  Const
    CODBANCOSICOOB = '756';


implementation

{ TDDAMenu }

class procedure TDDAMenu.AtualizarDuplicataDDASicoob(ACodigoBanco: string;
  ABancoAPI: Boolean);
var
  LCtaAtuDupDDA: TfrmCtaAtuDupDDA;
begin
  if ABancoAPI Then
  begin
    try
      pCriarFormularios(TfrmCtaAtuDupDDA, LCtaAtuDupDDA);
      LCtaAtuDupDDA.pnlTopo.Caption := 'Atualização de Dados de Duplicatas Encontradas DDA - 756 - Sicoob';
      LCtaAtuDupDDA.strConfig := 'CONFIGDDA756API';
      LCtaAtuDupDDA.strCodBco := CODBANCOSICOOB;
      LCtaAtuDupDDA.ShowModal;
    finally
      FreeAndNil(LCtaAtuDupDDA);
    end;
  end;
end;

class procedure TDDAMenu.CadastroDuplicataDDANaoIdentificadas(ACodigoBanco: string;
ABancoAPI: Boolean);
var
  LConfigCtaDDA: TfrmConfigCtaDDA;
  LCtaCadDupDDA: TfrmCtaCadDupDDA;
  LCarteira: Integer;
  LConfirma: Boolean;
begin
  if ABancoAPI Then
  begin
    try
      pCriarFormularios(TfrmConfigCtaDDA, LConfigCtaDDA);
      LConfigCtaDDA.pnlTopo.Caption   := 'Selecione a Conta DDA - 756 - Sicoob Online';
      LConfigCtaDDA.btnGravar.Caption := '&OK';
      LConfigCtaDDA.strConfig         := 'CONFIGDDA756API';
      LConfigCtaDDA.blnNaoEditar      := True;
      LConfigCtaDDA.BancoAPI          := ABancoAPI;
      LConfigCtaDDA.ShowModal;
      LCarteira := LConfigCtaDDA.tabContas.TabIndex + 1;
    finally
      LConfirma := False;
      if LConfigCtaDDA.ModalResult = mrOK then
        LConfirma := True;
      FreeAndNil(LConfigCtaDDA);
    end;

    if LConfirma Then
    begin
      try
        pCriarFormularios(TfrmCtaCadDupDDA, LCtaCadDupDDA);
        LCtaCadDupDDA.pnlTopo.Caption := 'Cadastro de Duplicatas não Identificadas DDA - 756 - Sicoob Online';
        LCtaCadDupDDA.strConfig := 'CONFIGDDA756API-' + InttoStr(LCarteira);
        LCtaCadDupDDA.ShowModal;
      finally
        FreeAndNil(LCtaCadDupDDA);
      end;
    end;
  end;
end;

class procedure TDDAMenu.Configuracao(ACodigoBanco, AConfig: string;
  ABancoAPI: Boolean);
var
  LConfigCtaDDA: TfrmConfigCtaDDA;
begin
  if ABancoAPI Then
  begin
    if not ValidaArquivosNecessariosPelaAPI(ACodigoBanco) then
      Exit;
  end;
  try
    pCriarFormularios(TfrmConfigCtaDDA, LConfigCtaDDA);

    LConfigCtaDDA.pnlTopo.Caption := 'Configuração de Contas Correntes - DDA - '
      + RetornaDescricaoBanco(ACodigoBanco, ABancoAPI);
    LConfigCtaDDA.strConfig := AConfig;
    LConfigCtaDDA.strCodBco := ACodigoBanco;
    LConfigCtaDDA.BancoAPI := ABancoAPI;
    LConfigCtaDDA.ShowModal;
  finally
    FreeAndNil(LConfigCtaDDA);
  end;
end;

class procedure TDDAMenu.ImportarBoletosApi(ACodigoBanco: String);
var
  LConfigDDA: TfrmConfigCtaDDA;
  LRetDDAAPI: TfrmRetDDAAPI;
  LCarteira: Integer;
begin
  if not ValidaArquivosNecessariosPelaAPI(ACodigoBanco) then
    Exit;

  LCarteira := 1;

  try
    pCriarFormularios(TfrmConfigCtaDDA, LConfigDDA);
    try
      LConfigDDA.pnlTopo.Caption :=
        'Selecione a Conta DDA - ' +
          RetornaDescricaoBanco(ACodigoBanco, True);
      LConfigDDA.strConfig := 'CONFIGCTAAPI' + ACodigoBanco;
      LConfigDDA.btnGravar.Caption := '&OK';
      LConfigDDA.strCodBco := ACodigoBanco;
      LConfigDDA.BancoAPI := True;
      LConfigDDA.blnNaoEditar := True;
      LConfigDDA.ShowModal;

      LCarteira := LConfigDDA.tabContas.TabIndex + 1;

      if LConfigDDA.ModalResult <> mrOk Then
        Exit;
    finally
      FreeAndNil(LConfigDDA);
    end;

    pCriarFormularios(TfrmRetDDAAPI, LRetDDAAPI);
    try
      LRetDDAAPI.ImportacaoAPI := True;
      LRetDDAAPI.Configuracao :=
        'CONFIGCTAAPI' + ACodigoBanco + '-' + LCarteira.ToString;
      LRetDDAAPI.CodBanco := ACodigoBanco;
      LRetDDAAPI.Caption := 'Importação de Boletos - DDA Online - ' +
        RetornaDescricaoBanco(ACodigoBanco, True);
      LRetDDAAPI.ShowModal;
    finally
      FreeAndNil(LRetDDAAPI);
    End;
  except
    on E: Exception do
      pMensagensErro(
        E.Message,
        '[TPagDDAMenu.ImportarBoletosApi]'
      );
  end;
end;

class procedure TDDAMenu.RelatorioDuplicatasDDA(ACodigoBanco: string;
  ABancoAPI: Boolean);
var
  LRelDupDDA: TfrmCtaRelDupDDA;
begin
  if ABancoAPI Then
  begin
    try
      pCriarFormularios(TfrmCtaRelDupDDA, LRelDupDDA);
      LRelDupDDA.pnlTopo.Caption  := 'Relatório de Arq. Retorno DDA - 756 - Sicoob';
      LRelDupDDA.strConfig := 'CONFIGDDA756API';
      LRelDupDDA.ShowModal;
    finally
      FreeAndNil(LRelDupDDA);
    end;
  end;
end;

class function TDDAMenu.RetornaDescricaoBanco(ACodigoBanco: string;
  ABancoAPI: Boolean): string;
begin
  Result := EmptyStr;

  if ACodigoBanco = CODBANCOSICOOB then
   Result := '756 - Sicoob ';

  if ABancoAPI then
    Result := Result + '[Online]';
end;

class function TDDAMenu.ValidaArquivosNecessariosPelaAPI(
  ACodigoBanco: string): Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + 'ssleay32.dll');

  If Result Then
    Result := FileExists(ExtractFilePath(Application.ExeName) + 'libeay32.dll');

  If Not Result Then
  begin
    if AcodigoBanco = CODBANCOSICOOB then
      fMensagem(
        'ATENÇÃO', 'Para a utilização do Banco Sicoob DDA '+
        '[Online], é necessário possuir os arquivos ssleay32.dll e '+
        'libeay32.dll na pasta do Autban.', ['&OK']);
  end;
end;

end.
