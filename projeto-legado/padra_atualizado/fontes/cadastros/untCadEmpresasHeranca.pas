unit untCadEmpresasHeranca;

interface

uses
  System.Classes, Winapi.Windows, Winapi.Messages, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, UniClientDataSet, Vcl.ComCtrls, Vcl.CheckLst, Uni,
  Vcl.DBCtrls, EditFocus, untTypesSistema, untModulo, cxProgressBar, untGravando;

type

  THerancaEmpresa = Class
  private
    FblnTemCondicaoAnterior : Boolean;
    FcdsCondicaoPagamento   : TUniClientDataSet;
    FcdsDireitoAcesso       : TUniClientDataSet;
    FcdsHeranca             : TUniClientDataSet;
    FQuery                  : TUniQuery;
    FstrComandoReplicacao   : String;
    FIP                     : String;

    FTesteDeConexao_Erro     : Boolean;
    FTesteDeConexao_Mensagem : String;

    function fOperadorEstaConectadoNoMesmoBancoFisico : Boolean;
    function fGetNumeroItensHerdados : Integer;
    function fValidaEmpresasInformadas(var AMensagem : String) : Boolean;
    procedure pCriarClientDataSetCondicaoPagamento;
    procedure pCriarClientDataSetDireitoAcesso;
    procedure pCriarClientDataSetHeranca;
    procedure pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa : String; ATemAcesso : Boolean; ACampoDAQuery : String);

    function fTesteDeConectividadeComBancoDeDados(pgbStatus: TcxProgressBar = Nil) : Boolean;
    function fTestaAcesso(strIP : String) : Boolean;
    function fRetornaIP_Acessivel(strIP_Primario, strIP_Secundario : String) : String;
    function fRetornaAcessoJahValidado(strIP_Primario, strIP_Secundario : String) : String;

    procedure pGravarValor_cdsHeranca(strField, strValor : String);
    function fValidarUSAREP : Boolean;

  public
    Constructor Create; Reintroduce;
    Destructor Destroy; Override;

    property cdsCondicaoPagamento   : TUniClientDataSet read FcdsCondicaoPagamento   write FcdsCondicaoPagamento;
    property cdsDireitoAcesso       : TUniClientDataSet read FcdsDireitoAcesso       write FcdsDireitoAcesso;
    property cdsHeranca             : TUniClientDataSet read FcdsHeranca             write FcdsHeranca;
    property intNumeroItensHerdados : integer           read fGetNumeroItensHerdados;
    property strComandoReplicacao   : string            read FstrComandoReplicacao   write FstrComandoReplicacao;

    function fGravarCondicaoPagamento(ACodigoNovaEmpresa : String) : Boolean;
    function fGravarDireitoAcesso(ACodigoNovaEmpresa : String) : Boolean;
    function fGravaLogRep(AstrNomeTabela : String) : Boolean;
    procedure pAtualizaComandoReplicacao(AstrParametro, AstrValor : String);
    procedure pProcessarCFGWebService(AstrCodigoEmpresa, AstrCNPJEmpresa : String);

    procedure pGravaLogRep(AQuery             : TUniQuery;
                           AstrNomeTabela,
                           AstrEmpresaOrigem,
                           AstrEmpresaDestino : String);

    function fSelecionouTarefaParaHerdar(ATarefasHerancaCadEmpresas : TTarefasHerancaCadEmpresas) : Boolean;
    function fHerdarDadosDoBancoFisico(ATarefasHerancaCadEmpresas : TTarefasHerancaCadEmpresas) : Boolean;
    function fRetornaIP_AcessivelParaHeranca(ATarefasHerancaCadEmpresas : TTarefasHerancaCadEmpresas) : String;

    function fExecutarHeranca(ATarefasHerancaCadEmpresas : TTarefasHerancaCadEmpresas;
                              AEmpOri                    : String;
                              AEmpDes                    : String) : Boolean;

    function fRetornarQuery(strIP : String) : TUniQuery; Overload;
    function fRetornarQuery(ATarefasHerancaCadEmpresas : TTarefasHerancaCadEmpresas) : TUniQuery; Overload;

  End;

  TfrmCadEmpresasHeranca = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    cxGridCitel1: TcxGridCitel;
    grdHeranca: TcxGridDBTableViewCitel;
    grdHerancaColumn1: TcxGridDBColumn;
    grdHerancaColumn2: TcxGridDBColumn;
    grdHerancaColumn3: TcxGridDBColumn;
    cxGridCitel1Level1: TcxGridLevel;
    chkAcesso: TCheckListBox;
    Label1: TLabel;
    Label2: TLabel;
    btnAddDireitoAcesso: TBitBtnLocked;
    cxGridCitel2: TcxGridCitel;
    cxGridDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    TabSheet3: TTabSheet;
    Label3: TLabel;
    btnAddCondicaoPagamento: TBitBtnLocked;
    cxGridCitel3: TcxGridCitel;
    cxGridDBTableViewCitel2: TcxGridDBTableViewCitel;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    dtsHeranca: TDataSource;
    dtsDireitoAcesso: TDataSource;
    dtsCondicaoPagamento: TDataSource;
    chkAcessoGeralTodos: TCheckBox;
    chkAcessoIndividualTodos: TCheckBox;
    chkCondicaoPagamentoTodos: TCheckBox;
    edtCodGpo: TEditFocus;
    edtDscGpo: TEditFocus;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    edtCodCnd: TEditFocus;
    edtDscCnd: TEditFocus;
    pnlObservacoes: TPanel;
    lblInformacao: TLabel;
    procedure FormShow(Sender: TObject);
    procedure grdHerancaEditKeyPress(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddDireitoAcessoClick(Sender: TObject);
    procedure btnAddCondicaoPagamentoClick(Sender: TObject);
    procedure chkAcessoGeralTodosClick(Sender: TObject);
    procedure chkAcessoIndividualTodosClick(Sender: TObject);
    procedure chkCondicaoPagamentoTodosClick(Sender: TObject);
    procedure edtCodGpoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FblnConfirma       : Boolean;
    FObjHerancaEmpresa : THerancaEmpresa;
    FQuery             : TUniQuery;
    arrConsGpo, arrConsOpe, arrConsCnd: TConsultasArray;

    procedure pAtualizaClienteDataSetDireitoAcesso;
    procedure pAtualizaClienteDataSetCondPagamento;
    procedure pLimparCamposDireitosDeAcesso;
    procedure pLimparCamposCondPagamento;
    procedure pMontarQueryAddDireitoAcesso;
    procedure pMontarQueryAddCondicaoPagamento;
    function fValidaFiltro(strFiltro: String; blnChecked: Boolean): Boolean;
    function fGetCodigosSelecionadosGrupo: String;
    function fGetCodigosSelecionadosOperador: String;
    function fGetCodigosSelecionadosCondPgto: String;
  public
    { Public declarations }
    property blnConfirma       : Boolean         read FblnConfirma       write FblnConfirma;
    property ObjHerancaEmpresa : THerancaEmpresa read FObjHerancaEmpresa write FObjHerancaEmpresa;
  protected
    { Protected declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, untConsultas, untPesqAux, SysUtils, StrUtils, untObservacao;

const
  TAREFAS_USAREP = 'CFGSIS_CFGTIN_CFGREL_LAYETI_CNF_NFE_CFGEMP_CNFBOL_CONEMP_CADCAR_';

{$R *.dfm}

procedure TfrmCadEmpresasHeranca.btnAddCondicaoPagamentoClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  btnAddCondicaoPagamento.Enabled := False;
  Try
    pMontarQueryAddCondicaoPagamento;

    If fEmptyStr(FQuery.Sql.Text) Then
      Exit;

    pAtualizaClienteDataSetCondPagamento;

    cxGridDBTableViewCitel2.DataController.FocusedRowIndex := 0;
  Finally
    pLimparCamposCondPagamento;
    btnAddCondicaoPagamento.Enabled := True;
  End;
end;

procedure TfrmCadEmpresasHeranca.btnAddDireitoAcessoClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;
  
  btnAddDireitoAcesso.Enabled := False;
  Try
    pMontarQueryAddDireitoAcesso;

    If fEmptyStr(FQuery.Sql.Text) Then
      Exit;

    pAtualizaClienteDataSetDireitoAcesso;

    cxGridDBTableViewCitel1.DataController.FocusedRowIndex := 0;
  Finally
    pLimparCamposDireitosDeAcesso;
    btnAddDireitoAcesso.Enabled := True;
  End;
end;

procedure TfrmCadEmpresasHeranca.btnConfirmaClick(Sender: TObject);
  var
    LMensagem : String;
begin
  if not FObjHerancaEmpresa.fValidaEmpresasInformadas(LMensagem) then
  Begin

    Try
      pCriarFormularios(TfrmObservacao, frmObservacao);
      frmObservacao.lblMensagem.Caption := 'ATENÇÃO!';
      frmObservacao.memObs.Texto        := LMensagem;
      frmObservacao.ShowModal;
    Finally
      pFreeAndNil(frmObservacao);
    End;

    Exit;

  End
  Else
    FblnConfirma := True;
end;

procedure TfrmCadEmpresasHeranca.chkAcessoGeralTodosClick(Sender: TObject);
begin
  inherited;
  edtCodGpo.Enabled := Not chkAcessoGeralTodos.Checked;
  If Not edtCodGpo.Enabled Then
  Begin
    edtCodGpo.Clear;
    edtDscGpo.Clear;
  End;
end;

procedure TfrmCadEmpresasHeranca.chkAcessoIndividualTodosClick(Sender: TObject);
begin
  inherited;
  edtCodOpe.Enabled := Not chkAcessoIndividualTodos.Checked;
  If Not edtCodOpe.Enabled Then
  Begin
    edtCodOpe.Clear;
    edtNomOpe.Clear;
  End;
end;

procedure TfrmCadEmpresasHeranca.chkCondicaoPagamentoTodosClick(
  Sender: TObject);
begin
  inherited;
  edtCodCnd.Enabled := Not chkCondicaoPagamentoTodos.Checked;
  If Not edtCodCnd.Enabled Then
  Begin
    edtCodCnd.Clear;
    edtDscCnd.Clear;
  End;
end;

procedure TfrmCadEmpresasHeranca.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCondicoesPgto(Self, edtCodCnd, edtDscCnd, Nil, Key, arrConsCnd, False) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadEmpresasHeranca.edtCodGpoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoOperador(Self, edtCodGpo, edtDscGpo, Nil, Key, arrConsGpo, False) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadEmpresasHeranca.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodOpe, edtNomOpe, Nil, Key, arrConsOpe, False) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmCadEmpresasHeranca.fGetCodigosSelecionadosCondPgto: String;
  Var
    objCons: TConsultas;
begin
  Result := '';

  If Not fEmptyStr(edtCodCnd.Text) Then
  Begin
    If edtDscCnd.Text <> '+1' Then
      Result := '"'+ edtCodCnd.Text +'"'
    Else
    Begin
      For objCons In arrConsCnd Do
        Result := Result +'"'+ objCons.strCodigo +'",';
      Result := Copy(Result, 1, Length(Result) -1);
    End;
  End;
end;

function TfrmCadEmpresasHeranca.fGetCodigosSelecionadosGrupo: String;
  Var
    objCons: TConsultas;
begin
  Result := '';

  If Not fEmptyStr(edtCodGpo.Text) Then
  Begin
    If edtDscGpo.Text <> '+1' Then
      Result := '"'+ edtCodGpo.Text +'"'
    Else
    Begin
      For objCons In arrConsGpo Do
        Result := Result +'"'+ objCons.strCodigo +'",';
      Result := Copy(Result, 1, Length(Result) -1);
    End;
  End;
end;

function TfrmCadEmpresasHeranca.fGetCodigosSelecionadosOperador: String;
  Var
    objCons: TConsultas;
begin
  Result := '';

  If Not fEmptyStr(edtCodOpe.Text) Then
  Begin
    If edtNomOpe.Text <> '+1' Then
      Result := '"'+ edtCodOpe.Text +'"'
    Else
    begin
      For objCons In arrConsOpe Do
        Result := Result +'"'+ objCons.strCodigo +'",';
      Result := Copy(Result, 1, Length(Result) -1);
    end;
  End;
end;

procedure TfrmCadEmpresasHeranca.FormCreate(Sender: TObject);
begin
  inherited;
  FblnConfirma := False;
  FQuery       := fCriaQuery(nil);

  lblInformacao.Caption := StringReplace(lblInformacao.Caption, '[TABELAS]', TAREFAS_USAREP, [rfReplaceAll]);

end;

procedure TfrmCadEmpresasHeranca.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FQuery);
end;

procedure TfrmCadEmpresasHeranca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmCadEmpresasHeranca.FormShow(Sender: TObject);
begin
  inherited;
  dtsHeranca.dataset           := FObjHerancaEmpresa.cdsHeranca;
  dtsDireitoAcesso.dataset     := FObjHerancaEmpresa.cdsDireitoAcesso;
  dtsCondicaoPagamento.dataset := FObjHerancaEmpresa.cdsCondicaoPagamento;

  pageControl1.ActivePage := TabSheet1;
end;

function TfrmCadEmpresasHeranca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtCodGpo) Then
    Begin
      If edtDscGpo.Text = '+1' Then
        Exit;

      If Not fEmptyStr(edtCodGpo.Text) Then
      Begin
        edtDscGpo.Text := fRetNomCadGpo(edtCodGpo.Text);
        If (fEmptyStr(edtDscGpo.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Grupo de Operador informado não existe!', ['&OK']);
          Result := False;
        End;
      End
      Else
        edtDscGpo.Clear;
    End

    Else If (Sender = edtCodOpe) Then
    Begin
      If edtNomOpe.Text = '+1' Then
        Exit;
    
      If Not fEmptyStr(edtCodOpe.Text) Then
      Begin
        edtNomOpe.Text := fRetNomeOperador(edtCodOpe.Text);
        If (fEmptyStr(edtNomOpe.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Operador informado não existe!', ['&OK']);
          Result := False;
        End;
      End
      Else
        edtNomOpe.Clear;
    End

    Else If (Sender = edtCodCnd) Then
    Begin
      If edtDscCnd.Text = '+1' Then
        Exit;
    
      If Not fEmptyStr(edtCodCnd.Text) Then
      Begin
        edtDscCnd.Text := fRetDesConPag(edtCodCnd.Text);
        If (fEmptyStr(edtDscCnd.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Condição de Pagamento informada não existe!', ['&OK']);
          Result := False;
        End;
      End
      Else
        edtDscCnd.Clear;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadEmpresasHeranca.fValidaFiltro(strFiltro: String;
  blnChecked: Boolean): Boolean;
begin
  Result := True;

  If Not fEmptyStr(strFiltro) Then
    Exit;

  If blnChecked Then
    Exit;

  Result := False;
end;

procedure TfrmCadEmpresasHeranca.grdHerancaEditKeyPress(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
  Var
    LQueryEmpresa : TUniQuery;
    LarrEmpresa   : TConsultasArray;
begin
  inherited;

  If (AItem as TcxGridDBColumn).DataBinding.FieldName <> 'HER_EMPORI' then
    Exit;

  If fEntraCons(Key) Then
  Begin

    LQueryEmpresa := fCriaQuery(Self);

    If fPesqEmpresa(conEmpSimples, Self, Nil, Nil, LQueryEmpresa, Key, LarrEmpresa) Then
    Begin
      AItem.EditValue := LQueryEmpresa.FieldByName('EMP_CODEMP').AsString;
    End;

    FreeAndNil(LQueryEmpresa);
  End;
end;

procedure TfrmCadEmpresasHeranca.pAtualizaClienteDataSetCondPagamento;
begin
  FObjHerancaEmpresa.cdsCondicaoPagamento.DisableControls;

  FQuery.Open;
  FQuery.First;
  while not FQuery.Eof do
  Begin
    If FObjHerancaEmpresa.cdsCondicaoPagamento.FindKey([FQuery.FieldByName('CND_CODIGO').AsString]) Then
      FObjHerancaEmpresa.cdsCondicaoPagamento.Edit
    Else
      FObjHerancaEmpresa.cdsCondicaoPagamento.Append;

    FObjHerancaEmpresa.cdsCondicaoPagamento.FieldByName('CND_CODCND').AsString := FQuery.FieldByName('CND_CODIGO').AsString;
    FObjHerancaEmpresa.cdsCondicaoPagamento.FieldByName('CND_NOMCND').AsString := FQuery.FieldByName('CND_DESCRI').AsString;
    FObjHerancaEmpresa.cdsCondicaoPagamento.Post;

    FQuery.Next;
  End;

  FObjHerancaEmpresa.cdsCondicaoPagamento.EnableControls;
  FQuery.Close;
end;

procedure TfrmCadEmpresasHeranca.pAtualizaClienteDataSetDireitoAcesso;
  var
    LIdx : Integer;
begin
  FObjHerancaEmpresa.cdsDireitoAcesso.DisableControls;

  FQuery.Open;
  FQuery.First;
  while not FQuery.Eof do
  Begin
    If FObjHerancaEmpresa.cdsDireitoAcesso.FindKey([FQuery.FieldByName('OPE_CODOPE').AsString]) Then
      FObjHerancaEmpresa.cdsDireitoAcesso.Edit
    Else
      FObjHerancaEmpresa.cdsDireitoAcesso.Append;

    FObjHerancaEmpresa.cdsDireitoAcesso.FieldByName('DIR_CODOPE').AsString := FQuery.FieldByName('OPE_CODOPE').AsString;
    FObjHerancaEmpresa.cdsDireitoAcesso.FieldByName('DIR_NOMOPE').AsString := FQuery.FieldByName('OPE_NOMOPE').AsString;

    FObjHerancaEmpresa.cdsDireitoAcesso.FieldByName('DIR_EMPLOG').AsBoolean := False;
    FObjHerancaEmpresa.cdsDireitoAcesso.FieldByName('DIR_EMPACE').AsBoolean := False;
    FObjHerancaEmpresa.cdsDireitoAcesso.FieldByName('DIR_EMPROM').AsBoolean := False;
    FObjHerancaEmpresa.cdsDireitoAcesso.FieldByName('DIR_EMPCTR').AsBoolean := False;
    FObjHerancaEmpresa.cdsDireitoAcesso.FieldByName('DIR_EMPCTP').AsBoolean := False;
    FObjHerancaEmpresa.cdsDireitoAcesso.FieldByName('DIR_EMPEST').AsBoolean := False;
    for LIdx := 0 to 5 do
    Begin
      if chkAcesso.Checked[Lidx] then
      begin
        case LIdx of
          0 : FObjHerancaEmpresa.cdsDireitoAcesso.FieldByName('DIR_EMPLOG').AsBoolean := True;
          1 : FObjHerancaEmpresa.cdsDireitoAcesso.FieldByName('DIR_EMPACE').AsBoolean := True;
          2 : FObjHerancaEmpresa.cdsDireitoAcesso.FieldByName('DIR_EMPROM').AsBoolean := True;
          3 : FObjHerancaEmpresa.cdsDireitoAcesso.FieldByName('DIR_EMPCTR').AsBoolean := True;
          4 : FObjHerancaEmpresa.cdsDireitoAcesso.FieldByName('DIR_EMPCTP').AsBoolean := True;
          5 : FObjHerancaEmpresa.cdsDireitoAcesso.FieldByName('DIR_EMPEST').AsBoolean := True;
        End;
      end;
    End;

    FObjHerancaEmpresa.cdsDireitoAcesso.Post;
    FQuery.Next;
  End;

  FObjHerancaEmpresa.cdsDireitoAcesso.EnableControls;
  FQuery.Close;
end;

procedure TfrmCadEmpresasHeranca.pLimparCamposCondPagamento;
begin
  edtCodCnd.Clear;
  edtDscCnd.Clear;  
  chkCondicaoPagamentoTodos.Checked := False;
end;

procedure TfrmCadEmpresasHeranca.pLimparCamposDireitosDeAcesso;
  var
    LIdx : Integer;
begin
  edtCodGpo.Clear;
  edtDscGpo.Clear;
  edtCodOpe.Clear;
  edtNomOpe.Clear;
  chkAcessoGeralTodos.Checked      := False;
  chkAcessoIndividualTodos.Checked := False;  

  for LIdx := 0 to 5 do
    chkAcesso.Checked[Lidx] := False;
end;

procedure TfrmCadEmpresasHeranca.pMontarQueryAddCondicaoPagamento;
  Var
    strCodCnd: String;
begin
  FQuery.Sql.Clear;

  strCodCnd := fGetCodigosSelecionadosCondPgto;

  If fValidaFiltro(strCodCnd, chkCondicaoPagamentoTodos.Checked) Then
  Begin
    FQuery.Sql.Add(' SELECT CND_CODIGO, CND_DESCRI FROM CADCND ');
    FQuery.Sql.Add(' WHERE CND_STATUS = "A" ');

    If Not chkCondicaoPagamentoTodos.Checked Then
      FQuery.Sql.Add(' AND CND_CODIGO IN ('+ strCodCnd +') ');
  End;
end;

procedure TfrmCadEmpresasHeranca.pMontarQueryAddDireitoAcesso;
  Var
    strCodGpo, strCodOpe: String;
begin
  FQuery.Sql.Clear;

  strCodGpo := fGetCodigosSelecionadosGrupo;
  strCodOpe := fGetCodigosSelecionadosOperador;

  If fValidaFiltro(strCodGpo, chkAcessoGeralTodos.Checked) Then
  Begin
    FQuery.Sql.Add(' SELECT CADOPE.OPE_CODOPE, CADOPE.OPE_NOMOPE ');
    FQuery.Sql.Add(' FROM OPEGPO ');
    FQuery.Sql.Add(' JOIN CADOPE ON CADOPE.OPE_CODOPE = OPEGPO.OPE_CODOPE ');
    FQuery.Sql.Add(' WHERE CADOPE.OPE_STATUS = "A" ');

    If Not chkAcessoGeralTodos.Checked Then
      FQuery.Sql.Add(' AND OPEGPO.GPO_CODGPO IN ('+ strCodGpo +') ');
  End;

  If fValidaFiltro(strCodOpe, chkAcessoIndividualTodos.Checked) Then
  Begin
    if not fEmptyStr(FQuery.Sql.Text) then
      FQuery.Sql.Add(' UNION ');

    FQuery.Sql.Add(' SELECT CADOPE.OPE_CODOPE, CADOPE.OPE_NOMOPE ');
    FQuery.Sql.Add(' FROM CADOPE ');
    FQuery.Sql.Add(' WHERE OPE_STATUS = "A" ');

    If Not chkAcessoIndividualTodos.Checked Then
      FQuery.Sql.Add(' AND OPE_CODOPE IN ('+ strCodOpe +') ');
  End;
end;

{ THerancaEmpresa }

constructor THerancaEmpresa.Create;
begin
  inherited;

  FQuery := fCriaQuery(nil);

  pCriarClientDataSetHeranca;
  pCriarClientDataSetDireitoAcesso;
  pCriarClientDataSetCondicaoPagamento;

  FTesteDeConexao_Erro     := False;
  FTesteDeConexao_Mensagem := '';

end;

destructor THerancaEmpresa.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FcdsCondicaoPagamento);
  FreeAndNil(FcdsDireitoAcesso);
  FreeAndNil(FcdsHeranca);
  inherited;
end;

function THerancaEmpresa.fExecutarHeranca(ATarefasHerancaCadEmpresas : TTarefasHerancaCadEmpresas;
                                          AEmpOri                    : String;
                                          AEmpDes                    : String) : Boolean;
Var
  qryGenCfg   : TUniQuery;
  qryBDFisico : TUniQuery;
Const
  QUANTIDADE_INSERCOES_POR_VEZ = 500;
begin

  Result := False;

  qryBDFisico := fRetornarQuery(fRetornaIP_AcessivelParaHeranca(ATarefasHerancaCadEmpresas));
  qryGenCfg   := fCriaQuery;

  Try

    qryBDFisico.Close;
    qryBDFisico.SQL.Clear;
    qryBDFisico.SQL.Add(ATarefasHerancaCadEmpresas.GetSQL);
    qryBDFisico.ParamByName('ORI_CODEMP').AsString := AEmpOri;
    qryBDFisico.ParamByName('DES_CODEMP').AsString := AEmpDes;
    qryBDFisico.Open;

    If qryBDFisico.IsEmpty Then
      Exit;

    qryGenCfg.Close;
    qryGenCfg.SQL.Clear;

    qryBDFisico.First;
    While Not qryBDFisico.Eof Do
    Begin

      qryGenCfg.SQL.Append(qryBDFisico.FieldByName('INS').AsString);
      qryBDFisico.Next;

      If (qryGenCfg.SQL.Count >= QUANTIDADE_INSERCOES_POR_VEZ) Or (qryBDFisico.Eof) Then
      Begin

        Try

          qryGenCfg.ExecSQL;
          pGravaLogRep(qryGenCfg, ATarefasHerancaCadEmpresas.GetValue, AEmpOri, AEmpDes);

          qryGenCfg.SQL.Clear;
          Result := True;

        Except
          Exit(False);
        End;

      End;

    End;

  Finally
    FreeAndNil(qryBDFisico);
    FreeAndNil(qryGenCfg);
  End;

end;

function THerancaEmpresa.fGetNumeroItensHerdados: Integer;
begin
  Result := 0;
  FcdsHeranca.DisableControls;
  FcdsHeranca.First;
  while not FcdsHeranca.Eof do
  begin
    if FcdsHeranca.FieldByName('HER_CHECKD').AsBoolean then
      Result := Result + 1;
    FcdsHeranca.Next;
  end;
  FcdsHeranca.EnableControls;

  {***************************************************************************
  Mais 2 por conta dos passos para gravar o direito de acesso e as condições de pagamento
  *************************************************************************GD*}
  Result := Result + 2;
end;

function THerancaEmpresa.fGravaLogRep(AstrNomeTabela : String): Boolean;
begin
  Result := untFuncoesSimples.fGravaLogRep(FstrComandoReplicacao.Replace(#13#10, ' '), AstrNomeTabela, 'N', frmModulo.GetCurrentConnection);
end;

function THerancaEmpresa.fGravarCondicaoPagamento(ACodigoNovaEmpresa: String): Boolean;
begin
  Result := True;

  FQuery.Sql.Clear;
  FQuery.Sql.Text := 'UPDATE CADCND SET CND_EMPACE = CONCAT('''+ACodigoNovaEmpresa+'_'', CND_EMPACE) WHERE CND_CODIGO = :CODIGO ';

  Try
    FcdsCondicaoPagamento.First;
    while not FcdsCondicaoPagamento.Eof do
    Begin
      Fquery.ParamByName('CODIGO').AsString := FcdsCondicaoPagamento.FieldByName('CND_CODCND').AsString;
      Fquery.ExecSql;

      FcdsCondicaoPagamento.Next;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[THerancaEmpresa.fGravarCondicaoPagamento]');
    End;
  End;

end;

function THerancaEmpresa.fGravarDireitoAcesso(ACodigoNovaEmpresa : String): Boolean;
begin
  Result := True;

  Try
    FcdsDireitoAcesso.First;
    while not FcdsDireitoAcesso.Eof do
    Begin
      FblnTemCondicaoAnterior := False;

      FQuery.Sql.Clear;
      FQuery.Sql.Text := 'UPDATE CADOPE SET ';

      pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, FcdsDireitoAcesso.FieldByName('DIR_EMPLOG').AsBoolean, 'OPE_EMPLOG');
      pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, FcdsDireitoAcesso.FieldByName('DIR_EMPACE').AsBoolean, 'OPE_EMPACE');
      pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, FcdsDireitoAcesso.FieldByName('DIR_EMPROM').AsBoolean, 'OPE_EMPROM');
      pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, FcdsDireitoAcesso.FieldByName('DIR_EMPCTR').AsBoolean, 'OPE_EMPCTR');
      pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, FcdsDireitoAcesso.FieldByName('DIR_EMPCTP').AsBoolean, 'OPE_EMPCTP');
      pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, FcdsDireitoAcesso.FieldByName('DIR_EMPEST').AsBoolean, 'OPE_EMPEST');

      if not FblnTemCondicaoAnterior then
      Begin
        FcdsDireitoAcesso.Next;
        continue;
      End;

      FQuery.Sql.Text := FQuery.Sql.Text + ' WHERE OPE_CODOPE = :CODOPE ';
      Fquery.ParamByName('CODOPE'     ).AsString := FcdsDireitoAcesso.FieldByName('DIR_CODOPE').AsString;
      Fquery.ExecSql;

      FcdsDireitoAcesso.Next;
    End;

    //MF: 280817 - 17/05/2023 - ini
    FblnTemCondicaoAnterior := False;
    FQuery.Sql.Clear;
    FQuery.Sql.Text := 'UPDATE CADOPE SET ';

    pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, True, 'OPE_EMPLOG');
    pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, True, 'OPE_EMPACE');
    pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, True, 'OPE_EMPROM');
    pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, True, 'OPE_EMPCTR');
    pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, True, 'OPE_EMPCTP');
    pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, True, 'OPE_EMPEST');
    pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, True, 'OPE_EMPFAT');
    pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, True, 'OPE_EMPLIB');
    pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa, True, 'OPE_EMPMTL');

    FQuery.Sql.Text := FQuery.Sql.Text + ' WHERE OPE_CODOPE IN (''999'', ''998'', ''997'')';
    Fquery.ExecSql;
    //MF: 280817 - 17/05/2023 - fim

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[THerancaEmpresa.fGravarDireitoAcesso]');
    End;
  End;

end;

function THerancaEmpresa.fHerdarDadosDoBancoFisico(ATarefasHerancaCadEmpresas: TTarefasHerancaCadEmpresas): Boolean;
begin

  Result := False;

  If Not cdsHeranca.Locate('HER_DESCRI', ATarefasHerancaCadEmpresas.GetValue, []) Then
    Exit;

  If fEmptyStr(cdsHeranca.FieldByName('HER_END_IP').AsString) Then
    Exit;

  Result := True;

end;

function THerancaEmpresa.fOperadorEstaConectadoNoMesmoBancoFisico: Boolean;
begin
  Result := (VS_strCodEmp = fCampoTabela('PRO_CODEMP', 'PROCOD', ['PRO_NOMARQ'], ['MOVGER']));
end;

function THerancaEmpresa.fSelecionouTarefaParaHerdar(ATarefasHerancaCadEmpresas: TTarefasHerancaCadEmpresas): Boolean;
begin

  Result := False;

  If Not cdsHeranca.Locate('HER_DESCRI', ATarefasHerancaCadEmpresas.GetValue, []) Then
    Exit;

  If Not cdsHeranca.FieldByName('HER_CHECKD').AsBoolean Then
    Exit;

  Result := True;

end;

function THerancaEmpresa.fRetornaAcessoJahValidado(strIP_Primario, strIP_Secundario : String): String;
var
  cdsCloneDados : TUniClientDataSet;
begin

  Result := '';

  cdsCloneDados := TUniClientDataSet.Create(nil);

  Try

    pCloneDataSet(cdsCloneDados, cdsHeranca);

    If Not fEmptyStr(strIP_Primario) Then
      If cdsCloneDados.Locate('HER_END_IP', strIP_Primario, []) Then
        Result := strIP_Primario;

    If Not fEmptyStr(strIP_Secundario) Then
      If cdsCloneDados.Locate('HER_END_IP', strIP_Secundario, []) Then
        Result := strIP_Secundario;

  Finally;
    FreeAndNil(cdsCloneDados);
  End;

end;

function THerancaEmpresa.fRetornaIP_Acessivel(strIP_Primario, strIP_Secundario : String): String;
var
  strIP_Jah_Validado : String;
begin

  Result := '';

  strIP_Jah_Validado := fRetornaAcessoJahValidado(strIP_Primario, strIP_Secundario);

  If Not fEmptyStr(strIP_Jah_Validado) Then
    Exit(strIP_Jah_Validado);

  If fTestaAcesso(strIP_Primario) Then
    Exit(strIP_Primario);

  If fTestaAcesso(strIP_Secundario) Then
    Exit(strIP_Secundario);

end;

function THerancaEmpresa.fRetornaIP_AcessivelParaHeranca(ATarefasHerancaCadEmpresas: TTarefasHerancaCadEmpresas): String;
begin

  Result := '';

  If Not cdsHeranca.Locate('HER_DESCRI', ATarefasHerancaCadEmpresas.GetValue, []) Then
    Exit;

  Result := cdsHeranca.FieldByName('HER_END_IP').AsString;

end;

function THerancaEmpresa.fRetornarQuery(ATarefasHerancaCadEmpresas: TTarefasHerancaCadEmpresas): TUniQuery;
var
  strIPAcessivel : String;
begin

  Result := Nil;

  strIPAcessivel := fRetornaIP_AcessivelParaHeranca(ATarefasHerancaCadEmpresas);

  If (strIPAcessivel.IsEmpty) Then
    Exit;

  Result := fRetornarQuery(strIPAcessivel);

end;

function THerancaEmpresa.fRetornarQuery(strIP: String): TUniQuery;
var
  Conexao: TUniConnection;
begin

  Result := Nil;

  If strIP.IsEmpty Then
    Exit;

  Conexao := TUniConnection.Create(Nil);

  Conexao.Disconnect;

  Conexao.Server   := IIF(fOperadorEstaConectadoNoMesmoBancoFisico, frmModulo.GetCurrentConnection.Server, strIP);
  Conexao.Port     := frmModulo.GetCurrentConnection.Port;
  Conexao.Database := frmModulo.GetCurrentConnection.Database;
  Conexao.Username := frmModulo.GetCurrentConnection.Username;
  Conexao.Password := frmModulo.GetCurrentConnection.Password;
  Conexao.ProviderName := frmModulo.GetCurrentConnection.ProviderName;

  Try

    Conexao.Connect;

    Result := TUniQuery.Create(Nil);

    Result.Connection := Conexao;
    Result.Options.RequiredFields := False;

  Except
    Result := Nil;
  End;

end;

function THerancaEmpresa.fTestaAcesso(strIP : String): Boolean;
var
  frmAguarde: TfrmGravando;
begin

  If strIP.IsEmpty Then
    Exit(False);

  Try

    FIP := strIP;

    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fTesteDeConectividadeComBancoDeDados;
    frmAguarde.ShowModal;
    Result := frmAguarde.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

end;

function THerancaEmpresa.fTesteDeConectividadeComBancoDeDados(pgbStatus: TcxProgressBar = Nil): Boolean;
var
  Conexao: TUniConnection;
begin

  Result := False;

  If FIP.IsEmpty Then
    Exit;

  pInformacao('Testando conexão com o banco de dados, Aguarde....', pgbStatus);

  Conexao := TUniConnection.Create(Nil);

  Try

    Conexao.Disconnect;

    Conexao.Server   := FIP;
    Conexao.Port     := frmModulo.GetCurrentConnection.Port;
    Conexao.Database := frmModulo.GetCurrentConnection.Database;
    Conexao.Username := frmModulo.GetCurrentConnection.Username;
    Conexao.Password := frmModulo.GetCurrentConnection.Password;
    Conexao.ProviderName := frmModulo.GetCurrentConnection.ProviderName;

    FTesteDeConexao_Erro     := False;
    FTesteDeConexao_Mensagem := '';

    Try
      Conexao.Connect;
      Result := Conexao.Connected;
    Except

      On E: Exception Do
      Begin

        Result := False;

        FTesteDeConexao_Erro     := True;
        FTesteDeConexao_Mensagem := 'IP       : ' + Conexao.Server        + #13 +
                                    'Porta    : ' + Conexao.Port.ToString + #13 +
                                    'Database : ' + Conexao.Database      + #13 +
                                    'Retorno  : ' + E.message             + #13;

      End;

    End;

  Finally
    FreeAndNil(Conexao);
  End;

end;

function THerancaEmpresa.fValidaEmpresasInformadas(var AMensagem : String): Boolean;
var
  LQueryEmpresa   : TUniQuery;
  strIP_Acessivel : String;
begin
  Result := True;

  LQueryEmpresa := fCriaQuery(nil);
  Try
    FcdsHeranca.DisableControls;
    FcdsHeranca.First;
    while not FcdsHeranca.Eof do
    begin

      pGravarValor_cdsHeranca('HER_EMPORI', fPadL(FcdsHeranca.FieldByName('HER_EMPORI').AsString, 3, '0'));

      pPesquisaCadEmp(LQueryEmpresa, LQueryEmpresa, FcdsHeranca.FieldByName('HER_EMPORI').AsString);

      if fEmptyStr(LQueryEmpresa.FieldByName('EMP_CODEMP').AsString) Then
      Begin
        AMensagem := 'A empresa "'+FcdsHeranca.FieldByName('HER_EMPORI').AsString+'" não está cadastrada. O processo será finalizado!';
        Exit(False);
      End;

      If (Not fOperadorEstaConectadoNoMesmoBancoFisico) And
         (fValidarUSAREP)                               And
         (LQueryEmpresa.FieldByName('EMP_USAREP').AsString.Equals('S')) Then
      Begin

        strIP_Acessivel := fRetornaIP_Acessivel(LQueryEmpresa.FieldByName('EMP_NUM_IP').AsString,
                                                LQueryEmpresa.FieldByName('EMP_NIP_SEC').AsString);

        If Not fEmptyStr(strIP_Acessivel) Then
          pGravarValor_cdsHeranca('HER_END_IP', strIP_Acessivel)
        Else
        Begin
          AMensagem := 'O banco de dados da empresa "'+FcdsHeranca.FieldByName('HER_EMPORI').AsString+'" não está acessível.' + #13 + #13;
          AMensagem := AMensagem + IIF(FTesteDeConexao_Erro, FTesteDeConexao_Mensagem + #13, EmptyStr);
          AMensagem := AMensagem + 'O processo será finalizado!';
          Exit(False);
        End;

      End;

      FcdsHeranca.Next;

    end;

  Finally
    FcdsHeranca.EnableControls;
    FreeAndNil(LQueryEmpresa);
  End;

end;

function THerancaEmpresa.fValidarUSAREP: Boolean;
begin
  Result := Pos(FcdsHeranca.FieldByName('HER_DESCRI').AsString, TAREFAS_USAREP) > 0;
end;

procedure THerancaEmpresa.pAtualizaComandoReplicacao(AstrParametro, AstrValor: String);
begin
  FstrComandoReplicacao := AnsiReplaceStr(FstrComandoReplicacao, ':'+AstrParametro, AstrValor);
end;

procedure THerancaEmpresa.pCriarClientDataSetCondicaoPagamento;
begin
  FcdsCondicaoPagamento := TUniClientDataSet.Create(nil);

  FcdsCondicaoPagamento.FieldDefs.Add('CND_CODCND', ftString, 003, False);
  FcdsCondicaoPagamento.FieldDefs.Add('CND_NOMCND', ftString, 100, False);

  FcdsCondicaoPagamento.IndexFieldNames := 'CND_CODCND'; //usado no FindKey (mais performático que o Locate)
  FcdsCondicaoPagamento.CreateDataSet;
  FcdsCondicaoPagamento.Open;
end;

procedure THerancaEmpresa.pCriarClientDataSetDireitoAcesso;
begin
  FcdsDireitoAcesso := TUniClientDataSet.Create(nil);

  FcdsDireitoAcesso.FieldDefs.Add('DIR_CODOPE', ftString, 003, False);
  FcdsDireitoAcesso.FieldDefs.Add('DIR_NOMOPE', ftString, 100, False);
  FcdsDireitoAcesso.FieldDefs.Add('DIR_EMPLOG', ftBoolean,  0, False);
  FcdsDireitoAcesso.FieldDefs.Add('DIR_EMPACE', ftBoolean,  0, False);
  FcdsDireitoAcesso.FieldDefs.Add('DIR_EMPROM', ftBoolean,  0, False);
  FcdsDireitoAcesso.FieldDefs.Add('DIR_EMPCTR', ftBoolean,  0, False);
  FcdsDireitoAcesso.FieldDefs.Add('DIR_EMPCTP', ftBoolean,  0, False);
  FcdsDireitoAcesso.FieldDefs.Add('DIR_EMPEST', ftBoolean,  0, False);

  FcdsDireitoAcesso.IndexFieldNames := 'DIR_CODOPE'; //usado no FindKey (mais performático que o Locate)
  FcdsDireitoAcesso.CreateDataSet;
  FcdsDireitoAcesso.Open;
end;

procedure THerancaEmpresa.pCriarClientDataSetHeranca;
begin
  FcdsHeranca := TUniClientDataSet.Create(nil);

  FcdsHeranca.FieldDefs.Add('HER_CHECKD', ftBoolean,  0, False);
  FcdsHeranca.FieldDefs.Add('HER_DESCRI', ftString, 100, False);
  FcdsHeranca.FieldDefs.Add('HER_EMPORI', ftString, 100, False);
  FcdsHeranca.FieldDefs.Add('HER_END_IP', ftString, 100, False);

  FcdsHeranca.CreateDataSet;
  FcdsHeranca.Open;

  FcdsHeranca.Append;
  FcdsHeranca.FieldByName('HER_CHECKD').AsBoolean := True;
  FcdsHeranca.FieldByName('HER_DESCRI').AsString  := 'ITEGER';
  FcdsHeranca.FieldByName('HER_EMPORI').AsString  := VS_strCodEmp;
  FcdsHeranca.FieldByName('HER_END_IP').Clear;
  FcdsHeranca.Post;

  FcdsHeranca.Append;
  FcdsHeranca.FieldByName('HER_CHECKD').AsBoolean := True;
  FcdsHeranca.FieldByName('HER_DESCRI').AsString  := 'ACAGER';
  FcdsHeranca.FieldByName('HER_EMPORI').AsString  := VS_strCodEmp;
  FcdsHeranca.FieldByName('HER_END_IP').Clear;
  FcdsHeranca.Post;

  FcdsHeranca.Append;
  FcdsHeranca.FieldByName('HER_CHECKD').AsBoolean := True;
  FcdsHeranca.FieldByName('HER_DESCRI').AsString  := 'CFGSIS';
  FcdsHeranca.FieldByName('HER_EMPORI').AsString  := VS_strCodEmp;
  FcdsHeranca.FieldByName('HER_END_IP').Clear;
  FcdsHeranca.Post;

  FcdsHeranca.Append;
  FcdsHeranca.FieldByName('HER_CHECKD').AsBoolean := True;
  FcdsHeranca.FieldByName('HER_DESCRI').AsString  := 'CFGTIN';
  FcdsHeranca.FieldByName('HER_EMPORI').AsString  := VS_strCodEmp;
  FcdsHeranca.FieldByName('HER_END_IP').Clear;
  FcdsHeranca.Post;

  FcdsHeranca.Append;
  FcdsHeranca.FieldByName('HER_CHECKD').AsBoolean := True;
  FcdsHeranca.FieldByName('HER_DESCRI').AsString  := 'CFGREL';
  FcdsHeranca.FieldByName('HER_EMPORI').AsString  := VS_strCodEmp;
  FcdsHeranca.FieldByName('HER_END_IP').Clear;
  FcdsHeranca.Post;

  FcdsHeranca.Append;
  FcdsHeranca.FieldByName('HER_CHECKD').AsBoolean := True;
  FcdsHeranca.FieldByName('HER_DESCRI').AsString  := 'LAYETI';
  FcdsHeranca.FieldByName('HER_EMPORI').AsString  := VS_strCodEmp;
  FcdsHeranca.FieldByName('HER_END_IP').Clear;
  FcdsHeranca.Post;

  FcdsHeranca.Append;
  FcdsHeranca.FieldByName('HER_CHECKD').AsBoolean := True;
  FcdsHeranca.FieldByName('HER_DESCRI').AsString  := 'CNF_NFE';
  FcdsHeranca.FieldByName('HER_EMPORI').AsString  := VS_strCodEmp;
  FcdsHeranca.FieldByName('HER_END_IP').Clear;
  FcdsHeranca.Post;

  FcdsHeranca.Append;
  FcdsHeranca.FieldByName('HER_CHECKD').AsBoolean := True;
  FcdsHeranca.FieldByName('HER_DESCRI').AsString  := 'CFGEMP';
  FcdsHeranca.FieldByName('HER_EMPORI').AsString  := VS_strCodEmp;
  FcdsHeranca.FieldByName('HER_END_IP').Clear;
  FcdsHeranca.Post;

  FcdsHeranca.Append;
  FcdsHeranca.FieldByName('HER_CHECKD').AsBoolean := True;
  FcdsHeranca.FieldByName('HER_DESCRI').AsString  := 'CADLOT';
  FcdsHeranca.FieldByName('HER_EMPORI').AsString  := VS_strCodEmp;
  FcdsHeranca.FieldByName('HER_END_IP').Clear;
  FcdsHeranca.Post;

  FcdsHeranca.Append;
  FcdsHeranca.FieldByName('HER_CHECKD').AsBoolean := True;
  FcdsHeranca.FieldByName('HER_DESCRI').AsString  := 'CNFBOL';
  FcdsHeranca.FieldByName('HER_EMPORI').AsString  := VS_strCodEmp;
  FcdsHeranca.FieldByName('HER_END_IP').Clear;
  FcdsHeranca.Post;

  FcdsHeranca.Append;
  FcdsHeranca.FieldByName('HER_CHECKD').AsBoolean := True;
  FcdsHeranca.FieldByName('HER_DESCRI').AsString  := 'CONEMP';
  FcdsHeranca.FieldByName('HER_EMPORI').AsString  := VS_strCodEmp;
  FcdsHeranca.FieldByName('HER_END_IP').Clear;
  FcdsHeranca.Post;

  FcdsHeranca.Append;
  FcdsHeranca.FieldByName('HER_CHECKD').AsBoolean := True;
  FcdsHeranca.FieldByName('HER_DESCRI').AsString  := 'CADCAR';
  FcdsHeranca.FieldByName('HER_EMPORI').AsString  := VS_strCodEmp;
  FcdsHeranca.FieldByName('HER_END_IP').Clear;
  FcdsHeranca.Post;

  if (fCfgSis('TPDCEM', varString) = '2') then
  Begin
    FcdsHeranca.Append;
    FcdsHeranca.FieldByName('HER_CHECKD').AsBoolean := True;
    FcdsHeranca.FieldByName('HER_DESCRI').AsString  := 'ITEEMB';
    FcdsHeranca.FieldByName('HER_EMPORI').AsString  := VS_strCodEmp;
    FcdsHeranca.FieldByName('HER_END_IP').Clear;
    FcdsHeranca.Post;
  End;

end;

procedure THerancaEmpresa.pGravaLogRep(AQuery             : TUniQuery;
                                       AstrNomeTabela,
                                       AstrEmpresaOrigem,
                                       AstrEmpresaDestino : String);
begin

  If fTabelaReplica(AstrNomeTabela) Then
    Exit;

  strComandoReplicacao := AQuery.Sql.text;
  pAtualizaComandoReplicacao('DES_CODEMP', QuotedStr(AstrEmpresaDestino));
  pAtualizaComandoReplicacao('ORI_CODEMP', QuotedStr(AstrEmpresaOrigem));
  pAtualizaComandoReplicacao('NFE_ULTALT', 'null');
  fGravaLogRep(AstrNomeTabela);

end;

procedure THerancaEmpresa.pGravarValor_cdsHeranca(strField, strValor: String);
begin

  If strField.IsEmpty Then
    Exit;

  If strValor.IsEmpty Then
    Exit;

  If Not Assigned(FcdsHeranca) Then
    Exit;

  FcdsHeranca.Edit;
  FcdsHeranca.FieldByName(strField).AsString := strValor;
  FcdsHeranca.Post;

end;

procedure THerancaEmpresa.pMontarQueryParaGravarDireitoAcesso(ACodigoNovaEmpresa : String; ATemAcesso : Boolean; ACampoDAQuery : String);
begin
  if ATemAcesso then
  Begin
    if not FblnTemCondicaoAnterior  then
      FQuery.Sql.Text := FQuery.Sql.text + ACampoDAQuery +' = CONCAT('''+ACodigoNovaEmpresa+'_'', '+ACampoDAQuery+') '
    else
      FQuery.Sql.Text := FQuery.Sql.text +' , '+ ACampoDAQuery +' = CONCAT('''+ACodigoNovaEmpresa+'_'', '+ACampoDAQuery+') ';

    FblnTemCondicaoAnterior := True;
  End;
end;

procedure THerancaEmpresa.pProcessarCFGWebService(AstrCodigoEmpresa, AstrCNPJEmpresa: String);
  var
    LQueryEmpresa    : TUniQuery;
    LblnExecutaQuery : Boolean;
begin
  LblnExecutaQuery := fEmptyStr(AstrCNPJEmpresa);
  if not LblnExecutaQuery then
    LblnExecutaQuery := Not fTestaCgc(AstrCNPJEmpresa);

  If LblnExecutaQuery Then
  Begin
    LQueryEmpresa := fCriaQuery(nil);
    Try
      LQueryEmpresa.Sql.Text := ' UPDATE CFGSIS SET SIS_VALCFG = NULL WHERE SIS_CODCFG = :CODCFG AND SIS_CODEMP = :CODEMP ';

      LQueryEmpresa.ParamByName('CODCFG').AsString := 'CFG_CITLIC';
      LQueryEmpresa.ParamByName('CODEMP').AsString := AstrCodigoEmpresa;
      LQueryEmpresa.ExecSQL;

      LQueryEmpresa.ParamByName('CODCFG').AsString := 'CFG_CITUSU';
      LQueryEmpresa.ParamByName('CODEMP').AsString := AstrCodigoEmpresa;
      LQueryEmpresa.ExecSQL;
    Finally
      FreeAndNil(LQueryEmpresa);
    End;
  End;
end;

end.
