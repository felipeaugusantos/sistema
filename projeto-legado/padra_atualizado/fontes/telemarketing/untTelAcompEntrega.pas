unit untTelAcompEntrega;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Grids, DBGridCitel, DBGrids, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, Mask, MaskEditFocus, EditFocus, Uni, DB, frxClass, frxDBSet,
  BitBtnLockedIncrem, MemDS, DBAccess, frxExportCSVTestabilidade;

type
  TfrmTelAcompEntrega = class(TfrmPai)
    pnlCabecalho: TPanel;
    dbgPedidos: TDBGridCitel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    qryPedidos: TUniQuery;
    dtsPedidos: TDataSource;
    btnHistoricoPed: TBitBtnLocked;
    btnDadosEntrega: TBitBtnLocked;
    Label4: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    btnEnviaEmail: TBitBtnLocked;
    Label5: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure dbgPedidosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDadosEntregaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnHistoricoPedClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnEnviaEmailClick(Sender: TObject);
    procedure qryPedidosAfterScroll(DataSet: TDataSet);
    procedure mskDtaIniExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    qryCadCli: TUniQuery;
    qryCadEmp: TUniQuery;
    procedure pCarregaCliente;
    procedure pCarregaEmpresa;
    procedure pCarregaVendedor;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untPesqAux, untTypesSistema, untFuncoesRel, untFuncoesRel2,
  untTelAcompEntregaEmail, untEnderecoEntrega, untConsultas;

{$R *.dfm}

procedure TfrmTelAcompEntrega.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTelAcompEntrega.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodCli);
end;

procedure TfrmTelAcompEntrega.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadCli := fCriaQuery(Self);
  qryCadEmp := fCriaQuery(Self);

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
end;

function TfrmTelAcompEntrega.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCodCli) Then
  Begin
    If fEmptyStr(edtCodCli.Text) Then
    Begin
      edtNomCli.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaCliente;
      If (qryCadCli.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodEmp) Then
  Begin
    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      edtNomEmp.Text := 'TODAS';
    End
    Else
    Begin
      pCarregaEmpresa;
      If qryCadEmp.IsEmpty Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodVen) Then
  Begin
    If fEmptyStr(edtCodVen.Text) Then
    Begin
      edtNomVen.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaVendedor;
      If fEmptyStr(edtNomVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = mskDtaIni) Then
  Begin
  End

  Else If (Sender = mskDtaFin) Then
  Begin
    If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data final deve ser maior que a data inicial!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmTelAcompEntrega.pCarregaCliente;
begin
  pPesquisaCadCli(Nil, qryCadCli, edtCodCli.Text);
  edtNomCli.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
end;

procedure TfrmTelAcompEntrega.btnAdicionarClick(Sender: TObject);
  Var
    strSQL: String;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FGO_NUMDOC, ';
  strSQL := strSQL + '  FGO_ESPDOC, ';  
  strSQL := strSQL + '  CONCAT(FGO_DTAENT, " - ", FGO_HORENT) AS FGO_DTAENT, ';
  strSQL := strSQL + '  FGO_NUMFAT, ';
  strSQL := strSQL + '  FGO_TIPFAT, ';
  strSQL := strSQL + '  FGO_CODEMP, ';
  strSQL := strSQL + '  FGO_EMPFAT, ';
  strSQL := strSQL + '  CONCAT(FGO_DTAFAT, " - ", M.GER_HORENT) AS FGO_DTAFAT, ';
  strSQL := strSQL + '  FGO_CODCLI, ';
  strSQL := strSQL + '  IF(FGO_NOMCON = "" OR FGO_NOMCON IS NULL, CLI_NOMCLI, FGO_NOMCON) AS FGO_NOMCLI, ';
  strSQL := strSQL + '  FGO_CODEMP, ';
  strSQL := strSQL + '  EMP_NOMEMP  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATGOR ';
  strSQL := strSQL + 'JOIN CADCLI ON FGO_CODCLI = CLI_CODCLI ';

  strSQL := strSQL + 'LEFT JOIN MOVGER M ON M.GER_NUMDOC = FGO_NUMFAT AND ';
  strSQL := strSQL + '                      M.GER_ESPDOC = FGO_TIPFAT AND ';
  strSQL := strSQL + '                      M.GER_CODEMP = FGO_EMPFAT AND ';
  strSQL := strSQL + '                      M.GER_CODCLI = FGO_CODCLI ';

  strSQL := strSQL + 'LEFT JOIN CADEMP ON FGO_CODEMP = EMP_CODEMP ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FGO_ESPDOC <> "PR" ';

  If (Not fEmptyStr(edtCodCli.Text)) Then
  Begin
    strSQL := strSQL + '  AND FGO_CODCLI = :CODCLI ';
  End;

  If (Not fEmptyStr(edtCodEmp.Text)) Then
  Begin
    strSQL := strSQL + '  AND FGO_CODEMP = :CODEMP ';
  End;

  If (Not fEmptyStr(edtCodVen.Text)) Then
  Begin
    strSQL := strSQL + '  AND FGO_CODVEN = :CODVEN ';
  End;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
  Begin
    strSQL := strSQL + '  AND FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  End;

  strSQL := strSQL + '  ORDER BY FGO_DTAENT, FGO_HORENT, FGO_DTAFAT ';

  qryPedidos.Close;
  qryPedidos.SQL.Clear;
  qryPedidos.SQL.Add(strSQL);
  If (Not fEmptyStr(edtCodCli.Text)) Then
  Begin
    qryPedidos.ParamByName('CODCLI').AsString := edtCodCli.Text;
  End;

  If (Not fEmptyStr(edtCodEmp.Text)) Then
  Begin
    qryPedidos.ParamByName('CODEMP').AsString := edtCodEmp.Text;
  End;

  If (Not fEmptyStr(edtCodVen.Text)) Then
  Begin
    qryPedidos.ParamByName('CODVEN').AsString := edtCodVen.Text;
  End;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
  Begin
    qryPedidos.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    qryPedidos.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
  End;
  
  qryPedidos.Open;
  qryPedidos.FieldByName('FGO_NUMDOC').DisplayWidth := 115;
  qryPedidos.FieldByName('FGO_DTAENT').DisplayWidth := 130;
  qryPedidos.FieldByName('FGO_NUMFAT').DisplayWidth := 115;
  qryPedidos.FieldByName('FGO_TIPFAT').DisplayWidth := 050;
  qryPedidos.FieldByName('FGO_CODEMP').DisplayWidth := 050;
  qryPedidos.FieldByName('FGO_EMPFAT').DisplayWidth := 050;
  qryPedidos.FieldByName('FGO_DTAFAT').DisplayWidth := 090;

  pSetFocus(dbgPedidos);
end;

procedure TfrmTelAcompEntrega.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  qryPedidos.Close;
  qryCadCli.Close;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  pSetFocus(edtCodCli);
end;

procedure TfrmTelAcompEntrega.dbgPedidosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
  Begin
    btnCancelaItem.Click;
  End
  Else If Key = VK_RETURN Then
  Begin
    btnHistoricoPed.Click;
  End;
end;

procedure TfrmTelAcompEntrega.btnDadosEntregaClick(Sender: TObject);
  Var
    objEndEnt: TEnderecoEntrega;
begin
  inherited;
  {
  Try
    pCriarFormularios(TfrmTelDadosEntrega, frmTelDadosEntrega);
    frmTelDadosEntrega.edtCodCli.Text := edtCodCli.Text;
    frmTelDadosEntrega.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmTelAcompEntrega.btnDadosEntregaClick]');
    End;
  End;

  pFreeAndNil(frmTelDadosEntrega);
  }

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    objEndEnt := TEnderecoEntrega.Create(Self);
    objEndEnt.fAlteraEnderecoEntrega(True, edtCodCli.Text, True);
    FreeAndNil(objEndEnt);
  End;
end;

procedure TfrmTelAcompEntrega.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F2) And (qryPedidos.Active) Then
  Begin
    btnDadosEntrega.Click;
  End;

  If (Key = VK_F9) And (qryPedidos.Active) Then
  Begin
    btnEnviaEmail.Click;
  End;

end;

procedure TfrmTelAcompEntrega.btnHistoricoPedClick(Sender: TObject);
begin
  inherited;

  If (Not qryPedidos.Active) Or (qryPedidos.IsEmpty) Then
  Begin
    Exit;
  End;

  If fEmptyStr(qryPedidos.FieldByName('FGO_NUMFAT').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse pedido ainda não foi faturado!', ['&Ok']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(70, 5190, [],
                        ['NUMDOC','CODEMP'],
                        [qryPedidos.FieldByName('FGO_NUMDOC').AsString,
                        qryPedidos.FieldByName('FGO_CODEMP').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmTelAcompEntrega.pCarregaEmpresa;
begin
  pPesquisaCadEmp(Nil, qryCadEmp, edtCodEmp.Text);
  edtNomEmp.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmTelAcompEntrega.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTelAcompEntrega.btnEnviaEmailClick(Sender: TObject);
begin
  inherited;

  pEnviaEmail(qryPedidos.FieldByName('FGO_NUMDOC').AsString,
              qryPedidos.FieldByName('FGO_ESPDOC').AsString,
              qryPedidos.FieldByName('FGO_CODEMP').AsString,
              qryPedidos.FieldByName('FGO_NUMFAT').AsString,
              qryPedidos.FieldByName('FGO_TIPFAT').AsString,
              qryPedidos.FieldByName('FGO_EMPFAT').AsString,
              qryPedidos.FieldByName('FGO_CODCLI').AsString,              
              Handle);
              
end;

procedure TfrmTelAcompEntrega.qryPedidosAfterScroll(DataSet: TDataSet);
begin
  inherited;

  edtCodCli.Text := qryPedidos.FieldByName('FGO_CODCLI').AsString;
  edtNomCli.Text := qryPedidos.FieldByName('FGO_NOMCLI').AsString;
  edtCodEmp.Text := qryPedidos.FieldByName('FGO_CODEMP').AsString;
  edtNomEmp.Text := qryPedidos.FieldByName('EMP_NOMEMP').AsString;

end;

procedure TfrmTelAcompEntrega.mskDtaIniExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    mskDtaFin.Clear;
    mskDtaFin.Enabled := False;
    pSetFocus(btnAdicionar);
  End
  Else
  Begin
    mskDtaFin.Enabled := True;
    pSetFocus(mskDtaFin);
  End;
end;

procedure TfrmTelAcompEntrega.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryConOpe: TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    qryConOpe := fCriaQuery(Self);

    if fPesqOperador(Self, edtCodVen, edtNomVen, qryConOpe, Key, arrSel) then
    Begin
      If (fValidaCampos(edtCodVen, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    FreeAndNil(qryConOpe);
  End;
end;

procedure TfrmTelAcompEntrega.pCarregaVendedor;
begin
  edtNomVen.Text := fRetNomeOperador(edtCodVen.Text);
end;

end.
