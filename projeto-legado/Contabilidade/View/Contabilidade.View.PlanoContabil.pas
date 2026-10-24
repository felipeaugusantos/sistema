unit Contabilidade.View.PlanoContabil;

interface

uses
  Windows, Controls, Forms, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  DBEditFocus, AppEvnts, DB, BitBtnLockedIncrem, Mask, DBCtrls, Menus, Classes,
  frxClass, frxExportCSVTestabilidade, Contabilidade.View.TfrmPaiCadContabilidade, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxGroupBox, cxRadioGroup, cxDBEdit, ComboBoxFocus, MemDS, DBAccess, Uni,
  Contabilidade.Classes.TValidaProcessoContaContabil, Contabilidade.Interfaces;

type
  TfrmPlanoContabil = class(TfrmPaiCadContabilidade)
    pnlCentral: TPanel;
    dtsPlaNco: TDataSource;
    pnlContaRef: TPanel;
    pnlCampos: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label101: TLabel;
    dbeDescri: TDBEditFocus;
    dbeConta: TDBEditFocus;
    dbeConRed: TDBEditFocus;
    dbeTplAco: TDBEditFocus;
    edtDescricaoDoTipoDePlanoDeContaContabil: TEditFocus;
    dbcApurac: TDBCheckBox;
    lblContaRef: TLabel;
    dbeCtaRef: TDBEditFocus;
    edtDescricaoCtaRef: TEditFocus;
    pnlNatAju: TPanel;
    lblNatAju: TLabel;
    edtDescricaoNatAjuste: TEditFocus;
    dbeNatAju: TDBEditFocus;
    pnlAjuLiq: TPanel;
    lblAjuLiq: TLabel;
    cbxAjuLiq: TComboBoxFocus;
    btnAjudaAjustes: TBitBtnLocked;
    pnlCompl: TPanel;
    dbrgNature: TcxDBRadioGroup;
    dbrgFinali: TcxDBRadioGroup;
    dbrgRedutora: TcxDBRadioGroup;
    dbrgPatrimonial: TcxDBRadioGroup;
    pnlVigencia: TPanel;
    Label4: TLabel;
    dbeDtaIni: TDBEditFocus;
    Label5: TLabel;
    dbeDtaFin: TDBEditFocus;
    pnlSubCnt: TPanel;
    dbrgSubcontas: TcxDBRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCtaRefKeyPress(Sender: TObject; var Key: Char);
    procedure dbeNatAjuKeyPress(Sender: TObject; var Key: Char);
    procedure dbrgNaturePropertiesEditValueChanged(Sender: TObject);
    procedure cbxAjuLiqChange(Sender: TObject);
    procedure dtsPlaNcoDataChange(Sender: TObject; Field: TField);
    procedure dbeContaExit(Sender: TObject);
  private
    { Private declarations }
    strConRed: String;
    blnExpECD: Boolean;
    FblnNCO_SUBCNT: Boolean;
    intLenConRed: Integer;
    blnInclusao: Boolean;
    FstrTPlacoEmpLog: string;
    FstrDescTPlacoEmpLog: string;
    FValorCfgCrdCon: string;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pCarregaCampos;
    procedure pCarregaJusteLucroLiquido;
    function fContaReduzidaAutomatica : boolean;
    function fInserindoContaReduzidaAutomatica: boolean;
    function fgetNovaContaReduzida: string;
    function fUtilizaAjusteLucroLiq: boolean;
    procedure pHabitaCamposVigencia(const blnHabilitar:boolean) ;
    procedure pDesabilitaNaturezaAjuste(const AOpcao:string) ;
    procedure pAjustaCamposConta(const ADados: TDadosCamposConta);
    procedure pDesfixaCamposConta;
    function fValidaCamposConta: Boolean;
    procedure pGravaNullChaveEstrangeiraQuandoVazia ;
    procedure pAjustaRefPontos;
  protected
    procedure pInicializaIndices; override;
    function fVerificaContaEmUso(const AConta, ATplaco: String): Boolean ;
    procedure pLigaDesligaFkPlanco(const AStatus: TFkPlanco) ;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fExecutaAntesDoDelete : Boolean; override;
  public
    { Public declarations }
  end;

var
  frmPlanoContabil: TfrmPlanoContabil;

implementation

uses untTypesSistema, Contabilidade.Funcoes,
     untFuncoesSimples, Contabilidade.Consultas, StrUtils,
     SysUtils, System.MaskUtils,
  Contabilidade.Classes.TControleContabilidade,
  Contabilidade.Classes.UniQueryAuditoria;

{$R *.dfm}

function fCfgDescup: string;
begin
  result := 'N' ;
  if fConfiguracaoExiste('DESCUP') then
  begin
    result := fCfgSis('DESCUP') ;
  end;
end;

procedure TfrmPlanoContabil.FormCreate(Sender: TObject);
begin
  inherited;
  FValorCfgCrdCon := '';
  if fConfiguracaoExiste('CRDCON') then
    FValorCfgCrdCon := fCfgSis('CRDCON');

  strNomeTabela     := 'PLANCO';
  strNomeCampo      := 'NCO_CODCON';
  qryTabela         := fCriaQueryContabilidade('PLANCO', Self.Name, Self);
  qryTabela.SQL.Text := 'SELECT * FROM PLANCO';
  dtsPlaNco.DataSet := qryTabela;
  FblnNCO_SUBCNT := fCampoExiste('PLANCO', 'NCO_SUBCNT') ;

  pnlNatAju.Visible   := fUtilizaNaturezaDoAjuste;
  pnlAjuLiq.Visible   := fUtilizaAjusteLucroLiq;
  pnlSubCnt.Visible   := fCfgDesmembrarSubContaCliFor = 'S' ;
  pnlVigencia.Visible := False ;
  if fTemVigencia then
  begin
    pnlVigencia.Visible := True;
    dbeDtaIni.DataField := 'NCO_DTAINI' ;
    dbeDtaFin.DataField := 'NCO_DTAFIN' ;
  end;

  dbeNatAju.DataField := IIF(pnlNatAju.Visible, 'NCO_NATAJU', '');

  qryTabela.AfterOpen := pAfterOpen;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeConta;
  arrCamposChave[1] := dbeTplAco;
  if fCfgExpEcd = 'S' then
  begin
    blnExpECD := True;
  end
  else
  begin
    blnExpECD := False;
    dbeCtaRef.DataField := '';
  end;

  if fCfgCtrnum = 'S' then
  begin
    dbeConRed.TipoTexto := DBEditFocus.TControlTipoTexto(DBEditFocus.TTipoTexto.ttNumerico) ;
  end;


  btnAjudaAjustes.Hint := '» NUNCA: Caso a conta não represente um ajuste no lucro líquido.'+ #13 +
                          '» SEMPRE: Serão considerados todos os lançamentos que contém a conta como contra partida.';
  if fCfgDescup = 'S' then
  begin
    dbeDescri.CharCase := ecNormal ;
  end;

  if not FblnNCO_SUBCNT then
    dbrgSubcontas.DataBinding.DataField := '';

  intLenConRed := fCfgSis('CRDTAM', varInteger);
  blnInclusao := False;

  dbeTplAco.ReadOnly := True;
  FstrTPlacoEmpLog := fRetTplacoEmpresaLogada;
  FstrDescTPlacoEmpLog := TValidaProcessoContaContabil.fCarregaDescricaoDoTipoDePlanoDeContaContabil(FstrTPlacoEmpLog);
end;

procedure TfrmPlanoContabil.FormShow(Sender: TObject);
begin
  inherited;
  pnlContaRef.Visible := blnExpECD;

  If Not pnlContaRef.Visible Then
    Self.ClientHeight := Self.ClientHeight - pnlContaRef.Height;

  If Not pnlCompl.Visible Then
    Self.ClientHeight := Self.ClientHeight - pnlCompl.Height;

  If Not pnlNatAju.Visible Then
    Self.ClientHeight := Self.ClientHeight - pnlNatAju.Height;

  If Not pnlAjuLiq.Visible Then
    Self.ClientHeight := Self.ClientHeight - pnlAjuLiq.Height;

  If Not pnlVigencia.Visible Then
    Self.ClientHeight := Self.ClientHeight - pnlVigencia.Height;
end;

procedure TfrmPlanoContabil.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaCampos;
  pHabitaCamposVigencia(False) ;
  pDesfixaCamposConta;
  blnInclusao := False;
end;

procedure TfrmPlanoContabil.btnExcluirClick(Sender: TObject);
begin
  if fVerificaContaEmUso(dbeConta.Text, dbeTplAco.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Conta do plano contábil ['+dbeConta.Text+'] em uso nas tabelas da contabilidade!', ['&OK']);
    exit ;
  end ;

  try
    inherited;
  finally
    pLigaDesligaFkPlanco(pLiga) ;
  end ;

  pCarregaCampos;
end;

procedure TfrmPlanoContabil.btnGravarClick(Sender: TObject);
var
  strContaReduzida: string ;
  strSugestao: string ;
  recDadosValidacao: TDadosValidacaoContaContabil ;
begin

  if (fInserindoContaReduzidaAutomatica) then
  begin
    strContaReduzida := fgetNovaContaReduzida ;
    if fEmptyStr(strContaReduzida) then
    begin
      strSugestao := fCampoTabela('MAX(CAST(NCO_CONRED AS SIGNED))+1', 'PLANCO', [], []) ;
      fMensagem('ATENÇÃO!', 'Não foi possível calcular o valor automático da conta reduzida!'+#13+'Ajuste o valor da CFG_CRDSEQ para '+strSugestao+' em " > Útil > Configuração do Sistema"', ['&OK']);
      exit ;
    end;

    qryTabela.FieldByName('NCO_CONRED').AsString := strContaReduzida ;
  end;

  If pnlAjuLiq.Visible Then
  Begin
    Case cbxAjuLiq.ItemIndex Of
      0 : qryTabela.FieldByName('NCO_AJULIQ').AsString := 'N';
      1 : qryTabela.FieldByName('NCO_AJULIQ').AsString := 'S';
    End;
  End;

  pGravaNullChaveEstrangeiraQuandoVazia ;

  recDadosValidacao.AContaContabil := dbeConta.Field.AsString;
  recDadosValidacao.ATpLaco := dbeTplAco.Field.AsString;
  if fTemVigencia then
  begin
    recDadosValidacao.AInicio := qryTabela.FieldByName('NCO_DTAINI').AsDateTime;
    recDadosValidacao.AFinal := qryTabela.FieldByName('NCO_DTAFIN').AsDateTime;
  end;
  recDadosValidacao.AAutoInc := qryTabela.FieldByName('AUTOINCREM').AsString;
  recDadosValidacao.AApurac := qryTabela.FieldByName('NCO_APURAC').AsString;
  recDadosValidacao.AContaRef := qryTabela.FieldByName('NCO_CTAREF').AsString;
  recDadosValidacao.ADescricaoConta := qryTabela.FieldByName('NCO_DESCRI').AsString;
  recDadosValidacao.ANatureza := qryTabela.FieldByName('NCO_NATURE').AsString;
  recDadosValidacao.AFinalidade := qryTabela.FieldByName('NCO_FINALI').AsString;
  recDadosValidacao.ARedutora := qryTabela.FieldByName('NCO_REDUTO').AsString;
  if fUtilizaNaturezaDoAjuste then
  begin
    recDadosValidacao.ANatAju := qryTabela.FieldByName('NCO_NATAJU').AsString;
  end;
  if fUtilizaAjusteLucroLiq then
  begin
    recDadosValidacao.AAjuLiq := cbxAjuLiq.Text;
  end;
  recDadosValidacao.APatrimonial := qryTabela.FieldByName('NCO_PATRIM').AsString;
  recDadosValidacao.AContaReduzida := qryTabela.FieldByName('NCO_CONRED').AsString;

  if (qryTabela.State = dsEdit) and (not fValidaCamposConta) then
    exit ;

  if not TValidaProcessoContaContabil.fValidaPlanoContas(recDadosValidacao, TMostraMensagemErroValidacao.pMostra) then
  begin
    exit ;
  end;

  inherited;

  pHabitaCamposVigencia(False) ;
  pCarregaJusteLucroLiquido;
  pDesabilitaNaturezaAjuste(cbxAjuLiq.Text);
  pDesfixaCamposConta;
  blnInclusao := False;
end;

procedure TfrmPlanoContabil.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnInclusao := True;
  pHabilitaCodigo(dbeConta, dbeConta, True);
  pHabitaCamposVigencia(True) ;
  If pnlAjuLiq.Visible Then
    qryTabela.FieldByName('NCO_AJULIQ').AsString := 'N';
  qryTabela.FieldByName('NCO_TPLACO').AsString := FstrTPlacoEmpLog;
  pCarregaCampos;
  qryTabela.FieldByName('NCO_APURAC').AsString := '0';
  qryTabela.FieldByName('NCO_NATURE').AsString := 'A';
  qryTabela.FieldByName('NCO_FINALI').AsString := 'C';
  qryTabela.FieldByName('NCO_REDUTO').AsString := 'N';
  qryTabela.FieldByName('NCO_PATRIM').AsString := 'N';

  if FblnNCO_SUBCNT then
    qryTabela.FieldByName('NCO_SUBCNT').AsString := 'N';

  dbeConRed.Enabled := not fContaReduzidaAutomatica;
  dbeNatAju.Enabled := cbxAjuLiq.Text = 'Sempre' ;
  strConRed := '';
end;

procedure TfrmPlanoContabil.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrPlan: TConsultasArray;
begin
  chrKey := '/'; 
  If fPesqPlanoContabil(Self, Nil, Nil, qryTabela, chrKey, arrPlan, True, '', True, True) Then
  begin
    pCarregaCampos;
    pSetFocus(btnAlterar);
  end;
end;

procedure TfrmPlanoContabil.cbxAjuLiqChange(Sender: TObject);
begin
  inherited;
  pDesabilitaNaturezaAjuste(TComboBoxFocus(Sender).Text);
end;

procedure TfrmPlanoContabil.dbeContaExit(Sender: TObject);
begin
  inherited;
  if blnInclusao and (not fEmptyStr(dbeConta.Text)) then
    pAjustaCamposConta(TValidaProcessoContaContabil.fRetornaCamposConta(dbeConta.Text))
  else
    pDesfixaCamposConta;
end;

procedure TfrmPlanoContabil.dbeCtaRefKeyPress(Sender: TObject; var Key: Char);
Var
  arrCons: TConsultasArray;
begin
  if fEntraCons(Key) then
  begin
    If fPesqPlanoPreferencial(Self, TDBEditFocus(Sender), edtDescricaoCtaRef, Nil, Key, arrCons, False) Then
    Begin
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmPlanoContabil.dbeNatAjuKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCons: TConsultasArray;
begin
  inherited;
  If fPesqNaturezaDosAjustes(Self, dbeNatAju, edtDescricaoNatAjuste, Nil, Key, arrCons) Then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmPlanoContabil.dbrgNaturePropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  If fTemVigencia Then
  begin
    if qryTabela.State in [dsInsert,dsEdit] then
    begin
      dbeDtaIni.Enabled := TcxRadioGroup(Sender).ItemIndex = 0 ;
      dbeDtaFin.Enabled := TcxRadioGroup(Sender).ItemIndex = 0 ;
      if TcxRadioGroup(Sender).ItemIndex = 1 then ////sintetico
      begin
        dbeDtaIni.Field.Clear ;
        dbeDtaFin.Field.Clear ;
      end;
    end;
  end;
end;

procedure TfrmPlanoContabil.dtsPlaNcoDataChange(Sender: TObject; Field: TField);
begin
  inherited;

  if not Assigned(dtsPlaNCO.DataSet) then
    Exit ;

  if not dtsPlaNCO.DataSet.Active then
    Exit ;

  if dtsPlaNCO.State in [dsEdit, dsInsert] then
    pDesabilitaNaturezaAjuste(cbxAjuLiq.Text) ;

end;

function TfrmPlanoContabil.fContaReduzidaAutomatica: boolean;
begin
  Result := False;
  if (FValorCfgCrdCon = '1') then
    Result := True;
end;

function TfrmPlanoContabil.fExecutaAntesDoDelete: Boolean;
begin
  Result := True ;
  pLigaDesligaFkPlanco(pDesliga) ;
end;

function TfrmPlanoContabil.fgetNovaContaReduzida: string;
var
  intTentativas : integer ;
  strTplAco : string ;
begin
  strTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [Vs_strCodEmp], False);
  intTentativas := 1 ;
  while intTentativas <= 10 do
  begin
    Result := fRetSequencial('CRDSEQ', VS_strCodEmp, intLenConRed);
    ////verifica se o código já foi cadastrado
    if fEmptyStr(fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CONRED', 'NCO_TPLACO'], [Result, strTplAco])) then
    begin
      break ;
    end;
    Result := '' ;
    inc(intTentativas) ;
  end;
end;

function TfrmPlanoContabil.fInserindoContaReduzidaAutomatica: boolean;
begin
  Result := False;

  if (qryTabela.State = dsInsert) then
  begin
    if (qryTabela.FieldByName('NCO_CONRED').AsString.IsEmpty) then
    begin
      if (fContaReduzidaAutomatica) then
      begin
        Result := True;
      end;
    end;
  end;
end;

procedure TfrmPlanoContabil.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeConta, dbeDescri, False);
  pHabitaCamposVigencia(True) ;
  strConRed := qryTabela.FieldByName('NCO_CONRED').AsString;
  dbeConRed.Enabled := not fContaReduzidaAutomatica;
  dbeNatAju.Enabled := cbxAjuLiq.Text = 'Sempre' ;
end;

function TfrmPlanoContabil.fUtilizaAjusteLucroLiq: boolean;
begin
  Result := False;

  if not fConfiguracaoExiste('SPDECF') then
    Exit;

  if not fCfgSis('SPDECF', varBoolean) then
    Exit;

  if not fCampoExiste('PLANCO', 'NCO_AJULIQ') then
    Exit;

  Result := True;
end;

function TfrmPlanoContabil.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strMensagemValidacao: string ;
  strDescricaoCtaRef: string ;
  strDescricaoDoTipoDePlanoDeContaContabil: string ;
  strDescricaoNatAjuste: string ;
begin

  Result := True;

  If (Sender = dbeConta) Then
  Begin
    if not TValidaProcessoContaContabil.fValidaConta(strMensagemValidacao, dbeConta.Text) then
    Begin
      fMensagem('ATENÇÃO!', strMensagemValidacao, ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;
  End
  Else If (Sender = dbeDescri) Then
  Begin
    if not TValidaProcessoContaContabil.fValidaDescricaoConta(strMensagemValidacao, dbeDescri.Text) then
    begin
      fMensagem('ATENÇÃO!', strMensagemValidacao, ['&OK']);
      Result := False;
    end;
  End

  Else If (Sender = dbeConRed) and (dbeConRed.Enabled) Then
  Begin
    if ((intLenConRed > 0) And (dbeConRed.Text <> '')) then
    begin
      dbeConRed.Text := fStrZero(dbeConRed.Text, intLenConRed);
    end;

    if not TValidaProcessoContaContabil.fValidaContaReduzida(strMensagemValidacao, dbeConRed.Text, dbrgNature.DataBinding.Field.AsString, qryTabela.FieldByName('AUTOINCREM').AsString) then
    begin
      fMensagem('ATENÇÃO!', strMensagemValidacao, ['&OK']);
      Result := False;
    end;
  End

  else if (Sender = dbeTplAco) then
  begin
    if not TValidaProcessoContaContabil.fValidaTplaco(strMensagemValidacao, dbeTplAco.Text, strDescricaoDoTipoDePlanoDeContaContabil) then
    begin
      fMensagem('ATENÇÃO!', strMensagemValidacao, ['&OK']) ;
      Result := False ;
    end
    else if not TValidaProcessoContaContabil.fValidaTplacoEmpLog(strMensagemValidacao, dbeTplAco.Text, FstrTPlacoEmpLog) then
    begin
      fMensagem('ATENÇÃO!', strMensagemValidacao, ['&OK']) ;
      Result := False ;
    end
    else
    begin
      edtDescricaoDoTipoDePlanoDeContaContabil.Text := strDescricaoDoTipoDePlanoDeContaContabil;
    end;
  end

  else if Sender = dbeCtaRef then
  begin
    pAjustaRefPontos;

    if not TValidaProcessoContaContabil.fValidaContaReferencial(strMensagemValidacao, dbeCtaRef.Text, dbeConta.Text, dbrgNature.Properties.Items[dbrgNature.ItemIndex].Value, strDescricaoCtaRef) then
    begin
      fMensagem('ATENÇÃO!', strMensagemValidacao, ['&OK']) ;
      Result := False ;
    end
    else
    begin
      edtDescricaoCtaRef.Text := strDescricaoCtaRef ;
    end;
  end

  else if (Sender = dbrgNature) then
  begin
    if not TValidaProcessoContaContabil.fValidaNatureza(strMensagemValidacao, dbrgNature.Properties.Items[dbrgNature.ItemIndex].Value, dbeConta.Text) then
    begin
      fMensagem('ATENÇÃO!', strMensagemValidacao, ['&OK']) ;
      Result := False ;
    end;
  end

  else if (Sender = dbrgFinali) then
  begin
    if not TValidaProcessoContaContabil.fValidaFinalidade(strMensagemValidacao, dbrgFinali.Properties.Items[dbrgFinali.ItemIndex].Value) then
    begin
      fMensagem('ATENÇÃO!', strMensagemValidacao, ['&OK']) ;
      Result := False ;
    end;
  end

  else if (Sender = dbrgRedutora) then
  begin
    if not TValidaProcessoContaContabil.fValidaRedutora(strMensagemValidacao, dbrgRedutora.Properties.Items[dbrgRedutora.ItemIndex].Value) then
    begin
      fMensagem('ATENÇÃO!', strMensagemValidacao, ['&OK']) ;
      Result := False ;
    end;
  end

  else if (Sender = dbeNatAju) then
  begin
    if not TValidaProcessoContaContabil.fValidaNaturezaAjuste(strMensagemValidacao, dbeNatAju.Text, cbxAjuLiq.Text, strDescricaoNatAjuste) then
    begin
      fMensagem('ATENÇÃO!', strMensagemValidacao, ['&OK']) ;
      Result := False ;
    end
    else
    begin
      edtDescricaoNatAjuste.Text := strDescricaoNatAjuste ;
    end;
  end

  else if (Sender = dbrgPatrimonial) and
          (blnBuscaPorChave)  then
  begin
    if not TValidaProcessoContaContabil.fValidaPatrimonial(strMensagemValidacao, dbrgPatrimonial.Properties.Items[dbrgPatrimonial.ItemIndex].Value, dbeConta.Text) then
    begin
      fMensagem('ATENÇÃO!', strMensagemValidacao, ['&OK']);
      Result := False;
    end;
  end;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmPlanoContabil.fValidaCamposConta: Boolean;
var
  LDados: TDadosCamposConta;
  LMsg, LValor: string;
begin
  Result := True;

  if fCfgExpCtb = 'S' then
    Exit ;

  LDados := TValidaProcessoContaContabil.fRetornaCamposConta(qryTabela.FieldByName('NCO_CODCON').AsString);

  LMsg := 'Valor(es) diferente(s) do esperado pela parametrização do código da conta: ';

  if LDados.NatureFixo then
  begin
    if String(LDados.Nature) <> qryTabela.FieldByName('NCO_NATURE').AsString then
    begin
      if LDados.Nature = 'A' then
        LValor := 'Analítico'
      else
        LValor := 'Sintético';

      LMsg := LMsg + #13 + '- A Natureza deve ser = "' + LValor +'"';
      Result := False;
    end;
  end;

  if LDados.FinaliFixo then
  begin
    if String(LDados.Finali) <> qryTabela.FieldByName('NCO_FINALI').AsString then
    begin
      if LDados.Finali = 'C' then
        LValor := 'Credora'
      else
        LValor := 'Devedora';

      LMsg := LMsg + #13 + '- A Finalidade deve ser = "' + LValor +'"';
      Result := False;
    end;
  end;

  if LDados.RedutoFixo then
  begin
    if String(LDados.Reduto) <> qryTabela.FieldByName('NCO_REDUTO').AsString then
    begin
      if LDados.Reduto = 'S' then
        LValor := 'Sim'
      else
        LValor := 'Não';


      LMsg := LMsg + #13 + '- Redutora deve ser = "' + LValor +'"';
      Result := False;
    end;
  end;

  if LDados.PatrimFixo then
  begin
    if String(LDados.Patrim) <> qryTabela.FieldByName('NCO_PATRIM').AsString then
    begin
      if LDados.Patrim = 'S' then
        LValor := 'Sim'
      else
        LValor := 'Não';

      LMsg := LMsg + #13 + '- Patrimonial deve ser = "' + LValor +'"';
      Result := False;
    end;
  end;

  if not Result then
    fMensagem('ATENÇÃO!', LMsg, ['&OK']);
end;

function TfrmPlanoContabil.fVerificaContaEmUso(const AConta,
  ATplaco: String): Boolean;
var
  LConsultaConta: TUniQuery ;
  LConsultaTplaco: TUniQuery ;
  LConta: String ;
  LEmpresas: String ;
  LConsultaMetaDados: TUniQuery ;
  LTabelaFilha, LColunaFilha, LColunaEmpresa: String ;
begin
  Result := False ;
  LConta := fSemMascaraPlaNco(AConta) ;

  // busca as empresas do tplaco
  LConsultaTplaco := fCriaQuery() ;
  try
    LConsultaTplaco.Close ;
    LConsultaTplaco.SQL.Clear ;
    LConsultaTplaco.SQL.Add('SELECT EMP_CODEMP FROM CADEMP WHERE EMP_TPLACO = :TPLACO') ;
    LConsultaTplaco.ParamByName('TPLACO').AsString := ATplaco ;
    LConsultaTplaco.Open ;
    LEmpresas := '' ;
    LConsultaTplaco.First ;
    while not LConsultaTplaco.Eof do
    begin
      LEmpresas := LEmpresas + ifThen(fEmptyStr(LEmpresas), '', ',') + QuotedStr(LConsultaTplaco.FieldByName('EMP_CODEMP').AsString) ;
      LConsultaTplaco.Next ;
    end ;
  finally
    FreeAndNil(LConsultaTplaco) ;
  end ;

  if fEmptyStr(LEmpresas) then
    Exit ;

  LConsultaConta := fCriaQuery() ;
  try
    LConsultaMetaDados := fCriaQuery() ;
    try
      LConsultaMetaDados.Close ;
      LConsultaMetaDados.SQL.Clear ;
      LConsultaMetaDados.SQL.Add(' SELECT ');
      LConsultaMetaDados.SQL.Add('     kcu.TABLE_NAME                  AS TABELA_FILHA, ');
      LConsultaMetaDados.SQL.Add('     kcu.COLUMN_NAME                 AS COLUNA_FILHA, ');
      LConsultaMetaDados.SQL.Add('     MIN(col.COLUMN_NAME)            AS COLUNA_EMPRESA ');
      LConsultaMetaDados.SQL.Add(' FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu ');
      LConsultaMetaDados.SQL.Add(' INNER JOIN INFORMATION_SCHEMA.COLUMNS col ');
      LConsultaMetaDados.SQL.Add('     ON  col.TABLE_SCHEMA = kcu.TABLE_SCHEMA ');
      LConsultaMetaDados.SQL.Add('     AND col.TABLE_NAME   = kcu.TABLE_NAME ');
      LConsultaMetaDados.SQL.Add('     AND (col.COLUMN_NAME LIKE "%CODEMP%" OR col.COLUMN_NAME LIKE "%EMPLAN%") ');
      LConsultaMetaDados.SQL.Add(' WHERE kcu.REFERENCED_TABLE_NAME   = "PLANCO" ');
      LConsultaMetaDados.SQL.Add('   AND kcu.REFERENCED_TABLE_SCHEMA = DATABASE() ');
      LConsultaMetaDados.SQL.Add(' GROUP BY kcu.TABLE_NAME, kcu.COLUMN_NAME; ');
      LConsultaMetaDados.Open ;

      LConsultaMetaDados.First ;
      while not LConsultaMetaDados.Eof do
      begin
        LTabelaFilha := LConsultaMetaDados.FieldByName('TABELA_FILHA').AsString ;
        LColunaFilha := LConsultaMetaDados.FieldByName('COLUNA_FILHA').AsString ;
        LColunaEmpresa := LConsultaMetaDados.FieldByName('COLUNA_EMPRESA').AsString ;

        LConsultaConta.Close ;
        LConsultaConta.SQL.Clear ;
        LConsultaConta.SQL.Add('SELECT ' + LColunaFilha + ' FROM ' + LTabelaFilha + ' WHERE ' + LColunaFilha + ' = :CODCON AND ' + LColunaEmpresa + ' IN (' + LEmpresas + ') LIMIT 1') ;
        LConsultaConta.ParamByName('CODCON').AsString := LConta ;
        LConsultaConta.Open ;
        if not LConsultaConta.IsEmpty then
          Exit(True) ;

        LConsultaMetaDados.Next ;
      end ;
    finally
      FreeAndNil(LConsultaMetaDados) ;
    end ;
  finally
    FreeAndNil(LConsultaConta) ;
  end ;

end;

procedure TfrmPlanoContabil.pAfterOpen(DataSet: TDataSet);
begin
  If (Assigned(DataSet.FindField('NCO_CODCON'))) Then
    DataSet.FieldByName('NCO_CODCON').EditMask := fMskCon;
  If fTemVigencia Then
  begin
    DataSet.FieldByName('NCO_DTAINI').EditMask := '99/99/9999';
    DataSet.FieldByName('NCO_DTAFIN').EditMask := '99/99/9999';
  end;
end;

procedure TfrmPlanoContabil.pAjustaCamposConta(const ADados: TDadosCamposConta);
begin
  if not (qryTabela.State in [dsInsert, dsEdit]) then
    Exit;

  if fCfgExpCtb = 'S' then
    Exit ;

  qryTabela.FieldByName('NCO_FINALI').AsString := ADados.Finali;
  dbrgFinali.Enabled := not ADados.FinaliFixo;

  qryTabela.FieldByName('NCO_REDUTO').AsString := ADados.Reduto;
  dbrgRedutora.Enabled := not ADados.RedutoFixo;

  qryTabela.FieldByName('NCO_PATRIM').AsString := ADados.Patrim;
  dbrgPatrimonial.Enabled := not ADados.PatrimFixo;

  qryTabela.FieldByName('NCO_NATURE').AsString := ADados.Nature;
  dbrgNature.Enabled := not ADados.NatureFixo;
end;

procedure TfrmPlanoContabil.pAjustaRefPontos;
var
  LstrCtaRef: string;
  LstrCtaRefSemPontos: string;
begin
  if not dbeCtaRef.Enabled then
    Exit;

  LstrCtaRef := string(dbeCtaRef.Text).Trim;

  if fEmptyStr(LstrCtaRef) then
    Exit;

  LstrCtaRefSemPontos := StringReplace(LstrCtaRef, '.', '', [rfReplaceAll]);

  if LstrCtaRef <> LstrCtaRefSemPontos then
    Exit;

  LstrCtaRef := fCampoTabela('NRE_CODREF', 'PLANRE', ['REPLACE(NRE_CODREF, ".", "")'], [LstrCtaRefSemPontos]);

  if not fEmptyStr(LstrCtaRef) then
    dbeCtaRef.Text := LstrCtaRef;
end;

procedure TfrmPlanoContabil.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NCO_CODCON');
  stlCampos.Add('NCO_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NCO_DESCRI');
  stlCamInd.Add('NCO_CODCON');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
end;

procedure TfrmPlanoContabil.pLigaDesligaFkPlanco(const AStatus: TFkPlanco);
var
  LExec: TUniQuery ;
begin
  LExec := fCriaQuery() ;
  try
    LExec.Close ;
    LExec.SQL.Clear ;
    if AStatus = pLiga then
      LExec.SQL.Add('SET FOREIGN_KEY_CHECKS = 1 ;')
    else if AStatus = pDesliga then
      LExec.SQL.Add('SET FOREIGN_KEY_CHECKS = 0 ;') ;
    LExec.ExecSQL ;
  finally
    FreeAndNil(LExec) ;
  end ;
end;

procedure TfrmPlanoContabil.pCarregaCampos;
begin
  if dbeTplAco.Text <> FstrTPlacoEmpLog then
    edtDescricaoDoTipoDePlanoDeContaContabil.Text := TValidaProcessoContaContabil.fCarregaDescricaoDoTipoDePlanoDeContaContabil(dbeTplAco.Text)
  else
    edtDescricaoDoTipoDePlanoDeContaContabil.Text := FstrDescTPlacoEmpLog;
  edtDescricaoCtaRef.Text := TValidaProcessoContaContabil.fCarregaDescricaoDaCtaRef(dbeCtaRef.Text);
  edtDescricaoNatAjuste.Text := TValidaProcessoContaContabil.fCarregaDescricaoDaNatAjuste(dbeNatAju.Text);
  pCarregaJusteLucroLiquido;
  pDesabilitaNaturezaAjuste(cbxAjuLiq.Text);
end;

procedure TfrmPlanoContabil.pCarregaJusteLucroLiquido;
begin
  If pnlAjuLiq.Visible Then
  Begin
    If fEmptyStr(qryTabela.FieldByName('NCO_AJULIQ').AsString) Then
      cbxAjuLiq.ItemIndex := -1
    Else
      Case qryTabela.FieldByName('NCO_AJULIQ').AsString[1] Of
        'N': cbxAjuLiq.ItemIndex := 0;
        'S': cbxAjuLiq.ItemIndex := 1;
      End;
  End;
end;

procedure TfrmPlanoContabil.pDesabilitaNaturezaAjuste(const AOpcao: string);
begin
  if not fUtilizaNaturezaDoAjuste then
  begin
    exit ;
  end;

  if not (dtsPlaNco.DataSet.State in [dsEdit, dsInsert]) then
  begin
    dbeNatAju.Enabled := False ;
    exit ;
  end ;

  dbeNatAju.Enabled := AOpcao = 'Sempre' ;
  ////limpa o valor do campo.
  if not dbeNatAju.Enabled then
  begin
    if (not fEmptyStr(dtsPlaNco.DataSet.FieldByName('NCO_NATAJU').AsString)) and (dtsPlaNco.DataSet.State in [dsEdit, dsInsert]) then
    begin
      dtsPlaNco.DataSet.FieldByName('NCO_NATAJU').Clear ;
      edtDescricaoNatAjuste.Clear ;
    end;
  end;

end;

procedure TfrmPlanoContabil.pDesfixaCamposConta;
begin
  dbrgNature.Enabled := True;
  dbrgFinali.Enabled := True;
  dbrgRedutora.Enabled := True;
  dbrgPatrimonial.Enabled := True;
end;

procedure TfrmPlanoContabil.pGravaNullChaveEstrangeiraQuandoVazia;
begin

  if not ((qryTabela.State = dsEdit) or (qryTabela.State = dsInsert)) then
    Exit ;

  if fEmptyStr(dbeTplAco.Field.asString) then
    dbeTplAco.Field.Clear;

  if not fEmptyStr(dbeCtaRef.DataField) then
    if fEmptyStr(dbeCtaRef.Field.asString) then
      dbeCtaRef.Field.Clear;

  if not fEmptyStr(dbeNatAju.DataField) then
    if fEmptyStr(dbeNatAju.Field.asString) then
      dbeNatAju.Field.Clear;

  if (qryTabela.State = dsInsert)
     and fContaReduzidaAutomatica
     and fEmptyStr(qryTabela.FieldByName('NCO_CONRED').AsString) then
  begin
    fMensagem('ATENÇÃO!',
              'Não foi possível determinar a Conta Reduzida automaticamente.'+#13+
              'Verifique CFG_CRDCON, CFG_CRDSEQ e CFG_CRDTAM em " > Util > Configuração do Sistema" e tente novamente.',
              ['&OK']);
    Abort;
  end;

end;

procedure TfrmPlanoContabil.pHabitaCamposVigencia(const blnHabilitar:boolean);
begin
  if not fTemVigencia then
    exit;

  if qryTabela.FieldByName('NCO_NATURE').AsString <> 'A' then
  begin
    dbeDtaIni.Enabled := False ;
    dbeDtaFin.Enabled := False ;
    exit ;
  end;

  dbeDtaIni.Enabled := blnHabilitar ;
  dbeDtaFin.Enabled := blnHabilitar ;

end;

end.


