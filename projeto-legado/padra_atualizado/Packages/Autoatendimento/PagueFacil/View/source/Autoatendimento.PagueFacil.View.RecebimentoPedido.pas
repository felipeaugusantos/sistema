unit Autoatendimento.PagueFacil.View.RecebimentoPedido;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects, FMX.Media,
  FMX.TabControl, Autoatendimento.PagueFacil.Frame.fmxItensPedido, FMX.Ani,
  FMX.ListBox, FMX.Edit, Autoatendimento.PagueFacil.Interfaces, FMX.Filter.Effects,
  System.Actions, FMX.ActnList, DateUtils, FMX.ScrollBox, FMX.Memo, StrUtils,
  AVPlayer, System.IniFiles, System.Math;

Type
  TTipoCartao = (opcDebito, opcCredito, opcPix);

type
  TfmxRecebimentoPedido = class(TForm)
    layPrincipal: TLayout;
    recPubli: TRectangle;
    imgLogoCitel: TImage;
    recCodigoBarras: TRectangle;
    ShadowEffect1: TShadowEffect;
    lblCodigoBarras: TLabel;
    ShadowEffect2: TShadowEffect;
    tabTelas: TTabControl;
    tabCodigoBarras: TTabItem;
    tabInformacoesPedido: TTabItem;
    recPrincipal: TRectangle;
    imgFundo: TImage;
    recFundoInformacoesPedido: TRectangle;
    recDadosItensPedido: TRectangle;
    recTopo: TRectangle;
    efeSombra: TShadowEffect;
    linTopoDadosPedido: TLine;
    lblNumeroPedido: TLabel;
    fraItensPedido: TframeItensPedido;
    recRodape: TRectangle;
    layTotais: TLayout;
    linTotais: TLine;
    lblTotalPagarCap: TLabel;
    lblTotalPagarVal: TLabel;
    lblDadosEntrega: TLabel;
    layDadosCliente: TLayout;
    lblNomeCliente: TLabel;
    lblCPFCliente: TLabel;
    lblEnderecoCliente: TLabel;
    lblBairroCliente: TLabel;
    lblCEPCliente: TLabel;
    lblTelefoneCliente: TLabel;
    linDadosEntrega: TLine;
    layDadosEntrega: TLayout;
    lblEnderecoEntrega: TLabel;
    lblBairroEntrega: TLabel;
    lblCEPEntrega: TLabel;
    recFormaPagamento: TRectangle;
    recSelecionaFormaPagamento: TRectangle;
    lblCredito: TLabel;
    lblDebito: TLabel;
    lblFormaPagamento: TLabel;
    lblParcelas: TLabel;
    lblDadosClientes: TLabel;
    linDadosCliente: TLine;
    recBotaoPagar: TRectangle;
    recCancelar: TRectangle;
    lblCancelar: TLabel;
    lblPagar: TLabel;
    tabPagamentoCartao: TTabItem;
    recFundoPagamentoCartao: TRectangle;
    recMensagensTEF: TRectangle;
    tabConfirmacaoPagamento: TTabItem;
    recPagamentoEfetuado: TRectangle;
    lblMensagensTEF: TLabel;
    layDadosPedido: TLayout;
    layComponentes: TLayout;
    layInfoCartao: TLayout;
    edtCodigoBarras: TEdit;
    lstProdutos: TListBox;
    lstItem1: TListBoxItem;
    lblCidadeCliente: TLabel;
    lblCidadeEntrega: TLabel;
    lblErroPedido: TLabel;
    layCodigoBarras: TLayout;
    layInformacoesPedido: TLayout;
    layPagamentoCartao: TLayout;
    layConfirmacaoPagamento: TLayout;
    recTransparente: TRectangle;
    lblErroCodigoBarras: TLabel;
    linCursor: TLine;
    TimerCursor: TTimer;
    lblHora: TLabel;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    flwTotalizacao: TFlowLayout;
    layValorIPI: TLayout;
    lblValorIPICap: TLabel;
    lblValorIPIVal: TLabel;
    layDescEspecial: TLayout;
    lblDescEspecialVal: TLabel;
    lblDescEspecialCap: TLabel;
    layValorST: TLayout;
    lblValorSTVal: TLabel;
    lblValorSTCap: TLabel;
    layDescAcessorias: TLayout;
    lblDescAcessoriasVal: TLabel;
    lblDescAcessoriasCap: TLabel;
    layValorFCP: TLayout;
    lblValorFCPVal: TLabel;
    lblValorFCPCap: TLabel;
    layValorFrete: TLayout;
    lblValorFreteVal: TLabel;
    lblValorFreteCap: TLabel;
    laySubTotal: TLayout;
    lblSubTotalCap: TLabel;
    lblSubTotalVal: TLabel;
    layTotalPagar: TLayout;
    layAguarde: TLayout;
    cirFundoBranco: TCircle;
    arcAguarde: TArc;
    aniRodar: TFloatAnimation;
    aniDiminuir: TFloatAnimation;
    layCheck: TLayout;
    recFundoBranco: TRectangle;
    recFundoAzul: TRectangle;
    cirPonto: TCircle;
    patCheck: TPath;
    lblPagamentoEfetuado: TLabel;
    Button1: TButton;
    imgMaquinaFechada: TImage;
    imgMaquinaAberta: TImage;
    imgCartaoMao: TImage;
    imgCartao: TImage;
    imgRecibo: TImage;
    lblMaquina: TLabel;
    recImage: TImage;
    timerAds: TTimer;
    recCarregando: TRectangle;
    aniCarregando: TFloatAnimation;
    memErros: TMemo;
    imgLog: TImage;
    btnLogErros: TSpeedButton;
    lblValorParcela: TLabel;
    layOpcoesParcelas: TLayout;
    recFundoParcelas: TRectangle;
    recSelecionaParcela: TRectangle;
    lstParcelas: TListBox;
    lstIteParcela1: TListBoxItem;
    lstIteParcela2: TListBoxItem;
    lstIteParcela3: TListBoxItem;
    lstIteParcela4: TListBoxItem;
    lstIteParcela5: TListBoxItem;
    lstIteParcela6: TListBoxItem;
    lstIteParcela7: TListBoxItem;
    lstIteParcela8: TListBoxItem;
    lstIteParcela9: TListBoxItem;
    lstIteParcela10: TListBoxItem;
    lstIteParcela11: TListBoxItem;
    lstIteParcela12: TListBoxItem;
    recEscondeDireita: TRectangle;
    recEscondeEsquerda: TRectangle;
    laySetaEsquerda: TLayout;
    patEsquerda: TPath;
    laySetaDireita: TLayout;
    patDireita: TPath;
    timerErro: TTimer;
    recTravaTela: TRectangle;
    layAguardeMenor: TLayout;
    cirFundoBrancoMenor: TCircle;
    arcAguardeMenor: TArc;
    aniRodarMenor: TFloatAnimation;
    btnAbrirTeclado: TRectangle;
    btnFecharTeclado: TRectangle;
    recTeclado: TRectangle;
    rec7: TRectangle;
    rec4: TRectangle;
    rec1: TRectangle;
    recBackspace: TRectangle;
    rec8: TRectangle;
    rec5: TRectangle;
    rec0: TRectangle;
    rec2: TRectangle;
    rec9: TRectangle;
    rec6: TRectangle;
    rec3: TRectangle;
    recLimpar: TRectangle;
    lbl0: TLabel;
    lbl2: TLabel;
    lbl9: TLabel;
    lbl6: TLabel;
    lbl3: TLabel;
    lblLimpar: TLabel;
    lbl7: TLabel;
    lbl4: TLabel;
    lbl1: TLabel;
    lblBackspace: TLabel;
    lbl8: TLabel;
    lbl5: TLabel;
    player: TAVPlayer;
    recVideo: TAVView;
    lblPix: TLabel;
    imgPix: TImage;
    procedure FormCreate(Sender: TObject);
    procedure lblCreditoClick(Sender: TObject);
    procedure lblDebitoClick(Sender: TObject);
    procedure tabTelasChange(Sender: TObject);
    procedure lblCreditoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure edtCodigoBarrasChange(Sender: TObject);
    procedure lblPagarMouseEnter(Sender: TObject);
    procedure lblPagarMouseLeave(Sender: TObject);
    procedure edtCodigoBarrasChangeTracking(Sender: TObject);
    procedure lblPagarClick(Sender: TObject);
    procedure lblCancelarClick(Sender: TObject);
    procedure TimerCursorTimer(Sender: TObject);
    procedure edtCodigoBarrasExit(Sender: TObject);
    procedure edtCodigoBarrasEnter(Sender: TObject);
    procedure edtCodigoBarrasClick(Sender: TObject);
    procedure edtCodigoBarrasKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure aniDiminuirFinish(Sender: TObject);
    procedure recMensagensTEFDblClick(Sender: TObject);
    procedure timerAdsTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aniCarregandoFinish(Sender: TObject);
    procedure recPrincipalDblClick(Sender: TObject);
    procedure btnLogErrosClick(Sender: TObject);
    procedure laySetaEsquerdaClick(Sender: TObject);
    procedure laySetaDireitaClick(Sender: TObject);
    procedure lstIteParcela1Click(Sender: TObject);
    procedure timerErroTimer(Sender: TObject);
    procedure playerPlaybackFinished(Sender: TObject);
    procedure btnAbrirTecladoClick(Sender: TObject);
    procedure btnFecharTecladoClick(Sender: TObject);
    procedure rec7Click(Sender: TObject);
    procedure recLimparClick(Sender: TObject);
    procedure rec7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rec7MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure recBackspaceMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure lblPixClick(Sender: TObject);
    procedure lblDebitoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure lblPixMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure lblPagarDblClick(Sender: TObject);
    procedure lblCancelarDblClick(Sender: TObject);
  private
    { Private declarations }
    FPagueFacil : IAutoatendimentoPagueFacilRecebimentoPedido;
    FArquivosAds: TStringList;
    FCallLogTot: TCallLogTot;
    FExceptionLogErr: Exception;
    LPedNotPau : String;
    FProcessando: Boolean;

    procedure AtualizarInformacoes(AMostrarCPF : Boolean = True);
    procedure AtualizarPagamento;
    procedure AtualizaItensPedido;
    procedure AtualizaParcelamento(ANumParcelas: Integer);
    procedure AjustaLayoutTotalizacoes;
    procedure EsconderParcelas;
    procedure MostrarParcelas;
    procedure MostraMensagem(AMsg, ATipo:String);
    procedure NovoPedido;
    procedure PagamentoConcluido;
    procedure MudarTab(ATab: TTabItem);
    procedure MostrarErroNoCodigoBarras(MsgErro: String);
    procedure AcertaTelaTipoPagamento;
    procedure EscondeCursor;
    procedure MoveCursor(Key: Word);
    procedure PiscaCursor;
    procedure FinalizaAnimacao;
    procedure ListarAds(Var Lista: TStringList);
    procedure CarregaAd(AArquivo: String);
    procedure DesabilitarBotoes(LeftDestino: Single);
    procedure SetaFormaPagamento(ATipo : TTipoCartao);
    procedure HabilitaParcelamento;
    procedure DesabilitaParcelamento;
    procedure MoverListaParcelas(ANumParcelas: Integer);
    procedure MarcarParcelaEscolhida(ANumParcela: Integer);
    procedure LimparErroCodigoBarras;
    procedure MensagensDoTEF(AMsg: String);
    procedure TravarTela(Travar:Boolean);
    procedure MostrarAguarde(Mostrar:Boolean);
    procedure InformarParcelas;
    procedure HabilitarParcelas;
    procedure StopAds;
    procedure PlayAds;
    procedure pAtualizaParcelamentoComTrava;
    procedure pSelecionaParcelaComTrava(intTag : Integer);
    procedure PedeCPFSeConsumidor;
    procedure PerguntaIdentificacaoCliente;
    procedure MensagemOk(ATitulo, AMensagem: String);

    Function DiaAtualCompleto: String;
    Function DiaDaSemana(Data: TDateTime): String;
    Function MesDoAno(Data: TDateTime): String;
    Function EhLayoutDeTotalizacaoEEstaVisivel(Sender: TObject): Boolean;
    Function RetornaSoNumeros(ATexto: String): String;
    function fStrZero(Zeros:string;Quant:integer):String;
    function PosicaoDaLista: Single;
    function fTravaOpcaoCredito : Boolean;
    function TravaOpcaoPix: Boolean;
    function Pergunta(ATitulo, AMensagem: String) : Integer;
    function InputBoxFmx(ADescricao: String): String;
    function TravaFormaPagamento: Boolean;

    function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;

  public
    { Public declarations }
    procedure OnMensagemAoUsuario(AMsg: String);
    procedure OnMensagemDeErro(AMsg: String);
    procedure OnMensagemAguarde(AMsg: String);
    property CallLogTot: TCallLogTot read FCallLogTot write FCallLogTot;
  published
    property PagueFacil: IAutoatendimentoPagueFacilRecebimentoPedido Read FPagueFacil write FPagueFacil;
  end;

var
  fmxRecebimentoPedido: TfmxRecebimentoPedido;

Const
  CorVermelha   = TAlphaColor($FFEB5757);
  CorAzulEscuro = TAlphaColor($FF1E202C);
  ExtensaoImagens = 'jpg_jpeg_bmp_png_';
  ExtensaoVideos  = 'avi_mp4_wmv_mov_';

implementation

Uses IOUtils, Autoatendimento.PagueFacil.View.Pergunta,
  Autoatendimento.PagueFacil.View.InputBox,
  Autoatendimento.PagueFacil.View.Mensagem;

{$R *.fmx}

procedure TfmxRecebimentoPedido.AjustaLayoutTotalizacoes;
Var
  LContador, LVisiveis :Integer;
begin
  LVisiveis := 0;

  layDescEspecial.Visible   := FPagueFacil.Pedido.DescontoEspecial <> 0;
  layDescAcessorias.Visible := FPagueFacil.Pedido.DespesasAcessorias <> 0;
  layValorFrete.Visible     := FPagueFacil.Pedido.ValorFrete <> 0;
  layValorIPI.Visible       := FPagueFacil.Pedido.TotalIPI <> 0;
  layValorST.Visible        := FPagueFacil.Pedido.TotalST <> 0;
  layValorFCP.Visible       := FPagueFacil.Pedido.TotalFCP_ST <> 0;

  For LContador := 0 to Self.ComponentCount - 1 do
  Begin
    If EhLayoutDeTotalizacaoEEstaVisivel(Self.Components[LContador]) Then
      Inc(LVisiveis);
  End;

  If (LVisiveis = 0) Then
    laySubTotal.Height := 0
  Else
    laySubTotal.Height := 25;

  Case LVisiveis Of
    0:   flwTotalizacao.Height := 25;
    1,2: flwTotalizacao.Height := 50;
    3,4: flwTotalizacao.Height := 75;
    5,6: flwTotalizacao.Height := 100;
  End;

  layTotais.Height := layTotalPagar.Height + flwTotalizacao.Height + laySubTotal.Height;
end;

procedure TfmxRecebimentoPedido.aniCarregandoFinish(Sender: TObject);
begin
  aniCarregando.Enabled := False;
end;

procedure TfmxRecebimentoPedido.aniDiminuirFinish(Sender: TObject);
begin
  aniRodar.Enabled := False;

  arcAguarde.RotationAngle := 0;
  TAnimator.AnimateFloatWait(arcAguarde, 'RotationAngle', 360, 2, TAnimationType.Out, TInterpolationType.Cubic);

  layCheck.Visible       := True;
  cirFundoBranco.Visible := False;

  FinalizaAnimacao;
end;

procedure TfmxRecebimentoPedido.AtualizaItensPedido;
Var
  LProduto: IAutoatendimentoPagueFacilPedidoItens;
  LItem   : TListBoxItem;
  LFrame  : TframeItensPedido;
  LCount  : Integer;
begin
  LCount := 0;
  lstProdutos.Items.Clear;

  lstProdutos.BeginUpdate;
  For LProduto In FPagueFacil.Pedido.Produtos Do
  Begin
    Inc(LCount);

    LItem         := TListBoxItem.Create(Self);
    LFrame        := TframeItensPedido.Create(Self);
    LFrame.Name   := 'FrameItem' + LCount.ToString;

    LFrame.Parent := LItem;
    LFrame.Align  := TAlignLayout.Contents;
    LFrame.Height := 80;
    LItem.Height  := 80;

    LFrame.lblCODITE.Text := LProduto.Codigo;
    LFrame.lblDESITE.Text := LProduto.Descricao;
    LFrame.lblUNIDAD.Text := LProduto.Unidade;
    LFrame.lblVALUNI.Text := FormatFloat('0', LProduto.Quantidade) + ' x R$ ' +
                             FormatFloat('#,##0.00', LProduto.ValorUnitario);
    LFrame.lblVALTOT.Text := 'R$ ' + FormatFloat('#,##0.00', LProduto.ValorTotal);

    LItem.Parent := lstProdutos;
  End;
  lstProdutos.EndUpdate;
end;

procedure TfmxRecebimentoPedido.AtualizaParcelamento(ANumParcelas: Integer);
begin
  lblValorParcela.Text := ANumParcelas.ToString + ' x R$ ' +
                          FormatFloat('#,##0.00', FPagueFacil.Pedido.ValorContabil / ANumParcelas);
end;

procedure TfmxRecebimentoPedido.AtualizarInformacoes(AMostrarCPF : Boolean = True);
begin
  {********************}
  {* Dados do Pedido  *}
  {********************}
  lblNumeroPedido.Text      := 'Pedido Nº ' + FPagueFacil.Pedido.Numero;

  {********************}
  {* Dados do Cliente *}
  {********************}
  lblNomeCliente.Text       := FPagueFacil.Pedido.Cliente.Nome;

  If Not AMostrarCPF Then
    lblCPFCliente.Text      := '000.000.000-00'
  Else
    lblCPFCliente.Text      := FPagueFacil.Pedido.Cliente.Documento;

  lblTelefoneCliente.Text   := FPagueFacil.Pedido.Cliente.Telefone;
  lblEnderecoCliente.Text   := FPagueFacil.Pedido.Cliente.Endereco.Logradouro;
  lblBairroCliente.Text     := FPagueFacil.Pedido.Cliente.Endereco.Bairro;
  lblCidadeCliente.Text     := FPagueFacil.Pedido.Cliente.Endereco.Cidade + ' - ' +
                               FPagueFacil.Pedido.Cliente.Endereco.Estado;
  lblCEPCliente.Text        := FPagueFacil.Pedido.Cliente.Endereco.Cep;

  {********************}
  {* Dados do Entrega *}
  {********************}
  lblEnderecoEntrega.Text   := FPagueFacil.Pedido.Entrega.Endereco.Logradouro;
  lblBairroEntrega.Text     := FPagueFacil.Pedido.Entrega.Endereco.Bairro;
  lblCidadeEntrega.Text     := FPagueFacil.Pedido.Entrega.Endereco.Cidade + ' - ' +
                               FPagueFacil.Pedido.Entrega.Endereco.Estado;
  lblCEPEntrega.Text        := FPagueFacil.Pedido.Entrega.Endereco.Cep;

  {***************}
  {* Totalização *}
  {***************}
  lblSubTotalVal.Text       := 'R$ ' + FormatFloat('#,##0.00', FPagueFacil.Pedido.TotalProdutos);
  lblDescEspecialVal.Text   := 'R$ ' + FormatFloat('#,##0.00', FPagueFacil.Pedido.DescontoEspecial);
  lblDescAcessoriasVal.Text := 'R$ ' + FormatFloat('#,##0.00', FPagueFacil.Pedido.DespesasAcessorias);
  lblValorFreteVal.Text     := 'R$ ' + FormatFloat('#,##0.00', FPagueFacil.Pedido.ValorFrete);
  lblValorIPIVal.Text       := 'R$ ' + FormatFloat('#,##0.00', FPagueFacil.Pedido.TotalIPI);
  lblValorSTVal.Text        := 'R$ ' + FormatFloat('#,##0.00', FPagueFacil.Pedido.TotalST);
  lblValorFCPVal.Text       := 'R$ ' + FormatFloat('#,##0.00', FPagueFacil.Pedido.TotalFCP_ST);
  lblTotalPagarVal.Text     := 'R$ ' + FormatFloat('#,##0.00', FPagueFacil.Pedido.ValorContabil);
  AjustaLayoutTotalizacoes;

  {************}
  {* Produtos *}
  {************}
  AtualizaItensPedido;

  AtualizaParcelamento(StrToIntDef(LeftStr(RetornaSoNumeros(FPagueFacil.Pedido.Pagamento.Parcelas), 2), 1));

  MudarTab(tabInformacoesPedido);
  lblErroPedido.Text := EmptyStr;
end;

procedure TfmxRecebimentoPedido.AtualizarPagamento;
const
  intParcelaMinima = 1;
var
  intParcelas: Integer;
  blnTravaParcelaNegociadaPedido : Boolean;
begin
  blnTravaParcelaNegociadaPedido := (FPagueFacil.SolicitaDadosCartao) or (FPagueFacil.TravaFormaNegociadaPelaConPag);

  if blnTravaParcelaNegociadaPedido then
    intParcelas := StrToIntDef(LeftStr(RetornaSoNumeros(FPagueFacil.Pedido.Pagamento.Parcelas), 2), 1)
  else
    intParcelas := FPagueFacil.NumeroMaximoParcelas;

  If TravaOpcaoPix Then
  Begin
    SetaFormaPagamento(opcPix);
    DesabilitaParcelamento;

    Exit;
  End;

  if (intParcelas > 1) then
    SetaFormaPagamento(opcCredito);

  if (not FPagueFacil.TravaFormaNegociada) then
    HabilitaParcelamento
  else
    DesabilitaParcelamento;

  if blnTravaParcelaNegociadaPedido then
  begin
    MoverListaParcelas(FPagueFacil.Pedido.Pagamento.QtdeParcelasCartao);
    MarcarParcelaEscolhida(FPagueFacil.Pedido.Pagamento.QtdeParcelasCartao);

    if (FPagueFacil.Pedido.Pagamento.TipoCartao = 'D') then
      SetaFormaPagamento(opcDebito)

    else if (FPagueFacil.Pedido.Pagamento.TipoCartao = 'P') then
      SetaFormaPagamento(opcPix)

    else if (FPagueFacil.Pedido.Pagamento.QtdeParcelasCartao = 1) then
      SetaFormaPagamento(opcCredito)

    else
    begin
      SetaFormaPagamento(opcCredito);
      DesabilitaParcelamento;
    end;
  end
  else
  begin
    MoverListaParcelas(intParcelaMinima);
    MarcarParcelaEscolhida(intParcelaMinima);

    SetaFormaPagamento(opcCredito);
    layOpcoesParcelas.Enabled := True;
  end;

  InformarParcelas;
end;

procedure TfmxRecebimentoPedido.btnAbrirTecladoClick(Sender: TObject);
begin
  recTeclado.Opacity       := 0;
  recTeclado.Visible       := True;
  btnFecharTeclado.Opacity := 0;
  btnFecharTeclado.Visible := True;

  TAnimator.AnimateFloat(recTeclado,       'Opacity', 1,   0.5, TAnimationType.InOut, TInterpolationType.Linear);
  TAnimator.AnimateFloat(btnFecharTeclado, 'Opacity', 0.5, 0.5, TAnimationType.InOut, TInterpolationType.Linear);
  TAnimator.AnimateFloatWait(btnAbrirTeclado,  'Opacity', 0,   0.5, TAnimationType.InOut, TInterpolationType.Linear);

  btnAbrirTeclado.Visible := False;
end;

procedure TfmxRecebimentoPedido.btnFecharTecladoClick(Sender: TObject);
begin
  btnAbrirTeclado.Visible := True;

  TAnimator.AnimateFloat(recTeclado,           'Opacity', 0, 0.5, TAnimationType.InOut, TInterpolationType.Linear);
  TAnimator.AnimateFloat(btnFecharTeclado,     'Opacity', 0, 0.5, TAnimationType.InOut, TInterpolationType.Linear);
  TAnimator.AnimateFloatWait(btnAbrirTeclado,  'Opacity', 0.5, 0.5, TAnimationType.InOut, TInterpolationType.Linear);

  recTeclado.Visible       := False;
  btnFecharTeclado.Visible := False;
end;

procedure TfmxRecebimentoPedido.btnLogErrosClick(Sender: TObject);
begin
  memErros.Visible := Not memErros.Visible;
end;

procedure TfmxRecebimentoPedido.CarregaAd(AArquivo: String);
begin
  If ContainsStr(ExtensaoImagens, RightStr(AArquivo,3)) Then
  Begin
    recVideo.Visible := False;
    recImage.Visible := True;

    recImage.Bitmap.LoadFromFile(AArquivo);
  End
  Else if ContainsStr(ExtensaoVideos, RightStr(AArquivo,3)) Then
  Begin
    recVideo.Visible := True;
    recImage.Visible := False;

    player.OpenMovie(AArquivo);
    timerAds.Enabled := False;
  End;
end;

procedure TfmxRecebimentoPedido.DesabilitaParcelamento;
begin
  laySetaEsquerda.Opacity := 0.05;
  laySetaDireita.Opacity  := 0.05;
end;

procedure TfmxRecebimentoPedido.DesabilitarBotoes(LeftDestino: Single);
begin
  If (LeftDestino = 0) Then
    TAnimator.AnimateFloat(laySetaEsquerda, 'Opacity', 0.05, 0.3, TAnimationType.Out, TInterpolationType.Cubic)
  Else
    TAnimator.AnimateFloat(laySetaEsquerda, 'Opacity', 1, 0.3, TAnimationType.&In, TInterpolationType.Cubic);

  If (LeftDestino = PosicaoDaLista) Then
    TAnimator.AnimateFloat(laySetaDireita, 'Opacity', 0.05, 0.3, TAnimationType.Out, TInterpolationType.Cubic)
  Else
    TAnimator.AnimateFloat(laySetaDireita, 'Opacity', 1, 0.3, TAnimationType.&In, TInterpolationType.Cubic);
end;

function TfmxRecebimentoPedido.DiaAtualCompleto: String;
begin
  Result := DiaDaSemana(Today) + ', ' +
            DayOf(Today).ToString + ' de ' +
            MesDoAno(Today) + ' de ' +
            YearOf(Today).ToString;
end;

Function TfmxRecebimentoPedido.DiaDaSemana(Data: TDateTime): String;
begin
  Case DayOfTheWeek(Data) Of
   0: Result := 'Domingo';
   1: Result := 'Segunda-feira';
   2: Result := 'Terça-feira';
   3: Result := 'Quarta-feira';
   4: Result := 'Quinta-feira';
   5: Result := 'Sexta-feira';
   6: Result := 'Sábado';
  End;
end;

procedure TfmxRecebimentoPedido.edtCodigoBarrasChange(Sender: TObject);
begin
  If (edtCodigoBarras.Tag = 1) Then
  Begin
    Try
      Try
        If Not (edtCodigoBarras.Text.IsEmpty) Then
        Begin
          MostrarAguarde(True);

          edtCodigoBarras.Tag  := 0;
          edtCodigoBarras.Text := fStrZero(edtCodigoBarras.Text, edtCodigoBarras.MaxLength) + #35;
          edtCodigoBarras.Tag  := 1;

          MoveCursor(vkEnd);

          FPagueFacil.CarregarPedido(edtCodigoBarras.Text);

          AtualizarInformacoes;
          AtualizarPagamento;

          If FPagueFacil.Pedido.Cliente.EhConsumidor Then
            PedeCPFSeConsumidor
          Else
            PerguntaIdentificacaoCliente;
        End;
      Except
        On E: EAbort Do
        Begin
          Application.ProcessMessages;
          Sleep(3000);
        End;

        On E: Exception Do
        Begin
          OnMensagemDeErro(E.Message);
          Exit;
        End;
      End;
    Finally
      MostrarAguarde(False);
    End;
  End;
end;

procedure TfmxRecebimentoPedido.edtCodigoBarrasChangeTracking(Sender: TObject);
begin
  MoveCursor(vkRight);

  If Not (lblErroCodigoBarras.Text.IsEmpty) Then
    LimparErroCodigoBarras;
end;

procedure TfmxRecebimentoPedido.edtCodigoBarrasClick(Sender: TObject);
begin
  MoveCursor(vkNone);
end;

procedure TfmxRecebimentoPedido.edtCodigoBarrasEnter(Sender: TObject);
begin
  PiscaCursor;

  If FPagueFacil.UsaComanda Then
    edtCodigoBarras.MaxLength := 13
  Else
    edtCodigoBarras.MaxLength := 12;
end;

procedure TfmxRecebimentoPedido.edtCodigoBarrasExit(Sender: TObject);
begin
  EscondeCursor;
end;

procedure TfmxRecebimentoPedido.edtCodigoBarrasKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  Case Key Of
    vkLeft, vkHome, vkRight, vkEnd : MoveCursor(Key);
  End;
end;

function TfmxRecebimentoPedido.EhLayoutDeTotalizacaoEEstaVisivel(
  Sender: TObject): Boolean;
begin
  Result := False;

  If (Sender.ClassNameIs('TLayout')) Then
    If (TLayout(Sender).Parent.Name = 'flwTotalizacao') Then
      If (TLayout(Sender).Visible) Then
        Result := True;
end;

procedure TfmxRecebimentoPedido.EscondeCursor;
begin
  linCursor.Tag := 0;
end;

procedure TfmxRecebimentoPedido.EsconderParcelas;
begin
  layOpcoesParcelas.Visible := False;
  lblParcelas.Visible       := False;
  lblValorParcela.Visible   := False;
end;

function TfmxRecebimentoPedido.fArqIni(ReadWrite: Integer; NomChave, NomSecao,
  Conteudo, strNomArq: String): String;
Var
  iniArqIni : TIniFile;
begin
  If (strNomArq.IsEmpty) Then
    strNomArq := 'opcoes.ini';

  iniArqIni := TIniFile.Create(System.SysUtils.GetCurrentDir + strNomArq);
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;
end;

procedure TfmxRecebimentoPedido.FinalizaAnimacao;
Var
  Tempo: Single;
begin
  Tempo := 0.75;

  TAnimator.AnimateFloat(recFundoAzul, 'Width', 59, Tempo, TAnimationType.&In, TInterpolationType.Exponential);
  TAnimator.AnimateFloat(cirPonto, 'Position.X', 100, Tempo, TAnimationType.&In, TInterpolationType.Exponential);
  TAnimator.AnimateFloatWait(cirPonto, 'Position.Y', 183, Tempo, TAnimationType.&In, TInterpolationType.Exponential);

  TAnimator.AnimateFloat(arcAguarde, 'Opacity', 0, Tempo*2, TAnimationType.Out, TInterpolationType.Exponential);
  TAnimator.AnimateFloat(recFundoAzul, 'Width', 197, Tempo*2, TAnimationType.Out, TInterpolationType.Exponential);
  TAnimator.AnimateFloat(cirPonto, 'Position.X', 229 , Tempo*2, TAnimationType.Out, TInterpolationType.Exponential);
  TAnimator.AnimateFloat(lblPagamentoEfetuado, 'Opacity', 1, Tempo*2, TAnimationType.InOut, TInterpolationType.Linear);
  TAnimator.AnimateFloatWait(cirPonto, 'Position.Y', 50, Tempo*2, TAnimationType.Out, TInterpolationType.Exponential);

  Sleep(2000);

  recFundoAzul.Visible   := False;
  recFundoBranco.Visible := False;
  cirPonto.Visible       := False;

  //TAnimator.AnimateFloatWait(layConfirmacaoPagamento, 'Opacity', 0, 1, TAnimationType.InOut, TInterpolationType.Linear);
  layConfirmacaoPagamento.Opacity := 0;
  layConfirmacaoPagamento.Visible := False;

  aniDiminuir.Enabled := False;

  NovoPedido;
end;

procedure TfmxRecebimentoPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FArquivosAds.Free;
end;

procedure TfmxRecebimentoPedido.FormCreate(Sender: TObject);
begin
  {* Flag utilizada para testes apenas *}
  If Not (fArqIni(0, 'GERAL', 'TESTE_TOTEM_SEM_TEF', '') = 'S') Then
    Self.FormStyle := TFormStyle.Normal;

  FExceptionLogErr := Nil ;
  FCallLogTot := Nil ;
  tabTelas.ActiveTab          := tabCodigoBarras;
  recDadosItensPedido.Visible := False;

  Self.BorderStyle := TFmxFormBorderStyle.None;
  Self.WindowState := TWindowState.wsMaximized;

  recCarregando.Width       := 0;
  imgMaquinaFechada.Opacity := 0;
  lblMensagensTEF.Text      := EmptyStr;
  recTeclado.Visible        := False;
  btnFecharTeclado.Opacity  := 0;
  btnAbrirTeclado.Opacity   := 0.5;
  edtCodigoBarras.Tag       := 1;
  LPedNotPau                := '';
  FProcessando := False;
  MostrarAguarde(False);
  memErros.Lines.Clear;
end;

procedure TfmxRecebimentoPedido.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkEscape then
    if (tabTelas.TabIndex = tabCodigoBarras.Index) then
      Close;
end;

procedure TfmxRecebimentoPedido.FormShow(Sender: TObject);
begin
  TimerCursor.Enabled := True;

  If Not Assigned(FArquivosAds) Then
    FArquivosAds := TStringList.Create;

  ListarAds(FArquivosAds);

  If FArquivosAds.Count > 0 Then
    CarregaAd(FArquivosAds[0]);

  recPubli.Tag          := 0;
  recCarregando.Width   := 0;
  aniCarregando.Enabled := True;

  PlayAds;
end;

function TfmxRecebimentoPedido.fStrZero(Zeros: string; Quant: integer): String;
Var
	I,Tamanho:integer;
	Aux: string;
begin
  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  For I := 1 To Tamanho Do
	If Aux[i] <> ',' Then
	  Zeros := Zeros + Aux[i];

  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  for I:=1 to Quant-Tamanho do
  Zeros:=Zeros + '0';
  Aux := Zeros + Aux;
  fStrZero := Aux;
end;

procedure TfmxRecebimentoPedido.HabilitaParcelamento;
begin
  lstParcelas.Enabled := True;
  lblCredito.Enabled := True;
  lblDebito.Enabled := True;
  laySetaEsquerda.Opacity := 0.05;
  laySetaDireita.Opacity  := 1;
end;

procedure TfmxRecebimentoPedido.HabilitarParcelas;
Var
  i    : Integer;
  LItem: TListBoxItem;
begin
  For i := 1 To 12 Do
  Begin
    LItem := TListBoxItem(FindComponent('lstIteParcela' + IntToStr(i)));

    If (i <= FPagueFacil.NumeroMaximoParcelas) Then
      LITem.Visible := True
    Else
      LITem.Visible := False;
  End;
end;

procedure TfmxRecebimentoPedido.InformarParcelas;
  var
    intQtdParcelaCompara : Integer;
begin
  HabilitarParcelas;

  if recSelecionaParcela.Tag <= 3 then
    intQtdParcelaCompara := 3
  else if recSelecionaParcela.Tag <= 6 then
    intQtdParcelaCompara := 6
  else if recSelecionaParcela.Tag <= 9 then
    intQtdParcelaCompara := 9
  else
    intQtdParcelaCompara := 12;
  
  If FPagueFacil.NumeroMaximoParcelas > intQtdParcelaCompara Then
  Begin
    patEsquerda.Visible     := True;
    laySetaEsquerda.Enabled := True;

    patDireita.Visible      := True;
    laySetaDireita.Enabled  := True;
  End
  Else
  Begin
    if recSelecionaParcela.Tag <= 3 then
    begin
      patEsquerda.Visible     := False;
      laySetaEsquerda.Enabled := False;
    end;

    patDireita.Visible      := False;
    laySetaDireita.Enabled  := False;
  End;
  
end;

function TfmxRecebimentoPedido.InputBoxFmx(ADescricao: String): String;
begin
  Try
    fmxInputBox := TfmxInputBox.Create(Self);
    fmxInputBox.lblDescricao.Text := ADescricao;
    fmxInputBox.FPagueFacil       := FPagueFacil;
    fmxInputBox.ShowModal;
  Finally
    Result := fmxInputBox.edtInputText.Text;
    fmxInputBox.Free;
  End;
end;

procedure TfmxRecebimentoPedido.pAtualizaParcelamentoComTrava;
begin
  recSelecionaParcela.Visible := True;
  AtualizaParcelamento(recSelecionaParcela.Tag);
end;

procedure TfmxRecebimentoPedido.laySetaDireitaClick(Sender: TObject);
Var
  LLeft : Single;
  intQtdParcelasCartao : Integer;
begin
  TravarTela(True);

  intQtdParcelasCartao := 1;
  if FPagueFacil.Pedido.Pagamento.QtdeParcelasCartao > 0 then
    intQtdParcelasCartao := FPagueFacil.Pedido.Pagamento.QtdeParcelasCartao;

  LLeft := lstParcelas.Position.X;
  If (lstParcelas.Enabled) Then
  Begin
    If (lstParcelas.Position.X > PosicaoDaLista) Then
    Begin
      If (patDireita.Visible) Then
      Begin
        LLeft := lstParcelas.Position.X - recFundoParcelas.Width;
        TAnimator.AnimateFloat(lstParcelas, 'Position.X', LLeft, 0.3, TAnimationType.Out, TInterpolationType.Cubic);
        recSelecionaParcela.Tag := recSelecionaParcela.Tag + 3;

        if not FPagueFacil.TravaFormaNegociada then
        begin
          if recSelecionaParcela.Tag > FPagueFacil.NumeroMaximoParcelas then
            recSelecionaParcela.Tag := FPagueFacil.NumeroMaximoParcelas;

          AtualizaParcelamento(recSelecionaParcela.Tag)
        end
        else
        begin
          //if recSelecionaParcela.Tag <= FPagueFacil.Pedido.Pagamento.QtdeParcelasCartao then
          if recSelecionaParcela.Tag <= intQtdParcelasCartao then
            pAtualizaParcelamentoComTrava
          else
            recSelecionaParcela.Visible := False;
        end;
      End;
    End;
    DesabilitarBotoes(LLeft);
  End;

  InformarParcelas;
  
  TravarTela(False);
end;

procedure TfmxRecebimentoPedido.laySetaEsquerdaClick(Sender: TObject);
Var
  LLeft : Single;
  intQtdParcelasCartao : Integer;
begin
  TravarTela(True);

  intQtdParcelasCartao := 1;
  if FPagueFacil.Pedido.Pagamento.QtdeParcelasCartao > 0 then
    intQtdParcelasCartao := FPagueFacil.Pedido.Pagamento.QtdeParcelasCartao;

  LLeft := lstParcelas.Position.X;
  If (lstParcelas.Enabled) Then
  Begin
    If (lstParcelas.Position.X < 0) Then
    Begin
      If (patEsquerda.Visible) Then
      Begin
        LLeft := lstParcelas.Position.X + recFundoParcelas.Width;
        TAnimator.AnimateFloat(lstParcelas, 'Position.X', LLeft, 0.3, TAnimationType.Out, TInterpolationType.Cubic);
        recSelecionaParcela.Tag := recSelecionaParcela.Tag - 3;

        if not FPagueFacil.TravaFormaNegociada then
          AtualizaParcelamento(recSelecionaParcela.Tag)
        else
        begin
          //if (recSelecionaParcela.Tag <= FPagueFacil.Pedido.Pagamento.QtdeParcelasCartao) then
          if (recSelecionaParcela.Tag <= intQtdParcelasCartao) then
            pAtualizaParcelamentoComTrava;
        end;
      End;
    End;
    DesabilitarBotoes(LLeft);
  End;

  InformarParcelas;

  TravarTela(False);
end;

procedure TfmxRecebimentoPedido.lblCancelarClick(Sender: TObject);
begin
  If Not LPedNotPau.IsEmpty Then
    FPagueFacil.Pedido.AlterarNotaFiscalPaulista(LPedNotPau);

  NovoPedido;
end;

procedure TfmxRecebimentoPedido.lblCancelarDblClick(Sender: TObject);
begin
  // Ignora o double click
end;

function TfmxRecebimentoPedido.fTravaOpcaoCredito : Boolean;
begin
  Result := True;

  if (not FPagueFacil.TravaFormaNegociada) then
    Exit(False);

  if (FPagueFacil.Pedido.Pagamento.TipoCartao <> 'D') then
    Exit(False);

  if (not FPagueFacil.SolicitaDadosCartao) and (not FPagueFacil.TravaFormaNegociadaPelaConPag) then
    Exit(False);
end;

procedure TfmxRecebimentoPedido.lblCreditoClick(Sender: TObject);
begin
  if fTravaOpcaoCredito then
    Exit;

  If TravaOpcaoPix Then
    Exit;

  If MatchStr(recSelecionaFormaPagamento.TagString, ['D', 'P']) Then
    SetaFormaPagamento(opcCredito);
end;

procedure TfmxRecebimentoPedido.lblCreditoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
begin
  If MatchStr(recSelecionaFormaPagamento.TagString, ['D', 'P']) Then
    TLabel(Sender).Cursor := crHandPoint
  Else
    TLabel(Sender).Cursor := crDefault;
end;

procedure TfmxRecebimentoPedido.lblDebitoClick(Sender: TObject);
begin
  If TravaOpcaoPix Then
    Exit;

  If MatchStr(recSelecionaFormaPagamento.TagString, ['C', 'P']) Then
    SetaFormaPagamento(opcDebito);
end;

procedure TfmxRecebimentoPedido.lblDebitoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
begin
  If MatchStr(recSelecionaFormaPagamento.TagString, ['C', 'P']) Then
    TLabel(Sender).Cursor := crHandPoint
  Else
    TLabel(Sender).Cursor := crDefault;
end;

procedure TfmxRecebimentoPedido.lblPagarClick(Sender: TObject);
begin
  if FProcessando then
    Exit;

  FProcessando := True;

  AcertaTelaTipoPagamento;
  MudarTab(tabPagamentoCartao);

  Try
    MostrarAguarde(True);
    FPagueFacil.SetTipoCartao(recSelecionaFormaPagamento.TagString);
    FPagueFacil.SetParcelas(recSelecionaParcela.Tag);
    FPagueFacil.RealizarAdiantamento;
    MostrarAguarde(False);
  Except
    On E: EAbort Do
    Begin
      Application.ProcessMessages;
      FProcessando := False;
      MostrarAguarde(False);
      Sleep(1000);
      MudarTab(tabInformacoesPedido);
      Exit;
    End;

    On E: Exception Do
    Begin
      FExceptionLogErr := E ;
      try
        OnMensagemDeErro(E.Message);
      finally
        FExceptionLogErr := Nil ;
      end ;
      Application.ProcessMessages;
      FProcessando := False;
      MostrarAguarde(False);
      Sleep(1000);
      MudarTab(tabInformacoesPedido);
      Exit;
    End;
  End;

  Try
    MostrarAguarde(True);

    Try
      If FPagueFacil.ModoEmitirNFCe Then
      Begin
        MensagensDoTEF('Emitindo NFCe...');
        FPagueFacil.EmitirNFCe;

        If Not FPagueFacil.NFCeAutorizada Then
        Begin
          If Assigned(FCallLogTot) Then
            FCallLogTot('Documento fiscal não autorizado após o recebimento.', FPagueFacil, Nil) ;

          MensagemOk('Ops!','Documento fiscal não autorizado!' + #13 +
                            'Procure o vendedor responsável por sua compra.');
        End;
      End;
    Except
      On E: EAbort Do
      Begin
        If Assigned(FCallLogTot) Then
          FCallLogTot('Emissão da NFCe interrompida: ' + E.Message, FPagueFacil, Nil) ;

        Application.ProcessMessages;
        Sleep(5000);
      End;

      On E: Exception Do
      Begin
        FExceptionLogErr := E ;
        try
          OnMensagemDeErro(E.Message);
        finally
          FExceptionLogErr := Nil ;
        end ;
        Application.ProcessMessages;
        Sleep(5000);
      End;
    End;

  Finally
    FProcessando := False;
    MostrarAguarde(False);
    MudarTab(tabConfirmacaoPagamento);
  End;

end;

procedure TfmxRecebimentoPedido.lblPagarDblClick(Sender: TObject);
begin
  // Ignora o double click
end;

procedure TfmxRecebimentoPedido.lblPagarMouseEnter(Sender: TObject);
begin
  TAnimator.AnimateFloat(TLabel(Sender), 'Opacity', 1, 0.3, TAnimationType.InOut, TInterpolationType.Cubic);
  TLabel(Sender).Cursor := crHandPoint;
end;

procedure TfmxRecebimentoPedido.lblPagarMouseLeave(Sender: TObject);
begin
  TAnimator.AnimateFloat(TLabel(Sender), 'Opacity', 0.6, 0.3, TAnimationType.InOut, TInterpolationType.Cubic);
  TLabel(Sender).Cursor  := crDefault;
end;

procedure TfmxRecebimentoPedido.lblPixClick(Sender: TObject);
begin
  if fTravaOpcaoCredito then
    Exit;

  If MatchStr(recSelecionaFormaPagamento.TagString, ['D', 'C']) Then
    SetaFormaPagamento(opcPix);
end;

procedure TfmxRecebimentoPedido.lblPixMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
begin
  If MatchStr(recSelecionaFormaPagamento.TagString, ['C', 'D']) Then
    TLabel(Sender).Cursor := crHandPoint
  Else
    TLabel(Sender).Cursor := crDefault;
end;

procedure TfmxRecebimentoPedido.LimparErroCodigoBarras;
begin
  recCodigoBarras.Stroke.Color   := TAlphaColorRec.White;
  edtCodigoBarras.Margins.Bottom := 10;
  linCursor.Position.Y           := 9;
  lblErroCodigoBarras.Text       := EmptyStr;
  edtCodigoBarras.Text           := EmptyStr;
  timerErro.Enabled              := False;
  edtCodigoBarras.SetFocus;
end;

procedure TfmxRecebimentoPedido.ListarAds(Var Lista: TStringList);
Var
  LFile, LPath: String;
begin
  Lista.Clear;
  LPath := System.SysUtils.GetCurrentDir + '\PagueFacil\Ads\';

  If DirectoryExists(LPath) Then
    For LFile In TDirectory.GetFiles(LPath) Do
      Lista.Add(LFile);
end;

procedure TfmxRecebimentoPedido.pSelecionaParcelaComTrava(intTag : Integer);
begin
  if (intTag <= FPagueFacil.Pedido.Pagamento.QtdeParcelasCartao) then
  begin
    recSelecionaParcela.Tag := intTag;
    recSelecionaParcela.Visible := True;
    MarcarParcelaEscolhida(intTag);
  end;
end;

procedure TfmxRecebimentoPedido.lstIteParcela1Click(Sender: TObject);
begin
  if (not FPagueFacil.TravaFormaNegociada) then
  begin
    recSelecionaParcela.Tag := TListBoxItem(Sender).Tag;
    MarcarParcelaEscolhida(TListBoxItem(Sender).Tag);
  end
  else
  begin
    pSelecionaParcelaComTrava(TListBoxItem(Sender).Tag);
  end;
end;

procedure TfmxRecebimentoPedido.MarcarParcelaEscolhida(ANumParcela: Integer);
begin
  if ANumParcela = 0 then
    ANumParcela := 1;

  recSelecionaParcela.Tag :=  ANumParcela;
  Case ANumParcela Of
    1,4,7,10:
    begin
      TAnimator.AnimateFloat(recSelecionaParcela, 'Position.X', 0, 0.3, TAnimationType.Out, TInterpolationType.Cubic);
      recSelecionaParcela.Corners    := [TCorner.TopLeft, TCorner.BottomLeft];
      recSelecionaParcela.Sides      := [TSide.Top, TSide.Bottom, TSide.Left, TSide.Right];
    end;

    2,5,8,11:
    begin
      TAnimator.AnimateFloat(recSelecionaParcela, 'Position.X', 52, 0.3, TAnimationType.Out, TInterpolationType.Cubic);
      recSelecionaParcela.Corners    := [];
      recSelecionaParcela.Sides      := [TSide.Top, TSide.Bottom, TSide.Left, TSide.Right];
    end;

    3,6,9,12:
    begin
      TAnimator.AnimateFloat(recSelecionaParcela, 'Position.X', 104, 0.3, TAnimationType.Out, TInterpolationType.Cubic);
      recSelecionaParcela.Corners    := [TCorner.TopRight, TCorner.BottomRight];
      recSelecionaParcela.Sides      := [TSide.Top, TSide.Bottom, TSide.Left, TSide.Right];
    end;
  End;
  AtualizaParcelamento(ANumParcela);
end;

procedure TfmxRecebimentoPedido.MensagemOk(ATitulo, AMensagem: String);
begin
  Try
    fmxMensagem := TfmxMensagem.Create(Self);
    fmxMensagem.lblDescricao.Text := ATitulo;
    fmxMensagem.lblMensagem.Text  := AMensagem;
    fmxMensagem.ShowModal;
  Finally
    fmxMensagem.Free;
  End;
end;

procedure TfmxRecebimentoPedido.MensagensDoTEF(AMsg: String);
begin
  If (AMsg = 'Informando valor do adiantamento!') Then
    AMsg := '';

  If (AMsg = 'Aguarde, Gravando Adiantamento...') Then
    lblMaquina.Text := 'Concluindo pagamento...';

  If (AMsg = 'Aguarde, Imprimindo Recibo...') Then
    lblMaquina.Text := 'Obrigado!';

  If AMsg.Contains('NFCe') Then
    lblMaquina.Text := AMsg;

  lblMensagensTEF.Text := AMsg;

  If (AMsg = 'Não foi possível realizar o recebimento do pedido!') Then
  Begin
    Sleep(5000);
    FPagueFacil.Pedido.AlterarNotaFiscalPaulista('S');
    NovoPedido;
  End;

end;

function TfmxRecebimentoPedido.MesDoAno(Data: TDateTime): String;
begin
  Case MonthOf(Data) Of
   1 : Result := 'Janeiro';
   2 : Result := 'Fevereiro';
   3 : Result := 'Março';
   4 : Result := 'Abril';
   5 : Result := 'Maio';
   6 : Result := 'Junho';
   7 : Result := 'Julho';
   8 : Result := 'Agosto';
   9 : Result := 'Setembro';
   10: Result := 'Outubro';
   11: Result := 'Novembro';
   12: Result := 'Dezembro';
  End;
end;

procedure TfmxRecebimentoPedido.MostraMensagem(AMsg, ATipo:String);
begin
  memErros.Lines.Add(ATipo + ': ' + AMsg);

  Case tabTelas.TabIndex Of
   0: MostrarErroNoCodigoBarras(AMsg);
   2: MensagensDoTEF(AMsg);
  End;
end;

procedure TfmxRecebimentoPedido.MostrarAguarde(Mostrar:Boolean);
begin
  layAguardeMenor.Visible := Mostrar;
  aniRodarMenor.Enabled   := Mostrar;
end;

procedure TfmxRecebimentoPedido.MostrarErroNoCodigoBarras(MsgErro: String);
begin
  recCodigoBarras.Stroke.Color   := CorVermelha;
  edtCodigoBarras.Margins.Bottom := 30;
  linCursor.Position.Y           := -1;
  lblErroCodigoBarras.Text       := MsgErro;
  timerErro.Enabled              := True;
end;

procedure TfmxRecebimentoPedido.MostrarParcelas;
begin
  layOpcoesParcelas.Visible := True;
  lblParcelas.Visible       := True;
  lblValorParcela.Visible   := True;
end;

procedure TfmxRecebimentoPedido.MoveCursor(Key: Word);
Var
  LText: String;
begin
  PiscaCursor;

  edtCodigoBarras.Canvas.Font.Family := edtCodigoBarras.Font.Family;
  edtCodigoBarras.Canvas.Font.Size   := edtCodigoBarras.Font.Size;

  Case Key Of
    vkEnd  : linCursor.Position.X := edtCodigoBarras.Canvas.TextWidth(String(edtCodigoBarras.Text).Replace(' ', '.')) + 2.5;
    vkHome : linCursor.Position.X := 2.5;

    vkLeft, vkRight, vkNone:
    Begin
      If Key = vkLeft Then
        LText := Copy(String(edtCodigoBarras.Text).Replace(' ', '.'), 1, (edtCodigoBarras.CaretPosition - 1))
      Else If Key = vkRight Then
        LText := Copy(String(edtCodigoBarras.Text).Replace(' ', '.'), 1, (edtCodigoBarras.CaretPosition + 1))
      Else
        LText := Copy(String(edtCodigoBarras.Text).Replace(' ', '.'), 1, (edtCodigoBarras.CaretPosition));

      linCursor.Position.X := edtCodigoBarras.Canvas.TextWidth(LText) + 2.5;
    End;
  End;
end;

procedure TfmxRecebimentoPedido.MoverListaParcelas(ANumParcelas: Integer);
begin
  Case ANumParcelas Of
    1,2,3   : lstParcelas.Position.X := 0;
    4,5,6   : lstParcelas.Position.X := (recFundoParcelas.Width * -1);
    7,8,9   : lstParcelas.Position.X := (recFundoParcelas.Width * 2) * -1;
    10,11,12: lstParcelas.Position.X := (recFundoParcelas.Width * 3) * -1;
  End;

  DesabilitarBotoes(lstParcelas.Position.X);
end;

procedure TfmxRecebimentoPedido.MudarTab(ATab: TTabItem);
begin
  tabTelas.ActiveTab := ATab;
end;

procedure TfmxRecebimentoPedido.NovoPedido;
begin
  edtCodigoBarras.Text      := '';
  lblErroCodigoBarras.Text  := '';
  lblErroPedido.Text        := '';
  LPedNotPau                := '';
  imgMaquinaFechada.Opacity := 0;

  lblCredito.Opacity := 1;
  lblDebito.Opacity  := 1;
  lblPix.Opacity     := 1;

  MudarTab(tabCodigoBarras);

  recDadosItensPedido.Visible := False;
  lblMensagensTEF.Text := EmptyStr;
  memErros.Lines.Clear;
  layPrincipal.Repaint;
end;

procedure TfmxRecebimentoPedido.OnMensagemAguarde(AMsg: String);
begin
  MostraMensagem(AMsg, 'Aguarde');
end;

procedure TfmxRecebimentoPedido.OnMensagemAoUsuario(AMsg: String);
begin
  MostraMensagem(AMsg, 'Ao usuário');
end;

procedure TfmxRecebimentoPedido.OnMensagemDeErro(AMsg: String);
begin
  MostraMensagem(AMsg, 'Erro');
  if Assigned(FCallLogTot) then
    FCallLogTot(AMsg, FPagueFacil, FExceptionLogErr) ;
end;

procedure TfmxRecebimentoPedido.AcertaTelaTipoPagamento;
begin
  If recSelecionaFormaPagamento.TagString.Equals('P') Then
  Begin
    imgMaquinaFechada.Visible := False;
    imgMaquinaAberta.Visible  := False;
    lblMaquina.Visible        := False;

    imgPix.Position.Y := imgMaquinaFechada.Position.Y;
    imgPix.Visible    := True;
  End
  Else
  Begin
    imgMaquinaFechada.Visible := True;
    imgMaquinaAberta.Visible  := True;
    lblMaquina.Visible        := True;
    imgPix.Visible            := False;

    lblMaquina.Text := 'Siga as instruções no PinPad...';
    TAnimator.AnimateFloatWait(imgMaquinaFechada, 'Opacity', 1, 2, TAnimationType.InOut, TInterpolationType.Cubic);

    imgCartaoMao.Opacity      := 0;
    imgCartao.Opacity         := 0;
    imgRecibo.Opacity         := 0;
    imgMaquinaAberta.Opacity  := 0;

    imgCartaoMao.Position.Y  := 996;
    imgRecibo.Position.Y     := 335;
  End;
end;

procedure TfmxRecebimentoPedido.PagamentoConcluido;
begin
  lblPagamentoEfetuado.Opacity := 0;
  arcAguarde.Opacity           := 1;
  recFundoAzul.Width           := 197;
  cirPonto.Position.X          := 44;
  cirPonto.Position.X          := 134;

  layAguarde.Visible     := True;
  cirFundoBranco.Visible := True;
  layCheck.Visible       := False;

  recFundoAzul.Visible   := True;
  recFundoBranco.Visible := True;
  cirPonto.Visible       := True;

  arcAguarde.EndAngle      := -270;
  arcAguarde.StartAngle    := 173;
  arcAguarde.RotationAngle := 0;

  recFundoAzul.Width   := 0;
  cirPonto.Position.X  := 44;
  cirPonto.Position.Y  := 134;

  //TAnimator.AnimateFloat(layConfirmacaoPagamento, 'Opacity', 1, 1, TAnimationType.&In, TInterpolationType.Linear);
  layConfirmacaoPagamento.Opacity := 1;
  layConfirmacaoPagamento.Visible := True;

  aniRodar.Enabled    := True;
  aniDiminuir.Enabled := True;
end;

procedure TfmxRecebimentoPedido.StopAds;
begin
  If player.Playing Then
    player.Pause
  Else
    timerAds.Enabled := False;
end;

procedure TfmxRecebimentoPedido.PedeCPFSeConsumidor;
Var
  LCPFDigitado : String;
begin
  Application.ProcessMessages;

  LCPFDigitado := '';

  If FPagueFacil.Pedido.Cliente.EhConsumidor Then
    If (Pergunta('Atenção','Deseja inserir o CPF na venda?') = mrYes) Then
      LCPFDigitado := InputBoxFmx('Informe o CPF:');

  If Not LCPFDigitado.IsEmpty Then
  Begin
    FPagueFacil.Pedido.AlteraCPFConsumidor(LCPFDigitado);
    lblCPFCliente.Text := FPagueFacil.FormataCPF(LCPFDigitado);
  End;
end;

function TfmxRecebimentoPedido.Pergunta(ATitulo, AMensagem: String) : Integer;
begin
  Try
    fmxPergunta := TfmxPergunta.Create(Self);
    fmxPergunta.lblDescricao.Text := ATitulo;
    fmxPergunta.lblMensagem.Text  := AMensagem;
    fmxPergunta.ShowModal;
  Finally
    Result := fmxPergunta.Tag;
    fmxPergunta.Free;
  End;
end;

procedure TfmxRecebimentoPedido.PerguntaIdentificacaoCliente;
begin
  Application.ProcessMessages;

  If FPagueFacil.Pedido.PerguntaCPFNaVenda Then
  Begin
    If (Pergunta('Atenção','Deseja inserir o CPF na venda?') = mrNo) Then
    Begin
      LPedNotPau := FPagueFacil.Pedido.NotaFiscalPaulista;
      FPagueFacil.Pedido.AlterarNotaFiscalPaulista('N');
      AtualizarInformacoes(False);
    End;
  End;
end;

procedure TfmxRecebimentoPedido.PiscaCursor;
begin
  linCursor.Tag := 1;
end;

procedure TfmxRecebimentoPedido.PlayAds;
begin
  If player.Paused Then
    player.Play
  Else
    timerAds.Enabled := True;
end;

procedure TfmxRecebimentoPedido.playerPlaybackFinished(Sender: TObject);
begin
  timerAds.Enabled := True;
end;

function TfmxRecebimentoPedido.PosicaoDaLista: Single;
begin
  // Default 12x
  Result := -474;

  Case FPagueFacil.NumeroMaximoParcelas Of
    3 : Result := 0;
    6 : Result := -158;
    9 : Result := -316;
  End;
end;

procedure TfmxRecebimentoPedido.rec7Click(Sender: TObject);
begin
  edtCodigoBarras.Tag  := 0;

  If (TRectangle(Sender).Name = 'recBackspace') Then
    edtCodigoBarras.Text := Copy(edtCodigoBarras.Text, 1, edtCodigoBarras.Text.Length - 1)
  Else
    edtCodigoBarras.Text := edtCodigoBarras.Text + TRectangle(Sender).Tag.ToString();

  edtCodigoBarras.CaretPosition := edtCodigoBarras.CaretPosition + 1;
  MoveCursor(vkNone);
  edtCodigoBarras.Tag  := 1;
  edtCodigoBarras.SetFocus;
end;

procedure TfmxRecebimentoPedido.rec7MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
Var
  LLabel: TLabel;
begin
  TRectangle(Sender).Fill.Color := $FF003A5B;
  LLabel := TLabel(FindComponent('lbl' + Copy(TRectangle(Sender).Name, 4, 20)));
  LLabel.FontColor := TAlphaColorRec.White;
end;

procedure TfmxRecebimentoPedido.rec7MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  TRectangle(Sender).Fill.Color := $FF6695BF;
end;

procedure TfmxRecebimentoPedido.recBackspaceMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
Var
  LLabel: TLabel;
begin
  TRectangle(Sender).Fill.Color := $FFE0E0E0;

  LLabel := TLabel(FindComponent('lbl' + Copy(TRectangle(Sender).Name, 4, 20)));
  LLabel.FontColor := TAlphaColorRec.Black;
end;

procedure TfmxRecebimentoPedido.recLimparClick(Sender: TObject);
begin
  edtCodigoBarras.Tag  := 1;
  edtCodigoBarrasChange(edtCodigoBarras);
end;

procedure TfmxRecebimentoPedido.recMensagensTEFDblClick(Sender: TObject);
begin
{  If (lblMaquina.Text = 'Insira seu cartão.') Then
  Begin
    TAnimator.AnimateFloat(imgCartaoMao, 'Opacity', 1, 0.5, TAnimationType.In, TInterpolationType.Cubic);
    TAnimator.AnimateFloatWait(imgCartaoMao, 'Position.Y', 796, 2, TAnimationType.Out, TInterpolationType.Cubic);
    imgCartao.Opacity := 1;
    TAnimator.AnimateFloatWait(imgCartaoMao, 'Opacity', 0, 0.5, TAnimationType.Out, TInterpolationType.Cubic);
    lblMaquina.Text := 'Digite a senha:';
    Exit;
  End;

  If (lblMaquina.Text = 'Digite a senha:') Then
  Begin
    lblMaquina.Text := 'Retire seu cartão.';
    TAnimator.AnimateFloatWait(imgCartaoMao, 'Opacity', 1, 0.5, TAnimationType.In, TInterpolationType.Cubic);
    imgCartao.Opacity := 0;
    TAnimator.AnimateFloatDelay(imgCartaoMao, 'Position.Y', 996, 2, 0.5, TAnimationType.Out, TInterpolationType.Cubic);
    TAnimator.AnimateFloatDelay(imgCartaoMao, 'Opacity', 0, 0.5, 1.5, TAnimationType.Out, TInterpolationType.Cubic);
    TAnimator.AnimateFloatWait(lblMaquina, 'Opacity', 1, 2.5, TAnimationType.Out, TInterpolationType.Cubic);
    lblMaquina.Text := '';
    Exit;
  End;

  If (lblMaquina.Text = '') Then
  Begin
    lblMaquina.Text := 'Imprimindo recibo...';
    TAnimator.AnimateFloatWait(imgRecibo, 'Position.Y', 125, 4, TAnimationType.Out, TInterpolationType.Cubic);
    lblMaquina.Text := 'Obrigado!';
    Exit;
  End;

  If (lblMaquina.Text = 'Obrigado!') Then
      MudarTab(tabConfirmacaoPagamento);   }

{  If (lblMaquina.Text = 'Siga as instruções no PinPad...') Then
      MudarTab(tabConfirmacaoPagamento);}
end;

procedure TfmxRecebimentoPedido.recPrincipalDblClick(Sender: TObject);
begin
  btnLogErros.Visible := Not btnLogErros.Visible;
  memErros.Visible    := False;
end;

function TfmxRecebimentoPedido.RetornaSoNumeros(ATexto: String): String;
  Var
    strTmp: String;
    intIndice: Integer;
begin
  strTmp := '';

  If Not ATexto.IsEmpty Then
  Begin
    For intIndice := 1 To Length(ATexto) Do
      If CharInSet(ATexto[intIndice], ['0'..'9']) Then
        strTmp := strTmp + ATexto[intIndice];
  End;

  Result := strTmp;
end;

procedure TfmxRecebimentoPedido.SetaFormaPagamento(ATipo: TTipoCartao);
  Var
    LCornersDebito: TCorners;

    LSidesDebito: TSides;
begin
  LCornersDebito := [];
  LSidesDebito := [TSide.Top, TSide.Bottom, TSide.Left, TSide.Right];
  recFormaPagamento.Width := 310;
  lblDebito.Align := TAlignLayout.Fit;

  If Not FPagueFacil.Pedido.Pagamento.PermiteReceberPix Then
  Begin
    LCornersDebito := [TCorner.TopRight, TCorner.BottomRight];
    LSidesDebito := [TSide.Top, TSide.Bottom, TSide.Right];

    recFormaPagamento.Width := 205;

    lblPix.Visible := False;
    lblDebito.Align := TAlignLayout.FitRight;
  End;

  If (ATipo = opcDebito) Then
  Begin
    TAnimator.AnimateFloat(recSelecionaFormaPagamento, 'Position.X', 105, 0.3, TAnimationType.InOut, TInterpolationType.Cubic);
    recSelecionaFormaPagamento.Corners   := LCornersDebito;
    recSelecionaFormaPagamento.Sides     := LSidesDebito;
    recSelecionaFormaPagamento.TagString := 'D';
    EsconderParcelas;
  End
  Else If (ATipo = opcCredito) Then
  Begin
    TAnimator.AnimateFloat(recSelecionaFormaPagamento, 'Position.X', 0, 0.3, TAnimationType.InOut, TInterpolationType.Cubic);
    recSelecionaFormaPagamento.Corners   := [TCorner.TopLeft, TCorner.BottomLeft];
    recSelecionaFormaPagamento.Sides     := [TSide.Top, TSide.Bottom, TSide.Left];
    recSelecionaFormaPagamento.TagString := 'C';
    MostrarParcelas;
  End
  Else
  Begin
    TAnimator.AnimateFloat(recSelecionaFormaPagamento, 'Position.X', 210, 0.3, TAnimationType.InOut, TInterpolationType.Cubic);
    recSelecionaFormaPagamento.Corners   := [TCorner.TopRight, TCorner.BottomRight];
    recSelecionaFormaPagamento.Sides     := [TSide.Top, TSide.Bottom, TSide.Right];
    recSelecionaFormaPagamento.TagString := 'P';
    EsconderParcelas;
  End;

  If TravaFormaPagamento Then
  Begin
    lblCredito.Opacity := IfThen(recSelecionaFormaPagamento.TagString = 'C', 1, 0.1);
    lblDebito.Opacity  := IfThen(recSelecionaFormaPagamento.TagString = 'D', 1, 0.1);
    lblPix.Opacity     := IfThen(recSelecionaFormaPagamento.TagString = 'P', 1, 0.1);
  End;
end;

procedure TfmxRecebimentoPedido.tabTelasChange(Sender: TObject);
begin
  recDadosItensPedido.Visible := (tabTelas.ActiveTab <> tabCodigoBarras) And
                                 (tabTelas.ActiveTab <> tabConfirmacaoPagamento);

  StopAds;

  Case tabTelas.TabIndex Of
    0 : PlayAds;
    1 : InformarParcelas;
    2 : AcertaTelaTipoPagamento;
    3 : PagamentoConcluido;
  End;
end;

procedure TfmxRecebimentoPedido.timerAdsTimer(Sender: TObject);
Var
  LFile: String;
begin
  If FArquivosAds.Count = 0 Then
    Exit;

  recPubli.Tag := recPubli.Tag + 1;

  If (recPubli.Tag = FArquivosAds.Count) Then
    recPubli.Tag := 0;

  recCarregando.Width := 0;

  LFile := FArquivosAds[recPubli.Tag];

  CarregaAd(LFile);

  aniCarregando.Enabled := True;
end;

procedure TfmxRecebimentoPedido.TimerCursorTimer(Sender: TObject);
begin
  Case tabTelas.TabIndex Of
    0:
    Begin
      If Not memErros.Visible Then
        If Not edtCodigoBarras.IsFocused Then
          edtCodigoBarras.SetFocus;

      If (linCursor.Tag = 0) Then
        linCursor.Visible := False
      Else If (linCursor.Tag = 1) Then
        linCursor.Visible := Not linCursor.Visible;
    End;
  End;

  lblHora.Text := DiaAtualCompleto + '  -  ' + FormatDateTime('t', Now);
end;

procedure TfmxRecebimentoPedido.timerErroTimer(Sender: TObject);
begin
  LimparErroCodigoBarras;
end;

function TfmxRecebimentoPedido.TravaFormaPagamento: Boolean;
begin
  Result := False;

  if fTravaOpcaoCredito then
    Exit(True);

  if TravaOpcaoPix then
    Exit(True);
end;

function TfmxRecebimentoPedido.TravaOpcaoPix: Boolean;
begin
  Result := True;

  if not FPagueFacil.Pedido.Pagamento.FormaCodigo.Equals('012') then
    Exit(False);

  if FPagueFacil.Pedido.AutoIncremPixVinculadoAoPedido.IsEmpty then
    Exit(FPagueFacil.Pedido.Pagamento.CondicaoRecPix.Equals('S'));
end;

procedure TfmxRecebimentoPedido.TravarTela(Travar: Boolean);
begin
  recTravaTela.Visible := Travar;
end;

end.
