unit untTBancoSicrediMenu;

interface

Uses System.Classes, System.SysUtils, Windows, Vcl.Forms, Vcl.Controls;

Type
  TBancoSicrediMenu = class
  private
    class function ValidaArquivosNecessariosPelaAPI: Boolean;
  Public
    class procedure Configuracao;
    class procedure ImportacaoBoletosPagos;
    class procedure AlterarBoletosRegistrados;
    class procedure CancelarBoletosRegistrados;
    class procedure ImprimirBoletosImportados;

    class function CarteiraParaBaixa: Integer;
end;

implementation
Uses untFuncoesSimples, untConfigSicrediAPI, untRetBcoAPI, untRelRetBco,untTBancoSicrediAPI,
     untAlteraBoletoApi;
{ TBancoSicrediMenu }

class procedure TBancoSicrediMenu.CancelarBoletosRegistrados;
  Var
    LCarteira: Integer;

    LCancelaBoletoApi: TfrmAlteraBoletoApi;
    LConfigSicrediAPI : TfrmConfigSicrediAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigSicrediAPI, LConfigSicrediAPI);
    LConfigSicrediAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigSicrediAPI.btnGravar.Caption := '&OK';
    LConfigSicrediAPI.blnNaoEditar      := True;
    LConfigSicrediAPI.ShowModal;

    If LConfigSicrediAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigSicrediAPI);
      Exit;
    End;

    LCarteira := LConfigSicrediAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigSicrediAPI);
  End;

  Try
    pCriarFormularios(TfrmAlteraBoletoApi, LCancelaBoletoApi);
    LCancelaBoletoApi.NomeDoBanco      := '748 - Banco Sicredi [Online]';
    LCancelaBoletoApi.Carteira         := LCarteira;
    LCancelaBoletoApi.Configuracao     := 'CONFIG748API-';
    LCancelaBoletoApi.CodigoDoBanco    := '748';
    LCancelaBoletoApi.ObjetoBanco      := TBancoSicrediAPI.Create(Concat('CONFIG748API-',LCarteira.ToString,'-', VS_strCodEmp));
    LCancelaBoletoApi.pnlTopo.Caption  := 'Cancelamento de boletos registrados - 748 - Banco Sicredi [Online]';
    LCancelaBoletoApi.Cancelamento     := True;
    LCancelaBoletoApi.ShowModal;
  Finally
    FreeAndNil(LCancelaBoletoApi);
  End;
end;

class procedure TBancoSicrediMenu.AlterarBoletosRegistrados;
  Var
    LCarteira: Integer;

    LAlteraBoletoApi: TfrmAlteraBoletoApi;
    LConfigSicrediAPI : TfrmConfigSicrediAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigSicrediAPI, LConfigSicrediAPI);
    LConfigSicrediAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigSicrediAPI.btnGravar.Caption := '&OK';
    LConfigSicrediAPI.blnNaoEditar      := True;
    LConfigSicrediAPI.ShowModal;

    If LConfigSicrediAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigSicrediAPI);
      Exit;
    End;

    LCarteira := LConfigSicrediAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigSicrediAPI);
  End;

  Try
    pCriarFormularios(TfrmAlteraBoletoApi, LAlteraBoletoApi);
    LAlteraBoletoApi.NomeDoBanco      := '748 - Banco Sicredi [Online]';
    LAlteraBoletoApi.Carteira         := LCarteira;
    LAlteraBoletoApi.Configuracao     := 'CONFIG748API-';
    LAlteraBoletoApi.CodigoDoBanco    := '748';
    LAlteraBoletoApi.ObjetoBanco := TBancoSicrediAPI.Create(Concat('CONFIG748API-', LCarteira.ToString, '-', VS_strCodEmp));
    LAlteraBoletoApi.pnlTopo.Caption  := 'Alteração de boletos registrados - 748 - Banco Sicredi [Online]';
    LAlteraBoletoApi.Cancelamento     := False;
    LAlteraBoletoApi.ShowModal;
  Finally
    FreeAndNil(LAlteraBoletoApi);
  End;
end;

class function TBancoSicrediMenu.CarteiraParaBaixa: Integer;
  Var
    LConfigSicrediAPI : TfrmConfigSicrediAPI ;
begin
  Result := 0;

  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigSicrediAPI, LConfigSicrediAPI);
    LConfigSicrediAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigSicrediAPI.btnGravar.Caption := '&OK';
    LConfigSicrediAPI.blnNaoEditar      := True;
    LConfigSicrediAPI.ShowModal;

    If LConfigSicrediAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigSicrediAPI);
      Exit;
    End;

    Result := LConfigSicrediAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigSicrediAPI);
  End;
end;

class procedure TBancoSicrediMenu.Configuracao;
  Var
    LConfigSicrediAPI : TfrmConfigSicrediAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigSicrediAPI, LConfigSicrediAPI);
    LConfigSicrediAPI.ShowModal;
  Finally
    FreeAndNil(LConfigSicrediAPI);
  End;
end;

class procedure TBancoSicrediMenu.ImportacaoBoletosPagos;
  Var
    LCarteira: Integer;

    LRetBcoAPI: TfrmRetBcoAPI;
    LConfigSicrediAPI : TfrmConfigSicrediAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigSicrediAPI, LConfigSicrediAPI);
    LConfigSicrediAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigSicrediAPI.btnGravar.Caption := '&OK';
    LConfigSicrediAPI.blnNaoEditar      := True;
    LConfigSicrediAPI.ShowModal;

    If LConfigSicrediAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigSicrediAPI);
      Exit;
    End;

    LCarteira := LConfigSicrediAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigSicrediAPI);
  End;

  Try
    pCriarFormularios(TfrmRetBcoAPI, LRetBcoAPI);
    LRetBcoAPI.NomeDoBanco      := '748 - Banco Sicredi [Online]';
    LRetBcoAPI.Carteira         := LCarteira;
    LRetBcoAPI.Configuracao     := 'CONFIG748API-';
    LRetBcoAPI.CodigoDoBanco    := '748';
    LRetBcoAPI.ObjetoImportacao := TBancoSicrediAPI.Create(Concat('CONFIG748API-', LCarteira.ToString, '-', VS_strCodEmp));
    LRetBcoAPI.pnlTopo.Caption  := 'Importação Boletos Pagos - 748 - Banco Sicredi [Online]';
    LRetBcoAPI.ShowModal;
  Finally
    FreeAndNil(LRetBcoAPI);
  End;
end;

class procedure TBancoSicrediMenu.ImprimirBoletosImportados;
  Var
    LRelRetBco : TfrmRelRetBco;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmRelRetBco,LRelRetBco);
    LRelRetBco.pnlTopo.Caption := 'Relatório de Retorno Banco - 748 - Banco Sicredi [Online]';
    LRelRetBco.strNomBanco     := '748 - Banco Sicredi [Online]';
    LRelRetBco.ATipoCnab       := 'API';
    LRelRetBco.ShowModal;
  Finally
    FreeAndNil(LRelRetBco);
  End;
end;

class function TBancoSicrediMenu.ValidaArquivosNecessariosPelaAPI: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + 'ssleay32.dll');

  If Result Then
    Result := FileExists(ExtractFilePath(Application.ExeName) + 'libeay32.dll');

  If Not Result Then
    fMensagem('ATENÇÃO', 'Para a utilização do Banco Sicredi [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
end;

end.
