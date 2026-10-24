unit untCadFaixaDescontoLinhaGrupoGerente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, Uni, untConsultas, StrUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  EditFocus, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, untFuncoesConsulta, cxProgressBar, untGravando, QColorLabel;

type
  TfrmCadFaixaDescontoLinhaGrupoGerente = class(TfrmPai)
    pnlAtalho01: TPanel;
    lblAtalho01: TLabel;
    pnlAtalho02: TPanel;
    lblAtalho02: TLabel;
    cxgGrupos: TcxGrid;
    cxGridDBTvGrupos: TcxGridDBTableView;
    cxgGruposDBDESITE: TcxGridDBColumn;
    cxgGruposDBDESINI: TcxGridDBColumn;
    cxgGruposDBDESFIN: TcxGridDBColumn;
    cxgGruposDBPERCOM: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnlCadGrupo: TPanel;
    lblLinhaGrupo: TLabel;
    lblDesIni: TLabel;
    lblDesFin: TLabel;
    lblComissao: TLabel;
    edtCodGru: TEditFocus;
    edtDesGru: TEditFocus;
    btnConfirmarLinha: TBitBtnLocked;
    edtDesIni: TEditFocus;
    edtDesFin: TEditFocus;
    edtComissao: TEditFocus;
    pnlCabecalho: TPanel;
    lblGerente: TLabel;
    edtCodGer: TEditFocus;
    edtNomGer: TEditFocus;
    btnConfirmarGerente: TBitBtnLocked;
    edtDescri: TEditFocus;
    cxgGerentes: TcxGrid;
    cxGridDBTvGerentes: TcxGridDBTableView;
    cxgGerentesDBCODGER: TcxGridDBColumn;
    cxgGerentesDBNOMGER: TcxGridDBColumn;
    cxgGerentesLevel1: TcxGridLevel;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    dtsGerente: TDataSource;
    cdsGerente: TUniClientDataSet;
    cdsGerenteHLG_CODTAB: TStringField;
    cdsGerenteHLG_NOMGER: TStringField;
    cdsGerenteAUTOINCREM: TStringField;
    dtsGrupo: TDataSource;
    cdsGrupo: TUniClientDataSet;
    cdsGrupoHLG_CODTAB: TStringField;
    cdsGrupoHLG_CODGRU: TStringField;
    cdsGrupoHLG_DESGRU: TStringField;
    cdsGrupoHLG_DESINI: TFloatField;
    cdsGrupoHLG_DESFIN: TFloatField;
    cdsGrupoHLG_PERCOM: TFloatField;
    cdsGrupoAUTOINCREM : TStringField;
    lblCodTab: TLabel;
    lblDescri: TLabel;
    edtCodTab: TEditFocus;
    cdsGerenteHLG_CODGER: TStringField;
    Bevel1: TBevel;
    Label2: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label1: TLabel;
    edtCodUni: TEditFocus;
    edtSigUni: TEditFocus;
    cdsGrupoHLG_CODITE: TStringField;
    cdsGrupoHLG_DESITE: TStringField;
    cdsGrupoHLG_CODUNI: TStringField;
    lblTabPre: TLabel;
    edtTabPre: TEditFocus;
    clbPrcVenda: TColorLabel;
    cdsGrupoHLG_TABPRE: TStringField;
    cxgGruposDBTABPRE: TcxGridDBColumn;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodGerKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarGerenteClick(Sender: TObject);
    procedure cxGridDBTvGerentesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarLinhaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtNomGerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxGridDBTvGruposKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGerExit(Sender: TObject);
    procedure cxGridDBTvGruposDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    blnInserindo: Boolean;
    blnAlterando: Boolean;
    arrGerentes: TConsultasArray;
    strCodTabSel: String;
    blnAltLinGru: Boolean;
    strVrfTpr: String;

    procedure pLimparDadosGerente;
    procedure pLimparDadosGrupo;
    procedure pLimparTela;
    procedure pHabilitar(blnHabilitar: Boolean);
    procedure pAdicionarGerente(strCodGer, strNomGer: String);
    function fGerenteAdicionado(strCodGer: String): Boolean;
    procedure pAdicionarGrupo(strCodGru, strDesGru: String; fltDesIni,
      fltDesFin, fltComis: Double; strCodIte, strCodUni, strTabPre: String);
    function fFaixaExiste(strCodIte: String; fltDesIni,
      fltDesFin: Double; strTabPre: String): Boolean;
    function fHierarquiaExiste(strCodTab: String): Boolean;
    procedure pCadastrarHierarquia;
    procedure pVincularGerentes;
    procedure pVincularGrupos;
    procedure pCarregarGerentes(strCodTab: String);
    procedure pCarregarGrupos(strCodTab: String);
    function fExcluir(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fGerenteEmOutraHierarquia(strCodGer, strCodTab: String): Boolean;
    procedure pAdicionaProdutos;
    procedure pMoveItemParaEdicao;
    procedure pCarregaTabelaPrecos;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untObservacao;

{$R *.dfm}

{ TfrmCadFaixaDescontoLinhaGrupoGerente1 }

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.btnAlterarClick(
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

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.btnCancelaClick(
  Sender: TObject);
begin
  inherited;
  pLimparTela;

  pHabilitar(True);
  blnInserindo := False;
  blnAlterando := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.btnConfirmarGerenteClick(
  Sender: TObject);
  Var
    qryGer : TUniQuery;
    strCodGer : String;
    arrGerentesEmOutrasHierarquias : Array Of String;
begin
  inherited;

  SetLength(arrGerentesEmOutrasHierarquias, 0);

  If fValidaCampos(edtCodGer) Then
  Begin
    If Length(arrGerentes) > 1 Then
    Begin
      qryGer := fCriaQuery;
      Try
        qryGer.SQL.Clear;
        qryGer.SQL.Add(' SELECT OPE_CODOPE, OPE_NOMOPE ');
        qryGer.SQL.Add(' FROM CADOPE ');
        qryGer.SQL.Add(' WHERE ' + fStrLocate(edtCodGer, arrGerentes, 'OPE_CODOPE', 'CODOPE', True));
        pSetaParam(edtCodGer.Text, arrGerentes, strCodGer, 'CODOPE', qryGer);
        qryGer.Open;

        qryGer.First;
        While Not qryGer.Eof Do
        Begin
          If fGerenteEmOutraHierarquia(qryGer.FieldByName('OPE_CODOPE').AsString, strCodTabSel) Then
          Begin
           SetLength(arrGerentesEmOutrasHierarquias, Length(arrGerentesEmOutrasHierarquias)+1);
           arrGerentesEmOutrasHierarquias[Length(arrGerentesEmOutrasHierarquias)-1] := qryGer.FieldByName('OPE_CODOPE').AsString;
          End
          Else If Not fGerenteAdicionado(qryGer.FieldByName('OPE_CODOPE').AsString) Then
            pAdicionarGerente(qryGer.FieldByName('OPE_CODOPE').AsString, qryGer.FieldByName('OPE_NOMOPE').AsString);

          qryGer.Next;
        End;
      Finally
        FreeAndNil(qryGer);
      End;

      If Length(arrGerentesEmOutrasHierarquias) > 0 Then
      Begin
        If Length(arrGerentesEmOutrasHierarquias) < Length(arrGerentes) Then
          pMensagemOk('Gerentes inseridos com sucesso, com exceção de: ['+fOrganizaArrayComVirgula(arrGerentesEmOutrasHierarquias)+'] que já foram adicionados a outra hierarquia!')
        Else
          pMensagemOk('Os gerentes selecionados não foram adicionados, pois, se encontram em outra hierarquia!');
      End;

      SetLength(arrGerentes, 0);
    End
    Else
    Begin
      If fGerenteEmOutraHierarquia(edtCodGer.Text, strCodTabSel) Then
        pMensagemOk('Esse gerente já foi adicionado a outra hierarquia!')
      Else If Not fGerenteAdicionado(edtCodGer.Text) Then
        pAdicionarGerente(edtCodGer.Text, edtNomGer.Text)
      Else
        pMensagemOk('Esse gerente já foi adicionado!');
    End;

    pLimparDadosGerente;
    pSetFocus(edtCodGer);

    pHabilitar(False);
  End;
end;

function TfrmCadFaixaDescontoLinhaGrupoGerente.fGerenteAdicionado(strCodGer: String):Boolean;
begin
  cdsGerente.DisableControls;
  Try
    cdsGerente.Filter := 'HLG_CODGER = ' + QuotedStr(strCodGer);
    cdsGerente.Filtered := True;
    Result := Not cdsGerente.IsEmpty;
  Finally
    cdsGerente.Filtered := False;
    cdsGerente.EnableControls;
  End;
end;

function TfrmCadFaixaDescontoLinhaGrupoGerente.fGerenteEmOutraHierarquia(
  strCodGer, strCodTab: String): Boolean;
  Var
    qryGer : TUniQuery;
begin
  qryGer := fCriaQuery;
  Try
    qryGer.SQL.Clear;
    qryGer.SQL.Add(' SELECT HLG_CODTAB ');
    qryGer.SQL.Add(' FROM COMHLG ');
    qryGer.SQL.Add(' WHERE HLG_CODGER = :CODGER ');
    qryGer.ParamByName('CODGER').AsString := strCodGer;
    qryGer.Open;

    If (Not qryGer.IsEmpty) Then
      Result := qryGer.FieldByName('HLG_CODTAB').AsString <> strCodTab
    Else
      Result := False;
  Finally
    FreeAndNil(qryGer);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.pAdicionaProdutos;
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

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.pAdicionarGerente(strCodGer: String; strNomGer: String);
begin
  cdsGerente.Append;
  cdsGerenteHLG_CODGER.AsString := strCodGer;
  cdsGerenteHLG_NOMGER.AsString := strNomGer;
  cdsGerente.Post;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.btnConfirmarLinhaClick(
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

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.btnExcluirClick(
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
        pMensagensErro(E.Message,'[TfrmCadFaixaDescontoLinhaGrupoGerente.btnExcluirClick]');
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

function TfrmCadFaixaDescontoLinhaGrupoGerente.fExcluir(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('DELETE FROM COMHL3 WHERE HL3_CODTAB = :CODTAB');
    qryGen.ParamByName('CODTAB').AsString := strCodTabSel;
    qryGen.ExecSQL;

    pLimparTela;
  Finally
    FreeAndNil(qryGen);
  End;

  Result := True;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.pCadastrarHierarquia;
  Var
    qryCadastro : TUniQuery;
begin
  qryCadastro := fCriaQuery(Self);
  Try
    If blnAlterando Then
    Begin
      qryCadastro.SQL.Clear;
      qryCadastro.SQL.Add('DELETE FROM COMHL3 WHERE HL3_CODTAB = :CODTAB');
      qryCadastro.ParamByName('CODTAB').AsString := edtCodTab.Text;
      qryCadastro.ExecSQL;
    End;

    qryCadastro.Close;
    qryCadastro.SQL.Clear;
    qryCadastro.SQL.Add('SELECT * FROM COMHL3 WHERE FALSE');
    qryCadastro.Open;

    qryCadastro.Append;
    qryCadastro.FieldByName('HL3_CODTAB').AsString := edtCodTab.Text;
    qryCadastro.FieldByName('HL3_DESCRI').AsString := edtDescri.Text;
    qryCadastro.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMHL3', '');
    qryCadastro.Post;

    strCodTabSel := edtCodTab.Text;
  Finally
    FreeAndNil(qryCadastro);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.pVincularGerentes;
  Var
    qryGerente : TUniQuery;
begin
  qryGerente := fCriaQuery(Self);
  Try
    qryGerente.Close;
    qryGerente.SQL.Clear;
    qryGerente.SQL.Add('SELECT * FROM COMHLG WHERE FALSE');
    qryGerente.Open;

    cdsGerente.First;
    While (Not cdsGerente.Eof) Do
    Begin
      qryGerente.Append;
      qryGerente.FieldByName('HLG_CODTAB').AsString := edtCodTab.Text;
      qryGerente.FieldByName('HLG_CODGER').AsString := cdsGerenteHLG_CODGER.AsString;
      qryGerente.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMHLG', '');
      qryGerente.Post;

      cdsGerente.Next;
    End;
  Finally
    FreeAndNil(qryGerente);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.pVincularGrupos;
  Var
    qryGrupo : TUniQuery;
begin
  qryGrupo := fCriaQuery(Self);
  Try
    qryGrupo.Close;
    qryGrupo.SQL.Clear;
    qryGrupo.SQL.Add('SELECT * FROM HLGFAI WHERE FALSE');
    qryGrupo.Open;

    cdsGrupo.First;
    While (Not cdsGrupo.Eof) Do
    Begin
      qryGrupo.Append;
      qryGrupo.FieldByName('HLG_CODTAB').AsString := edtCodTab.Text;
      qryGrupo.FieldByName('HLG_CODGRU').AsString := cdsGrupoHLG_CODGRU.AsString;
      qryGrupo.FieldByName('HLG_DESINI').AsFloat  := cdsGrupoHLG_DESINI.AsFloat;
      qryGrupo.FieldByName('HLG_DESFIN').AsFloat  := cdsGrupoHLG_DESFIN.AsFloat;
      qryGrupo.FieldByName('HLG_PERCOM').AsFloat  := cdsGrupoHLG_PERCOM.AsFloat;
      qryGrupo.FieldByName('HLG_CODITE').AsString := cdsGrupoHLG_CODITE.AsString;
      qryGrupo.FieldByName('HLG_CODUNI').AsString := cdsGrupoHLG_CODUNI.AsString;
      qryGrupo.FieldByName('HLG_TABPRE').AsString := cdsGrupoHLG_TABPRE.AsString;
      qryGrupo.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('HLGFAI', '');
      qryGrupo.Post;

      cdsGrupo.Next;
    End;
  Finally
    FreeAndNil(qryGrupo);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.btnGravarClick(Sender: TObject);
begin
  inherited;

  If (Not fValidaCampos(edtCodTab)) Or (Not fValidaCampos(edtDescri)) Then
    Exit;

  If (cdsGerente.IsEmpty) Or (cdsGrupo.IsEmpty) Then
  Begin
    fMensagem('Atenção!', 'É necessário informar Gerentes e grupos!', ['&Ok']);
    Exit;
  End;

  fStartTransaction;
  Try
    pCadastrarHierarquia;
    pVincularGerentes;
    pVincularGrupos;
    fCommit;

    pHabilitar(True);
    blnInserindo := False;
    blnAlterando := False;
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '[TfrmCadFaixaDescontoLinhaGrupoGerente.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.pAdicionarGrupo(strCodGru: String;
                                                                strDesGru: String;
                                                                fltDesIni: Double;
                                                                fltDesFin: Double;
                                                                fltComis: Double;
                                                                strCodIte: String;
                                                                strCodUni: String;
                                                                strTabPre: String);
begin
  If (blnAltLinGru) Then
    cdsGrupo.Edit
  Else
    cdsGrupo.Append;

  cdsGrupoHLG_CODGRU.AsString := strCodGru;
  cdsGrupoHLG_DESGRU.AsString := strDesGru;
  cdsGrupoHLG_DESINI.AsFloat  := fltDesIni;
  cdsGrupoHLG_DESFIN.AsFloat  := fltDesFin;
  cdsGrupoHLG_PERCOM.AsFloat  := fltComis;
  cdsGrupoHLG_CODITE.AsString := strCodIte;
  cdsGrupoHLG_CODUNI.AsString := strCodUni;
  cdsGrupoHLG_DESITE.AsString := Concat(strCodIte,'-',fRetNomProduto(strCodIte));
  cdsGrupoHLG_TABPRE.AsString := strTabPre;
  cdsGrupo.Post;
end;

function TfrmCadFaixaDescontoLinhaGrupoGerente.fFaixaExiste(strCodIte: String;
                                                            fltDesIni: Double;
                                                            fltDesFin: Double;
                                                            strTabPre: String) : Boolean;
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
      If (cdsGrupo.FieldByName('HLG_CODITE').AsString <> strCodIte) Or
        ((blnAltLinGru) And (cdsGrupo.RecNo = intRecNo)) Then
      Begin
        cdsGrupo.Next;
        Continue;
      End;

      If (fltDesIni >= cdsGrupo.FieldByName('HLG_DESINI').AsFloat) And (fltDesIni <= cdsGrupo.FieldByName('HLG_DESFIN').AsFloat) Then
        Result := True
      Else If (fltDesFin >= cdsGrupo.FieldByName('HLG_DESINI').AsFloat) And (fltDesFin <= cdsGrupo.FieldByName('HLG_DESFIN').AsFloat) Then
        Result := True
      Else If (fltDesIni <= cdsGrupo.FieldByName('HLG_DESINI').AsFloat) And (fltDesFin >= cdsGrupo.FieldByName('HLG_DESFIN').AsFloat) Then
        Result := True;

      If (Result) And (Not fEmptyStr(strTabPre)) And (strTabPre <> cdsGrupo.FieldByName('HLG_TABPRE').AsString) Then
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

function TfrmCadFaixaDescontoLinhaGrupoGerente.fHierarquiaExiste(strCodTab: String): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT * FROM COMHL3 WHERE HL3_CODTAB = :CODTAB');
    qryGen.ParamByName('CODTAB').AsString := strCodTab;
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.btnIncluirClick(
  Sender: TObject);
begin
  inherited;
  pHabilitar(False);
  pLimparTela;

  blnInserindo := True;
  blnAlterando := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.pCarregarGerentes(strCodTab: String);
  Var
    qryHLG : TUniQuery;
begin
  inherited;

  qryHLG := fCriaQuery;
  Try
    qryHLG.SQL.Clear;
    qryHLG.SQL.Add(' SELECT COMHLG.AUTOINCREM, COMHLG.HLG_CODGER, CADOPE.OPE_NOMOPE ');
    qryHLG.SQL.Add(' FROM COMHLG ');
    qryHLG.SQL.Add(' INNER JOIN CADOPE ON COMHLG.HLG_CODGER = CADOPE.OPE_CODOPE ');
    qryHLG.SQL.Add(' WHERE COMHLG.HLG_CODTAB = :CODTAB ');
    qryHLG.ParamByName('CODTAB').AsString := strCodTab;
    qryHLG.Open;

    qryHLG.First;
    While Not qryHLG.Eof Do
    Begin
      pAdicionarGerente(qryHLG.FieldByName('HLG_CODGER').AsString, qryHLG.FieldByName('OPE_NOMOPE').AsString);

      qryHLG.Next;
    End;
  Finally
    FreeAndNil(qryHLG);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.pCarregarGrupos(strCodTab: String);
  Var
    qryFaixa : TUniQuery;
begin
  inherited;

  qryFaixa := fCriaQuery;
  Try
    qryFaixa.SQL.Clear;
    qryFaixa.SQL.Add(' SELECT HLGFAI.*, CADGRU.GRU_DESGRU ');
    qryFaixa.SQL.Add(' FROM HLGFAI ');
    qryFaixa.SQL.Add(' INNER JOIN CADGRU ON HLG_CODGRU = GRU_CODGRU ');
    qryFaixa.SQL.Add(' WHERE HLG_CODTAB = :CODTAB ');
    qryFaixa.ParamByName('CODTAB').AsString := strCodTab;
    qryFaixa.Open;

    qryFaixa.First;
    While Not qryFaixa.Eof Do
    Begin
      pAdicionarGrupo(qryFaixa.FieldByName('HLG_CODGRU').AsString,
                      qryFaixa.FieldByName('GRU_DESGRU').AsString,
                      qryFaixa.FieldByName('HLG_DESINI').AsFloat,
                      qryFaixa.FieldByName('HLG_DESFIN').AsFloat,
                      qryFaixa.FieldByName('HLG_PERCOM').AsFloat,
                      qryFaixa.FieldByName('HLG_CODITE').AsString,
                      qryFaixa.FieldByName('HLG_CODUNI').AsString,
                      qryFaixa.FieldByName('HLG_TABPRE').AsString);

      qryFaixa.Next;
    End;
  Finally
    FreeAndNil(qryFaixa);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.pCarregaTabelaPrecos;
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

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.btnPesquisaClick(
  Sender: TObject);
  Var
    qryConsulta : TUniQuery;
    arrSel : TConsultasArray;
    strSQL : String;
begin
  inherited;

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  HL3_CODTAB, ';
  strSQL := strSQL + '  HL3_DESCRI, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  COMHL3 ';

  qryConsulta := fCriaQuery;
  Try
    If fConsulta([strSQL],
                 ['Código', 'Descrição'],
                 ['HL3_CODTAB', 'HL3_DESCRI'],
                 'AUTOINCREM',
                 'COMHL3',
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
      strCodTabSel   := qryConsulta.FieldByName('HL3_CODTAB').AsString;

      edtCodTab.Text := strCodTabSel;
      edtDescri.Text := qryConsulta.FieldByName('HL3_DESCRI').AsString;

      pCarregarGerentes(strCodTabSel);
      pCarregarGrupos(strCodTabSel);
      cxgGrupos.Enabled := False;
    End
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.cxGridDBTvGerentesKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_DELETE Then
    If (Not cdsGerente.IsEmpty) And (blnInserindo Or blnAlterando) Then
      cdsGerente.Delete;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.cxGridDBTvGruposDblClick(
  Sender: TObject);
begin
  inherited;
  pMoveItemParaEdicao;
  cxgGrupos.Enabled := False;
  blnAltLinGru := True;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.cxGridDBTvGruposKeyDown(
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

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.edtCodGerExit(Sender: TObject);
begin
  inherited;

  if not fEmptyStr(edtCodGer.Text) then
  begin
    edtCodGer.Text := fStrZero(edtCodGer.Text, edtCodGer.TamCampo);
    edtNomGer.Text := fRetNomeOperador(edtCodGer.Text);
  end;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.edtCodGerKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  if fPesqOperador(Self, edtCodGer, edtNomGer, Nil, Key, arrGerentes, False, True, True) then
  Begin
    If fValidaCampos(edtCodGer) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.edtCodGruKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;

  If (fPesqGrupo(Self, edtCodGru, edtDesGru, Nil, Key, arrGrupos, True)) Then
  Begin
    If fValidaCampos(edtCodGru) Then
      SelectNext(ActiveControl, True, True);
  End
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.edtCodIteKeyPress(
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

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.edtCodUniKeyPress(
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

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.edtNomGerKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    btnConfirmarGerente.Click;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.FormCreate(Sender: TObject);
begin
  inherited;
  cdsGerente.CreateDataSet;
  cdsGrupo.CreateDataSet;

  pHabilitar(True);

  strCodTabSel := '';
  blnAltLinGru := False;
  cxgGrupos.Enabled := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.FormShow(Sender: TObject);
begin
  inherited;
  lblTabPre.Visible := fCfgSis('TPCHFD', varBoolean);
  edtTabPre.Visible := lblTabPre.Visible;
  clbPrcVenda.Visible := lblTabPre.Visible;
  cxgGruposDBTABPRE.Visible := lblTabPre.Visible;
  pCarregaTabelaPrecos;
end;

function TfrmCadFaixaDescontoLinhaGrupoGerente.fValidaCampos(
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
    Else If (Sender = edtCodGer) Then
    Begin
      If (fEmptyStr(edtCodGer.Text)) Then
      Begin
        fMensagem('AVISO','Código do Gerente deve ser preenchido.', ['&OK']);
        Result := False;
      End
      Else If (edtCodGer.Text <> '00000000') And (edtNomGer.Text <> '+1') Then
      Begin
        edtNomGer.Text := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE', 'OPE_STATUS', 'OPE_INTEXT'], [edtCodGer.Text, 'A', 'G']);

        If (fEmptyStr(edtNomGer.Text)) Then
        Begin
          fMensagem('AVISO','Código do Gerente não encontrado.', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodGru) And (Not fEmptyStr(edtCodGru.Text)) Then
    Begin
      If (edtCodGru.Text <> '00000000') And (edtDesGru.Text <> '+1') Then
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

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.pHabilitar(
  blnHabilitar: Boolean);
begin
  btnIncluir.Enabled  := blnHabilitar;
  btnGravar.Enabled   := Not blnHabilitar;
  btnExcluir.Enabled  := blnHabilitar;
  btnCancela.Enabled  := Not blnHabilitar;
  btnPesquisa.Enabled := blnHabilitar;

  edtCodTab.Enabled := Not blnHabilitar;
  edtDescri.Enabled := Not blnHabilitar;
  edtCodGer.Enabled := Not blnHabilitar;
  cxgGerentes.Enabled := Not blnHabilitar;
  btnConfirmarGerente.Enabled := Not blnHabilitar;

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

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.pLimparDadosGerente;
begin
  edtCodGer.Clear;
  edtNomGer.Clear;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.pLimparDadosGrupo;
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

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.pLimparTela;
begin
  strCodTabSel := '';
  cdsGerente.EmptyDataSet;
  cdsGrupo.EmptyDataSet;

  edtCodTab.Clear;
  edtDescri.Clear;

  pLimparDadosGerente;
  pLimparDadosGrupo;

  pSetFocus(edtCodTab);
end;

procedure TfrmCadFaixaDescontoLinhaGrupoGerente.pMoveItemParaEdicao;
begin
  edtCodGru.Text   := cdsGrupoHLG_CODGRU.AsString;
  edtDesGru.Text   := fRetNomeLinhaGrupo(cdsGrupoHLG_CODGRU.AsString);
  edtCodUni.Text   := cdsGrupoHLG_CODUNI.AsString;
  edtSigUni.Text   := fRetSiglaUnidade(cdsGrupoHLG_CODUNI.AsString);
  edtCodIte.Text   := cdsGrupoHLG_CODITE.AsString;
  edtDesIte.Text   := fRetNomProduto(cdsGrupoHLG_CODITE.AsString);
  edtDesIni.Text   := FormatFloat(fMskDigitos(4),cdsGrupoHLG_DESINI.AsFloat);
  edtDesFin.Text   := FormatFloat(fMskDigitos(4),cdsGrupoHLG_DESFIN.AsFloat);
  edtComissao.Text := FormatFloat(fMskDigitos(4),cdsGrupoHLG_PERCOM.AsFloat);
  edtTabPre.Text   := cdsGrupoHLG_TABPRE.AsString;
end;

end.
