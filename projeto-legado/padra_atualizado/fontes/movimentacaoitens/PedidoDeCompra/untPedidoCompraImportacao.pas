unit untPedidoCompraImportacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxCurrencyEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView, untTypesSistema,
  cxGridDBBandedTableView, cxClasses, cxGridCustomView, cxGrid, EditFocus, uniClientDataSet, Math,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmPedidoCompraImportacao = class(TfrmPaiEdit)
    pnl1: TPanel;
    lbl4: TLabel;
    lbl8: TLabel;
    edtValTax: TEditFocus;
    edtMarMer: TEditFocus;
    pnl2: TPanel;
    grb1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    edtTotIte: TEditFocus;
    edtTotImp: TEditFocus;
    edtTotIPI: TEditFocus;
    edtTotPis: TEditFocus;
    edtTotCof: TEditFocus;
    edtTotTax: TEditFocus;
    edtTotIcm: TEditFocus;
    edtTotGer: TEditFocus;
    edtTotMar: TEditFocus;
    btnConfirma: TBitBtnLocked;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    dtsItens: TDataSource;
    cxgItens: TcxGrid;
    cxbItens: TcxGridDBBandedTableView;
    cxcItensDBBandedTableView1Column1: TcxGridDBBandedColumn;
    cxcItensDBBandedTableView1Column2: TcxGridDBBandedColumn;
    cxcItensColumn1: TcxGridDBBandedColumn;
    cxcItensColumn2: TcxGridDBBandedColumn;
    cxcItensUNILIQ: TcxGridDBBandedColumn;
    cxcItensColumn4: TcxGridDBBandedColumn;
    cxcItensColumn5: TcxGridDBBandedColumn;
    cxcItensColumn6: TcxGridDBBandedColumn;
    cxcItensColumn7: TcxGridDBBandedColumn;
    cxcItensColumn8: TcxGridDBBandedColumn;
    cxcItensColumn9: TcxGridDBBandedColumn;
    cxcItensColumn10: TcxGridDBBandedColumn;
    cxcItensColumn11: TcxGridDBBandedColumn;
    cxcItensColumn12: TcxGridDBBandedColumn;
    cxcItensColumn13: TcxGridDBBandedColumn;
    cxcItensColumn14: TcxGridDBBandedColumn;
    cxcItensColumn15: TcxGridDBBandedColumn;
    cxcItensColumn16: TcxGridDBBandedColumn;
    cxcItensColumn17: TcxGridDBBandedColumn;
    cxlGrid1Level1: TcxGridLevel;
    cxbItenPerBas: TcxGridDBBandedColumn;
    grbReforma: TGroupBox;
    cxbItensALQCBS: TcxGridDBBandedColumn;
    cxbItensVALCBS: TcxGridDBBandedColumn;
    cxbItensALQIBS: TcxGridDBBandedColumn;
    cxbItensVALIBS: TcxGridDBBandedColumn;
    cxbItensALQ_IS: TcxGridDBBandedColumn;
    cxbItensVAL_IS: TcxGridDBBandedColumn;
    lblTotCbs: TLabel;
    lblTotIbs: TLabel;
    lblTotIs: TLabel;
    edtTotCbs: TEditFocus;
    edtTotIbs: TEditFocus;
    edtTotIs: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxcItensColumn15PropertiesEditValueChanged(Sender: TObject);
    procedure cxcItensColumn15PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxbItenPerBasPropertiesEditValueChanged(Sender: TObject);
    procedure cxbItenPerBasPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    { Private declarations }
    savAfterPost,
    savBeforePost: TprcScroll;
    FblnSomaReforma: Boolean;

    Procedure pRateiaTaxas;
    Procedure pAfterPost(DataSet: TDataSet);
    Procedure pBeforePost(DataSet: TDataSet);
    procedure pMostraResumo;
  public
    { Public declarations }
    cdsItens: TUniClientDataSet;
    intDecUni: Integer;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmPedidoCompraImportacao: TfrmPedidoCompraImportacao;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesAuxiliares, untFuncoesPedidoSimples;

{ TfrmPedidoCompraImportacao }

procedure TfrmPedidoCompraImportacao.cxbItenPerBasPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  If cdsItens.State = dsEdit Then
    cdsItens.Post;

end;

procedure TfrmPedidoCompraImportacao.cxbItenPerBasPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  If (DisplayValue < 0) Or (DisplayValue > 100) Then
  Begin
    DisplayValue := 100;
    pMensagemOk('O percentual da Base de Icms deve ser ser de entre 0 e 100!');
    Error := False;
  End;
end;

procedure TfrmPedidoCompraImportacao.cxcItensColumn15PropertiesEditValueChanged(
  Sender: TObject);
begin
  If cdsItens.State = dsEdit Then
    cdsItens.Post;
end;

procedure TfrmPedidoCompraImportacao.cxcItensColumn15PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If Error Then
  Begin
    ErrorText := '';
    DisplayValue := 0;
    Error := False;

    pMensagemOk('O percentual de ICMS deve ser maior ou igual a zero!');
  End;
end;

procedure TfrmPedidoCompraImportacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    If Not fVerificaCampos Then
    Begin
      Action := caNone;
      Exit;
    End;
  End;

  cdsItens.AfterPost  := savAfterPost;
  cdsItens.BeforePost := savBeforePost;
end;

procedure TfrmPedidoCompraImportacao.FormDestroy(Sender: TObject);
begin
  cdsItens.AfterPost  := Nil;
  cdsItens.BeforePost := Nil;
  inherited;
end;

procedure TfrmPedidoCompraImportacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_F10: btnConfirma.Click;
  End;

end;

procedure TfrmPedidoCompraImportacao.FormShow(Sender: TObject);
begin
  inherited;

  savAfterPost  := cdsItens.AfterPost;
  savBeforePost := cdsItens.BeforePost;

  cdsItens.AfterPost  := pAfterPost;
  cdsItens.BeforePost := pBeforePost;

  TcxCustomCurrencyEditProperties(cxcItensUNILIQ.Properties).DecimalPlaces := intDecUni;

  FblnSomaReforma    := fSomarNovosImpostosDaReformaAoValorContabil;
  grbReforma.Visible := FblnSomaReforma;
  cxbItensALQCBS.Visible := FblnSomaReforma;
  cxbItensVALCBS.Visible := FblnSomaReforma;
  cxbItensALQIBS.Visible := FblnSomaReforma;
  cxbItensVALIBS.Visible := FblnSomaReforma;
  cxbItensALQ_IS.Visible := FblnSomaReforma;
  cxbItensVAL_IS.Visible := FblnSomaReforma;

  pRateiaTaxas;

  pSetFocus(edtValTax);
end;

function TfrmPedidoCompraImportacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  blnMudarFoco := True;

  Result := True;

  If (Sender = edtValTax) Then
  Begin

    If fEmptyStr(edtValTax.Text) Then
    Begin
      edtValTax.Text := '0,00';
    End

    Else If fStrToFloat(edtValTax.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A Taxa Siscomex deve ser maior ou igual a zero!', ['&O k']);
      Result := False;
    End;

  End

  Else If (Sender = edtMarMer) Then
  Begin

    If fEmptyStr(edtMarMer.Text) Then
    Begin
      edtValTax.Text := '0,00';
    End

    Else If fStrToFloat(edtMarMer.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor da Marinha Mercante deve ser maior ou igual a zero!', ['&O k']);
      Result := False;
    End;

  End;

  If Result And (blnBuscaPorChave Or (Sender = edtMarMer)) Then
    pRateiaTaxas;

  If (Not Result) Then
  Begin
    If Sender.CanFocus Then
      pSetFocus(Sender)
  End;

end;

procedure TfrmPedidoCompraImportacao.pAfterPost(DataSet: TDataSet);
begin
  pMostraResumo;
end;

procedure TfrmPedidoCompraImportacao.pBeforePost(DataSet: TDataSet);
var fltFrac, fltAlqReduzida: Double;
  CalculoBaseICMSNotaImp: TConjCalculoBaseICMSNotaImp;
begin
  CalculoBaseICMSNotaImp := fGetCfgCalculoBaseICMSNotaImportacao;
  With DataSet Do
  Begin

    CalculoBaseICMSNotaImp := fGetCfgCalculoBaseICMSNotaImportacao;

    FieldByName('ITE_BASICM').AsFloat := FieldByName('ITE_TOTITE').AsFloat;
    If cbiniII in CalculoBaseICMSNotaImp Then
      FieldByName('ITE_BASICM').AsFloat := FieldByName('ITE_BASICM').AsFloat + FieldByName('ITE_VALIMP').AsFloat;
    If cbiniIPI in CalculoBaseICMSNotaImp Then
      FieldByName('ITE_BASICM').AsFloat := FieldByName('ITE_BASICM').AsFloat + FieldByName('ITE_TOTIPI').AsFloat;
    If cbiniPIS_COFINS in CalculoBaseICMSNotaImp Then
      FieldByName('ITE_BASICM').AsFloat := FieldByName('ITE_BASICM').AsFloat + FieldByName('ITE_VALPIS').AsFloat +
                                                                               FieldByName('ITE_VALCOF').AsFloat;
    If cbiniSiscomex in CalculoBaseICMSNotaImp Then
      FieldByName('ITE_BASICM').AsFloat := FieldByName('ITE_BASICM').AsFloat + FieldByName('ITE_VALSIS').AsFloat;
    If cbiniAFRMM in CalculoBaseICMSNotaImp Then
      FieldByName('ITE_BASICM').AsFloat := FieldByName('ITE_BASICM').AsFloat + FieldByName('ITE_VALMAR').AsFloat;

{*
  ALQ_REDUZIDA = ( ALQICM * PERBAS ) / 100
*}

    fltAlqReduzida := (FieldByName('ITE_ALQICM').AsFloat * FieldByName('ITE_PERBAS').AsFloat) / 100;

    fltFrac := ( 1 -  (fltAlqReduzida / 100));
    If fltFrac <=0 Then
      fltFrac := 0.0001;

    fltAlqReduzida := (FieldByName('ITE_ALQICM').AsFloat * FieldByName('ITE_PERBAS').AsFloat) / 100;
    FieldByName('ITE_BASICM').AsFloat := RoundTo( FieldByName('ITE_BASICM').AsFloat / (fltFrac), -2);

    FieldByName('ITE_VALICM').AsFloat := RoundTo( FieldByName('ITE_BASICM').AsFloat * (fltAlqReduzida / 100), -2);
    If FieldByName('ITE_ALQICM').AsFloat > 0 Then
      DataSet.FieldByName('ITE_BASICM').AsFloat := RoundTo( FieldByName('ITE_VALICM').AsFloat * 100 / FieldByName('ITE_ALQICM').AsFloat, -2);

    pCalculaImpostosReformaItem(DataSet, True);
  End;
end;

procedure TfrmPedidoCompraImportacao.pMostraResumo;
begin
  edtTotIte.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsItens, 'TOT_TOTITE'));
  edtTotImp.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsItens, 'TOT_VALIMP'));
  edtTotIPI.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsItens, 'TOT_TOTIPI'));
  edtTotPis.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsItens, 'TOT_VALPIS'));
  edtTotCof.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsItens, 'TOT_VALCOF'));
  edtTotTax.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsItens, 'TOT_VALSIS'));
  edtTotMar.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsItens, 'TOT_VALMAR'));
  edtTotIcm.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsItens, 'TOT_VALICM'));

  edtTotCbs.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsItens, 'TOT_VALCBS'));
  edtTotIbs.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsItens, 'TOT_VALIBS'));
  edtTotIs.Text  := FormatFloat('#,##0.00', fDoubleAggregate(cdsItens, 'TOT_VAL_IS'));

  edtTotGer.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsItens, 'TOT_TOTITE') +
                                            fDoubleAggregate(cdsItens, 'TOT_VALIMP') +
                                            fDoubleAggregate(cdsItens, 'TOT_TOTIPI') +
                                            fDoubleAggregate(cdsItens, 'TOT_VALPIS') +
                                            fDoubleAggregate(cdsItens, 'TOT_VALCOF') +
                                            fDoubleAggregate(cdsItens, 'TOT_VALSIS') +
                                            fDoubleAggregate(cdsItens, 'TOT_VALMAR') +
                                            fDoubleAggregate(cdsItens, 'TOT_VALICM') +
                                            IIF(FblnSomaReforma,
                                                fDoubleAggregate(cdsItens, 'TOT_VALCBS') +
                                                fDoubleAggregate(cdsItens, 'TOT_VALIBS') +
                                                fDoubleAggregate(cdsItens, 'TOT_VAL_IS'), 0));
end;

procedure TfrmPedidoCompraImportacao.pRateiaTaxas;
  Var
    fltResSis,
    fltResMer,
    fltTotalItens: Double;
Begin
  fltResSis     := fStrToFloat(edtValTax.Text);
  fltResMer     := fStrToFloat(edtMarMer.Text);
  fltTotalItens := fDoubleAggregate(cdsItens, 'TOT_TOTITE');
  With cdsItens Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;
      If RecNo = RecordCount Then
      Begin
        FieldByName('ITE_VALSIS').AsFloat := fltResSis;
        FieldByName('ITE_VALMAR').AsFloat := fltResMer;
      End Else
      Begin
        FieldByName('ITE_VALSIS').AsFloat := RoundTo( ( FieldByName('ITE_TOTITE').AsFloat / fltTotalItens ) * fStrToFloat(edtValTax.Text), -2);
        FieldByName('ITE_VALMAR').AsFloat := RoundTo( ( FieldByName('ITE_TOTITE').AsFloat / fltTotalItens ) * fStrToFloat(edtMarMer.Text), -2);
      End;
      fltResSis := fltResSis - FieldByName('ITE_VALSIS').AsFloat;
      fltResMer := fltResMer - FieldByName('ITE_VALMAR').AsFloat;
      Post;
      Next;
    End;
    EnableControls;
  End;
  pMostraResumo;
end;

end.
