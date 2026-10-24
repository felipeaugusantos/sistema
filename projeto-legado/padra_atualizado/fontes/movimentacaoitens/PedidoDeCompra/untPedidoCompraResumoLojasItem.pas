unit untPedidoCompraResumoLojasItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  untFuncoesSimples, untZClient, Uni, UniClientDataSet, cxCurrencyEdit, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmPedidoCompraResumoLojasItem = class(TfrmPaiEdit)
    cxvItens: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxvItensCODITE: TcxGridDBColumn;
    cxvItensDESITE: TcxGridDBColumn;
    cxvItensSIGUNI: TcxGridDBColumn;
    cxvItensTOTITE: TcxGridDBColumn;
    cxvItensTOTIPI: TcxGridDBColumn;
    cxvItensTOTSUB: TcxGridDBColumn;
    cxvItensTOTGER: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    cxvItensQTDITE: TcxGridDBColumn;
    cxvItensTOTCBS: TcxGridDBColumn;
    cxvItensTOTIBS: TcxGridDBColumn;
    cxvItensTOT_IS: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    cdsResumo: TZClient;
    FblnSomaReforma: Boolean;

    Function fSQLItens: String;

  public
    { Public declarations }
    class procedure pExibeResumo(cdsItensMultLoja, cdsItensPedido : TUniClientDataSet; strCodEmp: String);
  end;

var
  frmPedidoCompraResumoLojasItem: TfrmPedidoCompraResumoLojasItem;

implementation

{$R *.dfm}

procedure TfrmPedidoCompraResumoLojasItem.FormCreate(Sender: TObject);
begin
  inherited;

  cdsResumo := TZClient.Create(Self, fSQLItens);
  cdsResumo.fAbreClient(True, 'TfrmPedidoCompraResumoLojasItem.FormCreate');

  cdsResumo.pAlinhaCampoCentro('CODITE');

  FblnSomaReforma                        := fSomarNovosImpostosDaReformaAoValorContabil;
  cxvItensTOTCBS.Visible                 := FblnSomaReforma;
  cxvItensTOTCBS.VisibleForCustomization := FblnSomaReforma;
  cxvItensTOTIBS.Visible                 := FblnSomaReforma;
  cxvItensTOTIBS.VisibleForCustomization := FblnSomaReforma;
  cxvItensTOT_IS.Visible                 := FblnSomaReforma;
  cxvItensTOT_IS.VisibleForCustomization := FblnSomaReforma;

  cxvItens.DataController.DataSource := cdsResumo.dtsSource;
end;

procedure TfrmPedidoCompraResumoLojasItem.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Key := 0;
end;

procedure TfrmPedidoCompraResumoLojasItem.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  Key := #0;
end;

Function TfrmPedidoCompraResumoLojasItem.fSQLItens: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   ITE_CODITE   AS CODITE, ';
  strSQL := strSQL + '   ITE_DESITE   AS DESITE, ';
  strSQL := strSQL + '   ITE_CODMAR   AS CODMAR, ';
  strSQL := strSQL + '   C.AUTOINCREM AS AUTINC, ';
  strSQL := strSQL + '   UNI_SIGUNI   AS SIGUNI, ';
  strSQL := strSQL + '   0.0000       AS TOTITE, ';
  strSQL := strSQL + '   0.0000       AS TOTIPI, ';
  strSQL := strSQL + '   0.0000       AS TOTCBS, ';
  strSQL := strSQL + '   0.0000       AS TOTIBS, ';
  strSQL := strSQL + '   0.0000       AS TOT_IS, ';
  strSQL := strSQL + '   0.0000       AS TOTSUB, ';
  strSQL := strSQL + '   0.0000       AS TOTGER, ';
  strSQL := strSQL + '   0.0000       AS QTDITE  ';

  strSQL := strSQL + ' FROM CADITE C ';

  strSQL := strSQL + ' INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + ' WHERE FALSE ';
  Result := strSQL;
End;

class procedure TfrmPedidoCompraResumoLojasItem.pExibeResumo(cdsItensMultLoja, cdsItensPedido: TUniClientDataSet; strCodEmp: String);
  var
    frmPedidoCompraResumoLojasItem: TfrmPedidoCompraResumoLojasItem;
    blnFiltered : Boolean;
    strFilter: String;
    strBook : TBookmark;

    fltTotIteAux,
    fltTotIpiAux,
    fltTotCbsAux,
    fltTotIbsAux,
    fltTot_IsAux,
    fltTotSubAux: Double;

    intRecNo: Integer;
    prcAfterScroll: TprcScroll;

begin
  prcAfterScroll := cdsItensPedido.AfterScroll;
  cdsItensPedido.AfterScroll := Nil;

  pCriarFormularios(TfrmPedidoCompraResumoLojasItem, frmPedidoCompraResumoLojasItem);
  With frmPedidoCompraResumoLojasItem Do
  Begin
    blnFiltered := cdsItensMultLoja.Filtered;
    strFilter   := cdsItensMultLoja.Filter;

    Try
      intRecNo  := cdsItensPedido.RecNo;
      cdsItensPedido.DisableControls;

      cdsItensMultLoja.DisableControls;
      cdsItensMultLoja.Filter   := 'ITE_CODEMP = ' + QuotedStr(strCodEmp);
      cdsItensMultLoja.Filtered := True;
      strBook := cdsItensMultLoja.Bookmark;

      cdsItensMultLoja.First;
      While not cdsItensMultLoja.Eof do
      Begin
        if not cdsResumo.Locate('CODITE', cdsItensMultLoja.FieldByName('ITE_CODITE').AsString, []) then
        Begin
          cdsResumo.Insert;
          cdsResumo.FieldByName('CODITE').AsString := cdsItensMultLoja.FieldByName('ITE_CODITE').AsString;
          cdsResumo.FieldByName('DESITE').AsString := cdsItensMultLoja.FieldByName('ITE_DESITE').AsString;
          cdsResumo.FieldByName('SIGUNI').AsString := cdsItensMultLoja.FieldByName('ITE_SIGUNI').AsString;
          cdsResumo.FieldByName('CODMAR').AsString := cdsItensMultLoja.FieldByName('ITE_CODMAR').AsString;

          cdsResumo.FieldByName('TOTITE').AsFloat := 0;
          cdsResumo.FieldByName('TOTIPI').AsFloat := 0;
          cdsResumo.FieldByName('TOTCBS').AsFloat := 0;
          cdsResumo.FieldByName('TOTIBS').AsFloat := 0;
          cdsResumo.FieldByName('TOT_IS').AsFloat := 0;
          cdsResumo.FieldByName('TOTSUB').AsFloat := 0;
          cdsResumo.FieldByName('TOTGER').AsFloat := 0;
          cdsResumo.FieldByName('QTDITE').AsFloat := 0;
        End
        Else
          cdsResumo.Edit;

        If cdsItensPedido.Locate('ITE_CODITE', cdsItensMultLoja.FieldByName('ITE_CODITE').AsString, []) Then
        Begin
          If cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat > 0 Then
          Begin
            fltTotIteAux := (cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat / cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat) * cdsItensMultLoja.FieldByName('ITE_QTDITE').AsFloat;
            fltTotIpiAux := (cdsItensPedido.FieldByName('ITE_TOTIPI').AsFloat / cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat) * cdsItensMultLoja.FieldByName('ITE_QTDITE').AsFloat;
            fltTotSubAux := (cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat / cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat) * cdsItensMultLoja.FieldByName('ITE_QTDITE').AsFloat;
            fltTotCbsAux := (cdsItensPedido.FieldByName('ITE_VALCBS').AsFloat / cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat) * cdsItensMultLoja.FieldByName('ITE_QTDITE').AsFloat;
            fltTotIbsAux := (cdsItensPedido.FieldByName('ITE_VALIBS').AsFloat / cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat) * cdsItensMultLoja.FieldByName('ITE_QTDITE').AsFloat;
            fltTot_IsAux := (cdsItensPedido.FieldByName('ITE_VAL_IS').AsFloat / cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat) * cdsItensMultLoja.FieldByName('ITE_QTDITE').AsFloat;
          End Else
          Begin
            fltTotIteAux := 0;
            fltTotIpiAux := 0;
            fltTotSubAux := 0;
            fltTotCbsAux := 0;
            fltTotIbsAux := 0;
            fltTot_IsAux := 0;
          End;

          cdsResumo.FieldByName('AUTINC').AsString := cdsItensPedido.FieldByName('AUTOINCREM').AsString;

          cdsResumo.FieldByName('QTDITE').AsFloat := cdsResumo.FieldByName('QTDITE').AsFloat + cdsItensMultLoja.FieldByName('ITE_QTDITE').AsFloat;
          cdsResumo.FieldByName('TOTITE').AsFloat := cdsResumo.FieldByName('TOTITE').AsFloat + fltTotIteAux;
          cdsResumo.FieldByName('TOTIPI').AsFloat := cdsResumo.FieldByName('TOTIPI').AsFloat + fltTotIpiAux;
          cdsResumo.FieldByName('TOTCBS').AsFloat := cdsResumo.FieldByName('TOTCBS').AsFloat + fltTotCbsAux;
          cdsResumo.FieldByName('TOTIBS').AsFloat := cdsResumo.FieldByName('TOTIBS').AsFloat + fltTotIbsAux;
          cdsResumo.FieldByName('TOT_IS').AsFloat := cdsResumo.FieldByName('TOT_IS').AsFloat + fltTot_IsAux;
          cdsResumo.FieldByName('TOTSUB').AsFloat := cdsResumo.FieldByName('TOTSUB').AsFloat + fltTotSubAux;
          cdsResumo.FieldByName('TOTGER').AsFloat := cdsResumo.FieldByName('TOTGER').AsFloat + fltTotIteAux +
                                                               fltTotIpiAux +
                                                               fltTotSubAux;

          If FblnSomaReforma Then
            cdsResumo.FieldByName('TOTGER').AsFloat := cdsResumo.FieldByName('TOTGER').AsFloat + fltTotCbsAux + fltTotIbsAux + fltTot_IsAux;
        End;

        cdsResumo.Post;

        cdsItensMultLoja.Next;
      End;

      cdsResumo.Filter := '(TOTGER > 0)';
      cdsResumo.Filtered := True;

      If SameText(cdsItensPedido.IndexFieldNames, 'ITE_DESITE') Then
        cdsResumo.IndexFieldNames := 'DESITE'

      Else If SameText(cdsItensPedido.IndexFieldNames, 'ITE_CODMAR;ITE_DESITE') Then
        cdsResumo.IndexFieldNames := 'CODMAR;DESITE'

      Else If SameText(cdsItensPedido.IndexFieldNames, 'AUTOINCREM') Then
        cdsResumo.IndexFieldNames := 'AUTINC';

      cdsResumo.First;

    Finally
      cdsItensMultLoja.Bookmark := strBook;
      cdsItensMultLoja.Filtered := blnFiltered;
      cdsItensMultLoja.Filter   := strFilter;
      cdsItensMultLoja.EnableControls;
      cdsItensPedido.EnableControls;
      cdsItensPedido.AfterScroll := prcAfterScroll;
    End;

    cdsItensPedido.RecNo := intRecNo;

    Caption := 'Itens da Loja ' + strCodEmp + ' - ' + fRetNomeEmpresaSelec(strCodEmp);

    ShowModal;
  End;
  FreeAndNil(frmPedidoCompraResumoLojasItem);
end;

end.
