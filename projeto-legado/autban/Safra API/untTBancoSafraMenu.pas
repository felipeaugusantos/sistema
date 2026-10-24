unit untTBancoSafraMenu;

interface

Uses System.Classes, System.SysUtils, Windows, Vcl.Forms, Vcl.Controls;

Type
  TBancoSafraMenu = class
  private
    class function ValidaArquivosNecessariosPelaAPI: Boolean;
  Public
    class procedure Configuracao;
    class procedure ImportacaoBoletosPagos;
    class procedure ImprimirBoletosImportados;

    class function CarteiraParaBaixa: Integer;
end;

implementation
Uses untFuncoesSimples, untConfigSafraAPI, untRetBcoAPI, untRelRetBco,untTBancoSafraAPI,
     untAlteraBoletoApi, untRetBco;

{ TBancoSafraMenu }

class function TBancoSafraMenu.CarteiraParaBaixa: Integer;
  Var
    LConfigSafraAPI : TfrmConfigSafraAPI ;
begin
  Result := 0;

  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigSafraAPI, LConfigSafraAPI);
    LConfigSafraAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigSafraAPI.btnGravar.Caption := '&OK';
    LConfigSafraAPI.blnNaoEditar      := True;
    LConfigSafraAPI.ShowModal;

    If LConfigSafraAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigSafraAPI);
      Exit;
    End;

    Result := LConfigSafraAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigSafraAPI);
  End;
end;

class procedure TBancoSafraMenu.Configuracao;
  Var
    LConfigSafraAPI : TfrmConfigSafraAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigSafraAPI, LConfigSafraAPI);
    LConfigSafraAPI.ShowModal;
  Finally
    FreeAndNil(LConfigSafraAPI);
  End;
end;

class procedure TBancoSafraMenu.ImportacaoBoletosPagos;
  Var
    LCarteira: Integer;

    LConfigSafraAPI : TfrmConfigSafraAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigSafraAPI, LConfigSafraAPI);
    LConfigSafraAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigSafraAPI.btnGravar.Caption := '&OK';
    LConfigSafraAPI.blnNaoEditar      := True;
    LConfigSafraAPI.ShowModal;

    If LConfigSafraAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigSafraAPI);
      Exit;
    End;

    LCarteira := LConfigSafraAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigSafraAPI);
  End;

  Try
    pCriarFormularios(TfrmRetBco,frmRetBco);
    frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 422 - Safra (API)';
    frmRetBco.strNomBanco      := '422 - Safra (API)';
    frmRetBco.intCartei  := LCarteira;
    frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG422API-' + IntToStr(LCarteira), 'PATHRET', '');
    frmRetBco.ShowModal;
  Finally
    FreeAndNil(frmRetBco);
  End;

end;

class procedure TBancoSafraMenu.ImprimirBoletosImportados;
  Var
    LRelRetBco : TfrmRelRetBco;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmRelRetBco,LRelRetBco);
    LRelRetBco.pnlTopo.Caption := 'Relatório de Retorno Banco - 422 - Banco Safra [Online]';
    LRelRetBco.strNomBanco     := '422 - Banco Safra [Online]';
    LRelRetBco.ATipoCnab       := 'API';
    LRelRetBco.ShowModal;
  Finally
    FreeAndNil(LRelRetBco);
  End;
end;

class function TBancoSafraMenu.ValidaArquivosNecessariosPelaAPI: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + 'ssleay32.dll');

  If Result Then
    Result := FileExists(ExtractFilePath(Application.ExeName) + 'libeay32.dll');

  If Not Result Then
    fMensagem('ATENÇÃO', 'Para a utilização do Banco Safra [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
end;

end.
