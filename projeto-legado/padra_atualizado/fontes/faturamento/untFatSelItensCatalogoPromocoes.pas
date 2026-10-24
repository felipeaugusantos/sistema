unit untFatSelItensCatalogoPromocoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  DateUtils, BitBtnLockedIncrem, UniClientDataSet, DB, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, Generics.Collections, Uni, untFuncFatTypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, QColorLabel,
  Vcl.Mask, MaskEditFocus, EditFocus, ComboBoxFocus, untTypesSistema,
  frxExportPDF, frxDBSet, System.ImageList, Vcl.ImgList, cxImageList, Vcl.ComCtrls,
  Promocao.Classes.CatalogoPromocao, untFuncFat, Datasnap.DBClient,
  untFrameFiltrosCatPromocao;

type
  TfrmFatSelItensCatalogoPromocoes = class(TfrmPai)
    dtsDados: TDataSource;
    btnGerarRelatorio: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    Shape1: TShape;
    btnPadrao: TBitBtnLocked;
    btnInverterSelecao: TBitBtnLocked;
    frxRelJato: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    frxExpPDF: TfrxPDFExport;
    btnEnviarEmailRelatorio: TBitBtnLocked;
    cxImageCollection1: TcxImageCollection;
    pnlDados: TPanel;
    grdItens: TcxGridCitel;
    grdItensTableView: TcxGridDBTableViewCitel;
    grdItensLevel1: TcxGridLevel;
    pnlLegendas: TPanel;
    pnlLegendaSelecionados: TPanel;
    Shape2: TShape;
    Label5: TLabel;
    pnlLegendaEmPromocao: TPanel;
    shpPromocao: TShape;
    Label4: TLabel;
    pnlFiltros: TPanel;
    pnlBotoesPesquisa: TPanel;
    btnPesquisar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    frameFiltrosCatPromocao: TframeFiltrosCatPromocao;
    procedure grdItensTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdItensTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdItensTableViewDblClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdItensTableViewColumnSizeChanged(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure grdItensTableViewColumnPosChanged(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnPadraoClick(Sender: TObject);
    procedure btnInverterSelecaoClick(Sender: TObject);

    procedure btnGerarRelatorioClick(Sender: TObject);
    procedure btnEnviarEmailRelatorioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    blnRestaurandoPadrao: Boolean;
    intAltpnlFiltrosOri: Integer;

    procedure pGerarRelatorio;
    procedure pMarcarIndividual;
    procedure pMarcarDesmarcaTodos(blnStatus: Boolean);
    procedure pMarcarTodos;
    procedure pDesmarcarTodos;
    procedure pInverterSelecao;
    procedure pMarcar(blnStatus: Boolean);
    procedure pCarregarItens;
    procedure pEscondeCampos;
    procedure pCarregarLayoutGrid;
    procedure pSalvarLayoutGrid;
    procedure pGerarArquivo(AEnviarEmail : Boolean);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strCndPag: String;
    strCodCli: String;
    blnModoFiltrosGeracaoGlobal: Boolean;
    objCatProm : TCatalogoPromocao;

    fRetornaValorUnitarioLiquido: function(strCodIte: String; fltUnitarTmp, fltDesCon, fltDesAvi: Double): Double of object;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untDigMotivoVendaPerdida, untObservacao,
  untVendasPerdidas, untConsultas, untPesqItem,
  untFuncoesConsulta, untCadPro, untLegendasItem, untFuncoesImagem,
  untFuncoesGenerica, untInputDialog, untTEnvioEmail, untDisparaEmailAut,
  untImagemBase64, untLiberacao, untCrmCatalogoPromocao;

procedure TfrmFatSelItensCatalogoPromocoes.btnEnviarEmailRelatorioClick(Sender: TObject);
begin
  pGerarArquivo(True);
end;

procedure TfrmFatSelItensCatalogoPromocoes.btnGerarRelatorioClick(
  Sender: TObject);
begin
  inherited;
  fExecutarModal(pGerarRelatorio, 'Aguarde, Gerando relatório ...', '');
end;

procedure TfrmFatSelItensCatalogoPromocoes.btnInverterSelecaoClick(
  Sender: TObject);
begin
  inherited;
  fExecutarModal(pInverterSelecao, 'Aguarde, invertendo seleção dos produtos ...', '');
end;

procedure TfrmFatSelItensCatalogoPromocoes.btnCancelarClick(Sender: TObject);
begin
  inherited;

  If Assigned(objCatProm.cdsDados) Then
  Begin
    objCatProm.pLimpar;
    objCatProm.pLimparDadosConsulta;
  End;

  frameFiltrosCatPromocao.pLimparFiltros;

  SelectFirst;
end;

procedure TfrmFatSelItensCatalogoPromocoes.btnPadraoClick(Sender: TObject);
begin
  inherited;
  Try
    blnRestaurandoPadrao := True;
    grdItensTableView.ClearItems;
    grdItensTableView.DataController.CreateAllItems;
    pEscondeCampos;
    grdItensTableView.ApplyBestFit();
    pSalvarLayoutGrid;
  Finally
    blnRestaurandoPadrao := False;
    fExecutarModal(pCarregarItens, 'Aguarde, pesquisando produtos ...', '');
  End;
end;

procedure TfrmFatSelItensCatalogoPromocoes.btnPesquisarClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) Then
    fExecutarModal(pCarregarItens, 'Aguarde, pesquisando produtos ...', '');

  dtsDados.DataSet := objCatProm.cdsDados;

  If Assigned(objCatProm.cdsDados) Then
  Begin
    grdItensTableView.ClearItems;
    grdItensTableView.DataController.CreateAllItems;
    pCarregarLayoutGrid;
    grdItensTableView.NavigatorButtons.First.Click;

    pEscondeCampos;

    pSetFocus(grdItens);
  End;
end;

procedure TfrmFatSelItensCatalogoPromocoes.pGerarArquivo(AEnviarEmail: Boolean);
begin
  Try
    objCatProm.pGerarArquivo(True, AEnviarEmail, False);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFatSelItensCatalogoPromocoes.pGerarArquivo]');
    End;
  End;
end;

procedure TfrmFatSelItensCatalogoPromocoes.pGerarRelatorio;
begin
  pGerarArquivo(False);
end;

procedure TfrmFatSelItensCatalogoPromocoes.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pDesmarcarTodos, 'Aguarde, desmarcando todos os produtos ...', '');
end;

procedure TfrmFatSelItensCatalogoPromocoes.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pMarcarTodos, 'Aguarde, marcando todos os produtos ...', '');
end;

procedure TfrmFatSelItensCatalogoPromocoes.FormCreate(Sender: TObject);
begin
  inherited;

  intAltpnlFiltrosOri := pnlFiltros.Height;

  objCatProm := TCatalogoPromocao.Create;

  frameFiltrosCatPromocao.ParentForm := Self;
  frameFiltrosCatPromocao.blnFiltrosProm := True;

  pSetaCodIte(frameFiltrosCatPromocao.edtCodItePrm);
end;

procedure TfrmFatSelItensCatalogoPromocoes.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(objCatProm) Then
    FreeAndNil(objCatProm);
end;

procedure TfrmFatSelItensCatalogoPromocoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F5: If btnMarcarTodos.Enabled And btnMarcarTodos.Visible Then btnMarcarTodos.Click;
    VK_F6: If btnDesmarcarTodos.Enabled And btnDesmarcarTodos.Visible Then btnDesmarcarTodos.Click;
    VK_F7: If btnInverterSelecao.Enabled And btnInverterSelecao.Visible Then btnInverterSelecao.Click;
    VK_F10: If btnGerarRelatorio.Enabled And btnGerarRelatorio.Visible Then btnGerarRelatorio.Click;
    VK_F11: If btnEnviarEmailRelatorio.Enabled And btnEnviarEmailRelatorio.Visible Then btnEnviarEmailRelatorio.Click;
    VK_ESCAPE: pEscapePressed;
  End;
end;

procedure TfrmFatSelItensCatalogoPromocoes.FormShow(Sender: TObject);
begin
  inherited;

  objCatProm.pIniciaRelatorio(frxRelJato, frxExpPDF, frxRelatorio);

  frameFiltrosCatPromocao.strCndPag := strCndPag;
  frameFiltrosCatPromocao.strCodCli := strCodCli;
  frameFiltrosCatPromocao.pInicializaFiltros;

  blnRestaurandoPadrao := False;

  shpPromocao.Brush.Color := ARRCOR_SITUACAO_ITEM[sitPromocao];

  btnCancelar.Click;
end;

function TfrmFatSelItensCatalogoPromocoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    Result := frameFiltrosCatPromocao.fValidaCampos(Sender, blnBuscaPorChave);
  End;

  If Not Result Then
    pSetFocus(Sender)
end;

procedure TfrmFatSelItensCatalogoPromocoes.grdItensTableViewColumnPosChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;

  pSalvarLayoutGrid;
end;

procedure TfrmFatSelItensCatalogoPromocoes.grdItensTableViewColumnSizeChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;

  pSalvarLayoutGrid;
end;

procedure TfrmFatSelItensCatalogoPromocoes.grdItensTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

  function fGridFocado: Boolean;
  begin
    Result := Assigned(ActiveControl) And fCheckParent(ActiveControl, grdItens);
  end;

begin
  inherited;

  If Not Assigned(objCatProm.cdsDados)Then
    Exit;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
              grdItensTableView.GetColumnByFieldName('Marcado').Index]) = 'S' Then
  Begin
    If AViewInfo.Selected And fGridFocado Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clBlue;
  End
  Else If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                   grdItensTableView.GetColumnByFieldName('Promoção').Index]) <> '' Then
  Begin
    If AViewInfo.Selected And fGridFocado Then
      ACanvas.Font.Color := clYellow
    Else
      ACanvas.Font.Color := ARRCOR_SITUACAO_ITEM[sitPromocao];
  End;
end;

procedure TfrmFatSelItensCatalogoPromocoes.grdItensTableViewDblClick(
  Sender: TObject);
begin
  inherited;

  pMarcarIndividual;
end;

procedure TfrmFatSelItensCatalogoPromocoes.grdItensTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_RETURN Then
    pMarcarIndividual;
end;

procedure TfrmFatSelItensCatalogoPromocoes.pCarregarItens;
begin

  Try
    objCatProm.pLimpar;
    objCatProm.strCodCli := strCodCli;
    frameFiltrosCatPromocao.pSetParamObjCatProm(objCatProm);
    objCatProm.pConsultarGeral;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFatSelItensCatalogoPromocoes.pCarregarItens]');
    End;
  End;
end;

procedure TfrmFatSelItensCatalogoPromocoes.pCarregarLayoutGrid;
  Var
    intRecNo: Integer;
begin

  fGetFuncoesCxGrid.fCarregarView(grdItensTableView,
    Self.Name + '_' + grdItensTableView.Name, objCatProm.cdsDados, intRecNo);
end;

procedure TfrmFatSelItensCatalogoPromocoes.pDesmarcarTodos;
begin
  pMarcarDesmarcaTodos(False);
end;

procedure TfrmFatSelItensCatalogoPromocoes.pEscondeCampos;
begin
  Try
    grdItensTableView.GetColumnByFieldName('Cliente').Visible := False;
    grdItensTableView.GetColumnByFieldName('Marcado').Visible := False;
    grdItensTableView.GetColumnByFieldName('Promoção').Visible := False;
    grdItensTableView.GetColumnByFieldName('Preço Custo').Visible := False;
    grdItensTableView.GetColumnByFieldName('Código de Fábrica').Visible := False;
    grdItensTableView.GetColumnByFieldName('Preço').Visible := False;
    grdItensTableView.GetColumnByFieldName('CaminhoImagem').Visible := False;
    grdItensTableView.GetColumnByFieldName('Montadora').Visible := False;
    grdItensTableView.GetColumnByFieldName('Aplicacao').Visible := False;
    grdItensTableView.GetColumnByFieldName('IndiceImagem').Visible := False;
    grdItensTableView.GetColumnByFieldName('ThumGerado').Visible := False;
    grdItensTableView.GetColumnByFieldName('ImgCarregada').Visible := False;
    grdItensTableView.GetColumnByFieldName('AUTINCIMG').Visible := False;
    grdItensTableView.GetColumnByFieldName('Margem').Visible := fVerificaAcessoSistema('CRMCMG');
    grdItensTableView.GetColumnByFieldName('Preço c/ Imp. c/').Visible := frameFiltrosCatPromocao.chkPrecoImposto.Checked;
    grdItensTableView.GetColumnByFieldName('Preço Promoção c/ Imp.').Visible := frameFiltrosCatPromocao.chkPrecoImposto.Checked;
    grdItensTableView.GetColumnByFieldName('Preço com Impostos').Visible := frameFiltrosCatPromocao.chkPrecoImposto.Checked;
    grdItensTableView.GetColumnByFieldName('ITE_DESMAX').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CODGRU').Visible := False;
    grdItensTableView.GetColumnByFieldName('UNI_CODUNI').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CODFOR').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_COMLUB').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_IPISAI').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_COMVAR').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_COMATA').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_COMDIS').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_IMPULT').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREULT').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREMED').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CLAIPI').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PESOIT').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PESLIQ').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CODFAB').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_MARMIN').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_MARMSG').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_MARMGE').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CODMAR').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PRECOM').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_QTPPRO').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_IPIENT').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_FREENT').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PRECUS').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CODABF').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_OBRCPF').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CODBAR').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREVE1').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREVE2').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREVE3').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CODBAR').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREVE4').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREVE5').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREVE6').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREVE7').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_DTAUVE').Visible := False;
    grdItensTableView.GetColumnByFieldName('QTDIA_SVND').Visible := False;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFatSelItensCatalogoPromocoes.pEscondeCampos]');
    End;
  End;
end;

procedure TfrmFatSelItensCatalogoPromocoes.pInverterSelecao;
  Var
    intRowNum: Integer;
begin
  If Assigned(objCatProm.cdsDados) Then
  With objCatProm.cdsDados Do
  Begin
    intRowNum := RecNo;
    DisableControls;
    Try
      First;
      While Not Eof Do
      Begin
        pMarcar(FieldByName('Marcado').AsString <> 'S');
        Next;
      End;
    Finally
      RecNo := intRowNum;
      EnableControls;
    End;
  End;
end;

procedure TfrmFatSelItensCatalogoPromocoes.pMarcar(blnStatus: Boolean);
begin
  If blnStatus Then
  Begin
    objCatProm.cdsDados.Edit;
    objCatProm.cdsDados.FieldByName('Marcado').AsString := 'S';
    objCatProm.cdsDados.Post;
  End
  Else
  Begin
    objCatProm.cdsDados.Edit;
    objCatProm.cdsDados.FieldByName('Marcado').AsString := 'N';
    objCatProm.cdsDados.Post;
  End;
end;

procedure TfrmFatSelItensCatalogoPromocoes.pMarcarIndividual;
begin
  If (objCatProm.cdsDados.FieldByName('Marcado').AsString = 'N') Then
    pMarcar(True)
  Else
    pMarcar(False);
  grdItensTableView.NavigatorButtons.Next.Click;
end;

procedure TfrmFatSelItensCatalogoPromocoes.pMarcarTodos;
begin
  pMarcarDesmarcaTodos(True);
end;

procedure TfrmFatSelItensCatalogoPromocoes.pMarcarDesmarcaTodos(blnStatus: Boolean);
  Var
    intRowNum: Integer;
begin
  If Assigned(objCatProm.cdsDados) Then
  With objCatProm.cdsDados Do
  Begin
    intRowNum := RecNo;
    DisableControls;
    Try
      First;
      While Not Eof Do
      Begin
        pMarcar(blnStatus);
        Next;
      End;
    Finally
      RecNo := intRowNum;
      EnableControls;
    End;
  End;
end;

procedure TfrmFatSelItensCatalogoPromocoes.pSalvarLayoutGrid;
begin
  fGetFuncoesCxGrid.pSalvarView(grdItensTableView,
    Self.Name + '_' + grdItensTableView.Name, objCatProm.cdsDados);
end;

end.
