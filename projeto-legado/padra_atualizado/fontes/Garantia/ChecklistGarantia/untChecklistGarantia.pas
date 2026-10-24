unit untChecklistGarantia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, untFrameCheckListGarantiaMercadoria,
  untCadCheckListValidacaoGarantia, Datasnap.DBClient, untFrameEdicaoChecklistGarantia, untChkMerTypes,
  cxGridCustomTableView, System.JSON;

type
  TfrmChecklistGarantia = class(TfrmPai)
    fraChecklist: TframeCheckListGarantiaMercadoria;
    fraEdicaockl: TfraEdicaoChecklistGarantia;
    pnlEdicao: TPanel;
    pnlChecklist: TPanel;
    btnConfirmar: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fraChecklistcxGrid1DBTableView1CellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure fraChecklistbtnEditarClick(Sender: TObject);

    procedure fraEdicaocklmmoChkGarConteudoChange(Sender: TObject);
    procedure fraEdicaocklbtnChkGarConfirmarClick(Sender: TObject);
    procedure fraChecklistbtnExtrairJsonClick(Sender: TObject);
    procedure fraEdicaockledtChkGarCodigoExit(Sender: TObject);
  private
    FblnPermitirEdicao: Boolean;
    FblnHabilitaExportacaoJson: Boolean;
    { Private declarations }
    constructor Create(AOwner: TComponent);reintroduce;overload;
    function fGetEnuTipoCheckList: TTipochecklist;
    procedure pSetblnPermitirEdicao(const Value: Boolean);
    procedure pSetEnuTipoChecklist(const Value: TTipoCheckList);
    procedure pSetblnHabilitaExportacaoJson(Value: Boolean);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    property blnHabilitaExportacaoJson: Boolean Read FblnHabilitaExportacaoJson Write pSetblnHabilitaExportacaoJson;
    property enuTipoChecklist: TTipoCheckList Read fGetEnuTipoCheckList;
    property blnPermitirEdicao: Boolean Read FblnPermitirEdicao Write pSetblnPermitirEdicao;
    Constructor CreateChecklist(AOwner: TComponent; enuTipoChecklist: TTipoCheckList; strCodIte: String);overload;

    procedure pAplicarChecklistAlteracaoIndividualPreco(strJsonChecklist: String);


    { Public declarations }
  end;

var
  frmChecklistGarantia: TfrmChecklistGarantia;

implementation
uses
  Data.DB,
  untController.CheckListGarantia,
  untFuncoesSimples;

{$R *.dfm}

{ TfrmChecklistGarantia }


constructor TfrmChecklistGarantia.Create(AOwner: TComponent);
begin
  FblnHabilitaExportacaoJson := False;
  inherited Create(AOwner);

end;

constructor TfrmChecklistGarantia.CreateChecklist(AOwner: TComponent; enuTipoChecklist: TTipoCheckList; strCodIte: String);
begin
  Self.Create(AOwner);
  fraChecklist.blnSomenteLeitura := True;
  pSetEnuTipoChecklist(enuTipoChecklist);
  fraChecklist.pCarregarCheckList(strCodIte,'');
  fraChecklist.blnHabilitarExtrairJson := FblnHabilitaExportacaoJson;

  fraChecklist.pSetFrameEdicao(fraEdicaockl);

  fraChecklist.blnSomenteLeitura := False;
  fraChecklist.blnSomenteOpcoesItem := True;
  fraChecklist.pFiltrarSomenteAtivos(True);
  fraChecklist.pOcultarPainel(True);

  fraEdicaoCkl.pSetFrameCheckList(enuTipoChecklist, fraChecklist);


end;



function TfrmChecklistGarantia.fGetEnuTipoCheckList: TTipochecklist;
begin
  Result := fraCheckList.enuGrupo;
end;

procedure TfrmChecklistGarantia.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_F10:
      begin
        if btnConfirmar.Enabled then
          btnConfirmar.Click;
      end;
  end;
end;

procedure TfrmChecklistGarantia.fraChecklistbtnEditarClick(Sender: TObject);
begin
  inherited;
  fraChecklist.btnEditarClick(Sender);

end;

procedure TfrmChecklistGarantia.fraChecklistbtnExtrairJsonClick(Sender: TObject);
begin
  inherited;
  fraChecklist.btnExtrairJsonClick(Sender);
end;

procedure TfrmChecklistGarantia.fraChecklistcxGrid1DBTableView1CellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  fraChecklist.cxGrid1DBTableView1CellClick(Sender, ACellViewInfo, AButton, AShift, AHandled);

end;

procedure TfrmChecklistGarantia.fraEdicaocklbtnChkGarConfirmarClick(Sender: TObject);
begin
  if fEmptyStr(fraEdicaockl.edtChkGarCodigo.Text) then
    Abort;
  inherited;

  if not  fValidaCampos(fraEdicaockl.edtChkGarCodigo) then
    abort;

  fraEdicaockl.btnChkGarConfirmarClick(Sender);

end;

procedure TfrmChecklistGarantia.fraEdicaockledtChkGarCodigoExit(
  Sender: TObject);
begin
  if Not fEmptyStr(fraEdicaockl.edtChkGarCodigo.Text) then
  begin
    if not  fValidaCampos(fraEdicaockl.edtChkGarCodigo) then
      abort;
  end;
  inherited;

end;

procedure TfrmChecklistGarantia.fraEdicaocklmmoChkGarConteudoChange(Sender: TObject);
begin
  inherited;
  fraEdicaockl.mmoChkGarConteudoChange(Sender);

end;

function TfrmChecklistGarantia.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  if Sender =  Self.fraEdicaockl.edtChkGarCodigo then
  begin
    Result := fraEdicaockl.rdgChkGarTipoVG.ItemIndex = Ord(Self.fraCheckList.enuGrupo);
    if Not Result then
    begin
      fMensagem('Atenção!','O item selecionado não pertence grupo que está sendo editado!',['&Ok']);
      Exit;
    end;
  end;

end;

procedure TfrmChecklistGarantia.pAplicarChecklistAlteracaoIndividualPreco(strJsonChecklist: String);
begin
  fraChecklist.checkListProduto.fCarregarJson(strJsonChecklist);
end;


procedure TfrmChecklistGarantia.pSetblnHabilitaExportacaoJson(Value: Boolean);
begin
  FblnHabilitaExportacaoJson := Value;
  fraChecklist.blnHabilitarExtrairJson := FblnHabilitaExportacaoJson;
end;

procedure TfrmChecklistGarantia.pSetblnPermitirEdicao(const Value: Boolean);
begin
  FblnPermitirEdicao := Value;
  pnlEdicao.Visible := FblnPermitirEdicao;
  fraChecklist.blnSomenteLeitura := Not blnPermitirEdicao;
  btnConfirmar.Visible := FblnPermitirEdicao;
end;

procedure TfrmChecklistGarantia.pSetEnuTipoChecklist(const Value: TTipoCheckList);
begin
  Self.fraCheckList.enuGrupo := Value;
  if Value = TTipoCheckList.Garantia then
    Self.fraEdicaockl.lblTituloChecklist.Caption := 'CHECKLIST DE DEVOLUÇÃO EM GARANTIA'
 else
    Self.fraEdicaockl.lblTituloChecklist.Caption := 'CHECKLIST DE TROCA DE MERCADORIA';
end;

end.
