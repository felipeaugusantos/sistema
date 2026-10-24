unit untTPagForMenu;

interface

Uses System.Classes, System.SysUtils, Windows, Vcl.Forms, Vcl.Controls;

Type
  TPagForMenu = class
  private
    class function ValidaArquivosNecessariosPelaAPI: Boolean;

    class function RetornaDescricaoBanco(ACodigoBanco: String;
                                         ABancoAPI: Boolean): String;
  Public
    class procedure Configuracao(ACodigoBanco,
                                 AConfig: String;
                                 ABancoAPI: Boolean);

    class procedure GeracaoDeDuplicata(ACodigoBanco: String;
                                       ABancoAPI: Boolean);

    class procedure RelatorioDeDuplicataRemessa(ACodigoBanco: String;
                                                ABancoAPI: Boolean);

    class procedure CancelaDuplicatasRemessa(ACodigoBanco: String;
                                             ABancoAPI: Boolean);

    class procedure EnviaDuplicatasRemessaApi(ACodigoBanco: String);

    class procedure CancelaDuplicatasEnviadasAoBanco(ACodigoBanco: String;
                                                     ABancoAPI: Boolean);

    class procedure ImportarBoletosApi(ACodigoBanco: String);

    class function CarteiraParaBaixa(ACodigoBanco: String;
                                     ABancoAPI: Boolean;
                                     Var ADiasCredito: Integer): Integer;

    class procedure RelatorioDeDuplicatasImportadas(ACodigoBanco: String;
                                                    ABancoAPI: Boolean);
end;

implementation
Uses untFuncoesSimples, untConfigPagFor, untGerDup, untRelRelCtaDuplicatas,
     untEstorno, untTPagFor, untRetPagFor, untRelRetBcoCta;
{ untTPagForMenu }

class procedure TPagForMenu.CancelaDuplicatasEnviadasAoBanco(
  ACodigoBanco: String; ABancoAPI: Boolean);
  Var
    LEstorno: TfrmEstorno;
begin
  Try
    pCriarFormularios(TfrmEstorno, LEstorno);

    LEstorno.edtCodBco.Text  := ACodigoBanco;
    LEstorno.edtDesBco.Text  := RetornaDescricaoBanco(ACodigoBanco, ABancoAPI);
    LEstorno.blnApenasCadPag := True;
    LEstorno.blnApareceDtaPg := True;
    LEstorno.ContasAPagarAPI := ABancoAPI;
    LEstorno.strTipGer       := 'P';
    LEstorno.ShowModal;
  Finally
    FreeAndNil(LEstorno);
  End;
end;

class procedure TPagForMenu.CancelaDuplicatasRemessa(ACodigoBanco: String;
  ABancoAPI: Boolean);
  Var
    LEstorno: TfrmEstorno;
begin
  Try
    pCriarFormularios(TfrmEstorno, LEstorno);

    LEstorno.edtCodBco.Text  := ACodigoBanco;
    LEstorno.edtDesBco.Text  := RetornaDescricaoBanco(ACodigoBanco, ABancoAPI);
    LEstorno.blnApenasCadPag := False;
    LEstorno.blnApareceDtaPg := True;
    LEstorno.ContasAPagarAPI := ABancoAPI;
    LEstorno.strTipGer       := 'P';
    LEstorno.ShowModal;
  Finally
    FreeAndNil(LEstorno);
  End;
end;

class function TPagForMenu.CarteiraParaBaixa(ACodigoBanco: String;
  ABancoAPI: Boolean; Var ADiasCredito: Integer): Integer;
  Var
    LConfigPagFor: TfrmConfigPagFor;
begin
  Result := 0;

  If ABancoAPI Then
  Begin
    If Not ValidaArquivosNecessariosPelaAPI Then
      Exit;
  End;

  Try
    pCriarFormularios(TfrmConfigPagFor, LConfigPagFor);
    LConfigPagFor.pnlTopo.Caption   := 'Selecione a carteira';
    LConfigPagFor.btnGravar.Caption := '&OK';
    LConfigPagFor.blnNaoEditar      := True;
    LConfigPagFor.strCodBco         := ACodigoBanco;
    LConfigPagFor.strConfig         := 'CONFIGCTAAPI' + ACodigoBanco;
    LConfigPagFor.BancoAPI          := ABancoAPI;
    LConfigPagFor.ShowModal;

    If LConfigPagFor.ModalResult <> mrOK Then
      Exit;

    ADiasCredito := StrToIntDef(LConfigPagFor.edtDiasCred.Text,0);

    Result := LConfigPagFor.tabContas.TabIndex + 1;
  Finally
    FreeAndNil(LConfigPagFor);
  End;
end;

class procedure TPagForMenu.Configuracao(ACodigoBanco, AConfig: String;
  ABancoAPI: Boolean);
  Var
    LConfigPagFor: TfrmConfigPagFor;
begin
  If ABancoAPI Then
  Begin
    If Not ValidaArquivosNecessariosPelaAPI Then
      Exit;
  End;

  Try
    pCriarFormularios(TfrmConfigPagFor, LConfigPagFor);

    LConfigPagFor.pnlTopo.Caption := 'Configurações Contas a Pagar - ' + RetornaDescricaoBanco(ACodigoBanco,
                                                                                               ABancoAPI);
    LConfigPagFor.strConfig       := AConfig;
    LConfigPagFor.strCodBco       := ACodigoBanco;
    LConfigPagFor.BancoAPI        := ABancoAPI;
    LConfigPagFor.ShowModal;
  Finally
    FreeAndNil(LConfigPagFor);
  End;
end;

class procedure TPagForMenu.EnviaDuplicatasRemessaApi(ACodigoBanco: String);
  Var
    LConfigPagFor: TfrmConfigPagFor;

    LCarteira: Integer;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  LCarteira := 1;

  Try
    pCriarFormularios(TfrmConfigPagFor, LConfigPagFor);

    LConfigPagFor.pnlTopo.Caption := 'Configurações Contas a Pagar - ' + RetornaDescricaoBanco(ACodigoBanco,
                                                                                               True);
    LConfigPagFor.strConfig    := 'CONFIGCTAAPI' + ACodigoBanco;
    LConfigPagFor.strCodBco    := ACodigoBanco;
    LConfigPagFor.BancoAPI     := True;
    LConfigPagFor.blnNaoEditar := True;
    LConfigPagFor.ShowModal;

    LCarteira := LConfigPagFor.tabContas.TabIndex + 1;

    If LConfigPagFor.ModalResult <> mrOk Then
      Exit;
  Finally
    FreeAndNil(LConfigPagFor);
  End;

  TPagFor.EnviaDuplicatasRemessaAPI(ACodigoBanco,
                                    'CONFIGCTAAPI' +
                                        ACodigoBanco + '-' +
                                        LCarteira.ToString + '-' +
                                        VS_strCodEmp);
end;

class procedure TPagForMenu.GeracaoDeDuplicata(ACodigoBanco: String;
  ABancoAPI: Boolean);
  Var
    LGerDup: TfrmGerDup;
begin
  Try
    pCriarFormularios(TfrmGerDup, LGerDup);
    LGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - ' + RetornaDescricaoBanco(ACodigoBanco, ABancoAPI);
    LGerDup.strNomBanco            := RetornaDescricaoBanco(ACodigoBanco, ABancoAPI);
    LGerDup.strTipGer              := 'P';
    LGerDup.blnMosTED              := True;
    LGerDup.ContasAPagarAPI        := ABancoAPI;
    LGerDup.ShowModal;
  Finally
    FreeAndNil(LGerDup);
  End;
end;

class procedure TPagForMenu.ImportarBoletosApi(ACodigoBanco: String);
  Var
    LConfigPagFor: TfrmConfigPagFor;

    LRetPagFor: TfrmRetPagFor;

    LCarteira: Integer;
begin
  If Not ValidaArquivosNecessariosPelaAPI Then
    Exit;

  LCarteira := 1;

  Try
    pCriarFormularios(TfrmConfigPagFor, LConfigPagFor);

    LConfigPagFor.pnlTopo.Caption := 'Configurações Contas a Pagar - ' + RetornaDescricaoBanco(ACodigoBanco,
                                                                                               True);
    LConfigPagFor.strConfig    := 'CONFIGCTAAPI' + ACodigoBanco;
    LConfigPagFor.strCodBco    := ACodigoBanco;
    LConfigPagFor.BancoAPI     := True;
    LConfigPagFor.blnNaoEditar := True;
    LConfigPagFor.ShowModal;

    LCarteira := LConfigPagFor.tabContas.TabIndex + 1;

    If LConfigPagFor.ModalResult <> mrOk Then
      Exit;
  Finally
    FreeAndNil(LConfigPagFor);
  End;

  Try
    pCriarFormularios(TfrmRetPagFor, LRetPagFor);
    LRetPagFor.strNomBco     := RetornaDescricaoBanco(ACodigoBanco,
                                                      True);

    LRetPagFor.ImportacaoAPI := True;
    LRetPagFor.strConfig     := 'CONFIGCTAAPI' + ACodigoBanco + '-' + LCarteira.ToString;
    LRetPagFor.strCodBco     := ACodigoBanco;
    LRetPagFor.pnlTopo.Caption  := 'Importação Boletos - ' + RetornaDescricaoBanco(ACodigoBanco,
                                                                                   True);

    LRetPagFor.ShowModal;
  Finally
    FreeAndNil(LRetPagFor);
  End;
end;

class procedure TPagForMenu.RelatorioDeDuplicataRemessa(ACodigoBanco: String;
  ABancoAPI: Boolean);
  Var
    LRelRelCtaDuplicatas: TfrmRelRelCtaDuplicatas;
begin
  Try
    pCriarFormularios(TfrmRelRelCtaDuplicatas, LRelRelCtaDuplicatas);
    LRelRelCtaDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - ' + RetornaDescricaoBanco(ACodigoBanco, ABancoAPI);
    LRelRelCtaDuplicatas.strNomBanco      := RetornaDescricaoBanco(ACodigoBanco, ABancoAPI);
    LRelRelCtaDuplicatas.blnMosPagto      := True;
    LRelRelCtaDuplicatas.ShowModal;
  Finally
    FreeAndNil(LRelRelCtaDuplicatas);
  End;
end;

class procedure TPagForMenu.RelatorioDeDuplicatasImportadas(
  ACodigoBanco: String; ABancoAPI: Boolean);
  Var
    LRelRetBcoCta: TfrmRelRetBcoCta;
begin
  Try
    pCriarFormularios(TfrmRelRetBcoCta, LRelRetBcoCta);
    LRelRetBcoCta.pnlTopo.Caption  := 'Relatório de Retorno Banco - ' + RetornaDescricaoBanco(ACodigoBanco, ABancoAPI);
    LRelRetBcoCta.strNomBanco      := RetornaDescricaoBanco(ACodigoBanco, ABancoAPI);
    LRelRetBcoCta.BancoAPI         := ABancoAPI;
    LRelRetBcoCta.ShowModal;
  Finally
    FreeAndNil(LRelRetBcoCta);
  End;
end;

class function TPagForMenu.RetornaDescricaoBanco(ACodigoBanco: String;
  ABancoAPI: Boolean): String;
begin
  Result := EmptyStr;

  If ACodigoBanco = '001' Then
    Result := '001 - Banco do Brasil ';

  If ABancoAPI Then
    Result := Result + '[Online]';
end;

class function TPagForMenu.ValidaArquivosNecessariosPelaAPI: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + 'ssleay32.dll');

  If Result Then
    Result := FileExists(ExtractFilePath(Application.ExeName) + 'libeay32.dll');

  If Not Result Then
    fMensagem('ATENÇÃO', 'Para a utilização do Banco do Brasil Pagfor [Online], é necessário possuir os arquivos ssleay32.dll e libeay32.dll ' +
                         'na pasta do Autban.', ['&OK']);
end;

end.
