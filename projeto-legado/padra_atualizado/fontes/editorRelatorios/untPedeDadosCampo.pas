unit untPedeDadosCampo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Data.DB,
  DBComboBoxFocus, untFuncoesSimples, untInterfaceRelatorio, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGridCustomView, cxClasses, cxGridLevel, cxGrid,
  cxDropDownEdit, untFuncEditorRel, DBMemoFocus, Vcl.ComCtrls,
  cxDBLookupComboBox,
  untZClient, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxContainer, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit,
  cxColorComboBox, cxDBColorComboBox, ComboBoxFocus, cxGridDBTableView,
  untLegendasGridRelat,
  EditFocus, fs_synmemo;

type
  TfrmPedeDadosCampo = class(TfrmPaiEdit)
    dtsCadCam: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblNroDec: TLabel;
    lblForTot: TLabel;
    dbeNomCam: TDBEditFocus;
    dbeNroDec: TDBEditFocus;
    dbeFilPri: TDBCheckBox;
    dbeForTot: TDBMemoFocus;
    grbVisibilidade: TGroupBox;
    Label4: TLabel;
    lblAprove: TLabel;
    Label5: TLabel;
    dbeVisibi: TDBComboBoxFocus;
    dbeAprove: TDBLookupComboBox;
    dbeExpVis: TDBMemoFocus;
    bdeNulBra: TDBCheckBox;
    grbQuebra: TGroupBox;
    dbeQuebra: TDBCheckBox;
    dbeNewPag: TDBCheckBox;
    dbeReprin: TDBCheckBox;
    pnlMsgDados: TPanel;
    Panel14: TPanel;
    dbeMsgGru: TDBMemoFocus;
    Panel2: TPanel;
    dbeQuaQue: TDBMemoFocus;
    tbsFormula: TTabSheet;
    Panel3: TPanel;
    Label3: TLabel;
    dbeFuncao: TDBComboBoxFocus;
    pnlParametros: TPanel;
    cxGrid1: TcxGrid;
    cxvParametros: TcxGridDBBandedTableView;
    cxvParametrosNOMPAR: TcxGridDBBandedColumn;
    cxvParametrosVALPAR: TcxGridDBBandedColumn;
    cxgParametros: TcxGridLevel;
    dbeDesCam: TDBMemoFocus;
    dbeStaPag: TDBCheckBox;
    dbeSEPARQ: TDBCheckBox;
    dbeMAXFIT: TDBCheckBox;
    dbeREATOT: TDBCheckBox;
    dbeAlinha: TDBRadioGroup;
    grbFonte: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    dbeFntCam: TDBEditFocus;
    btnSetaFonte: TBitBtnLocked;
    dbeFntCnd: TDBMemoFocus;
    btnLimpaFonte: TBitBtnLocked;
    lblAjudaFormula: TLabel;
    bdeDesLin: TDBCheckBox;
    dbeRemLin: TDBCheckBox;
    dbeKeepTg: TDBCheckBox;
    Label8: TLabel;
    dtsCampoFonte: TDataSource;
    dbeDefFon: TcxDBLookupComboBox;
    TabSheet1: TTabSheet;
    Panel4: TPanel;
    tbsLegendas: TTabSheet;
    Panel5: TPanel;
    Label9: TLabel;
    dbeTitLeg: TDBEditFocus;
    dbePosLeg: TDBRadioGroup;
    Label11: TLabel;
    dbeColLeg: TDBEditFocus;
    Panel6: TPanel;
    Panel7: TPanel;
    cxvLegendas: TcxGridDBTableView;
    cxgLegendasLevel1: TcxGridLevel;
    cxgLegendas: TcxGrid;
    cxvLegendasColumn1: TcxGridDBColumn;
    cxvLegendasColumn2: TcxGridDBColumn;
    edtLegenda: TEditFocus;
    Label12: TLabel;
    Panel21: TPanel;
    btnDelCom: TBitBtnLocked;
    btnIncCom: TBitBtnLocked;
    Label13: TLabel;
    btnSetaCorLegenda: TcxColorComboBox;
    Label14: TLabel;
    dbeLegRef: TDBLookupComboBox;
    tbsCodBar: TTabSheet;
    Panel8: TPanel;
    Label15: TLabel;
    dbeCHKSUM: TDBCheckBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    debFNTCAM2: TDBEditFocus;
    btnSetaFonte2: TBitBtnLocked;
    btnLimpaFonte2: TBitBtnLocked;
    Label19: TLabel;
    dbeVALCOR2: TcxDBColorComboBox;
    DBCheckBox1: TDBCheckBox;
    dbeCAMBAR: TDBComboBoxFocus;
    DBEditFocus1: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    Label20: TLabel;
    DBEditFocus3: TDBEditFocus;
    Label21: TLabel;
    cmbPosBar: TComboBoxFocus;
    pnlGraficoComum: TPanel;
    Label10: TLabel;
    cmbTipGra: TComboBoxFocus;
    pnlGrafico: TPanel;
    lblValCor: TLabel;
    lblGroDis: TLabel;
    lblTipDia: TLabel;
    dbeValCor: TcxDBColorComboBox;
    cmbGroDis: TComboBoxFocus;
    cmbTipDia: TComboBoxFocus;
    tbsEditavel: TTabSheet;
    Panel10: TPanel;
    pnlValidacao: TPanel;
    Panel12: TPanel;
    stmSCRVAL: TfsSyntaxMemo;
    dbeEDITAV: TDBCheckBox;
    btnConfirma: TBitBtnLocked;
    frxAjuda: TfrxReport;
    pnlMarcarTodos: TPanel;
    dbeINTERF: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    Label22: TLabel;
    dbeValChe: TDBEditFocus;
    Label23: TLabel;
    dbeValUnc: TDBEditFocus;
    btnAjuda: TBitBtnLocked;
    btnCompila: TBitBtnLocked;
    Panel11: TPanel;
    Panel13: TPanel;
    Label24: TLabel;
    cxlPesGri: TcxDBLookupComboBox;
    cxgParametrosConsulta: TcxGrid;
    cxvParametrosConsulta: TcxGridDBTableView;
    cxvParametrosDESPAR: TcxGridDBColumn;
    cxvParametrosTIPATR: TcxGridDBColumn;
    cxvParametrosVALORC: TcxGridDBColumn;
    cxvParametrosPARPAI: TcxGridDBColumn;
    cxvParametrosNOMCAM: TcxGridDBColumn;
    cxgParametrosLevel1: TcxGridLevel;
    tbsXML: TTabSheet;
    Label25: TLabel;
    DBEditFocus4: TDBEditFocus;
    Label26: TLabel;
    DBEditFocus5: TDBEditFocus;
    Label27: TLabel;
    DBEditFocus6: TDBEditFocus;
    dbeKeepCh: TDBCheckBox;
    DBRadioGroup1: TDBRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure dbeFuncaoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbeVisibiChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbeExpVisExit(Sender: TObject);
    procedure dbeExpVisKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeQuebraClick(Sender: TObject);
    procedure dbeSEPARQClick(Sender: TObject);
    procedure dbeNewPagClick(Sender: TObject);
    procedure dbeStaPagClick(Sender: TObject);
    procedure btnSetaFonteClick(Sender: TObject);
    procedure btnLimpaFonteClick(Sender: TObject);
    procedure lblAjudaFormulaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbTipGraChange(Sender: TObject);
    procedure btnDelComClick(Sender: TObject);
    procedure btnIncComClick(Sender: TObject);
    procedure cxvLegendasCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxvLegendasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCompilaClick(Sender: TObject);
    procedure btnAjudaClick(Sender: TObject);
    procedure cxlPesGriPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    cdsCamposFonte: TZClient;

    objLegendas: TLegendasGridRelat;

    procedure pCarregaLegenda;

    procedure pAtualizaNewPag;
    procedure pAjustaTipoDado;

    Function fCompilaScript(blnDarMensagem: Boolean): Boolean;

  public
    { Public declarations }
    objInterface: TInterfaceRelatorio;

    procedure pCarregaCamposFonte;
  end;

var
  frmPedeDadosCampo: TfrmPedeDadosCampo;

implementation

{$R *.dfm}

uses
  StrUtils,
  untPascalScriptRelatorio,
  untAjudaFormulas;

procedure TfrmPedeDadosCampo.dbeStaPagClick(Sender: TObject);
begin
  inherited;

  If Not Assigned(objInterface) Then
    Exit;

  If (Not dbeStaPag.Checked) And (objInterface.cdsCampos.State = dsEdit) Then
  Begin
    dtsCadCam.dataSet.FieldByName('CAM_SEPARQ').AsString := 'N';
  End;

end;

Function TfrmPedeDadosCampo.fCompilaScript(blnDarMensagem: Boolean): Boolean;
  Var
    intLinhaErro, intColunaErro: Integer;
begin
  Result := True;

  If fEmptyStr(stmSCRVAL.Lines.Text) Then
    Exit;

  If TPascalScriptRelatorio.fCompila(stmSCRVAL.Lines.Text, tscValidate, intLinhaErro, intColunaErro) Then
  Begin
    If blnDarMensagem Then
      pMensagemOk('Script compilado com sucesso!')
  End Else
  Begin
    Result := False;
    pgcDados.ActivePage := tbsEditavel;
    pSetFocus(stmSCRVAL);
    stmSCRVAL.SetPos(intColunaErro,  intLinhaErro);
  End;
end;

procedure TfrmPedeDadosCampo.btnAjudaClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption, frxAjuda);
end;

procedure TfrmPedeDadosCampo.btnCompilaClick(Sender: TObject);
begin
  inherited;

  fCompilaScript(True);
end;

procedure TfrmPedeDadosCampo.btnDelComClick(Sender: TObject);
begin
  inherited;

  objLegendas.pExcluiLegenda;
end;

procedure TfrmPedeDadosCampo.btnIncComClick(Sender: TObject);
begin
  inherited;

  If objLegendas.fAdicionaLegenda(edtLegenda.Text, btnSetaCorLegenda.ColorValue) Then
  Begin
    edtLegenda.Clear;
    btnSetaCorLegenda.Clear;
    pSetFocus(edtLegenda);
  End;

end;

procedure TfrmPedeDadosCampo.btnLimpaFonteClick(Sender: TObject);
begin
  inherited;
  dtsCadCam.dataSet.FieldByName('CAM_FNTCAM').Clear;
end;

procedure TfrmPedeDadosCampo.btnSetaFonteClick(Sender: TObject);
var
  fntDialog: TFontDialog;
begin
  inherited;

  fntDialog := TFontDialog.Create(nil);
  try
    if not fEmptyStr(dtsCadCam.dataSet.FieldByName('CAM_FNTCAM').AsString) then
      fntDialog.Font := TInterfaceRelatorio.StrToFont(dtsCadCam.dataSet.FieldByName('CAM_FNTCAM').AsString);
    if fntDialog.Execute then
      dtsCadCam.dataSet.FieldByName('CAM_FNTCAM').AsString := TInterfaceRelatorio.FontToStr(fntDialog.Font);
  finally
    FreeAndNil(fntDialog);
  end;
end;

procedure TfrmPedeDadosCampo.cmbTipGraChange(Sender: TObject);
begin
  inherited;

  pAjustaTipoDado;
end;

procedure TfrmPedeDadosCampo.cxlPesGriPropertiesChange(Sender: TObject);
begin
  inherited;

  objInterface.objConsultasGrid.fIncluiFiltros(dtsCadCam.dataSet.FieldByName('CAM_NOMCAM').AsString,
                                               VarToStr(cxlPesGri.EditValue));
end;

procedure TfrmPedeDadosCampo.cxvLegendasCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  pCarregaLegenda;
end;

procedure TfrmPedeDadosCampo.cxvLegendasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: pCarregaLegenda;
  End;
end;

procedure TfrmPedeDadosCampo.pCarregaLegenda;
Begin
  If Not objLegendas.IsEmpty Then
  Begin
    edtLegenda.Text := objLegendas.FieldByName('legenda').AsString;
    btnSetaCorLegenda.ColorValue := objLegendas.FieldByName('cor').AsInteger;
  End;
End;

procedure TfrmPedeDadosCampo.dbeExpVisExit(Sender: TObject);
begin
  inherited;

  dbeVisibiChange(Nil);
end;

procedure TfrmPedeDadosCampo.dbeExpVisKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  dbeVisibiChange(Nil);
end;

procedure TfrmPedeDadosCampo.dbeFuncaoChange(Sender: TObject);
begin
  inherited;

  objInterface.pCarregaParametrosFuncao(dbeFuncao.Text);
end;

procedure TfrmPedeDadosCampo.dbeNewPagClick(Sender: TObject);
begin
  inherited;

  If Not Assigned(objInterface) Then
    Exit;

  If (Not dbeNewPag.Checked) And (objInterface.cdsCampos.State = dsEdit) Then
  Begin
    dtsCadCam.dataSet.FieldByName('CAM_SEPARQ').AsString := 'N';
  End;

end;

procedure TfrmPedeDadosCampo.dbeQuebraClick(Sender: TObject);
begin
  inherited;

  pAtualizaNewPag;

  If Not Assigned(objInterface) Then
    Exit;

  With objInterface.cdsCampos Do
  Begin
    If dbeQuebra.Checked And (State = dsEdit) Then
      dbeREATOT.Checked := True;
  End;
end;

procedure TfrmPedeDadosCampo.dbeSEPARQClick(Sender: TObject);
begin
  inherited;

  If Not Assigned(objInterface) Then
    Exit;

  If dbeSEPARQ.Checked And (objInterface.cdsCampos.State = dsEdit) Then
  Begin
    dtsCadCam.dataSet.FieldByName('CAM_NEWPAG').AsString := 'S';
    dtsCadCam.dataSet.FieldByName('CAM_STAPAG').AsString := 'S';
  End;
end;

procedure TfrmPedeDadosCampo.pAtualizaNewPag;
Begin
  If Not Assigned(objInterface) Then
    Exit;

  With objInterface.cdsCampos Do
  Begin
    dbeNewPag.Enabled := dbeQuebra.Checked;
    dbeReprin.Enabled := dbeQuebra.Checked;
    dbeMsgGru.Enabled := dbeQuebra.Checked;

    If (Not dbeNewPag.Enabled) And (State = dsEdit) Then
      dbeNewPag.Checked := False;

    If (Not dbeReprin.Enabled) And (State = dsEdit) Then
      dbeReprin.Checked := False;
  End;
End;

procedure TfrmPedeDadosCampo.dbeVisibiChange(Sender: TObject);
  Var
    blnAprove: Boolean;
begin
  inherited;

  With objInterface.cdsCampos Do
  Begin
    blnAprove := (Not SameText(dbeVisibi.Text, ArrDesVisibilidade[visSempre])) Or
                 (Not fEmptyStr(dbeExpVis.Text));

    If (State = dsEdit) And (Not blnAprove) Then
      FieldByName('CAM_APROVE').Clear;

    dbeAprove.Enabled := blnAprove;
    lblAprove.Enabled := dbeAprove.Enabled;
  End;
end;

procedure TfrmPedeDadosCampo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If dbeINTERF.Checked Then
    Begin
      If fEmptyStr(dbeValChe.Text) Or fEmptyStr(dbeValUnc.Text) Then
      Begin
        pMensagemOk('Os campos Valor Marcardo e Valor Desmarcado devem ser preenchidos!');
        Action := caNone;
        Exit;
      End;

      If SameText(dbeValChe.Text, dbeValUnc.Text) Then
      Begin
        pMensagemOk('Os campos Valor Marcardo e Valor Desmarcado não podem ter os mesmos valores!');
        Action := caNone;
        Exit;
      End;

    End;

    If (dbeForTot.Enabled And (Not objInterface.fCompilaExpressao(dbeForTot.Text, 'Fórmula para Totalização'))) Or
       (Not objInterface.fCompilaExpressao(dbeExpVis.Text, 'Expressão que torna o campo visível')) Or
       (Not objInterface.fCompilaExpressao(dbeQuaQue.Text, 'Expressão para realizar a quebra')) Then
    Begin
      Action := caNone;
      Exit;
    End;

    If Not fCompilaScript(False) Then
    Begin
      Action := caNone;
      Exit;
    End;

    dtsCadCam.dataSet.FieldByName('CAM_TIPGRA').AsInteger := cmbTipGra.ItemIndex;
    dtsCadCam.dataSet.FieldByName('CAM_GRODIS').AsInteger := cmbGroDis.ItemIndex;
    dtsCadCam.dataSet.FieldByName('CAM_TIPDIA').AsInteger := cmbTipDia.ItemIndex;
    dtsCadCam.dataSet.FieldByName('CAM_POSBAR').AsInteger := cmbPosBar.ItemIndex;

    dtsCadCam.dataSet.FieldByName('CAM_LEGEND').AsString := objLegendas.fRetornaLegendas;

    dtsCadCam.dataSet.FieldByName('CAM_SCRVAL').AsString := AnsiReplaceStr(stmSCRVAL.Lines.Text, #13#10, '<<csq>>');
  End;

end;

procedure TfrmPedeDadosCampo.pCarregaCamposFonte;
Begin
  If Not Assigned(cdsCamposFonte) Then
  Begin
    cdsCamposFonte := TZClient.Create(Self);
    cdsCamposFonte.Data := objInterface.cdsCampos.Data;
    cdsCamposFonte.IndexFieldNames := 'CAM_NOMCAM';
    dtsCampoFonte.DataSet := cdsCamposFonte;
  End;
End;

procedure TfrmPedeDadosCampo.FormCreate(Sender: TObject);
begin
  inherited;
  {Se resolução disponível for inferior ou igual à (1366 x 768), ajusta a tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  cdsCamposFonte := Nil;

  objLegendas := TLegendasGridRelat.Create(Self);
end;

procedure TfrmPedeDadosCampo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_BACK: Begin
               If (objInterface.cdsCampos.State = dsEdit) And dbeAprove.Focused Then
                 objInterface.cdsCampos.FieldByName('CAM_APROVE').Clear;

               If (objInterface.cdsCampos.State = dsEdit) And dbeLegRef.Focused Then
                  objInterface.cdsCampos.FieldByName('CAM_LEGREF').Clear;
             End;

    VK_DELETE: If (objInterface.cdsCampos.State = dsEdit) Then
               Begin
                  If dbeCAMBAR.Focused Then
                    dtsCadCam.dataSet.FieldByName('CAM_CAMBAR').Clear

                  Else If cmbPosBar.Focused Then
                    dtsCadCam.dataSet.FieldByName('CAM_POSBAR').Clear;
               End;
  End;

end;

procedure TfrmPedeDadosCampo.FormShow(Sender: TObject);
begin
  inherited;

  pgcDados.ActivePageIndex := 0;

  lblNroDec.Enabled := SameText(dtsCadCam.dataSet.FieldByName('CAM_TIPCAM').AsString, String(ArrDesInterface[facFloat]));
  dbeNroDec.Enabled := lblNroDec.Enabled;

  dbeForTot.Enabled := SameText(dtsCadCam.dataSet.FieldByName('CAM_TOTALI').AsString, STR_DEF_FORMULA);
  lblForTot.Enabled := dbeForTot.Enabled;

  cmbTipGra.ItemIndex := dtsCadCam.dataSet.FieldByName('CAM_TIPGRA').AsInteger;
  cmbTipDia.ItemIndex := dtsCadCam.dataSet.FieldByName('CAM_TIPDIA').AsInteger;
  cmbGroDis.ItemIndex := dtsCadCam.dataSet.FieldByName('CAM_GRODIS').AsInteger;
  cmbPosBar.ItemIndex := dtsCadCam.dataSet.FieldByName('CAM_POSBAR').AsInteger;

  stmSCRVAL.Lines.Text := AnsiReplaceStr(dtsCadCam.dataSet.FieldByName('CAM_SCRVAL').AsString, '<<csq>>', #13#10);

  objLegendas.fCarregaLegendas(dtsCadCam.dataSet.FieldByName('CAM_LEGEND').AsString);
  cxvLegendas.DataController.DataSource := objLegendas.dtsSource;

  pSetFocus(dbeDesCam);

  dbeVisibiChange(Nil);

  cxlPesGriPropertiesChange(Nil);

  pAtualizaNewPag;
end;

procedure TfrmPedeDadosCampo.lblAjudaFormulaClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmAjudaFormulas, frmAjudaFormulas);
  pSetFocus(dbeForTot);
end;

procedure TfrmPedeDadosCampo.pAjustaTipoDado;
Begin
  lblValCor.Enabled := dtsCadCam.dataSet.FieldByName('CAM_TIPGRA').AsInteger = 1;
  dbeValCor.Enabled := dtsCadCam.dataSet.FieldByName('CAM_TIPGRA').AsInteger = 1;

  lblGroDis.Enabled := dtsCadCam.dataSet.FieldByName('CAM_TIPGRA').AsInteger = 3;
  cmbGroDis.Enabled := dtsCadCam.dataSet.FieldByName('CAM_TIPGRA').AsInteger = 3;
  cmbTipDia.Enabled := dtsCadCam.dataSet.FieldByName('CAM_TIPGRA').AsInteger = 3;
End;

end.
