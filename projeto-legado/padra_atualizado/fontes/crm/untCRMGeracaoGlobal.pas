unit untCRMGeracaoGlobal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, ComboBoxFocus, EditFocus, Vcl.Mask, MaskEditFocus, untGravando,
  cxProgressBar, StrUtils, Data.DB, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGridCitel, cxClasses, cxGridLevel,
  cxGrid, System.ImageList, Vcl.ImgList, cxTextEdit, DateUtils, Vcl.DBCtrls,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.ComCtrls,
  DBEditFocus, untTCRMGeracaoGlobal, untCRMGeracaoGlobalFrameParametros,
  Vcl.Samples.Spin, UniClientDataSet, Promocao.Classes.CatalogoPromocao, untCrmCatalogoPromocao,
  untFatSelItensCatalogoPromocoes, frxExportPDF, frxDBSet;

type
  TcxViewInfoAcess = class(TcxGridTableDataCellViewInfo);
  TcxPainterAccess = class(TcxGridTableDataCellPainter);

  TfrmCRMGeracaoGlobal = class(TfrmPai)
    Notebook: TNotebook;
    pnlDados: TPanel;
    Shape1: TShape;
    imgLista: TImageList;
    fraCRMGeracaoGlobalFrameParametros: TfraCRMGeracaoGlobalFrameParametros;
    btnCarregarDados: TBitBtnLocked;
    btnAcoesAutomaticas: TBitBtnLocked;
    pnlBtnDadosCarregados: TPanel;
    btnConfirma: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmTodos: TBitBtnLocked;
    pnlQtdMarcar: TPanel;
    lblQtdMarcar: TLabel;
    speQtdMarcar: TSpinEdit;
    btnMarcarPorQtde: TBitBtnLocked;
    lblQtdCli: TLabel;
    PCDados: TPageControl;
    tsDadosCliente: TTabSheet;
    tsDadosPromocaoGeral: TTabSheet;
    cxDados: TcxGridCitel;
    cxDadosTableView: TcxGridDBTableViewCitel;
    cxDadosTableViewColumnMARCA: TcxGridDBColumn;
    cxDadosTableViewColumn1: TcxGridDBColumn;
    cxDadosTableViewColumn2: TcxGridDBColumn;
    cxDadosTableViewColumn3: TcxGridDBColumn;
    cxDadosTableViewColumn4: TcxGridDBColumn;
    cxDadosTableViewColumn5: TcxGridDBColumn;
    cxDadosTableViewColumn6: TcxGridDBColumn;
    cxDadosTableViewColumn7: TcxGridDBColumn;
    cxDadosTableViewColumn8: TcxGridDBColumn;
    cxDadosTableViewColumn9: TcxGridDBColumn;
    cxDadosTableViewColumn10: TcxGridDBColumn;
    cxDadosTableViewColumn11: TcxGridDBColumn;
    cxDadosTableViewColumn12: TcxGridDBColumn;
    cxDadosTableViewColumn13: TcxGridDBColumn;
    cxDadosTableViewColumn14: TcxGridDBColumn;
    cxDadosTableViewColumn15: TcxGridDBColumn;
    cxDadosTableViewColumn16: TcxGridDBColumn;
    cxDadosTableViewColumn17: TcxGridDBColumn;
    cxDadosTableViewColumn18: TcxGridDBColumn;
    cxDadosTableViewColumn19: TcxGridDBColumn;
    cxDadosTableViewColumn20: TcxGridDBColumn;
    cxDadosTableViewColumn21: TcxGridDBColumn;
    cxDadosTableViewColumn22: TcxGridDBColumn;
    cxDadosTableViewColumn23: TcxGridDBColumn;
    cxDadosTableViewColumn24: TcxGridDBColumn;
    cxDadosTableViewColumnESPORC: TcxGridDBColumn;
    cxDadosTableViewColumnVLRORC: TcxGridDBColumn;
    cxDadosLevel1: TcxGridLevel;
    pnlPromocao: TPanel;
    frxRelatorio: TfrxDBDataset;
    frxExpPDF: TfrxPDFExport;
    frxRelJato: TfrxReport;
    tsDadosPromocaoPorCliente: TTabSheet;
    pnlPromocaoCliente: TPanel;
    cxDadosTableViewColumn25: TcxGridDBColumn;
    cxDadosTableViewColumn26: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCarregarDadosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxDadosTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure cxDadosTableViewKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnDesmTodosClick(Sender: TObject);
    procedure btnAcoesAutomaticasClick(Sender: TObject);
    procedure cxDadosTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarPorQtdeClick(Sender: TObject);
    procedure PCDadosChange(Sender: TObject);
  private
    frmGrav : TfrmGravando;
    FCRMGeracaoGlobal: TCRMGeracaoGlobal;
    frmCrmCatalogoPromocaoGeral: TfrmCrmCatalogoPromocao;
    frmCrmCatalogoPromocaoCliente: TfrmCrmCatalogoPromocao;

    function fAbreDados: Boolean;
    function fAbreDadosProgresso(cxProgress : TcxProgressBar) : Boolean;

    procedure pMarcarTodos;
    procedure pMarcarAleatorio;
    procedure pReset;
    function getCRMGeracaoGlobal: TCRMGeracaoGlobal;
    procedure pExibirTabDadosPromocao;
    procedure pCarregarDadosPromocao;
    procedure pCarregarDadosPromocaoGeral;
    procedure pCarregarDadosPromocaoPorCliente;
    procedure pExibirDadosPromocaoGeral;
    procedure pExibirDadosPromocaoCliente;
    procedure pAjustarBotoesRodapeTsPromocao(const blnHabilitar: Boolean);
    procedure pAjustarBotoesRodapeTsCliente(const blnHabilitar: Boolean);

  public
    strCodCli : String;

  Protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean): Boolean;Override;
  end;

var
  frmCRMGeracaoGlobal: TfrmCRMGeracaoGlobal;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untCadMovOcorrencias, untAtualizaOcorrenciasCRM,
  untFuncoesCRM, untCadAcaoAutomaticaCRM;

procedure TfrmCRMGeracaoGlobal.btnMarcarPorQtdeClick(Sender: TObject);
begin
  inherited;

  If (speQtdMarcar.Value <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informar a quantidade!', ['&O k']);
    pSetFocus(speQtdMarcar);
    Exit;
  End;

  getCRMGeracaoGlobal().pDesmarcaTodos();
  cxDadosTableView.Site.Repaint;

  pMarcarAleatorio;
end;

procedure TfrmCRMGeracaoGlobal.btnAcoesAutomaticasClick(Sender: TObject);
  Var
    frmCadAcaoAutomaticaCRM: TFrmCadAcaoAutomaticaCRM;
begin
  inherited;
  If Not btnAcoesAutomaticas.Visible Then
    Exit;

  pCriarFormularios(TFrmCadAcaoAutomaticaCRM, frmCadAcaoAutomaticaCRM);

  Try
    frmCadAcaoAutomaticaCRM.ShowModal;
  Finally
    FreeAndNil(frmCadAcaoAutomaticaCRM);
  End;
end;

procedure TfrmCRMGeracaoGlobal.btnCarregarDadosClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  fraCRMGeracaoGlobalFrameParametros.pSetaParamClass();

  tsDadosPromocaoGeral.TabVisible := False;
  tsDadosPromocaoPorCliente.TabVisible := False;

  If fAbreDados Then
  Begin
    pMarcarTodos;
    Self.WindowState            := wsMaximized;
    Notebook.PageIndex          := 1;
    pnlBtnDadosCarregados.Visible := True;
    btnCarregarDados.Visible    := False;
    btnAcoesAutomaticas.Visible := False;

    PCDados.ActivePage := tsDadosCliente;
    pAjustarBotoesRodapeTsCliente(True);

    pnlInfo.Caption             := '[ ENTER ] - Para marcar/desmarcar o registro selecionado';

    pExibirTabDadosPromocao;

    pSetFocus(cxDados);
  End
  Else
  Begin
    fMensagem('', 'Sem dados para exibir!', ['&OK']);
    fraCRMGeracaoGlobalFrameParametros.pgcFiltrosChange(fraCRMGeracaoGlobalFrameParametros.pgcFiltros);
  End;
end;

procedure TfrmCRMGeracaoGlobal.btnConfirmaClick(Sender: TObject);
var
  frmCadMovOcorrencias : TfrmCadMovOcorrencias;
Begin
  inherited;
  Try
    pCriarFormularios(TfrmCadMovOcorrencias,frmCadMovOcorrencias);
    frmCadMovOcorrencias.strCodCli := '00000000';
    frmCadMovOcorrencias.edtDesCodCli.Text := 'Geração global de ocorrência';
    frmCadMovOcorrencias.blnGeracaoGlobalOcorrencias := True;
    frmCadMovOcorrencias.strCodEmp := VS_strCodEmp;
    frmCadMovOcorrencias.strOperac := 'Coleta';

    If frmCadMovOcorrencias.ShowModal = MrOK Then
    Begin
      getCRMGeracaoGlobal().ParamCRM.dtaDtaAge := frmCadMovOcorrencias.qryTabelaProp.FieldByName('OCO_DTAAGE').AsDateTime;
      getCRMGeracaoGlobal().ParamCRM.horHorAge := frmCadMovOcorrencias.qryTabelaProp.FieldByName('OCO_HORAGE').AsDateTime;
      getCRMGeracaoGlobal().ParamCRM.strOpeOco := IIF(fEmptyStr(frmCadMovOcorrencias.qryTabelaProp.FieldByName('OCO_OPEOCO').AsString),
                                                      strLoginUsuarioLogado,
                                                      frmCadMovOcorrencias.qryTabelaProp.FieldByName('OCO_OPEOCO').AsString);
      getCRMGeracaoGlobal().ParamCRM.strCodOpe := frmCadMovOcorrencias.qryTabelaProp.FieldByName('OCO_CODOPE').AsString;
      getCRMGeracaoGlobal().ParamCRM.strCodSit := frmCadMovOcorrencias.qryTabelaProp.FieldByName('OCO_CODSIT').AsString;
      getCRMGeracaoGlobal().ParamCRM.blnOpeCaC := frmCadMovOcorrencias.blnOpeCadCli;
      getCRMGeracaoGlobal().ParamCRM.strCodCoc := frmCadMovOcorrencias.qryTabelaProp.FieldByName('OCO_CODCOC').AsString;
      getCRMGeracaoGlobal().ParamCRM.strCodToc := frmCadMovOcorrencias.qryTabelaProp.FieldByName('OCO_CODTOC').AsString;
      getCRMGeracaoGlobal().ParamCRM.strDescri := frmCadMovOcorrencias.qryTabelaProp.FieldByName('OCO_DESCRI').AsString;
      getCRMGeracaoGlobal().ParamCRM.BlnEmerge := frmCadMovOcorrencias.qryTabelaProp.FieldByName('OCO_EMERGE').AsString = 'S';

      pCriarFormularios(TfrmGravando, frmGrav );
      frmGrav.fExecutarAcao := getCRMGeracaoGlobal().fInsereOcorrencias;
      frmGrav.lblGravando.Caption := 'Gravando ocorrências...';
      frmGrav.ShowModal;
      pFreeAndNil(frmGrav);

      frmCadMovOcorrencias.qryTabelaProp.Cancel;
    End;

  Finally
    FreeAndNil(frmCadMovOcorrencias);
  End;

  pReset;
end;

procedure TfrmCRMGeracaoGlobal.btnDesmTodosClick(Sender: TObject);
begin
  inherited;
  If not btnDesmTodos.Visible Then
    Exit;

  If (PCDados.ActivePage = tsDadosPromocaoGeral) Then
  Begin
    If Assigned(frmCrmCatalogoPromocaoGeral) Then
      frmCrmCatalogoPromocaoGeral.pDesmarcarTodos;
  End
  Else If (PCDados.ActivePage = tsDadosPromocaoPorCliente) Then
  Begin
    If Assigned(frmCrmCatalogoPromocaoCliente) Then
      frmCrmCatalogoPromocaoCliente.pDesmarcarTodos;
  End
  Else If PCDados.ActivePage = tsDadosCliente Then
    getCRMGeracaoGlobal().pDesmarcaTodos();

  cxDadosTableView.Site.Repaint;
end;

procedure TfrmCRMGeracaoGlobal.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;

  If not btnMarcarTodos.Visible Then
    Exit;

  If (PCDados.ActivePage = tsDadosPromocaoGeral) Then
  Begin
    If Assigned(frmCrmCatalogoPromocaoGeral) Then
      frmCrmCatalogoPromocaoGeral.pMarcarTodos;
  End
  Else If (PCDados.ActivePage = tsDadosPromocaoPorCliente) Then
  Begin
    If Assigned(frmCrmCatalogoPromocaoCliente) Then
      frmCrmCatalogoPromocaoCliente.pMarcarTodos;
  End
  Else If PCDados.ActivePage = tsDadosCliente Then
    pMarcarTodos;
end;

procedure TfrmCRMGeracaoGlobal.cxDadosTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  strCodCli : String;
  APainter: TcxPainterAccess;
begin

  If not (AViewInfo.EditViewInfo is TcxCustomTextEditViewInfo) Then
    Exit;

  If AViewInfo.Item.Index <> cxDadosTableViewColumnMARCA.Index Then
    Exit;

  If AViewInfo.GridRecord.Index < 0 Then
    Exit;

  strCodCli := VarAsType(IIF(cxDadosTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[ cxDadosTableViewColumnMARCA.Index] = null,0,cxDadosTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[ cxDadosTableViewColumnMARCA.Index]), varString );

  APainter := TcxPainterAccess(TcxViewInfoAcess(AViewInfo).GetPainterClass.Create(ACanvas, AViewInfo));
  With APainter do
  Begin
    Try
      DrawBorders;
      With AViewInfo.ClientBounds Do
      Begin

        If getCRMGeracaoGlobal().fJaMarcado(strCodCli) Then
          imgLista.Draw(ACanvas.Canvas, Left + 1, Top + 1, 1)
        Else
          imgLista.Draw(ACanvas.Canvas, Left + 1, Top + 1, 0);

      End
    Finally
      Free;
    End;
  End;
  ADone := True;
end;

procedure TfrmCRMGeracaoGlobal.cxDadosTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Escape: btnSair.Click;
  End;
end;

procedure TfrmCRMGeracaoGlobal.cxDadosTableViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
  Begin
    getCRMGeracaoGlobal().pMarcaDesmarca(getCRMGeracaoGlobal().cdsDados.FieldByName('CLI_CODCLI').AsString);
    cxDadosTableView.Site.Repaint;
  End;
end;

function TfrmCRMGeracaoGlobal.fAbreDados : Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGrav );

    frmGrav.fExecutarAcao := fAbreDadosProgresso;
    frmGrav.lblGravando.Caption := 'Carregando informações...';
    frmGrav.pgbStatus.Visible := False;
    frmGrav.ShowModal;

    Result := frmGrav.blnConfirma;

  Finally
    pFreeAndNil(frmGrav);
  End;

End;

function TfrmCRMGeracaoGlobal.fAbreDadosProgresso(cxProgress : TcxProgressBar) : Boolean;
Begin
  Try
    Application.ProcessMessages;
    Result :=  getCRMGeracaoGlobal().fCarregaDados();

    If Result Then
    Begin
      cxDadosTableView.ApplyBestFit();
      cxDadosTableViewColumnMARCA.Width := 24;

      cxDadosTableViewColumnESPORC.Visible := False;
      cxDadosTableViewColumnVLRORC.Visible := False;
      If ((Not fEmptyDate(getCRMGeracaoGlobal().ParamCon.dtaIniOrc) ) And
          (Not fEmptyDate(getCRMGeracaoGlobal().ParamCon.dtaFinOrc)) Or
          (Not fEmptyStr(getCRMGeracaoGlobal().ParamCon.edtDiaOrc))) Then
      Begin
        cxDadosTableViewColumnESPORC.Visible := True;
        cxDadosTableViewColumnVLRORC.Visible := True;
      End;

      lblQtdCli.Caption := 'Total Cliente(s): ' + IntToStr(getCRMGeracaoGlobal.cdsDados.RecordCount);
      Application.ProcessMessages;
    End;
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(e.Message, 'TfrmCRMGeracaoGlobal.fAbreDadosProgresso');
    End;
  End;
End;

procedure TfrmCRMGeracaoGlobal.pCarregarDadosPromocao;
begin
  fExecutarModal(pCarregarDadosPromocaoGeral, 'Aguarde, consultando dados de promoções ...', '');
  Application.ProcessMessages;
  fExecutarModal(pExibirDadosPromocaoGeral, 'Aguarde, carregando dados de promoções ...', '');

  Application.ProcessMessages;
  tsDadosPromocaoGeral.TabVisible := True;

  fExecutarModal(pCarregarDadosPromocaoPorCliente, 'Aguarde, consultando dados de promoções por cliente ...', '');
  Application.ProcessMessages;
  fExecutarModal(pExibirDadosPromocaoCliente, 'Aguarde, carregando dados de promoções por cliente...', '');

  Application.ProcessMessages;
  tsDadosPromocaoPorCliente.TabVisible := True;
end;

procedure TfrmCRMGeracaoGlobal.pCarregarDadosPromocaoGeral;
begin
  If Not Assigned(frmCrmCatalogoPromocaoGeral)Then
    pCriarFormularios(TfrmCrmCatalogoPromocao, frmCrmCatalogoPromocaoGeral);

  Try
    getCRMGeracaoGlobal().ParamPRM.ObjCatalogoPromocao.strCodCli := EmptyStr;
    getCRMGeracaoGlobal().ParamPRM.ObjCatalogoPromocao.pIniciaRelatorio(frxRelJato, frxExpPDF, frxRelatorio);
    getCRMGeracaoGlobal().ParamPRM.ObjCatalogoPromocao.pConsultarGeral;
  Except
    On E : Exception Do
    Begin
      pMensagensErro(e.Message, 'TfrmCRMGeracaoGlobal.pCarregarDadosPromocaoGeral');
    End;
  End;
end;

procedure TfrmCRMGeracaoGlobal.pCarregarDadosPromocaoPorCliente;
begin
  If Not Assigned(frmCrmCatalogoPromocaoCliente)Then
    pCriarFormularios(TfrmCrmCatalogoPromocao, frmCrmCatalogoPromocaoCliente);

  Try
    getCRMGeracaoGlobal().ParamPRM.ObjCatalogoPromocao.pIniciaRelatorio(frxRelJato, frxExpPDF, frxRelatorio);
    getCRMGeracaoGlobal().ParamPRM.ObjCatalogoPromocao.blnSomenteEmPromocao := True;

    getCRMGeracaoGlobal().cdsDados.DisableControls;
    While Not getCRMGeracaoGlobal().cdsDados.Eof Do
    Begin
      If getCRMGeracaoGlobal().fJaMarcado(getCRMGeracaoGlobal().cdsDados.FieldByName('CLI_CODCLI').AsString) Then
        getCRMGeracaoGlobal().ParamPRM.ObjCatalogoPromocao.fAddClienteParaConsulta(getCRMGeracaoGlobal().cdsDados.FieldByName('CLI_CODCLI').AsString);

      getCRMGeracaoGlobal().cdsDados.Next;
    End;
    getCRMGeracaoGlobal().cdsDados.EnableControls;

    getCRMGeracaoGlobal().ParamPRM.ObjCatalogoPromocao.pConsultarGrupoClientes;
  Except
    On E : Exception Do
    Begin
      pMensagensErro(e.Message, 'TfrmCRMGeracaoGlobal.pCarregarDadosPromocaoPorCliente');
    End;
  End;
end;

procedure TfrmCRMGeracaoGlobal.PCDadosChange(Sender: TObject);
begin
  inherited;

  pAjustarBotoesRodapeTsCliente(True);

  If (PCDados.ActivePage = tsDadosPromocaoGeral) Or
     (PCDados.ActivePage = tsDadosPromocaoPorCliente) Then
  Begin
    pAjustarBotoesRodapeTsPromocao(False);
  End;
end;

procedure TfrmCRMGeracaoGlobal.pAjustarBotoesRodapeTsCliente(const blnHabilitar: Boolean);
begin
  btnConfirma.Visible         := blnHabilitar;
  btnMarcarTodos.Visible      := blnHabilitar;
  btnDesmTodos.Visible        := blnHabilitar;
  pnlQtdMarcar .Visible       := blnHabilitar;
  btnMarcarPorQtde.Visible    := blnHabilitar;
  lblQtdCli.Visible           := blnHabilitar;
end;

procedure TfrmCRMGeracaoGlobal.pAjustarBotoesRodapeTsPromocao(const blnHabilitar: Boolean);
begin
  pnlQtdMarcar .Visible       := blnHabilitar;
  btnMarcarPorQtde.Visible    := blnHabilitar;
  lblQtdCli.Visible           := blnHabilitar;
end;

procedure TfrmCRMGeracaoGlobal.pExibirDadosPromocaoCliente;
begin
  If Assigned(getCRMGeracaoGlobal().ParamPRM.ObjCatalogoPromocao.cdsDadosCliente) Then
  Begin
    frmCrmCatalogoPromocaoCliente.Parent := pnlPromocaoCliente;
    frmCrmCatalogoPromocaoCliente.BorderStyle := bsNone;
    frmCrmCatalogoPromocaoCliente.Align := alClient;
    frmCrmCatalogoPromocaoCliente.cdsDados := getCRMGeracaoGlobal().ParamPRM.ObjCatalogoPromocao.cdsDadosCliente;
    frmCrmCatalogoPromocaoCliente.blnExibeColImposto := getCRMGeracaoGlobal().ParamPRM.ObjCatalogoPromocao.blnPrecoImposto;
    frmCrmCatalogoPromocaoCliente.blnExibeColCliente := True;
    frmCrmCatalogoPromocaoCliente.pCarregarGrid;
    frmCrmCatalogoPromocaoCliente.Show;
  End;
end;

procedure TfrmCRMGeracaoGlobal.pExibirDadosPromocaoGeral;
begin
  If Assigned(getCRMGeracaoGlobal().ParamPRM.ObjCatalogoPromocao.cdsDados) Then
  Begin
    frmCrmCatalogoPromocaoGeral.Parent := pnlPromocao;
    frmCrmCatalogoPromocaoGeral.BorderStyle := bsNone;
    frmCrmCatalogoPromocaoGeral.Align := alClient;
    frmCrmCatalogoPromocaoGeral.cdsDados := getCRMGeracaoGlobal().ParamPRM.ObjCatalogoPromocao.cdsDados;
    frmCrmCatalogoPromocaoGeral.blnExibeColImposto := getCRMGeracaoGlobal().ParamPRM.ObjCatalogoPromocao.blnPrecoImposto;
    frmCrmCatalogoPromocaoGeral.pCarregarGrid;
    frmCrmCatalogoPromocaoGeral.Show;
  End;
end;

procedure TfrmCRMGeracaoGlobal.pExibirTabDadosPromocao;
begin
  If Not getCRMGeracaoGlobal().ParamPRM.chkCatProm Then
  Begin
    tsDadosPromocaoGeral.TabVisible := False;
    tsDadosPromocaoPorCliente.TabVisible := False;
    Exit;
  End;

  pCarregarDadosPromocao;
end;

procedure TfrmCRMGeracaoGlobal.pMarcarAleatorio;
begin
  pCriarFormularios(TfrmGravando, frmGrav );
  Try
    getCRMGeracaoGlobal.intQtdSel := speQtdMarcar.Value;
    frmGrav.fExecutarAcao := getCRMGeracaoGlobal().fMarcarClientesAleatoriamente;
    frmGrav.lblGravando.Caption := 'Atualizando informações...';
    frmGrav.pgbStatus.Visible := False;
    frmGrav.ShowModal;

    cxDadosTableView.Site.Repaint;
  Finally
    pFreeAndNil(frmGrav);
  End;
end;

procedure TfrmCRMGeracaoGlobal.pMarcarTodos;
Begin
  pCriarFormularios(TfrmGravando, frmGrav );
  Try
    frmGrav.fExecutarAcao := getCRMGeracaoGlobal().fMarcaTodos;
    frmGrav.lblGravando.Caption := 'Atualizando informações...';
    frmGrav.pgbStatus.Visible := False;
    frmGrav.ShowModal;

    cxDadosTableView.Site.Repaint;
  Finally
    pFreeAndNil(frmGrav);
  End;
End;

procedure TfrmCRMGeracaoGlobal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If NoteBook.PageIndex = 1 Then
  Begin
    Action := caNone;

    If fMensagem('', 'Deseja cancelar?', ['&Sim', '&Não'],2) = 1 Then
       pReset;
  End;
end;

procedure TfrmCRMGeracaoGlobal.FormCreate(Sender: TObject);
begin
  inherited;
  cxDadosTableView.DataController.DataSource := getCRMGeracaoGlobal().cdsDados.dtsSource;
  pReset;

  fraCRMGeracaoGlobalFrameParametros.ParentForm := Self;

  fraCRMGeracaoGlobalFrameParametros.blnLiberadoVendedor      := fVerificaAcessoSistema('CRMGBV', strLoginUsuarioLogado);
  fraCRMGeracaoGlobalFrameParametros.blnLiberadoRepresentante := fVerificaAcessoSistema('CRMGBR', strLoginUsuarioLogado);
  fraCRMGeracaoGlobalFrameParametros.edtCodEmp.Text := VS_strCodEmp;
  fraCRMGeracaoGlobalFrameParametros.edtCodEmpExit(fraCRMGeracaoGlobalFrameParametros.edtCodEmp);
  fraCRMGeracaoGlobalFrameParametros.ParamCon   := getCRMGeracaoGlobal().ParamCon;

  fraCRMGeracaoGlobalFrameParametros.ParentForm := Self;
  fraCRMGeracaoGlobalFrameParametros.ParamPRM   := getCRMGeracaoGlobal().ParamPRM;

end;

procedure TfrmCRMGeracaoGlobal.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(FCRMGeracaoGlobal) Then
    FreeAndNil(FCRMGeracaoGlobal);

  If Assigned(frmCrmCatalogoPromocaoGeral) Then
    pFreeAndNil(frmCrmCatalogoPromocaoGeral);

  If Assigned(frmCrmCatalogoPromocaoCliente) Then
    pFreeAndNil(frmCrmCatalogoPromocaoCliente);

end;

procedure TfrmCRMGeracaoGlobal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F7: btnMarcarTodos.Click;
    VK_F8: btnDesmTodos.Click;
    VK_F9: btnAcoesAutomaticas.Click;
  End;
end;

procedure TfrmCRMGeracaoGlobal.FormShow(Sender: TObject);
begin
  inherited;
  fraCRMGeracaoGlobalFrameParametros.strCodCli := strCodCli;
  fraCRMGeracaoGlobalFrameParametros.pCarregarTsPromocoes ;
  pReset();

end;

function TfrmCRMGeracaoGlobal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
    Result := fraCRMGeracaoGlobalFrameParametros.fValidaCampos(Sender, blnBuscaPorChave);

  if not Result Then
    pSetFocus(sender);
end;

function TfrmCRMGeracaoGlobal.getCRMGeracaoGlobal: TCRMGeracaoGlobal;
begin
  If Not Assigned(FCRMGeracaoGlobal) Then
    FCRMGeracaoGlobal := TCRMGeracaoGlobal.Create;

  Result := FCRMGeracaoGlobal;
end;

procedure TfrmCRMGeracaoGlobal.pReset;
begin
  Self.WindowState            := wsNormal;
  Self.Position               := poScreenCenter;
  Notebook.PageIndex          := 0;
  pnlBtnDadosCarregados.Visible := False;
  btnCarregarDados.Visible    := True;
  btnAcoesAutomaticas.Visible := fVerificaAcessoSistema('frmCadAcaoAutomaticaCRM', strLoginUsuarioLogado);
  btnConfirma.Visible         := False;
  btnMarcarTodos.Visible      := False;
  btnDesmTodos.Visible        := False;
  pnlInfo.Caption             := '';

  pnlQtdMarcar.Visible := False;
  btnMarcarPorQtde.Visible := False;

  fraCRMGeracaoGlobalFrameParametros.pgcFiltros.ActivePage := fraCRMGeracaoGlobalFrameParametros.tbsDadosCliente;

  fraCRMGeracaoGlobalFrameParametros.tsPromocoes.TabVisible := fVerificaAcessoSistema('BTNPRM', strLoginUsuarioLogado);

  lblQtdCli.Caption := '';

  pSetFocus(fraCRMGeracaoGlobalFrameParametros.edtCodCid);

end;

end.
