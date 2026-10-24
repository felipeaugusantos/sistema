{*******************************************************}
{* CLASSE CRIADA PARA NOVA FUNÇÃO DE CONSULTA DE ITENS *}
{****************************************************JU*}
unit untPanelCxItem;

interface
Uses
  ExtCtrls,
  Forms,
  Controls,
  ComCtrls,
  UniClientDataSet,
  SysUtils,
  Classes,
  untClassPanelCx,
  untPnlDadosItem,
  untPnlDadosItemPrecoProduto,
  untFuncoesSimples,
  BitBtnLockedIncrem,
  untTypesSistema;

Type


  TTipoPanel = (tpNenhum, tpProdutoPreco);

  TPanelCxItem = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosItemClass;
  protected
    constructor Create(TfrmPnlCon: TfrmPnlDadosItemClass); reintroduce;
  public
    intPraMedio: Integer;
    frmPnlCon: TfrmPnlDadosItem;
    strNomForm: String;
    strCodVen : String;
    strCodDig : String;
    strSenVen : String;
    strOpcDoc : String;
    strEmprCD : String;
    blnExibirVrUnitarioPedCompraGrid: Boolean;
    procVendasPerdidas              : TProcVendasGenerica;
    procDisplayGeneric              : TprcDisplayText;
    procRelVendasPerdidas           : TProcRelVendasGenerica;
    procMostraDocumentoReimpressao  : TMostraDocumentoReimpressao;
    procExibeAgregados              : TProcExibeAgregados;
    procExibeRequisicaoCompra       : TProcExibeRequisicaoCompra;
    procExibeCndPag                 : TProcExibeCndPag;
    blnFaturamento                  : Boolean;
    blnPnlDadosItem                 : Boolean;
    blnPedCorte                     : Boolean;
    blnConfirmaSimilar              : Boolean;
    strEmpIte,
    strEmpSal                       : String;
    blnExiSalDisCD                  : Boolean;
    strNumOrc                       : String;
    strEspOrc                       : String;
    blnCndPag                       : Boolean;
    strCodCndPag                    : String;
    strCndPag                       : String;
    strCodForPag                    : String;
    strDesForPag                    : String;
    fltDescMaxV                     : Double;
    fltDescMaxG                     : Double;
    fltDescApli                     : Double;
    blnConfirmaCndPag               : Boolean;

    class function New(enuTipoPanel: TTipoPanel = tpNenhum): TPanelCxItem; overload;

    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet;
                        btnConfirma: TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

implementation

uses
  untPnlDadosItemResumido, untPnlDadosItemAntigo;

constructor TPanelCxItem.Create(TfrmPnlCon: TfrmPnlDadosItemClass);
begin
  inherited Create;
  FTfrmCo                          := TfrmPnlCon;
  blnPnlDadosItem                  := True;
  blnFaturamento                   := False;
  blnPedCorte                      := False;
  procVendasPerdidas               := Nil;
  procDisplayGeneric               := Nil;
  procRelVendasPerdidas            := Nil;
  procMostraDocumentoReimpressao   := Nil;
  ProcExibeRequisicaoCompra        := Nil;
  procExibeAgregados               := Nil;
  procExibeCndPag                  := Nil;
  strSenVen                        := '';
  strOpcDoc                        := '';
  strEmprCD                        := '';
  blnExibirVrUnitarioPedCompraGrid := False;
  blnConfirmaSimilar               := False;
  blnCndPag                        := False;
  strCodCndPag                     := '';
  strCndPag                        := '';
  strCodForPag                     := '';
  strDesForPag                     := '';
  fltDescMaxV                      := 0;
  fltDescMaxG                      := 0;
  fltDescApli                      := 0;
  blnConfirmaCndPag                := False;
end;

class function TPanelCxItem.New(enuTipoPanel: TTipoPanel = tpNenhum): TPanelCxItem;
begin
  case enuTipoPanel of
    tpProdutoPreco: Result := Self.Create(TfrmPnlDadosItemPrecoProduto);
  Else
    If fCfgSis('PANITE', varBoolean) Then
      Result := Self.Create(TfrmPnlDadosItemResumido)
    Else
      Result := Self.Create(TfrmPnlDadosItemAntigo);
  End;
end;

procedure TPanelCxItem.pCriaForm(NewDockSite: TWinControl;
                                 DropControl: TControl;
                                 cdsConsulta: TUniClientDataSet;
                                 btnConfirma: TBitBtnLocked;
                                 cdsSubConsulta : TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta        := cdsConsulta;
  frmPnlCon.cdsSubConsulta := cdsSubConsulta;
  frmPanel                     := frmPnlCon;
  frmPnlCon.strNomForm         := strNomForm;
  frmPnlCon.strCodCli          := recParametros.strCodCli;
  frmPnlCon.strCodVen          := strCodVen;
  frmPnlCon.strCodDig          := strCodDig;
  frmPnlCon.intPraMedio        := intPraMedio;
  frmPnlCon.strCodCnd          := recParametros.strCodCnd;
  frmPnlCon.strTabPre          := recParametros.strTabPre;
  frmPnlCon.blnFaturamento     := blnFaturamento;
  frmPnlCon.blnPedCorte        := blnPedCorte;
  frmPnlCon.strSenVen          := strSenVen;
  frmPnlCon.strOpcDoc          := strOpcDoc;
  frmPnlCon.strEmprCD          := strEmprCD;
  frmPnlCon.strNumOrc          := strNumOrc;
  frmPnlCon.strEspOrc          := strEspOrc;
  frmPnlCon.blnCndPag          := blnCndPag;
  frmPnlCon.strCodCndPag       := strCodCndPag;
  frmPnlCon.strCndPag          := strCndPag;
  frmPnlCon.strCodForPag       := strCodForPag;
  frmPnlCon.strDesForPag       := strDesForPag;
  frmPnlCon.fltDescMaxV        := fltDescMaxV;
  frmPnlCon.fltDescMaxG        := fltDescMaxG;
  frmPnlCon.fltDescApli        := fltDescApli;
  frmPnlCon.blnConfirmaCndPag  := blnConfirmaCndPag;
  frmPnlCon.procVendasPerdidas               := procVendasPerdidas;
  frmPnlCon.procMostraDocumentoReimpressao   := procMostraDocumentoReimpressao;
  frmPnlCon.btnConfirma                      := btnConfirma;
  frmPnlCon.objPanel                         := Self;
  If (fCfgSis('PANITE', VarBoolean) And fCfgSis('CPDNPI', VarBoolean)) Then
    frmPnlCon.objPanel.FOnDislplayTextGeneric  := frmPnlCon.pOnDisplayText;
  frmPnlCon.procRelVendasPerdidas            := procRelVendasPerdidas;
  frmPnlCon.procExibeAgregados               := procExibeAgregados;
  frmPnlCon.ProcExibeRequisicaoCompra        := procExibeRequisicaoCompra;
  frmPnlCon.ProcExibeCndPag                  := ProcExibeCndPag;
  frmPnlCon.strEmpIte                        := strEmpIte;
  frmPnlCon.strEmpSal                        := strEmpSal;
  frmPnlCon.blnExiSalDisCD                   := blnExiSalDisCD;
  frmPnlCon.blnExibirVrUnitarioPedCompraGrid := blnExibirVrUnitarioPedCompraGrid;
  frmPnlCon.pSetPnlDadosItemVisible(blnPnlDadosItem);

  pSetCxControlsScrollbarModeClassic(frmPnlCon);

  prcAtualizar := nil;
  prcIniciouNavegacaoGridConsulta := frmPnlCon.pIniciouNavegacaoGridConsulta;
  prcParouNavegacaoGridConsulta := frmPnlCon.pParouNavegacaoGridConsulta;
  prcAtualizaInformacaoSubConsulta := frmPnlCon.pAtualizaInformacaoSubConsulta;

  pgcDropControl := DropControl;
  With frmPnlCon Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;

  prcAtualizaAplicacao := frmPnlCon.pAtualizarAplicacao;

end;

procedure TPanelCxItem.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Assigned(frmPnlCon.OnKeyDown) Then
    frmPnlCon.OnKeyDown(Self, Key, Shift);
end;

end.
