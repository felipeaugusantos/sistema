unit untConfOrdProd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Uni, UniClientDataSet, cxProgressBar, cxGridCustomPopupMenu,
  cxGridPopupMenu, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmConfOrdProd = class(TfrmPai)
    btnBuscar: TBitBtnLocked;
    btnLimparBusca: TBitBtnLocked;
    btnAtualizar: TBitBtnLocked;
    btnPesagem: TBitBtnLocked;
    btnConfPesagem: TBitBtnLocked;
    grdOrdProd: TcxGrid;
    grdOrdProdDados: TcxGridDBTableView;
    grdOrdProdNivel: TcxGridLevel;
    dtsOrdPro: TDataSource;
    grdOrdProdDadosORD_LOTEOP: TcxGridDBColumn;
    grdOrdProdDadosORD_CODORD: TcxGridDBColumn;
    grdOrdProdDadosORD_DTACAD: TcxGridDBColumn;
    grdOrdProdDadosORD_CODITE: TcxGridDBColumn;
    grdOrdProdDadosORD_DESITE: TcxGridDBColumn;
    grdOrdProdDadosORD_CODBAR: TcxGridDBColumn;
    grdOrdProdDadosORD_CODCOR: TcxGridDBColumn;
    grdOrdProdDadosORD_DESCOR: TcxGridDBColumn;
    grdOrdProdDadosORD_REFERE: TcxGridDBColumn;
    grdOrdProdDadosORD_VOLUME: TcxGridDBColumn;
    grdOrdProdDadosORD_PESOLI: TcxGridDBColumn;
    grdOrdProdDadosORD_LOCFIS: TcxGridDBColumn;
    grdOrdProdDadosORD_PEDIDO: TcxGridDBColumn;
    grdOrdProdDadosORD_NUMRES: TcxGridDBColumn;
    pnlLegenda: TPanel;
    lblPesPar: TLabel;
    shpPesPar: TShape;
    lblPesTot: TLabel;
    shpPesTot: TShape;
    grdOrdProdDadosORD_QTDECF: TcxGridDBColumn;
    lblPesoLimite: TLabel;
    shpPesoLimite: TShape;
    pnlFiltro: TPanel;
    rdgSitConf: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfPesagemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnLimparBuscaClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnPesagemClick(Sender: TObject);
    procedure grdOrdProdDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure rdgSitConfClick(Sender: TObject);
  private
    { Private declarations }
    strSQLOrdPro: String;
    cdsOrdPro: TUniClientDataSet;

    strCodBar: String;
    strCodIte: String;
    strCodCor: String;
    strPedRes: String;
    dteDtaCad: TDateTime;

    procedure pCarregarDados;
    function  fCarregarDados(pgbProgresso: TcxProgressBar): Boolean;
    procedure pLimparVarFiltros;
    procedure pAtualizarFiltros;
    function  fAtualizarFiltros(pgbProgresso: TcxProgressBar): Boolean;
    function  fRemoverFiltros(pgbProgresso: TcxProgressBar): Boolean;
    procedure pOnFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure pRealizarPesagem(strCodBarOP: String);
    procedure pRealizarConferenciaPesagem(strCodBarOP: String);
  public
    { Public declarations }
  end;

var
  frmConfOrdProd: TfrmConfOrdProd;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando, untConfOrdProdFiltros,
  untConfOrdProdPesagem;

procedure TfrmConfOrdProd.btnAtualizarClick(Sender: TObject);
begin
  inherited;

  pCarregarDados();
  pLimparVarFiltros();
end;

procedure TfrmConfOrdProd.btnBuscarClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmConfOrdProdFiltros, frmConfOrdProdFiltros);

    Try
      frmConfOrdProdFiltros.ShowModal;

      If (frmConfOrdProdFiltros.blnConfirma) Then Begin
        strCodBar := frmConfOrdProdFiltros.strCodBar;
        strCodIte := frmConfOrdProdFiltros.strCodIte;
        strCodCor := frmConfOrdProdFiltros.strCodCor;
        strPedRes := frmConfOrdProdFiltros.strPedRes;
        dteDtaCad := frmConfOrdProdFiltros.dteDtaCad;
      End Else Begin
        pLimparVarFiltros();
      End;

      pAtualizarFiltros();
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConfOrdProd.btnBuscarClick]');
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmConfOrdProd.btnConfPesagemClick(Sender: TObject);
begin
  inherited;

  If (Not fVerificaAcessoSistema('CFOPF11')) Then Begin
    fMensagem('ATENÇÃO!', 'Operador não tem direito de acesso a Conferência da Pesagem!', ['&OK']);
    Exit;
  End;

  If (fEmptyStr(cdsOrdPro.FieldByName('AUTOINCREM').AsString)) Then Begin
    fMensagem('ATENÇÃO!', 'Selecione uma Ordem de Produção para realizar esta operação!', ['&OK']);
    Exit;
  End;

  pRealizarConferenciaPesagem(cdsOrdPro.FieldByName('ORD_CODBAR').AsString);
end;

procedure TfrmConfOrdProd.btnLimparBuscaClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.pgbStatus.Visible   := False;
      frmGravando.lblGravando.Caption := 'Removendo filtros...';
      frmGravando.fExecutarAcao := fRemoverFiltros;
      frmGravando.ShowModal;
      Self.Repaint();
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConfOrdProd.pAtualizarFiltros]');
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmConfOrdProd.btnPesagemClick(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(cdsOrdPro.FieldByName('AUTOINCREM').AsString)) Then Begin
    fMensagem('ATENÇÃO!', 'Selecione uma Ordem de Produção para realizar esta operação!', ['&OK']);
    Exit;
  End;

  pRealizarPesagem(cdsOrdPro.FieldByName('ORD_CODBAR').AsString);
end;

function TfrmConfOrdProd.fAtualizarFiltros(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  Try
    cdsOrdPro.DisableControls();

    cdsOrdPro.Filter   := '';
    cdsOrdPro.Filtered := False;

    Try
      If (Not fEmptyStr(strCodBar)) Or
         (Not fEmptyStr(strCodIte)) Or
         (Not fEmptyStr(strCodCor)) Or
         (Not fEmptyStr(strPedRes)) Or
         (dteDtaCad > 0)            Or
         (rdgSitConf.ItemIndex <> 2) Then  //Todas
        cdsOrdPro.Filtered := True;

      cdsOrdPro.First();

      grdOrdProdDados.ApplyBestFit();

      grdOrdProd.Refresh();

      Application.ProcessMessages();

      //Se for filtro por CODBAR já carrega a OP para baixa
      If (Not fEmptyStr(strCodBar)) And
         (fEmptyStr(strCodIte)) And
         (fEmptyStr(strCodCor)) And
         (fEmptyStr(strPedRes)) And
         (dteDtaCad = 0) And
         (cdsOrdPro.RecordCount = 1) Then
        pRealizarPesagem(cdsOrdPro.FieldByName('ORD_CODBAR').AsString);
    Except
      On E: Exception Do Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmConfOrdProd.fAtualizarFiltros');
      End;
    End;
  Finally
    cdsOrdPro.EnableControls();
  End;
end;

function TfrmConfOrdProd.fCarregarDados(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryOrdPro: TUniQuery;
begin
  strSQLOrdPro := 'SELECT ';
  strSQLOrdPro := strSQLOrdPro + '  G.AUTOINCREM, ';
  strSQLOrdPro := strSQLOrdPro + '  G.ORD_CODBAR, ';
  strSQLOrdPro := strSQLOrdPro + '  CONCAT(DATE_FORMAT(G.ORD_DTACAD,"%d%m%y"), "-", G.ORD_CODORD) AS ORD_LOTEOP, ';
  strSQLOrdPro := strSQLOrdPro + '  G.ORD_CODORD, ';
  strSQLOrdPro := strSQLOrdPro + '  G.ORD_DTACAD, ';
  strSQLOrdPro := strSQLOrdPro + '  G.ORD_CODITE, ';
  strSQLOrdPro := strSQLOrdPro + '  IG.ITE_DESITE AS ORD_DESITE, ';
  strSQLOrdPro := strSQLOrdPro + '  G.ORD_CODCOR, ';
  strSQLOrdPro := strSQLOrdPro + '  C.COR_DESCOR AS ORD_DESCOR, ';
  strSQLOrdPro := strSQLOrdPro + '  IG.ITE_REFERE AS ORD_REFERE, ';
  strSQLOrdPro := strSQLOrdPro + '  SUM( ';
  strSQLOrdPro := strSQLOrdPro + '    IF( ';
  strSQLOrdPro := strSQLOrdPro + '      U.UNI_KILLIT = "K", ';
  strSQLOrdPro := strSQLOrdPro + '      IF( ';
  strSQLOrdPro := strSQLOrdPro + '        IFNULL(GM.GMT_PESREA, 0) > 0, ';
  strSQLOrdPro := strSQLOrdPro + '        D.ORD_QTDPRO * U.UNI_PESLIT / GM.GMT_PESREA, ';
  strSQLOrdPro := strSQLOrdPro + '        0 ';
  strSQLOrdPro := strSQLOrdPro + '      ), ';
  strSQLOrdPro := strSQLOrdPro + '      D.ORD_QTDPRO * U.UNI_PESLIT ';
  strSQLOrdPro := strSQLOrdPro + '    ) ';
  strSQLOrdPro := strSQLOrdPro + '  ) AS ORD_VOLUME, ';
  strSQLOrdPro := strSQLOrdPro + '  SUM( ';
  strSQLOrdPro := strSQLOrdPro + '    IF( ';
  strSQLOrdPro := strSQLOrdPro + '      U.UNI_KILLIT = "K", ';
  strSQLOrdPro := strSQLOrdPro + '      D.ORD_QTDPRO * U.UNI_PESLIT, ';
  strSQLOrdPro := strSQLOrdPro + '      D.ORD_QTDPRO * U.UNI_PESLIT * GM.GMT_PESREA ';
  strSQLOrdPro := strSQLOrdPro + '    ) ';
  strSQLOrdPro := strSQLOrdPro + '  ) AS ORD_PESOLI, ';
  strSQLOrdPro := strSQLOrdPro + '  SUM(D.ORD_QTDECF) AS ORD_QTDECF, ';
  strSQLOrdPro := strSQLOrdPro + '  G.ORD_LOCORP AS ORD_LOCFIS, ';
  strSQLOrdPro := strSQLOrdPro + '  (SELECT ';
  strSQLOrdPro := strSQLOrdPro + '    GROUP_CONCAT(FDO_NUMDOC SEPARATOR " - ") ';
  strSQLOrdPro := strSQLOrdPro + '  FROM ';
  strSQLOrdPro := strSQLOrdPro + '    EXTDOR ';
  strSQLOrdPro := strSQLOrdPro + '    LEFT JOIN FATDOR ';
  strSQLOrdPro := strSQLOrdPro + '      ON FATDOR.AUTOINCREM = FDO_SEQFDO ';
  strSQLOrdPro := strSQLOrdPro + '  WHERE FDO_SEQOPI = G.AUTOINCREM) AS ORD_PEDIDO, ';
  strSQLOrdPro := strSQLOrdPro + '  CONCAT( ';
  strSQLOrdPro := strSQLOrdPro + '    FG.FGO_NUMDOC, ';
  strSQLOrdPro := strSQLOrdPro + '    "-", ';
  strSQLOrdPro := strSQLOrdPro + '    FG.FGO_ESPDOC, ';
  strSQLOrdPro := strSQLOrdPro + '    "-", ';
  strSQLOrdPro := strSQLOrdPro + '    FG.FGO_CODEMP ';
  strSQLOrdPro := strSQLOrdPro + '  ) AS ORD_NUMRES ';
  strSQLOrdPro := strSQLOrdPro + 'FROM ';
  strSQLOrdPro := strSQLOrdPro + '  ORDGER G ';
  strSQLOrdPro := strSQLOrdPro + '  INNER JOIN ORDDET D ';
  strSQLOrdPro := strSQLOrdPro + '    ON G.AUTOINCREM = D.ORD_SEQGER ';
  strSQLOrdPro := strSQLOrdPro + '  INNER JOIN CADITE IG ';
  strSQLOrdPro := strSQLOrdPro + '    ON G.ORD_CODITE = IG.ITE_CODITE ';
  strSQLOrdPro := strSQLOrdPro + '  LEFT JOIN CADCOR C ';
  strSQLOrdPro := strSQLOrdPro + '    ON G.ORD_CODCOR = C.COR_CODCOR ';
  strSQLOrdPro := strSQLOrdPro + '  LEFT JOIN CADITE ID ';
  strSQLOrdPro := strSQLOrdPro + '    ON ID.ITE_CODITE = D.ORD_CODITE ';
  strSQLOrdPro := strSQLOrdPro + '  LEFT JOIN CADUNI U ';
  strSQLOrdPro := strSQLOrdPro + '    ON ID.ITE_CODUNI = U.UNI_CODUNI ';
  strSQLOrdPro := strSQLOrdPro + '  LEFT JOIN GEIMAT GM ';
  strSQLOrdPro := strSQLOrdPro + '    ON GMT_STATUS = "A" ';
  strSQLOrdPro := strSQLOrdPro + '    AND GMT_CODITE = G.ORD_CODITE ';
  strSQLOrdPro := strSQLOrdPro + '    AND GMT_CODCOR = G.ORD_CODCOR ';
  strSQLOrdPro := strSQLOrdPro + '  LEFT JOIN EXTGOR EX ';
  strSQLOrdPro := strSQLOrdPro + '    ON EX.FGO_ORDIND = G.AUTOINCREM ';
  strSQLOrdPro := strSQLOrdPro + '  LEFT JOIN FATGOR FG ';
  strSQLOrdPro := strSQLOrdPro + '    ON FG.AUTOINCREM = EX.FGO_SEQFGO ';
  strSQLOrdPro := strSQLOrdPro + 'WHERE G.ORD_CODEMP = :CODEMP ';
  strSQLOrdPro := strSQLOrdPro + '  AND G.ORD_DTABAI IS NULL ';
  strSQLOrdPro := strSQLOrdPro + '  AND G.ORD_OPBXCF IS NULL ';
  strSQLOrdPro := strSQLOrdPro + 'GROUP BY G.AUTOINCREM ORDER BY G.ORD_DTACAD';

  Result := True;

  Try
    qryOrdPro := fCriaQuery(nil);

    Try
      qryOrdPro.Close();
      qryOrdPro.SQL.Clear();
      qryOrdPro.SQL.Text := strSQLOrdPro;
      qryOrdPro.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryOrdPro.Open();

      If (Assigned(cdsOrdPro)) Then
        cdsOrdPro.EmptyDataSet();

      cdsOrdPro := fCriaClientDatset(qryOrdPro);
      dtsOrdPro.DataSet := cdsOrdPro;

      cdsOrdPro.OnFilterRecord := pOnFilterRecord;

      TFloatField(cdsOrdPro.FieldByName('ORD_VOLUME')).DisplayFormat := '#,###0.000';
      TFloatField(cdsOrdPro.FieldByName('ORD_PESOLI')).DisplayFormat := '#,###0.000';

      grdOrdProdDados.ApplyBestFit();
    Except
      On E: Exception Do Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmConfOrdProd.pCarregarDados');
      End;
    End;
  Finally
    FreeAndNil(qryOrdPro);
  End;
end;

procedure TfrmConfOrdProd.FormCreate(Sender: TObject);
begin
  inherited;

  strSQLOrdPro := '';

  pLimparVarFiltros();
end;

procedure TfrmConfOrdProd.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then btnSair.Click();

  If (Key = VK_F3)  Then btnBuscar.Click();
  If (Key = VK_F4)  Then btnLimparBusca.Click();
  If (Key = VK_F5)  Then btnAtualizar.Click();
  If (Key = VK_F10) Then btnPesagem.Click();
  If (Key = VK_F11) Then btnConfPesagem.Click();
end;

procedure TfrmConfOrdProd.FormShow(Sender: TObject);
begin
  inherited;

  pCarregarDados();
end;

function TfrmConfOrdProd.fRemoverFiltros(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  Try
    cdsOrdPro.DisableControls();
    pLimparVarFiltros();

    Try
      cdsOrdPro.Filter   := '';
      cdsOrdPro.Filtered := False;
    Except
      On E: Exception Do Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmConfOrdProd.fAtualizarFiltros');
      End;
    End;
  Finally
    cdsOrdPro.EnableControls();
  End;
end;

procedure TfrmConfOrdProd.grdOrdProdDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
   fltQTDECF,
   fltPESOLI: Double;
begin
  inherited;

  If Assigned(grdOrdProdDados.DataController.DataSource.DataSet) And
    (Not grdOrdProdDados.DataController.DataSource.DataSet.IsEmpty) Then Begin

    fltQTDECF := VarAsType(IfNull(Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdOrdProdDadosORD_QTDECF.Index], 0), varDouble);
    fltPESOLI := VarAsType(IfNull(Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdOrdProdDadosORD_PESOLI.Index], 0), varDouble);

    fltQTDECF := Trunc(fltQTDECF * 1000);
    fltPESOLI := Trunc(fltPESOLI * 1000);

    If (fltQTDECF = fltPESOLI) Then Begin
      If (ACanvas.Brush.Color = clHighlight) Then
        ACanvas.Font.Color := clWhite;

      ACanvas.Brush.Color := $0096CFA7;
    End Else If (fltQTDECF > 0) And (fPesoDentroLimite(fltQTDECF, fltPESOLI)) Then Begin
      If (ACanvas.Brush.Color = clHighlight) Then
        ACanvas.Font.Color := clBlack;

      ACanvas.Brush.Color := clSkyBlue;
    End Else If (fltQTDECF > 0) And (fltQTDECF < fltPESOLI) Then Begin
      If (ACanvas.Brush.Color = clHighlight) Then
        ACanvas.Font.Color := clBlack;

      ACanvas.Brush.Color := $00CCFFFF;
    End;
  End;
end;

procedure TfrmConfOrdProd.pAtualizarFiltros;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.pgbStatus.Visible   := False;
      frmGravando.lblGravando.Caption := 'Aplicando filtros...';
      frmGravando.fExecutarAcao := fAtualizarFiltros;
      frmGravando.ShowModal;
      Self.Repaint();
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConfOrdProd.pAtualizarFiltros]');
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmConfOrdProd.pCarregarDados;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.pgbStatus.Visible   := False;
      frmGravando.lblGravando.Caption := 'Carregando Ordens de Produção em aberto...';
      frmGravando.fExecutarAcao := fCarregarDados;
      frmGravando.ShowModal;
      Self.Repaint();
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConfOrdProd.pCarregarDados]');
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmConfOrdProd.pLimparVarFiltros;
begin
  strCodBar := '';
  strCodIte := '';
  strCodCor := '';
  strPedRes := '';
  dteDtaCad := 0;
end;

procedure TfrmConfOrdProd.pOnFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := True;

  If (Not fEmptyStr(strCodBar)) Then
    Accept := Accept And (Pos(DataSet.FieldByName('ORD_CODBAR').AsString, strCodBar) > 0);

  If (Not fEmptyStr(strCodIte)) Then
    Accept := Accept And (Pos(DataSet.FieldByName('ORD_CODITE').AsString, strCodIte) > 0);

  If (Not fEmptyStr(strCodCor)) Then
    Accept := Accept And (Pos(DataSet.FieldByName('ORD_CODCOR').AsString, strCodCor) > 0);

  If (Not fEmptyStr(strPedRes)) Then
    Accept := Accept And (Pos(strPedRes, DataSet.FieldByName('ORD_NUMRES').AsString) > 0);

  If (dteDtaCad > 0) Then
    Accept := Accept And (DataSet.FieldByName('ORD_DTACAD').AsDateTime = dteDtaCad);

  If (rdgSitConf.ItemIndex = 0) Then //Pendente
    Accept := Accept And (DataSet.FieldByName('ORD_QTDECF').AsFloat = 0);

  If (rdgSitConf.ItemIndex = 1) Then //Iniciada
    Accept := Accept And (DataSet.FieldByName('ORD_QTDECF').AsFloat > 0);
end;

procedure TfrmConfOrdProd.pRealizarConferenciaPesagem(strCodBarOP: String);
  Var
    strTemp: String;
begin
  Try
    strTemp := 'CONF_OP_' + strCodBarOP;

    If (Not fLock_Unlock(strTemp, True, False)) Then
    Begin
      fMensagem('', 'Há outro operador realizando a conferência da pesagem desta Ordem de Produção. Operação cancelada!', ['&OK']);
      Exit;
    End;

    pCriarFormularios(TfrmConfOrdProdPesagem, frmConfOrdProdPesagem);

    Try
      frmConfOrdProdPesagem.strCodBarOP    := strCodBarOP;
      frmConfOrdProdPesagem.blnConferencia := True;
      frmConfOrdProdPesagem.Caption := 'Conf. de Ord. de Prod. | Cód. Barras: ' + strCodBarOP + ' | Prod.: ' +
        cdsOrdPro.FieldByName('ORD_CODITE').AsString + '-' + cdsOrdPro.FieldByName('ORD_DESITE').AsString +
        ' (Conferência Pesagem)';

      frmConfOrdProdPesagem.ShowModal;

      If (frmConfOrdProdPesagem.blnConfir) Then
        btnAtualizar.Click();
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConfOrdProd.pRealizarPesagem]');
    End;
  Finally
    fLock_Unlock(strTemp, False, False);
    pFreeAndNil(frmConfOrdProdPesagem);
  End;
end;

procedure TfrmConfOrdProd.pRealizarPesagem(strCodBarOP: String);
  Var
    strTemp: String;
begin
  Try
    strTemp := 'CONF_OP_' + strCodBarOP;

    If (Not fLock_Unlock(strTemp, True, False)) Then
    Begin
      fMensagem('', 'Há outro operador realizando a pesagem desta Ordem de Produção. Operação cancelada!', ['&OK']);
      Exit;
    End;

    pCriarFormularios(TfrmConfOrdProdPesagem, frmConfOrdProdPesagem);

    Try
      frmConfOrdProdPesagem.strCodBarOP    := strCodBarOP;
      frmConfOrdProdPesagem.blnConferencia := False;
      frmConfOrdProdPesagem.Caption := 'Conf. de Ord. de Prod. | Cód. Barras: ' + strCodBarOP + ' | Prod.: ' +
        cdsOrdPro.FieldByName('ORD_CODITE').AsString + '-' + cdsOrdPro.FieldByName('ORD_DESITE').AsString +
        ' (Pesagem)';

      frmConfOrdProdPesagem.ShowModal;

      If (frmConfOrdProdPesagem.blnConfir) Then Begin
        btnAtualizar.Click();
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConfOrdProd.pRealizarPesagem]');
    End;
  Finally
    fLock_Unlock(strTemp, False, False);
    pFreeAndNil(frmConfOrdProdPesagem);
  End;
end;

procedure TfrmConfOrdProd.rdgSitConfClick(Sender: TObject);
begin
  inherited;

  pAtualizarFiltros();
end;

end.
