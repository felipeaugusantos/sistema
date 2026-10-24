unit untTLogAlteracaoDataPedCompra;

interface

uses SysUtils, uni, Data.DB, UniClientDataset;

Type
  TLogAlteracaoDataPedCompra = class
  private
    FdtaLOGDTA: TDate;
    FdtaLOGHOR: TTime;
    qrySQL: TUniQuery;
    FstrPedido: string;
    FstrFornecedor: String;
    FCdsItensPedidoCompra: TUniClientDataSet;

    function fAlteraData(strCODOPE: string;
                       strCODEMP: string;
                       strNUMPED: string;
                       strESPDOC: string;
                       intANTCTN: integer;
                       intDEPCTN: integer;
                       dtaDTAATU: TDate;
                       dtaDTANOV: TDate;
                       strMOTIVO: String;
                       strPCGSEQ: String): boolean;
  public
    constructor Create;
    destructor Destroy; Override;
    procedure pSetTituloTela(strPedido: string; strFornecedor: String);

    function fPede_e_AlteraData(strCODOPE: string;
                         strCODEMP: string;
                         strNUMPED: string;
                         strESPDOC: string;
                         intANTCTN: integer;
                         intDEPCTN: integer;
                         dtaDTAATU: TDate;
                         dtaDTAFAT: TDate;
                         strPCGSEQ: String): boolean;

    function fGravaLog(strCODOPE: string;
                       strCODEMP: string;
                       strNUMPED: string;
                       strESPDOC: string;
                       intANTCTN: integer;
                       intDEPCTN: integer;
                       dtaDTAATU: TDate;
                       dtaDTANOV: TDate;
                       strMOTIVO: String;
                       strPCGSEQ: String;
                       strIteAutoincrem: string = ''): boolean;

   procedure pShowHistoricoLog(strPCGSEQ: string; blnMensagemVazio: boolean = False);
   function fRetornaSQLLogItens: string;
end;

implementation

{ TLogAlteracaoDataPedCompra }

uses untFuncoesSimples, untLogAlteracaoDataPedidoCompra,
  untPedeDataAlteracaoPedido;

constructor TLogAlteracaoDataPedCompra.Create;
begin
  qrySQL := fCriaQuery;
end;

destructor TLogAlteracaoDataPedCompra.Destroy;
begin
  FreeAndNil(qrySQL);
  FreeAndNil(FCdsItensPedidoCompra);
end;

function TLogAlteracaoDataPedCompra.fPede_e_AlteraData(strCODOPE, strCODEMP, strNUMPED,
  strESPDOC: string; intANTCTN, intDEPCTN: integer; dtaDTAATU: TDate; dtaDTAFAT: TDate; strPCGSEQ: string): boolean;
  var dtaNovaData: TDate;
      strMotivo, strSql: string;
begin
  Result := False;
  dtaNovaData := 0;

  strSql := 'SELECT P.AUTOINCREM AS AUTINC_PCMDET, P.PCD_CODITE, P.PCD_DESITE, CM.MAR_DESMAR, ICF.ITE_CODITF, P.PCD_DTAENT, "" AS NOVA_DATA_ENTREGA ';
  strSql := strSql + 'FROM PCMDET P ';
  strSql := strSql + 'LEFT JOIN CADITE CI ON PCD_CODITE = ITE_CODITE ';
  strSql := strSql + 'LEFT JOIN CADMAR CM ON CM.MAR_CODMAR = CI.ITE_CODMAR ';
  strSql := strSql + 'LEFT JOIN ITEFOR ICF ON ICF.ITE_CODITE = P.PCD_CODITE AND ICF.ITE_CODFOR = P.PCD_CODFOR ';
  strSql := strSql + 'WHERE P.PCD_CODEMP = ' + QuotedStr(strCODEMP) + ' AND ';
  strSql := strSql + 'PCD_NUMPED = ' + QuotedStr(strNUMPED) + ' AND ';
  strSql := strSql + 'PCD_ESPDOC = ' + QuotedStr(strESPDOC) + ' AND ';
  strSql := strSql + 'IFNULL(PCD_BAIXAD,0) <> 1 GROUP BY P.PCD_CODITE;';

  FCdsItensPedidoCompra := fCriaClientDataset(strSql);
  FCdsItensPedidoCompra.IndexFieldNames := 'AUTINC_PCMDET';

  If TfrmPedeDataAlteracaoPedido.fPedeMotivo_e_NovaDataDeEntrega(dtaNovaData, strMotivo, FstrPedido, FstrFornecedor, FCdsItensPedidoCompra) Then
  Begin
    FCdsItensPedidoCompra.Filter := 'NOVA_DATA_ENTREGA <> ' + QuotedStr(EmptyStr);
    FCdsItensPedidoCompra.Filtered := True;

    if dtaNovaData = dtaDTAATU then
      dtaNovaData := 0;

    If (dtaNovaData <> 0) OR (FCdsItensPedidoCompra.RecordCount > 0) Then
    Begin
      fStartTransaction;
      Result := fAlteraData(strCODOPE, strCODEMP, strNUMPED, strESPDOC, intANTCTN, intDEPCTN,
                            dtaDTAATU, dtaNovaData, strMotivo, strPCGSEQ);
      If Result Then
        fCommit
      Else
        fRollback;
    End;
  End;
end;


function TLogAlteracaoDataPedCompra.fAlteraData(strCODOPE: string; strCODEMP: string;
  strNUMPED: string; strESPDOC: string; intANTCTN, intDEPCTN: integer; dtaDTAATU: TDate; dtaDTANOV: TDate;
  strMOTIVO: String; strPCGSEQ: String): boolean;
var
  blnSucesso: Boolean;
Begin
  blnSucesso := True;

  Try
    Try
      If dtaDTANOV <> 0 then
      begin
        qrySQL.SQL.Clear;
        qrySQL.SQL.Add('UPDATE PCMGER SET PCG_DTAENT = :DTAENTGER');
        qrySQL.SQL.Add(' WHERE PCMGER.AUTOINCREM = :AUTINC;');

        qrySQL.ParamByName('DTAENTGER').AsDate   := dtaDTANOV;
        qrySQL.ParamByName('AUTINC').AsString := strPCGSEQ;
        qrySQL.ExecSQL;

        If qrySQL.RowsAffected > 0 Then
        begin
          if not fGravaLog(strCODOPE, strCODEMP, strNUMPED, strESPDOC, intANTCTN, intDEPCTN, dtaDTAATU, dtaDTANOV, strMotivo, strPCGSEQ) then
            blnSucesso := False;
        end
        else
        begin
          blnSucesso := False;
        end;
      end;

      FCdsItensPedidoCompra.First;
      while not FCdsItensPedidoCompra.eof do
      begin
        qrySQL.Close;
        qrySQL.SQL.Clear;
        qrySQL.SQL.Add('UPDATE PCMDET SET PCD_DTAENT = :DTAENT' + IntToStr(FCdsItensPedidoCompra.RecNo));
        qrySQL.SQL.Add('WHERE PCMDET.PCD_CODEMP = :CODEMP');
        qrySQL.SQL.Add('AND PCMDET.PCD_NUMPED = :NUMPED');
        qrySQL.SQL.Add('AND PCMDET.PCD_ESPDOC = :ESPDOC');
        qrySQL.SQL.Add('AND PCMDET.PCD_BAIXAD <> 1');
        qrySQL.SQL.Add('AND PCMDET.PCD_QTDBAI <> PCMDET.PCD_QTDITE');
        qrySQL.SQL.Add('AND PCMDET.PCD_CODITE = :PCD_CODITE' + IntToStr(FCdsItensPedidoCompra.RecNo));
        qrySQL.SQL.Add(';');

        qrySQL.ParamByName('DTAENT' + IntToStr(FCdsItensPedidoCompra.RecNo)).AsDate := StrToDate(FCdsItensPedidoCompra.FieldByName('NOVA_DATA_ENTREGA').AsString);
        qrySQL.ParamByName('PCD_CODITE' + IntToStr(FCdsItensPedidoCompra.RecNo)).AsString := FCdsItensPedidoCompra.FieldByName('PCD_CODITE').AsString;

        qrySQL.ParamByName('CODEMP').AsString := strCODEMP;
        qrySQL.ParamByName('NUMPED').AsString := strNUMPED;
        qrySQL.ParamByName('ESPDOC').AsString := strESPDOC;

        qrySQL.ExecSQL;

        If qrySQL.RowsAffected > 0 Then
        begin
          if not fGravaLog(strCODOPE, strCODEMP, strNUMPED, strESPDOC, intANTCTN,
                            intDEPCTN, dtaDTAATU, StrToDate(FCdsItensPedidoCompra.FieldByName('NOVA_DATA_ENTREGA').AsString),
                            strMotivo, strPCGSEQ, FCdsItensPedidoCompra.FieldByName('AUTINC_PCMDET').AsString) then
            blnSucesso := False;
        end
        else
        begin
          blnSucesso := False;
        end;

        FCdsItensPedidoCompra.Next;
      end;

      Result := blnSucesso;
    Except
      On E:Exception do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TLogAlteracaoDataPedCompra.fAlteraData]');
      End;
    End;
  Finally
    qrySQL.SQL.Clear;
  End;
End;

function TLogAlteracaoDataPedCompra.fGravaLog(strCODOPE, strCODEMP,
  strNUMPED, strESPDOC: string; intANTCTN, intDEPCTN: integer; dtaDTAATU, dtaDTANOV: TDate;
  strMOTIVO, strPCGSEQ: String; strIteAutoincrem: string = ''): boolean;
begin
  Try
    Result := True;
    If dtaDTAATU = dtaDTANOV Then
      Exit;

    FdtaLOGDTA := fNow;
    FdtaLOGHOR := fNow;
    qrySQL.SQL.Clear;
    Try
      // Localiza o autoincrem da pcmger
      If fEmptyStr(strPCGSEQ) Then
      Begin
        qrySQL.SQL.Add('SELECT AUTOINCREM FROM PCMGER');
        qrySQL.SQL.Add(' WHERE PCG_NUMPED = :NUMPED');
        qrySQL.SQL.Add('   AND PCG_ESPDOC = :ESPDOC');
        qrySQL.SQL.Add('   AND PCG_CODEMP = :CODEMP');
        qrySQL.ParamByName('NUMPED').AsString := strNUMPED;
        qrySQL.ParamByName('ESPDOC').AsString := strESPDOC;
        qrySQL.ParamByName('CODEMP').AsString := strCODEMP;
        qrySQL.Open;
        strPCGSEQ := qrySQL.FieldByName('AUTOINCREM').AsString;
      End;

      qrySQL.SQL.Clear;

      qrySQL.SQL.Add('INSERT INTO LOGDPD (');
      qrySQL.SQL.Add('AUTOINCREM,');
      qrySQL.SQL.Add('LOG_LOGDTA,');
      qrySQL.SQL.Add('LOG_LOGHOR,');
      qrySQL.SQL.Add('LOG_CODOPE,');
      qrySQL.SQL.Add('LOG_NUMPED,');
      qrySQL.SQL.Add('LOG_ESPDOC,');
      qrySQL.SQL.Add('LOG_ANTCTN,');
      qrySQL.SQL.Add('LOG_DEPCTN,');
      qrySQL.SQL.Add('LOG_DTAATU,');
      qrySQL.SQL.Add('LOG_DTANOV,');
      qrySQL.SQL.Add('LOG_MOTIVO,');
      qrySQL.SQL.Add('LOG_PCGSEQ,');
      qrySQL.SQL.Add('LOG_PCDSEQ,');
      qrySQL.SQL.Add('LOG_CODEMP) VALUES (');
      qrySQL.SQL.Add(':AUTINC,');
      qrySQL.SQL.Add(':LOGDTA,');
      qrySQL.SQL.Add(':LOGHOR,');
      qrySQL.SQL.Add(':CODOPE,');
      qrySQL.SQL.Add(':NUMPED,');
      qrySQL.SQL.Add(':ESPDOC,');
      qrySQL.SQL.Add(':ANTCTN,');
      qrySQL.SQL.Add(':DEPCTN,');
      qrySQL.SQL.Add(':DTAATU,');
      qrySQL.SQL.Add(':DTANOV,');
      qrySQL.SQL.Add(':MOTIVO,');
      qrySQL.SQL.Add(':PCGSEQ,');
      qrySQL.SQL.Add(':PCDSEQ,');
      qrySQL.SQL.Add(':CODEMP)');
      qrySQL.ParamByName('AUTINC').AsString := fRetAutoIncrem('LOGDPD', VS_strCodEmp);
      qrySQL.ParamByName('LOGDTA').AsDateTime := FdtaLOGDTA;
      qrySQL.ParamByName('LOGHOR').AsDateTime := FdtaLOGHOR;
      qrySQL.ParamByName('CODOPE').AsString := strCODOPE;
      qrySQL.ParamByName('NUMPED').AsString := strNUMPED;
      qrySQL.ParamByName('ESPDOC').AsString := strESPDOC;
      qrySQL.ParamByName('ANTCTN').AsInteger:= intANTCTN;
      qrySQL.ParamByName('DEPCTN').AsInteger:= intDEPCTN;
      qrySQL.ParamByName('DTAATU').AsDateTime := dtaDTAATU;
      qrySQL.ParamByName('DTANOV').AsDateTime := dtaDTANOV;
      qrySQL.ParamByName('MOTIVO').AsString := strMOTIVO;
      qrySQL.ParamByName('PCGSEQ').AsString := strPCGSEQ;
      qrySQL.ParamByName('CODEMP').AsString := strCODEMP;
      qrySQL.ParamByName('PCDSEQ').AsString := strIteAutoincrem;

      qrySQL.ExecSQL;
    Finally
      qrySQL.SQL.Clear;
    End;
  except
    On E:Exception do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TLogAlteracaoDataPedCompra.fGravarLog]');
    End;
  End;
end;

procedure TLogAlteracaoDataPedCompra.pSetTituloTela(strPedido,
  strFornecedor: String);
begin
  FstrPedido := strPedido;
  FstrFornecedor := strFornecedor;
end;

procedure TLogAlteracaoDataPedCompra.pShowHistoricoLog(strPCGSEQ: string; blnMensagemVazio: boolean = False);
var
  qryBuscaLogProduto: TUniQuery;
begin
  If fEmptyStr(strPCGSEQ) Then
    Exit;
  qrySQL.SQL.Clear;

  qryBuscaLogProduto := fCriaQuery;

  Try
    qrySQL.SQL.Add('SELECT');
    qrySQL.SQL.Add('  LOG_LOGDTA AS LOGDTA,');
    qrySQL.SQL.Add('  LOG_LOGHOR AS LOGHOR,');
    qrySQL.SQL.Add('  LOG_CODOPE AS CODOPE,');
    qrySQL.SQL.Add('  LOG_DTAATU AS DTAATU,');
    qrySQL.SQL.Add('  LOG_DTANOV AS DTANOV,');
    qrySQL.SQL.Add('  LOG_MOTIVO AS MOTIVO,');
    qrySQL.SQL.Add('  CONCAT("Pedido: ", LOG_NUMPED, "-", LOG_ESPDOC, "-", LOG_CODEMP) AS  PEDIDO,');
    qrySQL.SQL.Add('  CONCAT("Fornecedor: ", PCG_CODFOR, "-", FOR_NOMFOR) AS FORNEC');
    qrySQL.SQL.Add('FROM LOGDPD');
    qrySQL.SQL.Add('INNER JOIN PCMGER ON PCMGER.AUTOINCREM = LOG_PCGSEQ');
    qrySQL.SQL.Add('LEFT JOIN CADFOR ON FOR_CODFOR = PCMGER.PCG_CODFOR');
    qrySQL.SQL.Add('WHERE LOG_PCGSEQ = ' + QuotedStr(strPCGSEQ));
    qrySQL.SQL.Add('AND (LOG_PCDSEQ = "" OR LOG_PCDSEQ IS NULL)');
    qrySQL.SQL.Add('ORDER BY LOG_LOGDTA, LOG_LOGHOR');
    qrySQL.Open;

    qryBuscaLogProduto.SQL.Add(fRetornaSQLLogItens);
    qryBuscaLogProduto.ParamByName('LOG_PCGSEQ').AsString := strPCGSEQ;
    qryBuscaLogProduto.Open;

    If (qrySQL.IsEmpty) AND (qryBuscaLogProduto.IsEmpty) Then
    Begin
      If blnMensagemVazio Then
        pMensagemOk('Este pedido não teve data de entrega alterada.');
      Exit;
    End;
    pCriarFormularios(TfrmLogAlteracaoDataPedidoCompra, frmLogAlteracaoDataPedidoCompra);
    Try
      frmLogAlteracaoDataPedidoCompra.dtsDados.DataSet := qrySQL;
      frmLogAlteracaoDataPedidoCompra.dtsDadosItens.DataSet := qryBuscaLogProduto;
      frmLogAlteracaoDataPedidoCompra.Showmodal;
    Finally
      FreeAndNil(frmLogAlteracaoDataPedidoCompra);
    End;
  Finally
    qrySQL.SQL.Clear;
    FreeAndNil(qryBuscaLogProduto);
  End;
end;

function TLogAlteracaoDataPedCompra.fRetornaSQLLogItens: string;
var
  strSql: string;
begin
  strSql := 'SELECT';
  strSql := strSql + ' LOG_LOGDTA AS LOGDTA,';
  strSql := strSql + ' LOG_LOGHOR AS LOGHOR,';
  strSql := strSql + ' LOG_CODOPE AS CODOPE,';
  strSql := strSql + ' LOG_DTAATU AS DTAATU,';
  strSql := strSql + ' LOG_DTANOV AS DTANOV,';
  strSql := strSql + ' LOG_MOTIVO AS MOTIVO,';
  strSql := strSql + ' CONCAT("Pedido: ", LOG_NUMPED, "-", LOG_ESPDOC, "-", LOG_CODEMP) AS  PEDIDO,';
  strSql := strSql + ' CONCAT("Fornecedor: ", PCG_CODFOR, "-", FOR_NOMFOR) AS FORNEC,';
  strSql := strSql + ' PCD_CODITE,';
  strSql := strSql + ' PCD_DESITE';
  strSql := strSql + ' FROM LOGDPD';
  strSql := strSql + ' INNER JOIN PCMGER ON PCMGER.AUTOINCREM = LOG_PCGSEQ';
  strSql := strSql + ' LEFT JOIN CADFOR ON FOR_CODFOR = PCMGER.PCG_CODFOR';
  strSql := strSql + ' LEFT JOIN PCMDET ON PCMDET.AUTOINCREM = LOG_PCDSEQ';
  strSql := strSql + ' WHERE LOG_PCGSEQ = :LOG_PCGSEQ';
  strSql := strSql + ' AND LOG_PCDSEQ <> ""';
  strSql := strSql + ' ORDER BY LOG_LOGDTA, LOG_LOGHOR';

  Result := strSql;
end;

end.
