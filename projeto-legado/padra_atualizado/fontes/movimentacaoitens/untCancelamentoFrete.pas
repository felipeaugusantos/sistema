unit untCancelamentoFrete;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.StdCtrls, UITypes,
  DirectoryEditFocus, Vcl.Mask, MaskEditFocus, EditFocus, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxCheckBox, cxCurrencyEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, Vcl.DBCtrls, DBMemoFocus, untEntFreCon, Datasnap.DBClient, cxContainer, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untTypesSistema, cxDataControllerConditionalFormattingRulesManagerDialog, 
  untFrameDirectoryEditFocus, MaskUtils, untFramePlanoDeContasMaskEdit;

type
  TfrmCancelamentoFrete = class(TfrmPaiSimples)
    BitBtnLocked1: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    dbmLOGIMP: TDBMemoFocus;
    Panel5: TPanel;
    Shape1: TShape;
    Label5: TLabel;
    Shape2: TShape;
    lblDocumentoCancelado: TLabel;
    lblDocumentoNaoEncontrado: TLabel;
    Shape3: TShape;
    prgProgresso: TProgressBar;
    cxgArquivos: TcxGrid;
    cxgArquivosView: TcxGridDBTableView;
    cxgArquivosIMPORT: TcxGridDBColumn;
    cxgArquivosNOMARQ: TcxGridDBColumn;
    cxgArquivosCGCTRA: TcxGridDBColumn;
    cxgArquivosNOMTRA: TcxGridDBColumn;
    cxgArquivosLevel1: TcxGridLevel;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    shpSemNota: TShape;
    lblDocumentoPago: TLabel;
    cxgArquivosDTADOC: TcxGridDBColumn;
    chkArquivoComErro: TCheckBox;
    chkDocumentoCancelado: TCheckBox;
    chkDocumentoNaoExiste: TCheckBox;
    chkDocumentoPago: TCheckBox;
    pnlTail: TPanel;
    Label1: TLabel;
    dirPasta: TfraDirectoryEditFocus;
    cxgArquivosCHAVE: TcxGridDBColumn;
    Panel4: TPanel;
    cxgArquivosSTATUS: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgArquivosViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pReiniciaProcesso(blnHabilita: boolean);
    procedure btnMarcaCreditaICMSClick(Sender: TObject);
    procedure btnDesmarcaCreditaICMSClick(Sender: TObject);
    procedure selecionaFiltroLegenda(Sender: TObject);
  private
    objFreCon: TFreCon;
    { Private declarations }
  public
    tpFrete: TTipoFrete;
    { Public declarations }

  protected
    { Protected declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    Procedure pHabilitaForm(blnHabilita: Boolean);
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas;

{ TfrmEntFreConImpVarios }

procedure TfrmCancelamentoFrete.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pHabilitaForm(False);

  If objFreCon.fConfirmarCancelamento(prgProgresso) Then
    pReiniciaProcesso(True);
  pHabilitaForm(True);
end;

procedure TfrmCancelamentoFrete.btnDesmarcaCreditaICMSClick(Sender: TObject);
begin
  inherited;
  objFreCon.pMarcaTodosCreditaICMS(False);

end;

procedure TfrmCancelamentoFrete.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  objFreCon.pMarcaTodosArquivos(False);
end;

procedure TfrmCancelamentoFrete.btnMarcaCreditaICMSClick(Sender: TObject);
begin
  inherited;
  objFreCon.pMarcaTodosCreditaICMS(True);

end;

procedure TfrmCancelamentoFrete.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  objFreCon.pMarcaTodosArquivos;
end;

procedure TfrmCancelamentoFrete.selecionaFiltroLegenda(Sender: TObject);
begin
  inherited;
  objFreCon.blnArquivoComErro := chkArquivoComErro.Checked;
  objFreCon.blnDocumentoNaoExiste := chkDocumentoNaoExiste.Checked;
  objFreCon.blnDocumentoPago := chkDocumentoPago.Checked;
  objFreCon.blnDocumentoCancelado := chkDocumentoCancelado.Checked;

  objFreCon.pFiltraLog;
end;

procedure TfrmCancelamentoFrete.cxgArquivosViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    intStatus: Integer;
begin
  inherited;
  intStatus := StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgArquivosSTATUS.Index]), -1);

  Case intStatus Of
    {$region 'IMPORTADO_COM_ERRO'}
    IMPORTADO_COM_ERRO:  Begin
                           ACanvas.Brush.Color := clRed;

                           If AViewInfo.Selected Then
                             ACanvas.Font.Color := clYellow;
                         End;
   {$endregion}
    {$region 'DOCUMENTO_NAO_EXISTE'}
    DOCUMENTO_NAO_EXISTE: Begin
                           ACanvas.Brush.Color := lblDocumentoNaoEncontrado.Font.Color;
                           If AViewInfo.Selected Then
                             ACanvas.Font.Color := clBlack;
                         End;
    {$endregion}
    {$region 'DOCUMENTO_PAGO'}
    DOCUMENTO_PAGO: Begin
                           ACanvas.Brush.Color := lblDocumentoPago.Font.Color;
                           If AViewInfo.Selected Then
                             ACanvas.Font.Color := clBlack;
                         End;
    {$endregion}
    {$region 'DOCUMENTO_CANCELADO'}
    DOCUMENTO_CANCELADO: Begin
                           ACanvas.Brush.Color := lblDocumentoCancelado.Font.Color;
                           If AViewInfo.Selected Then
                             ACanvas.Font.Color := clBlack;
                         End;
    {$endregion}
  Else
    If objFreCon.blnUtiAbr Then
      dirPasta.edtDirectory.text := fCfgSisL('XMLCTE');
  End;

end;

procedure TfrmCancelamentoFrete.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fAtuCfgSis('XMLCTE', dirPasta.edtDirectory.text);
  FreeAndNil(objFreCon);
end;

procedure TfrmCancelamentoFrete.FormCreate(Sender: TObject);
begin
  inherited;
  objFreCon := TFreCon.Create(Self);
  objFreCon.blnXMLEvento := true;
  objFreCon.blnImpVariosXml := True;
end;

procedure TfrmCancelamentoFrete.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = vkEscape) and (Not pnlTail.Enabled) And
     (fMensagem('','Deseja abandonar esta tarefa?', ['&SIM', '&NÃO'], 1) = 1) Then
  Begin
    pReiniciaProcesso(True);
  End;
  If Key = VK_F6 Then
    btnMarcaTodos.Click;
  If Key = VK_F7 Then
    btnDesmarcaTodos.Click;
end;

procedure TfrmCancelamentoFrete.FormShow(Sender: TObject);
begin
  inherited;
  objFreCon.tpFrete := tpFrete;
  dirPasta.edtDirectory.text := fCfgSisL('XMLCTE');
end;

function TfrmCancelamentoFrete.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dirPasta) Then
    Begin
      If fEmptyStr(dirPasta.edtDirectory.text) Then
      Begin
        fMensagem('','A pasta deve ser informada!',['&O K']);
        Result := False;
      End
      Else
      Begin

        If Not DirectoryExists(dirPasta.edtDirectory.text) Then
        Begin
          fMensagem('','Pasta não encontrada!',['&O K']);
          Result := False;
        End
        Else If blnBuscaPorChave And fVerificaCampos Then
        Begin
          If Not Assigned(objFreCon) Then
          Begin
            Result := False;
          End
          Else
          Begin
            objFreCon.strCodOpe := strLoginUsuarioLogado;
            pHabilitaForm(False);
            If objFreCon.fCarregaArquivos(dirPasta.edtDirectory.text, 'xml') Then
            Begin
              cxgArquivosView.DataController.DataSource := objFreCon.dtsTabela;
              dbmLOGIMP.DataSource := objFreCon.dtsTabela;
              objFreCon.fXmlToBanco(prgProgresso);
              cxgArquivosView.ApplyBestFit;
            End;
            pHabilitaForm(True);
            pReiniciaProcesso(False);
          End;
        End;
      End;
      If Result Then
        fAtuCfgSis('XMLCTE', dirPasta.edtDirectory.text);
    End;
  End;
  If Not Result Then
  Begin
    blnMudarFoco := False;
    pSetFocus(Sender);
  End;

end;

procedure TfrmCancelamentoFrete.pHabilitaForm(blnHabilita: Boolean);
begin
  //pnlTopo.Enabled     := blnHabilita;
  cxgArquivos.Enabled := blnHabilita;
  pnlBotoes.Enabled   := blnHabilita;
end;


procedure TfrmCancelamentoFrete.pReiniciaProcesso(blnHabilita: boolean);
begin
  pnlTail.Enabled     := blnHabilita;
  dirPasta.Enabled  := blnHabilita;
  If blnHabilita Then
  Begin
    dirPasta.edtDirectory.text := fCfgSisL('XMLCTE');
    If Assigned(objFreCon) Then
      objFreCon.qryTabela.EmptyDataSet;
    pSetFocus(dirPasta);
  End;
end;



end.
