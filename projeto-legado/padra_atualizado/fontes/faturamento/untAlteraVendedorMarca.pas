unit untAlteraVendedorMarca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, QColorLabel,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, untTypesSistema,
  Uni, UniClientDataSet, cxProgressBar;

type
  TfrmAlteraVendedorMarca = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label19: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label3: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    lbl1: TLabel;
    edtCodReg: TEditFocus;
    edtNomReg: TEditFocus;
    Label4: TLabel;
    rdbCadastro: TRadioButton;
    rdbUtlVnd: TRadioButton;
    mskDtaIni: TMaskEditFocus;
    Label6: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label2: TLabel;
    edtCodVenAtual: TEditFocus;
    edtNomVenAtual: TEditFocus;
    ColorLabel1: TColorLabel;
    Label1: TLabel;
    edtStatus: TEditFocus;
    Label58: TLabel;
    edtDesRed: TEditFocus;
    lbl12: TLabel;
    edtDesSub: TEditFocus;
    Label40: TLabel;
    edtDesAti: TEditFocus;
    Label5: TLabel;
    edtCodRed: TEditFocus;
    edtCodAti: TEditFocus;
    edtCodSub: TEditFocus;
    Label11: TLabel;
    edtMarcaAtual: TEditFocus;
    edtDesMarcaAtual: TEditFocus;
    Panel1: TPanel;
    Label7: TLabel;
    rdbIncluir: TRadioButton;
    rdbExcluir: TRadioButton;
    Label8: TLabel;
    lblVendedor: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    lblMarca: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    btnCarregar: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    grdDadosTv: TcxGridDBTableViewCitel;
    grdDadosLvl: TcxGridLevel;
    grdDados: TcxGridCitel;
    Label12: TLabel;
    edtEstado: TEditFocus;
    edtDesEstado: TEditFocus;
    dsDados: TDataSource;
    grdDadosTvCODCLI: TcxGridDBColumn;
    grdDadosTvNOMCLI: TcxGridDBColumn;
    grdDadosTvCODOPE: TcxGridDBColumn;
    grdDadosTvNOMOPE: TcxGridDBColumn;
    grdDadosTvCODMAR: TcxGridDBColumn;
    grdDadosTvDESMAR: TcxGridDBColumn;
    grdDadosTvOPERAC: TcxGridDBColumn;
    btnImportarPlanilha: TBitBtnLocked;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtEstadoExit(Sender: TObject);
    procedure edtEstadoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodSubKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSubExit(Sender: TObject);
    procedure edtCodVenAtualKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenAtualExit(Sender: TObject);
    procedure edtMarcaAtualKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaAtualExit(Sender: TObject);
    procedure rdbIncluirClick(Sender: TObject);
    procedure rdbExcluirClick(Sender: TObject);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure btnCarregarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdDadosTvCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnImportarPlanilhaClick(Sender: TObject);
  private
    { Private declarations }
    FArrCliente,
    FArrRede,
    FArrAtividade,
    FArrCidade,
    FArrEstado,
    FArrRegiao,
    FArrSubReg,
    FArrVendedAtual,
    FArrMarcaAtual,
    FArrVended,
    FArrMarca: TConsultasArray;

    FCdsDados: TUniClientDataSet;
    FQryConsulta: TUniQuery;

    procedure pCarregar;
    procedure pConfiguraClientDataSet;
    function fMontaClientDataSet(pgbProgresso: TcxProgressBar): Boolean;
    function fRegistroExiste(const ACodCli, ACodOpe, ACodMar: String): Boolean;
    procedure pVerificaVenMar;
    procedure pIncluirDado(const AIdxVen, AIdxMar: Integer; const AOperacao: String);

    procedure pVerificaIncluir(AIdxVen, AIdxMar: Integer);
    procedure pVerificaExcluir(AIdxVen, AIdxMar: Integer);

    function fConfirmar(pgbProgresso: TcxProgressBar): Boolean;

    procedure pLimpaTela;

    function fWhereCodVen: String;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
  end;

const
  OP_INCLUIR = 'Incluir';
  OP_EXCLUIR = 'Excluir';

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untConsultas, untFuncoesConsulta, StrUtils,
  untImportarPlanilhaVendedorMarca;

procedure TfrmAlteraVendedorMarca.btnCarregarClick(Sender: TObject);
begin
  inherited;
  if not fVerificaCampos then
    Exit;

  pVerificaVenMar;

  pCarregar;
end;

procedure TfrmAlteraVendedorMarca.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('ATENÇÃO!', 'Deseja realmente confirmar a operação?', ['&Sim', '&Não'],2) <> 1 then
    Exit;

  fChamaTelaGravando(fConfirmar);
end;

procedure TfrmAlteraVendedorMarca.btnImportarPlanilhaClick(Sender: TObject);
  Var
    frmImportarPlanilhaVendedorMarca : TfrmImportarPlanilhaVendedorMarca;
begin
  inherited;

  pCriarFormularios(TfrmImportarPlanilhaVendedorMarca, frmImportarPlanilhaVendedorMarca);
  Try
    frmImportarPlanilhaVendedorMarca.ShowModal;
  Finally
    pFreeAndNil(frmImportarPlanilhaVendedorMarca);
  End;
end;

procedure TfrmAlteraVendedorMarca.btnSairClick(Sender: TObject);
begin
  if fMensagem('ATENÇÃO!', 'Deseja realmente cancelar a operação?', ['&Sim', '&Não'],2) <> 1 then
    Exit;

  inherited;
end;

procedure TfrmAlteraVendedorMarca.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtDesAti, FArrAtividade, Nil, fRetNomAtividade, 'da atividade');
end;

procedure TfrmAlteraVendedorMarca.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, FArrAtividade, False) Then
    if fValidaCampos(edtCodAti, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAlteraVendedorMarca.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtNomCid, FArrCidade, fRetNomCidadeSemOpc, Nil, 'da Cidade');
end;

procedure TfrmAlteraVendedorMarca.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtNomCid, Nil, Nil, Key, FArrCidade, False) Then
    if fValidaCampos(edtCodCid, False) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAlteraVendedorMarca.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCliente, edtDesCliente, FArrCliente, Nil, fRetNomCliente, 'do cliente');
end;

procedure TfrmAlteraVendedorMarca.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, FArrCliente, False) Then
    if fValidaCampos(edtCodCliente, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAlteraVendedorMarca.edtCodRedExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRed, edtDesRed, FArrRede, fRetNomeRedeLojaSelect, Nil, 'da rede de lojas');
end;

procedure TfrmAlteraVendedorMarca.edtCodRedKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, FArrRede, False) Then
    if fValidaCampos(edtCodRed, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAlteraVendedorMarca.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg, edtNomReg, FArrRegiao, Nil, fRetNomRegiao, 'da Região');
end;

procedure TfrmAlteraVendedorMarca.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRegiao(Self, edtCodReg, edtNomReg, Nil, Key, FArrRegiao, False) Then
    if fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAlteraVendedorMarca.edtCodSubExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSub, edtDesSub, FArrSubReg, Nil, fRetNomSubRegiao, 'da sub-região');
end;

procedure TfrmAlteraVendedorMarca.edtCodSubKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqSubRegiao(Self, edtCodSub, edtDesSub, Nil, Key, FArrSubReg, False) Then
    If fValidaCampos(edtCodSub, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAlteraVendedorMarca.edtCodVenAtualExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVenAtual, edtNomVenAtual, FArrVendedAtual, fRetNomeOperador, Nil, 'do vendedor');
end;

procedure TfrmAlteraVendedorMarca.edtCodVenAtualKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVenAtual, edtNomVenAtual, Nil, Key, FArrVendedAtual, False) then
    If fValidaCampos(edtCodVenAtual, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAlteraVendedorMarca.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtNomVen, FArrVended, fRetNomeOperador, Nil, 'do vendedor');
end;

procedure TfrmAlteraVendedorMarca.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, FArrVended, False) then
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAlteraVendedorMarca.edtEstadoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtEstado, edtDesEstado, FArrEstado, fRetNomeEstado, Nil, 'do estado');
end;

procedure TfrmAlteraVendedorMarca.edtEstadoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEstado(Self, edtEstado, edtDesEstado, Nil, Key, FArrEstado, False) Then
    if fValidaCampos(edtEstado, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAlteraVendedorMarca.edtMarcaAtualExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarcaAtual, edtDesMarcaAtual, FArrMarcaAtual, fRetNomMarca, Nil, 'da marca');
end;

procedure TfrmAlteraVendedorMarca.edtMarcaAtualKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarcaAtual, edtDesMarcaAtual, Nil, Key, FArrMarcaAtual, False) Then
    If fValidaCampos(edtMarcaAtual, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmAlteraVendedorMarca.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca, edtDesMarca, FArrMarca, fRetNomMarca, Nil, 'da marca');
end;

procedure TfrmAlteraVendedorMarca.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, FArrMarca, False) Then
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
end;

function TfrmAlteraVendedorMarca.fConfirmar(
  pgbProgresso: TcxProgressBar): Boolean;
var
  LQryUpdate: TUniQuery;
  LQryLog: TUniQuery;
begin
  pInfoStatusGravacao(pgbProgresso, 'Aguarde... Alterando registros...', FCdsDados.RecordCount);

  FCdsDados.DisableControls;
  LQryUpdate := fCriaQuery;
  LQryLog := fCriaQuery;
  try
    FCdsDados.First;

    if FCdsDados.FieldByName('OPERAC').AsString = OP_INCLUIR then
    begin
      LQryUpdate.SQL.Add('INSERT INTO CLIVEN(AUTOINCREM, CVE_CODCLI, CVE_CODMAR, CVE_CODVEN)');
      LQryUpdate.SQL.Add('VALUES (:AUTINC, :CODCLI, :CODMAR, :CODVEN)');
    end
    else
    if FCdsDados.FieldByName('OPERAC').AsString = OP_EXCLUIR then
    begin
      LQryUpdate.SQL.Add('DELETE FROM CLIVEN');
      LQryUpdate.SQL.Add('WHERE CVE_CODCLI = :CODCLI');
      LQryUpdate.SQL.Add('  AND CVE_CODMAR = :CODMAR');
      LQryUpdate.SQL.Add('  AND CVE_CODVEN = :CODVEN');
    end;

    LQryLog.SQL.Add('INSERT INTO LOGVMC(AUTOINCREM, LOG_DTAALT, LOG_HORALT, LOG_CODOPE, LOG_CODCLI, LOG_CODVEN, LOG_CODMAR, LOG_OPERAC)');
    LQryLog.SQL.Add('VALUES (:AUTINC, :DTAALT, :HORALT, :CODOPE, :CODCLI, :CODVEN, :CODMAR, :OPERAC)');

    fStartTransaction;
    try

      while not FCdsDados.Eof do
      begin
        if FCdsDados.FieldByName('OPERAC').AsString = OP_INCLUIR then
           LQryUpdate.ParamByName('AUTINC').AsString := fRetAutoIncrem('CLIVEN', VS_strCodEmp);

        LQryUpdate.ParamByName('CODCLI').AsString := FCdsDados.FieldByName('CODCLI').AsString;
        LQryUpdate.ParamByName('CODMAR').AsString := FCdsDados.FieldByName('CODMAR').AsString;
        LQryUpdate.ParamByName('CODVEN').AsString := FCdsDados.FieldByName('CODOPE').AsString;
        LQryUpdate.ExecSQL;

        LQryLog.ParamByName('AUTINC').AsString := fRetAutoIncrem('LOGVMC', VS_strCodEmp);
        LQryLog.ParamByName('DTAALT').AsDateTime := fNow;
        LQryLog.ParamByName('HORALT').AsDateTime := fNow;
        LQryLog.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
        LQryLog.ParamByName('CODCLI').AsString := FCdsDados.FieldByName('CODCLI').AsString;
        LQryLog.ParamByName('CODVEN').AsString := FCdsDados.FieldByName('CODOPE').AsString;
        LQryLog.ParamByName('CODMAR').AsString := FCdsDados.FieldByName('CODMAR').AsString;
        LQryLog.ParamByName('OPERAC').AsString := FCdsDados.FieldByName('OPERAC').AsString[1];
        LQryLog.ExecSQL;

        FCdsDados.Next;
        pStepStatusGravacao(pgbProgresso);
      end;

      fMensagem('', 'Cadastros atualizados com sucesso!', ['&O k']);
      fCommit;
      Result := True;

      pLimpaTela;
    except
      on E: Exception do
      begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message,'[TfrmAlteraVendedorMarca.fConfirmar]');
      end;
    end;

  finally
    FreeAndNil(LQryLog);
    FreeAndNil(LQryUpdate);
    FCdsDados.First;
    FCdsDados.EnableControls;
  end;
end;

function TfrmAlteraVendedorMarca.fMontaClientDataSet(
  pgbProgresso: TcxProgressBar): Boolean;
var
  LIdxVen: Integer;
  LIdxMar: Integer;
begin
  Result := True;
  pInfoStatusGravacao(pgbProgresso, 'Aguarde... Carregando registros para alteração...', FQryConsulta.RecordCount);

  FCdsDados.DisableControls;
  try
    FCdsDados.EmptyDataSet;

    FQryConsulta.First;
    while not FQryConsulta.Eof do
    begin
      for LIdxVen := Low(FArrVended) to High(FArrVended) do
      begin
        for LIdxMar := Low(FArrMarca) to High(FArrMarca) do
        begin
          if rdbIncluir.Checked then
            pVerificaIncluir(LIdxVen, LIdxMar)
          else
          if rdbExcluir.Checked then
            pVerificaExcluir(LIdxVen, LIdxMar);
        end;
      end;

      FQryConsulta.Next;
      pStepStatusGravacao(pgbProgresso);
    end;
  finally
    FCdsDados.First;
    FCdsDados.EnableControls;
  end;
end;

procedure TfrmAlteraVendedorMarca.FormCreate(Sender: TObject);
begin
  inherited;
  FQryConsulta := fCriaQuery;

  FCdsDados := TUniClientDataSet.Create(Nil);
  dsDados.DataSet := FCdsDados;

  pConfiguraClientDataSet;
end;

procedure TfrmAlteraVendedorMarca.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FQryConsulta);
  FreeAndNil(FCdsDados);
end;

procedure TfrmAlteraVendedorMarca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F8: btnCarregar.Click;
    VK_F10: btnConfirmar.Click;
  end;
end;

function TfrmAlteraVendedorMarca.fRegistroExiste(const ACodCli, ACodOpe,
  ACodMar: String): Boolean;
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;
  try
    LQry.SQL.Add('SELECT AUTOINCREM');
    LQry.SQL.Add('FROM CLIVEN');
    LQry.SQL.Add('WHERE CVE_CODCLI = :CODCLI');
    LQry.SQL.Add('  AND CVE_CODVEN = :CODVEN');
    LQry.SQL.Add('  AND CVE_CODMAR = :CODMAR');

    LQry.ParamByName('CODCLI').AsString := ACodCli;
    LQry.ParamByName('CODVEN').AsString := ACodOpe;
    LQry.ParamByName('CODMAR').AsString := ACodMar;

    LQry.Open;

    Result := not LQry.IsEmpty;
  finally
    FreeAndNil(LQry);
  end;
end;

function TfrmAlteraVendedorMarca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtStatus) Then
  Begin
    If fEmptyStr(edtStatus.Text) Then
      edtStatus.Text := 'T'
    Else If (not AnsiMatchStr(edtStatus.Text, ['A', 'I', 'T'])) Then
      Result := False
  End

  Else If (Sender = mskDtaIni) Then
  Begin

    If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      mskDtaFin.Enabled := False
    Else
      mskDtaFin.Enabled := True;

  End

  Else If (Sender = mskDtaFin) Then
  Begin

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
          Result := False;
        End;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmAlteraVendedorMarca.fWhereCodVen: String;
var
  LWhere: String;
begin
  Result := '';

  LWhere := '';
  LWhere := LWhere + fStrLocate(edtCodVenAtual, FArrVendedAtual, 'CVE_CODVEN', 'CODVEN', True);
  if not fEmptyStr(edtCodVenAtual.Text) then
    LWhere := LWhere + '   OR CLI_CODVEN = :CODVEN2';

  if not fEmptyStr(LWhere) then
    Result := ' AND ( ' + LWhere + ' ) ';
end;

procedure TfrmAlteraVendedorMarca.grdDadosTvCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDadosTvOPERAC.Index] = OP_INCLUIR) Then
    ACanvas.Font.Color := clGreen
  Else
    ACanvas.Font.Color := clRed;
end;

procedure TfrmAlteraVendedorMarca.pCarregar;
var
  LSelect: String;
  LLinhaTemp: String;
begin
  LSelect := LSelect + '';
  LSelect := LSelect + ' SELECT CLI_CODCLI, CLI_NOMCLI ';
  LSelect := LSelect + ' FROM CADCLI';
  LSelect := LSelect + ' LEFT JOIN CLIVEN ON CLI_CODCLI = CVE_CODCLI';
  LSelect := LSelect + ' LEFT JOIN CADCID ON CLI_CODCID = CID_CODCID';
  LSelect := LSelect + ' WHERE TRUE';
  if edtStatus.Text <> 'T' then
    LSelect := LSelect + '   AND CLI_STATUS = :STATUS';

  LSelect := LSelect + fStrLocate(edtCodCliente, FArrCliente, 'CLI_CODCLI', 'CODCLI');
  LSelect := LSelect + fStrLocate(edtCodRed, FArrRede, 'CLI_CODRED', 'CODRED');
  LSelect := LSelect + fStrLocate(edtCodAti, FArrAtividade, 'CLI_CODATI', 'CODATI');
  LSelect := LSelect + fStrLocate(edtCodCid, FArrCidade, 'CLI_CODCID', 'CODCID');
  LSelect := LSelect + fStrLocate(edtEstado, FArrEstado, 'CID_ESTADO', 'ESTADO');
  LSelect := LSelect + fStrLocate(edtCodReg, FArrRegiao, 'CLI_CODREG', 'CODREG');
  LSelect := LSelect + fStrLocate(edtCodSub, FArrSubReg, 'CLI_CODSUB', 'CODSUB');

  if Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) then
  begin
    if rdbCadastro.Checked then
      LSelect := LSelect + '   AND CLI_DTACAD BETWEEN :DTAINI AND :DTAFIM';
    if rdbUtlVnd.Checked then
      LSelect := LSelect + '   AND CLI_ULTCOM BETWEEN :DTAINI AND :DTAFIM';
  end;

  LSelect := LSelect + fWhereCodVen;

  LSelect := LSelect + fStrLocate(edtMarcaAtual, FArrMarcaAtual, 'CVE_CODMAR', 'CODMAR');
  LSelect := LSelect + ' GROUP BY CLI_CODCLI';

  FQryConsulta.Close;
  FQryConsulta.SQL.Text := LSelect;

  if edtStatus.Text <> 'T' then
    FQryConsulta.ParamByName('STATUS').AsString := edtStatus.Text;

  pSetaParam(edtCodCliente.Text, FArrCliente, LLinhaTemp, 'CODCLI', FQryConsulta);
  pSetaParam(edtCodAti.Text, FArrAtividade, LLinhaTemp, 'CODATI', FQryConsulta);
  pSetaParam(edtCodRed.Text, FArrRede, LLinhaTemp, 'CODRED', FQryConsulta);
  pSetaParam(edtCodCid.Text, FArrCidade, LLinhaTemp, 'CODCID', FQryConsulta);
  pSetaParam(edtEstado.Text, FArrEstado, LLinhaTemp, 'ESTADO', FQryConsulta);
  pSetaParam(edtCodReg.Text, FArrRegiao, LLinhaTemp, 'CODREG', FQryConsulta);
  pSetaParam(edtCodSub.Text, FArrSubReg, LLinhaTemp, 'CODSUB', FQryConsulta);

  if Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) then
  begin
    FQryConsulta.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    FQryConsulta.ParamByName('DTAFIM').AsDateTime := StrToDate(mskDtaFin.Text);
  end;

  pSetaParam(edtCodVenAtual.Text, FArrVendedAtual, LLinhaTemp, 'CODVEN', FQryConsulta);
  if not fEmptyStr(edtCodVenAtual.Text) then
    FQryConsulta.ParamByName('CODVEN2').AsString := edtCodVenAtual.Text;

  pSetaParam(edtMarcaAtual.Text, FArrMarcaAtual, LLinhaTemp, 'CODMAR', FQryConsulta);

  FQryConsulta.Open;

  fChamaTelaGravando(fMontaClientDataSet);
end;

procedure TfrmAlteraVendedorMarca.pConfiguraClientDataSet;
var
  Field: TFieldDef;
begin
  Field := FCdsDados.FieldDefs.AddFieldDef;
  Field.Name     := 'CODCLI';
  Field.DataType := ftString;
  Field.Size     := 8;

  Field := FCdsDados.FieldDefs.AddFieldDef;
  Field.Name     := 'NOMCLI';
  Field.DataType := ftString;
  Field.Size     := 60;

  Field := FCdsDados.FieldDefs.AddFieldDef;
  Field.Name     := 'CODOPE';
  Field.DataType := ftString;
  Field.Size     := 3;

  Field := FCdsDados.FieldDefs.AddFieldDef;
  Field.Name     := 'NOMOPE';
  Field.DataType := ftString;
  Field.Size     := 30;

  Field := FCdsDados.FieldDefs.AddFieldDef;
  Field.Name     := 'CODMAR';
  Field.DataType := ftString;
  Field.Size     := 6;

  Field := FCdsDados.FieldDefs.AddFieldDef;
  Field.Name     := 'DESMAR';
  Field.DataType := ftString;
  Field.Size     := 30;

  Field := FCdsDados.FieldDefs.AddFieldDef;
  Field.Name     := 'OPERAC';
  Field.DataType := ftString;
  Field.Size     := 7;

  FCdsDados.CreateDataSet;
  FCdsDados.Open;
end;

procedure TfrmAlteraVendedorMarca.pEscapePressed;
begin
  inherited;
  btnSair.Click;
end;

procedure TfrmAlteraVendedorMarca.pIncluirDado(const AIdxVen, AIdxMar: Integer;
  const AOperacao: String);
begin
  FCdsDados.Append;
  FCdsDados.FieldByName('CODCLI').AsString := FQryConsulta.FieldByName('CLI_CODCLI').AsString;
  FCdsDados.FieldByName('NOMCLI').AsString := FQryConsulta.FieldByName('CLI_NOMCLI').AsString;
  FCdsDados.FieldByName('CODOPE').AsString := FArrVended[AIdxVen].strCodigo;
  if fEmptyStr(FArrVended[AIdxVen].strDescri) then
    FCdsDados.FieldByName('NOMOPE').AsString := fRetNomeOperador(FArrVended[AIdxVen].strCodigo)
  else
    FCdsDados.FieldByName('NOMOPE').AsString := FArrVended[AIdxVen].strDescri;

  FCdsDados.FieldByName('CODMAR').AsString := FArrMarca[AIdxMar].strCodigo;
  if fEmptyStr(FArrMarca[AIdxMar].strDescri) then
    FCdsDados.FieldByName('DESMAR').AsString := fRetNomMarca(FArrMarca[AIdxMar].strCodigo)
  else
    FCdsDados.FieldByName('DESMAR').AsString := FArrMarca[AIdxMar].strDescri;

  FCdsDados.FieldByName('OPERAC').AsString := AOperacao;
  FCdsDados.Post;
end;

procedure TfrmAlteraVendedorMarca.pLimpaTela;
begin
  FCdsDados.EmptyDataSet;

  edtCodCliente.Clear;
  edtDesCliente.Clear;

  edtStatus.Clear;

  edtCodRed.Clear;
  edtDesRed.Clear;

  edtCodAti.Clear;
  edtDesAti.Clear;

  edtCodCid.Clear;
  edtNomCid.Clear;

  edtEstado.Clear;
  edtDesEstado.Clear;

  edtCodReg.Clear;
  edtNomReg.Clear;

  edtCodSub.Clear;
  edtDesSub.Clear;

  mskDtaIni.Clear;
  mskDtaFin.Clear;

  rdbCadastro.Checked := True;

  edtCodVenAtual.Clear;
  edtNomVenAtual.Clear;

  edtMarcaAtual.Clear;
  edtDesMarcaAtual.Clear;

  rdbIncluir.Checked := True;

  edtCodVen.Clear;
  edtNomVen.Clear;

  edtMarca.Clear;
  edtDesMarca.Clear;

  pSetFocus(edtCodCliente);
end;

procedure TfrmAlteraVendedorMarca.pVerificaExcluir(AIdxVen, AIdxMar: Integer);
begin
  if fRegistroExiste(FQryConsulta.FieldByName('CLI_CODCLI').AsString,
                     FArrVended[AIdxVen].strCodigo,
                     FArrMarca[AIdxMar].strCodigo) then
    pIncluirDado(AIdxVen, AIdxMar, OP_EXCLUIR);
end;

procedure TfrmAlteraVendedorMarca.pVerificaIncluir(AIdxVen, AIdxMar: Integer);
begin
  if not fRegistroExiste(FQryConsulta.FieldByName('CLI_CODCLI').AsString,
                         FArrVended[AIdxVen].strCodigo,
                         FArrMarca[AIdxMar].strCodigo) then
    pIncluirDado(AIdxVen, AIdxMar, OP_INCLUIR);
end;

procedure TfrmAlteraVendedorMarca.pVerificaVenMar;
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;
  try

    if fEmptyStr(edtCodVen.Text) then
    begin
      LQry.Close;
      LQry.SQL.Clear;
      LQry.SQL.Add('SELECT OPE_CODOPE, OPE_NOMOPE');
      LQry.SQL.Add('  FROM CADOPE');
      LQry.SQL.Add(' WHERE OPE_STATUS = "A"');

      LQry.Open;
      SetLength(FArrVended, LQry.RecordCount);
      while not LQry.Eof do
      begin
        FArrVended[LQry.RecNo-1].strCodigo := LQry.FieldByName('OPE_CODOPE').AsString;
        FArrVended[LQry.RecNo-1].strDescri := LQry.FieldByName('OPE_NOMOPE').AsString;

        LQry.Next;
      end;
    end;

    if fEmptyStr(edtMarca.Text) then
    begin
      LQry.Close;
      LQry.SQL.Clear;
      LQry.SQL.Add('SELECT MAR_CODMAR, MAR_DESMAR');
      LQry.SQL.Add('  FROM CADMAR ');

      LQry.Open;
      SetLength(FArrMarca, LQry.RecordCount);
      while not LQry.Eof do
      begin
        FArrMarca[LQry.RecNo-1].strCodigo := LQry.FieldByName('MAR_CODMAR').AsString;
        FArrMarca[LQry.RecNo-1].strDescri := LQry.FieldByName('MAR_DESMAR').AsString;

        LQry.Next;
      end;
    end;

  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmAlteraVendedorMarca.rdbExcluirClick(Sender: TObject);
begin
  inherited;
  lblVendedor.Caption := 'Vendedor a excluir:';
  lblMarca.Caption := 'Marca a excluir:';
end;

procedure TfrmAlteraVendedorMarca.rdbIncluirClick(Sender: TObject);
begin
  inherited;
  lblVendedor.Caption := 'Vendedor a incluir:';
  lblMarca.Caption := 'Marca a incluir:';
end;

end.
