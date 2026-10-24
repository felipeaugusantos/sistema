unit untFatLiberacaoBloqueios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, ExtCtrls, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, untFuncfat, untFuncoesSimples,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, StrUtils, DBCtrls, DateUtils,
  DBMemoFocus, ImgList, cxGraphics, BitBtnLockedIncrem, MemDS, cxProgressBar,
  DBAccess, Datasnap.Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, dxGDIPlusClasses, untFuncoes, untTypesSistema, MemoFocus;

type
  TfrmFatLiberacaoBloqueios = class(TfrmPaiOrdena)
    imgBloqueado: TImage;
    imgAguardando: TImage;
    imgSolicitar: TImage;
    imgCancelar: TImage;
    imgNegada: TImage;
    cdsConsultaDIRACE: TStringField;
    cdsConsultaNUMLIB: TStringField;
    cdsConsultaMOTIVO: TStringField;
    cdsConsultaINFBLO: TMemoField;
    cdsConsultaINFLIB: TMemoField;
    cdsConsultaMSGLIB: TMemoField;
    cdsConsultaSOLICI: TStringField;
    cdsConsultaCANCEL: TStringField;
    cdsConsultaSTATUS: TStringField;
    imgLiberado: TImage;
    spl1: TSplitter;
    mmoInfLib: TDBMemoFocus;
    mmoInfBlo: TMemoFocus;
    cdsConsultaCODOPE: TStringField;
    cdsConsultaCODDIG: TStringField;
    cdsConsultaOPELIB: TStringField;
    cdsConsultaMENOBS: TMemoField;
    cdsConsultaCODITE: TStringField;
    cdsConsultaAUTINC: TIntegerField;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    btnOk: TBitBtnLocked;
    lbl7: TLabel;
    cdsConsultaLIBERA: TStringField;
    imgLiberar: TImage;
    pnlMsgLib: TPanel;
    cdsConsultaNOMOPE: TStringField;
    cdsConsultaMSGJSO: TMemoField;
    imgAnalise: TImage;
    lblAnalise: TLabel;
    cdsConsultaMSGSEN: TStringField;
    btnAnlAnalitica: TBitBtnLocked;
    cdsConsultaAVISO_: TStringField;
    cdsConsultaLIBPED: TStringField;
    btnImgCliente: TBitBtnLocked;
    btnLiberarTodas: TBitBtnLocked;
    btnEnvMensagem: TBitBtnLocked;
    pnlMensagens: TPanel;
    pnlShapeQtdMsgPen: TPanel;
    shpQtdMsg: TShape;
    lblQtdMsg: TLabel;
    btnMensagens: TBitBtnLocked;
    imgOpeSemAce: TImage;
    lblOpeSemAce: TLabel;
    cdsConsultaTEMACE: TStringField;
    btnProdPreMin: TBitBtnLocked;
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaCellClick(Column: TColumn);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure tmrLiberaTimer(Sender: TObject);
    procedure spl1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure spl2CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAnlAnaliticaClick(Sender: TObject);
    procedure btnImgClienteClick(Sender: TObject);
    procedure btnLiberarTodasClick(Sender: TObject);
    procedure btnEnvMensagemClick(Sender: TObject);
    procedure btnMensagensClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnProdPreMinClick(Sender: TObject);
  private
    { Private declarations }
    X_POS_GRID, Y_POS_GRID: Integer;

    intREC_NO: Integer;
    intCOR_ZEBRA: Integer;

    intSemaforo: Integer;
    strJustTemp : String;
    blnUsaDig : Boolean;

    tmrLibera: TNewTimer;
    strCodigoLiberacaoLogVar: String;

    blnExecutandoAcao: Boolean;

    procedure pCarregaBloqueios;
    procedure pCarregaValorFrete(var objLogAvi: TLogAvi);
    procedure pCarregaProfissionaisBloqueios(var objLogAvi: TLogAvi);
    procedure pCarregaTransportadoraValorMinimo(var ObjLogAvi: TLogAvi);
    procedure pAtualizarOpeLibArrLogAvi;
    function fCancelarSolicitacao: Boolean;
    function fEnviaMsgLiberacao(pgbStatus: TcxProgressBar = nil): Boolean;

    function fEnviarParaLiberacaoPorEscolhaOperador: Boolean;
    function fItemJaLiberado: Boolean;
    procedure pAvisosLimpaLogAvi;

    function fMsgLiberacaoJaLida(strNumLib     : String;
                                 var strMsgLib : String;
                                 var strOpeLib : String;
                                 strOpeLibRef  : String = ''): Boolean;

    function fLiberacaoCompleta(var blnTodasRespondidas: Boolean): Boolean;
    procedure pApagaLogVarNaoUtilizado;
    procedure pCancelarTodasSolicitacoes;
    function fMsgLiberacaoJaAnalisando(strNumLib : String; var strOpeAnalise: String) : Boolean;
    function fSolicLiberacaoAnaliseAnalitica: Boolean;
    procedure pLiberarDireitoDeAcessoSelecionado(const blnHabilitarTimerSeLiberado: Boolean; const strOperador: String; const blnValidarDireitoAcesso: Boolean);
    procedure pAguardarTentativasExecutaAcao;
    function fValidouOperador(var strOperador : String): Boolean;
    procedure pMostrarAviso(const strAviso: String);
    procedure pLigaTimerLibera;
    procedure pCarregaValorFreteCotado(var objLogAvi: TLogAvi);
    procedure pCarregaValorDocumento(var objLogAvi: TLogAvi);
    function fGetSqlLiberacao: String;
    function fExisteOperadorComAcessoLibRemota(strDirAce: String): Boolean;
    procedure pSetarVisibilidadeQtdMsgNaoLida(const intQtdMsg : Integer);
    procedure pAtualizarBotaoMensagens(Sender : TObject);
    procedure pMandaMensagemLiberacaoValorMinimoPorItem;
    procedure pSalvaProdutosTravaPreco(strNumLib: String);
    procedure pMostraProdutosTravaPreco;
    procedure pAjustaProdutosTravaPreco;
  protected
    function TimerBotaoMsg : TNewTimer;
    procedure RemoveTimerBotaoMsg;
  public
    { Public declarations }
    fatVenda: TFatVenda;
    cdsXmlF4: TUniClientDataSet;
    blnSenlib: Boolean;
  end;

var
  frmFatLiberacaoBloqueios: TfrmFatLiberacaoBloqueios;

implementation

uses untMsgInterna, untLogVar, untConstantes, untMsgLiberacao, untLiberacao,
     untMemo, untFatMostraMargemNovo, untTipoFreteAtc, untFuncoesImagem,
     untImagens, untCadMsg, untCadMsgEnv, untFatTravaProdPreco;

{$R *.dfm}

{ TfrmFatLiberacaoBloqueios }

procedure TfrmFatLiberacaoBloqueios.btnAnlAnaliticaClick(Sender: TObject);
begin
  inherited;
  If Not btnAnlAnalitica.Visible Then
    Exit;

  If Not fSolicLiberacaoAnaliseAnalitica Then
    Exit;

  pMostrarAviso(fLimpaTagMsgOculta(cdsConsultaINFLIB.AsString, omlMsgParaQuemReceb));
end;

procedure TfrmFatLiberacaoBloqueios.btnEnvMensagemClick(Sender: TObject);
var
  frmCadMsgEnv: TfrmCadMsgEnv;
begin
  inherited;

  pCriarFormularios(TfrmCadMsgEnv, frmCadMsgEnv);
  try
    frmCadMsgEnv.ShowModal;
  finally
    pFreeAndNil(frmCadMsgEnv);
  end;
end;

procedure TfrmFatLiberacaoBloqueios.btnImgClienteClick(Sender: TObject);
  var
    frmImagem: TfrmImagens;

begin
  pCriarFormularios(TfrmImagens, frmImagem);

  Try
    frmImagem.pAbrirImagens(tiCliente, fRetornaClienteDaLiberacao(cdsConsultaNUMLIB.AsString), True);
  Finally
    pFreeAndNil(frmImagem);
  End;
end;

procedure TfrmFatLiberacaoBloqueios.btnLiberarTodasClick(Sender: TObject);
  Var
    intRecNo : Integer;
    blnLiberouAoMenosUmaTrava : Boolean;
    strOperador : String;
    strDireitosNegados : String;
begin
  If (Not btnLiberarTodas.Visible) Then
    Exit;

  pAguardarTentativasExecutaAcao;

  If (blnExecutandoAcao) Then
  Begin
    fMensagem('ATENÇÃO!', 'Uma tentativa de liberação já está em andamento, aguarde um momento e tente novamente!', ['&OK']);
    Exit;
  End;

  If (Not fValidouOperador(strOperador)) Then
    Exit;

  intRecNo := cdsConsulta.RecNo;
  blnExecutandoAcao := True;
  blnLiberouAoMenosUmaTrava := False;
  Try
    strDireitosNegados := EmptyStr;
    cdsConsulta.DisableControls;

    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      If (cdsConsultaSTATUS.AsString = 'B') Or
         (cdsConsultaSTATUS.AsString = 'N') Then
      Begin
        If (fVerificaAcessoSistema(cdsConsultaDIRACE.AsString, strOperador)) Then
        Begin
          pLiberarDireitoDeAcessoSelecionado(False, strOperador, False);
          If (cdsConsultaSTATUS.AsString = 'L') Then
            blnLiberouAoMenosUmaTrava := True;
        End
        Else
          strDireitosNegados := strDireitosNegados + '[' + cdsConsultaDIRACE.AsString + '] - ' + cdsConsultaMOTIVO.AsString + sLineBreak;
      End;
      cdsConsulta.Next;
    End;
  Finally
    If intRecNo > 0 Then
      cdsConsulta.RecNo := intRecNo;
    cdsConsulta.EnableControls;
    If (blnLiberouAoMenosUmaTrava) Then
      pLigaTimerLibera;
    blnExecutandoAcao := False;
  End;

  If (Not fEmptyStr(strDireitosNegados)) Then
    pMostrarAviso('Operador sem permissão para liberar os direitos de acesso:' + sLineBreak + sLineBreak + strDireitosNegados);
end;

procedure TfrmFatLiberacaoBloqueios.btnMensagensClick(Sender: TObject);
var
  frmCadMsg: TfrmCadMsg;
begin
  inherited;

  pCriarFormularios(TfrmCadMsg, frmCadMsg);
  try
    frmCadMsg.ShowModal;
  finally
    pFreeAndNil(frmCadMsg);
  end;
end;

procedure TfrmFatLiberacaoBloqueios.btnOkClick(Sender: TObject);
  Var
    blnTodasRespondidas: Boolean;
begin
  inherited;
  If fLiberacaoCompleta(blnTodasRespondidas) Then
  Begin
    pAvisosLimpaLogAvi;
    Close;
    ModalResult := mrOk;
  End
  Else If (Not blnTodasRespondidas) Then
    pMensagemOk('Não é possível confirmar pois ainda ' +
                'existem solicitações não liberadas!')
  Else
    pMensagemOk('Não é possível confirmar pois nem todas as solicitações ' +
                'foram liberadas!');
end;

procedure TfrmFatLiberacaoBloqueios.btnProdPreMinClick(Sender: TObject);
begin
  inherited;

  if not btnProdPreMin.Visible then
    Exit;

  pMostraProdutosTravaPreco;
end;

procedure TfrmFatLiberacaoBloqueios.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  intREC_NO := DataSet.RecNo;

  If Not cdsConsulta.IsEmpty Then
  Begin
    mmoInfBlo.Texto := fTagMsgOcultaToMsgCoringa(cdsConsultaINFBLO.AsString);
    mmoInfBlo.Texto := fLimpaTagMsgOculta(mmoInfBlo.Texto, omlMsgParaQuemReceb);

    If Not cdsConsulta.ControlsDisabled Then
      btnAnlAnalitica.Visible := (Not fEmptyStr(cdsConsultaINFLIB.AsString)) And
                                 (fLimpaTagMsgOculta(cdsConsultaINFLIB.AsString) <> fLimpaTagMsgOculta(cdsConsultaINFBLO.AsString));
  End;
end;

function TfrmFatLiberacaoBloqueios.fEnviarParaLiberacaoPorEscolhaOperador: Boolean;
begin
  Result := (fatVenda.blnUsaLiberacaoPedidosConformeEscolhaDoOperador) And
            (fatVenda.blnOperadorEscolheuEnviarPedidoParaLiberacao) And
            (fatVenda.strEnvLib = 'S');
end;

function TfrmFatLiberacaoBloqueios.fExisteOperadorComAcessoLibRemota(strDirAce: String): Boolean;
  Var
    qryCadOpe: TUniQuery;
begin
  qryCadOpe := fCriaQuery;
  Try
    qryCadOpe.SQL.Add( fGetSqlLiberacao );
    qryCadOpe.SQL.Add('AND OPE_CODOPE NOT IN ("997", "998", "999")');
    qryCadOpe.SQL.Add('AND EXISTS(');
    qryCadOpe.SQL.Add('  SELECT 1 FROM DIROPE D');
    qryCadOpe.SQL.Add('  WHERE D.OPE_CODOPE = CADOPE.OPE_CODOPE');
    qryCadOpe.SQL.Add('  AND D.DIR_NOMFRM = :DIRACE');
    qryCadOpe.SQL.Add('  UNION ALL');
    qryCadOpe.SQL.Add('  SELECT 1 FROM DIRGPO D');
    qryCadOpe.SQL.Add('  JOIN OPEGPO O ON O.GPO_CODGPO = D.GPO_CODGPO');
    qryCadOpe.SQL.Add('  WHERE O.OPE_CODOPE = CADOPE.OPE_CODOPE');
    qryCadOpe.SQL.Add('  AND D.DIR_NOMFRM = :DIRACE');
    qryCadOpe.SQL.Add(')');
    qryCadOpe.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryCadOpe.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadOpe.ParamByName('DIRACE').AsString := strDirAce;
    qryCadOpe.Open;

    Result := Not qryCadOpe.IsEmpty;
  Finally
    FreeAndNil(qryCadOpe);
  End;
end;

function TfrmFatLiberacaoBloqueios.fGetSqlLiberacao: String;
begin
  Result := '';
  Result := Result + ' SELECT OPE_CODOPE ';
  Result := Result + ' FROM CADOPE       ';
  Result := Result + ' WHERE OPE_CODOPE <> :CODOPE ';
  //Feito para operadores que podem acessar a empresa para fazer vendas mas não podem liberar travas daquela empresa
  Result := Result + ' AND LOCATE(:CODEMP, OPE_EMPLIB) > 0 ';
  Result := Result + ' AND OPE_MSGLIB  = "S" ';
  Result := Result + ' AND OPE_STATUS <> "I" ';
end;

function TfrmFatLiberacaoBloqueios.fItemJaLiberado: Boolean;
begin
  Result := (cdsConsultaAVISO_.AsString = 'S') Or (cdsConsultaLIBPED.AsString = 'S');
end;

procedure TfrmFatLiberacaoBloqueios.pMandaMensagemLiberacaoValorMinimoPorItem;
var
  intContador: Integer;
  strDirAce: String;
begin
  if not Assigned(cdsConsulta) then
    Exit;

  if not cdsConsulta.Active then
    Exit;

  if cdsConsulta.RecordCount <= 0 then
    Exit;

  if cdsConsulta.RecNo <= 0 then
    Exit;

  if not Assigned(arrLogAvi) then
    Exit;

  if Length(arrLogAvi) <= 0 then
    Exit;

  for intContador := 0 to Length(arrLogAvi) - 1 do
  begin
    strDirAce := Copy(arrLogAvi[intContador].strDirAce, 1, 5);
    if (arrLogAvi[intContador].strNumLib = cdsConsultaNUMLIB.AsString) and (Pos(strDirAce, 'PRMIN_VEMIN_') >0) then
    begin
      pSalvaProdutosTravaPreco(arrLogAvi[intContador].strNumLib);
      Exit;
    end;
  end;
end;

procedure TfrmFatLiberacaoBloqueios.pMostraProdutosTravaPreco;
const
  MENSAGEM = 'Não há retorno da solicitação.';
var
  frmFatTravaProdPreco: TfrmFatTravaProdPreco;
begin
  if not Assigned(cdsConsulta) then
  begin
    pMensagemOk(MENSAGEM);
    Exit;
  end;

  if not cdsConsulta.Active then
  begin
    pMensagemOk(MENSAGEM);
    Exit;
  end;

  if cdsConsulta.RecordCount <= 0 then
  begin
    pMensagemOk(MENSAGEM);
    Exit;
  end;

  if cdsConsulta.RecNo <= 0 then
  begin
    pMensagemOk(MENSAGEM);
    Exit;
  end;

  If fEmptyStr(cdsConsultaNUMLIB.AsString) Then
  begin
    pMensagemOk(MENSAGEM);
    Exit;
  end;

  if fCampoTabela('GER_NUMLIB','TPMGER',['GER_NUMLIB'],[cdsConsultaNUMLIB.AsString]) <> cdsConsultaNUMLIB.AsString then
  begin
    pMensagemOk(MENSAGEM);
    Exit;
  end;

  if fCampoTabela('GER_RESPON','TPMGER',['GER_NUMLIB'],[cdsConsultaNUMLIB.AsString]) <> 'S' then
  begin
    pMensagemOk(MENSAGEM);
    Exit;
  end;

  pCriarFormularios(TfrmFatTravaProdPreco, frmFatTravaProdPreco);

  try
    frmFatTravaProdPreco.NumLib := cdsConsultaNUMLIB.AsString;
    frmFatTravaProdPreco.ApenaVisualizacao := True;
    frmFatTravaProdPreco.ShowModal;
    pCloneDataSet(fatVenda.cdsTravaProdMin, frmFatTravaProdPreco.cdsProdutos);
    fatVenda.strNumLib := frmFatTravaProdPreco.NumLib;
  finally
    pFreeAndNil(frmFatTravaProdPreco);
  end;
end;

procedure TfrmFatLiberacaoBloqueios.pMostrarAviso(const strAviso: String);
  Var
    frmMemo : TfrmMemo;
begin
  pCriarFormularios(TfrmMemo, frmMemo);
  Try
    frmMemo.Height := 600;
    frmMemo.Width  := 1024;
    frmMemo.cxMemo.Lines.Text := strAviso;
    frmMemo.cxMemo.Style.Font.Style := [];
    frmMemo.cxMemo.Style.Font.Size  := 8;
    frmMemo.cxMemo.Properties.ScrollBars := ssBoth;
    frmMemo.cxMemo.Properties.WordWrap := False;
    frmMemo.ShowModal;
  Finally
    pFreeAndNil(frmMemo);
  End;
end;

procedure TfrmFatLiberacaoBloqueios.pLigaTimerLibera;
begin
  tmrLibera := TNewTimer.Get(Self.Name + '.tmrLibera');
  tmrLibera.Interval := 1500;
  tmrLibera.Enabled := True;
  tmrLibera.OnTimer := tmrLiberaTimer;
end;

procedure TfrmFatLiberacaoBloqueios.pAvisosLimpaLogAvi;
  Var
    SL: TStringList;
    intIdx: Integer;
begin
  If (fUsaLiberacaoFinanceiraOuComercial) Then
    Exit;

  SL := TStringList.Create;
  Try
    For intIdx := 0 To Length(arrLogAvi) -1 Do
      If (arrLogAvi[intIdx].blnAviso_) Then
         SL.Add(arrLogAvi[intIdx].strDirAce);

    If SL.Count > 0 Then
    Begin
      For intIdx := 0 To SL.Count -1 Do
        pRemoverTravaLogAvi(SL[intIdx], fatVenda.strNTrava);
    End;
  Finally
    FreeAndNil(SL);
  End;
end;

procedure TfrmFatLiberacaoBloqueios.dbgConsultaCellClick(Column: TColumn);
  Var
    strOperador: String;

  procedure pMensagemSolicitacao;
  begin
    If fItemJaLiberado Then
      Exit
    Else If (cdsConsultaSTATUS.AsString = 'N') Then
      pMensagemOk('Esta solicitação já foi negada!')
    Else If (cdsConsultaSTATUS.AsString = 'A') Then
      pMensagemOk('Solicitação já foi enviada, aguarde...')
    Else If (cdsConsultaSTATUS.AsString = 'L') Then
      pMensagemOk('Solicitação já foi liberada!')
    Else If (cdsConsultaSTATUS.AsString = 'B') Then
      pMensagemOk('Solicitação não foi enviada!');
  end;

begin
  inherited;

  pAguardarTentativasExecutaAcao;

  If (blnExecutandoAcao) Then
    Exit;

  blnExecutandoAcao := True;

  Try
    If InterlockedIncrement(intSemaforo) = 0 Then
    Begin
      Try
        If Column.FieldName = 'SOLICI' Then
        Begin
          If cdsConsultaTEMACE.AsString <> 'S' Then
          Begin
            pMensagemOk('Não existem operadores com este direito de acesso.');
            Exit;
          End;

          If (cdsConsultaSTATUS.AsString = 'B') Or
             (cdsConsultaSTATUS.AsString = 'N') Then
          Begin
            If (fMensagem('','Confirma solicitação ' +
                            'de liberação?', ['', '']) = 1) Then
            Begin
              If fCancelarSolicitacao And fChamaTelaGravando(fEnviaMsgLiberacao) Then
              Begin
                cdsConsulta.Edit;
                cdsConsultaOPELIB.AsString := '';
                cdsConsultaNOMOPE.AsString := '';
                cdsConsultaSTATUS.AsString := 'A';
                cdsConsultaMSGLIB.AsString := 'Aguardando retorno!';
                cdsConsulta.Post;
              End;
            End;
          End
          Else
            pMensagemSolicitacao;
        End

        Else If Column.FieldName = 'LIBERA' Then
        Begin

          If (cdsConsultaSTATUS.AsString = 'B') Or
             (cdsConsultaSTATUS.AsString = 'N') Then
          Begin
            If (fValidouOperador(strOperador)) Then
              pLiberarDireitoDeAcessoSelecionado(True, strOperador, True);
          End
          Else
            pMensagemSolicitacao;

        End

        Else If Column.FieldName = 'CANCEL' Then
        Begin
          If (cdsConsultaSTATUS.AsString = 'A') Then
          Begin
            If (fMensagem('', 'Confirma cancelamento da ' +
                              'solicitação?', ['','']) = 1) And fCancelarSolicitacao Then
            Begin
              cdsConsulta.Edit;
              cdsConsultaOPELIB.AsString := '';
              cdsConsultaNOMOPE.AsString := '';
              cdsConsultaSTATUS.AsString := 'B';
              cdsConsultaMSGLIB.AsString := 'Bloqueada!';
              cdsConsulta.Post;
            End;

          End
          Else
            pMensagemSolicitacao;
        End;

      Finally
        InterlockedDecrement(intSemaforo);
      End;
    End
    Else
      InterlockedDecrement(intSemaforo);
  Finally
    blnExecutandoAcao := False;
  End;
end;

procedure TfrmFatLiberacaoBloqueios.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);

  function fInsideRect: Boolean;
  begin
    Result := (( rect.Left   ) <= X_POS_GRID ) And (( rect.Right  ) >= X_POS_GRID ) And
              (( rect.Top    ) <= Y_POS_GRID ) And (( rect.Bottom ) >= Y_POS_GRID ) ;
  End;

  procedure pDesenhaTexto();
    Var
      ARect: TRect;
      LLeft: Integer;

      strTexto: String;
      clColor_: TColor;
  begin
    If (cdsConsultaAVISO_.AsString = 'S') Then
    Begin
      strTexto := 'AVISO';
      clColor_ := clSkyBlue;
    End
    Else
    Begin
      strTexto := 'LIB.PED.';
      clColor_ := $00BBBBFF;
    End;

    ARect := Rect;
    LLeft := ARect.Left + ((ARect.Right - ARect.Left) div 2) - (Canvas.TextWidth(strTexto) div 2);
    dbgConsulta.Canvas.Brush.Color := clColor_;
    dbgConsulta.Canvas.FillRect(ARect);
    dbgConsulta.Canvas.TextOut(LLeft, ARect.Top + 2, strTexto);
  end;
  
  procedure pDesenhaImagem(bmp: TBitmap; blnFocar: Boolean = False);
  begin
    With dbgConsulta.Canvas, Rect Do
    Begin
      FillRect(Rect);

      If fInsideRect And blnFocar Then
      Begin
        Brush.Color := cl3DLight;
        FillRect(Rect);
      End;

      Draw(Left + (Column.Width div 2 - bmp.Width div 2), Top + 1, bmp);

      If fInsideRect And blnFocar Then
      Begin
        Pen.Color := clBlack;
        Brush.Style := bsClear;
        Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
      End;

    End;
  end;

  procedure pPintarZebra;
  begin
    If (cdsConsulta.Active) And
       (cdsConsulta.RecordCount > 0) Then
    Begin
      If (cdsConsulta.RecNo Mod 2) = 0 Then
        dbgConsulta.Canvas.Brush.Color := intCOR_ZEBRA
      Else
        dbgConsulta.Canvas.Brush.Color := clWhite;

      dbgConsulta.Canvas.Font.Color := clBlack;

      If cdsConsulta.RecNo = intREC_NO Then
        dbgConsulta.Canvas.Font.Style := [fsBold];      

      dbgConsulta.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    End;
  end;

begin
  inherited;

  pPintarZebra;

  If Column.FieldName = 'SOLICI' Then
  begin
    If fItemJaLiberado Then
      pDesenhaTexto()
    Else
    Begin
      If cdsConsultaTEMACE.AsString = 'S' Then
        pDesenhaImagem(imgSolicitar.Picture.Bitmap, True)
      Else
        pDesenhaImagem(imgOpeSemAce.Picture.Bitmap, True);
    End
  End

  Else If Column.FieldName = 'CANCEL' Then
  begin
    If fItemJaLiberado Then
      pDesenhaTexto()
    Else
      pDesenhaImagem(imgCancelar.Picture.Bitmap, True);
  End

  Else If Column.FieldName = 'LIBERA' Then
  begin
    If fItemJaLiberado Then
      pDesenhaTexto()
    Else
      pDesenhaImagem(imgLiberar.Picture.Bitmap, True);
  End

  Else If Column.FieldName = 'STATUS' Then
  begin
    If Column.Field.AsString = 'L' Then
      pDesenhaImagem(imgLiberado.Picture.Bitmap)
    Else If Column.Field.AsString = 'N' Then
      pDesenhaImagem(imgNegada.Picture.Bitmap)
    Else If Column.Field.AsString = 'A' Then
      pDesenhaImagem(imgAguardando.Picture.Bitmap)
    Else If Column.Field.AsString = 'B' Then
      pDesenhaImagem(imgBloqueado.Picture.Bitmap)
    Else If Column.Field.AsString = 'S' Then
      pDesenhaImagem(imgAnalise.Picture.Bitmap);
  End;

  With dbgConsulta, Canvas Do
  Begin
    Pen.Color := clBlack;
    Brush.Style := bsClear;
    Rectangle(0, 0, Width, Height);
  End;

end;

procedure TfrmFatLiberacaoBloqueios.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_delete Then
  key := 0;
end;

procedure TfrmFatLiberacaoBloqueios.dbgConsultaMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  X_POS_GRID := X;
  Y_POS_GRID := Y;
  dbgConsulta.Refresh;
end;

procedure TfrmFatLiberacaoBloqueios.FormClose(Sender: TObject;
  var Action: TCloseAction);
  Var
    blnTodasRespondidas: Boolean;
begin
  inherited;
  pAtualizarOpeLibArrLogAvi;
  If Not fLiberacaoCompleta(blnTodasRespondidas) Then
  Begin
    pCancelarTodasSolicitacoes;
    pApagaLogVarNaoUtilizado;
  End;
  if assigned(tmrLibera) then
  begin
    tmrLibera.Enabled := False;
    TNewTimer.Del(Self.Name + '.tmrLibera');
  end;
end;

procedure TfrmFatLiberacaoBloqueios.FormCreate(Sender: TObject);
begin
  inherited;
  blnExecutandoAcao := False;

  cdsConsulta.CreateDataSet;

  blnTemSelecao := False;
  blnSempreRelerBanco := False;
  blnSelecionaComEnter := False;
  blnSelecionaComEspaco := False;
  blnTemPesquisa := False;
  blnSenLib      := False;

  intSemaforo := -1;

  intCOR_ZEBRA := StrToIntDef(fCfgSis('CORZEB'), clWhite);
  blnUsaDig := (fCfgSis('USADIG', varBoolean));
end;

procedure TfrmFatLiberacaoBloqueios.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then btnOk.Click
  Else If Key = VK_F1  Then dbgConsultaCellClick(fFindColumnByName(dbgConsulta, 'SOLICI'))
  Else If Key = VK_F2  Then dbgConsultaCellClick(fFindColumnByName(dbgConsulta, 'CANCEL'))
  Else If Key = VK_F3  Then dbgConsultaCellClick(fFindColumnByName(dbgConsulta, 'LIBERA'))
  Else If Key = VK_F9  Then btnLiberarTodas.Click
  Else If Key = VK_F12 Then btnAnlAnalitica.Click
  Else If Key = VK_F5  Then
  Begin
    If Shift = [ssAlt] Then
    Begin
      If (btnImgCliente.Visible) Then
        btnImgCliente.Click;
      key := 0;
    End;
  End
  Else If Key = VK_F6 Then
  Begin
    If Shift = [ssAlt] Then
      btnMensagens.Click;
  End
  Else If Key = VK_F8 Then
  Begin
    If Shift = [ssAlt] Then
      btnProdPreMin.Click;
  End
  Else If Key = VK_F7 Then
  Begin
    If Shift = [ssAlt] Then
      btnEnvMensagem.Click;
  End;
end;

procedure TfrmFatLiberacaoBloqueios.FormShow(Sender: TObject);
begin
  inherited;
  btnImgCliente.Visible := (fCfgSis('TRAREM', varInteger) = 2) And (fCfgSis('HABREM', varBoolean));
  btnAnlAnalitica.Visible := False;
  btnProdPreMin.Visible := fCfgSis('ALTVMT', varBoolean);
  pCarregaBloqueios;
  btnLiberarTodas.Visible := (cdsConsulta.RecordCount > 1);
  TimerBotaoMsg.Enabled := True;
  pAtualizarBotaoMensagens(Self);
  pSetFocus(dbgConsulta);
end;

procedure TfrmFatLiberacaoBloqueios.pCarregaBloqueios;
  var
    intBloqueio: Integer;
    cdsXml1: TUniClientDataSet;
    cdsXml2: TUniClientDataSet;
    cdsXml3: TUniClientDataSet;
    cdsXmlF4bkp: TUniClientDataSet;
    blnLibAutomatica: Boolean;
    DataF4: OleVariant;
    objCdsXmlF4: TUniClientDataSet;
    blnValorMinimoF4: Boolean;
    horaLogLib,
    horaLogEnv,
    horaLogCad: TDateTime;
    strCodigoLiberacao: String;


  function fGetMotivo: String;
  begin
    Result := LeftStr(arrLogAvi[intBloqueio].strInfBlo,
      Pos(#13#10, arrLogAvi[intBloqueio].strInfBlo) -1);
  end;

  function fGetClientDataSetMsgLib(const strMsgLib: String): TUniClientDataSet;
  begin
    Result := TUniClientDataSet.Create(nil);
    Result.FieldDefs.Add(untLogVar.strCAMPOLIB, ftMemo);
    Result.CreateDataSet;

    Result.Append;
    Result.FieldByName(untLogVar.strCAMPOLIB).AsString := strMsgLib;
    Result.Post;
  end;

begin
  blnPodeIncluir := True;
  blnLibAutomatica := False;
  blnValorMinimoF4 := False;

  For intBloqueio := 0 To Length(arrLogAvi) -1 Do
  Begin
    {****************************************************************}
    {* GERA NOVAMENTE O NUMERO DE LIBERACAO, POIS EM ALGUNS CLIENTES*}
    {* OCORREU DE DOIS OPERADORES USAREM O MESMO NUMERO...          *}
    {************************************************************JC**}
    arrLogAvi[intBloqueio].strNumLib := fGeraNumLiberacao(arrLogAvi[intBloqueio].strDirAce);

    If Pos(STRING_FORMAS_PAGTO_NEGOCIADAS, arrLogAvi[intBloqueio].strInfBlo) > 0 Then
      arrLogAvi[intBloqueio].strInfBlo := fatVenda.fDefinirMsgFormasPagamentoNegociada(arrLogAvi[intBloqueio].strInfBlo);

    If Pos(STRING_FORMAS_PAGTO_NEGOCIADAS, arrLogAvi[intBloqueio].strInfLib) > 0 Then
      arrLogAvi[intBloqueio].strInfLib := fatVenda.fDefinirMsgFormasPagamentoNegociada(arrLogAvi[intBloqueio].strInfLib);

    If Pos(STRING_FORMAS_PAGTO_NEGOCIADAS, arrLogAvi[intBloqueio].strMsgJso) > 0 Then
      arrLogAvi[intBloqueio].strMsgJso := fatVenda.fDefinirMsgFormasPagamentoNegociada(arrLogAvi[intBloqueio].strMsgJso, true);

    arrLogAvi[intBloqueio].strInfLib := fLimpaTagMsgOculta(arrLogAvi[intBloqueio].strInfLib);

    pCarregaValorFrete(arrLogAvi[intBloqueio]);
    pCarregaValorFreteCotado(arrLogAvi[intBloqueio]);
    pCarregaValorDocumento(arrLogAvi[intBloqueio]);
    pCarregaProfissionaisBloqueios(arrLogAvi[intBloqueio]);
    pCarregaTransportadoraValorMinimo(arrLogAvi[intBloqueio]);

    cdsConsulta.Append;
    cdsConsultaDIRACE.AsString := arrLogAvi[intBloqueio].strDirAce;
    cdsConsultaMSGSEN.AsString := arrLogAvi[intBloqueio].strMsgSen;
    cdsConsultaNUMLIB.AsString := arrLogAvi[intBloqueio].strNumLib;
    cdsConsultaMOTIVO.AsString := fGetMotivo;
    cdsConsultaINFBLO.AsString := StringReplace(arrLogAvi[intBloqueio].strInfBlo, STRING_PROFISSIONAIS_LIBERACAO, '', [rfReplaceAll]);
    cdsConsultaINFLIB.AsString := arrLogAvi[intBloqueio].strInfLib;
    cdsConsultaCODOPE.AsString := arrLogAvi[intBloqueio].strCodOpe;
    cdsConsultaCODDIG.AsString := arrLogAvi[intBloqueio].strCodDig;
    cdsConsultaMENOBS.AsString := arrLogAvi[intBloqueio].strMenObs;
    cdsConsultaCODITE.AsString := arrLogAvi[intBloqueio].strCodIte;
    cdsConsultaAUTINC.AsFloat  := arrLogAvi[intBloqueio].intAutInc;

    If (arrLogAvi[intBloqueio].blnAviso_) Then
    Begin
      cdsConsultaAVISO_.AsString := 'S';
      cdsConsultaSTATUS.AsString := 'L';
      cdsConsultaMSGLIB.AsString := 'Mensagem de aviso!';
    End
    Else If (fEnviarParaLiberacaoPorEscolhaOperador) Then
    Begin
      cdsConsultaLIBPED.AsString := 'S';
      cdsConsultaSTATUS.AsString := 'L';
      cdsConsultaMSGLIB.AsString := 'Enviada para liberação de pedidos!';
    End
    Else
    Begin
      cdsConsultaSTATUS.AsString := 'B';
      cdsConsultaMSGLIB.AsString := 'Bloqueada!';
    End;

    cdsConsultaTEMACE.AsString := IIF(fExisteOperadorComAcessoLibRemota(arrLogAvi[intBloqueio].strDirAce), 'S', 'N');
    cdsConsultaMSGJSO.AsString := arrLogAvi[intBloqueio].strMsgJso;

    If (Pos(arrLogAvi[intBloqueio].strDirAce, 'VEMIN_VEMIN2_VEMIN3_VEMIN4_VEMIN5_VEMIN6_PRMIN_PRMIN2_PRMIN3_PRMIN4_PRMIN5_PRMIN6_') > 0) Then
      cdsXml1 := fatVenda.cdsTravaMinima
    Else
      cdsXml1 := nil;

    if (Pos('Valor da Venda Menor que o Valor Mínimo', fGetMotivo) > 0) and (cdsXmlF4 <> Nil) then
    begin
      cdsXmlF4bkp := TUniClientDataSet.Create(nil);
      cdsXmlF4bkp.Data := cdsXmlF4.Data;
      objCdsXmlF4 := TUniClientDataSet.Create(nil);
      DataF4 := fatVenda.fCalculaMargemLucro(False, -1, Nil, True);
      objCdsXmlF4.Data := DataF4;
      TfrmFatMostraMargemNovo.pCalcularTotaisPublico(objCdsXmlF4, fatVenda, fatVenda.fltDesEsp);
      cdsXmlF4 := objCdsXmlF4;
      blnValorMinimoF4 := True;
    end;

    If (Pos(arrLogAvi[intBloqueio].strDirAce, 'VECUS_VEMIN_VEMIN2_VEMIN3_VEMIN4_VEMIN5_VEMIN6_PRMIN_PRMIN2_PRMIN3_PRMIN4_PRMIN5_PRMIN6_EMIFAT_') > 0) Then
      cdsXml2 := cdsXmlF4
    Else
      cdsXml2 := nil;

    if not fEmptyStr(arrLogAvi[intBloqueio].strInfLib) then
      cdsXml3 := fGetClientDataSetMsgLib(arrLogAvi[intBloqueio].strInfLib)
    else
      cdsXml3 := nil;

    strCodigoLiberacaoLogVar := Trim(cdsConsultaDIRACE.AsString) + fatVenda.FSequencialUnicoDtaHrLogVar;

    If (Not arrLogAvi[intBloqueio].blnAviso_) And (Not fEnviarParaLiberacaoPorEscolhaOperador) Then
    Begin
      If Not fGravaLogVar(arrLogAvi[intBloqueio].strNumLib, arrLogAvi[intBloqueio].strInfLib,
                          arrLogAvi[intBloqueio].strCodOpe, arrLogAvi[intBloqueio].strCodDig,
                          fatVenda.strCodCli, strCodigoLiberacaoLogVar, cdsXml1, cdsXml2, cdsXml3) Then
      Begin
        blnFecharFormPai := True;
        Exit;
      End;
    End;

    if blnValorMinimoF4 then
    begin
      FreeAndNil(objCdsXmlF4);
      cdsXmlF4 := cdsXmlF4bkp;
      FreeAndNil(cdsXmlF4bkp);
    end;

    If blnSenLib Or fVerificaAcessoMaster(cdsConsultaDIRACE.AsString, strLoginUsuarioLogado) Then
    Begin
      If Not fEmptyStr(strLoginUsuarioLogado) Then
      Begin
        If fVerificaAcessoSistema(cdsConsultaDIRACE.AsString, strLoginUsuarioLogado) Then
        Begin
          if not fVerificaDataHoraLiberacao(cdsConsultaNUMLIB.AsString, horaLogLib) then
            horaLogLib := fTime();
          if not fVerificaDataHoraEnvio(cdsConsultaNUMLIB.AsString, horaLogEnv) then
            horaLogEnv := fTime();
          if not fVerificaDataHoraCadastro(cdsConsultaNUMLIB.AsString, horaLogCad) then
            horaLogCad := fTime();

          strCodigoLiberacao := fCodigoLiberacaoLogLib(cdsConsultaDIRACE.AsString);
          pGeraMatrizLiberacao(strLoginUsuarioLogado,
                               cdsConsultaCODOPE.AsString,
                               fMesclaMensagemMaisJustificativa(cdsConsultaMENOBS.AsString, strJustTemp),
                               cdsConsultaDIRACE.AsString,
                               strCodigoLiberacao,
                               cdsConsultaCODITE.AsString,
                               cdsConsultaAUTINC.AsInteger,
                               cdsConsultaNUMLIB.AsString,
                               fMesclaMensagemMaisJustificativa(cdsConsultaINFLIB.AsString, strJustTemp),
                               False,
                               fRetornaXmlClientTravasMinimas(cdsConsultaNUMLIB.AsString, 'AUX_INFOF4'),
                               horaLogLib,
                               horaLogCad,
                               horaLogEnv,
                               cdsConsultaMSGSEN.AsString,
                               cdsConsultaMOTIVO.AsString);

          pUpdateLogVar(cdsConsultaNUMLIB.AsString, strLoginUsuarioLogado, True, '', horaLogEnv, horaLogLib);

          cdsConsultaOPELIB.AsString := strLoginUsuarioLogado;
          cdsConsultaNOMOPE.AsString := strLoginUsuarioLogado + '-' + fRetNomeOperador(strLoginUsuarioLogado);
          cdsConsultaSTATUS.AsString := 'L';
          cdsConsultaMSGLIB.AsString := 'Liberada manualmente!';
          cdsConsulta.Post;
          blnLibAutomatica := True;
          Continue;
        End;
      End;
    End;

    cdsConsulta.Post;
  End;

  If blnLibAutomatica Then
    pLigaTimerLibera;

  cdsConsulta.First;

  blnPodeIncluir := False;

  if Assigned(cdsXml3) then
    FreeAndNil(cdsXml3);
end;

procedure TfrmFatLiberacaoBloqueios.pCarregaValorFrete(var objLogAvi: TLogAvi);
var
  strValorFrete: string;
  blnInfBlo: Boolean;
  blnInfLib: Boolean;
  blnMsgJso: Boolean;
begin
  blnInfBlo := (Pos(STRING_VALOR_FRETE, objLogAvi.strInfBlo) > 0);
  blnInfLib := (Pos(STRING_VALOR_FRETE, objLogAvi.strInfLib) > 0);
  blnMsgJso := (Pos(STRING_VALOR_FRETE, objLogAvi.strMsgJso) > 0);

  if (not blnInfBlo) and (not blnInfLib) and (not blnMsgJso) then
    Exit;

  strValorFrete := FormatFloat(fMskDigitos(2), fatVenda.fltValFre);

  if blnInfBlo then
    objLogAvi.strInfBlo := AnsiReplaceStr(objLogAvi.strInfBlo, STRING_VALOR_FRETE, strValorFrete)
  else
    objLogAvi.strInfBlo := AnsiReplaceStr(objLogAvi.strInfBlo, STRING_VALOR_FRETE, '');

  if blnInfLib then
    objLogAvi.strInfLib := AnsiReplaceStr(objLogAvi.strInfLib, STRING_VALOR_FRETE, strValorFrete)
  else
    objLogAvi.strInfLib := AnsiReplaceStr(objLogAvi.strInfLib, STRING_VALOR_FRETE, '');

  if blnInfBlo then
    objLogAvi.strMsgJso := AnsiReplaceStr(objLogAvi.strMsgJso, STRING_VALOR_FRETE, strValorFrete)
  else
    objLogAvi.strMsgJso := AnsiReplaceStr(objLogAvi.strMsgJso, STRING_VALOR_FRETE, '');
end;

procedure TfrmFatLiberacaoBloqueios.pCarregaValorFreteCotado(var objLogAvi: TLogAvi);
var
  strValorFrete: string;
  blnInfBlo: Boolean;
  blnInfLib: Boolean;
  blnMsgJso: Boolean;
begin
  blnInfBlo := (Pos(STRING_VALOR_FRETE_COTADO, objLogAvi.strInfBlo) > 0);
  blnInfLib := (Pos(STRING_VALOR_FRETE_COTADO, objLogAvi.strInfLib) > 0);
  blnMsgJso := (Pos(STRING_VALOR_FRETE_COTADO, objLogAvi.strMsgJso) > 0);

  if (not blnInfBlo) and (not blnInfLib) and (not blnMsgJso) then
    Exit;

  strValorFrete := FormatFloat(fMskDigitos(2), fatVenda.fltFreCot);

  if blnInfBlo then
    objLogAvi.strInfBlo := AnsiReplaceStr(objLogAvi.strInfBlo, STRING_VALOR_FRETE_COTADO, strValorFrete)
  else
    objLogAvi.strInfBlo := AnsiReplaceStr(objLogAvi.strInfBlo, STRING_VALOR_FRETE_COTADO, '');

  if blnInfLib then
    objLogAvi.strInfLib := AnsiReplaceStr(objLogAvi.strInfLib, STRING_VALOR_FRETE_COTADO, strValorFrete)
  else
    objLogAvi.strInfLib := AnsiReplaceStr(objLogAvi.strInfLib, STRING_VALOR_FRETE_COTADO, '');

  if blnInfBlo then
    objLogAvi.strMsgJso := AnsiReplaceStr(objLogAvi.strMsgJso, STRING_VALOR_FRETE_COTADO, strValorFrete)
  else
    objLogAvi.strMsgJso := AnsiReplaceStr(objLogAvi.strMsgJso, STRING_VALOR_FRETE_COTADO, '');
end;

function TfrmFatLiberacaoBloqueios.fValidouOperador(var strOperador : String): Boolean;
  Var
    strSenha : String;
begin
  strOperador := EmptyStr;
  Result := False;

  If (Not ffrmSenha(strSenha)) Then
    Exit;

  If fEmptyStr(strSenha) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe a senha para liberação!', ['&OK']);
    Exit;
  End;

  strOperador := fRetCodVendedor(strSenha);

  If fEmptyStr(strOperador) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse operador não tem direitos para essa liberação!', ['&OK']);
    Exit;
  End;

  If (Not fEhAdministrador(strOperador)) And (Pos(VS_strCodEmp, fRetEmpAcessoUsuario(strOperador)) <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', '-------------------------------------------------------------------------------------------------'+#13+
                          'Este operador não tem acesso à esta empresa. '+#13+
                          'Esta liberação não será confirmada. '+#13+
                          'Para definição do acesso às empresas, acessar CAD.OPERADORES > ACESSO EMPRESA > EMPRESAS - ACESSO'+#13+
                          '-------------------------------------------------------------------------------------------------', ['&OK']);
    Exit;
  End;

  If (fRetornaStatusCadastro(strOperador, 'OPE', 'CADOPE', 'OPE_CODOPE') = 'I') Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse operador está inativo!', ['&OK']);
    Exit;
  End;

  Result := True;
end;

procedure TfrmFatLiberacaoBloqueios.pLiberarDireitoDeAcessoSelecionado(const blnHabilitarTimerSeLiberado: Boolean; const strOperador: String; const blnValidarDireitoAcesso: Boolean);
  Var
    strCodigoLiberacao : String;
    horaLogLib : TDateTime;
    horaLogEnv : TDateTime;
    horaLogCad : TDateTime;
begin
  If fEmptyStr(strOperador) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse operador não tem direitos para essa liberação!', ['&OK']);
    Exit;
  End;

  If (blnValidarDireitoAcesso) Then
  Begin
    If (Not fVerificaAcessoSistema(cdsConsultaDIRACE.AsString, strOperador)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse operador não tem direitos para essa liberação!', ['&OK']);
      Exit;
    End;
  End;

  if not fVerificaDataHoraLiberacao(cdsConsultaNUMLIB.AsString, horaLogLib) then
    horaLogLib := fTime();
  if not fVerificaDataHoraEnvio(cdsConsultaNUMLIB.AsString, horaLogEnv) then
    horaLogEnv := fTime();
  if not fVerificaDataHoraCadastro(cdsConsultaNUMLIB.AsString, horaLogCad) then
    horaLogCad := fTime();

  strCodigoLiberacao := fCodigoLiberacaoLogLib(cdsConsultaDIRACE.AsString);
  pGeraMatrizLiberacao(strOperador,
                       cdsConsultaCODOPE.AsString,
                       fMesclaMensagemMaisJustificativa(cdsConsultaMENOBS.AsString, strJustTemp),
                       cdsConsultaDIRACE.AsString,
                       strCodigoLiberacao,
                       cdsConsultaCODITE.AsString,
                       cdsConsultaAUTINC.AsInteger,
                       cdsConsultaNUMLIB.AsString,
                       fMesclaMensagemMaisJustificativa(cdsConsultaINFLIB.AsString, strJustTemp),
                       False,
                       fRetornaXmlClientTravasMinimas(cdsConsultaNUMLIB.AsString, 'AUX_INFOF4'),
                       horaLogLib,
                       horaLogCad,
                       horaLogEnv,
                       cdsConsultaMSGSEN.AsString,
                       cdsConsultaMOTIVO.AsString);

  pUpdateLogVar(cdsConsultaNUMLIB.AsString, strOperador, True, '', horaLogEnv, horaLogLib);

  cdsConsulta.Edit;
  cdsConsultaOPELIB.AsString := strOperador;
  cdsConsultaNOMOPE.AsString := strOperador + '-' + fRetNomeOperador(strOperador);
  cdsConsultaSTATUS.AsString := 'L';
  cdsConsultaMSGLIB.AsString := 'Liberada manualmente!';
  cdsConsulta.Post;

  If (blnHabilitarTimerSeLiberado) Then
    pLigaTimerLibera;
end;

procedure TfrmFatLiberacaoBloqueios.pCarregaProfissionaisBloqueios(var objLogAvi: TLogAvi);
var
  strMsgProfissional: string;
  blnInfBlo: Boolean;
  blnInfLib: Boolean;
  blnMsgJso: Boolean;
begin
  strMsgProfissional := '';

  blnInfBlo := (Pos(STRING_PROFISSIONAIS_LIBERACAO, objLogAvi.strInfBlo) > 0) And (Not fIsentarDigitacaoDeProfissionalQuandoPedidoOrcamento(fatVenda.strOpcDoc, fatVenda.strEspDoc));
  blnInfLib := (Pos(STRING_PROFISSIONAIS_LIBERACAO, objLogAvi.strInfLib) > 0) And (Not fIsentarDigitacaoDeProfissionalQuandoPedidoOrcamento(fatVenda.strOpcDoc, fatVenda.strEspDoc));
  blnMsgJso := (Pos(STRING_PROFISSIONAIS_LIBERACAO, objLogAvi.strMsgJso) > 0) And (Not fIsentarDigitacaoDeProfissionalQuandoPedidoOrcamento(fatVenda.strOpcDoc, fatVenda.strEspDoc));

  if (not blnInfBlo) and (not blnInfLib) and (not blnMsgJso) then
    Exit;

  if (fCfgSis('NROPRO') = '2') and (not fEmptyStr(fatVenda.strCodDiv)) then
    strMsgProfissional := STRING_ENTER + StringOfChar('-', 90) +
                          STRING_ENTER + 'PROFISSIONAL: ' + fatVenda.strCodDiv + '-' +
                          fRetNomProfissional(fatVenda.strCodDiv) + '-' + fRetNomAtividadeProfissional(fatVenda.strCodDiv) +
                          STRING_ENTER + StringOfChar('-', 90) + STRING_ENTER;

  if (fCfgSis('NROPRO') = '3') and Assigned(fatVenda.cdsProfiss) and
     (fatVenda.cdsProfiss.Active) and (not fatVenda.cdsProfiss.IsEmpty) then
  begin
    strMsgProfissional := STRING_ENTER + StringOfChar('-', 90) +
                          STRING_ENTER + 'PROFISSIONAIS: ';
    fatVenda.cdsProfiss.First;
    while not fatVenda.cdsProfiss.Eof do
    begin
      strMsgProfissional := strMsgProfissional + STRING_ENTER +
                            fatVenda.cdsProfiss.FieldByName('DIV_CODDIV').AsString + '-' +
                            fRetNomProfissional(fatVenda.cdsProfiss.FieldByName('DIV_CODDIV').AsString) + '-' +
                            fRetNomAtividadeProfissional(fatVenda.cdsProfiss.FieldByName('DIV_CODDIV').AsString);
      FatVenda.cdsProfiss.Next;
    end;
    strMsgProfissional := strMsgProfissional + STRING_ENTER + StringOfChar('-', 90) + STRING_ENTER;
  end;

  if fEmptyStr(strMsgProfissional) then
    Exit;

  if blnInfBlo then
    objLogAvi.strInfBlo := AnsiReplaceStr(objLogAvi.strInfBlo, STRING_PROFISSIONAIS_LIBERACAO, strMsgProfissional)
  else
    objLogAvi.strInfBlo := AnsiReplaceStr(objLogAvi.strInfBlo, STRING_PROFISSIONAIS_LIBERACAO, '');

  if blnInfLib then
    objLogAvi.strInfLib := AnsiReplaceStr(objLogAvi.strInfLib, STRING_PROFISSIONAIS_LIBERACAO, strMsgProfissional)
  else
    objLogAvi.strInfLib := AnsiReplaceStr(objLogAvi.strInfLib, STRING_PROFISSIONAIS_LIBERACAO, '');

  if blnInfBlo then
    objLogAvi.strMsgJso := AnsiReplaceStr(objLogAvi.strMsgJso, STRING_PROFISSIONAIS_LIBERACAO, AnsiReplaceStr(strMsgProfissional,'"',''''))
  else
    objLogAvi.strMsgJso := AnsiReplaceStr(objLogAvi.strMsgJso, STRING_PROFISSIONAIS_LIBERACAO, '');
end;

procedure TfrmFatLiberacaoBloqueios.pCarregaTransportadoraValorMinimo(
  var ObjLogAvi: TLogAvi);
var
  strMsgValorMinimo: string;
  blnInfBlo: Boolean;
  blnInfLib: Boolean;
  blnMenObs: Boolean;

  intPosTransp: integer;
begin
  strMsgValorMinimo := '';

  If (objLogAvi.strDirAce = 'VEMIN3') or
    (objLogAvi.strDirAce = 'VEMIN6') or
    (objLogAvi.strDirAce = 'VEMIN') Then
  Begin

    blnInfBlo := (Pos('Transportadora', objLogAvi.strInfBlo) = 0);
    blnInfLib := (Pos('Transportadora', objLogAvi.strInfLib) = 0);
    blnMenObs := (Pos('Transportadora', objLogAvi.strMenObs) = 0);

    If Not fEmptyStr(fatVenda.strCodTra) then
    Begin
      strMsgValorMinimo := STRING_ENTER + StringOfChar('-', 95) +
                           STRING_ENTER + 'Transportadora: ' + fatVenda.strCodTra + '-' + fRetNomTransportadora(fatVenda.strCodTra);

      If Not fEmptyStr(fatVenda.strTipFre) Then
        strMsgValorMinimo := strMsgValorMinimo + STRING_ENTER + 'Tipo de Frete: ' + fDescricaoFrete(fatVenda.strTipFre);

      strMsgValorMinimo := strMsgValorMinimo + STRING_ENTER + StringOfChar('-', 95);
    End;

    if fEmptyStr(strMsgValorMinimo) then
      Exit;

    If blnInfBlo Then
      objLogAvi.strInfBlo := objLogAvi.strInfBlo + strMsgValorMinimo
    Else
    Begin
      intPosTransp := Pos('Transportadora', objLogAvi.strInfBlo);
      objLogAvi.strInfBlo := StuffString(objLogAvi.strInfBlo, intPosTransp - 101, 482, strMsgValorMinimo)
    End;

    if blnInfLib then
      objLogAvi.strInfLib := objLogAvi.strInfLib + strMsgValorMinimo
    Else
    Begin
      intPosTransp := Pos('Transportadora', objLogAvi.strInfLib);
      objLogAvi.strInfLib := StuffString(objLogAvi.strInfLib, intPosTransp - 101, 482, strMsgValorMinimo)
    End;

    if blnMenObs then
      objLogAvi.strMenObs := objLogAvi.strMenObs + strMsgValorMinimo
    Else
    Begin
      intPosTransp := Pos('Transportadora', objLogAvi.strMenObs);
      objLogAvi.strMenObs := StuffString(objLogAvi.strMenObs, intPosTransp - 101, 482, strMsgValorMinimo)
    End;

  End;

end;

procedure TfrmFatLiberacaoBloqueios.spl1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
  Accept := pnlTail.Height > 30;
end;

procedure TfrmFatLiberacaoBloqueios.spl2CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
  Accept := pnlMsgLib.Height > 30;
end;

procedure TfrmFatLiberacaoBloqueios.tmrLiberaTimer(Sender: TObject);
Var
  strOpeLib           : String;
  strMsgLib           : String;
  intRecNo            : Integer;
  blnTodasRespondidas : Boolean;
  strOpeAnalise       : String;
  horaLogLib,
  horaLogEnv,
  horaLogCad          : TDateTime;
  strCodigoLiberacao  : String;
begin
  inherited;

  If blnExecutandoAcao Then
    Exit;

  blnExecutandoAcao := True;

  Try
    intRecNo := cdsConsulta.RecNo;

    cdsConsulta.DisableControls;

    cdsConsulta.First;

    While Not cdsConsulta.Eof Do
    Begin
      If Pos(cdsConsultaSTATUS.AsString, 'L_N_') <= 0 Then
      Begin

        {Aguardando... Alguém já pegou para analisar?}
        If (cdsConsultaSTATUS.AsString = 'A') Then
        Begin
          If fMsgLiberacaoJaAnalisando(cdsConsultaNUMLIB.AsString, strOpeAnalise) Then
          Begin
            If Not fEmptyStr(strOpeAnalise) Then
            Begin
              cdsConsulta.Edit;
              cdsConsultaSTATUS.AsString := 'S';
              cdsConsultaMSGLIB.AsString := 'Solicitação em Análise! ' + 'Por: ' + strOpeAnalise + '-' + fRetNomeOperador(strOpeAnalise);
              cdsConsulta.Post;
            End;
          End;
        End
        Else
        {Analisando... Parou de analisar?}
        If (cdsConsultaSTATUS.AsString = 'S') Then
        Begin
          If Not fMsgLiberacaoJaAnalisando(cdsConsultaNUMLIB.AsString, strOpeAnalise) Then
          Begin
            cdsConsulta.Edit;
            cdsConsultaSTATUS.AsString := 'A';
            cdsConsultaMSGLIB.AsString := 'Aguardando retorno!';
            cdsConsulta.Post;
          End;
        End;

        If fVerificaLiberacao(cdsConsultaNUMLIB.AsString, strOpeLib) Then
        Begin

          if fCfgSis('JUSLIB', varBoolean) then
          begin
            If fMsgLiberacaoJaLida(cdsConsultaNUMLIB.AsString, strMsgLib, strOpeLib, strOpeLib) Then
            Begin
              strMsgLib := sLineBreak + 'Justificativa de Liberação: ' + strMsgLib;
            End;
          end;

          If (strOpeLib <> '') Then
          Begin
            if not fVerificaDataHoraLiberacao(cdsConsultaNUMLIB.AsString, horaLogLib) then
              horaLogLib := 0;
            if not fVerificaDataHoraEnvio(cdsConsultaNUMLIB.AsString, horaLogEnv) then
              horaLogEnv := 0;
            if not fVerificaDataHoraCadastro(cdsConsultaNUMLIB.AsString, horaLogCad) then
              horaLogCad := 0;

            strCodigoLiberacao := fCodigoLiberacaoLogLib(cdsConsultaDIRACE.AsString);
            pGeraMatrizLiberacao(strOpeLib,
                                 cdsConsultaCODOPE.AsString,
                                 fMesclaMensagemMaisJustificativa(cdsConsultaINFLIB.AsString, strJustTemp, strMsgLib),//fMesclaMensagemMaisJustificativa(cdsConsultaMENOBS.AsString, strJustTemp),
                                 cdsConsultaDIRACE.AsString,
                                 strCodigoLiberacao,
                                 cdsConsultaCODITE.AsString,
                                 cdsConsultaAUTINC.AsInteger,
                                 cdsConsultaNUMLIB.AsString,
                                 fMesclaMensagemMaisJustificativa(cdsConsultaINFLIB.AsString, strJustTemp, strMsgLib),
                                 False,
                                 fRetornaXmlClientTravasMinimas(cdsConsultaNUMLIB.AsString, 'AUX_INFOF4'),
                                 horaLogLib,
                                 horaLogCad,
                                 horaLogEnv,
                                 cdsConsultaMSGSEN.AsString,
                                 cdsConsultaMOTIVO.AsString);

            cdsConsulta.Edit;
            cdsConsultaOPELIB.AsString := strOpeLib;
            cdsConsultaNOMOPE.AsString := strOpeLib + '-' + fRetNomeOperador(strOpeLib);

            cdsConsultaSTATUS.AsString := 'L';
            cdsConsultaMSGLIB.AsString := 'Solicitação liberada com sucesso!' + strMsgLib;
            cdsConsulta.Post;

            If (fCfgSis('ALTVMT', varString) = 'S') And (Pos(Copy(cdsConsultaDIRACE.AsString,1,5), 'PRMIN_VEMIN_') >0) Then
            Begin
              pAjustaProdutosTravaPreco
            End;
          End
          Else
          Begin
            cdsConsulta.Edit;
            cdsConsultaOPELIB.AsString := '';
            cdsConsultaNOMOPE.AsString := '';
            cdsConsulta.Post;
          End;

          If (Not fEmptyStr(strMsgLib)) And (fCfgSis('JUSLIB', varBoolean)) And (fCfgSis('JUSAUT', varBoolean)) Then
            fMensagem('', 'A sua solicitação de liberação foi Autorizada!' + strMsgLib, ['&Ok']);
        End
        Else If fMsgLiberacaoJaLida(cdsConsultaNUMLIB.AsString, strMsgLib, strOpeLib) Then
        Begin

          cdsConsulta.Edit;

          if (strOpeLib <> '') then
          begin
            cdsConsultaOPELIB.AsString := strOpeLib;
            cdsConsultaNOMOPE.AsString := strOpeLib + '-' + fRetNomeOperador(strOpeLib);
          end
          else
          begin
            cdsConsultaOPELIB.AsString := '';
            cdsConsultaNOMOPE.AsString := '';
          end;

          cdsConsultaSTATUS.AsString := 'N';
          cdsConsultaMSGLIB.AsString := 'Solicitação negada!' + #13#10 + 'Justificativa: ' + strMsgLib;
          cdsConsulta.Post;

        End;
      End;

      cdsConsulta.Next;
    End;

    If intRecNo > 0 Then
      cdsConsulta.RecNo := intRecNo;

    cdsConsulta.EnableControls;

    If fLiberacaoCompleta(blnTodasRespondidas) Then
    Begin
      if assigned(tmrLibera) then
        tmrLibera.Enabled := False;
      pMensagemOk('Todas as solicitações foram liberadas!');
      btnOk.Click;
    End
    Else If blnTodasRespondidas Then
    Begin
      if assigned(tmrLibera) then
        tmrLibera.Enabled := False;
      pMensagemOk('Todas as solicitações foram respondidas, ' +
                  'porém existem bloqueios!');
    End;
  Finally
    blnExecutandoAcao := False;
  End;

end;

function TfrmFatLiberacaoBloqueios.fCancelarSolicitacao: Boolean;
begin
  Result :=
    fExecutaSQL( ' DELETE FROM CADMSG ' +
                 ' WHERE MSG_OPEENV = ' + QuotedStr(fRetCodOpeSolicitante(fatVenda.strOpcDoc, IIF(blnUsaDig, cdsConsultaCODDIG.AsString, cdsConsultaCODOPE.AsString))) +
                 ' AND MSG_NUMLIB = ' + QuotedStr(cdsConsultaNUMLIB.AsString) );
end;

procedure TfrmFatLiberacaoBloqueios.pCancelarTodasSolicitacoes;
  Var
    intRecNo: Integer;
begin
  inherited;
  intRecNo := cdsConsulta.RecNo;
  cdsConsulta.DisableControls;
  cdsConsulta.First;

  While Not cdsConsulta.Eof Do
  Begin
    fCancelarSolicitacao;
    cdsConsulta.Next;
  End;

  If intRecNo > 0 Then
    cdsConsulta.RecNo := intRecNo;

  cdsConsulta.EnableControls;
end;

procedure TfrmFatLiberacaoBloqueios.pAguardarTentativasExecutaAcao;
  Var
    intTentativas : Integer;
begin
  For intTentativas := 1 To 100 Do
  Begin
    If (Not blnExecutandoAcao) Then
      Break;

    Sleep(100);
  End;
end;

procedure TfrmFatLiberacaoBloqueios.pAjustaProdutosTravaPreco;
var
  frmFatTravaProdPreco: TfrmFatTravaProdPreco;
begin
  if not Assigned(cdsConsulta) then
  begin
    Exit;
  end;

  if not cdsConsulta.Active then
  begin
    Exit;
  end;

  if cdsConsulta.RecordCount <= 0 then
  begin
    Exit;
  end;

  if cdsConsulta.RecNo <= 0 then
  begin
    Exit;
  end;

  If fEmptyStr(cdsConsultaNUMLIB.AsString) Then
  begin
    Exit;
  end;

  if fCampoTabela('GER_NUMLIB','TPMGER',['GER_NUMLIB'],[cdsConsultaNUMLIB.AsString]) <> cdsConsultaNUMLIB.AsString then
  begin
    Exit;
  end;

  if fCampoTabela('GER_RESPON','TPMGER',['GER_NUMLIB'],[cdsConsultaNUMLIB.AsString]) <> 'S' then
  begin
    Exit;
  end;

  pCriarFormularios(TfrmFatTravaProdPreco, frmFatTravaProdPreco);

  try
    frmFatTravaProdPreco.NumLib := cdsConsultaNUMLIB.AsString;
    frmFatTravaProdPreco.ApenaVisualizacao := True;
    frmFatTravaProdPreco.pCarregaProdutosTrava;
    pCloneDataSet(fatVenda.cdsTravaProdMin, frmFatTravaProdPreco.cdsProdutos);
    fatVenda.strNumLib := frmFatTravaProdPreco.NumLib;
  finally
    pFreeAndNil(frmFatTravaProdPreco);
  end;
end;

procedure TfrmFatLiberacaoBloqueios.pApagaLogVarNaoUtilizado;
  Var
    intRecNo: Integer;
begin
  inherited;
  intRecNo := cdsConsulta.RecNo;
  cdsConsulta.DisableControls;
  cdsConsulta.First;

  While Not cdsConsulta.Eof Do
  Begin
    fExecutaSQL('DELETE FROM LOGVAR ' +
                'WHERE LOG_NROLIB = ' + QuotedStr(cdsConsultaNUMLIB.AsString));
    cdsConsulta.Next;
  End;

  If intRecNo > 0 Then
    cdsConsulta.RecNo := intRecNo;

  cdsConsulta.EnableControls;
end;

procedure TfrmFatLiberacaoBloqueios.pAtualizarOpeLibArrLogAvi;
  Var
    intBloqueio: Integer;
begin
  For intBloqueio := 0 To Length(arrLogAvi) -1 Do
    If cdsConsulta.Locate('NUMLIB', arrLogAvi[intBloqueio].strNumLib, []) Then
      arrLogAvi[intBloqueio].strOpeLib := cdsConsultaOPELIB.AsString;
end;

function TfrmFatLiberacaoBloqueios.fEnviaMsgLiberacao(pgbStatus: TcxProgressBar = nil): Boolean;
  Var
    qryCadOpe : TUniQuery;
    strCodOpe : String;
    stlCodOpe : TStringList;
    msgInterna: TMsgInterna;
    strMensagem: String;
    strJustificativa: String;
    strMensagemJSON : String;
    strMsgNegativa  : String;
    strMsgEnvioJson : String;
    strMsgEnvio     : String;
    strInfLib       : String;
    objMsg : TMensagemLiberacao;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde, enviando mensagem de liberação ...', 0);

  Result := False;
  if not fEmptyStr(cdsConsultaMSGJSO.AsString) then
  begin
    objMsg := TMensagemLiberacao.Create(Self);
    objMsg.fGetObjectFromJson(cdsConsultaMSGJSO.AsString);
  end;

  qryCadOpe := fCriaQuery;
  Try
    Try
      qryCadOpe.SQL.Add( fGetSqlLiberacao );
      qryCadOpe.SQL.Add('ORDER BY OPE_CODOPE');
      qryCadOpe.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryCadOpe.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCadOpe.Open;

      Result := Not qryCadOpe.IsEmpty;

      If Not Result Then
      Begin
        pMensagemOk('Não há nenhum operador ativo marcado para "Receber mensagem de Liberação Remota", '+
                    'com acesso no quadro "Empresas - Acesso para receber liberação remota" '+
                    'liberado para a loja '+ VS_strCodEmp +'. Sendo assim, ninguém pode receber a mensagem.'+ sLineBreak +
                    'Peça para o responsável ajustar os cadastros e depois tente novamente.', 500, 220);
        Exit;
      End;

      stlCodOpe := TStringList.Create;

      qryCadOpe.First;
      While Not qryCadOpe.Eof Do
      Begin
        If fVerificaAcessoSistema(cdsConsultaDIRACE.AsString, qryCadOpe.FieldByName('OPE_CODOPE').AsString) Then
          stlCodOpe.Add(qryCadOpe.FieldByName('OPE_CODOPE').AsString);
        qryCadOpe.Next;
      End;

      msgInterna := TMsgInterna.Create(Self);

      strJustificativa := '';

      If fMensagem('', 'Deseja digitar uma justificativa para a solicitação de liberação?', ['','']) = 1 Then
      Begin
        While (fEmptyStr(strJustificativa)) Do
        Begin
           If not InputQuery(cdsConsultaMOTIVO.AsString, 'Digite a justificativa para esta liberação:', strJustificativa) then
             break;
        End;

        if not fEmptyStr(strJustificativa) then
        begin
          if Assigned(objMsg) then
            objMsg.strJustificativa := strJustificativa;

          strJustificativa := STRING_QUEBRA + 'JUSTIFICATIVA:' + STRING_QUEBRA + strJustificativa + STRING_QUEBRA;
          strJustTemp := #13 + StringReplace(strJustificativa, STRING_QUEBRA, '', [rfReplaceAll]) + #13;

          pGravarJustificativa(cdsConsultaNUMLIB.AsString, strJustTemp);

        end;
      End;

      if Assigned(objMsg) then
      begin
        strMensagem     := cdsConsultaINFBLO.AsString;
        strMensagemJSON := objMsg.fGetJsonObject.ToJson;
      end
      else
      begin
        strMensagem     := cdsConsultaINFBLO.AsString;
        strMensagem     := fMesclaMensagemMaisJustificativa(strMensagem, strJustificativa);
        strMensagemJSON := '';
      end;

      strMensagem     := fLimpaTagMsgOculta(strMensagem);
      strMensagemJSON := fLimpaTagMsgOculta(strMensagemJSON);

      strCodigoLiberacaoLogVar := Trim(cdsConsultaDIRACE.AsString) + fatVenda.FSequencialUnicoDtaHrLogVar;

      strInfLib := cdsConsultaINFLIB.AsString;

      strMsgNegativa := fRetJustificativaNegacaoMsgAnterior(strCodigoLiberacaoLogVar, fatVenda.strCodCli);
      If Not fEmptyStr(strMsgNegativa) Then
      Begin
        strMensagem := strMensagem + strMsgNegativa;
        strInfLib := strInfLib + strMsgNegativa;
      End;

      strMensagem := strMensagem  + #13#10+ fRetornaRotina;
      strInfLib := strInfLib + #13#10+ fRetornaRotina;

      pUpdateAuxVar(cdsConsultaNUMLIB.AsString, fatVenda.strCodCli, fatVenda.strCodVen, strInfLib);

      strMensagem    := AnsiReplaceStr(strMensagem    , #13#10, STRING_QUEBRA);

      pInfoStatusGravacao(pgbStatus, 'Aguarde, enviando mensagem de liberação ...', stlCodOpe.Count);

      fStartTransaction;
      Try
        If (fCfgSis('ALTVMT', varBoolean)) Then
        Begin
          pMandaMensagemLiberacaoValorMinimoPorItem;
        End;

        dbgConsulta.Enabled := False;
        For strCodOpe In stlCodOpe Do
        Begin
          pStepStatusGravacao(pgbStatus);
          pnlInfo.Caption := 'Aguarde, enviando mensagem de liberação para o operador: ' + cdsConsultaCODOPE.AsString;

          strMsgEnvio := strMensagem;
          strMsgEnvioJson := strMensagemJSON;
          If fDestinatarioSemDireitoAcessoInformacao(cdsConsultaDIRACE.AsString, strCodOpe) Then
          Begin
            strMsgEnvio     := fTagMsgOcultaToMsgCoringa(strMsgEnvio, omlMsgParaQuemReceb);
            strMsgEnvioJson := fTagMsgOcultaToMsgCoringa(strMsgEnvioJson, omlMsgParaQuemReceb);
          End
          Else
          Begin
            strMsgEnvio     := fLimpaTagMsgOculta(strMsgEnvio, omlMsgParaQuemReceb);
            strMsgEnvioJson := fLimpaTagMsgOculta(strMsgEnvioJson, omlMsgParaQuemReceb);
          End;

          If msgInterna.fEnviaMensagem(cdsConsultaMOTIVO.AsString,
                                       strMsgEnvio,
                                       fRetCodOpeSolicitante(fatVenda.strOpcDoc, IIF(blnUsaDig, cdsConsultaCODDIG.AsString, cdsConsultaCODOPE.AsString)),
                                       strCodOpe,
                                       'S',
                                       cdsConsultaNUMLIB.AsString,
                                       strMsgEnvioJson) Then
          Begin
            Result := True;
          End;
        End;
      Finally
        pnlInfo.Caption := '';
        dbgConsulta.Enabled := True;
        fCommit;
      End;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro('Erro: ' + E.Message, '[fEnviaMsgLiberacao]');
        Result := False;
      End;
    end;

  Finally
    FreeAndNil(qryCadOpe);

    If Assigned(msgInterna) Then
      FreeAndNil(msgInterna);

    If Assigned(objMsg) Then
      FreeAndNil(objMsg);

    If Assigned(stlCodOpe) Then
      FreeAndNil(stlCodOpe);

    If Result Then
      pLigaTimerLibera;
  End;
end;

function TfrmFatLiberacaoBloqueios.fSolicLiberacaoAnaliseAnalitica: Boolean;
  Var
    objLiberacao: TLiberacao;
    strCodOpe: String;
begin
  objLiberacao := TLiberacao.Create;
  Try
    objLiberacao.strDirAce := 'TRDESANA';
    objLiberacao.strMsgSen := 'Análise Analítica dos Produtos';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    strCodOpe := IIF(blnUsaDig, cdsConsultaCODDIG.AsString, cdsConsultaCODOPE.AsString);

    objLiberacao.objMsgLibera.pAddSeparador;
    objLiberacao.objMsgLibera.pAddTexto('TRAVA DE DESCONTO - REALIZAR ANÁLISE ANALÍTICA DOS PRODUTOS', alCentro);
    objLiberacao.objMsgLibera.pAddSeparador;
   // objLiberacao.objMsgLibera.pAddTexto('Número Liberação: '+ cdsConsultaNUMLIB.AsString); //removido pois estava causando confusão no cliente
    objLiberacao.objMsgLibera.pAddTexto('Motivo bloqueio : '+ cdsConsultaMOTIVO.AsString);
    objLiberacao.objMsgLibera.pAddTexto('Operador        : '+ strCodOpe +'-'+ fRetNomVendRep(strCodOpe));
    objLiberacao.objMsgLibera.pAddTexto('Cliente         : '+ fatVenda.strCodCli +'-'+ fRetNomCliente(fatVenda.strCodCli));

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

function TfrmFatLiberacaoBloqueios.fMsgLiberacaoJaAnalisando(strNumLib : String; var strOpeAnalise: String): Boolean;
var
  qryMsg: TUniQuery;
begin

  qryMsg := fCriaQuery(nil);

  Try

    With qryMsg, SQL Do
    Begin

      Clear;

      Add('SELECT SQL_NO_CACHE ');
      Add('  MSG_OPELIB ');
      Add('FROM ');
      Add('  CADMSG ');
      Add('WHERE ');
      Add('  MSG_OPEENV = :OPEENV AND ');
      Add('  MSG_NUMLIB = :NUMLIB AND ');
      Add('  ((MSG_OPELIB IS NOT NULL) AND (MSG_OPELIB <> "")) ');

      ParamByName('OPEENV').AsString := fRetCodOpeSolicitante(fatVenda.strOpcDoc, IIF(blnUsaDig, cdsConsultaCODDIG.AsString, cdsConsultaCODOPE.AsString));
      ParamByName('NUMLIB').AsString := strNumLib;

      Open;

      Result := (Not IsEmpty);

      strOpeAnalise := '';

      If Result Then
        strOpeAnalise := FieldByName('MSG_OPELIB').AsString;

    End;

  Finally
    FreeAndNil(qryMsg);
  End;

end;

function TfrmFatLiberacaoBloqueios.fMsgLiberacaoJaLida(strNumLib     : String;
                                                       var strMsgLib : String;
                                                       var strOpeLib : String;
                                                       strOpeLibRef  : String = ''): Boolean;
var
  qryMsg: TUniQuery;
begin

  qryMsg := fCriaQuery(nil);

  With qryMsg, SQL Do
  Begin
    Clear;
    Add('SELECT SQL_NO_CACHE ');
    Add('  MSG_MSGLIB, MSG_OPELIB ');
    Add('FROM ');
    Add('  CADMSG ');
    Add('WHERE ');
    If (Not fEmptyStr(strOpeLibRef)) Then
      Add('MSG_OPELIB = "'+strOpeLibRef+'" AND ');
    Add('  MSG_OPEENV = :OPEENV AND ');
    Add('  MSG_NUMLIB = :NUMLIB AND ');
    Add('  MSG_LIDA__ = "S" ');

    ParamByName('OPEENV').AsString := fRetCodOpeSolicitante(fatVenda.strOpcDoc, IIF(blnUsaDig, cdsConsultaCODDIG.AsString, cdsConsultaCODOPE.AsString));
    ParamByName('NUMLIB').AsString := strNumLib;

    Open;

    Result := (Not IsEmpty);

    strMsgLib := '';
    strOpeLib := '';

    If Result Then
    begin
      strMsgLib := FieldByName('MSG_MSGLIB').AsString;
      strOpeLib := FieldByName('MSG_OPELIB').AsString;
    end;

  End;

  FreeAndNil(qryMsg);

end;

function TfrmFatLiberacaoBloqueios.fLiberacaoCompleta(var blnTodasRespondidas: Boolean): Boolean;
  Var
    intRecNo: Integer;
begin
  inherited;
  Result := True;
  intRecNo := cdsConsulta.RecNo;
  blnTodasRespondidas := True;   

  cdsConsulta.DisableControls;

  cdsConsulta.First;

  While Not cdsConsulta.Eof Do
  Begin
    If cdsConsultaSTATUS.AsString <> 'L' Then
    Begin
      Result := False;
    End;

    blnTodasRespondidas := blnTodasRespondidas And
      (Pos(cdsConsultaSTATUS.AsString, 'L_N_') > 0);

    cdsConsulta.Next;
  End;

  If intRecNo > 0 Then
    cdsConsulta.RecNo := intRecNo;

  cdsConsulta.EnableControls;
end;

procedure TfrmFatLiberacaoBloqueios.pCarregaValorDocumento(var objLogAvi: TLogAvi);
var
  strValorDocumento: string;
  blnInfBlo: Boolean;
  blnInfLib: Boolean;
  blnMsgJso: Boolean;
begin
  blnInfBlo := (Pos(STRING_VALOR_DOCUMENTO, objLogAvi.strInfBlo) > 0);
  blnInfLib := (Pos(STRING_VALOR_DOCUMENTO, objLogAvi.strInfLib) > 0);
  blnMsgJso := (Pos(STRING_VALOR_DOCUMENTO, objLogAvi.strMsgJso) > 0);

  if (not blnInfBlo) and (not blnInfLib) and (not blnMsgJso) then
    Exit;

  strValorDocumento := FormatFloat(fMskDigitos(2), fatVenda.fltTotGer);

  if blnInfBlo then
    objLogAvi.strInfBlo := AnsiReplaceStr(objLogAvi.strInfBlo, STRING_VALOR_DOCUMENTO, strValorDocumento)
  else
    objLogAvi.strInfBlo := AnsiReplaceStr(objLogAvi.strInfBlo, STRING_VALOR_DOCUMENTO, '');

  if blnInfLib then
    objLogAvi.strInfLib := AnsiReplaceStr(objLogAvi.strInfLib, STRING_VALOR_DOCUMENTO, strValorDocumento)
  else
    objLogAvi.strInfLib := AnsiReplaceStr(objLogAvi.strInfLib, STRING_VALOR_DOCUMENTO, '');

  if blnInfBlo then
    objLogAvi.strMsgJso := AnsiReplaceStr(objLogAvi.strMsgJso, STRING_VALOR_DOCUMENTO, strValorDocumento)
  else
    objLogAvi.strMsgJso := AnsiReplaceStr(objLogAvi.strMsgJso, STRING_VALOR_DOCUMENTO, '');
end;

procedure TfrmFatLiberacaoBloqueios.FormDestroy(Sender: TObject);
begin
  RemoveTimerBotaoMsg;
  inherited;
end;

procedure TfrmFatLiberacaoBloqueios.pSalvaProdutosTravaPreco(strNumLib: String);
var
  qryProdutosTrava: TUniQuery;
  strAutInc: String;
begin
  if cdsVenda = Nil then
    Exit;

  if not cdsVenda.Active then
    Exit;

  if cdsVenda.RecordCount <= 0 then
    Exit;

  cdsVenda.First;

  qryProdutosTrava := fCriaQuery;

  try
    try
      strAutInc := fRetAutoIncrem('TPMGER', VS_strCodEmp);

      qryProdutosTrava.Close;
      qryProdutosTrava.SQL.Clear;
      qryProdutosTrava.SQL.Add('INSERT INTO TPMGER(AUTOINCREM, GER_OPESOL, GER_NUMLIB)');
      qryProdutosTrava.SQL.Add('VALUES(:AUTINC, :OPESOL, :NUMLIB)');

      qryProdutosTrava.ParamByName('AUTINC').AsString := strAutInc;
      qryProdutosTrava.ParamByName('OPESOL').AsString := strLoginUsuarioLogado;
      qryProdutosTrava.ParamByName('NUMLIB').AsString := strNumLib;

      qryProdutosTrava.ExecSQL;

      qryProdutosTrava.Close;
      qryProdutosTrava.SQL.Clear;
      qryProdutosTrava.SQL.Add('INSERT INTO TPMDET(AUTOINCREM, DET_SEQGER, DET_CODITE, DET_DESITE, DET_PREORI, DET_DESCON,');
      qryProdutosTrava.SQL.Add('                   DET_PRENOV, DET_PRECUS, DET_MARLIQ, DET_PREPER, DET_PREAUT, DET_SEQFDO)');
      qryProdutosTrava.SQL.Add('VALUES(:AUTINC, :SEQGER, :CODITE, :DESITE, :PREORI, :DESCON,');
      qryProdutosTrava.SQL.Add('       :PRENOV, :PRECUS, :MARLIQ, :PREPER, :PREAUT, :SEQFDO)');

      while not cdsVenda.Eof do
      begin
        qryProdutosTrava.Close;
        qryProdutosTrava.ParamByName('AUTINC').AsString := fRetAutoIncrem('TPMDET', VS_strCodEmp);
        qryProdutosTrava.ParamByName('SEQGER').AsString := strAutInc;
        qryProdutosTrava.ParamByName('CODITE').AsString := cdsVenda.FieldByName('ITE_CODITE').AsString;
        qryProdutosTrava.ParamByName('DESITE').AsString := cdsVenda.FieldByName('ITE_DESITE').AsString;
        qryProdutosTrava.ParamByName('PREORI').AsFloat := cdsVenda.FieldByName('ITE_UNIORI').AsFloat;
        qryProdutosTrava.ParamByName('DESCON').AsFloat := ((cdsVenda.FieldByName('ITE_UNITAR').AsFloat * 100) / cdsVenda.FieldByName('ITE_UNIORI').AsFloat);
        qryProdutosTrava.ParamByName('PRENOV').AsFloat := cdsVenda.FieldByName('ITE_UNITAR').AsFloat;
        qryProdutosTrava.ParamByName('PRECUS').AsFloat := cdsVenda.FieldByName('ITE_PRECU2').AsFloat;
        qryProdutosTrava.ParamByName('MARLIQ').AsFloat := cdsVenda.FieldByName('ITE_MARLUC').AsFloat;
        qryProdutosTrava.ParamByName('PREPER').AsFloat := cdsVenda.FieldByName('ITE_PREMIN').AsFloat;
        qryProdutosTrava.ParamByName('PREAUT').AsFloat := cdsVenda.FieldByName('ITE_PREMIN').AsFloat;
        qryProdutosTrava.ParamByName('SEQFDO').AsString := cdsVenda.FieldByName('AUTOINCREM').AsString;
        qryProdutosTrava.ExecSQL;

        cdsVenda.Next;
      end;
    except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmFatLiberacaoBloqueios.pSalvaProdutosTravaPreco');
      End;
    end;
  finally
    FreeAndNil(qryProdutosTrava);
  end;
end;

procedure TfrmFatLiberacaoBloqueios.pSetarVisibilidadeQtdMsgNaoLida(
  const intQtdMsg: Integer);
begin
  If (intQtdMsg > 99) Then
    lblQtdMsg.Caption := '+99'
  Else
    lblQtdMsg.Caption := IntToStr(intQtdMsg);
  pnlShapeQtdMsgPen.Visible := (intQtdMsg > 0);
  If (pnlShapeQtdMsgPen.Visible) Then
  Begin
    btnMensagens.Font.Color := clBlue;
    btnMensagens.Font.Style := [fsBold];
  End
  Else
  Begin
    btnMensagens.Font.Color := clBlack;
    btnMensagens.Font.Style := [];
  End;
end;

procedure TfrmFatLiberacaoBloqueios.RemoveTimerBotaoMsg;
begin
  TNewTimer.Del(Self.Name + '.tmrBotaoMsg');
end;

procedure TfrmFatLiberacaoBloqueios.pAtualizarBotaoMensagens(Sender: TObject);
begin
  pSetarVisibilidadeQtdMsgNaoLida(TfrmCadMsg.fGetQtdMensagensNaoLidas);
end;

function TfrmFatLiberacaoBloqueios.TimerBotaoMsg: TNewTimer;
begin
  if not TNewTimer.Has(Self.Name + '.tmrBotaoMsg') then
  begin
    Result := TNewTimer.Get(Self.Name + '.tmrBotaoMsg');
    Result.Interval := fCfgSis('ATBTMS', varInteger) * 1000;
    Result.Enabled  := True;
    Result.OnTimer  := pAtualizarBotaoMensagens;
  end
  else
    Result := TNewTimer.Get(Self.Name + '.tmrBotaoMsg');
end;

end.

