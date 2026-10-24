unit untCadAssistenciaTecnica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Datasnap.DBClient, Vcl.DBCtrls, Vcl.Mask,
  DBEditFocus, QColorLabel, EditFocus, Uni, UniClientDataSet, MaskEditFocus, untZClient, frxDBSet;

Type
  {$SCOPEDENUMS ON}
  TTipoContato = (Telefone, Celular, EMail, Site, WhatsApp, Telegram, Instagram);
  {$SCOPEDENUMS OFF}

  TTipoContatoHelper = Record Helper for TTipoContato
    function fAsString: String;
    function fParNomeValor(chrSeparador: Char = '='): String;
    procedure pSetAsString(const Value: String);
  end;

  TComboBoxHelper = Class Helper for TComboBox
    procedure pSetIndexOfName(const strIndexName: String);
    function fGetNameOfItemIndex: String;
  end;

const
  CONTATO_NUM_TELEFONE = [TTipoContato.Telefone,
                          TTipoContato.Celular,
                          TTipoContato.WhatsApp];

  CONTATO_TEXTO = [TTipoContato.EMail,
                   TTipoContato.Site,
                   TTipoContato.Telegram,
                   TTipoContato.Instagram];
type
  TEnderecoRecord = Record
    intId: Integer;
    strAutoincrem: String;
    strIncAtc: String;
    strCep: String;
    strCidade: String;
    strCodCid: String;
    strEstado: String;
    strSituacao: String;
    strBairro: String;
    strEndereco: String;
    procedure Inicializar;
  end;
  TEndereco = TEnderecoRecord;

  TContatoRecord = Record
    intId: Integer;
    strAutoincrem: String;
    strIncAtc: String;
    strTipo: String;
    strDescricao: String;
    strNome: String;
    strIncAen: String;
    procedure Inicializar;
  end;

  TContato = TContatoRecord;

  TfrmCadAssistenciaTecnica = class(TfrmPaiCad)
    tbsEnderecos: TTabSheet;
    tbsContato: TTabSheet;
    pnlFrmContato: TPanel;
    pnlGridContato: TPanel;
    pnlFrmEnderecos: TPanel;
    pnlGridEnderecos: TPanel;
    dbgContato: TDBGridCitel;
    dbgEndereco: TDBGridCitel;
    dtsAssitencias: TDataSource;
    dtsEnderecos: TDataSource;
    dtsContatos: TDataSource;
    dbeCodigo: TDBEditFocus;
    dbeNome: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtEndCep: TMaskEditFocus;
    edtCidade: TEditFocus;
    edtEstado: TEditFocus;
    edtBairro: TEditFocus;
    edtEndereco: TEditFocus;
    lblCep: TLabel;
    lblCidade: TLabel;
    lblEstado: TLabel;
    lblBairro: TLabel;
    lblEndereco: TLabel;
    dbeSituacao: TDBEditFocus;
    lblSituacao: TLabel;
    ColorLabel1: TColorLabel;
    lblNome: TLabel;
    lblDescricao: TLabel;
    lblTipoContato: TLabel;
    edtCttPessoa: TEditFocus;
    btnAddEnd: TBitBtnLocked;
    btnCanEnd: TBitBtnLocked;
    cboCttTipo: TComboBox;
    btnAddCtt: TBitBtnLocked;
    btnCanCtt: TBitBtnLocked;
    mmoCttDescricao: TMemo;
    edtEndSit: TEditFocus;
    Label4: TLabel;
    ColorLabel2: TColorLabel;
    medCttDes: TMaskEditFocus;
    edtCodCid: TEditFocus;
    cboUnidade: TComboBox;
    lblAssistencia: TLabel;
    btnExcluirContato: TBitBtnLocked;
    frxReport1: TfrxReport;
    frxCadATC: TfrxDBDataset;
    btnVisualizar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAddEndClick(Sender: TObject);
    procedure btnCanEndClick(Sender: TObject);
    procedure dbgEnderecoDblClick(Sender: TObject);
    procedure dtsAssitenciasStateChange(Sender: TObject);
    procedure dtsAssitenciasDataChange(Sender: TObject; Field: TField);
    procedure cboCttTipoChange(Sender: TObject);
    procedure dbgContatoDblClick(Sender: TObject);
    procedure btnAddCttClick(Sender: TObject);
    procedure btnCanCttClick(Sender: TObject);
    procedure dbgEnderecoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgContatoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure edtEndCepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirContatoClick(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
  private
    blnUsaCep: boolean;
    QryCADATC: TUniQuery;  //Assistência técnica
    qryConCid: TUniQuery;
    FcdsEnderecos: TUniClientDataSet;  //Endereços
    FcdsContatos: TUniClientDataSet;  //Contatos
    FrecEndereco: TEndereco;
    FRecContato: TContato;
    FGravando: Boolean;
    procedure pAplicarFiltroRegistrosNaoExcluidos(DataSet: TDataSet);
    procedure pAplicarFiltroDataSet(const strFiltro: String; DataSet: TDataSet);
    procedure pAplicarFiltroRegistrosExcluidos(DataSet: TDataSet);


    function fGetSQLCadAEN: String;
    procedure pConectarDataSources;
    procedure pCriarTabelas;
    procedure pCriarQryCadATC;
    procedure pCriarcdsEnderecos;
    procedure pCriarcdsContatos;
    procedure pCarregarContatos(const strIncATC: String);
    procedure pCarregarEnderecos(const strIncATC: String);
    procedure pCarregaCidade(QryConsulta: TUniquery; strCodCid: String; Out strCidade, strEstado, strCep: String);
    procedure pCarrecarDadosComplementares(const strIncATC: String);
    procedure pConfigurarTelaContato(const enuTipoContato: TTipoContato);
    procedure pConfigurarGridContato;
    procedure pFcdsContatosACT_TIPO__OnGetText (Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pFcdsEnderecoID_OnGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    function fGravarEnderecos(const strIncAtc: String): Boolean;
    function fGravarContatos(const strIncATC: String): Boolean;
    function fObterId(objDataSet: TDataSet): Integer;
    procedure pPesquisarCidade(Var Key: Char);
    procedure pQryCADATCOnAfterScroll(DataSet: TDataSet);
    procedure pQryCADATCOnAfterOpen(DataSet: TDataSet);
    procedure pQryCADATCOnNewRecord(DataSet: TDataSet);

    function fObterEnderecoDigitado: TEndereco;
    procedure pExibirEndereco;
    procedure pInserirEndereco;
    procedure pEditarEndereco;
    function fObterEndereco: TEndereco;
    procedure pExibirContato;
    procedure pInserirContato;
    procedure pEditarContato;
    procedure pExcluirEndereco;
    procedure pLimparContatos;
    procedure pDesvincularContatoEndereco(strAutInc: String);
    procedure pExcluirContato;
    function fObterContatoDigitado: TContato;

    procedure pPrepararCboTipoContato;
    procedure pInicializar(blnCompleto: Boolean = True);
    procedure pCarregarCFGs;
    function fGetUnidades(blnReiniciar: Boolean = False): TStrings;
    function fGetIndexUnidade(const strAutInc: String): Integer;
    function fGetAutoincremEnderecoDeID(const intIndex: Integer): String;
    procedure pAddUnidade(recEndereco: TEndereco);
    function fGetSqlFichaAssistenciaTecnica: String;
    procedure pImprimir(const strCodAtc: String);
  private
    function fValidarEndereco(Sender: TWinControl; blnSomenteValidar: Boolean = False): Boolean;
  protected
    procedure pInicializaIndices; override;
    function fNomeCadastrado(strNomAssistencia: String; strCodAtc: String = ''): Boolean;

    { Private declarations }
  public
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    class function fGetSqlListaAssistencias: String;
    class function fObterListaAssistencias: TUniClientDataSet;
    class procedure pImprimirFichaAssistenciaTecnica(const strCodAtc: String);
    { Public declarations }
  end;

var
  frmCadAssistenciaTecnica: TfrmCadAssistenciaTecnica;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema, untCadCid, TypInfo, untPesqAux, System.StrUtils;

{$R *.dfm}

{ TfrmCadAssistenciaTecnica }

procedure TfrmCadAssistenciaTecnica.btnAddCttClick(Sender: TObject);
begin
  inherited;
  FRecContato := fObterContatoDigitado;

  if Not fEmptyStr(FRecContato.strDescricao) then
    pInserirContato;

  FRecContato.Inicializar;
  pExibirContato;
  pLimparContatos;
end;

procedure TfrmCadAssistenciaTecnica.btnAddEndClick(Sender: TObject);
  Var
    blnAbortar: Boolean;

begin
  FrecEndereco := fObterEnderecoDigitado;

  inherited;
  blnAbortar := True;
  if fValidarEndereco(edtEndCep, True) then
    if fValidarEndereco(edtCodCid, True) then
      if fValidarEndereco(edtEndSit, True) then
        blnAbortar := False;

  if blnAbortar then
    Exit;


  pInserirEndereco;
  FrecEndereco.Inicializar;
  pExibirEndereco;
end;

procedure TfrmCadAssistenciaTecnica.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeNome, False);
end;

procedure TfrmCadAssistenciaTecnica.btnCanEndClick(Sender: TObject);
begin
  inherited;
  FrecEndereco.Inicializar;
  pExibirEndereco;
end;

procedure TfrmCadAssistenciaTecnica.btnCancelaClick(Sender: TObject);
begin
  inherited;
  if FcdsEnderecos.Active then
    FcdsEnderecos.EmptyDataSet;

  if FcdsContatos.Active then
    FcdsContatos.EmptyDataSet;

  pCarrecarDadosComplementares(QryCADATC.FieldByName('AUTOINCREM').AsString);
end;

procedure TfrmCadAssistenciaTecnica.btnCanCttClick(Sender: TObject);
begin
  inherited;
  FRecContato.Inicializar;
  pExibirContato;
  pLimparContatos;
end;

procedure TfrmCadAssistenciaTecnica.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadAssistenciaTecnica.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAssistenciaTecnica.btnExcluirContatoClick(Sender: TObject);
begin
  inherited;
  pExcluirContato;
  FRecContato.Inicializar;
  pExibirContato;
  pLimparContatos;
end;

procedure TfrmCadAssistenciaTecnica.btnGravarClick(Sender: TObject);
  Var
    strAutInc: String;
begin
  FGravando := True;
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
    strAutInc := QryCADATC.FieldByName('AUTOINCREM').AsString;
    blnGravou := blnGravou and fGravarEnderecos(strAutInc);
    blnGravou := blnGravou and fGravarContatos(strAutInc);
    FGravando := False;
  Except
    On E: Exception Do
    Begin
      FGravando := False;
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadAssistenciaTecnica.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAssistenciaTecnica.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeNome, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmCadAssistenciaTecnica.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAssistencias: TConsultasArray;
    strCodigo, strNomAss, strSituac: String;
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE PREÇOS *}
  {*********************************RV*}
  chrKey := '/';

  IF fPesqAssistenciaTecnica(Self, strCodigo, strNomAss, strSituac, qryTabela, chrKey, arrAssistencias) Then
    pSetFocus(btnAlterar)
end;

procedure TfrmCadAssistenciaTecnica.btnVisualizarClick(Sender: TObject);
begin
  inherited;
  pImprimir(qryTabela.FieldByName('ATC_CODIGO').AsString);
end;

procedure TfrmCadAssistenciaTecnica.cboCttTipoChange(Sender: TObject);
  Var
    enuTipoContato: TTipoContato;


begin
  inherited;
  enuTipoContato.pSetAsString(cboCttTipo.fGetNameOfItemIndex);
  pConfigurarTelaContato(enuTipoContato);
end;

procedure TfrmCadAssistenciaTecnica.pConectarDataSources;
begin
  dtsEnderecos.DataSet := FcdsEnderecos;
  dtsEnderecos.AutoEdit := False;
  dtsContatos.DataSet := FcdsContatos;
  dtsContatos.AutoEdit := False;
  dtsAssitencias.DataSet := QryCADATC;
end;

procedure TfrmCadAssistenciaTecnica.pConfigurarGridContato;
  Var
    intIndex:  Integer;
    objColumn: TColumn;
begin
  for intIndex := 0 to dbgContato.Columns.Count -1 do
  begin
    objColumn := dbgContato.Columns[intIndex];
    if objColumn.FieldName = 'ACT_TIPO__' then
      dbgContato.Columns[intIndex].Width := 64
    else if objColumn.FieldName = 'ACT_PESSOA' then
      dbgContato.Columns[intIndex].Width := 64
    else if objColumn.FieldName = 'ACT_DESCRI' then
      dbgContato.Columns[intIndex].Width := 190;
  end;
end;

procedure TfrmCadAssistenciaTecnica.pConfigurarTelaContato(
  const enuTipoContato: TTipoContato);
  Var
    intTopBtn: Integer;
    objAtivo: TControl;
begin
  if enuTipoContato in CONTATO_NUM_TELEFONE then
  begin
    medCttDes.Visible := True;
    mmoCttDescricao.Visible := False;
    objAtivo := medCttDes;
  end
  else if enuTipoContato in CONTATO_TEXTO then
  begin
    medCttDes.Visible := False;
    mmoCttDescricao.Visible := True;
    objAtivo := mmoCttDescricao;
  end
  else begin
    medCttDes.Visible := True;
    mmoCttDescricao.Visible := False;
    objAtivo := medCttDes;
  end;
  intTopBtn := objAtivo.Top + objAtivo.Height + 3;
  btnAddCtt.Top := intTopBtn;
  btnCanCtt.Top := intTopBtn;
  btnExcluirContato.Top := intTopBtn;
end;

procedure TfrmCadAssistenciaTecnica.dbgContatoDblClick(Sender: TObject);
begin
  inherited;
  if Not btnAddCtt.Enabled then
    Exit;

  if FcdsContatos.IsEmpty then
    Exit;
  pEditarContato;
end;

procedure TfrmCadAssistenciaTecnica.dbgContatoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if ((Key = VK_DELETE) and (ssCtrl in Shift)) then
  begin
    pExibirContato;
  end;
end;

procedure TfrmCadAssistenciaTecnica.dbgEnderecoDblClick(Sender: TObject);
begin
  inherited;
  if not FcdsEnderecos.IsEmpty then
    pEditarEndereco;
end;

procedure TfrmCadAssistenciaTecnica.dbgEnderecoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if ((Key = VK_DELETE) and (ssCtrl in Shift)) then
  begin
    pExcluirEndereco;
  end;
end;

procedure TfrmCadAssistenciaTecnica.dtsAssitenciasDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  pInicializar(False);
end;

procedure TfrmCadAssistenciaTecnica.dtsAssitenciasStateChange(Sender: TObject);
  Var
    blnHabilitar: Boolean;
begin
  inherited;
  blnHabilitar := dtsAssitencias.State in[dsEdit, dsInsert];
  pInicializar(False);
  cboCttTipo.Enabled := blnHabilitar;
  cboUnidade.Enabled := blnHabilitar;
  mmoCttDescricao.Enabled := blnHabilitar;
  btnAddEnd.Enabled := blnHabilitar;
  btnCanEnd.Enabled := blnHabilitar;
  btnAddCtt.Enabled := blnHabilitar;
  btnCanCtt.Enabled := blnHabilitar;
  btnExcluirContato.Enabled := blnHabilitar;
end;

procedure TfrmCadAssistenciaTecnica.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pPesquisarCidade(Key);
end;

procedure TfrmCadAssistenciaTecnica.edtEndCepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) And blnUsaCep Then
  Begin
    Key := #0;
    FrecEndereco.strCep := EmptyStr;
    edtEndCep.Text := fConsultarCep(Self, edtEndCep.Text, edtEndCep );
    frecEndereco.strCep := edtEndCep.text;

    if Not fEmptyStr(edtEndCep.Text) then
      fValidaCampos(edtEndCep);
  End;
end;

procedure TfrmCadAssistenciaTecnica.pEditarContato;
begin
  FRecContato.Inicializar;
  FRecContato.intId := FcdsContatos.FieldByName('ID').AsInteger;
  FRecContato.strAutoincrem := FcdsContatos.FieldByName('AUTOINCREM').AsString;
  FRecContato.strIncAtc := FcdsContatos.FieldByName('ACT_INCATC').AsString;
  FRecContato.strTipo := FcdsContatos.FieldByName('ACT_TIPO__').AsString;
  FRecContato.strDescricao  := FcdsContatos.FieldByName('ACT_DESCRI').AsString;
  FRecContato.strNome := FcdsContatos.FieldByName('ACT_PESSOA').AsString;
  FrecContato.strIncAen := FcdsContatos.FieldByName('ACT_INCAEN').AsString;
  pExibirContato;
end;

procedure TfrmCadAssistenciaTecnica.pEditarEndereco;
begin
  FrecEndereco := fObterEndereco;
  pExibirEndereco;
end;

procedure TfrmCadAssistenciaTecnica.pExcluirContato;
begin
  if FcdsContatos.IsEmpty then
    Exit;
  if FcdsContatos.FieldByName('ID').AsString = FcdsContatos.FieldByName('AUTOINCREM').AsString then
    FcdsContatos.Delete
  else begin
    FcdsContatos.Edit;
    FcdsContatos.FieldByName('ID').AsInteger := FcdsContatos.FieldByName('ID').AsInteger * -1;
    FcdsContatos.Post;
  end;
end;

procedure TfrmCadAssistenciaTecnica.pExcluirEndereco;
  Var
   recEnd: TEndereco;
begin
  recEnd := fObterEndereco;
  if FcdsEnderecos.IsEmpty then
    Exit;
  if FcdsEnderecos.FieldByName('ID').AsString = FcdsEnderecos.FieldByName('AUTOINCREM').AsString then
    FcdsEnderecos.Delete
  else begin
    FcdsEnderecos.Edit;
    FcdsEnderecos.FieldByName('ID').AsInteger := FcdsEnderecos.FieldByName('ID').AsInteger * -1;
    FcdsEnderecos.Post;
  end;
  cboUnidade.Items.Delete(cboUnidade.Items.IndexOfName(FormatFloat('000',recEnd.intId)));
  pDesvincularContatoEndereco(recEnd.strAutoincrem);
end;

procedure TfrmCadAssistenciaTecnica.pExibirContato;
  Var
    intIndexUnidade: Integer;
begin
  mmoCttDescricao.Clear;
  medCttDes.Clear;
  cboCttTipo.pSetIndexOfName(FRecContato.strTipo);
  cboCttTipoChange(cboCttTipo);
  edtCttPessoa.Text := FRecContato.strNome;

  if medCttDes.Visible then
    medCttDes.Text := FRecContato.strDescricao
  else if mmoCttDescricao.Visible then
    mmoCttDescricao.Text := FRecContato.strDescricao;

  if fEmptyStr(FRecContato.strIncAen) then
    cboUnidade.ItemIndex := -1
  else
  begin
    intIndexUnidade := fGetIndexUnidade(FRecContato.strIncAen);
    cboUnidade.ItemIndex := intIndexUnidade;
  end;
end;

procedure TfrmCadAssistenciaTecnica.pExibirEndereco;
begin
  edtCodCid.text := FrecEndereco.strCodCid;
  edtEndCep.Text := FrecEndereco.strCep;
  edtCidade.Text := FrecEndereco.strCidade;
  edtEstado.Text := FrecEndereco.strEstado;
  edtBairro.Text := FrecEndereco.strBairro;
  edtEndSit.Text := FrecEndereco.strSituacao;
  edtEndereco.Text := FrecEndereco.strEndereco;
end;

procedure TfrmCadAssistenciaTecnica.pFcdsContatosACT_TIPO__OnGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
  Var
    enuTipoContato: TTipoContato;
begin
  enuTipoContato.pSetAsString(Sender.AsString);
  Text := enuTipoContato.fAsString;
end;

procedure TfrmCadAssistenciaTecnica.pFcdsEnderecoID_OnGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if Sender.AsInteger > 0 then
    Text := FormatFloat('000', Sender.AsInteger)
  else
    Text :=EmptyStr;
end;

procedure TfrmCadAssistenciaTecnica.FormCreate(Sender: TObject);
begin
  inherited;
  FGravando := false;
  pCarregarCFGs;
  pCriarTabelas;
  pConectarDataSources;
  pPrepararCboTipoContato;
  pConfigurarGridContato;
  cboUnidade.Items.NameValueSeparator := '=';
end;

procedure TfrmCadAssistenciaTecnica.FormDestroy(Sender: TObject);
begin
  if Assigned(QryCADATC) then
    FreeAndNil(QryCADATC);

  if Assigned(QryConCid) then
    FreeAndNil(qryConCid);

  if Assigned(FcdsEnderecos) then
    FreeAndNil(FcdsEnderecos);

  if Assigned(FcdsContatos) then
    FreeAndNil(FcdsContatos);

  inherited;
end;

procedure TfrmCadAssistenciaTecnica.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
  pgcDados.ActivePage := tbsGeral;
end;

function TfrmCadAssistenciaTecnica.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  begin
    if (Sender = dbeSituacao) then
    begin
      if fEmptyStr(dbeSituacao.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A situação deve ser preenchida!', ['&Ok']);
        Result := False;
      end
      else if indexStr(dbeSituacao.Text,['A','I']) = -1 then
      begin
        fMensagem('ATENÇÃO!', 'A situação inválida!', ['&Ok']);
        Result := False;
      end;
    end
    else if (Sender = dbeNome) then
    begin
      if fEmptyStr(TDBEdit(Sender).Text) then
      begin
        fMensagem('ATENÇÃO!', 'O nome da assistência é obrigatório!', ['&Ok']);
        Result := False;
      end
      else if fNomeCadastrado(TDBEdit(Sender).Text, qryTabela.FieldByName('ATC_CODIGO').AsString) Then
      begin
        fMensagem('ATENÇÃO!', 'O nome da assistência já cadastrado!', ['&Ok']);
        Result := False;
      end;
    end
    else if (Not FGravando) and (Pos(LowerCase(Sender.Name),LowerCase('_edtEndCep_edtCodCid_edtEndSit_')) > 0) Then
    begin
      Result := fValidarEndereco(Sender);
    end;
  end;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadAssistenciaTecnica.fValidarEndereco(Sender: TWinControl; blnSomenteValidar: Boolean = False): Boolean;
  Var
    strAux: String;
begin
  Result := True;
  if (Sender = edtCodCid) then
  begin
    If Not fEmptyStr(edtCodCid.Text) Then
    Begin
      if Not  blnSomenteValidar then
      begin
        pCarregaCidade(qryConCid,
                       FrecEndereco.strCodCid,
                       FrecEndereco.strCidade,
                       FrecEndereco.strEstado,
                       FrecEndereco.strCep);
        Result := Not qryConCid.FieldByName('CID_CODCID').IsNull;
      end;

      If Not Result Then
        fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
    End
  end
  else if (Sender = edtEndCep) then
  begin
    If (Not fEmptyStr(fTiraCaracEspeciais(edtEndCep.Text))) Then
    Begin
      If Length(Trim(fTiraCaracEspeciais(edtEndCep.Text))) < 8 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Cep deve ser vazio ou com 8 digitos.', ['&Ok']);
        Result := False;
      End;
    End;

    if Result and (Not blnSomenteValidar) then
    begin
      if blnUsaCep then
      begin
        FrecEndereco.strCep := edtEndCep.Text;
        if fCadCepDadosCep(edtEndCep.Text, FrecEndereco.strCodCid,
                           FrecEndereco.strEndereco, FRecendereco.strBairro,
                           FrecEndereco.strCidade, FrecEndereco.strEstado, strAux) then
        begin
          pCarregaCidade(qryConCid,
                         FrecEndereco.strCodCid,
                         FrecEndereco.strCidade,
                         FrecEndereco.strEstado,
                         strAux);
          pExibirEndereco;
        end
        else
          Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;

      end;

        IF Not fEmptyStr(FrecEndereco.strCodCid) then
        begin
          pSetFocus(edtEndSit);
        End;

    end;
  end
  else if (Sender = edtEndSit) then
  begin
    if fEmptyStr(edtEndSit.Text) then
    begin
      fMensagem('ATENÇÃO!', 'A situação deve ser preenchida!', ['&Ok']);
      Result := False;
    end
    else if indexStr(edtEndSit.Text,['A','I']) = -1 then
    begin
      fMensagem('ATENÇÃO!', 'A situação inválida!', ['&Ok']);
      Result := False;
    end;
  end;

end;



function TfrmCadAssistenciaTecnica.fGetAutoincremEnderecoDeID(const intIndex: Integer): String;
begin
  Result := VarToStrDef(FcdsEnderecos.Lookup('ID', intIndex, 'AUTOINCREM'),'');
end;

function TfrmCadAssistenciaTecnica.fGetIndexUnidade(const strAutInc: String): Integer;
  Var
    intId: Integer;
    stlUnid: TStrings;
begin
  intId := StrToInt(VarToStrDef(FcdsEnderecos.Lookup('AUTOINCREM',strAutInc,'ID'),'-1'));

  if intId = -1 then
    Exit(intId);

  stlUnid := fGetUnidades;
  Result := stlUnid.IndexOfName(FormatFloat('000', intId));
end;

function TfrmCadAssistenciaTecnica.fGetSQLCadAEN: String;

begin
  Result := EmptyStr;
  Result := Result + ' SELECT A.*, B.CID_NOMCID, B.CID_ESTADO ';
  Result := Result + ' FROM CADAEN A ';
  Result := Result + ' INNER JOIN CADCID B on B.CID_CODCID = A.AEN_ENDCID ';
  Result := Result + ' WHERE AEN_INCATC = :INCATC; ';
end;


function TfrmCadAssistenciaTecnica.fGetSqlFichaAssistenciaTecnica: String;
begin
  Result :=          ' SELECT A.AUTOINCREM, ATC_CODIGO, ATC_SITUAC, ATC_CODEMP, ATC_NOMEMP, ';
  Result := Result + '         E2.GRUPO, E2.INCEND, E2.AEN_SITUAC, E2.AEN_ENDCID, E2.AEN_ENDCEP, E2.AEN_ENDBAI, ';
  Result := Result + '         E2.AEN_ENDEND, E2.CID_NOMCID, E2.CID_ESTADO, ';
  Result := Result + '         CASE E2.ACT_TIPO__ ';
  Result := Result + '           WHEN "0" THEN "Telefone" ';
  Result := Result + '           WHEN "1" THEN "Celular" ';
  Result := Result + '           WHEN "2" THEN "Email" ';
  Result := Result + '           WHEN "3" THEN "Site" ';
  Result := Result + '           WHEN "4" THEN "WhatsApp" ';
  Result := Result + '           WHEN "5" THEN "Telegram" ';
  Result := Result + '           WHEN "6" THEN "Instagram" ';
  Result := Result + '         END "ACT_TIPO__", ';
  Result := Result + '         E2.ACT_DESCRI, E2.ACT_PESSOA ';

  Result := Result + ' FROM CADATC A ';

  Result := Result + ' LEFT JOIN (SELECT E.AEN_INCATC AS "INCATC", ';
  Result := Result + '              "2" AS GRUPO, E.AUTOINCREM AS "INCEND", E.AEN_SITUAC, E.AEN_ENDCID, E.AEN_ENDCEP, ';
  Result := Result + '              E.AEN_ENDBAI, E.AEN_ENDEND, C.CID_NOMCID, C.CID_ESTADO, ';
  Result := Result + '              T.AUTOINCREM AS "INCACT", T.ACT_TIPO__, T.ACT_DESCRI,  T.ACT_PESSOA ';
  Result := Result + '       FROM CADAEN E ';
  Result := Result + '       join CADCID C ON C.CID_CODCID = E.AEN_ENDCID ';
  Result := Result + '       LEFT JOIN CADACT T ON T.ACT_INCAEN = E.AUTOINCREM AND T.ACT_INCATC = E.AEN_INCATC ';

  Result := Result + '       UNION ';

  Result := Result + '       SELECT T.ACT_INCATC AS "INCATC", ';
  Result := Result + '              "1" AS GRUPO, E.AUTOINCREM AS "INCEND", E.AEN_SITUAC, E.AEN_ENDCID, E.AEN_ENDCEP, ';
  Result := Result + '              E.AEN_ENDBAI, E.AEN_ENDEND, C.CID_NOMCID, C.CID_ESTADO, ';
  Result := Result + '              T.AUTOINCREM AS "INCACT", T.ACT_TIPO__, T.ACT_DESCRI,  T.ACT_PESSOA ';
  Result := Result + '       FROM CADACT T ';
  Result := Result + '       LEFT JOIN CADAEN E ON E.AUTOINCREM = T.ACT_INCAEN  AND FALSE ';
  Result := Result + '       LEFT JOIN CADCID C ON C.CID_CODCID = E.AEN_ENDCID AND FALSE ';
  Result := Result + '       WHERE NOT EXISTS (SELECT 1 FROM CADAEN WHERE AUTOINCREM = T.ACT_INCAEN)) E2 ';

  Result := Result + ' ON E2.INCATC = A.AUTOINCREM ';

  Result := Result + ' WHERE ATC_CODIGO = :CODATC ';
  Result := Result + ' ORDER BY E2.GRUPO, E2.CID_ESTADO, E2.CID_NOMCID, E2.INCEND, E2.ACT_TIPO__   ';
end;

class function TfrmCadAssistenciaTecnica.fGetSqlListaAssistencias: String;
begin
  Result := ' SELECT ATC_CODIGO, ATC_NOMEMP, ATC_SITUAC, IF(ATC_SITUAC = "A","Ativo","Inativo") AS "SITUACAO"  ';
  Result := Result + ' FROM CADATC ';
  Result := Result + ' ORDER BY ATC_SITUAC, ATC_CODIGO ';
end;

function TfrmCadAssistenciaTecnica.fGetUnidades(blnReiniciar: Boolean): TStrings;
begin
  if blnReiniciar then
    cboUnidade.Items.Clear;

  cboUnidade.Items.Delimiter := '=';
  Result := cboUnidade.Items;
end;

function TfrmCadAssistenciaTecnica.fGravarContatos(
  const strIncATC: String): Boolean;
  CONST
    SQL_CADAEN: String = 'SELECT * FROM CADACT WHERE ACT_INCATC = :INCATC  ';
  Var
    Qry: TUniQuery;
begin
  Result := True;
  Qry := Nil;
  Try
    Try
      Qry := fCriaQuery;
      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add(SQL_CADAEN);
      Qry.ParamByName('INCATC').AsString := strIncATC;
      Qry.Open;
      {$Region 'Excluindo registros'}
      Qry.First;
      pAplicarFiltroRegistrosExcluidos(FcdsContatos);
      FcdsContatos.First;
      While Not FcdsContatos.Eof do
      begin
        if Qry.Locate('AUTOINCREM',
                      VarArrayOf([FcdsContatos.FieldByName('AUTOINCREM').AsString]),
                      []) Then
          Qry.Delete;
        FcdsContatos.Next;
      end;
      {$Endregion}
      pAplicarFiltroRegistrosNaoExcluidos(FcdsContatos);
      FcdsContatos.First;
      While Not FcdsContatos.Eof do
      begin
        if qry.Locate('AUTOINCREM', FcdsContatos.FieldByName('AUTOINCREM').AsString, []) Then
        begin
          Qry.Edit;
        end
        else
        begin
          Qry.Append;
          Qry.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADACT', VS_strCodEmp);
          Qry.FieldByName('ACT_INCATC').AsString := strIncATC;
        end;
        if FEmptyStr(FcdsContatos.FieldByName('ACT_INCAEN').AsString) then
          Qry.FieldByName('ACT_INCAEN').Value := Null
        else
          Qry.FieldByName('ACT_INCAEN').AsString := FcdsContatos.FieldByName('ACT_INCAEN').AsString;

        Qry.FieldByName('ACT_TIPO__').AsString := FcdsContatos.FieldByName('ACT_TIPO__').AsString;
        Qry.FieldByName('ACT_DESCRI').AsString := FcdsContatos.FieldByName('ACT_DESCRI').AsString;
        Qry.FieldByName('ACT_PESSOA').AsString := FcdsContatos.FieldByName('ACT_PESSOA').AsString;
        Qry.Post;
        FcdsContatos.Next;
      end;
    Except
      On E: Exception do
      begin
        Result := False;
        pMensagensErro(e.Message,'TfrmCadAssistenciaTecnica.fGravarContatos');
      end;
    End;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;

end;

function TfrmCadAssistenciaTecnica.fGravarEnderecos(const strIncAtc: String): Boolean;
  CONST
    SQL_CADAEN: String = 'SELECT * FROM CADAEN WHERE AEN_INCATC = :INCATC  ';
    FILTRO_CONTATOS: String = ' ACT_INCAEN = %s AND ID > 0 ';
  Var
    Qry: TUniQuery;
    strAutInc: String;
    blnAtualizarContatos: Boolean;
    strFiltroContatos: String;

begin
  Result := True;
  Qry := Nil;
  Try
    FcdsEnderecos.DisableControls;
    Try
      Qry := fCriaQuery;
      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add(SQL_CADAEN);
      Qry.ParamByName('INCATC').AsString := strIncATC;
      Qry.Open;
      Qry.First;
      {$Region 'Excluindo registros'}
      pAplicarFiltroRegistrosExcluidos(FcdsEnderecos);
      if Not fcdsEnderecos.IsEmpty then
      begin
        FcdsEnderecos.First;
        While Not FcdsEnderecos.Eof do
        begin
          if Qry.Locate('AUTOINCREM',
                         VarArrayOf([FcdsEnderecos.FieldByName('AUTOINCREM').AsString]),
                        []) Then
             Qry.Delete;
          FcdsEnderecos.Next;
        end;
      end;
      {$Endregion}
      pAplicarFiltroRegistrosNaoExcluidos(FcdsEnderecos);
      FcdsEnderecos.First;
      While Not FcdsEnderecos.Eof do
      begin
        blnAtualizarContatos := False;
        if qry.Locate('AUTOINCREM', FcdsEnderecos.FieldByName('AUTOINCREM').AsString, []) Then
        begin
          Qry.Edit;
        end
        else
        begin
          Qry.Append;
          strAutInc := fRetAutoIncrem('CADAEN', VS_strCodEmp);
          Qry.FieldByName('AUTOINCREM').AsString := strAutInc;
          Qry.FieldByName('AEN_INCATC').AsString := strIncAtc;
          blnAtualizarContatos := True;
        end;

        Qry.FieldByName('AEN_SITUAC').AsString := FcdsEnderecos.FieldByName('AEN_SITUAC').AsString;
        Qry.FieldByName('AEN_ENDCEP').AsString := FcdsEnderecos.FieldByName('AEN_ENDCEP').AsString;
        Qry.FieldByName('AEN_ENDCID').AsString := FcdsEnderecos.FieldByName('AEN_ENDCID').AsString;
        Qry.FieldByName('AEN_ENDBAI').AsString := FcdsEnderecos.FieldByName('AEN_ENDBAI').AsString;
        Qry.FieldByName('AEN_ENDEND').AsString := FcdsEnderecos.FieldByName('AEN_ENDEND').AsString;
        Qry.Post;

        if blnAtualizarContatos then
        begin
          strFiltroContatos :=Format(FILTRO_CONTATOS,[QuotedStr(FcdsEnderecos.FieldByName('ID').AsString)]);
          Try
            FcdsContatos.DisableControls;
            pAplicarFiltroDataSet(strFiltroContatos, FcdsContatos);
            if Not FcdsContatos.IsEmpty then
            begin
              FcdsContatos.First;
              While Not fcdsContatos.Eof do
              begin
                FcdsContatos.Edit;
                fcdsContatos.FieldByName('ACT_INCAEN').AsString := strAutInc;
                FcdsContatos.Post;
                FcdsContatos.Next;
              end;
            end;
          Finally
            pAplicarFiltroRegistrosNaoExcluidos(FcdsContatos);
            FcdsContatos.EnableControls;
          End;
        end;
        FcdsEnderecos.Next;
      end;
    Except
      On E: Exception do
      begin
        Result := False;
        pMensagensErro(e.Message,'TfrmCadAssistenciaTecnica.fGravarEnderecos');
      end;
    End;
  Finally
    pAplicarFiltroRegistrosNaoExcluidos(FcdsEnderecos);
    if Assigned(Qry) then
      FreeAndNil(Qry);
    FcdsEnderecos.EnableControls;
  End;

end;

function TfrmCadAssistenciaTecnica.fNomeCadastrado(strNomAssistencia: String; strCodAtc: String): Boolean;
  CONST
    SQL_CADACT: String = 'SELECT COUNT(1) AS "TOTAL" FROM CADATC WHERE ATC_NOMEMP = :NOMEMP ';
  Var
    Qry: TUniQuery;
    blnCodigo: boolean;
    strSQL: String;
begin
  blnCodigo := Not fEmptyStr(strCodAtc);
  Qry := Nil;
  strSQL := SQL_CADACT;

  if blnCodigo then
    strSQL := strSQL + ' and ATC_CODIGO <> :CODIGO ';
  Result := False;
  Try
    Try
      Qry := fCriaQuery;
      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add(strSQL);
      Qry.ParamByName('NOMEMP').AsString := strNomAssistencia;

      if blnCodigo then
        Qry.ParamByName('CODIGO').AsString := strCodAtc;

      Qry.Open;
      if Qry.IsEmpty then
        Exit;
      Result := Qry.FieldByName('TOTAL').AsInteger  > 0;
      Qry.Close;
    Except
      On E: Exception do
      begin
        pMensagensErro(e.Message,'TfrmCadAssistenciaTecnica.fNomeCadastrado');
      end;
    End;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

function TfrmCadAssistenciaTecnica.fObterContatoDigitado: TContato;
  Var
    strChave: String;
begin
  Result := FRecContato;
  Result.strTipo := cboCttTipo.fGetNameOfItemIndex;
  Result.strNome := edtCttPessoa.Text;

  if medCttDes.Visible then
    Result.strDescricao := medCttDes.Text
  else
    Result.strDescricao := mmoCttDescricao.Text;

  if cboUnidade.ItemIndex >= 0 then
  begin
    strChave := cboUnidade.Items.Names[cboUnidade.ItemIndex];
    Result.strIncAen := fGetAutoincremEnderecoDeID(StrToIntDef(strChave,-1));
  end
  else
    Result.strIncAen := EmptyStr;
end;

function TfrmCadAssistenciaTecnica.fObterEndereco: TEndereco;
begin
  Result.Inicializar;
  Result.intId := FcdsEnderecos.FieldByName('ID').AsInteger;
  Result.strAutoincrem := FcdsEnderecos.FieldByName('AUTOINCREM').AsString;
  Result.strCep := FcdsEnderecos.FieldByName('AEN_ENDCEP').AsString;
  Result.strIncAtc := FcdsEnderecos.FieldByName('AEN_INCATC').AsString;
  Result.strSituacao := FcdsEnderecos.FieldByName('AEN_SITUAC').AsString;
  Result.strCodCid := FcdsEnderecos.FieldByName('AEN_ENDCID').AsString;
  Result.strBairro := FcdsEnderecos.FieldByName('AEN_ENDBAI').AsString;
  Result.strEndereco := FcdsEnderecos.FieldByName('AEN_ENDEND').AsString;
  Result.strEstado := FcdsEnderecos.FieldByName('CID_ESTADO').AsString;
  Result.strCidade := FcdsEnderecos.FieldByName('CID_NOMCID').AsString;

end;

function TfrmCadAssistenciaTecnica.fObterEnderecoDigitado: TEndereco;
begin
  Result := FrecEndereco;
  Result.strCodCid := edtCodCid.Text;
  Result.strCep := edtEndCep.Text;
  Result.strCidade := edtCidade.Text;
  Result.strEstado := edtEstado.Text;
  Result.strBairro := edtBairro.Text;
  Result.strEndereco := edtEndereco.Text;
  Result.strSituacao := edtEndSit.Text;
end;


function TfrmCadAssistenciaTecnica.fObterId(objDataSet: TDataSet): Integer;
  Var
    blnTemFiltro: Boolean;
begin
  blnTemFiltro := objDataSet.Filtered;
  Try
    if blnTemFiltro then
      objDataSet.Filtered := False;
    Result := objDataSet.RecordCount + 1;
  Finally
    if blnTemFiltro then
      objDataSet.Filtered := True;
  end;
end;

class function TfrmCadAssistenciaTecnica.fObterListaAssistencias: TUniClientDataSet;
  Var
    strSQL: String;
begin
  strSQL := fGetSqlListaAssistencias;
  Result :=  TZClient.Create(Nil, strSQL);
  Result.Open;
end;

procedure TfrmCadAssistenciaTecnica.pInserirContato;
  Var
    recContato: TContato;
begin
  recContato := FrecContato;
  if recContato.intId = 0 then
  begin
    recContato.intId := fObterId(FcdsContatos);
    FcdsContatos.Append;
    FcdsContatos.FieldByName('ID').AsInteger := recContato.intId;
    FcdsContatos.FieldByName('AUTOINCREM').AsString := IntToStr(recContato.intId);
    FcdsContatos.FieldByName('ACT_INCATC').AsString := QryCADATC.FieldByName('AUTOINCREM').AsString;
  end
  else
  begin
    if FcdsContatos.Locate('ID', recContato.intId, []) Then
      FcdsContatos.Edit
    else begin
      pMensagemOk('Contato não localizado e não poderá ser atualizado!');
      Exit;
    end;
  end;
  FcdsContatos.FieldByName('ACT_TIPO__').AsString := recContato.strTipo;
  FcdsContatos.FieldByName('ACT_DESCRI').AsString := recContato.strDescricao;
  FcdsContatos.FieldByName('ACT_PESSOA').AsString := recContato.strNome;
  FcdsContatos.FieldByName('ACT_INCAEN').AsString := recContato.strIncAen;
  FcdsContatos.Post;
end;

procedure TfrmCadAssistenciaTecnica.pInserirEndereco;
  Var
    recEndereco: TEndereco;
begin
  recEndereco := FrecEndereco;
  if recEndereco.intId = 0 then
  begin
    recEndereco.intId := fObterId(FcdsEnderecos);
    FcdsEnderecos.Append;
    FcdsEnderecos.FieldByName('ID').AsInteger := recEndereco.intId;
    FcdsEnderecos.FieldByName('AUTOINCREM').AsString := IntToStr(recEndereco.intId);
    FcdsEnderecos.FieldByName('AEN_INCATC').AsString := QryCADATC.FieldByName('AUTOINCREM').AsString;
  end
  else begin
    if FcdsEnderecos.Locate('ID', recEndereco.intId, []) Then
      FcdsEnderecos.Edit
    else begin
      pMensagemOk('Endereço não localizado e não poderá ser atualizado!');
      Exit;
    end;
  end;
  FcdsEnderecos.FieldByName('AEN_ENDCEP').AsString := recEndereco.strCep;
  FcdsEnderecos.FieldByName('AEN_SITUAC').AsString := recEndereco.strSituacao;
  FcdsEnderecos.FieldByName('AEN_ENDCID').AsString := recEndereco.strCodCid;
  FcdsEnderecos.FieldByName('AEN_ENDBAI').AsString := recEndereco.strBairro;
  FcdsEnderecos.FieldByName('AEN_ENDEND').AsString := recEndereco.strEndereco;
  FcdsEnderecos.FieldByName('CID_ESTADO').AsString := recEndereco.strEstado;
  FcdsEnderecos.FieldByName('CID_NOMCID').AsString := recEndereco.strCidade;
  FcdsEnderecos.Post;
  pAddUnidade(recEndereco);
end;

procedure TfrmCadAssistenciaTecnica.pLimparContatos;
begin
  edtCttPessoa.Clear;
  cboCttTipo.ItemIndex := -1;
  cboUnidade.ItemIndex := -1;
  mmoCttDescricao.Clear;
  medCttDes.Clear;
end;

procedure TfrmCadAssistenciaTecnica.pPrepararCboTipoContato;
  Var
    enuTipoContato: TTipoContato;
    strPar: String;
begin
  cboCttTipo.Items.Clear;
  cboCttTipo.Items.NameValueSeparator := '=';

  for enuTipoContato in [TTipoContato.Telefone..TTipoContato.Instagram] do
  begin
    strPar := enuTipoContato.fParNomeValor;
    cboCttTipo.Items.Add(strPar);
  end;
end;

procedure TfrmCadAssistenciaTecnica.pQryCADATCOnAfterOpen(DataSet: TDataSet);
begin
  If QryCADATC.IsEmpty then
    Exit;
  if fEmptyStr(QryCADATC.FieldByName('AUTOINCREM').AsString) then
    Exit;
  pCarrecarDadosComplementares(QryCADATC.FieldByName('AUTOINCREM').AsString);
end;

procedure TfrmCadAssistenciaTecnica.pQryCADATCOnAfterScroll(DataSet: TDataSet);
begin
  pInicializar;
end;

procedure TfrmCadAssistenciaTecnica.pQryCADATCOnNewRecord(DataSet: TDataSet);
begin
  pInicializar;
end;

procedure TfrmCadAssistenciaTecnica.pAddUnidade(recEndereco: TEndereco);
  Var
    stlEnd: TStrings;
    intIdx: Integer;
    strChave: String;
    strValor: String;
begin
  stlEnd := fGetUnidades;
  strChave := FormatFloat('000', recEndereco.intId);
  intIdx := stlEnd.IndexOfName(strChave);
  strValor := Format('%S %s %s',[recEndereco.strEstado,
                                 recEndereco.strCidade,
                                 recEndereco.strEndereco]);

  if intIdx >= 0 then
   stlEnd.ValueFromIndex[intIdx] := strValor
  else begin
    stlEnd.Add(strChave+'='+strValor)
  end  ;
end;

procedure TfrmCadAssistenciaTecnica.pAplicarFiltroDataSet(
  const strFiltro: String; DataSet: TDataSet);

  Var
    blnEnableControls: Boolean;
begin
  blnEnableControls := Not DataSet.ControlsDisabled;
  Try
    if blnEnableControls then
      DataSet.DisableControls;
    DataSet.Filtered := False;
    DataSet.Filter := strFiltro;
    if Not fEmptyStr(DataSet.Filter) then
      DataSet.Filtered := True;
  Finally
    if blnEnableControls then
      DataSet.EnableControls;
  End;
end;

procedure TfrmCadAssistenciaTecnica.pAplicarFiltroRegistrosExcluidos(
  DataSet: TDataSet);
  CONST
    FILTRO_REG_EXCLUSAO: String = ' ID < 0';
begin
  pAplicarFiltroDataSet(FILTRO_REG_EXCLUSAO, DataSet);
end;

procedure TfrmCadAssistenciaTecnica.pAplicarFiltroRegistrosNaoExcluidos(DataSet: TDataSet);
  CONST
    FILTRO_REG_ATIVOS: String = ' ID > 0';

begin
  pAplicarFiltroDataSet(FILTRO_REG_ATIVOS, DataSet);
end;

procedure TfrmCadAssistenciaTecnica.pCarrecarDadosComplementares(
  const strIncATC: String);
begin
  if  fEmptyStr(strIncATC) then
    Exit;
  pCarregarEnderecos(strIncATC);
  pCarregarContatos(strIncATC);
end;

procedure TfrmCadAssistenciaTecnica.pCarregaCidade(QryConsulta: TUniquery; strCodCid: String;
  out strCidade, strEstado, strCep: String);
begin
  pPesquisaCadCid(Nil, qryConCid, strCodCid);
  strCidade := QryConcid.FieldByName('CID_NOMCID').AsString;
  strEstado := QryConcid.FieldByName('CID_ESTADO').AsString;
  strCep    := QryConcid.FieldByName('CID_C_E_P_').AsString;
end;

procedure TfrmCadAssistenciaTecnica.pCarregarCFGs;
begin
  blnUsaCep := fCfgSis('USACEP', varBoolean);
end;

procedure TfrmCadAssistenciaTecnica.pCarregarContatos(const strIncATC: String);
  CONST
    SQL_CADACT: String = 'SELECT * FROM CADACT WHERE ACT_INCATC = :INCATC ';
  Var
    Qry: TUniQuery;
    strSQL: String;
    intId: Integer;
begin
  Qry := Nil;
  strSQL := SQL_CADACT;
  Try
    Try
      FcdsContatos.EmptyDataSet;
      Qry := fCriaQuery;
      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add(strSQL);
      Qry.ParamByName('INCATC').AsString := strIncATC;
      Qry.Open;
      if Qry.IsEmpty then
        Exit;
      Qry.First;
      While Not Qry.Eof do
      begin
        intId := fObterId(FcdsContatos);
        FcdsContatos.Append;
        FcdsContatos.FieldByName('ID').AsInteger := intId;
        FcdsContatos.FieldByName('AUTOINCREM').AsString := Qry.FieldByName('AUTOINCREM').AsString;
        FcdsContatos.FieldByName('ACT_INCATC').AsString := Qry.FieldByName('ACT_INCATC').AsString;
        FcdsContatos.FieldByName('ACT_TIPO__').AsString := Qry.FieldByName('ACT_TIPO__').AsString;
        FcdsContatos.FieldByName('ACT_DESCRI').AsString := Qry.FieldByName('ACT_DESCRI').AsString;
        FcdsContatos.FieldByName('ACT_INCAEN').AsString := Qry.FieldByName('ACT_INCAEN').AsString;
        FcdsContatos.FieldByName('ACT_PESSOA').AsString := Qry.FieldByName('ACT_PESSOA').AsString;
        FcdsContatos.Post;
        Qry.Next;
      end;
      Qry.Close;
    Except
      On E: Exception do
      begin
        pMensagensErro(e.Message,'TfrmCadAssistenciaTecnica.pCarregarContatos');
      end;
    End;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

procedure TfrmCadAssistenciaTecnica.pCarregarEnderecos(const strIncATC: String);
  Var
    strSQL: String;
    Qry: TUniQuery;
    intId: Integer;
    recEndereco: TEndereco;
begin
  Qry := Nil;
  strSQL := fGetSQLCadAEN;
  Try
    Try
      fGetUnidades(True);
      FcdsEnderecos.EmptyDataSet;
      Qry := fCriaQuery;
      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add(strSQL);
      Qry.ParamByName('INCATC').AsString := strIncATC;
      Qry.Open;
      if Qry.IsEmpty then
        Exit;
      Qry.First;
      While Not Qry.Eof do
      begin
        intId := fObterId(FcdsEnderecos);
        Fcdsenderecos.Append;
        FcdsEnderecos.FieldByName('ID').AsInteger := intId;
        Fcdsenderecos.FieldByName('AUTOINCREM').AsString := Qry.FieldByName('AUTOINCREM').AsString;
        Fcdsenderecos.FieldByName('AEN_SITUAC').AsString := Qry.FieldByName('AEN_SITUAC').AsString;
        Fcdsenderecos.FieldByName('AEN_INCATC').AsString := Qry.FieldByName('AEN_INCATC').AsString;
        Fcdsenderecos.FieldByName('AEN_ENDCEP').AsString := Qry.FieldByName('AEN_ENDCEP').AsString;
        Fcdsenderecos.FieldByName('AEN_ENDCID').AsString := Qry.FieldByName('AEN_ENDCID').AsString;
        Fcdsenderecos.FieldByName('AEN_ENDBAI').AsString := Qry.FieldByName('AEN_ENDBAI').AsString;
        Fcdsenderecos.FieldByName('AEN_ENDEND').AsString := Qry.FieldByName('AEN_ENDEND').AsString;
        Fcdsenderecos.FieldByName('CID_NOMCID').AsString := Qry.FieldByName('CID_NOMCID').AsString;
        Fcdsenderecos.FieldByName('CID_ESTADO').AsString := Qry.FieldByName('CID_ESTADO').AsString;
        Fcdsenderecos.Post;
        recEndereco := fObterEndereco;
        pAddUnidade(recEndereco);
        Qry.Next;
      end;
      Qry.Close;
    Except
      On E: Exception do
      begin
        pMensagensErro(e.Message,'TfrmCadAssistenciaTecnica.pCarregarEnderecos');
      end;
    End;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;


procedure TfrmCadAssistenciaTecnica.pCriarcdsContatos;
  Var
    objFieldDef: TFieldDef;
    objField: TField;
begin
  FcdsContatos := TUniClientDataSet.Create(Nil);

  objFieldDef := FcdsContatos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'ID';
  objFieldDef.DataType := ftInteger;
  objFieldDef.CreateField(FcdsContatos);

  objFieldDef := FcdsContatos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'AUTOINCREM';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 20;
  objFieldDef.CreateField(FcdsContatos);

  objFieldDef := FcdsContatos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'ACT_INCATC';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 20;
  objFieldDef.CreateField(FcdsContatos);

  objFieldDef := FcdsContatos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'ACT_TIPO__';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 1;
  objField :=   objFieldDef.CreateField(FcdsContatos);
  objField.OnGetText := pFcdsContatosACT_TIPO__OnGetText;

  objFieldDef := FcdsContatos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'ACT_DESCRI';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 256;
  objFieldDef.CreateField(FcdsContatos);

  objFieldDef := FcdsContatos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'ACT_INCAEN';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 20;
  objFieldDef.CreateField(FcdsContatos);

  objFieldDef := FcdsContatos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'ACT_PESSOA';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 60;
  objFieldDef.CreateField(FcdsContatos);

  FcdsContatos.CreateDataSet;
  FcdsContatos.IndexFieldNames := 'ID;AUTOINCREM';
  pAplicarFiltroRegistrosNaoExcluidos(FcdsContatos);
end;

procedure TfrmCadAssistenciaTecnica.pCriarcdsEnderecos;
  Var
    objFieldDef: TFieldDef;
begin
  FcdsEnderecos := TUniClientDataSet.Create(Nil);
  objFieldDef := FcdsEnderecos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'AUTOINCREM';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 20;

  objFieldDef := FcdsEnderecos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'AEN_INCATC';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 20;

  objFieldDef := FcdsEnderecos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'AEN_SITUAC';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 1;

  objFieldDef := FcdsEnderecos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'AEN_ENDCEP';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 9;

  objFieldDef := FcdsEnderecos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'AEN_ENDCID';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 5;

  objFieldDef := FcdsEnderecos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'AEN_ENDBAI';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 60;

  objFieldDef := FcdsEnderecos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'AEN_ENDEND';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 150;

  objFieldDef := FcdsEnderecos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'CID_ESTADO';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 2;

  objFieldDef := FcdsEnderecos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'CID_NOMCID';
  objFieldDef.DataType := ftString;
  objFieldDef.Size := 40;

  objFieldDef := FcdsEnderecos.FieldDefs.AddFieldDef;
  objFieldDef.Name := 'ID';
  objFieldDef.DataType := ftInteger;


  FcdsEnderecos.CreateDataSet;
  FcdsEnderecos.IndexFieldNames := 'CID_ESTADO;CID_NOMCID';
  pAplicarFiltroRegistrosNaoExcluidos(FcdsEnderecos);
  if Assigned(FcdsEnderecos.FindField('ID')) Then
    FcdsEnderecos.FieldByName('ID').OnGetText := pFcdsEnderecoID_OnGetText;
end;

procedure TfrmCadAssistenciaTecnica.pCriarQryCadATC;
  Var
    strSql: String;
begin
  strNomeTabela := 'CADATC';
  strNomeCampo := 'ATC_CODIGO';

  strSQL := 'SELECT AUTOINCREM, ATC_CODIGO, ATC_SITUAC, ATC_CODEMP, ATC_NOMEMP ' ;
  strSQL := strSQL + ' FROM CADATC ';


  QryCADATC := fCriarQuery(strSql, Self);

  QryCADATC.FieldByName('ATC_CODIGO').DisplayLabel := 'Código';
  QryCADATC.FieldByName('ATC_SITUAC').DisplayLabel := 'Situação';
  QryCADATC.FieldByName('ATC_NOMEMP').DisplayLabel := 'Nome da Assistência';
  QryCADATC.FieldByName('ATC_CODEMP').Visible := False;
  QryCADATC.FieldByName('AUTOINCREM').Visible := False;

  dtsAssitencias.DataSet := QryCADATC;
  QryTabela := QryCADATC;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
  QryCADATC.AfterScroll := pQryCADATCOnAfterScroll;

  QryCADATC.AfterOpen := pQryCADATCOnAfterOpen;
  QryCADATC.OnNewRecord := pQryCADATCOnNewRecord;
end;

procedure TfrmCadAssistenciaTecnica.pCriarTabelas;
begin
  pCriarQryCadATC;
  pCriarcdsEnderecos;
  pCriarcdsContatos;
  qryConCid := fCriaQuery(Self);
end;

procedure TfrmCadAssistenciaTecnica.pDesvincularContatoEndereco(strAutInc: String);
  Var
    cdsContatosACT_INCAEN: TField;
begin
  FcdsContatos.First;
  cdsContatosACT_INCAEN := FcdsContatos.FindField('ACT_INCAEN');
  While Not FcdsContatos.Eof do
  begin
    if cdsContatosACT_INCAEN.AsString = strAutInc then
    begin
      FcdsContatos.Edit;
      cdsContatosACT_INCAEN.AsString := EmptyStr;
      FcdsContatos.Post;
    end;
    FcdsContatos.Next;
  end
end;

procedure TfrmCadAssistenciaTecnica.pImprimir(const strCodAtc: String);
  Var
    Qry: TUniQuery;
begin
  Qry := Nil;
  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(fGetSqlFichaAssistenciaTecnica);
    Qry.ParamByName('CODATC').AsString := strCodAtc;
    Qry.Open;

    if Qry.IsEmpty then
    begin
      pMensagemOk('Não foram localizados dados da assistência técnica!');
      Exit;
    end;

    frxCadATC.DataSet := Qry;
    frxReport1.PrepareReport;

    frxReport1.ShowPreparedReport;

  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

class procedure TfrmCadAssistenciaTecnica.pImprimirFichaAssistenciaTecnica(const strCodAtc: String);
  Var
    frmCadAssistenciaTecnica: TfrmCadAssistenciaTecnica;
begin
  frmCadAssistenciaTecnica := Nil;
  Try
    frmCadAssistenciaTecnica := TfrmCadAssistenciaTecnica.Create(Nil);
    frmCadAssistenciaTecnica.pImprimir(strCodAtc);
    frmCadAssistenciaTecnica.Release;
  Finally
    if Assigned(frmCadAssistenciaTecnica) then
      FreeAndNil(frmCadAssistenciaTecnica);
  End;
end;

procedure TfrmCadAssistenciaTecnica.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('ATC_CODIGO');
  stlCampos.Add('ATC_NOMEMP');
  stlCampos.Add('ATC_SITUAC');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('ATC_NOMEMP');
  stlCamInd.Add('ATC_CODIGO');
  stlCamInd.Add('ATC_SITUAC');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Nome Assistência');
  stlDesInd.Add('Código');
  stlDesInd.Add('Situação');
  stlDesInd.Add('AUTOINCREM');
end;

procedure TfrmCadAssistenciaTecnica.pInicializar(blnCompleto: Boolean = True);
  Var
    strAutInc: String;
begin
  FrecEndereco.Inicializar;
  FRecContato.Inicializar;
  pExibirEndereco;
  pExibirContato;

  if (Not blnCompleto) then
    Exit;

  cboUnidade.Items.Clear;

  if FcdsEnderecos.Active then
    FcdsEnderecos.EmptyDataSet;

  if FcdsContatos.Active then
    FcdsContatos.EmptyDataSet;


  if QryCADATC.IsEmpty then
  begin
    strAutInc := EmptyStr
  end
  else
  begin
    if fEmptyStr(QryCADATC.FieldByName('AUTOINCREM').AsString) then
      strAutInc := EmptyStr
    else
     strAutInc := QryCADATC.FieldByName('AUTOINCREM').AsString;
  end;

  pCarrecarDadosComplementares(strAutInc);

end;

procedure TfrmCadAssistenciaTecnica.pPesquisarCidade(Var Key: Char);
  Var
    arrCidade: TConsultasArray;

begin

  If fPesqCidade(Self,edtCodCid, edtCidade, edtEstado, qryConCid, Key, arrCidade) Then
  Begin

    If fValidaCampos(edtCidade, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

{ TEnderecoRecord }

procedure TEnderecoRecord.Inicializar;
begin
  Self.intId        := 0;
  Self.strIncAtc    := EmptyStr;
  Self.strCep       := EmptyStr;
  Self.strCidade    := EmptyStr;
  Self.strCodCid    := EmptyStr;
  Self.strEstado    := EmptyStr;
  Self.strSituacao  := EmptyStr;
  Self.strBairro    := EmptyStr;
  Self.strEndereco  := EmptyStr;
end;
{ TContatoRecord }

procedure TContatoRecord.Inicializar;
begin
  Self.intId := 0;
  Self.strAutoincrem := EmptyStr;
  Self.strIncAtc := EmptyStr;
  Self.strTipo := EmptyStr;
  Self.strDescricao := EmptyStr;
  Self.strNome := EmptyStr;
  self.strIncAen := EmptyStr;
end;

{ TComboBoxHelper }

function TComboBoxHelper.fGetNameOfItemIndex: String;
begin
  Result := Self.Items.Names[Self.ItemIndex];
end;

procedure TComboBoxHelper.pSetIndexOfName(const strIndexName: String);
  Var
    intIdx: Integer;
begin
  intIdx :=  Self.Items.IndexOfName(strIndexName);
  if intIdx >=0 then
    Self.ItemIndex := intIdx;
end;

{ TTipoContatoHelper }

function TTipoContatoHelper.fAsString: String;
begin
  if Ord(Self) = -1 then
    Result := EmptyStr
  else
   Result :=  GetEnumName(TypeInfo(TTipoContato), Ord(Self));
end;

function TTipoContatoHelper.fParNomeValor(chrSeparador: Char): String;
begin
  if Ord(Self) = -1 then
    Result := EmptyStr
  else
    Result := IntToStr(Ord(Self))+'='+Self.fAsString;
end;

procedure TTipoContatoHelper.pSetAsString(const Value: String);
  Var
    intAux: Integer;
begin
  if TryStrToInt(Value, intAux) then
    Self := TTipoContato(Ord(intAux))
  else
    Self := TTipoContato(Ord(-1));
end;

end.

