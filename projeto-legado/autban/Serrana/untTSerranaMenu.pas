unit untTSerranaMenu;

interface

Uses System.Classes, System.SysUtils, Windows, Vcl.Forms, Vcl.Controls;

Type
  TSerranaMenu = class
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
Uses untFuncoesSimples, untConfigSerrana, untRelRelDuplicatas, untRetBco,
     untRelRetBco, untEstorno, untExpArqRemSerrana, untGerDup;
{ TSerranaMenu }

class procedure TSerranaMenu.CancelamentoDuplicatasEnviadasAoBanco;
begin
  Try
    pCriarFormularios(TfrmEstorno,frmEstorno);
    frmEstorno.edtCodBco.Text  := '991';
    frmEstorno.edtDesBco.Text  := 'Banco Serrana';
    frmEstorno.blnApenasCadRec := True;
    frmEstorno.ShowModal;
  Finally
    FreeAndNil(frmEstorno);
  End;
end;

class procedure TSerranaMenu.CancelamentoDuplicatasGeradas;
begin
  Try
    pCriarFormularios(TfrmEstorno,frmEstorno);
    frmEstorno.edtCodBco.Text  := '991';
    frmEstorno.edtDesBco.Text  := 'Banco Serrana';
    frmEstorno.blnApenasCadRec := False;
    frmEstorno.ShowModal;
  Finally
    FreeAndNil(frmEstorno);
  End;
end;

class function TSerranaMenu.CarteiraParaBaixa: Integer;
begin
  Result := 0;

  Try
    pCriarFormularios(TfrmConfigSerrana, frmConfigSerrana);
    frmConfigSerrana.pnlTopo.Caption   := 'Selecione a carteira';
    frmConfigSerrana.btnGravar.Caption := '&OK';
    frmConfigSerrana.blnNaoEditar         := True;
    frmConfigSerrana.ShowModal;

    If frmConfigSerrana.ModalResult <> mrOK Then
    Begin
      FreeAndNil(frmConfigSerrana);
      Exit;
    End;

    Result := frmConfigSerrana.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(frmConfigSerrana);
  End;
end;

class procedure TSerranaMenu.Configuracao;
begin
  Try
    pCriarFormularios(TfrmConfigSerrana, frmConfigSerrana);
    frmConfigSerrana.ShowModal;
  Finally
    FreeAndNil(frmConfigSerrana);
  End;
end;

class procedure TSerranaMenu.ExportaArquivoDeRemessa;
  Var
    LCarteira: Integer;
begin
  Try
    pCriarFormularios(TfrmConfigSerrana, frmConfigSerrana);
    frmConfigSerrana.pnlTopo.Caption   := 'Selecione a carteira';
    frmConfigSerrana.btnGravar.Caption := '&OK';
    frmConfigSerrana.blnNaoEditar      := True;
    frmConfigSerrana.ShowModal;

    If frmConfigSerrana.ModalResult <> mrOK Then
    Begin
      FreeAndNil(frmConfigSerrana);
      Exit;
    End;

    LCarteira := frmConfigSerrana.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(frmConfigSerrana);
  End;

  Try
    pCriarFormularios(TfrmExpArqRemSerrana, frmExpArqRemSerrana);
    frmExpArqRemSerrana.intCartei  := LCarteira;
    frmExpArqRemSerrana.strNomForm := 'frmConfigSerrana';
    frmExpArqRemSerrana.ShowModal;
  Finally
    FreeAndNil(frmExpArqRemSerrana);
  End;
end;

class procedure TSerranaMenu.GeracaoDeDuplicatas;
begin
  Try
    pCriarFormularios(TfrmGerDup,frmGerDup);
    frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 991 - Banco Serrana';
    frmGerDup.strNomBanco     := '991 - Banco Serrana';
    frmGerDup.ShowModal;
  Finally
    FreeAndNil(frmGerDup);
  End;
end;

class procedure TSerranaMenu.ImportacaoArquivoRetorno;
  Var
    LCarteira: Integer;
begin
  Try
    pCriarFormularios(TfrmConfigSerrana, frmConfigSerrana);
    frmConfigSerrana.pnlTopo.Caption   := 'Selecione a carteira';
    frmConfigSerrana.btnGravar.Caption := '&OK';
    frmConfigSerrana.blnNaoEditar         := True;
    frmConfigSerrana.ShowModal;

    If frmConfigSerrana.ModalResult <> mrOK Then
    Begin
      FreeAndNil(frmConfigSerrana);
      Exit;
    End;

    LCarteira := frmConfigSerrana.tabCarteira.TabIndex + 1;

  Finally
    FreeAndNil(frmConfigSerrana);
  End;

  Try
    pCriarFormularios(TfrmRetBco, frmRetBco);
    frmRetBco.strNomBanco      := '991 - Banco Serrana';
    frmRetBco.intCartei        := LCarteira;
    frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG991-' + IntToStr(LCarteira), 'PATHRET', '');
    frmRetBco.ShowModal;
  Finally
    FreeAndNil(frmRetBco);
  End;
end;

class procedure TSerranaMenu.RelatorioDuplicatasImportadas;
begin
  Try
    pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
    frmRelRetBco.pnlTopo.Caption := 'Relatório de Retorno Banco - 991 - Banco Serrana';
    frmRelRetBco.strNomBanco     := '991 - Banco Serrana';
    frmRelRetBco.ATipoCnab       := '400';
    frmRelRetBco.ShowModal;
  Finally
    FreeAndNil(frmRelRetBco);
  End;
end;

class procedure TSerranaMenu.RelatorioDuplicatasGeradas;
begin
  Try
    pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
    frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 991 - Banco Serrana';
    frmRelRelDuplicatas.strNomBanco      := '991 - Banco Serrana';
    frmRelRelDuplicatas.ShowModal;
  Finally
    FreeAndNil(frmRelRelDuplicatas);
  End;
end;

end.
