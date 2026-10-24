unit untPedidoCompraResumoLojas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, UniClientDataSet, DB, Grids, DBGridCitel, DBGrids,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade, untTypesSistema,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGridCitel, cxClasses, cxGridLevel, cxGrid, untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDropDownEdit,
  cxCurrencyEdit, untCdsDigMultLoja, untSalvaConfiguracaoGrid;

type
  TfrmPedidoCompraResumoLojas = class(TfrmPai)
    btnItens: TBitBtnLocked;
    cxPedidosLevel1: TcxGridLevel;
    cxvPedidos: TcxGridDBTableViewCitel;
    cxPedidos: TcxGridCitel;
    cxPedCODEMP: TcxGridDBColumn;
    cxvPedidosNOMEMP: TcxGridDBColumn;
    cxvPedidosTOTITE: TcxGridDBColumn;
    cxvPedidosTOTIPI: TcxGridDBColumn;
    cxvPedidosTOTSUB: TcxGridDBColumn;
    cxvPedidosTOTGER: TcxGridDBColumn;
    cxvPedidosTOTFRE: TcxGridDBColumn;
    cxvPedidosTOTDES: TcxGridDBColumn;
    lblValorMinFornecedor: TLabel;
    cxPedidosACUMUL: TcxGridDBColumn;
    btnAcumular: TBitBtnLocked;
    cxVPedidosTOTLKG: TcxGridDBColumn;
    cxvPedidosTOTPES: TcxGridDBColumn;
    cxvPedidosTOTCBS: TcxGridDBColumn;
    cxvPedidosTOTIBS: TcxGridDBColumn;
    cxvPedidosTOT_IS: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnItensClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnAcumularClick(Sender: TObject);
    procedure cxPedidosACUMULPropertiesCloseUp(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    clrZebra : TColor;
    FblnSomaReforma: Boolean;

    strAcumulAntes: String;

    stlOrigens : TStringList;
    stlDestinos: TStringList;

    stlLojas: TStringList;
    stlLojasCorrente: TStringList;

    cdsResumo: TZClient;

    FcdsDigMultLoja: TCdsDigMultLoja;

    FcdsItensMultLoja, FcdsItensPedido : TUniClientDataSet;

    procedure pBeforePost(dataSet: TDataset);

    procedure pBeforeEdit(dataSet: TDataset);

    procedure pAfterScroll(dataSet: TDataset);

    Function fSQLResumo: String;

  public

    class procedure pExibeResumo(cdsDigMultLoja: TCdsDigMultLoja; cdsItensMultLoja, cdsItensPedido : TUniClientDataSet; strCodFor: string = '');
  end;



implementation

uses untFuncoesSimples, untPedidoCompraResumoLojasItem;

{$R *.dfm}

{ TfrmPedidoCompraResumoLojas }

procedure TfrmPedidoCompraResumoLojas.pBeforeEdit(dataSet: TDataset);
Begin
  strAcumulAntes := dataSet.FieldByName('ACUMUL').AsString;
End;

procedure TfrmPedidoCompraResumoLojas.pBeforePost(dataSet: TDataset);
  Var
    intIndex: Integer;
Begin

  With dataSet Do
  Begin

   If stlDestinos.Find(strAcumulAntes, intIndex) Then
     stlDestinos.Delete(intIndex);

    stlDestinos.Add(FieldByName('ACUMUL').AsString);

   If fEmptyStr(FieldByName('ACUMUL').AsString) Then
   Begin

     If stlOrigens.Find(FieldByName('CODEMP').AsString, intIndex) Then
       stlOrigens.Delete(intIndex);

   End

   Else stlOrigens.Add(FieldByName('CODEMP').AsString);

  End;

End;

Function TfrmPedidoCompraResumoLojas.fSQLResumo: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   EMP_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   EMP_CODEMP AS ACUMUL, ';
  strSQL := strSQL + '   EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '   0.00       AS TOTITE, ';
  strSQL := strSQL + '   0.00       AS TOTIPI, ';
  strSQL := strSQL + '   0.00       AS TOTCBS, ';
  strSQL := strSQL + '   0.00       AS TOTIBS, ';
  strSQL := strSQL + '   0.00       AS TOT_IS, ';
  strSQL := strSQL + '   0.00       AS TOTSUB, ';
  strSQL := strSQL + '   0.00       AS TOTGER, ';
  strSQL := strSQL + '   0.00       AS TOTFRE, ';
  strSQL := strSQL + '   0.00       AS TOTDES, ';
  strSQL := strSQL + '   0.00       AS TOTLKG, ';
  strSQL := strSQL + '   0.00       AS TOTPES  ';


  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + '   CADEMP ';
  strSQL := strSQL + ' WHERE FALSE ';

  Result := strSQL;
End;

procedure TfrmPedidoCompraResumoLojas.btnAcumularClick(Sender: TObject);
  Var
    cdsCopia: TUniClientDataSet;
    blnTransferiu: Boolean;
begin
  inherited;

  If Not fPergunta('Confirma as transferências informadas?') Then
    Exit;

  blnTransferiu := False;

  cdsCopia := TUniClientDataSet.Create(Nil);
  cdsCopia.Data := cdsResumo.Data;

  With cdsResumo Do
  Begin
    Try
      DisableControls;

      FcdsDigMultLoja.cdsItens.AfterPost := Nil;

      Filtered := False;

      First;

      While Not Eof Do
      Begin

        If Not fEmptyStr(FieldByName('ACUMUL').AsString) Then
        Begin

          If FcdsDigMultLoja.fAcumulaEmpresa(FieldByName('CODEMP').AsString, FieldByName('ACUMUL').AsString) Then
          Begin
            Edit;
            FieldByName('TOTITE').AsFloat := 0;
            FieldByName('TOTIPI').AsFloat := 0;
            FieldByName('TOTCBS').AsFloat := 0;
            FieldByName('TOTIBS').AsFloat := 0;
            FieldByName('TOT_IS').AsFloat := 0;
            FieldByName('TOTSUB').AsFloat := 0;
            FieldByName('TOTGER').AsFloat := 0;
            FieldByName('TOTFRE').AsFloat := 0;
            FieldByName('TOTDES').AsFloat := 0;
            FieldByName('TOTLKG').AsFloat := 0;
            FieldByName('TOTPES').AsFloat := 0;
            Post;
          End

          Else Break;

          blnTransferiu  := True;

        End;

        Next;
      End;

      cdsCopia.First;
      While Not cdsCopia.Eof Do
      Begin

        If (Not fEmptyStr(cdsCopia.FieldByName('ACUMUL').AsString)) And cdsResumo.Locate('CODEMP', cdsCopia.FieldByName('ACUMUL').AsString, [])  Then
        Begin
          cdsResumo.Edit;
          cdsResumo.FieldByName('TOTITE').AsFloat := cdsResumo.FieldByName('TOTITE').AsFloat + cdsCopia.FieldByName('TOTITE').AsFloat;
          cdsResumo.FieldByName('TOTIPI').AsFloat := cdsResumo.FieldByName('TOTIPI').AsFloat + cdsCopia.FieldByName('TOTIPI').AsFloat;
          cdsResumo.FieldByName('TOTCBS').AsFloat := cdsResumo.FieldByName('TOTCBS').AsFloat + cdsCopia.FieldByName('TOTCBS').AsFloat;
          cdsResumo.FieldByName('TOTIBS').AsFloat := cdsResumo.FieldByName('TOTIBS').AsFloat + cdsCopia.FieldByName('TOTIBS').AsFloat;
          cdsResumo.FieldByName('TOT_IS').AsFloat := cdsResumo.FieldByName('TOT_IS').AsFloat + cdsCopia.FieldByName('TOT_IS').AsFloat;
          cdsResumo.FieldByName('TOTSUB').AsFloat := cdsResumo.FieldByName('TOTSUB').AsFloat + cdsCopia.FieldByName('TOTSUB').AsFloat;
          cdsResumo.FieldByName('TOTGER').AsFloat := cdsResumo.FieldByName('TOTGER').AsFloat + cdsCopia.FieldByName('TOTGER').AsFloat;
          cdsResumo.FieldByName('TOTFRE').AsFloat := cdsResumo.FieldByName('TOTFRE').AsFloat + cdsCopia.FieldByName('TOTFRE').AsFloat;
          cdsResumo.FieldByName('TOTDES').AsFloat := cdsResumo.FieldByName('TOTDES').AsFloat + cdsCopia.FieldByName('TOTDES').AsFloat;
          cdsResumo.FieldByName('TOTLKG').AsFloat := cdsResumo.FieldByName('TOTLKG').AsFloat + cdsCopia.FieldByName('TOTLKG').AsFloat;
          cdsResumo.FieldByName('TOTPES').AsFloat := cdsResumo.FieldByName('TOTPES').AsFloat + cdsCopia.FieldByName('TOTPES').AsFloat;

          cdsResumo.Post;
        End;

       cdsCopia.Next;
      End;

    Finally
      FcdsDigMultLoja.cdsItens.AfterPost := FcdsDigMultLoja.pAfterPostMultiloja;

      Filtered := True;

      EnableControls;
    End;

    If blnTransferiu Then
      pMensagemOk('Operação realizada com sucesso!')
    Else
      pMensagemOk('Informe a empresa destino na coluna "Acumular na Empresa"!');

  End;

  FreeAndNil(cdsCopia);
end;

procedure TfrmPedidoCompraResumoLojas.btnItensClick(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(cdsResumo.FieldByName('CODEMP').AsString) Then
    TfrmPedidoCompraResumoLojasItem.pExibeResumo(FcdsItensMultLoja, FcdsItensPedido, cdsResumo.FieldByName('CODEMP').AsString);
end;

procedure TfrmPedidoCompraResumoLojas.cxPedidosACUMULPropertiesCloseUp(
  Sender: TObject);
begin
  inherited;

  If cdsResumo.State = dsEdit Then
    cdsResumo.Post;
end;

procedure TfrmPedidoCompraResumoLojas.pAfterScroll(dataSet: TDataset);
  Var
    intContador,
    intIndex: Integer;
Begin
  If dataSet.ControlsDisabled Then
    Exit;

  stlLojasCorrente.Text := stlLojas.Text;

  If stlLojasCorrente.Find(dataSet.FieldByName('CODEMP').AsString, intIndex) Then
    stlLojasCorrente.Delete(intIndex);

  For intContador := 0 To stlOrigens.Count - 1 Do
    If stlLojasCorrente.Find(stlOrigens[intContador], intIndex) Then
      stlLojasCorrente.Delete(intIndex);

  TcxComboBoxProperties(cxPedidosACUMUL.Properties).Items.Text := stlLojasCorrente.Text;

  cdsResumo.ReadOnly := stlDestinos.Find(dataSet.FieldByName('CODEMP').AsString, intIndex);
End;

procedure TfrmPedidoCompraResumoLojas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxvPedidos,'frmPedidoCompraResumoLojas');
end;

procedure TfrmPedidoCompraResumoLojas.FormCreate(Sender: TObject);
begin
  inherited;

  FblnSomaReforma                          := fSomarNovosImpostosDaReformaAoValorContabil;
  cxvPedidosTOTCBS.Visible                 := FblnSomaReforma;
  cxvPedidosTOTCBS.VisibleForCustomization := FblnSomaReforma;
  cxvPedidosTOTIBS.Visible                 := FblnSomaReforma;
  cxvPedidosTOTIBS.VisibleForCustomization := FblnSomaReforma;
  cxvPedidosTOT_IS.Visible                 := FblnSomaReforma;
  cxvPedidosTOT_IS.VisibleForCustomization := FblnSomaReforma;

  stlDestinos := TStringList.Create;
  stlDestinos.Sorted := True;
  stlDestinos.Duplicates := dupIgnore;

  stlOrigens := TStringList.Create;
  stlOrigens.Sorted := True;
  stlOrigens.Duplicates := dupIgnore;

  stlLojas  := TStringList.Create;
  stlLojas.Add('');

  stlLojasCorrente  := TStringList.Create;

  blnFecharComEscape := True;
  clrZebra := fCfgSis('CORZEB');

  cdsResumo := TZClient.Create(Self, fSQLResumo);
  cdsResumo.fAbreClient(True, '[TfrmPedidoCompraResumoLojas.FormCreate]');
  cdsResumo.pAlinhaCampoCentro('CODEMP');
  cdsResumo.pAlinhaCampoCentro('ACUMUL');

  cxvPedidos.DataController.DataSource := cdsResumo.dtsSource;
end;

procedure TfrmPedidoCompraResumoLojas.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(stlLojas);
end;

procedure TfrmPedidoCompraResumoLojas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE : Close;

    VK_F5 : btnAcumular.Click;

    VK_F2: Begin
             Key := 0;
             btnItens.Click;
             pSetFocus(cxPedidos);
           End;
  End;

end;

procedure TfrmPedidoCompraResumoLojas.FormShow(Sender: TObject);
begin
  inherited;

  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxvPedidos,'frmPedidoCompraResumoLojas');

  If fCfgSis('USATMQ') = 'N' Then
    cxvPedidosTOTLKG.Visible:= False
  Else
  Begin
     cxvPedidosTOTLKG.Visible:= True;
    If SameText(fCfgSis('LITGAL'), 'L') Then
      cxvPedidosTOTLKG.Caption := 'Lt/Kg'
    Else
      cxvPedidosTOTLKG.Caption := 'Galonag.';
  End;


  pSetFocus(cxPedidos);
end;

class procedure TfrmPedidoCompraResumoLojas.pExibeResumo(cdsDigMultLoja: TCdsDigMultLoja;
                      cdsItensMultLoja, cdsItensPedido: TUniClientDataSet; strCodFor: string  = '');
  var
    frmPedidoCompraResumoLojas: TfrmPedidoCompraResumoLojas;
    blnFiltered : Boolean;
    strBook : TBookmark;

    intRecNo: Integer;

    prcAfterScroll: TprcScroll;
begin
  prcAfterScroll := cdsItensPedido.AfterScroll;
  cdsItensPedido.AfterScroll := Nil;

  pCriarFormularios(TfrmPedidoCompraResumoLojas, frmPedidoCompraResumoLojas);
  With frmPedidoCompraResumoLojas Do
  Begin
    FcdsDigMultLoja   := cdsDigMultLoja;
    FcdsItensMultLoja := cdsItensMultLoja;
    FcdsItensPedido   := cdsItensPedido;

    blnFiltered := cdsItensMultLoja.Filtered;
    Try
      intRecNo  := cdsItensPedido.RecNo;
      cdsItensPedido.DisableControls;

      cdsItensMultLoja.DisableControls;
      cdsItensMultLoja.Filtered := False;
      strBook := cdsItensMultLoja.Bookmark;

      If fEmptyStr(strCodFor) Then
        frmPedidoCompraResumoLojas.lblValorMinFornecedor.Visible := False
      Else
        frmPedidoCompraResumoLojas.lblValorMinFornecedor.Caption := 'Valor mínimo exigido pelo fornecedor:' +
          FormatFloat('#0.00', fCampoTabela('FOR_MINPED', 'CADFOR', ['FOR_CODFOR' ], [strCodFor]));

      cdsDigMultLoja.cdsTotalEmpresas.First;
      While not cdsDigMultLoja.cdsTotalEmpresas.Eof do
      Begin

        if not cdsResumo.Locate('CODEMP', cdsDigMultLoja.cdsTotalEmpresas.FieldByName('CODEMP').AsString, []) then
        Begin
          stlLojas.Add(cdsDigMultLoja.cdsTotalEmpresas.FieldByName('CODEMP').AsString);

          cdsResumo.Insert;
          cdsResumo.FieldByName('CODEMP').AsString := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('CODEMP').AsString;
          cdsResumo.FieldByName('NOMEMP').AsString := fRetNomeEmpresaSelec(cdsDigMultLoja.cdsTotalEmpresas.FieldByName('CODEMP').AsString);

          cdsResumo.FieldByName('TOTITE').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTITE').AsFloat;
          cdsResumo.FieldByName('TOTIPI').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTIPI').AsFloat;
          cdsResumo.FieldByName('TOTCBS').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALCBS').AsFloat;
          cdsResumo.FieldByName('TOTIBS').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALIBS').AsFloat;
          cdsResumo.FieldByName('TOT_IS').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VAL_IS').AsFloat;
          cdsResumo.FieldByName('TOTSUB').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTSUB').AsFloat;
          cdsResumo.FieldByName('TOTFRE').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALFRE').AsFloat;
          cdsResumo.FieldByName('TOTDES').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_DESACE').AsFloat;

          cdsResumo.FieldByName('TOTLKG').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_LITROS').AsFloat;
          cdsResumo.FieldByName('TOTPES').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_PESLIT').AsFloat;


          cdsResumo.FieldByName('TOTGER').AsFloat := cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTITE').AsFloat +
                                                     cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTIPI').AsFloat +
                                                     cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_TOTSUB').AsFloat +
                                                     cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_VALFRE').AsFloat +
                                                     cdsDigMultLoja.cdsTotalEmpresas.FieldByName('TOT_DESACE').AsFloat;

          If FblnSomaReforma Then
            cdsResumo.FieldByName('TOTGER').AsFloat := cdsResumo.FieldByName('TOTGER').AsFloat +
                                                       cdsResumo.FieldByName('TOTCBS').AsFloat +
                                                       cdsResumo.FieldByName('TOTIBS').AsFloat +
                                                       cdsResumo.FieldByName('TOT_IS').AsFloat;
        End;

        cdsResumo.Post;

        cdsDigMultLoja.cdsTotalEmpresas.Next;
      End;

      cdsResumo.Filter := '(TOTGER > 0)';
      cdsResumo.Filtered := True;

    Finally
      cdsItensMultLoja.Bookmark := strBook;
      cdsItensMultLoja.Filtered := blnFiltered;
      cdsItensMultLoja.EnableControls;
      cdsItensPedido.EnableControls;
      cdsItensPedido.AfterScroll := prcAfterScroll;
    End;

    cdsItensPedido.RecNo  := intRecNo;

    cdsResumo.AfterScroll := pAfterScroll;
    cdsResumo.BeforeEdit  := pBeforeEdit;
    cdsResumo.BeforePost  := pBeforePost;

    pAfterScroll(cdsResumo);

    ShowModal;
  End;
  FreeAndNil(frmPedidoCompraResumoLojas);

end;

end.
