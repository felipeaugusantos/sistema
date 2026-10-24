unit untCadFaixaDescontoLinhaGrupoVendedor;

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
  UniClientDataSet, untFuncoesConsulta, cxProgressBar, untGravando, QColorLabel,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus;

type
  TfrmCadFaixaDescontoLinhaGrupoVendedor = class(TfrmPai)
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
    lblVendedor: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    btnConfirmarVendedor: TBitBtnLocked;
    edtDescri: TEditFocus;
    cxgVendedores: TcxGrid;
    cxGridDBTvVendedores: TcxGridDBTableView;
    cxgVendedoresDBCODVEN: TcxGridDBColumn;
    cxgVendedoresDBNOMVEN: TcxGridDBColumn;
    cxgVendedoresLevel1: TcxGridLevel;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    dtsVendedor: TDataSource;
    cdsVendedor: TUniClientDataSet;
    cdsVendedorHLV_CODTAB: TStringField;
    cdsVendedorHLV_NOMVEN: TStringField;
    cdsVendedorAUTOINCREM: TStringField;
    dtsGrupo: TDataSource;
    cdsGrupo: TUniClientDataSet;
    cdsGrupoHLV_CODTAB: TStringField;
    cdsGrupoHLV_CODGRU: TStringField;
    cdsGrupoHLV_DESGRU: TStringField;
    cdsGrupoHLV_DESINI: TFloatField;
    cdsGrupoHLV_DESFIN: TFloatField;
    cdsGrupoHLV_PERCOM: TFloatField;
    cdsGrupoAUTOINCREM : TStringField;
    lblCodTab: TLabel;
    lblDescri: TLabel;
    edtCodTab: TEditFocus;
    cdsVendedorHLV_CODVEN: TStringField;
    Bevel1: TBevel;
    Label1: TLabel;
    edtCodUni: TEditFocus;
    edtSigUni: TEditFocus;
    Label2: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    cdsGrupoHLV_CODITE: TStringField;
    cdsGrupoHLV_DESITE: TStringField;
    cdsGrupoHLV_CODUNI: TStringField;
    lblTabPre: TLabel;
    clbPrcVenda: TColorLabel;
    edtTabPre: TEditFocus;
    cdsGrupoHLV_TABPRE: TStringField;
    cxgGruposDBTABPRE: TcxGridDBColumn;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarVendedorClick(Sender: TObject);
    procedure cxGridDBTvVendedoresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarLinhaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtNomVenKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxGridDBTvGruposKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure pAdicionaProdutos;
    procedure edtCodVenExit(Sender: TObject);
    procedure cxGridDBTvGruposDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    blnInserindo: Boolean;
    blnAlterando: Boolean;
    arrVendedores: TConsultasArray;
    strCodTabSel: String;
    blnAltLinGru: Boolean;
    strVrfTpr: String;

    procedure pLimparDadosVendedor;
    procedure pLimparDadosGrupo;
    procedure pLimparTela;
    procedure pHabilitar(blnHabilitar: Boolean);
    procedure pAdicionarVendedor(strCodVen, strNomVen: String);
    function fVendedorAdicionado(strCodVen: String): Boolean;
    procedure pAdicionarGrupo(strCodGru, strDesGru: String; fltDesIni,
      fltDesFin, fltComis: Double; strCodIte, strCodUni, strTabPre: String);
    function fFaixaExiste(strCodIte: String; fltDesIni,
      fltDesFin: Double; strTabPre: String): Boolean;
    function fHierarquiaExiste(strCodTab: String): Boolean;
    procedure pCadastrarHierarquia;
    procedure pVincularVendedores;
    procedure pVincularGrupos;
    procedure pCarregarVendedores(strCodTab: String);
    procedure pCarregarGrupos(strCodTab: String);
    function fExcluir(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fVendedorEmOutraHierarquia(strCodVen, strCodTab: String): Boolean;
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

{ TfrmCadFaixaDescontoLinhaGrupoVendedor1 }

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.btnAlterarClick(
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

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.btnCancelaClick(
  Sender: TObject);
begin
  inherited;
  pLimparTela;

  pHabilitar(True);
  blnInserindo := False;
  blnAlterando := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.btnConfirmarVendedorClick(
  Sender: TObject);
  Var
    qryVen : TUniQuery;
    strCodVen : String;
    arrVendedoresEmOutrasHierarquias : Array Of String;
begin
  inherited;

  SetLength(arrVendedoresEmOutrasHierarquias, 0);

  If fValidaCampos(edtCodVen) Then
  Begin
    If Length(arrVendedores) > 1 Then
    Begin
      qryVen := fCriaQuery;
      Try
        qryVen.SQL.Clear;
        qryVen.SQL.Add(' SELECT OPE_CODOPE, OPE_NOMOPE ');
        qryVen.SQL.Add(' FROM CADOPE ');
        qryVen.SQL.Add(' WHERE ' + fStrLocate(edtCodVen, arrVendedores, 'OPE_CODOPE', 'CODOPE', True));
        pSetaParam(edtCodVen.Text, arrVendedores, strCodVen, 'CODOPE', qryVen);
        qryVen.Open;

        qryVen.First;
        While Not qryVen.Eof Do
        Begin
          If fVendedorEmOutraHierarquia(qryVen.FieldByName('OPE_CODOPE').AsString, strCodTabSel) Then
          Begin
           SetLength(arrVendedoresEmOutrasHierarquias, Length(arrVendedoresEmOutrasHierarquias)+1);
           arrVendedoresEmOutrasHierarquias[Length(arrVendedoresEmOutrasHierarquias)-1] := qryVen.FieldByName('OPE_CODOPE').AsString;
          End
          Else If Not fVendedorAdicionado(qryVen.FieldByName('OPE_CODOPE').AsString) Then
            pAdicionarVendedor(qryVen.FieldByName('OPE_CODOPE').AsString, qryVen.FieldByName('OPE_NOMOPE').AsString);

          qryVen.Next;
        End;
      Finally
        FreeAndNil(qryVen);
      End;

      If Length(arrVendedoresEmOutrasHierarquias) > 0 Then
      Begin
        If Length(arrVendedoresEmOutrasHierarquias) < Length(arrVendedores) Then
          pMensagemOk('Vendedores inseridos com sucesso, com exceção de: ['+fOrganizaArrayComVirgula(arrVendedoresEmOutrasHierarquias)+'] que já foram adicionados a outra hierarquia!')
        Else
          pMensagemOk('Os vendedores selecionados não foram adicionados, pois, se encontram em outra hierarquia!');
      End;

      SetLength(arrVendedores, 0);
    End
    Else
    Begin
      If fVendedorEmOutraHierarquia(edtCodVen.Text, strCodTabSel) Then
        pMensagemOk('Esse vendedor já foi adicionado a outra hierarquia!')
      Else If Not fVendedorAdicionado(edtCodVen.Text) Then
        pAdicionarVendedor(edtCodVen.Text, edtNomVen.Text)
      Else
        pMensagemOk('Esse vendedor já foi adicionado!');
    End;

    pLimparDadosVendedor;
    pSetFocus(edtCodVen);

    pHabilitar(False);
  End;
end;

function TfrmCadFaixaDescontoLinhaGrupoVendedor.fVendedorAdicionado(strCodVen: String):Boolean;
begin
  cdsVendedor.DisableControls;
  Try
    cdsVendedor.Filter := 'HLV_CODVEN = ' + QuotedStr(strCodVen);
    cdsVendedor.Filtered := True;
    Result := Not cdsVendedor.IsEmpty;
  Finally
    cdsVendedor.Filtered := False;
    cdsVendedor.EnableControls;
  End;
end;

function TfrmCadFaixaDescontoLinhaGrupoVendedor.fVendedorEmOutraHierarquia(
  strCodVen, strCodTab: String): Boolean;
  Var
    qryVen : TUniQuery;
begin
  qryVen := fCriaQuery;
  Try
    qryVen.SQL.Clear;
    qryVen.SQL.Add(' SELECT HLV_CODTAB ');
    qryVen.SQL.Add(' FROM COMHLV ');
    qryVen.SQL.Add(' WHERE HLV_CODVEN = :CODVEN ');
    qryVen.ParamByName('CODVEN').AsString := strCodVen;
    qryVen.Open;

    If (Not qryVen.IsEmpty) Then
      Result := qryVen.FieldByName('HLV_CODTAB').AsString <> strCodTab
    Else
      Result := False;
  Finally
    FreeAndNil(qryVen);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.pAdicionarVendedor(strCodVen: String; strNomVen: String);
begin
  cdsVendedor.Append;
  cdsVendedorHLV_CODVEN.AsString := strCodVen;
  cdsVendedorHLV_NOMVEN.AsString := strNomVen;
  cdsVendedor.Post;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.btnConfirmarLinhaClick(
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

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.btnExcluirClick(
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
        pMensagensErro(E.Message,'[TfrmCadFaixaDescontoLinhaGrupoVendedor.btnExcluirClick]');
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

function TfrmCadFaixaDescontoLinhaGrupoVendedor.fExcluir(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('DELETE FROM COMHL2 WHERE HL2_CODTAB = :CODTAB');
    qryGen.ParamByName('CODTAB').AsString := strCodTabSel;
    qryGen.ExecSQL;

    pLimparTela;
  Finally
    FreeAndNil(qryGen);
  End;

  Result := True;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.pCadastrarHierarquia;
  Var
    qryCadastro : TUniQuery;
begin
  qryCadastro := fCriaQuery(Self);
  Try
    If blnAlterando Then
    Begin
      qryCadastro.SQL.Clear;
      qryCadastro.SQL.Add('DELETE FROM COMHL2 WHERE HL2_CODTAB = :CODTAB');
      qryCadastro.ParamByName('CODTAB').AsString := edtCodTab.Text;
      qryCadastro.ExecSQL;
    End;

    qryCadastro.Close;
    qryCadastro.SQL.Clear;
    qryCadastro.SQL.Add('SELECT * FROM COMHL2 WHERE FALSE');
    qryCadastro.Open;

    qryCadastro.Append;
    qryCadastro.FieldByName('HL2_CODTAB').AsString := edtCodTab.Text;
    qryCadastro.FieldByName('HL2_DESCRI').AsString := edtDescri.Text;
    qryCadastro.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMHL2', '');
    qryCadastro.Post;

    strCodTabSel := edtCodTab.Text;
  Finally
    FreeAndNil(qryCadastro);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.pVincularVendedores;
  Var
    qryVendedor : TUniQuery;
begin
  qryVendedor := fCriaQuery(Self);
  Try
    qryVendedor.Close;
    qryVendedor.SQL.Clear;
    qryVendedor.SQL.Add('SELECT * FROM COMHLV WHERE FALSE');
    qryVendedor.Open;

    cdsVendedor.First;
    While (Not cdsVendedor.Eof) Do
    Begin
      qryVendedor.Append;
      qryVendedor.FieldByName('HLV_CODTAB').AsString := edtCodTab.Text;
      qryVendedor.FieldByName('HLV_CODVEN').AsString := cdsVendedorHLV_CODVEN.AsString;
      qryVendedor.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMHLV', '');
      qryVendedor.Post;

      cdsVendedor.Next;
    End;
  Finally
    FreeAndNil(qryVendedor);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.pVincularGrupos;
  Var
    qryGrupo : TUniQuery;
begin
  qryGrupo := fCriaQuery(Self);
  Try
    qryGrupo.Close;
    qryGrupo.SQL.Clear;
    qryGrupo.SQL.Add('SELECT * FROM HLVFAI WHERE FALSE');
    qryGrupo.Open;

    cdsGrupo.First;
    While (Not cdsGrupo.Eof) Do
    Begin
      qryGrupo.Append;
      qryGrupo.FieldByName('HLV_CODTAB').AsString := edtCodTab.Text;
      qryGrupo.FieldByName('HLV_CODGRU').AsString := cdsGrupoHLV_CODGRU.AsString;
      qryGrupo.FieldByName('HLV_DESINI').AsFloat  := cdsGrupoHLV_DESINI.AsFloat;
      qryGrupo.FieldByName('HLV_DESFIN').AsFloat  := cdsGrupoHLV_DESFIN.AsFloat;
      qryGrupo.FieldByName('HLV_PERCOM').AsFloat  := cdsGrupoHLV_PERCOM.AsFloat;
      qryGrupo.FieldByName('HLV_CODITE').AsString := cdsGrupoHLV_CODITE.AsString;
      qryGrupo.FieldByName('HLV_CODUNI').AsString := cdsGrupoHLV_CODUNI.AsString;
      qryGrupo.FieldByName('HLV_TABPRE').AsString := cdsGrupoHLV_TABPRE.AsString;
      qryGrupo.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('HLVFAI', '');
      qryGrupo.Post;

      cdsGrupo.Next;
    End;
  Finally
    FreeAndNil(qryGrupo);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.btnGravarClick(Sender: TObject);
begin
  inherited;

  If (Not fValidaCampos(edtCodTab)) Or (Not fValidaCampos(edtDescri)) Then
    Exit;

  If (cdsVendedor.IsEmpty) Or (cdsGrupo.IsEmpty) Then
  Begin
    fMensagem('Atenção!', 'É necessário informar Vendedores e grupos!', ['&Ok']);
    Exit;
  End;

  fStartTransaction;
  Try
    pCadastrarHierarquia;
    pVincularVendedores;
    pVincularGrupos;
    fCommit;

    pHabilitar(True);
    blnInserindo := False;
    blnAlterando := False;
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '[TfrmCadFaixaDescontoLinhaGrupoVendedor.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.pAdicionaProdutos;
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

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.pAdicionarGrupo(strCodGru: String;
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

  cdsGrupoHLV_CODGRU.AsString := strCodGru;
  cdsGrupoHLV_DESGRU.AsString := strDesGru;
  cdsGrupoHLV_DESINI.AsFloat  := fltDesIni;
  cdsGrupoHLV_DESFIN.AsFloat  := fltDesFin;
  cdsGrupoHLV_PERCOM.AsFloat  := fltComis;
  cdsGrupoHLV_CODITE.AsString := strCodIte;
  cdsGrupoHLV_CODUNI.AsString := strCodUni;
  cdsGrupoHLV_DESITE.AsString := Concat(strCodIte,'-',fRetNomProduto(strCodIte));
  cdsGrupoHLV_TABPRE.AsString := strTabPre;
  cdsGrupo.Post;
end;

function TfrmCadFaixaDescontoLinhaGrupoVendedor.fFaixaExiste(strCodIte: String;
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
      If (cdsGrupo.FieldByName('HLV_CODITE').AsString <> strCodIte) Or
        ((blnAltLinGru) And (cdsGrupo.RecNo = intRecNo)) Then
      Begin
        cdsGrupo.Next;
        Continue;
      End;

      If (fltDesIni >= cdsGrupo.FieldByName('HLV_DESINI').AsFloat) And (fltDesIni <= cdsGrupo.FieldByName('HLV_DESFIN').AsFloat) Then
        Result := True
      Else If (fltDesFin >= cdsGrupo.FieldByName('HLV_DESINI').AsFloat) And (fltDesFin <= cdsGrupo.FieldByName('HLV_DESFIN').AsFloat) Then
        Result := True
      Else If (fltDesIni <= cdsGrupo.FieldByName('HLV_DESINI').AsFloat) And (fltDesFin >= cdsGrupo.FieldByName('HLV_DESFIN').AsFloat) Then
        Result := True;

      If (Result) And (Not fEmptyStr(strTabPre)) And (strTabPre <> cdsGrupo.FieldByName('HLV_TABPRE').AsString) Then
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

function TfrmCadFaixaDescontoLinhaGrupoVendedor.fHierarquiaExiste(strCodTab: String): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT * FROM COMHL2 WHERE HL2_CODTAB = :CODTAB');
    qryGen.ParamByName('CODTAB').AsString := strCodTab;
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.btnIncluirClick(
  Sender: TObject);
begin
  inherited;
  pHabilitar(False);
  pLimparTela;

  blnInserindo := True;
  blnAlterando := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.pCarregarVendedores(strCodTab: String);
  Var
    qryHLV : TUniQuery;
begin
  inherited;

  qryHLV := fCriaQuery;
  Try
    qryHLV.SQL.Clear;
    qryHLV.SQL.Add(' SELECT COMHLV.AUTOINCREM, COMHLV.HLV_CODVEN, CADOPE.OPE_NOMOPE ');
    qryHLV.SQL.Add(' FROM COMHLV ');
    qryHLV.SQL.Add(' INNER JOIN CADOPE ON COMHLV.HLV_CODVEN = CADOPE.OPE_CODOPE ');
    qryHLV.SQL.Add(' WHERE COMHLV.HLV_CODTAB = :CODTAB ');
    qryHLV.ParamByName('CODTAB').AsString := strCodTab;
    qryHLV.Open;

    qryHLV.First;
    While Not qryHLV.Eof Do
    Begin
      pAdicionarVendedor(qryHLV.FieldByName('HLV_CODVEN').AsString, qryHLV.FieldByName('OPE_NOMOPE').AsString);

      qryHLV.Next;
    End;
  Finally
    FreeAndNil(qryHLV);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.pCarregaTabelaPrecos;
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

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.pCarregarGrupos(strCodTab: String);
  Var
    qryFaixa : TUniQuery;
begin
  inherited;

  qryFaixa := fCriaQuery;
  Try
    qryFaixa.SQL.Clear;
    qryFaixa.SQL.Add(' SELECT HLVFAI.*, CADGRU.GRU_DESGRU ');
    qryFaixa.SQL.Add(' FROM HLVFAI ');
    qryFaixa.SQL.Add(' INNER JOIN CADGRU ON HLV_CODGRU = GRU_CODGRU ');
    qryFaixa.SQL.Add(' WHERE HLV_CODTAB = :CODTAB ');
    qryFaixa.ParamByName('CODTAB').AsString := strCodTab;
    qryFaixa.Open;

    qryFaixa.First;
    While Not qryFaixa.Eof Do
    Begin
      pAdicionarGrupo(qryFaixa.FieldByName('HLV_CODGRU').AsString,
                      qryFaixa.FieldByName('GRU_DESGRU').AsString,
                      qryFaixa.FieldByName('HLV_DESINI').AsFloat,
                      qryFaixa.FieldByName('HLV_DESFIN').AsFloat,
                      qryFaixa.FieldByName('HLV_PERCOM').AsFloat,
                      qryFaixa.FieldByName('HLV_CODITE').AsString,
                      qryFaixa.FieldByName('HLV_CODUNI').AsString,
                      qryFaixa.FieldByName('HLV_TABPRE').AsString);

      qryFaixa.Next;
    End;
  Finally
    FreeAndNil(qryFaixa);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.btnPesquisaClick(
  Sender: TObject);
  Var
    qryConsulta : TUniQuery;
    arrSel : TConsultasArray;
    strSQL : String;
begin
  inherited;

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  HL2_CODTAB, ';
  strSQL := strSQL + '  HL2_DESCRI, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  COMHL2 ';

  qryConsulta := fCriaQuery;
  Try
    If fConsulta([strSQL],
                 ['Código', 'Descrição'],
                 ['HL2_CODTAB', 'HL2_DESCRI'],
                 'AUTOINCREM',
                 'COMHL2',
                 Self.Name,
                 'Cadastro de Faixa de Desconto Por Linha/Grupo - Vendedor',
                 qryConsulta,
                 nil,
                 True,
                 arrSel,
                 'AUTOINCREM',
                 nil) Then
    Begin
      pLimparTela;
      strCodTabSel   := qryConsulta.FieldByName('HL2_CODTAB').AsString;

      edtCodTab.Text := strCodTabSel;
      edtDescri.Text := qryConsulta.FieldByName('HL2_DESCRI').AsString;

      pCarregarVendedores(strCodTabSel);
      pCarregarGrupos(strCodTabSel);
      cxgGrupos.Enabled := False;
    End
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.cxGridDBTvVendedoresKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_DELETE Then
    If (Not cdsVendedor.IsEmpty) And (blnInserindo Or blnAlterando) Then
      cdsVendedor.Delete;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.cxGridDBTvGruposDblClick(
  Sender: TObject);
begin
  inherited;
  pMoveItemParaEdicao;
  cxgGrupos.Enabled := False;
  blnAltLinGru := True;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.cxGridDBTvGruposKeyDown(
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

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.edtCodVenExit(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(edtCodVen.Text) then
  begin
    edtCodVen.Text := fStrZero(edtCodVen.Text, edtCodVen.TamCampo);
    edtNomVen.Text := fRetNomeOperador(edtCodVen.Text);
  end;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.edtCodVenKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  if fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrVendedores, False, True) then
  Begin
    If fValidaCampos(edtCodVen) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.edtCodGruKeyPress(
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

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.edtCodIteKeyPress(
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

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.edtCodUniKeyPress(
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

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.edtNomVenKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    btnConfirmarVendedor.Click;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.FormCreate(Sender: TObject);
begin
  inherited;
  cdsVendedor.CreateDataSet;
  cdsGrupo.CreateDataSet;

  pHabilitar(True);

  strCodTabSel := '';
  blnAltLinGru := False;
  cxgGrupos.Enabled := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.FormShow(Sender: TObject);
begin
  inherited;
  lblTabPre.Visible := fCfgSis('TPCHFD', varBoolean);
  edtTabPre.Visible := lblTabPre.Visible;
  clbPrcVenda.Visible := lblTabPre.Visible;
  cxgGruposDBTABPRE.Visible := lblTabPre.Visible;
  pCarregaTabelaPrecos;
end;

function TfrmCadFaixaDescontoLinhaGrupoVendedor.fValidaCampos(
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
    Else If (Sender = edtCodVen) Then
    Begin
      If (fEmptyStr(edtCodVen.Text)) Then
      Begin
        fMensagem('AVISO','Código do Vendedor deve ser preenchido.', ['&OK']);
        Result := False;
      End
      Else If (edtCodVen.Text <> '00000000') And (edtNomVen.Text <> '+1') Then
      Begin
        edtNomVen.Text := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE', 'OPE_STATUS'], [edtCodVen.Text, 'A']);

        If (fEmptyStr(edtNomVen.Text)) Then
        Begin
          fMensagem('AVISO','Código do Vendedor não encontrado.', ['&OK']);
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

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.pHabilitar(
  blnHabilitar: Boolean);
begin
  btnIncluir.Enabled  := blnHabilitar;
  btnGravar.Enabled   := Not blnHabilitar;
  btnExcluir.Enabled  := blnHabilitar;
  btnCancela.Enabled  := Not blnHabilitar;
  btnPesquisa.Enabled := blnHabilitar;

  edtCodTab.Enabled := Not blnHabilitar;
  edtDescri.Enabled := Not blnHabilitar;
  edtCodVen.Enabled := Not blnHabilitar;
  cxgVendedores.Enabled := Not blnHabilitar;
  btnConfirmarVendedor.Enabled := Not blnHabilitar;

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

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.pLimparDadosVendedor;
begin
  edtCodVen.Clear;
  edtNomVen.Clear;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.pLimparDadosGrupo;
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

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.pLimparTela;
begin
  strCodTabSel := '';
  cdsVendedor.EmptyDataSet;
  cdsGrupo.EmptyDataSet;

  edtCodTab.Clear;
  edtDescri.Clear;

  pLimparDadosVendedor;
  pLimparDadosGrupo;

  pSetFocus(edtCodTab);
end;

procedure TfrmCadFaixaDescontoLinhaGrupoVendedor.pMoveItemParaEdicao;
begin
  edtCodGru.Text   := cdsGrupoHLV_CODGRU.AsString;
  edtDesGru.Text   := fRetNomeLinhaGrupo(cdsGrupoHLV_CODGRU.AsString);
  edtCodUni.Text   := cdsGrupoHLV_CODUNI.AsString;
  edtSigUni.Text   := fRetSiglaUnidade(cdsGrupoHLV_CODUNI.AsString);
  edtCodIte.Text   := cdsGrupoHLV_CODITE.AsString;
  edtDesIte.Text   := fRetNomProduto(cdsGrupoHLV_CODITE.AsString);
  edtDesIni.Text   := FormatFloat(fMskDigitos(4),cdsGrupoHLV_DESINI.AsFloat);
  edtDesFin.Text   := FormatFloat(fMskDigitos(4),cdsGrupoHLV_DESFIN.AsFloat);
  edtComissao.Text := FormatFloat(fMskDigitos(4),cdsGrupoHLV_PERCOM.AsFloat);
  edtTabPre.Text   := cdsGrupoHLV_TABPRE.AsString;
end;

end.
