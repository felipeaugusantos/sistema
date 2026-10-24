unit untTefCitelAdministracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, EditFocus,
  cxCurrencyEdit, CurrencyEditFocus, ComboBoxFocus, untLiberacao,
  untInterfaceTefCitel, untTefCitelInfoMsg, cxGroupBox, cxRadioGroup, StrUtils, Uni,
  dxBarBuiltInMenu, cxPC, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxGrid, Datasnap.DBClient, cxProgressBar, untTypesSistema;

const
  strMsgPassaCartao = 'Insira ou passe o cartao na leitora. Pressione 9 para CANCELAR.';
  strMsgAproxeCartao = 'Insira ou passe ou aproxime o cartao na leitora. Pressione 9 para CANCELAR.';
  strMsgNaoEhTerminal = 'Opção de reimpressão e cancelamento somente no terminal onde haja leitora de cartão com fio (PIN Pad) habilitado.';

type
  TConsultaControleNcr = record
    blnOk: Boolean;
    dtaData: TDate;
    fltValor: Double;
    blnMaisDeUm: Boolean;
  end;

type
  TfrmTefCitelAdministracao = class(TfrmPaiSimples, IObserverTEFCitel)
    Panel2: TPanel;
    pnDados: TPanel;
    lblNumNsu: TLabel;
    lblTotalBruto: TLabel;
    Label2: TLabel;
    edtNumNsu: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    edtDtaTransacao: TcxDateEdit;
    edtValTra: TEditFocus;
    pnReimpressao: TPanel;
    btnEncerraReimp: TBitBtnLocked;
    btnConfirmaReimp: TBitBtnLocked;
    pnCancelamento: TPanel;
    btnCredito: TBitBtnLocked;
    btnDebito: TBitBtnLocked;
    btnEncerra: TBitBtnLocked;
    Label3: TLabel;
    pnMenu: TPanel;
    btnReimprimeTransacao: TBitBtnLocked;
    btnCancelaTransacao: TBitBtnLocked;
    btnSairFechamento: TBitBtnLocked;
    cbTipoComp: TComboBoxFocus;
    btnVerTransPendentes: TBitBtnLocked;
    pnMensTef: TPanel;
    tmrAtualizaMsg: TTimer;
    lbOperacoes: TLabel;
    btnPix: TBitBtnLocked;
    btnFoco: TBitBtnLocked;
    btnRelatorioTef: TBitBtnLocked;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtValTraKeyPress(Sender: TObject; var Key: Char);
    procedure edtValTraClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairFechamentoClick(Sender: TObject);
    procedure btnCreditoClick(Sender: TObject);
    procedure btnDebitoClick(Sender: TObject);
    procedure btnEncerraClick(Sender: TObject);
    procedure btnReimprimeTransacaoClick(Sender: TObject);
    procedure btnCancelaTransacaoClick(Sender: TObject);
    procedure btnConfirmaReimpClick(Sender: TObject);
    procedure btnEncerraReimpClick(Sender: TObject);
    procedure cbTipoCompChange(Sender: TObject);
    procedure btnVerTransPendentesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tmrAtualizaMsgTimer(Sender: TObject);
    procedure btnPixClick(Sender: TObject);
    procedure btnRelatorioTefClick(Sender: TObject);
  private
    { Private declarations }
    objLiberacao:  TLiberacao;
    intTipoCar : integer;
    intTipo : Integer;
    FOperacaoAndamento : Boolean;
    blnPermiteSair : Boolean;

    function fObteveDadosUltimoComprovante(var AstrAutoInc: String): Boolean;
    function fObteveDadosEspecificoComprovante(var AstrAutoInc: String; const AdtaDataComprovante: TDateTime; const AstrNsu: String; const AfltValor: Double): Boolean;
    procedure pLimpaCampos;
    function fCancelamento : Boolean;
    function fReimpressao : Boolean;
    function fVerLiberacaoCancelamento: Boolean;
    function fVerLiberacaoReImpressao: Boolean;

    procedure pHabilitaDados(blnHabilita : Boolean; intTipo : Integer);

    function fVerificaPendencias(pgbProgresso: TcxProgressBar): Boolean;
    function fVerificaTransacaoJaEstornada(strNumNsu : String; dtaDtaTra : TDate; out strDtaEstorno : String) : Boolean;

    procedure pCancelamento;
    procedure pReimpressao;

    procedure pTecla1Click;
    procedure pTecla2Click;
    procedure pTecla3Click;
    procedure pTecla4Click;
    procedure pTecla5Click;
    procedure pTecla7Click;
    procedure pTecla9Click;
    function fVerificaMsgInsiraCartao(strMsg : String) : Boolean;
    function fRetornaCarteiraDigitalSelecionada(const AarrCarDig: Array Of String):integer ;
    function fRetornaDescricaoCarteiraDigital:string ;
    procedure pTrocaCamposDeLugarNcr ;
    procedure pFocoCamposNcr ;
    function fConsultaControleNcr(const AstrControle: String; const AfltValorDig: Double; const AdtaDataDig: TDate): TConsultaControleNcr;
    function fObterStatusLocalDoComprovante(const AstrAutoInc: String): string;
    procedure pDesabilitaTefRelatorios;
  protected
    procedure AtualizaTefCitel(ARetorno: IRetornoTEFCitel);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untTefCitelUtil, untFuncoesSimples, untQckFatImpNFCe,
  untTefCitelTransacaoView;

{$R *.dfm}

procedure TfrmTefCitelAdministracao.btnCreditoClick(Sender: TObject);
begin
  inherited;
  intTipoCar := 2;

  pnCancelamento.Visible := False;
  pnDados.Visible        := True;

  lbOperacoes.Caption := 'CRÉDITO';

  pFocoCamposNcr ;
end;

procedure TfrmTefCitelAdministracao.btnDebitoClick(Sender: TObject);
begin
  inherited;
  intTipoCar := 1;

  pnCancelamento.Visible := False;
  pnDados.Visible := True;

  lbOperacoes.Caption := 'DÉBITO';

  pFocoCamposNcr ;
end;

procedure TfrmTefCitelAdministracao.btnEncerraClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;

  pnMenu.Enabled := True;
  pnCancelamento.Visible := False;

  btnReimprimeTransacao.Enabled := True;
  btnSairFechamento.Enabled     := True;
end;

procedure TfrmTefCitelAdministracao.btnEncerraReimpClick(Sender: TObject);
begin
  inherited;
  pnMenu.Enabled        := True;
  pnReimpressao.Visible := False;

  btnCancelaTransacao.Enabled := True;
  btnSairFechamento.Enabled   := True;
end;

procedure TfrmTefCitelAdministracao.btnPixClick(Sender: TObject);
begin
  inherited;
  intTipoCar := CARTEIRA_DIGITAL_ESTORNO;

  pnCancelamento.Visible := False;
  pnDados.Visible := True;

  lbOperacoes.Caption := Trim(fRetornaDescricaoCarteiraDigital);

  pFocoCamposNcr ;
end;

procedure TfrmTefCitelAdministracao.btnReimprimeTransacaoClick(Sender: TObject);
begin
  inherited;
  intTipo := 4;
  if fVerLiberacaoReImpressao then
  begin
    pnMenu.Enabled              := False;
    pnReimpressao.Visible       := True;

    btnCancelaTransacao.Enabled := False;
    btnSairFechamento.Enabled   := False;

    pSetFocus(cbTipoComp);
    cbTipoComp.ItemIndex := 0;
  end ;
end;

procedure TfrmTefCitelAdministracao.btnRelatorioTefClick(Sender: TObject);
var
  frmTransacaoTef: TfrmTransacaoTef;
  LMensagem: string;
begin
  inherited;
  if fCfgSis('TEFCIT') = OPCAO_NCR then
  begin
    if not fVerificaConexaoApiScope then
    begin
      LMensagem := 'Não conseguimos acessar as informações agora.' + sLineBreak +
        'Você será redirecionado ao site, para consultar os dados diretamente.';

      fMensagem('ATENÇÃO!', LMensagem, ['&OK']) ;
      pBrowserNavigate(fCfgSis('RLTFLK')) ;
      Exit;
    end;
  end
  else
  begin
    if fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_SE_CRE']) = '' then
    begin
      fMensagem('ATENÇÃO!', 'Necessário registrar uma credencial.'+ #13+ 'Verifique a CFG_SE_CRE.', ['&OK']) ;
      exit ;
    end ;
  end ;

  pCriarFormularios(TfrmTransacaoTef, frmTransacaoTef);
  try
    frmTransacaoTef.ShowModal;
  finally
    pFreeAndNil(frmTransacaoTef);
  end;
end;

procedure TfrmTefCitelAdministracao.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;

  pnDados.Visible        := False;
  pnReimpressao.Visible  := False;
  pnCancelamento.Visible := False;
  pnMenu.Enabled         := True;

  btnCancelaTransacao.Enabled   := True;
  btnSairFechamento.Enabled     := True;
  btnReimprimeTransacao.Enabled := True;
end;

procedure TfrmTefCitelAdministracao.btnCancelaTransacaoClick(Sender: TObject);
begin
  inherited;
  intTipo := 5;

  if fVerLiberacaoCancelamento then
  begin
    pSetFocus(btnCancelaTransacao);
    Sleep(100);

    pnMenu.Enabled                := False;
    pnCancelamento.Visible        := True;
    btnPix.Caption                := '3 - ' + fRetornaDescricaoCarteiraDigital ;

    btnReimprimeTransacao.Enabled := False;
    btnSairFechamento.Enabled     := False;

    pSetFocus(btnCredito);
  end;
end;

procedure TfrmTefCitelAdministracao.btnConfirmarClick(Sender: TObject);
var
  dtaDataDigitada : TDateTime;
begin
  inherited;
  if fStrToFloat(Trim(edtValTra.Text)) = 0 then
  begin
    fMensagem('ATENÇÃO!', 'Valor inválido. Verifique!', ['&OK']);
    pSetFocus(edtValTra);
    Exit;
  end;

  if Trim(edtNumNsu.Text) = '' then
  begin
    fMensagem('ATENÇÃO!', 'Preencha o número do documento!', ['&OK']);
    pSetFocus(edtNumNsu);
    Exit;
  end;

  if not TryStrToDate(edtDtaTransacao.Text, dtaDataDigitada) then
  begin
    fMensagem('ATENÇÃO!', 'Verificar data da transação.!', ['&OK']);
    pSetFocus(edtDtaTransacao);
    Exit;
  end;

  if not fValidaCampos(edtNumNsu, False) then
    Exit ;

  case intTipoCar of
    1 :
    begin
      if edtDtaTransacao.Date <> Date then
      begin
        fMensagem('ATENÇÃO!', 'Cancelamento de transação de débito permitido somente no mesmo dia!', ['&OK']);
        pSetFocus(edtDtaTransacao);
        Exit;
      end;
    end;
    2 :
    begin
      if edtDtaTransacao.Date > Date then
      begin
        fMensagem('ATENÇÃO!', 'Verificar data da transação!', ['&OK']);
        pSetFocus(edtDtaTransacao);
        Exit;
      end;
    end;
  end;

  if edtDtaTransacao.Date > Date then
  begin
    fMensagem('ATENÇÃO!', 'Verificar data da transação!', ['&OK']);
    pSetFocus(edtDtaTransacao);
    Exit;
  end;

  pnDados.Enabled := False;

  if intTipo = 4 then
    pReimpressao
  else
  if intTipo = 5 then
    pCancelamento;

  pLimpaCampos;
  pHabilitaDados(False, intTipo);

  Self.Close;
end;

procedure TfrmTefCitelAdministracao.btnConfirmaReimpClick(Sender: TObject);
begin
  inherited;
  if cbTipoComp.ItemIndex = -1 then
  begin
    fMensagem('ATENÇÃO!', 'Selecione o tipo de comprovante!', ['&OK']);
    pSetFocus(cbTipoComp);
    Exit;
  end;

  if cbTipoComp.ItemIndex = 1 then
  begin
    pnReimpressao.Visible := False;
    pnDados.Visible       := True;

    pFocoCamposNcr ;
  end
  else
  begin
    edtValTra.Text := '0';
    pReimpressao;

    Self.Close;
  end;
end;

procedure TfrmTefCitelAdministracao.btnSairClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmTefCitelAdministracao.btnSairFechamentoClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmTefCitelAdministracao.btnVerTransPendentesClick(Sender: TObject);
begin
  inherited;
  try
    fChamaTelaGravando(fVerificaPendencias);
  finally
    Self.Enabled := True;
    SetForegroundWindow(Handle);

    Self.Close;
  end;
end;

procedure TfrmTefCitelAdministracao.cbTipoCompChange(Sender: TObject);
begin
  inherited;
  pSetFocus(btnConfirmaReimp);
end;

procedure TfrmTefCitelAdministracao.edtValTraClick(Sender: TObject);
begin
  inherited;
  edtValTra.SelStart := Length(edtValTra.Text);
end;

procedure TfrmTefCitelAdministracao.edtValTraKeyPress(Sender: TObject;
  var Key: Char);
  var
   Texto, Texto2: string;
   i: byte;
begin
  inherited;
  if CharInSet(Key,['0'..'9',chr(vk_back)]) then
  begin
    if (CharInSet(Key, ['0'..'9'])) then
      if (Length(Trim(edtValTra.Text))>23) then
        key := #0;

    Texto2 := '0';
    Texto := Trim(edtValTra.Text)+Key;
    for i := 1 to Length(Texto) do
      if CharInSet(Texto[i],['0'..'9']) then
        Texto2 := Texto2 + Texto[i];

    if key = chr(vk_back) then
       Delete(Texto2,Length(Texto2),1);

    Texto2 := FormatFloat('#,0.00',StrToInt64(Texto2)/100);

    repeat
       Texto2 := ' '+Texto2
    until Canvas.TextWidth(Texto2) >= edtValTra.Width;

    edtValTra.Text := Texto2;

    edtValTra.SelStart := Length(Texto2);
  end;

  Key := #0;
end;

procedure TfrmTefCitelAdministracao.FormCreate(Sender: TObject);
begin
  inherited;
  FOperacaoAndamento := False;
  btnPix.Visible := fMostrarOpcaoPix or (fCfgSis('PIXSCP', varString) = 'S') ;
  btnPix.Enabled := fMostrarOpcaoPix or (fCfgSis('PIXSCP', varString) = 'S') ;
  pTrocaCamposDeLugarNcr ;
end;

procedure TfrmTefCitelAdministracao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //inherited;
  if Key = Vk_Escape then
    if btnSairFechamento.Enabled then
      btnSairFechamentoClick(Sender);
end;

procedure TfrmTefCitelAdministracao.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if CharInSet(Key, [#49, #97]) then
    pTecla1Click;

  if CharInSet(Key, [#50, #98]) then
    pTecla2Click;

  if CharInSet(Key, [#51, #99]) then
    pTecla3Click;

  if CharInSet(Key, [#52, #100]) then
    pTecla4Click;

  if CharInSet(Key, [#53, #101]) then
    pTecla5Click;

  if CharInSet(Key, [#55, #103]) then
    pTecla7Click;

  if CharInSet(Key, [#57, #105]) then
    pTecla9Click;
end;

procedure TfrmTefCitelAdministracao.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnFoco);
  btnFoco.visible := False;
  edtValTra.Text := '0';

  btnCancelaTransacao.Visible := VS_blnTefCitel;
  btnCancelaTransacao.Enabled := VS_blnTefCitel;

  btnReimprimeTransacao.Visible := VS_blnTefCitel;
  btnReimprimeTransacao.Enabled := VS_blnTefCitel;

  btnRelatorioTef.Visible := ((fCfgSis('TEFCIT') = OPCAO_NCR) and (fCfgSis('RLTFHB') = 'S')) or (fCfgSis('TEFCIT') = OPCAO_CLISITEF);
  btnRelatorioTef.Enabled := btnRelatorioTef.Visible;
  pDesabilitaTefRelatorios ;

  if not VS_blnTefCitel then
  begin
    fMensagem('ATENÇÃO!', strMsgNaoEhTerminal, ['&OK']);
    pnMensTef.Caption := strMsgNaoEhTerminal;
    pnMensTef.Font.Color := clRed;
    pnMensTef.Font.Size := 8;
  end;
end;

procedure TfrmTefCitelAdministracao.pLimpaCampos;
begin
  edtNumNsu.Clear;
  edtValTra.Clear;
  edtDtaTransacao.Clear;
end;

function TfrmTefCitelAdministracao.fObteveDadosEspecificoComprovante(
  var AstrAutoInc: String; const AdtaDataComprovante: TDateTime;
  const AstrNsu: String; const AfltValor: Double): Boolean;
Var
  LqryComprovante : TUniQuery;
  LblnControle : Boolean;
begin
  AstrAutoInc := EmptyStr;

  LblnControle := fUsaControleScope(AdtaDataComprovante, AstrNsu) ;

  LqryComprovante := fCriaQuery(Self);
  Try
    LqryComprovante.Close;
    LqryComprovante.SQL.Clear;
    LqryComprovante.SQL.Add(' SELECT AUTOINCREM FROM TEFTRA ');
    LqryComprovante.SQL.Add(' WHERE TFT_DTATRA = :DTATRA ');
    LqryComprovante.SQL.Add('       AND ' + ifThen(LblnControle, 'TFT_CONTRO', 'TFT_NUMNSU') + ' = :NUMNSU ');
    LqryComprovante.SQL.Add('       AND TFT_VALTRA = :VALTRA ');

    if fCfgSis('TEFCIT', varString) <> OPCAO_NCR then
      LqryComprovante.SQL.Add('       AND TRIM(COALESCE(TFT_COMIMP, "")) <> "" ')
    else
      LqryComprovante.SQL.Add('       AND ( (TRIM(COALESCE(TFT_COMIMP, "")) <> "") OR (TRIM(COALESCE(TFT_COMAUX, "")) <> "") ) ') ;

    LqryComprovante.ParamByName('DTATRA').AsDateTime := AdtaDataComprovante ;
    LqryComprovante.ParamByName('NUMNSU').AsString := ifThen(LblnControle, AstrNsu, fPadL(AstrNsu, 14, '0')) ;
    LqryComprovante.ParamByName('VALTRA').AsFloat := AfltValor ;
    LqryComprovante.Open;

    If (Not LqryComprovante.IsEmpty) Then
      AstrAutoInc := LqryComprovante.FieldByName('AUTOINCREM').AsString;

    Result := (Not fEmptyStr(AstrAutoInc));
  Finally
    FreeAndNil(LqryComprovante);
  End;
end;

function TfrmTefCitelAdministracao.fObteveDadosUltimoComprovante(var AstrAutoInc: String): Boolean;
  Var
    qryUltimoComprovante : TUniQuery;
begin
  AstrAutoInc := EmptyStr;
  qryUltimoComprovante := fCriaQuery(Self);
  Try
    qryUltimoComprovante.Close;
    qryUltimoComprovante.SQL.Clear;
    qryUltimoComprovante.SQL.Add(' SELECT TFT_NUMNSU, TFT_VALTRA, TFT_DTATRA, TFT_DESTRA, AUTOINCREM ');
    qryUltimoComprovante.SQL.Add(' FROM TEFTRA ');
    qryUltimoComprovante.SQL.Add(' WHERE TFT_CODEMP = :CODEMP ');
    qryUltimoComprovante.SQL.Add(' AND TFT_NUMTER = :NUMTER ');
    qryUltimoComprovante.SQL.Add(' AND TFT_DTATRA = CURRENT_DATE ');
    qryUltimoComprovante.SQL.Add(' ORDER BY TFT_NUMDOC DESC ');
    qryUltimoComprovante.SQL.Add(' LIMIT 1  ');
    qryUltimoComprovante.ParamByName('CODEMP').AsString := VS_strCodEmp ;
    qryUltimoComprovante.ParamByName('NUMTER').AsString := VS_NumTerTef ;
    qryUltimoComprovante.Open;

    If (Not qryUltimoComprovante.IsEmpty) Then
      AstrAutoInc := qryUltimoComprovante.FieldByName('AUTOINCREM').AsString;

    Result := (Not fEmptyStr(AstrAutoInc));
  Finally
    FreeAndNil(qryUltimoComprovante);
  End;
end;

function TfrmTefCitelAdministracao.fReimpressao : Boolean;
var
  LstrConteudoViaCliente: string;
  LstrConteudoViaLojista: string;
  LstrAutoInc: String;
  LMensagem: string;
  LStatus: string;
  LResult: Boolean;
  LOption: Integer;
begin
  Result := False;
  LstrConteudoViaCliente := '' ;
  LstrConteudoViaLojista := '' ;
  LstrAutoInc := EmptyStr ;
  LMensagem := EmptyStr;
  LStatus := EmptyStr;
  LOption := cbTipoComp.ItemIndex;

  case LOption of
    0: LResult := fObteveDadosUltimoComprovante(LstrAutoInc);
    1: LResult := fObteveDadosEspecificoComprovante(LstrAutoInc, edtDtaTransacao.Date, edtNumNsu.Text, fStrToFloat(edtValTra.Text));
  else
    begin
      fMensagem('ATENÇÃO!', 'Opção inválida no campo "Tipo de Comprovante".', ['&OK']);
      Exit;
    end;
  end;

  if not LResult then
  begin
    if LOption = 0 then
      LMensagem := 'Não foi possível obter o último comprovante. Selecione a opção "demais comprovantes" e informe os dados da transação.';

    if LOption = 1 then
      LMensagem := 'Não é possível recuperar dados do comprovante!';

    fMensagem('ATENÇÃO!', LMensagem, ['&OK']);
    Exit;
  end
  else
  begin
    LStatus := fObterStatusLocalDoComprovante(LstrAutoInc);
    if (LStatus <> EmptyStr) and (LStatus = 'PENDENTE') then
    begin
      LMensagem := 'Não é possível imprimir comprovante de transação que tenha ficado Pendente de Confirmação/Cancelamento,' + sLineBreak +
                     'mesmo que o respectivo tratamento já tenha sido efetuado.';
      fMensagem('ATENÇÃO!', LMensagem, ['&OK']);
      exit ;
    end ;
  end ;

  pPreparaDadosReimpressaoViaTefTra(LstrAutoInc,
                                    LstrConteudoViaCliente,
                                    LstrConteudoViaLojista,
                                    LMensagem);

  LResult := not fEmptyStr(LstrConteudoViaCliente);
  if LResult then
  begin
    Result := fImpCupom(LstrConteudoViaCliente, LstrConteudoViaLojista);
    Exit;
  end;

  if not fEmptyStr(LMensagem) then
   fMensagem('ATENÇÃO!', LMensagem, ['&OK']);

end;

function TfrmTefCitelAdministracao.fObterStatusLocalDoComprovante(const AstrAutoInc: String): string;
var
  LConsulta: TUniQuery;
  LSQL: string;
begin
  Result := '';
  LConsulta := fCriaQuery();
  try
    LSQL := 'SELECT TFT_STATUS FROM TEFTRA '  + sLineBreak +
            'WHERE AUTOINCREM = :AUTOINCREM '   ;

    LConsulta.SQL.Clear;
    LConsulta.SQL.Text := LSQL;
    LConsulta.ParamByName('AUTOINCREM').AsString := AstrAutoInc;
    LConsulta.Open;
    Result := UpperCase(LConsulta.FieldByName('TFT_STATUS').AsString);
  finally
    FreeAndNil(LConsulta);
  end;
end;

function TfrmTefCitelAdministracao.fRetornaCarteiraDigitalSelecionada(
  const AarrCarDig: Array Of String): integer;
begin
  Result := 0 ;
  if Length(AarrCarDig) > 1 then
  begin
    Result := fGetMenu('Carteiras Digitais', AarrCarDig, 0, True);
  end
  else if Length(AarrCarDig) = 1 then
  begin
    Result := 1 ;
  end ;
end;

function TfrmTefCitelAdministracao.fRetornaDescricaoCarteiraDigital: string;
var
  LintCnt: integer ;
begin
  if fCfgSis('PIXSCP', varString) = 'S' then
  begin
    result := fstrEspaco('Pix', 24) ;
    exit;
  end;
  LintCnt := fCampoTabela('COUNT(*)', 'CARDIG', [], []) ;
  if LintCnt > 1 then
  begin
    result := 'Carteira Digital' ;
  end
  else
  begin
    result := fstrEspaco(fCampoTabela('DIG_DESCRI', 'CARDIG', [], []), 24) ;
  end ;
end;

function TfrmTefCitelAdministracao.fCancelamento : Boolean;
var
  RetornoTEFCitel: IRetornoTEFCitel;
  strDtaEstorno : String;
  LstrCarDig: String;
  LqryCarDig: TUniQuery;
  LarrMenu  : Array Of String;
  LintCount : integer ;
  LstrCarDigSel : String ;
begin
  Result := False;

  if fVerificaTransacaoJaEstornada(edtNumNsu.Text, edtDtaTransacao.Date, strDtaEstorno) then
  begin
    fMensagem('ATENÇÃO!', 'Essa transação consta como cancelada/estornada em '+strDtaEstorno+' pelo ADM TEF. '+
                          #13+ 'Verifique relatório do TEF!', ['&OK']);
    Exit;
  end;

  LstrCarDig := fRetornaCarteiraDigital(edtNumNsu.Text, edtDtaTransacao.Date, fStrToFloat(edtValTra.Text)) ;
  if not fEmptyStr(LstrCarDig) then
  begin
    LstrCarDig := '{CarteirasDigitaisHabilitadas=' + LstrCarDig + '}' ;
  end
  else
  begin
    if intTipoCar = CARTEIRA_DIGITAL_ESTORNO then
    begin
      if fCfgSis('PIXSCP', varString) = 'S' then
      begin
        LstrCarDig := '{CarteirasDigitaisHabilitadas=001}' ;
      end
      else
      begin
        SetLength(LarrMenu,0);
        LqryCarDig := fCriaQuery;
        try
          LqryCarDig.Close ;
          LqryCarDig.SQL.Clear ;
          LqryCarDig.SQL.Add('SELECT DIG_CARDSE, DIG_DESCRI FROM CARDIG ORDER BY DIG_ORDEM_') ;
          LqryCarDig.Open ;
          LqryCarDig.First ;
          while not LqryCarDig.Eof do
          begin
            SetLength(LarrMenu,Succ(Length(LarrMenu)));
            LarrMenu[High(LarrMenu)] := LqryCarDig.FieldByName('DIG_DESCRI').asString ;
            LqryCarDig.Next ;
          end ;
          LintCount := fRetornaCarteiraDigitalSelecionada(LarrMenu);
          If LintCount > 0 Then
          begin
            LstrCarDigSel :=  LarrMenu[Pred(LintCount)];
            LqryCarDig.Locate('DIG_DESCRI', LstrCarDigSel, []) ;
            LstrCarDig := '{CarteirasDigitaisHabilitadas=' + LqryCarDig.FieldByName('DIG_CARDSE').asString + '}' ;
          end
          else
          begin
            fMensagem('ATENÇÃO!', 'Operação cancelada! ', ['&OK']);
            exit ;
          end ;
        finally
          FreeAndNil(LqryCarDig) ;
        end ;
      end;
    end
    else // outras formas de estorno
    begin
      LstrCarDig := '' ;
    end ;
  end ;

  RetornoTEFCitel :=  fCancelamentoNormal(strLoginUsuarioLogado,
                                          edtDtaTransacao.Date,
                                          nOw,
                                          edtNumNsu.Text,
                                          fStrToFloat(edtValTra.Text),
                                          IntToStr(intTipoCar),
                                          '',
                                          LstrCarDig);

  if Assigned(RetornoTEFCitel) then
  begin
    Result := True;
    fMensagem('ATENÇÃO!', 'Transação cancelada com sucesso!'+#13+
                          'Necessário verificar se o ajuste/estorno financeiro desse cancelamento foi realizado no Resumo de Caixa.', ['&OK']);
  end;
end;

function TfrmTefCitelAdministracao.fVerLiberacaoCancelamento: Boolean;
begin
  objLiberacao := TLiberacao.Create;
  try
    Result := True;
    If Not fVerificaAcessoSistema('CARCANCEFET', strLoginUsuarioLogado) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddSeparador(106);
      objLiberacao.objMsgLibera.pAddTexto('Efetuar cancelamento de transação realizada pelo TEF');
      objLiberacao.objMsgLibera.pAddTextoCaption('Tipo...........: ', 'DÉBITO / CRÉDITO / PIX / CARTEIRA DIGITAL', 23);

      objLiberacao.strDirAce := 'CARCANCEFET';
      objLiberacao.strMsgSen := 'Cancelamento de cartões';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddSeparador(106);

      If (Not objLiberacao.fLibera) Then
        Result := False;
    End;
  finally
    FreeAndNil(objLiberacao);
  End;
end;

function TfrmTefCitelAdministracao.fVerLiberacaoReImpressao: Boolean;
begin
  objLiberacao := TLiberacao.Create;
  try
    Result := True;
    If Not fVerificaAcessoSistema('CARREIMPFET', strLoginUsuarioLogado) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddSeparador(106);
      objLiberacao.objMsgLibera.pAddTexto('Efetuar reimpressão de transação realizada pelo TEF');
      objLiberacao.objMsgLibera.pAddTextoCaption('Tipo...........: ', 'DÉBITO / CRÉDITO / PIX / CARTEIRA DIGITAL', 23);

      objLiberacao.strDirAce := 'CARREIMPFET';
      objLiberacao.strMsgSen := 'Reimpressão de cartões';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddSeparador(106);

      If (Not objLiberacao.fLibera) Then
        Result := False;
    End;
  finally
    FreeAndNil(objLiberacao);
  End;
end;

procedure TfrmTefCitelAdministracao.pCancelamento;
begin
  tmrAtualizaMsg.Enabled := True;
  fCancelamento;
  tmrAtualizaMsg.Enabled := False;
end;

procedure TfrmTefCitelAdministracao.pDesabilitaTefRelatorios;
begin
  if fCfgSis('TEFCIT') = OPCAO_NCR then
    btnRelatorioTef.Enabled := False ;
end;

function TfrmTefCitelAdministracao.fConsultaControleNcr(const AstrControle: String; const AfltValorDig: Double; const AdtaDataDig: TDate): TConsultaControleNcr;
var
  LqryConsulta: TUniQuery ;
begin
  Result.fltValor := 0;
  Result.dtaData := 0;
  Result.blnMaisDeUm := False;
  Result.blnOk := False;

  if fCfgSis('TEFCIT', varString) <> OPCAO_NCR then
    Exit ;

  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add('SELECT TFT_VALTRA, TFT_DTATRA FROM TEFTRA WHERE TFT_CONTRO = :CONTRO AND TFT_CODEMP = :CODEMP ;') ;
    LqryConsulta.ParamByName('CONTRO').AsString := AstrControle ;
    LqryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp ;
    LqryConsulta.Open ;

    Result.blnOk := True ;
    Result.blnMaisDeUm := LqryConsulta.RecordCount > 1;

    while not LqryConsulta.Eof do
    begin
      Result.fltValor := LqryConsulta.FieldByName('TFT_VALTRA').AsFloat ;
      Result.dtaData := LqryConsulta.FieldByName('TFT_DTATRA').AsDateTime ;

      if Result.blnMaisDeUm and (Result.fltValor = AfltValorDig) and (Result.dtaData = AdtaDataDig) then
        break;

      LqryConsulta.Next;
    end;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end;

procedure TfrmTefCitelAdministracao.pFocoCamposNcr;
begin
  if fCfgSis('TEFCIT', varString) = OPCAO_NCR then
    pSetFocus(edtNumNsu)
  else
    pSetFocus(edtValTra);
end;

procedure TfrmTefCitelAdministracao.pHabilitaDados(blnHabilita : Boolean; intTipo : Integer);
begin
  if blnHabilita then
  begin
    if intTipo = 5 then
    begin
      pnDados.Visible        := True;
      pnCancelamento.Visible := False;
    end
    else
    begin
      pnDados.Visible        := True;
      pnReimpressao.Visible  := False;
    end;

    pFocoCamposNcr ;
  end
  else
  begin
    if intTipo = 5 then
    begin
      pnDados.Visible        := False;
      pnCancelamento.Visible := True;
    end
    else
    begin
      pnDados.Visible        := False;
      pnReimpressao.Visible  := True;
    end;
  end;
end;

function TfrmTefCitelAdministracao.fVerificaPendencias(
  pgbProgresso: TcxProgressBar): Boolean;
  var
    intCont : integer;
  const
    intQtdMax = 2;
begin
  intCont := 1;

  pgbProgresso.Properties.Max := intQtdMax;

  pgbProgresso.Position       := intCont;
  Application.ProcessMessages;

  Inc(intCont);

  Application.ProcessMessages;
  pgbProgresso.Position       := intCont;
  Application.ProcessMessages;
  if not fVerificaPendenciasTEFCitel then
  begin
    Result := False;
    fMensagem('ATENÇÃO!', 'Atenção! Sem transação pendente de tratamento.', ['&OK']);
    Self.Close;
  end
  else
    Result := True;
end;

function TfrmTefCitelAdministracao.fVerificaTransacaoJaEstornada(strNumNsu : String;
                                                                 dtaDtaTra : TDate;
                                                                 out strDtaEstorno : String) : Boolean;
  var
    qryTefTra : TUniQuery;
    strSeqCon : String;
    LblnControle: Boolean ;
begin
  Result := False;

  LblnControle := fUsaControleScope(edtDtaTransacao.Date, edtNumNsu.Text) ;

  qryTefTra := fCriaQuery(Self);
  try
    qryTefTra.Close;
    qryTefTra.SQL.Clear;
    qryTefTra.SQL.Add(' SELECT ' +
             '   TFT_SEQCON ' +
             ' FROM ' +
             '   TEFTRA ' +
             ' WHERE ' +
             '   TFT_DTATRA = :DTATRA ' +
             ' AND ' +
             '   ' + ifThen(LblnControle, 'TFT_CONTRO', 'TFT_NUMNSU') + ' = :NUMNSU ' +
             ' AND ' +
             '   TFT_CODEMP = :CODEMP '+
             ' AND '+
             '   TFT_STATUS = ''ESTORNADA'' ');
    qryTefTra.ParamByName('DTATRA').AsDate   := edtDtaTransacao.Date;
    qryTefTra.ParamByName('NUMNSU').AsString := ifThen(LblnControle, edtNumNsu.Text, fPadL(edtNumNsu.Text, 14, '0'));
    qryTefTra.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTefTra.Open;

    if not qryTefTra.IsEmpty then
    begin
      strSeqCon := qryTefTra.FieldByName('TFT_SEQCON').AsString;

      qryTefTra.Close;
      qryTefTra.SQL.Clear;
      qryTefTra.SQL.Add(' SELECT');
      qryTefTra.SQL.Add('   TFT_DTATRA');
      qryTefTra.SQL.Add(' FROM');
      qryTefTra.SQL.Add('   TEFTRA');
      qryTefTra.SQL.Add(' WHERE ');
      qryTefTra.SQL.Add('   TFT_SEQCON = :SEQCON');
      qryTefTra.ParamByName('SEQCON').AsString := strSeqCon;
      qryTefTra.Open;

      strDtaEstorno := qryTefTra.FieldByName('TFT_DTATRA').AsString;

      Result := True;
    end;
  finally
    FreeAndNil(qryTefTra);
  end;

end;

procedure TfrmTefCitelAdministracao.AtualizaTefCitel(ARetorno: IRetornoTEFCitel);
  var
    FrmTefCitelInfoMsg : TFrmTefCitelInfoMsg;
    LstrNovoNumDoc: String ;
begin
  if ARetorno.StatusTEF.strStatus = '' then
    Exit;

  blnPermiteSair := False;

  case StrToInt(ARetorno.StatusTEF.strStatus) of
    INFO_20_CANCELAMENTO:
    begin
      if fVerificaMsgTefCitel(ARetorno.StatusTEF.strMensagem) then
      begin
        pCriarFormularios(TFrmTefCitelInfoMsg, FrmTefCitelInfoMsg);
        try
          FrmTefCitelInfoMsg.strStatus           := ARetorno.StatusTEF.strStatus;
          FrmTefCitelInfoMsg.lbStatusTef.Caption := ARetorno.StatusTEF.strMensagem;
          FrmTefCitelInfoMsg.ShowModal;
        finally
          pFreeAndNil(FrmTefCitelInfoMsg);
        end
      end
      else
      begin
        pnMensTef.Font.Color := clRed;
        pnMensTef.Caption    := ARetorno.StatusTEF.strMensagem;
        pnMensTef.Refresh;
      end;
    end;
    INFO_21_CANCELAMENTO: exit;
    INFO_23_CANCELAMENTO: exit;
    INFO_30_CANCELAMENTO: exit;
    INFO_34_CANCELAMENTO: exit;
    INFO_131_CANCELAMENTO: exit;
    INFO_999_CANCELAMENTO:
    begin
      LstrNovoNumDoc := fRetNumDocTransacaoTef;
      pGravaTransacaoErro(LstrNovoNumDoc, fStrToFloat(edtValTra.Text)) ;
      fMensagem('ATENÇÃO!', ARetorno.StatusTEF.strMensagem, ['&Ok']);
    end;
    else
    if StrToInt(ARetorno.StatusTEF.strStatus) < 0 then
    begin
      blnPermiteSair := False;
      if fVerificaMsgTefCitel(ARetorno.StatusTEF.strMensagem) then
        fMensagem('ATENÇÃO!', ARetorno.StatusTEF.strMensagem, ['&Ok']);
    end
    else
    begin
      blnPermiteSair := False;
      if StrToInt(ARetorno.StatusTEF.strStatus) > 0 then
        fMensagem('ATENÇÃO!', ARetorno.StatusTEF.strMensagem, ['&Ok']);
    end;
  end;
end;

procedure TfrmTefCitelAdministracao.pReimpressao;
begin
  fReimpressao;
end;

procedure TfrmTefCitelAdministracao.pTecla1Click;
begin
  if pnCancelamento.Visible then
    btnCreditoClick(Self)
  else
  if pnReimpressao.Visible then
    btnConfirmaReimpClick(Self);
end;

procedure TfrmTefCitelAdministracao.pTecla2Click;
begin
  if pnCancelamento.Visible then
    btnDebitoClick(Self);
end;

procedure TfrmTefCitelAdministracao.pTecla3Click;
begin
  if (pnCancelamento.Visible) and (btnPix.Visible) then
    btnPixClick(Self);
end;

procedure TfrmTefCitelAdministracao.pTecla4Click;
begin
  if pnMenu.Enabled and btnReimprimeTransacao.Enabled then
    btnReimprimeTransacaoClick(Self);
end;

procedure TfrmTefCitelAdministracao.pTecla5Click;
begin
  if pnMenu.Enabled and btnCancelaTransacao.Enabled then
    btnCancelaTransacaoClick(Self);
end;

procedure TfrmTefCitelAdministracao.pTecla7Click;
begin
  if pnMenu.Enabled and btnRelatorioTef.Enabled then
    btnRelatorioTef.Click;
end;

procedure TfrmTefCitelAdministracao.pTecla9Click;
begin
  if fVerificaMsgInsiraCartao(pnMensTef.Caption) then
    ObjTefCitel.pSair(True)
  else
  begin
    case intTipo of
      4 :
      begin
        if pnReimpressao.Visible then
          btnEncerraReimpClick(Self);
      end;
      5 :
      begin
        if pnCancelamento.Visible then
          btnEncerraClick(Self);
      end;
    end;
  end;
end;

procedure TfrmTefCitelAdministracao.pTrocaCamposDeLugarNcr;
var
  LintTopLblNumNsu, LintTopEdtNumNsu: Integer ;
begin
  if fCfgSis('TEFCIT', varString) <> OPCAO_NCR then
    Exit ;

  LintTopLblNumNsu := lblNumNsu.Top ;
  LintTopEdtNumNsu := edtNumNsu.Top ;

  lblNumNsu.Top := lblTotalBruto.Top ;
  lblNumNsu.Caption := 'Controle' ;
  edtNumNsu.Top := edtValtra.Top ;

  lblTotalBruto.Top := LintTopLblNumNsu ;
  edtValTra.Top := LintTopEdtNumNsu ;

  edtNumNsu.TabOrder := 0 ;
  edtValTra.TabOrder := 1 ;
  edtDtaTransacao.TabOrder := 2 ;
end;

procedure TfrmTefCitelAdministracao.tmrAtualizaMsgTimer(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
end;

function TfrmTefCitelAdministracao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  LfltAuxValor: Double;
  LConsultaControleNcr: TConsultaControleNcr;
begin
  Result := True;

  If (Sender = edtNumNsu) Then
  Begin
    LfltAuxValor := fStrToFloat(edtValTra.Text);
    LConsultaControleNcr := fConsultaControleNcr(edtNumNsu.Text, LfltAuxValor, edtDtaTransacao.Date);
    if LConsultaControleNcr.blnOk then
    begin
      if (LConsultaControleNcr.fltValor = 0) and (blnBuscaPorChave) then
      begin
        edtValTra.Clear ;
        edtDtaTransacao.Clear ;
        Result := True ;
        exit ;
      end ;

      // valida os valores somente se cancelamento
      if intTipo = 5 then
      begin
        if (LConsultaControleNcr.fltValor <> 0) and (LfltAuxValor <> 0) and (LfltAuxValor <> LConsultaControleNcr.fltValor) then
        begin
          if LConsultaControleNcr.blnMaisDeUm then
            fMensagem('ATENÇÃO!', 'Não foi encontrada nenhuma transação com o valor e a data informados.', ['&OK'])
          else
            fMensagem('ATENÇÃO!', 'Valor da transação divergente, esperado ['+FormatCurr('##0.00', LConsultaControleNcr.fltValor)+'] encontrado ['+FormatCurr('##0.00', LfltAuxValor)+']! ', ['&OK']) ;
          Result := False ;
        end ;

        if (LConsultaControleNcr.dtaData > 0) and (edtDtaTransacao.Date > 0) and (edtDtaTransacao.Date <> LConsultaControleNcr.dtaData) then
        begin
          if LConsultaControleNcr.blnMaisDeUm then
            fMensagem('ATENÇÃO!', 'Não foi encontrada nenhuma transação com o valor e data informados.', ['&OK'])
          else
            fMensagem('ATENÇÃO!', 'Data da transação divergente, esperado ['+DateToStr(LConsultaControleNcr.dtaData)+'] encontrado ['+DateToStr(edtDtaTransacao.Date)+']! ', ['&OK']) ;
          Result := False ;
        end ;
      end ;

      if (Result) and (blnBuscaPorChave) then
      begin
        if not LConsultaControleNcr.blnMaisDeUm then
        begin
          edtValTra.Text := FormatCurr('##0.00', LConsultaControleNcr.fltValor) ;
          edtDtaTransacao.Date := LConsultaControleNcr.dtaData ;
        end;

        if (LConsultaControleNcr.blnMaisDeUm) and (LfltAuxValor = 0) and (edtDtaTransacao.Date <= 0) then
        begin
          fMensagem('ATENÇÃO!', 'Foi encontrado mais de um registro com o mesmo número de controle.'
                    + #13 + 'Por favor, informar manualmente o valor e a data da transação desejada.', ['&OK']) ;
        end;
      end ;
    end ;
  end ;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmTefCitelAdministracao.fVerificaMsgInsiraCartao(strMsg : String) : Boolean;
begin
  Result := False;

  if strMsg = strMsgPassaCartao then
    Result := True;

  if strMsg = strMsgAproxeCartao then
    Result := True;
end;

end.
