unit ContasBancarias.View.ImportacaoExtrato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,System.Types, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.Generics.Collections,
  ContasBancarias.View.Frame.ContaBancaria, ContasBancarias.Model.ContaBancaria,System.StrUtils,
  ContasBancarias.Controller.ContaBancaria, untLibContaBancariaPai,ContasBancarias.View.InformaPeriodo,
  untExtratoBaseClass, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,System.Threading,SyncObjs, JSON,
  cxButtons;

type
  TfrmImportacaoExtrato = class(TfrmPai)
    pnlFooter: TPanel;
    lblTotalGeral: TLabel;
    pnlTop: TPanel;
    lblTitulo: TLabel;
    lblSubTitulo: TLabel;
    edtFiltro: TEdit;
    scbContas: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtFiltroChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConsultaSaldoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FImportacaoExtratoController: TImportacaoExtratoController;
    FFramesContas: TList<TframeContaBancaria>;
    FConsultaSaldo: Boolean;
    FJSONDadosExtratoBancario: String;

    FConsultaEmAndamento: Boolean;

    FTimerConsulta: TTimer;
    FConsultaFinalizada: Boolean;

    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure CriarCardsContas;
    function ConverterParaJSON(AContaBancaria: TContaBancaria): string;
    procedure LimparCards;
    procedure AplicarFiltros;
    procedure PreparaTelaParaConsultarSaldo;
    function CriarCardConta(AConta: TContaBancaria; ATopPos: Integer): TframeContaBancaria;
    procedure AdicionarMargemNoUltimoItem;
    procedure HandleImportarClick(ASender: TObject);
    procedure AtualizarTotais;
    procedure ConsultarSaldoTodasContasBancarias;

    procedure IniciarConsultasAutomaticas;
    procedure TimerConsultaTimer(Sender: TObject);
    procedure MostrarCarregandoTodosCards;
    procedure ConsultasFinalizadas;
    procedure AguardeFinalizarConsultas;
  public
    { Public declarations }
    property ConsultaSaldo: Boolean read FConsultaSaldo write FConsultaSaldo;
    property JSONDadosExtratoBancario: String read FJSONDadosExtratoBancario write FJSONDadosExtratoBancario;
  end;

implementation

Uses untTLibContasBancariasFuncoes;

{$R *.dfm}

procedure TfrmImportacaoExtrato.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FTimerConsulta.Enabled := False;
  FConsultaFinalizada := True;

  TLibContaBancariaFuncoes.
    AguardeExecutarModalA(AguardeFinalizarConsultas,'Aguarde... Finalizando consultas.','');
end;

procedure TfrmImportacaoExtrato.FormCreate(Sender: TObject);
begin
  inherited;
  FFramesContas := TList<TframeContaBancaria>.Create;
  FConsultaEmAndamento := False;
  FConsultaFinalizada := False;

  FTimerConsulta := TTimer.Create(Self);
  FTimerConsulta.Interval := 3000;
  FTimerConsulta.OnTimer := TimerConsultaTimer;
  FTimerConsulta.Enabled := FConsultaSaldo;

  DoubleBuffered := True;
  scbContas.DoubleBuffered := True;
end;

procedure TfrmImportacaoExtrato.TimerConsultaTimer(Sender: TObject);
begin
  if Not FConsultaEmAndamento then
  begin
    FTimerConsulta.Enabled := False;
    IniciarConsultasAutomaticas;
  end;
end;

procedure TfrmImportacaoExtrato.ConsultasFinalizadas;
begin
  If Not FConsultaFinalizada Then
  Begin
    FTimerConsulta.Interval := 60000;
    FTimerConsulta.Enabled := True;
    pnlInfo.Caption := 'Consultas finalizadas - Próxima em 1 minuto';
  End;
end;

procedure TfrmImportacaoExtrato.IniciarConsultasAutomaticas;
begin
  MostrarCarregandoTodosCards;
  ConsultarSaldoTodasContasBancarias;
end;

procedure TfrmImportacaoExtrato.FormDestroy(Sender: TObject);
begin
  inherited;
  LimparCards;
  FImportacaoExtratoController.Free;
  FFramesContas.Free;
  FTimerConsulta.Enabled := False;
  FTimerConsulta.Free;
end;

procedure TfrmImportacaoExtrato.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    pEscapePressed;
  End;
end;

procedure TfrmImportacaoExtrato.FormShow(Sender: TObject);
begin
  inherited;
  FImportacaoExtratoController := TImportacaoExtratoController.Create(FConsultaSaldo);
  FImportacaoExtratoController.CarregarContasBanco;
  PreparaTelaParaConsultarSaldo;

  CriarCardsContas;
  AdicionarMargemNoUltimoItem;

  FTimerConsulta.Enabled := FConsultaSaldo;
end;

procedure TfrmImportacaoExtrato.MostrarCarregandoTodosCards;
var
  I: Integer;
begin
  for I := 0 to FFramesContas.Count - 1 do
  begin
    if FFramesContas[I].Visible then
    begin
      FFramesContas[I].imgCarregando.Visible := True;
      FFramesContas[I].pnlMensagemErro.Visible := False;
      FFramesContas[I].pnlSaldo.Visible := False;
    end;
  end;
end;

procedure TfrmImportacaoExtrato.CriarCardsContas;
var
  LContador: Integer;
  LTopPos: Integer;
  LContas: TList<TContaBancaria>;
begin
  LimparCards;
  LContas := FImportacaoExtratoController.ListaContas;
  LTopPos := 16;

  for LContador := 0 to LContas.Count - 1 do
  begin
    FFramesContas.Add(CriarCardConta(LContas[LContador], LTopPos));
    LTopPos := LTopPos + 146;
  end;
end;

procedure TfrmImportacaoExtrato.WMMouseWheel(var Message: TWMMouseWheel);
var
  LPoint: TPoint;
  LScrollPos: Integer;
  LScrollLines: Integer;
begin
  LPoint := Point(Message.XPos, Message.YPos);
  LPoint := scbContas.ScreenToClient(LPoint);

  if PtInRect(scbContas.ClientRect, LPoint) then
  begin
    SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @LScrollLines, 0);
    if LScrollLines = 0 then
      LScrollLines := 3;

    LScrollPos := scbContas.VertScrollBar.Position -
                  (Message.WheelDelta * LScrollLines * 10 div WHEEL_DELTA);

    if LScrollPos < 0 then
      LScrollPos := 0
    else if LScrollPos > scbContas.VertScrollBar.Range then
      LScrollPos := scbContas.VertScrollBar.Range;

    scbContas.VertScrollBar.Position := LScrollPos;

    Message.Result := 1;
  end
  else
    inherited;
end;


procedure TfrmImportacaoExtrato.ConsultarSaldoTodasContasBancarias;
begin

  If FConsultaFinalizada or FConsultaEmAndamento Then
    Exit;

  FConsultaEmAndamento := True;

  // Executa em background
  TThread.CreateAnonymousThread(procedure
  var
    LContador: Integer;
    LConta: TContaBancaria;
    LCardContaBancaria: TframeContaBancaria;
  begin

    for LContador := 0 to FFramesContas.Count - 1 do
    begin

      If FConsultaFinalizada Then
       Continue;

      LCardContaBancaria := FFramesContas[LContador];

      if LCardContaBancaria.Visible then
      begin
        LConta := FImportacaoExtratoController.ListaContas[LCardContaBancaria.Tag];

        LConta.DadosRequisicao.DataInicial := VS_FuncoesExternas.fIGetVS_Date;
        LConta.DadosRequisicao.DataFinal := VS_FuncoesExternas.fIGetVS_Date;

        // Atualiza a UI na thread principal
        TThread.Synchronize(nil, procedure
        begin
          LCardContaBancaria.pnlMensagemErro.Visible := False;
          pnlInfo.Font.Color := $00339900;
          pnlInfo.Caption := 'Consultando saldo: ' + Format('Agência: %s | C/C: %s', [LConta.Agencia, LConta.NumeroConta]);
        end);

        try
          FImportacaoExtratoController.ConsultarSaldo(LConta);

          // Atualiza os resultados na thread principal
          TThread.Synchronize(nil, procedure
          begin
            LCardContaBancaria.lblUltimaImportacao.Caption := 'Última Consulta: ' +
              FormatDateTime('dd/mm/yyyy hh:nn', VS_FuncoesExternas.fIGetVS_Date + TLibContaBancariaFuncoes.fTime);

            LCardContaBancaria.imgCarregando.Visible := False;

            if not LConta.ErroConsulta.IsEmpty then
            begin
              LCardContaBancaria.pnlMensagemErro.Hint := LConta.ErroConsulta;
              LCardContaBancaria.pnlMensagemErro.Visible := True;
              Exit;
            end;

            LCardContaBancaria.pnlSaldo.Visible := True;
            LCardContaBancaria.lblValorSaldo.Caption := Format('Saldo: R$ %s', [FormatFloat('###,##0.00', LConta.Saldo)]);

            LCardContaBancaria.lblValorSaldo.Style.TextColor := $00339900;
            LCardContaBancaria.lblValorSaldo.AutoSize := True;
            LCardContaBancaria.lblValorSaldo.Align := alRight;

            if LConta.Saldo < 0 then
            begin
              LCardContaBancaria.lblValorSaldo.Style.TextColor := clRed;
            end;
          end);

        except
          on E: Exception do
          begin
            // Trata erro na thread principal
            TThread.Synchronize(nil, procedure
            begin
              LCardContaBancaria.pnlMensagemErro.Hint := E.Message;
              LCardContaBancaria.pnlMensagemErro.Visible := True;
            end);
          end;
        end;
      end;
    end;

    // Finalização na thread principal
    TThread.Synchronize(nil, procedure
    begin
      AtualizarTotais;
      pnlInfo.Caption := '';
      ConsultasFinalizadas;
      FConsultaEmAndamento := False;
    end);
  end).Start;;
end;

function TfrmImportacaoExtrato.CriarCardConta(AConta: TContaBancaria; ATopPos: Integer): TframeContaBancaria;
begin
  Result := TframeContaBancaria.Create(scbContas);
  Result.Parent := scbContas;
  Result.Name := 'FrameCardConta' + IntToStr(FFramesContas.Count);
  Result.Left := 16;
  Result.Top := ATopPos;
  Result.Width := 600;
  Result.Height := 140;
  Result.Tag := FFramesContas.Count;
  Result.OnImportarClick := HandleImportarClick;
  Result.CarregarDados(AConta);
  Result.ConfigurarBordasArredondadas;
  Result.lblValorSaldo.Visible := False;
  Result.pnlMensagemErro.Visible := False;
  Result.imgCarregando.Visible := False;

  If FConsultaSaldo Then
  Begin
    Result.btnImportar.Visible := False;
    Result.pnlImportar.Visible := False;
    Result.lblValorSaldo.Visible := True;
    Result.imgCarregando.Visible := True;
    Result.lblUltimaImportacao.Caption := 'Últ. Consulta: 00/00/0000 00:00';
  End;
end;

procedure TfrmImportacaoExtrato.AdicionarMargemNoUltimoItem;
  var
   EmptyPanel: TPanel;
begin
  EmptyPanel := TPanel.Create(scbContas);
  EmptyPanel.Parent := scbContas;
  EmptyPanel.Align := alBottom;
  EmptyPanel.Height := 20;
  EmptyPanel.BevelOuter := bvNone;
  EmptyPanel.BevelInner := bvNone;
end;

procedure TfrmImportacaoExtrato.LimparCards;
var
  LContador: Integer;
begin
  for LContador := 0 to FFramesContas.Count - 1 do
    FFramesContas[LContador].Free;
  FFramesContas.Clear;
end;

procedure TfrmImportacaoExtrato.PreparaTelaParaConsultarSaldo;
begin
  If Not FConsultaSaldo Then
    Exit;

  lblTitulo.Caption := 'Consulta de Saldo Bancário';
  lblSubTitulo.Caption := 'Selecione a conta para visualizar o saldo disponível';
  Self.Caption := 'Consulta de Saldo Bancário (Online)';
  lblTotalGeral.Visible := True;
end;

procedure TfrmImportacaoExtrato.AguardeFinalizarConsultas;
begin
  while FConsultaEmAndamento do
  begin
    Sleep(50);
    Application.ProcessMessages;
  end;
end;
procedure TfrmImportacaoExtrato.AplicarFiltros;
var
  LContador: Integer;
  LConta: TContaBancaria;
  LFiltro,
  LTextoConta: string;
  LVisibleCount: Integer;
  LMostrar: Boolean;
begin
  LFiltro := Trim(edtFiltro.Text);
  LVisibleCount := 0;
  scbContas.DisableAutoRange;
  Try
    for LContador := 0 to FFramesContas.Count - 1 do
    begin
      LConta := FImportacaoExtratoController.ListaContas[LContador];
      LMostrar := True;

      if Not LFiltro.IsEmpty then
      begin
        LTextoConta := (LConta.Banco + ' ' + LConta.Agencia + ' ' + LConta.NumeroConta).ToLower;
        LMostrar := ContainsText(LTextoConta, LFiltro);
      end;

      FFramesContas[LContador].Visible := LMostrar;

      if LMostrar then
      begin
        FFramesContas[LContador].Top := 16 + (LVisibleCount * 146);
        Inc(LVisibleCount);
      end;

    end;
  Finally
    scbContas.EnableAutoRange;
    scbContas.VertScrollBar.Position := 0;
  End;

  AtualizarTotais;
end;

procedure TfrmImportacaoExtrato.AtualizarTotais;
begin
  lblTotalGeral.Caption := 'Total Geral: R$ ' + FormatFloat('###,##0.00', FImportacaoExtratoController.SaldoTotal);
end;

procedure TfrmImportacaoExtrato.btnConsultaSaldoClick(Sender: TObject);
begin
  inherited;
  Self.Enabled := False;
  Try
    TLibContaBancariaFuncoes.
     AguardeExecutarModalA(ConsultarSaldoTodasContasBancarias,'Aguarde... Consultando saldos','');
  Finally
    Self.Enabled := True;
  End;
end;

procedure TfrmImportacaoExtrato.HandleImportarClick(ASender: TObject);
var
  LIndexConta: Integer;
  LConta: TContaBancaria;
  LfrmInformaPeriodo: TfrmInformaPeriodo;
  LCardContaBncaria: TframeContaBancaria;
begin
  LCardContaBncaria :=  (ASender as TframeContaBancaria);
  LIndexConta := LCardContaBncaria.Tag;
  if (LIndexConta >= 0) and (LIndexConta < FImportacaoExtratoController.ListaContas.Count) then
  begin
    LConta := FImportacaoExtratoController.ListaContas[LIndexConta];

    Try
      TLibContaBancariaFuncoes.pCriarFormularios(TfrmInformaPeriodo,LfrmInformaPeriodo);
      LCardContaBncaria.pnlMensagemErro.Visible := False;

      pnlInfo.Font.Color :=  $00339900;
      pnlInfo.Caption := 'Importando extrato: ' + Format('Agência: %s | C/C: %s', [LConta.Agencia, LConta.NumeroConta]);

      If LfrmInformaPeriodo.ShowModal = mrOk Then
      Begin
        LConta.DadosRequisicao.DataInicial := LfrmInformaPeriodo.mskDataInicial.Date;
        LConta.DadosRequisicao.DataFinal :=  LfrmInformaPeriodo.mskDataFinal.Date;

        FImportacaoExtratoController.ImportarExtrato(LConta);


        If Not LConta.ErroConsulta.IsEmpty Then
        Begin
          LCardContaBncaria.pnlMensagemErro.Hint := LConta.ErroConsulta;
          LCardContaBncaria.pnlMensagemErro.Visible := True;
          pnlInfo.Caption := '';
          Exit;
        End;

        LCardContaBncaria.lblUltimaImportacao.Caption := 'Última importação: ' +
          FormatDateTime('dd/mm/yyyy', FImportacaoExtratoController.RetornaDataUltimaImportacao(LConta));

        FJSONDadosExtratoBancario := ConverterParaJSON(LConta);

        If (LConta.QuantidadeDeMovimentacoes > 0) Then
        Begin
          Self.btnSair.Click;
          Exit;
        End;

        TLibContaBancariaFuncoes.fMensagem(
          'Atenção',
          'Não encontramos movimentações no período informado. Por favor, verifique as datas e tente novamente.',
          ['&Ok']
        );
      End;

    Finally
      pnlInfo.Caption := '';
      FreeAndNil(LfrmInformaPeriodo);
    End;

  end;
end;

procedure TfrmImportacaoExtrato.edtFiltroChange(Sender: TObject);
begin
  AplicarFiltros;
end;

function TfrmImportacaoExtrato.ConverterParaJSON(AContaBancaria: TContaBancaria): string;
var
  JSONObj: TJSONObject;
begin
  JSONObj := TJSONObject.Create;
  try
    JSONObj.AddPair('CodigoBanco', FormatFloat('000', AContaBancaria.CodigoBanco));
    JSONObj.AddPair('CodigoPortador', Copy(AContaBancaria.Portador, 1, 5));
    JSONObj.AddPair('DataInicial',DateToStr(AContaBancaria.DadosRequisicao.DataInicial));
    JSONObj.AddPair('DataFinal',DateToStr(AContaBancaria.DadosRequisicao.DataFinal));
    Result := JSONObj.ToString;
  finally
    JSONObj.Free;
  end;
end;

end.
