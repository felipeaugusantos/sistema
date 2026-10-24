unit Contabilidade.View.GeracaoLancamentoContabil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, ComboBoxFocus,
  EditFocus, Vcl.Mask, MaskEditFocus, Contabilidade.Classes.TDadosAbertura,
  cxProgressBar, UniClientDataSet, Contabilidade.View.TfrmPaiContabilidade, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, System.StrUtils, Uni, Contabilidade.Interfaces,
  untTypesSistema, Vcl.CheckLst, System.Generics.Collections,
  Contabilidade.Classes.TListaValidacoesContabeis;

type
  TfrmGerLanCon = class(TfrmPaiContabilidade)
    Panel1: TPanel;
    Label2: TLabel;
    lblCodEmp: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    btnGerar: TBitBtnLocked;
    Label3: TLabel;
    cklListaTipos: TCheckListBox;
    chkLancarFinalPreValidacao: TCheckBox;
    btnCheckList: TBitBtnLocked;
    chkRaizCnpjEmpresa: TCheckBox;
    btnLancamentos: TBitBtn;
    chkSomenteComErro: TCheckBox;
    btnLancamentosComErro: TBitBtnLocked;
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cklListaTiposKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCheckListClick(Sender: TObject);
    procedure chkRaizCnpjEmpresaClick(Sender: TObject);
    procedure btnLancamentosClick(Sender: TObject);
    procedure chkSomenteComErroClick(Sender: TObject);
    procedure btnLancamentosComErroClick(Sender: TObject);
  private
    { Private declarations }
    blnPreValidar : Boolean;
    FDadosAbertura: TDadosAbertura;
    LTipoContabilSelecionado : TTiposContabeis;
    objListaValidacoesContabeis : TListaValidacoesContabeis;
    // TInterfacedObject: sem uma referencia de interface, o primeiro cast (exibicao das advertencias)
    // o destroi e a geracao segue com o ponteiro solto. Atualizar junto com objListaValidacoesContabeis.
    FintfListaValidacoes: IUpdateContaContabil;
    FarrEmp: TConsultasArray;
    FcdsPlancoInfo: TUniClientDataSet;
    FTipoSelecionadoComNatureza: TStringList;
    // Req. 470760 - geracao sem os documentos com erro e reprocesso so deles.
    FblnReprocessaErros: Boolean;
    FlstDocExcluir: TStringList;
    FlstDocReprocesso: TStringList;
    FlstEmpCmvComErro: TStringList;
    FlstEmpCmvReprocesso: TStringList;
    FdicDocsReprocesso: TDictionary<String, TArrIncDoc>;
    FcdsPendenciasReprocesso: TUniClientDataSet;
    function fConfirmar(pgbProgresso: TcxProgressBar): Boolean;
    function fConfirmarCTP(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCarregarDadosAbertura(pgbProgresso: TcxProgressBar; const AstrCodEmp: String);
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    procedure pListarErrosContabeis(const AUpdateContaContabil: IUpdateContaContabil; const ADataSet: TUniClientDataSet);
    function fRetTipoExportacao(const ATipoContabil: TTiposContabeis): string;
    function fSiglaExportacao(const ATipoContabil: TTiposContabeis; stlSiglasAdicionais: TStringList): String;
    function fExecutarGeracao(const ATipo: TTiposContabeis): boolean;
    procedure pEstadoBotao(blnHabilita: Boolean);
    function fTemTipoMarcado: boolean;
    function fTemTipoComNaturezaMarcado: boolean;
    function fTravouTodosOsTiposSelecionados: boolean;
    function fRetornaTiposSelecionadosComNaturezaParaFiltroSql(): string;
    procedure pDestravaTodosTiposSelecionados;
    procedure pPopularTiposCheckListBox;
    function fEfetivarLancamentos(const APreValidar: boolean): boolean;
    function fPodeSelecionarTipo: boolean;
    function fExisteMovimento: Boolean;
    procedure pMostraWarningNaValidacaoContabil(AobjListaValidacoesContabeis : TListaValidacoesContabeis) ;
    procedure pAjustaArrayEmpresas ;
    procedure pRecriaObjListaValidacoesContabeis ;
    function fTiposContabeisSelecionados: TSetTiposContabeis ;
    procedure pMostraConferenciaNaturezaSemParcon;
    function fPodeIniciarGeracao(const AblnReprocesso: Boolean): Boolean;
    // True tambem quando a sigla nao precisa rodar (reprocesso sem documento dela, CMV com erro).
    function fGerarSigla(const AstrSigla: String; ArecParCon: TParametrosConsulta; pgbProgresso: TcxProgressBar; const AobjValida: IValidaContaContabil): Boolean;
    // False: reprocesso sem documento pendente da empresa, o CTP/PCP dela nao roda.
    function fPreparaDadosAberturaReprocesso(const AstrCodEmp: String): Boolean;
    function fSiglasDoTipo(const ATipo: TTiposContabeis): TArray<String>;
    function fTipoDaSigla(const AstrSigla: String): String;
    function fChaveExclusao(const AcdsErros: TUniClientDataSet): String;
    function fPodeGerarSemOsDocumentosComErro: Boolean;
    function fTemErroForaDaExclusao(const AcdsErros: TUniClientDataSet): Boolean;
    function fEmpresasSelecionadas: TArray<String>;
    function fEmpresaChave(const AstrCodEmpDoc: String): String;
    function fTiposSelecionados: TArray<String>;
    procedure pMontarExclusao(const AcdsErros: TUniClientDataSet);
    procedure pMontarReprocesso(const AcdsPendencias: TUniClientDataSet);
    procedure pGerarSemOsDocumentosComErro(const AstrPergunta: String);
    procedure pReprocessarPendencias(const AcdsPendencias: TUniClientDataSet);
    // AcdsErros nil: so tira da CONPEN o que a geracao acabou de processar.
    procedure pAtualizarPendencias(const AcdsErros: TUniClientDataSet);
    // Marca o check list dos dias reprocessados; devolve quantos documentos pendentes nao foram localizados.
    function fConcluirReprocesso: Integer;
    procedure pAvisarReprocesso(const AstrMensagemOk: String);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmGerLanCon: TfrmGerLanCon;

implementation

uses
  Contabilidade.Classes.TGerLanCon,
  Contabilidade.Classes.TValidaContasContabeis, Contabilidade.Funcoes,
  Contabilidade.Classes.TGeradorContabil, Contabilidade.View.ErrosContabeis,
  Data.DB, untConsultas, untFuncoesSimples,
  Contabilidade.View.CheckListImportacao,
  Contabilidade.Classes.TControleContabilidade,
  Contabilidade.Classes.FechamentoDiaMes,
  System.DateUtils, Contabilidade.View.ConferenciaNaturezaOperacaoParcon,
  Contabilidade.Classes.CheckListImportacao;

{$R *.dfm}

procedure TfrmGerLanCon.btnLancamentosClick(Sender: TObject);
begin
  inherited;

  if (not fVerificaAcessoSistema(NOME_FRM_LOTES_CONTABEIS)) then
  begin
    fMensagem('ATENÇÃO','Operador não possui acesso para visualizar informações de ' + CAPTION_MENU_LOTES_CONTABEIS + '.',['&OK']);
    Exit;
  end;

  TMenuContabilidade.mnuLanLotesContabeisClick(Nil) ;
end;

procedure TfrmGerLanCon.btnCheckListClick(Sender: TObject);
var
  LfrmCheckListImportacao : TfrmCheckListImportacao;
begin
  pCriarFormularios(TfrmCheckListImportacao, LfrmCheckListImportacao);
  try
    LfrmCheckListImportacao.ShowModal;
  finally
    pFreeAndNil(LfrmCheckListImportacao);
  end;
end;

procedure TfrmGerLanCon.btnGerarClick(Sender: TObject);
begin
  if not fPodeIniciarGeracao(False) then
    Exit;

  objListaValidacoesContabeis := TListaValidacoesContabeis.Create;
  FintfListaValidacoes := objListaValidacoesContabeis;
  pEstadoBotao(False);
  FcdsPlancoInfo := fCarregaPlancoInfo ;
  Try
    if fEfetivarLancamentos(True) then
    begin

      pMostraWarningNaValidacaoContabil(objListaValidacoesContabeis) ;

      if chkLancarFinalPreValidacao.Checked then
      begin
        pAtualizarPendencias(nil);
        fMensagem('Aviso', 'Geração concluída com sucesso!', ['OK']);
        exit ;
      end ;

      if (fMensagem('Aviso', 'Pré-validação concluída, deseja efetuar a geração?', ['&Sim', '&Não'], 1) = 1) then
      begin
        pRecriaObjListaValidacoesContabeis ;
        if fEfetivarLancamentos(False) then
        begin
          pAtualizarPendencias(nil);
          fMensagem('Aviso', 'Geração concluída com sucesso!', ['OK']);
        end;
      end ;
    end
    else if (not objListaValidacoesContabeis.getDataSet.IsEmpty) then
    begin
      if fPodeGerarSemOsDocumentosComErro then
        pGerarSemOsDocumentosComErro('Durante a Geração do(s) Movimento(s), foi(ram) identificado(s) Registro(s) com ERRO(S) que impedem a sua geração. Gostaria de visualizar o(s) Registro(s)?')
      else
        pListarErrosContabeis(objListaValidacoesContabeis as IUpdateContaContabil, objListaValidacoesContabeis.getDataSet);
    end;
  Finally
    FcdsPlancoInfo.EmptyDataSet ;
    FreeAndNil(FcdsPlancoInfo) ;
    pDestravaTodosTiposSelecionados;
    pEstadoBotao(True);
  End;
end;

function TfrmGerLanCon.fPodeIniciarGeracao(const AblnReprocesso: Boolean): Boolean;
var
  LTiposContabeis: TSetTiposContabeis ;
begin
  Result := False;

  If Not fVerificaCampos Then
    Exit;

  pAjustaArrayEmpresas ;

  if fTemFechamento(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), FarrEmp) then
    Exit;

  LTiposContabeis := fTiposContabeisSelecionados ;
  if TVerificaFechamentoDiaMes.fTemFechamento(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), FarrEmp, True, LTiposContabeis) then
    Exit;

  // O reprocesso de documentos com erro nao apaga o periodo: a pergunta de exclusao nao se aplica.
  if (not AblnReprocesso) and Self.fExisteMovimento then
  begin
    if fMensagem('ATENÇÃO!', 'Já existe dados gerados no período informado. ' + #13#10 +
                          'Confirma a exclusão e nova geração ? ' + #13#10 + #13#10 +
                          'Caso os dados já tenham sido integrados com outro' + #13#10 +
                          'sistema, esse processo deverá ser refeito!', ['&Sim', '&Não'], 1) = 2 then
    begin
      Exit;
    end;
  end;

  if not fTemTipoMarcado then
  begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um tipo contábil para geração!', ['&OK']);
    Exit;
  end;

  if not fPodeSelecionarTipo then
    exit;

  pMostraConferenciaNaturezaSemParcon;

  if not fTravouTodosOsTiposSelecionados then
  begin
    pDestravaTodosTiposSelecionados;
    Exit;
  end;

  Result := True;
end;

procedure TfrmGerLanCon.chkRaizCnpjEmpresaClick(Sender: TObject);
begin
  inherited;
  TCheckBox(Sender).OnClick := nil ;
  try
    if TCheckBox(Sender).Checked then
    begin
      if fEmptyStr(edtCodEmp.Text) or (edtCodEmp.Text = '000') then
      begin
        fMensagem('ATENÇÃO!', 'Selecione uma empresa primeiro!', ['&O k']);
        TCheckBox(Sender).Checked := False;
        pSetFocus(edtCodEmp);
        Exit ;
      end ;
    end ;
    SetLength(FarrEmp, 0);
  finally
    TCheckBox(Sender).OnClick := chkRaizCnpjEmpresaClick ;
  end ;
end;

procedure TfrmGerLanCon.cklListaTiposKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_Return then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmGerLanCon.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, FarrEmp, False) Then
  Begin
    chkRaizCnpjEmpresa.Checked := False ;
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerLanCon.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmGerLanCon.FormCreate(Sender: TObject);
begin
  inherited;
  FcdsPlancoInfo := Nil ;
  if Assigned(procLimparDicionarioCampoTabelaContabilidade) then
    procLimparDicionarioCampoTabelaContabilidade ;

  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;
  FDadosAbertura := TDadosAbertura.Create;
  blnPreValidar := False;

  FTipoSelecionadoComNatureza := TStringList.Create;

  FblnReprocessaErros := False;
  FcdsPendenciasReprocesso := nil;
  FlstDocExcluir := TStringList.Create;
  FlstDocExcluir.Sorted := True;
  FlstDocExcluir.Duplicates := dupIgnore;
  FlstDocReprocesso := TStringList.Create;
  FlstDocReprocesso.Sorted := True;
  FlstDocReprocesso.Duplicates := dupIgnore;
  FlstEmpCmvComErro := TStringList.Create;
  FlstEmpCmvComErro.Sorted := True;
  FlstEmpCmvComErro.Duplicates := dupIgnore;
  FlstEmpCmvReprocesso := TStringList.Create;
  FlstEmpCmvReprocesso.Sorted := True;
  FlstEmpCmvReprocesso.Duplicates := dupIgnore;
  FdicDocsReprocesso := TDictionary<String, TArrIncDoc>.Create;

  // Sem a CONPEN (script ainda nao aplicado) a tela segue no comportamento anterior.
  chkSomenteComErro.Visible := TPendenciaContabil.fTabelaExiste;
  btnLancamentosComErro.Visible := False;

  pPopularTiposCheckListBox;
end;

procedure TfrmGerLanCon.FormDestroy(Sender: TObject);
begin
  FDadosAbertura.Free;
  FreeAndNil(FTipoSelecionadoComNatureza);
  FreeAndNil(FlstDocExcluir);
  FreeAndNil(FlstDocReprocesso);
  FreeAndNil(FlstEmpCmvComErro);
  FreeAndNil(FlstEmpCmvReprocesso);
  FreeAndNil(FdicDocsReprocesso);
  inherited;
end;

function TfrmGerLanCon.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End
      else if not fDataValida(StrToDate(mskDtaIni.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'Data Inicial inválida!', ['&O k']);
        Result := False;
      end
      else if YearOf(strToDate(mskDtaIni.Text)) < 2000 then
      begin
        fMensagem('ATENÇÃO!', 'A Data Inicial informada é muito antiga!', ['&O k']);
        Result := False;
      end
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End
      else if not fDataValida(StrToDate(mskDtaFin.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'Data final inválida!', ['&O k']);
        Result := False;
      end
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      if edtCodEmp.Text <> '000' then
      begin
        If (Not fEmptyStr(edtCodEmp.Text)) Then
        Begin
          SetLength(FarrEmp, 0);
          edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);
          If (fEmptyStr(edtNomEmp.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
            chkRaizCnpjEmpresa.Checked := False ;
            SetLength(FarrEmp, 0);
            Result := False;
          End;
        End
        Else
        begin
          chkRaizCnpjEmpresa.Checked := False ;
          SetLength(FarrEmp, 0);
          edtNomEmp.Clear;
        end ;
      end ;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmGerLanCon.pAjustaArrayEmpresas;
var
  LreqEmpresa: TConsultas ;
begin
  if chkRaizCnpjEmpresa.Checked then
    FarrEmp := fObtemEmpresasFiliais(edtCodEmp.Text)
  else
  begin
    if (Length(FarrEmp) > 0) and (not fEmptyStr(FarrEmp[0].strCodigo)) then
      Exit ;

    SetLength(FarrEmp, 1);
    FillChar(LreqEmpresa, SizeOf(LreqEmpresa), #0);
    LreqEmpresa.strCodigo := edtCodEmp.Text ;
    FarrEmp[0] := LreqEmpresa ;
  end ;

end;

procedure TfrmGerLanCon.pCarregarDadosAbertura(pgbProgresso: TcxProgressBar; const AstrCodEmp: String);
begin
  FDadosAbertura.blnPreValidar := blnPreValidar;
  FDadosAbertura.dtaDataInicial := StrToDate(mskDtaIni.Text);
  FDadosAbertura.dtaDataFinal := StrToDate(mskDtaFin.Text);
  FDadosAbertura.empresa.strCodigo := AstrCodEmp;
  FDadosAbertura.empresa.strDescricao := fRetNomeEmpresa(AstrCodEmp);
  FDadosAbertura.progresso := pgbProgresso;
  FDadosAbertura.strTipoExportacao := fRetTipoExportacao(LTipoContabilSelecionado);
  FDadosAbertura.blnProvisao := (LTipoContabilSelecionado = tcPCP);
  if fConfiguracaoExiste('EXUCCP') then
    FDadosAbertura.blnExportaUsoConsumo := fCfgSis('EXUCCP', varBoolean);
  FDadosAbertura.blnUsaCheckListComplemento := fTabelaExiste('CMPPAR');
  FDadosAbertura.blnConSeqParExiste := fCampoExiste('PARCON', 'CON_SEQPAR');
  FDadosAbertura.blnCON_PAGANT := fCampoExiste('PARCON', 'CON_PAGANT');
  if (FDadosAbertura.blnCON_PAGANT) then
  begin
    FDadosAbertura.blnParametrizouPagamentoAntecipadoAvulso := fCampoTabelaParcon('COUNT(*)', ['CON_PAGANT', 'CON_PAGAME'], ['Sim', 'Pagamentos Avulsos'], True) > 0;
    FDadosAbertura.blnParametrizouPagamentoAntecipadoFatura := fCampoTabelaParcon('COUNT(*)', ['CON_PAGANT', 'CON_PAGAME'], ['Sim', 'Pagamentos Fatura'], True) > 0;
  end
  else
  begin
    FDadosAbertura.blnParametrizouPagamentoAntecipadoAvulso := False;
    FDadosAbertura.blnParametrizouPagamentoAntecipadoFatura := False;
  end;
  FDadosAbertura.blnCTA_PLARES := fCampoExiste('CADCTA', 'CTA_PLARES');
  FDadosAbertura.cdsPlancoInfo := FcdsPlancoInfo ;
end;

procedure TfrmGerLanCon.pDestravaTodosTiposSelecionados;
  var
    intCnt : integer;
    strTipLan : string;
begin
  for intCnt := 0 to Pred(cklListaTipos.Items.Count) do
  begin
    if cklListaTipos.Checked[intCnt] then
    begin
      strTipLan := LeftStr(cklListaTipos.Items.Strings[intCnt], 3);
      fLock_Unlock('LANCON_'+strTipLan, False);
    end;
  end;
end;

procedure TfrmGerLanCon.pEstadoBotao(blnHabilita: Boolean);
begin
  btnGerar.Enabled := blnHabilita and (not chkSomenteComErro.Checked);
  btnLancamentosComErro.Enabled := blnHabilita;
  btnSair.Enabled := blnHabilita;
end;

function TfrmGerLanCon.fEfetivarLancamentos(const APreValidar: boolean): boolean;
  var
    intCnt : Integer;
begin
  Result := True;
  blnPreValidar := APreValidar;
  for intCnt := 0 to Pred(cklListaTipos.Items.Count) do
  begin
    if cklListaTipos.Checked[intCnt] then
    begin
      if not fExecutarGeracao(TTiposContabeis(fAjustaIndexDescricaoContabil(intCnt, cklListaTipos.Items))) then
        Result := False;
    end;
  end;
end;

function TfrmGerLanCon.fExecutarGeracao(const ATipo: TTiposContabeis): boolean;
begin
  Try
    LTipoContabilSelecionado := ATipo;

    If ((ATipo = tcCTP) Or (ATipo = tcPCP)) Then
      result := fChamaTelaGravando(fConfirmarCTP)
    Else
      result := fChamaTelaGravando(fConfirmar);
  Except
    On E: Exception Do
    begin
      result := false;
      pMensagensErro(E.Message,'[TfrmGerLanCon.fExecutarGeracao]');
    end;
  End;
end;

function TfrmGerLanCon.fExisteMovimento: Boolean;
  Var
    qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT AUTOINCREM  ');
    qryAux.SQL.Add('   FROM LANCON ');
    qryAux.SQL.Add('  WHERE CON_AUTOMA = 1 ');
    qryAux.SQL.Add('  AND CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
    if (Length(FarrEmp) > 0) and (not fEmptyStr(FarrEmp[0].strCodigo)) then
      qryAux.SQL.Add('  AND CON_EMPLAN IN (' + fGetInEmpresas(FarrEmp) + ') ');
    qryAux.SQL.Add(' LIMIT 10 ');

    qryAux.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
    qryAux.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

    qryAux.Open;

    Result := qryAux.RecordCount > 0;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmGerLanCon.fSiglaExportacao(const ATipoContabil: TTiposContabeis;
  stlSiglasAdicionais: TStringList): String;
begin
  Result := '';
  stlSiglasAdicionais.Clear;
  If (ATipoContabil = tcSAI) Then
  Begin
    Result := DES_CONTABIL_SIGLA[tcSAI];
    stlSiglasAdicionais.Add('SES');
    stlSiglasAdicionais.Add('CSA');
  End
  Else If (ATipoContabil = tcENT) Then
  Begin
    Result := DES_CONTABIL_SIGLA[tcENT];
    stlSiglasAdicionais.Add('ENTADT');
    stlSiglasAdicionais.Add('SEE');
    stlSiglasAdicionais.Add('SEEADT');
    stlSiglasAdicionais.Add('OUE');
    stlSiglasAdicionais.Add('CEN');
  end
  else if (ATipoContabil = tcCTR) then
  begin
    Result := DES_CONTABIL_SIGLA[tcCTR];
    stlSiglasAdicionais.Add('CTR_ADT_CC');
  End
  Else
    Result := fRetTipoExportacao(ATipoContabil);
end;

procedure TfrmGerLanCon.pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

function TfrmGerLanCon.fConfirmar(pgbProgresso: TcxProgressBar): Boolean;
  Var
    recParCon : TParametrosConsulta;
    strSigla : String;
    stlGerAdi : TStringList;
    intCnt : Integer;
    objValida : IValidaContaContabil;
    LintCnt: Integer ;
    LstrMensagemEmpresa: String ;
    LblnRetorno: Boolean ;
begin
  Result := True;
  LblnRetorno := True;

  for LintCnt := Low(FarrEmp) to High(FarrEmp) do
  begin
    LstrMensagemEmpresa := '' ;
    if not fEmptyStr(FarrEmp[LintCnt].strCodigo) then
      LstrMensagemEmpresa := FarrEmp[LintCnt].strCodigo + ' - ' + fRetNomeEmpresa(FarrEmp[LintCnt].strCodigo) ;
    FillChar(recParCon, SizeOf(recParCon), #0);
    recParCon.strCodEmp := FarrEmp[LintCnt].strCodigo ;
    recParCon.dtaDtaIni := StrToDate(mskDtaIni.Text);
    recParCon.dtaDtaFin := StrToDate(mskDtaFin.Text);
    recParCon.cdsPlancoInfo := FcdsPlancoInfo;
    stlGerAdi := TStringList.Create;
    objValida := TValidaContaContabil.New;
    Try
      strSigla := fSiglaExportacao(LTipoContabilSelecionado, stlGerAdi);

      If (Not fEmptyStr(strSigla)) Then
      Begin
        pSetaTextoProgresso(pgbProgresso, IIF(blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: ' + strSigla + IfThen(fEmptyStr(LstrMensagemEmpresa), '', #13+#10 + LstrMensagemEmpresa) );
        if fGerarSigla(strSigla, recParCon, pgbProgresso, objValida) then
        begin
          For intCnt := 0 To stlGerAdi.Count-1 Do
          Begin
            if not fGerarSigla(stlGerAdi.Strings[intCnt], recParCon, pgbProgresso, objValida) then
            begin
              result := false;
              break;
            end;
          End;
        end
        else
          result := false;

        If (Not objValida.DataSet.IsEmpty) or (Not objValida.DataSetWarnings.IsEmpty) Then
        begin
          objListaValidacoesContabeis.FSigla := strSigla;
          Result := objListaValidacoesContabeis.AddValidacao(objValida);
          // Na geracao sem os documentos com erro os mesmos erros voltam, e nao contam.
          if (not Result) and (not blnPreValidar) and (FlstDocExcluir.Count > 0) then
            Result := not fTemErroForaDaExclusao(objValida.DataSet);
        end;

        if LblnRetorno then
          if not Result then
            LblnRetorno := Result ;

      End
      Else
      begin
        Result := false;
        fMensagem('ATENÇÃO!', Format('A opção selecionada [%s] ainda não foi implementada!', [fRetTipoExportacao(LTipoContabilSelecionado)]), ['&OK']);
        Exit ;
      end;

    Finally
      FreeAndNil(stlGerAdi);
    End;

  End ;
  Result := LblnRetorno ;
end;

function TfrmGerLanCon.fConfirmarCTP(pgbProgresso: TcxProgressBar): Boolean;
  var
    gerador: TGeradorContabil;
    LintCnt: Integer ;
    LstrMensagemEmpresa: String ;
    LlblDescricaoProgresso: TLabel ;
    LblnRetorno: Boolean ;
begin
  inherited;
  LblnRetorno := True;
  for LintCnt := Low(FarrEmp) to High(FarrEmp) do
  begin

    LstrMensagemEmpresa := '' ;
    if not fEmptyStr(FarrEmp[LintCnt].strCodigo) then
      LstrMensagemEmpresa := FarrEmp[LintCnt].strCodigo + ' - ' + fRetNomeEmpresa(FarrEmp[LintCnt].strCodigo) ;

    pnlInfo.Caption := 'Aguarde, gerando dados...' ;
    Screen.Cursor   := crHourGlass;

    LlblDescricaoProgresso := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));
    if Assigned(LlblDescricaoProgresso) then
    begin
      LlblDescricaoProgresso.Visible := True;
      LlblDescricaoProgresso.Caption := IIF(blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: CTP' + IfThen(fEmptyStr(LstrMensagemEmpresa), '', #13+#10 + LstrMensagemEmpresa) ;
    end ;

    Application.ProcessMessages;

    pCarregarDadosAbertura(pgbProgresso, FarrEmp[LintCnt].strCodigo);
    if not fPreparaDadosAberturaReprocesso(FarrEmp[LintCnt].strCodigo) then
    begin
      pnlInfo.Caption := '';
      Screen.Cursor := crDefault;
      Continue;
    end;

    gerador := TGeradorContabil.create(FDadosAbertura);
    try
      //variavel que determina se as contas existem na tabela PLANCO antes de inserir
      gerador.blnValidarContas := blnPreValidar;
      gerador.LancarEmPreValidar := chkLancarFinalPreValidacao.Checked ;
      gerador.pGerar;

      if (Not gerador.listaErros.IsEmpty) or (Not gerador.listaWarnings.IsEmpty) then
      begin
        objListaValidacoesContabeis.FSigla := '';
        result := objListaValidacoesContabeis.AddValidacao(gerador.objValida) ;
        if (not Result) and (not blnPreValidar) and (FlstDocExcluir.Count > 0) then
          Result := not fTemErroForaDaExclusao(gerador.listaErros);
        if LblnRetorno then
          if not Result then
             LblnRetorno := Result ;
        //pListarErrosContabeis(gerador.objValida as IUpdateContaContabil, gerador.listaErros);
      end;

      btnGerar.Enabled := True;
      Screen.Cursor := crDefault;
    finally
      pnlInfo.Caption := '';
      gerador.Free;
    end;

  end ;
  Result := LblnRetorno ;
end;

procedure TfrmGerLanCon.pListarErrosContabeis(const AUpdateContaContabil: IUpdateContaContabil; const ADataSet: TUniClientDataSet);
  var
    LfrmErrosContabil : TfrmErrosContabil;
begin
  pCriarFormularios(TfrmErrosContabil, LfrmErrosContabil);
  try
    LfrmErrosContabil.cdsErros := ADataSet;
    LfrmErrosContabil.objUpdateContaContabil := AUpdateContaContabil;
    LfrmErrosContabil.ShowModal;
  finally
    pFreeAndNil(LfrmErrosContabil);
  end;
end;

procedure TfrmGerLanCon.pMostraConferenciaNaturezaSemParcon;
var
  LFrmConferenciaNaturezaOperacaoParcon: TfrmConferenciaNaturezaOperacaoParcon;
  LTemDados: TDataSet;
  LFiltro: string;
begin
  if fCfgParNat <> 'S' then
    Exit;

  if not fTemTipoComNaturezaMarcado then
    Exit;

  pCriarFormularios(TfrmConferenciaNaturezaOperacaoParcon,
    LFrmConferenciaNaturezaOperacaoParcon);
  Try
    LFiltro := fRetornaTiposSelecionadosComNaturezaParaFiltroSql;
    LTemDados := LFrmConferenciaNaturezaOperacaoParcon.pCarregaDados(LFiltro);
    if not Assigned(LTemDados) then
    begin
      pMensagensErro(LFrmConferenciaNaturezaOperacaoParcon.MensagemErro,
        '[TfrmGerLanCon.pMostraConferenciaNaturezaSemParcon]');
      exit;
    end;
    if not LTemDados.IsEmpty then
    begin
      if fMensagem('Aviso', 'Existe(m) Natureza(s) de Operação(ões) que não estão Parametrizadas, e consequentemente não serão Contabilizadas.'+#13+
                            'Deseja visualizar os Parâmetros ausentes?', ['&Sim', '&Não'], 2) = 1 then
      begin
        LFrmConferenciaNaturezaOperacaoParcon.ShowModal;
      end;
    end;
  Finally
    pFreeAndNil(LFrmConferenciaNaturezaOperacaoParcon);
  End;

end;

procedure TfrmGerLanCon.pMostraWarningNaValidacaoContabil(
  AobjListaValidacoesContabeis: TListaValidacoesContabeis);
begin
  if not AobjListaValidacoesContabeis.getDataSet.IsEmpty then
  begin
    if fEhAdmContabilidade then
    begin
      if fMensagem('Aviso', 'Há registros que não foram processados por alguma advertência!'+#13+
                            'Deseja Visualizar?'+#13+#13+
                            'Obs: Esta mensagem aparecerá apenas para operadores ADM', ['&Sim', '&Não'], 1) = 1 then
        pListarErrosContabeis(AobjListaValidacoesContabeis as IUpdateContaContabil, AobjListaValidacoesContabeis.getDataSet);
    end
    else
      pListarErrosContabeis(AobjListaValidacoesContabeis as IUpdateContaContabil, AobjListaValidacoesContabeis.getDataSet);

  end ;
end;

procedure TfrmGerLanCon.pPopularTiposCheckListBox;
var
  intCnt : Integer;
  LLastItem: Integer;
  LListaParamConf: TStringList ;
begin

  LListaParamConf := fCarregaListaParametrosConfigurados ;
  try
    cklListaTipos.Items.Clear;
    for intCnt := Ord(Low(TTiposContabeis)) to Ord(High(TTiposContabeis)) Do
    begin
      if (TTiposContabeis(intCnt) = tcANT) and (not fTabelaExiste('PAGANT')) then
        Continue;

      if not fPodeUsarTiposContabeisAgrupamento(TTiposContabeis(intCnt)) then
        Continue;

      if (TTiposContabeis(intCnt) = tcAJI) and (not fCfgSis('AJUICM', varBoolean)) then
        Continue;

      if ((TTiposContabeis(intCnt) = tcAJE) or (TTiposContabeis(intCnt) = tcAJS)) and (not fCfgSis('AJUPAR', varBoolean)) then
        Continue;

      LLastItem := cklListaTipos.Items.Add(DES_CONTABIL[TTiposContabeis(intCnt)]);
      cklListaTipos.ItemEnabled[LLastItem] := fTemParametroConfigurado(LListaParamConf, DES_CONTABIL_SIGLA[TTiposContabeis(intCnt)]) ;
    end;
  finally
    FreeAndNil(LListaParamConf) ;
  end ;
end;

procedure TfrmGerLanCon.pRecriaObjListaValidacoesContabeis;
begin
  if not fEhAdmContabilidade then
    Exit ;

  objListaValidacoesContabeis := Nil ;
  objListaValidacoesContabeis := TListaValidacoesContabeis.Create;
  FintfListaValidacoes := objListaValidacoesContabeis;
end;

function TfrmGerLanCon.fPodeSelecionarTipo: boolean;
  var
    intCnt : Integer;
begin
  Result := True;
  for intCnt := 0 to Pred(cklListaTipos.Items.Count) do
  begin
    if cklListaTipos.Checked[intCnt] then
    begin
      if (LeftStr(cklListaTipos.Items.Strings[intCnt], 3)) = 'IMO' then
      begin
        if not (fTabelaExiste('CADIMO') and fTabelaExiste('IMOAMO')) then
        begin
          fMensagem('ATENÇÃO!','A versão atual não suporta a rotina de imobilizado, solicite atualização!',['&OK']);
          Exit(False);
        end;
      end
      else if not fPermiteApenasPeriodoDentroDeUmUnicoMes(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), LeftStr(cklListaTipos.Items.Strings[intCnt], 3)) then
      begin
        Exit(False);
      end ;
    end;
  end;
end;

function TfrmGerLanCon.fRetornaTiposSelecionadosComNaturezaParaFiltroSql: string;
var
  LCnt: Integer;
begin
  Result := EmptyStr;
  for LCnt := 0 to FTipoSelecionadoComNatureza.Count-1 do
    Result := Result + IfThen(fEmptyStr(Result), EmptyStr, ',') + fQuotedStr(FTipoSelecionadoComNatureza.Strings[LCnt]);
end;

function TfrmGerLanCon.fRetTipoExportacao(const ATipoContabil: TTiposContabeis): string;
begin
  result := DES_CONTABIL_SIGLA[ATipoContabil];
end;

function TfrmGerLanCon.fTemTipoComNaturezaMarcado: boolean;
var
  LCnt : Integer;
  LTipo: string;
begin
  Result := False;
  FTipoSelecionadoComNatureza.Clear;
  for LCnt := 0 to Pred(cklListaTipos.Items.Count) do
  begin
    if cklListaTipos.Checked[LCnt] then
    begin
      LTipo := String(LeftStr(cklListaTipos.Items.Strings[LCnt], 3));
      if TfrmConferenciaNaturezaOperacaoParcon.fEhTipoComNatureza(LTipo) then
      begin
        Result := True;
        FTipoSelecionadoComNatureza.Add(LTipo);
      end;
    end;
  end;
end;

function TfrmGerLanCon.fTemTipoMarcado: boolean;
  var
    intCnt : Integer;
begin
  Result := False;
  for intCnt := 0 to Pred(cklListaTipos.Items.Count) do
  begin
    if cklListaTipos.Checked[intCnt] then
    begin
      Result := True;
      break;
    end;
  end;
end;

function TfrmGerLanCon.fTiposContabeisSelecionados: TSetTiposContabeis;
var
  intCnt: Integer ;
begin
  Result := [] ;

  for intCnt := 0 to Pred(cklListaTipos.Items.Count) do
    if cklListaTipos.Checked[intCnt] then
      Result := Result + [TTiposContabeis(fAjustaIndexDescricaoContabil(intCnt, cklListaTipos.Items))];

end;

function TfrmGerLanCon.fTravouTodosOsTiposSelecionados: boolean;
  var
    intCnt : integer;
    strTipLan : string;
begin
  Result := True;
  for intCnt := 0 to Pred(cklListaTipos.Items.Count) do
  begin
    if cklListaTipos.Checked[intCnt] then
    begin
      strTipLan := LeftStr(cklListaTipos.Items.Strings[intCnt], 3);
      if not fLock_Unlock('LANCON_'+strTipLan, True, False) then
      begin
        fMensagem('ATENÇÃO!', 'A rotina "Geração de Lancamentos Contábeis - ' + strTipLan +
                              '" já está sendo utilizada por outra estação: ' +
                              fGetHostLock('LANCON_'+strTipLan), ['&Ok']);
        Result := False;
        break;
      end;
    end;
  end;
end;

{ Req. 470760 - geracao sem os documentos com erro e reprocesso so deles }

procedure TfrmGerLanCon.chkSomenteComErroClick(Sender: TObject);
begin
  inherited;
  btnLancamentosComErro.Visible := chkSomenteComErro.Checked;
  btnGerar.Enabled := not chkSomenteComErro.Checked;
end;

procedure TfrmGerLanCon.btnLancamentosComErroClick(Sender: TObject);
var
  LcdsPendencias: TUniClientDataSet;
begin
  If Not fVerificaCampos Then
    Exit;

  pAjustaArrayEmpresas ;

  if not fTemTipoMarcado then
  begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um tipo contábil para geração!', ['&OK']);
    Exit;
  end;

  LcdsPendencias := TPendenciaContabil.fListar(fEmpresasSelecionadas, fTiposSelecionados,
                                               StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text));
  try
    if LcdsPendencias.IsEmpty then
    begin
      fMensagem('Aviso', 'Não há lançamentos com erro para a empresa, o período e os tipos selecionados.', ['&OK']);
      Exit;
    end;

    TfrmErrosContabil.pExibir(LcdsPendencias);

    if fMensagem('Aviso', 'Efetuar a geração dos lançamentos?', ['&Sim', '&Não'], 1) = 2 then
      Exit;

    if not fPodeIniciarGeracao(True) then
      Exit;

    pReprocessarPendencias(LcdsPendencias);
  finally
    FreeAndNil(LcdsPendencias);
  end;
end;

procedure TfrmGerLanCon.pReprocessarPendencias(const AcdsPendencias: TUniClientDataSet);
begin
  pMontarReprocesso(AcdsPendencias);
  FblnReprocessaErros := True;
  FcdsPendenciasReprocesso := AcdsPendencias;

  objListaValidacoesContabeis := TListaValidacoesContabeis.Create;
  FintfListaValidacoes := objListaValidacoesContabeis;
  pEstadoBotao(False);
  FcdsPlancoInfo := fCarregaPlancoInfo ;
  Try
    if fEfetivarLancamentos(True) then
    begin
      pMostraWarningNaValidacaoContabil(objListaValidacoesContabeis) ;

      // Com a geracao final na pre-validacao, a primeira passada ja gravou.
      if chkLancarFinalPreValidacao.Checked or fEfetivarLancamentos(False) then
      begin
        pAtualizarPendencias(nil);
        pAvisarReprocesso('Todos os lançamentos que apresentavam erros foram gerados com sucesso');
      end;
    end
    else if (not objListaValidacoesContabeis.getDataSet.IsEmpty) then
    begin
      if fPodeGerarSemOsDocumentosComErro then
        pGerarSemOsDocumentosComErro('Nem todos os lançamentos que apresentavam erros foram corrigidos. Deseja visualizá-los?')
      else
        pListarErrosContabeis(objListaValidacoesContabeis as IUpdateContaContabil, objListaValidacoesContabeis.getDataSet);
    end;
  Finally
    FblnReprocessaErros := False;
    FcdsPendenciasReprocesso := nil;
    FdicDocsReprocesso.Clear;
    FlstDocReprocesso.Clear;
    FlstEmpCmvReprocesso.Clear;
    FcdsPlancoInfo.EmptyDataSet ;
    FreeAndNil(FcdsPlancoInfo) ;
    pDestravaTodosTiposSelecionados;
    pEstadoBotao(True);
  End;
end;

procedure TfrmGerLanCon.pGerarSemOsDocumentosComErro(const AstrPergunta: String);
var
  LcdsErros: TUniClientDataSet;
begin
  if fMensagem('Aviso', AstrPergunta, ['&Sim', '&Não'], 1) = 2 then
    Exit;

  pListarErrosContabeis(objListaValidacoesContabeis as IUpdateContaContabil, objListaValidacoesContabeis.getDataSet);

  if fMensagem('Aviso', 'Os registros com erro não serão gerados e ficarão pendentes para correção. Deseja gerar os registros que não apresentam erros?', ['&Sim', '&Não'], 1) = 2 then
    Exit;

  // A CONPEN recebe os erros da pre-validacao; a segunda passada acrescenta os mesmos erros na lista.
  LcdsErros := TUniClientDataSet.Create(nil);
  try
    pCloneDataSet(LcdsErros, objListaValidacoesContabeis.getDataSet);
    pMontarExclusao(LcdsErros);
    try
      if fEfetivarLancamentos(False) then
      begin
        pAtualizarPendencias(LcdsErros);
        if FblnReprocessaErros then
          pAvisarReprocesso('Geração concluída com sucesso!')
        else
          fMensagem('Aviso', 'Geração concluída com sucesso!', ['OK']);
      end;
    finally
      FlstDocExcluir.Clear;
      FlstEmpCmvComErro.Clear;
    end;
  finally
    FreeAndNil(LcdsErros);
  end;
end;

function TfrmGerLanCon.fGerarSigla(const AstrSigla: String; ArecParCon: TParametrosConsulta;
  pgbProgresso: TcxProgressBar; const AobjValida: IValidaContaContabil): Boolean;
var
  LobjGerLanCon: TGerLanCon;
begin
  Result := True;

  ArecParCon.blnReprocessaErros := FblnReprocessaErros;
  if FlstDocExcluir.Count > 0 then
    ArecParCon.lstDocExcluir := FlstDocExcluir;
  ArecParCon.lstDocReprocesso := FlstDocReprocesso;

  if AstrSigla = 'CMV' then
  begin
    // CMV e agrupado por CFOP no periodo e a chave muda a cada geracao: tudo ou nada por empresa.
    if (not blnPreValidar) and (FlstEmpCmvComErro.IndexOf(ArecParCon.strCodEmp) >= 0) then
      Exit;

    if FblnReprocessaErros then
    begin
      if FlstEmpCmvReprocesso.IndexOf(ArecParCon.strCodEmp) < 0 then
        Exit;
      ArecParCon.blnReprocessaErros := False;
    end;
  end
  else if FblnReprocessaErros then
  begin
    // Sem documento pendente a sigla nao roda: lista vazia seria o periodo inteiro.
    if not FdicDocsReprocesso.TryGetValue(ArecParCon.strCodEmp + '|' + AstrSigla, ArecParCon.arrIncDoc) then
      Exit;
  end;

  LobjGerLanCon := TGerLanCon.Create(Self, AstrSigla, ArecParCon, pgbProgresso, blnPreValidar, AobjValida, chkLancarFinalPreValidacao.Checked);
  try
    Result := LobjGerLanCon.fGerarLancamentos;
  finally
    FreeAndNil(LobjGerLanCon);
  end;
end;

function TfrmGerLanCon.fPreparaDadosAberturaReprocesso(const AstrCodEmp: String): Boolean;
var
  LarrIncDoc: TArrIncDoc;
begin
  Result := True;

  FDadosAbertura.blnReprocessaErros := FblnReprocessaErros;
  FDadosAbertura.lstDocExcluir := nil;
  if FlstDocExcluir.Count > 0 then
    FDadosAbertura.lstDocExcluir := FlstDocExcluir;

  SetLength(LarrIncDoc, 0);
  if FblnReprocessaErros then
    Result := FdicDocsReprocesso.TryGetValue(AstrCodEmp + '|' + FDadosAbertura.strTipoExportacao, LarrIncDoc);
  FDadosAbertura.arrIncDoc := LarrIncDoc;
end;

function TfrmGerLanCon.fSiglasDoTipo(const ATipo: TTiposContabeis): TArray<String>;
var
  LstlGerAdi: TStringList;
  LintCnt: Integer;
begin
  LstlGerAdi := TStringList.Create;
  try
    Result := [fSiglaExportacao(ATipo, LstlGerAdi)];
    for LintCnt := 0 to LstlGerAdi.Count - 1 do
      Result := Result + [LstlGerAdi[LintCnt]];
  finally
    FreeAndNil(LstlGerAdi);
  end;
end;

function TfrmGerLanCon.fTipoDaSigla(const AstrSigla: String): String;
var
  LintCnt: Integer;
  LTipo: TTiposContabeis;
begin
  Result := '';
  for LintCnt := 0 to Pred(cklListaTipos.Items.Count) do
  begin
    if not cklListaTipos.Checked[LintCnt] then
      Continue;

    LTipo := TTiposContabeis(fAjustaIndexDescricaoContabil(LintCnt, cklListaTipos.Items));
    if MatchStr(AstrSigla, fSiglasDoTipo(LTipo)) then
      Exit(fRetTipoExportacao(LTipo));
  end;
end;

function TfrmGerLanCon.fChaveExclusao(const AcdsErros: TUniClientDataSet): String;
var
  LstrSigla: String;
begin
  // O TGeradorContabil grava todo CTP/PCP com tabela CADPAG; os demais, com a tabela do erro.
  LstrSigla := AcdsErros.FieldByName('ERR_SIGLA').AsString;
  if (LstrSigla = fRetTipoExportacao(tcCTP)) or (LstrSigla = fRetTipoExportacao(tcPCP)) then
    Result := AcdsErros.FieldByName('ERR_CHVDOC').AsString + '|CADPAG'
  else
    Result := AcdsErros.FieldByName('ERR_CHVDOC').AsString + '|' + AcdsErros.FieldByName('ERR_TABELA').AsString;
end;

function TfrmGerLanCon.fPodeGerarSemOsDocumentosComErro: Boolean;
var
  LcdsErros: TUniClientDataSet;
begin
  // Erro sem documento (ou de fora do gerador) nao se isola: segue o tudo ou nada de antes.
  Result := TPendenciaContabil.fTabelaExiste;
  if not Result then
    Exit;

  LcdsErros := objListaValidacoesContabeis.getDataSet;
  LcdsErros.First;
  while not LcdsErros.Eof do
  begin
    if (LcdsErros.FieldByName('ERR_STATUS').AsString = 'EE') and
       (fEmptyStr(LcdsErros.FieldByName('ERR_CHVDOC').AsString) or fEmptyStr(LcdsErros.FieldByName('ERR_SIGLA').AsString)) then
      Exit(False);
    LcdsErros.Next;
  end;
end;

function TfrmGerLanCon.fTemErroForaDaExclusao(const AcdsErros: TUniClientDataSet): Boolean;
begin
  Result := False;
  AcdsErros.First;
  while not AcdsErros.Eof do
  begin
    if (AcdsErros.FieldByName('ERR_STATUS').AsString = 'EE') and
       (FlstDocExcluir.IndexOf(fChaveExclusao(AcdsErros)) < 0) then
      Exit(True);
    AcdsErros.Next;
  end;
end;

function TfrmGerLanCon.fEmpresasSelecionadas: TArray<String>;
var
  LintCnt: Integer;
begin
  // Empresa em branco e geracao de todas as empresas: lista vazia, sem filtro de empresa.
  Result := [];
  for LintCnt := Low(FarrEmp) to High(FarrEmp) do
    if not fEmptyStr(FarrEmp[LintCnt].strCodigo) then
      Result := Result + [FarrEmp[LintCnt].strCodigo];
end;

function TfrmGerLanCon.fEmpresaChave(const AstrCodEmpDoc: String): String;
begin
  // Sem empresa na tela, cada sigla roda uma vez para todas as empresas (recParCon.strCodEmp vazio):
  // as listas do reprocesso e do CMV usam a mesma chave vazia que fGerarSigla procura.
  Result := AstrCodEmpDoc;
  if Length(fEmpresasSelecionadas) = 0 then
    Result := '';
end;

function TfrmGerLanCon.fTiposSelecionados: TArray<String>;
var
  LintCnt: Integer;
begin
  Result := [];
  for LintCnt := 0 to Pred(cklListaTipos.Items.Count) do
    if cklListaTipos.Checked[LintCnt] then
      Result := Result + [fRetTipoExportacao(TTiposContabeis(fAjustaIndexDescricaoContabil(LintCnt, cklListaTipos.Items)))];
end;

procedure TfrmGerLanCon.pMontarExclusao(const AcdsErros: TUniClientDataSet);
begin
  FlstDocExcluir.Clear;
  FlstEmpCmvComErro.Clear;

  AcdsErros.First;
  while not AcdsErros.Eof do
  begin
    if AcdsErros.FieldByName('ERR_STATUS').AsString = 'EE' then
    begin
      if AcdsErros.FieldByName('ERR_SIGLA').AsString = 'CMV' then
        FlstEmpCmvComErro.Add(fEmpresaChave(AcdsErros.FieldByName('ERR_CODEMP').AsString))
      else
        FlstDocExcluir.Add(fChaveExclusao(AcdsErros));
    end;
    AcdsErros.Next;
  end;
end;

procedure TfrmGerLanCon.pMontarReprocesso(const AcdsPendencias: TUniClientDataSet);
var
  LstrEmp: String;
  LstrSigla: String;
  LstrChvDoc: String;
  LstrChave: String;
  LarrIncDoc: TArrIncDoc;
  LintCnt: Integer;
  LblnExiste: Boolean;
begin
  FdicDocsReprocesso.Clear;
  FlstDocReprocesso.Clear;
  FlstEmpCmvReprocesso.Clear;

  AcdsPendencias.First;
  while not AcdsPendencias.Eof do
  begin
    LstrEmp := fEmpresaChave(AcdsPendencias.FieldByName('ERR_CODEMP').AsString);
    LstrSigla := AcdsPendencias.FieldByName('ERR_SIGLA').AsString;
    LstrChvDoc := AcdsPendencias.FieldByName('ERR_CHVDOC').AsString;

    if LstrSigla = 'CMV' then
      FlstEmpCmvReprocesso.Add(LstrEmp)
    else
    begin
      // Uma lista por empresa e sigla: as siglas irmas buscam em tabelas diferentes e a chave se repete.
      LstrChave := LstrEmp + '|' + LstrSigla;
      if not FdicDocsReprocesso.TryGetValue(LstrChave, LarrIncDoc) then
        SetLength(LarrIncDoc, 0);

      LblnExiste := False;
      for LintCnt := 0 to High(LarrIncDoc) do
        if (LarrIncDoc[LintCnt].IncDoc = LstrChvDoc) or
           (LarrIncDoc[LintCnt].IncDoc = LstrChvDoc + '|' + AcdsPendencias.FieldByName('ERR_TABELA').AsString) then
        begin
          LblnExiste := True;
          Break;
        end;

      if not LblnExiste then
      begin
        SetLength(LarrIncDoc, Length(LarrIncDoc) + 1);
        if MatchStr(LstrSigla, ['AGR', 'AGP']) then
        LarrIncDoc[High(LarrIncDoc)].IncDoc := LstrChvDoc + '|' + AcdsPendencias.FieldByName('ERR_TABELA').AsString
      else
        LarrIncDoc[High(LarrIncDoc)].IncDoc := LstrChvDoc;
        LarrIncDoc[High(LarrIncDoc)].ConLog := 0;
        FdicDocsReprocesso.AddOrSetValue(LstrChave, LarrIncDoc);
      end;

      FlstDocReprocesso.Add(LstrChvDoc + '|' + AcdsPendencias.FieldByName('ERR_TABELA').AsString);
    end;

    AcdsPendencias.Next;
  end;
end;

procedure TfrmGerLanCon.pAtualizarPendencias(const AcdsErros: TUniClientDataSet);
var
  LintTipo: Integer;
  LintEmp: Integer;
  LTipo: TTiposContabeis;
begin
  if not TPendenciaContabil.fTabelaExiste then
    Exit;

  for LintTipo := 0 to Pred(cklListaTipos.Items.Count) do
  begin
    if not cklListaTipos.Checked[LintTipo] then
      Continue;

    LTipo := TTiposContabeis(fAjustaIndexDescricaoContabil(LintTipo, cklListaTipos.Items));
    for LintEmp := Low(FarrEmp) to High(FarrEmp) do
      TPendenciaContabil.pSubstituir(FarrEmp[LintEmp].strCodigo, fRetTipoExportacao(LTipo), fSiglasDoTipo(LTipo),
                                     StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), AcdsErros,
                                     FblnReprocessaErros, FlstEmpCmvReprocesso.IndexOf(FarrEmp[LintEmp].strCodigo) >= 0);
  end;
end;

procedure TfrmGerLanCon.pAvisarReprocesso(const AstrMensagemOk: String);
var
  LintNaoLocalizados: Integer;
begin
  LintNaoLocalizados := fConcluirReprocesso;
  if LintNaoLocalizados = 0 then
    fMensagem('Aviso', AstrMensagemOk, ['OK'])
  else
    fMensagem('Aviso', Format('Os lançamentos foram gerados, mas %d documento(s) pendente(s) não foi(ram) localizado(s) no ' +
                              'reprocesso e continua(m) pendente(s). Para atualizá-lo(s), gere o período normalmente.',
                              [LintNaoLocalizados]), ['OK']);
end;

function TfrmGerLanCon.fConcluirReprocesso: Integer;
var
  LcdsRestantes: TUniClientDataSet;
  LlstRestantes: TStringList;
  LlstMarcados: TStringList;
  LlstNaoLocalizados: TStringList;
  LstrEmp: String;
  LstrSigla: String;
  LstrChave: String;
  LstrTipLan: String;
  LstrMarca: String;
  LblnGerado: Boolean;
  LarrDias: TDateDynArray;
begin
  Result := 0;
  if not Assigned(FcdsPendenciasReprocesso) then
    Exit;

  LlstRestantes := TStringList.Create;
  LlstMarcados := TStringList.Create;
  LlstNaoLocalizados := TStringList.Create;
  LcdsRestantes := TPendenciaContabil.fListar(fEmpresasSelecionadas, fTiposSelecionados,
                                              StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text));
  try
    LlstRestantes.Sorted := True;
    LlstRestantes.Duplicates := dupIgnore;
    LlstMarcados.Sorted := True;
    LlstNaoLocalizados.Sorted := True;
    LlstNaoLocalizados.Duplicates := dupIgnore;

    LcdsRestantes.First;
    while not LcdsRestantes.Eof do
    begin
      LlstRestantes.Add(LcdsRestantes.FieldByName('ERR_CODEMP').AsString + '|' +
                        LcdsRestantes.FieldByName('ERR_CHVDOC').AsString + '|' +
                        LcdsRestantes.FieldByName('ERR_TABELA').AsString);
      LcdsRestantes.Next;
    end;

    FcdsPendenciasReprocesso.First;
    while not FcdsPendenciasReprocesso.Eof do
    begin
      LstrEmp := FcdsPendenciasReprocesso.FieldByName('ERR_CODEMP').AsString;
      LstrSigla := FcdsPendenciasReprocesso.FieldByName('ERR_SIGLA').AsString;
      LstrChave := LstrEmp + '|' + FcdsPendenciasReprocesso.FieldByName('ERR_CHVDOC').AsString + '|' +
                   FcdsPendenciasReprocesso.FieldByName('ERR_TABELA').AsString;

      // Gerado = saiu da CONPEN. CMV regera com chave nova a cada vez: vale o tudo ou nada da empresa.
      if LstrSigla = 'CMV' then
        LblnGerado := FlstEmpCmvComErro.IndexOf(fEmpresaChave(LstrEmp)) < 0
      else
        LblnGerado := LlstRestantes.IndexOf(LstrChave) < 0;

      if LblnGerado then
      begin
        LstrTipLan := fTipoDaSigla(LstrSigla);
        LstrMarca := LstrEmp + '|' + LstrTipLan + '|' + DateToStr(FcdsPendenciasReprocesso.FieldByName('ERR_DTALAN').AsDateTime);
        if (not fEmptyStr(LstrTipLan)) and (LlstMarcados.IndexOf(LstrMarca) < 0) then
        begin
          LlstMarcados.Add(LstrMarca);
          SetLength(LarrDias, 1);
          LarrDias[0] := FcdsPendenciasReprocesso.FieldByName('ERR_DTALAN').AsDateTime;
          TProcessaCheckList.pMarcarReprocesso(LstrTipLan, LstrEmp, LarrDias);
        end;
      end
      else if (LstrSigla <> 'CMV') and (FlstDocExcluir.IndexOf(fChaveExclusao(FcdsPendenciasReprocesso)) < 0) then
        // Continua pendente sem ter voltado com erro: o reprocesso nao chegou a carregar o documento.
        LlstNaoLocalizados.Add(LstrChave);

      FcdsPendenciasReprocesso.Next;
    end;

    Result := LlstNaoLocalizados.Count;
  finally
    FreeAndNil(LcdsRestantes);
    FreeAndNil(LlstRestantes);
    FreeAndNil(LlstMarcados);
    FreeAndNil(LlstNaoLocalizados);
  end;
end;
end.
