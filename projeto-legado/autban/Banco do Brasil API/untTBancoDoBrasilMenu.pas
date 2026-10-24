unit untTBancoDoBrasilMenu;

interface

Uses System.Classes, System.SysUtils, Windows, Vcl.Forms, Vcl.Controls;

Type
  TBancoDoBrasilMenu = class
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
Uses untFuncoesSimples, untConfigBancoDoBrasilAPI, untRetBcoAPI, untRelRetBco,untTBancoDoBrasilAPI,
     untAlteraBoletoApi;
{ TBancoDoBrasilMenu }

class procedure TBancoDoBrasilMenu.CancelarBoletosRegistrados;
  Var
    LCarteira: Integer;

    LCancelaBoletoApi: TfrmAlteraBoletoApi;
    LConfigBancoDoBrasilAPI : TfrmConfigBancoDoBrasilAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigBancoDoBrasilAPI, LConfigBancoDoBrasilAPI);
    LConfigBancoDoBrasilAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigBancoDoBrasilAPI.btnGravar.Caption := '&OK';
    LConfigBancoDoBrasilAPI.blnNaoEditar      := True;
    LConfigBancoDoBrasilAPI.ShowModal;

    If LConfigBancoDoBrasilAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigBancoDoBrasilAPI);
      Exit;
    End;

    LCarteira := LConfigBancoDoBrasilAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigBancoDoBrasilAPI);
  End;

  Try
    pCriarFormularios(TfrmAlteraBoletoApi, LCancelaBoletoApi);
    LCancelaBoletoApi.NomeDoBanco      := '001 - Banco do Brasil [Online]';
    LCancelaBoletoApi.Carteira         := LCarteira;
    LCancelaBoletoApi.Configuracao     := 'CONFIG001API-';
    LCancelaBoletoApi.CodigoDoBanco    := '001';
    LCancelaBoletoApi.ObjetoBanco      := TBancoDoBrasilAPI.Create(Concat('CONFIG001API-',LCarteira.ToString,'-', VS_strCodEmp));
    LCancelaBoletoApi.pnlTopo.Caption  := 'Cancelamento de boletos registrados - 001 - Banco do Brasil [Online]';
    LCancelaBoletoApi.Cancelamento     := True;
    LCancelaBoletoApi.ShowModal;
  Finally
    FreeAndNil(LCancelaBoletoApi);
  End;
end;

class procedure TBancoDoBrasilMenu.AlterarBoletosRegistrados;
  Var
    LCarteira: Integer;

    LAlteraBoletoApi: TfrmAlteraBoletoApi;
    LConfigBancoDoBrasilAPI : TfrmConfigBancoDoBrasilAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigBancoDoBrasilAPI, LConfigBancoDoBrasilAPI);
    LConfigBancoDoBrasilAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigBancoDoBrasilAPI.btnGravar.Caption := '&OK';
    LConfigBancoDoBrasilAPI.blnNaoEditar      := True;
    LConfigBancoDoBrasilAPI.ShowModal;

    If LConfigBancoDoBrasilAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigBancoDoBrasilAPI);
      Exit;
    End;

    LCarteira := LConfigBancoDoBrasilAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigBancoDoBrasilAPI);
  End;

  Try
    pCriarFormularios(TfrmAlteraBoletoApi, LAlteraBoletoApi);
    LAlteraBoletoApi.NomeDoBanco      := '001 - Banco do Brasil [Online]';
    LAlteraBoletoApi.Carteira         := LCarteira;
    LAlteraBoletoApi.Configuracao     := 'CONFIG001API-';
    LAlteraBoletoApi.CodigoDoBanco    := '001';
    LAlteraBoletoApi.ObjetoBanco := TBancoDoBrasilAPI.Create(Concat('CONFIG001API-', LCarteira.ToString, '-', VS_strCodEmp));
    LAlteraBoletoApi.pnlTopo.Caption  := 'Alteração de boletos registrados - 001 - Banco do Brasil [Online]';
    LAlteraBoletoApi.Cancelamento     := False;
    LAlteraBoletoApi.ShowModal;
  Finally
    FreeAndNil(LAlteraBoletoApi);
  End;
end;

class function TBancoDoBrasilMenu.CarteiraParaBaixa: Integer;
  Var
    LConfigBancoDoBrasilAPI : TfrmConfigBancoDoBrasilAPI ;
begin
  Result := 0;

  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigBancoDoBrasilAPI, LConfigBancoDoBrasilAPI);
    LConfigBancoDoBrasilAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigBancoDoBrasilAPI.btnGravar.Caption := '&OK';
    LConfigBancoDoBrasilAPI.blnNaoEditar      := True;
    LConfigBancoDoBrasilAPI.ShowModal;

    If LConfigBancoDoBrasilAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigBancoDoBrasilAPI);
      Exit;
    End;

    Result := LConfigBancoDoBrasilAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigBancoDoBrasilAPI);
  End;
end;

class procedure TBancoDoBrasilMenu.Configuracao;
  Var
    LConfigBancoDoBrasilAPI : TfrmConfigBancoDoBrasilAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigBancoDoBrasilAPI, LConfigBancoDoBrasilAPI);
    LConfigBancoDoBrasilAPI.ShowModal;
  Finally
    FreeAndNil(LConfigBancoDoBrasilAPI);
  End;
end;

class procedure TBancoDoBrasilMenu.ImportacaoBoletosPagos;
  Var
    LCarteira: Integer;

    LRetBcoAPI: TfrmRetBcoAPI;
    LConfigBancoDoBrasilAPI : TfrmConfigBancoDoBrasilAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigBancoDoBrasilAPI, LConfigBancoDoBrasilAPI);
    LConfigBancoDoBrasilAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigBancoDoBrasilAPI.btnGravar.Caption := '&OK';
    LConfigBancoDoBrasilAPI.blnNaoEditar      := True;
    LConfigBancoDoBrasilAPI.ShowModal;

    If LConfigBancoDoBrasilAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigBancoDoBrasilAPI);
      Exit;
    End;

    LCarteira := LConfigBancoDoBrasilAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigBancoDoBrasilAPI);
  End;

  Try
    pCriarFormularios(TfrmRetBcoAPI, LRetBcoAPI);
    LRetBcoAPI.NomeDoBanco      := '001 - Banco do Brasil [Online]';
    LRetBcoAPI.Carteira         := LCarteira;
    LRetBcoAPI.Configuracao     := 'CONFIG001API-';
    LRetBcoAPI.CodigoDoBanco    := '001';
    LRetBcoAPI.ObjetoImportacao := TBancoDoBrasilAPI.Create(Concat('CONFIG001API-', LCarteira.ToString, '-', VS_strCodEmp));
    LRetBcoAPI.pnlTopo.Caption  := 'Importação Boletos Pagos - 001 - Banco do Brasil [Online]';
    LRetBcoAPI.ShowModal;
  Finally
    FreeAndNil(LRetBcoAPI);
  End;
end;

class procedure TBancoDoBrasilMenu.ImprimirBoletosImportados;
  Var
    LRelRetBco : TfrmRelRetBco;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmRelRetBco,LRelRetBco);
    LRelRetBco.pnlTopo.Caption := 'Relatório de Retorno Banco - 001 - Banco do Brasil [Online]';
    LRelRetBco.strNomBanco     := '001 - Banco do Brasil [Online]';
    LRelRetBco.ATipoCnab       := 'API';
    LRelRetBco.ShowModal;
  Finally
    FreeAndNil(LRelRetBco);
  End;
end;

class function TBancoDoBrasilMenu.ValidaArquivosNecessariosPelaAPI: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + 'ssleay32.dll');

  If Result Then
    Result := FileExists(ExtractFilePath(Application.ExeName) + 'libeay32.dll');

  If Not Result Then
    fMensagem('ATENÇÃO', 'Para a utilização do Banco do Brasil [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
end;

end.
