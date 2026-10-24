unit untTBancoSantanderMenu;

interface

Uses System.Classes, System.SysUtils, Windows, Vcl.Forms, Vcl.Controls,
     Vcl.ComCtrls;

Type
  TBancoSantanderMenu = class
  private
    class function ValidaArquivosNecessariosPelaAPI: Boolean;
  Public
    class procedure Configuracao;
    class procedure ImportacaoBoletosPagos;
    class procedure ImprimirBoletosImportados;
    class procedure CancelarBoletosRegistrados;

    class function CarteiraParaBaixa: Integer;
end;

implementation
Uses untFuncoesSimples, untConfigSantanderAPI, untRetBcoAPI, untRelRetBco,
     untTBancoSantanderAPI, untAlteraBoletoApi;

{ TBancoSantanderMenu }

class procedure TBancoSantanderMenu.CancelarBoletosRegistrados;
  Var
    LCarteira: Integer;

    LCancelaBoletoApi: TfrmAlteraBoletoApi;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  LCarteira := CarteiraParaBaixa;

  If LCarteira = 0 Then
    Exit;

  Try
    pCriarFormularios(TfrmAlteraBoletoApi, LCancelaBoletoApi);
    LCancelaBoletoApi.NomeDoBanco      := '033 - Banco Santander [Online]';
    LCancelaBoletoApi.Carteira         := LCarteira;
    LCancelaBoletoApi.Configuracao     := 'CONFIG033API-';
    LCancelaBoletoApi.CodigoDoBanco    := '033';
    LCancelaBoletoApi.ObjetoBanco      := TBancoSantanderAPI.Create(Concat('CONFIG033API-', LCarteira.ToString, '-', VS_strCodEmp));
    LCancelaBoletoApi.pnlTopo.Caption  := 'Cancelamento de boletos registrados - 033 - Banco Santander [Online]';
    LCancelaBoletoApi.Cancelamento     := True;
    LCancelaBoletoApi.ShowModal;
  Finally
    FreeAndNil(LCancelaBoletoApi);
  End;
end;

class function TBancoSantanderMenu.CarteiraParaBaixa: Integer;
  Var
    LConfigSantanderAPI: TfrmConfigSantanderAPI;
begin
  Result := 0;

  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigSantanderAPI, LConfigSantanderAPI);
    LConfigSantanderAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigSantanderAPI.btnGravar.Caption := '&OK';
    LConfigSantanderAPI.blnNaoEditar      := True;
    LConfigSantanderAPI.ShowModal;

    If LConfigSantanderAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigSantanderAPI);
      Exit;
    End;

    Result := LConfigSantanderAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigSantanderAPI);
  End;
end;

class procedure TBancoSantanderMenu.Configuracao;
  Var
    LConfigSantanderAPI : TfrmConfigSantanderAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigSantanderAPI, LConfigSantanderAPI);
    LConfigSantanderAPI.ShowModal;
  Finally
    FreeAndNil(LConfigSantanderAPI);
  End;
end;

class procedure TBancoSantanderMenu.ImportacaoBoletosPagos;
  Var
    LCarteira: Integer;

    LRetBcoAPI: TfrmRetBcoAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  LCarteira := CarteiraParaBaixa;

  If LCarteira = 0 Then
    Exit;

  Try
    pCriarFormularios(TfrmRetBcoAPI, LRetBcoAPI);
    LRetBcoAPI.NomeDoBanco      := '033 - Banco Santander [Online]';
    LRetBcoAPI.Carteira         := LCarteira;
    LRetBcoAPI.Configuracao     := 'CONFIG033API-';
    LRetBcoAPI.CodigoDoBanco    := '033';
    LRetBcoAPI.ObjetoImportacao := TBancoSantanderAPI.Create(Concat('CONFIG033API-', LCarteira.ToString, '-', VS_strCodEmp));
    LRetBcoAPI.pnlTopo.Caption  := 'Importação Boletos Pagos - 033 - Banco Santander [Online]';
    LRetBcoAPI.ShowModal;
  Finally
    FreeAndNil(LRetBcoAPI);
  End;
end;

class procedure TBancoSantanderMenu.ImprimirBoletosImportados;
  Var
    LRelRetBco : TfrmRelRetBco;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmRelRetBco,LRelRetBco);
    LRelRetBco.pnlTopo.Caption := 'Relatório de Retorno Banco - 033 - Banco Santander [Online]';
    LRelRetBco.strNomBanco     := '033 - Banco Santander [Online]';
    LRelRetBco.ATipoCnab       := 'API';
    LRelRetBco.ShowModal;
  Finally
    FreeAndNil(LRelRetBco);
  End;
end;

class function TBancoSantanderMenu.ValidaArquivosNecessariosPelaAPI: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + 'ssleay32.dll');

  If Result Then
    Result := FileExists(ExtractFilePath(Application.ExeName) + 'libeay32.dll');

  If Not Result Then
    fMensagem('ATENÇÃO', 'Para a utilização do Banco Santander [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
end;

end.
