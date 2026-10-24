unit untTLogAlteracaoDataPedCompra;

interface

uses SysUtils, uni, Data.DB;

Type
  TLogAlteracaoDataPedCompra = class
  private
    FdtaLOGDTA: TDate;
    FdtaLOGHOR: TTime;
    qrySQL: TUniQuery;
    FstrPedido: string;
    FstrFornecedor: String;
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
                       strPCGSEQ: String): boolean;

   procedure pShowHistoricoLog(strPCGSEQ: string; blnMensagemVazio: boolean = False);
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
end;

function TLogAlteracaoDataPedCompra.fPede_e_AlteraData(strCODOPE, strCODEMP, strNUMPED,
  strESPDOC: string; intANTCTN, intDEPCTN: integer; dtaDTAATU: TDate; strPCGSEQ: string): boolean;
  var dtaNovaData: TDate;
      strMotivo: string;
begin
  Result := False;
  dtaNovaData := 0;

  TfrmPedeDataAlteracaoPedido.pPedeMotivo_e_NovaDataDeEntrega(dtaNovaData, strMotivo, FstrPedido, FstrFornecedor);
  If dtaNovaData <> 0 Then
  Begin
    fStartTransaction;
    Result := fAlteraData(strCODOPE, strCODEMP, strNUMPED, strESPDOC, intANTCTN, intDEPCTN,
                          dtaDTAATU, dtaNovaData, strMotivo, strPCGSEQ);
    If Result Then
      fCommit
    Else
      fRollback;
  End;
end;


function TLogAlteracaoDataPedCompra.fAlteraData(strCODOPE: string; strCODEMP: string;
  strNUMPED: string; strESPDOC: string; intANTCTN, intDEPCTN: integer; dtaDTAATU: TDate; dtaDTANOV: TDate;
  strMOTIVO: String; strPCGSEQ: String): boolean;
Begin
  qrySQL.SQL.Clear;
  Try
    Try
      qrySQL.SQL.Add('UPDATE PCMGER SET PCG_DTAENT = :DTAENT');
      qrySQL.SQL.Add(' WHERE PCMGER.AUTOINCREM = :AUTINC;');

      qrySQL.SQL.Add('UPDATE PCMDET SET PCD_DTAENT = :DTAENT');
      qrySQL.SQL.Add('   WHERE PCMDET.PCD_CODEMP = :CODEMP');
      qrySQL.SQL.Add('     AND PCMDET.PCD_NUMPED = :NUMPED');
      qrySQL.SQL.Add('     AND PCMDET.PCD_ESPDOC = :ESPDOC');
      qrySQL.SQL.Add('     AND PCMDET.PCD_BAIXAD <> 1');
      qrySQL.SQL.Add('     AND PCMDET.PCD_QTDBAI <> PCMDET.PCD_QTDITE');

      qrySQL.ParamByName('DTAENT').AsDate   := dtaDTANOV;
      qrySQL.ParamByName('AUTINC').AsString := strPCGSEQ;
      qrySQL.ParamByName('CODEMP').AsString := strCODEMP;
      qrySQL.ParamByName('NUMPED').AsString := strNUMPED;
      qrySQL.ParamByName('ESPDOC').AsString := strESPDOC;

      qrySQL.ExecSQL;
      If qrySQL.RowsAffected > 0 Then
        Result := fGravaLog(strCODOPE, strCODEMP, strNUMPED, strESPDOC, intANTCTN, intDEPCTN,
                              dtaDTAATU, dtaDTANOV, strMotivo, strPCGSEQ)
      Else
        Result := True;
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
  strMOTIVO, strPCGSEQ: String): boolean;
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
      qrySQL.SQL.Add('LOG_CODEMP) VALUES (');
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
      qrySQL.SQL.Add(':CODEMP)');
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
begin
  If fEmptyStr(strPCGSEQ) Then
    Exit;
  qrySQL.SQL.Clear;
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
    qrySQL.SQL.Add('ORDER BY LOG_LOGDTA, LOG_LOGHOR');
    qrySQL.Open;
    If qrySQL.IsEmpty Then
    Begin
      If blnMensagemVazio Then
        pMensagemOk('Este pedido não teve data de entrega alterada.');
      Exit;
    End;
    pCriarFormularios(TfrmLogAlteracaoDataPedidoCompra, frmLogAlteracaoDataPedidoCompra);
    Try
      frmLogAlteracaoDataPedidoCompra.dtsDados.DataSet := qrySQL;
      frmLogAlteracaoDataPedidoCompra.Showmodal;
    Finally
      FreeAndNil(frmLogAlteracaoDataPedidoCompra);
    End;
  Finally
    qrySQL.SQL.Clear;
  End;
end;

end.
