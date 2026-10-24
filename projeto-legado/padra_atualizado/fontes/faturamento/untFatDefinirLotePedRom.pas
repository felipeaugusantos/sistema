unit untFatDefinirLotePedRom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Datasnap.DBClient, UniClientDataSet,
  untDefineLotesWMS, MemDS, DBAccess, Uni, Datasnap.Provider, UniDataSetProvider;

type
  TfrmDefinirLotePedRom = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Label1: TLabel;
    grdProdutoTv: TcxGridDBTableViewCitel;
    grdProdutoLv: TcxGridLevel;
    grdProduto: TcxGridCitel;
    dbgLotes: TDBGridCitel;
    grdProdutoCODITE: TcxGridDBColumn;
    grdProdutoDESITE: TcxGridDBColumn;
    grdProdutoDOCS: TcxGridDBColumn;
    grdProdutoQTDITE: TcxGridDBColumn;
    cdsDefineLote: TUniClientDataSet;
    cdsDefineLoteCODITE: TStringField;
    cdsDefineLoteDESITE: TStringField;
    cdsDefineLoteQTDITE: TFloatField;
    cdsDefineLoteNUMDOC: TStringField;
    cdsDefineLoteNUMLOT: TStringField;
    cdsDefineLoteCODSEP: TStringField;
    cdsDefineLoteSEQSEP: TIntegerField;
    dtsDefineLote: TDataSource;
    cdsConsulta: TUniClientDataSet;
    dspConsulta: TUniDataSetProvider;
    qryConsulta: TUniQuery;
    grdProdutoNUMLOT: TcxGridDBColumn;
    btnAtualiza: TBitBtnLocked;
    btnCadLot: TBitBtnLocked;
    Panel2: TPanel;
    Label2: TLabel;
    cdsLotesSel: TUniClientDataSet;
    cdsLotesSelCODITE: TStringField;
    cdsLotesSelNUMLOT: TStringField;
    cdsLotesSelQTDLOT: TFloatField;
    cdsDefineLoteAUTINC: TStringField;
    cdsLotesSelAUTINC: TStringField;
    grdProdutoAUTINC: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure cdsDefineLoteAfterScroll(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure dbgLotesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAtualizaClick(Sender: TObject);
    procedure grdProdutoNUMLOTGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure FormCreate(Sender: TObject);
    procedure grdProdutoTvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCadLotClick(Sender: TObject);
  private
    { Private declarations }
    FobjDefineLotes: TDefineLotesWMS;

    FcdsLotSel : TUniClientDataSet;
    FdtsLotSel : TDataSource;

    blnUsaWMSRastreavelTinta: Boolean;

    procedure pAtualizaGridLotes;
    procedure pInformaLotesProduto;

    function fValidaLotesPreenchidos: Boolean;
    function fValidaLotesQuantidades: Boolean;
    procedure pAtualizaLotes;
  public
    FCodLot: String;
    FCodEmp: String;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untCadLoteItens;

procedure TfrmDefinirLotePedRom.btnAtualizaClick(Sender: TObject);
begin
  inherited;
  pAtualizaLotes;
  pAtualizaGridLotes;
end;

procedure TfrmDefinirLotePedRom.btnCadLotClick(Sender: TObject);
begin
  inherited;
  If fUsaRotinaWMS And Not fVerificaAcessoSistema('frmCadLoteItens') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso ao cadastro de Lotes!', ['&O k']);
    Exit;
  End;

  pCriarForm(TfrmCadLoteItens);
end;

procedure TfrmDefinirLotePedRom.btnConfirmaClick(Sender: TObject);
begin
  if not fValidaLotesPreenchidos then
    Exit;

  if not fValidaLotesQuantidades then
    Exit;

  ModalResult := MrOk;
end;

procedure TfrmDefinirLotePedRom.cdsDefineLoteAfterScroll(DataSet: TDataSet);
begin
  inherited;
  pAtualizaGridLotes;
end;

procedure TfrmDefinirLotePedRom.dbgLotesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  intRecNo: Integer;
begin
  inherited;
  if (not FcdsLotSel.Active) or FcdsLotSel.IsEmpty then
    Exit;

  if Key = VK_RETURN then
  begin
    intRecNo := cdsDefineLote.RecNo;
    cdsDefineLote.DisableControls;
    try
      cdsDefineLote.Filtered := False;
      cdsDefineLote.Filter := 'CODITE = ' + QuotedStr(cdsDefineLoteCODITE.AsString);
      cdsDefineLote.Filtered := True;

      if cdsDefineLote.RecordCount > 0 then
      begin
        pMensagemOk('Não foi possível definir o lote, pois existem ' + IntToStr(cdsDefineLote.RecordCount) + ' registros sem lotes para este produto!' + sLineBreak +
                    'Informe o lote utilizando o grid superior!');
        Exit;
      end;

    finally
      cdsDefineLote.Filtered := False;
      cdsDefineLote.RecNo := intRecNo;
      cdsDefineLote.EnableControls;
    end;

    if cdsLotesSel.Locate(
        'CODITE;NUMLOT',
        VarArrayOf([cdsDefineLoteCODITE.AsString, FcdsLotSel.FieldByName('NUMLOT').AsString]), []) then
      cdsLotesSel.Delete
    else
    begin
      cdsLotesSel.Append;
      cdsLotesSelCODITE.AsString := cdsDefineLoteCODITE.AsString;
      cdsLotesSelNUMLOT.AsString := FcdsLotSel.FieldByName('NUMLOT').AsString;
      cdsLotesSelQTDLOT.AsFloat  := FcdsLotSel.FieldByName('QTDITE').AsFloat;
      cdsLotesSelAUTINC.AsString := FcdsLotSel.FieldByName('AUTINC').AsString;

      cdsLotesSel.Post;
    end;

    grdProdutoTv.Controller.FocusedRecord.Invalidate;
  end;
end;

procedure TfrmDefinirLotePedRom.FormCreate(Sender: TObject);
begin
  inherited;
  cdsLotesSel.CreateDataSet;
  FdtsLotSel := TDataSource.Create(Self);
end;

procedure TfrmDefinirLotePedRom.FormDestroy(Sender: TObject);
begin
  if Assigned(FdtsLotSel) Then
    FreeAndNil(FdtsLotSel);

  if Assigned(FcdsLotSel) Then
    FreeAndNil(FcdsLotSel);

  if Assigned(FobjDefineLotes) Then
    FreeAndNil(FobjDefineLotes);

  inherited;

end;

procedure TfrmDefinirLotePedRom.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F10 then
    btnConfirma.Click
  else
  if Key = VK_F5 then
    btnAtualiza.Click
  else
  if Key = VK_F8 then
    btnCadLot.Click;
end;

procedure TfrmDefinirLotePedRom.FormShow(Sender: TObject);
begin
  inherited;

  WindowState := wsMaximized;

  cdsDefineLote.DisableControls;
  try
    cdsDefineLote.First;
    while not cdsDefineLote.Eof do
    begin
      if not fEmptyStr(cdsDefineLoteNUMLOT.AsString) then
        cdsDefineLote.Delete
      else
        cdsDefineLote.Next;
    end;
  finally
    cdsDefineLote.EnableControls;
  end;

  blnUsaWMSRastreavelTinta := fUsaRotinaWMS And
                              (fCfgSis('TMWMSR', varBoolean)) And
                              (fCfgSis('EXIDOC') = 'PD');

  FobjDefineLotes := TDefineLotesWMS.CreateInstance(Self, FCodLot, FCodEmp, blnUsaWMSRastreavelTinta);

  pAtualizaLotes;

  cdsDefineLote.AfterScroll := cdsDefineLoteAfterScroll;
  cdsDefineLote.First;
end;

procedure TfrmDefinirLotePedRom.pAtualizaLotes;
Var
  intIndex: Integer;
begin
  qryConsulta.Close;
  cdsConsulta.Close;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add(FobjDefineLotes.fGetSqlItensPedido);
  qryConsulta.Open;

  If Assigned(dspConsulta.DataSet) Then
    pSetaClient(dspConsulta.DataSet);

  cdsConsulta.Open;

  For intIndex := 0 To cdsConsulta.FieldDefs.Count - 1 Do
    cdsConsulta.FieldDefs[intIndex].Required := FALSE;

  FobjDefineLotes.pAtualizaLotes(cdsConsulta, True);
end;

function TfrmDefinirLotePedRom.fValidaLotesPreenchidos: Boolean;
var
  LRecNo: Integer;
begin
  Result := True;

  LRecNo := cdsDefineLote.RecNo;
  cdsDefineLote.DisableControls;
  try
    cdsDefineLote.First;
    while not cdsDefineLote.Eof do
    begin
      if not cdsLotesSel.Locate('AUTINC', cdsDefineLoteAUTINC.AsString, []) then
      begin
        fMensagem('', 'Existem produtos sem lote definido!', ['&OK']);
        Result := False;
        Exit;
      end;

      cdsDefineLote.Next;
    end;
  finally
    cdsDefineLote.RecNo := LRecNo;
    cdsDefineLote.EnableControls;
  end;
end;

function TfrmDefinirLotePedRom.fValidaLotesQuantidades: Boolean;
var
  LRecNo: Integer;
  LfltQtd: Double;
begin
  Result := True;

  LRecNo := cdsDefineLote.RecNo;
  cdsDefineLote.DisableControls;
  try
    cdsDefineLote.First;
    while not cdsDefineLote.Eof do
    begin
      LfltQtd := 0;

      cdsLotesSel.Filter := 'AUTINC = ' + QuotedStr(cdsDefineLoteAUTINC.AsString);
      cdsLotesSel.Filtered := True;
      try
        cdsLotesSel.First;
        while not cdsLotesSel.Eof do
        begin
          LfltQtd := LfltQtd + cdsLotesSel.FieldByName('QTDLOT').AsFloat;
          cdsLotesSel.Next;
        end;
      finally
        cdsLotesSel.Filtered := False;
      end;

      if LfltQtd < cdsDefineLoteQTDITE.AsFloat then
      begin
        fMensagem('', 'A quantidade do(s) lote(s) selecionado(s) do item ' + cdsDefineLoteCODITE.AsString + ' é insuficiente!', ['&OK']);
        Result := False;
        Exit;
      end;

      cdsDefineLote.Next;
    end;
  finally
    cdsDefineLote.RecNo := LRecNo;
    cdsDefineLote.EnableControls;
  end;
end;

procedure TfrmDefinirLotePedRom.grdProdutoNUMLOTGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var
  LstrAUTINC: String;
  LstrRetorno: String;
begin
  inherited;
  LstrRetorno := '';
  LstrAUTINC := VarToStr(grdProdutoTv.DataController.Values[ARecord.RecordIndex, grdProdutoAUTINC.Index]);

  cdsLotesSel.Filter := 'AUTINC = ' + QuotedStr(LstrAUTINC);
  cdsLotesSel.Filtered := True;
  try
    cdsLotesSel.First;
    while not cdsLotesSel.Eof do
    begin
      LstrRetorno := LstrRetorno + cdsLotesSelNUMLOT.AsString + ', ';
      cdsLotesSel.Next;
    end;
  finally
    cdsLotesSel.Filtered := False;
  end;

  Delete(LstrRetorno, Length(LstrRetorno)- 1, 1);
  AText := LstrRetorno;
end;

procedure TfrmDefinirLotePedRom.grdProdutoTvKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (not cdsDefineLote.Active) or cdsDefineLote.IsEmpty Then
    Exit;

  If (Key = VK_RETURN) Then
    pInformaLotesProduto;
end;

procedure TfrmDefinirLotePedRom.pAtualizaGridLotes;
begin
  FobjDefineLotes.pCarregaLotesDigitados(
    cdsDefineLote.FieldByName('CODITE').AsString,
    cdsDefineLote.FieldByName('AUTINC').AsString,
    FcdsLotSel);

  FdtsLotSel.DataSet  := FcdsLotSel;
  dbgLotes.DataSource := FdtsLotSel;

end;

procedure TfrmDefinirLotePedRom.pInformaLotesProduto;
Var
  strNumLot: String;
begin
  inherited;
  If not cdsConsulta.Locate('AUTOINCREM', cdsDefineLoteAUTINC.AsString, []) Then
    Exit;

  If (cdsConsulta.FieldByName('FDO_IDEPRO').AsString <> 'NOR') And
     (Not blnUsaWMSRastreavelTinta) And
     (not fCfgSis('TINWMS',varBoolean)) Then
    Exit;

  If cdsConsulta.FieldByName('FDO_PROACA').AsString = 'S' Then
    Exit;

  If (cdsConsulta.FieldByName('TEMLOT').AsString <> '1') Then
  Begin
    pMensagemOk('Esse item não possui lote cadastrado!');
    Exit;
  End;

  If fCfgSis('WMSLOT', varBoolean) Then
    If (cdsConsulta.FieldByName('ITE_LOTEPD').AsString = 'S') Then
    Begin
      If (fMensagem('ATENÇÃO!', 'Lote já definido no pedido, deseja alterá-lo?', ['',''], 2) = 2) Then
        Exit;
    End;

  If FobjDefineLotes.fDigitaLotes(cdsConsulta.FieldByName('FDO_CODITE').AsString,
                                  cdsConsulta.FieldByName('FDO_DESCRI').AsString,
                                  cdsConsulta.FieldByName('AUTOINCREM').AsString,
                                  cdsConsulta.FieldByName('FDO_QTDITE').AsFloat,
                                  cdsConsulta.FieldByName('FDO_IDEPRO').AsString,
                                  strNumLot) Then
  Begin
    If Not SameText(strNumLot, 'A DEFINIR') Then
    begin
      while cdsLotesSel.Locate('AUTINC;NUMLOT', VarArrayOf([cdsDefineLoteAUTINC.AsString, strNumLot]), []) do
        cdsLotesSel.Delete;

      cdsLotesSel.Append;
      cdsLotesSelCODITE.AsString := cdsDefineLoteCODITE.AsString;
      cdsLotesSelNUMLOT.AsString := strNumLot;
      cdsLotesSelQTDLOT.AsFloat  := cdsDefineLoteQTDITE.AsFloat;
      cdsLotesSelAUTINC.AsString := cdsDefineLoteAUTINC.AsString;

      cdsLotesSel.Post;

      grdProdutoTv.Controller.FocusedRecord.Invalidate;
    end;

  End;

  pAtualizaGridLotes;

end;

end.
