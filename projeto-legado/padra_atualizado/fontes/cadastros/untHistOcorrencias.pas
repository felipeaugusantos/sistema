unit untHistOcorrencias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, DB,
  Mask, DBCtrls, DBEditFocus, DBMemoFocus, Uni, EditFocus, MaskEditFocus,
  untAtualizaOcorrenciasCRM, BitBtnLockedIncrem, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, untLiberacao;

type
  TfrmHistOcorrencias = class(TfrmPaiCad)
    pnlGeral: TPanel;
    dtsHisOco: TDataSource;
    pnlDatas: TPanel;
    grbDatas: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pnlUsuario: TPanel;
    grbUsuario: TGroupBox;
    Label6: TLabel;
    Panel1: TPanel;
    dbmDescri: TDBMemoFocus;
    dbeCodigo: TDBEditFocus;
    dbeOpeOco: TDBEditFocus;
    edtDesOpeOco: TEditFocus;
    dbeDtaInc: TDBEditFocus;
    dbeHorInc: TDBEditFocus;
    dbeDtaCon: TDBEditFocus;
    dbeHorCon: TDBEditFocus;
    Panel2: TPanel;
    grbInfGerais: TGroupBox;
    Label10: TLabel;
    dbeComple: TDBEditFocus;
    dbeDesComple: TEditFocus;
    chkEnvEmail: TCheckBox;
    Label9: TLabel;
    dbeCodSit: TDBEditFocus;
    edtDesSit: TEditFocus;
    Label7: TLabel;
    Label11: TLabel;
    dbeDtaAge: TDBEditFocus;
    dbeHorAge: TDBEditFocus;
    chkEnvEmailDestino: TCheckBox;
    shpLiberadoAlterarDtConclusao: TShape;
    shpLiberadoAlterarHrConclusao: TShape;
    btnGravarEfinalizar: TBitBtnLocked;
    dbeTipOco: TDBEditFocus;
    lblTipOco: TLabel;
    edtDesTipOco: TEditFocus;
    ChkEmerge: TCheckBox;
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbeOpeOcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeCompleKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodSitKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCompleExit(Sender: TObject);
    procedure btnGravarEfinalizarClick(Sender: TObject);
    procedure dbeTipOcoKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure chkEnvEmailClick(Sender: TObject);
  private
    { Private declarations }
    FCodOco: String;
    FCodCli: String;
    FNomCli: String;
    FCodGoc: String;
    FNomGoc: String;
    FCodToc: String;
    FNomToc: String;
    FCliEma: String;
    FCodCoc: String;
    FNomCoc: String;
    FTip_Fc: String;
    FProtoc: String;
    FNumLead: String;
    qryCadOpe: TUniQuery;
    qryCadCoc: TUniQuery;
    qryCadToc: TUniQuery;
    qrySitOco: TUniQuery;
    FEspDoc: String;
    FNumDoc: String;
    FCodSit: String;
    FCodEmp: String;
    FObserv: String;
    FDtaAge: String;
    FHraAge: String;
    strTipOcoAnt: String;
    FBlnFinalizarOcorrencia: Boolean;
    FBlnPermiteDataRetroativa: Boolean;
    arrOpeEmer: TStringArray;
    blnEnvEmailDefault: Boolean;
    objLiberacao: TLiberacao;

    procedure pCarregaUsuarioOcorrencia;
    procedure pInserirNovoHistorico;
    procedure pHabilitaBotoes;
    procedure pInserirHistoricoNovaOcorrencia;
    procedure pAdicionaMascaras;
    procedure pDesejaEnviarPorEmail(const strAssunto: String);
    procedure pInserirHistorico(DataSet: TDataSet);
    procedure pSetaParametrosConcluida;
    procedure pCarregaComplementoOcorrencia;
    procedure pMensagemPadraoOcorrenciaCRM(strCodOco: string);
    function getDtaAge: String;
    procedure SetDtaAge(const Value: String);
    procedure pHabilitarEnvioEmail;
    procedure pCarregaTipoOcorrencia;
    procedure pCarregaSituacaoOcorrencia;
    procedure pHabilitarTipoOcorrencia;
    procedure pSetObjAtuOcoCrm(objAtuOcoCrm: TAtuOcoCrm);
    procedure SetHraAge(const Value: String);
    function getHraAge: String;
  protected
    function getCodOco: String;

    function getCodCli: String;
    function getNomCli: String;
    function getCliEma: String;
    function getCodGoc: String;
    function getNomGoc: String;
    function getCodToc: String;
    function getNomToc: String;
    function getCodCoc: String;
    function getNomCoc: String;
    function getTip_Fc: String;
    function getProtoc: String;
    function getObserv: String;

    procedure setCodOco(const Value: String);

    procedure setCodCli(const Value: String);
    procedure setNomCli(const Value: String);
    procedure setCliEma(const Value: String);
    procedure setCodGoc(const Value: String);
    procedure setNomGoc(const Value: String);
    procedure setCodToc(const Value: String);
    procedure setNomToc(const Value: String);
    procedure setCodCoc(const Value: String);
    procedure setNomCoc(const Value: String);
    procedure setTip_Fc(const Value: String);
    procedure setProtoc(const Value: String);
    procedure setObserv(const Value: String);

    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaDataConclusao: Boolean;
    function fValidaDataAgendamento: Boolean;
  public
    { Public declarations }

    //Usados para saber se a ocorrencia foi finalizada;
    FDtaCon: TDateTime;
    FHorCon: TDateTime;

    property strCodOco: String Read getCodOco Write setCodOco;
    property strCodEmp: String Read FCodEmp Write FCodEmp;

    property strCodCli: String Read getCodCli Write setCodCli;
    property strNomCli: String Read getNomCli Write setNomCli;
    property strCliEma: String Read getCliEma Write setCliEma;
    property strCodGoc: String Read getCodGoc Write setCodGoc;
    property strNomGoc: String Read getNomGoc Write setNomGoc;
    property strCodToc: String Read getCodToc Write setCodToc;
    property strNomToc: String Read getNomToc Write setNomToc;
    property strCodCoc: String Read getCodCoc Write setCodCoc;
    property strNomCoc: String Read getNomCoc Write setNomCoc;
    property strTip_Fc: String Read getTip_Fc Write setTip_Fc;
    property strProtoc: String Read getProtoc Write setProtoc;
    property strNumDoc: String Read FNumDoc   Write FNumDoc;
    property strEspDoc: String Read FEspDoc   Write FEspDoc;
    property strCodSit: String Read FCodSit   Write FCodSit;
    property strObserv: String Read getObserv Write SetObserv;
    property strDtaAge: String Read getDtaAge Write SetDtaAge;
    property strHraAge: String Read getHraAge Write SetHraAge;
  end;

var
  frmHistOcorrencias: TfrmHistOcorrencias;

implementation

uses untFuncoesSimples, untConsultas, untPesqAux, untFuncoesCRM, untTEnvioEmail, StrUtils, DateUtils,
  untFuncoesOcorrenciasCRM, untLeads;

{$R *.dfm}

procedure TfrmHistOcorrencias.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaUsuarioOcorrencia;  
  pSetFocus(btnSair);
end;

procedure TfrmHistOcorrencias.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untHistOcorrencias.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmHistOcorrencias.btnGravarClick(Sender: TObject);
var
  blnDevolu: Boolean;
  objAtuOcoCrm: TAtuOcoCrm;
  blnFecharAposGravar: Boolean;

  blnOcoFin: Boolean;
  strInfDev: String;
  strCodTea: String;
  blnInfCodTea: Boolean;
  strCodTeaOco: String;
begin
  blnFecharAposGravar := False;
  blnDevolu := False;
  SetLength(arrOpeEmer,0);
  blnOcoFin := False;
  blnInfCodTea := False;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    qryTabela.FieldByName('HIS_OPEHIS').AsString := strLoginUsuarioLogado;
    qryTabela.FieldByName('HIS_CODOCO').AsString := FCodOco;
    qryTabela.FieldByName('HIS_CODEMP').AsString := FCodEmp;
    qryTabela.FieldByName('HIS_CODTOC').AsString := FCodToc;
    qryTabela.FieldByName('HIS_NUMDOC').AsString := FNumDoc;
    qryTabela.FieldByName('HIS_ESPDOC').AsString := FEspDoc;

    If (FTip_Fc = 'C') And fTipOcoInformaTemperaturaAtendimento(FCodGoc, FCodToc) Then
    Begin
      strCodTeaOco := fRetornaCorAtendimentoOcorrencia(qryTabela.FieldByName('HIS_CODOCO').AsString,
                                                     qryTabela.FieldByName('HIS_CODEMP').AsString);

      strCodTea := fInformarTemperaturaAtendimento(strCodTeaOco);

      blnInfCodTea := (strCodTea <> strCodTeaOco);

      If fEmptyStr(strCodTea) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar a Temperatura do Atendimento para prosseguir  !',['&Ok']);
        Exit;
      End;
    End;

    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untHistOcorrencias.btnGravarClick]');
    End;
  End;

  objAtuOcoCrm := TAtuOcoCrm.Create(Self);
  Try
    blnGravou := True;


    If blnGravou Then
    Begin
      fCommit;

      pSetObjAtuOcoCrm(objAtuOcoCrm);

      objAtuOcoCrm.pAtualizaOcorrencia;

      pSetaParametrosConcluida;

      If Not fOcorrenciaConcluida(qryTabela.FieldByName('HIS_DTACON').AsDateTime,qryTabela.FieldByName('HIS_HORCON').AsDateTime) then
        pDesejaEnviarPorEmail('Nova ocorrência CRM - Novo Histórico')
      Else
        pDesejaEnviarPorEmail('Ocorrência Finalizada - CRM');
      btnGravarEfinalizar.Enabled := False;

      If fOcorrenciaDevolucao(FCodToc, FTip_Fc) And
         (Not FBlnFinalizarOcorrencia) And
         (Not (fOcorrenciaPossuiADVinculada(FCodOco, VS_strCodEmp))) Then
      Begin
        blnDevolu := True;
        blnFecharAposGravar := True;
        blnOcoFin := (objAtuOcoCrm.strDtaCon > 0) And (objAtuOcoCrm.strHorCon > 0);

        pFluxoDevolucaoDeProdutos(Self,
                                  blnOcoFin,
                                  objAtuOcoCrm.strCodOco,
                                  objAtuOcoCrm.strCodEmp,
                                  objAtuOcoCrm.strCodCli,
                                  objAtuOcoCrm.strNomCli,
                                  strInfDev,
                                  True)

      End;

      If objAtuOcoCrm.blnEmerge Then
      Begin
        pFluxoOcorrenciasEmergenciais(blnOcoFin,
                                      blnDevolu,
                                      dbmDescri.Text,
                                      objAtuOcoCrm);
      End;

      If blnInfCodTea Then
      Begin
        pAlterarTemperaturaAtendimento(FTip_Fc,
                                       qryTabela.FieldByName('HIS_CODOCO').AsString,
                                       qryTabela.FieldByName('HIS_CODEMP').AsString,
                                       strCodTea);
      End;

    End
    Else
      fRollBack;
  Finally
    objAtuOcoCrm.Free;

    If blnFecharAposGravar Then
      Self.Close;
  End;
end;

procedure TfrmHistOcorrencias.btnGravarEfinalizarClick(Sender: TObject);
begin
  If ((FCodToc = fCfgSis('VENORC', varString)) Or
      (FCodToc = fCfgSis('VENPED', varString))) Then
  Begin
    fMensagem('', strCRMOcoFinFat, ['&Ok']);
    Exit;
  End;

  qryTabela.FieldByName('HIS_DTACON').AsDateTime := Today;
  qryTabela.FieldByName('HIS_HORCON').AsDateTime := fNow;

  FBlnFinalizarOcorrencia := True;

  dbmDescri.Text := IfThen(Not fEmptyStr(dbmDescri.Text), dbmDescri.Text + '<<csq>>', '') + 'Finalizando a Ocorrência.';

  BtnGravar.Click;

  If blnGravou Then
  Begin
    btnGravarEfinalizar.Enabled := False;

    If fOcorrenciaDevolucao(FCodToc, FTip_Fc) Then
    Begin
      Self.Close;
    End;
  End;

end;

procedure TfrmHistOcorrencias.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, TDBEdit(dbmdescri), False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  pAdicionaMascaras;

  pSetFocus(dbeDtaAge);
  dbeDtaAge.SelectAll;
end;

procedure TfrmHistOcorrencias.chkEnvEmailClick(Sender: TObject);
begin
  inherited;
  If chkEnvEmail.Checked <> blnEnvEmailDefault Then
  Begin
    If Not fVerificaAcessoSistema('CRMALTOCOEMA') Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce := 'CRMALTOCOEMA';
      objLiberacao.strMsgSen := 'CRM: Permitir alterar o checkbox "'+ chkEnvEmail.Caption +'"';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('CRM: '+ IIF(Not chkEnvEmail.Checked, 'Não ', '') + chkEnvEmail.Caption);

      If Not objLiberacao.fLibera Then
      Begin
        chkEnvEmail.Checked := blnEnvEmailDefault;
        Exit;
      End;
    End;
  End;

  blnEnvEmailDefault := chkEnvEmail.Checked;
end;

procedure TfrmHistOcorrencias.dbeCodSitKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqSitOcorrencias(Self, dbeCodSit, edtDesSit, qrySitOco, Key, arrSel, True, True, FCodToc) Then
  Begin
    If fValidaCampos(dbeCodSit, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmHistOcorrencias.dbeCompleExit(Sender: TObject);
begin
  inherited;
  pMensagemPadraoOcorrenciaCRM(dbeComple.Text);
end;

procedure TfrmHistOcorrencias.dbeCompleKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCOcorr: TConsultasArray;
begin
  {*********************************************}
  {* NOVA CONSULTA COMPLEMENTOS DE OCORRENCIAS *}
  {******************************************AC*}
  If fPesqComplementosOcorrencias(Self, dbeComple, dbeDesComple, nil, Key, arrCOcorr, True, FCodToc) Then
  Begin
    If fValidaCampos(dbeComple, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmHistOcorrencias.dbeOpeOcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrOpe: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, dbeOpeOco, edtDesOpeOco, nil, Key, arrOpe) then
  Begin
    If fValidaCampos(dbeOpeOco, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmHistOcorrencias.dbeTipOcoKeyPress(Sender: TObject; var Key: Char);
var
  arrTpOco: TConsultasArray;
begin
  If fPesqTiposOcorrencias(Self, dbeTipOco, edtDesTipOco, nil, Key, arrTpOco, True, FCodGoc) Then
  Begin
    If fValidaCampos(dbeTipOco, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmHistOcorrencias.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Action <> CaNone) Then
  Begin
    FreeAndNil(qryCadOpe);
    FreeAndNil(qryTabela);
    FreeAndNil(qryCadCoc);
    FreeAndNil(qryCadToc);
    FreeAndNil(qrySitOco);
    FreeAndNil(objLiberacao);
  End;

  If blnGravou Then
    Self.ModalResult := mrOk;
end;

procedure TfrmHistOcorrencias.FormCreate(Sender: TObject);
begin
  inherited;
  FDtaCon := 0;
  FHorCon := 0;
  //Vem sempre como default cliente.Somente será trocado pelo frmCRMForn
  strTip_Fc := 'C';  
    
  strNomeTabela     := 'HISOCO';
  strNomeCampo      := 'HIS_CODHIS';
  qryTabela         := fCriarQuery('SELECT * FROM HISOCO WHERE FALSE', Self);
  qryCadToc         := fCriarQuery('SELECT * FROM CADTOC WHERE FALSE', Self);
  qrySitOco         := fCriarQuery('SELECT * FROM SITOCO WHERE FALSE', Self);

  dtsHisOco.DataSet := qryTabela;

  objLiberacao := TLiberacao.Create;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  qryTabela.BeforePost := pInserirHistorico;
  FBlnFinalizarOcorrencia := False;
end;

procedure TfrmHistOcorrencias.pHabilitarEnvioEmail;
begin
  blnEnvEmailDefault := (fCampoTabela('TOC_ENVEMA', 'CADTOC', ['TOC_CODTOC'], [FCodToc]) = 'S');

  chkEnvEmail.Checked        := blnEnvEmailDefault;
  chkEnvEmailDestino.Checked := (fCampoTabela('TOC_EMADES', 'CADTOC', ['TOC_CODTOC'], [FCodToc]) = 'S');
end;

procedure TfrmHistOcorrencias.pHabilitarTipoOcorrencia;
begin
  If ((FCodToc = fCfgSis('VENORC', varString)) Or
      (FCodToc = fCfgSis('VENPED', varString)) Or
      (FCodToc = fCfgSis('VENVN_', varString))) Then
  Begin
    dbeTipOco.Enabled  := False;
    dbeTipOco.ReadOnly := True;
    pCarregaTipoOcorrencia;
  End
  Else
    fValidaCampos(dbeTipOco,True);
end;

procedure TfrmHistOcorrencias.FormShow(Sender: TObject);

begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  If (FCodToc = fCfgSis('VENORC', varString)) Or
     (FCodToc = fCfgSis('VENPED', varString)) Then
  Begin
    dbeDtaCon.Tag := 50;
    dbeHorCon.Tag := 50;

    dbeDtaCon.Enabled := False;
    dbeHorCon.Enabled := False;

    dbeDtaCon.ReadOnly := True;
    dbeHorCon.ReadOnly := True;

    shpLiberadoAlterarDtConclusao.Brush.Color  := clRed;
    shpLiberadoAlterarHrConclusao.Brush.Color  := clRed;
  End
  Else
  Begin
    If fVerificaAcessoSistema('CNLFLX') Then
    Begin
      shpLiberadoAlterarDtConclusao.Brush.Color  := clGreen;
      shpLiberadoAlterarHrConclusao.Brush.Color  := clGreen;
      dbeDtaCon.Enabled := True;
      dbeHorCon.Enabled := True;
      dbeDtaCon.ReadOnly := False;
      dbeHorCon.ReadOnly := False;
    End
    Else
    Begin
      shpLiberadoAlterarDtConclusao.Brush.Color  := clRed;
      shpLiberadoAlterarHrConclusao.Brush.Color  := clRed;
      dbeDtaCon.Enabled := False;
      dbeHorCon.Enabled := False;
      dbeDtaCon.ReadOnly := True;
      dbeHorCon.ReadOnly := True;
    End;
  End;

  strTipOcoAnt := FCodToc;
  FNumLead := TLeads.fObterNumLead(FCodOco);
  pInserirNovoHistorico;
  pHabilitarEnvioEmail;

  blnEnvEmailDefault := chkEnvEmail.Checked;
end;

function TfrmHistOcorrencias.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Tipo de Ocorrência deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeOpeOco) Then
    Begin
      If fEmptyStr(dbeOpeOco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Usuário da Ocorrência deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaUsuarioOcorrencia;
        If qryCadOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código do Usuário da Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End;

        If (qryCadOpe.FieldByName('OPE_STATUS').AsString = 'I') Then
        Begin
          fMensagem('ATENÇÃO!', 'Operador '+ qryCadOpe.FieldByName('OPE_CODOPE').AsString + '-' +
                                qryCadOpe.FieldByName('OPE_NOMOPE').AsString +' está inativo e não pode ser utilizado para geração de ocorrências.', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeCodSit) Then
    Begin
      If not fEmptyStr(dbeCodSit.Text) Then
      Begin
        pCarregaSituacaoOcorrencia;
        If fEmptyStr(edtDesSit.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'O código da situação informado é inválido!', ['&Ok']);
          Result := False;
        End
        Else
        If FCodToc <> qrySitOco.FieldByName('SIT_CODTOC').AsString Then
        Begin
          fMensagem('ATENÇÃO', 'A situação escolhida não pertence ao tipo da ocorrência!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeDtaAge) Then
    Begin
      If fEmptyDate(dbeDtaAge.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Agendada deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
        Result := fValidaDataAgendamento;
    End

    Else If (Sender = dbeHorAge) Then
    Begin
      If fEmptyTime(dbeHorAge.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Hora Agendada deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
        Result := fValidaDataAgendamento;
    End

    Else If (Sender = dbeDtaCon) Then
    Begin
      If Not fEmptyDate(dbeDtaCon.Text) Then
        Result := fValidaDataConclusao;
    End

    Else If (Sender = dbeHorCon) Then
    Begin
      If (Not fEmptyStr(dbeHorCon.Text)) And (dbeHorCon.Text <> '  :  :  ') Then
      Begin
        If (fEmptyStr(dbeDtaCon.Text)) Or (dbeDtaCon.Text = '  /  /    ') Then
        begin
          fMensagem('ATENÇÃO!', 'A Data de Conclusão da Ocorrência deve ser preenchida!', ['&Ok']);
          Result := False;
        end;
      End
      Else If (Not fEmptyStr(dbeDtaCon.Text)) And (dbeDtaCon.Text <> '  /  /    ') Then
      Begin
        If (fEmptyStr(dbeHorCon.Text)) Or (dbeHorCon.Text = '  :  :  ') Then
        begin
          fMensagem('ATENÇÃO!', 'A Hora de Conclusão da Ocorrência deve ser preenchida!', ['&Ok']);
          Result := False;
        end;
      End
      Else
      If ((Not fEmptyDate(dbeDtaCon.Text)) and  (Not fEmptyDate(dbeHorCon.Text))) Then
        Result := fValidaDataConclusao;
    End

    Else If (Sender = dbeComple) Then
    Begin
      if not fEmptyStr(dbeComple.Text) then
      begin
        pCarregaComplementoOcorrencia;
        If qryCadCoc.FieldByName('COC_CODCOC').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código de Complemento da Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End
      end
      else
      begin
        dbeDesComple.Clear;
        qryTabela.FieldByName('HIS_CODCOC').Value := Null;
      end;
    End

    Else If (Sender = dbeTipOco) Then
    Begin
      If Not fEmptyStr(dbeTipOco.Text) Then
      Begin
        pCarregaTipoOcorrencia;
        If qryCadToc.FieldByName('TOC_CODTOC').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código de Tipo de Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If ((qryCadToc.FieldByName('TOC_CODTOC').AsString = fCfgSis('VENORC', varString)) Or
                 (qryCadToc.FieldByName('TOC_CODTOC').AsString = fCfgSis('VENPED', varString)) Or
                 (qryCadToc.FieldByName('TOC_CODTOC').AsString = fCfgSis('VENVN_', varString))
                ) And (qryCadToc.FieldByName('TOC_CODTOC').AsString <> strTipOcoAnt) Then
        Begin
          If (qryCadToc.FieldByName('TOC_CODTOC').AsString = fCfgSis('VENVN_', varString)) Then
            fMensagem('', 'Ocorrência Referente à Venda não pode ser alterada manualmente!', ['&Ok'])
          Else
            fMensagem('', 'Ocorrência Referente a Pedido/Orçamento não pode ser alterada manualmente!', ['&Ok']);

          dbeTipOco.Enabled := False;
          dbeTipOco.ReadOnly := True;
          Result := False;
        End;

        If Result Then
        Begin
          If (strTip_Fc = 'C') Then
          Begin
            If qryCadToc.FieldByName('TOC_USACLI').AsString <> 'S' Then
            Begin
              Result := False;
              pMensagemOk('Tipo de Ocorrência não permitido para Clientes!');
            End;
          End

          Else
          If (strTip_Fc = 'P') Then
          Begin
            If qryCadToc.FieldByName('TOC_USAPRO').AsString <> 'S' Then
            Begin
              Result := False;
              pMensagemOk('Tipo de Ocorrência não permitido para Prospectos!');
            End;
          End

          Else
          If (strTip_Fc = 'F') Then
          Begin
            If qryCadToc.FieldByName('TOC_USAFOR').AsString <> 'S' Then
            Begin
              Result := False;
              pMensagemOk('Tipo de Ocorrência não permitido para Fornecedores!');
            End;
          End;

          If strTipOcoAnt <> FCodToc Then
            pHabilitarEnvioEmail;

          strTipOcoAnt := FCodToc;
        End;
      End;
    End;
  End;
end;

function TfrmHistOcorrencias.fValidaDataAgendamento: Boolean;
var
  dtaInclusao: TDateTime;
  dtaAgendamento: TDateTime;
  dtaConclusao: TDateTime;
  intQtdDiaTol: Integer;
  fltDiasCalc: Double;
begin
  Result := True;
  dtaInclusao := StrToDateTimeDef(dbeDtaInc.Text + ' ' + dbeHorInc.Text, 0 );
  dtaAgendamento:= StrToDateTimeDef(dbeDtaAge.Text + ' ' + dbeHorAge.Text, 0 );
  dtaConclusao := StrToDateTimeDef(dbeDtaCon.Text + ' ' + dbeHorCon.Text, 0 );

  intQtdDiaTol := fCfgSis('DIATOL', varInteger);

  If dtaInclusao > dtaAgendamento Then
  Begin
    fltDiasCalc := DaysBetween(dtaInclusao, dtaAgendamento);

    Result := (intQtdDiaTol > 0) and (intQtdDiaTol >= fltDiasCalc);
  End;

  If Not Result Then
  Begin
    If (intQtdDiaTol = 0) Then
      fMensagem('ATENÇÃO!', 'A Data Agendada não permite lançamento de data retroativa. Verifique !', ['&Ok'])
    Else
      fMensagem('ATENÇÃO!', 'A Data Agendada deve ser maior que a data de inclusão!', ['&Ok']);

    Exit;
  End;

  Result := (dtaAgendamento >= dtaInclusao);
  If Not Result Then
  Begin
    fMensagem('ATENÇÃO!', 'A Data Agendada deve ser maior que a data de inclusão!', ['&Ok']);
    Exit;
  End;

  If (dtaConclusao > 0) Then
  Begin
    Result := (dtaAgendamento >= dtaInclusao);
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'A Data Agendada deve ser menor que a data de conclusão!', ['&Ok']);
      Exit;
    End;
  End;

end;

function TfrmHistOcorrencias.fValidaDataConclusao: Boolean;
var
  dtaInclusao: TDateTime;
  dtaConclusao: TDateTime;
  intQtdDiaTol: Integer;
  fltDiasCalc: Double;
begin
  Result := True;

  If Not fEmptyDate(dbeDtaInc.Text) Then
    dtaInclusao:= StrToDateTimeDef(dbeDtaInc.Text + ' ' + dbeHorInc.Text, 0 )
  Else
    dtaInclusao := VS_Date + fRetHoraServidor();

  dtaConclusao:= StrToDateTimeDef(dbeDtaCon.Text + ' ' + dbeHorCon.Text, 0 );

  intQtdDiaTol := fCfgSis('DIATOL', varInteger);

  If dtaInclusao > dtaConclusao Then
  Begin
    fltDiasCalc := DaysBetween(dtaInclusao, dtaConclusao);

    FBlnPermiteDataRetroativa := (intQtdDiaTol > 0) and (intQtdDiaTol >= fltDiasCalc);

    If FBlnPermiteDataRetroativa Then
    Begin
      dbeDtaInc.Text := dbeDtaCon.Text;
      dbeHorInc.Text := dbeHorCon.Text;

      If Not fValidaDataAgendamento Then
      Begin
        dbeDtaAge.Text := dbeDtaCon.Text;
        dbeHorAge.Text := dbeHorCon.Text;
      End;
    End;

    Result := FBlnPermiteDataRetroativa;
  End;

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO!', 'A Data/Hora de Conclusão deve ser maior que a data/hora de inclusão!', ['&Ok']);
  End;
end;

function TfrmHistOcorrencias.getCliEma: String;
begin
  Result := FCliEma;
end;

function TfrmHistOcorrencias.getCodCli: String;
begin
  Result := FCodCli;
end;

function TfrmHistOcorrencias.getCodCoc: String;
begin
  Result := FCodCoc;
end;

function TfrmHistOcorrencias.getCodGoc: String;
begin
  Result := FCodGoc;
end;

function TfrmHistOcorrencias.getCodOco: String;
begin
  Result := FCodOco;
end;

function TfrmHistOcorrencias.getNomCli: String;
begin
  Result := FNomCli;
end;

function TfrmHistOcorrencias.getNomCoc: String;
begin
  Result := FNomCoc;
end;

function TfrmHistOcorrencias.getNomGoc: String;
begin
  Result := FNomGoc;
end;

function TfrmHistOcorrencias.getNomToc: String;
begin
  Result := FNomToc;
end;

function TfrmHistOcorrencias.getObserv: String;
begin
  Result := FObserv;
end;

function TfrmHistOcorrencias.getProtoc: String;
begin
  Result := FProtoc;
end;

function TfrmHistOcorrencias.getTip_Fc: String;
begin
  Result := FTip_Fc;
end;

function TfrmHistOcorrencias.getCodToc: String;
begin
  Result := FCodToc;
end;

function TfrmHistOcorrencias.getDtaAge: String;
begin
  Result := FDtaAge;
end;

function TfrmHistOcorrencias.getHraAge: String;
begin
  Result := FHraAge;
end;

procedure TfrmHistOcorrencias.pAdicionaMascaras;
begin
  with qryTabela do
  begin
    TDateField(FieldByName('HIS_DTACON')).EditMask := '99/99/9999';
    TDateField(FieldByName('HIS_HORCON')).EditMask := '99:99:99';
    TDateField(FieldByName('HIS_DTAAGE')).EditMask := '99/99/9999';
    TDateField(FieldByName('HIS_HORAGE')).EditMask := '99:99:99';
  end;
end;

procedure TfrmHistOcorrencias.pSetObjAtuOcoCrm(objAtuOcoCrm: TAtuOcoCrm);
begin
  objAtuOcoCrm.pCarregaOcorrencia(FTip_Fc, FCodOco, IIF(Not fEmptyStr(FCodEmp), FCodEmp, VS_strCodEmp));
  objAtuOcoCrm.strNomFrm := Self.Name;
  objAtuOcoCrm.strCodOco := FCodOco;
  objAtuOcoCrm.strDtaInc := qryTabela.FieldByName('HIS_DTAINC').AsDateTime;
  objAtuOcoCrm.strHorInc := qryTabela.FieldByName('HIS_HORINC').AsDateTime;
  objAtuOcoCrm.strDtaAge := qryTabela.FieldByName('HIS_DTAAGE').AsDateTime;
  objAtuOcoCrm.strHorAge := qryTabela.FieldByName('HIS_HORAGE').AsDateTime;
  objAtuOcoCrm.strDtaCon := qryTabela.FieldByName('HIS_DTACON').AsDateTime;
  objAtuOcoCrm.strHorCon := qryTabela.FieldByName('HIS_HORCON').AsDateTime;
  objAtuOcoCrm.strOpeHis := strLoginUsuarioLogado;
  objAtuOcoCrm.strCodOpe := qryTabela.FieldByName('HIS_CODOPE').AsString;
  objAtuOcoCrm.strDescri := qryTabela.FieldByName('HIS_DESCRI').AsString;
  objAtuOcoCrm.strCodEmp := IIF(Not fEmptyStr(FCodEmp), FCodEmp, VS_strCodEmp);
  objAtuOcoCrm.strCodCoc := qryTabela.FieldByName('HIS_CODCOC').AsString;
  objAtuOcoCrm.strNumDoc := FNumDoc;
  objAtuOcoCrm.strEspDoc := FEspDoc;
  objAtuOcoCrm.strCodSit := qryTabela.FieldByName('HIS_CODSIT').AsString;
  objAtuOcoCrm.strCodToc := qryTabela.FieldByName('HIS_CODTOC').AsString;
  objAtuOcoCrm.blnEmerge := ChkEmerge.Checked;
end;

procedure TfrmHistOcorrencias.pCarregaComplementoOcorrencia;
begin
  If (fEmptyStr(FCodToc)) Then
  begin
    fMensagem('Informação!','Favor Informar o Tipo da Ocorrência!',['OK']);
    dbeComple.Text := '';
    Exit;
  end;

  pPesquisaCadCoc(qryTabela, qryCadCoc, dbeComple.Text, FCodToc);
  dbeDesComple.Text := qryCadCoc.FieldByName('COC_DESCOC').AsString;
end;

procedure TfrmHistOcorrencias.pCarregaSituacaoOcorrencia;
begin
  pPesquisaSitOco(qryTabela, qrySitOco, dbeCodSit.Text);
  edtDesSit.Text := qrySitOco.FieldByName('SIT_DESSIT').AsString;
end;

procedure TfrmHistOcorrencias.pCarregaTipoOcorrencia;
begin
  pPesquisaCadToc(qryTabela, qryCadToc, dbeTipOco.Text, FCodGoc);
  setCodToc(dbeTipOco.Text);
  edtDesTipOco.Text := qryCadToc.FieldByName('TOC_DESTOC').AsString;
end;

procedure TfrmHistOcorrencias.pCarregaUsuarioOcorrencia;
begin
  pPesquisaCadOpe(qryTabela, qryCadOpe, dbeOpeOco.Text);
  edtDesOpeOco.Text := qryCadOpe.FieldByName('OPE_NOMOPE').AsString;
end;

procedure TfrmHistOcorrencias.pDesejaEnviarPorEmail(const strAssunto: String);
begin
  If (Not(chkEnvEmail.Checked) And Not(chkEnvEmailDestino.Checked)) Then
    Exit;

  TEnvioEmail.EnviarEmail(Self,
                          strLoginUsuarioLogado,
                          strAssunto,
                          fRetornaParaMovOcorrencias(IfThen(chkEnvEmail.Checked,FCliEma, ''), IfThen(chkEnvEmailDestino.Checked, qryCadOpe.FieldByName('OPE_E_MAIL').AsString, '')),
                          [],
                          [],
                          TEnvioEmail.ContruirArrayMensagem(fFormataTextoMovOcorrencias(FCodCli,
                                                            FNomCli,
                                                            FCodGoc,
                                                            FNomGoc,
                                                            dbeDtaInc.Text,
                                                            dbeHorInc.Text,
                                                            '',
                                                            '',
                                                            FCodToc,
                                                            FNomToc,
                                                            dbeOpeOco.Text,
                                                            edtDesOpeOco.Text,
                                                            dbmDescri.Text,
                                                            dbeComple.Text,
                                                            dbeDesComple.Text,
                                                            FTip_Fc,
                                                            FProtoc,
                                                            False,
                                                            FCodEmp,
                                                            FEspDoc,
                                                            FNumDoc,
                                                            FNumLead)),
                          [],
                          true,False, '','', 0,False,
                          '','','','',0,0,0,'',
                                        '',0,False,'',Nil,'',
                                        '',False,False,'S','N', '','',
                                        False
                          );
end;

procedure TfrmHistOcorrencias.pHabilitaBotoes;
begin
  btnGravar.Enabled  := True;
  btnGravarEfinalizar.Enabled  := True;
  btnCancela.Enabled := True;
end;

procedure TfrmHistOcorrencias.pInicializaIndices;
begin
  inherited;
  qryCadOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  qryCadCoc := fCriarQuery('SELECT * FROM CADCOC WHERE FALSE', Self);
end;

procedure TfrmHistOcorrencias.pInserirHistorico(DataSet: TDataSet);
begin
  pInserirHistoricoNovaOcorrencia;
end;

procedure TfrmHistOcorrencias.pInserirHistoricoNovaOcorrencia;
begin
  qryTabela.FieldByName('HIS_DESCRI').AsString := fGeraTextoHistorico(qryTabela.FieldByName('HIS_DTAINC').AsDateTime,
                                                                      qryTabela.FieldByName('HIS_HORINC').AsDateTime,
                                                                      edtDesOpeOco.Text,
                                                                      qryTabela.FieldByName('HIS_DESCRI').AsString);
end;

procedure TfrmHistOcorrencias.pInserirNovoHistorico;
Var
  dtaAgeAux: String;
begin
  btnIncluirClick(Self);
  qryTabela.FieldByName('HIS_DTAINC').AsDateTime := VS_Date;
  qryTabela.FieldByName('HIS_HORINC').AsDateTime := fTime();

  dtaAgeAux := FDtaAge + ' ' + FHraAge;

  If Not(fEmptyDate(FDtaAge)) And (StrToDateTimeDef(dtaAgeAux, 0) >= fNow) Then
  Begin
    qryTabela.FieldByName('HIS_DTAAGE').AsDateTime := StrToDateTime(FDtaAge);
    qryTabela.FieldByName('HIS_HORAGE').AsDateTime := StrToDateTime(FHraAge);
  End
  Else
  Begin
    qryTabela.FieldByName('HIS_DTAAGE').AsDateTime := VS_Date;
    qryTabela.FieldByName('HIS_HORAGE').AsDateTime := fTime();
  End;
  qryTabela.FieldByName('HIS_CODOPE').AsString   := strLoginUsuarioLogado;
  qryTabela.FieldByName('HIS_CODCOC').AsString   := FCodCoc;
  qryTabela.FieldByName('HIS_CODSIT').AsString   := FCodSit;
  qryTabela.FieldByName('HIS_DESCRI').AsString   := FObserv;
  qryTabela.FieldByName('HIS_CODTOC').AsString   := FCodToc;
  fValidaCampos(dbeOpeOco,True);
  fValidaCampos(dbeComple,True);
  fValidaCampos(dbeCodSit,True);

  pHabilitarTipoOcorrencia;
  pHabilitaBotoes;
end;

procedure TfrmHistOcorrencias.pMensagemPadraoOcorrenciaCRM(strCodOco: string);
var
  strMensagemPadrao: string;
begin
  strMensagemPadrao := fBuscaMensagemPadraoOcorrenciaCRM(strCodOco);

  if (not fEmptyStr(dbmDescri.Text)) and (not fEmptyStr(strMensagemPadrao)) and (Trim(dbmDescri.Text) <> strMensagemPadrao) then
  begin
    if fMensagem('', 'Deseja sobrescrever a descrição da ocorrência?', ['&Sim', '&Não']) = 1 then
    begin
      dbmDescri.Text := strMensagemPadrao;
    end;
  end
  else if (fEmptyStr(dbmDescri.Text)) and (not fEmptyStr(strMensagemPadrao)) then
  begin
    dbmDescri.Text := strMensagemPadrao;
  end;
end;

procedure TfrmHistOcorrencias.pSetaParametrosConcluida;
begin
  FDtaCon := qryTabela.FieldByName('HIS_DTACON').AsDateTime;
  FHorCon := qryTabela.FieldByName('HIS_HORCON').AsDateTime;
end;

procedure TfrmHistOcorrencias.setCliEma(const Value: String);
begin
  If (FCliEma <> Value) Then
    FCliEma := Value;
end;

procedure TfrmHistOcorrencias.setCodCli(const Value: String);
begin
  If (FCodCli <> Value) Then
    FCodCli := Value;
end;

procedure TfrmHistOcorrencias.setCodCoc(const Value: String);
begin
  If (FCodCoc <> Value) Then
    FCodCoc := Value;
end;

procedure TfrmHistOcorrencias.setCodGoc(const Value: String);
begin
  If (FCodGoc <> Value) Then
    FCodGoc := Value;
end;

procedure TfrmHistOcorrencias.setCodOco(const Value: String);
begin
  If (FCodOco <> Value) Then
    FCodOco := Value;
end;

procedure TfrmHistOcorrencias.setCodToc(const Value: String);
begin
  If (FCodToc <> Value) Then
    FCodToc := Value;
end;

procedure TfrmHistOcorrencias.SetDtaAge(const Value: String);
begin
  FDtaAge := Value;
end;

procedure TfrmHistOcorrencias.SetHraAge(const Value: String);
begin
  FHraAge := Value;
end;

procedure TfrmHistOcorrencias.setNomCli(const Value: String);
begin
  If (FNomCli <> Value) Then
    FNomCli := Value;
end;

procedure TfrmHistOcorrencias.setNomCoc(const Value: String);
begin
  If (FNomCoc <> Value) Then
    FNomCoc := Value;
end;

procedure TfrmHistOcorrencias.setNomGoc(const Value: String);
begin
  If (FNomGoc <> Value) Then
    FNomGoc := Value;
end;

procedure TfrmHistOcorrencias.setNomToc(const Value: String);
begin
  If (FNomToc <> Value) Then
    FNomToc := Value;
end;

procedure TfrmHistOcorrencias.setObserv(const Value: String);
begin
  if (FObserv <> Value) then
    FObserv := Value;
end;

procedure TfrmHistOcorrencias.setProtoc(const Value: String);
begin
  If (FProtoc <> Value) Then
    FProtoc := Value;
end;

procedure TfrmHistOcorrencias.setTip_Fc(const Value: String);
begin
  If (FTip_Fc <> Value) Then
    FTip_Fc := Value;
end;

end.
