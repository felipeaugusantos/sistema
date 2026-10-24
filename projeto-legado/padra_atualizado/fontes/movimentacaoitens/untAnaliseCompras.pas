unit untAnaliseCompras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView, Uni,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, EditFocus,
  Mask, MaskEditFocus, QColorLabel, DBClient, Provider, DateUtils, StrUtils, DBCtrls,
  DBEditFocus, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade, UniClientDataSet, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  untCfgGrid;

type
  TfrmAnaliseCompras = class(TfrmPaiSimples)
    pnlDados: TPanel;
    grdAnaComView: TcxGridDBTableView;
    grdAnaComLevel1: TcxGridLevel;
    grdAnaCom: TcxGrid;
    grdAnaComCODEMP: TcxGridDBColumn;
    grdAnaComVENATU: TcxGridDBColumn;
    grdAnaComESTATU: TcxGridDBColumn;
    grdAnaComPEDCOM: TcxGridDBColumn;
    grdAnaComVENME1: TcxGridDBColumn;
    grdAnaComVENME2: TcxGridDBColumn;
    grdAnaComVENME3: TcxGridDBColumn;
    grdAnaComMEDIA_: TcxGridDBColumn;
    grdAnaComSUGEST: TcxGridDBColumn;
    lbl1: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtCodFab: TEditFocus;
    lbl3: TLabel;
    lbl4: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtPreVen: TEditFocus;
    lbl5: TLabel;
    lbl6: TLabel;
    edtPrePro: TEditFocus;
    lbl7: TLabel;
    mskLinGru: TMaskEditFocus;
    edtLinGru: TEditFocus;
    lbl8: TLabel;
    edtValPro: TEditFocus;
    lbl9: TLabel;
    lbl10: TLabel;
    edtMargem: TEditFocus;
    lbl11: TLabel;
    lbl12: TLabel;
    edtEstMin: TEditFocus;
    lbl13: TLabel;
    edtSubsti: TEditFocus;
    lblEntFut: TLabel;
    lbl14: TLabel;
    cdsDados: TUniClientDataSet;
    dtsDados: TDataSource;
    cdsDadosCODEMP: TStringField;
    cdsDadosVENATU: TFloatField;
    cdsDadosESTATU: TFloatField;
    cdsDadosPEDCOM: TFloatField;
    cdsDadosVENME1: TFloatField;
    cdsDadosVENME2: TFloatField;
    cdsDadosVENME3: TFloatField;
    cdsDadosMEDIA_: TFloatField;
    cdsDadosSUGEST: TFloatField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtUltAlt: TEditFocus;
    edtDtaUlt: TEditFocus;
    edtUltCom: TEditFocus;
    edtPreMed: TEditFocus;
    edtIPIEnt: TEditFocus;
    edtMarPro: TEditFocus;
    edtPraEnt: TEditFocus;
    chkTransf: TCheckBox;
    grdAnaComENTFUT: TcxGridDBColumn;
    cdsDadosENTFUT: TFloatField;
    grdAnaComPMED_V: TcxGridDBColumn;
    cdsDadosPMED_V: TFloatField;
    grdAnaComVENME4: TcxGridDBColumn;
    grdAnaComVENME5: TcxGridDBColumn;
    grdAnaComVENME6: TcxGridDBColumn;
    grdAnaComVENME7: TcxGridDBColumn;
    grdAnaComVENME8: TcxGridDBColumn;
    grdAnaComVENME9: TcxGridDBColumn;
    grdAnaComVENME10: TcxGridDBColumn;
    grdAnaComVENME11: TcxGridDBColumn;
    grdAnaComVENME12: TcxGridDBColumn;
    cdsDadosVENME4: TFloatField;
    cdsDadosVENME5: TFloatField;
    cdsDadosVENME6: TFloatField;
    cdsDadosVENME7: TFloatField;
    cdsDadosVENME8: TFloatField;
    cdsDadosVENME9: TFloatField;
    cdsDadosVENME10: TFloatField;
    cdsDadosVENME11: TFloatField;
    cdsDadosVENME12: TFloatField;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnCfgGri: TBitBtnLocked;
    btnNotEnt: TBitBtnLocked;
    btnPedCom: TBitBtnLocked;
    btnLimpaTela: TBitBtnLocked;
    btnCompra: TBitBtnLocked;
    btnVendas: TBitBtnLocked;
    btnSaldos: TBitBtnLocked;
    Shape1: TShape;
    Label4: TLabel;
    btnTabRel: TBitBtnLocked;
    grdAnaComSALDIS: TcxGridDBColumn;
    cdsDadosSALDIS: TFloatField;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure grdAnaComViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnNotEntClick(Sender: TObject);
    procedure btnPedComClick(Sender: TObject);
    procedure btnCompraClick(Sender: TObject);
    procedure btnVendasClick(Sender: TObject);
    procedure btnSaldosClick(Sender: TObject);
    procedure btnLimpaTelaClick(Sender: TObject);
    procedure chkTransfClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCfgGriClick(Sender: TObject);
    procedure grdAnaComVENME1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdAnaComVENME2CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdAnaComVENME3CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdAnaComVENME4CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdAnaComVENME5CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdAnaComVENME6CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdAnaComVENME7CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdAnaComVENME8CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdAnaComVENME9CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdAnaComVENME10CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdAnaComVENME11CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdAnaComVENME12CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnTabRelClick(Sender: TObject);
  private
    { Private declarations }

    intMesMostrar,
    intMesMedia: Integer;

    blnPorMes: Boolean;

    arrDatas: Array[0..12] Of Record
      dtaDtaIni,
      dtaDtaFin: TDate;
    End;

    objCfgGri: TCfgGrid;
    blnENTFUT: Boolean;

    procedure pDestacaMes(intMes: Integer; ACanvas: TcxCanvas; blnSelected: Boolean);

    procedure pLimpaTela;
    procedure pRetornaDados(strCodEmp: String);
    procedure pRetornaDadosGrid;

    function fRetornaSQL: String;
    function fRetornaSQLVendas(intTip: Integer): String;
    function fRetornaSQLVendasGirIte(intTip: Integer): String;
    function fRetornaSQLMedia: String;
    function fRetornaSQLSugestao: String;

    procedure pAjustaColunasMeses;
    procedure pCalculaDatas;

    Function fRetornaDadosGridPrg(cxProgresso: TcxProgressBar): Boolean;

    procedure pDadosAfterScroll(DataSet: TDataSet);

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

uses untConstantes, untSaldoPedidoCompra, untGravando, untComparaTabPre,
     untFuncoesSimples, untConsultas, untTypesSistema, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

procedure TfrmAnaliseCompras.btnCfgGriClick(Sender: TObject);
begin
  inherited;

  objCfgGri.pConfiguraColunas;
end;

procedure TfrmAnaliseCompras.btnCompraClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(95, 5631, [],
                        ['CODITE'],
                        [edtCodIte.Text],
                        Sender,
                        ['CODITE'],
                        False);
  End;

end;

procedure TfrmAnaliseCompras.btnLimpaTelaClick(Sender: TObject);
begin
  inherited;
  pLimpaTela;
  pSetFocus(edtCodIte);
end;

procedure TfrmAnaliseCompras.btnNotEntClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(93, 5614, [],
                        ['CODITE'],
                        [edtCodIte.Text],
                        Sender,
                        ['CODITE'],
                        False);
  End;

end;

procedure TfrmAnaliseCompras.btnPedComClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(94, 5630, [],
                        ['CODITE'],
                        [edtCodIte.Text],
                        Sender,
                        ['CODITE'],
                        False);
  End;

end;

procedure TfrmAnaliseCompras.btnSaldosClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(97, 5635, [],
                        ['CODITE'],
                        [edtCodIte.Text],
                        Sender,
                        ['CODITE'],
                        True);
  End;

end;


procedure TfrmAnaliseCompras.btnTabRelClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmComparaTabPre, frmComparaTabPre);
    frmComparaTabPre.edtCodIte.Text := edtCodIte.Text;
    frmComparaTabPre.ShowModal;
    FreeAndNil(frmComparaTabPre);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmAnaliseCompras.btnTabRelClick');
    End;
  End;

end;

procedure TfrmAnaliseCompras.btnVendasClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(96, 5632, [],
                        ['CODITE'],
                        [edtCodIte.Text],
                        Sender,
                        ['CODITE'],
                        False);
  End;

end;

procedure TfrmAnaliseCompras.pDadosAfterScroll(DataSet: TDataSet);
begin

  pRetornaDados(cdsDados.FieldByName('CODEMP').AsString);

end;


procedure TfrmAnaliseCompras.chkTransfClick(Sender: TObject);
begin
  inherited;

  fValidaCampos(edtCodIte, True);
end;

procedure TfrmAnaliseCompras.edtCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCodIte: TConsultasArray;
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrCodIte, True, nil, 'Consulta de Itens', '1') Then
  Begin
    If fValidaCampos(edtCodIte, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmAnaliseCompras.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodIte) Then
    Begin
      If (Not fEmptyStr(edtCodIte.Text)) Then
      Begin
        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
        pRetornaDados(VS_strCodEmp);
        If (fEmptyStr(edtDesIte.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','Esse Produto não está cadastrado!',['&O k']);
          Result := False;
        End
        Else
          pRetornaDadosGrid;
      End
      Else
        edtDesIte.Text := 'TODOS';
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAnaliseCompras.grdAnaComVENME10CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(10, ACanvas, AViewInfo.Selected);
end;

procedure TfrmAnaliseCompras.grdAnaComVENME11CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(11, ACanvas, AViewInfo.Selected);
end;

procedure TfrmAnaliseCompras.grdAnaComVENME12CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(12, ACanvas, AViewInfo.Selected);
end;

procedure TfrmAnaliseCompras.grdAnaComVENME1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(01, ACanvas, AViewInfo.Selected);
end;

procedure TfrmAnaliseCompras.grdAnaComVENME2CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(02, ACanvas, AViewInfo.Selected);

end;

procedure TfrmAnaliseCompras.grdAnaComVENME3CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(03, ACanvas, AViewInfo.Selected);
end;

procedure TfrmAnaliseCompras.grdAnaComVENME4CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(04, ACanvas, AViewInfo.Selected);
end;

procedure TfrmAnaliseCompras.grdAnaComVENME5CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(05, ACanvas, AViewInfo.Selected);
end;

procedure TfrmAnaliseCompras.grdAnaComVENME6CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(06, ACanvas, AViewInfo.Selected);
end;

procedure TfrmAnaliseCompras.grdAnaComVENME7CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(07, ACanvas, AViewInfo.Selected);
end;

procedure TfrmAnaliseCompras.grdAnaComVENME8CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  pDestacaMes(08, ACanvas, AViewInfo.Selected);
end;

procedure TfrmAnaliseCompras.grdAnaComVENME9CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  pDestacaMes(09, ACanvas, AViewInfo.Selected);
end;

procedure TfrmAnaliseCompras.pDestacaMes(intMes: Integer; ACanvas: TcxCanvas; blnSelected: Boolean);
Begin
  If (intMes <= intMesMedia) Then
  Begin
    ACanvas.Font.Color := clRed;
    ACanvas.Font.Style := [fsBold];

    If blnSelected Then
      ACanvas.Brush.Color := $00F5DBC2;
  End;
End;


procedure TfrmAnaliseCompras.grdAnaComViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
  Begin
    pLimpaTela;
    pSetFocus(edtCodIte);
  End
  Else If (Key = VK_F3) Then
    btnNotEnt.Click
  Else If (Key = VK_F4) Then
    btnPedCom.Click
  Else If (Key = VK_F5) Then
    btnTabRel.Click
  Else If (Key = VK_F12) Then
    btnLimpaTela.Click
  Else If (Key = VK_F8) Then
    btnCompra.Click
  Else If (Key = VK_F9) Then
    btnVendas.Click
  Else If (Key = VK_F11) Then
    btnSaldos.Click;
end;


procedure TfrmAnaliseCompras.pLimpaTela;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtCodFab.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtPreVen.Clear;
  mskLinGru.Clear;
  edtLinGru.Clear;
  edtMargem.Clear;
  edtIPIEnt.Clear;
  edtUltCom.Clear;
  edtDtaUlt.Clear;
  edtUltAlt.Clear;
  edtPraEnt.Clear;
  edtPrePro.Clear;
  edtValPro.Clear;
  edtMarPro.Clear;
  edtPreMed.Clear;
  edtSubsti.Clear;
  edtEstMin.Clear;
  cdsDados.EmptyDataSet;
end;

procedure TfrmAnaliseCompras.pRetornaDados(strCodEmp: String);
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE  ';
    strSQL := strSQL + '    I.ITE_DESITE,     ';
    strSQL := strSQL + '    I.ITE_CODFAB,     ';
    strSQL := strSQL + '    I.ITE_DIAFOR,     ';
    strSQL := strSQL + '    I.ITE_CODFOR,     ';
    strSQL := strSQL + '    F.FOR_NOMFOR,     ';
    strSQL := strSQL + '    I.ITE_CODGRU,     ';
    strSQL := strSQL + '    L.GRU_DESGRU,     ';
    strSQL := strSQL + '    A.ABF_CODSIT_ENT_PEJ,     ';

    strSQL := strSQL + '( ';
    strSQL := strSQL + '  SELECT          ';
    strSQL := strSQL + '    IPR_PREVEN    ';
    strSQL := strSQL + '  FROM            ';
    strSQL := strSQL + '    CADPRO,       ';
    strSQL := strSQL + '    PROEMP,       ';
    strSQL := strSQL + '    ITEPRO        ';
    strSQL := strSQL + '  WHERE           ';
    strSQL := strSQL + '    CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER AND ';
    strSQL := strSQL + '    PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM AND ';
    strSQL := strSQL + '    PROEMP.PRO_CODEMP = G.ITE_CODEMP      AND ';
    strSQL := strSQL + '           IPR_CODITE = G.ITE_CODITE      AND ';
    strSQL := strSQL + '    ' + fCurrentDate + ' BETWEEN PRO_DTAINI AND PRO_DTAFIN ';
    strSQL := strSQL + '  ORDER BY        ';
    strSQL := strSQL + '    PRO_DTAINI,   ';
    strSQL := strSQL + '    PRO_DTAFIN    ';
    strSQL := strSQL + '  LIMIT 1         ';
    strSQL := strSQL + ') AS ITE_PREPRO,  ';

    strSQL := strSQL + ' CAST((';
    strSQL := strSQL + '  SELECT          ';
    strSQL := strSQL + '    PRO_DTAFIN    ';
    strSQL := strSQL + '  FROM            ';
    strSQL := strSQL + '    CADPRO,       ';
    strSQL := strSQL + '    PROEMP,       ';
    strSQL := strSQL + '    ITEPRO        ';
    strSQL := strSQL + '  WHERE           ';
    strSQL := strSQL + '    CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER AND ';
    strSQL := strSQL + '    PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM AND ';
    strSQL := strSQL + '    PROEMP.PRO_CODEMP = G.ITE_CODEMP      AND ';
    strSQL := strSQL + '           IPR_CODITE = G.ITE_CODITE      AND ';
    strSQL := strSQL + '    ' + fCurrentDate + ' BETWEEN PRO_DTAINI AND PRO_DTAFIN ';
    strSQL := strSQL + '  ORDER BY        ';
    strSQL := strSQL + '    PRO_DTAINI,   ';
    strSQL := strSQL + '    PRO_DTAFIN    ';
    strSQL := strSQL + '  LIMIT 1)        ';
    strSQL := strSQL + ' AS DATE) ITE_VALPRO,  ';


    strSQL := strSQL + ' CAST((             ';
    strSQL := strSQL + '  SELECT            ';
    strSQL := strSQL + '    MAX(ALT_DTAALT) ';
    strSQL := strSQL + '  FROM              ';
    strSQL := strSQL + '    PREALT          ';
    strSQL := strSQL + '  WHERE             ';
    strSQL := strSQL + '    ALT_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '    ALT_CODEMP = G.ITE_CODEMP AND ';
    strSQL := strSQL + '    ALT_VE1ANT <> ALT_VE1ATU  AND ';
    strSQL := strSQL + '    ALT_VE1ATU <> 0)              ';
    strSQL := strSQL + ' AS DATE) ITE_DTAALT,  ';

    strSQL := strSQL + '    G.ITE_PREVE1, ';
    strSQL := strSQL + '    G.ITE_IPIENT, ';
    strSQL := strSQL + '    G.ITE_PRECUS, ';
    strSQL := strSQL + '    G.ITE_PREULT, ';
    strSQL := strSQL + '    G.ITE_IMPULT, ';
    strSQL := strSQL + '    G.ITE_DTAULT, ';
    strSQL := strSQL + '    G.ITE_MARBR1, ';
    strSQL := strSQL + '    G.ITE_PREMED, ';
    strSQL := strSQL + '    G.ITE_ESTMIN  ';

    strSQL := strSQL + ' FROM             ';
    strSQL := strSQL + '    CADITE I      ';

    strSQL := strSQL + '    INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + '                      AND  G.ITE_CODEMP = :CODEMP      ';

    If (fCfgSis('TIPABF') = '1') Then
      strSQL := strSQL + '  INNER JOIN ABFICM A ON A.ABF_CODABF = I.ITE_CODABF '
    Else
      strSQL := strSQL + '  INNER JOIN ABFICM A ON A.ABF_CODABF = G.ITE_CODABF ';

    strSQL := strSQL + '     LEFT JOIN CADFOR F ON F.FOR_CODFOR = I.ITE_CODFOR ';
    strSQL := strSQL + '     LEFT JOIN CADGRU L ON L.GRU_CODGRU = I.ITE_CODGRU ';

    strSQL := strSQL + ' WHERE            ';
    strSQL := strSQL + '    I.ITE_CODITE = :CODITE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtCodIte.Text;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      If Not IsEmpty Then
      Begin
        edtCodFab.Text := FieldByName('ITE_CODFAB').AsString;
        edtCodFor.Text := FieldByName('ITE_CODFOR').AsString;
        edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
        edtPreVen.Text := FormatFloat(',0.00', FieldByName('ITE_PREVE1').AsFloat);
        mskLinGru.Text := FieldByName('ITE_CODGRU').AsString;
        edtLinGru.Text := FieldByName('GRU_DESGRU').AsString;

        If fCfgSis('MARANA') = '1' Then
        Begin
          edtMargem.Text := FormatFloat('0.00',  FieldByName('ITE_MARBR1').AsFloat);

          edtMarPro.Text := FormatFloat(',0.00', fCalculaPrecoVenda(2,
                                                                    FieldByName('ITE_PRECUS').AsFloat,
                                                                    FieldByName('ITE_PREPRO').AsFloat, 0, 0, 0, 0, 0));
        End Else
        Begin
          edtMargem.Text := FormatFloat(',0.00', fCalculaPrecoVenda(2,
                                                                    FieldByName('ITE_IMPULT').AsFloat,
                                                                    FieldByName('ITE_PREVE1').AsFloat, 0, 0, 0, 0, 0));

          edtMarPro.Text := FormatFloat(',0.00', fCalculaPrecoVenda(2,
                                                                    FieldByName('ITE_IMPULT').AsFloat,
                                                                    FieldByName('ITE_PREPRO').AsFloat, 0, 0, 0, 0, 0))
        End;

        edtIPIEnt.Text := FormatFloat(',0.00', FieldByName('ITE_IPIENT').AsFloat);
        edtUltCom.Text := FormatFloat(',0.00', FieldByName('ITE_IMPULT').AsFloat);

        If (FieldByName('ITE_DTAULT').AsDateTime > 0) Then
          edtDtaUlt.Text := FormatDateTime('DD/MM/YYYY', FieldByName('ITE_DTAULT').AsDateTime)
        Else
          edtDtaUlt.Text := '';

        If (FieldByName('ITE_DTAALT').AsDateTime > 0) Then
          edtUltAlt.Text := FormatDateTime('DD/MM/YYYY', FieldByName('ITE_DTAALT').AsDateTime)
        Else
          edtUltAlt.Text := '';

        edtPrePro.Text := FormatFloat(',0.00', FieldByName('ITE_PREPRO').AsFloat);
        edtPraEnt.Text := FieldByName('ITE_DIAFOR').AsString;

        If (FieldByName('ITE_VALPRO').AsDateTime > 0) Then
          edtValPro.Text := FormatDateTime('dd/mm/yyyy', FieldByName('ITE_VALPRO').AsDateTime)
        Else
          edtValPro.Text := '';

        If (Pos(FieldByName('ABF_CODSIT_ENT_PEJ').AsString, CST_SUBSTITUICAO) > 0) Then
          edtSubsti.Text := 'SIM'
        Else
          edtSubsti.Text := 'NÃO';

        edtPreMed.Text := FormatFloat(',0.00', FieldByName('ITE_PREMED').AsFloat);
        edtEstMin.Text := FormatFloat('0.000', FieldByName('ITE_ESTMIN').AsFloat);
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  FreeAndNil(qryGen);
end;

procedure TfrmAnaliseCompras.pAjustaColunasMeses;
  Var
    intContador: Integer;
Begin
  pCalculaDatas;

  For intContador := 1 To intMesMostrar Do
    If Assigned(FindComponent('grdAnaComVENME' + intContador.ToString())) Then
      TcxGridDBColumn(FindComponent('grdAnaComVENME' + intContador.ToString())).Caption := 'Qt.Vendas ' + FormatDateTime('MM/YY', arrDatas[intContador].dtaDtaIni);

  grdAnaComMEDIA_.Caption := 'Média ' + intMesMedia.ToString() + ' meses';

  For intContador := intMesMostrar + 1 To 12 Do
    If Assigned(FindComponent('grdAnaComVENME' + intContador.ToString())) Then
      TcxGridDBColumn(FindComponent('grdAnaComVENME' + intContador.ToString())).Visible := False;
End;

procedure TfrmAnaliseCompras.pCalculaDatas;
  Var
    intContador: Integer;
    dtaDtaTmp: TDateTime;
Begin
  intMesMostrar := fCfgSis('ANAMOS', varInteger);
  intMesMedia   := fCfgSis('ANAMED', varInteger);
  blnPorMes     := fcfgSis('ANACMA') = 'M';

  If Not blnPorMes Then
  Begin
    intMesMostrar := 3;
    intMesMedia   := 3;
  End;

  arrDatas[0].dtaDtaIni := StrToDate('01' + '/' + fStrZero(MonthOf(VS_Date), 2) + '/' + fStrZero(YearOf(VS_Date), 4));
  arrDatas[0].dtaDtaFin := VS_Date;

  dtaDtaTmp := VS_Date;

  If blnPorMes Then
  Begin

    For intContador := 1 To intMesMostrar Do
    Begin
      dtaDtaTmp := IncMonth(dtaDtaTmp, -1);
      arrDatas[intContador].dtaDtaIni := StrToDate('01' + '/' + fStrZero(MonthOf(dtaDtaTmp), 2) + '/' + fStrZero(YearOf(dtaDtaTmp), 4));
      arrDatas[intContador].dtaDtaFin := StrToDate(fStrZero(DaysInMonth(dtaDtaTmp), 2) + '/' + fStrZero(MonthOf(dtaDtaTmp), 2) + '/' + fStrZero(YearOf(dtaDtaTmp), 4));
    End;

  End Else
  Begin
    dtaDtaTmp := IncMonth(dtaDtaTmp, -1);
    arrDatas[1].dtaDtaIni := StrToDate('01' + '/' + fStrZero(MonthOf(dtaDtaTmp), 2) + '/' + fStrZero(YearOf(dtaDtaTmp), 4));
    arrDatas[1].dtaDtaFin := StrToDate(fStrZero(DaysInMonth(dtaDtaTmp), 2) + '/' + fStrZero(MonthOf(dtaDtaTmp), 2) + '/' + fStrZero(YearOf(dtaDtaTmp), 4));

    dtaDtaTmp := IncYear(VS_Date, -1);
    arrDatas[2].dtaDtaIni := StrToDate('01' + '/' + fStrZero(MonthOf(dtaDtaTmp), 2) + '/' + fStrZero(YearOf(dtaDtaTmp), 4));
    arrDatas[2].dtaDtaFin := StrToDate(fStrZero(DaysInMonth(dtaDtaTmp), 2) + '/' + fStrZero(MonthOf(dtaDtaTmp), 2) + '/' + fStrZero(YearOf(dtaDtaTmp), 4));

    dtaDtaTmp := IncYear(VS_Date, -1);
    dtaDtaTmp := IncMonth(dtaDtaTmp, 1);
    arrDatas[3].dtaDtaIni := StrToDate('01' + '/' + fStrZero(MonthOf(dtaDtaTmp), 2) + '/' + fStrZero(YearOf(dtaDtaTmp), 4));
    arrDatas[3].dtaDtaFin := StrToDate(fStrZero(DaysInMonth(dtaDtaTmp), 2) + '/' + fStrZero(MonthOf(dtaDtaTmp), 2) + '/' + fStrZero(YearOf(dtaDtaTmp), 4));
  End;
End;

procedure TfrmAnaliseCompras.pRetornaDadosGrid;
  Var
    frmGravando: TfrmGravando;
Begin
  cdsDados.AfterScroll := Nil;

  TfrmGravando.fExecuta(fRetornaDadosGridPrg, frmGravando, 'Carregando dados, aguarde...');

  cdsDados.AfterScroll := pDadosAfterScroll;

  pDadosAfterScroll(cdsDados);
End;

Function TfrmAnaliseCompras.fRetornaDadosGridPrg(cxProgresso: TcxProgressBar): Boolean;
  Var
    qryDados : TUniQuery;
    intContador: Integer;
begin
  Result := True;

  Try

    qryDados := fCriaQuery(Self);

    With qryDados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetornaSQL);
      ParamByName('CODITE').AsString := edtCodIte.Text;

      Open;

      cdsDados.DisableControls;

      cdsDados.EmptyDataSet;

      cxProgresso.Properties.Max := qryDados.RecordCount;

      If Not IsEmpty Then
      Begin
        While Not Eof Do
        Begin
          cdsDados.Append;
          cdsDadosCODEMP.AsString := FieldByName('CODEMP').AsString;
          cdsDadosVENATU.AsFloat  := FieldByName('TOTVEN').AsFloat;
          cdsDadosESTATU.AsFloat  := FieldByName('SALDOS').AsFloat;
          cdsDadosPEDCOM.AsFloat  := FieldByName('PEDCOM').AsFloat;

          For intContador := 1 To intMesMostrar Do
            cdsDados.FieldByName('VENME' + intContador.ToString()).AsFloat := FieldByName('VENME' + intContador.ToString()).AsFloat;

          cdsDadosMEDIA_.AsFloat  := FieldByName('MEDIA_').AsFloat;
          cdsDadosSUGEST.AsFloat  := FieldByName('SUGEST').AsFloat;
          cdsDadosENTFUT.AsFloat  := FieldByName('ENTFUT').AsFloat;
          cdsDadosPMED_V.AsFloat  := FieldByName('PMED_V').AsFloat;
          cdsDadosSALDIS.AsFloat  := fRetornaSaldoDisponivel(edtCodIte.Text,
                                                                 False,
                                                                 True,
                                                                 '',
                                                                 True,
                                                                 FieldByName('CODEMP').AsString);;
          cdsDados.Post;
          Next;

          cxProgresso.Position := cxProgresso.Position + 1;
          Application.ProcessMessages;
        End;

        cdsDados.First;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
  FreeAndNil(qryDados);

  cdsDados.EnableControls;
end;

procedure TfrmAnaliseCompras.FormCreate(Sender: TObject);
begin
  inherited;
  blnENTFUT := ((Not fCfgSis('BEFTRG', VarBoolean)) Or (fUsaQtdPendenteEntregaFutura)); //Utilizando o mesmo padrão da untPesqItem.
  pSetaCodIte(edtCodIte);

  cdsDados.CreateDataSet;

  grdAnaComENTFUT.Visible := blnENTFUT;

  grdAnaComPMED_V.Visible := fCfgSis('RNPMVE', varBoolean);

  pAjustaColunasMeses;

  objCfgGri := TCfgGrid.Create(Self, grdAnaComView, 'Análise de Compras');
end;

procedure TfrmAnaliseCompras.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodIte);
end;

function TfrmAnaliseCompras.fRetornaSQL: String;
  Var
    intContador: Integer;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '  G.ITE_CODEMP                   AS CODEMP, ';
  Result := Result + '  (' + fSQLCamposQuantidadePendenteCompra(False {blnSoma}, Not chkTransf.Checked, False, 'SP') + ') AS PEDCOM, ';
  Result := Result + '  G.ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0,  G.ITE_SAL_ML / ITE_CNV_ML, 0) ';
  If blnENTFUT Then
    Result := Result + ' + ' + fGetSQLSomaCamposEntregaFutura('G', True);
  Result := Result + '    AS SALDOS, ';

  Result := Result + '  (' + fRetornaSQLVendas(0) + ') AS TOTVEN, ';

  For intContador := 1 To intMesMostrar Do
    Result := Result + '  (' + fRetornaSQLVendas(intContador) + ') AS VENME' + intContador.ToString() + ', ';

  Result := Result + '  (' + fRetornaSQLMedia     + ') AS MEDIA_, ';
  Result := Result + '  (' + fRetornaSQLSugestao  + ') AS SUGEST,  ';

  If blnENTFUT Then
    Result := Result + fGetSQLSomaCamposEntregaFutura('G', True) + ' AS ENTFUT, '
  Else
    Result := Result + ' 0.00 AS ENTFUT, ';

  Result := Result + '  G.ITE_PMED_V AS PMED_V ';

  Result := Result + 'FROM       ';
  Result := Result + '  ITEGER G  ';
  Result := Result + '  INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';

  Result := Result + '  LEFT JOIN SALPDC SP ON SP.SAL_CODITE = G.ITE_CODITE ';
  Result := Result + '                     AND SP.SAL_CODEMP = G.ITE_CODEMP ';
  Result := Result + 'WHERE      ';
  Result := Result + '  G.ITE_CODITE = :CODITE ';
end;

function TfrmAnaliseCompras.fRetornaSQLMedia: String;
  Var
    intContador: Integer;
begin
  Result := '';
  Result := Result + '((0 ';

  For intContador := 1 To intMesMedia Do
    Result := Result + ' + (' + fRetornaSQLVendas(intContador) + ') ';

  Result := Result  +  ') / ' + intMesMedia.ToString + ') ';
end;

function TfrmAnaliseCompras.fRetornaSQLSugestao: String;
begin
  Result := '';
  Result := Result + '(' + fRetornaSQLMedia +
                             ' - ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0,  G.ITE_SAL_ML / ITE_CNV_ML, 0) - ' +
                             '(' +  fSQLCamposQuantidadePendenteCompra(False {blnSoma}, False, False, 'SP') + ')' + ')';
end;

function TfrmAnaliseCompras.fRetornaSQLVendas(intTip: Integer): String;
Begin
  Result := fRetornaSQLVendasGirIte(intTip);
End;

function TfrmAnaliseCompras.fRetornaSQLVendasGirIte(intTip: Integer): String;
  Var
    strSQL    : String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + ' IFNULL(GIR_QSAI' + RightStr('0' + IntToStr(MonthOf(arrDatas[intTip].dtaDtaIni)), 2) + ',0) AS VENDAS ';
  strSQL := strSQL + 'FROM       ';
  strSQL := strSQL + '  GIRITE ';
  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '  GIR_CODITE = G.ITE_CODITE AND ';
  strSQL := strSQL + '  GIR_CODEMP = G.ITE_CODEMP AND ';
  strSQL := strSQL + '  GIR_A_N_O_ = ' + QuotedStr(IntToStr(YearOf(arrDatas[intTip].dtaDtaIni))) + ' ';

  Result := strSQL;
End;

end.

