unit untOpcoesLancExtrato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxButtons, cxGroupBox, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, untTypesSistema;

type
  TfrmOpcoesLancExtrato = class(TfrmPai)
    grpItens: TcxGroupBox;
    Label2: TLabel;
    cmbOpcoes: TcxComboBox;
    btnInclusao: TcxButton;
    btnBaixa: TcxButton;
    procedure cmbOpcoesPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnInclusaoClick(Sender: TObject);
    procedure btnBaixaClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
  private
    { Private declarations }
    strCreDebLoc,
    strHistorLoc,
    strCodPorLoc: String;
    strEspecieLoc: String;
    fltValLanLoc: Double;
    dteDtaLanLoc,
    dteDtaIniLoc,
    dteDtaFinLoc,
    FDataAjuste: TDate;
    FValorAjuste: Double;
    FCreDebAjuste: String;
    FDatasDivergentes: Boolean;
    FUtilizouAjuste: Boolean;

    procedure pCarregaOpcoes(strCreDeb: String);
  public
    { Public declarations }
    arrSeqLanLoc: TStringArray;
    AUtilizouAjuste: Boolean;
    class procedure pMostraComOpcoes(strCreDeb: String; fltValLan: Double;
                                     strHistor: String; dteDtaLan: TDate;
                                     strCodPor: String; dteDtaIni: TDate;
                                     dteDtaFin: TDate;var arrSeqLan: TStringArray;var AUtilizouAjuste: Boolean;
                                     AValorAjuste: Double = 0; ADataAjuste: TDate = 0;
                                     ADatasDivergentes: Boolean = False;
                                     ACreDebAjuste: String = '');

  end;

var
  frmOpcoesLancExtrato: TfrmOpcoesLancExtrato;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCadCtaReceber, untCadCtaPagar, untCadCheques,
  untCadMovBancario, untCadMovCartoes, untBaixaCtaPagar, untBaixaReceber,
  untBaixaCheques, untBaixaCartoes, System.StrUtils;

{ TfrmOpcoesLancExtrato }

procedure TfrmOpcoesLancExtrato.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
  case Msg.Message of
    WM_KEYDOWN:
    begin
      if (Msg.wParam = VK_ESCAPE) then
      begin
        Msg.wParam := 0;
        Close;
      end;
    end;
  end;
end;

procedure TfrmOpcoesLancExtrato.btnBaixaClick(Sender: TObject);
  Var
    frmBaixaReceber : TfrmBaixaReceber;
    frmBaixaCtaPagar: TfrmBaixaCtaPagar;
    frmBaixaCartoes : TfrmBaixaCartoes;
    frmBaixaCheques : TfrmBaixaCheques;
begin
  inherited;
  SetLength(arrSeqLanLoc, 0);

  grpItens.Enabled := False;

  Try
    ApplicationEvents.OnMessage := Nil;
    if cmbOpcoes.Text = 'Contas à Pagar' then
    begin
      If fVerificaAcessoSistema('mnuCtaPagar') And fVerificaAcessoSistema('frmBaixaCtaPagar') Then
      begin
        pCriarFormularios(TfrmBaixaCtaPagar, frmBaixaCtaPagar);

        try
          frmBaixaCtaPagar.mskDtaIni.Date := dteDtaIniLoc;
          frmBaixaCtaPagar.mskDtaFin.Date := dteDtaFinLoc;
          frmBaixaCtaPagar.edtCodPor.Text := strCodPorLoc;
          frmBaixaCtaPagar.blnCarregaBaixa:= True;
          frmBaixaCtaPagar.dteDtaPagFix   := dteDtaFinLoc;
          frmBaixaCtaPagar.strCodPorFix   := strCodPorLoc;
          frmBaixaCtaPagar.fltValorBaixa  := fltValLanLoc;
          frmBaixaCtaPagar.chkLimFil.Checked := false;
          frmBaixaCtaPagar.ShowModal;
        finally
          arrSeqLanLoc := Copy(frmBaixaCtaPagar.arrSeqLan,  Low(frmBaixaCtaPagar.arrSeqLan), Length(frmBaixaCtaPagar.arrSeqLan));
          FreeAndNil(frmBaixaCtaPagar);
        end;
      end
      Else
        pMensagemOk('Operador sem direito de acesso!');
    end;

    if cmbOpcoes.Text = 'Contas à Receber' then
    begin
      If fVerificaAcessoSistema('mnuCtaReceber') And fVerificaAcessoSistema('frmBaixaCtaReceber') Then
      begin
        pCriarFormularios(TfrmBaixaReceber, frmBaixaReceber);

        try
          frmBaixaReceber.mskDtaIni.Date := dteDtaIniLoc;
          frmBaixaReceber.mskDtaFin.Date := dteDtaFinLoc;
          frmBaixaReceber.edtCodPortador.Text := strCodPorLoc;
          frmBaixaReceber.blnCarregaBaixa := True;
          frmBaixaReceber.dteDtaRecFix   := dteDtaFinLoc;
          frmBaixaReceber.strCodPorFix   := strCodPorLoc;
          frmBaixaReceber.fltValorBaixa  := fltValLanLoc;
          frmBaixaReceber.chkLimFil.Checked := False;
          frmBaixaReceber.ShowModal;
        finally
          arrSeqLanLoc := Copy(frmBaixaReceber.arrSeqLan,  Low(frmBaixaReceber.arrSeqLan), Length(frmBaixaReceber.arrSeqLan));
          FreeAndNil(frmBaixaReceber);
        end;
      end
      Else
        pMensagemOk('Operador sem direito de acesso!');
    end;

    if cmbOpcoes.Text = 'Contas à Receber - Crédito' then
    begin
      If fVerificaAcessoSistema('mnuCtaReceber') And fVerificaAcessoSistema('frmBaixaCtaReceber') Then
      begin
        pCriarFormularios(TfrmBaixaReceber, frmBaixaReceber);

        try
          frmBaixaReceber.mskDtaIni.Date := dteDtaIniLoc;
          frmBaixaReceber.mskDtaFin.Date := dteDtaFinLoc;
          frmBaixaReceber.edtCodPortador.Text := strCodPorLoc;
          frmBaixaReceber.blnCarregaBaixa := True;
          frmBaixaReceber.dteDtaRecFix   := dteDtaFinLoc;
          frmBaixaReceber.strCodPorFix   := strCodPorLoc;
          frmBaixaReceber.fltValorBaixa  := fltValLanLoc;
          frmBaixaReceber.chkLimFil.Checked := False;
          frmBaixaReceber.ShowModal;
        finally
          arrSeqLanLoc := Copy(frmBaixaReceber.arrSeqLan,  Low(frmBaixaReceber.arrSeqLan), Length(frmBaixaReceber.arrSeqLan));
          FreeAndNil(frmBaixaReceber);
        end;
      end
      Else
        pMensagemOk('Operador sem direito de acesso!');
    end;

    if cmbOpcoes.Text = 'Cheque' then
    begin
      If fVerificaAcessoSistema('mnuManCheques') And fVerificaAcessoSistema('frmBaixaCheques') Then
      begin
        pCriarFormularios(tfrmBaixaCheques, frmBaixaCheques);

        try
          frmBaixaCheques.mskDtaIni.Date := dteDtaIniLoc;
          frmBaixaCheques.mskDtaFin.Date := dteDtaFinLoc;
          frmBaixaCheques.btnCarrCheques.Click;
          pSetFocus(frmBaixaCheques.dbgCheques);
          frmBaixaCheques.dteDtaRecFix   := dteDtaLanLoc;
          frmBaixaCheques.strCodPorFix   := strCodPorLoc;
          frmBaixaCheques.fltValorBaixa  := fltValLanLoc;
          frmBaixaCheques.ShowModal;
        finally
          arrSeqLanLoc := Copy(frmBaixaCheques.arrSeqLan,  Low(frmBaixaCheques.arrSeqLan), Length(frmBaixaCheques.arrSeqLan));
          FreeAndNil(frmBaixaCheques);
        end;
      end
      Else
        pMensagemOk('Operador sem direito de acesso!');
    end;

    if cmbOpcoes.Text = 'Cartão' then
    begin
      If fVerificaAcessoSistema('mnuContrCartoes') And fVerificaAcessoSistema('frmBaixaCartoes') Then
      begin
        pCriarFormularios(TfrmBaixaCartoes, frmBaixaCartoes);

        try
          frmBaixaCartoes.mskDtaIniVenc.Date := dteDtaLanLoc;
          frmBaixaCartoes.mskDtaFinVenc.Date := dteDtaLanLoc;
          frmBaixaCartoes.dteDtaRecFix       := dteDtaLanLoc;
          frmBaixaCartoes.strCodPorFix       := strCodPorLoc;
          frmBaixaCartoes.fltValorBaixa      := fltValLanLoc;
          pSetFocus(frmBaixaCartoes.btnCarrCartoes);
          frmBaixaCartoes.ShowModal;
        finally
          arrSeqLanLoc := Copy(frmBaixaCartoes.arrSeqLanLoc,  Low(frmBaixaCartoes.arrSeqLanLoc), Length(frmBaixaCartoes.arrSeqLanLoc));
          FreeAndNil(frmBaixaCartoes);
        end;
      end
      Else
        pMensagemOk('Operador sem direito de acesso!');
    end;
  Finally
    ApplicationEvents.OnMessage := ApplicationEventsMessage;

    grpItens.Enabled := True;
    Self.Close;
  End;
end;

procedure TfrmOpcoesLancExtrato.btnInclusaoClick(Sender: TObject);
begin
  inherited;
  FUtilizouAjuste := False;
  ApplicationEvents.OnMessage := Nil;
  if cmbOpcoes.Text = 'Contas à Receber' then
  begin
    If fVerificaAcessoSistema('mnuCtaReceber') And fVerificaAcessoSistema('frmCadCtaReceber') Then
    begin
      Try
        TfrmCadCtaReceber.pMostraIniciandoCadastro(fltValLanLoc,
                                                   strHistorLoc,
                                                   dteDtaLanLoc,
                                                   dteDtaFinLoc,
                                                   strCodPorLoc);
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmOpcoesLancExtrato.pChamarManutencaoCtr]');
      End;
    end
    Else
      pMensagemOk('Operador sem direito de acesso!');
  end;

  if cmbOpcoes.Text = 'Contas à Receber - Crédito' then
  begin
    If fVerificaAcessoSistema('mnuCtaReceber') And fVerificaAcessoSistema('frmCadCtaReceber') Then
    begin
      Try
        strEspecieLoc:='CC'; //'CC' - Crédito Cliente
        TfrmCadCtaReceber.pMostraIniciandoCadastro(fltValLanLoc,
                                                   strHistorLoc,
                                                   dteDtaLanLoc,
                                                   dteDtaFinLoc,
                                                   strCodPorLoc,
                                                   True,
                                                   strEspecieLoc);
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmOpcoesLancExtrato.pChamarManutencaoCtr]');
      End;
    end
    Else
      pMensagemOk('Operador sem direito de acesso!');
  end;

  if cmbOpcoes.Text = 'Contas à Pagar' then
  begin
    If fVerificaAcessoSistema('mnuCtaPagar') And fVerificaAcessoSistema('frmCadCtaPagar') Then
    begin
      Try
        TfrmCadCtaPagar.pMostraIniciandoCadastro(fltValLanLoc,
                                                 strHistorLoc,
                                                 dteDtaIniLoc,
                                                 dteDtaFinLoc,
                                                 strCodPorLoc,
                                                 arrSeqLanLoc);
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmOpcoesLancExtrato.pChamarManutencaoCtp]');
      End;
    end
    Else
      pMensagemOk('Operador sem direito de acesso!');
  end;

  if cmbOpcoes.Text = 'Cheque' then
  begin
    If fVerificaAcessoSistema('mnuManCheques') And fVerificaAcessoSistema('frmCadCheques') Then
    begin
      Try
        TfrmCadCheques.pMostraIniciandoCadastro(fltValLanLoc,
                                                strHistorLoc,
                                                dteDtaLanLoc,
                                                strCodPorLoc,
                                                arrSeqLanLoc);
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmOpcoesLancExtrato.pChamarManutencaoChq]');
      End;
    end
    Else
      pMensagemOk('Operador sem direito de acesso!');
  end;

  if cmbOpcoes.Text = 'Cartão' then
  begin
    If fVerificaAcessoSistema('mnuContrCartoes') And fVerificaAcessoSistema('frmCadMovCartoes') Then
    begin
      Try
        TfrmCadMovCartoes.pMostraIniciandoCadastro(fltValLanLoc,
                                                   strHistorLoc,
                                                   dteDtaLanLoc,
                                                   strCodPorLoc,
                                                   arrSeqLanLoc);
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmOpcoesLancExtrato.pChamarManutencaoCartao]');
      End;
    end
    Else
      pMensagemOk('Operador sem direito de acesso!');
  end;

  if cmbOpcoes.Text = 'Movimentação Bancária' then
  begin
    If fVerificaAcessoSistema('mnuFinanceiro') And fVerificaAcessoSistema('frmCadMovBancario') Then
    begin
      Try
        TfrmCadMovBancario.pMostraIniciandoCadastro(fltValLanLoc,
                                                    strHistorLoc,
                                                    dteDtaLanLoc,
                                                    strCodPorLoc,
                                                    strCreDebLoc,
                                                    arrSeqLanLoc);
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmOpcoesLancExtrato.pChamarMovimentacaoContaBanco]');
      End;
    end
    Else
      pMensagemOk('Operador sem direito de acesso!');
  end;

  if cmbOpcoes.Text = 'Transferência de Valores' then
  begin
    If fVerificaAcessoSistema('mnuFinanceiro') And fVerificaAcessoSistema('frmCadMovBancario_Te') Then
    begin
      Try
        Try
          TfrmCadMovBancario.pMostraIniciandoCadastro(fltValLanLoc,
                                                      strHistorLoc,
                                                      dteDtaLanLoc,
                                                      strCodPorLoc,
                                                      strCreDebLoc,
                                                      arrSeqLanLoc,
                                                      False,
                                                      'TE');
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[mnuCadMovBancario_TEClick]');
          End;
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmOpcoesLancExtrato.ChamarTransferenciadevalores]');
      End;
    end
    Else
      pMensagemOk('Operador sem direito de acesso!');
  end;

  if cmbOpcoes.Text = 'Movimentação Bancária - Ajuste Valores' then
  begin
    If fVerificaAcessoSistema('mnuFinanceiro') And fVerificaAcessoSistema('frmCadMovBancario') Then
    begin
      Try
        if FDatasDivergentes then
        begin
          fMensagem('ATENÇÃO', 'A opção "Movimentação Bancária - Ajuste de Valores" ' +
                             'está indisponível, pois há lançamentos selecionados com datas divergentes.', ['&OK']);
          Exit;
        end;

        TfrmCadMovBancario.pMostraIniciandoCadastro(FValorAjuste,
                                                    strHistorLoc + ' - Ajuste Valores',
                                                    FDataAjuste,
                                                    strCodPorLoc,
                                                    FCreDebAjuste,
                                                    arrSeqLanLoc);

        FUtilizouAjuste := true;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmOpcoesLancExtrato.pChamarMovimentacaoContaBanco]');
      End;
    end
    Else
      pMensagemOk('Operador sem direito de acesso!');
  end;

  ApplicationEvents.OnMessage := ApplicationEventsMessage;

  Close;
end;

procedure TfrmOpcoesLancExtrato.cmbOpcoesPropertiesChange(Sender: TObject);
begin
  inherited;
  if cmbOpcoes.Text = 'Contas à Receber' then
  begin
    btnBaixa.Caption := '&Baixa';
    btnBaixa.Visible := True;
    btnBaixa.Enabled := True;
    btnInclusao.Caption := '&Inclusão';
    btnInclusao.Left := 15;
    btnInclusao.Width := 130;
    pSetFocus(btnBaixa);
  end;

  if cmbOpcoes.Text = 'Contas à Receber - Crédito' then
  begin
    btnBaixa.Caption := '&Baixa';
    btnBaixa.Visible := True;
    btnBaixa.Enabled := False;
    btnInclusao.Caption := '&Inclusão';
    btnInclusao.Left := 15;
    btnInclusao.Width := 130;
    pSetFocus(btnBaixa);
  end;

  if cmbOpcoes.Text = 'Contas à Pagar' then
  begin
    btnBaixa.Caption := '&Baixa';
    btnBaixa.Visible := True;
    btnBaixa.Enabled := True;
    btnInclusao.Caption := '&Inclusão';
    btnInclusao.Left := 15;
    btnInclusao.Width := 130;
    pSetFocus(btnInclusao);
  end;

  if (cmbOpcoes.Text = 'Cheque') then
  begin
    btnBaixa.Caption := '&Depósito';
    if (strCreDebLoc = 'C') then
    begin
      btnBaixa.Visible := True;
      btnBaixa.Enabled := True;
      btnInclusao.Caption := '&Inclusão';
      btnInclusao.Left := 15;
      btnInclusao.Width := 130;
    end
    else
    begin
      btnBaixa.Visible := False;
      btnBaixa.Enabled := False;
      btnInclusao.Caption := '&Inclusão/Devolução';
      btnInclusao.Left := 26;
      btnInclusao.Width := 258;
    end;
    pSetFocus(btnInclusao);
  end;

  if cmbOpcoes.Text = 'Cartão' then
  begin
    btnBaixa.Caption := '&Conciliação';
    btnBaixa.Visible := True;
    btnBaixa.Enabled := True;
    btnInclusao.Caption := '&Inclusão';
    btnInclusao.Left := 15;
    btnInclusao.Width := 130;
    pSetFocus(btnBaixa);
  end;

  if cmbOpcoes.Text = 'Movimentação Bancária' then
  begin
    btnBaixa.Caption := '&Baixa';
    btnBaixa.Visible := False;
    btnBaixa.Enabled := False;
    btnInclusao.Caption := '&Inclusão';
    btnInclusao.Left := 96;
    btnInclusao.Width := 130;
    pSetFocus(btnInclusao);
  end;

  if cmbOpcoes.Text = 'Transferência de Valores' then
  begin
    btnBaixa.Caption := '&Baixa';
    btnBaixa.Visible := False;
    btnBaixa.Enabled := False;
    btnInclusao.Caption := '&Inclusão';
    btnInclusao.Left := 96;
    btnInclusao.Width := 130;
    pSetFocus(btnInclusao);
  end;

  if cmbOpcoes.Text = 'Movimentação Bancária - Ajuste Valores' then
  begin
    btnBaixa.Caption := '&Baixa';
    btnBaixa.Visible := False;
    btnBaixa.Enabled := False;
    btnInclusao.Caption := '&Inclusão';
    btnInclusao.Left := 96;
    btnInclusao.Width := 130;
    pSetFocus(btnInclusao);
  end;

end;

class procedure TfrmOpcoesLancExtrato.pMostraComOpcoes(strCreDeb: String;
  fltValLan: Double; strHistor: String; dteDtaLan: TDate; strCodPor: String;
  dteDtaIni: TDate; dteDtaFin: TDate;var arrSeqLan: TStringArray; var AUtilizouAjuste: Boolean;
  AValorAjuste: Double = 0; ADataAjuste: TDate = 0;
  ADatasDivergentes: Boolean = False; ACreDebAjuste: String = '');
begin
  frmOpcoesLancExtrato := TfrmOpcoesLancExtrato.Create(Nil);

  try
    with frmOpcoesLancExtrato do
    begin
      strCreDebLoc      := strCreDeb;
      fltValLanLoc      := fltValLan;
      strHistorLoc      := strHistor;
      dteDtaLanLoc      := dteDtaLan;
      strCodPorLoc      := strCodPor;
      dteDtaIniLoc      := dteDtaIni;
      dteDtaFinLoc      := dteDtaFin;
      FValorAjuste      := AValorAjuste;
      FDataAjuste       := ADataAjuste;
      FDatasDivergentes := ADatasDivergentes;
      FCreDebAjuste     := ACreDebAjuste;
      //FAUtilizouAjuste  := AUtilizouAjuste;

      ShowModal;
    end;
  finally

    AUtilizouAjuste := frmOpcoesLancExtrato.FUtilizouAjuste;
    arrSeqLan := frmOpcoesLancExtrato.arrSeqLanLoc;
    FreeAndNil(frmOpcoesLancExtrato)
  end;;
end;

procedure TfrmOpcoesLancExtrato.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaOpcoes(strCreDebLoc);
  cmbOpcoes.ItemIndex := 0;
end;

procedure TfrmOpcoesLancExtrato.pCarregaOpcoes(strCreDeb: String);
begin
  if strCreDeb = 'D' then
  begin
    with cmbOpcoes do
    begin
      Properties.Items.Add('Contas à Pagar');
      Properties.Items.Add('Cheque');
      Properties.Items.Add('Movimentação Bancária');
      Properties.Items.Add('Transferência de Valores');
    end;
  end
  else
  begin
    with cmbOpcoes do
    begin
      Properties.Items.Add('Contas à Receber');
      Properties.Items.Add('Contas à Receber - Crédito');
      Properties.Items.Add('Cheque');
      Properties.Items.Add('Cartão');
      Properties.Items.Add('Movimentação Bancária');
      Properties.Items.Add('Transferência de Valores');
    end;
  end;

  If FDatasDivergentes Then
  Begin
     fMensagem('ATENÇÃO', 'A opção "Movimentação Bancária - Ajuste de Valores" ' +
                          'está indisponível, pois há lançamentos selecionados com datas divergentes.', ['&OK']);
  End;

  if ((FValorAjuste > 0) And (Not FDatasDivergentes)) then
     cmbOpcoes.Properties.Items.Add('Movimentação Bancária - Ajuste Valores');
end;

end.
