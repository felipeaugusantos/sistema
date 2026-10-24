unit untLiberacaoPedidosExternos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, MemDS, DBAccess, Uni, Datasnap.Provider,
  UniDataSetProvider, Datasnap.DBClient, UniClientDataSet, dxCore, cxMemo, System.UITypes, untFuncoesGenerica,
  EditFocus, untTypesSistema;

const
  WM_MESSAGEATUALIZARPEDIDOS = WM_USER + 776;

type
  TfrmLiberacaoPedidosExternos = class(TfrmPai)
    pnlRodape: TPanel;
    shpLiberado: TShape;
    lblLiberado: TLabel;
    shpBloqueado: TShape;
    lblBloqueado: TLabel;
    cxgPedidos: TcxGrid;
    cxgPedidosDados: TcxGridDBTableView;
    cxgPedidosDadosFGO_TIPPED: TcxGridDBColumn;
    cxgPedidosDadosBONIFICA: TcxGridDBColumn;
    cxgPedidosDadosDESTINO: TcxGridDBColumn;
    cxgPedidosDadosFGO_NUMDOC: TcxGridDBColumn;
    cxgPedidosDadosFGO_CODEMP: TcxGridDBColumn;
    cxgPedidosDadosFGO_EMP_CD: TcxGridDBColumn;
    cxgPedidosDadosFGO_DTAENT: TcxGridDBColumn;
    cxgPedidosDadosFGO_HORENT: TcxGridDBColumn;
    cxgPedidosDadosFGO_PREVIS: TcxGridDBColumn;
    cxgPedidosDadosFGO_NOMCLI: TcxGridDBColumn;
    cxgPedidosDadosFGO_TIPFRE: TcxGridDBColumn;
    cxgPedidosDadosFGO_TOTFRE: TcxGridDBColumn;
    cxgPedidosDadosTRANSPORTADORA: TcxGridDBColumn;
    cxgPedidosDadosDIGITADOR: TcxGridDBColumn;
    cxgPedidosDadosVENDEDOR: TcxGridDBColumn;
    cxgPedidosDadosDESCRI: TcxGridDBColumn;
    cxgPedidosDadosDESFPG: TcxGridDBColumn;
    cxgPedidosDadosFGO_CONPAG: TcxGridDBColumn;
    cxgPedidosDadosTIPATE: TcxGridDBColumn;
    cxgPedidosDadosFGO_VLRCON: TcxGridDBColumn;
    cxgPedidosDadosLEX_DTALIB: TcxGridDBColumn;
    cxgPedidosDadosLEX_HRALIB: TcxGridDBColumn;
    cxgPedidosDadosLEX_OPELIB: TcxGridDBColumn;
    cxgPedidosDadosFGO_TIPOPE: TcxGridDBColumn;
    cxgPedidosDadosVALFUT: TcxGridDBColumn;
    cxgPedidosDadosVALENT: TcxGridDBColumn;
    cxgPedidosDadosVALRET: TcxGridDBColumn;
    cxgPedidosDadosFGO_LIBERA: TcxGridDBColumn;
    cxgPedidosDadosFGO_LIBCOM: TcxGridDBColumn;
    cxgPedidosDadosFGO_NUMPOK: TcxGridDBColumn;
    cxgPedidosDadosDESOCO: TcxGridDBColumn;
    cxgPedidosDadosCLILOJ: TcxGridDBColumn;
    cxgPedidosNivel: TcxGridLevel;
    pnlDiversos: TPanel;
    rdgStatus: TRadioGroup;
    qryPedidos: TUniQuery;
    dspPedidos: TUniDataSetProvider;
    cdsPedidos: TUniClientDataSet;
    dtsPedidos: TDataSource;
    cxgPedidosDadosLEX_LIBPOK: TcxGridDBColumn;
    btnSeleciona: TBitBtnLocked;
    btnAtualizar: TBitBtnLocked;
    btnReimpressao: TBitBtnLocked;
    btnExpandirTodos: TBitBtnLocked;
    btnRetrairTodos: TBitBtnLocked;
    btnPadrao: TBitBtnLocked;
    dtsMotivos: TDataSource;
    cdsMotivos: TUniClientDataSet;
    cdsMotivosLEX_NUMDOC: TStringField;
    cdsMotivosLEX_ESPDOC: TStringField;
    cdsMotivosLEX_CODEMP: TStringField;
    cdsMotivosLEX_OPELIB: TStringField;
    cdsMotivosLEX_OPEBLO: TStringField;
    cdsMotivosLEX_MOTBLO: TMemoField;
    cdsMotivosLEX_LIBPOK: TStringField;
    cxgPedidosNivelMotivos: TcxGridLevel;
    cxgPedidosMotivos: TcxGridDBTableView;
    cxgPedidosMotivosLEX_MOTLIB: TcxGridDBColumn;
    cxgPedidosMotivosLEX_MOTBLO: TcxGridDBColumn;
    cdsMotivosLEX_MOTLIB: TMemoField;
    cxgPedidosDadosFGO_C_G_C_: TcxGridDBColumn;
    lblMotivoBloqueio: TLabel;
    edtMotivoBloqueio: TEditFocus;
    lblProdutoPedido: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnRelPedExternos: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure rdgStatusClick(Sender: TObject);
    procedure cxgPedidosDadosCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnReimpressaoClick(Sender: TObject);
    procedure btnExpandirTodosClick(Sender: TObject);
    procedure btnRetrairTodosClick(Sender: TObject);
    procedure btnSelecionaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPadraoClick(Sender: TObject);
    procedure cxgPedidosDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnRelPedExternosClick(Sender: TObject);
  private

    mmsLayoutDefault: TMemoryStream;

    procedure pAtualizarPedidos;
    procedure pCarregaPedidos;
    function fNroPedido: String;
    function fGetChaveLayoutGrid: String;

    procedure pWMMessageAtualizarPedidos(var Message: TMessage); Message WM_MESSAGEATUALIZARPEDIDOS;

    procedure pFormataCGC_CPF(Sender: TField; var Text: string; DisplayText: Boolean);

    function fPreparaTextoMotivo: string;
    function fPreparaTextoProduto: string;

  public
    { Public declarations }
    arrSelIte: TConsultasArray;
  end;


implementation

uses
  untFuncoesSimples, untReimpressao, untLiberacaoPedidosExternosObs, untLibExt,
  untFuncoesConsulta, untConsultas, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

{ TfrmLiberacaoPedidosExternos }

procedure TfrmLiberacaoPedidosExternos.btnAtualizarClick(Sender: TObject);
begin
  inherited;
  PostMessage(Handle, WM_MESSAGEATUALIZARPEDIDOS, 0, 0);
end;

procedure TfrmLiberacaoPedidosExternos.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  If (cxgPedidosDados.DataController.DataSource.DataSet.Active) Then
    If (Not cxgPedidosDados.DataController.DataSource.DataSet.IsEmpty) Then
      cxgPedidosDados.Controller.ClearSelection;
end;

procedure TfrmLiberacaoPedidosExternos.btnExpandirTodosClick(Sender: TObject);
begin
  inherited;

  If (cxgPedidosDados.DataController.DataSource.DataSet.Active) Then
    If (Not cxgPedidosDados.DataController.DataSource.DataSet.IsEmpty) Then
      cxgPedidosDados.ViewData.Expand(True);

end;

procedure TfrmLiberacaoPedidosExternos.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  If (cxgPedidosDados.DataController.DataSource.DataSet.Active) Then
    If (Not cxgPedidosDados.DataController.DataSource.DataSet.IsEmpty) Then
      cxgPedidosDados.Controller.SelectAll;
end;

procedure TfrmLiberacaoPedidosExternos.btnPadraoClick(Sender: TObject);
begin
  inherited;
  btnPadrao.Enabled := False;
  mmsLayoutDefault.Position := 0;
  cxgPedidosDados.RestoreFromStream(mmsLayoutDefault);
  btnPadrao.Enabled := True;
end;

procedure TfrmLiberacaoPedidosExternos.btnReimpressaoClick(Sender: TObject);
begin

  inherited;

  If cdsPedidos.IsEmpty Then
    Exit;

  If (cdsPedidos.FieldByName('LEX_LIBPOK').AsString = 'S') Then
  Begin
    TReimpressao.Create(cdsPedidos.FieldByName('FGO_NUMDOC').AsString,
                        cdsPedidos.FieldByName('FGO_ESPDOC').AsString,
                        0,
                        0,
                        '',
                        cdsPedidos.FieldByName('FGO_CODEMP').AsString,
                        '',
                        False,
                        '',
                        False,
                        False,
                        False,
                        '',
                        '',
                        False,
                        0,
                        False,
                        '').pReimprimeDocumento;
  End
  Else
    fMensagem('ATENÇÃO!', 'O pedido ' + fNroPedido + ' não está liberado!', ['&Ok']);

end;

procedure TfrmLiberacaoPedidosExternos.btnRelPedExternosClick(Sender: TObject);
begin
  inherited;

  if Assigned(prcExecutaRelatorio) then
    prcExecutaRelatorio(431, 11536, [],
                        ['CODEMP','CODITE'],
                        [VS_strCodEmp, edtCodIte.Text],
                        Sender);
end;

procedure TfrmLiberacaoPedidosExternos.btnRetrairTodosClick(Sender: TObject);
begin
  inherited;

  If (cxgPedidosDados.DataController.DataSource.DataSet.Active) Then
    If (Not cxgPedidosDados.DataController.DataSource.DataSet.IsEmpty) Then
      cxgPedidosDados.ViewData.Collapse(True);

end;

procedure TfrmLiberacaoPedidosExternos.btnSelecionaClick(Sender: TObject);
var
  strObsLib,
  strDigLib   : String;
  blnLiberado, blnConfirmou : Boolean;
  objLibExt   : TLibExt;

  blnSelecionouMaisDeUmRegistro : Boolean;
  intCount, intRecIdx : Integer;

  strNumDocSel, strEspDocSel, strEmpDocSel : String;

  slPedidosJaLiberados : TStringList;

begin
  inherited;

  blnConfirmou := False;

  If cdsPedidos.IsEmpty Then
    Exit;

  strObsLib := '';

  blnSelecionouMaisDeUmRegistro := (cxgPedidosDados.Controller.SelectedRecordCount > 1);

  {Processa registros selecionados}
  If (blnSelecionouMaisDeUmRegistro) Then
  Begin

    slPedidosJaLiberados := TStringList.Create;
    slPedidosJaLiberados.Clear;

    For intCount := 0 To cxgPedidosDados.DataController.GetSelectedCount - 1 Do
    Begin

      intRecIdx := cxgPedidosDados.Controller.SelectedRecords[intCount].RecordIndex;

      strNumDocSel := cxgPedidosDados.DataController.Values[intRecIdx, cxgPedidosDadosFGO_NUMDOC.Index];
      strEspDocSel := 'PD';
      strEmpDocSel := cxgPedidosDados.DataController.Values[intRecIdx, cxgPedidosDadosFGO_CODEMP.Index];

      objLibExt := TLibExt.Create(Self,
                                  strNumDocSel,
                                  strEspDocSel,
                                  strEmpDocSel,
                                  False);

      Try

        {Já Liberado!}
        If objLibExt.strLibPok = 'S' Then
          slPedidosJaLiberados.Add(strNumDocSel);

      Finally
        If Assigned(objLibExt) Then
          objLibExt.Destroy;
      End;

    End;

    If (slPedidosJaLiberados.Count > 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O(s) pedido(s) ' + slPedidosJaLiberados.CommaText + ' já foi(ram) liberado(s)!', ['&Ok']);
      Exit;
    End;

    pCriarFormularios(TfrmLiberacaoPedidosExternosObs, frmLiberacaoPedidosExternosObs);

    Try

      frmLiberacaoPedidosExternosObs.ShowModal;
      blnConfirmou := frmLiberacaoPedidosExternosObs.blnConfirma;

      If blnConfirmou Then
      Begin
        strObsLib   := frmLiberacaoPedidosExternosObs.memObs.Text;
        strDigLib   := frmLiberacaoPedidosExternosObs.strCodDig;
        blnLiberado := frmLiberacaoPedidosExternosObs.rdbLibera.Checked;
      End Else
        Exit;

    Finally
      pFreeAndNil(frmLiberacaoPedidosExternosObs);
    End;

    If (blnConfirmou) Then
    Begin

      For intCount := 0 To cxgPedidosDados.DataController.GetSelectedCount - 1 Do
      Begin

        intRecIdx := cxgPedidosDados.Controller.SelectedRecords[intCount].RecordIndex;

        strNumDocSel := cxgPedidosDados.DataController.Values[intRecIdx, cxgPedidosDadosFGO_NUMDOC.Index];
        strEspDocSel := 'PD';
        strEmpDocSel := cxgPedidosDados.DataController.Values[intRecIdx, cxgPedidosDadosFGO_CODEMP.Index];

        objLibExt := TLibExt.Create(Self,
                                    strNumDocSel,
                                    strEspDocSel,
                                    strEmpDocSel,
                                    False);
        If (blnLiberado) Then
        Begin
          objLibExt.strOpeLib := strDigLib;
          objLibExt.strMotLib := strObsLib;
          objLibExt.pLiberar;
        End
        Else
        Begin
          objLibExt.strOpeBlo := strDigLib;
          objLibExt.strMotBlo := strObsLib;
          objLibExt.pBloquear;
        End;

        If Assigned(objLibExt) Then
          objLibExt.Destroy;

      End;

    End;

  End
  Else
  Begin

    Try

      pCriarFormularios(TfrmLiberacaoPedidosExternosObs, frmLiberacaoPedidosExternosObs);

      objLibExt := TLibExt.Create(Self,
                                  cdsPedidos.FieldByName('FGO_NUMDOC').AsString,
                                  cdsPedidos.FieldByName('FGO_ESPDOC').AsString,
                                  cdsPedidos.FieldByName('FGO_CODEMP').AsString,
                                  False);

      {Já Liberado!}
      If objLibExt.strLibPok = 'S' Then
        fMensagem('ATENÇÃO!', 'O pedido ' + fNroPedido + ' já foi liberado!', ['&Ok'])
      Else
      Begin

        If Not fEmptyStr(objLibExt.strMotBlo) Then
          strObsLib := 'Data:' + DateToStr(objLibExt.dtaDtaBlo) + '-' + objLibExt.strMotBlo;

        If fEmptyStr(strObsLib) Then
        Begin
          frmLiberacaoPedidosExternosObs.pnlObsAnt.Visible := False;
          frmLiberacaoPedidosExternosObs.Height            := frmLiberacaoPedidosExternosObs.Height -
                                                              frmLiberacaoPedidosExternosObs.pnlObsAnt.Height;
        End
        Else
        Begin
          frmLiberacaoPedidosExternosObs.memObsAnt.Texto   := strObsLib;
          frmLiberacaoPedidosExternosObs.pnlObsAnt.Visible := True;
        End;

        frmLiberacaoPedidosExternosObs.ShowModal;
        blnConfirmou := frmLiberacaoPedidosExternosObs.blnConfirma;

        If blnConfirmou Then
        Begin
          strObsLib   := frmLiberacaoPedidosExternosObs.memObs.Text;
          strDigLib   := frmLiberacaoPedidosExternosObs.strCodDig;
          blnLiberado := frmLiberacaoPedidosExternosObs.rdbLibera.Checked;

          If (blnLiberado) Then
          Begin
            objLibExt.strOpeLib := strDigLib;
            objLibExt.strMotLib := strObsLib;
            objLibExt.pLiberar;
          End
          Else
          Begin
            objLibExt.strOpeBlo := strDigLib;
            objLibExt.strMotBlo := strObsLib;
            objLibExt.pBloquear;
          End;
        End;
      End;

      pFreeAndNil(frmLiberacaoPedidosExternosObs);

      If Assigned(objLibExt) Then
        objLibExt.Destroy;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[frmLiberacaoPedidosExternos.btnSelecionaClick]');
    End;

  End;

  if blnConfirmou then
    PostMessage(Handle, WM_MESSAGEATUALIZARPEDIDOS, 0, 0);

end;

procedure TfrmLiberacaoPedidosExternos.cxgPedidosDadosCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

  function fGetValue(Column: TcxGridDBColumn): Variant;
  begin
    Result := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, Column.Index];
  end;

begin
  inherited;

  If (Not cdsPedidos.Active) Then
    Exit;

  If (Not AViewInfo.GridRecord.IsData) Or (AViewInfo.GridRecord.Index = -1) Then
    Exit;

  If (AViewInfo.Item.SortOrder <> soNone) And (Not AViewInfo.Selected) Then
    ACanvas.Brush.Color := clInfoBk;

  If VarToStr(fGetValue(cxgPedidosDadosLEX_LIBPOK)) = 'S' Then
  Begin
    If (ACanvas.Brush.Color <> clHighlight) Then
      ACanvas.Font.Color := shpLiberado.Brush.Color
    Else
      ACanvas.Font.Color := clYellow;
  End
  Else
  Begin
    If (ACanvas.Brush.Color <> clHighlight) Then
      ACanvas.Font.Color := shpBloqueado.Brush.Color
    Else
      ACanvas.Font.Color := clYellow;
  End;

  btnReimpressao.Enabled := (cxgPedidosDados.Controller.SelectedRecordCount <= 1);

end;

procedure TfrmLiberacaoPedidosExternos.cxgPedidosDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  intRecIdx : Integer;
begin

  inherited;

  If (Key = VK_SPACE) Then
  Begin

    intRecIdx := cxgPedidosDados.DataController.FocusedRecordIndex;

    If (cxgPedidosDados.DataController.DataSource.DataSet.Active) Then
    Begin

      If (Not cxgPedidosDados.DataController.DataSource.DataSet.IsEmpty) Then
      Begin

        If TcxGridViewData(cxgPedidosDados.ViewData).Records[intRecIdx].Expanded Then
          TcxGridViewData(cxgPedidosDados.ViewData).Records[intRecIdx].Collapse(False)
        Else
          TcxGridViewData(cxgPedidosDados.ViewData).Records[intRecIdx].Expand(False);

      End;

    End;

  End;

end;

procedure TfrmLiberacaoPedidosExternos.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte,edtDesIte,arrSelIte, nil, fRetNomProduto,'do Produto');
end;

procedure TfrmLiberacaoPedidosExternos.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrSelIte, True, nil, 'Consulta de Itens', '1') then
    Begin
      If fValidaCampos(edtCodIte, True) Then
      Begin
        pAtualizarPedidos;
        Self.SelectNext(ActiveControl, True, True);
      End;
    End;
  End;

end;

function TfrmLiberacaoPedidosExternos.fGetChaveLayoutGrid: String;
begin
  Result := Self.Name + '.' + cxgPedidosDados.Name;
end;

function TfrmLiberacaoPedidosExternos.fNroPedido: String;
begin

  Result := '';

  If cdsPedidos.IsEmpty Then
    Exit;

  Result := cdsPedidos.FieldByName('FGO_NUMDOC').AsString + '-' +
            cdsPedidos.FieldByName('FGO_ESPDOC').AsString + '-' +
            cdsPedidos.FieldByName('FGO_CODEMP').AsString;
end;

procedure TfrmLiberacaoPedidosExternos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(mmsLayoutDefault);
  fGetFuncoesCxGrid.pSalvarView(cxgPedidosDados, fGetChaveLayoutGrid, cdsPedidos);
end;

procedure TfrmLiberacaoPedidosExternos.FormCreate(Sender: TObject);
begin
  inherited;
  cdsMotivos.CreateDataSet;
  mmsLayoutDefault := TMemoryStream.Create;

  edtCodIte.MaxLength := fTamCodIte;
  edtCodIte.TamCampo  := fTamCodIte;

end;

procedure TfrmLiberacaoPedidosExternos.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If (Key = VK_F2) Then
  Begin
    btnAtualizar.Click;
  End
  Else
  If (Key = VK_F7) Then
  Begin
    btnMarcarTodos.Click;
  End
  Else
  If (Key = VK_F8) Then
  Begin
    btnDesmarcarTodos.Click;
  End
  Else
  If (Key = VK_F9) Then
  Begin
    btnReimpressao.Click;
  End
  Else
  If (Key = VK_F11) Then
  Begin
    btnExpandirTodos.Click;
  End
  Else
  If (Key = VK_F12) Then
  Begin
    btnRetrairTodos.Click;
  End
  Else
  If (Key = VK_RETURN) Then
  Begin
    if (edtMotivoBloqueio.Focused) Or (edtCodIte.Focused) then
      pAtualizarPedidos
    else
      btnSeleciona.Click;
  End
  Else
  If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End;

end;

procedure TfrmLiberacaoPedidosExternos.FormShow(Sender: TObject);
Var
  blnTipAte : Boolean;
  intRecNo  : Integer;
begin
  inherited;

  {Default - Não Liberados}
  rdgStatus.ItemIndex := 0;

  blnTipAte := fCfgSis('TIPATE', varBoolean) And fCfgSis('PEDTPA', varBoolean);

  PostMessage(Handle, WM_MESSAGEATUALIZARPEDIDOS, 0, 0);

  cxgPedidosDadosTIPATE.Visible := blnTipAte;

  cxgPedidosDados.StoreToStream(mmsLayoutDefault);

  If fGetFuncoesCxGrid.fCarregarView(cxgPedidosDados, fGetChaveLayoutGrid, cdsPedidos, intRecNo) Then
    cxgPedidosDadosTIPATE.Visible := blnTipAte;

  If (fCfgSis('ENT_CD') = 'S') Then
  Begin
    cxgPedidosDadosFGO_CODEMP.Caption := 'Emp.Origem';
    cxgPedidosDadosFGO_EMP_CD.Visible := True;
  End
  Else
  Begin
    cxgPedidosDadosFGO_CODEMP.Caption := 'Empresa';
    cxgPedidosDadosFGO_EMP_CD.Visible := False;
  End;

  cxgPedidosDadosCLILOJ.Visible := fCfgSis('CLILOJ', varBoolean);

  btnRelPedExternos.Visible := False;

  If Assigned(fncVerificaSeRelatorioExiste) then
    btnRelPedExternos.Visible := fncVerificaSeRelatorioExiste(431, 11536);

  pSetFocus(cxgPedidos);

end;

function TfrmLiberacaoPedidosExternos.fPreparaTextoMotivo: string;
begin

  Result := '';

  if fEmptyStr(edtMotivoBloqueio.Text) Then
    Exit;

  Result := ' AND MATCH(LEX_MOTBLO) AGAINST(' + QuotedStr(edtMotivoBloqueio.Text) + ') ';

end;

function TfrmLiberacaoPedidosExternos.fPreparaTextoProduto: string;
begin

  Result := '';

  If fEmptyStr(edtCodIte.Text) Then
    Exit;

  Result := ' AND ((SELECT      ' +
                   '  COUNT(*)  ' +
                   'FROM        ' +
                   '  FATDOR FD ' +
                   'WHERE       ' +
                   '  FD.FDO_NUMDOC = G.FGO_NUMDOC AND ' +
                   '  FD.FDO_ESPDOC = G.FGO_ESPDOC AND ' +
                   '  FD.FDO_CODEMP = G.FGO_CODEMP AND ' +
                   '  FD.FDO_CODITE = ' + QuotedStr(fStrZero(edtCodIte.Text, edtCodIte.TamCampo)) + ') > 0) ';

end;

procedure TfrmLiberacaoPedidosExternos.pAtualizarPedidos;
begin
  Try
    Screen.Cursor := crHourGlass;
    cxgPedidosDados.DataController.DataSource := nil;
    pCarregaPedidos;
    cxgPedidosDados.DataController.DataSource := dtsPedidos;
    cxgPedidosDados.DataController.GotoFirst;
  Finally
    Screen.Cursor := crDefault;
  End;
end;

procedure TfrmLiberacaoPedidosExternos.pCarregaPedidos;
begin

  With qryPedidos Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  SUM(((FDO_QTDITE - FDO_QTDBAI) * (FDO_UNITAR + (FDO_VALIPI + FDO_TOTFRE + FDO_VALRET + FDO_VALFCP' + fSqlValorReformaFdoRef('FATDOR.AUTOINCREM') + ' - FDO_DESESP) / FDO_QTDITE))) + IFNULL(FGO_DESACE, 0) AS FGO_VLRCON, ');
    SQL.Add('  G.*,                                              ');
    SQL.Add('  CONCAT(G.FGO_NUMPOK, IF(G.FGO_NUMPOK <> "" AND G.FGO_PEDSIT <> "", ",", ""),G.FGO_PEDSIT) AS PEDIDOSITE, ');
    SQL.Add('  IF(G.FGO_TIPOPE = "B", "S", "N") AS BONIFICA,     ');
    SQL.Add('  GROUP_CONCAT(DISTINCT IF(FDO_ENTFUT = "S", "ENT.FUTURA", IF(FDO_ENTRET = "E", "ENT.IMEDIATA", "RETIRA")) SEPARATOR " / ") AS DESTINO, ');
    SQL.Add('  C.CLI_C_G_C_ AS FGO_C_G_C_,                       ');
    SQL.Add('  C.CLI_NOMCLI,                                     ');
    SQL.Add('  C.CLI_OBSERV,                                     ');
    SQL.Add('  CONCAT(FGO_CODCLI, "-", CLI_NOMCLI) AS FGO_NOMCLI,');
    SQL.Add('  CONCAT(V.OPE_CODOPE, "-", V.OPE_NOMOPE) AS VENDEDOR,');
    SQL.Add('  CONCAT(D.OPE_CODOPE, "-", D.OPE_NOMOPE) AS DIGITADOR,');
    SQL.Add('  IF(IFNULL(T.TRA_NOMTRA, "") = "", CONCAT(TRAGOR.TRA_CODTRA, "-", TRAGOR.TRA_NOMTRA), CONCAT(G.FGO_CODTRA, "-", T.TRA_NOMTRA)) AS TRANSPORTADORA,');
    SQL.Add('  TPA_DESCRI AS TIPATE,                             ');
    SQL.Add('  FPG_DESCRI,                                       ');
    SQL.Add('  CONCAT(FPG_CODIGO, "-", FPG_DESCRI) AS DESFPG,    ');
    SQL.Add('  FGO_CONPAG,                                       ');
    SQL.Add('  SUM(IF(FDO_ENTFUT = "S", FDO_TOTITE - FDO_DESESP, 0.00)) AS VALFUT, ');
    SQL.Add('  SUM(IF(FDO_ENTRET = "R", FDO_TOTITE - FDO_DESESP, 0.00)) AS VALRET, ');
    SQL.Add('  SUM(IF(FDO_ENTRET = "E" AND FDO_ENTFUT = "N", FDO_TOTITE - FDO_DESESP, 0.00)) AS VALENT,');
    SQL.Add('  CONCAT(FGO_OCOLIB, "-", OCO_DESOCO, IF(IFNULL(FGO_HISCOM, "") <> "", " | ", ""), IFNULL(FGO_HISCOM, "")) AS DESOCO,');
    SQL.Add('  FGO_OCOLIB,');
    SQL.Add('  FGO_HISCOM,');
    SQL.Add('  OCO_DESOCO,');
    SQL.Add('  FGO_EMP_CD,');
    SQL.Add('  FGO_NTRAVA,');
    SQL.Add('  IF(IFNULL(FGO_CLILOJ, "N") = "N", "Não", "Sim") AS CLILOJ, ');
    SQL.Add('  CADDEP.DEP_DESCRI, ');
    SQL.Add('  LIBEXT.* ');
    SQL.Add('FROM                                                ');
    SQL.Add('  FATGOR G                                          ');
    SQL.Add('  JOIN FATDOR ON FDO_NUMDOC = FGO_NUMDOC AND        ');
    SQL.Add('                 FDO_ESPDOC = FGO_ESPDOC AND        ');
    SQL.Add('                 FDO_CODEMP = FGO_CODEMP AND        ');
    SQL.Add('                 FDO_CODCLI = FGO_CODCLI            ');
    SQL.Add('  JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ');
    SQL.Add('  JOIN CADCLI C ON C.CLI_CODCLI = G.FGO_CODCLI      ');
    SQL.Add('  LEFT JOIN EXTGOR ON G.AUTOINCREM = FGO_SEQFGO     ');
    SQL.Add('  LEFT JOIN CADTPA ON TPA_CODIGO = FGO_CODTPA       ');
    SQL.Add('  LEFT JOIN CADFPG ON FPG_CODIGO = FGO_CODFPG       ');
    SQL.Add('  LEFT JOIN CADOPE V ON V.OPE_CODOPE = FGO_CODVEN   ');
    SQL.Add('  LEFT JOIN CADOPE D ON D.OPE_CODOPE = FGO_CODDIG   ');
    SQL.Add('  LEFT JOIN CADTRA T ON T.TRA_CODTRA = FGO_CODTRA   ');
    SQL.Add('  LEFT JOIN AUXGOR   ON (AUXGOR.AUX_SEQGER  = G.AUTOINCREM) ');
    SQL.Add('  LEFT JOIN ENTCLI ECGOR  ON (ECGOR.AUTOINCREM = AUXGOR.AUX_ENTGER) ');
    SQL.Add('  LEFT JOIN CADTRA TRAGOR ON (ECGOR.ETC_CODTRA = TRAGOR.TRA_CODTRA) ');
    SQL.Add('  LEFT JOIN CADOCO OCOGOR ON (EXTGOR.FGO_OCOLIB = OCOGOR.OCO_CODOCO) ');
    SQL.Add('  LEFT JOIN CADDEP ON DEP_CODIGO = V.OPE_CODDEP AND DEP_CODEMP = V.OPE_CODEMP ');

    {LIBEXT - Controle "Liberação de Pedidos Externos"}
    SQL.Add('  JOIN LIBEXT ON LEX_NUMDOC = G.FGO_NUMDOC AND  ');
    SQL.Add('                 LEX_ESPDOC = G.FGO_ESPDOC AND  ');
    SQL.Add('                 LEX_CODEMP = G.FGO_CODEMP      ');

    SQL.Add('WHERE                                           ');

    {Permitir Liberação de Pedidos de outras empresas?}
    If Not fCfgSis('LPDEXT', VarBoolean) Then
      SQL.Add('  FGO_CODEMP = :CODEMP       AND                 ');

    SQL.Add('  FGO_ESPDOC = "PD"            AND                 ');
    SQL.Add('  IFNULL(FGO_DOCEND, "") = ""  AND                 ');
    SQL.Add('  FGO_JAFATU = FALSE           AND                 ');
    SQL.Add('  FGO_VLRCON > 0               AND                 ');
    SQL.Add('  IFNULL(FGO_NMPDAB, "") =  "" AND                 ');

    {Externos}
    SQL.Add('  ((IFNULL(FGO_NUMPOK, "") <> "") OR (IFNULL(FGO_PEDSIT, "") <> "") OR (LEX_ONDBLO = "S")) ');

    Case rdgStatus.ItemIndex Of
      0: SQL.Add('  AND LIBEXT.LEX_LIBPOK = "N" ' + fPreparaTextoMotivo); {Não Liberado!}
      1: SQL.Add('  AND LIBEXT.LEX_LIBPOK = "S" '); {Liberado!}
    End;

    {Filtra somente pedidos que
     contém o produto informado!}
    If Not fEmptyStr(edtCodIte.Text) Then
      SQL.Add(fPreparaTextoProduto);

    SQL.Add('GROUP BY ');
    SQL.Add('  FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_CODCLI ');

    {Permitir Liberação de Pedidos de outras empresas?}
    If Not fCfgSis('LPDEXT', VarBoolean) Then
      ParamByName('CODEMP').AsString := VS_strCodEmp;

  End;

  cdsPedidos.Close;
  cdsPedidos.SetProvider(dspPedidos);

  qryPedidos.Open;
  pSetaClient(qryPedidos);
  cdsPedidos.Open;

  {Motivos}
  If Not cdsPedidos.IsEmpty Then
  Begin

    cdsMotivos.EmptyDataSet;

    cdsPedidos.DisableControls;

    Try

      cdsPedidos.First;

      While Not cdsPedidos.Eof Do
      Begin

        cdsMotivos.Append;
        cdsMotivosLEX_NUMDOC.AsString := cdsPedidos.FieldByName('FGO_NUMDOC').AsString;
        cdsMotivosLEX_ESPDOC.AsString := cdsPedidos.FieldByName('FGO_ESPDOC').AsString;
        cdsMotivosLEX_CODEMP.AsString := cdsPedidos.FieldByName('FGO_CODEMP').AsString;

        cdsMotivosLEX_OPELIB.AsString := cdsPedidos.FieldByName('LEX_OPELIB').AsString;
        If Not fEmptyStr(cdsPedidos.FieldByName('LEX_MOTLIB').AsString) Then
        Begin
          cdsMotivosLEX_MOTLIB.AsString := 'Operador: ' + cdsPedidos.FieldByName('LEX_OPELIB').AsString + ' ' +
                                           'Data : '    + cdsPedidos.FieldByName('LEX_DTALIB').AsString + ' ' +
                                           'Motivo: '   + cdsPedidos.FieldByName('LEX_MOTLIB').AsString;
        End;

        cdsMotivosLEX_LIBPOK.AsString := cdsPedidos.FieldByName('LEX_LIBPOK').AsString;

        cdsMotivosLEX_OPEBLO.AsString := cdsPedidos.FieldByName('LEX_OPEBLO').AsString;
        If Not fEmptyStr(cdsPedidos.FieldByName('LEX_MOTBLO').AsString) Then
        Begin
          cdsMotivosLEX_MOTBLO.AsString := 'Operador: ' + cdsPedidos.FieldByName('LEX_OPEBLO').AsString + ' ' +
                                           'Data : '    + cdsPedidos.FieldByName('LEX_DTABLO').AsString + ' ' +
                                           'Motivo: '   + cdsPedidos.FieldByName('LEX_MOTBLO').AsString;
        End;

        cdsMotivos.Post;

        cdsPedidos.Next;

      End;

    Finally
      cdsPedidos.EnableControls;
    End;

  End;

  TFloatField(cdsPedidos.FieldByName('FGO_VLRCON')).DisplayFormat := '#,##0.00';
  TFloatField(cdsPedidos.FieldByName('FGO_TOTFRE')).DisplayFormat := '#,##0.00';

  TStringField(cdsPedidos.FieldByName('FGO_C_G_C_')).OnGetText := pFormataCGC_CPF;

  TStringField(cdsPedidos.FieldByName('FGO_TIPPED')).Alignment := taCenter;
  TStringField(cdsPedidos.FieldByName('FGO_CODEMP')).Alignment := taCenter;
  TStringField(cdsPedidos.FieldByName('FGO_TIPFRE')).Alignment := taCenter;
  TStringField(cdsPedidos.FieldByName('BONIFICA'  )).Alignment := taCenter;

  TStringField(cdsPedidos.FieldByName('LEX_DTALIB')).Alignment := taCenter;
  TStringField(cdsPedidos.FieldByName('LEX_HRALIB')).Alignment := taCenter;
  TStringField(cdsPedidos.FieldByName('LEX_OPELIB')).Alignment := taCenter;

end;

procedure TfrmLiberacaoPedidosExternos.pFormataCGC_CPF(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := fFormataCpfCgc(Sender.AsString, opcBrasil);
end;

procedure TfrmLiberacaoPedidosExternos.pWMMessageAtualizarPedidos(
  var Message: TMessage);
begin
  pAtualizarPedidos;
end;

procedure TfrmLiberacaoPedidosExternos.rdgStatusClick(Sender: TObject);
begin
  inherited;
  lblMotivoBloqueio.Visible := rdgStatus.ItemIndex = 0;
  edtMotivoBloqueio.Visible := lblMotivoBloqueio.Visible;

  PostMessage(Handle, WM_MESSAGEATUALIZARPEDIDOS, 0, 0);
end;

end.



