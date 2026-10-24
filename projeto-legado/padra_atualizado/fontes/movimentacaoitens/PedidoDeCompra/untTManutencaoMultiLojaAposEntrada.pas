unit untTManutencaoMultiLojaAposEntrada;

interface

uses Classes, SysUtils, untGerenciaTransferenciaPedidoCompraMultiLoja,
     untFuncoesSimples, UniClientDataSet, Uni, untZClient, Data.DB, Math,
     cxProgressBar;

Type
  TManutencaoMultiLojaAposEntrada = class
  private
    qryPedido: TUniQuery;
    FPedidoCompra: TpedidoCompra;
    cdsPcmDet : TZClient;
    cdsPcdDet : TZClient;

    procedure pMontaSQLPcmDet;
    procedure pMontaSQLPcdDet;
    procedure pCriaPcmDet;
    procedure pCriaPcdDet;
    procedure onCdsPcmDetAfterScroll(DataSet: TDataSet);
    procedure onCdsPcmDetBeforePost(DataSet: TDataSet);
    procedure pDistribuiPcdDet(fltQtd: double);
    procedure pAtualizaSaldoPDC;
    function fGravaAlteracoesAux(pcxProgress : TcxProgressbar): Boolean;
    function fAtualizaDadosPcmDet(strSeqPcd: String; fltQtdIte: Double): Boolean;
  public
    dtsPcmDet: TDataSource;
    dtsPcddet: TDataSource;
    constructor create;
    function fCarregaPedido(APedidoCompra: TpedidoCompra): Boolean;
    destructor Destroy; override;
    procedure Reinicia;
    function fGravaAlteracoes: Boolean;
  end;




implementation

uses
  untSaldoPedidoCompra, untGravando;

{ TManutencaoMultiLojaAposEntrada }

constructor TManutencaoMultiLojaAposEntrada.create;
begin
  qryPedido := fCriaQuery;
  dtsPcmDet := TDataSource.Create(nil);
  dtsPcdDet := TDataSource.Create(nil);
end;

destructor TManutencaoMultiLojaAposEntrada.Destroy;
begin
  FreeAndNil(qryPedido);
  FreeAndNil(dtsPcmDet);
  FreeAndNil(dtsPcdDet);
  If Assigned(cdsPcdDet) Then
    FreeAndNil(cdsPcdDet);
  If Assigned(cdsPcmDet) Then
    FreeAndNil(cdsPcmDet);
  inherited;
end;

function TManutencaoMultiLojaAposEntrada.fCarregaPedido(
  APedidoCompra: TpedidoCompra): Boolean;
begin
  Result := True;
  FPedidoCompra := APedidoCompra;
  qryPedido.SQL.Clear;

  qryPedido.SQL.Add('SELECT COUNT(1) AS QTD');
  qryPedido.SQL.Add('  FROM PCDDET');
  qryPedido.SQL.Add(' WHERE PCD_NUMPED = ' + FPedidoCompra.strNumped.QuotedString);
  qryPedido.SQL.Add('   AND PCD_CODEMP = ' + FPedidoCompra.strCodEmp.QuotedString);
  qryPedido.SQL.Add('   AND PCD_ESPDOC = ' + FPedidoCompra.strEspPed.QuotedString);
  qryPedido.Open;
  If qryPedido.IsEmpty Then
  Begin
    Result := False;
    pMensagemOk('O Pedido informado não é multi-loja, não será possível carregar!');
    Exit;
  End;

  pCriaPcmDet;
  If cdsPcmDet.IsEmpty Then
  Begin
    Result := False;
    pMensagemOk('O Pedido informado não foi encontrado!');
    Exit;
  End;

  pCriaPcdDet;
  cdsPcmDet.First;

  dtsPcmDet.DataSet := cdsPcmDet;
  dtsPcdDet.DataSet := cdsPcdDet;
end;

procedure TManutencaoMultiLojaAposEntrada.onCdsPcmDetAfterScroll(
  DataSet: TDataSet);
begin
  cdsPcdDet.DisableControls;
  Try
    cdsPcdDet.Filtered := False;
    cdsPcdDet.Filter := 'INCPCMDET = ' + QuotedStr(DataSet.FieldByName('AUTOINCREM').AsString);
    cdsPcdDet.Filtered := True;
  Finally
    cdsPcdDet.EnableControls;

  End;
end;

procedure TManutencaoMultiLojaAposEntrada.onCdsPcmDetBeforePost(
  DataSet: TDataSet);
begin
  If cdsPcmDet.FieldByName('BAIXAD').AsString = 'S' Then
    cdsPcmDet.FieldByName('PCD_QTDRES').AsFloat := 0;

  If cdsPcmDet.FieldByName('PCD_QTDRES').AsFloat < 0 Then
    cdsPcmDet.FieldByName('PCD_QTDRES').AsFloat := 0;


  cdsPcmDet.FieldByName('PCD_QTDITE').AsFloat := cdsPcmDet.FieldByName('PCD_QTDBAI').AsFloat +
                                                 cdsPcmDet.FieldByName('PCD_QTDRES').AsFloat;

  If cdsPcmDet.FieldByName('PCD_QTDITE').AsFloat > cdsPcmDet.FieldByName('PCD_QTDITE_ORIGINAL').AsFloat Then
  begin
    pMensagemOk('A Quantidade não pode exceder a quantidade original do pedido.');
    cdsPcmDet.FieldByName('PCD_QTDRES').AsFloat := cdsPcmDet.FieldByName('PCD_QTDRES_ORIGINAL').AsFloat;
    cdsPcmDet.FieldByName('PCD_QTDITE').AsFloat := cdsPcmDet.FieldByName('PCD_QTDBAI').AsFloat +
                                                   cdsPcmDet.FieldByName('PCD_QTDRES').AsFloat;
  End;

  pDistribuiPcdDet(cdsPcmDet.FieldByName('PCD_QTDITE').AsFloat);
end;

procedure TManutencaoMultiLojaAposEntrada.pCriaPcdDet;
begin
  If Assigned(cdsPcdDet) Then
    FreeAndNil(cdsPcdDet);
  cdsPcdDet := TZClient.Create(nil);
  pMontaSQLPcdDet;
  cdsPcdDet.fAbreClient(False,'TManutencaoMultiLojaAposEntrada.pCriaPcdDet');
end;

procedure TManutencaoMultiLojaAposEntrada.pCriaPcmDet;
begin
  If Assigned(cdsPcmDet) Then
    FreeAndNil(cdsPcmDet);
  cdsPcmDet := TZClient.Create(nil);
  pMontaSQLPcmDet;
  cdsPcmDet.fAbreClient(False,'TManutencaoMultiLojaAposEntrada.pCriaPcmDet');

  cdsPcmdet.AfterScroll := onCdsPcmDetAfterScroll;
  cdsPcmdet.BeforePOst  := onCdsPcmDetBeforePost;

end;

procedure TManutencaoMultiLojaAposEntrada.pDistribuiPcdDet(fltQtd: double);
begin
  cdsPcdDet.First;
  while not cdsPcdDet.Eof Do
  begin
    cdsPcdDet.Edit;
    cdsPcdDet.FieldByName('PCD_QTDITE').AsFloat :=  RoundTo((fltQtd * cdsPcdDet.FieldByName('REPRES').AsFloat) / 100, -4);
    cdsPcdDet.Post;
    cdsPcdDet.Next;
  End;
end;

procedure TManutencaoMultiLojaAposEntrada.pMontaSQLPcdDet;
begin
  cdsPcdDet.qryQuery.SQL.Add('SELECT PCMDET.AUTOINCREM AS INCPCMDET,');
  cdsPcdDet.qryQuery.SQL.Add('       PCDDET.AUTOINCREM AS INCPCDDET,');
  cdsPcdDet.qryQuery.SQL.Add('       CONCAT(PCDDET.PCD_EMPDES, "-",EMP_NOMEMP) AS PCD_CODEMP, ');
  cdsPcdDet.qryQuery.SQL.Add('       PCMDET.PCD_CODITE,');
  cdsPcdDet.qryQuery.SQL.Add('       PCMDET.PCD_DESITE,');
  cdsPcdDet.qryQuery.SQL.Add('       PCDDET.PCD_QTDITE,');
  cdsPcdDet.qryQuery.SQL.Add('       @RESPRES := (PCDDET.PCD_QTDITE * 100) /PCMDET.PCD_QTDITE REPRES,');
  cdsPcdDet.qryQuery.SQL.Add('       ROUND(PCMDET.PCD_QTDBAI * @RESPRES / 100, 4) PCD_QTDBAI,');
  cdsPcdDet.qryQuery.SQL.Add('       SUM(IFNULL(DETTRA.TRA_QTDITE, 0)) AS PCD_QTDTRA');
  cdsPcdDet.qryQuery.SQL.Add('  FROM PCMDET');
  cdsPcdDet.qryQuery.SQL.Add(' INNER JOIN PCDDET ON PCDDET.PCD_SEQGER = PCMDET.AUTOINCREM');
  cdsPcdDet.qryQuery.SQL.Add(' INNER JOIN CADEMP ON EMP_CODEMP = PCDDET.PCD_EMPDES');

  cdsPcdDet.qryQuery.SQL.Add('  LEFT JOIN DETTRA ON TRA_PCDDET =  PCDDET.AUTOINCREM');
  cdsPcdDet.qryQuery.SQL.Add(' WHERE PCMDET.PCD_NUMPED = '+FPedidoCompra.strNumped.QuotedString);
  cdsPcdDet.qryQuery.SQL.Add('   AND PCMDET.PCD_CODEMP = '+FPedidoCompra.strCodEmp.QuotedString);
  cdsPcdDet.qryQuery.SQL.Add('   AND PCMDET.PCD_ESPDOC = '+FPedidoCompra.strEspPed.QuotedString);
  cdsPcdDet.qryQuery.SQL.Add('   GROUP BY PCDDET.AUTOINCREM');
end;

procedure TManutencaoMultiLojaAposEntrada.pMontaSQLPcmDet;
begin
  cdsPcmDet.qryQuery.SQL.Add('SET @QTDBAIPED := 0; ');
  cdsPcmDet.qryQuery.SQL.Add('SET @QTDDEFBAI := 0; ');

  cdsPcmDet.qryQuery.SQL.Add('SELECT PCMDET.AUTOINCREM,');
  cdsPcmDet.qryQuery.SQL.Add('       PCMDET.PCD_CODITE,');
  cdsPcmDet.qryQuery.SQL.Add('       PCMDET.PCD_DESITE,');
  cdsPcmDet.qryQuery.SQL.Add('       PCMDET.PCD_QTDITE,');
  cdsPcmDet.qryQuery.SQL.Add('       PCMDET.PCD_QTDITE AS PCD_QTDITE_ORIGINAL,');


  cdsPcmDet.qryQuery.SQL.Add('       @QTDBAIPED  := IFNULL(( SELECT  SUM(IFNULL(BAI_QTDPED, 0)) FROM BAIPED WHERE BAI_AUTPED = PCMDET.AUTOINCREM), 0) AS QTDBAIPED, ');
  cdsPcmDet.qryQuery.SQL.Add('       @QTDDEFBAI  := IFNULL(( SELECT  SUM(IFNULL(DEF_QTDITE, 0)) FROM DEFBAI WHERE DEF_AUTPCD = PCMDET.AUTOINCREM), 0) AS QTDDEFBAI, ');

  cdsPcmDet.qryQuery.SQL.Add('       ROUND((IF(@QTDBAIPED = 0, @QTDDEFBAI , @QTDBAIPED) / IF(IFNULL(PCMDET.PCD_EMBALA, 0) = 0, 1, PCMDET.PCD_EMBALA)), 4) AS PCD_QTDBAI, ');

  cdsPcmDet.qryQuery.SQL.Add('       ROUND(PCMDET.PCD_QTDITE-(IF(@QTDBAIPED = 0, @QTDDEFBAI , @QTDBAIPED) / IF(IFNULL(PCMDET.PCD_EMBALA, 0) = 0, 1, PCMDET.PCD_EMBALA)), 4) AS PCD_QTDRES, ');
  cdsPcmDet.qryQuery.SQL.Add('       ROUND(PCMDET.PCD_QTDITE-(IF(@QTDBAIPED = 0, @QTDDEFBAI , @QTDBAIPED) / IF(IFNULL(PCMDET.PCD_EMBALA, 0) = 0, 1, PCMDET.PCD_EMBALA)), 4) AS PCD_QTDRES_ORIGINAL, ');

  cdsPcmDet.qryQuery.SQL.Add('       SUM(IFNULL(DETTRA.TRA_QTDITE, 0)) AS PCD_QTDTRA,');
  cdsPcmDet.qryQuery.SQL.Add('       "N" AS BAIXAD,');
  cdsPcmDet.qryQuery.SQL.Add('       PCDDET.AUTOINCREM');
  cdsPcmDet.qryQuery.SQL.Add('  FROM PCMDET');
  cdsPcmDet.qryQuery.SQL.Add(' INNER JOIN PCDDET ON PCDDET.PCD_SEQGER = PCMDET.AUTOINCREM');
  cdsPcmDet.qryQuery.SQL.Add('  LEFT JOIN DETTRA ON TRA_PCDDET =  PCDDET.AUTOINCREM');
  cdsPcmDet.qryQuery.SQL.Add(' WHERE PCMDET.PCD_NUMPED = '+FPedidoCompra.strNumped.QuotedString);
  cdsPcmDet.qryQuery.SQL.Add('   AND PCMDET.PCD_CODEMP = '+FPedidoCompra.strCodEmp.QuotedString);
  cdsPcmDet.qryQuery.SQL.Add('   AND PCMDET.PCD_ESPDOC = '+FPedidoCompra.strEspPed.QuotedString);
  cdsPcmDet.qryQuery.SQL.Add('   GROUP BY PCMDET.AUTOINCREM;');
end;

procedure TManutencaoMultiLojaAposEntrada.Reinicia;
begin
  If Assigned(cdsPcmDet) Then
    FreeAndNil(cdsPcmDet);
  If Assigned(cdsPcdDet) Then
    FreeAndNil(cdsPcdDet);
end;

procedure TManutencaoMultiLojaAposEntrada.pAtualizaSaldoPDC;
var
  qryGenDet: TUniQuery;
begin
  qryGenDet := fCriaQuery;
  Try
    qryGenDet.SQL.Add('CALL pAtualizaSaldoPedidoCompra');
    qryGenDet.ExecSQL;
  finally
    FreeAndNil(qryGenDet);
  End;
End;

function TManutencaoMultiLojaAposEntrada.fAtualizaDadosPcmDet(strSeqPcd: String; fltQtdIte: Double): Boolean;
  Var
    qryGenDet: TUniQuery;
    strUniPcg: String;
begin
  strUniPcg := fCfgSis('UNIPCG', VarString);
  Result := True;
  Try
    qryGenDet := fCriaQuery;
    Try
      If fltQtdIte = 0 Then
      begin
        qryGenDet.SQL.Add('DELETE FROM PCMDET WHERE AUTOINCREM = :AUTINC;');
        qryGenDet.ParamByName('AUTINC').AsString  := strSeqPcd;
      End
      Else
      Begin
        qryGenDet.SQL.Add('UPDATE PCMDET D');
        qryGenDet.SQL.Add(' INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED');
        qryGenDet.SQL.Add('                 AND PCG_CODEMP = PCD_CODEMP');
        qryGenDet.SQL.Add('                 AND PCG_ESPDOC = PCD_ESPDOC');
        qryGenDet.SQL.Add('   SET  PCD_QTDITE = :QTDITE,');
        qryGenDet.SQL.Add('        PCD_TOTITE = PCD_UNITAR * (' + fSQLFatorDesUni + ' *');
        qryGenDet.SQL.Add('                                   (1 - PCD_DESUN2 / 100) *');
        qryGenDet.SQL.Add('                                   (1 - PCD_DESUN3 / 100) *');
        qryGenDet.SQL.Add('                                   (1 - PCD_DESUN4 / 100) *');
        qryGenDet.SQL.Add('                                   (1 - PCD_DESUN5 / 100) *');
        qryGenDet.SQL.Add('                                   (1 - PCD_DESUN6 / 100) *');
        qryGenDet.SQL.Add('                                   ' + fSQLFatorDesAdi(strUniPcg) + ') * :QTDITE, ');

        qryGenDet.SQL.Add('        PCD_TOTSUB = PCD_TOTITE * IFNULL(PCD_PERSUB, 0) / 100,');
        qryGenDet.SQL.Add('        PCD_TOTIPI = PCD_TOTITE * IFNULL(PCD_PERIPI, 0) / 100');
        qryGenDet.SQL.Add('  WHERE D.AUTOINCREM = :AUTINC;');
        qryGenDet.ParamByName('QTDITE').AsFloat := fltQtdIte;
        qryGenDet.ParamByName('AUTINC').AsString  := strSeqPcd;
        qryGenDet.ExecSQL;
        qryGenDet.SQL.Clear;
        qryGenDet.SQL.Add('UPDATE PCMDET D SET');
        qryGenDet.SQL.Add('       PCD_VALFRE = ROUND(@FREUNI * (PCD_QTDITE - PCD_QTDBAI), 2)');
        qryGenDet.SQL.Add('       ,PCD_DESACE = ROUND(@ACEUNI * (PCD_QTDITE - PCD_QTDBAI), 2)');
        qryGenDet.SQL.Add('       ,PCD_BAIXAD = IF(PCD_QTDBAI >= PCD_QTDITE, 1,  IFNULL(PCD_BAIXAD, 0))');
        qryGenDet.SQL.Add(' WHERE PCD_NUMCTN = 0');
        qryGenDet.SQL.Add('   AND D.AUTOINCREM = :AUTINC');
        qryGenDet.ParamByName('AUTINC').AsString  := strSeqPcd;
      End;
      qryGenDet.ExecSQL;
      cdsPcddet.First;
      qryGenDet.SQL.Clear;
      qryGenDet.SQL.Add('UPDATE PCDDET SET PCD_QTDITE = :QTDITE WHERE AUTOINCREM = :AUTINC;');

      while not cdsPcddet.Eof Do
      Begin
        qryGenDet.ParamByName('AUTINC').AsString := cdsPcddet.FieldByName('INCPCDDET').AsString;
        qryGenDet.ParamByName('QTDITE').AsFloat := cdsPcddet.FieldByName('PCD_QTDITE').AsFloat;
        qryGenDet.ExecSQL;
        cdsPcddet.Next;
      End;

    Finally
      FreeAndNil(qryGenDet);
    End;
  Except
    On e: Exception do
    Begin
      Result := False;
      pMensagensErro(e.message, '[TManutencaoMultiLojaAposEntrada.fAtualizaDadosPcmDet]');
    End;
  End;
end;

function TManutencaoMultiLojaAposEntrada.fGravaAlteracoes: Boolean;
  Var
    LfrmGravando: TfrmGravando;
Begin
  Try
    Try
      pCriarFormularios(TfrmGravando, LfrmGravando);
      LfrmGravando.fExecutarAcao := fGravaAlteracoesAux;
      LfrmGravando.ShowModal;
      Result := LfrmGravando.blnConfirma;
    Finally
      pFreeAndNil(frmGravando);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TManutencaoMultiLojaAposEntrada.fGravaAlteracoes]');
    End;
  End;
End;


function TManutencaoMultiLojaAposEntrada.fGravaAlteracoesAux(pcxProgress : TcxProgressbar): Boolean;
begin
  cdsPcmDet.First;
  cdsPcmDet.DisableControls;
  cdsPcdDet.DisableControls;
  Try
    Result := True;
    fStartTransaction;
    while not cdsPcmDet.Eof Do
    Begin
      If  cdsPcmDet.FieldByName('PCD_QTDITE').AsFloat <> cdsPcmDet.FieldByName('PCD_QTDITE_ORIGINAL').AsFloat Then
      Begin
        If Result Then
          Result := Result And fAtualizaDadosPcmDet(cdsPcmDet.FieldByName('AUTOINCREM').AsString,
                                                    cdsPcmDet.FieldByName('PCD_QTDITE').AsFloat);
        If not Result Then
          Exit;
      end;
      cdsPcmDet.Next;
    End;

    If Result Then
    Begin
      pAtualizaSaldoPDC;
      fCommit;
    End
    Else
      fRollback;
  Finally
    cdsPcmDet.EnableControls;
    cdsPcdDet.EnableControls;
  End

end;


end.
