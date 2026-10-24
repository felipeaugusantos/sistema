unit untTItauMenu;

interface

Uses System.Classes, System.SysUtils, Windows, Vcl.Forms, Vcl.Controls,
     Vcl.ComCtrls;

Type
  TItauMenu = class
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
Uses untFuncoesSimples, untConfigItauAPI, untRetBcoAPI, untRelRetBco,
     untTBancoItauAPI, untAlteraBoletoApi;
{ TItauMenu }

class procedure TItauMenu.CancelarBoletosRegistrados;
  Var
    LCarteira: Integer;

    LCancelaBoletoApi: TfrmAlteraBoletoApi;

    LConfigItauAPI : TfrmConfigItauAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigItauAPI, LConfigItauAPI);
    LConfigItauAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigItauAPI.btnGravar.Caption := '&OK';
    LConfigItauAPI.blnNaoEditar      := True;
    LConfigItauAPI.ShowModal;

    If LConfigItauAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigItauAPI);
      Exit;
    End;

    LCarteira := LConfigItauAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigItauAPI);
  End;

  Try
    pCriarFormularios(TfrmAlteraBoletoApi, LCancelaBoletoApi);
    LCancelaBoletoApi.NomeDoBanco      := '341 - Banco do Brasil [Online]';
    LCancelaBoletoApi.Carteira         := LCarteira;
    LCancelaBoletoApi.Configuracao     := 'CONFIG341API-';
    LCancelaBoletoApi.CodigoDoBanco    := '341';
    LCancelaBoletoApi.ObjetoBanco      := TBancoItauAPI.Create(Concat('CONFIG341API-', LCarteira.ToString, '-', VS_strCodEmp));
    LCancelaBoletoApi.pnlTopo.Caption  := 'Cancelamento de boletos registrados - 341 - Banco Itaú [Online]';
    LCancelaBoletoApi.Cancelamento     := True;
    LCancelaBoletoApi.ShowModal;
  Finally
    FreeAndNil(LCancelaBoletoApi);
  End;
end;

class function TItauMenu.CarteiraParaBaixa: Integer;
  Var
    LConfigItauAPI : TfrmConfigItauAPI ;
begin
  Result := 0;

  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigItauAPI, LConfigItauAPI);
    LConfigItauAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigItauAPI.btnGravar.Caption := '&OK';
    LConfigItauAPI.blnNaoEditar      := True;
    LConfigItauAPI.ShowModal;

    If LConfigItauAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigItauAPI);
      Exit;
    End;

    Result := LConfigItauAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigItauAPI);
  End;
end;

class procedure TItauMenu.Configuracao;
  Var
    LConfigItauAPI : TfrmConfigItauAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigItauAPI, LConfigItauAPI);
    LConfigItauAPI.ShowModal;
  Finally
    FreeAndNil(LConfigItauAPI);
  End;
end;

class procedure TItauMenu.ImportacaoBoletosPagos;
  Var
    LCarteira: Integer;

    LRetBcoAPI: TfrmRetBcoAPI;
    LConfigItauAPI : TfrmConfigItauAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigItauAPI, LConfigItauAPI);
    LConfigItauAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigItauAPI.btnGravar.Caption := '&OK';
    LConfigItauAPI.blnNaoEditar      := True;
    LConfigItauAPI.ShowModal;

    If LConfigItauAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigItauAPI);
      Exit;
    End;

    LCarteira := LConfigItauAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigItauAPI);
  End;

  Try
    pCriarFormularios(TfrmRetBcoAPI, LRetBcoAPI);
    LRetBcoAPI.NomeDoBanco      := '341 - Banco Itaú [Online]';
    LRetBcoAPI.Carteira         := LCarteira;
    LRetBcoAPI.Configuracao     := 'CONFIG341API-';
    LRetBcoAPI.CodigoDoBanco    := '341';
    LRetBcoAPI.ObjetoImportacao := TBancoItauAPI.Create(Concat('CONFIG341API-', LCarteira.ToString, '-', VS_strCodEmp));
    LRetBcoAPI.pnlTopo.Caption  := 'Importação Boletos Pagos - 341 - Banco Itaú [Online]';
    LRetBcoAPI.ShowModal;
  Finally
    FreeAndNil(LRetBcoAPI);
  End;
end;

class procedure TItauMenu.ImprimirBoletosImportados;
  Var
    LRelRetBco : TfrmRelRetBco;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmRelRetBco,LRelRetBco);
    LRelRetBco.pnlTopo.Caption := 'Relatório de Retorno Banco - 341 - Banco Itaú [Online]';
    LRelRetBco.strNomBanco     := '341 - Banco Itaú [Online]';
    LRelRetBco.ATipoCnab       := 'API';
    LRelRetBco.ShowModal;
  Finally
    FreeAndNil(LRelRetBco);
  End;
end;

class function TItauMenu.ValidaArquivosNecessariosPelaAPI: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + 'ssleay32.dll');

  If Result Then
    Result := FileExists(ExtractFilePath(Application.ExeName) + 'libeay32.dll');

  If Not Result Then
    fMensagem('ATENÇÃO', 'Para a utilização do Banco Itaú [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
end;

end.
