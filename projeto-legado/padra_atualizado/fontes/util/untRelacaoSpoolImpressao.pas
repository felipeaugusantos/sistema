unit untRelacaoSpoolImpressao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, UniClientDataSet,
  Uni, UniDataSetProvider, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, DBAccess, MemDS,
  cxImageComboBox, System.ImageList, Vcl.ImgList, cxImageList,
  dxLayoutContainer, cxGridViewLayoutContainer, cxGridLayoutView,
  cxGridDBLayoutView, cxGridCustomLayoutView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGridCitel, cxContainer, cxTextEdit, cxMaskEdit,
  cxSpinEdit, cxCustomListBox, cxCheckListBox;

type
  TfrmRelacaoSpoolImpressao = class(TfrmPai)
    cxgSpoImpView: TcxGridDBTableView;
    cxgSpoImpLevel: TcxGridLevel;
    cxgSpoImp: TcxGrid;
    btnRemover: TBitBtnLocked;
    btnRefresh: TBitBtnLocked;
    qrySpoImp: TUniQuery;
    dtsSpoImp: TDataSource;
    cxgSpoImpViewStatus: TcxGridDBColumn;
    cxgSpoImpViewEmp: TcxGridDBColumn;
    cxgSpoImpViewOpe: TcxGridDBColumn;
    cxgSpoImpViewDescricao: TcxGridDBColumn;
    cxgSpoImpViewEnviado: TcxGridDBColumn;
    cxgSpoImpViewImpresso: TcxGridDBColumn;
    cxgSpoImpViewPontoimpressao: TcxGridDBColumn;
    cxgSpoImpViewImpressora: TcxGridDBColumn;
    cxgSpoImpViewConteudo: TcxGridDBColumn;
    cxgSpoImpViewAUTOINCREM: TcxGridDBColumn;
    imgIcones: TcxImageList;
    qrySpoImpStatus: TStringField;
    qrySpoImpEmp: TStringField;
    qrySpoImpOpe: TStringField;
    qrySpoImpDescrição: TStringField;
    qrySpoImpEnviado: TDateTimeField;
    qrySpoImpImpresso: TDateTimeField;
    qrySpoImpPontoimpressão: TStringField;
    qrySpoImpImpressora: TStringField;
    qrySpoImpAUTOINCREM: TStringField;
    Panel1: TPanel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    RadioGroup1: TGroupBox;
    Label1: TLabel;
    edtDias: TcxSpinEdit;
    chkRefresh: TCheckBox;
    tmrRefresh: TTimer;
    qrySpoImpArquivo: TStringField;
    qrySpoImpTamanho: TStringField;
    cxgSpoImpViewTamanho: TcxGridDBColumn;
    cklStatus: TcxCheckListBox;
    procedure cxgSpoImpViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrRefreshTimer(Sender: TObject);
    procedure cxSpinEdit1PropertiesChange(Sender: TObject);
    procedure qrySpoImpAfterScroll(DataSet: TDataSet);
    procedure cklStatusClickCheck(Sender: TObject; AIndex: Integer; APrevState,
      ANewState: TcxCheckBoxState);
  private
    { Private declarations }
    function fCarregaSpoolImpressao: Boolean;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untModulo, untGravando;

{$R *.dfm}

procedure TfrmRelacaoSpoolImpressao.FormShow(Sender: TObject);
begin
  inherited;
  fCarregaSpoolImpressao;
  pSetFocus(cxgSpoImp);
end;

procedure TfrmRelacaoSpoolImpressao.qrySpoImpAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnRemover.Visible := qrySpoImp.FieldByName('Status').AsString.Equals('Falha de impressão');
end;

procedure TfrmRelacaoSpoolImpressao.btnRemoverClick(Sender: TObject);
begin
  inherited;
  tmrRefresh.Enabled := False;
  Try
    If Not btnRemover.Visible Then
      Exit;
    If Not qrySpoImp.FieldByName('Status').AsString.Equals('Falha de impressão') Then
      Exit;
    If qrySpoImp.RecordCount <= 0 Then
    Begin
      pMensagemOk('Nenhum registro para remover!');
      Exit;
    End;
    If fMensagem('','Deseja realmente remover este documento?', ['','']) = 1 Then
    Begin
      fExecutaSQL('DELETE FROM SPOIMP WHERE AUTOINCREM = "' + qrySpoImp.FieldByName('AUTOINCREM').AsString + '"', True);
      fExecutaSQL('DELETE FROM SPOARQ WHERE SPO_NOMARQ = "' + qrySpoImp.FieldByName('Arquivo').AsString + '"', True);
      cxgSpoImpView.DataController.RefreshExternalData;
    End;
  Finally
    tmrRefresh.Enabled := True;
  End;
end;

procedure TfrmRelacaoSpoolImpressao.btnRefreshClick(Sender: TObject);
begin
  inherited;
  cxgSpoImpView.DataController.RefreshExternalData;
end;

procedure TfrmRelacaoSpoolImpressao.cklStatusClickCheck(Sender: TObject;
  AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
begin
  inherited;
  tmrRefresh.Enabled := False;
  try
    fCarregaSpoolImpressao;
  finally
    tmrRefresh.Enabled := True;
  end;
end;

procedure TfrmRelacaoSpoolImpressao.cxgSpoImpViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Escape:
      btnSair.Click;
    VK_DELETE:
      If btnRemover.Visible Then
        btnRemover.Click;
    VK_F5:
      btnRefresh.Click;
  End;
end;

procedure TfrmRelacaoSpoolImpressao.cxSpinEdit1PropertiesChange(
  Sender: TObject);
begin
  inherited;
  tmrRefresh.Enabled := False;
  try
    fCarregaSpoolImpressao;
  finally
    tmrRefresh.Enabled := True;
  end;
end;

procedure TfrmRelacaoSpoolImpressao.tmrRefreshTimer(Sender: TObject);
begin
  inherited;
  tmrRefresh.Enabled := False;
  If chkRefresh.Checked then
    cxgSpoImpView.DataController.RefreshExternalData;
  tmrRefresh.Enabled := True;
end;

function TfrmRelacaoSpoolImpressao.fCarregaSpoolImpressao: Boolean;
begin
  qrySpoImp.Connection := frmModulo.GetCurrentConnection;

  qrySpoImp.Close;
  qrySpoImp.SQL.Clear;

  qrySpoImp.SQL.Add(' SELECT SQL_NO_CACHE ');
  qrySpoImp.SQL.Add('   IF( ');
  qrySpoImp.SQL.Add('     A.SPO_DTAIMP IS NOT NULL, ');
  qrySpoImp.SQL.Add('     "Impressão concluída", ');
  qrySpoImp.SQL.Add('     IF( ');
  qrySpoImp.SQL.Add('       TIMEDIFF(CURRENT_TIMESTAMP, A.SPO_DTAINC) <= "00:00:30", ');
  qrySpoImp.SQL.Add('       "Aguardando impressão", ');
  qrySpoImp.SQL.Add('       "Falha de impressão" ');
  qrySpoImp.SQL.Add('     ) ');
  qrySpoImp.SQL.Add('   ) AS "Status", ');
  qrySpoImp.SQL.Add('   A.SPO_CODEMP AS "Emp.", ');
  qrySpoImp.SQL.Add('   A.SPO_CODOPE AS "Ope.", ');
  qrySpoImp.SQL.Add('   A.SPO_DESPRO AS "Descrição", ');
  qrySpoImp.SQL.Add('   A.SPO_DTAINC AS "Enviado", ');
  qrySpoImp.SQL.Add('   A.SPO_DTAIMP AS "Impresso", ');
  qrySpoImp.SQL.Add('   A.SPO_PONIMP AS "Ponto impressão", ');
  qrySpoImp.SQL.Add('   A.SPO_NOMIMP AS "Impressora", ');
  qrySpoImp.SQL.Add('   B.SPO_NOMARQ AS "Arquivo", ');
  qrySpoImp.SQL.Add('   CONCAT( ');
  qrySpoImp.SQL.Add('     ROUND(LENGTH(B.SPO_ARQB64) / 1000 / 1000, 2), ');
  qrySpoImp.SQL.Add('     " MB" ');
  qrySpoImp.SQL.Add('   ) AS "Tamanho", ');
  qrySpoImp.SQL.Add('   A.AUTOINCREM ');
  qrySpoImp.SQL.Add(' FROM ');
  qrySpoImp.SQL.Add('   SPOIMP A ');
  qrySpoImp.SQL.Add('   LEFT JOIN SPOARQ B ');
  qrySpoImp.SQL.Add('     ON B.SPO_NOMARQ = A.SPO_ARQIMP ');
  qrySpoImp.SQL.Add(' WHERE TRUE ');
  qrySpoImp.SQL.Add('   AND A.SPO_DTAINC >= ' + fCurrentDate(VS_Date - edtDias.Value));
  qrySpoImp.SQL.Add(' HAVING `Status` IN (""');

  If cklStatus.Items[0].Checked Then
    qrySpoImp.SQL.Add('   , "Aguardando impressão" ');

  If cklStatus.Items[1].Checked Then
    qrySpoImp.SQL.Add('   , "Impressão concluída" ');

  If cklStatus.Items[2].Checked Then
    qrySpoImp.SQL.Add('   , "Falha de impressão" ');

  qrySpoImp.SQL.Add(' )');

  qrySpoImp.SQL.Add(' ORDER BY A.AUTOINCREM DESC; ');

  qrySpoImp.Open;

  Result := Not qrySpoImp.IsEmpty;
end;

end.
