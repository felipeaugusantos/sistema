{***********************}
{* qryConFpg -> CADFPG *}
{********************JB*}
{***********************}
{* qryTipClg -> TIPCLG *}
{* qryTipCld -> TIPCLD *}
{********************RV*}

unit untCadTiposCliente;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, DBCtrls, DBEditFocus, EditFocus, Uni,
  AppEvnts, MaskEditFocus, DB, UniClientDataSet, BitBtnLockedIncrem,
  MemDS, DBAccess, Provider, Mask, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTiposCliente = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    pnlDadosFpg: TPanel;
    pnlConfirma: TPanel;
    pnlCndPag: TPanel;
    dbgTipos: TDBGridCitel;
    dbgTipCnd: TDBGridCitel;
    Label1: TLabel;
    dbeCodTip: TDBEditFocus;
    Label2: TLabel;
    dbeDesTip: TDBEditFocus;
    Label3: TLabel;
    edtCodFpg: TEditFocus;
    edtCodCnd: TEditFocus;    
    edtDesFpg: TEditFocus;
    mskCndPag: TMaskEditFocus;
    qryConsulta: TUniQuery;
    dtsConsulta: TDataSource;
    dtsTipClg: TDataSource;
    dtsTipCnd: TDataSource;
    pnl1: TPanel;
    lbl4: TLabel;
    lbl5: TLabel;
    btnConfirmar: TBitBtnLocked;
    btnCancelaFpg: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtCodFpgKeyPress(Sender: TObject; var Key: Char);
    procedure dbgTiposKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaFpgClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure dbgTipCndKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    qryConCnd: TUniQuery;
    qryTipClg: TUniQuery;
    qryTipCld: TUniQuery;

    qryTipCnd: TUniQuery;
    cdsTipCnd: TUniClientDataSet;
    cdsConsulta: TUniClientDataSet;

    blnAltCnd: Boolean;
    blnAltFpg: Boolean;

    procedure pDeletaTemporaria;

    procedure pAdicionaFpg;
    procedure pCarregaFpgAlteracao;

    procedure pAdicionaCnd;
    procedure pCarregaCndAlteracao;

    procedure pCarregaCadFpg;
    procedure pCarregaCadCnd;

    procedure pHabilitaPnl(blnHabilita: Boolean = True);

    function fGravaTipCld(strCodTip, strCodFpg: String): Boolean;
    function fGravaTipCnd: Boolean;
    function fApagaTipCnd: Boolean;
    procedure pDeletaFormasTipo(strCodTip: String);

    function fCarregaFormasPagamento(strCodTip: String): Boolean;
    function fCarregaCondicaoPagamento(strCodTip: String): Boolean;    
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, untFuncoes, Variants, untFuncoesSimples, untPai, untConsultas,
  untTypesSistema, untConstantes;

{$R *.dfm}

{ TfrmCadTiposCliente }

function TfrmCadTiposCliente.fApagaTipCnd: Boolean;
Var
  strSQL: String;
  qryTCn: TUniQuery;
begin

  Result := False;

  Try

    qryTCn := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  TIPCND    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  TCN_CODTIP = :CODTIP ';

    With qryTCn Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODTIP').AsString := dbeCodTip.Text;
      ExecSQL;
      Result := True;
    End;

  Except
    On E:Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadTiposCliente.fApagaTipCnd]');
    End;
  End;

  FreeAndNil(qryTcn);

end;

function TfrmCadTiposCliente.fCarregaCondicaoPagamento(
  strCodTip: String): Boolean;
Var
    strSQL   : String;

    procedure pFormataCondPagto;
    Begin
      If (Not Assigned(cdsTipCnd)) Then
        Exit;

      With cdsTipCnd Do
      Begin
        First;

          While Not Eof Do
          Begin
            Edit;
            FieldByName('TCN_CNDPAG').AsString := fFormataCondPag(FieldByName('TCN_CNDPAG').AsString);
            Post;

            Next;
          End;

        First;
      End;

    End;

begin

  Result := False;

  if Assigned(cdsTipCnd) then
    cdsTipCnd.EmptyDataSet;

  If fCfgSis('USACND') = 'S' Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  TCN_CODCND, ';
    strSQL := strSQL + '  CAST( IF(IFNULL(TCN_CNDPAG, "") = "", CND_CNDPAG, TCN_CNDPAG) AS CHAR(100) ) AS TCN_CNDPAG, ';
    strSQL := strSQL + '  CND_DESCRI ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  TIPCND ';
    strSQL := strSQL + '  LEFT JOIN CADCND ON CND_CODIGO = TCN_CODCND ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  TCN_CODTIP = :CODTIP  ';
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  TCN_CODCND ';

    With qryTipCnd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODTIP').AsString := dbeCodTip.Text;
      Open;
      pSetaClient(qryTipCnd);

      if Assigned(cdsTipCnd) then
        FreeAndNil(cdsTipCnd);

      cdsTipCnd := fCriaClientDatset(qryTipCnd);
      pSetaClient(cdsTipCnd);
    End;
  End
  Else
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  TCN_CODCND, ';
    strSQL := strSQL + '  CAST( TCN_CNDPAG  AS CHAR(100) ) AS TCN_CNDPAG  ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  TIPCND ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  TCN_CODTIP = :CODTIP  ';
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  TCN_CNDPAG ';

    With qryTipCnd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODTIP').AsString := dbeCodTip.Text;
      Open;
      pSetaClient(qryTipCnd);

      if Assigned(cdsTipCnd) then
        FreeAndNil(cdsTipCnd);

      cdsTipCnd := fCriaClientDatset(qryTipCnd);
      pSetaClient(cdsTipCnd);
    End;
  End;

  pFormataCondPagto;
  dtsTipCnd.DataSet := cdsTipCnd;
end;

function TfrmCadTiposCliente.fCarregaFormasPagamento(
  strCodTip: String): Boolean;
  Var
    strSQL   : String;
begin
  pDeletaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  TCD_CODFPG AS TIP_CODFPG, ';
  strSQL := strSQL + '  FPG_DESCRI AS TIP_DESFPG  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TIPCLD, ';
  strSQL := strSQL + '  CADFPG ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TCD_CODFPG = FPG_CODIGO AND ';
  strSQL := strSQL + '  TCD_CODTIP = :CODTIP ';

  With qryConsulta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODTIP').AsString := strCodTip;
    Open;
    pSetaClient(qryConsulta);

    if Assigned(cdsConsulta) then
      FreeAndNil(cdsConsulta);

    cdsConsulta := fCriaClientDatset(qryConsulta);
    pSetaClient(cdsConsulta);
  End;

  Result := True;
  dtsConsulta.DataSet := cdsConsulta;
end;

function TfrmCadTiposCliente.fGravaTipCld(strCodTip,
  strCodFpg: String): Boolean;
begin
  Try
    With qryTipCld Do
    Begin
      If (Not Active) Then
        Open;
      Append;
      FieldByName('TCD_CODTIP').AsString := strCodTip;
      FieldByName('TCD_CODFPG').AsString := strCodFpg;
      FieldByName('TCD_CODEMP').AsString := VS_strCodEmp;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('TIPCLD', VS_strCodEmp);
      Post;
    End;
    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fGravaTipCld]');
    End;
  End;
end;

function TfrmCadTiposCliente.fGravaTipCnd: Boolean;
Var
  strSQL: String;
  qryTCn: TUniQuery;
begin
  Result := False;

  If (Not fApagaTipCnd) Then
    Exit;

  Try

    qryTCn := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM TIPCND WHERE FALSE ';

    With qryTCn Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      cdsTipCnd.First;

      While Not cdsTipCnd.Eof Do
      Begin
        Append;
        FieldByName('TCN_CODTIP').AsString := dbeCodTip.Text;

        If fCfgSis('USACND') = 'S' Then
          FieldByName('TCN_CODCND').AsString := cdsTipCnd.FieldByName('TCN_CODCND').AsString
        Else
          FieldByName('TCN_CNDPAG').AsString := fTiraCaracEspeciais(cdsTipCnd.FieldByName('TCN_CNDPAG').AsString, True, True, True);

        FieldByName('TCN_CODEMP').AsString := VS_strCodEmp;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('TIPCND', VS_strCodEmp);
        Post;
        cdsTipCnd.Next;
      End;

      cdsTipCnd.First;

      Result := True;

    End;

  Except
    On E:Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadTiposCliente.fGravaTipCnd]');
    End;
  End;

  FreeAndNil(qryTCn);

end;

function TfrmCadTiposCliente.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeCodTip) And (dbeCodTip.Enabled) Then
  Begin

    If (fEmptyStr(dbeCodTip.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código do tipo deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      fBuscaPorCamposChave;
      fCarregaFormasPagamento(dbeCodTip.Text);
      fCarregaCondicaoPagamento(dbeCodTip.Text);
      pHabilitaPnl;
    End;

  End

  Else If (Sender = dbeDesTip) Then
  Begin

    If (fEmptyStr(dbeDesTip.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pHabilitaPnl;
    End;

  End

  Else If (Sender = edtCodCnd) And (edtCodCnd.Visible) Then
  Begin
    If fEmptyStr(edtCodCnd.Text) Then
    Begin
      mskCndPag.Clear;
      pnlCabecalho.Enabled := False;
    End

    Else If (cdsTipCnd.Locate('TCN_CODCND', edtCodCnd.Text, [])) Then
    Begin
      pCarregaCndAlteracao;
    End

    Else
    Begin
      pCarregaCadCnd;
      If (qryConCnd.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa condição não está cadastrada!', ['&Ok']);
        Result := False;
      End

      Else
      Begin
        pnlCabecalho.Enabled := False;
        pnlDadosFpg.Enabled  := True;
      End;
    End;
  End

  Else If (Sender = mskCndPag) And (Not mskCndPag.ReadOnly) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text))) Then
    Begin
      If (cdsTipCnd.Locate('TCN_CNDPAG', fFormataCondPag(mskCndPag.Text), [])) Then
      Begin
        pCarregaCndAlteracao;
      End
      Else If (Not fValidaCndPag(mskCndPag.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa condição não é válida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pnlCabecalho.Enabled := False;
      End;
    End
    Else
    Begin
      pnlCabecalho.Enabled := False;
    End;
  End

  Else If (Sender = edtCodFpg) And (blnBuscaPorChave) Then
  Begin

    If (fEmptyStr(edtCodFpg.Text)) Then
    Begin
      pnlCabecalho.Enabled := False;
    End

    Else If Assigned(cdsConsulta) And (cdsConsulta.Locate('TIP_CODFPG', edtCodFpg.Text, [])) Then
    Begin
      pCarregaFpgAlteracao;
    End

    Else
    Begin
      pCarregaCadFpg;
      If (fEmptyStr(edtDesFpg.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa forma de pagamento não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadTiposCliente.pAdicionaFpg;
begin

  If (fEmptyStr(edtCodFpg.Text)) Then
  Begin
    Exit;
  End;

  if Assigned(cdsConsulta) then
  Begin
    With cdsConsulta Do
    Begin

      If (blnAltFpg) Then
        Edit
      Else
        Append;

      FieldByName('TIP_CODFPG').AsString := edtCodFpg.Text;
      FieldByName('TIP_DESFPG').AsString := edtDesFpg.Text;
      Post;
    End;
  End;
end;

procedure TfrmCadTiposCliente.pAdicionaCnd;
begin

  If (fEmptyStr(edtCodCnd.Text)) And (fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text, True, True, True))) Then
  Begin
    Exit;
  End;

  With cdsTipCnd Do
  Begin

    If (blnAltCnd) Then
      Edit
    Else
      Append;

    FieldByName('TCN_CODCND').AsString := edtCodCnd.Text;
    FieldByName('CND_DESCRI').AsString := fRetDesConPag(edtCodCnd.Text);
    FieldByName('TCN_CNDPAG').AsString := fFormataCondPag(fTiraCaracEspeciais(mskCndPag.Text, True, True, True));
    Post;
  End;

end;

procedure TfrmCadTiposCliente.pCarregaCadFpg;
begin
  edtDesFpg.Text := fRetDesFpg(edtCodFpg.Text);
end;

procedure TfrmCadTiposCliente.pCarregaFpgAlteracao;
begin
  blnAltFpg := True;

  if Assigned(cdsConsulta) then
  Begin
    With cdsConsulta Do
    Begin
      edtCodFpg.Text := FieldByName('TIP_CODFPG').AsString;
      edtDesFpg.Text := FieldByName('TIP_DESFPG').AsString;
    End;
  End;
end;

procedure TfrmCadTiposCliente.pCarregaCndAlteracao;
begin
  blnAltCnd := True;

  With cdsTipCnd Do
  Begin
    edtCodCnd.Text := FieldByName('TCN_CODCND').AsString;
    mskCndPag.Text := fTiraCaracEspeciais(FieldByName('TCN_CNDPAG').AsString, True, True, True);
  End;
end;

procedure TfrmCadTiposCliente.pDeletaFormasTipo(strCodTip: String);
  Var
    strSQL   : String;
    qryGenCld: TUniQuery;
begin
  Try
    qryGenCld := fCriaQuery(Self);
    Try
      strSQL := '';
      strSQL := strSQL + 'DELETE FROM TIPCLD WHERE TCD_CODTIP = :CODTIP ';
      With qryGenCld Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODTIP').AsString := strCodTip;
        ExecSQL;
        Close;
      End;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[pDeletaFormasTipo]');
      End;
    End;
  Finally
    FreeAndNil(qryGenCld);
  End;
end;

procedure TfrmCadTiposCliente.pDeletaTemporaria;
begin
  if Assigned(cdsConsulta) then
    cdsConsulta.EmptyDataSet;

  if Assigned(cdsTipCnd) then
    cdsTipCnd.EmptyDataSet;
end;

procedure TfrmCadTiposCliente.pEscapePressed;
begin
  If (ActiveControl.Parent = pnlDadosFpg) Then
  Begin
    pnlCabecalho.Enabled := True;
    pHabilitaPnl(False);
    pSetFocus(dbeDesTip);
  End
  Else
  Begin
    inherited;
  End;

end;

procedure TfrmCadTiposCliente.pHabilitaPnl(blnHabilita: Boolean);
begin
  pnlDadosFpg.Enabled := blnHabilita;
  pnlCndPag.Enabled   := blnHabilita;
  pnlConfirma.Enabled := blnHabilita;
  dbgTipos.Enabled    := blnHabilita;
  dbgTipCnd.Enabled   := blnHabilita;
end;

procedure TfrmCadTiposCliente.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('TIP_CODTIP');
  stlCampos.Add('TIP_DESTIP');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('TIP_CODTIP');
  stlCamInd.Add('TIP_DESTIP');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadTiposCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Action <> caNone) Then
  Begin
    pDeletaTemporaria;
    FreeAndNil(qryConCnd);
    FreeAndNil(qryTipClg);
    FreeAndNil(qryTipCld);
  End;
end;

procedure TfrmCadTiposCliente.FormCreate(Sender: TObject);
begin
  inherited;
  qryTipCld         := fCriarQuery('SELECT * FROM TIPCLD WHERE FALSE', Self);

  qryTipClg         := fCriaQuery(Self);
  qryTabela         := qryTipClg;
  dtsTipClg.DataSet := qryTabela;

  qryTipCnd := fCriaQuery(Self);

  strNomeTabela     := 'TIPCLG';
  strNomeCampo      := 'TIP_CODTIP';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodTip;

  qryConCnd := fCriaQuery(Self);

  blnAltCnd := False;
  blnAltFpg := False;

  If (fCfgSis('USACND') <> 'S') Then
  Begin
    edtCodCnd.Visible  := False;
    mskCndPag.Left     := edtCodCnd.Left;
    mskCndPag.ReadOnly := False;
    mskCndPag.TabStop  := True;
    mskCndPag.Width    := mskCndPag.Width + edtCodCnd.Width+1;
  End;

  pHabilitaPnl(False);
  mskCndPag.EditMask := MASK_CONPAG;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadTiposCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F3) Then
  Begin
    If (ActiveControl <> edtCodCnd) And (edtCodCnd.CanFocus) Then
      pSetFocus(edtCodCnd)
    Else If (ActiveControl <> dbgTipCnd) And (dbgTipCnd.CanFocus) Then
      pSetFocus(dbgTipCnd);
  End
  Else If (Key = VK_F4) Then
  Begin
    If (ActiveControl <> edtCodFpg) And (edtCodFpg.CanFocus) Then
      pSetFocus(edtCodFpg)
    Else If (ActiveControl <> dbgTipos) And (dbgTipos.CanFocus) Then
      pSetFocus(dbgTipos);
  End;
end;

procedure TfrmCadTiposCliente.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) Then
  Begin

    {If (fEmptyStr(edtCodFpg.Text)) Then
    Begin
      btnCancelaFpg.Click;
      Exit;
    End;}

    pAdicionaFpg;
    pAdicionaCnd;
    btnCancelaFpg.Click;
  End;
end;

procedure TfrmCadTiposCliente.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pDeletaTemporaria;
  fCarregaFormasPagamento(dbeCodTip.Text);
  fCarregaCondicaoPagamento(dbeCodTip.Text);
  pCarregaCadCnd;

  pnlCabecalho.Enabled := True;
  pHabilitaPnl(False);
  dbgTipos.Enabled     := False;
  dbgTipCnd.Enabled    := False;
end;

procedure TfrmCadTiposCliente.edtCodFpgKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrForma: TConsultasArray;
begin
  inherited;
  {***********************************}
  {* NOVA CONSULTA DE FORMA DE PAGTO *}
  {********************************RV*}
  If fPesqFormaPgto(conFpgSimples, Self, edtCodFpg, edtDesFpg, Nil, Key, arrForma) Then
  Begin
    If fValidaCampos(edtCodFpg, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadTiposCliente.dbgTipCndKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    btnCancelaFpg.Click;
    pCarregaCndAlteracao;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    pSetFocus(edtCodCnd);
  End
  Else If (Key = VK_DELETE) Then
  Begin
    If (Not cdsTipCnd.Active) Or
       (cdsTipCnd.IsEmpty)    Then
      Exit;

    cdsTipCnd.Delete;
  End;
end;

procedure TfrmCadTiposCliente.dbgTiposKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    btnCancelaFpg.Click;
    pCarregaFpgAlteracao;

    pSetFocus(edtCodFpg);

  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    pSetFocus(edtCodCnd);
  End
  Else If (Key = VK_DELETE) Then
  Begin

    If (Not cdsConsulta.Active) Or
       (cdsConsulta.IsEmpty)    Then
      Exit;

    cdsConsulta.Delete;
  End;
end;

procedure TfrmCadTiposCliente.btnGravarClick(Sender: TObject);
  Var
    blnGravar: Boolean;
    LCodFPag : String;

  procedure pMensagem;
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar pelo menos uma Condição de Pagamento ou Forma de Pagamento!', ['&Ok']);

    If (pnlCabecalho.Enabled) Then
      pSetFocus(dbeDesTip)
    Else If (edtCodCnd.CanFocus) Then
      pSetFocus(edtCodCnd);

    Exit;
  End;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  if (Not Assigned(cdsConsulta)) And
     (Not Assigned(cdsTipCnd))   Then
  Begin
    pMensagem;
  End;

  If ((Not cdsConsulta.Active) Or
     (cdsConsulta.IsEmpty))    And
     ((Not cdsTipCnd.Active)   Or
     (cdsTipCnd.IsEmpty))      Then
  Begin
    pMensagem;
  End;

  If (fMensagem('', 'Confirma?', ['&Sim', '&Não']) = 2) Then
    Exit;

  If (fCfgSis('USACND') <> 'S') Then
  Begin
    qryTabela.FieldByName('TIP_CNDPAG').AsString := mskCndPag.Text;
    qryTabela.FieldByName('TIP_CODCND').Value    := Null;
  End
  Else
  Begin
    qryTabela.FieldByName('TIP_CNDPAG').Value := Null;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;

    If (Not blnGravou) Then
    Begin
      fRollBack;
      Exit;
    End;

    blnGravou := False;
    blnGravar := True;

    pDeletaFormasTipo(qryTabela.FieldByName('TIP_CODTIP').AsString);

    cdsConsulta.First;
    LCodFPag := '';
    While (Not cdsConsulta.Eof) Do
    Begin
      If Pos(cdsConsulta.FieldByName('TIP_CODFPG').AsString, LCodFPag) = 0 Then
      Begin
        LCodFPag := LCodFPag + ';' + cdsConsulta.FieldByName('TIP_CODFPG').AsString + ';';
        blnGravar := fGravaTipCld(qryTabela.FieldByName('TIP_CODTIP').AsString,
                                  cdsConsulta.FieldByName('TIP_CODFPG').AsString);

        If (Not blnGravar) Then
          Break;
      End;

      cdsConsulta.Next;
    End;

    {***********************************}
    {* GRAVA AS CONDIÇÕES DE PAGAMENTO *}
    {********************************PZ*}
    If (blnGravar) Then
      blnGravar := fGravaTipCnd;

    If (blnGravar) Then
      fCommit
    Else
      fRollBack;

    pnlCabecalho.Enabled := True;
    pHabilitaPnl(False);
    dbgTipos.Enabled     := False;
    dbgTipCnd.Enabled    := False;

    pDeletaTemporaria;
    fCarregaFormasPagamento(dbeCodTip.Text);
    fCarregaCondicaoPagamento(dbeCodTip.Text);
    pnlInfo.Caption := '';

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTiposCliente.btnGravarClick]');
    End;
  End;

end;

procedure TfrmCadTiposCliente.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If (blnUsaProCodigo) Then
    pHabilitaCodigo(dbeCodTip, dbeDesTip, False)
  Else
    pHabilitaCodigo(dbeCodTip, dbeCodTip, True);

  mskCndPag.Clear;
  pDeletaTemporaria;
  fCarregaFormasPagamento('');
  fCarregaCondicaoPagamento('');
end;

procedure TfrmCadTiposCliente.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodTip, dbeDesTip, False);
end;

procedure TfrmCadTiposCliente.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTiposCliente.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  If (blnExcluiu) Then
  Begin
    pDeletaTemporaria;
    blnExcluiu := False;
  End;
end;

procedure TfrmCadTiposCliente.btnCancelaFpgClick(Sender: TObject);
begin
  inherited;
  edtCodFpg.Clear;
  edtDesFpg.Clear;
  edtCodCnd.Clear;
  mskCndPag.Clear;

  If (pnlCndPag.Enabled) And (edtCodCnd.CanFocus) Then
    pSetFocus(edtCodCnd)
  Else If (pnlCndPag.Enabled) And (mskCndPag.CanFocus) Then
    pSetFocus(mskCndPag);

  blnAltCnd := False;
  blnAltFpg := False;
end;

procedure TfrmCadTiposCliente.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrTipo: TConsultasArray;
begin
  {*************************************}
  {* NOVA CONSULTA DE TIPO DE CLIENTES *}
  {**********************************RV*}
  chrKey := '/';
  If fPesqTipoCliente(Self, Nil, Nil, qryTabela, chrKey, arrTipo) Then
  Begin
    fCarregaFormasPagamento(dbeCodTip.Text);
    fCarregaCondicaoPagamento(dbeCodTip.Text);
    pCarregaCadCnd;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadTiposCliente.pCarregaCadCnd;
begin
  If fCfgSis('USACND') = 'S' Then
  Begin
    qryConCnd.SQL.Clear;
    qryConCnd.SQL.Add('SELECT * FROM CADCND WHERE CND_CODIGO = :CODCND');
    qryConCnd.ParamByName('CODCND').AsString := edtCodCnd.Text;
    qryConCnd.Open;
    mskCndPag.Text := qryConCnd.FieldByName('CND_CNDPAG').AsString;
  End
  Else
  Begin
    mskCndPag.Text := qryTabela.FieldByName('TIP_CNDPAG').AsString;
  End;
end;

procedure TfrmCadTiposCliente.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCnd: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE COND. PGTO *}
  {****************************RV*}
  If fPesqCondicoesPgto(Self, edtCodCnd, Nil, Nil, Key, arrCnd) Then
  Begin
    If fValidaCampos(edtCodCnd, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.

