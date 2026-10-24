unit untTBancoCredisisMenu;

interface

Uses System.Classes, System.SysUtils, Windows, Vcl.Forms, Vcl.Controls;

Type
  TBancoCredisisMenu = class
  private
    class function ValidaArquivosNecessariosPelaAPI: Boolean;
  Public
    class procedure Configuracao;
    class procedure ImportacaoBoletosPagos;
    class procedure ImprimirBoletosImportados;

    class function CarteiraParaBaixa: Integer;
end;

implementation
Uses untFuncoesSimples, untConfigCredisisAPI, untRetBcoAPI, untRelRetBco, untTBancoCredisisAPI;
{ TBancoCredisisMenu }

class function TBancoCredisisMenu.CarteiraParaBaixa: Integer;
  Var
    LConfigBancoCredisisAPI : TfrmConfigCredisisAPI;
begin
  Result := 0;

  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigCredisisAPI, LConfigBancoCredisisAPI);
    LConfigBancoCredisisAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigBancoCredisisAPI.btnGravar.Caption := '&OK';
    LConfigBancoCredisisAPI.blnNaoEditar      := True;
    LConfigBancoCredisisAPI.ShowModal;

    If LConfigBancoCredisisAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigBancoCredisisAPI);
      Exit;
    End;

    Result := LConfigBancoCredisisAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigBancoCredisisAPI);
  End;
end;

class procedure TBancoCredisisMenu.Configuracao;
  Var
    LConfigBancoCredisisAPI : TfrmConfigCredisisAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigCredisisAPI, LConfigBancoCredisisAPI);
    LConfigBancoCredisisAPI.ShowModal;
  Finally
    FreeAndNil(LConfigBancoCredisisAPI);
  End;
end;

class procedure TBancoCredisisMenu.ImportacaoBoletosPagos;
  Var
    LCarteira: Integer;

    LRetBcoAPI: TfrmRetBcoAPI;
    LConfigBancoCredisisAPI : TfrmConfigCredisisAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigCredisisAPI, LConfigBancoCredisisAPI);
    LConfigBancoCredisisAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigBancoCredisisAPI.btnGravar.Caption := '&OK';
    LConfigBancoCredisisAPI.blnNaoEditar      := True;
    LConfigBancoCredisisAPI.ShowModal;

    If LConfigBancoCredisisAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigBancoCredisisAPI);
      Exit;
    End;

    LCarteira := LConfigBancoCredisisAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigBancoCredisisAPI);
  End;

  Try
    pCriarFormularios(TfrmRetBcoAPI, LRetBcoAPI);
    LRetBcoAPI.NomeDoBanco      := '097 - Banco Credisis [Online]';
    LRetBcoAPI.Carteira         := LCarteira;
    LRetBcoAPI.Configuracao     := 'CONFIG097API-';
    LRetBcoAPI.CodigoDoBanco    := '097';
    LRetBcoAPI.ObjetoImportacao := TBancoCredisisAPI.Create(Concat('CONFIG097API-', LCarteira.ToString, '-', VS_strCodEmp));
    LRetBcoAPI.pnlTopo.Caption  := 'Importação Boletos Pagos - 097 - Banco Credisis [Online]';
    LRetBcoAPI.ShowModal;
  Finally
    FreeAndNil(LRetBcoAPI);
  End;
end;

class procedure TBancoCredisisMenu.ImprimirBoletosImportados;
  Var
    LRelRetBco : TfrmRelRetBco;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmRelRetBco,LRelRetBco);
    LRelRetBco.pnlTopo.Caption := 'Relatório de Retorno Banco - 097 - Banco Credisis [Online]';
    LRelRetBco.strNomBanco     := '097 - Banco Credisis [Online]';
    LRelRetBco.ATipoCnab       := 'API';
    LRelRetBco.ShowModal;
  Finally
    FreeAndNil(LRelRetBco);
  End;
end;

class function TBancoCredisisMenu.ValidaArquivosNecessariosPelaAPI: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + 'ssleay32.dll');

  If Result Then
    Result := FileExists(ExtractFilePath(Application.ExeName) + 'libeay32.dll');

  If Not Result Then
    fMensagem('ATENÇÃO', 'Para a utilização do Banco do Brasil [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
end;

end.
