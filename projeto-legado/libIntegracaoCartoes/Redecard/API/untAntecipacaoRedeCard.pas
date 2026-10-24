unit untAntecipacaoRedeCard;

interface

uses
  Winapi.Windows,Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, dxScreenTip, cxClasses, dxCustomHint, cxHint,
  QColorLabel, Vcl.ComCtrls, dxCore, cxDateUtils, cxGroupBox, cxCalendar,
  Vcl.Mask, MaskEditFocus,untTIntegracaoAntecipacaoRedeCard,untConstantes,
  dxGDIPlusClasses, cxImage, untGravando,untNewGravando, frxDBSet,untIDataSet,
  frxExportPDF;

type
  TfrmAntecipacaoRedeCard = class(TfrmPai)
    pnlFundo: TPanel;
    btnSimularAntecipacao: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    btnPesquisa: TBitBtnLocked;
    TimerBuscaCode: TTimer;
    pnlTop: TPanel;
    pnlTotais: TPanel;
    Label12: TLabel;
    Label10: TLabel;
    Label5: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    lblTotalLivre: TLabel;
    lblTotalGravame: TLabel;
    lblTotalDisponivel: TLabel;
    Label7: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    cxCBModalidade: TcxComboBox;
    cxCBFiltro: TcxComboBox;
    cxCBGravame: TcxComboBox;
    edtValorSaldo: TEditFocus;
    Label6: TLabel;
    edtDesPon: TEditFocus;
    edtPonVen: TEditFocus;
    frxReciboAntecipacaoRC: TfrxReport;
    frxHelpAntecipacaoRedeCard: TfrxReport;
    btnAjuda: TBitBtnLocked;
    frxPDFExport1: TfrxPDFExport;
    pnlImgSelo: TPanel;
    Image1: TImage;
    procedure edtPonVenKeyPress(Sender: TObject; var Key: Char);
    procedure cxCBModalidadeMouseEnter(Sender: TObject);
    procedure cxCBModalidadeMouseLeave(Sender: TObject);
    procedure cxCBGravameMouseLeave(Sender: TObject);
    procedure cxCBGravameMouseEnter(Sender: TObject);
    procedure edtValorSaldoMouseEnter(Sender: TObject);
    procedure edtDescontoMouseLeave(Sender: TObject);
    procedure cxCBFiltroMouseEnter(Sender: TObject);
    procedure cxCBFiltroMouseLeave(Sender: TObject);
    procedure edtValorSaldoMouseLeave(Sender: TObject);
    procedure btnSimularAntecipacaoClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerBuscaCodeTimer(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cxCBFiltroPropertiesEditValueChanged(Sender: TObject);
    procedure edtValorSaldoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtPonVenExit(Sender: TObject);
    procedure edtPonVenMouseEnter(Sender: TObject);
    procedure edtPonVenMouseLeave(Sender: TObject);
    procedure btnAjudaClick(Sender: TObject);
  private
    { Private declarations }
    FAntecipacaoSimulada : String;
    FEstabelecimentoAtual : String;
    FDadosRequisicao : TDadosRequisicao;
    FIntegracaoAntecipacaoRedeCard : TIntegracaoAntecipacaoRedeCard;
    FIncTentativaConsentimento:Integer;
    FClickBtnSimulacao: Boolean;
    FAplicacao: HWND;

    procedure CarregarEmpresa;
    procedure AdicionaParametrosRequisicao;
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pHideHint;
    procedure ShowHintComboBox(AComboBox: TcxComboBox; ATitulo: String);
    procedure CarregaMensagemAguardeConsentimento;
    procedure ExibirSaldos;
    procedure PedirPeriodo;
    procedure LimparTudo;
    procedure ExibirComprovante;
    function ValidaHorarioFuncionamento: Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    property Aplicacao: HWND read FAplicacao write FAplicacao;
  end;

implementation

Uses
  untFuncoes, untFuncoesSimples,untDigPeriodoData;

{$R *.dfm}


procedure TfrmAntecipacaoRedeCard.AdicionaParametrosRequisicao;
begin
  FDadosRequisicao.CodigoEstabelecimento := edtPonVen.Text;
  FDadosRequisicao.SaldoComGravame       := cxCBGravame.Text;
  FDadosRequisicao.ModalidadeRecebiveis  := cxCBModalidade.Text;
  FDadosRequisicao.Saldo                 := edtValorSaldo.Text;
  FDadosRequisicao.CodigoOperador        := '23';
  FDadosRequisicao.FiltrandoPor          := cxCBFiltro.Text;
  FIntegracaoAntecipacaoRedeCard.DadosRequisicao := FDadosRequisicao;
end;

procedure TfrmAntecipacaoRedeCard.btnSimularAntecipacaoClick(Sender: TObject);
begin
  inherited;

  If FIntegracaoAntecipacaoRedeCard.ExisteConfiguracaoVazia Then
    Exit;

  If Not ValidaHorarioFuncionamento Then
    Exit;

  If FIntegracaoAntecipacaoRedeCard.BuscarCode Then
  Begin
    fMensagem('ATENÇÃO!', 'Você está em processo de concessão de autorização, vá até o navegador padrão'+
                          ' e aceite a nossa solicitação de permissão para realizar a antecipação dos recebíveis.', ['&O k']);
    Exit;
  End;

  FClickBtnSimulacao := True;

  If Not fVerificaCampos Then
    Exit;

  If Not fValidaCampos(edtValorSaldo) Then
    Exit;

  If  FIntegracaoAntecipacaoRedeCard.BuscarCode Then
    Exit;

  If fStrToFloat(edtValorSaldo.Text) > fStrToFloat(Trim(lblTotalDisponivel.Caption).Replace('R$','')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Valor informado para simulação é maior que o saldo disponível!', ['&O k']);
    Exit;
  End;

  Try
    pEnabled(Self,False);
    Try
      AdicionaParametrosRequisicao;
      FIntegracaoAntecipacaoRedeCard.RealizarAntecipacao;

      If FIntegracaoAntecipacaoRedeCard.AntecipacaoRealizada Then
      Begin
        fMensagem('SUCESSO!', 'Antecipação realizada com sucesso!' + #13#10 +
                              'Em seguida será impresso o comprovante de antecipação.', ['&O k']);
        ExibirComprovante;
        LimparTudo;
      End;
    Except
      On E: Exception Do
      Begin
        pGravarErro(True, E.Message + ' - ' + Self.Name);
        pMensagensErro(E.Message, '[fMensagem]');
      End;
    End;
  Finally
    pEnabled(Self,True);
    pSetFocus(edtPonVen);
  End;
end;

procedure TfrmAntecipacaoRedeCard.btnAjudaClick(Sender: TObject);
begin
  inherited;
  frxHelpAntecipacaoRedeCard.PrepareReport;
  pExibirRelatorio('frmAntecipacaoRedeCard', 'Help Antecipação RedeCard', TReport.New(frxHelpAntecipacaoRedeCard));
end;

procedure TfrmAntecipacaoRedeCard.btnPesquisaClick(Sender: TObject);
  Var
    Key: Char;
    CodigoSimulacao: TEditFocus;
begin
  inherited;

  If FIntegracaoAntecipacaoRedeCard.BuscarCode Then
  Begin
    fMensagem('ATENÇÃO!', 'Você está em processo de concessão de autorização, vá até o navegador padrão'+
                          ' e aceite a nossa solicitação de permissão para realizar a antecipação dos recebíveis.', ['&O k']);
    Exit;
  End;


  Try
    Key :=  Chr(47);
    CodigoSimulacao := TEditFocus.Create(Self);

    If fIPesquisar(Self, CodigoSimulacao, nil, Key,'SIMANTREDECARD') Then
    Begin
      FAntecipacaoSimulada := CodigoSimulacao.Text;
    End;
  Finally
    FreeAndNil(CodigoSimulacao);
  End;
end;

procedure TfrmAntecipacaoRedeCard.btnSairClick(Sender: TObject);
begin

  If FIntegracaoAntecipacaoRedeCard.BuscarCode Then
  Begin
    If fMensagem('ATENÇÃO!', 'Você está em processo de concessão de autorização.'+#10#13+
                             'A operação será cancelada, deseja realmente sair?',['&Sim', '&Não'],2) = 2 Then
    Exit;
  End;

  inherited;

end;

procedure TfrmAntecipacaoRedeCard.CarregaMensagemAguardeConsentimento;
begin
  If fEmptyStr(pnlInfo.Caption) Then
    pnlInfo.Caption := 'Aguardando aceitação do consentimento.'
  Else If pnlInfo.Caption =  'Aguardando aceitação do consentimento.' Then
    pnlInfo.Caption := 'Aguardando aceitação do consentimento..'
  Else If pnlInfo.Caption =  'Aguardando aceitação do consentimento..' Then
    pnlInfo.Caption :=  'Aguardando aceitação do consentimento...'
  Else If pnlInfo.Caption =  'Aguardando aceitação do consentimento...' Then
    pnlInfo.Caption :=  'Aguardando aceitação do consentimento.';
end;

procedure TfrmAntecipacaoRedeCard.CarregarEmpresa;
begin
  If (fEmptyStr(fTiraCaracEspeciais(edtPonVen.Text))) Then
    Exit;

  edtDesPon.Text := RetornaNomeEmpresaEstabelecimento(edtPonVen.Text);
  If fEmptyStr(edtDesPon.Text) Then
    edtDesPon.Text := 'NÃO EXISTE EMPRESA VINCULADA';
end;

procedure TfrmAntecipacaoRedeCard.cxCBFiltroMouseEnter(Sender: TObject);
begin
  inherited;
  ShowHintComboBox(cxCBFiltro,'Tipo de seleção dos recebíveis no dado período. '+#10#13+
                              'Seleciona os recebíveis por data de apresentação  '+#10#13+
                              'ou data de vencimento.');
end;

procedure TfrmAntecipacaoRedeCard.cxCBFiltroMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmAntecipacaoRedeCard.cxCBFiltroPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  PedirPeriodo;
end;

procedure TfrmAntecipacaoRedeCard.cxCBGravameMouseEnter(Sender: TObject);
begin
  inherited;
  ShowHintComboBox(cxCBGravame,'Indica se será utilizado para antecipação saldo com gravame.');
end;

procedure TfrmAntecipacaoRedeCard.cxCBGravameMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmAntecipacaoRedeCard.cxCBModalidadeMouseEnter(Sender: TObject);
begin
  inherited;
  ShowHintComboBox(cxCBModalidade,'Modalidade dos recebíveis que serão'+#10#13+
                                  'antecipados (rotativo, parcelado ou ambos).');
end;

procedure TfrmAntecipacaoRedeCard.cxCBModalidadeMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmAntecipacaoRedeCard.edtDescontoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmAntecipacaoRedeCard.edtPonVenExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmAntecipacaoRedeCard.edtPonVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fIPesquisar(Self, edtPonVen, edtDesPon, Key,'ESTANTREDECARD') Then
  Begin
   edtPonVen.Text := RetornadoEstabelecimentoSelecionado(edtPonVen.Text);

    If fValidaCampos(edtPonVen) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAntecipacaoRedeCard.edtPonVenMouseEnter(Sender: TObject);
begin
  inherited;
  pShowHint(edtPonVen, 'Após informar o ponto de venda pressione a'+#13#10
                      +' tecla ENTER para consultar seu saldo disponível.');
end;

procedure TfrmAntecipacaoRedeCard.edtPonVenMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmAntecipacaoRedeCard.edtValorSaldoKeyPress(Sender: TObject;
  var Key: Char);
begin
  If (Key = #13) or (Key = #9) Then
    pSetFocus(btnSimularAntecipacao);
end;

procedure TfrmAntecipacaoRedeCard.edtValorSaldoMouseEnter(Sender: TObject);
begin
  inherited;
  pShowHint(edtValorSaldo, 'Valor do saldo que deseja antecipar. Esse campo é obrigatório '+#10#13+
                           'quando o campo Tipo de Antecipação dfor parcial.');
end;

procedure TfrmAntecipacaoRedeCard.edtValorSaldoMouseLeave(Sender: TObject);
begin
  inherited;
  pHideHint;

end;

procedure TfrmAntecipacaoRedeCard.ExibirComprovante;
  Var
    qryDados: IDataset;
begin
  Try
    // PARA ALTERAR O RELATORIO ALTERE O DOCUMENTO \libIntegracaoCartoes\Redecard\API\Antecipação RedeCard.odt
    // E TRANSFORME EM IMAGEM
    qryDados := objFunctions.fGetDataSet;
    qryDados.Close;

    qryDados.SQL := ' SELECT                                   '+
                    '   RED_VALBRU,                            '+
                    '  (RED_VALBRU - RED_VALLIQ) AS DESCONTO,  '+
                    '   RED_VALTAX,                            '+
                    '   RED_VALLIQ                             '+
                    ' FROM                                     '+
                    '   RED_CADANT WHERE AUTOINCREM = :AUTINC  ';

    qryDados.ParamByName('AUTINC').AsString := FIntegracaoAntecipacaoRedeCard.SimulacaoEfetivada;
    qryDados.Open;

    frxReciboAntecipacaoRC.Script.Variables['EMPRESA']         := Concat(VS_strCodEmp,'-',RetornaNomeEmpresa(VS_strCodEmp));
    frxReciboAntecipacaoRC.Script.Variables['ESTABELECIMENTO'] := Concat(edtPonVen.Text,'-',edtDesPon.Text);
    frxReciboAntecipacaoRC.Script.Variables['RED_VALBRU']      :=  'R$ ' + FormatFloat('#,##0.00', qryDados.FieldByName('RED_VALBRU').AsFloat);
    frxReciboAntecipacaoRC.Script.Variables['DESCONTO']        :=  'R$ ' + FormatFloat('#,##0.00', qryDados.FieldByName('DESCONTO').AsFloat);
    frxReciboAntecipacaoRC.Script.Variables['RED_VALTAX']      := FormatFloat('#,######0.000000%', qryDados.FieldByName('RED_VALTAX').AsFloat);
    frxReciboAntecipacaoRC.Script.Variables['RED_VALLIQ']      :=  'R$ ' + FormatFloat('#,##0.00', qryDados.FieldByName('RED_VALLIQ').AsFloat);
    frxReciboAntecipacaoRC.Script.Variables['MSGRECEBIMENTO']  := FIntegracaoAntecipacaoRedeCard.MensagemRecebimento;

    frxReciboAntecipacaoRC.PrepareReport;
    pExibirRelatorio('frmAntecipacaoRedeCard', 'Comprovante de antecipação de recebíveis – RedeCard', TReport.New(frxReciboAntecipacaoRC));


  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TfrmAntecipacaoRedeCard.ExibirSaldos;
begin
  lblTotalLivre.Caption      := 'R$ '+ FIntegracaoAntecipacaoRedeCard.TotalLivre;
  lblTotalGravame.Caption    := 'R$ '+ FIntegracaoAntecipacaoRedeCard.TotalGravame;
  lblTotalDisponivel.Caption := 'R$ '+ FIntegracaoAntecipacaoRedeCard.TotalDisponivel;

  FIntegracaoAntecipacaoRedeCard.TotalLivre := '';
  FIntegracaoAntecipacaoRedeCard.TotalGravame := '';

  If fStrToFloat(Trim(lblTotalDisponivel.Caption).Replace('R$','')) = 0 Then
    FEstabelecimentoAtual := '';

end;

procedure TfrmAntecipacaoRedeCard.FormCreate(Sender: TObject);
begin
  inherited;
  FIntegracaoAntecipacaoRedeCard := TIntegracaoAntecipacaoRedeCard.Create;
end;

procedure TfrmAntecipacaoRedeCard.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FIntegracaoAntecipacaoRedeCard);
end;

procedure TfrmAntecipacaoRedeCard.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnSimularAntecipacao.Click;
end;

procedure TfrmAntecipacaoRedeCard.FormShow(Sender: TObject);
begin
  inherited;
  FIncTentativaConsentimento := 0;
  FClickBtnSimulacao := False;

  If FIntegracaoAntecipacaoRedeCard.ExisteConfiguracaoVazia Then
    Exit;

  If Not ValidaHorarioFuncionamento Then
   Exit;

  FIntegracaoAntecipacaoRedeCard.RealizarConcessaDeAutorizacao;
end;

function TfrmAntecipacaoRedeCard.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtPonVen) Then
  Begin

    If (fEmptyStr(fTiraCaracEspeciais(edtPonVen.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código do ponto de venda deve ser informado!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      CarregarEmpresa;
      If (FEstabelecimentoAtual <> edtPonVen.Text) Then
      Begin
        If FIntegracaoAntecipacaoRedeCard.ExisteConfiguracaoVazia Then
          Exit(False);

        If Not ValidaHorarioFuncionamento Then
         Exit(False);

        FIncTentativaConsentimento := 0;
        FEstabelecimentoAtual := edtPonVen.Text;
        AdicionaParametrosRequisicao;
        AguardeExecutarModalA(FIntegracaoAntecipacaoRedeCard.ConsultaSaldo,'Aguarde, Consultando saldo.', '');
        ExibirSaldos;
        Result := FIntegracaoAntecipacaoRedeCard.ConsultouSaldo;
      End;

    End;

  End
  Else If (Sender = edtValorSaldo) Then
  Begin
    If (fStrToFloat (edtValorSaldo.Text) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor para simulação não pode ser negativo!', ['&O k']);
      Result := False;
    End
    Else If (fStrToFloat (edtValorSaldo.Text) > 0) And (fStrToFloat (edtValorSaldo.Text) < 20.00) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor para simulação não pode ser menor que vinte reais!', ['&O k']);
      Result := False;
    End
    Else If (fStrToFloat (edtValorSaldo.Text) > 0) And (fStrToFloat (edtValorSaldo.Text) > 999999.99) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor para simulação deve ser menor que um milhão de reais!', ['&O k']);
      Result := False;
    End
    Else If (fStrToFloat (edtValorSaldo.Text) = 0) And (fStrToFloat(Trim(lblTotalDisponivel.Caption).Replace('R$','')) > 999999.99) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não será permitido realizar a antecipação total, pois seu '+
                            'saldo disponível é maior ou igual a um milhão de reais. Informe um valor para simulação!', ['&O k']);
      Result := False;
    End;
  End;


  If (Not Result) Then
    pSetFocus(Sender);
end;


procedure TfrmAntecipacaoRedeCard.LimparTudo;
begin
  edtPonVen.Clear;
  edtDesPon.Clear;
  lblTotalLivre.Caption := 'R$ 0,00';
  lblTotalGravame.Caption := 'R$ 0,00';
  lblTotalDisponivel.Caption := 'R$ 0,00';
  cxCBModalidade.ItemIndex := 2;
  cxCBFiltro.ItemIndex := 2;
  cxCBGravame.ItemIndex := 1;
  edtValorSaldo.Clear;
  FEstabelecimentoAtual := '';
end;

procedure TfrmAntecipacaoRedeCard.PedirPeriodo;
  Var
    LDigPeriodoData: TfrmDigPeriodoData;
begin
  FDadosRequisicao.DataInicial           := '';
  FDadosRequisicao.DataFinal             := '';

  If (cxCBFiltro.ItemIndex = 2) Then
    Exit;

  Try
    pCriarFormularios(TfrmDigPeriodoData,LDigPeriodoData);
    LDigPeriodoData.ShowModal;

    If LDigPeriodoData.Confirma Then
    Begin
      FDadosRequisicao.DataInicial           := LDigPeriodoData.mskDtaIni.Text;
      FDadosRequisicao.DataFinal             := LDigPeriodoData.mskDtaFin.Text;
    End
    Else
      cxCBFiltro.ItemIndex := 2;

  Finally
    FreeAndNil(LDigPeriodoData);
  End;
end;

procedure TfrmAntecipacaoRedeCard.pHideHint;
begin
  HintControler.HideHint;
end;

procedure TfrmAntecipacaoRedeCard.pShowHint(edtEdit: TEditFocus;
  strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmAntecipacaoRedeCard.ShowHintComboBox(AComboBox: TcxComboBox;
  ATitulo: String);
begin
  HintControler.ShowHint(AComboBox.ClientOrigin.X,AComboBox.ClientOrigin.Y, ATitulo, AComboBox.Hint);
end;

procedure TfrmAntecipacaoRedeCard.TimerBuscaCodeTimer(Sender: TObject);
begin
  inherited;

  If (FIncTentativaConsentimento = 600) Then
  Begin
    TimerBuscaCode.Enabled := False;

    fMensagem('ATENÇÃO!','Se passou aproximadamente 2 minutos e não foi nos concedido autorização '
                        +'para realizar a antecipação, a operação será cancelada.', ['&O k']);

    pnlInfo.Caption := '';
    FIncTentativaConsentimento := 0;
    FClickBtnSimulacao := False;
    pEnabled(Self,True);
    FIntegracaoAntecipacaoRedeCard.BuscarCode := False;
    LimparTudo;
    TimerBuscaCode.Enabled := True;
  End;


  If FIntegracaoAntecipacaoRedeCard.BuscarCode Then
  Begin
    TimerBuscaCode.Enabled := False;
    Inc(FIncTentativaConsentimento);
    Application.ProcessMessages;
    Aguarde(500);

    If edtPonVen.Enabled Then
      pEnabled(Self,False);

     CarregaMensagemAguardeConsentimento;

    If FIntegracaoAntecipacaoRedeCard.VerificarSeGerouCodeConsentimento Then
    Begin
      Application.ProcessMessages;

      If fEmptyStr(FIntegracaoAntecipacaoRedeCard.Autorizacao.Code) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não recebemos permissão para realizar a antecipação.'+#10#13+
                              'Motivo: ' + FIntegracaoAntecipacaoRedeCard.Autorizacao.Error +#10#13+
                              'Operação cancelada!', ['&O k']);
        Exit;
      End;

      pnlInfo.Caption := '';
      pEnabled(Self,True);

      BringWindowToTop(FAplicacao);
      Application.BringToFront;
      Self.BringToFront;

      If FClickBtnSimulacao Then
      Begin
        If fMensagem('SUCESSO!', 'Concessão realizada com sucesso!'+#10#13+
                                 'Deseja prosseguir com a simulação?',['&Sim', '&Não'],2) = 1 Then
          btnSimularAntecipacao.Click;
      End

      Else
      Begin
        fMensagem('SUCESSO!','Concessão realizada com sucesso!' +#10#13+
                             'Prossiga com a simulação!', ['&O k']);

      End;

      FClickBtnSimulacao := False;
      Exit;
    End;

    TimerBuscaCode.Enabled := True;
  End;
end;

function TfrmAntecipacaoRedeCard.ValidaHorarioFuncionamento: Boolean;
begin

  Result := True;

  If (fRetHoraServidor < StrToTime('08:30:00')) Or
     (fRetHoraServidor > StrToTime('18:50:00')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Serviço RedeCard disponível somente entre às 08:30 da manha até às 18:50 da noite.', ['&O k']);
    Exit(False);
  End;


  If (DayOfWeek(Date) = 1) or (DayOfWeek(Date) = 7) Then
  Begin
    fMensagem('ATENÇÃO!', 'Serviço RedeCard indisponível aos fins de semana.', ['&O k']);
    Exit(False);
  End;


end;

end.
