unit untCadSitProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxColorComboBox,untZClient, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBColorComboBox, Mask, DBCtrls,
  DBEditFocus, Uni, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadSitProduto = class(TfrmPaiConfirma)
    pnlCampos: TPanel;
    cxgSitProView: TcxGridDBTableView;
    cxgSitProLevel1: TcxGridLevel;
    cxgSitPro: TcxGrid;
    cxgSitProViewColumn1: TcxGridDBColumn;
    cxgSitProViewColumn2: TcxGridDBColumn;
    cxgSitProViewColumn3: TcxGridDBColumn;
    dbeCodSit: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbnNavigator: TDBNavigator;
    dbeDescri: TDBEditFocus;
    shpSitCor: TShape;
    btnEscolheCores: TBitBtnLocked;
    ColorDialog: TColorDialog;
    chkPASCMP: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnEscolheCoresClick(Sender: TObject);
    procedure cxgSitProViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure dbnNavigatorClick(Sender: TObject; Button: TNavigateBtn);
  private
    { Private declarations }
    cdsSitPro: TZClient;

    Function fTemProduto(strCodSit: String): Boolean;

    Procedure pBeforDelete(dataSet: TdataSet);
    Procedure pAfterInsert(dataSet: TdataSet);
    procedure pcdsSitProDataChange(Sender: TObject; Field: TField);
    procedure pcdsSitProStateChange(Sender: TObject);
    procedure pBeforePost(DataSet: TdataSet);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadSitProduto.btnEscolheCoresClick(Sender: TObject);
begin
  inherited;
  If not (cdsSitPro.State in DsEditModes) Then
    Exit;

  If ColorDialog.Execute Then
    cdsSitPro.FieldByName('SIT_CORSIT').AsInteger := ColorDialog.Color;
end;

procedure TfrmCadSitProduto.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  With cdsSitPro Do
  Begin
    If (State = dsInsert) And
       fEmptyStr(FieldByName('SIT_DESCRI').AsString) Then
      Cancel;
  End;

  cdsSitPro.fSalva;
end;

procedure TfrmCadSitProduto.btnSairClick(Sender: TObject);
begin
  inherited;

  cdsSitPro.pCancela;
end;

procedure TfrmCadSitProduto.cxgSitProViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.Item.Index = cxgSitProViewColumn3.Index Then
  Begin
    ACanvas.Brush.Color := StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgSitProViewColumn3.Index]),0);
    ACanvas.Font.Color  := StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgSitProViewColumn3.Index]),0);
  End;
end;

procedure TfrmCadSitProduto.dbnNavigatorClick(Sender: TObject; Button: TNavigateBtn);
begin
  inherited;
  If Button =  nbInsert Then
    chkPASCMP.Checked := True;
end;

procedure TfrmCadSitProduto.FormCreate(Sender: TObject);
begin
  inherited;

  cdsSitPro := TZClient.Create(Self, 'SELECT * FROM SITPRO');

  If Not cdsSitPro.fAbreClient Then
    pMensagensErro(cdsSitPro.strMsgErr, '[frmCadSitProduto.FormCreate]');

  cdsSitPro.pSalvaPorRegistro('SITPRO', 'SIT_CODIGO');
  cdsSitPro.BeforeDelete    := pBeforDelete;
  cdsSitPro.AfterInsert     := pAfterInsert;
  cdsSitPro.BeforePost      := pBeforePost;
  cdsSitPro.fVerificaCampos := fVerificaCampos;

  cxgSitProView.DataController.DataSource := cdsSitPro.dtsSource;

  dbeCodSit.DataSource := cdsSitPro.dtsSource;
  dbeDescri.DataSource := cdsSitPro.dtsSource;

  chkPASCMP.DataSource := cdsSitPro.dtsSource;


  dbnNavigator.DataSource := cdsSitPro.dtsSource;

  cdsSitPro.dtsSource.OnDataChange := pcdsSitProDataChange;
  cdsSitPro.dtsSource.OnStateChange:= pcdsSitProStateChange;

  if cdsSitPro.RecordCount > 0 Then
    shpSitCor.Brush.Color := cdsSitPro.FieldByName('SIT_CORSIT').AsInteger;
end;

procedure TfrmCadSitProduto.pcdsSitProStateChange(Sender : TObject);
Begin
  btnEscolheCores.Enabled := (cdsSitPro.State in DsEditModes);

End;

procedure TfrmCadSitProduto.pcdsSitProDataChange(Sender : TObject; Field : TField);
Begin
  shpSitCor.Brush.Color := cdsSitPro.FieldByName('SIT_CORSIT').AsInteger;
End;

Function TfrmCadSitProduto.fTemProduto(strCodSit: String): Boolean;
  Var
    qryCadIte: TUniQuery;
Begin
  qryCadIte := fCriaQuery(Self);
  With qryCadIte, SQL Do
  Begin
    Clear;
    Add('SELECT COUNT(*) AS QTD FROM ITEGER');
    Add('WHERE ITE_SITPRO = :SITPRO');

    ParamByName('SITPRO').AsString := strCodSit;

    Open;
    Result := FieldByName('QTD').AsInteger > 0;

    Close;
  End;

  FreeAndNil(qryCadIte);
End;

Procedure TfrmCadSitProduto.pBeforDelete(dataSet: TdataSet);
Begin
  If fTemProduto(DataSet.FieldByName('SIT_CODIGO').AsString) Then
  Begin
    pMensagemOk('Há produtos cadastrados com essa situação!');
    Abort;
    Exit;
  End;

  If Not fPergunta('Confirma a exclusão do registro da Situação?') Then
    Abort;
End;

function TfrmCadSitProduto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeDescri) Then
  Begin
    If fEmptyStr(dbeDescri.Text) Then
    Begin
      fMensagem('', 'Informe a descrição da situação!', ['&Ok']);
      Result := False;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

Procedure TfrmCadSitProduto.pAfterInsert(DataSet: TdataSet);
Begin
  pSetFocus(dbeDescri);
  DataSet.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SITPRO', VS_strCodEmp);
  DataSet.FieldByName('SIT_CODIGO').AsString := fAtualizaProCod('SITPRO', 'SIT_CODIGO');
End;

Procedure TfrmCadSitProduto.pBeforePost(DataSet: TdataSet);
Begin
  If cdsSitPro.FieldByName('SIT_CORSIT').IsNull Then
  Begin
    fMensagem('', 'Informe a cor da situação!', ['&Ok']);
    btnEscolheCoresClick(Nil);
    If cdsSitPro.FieldByName('SIT_CORSIT').IsNull Then
      Abort;
  End;

  If cdsSitPro.FieldByName('SIT_DESCRI').IsNull Then
  Begin
    fMensagem('', 'Informe a descrição da situação!', ['&Ok']);
    pSetFocus(dbeDescri);
    If cdsSitPro.FieldByName('SIT_DESCRI').IsNull Then
      Abort;
  End;

End;

end.

