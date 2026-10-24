unit untFatRomSelDoctoManutencaoEndereco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxProgressBar, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, UniClientDataSet;

type
  TfrmFatRomSelDoctoManutencaoEndereco = class(TfrmPaiConfirma)
    cxgDocumentos: TcxGridCitel;
    cxgDocumentosDBTableViewCitel: TcxGridDBTableViewCitel;
    GER_NUMDOC: TcxGridDBColumn;
    GER_CODEMP: TcxGridDBColumn;
    GER_NOMCLI: TcxGridDBColumn;
    GER_NOMCID: TcxGridDBColumn;
    GER_ESTADO: TcxGridDBColumn;
    GER_BAIRRO: TcxGridDBColumn;
    GER_ENDCON: TcxGridDBColumn;
    GER_CEPCON: TcxGridDBColumn;
    GER_TRANSP: TcxGridDBColumn;
    cxgDocumentosLevel: TcxGridLevel;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    GER_ALTEND: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure cxgDocumentosDBTableViewCitelDblClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure cxgDocumentosDBTableViewCitelCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgDocumentosDBTableViewCitelKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure cxgDocumentosDBTableViewCitelKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    cdsDocs: TUniClientDataSet;
    dtsDocs: TDataSource;
    intRecNo: Integer;

    function fDesmarcaTodos(pgbStatus: TcxProgressBar): Boolean;
    function fMarcaTodos(pgbStatus: TcxProgressBar): Boolean;
    procedure pSelecionaDocumento(strAltDoc: String = '');
    function fIntRecNo: Integer;
    procedure pDesmarcaAlteracoes;
  public
    { Public declarations }
    cdsTmpDoc: TUniClientDataSet;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando;

procedure TfrmFatRomSelDoctoManutencaoEndereco.FormShow(Sender: TObject);
begin
  inherited;
  cdsDocs := fCriaClientDatset(cdsTmpDoc);
  dtsDocs := fCriaDataSource(cdsDocs);

  cxgDocumentosDBTableViewCitel.DataController.DataSource := dtsDocs;
  cxgDocumentosDBTableViewCitel.ApplyBestFit();

  pDesmarcaAlteracoes;
end;

procedure TfrmFatRomSelDoctoManutencaoEndereco.pDesmarcaAlteracoes;
var
  strFiltro: String;
begin
  strFiltro := cdsTmpDoc.Filter;

  cdsTmpDoc.Filtered := False;
  cdsTmpDoc.Filter := strFiltro + ' AND GER_ALTEND = '+QuotedStr('S');
  cdsTmpDoc.Filtered := True;

  while not cdsTmpDoc.IsEmpty do
  begin
    cdsTmpDoc.Edit;
    cdsTmpDoc.FieldByName('GER_ALTEND').AsString := 'N';
    cdsTmpDoc.Post;

    cdsTmpDoc.Next;
  end;

  cdsTmpDoc.Filtered := False;
  cdsTmpDoc.Filter := strFiltro;
  cdsTmpDoc.Filtered := True;
end;

procedure TfrmFatRomSelDoctoManutencaoEndereco.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsDocs);
  FreeAndNil(cdsDocs);
end;

procedure TfrmFatRomSelDoctoManutencaoEndereco.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F3: if Shift = [ssCtrl] then
             btnMarcaTodos.Click;

    VK_F4: if Shift = [ssCtrl] then
             btnDesmarcaTodos.Click;
  end;
end;

procedure TfrmFatRomSelDoctoManutencaoEndereco.btnConfirmaClick(
  Sender: TObject);
begin
  inherited;
  cdsDocs.DisableControls;

  cdsDocs.Filtered := False;
  cdsDocs.Filter := ' GER_ALTEND = '+QuotedStr('S');
  cdsDocs.Filtered := True;

  if cdsDocs.IsEmpty then
    ModalResult := mrCancel
  else
  begin
    cdsDocs.First;
    while not cdsDocs.Eof do
    begin

      if cdsTmpDoc.Locate('GER_CODCLI;GER_NUMDOC;GER_ESPDOC;GER_CODEMP;GER_ENTSAI',
                          VarArrayOf([
                          cdsDocs.FieldByName('GER_CODCLI').AsString,
                          cdsDocs.FieldByName('GER_NUMDOC').AsString,
                          cdsDocs.FieldByName('GER_ESPDOC').AsString,
                          cdsDocs.FieldByName('GER_CODEMP').AsString,
                          cdsDocs.FieldByName('GER_ENTSAI').AsString]),
                          []) then
      begin
        cdsTmpDoc.Edit;
        cdsTmpDoc.FieldByName('GER_ALTEND').AsString := cdsDocs.FieldByName('GER_ALTEND').AsString;
        cdsTmpDoc.Post;
      end;

      cdsDocs.Next;
    end;
  end;

end;

procedure TfrmFatRomSelDoctoManutencaoEndereco.btnDesmarcaTodosClick(
  Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fDesmarcaTodos, 'Desmarcando documentos...');
end;

function TfrmFatRomSelDoctoManutencaoEndereco.fDesmarcaTodos(pgbStatus: TcxProgressBar): Boolean;
begin
  if Assigned(cdsDocs) then
  begin
    cdsDocs.DisableControls;
    cdsDocs.First;
    While Not cdsDocs.Eof Do
    begin
      if cdsDocs.FieldByName('GER_ALTEND').AsString = 'S' then
        pSelecionaDocumento;

      cdsDocs.Next;
      pProgresso(cdsDocs.RecNo, cdsDocs.RecordCount, pgbStatus);
    end;
    cdsDocs.EnableControls;
  end;
  Result := True;
end;

procedure TfrmFatRomSelDoctoManutencaoEndereco.btnMarcaTodosClick(
  Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fMarcaTodos, 'Marcando documentos...');
end;

function TfrmFatRomSelDoctoManutencaoEndereco.fMarcaTodos(pgbStatus: TcxProgressBar): Boolean;
begin
  if Assigned(cdsDocs) then
  begin
    cdsDocs.DisableControls;
    cdsDocs.First;
    While Not cdsDocs.Eof Do
    begin
      if cdsDocs.FieldByName('GER_ALTEND').AsString = 'N' then
        pSelecionaDocumento;

      cdsDocs.Next;
      pProgresso(cdsDocs.RecNo, cdsDocs.RecordCount, pgbStatus);
    end;
    cdsDocs.EnableControls;
  end;
  Result := True;
end;

procedure TfrmFatRomSelDoctoManutencaoEndereco.cxgDocumentosDBTableViewCitelCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if not Assigned(cdsDocs) then
    Exit;

  if not cdsDocs.Active then
    Exit;

  inherited;

  if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, GER_ALTEND.Index]) = 'S' then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clLime
    else
    begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.Font.Color := clBlue;
    end;
  end;
end;

procedure TfrmFatRomSelDoctoManutencaoEndereco.cxgDocumentosDBTableViewCitelDblClick(
  Sender: TObject);
begin
  inherited;
  pSelecionaDocumento;
end;

function TfrmFatRomSelDoctoManutencaoEndereco.fIntRecNo: Integer;
begin
  Result := intRecNo;
  if Result = 0 then
     Result := cdsDocs.RecNo;
end;

procedure TfrmFatRomSelDoctoManutencaoEndereco.cxgDocumentosDBTableViewCitelKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN,
    VK_SPACE: pSelecionaDocumento;

    VK_F10: btnConfirma.Click;

    VK_ESCAPE: btnSair.Click;

    VK_UP: if Shift = [ssShift] then
           begin
             intRecNo := fIntRecNo;

             if intRecNo >= cdsDocs.RecNo then
             begin
               pSelecionaDocumento('S');
               cdsDocs.Prior;
               pSelecionaDocumento('S');
               cdsDocs.Next;
             end
             else
               pSelecionaDocumento('N');
           end;

    VK_DOWN: if Shift = [ssShift] then
             begin
               intRecNo := fIntRecNo;

               if intRecNo <= cdsDocs.RecNo then
               begin
                 pSelecionaDocumento('S');
                 cdsDocs.Next;
                 pSelecionaDocumento('S');
                 cdsDocs.Prior;
               end
               else
                 pSelecionaDocumento('N');
             end;
  end;
end;

procedure TfrmFatRomSelDoctoManutencaoEndereco.cxgDocumentosDBTableViewCitelKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Shift = [] then
    intRecNo := 0;
end;

procedure TfrmFatRomSelDoctoManutencaoEndereco.pSelecionaDocumento(strAltDoc: String = '');
begin
  if not Assigned(cdsDocs) then
    Exit;

  if not cdsDocs.Active then
    Exit;

  if cdsDocs.IsEmpty then
    Exit;

  cdsDocs.Edit;
  if fEmptyStr(strAltDoc) then
    cdsDocs.FieldByName('GER_ALTEND').AsString := IIF(cdsDocs.FieldByName('GER_ALTEND').AsString = 'N', 'S', 'N')
  else
    cdsDocs.FieldByName('GER_ALTEND').AsString := strAltDoc;

  cdsDocs.Post;
end;

end.

