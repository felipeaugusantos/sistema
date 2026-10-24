unit untTBancoBradescoMenu;

interface

Uses System.Classes, System.SysUtils, Windows, Vcl.Forms, Vcl.Controls,
     Vcl.ComCtrls;

Type
  TBancoBradescoMenu = class
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
Uses untFuncoesSimples, untConfigBradescoAPI, untRetBcoAPI, untRelRetBco,
     untTBancoBradescoAPI, untAlteraBoletoApi;

{ TBancoBradescoMenu }

class procedure TBancoBradescoMenu.CancelarBoletosRegistrados;
  Var
    LCarteira: Integer;

    LCancelaBoletoApi: TfrmAlteraBoletoApi;

    LConfigBradescoAPI : TfrmConfigBradescoAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigBradescoAPI, LConfigBradescoAPI);
    LConfigBradescoAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigBradescoAPI.btnGravar.Caption := '&OK';
    LConfigBradescoAPI.blnNaoEditar      := True;
    LConfigBradescoAPI.ShowModal;

    If LConfigBradescoAPI.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigBradescoAPI);
      Exit;
    End;

    LCarteira := LConfigBradescoAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigBradescoAPI);
  End;

  Try
    pCriarFormularios(TfrmAlteraBoletoApi, LCancelaBoletoApi);
    LCancelaBoletoApi.NomeDoBanco      := '237 - Banco Bradesco [Online]';
    LCancelaBoletoApi.Carteira         := LCarteira;
    LCancelaBoletoApi.Configuracao     := 'CONFIG237API-';
    LCancelaBoletoApi.CodigoDoBanco    := '237';
    LCancelaBoletoApi.ObjetoBanco      := TBancoBradescoAPI.Create(Concat('CONFIG237API-', LCarteira.ToString, '-', VS_strCodEmp));
    LCancelaBoletoApi.pnlTopo.Caption  := 'Cancelamento de boletos registrados - 237 - Banco Bradesco [Online]';
    LCancelaBoletoApi.Cancelamento     := True;
    LCancelaBoletoApi.ShowModal;
  Finally
    FreeAndNil(LCancelaBoletoApi);
  End;
end;

class function TBancoBradescoMenu.CarteiraParaBaixa: Integer;
  Var
    LConfigBradescoAPI: TfrmConfigBradescoAPI;
begin
  Result := 0;

  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigBradescoAPI, LConfigBradescoAPI);
    LConfigBradescoAPI.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigBradescoAPI.btnGravar.Caption := '&OK';
    LConfigBradescoAPI.blnNaoEditar      := True;
    LConfigBradescoAPI.ShowModal;

    If LConfigBradescoAPI.ModalResult <> mrOK Then
      Exit;
    
    Result := LConfigBradescoAPI.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigBradescoAPI);
  End;
end;

class procedure TBancoBradescoMenu.Configuracao;
  Var
    LConfigBradescoAPI : TfrmConfigBradescoAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigBradescoAPI, LConfigBradescoAPI);
    LConfigBradescoAPI.ShowModal;
  Finally
    FreeAndNil(LConfigBradescoAPI);
  End;
end;

class procedure TBancoBradescoMenu.ImportacaoBoletosPagos;
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
    LRetBcoAPI.NomeDoBanco      := '237 - Banco Bradesco [Online]';
    LRetBcoAPI.Carteira         := LCarteira;
    LRetBcoAPI.Configuracao     := 'CONFIG237API-';
    LRetBcoAPI.CodigoDoBanco    := '237';
    LRetBcoAPI.ObjetoImportacao := TBancoBradescoAPI.Create(Concat('CONFIG237API-', LCarteira.ToString, '-', VS_strCodEmp));
    LRetBcoAPI.pnlTopo.Caption  := 'Importação Boletos Pagos - 237 - Banco Bradesco [Online]';
    LRetBcoAPI.ShowModal;
  Finally
    FreeAndNil(LRetBcoAPI);
  End;
end;

class procedure TBancoBradescoMenu.ImprimirBoletosImportados;
  Var
    LRelRetBco : TfrmRelRetBco;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmRelRetBco,LRelRetBco);
    LRelRetBco.pnlTopo.Caption := 'Relatório de Retorno Banco - 237 - Banco Bradesco [Online]';
    LRelRetBco.strNomBanco     := '237 - Banco Bradesco [Online]';
    LRelRetBco.ATipoCnab       := 'API';
    LRelRetBco.ShowModal;
  Finally
    FreeAndNil(LRelRetBco);
  End;
end;

class function TBancoBradescoMenu.ValidaArquivosNecessariosPelaAPI: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + 'ssleay32.dll');

  If Result Then
    Result := FileExists(ExtractFilePath(Application.ExeName) + 'libeay32.dll');

  If Not Result Then
    fMensagem('ATENÇÃO', 'Para a utilização do Banco Bradesco [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autcom.', ['&OK']);
end;

end.
