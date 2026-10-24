unit untLibCancelamentoDocumentosGarantia;

interface

Uses
 untCancelamentoDocumentos;

Type
  TLibCancelamentoDocGarantia = Class
  private
    function fAtualizaEstoque(const strCodIte: String; const fltQtdIte: Double;
      const strEntSai, strNumLot, strEspecie: String): Boolean;
    procedure pDesvincularNotaEletronica(const pstrAutIncGerele: String);
    procedure pApagarItensDocumentoEntradaRecCliente(const pstrAutIncGer: String);
  public
    strNomFrm: String;
    class procedure pIncluirHistoricoCRMCancelamentoGarantia(pstrNumEnt, pstrEspDoc, pstrCodCli, pstrCodEmp: String);
    procedure pEstornarEntradaMercadoriaRecCliente(const pstrAutIncGer: String);overload;
    class procedure pEstornarEntradaMercadoriaRecCliente(const pstrAutIncGer: String; const pstrNomFrm: String);overload;
  end;

implementation
uses
  uni,
  StrUtils,
  SysUtils,
  untCadLote,
  untTCRMGarantia,
  untFuncoesSimples;

class procedure TLibCancelamentoDocGarantia.pIncluirHistoricoCRMCancelamentoGarantia(
  pstrNumEnt, pstrEspDoc, pstrCodCli, pstrCodEmp: String);
Var
  lDadosGarantiaCRM: TDadosGarantiaCRM;
begin
  if Not VS_strHabilitarCRM then
    Exit;

  lDadosGarantiaCRM.strNumEnt := pstrNumEnt;
  lDadosGarantiaCRM.strCodCli := pstrCodCli;
  lDadosGarantiaCRM.strCodEmp := pstrCodEmp;
  lDadosGarantiaCRM.strEspDoc := pstrEspDoc;
  lDadosGarantiaCRM.strNomCli := '';
  lDadosGarantiaCRM.strNomFrm := 'TLibCancelamentoDocGarantia';
  lDadosGarantiaCRM.blnGeraCreditoNoRecebimento := False;
  TCRMGarantia.pCancelarOcorrenciaCRM(lDadosGarantiaCRM);
end;

function TLibCancelamentoDocGarantia.fAtualizaEstoque(const strCodIte: String;
  const fltQtdIte: Double; const strEntSai, strNumLot,
  strEspecie: String): Boolean;
Var
  lstrSql,
  lstrNumLot: String;
  lqryGenIte: TUniQuery;
  objCadLot: TCadLot;

begin
  lstrNumLot := strNumLot;
  Result := True;
  lqryGenIte := fCriaQuery;
  objCadLot := TCadLot.Create(Nil);
  Try
    lstrSQL := '';
    lstrSQL := lstrSQL + 'UPDATE ';
    lstrSQL := lstrSQL + '  ITEGER ';
    lstrSQL := lstrSQL + 'SET ';
    If (strEntSai = 'E') Then
      lstrSQL := lstrSQL + '  ITE_SALDOS = ITE_SALDOS + :QTDITE '
    Else
      lstrSQL := lstrSQL + '  ITE_SALDOS = ITE_SALDOS - :QTDITE ';

    lstrSQL := lstrSQL + 'WHERE ';
    lstrSQL := lstrSQL + '  ITE_CODITE = :CODITE AND ';
    lstrSQL := lstrSQL + '  ITE_CODEMP = :CODEMP ';

    lqryGenIte.Close;
    lqryGenIte.SQL.Clear;
    lqryGenIte.SQL.Add(lstrSQL);
    lqryGenIte.ParamByName('QTDITE').AsFloat := fltQtdIte;
    lqryGenIte.ParamByName('CODITE').AsString := strCodIte;
    lqryGenIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    lqryGenIte.ExecSQL;
    lqryGenIte.Close;

    If fEmptyStr(lstrNumLot) Then
      lstrNumLot := objCadLot.fRetArmazemPrincipalVenda(strCodIte);

    If (Not fEmptyStr(lstrNumLot)) Then
      Result := objCadLot.fAtualizaEstoqueLote(strCodIte, strEntSai, lstrNumLot, fltQtdIte);
  Finally
    lqryGenIte.Free;
    objCadLot.Free;
  End;
end;

procedure TLibCancelamentoDocGarantia.pEstornarEntradaMercadoriaRecCliente(
  const pstrAutIncGer: String);
Var
  lqryMovGer,
  lqryAuxMov,
  lqryMovObs: TUniquery;

  lSql,
  lstrAutIncTmp: String;
begin
  lqryMovGer := fCriaQuery;
  lqryAuxMov := fCriaQuery;
  lqryMovObs := fCriaQuery;
  Try
    {$REGION 'Se entrada por nota eletrônica, removendo vínculo e liberando o documento para nova entrada'}
    lSql :=        ' SELECT G.AUTOINCREM, ';
    lSql := lSql + '        G2.AUTOINCREM AS INC_GERELE ';
    lSql := lSql + ' FROM MOVGER G ';
    lSql := lSql + ' LEFT JOIN GERELE G2 ';
    lSql := lSql + ' ON     G2.GER_EMPENT = G.GER_CODEMP ';
    lSql := lSql + '    AND G2.GER_DOCENT = G.GER_NUMDOC ';
    lSql := lSql + '    AND G2.GER_ESPENT = G.GER_ESPDOC ';
    lSql := lSql + '    AND G2.GER_TIP_FC = G.GER_TIP_FC ';
    lSql := lSql + '    AND IF(G2.GER_TIP_FC = "C", G2.GER_CODCLI = G.GER_CODCLI, G2.GER_CODFOR = G.GER_CODFOR) ';
    lSql := lSql + ' WHERE  G.AUTOINCREM = :AUTINC ';

    lQryMovGer.Close;
    lqryMovger.Sql.Clear;
    lqryMovger.Sql.Add(lSql);
    lqryMovger.ParamByName('AUTINC').AsString := pstrAutIncGer;
    lqryMovGer.Open;
    if lqryMovger.IsEmpty Then
      Exit
    else
      lQryMovger.First;

    lstrAutIncTmp := lqryMovGer.FieldByName('INC_GERELE').AsString;

    if not fEmptystr(lstrAutIncTmp) then
    begin
      pDesvincularNotaEletronica(lqryMovGer.FieldByName('INC_GERELE').AsString);
      lstrAutIncTmp := EmptyStr;
    end;
    {$Endregion}

    lQryMovger.Close;
    lQryMovger.Sql.Clear;
    lQryMovger.Sql.Add('SELECT * FROM MOVGER WHERE AUTOINCREM = :AUTINC ');
    lqryMovger.ParamByName('AUTINC').AsString := pstrAutIncGer;
    lqryMovGer.Open;

    lqryMovGer.First;

    pApagarItensDocumentoEntradaRecCliente(pstrAutIncGer);

    lqryMovGer.First;
    {$Region 'Cancelar Livro Fiscal'}
    TfrmCancelamentoDocumentos.fCancelaLivroFiscalEx('NF',
                                                     lqryMovGer.FieldByName('GER_NUMDOC').AsString,
                                                     lqryMovGer.FieldByName('GER_CODCLI').AsString,
                                                     lqryMovGer.FieldByName('GER_SERIE_').AsString,
                                                     lstrAutIncTmp);
    {$EndRegion}
    fVerificaIntegridade(Self.strNomFrm, 'MOVGER', lqryMovGer);
    {$Region 'AUXMOV'}
    lqryAuxMov.Close;
    lqryAuxMov.SQL.Clear;
    lqryAuxMov.SQL.Add('SELECT * FROM AUXMOV');
    lqryAuxMov.SQL.Add('WHERE AUX_SEQGER = :AUTINC');

    lqryAuxMov.ParamByName('AUTINC').AsString := lqryMovGer.FieldByName('AUTOINCREM').AsString;
    lqryAuxMov.Open;

    If Not lqryAuxMov.IsEmpty Then
    Begin
      lqryAuxMov.First;
      While Not lqryAuxMov.Eof Do
      Begin
        fVerificaIntegridade(Self.strNomFrm, 'AUXMOV', lqryAuxMov);
        fApagaRegistro('AUXMOV', lqryAuxMov.FieldByName('AUX_SEQGER').AsString);

        lqryAuxMov.Next;
      End;
    End;
    {$EndRegion}
    {$Region 'MOVOBS'}
    lqryMovObs.Close;
    lqryMovObs.SQL.Clear;
    lqryMovObs.SQL.Add('SELECT * FROM MOVOBS ');
    lqryMovObs.SQL.Add('WHERE MOV_SEQGER = :AUTINC ');

    lqryMovObs.ParamByName('AUTINC').AsString := lqryMovGer.FieldByName('AUTOINCREM').AsString;
    lqryMovObs.Open;

    If Not lqryMovObs.IsEmpty Then
    Begin
      lqryMovObs.First;
      While Not lqryMovObs.Eof Do
      Begin
        fVerificaIntegridade(Self.strNomFrm, 'MOVOBS', lqryMovObs);
        fApagaRegistro('MOVOBS', lqryMovObs.FieldByName('MOV_SEQGER').AsString);
        lqryMovObs.Next;
      End;
    End;
    {$Endregion}
    fApagaRegistro('MOVGER', lqryMovGer.FieldByName('AUTOINCREM').AsString);
  Finally
    lqryMovObs.Free;
    lqryAuxMov.Free;
    lQryMovGer.Free;
  End;
end;

class procedure TLibCancelamentoDocGarantia.pEstornarEntradaMercadoriaRecCliente(
  const pstrAutIncGer: String; const pstrNomFrm: String);
Var
  lLibCancelamentoDocGarantia: TLibCancelamentoDocGarantia;
begin
  lLibCancelamentoDocGarantia := TLibCancelamentoDocGarantia.Create;
  Try
    Try
      lLibCancelamentoDocGarantia.strNomFrm := pstrNomFrm;
      lLibCancelamentoDocGarantia.pEstornarEntradaMercadoriaRecCliente(pstrAutIncGer);
    Except
      On E: Exception do
      begin
        pMensagensErro(e.Message, 'TLibCancelamentoDocGarantia.pEstornarEntradaMercadoriaRecCliente' );
      end;
    End;
  Finally
    lLibCancelamentoDocGarantia.Free;
  End;
end;

procedure TLibCancelamentoDocGarantia.pApagarItensDocumentoEntradaRecCliente(const
  pstrAutIncGer: String);
Var
  lqryMovDet,
  lqryMovTri: TUniquery;
  lstrCodIte: String;
begin
  lqryMovDet := fCriaQuery;
  lqryMovTri := fCriaQuery;
  Try
    lqryMovDet.Close;
    lqryMovDet.Sql.Clear;
    lqryMovDet.Sql.Add(' SELECT * FROM MOVDET WHERE DET_SEQGER = :AUTINC ');
    lqryMovDet.ParamByName('AUTINC').AsString := pstrAutIncGer;
    lqryMovDet.Open;

    if lqryMovDet.IsEmpty then
      Exit
    else
      lQryMovDet.First;

    lqryMovTri.Close;
    lqryMovTri.Sql.Clear;
    lqryMovTri.Sql.Add(' SELECT * FROM MOVTRI WHERE DET_SEQGER = :INCDET ');
    While Not lqryMovDet.Eof do
    begin
      lstrCodIte := lqryMovDet.FieldByName('DET_CODITE').AsString;
      fVerificaIntegridade(Self.strNomFrm, 'MOVDET', lqryMovDet);

      if lqryMovTri.Active then
        lqryMovTri.Close;
      lqryMovTri.ParamByName('INCDET').AsString := lqryMovDet.FieldByName('AUTOINCREM').AsString;
      lqryMovTri.Open;

      if Not lqryMovTri.IsEmpty then
      begin
        lqryMovTri.First;
        While Not lqryMovTri.Eof do
        begin
          fVerificaIntegridade(Self.strNomFrm, 'MOVTRI', lqryMovTri);
          fApagaRegistro('MOVDET', lqryMovDet.FieldByName('AUTOINCREM').AsString);
          fApagaRegistro('MOVTRI', lqryMovTri.FieldByName('DET_SEQGER').AsString);

          lqryMovTri.Next;
        end;
      end;

      fAtualizaEstoque(lstrCodIte,
                       lqryMovDet.FieldByName('DET_QTDITE').AsFloat,
                       IIF(StrToInt(LeftStr(lqryMovDet.FieldByName('DET_CLAFIS').AsString, 1)) < 5, 'S', 'E'),
                       lqryMovDet.FieldByName('DET_NUMLOT').AsString, '');

      ReprocessarItem(lstrCodIte, '');
      lqryMovDet.Next;
    end;
  Finally
    lqryMovTri.Free;
    lqryMovDet.Free;
  End;
end;

procedure TLibCancelamentoDocGarantia.pDesvincularNotaEletronica(const
  pstrAutIncGerele: String);
Var
  lqryUpdate: TUniquery;
  lSql: String;
begin
  lSql :=        ' UPDATE GERELE  SET ';
  lSql := lSql + '        GER_EMPENT = Null, ';
  lSql := lSql + '        GER_DOCENT = Null, ';
  lSql := lSql + '        GER_ESPENT = Null  ';
  lSql := lSql + ' WHERE AUTOINCREM = :AUTINC ';

  lqryUpdate := fCriaQuery;
  Try
    lQryUpdate.Close;
    lQryUpdate.Sql.Clear;
    lQryUpdate.Sql.Add(lSql);
    lQryUpdate.ParamByName('AUTINC').AsString := pstrAutIncGerele;
    lQryUpdate.ExecSQL;
  Finally
    lQryUpdate.Free;
  End;
end;

end.

