unit Contabilidade.View.ApuracaoLucroPresumido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Contabilidade.Interfaces.SharedLucroPresumido,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxButtons, EditFocus, cxLabel, Data.DB, Datasnap.DBClient,
  UniClientDataSet, Vcl.ComCtrls, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxCalc, cxTextEdit,
  Contabilidade.Interfaces.ApuracaoLucroPresumido, cxProgressBar;

type
  TfrmApuracaoLucroPresumido = class(TfrmPaiContabilidade)
    pnlAbrirExercicio: TPanel;
    cxLabel1: TcxLabel;
    edtExercicio: TEditFocus;
    cxLabel7: TcxLabel;
    edtEmpSel: TEditFocus;
    edtNomEmpSel: TEditFocus;
    btnAbrir: TcxButton;
    btnGravar: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    pgcApuracao: TPageControl;
    tsBaseCalculo: TTabSheet;
    tsApuracao: TTabSheet;
    dsBaseCalculo: TDataSource;
    dsApuracao: TDataSource;
    GridBaseCalculo: TcxGridCitel;
    GridBaseCalculoView: TcxGridDBTableViewCitel;
    GridBaseCalculoViewAUTOINCREM: TcxGridDBColumn;
    GridBaseCalculoViewCODIGO: TcxGridDBColumn;
    GridBaseCalculoViewDESCRI: TcxGridDBColumn;
    GridBaseCalculoViewPERIOD_01: TcxGridDBColumn;
    GridBaseCalculoViewPERIOD_02: TcxGridDBColumn;
    GridBaseCalculoViewPERIOD_03: TcxGridDBColumn;
    GridBaseCalculoViewPERIOD_04: TcxGridDBColumn;
    GridBaseCalculoViewPERIOD_TOT: TcxGridDBColumn;
    GridBaseCalculoLevel: TcxGridLevel;
    GridApuracao: TcxGridCitel;
    GridApuracaoView: TcxGridDBTableViewCitel;
    GridApuracaoViewAUTOINCREM: TcxGridDBColumn;
    GridApuracaoViewCODIGO: TcxGridDBColumn;
    GridApuracaoViewDESCRI: TcxGridDBColumn;
    GridApuracaoViewPERIOD_01: TcxGridDBColumn;
    GridApuracaoViewPERIOD_02: TcxGridDBColumn;
    GridApuracaoViewPERIOD_03: TcxGridDBColumn;
    GridApuracaoViewPERIOD_04: TcxGridDBColumn;
    GridApuracaoViewPERIOD_TOT: TcxGridDBColumn;
    GridApuracaoLevel: TcxGridLevel;
    GridBaseCalculoViewBLOQUE: TcxGridDBColumn;
    GridApuracaoViewBLOQUE: TcxGridDBColumn;
    procedure edtEmpSelKeyPress(Sender: TObject; var Key: Char);
    procedure btnAbrirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure GridBaseCalculoViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure GridApuracaoViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    FobjLinhaSemDados: ITipoLinhasSemInformacao ;
    FtlpTipoApuracao: TTipoLucroPresumido ;
    FcdsApuracaoBaseCalculo: TUniClientDataSet ;
    FcdsApuracaoValor: TUniClientDataSet ;
    FstrCodigoApuracao: String ;
    function fPersiste(const ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoSalva ;
    function fDeleta(const ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoDelete ;
    procedure pConfguraNomeTab(const AtlpTipoApuracao: TTipoLucroPresumido) ;
    procedure pHabilitarEdicao(const AblnHabilitado: Boolean) ;
    procedure pLimpaCampos;
    function fCarregaApuracoes(const AstrCodEmp: String; const AintExercicio: Integer): boolean ;
    procedure pAfterPost(DataSet: TDataSet) ;
    function fCarregaComProgresso(pgbProgresso: TcxProgressBar): Boolean ;
    function fPersisteComProgresso(pgbProgresso: TcxProgressBar): Boolean ;
    function fDeletaComProgresso(pgbProgresso: TcxProgressBar): Boolean ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    property TipoApuracao: TTipoLucroPresumido read FtlpTipoApuracao write FtlpTipoApuracao ;
  end;

implementation

uses untConsultas, untTypesSistema, untFuncoesSimples,
Contabilidade.View.AdicionaPlanoContas, Contabilidade.Consultas,
System.StrUtils, System.Types, Contabilidade.Classes.ApuracaoLucroPresumidoFactory,
Contabilidade.Classes.ApuracaoLucroPresumidoComum, Contabilidade.Funcoes.LucroPresumido ;

{$R *.dfm}

procedure TfrmApuracaoLucroPresumido.btnAbrirClick(Sender: TObject);
begin
  inherited;

  if fEmptyStr(edtExercicio.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não informado!', ['&Ok']);
    pSetFocus(edtExercicio) ;
    exit ;
  end;

  fChamaTelaGravando(fCarregaComProgresso) ;

end;

procedure TfrmApuracaoLucroPresumido.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitarEdicao(True) ;
  pLimpaCampos ;
end;

procedure TfrmApuracaoLucroPresumido.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if (fMensagem('Aviso', 'Deseja realmente apagar a apuração?', ['&Sim', '&Não'], 2) = 1) then
    fChamaTelaGravando(fDeletaComProgresso) ;
end;

procedure TfrmApuracaoLucroPresumido.btnGravarClick(Sender: TObject);
begin
  inherited;

  fChamaTelaGravando(fPersisteComProgresso) ;

end;

procedure TfrmApuracaoLucroPresumido.edtEmpSelKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel, edtNomEmpSel, Nil, Key, arrEmpSel, False) Then
  Begin
    If fValidaCampos(edtEmpSel) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmApuracaoLucroPresumido.fCarregaApuracoes(const AstrCodEmp: String;
  const AintExercicio: Integer): boolean;
var
  LObjDadosApuracao: IDadosApuracaoLucroPresumido ;
  LstrMensagem: String ;
begin
  Result := False ;

  LObjDadosApuracao := fCarregaApuracaoLucroPresumido(FtlpTipoApuracao).fCarrega(AstrCodEmp, AintExercicio, LstrMensagem) ;

  if not Assigned(LObjDadosApuracao) then
  begin
    pMensagemOk(LstrMensagem);
    Exit ;
  end ;

  FstrCodigoApuracao := LObjDadosApuracao.Geral.Codigo ;

  Result := fProcessaApuracaoLucroPresumido(FtlpTipoApuracao,
                                            LObjDadosApuracao,
                                            FcdsApuracaoBaseCalculo,
                                            FcdsApuracaoValor,
                                            FobjLinhaSemDados) ;
end;

function TfrmApuracaoLucroPresumido.fCarregaComProgresso(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True ;
  pnlInfo.Caption := 'Aguarde, carregando dados...';
  Screen.Cursor   := crHourGlass;
  Application.ProcessMessages;
  try
    if fCarregaApuracoes(edtEmpSel.Text, strToInt(edtExercicio.Text)) then
      pHabilitarEdicao(False) ;
  finally
    Screen.Cursor := crDefault;
    pnlInfo.Caption := '';
  end ;
end;

function TfrmApuracaoLucroPresumido.fDeleta(
  const ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoDelete;
begin
  Result := TFactoryApuracaoLucroPresumidoDelete.New.fConfigura(ATipo) ;
end;

function TfrmApuracaoLucroPresumido.fDeletaComProgresso(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True ;
  pnlInfo.Caption := 'Aguarde, excluindo dados...';
  Screen.Cursor   := crHourGlass;
  Application.ProcessMessages;
  try

    if fDeleta(FtlpTipoApuracao).fDelete(FstrCodigoApuracao) then
    begin
      pHabilitarEdicao(True) ;
      pLimpaCampos ;
    end
    else
      pMensagensErro('Problemas ao deletar apurações do Lucro Presumido. Tente novamente!', '[TfrmApuracaoLucroPresumido.btnExcluirClick]');

  finally
    Screen.Cursor := crDefault;
    pnlInfo.Caption := '';
  end ;
end;

procedure TfrmApuracaoLucroPresumido.FormCreate(Sender: TObject);
begin
  inherited;

  FcdsApuracaoBaseCalculo := TUniClientDataSet.Create(Nil) ;
  FcdsApuracaoValor := TUniClientDataSet.Create(Nil) ;

  pCriarEstruturaCDSLucroPresumido(FcdsApuracaoBaseCalculo) ;
  pCriarEstruturaCDSLucroPresumido(FcdsApuracaoValor) ;

  pgcApuracao.ActivePageIndex := 0 ;
  pHabilitarEdicao(True) ;
  dsBaseCalculo.DataSet := FcdsApuracaoBaseCalculo ;
  dsApuracao.DataSet := FcdsApuracaoValor ;

  FcdsApuracaoBaseCalculo.AfterPost := pAfterPost ;
  FcdsApuracaoValor.AfterPost := pAfterPost ;
  FstrCodigoApuracao := '' ;
end;

procedure TfrmApuracaoLucroPresumido.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FcdsApuracaoBaseCalculo) ;
  FreeAndNil(FcdsApuracaoValor) ;
end;

procedure TfrmApuracaoLucroPresumido.FormShow(Sender: TObject);
begin
  inherited;
  pConfguraNomeTab(FtlpTipoApuracao) ;
  FobjLinhaSemDados := TFactoryLinhasSemInformacao.New.fConfigura(FtlpTipoApuracao) ;
  pLimpaCampos ;
end;

function TfrmApuracaoLucroPresumido.fPersiste(
  const ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoSalva;
begin
  Result := TFactoryApuracaoLucroPresumidoSalva.New.fConfigura(ATipo) ;
end;

function TfrmApuracaoLucroPresumido.fPersisteComProgresso(
  pgbProgresso: TcxProgressBar): Boolean;
var
  LobjApuracao : IDadosApuracaoLucroPresumido ;
begin
  Result := True ;
  pnlInfo.Caption := 'Aguarde, salvando dados...';
  Screen.Cursor   := crHourGlass;
  Application.ProcessMessages;
  try
    LobjApuracao := TTipoApuracaoLucroPresumidoConverte
                      .New
                      .Codigo(FstrCodigoApuracao)
                      .CodEmp(edtEmpSel.Text)
                      .Exerci(StrToInt(edtExercicio.Text))
                      .fConverte(FcdsApuracaoBaseCalculo, FcdsApuracaoValor) ;

    if fPersiste(FtlpTipoApuracao).fSalva(LobjApuracao) then
    begin
      pHabilitarEdicao(True) ;
      pLimpaCampos ;
    end
    else
      pMensagensErro('Problemas ao salvar apurações do Lucro Presumido. Tente novamente!', '[TfrmApuracaoLucroPresumido.btnGravarClick]');

  finally
    Screen.Cursor := crDefault;
    pnlInfo.Caption := '';
  end ;
end;

function TfrmApuracaoLucroPresumido.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  begin

    If (Sender = edtEmpSel) Then
    begin

      if not fEmptyStr(edtEmpSel.Text) then
      Begin
        edtNomEmpSel.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel.Text], False);
        if fEmptyStr(edtNomEmpSel.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      else
      Begin
        edtNomEmpSel.Clear;
        edtEmpSel.Clear;
        fMensagem('ATENÇÃO!', 'Empresa deve ser preenchida!', ['&OK']);
        Result := False;
      End

    end;

  end ;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmApuracaoLucroPresumido.GridApuracaoViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
var
  LstrInfoLinha: String ;
begin
  inherited;
  AAllow := GridApuracaoViewBLOQUE.DataBinding.Field.AsString <> 'S' ;

  if AAllow then
  begin
    LstrInfoLinha := GridApuracaoViewCODIGO.DataBinding.Field.AsString ;
    AAllow := TFactoryLinhasSemEdicao
                .New
                .fConfigura(FtlpTipoApuracao)
                .fGrupo(APURACAO)
                .fLinha(LstrInfoLinha)
                .fPodeEditar ;
  end ;

end;

procedure TfrmApuracaoLucroPresumido.GridBaseCalculoViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
var
  LstrInfoLinha: String ;
begin
  inherited;
  AAllow := GridBaseCalculoViewBLOQUE.DataBinding.Field.AsString <> 'S' ;

  if AAllow then
  begin
    LstrInfoLinha := GridBaseCalculoViewCODIGO.DataBinding.Field.AsString ;
    AAllow := TFactoryLinhasSemEdicao
                .New
                .fConfigura(FtlpTipoApuracao)
                .fGrupo(BASE_CALCULO)
                .fLinha(LstrInfoLinha)
                .fPodeEditar ;
  end ;
end;

procedure TfrmApuracaoLucroPresumido.pAfterPost(DataSet: TDataSet);
var
  LintCodigoBC, LintCodigoAP: Integer ;
  LobjProcessa: ITipoApuracaoLucroPresumidoProcessaCalculos ;
begin
  LintCodigoBC := FcdsApuracaoBaseCalculo.FieldByName('AUTOINCREM').AsInteger ;
  LintCodigoAP := FcdsApuracaoValor.FieldByName('AUTOINCREM').AsInteger ;
  FcdsApuracaoBaseCalculo.DisableControls ;
  FcdsApuracaoValor.DisableControls ;
  try
    LobjProcessa := TFactoryApuracaoLucroPresumidoProcessaCalculos.New.fConfigura(FtlpTipoApuracao) ;
    LobjProcessa
      .CdsBaseCalculo(FcdsApuracaoBaseCalculo)
      .CdsApuracao(FcdsApuracaoValor)
      .fLinhaSemDados(FobjLinhaSemDados)
      .fReprocessar(edtEmpSel.Text, StrToInt(edtExercicio.Text)) ;
  finally
    FcdsApuracaoBaseCalculo.Locate('AUTOINCREM', LintCodigoBC, []) ;
    FcdsApuracaoValor.Locate('AUTOINCREM', LintCodigoAP, []) ;
    FcdsApuracaoBaseCalculo.EnableControls ;
    FcdsApuracaoValor.EnableControls ;
  end ;
end;

procedure TfrmApuracaoLucroPresumido.pConfguraNomeTab(
  const AtlpTipoApuracao: TTipoLucroPresumido);
begin
  if AtlpTipoApuracao = tlpCSLL then
  begin
    tsBaseCalculo.Caption := 'Base Cálculo da CSLL' ;
    tsApuracao.Caption := 'Cálculo da CSLL' ;
  end
  else if AtlpTipoApuracao = tlpIRPJ then
  begin
    tsBaseCalculo.Caption := 'Base Cálculo do IRPJ' ;
    tsApuracao.Caption := 'Cálculo do IRPJ' ;
  end ;
end;

procedure TfrmApuracaoLucroPresumido.pHabilitarEdicao(
  const AblnHabilitado: Boolean);
begin
  edtExercicio.Enabled := AblnHabilitado ;
  edtEmpSel.Enabled := AblnHabilitado ;
  edtNomEmpSel.Enabled := AblnHabilitado ;
  btnAbrir.Enabled := AblnHabilitado ;

  btnGravar.Enabled := not AblnHabilitado ;
  btnCancela.Enabled := not AblnHabilitado ;
  btnExcluir.Enabled := not AblnHabilitado ;

  pgcApuracao.Enabled := not AblnHabilitado ;
end;

procedure TfrmApuracaoLucroPresumido.pLimpaCampos;
begin
  FcdsApuracaoBaseCalculo.EmptyDataSet ;
  FcdsApuracaoValor.EmptyDataSet ;

  edtExercicio.Clear ;
  edtEmpSel.Clear ;
  edtNomEmpSel.Clear ;

  pgcApuracao.ActivePageIndex := 0 ;
  pSetFocus(edtExercicio);

end;

end.
