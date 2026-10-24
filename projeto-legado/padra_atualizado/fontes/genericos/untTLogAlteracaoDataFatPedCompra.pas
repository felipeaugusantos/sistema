unit untTLogAlteracaoDataFatPedCompra;

interface

uses SysUtils, uni, Data.DB;

Type
  TLogAlteracaoDataFatPedCompra = class
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
                       strPCGSEQ: String;
                       blnAlteraItens: Boolean): boolean;
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
                         dtaDTAENT: TDate;
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
                       strPCGSEQ: String): boolean;

   procedure pShowHistoricoLog(strPCGSEQ: string; blnMensagemVazio: boolean = False);
end;

implementation

{ untLogAlteracaoDataPedidoCompra }

uses untFuncoesSimples, untLogAlteracaoDataFatPedidoCompra,
  untPedeDataFatAlteracaoPedido;

constructor TLogAlteracaoDataFatPedCompra.Create;
begin
  qrySQL := fCriaQuery;
end;

destructor TLogAlteracaoDataFatPedCompra.Destroy;
begin
  FreeAndNil(qrySQL);
end;

function TLogAlteracaoDataFatPedCompra.fPede_e_AlteraData(strCODOPE, strCODEMP, strNUMPED,
  strESPDOC: string; intANTCTN, intDEPCTN: integer; dtaDTAENT: TDate; dtaDTAFAT: TDate; strPCGSEQ: string): boolean;
  var dtaNovaData: TDate;
      strMotivo: string;
      blnAlteraItens: Boolean;
begin
  Result := False;
  dtaNovaData := 0;
  blnAlteraItens := False;

  TfrmPedeDataFatAlteracaoPedido.pPedeMotivo_e_NovaDataDeFaturamento(dtaNovaData, dtaDTAENT, dtaDTAFAT, strMotivo, FstrPedido, FstrFornecedor, blnAlteraItens);
  If dtaNovaData <> 0 Then
  Begin
    fStartTransaction;
    Result := fAlteraData(strCODOPE, strCODEMP, strNUMPED, strESPDOC, intANTCTN, intDEPCTN,
                          dtaDTAFAT, dtaNovaData, strMotivo, strPCGSEQ, blnAlteraItens);
    If Result Then
      fCommit
    Else
      fRollback;
  End;
end;


function TLogAlteracaoDataFatPedCompra.fAlteraData(strCODOPE: string; strCODEMP: string;
  strNUMPED: string; strESPDOC: string; intANTCTN, intDEPCTN: integer; dtaDTAATU: TDate; dtaDTANOV: TDate;
  strMOTIVO: String; strPCGSEQ: String; blnAlteraItens: Boolean): boolean;
 var
   intQtdDias: integer;
   strMultLojas: String;
begin
  Try
    Try

      qrySQL.SQL.Clear;
      qrySQL.SQL.Add('SELECT DATEDIFF(:DTAFAT, PCG_DTAFAT) AS QTDDIAS,');
      qrySQL.SQL.Add(' PCG_PEDMLJ ');
      qrySQL.SQL.Add(' FROM PCMGER');
      qrySQL.SQL.Add(' WHERE PCMGER.AUTOINCREM = :AUTINC;');
      qrySQL.ParamByName('DTAFAT').AsDate   := dtaDTANOV;
      qrySQL.ParamByName('AUTINC').AsString := strPCGSEQ;
      qrySQL.Open;

      intQtdDias    := qrySQL.FieldByName('QTDDIAS').AsInteger;
      strMultLojas  := qrySQL.FieldByName('PCG_PEDMLJ').AsString;

      qrySQL.SQL.Clear;
      qrySQL.SQL.Add('UPDATE PCMGER SET PCG_DTAFAT = :DTAFAT');
      qrySQL.SQL.Add(' WHERE PCMGER.AUTOINCREM = :AUTINC;');
      qrySQL.ParamByName('DTAFAT').AsDate   := dtaDTANOV;
      qrySQL.ParamByName('AUTINC').AsString := strPCGSEQ;
      qrySQL.ExecSQL;

      if blnAlteraItens Then
      Begin

        qrySQL.SQL.Clear;
        qrySQL.SQL.Add('UPDATE PCMDET SET PCD_DTAENT = DATE_ADD(PCD_DTAENT, INTERVAL ' + intQtdDias.ToString + ' DAY) ');
        qrySQL.SQL.Add('   WHERE ');

        if strMultLojas = 'N' Then
          qrySQL.SQL.Add(' PCMDET.PCD_CODEMP = :CODEMP AND ');

        qrySQL.SQL.Add('     PCMDET.PCD_NUMPED = :NUMPED');
        qrySQL.SQL.Add('     AND PCMDET.PCD_ESPDOC = :ESPDOC');
        qrySQL.SQL.Add('     AND PCMDET.PCD_BAIXAD <> 1');

        if strMultLojas = 'N' Then
          qrySQL.ParamByName('CODEMP').AsString := strCODEMP;

        qrySQL.ParamByName('NUMPED').AsString := strNUMPED;
        qrySQL.ParamByName('ESPDOC').AsString := strESPDOC;

         qrySQL.ExecSQL;

      End;

      If qrySQL.RowsAffected > 0 Then
        Result := fGravaLog(strCODOPE, strCODEMP, strNUMPED, strESPDOC, intANTCTN, intDEPCTN,
                              dtaDTAATU, dtaDTANOV, strMotivo, strPCGSEQ)
      Else
        Result := True;
    Except
      On E:Exception do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TLogAlteracaoDataFatPedCompra.fAlteraData]');
      End;
    End;
  Finally
    qrySQL.SQL.Clear;
  End;
End;

function TLogAlteracaoDataFatPedCompra.fGravaLog(strCODOPE, strCODEMP,
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

      qrySQL.SQL.Add('INSERT INTO LPDFAT (');
      qrySQL.SQL.Add('AUTOINCREM,');
      qrySQL.SQL.Add('LPD_LOGDTA,');
      qrySQL.SQL.Add('LPD_LOGHOR,');
      qrySQL.SQL.Add('LPD_CODOPE,');
      qrySQL.SQL.Add('LPD_NUMPED,');
      qrySQL.SQL.Add('LPD_ESPDOC,');
      qrySQL.SQL.Add('LPD_ANTCTN,');
      qrySQL.SQL.Add('LPD_DEPCTN,');
      qrySQL.SQL.Add('LPD_DTAATU,');
      qrySQL.SQL.Add('LPD_DTANOV,');
      qrySQL.SQL.Add('LPD_MOTIVO,');
      qrySQL.SQL.Add('LPD_PCGSEQ,');
      qrySQL.SQL.Add('LPD_CODEMP) VALUES (');
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

      qrySQL.ExecSQL;
    Finally
      qrySQL.SQL.Clear;
    End;
  except
    On E:Exception do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TLogAlteracaoDataFatPedCompra.fGravarLog]');
    End;
  End;
end;

procedure TLogAlteracaoDataFatPedCompra.pSetTituloTela(strPedido,
  strFornecedor: String);
begin
  FstrPedido := strPedido;
  FstrFornecedor := strFornecedor;
end;

procedure TLogAlteracaoDataFatPedCompra.pShowHistoricoLog(strPCGSEQ: string; blnMensagemVazio: boolean = False);
begin
  If fEmptyStr(strPCGSEQ) Then
    Exit;
  qrySQL.SQL.Clear;
  Try
    qrySQL.SQL.Add('SELECT');
    qrySQL.SQL.Add('  LPD_LOGDTA AS LOGDTA,');
    qrySQL.SQL.Add('  LPD_LOGHOR AS LOGHOR,');
    qrySQL.SQL.Add('  LPD_CODOPE AS CODOPE,');
    qrySQL.SQL.Add('  LPD_DTAATU AS DTAATU,');
    qrySQL.SQL.Add('  LPD_DTANOV AS DTANOV,');
    qrySQL.SQL.Add('  LPD_MOTIVO AS MOTIVO,');
    qrySQL.SQL.Add('  CONCAT("Pedido: ", LPD_NUMPED, "-", LPD_ESPDOC, "-", LPD_CODEMP) AS  PEDIDO,');
    qrySQL.SQL.Add('  CONCAT("Fornecedor: ", PCG_CODFOR, "-", FOR_NOMFOR) AS FORNEC');
    qrySQL.SQL.Add('FROM LPDFAT');
    qrySQL.SQL.Add('INNER JOIN PCMGER ON PCMGER.AUTOINCREM = LPD_PCGSEQ');
    qrySQL.SQL.Add('LEFT JOIN CADFOR ON FOR_CODFOR = PCMGER.PCG_CODFOR');
    qrySQL.SQL.Add('WHERE LPD_PCGSEQ = ' + QuotedStr(strPCGSEQ));
    qrySQL.SQL.Add('ORDER BY LPD_LOGDTA, LPD_LOGHOR');
    qrySQL.Open;
    If qrySQL.IsEmpty Then
    Begin
      If blnMensagemVazio Then
        pMensagemOk('Este pedido não teve data de faturamento alterada.');
      Exit;
    End;
    pCriarFormularios(TfrmLogAlteracaoDataFatPedidoCompra, frmLogAlteracaoDataFatPedidoCompra);
    Try
      frmLogAlteracaoDataFatPedidoCompra.dtsDados.DataSet := qrySQL;
      frmLogAlteracaoDataFatPedidoCompra.Showmodal;
    Finally
      FreeAndNil(frmLogAlteracaoDataFatPedidoCompra);
    End;
  Finally
    qrySQL.SQL.Clear;
  End;
end;

end.
