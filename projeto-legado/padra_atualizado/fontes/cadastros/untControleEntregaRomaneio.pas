unit untControleEntregaRomaneio;

interface
{$M+}

Uses
  Uni,
  Data.DB,
  SysUtils,
  ComCtrls,
  Controls,
  Forms,
  untFuncoesSimples;

Type
  recDataEmpresa = Record
    dtaData          : TDate;
    strCodigoEmpresa : String;
  End;

Type
  TArrayDeDatasEmpresas = Array of recDataEmpresa;
  TArrayDeDatas         = Array of TDate;
  TTipoBuscaCtrEntRom   = (tBusNormal, tBusDatasDivergentesDocFat, tBusDatasDivergentesPedOrc);

Type
  TControleEntregaRomaneio = Class(TObject)

  private
    FNumDoc,
    FEspDoc,
    FCodEmp,
    FCodCli: String;
    FDtaEnt: TDate;

    function fDataValida(dtaDtaEnt: TDate): Boolean;

    procedure pIncluiDataSeNaoExistir(Const dtaDtaEnt: TDate; Var arrDta: TArrayDeDatas);
    procedure pIncluiDataEmpresaSeNaoExistir(Const dtaDtaEnt: TDate; strCodEmp : String; Var arrDtaEmp: TArrayDeDatasEmpresas);

    function fDecrementaControleData(dtaDtaEnt: TDate; strCodEmp : String = ''): Boolean;
    function fIncrementaControleData(dtaDtaEnt: TDate; strCodEmp : String = ''): Boolean;

    procedure pCalculaQuantidadeEntregar(qryQtdEnt: TUniQuery; dtaDtaIni, dtaDtaFin: TDate);
  public
    arrDtaOri: TArrayDeDatas; //DATAS ORIGINAIS QUE SERÃO DECREMENTADAS;
    arrDtaEnt: TArrayDeDatas; //DATAS FINAIS QUE SERÃO SERÃO RESERVADAS;
    arrDtaAux: TArrayDeDatas;

    arrDtaEmpOri : TArrayDeDatasEmpresas;
    arrDtaEmpEnt : TArrayDeDatasEmpresas;
    arrDtaEmpAux : TArrayDeDatasEmpresas;

    procedure pSetDataEntrega(dtaDtaEnt: TDate);
    function fGetDataEntrega: TDate;

    function fUltimaData: TDate;
    function fProximaDataDisponivel: TDate;
    procedure pPedePeriodoInclusao;
    function fIncluiPeriodo(dtaDtaIni, dtaDtaFin: TDate; intQtqPe1: Integer; prgProgre: TProgressBar): Boolean;    

    function fDataExisteNaMatriz(Const dtaDtaEnt: TDate; Const arrDta: TArrayDeDatas): Boolean;
    function fDataEmpresaExisteNaMatriz(Const dtaDtaEnt : TDate;
                                              strCodEmp : String;
                                        Const arrDtaEmp : TArrayDeDatasEmpresas): Boolean;

    procedure pAlteraDataEntregaDocumento(dtaDtaFut: TDate);

    procedure pCopiarArray(Const arrOri: TArrayDeDatas;         Var arrDes: TArrayDeDatas);         Overload;
    procedure pCopiarArray(Const arrOri: TArrayDeDatasEmpresas; Var arrDes: TArrayDeDatasEmpresas); Overload;

    procedure fSetNumDoc(strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
    function fDataDisponivel(dtaDtaEnt: TDate; strCodEmp : String = ''): Boolean;

    procedure pCarregaArrayDatasPeloPedOrc(Var arrDta   : TArrayDeDatas);         Overload;
    procedure pCarregaArrayDatasPeloPedOrc(Var arrDtaEmp: TArrayDeDatasEmpresas); Overload;

    procedure pCarregaArrayDatasPeloDocFat(Var arrDta   : TArrayDeDatas;         tTipBusCtrEntRom: TTipoBuscaCtrEntRom = tBusNormal); Overload;
    procedure pCarregaArrayDatasPeloDocFat(Var arrDtaEmp: TArrayDeDatasEmpresas; tTipBusCtrEntRom: TTipoBuscaCtrEntRom = tBusNormal); Overload;

    function fProcessaArrayDatasControleEntregaRomaneio         : Boolean;
    function fProcessaArrayDatasControleEntregaRomaneioEmpresas : Boolean;

    function fEhControleDeEntregaRomaneioMultiloja : Boolean;

    constructor Create; reintroduce;
    
  published
    property strNumDoc: String Read FNumDoc Write FNumDoc;
    property strEspDoc: String Read FEspDoc Write FEspDoc;
    property strCodEmp: String Read FCodEmp Write FCodEmp;
    property strCodCli: String Read FCodCli Write FCodCli;
  End;

implementation

uses 
  untPedePeriodoConEnt;

procedure TControleEntregaRomaneio.pSetDataEntrega(dtaDtaEnt: TDate);
Begin
  FDtaEnt := dtaDtaEnt;
End;

function TControleEntregaRomaneio.fGetDataEntrega: TDate;
Begin
  Result := FDtaEnt;
End;

constructor TControleEntregaRomaneio.Create;
Begin
  inherited;
  FDtaEnt := VS_Date;

  SetLength(Self.arrDtaOri, 0);
  SetLength(Self.arrDtaEnt, 0);

  SetLength(Self.arrDtaEmpOri, 0);
  FillChar(Self.arrDtaEmpOri, SizeOf(Self.arrDtaEmpOri), #0);

  SetLength(Self.arrDtaEmpEnt, 0);
  FillChar(Self.arrDtaEmpEnt, SizeOf(Self.arrDtaEmpEnt), #0);

  SetLength(Self.arrDtaEmpAux, 0);
  FillChar(Self.arrDtaEmpAux, SizeOf(Self.arrDtaEmpAux), #0);

End;

function TControleEntregaRomaneio.fUltimaData: TDate;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    With qryGen Do
    Begin
      Close;
      SQL.Text := 'SELECT MAX(ENT_DTAENT) FROM CONENT WHERE ENT_CODEMP = ' + QuotedStr(VS_strCodEmp);
      Open;
      Result := Fields[0].AsDateTime;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;

function TControleEntregaRomaneio.fProximaDataDisponivel: TDate;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    With qryGen Do
    Begin
      SQL.Add('SELECT MIN(ENT_DTAENT) FROM CONENT');
      SQL.Add('WHERE');
      SQL.Add('  ENT_CODEMP =  :CODEMP AND');
      SQL.Add('  ENT_DTAENT >= :DTAENT AND');
      SQL.Add('  ENT_DISPE1 > 0           ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('DTAENT').AsDate   := VS_Date;

      Open;

      If Fields[0].IsNull Then
        Result := 0
      Else
        Result := Fields[0].AsDateTime;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TControleEntregaRomaneio.pPedePeriodoInclusao;
Begin
  pCriarFormularios(TfrmPedePeriodoConEnt, frmPedePeriodoConEnt);
  Try 
    frmPedePeriodoConEnt.objConEnt := Self;
    frmPedePeriodoConEnt.ShowModal;
  Finally
    FreeAndNil(frmPedePeriodoConEnt);
  End;
End;

function TControleEntregaRomaneio.fIncluiPeriodo(dtaDtaIni, dtaDtaFin: TDate; intQtqPe1: Integer; prgProgre: TProgressBar): Boolean;
  Var
    qryConEnt: TUniQuery;
    qryQtdEnt: TUniQuery;
Begin
  qryConEnt := fCriaQuery;
  qryQtdEnt := fCriaQuery;
  Try
    Try
      prgProgre.Position := 0;
      prgProgre.Max := Trunc(dtaDtaFin - dtaDtaIni) + 1;

      pCalculaQuantidadeEntregar(qryQtdEnt, dtaDtaIni, dtaDtaFin);

      With qryConEnt Do
      Begin
        fStartTransaction;

        SQL.Clear;
        SQL.Add('DELETE FROM CONENT');
        SQL.Add('WHERE');
        SQL.Add(' ENT_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
        SQL.Add(' ENT_CODEMP = :CODEMP');

        ParamByName('CODEMP').AsString   := VS_strCodEmp;
        ParamByName('DTAINI').AsDateTime := dtaDtaIni;
        ParamByName('DTAFIN').AsDateTime := dtaDtaFin;

        ExecSQL;

        Close;
        SQL.Text := 'SELECT * FROM CONENT WHERE FALSE';
        Open;

        While dtaDtaIni <= dtaDtaFin Do
        Begin

          If (DayOfWeek(dtaDtaIni) <> 1) And (Not fVerificaFeriado(dtaDtaIni)) Then
          Begin
            Insert;
            FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CONENT', VS_strCodEmp);
            FieldByName('ENT_CODEMP').AsString   := VS_strCodEmp;
            FieldByName('ENT_DTAENT').AsDateTime := dtaDtaIni;

            If DayOfWeek(dtaDtaIni) <> 7 Then
              FieldByName('ENT_DISPE1').AsInteger  := intQtqPe1
            Else
              FieldByName('ENT_DISPE1').AsInteger  := intQtqPe1 Div 2;

            If qryQtdEnt.Locate('DTAENT', dtaDtaIni, []) Then
            Begin
              If FieldByName('ENT_DISPE1').AsInteger > qryQtdEnt.FieldByName('QTDPED').AsInteger Then
                FieldByName('ENT_DISPE1').AsInteger :=
                  FieldByName('ENT_DISPE1').AsInteger - qryQtdEnt.FieldByName('QTDPED').AsInteger
              Else
                FieldByName('ENT_DISPE1').AsInteger := 0;
            End;

            Post;
          End;

          prgProgre.StepBy(1);
          dtaDtaIni := dtaDtaIni + 1;
          Application.ProcessMessages;
        End;

        Close;

        fCommit;
      End;

      Result := True;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        prgProgre.Position := 0;
        Result := False;
        pMensagensErro(e.Message, '[TControleEntregaRomaneio.fIncluiPeriodo]');
      End;
    End;
  Finally
    FreeAndNil(qryConEnt);
    FreeAndNil(qryQtdEnt);
  End;
End;

procedure TControleEntregaRomaneio.pCalculaQuantidadeEntregar(qryQtdEnt: TUniQuery;
  dtaDtaIni, dtaDtaFin: TDate);
Begin
  With qryQtdEnt, SQL Do
  Begin
    Clear;

    Add('SELECT');
    Add('  DTAENT, SUM(QTDPED) AS QTDPED');
    Add('FROM (');

    Add('SELECT');
    Add('  FGO_DTAENT AS DTAENT, COUNT(*) AS QTDPED');
    Add('FROM');
    Add('  FATGOR');
    Add('WHERE');
    Add('  FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
    Add('  FGO_CODEMP = :CODEMP AND ');
    Add('  FGO_JAFATU = 0 AND       ');
    Add('  FGO_ENTFAT = "S"         ');

    If (fEhControleDeEntregaRomaneioMultiloja) Then
      Add('  AND (SELECT COUNT(D.FDO_NUMDOC) FROM FATDOR D WHERE D.FDO_NUMDOC = FGO_NUMDOC AND  ' +
                                                                'D.FDO_ESPDOC = FGO_ESPDOC AND  ' +
                                                                'D.FDO_EMPITE = FGO_CODEMP) > 0 ');

    Add('GROUP BY');
    Add('  FGO_DTAENT');

    Add('UNION ALL');

    Add('SELECT');
    Add('  GER_DTENTR AS DTAENT, COUNT(*) AS QTDPED');
    Add('FROM');
    Add('  MOVGER');
    Add('WHERE');
    Add('  GER_DTENTR BETWEEN :DTAINI AND :DTAFIN AND');
    Add('  GER_CODEMP = :CODEMP AND ');
    Add('  GER_ENTFAT = "S"         ');
    Add('GROUP BY');
    Add('  GER_DTENTR');
    Add(') AS TAB');

    Add('GROUP BY');
    Add('  DTAENT');

    ParamByName('CODEMP').AsString   := VS_strCodEmp;
    ParamByName('DTAINI').AsDateTime := dtaDtaIni;
    ParamByName('DTAFIN').AsDateTime := dtaDtaFin;

    Open;
  End;
End;

procedure TControleEntregaRomaneio.fSetNumDoc(strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
begin
  FNumDoc := strNumDoc;
  FEspDoc := strEspDoc;
  FCodEmp := strCodEmp;
  FCodCli := strCodCli;
end;

function TControleEntregaRomaneio.fDataDisponivel(dtaDtaEnt: TDate; strCodEmp : String = ''): Boolean;
Var
  qryGen : TUniQuery;
Begin
  Result := True;

  If fDataValida(dtaDtaEnt) Then
  Begin
    qryGen := fCriaQuery;
    Try
      With qryGen, SQL Do
      Begin
        Add('SELECT                     ');
        Add(' ENT_DISPE1                ');
        Add('FROM                       ');
        Add(' CONENT                    ');
        Add('WHERE ENT_CODEMP = :CODEMP ');
        Add('  AND ENT_DTAENT = :DTAENT ');

        ParamByName('DTAENT').AsDateTime := dtaDtaEnt;
        ParamByName('CODEMP').AsString   := IIF(strCodEmp.IsEmpty, VS_strCodEmp, strCodEmp);

        Open;

        Result := (Not IsEmpty) And (FieldByName('ENT_DISPE1').AsInteger > 0);
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  End;
End;
 
function TControleEntregaRomaneio.fDataEmpresaExisteNaMatriz(const dtaDtaEnt : TDate;
                                                                   strCodEmp : String;
                                                             const arrDtaEmp : TArrayDeDatasEmpresas): Boolean;
Var
  intIdx: Integer;
begin
  Result := False;

  For intIdx := Low(arrDtaEmp) To High(arrDtaEmp) Do
  Begin
    If (arrDtaEmp[intIdx].dtaData          = dtaDtaEnt) And
       (arrDtaEmp[intIdx].strCodigoEmpresa = strCodEmp) Then
    Begin
      Result := True;
      Break;
    End;
  End;

end;

function TControleEntregaRomaneio.fDataExisteNaMatriz(Const dtaDtaEnt: TDate; Const arrDta: TArrayDeDatas): Boolean;
  Var 
    intIdx: Integer;
begin
  Result := False;

  For intIdx := Low(arrDta) To High(arrDta) Do
  Begin
    If (arrDta[intIdx] = dtaDtaEnt) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TControleEntregaRomaneio.fDataValida(dtaDtaEnt: TDate): Boolean;
begin
  Result := (dtaDtaEnt > 0) And (FormatDateTime('dd/mm/yyyy', dtaDtaEnt) <> '31/12/9999');
end;

procedure TControleEntregaRomaneio.pIncluiDataSeNaoExistir(Const dtaDtaEnt: TDate; Var arrDta: TArrayDeDatas);
begin
  If (Not fDataExisteNaMatriz(dtaDtaEnt, arrDta)) Then
  Begin
    SetLength(arrDta, Succ(Length(arrDta)));
    arrDta[High(arrDta)] := dtaDtaEnt;
  End;
end;

procedure TControleEntregaRomaneio.pIncluiDataEmpresaSeNaoExistir(const dtaDtaEnt: TDate; strCodEmp: String; var arrDtaEmp: TArrayDeDatasEmpresas);
begin

  If (Not fDataEmpresaExisteNaMatriz(dtaDtaEnt, strCodEmp, arrDtaEmp)) Then
  Begin
    SetLength(arrDtaEmp, Succ(Length(arrDtaEmp)));
    arrDtaEmp[High(arrDtaEmp)].dtaData          := dtaDtaEnt;
    arrDtaEmp[High(arrDtaEmp)].strCodigoEmpresa := strCodEmp;
  End;

end;

procedure TControleEntregaRomaneio.pAlteraDataEntregaDocumento(dtaDtaFut: TDate);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    With qryGen Do
    Begin
      SQL.Add(' UPDATE MOVDET ');
      SQL.Add('   SET DET_DTAFUT = :DTAFUT ');
      SQL.Add(' WHERE ');
      SQL.Add('   DET_NUMDOC = :NUMDOC AND ');
      SQL.Add('   DET_ESPDOC = :ESPDOC AND ');
      SQL.Add('   DET_CODEMP = :CODEMP AND ');
      SQL.Add('   DET_CODCLI = :CODCLI AND ');
      SQL.Add('   DET_ENTFUT = "S"     AND ');
      SQL.Add('   DET_MOTFUT = "P"     AND ');
      SQL.Add('   ROUND(DET_QTDITE - IFNULL(DET_QTDENT, 0), 4) > 0');

      ParamByName('DTAFUT').AsDate   := dtaDtaFut;
      ParamByName('NUMDOC').AsString := FNumDoc;
      ParamByName('ESPDOC').AsString := FEspDoc;
      ParamByName('CODEMP').AsString := FCodEmp;
      ParamByName('CODCLI').AsString := FCodCli;

      ExecSQL;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TControleEntregaRomaneio.pCarregaArrayDatasPeloDocFat(Var arrDta: TArrayDeDatas; tTipBusCtrEntRom: TTipoBuscaCtrEntRom = tBusNormal);
  Var
    qryGen: TUniQuery;
Begin
  SetLength(arrDta, 0);

  qryGen := fCriaQuery;
  Try
    With qryGen Do
    Begin
      If (tTipBusCtrEntRom = tBusNormal) Then
      Begin
        SQL.Add('SELECT');
        SQL.Add('  DISTINCT DET_DTAFUT ');
        SQL.Add('FROM');
        SQL.Add('  MOVGER INNER JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ');
        SQL.Add('WHERE GER_ENTFAT = "S"       ');
        SQL.Add('  AND GER_NUMDOC = :NUMDOC   ');
        SQL.Add('  AND GER_ESPDOC = :ESPDOC   ');
        SQL.Add('  AND GER_CODEMP = :CODEMP   ');
        SQL.Add('  AND GER_CODCLI = :CODCLI   ');
        SQL.Add('  AND DET_ENTFUT = "S"       ');
        SQL.Add('  AND DET_MOTFUT = "P"       ');
        SQL.Add('  AND DET_DTAFUT IS NOT NULL ');

        SQL.Add('UNION ALL');

        SQL.Add('SELECT');
        SQL.Add('  DISTINCT DET_DTAFUT ');
        SQL.Add('FROM');
        SQL.Add('  MOVGER INNER JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ');
        SQL.Add('WHERE GER_ENTFAT = "S"       ');
        SQL.Add('  AND GER_NUMDOC = :NUMDOC   ');
        SQL.Add('  AND GER_ESPDOC = :ESPDOC   ');
        SQL.Add('  AND GER_CODEMP = :CODEMP   ');
        SQL.Add('  AND GER_CODCLI = :CODCLI   ');
        SQL.Add('  AND DET_ENTFUT = "N"       ');
        SQL.Add('  AND DET_DTAFUT IS NOT NULL ');
      End
      Else
      Begin
        SQL.Add('SELECT');
        If (tTipBusCtrEntRom = tBusDatasDivergentesDocFat) Then
          SQL.Add('  DISTINCT DET_DTAFUT ')
        Else
          SQL.Add('  DISTINCT FDO_DTAFUT ');
        SQL.Add('FROM');
        SQL.Add('  MOVGER  ');
        SQL.Add('    INNER JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ');
        SQL.Add('    INNER JOIN FATDOR ON MOVDET.DET_NUM_PD = FATDOR.FDO_NUMDOC ');
        SQL.Add('                     AND MOVDET.DET_ESP_PD = FATDOR.FDO_ESPDOC ');
        SQL.Add('                     AND MOVDET.DET_EMP_PD = FATDOR.FDO_CODEMP ');
        SQL.Add('                     AND MOVDET.DET_IND_PD = FATDOR.FDO_SEQIND ');
        SQL.Add('                     AND MOVDET.DET_CODITE = FATDOR.FDO_CODITE ');
        SQL.Add('WHERE GER_ENTFAT = "S" ');
        SQL.Add('  AND GER_NUMDOC = :NUMDOC   ');
        SQL.Add('  AND GER_ESPDOC = :ESPDOC   ');
        SQL.Add('  AND GER_CODEMP = :CODEMP   ');
        SQL.Add('  AND GER_CODCLI = :CODCLI   ');
        SQL.Add('  AND FDO_ENTFUT = "S"       ');
        SQL.Add('  AND FDO_MOTFUT = "P"       ');
        If (tTipBusCtrEntRom = tBusDatasDivergentesDocFat) Then
          SQL.Add('  AND DET_DTAFUT IS NOT NULL ')
        Else
          SQL.Add('  AND FDO_DTAFUT IS NOT NULL ');
        SQL.Add('  AND ((FDO_MOTFUT <> FDO_MOTFUT) OR (FDO_DTAFUT <> DET_DTAFUT)) ');

        SQL.Add('UNION ALL');

        SQL.Add('SELECT');
        If (tTipBusCtrEntRom = tBusDatasDivergentesDocFat) Then
          SQL.Add('  DISTINCT DET_DTAFUT ')
        Else
          SQL.Add('  DISTINCT FDO_DTENTR ');
        SQL.Add('FROM');
        SQL.Add('  MOVGER  ');
        SQL.Add('    INNER JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ');
        SQL.Add('    INNER JOIN FATDOR ON MOVDET.DET_NUM_PD = FATDOR.FDO_NUMDOC ');
        SQL.Add('                     AND MOVDET.DET_ESP_PD = FATDOR.FDO_ESPDOC ');
        SQL.Add('                     AND MOVDET.DET_EMP_PD = FATDOR.FDO_CODEMP ');
        SQL.Add('                     AND MOVDET.DET_IND_PD = FATDOR.FDO_SEQIND ');
        SQL.Add('                     AND MOVDET.DET_CODITE = FATDOR.FDO_CODITE ');
        SQL.Add('    INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ');
        SQL.Add('WHERE GER_ENTFAT = "S" ');
        SQL.Add('  AND GER_NUMDOC = :NUMDOC   ');
        SQL.Add('  AND GER_ESPDOC = :ESPDOC   ');
        SQL.Add('  AND GER_CODEMP = :CODEMP   ');
        SQL.Add('  AND GER_CODCLI = :CODCLI   ');
        SQL.Add('  AND FDO_ENTRET = "E"       ');
        SQL.Add('  AND FDO_ENTFUT = "N"       ');
        SQL.Add('  AND FDO_DTENTR IS NOT NULL ');
        If (tTipBusCtrEntRom = tBusDatasDivergentesDocFat) Then
          SQL.Add('  AND DET_DTAFUT IS NOT NULL ')
        Else
          SQL.Add('  AND FDO_DTENTR IS NOT NULL ');
        SQL.Add('  AND FDO_DTENTR <> DET_DTAFUT ');
      End;

      ParamByName('NUMDOC').AsString := FNumDoc;
      ParamByName('ESPDOC').AsString := FEspDoc;
      ParamByName('CODEMP').AsString := FCodEmp;
      ParamByName('CODCLI').AsString := FCodCli;

      Open;

      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          pIncluiDataSeNaoExistir(qryGen.Fields[0].AsDateTime, arrDta);

          Next;
        End;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TControleEntregaRomaneio.pCarregaArrayDatasPeloPedOrc(Var arrDta: TArrayDeDatas);
  Var
    qryGen: TUniQuery;
Begin
  SetLength(arrDta, 0);
  
  qryGen := fCriaQuery;
  Try
    With qryGen Do
    Begin
      SQL.Add('SELECT');
      SQL.Add('  DISTINCT FDO_DTAFUT ');
      SQL.Add('FROM');
      SQL.Add('  FATGOR INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ');
      SQL.Add('WHERE FGO_ENTFAT = "S"       ');
      SQL.Add('  AND FGO_NUMDOC = :NUMDOC   ');
      SQL.Add('  AND FGO_ESPDOC = :ESPDOC   ');
      SQL.Add('  AND FGO_CODEMP = :CODEMP   ');
      SQL.Add('  AND FGO_CODCLI = :CODCLI   ');
      SQL.Add('  AND FDO_ENTFUT = "S"       ');
      SQL.Add('  AND FDO_MOTFUT = "P"       ');
      SQL.Add('  AND FDO_DTAFUT IS NOT NULL ');

      SQL.Add('UNION ALL');

      SQL.Add('SELECT');
      SQL.Add('  DISTINCT FDO_DTENTR ');
      SQL.Add('FROM');
      SQL.Add('  FATGOR INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ');
      SQL.Add('         INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ');
      SQL.Add('WHERE FGO_ENTFAT = "S"       ');
      SQL.Add('  AND FGO_NUMDOC = :NUMDOC   ');
      SQL.Add('  AND FGO_ESPDOC = :ESPDOC   ');
      SQL.Add('  AND FGO_CODEMP = :CODEMP   ');
      SQL.Add('  AND FGO_CODCLI = :CODCLI   ');
      SQL.Add('  AND FDO_ENTRET = "E"       ');
      SQL.Add('  AND FDO_ENTFUT = "N"       ');
      SQL.Add('  AND FDO_DTENTR IS NOT NULL ');

      ParamByName('NUMDOC').AsString := FNumDoc;
      ParamByName('ESPDOC').AsString := FEspDoc;
      ParamByName('CODEMP').AsString := FCodEmp;
      ParamByName('CODCLI').AsString := FCodCli;

      Open;
      
      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          pIncluiDataSeNaoExistir(qryGen.Fields[0].AsDateTime, arrDta);
          
          Next;
        End;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TControleEntregaRomaneio.pCopiarArray(Const arrOri: TArrayDeDatas; Var arrDes: TArrayDeDatas);
  Var
    intIdx: Integer;
begin
  If (Length(arrOri) > 0) Then
  Begin
    For intIdx := Low(arrOri) To High(arrOri) Do
    Begin
      pIncluiDataSeNaoExistir(arrOri[intIdx], arrDes);
    End;
  End;
end;

function TControleEntregaRomaneio.fDecrementaControleData(dtaDtaEnt: TDate; strCodEmp : String = ''): Boolean;
Var
  qryGen           : TUniQuery;
  intQtdDis        : Integer;
  strCodigoEmpresa : String;
begin

  Result := True;

  strCodigoEmpresa := IIF(strCodEmp.IsEmpty, VS_strCodEmp, strCodEmp);

  If fDataValida(dtaDtaEnt) Then
  Begin
    qryGen := fCriaQuery;
    Try
      Try
        With qryGen Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT                    ');
          SQL.Add('  ENT_DISPE1              ');
          SQL.Add('FROM                      ');
          SQL.Add('  CONENT                  ');
          SQL.Add('WHERE ENT_CODEMP = :CODEMP');
          SQL.Add('  AND ENT_DTAENT = :DTAENT');
          SQL.Add('FOR UPDATE                ');

          ParamByName('CODEMP').AsString := strCodigoEmpresa;
          ParamByName('DTAENT').AsDate   := dtaDtaEnt;
          Open;

          Result := (Not IsEmpty) And (FieldByName('ENT_DISPE1').AsInteger > 0);

          If Result Then
          Begin
            intQtdDis := FieldByName('ENT_DISPE1').AsInteger - 1;

            Close;
            SQL.Clear;
            SQL.Add('UPDATE CONENT');
            SQL.Add(' SET ENT_DISPE1 = :QTDDIS ');
            SQL.Add('WHERE                     ');
            SQL.Add('  ENT_CODEMP = :CODEMP AND');
            SQL.Add('  ENT_DTAENT = :DTAENT    ');

            ParamByName('CODEMP').AsString  := strCodigoEmpresa;
            ParamByName('DTAENT').AsDate    := dtaDtaEnt;
            ParamByName('QTDDIS').AsInteger := intQtdDis;

            ExecSQL;
          End;
        End;
      Except
        On E: Exception Do
        Begin
          Result := False;
          Raise Exception.Create('Não consegui checar a tabela de datas disponíveis na empresa '+strCodigoEmpresa+'. Tente novamente!');
        End;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

function TControleEntregaRomaneio.fEhControleDeEntregaRomaneioMultiloja: Boolean;
begin
  Result := fCfgSis('MULENT', varBoolean);
end;

function TControleEntregaRomaneio.fIncrementaControleData(dtaDtaEnt: TDate; strCodEmp : String = ''): Boolean;
Var
  qryGen           : TUniQuery;
  strCodigoEmpresa : String;
Begin

  Result := True;

  strCodigoEmpresa := IIF(strCodEmp.IsEmpty, VS_strCodEmp, strCodEmp);

  If fDataValida(dtaDtaEnt) Then
  Begin
    qryGen := fCriaQuery;
    Try
      Try
        With qryGen Do
        Begin
          SQL.Clear;
          SQL.Add('UPDATE CONENT');
          SQL.Add('  SET ENT_DISPE1 = ENT_DISPE1 + 1');
          SQL.Add('WHERE ENT_CODEMP = :CODEMP       ');
          SQL.Add('  AND ENT_DTAENT = :DTAENT       ');

          ParamByName('CODEMP').AsString  := strCodigoEmpresa;
          ParamByName('DTAENT').AsDate    := dtaDtaEnt;
          ExecSQL;
        End;
      Except
        Result := False;
        Raise Exception.Create('Não consegui checar a tabela de datas disponíveis na empresa '+strCodigoEmpresa+'. Tente novamente!');
      End;
    Finally
     FreeAndNil(qryGen);
    End;
  End;
end;

function TControleEntregaRomaneio.fProcessaArrayDatasControleEntregaRomaneio: Boolean;
  Var
    intIdx: Integer;
begin
  Result := True;

  If Result And (Length(Self.arrDtaOri) > 0) Then
  Begin
    For intIdx := Low(Self.arrDtaOri) To High(Self.arrDtaOri) Do
    Begin
      Result := Result And fIncrementaControleData(Self.arrDtaOri[intIdx]);
    End;
  End;

  If Result And (Length(Self.arrDtaEnt) > 0) Then
  Begin
    For intIdx := Low(Self.arrDtaEnt) To High(Self.arrDtaEnt) Do
    Begin
      Result := Result And fDecrementaControleData(Self.arrDtaEnt[intIdx]);
    End;
  End;

  If Result Then
  Begin
    SetLength(Self.arrDtaOri, 0);
    SetLength(Self.arrDtaEnt, 0);
  End;
end;

function TControleEntregaRomaneio.fProcessaArrayDatasControleEntregaRomaneioEmpresas: Boolean;
Var
  intIdx: Integer;
begin

  Result := True;

  If Result And (Length(Self.arrDtaEmpOri) > 0) Then
  Begin
    For intIdx := Low(Self.arrDtaEmpOri) To High(Self.arrDtaEmpOri) Do
    Begin
      Result := Result And fIncrementaControleData(Self.arrDtaEmpOri[intIdx].dtaData,
                                                   Self.arrDtaEmpOri[intIdx].strCodigoEmpresa);
    End;
  End;

  If Result And (Length(Self.arrDtaEmpEnt) > 0) Then
  Begin
    For intIdx := Low(Self.arrDtaEmpEnt) To High(Self.arrDtaEmpEnt) Do
    Begin
      Result := Result And fDecrementaControleData(Self.arrDtaEmpEnt[intIdx].dtaData,
                                                   Self.arrDtaEmpEnt[intIdx].strCodigoEmpresa);
    End;
  End;

  If Result Then
  Begin

    SetLength(Self.arrDtaEmpOri, 0);
    FillChar(arrDtaEmpOri, SizeOf(arrDtaEmpOri), #0);

    SetLength(Self.arrDtaEmpEnt, 0);
    FillChar(arrDtaEmpEnt, SizeOf(arrDtaEmpEnt), #0);

  End;

end;

procedure TControleEntregaRomaneio.pCarregaArrayDatasPeloDocFat(var arrDtaEmp: TArrayDeDatasEmpresas; tTipBusCtrEntRom: TTipoBuscaCtrEntRom);
  Var
    qryGen: TUniQuery;
Begin

  SetLength(arrDtaEmp, 0);
  FillChar(arrDtaEmp, SizeOf(arrDtaEmp), #0);

  qryGen := fCriaQuery;
  Try
    With qryGen Do
    Begin
      If (tTipBusCtrEntRom = tBusNormal) Then
      Begin
        SQL.Add('SELECT');
        SQL.Add('  DISTINCT DET_DTAFUT, DET_CODEMP ');
        SQL.Add('FROM');
        SQL.Add('  MOVGER INNER JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ');
        SQL.Add('WHERE GER_ENTFAT = "S"       ');
        SQL.Add('  AND GER_NUMDOC = :NUMDOC   ');
        SQL.Add('  AND GER_ESPDOC = :ESPDOC   ');
        SQL.Add('  AND GER_CODEMP = :CODEMP   ');
        SQL.Add('  AND GER_CODCLI = :CODCLI   ');
        SQL.Add('  AND DET_ENTFUT = "S"       ');
        SQL.Add('  AND DET_MOTFUT = "P"       ');
        SQL.Add('  AND DET_DTAFUT IS NOT NULL ');

        SQL.Add('UNION ALL');

        SQL.Add('SELECT');
        SQL.Add('  DISTINCT DET_DTAFUT, DET_CODEMP ');
        SQL.Add('FROM');
        SQL.Add('  MOVGER INNER JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ');
        SQL.Add('WHERE GER_ENTFAT = "S"       ');
        SQL.Add('  AND GER_NUMDOC = :NUMDOC   ');
        SQL.Add('  AND GER_ESPDOC = :ESPDOC   ');
        SQL.Add('  AND GER_CODEMP = :CODEMP   ');
        SQL.Add('  AND GER_CODCLI = :CODCLI   ');
        SQL.Add('  AND DET_ENTFUT = "N"       ');
        SQL.Add('  AND DET_DTAFUT IS NOT NULL ');
      End
      Else
      Begin
        SQL.Add('SELECT');
        If (tTipBusCtrEntRom = tBusDatasDivergentesDocFat) Then
          SQL.Add('  DISTINCT DET_DTAFUT, DET_CODEMP ')
        Else
          SQL.Add('  DISTINCT FDO_DTAFUT, FDO_EMPITE ');
        SQL.Add('FROM');
        SQL.Add('  MOVGER  ');
        SQL.Add('    INNER JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ');
        SQL.Add('    INNER JOIN FATDOR ON MOVDET.DET_NUM_PD = FATDOR.FDO_NUMDOC ');
        SQL.Add('                     AND MOVDET.DET_ESP_PD = FATDOR.FDO_ESPDOC ');
        SQL.Add('                     AND MOVDET.DET_EMP_PD = FATDOR.FDO_CODEMP ');
        SQL.Add('                     AND MOVDET.DET_IND_PD = FATDOR.FDO_SEQIND ');
        SQL.Add('                     AND MOVDET.DET_CODITE = FATDOR.FDO_CODITE ');
        SQL.Add('WHERE GER_ENTFAT = "S" ');
        SQL.Add('  AND GER_NUMDOC = :NUMDOC   ');
        SQL.Add('  AND GER_ESPDOC = :ESPDOC   ');
        SQL.Add('  AND GER_CODEMP = :CODEMP   ');
        SQL.Add('  AND GER_CODCLI = :CODCLI   ');
        SQL.Add('  AND FDO_ENTFUT = "S"       ');
        SQL.Add('  AND FDO_MOTFUT = "P"       ');
        If (tTipBusCtrEntRom = tBusDatasDivergentesDocFat) Then
          SQL.Add('  AND DET_DTAFUT IS NOT NULL ')
        Else
          SQL.Add('  AND FDO_DTAFUT IS NOT NULL ');
        SQL.Add('  AND ((FDO_MOTFUT <> FDO_MOTFUT) OR (FDO_DTAFUT <> DET_DTAFUT)) ');

        SQL.Add('UNION ALL');

        SQL.Add('SELECT');
        If (tTipBusCtrEntRom = tBusDatasDivergentesDocFat) Then
          SQL.Add('  DISTINCT DET_DTAFUT, DET_CODEMP ')
        Else
          SQL.Add('  DISTINCT FDO_DTENTR, FDO_EMPITE ');
        SQL.Add('FROM');
        SQL.Add('  MOVGER  ');
        SQL.Add('    INNER JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ');
        SQL.Add('    INNER JOIN FATDOR ON MOVDET.DET_NUM_PD = FATDOR.FDO_NUMDOC ');
        SQL.Add('                     AND MOVDET.DET_ESP_PD = FATDOR.FDO_ESPDOC ');
        SQL.Add('                     AND MOVDET.DET_EMP_PD = FATDOR.FDO_CODEMP ');
        SQL.Add('                     AND MOVDET.DET_IND_PD = FATDOR.FDO_SEQIND ');
        SQL.Add('                     AND MOVDET.DET_CODITE = FATDOR.FDO_CODITE ');
        SQL.Add('    INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ');
        SQL.Add('WHERE GER_ENTFAT = "S" ');
        SQL.Add('  AND GER_NUMDOC = :NUMDOC   ');
        SQL.Add('  AND GER_ESPDOC = :ESPDOC   ');
        SQL.Add('  AND GER_CODEMP = :CODEMP   ');
        SQL.Add('  AND GER_CODCLI = :CODCLI   ');
        SQL.Add('  AND FDO_ENTRET = "E"       ');
        SQL.Add('  AND FDO_ENTFUT = "N"       ');
        SQL.Add('  AND FDO_DTENTR IS NOT NULL ');
        If (tTipBusCtrEntRom = tBusDatasDivergentesDocFat) Then
          SQL.Add('  AND DET_DTAFUT IS NOT NULL ')
        Else
          SQL.Add('  AND FDO_DTENTR IS NOT NULL ');
        SQL.Add('  AND FDO_DTENTR <> DET_DTAFUT ');
      End;

      ParamByName('NUMDOC').AsString := FNumDoc;
      ParamByName('ESPDOC').AsString := FEspDoc;
      ParamByName('CODEMP').AsString := FCodEmp;
      ParamByName('CODCLI').AsString := FCodCli;

      Open;

      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          pIncluiDataEmpresaSeNaoExistir(qryGen.Fields[0].AsDateTime,
                                         qryGen.Fields[1].AsString,
                                         arrDtaEmp);
          Next;
        End;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TControleEntregaRomaneio.pCarregaArrayDatasPeloPedOrc(var arrDtaEmp: TArrayDeDatasEmpresas);
  Var
    qryGen: TUniQuery;
Begin

  SetLength(arrDtaEmp, 0);
  FillChar(arrDtaEmp, SizeOf(arrDtaEmp), #0);

  qryGen := fCriaQuery;
  Try
    With qryGen Do
    Begin
      SQL.Add('SELECT');
      SQL.Add('  DISTINCT FDO_DTAFUT, FDO_EMPITE ');
      SQL.Add('FROM');
      SQL.Add('  FATGOR INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ');
      SQL.Add('WHERE FGO_ENTFAT = "S"       ');
      SQL.Add('  AND FGO_NUMDOC = :NUMDOC   ');
      SQL.Add('  AND FGO_ESPDOC = :ESPDOC   ');
      SQL.Add('  AND FGO_CODEMP = :CODEMP   ');
      SQL.Add('  AND FGO_CODCLI = :CODCLI   ');
      SQL.Add('  AND FDO_ENTFUT = "S"       ');
      SQL.Add('  AND FDO_MOTFUT = "P"       ');
      SQL.Add('  AND FDO_DTAFUT IS NOT NULL ');

      SQL.Add('UNION ALL');

      SQL.Add('SELECT');
      SQL.Add('  DISTINCT FDO_DTENTR, FDO_EMPITE ');
      SQL.Add('FROM');
      SQL.Add('  FATGOR INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ');
      SQL.Add('         INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ');
      SQL.Add('WHERE FGO_ENTFAT = "S"       ');
      SQL.Add('  AND FGO_NUMDOC = :NUMDOC   ');
      SQL.Add('  AND FGO_ESPDOC = :ESPDOC   ');
      SQL.Add('  AND FGO_CODEMP = :CODEMP   ');
      SQL.Add('  AND FGO_CODCLI = :CODCLI   ');
      SQL.Add('  AND FDO_ENTRET = "E"       ');
      SQL.Add('  AND FDO_ENTFUT = "N"       ');
      SQL.Add('  AND FDO_DTENTR IS NOT NULL ');

      ParamByName('NUMDOC').AsString := FNumDoc;
      ParamByName('ESPDOC').AsString := FEspDoc;
      ParamByName('CODEMP').AsString := FCodEmp;
      ParamByName('CODCLI').AsString := FCodCli;

      Open;

      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          pIncluiDataEmpresaSeNaoExistir(qryGen.Fields[0].AsDateTime,
                                         qryGen.Fields[1].AsString,
                                         arrDtaEmp);
          Next;
        End;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TControleEntregaRomaneio.pCopiarArray(const arrOri: TArrayDeDatasEmpresas; var arrDes: TArrayDeDatasEmpresas);
Var
  intIdx: Integer;
begin

  If (Length(arrOri) > 0) Then
  Begin
    For intIdx := Low(arrOri) To High(arrOri) Do
    Begin
      pIncluiDataEmpresaSeNaoExistir(arrOri[intIdx].dtaData,
                                     arrOri[intIdx].strCodigoEmpresa,
                                     arrDes);
    End;
  End;

end;

end.
