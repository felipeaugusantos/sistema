unit untGatilhosInformacaoGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, UniClientDataSet,
  Uni, UniDataSetProvider, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade, System.UITypes, strUtils, MaskUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog, DBAccess, MemDS,
  cxImageComboBox, System.ImageList, Vcl.ImgList, cxImageList,
  dxLayoutContainer, cxGridViewLayoutContainer, cxGridLayoutView,
  cxGridDBLayoutView, cxGridCustomLayoutView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGridCitel, cxContainer, cxTextEdit, cxMaskEdit,
  cxSpinEdit, cxCustomListBox, cxCheckListBox, cxButtons, cxLabel, Vcl.CheckLst,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, EditFocus, ComboBoxFocus, MaskEditFocus;

type
  TfrmGatilhosInformacaoGrid = class(TfrmPai)
    cxgGatilhosView: TcxGridDBTableView;
    cxgGatilhosLevel: TcxGridLevel;
    cxgGatilhos: TcxGrid;
    qryGatilhos: TUniQuery;
    dtsSpoImp: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    qryGatilhosGAT_CODIGO: TStringField;
    qryGatilhosGAT_DESCRI: TStringField;
    qryGatilhosREL_DESCRI: TStringField;
    qryGatilhosGPE_DESCRI: TStringField;
    qryGatilhosOPE_NOMOPE: TStringField;
    qryGatilhosOPE_NUMWPP: TStringField;
    qryGatilhosOPE_E_MAIL: TStringField;
    qryGatilhosGAT_DIAENV: TStringField;
    qryGatilhosGAT_HORENV: TTimeField;
    qryGatilhosGAT_FERENV: TStringField;
    qryGatilhosGAT_STATUS: TStringField;
    cxgGatilhosViewGAT_CODIGO: TcxGridDBColumn;
    cxgGatilhosViewGAT_DESCRI: TcxGridDBColumn;
    cxgGatilhosViewREL_DESCRI: TcxGridDBColumn;
    cxgGatilhosViewGAT_CODEMP: TcxGridDBColumn;
    cxgGatilhosViewGPE_DESCRI: TcxGridDBColumn;
    cxgGatilhosViewOPE_NOMOPE: TcxGridDBColumn;
    cxgGatilhosViewOPE_NUMWPP: TcxGridDBColumn;
    cxgGatilhosViewOPE_E_MAIL: TcxGridDBColumn;
    cxgGatilhosViewGAT_DIAENV: TcxGridDBColumn;
    cxgGatilhosViewGAT_HORENV: TcxGridDBColumn;
    cxgGatilhosViewGAT_FERENV: TcxGridDBColumn;
    cxgGatilhosViewGAT_STATUS: TcxGridDBColumn;
    btnIncluir: TcxButton;
    btnAlterar: TcxButton;
    btnCopiarGatilho: TcxButton;
    btnExcluir: TcxButton;
    qryGatilhosGAT_CODEMP: TStringField;
    procedure cxgGatilhosViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxgGatilhosViewOPE_NUMWPPGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure FormCreate(Sender: TObject);
    procedure cxgGatilhosViewDblClick(Sender: TObject);
    procedure btnCopiarGatilhoClick(Sender: TObject);
  private
    { Private declarations }
    FMascaraTelefone: string;
    function fCarregarGatilhos: Boolean;
    procedure pValidarConfiguracoes;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untModulo, untGatilhosInformacaoEditar,
  untGatilhosInformacao, untFuncoesGenerica;

{$R *.dfm}

procedure TfrmGatilhosInformacaoGrid.FormCreate(Sender: TObject);
begin
  inherited;
  pValidarConfiguracoes;
  FMascaraTelefone := fRetMascaraFonePais;
  cxgGatilhosViewOPE_NUMWPP.Visible := fCfgSis('UTIWPP', varBoolean);
end;

procedure TfrmGatilhosInformacaoGrid.FormShow(Sender: TObject);
begin
  inherited;
  fCarregarGatilhos;
  pSetFocus(cxgGatilhos);
end;

procedure TfrmGatilhosInformacaoGrid.btnAlterarClick(Sender: TObject);
var
  LCodigo: String;
begin
  inherited;
  LCodigo := qryGatilhos.FieldByName('GAT_CODIGO').AsString;
  try
    if LCodigo.IsEmpty then
      Exit;
    if not TfrmGatilhosInformacaoEditar.Editar(LCodigo) then
      Exit;
    cxgGatilhosView.DataController.RefreshExternalData;
    TAtualizarGatilhosWebService.Execute;
  finally
    qryGatilhos.Locate('GAT_CODIGO', LCodigo, []);
  end;
end;

procedure TfrmGatilhosInformacaoGrid.btnCopiarGatilhoClick(Sender: TObject);
var
  LCodigo: String;
begin
  inherited;
  LCodigo := qryGatilhos.FieldByName('GAT_CODIGO').AsString;
  try
    if LCodigo.IsEmpty then
      Exit;
    if not TfrmGatilhosInformacaoEditar.Copiar(LCodigo) then
      Exit;
    cxgGatilhosView.DataController.RefreshExternalData;
    TAtualizarGatilhosWebService.Execute;
  finally
    qryGatilhos.Locate('GAT_CODIGO', LCodigo, []);
  end;
end;

procedure TfrmGatilhosInformacaoGrid.btnExcluirClick(Sender: TObject);
var
  LCodigo: string;
begin
  inherited;
  LCodigo := qryGatilhos.FieldByName('GAT_CODIGO').AsString;
  if LCodigo.IsEmpty Then
    Exit;
  if not fPergunta('Deseja realmente remover este gatilho de informação?') then
    Exit;
  if not TGatilhosInformacao.Excluir(LCodigo) then
    Exit;
  cxgGatilhosView.DataController.RefreshExternalData;
  TAtualizarGatilhosWebService.Execute;
end;

procedure TfrmGatilhosInformacaoGrid.btnIncluirClick(Sender: TObject);
var
  LCodigo: String;
begin
  inherited;
  LCodigo := EmptyStr;
  if TfrmGatilhosInformacaoEditar.Inserir(LCodigo) then
  begin
    cxgGatilhosView.DataController.RefreshExternalData;
    TAtualizarGatilhosWebService.Execute;
    qryGatilhos.Locate('GAT_CODIGO', LCodigo, []);
  end;
end;

procedure TfrmGatilhosInformacaoGrid.cxgGatilhosViewDblClick(Sender: TObject);
begin
  inherited;
  btnAlterar.Click;
end;

procedure TfrmGatilhosInformacaoGrid.cxgGatilhosViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Escape:
      btnSair.Click;
    VK_F1:
      btnIncluir.Click;
    VK_F2:
      btnAlterar.Click;
    VK_F3:
      btnCopiarGatilho.Click;
    VK_DELETE, VK_F4:
      btnExcluir.Click;
    VK_F5:
      cxgGatilhosView.DataController.RefreshExternalData;
  End;
end;

procedure TfrmGatilhosInformacaoGrid.cxgGatilhosViewOPE_NUMWPPGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  if AText <> EmptyStr then
    AText := FormatMaskText(FMascaraTelefone, AText);
end;

function TfrmGatilhosInformacaoGrid.fCarregarGatilhos: Boolean;
begin
  qryGatilhos.Close;
  qryGatilhos.Connection := frmModulo.GetCurrentConnection;
  qryGatilhos.Open;
  Result := Not qryGatilhos.IsEmpty;
end;

procedure TfrmGatilhosInformacaoGrid.pValidarConfiguracoes;
Const
  CFG_GATOPE = 'Configurações -> RELATÓRIOS -> Gatilhos de Informação - Operador para envio de Email / WhatsApp.';
  CFG_GATURL = 'Configurações -> RELATÓRIOS -> Gatilhos de Informação - URL do WebService Gatilhos de Informação Citel.';
begin
  if fEmptyStr(fRetNomeOperador(fCfgSis('GATOPE'))) then
  begin
    pMensagemOk(CFG_GATOPE + #13#10 + 'Favor configurar corretamente antes de prosseguir !');
    blnFecharFormPai := True;
    Exit;
  end
  else if fEmptyStr(fCfgSis('GATURL')) then
  begin
    pMensagemOk(CFG_GATURL + #13#10 + 'Favor configurar corretamente antes de prosseguir !');
    blnFecharFormPai := True;
    Exit;
  end
  else if fEmptyStr(fRetNomeDesteServidor) then
  begin
    pMensagemOk('Não foi possível indentificar o nome deste servidor. '+sLineBreak+'Favor entrar em contato com a Citel imediatamente!');
    blnFecharFormPai := True;
    Exit;
  end
  else if fCfgSis('UTIWPP', varBoolean) and (fRetFilaEnvioWhatsAppOperador(fCfgSis('GATOPE')) = 0) then
  begin
    pMensagemOk(CFG_GATOPE + #13#10 + 'Operador informado não possui fila para envio de mensagens WhatsApp. Favor configurar corretamente antes de prosseguir !');
    blnFecharFormPai := True;
    Exit;
  end;

  try
    TAtualizarGatilhosWebService.Execute(True);
  except
    on e: Exception do
    begin
      pMensagemSonora(e.Message);
      blnFecharFormPai := True;
    end;
  end;
end;

end.
