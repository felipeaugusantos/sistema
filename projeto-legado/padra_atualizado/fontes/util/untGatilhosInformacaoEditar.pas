unit untGatilhosInformacaoEditar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Mask, MaskEditFocus, Menus, Buttons, ExtCtrls,
  QColorLabel, EditFocus, Uni, AppEvnts, UniClientDataSet, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, Vcl.CheckLst, ComboBoxFocus,
  untGatilhosInformacao, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxButtons, cxControls, cxContainer, cxEdit, cxImage, dxGDIPlusClasses;

type
  TfrmGatilhosInformacaoEditar = class(TfrmPai)
    btnConfirmar: TBitBtnLocked;
    pnlEditarGatilho: TPanel;
    lbl6: TLabel;
    edtCodigo: TEditFocus;
    Label5: TLabel;
    cmbStatus: TComboBoxFocus;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    cmbQuandoEnviar: TComboBoxFocus;
    Label7: TLabel;
    chkDiasSemana: TCheckListBox;
    Label4: TLabel;
    edtHoraEnvio: TMaskEditFocus;
    chkEnviarFeriados: TCheckBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    edtNomOpe: TEditFocus;
    edtCodOpe: TEditFocus;
    chkWhatsApp: TCheckBox;
    chkEmail: TCheckBox;
    lblWhatsApp: TLabel;
    lblEmail: TLabel;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    edtCodRel: TEditFocus;
    edtNomRel: TEditFocus;
    lblMotEntFut: TLabel;
    cmbPeriodo: TComboBoxFocus;
    btnConfigurarFiltros: TcxButton;
    Label2: TLabel;
    chkDiasMes: TCheckListBox;
    btnEmailTeste: TcxButton;
    btnWhatsAppTeste: TcxButton;
    Label8: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lblLocalizar: TLabel;
    edtDescricao: TEditFocus;
    Label9: TLabel;
    cmbRelatorioStatus: TComboBoxFocus;
    Label10: TLabel;
    cmbRelatorioTipo: TComboBoxFocus;
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodRelKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfigurarFiltrosClick(Sender: TObject);
    procedure cmbQuandoEnviarChange(Sender: TObject);
    procedure lblEmailClick(Sender: TObject);
    procedure lblWhatsAppClick(Sender: TObject);
    procedure btnEmailTesteClick(Sender: TObject);
    procedure btnWhatsAppTesteClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FGatilho: TGatilhoInformacao;
    FPeriodos: TGatilhoPeriodos;
  protected
    procedure pAtualizarLabelWhatsApp;
    procedure pAtualizarLabelEmail;
    procedure pAtualizarComboPeriodos;
    function fValidarEmailOperadorDestino(blnInformar: Boolean; blnForcar: Boolean = False): Boolean;
    function fValidarWhatsAppOperadorDestino(blnInformar: Boolean; blnForcar: Boolean = False): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidarEstruturaParaDisparoDeWhatsapp: Boolean;
  public
    { Public declarations }
    class function Editar(const ACodigo: string): Boolean;
    class function Copiar(var ACodigo: String): Boolean;
    class function Inserir(var ACodigo: string): Boolean;
  end;

implementation

uses  untfuncoesSimples, DB, untTypesSistema, untConsultas, untRelatorio,
  untMaskInputDialog, untFuncoesGenerica;

{$R *.dfm}

class function TfrmGatilhosInformacaoEditar.Inserir(
  var ACodigo: string): Boolean;
var
  frmEditar: TfrmGatilhosInformacaoEditar;
begin
  pCriarFormularios(TfrmGatilhosInformacaoEditar, frmEditar);
  try
    try
      Result := frmEditar.ShowModal = mrOk;
      if Result Then
        ACodigo := frmEditar.FGatilho.strCodigo;
    finally
      frmEditar.FGatilho.LiberarFiltros;
    end;
  finally
    pFreeAndNil(frmEditar);
  end;
end;

procedure TfrmGatilhosInformacaoEditar.pAtualizarComboPeriodos;
var
  LPeriodo: TGatilhoPeriodo;
begin
  cmbPeriodo.Clear;
  cmbPeriodo.ItemIndex := -1;

  if not FGatilho.fTemFiltroDataInicial then
    if not FGatilho.fTemFiltroDataFinal then
    begin
      cmbPeriodo.Enabled := False;
      Exit;
    end;

  for LPeriodo in FPeriodos.Items do
  begin
    if LPeriodo.strSQLDataInicial <> EmptyStr then
      if not FGatilho.fTemFiltroDataInicial then
        Continue;

    if LPeriodo.strSQLDataInicial = EmptyStr then
      if FGatilho.fTemFiltroDataInicial then
        Continue;

    if LPeriodo.strSQLDataFinal <> EmptyStr then
      if not FGatilho.fTemFiltroDataFinal then
        Continue;

    if LPeriodo.strSQLDataFinal = EmptyStr then
      if FGatilho.fTemFiltroDataFinal then
        Continue;

    cmbPeriodo.Items.AddObject(LPeriodo.strDescricao, TObject(LPeriodo.strCodigo));
  end;

  cmbPeriodo.Enabled := cmbPeriodo.Items.Count > 0;

  If cmbPeriodo.Items.Count = 0 then
  Begin
    pMensagensErro('GATPER Vazia', '');
  End;
end;

procedure TfrmGatilhosInformacaoEditar.lblEmailClick(Sender: TObject);
begin
  inherited;
  if not fValidarEmailOperadorDestino(True) then
    chkEmail.Checked := False;
end;

procedure TfrmGatilhosInformacaoEditar.lblWhatsAppClick(Sender: TObject);
begin
  inherited;
  if not fValidarWhatsAppOperadorDestino(True) then
    chkWhatsApp.Checked := False;
end;

procedure TfrmGatilhosInformacaoEditar.pAtualizarLabelEmail;
begin
  lblEmail.Visible := not fEmptyStr(edtCodOpe.Text);
  lblEmail.Caption := fRetEmailOperador(edtCodOpe.Text);
  if fEmptyStr(lblEmail.Caption) then
    lblEmail.Caption := 'clique aqui para informar o email do operador.'
end;

procedure TfrmGatilhosInformacaoEditar.pAtualizarLabelWhatsApp;
begin
  lblWhatsApp.Visible := not fEmptyStr(edtCodOpe.Text) and fCfgSis('UTIWPP', varBoolean);
  lblWhatsApp.Caption := fCampoTabela('OPE_NUMWPP', 'CADOPE', ['OPE_CODOPE'], [edtCodOpe.Text]);
  if fEmptyStr(lblWhatsApp.Caption) then
    lblWhatsApp.Caption := 'clique aqui para informar o WhatsApp do operador.'
  else
    lblWhatsApp.Caption := fFormataFone(lblWhatsApp.Caption);
end;

procedure TfrmGatilhosInformacaoEditar.btnConfigurarFiltrosClick(Sender: TObject);
begin
  inherited;
  if fVerificaCampos then
    if FGatilho.EditarFiltrosRelatorio then
      pSetFocus(btnConfirmar);
end;

class function TfrmGatilhosInformacaoEditar.Editar(const ACodigo: String): Boolean;
var
  frmEditar: TfrmGatilhosInformacaoEditar;
begin
  Result := False;
  pCriarFormularios(TfrmGatilhosInformacaoEditar, frmEditar);
  try
    if TGatilhosInformacao.Carregar(ACodigo, frmEditar.FGatilho) then
    begin
      try
        Result := frmEditar.ShowModal = mrOk;
      finally
        frmEditar.FGatilho.LiberarFiltros;
      end;
    end
    else
      pMensagemOk('Não foi possível carregar este gatilho para edição!');
  finally
    pFreeAndNil(frmEditar);
  end;
end;

class function TfrmGatilhosInformacaoEditar.Copiar(var ACodigo: String): Boolean;
var
  frmEditar: TfrmGatilhosInformacaoEditar;
begin
  Result := False;
  pCriarFormularios(TfrmGatilhosInformacaoEditar, frmEditar);
  try
    if TGatilhosInformacao.Copiar(ACodigo, frmEditar.FGatilho) then
    begin
      try
        Result := frmEditar.ShowModal = mrOk;
        if Result then
          ACodigo := frmEditar.FGatilho.strCodigo;
      finally
        frmEditar.FGatilho.LiberarFiltros;
      end;
    end
    else
      pMensagemOk('Não foi possível copiar este gatilho!');
  finally
    pFreeAndNil(frmEditar);
  end;
end;

procedure TfrmGatilhosInformacaoEditar.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  if not edtCodEmp.ReadOnly then
    if (fPesqEmpresa(TTipoConsultaEmpresa.conEmpSimples, Self, edtCodEmp, edtNomEmp, nil, Key, arrSel)) then
      if fValidaCampos(edtCodEmp, True) then
        SelectNext(edtCodEmp, True, True);
end;

procedure TfrmGatilhosInformacaoEditar.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  if not edtCodOpe.ReadOnly then
    if (fPesqOperador(Self, edtCodOpe, edtNomOpe, nil, Key, arrSel)) then
      if fValidaCampos(edtCodOpe, True) then
        SelectNext(edtCodOpe, True, True);
end;

procedure TfrmGatilhosInformacaoEditar.edtCodRelKeyPress(Sender: TObject;
  var Key: Char);
var
  arrRelatorios: TConsultasArray;
begin
  inherited;
  if not edtCodRel.ReadOnly then
    if fPesqRelatorio(Self, edtCodRel, edtNomRel, Nil, False, '', Key, arrRelatorios, True, True, '') then
      if fValidaCampos(edtCodRel, True) then
        SelectNext(edtCodRel, True, True);
end;

procedure TfrmGatilhosInformacaoEditar.FormCreate(Sender: TObject);
begin
  inherited;
  FPeriodos := TGatilhoPeriodos.Create;
  chkDiasSemana.OnKeyDown := pOnKeyDownEdits;
  chkDiasMes.OnKeyDown := pOnKeyDownEdits;
  cmbQuandoEnviar.ItemIndex := 0;
  cmbQuandoEnviarChange(nil);
  cmbRelatorioStatus.Items.Clear;
  cmbRelatorioStatus.Items.Add('Normal');
  cmbRelatorioStatus.Items.Add('Alerta');
  cmbRelatorioStatus.ItemIndex := 0;
  cmbRelatorioTipo.Items.CommaText := fCfgSis('GATTIP');
  cmbRelatorioTipo.Items.Insert(0, '');
  cmbRelatorioTipo.ItemIndex := 0;
end;

procedure TfrmGatilhosInformacaoEditar.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FPeriodos);
end;

procedure TfrmGatilhosInformacaoEditar.FormShow(Sender: TObject);
var
  LIndex: Integer;
begin
  inherited;
  pAtualizarComboPeriodos;
  if not FGatilho.strCodigo.IsEmpty then
  begin
    edtCodigo.Text := FGatilho.strCodigo;
    edtDescricao.Text := FGatilho.strDescricao;
    edtCodRel.Text := FGatilho.strCodigoRelatorio;
    edtNomRel.Text := fRetNomeRelatorio(FGatilho.strCodigoRelatorio);
    edtCodOpe.Text := FGatilho.strCodigoOperador;
    edtNomOpe.Text := fRetNomVendRep(FGatilho.strCodigoOperador);
    edtCodEmp.Text := FGatilho.strCodigoEmpresa;
    edtNomEmp.Text := fRetNomeEmpresa(FGatilho.strCodigoEmpresa);
    cmbRelatorioStatus.ItemIndex := cmbRelatorioStatus.Items.IndexOf(FGatilho.strRelatorioStatus);
    cmbRelatorioTipo.ItemIndex := cmbRelatorioTipo.Items.IndexOf(FGatilho.strRelatorioTipo);
    chkWhatsApp.Checked := FGatilho.blnWhatsApp;
    chkEmail.Checked := FGatilho.blnEmail;
    chkEnviarFeriados.Checked := FGatilho.blnEnviarFeriados;
    edtHoraEnvio.Text := TimeToStr(FGatilho.dtaHoraEnvio);
    cmbPeriodo.ItemIndex := cmbPeriodo.Items.IndexOf(FPeriodos.FindByCodigo(FGatilho.strCodigoPeriodo).strDescricao);
    cmbStatus.ItemIndex := IIF(FGatilho.blnAtivo, 0, 1);
    cmbQuandoEnviar.ItemIndex := cmbQuandoEnviar.Items.IndexOf(FGatilho.strQuandoEnviar);
    cmbQuandoEnviarChange(nil);
    edtCodRel.ReadOnly := True;
    edtCodRel.TabStop := False;
    edtCodRel.Color := $00FFDFB8;
    edtCodRel.NormalColor := $00FFDFB8;
    edtCodOpe.ReadOnly := True;
    edtCodOpe.TabStop := False;
    edtCodOpe.Color := $00FFDFB8;
    edtCodOpe.NormalColor := $00FFDFB8;
    if not FGatilho.strCodigoEmpresa.IsEmpty then
    begin
      edtCodEmp.ReadOnly := True;
      edtCodEmp.TabStop := False;
      edtCodEmp.Color := $00FFDFB8;
      edtCodEmp.NormalColor := $00FFDFB8;
    end;
    if chkDiasSemana.Enabled then
      for LIndex := 1 to 7 do
        chkDiasSemana.Checked[Pred(LIndex)] := FGatilho.strDiasSemana[LIndex] = 'S';
    if chkDiasMes.Enabled then
      for LIndex := 1 to 31 do
        chkDiasMes.Checked[Pred(LIndex)] := FGatilho.strDiasMes[LIndex] = 'S';
    pSetFocus(cmbPeriodo);
  end
  else if FGatilho.blnCopiar then
  begin
    edtDescricao.Text := FGatilho.strDescricao;
    edtCodRel.Text := FGatilho.strCodigoRelatorio;
    edtNomRel.Text := fRetNomeRelatorio(FGatilho.strCodigoRelatorio);
    edtCodEmp.Text := FGatilho.strCodigoEmpresa;
    edtNomEmp.Text := fRetNomeEmpresa(FGatilho.strCodigoEmpresa);
    cmbRelatorioStatus.ItemIndex := cmbRelatorioStatus.Items.IndexOf(FGatilho.strRelatorioStatus);
    cmbRelatorioTipo.ItemIndex := cmbRelatorioTipo.Items.IndexOf(FGatilho.strRelatorioTipo);
    chkWhatsApp.Checked := FGatilho.blnWhatsApp;
    chkEmail.Checked := FGatilho.blnEmail;
    chkEnviarFeriados.Checked := FGatilho.blnEnviarFeriados;
    edtHoraEnvio.Text := TimeToStr(FGatilho.dtaHoraEnvio);
    cmbPeriodo.ItemIndex := cmbPeriodo.Items.IndexOf(FPeriodos.FindByCodigo(FGatilho.strCodigoPeriodo).strDescricao);
    cmbStatus.ItemIndex := IIF(FGatilho.blnAtivo, 0, 1);
    cmbQuandoEnviar.ItemIndex := cmbQuandoEnviar.Items.IndexOf(FGatilho.strQuandoEnviar);
    cmbQuandoEnviarChange(nil);
    edtCodRel.ReadOnly := True;
    edtCodRel.TabStop := False;
    edtCodRel.Color := $00FFDFB8;
    edtCodRel.NormalColor := $00FFDFB8;
    if not FGatilho.strCodigoEmpresa.IsEmpty then
    begin
      edtCodEmp.ReadOnly := True;
      edtCodEmp.TabStop := False;
      edtCodEmp.Color := $00FFDFB8;
      edtCodEmp.NormalColor := $00FFDFB8;
    end;
    if chkDiasSemana.Enabled then
      for LIndex := 1 to 7 do
        chkDiasSemana.Checked[Pred(LIndex)] := FGatilho.strDiasSemana[LIndex] = 'S';
    if chkDiasMes.Enabled then
      for LIndex := 1 to 31 do
        chkDiasMes.Checked[Pred(LIndex)] := FGatilho.strDiasMes[LIndex] = 'S';
    pSetFocus(edtCodOpe);
  end
  else
  begin
    chkWhatsApp.Checked := True;
    chkEmail.Checked := True;
    cmbQuandoEnviar.ItemIndex := 0;
    cmbQuandoEnviarChange(nil);
    chkEnviarFeriados.Checked := False;
    chkDiasSemana.Checked[0] := False;//dom
    chkDiasSemana.Checked[1] := True;
    chkDiasSemana.Checked[2] := True;
    chkDiasSemana.Checked[3] := True;
    chkDiasSemana.Checked[4] := True;
    chkDiasSemana.Checked[5] := True;
    chkDiasSemana.Checked[6] := False;//sab
    edtCodEmp.Text := VS_strCodEmp;
    edtNomEmp.Text := fRetNomeEmpresa(VS_strCodEmp);
    chkWhatsApp.Checked := FGatilho.blnWhatsApp;
    pSetFocus(edtCodEmp);
  end;
  if not fCfgSis('UTIWPP', varBoolean) then
  begin
    chkWhatsApp.Visible := False;
    chkWhatsApp.Checked := False;
    chkEmail.Enabled    := False;
    chkEmail.Checked    := True;
    btnWhatsAppTeste.Visible := False;
  end;
  FGatilho.CarregarFiltros;
  pAtualizarLabelEmail;
  pAtualizarLabelWhatsApp;
end;

function TfrmGatilhosInformacaoEditar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  LIndex: Integer;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = edtCodRel Then
    Begin
      edtNomRel.Text := fRetNomeRelatorio(edtCodRel.Text);
      if fEmptyStr(edtCodRel.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Código do Relatório deve ser preenchido!', ['&Ok']);
        Result := False;
      end
      else if not TGatilhosInformacao.ValidarRelatorio(edtCodRel.Text) then
      begin
        edtNomRel.Clear;
        edtCodRel.Clear;
        Result := False;
      end
      else
      begin
        if FGatilho.strCodigoRelatorio <> edtCodRel.Text then
        begin
          FGatilho.strCodigoRelatorio := edtCodRel.Text;
          FGatilho.CarregarFiltros;
          pAtualizarComboPeriodos;
          edtDescricao.Text := edtNomRel.Text;
        end;
      end;
    End
    Else If Sender = edtCodOpe Then
    Begin
      edtNomOpe.Text := fRetNomVendRep(edtCodOpe.Text);
      if fEmptyStr(edtCodOpe.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Código do Operador deve ser preenchido!', ['&Ok']);
        Result := False;
      end
      else if fEmptyStr(edtNomOpe.Text) then
      begin
        pMensagemOk('Operador não encontrado com este código!');
        edtCodOpe.Clear;
        Result := False;
      end
      else if FGatilho.strCodigoOperador <> edtCodOpe.Text then
      begin
        FGatilho.strCodigoOperador := edtCodOpe.Text;
        FGatilho.CarregarFiltros;
      end;
      pAtualizarLabelEmail;
      pAtualizarLabelWhatsApp;
    End
    Else If Sender = edtCodEmp Then
    Begin
      edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
      if fEmptyStr(edtCodEmp.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&Ok']);
        Result := False;
      end
      else if fEmptyStr(edtNomEmp.Text) then
      begin
        pMensagemOk('Empresa não encontrada com este código!');
        edtCodEmp.Clear;
        Result := False;
      end
      else
      begin
        FGatilho.strCodigoEmpresa := edtCodEmp.Text;
      end;
    End
    Else If (Sender = edtHoraEnvio) Then
    Begin
      If StrToTimeDef(edtHoraEnvio.Text, 0) = 0 Then
      Begin
        fMensagem('ATENÇÃO','Informe uma hora válida para executar o gatilho',['&OK']);
        Result := False;
      End
      else
        FGatilho.dtaHoraEnvio := StrToTimeDef(edtHoraEnvio.Text, 0);
    End
    Else If (Sender = edtDescricao) Then
    Begin
      If fEmptyStr(edtDescricao.Text) Then
      Begin
        fMensagem('ATENÇÃO','Informe a descrição do gatilho',['&OK']);
        Result := False;
      End
      else
        FGatilho.strDescricao := edtDescricao.Text;
    End
    Else If (Sender = cmbRelatorioStatus) Then
    Begin
      If fEmptyStr(cmbRelatorioStatus.Text) Then
      Begin
        fMensagem('ATENÇÃO','Informe o status para envio do Relatório',['&OK']);
        Result := False;
      End
      else
        FGatilho.strRelatorioStatus := cmbRelatorioStatus.Text;
    End
    Else If (Sender = cmbRelatorioTipo) Then
    Begin
      If fEmptyStr(cmbRelatorioTipo.Text) Then
      Begin
        fMensagem('ATENÇÃO','Informe o tipo para envio do Relatório',['&OK']);
        Result := False;
      End
      else
        FGatilho.strRelatorioTipo := cmbRelatorioTipo.Text;
    End
    Else If (Sender = cmbPeriodo) Then
    Begin
      If fEmptyStr(cmbPeriodo.Text) And cmbPeriodo.Enabled Then
      Begin
        fMensagem('ATENÇÃO','Selecione um período para executar o gatilho',['&OK']);
        Result := False;
      End
      Else
      Begin
        If cmbPeriodo.Enabled then
          FGatilho.strCodigoPeriodo := String(cmbPeriodo.Items.Objects[cmbPeriodo.ItemIndex])
        else
          FGatilho.strCodigoPeriodo := EmptyStr;
      End;
    End
    Else If (Sender = cmbQuandoEnviar) Then
    Begin
      If fEmptyStr(cmbQuandoEnviar.Text) Then
      Begin
        fMensagem('ATENÇÃO','Selecione a opção de quando enviar o gatilho',['&OK']);
        Result := False;
      End
      Else
      Begin
        FGatilho.strQuandoEnviar := cmbQuandoEnviar.Text;
      End;
    End
    Else If (Sender = chkDiasSemana) and chkDiasSemana.Enabled Then
    Begin
      FGatilho.strDiasSemana := EmptyStr;
      for LIndex := 1 to 7 do
        if chkDiasSemana.Checked[Pred(LIndex)] then
          FGatilho.strDiasSemana := FGatilho.strDiasSemana + 'S'
        else
          FGatilho.strDiasSemana := FGatilho.strDiasSemana + 'N';
      if not FGatilho.strDiasSemana.Contains('S') then
      Begin
        fMensagem('ATENÇÃO','Selecione pelo menos um dia da semana para executar o gatilho',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = chkDiasMes) and chkDiasMes.Enabled Then
    Begin
      FGatilho.strDiasMes := EmptyStr;
      for LIndex := 1 to 31 do
        if chkDiasMes.Checked[Pred(LIndex)] then
          FGatilho.strDiasMes := FGatilho.strDiasMes + 'S'
        else
          FGatilho.strDiasMes := FGatilho.strDiasMes + 'N';
      if not FGatilho.strDiasMes.Contains('S') then
      Begin
        fMensagem('ATENÇÃO','Selecione pelo menos um dia do mês para executar o gatilho',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = chkWhatsApp) Then
    Begin
      FGatilho.blnWhatsApp := chkWhatsApp.Checked;
    End
    Else If (Sender = chkEmail) Then
    Begin
      FGatilho.blnEmail := chkEmail.Checked;
    End
    Else If (Sender = chkEnviarFeriados) Then
    Begin
      FGatilho.blnEnviarFeriados := chkEnviarFeriados.Checked;
    End
    Else If (Sender = cmbStatus) Then
    Begin
      FGatilho.blnAtivo := cmbStatus.Text = 'Ativo';
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmGatilhosInformacaoEditar.fValidarEstruturaParaDisparoDeWhatsapp: Boolean;
var
  LIDFilaValidar: String;
  blnValidarCfgGatOpe: Boolean;
begin
  Result := False;

  if not fCfgSis('UTIWPP', varBoolean) then
    Exit(True);

  if not FGatilho.blnWhatsApp then
    Exit(True);

  if not FGatilho.blnAtivo then
    Exit(True);

  LIDFilaValidar := fCampoTabela('REL_WIDDIS', 'CADREL', ['REL_CODREL'], [FGatilho.strCodigoRelatorio]);
  blnValidarCfgGatOpe := fEmptyStr(LIDFilaValidar);

  if not fValidarEstruturaParaDisparoDeWhatsappDosGatilhosDeInformacao(fCfgSis('GATOPE', varString, FGatilho.strCodigoEmpresa), blnValidarCfgGatOpe, True, LIDFilaValidar) then
    Exit;

  Result := True;
end;

function TfrmGatilhosInformacaoEditar.fValidarEmailOperadorDestino(blnInformar: Boolean; blnForcar: Boolean = False): Boolean;
var
  strEmail: string;
begin
  if chkEmail.Checked or blnForcar then
  begin
    strEmail := fRetEmailOperador(edtCodOpe.Text);
    if blnInformar then
      strEmail := fMaskInputDialog('Confirme o Email do operador', 'Confirme o Email:', strEmail, 255, 450, ecLowerCase);
    while not fEmailValido(strEmail, True, 'Email', False, False) do
    begin
      strEmail := fMaskInputDialog('Email do operador', 'Informe o Email:', '', 255, 450, ecLowerCase);
      if fEmptyStr(strEmail) then
      begin
        pMensagemOk('O Email deve ser informado para confirmar o gatilho de informação!');
        Exit(False);
      end;
    end;
    if strEmail <> fRetEmailOperador(edtCodOpe.Text) then
      fExecutaSQL('UPDATE CADOPE SET OPE_E_MAIL = "' + strEmail + '" WHERE OPE_CODOPE = "' + edtCodOpe.Text + '"');
  end;
  pAtualizarLabelEmail;
  Result := True;
end;

function TfrmGatilhosInformacaoEditar.fValidarWhatsAppOperadorDestino(blnInformar: Boolean; blnForcar: Boolean = False): Boolean;
var
  strWhatsApp: string;
begin
  if (chkWhatsApp.Checked or blnForcar) and chkWhatsApp.Visible then
  begin
    strWhatsApp := fCampoTabela('OPE_NUMWPP', 'CADOPE', ['OPE_CODOPE'], [edtCodOpe.Text]);
    if blnInformar then
      strWhatsApp := fMaskInputDialog('Confirme o WhatsApp do operador', 'Confirme o WhatsApp:', strWhatsApp, 255, 450, ecNormal, fRetMascaraFonePais);
    while not fValidaTelefone(strWhatsApp) do
    begin
      pMensagemOk('Informe o número do WhatsApp corretamente!');
      strWhatsApp := fMaskInputDialog('WhatsApp do operador', 'Informe o WhatsApp:', '', 255, 450, ecNormal, fRetMascaraFonePais);
      if fEmptyStr(strWhatsApp) then
      begin
        pMensagemOk('O WhatsApp deve ser informado para confirmar o gatilho de informação!');
        Exit(False);
      end;
    end;
    if strWhatsApp <> fCampoTabela('OPE_NUMWPP', 'CADOPE', ['OPE_CODOPE'], [edtCodOpe.Text]) then
      fExecutaSQL('UPDATE CADOPE SET OPE_NUMWPP = "' + strWhatsApp + '" WHERE OPE_CODOPE = "' + edtCodOpe.Text + '"');
  end;
  pAtualizarLabelWhatsApp;
  Result := True;
end;

procedure TfrmGatilhosInformacaoEditar.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if not fVerificaCampos then
    Exit;

  if chkWhatsApp.Visible then
    if not chkWhatsApp.Checked then
      if not chkEmail.Checked then
      begin
        pMensagemOk('Necessário selecionar pelo menos uma opção de envio (WhatsApp ou Email)!');
        Exit;
      end;

  if not FGatilho.ValidarFiltrosRelatorio then
  begin
    pMensagemOk('Necessário configurar os filtros do Relatório antes de confirmar!');
    btnConfigurarFiltros.Click;
    if not FGatilho.ValidarFiltrosRelatorio then
      Exit;
  end;

  if not fValidarEmailOperadorDestino(False) then
    Exit;

  if not fValidarWhatsAppOperadorDestino(False) then
    Exit;

  if not fValidarEstruturaParaDisparoDeWhatsapp then
    Exit;

  if not TGatilhosInformacao.Salvar(FGatilho) then
    Exit;

  ModalResult := mrOk;
end;

procedure TfrmGatilhosInformacaoEditar.btnEmailTesteClick(Sender: TObject);
begin
  inherited;
  if not fVerificaCampos then
    Exit;

  if not FGatilho.ValidarFiltrosRelatorio then
  begin
    pMensagemOk('Necessário configurar os filtros do relatório antes de realizar o teste de envio por email!');
    btnConfigurarFiltros.Click;
    if not FGatilho.ValidarFiltrosRelatorio then
      Exit;
  end;

  if not fValidarEmailOperadorDestino(False, True) then
    Exit;

  fExecutarModal(FGatilho.TestarEnviarRelatorioPorEmail, 'Testando envio por email, aguarde ...', '');
end;

procedure TfrmGatilhosInformacaoEditar.btnWhatsAppTesteClick(Sender: TObject);
begin
  inherited;
  if not btnWhatsAppTeste.Visible then
    Exit;

  if not fVerificaCampos then
    Exit;

  if not FGatilho.ValidarFiltrosRelatorio then
  begin
    pMensagemOk('Necessário configurar os filtros do relatório antes de realizar o teste de envio por whatsapp!');
    btnConfigurarFiltros.Click;
    if not FGatilho.ValidarFiltrosRelatorio then
      Exit;
  end;

  if not fValidarWhatsAppOperadorDestino(False, True) then
    Exit;

  fExecutarModal(FGatilho.TestarEnviarRelatorioPorWhatsApp, 'Testando envio por whatsapp, aguarde ...', '');
end;

procedure TfrmGatilhosInformacaoEditar.cmbQuandoEnviarChange(Sender: TObject);
begin
  inherited;
  chkDiasSemana.Enabled := cmbQuandoEnviar.ItemIndex = 0;
  if not chkDiasSemana.Enabled then
    chkDiasSemana.CheckAll(TCheckBoxState.cbUnchecked);

  chkDiasMes.Enabled := cmbQuandoEnviar.ItemIndex = 1;
  if not chkDiasMes.Enabled then
    chkDiasMes.CheckAll(TCheckBoxState.cbUnchecked);
end;

end.

