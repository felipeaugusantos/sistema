unit untTBancoSicoobMenu;

interface

Uses System.Classes, System.SysUtils, Windows, Vcl.Forms, Vcl.Controls,
     Vcl.ComCtrls;

Type
  TBancoSicoobMenu = class
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
Uses untFuncoesSimples, untConfigSicoobAPI, untRetBcoAPI, untRelRetBco,
     untTBancoSicoobAPI, untAlteraBoletoApi;

{ TBancoSicoobMenu }

class procedure TBancoSicoobMenu.CancelarBoletosRegistrados;
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
    LCancelaBoletoApi.NomeDoBanco      := '756 - Banco Sicoob [Online]';
    LCancelaBoletoApi.Carteira         := LCarteira;
    LCancelaBoletoApi.Configuracao     := 'CONFIG756API-';
    LCancelaBoletoApi.CodigoDoBanco    := '756';
    LCancelaBoletoApi.ObjetoBanco      := TBancoSicoobAPI.Create(Concat('CONFIG756API-', LCarteira.ToString, '-', VS_strCodEmp));
    LCancelaBoletoApi.pnlTopo.Caption  := 'Cancelamento de boletos registrados - 756 - Banco Sicoob [Online]';
    LCancelaBoletoApi.Cancelamento     := True;
    LCancelaBoletoApi.ShowModal;
  Finally
    FreeAndNil(LCancelaBoletoApi);
  End;
end;

class function TBancoSicoobMenu.CarteiraParaBaixa: Integer;
  Var
    LConfigSicoobAPI: TfrmConfigSicoobAPI;
begin
  Result := 0;

  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigSicoobAPI, LConfigSicoobAPI);
    LConfigSicoobAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigSicoobAPI.btnGravar.Caption := '&OK';
    LConfigSicoobAPI.blnNaoEditar      := True;
    LConfigSicoobAPI.ShowModal;

    If LConfigSicoobAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigSicoobAPI);
      Exit;
    End;

    Result := LConfigSicoobAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigSicoobAPI);
  End;
end;

class procedure TBancoSicoobMenu.Configuracao;
  Var
    LConfigSicoobAPI : TfrmConfigSicoobAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigSicoobAPI, LConfigSicoobAPI);
    LConfigSicoobAPI.ShowModal;
  Finally
    FreeAndNil(LConfigSicoobAPI);
  End;
end;

class procedure TBancoSicoobMenu.ImportacaoBoletosPagos;
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
    LRetBcoAPI.NomeDoBanco      := '756 - Banco Sicoob [Online]';
    LRetBcoAPI.Carteira         := LCarteira;
    LRetBcoAPI.Configuracao     := 'CONFIG756API-';
    LRetBcoAPI.CodigoDoBanco    := '756';
    LRetBcoAPI.ObjetoImportacao := TBancoSicoobAPI.Create(Concat('CONFIG756API-', LCarteira.ToString, '-', VS_strCodEmp));
    LRetBcoAPI.pnlTopo.Caption  := 'Importação Boletos Pagos - 756 - Banco Sicoob [Online]';
    LRetBcoAPI.ShowModal;
  Finally
    FreeAndNil(LRetBcoAPI);
  End;
end;

class procedure TBancoSicoobMenu.ImprimirBoletosImportados;
  Var
    LRelRetBco : TfrmRelRetBco;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmRelRetBco,LRelRetBco);
    LRelRetBco.pnlTopo.Caption := 'Relatório de Retorno Banco - 756 - Banco Sicoob [Online]';
    LRelRetBco.strNomBanco     := '756 - Banco Sicoob [Online]';
    LRelRetBco.ATipoCnab       := 'API';
    LRelRetBco.ShowModal;
  Finally
    FreeAndNil(LRelRetBco);
  End;
end;

class function TBancoSicoobMenu.ValidaArquivosNecessariosPelaAPI: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + 'ssleay32.dll');

  If Result Then
    Result := FileExists(ExtractFilePath(Application.ExeName) + 'libeay32.dll');

  If Not Result Then
    fMensagem('ATENÇÃO', 'Para a utilização do Banco Sicoob [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
end;

end.
