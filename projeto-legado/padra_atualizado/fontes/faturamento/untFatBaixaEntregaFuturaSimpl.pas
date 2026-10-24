unit untFatBaixaEntregaFuturaSimpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, frxClass, Uni, System.UITypes,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  ComboBoxFocus, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel, untTypesSistema,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess;

type
  TfrmFatBaixaEntregaFuturaSimpl = class(TfrmPaiOrdena)
    gpbMotivo: TGroupBox;
    lblCliBus: TLabel;
    chkFalta: TCheckBox;
    chkPrevisao: TCheckBox;
    cmbCliBus: TComboBoxFocus;
    chkAguarda: TCheckBox;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label3: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblDocFat: TLabel;
    edtDocFat: TEditFocus;
    edtEspFat: TEditFocus;
    lblEspFat: TLabel;
    lbl2: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    Label1: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label4: TLabel;
    edtCodCidade: TEditFocus;
    edtDesCidade: TEditFocus;
    edtEstado: TEditFocus;
    btnConsulta: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    shpSepImpLegenda: TShape;
    lblSepImpLegenda: TLabel;
    btnEnderecosEntrega: TBitBtnLocked;
    lblRegiao: TLabel;
    edtCodRegiao: TEditFocus;
    edtNomeRegiao: TEditFocus;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsultaClick(Sender: TObject);
    procedure dbgConsultaDblClick(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtCodRegiaoKeyPress(Sender: TObject; var Key: Char);
    procedure btnEnderecosEntregaClick(Sender: TObject);
  private
    { Private declarations }
    procedure pAbreConsulta;
    function fTemAlgumFiltroPreenchido: Boolean;
  public
    { Public declarations }
    blnPrimeiraVez: Boolean;
    blnSepFut: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untTFatBaixaEntregaFutura,
  untEnderecosEntregaBaixaEntregaFutura;

{$R *.dfm}

procedure TfrmFatBaixaEntregaFuturaSimpl.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If cdsConsulta.IsEmpty Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  ModalResult := mrOk;
end;

procedure TfrmFatBaixaEntregaFuturaSimpl.btnConsultaClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  fExecutarModal(pAbreConsulta, 'Aguarde... Carregando documentos.', '');
end;

procedure TfrmFatBaixaEntregaFuturaSimpl.btnEnderecosEntregaClick(
  Sender: TObject);
var
  frmEnderecosEntregaBaixaEntregaFutura: TfrmEnderecosEntregaBaixaEntregaFutura;
begin
  inherited;
  If (Not cdsConsulta.Active) Or
     (cdsConsulta.RecordCount = 0) Then
  Begin
    pMensagemOk('É necessário que selecione algum registro de Baixa de Entrega Futura.');
    Exit;
  End;

  pCriarFormularios(TfrmEnderecosEntregaBaixaEntregaFutura, frmEnderecosEntregaBaixaEntregaFutura);
  Try
    frmEnderecosEntregaBaixaEntregaFutura.pCarregaDados(
      cdsConsulta.FieldByName('DET_DTAFUT').AsDateTime,
      cdsConsulta.FieldByName('DET_CODCLI').AsString,
      cdsConsulta.FieldByName('ETC_CIDENT').AsString,
      cdsConsulta.FieldByName('REG_CODREG').AsString,
      cdsConsulta.FieldByName('ETC_ENDENT').AsString,
      cdsConsulta.FieldByName('ETC_BAIENT').AsString
    );

    frmEnderecosEntregaBaixaEntregaFutura.ShowModal;
  Finally
    pFreeAndNil(frmEnderecosEntregaBaixaEntregaFutura);
  End;
end;

procedure TfrmFatBaixaEntregaFuturaSimpl.dbgConsultaDblClick(Sender: TObject);
begin
  inherited;
  btnConfirma.Click;
end;

procedure TfrmFatBaixaEntregaFuturaSimpl.dbgConsultaDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  if blnSepFut then
  begin
    if cdsConsulta.FieldByName('TOTITEDOC').AsFloat = cdsConsulta.FieldByName('SEP_QTDITE').AsFloat then
    begin
      dbgConsulta.Canvas.Brush.Color := shpSepImpLegenda.Brush.Color;
    end;
  end;

  dbgConsulta.DefaultDrawDataCell(Rect, dbgConsulta.Columns[DataCol].Field, State);
end;

procedure TfrmFatBaixaEntregaFuturaSimpl.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    btnConfirma.Click;
end;

procedure TfrmFatBaixaEntregaFuturaSimpl.edtCodCidadeKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCidades: TConsultasArray;
begin
  inherited;
  If fPesqCidade(Self, edtCodCidade, edtDesCidade, edtEstado, Nil, Key, arrCidades) Then
  Begin
    If fValidaCampos(edtCodCidade, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatBaixaEntregaFuturaSimpl.edtCodClienteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatBaixaEntregaFuturaSimpl.edtCodRegiaoKeyPress(Sender: TObject;
  var Key: Char);
var
  arrRegiao: TConsultasArray;
begin
  inherited;
  If fPesqRegiao(Self, edtCodRegiao, edtNomeRegiao, Nil, Key, arrRegiao, False) Then
  Begin
    if fValidaCampos(edtCodRegiao, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatBaixaEntregaFuturaSimpl.fGetSql(blnLike: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL :=
    TBaixaEntFut.New(
      TParamsBaixaEntFut.New()
        .FaltaProduto(chkFalta.Checked)
        .PrevisaoEntrega(chkPrevisao.Checked)
        .AguardandoCliente(chkAguarda.Checked)
        .ClienteVaiRetirar(IIF(cmbCliBus.Visible, TClienteRetira(cmbCliBus.ItemIndex), crTODOS))
        .DataInicial(StrToDateDef(mskDtaIni.Text, 0))
        .DataFinal(StrToDateDef(mskDtaFin.Text, 0))
        .NumeroDocumento(edtDocFat.Text)
        .EspecieDocumento(edtEspFat.Text)
        .LinhaGrupo(mskLinGru.Text)
        .CodigoCliente(edtCodCliente.Text)
        .CodigoCidade(edtCodCidade.Text)
        .CodigoRegiao(edtCodRegiao.Text)
    ).fGetSqlSimplificado;

  strSQL := strSQL + fFiltraSQL(blnlike);

  strSQL := strSQL + ' GROUP BY ';

  If (fCfgSis('AGBXEF') = '1') Then
    strSQL := strSQL + ' D.DET_DTAFUT, D.DET_CODCLI, CID_CODCID '
  Else If (fCfgSis('AGBXEF') = '2') Then
  Begin
    strSQL := strSQL + ' D.DET_DTAFUT, D.DET_CODCLI, CID_CODCID, EC.ETC_CIDENT, '
                     + ' EC.ETC_BAIENT '
  End
  Else If (fCfgSis('AGBXEF') = '3') Then
    strSQL := strSQL + ' D.DET_DTAFUT, D.DET_CODCLI, CID_CODCID, CR.REG_CODREG '
  Else If (fCfgSis('AGBXEF') = '4') Then
  Begin
    strSQL := strSQL + ' D.DET_DTAFUT, D.DET_CODCLI, CID_CODCID, CR.REG_CODREG, '
                     + ' EC.ETC_CIDENT, EC.ETC_ENDENT, EC.ETC_BAIENT ';
  End;

  Result := strSQL;
end;

procedure TfrmFatBaixaEntregaFuturaSimpl.FormCreate(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
  blnTemPesquisa := False;
  blnTemSelecao  := False;
  blnPrimeiraVez := True;
  blnSepFut := False;
end;

procedure TfrmFatBaixaEntregaFuturaSimpl.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End
  Else
  If Key = VK_F12 Then
  Begin
    Key := 0;
    btnEnderecosEntrega.Click;
  End;
end;

procedure TfrmFatBaixaEntregaFuturaSimpl.FormShow(Sender: TObject);
begin
  inherited;
  If fTemAlgumFiltroPreenchido Then
    btnConsulta.Click;

  If (blnSepFut) Then
  Begin
    fFindColumnByName(dbgConsulta, 'TOTITEDOC').Visible := True;
    fFindColumnByName(dbgConsulta, 'SEP_QTDITE').Visible := True;
    pnlTail.Visible := True;
  End;

  pSetFocus(chkFalta);
end;

function TfrmFatBaixaEntregaFuturaSimpl.fSetParametros: Boolean;
begin
  Result := True;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    qryConsulta.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
    qryConsulta.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
  End;

  If Not fEmptyStr(mskLinGru.Text) Then
    qryConsulta.ParamByName('CODGRU').AsString := mskLinGru.Text;

  If Not fEmptyStr(edtCodCidade.Text) Then
    qryConsulta.ParamByName('CODCID').AsString := edtCodCidade.Text;
end;

function TfrmFatBaixaEntregaFuturaSimpl.fTemAlgumFiltroPreenchido: Boolean;
begin
  Result := False;

  If (Not blnPrimeiraVez) Then
    Exit(True);

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Exit(True);

  If (Not fEmptyStr(edtDocFat.Text)) Then
    Exit(True);

  If (Not fEmptyStr(mskLinGru.Text)) Then
    Exit(True);

  If (Not fEmptyStr(edtCodCliente.Text)) Then
    Exit(True);

  If (Not fEmptyStr(edtCodCidade.Text)) Then
    Exit(True);
end;

function TfrmFatBaixaEntregaFuturaSimpl.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If blnBuscaPorChave Then
      Begin
        mskDtaFin.Clear;
        mskDtaFin.Enabled := Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text));
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End
      End;
    End

    Else If (Sender = cmbCliBus) Then
    Begin
      If cmbCliBus.Visible Then
        blnMudarFoco := False;
    End

    Else If (Sender = mskLinGru) Then
    Begin
      If fEmptyStr(mskLinGru.Text) Then
        edtDesGru.Text := 'TODOS'
      Else
      Begin
        edtDesGru.Text := fRetNomeLinhaGrupo(mskLinGru.Text);

        If fEmptyStr(edtDesGru.Text) Then
        Begin
          fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodCliente) Then
    Begin
      If fEmptyStr(edtCodCliente.Text) Then
        edtDesCliente.Text := 'TODOS'
      Else
      Begin
        edtDesCliente.Text := fRetNomCliente(edtCodCliente.Text);

        If fEmptyStr(edtDesCliente.Text) Then
        Begin
          fMensagem('AVISO','Código do Cliente não encontrado.', ['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodCidade) Then
    Begin
      If fEmptyStr(edtCodCidade.Text) Then
      Begin
        edtDesCidade.Text := 'TODAS';
        edtEstado.Clear;
      End
      Else
      Begin
        edtDesCidade.Text := fRetNomCidade(edtCodCidade.Text);
        edtEstado.Text    := fRetNomCidade(edtCodCidade.Text, 1);

        If fEmptyStr(edtDesCidade.Text) Then
        Begin
          fMensagem('AVISO','Código da Cidade não encontrado.', ['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodRegiao) Then
    Begin
      If fEmptyStr(edtCodRegiao.Text) Then
        edtNomeRegiao.Text := 'TODAS'
      Else
      Begin
        edtNomeRegiao.Text := fRetNomRegiao(edtCodRegiao.Text);

        If fEmptyStr(edtNomeRegiao.Text) Then
        Begin
          fMensagem('AVISO','Código da Região não encontrado.', ['&O K']);
          Result := False;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatBaixaEntregaFuturaSimpl.mskLinGruKeyPress(Sender: TObject; var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtDesGru, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatBaixaEntregaFuturaSimpl.pAbreConsulta;
begin
  fAbreConsulta(True);
  TFloatField(cdsConsulta.FieldByName('TOTITEDOC' )).DisplayFormat := '#,###0.0000';
  TFloatField(cdsConsulta.FieldByName('SEP_QTDITE')).DisplayFormat := '#,###0.0000';
end;

end.
