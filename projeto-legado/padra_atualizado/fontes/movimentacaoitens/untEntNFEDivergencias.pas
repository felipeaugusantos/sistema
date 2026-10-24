
unit untEntNFEDivergencias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, UITypes,
  cxCurrencyEdit, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade, untExcel, untTypesSistema, untGeraExcel,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao,
  frxExportPDF, frxDBSet, untVersaoProg;

type
  TfrmEntNFEDivergencias = class(TfrmPai)
    btnLiberar: TBitBtnLocked;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensFORNEC: TcxGridDBColumn;
    cxgItensNUMDOC: TcxGridDBColumn;
    cxgItensELETRO: TcxGridDBColumn;
    cxgItensCODITE: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensREFERE: TcxGridDBColumn;
    cxgItensSIGUNI: TcxGridDBColumn;
    cxgItensCODSIT: TcxGridDBColumn;
    cxgItensBASICM: TcxGridDBColumn;
    cxgItensALQICM: TcxGridDBColumn;
    cxgItensVALICM: TcxGridDBColumn;
    cxgItensBASSUB: TcxGridDBColumn;
    cxgItensFATMVA: TcxGridDBColumn;
    cxgItensVALSUB: TcxGridDBColumn;
    cxgItensALQIPI: TcxGridDBColumn;
    cxgItensVALIPI: TcxGridDBColumn;
    cxgItensBASIPI: TcxGridDBColumn;
    cxgItensDIF_BASICM: TcxGridDBColumn;
    cxgItensDIF_ALQICM: TcxGridDBColumn;
    cxgItensDIF_VALICM: TcxGridDBColumn;
    cxgItensDIF_BASIPI: TcxGridDBColumn;
    cxgItensDIF_ALQIPI: TcxGridDBColumn;
    cxgItensDIF_VALIPI: TcxGridDBColumn;
    cxgItensDIF_BASSUB: TcxGridDBColumn;
    cxgItensDIF_FATMVA: TcxGridDBColumn;
    cxgItensDIF_VALSUB: TcxGridDBColumn;
    cxgItensDIF_CODSIT: TcxGridDBColumn;
    Panel1: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Label2: TLabel;
    Shape3: TShape;
    Label3: TLabel;
    Shape4: TShape;
    lblTolerancia: TLabel;
    btnExpExc: TBitBtnLocked;
    cxItensCODFAB: TcxGridDBColumn;
    rdgCSTCad: TRadioGroup;
    cxgItensCLAFIS: TcxGridDBColumn;
    cxgItensABFICM: TcxGridDBColumn;
    cxgItensPERFOR: TcxGridDBColumn;
    btnCadAbrFisICM: TBitBtnLocked;
    btnCadAbrFisIpi: TBitBtnLocked;
    btnCadAbrFisPIS: TBitBtnLocked;
    btnCadAbrFisCOF: TBitBtnLocked;
    bntReprocessaAbvFiscal: TBitBtnLocked;
    cxgItensNCM: TcxGridDBColumn;
    cxgItensABRICM: TcxGridDBColumn;
    cxgItensDESABF: TcxGridDBColumn;
    btnCadPro: TBitBtnLocked;
    lblDivergenciaSTMensagem: TLabel;
    cxgItensPISCST: TcxGridDBColumn;
    cxgItensPISVBC: TcxGridDBColumn;
    cxgItensPISPPIS: TcxGridDBColumn;
    cxgItensPISVPIS: TcxGridDBColumn;
    cxgItensCOFCST: TcxGridDBColumn;
    cxgItensCOFVBC: TcxGridDBColumn;
    cxgItensCOFPCOFINS: TcxGridDBColumn;
    cxgItensCOFVCOFINS: TcxGridDBColumn;
    cxgItensDIF_PISCST: TcxGridDBColumn;
    cxgItensDIF_PISVBC: TcxGridDBColumn;
    cxgItensDIF_PISPPIS: TcxGridDBColumn;
    cxgItensDIF_PISVPIS: TcxGridDBColumn;
    cxgItensDIF_COFCST: TcxGridDBColumn;
    cxgItensDIF_COFVBC: TcxGridDBColumn;
    cxgItensDIF_COFPCOFINS: TcxGridDBColumn;
    cxgItensDIF_COFVCOFINS: TcxGridDBColumn;
    cxgItensABFCOF: TcxGridDBColumn;
    cxgItensABFPIS: TcxGridDBColumn;
    btnMotivosPedencia: TBitBtnLocked;
    btnRejeitaNota: TBitBtnLocked;
    frxDivergencias: TfrxReport;
    frxDBDivergencias: TfrxDBDataset;
    frxPDFExport: TfrxPDFExport;
    fodDestino: TFileOpenDialog;
    btnExpPdf: TBitBtnLocked;
    cxgItensDIF_PFCPST: TcxGridDBColumn;
    cxgItensDIF_VFCPST: TcxGridDBColumn;
    cxgItensVBCFCPST: TcxGridDBColumn;
    cxgItensPFCPST: TcxGridDBColumn;
    cxgItensVFCPST: TcxGridDBColumn;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnLiberarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgItensCODSITCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensBASICMCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensALQICMCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensVALICMCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensBASSUBCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensFATMVACustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensVALSUBCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensBASIPICustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensALQIPICustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensVALIPICustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnExpExcClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgItensCLAFISCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnCadAbrFisICMClick(Sender: TObject);
    procedure btnCadAbrFisIpiClick(Sender: TObject);
    procedure btnCadAbrFisPISClick(Sender: TObject);
    procedure btnCadAbrFisCOFClick(Sender: TObject);
    procedure bntReprocessaAbvFiscalClick(Sender: TObject);
    procedure btnCadProClick(Sender: TObject);
    procedure cxgItensPISCSTCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensPISPPISCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensPISVBCCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensPISVPISCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensCOFCSTCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensCOFVBCCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensCOFPCOFINSCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensCOFVCOFINSCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnRejeitaNotaClick(Sender: TObject);
    procedure btnMotivosPedenciaClick(Sender: TObject);
    function frxDivergenciasUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure btnExpPdfClick(Sender: TObject);
    procedure cxgItensVBCFCPSTCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    objLiberacao : TLiberacao;
    blnValidaPisCofins: Boolean;
    blnVALELE : Boolean;

    stlVermelho : TStringList;
    stlAmarelo : TStringList;
    
    Function fLiberaXMLDivergente: Boolean;

    procedure pAteraFonte(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
                   AViewInfo: TcxGridTableDataCellViewInfo);

    procedure pImprimeDetalhes(Excel: TExcel; Dados: TDataSet; Campos: TCampos;
      CorFundo: TCorExcel);
    function fCampoDeveSerPintadoDeVermelho(Dados: TDataSet; Campo: string): Boolean;

    procedure pAddDivergencia(coluna: TcxCustomGridTableItem; cor: TColor);
    function fGetValorCampo(strCampo: String): String;
    procedure pExportarPDF;
  public
    { Public declarations }
    blnBloqueiaNFE,
    blnConfirma: Boolean;
    blnReprocessar: boolean;
    strOpeLib: String;
    HoraLiberacao: TTime;

    strAutIncXMLVAL: String;

    Function fCalculaBloqueio: Boolean;
    function fPreparaGNRE(var blnPreviaGnreSuspensa: Boolean): Boolean;
  end;

var
  frmEntNFEDivergencias: TfrmEntNFEDivergencias;

implementation

{$R *.dfm}

Uses
  untFuncFat, untFuncoesSimples, untCadAbreviacaoFiscal,
  untCadAbreviacaoIPI, untCadAbreviacaoPIS, untCadAbreviacaoCOFINS,
  untMsgLiberacao, untCadProdutos, untPreparaGNRE,
  untEntImportaNotaElet, untPedePendenciasNota;

procedure TfrmEntNFEDivergencias.FormCreate(Sender: TObject);
begin
  inherited;
  strOpeLib := '';
  blnValidaPisCofins := fCfgSis('VAPICO', varBoolean);
  blnVALELE := fCfgSis('VALELE', varBoolean);

  cxgItensPISCST.Visible := blnValidaPisCofins;
  cxgItensPISVBC.Visible := blnValidaPisCofins;
  cxgItensPISPPIS.Visible := blnValidaPisCofins;
  cxgItensPISVPIS.Visible := blnValidaPisCofins;
  cxgItensCOFCST.Visible := blnValidaPisCofins;
  cxgItensCOFVBC.Visible := blnValidaPisCofins;
  cxgItensCOFPCOFINS.Visible := blnValidaPisCofins;
  cxgItensCOFVCOFINS.Visible := blnValidaPisCofins;
  cxgItensVBCFCPST.Visible := blnVALELE;
  cxgItensPFCPST.Visible := blnVALELE;
  cxgItensVFCPST.Visible := blnVALELE;

  blnConfirma := False;
  blnReprocessar := False;
  stlVermelho := TStringList.Create;
  stlAmarelo := TStringList.Create;

  objLiberacao := TLiberacao.Create;
  lblDivergenciaSTMensagem.Visible := False;

  strAutIncXMLVAL := '';
end;

procedure TfrmEntNFEDivergencias.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(stlVermelho);
  FreeAndNil(stlAmarelo);
  FreeAndNil(objLiberacao);
end;

procedure TfrmEntNFEDivergencias.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F3:  btnMotivosPedencia.Click;
    VK_F4:  btnRejeitaNota.Click;
    VK_F5:  btnCadAbrFisICM.Click;
    VK_F6:  btnCadAbrFisIpi.Click;
    VK_F7:  btnCadAbrFisPIS.Click;
    VK_F8:  btnCadAbrFisCOF.Click;
    VK_F9:  bntReprocessaAbvFiscal.Click;
    VK_F10: btnLiberar.Click;
    VK_F11: btnExpExc.Click;
    VK_F12: btnCadPro.Click;
    VKP: If ssAlt in Shift Then
         Begin
           btnExpPdf.Click;
         End;
  End;
end;

procedure TfrmEntNFEDivergencias.FormShow(Sender: TObject);
begin
  inherited;
  cxgItensView.ViewData.Expand(True);

  lblTolerancia.Caption := 'Divergências dentro do limite de tolerância (+/- R$ ' + FormatFloat('#0.00', fCfgSis('TOLNFE', varDouble)) + ')';

  btnMotivosPedencia.Visible := Not strAutIncXMLVAL.IsEmpty;
  btnRejeitaNota.Visible     := Not strAutIncXMLVAL.IsEmpty;
end;

function TfrmEntNFEDivergencias.fPreparaGNRE(var blnPreviaGnreSuspensa: Boolean): Boolean;
  Var
    strFilter: String;
    frmPreparaGNRE: TfrmPreparaGNRE;
begin
  blnPreviaGnreSuspensa := False;
  {Não existe divergencias de Valor no ST}
  If Not (lblDivergenciaSTMensagem.Visible) Then
    Exit(False);


  cxgItensView.DataController.DataSource.DataSet.DisableControls;
  Try
    strFilter := '';
    If cxgItensView.DataController.DataSource.DataSet.Filtered Then
      strFilter := cxgItensView.DataController.DataSource.DataSet.Filter;

    cxgItensView.DataController.DataSource.DataSet.Filtered := False;
    cxgItensView.DataController.DataSource.DataSet.Filter   := strFilter + IIf(strFilter <> '', ' AND ', '') + '((VSTCAL + VSTXML) > 0) AND ELETRO = ' + QuotedStr('S');

    cxgItensView.DataController.DataSource.DataSet.Filtered := True;
    If cxgItensView.DataController.DataSource.DataSet.RecordCount <= 0 Then
      Exit(False);

    If Not fPergunta('Existem produtos com divergência de ST. Deseja preparar automaticamente a GNRE?', True) Then
      Exit(False);
    pCriarFormularios(TfrmPreparaGNRE, frmPreparaGNRE);
    Try
      cxgItensView.DataController.DataSource.DataSet.EnableControls;
      frmPreparaGNRE.dtsDados.DataSet := cxgItensView.DataController.DataSource.DataSet;
      frmPreparaGNRE.Showmodal;

      Result := frmPreparaGNRE.btnConfirma;
      blnPreviaGnreSuspensa := Not frmPreparaGNRE.btnConfirma;
    Finally
      pFreeAndNil(frmPreparaGNRE);
    End
  Finally
    If strFilter <> '' Then
    Begin
      cxgItensView.DataController.DataSource.DataSet.Filtered := False;
      cxgItensView.DataController.DataSource.DataSet.Filter := strFilter;
      cxgItensView.DataController.DataSource.DataSet.Filtered := True;
    End;

    cxgItensView.DataController.DataSource.DataSet.EnableControls;

  End;
end;

function TfrmEntNFEDivergencias.frxDivergenciasUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;
  If (SameText(MethodName, 'fGetValorCampo')) Then
    Result := fGetValorCampo(Trim(Params[0]));
end;

procedure TfrmEntNFEDivergencias.btnCadAbrFisICMClick(Sender: TObject);
  Var
    frmCadAbreviacaoFiscal: TfrmCadAbreviacaoFiscal;
begin
  inherited;
  If fVerificaAcessoSistema('frmCadAbrevFiscal', strLoginUsuarioLogado) Then
  Begin
    pCriarFormularios(TfrmCadAbreviacaoFiscal, frmCadAbreviacaoFiscal);
    Try
      frmCadAbreviacaoFiscal.strAbrExterna := cxgItensView.DataController.DataSource.DataSet.FieldByName('CODABF').AsString;
      frmCadAbreviacaoFiscal.Showmodal;
    Finally
      FreeAndNil(frmCadAbreviacaoFiscal)
    End;
  End
  Else
    fMensagem('ATENÇÃO', 'Esse usuário não tem acesso a esse recurso.', ['&OK'])
end;

procedure TfrmEntNFEDivergencias.btnCadAbrFisIpiClick(Sender: TObject);
begin
  inherited;
  If fVerificaAcessoSistema('frmCadAbreviacaoIPI', strLoginUsuarioLogado) Then
    pCriarForm(TfrmCadAbreviacaoIPI)
  else
    fMensagem('ATENÇÃO', 'Esse usuário não tem acesso a esse recurso.', ['&OK'])
end;

procedure TfrmEntNFEDivergencias.btnCadAbrFisPISClick(Sender: TObject);
begin
  inherited;
  If fVerificaAcessoSistema('frmCadAbreviacaoPIS', strLoginUsuarioLogado) Then
    pCriarForm(TfrmCadAbreviacaoPIS)
  else
    fMensagem('ATENÇÃO', 'Esse usuário não tem acesso a esse recurso.', ['&OK'])

end;

procedure TfrmEntNFEDivergencias.btnCadProClick(Sender: TObject);
begin
  inherited;
  
  pCriarFormularios(TfrmCadProdutos, frmCadProdutos);

  try
    With cxgItensView.DataController.DataSource.DataSet Do
      frmCadProdutos.strCodIteParaCarregar := FieldByName('CODITE').AsString;
    frmCadProdutos.ShowModal;
  finally
    pFreeAndNil(frmCadProdutos);
  end;
end;

procedure TfrmEntNFEDivergencias.btnCadAbrFisCOFClick(Sender: TObject);
begin
  inherited;
  If fVerificaAcessoSistema('frmCadAbreviacaoCOFINS', strLoginUsuarioLogado) Then
    pCriarForm(TfrmCadAbreviacaoCOFINS)
  else
    fMensagem('ATENÇÃO', 'Esse usuário não tem acesso a esse recurso.', ['&OK'])
end;

procedure TfrmEntNFEDivergencias.btnExpExcClick(Sender: TObject);
begin
  inherited;
  If TGeraExcel.fGerarRelatorio(cxgItensView, Self.Caption, pImprimeDetalhes) Then
    fMensagem('','Arquivo salvo com sucesso!', ['&OK'])
  else
    fMensagem('ATENÇÃO', 'Esse usuário não tem acesso a esse recurso.', ['&OK'])
end;

procedure TfrmEntNFEDivergencias.btnLiberarClick(Sender: TObject);
begin
  inherited;

  If rdgCSTCad.Visible And (rdgCSTCad.ItemIndex = -1) Then
  Begin
    pMensagemOk('Informe se deseja utilizar a CST da Nota Eletrônica ou do Cadastro de Abreviação Fiscal na Entrada de Mercadorias!');
    pSetFocus(rdgCSTCad);
    Exit;
  End;

  blnConfirma := fLiberaXMLDivergente;

  blnConfirma := blnConfirma;

  If blnConfirma Then
    Close;
end;

procedure TfrmEntNFEDivergencias.btnMotivosPedenciaClick(Sender: TObject);
  Var
    frmPedePendenciasNota: TfrmPedePendenciasNota;
begin
  inherited;

  Try
    pCriarFormularios(TfrmPedePendenciasNota, frmPedePendenciasNota);
    frmPedePendenciasNota.srtAutXMLVAL := strAutIncXMLVAL;
    frmPedePendenciasNota.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmEntNFEDivergencias.btnMotivosPedenciaClick');
    End;
  End;

  FreeAndNil(frmPedePendenciasNota);
end;

procedure TfrmEntNFEDivergencias.btnRejeitaNotaClick(Sender: TObject);
begin
  inherited;

  If fPergunta('Confirma a rejeição da nota?') Then
  Begin
    If TfrmEntImportaNotaElet.fExcluiNotaDivergencia(strAutIncXMLVAL) Then
    Begin
      pMensagemOk('Nota exlcuida com sucesso!');
      Close;
    End;
  End;

end;

procedure TfrmEntNFEDivergencias.cxgItensALQICMCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensDIF_ALQICM.Index]);

  If fEmptyStr(strDifere) Then
    Exit;

  Case strDifere[1] Of
     'S': Begin
            ACanvas.Brush.Color := clRed;
            pAddDivergencia(AViewInfo.Item, clRed);
          End;

     'A': Begin
            ACanvas.Brush.Color := clYellow;
            pAddDivergencia(AViewInfo.Item, clYellow);
          End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensALQIPICustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensDIF_ALQIPI.Index]);

  If fEmptyStr(strDifere) Then
    Exit;
                                           
  Case strDifere[1] Of
     'S': Begin
            ACanvas.Brush.Color := clRed;
            pAddDivergencia(AViewInfo.Item, clRed);
          End;

     'A': Begin
            ACanvas.Brush.Color := clYellow;
            pAddDivergencia(AViewInfo.Item, clYellow);
          End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensBASICMCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensDIF_BASICM.Index]);

  If fEmptyStr(strDifere) Then
    Exit;
                                           
  Case strDifere[1] Of
     'S': Begin
            ACanvas.Brush.Color := clRed;
            pAddDivergencia(AViewInfo.Item, clRed);
          End;

     'A': Begin
            ACanvas.Brush.Color := clYellow;
            pAddDivergencia(AViewInfo.Item, clYellow);
          End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensBASIPICustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensDIF_BASIPI.Index]);

  If fEmptyStr(strDifere) Then
    Exit;
                                           
  Case strDifere[1] Of
     'S': Begin
            ACanvas.Brush.Color := clRed;
            pAddDivergencia(AViewInfo.Item, clRed);
          End;

     'A': Begin
            ACanvas.Brush.Color := clYellow;
            pAddDivergencia(AViewInfo.Item, clYellow);
          End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensBASSUBCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensDIF_BASSUB.Index]);

  If fEmptyStr(strDifere) Then
    Exit;
                                           
  Case strDifere[1] Of
     'S': Begin
            ACanvas.Brush.Color := clRed;
            pAddDivergencia(AViewInfo.Item, clRed);
          End;

     'A': Begin
            ACanvas.Brush.Color := clYellow;
            pAddDivergencia(AViewInfo.Item, clYellow);
          End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensCLAFISCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensCODSITCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensDIF_CODSIT.Index]);

  If fEmptyStr(strDifere) Then
    Exit;

  Case strDifere[1] Of
     'S': Begin
            ACanvas.Brush.Color := clRed;
            pAddDivergencia(AViewInfo.Item, clRed);
          End;

     'A': Begin
            ACanvas.Brush.Color := clYellow;
            pAddDivergencia(AViewInfo.Item, clYellow);
          End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensCOFCSTCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensDIF_COFCST.Index]);

  If fEmptyStr(strDifere) Then
    Exit;

  Case strDifere[1] Of
     'S': Begin
            ACanvas.Brush.Color := clRed;
            pAddDivergencia(AViewInfo.Item, clRed);
          End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensCOFPCOFINSCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensDIF_COFPCOFINS.Index]);

  If fEmptyStr(strDifere) Then
    Exit;

  Case strDifere[1] Of
     'S': Begin
            ACanvas.Brush.Color := clRed;
            pAddDivergencia(AViewInfo.Item, clRed);
          End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensCOFVBCCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensDIF_COFVBC.Index]);

  If fEmptyStr(strDifere) Then
    Exit;

  Case strDifere[1] Of
     'S': Begin
            ACanvas.Brush.Color := clRed;
            pAddDivergencia(AViewInfo.Item, clRed);
          End;

     'A': Begin
            ACanvas.Brush.Color := clYellow;
            pAddDivergencia(AViewInfo.Item, clYellow);
          End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);

end;

procedure TfrmEntNFEDivergencias.cxgItensCOFVCOFINSCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensDIF_COFVCOFINS.Index]);

  If fEmptyStr(strDifere) Then
    Exit;

  Case strDifere[1] Of
     'S': Begin
            ACanvas.Brush.Color := clRed;
            pAddDivergencia(AViewInfo.Item, clRed);
          End;

     'A': Begin
            ACanvas.Brush.Color := clYellow;
            pAddDivergencia(AViewInfo.Item, clYellow);
          End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);

end;

procedure TfrmEntNFEDivergencias.cxgItensFATMVACustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensDIF_FATMVA.Index]);

  If fEmptyStr(strDifere) Then
    Exit;

  Case strDifere[1] Of
     'S': Begin
            ACanvas.Brush.Color := clRed;
            pAddDivergencia(AViewInfo.Item, clRed);
          End;

     'A': Begin
            ACanvas.Brush.Color := clYellow;
            pAddDivergencia(AViewInfo.Item, clYellow);
          End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensPISCSTCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
   strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensDIF_PISCST.Index]);

  If fEmptyStr(strDifere) Then
    Exit;

  Case strDifere[1] Of
   'S': Begin
          ACanvas.Brush.Color := clRed;
          pAddDivergencia(AViewInfo.Item, clRed);
        End;
   'A': Begin
          ACanvas.Brush.Color := clYellow;
          pAddDivergencia(AViewInfo.Item, clYellow);
        End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensPISPPISCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
   strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensDIF_PISPPIS.Index]);

  If fEmptyStr(strDifere) Then
    Exit;

  Case strDifere[1] Of
   'S': Begin
          ACanvas.Brush.Color := clRed;
          pAddDivergencia(AViewInfo.Item, clRed);
        End;
   'A': Begin
          ACanvas.Brush.Color := clYellow;
          pAddDivergencia(AViewInfo.Item, clYellow);
        End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensPISVBCCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
   strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensDIF_PISVBC.Index]);

  If fEmptyStr(strDifere) Then
    Exit;

  Case strDifere[1] Of
   'S': Begin
          ACanvas.Brush.Color := clRed;
          pAddDivergencia(AViewInfo.Item, clRed);
        End;
   'A': Begin
          ACanvas.Brush.Color := clYellow;
          pAddDivergencia(AViewInfo.Item, clYellow);
        End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensPISVPISCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
   strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensDIF_PISVPIS.Index]);

  If fEmptyStr(strDifere) Then
    Exit;

  Case strDifere[1] Of
   'S': Begin
          ACanvas.Brush.Color := clRed;
          pAddDivergencia(AViewInfo.Item, clRed);
        End;
   'A': Begin
          ACanvas.Brush.Color := clYellow;
          pAddDivergencia(AViewInfo.Item, clYellow);
        End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensVALICMCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensDIF_VALICM.Index]);

  If fEmptyStr(strDifere) Then
    Exit;
                                           
  Case strDifere[1] Of
     'S': Begin
            ACanvas.Brush.Color := clRed;
            pAddDivergencia(AViewInfo.Item, clRed);
          End;

     'A': Begin
            ACanvas.Brush.Color := clYellow;
            pAddDivergencia(AViewInfo.Item, clYellow);
          End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensVALIPICustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensDIF_VALIPI.Index]);

  If fEmptyStr(strDifere) Then
    Exit;
                                           
  Case strDifere[1] Of
     'S': Begin
            ACanvas.Brush.Color := clRed;
            pAddDivergencia(AViewInfo.Item, clRed);
          End;

     'A': Begin
            ACanvas.Brush.Color := clYellow;
            pAddDivergencia(AViewInfo.Item, clYellow);
          End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensVALSUBCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strDifere: String;
begin
  inherited;

  strDifere := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensDIF_VALSUB.Index]);

  If fEmptyStr(strDifere) Then
    Exit;

  Case strDifere[1] Of
     'S': Begin
            ACanvas.Brush.Color := clRed;
            pAddDivergencia(AViewInfo.Item, clRed);
            lblDivergenciaSTMensagem.Visible := True;
          End;

     'A': Begin
            ACanvas.Brush.Color := clYellow;
            pAddDivergencia(AViewInfo.Item, clYellow);
            lblDivergenciaSTMensagem.Visible := True;
          End;
  End;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.cxgItensVBCFCPSTCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pAteraFonte(Sender, ACanvas, AViewInfo);
end;

procedure TfrmEntNFEDivergencias.pAteraFonte(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
                   AViewInfo: TcxGridTableDataCellViewInfo);
  Var
    strXML: String;
begin
  inherited;

  strXML := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensELETRO.Index]);

  Case strXML[1] Of
     'S':  Begin
             If ACanvas.Brush.Color = clRed then
               ACanvas.Font.Color := clYellow
             Else
               ACanvas.Font.Color := clBlue;
           End;

      Else
       Begin
         If ACanvas.Brush.Color = clRed then
           ACanvas.Font.Color := clWhite
         Else
           ACanvas.Font.Color := clGreen;
       End;
  End;

end;

procedure TfrmEntNFEDivergencias.pAddDivergencia(coluna: TcxCustomGridTableItem; cor: TColor);
  Var
    strField : String;
begin
  If (coluna Is TcxGridDbColumn) Then
  Begin
    strField := (coluna As TcxGridDbColumn).DataBinding.FieldName;
    Case cor Of
      clRed:
      Begin
        If stlVermelho.IndexOf(strField) <= -1 Then
          stlVermelho.Add(strField);
      End;
      clYellow:
      Begin
        If stlAmarelo.IndexOf(strField) <= -1 Then
          stlAmarelo.Add(strField);
      End;
    End;
  End;
end;

Function TfrmEntNFEDivergencias.fCalculaBloqueio: Boolean;
  Var
    intRecNo : Integer;
    strIteAtu: String;
    blnBloque: Boolean;
    objTabela: TRegistroMsgLiberaTabela;
  	objLinha : TLinhaMsgLibera;

  function fFloat(strCampo : String) : String;
  Begin
    Try
      With cxgItensView.DataController.DataSource.DataSet Do
        Result := FormatFloat('#,##0.00', FieldByName(strCampo).AsFloat);
    
    except
      on e: exception do
        ShowmEssage(strCampo);
    End;
  End;

  function fMyAddDados(strCampo, strValXml, strValCad : String): Boolean;
  Begin

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('CAMPO'      , strIteAtu , 39 , alEsquerda );
    objLinha.pAddColuna('CAMPO'      , strCampo  , 15 , alEsquerda );
    objLinha.pAddColuna('VALOR XML'  , strValXml , 15 , alEsquerda );
    objLinha.pAddColuna('CADASTRO'   , strValCad , 15 , alEsquerda );
    objTabela.lstLinhas.Add(objLinha);

    strIteAtu := '';
    Result    := True;
  End;

  function fMyAddDadosField(strCampo, strField : String; blnFloat : Boolean = True): Boolean;
    Var
      strNfe, strCadastro : String;
  Begin
    With cxgItensView.DataController.DataSource.DataSet Do
    Begin
      If (FieldByName('ELETRO').AsString = 'S') Then
      Begin
        If blnFloat Then
          strNfe := fFloat(strField)
        Else
          strNfe := FieldByName(strField).AsString;
      End
      Else
      Begin
        if blnFloat then
          strCadastro := fFloat(strField)
        else
          strCadastro := FieldByName(strField).AsString;
      End;

      Next;

      If (FieldByName('ELETRO').AsString = 'S') Then
      Begin
        if blnFloat then
          strNfe := fFloat(strField)
        else
          strNfe := FieldByName(strField).AsString;
      End
      Else
      Begin
        if blnFloat then
          strCadastro := fFloat(strField)
        Else
          strCadastro := FieldByName(strField).AsString;
      End;

      Prior;

      Result := fMyAddDados(strCampo, strNfe, strCadastro);

    End;

  End;

  procedure pCarregaIteAtu;
  Begin
    With cxgItensView.DataController.DataSource.DataSet Do
      strIteAtu := FieldByName('CODITE').AsString + ' - ' + FieldByName('DESITE').AsString;
  End;

  procedure pAddCabecalho;
  Begin
    With cxgItensView.DataController.DataSource.DataSet Do
    Begin

      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTextoCaption('NUMERO DO DOCUMENTO', FieldByName('NUMDOC').AsString);
      objLiberacao.objMsgLibera.pAddTextoCaption('FORNECEDOR'         , FieldByName('FORNEC').AsString);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'CAMPO'      , 39 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'CAMPO'      , 15 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'VALOR XML'  , 15 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'CADASTRO'   , 15 , alEsquerda , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      pCarregaIteAtu;
    End;
  End;

  Var
    strFornec,
    strNumDoc : String;

Begin
  objLiberacao.clear;
  objLiberacao.objMsgLibera.pAddTexto('Valores do XML divergentes dos valores da Entrada de Mercadorias');

  With cxgItensView.DataController.DataSource.DataSet Do
  Begin
    intRecNo := RecNo;

    Try
      strFornec := '';
      strNumDoc := '';
      objTabela := TRegistroMsgLiberaTabela.Create;

      DisableControls;
      First;
      pCarregaIteAtu;

      blnBloque:= false;

      While not Eof do
      Begin
        if (strFornec <> FieldByName('FORNEC').AsString) or
           (strNumDoc <> FieldByName('NUMDOC').AsString) Then
        begin
          if RecNo > 1 then
          begin
            if objTabela.lstLinhas.Count > 1 then
            begin
              objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
              objTabela := TRegistroMsgLiberaTabela.Create;
            end;

          end;

          pAddCabecalho;
        end;

        if FieldByName('DIF_CODSIT').AsString = 'S' then
          blnBloque := fMyAddDadosField('CST', 'CODSIT', False);

        if FieldByName('DIF_BASICM').AsString = 'S' then
          blnBloque := fMyAddDadosField('Base de ICMS', 'BASICM');

        if FieldByName('DIF_ALQICM').AsString = 'S' then
          blnBloque := fMyAddDadosField('Aliquota de ICMS', 'ALQICM');

        if FieldByName('DIF_VALICM').AsString = 'S' then
          blnBloque := fMyAddDadosField('Valor do ICMS', 'VALICM');

        if FieldByName('DIF_BASSUB').AsString = 'S' then
          blnBloque := fMyAddDadosField('Base da ST', 'BASSUB');

        if FieldByName('DIF_VALSUB').AsString = 'S' then
          blnBloque := fMyAddDadosField('Valor da ST', 'VALSUB');

        if FieldByName('DIF_FATMVA').AsString = 'S' then
          blnBloque := fMyAddDadosField('Valor do MVA', 'FATMVA');

        if FieldByName('DIF_BASIPI').AsString = 'S' then
          blnBloque := fMyAddDadosField('Base do IPI', 'BASIPI');

        if FieldByName('DIF_ALQIPI').AsString = 'S' then
          blnBloque := fMyAddDadosField('Aliquota do IPI', 'ALQIPI');

        if FieldByName('DIF_VALIPI').AsString = 'S' then
          blnBloque := fMyAddDadosField('Valor do IPI', 'VALIPI');

        if blnVALELE then
        begin
          if FieldByName('DIF_PFCPST').AsString = 'S' then
            blnBloque := fMyAddDadosField('Alíquota FCP ST', 'PFCPST');

          if FieldByName('DIF_VFCPST').AsString = 'S' then
            blnBloque := fMyAddDadosField('Valor FCP ST', 'VFCPST');
        end;

        // Pis Cof
        If FieldByName('DIF_PISCST').AsString = 'S' Then
          blnBloque := fMyAddDadosField('CST PIS', 'PISCST', False);
        If FieldByName('DIF_PISVBC').AsString  = 'S' then
          blnBloque := fMyAddDadosField('Base. PIS', 'PISVBC');
        If FieldByName('DIF_PISPPIS').AsString = 'S' then
          blnBloque := fMyAddDadosField('Alq. PIS', 'PISPPIS');
        If FieldByName('DIF_PISVPIS').AsString = 'S' then
          blnBloque := fMyAddDadosField('Vlr. PIS', 'PISVPIS');
        If FieldByName('DIF_COFCST').AsString = 'S' then
          blnBloque := fMyAddDadosField('CST COFINS', 'COFCST', fALSE);
        If FieldByName('DIF_COFVBC').AsString = 'S' then
          blnBloque := fMyAddDadosField('Base. COFINS', 'COFVBC');
        If FieldByName('DIF_COFPCOFINS').AsString = 'S' then
          blnBloque := fMyAddDadosField('Alq. COFINS', 'COFPCOFINS');
        If FieldByName('DIF_COFVCOFINS').AsString = 'S' then
          blnBloque := fMyAddDadosField('Vlr. COFINS', 'COFVCOFINS');

        strFornec := FieldByName('FORNEC').AsString;
        strNumDoc := FieldByName('NUMDOC').AsString;

        // São 2 Registros por Linha um da NFE outro do Cadastro.
        Next;
        Next;

        pCarregaIteAtu;
      End;

      if objTabela.lstLinhas.Count > 1 then
        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela)
      else
        FreeAndNil(objTabela);

    Finally
      If (intRecNo <> 0) And (intRecNo <= RecordCount) Then
        RecNo := intRecNo;

      EnableControls;
    End;

  End;

  Result := blnBloque;
End;

Function TfrmEntNFEDivergencias.fLiberaXMLDivergente: Boolean;
Begin
  strOpeLib := '';
  If blnBloqueiaNFE Then
  begin
    objLiberacao.strDirAce := 'XMLDIF';
    objLiberacao.strSenLib := fCfgSis('XMLDIF');
    objLiberacao.strMsgSen := 'XML Divergente';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;

    strOpeLib := objLiberacao.strOperador;
    HoraLiberacao := fNow;
  end
  Else
    Result := (fMensagem('ATENÇÃO', 'Deseja Liberar a importação mesmo contendo Divergências dentro da Tolerancia?', ['&Sim', '&Não']) = 1);

End;

function TfrmEntNFEDivergencias.fCampoDeveSerPintadoDeVermelho(Dados: TDataSet; Campo: string): Boolean;
Begin
  Result := False;
  If Dados.FieldByName('DIF_' + Campo).AsString = 'S' Then
    Result := True;
End;

procedure TfrmEntNFEDivergencias.pImprimeDetalhes(Excel: TExcel;
  Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
  Var
    intCnt : Integer;
    strRange : String;
begin
  With Excel, Campos Do
  Begin
    If (Dados.FindField('ELETRO') <> Nil) Then
    Begin
      If (Dados.FieldByName('ELETRO').AsString = 'S') Then
        CorFonte('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul)
      Else
        CorFonte('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Verde)
    End;

    For intCnt := 0 To stlVermelho.Count -1 Do
    Begin
      If fCampoDeveSerPintadoDeVermelho(Dados, stlVermelho.Strings[intCnt]) Then
      Begin
        strRange  := fGetLetraAlfa(ColunaPorNome[ stlVermelho.Strings[intCnt] ].Coluna) + IntToStr(LinhaAtual);
        CorFundo(strRange, strRange, Vermelho);
      End;
    End;

    For intCnt := 0 To stlAmarelo.Count -1 Do
    Begin
      strRange  := fGetLetraAlfa(ColunaPorNome[ stlAmarelo.Strings[intCnt] ].Coluna) + IntToStr(LinhaAtual);
      CorFundo(strRange, strRange, Amarelo);
    End;
  End;
end;

procedure TfrmEntNFEDivergencias.btnExpPdfClick(Sender: TObject);
begin
  inherited;
  pExportarPDF;
end;

procedure TfrmEntNFEDivergencias.pExportarPDF;
begin
 Try
    //frxDivergencias.LoadFromFile('C:\Users\prgintegracao_31\Desktop\Report_NFEDivergencias.fr3', True);
    frxDBDivergencias.DataSource := cxgItensView.DataController.DataSource;
    frxDivergencias.AddFunction('function fGetValorCampo(strCampo: String):String');
    frxDivergencias.Variables['EMPRESA'] := QuotedStr(fRetNomeEmpresa);

    TfrxMemoView(frxDivergencias.FindComponent('memoExplicativo')).Lines.Text := 'Divergências entre os valores dos XMLs e os calculados na Entrada de Mercadorias    -   ' + TVersaoExecutavel.GetTituloVersao + ' - Emp: ' + VS_strCodEmp;
    TfrxMemoView(frxDivergencias.FindComponent('memoFornec')).Lines.Text      := 'Fornecedor: ' + cxgItensView.DataController.DataSource.DataSet.FieldByName('FORNEC').AsString;
    TfrxMemoView(frxDivergencias.FindComponent('memoNumdoc')).Lines.Text      := 'Documento: ' + cxgItensView.DataController.DataSource.DataSet.FieldByName('NUMDOC').AsString;
    TfrxMemoView(frxDivergencias.FindComponent('memoLegDiv')).Lines.Text      :=  lblTolerancia.Caption;

    TfrxMemoView(frxDivergencias.FindComponent('memoCSTPIST')).Visible  := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoBasePIST')).Visible := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoAliqPIST')).Visible := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoVlrPIST')).Visible  := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoCSTCOFT')).Visible  := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoBaseCOFT')).Visible := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoAlqCOFT')).Visible  := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoVlrCOFT')).Visible  := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoCSTPPIS')).Visible  := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoBasePIS')).Visible  := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoAliqPIS')).Visible  := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoVLRPIS')).Visible   := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoCSTCOF')).Visible   := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoBASECOF')).Visible  := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoAlqCOF')).Visible   := blnValidaPisCofins;
    TfrxMemoView(frxDivergencias.FindComponent('memoVlrCOF')).Visible   := blnValidaPisCofins;

    TfrxReportPage(frxDivergencias.Pages[1]).PaperWidth := IIF(Not blnValidaPisCofins, 505, 655);
    frxDivergencias.PrepareReport;
    //frxDivergencias.ShowReport;
    If fodDestino.Execute Then
    Begin
      frxPDFExport.FileName := fodDestino.FileName + '.pdf';
      frxDivergencias.Export(frxPDFExport);
    End;

    pMensagemOk('Arquivo PDF gerado em: ' + #13 + frxPDFExport.FileName);
  Except On
    E:Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmEntNFEDivergencias.pExportarPDF');
    End;
  End;
end;

function TfrmEntNFEDivergencias.fGetValorCampo(strCampo: String):String;
begin
  If Assigned(cxgItensView.DataController.DataSource.DataSet.FindField(strCampo)) Then
    Result := cxgItensView.DataController.DataSource.DataSet.FieldByName(strCampo).AsString
  Else
    Result := '';
end;

procedure TfrmEntNFEDivergencias.bntReprocessaAbvFiscalClick(Sender: TObject);
begin
  blnReprocessar := True;
  Close;
end;

end.
