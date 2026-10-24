unit untFatExpedicaoRomaneio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, DB, Uni, UniDataSetProvider, UniClientDataSet, StrUtils, untFuncFat,
  MaskUtils, AppEvnts, frxClass, frxDBSet, MMSystem, untFuncFatTypes,
  untIteBar, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox,
  ImgList, MemDS, DBAccess, Provider, untZClient, untFuncFatImp,
  frxExportCSVTestabilidade, Datasnap.DBClient, untTypesSistema, untLiberacao, untSeparacaoFina,
  cxProgressBar, Faturamento.View.DadosCTe;

type
  TfrmFatExpedicaoRomaneio = class(TfrmPai)
    pnlGeral: TPanel;
    dbgItens: TDBGridCitel;
    pnlRodape: TPanel;
    lblCodBar: TLabel;
    edtCodIte: TEditFocus;
    Label2: TLabel;
    edtQtdIte: TEditFocus;
    dtsItens: TDataSource;
    cdsSelecao: TUniClientDataSet;
    cdsSelecaoCODBAR: TStringField;
    cdsSelecaoCODITE: TStringField;
    cdsSelecaoDESITE: TStringField;
    cdsSelecaoNUMDOC: TStringField;
    cdsSelecaoQTDITE: TFloatField;
    cdsSelecaoUNITAR: TFloatField;
    cdsSelecaoTOTITE: TFloatField;
    cdsSelecaoUNIDAD: TStringField;
    qrySelecaoNOMEMP: TStringField;
    qrySelecaoNOMCLI: TStringField;
    qrySelecaoTIPEMB: TStringField;
    qrySelecaoNRODOC: TStringField;
    cdsSelecaoNOMVEN: TStringField;
    cdsSelecaoENDENT: TStringField;
    cdsSelecaoCIDENT: TStringField;
    cdsSelecaoSIGLA_: TStringField;
    cdsSelecaoIDEPRO: TStringField;
    cdsSelecaoDTAENT: TDateField;
    cdsSelecaoDTAVAL: TDateField;
    cdsSelecaoMENSAG: TStringField;
    cdsSelecaoCODVEN: TStringField;
    cdsSelecaoVOLQTE: TStringField;
    lblLimparExpedido: TLabel;
    shpSemSal: TShape;
    lblSemSal: TLabel;
    btnConfirma: TBitBtnLocked;
    btnQuantidade: TBitBtnLocked;
    btnExpAut: TBitBtnLocked;
    frxEtiqItens: TfrxReport;
    btnFatura: TBitBtnLocked;
    frxRelInconsistencia: TfrxReport;
    btnRelInc: TBitBtnLocked;
    cdsIteInc: TUniClientDataSet;
    cdsIteIncDESITE: TStringField;
    cdsIteIncUNIDAD: TStringField;
    cdsIteIncACONFE: TFloatField;
    cdsIteIncCONFER: TFloatField;
    cdsIteIncDIFERE: TFloatField;
    frxRelatorio: TfrxDBDataset;
    cdsIteIncPEDIDO: TStringField;
    cdsIteIncNOMCLI: TStringField;
    lblSepImp: TLabel;
    cdsIteIncNOMVEN: TStringField;
    btnConsPD: TBitBtnLocked;
    btnDigVol: TBitBtnLocked;
    btnReimpSep: TBitBtnLocked;
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnQuantidadeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExpAutClick(Sender: TObject);
    procedure dbgItensEnter(Sender: TObject);
    procedure dbgItensExit(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnFaturaClick(Sender: TObject);
    procedure btnRelIncClick(Sender: TObject);
    procedure btnConsPDClick(Sender: TObject);
    procedure btnDigVolClick(Sender: TObject);
    procedure btnReimpSepClick(Sender: TObject);

  private
    { Private declarations }
    FParams      : TExpedicaoParams;
    FConfirmou   : Boolean;
    blnFecharForm: Boolean;
    strCodIte    : String;
    strCodDig    : String;
    strCamBus    : String;
    fatVenEst    : TFatVenda;
    stlItens     : TStringList;
    qryEtique    : TUniQuery;
    qryFatGor    : TUniQuery;
    VS_strTipDEx : String;
    objIteBar    : TIteBar;
    intDecQtd    : Integer;
    blnManPar    : Boolean;
    strMsgSel    : String;
    bln2CodBar   : Boolean;
    blnExpedido  : Boolean;
    strCodIteFor : String;

    strLogFileName: String;

    strOrdPdv: String;

    stlCodCli: TStringList;
    stlFatGor: TStringList;
    stlVolumesAlterados: TStringList;

    cdsBaiFut : TZClient;

    qryItens : TUniQuery;

    arrDocume: Array of TDocumento;

    objLiberacao : TLiberacao;

    function cdsItens: TUniClientDataSet;

    function fTodosItensConferidos: Boolean;
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pCalculaPesoBrutoLiqExpedicao(fatVenda: TFatVenda);

    procedure pExpedeItem;

    procedure pCarregaItensPedido(blnAgruparProdutos: Boolean = True);
    procedure pSelecionaItem;

    function fValidaDireitoAcesso: boolean;

    procedure pCarregarCliente(fatVenda: TFatVenda; fltQtdExp: Double);
    procedure pAtualizaTemporaria(fatVenda: TFatVenda);

    procedure pEdtCodIteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pOnFilter(DataSet: TDataSet; var Accept: Boolean);
    function fEncontraItem(Var strMensagem: String;
                           blnAtualizaQtde : Boolean = True): Boolean;

    procedure pAdicionaItemSelecao;
    procedure pRemoveItemSelecao;
    procedure pCarregaSaldosColorantes;
    Procedure pSqlFrom(stlItens: TStrings);

    function fSelecionado: Boolean;
    function fRetFatorExped: Double;
    function fRetQtdDigitada(strCodIte: String): Double;
    Function fProcuraSemelhante(strCodBar: String; Var strCodSem: String): Boolean;

    function fExcedeLimiteItensNFe: Boolean;

    function fExpedePedido(objSeparacaoFina : TSeparacaoFina = nil): Boolean;
    function fMarcaPedidoExpedido(strCodCon, strCodSep, strObsExp: String): Boolean;
    procedure pAtualizaQtdExpItemPedido(strAutIncIte: String; fltQtdExp: Double);
    procedure pAtualizaQtdExpItemRomDet(const strRomDetXAutInc: String; fltQtdExp: Double);
    procedure pImprimeEtiquetaDespacho(strNumDoc, strEspDoc, strCodCli, strCodEmp: String; intQtdTra: Integer);
    procedure pMarcarTodosProdutos;
    procedure pOrdenarItens;
    procedure pWriteLogFile(strText: String);

    Function fPedidoExpedido(blnVerifSoImpreSep: Boolean=False): Boolean;
    procedure pHabilitaCampos(blnHabQtd: Boolean = True);

    procedure pFiltraFatGor(strNumDoc,
                            strCodEmp,
                            strCodCli: String;
                            strAutInc: String = '');

    Function fRetItensBaixaEntFut(strSeqFgo: String): Boolean;
    function fSQLPedidosPorItem(blnFiltraItensNaoExpedidos: Boolean; strIdePro: String;
                                blnFiltraLote: Boolean = False): String;

    Function fTemCodLseNaoPreenchido(Var strCodItens: String): Boolean;
    procedure pChamarTelaDeImpressaoDeSeparacao(blnReimpressao: Boolean);
    procedure pImprimeSeparacao(blnImprimirRelatorio : boolean);
    procedure pTocarAlertaSonoro(blnAchou: Boolean);
    function fCodBarEmbUn :String;
    procedure pCarregaDescontoEspecialPedidosExpedidos(fatVenda: TFatVenda);
    procedure pRetornaConferenteESeparador(var strCodCon, strCodSep: String);
    procedure pConfirmaExpedicao(objSeparacaoFina: TSeparacaoFina = nil);
    procedure pAbreItens;
    function fConfirmaExpedicaoGravando(pgbStatus: TcxProgressBar): Boolean;
    procedure pInicializaTela;
    procedure pOnCreate;
    procedure pOnClose;
    procedure pOnShow;
    procedure pVerificarSeClienteTemPontosParaBrindes(fatVenda: TFatVenda);
    procedure pVerificarPromocaoBrindes(strNumDoc, strEspDoc, strCodCli, strNomCli: String);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    property Params: TExpedicaoParams read FParams write FParams;
    property blnConfirmou: Boolean read FConfirmou;
  end;

var
  frmFatExpedicaoRomaneio: TfrmFatExpedicaoRomaneio;

implementation

uses  untFuncoes, System.UITypes,untFatExpedicaoRomaneioVolumes,
      untConstantes, untFatDadosFiscais, untGravando, untFatTipoExpedicao,
      untExpDigVolumes, untImpEtiDespacho, untFuncTinta,untFuncoesSimples,
      untTMatrizSaldosColorantes, untFatDigSepConferente, untFatGor, untCfgRel,
      untModuloSPR, Math, untEmissaoNotaEspecial, untMovGer, untObservacao,
      untFatExpedicao, untDigCndPagamento, untFatExpConsultaPD,
      untAdiantamentoCliente, untAtualizaOcorrenciasCRM, untFuncoesCRM,
      untDuplicatas, untTypesCRM, untIFatEntregaFutura, untTFatEntregaFutura,
      untFatSeparadorConferente, untPromocaoBrindes, untFatPromocaoBrindes;

{$R *.dfm}

function TfrmFatExpedicaoRomaneio.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCodIte) Then
  Begin
    Result := True;

    If VS_strTipDEx = '1' Then
      blnMudarFoco := False;
  End

  Else If (Sender = edtQtdIte) Then
  Begin
    If (fEmptyStr(edtQtdIte.Text)) Then
    Begin
      pMensagemSonora('A quantidade deve ser preenchida!');
      Result := False;
    End
    Else If (fStrToFloat(edtQtdIte.Text) <= 0.0) Then
    Begin
      pMensagemSonora('A quantidade deve ser maior que Zero!');
      Result := False;
    End
    Else
    Begin
      pSetFocus(edtCodIte);
      blnMudarFoco := False;

      If VS_strTipDEx = '1' Then
        edtQtdIte.Enabled := False
      Else
      Begin
        pExpedeItem;
        edtQtdIte.Text := FloatToStrF(1, ffFixed, 12, intDecQtd);
        pSetFocus(dbgItens);
      End;
      
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmFatExpedicaoRomaneio.fTemCodLseNaoPreenchido(Var strCodItens: String): Boolean;
begin
  Result      := False;
  strCodItens := '';

  With cdsItens Do
  Begin
    First;
    While Not EOF Do
    Begin
      If fEmptyStr(FieldByName('ITE_CODLSE').AsString) Then
        strCodItens := strCodItens + FieldByName('CODITE').AsString + ', ';

      Next;
    End;

    If (Not fEmptyStr(strCodItens)) Then
    Begin
      strCodItens := Copy(strCodItens, 1, Length(strCodItens)-2);
      Result      := True;
    End;
  End;
end;

function TfrmFatExpedicaoRomaneio.fTodosItensConferidos: Boolean;
  Var
  cdsAux : TUniClientDataSet;
begin
  cdsAux := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsAux, cdsItens);

    cdsAux.First;
    Result := Not cdsAux.IsEmpty;
    While Not cdsAux.Eof Do
    Begin
      Result := Result And (fFormataFloat(cdsAux.FieldByName('QTDITE').AsFloat, 2) =
                            fFormataFloat(cdsAux.FieldByName('QTDEXP').AsFloat, 2));

      If (Not Result) Then
        Break;

      cdsAux.Next;
    End;

  Finally
    FreeAndNil(cdsAux)
  End;
end;

Function TfrmFatExpedicaoRomaneio.fProcuraSemelhante(strCodBar: String; Var strCodSem: String): Boolean;
  Var
    qryCadSem: TUniQuery;
Begin
  qryCadSem := fCriaQuery(Self);
  With qryCadSem, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  SEM_CODITE ');
    Add('FROM ');
    Add('  CADSEM ');
    Add('WHERE ');
    Add('  SEM_CODBAR = :CODBAR ');

    ParamByName('CODBAR').AsString := strCodBar;
    Open;

    If IsEmpty Then
    Begin
      strCodSem := '';
      Result := False;
    End Else
    Begin
      strCodSem := FieldByName('SEM_CODITE').AsString;
      Result := True;
    End;

  End;
  FreeAndNil(qryCadSem);
End;

procedure TfrmFatExpedicaoRomaneio.pExpedeItem;
var
  strMensagem  : String;
  blnAchou,
  blnBarExp    : Boolean;
  strCodSem    : String;
  strCodIteUni : String;
  strCodGruUni : String;
  fltQtdIteUni : Double;
  strTxtCap    : String;

  strCodIteAux : String;
  strCodDigAux : String;
  strCamBusAux : String;

  procedure SetaCampoProcurar(const strCaption: string);
  begin
    If Not bln2CodBar Then
      lblCodBar.Caption := strCaption;

    If bln2CodBar And (strCaption = CAP_CODBAR_EMB) Then
      strCamBus := 'CODBAR'
    Else
    If bln2CodBar And (strCaption = CAP_CODBAR_FOR) Then
      strCamBus := 'CODBAT'
    Else
      strCamBus := 'CODBAR';
  end;

  procedure pInverteBusca;
  begin
    If (strCamBus='BAREMB') Then
    Begin
      strCamBus:='CODBAT';
      strTxtCap:=CAP_CODBAR_FOR;
      lblCodBar.Caption:=CAP_CODBAR_EMB;
    End
    Else
    Begin
      strCamBus:='BAREMB';
      strTxtCap:=CAP_CODBAR_EMB;
      lblCodBar.Caption:=CAP_CODBAR_FOR;
    End;
  end;

  function fBuscaSegundoCodBar:Boolean;
  begin
    pInverteBusca;

    strCodIteFor := Trim(InputBox('AutCom', strTxtCap,''));

    strCodIte    := strCodIteFor;
    strCodDig    := strCodIteFor;

    Result := fEncontraItem(strMensagem);
  end;

  procedure pArmazenaCondicaoBusca(chrAcao:char);
  begin
    Case chrAcao Of
    'A':Begin
          strCodIteAux := strCodIte;
          strCodDigAux := strCodDig;
          strCamBusAux := strCamBus;
        End;
    'V':Begin
          strCodIte := strCodIteAux;
          strCodDig := strCodDigAux;
          strCamBus := strCamBusAux;
        End;
    End;
  end;

begin

  bln2CodBar   := (fCfgSis('EXPTIN') = '2') And (cdsItens.FieldByName('IDEPRO').AsString <> 'NOR');
  strCodIteFor := '';

  If (Length(edtCodIte.Text) > fTamCodIte) Or FParams.blnAutSer Then
    strCamBus := 'BAREMB'
  Else
  Begin
    strCamBus := 'CODITE';
    edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
    blnBarExp := (fCampoTabela('ITE_BAREXP', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]) = 'S') and fCfgSis('BAREXP', varBoolean);

    If (blnBarExp) Then
    Begin
      If Not fPermiteCodigoProdutoExpedicaoItensMedianteSenha(edtCodIte.Text, objLiberacao) Then
      Begin
        pMensagemSonora('Para expedir o produto ' + edtCodIte.Text + ' é necessário informar o código de barras. Esta informação é obrigatória para este item. ' +
                        'Verifique o cadastro de produtos - Aba "Dados de Saída" - Campo "Obrig. Cód. Barras Expedição"');
        edtCodIte.Clear;
        Exit;
      End;
    End;
  End;

  strMensagem := '';

  strCodIte := edtCodIte.Text;
  strCodDig := edtCodIte.Text;
  cdsItens.IndexFieldNames := 'AUTOINCREM';
  cdsItens.DisableControls;

  pArmazenaCondicaoBusca('A');
  If (Not bln2CodBar) Or (strCamBus = 'CODITE') Then
  Begin
    blnAchou := fEncontraItem(strMensagem);
  End
  Else
  Begin
    blnAchou := fEncontraItem(strMensagem);

    If (Not blnAchou) Then
    Begin
      pInverteBusca;
      blnAchou := fEncontraItem(strMensagem);
    End;

    If blnAchou Then
    Begin
      blnAchou := fBuscaSegundoCodBar;
    End;
  End;

  pArmazenaCondicaoBusca('V');

  If (Not blnAchou) And fCfgSis('ETIDIF', varBoolean) And (strCamBus = 'BAREMB') Then
  Begin
    If objIteBar.fLerCodigoBarrasUnidades(edtCodIte.Text, strCodIteUni, strCodGruUni, fltQtdIteUni) Then
    Begin
      strCamBus := 'CODITE';
      strCodIte := strCodIteUni;
      edtCodIte.Text := strCodIteUni;
      edtQtdIte.Text := FloatToStrF(fltQtdIteUni, ffFixed, 12, fCfgSis('DECQTD', varInteger));
      blnAchou := fEncontraItem(strMensagem);
    End;
  End;

  If (Not bln2CodBar) And (Not blnAchou) And (Length(edtCodIte.Text) > fTamCodIte) Then
  Begin
    SetaCampoProcurar(CAP_CODBAR_EMB);
    blnAchou := fEncontraItem(strMensagem);

    if (Not blnAchou) then
    begin
      SetaCampoProcurar(CAP_CODBAR_FOR);
      blnAchou := fEncontraItem(strMensagem);

      If (Not blnAchou) And fProcuraSemelhante(edtCodIte.Text, strCodSem) Then
      Begin
        strCamBus := 'CODITE';
        edtCodIte.Text := strCodSem;
        strCodIte      := strCodSem;
        blnAchou := fEncontraItem(strMensagem);
      End;
    end;    
  End;


  pTocarAlertaSonoro(blnAchou);

  cdsItens.EnableControls;

  If (Not blnAchou) Then
  Begin
    strMensagem := 'Produto (' + edtCodIte.Text
           + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') não encontrado!';
  End;

  If (Not fEmptyStr(strMensagem)) Then
  Begin
    pMensagemSonora(strMensagem);
  End;

  edtCodIte.Clear;
  lblCodBar.Caption:=CAP_CODBAR_EMB;

end;

procedure TfrmFatExpedicaoRomaneio.pFiltraFatGor(strNumDoc,
                                                 strCodEmp,
                                                 strCodCli: String;
                                                 strAutInc: String = '');
begin
  With qryFatGor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fSelectFromFatgorLeftAuxiliares(True));
    SQL.Add('WHERE ');

    If Not fEmptyStr(strAutInc) Then
    Begin
      SQL.Add('  F.AUTOINCREM = :AUTINC ');
      ParamByName('AUTINC').AsString := strAutInc;
    End
    Else
    Begin
      SQL.Add('  R.GER_NUMROM = :NUMDOC AND ');
      SQL.Add('  F.FGO_ESPDOC = :ESPDOC AND ');
      SQL.Add('  R.GER_EMPROM = :CODEMP AND ');
      SQL.Add('  F.FGO_CODCLI = :CODCLI     ');
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := 'PD';
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
    End;

    Open;

  End;
end;

procedure TfrmFatExpedicaoRomaneio.pHabilitaCampos(blnHabQtd: Boolean = True);
begin
  cdsItens.EnableControls;
  edtCodIte.Enabled     := True;

  If (blnHabQtd) Then
  Begin
    If (VS_strTipDEx <> '1') Then
      edtQtdIte.Enabled     := True;
  End;

  btnConfirma.Enabled   := Not fPedidoExpedido;
  If (fCfgSis('OPCROM', varString) = '1') And fCfgSis('USPRRO', varBoolean) And (Not fCfgSis('SEEXRO', varBoolean)) Then
    lblSepImp.Visible   := Not fPedidoExpedido(True)
  Else
    lblSepImp.Visible   := btnConfirma.Enabled;
  btnExpAut.Enabled     := btnConfirma.Enabled;
  btnQuantidade.Enabled := True;
  btnFatura.Enabled     := (not btnConfirma.Enabled);
  btnDigVol.Enabled     := btnFatura.Enabled;

  lblLimparExpedido.Visible :=
    (fVerificaAcessoSistema('EXPMTD', strLoginUsuarioLogado)) And (Not btnFatura.Enabled);

  btnRelInc.Visible := (FParams.VS_strTipExpInterna = '5') And
    (fVerificaAcessoSistema('IMREIN', strLoginUsuarioLogado));

  pSetFocus(edtCodIte);
end;

procedure TfrmFatExpedicaoRomaneio.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  {**********************************}
  { CONFIGURACAO DE COR P/ SELECAO   }
  {*******************************IV*}
  If (Not cdsItens.Active) Or (cdsItens.IsEmpty) Then
  Begin
    Exit;
  End;

  If fSelecionado Then
  Begin
    If dbgItens.Canvas.Brush.Color = clHighlight Then
      dbgItens.Canvas.Font.Color := clLime
    Else
      dbgItens.Canvas.Brush.Color := clAqua;
  End;

  {**********************************}
  { CONFIGURACAO DE COR P/ EXPEDICAO }
  {*******************************JB*}
  If (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, 2) = fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, 2)) Then
  Begin
    If (cdsItens.FieldByName('FDO_SEPEXP').AsString = 'N') Then
      dbgItens.Canvas.Font.Color := clMaroon;

    If dbgItens.Canvas.Brush.Color = clHighlight Then
      dbgItens.Canvas.Font.Color := clWhite;

    dbgItens.Canvas.Brush.Color := clLime;
  End
  Else If (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, 2) = fFormataFloat(cdsItens.FieldByName('CONCOL').AsFloat, 2)) Then
  Begin
    If (cdsItens.FieldByName('FDO_SEPEXP').AsString = 'N') Then
      dbgItens.Canvas.Font.Color := clMaroon;

    If dbgItens.Canvas.Brush.Color = clHighlight Then
      dbgItens.Canvas.Font.Color := clWhite;

    dbgItens.Canvas.Brush.Color := clMoneyGreen;
  End
  Else
  Begin
    If (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, 2) > fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, 2)) And
       (fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, 2) <> 0) Then
    Begin
      If dbgItens.Canvas.Brush.Color = clHighlight Then
        dbgItens.Canvas.Font.Color := clBlack;

      dbgItens.Canvas.Brush.Color := clYellow;
    end;
  End;

  If (cdsItens.FindField('SALEST') <> Nil) And shpSemSal.Visible Then
  Begin
    If cdsItens.FindField('SALEST').AsFloat <= 0 Then
      dbgItens.Canvas.Font.Color := shpSemSal.Brush.Color;
  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatExpedicaoRomaneio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Shift <> [] then
    Exit;

  Case Key Of
    VK_F5 : If btnReimpSep.Enabled Then btnReimpSep.Click;
    VK_F6 : If VS_strTipDEx = '1' Then btnQuantidade.Click;
    VK_F7 : btnExpAut.Click;
    VK_F8 : If btnRelInc.Visible Then btnRelInc.Click;
    VK_F9 : If btnConsPD.Enabled Then btnConsPD.Click;
    VK_F10: Begin
              Key := 0;
              If btnConfirma.Enabled Then
                btnConfirma.Click;
            End;
    VK_F11: If btnFatura.Enabled And btnFatura.Visible Then btnFatura.Click;
    VK_F12: If btnDigVol.Enabled And btnDigVol.Visible Then btnDigVol.Click;
    VK_ESCAPE : Begin
                  If (fMensagem('', 'Deseja sair?', ['&Sim', '&Não']) = 1) Then
                    btnSair.Click
                  Else
                    Key := 0;
                End;
  End;
end;

procedure TfrmFatExpedicaoRomaneio.btnQuantidadeClick(Sender: TObject);
var
  blnAcesso: boolean;
begin
  inherited;
  If (Not btnQuantidade.Enabled) Then
    Exit;

  blnAcesso := fVerificaAcessoSistema('QTDEXP');

  if not blnAcesso then
    blnAcesso := fValidaDireitoAcesso;

  If blnAcesso Then
  Begin
    edtQtdIte.Enabled := True;
    pSetFocus(edtQtdIte);
  End;
end;

procedure TfrmFatExpedicaoRomaneio.btnRelIncClick(Sender: TObject);
  Var
    qryPed   : TUniQuery;
    fltTotExp: Double;
begin
  inherited;

  Try
    qryPed := fCriaQuery;

    With cdsIteInc Do
    Begin
      CreateDataSet;

      cdsItens.First;
      While Not cdsItens.EOF Do
      Begin
        If (fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, 2) <>
            fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, 2) ) Then
        Begin
          fltTotExp := cdsItens.FieldByName('QTDEXP').AsFloat;

          qryPed.Close;

          qryPed.SQL.Clear;
          qryPed.SQL.Add(fSQLPedidosPorItem(False,
                                            cdsItens.FieldByName('IDEPRO').AsString,
                                            Not fEmptyStr(cdsItens.FieldByName('NUMLOT').AsString)
                                            ));

          qryPed.ParamByName('NUMROM').AsString := FParams.strNumRom;
          qryPed.ParamByName('CODEMP').AsString := VS_strCodEmp;

          If Not fEmptyStr(cdsItens.FieldByName('NUMLOT').AsString) Then
            qryPed.ParamByName('NUMLOT').AsString := cdsItens.FieldByName('NUMLOT').AsString;

          qryPed.ParamByName('CODITE').AsString := cdsItens.FieldByName('CODITE').AsString;
          qryPed.ParamByName('DESITE').AsString := cdsItens.FieldByName('DESCRI').AsString;

          If cdsItens.FieldByName('IDEPRO').AsString <> 'NOR' Then
          Begin
            qryPed.ParamByName('CODACA').AsString := cdsItens.FieldByName('CODACA').AsString;
            qryPed.ParamByName('EMPACA').AsString := cdsItens.FieldByName('EMPACA').AsString;
          End;

          qryPed.Open;
          qryPed.First;
          While Not qryPed.EOF Do
          Begin
            Append;
            FieldByName('PEDIDO').AsString := qryPed.FieldByName('FDO_NUMDOC').AsString + '-' +
                                              qryPed.FieldByName('FDO_ESPDOC').AsString + '-' +
                                              qryPed.FieldByName('FDO_CODEMP').AsString;

            FieldByName('NOMCLI').AsString := qryPed.FieldByName('FDO_CODCLI').AsString + ' - ' +
                                              fRetNomCliente(qryPed.FieldByName('FDO_CODCLI').AsString);

            FieldByName('NOMVEN').AsString := qryPed.FieldByName('FDO_CODVEN').AsString + ' - ' +
                                              fRetNomVendRep(qryPed.FieldByName('FDO_CODVEN').AsString);

            FieldByName('DESITE').AsString := cdsItens.FieldByName('DESITE').AsString;
            FieldByName('UNIDAD').AsString := cdsItens.FieldByName('UNIDAD').AsString;
            FieldByName('ACONFE').AsFloat  := qryPed.FieldByName('FDO_QTDITE').AsFloat;

            If (fltTotExp <> 0) Then
            Begin
              If (fltTotExp >= qryPed.FieldByName('FDO_QTDITE').AsFloat) Then
                FieldByName('CONFER').AsFloat := qryPed.FieldByName('FDO_QTDITE').AsFloat
              Else
                FieldByName('CONFER').AsFloat := fltTotExp;
            End
            Else
              FieldByName('CONFER').AsFloat := 0.00;

            Post;

            fltTotExp := fltTotExp - FieldByName('CONFER').AsFloat;

            qryPed.Next;
          End;
        End;

        cdsItens.Next;
      End;

      FreeAndNil(qryPed);

      If Not IsEmpty Then
      Begin
        frxRelatorio.DataSet := cdsIteInc;
        frxRelInconsistencia.Script.Variables['NOMREL'] := 'RELATÓRIO DE INCONSISTÊNCIA DA CONFERÊNCIA';
        frxRelInconsistencia.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
        frxRelInconsistencia.Script.Variables['NOMFOR'] := Self.Name;

        TfrxMemoView(frxRelInconsistencia.FindObject('rllFundoDetalhe')).Highlight.Color := fCfgSis('CORZEB');

        If frxRelInconsistencia.PrepareReport Then
          pPreviewReport(Self.Name, Self.Caption + ' (Relatório de inconsistência da conferência)', frxRelInconsistencia);
      End
      Else
        pMensagemOk('Não existe nenhum produto com inconsistência');

      Close;
    End;

  Except

    On E: Exception Do
    Begin
      FreeAndNil(qryPed);
      pMensagensErro(E.Message, 'pCarregaSaldosColorantes');
    End;

  End;
end;

function TfrmFatExpedicaoRomaneio.cdsItens: TUniClientDataSet;
begin
  Result := Self.FParams.cdsItens;
end;

Procedure TfrmFatExpedicaoRomaneio.pSqlFrom(stlItens: TStrings);
Begin
  With stlItens Do
  Begin
    Add('FROM                                                            ');
    Add('  FATDOR                                                        ');
    Add('  INNER JOIN CADITE I  ON I.ITE_CODITE      = FDO_CODITE        ');
    Add('  INNER JOIN ITEGER G  ON I.ITE_CODITE      = G.ITE_CODITE      ');
    Add('                      AND G.ITE_CODEMP      = :EMPITE           ');
    Add('  INNER JOIN CADUNI    ON   UNI_CODUNI      = I.ITE_CODUNI      ');
    Add('  LEFT  JOIN CADACA    ON   ACA_CODACA      = FDO_CODACA        ');
    Add('                      AND   ACA_CODEMP      = FDO_EMPACA        ');
    Add('  INNER JOIN CADGRU GR ON GR.GRU_CODGRU     = I.ITE_CODGRU      ');
    Add('  LEFT  JOIN FORTIN    ON FATDOR.FDO_CODACA = FORTIN.FOR_CODACA ');
    Add('                      AND FORTIN.FOR_EMPACA = FATDOR.FDO_EMPACA ');
    Add('  INNER JOIN FATGOR    ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ');
    Add('  LEFT  JOIN EXTGOR    ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
    Add('  LEFT  JOIN EXTDOR    ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ');
    Add('  INNER JOIN ROMGERX R ON R.GER_CODEMP      = FATGOR.FGO_CODEMP ');
    Add('                      AND R.GER_NUMDOC      = FATGOR.FGO_NUMDOC ');
    Add('                      AND R.GER_ESPDOC      = FATGOR.FGO_ESPDOC ');
    Add('                      AND R.GER_CODCLI      = FATGOR.FGO_CODCLI ');

    if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
      Add('  LEFT  JOIN ROMDETX D ON D.DET_AUTINC = FATDOR.AUTOINCREM AND D.DET_SEQGER = R.AUTOINCREM ');

    If (strOrdPdv = '4') or fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica Then
    Begin
      Add('  LEFT JOIN CADLOT ON  FDO_CODITE = LOT_CODITE AND ');
      Add('                       FDO_CODEMP = LOT_CODEMP AND ');
      Add('                       FDO_NUMLOT = LOT_NUMLOT     ');
    End;

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    begin
      Add(' LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LOT_LOCFIS AND CL1.LOC_CODEMP = LOT_CODEMP ');
      Add(' LEFT JOIN CADLOC CL2 ON CL2.LOC_CODLOC = G.ITE_LOCFIS AND CL2.LOC_CODEMP = G.ITE_CODEMP ');
      Add(' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ');
      Add(' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = CL2.LOC_CODLSE ');
    end
    else
      Add('  LEFT  JOIN CADLSE L  ON G.ITE_CODLSE      = L.LSE_CODIGO      ');

    If strOrdPdv = '5' Then
      Add('  LEFT JOIN CADDEP ON DEP_CODIGO = I.ITE_CODDEP');

    Add('WHERE                               ');
    Add('  IFNULL(FDO_ENTFUT,"N")  = "N" AND ');
    Add('  ' + fSQLQtde + ' > FDO_QTDBAI AND ');
    Add('  FDO_JAFATU = 0                AND ');
    Add('  IFNULL(FDO_PROEMB,"N") <> "S" AND ');
    Add('  FDO_CODITE <> :ITESER         AND ');
    Add('  FDO_CODITE <> :SERTER         AND ');

    If FParams.blnExiPedRetiraExpAntFat Then
      Add('  FDO_ENTRET = "R" AND ')

    Else If VS_strExpRetiraEntrega = 'R' Then
      Add('  FDO_ENTRET = "R" AND ')

    Else If VS_strExpRetiraEntrega = 'E' Then
      Add('  FDO_ENTRET = "E" AND ');

    If FParams.blnApenasFaturarJaExpedidos Then
      Add('  FDO_QTDEXP > 0.0000 AND ');

    Add('  R.GER_NUMROM = :NUMROM AND ');
    Add('  R.GER_EMPROM = :CODEMP     ');

    Add('AND (SELECT COUNT(*)');
    Add('       FROM ROMDETX');
    Add('      INNER JOIN ROMGERX ON DET_SEQGER = ROMGERX.AUTOINCREM');
    Add('     WHERE DET_AUTINC = FATDOR.AUTOINCREM');
    Add('       AND GER_NUMROM = R.GER_NUMROM');
    Add('       AND GER_EMPROM = R.GER_EMPROM) > 0');
  End;
End;

procedure TfrmFatExpedicaoRomaneio.pTocarAlertaSonoro(blnAchou: Boolean);
  Var
    strCfgSis,
    strEmbUn : String;
    strPathSom : String;
begin
  strEmbUn := fCodBarEmbUn;

  If (Not blnAchou) Or (fEmptyStr(strEmbUn)) Then
    strCfgSis := 'ALBINE'
  Else
    strCfgSis := 'ALBSCO';

  strPathSom := fCfgSis(strCfgSis);

  If Not fEmptyStr(strPathSom) Then
    sndPlaySound(PWideChar(strPathSom), 0);
end;


procedure TfrmFatExpedicaoRomaneio.pCarregaItensPedido(blnAgruparProdutos: Boolean = True);
begin

  With qryItens Do
  Begin

    Close;
    SQL.Clear;

    SQL.Add('SELECT                                                                                 ');
    SQL.Add('  FATDOR.*,                                                                            ');
    SQL.Add('  EXTDOR.FDO_ORDITE AS ORDITE,                                                         ');
    SQL.Add('  FATDOR.AUTOINCREM AS FDOINC,                                                         ');
    SQL.Add('  FDO_DESCRI AS DESCRI,                                                                ');
    SQL.Add('  CONCAT(FDO_CODITE, "-", FDO_DESCRI) AS DESITE,                                       ');
    SQL.Add('  FDO_DESCRI AS DESCRI,                                                                ');
    SQL.Add('  FDO_CODITE AS CODITE,                                                                ');
    SQL.Add('  IF(FDO_CODACA =  "" OR FDO_CODACA IS NULL, " ", FDO_CODACA) AS CODACA,               ');
    SQL.Add('  IF(FDO_EMPACA =  "" OR FDO_EMPACA IS NULL, " ", FDO_EMPACA) AS EMPACA,               ');
    SQL.Add('  IF(FDO_EMPPRD =  "" OR FDO_EMPPRD IS NULL, " ", FDO_EMPPRD) AS EMPPRD,               ');
    SQL.Add('  IF(FDO_IDEPRO =  "" OR FDO_IDEPRO IS NULL, " ", FDO_IDEPRO) AS IDEPRO,               ');
    SQL.Add('  IF(FDO_ENTFUT =  "" OR FDO_ENTFUT IS NULL, " ", FDO_ENTFUT) AS ENTFUT,               ');
    SQL.Add('  IF(FDO_MOTFUT =  "" OR FDO_MOTFUT IS NULL, " ", FDO_MOTFUT) AS MOTFUT,               ');
    SQL.Add('  IF(FDO_ENTRET =  "" OR FDO_ENTRET IS NULL, " ", FDO_ENTRET) AS ENTRET,               ');
    SQL.Add('  GR.GRU_CODGRU AS CODGRU,                                                             ');
    SQL.Add('  FDO_NUMDOC AS NUMDOC,                                                                ');

    if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
      SQL.Add('  SUM(DET_QTDITE) AS QTDITE, ')
    else
      SQL.Add('  SUM(' + fSQLQtde('', fCfgSis('RMPDPA', varBoolean)) + ' - FDO_QTDBAI) AS QTDITE,     ');

    SQL.Add('  SUM(' + fSQLQtde + ') AS QTDTOT,                                                     ');

    SQL.Add('  SUM(FDO_QTDITE) AS QTDORI,                                                           ');
    SQL.Add('  SUM(FDO_QTDBAI) AS QTDBAI,                                                           ');
    SQL.Add('  SUM(FDO_DESESP) AS DESESP,                                                           ');
    SQL.Add('  SUM(FDO_DESBAI) AS DESBAI,                                                           ');
    SQL.Add('  UNI_SIGUNI AS UNIDAD,                                                                ');

    If Not FParams.blnCarregarQtdExpedida Then
      SQL.Add('  0.0000 AS QTDEXP, ')
    Else
    if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
      SQL.Add('  SUM(IFNULL(DET_QTDEXP,0))  AS QTDEXP, ')
    Else
      SQL.Add('  SUM(IFNULL(FDO_QTDEXP,0))  AS QTDEXP, ');

    SQL.Add('  0 AS LIMPOU,                                         ');

    SQL.Add('  IFNULL((SELECT SUM(RDG_QTDITE)                       ');
    SQL.Add('          FROM ROMDIG                                  ');
    SQL.Add('          WHERE RDG_NUMROM = R.GER_NUMROM              ');
    SQL.Add('            AND RDG_CODEMP = R.GER_EMPROM              ');
    SQL.Add('            AND RDG_CODITE = FDO_CODITE),0) AS CONCOL, ');

    //Somente deve expedir a quantidade que foi separada quando rotina WMS
    If fUsaRotinaWMS Then
      SQL.Add(' SUM((SELECT SUM(LDO_QTDITE) FROM LOTDOR WHERE LDO_SEQFDO = FATDOR.AUTOINCREM)) AS QTDSEP,');

    SQL.Add('  (SUM(FDO_TOTCUS) / SUM(' + fSQLQtde + ')) AS VALCUS,                                 ');
    SQL.Add('  (SUM(FDO_TOTCU2) / SUM(' + fSQLQtde + ')) AS VALCU2,                                 ');
    SQL.Add('  G.ITE_SALDOS AS SALEST,                                                              ');
    SQL.Add('  EXTDOR.FDO_FRERAT AS FRERAT,                                                         ');
    SQL.Add('  FATDOR.AUTOINCREM AS AUTOINCREM,                                                     ');
    SQL.Add('  FATDOR.FDO_SEQGER AS SEQGER,                                                         ');
    SQL.Add('  IF(LEFT(FDO_CLAFIS, 1) < "5", "E", "S") AS ENTSAI,                                   ');
    SQL.Add('  FDO_IDEPRO AS IDEPRO,                                                                ');

    If (fCfgSis('EXPTIN') = '1') Then
      SQL.Add('  IF(FDO_CODACA IS NOT NULL AND FDO_CODACA <> "", ACA_CODBAR, I.ITE_CODBAR) AS CODBAR, ')
    Else
    Begin
      SQL.Add('  I.ITE_CODBAR AS CODBAR,                                                            ');
      SQL.Add('  ACA_CODBAR   AS CODBAT,                                                            ');
    End;

    SQL.Add('  "B" AS TIPBUS,                                                                       ');
    SQL.Add('  FDO_NUMDOC AS NUMDOC,                                                                ');
    SQL.Add('  FDO_ESPDOC AS ESPDOC,                                                                ');
    SQL.Add('  FDO_CODEMP AS CODEMP,                                                                ');

    SQL.Add('  (SELECT GROUP_CONCAT(CONCAT("-", BAR_CODBAR, "-")) FROM                              ');
    SQL.Add('   ITEBAR WHERE I.ITE_CODITE = BAR_CODITE) AS BAREMB,                                  ');

    SQL.Add('  I.ITE_EMBALA AS EMBALA,                                                              ');
    SQL.Add('  I.ITE_MLTVEN AS MLTVEN,                                                              ');
    SQL.Add('  FGO_ENT_CD AS ENT_CD,                                                                ');
    SQL.Add('  IFNULL(FGO_EMP_CD, ' + QuotedStr(fCfgSis('EMP_CD')) + ') AS EMP_CD,                  ');
    SQL.Add('  FGO_OPRFLJ AS OPRFLJ,                                                                ');
    SQL.Add('  FGO_TIPFIN AS TIPFIN,                                                                ');
    SQL.Add('  FGO_DESFIN AS DESFIN,                                                                ');

    SQL.Add('  FGO_VPAR01 AS VPAR01, ');
    SQL.Add('  FGO_VPAR02 AS VPAR02, ');
    SQL.Add('  FGO_VPAR03 AS VPAR03, ');
    SQL.Add('  FGO_VPAR04 AS VPAR04, ');
    SQL.Add('  FGO_VPAR05 AS VPAR05, ');
    SQL.Add('  FGO_VPAR06 AS VPAR06, ');
    SQL.Add('  FGO_VPAR07 AS VPAR07, ');
    SQL.Add('  FGO_VPAR08 AS VPAR08, ');
    SQL.Add('  FGO_VPAR09 AS VPAR09, ');
    SQL.Add('  FGO_VPAR10 AS VPAR10, ');
    SQL.Add('  FGO_VPAR11 AS VPAR11, ');
    SQL.Add('  FGO_VPAR12 AS VPAR12, ');

    SQL.Add('  ITE_PREULT AS PREULT, ');
    SQL.Add('  ITE_IMPULT AS IMPULT, ');

    If strOrdPdv = '4' Then
      SQL.Add('  IFNULL(IF(IFNULL(FDO_NUMLOT, "") = "", G.ITE_LOCFIS, LOT_LOCFIS), " ") AS LOCFIS,');

    If strOrdPdv = '5' Then
      SQL.Add('  DEP_DESCRI,');

    SQL.Add('  IF(FORTIN.FOR_EMPACA = "" OR FORTIN.FOR_EMPACA IS NULL, " ", FORTIN.FOR_EMPACA) FOR_EMPACA, ');
    SQL.Add('  IF(FORTIN.FOR_MODDIL = "" OR FORTIN.FOR_MODDIL IS NULL, 0,   FORTIN.FOR_MODDIL) FOR_MODDIL, ');
    SQL.Add('  IF(FORTIN.FOR_TEXBAS = "" OR FORTIN.FOR_TEXBAS IS NULL, " ", FORTIN.FOR_TEXBAS) FOR_TEXBAS, ');
    SQL.Add('  IF(FORTIN.FOR_TIPCOR = "" OR FORTIN.FOR_TIPCOR IS NULL, " ", FORTIN.FOR_TIPCOR) FOR_TIPCOR, ');
    SQL.Add('  IF(FORTIN.FOR_ITECOB = "" OR FORTIN.FOR_ITECOB IS NULL, " ", FORTIN.FOR_ITECOB) FOR_ITECOB, ');
    SQL.Add('  IF(FORTIN.FOR_CODACA = "" OR FORTIN.FOR_CODACA IS NULL, " ", FORTIN.FOR_CODACA) FOR_CODACA, ');
    SQL.Add('  IF(FORTIN.FOR_CATALI = "" OR FORTIN.FOR_CATALI IS NULL, " ", FORTIN.FOR_CATALI) FOR_CATALI, ');
    SQL.Add('  IF(IFNULL(FDO_INCFUT,"") = "", "", FDO_INCFUT) AS FDO_INCFUT, ');

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      SQL.Add('   IF(IFNULL(FDO_NUMLOT, "") = "", LS2.LSE_CODIGO, LS1.LSE_CODIGO) AS ITE_CODLSE, ')
    else
      SQL.Add('  G.ITE_CODLSE, ');

    SQL.Add('  FDO_NUMLOT AS NUMLOT, ');
    SQL.Add('  FDO_SEPEXP    ');

    pSqlFrom(qryItens.SQL);

    SQL.Add(' GROUP BY ');

    If blnAgruparProdutos Then
    Begin
      SQL.Add('   FDO_CODITE, ITE_CODLSE, FDO_IDEPRO, FDO_DESCRI, FDO_NUMLOT, ');
      SQL.Add('   UNI_SIGUNI, FDO_CODACA, FDO_EMPACA, FDO_PROACA, FDO_ITETIN  ');
    End
    Else
      SQL.Add('   FATDOR.AUTOINCREM ');

    SQL.Add(' ORDER BY ');
    SQL.Add('   FDO_DESCRI ');

    ParamByName('ITESER').AsString  := fCfgSis('ITESER');
    ParamByName('SERTER').AsString  := fCfgSis('SERTER');
    ParamByName('EMPITE').AsString  := VS_strCodEmp;
    ParamByName('NUMROM').AsString  := FParams.strNumRom;
    ParamByName('CODEMP').AsString  := VS_strCodEmp;
    Open;

    pSetaClient(qryItens);

  End;

  If Assigned(FParams.cdsItens) Then
    FreeAndNil(FParams.cdsItens);

  FParams.cdsItens := fCriaClientDatset(qryItens);

  dtsItens.DataSet := cdsItens;

  cdsItens.Close;
  cdsItens.Open;

  (cdsItens.FieldByName('SALEST') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (cdsItens.FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (cdsItens.FieldByName('QTDEXP') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

  pCarregaSaldosColorantes;

  cdsItens.OnFilterRecord := pOnFilter;
  cdsItens.AfterScroll    := pAfterScroll;

  //Se nao existir a dll da tinta especifica entao nao deixa expedir;
  If blnFecharForm Then
    Exit;

  blnFecharForm := cdsItens.IsEmpty;
  blnExpedido   := False;

  If (blnFecharForm) Then
    fMensagem('ATENÇÃO!', 'Não há itens neste pedido!', ['&Ok']);

end;

procedure TfrmFatExpedicaoRomaneio.pCarregaSaldosColorantes;
  Var
    matrizSaldosAux: TClassMatrizSaldosColorantes;
    qryIte: TUniQuery;
    blnLocFor: Boolean;
Begin
  Try
    qryIte := fCriaQuery;
    With qryIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT      ');
      SQL.Add('  FATDOR.*, ');
      SQL.Add('  IFNULL(FORTIN.FOR_EMPACA, " ") FOR_EMPACA, ');
      SQL.Add('  IFNULL(FORTIN.FOR_MODDIL, 0)   FOR_MODDIL, ');
      SQL.Add('  IFNULL(FORTIN.FOR_TEXBAS, " ") FOR_TEXBAS, ');
      SQL.Add('  IFNULL(FORTIN.FOR_TIPCOR, " ") FOR_TIPCOR, ');
      SQL.Add('  IFNULL(FORTIN.FOR_ITECOB, " ") FOR_ITECOB, ');
      SQL.Add('  IFNULL(FORTIN.FOR_CODACA, " ") FOR_CODACA, ');
      SQL.Add('  IFNULL(FORTIN.FOR_UNIVER, " ")  FOR_UNIVER, ');
      SQL.Add('  IFNULL(FORTIN.FOR_CATALI, " ")  FOR_CATALI  ');
      pSqlFrom(qryIte.SQL);
      ParamByName('ITESER').AsString  := fCfgSis('ITESER');
      ParamByName('SERTER').AsString  := fCfgSis('SERTER');
      ParamByName('EMPITE').AsString  := VS_strCodEmp;
      ParamByName('NUMROM').AsString  := FParams.strNumRom;
      ParamByName('CODEMP').AsString  := VS_strCodEmp;
      Open;
    End;

    With qryIte Do
    Begin
      First;
      While Not Eof Do
      Begin
        If FieldByName('FDO_IDEPRO').AsString <> 'NOR' Then
        Begin

          If (Not IsTintaExistente(FieldByName('FDO_IDEPRO').AsString)) Then
          Begin
            blnFecharForm := True;
            FreeAndNil(qryIte);
            Exit;
          End;

          matrizSaldosAux := fDesfragmentaTintaSaldosOR(qryIte, blnLocFor);
          matrizSaldosAux.pZerarQuantidadeFormulacao;

          If Not blnLocFor then
          Begin
            FreeAndNil(qryIte);
            Exit;
          End;

          fatVenEst.dicFormulas.AdicionarObjeto(FieldByName('AUTOINCREM').AsString, matrizSaldosAux);

        End;

        Next;
      End;

      First;
    End;

    FreeAndNil(qryIte);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'pCarregaSaldosColorantes');
    End;
  End;

End;

procedure TfrmFatExpedicaoRomaneio.pChamarTelaDeImpressaoDeSeparacao(blnReimpressao: Boolean);
begin
  Try
    pCriarFormularios(TfrmFatExpConsultaPD, frmFatExpConsultaPD);
    frmFatExpConsultaPD.Caption           := IIF(blnReimpressao, 'Reimprimir', 'Imprimir') + ' Separação';
    frmFatExpConsultaPD.strNumRom         := FParams.strNumRom;
    frmFatExpConsultaPD.blnFiltrarPorItem := False;
    frmFatExpConsultaPD.blnReimpressao    := blnReimpressao;
    frmFatExpConsultaPD.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatExpedicaoRomaneio.pChamarTelaDeImpressaoDeSeparacao]');
  End;
  pFreeAndNil(frmFatExpConsultaPD);
end;

procedure TfrmFatExpedicaoRomaneio.FormShow(Sender: TObject);
begin
  inherited;

  pOnShow;
end;

function TfrmFatExpedicaoRomaneio.fConfirmaExpedicaoGravando(pgbStatus: TcxProgressBar): Boolean;
var
  objSeparacaoFina : TSeparacaoFina;
begin
  Result := True;
  objSeparacaoFina := TSeparacaoFina.Create(tdsRomaneio, VS_strCodEmp);
  objSeparacaoFina.strNumeroDocumento := FParams.strNumRom;
  if objSeparacaoFina.fSeparacaoCompletaColetor and (Not fPedidoExpedido) then
  begin
    TfrmGravando(pgbStatus.Parent).lblGravando.Caption := 'Aguarde, confirmando expedição...';
    Application.ProcessMessages;
    pConfirmaExpedicao(objSeparacaoFina);
  end;
end;

procedure TfrmFatExpedicaoRomaneio.pAbreItens;
begin

  cdsSelecao.EmptyDataSet;
  cdsSelecao.Filter   := '';
  cdsSelecao.Filtered := FALSE;
  pCarregaItensPedido;

  pFiltraFatGor(FParams.strNumRom, VS_strCodEmp, '');

  If fCfgSis('QTDEXP',varBoolean) Then
  Begin
    If (not fFindColumnByName(dbgItens,'QTDITE').Visible) Then
      fFindColumnByName(dbgItens,'DESITE').Width   := fFindColumnByName(dbgItens,'DESITE').Width - fFindColumnByName(dbgItens,'QTDITE').Width;

    fFindColumnByName(dbgItens,'QTDITE').Visible := True;
  End
  Else
    fFindColumnByName(dbgItens,'QTDITE').Visible := False;

  {**********************************}
  { EXIBI SALDO DO ESTOQUE           }
  {*******************************JB*}
  If fCfgSis('EXISEE',varBoolean) Then
  Begin
    If (not fFindColumnByName(dbgItens,'SALEST').Visible) Then
      fFindColumnByName(dbgItens,'DESITE').Width   := fFindColumnByName(dbgItens,'DESITE').Width - fFindColumnByName(dbgItens,'SALEST').Width;

    fFindColumnByName(dbgItens,'SALEST').Visible := True;
  End
  Else
    fFindColumnByName(dbgItens,'SALEST').Visible := False;

  pOrdenarItens;
  cdsItens.First;

end;

procedure TfrmFatExpedicaoRomaneio.FormPaint(Sender: TObject);
begin
  inherited;
  If (blnFecharForm) Then
    Close;
end;

procedure TfrmFatExpedicaoRomaneio.pEdtCodIteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_RETURN) Then
    pExpedeItem;
end;

procedure TfrmFatExpedicaoRomaneio.FormActivate(Sender: TObject);
begin
  inherited;

  If VS_strTipDEx = '1' Then
    edtCodIte.OnKeyDown := pEdtCodIteKeyDown;

end;

procedure TfrmFatExpedicaoRomaneio.btnReimpSepClick(Sender: TObject);
begin
  inherited;

  If Not btnReimpSep.Visible Then
    Exit;

  If (Not fTodosItensConferidos) Then
  Begin
    fMensagem('Atenção', 'Você só pode reimprimir a separação após todos os itens estarem conferidos!', ['&Ok']);
  End
  Else
  Begin
    pChamarTelaDeImpressaoDeSeparacao(True);
    pCarregaItensPedido;
    pOrdenarItens;
    pHabilitaCampos;
  End;

  If (cdsItens.IsEmpty) Then
    Close;
end;
procedure TfrmFatExpedicaoRomaneio.btnConfirmaClick(Sender: TObject);
begin
  pConfirmaExpedicao;
end;

procedure TfrmFatExpedicaoRomaneio.pConfirmaExpedicao(objSeparacaoFina : TSeparacaoFina = nil);
  Var
    fatVenda      : TFatVenda;
    objEmiNFEsp   : TEmissaoNotaEspecial;

    intCodCli,
    intFatGor,
    intContador,
    intContador2,
    intConEma,
    intIndice,
    intQtdTraTmp,
    intIdxPed     : Integer;

    fltDesCon,
    fltTotIteTmp,
    fltDesConTmp,
    fltTotDup,
    fltQtdExp     : Double;

    blnGravou,
    blnDesmembrarVenda,
    blnDeletouItens,
    blnSolicitouTelaSepOpeExp,
    blnConfirma   : Boolean;

    strCodIte,
    strNumPok,
    strPedSit,
    strObsExp,
    strIteBon,
    strEspFat,
    strInformacao,
    strItensTravarIF,
    strIteErroSep,
    strCodItens : String;

    stlItensNaoExp,
    stlPedVal     : TStringList;
    dtaDtaBas     : TDate;

    strDocEma: String;
    strDocume: String;
    strTipoPedido: string;
    blnAlterouVolumes: Boolean;

    LblnUtilizarDataEmissaoCalcularDiaVencimento: boolean;

    procedure pAtualizaNumFatPedidosRomaneio;
      Var
        qryUpdate: TUniQuery;
    begin
      qryFatGor.First;
      While Not qryFatGor.EOF Do
      Begin
        qryUpdate := fCriaQuery;

        qryUpdate.SQL.Clear;
        qryUpdate.SQL.Add('UPDATE ');
        qryUpdate.SQL.Add('  ROMGERX ');
        qryUpdate.SQL.Add('SET ');
        qryUpdate.SQL.Add('  GER_DTAFAT = :DTAFAT, ');
        qryUpdate.SQL.Add('  GER_NUMFAT = :NUMFAT, ');
        qryUpdate.SQL.Add('  GER_TIPFAT = :TIPFAT, ');
        qryUpdate.SQL.Add('  GER_VENFAT = :VENFAT, ');
        qryUpdate.SQL.Add('  GER_CNDFAT = :CNDFAT, ');
        qryUpdate.SQL.Add('  GER_EMPFAT = :EMPFAT, ');
        qryUpdate.SQL.Add('  /* TEMP */ ');
        qryUpdate.SQL.Add('  GER_JAFATU = 1 ');
        qryUpdate.SQL.Add('WHERE ');
        qryUpdate.SQL.Add('  GER_NUMROM = :NUMROM AND ');
        qryUpdate.SQL.Add('  GER_EMPROM = :EMPROM AND ');
        qryUpdate.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
        qryUpdate.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
        qryUpdate.SQL.Add('  GER_CODEMP = :EMPDOC     ');

        qryUpdate.ParamByName('DTAFAT').AsDateTime := VS_Date;
        qryUpdate.ParamByName('NUMROM').AsString   := FParams.strNumRom;
        qryUpdate.ParamByName('EMPROM').AsString   := VS_strCodEmp;
        qryUpdate.ParamByName('NUMFAT').AsString   := fatVenda.strNumDoc;
        qryUpdate.ParamByName('TIPFAT').AsString   := fatVenda.strEspDoc;
        qryUpdate.ParamByName('VENFAT').AsString   := fatVenda.strCodVen;
        qryUpdate.ParamByName('CNDFAT').AsString   := fatVenda.strConPag;
        qryUpdate.ParamByName('NUMDOC').AsString   := qryFatGor.FieldByName('FGO_NUMDOC').AsString;
        qryUpdate.ParamByName('ESPDOC').AsString   := qryFatGor.FieldByName('FGO_ESPDOC').AsString;
        qryUpdate.ParamByName('EMPDOC').AsString   := qryFatGor.FieldByName('FGO_CODEMP').AsString;
        qryUpdate.ParamByName('EMPFAT').AsString   := fatVenda.strEmpDoc;

        qryUpdate.ExecSQL;

        qryUpdate.SQL.Text := AnsiReplaceStr(qryUpdate.SQL.Text, 'GER_','DET_');
        qryUpdate.SQL.Text := AnsiReplaceStr(qryUpdate.SQL.Text, 'ROMGERX','ROMDETX');

        if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
          qryUpdate.SQL.Text := AnsiReplaceStr(qryUpdate.SQL.Text, '/* TEMP */', 'DET_QTDBAI = DET_QTDITE,');

        qryUpdate.ExecSQL;

        FreeAndNil(qryUpdate);

        qryFatGor.Next;
      End;
    end;

    procedure pAtualizarTaxaJuros;
       function fRetTaxJurPd: Double;
       begin
         Result := 0;
         If (qryFatGor.FindField('FGO_TAXJUR') <> Nil) And (qryFatGor.FindField('FGO_TAXJUR').AsFloat > 0) Then
           Result := qryFatGor.FindField('FGO_TAXJUR').AsFloat;
       end;
    begin
      fatVenda.blnDeCndF := (fCfgSis('CNDVEN') = 'F');
      If fatVenda.blnTaxVpr Then
      Begin
        fatVenda.pCalculaTaxVpr;

        If (fatVenda.blnBaiEntFut) Then
        Begin
          If (fRetTaxJurPd > 0) Then
            fatVenda.fltTaxVpr := fRetTaxJurPd
          Else If (fatVenda.fTaxJurMatrizItens > 0) Then
            fatVenda.fltTaxVpr := fatVenda.fTaxJurMatrizItens;
        End;
      End;
    end;

    procedure pDeletaItensNaoExp;
    begin

      If (stlItensNaoExp.Count > 0) Then
      Begin

        While Not cdsVenda.Eof Do
        Begin
          If stlItensNaoExp.IndexOf(cdsVenda.FieldByName('AUTOINCREM').AsString) >= 0 Then
            cdsVenda.Delete;
          cdsVenda.Next;
        End;

        pAtualizaTemporaria(fatVenda);
      End;
    end;

    procedure pGravarArquivos;
    begin
      Try
        pCriarFormularios(TfrmGravando,frmGravando);
        frmGravando.strChave := 'FATVENDAS';
        frmGravando.fExecutarAcao := fatVenda.fGravaArquivosDesmembrandoVenda;
        frmGravando.ShowModal;

        blnGravou := frmGravando.blnConfirma;
        If (frmGravando.blnConfirma) Then
          Self.Close;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message,'[btnConfirmaClick - frmGravando]');
        End;
      End;
      pFreeAndNil(frmGravando);
    end;

    function fValidaQuantidadeSeparadaWMS: Boolean;
    begin
      Result := True;
      cdsItens.First;
      strIteErroSep := '';

      While (Not cdsItens.Eof) Do
      Begin

        If (fFormataFloat(cdsItens.FieldByName('QTDSEP').AsFloat, 2) <>
            fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, 2)) Then
        Begin
          Result := False;

          If Not fEmptyStr(strIteErroSep) Then
            strIteErroSep := strIteErroSep + ', ';

          strIteErroSep := strIteErroSep + cdsItens.FieldByName('CODITE').AsString;
        End;

        cdsItens.Next;
      End;

      cdsItens.First;
    end;

    function fGetTotalParcelasPedido: Double;
      Var
        intContador: Integer;
    begin
      Result := 0;
      For intContador := 0 To 23 Do
        Result := Result + fatVenda.arrDuplicataCND[intContador].curValor;
    End;

begin
  blnSolicitouTelaSepOpeExp := False;

  pWriteLogFile('Pressiou o botão [F10] na tela de expedicao itens');

  pWriteLogFile('Chamou o método inherited');

  inherited;

  pWriteLogFile('verificou se o botao esta habilitido');

  If (Not btnConfirma.Enabled) Then
    Exit;

  pWriteLogFile('Criou a lista de pedidos stlPedVal');

  stlPedVal := TStringList.Create;
  stlPedVal.Clear;
  stlPedVal.Sorted := True;

  pWriteLogFile('Desabilitou os controles do cdsItens');

  blnConfirma := True;
  FParams.blnExpPar := False;
  cdsItens.DisableControls;
  cdsItens.First;

  edtCodIte.Enabled     := False;
  edtQtdIte.Enabled     := False;
  btnConfirma.Enabled   := False;
  btnExpAut.Enabled     := btnConfirma.Enabled;
  btnQuantidade.Enabled := False;

  strCodIte := '';

  pWriteLogFile('Vai processar os itens para adicionar na lista stlPedVal');

  fltQtdExp := 0;
  While (Not cdsItens.Eof) Do
  Begin
    fltQtdExp := fltQtdExp + cdsItens.FieldByName('QTDEXP').AsFloat;

    If (cdsItens.FieldByName('DESFIN').AsFloat > 0) And
       (cdsItens.FieldByName('TIPFIN').AsString = 'V') And
       (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, 2)  <>
        fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, 2)) And
       (Not stlPedVal.Find(cdsItens.FieldByName('NUMDOC').AsString, intIndice)) Then
    Begin
      stlPedVal.Add(cdsItens.FieldByName('NUMDOC').AsString);
    End;

    cdsItens.Next;
  End;

  pWriteLogFile('Vai processar novamente os itens verificando a quantidade expedida');

  cdsItens.First;
  While (Not cdsItens.Eof) Do
  Begin

    If (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, 2)  <>
        fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, 2)) Then
    Begin
      blnConfirma := False;
      Break;
    End;

    strCodIte := strCodIte + '(ITE_CODITE = ' + cdsItens.FieldByName('CODITE').AsString + ') ';

    If (cdsItens.RecNo < cdsItens.RecordCount) Then
    Begin
      strCodIte := strCodIte + ' OR ';
    End;

    cdsItens.Next;
  End;

  pWriteLogFile('Habilitou novamente os controles do cdsItens');

  cdsItens.First;
  cdsItens.EnableControls;

  pWriteLogFile('Vai verificar o tipo de expedicao utilizada e se permite parcial');

  If (Not blnConfirma) Then
  Begin
    pWriteLogFile('Entrou no tipo de expedicao diferente de 2');

    If (Not fCfgExpedicaoParcialHabilitada) Or (Pos(FParams.VS_strTipExpInterna, '2_') > 0) Then
    Begin

      if objSeparacaoFina = nil then
      begin
        If (Pos(FParams.VS_strTipExpInterna, '2_') > 0) Then
          fMensagem('', 'O documento não está completo! Por favor, verifique.', ['&Ok'])
        Else
          fMensagem('', 'O pedido não está completo! Por favor, verifique.', ['&Ok']);
      end;

    End
    Else
    Begin
      if objSeparacaoFina = nil then
      begin
        If stlPedVal.Count > 0 Then
        Begin
          blnConfirma := False;
          fMensagem('', 'Há pedido(s) (' + stlPedVal.CommaText + ') com Desconto Financeiro em Valor e não pode(m) ser faturado(s) parcialmente!', ['&Ok']);
        End

        Else
        Begin
          blnConfirma := (fMensagem('ATENÇÃO!', 'O pedido não está completo! Deseja continuar?', ['&Sim', '&Não']) = 1);
          blnConfirma := fPermiteExpedicaoParcial(blnConfirma, '_3_4', EmptyStr, EmptyStr, EmptyStr);
        End;
      end
      else
       blnConfirma := false;
    End;
  End;

  pWriteLogFile('Limpou e destruiu a lista stlPedVal');

  stlPedVal.Clear;
  FreeAndNil(stlPedVal);

  If (blnConfirma) And (Not fUsaRotinaWMS) Then
  Begin
    cdsItens.First;
    While (Not cdsItens.Eof) Do
    Begin
      If Not fPermitirFaturarComLoteADefinir(
           cdsItens.FieldByName('NUMDOC').AsString,
           cdsItens.FieldByName('ESPDOC').AsString,
           cdsItens.FieldByName('CODEMP').AsString) Then
      Begin
        blnConfirma := False;
        Break;
      End;

      cdsItens.Next;
    End;
  End;

  pWriteLogFile('Vai verificar se tem algum item com localização de separação não preenchida');

  If blnConfirma And fCfgSis('SEPSET', varBoolean) And (fCfgSis('GRUSEP', varString) = 'S') And fTemCodLseNaoPreenchido(strCodItens) Then
  Begin
    blnConfirma := False;
    if objSeparacaoFina = nil then
      fMensagem('', 'Há produto(s) com a Localização da Separação não preenchida. ' + #13#10 +
                    'Atualize o(s) iten(s) ' + strCodItens + ' antes de expedir!', ['&Ok']);
  End;

  //Somente deve expedir a quantidade que foi separada quando rotina WMS
  If blnConfirma And fUsaRotinaWMS And Not fValidaQuantidadeSeparadaWMS Then
  Begin
    blnConfirma := False;
    if objSeparacaoFina = nil then
      fMensagem('', 'Há produtos com a quantidade expedida diferente da ' + #13#10 +
                    'quantidade separada! Por favor, verifique.' + #13#10 +
                    'Produtos: ' + strIteErroSep + '.', ['&Ok']);
  End;

  If (Not blnConfirma) Then
  Begin
    pWriteLogFile('verificou que a blnConfirma esta falsa e vai habilitar os campos');

    pHabilitaCampos;
    Exit;
  End;

  strNumPok := '';
  strPedSit := '';
  strDocEma := '';
  setLength(arrDocume, 0);

  If (FParams.VS_strTipExpInterna = '5') Then
  Begin
    pWriteLogFile('verificou que o tipo de expedicao esta 4');
    pWriteLogFile('Vai chamar a funcao fExpedePedido');

    If (Not fExpedePedido(objSeparacaoFina)) Then
      pHabilitaCampos
    Else
    Begin
      For  intConEma := Low(ArrDocume) To High(ArrDocume) Do
      Begin
        strDocume := arrDocume[intConEma].strNumDoc + arrDocume[intConEma].strEspDoc + arrDocume[intConEma].strCodEmp + arrDocume[intConEma].strCliFor;

        If (Pos(strDocume, strDocEma) <= 0) Then
        Begin
          fDisparaWhatsappAutomatico(arrDocume[intConEma].strNumDoc, 'E5',ArrDocume[intConEma].strEspDoc, '', 'CF', '', ArrDocume[intConEma].strCliFor, '', True, '', Nil, '', '', '', Self.UnitName);
          fDisparaEmailAutomatico(arrDocume[intConEma].strNumDoc, 'E5',ArrDocume[intConEma].strEspDoc, '', 'CF', '', ArrDocume[intConEma].strCliFor);
          fDisparaSMSAutomatico(arrDocume[intConEma].strNumDoc, 'E5',ArrDocume[intConEma].strEspDoc, '', 'CF', '', ArrDocume[intConEma].strCliFor);
          strDocEma := strDocEma + ';' + strDocume;
        End;
      End;

      if (objSeparacaoFina = nil) then
        pInicializaTela
      else
        pAbreItens;

    End;

    pWriteLogFile('Vai sair fora do evento do botao [F10] com um exit');

    Exit;
  End
  Else
  Begin
    stlCodCli.Clear;
    stlCodCli.Sorted := True;
    stlCodCli.Duplicates := dupIgnore;

    cdsItens.First;
    While (Not cdsItens.Eof) Do
    Begin
      stlCodCli.Add(cdsItens.FieldByName('FDO_CODCLI').AsString);
      cdsItens.Next;
    End;
  End;

  Try
    VS_blnUsaPonImp := True;

    cdsItens.OnFilterRecord := nil;
    strTipoPedido := '';

    For intCodCli := 0 To stlCodCli.Count-1 Do
    Begin
      stlFatGor.Clear;
      stlFatGor.Sorted := True;
      stlFatGor.Duplicates := dupIgnore;

      {*********************************}
      {* CARREGA OS PEDIDOS DO CLIENTE *}
      {******************************JC*}
      pFiltraFatGor(FParams.strNumRom, VS_strCodEmp, stlCodCli[intCodCli], '');

      qryFatGor.First;

      While Not qryFatGor.EOF Do
      Begin
        stlFatGor.Add(qryFatGor.FieldByName('FGO_SEQFGO').AsString);
        qryFatGor.Next;
      End;

      For intFatGor := 0 To stlFatGor.Count-1 Do
      Begin
        With cdsItens Do
        Begin
          Filtered := False;
          Filter   := 'FDO_SEQGER = ' + QuotedStr(stlFatGor[intFatGor]);
          Filtered := True;
        End;

        If Not cdsItens.IsEmpty Then
        Begin

          pCriarCdsVenda(Self);
          fatVenda := TFatVenda.CreateInstance('CP');
          try
            fatVenda.objExpedicao := Self.FParams;
            fatVenda.objExpedicao.blnExpParcial := False;
            cdsItens.First;
            While (Not cdsItens.Eof) Do
            Begin
              If (fRetFatorExped <> 1) Then
              Begin
                fatVenda.objExpedicao.blnExpParcial := True;
                Break
              End;

              cdsItens.Next;
            End;
            cdsItens.First;

            {*************************************************************************}
            {* SE FOR PEDIDO DE BAIXA DE ENTREGA FUTURA, DEVE BAIXAR A QTD. ENTREGUE *}
            {* E BAIXAR OS DOCUMENTOS DE ENTREGA FUTURA CORRESPONDENTES              *}
            {**********************************************************************MM*}
            If Not fEmptyStr(cdsItens.FieldByName('FDO_INCFUT').AsString) Then
            Begin
              fatVenda.strOpcDocTrue := 'BF';
              fatVenda.blnBaiEntFut  := TRUE;

              If fRetItensBaixaEntFut(stlFatGor[intFatGor]) Then
              Begin
                fatVenda.cdsBaiEntFut := fCriaClientDatset(cdsBaiFut);
                If fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) Then
                Begin
                  fatVenda.pInformaQtdItemExpParcial(cdsItens);
                  cdsItens.First;
                End;
              End;
            End
            Else
              fatVenda.strOpcDocTrue := 'EI';

            fatVenda.blnExpedi     := True;
            fatVenda.blnVerEstOrc  := False;
            pAtualizaTemporaria(fatVenda);
            fatVenda.strNomeForm   := 'frmFatVendas';

            fatVenda.blnImprimeSep := fCfgSis('SEPAUT', varBoolean);

            fatVenda.fltDesEsp := 0.0;
            fatVenda.fltDupRec := 0.0;
            fatVenda.fltValAdt := 0.0;
            FillChar(fatVenda.recValAdt, SizeOf(fatVenda.recValAdt), #0);

            fatVenda.fltValMor := fCfgSis('TAXDIA', varDouble);

            fatVenda.strPedExp := '';

            fatVenda.strOpeExp := strLoginUsuarioLogado;
            fatVenda.strSepExp := '';

            intQtdTraTmp := 0;
            blnAlterouVolumes := False;

            pFiltraFatGor('', '', '', cdsItens.FieldByName('SEQGER').AsString);

            With qryFatGor Do
            Begin
              If Not IsEmpty Then
              Begin
                fatVenda.strNumOrc := FieldByName('FGO_NUMDOC').AsString;
                fatVenda.strEspOrc := FieldByName('FGO_ESPDOC').AsString;
                fatVenda.strEmpOri := FieldByName('FGO_CODEMP').AsString;

                fatVenda.strPedExp := fatVenda.strPedExp + FieldByName('FGO_NUMDOC').AsString + ', ';
                fatVenda.strEmpOriPed := FieldByName('FGO_CODEMP').AsString;

                If (fatVenda.blnBaiEntFut) Then
                Begin
                  fatVenda.dicDesEspItens := TDicionario.Create;
                  fatVenda.dicDesEspItens.Limpar;
                End;

                {**************************************************************************************************}
                {* FUNÇÃO pCarregaDadosCliente TEM QUE ESTAR ANTES DE pCarregaPedidoOrcamento, POIS, A FUNÇÃO     *}
                {* fCalculaAliquota CONTIDA DENTRO DO MESMO, USA A UF DO CLIENTE PARA EFETUAR O CALCULO DO ICMS E *}
                {* QUE É GRAVADO DET_ICMSAI DA MOVTRI USADO NO CALCULO DE MARGEM REQ.: 125427                     *}
                {************************************************************************************************VA}
                FParams.strNumDoc := fatVenda.strNumOrc;
                FParams.strCodEmp := fatVenda.strEmpOri;

                pCarregarCliente(fatVenda, fltQtdExp);

                Try
                  fatVenda.pCarregaPedidoOrcamento(qryFatGor, blnDeletouItens, nil, '', True, FParams.strNumRom);
                Except
                  On E: ExceptionAutcom Do
                  Begin
                    pMensagemOK(E.Message);
                    Exit;
                  End;

                  On E: Exception Do
                  Begin
                    pMensagensErro(E.Message, '[btnConfirma.pCarregaPedidoOrcamento]');
                    Exit;
                  End;
                End;

                if fatVenda.blnFecharForm then
                begin
                  pHabilitaCampos;
                  Exit;
                end;

                //verifica se o volume foi alterado pelo botão [F12] Digitar Volumes
                If fEstaNaLista(stlVolumesAlterados,
                                Concat(FieldByName('FGO_NUMDOC').AsString, '-',
                                       FieldByName('FGO_ESPDOC').AsString, '-',
                                       FieldByName('FGO_CODEMP').AsString)) Then
                  blnAlterouVolumes := True;

                If (Not fatVenda.blnBaiEntFut) Then
                  fatVenda.fltDesEsp := fatVenda.fltDesEsp + FieldByName('FGO_DESESP').AsFloat;

                fatVenda.fltDupRec := fatVenda.fltDupRec + fatVenda.fTotalDuplicataQuitada(FieldByName('FGO_NUMDOC').AsString,
                                                                                           FieldByName('FGO_ESPDOC').AsString,
                                                                                           FieldByName('FGO_CODEMP').AsString);

                fatVenda.recValAdt := TAdiantamento.fGetTotaisAdiantamento(FieldByName('FGO_NUMDOC').AsString,
                                                                           FieldByName('FGO_ESPDOC').AsString,
                                                                           FieldByName('FGO_CODEMP').AsString);

                fatVenda.fltValAdt := fatVenda.fltValAdt + fatVenda.recValAdt.fltValLan;

                {*************************************************************}
                { ALIMENTA PROPRIEDADE fatvenda.strDocsConfPD PARA UTILIZAÇÃO }
                { NA "CONFIGURAÇÃO DA NOTA FISCAL ELETRÔNICA                  }
                {*********************************************************RL**}
                fatVenda.pAddDocsConfPD(FieldByName('FGO_NUMDOC').AsString + '-' +
                                        FieldByName('FGO_ESPDOC').AsString + '-' +
                                        FieldByName('FGO_CODEMP').AsString + ',');

                fatVenda.pAddRotasConfPD(fRetRotasPorPedido(FieldByName('FGO_NUMDOC').AsString,
                                                            FieldByName('FGO_ESPDOC').AsString,
                                                            FieldByName('FGO_CODEMP').AsString));

                fatVenda.pAddRegioesConfPD(fRetRegioesPorPedido(FieldByName('FGO_NUMDOC').AsString,
                                                                FieldByName('FGO_ESPDOC').AsString,
                                                                FieldByName('FGO_CODEMP').AsString));

                If fEmptyStr(strNumPok) Then
                  strNumPok := fatVenda.strNumPok;

                If fEmptyStr(strPedSit) Then
                  strPedSit := fatVenda.strPedSit;

                intQtdTraTmp := intQtdTraTmp + fatVenda.intQtdTra;
              End;
            End;

            fatVenda.intQtdTra := intQtdTraTmp;
            If (Not fCfgSis('VOLEXP', VarBoolean)) Then
              If fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) Then
                fatVenda.intQtdTra := Floor(fatVenda.fRetVolumes);

            If fEmptyStr(fatVenda.strEspTra) Then
              fatVenda.strEspTra := fCfgSis('ESPTRA');

            fatVenda.strPedExp := LeftStr(fatVenda.strPedExp, length(fatVenda.strPedExp) -2);

            fatVenda.strNumPok := strNumPok;
            fatVenda.strPedSit := strPedSit;

            pCarregaDescontoEspecialPedidosExpedidos(fatVenda);
          
            If (fatVenda.fZerarDesEsp) Then
              fatVenda.fltDesEsp := 0.0;

            {*****************************************}
            {* VALIDA FORMA DE PAGAMENTO CARREGADA   *}
            {**************************************IV*}
            If (fCfgSis('USAFPG', varBoolean)) And
               (fRetornaStatusCadastro(fatVenda.strCodFpg, 'FPG', 'CADFPG', 'FPG_CODIGO') <> 'A') Then
            Begin
              If fEmptyStr(fatVenda.strCodFpg) Then
                fMensagem('ATENÇÃO!', 'A Forma de Pagamento deve ser informada! Favor verificar.', ['&Ok']);

              pHabilitaCampos;
              Exit;
            End;

            fatVenda.strNumOrc := '';
            fatVenda.strEspOrc := '';
            fatVenda.strEmpOri := '';

            {*******************************************************}
            {* ATUALIZA O DOCUMENTO DE ENTREGA FUTURA DOS PRODUTOS *}
            {***************************************************JC**}
            fatVenda.pAtualizaDocumentoEntregaFutura;

            Try
              fatVenda.pPreencheMatrizFechamento;
            Except

              On E: ExceptionAutCom Do
              Begin
                pHabilitaCampos;
                fMensagem('', E.Message, ['&O K']);
                Exit;
              End;

              On E: Exception Do
              Begin
                pHabilitaCampos;
                pMensagensErro(E.Message, 'frmFatExpedicaoItens.btnConfirmaClick');
                Exit;
              End;
            End;

            fatVenda.fltTotCus := 0;

            If fRateiaFreteItensTransportadora(fatVenda.strCodTra, fatVenda.strTipFre) Then
            Begin
              fatVenda.fltFreDig := 0;
              fatVenda.fltValFre := 0;
              fatVenda.fltFreRat := 0;
            End;

            For intContador := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
            Begin
              cdsItens.First;
              If Not cdsItens.Locate('AUTOINCREM', fatVenda.arrMatItens[intContador].strSeqDet, []) Then
              Begin
                fatVenda.arrMatItens[intContador].fltQtdIte := 0;
                Continue;
              End;

              If (fRetFatorExped <> 1) Then
              Begin
                If (fatVenda.blnBaiEntFut) Then
                Begin
                  fatVenda.dicDesEspItens[fatVenda.arrMatItens[intContador].intAutInc.ToString] :=
                        fFormataFloat(fatVenda.dicDesEspItens[fatVenda.arrMatItens[intContador].intAutInc.ToString] * fRetFatorExped, 2);
                End;
                fatVenda.arrMatItens[intContador].fltDesEsp := fatVenda.arrMatItens[intContador].fltDesEsp * fRetFatorExped;
                fatVenda.arrMatItens[intContador].fltPesoIt := fatVenda.arrMatItens[intContador].fltPesoIt * fRetFatorExped;
                fatVenda.arrMatItens[intContador].fltPesLiq := fatVenda.arrMatItens[intContador].fltPesLiq * fRetFatorExped;
              End;

              fatVenda.arrMatItens[intContador].strTipBus := cdsItens.FieldByName('TIPBUS').AsString;

              fatVenda.arrMatItens[intContador].strNumOrc := qryFatGor.FieldByName('FGO_NUMDOC').AsString;
              fatVenda.arrMatItens[intContador].strEspOrc := qryFatGor.FieldByName('FGO_ESPDOC').AsString;
              fatVenda.arrMatItens[intContador].strEmpOrc := qryFatGor.FieldByName('FGO_CODEMP').AsString;

              If (fatVenda.strOpcDocTrue = 'BF') Then
              Begin
                fatVenda.arrMatItens[intContador].fltPreCus := cdsItens.FieldByName('VALCUS').AsFloat;
                fatVenda.arrMatItens[intContador].fltTotCus := cdsItens.FieldByName('VALCUS').AsFloat * fatVenda.arrMatItens[intContador].fltQtdIte;

                fatVenda.arrMatItens[intContador].fltPreCu2 := cdsItens.FieldByName('VALCU2').AsFloat;
                fatVenda.arrMatItens[intContador].fltTotCu2 := cdsItens.FieldByName('VALCU2').AsFloat * fatVenda.arrMatItens[intContador].fltQtdIte;
              End;

              If fRateiaFreteItensTransportadora(fatVenda.strCodTra, fatVenda.strTipFre) Then
              Begin
                fatVenda.arrMatItens[intContador].fltFreRat := 0.00;
                fatVenda.fltFreDig := fatVenda.fltFreDig + cdsItens.FieldByName('FRERAT').AsFloat / cdsItens.FieldByName('QTDTOT').AsFloat * cdsItens.FieldByName('QTDEXP').AsFloat;
                fatVenda.fltValFre := fatVenda.fltValFre + cdsItens.FieldByName('FRERAT').AsFloat / cdsItens.FieldByName('QTDTOT').AsFloat * cdsItens.FieldByName('QTDEXP').AsFloat;
              End;

              fatVenda.arrMatItens[intContador].fltTotUlt :=
                IfThen((fatVenda.arrMatItens[intContador].strIdePro = 'NOR') And (Not fatVenda.arrMatItens[intContador].blnProAca), cdsItens.FieldByName('PREULT').AsFloat * fatVenda.arrMatItens[intContador].fltQtdIte, fatVenda.arrMatItens[intContador].fltTotUlt);

              fatVenda.arrMatItens[intContador].fltImpUlt :=
                IfThen((fatVenda.arrMatItens[intContador].strIdePro = 'NOR') And (Not fatVenda.arrMatItens[intContador].blnProAca), cdsItens.FieldByName('IMPULT').AsFloat, fatVenda.arrMatItens[intContador].fltImpUlt);

              fatVenda.arrMatItens[intContador].fltTotImp :=
                IfThen((fatVenda.arrMatItens[intContador].strIdePro = 'NOR') And (Not fatVenda.arrMatItens[intContador].blnProAca), cdsItens.FieldByName('IMPULT').AsFloat, fatVenda.arrMatItens[intContador].fltImpUlt) * fatVenda.arrMatItens[intContador].fltQtdIte;

              fatVenda.fltTotCus := fatVenda.fltTotCus + fatVenda.arrMatItens[intContador].fltTotCus;

              {*****************************************}
              {* APLICA O DESCONTO EM %                *}
              {**************************************MV*}
              fltDesCon := qryFatGor.FieldByName('FGO_DESCON').AsFloat;

              {***********************************************************************************************}
              {* COMENTADO ESSE IF POIS QUANDO ESTAVA APLICANDO ACRÉSCIMO NO PEDIDO, OU SEJA, FGO_PORDES < 0 *}
              {* NO MOMENTO DE FATURAR O PEDIDO NÃO ERA APLICADO O ACRÉSCIMO NO DOCUMENTO DE VENDA, DEIXANDO *}
              {* O DOCUMENTO DE VENDA COM VALOR MENOR QUE O DO PEDIDO. COMENTADO A PEDIDO DO RONALDO.        *}
              {********************************************************************************03/02/2014**PZ*}
              //If (fltDesCon <= 0) THen
              //  fltDesCon := 0;

              {***********************************************************************************************}
              {* COMENTADO POIS ESSE CÁLCULO DA PORDES ANTES DA CALCULATOTGER DA DIFERENÇA DE CENTAVOS QUANDO*}
              {* EXISTE DESCONTO TAMBÉM DA CONDIÇÃO DE PAGAMENTO, QUE É APLICADA DENTRO DA CALCULATOTGER PELA*}
              {* pAplicaDescontoCondicaoUnitario PORTANTO PASSEI A ALIMENTAR A .fltPorDesExp COM O PORDES DE *}
              {* CADA PEDIDO E ESSE É APLICADO CORRETAMENTE DENTRO DA CALCULATOTGER NA SEQUÊNCIA CORRETA     *)  
              {********************************************************************************************VA*}
              //fatVenda.fltPorDes := fltDesCon;
              //fatVenda.pCalcPorDes(fatVenda.arrMatItens[intContador], fltTotIteTmp, fltDesConTmp);
              //fatVenda.arrMatItens[intContador].fltUniTmp := fatVenda.arrMatItens[intContador].fltUniTar;

              If fatVenda.blnBaiEntFut Then
                fatVenda.arrMatItens[intContador].fltPorDesExp := fRetPorDesPeloAutIncFdo(fatVenda.arrMatItens[intContador].strSeqDet) 
              Else   
                fatVenda.arrMatItens[intContador].fltPorDesExp := fltDesCon;

              fatVenda.arrMatItens[intContador].strTipFin := cdsItens.FieldByName('TIPFIN').AsString;
              fatVenda.arrMatItens[intContador].fltDesFin := cdsItens.FieldByName('DESFIN').AsFloat;

              fatVenda.fltPorDes := 0;
            End;

            If Length(fatVenda.arrMatItens) = 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Não há nenhum produto para ser expedido! Favor verificar.', ['&Ok']);
              pHabilitaCampos;
              Exit;
            End;

            If fatVenda.fUltrapassouLimiteItensNFe(strInformacao) Then
            Begin
              pMensagemSonora(strInformacao);
              pHabilitaCampos;
              Exit;
            End;

            pAtualizarTaxaJuros;

            If (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_CP_') > 0) And (fCfgSis('TAXENT', varBoolean)) Then
            Begin
              fatVenda.blnAplicaTaxaEntrega := True;
              fatVenda.pAtualizaValorTaxaEntrega;
            End;

            pCalculaPesoBrutoLiqExpedicao(fatVenda);

            fatVenda.pCalculaTotGer(False, False);

            If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
            Begin
              If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
                fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
            End;

            fatVenda.pDestacaRetencoes;
            fatVenda.pRetemImpostosNoDescontoEspecial;

            fatVenda.pCalculaTotGer(False, False);

            {*************************************************}
            {* VERIFICA SE OS PRODUTOS PODEM SER BONIFICADOS *}
            {**********************************************MM*}
            If Not fatVenda.fValidouItensBonificados Then
            Begin
              pHabilitaCampos;
              Exit;
            End;

            {*******************************************}
            {* DEFINE A ESPÉCIE DE ACORDO COM O TIPO   *}
            {* DO PEDIDO                               *}
            {****************************************MV*}
            If ((fatVenda.strEspOrc = 'PD') And (fatVenda.strOpcDoc = 'VN')) Or
               ((Not fEmptyStr(fatVenda.strOpeExp)) And (fatVenda.strOpcDoc = 'CP')) Then
            Begin

              if (fCfgSis('TPDCEX') = '2') and (Not fEmptyStr(strTipoPedido)) and
                 (fEmptyStr(fatVenda.strTipPed)) and fCfgSis('APPEPD', varBoolean) then
                fatVenda.strTipPed := strTipoPedido;

              If ((FParams.VS_strTipExpInterna = '3') And (fCfgSis('TPDCEX') = '1')) And (fEmptyStr(fatVenda.strTipPed)) Then
              Begin
                fMensagem('ATENÇÃO!', 'O tipo do pedido não está preenchido! Favor verificar.', ['&Ok']);
                Exit;
              End
              Else
              Begin

                If ((FParams.VS_strTipExpInterna = '3') And (fCfgSis('TPDCEX') = '2')) And
                   (fEmptyStr(fatVenda.strTipPed)) And (Not fEmptyStr(fatVenda.strOpeExp)) Then
                Begin

                  Try
                    pCriarFormularios(TfrmFatTipoExpedicao, frmFatTipoExpedicao);
                    frmFatTipoExpedicao.fatVenda := fatVenda;
                    frmFatTipoExpedicao.ShowModal;
                    blnConfirma := frmFatTipoExpedicao.blnConfirma;

                    strTipoPedido := fatVenda.strTipPed;
                  Except
                    On E: Exception Do
                    Begin
                      blnConfirma := False;
                      pMensagensErro(E.Message, '[TFatVenda.fGravaArquivos]');
                    End;
                  End;

                  pFreeAndNil(frmFatTipoExpedicao);

                  If Not blnConfirma Then
                  Begin
                    fMensagem('ATENÇÃO!', 'O tipo do pedido não está preenchido! Favor verificar.', ['&Ok']);
                    pHabilitaCampos;
                    Exit;
                  End;

                End;

              End;

              fatVenda.pDefineTipoFaturamentoExpedicao;
            End;

            fatVenda.pPreparaParaEmitirMeiaNotaNotaNormal;

            {********************************************}
            {* VALIDAÇÃO DE ITENS AGROTOXICOS EM CUPOM  *}
            {*****************************************IV*}
            If (fatVenda.strEspDoc = 'IF'        ) And
               (fCfgSis('RECGRO', varBoolean)    ) And
               (fVerificaItemAgrotoxico(fatVenda)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é permitido emitir Cupom Fiscal' + #13#10 +
                                    'em venda com produtos que sejam agrotóxicos!', ['&O k']);
              pHabilitaCampos;
              pSetFocus(edtCodIte);
              Exit;
            End;

            If (fatVenda.strEspDoc = 'IF') And
               (fCfgSis('PAFECF', varBoolean)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é permitido emitir Cupom Fiscal' + #13#10 +
                                    'quando configurado para PAF-ECF. Use o PDVCitel!', ['&O k']);
              pHabilitaCampos;
              pSetFocus(edtCodIte);
              Exit;
            End;

            If fatVenda.strEspDoc = 'IF' Then
            Begin
              strItensTravarIF := '';
              if not fCfgSis('USNFCE', varBoolean) then
              begin
                For intContador := 0 To Length(fatVenda.arrMatItens)-1 Do
                Begin
                  If fFormataFloat(fatVenda.arrMatItens[intContador].fltQtdIte, 3) > fFormataFloat(MAX_QUANTIDADE_CUPOM,3) Then
                  Begin
                    strItensTravarIF := strItensTravarIF + fatVenda.arrMatItens[intContador].strDesIte + #13#10;
                  End;
                End;
              end;

              If Not fEmptyStr(strItensTravarIF) Then
              Begin
                Try
                  pCriarFormularios(TfrmObservacao, frmObservacao);
                  frmObservacao.lblMensagem.Caption := 'Itens com quantidade acima de ' + FloatToStrF(MAX_QUANTIDADE_CUPOM, ffNumber, 12, 3) + ':';
                  frmObservacao.memObs.Texto := strItensTravarIF;
                  frmObservacao.ShowModal;
                  FreeAndNil(frmObservacao);
                Except
                  On E: Exception Do
                  Begin
                    pMensagensErro(E.Message, '[TfrmObservacao_ItensIF]');
                  End;
                End;

                pHabilitaCampos;
                pSetFocus(edtCodIte);
                Exit;
              End;
            End;

            If fVerificaSeImpNFAvulsa(fatVenda.strEspDoc, teNaoPermite) Then
            Begin
              pHabilitaCampos;
              pSetFocus(edtCodIte);
              Exit;
            End;

            If Pos(fatVenda.strEspDoc, 'MI_FF_') > 0 Then
            Begin
              If (Not fatVenda.fPermiteEmissaoFFPeloTipoDePedido) Then
              Begin
                pHabilitaCampos;
                pSetFocus(edtCodIte);
                Exit;
              End;
            End;

            If Not fatVenda.fDadosCorretosParaClienteConsumidor(fatVenda.strEspDoc) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é permitido emitir Nota Fiscal sem preencher todos os dados do cliente.', ['&Ok']);
              pHabilitaCampos;
              pSetFocus(edtCodIte);
              Exit;
            End;

            blnDesmembrarVenda := fatVenda.fHaveraDesmembramentoVenda(fatVenda.arrMatItens);

            If (Not blnDesmembrarVenda) And (fatVenda.strEspDoc = 'IF') And fCfgSis('FRECUP', VarBoolean) Then
            Begin
              fatVenda.pInsereItemFreteNoCupomFiscal;
            End;

            fatVenda.pAplicarFreteComoAcrescimoNFCe;

            fatVenda.pCalculaTotGer;
            fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

            fatVenda.pPreencherMsgDadosAdicBaixaEntFutNF;

            If Not fPermiteEmitirCupom(fatVenda) Then
              Exit;

            if (fatVenda.strEspDoc = 'IF') then
            begin
              If fatVenda.fPossuiBrindeProduto Then
              begin
                fMensagem('ATENÇÃO!', 'Não é permitido emitir cupom fiscal para produto de brinde.', ['&Ok']);
                Exit;
              end
            end;

            If (fatVenda.fItensObrNfe) Then
              Exit;

            {*****************************************}
            {* SE NÃO FOR ACEITO MI FORA DO ESTADO   *}
            {**************************************MV*}
            If (Not fCfgSis('MIFEST', varBoolean)) And (FParams.VS_strTipExpInterna = '3') And (Pos(fatVenda.strEspDoc, 'MI_FF') > 0) Then
            Begin

              If (fatVenda.fTrocaUFEndEntrega <> fCadEmp('ESTADO')) And (fVerificaSituacaoTributaria(fatVenda)) Then
              Begin
                fMensagem('ATENÇÃO!', 'Não é permitido confirmar ' + fatVenda.strEspDoc +'  com produto que ' +
                                      'tenha substituição tributária para cliente fora do estado!', ['&O k']);
                pHabilitaCampos;
                Exit;
              End;

            End;

            {*********************************************************}
            {* CASO SEJA NOTA FISCAL, CHAMA A TELA DOS DADOS FISCAIS *}
            {******************************************************LU*}
            If (fatVenda.strTipPed = 'A') And (fCfgSis('ADIEXP') = 'S') Then
            Begin
              Try
                pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
                try
                  frmFatDadosFiscais.fatVenda := fatVenda;
                  frmFatDadosFiscais.blnExpedicao := True;
                  frmFatDadosFiscais.showModal;
                  blnConfirma := frmFatDadosFiscais.blnConfirma;
                finally
                  pFreeAndNil(frmFatDadosFiscais);
                end;
              Except
                On E: Exception Do
                Begin
                  pMensagensErro(E.Message, '[btnConfirmaClick_DadosFiscais]');
                End;
              End;

            End
            Else
            Begin
              blnConfirma := True;

              If (fatVenda.strTipPed = 'A') And (fatVenda.fZerarIcmsNotaTransferenciaEstadosEspecificos(fatVenda.strClaFis)) Then
                fatVenda.pZerarIcmsNotaTransferenciaEstadosEspecificos;
            End;

            if (blnConfirma) and (fatVenda.strTipPed = 'A') And (fatVenda.strEspDoc = 'NF') and (not fEmptyStr(fatVenda.strCodTra)) and (fCfgSis('UTICTE', varBoolean))
               and (fCampoTabela('TRA_CONHAB', 'CADTRA', ['TRA_CODTRA'], [fatVenda.strCodTra]) = 'S') then
            begin
              try
                blnConfirma := TfrmFatDadosCTe.Exibir(fatVenda);
              except
                On E: Exception do
                begin
                  blnConfirma := False;
                  pMensagensErro(E.Message, '[btnConfirmaClick_CTe]');
                end;
              end;
            end
            else
              fatVenda.objDadosCte.blnGrava := False;

            If fRateiaFreteItensTransportadora(fatVenda.strCodTra, fatVenda.strTipFre) And (fatVenda.fltValFre > 0) Then
            Begin
              fatVenda.fltFreRat := fatVenda.fltValFre;
              fatVenda.fltValFre := 0.00;
              fatVenda.fltFreDig := 0.00;

              fatVenda.pCalculaTotGer;
            End;

            blnConfirma := blnConfirma And fatVenda.fSolicitaDataHoraEntradaSaidaNotaFiscal;

            If blnConfirma Then
            Begin
              If fatVenda.fPedidoAPrazoComEntradaQuitada(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                                         qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                                         qryFatGor.FieldByName('FGO_CODEMP').AsString,
                                                         fatVenda.FConPag) Then
              Begin
                fatVenda.pAlteraCondicaoPagamentoRemovendoEntrada(fatVenda.FConPag);
              End;

              {*********************************************************************************}
              {* CASO FOR UM PEDIDO GERADO PELO F11 COM MODALIDADE "013-UTILIZACAO DE CREDITO" *}
              {* E "015-A RECEBER", ENTAO DEVE ALTERAR A FORMA DE PAGAMENTO DE 009 PARA 015    *}
              {* PARA GERAR O CONTAS A RECEBER A VISTA EM ABERTO                               *}
              {*****************************************************************************JC**}
              If fatVenda.fPedidoRecebidoModalidadesCreditoeAReceberF11(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                                                        qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                                                        qryFatGor.FieldByName('FGO_CODEMP').AsString) Then
              Begin
                fatVenda.strCodFpg := '015';
                fatVenda.strDesFpg := fRetDesFpg('015');
              End;

              fatVenda.pCalculaTotalParaCadRec;

              dtaDtaBas := VS_Date;

              LblnUtilizarDataEmissaoCalcularDiaVencimento := fatVenda.fUtilizarDataEmissaoCalcularDiaVencimento ;
              {***************************************************************************************}
              {* UTILIZA A DATA DA EMISSÃO DO PEDIDO COMO BASE PARA CALCULO DA CONDIÇÃO DE PAGAMENTO *}
              {************************************************************************************PZ*}
              If (fUtilizarComoDataBaseCtrDataEmissaoPedido(fatVenda.fFaturandoPedido, LblnUtilizarDataEmissaoCalcularDiaVencimento)) Then
              Begin
                {**********************************************************************************************}
                {* CASO O PEDIDO ESTEJA SENDO FATURADO ANTECIPADAMENTE À DATA DE PREVISÃO, UTILIZAR ESSA DATA *}
                {* PARA REMONTAR A CONDIÇÃO DE PAGAMENTO                                                      *}
                {*******************************************************************************************KM*}
                If (fUtilizarComoDataBaseCtrDataPrevisaoPedido(fatVenda.fFaturandoPedido)) And (fatVenda.dtaPreVis <> 0) And (VS_Date < fatVenda.dtaPreVis) Then
                  dtaDtaBas := fatVenda.dtaPreVis
                Else
                  dtaDtaBas := fatVenda.dtaDtaEntOri;
              End;

              fltTotDup := fatVenda.fltTotCadRec - fatVenda.fltValAdt;
              If (fltTotDup < 0) And (fatVenda.fltValAdt <> 0) Then
                fltTotDup := 0;

              fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fltTotDup,
                                                       FAlse, False, False, dtaDtaBas, False, fatVenda.fltImpFre, 'N', fCfgSis('DUPRED', varBoolean),
                                                       False, 0, False, Nil, '', True, True, Nil, '', False, True, '', '', Nil, fatVenda.fFaturandoPedido,
                                                       False, Nil, False, False, 0, '', fatVenda.strCodCid,
                                                       '', False, LblnUtilizarDataEmissaoCalcularDiaVencimento);

              fatVenda.strConPag := fRetornaCndPag(fatVenda.arrDuplicata, VS_Date);

              pCarregaDuplicatasCND(1,cdsItens.FieldByName('SEQGER').AsString, fatVenda.arrDuplicataCND);

              If fatVenda.fltValAdt > 0 Then
              Begin
                blnConfirma := fatVenda.fAdicionaAdiantamentoPrimeiraParcela;
                blnManPar   := False;
              End;

              If fFormataFloat(fatVenda.fltTotCadRec, 2) <> fFormataFloat(fGetTotalParcelasPedido, 2) Then
                blnManPar := False;

              If blnManPar And (Not FParams.blnExpPar) Then
              Begin

                For intContador := 0 To 23 Do
                Begin
                  If (fEmptyStr(fatVenda.arrDuplicata[intContador].strSequen)) Then
                    Break;
                  fatVenda.arrDuplicata[intContador].curValor := fatVenda.arrDuplicataCND[intContador].curValor;
                End;

              End;

              fatVenda.pRateiaValores;
            End;

            {*********************************************************************}
            {* SE UTILIZAR LIBERAÇÃO DE PEDIDO E NÃO PERMITIR EXPEDIÇÃO PARCIAL, *}
            {* NÃO DEVE TRAVAR VALOR MÍNIMO NF, POIS ESTA VERIFICAÇÃO TERÁ SIDO  *}
            {* FEITA NA LIBERAÇÃO DO PEDIDO                                      *}
            {******************************************************************MM*}
            If Not (fCfgSis('LIBPED',varBoolean) And (Not fCfgExpedicaoParcialHabilitada)) Then
            Begin
              If (fatVenda.strTipPed = 'A') And blnConfirma And (Not fatVenda.fVerificaValorMinimoEmitirNF) Then
              Begin
                blnConfirma := False;
              End;
            End;

            If blnConfirma Then
            Begin

              {*****************************************}
              {* TRATAMENTO DE PARCELA MÍNIMA PARA NF  *}
              {**************************************MV*}
              If Not fatVenda.fVerificaValorMinimoParcela Then
              Begin
                blnConfirma := False;
              End;

            End;

            If blnConfirma Then
            Begin
              If ((Pos(fatVenda.strEspDoc,'NF_EL_NS_') > 0)) And
                 (fCfgSis('CPFOBR', varBoolean)) Then
              Begin
                If (fEmptyStr(fatVenda.strCliCgc)) Then
                Begin
                  blnConfirma := False;
                  fMensagem('ATENÇÃO!', 'Cliente não possui CPF / CNPJ. Não será permitido emitir '+fDescricaoDocFat(fatVenda.strEspDoc)+'.', ['&Ok']);
                End
                Else If (fReplicatorStr(fatVenda.strCliCgc[1], Length(fatVenda.strCliCgc)) = fatVenda.strCliCgc) And
                (fatVenda.fTrocaUFEndEntrega <> 'EX')Then
                Begin
                  blnConfirma := False;
                  fMensagem('ATENÇÃO!', 'O CPF / CNPJ do cliente não é válido para emitir nota fiscal.', ['&Ok']);
                End;
              End;
            End;

            If (Not fatVenda.fVerificaItemObrigCodIbama) Then
            Begin
              blnConfirma := False;
            End;

            If blnConfirma Then
            Begin
              {***************************************************************************************}
              {* NAO SERA PERMITIDO EMITIR CUPOM PARA CLIENTES FORA DO ESTADO COM INSCRICAO ESTADUAL *}
              {************************************************************************************JC*}
              If (Pos(fatVenda.strEspDoc,'IF_IV_') > 0) And
                 (fatVenda.fTrocaUFEndEntrega <> fCadEmp('ESTADO')) Then
              Begin
                fMensagem('ATENÇÃO!', 'Não é permitido emitir cupom fiscal para clientes fora do estado', ['&Ok']);
                blnConfirma := False;
              End;
            End;

            If Not blnConfirma Then
            Begin
              pHabilitaCampos;
              Exit;
            End;

            blnGravou := False;
            fatVenda.fHaveraDesmembramentoVenda(fatVenda.arrMatItens);
            strEspFat := fatVenda.strEspDoc;

            pGravarArquivos;

            If blnGravou Then
            Begin
              pAtualizaNumFatPedidosRomaneio;
            End;

            {***************************************************************************************}
            {* CASO JA FATUROU OS ITENS EXPEDIDOS, LIMPA A QTD PARA CONTINUAR EXPEDINDO O RESTANTE *}
            {************************************************************************************JC*}
            If blnGravou And FParams.blnApenasFaturarJaExpedidos Then
            Begin
              cdsItens.First;
              While (Not cdsItens.Eof) Do
              Begin
                pAtualizaQtdExpItemPedido(cdsItens.FieldByName('AUTOINCREM').AsString, 0);
                cdsItens.Next;
              End;
            End;

            If blnGravou Then
            Begin
              pVerificarSeClienteTemPontosParaBrindes(fatVenda);
            End;

            {****************************************************}
            {* VERIFICA SE DEVE IMPRIMIR A ETIQUETA DE DESPACHO *}
            {*************************************************MM*}
            If fCfgSis('IMETDE', varBoolean) And blnGravou Then
            Begin
              For intContador := 0 To fatVenda.objFatVendaImp.ItemsCount -1 Do
              Begin
                With fatVenda.objFatVendaImp[intContador] Do
                  If intQtdTra > 0 Then
                    pImprimeEtiquetaDespacho(strNumDoc, strEspDoc, strCodCli, VS_strCodEmp, intQtdTra);
              End;
            End;

            {**************************************}
            {* CASO JA FATUROU OS ITENS EXPEDIDOS *}
            {**********************************JC**}
            If (blnGravou) And fatVenda.fEmiteNotaEspecial(strEspFat) And
               (Not fatVenda.blnMeiaNotaComNotaNormal) Then
            Begin
              objEmiNFEsp := TEmissaoNotaEspecial.Create;
              Try
                For intContador := 0 To fatVenda.objFatVendaImp.ItemsCount -1 Do
                  With fatVenda.objFatVendaImp[intContador] Do
                    objEmiNFEsp.fEmitirNotaEspecial(strNumDoc, strEspDoc, strEmpDoc,
                      fatVenda.strTipFatNEs, fatVenda.fltFatNot, fltPesBru, fltPesLiq,
                      Not blnAlterouVolumes);
              Finally
                objEmiNFEsp.Destroy;
              End;
            End;

            FConfirmou := blnGravou;
          finally
            FreeAndNil(fatVenda);
            pFreeCdsVenda;
          end;

        End; //If Not cdsItens.IsEmpty

      End; //For intFatGor := 0 To stlFatGor.Count-1

    End; //For intCodCli := 0 To stlCodCli.Count-1

  Finally

    VS_strPonImp      := '';
    VS_blnUsaPonImp   := False;

    cdsItens.Filtered := False;
    cdsItens.OnFilterRecord := pOnFilter;

    If Not blnGravou Then
    Begin
      pCarregaItensPedido;
      pHabilitaCampos;
    End;

  End;
end;

procedure TfrmFatExpedicaoRomaneio.pVerificarSeClienteTemPontosParaBrindes(fatVenda: TFatVenda);
  Var
    strNomCli: string;
    blnCliCon : Boolean;
    blnCliBal : Boolean;
begin
  If FParams.blnOndaSeparacao Then
    Exit;

  If FParams.blnFaturandoTodosAutomaticamente Then
    Exit;

  strNomCli := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [fatVenda.strCodCli]);
  blnCliCon := fClienteConsumidor(strNomCli, False, True);
  blnCliBal := fClienteConsumidor(strNomCli, True, False);
  If (Not blnCliCon) And (Not blnCliBal) Then
    pVerificarPromocaoBrindes('','', fatVenda.strCodCli, strNomCli)
  Else
  Begin
    pVerificarPromocaoBrindes(fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strCodCli, strNomCli);
  End;
end;

procedure TfrmFatExpedicaoRomaneio.pVerificarPromocaoBrindes(strNumDoc, strEspDoc, strCodCli, strNomCli: String);
var
  dtaMin, dtaMax: TDateTime;
  blnPedeBrindes,
  blnApenasPromoVigente: Boolean;
  frmFatPromocaoBrindes : TfrmFatPromocaoBrindes;
begin
  blnApenasPromoVigente := (not fCfgSis('PEBRFA', varBoolean));

  If (TPromocaoBrindes.fTemPromocaoDeBrindeEmVigencia) And
     (TFatEmitirBrindePromocao.fClienteTemPontosParaBrindes(
      strCodCli, strNumDoc, strEspDoc, dtaMin, dtaMax, blnApenasPromoVigente)) Then
  Begin
    If fEmptyStr(strNumDoc) Then
      blnPedeBrindes := fPergunta('Cliente possui direito a brinde por pontos acumulados ' +
                                  'por produto vendido. ' +
                                  'Deseja emitir o documento de brinde?')
    Else
      blnPedeBrindes := fPergunta('Cliente possui direito a brinde por pontos acumulados ' +
                                  'por produto vendido (' + strNumDoc + '-' + strEspDoc + '). ' +
                                  'Deseja emitir o documento de brinde?');

    If blnPedeBrindes Then
    Begin
      Try
        Try
          pCriarFormularios(TfrmFatPromocaoBrindes, frmFatPromocaoBrindes);
          frmFatPromocaoBrindes.strOperador    := strLoginUsuarioLogado;
          frmFatPromocaoBrindes.edtCodCli.Text := strCodCli;
          frmFatPromocaoBrindes.edtNomCli.Text := strNomCli;
          frmFatPromocaoBrindes.edtNumDoc.Text := strNumDoc;
          frmFatPromocaoBrindes.edtEspDoc.Text := strEspDoc;
          frmFatPromocaoBrindes.mskDtaIni.Text := DateToStr(dtaMin);
          frmFatPromocaoBrindes.mskDtaFin.Text := DateToStr(dtaMax);
          frmFatPromocaoBrindes.edtCodEmp.Text := VS_strCodEmp;
          frmFatPromocaoBrindes.edtDesEmp.Text := fRetNomeEmpresa;
          frmFatPromocaoBrindes.blnFatVenda    := True;
          frmFatPromocaoBrindes.ShowModal;
        Except
          On E: Exception Do
            pMensagensErro(E.Message, '');
        End;
      Finally
        pFreeAndNil(frmFatPromocaoBrindes);
      End;
    End;
  End;
end;

procedure TfrmFatExpedicaoRomaneio.pAfterScroll(DataSet: TDataSet);
Begin
  If cdsItens.FieldByName('QTDITE').AsFloat = cdsItens.FieldByName('QTDEXP').AsFloat Then
    btnConsPD.Enabled := False
  Else
    btnConsPD.Enabled := True;
End;

procedure TfrmFatExpedicaoRomaneio.pCalculaPesoBrutoLiqExpedicao(fatVenda: TFatVenda);
begin
  fatVenda.pCalculaPesBruLiq;
end;

procedure TfrmFatExpedicaoRomaneio.pCarregarCliente(fatVenda: TFatVenda; fltQtdExp: Double);
Var
  strConAux: string;
  strTipFor: string;
begin
  blnManPar := True;

  fatVenda.strConPag := qryFatGor.FieldByName('FGO_CONPAG').AsString; // Condição de Pagamento
  fatVenda.strCodCnd := qryFatGor.FieldByName('FGO_CODCND').AsString; // Condicao      - Codigo
  fatVenda.strCodFpg := qryFatGor.FieldByName('FGO_CODFPG').AsString; // Código da Forma de Pagamento

  untFuncFat.pCarregarClientePedidoOrcamento(fatVenda, fatVenda.strEmpOri);

  fatVenda.pCarregaAliquotasRetencao;
  fatVenda.pAtualizaClassTransferencias;

  pCarregaDescontoEspecialPedidosExpedidos(fatVenda);

  strTipFor := fRetTipoForaConPag(fatVenda.strCodCnd);

  strConAux := '';

  If (fConPagFora(strTipFor)) And fCfgSis('USACND', VarBoolean) And (Not fEmptyStr(fatVenda.strCodCnd)) Then
  Begin
    strConAux := fRetConPagCodCnd(fatVenda.strCodCnd);
    fatVenda.strConPag := fRetCondicao(fatVenda.fRetConPagRef, fatVenda.dtaUltDtaAlt, fatVenda.strCodCnd, strTipFor, strConAux, 0, '', fatVenda.strCodCid);

    If fatVenda.strConPag <> qryFatGor.FieldByName('FGO_CONPAG').AsString Then
      blnManPar := False;
  End;

  If Not fatVenda.fDocumentoParaFornecedor Then
  Begin
    If (fEmptyStr(strConAux)) And (Pos(strTipFor, 'OUTROS_DIA FIXO_') <= 0) And fCfgSis('USACND', VarBoolean) And (Not fEmptyStr(fatVenda.strCodCnd)) Then
      strConAux := fRetConPagCodCnd(fatVenda.strCodCnd)
    Else
      strConAux := fatVenda.strConPag;

    fatVenda.strConPag := fRetCondicaoDiaFixoCliente(fatVenda.fRetConPagRef, fatVenda.dtaUltDtaAlt, fatVenda.strCodCli, strConAux, 0, '', fatVenda.strCodCid);

    If fatVenda.strConPag <> qryFatGor.FieldByName('FGO_CONPAG').AsString Then
      blnManPar := False;
  End;
end;

procedure TfrmFatExpedicaoRomaneio.pCarregaDescontoEspecialPedidosExpedidos(fatVenda: TFatVenda);
begin
  {*********************************************}
  { CALCULA O DESCONTO ESPECIAL DE ACORDO COM A }
  { QUANTIDADE DE ITENS FALTANTES DO PEDIDO     }
  {******************************************JB*}
  cdsItens.First;
  fatVenda.fltDesEsp := 0;
  While (Not cdsItens.Eof) Do
  Begin
    If fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, 2) > 0 Then
    Begin
      If fRetFatorExped = 1 Then
      Begin
        If (cdsItens.FieldByName('QTDEXP').AsFloat + cdsItens.FieldByName('QTDBAI').AsFloat) =
           (cdsItens.FieldByName('QTDTOT').AsFloat) Then
        Begin
          fatVenda.fltDesEsp := fatVenda.fltDesEsp + cdsItens.FieldByName('DESESP').AsFloat -
                                cdsItens.FieldByName('DESBAI').AsFloat;
        End
        Else
          fatVenda.fltDesEsp := fatVenda.fltDesEsp + ((cdsItens.FieldByName('DESESP').AsFloat /
                                cdsItens.FieldByName('QTDTOT').AsFloat) * cdsItens.FieldByName('QTDEXP').AsFloat);
      End
      Else
      Begin
        fatVenda.fltDesEsp := fatVenda.fltDesEsp + (cdsItens.FieldByName('DESESP').AsFloat * fRetFatorExped);
      End;
    End;
    cdsItens.Next;
  End;

  If (fatVenda.fltDesEsp < 0) Then
    fatVenda.fltDesEsp := 0;

  //Sempre que recalcular o desconto especial devemos formatar com 2 decimais
  fatVenda.fltDesEsp := fFormataFloat(fatVenda.fltDesEsp, 2);
end;

procedure TfrmFatExpedicaoRomaneio.pAtualizaTemporaria(fatVenda: TFatVenda);
begin
  cdsVenda.Filtered := False;
  cdsVenda.Filter := '';
end;

procedure TfrmFatExpedicaoRomaneio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pOnClose;

end;

procedure TfrmFatExpedicaoRomaneio.pOnFilter(DataSet: TDataSet; var Accept: Boolean);
begin
  If (Not fEmptyStr(strCamBus)) Then
  Begin
    If SameText(strCamBus, 'BAREMB') Then
      Accept := Pos('-' + strCodIte + '-', DataSet.FieldByName(strCamBus).AsString) > 0
    Else
      Accept := (DataSet.FieldByName(strCamBus).AsString = strCodIte);
  End;
end;

function TfrmFatExpedicaoRomaneio.fRetItensBaixaEntFut(strSeqFgo: String): Boolean;
begin
  Result := False;

  Try
    With cdsBaiFut.qryQuery, SQL Do
    Begin
      cdsBaiFut.Close;

      Close;
      Clear;
      Add(fRetSQLItensBaixaEntFut);
      ParamByName('SEQFGO').AsString := strSeqFgo;
      cdsBaiFut.pSetProvider;
      Open;
      pSetaClient(cdsBaiFut.qryQuery);
      cdsBaiFut.Open;

      Result := Not cdsBaiFut.IsEmpty;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[fRetItensBaixaEntFut]');
    End;
  End;
end;

function TfrmFatExpedicaoRomaneio.fRetFatorExped: Double;
begin
  Result := 1;

  If fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) Then
    Result := (cdsItens.FieldByName('QTDEXP').AsFloat / cdsItens.FieldByName('QTDORI').AsFloat);
end;

function TfrmFatExpedicaoRomaneio.fRetQtdDigitada(strCodIte: String): Double;
Begin
  Result := 0;
  If (cdsItens.FindFirst) Then
  Begin
    Repeat
      Result := Result + cdsItens.FieldByName('QTDEXP').AsFloat;
    Until (Not cdsItens.FindNext);
  End;
End;

function TfrmFatExpedicaoRomaneio.fCodBarEmbUn: String;
  Var
    qryCodBarIte: TUniQuery;
Begin
  qryCodBarIte := fCriaQuery(Self);
  Try
    With qryCodBarIte, SQL Do
    Begin
      Clear;
      Add(' SELECT ITE_CODBAR, ITE_BAREMB, ITE_CODITE ');
      Add('   FROM CADITE ');
      Add('  WHERE (ITE_CODBAR = :CODBAR) ');
      Add('     OR (ITE_BAREMB = :CODBAR) ');
      Add('     OR (ITE_CODITE = :CODBAR) ');
      ParamByName('CODBAR').AsString := strCodDig;
      Open;

      If (FieldByName('ITE_CODBAR').AsString = strCodDig) Or
         (FieldByName('ITE_CODITE').AsString = strCodDig) Then
        Result := 'UN'
      Else If FieldByName('ITE_BAREMB').AsString = strCodDig Then
        Result := 'EMB'
      Else
        Result := '';

      Close;
    End;
  Finally
    FreeAndNil(qryCodBarIte);
  End;
end;
function TfrmFatExpedicaoRomaneio.fEncontraItem(Var strMensagem: String;
                                                blnAtualizaQtde : Boolean = True): Boolean;
  Var
    fltSaldoItemAtu,
    fltQtdDig,
    fltQtdIte,
    fltEmbala: Double;
    strSemEst: String;
    blnPedSen: Boolean;
    blnSemEst: Boolean;
    recForTin: TForTin;
    blnBaiSubIte: Boolean;
    blnBusNormalOuExp2CodBarCompleta: Boolean;

  function fPedeSenhaMultiploVenda: Boolean;
  begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Item ' + cdsItens.FieldByName('CODITE').AsString   + ' - ' +
                                         LeftStr(cdsItens.FieldByName('DESITE').AsString,50) + ' '   +
                                         'com quantidade fora do Múltiplo de Vendas.');

    objLiberacao.strDirAce := 'SENMTP';
    objLiberacao.strSenLib := fCfgSis('SENMTP');
    objLiberacao.strMsgSen := 'Senha para liberação de venda de item com quantidade fora do múltiplo de venda';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  end;

  function fValidaMultiploVenda(fltQtdExp: Double): Boolean;
    Var
      fltValor: Double;
      fltMltVen: Double;
  begin
    Result := True;
    fltMltVen := cdsItens.FieldByName('MLTVEN').AsFloat;

    If (fltMltVen > 0) Then
    Begin
      If fltQtdExp < fltMltVen Then
      Begin
        If (Pos(fCfgSis('MLTVEN'), '14') > 0) Then // 1-Trava / 4-Solicita Senha
        Begin
          fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(fltMltVen, ffNumber, 12, 3), ['&OK']);

          If (fCfgSis('MLTVEN') = '4') Then // Solicita Senha
            Result := fPedeSenhaMultiploVenda
          Else
            Result := False;
        End
        Else If (fCfgSis('MLTVEN') = '3') Then  // Avisa
          fMensagem('','A quantidade digitada é diferente de um múltiplo de: ' + FloatToStrF(fltMltVen, ffNumber, 12, 3), ['&OK']);
      End
      Else
      Begin
        fltValor := fFormataFloat( fltQtdExp / fltMltVen, 5);

        If (fltValor - Int(fltValor)) > 0 Then
        Begin
          If (Pos(fCfgSis('MLTVEN'), '14') > 0) Then // 1-Trava / 4-Solicita Senha
          Begin
            fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(fltMltVen, ffNumber, 12, 3), ['&OK']);

            If (fCfgSis('MLTVEN') = '4') Then // Solicita Senha
              Result := fPedeSenhaMultiploVenda
            Else
              Result := False;
          End
          Else If (fCfgSis('MLTVEN') = '3') Then // Avisa
            fMensagem('','A quantidade digitada é diferente de um múltiplo de: ' + FloatToStrF(fltMltVen, ffNumber, 12, 3), ['&OK']);
        End;
      End;
    End;
  End;

begin
  cdsItens.First;
  Result    := False;
  fltQtdDig := 0.0;

  If ((FParams.VS_strTipExpInterna = '3') Or (FParams.VS_strTipExpInterna = '5')) Then
    fltQtdDig := fRetQtdDigitada(strCodIte);

  blnBusNormalOuExp2CodBarCompleta:=((Not bln2CodBar) Or (strCamBus = 'CODITE'))
                                 Or (bln2CodBar And (Not fEmptyStr(strCodIteFor)));

  If (cdsItens.FindFirst) Then
  Begin

    Result := True;

    Repeat
      If SameText(strCamBus, 'BAREMB') Then
        fltEmbala := objIteBar.fQuantidadeEmbalagem(cdsItens.FieldByName('CODITE').AsString, strCodDig)
      Else
        fltEmbala := 1;

      fltQtdIte := cdsItens.FieldByName('QTDEXP').AsFloat + fltEmbala * fStrToFloat(edtQtdIte.Text);

      If (cdsItens.FieldByName('QTDITE').AsFloat >= fltQtdIte) Then
      Begin
        If (blnBusNormalOuExp2CodBarCompleta) Then
        Begin
          If fExcedeLimiteItensNFe Then
            blnAtualizaQtde := False

          Else If (FParams.VS_strTipExpInterna = '3') Or (FParams.VS_strTipExpInterna = '5') Then
          Begin
            fatVenEst.strIdePro := cdsItens.FieldByName('IDEPRO').AsString;

            fltSaldoItemAtu := cdsItens.FieldByName('SALEST').AsFloat;

            If fUsaQtdPendenteEntregaFutura Then
              fltSaldoItemAtu := fltSaldoItemAtu + TEntregaFutura.New(
                                                     TParamEF.New()
                                                       .CodIte(cdsItens.FieldByName('CODITE').AsString)
                                                       .CodEmp(VS_strCodEmp)
                                                       .Faturamento(True)
                                                     ).Total();

            If (cdsItens.FieldByName('IDEPRO').AsString <> 'NOR') Then
            Begin
              recForTin.intModDil   := IfNull(cdsItens.FieldByName('FOR_MODDIL').Value, 0);
              recForTin.strTextBase := IfNull(cdsItens.FieldByName('FOR_TEXBAS').Value, '');
              recForTin.strTipCor   := IfNull(cdsItens.FieldByName('FOR_TIPCOR').Value, '');
              recForTin.Formulas    := TClassMatrizSaldosColorantes(fatVenEst.dicFormulas.RetornaObjeto(cdsItens.FieldByName('AUTOINCREM').AsString));
              If cdsItens.FindField('FOR_CATALI') <> Nil Then
                recForTin.strCatali   := IfNull(cdsItens.FieldByName('FOR_CATALI').Value, '');

              If (cdsItens.FieldByName('OPRFLJ').AsString = 'N') And
                 (cdsItens.FieldByName('ENT_CD').AsString = 'S') Then
              Begin
                recforTin.Formulas.fRecalculaSaldos(cdsItens.FieldByName('EMP_CD').AsString, fltQtdIte, FParams.strNumDoc, fUsaRotinaWMS);
              End
              Else
              Begin
                recforTin.Formulas.fRecalculaSaldos(cdsItens.FieldByName('EMPPRD').AsString, fltQtdIte, FParams.strNumDoc, fUsaRotinaWMS);
              End;
            End;

            blnBaiSubIte := (fCfgSis('BXSBIT') <> '1');

            If (fItemEstrutura(cdsItens.FieldByName('CODITE').AsString)) And
               (blnBaiSubIte) And
               (fCfgSis('BXSBIT') = '3') And
               (fatVenEst.fRetornaSaldoDisponivelItemNormal('',
                                                            cdsItens.FieldByName('CODITE').AsString,
                                                            '',
                                                            cdsItens.FieldByName('AUTOINCREM').AsString,
                                                            cdsItens.FieldByName('CODACA').AsString,
                                                            cdsItens.FieldByName('EMPACA').AsString,
                                                            fltSaldoItemAtu,
                                                            False) >= fltQtdIte) Then
            Begin
              blnBaiSubIte := False;
            End;

            If (fItemEstrutura(cdsItens.FieldByName('CODITE').AsString)) And
               (blnBaiSubIte) Then
            Begin
              If (Not fatVenEst.fVerificaQtdEstoqueSubItensEstrutura(fatVenEst.strOpcDoc,
                                                                     cdsItens.FieldByName('CODITE').AsString,
                                                                     cdsItens.FieldByName('AUTOINCREM').AsString,
                                                                     fltQtdIte,
                                                                     True,
                                                                     nil,
                                                                     blnPedSen,
                                                                     False,
                                                                     '',
                                                                     cdsItens.FieldByName('ENTRET').AsString,
                                                                     cdsItens.FieldByName('ENTFUT').AsString,
                                                                     cdsItens.FieldByName('MOTFUT').AsString)) Then
              Begin
                Exit;
              End;
            End

            Else If Not fatVenEst.fVerificaQtdEstoque(VS_strCodEmp,
                                                      'VN',
                                                      'S',  // EntSai
                                                      cdsItens.FieldByName('NUMDOC').AsString,
                                                      cdsItens.FieldByName('AUTOINCREM').AsString,
                                                      cdsItens.FieldByName('CODITE').AsString,
                                                      cdsItens.FieldByName('CODACA').AsString,
                                                      cdsItens.FieldByName('EMPACA').AsString,
                                                      cdsItens.FieldByName('DESCRI').AsString,
                                                      cdsItens.FieldByName('ENTRET').AsString,
                                                      cdsItens.FieldByName('ENTFUT').AsString,
                                                      cdsItens.FieldByName('MOTFUT').AsString,
                                                      fltQtdIte,
                                                      fltQtdDig,
                                                      cdsItens.FieldByName('QTDEXP').AsFloat,//Quantidade Anterior
                                                      fltSaldoItemAtu,
                                                      cdsItens.FieldByName('QTDEXP').AsFloat > 0,//Alterando
                                                      strSemEst,
                                                      TRUE,
                                                      blnPedSen,
                                                      blnSemEst,
                                                      recForTin,
                                                      False,
                                                      '') Then // NUMLOT
              Exit;
          End;

          If blnAtualizaQtde Then
          Begin
            If Not fValidaMultiploVenda(fltEmbala * fStrToFloat(edtQtdIte.Text)) Then
              Exit;

            cdsItens.Edit;
            cdsItens.FieldByName('QTDEXP').AsFloat := cdsItens.FieldByName('QTDEXP').AsFloat +
                                                      fltEmbala * fStrToFloat(edtQtdIte.Text);

            If (strCamBus = 'CODITE') Then
              cdsItens.FieldByName('TIPBUS').AsString := 'C';

            cdsItens.Post;

            blnExpedido := True;
          End;

          edtQtdIte.Text := FloatToStrF(1, ffFixed, 12, intDecQtd);
          strMensagem := '';
          Break;
        End;
      End
      Else
      Begin
        If fltEmbala * fStrToFloat(edtQtdIte.Text) > fStrToFloat(FloatToStrF(1, ffFixed, 12, intDecQtd)) Then
          strMensagem := 'Quantidade (' + FormatFloat('#,##0.00', fltEmbala * fStrToFloat(edtQtdIte.Text)) + ') não permitida para o produto (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ').'
        Else
          strMensagem := 'Produto (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') já foi totalmente expedido!';
      End;

    Until (Not cdsItens.FindNext);

  End;

end;

procedure TfrmFatExpedicaoRomaneio.btnConsPDClick(Sender: TObject);
begin
  inherited;

  If Not btnConsPD.Enabled Then
    Exit;

  If blnExpedido Then
  Begin
    pMensagemOk('As alterações realizadas ainda não foram confirmadas.'+#13+
                'Pressione "[F10] Expedir" para prosseguir!');
    Exit;
  End;

  Try
    pCriarFormularios(TfrmFatExpConsultaPD, frmFatExpConsultaPD);
    frmFatExpConsultaPD.Caption        := 'Consulta Pedidos de Venda';
    frmFatExpConsultaPD.strNumRom      := FParams.strNumRom;
    frmFatExpConsultaPD.edtCodIte.Text := cdsItens.FieldByName('CODITE').AsString;
    frmFatExpConsultaPD.edtDesIte.Text := Copy(cdsItens.FieldByName('DESITE').AsString,7,100);
    frmFatExpConsultaPD.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatExpedicaoRomaneio.btnConsPD]');
  End;

  pFreeAndNil(frmFatExpConsultaPD);

  pCarregaItensPedido;
  pOrdenarItens;
  pHabilitaCampos;

  If (cdsItens.IsEmpty) Then
    Close;
end;

procedure TfrmFatExpedicaoRomaneio.btnDigVolClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmFatExpedicaoRomaneioVolumes, frmFatExpedicaoRomaneioVolumes);
    frmFatExpedicaoRomaneioVolumes.strNumeroRomaneio := Self.FParams.strNumRom;
    frmFatExpedicaoRomaneioVolumes.ShowModal;

    If frmFatExpedicaoRomaneioVolumes.ModalResult = mrOk Then
    Begin
      stlVolumesAlterados.Clear;

      frmFatExpedicaoRomaneioVolumes.cdsPedidos.First;
      While Not frmFatExpedicaoRomaneioVolumes.cdsPedidos.Eof Do
      Begin
        If frmFatExpedicaoRomaneioVolumes.cdsPedidos.FieldByName('VOLUME_ALTERADO').AsInteger = 1 Then
          stlVolumesAlterados.Add(frmFatExpedicaoRomaneioVolumes.cdsPedidos.FieldByName('NUMPED').AsString);

        frmFatExpedicaoRomaneioVolumes.cdsPedidos.Next;
      End;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmFatExpedicaoRomaneioVolumes);
end;

procedure TfrmFatExpedicaoRomaneio.btnExpAutClick(Sender: TObject);
begin
  inherited;

  If (Not btnExpAut.Visible) Or (Not btnExpAut.Enabled) Then
    Exit;

  {*************************************}
  {* VERIFICA SE TEM DIREITO DE ACESSO *}
  {**********************************JB*}
  If Not fVerificaAcessoSistema('EXPAUT', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  btnExpAut.Enabled := FALSE;

  pMarcarTodosProdutos;

  btnConfirma.Click;

  btnExpAut.Enabled := TRUE;
End;

procedure TfrmFatExpedicaoRomaneio.btnFaturaClick(Sender: TObject);
  Var
    strTipExpBkp : String;
begin
  inherited;
  strTipExpBkp        := FParams.VS_strTipExpInterna;
  FParams.VS_strTipExpInterna := '3';

  pCarregaItensPedido(False);

  btnConfirma.Enabled := True;
  btnConfirma.Click;
  btnConfirma.Enabled := False;

  FParams.VS_strTipExpInterna := strTipExpBkp;
end;

procedure TfrmFatExpedicaoRomaneio.pMarcarTodosProdutos;
  var
    intRecNo: Integer;
    fltQtdIte: Double;
    strIndexFieldNames: String;
begin
  If VS_strTipDEx = '1' Then
  Begin
    With cdsItens Do
    Begin
      DisableControls;
      First;
      While Not Eof Do
      Begin
        //Somente deve expedir a quantidade que foi separada quando rotina WMS
        If Not fUsaRotinaWMS Then
          fltQtdIte := cdsItens.FieldByName('QTDITE').AsFloat
        Else
          fltQtdIte := cdsItens.FieldByName('QTDSEP').AsFloat;

        {************************************************************}
        { Se estiver configurado para usar "Liberar somente produtos }
        { com saldo suficiente", então só liberará esses produtos.   }
        {*********************************************************RV*}
        If (fCfgSis('LIBSAL') = 'S') Then
        Begin
          If (FieldByName('SALEST').AsFloat < fltQtdIte) Then
            fltQtdIte := FieldByName('SALEST').AsFloat;

          If fltQtdIte <= 0 Then
          Begin
            Next;
            Continue;
          End;
        End;

        If fExcedeLimiteItensNFe Then
          Break;

        Edit;
        FieldByName('QTDEXP').AsFloat := fltQtdIte;
        Post;

        Next;
      End;
      EnableControls;
    End;
  End
  Else
  Begin
    With cdsItens Do
    Begin
      pOrdenarItens;

      First;
      While Not Eof Do
      Begin
        intRecNo := RecNo;
        strIndexFieldNames := cdsItens.IndexFieldNames;

        //Somente deve expedir a quantidade que foi separada quando rotina WMS
        If Not fUsaRotinaWMS Then
          fltQtdIte := cdsItens.FieldByName('QTDITE').AsFloat
        Else
          fltQtdIte := cdsItens.FieldByName('QTDSEP').AsFloat;

        Try
          If FieldByName('QTDEXP').AsFloat < fltQtdIte Then
          Begin
            If fExcedeLimiteItensNFe Then
              Break;

            edtCodIte.Text := FieldByName('CODITE').AsString;
            edtQtdIte.Text := FloatToStrF(fltQtdIte - FieldByName('QTDEXP').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger));
            pExpedeItem;
          End;
        Finally
          cdsItens.IndexFieldNames := strIndexFieldNames;
          RecNo := intRecNo;
        End;

        Next;
      End;
      EnableControls;
    End;
  End;
end;

procedure TfrmFatExpedicaoRomaneio.dbgItensEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption   := strMsgSel;
end;

procedure TfrmFatExpedicaoRomaneio.dbgItensExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption   := '';
end;

procedure TfrmFatExpedicaoRomaneio.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Var
    strOperador: string;
    blnTemAcessoMarcarTudo: Boolean;
begin
  inherited;
  If ((Key = VK_RETURN) And (VS_strTipDEx = '1')) Or
          ((Key = VK_SPACE ) And (VS_strTipDEx = '2')) Then
  Begin
    pSelecionaItem;
  End
  Else If ((Key = VK_RETURN) And (VS_strTipDEx = '2')) Then
  Begin
    edtCodIte.Text := cdsItens.FieldByName('CODITE').AsString;
    pSetFocus(edtQtdIte);
  End
  Else If (Shift = [ssShift]) and (Key = VK_F5) And lblLimparExpedido.Visible Then
  Begin
    blnTemAcessoMarcarTudo := fVerificaAcessoSistema('EXPMTD', strLoginUsuarioLogado);
    If (blnTemAcessoMarcarTudo) Or
       (ffrmSenha(strOperador)) Then
    Begin
      If (blnTemAcessoMarcarTudo) Or
         (fVerificaAcessoSistema('LIMEXP', fRetCodVendedor(strOperador))) Then
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('QTDEXP').AsFloat := 0;
        cdsItens.FieldByName('LIMPOU').AsInteger := 1;
        cdsItens.Post;
      End
      Else
        fMensagem('', 'Operador informado não possui direitos de acesso para ' + #13#10 +
                      'limpar a quantidade expedida do produto!', ['&Ok']);
    End;
  End;
end;

procedure TfrmFatExpedicaoRomaneio.pSelecionaItem;
Begin
  If Not fSelecionado Then
    pAdicionaItemSelecao
  Else
    pRemoveItemSelecao;

  dbgItens.Repaint;
End;

function TfrmFatExpedicaoRomaneio.fSelecionado: Boolean;
Begin
  If (Assigned(stlItens)) And (Assigned(FParams.cdsItens)) Then
    Result := (stlItens.IndexOf(cdsItens.FieldByName('AUTOINCREM').AsString) > -1)
  Else
    Result := False;
End;

procedure TfrmFatExpedicaoRomaneio.pAdicionaItemSelecao;
Begin
  stlItens.Add(cdsItens.FieldByName('AUTOINCREM').AsString);
End;

procedure TfrmFatExpedicaoRomaneio.pRemoveItemSelecao;
  Var
    objItem : TObject;
    intIndex: Integer;
Begin
  intIndex := stlItens.IndexOf(cdsItens.FieldByName('AUTOINCREM').AsString);
  If intIndex > -1 Then
  Begin
    objItem := stlItens.Objects[intIndex];
    stlItens.Delete(intIndex);
    If Assigned(objItem) Then
      FreeAndNil(objItem);
  End;
End;

procedure TfrmFatExpedicaoRomaneio.FormCreate(Sender: TObject);
Begin
  inherited;
  pSetaCodIte(cdsSelecaoCODITE);
  cdsSelecao.CreateDataSet;
  cdsSelecao.Open;

  pOnCreate;
end;

function TfrmFatExpedicaoRomaneio.fPedidoExpedido(blnVerifSoImpreSep: Boolean=False): Boolean;
  Var
    qryAux: TUniQuery;

    function fExpedicaoIncompletaOuSeparacaoNaoImpressa: Boolean;
    begin
      If blnVerifSoImpreSep Then
        Result := (cdsItens.FieldByName('FDO_SEPEXP').AsString = 'N')
      Else
        Result := (cdsItens.FieldByName('FDO_SEPEXP').AsString = 'N') Or
                  (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, 2) <> fFormataFloat(qryAux.FieldByName('FDO_QTDEXP').AsFloat, 2));
    End;

begin
  Try
    Result := True;

    qryAux := fCriaQuery;

    cdsItens.First;
    While (Not cdsItens.Eof) Do
    Begin

      With qryAux Do
      Begin
        SQL.Clear;
        SQL.Add('SELECT ');
        SQL.Add('  FATDOR.AUTOINCREM, ');
        SQL.Add('  GER_NUMROM, ');
        SQL.Add('  FDO_CODITE, ');
        SQL.Add('  FDO_SEPEXP, ');
        if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
          SQL.Add('  SUM(D.DET_QTDEXP) AS FDO_QTDEXP ')
        else
          SQL.Add('  SUM(EXTDOR.FDO_QTDEXP) AS FDO_QTDEXP ');
        SQL.Add('FROM ');
        SQL.Add('  FATDOR ');
        SQL.Add('  LEFT  JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ');
        SQL.Add('  INNER JOIN ROMGERX R ');
        SQL.Add('     ON R.GER_CODEMP = FATDOR.FDO_CODEMP ');
        SQL.Add('    AND R.GER_NUMDOC = FATDOR.FDO_NUMDOC ');
        SQL.Add('    AND R.GER_ESPDOC = FATDOR.FDO_ESPDOC ');
        SQL.Add('    AND R.GER_CODCLI = FATDOR.FDO_CODCLI ');
        if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
          SQL.Add('  LEFT  JOIN ROMDETX D ON D.DET_AUTINC = FATDOR.AUTOINCREM AND D.DET_SEQGER = R.AUTOINCREM ');
        SQL.Add('WHERE ');
        SQL.Add('  GER_NUMROM        = :NUMROM AND ');
        SQL.Add('  GER_EMPROM        = :EMPROM AND ');
        SQL.Add('  FDO_CODITE        = :CODITE AND ');
        SQL.Add('  ' + fSQLQtde + ' > FDO_QTDBAI AND '); //Ignora os produtos ja baixados totalmente
        SQL.Add('  FDO_JAFATU = 0                    '); //Ignora os produtos ja faturados
        SQL.Add('GROUP BY FDO_CODITE, FDO_IDEPRO, FDO_DESCRI, ');
        SQL.Add('         FDO_NUMLOT, FDO_CODACA, FDO_EMPACA  ');
        SQL.Add('ORDER BY FDO_DESCRI ');

        ParamByName('NUMROM').AsString := FParams.strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;
        ParamByName('CODITE').AsString := cdsItens.FieldByName('FDO_CODITE').AsString;

        Open;

        If (qryAux.RecordCount > 1) Then
        Begin
          If Locate('AUTOINCREM', cdsItens.FieldByName('AUTOINCREM').AsString, []) Then
          Begin
            If fExpedicaoIncompletaOuSeparacaoNaoImpressa Then
            Begin
              Result := False;
              Break;
            End;
          End;
        End
        Else
        Begin
          If fExpedicaoIncompletaOuSeparacaoNaoImpressa Then
          Begin
            Result := False;
            Break;
          End;
        End;
      End;

      cdsItens.Next;
    End;

    FreeAndNil(qryAux);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFatExpedicaoRomaneio.fPedidoExpedido]');
      Result := False;
    End;
  End;
end;

procedure TfrmFatExpedicaoRomaneio.pRetornaConferenteESeparador(var strCodCon, strCodSep : String);
  Var
    qryExtGor : TUniQuery;
Begin
  Try
    qryExtGor := fCriaQuery;
    With qryExtGor, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT FGO_OPBXSE, FGO_OPEEXP                      ');
      Add(' FROM EXTGOR G                                      ');
      Add(' INNER JOIN FATGOR F ON F.AUTOINCREM = G.FGO_SEQFGO ');
      Add(' WHERE FGO_NUMROM = :NUMROM                         ');
      Add('   AND FGO_EMPROM = :EMPROM                         ');
      Add(' ORDER BY FGO_OPBXSE DESC                           ');
      Add(' LIMIT 1                                            ');

      ParamByName('NUMROM').AsString := FParams.strNumRom;
      ParamByName('EMPROM').AsString := FParams.strCodEmp;

      Open;

      strCodCon := FieldByName('FGO_OPEEXP').AsString;
      strCodSep := FieldByName('FGO_OPBXSE').AsString;

      Close;

    End;
  Finally
    FreeAndNil(qryExtGor);
  End;

End;

function TfrmFatExpedicaoRomaneio.fExpedePedido(objSeparacaoFina : TSeparacaoFina = nil): Boolean;
Var
  strCodCon     : String;
  strCodSep     : String;
  strObsExp     : String;
  blnConfirma   : Boolean;
begin
  pWriteLogFile('Entrou na função fExpedePedido');

  blnConfirma := True;

  {*******************************************}
  {* INFORMA SEPARADOR E CONFERENTE          *}
  {****************************************PZ*}
  If (fCfgSis('EXSECO') = 'S') Then
  Begin
    if objSeparacaoFina <> nil then
    begin
      strCodCon := objSeparacaoFina.strCodigoOperadorFinalizouConferencia;
      strCodSep := objSeparacaoFina.strCodigoOperadorFinalizouSeparacao;
    end
    else
    begin
      pWriteLogFile('Vai solicitar o conferente e o separador');

      pRetornaConferenteESeparador(strCodCon, strCodSep);

      If (Not TFatSeparadorConferente.New
        .WriteLogFile(pWriteLogFile)
        .Solicitar(strCodCon, strCodSep, strObsExp)) Then
        blnConfirma := False;
    end;
  End;

  If blnConfirma Then
    pWriteLogFile('Resultou verdadeiro vai marcar o pedido como expedido')
  Else
    pWriteLogFile('Resultou falso na função');

  If (blnConfirma) Then
    blnConfirma := fMarcaPedidoExpedido(strCodCon, strCodSep, strObsExp);

  If blnConfirma and
     fCfgSis('USPRRO', varBoolean) And
     fCfgSis('SEEXRO', varBoolean) Then
  Begin
    {********************************************}
    {* CFG_TPSPFN:                              *}
    {*       1 = CIA DAS TINTAS                 *}
    {*       2 = SECOL                          *}
    {*****************************************RN*}
    If (fCfgSis('TPSPFN') = '1') And (fTodosItensConferidos) Then
      pChamarTelaDeImpressaoDeSeparacao(False)
    Else If (fCfgSis('TPSPFN') = '2') Then
      pImprimeSeparacao(objSeparacaoFina = nil);
  End;

  Result := blnConfirma;
end;

function TfrmFatExpedicaoRomaneio.fSQLPedidosPorItem(blnFiltraItensNaoExpedidos: Boolean; strIdePro: String;
                                                     blnFiltraLote: Boolean = False): String;
begin
  Result := '';
  Result := Result + '  ';
  Result := Result + 'SELECT ';
  Result := Result + '  FATDOR.FDO_NUMDOC, ';
  Result := Result + '  FATDOR.FDO_ESPDOC, ';
  Result := Result + '  FATDOR.FDO_CODEMP, ';
  Result := Result + '  FATDOR.FDO_CODCLI, ';
  Result := Result + '  FATDOR.FDO_CODVEN, ';
  Result := Result + '  FATDOR.FDO_CODITE, ';
  Result := Result + '  FATDOR.FDO_DESCRI, ';
  Result := Result + '  EXTDOR.FDO_SEQFDO, ';

  if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
  begin
    Result := Result + '  D.AUTOINCREM AS ROMDETX_AUTOINCREM, ';
    Result := Result + '  D.DET_QTDEXP AS FDO_QTDEXP, ';
    Result := Result + '  D.DET_QTDITE AS FDO_QTDITE, ';
  end
  else
  begin
    Result := Result + '  EXTDOR.FDO_QTDEXP, ';
    Result := Result + '  (' + fSQLQtde('FATDOR') + ' - IFNULL(FDO_QTDBAI,0)) AS FDO_QTDITE, ';
  end;

  Result := Result + '  FATDOR.FDO_DTAENT ';

  Result := Result + 'FROM ';
  Result := Result + '  FATDOR ';
  Result := Result + '  LEFT  JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ';
  Result := Result + '  INNER JOIN ROMGERX R ';
  Result := Result + '     ON R.GER_CODEMP = FATDOR.FDO_CODEMP ';
  Result := Result + '    AND R.GER_NUMDOC = FATDOR.FDO_NUMDOC ';
  Result := Result + '    AND R.GER_ESPDOC = FATDOR.FDO_ESPDOC ';
  Result := Result + '    AND R.GER_CODCLI = FATDOR.FDO_CODCLI ';
  if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
    Result := Result + '  LEFT  JOIN ROMDETX D ON D.DET_AUTINC = FATDOR.AUTOINCREM AND D.DET_SEQGER = R.AUTOINCREM ';

  Result := Result + 'WHERE ';
  Result := Result + '  GER_NUMROM = :NUMROM AND ';
  Result := Result + '  GER_EMPROM = :CODEMP AND ';
  Result := Result + '  FDO_DESCRI = :DESITE AND ';
  Result := Result + '  FDO_JAFATU = 0 AND ';

  If blnFiltraLote Then
    Result := Result + '  FDO_NUMLOT = :NUMLOT AND ';

  Result := Result + '  FDO_CODITE = :CODITE     ';

  If strIdePro <> 'NOR' Then
  Begin
    Result := Result + '  AND FDO_CODACA = :CODACA ';
    Result := Result + '  AND FDO_EMPACA = :EMPACA ';
  End;

  If blnFiltraItensNaoExpedidos Then
  begin
    if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
      Result := Result + ' AND IFNULL(D.DET_QTDEXP,0) < IFNULL(' + fSQLQtde('FATDOR') + ',0) '
    else
      Result := Result + ' AND IFNULL(EXTDOR.FDO_QTDEXP,0) < IFNULL(' + fSQLQtde('FATDOR') + ',0) ';
  end;

  Result := Result + 'ORDER BY ';
  Result := Result + '  FATDOR.FDO_DESCRI, FATDOR.FDO_DTAENT, FATDOR.FDO_CODEMP, ';
  Result := Result + '  FATDOR.FDO_ESPDOC, FATDOR.FDO_NUMDOC ';
end;

procedure TfrmFatExpedicaoRomaneio.pAtualizaQtdExpItemPedido(strAutIncIte: String; fltQtdExp: Double);
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  qryAux.SQL.Add('UPDATE ');
  qryAux.SQL.Add('  EXTDOR ');
  qryAux.SQL.Add('SET ');
  qryAux.SQL.Add('  FDO_QTDEXP = FDO_QTDEXP + :QTDEXP ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FDO_SEQFDO = :SEQFDO ');

  qryAux.ParamByName('QTDEXP').AsFloat  := fltQtdExp;
  qryAux.ParamByName('SEQFDO').AsString := strAutIncIte;

  qryAux.ExecSQL;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

procedure TfrmFatExpedicaoRomaneio.pAtualizaQtdExpItemRomDet(const strRomDetXAutInc: String; fltQtdExp: Double);
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  qryAux.SQL.Add('UPDATE ');
  qryAux.SQL.Add('  ROMDETX ');
  qryAux.SQL.Add('SET ');
  qryAux.SQL.Add('  DET_QTDEXP = COALESCE(DET_QTDEXP, 0) + :QTDEXP ');
  qryAux.SQL.Add('WHERE AUTOINCREM = :AUTINC ');

  qryAux.ParamByName('QTDEXP').AsFloat  := fltQtdExp;
  qryAux.ParamByName('AUTINC').AsString := strRomDetXAutInc;

  qryAux.ExecSQL;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

function TfrmFatExpedicaoRomaneio.fMarcaPedidoExpedido(strCodCon, strCodSep, strObsExp: String): Boolean;
  Var
    strDocumentos : String;
    strDocumento  : String;
    objOcoCrm : TAtuOcoCRM;
    fltQtdExp,
    fltQtdBai,
    fltQtdPen: Double;
    qryRom: TUniQuery;
    blnFiltrarSomenteItensNaoExpedidos: Boolean;

    function fPedidoExp(strNumDoc, strCodEmp, strCodCli: String): Boolean;
      var
        qryGen: TUniQuery;
    begin
      qryGen := fCriaQuery;
      qryGen.SQL.Add('SELECT ');
      qryGen.SQL.Add('  COUNT(*) ');
      qryGen.SQL.Add('FROM ');
      qryGen.SQL.Add('  FATDOR ');
      qryGen.SQL.Add('  LEFT JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ');
      qryGen.SQL.Add('WHERE ');
      qryGen.SQL.Add('  FDO_NUMDOC  = :NUMDOC AND ');
      qryGen.SQL.Add('  FDO_ESPDOC  = :ESPDOC AND ');
      qryGen.SQL.Add('  FDO_CODEMP  = :CODEMP AND ');
      qryGen.SQL.Add('  FDO_CODCLI  = :CODCLI AND ');
      qryGen.SQL.Add('  FDO_CODITE <> :ITESER AND ');
      qryGen.SQL.Add('  FDO_CODITE <> :SERTER AND ');
      qryGen.SQL.Add('  (ROUND(' + fSQLQtde + ' - FDO_QTDBAI, 4) - ROUND(FDO_QTDEXP, 4)) > 0 ');
      qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGen.ParamByName('ESPDOC').AsString := 'PD';
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.ParamByName('CODCLI').AsString := strCodCli;
      qryGen.ParamByName('ITESER').AsString := fCfgSis('ITESER', varString);
      qryGen.ParamByName('SERTER').AsString := fCfgSis('SERTER', varString);

      qryGen.Open;

      Result := (qryGen.Fields[0].AsInteger = 0);

      FreeAndNil(qryGen);
    end;

    procedure pAtualizaPedido(strNumDoc, strCodEmp, strCodCli: String; blnExpedido: Boolean);
      Var
        strSQL: String;
        qryUpd: TUniQuery;
    begin
      strSQL := '';
      strSQL := strSQL + 'UPDATE     ';
      strSQL := strSQL + '  EXTGOR E ';
      strSQL := strSQL + '  INNER JOIN FATGOR F ON F.AUTOINCREM = E.FGO_SEQFGO ';
      strSQL := strSQL + 'SET      ';

      If fEmptyStr(strCodCon) Then
        strSQL := strSQL + '  E.FGO_OPEEXP = NULL, '
      Else
        strSQL := strSQL + '  E.FGO_OPEEXP = :OPEEXP, ';

      strSQL := strSQL + '  E.FGO_SEPEXP = :SEPEXP, ';
      strSQL := strSQL + '  E.FGO_OBSEXP = :OBSEXP  ';

      If blnExpedido Then
      Begin
        strSQL := strSQL + '  ,E.FGO_DTLBEX = :DTLBEX  ';
        strSQL := strSQL + '  ,E.FGO_HRLBEX = :HRLBEX  ';
      End;

      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  F.FGO_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  F.FGO_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  F.FGO_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  F.FGO_CODCLI = :CODCLI     ';

      qryUpd := fCriaQuery(Self);

      With qryUpd Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        If Not fEmptyStr(strCodCon) Then
          ParamByName('OPEEXP').AsString := strCodCon;

        ParamByName('SEPEXP').AsString := strCodSep;
        ParamByName('OBSEXP').AsString := strObsExp;
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := 'PD';
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;

        If blnExpedido Then
        Begin
          ParamByName('DTLBEX').AsDate := VS_Date;
          ParamByName('HRLBEX').AsTime := fTime();
        End;

        ExecSQL;
      End;

      FreeAndNil(qryUpd);
    End;

    Function fTotalExpedido(strCodIte, strDesIte, strNumLot, strCodAca, strEmpAca: String; blnFiltraItensNaoExpedidos: Boolean): Double;
      Var
        strSQL: String;
        qryTot: TUniQuery;
    begin
      Result := 0.00;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  FATDOR.FDO_CODITE, ';
      if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
        strSQL := strSQL + '  SUM(D.DET_QTDEXP) AS TOTEXP '
      else
        strSQL := strSQL + '  SUM(EXTDOR.FDO_QTDEXP) AS TOTEXP ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  FATDOR ';
      strSQL := strSQL + '  LEFT  JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ';
      strSQL := strSQL + '  INNER JOIN ROMGERX R ';
      strSQL := strSQL + '     ON R.GER_CODEMP = FATDOR.FDO_CODEMP ';
      strSQL := strSQL + '    AND R.GER_NUMDOC = FATDOR.FDO_NUMDOC ';
      strSQL := strSQL + '    AND R.GER_ESPDOC = FATDOR.FDO_ESPDOC ';
      strSQL := strSQL + '    AND R.GER_CODCLI = FATDOR.FDO_CODCLI ';
      if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
        strSQL := strSQL + '  LEFT  JOIN ROMDETX D ON D.DET_AUTINC = FATDOR.AUTOINCREM AND D.DET_SEQGER = R.AUTOINCREM ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
      strSQL := strSQL + '  GER_EMPROM = :CODEMP AND ';
      strSQL := strSQL + '  FDO_CODITE = :CODITE AND ';
      strSQL := strSQL + '  FDO_DESCRI = :DESCRI AND ';
      strSQL := strSQL + '  IFNULL(FDO_NUMLOT,"") = :NUMLOT AND';
      strSQL := strSQL + '  FDO_JAFATU = 0 ';

      If Not fEmptyStr(strCodAca) Then
      Begin
        strSQL := strSQL + '  AND FDO_CODACA = :CODACA ';
        strSQL := strSQL + '  AND FDO_EMPACA = :EMPACA ';
      End;

      If blnFiltraItensNaoExpedidos Then
      begin
        if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
          strSQL := strSQL + ' AND IFNULL(D.DET_QTDEXP,0) < IFNULL(' + fSQLQtde('FATDOR') + ',0) '
        else
          strSQL := strSQL + ' AND IFNULL(EXTDOR.FDO_QTDEXP,0) < IFNULL(' + fSQLQtde('FATDOR') + ',0) ' ;
      end;

      strSQL := strSQL + 'GROUP BY ';
      strSQL := strSQL + '  FATDOR.FDO_CODITE, FATDOR.FDO_DESCRI, FATDOR.FDO_NUMLOT ';
      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  FATDOR.FDO_CODITE, FATDOR.FDO_NUMLOT, EXTDOR.FDO_SEQFDO ';

      qryTot := fCriaQuery(Self);

      With qryTot Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('NUMROM').AsString := FParams.strNumRom;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('DESCRI').AsString := strDesIte;
        ParamByName('NUMLOT').AsString := strNumLot;

        If Not fEmptyStr(strCodAca) Then
        Begin
          ParamByName('CODACA').AsString := strCodAca;
          ParamByName('EMPACA').AsString := strEmpAca;
        End;

        Open;

        If Not IsEmpty Then
          Result := FieldByName('TOTEXP').AsFloat;
      End;

      FreeAndNil(qryTot);
    End;

begin
  Result := False;
  qryRom := fCriaQuery;
  strDocumentos := '';
  pWriteLogFile('Entrou na funcao fMarcaPedidoExpedido');

  blnFiltrarSomenteItensNaoExpedidos := True;
  Try
    pWriteLogFile('Inicou uma transacao');
    fStartTransaction;

    pWriteLogFile('vai processar o cdsItens chamando a procedure pAtualizaQtdExpItemPedido');

    cdsItens.First;
    While (Not cdsItens.Eof) Do
    Begin
      if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
        blnFiltrarSomenteItensNaoExpedidos := cdsItens.FieldByName('LIMPOU').AsInteger = 0;

      fltQtdExp := cdsItens.FieldByName('QTDEXP').AsFloat -
                   fTotalExpedido(cdsItens.FieldByName('CODITE').AsString,
                                  cdsItens.FieldByName('DESCRI').AsString,
                                  cdsItens.FieldByName('NUMLOT').AsString,
                                  cdsItens.FieldByName('CODACA').AsString,
                                  cdsItens.FieldByName('EMPACA').AsString,
                                  blnFiltrarSomenteItensNaoExpedidos);

      With qryRom Do
      Begin
        Close;

        SQL.Clear;
        SQL.Add(fSQLPedidosPorItem(blnFiltrarSomenteItensNaoExpedidos, cdsItens.FieldByName('IDEPRO').AsString));

        ParamByName('NUMROM').AsString := FParams.strNumRom;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODITE').AsString := cdsItens.FieldByName('CODITE').AsString;
        ParamByName('DESITE').AsString := cdsItens.FieldByName('DESCRI').AsString;

        If cdsItens.FieldByName('IDEPRO').AsString <> 'NOR' Then
        Begin
          ParamByName('CODACA').AsString := cdsItens.FieldByName('CODACA').AsString;
          ParamByName('EMPACA').AsString := cdsItens.FieldByName('EMPACA').AsString;
        End;

        Open;
        First;

        SetLength(arrDocume, 0);

        While Not EOF Do
        Begin
          If (fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) And (fltQtdExp <> 0)) Or (fltQtdExp > 0) Then
          Begin
            SetLength(arrDocume, Length(arrDocume) + 1);
            arrDocume[Length(arrDocume) - 1].strNumDoc := FieldByName('FDO_NUMDOC').AsString;
            arrDocume[Length(arrDocume) - 1].strEspDoc := FieldByName('FDO_ESPDOC').AsString;
            arrDocume[Length(arrDocume) - 1].strCodEmp := FieldByName('FDO_CODEMP').AsString;
            arrDocume[Length(arrDocume) - 1].strCliFor := FieldByName('FDO_CODCLI').AsString;

            if fltQtdExp < 0 then
            begin
              fltQtdPen := FieldByName('FDO_QTDEXP').AsFloat * -1;
              fltQtdBai := IfThen(fltQtdExp < fltQtdPen, fltQtdPen, fltQtdExp);
            end
            else
            begin
              fltQtdPen := FieldByName('FDO_QTDITE').AsFloat - FieldByName('FDO_QTDEXP').AsFloat;
              fltQtdBai := IfThen(fltQtdExp > fltQtdPen, fltQtdPen, fltQtdExp);
            end;

            fltQtdExp := fltQtdExp - fltQtdBai;

            pAtualizaQtdExpItemPedido(FieldByName('FDO_SEQFDO').AsString,
                                      fltQtdBai);

            if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
              pAtualizaQtdExpItemRomDet(
                FieldByName('ROMDETX_AUTOINCREM').AsString,
                fltQtdBai);

            pAtualizaPedido(FieldByName('FDO_NUMDOC').AsString,
                            FieldByName('FDO_CODEMP').AsString,
                            FieldByName('FDO_CODCLI').AsString,
                            fPedidoExp(FieldByName('FDO_NUMDOC').AsString,
                                       FieldByName('FDO_CODEMP').AsString,
                                       FieldByName('FDO_CODCLI').AsString));

            If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
            Begin
              strDocumento := FieldByName('FDO_NUMDOC').AsString +
                              FieldByName('FDO_ESPDOC').AsString +
                              FieldByName('FDO_CODEMP').AsString;

              If Pos(strDocumento, strDocumentos) = 0 Then
              Begin
                objOcoCrm := fAtualizaInformacoesCRM(FieldByName('FDO_NUMDOC').AsString,
                                                     FieldByName('FDO_ESPDOC').AsString,
                                                     FieldByName('FDO_CODEMP').AsString,
                                                     FieldByName('FDO_CODCLI').AsString,
                                                     FieldByName('FDO_NUMDOC').AsString,
                                                     FieldByName('FDO_ESPDOC').AsString,
                                                     strLoginUsuarioLogado,
                                                     afcPedidoConferido);

                objOcoCrm.pProcessaFatOcorrenciasCRM;
                FreeAndNil(objOcoCrm);
                strDocumentos := strDocumentos + strDocumento + '_';
              End;
            End;
          End;

          Next;
        End;
      End;

      cdsItens.Next;
    End;

    pWriteLogFile('vai comitar a transacao');
    fCommit;

    FConfirmou := True;
    Result := True;

    FreeAndNil(qryRom);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pWriteLogFile('Ocorreu um erro na funcao fMarcaPedidoExpedido:' + E.Message);
      pMensagensErro(E.Message, '[TfrmFatExpedicaoItens.fMarcaPedidoExpedido]');
    End;
  End;

  If fCfgSis('TIPBAR', varString) = '2' Then
   edtCodIte.MaxLength := 43;

end;

procedure TfrmFatExpedicaoRomaneio.pImprimeEtiquetaDespacho(strNumDoc, strEspDoc, strCodCli, strCodEmp: String; intQtdTra: Integer);
  Var
    frmImpEtiDespacho : TfrmImpEtiDespacho;
begin
  Try
    pCriarFormularios(TfrmImpEtiDespacho, frmImpEtiDespacho);
    frmImpEtiDespacho.edtNumDoc.Text := strNumDoc;
    frmImpEtiDespacho.edtEspDoc.Text := strEspDoc;
    frmImpEtiDespacho.edtQtdVol.Text := IntToStr(intQtdTra);
    frmImpEtiDespacho.edtCodCli.Text := strCodCli;
    frmImpEtiDespacho.strCodCli      := strCodCli;
    frmImpEtiDespacho.edtCodEmp.Text := strCodEmp;
    frmImpEtiDespacho.blnImpEti      := True;

    If (intQtdTra <= 0) Or (Not frmImpEtiDespacho.fValidarTodosCampos) Then
      frmImpEtiDespacho.ShowModal
    Else
      frmImpEtiDespacho.btnConfirma.Click;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmFatExpedicaoItens -> frmImpEtiDespacho]');
  End;
  pFreeAndNil(frmImpEtiDespacho);
end;

{*******************************************************}
{* CFG_TPSPFN:                                         *}
{*       1 = CIA DAS TINTAS                            *}
{*       2 = SECOL                                     *}
{* * IMPRESSÃO DE SEPARAÇÃO DA "SECOL" CÓPIA (48.2.22) *}
{****************************************************RN*}
procedure TfrmFatExpedicaoRomaneio.pImprimeSeparacao(blnImprimirRelatorio : boolean);
  Var
    qrySetores    : TUniQuery;
    blnImpSep     : Boolean;
    objSeparacaoFina : TSeparacaoFina;

    Procedure pMarcaSeparacaoImpressaRomaneio(strCodLse: String);
    begin
      fExecutaSQL('UPDATE ROMDETX R ' +
                  '       INNER JOIN ITEGER I ON (R.DET_CODITE = I.ITE_CODITE) ' +
                  '                          AND (R.DET_CODEMP = I.ITE_CODEMP) ' +
                  '       INNER JOIN FATDOR F ON (R.DET_CODEMP = F.FDO_CODEMP) ' +
                  '                          AND (R.DET_NUMDOC = F.FDO_NUMDOC) ' +
                  '                          AND (R.DET_ESPDOC = F.FDO_ESPDOC) ' +
                  '                          AND (R.DET_CODCLI = F.FDO_CODCLI) ' +
                  '                          AND (I.ITE_CODITE = F.FDO_CODITE) ' +
                  '                          AND (I.ITE_CODEMP = F.FDO_CODEMP) ' +
                  '       INNER JOIN EXTDOR E ON (F.AUTOINCREM = E.FDO_SEQFDO) ' +
                  'SET    R.DET_SEPIMP = "S", ' +
                  '       E.FDO_SEPEXP = "S" ' +
                  'WHERE  R.DET_NUMROM = "' + FParams.strNumRom + '" ' +
                  '  AND  R.DET_EMPROM = "' + VS_strCodEmp + '"' +
                  '  AND  I.ITE_CODLSE = "' + strCodLse + '"');
    end;

begin
  blnImpSep  := False;
  qrySetores := fCriaQuery(Nil);

  cdsItens.OnFilterRecord  := Nil;

  With qrySetores Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT DISTINCT');
    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    begin
      SQL.Add('   IF(IFNULL(F.FDO_NUMLOT, "") = "", LS2.LSE_CODIGO, LS1.LSE_CODIGO) AS ITE_CODLSE, ');
      SQL.Add('   IF(IFNULL(F.FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) AS LSE_DESCRI, ');
      SQL.Add('   IF(IFNULL(F.FDO_NUMLOT, "") = "", LS2.AUTOINCREM, LS1.AUTOINCREM) AS AUTOINCREM  ');
    end
    else
    begin
      SQL.Add('   I.ITE_CODLSE, ');
      SQL.Add('   L.LSE_DESCRI, ');
      SQL.Add('   L.AUTOINCREM  ');
    end;

    SQL.Add('FROM ');
    SQL.Add('  ROMDETX D ');
    SQL.Add('    INNER JOIN ITEGER I ON (D.DET_CODITE = I.ITE_CODITE) ');
    SQL.Add('                       AND (D.DET_CODEMP = I.ITE_CODEMP) ');
    SQL.Add('    INNER JOIN FATDOR F ON (D.DET_CODEMP = F.FDO_CODEMP) ');
    SQL.Add('                       AND (D.DET_NUMDOC = F.FDO_NUMDOC) ');
    SQL.Add('                       AND (D.DET_ESPDOC = F.FDO_ESPDOC) ');
    SQL.Add('                       AND (D.DET_CODCLI = F.FDO_CODCLI) ');
    SQL.Add('                       AND (I.ITE_CODITE = F.FDO_CODITE) ');
    SQL.Add('                       AND (I.ITE_CODEMP = F.FDO_CODEMP) ');
    SQL.Add('    INNER JOIN EXTDOR E ON (F.AUTOINCREM = E.FDO_SEQFDO) ');

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    begin
      SQL.Add(' LEFT JOIN CADLOT LT ON LT.LOT_CODITE = FDO_CODITE AND LT.LOT_CODEMP = FDO_CODEMP AND LT.LOT_NUMLOT = FDO_NUMLOT ');
      SQL.Add(' LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LT.LOT_LOCFIS AND CL1.LOC_CODEMP = LT.LOT_CODEMP ');
      SQL.Add(' LEFT JOIN CADLOC CL2 ON CL2.LOC_CODLOC = I.ITE_LOCFIS AND CL2.LOC_CODEMP = I.ITE_CODEMP ');
      SQL.Add(' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ');
      SQL.Add(' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = CL2.LOC_CODLSE ');
    end
    else
      SQL.Add('    LEFT  JOIN CADLSE L ON (I.ITE_CODLSE = L.LSE_CODIGO) ');

    SQL.Add('WHERE ');
    SQL.Add('  E.FDO_SEPEXP = "N"     AND ');
    SQL.Add('  D.DET_NUMROM = :NUMROM AND ');
    SQL.Add('  D.DET_EMPROM = :CODEMP     ');
    SQL.Add('ORDER BY ');
    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      SQL.Add('  IF(IFNULL(F.FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) ')
    else
      SQL.Add('  L.LSE_DESCRI ');

    ParamByName('NUMROM').AsString := FParams.strNumRom;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;
    First;
    While Not EOF Do
    Begin
      cdsItens.Filtered := False;
      cdsItens.Filter   := ' ITE_CODLSE = ' + QuotedStr(FieldByName('ITE_CODLSE').AsString) + ' AND ' +
                           ' FDO_SEPEXP = ' + QuotedStr('N') + ' ';
      cdsItens.Filtered := True;

      cdsItens.First;
      While Not cdsItens.EOF Do
      Begin
        blnImpSep := (fFormataFloat(cdsItens.FieldByName('QTDITE').AsFloat, 2) =
                      fFormataFloat(cdsItens.FieldByName('QTDEXP').AsFloat, 2));

        If Not blnImpSep Then
          cdsItens.Last
        ELse
          cdsItens.Next;
      End;

      If blnImpSep Then
      Begin
        blnImpSep := False;

        objSeparacaoFina := TSeparacaoFina.Create(tdsRomaneio, VS_strCodEmp);
        try
          objSeparacaoFina.strNumeroDocumento := FParams.strNumRom;
          objSeparacaoFina.strAutoincremLocalSeparacao := FieldByName('AUTOINCREM').AsString;
          if (not blnImprimirRelatorio) or objSeparacaoFina.fImprimeSeparacaoRomaneio then
            pMarcaSeparacaoImpressaRomaneio(FieldByName('ITE_CODLSE').AsString);

        finally
          FreeAndNil(objSeparacaoFina);
        end;

      End;

      Next;
    End;
  End;

  cdsItens.First;
  cdsItens.OnFilterRecord := pOnFilter;
end;

function TfrmFatExpedicaoRomaneio.fExcedeLimiteItensNFe: Boolean;
  Var
    strEntRet, strEntFut: String;
    strInformacao: String;
    intQtdItens: Integer;
begin
  With TUniClientDataSet.Create(nil) Do
  Begin
    Data := cdsItens.Data;

    Filter := cdsItens.Filter;

    If Not fEmptyStr(Filter) Then
      Filter := Filter  + ' AND ';

    strEntRet := cdsItens.FieldByName('ENTRET').AsString;
    strEntFut := cdsItens.FieldByName('ENTFUT').AsString;

    Filter := Filter + 'QTDEXP > 0 AND ';    
    Filter := Filter + 'ENTRET = ' + QuotedStr(strEntRet) + ' AND ';
    Filter := Filter + 'ENTFUT = ' + QuotedStr(strEntFut);

    Filtered := True;

    If cdsItens.FieldByName('QTDEXP').AsInteger > 0 Then
      intQtdItens := RecordCount
    Else
      intQtdItens := RecordCount + 1;    

    If strEntRet = 'R' Then
      Result := TFatVenda.fUltrapassouLimiteItensNFe(intQtdItens, 'Retira', strInformacao)

    Else If strEntFut = 'N' Then
      Result := TFatVenda.fUltrapassouLimiteItensNFe(intQtdItens, 'Entrega Imediata', strInformacao)

    Else
      Result := TFatVenda.fUltrapassouLimiteItensNFe(intQtdItens, 'Entrega Futura', strInformacao);

    Destroy;
  End;

  If Result Then
    pMensagemSonora(strInformacao);
end;

procedure TfrmFatExpedicaoRomaneio.pOrdenarItens;
begin
  cdsItens.IndexFieldNames := 'AUTOINCREM';

  Case strOrdPdv[1] Of
    '1': cdsItens.IndexFieldNames := 'FDO_DESCRI;AUTOINCREM';
    '2': cdsItens.IndexFieldNames := 'UNIDAD;FDO_DESCRI;AUTOINCREM';
    '3': cdsItens.IndexFieldNames := 'ORDITE;AUTOINCREM';
    '4': cdsItens.IndexFieldNames := 'LOCFIS;FDO_DESCRI;AUTOINCREM';
    '5': cdsItens.IndexFieldNames := 'DEP_DESCRI;FDO_DESCRI';
    '6': Begin
           cdsItens.IndexFieldNames := '';
           cdsItens.IndexDefs.Clear;
           With cdsItens.IndexDefs.AddIndexDef Do
           Begin
             Name       := 'IDX_ORDEM';
             Fields     := 'ENTRET;ENTFUT;FDO_DESCRI';
             DescFields := 'ENTRET';
           End;

           cdsItens.IndexName := 'IDX_ORDEM';
         End;
  End;

end;

procedure TfrmFatExpedicaoRomaneio.pWriteLogFile(strText: String);
  var
    strLogPath: String;
    stlLogFile: TStringList;
begin
  Try
    strlogPath := ExtractFilePath(Application.ExeName) + '\LogExp\';

    If Not DirectoryExists(strLogPath) Then
      CreateDir(strLogPath);

    strLogPath := strLogPath + strLogFileName;

    stlLogFile := TStringList.Create;

    If FileExists(strLogPath) Then
      stlLogFile.LoadFromFile(strLogPath);

    stlLogFile.Add(strText);

    stlLogFile.SaveToFile(strLogPath);

    FreeAndNil(stlLogFile);
  Except

  End;
End;

procedure TfrmFatExpedicaoRomaneio.pInicializaTela;
var
  strNumRomAux: String;
begin
  strNumRomAux := FParams.strNumRom;

  pOnClose;
  pOnCreate;
  FParams.VS_strTipExpInterna    := VS_strTipExp;
  FParams.blnCarregarQtdExpedida := VS_strTipExp = '5';
  FParams.strNumRom              := strNumRomAux;
  pOnShow;
end;

procedure TfrmFatExpedicaoRomaneio.pOnCreate;
begin
  pEsvaziaArrayCfgDes;

  dbgItens.DataSource := nil;

  qryItens := fCriaQuery(Self);

  objLiberacao := TLiberacao.Create;

  strLogFileName := fNomeDoComputador + '_' + FormatDateTime('yyyyMMddhhmmss', fNow()) + '.txt';

  VS_strTipDEx := fCfgSis('TIPDEX');

  If VS_strTipDEx = '1' Then
    strMsgSel := '[ENTER] Marca / Desmarca Item'
  Else
    strMsgSel := '[BARRA DE ESPAÇO] Marca / Desmarca Item';

  objIteBar     := TIteBar.Create(opcFuncoes);

  FParams := TExpedicaoParams.Create;
  FParams.blnAutSer := FALSE;

  if Assigned(frmFatExpedicao) then
  begin
    if frmFatExpedicao.dtsPedidos.DataSet.FieldByName('PEDPAR').AsString <> 'R' then
      FParams.blnReposicao := False
    else
      FParams.blnReposicao := True;
  end
  else
    FParams.blnReposicao := False;

  FParams.blnCarregarQtdExpedida := False;

  fatVenEst   := TFatVenda.CreateInstance('VN');
  fatVenEst.blnExpedi := True;

  intDecQtd := fCfgSis('DECQTD', varInteger);
  edtQtdIte.EditFormat := fMskDigitos(intDecQtd);

  btnDigVol.Visible := fCfgSis('VOLEXP', VarBoolean);

  If VS_strTipDEx = '1' Then
  Begin
    btnQuantidade.Visible := True;
    edtQtdIte.Enabled     := False;
  End
  Else
    btnQuantidade.Visible := False;

  strOrdPdv := fCfgSis('ORDPDV');

  btnFatura.Enabled := False;
  btnDigVol.Enabled := False;

  stlCodCli := TStringList.Create;
  stlFatGor := TStringList.Create;
  stlVolumesAlterados := TStringList.Create;

  cdsBaiFut := TZClient.Create(Self);

  dbgItens.DataSource := dtsItens;

  btnReimpSep.Visible := (fCfgSis('TPSPFN') = '1');
end;

procedure TfrmFatExpedicaoRomaneio.pOnShow;
begin
  If (edtCodIte.Visible) And (edtCodIte.Enabled) And (Not edtCodIte.ReadOnly) Then
    pSetFocus(edtCodIte);

  edtQtdIte.Text := FloatToStrF(1, ffFixed, 12, intDecQtd);

  If fEmptyStr(FParams.VS_strTipExpInterna) Then
    FParams.VS_strTipExpInterna := VS_strTipExp;

  FParams.blnApenasFaturarJaExpedidos := FParams.blnCarregarQtdExpedida And (FParams.VS_strTipExpInterna = '3');

  If FParams.blnApenasFaturarJaExpedidos Then
  Begin
    btnQuantidade.Visible := False;
    btnExpAut.Visible := False;
    btnExpAut.Visible := False;
    pnlRodape.Visible := False;
  End;

  stlItens  := TStringList.Create;
  qryEtique := fCriaQuery;

  blnFecharForm := False;
  FConfirmou := False;

  qryFatGor := fCriaQuery(Self);

  If VS_strTipDEx = '2' Then
    pSetFocus(dbgItens);


  btnRelInc.Visible := (FParams.VS_strTipExpInterna = '5') And
    (fVerificaAcessoSistema('IMREIN', strLoginUsuarioLogado));

  shpSemSal.Visible := False;
  lblSemSal.Visible := False;

  pAbreItens;

  if (fCfgSis('TPSPFN', varString) = '2') then
  begin
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.lblGravando.Caption := 'Aguarde, verificando expedição coletor...';
      frmGravando.pgbStatus.Visible := False;
      frmGravando.fExecutarAcao := fConfirmaExpedicaoGravando;
      frmGravando.ShowModal;
    finally
      pFreeAndNil(frmGravando);
    End;
  end;

  pHabilitaCampos(False);
end;

procedure TfrmFatExpedicaoRomaneio.pOnClose;
begin
  pEsvaziaArrayCfgDes;

  FreeAndNil(FParams.cdsItens);

  FreeAndNil(fatVenEst);
  FreeAndNil(qryEtique);
  FreeAndNil(stlItens);
  FreeAndNil(stlCodCli);
  FreeAndNil(stlFatGor);
  FreeAndNil(stlVolumesAlterados);

  If FileExists(ExtractFilePath(Application.ExeName) + '\LogExp\' + strLogFileName) Then
    DeleteFile(ExtractFilePath(Application.ExeName) + '\LogExp\' + strLogFileName);

  FreeAndNil(objIteBar);

  FreeAndNil(cdsIteInc);
  FreeAndNil(qryItens);
  FreeAndNil(FParams);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
end;

function TfrmFatExpedicaoRomaneio.fValidaDireitoAcesso: boolean;
begin
  objLiberacao.Clear;
  objLiberacao.strDirAce    := 'QTDEXP';
  objLiberacao.strMsgSen    := 'Expedição - Permitir alterar a quantidade conferida através do botão "[F6] Qtde"';
  objLiberacao.strCodOpe    := strLoginUsuarioLogado;
  objLiberacao.objMsgLibera.pAddTexto('Expedição - Permitir alterar a quantidade conferida através do botão "[F6] Qtde"' + sLineBreak +
                                      'Produto: ' + cdsItens.FieldByName('DESITE').AsString);

  objLiberacao.pInformaNumDocEspDocCodEmp(
                      cdsItens.FieldByName('NUMDOC').AsString,
                      cdsItens.FieldByName('ESPDOC').AsString,
                      VS_strCodEmp);

  Result := objLiberacao.fLibera;
end;

End.


