unit untCadFaixaDescontoLinhaGrupo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, StrUtils,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, Uni, untConsultas,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  EditFocus, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, untFuncoesConsulta, cxProgressBar, untGravando, QColorLabel;

type
  TfrmCadFaixaDescontoLinhaGrupo = class(TfrmPai)
    pnlAtalho02: TPanel;
    lblAtalho02: TLabel;
    cxgGrupos: TcxGrid;
    cxGridDBTvGrupos: TcxGridDBTableView;
    cxgGruposDBDESITE: TcxGridDBColumn;
    cxgGruposDBDESINI: TcxGridDBColumn;
    cxgGruposDBDESFIN: TcxGridDBColumn;
    cxgGruposDBPERCOM: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnlCabecalho: TPanel;
    edtDescri: TEditFocus;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    dtsGrupo: TDataSource;
    cdsGrupo: TUniClientDataSet;
    cdsGrupoHLF_CODTAB: TStringField;
    cdsGrupoHLF_CODGRU: TStringField;
    cdsGrupoHLF_DESGRU: TStringField;
    cdsGrupoHLF_DESINI: TFloatField;
    cdsGrupoHLF_DESFIN: TFloatField;
    cdsGrupoHLF_PERCOM: TFloatField;
    cdsGrupoAUTOINCREM : TStringField;
    lblCodTab: TLabel;
    lblDescri: TLabel;
    edtCodTab: TEditFocus;
    Bevel1: TBevel;
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
    Label1: TLabel;
    edtCodUni: TEditFocus;
    edtSigUni: TEditFocus;
    Label2: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    cdsGrupoHLF_CODITE: TStringField;
    cdsGrupoHLF_DESITE: TStringField;
    cdsGrupoHLF_CODUNI: TStringField;
    lblTabPre: TLabel;
    edtTabPre: TEditFocus;
    clbPrcVenda: TColorLabel;
    cdsGrupoHLF_TABPRE: TStringField;
    cxgGruposDBTABPRE: TcxGridDBColumn;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarLinhaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxGridDBTvGruposKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure cxGridDBTvGruposDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    blnInserindo: Boolean;
    blnAlterando: Boolean;
    strCodTabSel: String;
    blnAltLinGru: Boolean;
    strVrfTpr: String;

    procedure pLimparDadosGrupo;
    procedure pLimparTela;
    procedure pHabilitar(blnHabilitar: Boolean);
    procedure pAdicionarGrupo(strCodGru, strDesGru: String; fltDesIni,
      fltDesFin, fltComis: Double; strCodIte, strCodUni, strTabPre: String);
    function fFaixaExiste(strCodIte: String; fltDesIni,
      fltDesFin: Double; strTabPre: String): Boolean;
    function fHierarquiaExiste(strCodTab: String): Boolean;
    procedure pCadastrarHierarquia;
    procedure pVincularGrupos;
    procedure pCarregarGrupos(strCodTab: String);
    function fExcluir(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fItemEmOutraHierarquia(strCodIte, strCodTab: String): Boolean;
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

{ TfrmCadFaixaDescontoLinhaGrupo1 }

procedure TfrmCadFaixaDescontoLinhaGrupo.btnAlterarClick(
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

procedure TfrmCadFaixaDescontoLinhaGrupo.btnCancelaClick(
  Sender: TObject);
begin
  inherited;
  pLimparTela;

  pHabilitar(True);
  blnInserindo := False;
  blnAlterando := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupo.btnConfirmarLinhaClick(
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

procedure TfrmCadFaixaDescontoLinhaGrupo.btnExcluirClick(
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
        pMensagensErro(E.Message,'[TfrmCadFaixaDescontoLinhaGrupo.btnExcluirClick]');
      End;
    End
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

function TfrmCadFaixaDescontoLinhaGrupo.fExcluir(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('DELETE FROM COMHL4 WHERE HL4_CODTAB = :CODTAB');
    qryGen.ParamByName('CODTAB').AsString := strCodTabSel;
    qryGen.ExecSQL;

    pLimparTela;
  Finally
    FreeAndNil(qryGen);
  End;

  Result := True;
end;

procedure TfrmCadFaixaDescontoLinhaGrupo.pCadastrarHierarquia;
  Var
    qryCadastro : TUniQuery;
begin
  qryCadastro := fCriaQuery(Self);
  Try
    If blnAlterando Then
    Begin
      qryCadastro.SQL.Clear;
      qryCadastro.SQL.Add('DELETE FROM COMHL4 WHERE HL4_CODTAB = :CODTAB');
      qryCadastro.ParamByName('CODTAB').AsString := edtCodTab.Text;
      qryCadastro.ExecSQL;
    End;

    qryCadastro.Close;
    qryCadastro.SQL.Clear;
    qryCadastro.SQL.Add('SELECT * FROM COMHL4 WHERE FALSE');
    qryCadastro.Open;

    qryCadastro.Append;
    qryCadastro.FieldByName('HL4_CODTAB').AsString := edtCodTab.Text;
    qryCadastro.FieldByName('HL4_DESCRI').AsString := edtDescri.Text;
    qryCadastro.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMHL4', '');
    qryCadastro.Post;

    strCodTabSel := edtCodTab.Text;
  Finally
    FreeAndNil(qryCadastro);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupo.pVincularGrupos;
  Var
    qryGrupo : TUniQuery;
begin
  qryGrupo := fCriaQuery(Self);
  Try
    qryGrupo.Close;
    qryGrupo.SQL.Clear;
    qryGrupo.SQL.Add('SELECT * FROM COMHLF WHERE FALSE');
    qryGrupo.Open;

    cdsGrupo.First;
    While (Not cdsGrupo.Eof) Do
    Begin
      qryGrupo.Append;
      qryGrupo.FieldByName('HLF_CODTAB').AsString := edtCodTab.Text;
      qryGrupo.FieldByName('HLF_CODGRU').AsString := cdsGrupoHLF_CODGRU.AsString;
      qryGrupo.FieldByName('HLF_DESINI').AsFloat  := cdsGrupoHLF_DESINI.AsFloat;
      qryGrupo.FieldByName('HLF_DESFIN').AsFloat  := cdsGrupoHLF_DESFIN.AsFloat;
      qryGrupo.FieldByName('HLF_PERCOM').AsFloat  := cdsGrupoHLF_PERCOM.AsFloat;
      qryGrupo.FieldByName('HLF_CODITE').AsString := cdsGrupoHLF_CODITE.AsString;
      qryGrupo.FieldByName('HLF_CODUNI').AsString := cdsGrupoHLF_CODUNI.AsString;
      qryGrupo.FieldByName('HLF_TABPRE').AsString := cdsGrupoHLF_TABPRE.AsString;
      qryGrupo.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMHLF', '');
      qryGrupo.Post;

      cdsGrupo.Next;
    End;
  Finally
    FreeAndNil(qryGrupo);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupo.btnGravarClick(Sender: TObject);
begin
  inherited;

  If (Not fValidaCampos(edtCodTab)) Or (Not fValidaCampos(edtDescri)) Then
    Exit;

  If (cdsGrupo.IsEmpty) Then
  Begin
    fMensagem('Atenção!', 'É necessário informar as faixa de desconto por grupo!', ['&Ok']);
    Exit;
  End;

  fStartTransaction;
  Try
    pCadastrarHierarquia;
    pVincularGrupos;
    fCommit;

    pHabilitar(True);
    blnInserindo := False;
    blnAlterando := False;
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '[TfrmCadFaixaDescontoLinhaGrupo.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupo.pAdicionaProdutos;
var
  qryProdutos: TUniQuery;
  strItemHierarquia: String;
  strItemFaixa: String;
begin
  qryProdutos := fCriaQuery;
  cdsGrupo.DisableControls;

  strItemHierarquia := EmptyStr;
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
      if fItemEmOutraHierarquia(qryProdutos.FieldByName('ITE_CODITE').AsString, strCodTabSel) then
        strItemHierarquia := strItemHierarquia + Concat(qryProdutos.FieldByName('ITE_CODITE').AsString,'-',qryProdutos.FieldByName('ITE_DESITE').AsString) + sLineBreak
      else if fFaixaExiste(qryProdutos.FieldByName('ITE_CODITE').AsString, StrToFloatDef(edtDesIni.Text, 0), StrToFloatDef(edtDesFin.Text, 0), edtTabPre.Text) then
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

    If (Not fEmptyStr(strItemHierarquia)) Then
      TfrmObservacao.fObservacao('O(s) item(ns) abaixo já se encontra(m) em outra(s) hierarquia(s)', strItemHierarquia);

    If (Not fEmptyStr(strItemFaixa)) Then
      TfrmObservacao.fObservacao('A faixa preenchida do(s) item(ns) abaixo já existe em outro intervalo!', strItemFaixa);

    If (fEmptyStr(strItemHierarquia)) And (fEmptyStr(strItemFaixa)) Then
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

procedure TfrmCadFaixaDescontoLinhaGrupo.pAdicionarGrupo(strCodGru: String;
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

  cdsGrupoHLF_CODGRU.AsString := strCodGru;
  cdsGrupoHLF_DESGRU.AsString := strDesGru;
  cdsGrupoHLF_DESINI.AsFloat  := fltDesIni;
  cdsGrupoHLF_DESFIN.AsFloat  := fltDesFin;
  cdsGrupoHLF_PERCOM.AsFloat  := fltComis;
  cdsGrupoHLF_CODITE.AsString := strCodIte;
  cdsGrupoHLF_CODUNI.AsString := strCodUni;
  cdsGrupoHLF_DESITE.AsString := Concat(strCodIte,'-',fRetNomProduto(strCodIte));
  cdsGrupoHLF_TABPRE.AsString := strTabPre;
  cdsGrupo.Post;
end;

function TfrmCadFaixaDescontoLinhaGrupo.fFaixaExiste(strCodIte: String;
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
      If (cdsGrupo.FieldByName('HLF_CODITE').AsString <> strCodIte) Or
        ((blnAltLinGru) And (cdsGrupo.RecNo = intRecNo)) Then
      Begin
        cdsGrupo.Next;
        Continue;
      End;

      If (fltDesIni >= cdsGrupo.FieldByName('HLF_DESINI').AsFloat) And (fltDesIni <= cdsGrupo.FieldByName('HLF_DESFIN').AsFloat) Then
        Result := True
      Else If (fltDesFin >= cdsGrupo.FieldByName('HLF_DESINI').AsFloat) And (fltDesFin <= cdsGrupo.FieldByName('HLF_DESFIN').AsFloat) Then
        Result := True
      Else If (fltDesIni <= cdsGrupo.FieldByName('HLF_DESINI').AsFloat) And (fltDesFin >= cdsGrupo.FieldByName('HLF_DESFIN').AsFloat) Then
        Result := True;

      If (Result) And (Not fEmptyStr(strTabPre)) And (strTabPre <> cdsGrupo.FieldByName('HLF_TABPRE').AsString) Then
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

function TfrmCadFaixaDescontoLinhaGrupo.fItemEmOutraHierarquia(strCodIte,
  strCodTab: String): Boolean;
  Var
    qryIte : TUniQuery;
begin
  qryIte := fCriaQuery;
  Try
    qryIte.SQL.Clear;
    qryIte.SQL.Add(' SELECT HLF_CODTAB ');
    qryIte.SQL.Add(' FROM COMHLF ');
    qryIte.SQL.Add(' WHERE HLF_CODITE = :CODITE ');
    qryIte.ParamByName('CODITE').AsString := strCodIte;
    qryIte.Open;

    If (Not qryIte.IsEmpty) Then
      Result := qryIte.FieldByName('HLF_CODTAB').AsString <> strCodTab
    Else
      Result := False;
  Finally
    FreeAndNil(qryIte);
  End;
end;

function TfrmCadFaixaDescontoLinhaGrupo.fHierarquiaExiste(strCodTab: String): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT * FROM COMHL4 WHERE HL4_CODTAB = :CODTAB');
    qryGen.ParamByName('CODTAB').AsString := strCodTab;
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupo.btnIncluirClick(
  Sender: TObject);
begin
  inherited;
  pHabilitar(False);
  pLimparTela;

  blnInserindo := True;
  blnAlterando := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupo.pCarregarGrupos(strCodTab: String);
  Var
    qryFaixa : TUniQuery;
begin
  inherited;

  qryFaixa := fCriaQuery;
  Try
    qryFaixa.SQL.Clear;
    qryFaixa.SQL.Add(' SELECT COMHLF.*, CADGRU.GRU_DESGRU ');
    qryFaixa.SQL.Add(' FROM COMHLF ');
    qryFaixa.SQL.Add(' INNER JOIN CADGRU ON HLF_CODGRU = GRU_CODGRU ');
    qryFaixa.SQL.Add(' WHERE HLF_CODTAB = :CODTAB ');
    qryFaixa.ParamByName('CODTAB').AsString := strCodTab;
    qryFaixa.Open;

    qryFaixa.First;
    While Not qryFaixa.Eof Do
    Begin
      pAdicionarGrupo(qryFaixa.FieldByName('HLF_CODGRU').AsString,
                      qryFaixa.FieldByName('GRU_DESGRU').AsString,
                      qryFaixa.FieldByName('HLF_DESINI').AsFloat,
                      qryFaixa.FieldByName('HLF_DESFIN').AsFloat,
                      qryFaixa.FieldByName('HLF_PERCOM').AsFloat,
                      qryFaixa.FieldByName('HLF_CODITE').AsString,
                      qryFaixa.FieldByName('HLF_CODUNI').AsString,
                      qryFaixa.FieldByName('HLF_TABPRE').AsString);

      qryFaixa.Next;
    End;
  Finally
    FreeAndNil(qryFaixa);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupo.pCarregaTabelaPrecos;
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

procedure TfrmCadFaixaDescontoLinhaGrupo.btnPesquisaClick(
  Sender: TObject);
  Var
    qryConsulta : TUniQuery;
    arrSel : TConsultasArray;
    strSQL : String;
begin
  inherited;

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  HL4_CODTAB, ';
  strSQL := strSQL + '  HL4_DESCRI, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  COMHL4 ';

  qryConsulta := fCriaQuery;
  Try
    If fConsulta([strSQL],
                 ['Código', 'Descrição'],
                 ['HL4_CODTAB', 'HL4_DESCRI'],
                 'AUTOINCREM',
                 'COMHL4',
                 Self.Name,
                 'Cadastro de Faixa de Desconto Por Linha/Grupo',
                 qryConsulta,
                 nil,
                 True,
                 arrSel,
                 'AUTOINCREM',
                 nil) Then
    Begin
      pLimparTela;
      strCodTabSel   := qryConsulta.FieldByName('HL4_CODTAB').AsString;

      edtCodTab.Text := strCodTabSel;
      edtDescri.Text := qryConsulta.FieldByName('HL4_DESCRI').AsString;

      pCarregarGrupos(strCodTabSel);
      cxgGrupos.Enabled := False;
    End
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupo.cxGridDBTvGruposDblClick(
  Sender: TObject);
begin
  inherited;
  pMoveItemParaEdicao;
  cxgGrupos.Enabled := False;
  blnAltLinGru := True;
end;

procedure TfrmCadFaixaDescontoLinhaGrupo.cxGridDBTvGruposKeyDown(
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

procedure TfrmCadFaixaDescontoLinhaGrupo.edtCodGruKeyPress(
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

procedure TfrmCadFaixaDescontoLinhaGrupo.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmCadFaixaDescontoLinhaGrupo.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmCadFaixaDescontoLinhaGrupo.FormCreate(Sender: TObject);
begin
  inherited;
  cdsGrupo.CreateDataSet;

  pHabilitar(True);

  strCodTabSel := '';
  blnAltLinGru := False;
  cxgGrupos.Enabled := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupo.FormShow(Sender: TObject);
begin
  inherited;
  lblTabPre.Visible := fCfgSis('TPCHFD', varBoolean);
  edtTabPre.Visible := lblTabPre.Visible;
  clbPrcVenda.Visible := lblTabPre.Visible;
  cxgGruposDBTABPRE.Visible := lblTabPre.Visible;
  pCarregaTabelaPrecos;
end;

function TfrmCadFaixaDescontoLinhaGrupo.fValidaCampos(
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

procedure TfrmCadFaixaDescontoLinhaGrupo.pHabilitar(
  blnHabilitar: Boolean);
begin
  btnIncluir.Enabled  := blnHabilitar;
  btnGravar.Enabled   := Not blnHabilitar;
  btnExcluir.Enabled  := blnHabilitar;
  btnCancela.Enabled  := Not blnHabilitar;
  btnPesquisa.Enabled := blnHabilitar;

  edtCodTab.Enabled := Not blnHabilitar;
  edtDescri.Enabled := Not blnHabilitar;

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

procedure TfrmCadFaixaDescontoLinhaGrupo.pLimparDadosGrupo;
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

procedure TfrmCadFaixaDescontoLinhaGrupo.pLimparTela;
begin
  strCodTabSel := '';
  cdsGrupo.EmptyDataSet;

  edtCodTab.Clear;
  edtDescri.Clear;

  pLimparDadosGrupo;

  pSetFocus(edtCodTab);
end;

procedure TfrmCadFaixaDescontoLinhaGrupo.pMoveItemParaEdicao;
begin
  edtCodGru.Text   := cdsGrupoHLF_CODGRU.AsString;
  edtDesGru.Text   := fRetNomeLinhaGrupo(cdsGrupoHLF_CODGRU.AsString);
  edtCodUni.Text   := cdsGrupoHLF_CODUNI.AsString;
  edtSigUni.Text   := fRetSiglaUnidade(cdsGrupoHLF_CODUNI.AsString);
  edtCodIte.Text   := cdsGrupoHLF_CODITE.AsString;
  edtDesIte.Text   := fRetNomProduto(cdsGrupoHLF_CODITE.AsString);
  edtDesIni.Text   := FormatFloat(fMskDigitos(4),cdsGrupoHLF_DESINI.AsFloat);
  edtDesFin.Text   := FormatFloat(fMskDigitos(4),cdsGrupoHLF_DESFIN.AsFloat);
  edtComissao.Text := FormatFloat(fMskDigitos(4),cdsGrupoHLF_PERCOM.AsFloat);
  edtTabPre.Text   := cdsGrupoHLF_TABPRE.AsString;
end;

end.
