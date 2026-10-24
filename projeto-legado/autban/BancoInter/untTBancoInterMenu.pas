unit untTBancoInterMenu;

interface

Uses System.Classes, System.SysUtils, Windows, Vcl.Forms, Vcl.Controls,untTypesSistema,System.DateUtils;

Type
  TBancoInterMenu = class
  private
    class function ValidaArquivosNecessariosPelaAPI: Boolean;
  Public
    class procedure Configuracao;
    class procedure ImportacaoBoletosPagos;
    class procedure ImprimirBoletosImportados;
    class procedure VerificaExpiracaoCertificadoDigitalBancoInter;
    class procedure CancelarBoletosRegistrados;

    class function CarteiraParaBaixa: Integer;
end;

implementation
Uses untFuncoesSimples, untConfigBancoInter, untRetBcoAPI, untRelRetBco,untTBancoInter, untAlteraBoletoApi;
{ TBancoInterMenu }

class function TBancoInterMenu.CarteiraParaBaixa: Integer;
begin
  Result := 0;

  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigBancoInter, frmConfigBancoInter);
    frmConfigBancoInter.pnlTopo.Caption   := 'Selecione a carteira';
    frmConfigBancoInter.btnGravar.Caption := '&OK';
    frmConfigBancoInter.NaoEditar         := True;
    frmConfigBancoInter.ShowModal;

    If frmConfigBancoInter.ModalResult <> mrOK Then
    Begin
      FreeAndNil(frmConfigBancoInter);
      Exit;
    End;

    Result := frmConfigBancoInter.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(frmConfigBancoInter);
  End;
end;

class procedure TBancoInterMenu.Configuracao;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigBancoInter, frmConfigBancoInter);
    frmConfigBancoInter.ShowModal;
  Finally
    FreeAndNil(frmConfigBancoInter);
  End;
end;

class procedure TBancoInterMenu.VerificaExpiracaoCertificadoDigitalBancoInter;
  Var
    LSelecionado,
    LContador: Integer;
    LCodCarteira: Integer;
    arrBancos  : TArrBancos;
    arrBanCar  : TStringArray;
    arrCarCertExp  : TStringArray;
    LConfigBancoInter : TfrmConfigBancoInter;
Begin

  If Not fVerificaAcessoSistema('ALTCERTINT') Then
    Exit;

  pCarregaArrayBancoCarteira('077', arrBancos, arrBanCar);
  LCodCarteira := 1;

  If (Length(arrBanCar) > 0) Then
  Begin

    If (Length(arrBanCar) > 1) Then
    Begin

      For LContador := 0 To Length(arrBanCar)-1 Do
      Begin
        If StrToDateDef(fGetBancoConfig(0, 'CONFIG077-' + IntToStr(arrBancos[LContador-1].intCodCar), 'VALCERT', ''),0) <= IncDay(VS_DATE,30) Then
        Begin
          SetLength(arrCarCertExp, Length(arrCarCertExp)+1);
          arrCarCertExp[LContador] := arrBanCar[LContador];
          LCodCarteira   := arrBancos[LContador-1].intCodCar;
        End;
      End;

      If (Length(arrCarCertExp) > 0) Then
      Begin
        If fMensagem('ATENÇÃO','Há carteira(s) com certificado(s) do Banco Inter '+
                                'próximos da data de validade, considere realizar a renovação!'+ #13#10 +
                                'Deseja verificar agora?',['&Sim','&Não'],2) = 2 Then
          Exit;
      End Else Exit;

      If  (Length(arrCarCertExp) > 1) Then
      Begin
        LSelecionado := fGetMenu('Selecione o Banco e Carteira', arrCarCertExp, 0, True);

        If LSelecionado <> -1 Then
        Begin
          LCodCarteira   := arrBancos[LSelecionado-1].intCodCar;
        End;
      End;

      If Not ValidaArquivosNecessariosPelaAPI Then
        Exit;

      Try
        pCriarFormularios(TfrmConfigBancoInter, LConfigBancoInter);
        LConfigBancoInter.tabCarteira.TabIndex := (LCodCarteira - 1);
        LConfigBancoInter.ShowModal;
      Finally
        FreeAndNil(LConfigBancoInter);
      End;

    End;


  End;
End;

class procedure TBancoInterMenu.ImportacaoBoletosPagos;
  Var
    LCarteira: Integer;

    LRetBcoAPI: TfrmRetBcoAPI;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigBancoInter, frmConfigBancoInter);
    frmConfigBancoInter.pnlTopo.Caption   := 'Selecione a carteira';
    frmConfigBancoInter.btnGravar.Caption := '&OK';
    frmConfigBancoInter.NaoEditar         := True;
    frmConfigBancoInter.ShowModal;

    If frmConfigBancoInter.ModalResult <> mrOK Then
    Begin
      FreeAndNil(frmConfigBancoInter);
      Exit;
    End;

    LCarteira := frmConfigBancoInter.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(frmConfigBancoInter);
  End;

  Try
    pCriarFormularios(TfrmRetBcoAPI, LRetBcoAPI);
    LRetBcoAPI.NomeDoBanco      := '077 - Banco Inter';
    LRetBcoAPI.Carteira         := LCarteira;
    LRetBcoAPI.Configuracao     := 'CONFIG077-';
    LRetBcoAPI.CodigoDoBanco    := '077';
    LRetBcoAPI.ObjetoImportacao := TBancoInter.Create(Concat('CONFIG077-', LCarteira.ToString, '-', VS_strCodEmp));
    LRetBcoAPI.pnlTopo.Caption  := 'Importação Boletos Pagos - 077 - Banco Inter';
    LRetBcoAPI.ShowModal;
  Finally
    FreeAndNil(LRetBcoAPI);
  End;
end;

class procedure TBancoInterMenu.ImprimirBoletosImportados;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
    frmRelRetBco.pnlTopo.Caption := 'Relatório de Retorno Banco - 077 - Banco Inter';
    frmRelRetBco.strNomBanco     := '077 - Banco Inter';
    frmRelRetBco.ATipoCnab       := 'API';
    frmRelRetBco.ShowModal;
  Finally
    FreeAndNil(frmRelRetBco);
  End;
end;

class function TBancoInterMenu.ValidaArquivosNecessariosPelaAPI: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + 'ssleay32.dll');

  If Result Then
    Result := FileExists(ExtractFilePath(Application.ExeName) + 'libeay32.dll');

  If Not Result Then
    fMensagem('ATENÇÃO', 'Para a utilização do Banco Inter, é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
end;

class procedure TBancoInterMenu.CancelarBoletosRegistrados;
  Var
    LCarteira: Integer;

    LCancelaBoletoApi: TfrmAlteraBoletoApi;

    LConfigBancoInter : TfrmConfigBancoInter;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  Try
    pCriarFormularios(TfrmConfigBancoInter, LConfigBancoInter);
    LConfigBancoInter.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigBancoInter.btnGravar.Caption := '&OK';
    LConfigBancoInter.NaoEditar := True;
    LConfigBancoInter.ShowModal;

    If LConfigBancoInter.ModalResult <> mrOK Then
    Begin
      FreeAndNil(LConfigBancoInter);
      Exit;
    End;

    LCarteira := LConfigBancoInter.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(LConfigBancoInter);
  End;

  Try
    pCriarFormularios(TfrmAlteraBoletoApi, LCancelaBoletoApi);
    LCancelaBoletoApi.NomeDoBanco      := '077 - Banco Inter [Online]';
    LCancelaBoletoApi.Carteira         := LCarteira;
    LCancelaBoletoApi.Configuracao     := 'CONFIG077-';
    LCancelaBoletoApi.CodigoDoBanco    := '077';
    LCancelaBoletoApi.ObjetoBanco      := TBancoInter.Create(Concat('CONFIG077-', LCarteira.ToString, '-', VS_strCodEmp));
    LCancelaBoletoApi.pnlTopo.Caption  := 'Cancelamento de boletos registrados - 077 - Banco Inter [Online]';
    LCancelaBoletoApi.Cancelamento     := True;
    LCancelaBoletoApi.ShowModal;
  Finally
    FreeAndNil(LCancelaBoletoApi);
  End;
end;

end.
