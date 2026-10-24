unit untCadMsg;

interface

uses
  Windows, Classes, Controls, Forms, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons,
  ExtCtrls, AppEvnts, frxClass, frxDBSet, frxDMPExport, BitBtnLockedIncrem, Variants,
  MemDS, DBAccess, Provider, frxExportCSVTestabilidade, Datasnap.DBClient, frxBarcode,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, untfuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, dxCore, untFuncoesRel, untFuncoesRel2;

type
  TfrmCadMsg = class(TfrmPaiOrdena)
    btnLidas: TBitBtnLocked;
    btnAbrir: TBitBtnLocked;
    btnNova: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    btnResponder: TBitBtnLocked;
    pnlLegenda: TPanel;
    shp3: TShape;
    lbl3: TLabel;
    dbgMensagens: TcxGrid;
    dbgMensagensDB: TcxGridDBTableView;
    dbgMensagensMSG_EMPENV: TcxGridDBColumn;
    dbgMensagensMSG_DTAENV: TcxGridDBColumn;
    dbgMensagensMSG_HORENV: TcxGridDBColumn;
    dbgMensagensMSG_OPEENV: TcxGridDBColumn;
    dbgMensagensOPE_OPEENV: TcxGridDBColumn;
    dbgMensagensMSG_TITULO: TcxGridDBColumn;
    dbgMensagensMSG_LIBERA: TcxGridDBColumn;
    dbgMensagensOPE_OPELIB: TcxGridDBColumn;
    dbgMensagensLevel1: TcxGridLevel;
    dbgMensagensMARDES: TcxGridDBColumn;
    dbgMensagensMSG_ABREVI: TcxGridDBColumn;
    procedure btnNovaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLidasClick(Sender: TObject);
    procedure btnAbrirClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure tmrLiberaTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgMensagensDBCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure dbgMensagensDBKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgMensagensDBCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure dbgMensagensDBColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    intSort : Integer;
    tmrLibera: TNewTimer;
    function fMarcaLidas: Boolean;
    function fMarcaOperadorLiberacao(strOpeLib: String): Boolean;
    function fTemOperadorLiberando(): Boolean;
    function fMsgLiberacao: Boolean;
    function fPermiteAbrirMsg(Var strChave: String): Boolean;
    function fGetColunaOrdem: Integer;

    procedure pMarcaDesmarca;
    procedure fConfiguraGrid;
  public
    { Public declarations }
    tmrTemMsg  : TNewTimer;

    class function fGetSqlMsg(strOpeRec: String; blnMsgLib: Boolean; strCampos: String; blnLeftOpeLib: boolean = true): String;
    class function fEnvia(strAssunto : String; blnUnicaMsg : Boolean = False): String;
    class function fMarcaLiberada(strNumLib, strMsgLib: String; strCodLib: String=''): Boolean;
    class function fRetEmpDesCadMsg(strNumLib, strCodRec: String): String;
    class function fGetQtdMensagensNaoLidas: Integer;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
  end;

var
//  frmCadMsg: TfrmCadMsg;
  blnCadMsgAberto: Boolean;

procedure pAbreMensagem(tmrTemMsg: TNewTimer);

implementation

uses
  SysUtils, Graphics, strUtils, untCadMsgEnv, untCadMsgAbrir,
  untCfgRel;

{$R *.dfm}

procedure TfrmCadMsg.btnNovaClick(Sender: TObject);
  Var
    strOpeResp: String;
    strAssuntoResp: String;
    strSeqMsg: String;
    strMsgOri: String;
    strDtaOri: String;
    strHorOri: String;
    frmMsgEnv: TfrmCadMsgEnv;
    blnVaiResponderTodos: Boolean;
    intIdMensagem: integer;
begin
  inherited;

  If Not Self.Visible Then
    Exit;

  If (Assigned(tmrTemMsg)) Then
    tmrTemMsg.Enabled := False;

  strOpeResp    := '';
  strAssuntoResp:= '';
  strSeqMsg     := '';
  strMsgOri     := '';
  strDtaOri     := '';
  strHorOri     := '';
  blnVaiResponderTodos := False;
  intIdMensagem := 0;

  If (Sender = btnResponder) Then
  Begin
    strOpeResp    := cdsConsulta.FieldByName('MSG_OPEENV').AsString;
    strAssuntoResp:= cdsConsulta.FieldByName('MSG_TITULO').AsString;
    strSeqMsg     := cdsConsulta.FieldByName('AUTOINCREM').AsString;
    strMsgOri     := cdsConsulta.FieldByName('MSG_MENSAG').AsString;
    strDtaOri     := cdsConsulta.FieldByName('MSG_DTAENV').AsString;
    strHorOri     := cdsConsulta.FieldByName('MSG_HORENV').AsString;
    intIdMensagem := cdsConsulta.FieldByName('MSG_IDMSG_').AsInteger;
    //Colocado neste local para funcionar somente quando for responder através do botão "[F9] Resp."
    blnVaiResponderTodos := fCfgSis('MSGALL', varBoolean);
  End;

  Try
    pCriarFormularios(TfrmCadMsgEnv,frmMsgEnv);

    frmMsgEnv.strOpeResp     := strOpeResp;
    frmMsgEnv.strAssuntoResp := strAssuntoResp;
    frmMsgEnv.strSeqMsg      := strSeqMsg;
    frmMsgEnv.strMsgOri      := strMsgOri;
    frmMsgEnv.strDtaOri      := strDtaOri;
    frmMsgEnv.strHorOri      := strHorOri;
    frmMsgEnv.intIdMensagem  := intIdMensagem;
    frmMsgEnv.blnVaiResponderTodos := blnVaiResponderTodos;

    frmMsgEnv.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCadMsg.btnNovaClick]');
  End;
  pFreeAndNil(frmMsgEnv);

end;

procedure TfrmCadMsg.btnPesquisarClick(Sender: TObject);
begin
  lflLastField.intIndCol := intSort;
  lflLastField.strNomCam := dbgMensagensDB.Columns[intSort].DataBinding.FieldName;
  lflLastField.strNomCol := dbgMensagensDB.Columns[intSort].Caption;
  lflLastField.ftyTipCam := IIF(dbgMensagensDB.Columns[intSort].DataBinding.FieldName='MSG_DTAENV',ftDate,IIF(dbgMensagensDB.Columns[intSort].DataBinding.FieldName='MSG_HORENV',ftTime,ftString));

  If lflLastField.strNomCam = 'MSG_ABREVI' Then
  Begin
    lflLastField.strNomCam := 'MSG_MENSAG';
    lflLastField.ftyTipCam := ftWideString;
  End;

  inherited;
end;

procedure TfrmCadMsg.dbgMensagensDBCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  pMarcaDesmarca;
end;

procedure TfrmCadMsg.dbgMensagensDBColumnHeaderClick(Sender: TcxGridTableView;
  AColumn: TcxGridColumn);
begin
  inherited;
  intSort := AColumn.VisibleIndex;
  pnlPesquisa.Visible := False;
end;

procedure TfrmCadMsg.dbgMensagensDBCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  strLibera,
  strOpeLib,
  strMarDes : String;
begin
  inherited;

  If AViewInfo.Selected Then
  Begin
    ACanvas.Brush.Color := clMenuHighlight;
    ACanvas.Font.Color  := clWhite;
    Exit;
  End;

  strLibera := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgMensagensMSG_LIBERA.Index]);
  strOpeLib := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgMensagensOPE_OPELIB.Index]);

  If (strLibera = 'S') Then
  Begin
    If fEmptyStr(strOpeLib) Then
      ACanvas.Font.Color  := clRed
    Else
      ACanvas.Font.Color  := clGreen;
  End;

  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgMensagensMARDES.Index]);

  If fEmptyStr(strMarDes) Then
    Exit;

  If (strMarDes = 'M') Then
  Begin
    ACanvas.Brush.Color := clAqua;
    ACanvas.Font.Color  := clBlack;
  End
  Else
  Begin
    ACanvas.Brush.Color := clWhite;
    ACanvas.Font.Color  := clBlack;
  End;
end;

procedure TfrmCadMsg.dbgMensagensDBKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_RETURN) And (Not cdsConsulta.IsEmpty) Then
    pMarcaDesmarca
  Else
  If (Key = VK_DOWN) And (Shift = [ssShift]) And (Not cdsConsulta.IsEmpty) Then
    pMarcaDesmarca
  Else
  If (Key = VK_UP)  And (Shift = [ssShift]) And (Not cdsConsulta.IsEmpty) Then
    pMarcaDesmarca;

end;

class function TfrmCadMsg.fGetSqlMsg(strOpeRec: String; blnMsgLib: Boolean; strCampos: String; blnLeftOpeLib: boolean = true): String;
Var
  strSQL   : String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                           ';
  strSQL := strSQL + '   ' + strCampos + '              ';
  strSQL := strSQL + ',  CAST("" AS CHAR(01)) AS MARDES ';
  strSQL := strSQL + ' FROM                             ';
  strSQL := strSQL + '   CADMSG                         ';

  strSQL := strSQL + '   INNER JOIN CADOPE OPEENV ON ';
  strSQL := strSQL + '     MSG_OPEENV = OPEENV.OPE_CODOPE AND OPEENV.OPE_STATUS <> "I" ';

  if (blnLeftOpeLib) then
  begin
    strSQL := strSQL + '   LEFT JOIN CADOPE OPELIB ON  ';
    strSQL := strSQL + '     MSG_OPELIB = OPELIB.OPE_CODOPE ';
  end;

  strSQL := strSQL + ' WHERE                         ';
  strSQL := strSQL + '   MSG_LIDA__ = "N" AND        ';
  strSQL := strSQL + '   MSG_LIBERA = "' + IIF(blnMsgLib, 'S', 'N') + '" AND ';

  {********************************}
  {* VERIFICA O DIREITO DE ACESSO *}
  {* PARA RECEBER MENSAGENS.      *}
  {*****************************PZ*}
  If Not blnMsgLib Then
  Begin
    If fVerificaAcessoSistema('DIRREC', strOpeRec) Then
      strSQL := strSQL + '   MSG_OPEREC = ' + QuotedStr(strOpeRec)
    Else
      strSQL := strSQL + '   MSG_OPEREC = ' + QuotedStr('-1');
  End
  Else
    strSQL := strSQL + '   MSG_OPEREC = ' + QuotedStr(strOpeRec);

  Result := strSQL;
End;

class function TfrmCadMsg.fEnvia(strAssunto: String; blnUnicaMsg : Boolean): String;
  Var
    frmMsg: TfrmCadMsg;
    frmMsgEnv: TfrmCadMsgEnv;
begin
  pCriarFormularios(TfrmCadMsg, frmMsg);
  With frmMsg Do
  Begin
    If (Assigned(tmrTemMsg)) Then
      tmrTemMsg.Enabled := False;


    Try
      pCriarFormularios(TfrmCadMsgEnv,frmMsgEnv);

      frmMsgEnv.edtAssunto.Text := strAssunto;

      frmMsgEnv.blnUnicaMsg := blnUnicaMsg;

      frmMsgEnv.ShowModal;
      If not fEmptyStr(frmMsgEnv.strAutIncMsg) Then
        Result := frmMsgEnv.strAutIncMsg;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadMsg.btnNovaClick]');
    End;
    pFreeAndNil(frmMsgEnv);
    fAbreConsulta(True);

    If (Assigned(tmrTemMsg)) Then
    Begin
      tmrTemMsg.Enabled := True;
    End;
  End;

end;

function TfrmCadMsg.fGetSql(blnLike: Boolean): String;
Begin
  Result := Self.fGetSqlMsg(strLoginUsuarioLogado, Self.Tag > 0,
    'CADMSG.*, CONCAT(SUBSTR(MSG_MENSAG, 1, 60), "...")  AS MSG_ABREVI, OPEENV.OPE_NOMOPE AS OPE_OPEENV, OPELIB.OPE_NOMOPE AS OPE_OPELIB ');
End;

procedure TfrmCadMsg.FormShow(Sender: TObject);
  Var
    intRecNo: Integer;
begin
  inherited;
  blnCadMsgAberto := True;

  If (Self.Tag = 0) Then
    Self.Caption := 'Mensagens Recebidas'
  Else
    Self.Caption := 'Pedidos de Liberação Recebidos';

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgMensagensDB.Columns[0].DataBinding.FieldName;
  lflLastField.strNomCol := dbgMensagensDB.Columns[0].Caption;
  lflLastField.ftyTipCam := ftDateTime;

  fAbreConsulta(True);

  pSetaClient(cdsConsulta);

  fGetFuncoesCxGrid.fCarregarView(dbgMensagensDB, Self.Name + '.' + dbgMensagensDB.Name, cdsConsulta, intRecNo);

  fConfiguraGrid;

  intSort := fGetColunaOrdem;
  blnSempreRelerBanco := False;

  dbgMensagensOPE_OPEENV.Width := 150;
  dbgMensagensMSG_TITULO.Width := 230;
  dbgMensagensOPE_OPELIB.Width := 142;

  {********************************}
  {* VERIFICA O DIREITO DE ACESSO *}
  {* PARA ENVIAR MENSAGENS.       *}
  {*****************************PZ*}
  btnNova.Enabled  := fVerificaAcessoSistema('DIRENV');

  If (Self.Tag = 1) Then
  Begin
    btnNova.Visible      := False;
    btnResponder.Visible := False;
    btnLidas.Visible     := False;
    tmrLibera.Enabled    := True;
    pnlLegenda.Visible   := True;
  End
  Else
  Begin
    dbgMensagensOPE_OPEENV.Width    := dbgMensagensOPE_OPEENV.Width + dbgMensagensOPE_OPELIB.Width div 2;
    dbgMensagensMSG_TITULO.Width    := dbgMensagensMSG_TITULO.Width + dbgMensagensOPE_OPELIB.Width div 2;
    dbgMensagensOPE_OPELIB.Visible  := False;

    pnlLegenda.Visible              := False;
  End;

  pnlTail.Visible     := pnlLegenda.Visible;
  btnImprimir.Visible := fVerificaAcessoSistema('PIMPME');
end;

procedure TfrmCadMsg.fConfiguraGrid;
Begin
  dbgMensagensMSG_EMPENV.Visible := True;
  dbgMensagensMSG_EMPENV.Visible := True;
  dbgMensagensMSG_DTAENV.Visible := True;
  dbgMensagensMSG_HORENV.Visible := True;
  dbgMensagensMSG_OPEENV.Visible := True;
  dbgMensagensOPE_OPEENV.Visible := True;
  dbgMensagensMSG_TITULO.Visible := True;
  dbgMensagensMSG_ABREVI.Visible := True;
  dbgMensagensMSG_LIBERA.Visible := True;
  dbgMensagensOPE_OPELIB.Visible := True;
End;

function TfrmCadMsg.fPermiteAbrirMsg(Var strChave: String): Boolean;
Begin
  If (fMsgLiberacao) And (Not fEmptyStr(cdsConsulta.FieldByName('MSG_NUMLIB').AsString)) Then
  Begin
    strChave := 'MENSAGEM_LIBERACAO_' + cdsConsulta.FieldByName('MSG_NUMLIB').AsString;

    Result := fLock_Unlock(strChave, True, False);

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa liberação está sendo analisada por outra estação: ' + Chr(13) +
                fGetHostLock(strChave), ['&OK']);
    End;
  End
  Else
  Begin
    strChave := '';
    Result := True;
  End;
end;

procedure TfrmCadMsg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tmrLibera.Enabled  := False;
  TNewTimer.Del(Self.Name + '.tmrLibera');
  fGetFuncoesCxGrid.pSalvarView(dbgMensagensDB, Self.Name + '.' + dbgMensagensDB.Name, cdsConsulta);
  inherited;
  blnCadMsgAberto := False;
end;

procedure TfrmCadMsg.FormCreate(Sender: TObject);
begin
  inherited;
  tmrLibera := TNewTimer.Get(Self.Name + '.tmrLibera');
  tmrLibera.Interval := 10000;
  tmrLibera.Enabled  := False;
  tmrLibera.OnTimer  := tmrLiberaTimer;
end;

procedure TfrmCadMsg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    blnSempreLerBancoAtual: Boolean;
begin
  If Key = VK_RETURN Then
  Begin
    If (pnlPesquisa.Visible) And (edtString.Focused) And
       (lflLastField.strNomCam = 'MSG_MENSAG') Then
    Begin
      blnSempreLerBancoAtual := blnSempreRelerBanco;

      blnSempreRelerBanco := True;
      inherited;
      blnSempreRelerBanco := blnSempreLerBancoAtual;
      Exit;
    End;
  End;

  inherited;
  Case Key Of
    VK_F6 : btnAbrir.Click;
    VK_F7 : btnNova.Click;
    VK_F8 : btnImprimir.Click;
    VK_F9 : btnResponder.Click;
    VK_F10: btnLidas.Click;
  End;
end;

class function TfrmCadMsg.fRetEmpDesCadMsg(strNumLib, strCodRec: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Result := '';
  qryGen := fCriaQuery;
  Try
    If (Not fEmptyStr(strNumLib)) And (Not fEmptyStr(strCodRec)) Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT LEFT(AUTOINCREM,3) AS EMPDES, MSG_OPEREC FROM CADMSG ';
      strSQL := strSQL + '  WHERE MSG_NUMLIB = :NUMLIB ';
      strSQL := strSQL + '    AND MSG_OPELIB IS NULL ';

      With qryGen Do
      Begin
        SQL.Clear;
        SQL.Add(strSQL);
        ParambyName('NUMLIB').AsString := strNumLib;
        Open;

        If Not IsEmpty Then
        Begin
          Locate('MSG_OPEREC', strCodRec, []);
          Result := Fields[0].AsString;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

class function TfrmCadMsg.fMarcaLiberada(strNumLib, strMsgLib: String; strCodLib: String=''): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Result := True;
  Try
    If (Not fEmptyStr(strNumLib)) Then
    Begin
      fStartTransaction;

      strSQL := '';
      strSQL := strSQL + ' UPDATE CADMSG           ';
      strSQL := strSQL + ' SET                     ';
      strSQL := strSQL + '   MSG_LIDA__ = "S",     ';
      If (Not fEmptyStr(strCodLib)) Then
        strSQL := strSQL + '   MSG_OPELIB = :OPELIB,  ';
      strSQL := strSQL + '   MSG_MSGLIB = :MSGLIB  ';
      strSQL := strSQL + ' WHERE                   ';
      strSQL := strSQL + '   MSG_NUMLIB = :NUMLIB  ';
      If (fEmptyStr(strCodLib)) Then
        strSQL := strSQL + '   AND MSG_LIDA__ = "N"   ';

      qryGen := fCriaQuery;

      With qryGen Do
      Begin
        SQL.Clear;
        SQL.Add(strSQL);
        ParambyName('MSGLIB').AsString := strMsgLib;
        If (Not fEmptyStr(strCodLib)) Then
          ParambyName('OPELIB').AsString := strCodLib;
        ParambyName('NUMLIB').AsString := strNumLib;
        ExecSQL;
      End;

      fCommit;

      FreeAndNil(qryGen);
    End;
  Except
    On E : Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmCadMsg.fMarcaOperadorLiberacao(strOpeLib: String): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Result := True;
  Try
    If cdsConsulta.Active And (Not fEmptyStr(cdsConsulta.FieldByName('MSG_NUMLIB').AsString)) Then
    Begin
      fStartTransaction;
      strSQL := '';
      strSQL := strSQL + ' UPDATE CADMSG           ';
      strSQL := strSQL + ' SET                     ';
      strSQL := strSQL + '   MSG_OPELIB = :OPELIB  ';
      strSQL := strSQL + ' WHERE                   ';
      strSQL := strSQL + '   MSG_NUMLIB = :NUMLIB  ';
      qryGen := fCriaQuery;

      With qryGen Do
      Begin
        SQL.Clear;
        SQL.Add(strSQL);

        If fEmptyStr(strOpeLib) Then
          ParambyName('OPELIB').Value := Null
        Else
          ParambyName('OPELIB').AsString := strOpeLib;

        ParambyName('NUMLIB').AsString := cdsConsulta.FieldByName('MSG_NUMLIB').AsString;
        ExecSQL;
      End;

      cdsConsulta.Edit;
      cdsConsulta.FieldbyName('MSG_OPELIB').AsString := strOpeLib;
      cdsConsulta.FieldbyName('OPE_OPELIB').AsString := fRetNomeOperador(strOpeLib);
      cdsConsulta.Post;

      fCommit;
      FreeAndNil(qryGen);
    End;
  Except
    On E : Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmCadMsg.fTemOperadorLiberando(): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Result := False;
  Try
    If cdsConsulta.Active And (Not fEmptyStr(cdsConsulta.FieldByName('MSG_NUMLIB').AsString)) Then
    Begin
      qryGen := fCriaQuery;

      With qryGen Do
      Begin
        SQL.Clear;
        SQL.Add('SELECT MSG_OPELIB FROM CADMSG WHERE MSG_NUMLIB = :NUMLIB');
        ParambyName('NUMLIB').AsString := cdsConsulta.FieldByName('MSG_NUMLIB').AsString;
        Open;
      End;

      If (Not fEmptyStr(qryGen.FieldByName('MSG_OPELIB').AsString)) And
         (qryGen.FieldByName('MSG_OPELIB').AsString <> strLoginUsuarioLogado) Then
      Begin
        Result := True;

        cdsConsulta.Edit;
        cdsConsulta.FieldbyName('MSG_OPELIB').AsString := qryGen.FieldByName('MSG_OPELIB').AsString;
        cdsConsulta.FieldbyName('OPE_OPELIB').AsString := fRetNomeOperador(qryGen.FieldByName('MSG_OPELIB').AsString);
        cdsConsulta.Post;

        pMensagemOk('Essa liberação já está sendo analisada por outro operador:' + #13#10 +
                     cdsConsulta.FieldbyName('MSG_OPELIB').AsString + ' - ' +
                     cdsConsulta.FieldbyName('OPE_OPELIB').AsString);
      End;

      FreeAndNil(qryGen);
    End;
  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

Function TfrmCadMsg.fMarcaLidas: Boolean;
  Var
    strSQL,
    strSelecao: String;
    qryGen: TUniQuery;

  function fRetornaSelecionados : String;
    var
      cdsMsgSel: TUniClientDataSet;
      strTag : String;
  begin

    Result := '';
    strTag := '';

    cdsMsgSel          := TUniClientDataSet.Create(nil);
    cdsMsgSel.Data     := cdsConsulta.Data;
    cdsMsgSel.Filter   := 'MARDES = ' + QuotedStr('M');
    cdsMsgSel.Filtered := True;

    cdsMsgSel.First;

    While Not cdsMsgSel.Eof Do
    Begin
      Result := Result + strTag + QuotedStr(cdsMsgSel.FieldByName('AUTOINCREM').AsString);
      strTag := ',';

      cdsMsgSel.Next;
    End;

    FreeAndNil(cdsMsgSel);
  end;
Begin
  Result := True;

  strSelecao := fRetornaSelecionados;

  If fEmptyStr(strSelecao) Then
  Begin
    fMensagem('', 'Selecione as mensagens com [ENTER] ou [Duplo Click]' , ['&O k']);
    Exit;
  End;

  If (fMensagem('', 'Confirma marcar as mensagens como lidas?', ['&Sim', '&Não']) = 2) Then
    Exit;

  Try
    If cdsConsulta.Active And (Not fEmptyStr(strSelecao)) Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' UPDATE CADMSG           ';
      strSQL := strSQL + ' SET                     ';
      strSQL := strSQL + '   MSG_LIDA__ = "S"      ';
      strSQL := strSQL + ' WHERE                   ';
      strSQL := strSQL + '   AUTOINCREM IN (' +  strSelecao + ')';

      qryGen := fCriaQuery;
      With qryGen Do
      Begin
        SQL.Clear;
        SQL.add(strSQL);
        ExecSQL;
      End;

      FreeAndNil(qryGen);

      stlListSelecao.Clear;

      fAbreConsulta(True);
    End;
  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[fMarcaLidas]');
    End;
  End;
End;

function TfrmCadMsg.fMsgLiberacao: Boolean;
begin
  Result := (cdsConsulta.FindField('MSG_LIBERA') <> Nil) And
            (cdsConsulta.FieldByName('MSG_LIBERA').AsString = 'S');
end;

procedure TfrmCadMsg.btnLidasClick(Sender: TObject);
begin
  inherited;
  If Not btnLidas.Visible Then
    Exit;
  fMarcaLidas;
end;

procedure TfrmCadMsg.btnMudaOrdemClick(Sender: TObject);
var
  intCount : Integer;
begin
  pnlPesquisa.Visible := False;

  dbgMensagensDB.Columns[intSort].SortOrder := soNone;
  Inc(intSort);

  For intCount := intSort To dbgMensagensDB.ColumnCount-1 Do
  Begin
    If dbgMensagensDB.Columns[intCount].Visible Then
    Begin
      intSort := intCount;
      Break;
    End;
  End;

  If intCount >= dbgMensagensDB.ColumnCount-1 Then
    intSort := 0;

  dbgMensagensDB.Columns[intSort].SortOrder := soAscending;
end;

procedure TfrmCadMsg.btnAbrirClick(Sender: TObject);
  Var
    strChave: String;
    frmMsgAbrir: TfrmCadMsgAbrir;
begin
  inherited;

  tmrLibera.Enabled := False;

  Try
    If (Self.Tag = 1) And fTemOperadorLiberando Then
      Exit;

    If Not fPermiteAbrirMsg(strChave) Then
      Exit;

    Try
      If (Self.Tag = 1) Then
        fMarcaOperadorLiberacao(strLoginUsuarioLogado);

      pCriarFormularios(TfrmCadMsgAbrir, frmMsgAbrir);
      frmMsgAbrir.frmMsg := Self;
      frmMsgAbrir.ShowModal;

      If (Self.Tag = 1) Then
      Begin
        If (frmMsgAbrir.ModalResult = mrOk) Then
        Begin
          stlListSelecao.Clear;
          pAddListaQuery;
          lflLastField.intIndCol := -1;

          If cdsConsulta.Active Then
            fMarcaLiberada(cdsConsulta.FieldByName('MSG_NUMLIB').AsString, frmMsgAbrir.strMsgLib);

          fAbreConsulta(True);

          If cdsConsulta.IsEmpty Then
            Close;
        End
        Else
          fMarcaOperadorLiberacao('');
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadMsg.btnAbrirClick]');
    End;

    fLock_Unlock(strChave, False, False);

    pFreeAndNil(frmMsgAbrir);
  Finally
    tmrLibera.Enabled := (Self.Tag = 1);
  End;
end;

procedure pAbreMensagem(tmrTemMsg: TNewTimer);
  Var
    qryGen: TUniQuery;
    blnTemMsg: Boolean;
    frmMsg: TfrmCadMsg;
Begin

  blnTemMsg := False;

  {******************************}
  {* VERIFICA DIREITO DE ACESSO *}
  {* PARA RECEBER MENSAGENS.    *}
  {***************************PZ*}
  If (Not fVerificaAcessoSistema('DIRREC')) Then
    Exit;

  qryGen := fCriaQuery;
  Try
    Try
      With qryGen Do
      Begin
        SQL.Clear;
        SQL.add(TfrmCadMsg.fGetSqlMsg(strLoginUsuarioLogado, False, 'COUNT(0)', False));
        Open;
        blnTemMsg := Fields[0].AsInteger > 0;
        Close;
      End;
    Except
      On E : Exception Do
        pMensagensErro(E.Message, '[fMarcaLidas]');
    End;
  Finally
    FreeAndNil(qryGen);
  End;

  If blnTemMsg Then
  Begin
    Try
      Try
        pCriarFormularios(TfrmCadMsg, frmMsg);
        frmMsg.tmrTemMsg   := tmrTemMsg;
        frmMsg.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pAbreMensagem]');
          Exit;
        End;
      End;
    finally
      pFreeAndNil(frmMsg);
    end;
  End;
End;

procedure TfrmCadMsg.btnImprimirClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.IsEmpty Then
    Exit;

  If Not btnImprimir.Visible Then
    Exit;

  With cdsConsulta Do
  Begin
    If Assigned(prcExecutaRelatorio) Then
      prcExecutaRelatorio(56,
                          4929,
                          [],
                          ['OPEREC','CODMSG'],
                          [cdsConsulta.FieldByName('MSG_OPEREC').AsString,cdsConsulta.FieldByName('MSG_CODMSG').AsString],
                          Sender,
                          nil,
                          True);
  End;

end;

procedure TfrmCadMsg.pMarcaDesmarca;
begin
  If cdsConsulta.FieldByName('MARDES').AsString = 'M' Then
  Begin
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('MARDES').AsString := '';
    cdsConsulta.Post;
  End
  Else
  Begin
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('MARDES').AsString := 'M';
    cdsConsulta.Post;
  End;
end;

procedure TfrmCadMsg.tmrLiberaTimer(Sender: TObject);
begin
  inherited;
  Try
    tmrLibera.Enabled := False;
    lflLastField.intIndCol := -1;
    fAbreConsulta(True);
    If cdsConsulta.IsEmpty Then
      Close;
  Finally
    tmrLibera.Enabled := True;
  End;
end;

function TfrmCadMsg.fGetColunaOrdem: Integer;
var
  intCount : Integer;
begin
  Result := 0;

  For intCount := 0 To dbgMensagensDB.ColumnCount-1 Do
  Begin
    If dbgMensagensDB.Columns[intCount].SortOrder <> soNone Then
    Begin
      Result := intCount;
      Break;
    End;
  End;
end;

class function TfrmCadMsg.fGetQtdMensagensNaoLidas: Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(Self.fGetSqlMsg(strLoginUsuarioLogado, False, 'COUNT(0)', False));
    qryGen.Open;
    Result := qryGen.Fields[0].AsInteger;
  Finally
    FreeAndNil(qryGen);
  End;
end;

initialization

  blnCadMsgAberto := False;

end.

