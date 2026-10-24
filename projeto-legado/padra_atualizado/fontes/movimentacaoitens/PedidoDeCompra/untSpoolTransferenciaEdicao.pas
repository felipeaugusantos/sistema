unit untSpoolTransferenciaEdicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridBandedTableView,
  cxGridDBBandedTableView, cxCurrencyEdit,
  untGeraSpoolTransferencia, cxCheckBox,
  untCfgGrid,
  untSalvaConfiguracaoGrid, UniClientDataSet, cxTextEdit;

type
  TfrmSpoolTransferenciaEdicao = class(TfrmPaiConfirma)
    cxgItens: TcxGrid;
    cxgItensLevel1: TcxGridLevel;
    cxvItens: TcxGridDBBandedTableView;
    cxvItensEMPORI: TcxGridDBBandedColumn;
    cxvItensDESITE: TcxGridDBBandedColumn;
    cxvItensQTDITE: TcxGridDBBandedColumn;
    cxvItensSALDIS_Destino: TcxGridDBBandedColumn;
    cxvItensQTDEXC: TcxGridDBBandedColumn;
    cxvItensSIGUNI: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxvItensCODITE: TcxGridDBBandedColumn;
    cxvItensSUGEST: TcxGridDBBandedColumn;
    cxvItensMARDES: TcxGridDBBandedColumn;
    cxvItensMINDES: TcxGridDBBandedColumn;
    Panel1: TPanel;
    shpAbaixoZero: TShape;
    lblMsgReq: TLabel;
    shpTransfere: TShape;
    Label1: TLabel;
    shpAbaixoMinimo: TShape;
    Label2: TLabel;
    shpAcimaMinimo: TShape;
    Label3: TLabel;
    cxvItensSIITE: TcxGridDBBandedColumn;
    Label4: TLabel;
    cxvItensSALFIS_Origem: TcxGridDBBandedColumn;
    cxvItensSALDIS_Origem: TcxGridDBBandedColumn;
    cxvItensSALFIS_Destino: TcxGridDBBandedColumn;
    cxvItensDIAEST_Origem: TcxGridDBBandedColumn;
    cxvItensDIAEST_Destino: TcxGridDBBandedColumn;
    cxvItensDIATRA_Destino: TcxGridDBBandedColumn;
    cxvItensSALBAS_Destino: TcxGridDBBandedColumn;
    cxvItensSALBAS_Origem: TcxGridDBBandedColumn;
    btnMarcarItem: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnCfgGri: TBitBtnLocked;
    cxvItensESTMIN: TcxGridDBBandedColumn;
    cxvItensMEDORI: TcxGridDBBandedColumn;
    cxvItensMEDDES: TcxGridDBBandedColumn;
    lblTitTotPes: TLabel;
    lblTotPes: TLabel;
    lblTitPesoBruto: TLabel;
    lblTotPesoBruto: TLabel;
    Panel2: TPanel;
    rdgAgrupar: TRadioGroup;
    cxvItensEMPDES: TcxGridDBBandedColumn;
    cxvItensQTDALT: TcxGridDBBandedColumn;
    cxvItensFORFIL: TcxGridDBBandedColumn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxvItensCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnMarcarItemClick(Sender: TObject);
    procedure cxvItensQTDITEPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvItensDataControllerFilterChanged(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCfgGriClick(Sender: TObject);
    procedure rdgAgruparClick(Sender: TObject);
  private
    { Private declarations }

    blnMarcar: Boolean;
    wrdLastKey: Word;

    objCfgGri: TCfgGrid;

    Procedure pBeforePost(cdsItens: TDataSet);

    Procedure pAfterPost(cdsItens: TDataSet);

    procedure pAgrupaPorEmpresaDestino;
    procedure pAgrupaPorEmpresaOrigem;
    procedure pAgrupaPorProduto;

    Function fMarcaDesmarcaTodos(cxgProgresso: TcxProgressBar): Boolean;

    procedure pAjustaColunas;
    function  fZeraNegativo(fltValor: Double): Double;
    procedure pCalculaRodape;

  public
    { Public declarations }
    objSpool: TGeraSpoolTransferencia;
  end;

var
  frmSpoolTransferenciaEdicao: TfrmSpoolTransferenciaEdicao;

implementation

{$R *.dfm}

Uses
  System.UITypes,
  Math,
  untGravando,
  untFuncoesSimples;


procedure TfrmSpoolTransferenciaEdicao.btnCfgGriClick(Sender: TObject);
begin
  inherited;

  objCfgGri.pConfiguraColunas
end;

procedure TfrmSpoolTransferenciaEdicao.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  cxvItens.DataController.Filter.BeginUpdate;
  Try
    cxvItens.DataController.Filter.Root.Clear;
  Finally
    cxvItens.DataController.Filter.EndUpdate
  End;
end;

procedure TfrmSpoolTransferenciaEdicao.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  blnMarcar := False;

  TfrmGravando.fExecuta(fMarcaDesmarcaTodos, frmGravando);
end;

Function TfrmSpoolTransferenciaEdicao.fMarcaDesmarcaTodos(cxgProgresso: TcxProgressBar): Boolean;
  Var
    intContador: Integer;
    strEmpDes,
    strCodIte,
    strCodEmp: String;
Begin
  objSpool.cdsItens.AfterPost := Nil;

  If blnMarcar Then
    frmGravando.lblGravando.Caption := 'Marcando itens, aguarde...'
  Else
    frmGravando.lblGravando.Caption := 'Desmarcando itens, aguarde...';

  cxgProgresso.Properties.Max := cxvItens.ViewData.RecordCount;

  objSpool.cdsItens.IndexFieldNames := 'CODITE;EMPDES;CODEMP';

  For intContador := 0 To cxvItens.ViewData.RecordCount - 1 Do
  Begin
    If cxvItens.ViewData.Records[intContador].IsData Then
    Begin
      strEmpDes := cxvItens.ViewData.Records[intContador].Values[cxvItensEMPDES.Index];
      strCodIte := cxvItens.ViewData.Records[intContador].Values[cxvItensCODITE.Index];
      strCodEmp := cxvItens.ViewData.Records[intContador].Values[cxvItensEMPORI.Index];

      If objSpool.cdsItens.FindKey([strCodIte, strEmpDes, strCodEmp]) Then
      Begin
        objSpool.cdsItens.Edit;
        objSpool.cdsItens.FieldByName('MARDES').AsString := IIF(blnMarcar, 'S', 'N');
        objSpool.cdsItens.Post;
      End;
    End;

    cxgProgresso.Position := cxgProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  pCalculaRodape;
  Result := True;

  objSpool.cdsItens.AfterPost := pAfterPost;
End;

procedure TfrmSpoolTransferenciaEdicao.btnMarcarItemClick(Sender: TObject);
begin
  inherited;

  objSpool.pMarcaDesmarca;

  pCalculaRodape;
end;

procedure TfrmSpoolTransferenciaEdicao.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  blnMarcar := True;

  TfrmGravando.fExecuta(fMarcaDesmarcaTodos, frmGravando);
end;

procedure TfrmSpoolTransferenciaEdicao.cxvItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    fltSalDis,
    fltEstMin: Double;
begin
  inherited;

  fltSalDis := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensSALDIS_Destino.Index]));
  fltEstMin := fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensMINDES.Index]));

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                          cxvItensMARDES.Index]) = 'S' Then
  Begin
    ACanvas.Brush.Color := shpTransfere.Brush.Color;
  End;

  If fltSalDis <= 0 Then
  Begin
    ACanvas.Font.Color := shpAbaixoZero.Brush.Color;
  End

  Else If fltSalDis < fltEstMin Then
  Begin
    ACanvas.Font.Color := shpAbaixoMinimo.Brush.Color;
  End

  Else If fltSalDis >= fltEstMin Then
  Begin
    ACanvas.Font.Color := shpAcimaMinimo.Brush.Color;
  End


end;

procedure TfrmSpoolTransferenciaEdicao.cxvItensDataControllerFilterChanged(
  Sender: TObject);
begin
  inherited;

  cxvItens.ViewData.Expand(True);
end;

Procedure TfrmSpoolTransferenciaEdicao.pBeforePost(cdsItens: TDataSet);
Begin
  With cdsItens Do
  Begin
    If (RoundTo(FieldByName('QTDANT').AsFloat, -4) <> RoundTo(FieldByName('QTDITE').AsFloat, -4)) Then
      FieldByName('QTDALT').AsString := 'S'
    Else
      FieldByName('QTDALT').AsString := 'N';

    objSpool.pAjustaDiasEstQtdTra(cdsItens);
  End;
End;

Procedure TfrmSpoolTransferenciaEdicao.pAfterPost(cdsItens: TDataSet);
Begin
  If objSpool.cdsItens.FieldByName('MARDES').AsString = 'S' Then
    pCalculaRodape;

  If wrdLastKey <> VK_DOWN Then
    cxvItens.NavigatorButtons.Next.Click;
End;

procedure TfrmSpoolTransferenciaEdicao.cxvItensQTDITEPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
Var
  strCodUni,strCodIte, strItemFracionado: String;
  fltQtdAnt,
  fltQtdDis: Double;
  blnResult: Boolean;
begin
  inherited;
  blnResult := True;

  strCodIte := '';
  strCodUni := '';
  strItemFracionado := '';

  fltQtdAnt := objSpool.cdsItens.FieldByName('QTDITE').AsFloat;

  objSpool.cdsFornecedoras.FindKey([objSpool.cdsItens.FieldByName('CODEMP').AsString,
                                    objSpool.cdsItens.FieldByName('CODITE').AsString]);

  fltQtdDis := objSpool.cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat + fltQtdAnt;

  If fStrToFloat(DisplayValue) < 0 Then
  Begin

    Keybd_Event(VK_ESCAPE, 0, 0, 0);

    If (objSpool.cdsItens.State = dsEdit) Then
      objSpool.cdsItens.Cancel;


    pMensagemOk('A quantidade deve ser maior ou igual a zero!');

    blnResult := False;
  End

  Else If (fStrToFloat(DisplayValue) > fZeraNegativo(fltQtdDis)) Then
  Begin
    Keybd_Event(VK_ESCAPE, 0, 0, 0);

    If (objSpool.cdsItens.State = dsEdit) Then
      objSpool.cdsItens.Cancel;

    pMensagemOk('A quantidade remanescente na origem para distribuição é de ' + FormatFloat(fMskDigitos(2), fltQtdDis)  +  '!');

    blnResult := False;
  End

  Else If (fStrToFloat(DisplayValue) > fZeraNegativo(objSpool.cdsItens.FieldByName('SALDIS_ORI').AsFloat)) Then
  Begin
    Keybd_Event(VK_ESCAPE, 0, 0, 0);

    If (objSpool.cdsItens.State = dsEdit) Then
      objSpool.cdsItens.Cancel;

    pMensagemOk('A quantidade deve ser menor ou igual ao Saldo Disponível de Origem!');

    blnResult := False;
  End

  Else If fStrToFloat(DisplayValue) > 0 Then
  Begin
    strCodIte := objSpool.cdsItens.FieldByName('CODITE').AsString;
    strCodUni := fCampoTabela('ITE_CODUNI', 'CADITE', ['ITE_CODITE'], [strCodIte]);
    strItemFracionado := fCampoTabela('UNI_ITEFRA', 'CADUNI', ['UNI_CODUNI'], [strCodUni]);

    If (strItemFracionado = 'N') And (frac(fStrToFloat(DisplayValue)) <> 0) Then
    Begin
      Keybd_Event(VK_ESCAPE, 0, 0, 0);
      pMensagemOk('Não é permitido informar valor fracionado para esse item!');
      If (objSpool.cdsItens.State = dsEdit) Then
        objSpool.cdsItens.Cancel;

      blnResult := False;
    End

  End;

  If blnResult Then
  Begin
    objSpool.cdsFornecedoras.Edit;
    objSpool.cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat := objSpool.cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat
                                            + fltQtdAnt - fStrToFloat(DisplayValue);
    objSpool.cdsFornecedoras.Post;
  End;
end;

procedure TfrmSpoolTransferenciaEdicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If fPergunta('Confirma a transferência da saldos?') Then
    Begin

      If objSpool.fGeraTransferencia(True) Then
        pMensagemOk('Transferências geradas com sucesso!')
      Else
        Action := caNone;

    End Else
      Action := caNone;

  End Else
  Begin

    If Not fPergunta('Deseja abandonar a tarefa?') Then
      Action := caNone;

  End;

  TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxvItens, Self.Name);
end;

procedure TfrmSpoolTransferenciaEdicao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key <> 37 Then
    wrdLastKey := Key;

  Case Key of

    VK_F5 : btnMarcarItem.Click;
    VK_F6 : btnMarcaTodos.Click;
    VK_F7 : btnDesmarcaTodos.Click;

    VK_F10: btnConfirma.Click;

  End;
end;

procedure TfrmSpoolTransferenciaEdicao.pAjustaColunas;
Begin
  If objSpool.recOpcGir.blnMedAju Then
  Begin
    cxvItensMEDDES.DataBinding.FieldName := 'AJUSTA_DES';
    cxvItensMEDDES.Caption := 'Méd.Ajus.Dest.';

    cxvItensMEDORI.DataBinding.FieldName := 'AJUSTA_ORI';
    cxvItensMEDORI.Caption := 'Méd.Ajus.Orig.';
  End Else
  Begin
    cxvItensMEDDES.DataBinding.FieldName := 'MEDIA__DES';
    cxvItensMEDDES.Caption := 'Média Destino';

    cxvItensMEDORI.DataBinding.FieldName := 'MEDIA__ORI';
    cxvItensMEDORI.Caption := 'Média Origem';
  End;
End;

procedure TfrmSpoolTransferenciaEdicao.FormShow(Sender: TObject);
begin
  inherited;
  cxvItens.DataController.DataSource := objSpool.cdsItens.dtsSource;
  cxvItens.ViewData.Expand(True);
  cxvItens.NavigatorButtons.First.Click;

  objSpool.cdsItens.BeforePost := pBeforePost;

  pAjustaColunas;

  objCfgGri := TCfgGrid.Create(Self, cxvItens, Self.Caption);

  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxvItens, Self.Name);

  pAjustaColunas;

  If objCfgGri.blnAjustouColunasVazio Then
  Begin
    cxvItens.ApplyBestFit;

    objCfgGri.blnAjustouColunasVazio := objSpool.cdsItens.IsEmpty;
  End;

  pCalculaRodape;

  objSpool.cdsItens.AfterPost := pAfterPost;

  If objSpool.cdsFornecedoras.Active Then
  Begin
    objSpool.cdsFornecedoras.Filtered := False;
    objSpool.cdsFornecedoras.IndexFieldNames := 'ITE_CODEMP;ITE_CODITE';
  End;

  rdgAgruparClick(Nil);

  cxvItens.ViewData.Expand(False);
end;

function TfrmSpoolTransferenciaEdicao.fZeraNegativo(fltValor: Double): Double;
begin
  Result := fltValor;
  If Result < 0 Then
    Result := 0
end;

procedure TfrmSpoolTransferenciaEdicao.pCalculaRodape;
var
  cdsAux: TUniClientDataSet;
  fltTotQtd,
  fltTotPes: Double;
Begin
  cdsAux := TUniClientDataSet.Create(Nil);
  fltTotQtd := 0;
  fltTotPes := 0;
  Try
    cdsAux.Data := objSpool.cdsItens.Data;

    lblTotPes.Caption := FormatFloat('#,##0.000', 0);
    lblTotPesoBruto.Caption := FormatFloat('#,##0.000', 0);
    cdsAux.Filter := 'MARDES = ''S''';
    cdsAux.Filtered := True;
    cdsAux.First;
    While Not cdsAux.Eof Do
    Begin
      fltTotQtd := fltTotQtd + cdsAux.FieldByName('QTDITE').AsFloat;
      fltTotPes := fltTotPes + (cdsAux.FieldByName('PESOIT').AsFloat * cdsAux.FieldByName('QTDITE').AsFloat);
      cdsAux.Next;
    End;
  Finally
    lblTotPes.Caption := FormatFloat('#,##0.0000', fltTotQtd);
    lblTotPesoBruto.Caption := FormatFloat('#,##0.0000', fltTotPes);
    FreeAndNil(cdsAux);
  End;
End;

procedure TfrmSpoolTransferenciaEdicao.rdgAgruparClick(Sender: TObject);
begin
  inherited;

  Case rdgAgrupar.ItemIndex Of
    0: pAgrupaPorEmpresaDestino;
    1: pAgrupaPorProduto;
    2: pAgrupaPorEmpresaOrigem;
  End;
end;

procedure TfrmSpoolTransferenciaEdicao.pAgrupaPorEmpresaDestino;
Begin
  cxvItensEMPDES.GroupIndex := 0;
  cxvItensFORFIL.GroupIndex := -1;
  cxvItensCODITE.GroupIndex := -1;

  cxvItens.ViewData.Expand(False);
End;

procedure TfrmSpoolTransferenciaEdicao.pAgrupaPorProduto;
Begin
  cxvItensEMPDES.GroupIndex := -1;
  cxvItensFORFIL.GroupIndex := -1;
  cxvItensCODITE.GroupIndex := 0;

  cxvItens.ViewData.Expand(False);
End;

procedure TfrmSpoolTransferenciaEdicao.pAgrupaPorEmpresaOrigem;
Begin
  cxvItensFORFIL.GroupIndex := 0;
  cxvItensEMPDES.GroupIndex := -1;
  cxvItensCODITE.GroupIndex := -1;

  cxvItens.ViewData.Expand(False);
End;

end.
