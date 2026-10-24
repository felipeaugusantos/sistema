unit untCadAcaoAutomaticaCRM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass, Uni,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, untCRMGeracaoGlobalFrameParametros, untTCRMGeracaoGlobal,
  EditFocus, MemoFocus, QColorLabel;

type
  TfrmCadAcaoAutomaticaCRM = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    pnlCabecalho: TPanel;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    lblVigencia: TLabel;
    lblA: TLabel;
    dbeDtaIni: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dbeCodAca: TDBEditFocus;
    dbeDtaFin: TDBEditFocus;
    gbxParametros: TGroupBox;
    pgcParametros: TPageControl;
    tbsParCon: TTabSheet;
    tbsParCRM: TTabSheet;
    fraCRMGeracaoGlobalFrameParametros: TfraCRMGeracaoGlobalFrameParametros;
    Label10: TLabel;
    edtCodGoc: TEditFocus;
    edtDesGoc: TEditFocus;
    gbxInformacoesGerais: TGroupBox;
    Label11: TLabel;
    edtCodToc: TEditFocus;
    edtDesToc: TEditFocus;
    Label1: TLabel;
    Label9: TLabel;
    edtComple: TEditFocus;
    edtDesComple: TEditFocus;
    edtCodSit: TEditFocus;
    edtDesSit: TEditFocus;
    Label6: TLabel;
    edtCodOpe: TEditFocus;
    edtDesOpeOco: TEditFocus;
    mDescricao: TMemoFocus;
    ColorLabel51: TColorLabel;
    dbeAtiva: TDBEditFocus;
    ColorLabel52: TColorLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dtsTabelaStateChange(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodGocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCompleKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSitKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
    procedure fraCentroCustoedtCodEveKeyPress(Sender: TObject; var Key: Char);
  private
    FParamCon: TParametroConGeracaoGlobal;
    FParamCRM: TParametroCrmGeracaoGlobal;
    FParamPRM: TParametroPrmGeracaoGlobal;
    qryCadGoc: TUniQuery;
    qryCadToc: TUniQuery;
    qryCadCoc: TUniQuery;
    qryCadOpe: TUniQuery;
    FstrTip_Fc: String;
    blnOpeCadCli : Boolean;
    blnCancelando: Boolean;
    strAtivaAnt: String;
    dtaVigIniAnt: TDateTime;
    dtaVigFimAnt: TDateTime;

    function getParamCon: TParametroConGeracaoGlobal;
    function getParamCRM: TParametroCrmGeracaoGlobal;
    function getParamPRM: TParametroPrmGeracaoGlobal;

    function fJaExisteParametrosDeConsulta: Boolean;

    procedure pReset;
    procedure pLimparParams;
    procedure pSetaDataScreen;
    procedure pSetaParamClass;
    procedure pAdicionaMascaras;
    procedure pLimparComponentes;
    procedure pCarregarParametros;
    procedure pCarregaTipoOcorrencia;
    procedure pCarregaGrupoOcorrencia;
    procedure pCarregaUsuarioOcorrencia;
    procedure pCarregaComplementoOcorrencia;
    procedure pHabilitaComponentes(Const blnHabilitar: Boolean);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    property strTip_Fc: String Read FstrTip_Fc Write FstrTip_Fc;
  end;

implementation

uses
  Rest.JSON,
  untPesqAux,
  untConsultas,
  untFuncoesCRM,
  untHelperCitel,
  untTypesSistema,
  untFuncoesSimples,
  untLiberacao;

{$R *.dfm}

procedure TfrmCadAcaoAutomaticaCRM.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodAca, dbeDescri, False);
  pAdicionaMascaras();
  strAtivaAnt := dbeAtiva.Text;
  dtaVigIniAnt := StrToDateTimeDef(dbeDtaIni.Text,0);
  dtaVigFimAnt := StrToDateTimeDef(dbeDtaFin.Text,0);
end;

procedure TfrmCadAcaoAutomaticaCRM.btnCancelaClick(Sender: TObject);
begin
  blnCancelando := True;
  try
    inherited;
    pReset();
    pCarregarParametros();
  finally
    blnCancelando := False;
  end;
end;

procedure TfrmCadAcaoAutomaticaCRM.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadAcaoAutomaticaCRM.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pReset();
  pCarregarParametros();
end;

procedure TfrmCadAcaoAutomaticaCRM.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If (Not fValidaCampos(edtCodOpe, True)) Then // Feito para não dar mensagem no meio da transação
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  pSetaParamClass();
  qryTabela.FieldByName('ACA_PARCON').AsString := TJSON.ObjectToJsonString(getParamCon());
  qryTabela.FieldByName('ACA_PARCRM').AsString := TJSON.ObjectToJsonString(getParamCRM());

  If fJaExisteParametrosDeConsulta() Then
  Begin
    fMensagem('', 'Não é possível incluir uma nova ação com parâmetros já existentes em ações no período vigente informado!', ['&OK']);
    Exit;
  End;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadAcaoAutomaticaCRM.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pgcParametros.ActivePage := tbsParCon;
  fraCRMGeracaoGlobalFrameParametros.pgcFiltros.ActivePage := fraCRMGeracaoGlobalFrameParametros.tbsDadosCliente;
end;

procedure TfrmCadAcaoAutomaticaCRM.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodAca, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodAca, dbeCodAca, True);

  pReset();
  pCarregarParametros();
end;

procedure TfrmCadAcaoAutomaticaCRM.btnPesquisaClick(Sender: TObject);
  Var
    arrAca : TConsultasArray;
    chrKey : Char;
begin
  inherited;
  chrKey := '/';
  If fPesqAcoesAutomaticasCRM(Self, Nil, Nil, qryTabela, chrKey, arrAca) Then
  Begin
    pSetFocus(btnAlterar);
    pCarregarParametros();
  End;
end;

procedure TfrmCadAcaoAutomaticaCRM.dtsTabelaStateChange(Sender: TObject);
begin
  inherited;
  If blnCancelando Then
    Exit;

  If Not (dtsTabela.DataSet.State in dsEditModes) Then
    pCarregarParametros();

  pHabilitaComponentes((dtsTabela.DataSet.State in dsEditModes));
end;

procedure TfrmCadAcaoAutomaticaCRM.edtCodGocKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTOcorr: TConsultasArray;
begin
  inherited;
  If fPesqGruposOcorrencias(Self, edtCodGoc, edtDesGoc, nil, Key, arrTOcorr) Then
  Begin
    If fValidaCampos(edtCodGoc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAcaoAutomaticaCRM.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrOpe: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodOpe, edtDesOpeOco, nil, Key, arrOpe) then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAcaoAutomaticaCRM.edtCodSitKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqSitOcorrencias(Self, edtCodSit, edtDesSit, Nil, Key, arrSel, True, True, edtCodToc.Text ) Then
  Begin
    If fValidaCampos(edtCodSit, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAcaoAutomaticaCRM.edtCodTocKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTOcorr: TConsultasArray;
begin
  inherited;
  If fPesqTiposOcorrencias(Self, edtCodToc, edtDesToc, nil, Key, arrTOcorr, True, edtCodGOc.Text) Then
  Begin
    If fValidaCampos(edtCodToc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAcaoAutomaticaCRM.edtCompleKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCOcorr: TConsultasArray;
begin
  If fPesqComplementosOcorrencias(Self, edtComple, edtDesComple, nil, Key, arrCOcorr, True, edtCodToc.Text) Then
  Begin
    If fValidaCampos(edtComple, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAcaoAutomaticaCRM.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'ACACRM';
  strNomeCampo      := 'ACA_CODACA';
  qryTabela         := fCriarQuery('SELECT * FROM ACACRM WHERE FALSE', Self);;
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodAca;

  fraCRMGeracaoGlobalFrameParametros.ParentForm := Self;

  fraCRMGeracaoGlobalFrameParametros.blnLiberadoVendedor      := fVerificaAcessoSistema('CRMGBV', strLoginUsuarioLogado);
  fraCRMGeracaoGlobalFrameParametros.blnLiberadoRepresentante := fVerificaAcessoSistema('CRMGBR', strLoginUsuarioLogado);

  qryCadGoc         := fCriarQuery('SELECT * FROM CADGOC WHERE FALSE', Self);
  qryCadToc         := fCriarQuery('SELECT * FROM CADTOC WHERE FALSE', Self);
  qryCadCoc         := fCriarQuery('SELECT * FROM CADCOC WHERE FALSE', Self);
  qryCadOpe         := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);

  FstrTip_Fc        := 'C';
  blnOpeCadCli      := False;
end;

procedure TfrmCadAcaoAutomaticaCRM.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(FParamCon) Then
    FreeAndNil(FParamCon);
  FreeAndNil(qryCadGoc);
  FreeAndNil(qryCadToc);
  FreeAndNil(qryCadCoc);
  FreeAndNil(qryCadOpe);
end;

procedure TfrmCadAcaoAutomaticaCRM.FormShow(Sender: TObject);
begin
  inherited;
  pAdicionaMascaras();
  pReset();
end;

procedure TfrmCadAcaoAutomaticaCRM.fraCentroCustoedtCodEveExit(Sender: TObject);
begin
  inherited;
  fraCRMGeracaoGlobalFrameParametros.fraCentroCustoedtCodEveExit(Sender);

end;

procedure TfrmCadAcaoAutomaticaCRM.fraCentroCustoedtCodEveKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  fraCRMGeracaoGlobalFrameParametros.fraCentroCustoedtCodEveKeyPress(Sender,
  Key);

end;

function TfrmCadAcaoAutomaticaCRM.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  objLiberacao : TLiberacao;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeDtaIni) Then
    Begin
      If fEmptyDate(dbeDtaIni.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        dbeDtaIni.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(dbeDtaIni.Text,0));
        If StrToDateDef(dbeDtaIni.Text,0) = 0 Then
        Begin
          Result := False;
          fMensagem('','Informe uma data válida!', ['&OK']);
        End;

        If (dtaVigIniAnt <> StrToDateDef(dbeDtaIni.Text,0)) And (dtaVigIniAnt > 0) Then
        Begin
          objLiberacao := TLiberacao.Create;
          Try
            objLiberacao.objMsgLibera.strtitulo := 'Alterar Vigência do Cadastro de Ação Automática';
            objLiberacao.objMsgLibera.pAddSeparador(100);
            objLiberacao.objMsgLibera.pAddTextoCaption('Data vigência (inicial) atual', dbeDtaIni.Text);
            objLiberacao.objMsgLibera.pAddTextoCaption('Data vigência (inicial) anterior', DateTimeToStr(dtaVigIniAnt));
            objLiberacao.strDirAce := 'VIGAUT';
            objLiberacao.strSenLib := fCfgSis('SENVIG');
            objLiberacao.strMsgSen := 'Status da Vigência do Cadastro de Ação Automática';
            objLiberacao.blnMosMen  := True;
            objLiberacao.strCodOpe  := strLoginUsuarioLogado;
            objLiberacao.strCodDig  := strLoginUsuarioLogado;

            Result := objLiberacao.fLibera;

            If Not Result Then
              dbeDtaIni.Text := DateTimeToStr(dtaVigIniAnt)
            Else
              dtaVigIniAnt := StrToDateDef(dbeDtaIni.Text,0);
          Finally
            FreeAndNil(objLiberacao);
          End;
        End;
      End;
    End
    Else If (Sender = dbeDtaFin) Then
    Begin
      If fEmptyDate(dbeDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        dbeDtaFin.Text := FormatDateTime('dd/mm/yyyy', StrToDateDef(dbeDtaFin.Text,0));

        If StrToDateDef(dbeDtaFin.Text,0) < StrToDateDef(dbeDtaIni.Text,0) Then
        Begin
          Result := False;
          fMensagem('', 'A data final deve ser maior ou igual a data inicial!', ['&OK']);
        End;

        If (dtaVigFimAnt <> StrToDateDef(dbeDtaFin.Text,0)) And (dtaVigFimAnt > 0) Then
        Begin
          objLiberacao := TLiberacao.Create;
          Try
            objLiberacao.objMsgLibera.strtitulo := 'Alterar Vigência do Cadastro de Ação Automática';
            objLiberacao.objMsgLibera.pAddSeparador(100);
            objLiberacao.objMsgLibera.pAddTextoCaption('Data vigência (final) atual', dbeDtaFin.Text);
            objLiberacao.objMsgLibera.pAddTextoCaption('Data vigência (final) anterior', DateTimeToStr(dtaVigFimAnt));
            objLiberacao.strDirAce := 'VIGAUT';
            objLiberacao.strSenLib := fCfgSis('SENVIG');
            objLiberacao.strMsgSen := 'Status da Vigência do Cadastro de Ação Automática';
            objLiberacao.blnMosMen  := True;
            objLiberacao.strCodOpe  := strLoginUsuarioLogado;
            objLiberacao.strCodDig  := strLoginUsuarioLogado;

            Result := objLiberacao.fLibera;

            If Not Result Then
              dbeDtaFin.Text := DateTimeToStr(dtaVigFimAnt)
            Else
              dtaVigFimAnt := StrToDateDef(dbeDtaFin.Text,0);
          Finally
            FreeAndNil(objLiberacao);
          End;
        End;
      End;
    End
    Else If (Sender = edtCodGoc) Then
    Begin
      If fEmptyStr(edtCodGoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do Grupo da Ocorrência deve ser preenchido!', ['&Ok']);
        edtDesGoc.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaGrupoOcorrencia;
        If qryCadGoc.FieldByName('GOC_CODGOC').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Grupo de Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else
        If not fVerificaDireitoAcessoGrupoOcorrencia(qryCadGoc.FieldByName('GOC_CODGOC').AsString) Then
        Begin
          Result := False;
          fMensagem('', 'Usuário sem permissão para utilizar este grupo de ocorrência!', ['&Ok']);
        End;

      End;

      If Result And blnBuscaPorChave And (not fEmptyStr(edtCodToc.Text)) Then
      Begin
        Result := fValidaCampos(edtCodToc, True);
        If Not Result Then
          Sender := edtCodToc;
      End;
    End
    Else If (Sender = edtCodToc) Then
    Begin
      If fEmptyStr(edtCodToc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Tipo de Ocorrência deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaTipoOcorrencia;
        If qryCadToc.FieldByName('TOC_CODTOC').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código de Tipo de Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End;
        If Result Then
        Begin
          If (FstrTip_Fc = 'P') Then
          Begin
            If qryCadToc.FieldByName('TOC_USACLI').AsString <> 'S' Then
            Begin
              Result := False;
              pMensagemOk('Tipo de Ocorrência não permitido para Clientes!');
            End;
          End
          Else If (FstrTip_Fc = 'P') Then
          Begin
            If qryCadToc.FieldByName('TOC_USAPRO').AsString <> 'S' Then
            Begin
              Result := False;
              pMensagemOk('Tipo de Ocorrência não permitido para Prospectos!');
            End;
          End;

          If Result Then
          Begin
            If qryCadToc.FieldByName('TOC_USAGLO').AsString <> 'S' Then
            Begin
              Result := False;
              pMensagemOk('Tipo de Ocorrência não permitido para Geração Global de Ocorrências!');
            End;
          End;
        End;
      End;
    End
    Else If (Sender = edtComple) Then
    Begin
      if not fEmptyStr(edtComple.Text) then
      begin
        pCarregaComplementoOcorrencia;
        If qryCadCoc.FieldByName('COC_CODCOC').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código de Complemento da Ocorrência não está cadastrado!', ['&Ok']);
          edtDesToc.Clear;
          Result := False;
        End
      end;
    End
    Else
    If (Sender = edtCodSit) Then
    Begin
      If not fEmptyStr(edtCodSit.Text) Then
      Begin
        edtDesSit.Text := fRetDesSitOco(edtCodSit.Text);
        If fEmptyStr(edtDesSit.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'O código da situação informado é inválido!', ['&Ok']);
          Result := False;
        End
        Else
        If Pos(edtCodToc.Text, fRetTocSitOco(edtCodToc.Text)) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'A situação escolhida não pertence ao tipo selecionado!', ['&Ok']);
          edtDesSit.Clear;
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodOpe) Then
    Begin
      If fEmptyStr(edtCodOpe.Text) And (FstrTip_Fc = 'C') Then
      Begin
        if (Not blnOpeCadCli) And blnBuscaPorChave Then
        Begin
          blnOpeCadCli := fMensagem('ATENÇÃO!', 'Deseja preencher o usuário com o mesmo vendedor do Cadastro de Clientes?', ['&Sim', '&Não'],1) = 1;
          Result := blnOpeCadCli;

          If not Result Then
            fMensagem('','É obrigatório o preenchimento do código do operador!',['&OK'])
          Else
            edtDesOpeOco.Text := 'Vendedor do cliente';
        End;
      End
      Else
      Begin
        blnOpeCadCli := False;
        pCarregaUsuarioOcorrencia;
        If qryCadOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Código do Usuário da Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeAtiva) Then
    Begin
      If fEmptyStr(dbeAtiva.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Ativa" deve se preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (strAtivaAnt <> dbeAtiva.Text) And (Not fEmptyStr(strAtivaAnt)) Then
        Begin
          objLiberacao := TLiberacao.Create;
          Try
            objLiberacao.objMsgLibera.pAddTexto('Permissão Status do Cadastro de Ação Automática');
            objLiberacao.objMsgLibera.pAddSeparador(100);
            objLiberacao.objMsgLibera.pAddTextoCaption('Status Atual', IIF(dbeAtiva.Text = 'S', 'Ativo', 'Inativo'));
            objLiberacao.objMsgLibera.pAddTextoCaption('Status Anterior', IIF(strAtivaAnt = 'S', 'Ativo', 'Inativo'));
            objLiberacao.strDirAce := 'STAATV';
            objLiberacao.strSenLib := fCfgSis('SENATV');
            objLiberacao.strMsgSen := 'Status do Cadastro de Ação Automática';
            objLiberacao.blnMosMen  := True;
            objLiberacao.strCodOpe  := strLoginUsuarioLogado;
            objLiberacao.strCodDig  := strLoginUsuarioLogado;

            Result := objLiberacao.fLibera;

            If Not Result Then
              dbeAtiva.Text := strAtivaAnt
            Else
              strAtivaAnt := dbeAtiva.Text;
          Finally
            FreeAndNil(objLiberacao);
          End;
        End;
      End;
    End;
  End;

  If Result Then
    Result := fraCRMGeracaoGlobalFrameParametros.fValidaCampos(Sender, blnBuscaPorChave);

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadAcaoAutomaticaCRM.fJaExisteParametrosDeConsulta: Boolean;
  Var
    qryGen: TUniQuery;
begin
  Result := False;
  qryGen := fCriaQuery(Self);

  Try
    qryGen.SQL.Add('SELECT C.ACA_PARCON                                       ');
    qryGen.SQL.Add('  FROM ACACRM C                                           ');
    qryGen.SQL.Add(' WHERE C.AUTOINCREM <> :AUTINC                            ');
    qryGen.SQL.Add('   AND ((:DTAINI BETWEEN C.ACA_DTAINI AND C.ACA_DTAFIN) OR');
    qryGen.SQL.Add('        (:DTAFIN BETWEEN C.ACA_DTAINI AND C.ACA_DTAFIN))  ');
    qryGen.ParamByName('AUTINC').AsString   := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryGen.ParamByName('DTAINI').AsDateTime := qryTabela.FieldByName('ACA_DTAINI').AsDateTime;
    qryGen.ParamByName('DTAFIN').AsDateTime := qryTabela.FieldByName('ACA_DTAFIN').AsDateTime;
    qryGen.Open;

    While (Not qryGen.Eof) And (Not Result) Do
    Begin
      Result := qryTabela.FieldByName('ACA_PARCON').AsString = qryGen.FieldByName('ACA_PARCON').AsString;
      qryGen.Next();
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmCadAcaoAutomaticaCRM.getParamCon: TParametroConGeracaoGlobal;
begin
  If Not Assigned(FParamCon) Then
  Begin
    If fEmptyStr(qryTabela.FieldByName('ACA_PARCON').AsString) Then
      FParamCon := TParametroConGeracaoGlobal.Create
    Else
      FParamCon := TJSON.JsonToObject<TParametroConGeracaoGlobal>(qryTabela.FieldByName('ACA_PARCON').AsString);
  End;

  Result := FParamCon;
end;

function TfrmCadAcaoAutomaticaCRM.getParamCRM: TParametroCrmGeracaoGlobal;
begin
  If Not Assigned(FParamCRM) Then
  Begin
    If fEmptyStr(qryTabela.FieldByName('ACA_PARCRM').AsString) Then
      FParamCRM := TParametroCrmGeracaoGlobal.Create
    Else
      FParamCRM := TJSON.JsonToObject<TParametroCrmGeracaoGlobal>(qryTabela.FieldByName('ACA_PARCRM').AsString);
  End;

  Result := FParamCRM;
end;

function TfrmCadAcaoAutomaticaCRM.getParamPRM: TParametroPrmGeracaoGlobal;
begin
  If Not Assigned(FParamPRM) Then
  Begin
    FParamPRM := TParametroPrmGeracaoGlobal.Create;
  End;

  Result := FParamPRM;
end;

procedure TfrmCadAcaoAutomaticaCRM.pAdicionaMascaras;
begin
  with qryTabela do
  begin
    TDateField(FieldByName('ACA_DTAINI')).EditMask := '99/99/9999';
    TDateField(FieldByName('ACA_DTAFIN')).EditMask := '99/99/9999';
  end;
end;

procedure TfrmCadAcaoAutomaticaCRM.pCarregaComplementoOcorrencia;
begin
  if (fEmptyStr(edtCodToc.Text)) And (dtsTabela.State in [dsInsert, dsEdit]) then
  begin
    fMensagem('Informação!','Favor Informar o Tipo da Ocorrência!',['OK']);
    edtComple.Clear;
    edtDesComple.Clear;
    Exit;
  end;

  pPesquisaCadCoc(qryTabela, qryCadCoc, edtComple.Text, edtCodToc.Text);
  With qryCadCoc Do
  Begin
    edtDesComple.Text := FieldByName('COC_DESCOC').AsString;
  End;
end;

procedure TfrmCadAcaoAutomaticaCRM.pCarregaGrupoOcorrencia;
begin
  pPesquisaCadGOc(nil, qryCadGoc, edtCodGoc.Text);
  With qryCadGoc Do
  Begin
    edtDesGoc.Text := FieldByName('GOC_DESGOC').AsString;
  End;
end;

procedure TfrmCadAcaoAutomaticaCRM.pCarregarParametros;
begin
  pLimparParams();
  fraCRMGeracaoGlobalFrameParametros.ParamCon := getParamCon();
  fraCRMGeracaoGlobalFrameParametros.ParamPRM := getParamPrm();
  getParamCRM();

  If (Not (qryTabela.State in [dsInsert])) And
    (Not qryTabela.IsEmpty) Then
  Begin
    If (Not fEmptyStr(qryTabela.FieldByName('ACA_PARCON').AsString)) Then
      fraCRMGeracaoGlobalFrameParametros.pSetaDataScreen();

    If (Not fEmptyStr(qryTabela.FieldByName('ACA_PARCRM').AsString)) Then
      pSetaDataScreen();
  End;
end;

procedure TfrmCadAcaoAutomaticaCRM.pCarregaTipoOcorrencia;
begin
  if (fEmptyStr(edtCodGoc.Text)) And (dtsTabela.State in [dsInsert, dsEdit]) then
  begin
    fMensagem('Informação!','Favor Informar o Grupo da Ocorrência!',['OK']);
    edtCodToc.Clear;
    edtDesToc.Clear;
    Exit;
  end;

  pPesquisaCadToc(qryTabela, qryCadToc, edtCodToc.Text, edtCodGoc.Text);
  With qryCadToc Do
  Begin
    edtDesToc.Text := FieldByName('TOC_DESTOC').AsString;
  End;
end;

procedure TfrmCadAcaoAutomaticaCRM.pCarregaUsuarioOcorrencia;
begin
  pPesquisaCadOpe(qryTabela, qryCadOpe, edtCodOpe.Text);
  With qryCadOpe Do
  Begin
    edtDesOpeOco.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmCadAcaoAutomaticaCRM.pLimparComponentes;
begin
  edtCodGoc.Clear;
  edtDesGoc.Clear;
  edtCodToc.Clear;
  edtDesToc.Clear;
  edtComple.Clear;
  edtDesComple.Clear;
  edtCodSit.Clear;
  edtDesSit.Clear;
  edtCodOpe.Clear;
  edtDesOpeOco.Clear;
  mDescricao.Clear;
end;

procedure TfrmCadAcaoAutomaticaCRM.pHabilitaComponentes(
  const blnHabilitar: Boolean);
begin
  fraCRMGeracaoGlobalFrameParametros.pHabilitarComponentes(blnHabilitar);

  edtCodGoc.Enabled := blnHabilitar;
  edtCodToc.Enabled := blnHabilitar;
  edtComple.Enabled := blnHabilitar;
  edtCodSit.Enabled := blnHabilitar;
  edtCodOpe.Enabled := blnHabilitar;
  mDescricao.Enabled:= blnHabilitar;
end;

procedure TfrmCadAcaoAutomaticaCRM.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('ACA_CODACA');
  stlCampos.Add('ACA_DESCRI');
  stlCampos.Add('ACA_DTAINI');
  stlCampos.Add('ACA_DTAFIN');
  stlCampos.Add('ACA_PARCON');
  stlCampos.Add('ACA_PARCRM');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('ACA_CODACA');
  stlCamInd.Add('ACA_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadAcaoAutomaticaCRM.pLimparParams;
begin
  fraCRMGeracaoGlobalFrameParametros.ParamCon := nil;
  FreeAndNil(FParamCon);
  FreeAndNil(FParamCRM);
  FreeAndNil(FParamPRM);
end;

procedure TfrmCadAcaoAutomaticaCRM.pReset;
begin
  pAdicionaMascaras();
  pLimparComponentes();
  blnOpeCadCli := False;
  fraCRMGeracaoGlobalFrameParametros.pLimparComponentes();
  pgcParametros.ActivePage := tbsParCon;
  fraCRMGeracaoGlobalFrameParametros.pgcFiltros.ActivePage := fraCRMGeracaoGlobalFrameParametros.tbsDadosCliente;
end;

procedure TfrmCadAcaoAutomaticaCRM.pSetaDataScreen;
begin
  edtCodGoc.Text  := getParamCRM().strCodGoc;
  edtCodToc.Text  := getParamCRM().strCodToc;
  edtComple.Text  := getParamCRM().strCodCoc;
  edtCodSit.Text  := getParamCRM().strCodSit;
  mDescricao.Text := getParamCRM().strDescri;
  blnOpeCadCli    := getParamCRM().blnOpeCaC;

  If blnOpeCadCli Then
    edtDesOpeOco.Text := 'Vendedor do cliente'
  Else
    edtCodOpe.Text  := getParamCRM().strCodOpe;

  fValidaCampos(edtCodGoc, True);
  fValidaCampos(edtCodToc, True);
  fValidaCampos(edtComple, True);
  fValidaCampos(edtCodSit, True);
  fValidaCampos(edtCodOpe, True);
end;

procedure TfrmCadAcaoAutomaticaCRM.pSetaParamClass;
begin
  fraCRMGeracaoGlobalFrameParametros.pSetaParamClass();

  getParamCRM().strCodGoc := edtCodGoc.Text;
  getParamCRM().strCodToc := edtCodToc.Text;
  getParamCRM().strCodCoc := edtComple.Text;
  getParamCRM().strCodSit := edtCodSit.Text;
  getParamCRM().strCodOpe := edtCodOpe.Text;
  getParamCRM().strDescri := mDescricao.Text;
  getParamCRM().strTip_Fc := FstrTip_Fc;

  If fEmptyStr(getParamCRM().strOpeOco) Then
    getParamCRM().strOpeOco := strLoginUsuarioLogado;

  getParamCRM().blnOpeCaC := blnOpeCadCli;
end;

end.
