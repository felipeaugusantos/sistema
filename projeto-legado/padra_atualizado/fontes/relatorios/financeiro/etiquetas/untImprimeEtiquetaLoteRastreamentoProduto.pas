unit untImprimeEtiquetaLoteRastreamentoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, untZClient,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, EditFocus, Vcl.Mask, MaskEditFocus, System.AnsiStrings, untTypesSistema,
  TypesRel, cxCurrencyEdit, cxSpinEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmImprimeEtiquetaLoteRastreamentoProduto = class(TfrmPaiSimples)
    pnlContFiltros: TPanel;
    cxDadostv: TcxGridDBTableView;
    cxDadosLvl: TcxGridLevel;
    cxDados: TcxGrid;
    dtsDados: TDataSource;
    pnlBotoesImp: TPanel;
    btnConfirma: TBitBtnLocked;
    btnSairImp: TBitBtnLocked;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl2: TLabel;
    lbl9: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    edtRefere: TEditFocus;
    edtCodFor: TEditFocus;
    edtNumLot: TEditFocus;
    edtNomFor: TEditFocus;
    Panel2: TPanel;
    lblQtdEtq: TLabel;
    edtQtdEtq: TEditFocus;
    edtLinGruFin: TEditFocus;
    mskLinGruFin: TMaskEditFocus;
    btnConfirmaFiltro: TBitBtnLocked;
    btnLimFil: TBitBtnLocked;
    pnlFiltros: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtRefFin: TEditFocus;
    cxDadosNUMLOT: TcxGridDBColumn;
    cxDadosCODITE: TcxGridDBColumn;
    cxDadosDESITE: TcxGridDBColumn;
    cxDadosQTDETI: TcxGridDBColumn;
    btnPesDoc: TBitBtnLocked;
    procedure FormDestroy(Sender: TObject);
    procedure btnLimFilClick(Sender: TObject);
    procedure btnConfirmaFiltroClick(Sender: TObject);

    procedure edtCodMarExit(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruFinExit(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);

    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruFinKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);

    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure btnSairImpClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxDadostvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxDadostvCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnPesDocClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  Protected
    cdsDados: TZClient;
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  private
    arrCodIte,
    arrCodFor,
    arrCodMar: TConsultasArray;
    strCodIte,
    strCodFor,
    strCodMar,
    strSeqLot: string;
    arrSeqLot: TConsultasArray;
    function  fTemQtdEtiMarcada(blnLimparConsulta: boolean = True): Boolean;
    function  fSQLLoteRastreamento(blnVazio :Boolean = False): String;
    procedure pAtribuirParametros;
    procedure pCarregarListaLoteEQuantidades(var ArrLoteProdutoEtiq: TArrLoteProdutoEtiq);
    function fSQLCamposBase: String;
    function fSQLLoteRastreamentoConsulta(blnVazio: Boolean = False): String;
    function fSQLLoteRastreamentoFatGor(blnVazio: Boolean = False): String;
    function fSQLOrder: String;
    { Private declarations }
  public
    strSeqGorEnderecamento : String;

    { Public declarations }
  end;


implementation

uses
 untFuncoesConsulta, untConsultas, untFuncoesSimples,
  untFuncoesRelatorios, untFuncoesEtiquetas, untCfgLocFis;

{$R *.dfm}

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.FormCreate(
  Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  strSeqGorEnderecamento := '';
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsDados);

end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    btnSairImp.Click
  Else If (Key  = VK_F4) and (pnlContFiltros.Visible) Then
    btnLimFil.Click
  Else If (Key = VK_F5) And (pnlContFiltros.Visible) Then
    btnConfirmaFiltro.Click
  Else If Key = VK_F10 Then
    btnConfirma.Click;
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.FormShow(Sender: TObject);
begin
  inherited;
  cdsDados := TZClient.Create(Nil, fSQLLoteRastreamento(True));

  pAtribuirParametros;
  cdsDados.fAbreClient(True, 'FormCreate');
  dtsDados.DataSet := cdsDados;

  if not fEmptyStr(strSeqGorEnderecamento) then
  begin
    pnlContFiltros.Visible := False;
    lblQtdEtq.Visible := False;
    edtQtdEtq.Visible := False;
  end;

  If fEmptyStr(strSeqGorEnderecamento) Then
    pSetFocus(mskLinGru)
  Else
  Begin
    pSetFocus(cxDados);
    btnConfirmaFiltro.Click;
  End
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.btnLimFilClick(Sender: TObject);
begin
  inherited;
  mskLinGru.Clear;
  edtDesGru.Clear;
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
  edtRefere.Clear;
  edtCodFor.Clear;
  edtNumLot.Clear;
  edtNomFor.Clear;
  edtLinGruFin.Clear;
  mskLinGruFin.Clear;

  pDesmarcaLista(edtCodFor, arrCodFor);
  pDesmarcaLista(edtCodMar, arrCodMar);
  pDesmarcaLista(edtCodIte, arrCodIte);
  pDesmarcaLista(edtNumLot, arrSeqLot);
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.btnPesDocClick(
  Sender: TObject);
begin
  If fPesqLoteRastreamento(Self, edtNumLot, Nil, 0, Nil, arrSeqLot, False) Then
    If fValidaCampos(edtNumLot, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.btnSairImpClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.cxDadostvCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Sender.DataController.Values
               [AViewInfo.GridRecord.RecordIndex, cxDadosQTDETI.Index]) > 0 Then
  Begin
    ACanvas.Brush.Color := clHighlight;
    ACanvas.Font.Color  := clLime;
  End

{    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVendaViewITESEL.Index]) = 'S' Then
    Begin
      If AViewInfo.Selected Then
      Begin
        ACanvas.Brush.Color := clHighlight;
        ACanvas.Font.Color  := clLime;
      End
      Else
        ACanvas.Brush.Color := clMoneyGreen;
    End;}

end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.cxDadostvKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = 13 Then
     cxDadosQTDETI.FocusWithSelection;
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.btnConfirmaClick(Sender: TObject);
var
  prmDllEtq: TParamDllEtiquetas;
begin
  inherited;
  If Not fTemQtdEtiMarcada Then
  Begin
    pMensagemOK('Será preciso selecionar ao menos uma etiqueta para ser impressa.');
    Exit;
  End;
  prmDllEtq := TParamDllEtiquetas.Create;
  prmDllEtq.strCodEmp := ShortString(String(VS_strCodEmp));
  case AnsiIndexStr(ShortString(fCfgSis('ETIRAS', varString)), ['L', 'A', 'Z']) of
    0: prmDllEtq.tpeTipEtq := tpeLoteRastreamentoProdutoLaser;
    1: prmDllEtq.tpeTipEtq := tpeLoteRastreamentoProdutoArgox;
    2: prmDllEtq.tpeTipEtq := tpeLoteRastreamentoProdutoZebra;
  end;

  pCarregarListaLoteEQuantidades(prmDllEtq.ArrLoteProdutoEtiq);
  fImprimeEtiqueta(prmDllEtq, 'fImprimeEtiquetasRastreamentoProduto');
  FreeAndNil(prmDllEtq);
  pMensagemOk('Impressão Concluída.');
  edtQtdEtq.Text := '0';
  btnConfirmaFiltroClick(Sender);
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.btnConfirmaFiltroClick(Sender: TObject);
begin
  If fEmptyStr(edtQtdEtq.Text) Then
  Begin
    pMensagemOk('A Quantidade de Etiquetas deve ser preenchido!');
    Exit;
  End;

  If fValidaCampos(nil, False) Then
  begin
    cdsDados.qryQuery.SQL.Text := fSQLLoteRastreamento;
    pAtribuirParametros;
    cdsDados.fAbreClient(True, 'btnConfirmaFiltroClick', False, True);
    cxDadostv.ApplyBestFit;
  end;
end;

function TfrmImprimeEtiquetaLoteRastreamentoProduto.fTemQtdEtiMarcada(blnLimparConsulta: boolean = True): Boolean;
begin
  cdsDados.DisableControls;
  Try
    cdsDados.Filtered := False;
    cdsDados.Filter   := 'QTDETI >= 1';
    cdsDados.Filtered  := True;
    Result := cdsDados.RecordCount > 0;
  Finally
    If blnLimparConsulta Then
      cdsDados.Filtered := False;
    cdsDados.EnableControls;
  End;
end;


function TfrmImprimeEtiquetaLoteRastreamentoProduto.fSQLLoteRastreamento(blnVazio :Boolean = False): String;
begin

  if fEmptyStr(strSeqGorEnderecamento) then
    Result := fSQLLoteRastreamentoConsulta(blnVazio)
  else
    Result := fSQLLoteRastreamentoFatGor(blnVazio);

End;

function TfrmImprimeEtiquetaLoteRastreamentoProduto.fSQLCamposBase: String;
begin
  Result := '';
  Result := Result + '   CADITE.ITE_CODITE AS CODITE, ';
  Result := Result + '   CADITE.ITE_DESITE AS DESITE, ';
  Result := Result + '   LOTRAS.LOT_NUMLOT AS NUMLOT, ';
  Result := Result + '   LOTRAS.AUTOINCREM AS SEQLOT, ';
end;

function TfrmImprimeEtiquetaLoteRastreamentoProduto.fSQLOrder: String;
begin
  Result := '  ORDER BY CADITE.ITE_DESITE, LOTRAS.LOT_NUMLOT ';
end;

function TfrmImprimeEtiquetaLoteRastreamentoProduto.fSQLLoteRastreamentoFatGor(blnVazio :Boolean = False): String;
begin
  Result := '';
  Result := Result + ' SELECT                                                      ';
  Result := Result + fSQLCamposBase                                                 ;
  Result := Result + '   MOVRAS.MOV_QTDETI AS QTDETI                               ';
  Result := Result + '  FROM MOVRAS                                                ';
  Result := Result + '  INNER JOIN LOTRAS ON LOTRAS.AUTOINCREM = MOV_SEQLOT        ';
  Result := Result + '  INNER JOIN CADITE ON CADITE.ITE_CODITE = LOTRAS.LOT_CODITE ';
  Result := Result + '  LEFT  JOIN CADFOR ON CADFOR.FOR_CODFOR = LOTRAS.LOT_CODFOR ';


  if blnVazio Then
    Result := Result + ' WHERE FALSE '
  Else
    Result := Result + ' WHERE TRUE ';

  Result := Result + '  AND MOVRAS.MOV_SEQEND = ' + QuotedStr(strSeqGorEnderecamento);
  Result := Result + fSQLOrder;

End;

function TfrmImprimeEtiquetaLoteRastreamentoProduto.fSQLLoteRastreamentoConsulta(blnVazio :Boolean = False): String;
begin
  Result := Result + ' SELECT  ';
  Result := Result + fSQLCamposBase;

  If fEmptyStr(edtQtdEtq.Text) Then
    Result := Result + '   0 AS QTDETI '
  Else
    Result := Result + '   ' + edtQtdEtq.Text + ' AS QTDETI ';

  Result := Result + ' FROM LOTRAS ';
  Result := Result + ' INNER JOIN CADITE ON CADITE.ITE_CODITE = LOTRAS.LOT_CODITE ';
  Result := Result + ' LEFT  JOIN CADFOR ON CADFOR.FOR_CODFOR = LOTRAS.LOT_CODFOR ';

  if blnVazio Then
    Result := Result + ' WHERE FALSE '
  Else
  begin
    Result := Result + ' WHERE TRUE ';

    {Filtro de Linha Grupo  Grupo}
    If Not fEmptyStr(mskLinGru.Text) Then
    Begin
      If RightStr(AnsiString(mskLinGru.Text), 2) = '000' Then
      Begin
        If Not fEmptyStr(mskLinGruFin.Text) Then
        Begin
          If RightStr(AnsiString(mskLinGruFin.Text),3) = '000' Then
            Result := Result + '  AND LEFT(CADITE.ITE_CODGRU,3) BETWEEN LEFT(:CODGRU,3) AND LEFT(:CODGRU2,3) '
          Else
            Result := Result + '  AND CADITE.ITE_CODGRU BETWEEN CONCAT(LEFT(:CODGRU,3),"000") AND :CODGRU2 ';
        End
        Else
          Result := Result + '  AND LEFT(CADITE.ITE_CODGRU,3) = LEFT(:CODGRU,3) ';
      End
      Else
      Begin
        If Not fEmptyStr(mskLinGruFin.Text) Then
        Begin
          If RightStr(AnsiString(mskLinGruFin.Text), 3) = '000' Then
            Result := Result + '  AND CADITE.ITE_CODGRU BETWEEN :CODGRU AND CONCAT(LEFT(:CODGRU2,3),"099") '
          Else
            Result := Result + '  AND CADITE.ITE_CODGRU BETWEEN :CODGRU AND :CODGRU2 ';
        End
        Else
          Result := Result + '  AND CADITE.ITE_CODGRU = :CODGRU ';
      End;
    End;

    { PRODUTO }
    If fEmptyStr(edtCodIte.Text) Then
      Result := Result + fStrLocate(edtCodIte, arrCodIte, 'CADITE.ITE_CODITE', 'CODITE');

    { MARCA }
    If fEmptyStr(edtCodMar.Text) Then
      Result := Result + fStrLocate(edtCodMar, arrCodMar, 'CADITE.ITE_CODMAR', 'CODMAR');

    { REFERERNCIA }
    If Not fEmptyStr(edtRefere.Text) Then
      If (Not fEmptyStr(edtRefFin.Text)) Then
        Result := Result + ' AND LEFT(CADITE.ITE_REFERE, LENGTH(:MAIOR)) BETWEEN :REFERE AND :REFFIN '
      Else
        Result := Result + '  AND CADITE.ITE_REFERE LIKE :REFERE ';

    { FORNECEDOR }
    If Not fEmptyStr(edtCodFor.Text) Then
      Result := Result + fStrLocate(edtCodFor, arrCodFor, 'LOT_CODFOR', 'CODFOR');

    { LOTE }
    If Not fEmptyStr(edtNumLot.Text) Then
      Result := Result + fStrLocate(edtNumLot, arrSeqLot, 'LOTRAS.AUTOINCREM', 'SEQLOT');
  end;


  Result := Result + fSQLOrder;

End;

function TfrmImprimeEtiquetaLoteRastreamentoProduto.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodFor) Then
      pDesmarcaLista(edtCodFor, arrCodFor)

    Else If (Sender = edtCodMar) Then
      pDesmarcaLista(edtCodMar, arrCodMar)

    Else If (Sender = mskLinGru) Then
      mskLinGruFin.Enabled := Not fEmptyStr(mskLinGru.Text)

    Else If (Sender = edtCodIte) Then
      pDesmarcaLista(edtCodIte, arrCodIte)
    Else If (Sender = edtNumLot) Then
    Begin
     // pDesmarcaLista(edtNumLot, arrSeqLot);
      If (edtNumLot.Text <> '+1') And (not (fEmptyStr(edtNumLot.Text))) Then
      Begin
        {If fEmptyStr(fRetNumLoteConsulta(edtNumLot.Text)) Then
        Begin
          Result := False;
          pMensagemOk('Numero do Lote Inválido!');
          edtNumLot.Text := '';
        End; }
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

 End;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.pAtribuirParametros;
  Var
    strSeqLotFilter : String;
begin
  If cdsDados.qryQuery.FindParam('CODEMP') <> Nil Then
    cdsDados.qryQuery.ParamByName('CODEMP').AsString := VS_strCodemp;

  If Not fEmptyStr(mskLinGru.Text) Then
    cdsDados.qryQuery.ParamByName('CODGRU').AsString := mskLinGru.Text;
  If Not fEmptyStr(mskLinGruFin.Text) Then
    cdsDados.qryQuery.ParamByName('CODGRU2').AsString := mskLinGruFin.Text;

  strSeqLotFilter := '';
  if Length(arrSeqLot) > 0 then
    strSeqLotFilter := arrSeqLot[0].strCodigo;

  pSetaParam(strSeqLotFilter, arrSeqLot, strSeqLot, 'SEQLOT', cdsDados.qryQuery);

  pSetaParam(edtCodIte.Text, arrCodIte, strCodIte, 'CODITE', cdsDados.qryQuery);

  pSetaParam(edtCodMar.Text, arrCodMar, strCodMar, 'CODMAR', cdsDados.qryQuery);

  { REFERENCIA }
  If Not fEmptyStr(edtRefere.Text) Then
  Begin
    If (Not fEmptyStr(edtRefFin.Text)) Then
    Begin
      cdsDados.qryQuery.ParamByName('REFERE').AsString := edtRefere.Text;
      cdsDados.qryQuery.ParamByName('REFFIN').AsString := edtRefFin.Text;
      If Length(edtRefere.Text) > Length(edtRefFin.Text) Then
        cdsDados.qryQuery.ParamByName('MAIOR').AsString := edtRefere.Text
      Else
        cdsDados.qryQuery.ParamByName('MAIOR').AsString := edtRefFin.Text;
    End
    Else
      cdsDados.qryQuery.ParamByName('REFERE').AsString := edtRefere.Text + '%';
  End;

  pSetaParam(edtCodFor.Text, arrCodFor, strCodFor , 'CODFOR', cdsDados.qryQuery);
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.pCarregarListaLoteEQuantidades(var ArrLoteProdutoEtiq: TArrLoteProdutoEtiq);
begin
  cdsDados.DisableControls;
  Try
    If Not fTemQtdEtiMarcada(False) Then
      Exit;

    SetLength(ArrLoteProdutoEtiq, cdsDados.RecordCount);
    cdsDados.first;
    While not cdsDados.Eof Do
    Begin
      ArrLoteProdutoEtiq[cdsDados.RecNo -1].intQtdEti := cdsDados.FieldByName('QTDETI').AsInteger;
      ArrLoteProdutoEtiq[cdsDados.RecNo -1].strAutInc := ShortString(cdsDados.FieldByName('SEQLOT').AsString);
      cdsDados.Next;
    End;
  Finally
    cdsDados.First;
    cdsDados.Filtered := False;
    cdsDados.EnableControls;
  End;
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrCodMar, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.mskLinGruExit(Sender: TObject);
begin
  If fEmptyStr(mskLinGru.Text) Then
    edtDesGru.Text := 'TODOS'
  Else
  Begin
    edtDesGru.Text := fRetNomeLinhaGrupo(mskLinGru.Text);
    If fEmptyStr(edtDesGru.Text) Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinGru.Clear;
      pSetFocus(mskLinGru);
    End;
  End;
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.mskLinGruFinExit(Sender: TObject);
begin
  If fEmptyStr(mskLinGruFin.Text) Then
    edtlinGruFin.Text := 'TODOS'
  Else
  Begin
    edtlinGruFin.Text := fRetNomeLinhaGrupo(mskLinGruFin.Text);
    If fEmptyStr(edtlinGruFin.Text) Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinGruFin.Clear;
      pSetFocus(mskLinGruFin);
    End;
  End;
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.edtCodIteExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodIte,edtDesIte, arrCodIte, nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.edtCodForExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrCodFor, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrCodFor, False) Then
    If fValidaCampos(edtCodFor, True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.mskLinGruKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  If fPesqGrupo(Self, mskLinGru, edtDesGru, nil, Key, arrSel) Then
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.mskLinGruFinKeyPress(Sender: TObject; var Key: Char);
  var arrSel : TConsultasArray;
begin
  If Not fEmptyStr(mskLinGru.Text) Then
  Begin
    If fPesqGrupo(Self, mskLinGruFin, edtlinGruFin, nil, Key, arrSel) Then
      If fValidaCampos(mskLinGruFin, True) Then
        SelectNext(ActiveControl, True, True);
  End
  Else
    Key := #0;
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.edtCodIteKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrCodIte, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fvalidaCampos(edtCodIte,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImprimeEtiquetaLoteRastreamentoProduto.edtCodMarKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrCodMar, False) Then
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
end;

end.
