unit untRelEstPedCompraGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, System.UITypes,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider, untIFuncoes,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, untPaiEdit, cxLabel,
  cxCalendar;

type
  TfrmRelEstPedCompraGrid = class(TfrmPaiEdit)
    pnlTail: TPanel;
    Label2: TLabel;
    Shape2: TShape;
    Label1: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    Label3: TLabel;
    dtsConsulta: TDataSource;
    cxvPedCompra: TcxGridDBTableViewCitel;
    cxgPedCompraLevel: TcxGridLevel;
    cxgPedCompra: TcxGridCitel;
    cxvPedCompraTIPDOC: TcxGridDBColumn;
    cxvPedCompraPCD_NUMPED: TcxGridDBColumn;
    cxvPedCompraPCD_CODEMP: TcxGridDBColumn;
    cxvPedCompraPCD_CODFOR: TcxGridDBColumn;
    cxvPedCompraFOR_NOMFOR: TcxGridDBColumn;
    cxvPedCompraPCG_DTAPED: TcxGridDBColumn;
    cxvPedCompraPCD_DTAENT: TcxGridDBColumn;
    cxvPedCompraPCD_QTDITE: TcxGridDBColumn;
    cxvPedCompraUNI_SIGUNI: TcxGridDBColumn;
    cxvPedCompraPCD_EMBALA: TcxGridDBColumn;
    cxvPedCompraUNITAR: TcxGridDBColumn;
    cxvPedCompraPGC_COMPRA: TcxGridDBColumn;
    cxvPedCompraQTDCON: TcxGridDBColumn;
    cxvPedCompraQTDREQ: TcxGridDBColumn;
    btnReqCom: TBitBtnLocked;
    pnlObservacao: TPanel;
    lblObservacao: TLabel;
    memObserv: TMemo;
    cxvPedCompraLOG_DTAATU: TcxGridDBColumn;
    cxvPedCompraMotivoAlteracaoDataEntrega: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxvPedCompraCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnReqComClick(Sender: TObject);
  private
    { Private declarations }
    qryConsulta: TUniQuery;
    procedure AjustarColunas;
    procedure pMascaraValor;
    function fGetSql : String;
    procedure CarregarObservacao(objDataSet: TDataSet);
  public
    { Public declarations }
    strCodIte,
    strDesIte,
    strExiFor: String;
    blnOriConsulPro: boolean;
    blnExibirUnitario: boolean;
  end;

var
  frmRelEstPedCompraGrid: TfrmRelEstPedCompraGrid;

implementation

uses untFuncoesSimples, untFuncoesRel;

{$R *.dfm}


procedure TfrmRelEstPedCompraGrid.AjustarColunas;
begin
  cxvPedCompraQTDCON.Visible := (fCfgSis('USACON', varBoolean)) And (Pos(fCfgSis('CONFME', varString), '1_3_') > 0);
  cxvPedCompraUNITAR.Visible := blnExibirUnitario;
end;

procedure TfrmRelEstPedCompraGrid.btnReqComClick(Sender: TObject);
begin
  inherited;

  If qryConsulta.IsEmpty Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(101, 5751, [],
                        ['CODITE'],
                        [strCodIte],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmRelEstPedCompraGrid.cxvPedCompraCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Begin
  inherited;

  If (qryConsulta.Active) And (Not qryConsulta.IsEmpty) Then
  Begin
      If ((Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvPedCompraTIPDOC.Index]) = 'CO') Then
        ACanvas.Font.Color := clRed
      Else If ((Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvPedCompraTIPDOC.Index]) = 'GF') Then
        ACanvas.Font.Color := clFuchsia
      Else
        ACanvas.Font.Color := clBlue;
  End;

  If AViewInfo.Selected Then
    ACanvas.Font.Color := clBlack;

End;

function TfrmRelEstPedCompraGrid.fGetSql: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  D.AUTOINCREM,     ';
  strSQL := strSQL + 'IF ((COALESCE(                                           ';
  strSQL := strSQL + '        (SELECT                                           ';
  strSQL := strSQL + '          COUNT(1)                                        ';
  strSQL := strSQL + '        FROM                                              ';
  strSQL := strSQL + '          MOVGAE D                                        ';
  If fCfgSis('CPDORI', varBoolean) Then
  Begin
    strSQL := strSQL + '        WHERE D.GAE_NUMENV = PCG_ORIGND ';
    strSQL := strSQL + '          AND D.GAE_ESPENV = PCG_ORIGES ';
    strSQL := strSQL + '          AND D.GAE_EMPENV = PCG_ORIGEP), 0) > 0)                 ';
  End
  Else
  begin
    strSQL := strSQL + '        WHERE D.GAE_NUMENV = SUBSTRING(PCG_DOCORI, 1, 12) ';
    strSQL := strSQL + '          AND D.GAE_ESPENV = SUBSTRING(PCG_DOCORI, 13, 2) ';
    strSQL := strSQL + '          AND D.GAE_EMPENV = SUBSTRING(PCG_DOCORI,        ';
    strSQL := strSQL + '            LENGTH(PCG_DOCORI) - 2,                       ';
    strSQL := strSQL + '            LENGTH(PCG_DOCORI))), 0) > 0)                 ';

  End;
  strSQL := strSQL + '     OR (COALESCE(( SELECT COUNT(1) FROM PCMDET           ';
  strSQL := strSQL + '      INNER JOIN SEQGAR ON SEQ_PCMDET = PCMDET.AUTOINCREM ';
  strSQL := strSQL + '      WHERE PCD_NUMPED = PCG_NUMPED                       ';
  strSQL := strSQL + '        AND PCD_CODEMP = PCG_CODEMP                       ';
  strSQL := strSQL + '        AND PCD_NUMCTN = PCG_NUMCTN                       ';
  strSQL := strSQL + '        AND PCD_ESPDOC = PCG_ESPDOC),0) > 0 )             ';
  strSQL := strSQL + '  , ''GF'',''PD'') AS TIPDOC,                             ';
  strSQL := strSQL + '  PCD_NUMPED,       ';
  strSQL := strSQL + '  IF (PCG_EMPDES IS NULL OR PCG_EMPDES = "", PCD_CODEMP, PCG_EMPDES) AS PCD_CODEMP, ';
  strSQL := strSQL + '  PCD_CODFOR,       ';
  strSQL := strSQL + '  FOR_NOMFOR,       ';
  strSQL := strSQL + '  IF(IFNULL(PCG_COMPRA,"") <> "" , PCG_COMPRA, OPE_NOMOPE) AS PGC_COMPRA, ';

  If fCfgSis('ENTITE', varString ) = 'S' Then
    strSQL := strSQL + '  PCD_DTAENT AS PCD_DTAENT,     '
  Else
    strSQL := strSQL + '  PCG_DTAENT AS PCD_DTAENT,     ';

  strSQL := strSQL + '  PCG_DTAPED,       ';
  strSQL := strSQL + '  UNI_SIGUNI,       ';
  strSQL := strSQL + '  PCD_EMBALA,       ';

  strSQL := strSQL + '  IFNULL((SELECT SUM(RCD_QTDITE) ';
  strSQL := strSQL + '           - IFNULL((SELECT SUM(BAI_QTDREQ) FROM BAIREQ WHERE BAI_AUTREQ = R.AUTOINCREM), 0) ';
  strSQL := strSQL + '   FROM MOVRCD R ';
  strSQL := strSQL + '   WHERE RCD_ATETRA <> 1 AND RCD_SEQPCD = D.AUTOINCREM), 0) AS QTDREQ,    ';

  strSQL := strSQL + '  ROUND(SUM(PCD_QTDITE - PCD_QTDBAI), 2) AS PCD_QTDITE ';

  If (fCfgSis('USACON', varBoolean)) and
     (Pos(fCfgSis('CONFME', varString), '1_3_') > 0) Then
  Begin
    strSQL := strSQL + ' ,  IF((SELECT COUNT(1) FROM DEFBAI WHERE DEF_AUTPCD = D.AUTOINCREM ) > 0, ';
    strSQL := strSQL + ' IFNULL((SELECT SUM(DIGELE.DIG_QTDITE) ';
    strSQL := strSQL + '     FROM DIGELE ';
    strSQL := strSQL + '    WHERE DIGELE.DIG_CODITE = D.PCD_CODITE ';
    strSQL := strSQL + '      AND DIGELE.DIG_CODEMP = IFNULL(PCMGER.PCG_EMPDES, PCMGER.PCG_CODEMP) ';
    strSQL := strSQL + '      AND DIGELE.DIG_IDEDIG IN (SELECT DISTINCT(GERELE.GER_IDEDIG) ';
    strSQL := strSQL + '                                  FROM PEDELE ';
    strSQL := strSQL + '                                 INNER JOIN GERELE ON GERELE.AUTOINCREM = PEDELE.PEL_SEQELE ';

    //Conferencia Depois da entrada
    If (fCfgSis('TIPPNT', varString) = 'D') Then
    Begin
      strSQL := strSQL + ' AND IFNULL((SELECT  MOVGER.GER_DTAENT FROM MOVGER ';
      strSQL := strSQL + '              WHERE MOVGER.GER_NUMDOC = GERELE.GER_DOCENT ';
      strSQL := strSQL + '                AND MOVGER.GER_ESPDOC = GERELE.GER_ESPENT ';
      strSQL := strSQL + '                AND MOVGER.GER_CODEMP = GERELE.GER_EMPENT ';
      strSQL := strSQL + '                AND MOVGER.GER_CODFOR = GERELE.GER_CODFOR ), "") = "" ';
    End
    Else
      strSQL := strSQL + ' AND GER_DOCENT IS NULL ';

    strSQL := strSQL + '                                 WHERE PEDELE.PEL_NUMDOC = D.PCD_NUMPED ';
    strSQL := strSQL + '                                   AND PEDELE.PEL_ESPDOC = D.PCD_ESPDOC ';
    strSQL := strSQL + '                                   AND PEDELE.PEL_CODEMP = D.PCD_CODEMP)), 0), 0) QTDCON ';
  End
  else
    strSQL := strSQL + ' ,0.00 AS QTDCON ';
  strSQL := strSQL + '   ,ROUND(PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
  strSQL := strSQL + '                      * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
  strSQL := strSQL + '                      * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
  strSQL := strSQL + '                      * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
  strSQL := strSQL + '                      * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
  strSQL := strSQL + '                      * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
  strSQL := strSQL + '   , 2) AS UNITAR,  ';


  strSQL := strSQL + ' PCG_OBSPD1, ';
  strSQL := strSQL + ' PCG_OBSPD2, ';
  strSQL := strSQL + ' PCG_OBSPD3, ';
  strSQL := strSQL + ' PCG_OBSPD4, ';
  strSQL := strSQL + ' PCG_OBSPD5, ';
  strSQL := strSQL + ' PCG_OBSPD6  ';
  strSQL := strSQL + ', IFNULL( ';
  strSQL := strSQL + '(SELECT ';
  strSQL := strSQL + 'CAST(LOG_MOTIVO AS CHAR(250)) AS LOG_MOTIVO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + 'LOGDPD ';
  strSQL := strSQL + 'WHERE LOG_PCGSEQ = PCMGER.AUTOINCREM ';
  strSQL := strSQL + 'ORDER BY LOGDPD.AUTOINCREM DESC LIMIT 1), ';
  strSQL := strSQL + '"") AS motivoAlteracao';
  strSQL := strSQL + ', IFNULL((SELECT MIN(LOG_DTAATU) ';
  strSQL := strSQL + 'FROM LOGDPD ';
  strSQL := strSQL + 'WHERE LOG_PCGSEQ = PCMGER.AUTOINCREM ';
  strSQL := strSQL + '), PCD_DTAENT) LOG_DTAATU ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PCMDET D ';

  strSQL := strSQL + 'INNER JOIN PCMGER ON ';
  strSQL := strSQL + '  PCG_NUMPED = PCD_NUMPED AND ';
  strSQL := strSQL + '  PCG_ESPDOC = PCD_ESPDOC AND ';
  strSQL := strSQL + '  PCG_CODEMP = PCD_CODEMP ';

  strSQL := strSQL + 'INNER JOIN CADFOR ON ';
  strSQL := strSQL + '  PCD_CODFOR = FOR_CODFOR ';

  strSQL := strSQL + 'LEFT JOIN CADOPE ON OPE_CODOPE = PCG_CODCMP ';

  strSQL := strSQL + 'LEFT JOIN CADUNI ON UNI_CODUNI = PCD_CODUNI ';

  strSQL := strSQL + 'WHERE ';

  If fCfgSis('LIBPCM', varBoolean) Then
    strSQL := strSQL + '  PCG_PEDLIB IS NOT NULL AND ';

  strSQL := strSQL + '  PCG_BAIXAD = 0 AND ';
  strSQL := strSQL + '  PCD_BAIXAD = 0 AND ';
  strSQL := strSQL + '  PCD_ESPDOC = "PD" AND ';
  strSQL := strSQL + '  PCD_NUMCTN = 0 AND PCG_NUMCTN = 0 AND ';
  strSQL := strSQL + '  PCD_CODITE =  ' + QuotedStr(strCodIte);
  strSQL := strSQL + ' GROUP BY PCD_NUMPED, PCD_CODEMP, QTDCON ';

  If blnOriConsulPro and fCfgSis('LCAPEC', varBoolean) Then
  Begin
    strSQL := strSQL + 'UNION ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '   C.AUTOINCREM, ';
    strSQL := strSQL + '   "CO" AS TIPDOC,       ';
    strSQL := strSQL + '   G.COT_NUMCOT AS PCD_NUMPED, ';
    strSQL := strSQL + '   IF(G.COT_MULLOJ = "S", EM.PCD_EMPDES, G.COT_CODEMP) AS PCD_CODEMP, ';
    strSQL := strSQL + '   F.FOR_CODFOR AS PCD_CODFOR, ';
    strSQL := strSQL + '   F.FOR_NOMFOR, ';
    strSQL := strSQL + '   IF(IFNULL(G.COT_COMPRA, "") <> "", G.COT_COMPRA, OPE_NOMOPE) AS PGC_COMPRA, ';
    strSQL := strSQL + '   G.COT_DTACAD AS PCG_DTAPED, ';
    strSQL := strSQL + '   CF.COT_DTAENT AS PCD_DTAENT, ';

    strSQL := strSQL + '  UNI_SIGUNI,       ';
    strSQL := strSQL + '  1.00 AS PCD_EMBALA,       ';

    strSQL := strSQL + '  0.00 AS QTDREQ,    ';

    strSQL := strSQL + '  IF(G.COT_MULLOJ = "S", EM.PCD_QTDITE, C.COT_QTDITE) AS PCD_QTDITE  ';

    strSQL := strSQL + ' ,0.00 AS QTDCON ';
    strSQL := strSQL + ' ,COT_VALUNI AS UNITAR,  ';
    strSQL := strSQL + ' "" PCG_OBSPD1, ';
    strSQL := strSQL + ' "" PCG_OBSPD2, ';
    strSQL := strSQL + ' "" PCG_OBSPD3, ';
    strSQL := strSQL + ' "" PCG_OBSPD4, ';
    strSQL := strSQL + ' "" PCG_OBSPD5, ';
    strSQL := strSQL + ' "" PCG_OBSPD6, ';
    strSQL := strSQL + ' "" motivoAlteracao, ';
    strSQL := strSQL + ' "" LOG_DTAATU  ';

    strSQL := strSQL + ' FROM COTGER G ';
    strSQL := strSQL + ' LEFT JOIN COTITE C ON C.COT_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + ' LEFT JOIN CADOPE O ON OPE_CODOPE = COT_CODCMP ';
    strSQL := strSQL + ' LEFT JOIN COTFOR T ON T.COT_SEQGER = G.AUTOINCREM AND T.COT_CODITE = C.COT_CODITE AND T.COT_CODFOR = C.COT_FORESC ';
    strSQL := strSQL + ' LEFT JOIN CADFOR F ON F.FOR_CODFOR = C.COT_FORESC ';
    strSQL := strSQL + ' LEFT JOIN COTCFO CF ON CF.COT_SEQGER = G.AUTOINCREM AND CF.COT_CODFOR = C.COT_FORESC ';
    strSQL := strSQL + ' LEFT JOIN PCDCOT EM ON EM.PCD_SEQGER = C.COT_SEQGER AND EM.PCD_CODITE = C.COT_CODITE ';

    strSQL := strSQL + 'INNER JOIN CADITE ON ITE_CODITE = C.COT_CODITE ';

    strSQL := strSQL + 'LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

    strSQL := strSQL + ' WHERE C.COT_CODITE = ' + QuotedStr(strCodIte);
    strSQL := strSQL + '  AND G.COT_DTAFIN IS NULL ';
    strSQL := strSQL + '  AND (SELECT COUNT(1) FROM PCMDET D';
    strSQL := strSQL + '        INNER JOIN PCMGER     ON PCG_NUMPED = PCD_NUMPED';
    strSQL := strSQL + '                             AND PCG_ESPDOC = PCD_ESPDOC';
    strSQL := strSQL + '                             AND PCG_CODEMP = PCD_CODEMP';
    strSQL := strSQL + '        WHERE D.PCD_CODITE = C.COT_CODITE';
    strSQL := strSQL + '          AND PCG_NUMCOT = G.COT_NUMCOT';
    strSQL := strSQL + '          AND PCG_EMPCOT = IF(G.COT_MULLOJ = "S", EM.PCD_EMPDES, G.COT_CODEMP  )) = 0';

    strSQL := strSQL + '  AND ((G.COT_MULLOJ = "N") OR ((G.COT_MULLOJ = "S") AND (EM.PCD_QTDITE > 0)))';
    strSQL := strSQL + ' GROUP BY PCD_NUMPED, PCD_CODEMP, QTDCON ';
  End;
  Result := strSQL;
End;

procedure TfrmRelEstPedCompraGrid.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConsulta);
end;

procedure TfrmRelEstPedCompraGrid.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta := fCriaQuery;
end;

procedure TfrmRelEstPedCompraGrid.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6: btnReqCom.Click;
  End;

end;

procedure TfrmRelEstPedCompraGrid.FormShow(Sender: TObject);
begin
  inherited;

  Caption := 'Pedidos de Compra em Aberto do Item: ' + strCodIte + ' - ' + strDesIte;

  If strExiFor = 'N' Then
  Begin
    cxvPedCompraPCD_CODFOR.Visible := False;//PCD_CODFOR
    cxvPedCompraFOR_NOMFOR.Visible := False;//PCD_NOMFOR
  End;

  qryConsulta.SQL.Text := fGetSql;
  qryConsulta.Open;
  dtsConsulta.DataSet := qryConsulta;

  qryConsulta.AfterScroll := CarregarObservacao;

  pMascaraValor;
  AjustarColunas;
end;

procedure TfrmRelEstPedCompraGrid.pMascaraValor;
begin
  If qryConsulta.Active Then
  Begin
    TFloatField(qryConsulta.FieldByName('PCD_QTDITE')).DisplayFormat := fMskDigitos(2);
    TFloatField(qryConsulta.FieldByName('PCD_EMBALA')).DisplayFormat := fMskDigitos(2);
    TFloatField(qryConsulta.FieldByName('QTDCON')).DisplayFormat     := fMskDigitos(2);
    TFloatField(qryConsulta.FieldByName('QTDREQ')).DisplayFormat     := fMskDigitos(2);
    TFloatField(qryConsulta.FieldByName('PCG_DTAPED')).EditMask      := '99/99/9999;1;_';
    TFloatField(qryConsulta.FieldByName('PCD_DTAENT')).EditMask      := '99/99/9999;1;_';
    TFloatField(qryConsulta.FieldByName('UNITAR')).DisplayFormat     := fMskDigitos(fCfgSis('DECUNI', varInteger));
  End;
end;


procedure TfrmRelEstPedCompraGrid.CarregarObservacao(objDataSet: TDataSet);
begin
  memObserv.Lines.Clear;
  if objDataSet.FieldByName('PCG_OBSPD1').AsString <>'' then
    memObserv.Lines.Add(objDataSet.FieldByName('PCG_OBSPD1').AsString);

  if objDataSet.FieldByName('PCG_OBSPD2').AsString <>'' then
    memObserv.Lines.Add(objDataSet.FieldByName('PCG_OBSPD2').AsString);

  if objDataSet.FieldByName('PCG_OBSPD3').AsString <>'' then
    memObserv.Lines.Add(objDataSet.FieldByName('PCG_OBSPD3').AsString);

  if objDataSet.FieldByName('PCG_OBSPD4').AsString <>'' then
    memObserv.Lines.Add(objDataSet.FieldByName('PCG_OBSPD4').AsString);

  if objDataSet.FieldByName('PCG_OBSPD5').AsString <>'' then
    memObserv.Lines.Add(objDataSet.FieldByName('PCG_OBSPD5').AsString);

  if objDataSet.FieldByName('PCG_OBSPD6').AsString <>'' then
    memObserv.Lines.Add(objDataSet.FieldByName('PCG_OBSPD6').AsString);

  memObserv.Text := Copy(memObserv.Text,1, Length(memObserv.Text)-Length(sLineBreak));
End;

end.
