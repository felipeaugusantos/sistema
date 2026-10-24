unit untTefCitelOperacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxButtons, untInterfaceTefCitel, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxCurrencyEdit, CurrencyEditFocus, EditFocus, cxProgressBar, untTypesSistema, untTefCitelInfoMsg,
  Generics.Collections, Data.DB, MemDS, DBAccess, Uni, untTefModalidadeInterface;

type
  TObserversTEFCitel = Array of IObserverTEFCitel;
  TregInfoCarDig = record
    cardse: string ;
    descri: string ;
  end ;

const
  strMsgSelFormaPag = 'Selecione a forma de pagamento';
  strInfo04 = 4;
  strInfo20 = 20;
  strInfo21 = 21;
  strInfo23 = 23;
  strInfo30 = 30;
  strInfo34 = 34;
  strInfo50 = 50;
  strInfo131 = 131;
  strInfo999 = -999;
  strInfo500 = 500;

type
  TfrmTefCitelOperacoes = class(TfrmPai, IObserverTEFCitel)
    pnMensTef: TPanel;
    tmrAtualizaMsg: TTimer;
    ApplicationEvents1: TApplicationEvents;
    tmrHabilita: TTimer;
    pnPrincipal: TPanel;
    pnOperacao: TPanel;
    pnMenu: TPanel;
    btnCredito: TBitBtnLocked;
    btnDebito: TBitBtnLocked;
    btnEncerraMenu: TBitBtnLocked;
    btnPix: TBitBtnLocked;
    pnOpcoesCredito: TPanel;
    btnAVista: TBitBtnLocked;
    btnParcEstab: TBitBtnLocked;
    btnEncerraOpcoesCredito: TBitBtnLocked;
    btnParcAdm: TBitBtnLocked;
    pnDados: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    btnConfirma: TBitBtnLocked;
    btnRetorna: TBitBtnLocked;
    edtQtdPar: TEditFocus;
    edtValor: TCurrencyEditFocus;
    pnQRCode: TPanel;
    imgQRCode: TImage;
    lbTmrPix: TLabel;
    tmrPix: TTimer;
    pnCarDig: TPanel;
    btnCarDig001: TBitBtnLocked;
    btnCarDig002: TBitBtnLocked;
    btnEncerraOpcoesCarDig: TBitBtnLocked;
    mnuCarDigOutras: TPopupMenu;
    btnCarDig003: TBitBtnLocked;
    btnPopMenu: TBitBtnLocked;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCreditoClick(Sender: TObject);
    procedure btnDebitoClick(Sender: TObject);
    procedure btnAVistaClick(Sender: TObject);
    procedure btnParcAdmClick(Sender: TObject);
    procedure btnParcEstabClick(Sender: TObject);
    procedure btnEncerraOpcoesCreditoClick(Sender: TObject);
    procedure btnRetornaClick(Sender: TObject);
    procedure btnEncerraMenuClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrAtualizaMsgTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrHabilitaTimer(Sender: TObject);
    procedure tmrPixTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEncerraOpcoesCarDigClick(Sender: TObject);
    procedure btnPopMenuClick(Sender: TObject);
  private
    { Private declarations }
    FobjInfoCartaoCreditoModalidade: IInfoCartaoCreditoModalidade ;
    FdictCodigoCardse: TDictionary<string,TregInfoCarDig> ;
    FOperacaoAndamento : Boolean;
    blnPermiteSelecionarOpcao : Boolean;
    blnPermiteSelecionarMenu : Boolean;
    blnPermiteSair : Boolean;
    tefCitelRetorno : IRetornoTEFCitel;
    intSegundos, intMinutos : Integer;
    FobjModalidadeDinamica: IModalidadeDinamica ;
    FobjOpcoes: IOpcoesModalidadeDinamica ;
    FlstEdits : TList<TWinControl> ;
    FdictBotoesModalidadeDinamica : TObjectDictionary<TChaveValorModalidade, TBitBtnLocked> ;
    FstrMotivoTransacaoNegada : String ;
    FblnApenasAVista: Boolean;
    FblnApenasPrazo: Boolean;
    FCfgSOLCAR: Boolean;

    function  fValidaParcelas(intQtdParc : Integer): Boolean;
    procedure pPassaCartao(strCodigoCarteiraDigital : string = '');
    procedure pTecla1Click;
    function fTecla1: boolean;
    procedure pTecla2Click;
    function fTecla2: boolean;
    procedure pTecla3Click;
    function fTecla3: boolean;
    procedure pTecla9Click;
    procedure pMontaListaFormsPagto(strMensagem : String);
    procedure pMsgInfo04;
    procedure pMsgInfo20;
    procedure pMsgInfo21;
    procedure pMsgInfo23;
    procedure pMsgInfo30;
    procedure pMsgInfo34;
    procedure pMsgInfo50;
    procedure pMsgInfo131;
    procedure pMsgInfo500;
    procedure pMsgInfoOutros;
    procedure pMsgInfo999;
    procedure pEncerrar;
    procedure pIniciaTimerPix;
    procedure pCarregaCarDig;
    procedure pEventItemCarDigClick(Sender: TObject);
    procedure pEventItemCarDigMaisClick(Sender: TObject);
    function fTecla9PnDados:boolean;
    procedure pAtualizaLayoutCartaoCreditoModalidade ;
    function fDescricaoCompletaCartaoCredito(const AccmModalidade: TCartaoCreditoModalidades): String ;
    function fCodigoModalidadeCartaoCredito(const AccmModalidade: TCartaoCreditoModalidades): String ;
    procedure pOnClickModalidadeDinamica(Sender: TObject) ;
    procedure pOnKeyPressOpcoes(Sender: TObject; var Key: Char) ;
    procedure pOnClickEncerrarOpcoes(Sender: TObject) ;
    procedure pOnClickConfirmarOpcoes(Sender: TObject);
    function fModalidadeDinamica: Boolean ;
    function pTecla9ClickCardig: Boolean ;
    function fTravouQtdParcelaInformada(const AintParc: Integer): Boolean ;
    function fHabilitaParcAdm: boolean ;
    function fHabilitaOpcoesAVista: Boolean;
    function fHabilitaOpcoesPrazo: Boolean;
    procedure pAtualizaEstadoBotoes;
  protected
    procedure AtualizaTefCitel(ARetorno: IRetornoTEFCitel);
  public
    { Public declarations }
    RetornoTEFCitel: IRetornoTEFCitel;
    fltValor : Double;
    strNumDoc : String;
    strRcxCodOpe : String;
    intOperacao: Integer;
    strModalidade: String;
    intQtdParcelas: Integer;
    strStatus : String;
    objDadosAdicionaisTefTra: IDadosAdicionaisTefTra ;
    objValidaParcelas: IDadosValidaParcelas ;
    blnApenasDebito: Boolean;
  end;

implementation

uses
  untFuncoesSimples, untTefCitelUtil,
  frxDelphiZXingQRCode, untQRCodeUtils, untTefModalidadeImpl;

{$R *.dfm}

procedure TfrmTefCitelOperacoes.btnRetornaClick(Sender: TObject);
begin
  inherited;
  pEncerrar;
end;

function TfrmTefCitelOperacoes.fCodigoModalidadeCartaoCredito(
  const AccmModalidade: TCartaoCreditoModalidades): String;
begin
  Result := FobjInfoCartaoCreditoModalidade.ModalidadeCodigo[AccmModalidade] ;
end;

function TfrmTefCitelOperacoes.fDescricaoCompletaCartaoCredito(
  const AccmModalidade: TCartaoCreditoModalidades): String;
begin
  Result := FobjInfoCartaoCreditoModalidade.DescricaoCompleta[AccmModalidade] ;
end;

function TfrmTefCitelOperacoes.fHabilitaOpcoesAVista: Boolean;
begin
  Result := not FblnApenasPrazo;
end;

function TfrmTefCitelOperacoes.fHabilitaOpcoesPrazo: Boolean;
begin
  Result := not FblnApenasAVista;
end;

function TfrmTefCitelOperacoes.fHabilitaParcAdm: boolean;
begin
  Result := True ;
  if fCfgSis('TEFCIT', varString) = OPCAO_NCR then
    Result := fCfgSis('TEFPAD', varString) = 'S' ;
end;

function TfrmTefCitelOperacoes.fTravouQtdParcelaInformada(const AintParc: Integer): Boolean ;
var
  LintQtdNeg: Integer ;
begin
  Result := False ;
  if Assigned(objValidaParcelas) then
  begin
    Result := objValidaParcelas.fTravouQtdParcelaInformada(AintParc) ;
    if Result then
    begin
      LintQtdNeg := objValidaParcelas.QtdNeg ;
      pMensagemOk('A quantidade de parcelas não pode ser maior que a quantidade negociada (' + IntToStr(LintQtdNeg) + ')!');
    end ;
  end ;
end ;

procedure TfrmTefCitelOperacoes.btnAVistaClick(Sender: TObject);
begin
  inherited;
  if not blnPermiteSelecionarOpcao then
    Exit;

  blnPermiteSelecionarOpcao := False;

  pnOperacao.Caption        := fDescricaoCompletaCartaoCredito(ccmAVista) ;

  btnAVista.Enabled         := False;
  btnParcAdm.Enabled        := False;
  btnParcEstab.Enabled      := False;

  blnPermiteSelecionarOpcao := False;

  strModalidade             := fCodigoModalidadeCartaoCredito(ccmAVista) ;

  tmrAtualizaMsg.Enabled    := True;
  { A escolha da modalidade vai para a TEFTRA aqui, no autcom - antes da
    convergencia para o external era a DLL que a guardava e gravava. Ver o
    porque em fPassaCartao (untTefCitelUtil). Os outros tres pontos desta
    tela seguem o mesmo padrao. }
  if Assigned(objDadosAdicionaisTefTra) then
  begin
    objDadosAdicionaisTefTra.Modalidade(strModalidade) ;
    pAtualizaTefTraComDadosAdicionais(objDadosAdicionaisTefTra, Nil) ;
  end ;
  pInfo21(strModalidade);
  tmrAtualizaMsg.Enabled    := False;

  ModalResult := mrOk;
end;

procedure TfrmTefCitelOperacoes.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  intQtdParcelas := StrToIntDef(edtQtdPar.Text,0);
  if not fValidaParcelas(intQtdParcelas) then
    begin
      fMensagem('ATENÇÃO!', 'Número de parcelas inválido. Mínimo 2, máximo 99.', ['&Ok']);
      pSetFocus(edtQtdPar);
      Exit;
    end;

  if fTravouQtdParcelaInformada(intQtdParcelas) then
  begin
    pSetFocus(edtQtdPar);
    Exit;
  end ;

  btnConfirma.Enabled    := False;
  tmrAtualizaMsg.Enabled := True;
  if Assigned(objDadosAdicionaisTefTra) then
  begin
    objDadosAdicionaisTefTra.Modalidade(strModalidade).NumDoc(strNumDoc).QtdParcelas(intQtdParcelas).Valor(fltValor) ;
    pAtualizaTefTraComDadosAdicionais(objDadosAdicionaisTefTra, Nil) ;
  end ;
  pInfo21(strModalidade);
  pInfo30(strNumDoc, Date, intQtdParcelas);
  pinfo34(fltValor);
  tmrAtualizaMsg.Enabled := False;
  ModalResult            := mrOk;
end;

procedure TfrmTefCitelOperacoes.btnCreditoClick(Sender: TObject);
begin
  inherited;
  if not blnPermiteSelecionarMenu then
    Exit;
  
  blnPermiteSelecionarMenu := False;

  btnCredito.Enabled       := False;
  btnDebito.Enabled        := False;
  btnPix.Enabled           := False;
  												     						
  pnOperacao.Caption       := 'SELECIONADO: CRÉDITO';
								  								  
  intOperacao              := 3;
								  
  btnAVista.Enabled        := False;
  btnParcAdm.Enabled       := False;
  btnParcEstab.Enabled     := False;

  tmrAtualizaMsg.Enabled := True;
  pPassaCartao;
  tmrAtualizaMsg.Enabled   := False;

  ModalResult              := MrOk;
end;

procedure TfrmTefCitelOperacoes.btnDebitoClick(Sender: TObject);
begin
  inherited;
  if not blnPermiteSelecionarMenu then
    Exit;

  blnPermiteSelecionarMenu := False; 

  btnCredito.Enabled       := False;
  btnDebito.Enabled        := False;
  btnPix.Enabled           := False;

  pnOperacao.Caption       := 'SELECIONADO: DÉBITO';
  intOperacao              := 2;
  strModalidade            := '';
					   			   
  tmrAtualizaMsg.Enabled   := True;
  pPassaCartao;
  tmrAtualizaMsg.Enabled   := False;

  ModalResult := MrOk;
end;

procedure TfrmTefCitelOperacoes.btnEncerraMenuClick(Sender: TObject);
begin
  inherited;
  pEncerrar;
end;

procedure TfrmTefCitelOperacoes.btnEncerraOpcoesCarDigClick(Sender: TObject);
begin
  inherited;

  if not blnPermiteSelecionarMenu then
    Exit;

  blnPermiteSelecionarMenu := True ;

  pAtualizaEstadoBotoes;

  pnCarDig.Visible         := False ;

  btnCarDig001.Enabled             := False ;
  btnCarDig002.Enabled             := False ;
  btnCarDig003.Enabled             := False ;
  btnPopMenu.Enabled               := False ;
  btnEncerraOpcoesCarDig.Enabled   := False;

  pSetFocus(btnCredito) ;
end;

procedure TfrmTefCitelOperacoes.btnEncerraOpcoesCreditoClick(Sender: TObject);
begin
  inherited;
  pEncerrar;
end;

procedure TfrmTefCitelOperacoes.btnParcAdmClick(Sender: TObject);
begin
  inherited;
  if not blnPermiteSelecionarOpcao then
    Exit;

  blnPermiteSelecionarOpcao := False;

  if fMensagem('ATENÇÃO!', 'Tem certeza que será ''Crédito Parcelado COM Juros''?', ['&Sim', '&Não'],2) = 1 then
  begin
    blnPermiteSelecionarOpcao       := False;

    strModalidade                   := fCodigoModalidadeCartaoCredito(ccmParcAdm);
    pnDados.Visible                 := True;
    pnOperacao.Caption              := fDescricaoCompletaCartaoCredito(ccmParcAdm);
    pSetFocus(edtQtdPar);
    edtValor.Value                  := fltValor;
    pnOpcoesCredito.Enabled         := False;
    pnOpcoesCredito.Visible         := False;
  end
  else
  begin
    blnPermiteSelecionarOpcao := True;
    pnOpcoesCredito.Enabled   := True;
    pnDados.Visible           := False;
    btnAvista.Enabled         := fHabilitaOpcoesAVista;
    btnParcAdm.Enabled        := fHabilitaOpcoesPrazo and fHabilitaParcAdm;
    btnParcEstab.Enabled      := fHabilitaOpcoesPrazo;
  end;
end;

procedure TfrmTefCitelOperacoes.btnParcEstabClick(Sender: TObject);
begin
  inherited;
  if not blnPermiteSelecionarOpcao then
    Exit;

  blnPermiteSelecionarOpcao := False;

  strModalidade := fCodigoModalidadeCartaoCredito(ccmParcLoja) ;

  pnOpcoesCredito.Visible         := False;
  pnDados.Visible                 := True;
  pSetFocus(edtQtdPar);
  edtValor.Value                  := fltValor;
  pnOperacao.Caption              := fDescricaoCompletaCartaoCredito(ccmParcLoja);
end;

procedure TfrmTefCitelOperacoes.btnPopMenuClick(Sender: TObject);
Var
  Lpnt : TPoint;
begin
  inherited;
  Lpnt := TButton(Sender).ClientToScreen(Point(0, TButton(Sender).Height)) ;
  mnuCarDigOutras.Popup(Lpnt.X, Lpnt.Y);
end;

procedure TfrmTefCitelOperacoes.FormCreate(Sender: TObject);
begin
  inherited;
  FobjModalidadeDinamica := nil ;
  FobjOpcoes := nil ;
  FlstEdits := TList<TWinControl>.Create ;
  FdictBotoesModalidadeDinamica := TObjectDictionary<TChaveValorModalidade, TBitBtnLocked>.Create([doOwnsKeys]);
  FobjInfoCartaoCreditoModalidade := fInfoCartaoCreditoModalidade('') ;
  pAtualizaLayoutCartaoCreditoModalidade ;
  FdictCodigoCardse := TDictionary<string,TregInfoCarDig>.Create();
  FOperacaoAndamento := False;
  blnPermiteSair     := True;
  pnQRCode.Visible := False;
  btnPix.Visible := fMostrarOpcaoPix ;
  if fCfgSis('TEFCIT', varString) = OPCAO_NCR then
    self.Caption := 'Operações Scope' ;
  objDadosAdicionaisTefTra := Nil ;
  FstrMotivoTransacaoNegada := '' ;
  FblnApenasAVista := False;
  FblnApenasPrazo := False;
  FCfgSOLCAR := fCfgSis('SOLCAR', varBoolean);
end;

procedure TfrmTefCitelOperacoes.pAtualizaEstadoBotoes;
var
  LblnCredito: Boolean;
  LblnDebito: Boolean;
begin
  LblnCredito := (fHabilitaOpcoesAVista or fHabilitaOpcoesPrazo);
  LblnDebito  := fHabilitaOpcoesAVista;

  if FCfgSOLCAR then
  begin
    LblnCredito := LblnCredito and (not blnApenasDebito);
    LblnDebito  := LblnDebito  or  (not blnApenasDebito);
  end;

  btnCredito.Enabled     := LblnCredito;
  btnDebito.Enabled      := LblnDebito;
  btnPix.Enabled         := fMostrarOpcaoPix and fHabilitaOpcoesAVista;
  btnAvista.Enabled      := fHabilitaOpcoesAVista;
  btnParcEstab.Enabled   := fHabilitaOpcoesPrazo;
  btnParcAdm.Enabled     := fHabilitaOpcoesPrazo and fHabilitaParcAdm;
  btnEncerraMenu.Enabled := True;
end;

procedure TfrmTefCitelOperacoes.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FdictBotoesModalidadeDinamica);
  FreeAndNil(FlstEdits);
  FreeAndNil(FdictCodigoCardse) ;
end;

procedure TfrmTefCitelOperacoes.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fModalidadeDinamica then
  begin
    FobjModalidadeDinamica.pKeyPressModalidade(Key) ;
    Exit ;
  end ;

  if (CharInSet(Key, [#49, #97])) then
    pTecla1Click;

  if (CharInSet(Key, [#50, #98])) then
    pTecla2Click;

  if (CharInSet(Key, [#51, #99])) then
    pTecla3Click;

  if (CharInSet(Key, [#57, #105])) then
    pTecla9Click;
end;

procedure TfrmTefCitelOperacoes.FormShow(Sender: TObject);
begin
  inherited;
  edtQtdPar.Text := EmptyStr;
  blnPermiteSelecionarOpcao := True;
  blnPermiteSelecionarMenu  := True;
  pCarregaCarDig;

  FblnApenasAVista   := False;
  FblnApenasPrazo    := False;
  edtQtdPar.ReadOnly := False;

  if Assigned(objValidaParcelas) and
     objValidaParcelas.fObrigarQuantidadeNegociada then
  begin
    FblnApenasAVista := objValidaParcelas.QtdNeg <= 1;
    FblnApenasPrazo  := objValidaParcelas.QtdNeg > 1;

    if FblnApenasPrazo then
    begin
      edtQtdPar.Text     := objValidaParcelas.QtdNeg.ToString();
      edtQtdPar.ReadOnly := True;
    end;
  end;

  pAtualizaEstadoBotoes;
end;

function TfrmTefCitelOperacoes.fTecla1: boolean;
begin
  result := False ;
  if pnMenu.Visible then
  begin
    if not pnMenu.Enabled then
      Exit;

    if btnCredito.Enabled then
    begin
      btnCreditoClick(Self);
      Exit;
    end ;
  end;

  if pnCarDig.Visible then
  begin
    if not btnCarDig001.Visible then
      exit ;

    if btnCarDig001.Enabled then
      btnCarDig001.Click ;

    Exit;
  end ;
  result := True ;
end;

function TfrmTefCitelOperacoes.fTecla2: boolean;
begin
  result := False ;

  if pnOpcoesCredito.Visible then
  begin
    if not pnOpcoesCredito.Enabled then
      Exit;

    if pnDados.Visible then
      Exit;

    if not btnParcAdm.Visible then
      Exit;

    if btnParcAdm.Enabled then
      btnParcAdmClick(Self);
  end
  else
  if pnMenu.Visible then
  begin
    if not pnMenu.Enabled then
      Exit;

    if btnDebito.Enabled then
    begin
      btnDebitoClick(Self);
      exit ;
    end ;
  end;

  result := True ;
end;

function TfrmTefCitelOperacoes.fTecla3: boolean;
begin
  result := False ;

  if pnOpcoesCredito.Visible then
  begin
    if not pnOpcoesCredito.Enabled then
      Exit;

    if pnDados.Visible then
      Exit;

    if not btnParcEstab.Visible then
      Exit;

    btnParcEstabClick(Self);
  end
  else
  if pnMenu.Visible then
  begin
    if not pnMenu.Enabled then
      Exit;

    if btnPix.Enabled then
    begin
      btnPix.Click ;
      exit ;
    end ;
  end ;

  result := True ;
end;

function TfrmTefCitelOperacoes.fTecla9PnDados: boolean;
begin
  result := false ;
  if edtQtdPar.Focused then
    Exit;

  if btnRetorna.Enabled then
  begin
    btnRetornaClick(Self);
    exit ;
  end ;
  result := True ;
end;

function TfrmTefCitelOperacoes.fValidaParcelas(intQtdParc : Integer): Boolean;
begin
  Result := True;

  if intQtdParc < 2 then
    Result := False;

  if intQtdParc > 99 then
    Result := False;
end;

procedure TfrmTefCitelOperacoes.pEventItemCarDigClick(Sender: TObject);
var
  LstrComponente: string ;
begin
  if not blnPermiteSelecionarMenu then
    Exit;

  LstrComponente := TComponent(Sender).name ;

  blnPermiteSelecionarMenu := False;

  btnCredito.Enabled       := False;
  btnDebito.Enabled        := False;
  btnPix.Enabled           := False;
  btnCarDig001.Enabled     := False ;
  btnCarDig002.Enabled     := False ;
  btnCarDig003.Enabled     := False ;
  btnPopMenu.Enabled       := False ;

  pnOperacao.Caption       := 'SELECIONADO: ' + FdictCodigoCardse[LstrComponente].descri ;
  intOperacao              := CARTEIRA_DIGITAL;
  strModalidade            := '1';

  tmrAtualizaMsg.Enabled   := True;
  pPassaCartao('{CarteirasDigitaisHabilitadas=' + FdictCodigoCardse[LstrComponente].cardse + '}');
  tmrAtualizaMsg.Enabled   := False;

  ModalResult              := MrOk;
end;

procedure TfrmTefCitelOperacoes.pEventItemCarDigMaisClick(Sender: TObject);
begin
  if not blnPermiteSelecionarMenu then
    Exit;

  blnPermiteSelecionarMenu := True ;

  btnCredito.Enabled       := False;
  btnDebito.Enabled        := False;
  btnPix.Enabled           := False;
  btnEncerraMenu.Enabled   := False;

  pnCarDig.Visible         := True ;

  btnCarDig001.Enabled           := True ;
  btnCarDig002.Enabled           := True ;
  btnCarDig003.Enabled           := True ;
  btnPopMenu.Enabled             := True ;
  btnEncerraOpcoesCarDig.Enabled := True ;

  pSetFocus(btnCarDig001) ;

end;

procedure TfrmTefCitelOperacoes.pAtualizaLayoutCartaoCreditoModalidade;
begin
  if fModalidadeDinamica then
    Exit;
  btnAVista.Caption := FobjInfoCartaoCreditoModalidade.DescricaoReduzida[ccmAVista] ;
  btnAVista.Visible := FobjInfoCartaoCreditoModalidade.ModalidadeVisivel[ccmAVista] ;
  btnParcAdm.Caption := FobjInfoCartaoCreditoModalidade.DescricaoReduzida[ccmParcAdm] ;
  btnParcAdm.Visible := FobjInfoCartaoCreditoModalidade.ModalidadeVisivel[ccmParcAdm] ;
  btnParcEstab.Caption := FobjInfoCartaoCreditoModalidade.DescricaoReduzida[ccmParcLoja] ;
  btnParcEstab.Visible := FobjInfoCartaoCreditoModalidade.ModalidadeVisivel[ccmParcLoja] ;
end;

procedure TfrmTefCitelOperacoes.pCarregaCarDig;
var
  LqryCarDig: TUniQuery ;
  LintCnt: integer ;
  LstrBotaoNome, LstrMenuNome: string ;
  LobjBotao: TObject ;
  LmnuCarDig : TMenuItem;
  LregInfo : TregInfoCarDig ;
begin
  FdictCodigoCardse.Clear ;
  LqryCarDig := fCriaQuery() ;
  try
    LqryCarDig.Close ;
    LqryCarDig.SQL.Clear ;
    LqryCarDig.SQL.Add(' SELECT DIG_CARDSE, DIG_DESCRI, DIG_ORDEM_ ') ;
    LqryCarDig.SQL.Add(' FROM CARDIG ') ;
    LqryCarDig.SQL.Add(' ORDER BY DIG_ORDEM_ ') ;
    LqryCarDig.Open ;
    LqryCarDig.First ;
    if LqryCarDig.RecordCount = 1 then
    begin
      btnPix.Caption := fstrEspaco('3 -  ' + LqryCarDig.FieldByName('DIG_DESCRI').AsString, 21) ;
      btnPix.OnClick := pEventItemCarDigClick ;
      FillChar(LregInfo,SizeOf(LregInfo),#0);
      LregInfo.cardse := LqryCarDig.FieldByName('DIG_CARDSE').AsString ;
      LregInfo.descri := LqryCarDig.FieldByName('DIG_DESCRI').AsString ;
      FdictCodigoCardse.Add(btnPix.name, LregInfo);
    end
    else if LqryCarDig.RecordCount >= 2 then
    begin
      btnPix.Caption := fstrEspaco('3 -  Cart. Digitais', 21) ;
      btnPix.OnClick := pEventItemCarDigMaisClick ;
      LintCnt := 0 ;
      LqryCarDig.first ;
      while not LqryCarDig.Eof do
      begin
        inc(LintCnt) ;
        if LintCnt <= 2 then
        begin
          LstrBotaoNome := 'btnCarDig' + fStrZero(LintCnt, 3) ;
          LobjBotao := self.FindComponent(LstrBotaoNome) ;
          if Assigned(LobjBotao) then
          begin
            TBitBtnLocked(LobjBotao).Caption := fstrEspaco(LqryCarDig.FieldByName('DIG_ORDEM_').AsString + ' -  ' + LqryCarDig.FieldByName('DIG_DESCRI').AsString, 19) ;
            TBitBtnLocked(LobjBotao).Visible := True ;
            TBitBtnLocked(LobjBotao).OnClick := pEventItemCarDigClick ;
            FillChar(LregInfo,SizeOf(LregInfo),#0);
            LregInfo.cardse := LqryCarDig.FieldByName('DIG_CARDSE').AsString ;
            LregInfo.descri := LqryCarDig.FieldByName('DIG_DESCRI').AsString ;
            FdictCodigoCardse.Add(LstrBotaoNome, LregInfo);
          end ;
        end
        else /// depois do 2 cria os itens no menu
        begin
          btnCarDig003.Caption := fstrEspaco('3 -  Outras', 16) ;
          btnCarDig003.Visible := True ;
          btnPopMenu.Visible   := True ;

          LmnuCarDig := TMenuItem.Create(mnuCarDigOutras);
          LstrMenuNome := 'mnuDigCar' + fStrZero(LintCnt, 3) ;
          LmnuCarDig.Name := LstrMenuNome ;
          LmnuCarDig.Caption := fstrEspaco(LqryCarDig.FieldByName('DIG_ORDEM_').AsString + ' -  ' + LqryCarDig.FieldByName('DIG_DESCRI').AsString, 21) ;
          LmnuCarDig.OnClick := pEventItemCarDigClick ;
          mnuCarDigOutras.Items.Add(LmnuCarDig);
          FillChar(LregInfo,SizeOf(LregInfo),#0);
          LregInfo.cardse := LqryCarDig.FieldByName('DIG_CARDSE').AsString ;
          LregInfo.descri := LqryCarDig.FieldByName('DIG_DESCRI').AsString ;
          FdictCodigoCardse.Add(LstrMenuNome, LregInfo);

        end ;
        LqryCarDig.Next ;
      end ;
    end ;
  finally
    FreeAndNil(LqryCarDig) ;
  end ;
end;

procedure TfrmTefCitelOperacoes.pEncerrar;
begin
  if blnPermiteSair then
  begin
    ObjTefCitel.pSair(True);
    intOperacao := -1;
    Self.Close;
  end;
end;

procedure TfrmTefCitelOperacoes.pIniciaTimerPix;
begin
  lbTmrPix.caption := '02:59';
  intMinutos := 2;
  intSegundos := 59;
  tmrPix.Enabled := True;
end;

procedure TfrmTefCitelOperacoes.pMontaListaFormsPagto(strMensagem : String);
  var
    strAux: String;
    i, tamanho: Integer;
    strConteudo : String;
    stlLista : TStringList;
    LblnAVista, LblnParcEstab, LblnParcAdm: Boolean;
  const
    strSeparator = ':';
begin
  if fModalidadeDinamica then
  begin
    if not FobjModalidadeDinamica.fModalidadeCarregada then
      FobjModalidadeDinamica
        .fForm(Self)
        .fSetOwner(pnOpcoesCredito)
        .fOpcoesOwner(pnDados)
        .fSetOnClickModalidade(pOnClickModalidadeDinamica)
        .fSetBotaoModelo(btnEncerraOpcoesCredito)
        .fEditsOpcoes(FlstEdits)
        .fBotoesModalidades(FdictBotoesModalidadeDinamica)
        .fMontaTelaModalidade(strMensagem) ;
    exit ;
  end ;

  stlLista := TStringList.Create;
  try
    strConteudo := Trim(strMensagem);
    tamanho     := Length(strConteudo);
    for i := 0 to tamanho -1 do
    begin
      strAux := Copy(strConteudo,i,1);
      if strAux = strSeparator then
        stlLista.Add(Copy(strConteudo,i-1,1));
    end;

    if not fEmptyStr(strModalidade) then
      exit;

    // Reset: parte do zero — apenas os modos que o TEF devolver (e que CNTF11 permitir) são habilitados
    // O estado sai calculado nas variáveis e vai aos botões uma vez só: o SiTef reenvia o menu (21)
    // enquanto o operador não escolhe, e desligar e religar o botão a cada volta faz a tela piscar
    // e perder o clique do mouse (Req. 462792).
    LblnAVista    := False;
    LblnParcEstab := False;
    LblnParcAdm   := False;

    for I := 0 to stlLista.Count -1 do
    begin
      case stlLista[i].ToInteger of
        1 : LblnAVista    := fHabilitaOpcoesAVista;
        2 : LblnParcEstab := fHabilitaOpcoesPrazo;
        3 : LblnParcAdm   := fHabilitaOpcoesPrazo and fHabilitaParcAdm;
      end;
    end;

    btnAVista.Enabled    := LblnAVista;
    btnParcEstab.Enabled := LblnParcEstab;
    btnParcAdm.Enabled   := LblnParcAdm;
  finally
    FreeAndNil(stlLista);
  end;
end;

procedure TfrmTefCitelOperacoes.pPassaCartao(strCodigoCarteiraDigital : string = '');
begin
  RetornoTEFCitel := fPassaCartao(intOperacao,
                                  intQtdParcelas,
                                  strModalidade,
                                  strNumDoc,
                                  fltValor,
                                  strRcxCodOpe,
                                  False,
                                  strCodigoCarteiraDigital,
                                  objDadosAdicionaisTefTra);

  if fCfgSis('TRAAPR', varBoolean) then
  begin
    if Assigned(RetornoTEFCitel) then
      fMensagem('ATENÇÃO!', 'Transação autorizada!', ['&OK'])
    else
      if fEmptyStr(FstrMotivoTransacaoNegada) then
        fMensagem('ATENÇÃO!', 'Houve um problema com a transação. '+sLineBreak+
                              'Verifique no relatório do TEF se a mesma foi autorizada!', ['&OK']);
  end;
end;

procedure TfrmTefCitelOperacoes.tmrAtualizaMsgTimer(Sender: TObject);
begin
  inherited;
  {*******************************************}
  {* ESTE TIMER FOI COLOCADO PARA MANTER     *}
  {* SINCRONIZADO AS MENSAGENS DO PINPAD     *}
  {* JUNTO COM AS MENSAGENS PAINEL DE MSG    *}
  {*****************************************AZ}
  Application.ProcessMessages;
end;

procedure TfrmTefCitelOperacoes.tmrHabilitaTimer(Sender: TObject);
begin
  inherited;
  btnEncerraMenu.Enabled          := blnPermiteSair;
  btnEncerraOpcoesCredito.Enabled := blnPermiteSair;
  btnRetorna.Enabled              := blnPermiteSair;
end;

procedure TfrmTefCitelOperacoes.tmrPixTimer(Sender: TObject);
begin
  inherited;
  intSegundos := intSegundos - 1;

  if (intSegundos = 0) then
  begin
    if (intMinutos > 0) then
    begin
      intMinutos := intMinutos - 1;
      intSegundos := 59;
    end
    else
      tmrPix.Enabled := False;
  end;

  lbTmrPix.caption := fStrZero(intMinutos,2)+':'+ fStrZero(intSegundos,2);
end;

procedure TfrmTefCitelOperacoes.AtualizaTefCitel(ARetorno: IRetornoTEFCitel);
begin
  if ARetorno.StatusTEF.strStatus = '' then
    Exit;

  tefCitelRetorno := ARetorno;
  strStatus := ARetorno.StatusTEF.strStatus;

  case StrToInt(ARetorno.StatusTEF.strStatus) of
    strInfo04: pMsgInfo04;
    strInfo20: pMsgInfo20;
    strInfo21: pMsgInfo21;
    strInfo23: pMsgInfo23;
    strInfo30: pMsgInfo30;
    strInfo34: pMsgInfo34;
    strInfo50: pMsgInfo50;
    strInfo131: pMsgInfo131;
    strInfo500: pMsgInfo500;
    strInfo999: pMsgInfo999;
    else
	  pMsgInfoOutros;
  end;
end;

procedure TfrmTefCitelOperacoes.pTecla1Click;
begin
  if fModalidadeDinamica then
    Exit;

  if not blnPermiteSelecionarOpcao then
    Exit;

  if pnDados.Visible then
  begin
    if not pnDados.Enabled then
      Exit;

    if not edtQtdPar.Focused then
      btnConfirmaClick(Self);

    Exit;
  end;

  if pnOpcoesCredito.Visible then
  begin
    if not pnOpcoesCredito.Enabled then
      Exit;

    if not btnAvista.Visible then
      Exit;

    if btnAvista.Enabled then
      btnAvistaClick(Self);

    Exit;
  end;

  if not fTecla1 then
  begin
    exit ;
  end ;

end;

procedure TfrmTefCitelOperacoes.pTecla2Click;
begin
  if fModalidadeDinamica then
    Exit;

  if not blnPermiteSelecionarOpcao then
    Exit;
  
  if not fTecla2 then
  begin
    exit ;
  end ;

  if pnCarDig.Visible then
  begin
    if not btnCarDig002.Visible then
      exit ;

    if btnCarDig002.Enabled then
      btnCarDig002.Click ;

  end ;

end;

procedure TfrmTefCitelOperacoes.pTecla3Click;
begin
  if fModalidadeDinamica then
    Exit;

  if not blnPermiteSelecionarOpcao then
    Exit;
  
  if not fTecla3 then
  begin
    exit ;
  end ;

  if pnCarDig.Visible then
  begin
    if not btnCarDig003.Visible then
      exit ;

    if btnCarDig003.Enabled then
      btnPopMenu.Click ;

  end ;

end;

procedure TfrmTefCitelOperacoes.pTecla9Click;
begin

  if fModalidadeDinamica then
    Exit;

  if pnQRCode.Visible then
  begin
    tmrPix.Enabled := False ;
    pnQRCode.Visible   := False;
    pnPrincipal.Visible := True;
    blnPermiteSair := True;
    btnRetornaClick(Self);
    exit ;
  end ;

  if pnMenu.Visible then
  begin
    if btnEncerraMenu.Enabled then
      btnEncerraMenuClick(Self);
  end
  else if pnOpcoesCredito.Visible then
  begin
    if btnEncerraOpcoesCredito.Enabled then
      btnEncerraOpcoesCreditoClick(Self);
  end
  else if pnDados.Visible then
  begin
    if not fTecla9PnDados then
    begin
      exit ;
    end ;
  end;

  if not pTecla9ClickCardig then
    exit ;

end;

procedure TfrmTefCitelOperacoes.pMsgInfo20;
  var
    FrmTefCitelInfoMsg : TFrmTefCitelInfoMsg;
begin
  pnQRCode.Visible   := False;
  pnPrincipal.Visible := True;
  if fVerificaMsgTefCitel(tefCitelRetorno.StatusTEF.strMensagem) then
  begin
    pCriarFormularios(TFrmTefCitelInfoMsg, FrmTefCitelInfoMsg);
    try
      FrmTefCitelInfoMsg.strStatus           := tefCitelRetorno.StatusTEF.strStatus;
      FrmTefCitelInfoMsg.lbStatusTef.Caption := tefCitelRetorno.StatusTEF.strMensagem;
      FrmTefCitelInfoMsg.ShowModal;
    finally
      pFreeAndNil(FrmTefCitelInfoMsg);
    end
  end
  else
  begin
    if pnDados.Visible then
      blnPermiteSair := True;
    pnMensTef.Font.Color := clRed;
    pnMensTef.Caption    := tefCitelRetorno.StatusTEF.strMensagem;
    pnMensTef.Refresh;
  end;
end;

procedure TfrmTefCitelOperacoes.pMsgInfo21;
begin
  pnQRCode.Visible   := False;
  pnPrincipal.Visible := True;
  blnPermiteSair := True;
  if (intOperacao = 2) and (not fModalidadeDinamica) then
    exit;

  if not pnDados.Visible then
  begin
    pnOpcoesCredito.Visible := True;
    pnOpcoesCredito.Enabled := True;
    pnMenu.Visible          := False;
    pnMenu.Enabled          := False;
    pMontaListaFormsPagto(tefCitelRetorno.StatusTEF.strMensagem);
  end;
end;

procedure TfrmTefCitelOperacoes.pMsgInfo23;
begin
  if fVerificaMsgInsereCartao(pnMensTef.Caption) then
    blnPermiteSair    := True
  else
    blnPermiteSair    := False;
  pnQRCode.Visible   := False;
  pnPrincipal.Visible := True;
  pnQRCode.Visible   := False;
  pnPrincipal.Visible := True;
  if (intOperacao = 2) and (not fModalidadeDinamica) then
    exit;
end;

procedure TfrmTefCitelOperacoes.pMsgInfo30;
begin
  pnQRCode.Visible := False;
  pnPrincipal.Visible := True;
  if not pnDados.Visible then
    blnPermiteSair := False;
  if (intOperacao = 2) and (not fModalidadeDinamica) then
    exit;
end;

procedure TfrmTefCitelOperacoes.pMsgInfo34;
begin
  pnQRCode.Visible   := False;
  pnPrincipal.Visible := True;
  blnPermiteSair      := False;
  if (intOperacao = 2) and (not fModalidadeDinamica) then
    exit;
end;

procedure TfrmTefCitelOperacoes.pMsgInfo50;
  var
    bmpQrCode: TBitmap;
begin
  blnPermiteSair      := False;
  pnQRCode.Visible   := True;
  pnPrincipal.Visible := False;

  bmpQrCode := fGerarQRCode(tefCitelRetorno.StatusTEF.strMensagem);
  try
    imgQRCode.Picture.Bitmap := bmpQrCode;
  finally
    FreeAndNil(bmpQrCode);
  end;

  pIniciaTimerPix;
end;

procedure TfrmTefCitelOperacoes.pMsgInfo500;
begin
  FstrMotivoTransacaoNegada := tefCitelRetorno.StatusTEF.strMensagem ;
  fMensagem('ATENÇÃO!', FstrMotivoTransacaoNegada, ['&Ok']);
end;

procedure TfrmTefCitelOperacoes.pMsgInfo999;
begin
  pGravaTransacaoErro(strNumDoc, fltValor) ;
  fMensagem('ATENÇÃO!', tefCitelRetorno.StatusTEF.strMensagem, ['&Ok']);
end;

procedure TfrmTefCitelOperacoes.pMsgInfoOutros;
begin
  if StrToInt(tefCitelRetorno.StatusTEF.strStatus) < 0 then
  begin
    blnPermiteSair := False;
    if fVerificaMsgTefCitel(tefCitelRetorno.StatusTEF.strMensagem) then
      fMensagem('ATENÇÃO!', tefCitelRetorno.StatusTEF.strMensagem, ['&Ok']);
  end
  else
  begin
    blnPermiteSair := False;
    if StrToInt(tefCitelRetorno.StatusTEF.strStatus) > 0 then
      fMensagem('ATENÇÃO!', tefCitelRetorno.StatusTEF.strMensagem, ['&Ok']);
  end;
end;

function TfrmTefCitelOperacoes.fModalidadeDinamica: Boolean;
begin
  Result := Assigned(FobjModalidadeDinamica) ;
end;

procedure TfrmTefCitelOperacoes.pOnClickConfirmarOpcoes(Sender: TObject);
var
  LobjControlFoco: TWinControl ;
  LstrMensagem: String ;
begin
  if not Assigned(FobjOpcoes) then
    exit ;

  if not FobjOpcoes.fValidaCamposInformados(LobjControlFoco, LstrMensagem) then
  begin
    fMensagem('ATENÇÃO!', LstrMensagem, ['&Ok']);
    pSetFocus(LobjControlFoco);
    exit ;
  end ;

  btnConfirma.Enabled    := False;
  tmrAtualizaMsg.Enabled := True;
  FobjOpcoes.fEnviaDadosInformados ;
  tmrAtualizaMsg.Enabled := False;
  ModalResult            := mrOk;
end;

procedure TfrmTefCitelOperacoes.pOnClickEncerrarOpcoes(Sender: TObject);
begin
  blnPermiteSair := True;
  pEncerrar ;
end;

procedure TfrmTefCitelOperacoes.pOnClickModalidadeDinamica(Sender: TObject);
var
  LstrTextoComplementar: String ;
  LstrDescModalidade: String ;
begin
  if not blnPermiteSelecionarOpcao then
    Exit;

  LstrDescModalidade := Trim(copy(TBitBtnLocked(Sender).Caption, 4, Length(TBitBtnLocked(Sender).Caption))) ;
  blnPermiteSelecionarOpcao := False;

  pnOperacao.Caption        := 'Selecionado Cartão Débito ' + LstrDescModalidade ;

  FobjModalidadeDinamica.pHabilitaBotoesModalidade(False);

  strModalidade             := inttostr(TBitBtnLocked(Sender).tag) ;

  FobjOpcoes := FobjModalidadeDinamica
                  .fOnKeyPressOpcoes(pOnKeyPressOpcoes)
                  .fOnClickConfirmarOpcoes(pOnClickConfirmarOpcoes)
                  .fOnClickEncerrarOpcoes(pOnClickEncerrarOpcoes)
                  .fValor(fltValor)
                  .fMontaTelaOpcoes(strModalidade, LstrTextoComplementar) ;
  if Assigned(FobjOpcoes) then
  begin
    pnOperacao.Caption        := 'Selecionado Cartão Débito ' + LstrDescModalidade + ' ' + LstrTextoComplementar  ;
    pnDados.Visible := True ;
    pnMenu.Visible := False ;
    pnOpcoesCredito.Visible := False ;
    pnOpcoesCredito.Enabled := False ;
    blnPermiteSelecionarOpcao := True;
    pSetFocus(TWinControl(FobjOpcoes.fPrimeiroControlFoco));
  end
  else // debito a vista
  begin
    tmrAtualizaMsg.Enabled    := True;
    if Assigned(objDadosAdicionaisTefTra) then
    begin
      objDadosAdicionaisTefTra.Modalidade(strModalidade) ;
      pAtualizaTefTraComDadosAdicionais(objDadosAdicionaisTefTra, Nil) ;
    end ;
    pInfo21(strModalidade);
    tmrAtualizaMsg.Enabled    := False;
    ModalResult := mrOk;
  end ;
end;

procedure TfrmTefCitelOperacoes.pOnKeyPressOpcoes(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    SelectNext(ActiveControl, True, True);
    Key := #0;
  end;
end;

function TfrmTefCitelOperacoes.pTecla9ClickCardig: Boolean;
begin
  Result := False ;
  if pnCarDig.Visible then
  begin
    if not pnCarDig.Enabled then
      exit ;

    if btnEncerraOpcoesCarDig.Enabled then
      btnEncerraOpcoesCarDig.Click ;

  end ;
  Result := True ;
end;

procedure TfrmTefCitelOperacoes.pMsgInfo04;
begin
  if tefCitelRetorno.StatusTEF.strMensagem = strMsgSelFormaPag then
  begin
    pnMensTef.Font.Color := clRed;
    pnMensTef.Caption    := tefCitelRetorno.StatusTEF.strMensagem;
    pnMensTef.Refresh;
  end;
end;

procedure TfrmTefCitelOperacoes.pMsgInfo131;
var
  LstrRede: String ;
begin
  LstrRede := '' ;
  if Assigned(tefCitelRetorno) then
    if Assigned(tefCitelRetorno.StatusTEF) then
      LstrRede := tefCitelRetorno.StatusTEF.strMensagem ;

  /// somente operação de debito
  if (not fModalidadeDinamica) and (intOperacao = 2) then
  begin
    FobjModalidadeDinamica := fModalidadeDinamicaByRede(LstrRede) ;
    if not fModalidadeDinamica then
    begin
      strModalidade := '1';
      tmrAtualizaMsg.Enabled    := True;
      if Assigned(objDadosAdicionaisTefTra) then
      begin
        objDadosAdicionaisTefTra.Modalidade(strModalidade) ;
        pAtualizaTefTraComDadosAdicionais(objDadosAdicionaisTefTra, Nil) ;
      end ;
      pInfo21(strModalidade);
      tmrAtualizaMsg.Enabled    := False;
    end ;
  end ;

  FobjInfoCartaoCreditoModalidade := fInfoCartaoCreditoModalidade(LstrRede) ;
  //ajusta as informações de acordo com a rede retornada
  pAtualizaLayoutCartaoCreditoModalidade ;
end;

end.
