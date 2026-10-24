unit untFatEmitirEntFutEmpCD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Uni,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  DBGridCitel, untFuncFatTypes, StrUtils,
  Data.DB, Vcl.Samples.Spin, EditFocus, cxProgressBar, System.ImageList,
  Vcl.ImgList, untFuncTinta;

type
  TfrmFatEmitirEntFutEmpCD = class(TfrmPai)
    dbgPedidos: TDBGridCitel;
    btnConfirma: TBitBtnLocked;
    dtsPedidos: TDataSource;
    Panel1: TPanel;
    edtTipFat: TEditFocus;
    spnTipFat: TSpinButton;
    Label8: TLabel;
    imglSitFin: TImageList;
    procedure dbgPedidosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure spnTipFatDownClick(Sender: TObject);
    procedure spnTipFatUpClick(Sender: TObject);
    procedure dbgPedidosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    qryPedidos: TUniquery;
    arrOpcoes: TOpcoesFaturamentoArray;
    intPosAtual: Integer;

    FstrCodigoCaixa : String;

    class function fGetSQLPedidos(const blnFiltrarData: Boolean=False): String;
    procedure pCarregarPedidos;
    procedure pEmitirNotaFiscalEntregaFutura;

    procedure pSetaOpcoesFaturamento;
    procedure pSetaTipoFaturamento(strEspecie: String);
    procedure pKeyDownTipFat(Key: Word; Shift: TShiftState);

    procedure qryPedidosAfterScroll(DataSet: TDataSet);
    class function fSQLTotPedidosEntFut(dtaEmissao: TDateTime; blnComAdiantamentoTotal: Boolean): String;
    function fSetaSituacaoFinanceira(pgbStatus: TcxProgressBar = Nil): Boolean;
  public
    { Public declarations }
    class function fTemPedidosEntFuturaParaFaturarEmpCD(
                     const dtaUltimoLancamento: TDateTime = 0;
                     blnAdiantamentoTotal: Boolean = False): Boolean; overload;

    class function fTemPedidosEntFuturaParaFaturarEmpCD(
                     out strPedidos: String;
                     const dtaUltimoLancamento: TDateTime = 0;
                     blnAdiantamentoTotal: Boolean = False): Boolean; overload;

    Property strCodigoCaixa : String Read FstrCodigoCaixa Write FstrCodigoCaixa;
  end;

var
  frmFatEmitirEntFutEmpCD: TfrmFatEmitirEntFutEmpCD;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando, untFuncFat, untFuncoes,
  untAdiantamentoCliente, untDuplicatas, untValidaSituacaoFinanceiraPedido,
  untTSituacaoPedidoVenda, untFatGor;

procedure TfrmFatEmitirEntFutEmpCD.btnConfirmaClick(Sender: TObject);
Var
  strDocTra: String;
  strEspTra: String;
  strEmpTra: String;
  strCliTra: String;
  strPenFin: String;
begin
  inherited;
  With qryPedidos Do
  Begin
    If IsEmpty Then
      Exit;

    If fTravaFatDorMenor(FieldByName('FGO_NUMDOC').AsString,
                         FieldByName('FGO_ESPDOC').AsString,
                         FieldByName('FGO_CODEMP').AsString) Then
    Begin
      fMensagem('ATENÇÃO!','Ainda não é permitido realizar o faturamento deste documento '+
                           'pois os produtos não foram replicados totalmente. Por favor, '+
                           'aguarde alguns minutos e tente novamente mais tarde.', ['&OK']);
      Exit;
    End;

    If (fCfgSis('VESIPD', varBoolean)) Then
    Begin
      If Not fValidaSituacaoFinanceiraPedido(FieldByName('FGO_NUMDOC').AsString,
                                             FieldByName('FGO_ESPDOC').AsString,
                                             FieldByName('FGO_CODEMP').AsString,
                                             strPenFin) Then
      Begin
        pMensagemOk(strPenFin + '!');
        Exit;
      End;
    End;

    If Not fPergunta('Confirma emissão ' + IfThen(arrOpcoes[intPosAtual].strEspDoc = 'NF','da ', 'do ') + arrOpcoes[intPosAtual].strDesCri + ' para o pedido ' +
      FieldByName('NUMDOC').AsString + ' ?') Then
      Exit;

    strDocTra := FieldByName('FGO_NUMDOC').AsString;
    strEspTra := FieldByName('FGO_ESPDOC').AsString;
    strEmpTra := FieldByName('FGO_CODEMP').AsString;
    strCliTra := FieldByName('FGO_CODCLI').AsString;

    If Not fLock_Unlock('FATGOR' + strDocTra + strEspTra + strEmpTra, True,
      False) Then
    Begin
      fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por '
        + fGetHostLock('FATGOR' + strDocTra + strEspTra + strEmpTra) + '!', ['&Ok']);
      Exit;
    End;

    If Not fLock_Unlock('CADREC' + strDocTra + strEspTra + strEmpTra + strCliTra, True, False) Then
    Begin
      fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por '
        + fGetHostLock('CADREC' + strDocTra + strEspTra + strEmpTra + strCliTra) + '!', ['&Ok']);
      Exit;
    End;

    Try
      TfrmGravando.fExecutarModal(pEmitirNotaFiscalEntregaFutura,
        'Aguarde, ' + 'Emitindo ' + arrOpcoes[intPosAtual].strDesCri + ' do Pedido ' + FieldByName('NUMDOC').AsString + ' ... ', '');
    Finally
      fLock_Unlock('FATGOR' + strDocTra + strEspTra + strEmpTra, False, False);
      fLock_Unlock('CADREC' + strDocTra + strEspTra + strEmpTra + strCliTra, False, False);

      pCarregarPedidos;
      pSetFocus(dbgPedidos);
    End;

  End;

end;

procedure TfrmFatEmitirEntFutEmpCD.dbgPedidosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Column.FieldName = 'SITFIN' Then
  Begin
    dbgPedidos.Canvas.FillRect(Rect);
    If dbgPedidos.DataSource.DataSet.FieldByName('SITFIN').AsString <> 'OK' Then
      imglSitFin.Draw(dbgPedidos.Canvas, Rect.Left + ((Column.Width - imglSitFin.Width) div 2), Rect.Top+1, 1)
    Else
      imglSitFin.Draw(dbgPedidos.Canvas, Rect.Left + ((Column.Width - imglSitFin.Width) div 2), Rect.Top+1, 2);
  End;
end;

procedure TfrmFatEmitirEntFutEmpCD.dbgPedidosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    btnSair.Click;
end;

class function TfrmFatEmitirEntFutEmpCD.fGetSQLPedidos(
  const blnFiltrarData: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '   CONCAT(DATE_FORMAT(FGO_DTAENT, "%d/%m/%Y"), " - ", TIME_FORMAT(FGO_HORENT, "%T")) DTAENT, ';
  Result := Result + '   CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS NUMDOC, ';
  Result := Result + '   CONCAT(FGO_CODCLI, "-", CLI_NOMCLI) AS NOMCLI, ';
  Result := Result + '   FGO_VLRCON AS VLRCON, ';
  Result := Result + '   FGO_CODCLI, ';
  Result := Result + '   FGO_NUMDOC, ';
  Result := Result + '   FGO_ESPDOC, ';
  Result := Result + '   FGO_CODEMP, ';
  Result := Result + '   FGO_TIPPED, ';
  Result := Result + '   IF(IFNULL(FGO_CODFPG, "") <> "",CONCAT(FGO_CODFPG, "-", CADFPG.FPG_DESCRI), "") AS FORPGT, ';
  Result := Result + '   "OK" AS SITFIN, ';
  Result := Result + '   FGO_ABADEP ';
  Result := Result + ' FROM ';
  Result := Result + '   FATGOR ';
  Result := Result + '   INNER JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ';
  Result := Result + '   INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ';
  Result := Result + '   LEFT JOIN CADFPG ON (CADFPG.FPG_CODIGO = FATGOR.FGO_CODFPG) ';
  Result := Result + ' WHERE FGO_ESPDOC = "PD" ';
  Result := Result + '   AND FGO_JAFATU = 0 ';
  Result := Result + '   AND FGO_ENTFUT = "S" ';
  Result := Result + '   AND IFNULL(FGO_LIBERA, 0) > 0 ';
  Result := Result + '   AND IFNULL(FGO_LIBCOM, 0) > 0 ';

  If blnFiltrarData Then
    Result := Result + '   AND FGO_DTAENT <= :DATA ';

  Result := Result + '   AND ( ';
  Result := Result + '   ( FGO_ENT_CD = "S" AND FGO_EMP_CD = "' + VS_strCodEmp + '" ) ';
  if fCfgSis('LIEFPL', varBoolean) then
    Result := Result + ' OR ( FGO_ENT_CD = "N" AND FGO_CODEMP = "' + VS_strCodEmp + '" ) ';
  Result := Result + '   ) ';

  Result := Result + ' ORDER BY ';
  Result := Result + '   FGO_DTAENT, FGO_HORENT, FGO_CODEMP, FGO_NUMDOC ';
end;

procedure TfrmFatEmitirEntFutEmpCD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qryPedidos.Close;
  FreeAndNil(qryPedidos);
end;

procedure TfrmFatEmitirEntFutEmpCD.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaOpcoesFaturamento;
end;

procedure TfrmFatEmitirEntFutEmpCD.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Assigned(ActiveControl) And ((ActiveControl) = edtTipFat) Then
    pKeyDownTipFat(Key, Shift);

  Case Key Of
    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmFatEmitirEntFutEmpCD.FormShow(Sender: TObject);
begin
  inherited;
  pSetaTipoFaturamento('NF');
  qryPedidos := fCriaQuery(Self);
  qryPedidos.AfterScroll := qryPedidosAfterScroll;
  qryPedidos.CachedUpdates := True;
  qryPedidos.Options.SetFieldsReadOnly := False;
  pCarregarPedidos;
  dtsPedidos.DataSet := qryPedidos;
  dbgPedidos.CorZebra := StrToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
  pSetFocus(dbgPedidos);
end;

function TfrmFatEmitirEntFutEmpCD.fSetaSituacaoFinanceira(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    strPenFin : String;
begin
  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := qryPedidos.RecordCount;
  pInformacao('Setando Situação Financeira, Aguarde....', pgbStatus);
  qryPedidos.DisableControls;
  qryPedidos.First;

  While (Not qryPedidos.Eof) Do
  Begin
    qryPedidos.Edit;

    If fValidaSituacaoFinanceiraPedido(qryPedidos.FieldByName('FGO_NUMDOC').AsString,
                                       qryPedidos.FieldByName('FGO_ESPDOC').AsString,
                                       qryPedidos.FieldByName('FGO_CODEMP').AsString,
                                       strPenFin) Then
      qryPedidos.FieldByName('SITFIN').AsString := 'OK'
    Else
      qryPedidos.FieldByName('SITFIN').AsString := '';

    qryPedidos.Post;
    pgbStatus.Position := qryPedidos.RecNo;
    qryPedidos.Next;
    Application.ProcessMessages;

  End;

  qryPedidos.First;
  qryPedidos.EnableControls;
  Result := True;
end;

class function TfrmFatEmitirEntFutEmpCD.fTemPedidosEntFuturaParaFaturarEmpCD(
                                          const dtaUltimoLancamento: TDateTime = 0;
                                          blnAdiantamentoTotal: Boolean = False): Boolean;
var
  strPedidos: String;
begin
  Result := TfrmFatEmitirEntFutEmpCD.fTemPedidosEntFuturaParaFaturarEmpCD(
                                       strPedidos,
                                       dtaUltimoLancamento,
                                       blnAdiantamentoTotal);
end;

class function TfrmFatEmitirEntFutEmpCD.fTemPedidosEntFuturaParaFaturarEmpCD(
                                          out strPedidos: String;
                                          const dtaUltimoLancamento: TDateTime = 0;
                                          blnAdiantamentoTotal: Boolean = False): Boolean;
Var
  qryFatGor: TUniquery;
  intCont: Integer;
begin
  strPedidos := '';
  qryFatGor := fCriaQuery(nil);

  Try
    qryFatGor.Close;
    qryFatGor.SQL.Clear;
    qryFatGor.SQL.Text := fSQLTotPedidosEntFut(dtaUltimoLancamento, blnAdiantamentoTotal);

    For intCont := 0 To Pred(qryFatGor.Params.Count) Do
    Begin
      If (qryFatGor.Params[intCont].Name.Equals('CODEMP')) Then
        qryFatGor.Params[intCont].AsString := VS_strCodEmp;

      If (qryFatGor.Params[intCont].Name.Equals('DATA')) Then
        qryFatGor.Params[intCont].AsDateTime := dtaUltimoLancamento;
    End;

    qryFatGor.Open;

    Result := Not qryFatGor.IsEmpty;

    If Result Then
    Begin
      qryFatGor.First;
      While Not qryFatGor.Eof Do
      Begin
        strPedidos := strPedidos + qryFatGor.FieldByName('DOCUMENTO').AsString + #10+#13;
        qryFatGor.Next;
      End;
    End;
  Finally
    FreeAndNil(qryFatGor);
  End;
end;

class function TfrmFatEmitirEntFutEmpCD.fSQLTotPedidosEntFut(dtaEmissao: TDateTime;
  blnComAdiantamentoTotal: Boolean): String;
begin
  Result :=
    ' SELECT                              '+
    '   FGO_NUMDOC,                       '+
    '   CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS DOCUMENTO  '+
    ' FROM                                '+
    '   FATGOR                            '+
    ' INNER JOIN                          '+
    '   EXTGOR ON                         '+
    '     FGO_SEQFGO = FATGOR.AUTOINCREM  '+
    ' WHERE FGO_ESPDOC = "PD"             '+
    '   AND FGO_JAFATU = 0                '+
    '   AND FGO_ENTFUT = "S"              '+
    '   AND IFNULL(FGO_LIBERA, 0) > 0     '+
    '   AND IFNULL(FGO_LIBCOM, 0) > 0     '+
    '   AND ( ( FGO_ENT_CD = "S" AND      '+
    '           FGO_EMP_CD = :CODEMP)     ';

  If (fCfgSis('LIEFPL', varBoolean)) Then
  Begin
    Result := Result + '   OR ( FGO_ENT_CD = "N" AND  '+
                       '        FGO_CODEMP = :CODEMP )';
  End;

  Result := Result + ' ) ';

  If (dtaEmissao > 0) Then
    Result := Result + '   AND FGO_DTAENT <= :DATA ';

  If (blnComAdiantamentoTotal) Then
  Begin
    Result := Result +
      '   AND IFNULL(                                             '+
      '     (SELECT                                               '+
      '        SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) '+
      '      FROM                                                 '+
      '        ADTCLI                                             '+
      '      WHERE ADT_NUMDOC = FGO_NUMDOC                        '+
      '        AND ADT_ESPDOC = FGO_ESPDOC                        '+
      '        AND ADT_CODEMP = FGO_CODEMP                        '+
      '        AND ADT_CODCLI = FGO_CODCLI), 0) >= FGO_VLRCON     ';
  End;
end;

procedure TfrmFatEmitirEntFutEmpCD.pCarregarPedidos;
  Var
    frmAguarde: TfrmGravando;

begin
  With qryPedidos, SQL Do
  Begin
    Close;
    Clear;
    Add(fGetSQLPedidos);
    Open;

    pCriarFormularios(TfrmGravando, frmAguarde);
    Try
      frmAguarde.fExecutarAcao := fSetaSituacaoFinanceira;
      frmAguarde.ShowModal;
    Finally
      pFreeAndNil(frmAguarde);
    End;

    TFloatField(FieldByName('VLRCON')).DisplayFormat := '#,##0.00';
  End;

end;

procedure TfrmFatEmitirEntFutEmpCD.pEmitirNotaFiscalEntregaFutura;
  Var
    fatVenda: TFatVenda;
    qryFatGor: TUniquery;
    blnDelItens: Boolean;
    intContador: Integer;
    fltTotDup: Double;
    strConPagDigDuplic: String;
    strEmpOriLog: String;

    function fGetTotalParcelasPedido: Double;
      Var
        intContador: Integer;
        LQry: TUniQuery;
    begin
      Result := 0;
      LQry := fCriaQuery;
      try
        LQry.SQL.Add('SELECT SUM(FGO_VALPAR) AS TOTAL ');
        LQry.SQL.Add('FROM GORCND');
        LQry.SQL.Add('WHERE FGO_SEQGER = :SEQGER');
        LQry.ParamByName('SEQGER').AsString := qryFatGor.FieldByName('AUTOINCREM').AsString;
        LQry.Open;

        if LQry.FieldByName('TOTAL').AsFloat = 0.00 then
        begin
          For intContador := 0 To 11 Do
            Result := Result + qryFatGor.FieldByName('FGO_VPAR' + fStrZero(intContador+1, 2)).AsFloat;
        end
        else
          Result := LQry.FieldByName('TOTAL').AsFloat;
      finally
        FreeAndNil(LQry);
      end;
    End;

    function fRetConPagParaDigDuplic(strConPagPar: String): String;
      Var 
        intQtdPar: Integer;
    begin
      Result := strConPagPar; 

      intQtdPar := StrToIntDef(Copy(Result, 1, 2), 1); 

      If (intQtdPar > 1) And (fatVenda.fltValAdt > 0) Then
      Begin  
        If (Copy(Result, 3, 3) = '000') Then
        Begin
          Result := Copy(strConPagPar, 6, Length(Result));
          Result := fStrZero(IntToStr(intQtdPar-1), 2) + Result;
        End;
      End;
    end;

begin
  strEmpOriLog := '';
  Try
    If (qryPedidos.FieldByName('FGO_ABADEP').AsString = 'S') then
    Begin
      strEmpOriLog := VS_StrCodEmp;
      pSetaEmpresaLogada(qryPedidos.FieldByName('FGO_CODEMP').AsString);
    End;

    pCriarCdsVenda(Self);
    fatVenda := TFatVenda.CreateInstance('VN');
    fatVenda.strCodigoCaixa := Self.FstrCodigoCaixa;
    qryFatGor := fCriaQuery(Self);

    fatVenda.strOpcDocTrue := 'EF';
    fatVenda.strEntFut := 'S';
    fatVenda.blnVerEstOrc := False;

    fatVenda.strNomeForm := 'frmFatVendas';

    fatVenda.blnImprimeSep := IIF(fCfgSis('IPBAFT', varBoolean), True, False);

    fatVenda.fltValMor := fCfgSis('TAXDIA', varDouble);

    fatVenda.strNumOrc := qryPedidos.FieldByName('FGO_NUMDOC').AsString;
    fatVenda.strEspOrc := qryPedidos.FieldByName('FGO_ESPDOC').AsString;
    fatVenda.strEmpOri := qryPedidos.FieldByName('FGO_CODEMP').AsString;

    fatVenda.blnEmissaoEntFutPorFatPedEntCd := True;

    fatVenda.strEspDoc := arrOpcoes[intPosAtual].strEspDoc;

    If (qryPedidos.FieldByName('FGO_ABADEP').AsString = 'S') then
    Begin
      fatVenda.strEmpOriPed := qryPedidos.FieldByName('FGO_CODEMP').AsString;
      fatVenda.strEmpDep := strEmpOriLog;
      fatVenda.strAbaDep := 'S';
    End;

    With qryFatGor Do
    Begin
      SQL.Clear;
      SQL.Add(fSelectFromFatgorLeftAuxiliares(False));
      SQL.Add('WHERE ');
      SQL.Add('  F.FGO_NUMDOC = :NUMDOC AND ');
      SQL.Add('  F.FGO_ESPDOC = :ESPDOC AND ');
      SQL.Add('  F.FGO_CODEMP = :CODEMP ');

      Close;
      ParamByName('NUMDOC').AsString := fatVenda.strNumOrc;
      ParamByName('ESPDOC').AsString := fatVenda.strEspOrc;
      ParamByName('CODEMP').AsString := fatVenda.strEmpOri;
      Open;
    End;

    untFuncFat.pCarregarClientePedidoOrcamento(fatVenda, fatVenda.strEmpOri, True);

    Try
      fatVenda.pCarregaPedidoOrcamento(qryFatGor, blnDelItens);
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;

    fatVenda.intQtdTra := qryFatGor.FieldByName('FGO_VOLUME').AsInteger;
    fatVenda.strEspTra := qryFatGor.FieldByName('FGO_ESPECI').AsString;

    fatVenda.strTipPed := 'A';

    untFuncFat.pCarregarClientePedidoOrcamento(fatVenda, fatVenda.strEmpOri);
    
    If (fatVenda.fZerarDesEsp) Then
      fatVenda.fltDesEsp := 0.0;

    fatVenda.pPreencheMatrizFechamento;

    fatVenda.blnDeCndF := (fCfgSis('CNDVEN') = 'F');

    If fatVenda.blnTaxVpr Then
      fatVenda.pCalculaTaxVpr;

    fatVenda.pCalculaPesBruLiq;

    If fCfgSis('PESPED', varBoolean) Then
    Begin
      fatVenda.fltPesBru := qryFatGor.FieldByName('FGO_PESBRU').AsFloat;
      fatVenda.fltPesLiq := qryFatGor.FieldByName('FGO_PESLIQ').AsFloat;
    End;

    fatVenda.pCalculaTotGer(False, False);

    If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
    Begin
      If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
        fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
    End;

    fatVenda.pCarregaAliquotasRetencao;
    fatVenda.pDestacaRetencoes;
    fatVenda.pRetemImpostosNoDescontoEspecial;

    fatVenda.pCalculaTotGer(False, False);

    fatVenda.pCalculaTotGer;
    fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

    fatVenda.fltDupRec := fatVenda.fTotalDuplicataQuitada(fatVenda.strNumOrc,
      fatVenda.strEspOrc, fatVenda.strEmpOri, fatVenda.strCodCli);

    fatVenda.recValAdt := TAdiantamento.fGetTotaisAdiantamento(fatVenda.strNumOrc,
      fatVenda.strEspOrc, fatVenda.strEmpOri);

    fatVenda.fltValAdt := fatVenda.recValAdt.fltValLan;

    fatVenda.pCalculaTotalParaCadRec;

    fltTotDup := fatVenda.fltTotCadRec - fatVenda.fltValAdt;
    If (fltTotDup < 0) And (fatVenda.fltValAdt <> 0) Then
      fltTotDup := 0;

    strConPagDigDuplic := fatVenda.strConPag;

    If (fltTotDup > 0) Then
      strConPagDigDuplic := fRetConPagParaDigDuplic(fatVenda.strConPag);
    
    fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(strConPagDigDuplic), 0,
      fltTotDup, False, False, False, VS_Date, False,
      fatVenda.fltImpFre, 'N', fCfgSis('DUPRED', varBoolean));

    fatVenda.strConPag := fRetornaCndPag(fatVenda.arrDuplicata, VS_Date);

    pCarregaDuplicatasCND(1,qryFatGor.FieldByName('AUTOINCREM').AsString, fatVenda.arrDuplicataCND);

    If fatVenda.fltValAdt > 0 Then
    Begin
      fatVenda.fAdicionaAdiantamentoPrimeiraParcela;

      If (fltTotDup > 0) Then
        fatVenda.strConPag := fRetornaCndPag(fatVenda.arrDuplicata, VS_Date);
    End
    Else If (fFormataFloat(fatVenda.fltTotCadRec, 2) = fFormataFloat(fGetTotalParcelasPedido, 2)) Then
    Begin

      For intContador := 0 To 23 Do
      Begin
        If (fEmptyStr(fatVenda.arrDuplicata[intContador].strSequen)) Then
          Break;

        fatVenda.arrDuplicata[intContador].curValor := fFormataFloat( fatVenda.arrDuplicataCND[intContador].curValor, 2);
      End;

    End;

    fatVenda.pRateiaValores;

    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.strChave := 'FATVENDAS';
      frmGravando.fExecutarAcao := fatVenda.fGravaArquivosDesmembrandoVenda;
      frmGravando.ShowModal;

      If frmGravando.blnConfirma Then
        fMensagem('', 'Documento ' + fatVenda.strNumDoc + '-' +
          fatVenda.strEspDoc + ' gerado com sucesso!', ['&O k']);

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;

    pFreeAndNil(frmGravando);

  Finally
    If Not fEmptyStr(strEmpOriLog) Then
    Begin
      pSetaEmpresaLogada(strEmpOriLog);

      If Assigned(pSetaEmpresaLogadaTinta) Then
        pSetaEmpresaLogadaTinta(strEmpOriLog);
    End;

    FreeAndNil(qryFatGor);
    FreeAndNil(fatVenda);
    pFreeCdsVenda;
  End;

end;

procedure TfrmFatEmitirEntFutEmpCD.pKeyDownTipFat(Key: Word;
  Shift: TShiftState);
  Var
    intPosicao : Integer;
    intContador: Integer;
begin
  inherited;

  If Key = VK_Down Then
  Begin
    intPosicao := intPosAtual;

    If (intPosAtual+1 >= Length(arrOpcoes)) Then
    Begin
      intPosAtual := 0;
    End
    Else
      Inc(intPosAtual);

    While (arrOpcoes[intPosAtual].strMosMen = 'N') And
          (intPosicao <> intPosAtual)              Do
    Begin

      If intPosAtual >= Length(arrOpcoes)-1 Then
        intPosAtual := 0
      Else
        Inc(intPosAtual);

    End;

    edtTipFat.Text := arrOpcoes[intPosAtual].strDesCri;
  End
  Else If Key = VK_Up Then
  Begin
    intPosicao := intPosAtual;

    If (intPosAtual-1 < 0) Then
    Begin
      intPosAtual := Length(arrOpcoes)-1;
    End
    Else
      Dec(intPosAtual);

    While (arrOpcoes[intPosAtual].strMosMen = 'N') And
          (intPosicao <> intPosAtual)              Do
    Begin

      If intPosAtual <= 0 Then
        intPosAtual := 0
      Else
        Dec(intPosAtual);

    End;

    edtTipFat.Text := arrOpcoes[intPosAtual].strDesCri;
  End
  Else If Shift <> [ssAlt] Then
  Begin
    For intContador := 0 To Length(arrOpcoes) -1 Do
    Begin

      If (arrOpcoes[intContador].strOpcLet = Chr(Key)) Then
      Begin
        intPosAtual := intContador;
        Break;
      End;

    End;

    If intContador < Length(arrOpcoes) Then
      edtTipFat.Text := arrOpcoes[intPosAtual].strDesCri;
  End;
end;

procedure TfrmFatEmitirEntFutEmpCD.pSetaOpcoesFaturamento;
  Var
    intIndice: Integer;

  function fPermiteEspecie(strEsp: String): Boolean;
  begin
    If (fCfgSis('PEMIFF') = '1') And                   //PERMISSAO GERAL
       (Not fCfgSis('PERM' + strEsp, varBoolean)) Then //NAO PERMITE
    Begin
      Result := False;
    End
    Else
      Result := True;
  End;
begin
  intIndice := -1;
  SetLength(arrOpcoes, 0);

  Inc(intIndice);
  SetLength(arrOpcoes, Succ(intIndice));

  arrOpcoes[intIndice].strDesCri := 'Nota Fiscal';
  arrOpcoes[intIndice].strEspDoc := 'NF';
  arrOpcoes[intIndice].strOpcLet := 'N';
  arrOpcoes[intIndice].strMosMen := 'S';

  If fPermiteEspecie('FF') Then
  Begin
    Inc(intIndice);
    SetLength(arrOpcoes, Succ(intIndice));

    arrOpcoes[intIndice].strDesCri := 'Faturamento Futuro';
    arrOpcoes[intIndice].strEspDoc := 'FF';
    arrOpcoes[intIndice].strOpcLet := 'F';
    arrOpcoes[intIndice].strMosMen := 'N';
  End;

  If ((fCfgSis('USACUP', varBoolean)) Or (fCfgSis('USNFCE', varBoolean)) Or fUsaSat ) And (Not fCfgSis('PAFECF', varBoolean)) And (fCfgSis('HEFCOE', varBoolean)) Then
  Begin
    Inc(intIndice);
    SetLength(arrOpcoes, Succ(intIndice));

    arrOpcoes[intIndice].strDesCri := fDescricaoIF;
    arrOpcoes[intIndice].strEspDoc := 'IF';
    arrOpcoes[intIndice].strOpcLet := 'C';
    arrOpcoes[intIndice].strMosMen := 'S';
  End;
end;

procedure TfrmFatEmitirEntFutEmpCD.pSetaTipoFaturamento(strEspecie: String);
  Var
    intIndex: Integer;
begin
  edtTipFat.Text := '';

  For intIndex := 0 To Length(arrOpcoes) - 1 Do
  Begin
    If SameText(arrOpcoes[intIndex].strEspDoc, strEspecie) Then
    Begin
      edtTipFat.Text := arrOpcoes[intIndex].strDesCri;
      intPosAtual := intIndex;
      Break;
    End;
  End;
end;

procedure TfrmFatEmitirEntFutEmpCD.qryPedidosAfterScroll(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('FGO_TIPPED').AsString = 'B') then
    pSetaTipoFaturamento('FF')
  else
    pSetaTipoFaturamento('NF');
end;

procedure TfrmFatEmitirEntFutEmpCD.spnTipFatDownClick(Sender: TObject);
  var
    Key: Word;
begin
  inherited;
  Key := VK_DOWN;

  If spnTipFat.Enabled Then
    pKeyDownTipFat(Key, []);
end;

procedure TfrmFatEmitirEntFutEmpCD.spnTipFatUpClick(Sender: TObject);
  var
    Key: Word;
begin
  inherited;
  Key := VK_UP;

  If spnTipFat.Enabled Then
    pKeyDownTipFat(Key, []);
end;

end.

