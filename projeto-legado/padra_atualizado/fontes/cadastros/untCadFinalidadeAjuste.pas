unit untCadFinalidadeAjuste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxImageComboBox, cxClasses, System.ImageList, Vcl.ImgList, cxImageList,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGridCitel, cxGrid, Datasnap.DBClient, UniClientDataSet,
  cxContainer, dxGDIPlusClasses, cxGroupBox, Uni, untFuncoesGenerica,
  cxProgressBar, untFuncoesSimples, System.StrUtils;

type
  TfrmCadFinalidadeAjuste = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    dtsTabela: TDataSource;
    rdgOperacao: TDBRadioGroup;
    chkObsAdc: TDBCheckBox;
    pagAbas: TPageControl;
    tbsCadastro: TTabSheet;
    tbsDireitosAcesso: TTabSheet;
    lblDescricaoDireitoAcesso: TLabel;
    rdgFiltro: TRadioGroup;
    cxgTemPermissao: TcxGridCitel;
    cxgTemPermissaoView: TcxGridDBTableViewCitel;
    cxgTemPermissaoViewtipo: TcxGridDBColumn;
    cxgTemPermissaoViewcodigo: TcxGridDBColumn;
    cxgTemPermissaoViewdescricao: TcxGridDBColumn;
    cxgTemPermissaoLevel: TcxGridLevel;
    pnlBotoesDireito: TPanel;
    btnVerGrupos: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnRemover: TBitBtnLocked;
    lblRemoverTodos: TLabel;
    imgIcones: TcxImageList;
    Styles: TcxStyleRepository;
    cxsFoco: TcxStyle;
    cxsSemFoco: TcxStyle;
    cdsTemPermissao: TUniClientDataSet;
    cdsTemPermissaotipo: TStringField;
    cdsTemPermissaocodigo: TStringField;
    cdsTemPermissaodescricao: TStringField;
    dtsTemPermissao: TDataSource;
    Panel2: TPanel;
    Label3: TLabel;
    cxGroupBox1: TcxGroupBox;
    Image1: TImage;
    edtPesquisar: TEdit;
    tmrPesquisar: TTimer;
    tmrSomenteSelecionar: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxgTemPermissaoViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxgTemPermissaoViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure lblRemoverTodosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
    procedure edtPesquisarEnter(Sender: TObject);
    procedure edtPesquisarExit(Sender: TObject);
    procedure edtPesquisarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgFiltroClick(Sender: TObject);
  private
    FQryOperadores,
    FQryGrupos: TUniQuery;
    procedure pGravarPermissao(AStrTipo, AStrAutIncFinAju, AStrCod: String);
    procedure pCarregaDireitosAcesso;
    procedure pLimparFiltros;
    procedure pRemoverTodos;
    function  fAplicarDireitosAcesso: Boolean;
    function  fAplicarAlteracoes(pgbProgresso: TCxProgressBar): Boolean;
    procedure pCarregarGruposComPermissao;
    procedure pCarregarOperadoresComPermissao;
    procedure pRemoverPermissao(AStrTipo, AstrAutIncFinAju, AstrCod: String);
    procedure pAdicionarPermissao(ATipo, ACodigo, ADescricao: String);
  public
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
    procedure pInicializaIndices; override;
  end;

var
  frmCadFinalidadeAjuste: TfrmCadFinalidadeAjuste;

implementation

{$R *.dfm}

uses untConsultas, untTypesSistema, untPermissaoAcessoAdicionar;

Const
  INFO_PESQUISA = 'Ctrl+L Pesquisar';

  SQL_DELETE_DIRGPO = 'DELETE FROM DFJGPO WHERE DFJ_CODGPO = "%s" AND DFJ_SEQFAJ = "%s";';
  SQL_DELETE_DIROPE = 'DELETE FROM DFJOPE WHERE DFJ_CODOPE = "%s" AND DFJ_SEQFAJ = "%s";';

procedure TfrmCadFinalidadeAjuste.btnAdicionarClick(Sender: TObject);
Var
  LSelecionado: TfrmPermissaoAcessoAdicionar.Selecionado;
  LSelecionados: TArray<TfrmPermissaoAcessoAdicionar.Selecionado>;
begin
  inherited;
  pLimparFiltros;
  cdsTemPermissao.DisableControls;
  Try
    LSelecionados := TfrmPermissaoAcessoAdicionar.Selecionar(Self.lblDescricaoDireitoAcesso.Caption, cdsTemPermissao, False);
    For LSelecionado In LSelecionados Do
      pAdicionarPermissao(LSelecionado.Tipo, LSelecionado.Codigo, LSelecionado.Descricao);
  Finally
    cdsTemPermissao.EnableControls;
  End;
end;

procedure TfrmCadFinalidadeAjuste.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);

  lblDescricaoDireitoAcesso.Caption := dbeDescri.Text;

  edtPesquisar.Text := INFO_PESQUISA;

  tbsDireitosAcesso.Enabled := True;
  chkObsAdc.Checked := qryTabela.FieldByName('FAJ_OBSADC').AsString = 'S';
  If Not qryTabela.isEmpty Then
    rdgOperacao.Enabled := True;
end;

procedure TfrmCadFinalidadeAjuste.btnCancelaClick(Sender: TObject);
begin
  inherited;
  tbsDireitosAcesso.Enabled := False;
  rdgOperacao.Enabled := False;
end;

procedure TfrmCadFinalidadeAjuste.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadFinalidadeAjuste.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  tbsDireitosAcesso.Enabled := False;
  rdgOperacao.Enabled := False;
end;

procedure TfrmCadFinalidadeAjuste.btnGravarClick(Sender: TObject);
begin
  blnGravou := False;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, '[untCadFinalidadeAjuste.btnGravarClick]');
    End;
  End;

  Try
    If blnGravou Then
    Begin
      If fAplicarDireitosAcesso Then
        fCommit;
    End
    Else
    Begin
      fRollBack;
      pnlInfo.Caption := '';
    End;
  Except
    fRollBack;
    pnlInfo.Caption := '';
  End;

  tbsDireitosAcesso.Enabled := False;
  rdgOperacao.Enabled := False;
end;

procedure TfrmCadFinalidadeAjuste.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  tbsDireitosAcesso.Enabled := True;
  rdgOperacao.ItemIndex := 2;
  chkObsAdc.Checked := False;

  pCarregaDireitosAcesso;

  rdgOperacao.Enabled := True;
end;

procedure TfrmCadFinalidadeAjuste.btnPesquisaClick(Sender: TObject);
  Var
    arrConsulta : TConsultasArray;
    chrKey   : Char;
Begin
  chrKey := '/';
  if fPesqFinalidadeAjuste(Self, Nil, Nil, qryTabela, chrKey, arrConsulta) then
  Begin
    pSetFocus(btnAlterar);
    pCarregaDireitosAcesso;
  End;
end;

procedure TfrmCadFinalidadeAjuste.btnRemoverClick(Sender: TObject);
begin
  inherited;
  If Not cdsTemPermissao.IsEmpty Then
  Begin
    cdsTemPermissao.Delete;
  End;
end;

procedure TfrmCadFinalidadeAjuste.cxgTemPermissaoViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DELETE:
      btnRemover.Click;
    VK_INSERT:
      btnAdicionar.Click;
    VK_UP:
      If cxgTemPermissaoView.DataController.RecNo <= 1 Then
        pSetFocus(edtPesquisar);
  End;

  If (Shift = ([ssCtrl])) And ((Key = Ord('l')) Or (Key = Ord('L'))) Then
  Begin
    pSetFocus(edtPesquisar);
  End;
end;

procedure TfrmCadFinalidadeAjuste.cxgTemPermissaoViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  If ARecord.Index = TcxGridDBTableView(Sender).DataController.FocusedRowIndex Then
    AStyle := cxsFoco
  Else
    AStyle := cxsSemFoco
end;

procedure TfrmCadFinalidadeAjuste.edtPesquisarChange(Sender: TObject);
begin
  inherited;
  tmrPesquisar.Enabled := False;
  tmrPesquisar.Enabled := True;
end;

procedure TfrmCadFinalidadeAjuste.edtPesquisarEnter(Sender: TObject);
begin
  inherited;
  If edtPesquisar.Text = INFO_PESQUISA Then
    edtPesquisar.Clear;
end;

procedure TfrmCadFinalidadeAjuste.edtPesquisarExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtPesquisar.Text) Then
    edtPesquisar.Text := INFO_PESQUISA;
end;

procedure TfrmCadFinalidadeAjuste.edtPesquisarKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DOWN, VK_RETURN:
      Begin
        cxgTemPermissaoView.DataController.GotoFirst;
        pSetFocus(cxgTemPermissao);
      End;
  End;
end;

procedure TfrmCadFinalidadeAjuste.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'FINAJU';
  strNomeCampo      := 'FAJ_CODIGO';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodigo;

  FQryGrupos := fCriaQuery;
  FQryOperadores := fCriaQuery;

end;

procedure TfrmCadFinalidadeAjuste.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);
  FreeAndNil(FQryGrupos);
  FreeAndNil(FQryOperadores);

  inherited;
end;

procedure TfrmCadFinalidadeAjuste.FormShow(Sender: TObject);
begin
  inherited;
  pagAbas.ActivePageIndex := tbsCadastro.PageIndex;
end;

function TfrmCadFinalidadeAjuste.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeDescri) Then
    Begin
      Result := not fEmptyStr(dbeDescri.Text);
      If Not Result Then
        fMensagem('', 'A descrição é obrigatória!', ['&OK']);
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadFinalidadeAjuste.lblRemoverTodosClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pRemoverTodos, 'Removendo todos, Aguarde ...', '');
end;

procedure TfrmCadFinalidadeAjuste.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

end;

procedure TfrmCadFinalidadeAjuste.pCarregaDireitosAcesso;
begin
  cdsTemPermissao.EmptyDataSet;
  pCarregarGruposComPermissao;
  pCarregarOperadoresComPermissao;
end;

procedure TfrmCadFinalidadeAjuste.pAdicionarPermissao(ATipo, ACodigo, ADescricao: String);
begin
  If ATipo.IsEmpty Then
    Exit;

  If cdsTemPermissao.Locate('tipo;codigo', VarArrayOf([ATipo, ACodigo]), []) Then
    Exit;

  cdsTemPermissao.AppendRecord([ATipo, ACodigo, ADescricao]);
end;

procedure TfrmCadFinalidadeAjuste.pLimparFiltros;
begin
  rdgFiltro.ItemIndex := 2;
  edtPesquisar.Clear;
  tmrPesquisar.Enabled := False;
  cdsTemPermissao.Filtered := False;
end;

procedure TfrmCadFinalidadeAjuste.pRemoverTodos;
begin
  cdsTemPermissao.DisableControls;
  Try
    While Not cdsTemPermissao.IsEmpty Do
    Begin
      btnRemover.Click;
      Application.ProcessMessages;
    End;
  Finally
    cdsTemPermissao.EnableControls;
  End;
end;

procedure TfrmCadFinalidadeAjuste.rdgFiltroClick(Sender: TObject);
begin
  inherited;
  cdsTemPermissao.Filter := '';
  Case rdgFiltro.ItemIndex Of
    1: cdsTemPermissao.Filter := 'TIPO = ''GRU''';
    2: cdsTemPermissao.Filter := 'TIPO = ''OPE''';
  End;
  If Not fEmptyStr(cdsTemPermissao.Filter) Then
    cdsTemPermissao.Filtered := True;
end;

function TfrmCadFinalidadeAjuste.fAplicarDireitosAcesso: Boolean;
begin
  TLimparCaches.Execute;
  Result := fChamaTelaGravando(fAplicarAlteracoes, 'Atualizando permissões de acesso, Aguarde ...');
  TLimparCaches.Execute;
end;

function TfrmCadFinalidadeAjuste.fAplicarAlteracoes(pgbProgresso: TCxProgressBar): Boolean;
Var
  LCodigo: String;
begin
  LCodigo := cdsTemPermissaocodigo.AsString;

  FQryOperadores.Close;
  FQryOperadores.Open;

  FQryGrupos.Close;
  FQryGrupos.Open;

  pLimparFiltros;
  cdsTemPermissao.DisableControls;
  Try
    Try
      pgbProgresso.properties.Max := cdsTemPermissao.RecordCount;

      cdsTemPermissao.First;
      While Not cdsTemPermissao.Eof Do
      Begin
        pgbProgresso.Position := cdsTemPermissao.RecNo;

        TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption :=
            lblDescricaoDireitoAcesso.Caption + #13#10 + 'Liberando direitos de acesso ' + IIF(cdsTemPermissaotipo.AsString = 'GRU','Grupo ','Operador ') +
            cdsTemPermissaodescricao.AsString + ' ... ';

        pGravarPermissao(cdsTemPermissaotipo.AsString,
                            qryTabela.FieldByName('AUTOINCREM').AsString,
                            cdsTemPermissaocodigo.AsString);

        Application.ProcessMessages;

        cdsTemPermissao.Next;
      End;

      pgbProgresso.properties.Max := FQryOperadores.RecordCount;

      FQryOperadores.First;
      While Not FQryOperadores.Eof Do
      Begin
        pgbProgresso.Position := FQryOperadores.RecNo;

        If Not cdsTemPermissao.Locate('tipo;codigo',
          VarArrayOf(['OPE', FQryOperadores.FieldByName('OPE_CODOPE').AsString]), []) Then
        Begin
          TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption :=
            lblDescricaoDireitoAcesso.Caption + #13#10 + 'Removendo direitos de acesso Operador ' +
            fRetNomVendRep(FQryOperadores.FieldByName('OPE_CODOPE').AsString) + ' ... ';

          pRemoverPermissao('OPE',
                            qryTabela.FieldByName('AUTOINCREM').AsString,
                            FQryOperadores.FieldByName('OPE_CODOPE').AsString);
        End;

        Application.ProcessMessages;

        FQryOperadores.Next;
      End;

      pgbProgresso.properties.Max := FQryGrupos.RecordCount;

      FQryGrupos.First;
      While Not FQryGrupos.Eof Do
      Begin
        pgbProgresso.Position := FQryGrupos.RecNo;

        If Not cdsTemPermissao.Locate('tipo;codigo',
          VarArrayOf(['GRU', FQryGrupos.FieldByName('GPO_CODGPO').AsString]), []) Then
        Begin
          TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption :=
            lblDescricaoDireitoAcesso.Caption + #13#10 + 'Removendo direitos de acesso Grupo ' +
            fRetNomCadGpo(FQryGrupos.FieldByName('GPO_CODGPO').AsString) + ' ... ';

          pRemoverPermissao('GRU',
                            qryTabela.FieldByName('AUTOINCREM').AsString,
                            FQryGrupos.FieldByName('GPO_CODGPO').AsString);
        End;

        Application.ProcessMessages;

        FQryGrupos.Next;
      End;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmCadFinalidadeAjuste.AplicarAlteracoes');
      End;
    End;
  Finally
    cdsTemPermissao.EnableControls;
    cdsTemPermissao.Locate('codigo', LCodigo, []);
  End;
End;


procedure TfrmCadFinalidadeAjuste.pCarregarGruposComPermissao;
Var
  LCodigo: String;
begin
  FQryGrupos.Close;
  FQryGrupos.SQL.Clear;
  FQryGrupos.SQL.Add(' SELECT * FROM DFJGPO                             ');
  FQryGrupos.SQL.Add(' INNER JOIN CADGPO C ON C.GPO_CODGPO = DFJ_CODGPO ');
  FQryGrupos.SQL.Add(' WHERE DFJ_SEQFAJ = :AUTINC                       ');
  FQryGrupos.ParamByName('AUTINC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
  FQryGrupos.Open;

  FQryGrupos.First;

  While Not FQryGrupos.Eof Do
  Begin
    LCodigo := FQryGrupos.FieldByName('GPO_CODGPO').AsString;
    cdsTemPermissao.AppendRecord(['GRU', LCodigo, fRetNomCadGpo(LCodigo)]);
    FQryGrupos.Next;
  End;

  cdsTemPermissao.First;
end;

procedure TfrmCadFinalidadeAjuste.pCarregarOperadoresComPermissao;
Var
  LCodigo: String;
begin

  FQryOperadores.Close;
  FQryOperadores.SQL.Clear;
  FQryOperadores.SQL.Add(' SELECT * FROM DFJOPE                             ');
  FQryOperadores.SQL.Add(' INNER JOIN CADOPE C ON C.OPE_CODOPE = DFJ_CODOPE ');
  FQryOperadores.SQL.Add(' WHERE DFJ_SEQFAJ = :AUTINC                       ');
  FQryOperadores.ParamByName('AUTINC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
  FQryOperadores.Open;

  FQryOperadores.First;

  While Not FQryOperadores.Eof Do
  Begin
    LCodigo := FQryOperadores.FieldByName('OPE_CODOPE').AsString;
    cdsTemPermissao.AppendRecord(['OPE', LCodigo, fRetNomVendRep(LCodigo)]);
    FQryOperadores.Next;
  End;

  cdsTemPermissao.First;
end;

procedure TfrmCadFinalidadeAjuste.pGravarPermissao(AStrTipo, AStrAutIncFinAju, AStrCod: String);
begin
  Case AnsiIndexStr(AStrTipo, ['OPE','GRU']) Of
    0: fExecutaSQL('REPLACE INTO DFJOPE (DFJ_SEQFAJ, DFJ_CODOPE) VALUES ("'+ AStrAutIncFinAju +'", "' + AStrCod + '");');
    1: fExecutaSQL('REPLACE INTO DFJGPO (DFJ_SEQFAJ, DFJ_CODGPO) VALUES ("'+ AStrAutIncFinAju +'", "' + AStrCod + '");');
  End;
end;

procedure TfrmCadFinalidadeAjuste.pRemoverPermissao(AStrTipo, AstrAutIncFinAju, AstrCod: String);
begin
  Case AnsiIndexStr(AStrTipo, ['OPE','GRU']) Of
    0: fExecutaSQL(Format(SQL_DELETE_DIROPE, [AStrCod, AStrAutIncFinAju]));
    1: fExecutaSQL(Format(SQL_DELETE_DIRGPO, [AStrCod, AStrAutIncFinAju]));
  End;
end;

end.
