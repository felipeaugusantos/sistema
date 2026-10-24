unit untExibicaoQRCodePix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxBarCode, Vcl.ExtCtrls, Vcl.StdCtrls,
  dxGDIPlusClasses, untInterfacesIntegracaoPixCitel, untTRequisicoesPix, untTiposPix,
  untTFuncoesAuxiliaresPix, Vcl.Menus, cxButtons, Vcl.WinXCtrls,
  cxImage, untStepsBarPixFrame, frxClass, frxBarcode, UniClientDataset,
  madExcept, PinPad.Interfaces, untTMonitoramentoNovasCobrancasPix, System.Threading,
  SyncObjs, untMensagemRemoverPix, untTelasAbertas, System.Rtti, untInterfacePixTefBridge;

type
  TfunDisparaWhatsAppAutomatico = function (strNumDoc,
                                            strOpcDoc,
                                            strEspDoc,
                                            strNumOrc,
                                            strEspOrc,
                                            strEmpOri,
                                            strCodDes: String;
                                            AQrCodePix: String = ''): Boolean;

  TfunDisparaEmailAutomatico = function (strNumDoc,
                                         strOpcDoc,
                                         strEspDoc,
                                         strNumOrc,
                                         strEspOrc,
                                         strEmpOri,
                                         strCodDes : String;
                                         AQrCodePix: String = '';
                                         ALinkCitelPix: String = ''): Boolean;

  TfrmExibicaoQRCodePix = class(TForm, IPixTefStatusObserver)
    barQRCodePix: TdxBarCode;
    tmrValidacaoPagamento: TTimer;
    lblMensagemAndamento: TLabel;
    btnCancelar: TcxButton;
    pnlImagem: TPanel;
    imgLogoEmpresa: TImage;
    pnlTopo: TPanel;
    pnlValorTotal: TPanel;
    lblValorTotal: TLabel;
    imgCarregando: TcxImage;
    fraStepsPix: TfrmStepsBarPixFrame;
    imgPixLogo: TImage;
    chkForcarPagamento: TCheckBox;
    lblCopiarQRCode: TLabel;
    lblRealizarImpressao: TLabel;
    popmnuMonitores: TPopupMenu;
    mnuMonitor1: TMenuItem;
    mnuMonitor2: TMenuItem;
    tmrAguardar: TTimer;
    lblContadorCOnsulta: TLabel;
    lblMensagemPinPad: TLabel;
    tmrForcarFechamento: TTimer;
    tmrPixTefScope: TTimer;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrValidacaoPagamentoTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mnuMonitor1Click(Sender: TObject);
    procedure mnuMonitor2Click(Sender: TObject);
    procedure tmrAguardarTimer(Sender: TObject);
    procedure tmrForcarFechamentoTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmrPixTefScopeTimer(Sender: TObject);
  protected
    procedure WMEnviarQrCode(var Msg: TMessage); message WM_USER + 100;
  private
    FQrCodePendente: String;
    FValorPendente: String;
    FErro,
    FAutoIncremChavePix,
    FTxIdPix,
    FTextoQRCode,
    FLinkCitel,
    FResposta,
    FAutoIncremMovPix,
    FDadosNovoPix,
    FDadosPixAlteracao,
    FDadosEnvioRequisicao,
    FCodigoCliente,
    FChaveDocumento,
    FMensagemLinks,
    FTransactionType: String;

    FValorDocumento: Double;

    FstrNumTer: String;

    FAmbienteHomologacaoPix,
    FVerificouToken,
    FCriarNovoPix,
    FPixAlterado,
    FUtilizaShipay,
    FUtilizaTefScope,
    FExibirMensagemFechamento,
    FTEmpoTelaExcedido,
    FFecharFormulario: Boolean;

    FRequisicoes: IRequisicoesPix;

    FValorTotal: Double;
    FPinPad: IPinPadCitel;
    FTerminado: Boolean;
    FblnComandoEmExecPinPad: Boolean;
    FblnQRCodeEmProcessamentoPeloPinPad: Boolean;

    FNovaCobrancaPix: TNovaCobrancaPix;
    FMsgEncerramentoTef: String ;

    FContadorAguardar,
    FContadorTentativas,
    FContadorConsulta: Integer;

    FIntervaloConsultas: Cardinal;

    FCritical : TCriticalSection;

    FControleFechamentoAutomatico: Cardinal;

    FMensagemRemoverPix: TfrmMensagemRemoverPix;

    FTempoMaximoTelaAberta: Cardinal;

    FRecebimentoPagueFacil: Boolean;

    FTelas : ITelasAbertas;
    FCntErroPinPad: Integer ;
    FOrigemChamada: String;

    procedure pEmpilharTelaAberta;
    procedure pRemoverTelaAberta;

    procedure DefineMonitorApresentacaoQRCodePix(AMonitor:Integer);
    procedure ConfigurarPopUpPainel;

    Const
      InputBoxMsg = WM_USER + 123;

    procedure AtualizarDataUltimaRequisicaoTela(AAutoincrem: String);

    function ForcarPagamento(ARetorno: String): String;

    procedure RetornaDadosDoPixExistente;

    function ChavePixUtilizaShipay: Boolean;
    function ChavePixUtilizaTefScope: Boolean;

    procedure ImprimirQRCode;

    procedure InputBoxSet(var Msg: TMessage); message InputBoxMsg;

    function GerarAlterarNovoPix: Boolean;

    procedure CopiarQRCodeAreaTransferencia;

    function PixComValorPagoDiferenteDaCobranca(var ADadosResposta: TDadosRetornoPixConsulta): Boolean;

    procedure CopiarTxIdAreaTransferencia;

    procedure BancoDoBrasilEmHomologacaoPagoEAindaAtivo(var ADadosResposta: TDadosRetornoPixConsulta);

    function RemoverPixGeradoNoBanco: Boolean;

    procedure pEnviaQrCodePinPad(const AstrTextoQrCode, AstrTituloInformativo: String) ;
    procedure pLimpaQrCodePinPad ;
    procedure pSetTextoQRCode(const AstrValor: String) ;
    function fGerarQrCodeImagemPinPad(const AstrTexto: String;
                                      const AstrValor: String;
                                            AOwner: TWinControl;
                                      var   AstrPathDiretorio, AstrNomeArquivo: String): Boolean ;
    procedure pRetornaValorParametrosPinPad(var AstrValorParam1, AstrValorParam2: String) ;
    procedure pForcaAtualizacaoPinPad ;
    procedure pNotificaProblemaComunicacaoPinPad ;
    procedure pGravaProblemaPinPadLogErr() ;

    function AtualizaMonitoramentoNovaCobranca(AResposta: TDadosRetornoPixConsulta): Boolean;

    procedure ParadaAuxiliarParaHabilitarAConsulta(ATextoQRCode: String);

    function DeveAlterarGerar: Boolean;

    procedure CarregaLogoTelaQRCode;

    function RetornaIntervaloConsultas: Integer;
    procedure pSetQrCodeEmProcessamentoPeloPinPad(const AblnProcessando: Boolean) ;

    procedure ValidaFechamentoDeTelaAutomatico;
    procedure FecharECancelarOPixAutomaticamente;

    procedure CarregaTempoMaximoTelaAberta;

    procedure CarregarImagem(Image: TComponent);

    { Private declarations }
  protected
    procedure OnStatusTef(const AEvento: TPixTefStatusEvento); stdcall;
  public
    property AutoIncremChavePix: String read FAutoIncremChavePix write FAutoIncremChavePix;
    property DadosNovoPix: String read FDadosNovoPix write FDadosNovoPix;
    property TransactionType: String read FTransactionType write FTransactionType;
    property TxIdPix: String read FTxIdPix write FTxIdPix;
    property TextoQRCode: String read FTextoQRCode write pSetTextoQRCode;
    property AutoIncremMovPix: String read FAutoIncremMovPix write FAutoIncremMovPix;
    property DadosPixAlteracao: String read FDadosPixAlteracao write FDadosPixAlteracao;
    property CodigoCliente: String read FCodigoCliente write FCodigoCliente;
    property ChaveDocumento: String read FChaveDocumento write FChaveDocumento;
    property ValorDocumento: Double read FValorDocumento write FValorDocumento;
    property OrigemChamada: String read FOrigemChamada write FOrigemChamada;

    property CriarNovoPix: Boolean read FCriarNovoPix write FCriarNovoPix;

    property ValorTotal: Double read FValorTotal write FValorTotal;

    property Resposta: String read FResposta;

    property TEmpoTelaExcedido: Boolean read FTEmpoTelaExcedido;

    property RecebimentoPagueFacil: Boolean read FRecebimentoPagueFacil write FRecebimentoPagueFacil;
    { Public declarations }
  end;

var
  frmExibicaoQRCodePix: TfrmExibicaoQRCodePix;
  funDisparaWhatsAppAutomatico: TfunDisparaWhatsAppAutomatico;
  funDisparaEmailAutomatico: TfunDisparaEmailAutomatico;

const
  CONF_DOCS_SIMPLES = 'CONF_DOCS_SIMPLES';

implementation

Uses untFuncoesSimples, untIDataset, System.StrUtils, untRelatoriosQRCodeDM,
     untSelFilImpressao, Clipbrd, System.IOUtils, System.JSON;

{$R *.dfm}

function TfrmExibicaoQRCodePix.AtualizaMonitoramentoNovaCobranca(AResposta: TDadosRetornoPixConsulta): Boolean;
begin
  If Not FCriarNovoPix Then
    Exit(False);

  If AResposta.Status <> FNovaCobrancaPix.Status Then
    Exit(True);

  Result := FContadorConsulta >= 4;
end;

procedure TfrmExibicaoQRCodePix.AtualizarDataUltimaRequisicaoTela(AAutoincrem: String);
  Var
    LAtualiza: IDataset;
begin
  If FCriarNovoPix Then
    Exit;

  LAtualiza := VS_FuncoesExternas.fGetDataSet;
  LAtualiza.SQL := 'UPDATE PIXTEL SET MPX_ULTREQ=CURRENT_TIMESTAMP ' +
                   'WHERE AUTOINCREM="' + AAutoincrem + '"';
  LAtualiza.ExecSQL;
End;

procedure TfrmExibicaoQRCodePix.BancoDoBrasilEmHomologacaoPagoEAindaAtivo(
  var ADadosResposta: TDadosRetornoPixConsulta);
begin
  If Not FAmbienteHomologacaoPix Then
    Exit;

  If Pos('qrcodepix-h.bb.com.br', ADadosResposta.LinkQrCode) <= 0 Then
    Exit;

  If ADadosResposta.ValorPago <= 0 Then
    Exit;

  If ADadosResposta.Status = 'ATIVA' Then
  Begin
    ADadosResposta.Status := 'CONCLUIDA';

    FResposta := FResposta.Replace(': "ATIVA",', ': "CONCLUIDA",');
  End;
end;

procedure TfrmExibicaoQRCodePix.btnCancelarClick(Sender: TObject);
begin
  if FUtilizaTefScope then
    if Assigned(objBridgeTef) then
    begin
      btnCancelar.Enabled := False;
      objBridgeTef.pSair(True);
    end;

  tmrAguardar.Enabled := False;

  Self.Close;
end;

procedure TfrmExibicaoQRCodePix.CarregaLogoTelaQRCode;
  Var
    LCaminhoImagem,
    LMensagemErro: String;

    LContador: Cardinal;
begin
  LCaminhoImagem := fCfgSis('PATLOG', VS_FuncoesExternas.fGetEmpresaLogada);

  LContador := GetTickCount;

  If Not LCaminhoImagem.IsEmpty Then
  Begin
    Try
      If FileExists(LCaminhoImagem) Then
        imgLogoEmpresa.Picture.LoadFromFile(LCaminhoImagem);
    Except
      On E: Exception Do
      Begin
        LMensagemErro := 'Ocorreu um erro ao carregar o logo: ' + E.Message;
        If E.Message.ToUpperInvariant.Contains('BITMAP IMAGE IS NOT VALID') Then
          LMensagemErro := 'O arquivo de imagem possui um formato inválido.' + #13 +
                           'Caminho: "' + LCaminhoImagem + '"' + #13 +
                           'Para corrigir, abra a imagem em um editor e salve-a novamente no formato correto.';

        VS_FuncoesExternas.fIMensagem('ATENÇÃO', LMensagemErro, ['&Ok']);
      End;
    End;
  End;

  If LContador + 30000 < GetTickCount Then
    VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'Ocorreu uma lentidão ao abrir a imagem gravada na configuração CFG_PATLOG.' + #13 +
                                             'Verifique se o caminho do arquivo está configurado corretamente.', ['&Ok']);
end;

procedure TfrmExibicaoQRCodePix.CarregarImagem(Image: TComponent);
Var
   LEx: IIntegracaoPixCitelEx;
  LImageStream: TBytesStream;
begin
  if Supports(VS_FuncoesExternas, IIntegracaoPixCitelEx, LEx) then
  begin
    LImageStream := LEx.fICarregaImagemBanco(Image.Name, Self.Name);

    If Not Assigned(LImageStream) Then
      Exit;

    If (Image.ClassName = 'TImage') Then
      TImage(Image).Picture.Graphic.LoadFromStream(LImageStream);

    LImageStream.Free;
  End;
end;

procedure TfrmExibicaoQRCodePix.CarregaTempoMaximoTelaAberta;
  Var
    LValorCFG: Integer;
begin
  If TryStrToInt(fCfgSis('PIXTLA', VS_FuncoesExternas.fGetEmpresaLogada), LValorCFG) Then
  Begin
    FTempoMaximoTelaAberta := LValorCFG * 60000;

    If FTempoMaximoTelaAberta >= 300000 Then
      Exit;
  End;

  FTempoMaximoTelaAberta := 300000;

  untFuncoesSimples.AdicionaAlteraConfiguracao('CFG_PIXTLA',
                                               (FTempoMaximoTelaAberta / 60000).ToString,
                                               VS_FuncoesExternas.fGetEmpresaLogada,
                                               'Tempo da tela do QRCode Pix aberta (entre 5 e 120 minutos)',
                                               'PIX');
end;

function TfrmExibicaoQRCodePix.ChavePixUtilizaShipay: Boolean;
  Var
    LConsulta: IDataset;
begin
  Result := False;

  LConsulta := VS_FuncoesExternas.fGetDataSet;
  LConsulta.SQL := 'SELECT C.* ' +
                   'FROM CCAPIX P ' +
                   'JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ' +
                   'WHERE P.AUTOINCREM="' + FAutoIncremChavePix + '"';
  LConsulta.Open;

  If LConsulta.FindField('CCA_USASHP') <> Nil Then
    Result := LConsulta.FieldByName('CCA_USASHP').AsString = 'S';
end;

function TfrmExibicaoQRCodePix.ChavePixUtilizaTefScope: Boolean;
Var
  LConsulta: IDataset;
begin
  Result := False;

  if not Assigned(objBridgeTef) then
    Exit;

  LConsulta := VS_FuncoesExternas.fGetDataSet;
  LConsulta.SQL := 'SELECT C.* ' +
                   'FROM CCAPIX P ' +
                   'JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ' +
                   'WHERE P.AUTOINCREM="' + FAutoIncremChavePix + '"';
  LConsulta.Open;

  If LConsulta.FindField('CCA_PIXSCP') <> Nil Then
    Result := LConsulta.FieldByName('CCA_PIXSCP').AsString = 'S';
end;

procedure TfrmExibicaoQRCodePix.ConfigurarPopUpPainel;
begin
  If (Screen.MonitorCount > 1) Then
  Begin
    Self.pnlTopo.PopupMenu := Self.popmnuMonitores;
  End;
end;

procedure TfrmExibicaoQRCodePix.CopiarQRCodeAreaTransferencia;
begin
  If Not barQRCodePix.Visible Then
    Exit;

  If FLinkCitel.IsEmpty Then
  Begin
    ClipBoard.AsText := barQRCodePix.Text;

    If Not FRecebimentoPagueFacil Then
      VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'Texto do QRCode (Pix Copia e Cola) copiado para a área de transferência.', ['&Ok']);
  End
  Else
  Begin
    ClipBoard.AsText := TFuncoesPix.RetornaLinkCitel(FLinkCitel);

    If Not FRecebimentoPagueFacil Then
      VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'Link do Texto do QRCode (Pix Copia e Cola) copiado para a área de transferência.', ['&Ok']);
  End;
end;

procedure TfrmExibicaoQRCodePix.CopiarTxIdAreaTransferencia;
begin
  If fCfgSis('HOMPIX', VS_FuncoesExternas.fGetEmpresaLogada) <> 'S' Then
    Exit;

  If FTxIdPix.IsEmpty Then
    Exit;

  ClipBoard.AsText := FTxIdPix;

  If Not FRecebimentoPagueFacil Then
    VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'TxId Pix copiado para a área de transferência.', ['&Ok']);
end;

procedure TfrmExibicaoQRCodePix.DefineMonitorApresentacaoQRCodePix(AMonitor : Integer);
begin
  If (Screen.MonitorCount > 1) then
  begin
    If (AMonitor = 2) Then
    Begin
      If (Self.Monitor.MonitorNum <> 1) Then
      Begin
        Self.Left := Screen.Monitors[0].Width + (Screen.Monitors[1].Width div 2 - (Self.Width div 2));
        Self.Top  := ((Screen.Monitors[1].Height div 2) - (Self.Height div 2));
        Self.MakeFullyVisible(Screen.Monitors[1]);
      End;
    End
    Else If (Self.Monitor.MonitorNum <> 0) Then
    Begin
      Self.Left := (Screen.Monitors[0].Width div 2 - (Self.Width div 2));
      Self.Top  := ((Screen.Monitors[0].Height div 2) - (Self.Height div 2));
      Self.MakeFullyVisible(Screen.Monitors[0]);
    End;
  end;
end;

function TfrmExibicaoQRCodePix.DeveAlterarGerar: Boolean;
begin
  Result := True;

  If DadosPixAlteracao.IsEmpty Then
  Begin
    If Not FTxIdPix.IsEmpty Then
      Exit(False);
  End;

  If FPixAlterado Then
    Exit(False);
end;

procedure TfrmExibicaoQRCodePix.FecharECancelarOPixAutomaticamente;
begin
  tmrAguardar.Enabled := False;
  tmrValidacaoPagamento.Enabled := False;

  FExibirMensagemFechamento := False;
  Self.Close;
end;

function TfrmExibicaoQRCodePix.fGerarQrCodeImagemPinPad(const AstrTexto: String;
  const AstrValor: String; AOwner: TWinControl; var AstrPathDiretorio,
  AstrNomeArquivo: String): Boolean;
var
  LpnlCodigoBarras: TPanel ;
  LpnlValor: TPanel ;
  LCodigoBarras: TdxBarCode ;
  //
  LPngImage: TdxPNGImage;
  LBitmap: TcxBitmap;
  LstrPathImagem: String ;
begin
  AstrPathDiretorio := ExtractFileDir(TPath.GetTempFileName);

  if not EndsStr('\', AstrPathDiretorio) then
    AstrPathDiretorio := AstrPathDiretorio + '\' ;

  AstrNomeArquivo := ExtractFileName(TPath.GetTempFileName) ;
  AstrNomeArquivo := ReplaceStr(AstrNomeArquivo, ExtractFileExt(AstrNomeArquivo), '.png') ;

  LstrPathImagem := AstrPathDiretorio + AstrNomeArquivo ;

  LpnlCodigoBarras := TPanel.Create(AOwner) ;
  LpnlValor := TPanel.Create(LpnlCodigoBarras) ;
  LCodigoBarras := TdxBarCode.Create(LpnlCodigoBarras);
  try
    LpnlCodigoBarras.Parent := AOwner ;
    LpnlValor.Parent := LpnlCodigoBarras ;
    LpnlCodigoBarras.Left   := 82 ;
    LpnlCodigoBarras.Top    := 178 ;
    LpnlCodigoBarras.Width  := 220 ;
    LpnlCodigoBarras.Height := 220 ;
    LpnlCodigoBarras.BorderStyle := bsSingle ;
    LpnlCodigoBarras.Visible := False ;

    LpnlValor.Left          := 1 ;
    LpnlValor.Top           := 1 ;
    LpnlValor.Width         := 218 ;
    LpnlValor.Height        := 24 ;
    LpnlValor.Align         := alTop ;
    LpnlValor.BevelOuter    := bvNone ;
    LpnlValor.Caption       := AstrValor ;
    LpnlValor.Font.Style    := [fsBold] ;
    LpnlValor.ParentFont    := False ;


    LCodigoBarras.Parent := LpnlCodigoBarras ;
    LCodigoBarras.Left := 1 ;
    LCodigoBarras.Top := 25 ;
    LCodigoBarras.Align := alClient ;
    LCodigoBarras.Text := AstrTexto ;
    LCodigoBarras.Properties.BarCodeSymbologyClassName := 'TdxBarCodeQRCodeSymbology' ;
    LCodigoBarras.Properties.FitMode := ifmProportionalStretch ;
    LCodigoBarras.Properties.ShowText := False ;
    LCodigoBarras.Transparent := False ;
    Application.ProcessMessages ;

    LBitmap := TcxBitmap.Create;
    try

      LBitmap.SetSize(LpnlCodigoBarras.BoundsRect);
       LpnlCodigoBarras.Visible := True ;
      try
        cxPaintToBitmap(LpnlCodigoBarras, LBitmap);
      finally
         LpnlCodigoBarras.Visible := False ;
      end ;

      LPngImage := TdxPNGImage.CreateFromBitmap(LBitmap);
      try
        LPngImage.SaveToFile(LstrPathImagem);
      finally
        LPngImage.Free;
      end ;

    finally
      FreeAndNil(LBitmap) ;
    end ;

  finally
    FreeAndNil(LpnlValor) ;
    FreeAndNil(LCodigoBarras) ;
    FreeAndNil(LpnlCodigoBarras) ;
  end ;

  Result := True ;
end;

function TfrmExibicaoQRCodePix.ForcarPagamento(ARetorno: String): String;
begin
  Result := LeftStr(ARetorno, ARetorno.Length - 1);

  Result := StringReplace(Result, 'ATIVA', 'CONCLUIDA', []);
  Result := StringReplace(Result, 'pending', 'approved', []);
  Result := StringReplace(Result, 'pendingv', 'approved', []);

  If Pos('"pix":[],', Result) > 0 Then
    Result := Result.Replace('"pix":[],', EmptyStr);

  Result := Result + ',"pix": ' +
                     '[{"endToEndId":"PAGAMENTOFORCADOTELAQRCODE",' +
                     '"txid":"' + FTxIdPix + '",' +
                     '"valor":"' + ReplaceStr(ReplaceStr(FormatFloat(',0.00', FValorTotal), '.', EmptyStr), ',', '.') + '",' +
                     '"pagador":{"cnpj":"97441842000110","nome":"TELEFONICA BRASIL S.A."},' +
                     '"horario":"' + FormatDateTime('yyyy-mm-dd', fNow) + 'T' + FormatDateTime('hh:mm:ss', fNow) + '-03:00"}]}';
end;

procedure TfrmExibicaoQRCodePix.FormActivate(Sender: TObject);
  Var
    LMonitor : Integer;
begin
  FErro := '';

  Try
    LMonitor := StrToIntDef(fCfgSis('MQRPIX', VS_FuncoesExternas.fGetEmpresaLogada),1);
    DefineMonitorApresentacaoQRCodePix(LMonitor);

    If FFecharFormulario Then
    Begin
      FErro := FMensagemLinks;
      lblMensagemAndamento.Font.Color := clRed;
      tmrValidacaoPagamento.Enabled := False;
      tmrAguardar.Enabled := False;
      tmrForcarFechamento.Enabled := False;

      Exit;
    End;

    If (Not FVerificouToken) and (not FUtilizaTefScope) Then
    Begin
      tmrValidacaoPagamento.Enabled := False;

      lblMensagemAndamento.Caption := 'Aguarde... comunicando com o banco.';

      Self.Update;

      Try
        FRequisicoes.VerificarToken;
      Except
        On E: Exception Do
        Begin
          FErro := TFuncoesPix.RetornaMensagemErroRequisicao(E.Message);
          lblMensagemAndamento.Font.Color := clRed;

          Exit;
        End;
      End;

      FVerificouToken := True;

      fraStepsPix.ConcluirStep(1);
      Self.Update;
    End;

    if FUtilizaTefScope then
    begin
      tmrPixTefScope.Enabled := True;
      exit;
    end;

    If FCriarNovoPix Then
    Begin
      If Not GerarAlterarNovoPix Then
        Exit;
    End
    Else
      RetornaDadosDoPixExistente;

    imgCarregando.Visible := False;
    barQRCodePix.Visible := True;

    pnlValorTotal.Visible := False;
    If FValorTotal > 0 Then
    Begin
      pnlValorTotal.Visible := True;
      lblValorTotal.Caption := 'R$ ' + FormatFloat(',0.00', FValorTotal);
    End;

    FIntervaloConsultas := RetornaIntervaloConsultas;
    tmrValidacaoPagamento.Enabled := True;

    fraStepsPix.ConcluirStep(2);
    Self.Update;
  Finally
    btnCancelar.Enabled := True;

    lblMensagemAndamento.Caption := FErro;

    If FErro.IsEmpty Then
    Begin
      If FControleFechamentoAutomatico = 0 Then
        FControleFechamentoAutomatico := GetTickCount;
    End;
  End;
end;

procedure TfrmExibicaoQRCodePix.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FUtilizaTefScope then
  begin
    FTerminado := True;
    Action := CaFree;
    exit;
  end;

  If FErro.IsEmpty Then
  Begin
    If FResposta.IsEmpty Then
    Begin
      If FCriarNovoPix Then
      Begin
        If Not FTextoQRCode.IsEmpty Then
        Begin
          lblMensagemAndamento.Caption := 'Aguarde... finalizando.';
          FResposta := FRequisicoes.ConsultarPixPorTxId(FTxIdPix, True, FDadosNovoPix);
          FResposta := TFuncoesPix.AdicionaTextoQRCode(FResposta, FTextoQRCode);
        End;
      End;
    End;
  End;

  If FCriarNovoPix Then
  Begin
    tmrValidacaoPagamento.Enabled := False;
    If Not RemoverPixGeradoNoBanco Then
    Begin
      lblMensagemAndamento.Caption := '';
      tmrValidacaoPagamento.Enabled := True;
      Action := CaNone;

      Exit;
    End;
  End;
  FTerminado := True;
  pLimpaQrCodePinPad ;
  pGravaProblemaPinPadLogErr ;

  If FTempoTelaExcedido Then
  Begin
    If Not FRecebimentoPagueFacil Then
      VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'O tempo da tela com o QRCode aberto foi excedido.', ['&Ok']);
  End;

  Action := CaFree;
end;

procedure TfrmExibicaoQRCodePix.FormCreate(Sender: TObject);
begin
  FCntErroPinPad := 0 ;
  FstrNumTer := '' ;
  lblMensagemPinPad.Caption := '' ;
  FblnComandoEmExecPinPad := False ;
  FPinPad := Nil ;
  FTerminado := False;
  FMsgEncerramentoTef := String(fMensagemEncerramentoTEF) ;
  FblnQRCodeEmProcessamentoPeloPinPad := False ;

  FVerificouToken := False;

  FCriarNovoPix := False;

  FPixAlterado := False;

  FValorTotal := 0;
  FContadorConsulta := 0;
  FContadorAguardar := 10;
  FContadorTentativas := 0;

  FErro := '';
  FDadosEnvioRequisicao := '';
  FCodigoCliente := EmptyStr;

  FAmbienteHomologacaoPix := fCfgSis('HOMPIX', VS_FuncoesExternas.fGetEmpresaLogada) = 'S';

  FIntervaloConsultas := 3000;
  FCritical := TCriticalSection.Create() ;

  FControleFechamentoAutomatico := 0;
  FExibirMensagemFechamento := True;
  FTEmpoTelaExcedido := False;

  pEmpilharTelaAberta;

  FRecebimentoPagueFacil := False;

  FTempoMaximoTelaAberta := 300000;
  CarregaTempoMaximoTelaAberta;

  FFecharFormulario := False;
  FMensagemLinks := EmptyStr;
end;

procedure TfrmExibicaoQRCodePix.FormDestroy(Sender: TObject);
begin
  if Assigned(objBridgeTef) then
    objBridgeTef.RemoveObserverPix(Self);

  FCritical.Enter;
  try
    FPinPad := Nil;
  finally
    FCritical.Leave;
  end;

  FreeAndNil(FCritical);
  pRemoverTelaAberta;
end;

procedure TfrmExibicaoQRCodePix.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if FUtilizaTefScope then
    Exit;

  Case Key Of
    VK_F3: CopiarQRCodeAreaTransferencia;
    VK_F5: CopiarTxIdAreaTransferencia;
    VK_F11: ImprimirQRCode;
    VK_F12:
    Begin
      If Shift = [ssShift, ssAlt, ssCtrl] Then
      Begin
        If fCfgSis('HOMPIX', VS_FuncoesExternas.fGetEmpresaLogada) <> 'S' Then
          Exit;

        PostMessage(Handle, InputBoxMsg, 0, 0);

        If InputBox('Palavra Chave', 'Digite a palavra chave', '') <> 'C!t&l133#7' Then
          Exit;

        chkForcarPagamento.Visible := True;
      End;
    End;
  End;
end;

procedure TfrmExibicaoQRCodePix.FormShow(Sender: TObject);
begin
  SetWindowLong(Self.Handle, GWL_STYLE, WS_BORDER);
  Self.Height := Self.Height - GetSystemMetrics(SM_CYCAPTION);
  Self.Refresh;

  barQRCodePix.Text := FTextoQRCode;

  CarregarImagem(imgLogoEmpresa);

  Self.BringToFront;

  FUtilizaShipay := ChavePixUtilizaShipay;
  FUtilizaTefScope := ChavePixUtilizaTefScope;

  lblMensagemAndamento.Caption := '';

  CarregaLogoTelaQRCode;

  imgCarregando.Visible := True;
  ConfigurarPopUpPainel;

  lblRealizarImpressao.Visible := Not FRecebimentoPagueFacil;

  Try
    FRequisicoes := TRequisicoesPix.Create(FAutoIncremChavePix);
  Except
    On E: Exception Do
    Begin
      FRequisicoes := Nil;
      FResposta := EmptyStr;
      FMensagemLinks := E.Message;
      FFecharFormulario := True;
    End;
  End;
end;

function TfrmExibicaoQRCodePix.GerarAlterarNovoPix: Boolean;
  Var
    LRetornoNovoPix: String;

    LNovoPix: TDadosRetornoPixAVista;

    LPixAlteracao: TDadosRetornoPixConsulta;
    LJsonRequestTef, LJsonResponseTef, LJsonDadosTef: String;
    LRespostaStatus: TDadosRetornoPixConsulta;
begin
  Result := True;

  If Not DeveAlterarGerar Then
    Exit;

  lblMensagemAndamento.Caption := 'Aguarde... gerando cobrança.';

  Self.Update;

  FDadosNovoPix := FDadosNovoPix.Replace('"chave": ""', '"chave": "' + FRequisicoes.getChavePix + '"')
                                .Replace('"pix_dict_key": ""', '"pix_dict_key": "' + FRequisicoes.getChavePix + '"')
                                .Replace('"pixKey": ""', '"pixKey": "' + FRequisicoes.getChavePix + '"');

  if FUtilizaTefScope then
  begin
    fraStepsPix.ConcluirStep(1);
    Application.ProcessMessages;
    Self.Update;
    objBridgeTef.AdicionaObserverPix(Self);
    try
      if FRequisicoes.CriarCobrancaTefScope(FDadosNovoPix, LJsonRequestTef, LJsonResponseTef, LJsonDadosTef) then
      begin
        btnCancelar.Enabled := False;
        fraStepsPix.ConcluirStep(3);
        Application.ProcessMessages;
        Self.Update;

        FNovaCobrancaPix.JsonEnviado := LJsonRequestTef;
        FNovaCobrancaPix.JsonRecebidoCriacao := LJsonResponseTef;
        FNovaCobrancaPix.AutoIncremChavePix := FAutoIncremChavePix;
        FNovaCobrancaPix.UtilizaTefScope := 'S';
        FNovaCobrancaPix.CodigoCliente := FCodigoCLiente;
        FNovaCobrancaPix.ChaveDocumento := FChaveDocumento;
        FNovaCobrancaPix.ValorDocumento := FValorDocumento;

        TMonitoramentoNovasCobrancasPix.GravarMonPix_Log(FNovaCobrancaPix);

        FResposta := LJsonResponseTef;
        LRespostaStatus := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LJsonResponseTef);
        FTxIdPix := LRespostaStatus.Txid;
        FValorTotal := LRespostaStatus.Valor;
        FContadorConsulta := 4;
        If AtualizaMonitoramentoNovaCobranca(LRespostaStatus) Then
        Begin
          FNovaCobrancaPix.JsonRecebidoConsulta := FResposta;

          TMonitoramentoNovasCobrancasPix.GravarMonPix_Log(FNovaCobrancaPix);

          FContadorConsulta := -1;
        End;

        Inc(FContadorConsulta);

        If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(LRespostaStatus) Then
        Begin
          If PixComValorPagoDiferenteDaCobranca(LRespostaStatus) Then
            Exit;

          lblMensagemAndamento.Caption := 'Pagamento realizado.';
          fraStepsPix.ConcluirStep(3);
          Application.ProcessMessages;
          Self.Update;

          Sleep(120);

          TMonitoramentoNovasCobrancasPix.RemoverMonPix_Log(FNovaCobrancaPix);

          lblMensagemAndamento.Caption := 'Concluido.';
          fraStepsPix.ConcluirStep(4);
          Application.ProcessMessages;
          Self.Update;
          Sleep(100);
          tmrAguardar.Enabled := False;
          Self.Close;
          Exit;
        End;
      end;
    finally
      objBridgeTef.RemoveObserverPix(Self);
    end;

    Self.Close;
    Exit;
  end;

  If FDadosPixAlteracao.IsEmpty Then
  Begin
    LRetornoNovoPix := FRequisicoes.CriarCobranca(FDadosNovoPix, Self.TransactionType);

    FNovaCobrancaPix.JsonEnviado := FDadosNovoPix;
    FNovaCobrancaPix.JsonRecebidoCriacao := LRetornoNovoPix;
    FNovaCobrancaPix.AutoIncremChavePix := FAutoIncremChavePix;
    FNovaCobrancaPix.UtilizaShipay := FUtilizaShipay;
    FNovaCobrancaPix.CodigoCliente := FCodigoCLiente;
    FNovaCobrancaPix.ChaveDocumento := FChaveDocumento;
    FNovaCobrancaPix.ValorDocumento := FValorDocumento;

    TMonitoramentoNovasCobrancasPix.GravarMonPix_Log(FNovaCobrancaPix);

    FContadorConsulta := 4;
  End
  Else
  Begin
    LPixAlteracao := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(FDadosPixAlteracao,
                                                                  FDadosNovoPix);

    LRetornoNovoPix := FDadosPixAlteracao;
    If TFuncoesPix.RetornaDadosAlteracao(FDadosPixAlteracao, '', FUtilizaShipay) <>
       TFuncoesPix.RetornaDadosAlteracao(FDadosNovoPix, '', FUtilizaShipay) Then
    Begin
      If Not FUtilizaShipay Then
        LRetornoNovoPix := FRequisicoes.AlterarCobranca(FDadosNovoPix,
                                                        LPixAlteracao.TxId)
      Else
      Begin
        FRequisicoes.CancelarCobrancaShipay(LPixAlteracao.TxId);

        LRetornoNovoPix := FRequisicoes.CriarCobranca(FDadosNovoPix, Self.TransactionType);
      End;
    End;

    FPixAlterado := True;

    barQRCodePix.Text := LPixAlteracao.TextoQrCode;
    TextoQRCode := LPixAlteracao.TextoQrCode;
  End;

  FErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRetornoNovoPix);
  If Not FErro.IsEmpty Then
  Begin
    lblMensagemAndamento.Caption := FErro;
    lblMensagemAndamento.Font.Color := clRed;

    Exit(False);
  End;

  LNovoPix := TFuncoesPix.RetornaDadosDoRetornoPixAVista(FDadosNovoPix,
                                                         LRetornoNovoPix,
                                                         FAutoIncremChavePix,
                                                         FUtilizaShipay);

  If MatchStr(LNovoPix.Status, ['ATIVA', 'CONCLUIDA', 'pending', 'pendingv', 'ACTIVE']) Then
  Begin
    FTxIdPix := LNovoPix.Txid;

    If FRequisicoes.GetCodigoDoBanco.Equals('208') Then
      FTxIdPix := LNovoPix.OrderRef;

    FValorTotal := LNovoPix.Valor;

    If Not FPixAlterado Then
    Begin
      barQRCodePix.Text := LNovoPix.TextoQrCode;
      TextoQRCode := LNovoPix.TextoQrCode;
    End;

    If (Not FPixAlterado) And (FOrigemChamada = CONF_DOCS_SIMPLES) Then
    Begin
      If (Assigned(funDisparaWhatsAppAutomatico)) Then
          funDisparaWhatsAppAutomatico('', 'CF', '', '', 'PC', '',
                                       FCodigoCLiente, IIF(barQRCodePix.Text = '', TFuncoesPix.RetornaLinkCitel(LNovoPix.LinkCitel), barQRCodePix.Text));

      If (Assigned(funDisparaEmailAutomatico)) Then
          funDisparaEmailAutomatico('', 'CF', '', '', 'PC', '',
                                    FCodigoCLiente, IIF(barQRCodePix.Text = '', TFuncoesPix.RetornaLinkCitel(LNovoPix.LinkCitel), barQRCodePix.Text));
    End;
  End;

  FLinkCitel := LNovoPix.LinkCitel;
end;

procedure TfrmExibicaoQRCodePix.ImprimirQRCode;
  Var
    LDataset: TUniClientDataset;

    LFilaImpressao: IDataset;

    LNomeFila: String;
Begin
  If FRecebimentoPagueFacil Then
    Exit;

  if FUtilizaTefScope then
    Exit;

  If FValorTotal = 0 Then
    Exit;

  tmrValidacaoPagamento.Enabled := False;
  Try
    LDataset := fCriaDatasetQRCode(barQRCodePix.Text,
                                   'R$ ' + FormatFloat(',0.00', FValorTotal));

    LDataset.Open;
    LDataset.First;

    LFilaImpressao := AbrirCfgRel('frmRcxResumoCaixa_QRCODE');

    if fCfgSis('SPOIMP', VS_FuncoesExternas.fGetEmpresaLogada).Equals('S') then
    begin
      LNomeFila := LFilaImpressao.FieldByName('REL_NOMFIL').AsString;
    end
    else
    begin
      Application.CreateForm(TfrmSelFilImpressao, frmSelFilImpressao);
      try
        frmSelFilImpressao.strFrm := 'frmRcxResumoCaixa_QRCODE';
        frmSelFilImpressao.blnImpressorasCadastradas := False;
        frmSelFilImpressao.FilaImpressao := LFilaImpressao;
        frmSelFilImpressao.CarregaFilaConfigurada;
        If frmSelFilImpressao.strImpSelecionada.IsEmpty Then
          frmSelFilImpressao.ShowModal;
        LNomeFila := frmSelFilImpressao.strImpSelecionada;
      finally
        FreeAndNil(frmSelFilImpressao);
      end;
    end;

    Application.CreateForm(TfrmRelatoriosQRCodeDM, frmRelatoriosQRCodeDM);
    try
      frmRelatoriosQRCodeDM.dtsRelatorio.DataSet := LDataset;
      frmRelatoriosQRCodeDM.frxQRCodePix40C.PrintOptions.Printer := LNomeFila;
      frmRelatoriosQRCodeDM.frxQRCodePix40C.PrintOptions.ShowDialog := LNomeFila.IsEmpty;
      If frmRelatoriosQRCodeDM.frxQRCodePix40C.PrepareReport Then
      Begin
        if LNomeFila.IsEmpty Then
          pPreviewReport('frmRcxResumoCaixa_QRCODE', 'Imprimir QRCode (Pix)', frmRelatoriosQRCodeDM.frxQRCodePix40C)
        Else
          pPrintReport('frmRcxResumoCaixa_QRCODE', 'Imprimir QRCode (Pix)', LNomeFila, frmRelatoriosQRCodeDM.frxQRCodePix40C);
      End;
    finally
      FreeAndNil(frmRelatoriosQRCodeDM);
    end;
  Finally
    tmrValidacaoPagamento.Enabled := True;
  End;
End;

procedure TfrmExibicaoQRCodePix.InputBoxSet(var Msg: TMessage);
  Var
   LContador: integer;
begin
  for LContador := 0 to Screen.Forms[0].ComponentCount-1 do
  begin
    if Screen.Forms[0].Components[LContador] is TEdit then
    begin
      TEdit(Screen.Forms[0].Components[LContador]).PasswordChar := '*';
      TEdit(Screen.Forms[0].Components[LContador]).Clear;
    end;
  end;
end;

procedure TfrmExibicaoQRCodePix.mnuMonitor1Click(Sender: TObject);
begin
  If FFecharFormulario Then
    Exit;

  DefineMonitorApresentacaoQRCodePix(1);
end;

procedure TfrmExibicaoQRCodePix.mnuMonitor2Click(Sender: TObject);
begin
  If FFecharFormulario Then
    Exit;

  DefineMonitorApresentacaoQRCodePix(2);
end;

procedure TfrmExibicaoQRCodePix.OnStatusTef(const AEvento: TPixTefStatusEvento);
var
  LValorPix: Double;
  LjsonValor: TJSONValue;
  LobjRoot: TJSONObject;
  LStringValor: String;
  LQrCode: String;
begin
  if AEvento.Codigo = 5 then /// mostrar QR-Code
  begin
    LQrCode := String(AEvento.Mensagem);
    barQRCodePix.Text := LQrCode;
    TextoQRCode := String(AEvento.Mensagem);
    LValorPix := 0;
    if not Trim(String(AEvento.JsonExtra)).IsEmpty then
    begin
      LjsonValor := TJSONObject.ParseJSONValue(String(AEvento.JsonExtra));
      try
        if (LjsonValor is TJSONObject) then
        begin
          LobjRoot  := LjsonValor as TJSONObject;
          if not LobjRoot.TryGetValue<Double>('valor', LValorPix) then
            LValorPix := 0;
        end;
      finally
        FreeAndNil(LjsonValor);
      end;
    end;
    imgCarregando.Visible := False;
    barQRCodePix.Visible := True;

    pnlValorTotal.Visible := False;
    LStringValor := 'R$ ' + FormatFloat(',0.00', LValorPix);
    If LValorPix > 0 Then
    Begin
      pnlValorTotal.Visible := True;
      lblValorTotal.Caption := LStringValor;
    End;

    if Assigned(objBridgeTef) then
    begin
      FQrCodePendente := LQrCode;
      FValorPendente := LStringValor;
      PostMessage(Self.Handle, WM_USER + 100, 0, 0);
    end;

    fraStepsPix.ConcluirStep(2);
    Application.ProcessMessages;
    Self.Update;
    exit;
  end;
  lblMensagemAndamento.Caption := String(AEvento.Mensagem);
end;

procedure TfrmExibicaoQRCodePix.ParadaAuxiliarParaHabilitarAConsulta(
  ATextoQRCode: String);
begin
  If Pos('sicoob.com.br', barQRCodePix.Text) > 0 Then
    Sleep(2500)
  Else If Pos('pagseguro.com', barQRCodePix.Text) > 0 Then
    Sleep(2700);
end;

procedure TfrmExibicaoQRCodePix.pEmpilharTelaAberta;
begin
  FTelas := untTelasAbertas.objTelasAbertas;

  If Assigned(FTelas) Then
    FTelas.AddFormAndSetPopupMode(Self);
end;

procedure TfrmExibicaoQRCodePix.pEnviaQrCodePinPad(const AstrTextoQrCode,
  AstrTituloInformativo: String);
begin
  if FblnQRCodeEmProcessamentoPeloPinPad then
    Exit ;

  pSetQrCodeEmProcessamentoPeloPinPad(True) ;
  FCritical.Enter;
  try
    if FTerminado then
      Exit;

    if FblnComandoEmExecPinPad then
    begin
      if not Assigned(FPinPad) then
        Exit ;

      FPinPad.pAbortarUltimoComando ;
      FblnComandoEmExecPinPad := False ;
    end ;

    pEnviaQrCodeInterno(AstrTextoQrCode, AstrTituloInformativo, FPinPad) ;

    if not Assigned(Self) then
      Exit ;

    FblnComandoEmExecPinPad := True ;
  finally
    FCritical.Leave;
    pNotificaProblemaComunicacaoPinPad ;
    pSetQrCodeEmProcessamentoPeloPinPad(False) ;
  end ;

end;

procedure TfrmExibicaoQRCodePix.pForcaAtualizacaoPinPad;
var
  LstrValorParam1: String ;
  LstrValorParam2: String ;
begin
  if trim(FTextoQRCode) <> '' then
  begin
    if not Assigned(FPinPad) then
      FPinPad := fInstanciaPinPad(FstrNumTer) ;

    if not Assigned(FPinPad) then
      Exit ;

    lblMensagemPinPad.Caption := 'Aguarde enviando o QR Code PIX para o PinPAD...';
    lblMensagemPinPad.Font.Style := [fsBold] ;
    Application.ProcessMessages ;

    LstrValorParam1 := FTextoQRCode ;
    LstrValorParam2 := 'Valor: '+ FormatFloat('##,##0.00', FValorTotal) ;
    pRetornaValorParametrosPinPad(LstrValorParam1, LstrValorParam2) ;

    TThread.CreateAnonymousThread(
    procedure
    begin
      if FTerminado then
        Exit;

      pEnviaQrCodePinPad(LstrValorParam1, LstrValorParam2) ;
    end).Start;
  end ;
end;

procedure TfrmExibicaoQRCodePix.pGravaProblemaPinPadLogErr;
begin
  if not Assigned(Self) then
    Exit ;

  if not Assigned(FPinPad) then
    Exit ;

  if Trim(FPinPad.fMsgErroAcesso) = '' then
    Exit ;

  GravarLogErr_Pix('PinPad', FPinPad.fMsgErroAcesso, FstrNumTer) ;

end;

function TfrmExibicaoQRCodePix.PixComValorPagoDiferenteDaCobranca(
  var ADadosResposta: TDadosRetornoPixConsulta): Boolean;
begin
  Result := FormatFloat(',0.00', FValorTotal) <>
            FormatFloat(',0.00', ADadosResposta.ValorPago);

  If Not Result Then
    Exit;

  FErro := 'Erro: O valor pago do Pix de ' + FormatFloat(',0.00', ADadosResposta.ValorPago) +
           ' não corresponde ao valor da cobrança.' + #13 +
           'Não é possível gravar uma cobrança inconistente.';
  lblMensagemAndamento.Font.Color := clRed;

  GravarLogErr_Pix('Pix Com Valor Pago Diferente Da Cobrança',
                   FErro + #13 + #13 +
                   'Json Retorno: ' + ADadosResposta.JsonRetorno);
end;

procedure TfrmExibicaoQRCodePix.pLimpaQrCodePinPad;
var
  LintCnt: Integer ;
begin
  if not Assigned(FPinPad) then
    Exit ;

  if not Assigned(Self) then
    Exit ;

  if FblnQRCodeEmProcessamentoPeloPinPad then
  begin
    LintCnt := 0 ;
    while True do
    begin
      lblMensagemAndamento.Caption := 'Aguarde encerrando comunicação com o PinPad!';
      lblMensagemAndamento.Font.Color := clRed;
      lblMensagemPinPad.Update;
      Sleep(1000) ;
      if not FblnQRCodeEmProcessamentoPeloPinPad then
        break ;

      LintCnt := LintCnt + 1 ;
      // espera até 20 segundos, se o PinPad não responder não executa nenhum comando no PinPad para evitar access violation
      if LintCnt >= 20 then
        Exit ;
    end ;
  end ;

  pLimpaQrCodeInterno(FPinPad, FMsgEncerramentoTef) ;
  FblnComandoEmExecPinPad := False ;
end;

procedure TfrmExibicaoQRCodePix.pNotificaProblemaComunicacaoPinPad;
begin
  if not Assigned(Self) then
    Exit ;

  if not Assigned(FPinPad) then
    Exit ;

  if Trim(FPinPad.fMsgErroAcesso) = '' then
    Exit ;

  if FTerminado then
    Exit ;

  FCritical.Enter;
  try
    pLimpaQrCodeInterno(FPinPad, FMsgEncerramentoTef) ;
  finally
    FCritical.Leave;
  end ;

  FblnComandoEmExecPinPad := False ;

end;

procedure TfrmExibicaoQRCodePix.pRemoverTelaAberta;
begin
  If Assigned(FTelas) Then
    FTelas.RemoveFormParent(Self);
end;

procedure TfrmExibicaoQRCodePix.pRetornaValorParametrosPinPad(
  var AstrValorParam1, AstrValorParam2: String);
var
  LstrPathDiretorio, LstrNomeArquivo: String ;
begin
  if fObtemFabricantePinPad = ppcfScope then
  begin
    fGerarQrCodeImagemPinPad(AstrValorParam1,
                             AstrValorParam2,
                             Self,
                             LstrPathDiretorio,
                             LstrNomeArquivo) ;
    AstrValorParam1 := LstrPathDiretorio ;
    AstrValorParam2 := LstrNomeArquivo ;
  end ;
end;

procedure TfrmExibicaoQRCodePix.pSetQrCodeEmProcessamentoPeloPinPad(
  const AblnProcessando: Boolean);
begin
  if not Assigned(Self) then
    Exit ;

  Self.FCritical.Enter();
  try
    FblnQRCodeEmProcessamentoPeloPinPad := AblnProcessando ;
  finally
    Self.FCritical.Leave();
  end ;
end;

procedure TfrmExibicaoQRCodePix.pSetTextoQRCode(const AstrValor: String);
var
  LstrValorParam1, LstrValorParam2: String ;
begin
  if FUtilizaTefScope then
  begin
    FTextoQRCode := AstrValor ;
    exit;
  end;

  if (trim(AstrValor) <> '') and (AstrValor <> FTextoQRCode) then
  begin

    if not Assigned(FPinPad) then
      FPinPad := fInstanciaPinPad(FstrNumTer) ;

    if (FValorTotal <> 0.00) and (Assigned(FPinPad)) then
    begin
      lblMensagemPinPad.Caption := 'Aguarde enviando o QR Code PIX para o PinPAD...';
      lblMensagemPinPad.Font.Style := [fsBold] ;
      Application.ProcessMessages ;

      LstrValorParam1 := AstrValor ;
      LstrValorParam2 := 'Valor: '+ FormatFloat('##,##0.00', FValorTotal) ;
      pRetornaValorParametrosPinPad(LstrValorParam1, LstrValorParam2) ;

      TThread.CreateAnonymousThread(
      procedure
      begin
        pEnviaQrCodePinPad(LstrValorParam1, LstrValorParam2) ;
      end).Start;
    end ;

  end ;
  FTextoQRCode := AstrValor ;
end;

function TfrmExibicaoQRCodePix.RemoverPixGeradoNoBanco: Boolean;
  Var
    LErro,
    LRetornoJson,
    LRequisicaoJson,
    LTxIdRemover: String;

    LDadosPix: TDadosRetornoPixConsulta;
begin
  Result := True;

  Try
    If Not FResposta.IsEmpty Then
    Begin
      If FCriarNovoPix Then
      Begin
        LDadosPix := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(FResposta, FDadosNovoPix);

        If Not MatchStr(LDadosPix.Status, STATUS_PIX_ATIVO) Then
          Exit;

        Result := Not FExibirMensagemFechamento;

        If Not Result Then
        Begin
          If FRecebimentoPagueFacil Then
            Result := True
          Else
          Begin
            FMensagemRemoverPix := TfrmMensagemRemoverPix.Create(Self);

            Try
              tmrForcarFechamento.Enabled := True;

              FMensagemRemoverPix.lblMensagem.Caption := 'Foi gerada uma cobrança Pix para o recebimento.' + #13 +
                                                         'Se continuar, o sistema cancelará o registro do Pix junto ao banco.' + #13 +
                                                         'Deseja realmente continuar?';

              FMensagemRemoverPix.ShowModal;

              Result := FMensagemRemoverPix.OpcaoSelecionada = 1;
            Finally
              FreeAndNil(FMensagemRemoverPix);
            End;
          End;
        End;

        If Not Result Then
          Exit;

        Try
          If Not FUtilizaShipay Then
          Begin
            LRequisicaoJson := '{"status": "REMOVIDA_PELO_USUARIO_RECEBEDOR", ' +
                               ' "valor": {' +
                               '  "original": "0.00"} ' +
                               '}';

            LTxIdRemover := FTxIdPix;
            If Not LDadosPix.OrderRef.IsEmpty Then
            Begin
              LTxIdRemover := LDadosPix.OrderRef;
              FRequisicoes.SetTxIdRemoverBancoBtg(LDadosPix.TxId);
            End;

            LRetornoJson := FRequisicoes.AlterarCobranca(LRequisicaoJson, LTxIdRemover);
          End
          Else
            LRetornoJson := FRequisicoes.CancelarCobrancaShipay(FTxIdPix);

          FResposta := '';

          LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRetornoJson);
          If Not LErro.IsEmpty Then
            Raise Exception.Create(LErro);

          TMonitoramentoNovasCobrancasPix.RemoverMonPix_Log(FNovaCobrancaPix);
        Except
          //Erro sendo gravado direto na requisição.
        End;
      End;

      FTEmpoTelaExcedido := FControleFechamentoAutomatico + FTempoMaximoTelaAberta < GetTickCount;
    End;
  Finally
    tmrForcarFechamento.Enabled := False;
  End;
end;

procedure TfrmExibicaoQRCodePix.RetornaDadosDoPixExistente;
  Var
    LConsulta: IDataset;
begin
  LConsulta := VS_FuncoesExternas.fGetDataSet;
  LConsulta.SQL := 'SELECT * FROM MOVPIX ' +
                   'WHERE AUTOINCREM="' + FAutoIncremMovPix + '"';
  LConsulta.Open;

  FValorTotal := 0.00;
  If Not LConsulta.IsEmpty Then
  Begin
    FValorTotal :=  LConsulta.FieldByName('MPX_VALPIX').AsFloat;
    pForcaAtualizacaoPinPad ;
    FDadosEnvioRequisicao := LConsulta.FieldByName('MPX_JSOENV').AsString;

    If LConsulta.FindField('MPX_LNKCIT') <> Nil Then
      FLinkCitel := LConsulta.FieldByName('MPX_LNKCIT').AsString;

    If FRequisicoes.GetCodigoDoBanco.Equals('208') Then
      FTxIdPix := LConsulta.FieldByName('MPX_ORDREF').AsString;
  End;
end;

function TfrmExibicaoQRCodePix.RetornaIntervaloConsultas: Integer;
begin
  Result := 3000;
  If barQRCodePix.Text.Contains('sicredi.com.br') Then
    Result := 7000;
end;

procedure TfrmExibicaoQRCodePix.tmrAguardarTimer(Sender: TObject);
begin
  If FFecharFormulario Then
    Exit;

  Inc(FContadorAguardar, -1);

  If FContadorAguardar <= 0 Then
  Begin
    tmrAguardar.Enabled := False;
    lblContadorCOnsulta.Caption := 'Nova tentativa de realizar consulta...';
    Application.ProcessMessages;
    FContadorAguardar := 10;

    FControleFechamentoAutomatico := FControleFechamentoAutomatico + 10000;

    tmrValidacaoPagamentoTimer(tmrValidacaoPagamento);
    Exit;
  End;

  lblContadorCOnsulta.Caption := 'Aguarde... Nova tentativa de consulta será realizada em ' + FContadorAguardar.ToString + ' segundos.';
  Application.ProcessMessages;
end;

procedure TfrmExibicaoQRCodePix.tmrForcarFechamentoTimer(Sender: TObject);
  Var
    LTempoAtual: Cardinal;
begin
  LTempoAtual := GetTickCount;

  If (FControleFechamentoAutomatico + FTempoMaximoTelaAberta + 5000 < LTempoAtual) Then
  Begin
    FExibirMensagemFechamento := False;

    If Assigned(FMensagemRemoverPix) Then
      FMensagemRemoverPix.btnNao.Click;

    Sleep(800);

    tmrForcarFechamento.Enabled := False;

    Self.Close;
  End;
end;

procedure TfrmExibicaoQRCodePix.tmrPixTefScopeTimer(Sender: TObject);
begin
  tmrPixTefScope.Enabled := False;
  lblCopiarQRCode.Visible := False;
  lblRealizarImpressao.Visible := False;
  GerarAlterarNovoPix;
end;

procedure TfrmExibicaoQRCodePix.tmrValidacaoPagamentoTimer(Sender: TObject);
  Var
    LRespostaStatus: TDadosRetornoPixConsulta;

    LDadosEnvio: String;
begin
  If FFecharFormulario Then
    Exit;

  if FUtilizaTefScope then
    Exit;

  If tmrValidacaoPagamento.Interval <> FIntervaloConsultas Then
    tmrValidacaoPagamento.Interval := FIntervaloConsultas;

  tmrValidacaoPagamento.Enabled := False;

  Try
    lblMensagemAndamento.Caption := 'Aguarde... Validando pagamento.';
    lblMensagemAndamento.Font.Color := clBlack;

    lblContadorCOnsulta.Caption := EmptyStr;

    if not FblnQRCodeEmProcessamentoPeloPinPad then
    begin
      lblMensagemPinPad.Caption := '';
      lblMensagemPinPad.Font.Style := [] ;
      lblMensagemPinPad.Update;
      if Assigned(FPinPad) and (Trim(FPinPad.fMsgErroAcesso) <> '') and (FCntErroPinPad <=1) then
      begin
        lblMensagemPinPad.Caption := 'Excepcionalmente o QR Code PIX, está sendo apresentado somente aqui na Tela';
        lblMensagemPinPad.Font.Color := clRed;
        lblMensagemPinPad.Update;
        Inc(FCntErroPinPad) ;
      end ;
    end ;

    btnCancelar.Enabled := False;

    LDadosEnvio := FDadosNovoPix;
    If Not FDadosEnvioRequisicao.IsEmpty Then
      LDadosEnvio := FDadosEnvioRequisicao;

    FResposta := FRequisicoes.ConsultarPixPorTxId(FTxIdPix, True, LDadosEnvio);
    FResposta := TFuncoesPix.AdicionaTextoQRCode(FResposta, FTextoQRCode);

    if chkForcarPagamento.Checked THen
      FResposta := ForcarPagamento(FResposta);

    FErro := TFuncoesPix.RetornaMensagemErroRequisicao(FResposta);
    If Not FErro.IsEmpty Then
    Begin
      lblMensagemAndamento.Font.Color := clRed;

      Inc(FContadorTentativas);
      tmrAguardar.Enabled := FContadorTentativas <= 3;

      Exit;
    End;

    If Not FLinkCitel.IsEmpty Then
      FResposta := LeftStr(FResposta, FResposta.Length - 1) + ', "linkCitel": "' + FLinkCitel + '"}';

    LRespostaStatus := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(FResposta, LDadosEnvio);

    BancoDoBrasilEmHomologacaoPagoEAindaAtivo(LRespostaStatus); //Para corrigir um erro do ambiente de homologação do BB

    If AtualizaMonitoramentoNovaCobranca(LRespostaStatus) Then
    Begin
      FNovaCobrancaPix.JsonRecebidoConsulta := FResposta;

      TMonitoramentoNovasCobrancasPix.GravarMonPix_Log(FNovaCobrancaPix);

      FContadorConsulta := -1;
    End;

    Inc(FContadorConsulta);

    If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(LRespostaStatus) Then
    Begin
      If PixComValorPagoDiferenteDaCobranca(LRespostaStatus) Then
        Exit;

      lblMensagemAndamento.Caption := 'Pagamento realizado.';
      fraStepsPix.ConcluirStep(3);
      Application.ProcessMessages;
      Self.Update;

      Sleep(120);

      TMonitoramentoNovasCobrancasPix.RemoverMonPix_Log(FNovaCobrancaPix);

      lblMensagemAndamento.Caption := 'Concluido.';
      fraStepsPix.ConcluirStep(4);
      Application.ProcessMessages;
      Self.Update;
      Sleep(100);

      Self.Close;
      Exit;
    End;

    AtualizarDataUltimaRequisicaoTela(FAutoIncremMovPix);

    ParadaAuxiliarParaHabilitarAConsulta(barQRCodePix.Text);

    tmrValidacaoPagamento.Enabled := True;
  Finally
    btnCancelar.Enabled := True;

    lblMensagemAndamento.Caption := FErro;

    If FErro.IsEmpty Then
      ValidaFechamentoDeTelaAutomatico;
  End;
end;

procedure TfrmExibicaoQRCodePix.ValidaFechamentoDeTelaAutomatico;
begin
  If GetTickCount - FControleFechamentoAutomatico < FTempoMaximoTelaAberta Then
    Exit;

  If GetTickCount - FControleFechamentoAutomatico >= FTempoMaximoTelaAberta Then
    FecharECancelarOPixAutomaticamente;
end;

procedure TfrmExibicaoQRCodePix.WMEnviarQrCode(var Msg: TMessage);
begin
  if Assigned(objBridgeTef) then
    objBridgeTef.pEnviarQrCode(FQrCodePendente, FValorPendente);
end;

end.
