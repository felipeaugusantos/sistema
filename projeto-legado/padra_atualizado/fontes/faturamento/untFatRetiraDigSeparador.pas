unit untFatRetiraDigSeparador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, DB,
  Uni, StrUtils, AppEvnts, DBCtrls,
  cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, BitBtnLockedIncrem, untZClient,
  frxClass, frxExportCSVTestabilidade, untLiberacao, untTThreadNotificacao,
  UniClientDataSet;

type
  TfrmFatRetiraDigSeparador = class(TfrmPai)
    dbgPedidos: TDBGridCitel;
    pnl1: TPanel;
    lbl1: TLabel;
    lblSemSal: TLabel;
    shpSemSal: TShape;
    pnlLegendEmpVen: TPanel;
    shp2: TShape;
    lbl3: TLabel;
    shp3: TShape;
    lbl4: TLabel;
    shpTotCon: TShape;
    lblTotCon: TLabel;
    lblSepAnt: TLabel;
    tmrTmpIan: TTimer;
    tmrTmpRte: TTimer;
    procedure FormShow(Sender: TObject);
    procedure dbgPedidosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgPedidosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmrTmpIanTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrTmpRteTimer(Sender: TObject);
  private
    { Private declarations }
    cdsPedidos: TZClient;
    objLiberacao : TLiberacao;

    blnSOMNSP: Boolean;
    intTMPRTE: Integer;
    intTMPIAN: Integer;
    intTMPDNS: Integer;

    thrNotificacao: TThreadNotificacao;
    procedure pCarregaPedidos;
    function fGetSQLPedidos: String;
    function fConferenciaProdutos: Boolean;
    procedure pAtualizaSeparador(strCodSep: String);
    procedure pInformaSeparador;
    procedure pRemoveSeparador;
    procedure pImprimirSeparacao(cdsDocumento: TZClient);
    function fItensDocumento(strNumDoc, strEspDoc, strCodEmp,
      strCodCli: String): String;
    function fUsaTempoSeparacao(strAutoincrem, strCodSep: String): Boolean;
    procedure pAtualizaSeparadorAnterior(strCodSep: String);
    function fGetSQLPedidoTemAoMenosUmJaPegouNao: String;
    procedure pMontaObservacao;
    function fCampoPreenchido(strCampo: String): Boolean;
    procedure pIncluirCampoObservacao(const strCampo: String; var strObservacao: String);

    procedure pInicializarNotificacoes;
    procedure pHabilitarNotificacoes(blnAtivar: Boolean);
    procedure pGerarThreadNotTinDisp;
    procedure pFinalizarThreadNotTinDisp(blnAtivarTimer: Boolean);
    function fUtilizaSistemaNotificacao: Boolean;
    procedure pEncerraThreadNotificacao;
  public
    { Public declarations }
  end;



implementation

uses untfuncoesSimples, untFuncFat, System.UITypes, untTypesSistema,
  untFatConfOrcamentosItens, untFuncFatImp, untFuncFatTypes;

{$R *.dfm}

{ TfrmFatRetiraDigSeparador }

procedure TfrmFatRetiraDigSeparador.dbgPedidosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With dbgPedidos.DataSource.DataSet Do
  Begin
    If cdsPedidos.FieldByName('TOTRETCOF').AsString = 'S' Then
    Begin
      If dbgPedidos.Canvas.Brush.Color = clHighLight Then
        dbgPedidos.Canvas.Font.Color := clLime
      Else
        dbgPedidos.Canvas.Font.Color := shpTotCon.Brush.Color;
    End
    Else If Not fEmptyStr(cdsPedidos.FieldByName('CODSEP').AsString) Then
    Begin
      If dbgPedidos.Canvas.Brush.Color = clHighLight Then
        dbgPedidos.Canvas.Font.Color := clLime
      Else
        dbgPedidos.Canvas.Font.Color := clBlue;
    End;

    If (Column.FieldName = 'ENTURG') Then
    Begin
      If (dbgPedidos.Canvas.Brush.Color <> clHighlight) Then
      Begin
        If (FieldByName('ENTURG').AsString = 'SIM') Then
        Begin
          dbgPedidos.Canvas.Font.Color := clRed;
          dbgPedidos.Canvas.Font.Style := [fsBold];
        End
        Else
          dbgPedidos.Canvas.Font.Color := clBlack;
      End
      Else
        dbgPedidos.Canvas.Font.Color := clYellow;
    End;

    If (Column.FieldName = 'CODVEN') And pnlLegendEmpVen.Visible Then
    Begin
      If (dbgPedidos.Canvas.Brush.Color <> clHighlight) Then
      Begin
        If (FieldByName('EMPVEN').AsString = FieldByName('CODEMP').AsString) Then
        Begin
          dbgPedidos.Canvas.Brush.Color := clLime;
        End
        Else
          dbgPedidos.Canvas.Brush.Color := clYellow;
      End;
    End;
  End;
  dbgPedidos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatRetiraDigSeparador.dbgPedidosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pFinalizarThreadNotTinDisp(False);

  If (Key = VK_RETURN) Then
  Begin
    If cdsPedidos.Active And Not cdsPedidos.IsEmpty Then
      If fEmptyStr(cdsPedidos.FieldByName('CODSEP').AsString) Then
        pInformaSeparador
      Else
        pRemoveSeparador;
    pFinalizarThreadNotTinDisp(True);
  End;
  pFinalizarThreadNotTinDisp(True);
end;

function TfrmFatRetiraDigSeparador.fGetSQLPedidos: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE            ';
  Result := Result + '   FATGOR.AUTOINCREM AS AUTINC, ';
  Result := Result + '   FGO_DTAENT AS DTAENT,        ';
  Result := Result + '   FGO_HORENT AS HORENT,        ';
  Result := Result + '   FGO_CODVEN AS CODVEN,        ';
  Result := Result + '   VEN.OPE_CODEMP AS EMPVEN,    ';  
  Result := Result + '   FGO_NUMDOC AS NUMDOC,        ';
  Result := Result + '   FGO_ESPDOC AS ESPDOC,        ';
  Result := Result + '   FGO_CODCLI AS CODCLI,        ';
  Result := Result + '   CONCAT(FGO_CODCLI, " - ", IF(FGO_NOMCON IS NULL, CLI_NOMCLI, FGO_NOMCON)) AS NOMCLI, ';
  Result := Result + '   SUM(IF(FDO_QTDITE > FDO_QTDBAI, FDO_TOTPES, 0)) AS PESBRU, ';
  Result := Result + '   SUM(((FDO_QTDITE - FDO_QTDBAI) * (FDO_UNITAR + (FDO_VALIPI + FDO_TOTFRE + FDO_VALRET + FDO_VALFCP' + fSqlValorReformaFdoRef('FATDOR.AUTOINCREM') + ' - FDO_DESESP) / FDO_QTDITE))) AS VLRCON, ';
  Result := Result + '   SUM(((FDO_QTDITE - FDO_QTDBAI) * (FDO_UNITAR)) - FDO_DESESP) AS VALDOC,              ';
  Result := Result + '   FGO_CODEMP AS CODEMP,        ';
  Result := Result + '   EXTGOR.FGO_SEPRET AS CODSEP, ';
  Result := Result + '   EXTGOR.FGO_DTASEP AS DTASEP, ';
  Result := Result + '   EXTGOR.FGO_HORSEP AS HORSEP, ';
  Result := Result + '   FGO_ENT_CD AS ENT_CD,        ';
  Result := Result + '   CONCAT(IFNULL(EXTGOR.FGO_SEPRET, ""), "-", IFNULL(SEP.OPE_NOMOPE, "")) AS NOMSEP, ';
  Result := Result + '   IF(IFNULL(EXTGOR.FGO_ENTURG, "") = "S", "SIM", "NÃO") AS ENTURG, ';
  Result := Result + '   IF((FDO_QTDITE - FDO_QTDRET)=0,"S","N") AS TOTRETCOF, ';
  Result := Result + '   CONCAT( FGO_MEN001," ", FGO_MEN002 ) AS MENSAGEM, ';
  Result := Result + '   EXTGOR.FGO_SEPANT AS SEPANT, ';
  Result := Result + '   EXTGOR.FGO_DTSANT AS DTSANT, ';
  Result := Result + '   EXTGOR.FGO_HRSANT AS HRSANT, ';
  Result := Result + '   CONCAT(IFNULL(EXTGOR.FGO_SEPANT, ""), "-", IFNULL(SAN.OPE_NOMOPE, "")) AS NOMSAN, ';
  Result := Result + '   FGO_SEPIMP AS SEPIMP, ';
  Result := Result + '   FGO_MENEXP, ';
  Result := Result + '   FGO_MENEX2, ';
  Result := Result + '   FGO_MENEX3, ';
  Result := Result + '   FGO_MENEX4, ';
  Result := Result + '   "" OBSERVACAO ';
  Result := Result + ' FROM      ';
  Result := Result + '   FATGOR  ';
  Result := Result + '   INNER JOIN CADCLI ON FATGOR.FGO_CODCLI = CADCLI.CLI_CODCLI ';
  Result := Result + '   INNER JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';
  Result := Result + '   INNER JOIN FATDOR ON FDO_NUMDOC = FGO_NUMDOC AND           ';
  Result := Result + '                        FDO_ESPDOC = FGO_ESPDOC AND           ';
  Result := Result + '                        FDO_CODEMP = FGO_CODEMP AND           ';
  Result := Result + '                        FDO_CODCLI = FGO_CODCLI               ';
  Result := Result + '   LEFT JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO  ';
  Result := Result + '   LEFT JOIN CADOPE SEP ON SEP.OPE_CODOPE = EXTGOR.FGO_SEPRET ';
  Result := Result + '   LEFT JOIN CADOPE SAN ON SAN.OPE_CODOPE = EXTGOR.FGO_SEPANT ';
  Result := Result + '   LEFT JOIN CADOPE VEN ON VEN.OPE_CODOPE = FATGOR.FGO_CODVEN ';
  Result := Result + ' WHERE                            ';
  Result := Result + '   FGO_CODEMP = :CODEMP AND       ';  
  Result := Result + '   FDO_ENTRET = "R" AND           ';//Somente Retira
  Result := Result + '   FGO_ESPDOC = "PD" AND          ';
  Result := Result + '   FGO_ENT_CD = "N" AND           ';
  Result := Result + '   IFNULL(FGO_LIBERA, 0) > 0 AND  ';
  Result := Result + '   IFNULL(FGO_LIBCOM, 0) > 0 AND  ';
  Result := Result + '   FGO_JAFATU = FALSE AND         ';
  Result := Result + '   FGO_DOCEND IS NULL AND         ';
  Result := Result + '   FGO_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
  Result := Result + '   FDO_EMPITE = FDO_CODEMP AND ';
  Result := Result + '   (LOCATE(FDO_CLAFIS, "5933_6933_") <= 0) AND ';
  Result := Result + '   IF(FDO_ENTFUT = "" OR FDO_ENTFUT IS NULL,"N", FDO_ENTFUT) = "N" AND ';
  Result := Result + '   IFNULL(EXTGOR.FGO_LOC_PD, "N") <> "S" ';
  Result := Result + fGetSQLPedidoTemAoMenosUmJaPegouNao;
  Result := Result + ' GROUP BY ';
  Result := Result + '   FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_CODCLI ';
  Result := Result + ' ORDER BY ';
  Result := Result + '   FGO_DTAENT, FGO_HORENT  ';
end;

function TfrmFatRetiraDigSeparador.fGetSQLPedidoTemAoMenosUmJaPegouNao: String;
begin
  Result := '   AND (SELECT COUNT(EXD.FDO_SEQFDO) FROM EXTDOR EXD '
          + '         INNER JOIN FATDOR FTD ON FTD.AUTOINCREM = EXD.FDO_SEQFDO '
          + '         WHERE FTD.FDO_SEQGER = FATGOR.AUTOINCREM '
          + '           AND EXD.FDO_PEGOU_ <> "S") > 0 ';
end;

procedure TfrmFatRetiraDigSeparador.pCarregaPedidos;
begin
  pFinalizarThreadNotTinDisp(False);
  With cdsPedidos, qryQuery Do
  Begin
    Screen.Cursor := crSQLWait;
    Application.ProcessMessages;

    qryQuery.Close;

    SQL.Clear;
    SQL.Add(fGetSQLPedidos);

    If Assigned(Params.FindParam('CODEMP')) Then
      ParamByName('CODEMP').AsString := VS_strCodEmp;

    fAbreClient(True, 'TfrmFatRetiraDigSeparador.pCarregaPedidos');

    pFormataDecimal('VLRCON', 2);
    pFormataDecimal('VALDOC', 2);

    Screen.Cursor := crDefault;

    dbgPedidos.DataSource := dtsSource;
  End;

  pMontaObservacao;
  pFinalizarThreadNotTinDisp(True);
end;

procedure TfrmFatRetiraDigSeparador.pEncerraThreadNotificacao;
begin
  If (Assigned(thrNotificacao)) Then
  Begin
    pHabilitarNotificacoes(False);
    Sleep(500);

    If (thrNotificacao.Started) Then Begin
      thrNotificacao.Terminate();
    End;

    thrNotificacao.Free();
  End;
end;

procedure TfrmFatRetiraDigSeparador.pFinalizarThreadNotTinDisp(blnAtivarTimer: Boolean);
begin
  If (blnSOMNSP) Then
  Begin
    pHabilitarNotificacoes(blnAtivarTimer);
    If (Assigned(thrNotificacao)) And (thrNotificacao.Started) Then
    Begin
      thrNotificacao.Terminate();
      thrNotificacao.WaitFor();
      thrNotificacao := nil;
    End;
  End;
end;

procedure TfrmFatRetiraDigSeparador.pGerarThreadNotTinDisp;
var
  cdsDocsSep: TZClient;
  strCaminhoSom: string;
begin
  try
    cdsDocsSep := TZClient.Create(nil);
    pCloneDataSet(cdsDocsSep, cdsPedidos);
    cdsDocsSep.Filtered := False;
    cdsDocsSep.Filter := cdsPedidos.Filter;

    if not fEmptyStr(cdsDocsSep.Filter) then
      cdsDocsSep.Filter := cdsDocsSep.Filter + ' AND ';

    cdsDocsSep.Filter := cdsDocsSep.Filter + ' CODSEP IS NULL ';

    cdsDocsSep.Filtered := True;

    If (cdsDocsSep.IsEmpty) Then
      Exit;
  finally
    FreeAndNil(cdsDocsSep);
  end;

  pHabilitarNotificacoes(True);

  strCaminhoSom := fCfgSis('SOMEXP', varString);

  thrNotificacao := TThreadNotificacao.Create(intTMPDNS, strCaminhoSom);
end;

procedure TfrmFatRetiraDigSeparador.pHabilitarNotificacoes(blnAtivar: Boolean);
begin
  tmrTmpIan.Enabled := blnAtivar;
end;

procedure TfrmFatRetiraDigSeparador.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pEncerraThreadNotificacao;
end;

procedure TfrmFatRetiraDigSeparador.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmFatRetiraDigSeparador.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited;
end;

procedure TfrmFatRetiraDigSeparador.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    Close
  Else If Key = VK_F3 Then
    fConferenciaProdutos
  Else If Key = VK_F5 Then
    pCarregaPedidos
  Else If Key = VK_F6 Then
    pImprimirSeparacao(cdsPedidos);
end;

function TfrmFatRetiraDigSeparador.fItensDocumento(strNumDoc, strEspDoc, strCodEmp,
  strCodCli: String): String;
  Var
    qryGen : TUniQuery;
    strQtdPen : String;
begin
  qryGen := fCriaQuery(Self);
  strQtdPen := IIF(fCfgSis('IMSEPO', varString) = 'F', 'FDO_QTDBAI', '(FDO_QTDBAI + FDO_QTDEXP)');

  With qryGen Do
  Begin
    SQL.Add(' SELECT DISTINCT FDO_CODITE  ');
    SQL.Add('   FROM FATDOR ');
    SQL.Add('  INNER JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ');
    SQL.Add('  WHERE FDO_NUMDOC = :NUMDOC ');
    SQL.Add('    AND FDO_ESPDOC = :ESPDOC ');
    SQL.Add('    AND FDO_CODEMP = :CODEMP ');
    SQL.Add('    AND FDO_CODCLI = :CODCLI ');
    SQL.Add('    AND (FDO_QTDITE - ' + strQtdPen + ') > 0 ');
    SQL.Add('    AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITEBOM')));
    SQL.Add('    AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITETAX')));
    SQL.Add('    AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITEMAN')));
    SQL.Add('    AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITELAN')));
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;

    Open;

    Result := '';

    First;
    While Not Eof Do
    Begin

      If Not fEmptyStr(qryGen.Fields[0].AsString) Then
      Begin
        If Not fEmptyStr(Result) Then
          Result := Result + ',';
        Result := Result + '"' + qryGen.Fields[0].AsString + '"';
      End;

      Next;
    End;

    Close;
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmFatRetiraDigSeparador.pImprimirSeparacao(cdsDocumento: TZClient);
  var
    objFatImp: TFatVendaImp;
    documento: TDadosImpressaoVenda;
    strNumDocSeparacao: String;
begin
  pFinalizarThreadNotTinDisp(False);
  If not fEmptyStr(cdsPedidos.FieldByName('CODSEP').AsString) Then
  Begin
    If (cdsPedidos.FieldByName('TOTRETCOF').AsString = 'S') or
       (Not fEmptyStr(cdsPedidos.FieldByName('CODSEP').AsString)) Then
    begin
      if cdsPedidos.FieldByName('SEPIMP').AsString = '1' then
      begin
        strNumDocSeparacao :=
          cdsDocumento.FieldByName('NUMDOC').AsString + '-' +
          cdsDocumento.FieldByName('ESPDOC').AsString + '-' +
          cdsDocumento.FieldByName('CODEMP').AsString;

        if (fMensagem('', 'O documento ' + strNumDocSeparacao + ' já foi separado.'+
          ' Deseja imprimir a separação novamente?', ['&Sim', '&Não'], 1) = 2) then
          Exit;
      end;
    end;

    objFatImp := TFatVendaImp.Create;
    Try
      With documento Do
      Begin
        strNumDoc := cdsDocumento.FieldByName('NUMDOC').AsString;
        strEspDoc := cdsDocumento.FieldByName('ESPDOC').AsString;
        strEmpDoc := cdsDocumento.FieldByName('CODEMP').AsString;
        strCodCli := cdsDocumento.FieldByName('CODCLI').AsString;
        blnEnt_CD := (cdsDocumento.FieldByName('ENT_CD').AsString = 'S');
      End;

      objFatImp.Add(documento);

      if objFatImp.fImprimeSeparacao(objFatImp[0], '', '', False, -1,
        fItensDocumento(documento.strNumDoc, documento.strEspDoc,
          documento.strEmpDoc, documento.strCodCli)) then
      begin
        if cdsPedidos.FieldByName('SEPIMP').AsString = '0' then
        begin
          cdsPedidos.Edit;
          cdsPedidos.FieldByName('SEPIMP').AsString := '1';
          cdsPedidos.Post;
        end;
      end;

    Finally
      If Assigned(objFatImp) Then
        objFatImp.Destroy;
    End;
  End
  Else
  Begin
    pMensagemOk('Ainda não foi informado nenhum separador para este pedido!');
    Exit;
  End;
  pFinalizarThreadNotTinDisp(True);
end;

procedure TfrmFatRetiraDigSeparador.FormShow(Sender: TObject);
begin
  inherited;
  cdsPedidos := TZClient.Create(Self);
  pCarregaPedidos;
  pnlLegendEmpVen.Visible := fCfgSis('EMPVEN', VarBoolean);

  pInicializarNotificacoes;
end;

procedure TfrmFatRetiraDigSeparador.pInformaSeparador;
  Var
    strSenha,
    strSeparador: String;
begin
  pFinalizarThreadNotTinDisp(False);
  If ffrmSenha(strSenha) Then
    strSeparador := fRetCodVendedor(strSenha);

  If Not fEmptyStr(strSeparador) Then
    pAtualizaSeparador(strSeparador);
  pFinalizarThreadNotTinDisp(True);
end;

procedure TfrmFatRetiraDigSeparador.pInicializarNotificacoes;
begin
  blnSOMNSP := fUtilizaSistemaNotificacao;
  intTMPRTE := fCfgSis('TMPRTE', varInteger);
  intTMPIAN := fCfgSis('TMPIAN', varInteger);
  intTMPDNS := fCfgSis('TMPDNS', varInteger);

  If (blnSOMNSP) Then
  Begin
    tmrTmpRte.Interval := intTMPRTE * 1000;
    tmrTmpIan.Interval := intTMPIAN * 1000;
    tmrTmpRte.Enabled  := True;
  End
  Else
  Begin
    thrNotificacao := nil
  End;

  pHabilitarNotificacoes(blnSOMNSP);
end;

procedure TfrmFatRetiraDigSeparador.pRemoveSeparador;
begin
  pFinalizarThreadNotTinDisp(False);
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Expedição de Retira - Separador - Limpar separador.');

  objLiberacao.strDirAce := 'LIMPSEPRET';
  objLiberacao.strMsgSen := 'Expedição de Retira - Limpar separador.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.blnUsarSenhaFixa := False;
  objLiberacao.blnSempreVariavelUsuario := True;

  If objLiberacao.fLibera Then
  Begin
    pAtualizaSeparador('');
  End;
  pFinalizarThreadNotTinDisp(True);
end;

procedure TfrmFatRetiraDigSeparador.tmrTmpIanTimer(Sender: TObject);
begin
  inherited;
  pGerarThreadNotTinDisp();
end;

procedure TfrmFatRetiraDigSeparador.tmrTmpRteTimer(Sender: TObject);
begin
  inherited;
  tmrTmpRte.Enabled := False;
  pCarregaPedidos;
  tmrTmpRte.Enabled := True;
end;

procedure TfrmFatRetiraDigSeparador.pAtualizaSeparador(strCodSep: String);
begin
  pFinalizarThreadNotTinDisp(False);
  pAtualizaSeparadorAnterior(strCodSep);

  With fCriaQuery, SQL Do
  Begin
    Clear;

    Add('UPDATE');
    Add('  EXTGOR,');
    Add('  FATGOR ');
    Add('SET FGO_SEPRET = :CODSEP,');
    Add('    FGO_DTASEP = :DTASEP,');
    Add('    FGO_HORSEP = :HORSEP ');
    Add('WHERE FGO_SEQFGO = AUTOINCREM');
    Add('    AND AUTOINCREM = :AUTINC');

    If fEmptyStr(strCodSep) Then
    Begin
      ParamByName('CODSEP').Value := Null;
      ParamByName('DTASEP').Value := Null;
      ParamByName('HORSEP').Value := Null;
    End
    Else
    Begin
      ParamByName('CODSEP').AsString   := strCodSep;
      ParamByName('DTASEP').AsDatetime := Date;
      ParamByName('HORSEP').AsDatetime := fTime();
    End;

    ParamByName('AUTINC').AsString   := cdsPedidos.FieldByName('AUTINC').AsString;

    ExecSQL;

    cdsPedidos.Edit;
    cdsPedidos.FieldByName('CODSEP').AsString := strCodSep;
    cdsPedidos.FieldByName('NOMSEP').AsString := strCodSep + '-' + fRetNomVendRep(strCodSep);
    cdsPedidos.FieldByName('DTASEP').Value    := ParamByName('DTASEP').Value;
    cdsPedidos.FieldByName('HORSEP').Value    := ParamByName('HORSEP').Value;
    cdsPedidos.Post;

    Destroy;
  End;
  pFinalizarThreadNotTinDisp(True);
end;

function TfrmFatRetiraDigSeparador.fUtilizaSistemaNotificacao: Boolean;
begin
  Result := False;

  If (fCfgSis('SISSON', varString) = 'S') Then
    Result := True;
end;

function TfrmFatRetiraDigSeparador.fUsaTempoSeparacao(strAutoincrem, strCodSep: String):Boolean;
var qryTmp: TUniQuery;
Begin
  Result := True;
  Try
    qryTmp := fCriaQuery(Self);

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT EXP_SEPRET FROM EXPRET ');
      SQL.Add('WHERE EXP_SEQFGO = :AUTOINCREM ');
      SQL.Add('ORDER BY EXP_DTAFIN DESC, EXP_HORFIN DESC ');
      SQL.Add('LIMIT 1 ');
      ParamByName('AUTOINCREM').AsString := strAutoincrem ;
      Open;

      Result := not (FieldByName('EXP_SEPRET').AsString = strCodSep);
    End;
  Except
    FreeAndNil(qryTmp);
  End;
End;

{**********************************************}
{* CHAMA A TELA DE CONFERENCIA DE ITENS DO    *}
{* DOCUMENTO, RESULTA TRUE SE ESTIVER TUDO OK *}
{*******************************************JC*}
function TfrmFatRetiraDigSeparador.fConferenciaProdutos: Boolean;
  Var
    frmFatConfOrcamentosItens: TfrmFatConfOrcamentosItens;
begin
  Result := False;

  If Not cdsPedidos.Active Or cdsPedidos.IsEmpty Then
    Exit;

  If fEmptyStr(cdsPedidos.FieldByName('CODSEP').AsString) Then
  Begin
    pMensagemOk('Ainda não foi informado nenhum separador para este pedido!');
    Exit;
  End;

  Try
    pCriarFormularios(TfrmFatConfOrcamentosItens, frmFatConfOrcamentosItens);
    frmFatConfOrcamentosItens.strNumDoc := cdsPedidos.FieldByName('NUMDOC').AsString;
    frmFatConfOrcamentosItens.strEspDoc := cdsPedidos.FieldByName('ESPDOC').AsString;
    frmFatConfOrcamentosItens.strCodEmp := cdsPedidos.FieldByName('CODEMP').AsString;
    frmFatConfOrcamentosItens.strCodSep := cdsPedidos.FieldByName('CODSEP').AsString;
    frmFatConfOrcamentosItens.blnRetiraDigSeparador := True;

    If fUsaTempoSeparacao( cdsPedidos.FieldByName('AUTINC').AsString,
                           cdsPedidos.FieldByName('CODSEP').AsString ) Then
    Begin
      frmFatConfOrcamentosItens.dtaSepIni := cdsPedidos.FieldByName('DTASEP').AsDateTime;
      frmFatConfOrcamentosItens.horSepIni := cdsPedidos.FieldByName('HORSEP').AsDateTime;
    End
    Else
    Begin
      frmFatConfOrcamentosItens.dtaSepIni := Date;
      frmFatConfOrcamentosItens.horSepIni := fTime();
    End;

    frmFatConfOrcamentosItens.blnRcxF11 := False;
    frmFatConfOrcamentosItens.ShowModal;
    Result := frmFatConfOrcamentosItens.blnConferido;

    If Result Then
    Begin
      If (cdsPedidos.ChangeCount > 0) Then
        cdsPedidos.CancelUpdates;
      cdsPedidos.Refresh;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fConferenciaProdutos]');
    End;
  End;

  pFreeAndNil(frmFatConfOrcamentosItens);
end;


procedure TfrmFatRetiraDigSeparador.pAtualizaSeparadorAnterior(strCodSep: String);
Var qryAtu : TUniQuery;
begin
  pFinalizarThreadNotTinDisp(False);
  If (cdsPedidos.FieldByName('CODSEP').AsString = strCodSep) Or
     (fEmptyStr(cdsPedidos.FieldByName('CODSEP').AsString)) Then
    Exit;

  Try
    qryAtu := fCriaQuery(Self);
    qryAtu.SQL.Clear;

    qryAtu.SQL.Add('UPDATE');
    qryAtu.SQL.Add('  EXTGOR');
    qryAtu.SQL.Add('SET FGO_SEPANT = :CODSEP,');
    qryAtu.SQL.Add('    FGO_DTSANT = :DTASEP,');
    qryAtu.SQL.Add('    FGO_HRSANT = :HORSEP ');
    qryAtu.SQL.Add('WHERE FGO_SEQFGO = :AUTINC');


    qryAtu.ParamByName('CODSEP').Value    := cdsPedidos.FieldByName('CODSEP').AsString;
    qryAtu.ParamByName('DTASEP').Value    := cdsPedidos.FieldByName('DTASEP').Value;
    qryAtu.ParamByName('HORSEP').Value    := cdsPedidos.FieldByName('HORSEP').Value;
    qryAtu.ParamByName('AUTINC').AsString := cdsPedidos.FieldByName('AUTINC').AsString;

    qryAtu.ExecSQL;

    cdsPedidos.Edit;
    cdsPedidos.FieldByName('SEPANT').AsString := cdsPedidos.FieldByName('CODSEP').AsString;
    cdsPedidos.FieldByName('NOMSAN').AsString := cdsPedidos.FieldByName('CODSEP').AsString + '-' + fRetNomVendRep(cdsPedidos.FieldByName('CODSEP').AsString);
    cdsPedidos.FieldByName('DTSANT').Value    := cdsPedidos.FieldByName('DTASEP').Value;
    cdsPedidos.FieldByName('HRSANT').Value    := cdsPedidos.FieldByName('HORSEP').Value;
    cdsPedidos.Post;

  Finally
    pFinalizarThreadNotTinDisp(True);
    FreeAndNil(qryAtu);
  End;
End;

procedure TfrmFatRetiraDigSeparador.pIncluirCampoObservacao(const strCampo: String; var strObservacao: String);
begin
  pFinalizarThreadNotTinDisp(False);
  If fCampoPreenchido(strCampo) Then
  Begin
    If (Not fEmptyStr(strObservacao)) Then
      strObservacao := strObservacao + ' ';

    strObservacao := strObservacao + cdsPedidos.FieldByName(strCampo).AsString;
  End;
  pFinalizarThreadNotTinDisp(True);
end;

procedure TfrmFatRetiraDigSeparador.pMontaObservacao;
  Var
    strObservacao: String;
begin
  pFinalizarThreadNotTinDisp(False);
  cdsPedidos.First;

  While (Not cdsPedidos.Eof) Do
  Begin
    strObservacao := '';

    pIncluirCampoObservacao('FGO_MENEXP', strObservacao);
    pIncluirCampoObservacao('FGO_MENEX2', strObservacao);
    pIncluirCampoObservacao('FGO_MENEX3', strObservacao);
    pIncluirCampoObservacao('FGO_MENEX4', strObservacao);

    If (Not fEmptyStr(strObservacao)) Then
    Begin
      cdsPedidos.Edit;
      cdsPedidos.FieldByName('OBSERVACAO').AsString := strObservacao;
      cdsPedidos.Post;
    End;

    cdsPedidos.Next;
  End;
  pFinalizarThreadNotTinDisp(True);
end;

function TfrmFatRetiraDigSeparador.fCampoPreenchido(strCampo: String): Boolean;
begin
  Result := False;

  If (cdsPedidos.FindField(strCampo) = Nil) Then
    Exit;

  If (fEmptyStr(cdsPedidos.FieldByName(strCampo).AsString)) Then
    Exit;

  Result := True;
end;

end.
