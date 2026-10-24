unit untTrocaVendTemp;

interface

uses
  Windows, Classes, Controls, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Uni, ComCtrls, AppEvnts, QColorLabel, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Vcl.Mask, MaskEditFocus, StrUtils, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, UITypes,
  cxGridTableView, cxGridDBTableView, cxGrid, UniClientDataSet, Graphics, Variants;

type
  TfrmTrocaVendTemp = class(TfrmPai)
    pnlFundo: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label3: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    Label5: TLabel;
    edtEstado: TEditFocus;
    Label6: TLabel;
    edtStatus: TEditFocus;
    ColorLabel1: TColorLabel;
    Label7: TLabel;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    Label10: TLabel;
    edtDiaCon: TEditFocus;
    Label11: TLabel;
    btnConfirma: TBitBtnLocked;
    grpModoConsidVendaCli: TGroupBox;
    grpPeriodoVendas: TGroupBox;
    chkPeriodoVendas: TCheckBox;
    grpDiasNaoCompra: TGroupBox;
    lblNaoCompraAcima: TLabel;
    lblDias: TLabel;
    edtNaoCompraAcima: TEditFocus;
    chkDiasNaoCompra: TCheckBox;
    lblVlrMinFat: TLabel;
    edtVlrMinFat: TEditFocus;
    lblQtdMinDocVen: TLabel;
    edtQtdMinDocVen: TEditFocus;
    lblPeriodoFat: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label8: TLabel;
    lblVenAtu: TLabel;
    lblVenTemp: TLabel;
    lblPeriodoVig: TLabel;
    lblAte: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    edtCodVenTemp: TEditFocus;
    edtDesVenTemp: TEditFocus;
    mskDtaIniVig: TMaskEditFocus;
    mskDtaFinVig: TMaskEditFocus;
    rdgOpcao: TRadioGroup;
    cxConsulta: TcxGrid;
    cxConsultaView: TcxGridDBTableView;
    cxConsultaNivel: TcxGridLevel;
    dtsConsulta: TDataSource;
    cxConsultaViewCLI_CODCLI: TcxGridDBColumn;
    cxConsultaViewCLI_NOMCLI: TcxGridDBColumn;
    cxConsultaViewCLI_CODVEN: TcxGridDBColumn;
    cxConsultaViewMARDES: TcxGridDBColumn;
    btnMarcarTodos: TBitBtnLocked;
    cxConsultaViewCVE_CODVEN: TcxGridDBColumn;
    cxConsultaViewCVE_DTVGIN: TcxGridDBColumn;
    cxConsultaViewCVE_DTVGFN: TcxGridDBColumn;
    cxConsultaViewCID_NOMCID: TcxGridDBColumn;
    cxConsultaViewCID_ESTADO: TcxGridDBColumn;
    Label2: TLabel;
    btnPesquisar: TBitBtnLocked;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure chkDiasNaoCompraClick(Sender: TObject);
    procedure chkPeriodoVendasClick(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenTempKeyPress(Sender: TObject; var Key: Char);
    procedure cxConsultaViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxConsultaViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure rdgOpcaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryConsulta : TUniQuery;
    qryConCli: TUniQuery;
    qryConOpe: TUniQuery;
    cdsConsulta: TUniClientDataSet;

    procedure pConsultaClientes;
    procedure pCarregaCliente;
    procedure pCarregaVendedor(edtCodigo, edtNome: TEditFocus);
    procedure pIniciarComponentesTela;
    procedure pEventoCheckBox;
    function fSelectVendas: String;
    Function fSQLFromMovDet: String;
    Procedure pSetaParamMovDet(qryMovDet: TUniQuery; dtaDtaIni, dtaDtaFim: TDate);
    function fAdicionarVendedorTemporario: Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses SysUtils, Forms, untConsultas, untfuncoesSimples, untPesqAux, untTypesSistema,
  untPanelCxClientes, untPnlDadosCliente, untCadClientes, untConstantes,
  untGravando;

{$R *.dfm}

procedure TfrmTrocaVendTemp.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
    objfrmPnl  : TPanelCxClientes;
begin
  objfrmPnl := TPanelCxClientes.Create(TfrmPnlDadosCliente);

  If fPesqCliente(conCliCompleta, Self, edtCodCli, edtNomCli, qryTabela, Key, arrClientes, True, objfrmPnl) And (Not edtCodCli.ReadOnly) Then
  Begin
    If (fValidaCampos(edtCodCli, True)) and (blnMudarFoco) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(objfrmPnl);
end;

procedure TfrmTrocaVendTemp.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmTrocaVendTemp.FormCreate(Sender: TObject);
begin
  inherited;
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);

  pIniciarComponentesTela();
end;

procedure TfrmTrocaVendTemp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F5 Then
    btnMarcarTodos.Click;
end;

procedure TfrmTrocaVendTemp.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIniVig);
end;

function TfrmTrocaVendTemp.fSQLFromMovDet: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + '  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  strSQL := strSQL + 'WHERE    ';

  strSQL := strSQL + '  DET_CODEMP = :CODEMP                     AND ';
  strSQL := strSQL + '  DET_PROEMB <> "S"                        AND ';
  strSQL := strSQL + '  DET_TIP_FC = "C"                         AND ';
  strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
  strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN   AND ';

  If Not fEmptyStr(edtCodCli.Text) Then
    strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';

  strSQL := strSQL + cnsFiltroFFDVTR;

  strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';

  If (fCfgSis('ENTBRF', varBoolean)) Then
    strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
  Else
    strSQL := strSQL + ') ';

  Result := strSQL;
End;

function TfrmTrocaVendTemp.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCodCli) Then
  Begin

    If Not fEmptyStr(edtCodCli.Text) Then
    Begin

      pCarregaCliente;

      If fEmptyStr(edtNomCli.Text) Then
      Begin
        fMensagem('','Cliente não encontrado!',['&OK']);
        Result := False;
      End;

    End
    Else
    Begin
      edtNomCli.Text := 'TODOS';
    End;

  End

  Else If (Sender = edtCodAti) Then
  Begin
    If Not fEmptyStr(edtCodAti.Text) Then
    Begin
      edtDesAti.Text := fCampoTabela('ATI_DESATI','CADATI',['ATI_CODATI'],[edtCodAti.Text]);
      If fEmptyStr(edtDesAti.Text) Then
      Begin
        fMensagem('','Atividade não cadastrada!',['&Ok']);
        Result := False;
      End;
    End
    Else
      edtDesAti.Text := 'TODOS';

    If Result And (rdgOpcao.ItemIndex = 1) Then
      pConsultaClientes;
  End

  Else If (Sender = edtNaoCompraAcima) Or (Sender = edtDiaCon) Then
  Begin
    If fStrToFloat(TEditFocus(Sender).Text) < 0 Then
    Begin
      fMensagem('','A quantidade de dias deve ser maior ou igual à zero!',['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtQtdMinDocVen) Then
  Begin
    If fStrToFloat(TEditFocus(Sender).Text) < 0 Then
    Begin
      fMensagem('','A quantidade de documentos de venda deve ser maior ou igual à zero!',['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtVlrMinFat) Then
  Begin
    If fStrToFloat(TEditFocus(Sender).Text) < 0 Then
    Begin
      fMensagem('','O valor mínimo de faturamento deve ser maior ou igual à zero!',['&Ok']);
      Result := False;
    End;
  End

  Else If ((Sender = mskDtaIni) Or (Sender = mskDtaFin)) And (chkPeriodoVendas.Checked) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      If (Sender = mskDtaFin) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&OK']);
            Result := False;
          End;
        End;
      End
    End;
  End

  Else If ((Sender = mskDtaIniVig) Or (Sender = mskDtaFinVig)) And (rdgOpcao.ItemIndex = 0) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskDtaIniVig.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial de Vigência deve ser preenchido!', ['&OK']);
      Result := False;
    End
    Else
    Begin
      If (Sender = mskDtaFinVig) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFinVig.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final de Vigência deve ser preenchido!', ['&OK']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIniVig.Text) > StrToDate(mskDtaFinVig.Text) Then
          Begin
            fMensagem('','A data inicial de Vigência deve ser menor que a data final!',['&OK']);
            Result := False;
          End;
        End;
      End
    End;
  End

  Else If (Sender = edtCodVen) Then
  Begin
    If not fEmptyStr(edtCodVen.Text) Then
    Begin
      pCarregaVendedor(edtCodVen, edtDesVen);

      If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&OK']);
        Result := False;
      End;
    End
    Else
      edtDesVen.Text := 'TODOS';

  End

  Else If (Sender = edtCodVenTemp) Then
  Begin

    If fEmptyStr(edtCodVenTemp.Text) And (rdgOpcao.ItemIndex = 0) Then
    Begin
      fMensagem('','O Vendedor Temporário deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin
      If (Not fEmptyStr(edtCodVen.Text))     And
         (Not fEmptyStr(edtCodVenTemp.Text)) And
         (SameText(edtCodVen.Text, edtCodVenTemp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Vendedor Temporário deve ser diferente do Vendedor Atual!', ['&OK']);
        Result := False;
      End
      Else If (Not fEmptyStr(edtCodVenTemp.Text)) Then
      Begin
        pCarregaVendedor(edtCodVenTemp, edtDesVenTemp);

        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End
      Else If (rdgOpcao.ItemIndex = 1) Then
        edtDesVenTemp.Text := 'TODOS';

    End;
  End

  Else If (Sender = edtCodCid) Then
  Begin

    If Not fEmptyStr(edtCodCid.Text) Then
    Begin
      edtNomCid.Text := fRetNomCidade(edtCodCid.Text);
      edtEstado.Text := fRetNomCidade(edtCodCid.Text,1);
      If fEmptyStr(edtNomCid.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta cidade não está cadastrada!', ['&O k']);
        Result := False;
      End;
    End
    Else
    Begin
      edtNomCid.Text := 'TODAS';
      edtEstado.Clear;
    End;

  End

  Else If (Sender = edtStatus) Then
  Begin
    If Pos(edtStatus.Text, 'A_I_T_') <= 0 Then
    Begin
      fMensagem('','O status do cliente deve ser (A)tivo, (I)nativo ou (T)odos!',['&Ok']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmTrocaVendTemp.edtCodVenKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqOperador(Self, edtCodVen, edtDesVen, qryConOpe, Key, arrSel) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTrocaVendTemp.edtCodVenTempKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqOperador(Self, edtCodVenTemp, edtDesVenTemp, qryConOpe, Key, arrSel) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTrocaVendTemp.pCarregaVendedor(edtCodigo, edtNome: TEditFocus);
begin

  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodigo.Text);

  With qryConOpe Do
    edtNome.Text := FieldByName('OPE_NOMOPE').AsString;

end;

procedure TfrmTrocaVendTemp.pEventoCheckBox;
begin
  chkPeriodoVendas.Checked := (Not chkDiasNaoCompra.Checked) And (chkPeriodoVendas.Checked);
  edtQtdMinDocVen.Enabled  := (chkPeriodoVendas.Checked);
  edtVlrMinFat.Enabled     := (chkPeriodoVendas.Checked);
  mskDtaIni.Enabled        := (chkPeriodoVendas.Checked);
  mskDtaFin.Enabled        := (chkPeriodoVendas.Checked);

  edtQtdMinDocVen.Text  := '0';
  edtVlrMinFat.Text     := '0,00';
  mskDtaIni.Text        := '__/__/____';
  mskDtaFin.Text        := '__/__/____';

  chkDiasNaoCompra.Checked  := (chkDiasNaoCompra.Checked) And (Not chkPeriodoVendas.Checked);
  edtNaoCompraAcima.Enabled := (chkDiasNaoCompra.Checked);

  edtNaoCompraAcima.Text    := '0';
end;

procedure TfrmTrocaVendTemp.pIniciarComponentesTela;
begin
  edtCodVen.Clear;
  edtDesVen.Clear;
  edtCodVenTemp.Clear;
  edtDesVenTemp.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodCid.Clear;
  edtNomCid.Clear;
  edtEstado.Clear;
  edtCodAti.Clear;
  edtDesAti.Clear;

  chkPeriodoVendas.Checked := False;
  edtQtdMinDocVen.Enabled  := False;
  edtVlrMinFat.Enabled     := False;
  mskDtaIni.Enabled        := False;
  mskDtaFin.Enabled        := False;

  edtQtdMinDocVen.Text  := '0';
  edtVlrMinFat.Text     := '0,00';
  mskDtaIni.Text        := '__/__/____';
  mskDtaFin.Text        := '__/__/____';

  chkDiasNaoCompra.Checked  := True;
  edtNaoCompraAcima.Enabled := True;

  edtNaoCompraAcima.Text    := '0';

  If rdgOpcao.ItemIndex = 0 Then
  Begin
    mskDtaIniVig.Enabled := True;
    mskDtaIniVig.Color   := clWindow;
    mskDtaIniVig.NormalColor := clWindow;

    mskDtaFinVig.Enabled := True;
    mskDtaFinVig.Color   := clWindow;
    mskDtaFinVig.NormalColor := clWindow;

    edtDiaCon.Enabled := True;
    edtDiaCon.Color   := clWindow;
    edtDiaCon.NormalColor := clWindow;

    edtNaoCompraAcima.Enabled := True;
    edtNaoCompraAcima.Color   := clWindow;
    edtNaoCompraAcima.NormalColor := clWindow;

    mskDtaIni.Enabled := True;
    mskDtaIni.Color   := clWindow;
    mskDtaIni.NormalColor := clWindow;

    mskDtaFin.Enabled := True;
    mskDtaFin.Color   := clWindow;
    mskDtaFin.NormalColor := clWindow;

    edtQtdMinDocVen.Enabled := True;
    edtQtdMinDocVen.Color   := clWindow;
    edtQtdMinDocVen.NormalColor := clWindow;

    edtVlrMinFat.Enabled := True;
    edtVlrMinFat.Color   := clWindow;
    edtVlrMinFat.NormalColor := clWindow;

    edtStatus.Enabled := True;
    edtStatus.Color   := clWindow;
    edtStatus.NormalColor := clWindow;

    grpModoConsidVendaCli.Enabled := True;
  End
  Else
  Begin
    mskDtaIniVig.Clear;
    mskDtaFinVig.Clear;

    mskDtaIniVig.Enabled := False;
    mskDtaIniVig.Color := $00FFE4D5;
    mskDtaIniVig.NormalColor := $00FFE4D5;

    mskDtaFinVig.Enabled := False;
    mskDtaFinVig.Color := $00FFE4D5;
    mskDtaFinVig.NormalColor := $00FFE4D5;

    edtDiaCon.Enabled := False;
    edtDiaCon.Color   := $00FFE4D5;
    edtDiaCon.NormalColor := $00FFE4D5;

    edtNaoCompraAcima.Enabled := False;
    edtNaoCompraAcima.Color   := $00FFE4D5;
    edtNaoCompraAcima.NormalColor := $00FFE4D5;

    mskDtaIni.Enabled := False;
    mskDtaIni.Color   := $00FFE4D5;
    mskDtaIni.NormalColor := $00FFE4D5;

    mskDtaFin.Enabled := False;
    mskDtaFin.Color   := $00FFE4D5;
    mskDtaFin.NormalColor := $00FFE4D5;

    edtQtdMinDocVen.Enabled := False;
    edtQtdMinDocVen.Color   := $00FFE4D5;
    edtQtdMinDocVen.NormalColor := $00FFE4D5;

    edtVlrMinFat.Enabled := False;
    edtVlrMinFat.Color   := $00FFE4D5;
    edtVlrMinFat.NormalColor := $00FFE4D5;

    edtStatus.Enabled := False;
    edtStatus.Color   := $00FFE4D5;
    edtStatus.NormalColor := $00FFE4D5;

    grpModoConsidVendaCli.Enabled := False;

    pSetFocus(edtCodVen);
  End;

  If Assigned(cdsConsulta) Then
    cdsConsulta.EmptyDataset;
end;


function TfrmTrocaVendTemp.fSelectVendas: String;
  Var
    strSQL       : String;
    strSQLUnion  : String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  DET_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  COUNT(*) AS QTDDOC, ';
  strSQL := strSQL + '  SUM(IF(DET_CONPAG = "01000" AND DET_ESPDOC NOT IN ("TR","DV") AND LEFT(DET_CLAFIS,1) >= 5, IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)),0.00)) AS VENVIS, ';
  strSQL := strSQL + '  SUM(IF(DET_CONPAG<> "01000" AND DET_ESPDOC NOT IN ("TR","DV") AND LEFT(DET_CLAFIS,1) >= 5, IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)),0.00)) AS VENPRA, ';
  strSQL := strSQL + '  SUM(IF(DET_ESPDOC IN ("TR","DV") OR LEFT(DET_CLAFIS,1) < 5, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE-DET_DESESP-DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF),0.00)) AS VENDEV, ';
  strSQL := strSQL + '  SUM(IF(DET_CONPAG = "01000", (IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)), 0)) AS AVIDIA, ';
  strSQL := strSQL + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)) AS VENDIA ';

  strSQL := strSQL + fSQLFromMovDet;

  strSQL := strSQL + ' GROUP BY     ';
  strSQL := strSQL + '   DET_CODCLI ';

  strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

  strSQLUnion := strSQL;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  CODCLI, ';
  strSQL := strSQL + '  QTDDOC, ';
  strSQL := strSQL + '  SUM(VENVIS) AS VENVIS, ';
  strSQL := strSQL + '  SUM(VENPRA) AS VENPRA, ';
  strSQL := strSQL + '  SUM(VENDEV) AS VENDEV, ';
  strSQL := strSQL + '  SUM(AVIDIA) AS AVIDIA, ';
  strSQL := strSQL + '  SUM(VENDIA) AS VENDIA  ';
  strSQL := strSQL + 'FROM   ';
  strSQL := strSQL + '(';

  strSQL := strSQL +  strSQLUnion;

  strSQL := strSQL + ') AS TMP_TABELA ';

  strSQL := strSQL + ' GROUP BY    ';
  strSQL := strSQL + '   CODCLI    ';

  Result := ' (' + strSQL + ') AS TMP_VENDAS ';
End;

procedure TfrmTrocaVendTemp.pSetaParamMovDet(qryMovDet: TUniQuery; dtaDtaIni,
  dtaDtaFim: TDate);
begin
  With qryMovDet Do Begin
    ParamByName('DTAINI').AsDate   := dtaDtaIni;
    ParamByName('DTAFIN').AsDate   := dtaDtaFim;
    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('CLADEV').AsString := VS_strClaDev;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    If Not fEmptyStr(edtCodCli.Text) Then
      ParamByName('CODCLI').AsString := edtCodCli.Text;

  End;
end;

procedure TfrmTrocaVendTemp.rdgOpcaoClick(Sender: TObject);
begin
  inherited;
  pIniciarComponentesTela;
end;

procedure TfrmTrocaVendTemp.btnConfirmaClick(Sender: TObject);

  function fSelecionados: Boolean;
  Begin
    With cdsConsulta Do
    Begin
      Filtered := False;
      Filter   := 'MARDES = ''S'' ';
      Filtered := True;
      Result   := (RecordCount > 0);
      Filtered := False;
    End;
  End;

Begin
  If assigned(cdsConsulta) Then
    If not cdsConsulta.IsEmpty Then
    Begin
      If (fVerificaCampos()) Then
        If fSelecionados Then
        Begin
          If (fMensagem('', 'Deseja confirmar a operação?', ['&Sim', '&Não'], 1) = 1) Then
          Begin

            If fAdicionarVendedorTemporario Then
            Begin
              fMensagem('','Processo efetuado com sucesso!',['&OK']);
              Close;
            End;
          End;
        End
        Else
          fMensagem('','Nenhum registro foi selecionado!',['&OK']);
    End;

end;

procedure TfrmTrocaVendTemp.edtCodCidKeyPress(Sender: TObject; var Key: Char);
Var
  arrCidade: TConsultasArray;
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtNomCid, edtEstado, Nil, Key, arrCidade) Then
  Begin
    if fValidaCampos(edtCodCid, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTrocaVendTemp.btnMarcarTodosClick(Sender: TObject);
var strMardes: String;
begin
  inherited;
  If assigned(cdsConsulta) Then
    With cdsConsulta Do
    Begin
      First;
      DisableControls;
      strMardes := IIF(FieldByName('MARDES').AsString = 'N','S','N');
      While not eof Do
      Begin
        Edit;
        FieldByName('MARDES').AsString := strMardes;
        Post;

        Next;
      End;
      First;
      EnableControls;
    End;
end;

procedure TfrmTrocaVendTemp.chkDiasNaoCompraClick(Sender: TObject);
begin
  inherited;

  chkPeriodoVendas.OnClick := nil;
  chkPeriodoVendas.Checked := (Not chkPeriodoVendas.Checked);
  pEventoCheckBox();
  chkPeriodoVendas.OnClick := chkPeriodoVendasClick;
end;

procedure TfrmTrocaVendTemp.chkPeriodoVendasClick(Sender: TObject);
begin
  inherited;

  chkDiasNaoCompra.OnClick := nil;
  chkDiasNaoCompra.Checked := (Not chkDiasNaoCompra.Checked);
  pEventoCheckBox();
  chkDiasNaoCompra.OnClick := chkDiasNaoCompraClick;
end;

procedure TfrmTrocaVendTemp.cxConsultaViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var Result: Boolean;
begin
  inherited;
  Result := (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                                   cxConsultaView.GetColumnByFieldName('MARDES').Index]) = 'S');

  If Result Then
  Begin
    If ACanvas.Brush.Color = clHighlight Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Brush.Color := clAqua;
  End;
end;

procedure TfrmTrocaVendTemp.cxConsultaViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    If Assigned(cdsConsulta) Then
    Begin
      With cdsConsulta Do
      Begin
        If not isEmpty Then
        Begin
          Edit;
          FieldByName('MARDES').AsString := IIF(FieldByName('MARDES').AsString = 'N','S','N');
          Post;
        End;
      End;
    End;
  End;
end;

procedure TfrmTrocaVendTemp.edtCodAtiKeyPress(Sender: TObject; var Key: Char);
Var
  arrAtiv: TConsultasArray;
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrAtiv) Then
  Begin
    If fValidaCampos(edtCodAti, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTrocaVendTemp.pConsultaClientes;
Var  strSQL  : String;

begin
  Self.Enabled := False;
  qryConsulta := fCriaQuery;

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    If rdgOpcao.ItemIndex = 0 Then
      strSQL := strSQL + ' CLI_CODCLI, CLI_NOMCLI, CLI_CODVEN, CID_NOMCID, CID_ESTADO, "S" AS MARDES  '
    Else
      strSQL := strSQL + ' CLI_CODCLI, CLI_NOMCLI, CLI_CODVEN, CID_NOMCID, CID_ESTADO, CVE_CODMAR, CVE_CODVEN, CVE_DTVGIN, CVE_DTVGFN, CLIVEN.AUTOINCREM, "S" AS MARDES ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CADCID.CID_CODCID = CADCLI.CLI_CODCID ';

    If rdgOpcao.ItemIndex = 1 Then
      strSQL := strSQL + '  INNER JOIN CLIVEN ON CLIVEN.CVE_CODCLI = CADCLI.CLI_CODCLI ';

    If (rdgOpcao.ItemIndex = 0) And (chkPeriodoVendas.Checked) Then
      strSQL := strSQL + '  INNER JOIN ' + fSelectVendas() + ' ON CADCLI.CLI_CODCLI = TMP_VENDAS.CODCLI ';

    strSQL := strSQL + 'WHERE  ';
    strSQL := strSQL + '  TRUE ';

    If (rdgOpcao.ItemIndex = 0) And (Not fEmptyStr(edtCodVenTemp.Text)) Then
    Begin
      strSQL := strSQL + '  AND NOT EXISTS (SELECT AUTOINCREM FROM CLIVEN ';
      strSQL := strSQL + '                  WHERE CLIVEN.CVE_CODCLI = CADCLI.CLI_CODCLI ';
      strSQL := strSQL + '                    AND CLIVEN.CVE_CODVEN = "' + edtCodVenTemp.Text + '") ';
    End;

    If Not fEmptyStr(edtCodVen.Text) Then
      strSQL := strSQL + '  AND CLI_CODVEN = "' + edtCodVen.Text + '" ';

    If (rdgOpcao.ItemIndex = 1) And (Not fEmptyStr(edtCodVenTemp.Text)) Then
      strSQL := strSQL + '  AND CVE_CODVEN = "' + edtCodVenTemp.Text + '" ';

    If Not fEmptyStr(edtCodCli.Text) Then
      strSQL := strSQL + '  AND CLI_CODCLI = "' + edtCodCli.Text + '" ';

    If Not fEmptyStr(edtCodCid.Text) Then
      strSQL := strSQL + '  AND CLI_CODCID = "' + edtCodCid.Text + '" ';

    If Not fEmptyStr(edtCodAti.Text) Then
      strSQL := strSQL + '  AND CLI_CODATI = "' + edtCodAti.Text + '" ';

    If edtStatus.Text <> 'T' Then
      strSQL := strSQL + '  AND CLI_STATUS = "' + edtStatus.Text + '" ';

    If (chkDiasNaoCompra.Checked) And (fStrToFloat(edtNaoCompraAcima.Text) > 0) Then
    Begin
      strSQL := strSQL + '  AND CLI_ULTCOM IS NOT NULL ';
      strSQL := strSQL + '  AND CLI_ULTCOM < DATE_SUB(' + fCurrentDate + ', INTERVAL ' + edtNaoCompraAcima.Text + ' DAY) ';
    End;

    If (chkPeriodoVendas.Checked) And (rdgOpcao.ItemIndex = 0)  Then
    Begin
      If fStrToFloat(edtQtdMinDocVen.Text) > 0 Then
        strSQL := strSQL + '  AND TMP_VENDAS.QTDDOC >= :QTDDOC ';

      If fStrToFloat(edtVlrMinFat.Text) > 0 Then
        strSQL := strSQL + '  AND (TMP_VENDAS.VENVIS + TMP_VENDAS.VENPRA + TMP_VENDAS.VENDEV + TMP_VENDAS.AVIDIA + TMP_VENDAS.VENDIA) >= :VALFAT ';
    End;

    If fStrToFloat(edtDiaCon.Text) > 0 Then
    Begin
      strSQL := strSQL + '  AND (SELECT AGE_DTABAI FROM AGETEL WHERE AGE_CODCLI = CLI_CODCLI AND AGE_DTABAI IS NOT NULL ORDER BY AGE_DTABAI DESC LIMIT 1) ';
      strSQL := strSQL + '       < DATE_SUB(' + fCurrentDate + ', INTERVAL ' + edtDiaCon.Text + ' DAY) ';
    End;

    With qryConsulta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (chkPeriodoVendas.Checked) And (rdgOpcao.ItemIndex = 0) And (fStrToFloat(edtQtdMinDocVen.Text) > 0) Then
        ParamByName('QTDDOC').AsFloat := fStrToFloat(edtQtdMinDocVen.Text);

      If (chkPeriodoVendas.Checked And (rdgOpcao.ItemIndex = 0) ) And (fStrToFloat(edtVlrMinFat.Text) > 0) Then
        ParamByName('VALFAT').AsFloat := fStrToFloat(edtVlrMinFat.Text);

      If (chkPeriodoVendas.Checked) And (rdgOpcao.ItemIndex = 0) Then
        pSetaParamMovDet(qryConsulta, StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text));

      Open;

      cdsConsulta := fCriaClientDatset(qryConsulta, False);
      pSetaClient(cdsConsulta);
      dtsConsulta.DataSet := cdsConsulta;

    End;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmTrocaVendTemp.pConsultaClientes]');
      FreeAndNil(qryConsulta);
    End;

  End;

  Self.Enabled := True;
  pnlInfo.Caption := '';
  SelectFirst;

  If not cdsConsulta.isEmpty Then
    pSetFocus(cxConsulta)
  Else
    fMensagem('','Não foi possível localizar registros.'+#13+
                 'Só será exibido clientes onde o vendedor temp. não estiver vinculado.'+#13+
                 'Verifique os filtros !',['&OK']);


end;

function TfrmTrocaVendTemp.fAdicionarVendedorTemporario: Boolean;
Var
  blnTransacao: Boolean;
  qryCliVen: TUniQuery;

  function fGetSQLCliVen: String;
  begin
    Result := 'INSERT INTO CLIVEN (AUTOINCREM, CVE_CODCLI, CVE_CODMAR, CVE_CODVEN, CVE_DTVGIN, CVE_DTVGFN, CVE_CODFOR) ' +
              'VALUES (:AUTINC, :CODCLI, :CODMAR, :CODVEN, :DTVGIN, :DTVGFN, :CODFOR)';
  end;

  function fGetSQLExcluirCliVen: String;
  begin
    Result := 'DELETE FROM CLIVEN WHERE AUTOINCREM = :AUTINC';
  end;

  procedure pAdicionarRegistro;
  begin
    If (Not Assigned(qryCliVen)) Then
      qryCliVen := fCriaQuery(nil);

    qryCliVen.Close();
    qryCliVen.SQL.Clear();
    qryCliVen.SQL.Text := fGetSQLCliVen();
    qryCliVen.ParamByName('AUTINC').AsString   := fRetAutoIncrem('CLIVEN', VS_strCodEmp);
    qryCliVen.ParamByName('CODCLI').AsString   := cdsConsulta.FieldByName('CLI_CODCLI').AsString;
    qryCliVen.ParamByName('CODMAR').Clear();
    qryCliVen.ParamByName('CODFOR').Clear();
    qryCliVen.ParamByName('CODVEN').AsString   := edtCodVenTemp.Text;
    qryCliVen.ParamByName('DTVGIN').AsDateTime := Trunc(StrToDateTime(mskDtaIniVig.Text));
    qryCliVen.ParamByName('DTVGFN').AsDateTime := Trunc(StrToDateTime(mskDtaFinVig.Text));
    qryCliVen.ExecSQL();
  end;

  procedure pRemoverRegistro;
  begin
    If (Not Assigned(qryCliVen)) Then
      qryCliVen := fCriaQuery(nil);

    qryCliVen.Close();
    qryCliVen.SQL.Clear();
    qryCliVen.SQL.Text := fGetSQLExcluirCliVen();
    qryCliVen.ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
    qryCliVen.ExecSQL();
  end;

begin
  Result := False;
  blnTransacao := fInTransaction();

  Try
    qryCliVen   := nil;

    Try
      If (Not blnTransacao) Then
        fStartTransaction();

      With cdsConsulta Do
      Begin
        While Not Eof Do
        Begin
          If FieldByName('MARDES').AsString = 'S' Then
          Begin
            If (rdgOpcao.ItemIndex = 0) Then
              pAdicionarRegistro
            Else
              pRemoverRegistro;
          End;

          Next;
        End;
      End;

      If (Not blnTransacao) Then
        fCommit();

      Result := True;
    Except
      On E: Exception Do
      Begin
        fRollback();
				pMensagensErro(E.Message,'[TfrmTrocaVendTemp.fAdicionarVendedorTemporario]');
      End;
    End;
  Finally
    FreeAndNil(qryCliVen);
  End;
end;

procedure TfrmTrocaVendTemp.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos()) Then
    TfrmGravando.fExecutarModal(pConsultaClientes, 'Aguarde... Carregando registros.','');
end;


end.
