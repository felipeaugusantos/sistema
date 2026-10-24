unit untCadFaixaDescontoLinhaGrupoSubGerente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, StrUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Datasnap.DBClient, UniClientDataSet,
  Uni, untConsultas, untTypesSistema,
  untFuncoesConsulta, cxProgressBar, untGravando, QColorLabel;

type
  TfrmCadFaixaDescontoLinhaGrupoSubGerente = class(TfrmPaiSimples)
    pnlPrincipal: TPanel;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    pnlCabecalho: TPanel;
    lblGerente: TLabel;
    lblCodTab: TLabel;
    lblDescri: TLabel;
    Bevel1: TBevel;
    edtCodSub: TEditFocus;
    edtNomSub: TEditFocus;
    btnConfirmarSubGerente: TBitBtnLocked;
    edtDescri: TEditFocus;
    edtCodTab: TEditFocus;
    cxgSubGerentes: TcxGrid;
    cxGridDBTvSubGerentes: TcxGridDBTableView;
    cxgGerentesDBCODSUB: TcxGridDBColumn;
    cxgGerentesDBNOMSUB: TcxGridDBColumn;
    cxgSubGerentesLevel1: TcxGridLevel;
    pnlAtalho01: TPanel;
    lblAtalho01: TLabel;
    pnlCadGrupo: TPanel;
    lblLinhaGrupo: TLabel;
    lblDesIni: TLabel;
    lblDesFin: TLabel;
    lblComissao: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    edtCodGru: TEditFocus;
    edtDesGru: TEditFocus;
    btnConfirmarLinha: TBitBtnLocked;
    edtDesIni: TEditFocus;
    edtDesFin: TEditFocus;
    edtComissao: TEditFocus;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtCodUni: TEditFocus;
    edtSigUni: TEditFocus;
    cxgGrupos: TcxGrid;
    cxGridDBTvGrupos: TcxGridDBTableView;
    cxgGruposDBDESITE: TcxGridDBColumn;
    cxgGruposDBDESINI: TcxGridDBColumn;
    cxgGruposDBDESFIN: TcxGridDBColumn;
    cxgGruposDBPERCOM: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnlAtalho02: TPanel;
    lblAtalho02: TLabel;
    cdsGrupo: TUniClientDataSet;
    cdsGrupoHLS_CODTAB: TStringField;
    cdsGrupoHLS_CODGRU: TStringField;
    cdsGrupoHLS_DESINI: TFloatField;
    cdsGrupoHLS_DESFIN: TFloatField;
    cdsGrupoHLS_PERCOM: TFloatField;
    cdsGrupoAUTOINCREM: TStringField;
    cdsGrupoHLS_DESGRU: TStringField;
    cdsGrupoHLS_CODITE: TStringField;
    cdsGrupoHLS_DESITE: TStringField;
    cdsGrupoHLS_CODUNI: TStringField;
    dtsGrupo: TDataSource;
    cdsSubGerente: TUniClientDataSet;
    cdsSubGerenteAUTOINCREM: TStringField;
    cdsSubGerenteHLS_CODTAB: TStringField;
    cdsSubGerenteHLS_NOMSUB: TStringField;
    cdsSubGerenteHLS_CODSUB: TStringField;
    dtsSubGerente: TDataSource;
    lblTabPre: TLabel;
    edtTabPre: TEditFocus;
    clbPrcVenda: TColorLabel;
    cdsGrupoHLS_TABPRE: TStringField;
    cxgGruposDBTABPRE: TcxGridDBColumn;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodSubKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarSubGerenteClick(Sender: TObject);
    procedure edtCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarLinhaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtNomSubKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxGridDBTvSubGerentesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridDBTvGruposKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSubExit(Sender: TObject);
    procedure cxGridDBTvGruposDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    blnInserindo: Boolean;
    blnAlterando: Boolean;
    arrSubGerentes: TConsultasArray;
    strCodTabSel: String;
    blnAltLinGru: Boolean;
    strVrfTpr: String;

    procedure pLimparDadosSubGerente;
    procedure pLimparDadosGrupo;
    procedure pLimparTela;
    procedure pHabilitar(blnHabilitar: Boolean);
    procedure pAdicionarSubGerente(strCodSub, strNomSub: String);
    function fGerenteAdicionado(strCodSub: String): Boolean;
    procedure pAdicionarGrupo(strCodGru, strDesGru: String; fltDesIni,
      fltDesFin, fltComis: Double; strCodIte, strCodUni, strTabPre: String);
    function fFaixaExiste(strCodIte: String; fltDesIni,
      fltDesFin: Double; strTabPre: String): Boolean;
    function fHierarquiaExiste(strCodTab: String): Boolean;
    procedure pCadastrarHierarquia;
    procedure pVincularSubGerentes;
    procedure pVincularGrupos;
    procedure pCarregarSubGerentes(strCodTab: String);
    procedure pCarregarGrupos(strCodTab: String);
    function fExcluir(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fSubGerenteEmOutraHierarquia(strCodSub, strCodTab: String): Boolean;
    procedure pAdicionaProdutos;
    procedure pMoveItemParaEdicao;
    procedure pCarregaTabelaPrecos;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadFaixaDescontoLinhaGrupoSubGerente: TfrmCadFaixaDescontoLinhaGrupoSubGerente;

implementation

{$R *.dfm}

uses untFuncoesSimples, untObservacao;

{ TfrmCadFaixaDescontoLinhaGrupoSubGerente }

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.btnAlterarClick(
  Sender: TObject);
begin
  inherited;
  If fEmptyStr(strCodTabSel) Then
  Begin
    pMensagemOk('Selecione um registro para alterar!');
    Exit;
  End;

  pHabilitar(False);
  pHabilitaCodigo(edtCodTab, edtDescri, False);
  blnInserindo := False;
  blnAlterando := True;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.btnCancelaClick(
  Sender: TObject);
begin
  inherited;
  pLimparTela;

  pHabilitar(True);
  blnInserindo := False;
  blnAlterando := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.btnConfirmarLinhaClick(
  Sender: TObject);
begin
  inherited;

  if (fEmptyStr(edtCodGru.Text)) then
  begin
    if (fEmptyStr(edtCodUni.Text)) then
    begin
      if (fEmptyStr(edtCodIte.Text)) then
      begin
        pMensagemOk('Nenhum filtro informado.');
        Exit;
      end;
    end;
  end;

  If fVerificaCampos Then
  Begin
    TfrmGravando.fExecutarModal(pAdicionaProdutos, 'Aguarde, Carregando produtos ...', '');
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.btnConfirmarSubGerenteClick(
  Sender: TObject);
var
  qrySub : TUniQuery;
  strCodSub : String;
  arrSubGerentesEmOutrasHierarquias : Array Of String;
begin
  inherited;

  SetLength(arrSubGerentesEmOutrasHierarquias, 0);

  If fValidaCampos(edtCodSub) Then
  Begin
    If Length(arrSubGerentes) > 1 Then
    Begin
      qrySub := fCriaQuery;
      Try
        qrySub.SQL.Clear;
        qrySUb.SQL.Add(' SELECT OPE_CODOPE, OPE_NOMOPE ');
        qrySub.SQL.Add(' FROM CADOPE ');
        qrySub.SQL.Add(' WHERE ' + fStrLocate(edtCodSub, arrSubGerentes, 'OPE_CODOPE', 'CODOPE', True));
        pSetaParam(edtCodSub.Text, arrSubGerentes, strCodSub, 'CODOPE', qrySub);
        qrySub.Open;

        qrySub.First;
        While Not qrySub.Eof Do
        Begin
          If fSubGerenteEmOutraHierarquia(qrySub.FieldByName('OPE_CODOPE').AsString, strCodTabSel) Then
          Begin
           SetLength(arrSubGerentesEmOutrasHierarquias, Length(arrSubGerentesEmOutrasHierarquias)+1);
           arrSubGerentesEmOutrasHierarquias[Length(arrSubGerentesEmOutrasHierarquias)-1] := qrySub.FieldByName('OPE_CODOPE').AsString;
          End
          Else If Not fGerenteAdicionado(qrySub.FieldByName('OPE_CODOPE').AsString) Then
            pAdicionarSubGerente(qrySub.FieldByName('OPE_CODOPE').AsString, qrySub.FieldByName('OPE_NOMOPE').AsString);

          qrySub.Next;
        End;
      Finally
        FreeAndNil(qrySub);
      End;

      If Length(arrSubGerentesEmOutrasHierarquias) > 0 Then
      Begin
        If Length(arrSubGerentesEmOutrasHierarquias) < Length(arrSubGerentes) Then
          pMensagemOk('Subgerentes inseridos com sucesso, com exceção de: ['+fOrganizaArrayComVirgula(arrSubGerentesEmOutrasHierarquias)+'] que já foram adicionados a outra hierarquia!')
        Else
          pMensagemOk('Os subgerentes selecionados não foram adicionados, pois, se encontram em outra hierarquia!');
      End;

      SetLength(arrSubGerentes, 0);
    End
    Else
    Begin
      If fSubGerenteEmOutraHierarquia(edtCodSub.Text, strCodTabSel) Then
        pMensagemOk('Esse subgerente já foi adicionado a outra hierarquia!')
      Else If Not fGerenteAdicionado(edtCodSub.Text) Then
        pAdicionarSubGerente(edtCodSub.Text, edtNomSub.Text)
      Else
        pMensagemOk('Esse subgerente já foi adicionado!');
    End;

    pLimparDadosSubGerente;
    pSetFocus(edtCodSub);

    pHabilitar(False);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.btnExcluirClick(
  Sender: TObject);
begin
  inherited;

  If fEmptyStr(strCodTabSel) Then
    Exit;

  If fMensagem('Atenção!', 'Deseja excluir este registro?', ['&Sim', '&Não']) = 2 Then
    Exit;

  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    Try
      frmGravando.fExecutarAcao := fExcluir;
      frmGravando.ShowModal;

      If frmGravando.blnConfirma Then
        pMensagemOK('Registro excluído com sucesso!');
    Except
      On E:Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmCadFaixaDescontoLinhaGrupoSubGerente.btnExcluirClick]');
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.btnGravarClick(
  Sender: TObject);
begin
  inherited;
  If (Not fValidaCampos(edtCodTab)) Or (Not fValidaCampos(edtDescri)) Then
    Exit;

  If (cdsSubGerente.IsEmpty) Or (cdsGrupo.IsEmpty) Then
  Begin
    fMensagem('Atenção!', 'É necessário informar Subgerentes e grupos!', ['&Ok']);
    Exit;
  End;

  fStartTransaction;
  Try
    pCadastrarHierarquia;
    pVincularSubGerentes;
    pVincularGrupos;
    fCommit;

    pHabilitar(True);
    blnInserindo := False;
    blnAlterando := False;
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '[TfrmCadFaixaDescontoLinhaGrupoSubGerente.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.btnIncluirClick(
  Sender: TObject);
begin
  inherited;
  pHabilitar(False);
  pLimparTela;

  blnInserindo := True;
  blnAlterando := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.btnPesquisaClick(
  Sender: TObject);
var
  qryConsulta : TUniQuery;
  arrSel : TConsultasArray;
  strSQL : String;
begin
  inherited;

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  HL5_CODTAB, ';
  strSQL := strSQL + '  HL5_DESCRI, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  COMHL5 ';

  qryConsulta := fCriaQuery;
  Try
    If fConsulta([strSQL],
                 ['Código', 'Descrição'],
                 ['HL5_CODTAB', 'HL5_DESCRI'],
                 'AUTOINCREM',
                 'COMHL5',
                 Self.Name,
                 'Cadastro de Faixa de Desconto Por Linha/Grupo - Gerente',
                 qryConsulta,
                 nil,
                 True,
                 arrSel,
                 'AUTOINCREM',
                 nil) Then
    Begin
      pLimparTela;
      strCodTabSel   := qryConsulta.FieldByName('HL5_CODTAB').AsString;

      edtCodTab.Text := strCodTabSel;
      edtDescri.Text := qryConsulta.FieldByName('HL5_DESCRI').AsString;

      pCarregarSubGerentes(strCodTabSel);
      pCarregarGrupos(strCodTabSel);
      cxgGrupos.Enabled := False;
    End
  Finally
    FreeAndNil(qryConsulta);
  End;
end;
procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.cxGridDBTvGruposDblClick(
  Sender: TObject);
begin
  inherited;
  pMoveItemParaEdicao;
  cxgGrupos.Enabled := False;
  blnAltLinGru := True;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.cxGridDBTvGruposKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE:
    Begin
      If (Not cdsGrupo.IsEmpty) And (blnInserindo Or blnAlterando) Then
        cdsGrupo.Delete
    End;
    VK_RETURN: cxGridDBTvGruposDblClick(cxGridDBTvGrupos);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.cxGridDBTvSubGerentesKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_DELETE Then
    If (Not cdsSubGerente.IsEmpty) And (blnInserindo Or blnAlterando) Then
      cdsSubGerente.Delete;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.edtCodGruKeyPress(
  Sender: TObject; var Key: Char);
var
  arrGrupos: TConsultasArray;
begin
  inherited;

  If (fPesqGrupo(Self, edtCodGru, edtDesGru, Nil, Key, arrGrupos, True)) Then
  Begin
    If fValidaCampos(edtCodGru) Then
      SelectNext(ActiveControl, True, True);
  End
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.edtCodIteKeyPress(
  Sender: TObject; var Key: Char);
var
  arrProd : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrProd) then
    Begin
      If (fValidaCampos(edtCodIte, True)) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.edtCodSubExit(
  Sender: TObject);
begin
  inherited;

  if not fEmptyStr(edtCodSub.Text) then
  begin
    edtCodSub.Text := fStrZero(edtCodSub.Text, edtCodSub.TamCampo);
    edtNomSub.Text := fRetNomeOperador(edtCodSub.Text);
  end;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.edtCodSubKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqOperador(Self, edtCodSub, edtNomSub, Nil, Key, arrSubGerentes, False, True, False, False, False, False, False, True) then
  Begin
    If fValidaCampos(edtCodSub) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.edtCodUniKeyPress(
  Sender: TObject; var Key: Char);
var
  arrUnidades: TConsultasArray;
begin
  inherited;
  if fPesqUnidade(Self, edtCodUni, Nil, edtSigUni, Nil, Key, arrUnidades, True, False, False, False) then
  begin
    If fValidaCampos(edtCodUni, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.edtNomSubKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    btnConfirmarSubGerente.Click;
end;

function TfrmCadFaixaDescontoLinhaGrupoSubGerente.fExcluir(
  pgbStatus: TcxProgressBar): Boolean;
var
  qrySub : TUniQuery;
begin
  qrySub := fCriaQuery(Self);
  Try
    qrySub.SQL.Clear;
    qrySub.SQL.Add('DELETE FROM COMHL5 WHERE HL5_CODTAB = :CODTAB');
    qrySub.ParamByName('CODTAB').AsString := strCodTabSel;
    qrySub.ExecSQL;

    pLimparTela;
  Finally
    FreeAndNil(qrySub);
  End;

  Result := True;
end;

function TfrmCadFaixaDescontoLinhaGrupoSubGerente.fFaixaExiste(
  strCodIte: String; fltDesIni, fltDesFin: Double; strTabPre: String): Boolean;
  Var
    intRecNo: Integer;
begin
  Result := False;
  intRecNo := cdsGrupo.RecNo;
  cdsGrupo.DisableControls;

  Try
    cdsGrupo.First;

    While Not cdsGrupo.Eof Do
    Begin
      If (cdsGrupo.FieldByName('HLS_CODITE').AsString <> strCodIte) Or
        ((blnAltLinGru) And (cdsGrupo.RecNo = intRecNo)) Then
      Begin
        cdsGrupo.Next;
        Continue;
      End;

      If (fltDesIni >= cdsGrupo.FieldByName('HLS_DESINI').AsFloat) And (fltDesIni <= cdsGrupo.FieldByName('HLS_DESFIN').AsFloat) Then
        Result := True
      Else If (fltDesFin >= cdsGrupo.FieldByName('HLS_DESINI').AsFloat) And (fltDesFin <= cdsGrupo.FieldByName('HLS_DESFIN').AsFloat) Then
        Result := True
      Else If (fltDesIni <= cdsGrupo.FieldByName('HLS_DESINI').AsFloat) And (fltDesFin >= cdsGrupo.FieldByName('HLS_DESFIN').AsFloat) Then
        Result := True;

      If (Result) And (Not fEmptyStr(strTabPre)) And (strTabPre <> cdsGrupo.FieldByName('HLS_TABPRE').AsString) Then
      Begin
        Result := False;
      End;

      If Result Then
        Exit;

      cdsGrupo.Next;
    End;
  Finally
    cdsGrupo.Filtered := False;
    cdsGrupo.RecNo := intRecNo;
    cdsGrupo.EnableControls;
  End;
end;

function TfrmCadFaixaDescontoLinhaGrupoSubGerente.fGerenteAdicionado(
  strCodSub: String): Boolean;
begin
  cdsSubGerente.DisableControls;
  Try
    cdsSubGerente.Filter := 'HLS_CODSUB = ' + QuotedStr(strCodSub);
    cdsSubGerente.Filtered := True;
    Result := Not cdsSubGerente.IsEmpty;
  Finally
    cdsSubGerente.Filtered := False;
    cdsSubGerente.EnableControls;
  End;
end;

function TfrmCadFaixaDescontoLinhaGrupoSubGerente.fSubGerenteEmOutraHierarquia(
  strCodSub, strCodTab: String): Boolean;
var
  qrySub : TUniQuery;
begin
  qrySub := fCriaQuery;
  Try
    qrySub.SQL.Clear;
    qrySub.SQL.Add(' SELECT HLS_CODTAB ');
    qrySub.SQL.Add(' FROM COMHLS ');
    qrySub.SQL.Add(' WHERE HLS_CODSUB = :CODSUB ');
    qrySub.ParamByName('CODSUB').AsString := strCodSub;
    qrySub.Open;

    If (Not qrySub.IsEmpty) Then
      Result := qrySub.FieldByName('HLS_CODTAB').AsString <> strCodTab
    Else
      Result := False;
  Finally
    FreeAndNil(qrySub);
  End;
end;

function TfrmCadFaixaDescontoLinhaGrupoSubGerente.fHierarquiaExiste(
  strCodTab: String): Boolean;
var
  qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT * FROM COMHL5 WHERE HL5_CODTAB = :CODTAB');
    qryGen.ParamByName('CODTAB').AsString := strCodTab;
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.FormCreate(Sender: TObject);
begin
  inherited;
  cdsSubGerente.CreateDataSet;
  cdsGrupo.CreateDataSet;

  pHabilitar(True);

  strCodTabSel := '';
  blnAltLinGru := False;
  cxgGrupos.Enabled := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.FormShow(Sender: TObject);
begin
  inherited;
  lblTabPre.Visible := fCfgSis('TPCHFD', varBoolean);
  edtTabPre.Visible := lblTabPre.Visible;
  clbPrcVenda.Visible := lblTabPre.Visible;
  cxgGruposDBTABPRE.Visible := lblTabPre.Visible;
  pCarregaTabelaPrecos;
end;

function TfrmCadFaixaDescontoLinhaGrupoSubGerente.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodTab) Then
    Begin
      If fEmptyStr(edtCodTab.Text) Then
      Begin
        fMensagem('', 'O código da hierarquia deve ser preenchido.', ['&Ok']);
        Result := False;
      End
      Else If (fHierarquiaExiste(edtCodTab.Text)) And (Not blnAlterando) Then
      Begin
        fMensagem('', 'Já existe uma hierarquia com esse código.', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtDescri) Then
    Begin
      If fEmptyStr(edtDescri.Text) Then
      Begin
        fMensagem('', 'A descrição da hierarquia deve ser preenchida.', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodSub) Then
    Begin
      If (fEmptyStr(edtCodSub.Text)) Then
      Begin
        fMensagem('AVISO','Código do Subgerente deve ser preenchido.', ['&OK']);
        Result := False;
      End
      Else If (edtCodSub.Text <> '000000') And (edtNomSub.Text <> '+1') Then
      Begin
        edtNomSub.Text := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE', 'OPE_STATUS', 'OPE_INTEXT'], [edtCodSub.Text, 'A', 'S']);

        If (fEmptyStr(edtNomSub.Text)) Then
        Begin
          fMensagem('AVISO','Código do Subgerente não encontrado.', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodGru) And (Not fEmptyStr(edtCodGru.Text)) Then
    Begin
      If (edtCodGru.Text <> '000000') And (edtDesGru.Text <> '+1') Then
      Begin
        edtDesGru.Text := fCampoTabela('GRU_DESGRU', 'CADGRU', ['GRU_CODGRU'], [edtCodGru.Text]);

        If (fEmptyStr(edtDesGru.Text)) Then
        Begin
          fMensagem('AVISO','Código do grupo não encontrado.', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodUni) And (Not fEmptyStr(edtCodUni.Text)) Then
    Begin
      edtSigUni.Text := fRetSiglaUnidade(edtCodUni.Text);

      If (fEmptyStr(edtSigUni.Text)) Then
      Begin
        fMensagem('AVISO','Código da unidade não encontrado.', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodIte) And (Not fEmptyStr(edtCodIte.Text)) Then
    Begin
      edtCodIte.Text := fStrZero(edtCodIte.Text, edtCodIte.MaxLength);
      edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

      If (fEmptyStr(edtDesIte.Text)) Then
      Begin
        fMensagem('AVISO','Código do produto não encontrado.', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtDesIni) Then
    Begin
      If (fEmptyStr(edtDesIni.Text)) Then
      Begin
        fMensagem('AVISO','Desconto inicial deve ser preenchido.', ['&OK']);
        Result := False;
      End
      Else If (StrToFloatDef(edtDesIni.Text, 0) < 0) Or (StrToFloatDef(edtDesIni.Text, 0) > 100) Then
      Begin
        fMensagem('AVISO','Valor inválido para o campo Desconto Inicial, preencha um valor entre 0 e 100.', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtDesFin) Then
    Begin
      If (fEmptyStr(edtDesFin.Text)) Then
      Begin
        fMensagem('AVISO','Desconto final deve ser preenchido.', ['&OK']);
        Result := False;
      End
      Else If (StrToFloatDef(edtDesFin.Text, 0) < 0) Or (StrToFloatDef(edtDesFin.Text, 0) > 100) Then
      Begin
        fMensagem('AVISO','Valor inválido para o campo Desconto Final, preencha um valor entre 0 e 100.', ['&OK']);
        Result := False;
      End
      Else If (StrToFloatDef(edtDesIni.Text, 0) > StrToFloatDef(edtDesFin.Text, 0)) Then
      Begin
        fMensagem('AVISO','Desconto Final deve ser maior ou igual ao Desconto Inicial.', ['&OK']);
        Result := False;
      End
    End
    Else If (Sender = edtTabPre) And (edtTabPre.Visible) Then
    Begin
      If fEmptyStr(edtTabPre.Text) Then
      Begin
        fMensagem('AVISO','Tabela de preço deve ser preenchida.', ['&OK']);
        Result := False;
      End
      Else If Pos( edtTabPre.Text, strVrfTpr ) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Tabela de Preço deve ser ' + clbPrcVenda.Caption + '!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.pAdicionaProdutos;
var
  qryProdutos: TUniQuery;
  strItemFaixa: String;
begin
  qryProdutos := fCriaQuery;
  cdsGrupo.DisableControls;

  strItemFaixa := EmptyStr;

  try
    qryProdutos.Close;
    qryProdutos.SQL.Clear;
    qryProdutos.SQL.Add('SELECT I.ITE_CODITE, I.ITE_DESITE, I.ITE_CODUNI, I.ITE_CODGRU, G.GRU_DESGRU');
    qryProdutos.SQL.Add('FROM CADITE I');
    qryProdutos.SQL.Add('LEFT JOIN CADGRU G');
    qryProdutos.SQL.Add('ON(I.ITE_CODGRU = G.GRU_CODGRU)');
    qryProdutos.SQL.Add('WHERE TRUE');

    if not fEmptyStr(edtCodGru.Text) then
    begin
      if RightStr(edtCodGru.Text,3) = '000' then
        qryProdutos.SQL.Add('AND LEFT(ITE_CODGRU,3) = LEFT('+QuotedStr(edtCodGru.Text)+',3)')
      else
        qryProdutos.SQL.Add('AND I.ITE_CODGRU = '+QuotedStr(edtCodGru.Text)+'');
    end;

    if not fEmptyStr(edtCodUni.Text) then
      qryProdutos.SQL.Add('AND I.ITE_CODUNI = '+QuotedStr(edtCodUni.Text)+'');

    if not fEmptyStr(edtCodIte.Text) then
      qryProdutos.SQL.Add('AND I.ITE_CODITE = '+QuotedStr(edtCodIte.Text)+'');

    qryProdutos.Open;

    if qryProdutos.IsEmpty then
    begin
      pMensagemOk('Nenhum produto encontrado para os filtros informados');
      Exit;
    end;

    while not qryProdutos.Eof do
    begin
      if fFaixaExiste(qryProdutos.FieldByName('ITE_CODITE').AsString, StrToFloatDef(edtDesIni.Text, 0), StrToFloatDef(edtDesFin.Text, 0), edtTabPre.Text) then
        strItemFaixa := strItemFaixa + Concat(qryProdutos.FieldByName('ITE_CODITE').AsString,'-',qryProdutos.FieldByName('ITE_DESITE').AsString) + sLineBreak
      else
      begin
        pAdicionarGrupo(qryProdutos.FieldByName('ITE_CODGRU').AsString,
                        qryProdutos.FieldByName('GRU_DESGRU').AsString,
                        StrToFloatDef(edtDesIni.Text, 0),
                        StrToFloatDef(edtDesFin.Text, 0),
                        StrToFloatDef(edtComissao.Text, 0),
                        qryProdutos.FieldByName('ITE_CODITE').AsString,
                        qryProdutos.FieldByName('ITE_CODUNI').AsString,
                        edtTabPre.Text);
      end;

      qryProdutos.Next;
    end;

    If (Not fEmptyStr(strItemFaixa)) Then
    Begin
      TfrmObservacao.fObservacao('A faixa preenchida do(s) item(ns) abaixo já existe em outro intervalo!', strItemFaixa);
    End
    Else
    Begin
      pLimparDadosGrupo;
      pSetFocus(edtCodGru);
      pHabilitar(False);

      If (cdsGrupo.RecordCount > 0) Then
        cdsGrupo.First;
    End;
  finally
    FreeAndNil(qryProdutos);
    cdsGrupo.EnableControls;
  end;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.pAdicionarSubGerente(strCodSub,
  strNomSub: String);
begin
  cdsSubGerente.Append;
  cdsSubGerenteHlS_CODSUB.AsString := strCodSub;
  cdsSubGerenteHLS_NOMSUB.AsString := strNomSub;
  cdsSubGerente.Post;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.pAdicionarGrupo(strCodGru,
  strDesGru: String; fltDesIni, fltDesFin, fltComis: Double; strCodIte,
  strCodUni, strTabPre: String);
begin
  If (blnAltLinGru) Then
    cdsGrupo.Edit
  Else
    cdsGrupo.Append;

  cdsGrupoHLS_CODGRU.AsString := strCodGru;
  cdsGrupoHLS_DESGRU.AsString := strDesGru;
  cdsGrupoHLS_DESINI.AsFloat  := fltDesIni;
  cdsGrupoHLS_DESFIN.AsFloat  := fltDesFin;
  cdsGrupoHLS_PERCOM.AsFloat  := fltComis;
  cdsGrupoHLS_CODITE.AsString := strCodIte;
  cdsGrupoHLS_CODUNI.AsString := strCodUni;
  cdsGrupoHLS_DESITE.AsString := Concat(strCodIte,'-',fRetNomProduto(strCodIte));
  cdsGrupoHLS_TABPRE.AsString := strTabPre;
  cdsGrupo.Post;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.pCadastrarHierarquia;
var
  qryCadastro : TUniQuery;
begin
  qryCadastro := fCriaQuery(Self);
  Try
    If blnAlterando Then
    Begin
      qryCadastro.SQL.Clear;
      qryCadastro.SQL.Add('DELETE FROM COMHL5 WHERE HL5_CODTAB = :CODTAB');
      qryCadastro.ParamByName('CODTAB').AsString := edtCodTab.Text;
      qryCadastro.ExecSQL;
    End;

    qryCadastro.Close;
    qryCadastro.SQL.Clear;
    qryCadastro.SQL.Add('SELECT * FROM COMHL5 WHERE FALSE');
    qryCadastro.Open;

    qryCadastro.Append;
    qryCadastro.FieldByName('HL5_CODTAB').AsString := edtCodTab.Text;
    qryCadastro.FieldByName('HL5_DESCRI').AsString := edtDescri.Text;
    qryCadastro.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMHL5', '');
    qryCadastro.Post;

    strCodTabSel := edtCodTab.Text;
  Finally
    FreeAndNil(qryCadastro);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.pCarregarSubGerentes(
  strCodTab: String);
var
  qryHLS : TUniQuery;
begin
  inherited;

  qryHLS := fCriaQuery;
  Try
    qryHLS.SQL.Clear;
    qryHLS.SQL.Add(' SELECT COMHLS.AUTOINCREM, COMHLS.HLS_CODSUB, CADOPE.OPE_NOMOPE ');
    qryHLS.SQL.Add(' FROM COMHLS ');
    qryHLS.SQL.Add(' INNER JOIN CADOPE ON COMHLS.HLS_CODSUB = CADOPE.OPE_CODOPE ');
    qryHLS.SQL.Add(' WHERE COMHLS.HLS_CODTAB = :CODTAB ');
    qryHLS.ParamByName('CODTAB').AsString := strCodTab;
    qryHLS.Open;

    qryHLS.First;
    While Not qryHLS.Eof Do
    Begin
      pAdicionarSubGerente(qryHLS.FieldByName('HLS_CODSUB').AsString, qryHLS.FieldByName('OPE_NOMOPE').AsString);

      qryHLS.Next;
    End;
  Finally
    FreeAndNil(qryHLS);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.pCarregaTabelaPrecos;
  Var
    intCon: Integer;
begin
  If Not clbPrcVenda.Visible Then
    Exit;

  strVrfTpr := EmptyStr;
  clbPrcVenda.Caption := EmptyStr;

  For intCon:= 1 To Length(Trim(VS_strTabPrc)) Do
  Begin
    strVrfTpr := strVrfTpr + IfThen(SameText(VS_strTabPrc[intCon], 'S'), IntToStr(intCon), '');
    If (VS_strTabPrc[intCon] = 'S') Then
    Begin
      clbPrcVenda.Caption := clbPrcVenda.Caption + ' (' + IntToStr(intCon) + ')';
    End;
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.pCarregarGrupos(
  strCodTab: String);
var
  qryFaixa : TUniQuery;
begin
  inherited;

  qryFaixa := fCriaQuery;
  Try
    qryFaixa.SQL.Clear;
    qryFaixa.SQL.Add(' SELECT HLSFAI.*, CADGRU.GRU_DESGRU ');
    qryFaixa.SQL.Add(' FROM HLSFAI ');
    qryFaixa.SQL.Add(' INNER JOIN CADGRU ON HLS_CODGRU = GRU_CODGRU ');
    qryFaixa.SQL.Add(' WHERE HLS_CODTAB = :CODTAB ');
    qryFaixa.ParamByName('CODTAB').AsString := strCodTab;
    qryFaixa.Open;

    qryFaixa.First;
    While Not qryFaixa.Eof Do
    Begin
      pAdicionarGrupo(qryFaixa.FieldByName('HLS_CODGRU').AsString,
                      qryFaixa.FieldByName('GRU_DESGRU').AsString,
                      qryFaixa.FieldByName('HLS_DESINI').AsFloat,
                      qryFaixa.FieldByName('HLS_DESFIN').AsFloat,
                      qryFaixa.FieldByName('HLS_PERCOM').AsFloat,
                      qryFaixa.FieldByName('HLS_CODITE').AsString,
                      qryFaixa.FieldByName('HLS_CODUNI').AsString,
                      qryFaixa.FieldByName('HLS_TABPRE').AsString);

      qryFaixa.Next;
    End;
  Finally
    FreeAndNil(qryFaixa);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.pHabilitar(
  blnHabilitar: Boolean);
begin
  btnIncluir.Enabled  := blnHabilitar;
  btnGravar.Enabled   := Not blnHabilitar;
  btnExcluir.Enabled  := blnHabilitar;
  btnCancela.Enabled  := Not blnHabilitar;
  btnPesquisa.Enabled := blnHabilitar;

  edtCodTab.Enabled := Not blnHabilitar;
  edtDescri.Enabled := Not blnHabilitar;
  edtCodSub.Enabled := Not blnHabilitar;
  cxgSubGerentes.Enabled := Not blnHabilitar;
  btnConfirmarSubGerente.Enabled := Not blnHabilitar;

  edtCodGru.Enabled := Not blnHabilitar;
  edtCodUni.Enabled := Not blnHabilitar;
  edtCodIte.Enabled := Not blnHabilitar;
  edtDesIni.Enabled := Not blnHabilitar;
  edtDesFin.Enabled := Not blnHabilitar;
  edtComissao.Enabled := Not blnHabilitar;
  cxgGrupos.Enabled   := Not blnHabilitar;
  btnConfirmarLinha.Enabled := Not blnHabilitar;
  edtTabPre.Enabled := Not blnHabilitar;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.pLimparDadosSubGerente;
begin
  edtCodSub.Clear;
  edtNomSub.Clear;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.pLimparDadosGrupo;
begin
  edtCodGru.Clear;
  edtDesGru.Clear;
  edtCodUni.Clear;
  edtSigUni.Clear;
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtDesIni.Text := '0,00';
  edtDesFin.Text := '0,00';
  edtComissao.Text := '0,00';
  blnAltLinGru := False;
  cxgGrupos.Enabled := True;
  edtTabPre.Clear;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.pLimparTela;
begin
  strCodTabSel := '';
  cdsSubGerente.EmptyDataSet;
  cdsGrupo.EmptyDataSet;

  edtCodTab.Clear;
  edtDescri.Clear;

  pLimparDadosSubGerente;
  pLimparDadosGrupo;

  pSetFocus(edtCodTab);
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.pVincularGrupos;
var
  qryGrupo : TUniQuery;
begin
  qryGrupo := fCriaQuery(Self);
  Try
    qryGrupo.Close;
    qryGrupo.SQL.Clear;
    qryGrupo.SQL.Add('SELECT * FROM HLSFAI WHERE FALSE');
    qryGrupo.Open;

    cdsGrupo.First;
    While (Not cdsGrupo.Eof) Do
    Begin
      qryGrupo.Append;
      qryGrupo.FieldByName('HLS_CODTAB').AsString := edtCodTab.Text;
      qryGrupo.FieldByName('HLS_CODGRU').AsString := cdsGrupoHLS_CODGRU.AsString;
      qryGrupo.FieldByName('HLS_DESINI').AsFloat  := cdsGrupoHLS_DESINI.AsFloat;
      qryGrupo.FieldByName('HLS_DESFIN').AsFloat  := cdsGrupoHLS_DESFIN.AsFloat;
      qryGrupo.FieldByName('HLS_PERCOM').AsFloat  := cdsGrupoHLS_PERCOM.AsFloat;
      qryGrupo.FieldByName('HLS_CODITE').AsString := cdsGrupoHLS_CODITE.AsString;
      qryGrupo.FieldByName('HLS_CODUNI').AsString := cdsGrupoHLS_CODUNI.AsString;
      qryGrupo.FieldByName('HLS_TABPRE').AsString := cdsGrupoHLS_TABPRE.AsString;
      qryGrupo.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('HLSFAI', '');
      qryGrupo.Post;

      cdsGrupo.Next;
    End;
  Finally
    FreeAndNil(qryGrupo);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.pVincularSubGerentes;
var
  qrySubGerente : TUniQuery;
begin
  qrySubGerente := fCriaQuery(Self);
  Try
    qrySubGerente.Close;
    qrySubGerente.SQL.Clear;
    qrySubGerente.SQL.Add('SELECT * FROM COMHLS WHERE FALSE');
    qrySubGerente.Open;

    cdsSubGerente.First;
    While (Not cdsSubGerente.Eof) Do
    Begin
      qrySubGerente.Append;
      qrySubGerente.FieldByName('HLS_CODTAB').AsString := edtCodTab.Text;
      qrySubGerente.FieldByName('HLS_CODSUB').AsString := cdsSubGerenteHLS_CODSUB.AsString;
      qrySubGerente.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMHLS', '');
      qrySubGerente.Post;

      cdsSubGerente.Next;
    End;
  Finally
    FreeAndNil(qrySubGerente);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoSubGerente.pMoveItemParaEdicao;
begin
  edtCodGru.Text   := cdsGrupoHLS_CODGRU.AsString;
  edtDesGru.Text   := fRetNomeLinhaGrupo(cdsGrupoHLS_CODGRU.AsString);
  edtCodUni.Text   := cdsGrupoHLS_CODUNI.AsString;
  edtSigUni.Text   := fRetSiglaUnidade(cdsGrupoHLS_CODUNI.AsString);
  edtCodIte.Text   := cdsGrupoHLS_CODITE.AsString;
  edtDesIte.Text   := fRetNomProduto(cdsGrupoHLS_CODITE.AsString);
  edtDesIni.Text   := FormatFloat(fMskDigitos(4),cdsGrupoHLS_DESINI.AsFloat);
  edtDesFin.Text   := FormatFloat(fMskDigitos(4),cdsGrupoHLS_DESFIN.AsFloat);
  edtComissao.Text := FormatFloat(fMskDigitos(4),cdsGrupoHLS_PERCOM.AsFloat);
  edtTabPre.Text   := cdsGrupoHLS_TABPRE.AsString;
end;

end.
