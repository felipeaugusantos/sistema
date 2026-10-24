unit Contabilidade.View.PlanoContaVinculoPlanoReferencial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, MemDS, DBAccess, Uni,
  Datasnap.DBClient, UniClientDataSet, EditFocus, cxGridBandedTableView,
  cxGridDBBandedTableView, cxCheckBox, cxButtonEdit, cxMaskEdit,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, cxGridPopupMenu, cxProgressBar,
  Vcl.ComCtrls;

type
  TfrmPlanoContaVinculoPlanoReferencial = class(TfrmPaiContabilidade)
    dsPlanoReferencial: TDataSource;
    dsPlanoContas: TDataSource;
    GridPopupPlanco: TcxGridPopupMenu;
    cxGridPopupPlanre: TcxGridPopupMenu;
    PopupMenuPlanco: TPopupMenu;
    Marcar1: TMenuItem;
    Desmarcar1: TMenuItem;
    btnSalvar: TBitBtnLocked;
    pgVinculo: TPageControl;
    tsPlanoReferencial: TTabSheet;
    tsPlanoContasFinanceiro: TTabSheet;
    tsPortador: TTabSheet;
    pnlBotoesPlanoReferencial: TPanel;
    pnlBotoesPlanoContasFinanceiro: TPanel;
    pnlBotoesPortador: TPanel;
    gbPlanoContas: TcxGroupBox;
    GridPlanoContas: TcxGridCitel;
    GridPlanoContasView: TcxGridDBBandedTableView;
    GridPlanoContasViewAUTOINCREM: TcxGridDBBandedColumn;
    GridPlanoContasViewNCO_CODCON: TcxGridDBBandedColumn;
    GridPlanoContasViewNCO_DESCRI: TcxGridDBBandedColumn;
    GridPlanoContasViewSELECIONADO: TcxGridDBBandedColumn;
    GridPlanoContasViewNCO_CTAREF: TcxGridDBBandedColumn;
    GridPlanoContasViewNRE_DESCRI: TcxGridDBBandedColumn;
    GridPlanoContasLevel: TcxGridLevel;
    gbPlanoReferencial: TcxGroupBox;
    GridPlanoReferencial: TcxGridCitel;
    GridPlanoReferencialView: TcxGridDBBandedTableView;
    GridPlanoReferencialViewNRE_CODREF: TcxGridDBBandedColumn;
    GridPlanoReferencialViewNRE_DESCRI: TcxGridDBBandedColumn;
    GridPlanoReferencialViewSELECIONADO: TcxGridDBBandedColumn;
    GridPlanoReferencialViewNRE_DTAINI: TcxGridDBBandedColumn;
    GridPlanoReferencialViewNRE_DTAFIN: TcxGridDBBandedColumn;
    GridPlanoReferencialLevel: TcxGridLevel;
    btnSalvarPlanoReferencial: TBitBtnLocked;
    btnSalvarPlanoContasFinanceiro: TBitBtnLocked;
    btnSalvarPortador: TBitBtnLocked;
    gbPlanoContabilPlanoContasFinanceiro: TcxGroupBox;
    gbPlanoContasFinanceiro: TcxGroupBox;
    gbPlanoContabilPortador: TcxGroupBox;
    gbPortadores: TcxGroupBox;
    GridPlanoContasFinanceiroView: TcxGridDBTableViewCitel;
    GridPlanoContasFinanceiroLevel: TcxGridLevel;
    GridPlanoContasFinanceiro: TcxGridCitel;
    GridPlanoContabilFinanceiroView: TcxGridDBTableViewCitel;
    GridPlanoContabilFinanceiroLevel: TcxGridLevel;
    GridPlanoContabilFinanceiro: TcxGridCitel;
    GridPortadoresView: TcxGridDBTableViewCitel;
    GridPortadoresLevel: TcxGridLevel;
    GridPortadores: TcxGridCitel;
    GridPlanoContabilPortadoresView: TcxGridDBTableViewCitel;
    GridPlanoContabilPortadoresLevel: TcxGridLevel;
    GridPlanoContabilPortadores: TcxGridCitel;
    GridPopupPortadores: TcxGridPopupMenu;
    GridPopupPlanoContasFinanceiro: TcxGridPopupMenu;
    GridPopupPlancoPortadores: TcxGridPopupMenu;
    GridPopupPlancoPlanoContasFinanceiro: TcxGridPopupMenu;
    dsPortadores: TDataSource;
    dsPlanoContasFinanceiro: TDataSource;
    dsPlancoPortador: TDataSource;
    dsPlancoContasFinanceiro: TDataSource;
    cdsPlanre: TUniClientDataSet;
    cdsPlancoComPlanoReferencial: TUniClientDataSet;
    cdsPlancoComPlanoReferencialSELECIONADO: TStringField;
    cdsPlancoComPlanoReferencialAUTOINCREM: TStringField;
    cdsPlancoComPlanoReferencialNCO_CODCON: TStringField;
    cdsPlancoComPlanoReferencialNCO_DESCRI: TStringField;
    cdsPlancoComPlanoReferencialNCO_CTAREF: TStringField;
    cdsPlancoComPlanoReferencialNRE_DESCRI: TStringField;
    cdsPlanreSELECIONADO: TStringField;
    cdsPlanreNRE_CODREF: TStringField;
    cdsPlanreNRE_DESCRI: TStringField;
    cdsPlanreNRE_DTAINI: TDateField;
    cdsPlanreNRE_DTAFIN: TDateField;
    cdsCadctaComPlanoContabil: TUniClientDataSet;
    cdsPlancoContasFinanceiro: TUniClientDataSet;
    cdsCtanco: TUniClientDataSet;
    cdsCadctaComPlanoContabilSELECIONADO: TStringField;
    cdsCadctaComPlanoContabilPOR_EMPRESA: TStringField;
    cdsCadctaComPlanoContabilCTA_CODCTA: TStringField;
    cdsCadctaComPlanoContabilCTA_DESCTA: TStringField;
    cdsCadctaComPlanoContabilCTA_PLANCO: TStringField;
    cdsCadctaComPlanoContabilNCO_DESCRI: TStringField;
    cdsCadctaComPlanoContabilAUTOINCREM: TStringField;
    cdsPlancoContasFinanceiroSELECIONADO: TStringField;
    cdsPlancoContasFinanceiroNCO_CODCON: TStringField;
    cdsPlancoContasFinanceiroNCO_DESCRI: TStringField;
    cdsPlancoContasFinanceiroNCO_DTAINI: TDateField;
    cdsPlancoContasFinanceiroNCO_DTAFIN: TDateField;
    cdsPlancoContasFinanceiroAUTOINCREM: TStringField;
    cdsCtancoNCO_CODCTA: TStringField;
    GridPlanoContasFinanceiroViewSELECIONADO: TcxGridDBColumn;
    GridPlanoContasFinanceiroViewPOR_EMPRESA: TcxGridDBColumn;
    GridPlanoContasFinanceiroViewCTA_CODCTA: TcxGridDBColumn;
    GridPlanoContasFinanceiroViewCTA_DESCTA: TcxGridDBColumn;
    GridPlanoContasFinanceiroViewCTA_PLANCO: TcxGridDBColumn;
    GridPlanoContasFinanceiroViewNCO_DESCRI: TcxGridDBColumn;
    GridPlanoContasFinanceiroViewAUTOINCREM: TcxGridDBColumn;
    GridPlanoContabilFinanceiroViewSELECIONADO: TcxGridDBColumn;
    GridPlanoContabilFinanceiroViewNCO_CODCON: TcxGridDBColumn;
    GridPlanoContabilFinanceiroViewNCO_DESCRI: TcxGridDBColumn;
    GridPlanoContabilFinanceiroViewNCO_DTAINI: TcxGridDBColumn;
    GridPlanoContabilFinanceiroViewNCO_DTAFIN: TcxGridDBColumn;
    GridPlanoContabilFinanceiroViewAUTOINCREM: TcxGridDBColumn;
    cdsCadctaComPlanoContabilVER_EMPRESA: TStringField;
    GridPlanoContasFinanceiroViewVER_EMPRESA: TcxGridDBColumn;
    cdsCtancoCODEMP: TStringField;
    cdsCtancoCODCON: TStringField;
    cdsCtancoCONMSK: TStringField;
    cdsCtancoCREDEB: TStringField;
    cdsCadporComPlanoContabil: TUniClientDataSet;
    cdsCadporComPlanoContabilSELECIONADO: TStringField;
    cdsCadporComPlanoContabilPOR_EMPRESA: TStringField;
    cdsCadporComPlanoContabilPOR_CODPOR: TStringField;
    cdsCadctaComPlanoContabilPOR_NOMPOR: TStringField;
    cdsCadporComPlanoContabilPOR_PLANCO: TStringField;
    cdsCadporComPlanoContabilNCO_DESCRI: TStringField;
    cdsCadporComPlanoContabilAUTOINCREM: TStringField;
    cdsCadporComPlanoContabilVER_EMPRESA: TStringField;
    cdsPlancoPortador: TUniClientDataSet;
    cdsPlancoPortadorSELECIONADO: TStringField;
    cdsPlancoPortadorNCO_CODCON: TStringField;
    cdsPlancoPortadorNCO_DESCRI: TStringField;
    cdsPlancoPortadorNCO_DTAINI: TDateField;
    cdsPlancoPortadorNCO_DTAFIN: TDateField;
    cdsPlancoPortadorAUTOINCREM: TStringField;
    cdsPornco: TUniClientDataSet;
    cdsPorncoNCO_CODPOR: TStringField;
    cdsPorncoCODEMP: TStringField;
    cdsPorncoCODCON: TStringField;
    cdsPorncoCONMSK: TStringField;
    cdsPorncoCREDEB: TStringField;
    GridPlanoContabilPortadoresViewSELECIONADO: TcxGridDBColumn;
    GridPlanoContabilPortadoresViewNCO_CODCON: TcxGridDBColumn;
    GridPlanoContabilPortadoresViewNCO_DESCRI: TcxGridDBColumn;
    GridPlanoContabilPortadoresViewNCO_DTAINI: TcxGridDBColumn;
    GridPlanoContabilPortadoresViewNCO_DTAFIN: TcxGridDBColumn;
    GridPlanoContabilPortadoresViewAUTOINCREM: TcxGridDBColumn;
    GridPortadoresViewSELECIONADO: TcxGridDBColumn;
    GridPortadoresViewPOR_EMPRESA: TcxGridDBColumn;
    GridPortadoresViewPOR_CODPOR: TcxGridDBColumn;
    GridPortadoresViewPOR_NOMPOR: TcxGridDBColumn;
    GridPortadoresViewPOR_PLANCO: TcxGridDBColumn;
    GridPortadoresViewNCO_DESCRI: TcxGridDBColumn;
    GridPortadoresViewAUTOINCREM: TcxGridDBColumn;
    GridPortadoresViewVER_EMPRESA: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure GridPlanoContasViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure GridPlanoContasViewNCO_CTAREFPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure GridPlanoReferencialViewSELECIONADOPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure Marcar1Click(Sender: TObject);
    procedure Desmarcar1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSalvarPlanoReferencialClick(Sender: TObject);
    procedure GridPlanoContasFinanceiroViewEditing(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      var AAllow: Boolean);
    procedure GridPlanoContasFinanceiroViewCTA_PLANCOPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure GridPlanoContabilFinanceiroViewSELECIONADOPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure GridPlanoContasFinanceiroViewVER_EMPRESAPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure cdsCtancoAfterInsert(DataSet: TDataSet);
    procedure cdsPorncoAfterInsert(DataSet: TDataSet);
    procedure btnSalvarPlanoContasFinanceiroClick(Sender: TObject);
    procedure GridPlanoContabilPortadoresViewSELECIONADOPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure GridPortadoresViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure GridPortadoresViewPOR_PLANCOPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure GridPortadoresViewVER_EMPRESAPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure btnSalvarPortadorClick(Sender: TObject);
    procedure pgVinculoChanging(Sender: TObject; var AllowChange: Boolean);
  private
    { Private declarations }
    procedure pCarregaDadosPlancoComPlanre ;
    procedure pCarregaDadosPlanre ;
    procedure pVincularPlanoReferencial ;
    procedure pVincularContaContabilContaFinanceiro ;
    procedure pVincularContaContabilPortador ;

    procedure pCarregaDadosCadctaComPlanco ;
    procedure pCarregaDadosPlancoContasFinanceiro ;

    procedure pCarregaDadosCadporComPlanco ;
    procedure pCarregaDadosPlancoPortador ;

    procedure pSelecionaPlanco(const ASelecionar: Boolean) ;
    function fCanClose:boolean ;
    function fExecutarVinculo:boolean ;
    function fConfirmarVinculoPlanoReferencial(pgbProgresso: TcxProgressBar): Boolean;
    function fConfirmarVinculoPlanoContasFinanceiro(pgbProgresso: TcxProgressBar): Boolean;
    function fConfirmarVinculoPortador(pgbProgresso: TcxProgressBar): Boolean;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
      strTexto: String);
    function fIsAssignedProgresso(pgbProgresso: TcxProgressBar):boolean ;
    procedure pGravaVinculoPlanoReferencial(pgbProgresso: TcxProgressBar);
    procedure pGravaVinculoPlanoContasFinanceiro(pgbProgresso: TcxProgressBar);
    procedure pGravaVinculoPortador(pgbProgresso: TcxProgressBar);
    procedure pFormataContaGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, Contabilidade.Funcoes, untTypesSistema,
  System.Generics.Collections, strUtils, math, System.MaskUtils,
  Contabilidade.Interfaces.TVinculoPlanoContabilService,
  Contabilidade.Interfaces.TVinculoPlanoContabilRepo,
  Contabilidade.Classes.TVinculoPlanoContabilService,
  Contabilidade.Classes.TVinculoPlanoContabilRepo,
  Contabilidade.Classes.TVinculoPlanoContabil,
  Contabilidade.Classes.TVinculoPlanoContabilFactory ;

{$R *.dfm}

{ TfrmPlanoContaVinculoPlanoReferencial }

procedure TfrmPlanoContaVinculoPlanoReferencial.pCarregaDadosCadctaComPlanco;
var
  LPlanoService: IVinculoPlanoContabilGenericService<TCadCtaComPlanoContabil, TPlanco>;
  LListaCadcta: TObjectList<TCadCtaComPlanoContabil> ;
  LItem: TCadCtaComPlanoContabil ;
  LItemCtanco: TNco ;
  LMascara : String ;
begin
  LMascara := fMskCon ;
  LPlanoService := TVinculoPlanoContabilFactory<TCadCtaComPlanoContabil, TPlanco>.New.fPlanoContabilVinculo ;
  LListaCadcta := LPlanoService.fListDadosT ;
  dsPlanoContasFinanceiro.Enabled := False ;
  cdsCadctaComPlanoContabil.DisableControls ;
  cdsCtanco.DisableControls ;
  try
    cdsCadctaComPlanoContabil.EmptyDataSet ;
    cdsCtanco.EmptyDataSet ;
    for LItem in LListaCadcta do
    begin
      cdsCadctaComPlanoContabil.Append ;
      cdsCadctaComPlanoContabil.FieldByName('SELECIONADO').AsString := LItem.selecionado ;
      cdsCadctaComPlanoContabil.FieldByName('POR_EMPRESA').AsString := LItem.por_empresa ;
      cdsCadctaComPlanoContabil.FieldByName('CTA_CODCTA').AsString := LItem.cta_codcta ;
      cdsCadctaComPlanoContabil.FieldByName('CTA_DESCTA').AsString := LItem.cta_descta ;
      cdsCadctaComPlanoContabil.FieldByName('CTA_PLANCO').AsString := LItem.cta_planco ;
      cdsCadctaComPlanoContabil.FieldByName('NCO_DESCRI').AsString := LItem.nco_descri ;
      cdsCadctaComPlanoContabil.FieldByName('AUTOINCREM').AsString := LItem.autoincrem ;
      cdsCadctaComPlanoContabil.Post ;

      for LItemCtanco in LItem.empresas do
      begin
        cdsCtanco.Append ;
        cdsCtanco.FieldByName('NCO_CODCTA').AsString := LItemCtanco.nco_codnco ;
        cdsCtanco.FieldByName('CODEMP').AsString := LItemCtanco.nco_codemp ;
        cdsCtanco.FieldByName('CODCON').AsString := LItemCtanco.nco_codcon ;
        cdsCtanco.FieldByName('CONMSK').AsString := FormatMaskText(LMascara, LItemCtanco.nco_codcon) ;
        cdsCtanco.Post ;
      end ;

    end ;
    cdsCadctaComPlanoContabil.MergeChangeLog ;
  finally
    FreeAndNil(LListaCadcta) ;
    dsPlanoContasFinanceiro.Enabled := True ;
    cdsCadctaComPlanoContabil.EnableControls ;
    cdsCtanco.EnableControls ;
  end ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pCarregaDadosCadporComPlanco;
var
  LPlanoService: IVinculoPlanoContabilGenericService<TCadPorComPlanoContabil, TPlanco>;
  LListaCadpor: TObjectList<TCadporComPlanoContabil> ;
  LItem: TCadporComPlanoContabil ;
  LItemPornco: TNco ;
  LMascara: String ;
begin
  LMascara := fMskCon ;
  LPlanoService := TVinculoPlanoContabilFactory<TCadporComPlanoContabil, TPlanco>.New.fPlanoContabilVinculo ;
  LListaCadpor := LPlanoService.fListDadosT ;
  dsPortadores.Enabled := False ;
  cdsCadporComPlanoContabil.DisableControls ;
  cdsPornco.DisableControls ;
  try
    cdsCadporComPlanoContabil.EmptyDataSet ;
    cdsPornco.EmptyDataSet ;
    for LItem in LListaCadpor do
    begin
      cdsCadporComPlanoContabil.Append ;
      cdsCadporComPlanoContabil.FieldByName('SELECIONADO').AsString := LItem.selecionado ;
      cdsCadporComPlanoContabil.FieldByName('POR_EMPRESA').AsString := LItem.por_empresa ;
      cdsCadporComPlanoContabil.FieldByName('POR_CODPOR').AsString := LItem.por_codpor ;
      cdsCadporComPlanoContabil.FieldByName('POR_NOMPOR').AsString := LItem.por_nompor ;
      cdsCadporComPlanoContabil.FieldByName('POR_PLANCO').AsString := LItem.por_planco ;
      cdsCadporComPlanoContabil.FieldByName('NCO_DESCRI').AsString := LItem.nco_descri ;
      cdsCadporComPlanoContabil.FieldByName('AUTOINCREM').AsString := LItem.autoincrem ;
      cdsCadporComPlanoContabil.Post ;

      for LItemPornco in LItem.empresas do
      begin
        cdsPornco.Append ;
        cdsPornco.FieldByName('NCO_CODPOR').AsString := LItemPornco.nco_codnco ;
        cdsPornco.FieldByName('CODEMP').AsString := LItemPornco.nco_codemp ;
        cdsPornco.FieldByName('CODCON').AsString := LItemPornco.nco_codcon ;
        cdsPornco.FieldByName('CONMSK').AsString := FormatMaskText(LMascara, LItemPornco.nco_codcon) ;
        cdsPornco.Post ;
      end ;

    end ;
    cdsCadporComPlanoContabil.MergeChangeLog ;
  finally
    FreeAndNil(LListaCadpor) ;
    dsPortadores.Enabled := True ;
    cdsCadporComPlanoContabil.EnableControls ;
    cdsPornco.EnableControls ;
  end ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pCarregaDadosPlancoComPlanre;
var
  LPlanoService: IVinculoPlanoContabilGenericService<TPlancoComPlanoReferencial, TPlanre>;
  LListaPlanco: TObjectList<TPlancoComPlanoReferencial> ;
  LItem: TPlancoComPlanoReferencial ;
begin
  LPlanoService := TVinculoPlanoContabilFactory<TPlancoComPlanoReferencial, TPlanre>.New.fPlanoContabilVinculo ;
  LListaPlanco := LPlanoService.fListDadosT ;
  dsPlanoContas.Enabled := False ;
  cdsPlancoComPlanoReferencial.DisableControls ;
  try
    cdsPlancoComPlanoReferencial.EmptyDataSet ;

    for LItem in LListaPlanco do
    begin
      cdsPlancoComPlanoReferencial.Append ;
      cdsPlancoComPlanoReferencial.FieldByName('SELECIONADO').AsString := LItem.selecionado ;
      cdsPlancoComPlanoReferencial.FieldByName('AUTOINCREM').AsString := LItem.autoincrem ;
      cdsPlancoComPlanoReferencial.FieldByName('NCO_CODCON').AsString := LItem.nco_codcon ;
      cdsPlancoComPlanoReferencial.FieldByName('NCO_DESCRI').AsString := LItem.nco_descri ;
      cdsPlancoComPlanoReferencial.FieldByName('NCO_CTAREF').AsString := LItem.nco_ctaref ;
      cdsPlancoComPlanoReferencial.FieldByName('NRE_DESCRI').AsString := LItem.nre_descri ;
      cdsPlancoComPlanoReferencial.Post ;
    end ;
    cdsPlancoComPlanoReferencial.MergeChangeLog ;
  finally
    FreeAndNil(LListaPlanco) ;
    dsPlanoContas.Enabled := True ;
    cdsPlancoComPlanoReferencial.EnableControls ;
  end ;

end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pCarregaDadosPlancoContasFinanceiro;
var
  LPlanoService: IVinculoPlanoContabilGenericService<TCadCtaComPlanoContabil, TPlanco>;
  LListaPlanco: TObjectList<TPlanco> ;
  LItem: TPlanco ;
begin
  LPlanoService := TVinculoPlanoContabilFactory<TCadCtaComPlanoContabil, TPlanco>.New.fPlanoContabilVinculo ;
  LListaPlanco := LPlanoService.fListDadosT2 ;

  dsPlancoContasFinanceiro.Enabled := False ;
  cdsPlancoContasFinanceiro.DisableControls ;
  try
    cdsPlancoContasFinanceiro.EmptyDataSet ;
    for LItem in LListaPlanco do
    begin
      cdsPlancoContasFinanceiro.Append ;
      cdsPlancoContasFinanceiro.FieldByName('SELECIONADO').AsString := LItem.selecionado ;
      cdsPlancoContasFinanceiro.FieldByName('NCO_CODCON').AsString := LItem.nco_codcon ;
      cdsPlancoContasFinanceiro.FieldByName('NCO_DESCRI').AsString := LItem.nco_descri ;
      if not fEmptyStr(LItem.nco_dtaini) then
        cdsPlancoContasFinanceiro.FieldByName('NCO_DTAINI').AsDateTime := StrToDate(LItem.nco_dtaini) ;
      if not fEmptyStr(LItem.nco_dtafin) then
        cdsPlancoContasFinanceiro.FieldByName('NCO_DTAFIN').AsDateTime := StrToDate(LItem.nco_dtafin) ;
      cdsPlancoContasFinanceiro.FieldByName('AUTOINCREM').AsString := LItem.autoincrem ;
      cdsPlancoContasFinanceiro.Post ;
    end ;

  finally
    FreeAndNil(LListaPlanco) ;
    dsPlancoContasFinanceiro.Enabled := True ;
    cdsPlancoContasFinanceiro.EnableControls ;
  end ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pCarregaDadosPlancoPortador;
var
  LPlanoService: IVinculoPlanoContabilGenericService<TCadPorComPlanoContabil, TPlanco>;
  LListaPlanco: TObjectList<TPlanco> ;
  LItem: TPlanco ;
begin
  LPlanoService := TVinculoPlanoContabilFactory<TCadPorComPlanoContabil, TPlanco>.New.fPlanoContabilVinculo ;
  LListaPlanco := LPlanoService.fListDadosT2 ;

  dsPlancoPortador.Enabled := False ;
  cdsPlancoPortador.DisableControls ;
  try
    cdsPlancoPortador.EmptyDataSet ;
    for LItem in LListaPlanco do
    begin
      cdsPlancoPortador.Append ;
      cdsPlancoPortador.FieldByName('SELECIONADO').AsString := LItem.selecionado ;
      cdsPlancoPortador.FieldByName('NCO_CODCON').AsString := LItem.nco_codcon ;
      cdsPlancoPortador.FieldByName('NCO_DESCRI').AsString := LItem.nco_descri ;
      if not fEmptyStr(LItem.nco_dtaini) then
        cdsPlancoPortador.FieldByName('NCO_DTAINI').AsDateTime := StrToDate(LItem.nco_dtaini) ;
      if not fEmptyStr(LItem.nco_dtafin) then
        cdsPlancoPortador.FieldByName('NCO_DTAFIN').AsDateTime := StrToDate(LItem.nco_dtafin) ;
      cdsPlancoPortador.FieldByName('AUTOINCREM').AsString := LItem.autoincrem ;
      cdsPlancoPortador.Post ;
    end ;

  finally
    FreeAndNil(LListaPlanco) ;
    dsPlancoPortador.Enabled := True ;
    cdsPlancoPortador.EnableControls ;
  end ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pCarregaDadosPlanre;
var
  LPlanoService: IVinculoPlanoContabilGenericService<TPlancoComPlanoReferencial, TPlanre>;
  LListaPlanre: TObjectList<TPlanre> ;
  LItem: TPlanre ;
begin

  LPlanoService := TVinculoPlanoContabilFactory<TPlancoComPlanoReferencial, TPlanre>.New.fPlanoContabilVinculo ;
  LListaPlanre := LPlanoService.fListDadosT2 ;

  dsPlanoReferencial.Enabled := False ;
  cdsPlanre.DisableControls ;
  try
    cdsPlanre.EmptyDataSet ;
    for LItem in LListaPlanre do
    begin
      cdsPlanre.Append ;
      cdsPlanre.FieldByName('SELECIONADO').AsString := LItem.selecionado ;
      cdsPlanre.FieldByName('NRE_CODREF').AsString := LItem.nre_codref ;
      cdsPlanre.FieldByName('NRE_DESCRI').AsString := LItem.nre_descri ;
      if not fEmptyStr(LItem.nre_dtaini) then
        cdsPlanre.FieldByName('NRE_DTAINI').AsDateTime := StrToDate(LItem.nre_dtaini) ;
      if not fEmptyStr(LItem.nre_dtafin) then
        cdsPlanre.FieldByName('NRE_DTAFIN').AsDateTime := StrToDate(LItem.nre_dtafin) ;
      cdsPlanre.Post ;
    end ;

  finally
    FreeAndNil(LListaPlanre) ;
    dsPlanoReferencial.Enabled := True ;
    cdsPlanre.EnableControls ;
  end ;

end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pGravaVinculoPlanoContasFinanceiro(
  pgbProgresso: TcxProgressBar);
var
  LCnt: integer ;
  LPlanoService: IVinculoPlanoContabilGenericService<TCadCtaComPlanoContabil, TPlanco>;
  LListaCadCta: TObjectList<TCadCtaComPlanoContabil> ;
  LItem: TCadCtaComPlanoContabil ;
  LEmpresas: TObjectList<TNco> ;
  LItemEmpresa: TNco ;
  LIndiceAnterior: String ;
begin
  LPlanoService := TVinculoPlanoContabilFactory<TCadCtaComPlanoContabil, TPlanco>.New.fPlanoContabilVinculo ;

  cdsCadctaComPlanoContabil.DisableControls ;
  LListaCadCta := TObjectList<TCadCtaComPlanoContabil>.Create ;
  LIndiceAnterior := cdsCtanco.IndexName ;
  cdsCtanco.IndexName := 'IndicePesquisaCta' ;
  try
    LCnt := 0 ;
    cdsCadctaComPlanoContabil.First ;
    while not cdsCadctaComPlanoContabil.Eof do
    begin
      inc(LCnt) ;
      pgbProgresso.Position := LCnt;
      Application.ProcessMessages;

      LItem := TCadCtaComPlanoContabil.Create ;
      LItem.autoincrem := cdsCadctaComPlanoContabil.FieldByName('AUTOINCREM').AsString ;
      LItem.cta_codcta := cdsCadctaComPlanoContabil.FieldByName('CTA_CODCTA').AsString ;
      LItem.cta_descta := cdsCadctaComPlanoContabil.FieldByName('CTA_DESCTA').AsString ;
      LItem.cta_planco := cdsCadctaComPlanoContabil.FieldByName('CTA_PLANCO').AsString ;
      LItem.nco_descri := cdsCadctaComPlanoContabil.FieldByName('NCO_DESCRI').AsString ;

      LEmpresas := TObjectList<TNco>.Create ;

      if cdsCtanco.FindKey([LItem.cta_codcta]) then
      begin
        while (cdsCtanco.FieldByName('NCO_CODCTA').AsString = LItem.cta_codcta) and (not cdsCtanco.Eof) do
        begin
          LItemEmpresa := TNco.Create ;
          LItemEmpresa.nco_codnco := cdsCtanco.FieldByName('NCO_CODCTA').AsString ;
          LItemEmpresa.nco_codemp := cdsCtanco.FieldByName('CODEMP').AsString ;
          LItemEmpresa.nco_codcon := cdsCtanco.FieldByName('CODCON').AsString ;

          LEmpresas.Add(LItemEmpresa) ;
          cdsCtanco.Next ;
        end ;
      end ;

      LItem.empresas := LEmpresas ;

      LListaCadCta.Add(LItem) ;

      cdsCadctaComPlanoContabil.Next ;
    end ;

    if LPlanoService.fSalvarVinculo(LListaCadCta) then
      cdsCadctaComPlanoContabil.MergeChangeLog ;

  finally
    cdsCadctaComPlanoContabil.EnableControls ;
    cdsCtanco.IndexName := LIndiceAnterior ;
    FreeAndNil(LListaCadCta) ;
  end ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pGravaVinculoPlanoReferencial(
  pgbProgresso: TcxProgressBar);
var
  intCnt: integer ;
  LPlanoService: IVinculoPlanoContabilGenericService<TPlancoComPlanoReferencial, TPlanre>;
  LListaPlanco: TObjectList<TPlancoComPlanoReferencial> ;
  LItem: TPlancoComPlanoReferencial ;
begin
  LPlanoService := TVinculoPlanoContabilFactory<TPlancoComPlanoReferencial, TPlanre>.New.fPlanoContabilVinculo ;

  cdsPlancoComPlanoReferencial.DisableControls ;
  LListaPlanco := TObjectList<TPlancoComPlanoReferencial>.Create ;
  try
    intCnt := 0 ;
    cdsPlancoComPlanoReferencial.First ;
    while not cdsPlancoComPlanoReferencial.Eof do
    begin
      inc(intCnt) ;
      pgbProgresso.Position := intCnt;
      Application.ProcessMessages;

      LItem := TPlancoComPlanoReferencial.Create ;
      LItem.autoincrem := cdsPlancoComPlanoReferencial.FieldByName('AUTOINCREM').AsString ;
      LItem.nco_codcon := cdsPlancoComPlanoReferencial.FieldByName('NCO_CODCON').AsString ;
      LItem.nco_descri := cdsPlancoComPlanoReferencial.FieldByName('NCO_DESCRI').AsString ;
      LItem.nco_ctaref := cdsPlancoComPlanoReferencial.FieldByName('NCO_CTAREF').AsString ;
      LItem.nre_descri := cdsPlancoComPlanoReferencial.FieldByName('NRE_DESCRI').AsString ;

      LListaPlanco.Add(LItem) ;

      cdsPlancoComPlanoReferencial.Next;
    end;

    if LPlanoService.fSalvarVinculo(LListaPlanco) then
      cdsPlancoComPlanoReferencial.MergeChangeLog ;

  finally
    cdsPlancoComPlanoReferencial.EnableControls ;
    FreeAndNil(LListaPlanco) ;
  end;

end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pGravaVinculoPortador(
  pgbProgresso: TcxProgressBar);
var
  LCnt: integer ;
  LPlanoService: IVinculoPlanoContabilGenericService<TCadPorComPlanoContabil, TPlanco>;
  LListaCadPor: TObjectList<TCadPorComPlanoContabil> ;
  LItem: TCadPorComPlanoContabil ;
  LEmpresas: TObjectList<TNco> ;
  LItemEmpresa: TNco ;
  LIndiceAnterior: String ;
begin
  LPlanoService := TVinculoPlanoContabilFactory<TCadPorComPlanoContabil, TPlanco>.New.fPlanoContabilVinculo ;

  cdsCadporComPlanoContabil.DisableControls ;
  LListaCadPor := TObjectList<TCadPorComPlanoContabil>.Create ;
  LIndiceAnterior := cdsPornco.IndexName ;
  cdsPornco.IndexName := 'IndicePesquisa' ;
  try
    LCnt := 0 ;
    cdsCadporComPlanoContabil.First ;
    while not cdsCadporComPlanoContabil.Eof do
    begin
      inc(LCnt) ;
      pgbProgresso.Position := LCnt;
      Application.ProcessMessages;

      LItem := TCadPorComPlanoContabil.Create ;
      LItem.autoincrem := cdsCadporComPlanoContabil.FieldByName('AUTOINCREM').AsString ;
      LItem.por_codpor := cdsCadporComPlanoContabil.FieldByName('POR_CODPOR').AsString ;
      LItem.por_nompor := cdsCadporComPlanoContabil.FieldByName('POR_NOMPOR').AsString ;
      LItem.por_planco := cdsCadporComPlanoContabil.FieldByName('POR_PLANCO').AsString ;
      LItem.nco_descri := cdsCadporComPlanoContabil.FieldByName('NCO_DESCRI').AsString ;

      LEmpresas := TObjectList<TNco>.Create ;

      if cdsPornco.FindKey([LItem.por_codpor]) then
      begin
        while (cdsPornco.FieldByName('NCO_CODPOR').AsString = LItem.por_codpor) and (not cdsPornco.Eof) do
        begin
          LItemEmpresa := TNco.Create ;
          LItemEmpresa.nco_codnco := cdsPornco.FieldByName('NCO_CODPOR').AsString ;
          LItemEmpresa.nco_codemp := cdsPornco.FieldByName('CODEMP').AsString ;
          LItemEmpresa.nco_codcon := cdsPornco.FieldByName('CODCON').AsString ;

          LEmpresas.Add(LItemEmpresa) ;
          cdsPornco.Next ;
        end ;
      end ;

      LItem.empresas := LEmpresas ;

      LListaCadPor.Add(LItem) ;

      cdsCadporComPlanoContabil.Next ;
    end ;

    if LPlanoService.fSalvarVinculo(LListaCadPor) then
      cdsCadporComPlanoContabil.MergeChangeLog ;

  finally
    cdsCadporComPlanoContabil.EnableControls ;
    cdsPornco.IndexName := LIndiceAnterior ;
    FreeAndNil(LListaCadPor) ;
  end ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pFormataContaGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if DisplayText and (not fEmptyStr(Sender.AsString)) then
    Text := FormatMaskText(fMskCon, Sender.AsString)
  else
    Text := Sender.AsString;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pgVinculoChanging(
  Sender: TObject; var AllowChange: Boolean);
var
  LMudancaPlanoReferencial: boolean ;
  LMudancaPlanoContasFinanceiro: boolean ;
  LMudancaPortador: boolean ;
begin
  inherited;
  LMudancaPlanoReferencial := cdsPlancoComPlanoReferencial.ChangeCount <> 0 ;
  LMudancaPlanoContasFinanceiro := cdsCadctaComPlanoContabil.ChangeCount <> 0 ;
  LMudancaPortador := cdsCadporComPlanoContabil.ChangeCount <> 0 ;

  if LMudancaPlanoReferencial or
     LMudancaPlanoContasFinanceiro or
     LMudancaPortador then
  begin
    AllowChange := False ;
    fMensagem('ATENÇÃO!', 'Salvar as alterações antes de mudar de aba!', ['&OK']);
  end ;

end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pSelecionaPlanco(
  const ASelecionar: Boolean);
var
  intRow: integer ;
  intRecordIndex: integer ;
  strPlanco: string ;
begin
  dsPlanoContas.DataSet.DisableControls ;
  try
    for intRow := 0 to GridPlanoContasView.DataController.FilteredRecordCount-1 do
    begin
      intRecordIndex := GridPlanoContasView.DataController.FilteredRecordIndex[intRow] ;
      strPlanco := GridPlanoContasView.DataController.Values[intRecordIndex, GridPlanoContasViewNCO_CODCON.Index] ;
      if dsPlanoContas.DataSet.Locate('NCO_CODCON', strPlanco, [loCaseInsensitive]) then
      begin
        if not fEmptyStr(dsPlanoContas.DataSet.FieldByName('NCO_CTAREF').AsString) then
        begin
          continue ;
        end;
        dsPlanoContas.DataSet.Edit ;
        dsPlanoContas.DataSet.FieldByName('SELECIONADO').AsInteger := iif(ASelecionar,1,0);
        dsPlanoContas.DataSet.Post ;
      end;
    end;
  finally
    dsPlanoContas.DataSet.EnableControls ;
  end;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pSetaTextoProgresso(
  pgbProgresso: TcxProgressBar; strTexto: String);
begin
  if fIsAssignedProgresso(pgbProgresso) then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pVincularContaContabilContaFinanceiro;
var
  strBookMark: string ;
  blnFlag: boolean;
begin
  inherited;
  blnFlag := False ;
  dsPlanoContasFinanceiro.DataSet.DisableControls ;
  try
    strBookMark := dsPlanoContasFinanceiro.DataSet.FieldByName('CTA_CODCTA').AsString ;
    dsPlanoContasFinanceiro.DataSet.First ;
    while not dsPlanoContasFinanceiro.DataSet.Eof do
    begin
      if dsPlanoContasFinanceiro.DataSet.FieldByName('SELECIONADO').AsInteger = 1 then
      begin
        dsPlanoContasFinanceiro.DataSet.Edit ;
        dsPlanoContasFinanceiro.DataSet.FieldByName('CTA_PLANCO').AsString := dsPlancoContasFinanceiro.DataSet.FieldByName('NCO_CODCON').AsString ;
        dsPlanoContasFinanceiro.DataSet.FieldByName('NCO_DESCRI').AsString := dsPlancoContasFinanceiro.DataSet.FieldByName('NCO_DESCRI').AsString ;
        dsPlanoContasFinanceiro.DataSet.FieldByName('SELECIONADO').AsInteger := 0 ;
        dsPlanoContasFinanceiro.DataSet.Post ;
        blnFlag := True ;
      end;
      dsPlanoContasFinanceiro.DataSet.Next ;
    end;
    dsPlanoContasFinanceiro.DataSet.Locate('CTA_CODCTA', strBookMark, [loCaseInsensitive]) ;
  finally
    dsPlanoContasFinanceiro.DataSet.EnableControls ;
  end;
  if not blnFlag then
  begin
    fMensagem('ATENÇÃO!', 'Nenhuma plano de contas financeiro selecionado!', ['&OK']);
    pSetFocus(GridPlanoContasFinanceiro);
  end;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pVincularContaContabilPortador;
var
  LBookMark: string ;
  LFlag: boolean;
begin
  inherited;
  LFlag := False ;
  dsPortadores.DataSet.DisableControls ;
  try
    LBookMark := dsPortadores.DataSet.FieldByName('POR_CODPOR').AsString ;
    dsPortadores.DataSet.First ;
    while not dsPortadores.DataSet.Eof do
    begin
      if dsPortadores.DataSet.FieldByName('SELECIONADO').AsInteger = 1 then
      begin
        dsPortadores.DataSet.Edit ;
        dsPortadores.DataSet.FieldByName('POR_PLANCO').AsString := dsPlancoPortador.DataSet.FieldByName('NCO_CODCON').AsString ;
        dsPortadores.DataSet.FieldByName('NCO_DESCRI').AsString := dsPlancoPortador.DataSet.FieldByName('NCO_DESCRI').AsString ;
        dsPortadores.DataSet.FieldByName('SELECIONADO').AsInteger := 0 ;
        dsPortadores.DataSet.Post ;
        LFlag := True ;
      end;
      dsPortadores.DataSet.Next ;
    end;
    dsPortadores.DataSet.Locate('POR_CODPOR', LBookMark, [loCaseInsensitive]) ;
  finally
    dsPortadores.DataSet.EnableControls ;
  end;
  if not LFlag then
  begin
    fMensagem('ATENÇÃO!', 'Nenhum portador selecionado!', ['&OK']);
    pSetFocus(GridPortadores);
  end;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.pVincularPlanoReferencial;
var
  strBookMark: string ;
  blnFlag: boolean;
begin
  inherited;
  blnFlag := False ;
  dsPlanoContas.DataSet.DisableControls ;
  try
    strBookMark := dsPlanoContas.DataSet.FieldByName('NCO_CODCON').AsString ;
    dsPlanoContas.DataSet.First ;
    while not dsPlanoContas.DataSet.Eof do
    begin
      if dsPlanoContas.DataSet.FieldByName('SELECIONADO').AsInteger = 1 then
      begin
        dsPlanoContas.DataSet.Edit ;
        dsPlanoContas.DataSet.FieldByName('NCO_CTAREF').AsString := dsPlanoReferencial.DataSet.FieldByName('NRE_CODREF').AsString ;
        dsPlanoContas.DataSet.FieldByName('NRE_DESCRI').AsString := dsPlanoReferencial.DataSet.FieldByName('NRE_DESCRI').AsString ;
        dsPlanoContas.DataSet.FieldByName('SELECIONADO').AsInteger := 0 ;
        dsPlanoContas.DataSet.Post ;
        blnFlag := True ;
      end;
      dsPlanoContas.DataSet.Next ;
    end;
    dsPlanoContas.DataSet.Locate('NCO_CODCON', strBookMark, [loCaseInsensitive]) ;
  finally
    dsPlanoContas.DataSet.EnableControls ;
  end;
  if not blnFlag then
  begin
    fMensagem('ATENÇÃO!', 'Nenhum plano de contas selecionado!', ['&OK']);
    pSetFocus(GridPlanoContas);
  end;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.btnSalvarPlanoContasFinanceiroClick(
  Sender: TObject);
begin
  inherited;
  if fMensagem('ATENÇÃO!', 'Confirma os ajustes no plano de contas financeiro?', ['&Sim', '&Não'], 1) = 2 then
    exit ;

  fExecutarVinculo ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.btnSalvarPlanoReferencialClick(
  Sender: TObject);
begin
  inherited;

  if fMensagem('ATENÇÃO!', 'Confirma os ajustes no plano de contas?', ['&Sim', '&Não'], 1) = 2 then
    exit ;

  fExecutarVinculo ;

end;

procedure TfrmPlanoContaVinculoPlanoReferencial.btnSalvarPortadorClick(
  Sender: TObject);
begin
  inherited;
  if fMensagem('ATENÇÃO!', 'Confirma os ajustes no portador?', ['&Sim', '&Não'], 1) = 2 then
    exit ;

  fExecutarVinculo ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.cdsCtancoAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('NCO_CODCTA').AsString := cdsCadctaComPlanoContabil.FieldByName('CTA_CODCTA').AsString ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.cdsPorncoAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('NCO_CODPOR').AsString := cdsCadporComPlanoContabil.FieldByName('POR_CODPOR').AsString ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.Desmarcar1Click(
  Sender: TObject);
begin
  inherited;
  pSelecionaPlanco(False) ;
end;

function TfrmPlanoContaVinculoPlanoReferencial.fCanClose: boolean;
var
  LblnFlagMudanca: boolean ;
  LNomeAbas: String ;
begin
  LNomeAbas := '' ;
  LblnFlagMudanca := cdsPlancoComPlanoReferencial.ChangeCount <> 0 ;
  if LblnFlagMudanca then
    LNomeAbas := LNomeAbas + IfThen(fEmptyStr(LNomeAbas), '', ', ')  + tsPlanoReferencial.Caption  ;

  LblnFlagMudanca := cdsCadctaComPlanoContabil.ChangeCount <> 0 ;
  if LblnFlagMudanca then
    LNomeAbas := LNomeAbas + IfThen(fEmptyStr(LNomeAbas), '', ', ')  + tsPlanoContasFinanceiro.Caption  ;

  LblnFlagMudanca := cdsCadporComPlanoContabil.ChangeCount <> 0 ;
  if LblnFlagMudanca then
    LNomeAbas := LNomeAbas + IfThen(fEmptyStr(LNomeAbas), '', ', ')  + tsPortador.Caption  ;

  if not fEmptyStr(LNomeAbas) then
  begin
    if fMensagem('ATENÇÃO!', 'Existem dados alterados nas seguintes abas:' + #13#10 +
                             LNomeAbas + #13#10 +
                             'Os dados alterados serão perdidos!' + #13#10 + #13#10 +
                             'Deseja continuar?', ['&Sim', '&Não'], 1) = 2 then
    begin
      result := False ;
      exit ;
    end;
  end;

  result := True ;
end;

function TfrmPlanoContaVinculoPlanoReferencial.fConfirmarVinculoPlanoContasFinanceiro(
  pgbProgresso: TcxProgressBar): Boolean;
begin

  result := True ;

  pSetaTextoProgresso(pgbProgresso, 'Vinculando plano de contas contábil no plano de contas financeiro');

  pgbProgresso.Properties.Max := cdsCadctaComPlanoContabil.RecordCount;

  try
    pGravaVinculoPlanoContasFinanceiro(pgbProgresso) ;
    fMensagem('ATENÇÃO!', 'Concluído!', ['&OK']);
    pSetFocus(GridPlanoContasFinanceiro);
  Except
    On E: Exception Do
    Begin
      fMensagem('ATENÇÃO!', 'Problemas ao gravar dados!' + #13 + E.Message, ['&OK']);
    End;
  End;

end;

function TfrmPlanoContaVinculoPlanoReferencial.fConfirmarVinculoPlanoReferencial(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  result := True ;

  pSetaTextoProgresso(pgbProgresso, 'Vinculando plano referencial no plano de contas contábil');

  pgbProgresso.Properties.Max := cdsPlancoComPlanoReferencial.RecordCount;

  try
    pGravaVinculoPlanoReferencial(pgbProgresso) ;
    fMensagem('ATENÇÃO!', 'Concluído!', ['&OK']);
    pSetFocus(GridPlanoReferencial);
  Except
    On E: Exception Do
    Begin
      fMensagem('ATENÇÃO!', 'Problemas ao gravar dados!' + #13 + E.Message, ['&OK']);
    End;
  End;

end;

function TfrmPlanoContaVinculoPlanoReferencial.fConfirmarVinculoPortador(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  result := True ;

  pSetaTextoProgresso(pgbProgresso, 'Vinculando plano de contas contábil no portador');

  pgbProgresso.Properties.Max := cdsCadporComPlanoContabil.RecordCount;

  try
    pGravaVinculoPortador(pgbProgresso) ;
    fMensagem('ATENÇÃO!', 'Concluído!', ['&OK']);
    pSetFocus(GridPortadores);
  Except
    On E: Exception Do
    Begin
      fMensagem('ATENÇÃO!', 'Problemas ao gravar dados!' + #13 + E.Message, ['&OK']);
    End;
  End;
end;

function TfrmPlanoContaVinculoPlanoReferencial.fExecutarVinculo: boolean;
var
  LVinculoSelecionado: TFunctionFormGravando ;
begin
  LVinculoSelecionado := Nil ;

  if pgVinculo.ActivePageIndex = tsPlanoReferencial.PageIndex then
    LVinculoSelecionado := fConfirmarVinculoPlanoReferencial
  else if pgVinculo.ActivePageIndex = tsPlanoContasFinanceiro.PageIndex then
    LVinculoSelecionado := fConfirmarVinculoPlanoContasFinanceiro
  else if pgVinculo.ActivePageIndex = tsPortador.PageIndex then
    LVinculoSelecionado := fConfirmarVinculoPortador ;

  if not Assigned(LVinculoSelecionado) then
    raise Exception.Create('Vinculo não implementado!');

  Try
    result := fChamaTelaGravando(LVinculoSelecionado)
  Except
    On E: Exception Do
    begin
      raise;
    end;
  End;
end;

function TfrmPlanoContaVinculoPlanoReferencial.fIsAssignedProgresso(
  pgbProgresso: TcxProgressBar): boolean;
begin
  result := false ;
  if not Assigned(pgbProgresso) then
    exit ;

  if not Assigned(GetParentForm(pgbProgresso).FindComponent('lblGravando')) then
    exit ;

  result := true ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := fCanClose ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.FormCreate(Sender: TObject);
begin
  inherited;
  cdsPlancoComPlanoReferencial.CreateDataSet ;
  cdsPlancoComPlanoReferencial.LogChanges := True ;
  cdsPlanre.CreateDataSet ;

  cdsCadctaComPlanoContabil.CreateDataSet ;
  cdsCadctaComPlanoContabil.LogChanges := True ;
  cdsPlancoContasFinanceiro.CreateDataSet ;
  cdsCtanco.CreateDataSet ;

  cdsCadporComPlanoContabil.CreateDataSet ;
  cdsCadporComPlanoContabil.LogChanges := True ;
  cdsPlancoPortador.CreateDataSet ;
  cdsPornco.CreateDataSet ;

  tsPlanoReferencial.TabVisible := fCfgSis('EXPECD') = 'S' ;

  pgVinculo.ActivePageIndex := ifThen(tsPlanoReferencial.TabVisible, 0, 1) ;

  cdsCadctaComPlanoContabilCTA_PLANCO.OnGetText          := pFormataContaGetText;
  cdsCadporComPlanoContabilPOR_PLANCO.OnGetText          := pFormataContaGetText;
  cdsPlancoComPlanoReferencialNCO_CODCON.OnGetText       := pFormataContaGetText;
  cdsPlancoContasFinanceiroNCO_CODCON.OnGetText          := pFormataContaGetText;
  cdsPlancoPortadorNCO_CODCON.OnGetText                  := pFormataContaGetText;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_F10 then
  begin
    if pgVinculo.ActivePageIndex = tsPlanoReferencial.PageIndex then
      btnSalvarPlanoReferencial.Click
    else if pgVinculo.ActivePageIndex = tsPlanoContasFinanceiro.PageIndex then
      btnSalvarPlanoContasFinanceiro.Click
    else if pgVinculo.ActivePageIndex = tsPortador.PageIndex then
      btnSalvarPortador.Click ;
  end;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDadosPlancoComPlanre ;
  pCarregaDadosPlanre ;

  pCarregaDadosCadctaComPlanco ;
  pCarregaDadosPlancoContasFinanceiro ;

  pCarregaDadosCadporComPlanco ;
  pCarregaDadosPlancoPortador ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.GridPlanoContabilFinanceiroViewSELECIONADOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pVincularContaContabilContaFinanceiro ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.GridPlanoContabilPortadoresViewSELECIONADOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pVincularContaContabilPortador ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.GridPlanoContasFinanceiroViewCTA_PLANCOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if fEmptyStr(GridPlanoContasFinanceiroViewCTA_PLANCO.DataBinding.Field.AsString) then
  begin
    fMensagem('ATENÇÃO!', 'Plano de conta financeiro sem conta contábil!', ['&OK']);
    exit ;
  end;

  dsPlanoContasFinanceiro.DataSet.Edit ;
  dsPlanoContasFinanceiro.DataSet.FieldByName('CTA_PLANCO').Clear ;
  dsPlanoContasFinanceiro.DataSet.FieldByName('NCO_DESCRI').Clear ;
  dsPlanoContasFinanceiro.DataSet.Post ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.GridPlanoContasFinanceiroViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  if AItem = GridPlanoContasFinanceiroViewCTA_PLANCO then
    Exit ;

  if AItem = GridPlanoContasFinanceiroViewVER_EMPRESA then
    Exit ;

  if GridPlanoContasFinanceiroViewPOR_EMPRESA.DataBinding.Field.AsInteger = 1 then
  begin
    AAllow := False ;
    fMensagem('ATENÇÃO!', 'Plano de conta financeiro possui conta contábil por empresa!', ['&OK']);
    GridPlanoContasFinanceiroViewCTA_PLANCO.FocusWithSelection;
  end ;

  if not fEmptyStr(dsPlanoContasFinanceiro.DataSet.FieldByName('CTA_PLANCO').AsString) then
  begin
    AAllow := False ;
    fMensagem('ATENÇÃO!', 'Desvincule a Conta Contábil!', ['&OK']);
    GridPlanoContasFinanceiroViewCTA_PLANCO.FocusWithSelection;
  end;

end;

procedure TfrmPlanoContaVinculoPlanoReferencial.GridPlanoContasFinanceiroViewVER_EMPRESAPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  LCodCta: String ;
begin
  inherited;
  if not fEmptyStr(GridPlanoContasFinanceiroViewCTA_PLANCO.DataBinding.Field.AsString) then
  begin
    fMensagem('ATENÇÃO!', 'Conta contábil já associada!', ['&OK']);
    exit ;
  end ;

  LCodCta := GridPlanoContasFinanceiroViewCTA_CODCTA.DataBinding.Field.AsString ;
  cdsCtanco.AfterInsert := cdsCtancoAfterInsert ;
  try
    cdsCtanco.Filter := 'NCO_CODCTA = ' + QuotedStr(LCodCta) ;
    cdsCtanco.Filtered := True ;

    pPlanoDeContasPorEmpresa(LCodCta, 'CTANCO', '', dsEdit, cdsCtanco, True);

    dsPlanoContasFinanceiro.DataSet.Edit ;
    dsPlanoContasFinanceiro.DataSet.FieldByName('POR_EMPRESA').AsString := IfThen(cdsCtanco.RecordCount = 0, '0', '1') ;
    dsPlanoContasFinanceiro.DataSet.FieldByName('SELECIONADO').AsString := '0' ;
    dsPlanoContasFinanceiro.DataSet.Post ;

  finally
    cdsCtanco.Filter   := '' ;
    cdsCtanco.Filtered := False ;
    cdsCtanco.AfterInsert := Nil ;
  end ;

end;

procedure TfrmPlanoContaVinculoPlanoReferencial.GridPlanoContasViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  if AItem = GridPlanoContasViewNCO_CTAREF then
  begin
    exit ;
  end;

  if not fEmptyStr(dsPlanoContas.DataSet.FieldByName('NCO_CTAREF').AsString) then
  begin
    AAllow := False ;
    fMensagem('ATENÇÃO!', 'Desvincule o plano referencial!', ['&OK']);
    GridPlanoContasViewNCO_CTAREF.FocusWithSelection;
  end;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.GridPlanoContasViewNCO_CTAREFPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if fEmptyStr(GridPlanoContasViewNCO_CTAREF.DataBinding.Field.AsString) then
  begin
    fMensagem('ATENÇÃO!', 'Plano de conta sem plano referencial!', ['&OK']);
    exit ;
  end;

  dsPlanoContas.DataSet.Edit ;
  dsPlanoContas.DataSet.FieldByName('NCO_CTAREF').Clear ;
  dsPlanoContas.DataSet.FieldByName('NRE_DESCRI').Clear ;
  dsPlanoContas.DataSet.Post ;

end;

procedure TfrmPlanoContaVinculoPlanoReferencial.GridPlanoReferencialViewSELECIONADOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pVincularPlanoReferencial ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.GridPortadoresViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  if AItem = GridPortadoresViewPOR_PLANCO then
    Exit ;

  if AItem = GridPortadoresViewVER_EMPRESA then
    Exit ;

  if GridPortadoresViewPOR_EMPRESA.DataBinding.Field.AsInteger = 1 then
  begin
    AAllow := False ;
    fMensagem('ATENÇÃO!', 'Portador possui conta contábil por empresa!', ['&OK']);
    GridPortadoresViewPOR_PLANCO.FocusWithSelection;
  end ;

  if not fEmptyStr(dsPortadores.DataSet.FieldByName('POR_PLANCO').AsString) then
  begin
    AAllow := False ;
    fMensagem('ATENÇÃO!', 'Desvincule a Conta Contábil!', ['&OK']);
    GridPortadoresViewPOR_PLANCO.FocusWithSelection;
  end;

end;

procedure TfrmPlanoContaVinculoPlanoReferencial.GridPortadoresViewPOR_PLANCOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if fEmptyStr(GridPortadoresViewPOR_PLANCO.DataBinding.Field.AsString) then
  begin
    fMensagem('ATENÇÃO!', 'Portador sem conta contábil!', ['&OK']);
    exit ;
  end;

  dsPortadores.DataSet.Edit ;
  dsPortadores.DataSet.FieldByName('POR_PLANCO').Clear ;
  dsPortadores.DataSet.FieldByName('NCO_DESCRI').Clear ;
  dsPortadores.DataSet.Post ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.GridPortadoresViewVER_EMPRESAPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  LCodPor: String ;
begin
  inherited;
  if not fEmptyStr(GridPortadoresViewPOR_PLANCO.DataBinding.Field.AsString) then
  begin
    fMensagem('ATENÇÃO!', 'Conta contábil já associada!', ['&OK']);
    exit ;
  end ;

  LCodPor := GridPortadoresViewPOR_CODPOR.DataBinding.Field.AsString ;
  cdsPornco.AfterInsert := cdsPorncoAfterInsert ;
  try
    cdsPornco.Filter := 'NCO_CODPOR = ' + QuotedStr(LCodPor) ;
    cdsPornco.Filtered := True ;

    pPlanoDeContasPorEmpresa(LCodPor, 'PORNCO', '', dsEdit, cdsPornco, True);

    dsPortadores.DataSet.Edit ;
    dsPortadores.DataSet.FieldByName('POR_EMPRESA').AsString := IfThen(cdsPornco.RecordCount = 0, '0', '1') ;
    dsPortadores.DataSet.FieldByName('SELECIONADO').AsString := '0' ;
    dsPortadores.DataSet.Post ;

  finally
    cdsPornco.Filter   := '' ;
    cdsPornco.Filtered := False ;
    cdsPornco.AfterInsert := Nil ;
  end ;
end;

procedure TfrmPlanoContaVinculoPlanoReferencial.Marcar1Click(Sender: TObject);
begin
  inherited;
  pSelecionaPlanco(True) ;
end;

end.
