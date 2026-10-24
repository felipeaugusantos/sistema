unit untTRubiMenu;

interface

Uses System.Classes, System.SysUtils, Windows, Vcl.Forms, Vcl.Controls;

Type
  TRubiMenu = class
  private

  Public
    class procedure Configuracao;
    class procedure GeracaoDeDuplicatas;
    class procedure ImportacaoArquivoRetorno;
    class procedure RelatorioDuplicatasImportadas;
    class procedure RelatorioDuplicatasGeradas;
    class procedure CancelamentoDuplicatasGeradas;
    class procedure CancelamentoDuplicatasEnviadasAoBanco;
    class procedure ExportaArquivoDeRemessa;

    class function CarteiraParaBaixa: Integer;
end;

implementation
Uses untFuncoesSimples, untConfigRubi, untRelRelDuplicatas, untRetBco,
     untRelRetBco, untEstorno, untExpArqRemRubi, untGerDup;
{ TRubiMenu }

class procedure TRubiMenu.CancelamentoDuplicatasEnviadasAoBanco;
begin
  Try
    pCriarFormularios(TfrmEstorno,frmEstorno);
    frmEstorno.edtCodBco.Text  := '989';
    frmEstorno.edtDesBco.Text  := 'Banco Data Venia';
    frmEstorno.blnApenasCadRec := True;
    frmEstorno.ShowModal;
  Finally
    FreeAndNil(frmEstorno);
  End;
end;

class procedure TRubiMenu.CancelamentoDuplicatasGeradas;
begin
  Try
    pCriarFormularios(TfrmEstorno,frmEstorno);
    frmEstorno.edtCodBco.Text  := '989';
    frmEstorno.edtDesBco.Text  := 'Banco Data Venia';
    frmEstorno.blnApenasCadRec := False;
    frmEstorno.ShowModal;
  Finally
    FreeAndNil(frmEstorno);
  End;
end;

class function TRubiMenu.CarteiraParaBaixa: Integer;
begin
  Result := 0;

  Try
    pCriarFormularios(TfrmConfigRubi, frmConfigRubi);
    frmConfigRubi.pnlTopo.Caption   := 'Selecione a carteira';
    frmConfigRubi.btnGravar.Caption := '&OK';
    frmConfigRubi.blnNaoEditar         := True;
    frmConfigRubi.ShowModal;

    If frmConfigRubi.ModalResult <> mrOK Then
    Begin
      FreeAndNil(frmConfigRubi);
      Exit;
    End;

    Result := frmConfigRubi.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(frmConfigRubi);
  End;
end;

class procedure TRubiMenu.Configuracao;
begin
  Try
    pCriarFormularios(TfrmConfigRubi, frmConfigRubi);
    frmConfigRubi.ShowModal;
  Finally
    FreeAndNil(frmConfigRubi);
  End;
end;

class procedure TRubiMenu.ExportaArquivoDeRemessa;
  Var
    LCarteira: Integer;
begin
  Try
    pCriarFormularios(TfrmConfigRubi, frmConfigRubi);
    frmConfigRubi.pnlTopo.Caption   := 'Selecione a carteira';
    frmConfigRubi.btnGravar.Caption := '&OK';
    frmConfigRubi.blnNaoEditar      := True;
    frmConfigRubi.ShowModal;

    If frmConfigRubi.ModalResult <> mrOK Then
    Begin
      FreeAndNil(frmConfigRubi);
      Exit;
    End;

    LCarteira := frmConfigRubi.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(frmConfigRubi);
  End;

  Try
    pCriarFormularios(TfrmExpArqRemRubi, frmExpArqRemRubi);
    frmExpArqRemRubi.intCartei  := LCarteira;
    frmExpArqRemRubi.strNomForm := 'frmConfigRubi';
    frmExpArqRemRubi.ShowModal;
  Finally
    FreeAndNil(frmExpArqRemRubi);
  End;
end;

class procedure TRubiMenu.GeracaoDeDuplicatas;
begin
  Try
    pCriarFormularios(TfrmGerDup,frmGerDup);
    frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 989 - Banco Data Venia';
    frmGerDup.strNomBanco     := '989 - Banco Data Viena';
    frmGerDup.ShowModal;
  Finally
    FreeAndNil(frmGerDup);
  End;
end;

class procedure TRubiMenu.ImportacaoArquivoRetorno;
  Var
    LCarteira: Integer;
begin
  Try
    pCriarFormularios(TfrmConfigRubi, frmConfigRubi);
    frmConfigRubi.pnlTopo.Caption   := 'Selecione a carteira';
    frmConfigRubi.btnGravar.Caption := '&OK';
    frmConfigRubi.blnNaoEditar         := True;
    frmConfigRubi.ShowModal;

    If frmConfigRubi.ModalResult <> mrOK Then
    Begin
      FreeAndNil(frmConfigRubi);
      Exit;
    End;

    LCarteira := frmConfigRubi.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(frmConfigRubi);
  End;

  Try
    pCriarFormularios(TfrmRetBco, frmRetBco);
    frmRetBco.strNomBanco      := '989 - Banco Data Venia';
    frmRetBco.intCartei        := LCarteira;
    frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG989-' + IntToStr(LCarteira), 'PATHRET', '');
    frmRetBco.ShowModal;
  Finally
    FreeAndNil(frmRetBco);
  End;
end;

class procedure TRubiMenu.RelatorioDuplicatasImportadas;
begin
  Try
    pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
    frmRelRetBco.pnlTopo.Caption := 'Relatório de Retorno Banco - 989 - Banco Data Venia';
    frmRelRetBco.strNomBanco     := '989 - Banco Data Viena';
    frmRelRetBco.ATipoCnab       := '400';
    frmRelRetBco.ShowModal;
  Finally
    FreeAndNil(frmRelRetBco);
  End;
end;

class procedure TRubiMenu.RelatorioDuplicatasGeradas;
begin
  Try
    pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
    frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 989 - Banco Data Venia';
    frmRelRelDuplicatas.strNomBanco      := '989 - Banco Data Viena';
    frmRelRelDuplicatas.ShowModal;
  Finally
    FreeAndNil(frmRelRelDuplicatas);
  End;
end;

end.
