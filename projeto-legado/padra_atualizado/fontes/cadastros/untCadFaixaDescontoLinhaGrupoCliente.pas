unit untCadFaixaDescontoLinhaGrupoCliente;

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
  TfrmCadFaixaDescontoLinhaGrupoCliente = class(TfrmPai)
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
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    btnConfirmarCliente: TBitBtnLocked;
    edtDescri: TEditFocus;
    cxgClientes: TcxGrid;
    cxGridDBTvClientes: TcxGridDBTableView;
    cxgClientesDBCODCLI: TcxGridDBColumn;
    cxgClientesDBNOMCLI: TcxGridDBColumn;
    cxgClientesLevel1: TcxGridLevel;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    dtsCliente: TDataSource;
    cdsCliente: TUniClientDataSet;
    cdsClienteHLC_CODTAB: TStringField;
    cdsClienteHLC_NOMCLI: TStringField;
    cdsClienteAUTOINCREM: TStringField;
    dtsGrupo: TDataSource;
    cdsGrupo: TUniClientDataSet;
    cdsGrupoHLC_CODTAB: TStringField;
    cdsGrupoHLC_CODGRU: TStringField;
    cdsGrupoHLC_DESGRU: TStringField;
    cdsGrupoHLC_DESINI: TFloatField;
    cdsGrupoHLC_DESFIN: TFloatField;
    cdsGrupoHLC_PERCOM: TFloatField;
    cdsGrupoAUTOINCREM : TStringField;
    lblCodTab: TLabel;
    lblDescri: TLabel;
    edtCodTab: TEditFocus;
    cdsClienteHLC_CODCLI: TStringField;
    Bevel1: TBevel;
    Label1: TLabel;
    edtCodUni: TEditFocus;
    edtSigUni: TEditFocus;
    Label2: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    cdsGrupoHLC_CODITE: TStringField;
    cdsGrupoHLC_DESITE: TStringField;
    cdsGrupoHLC_CODUNI: TStringField;
    lblTabPre: TLabel;
    edtTabPre: TEditFocus;
    clbPrcVenda: TColorLabel;
    cdsGrupoHLC_TABPRE: TStringField;
    cxgGruposDBTABPRE: TcxGridDBColumn;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClienteClick(Sender: TObject);
    procedure cxGridDBTvClientesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarLinhaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtNomCliKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxGridDBTvGruposKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure pAdicionaProdutos;
    procedure edtCodCliExit(Sender: TObject);
    procedure cxGridDBTvGruposDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    blnInserindo: Boolean;
    blnAlterando: Boolean;
    arrClientes: TConsultasArray;
    strCodTabSel: String;
    blnAltLinGru: Boolean;
    strVrfTpr: String;

    procedure pLimparDadosCliente;
    procedure pLimparDadosGrupo;
    procedure pLimparTela;
    procedure pHabilitar(blnHabilitar: Boolean);
    procedure pAdicionarCliente(strCodCli, strNomCli: String);
    function fClienteAdicionado(strCodCli: String): Boolean;
    procedure pAdicionarGrupo(strCodGru, strDesGru: String; fltDesIni,
      fltDesFin, fltComis: Double; strCodIte, strCodUni, strTabPre: String);
    function fFaixaExiste(strCodIte: String; fltDesIni,
      fltDesFin: Double; strTabPre: String): Boolean;
    function fHierarquiaExiste(strCodTab: String): Boolean;
    procedure pCadastrarHierarquia;
    procedure pVincularClientes;
    procedure pVincularGrupos;
    procedure pCarregarClientes(strCodTab: String);
    procedure pCarregarGrupos(strCodTab: String);
    function fExcluir(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fClienteEmOutraHierarquia(strCodCli, strCodTab: String): Boolean;
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

{ TfrmCadFaixaDescontoLinhaGrupoCliente1 }

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.btnAlterarClick(
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

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.btnCancelaClick(
  Sender: TObject);
begin
  inherited;
  pLimparTela;

  pHabilitar(True);
  blnInserindo := False;
  blnAlterando := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.btnConfirmarClienteClick(
  Sender: TObject);
  Var
    qryCli : TUniQuery;
    strCodCli : String;
    arrClientesEmOutrasHierarquias : Array Of String;
begin
  inherited;

  SetLength(arrClientesEmOutrasHierarquias, 0);

  If fValidaCampos(edtCodCli) Then
  Begin
    If Length(arrClientes) > 1 Then
    Begin
      qryCli := fCriaQuery;
      Try
        qryCli.SQL.Clear;
        qryCli.SQL.Add(' SELECT CLI_CODCLI, CLI_NOMCLI ');
        qryCli.SQL.Add(' FROM CADCLI ');
        qryCli.SQL.Add(' WHERE ' + fStrLocate(edtCodCli, arrClientes, 'CLI_CODCLI', 'CODCLI', True));
        pSetaParam(edtCodCli.Text, arrClientes, strCodCli, 'CODCLI', qryCli);
        qryCli.Open;

        qryCli.First;
        While Not qryCli.Eof Do
        Begin
          If fClienteEmOutraHierarquia(qryCli.FieldByName('CLI_CODCLI').AsString, strCodTabSel) Then
          Begin
           SetLength(arrClientesEmOutrasHierarquias, Length(arrClientesEmOutrasHierarquias)+1);
           arrClientesEmOutrasHierarquias[Length(arrClientesEmOutrasHierarquias)-1] := qryCli.FieldByName('CLI_CODCLI').AsString;
          End
          Else If Not fClienteAdicionado(qryCli.FieldByName('CLI_CODCLI').AsString) Then
            pAdicionarCliente(qryCli.FieldByName('CLI_CODCLI').AsString, qryCli.FieldByName('CLI_NOMCLI').AsString);

          qryCli.Next;
        End;
      Finally
        FreeAndNil(qryCli);
      End;

      If Length(arrClientesEmOutrasHierarquias) > 0 Then
      Begin
        If Length(arrClientesEmOutrasHierarquias) < Length(arrClientes) Then
          pMensagemOk('Clientes inseridos com sucesso, com exceção de: ['+fOrganizaArrayComVirgula(arrClientesEmOutrasHierarquias)+'] que já foram adicionados a outra hierarquia!')
        Else
          pMensagemOk('Os clientes selecionados não foram adicionados, pois, se encontram em outra hierarquia!');
      End;

      SetLength(arrClientes, 0);
    End
    Else
    Begin
      If fClienteEmOutraHierarquia(edtCodCli.Text, strCodTabSel) Then
        pMensagemOk('Esse cliente já foi adicionado a outra hierarquia!')
      Else If Not fClienteAdicionado(edtCodCli.Text) Then
        pAdicionarCliente(edtCodCli.Text, edtNomCli.Text)
      Else
        pMensagemOk('Esse cliente já foi adicionado!');
    End;

    pLimparDadosCliente;
    pSetFocus(edtCodCli);

    pHabilitar(False);
  End;
end;

function TfrmCadFaixaDescontoLinhaGrupoCliente.fClienteAdicionado(strCodCli: String):Boolean;
begin
  cdsCliente.DisableControls;
  Try
    cdsCliente.Filter := 'HLC_CODCLI = '+strCodCli;
    cdsCliente.Filtered := True;
    Result := Not cdsCliente.IsEmpty;
  Finally
    cdsCliente.Filtered := False;
    cdsCliente.EnableControls;
  End;
end;

function TfrmCadFaixaDescontoLinhaGrupoCliente.fClienteEmOutraHierarquia(strCodCli: String; strCodTab: String): Boolean;
  Var
    qryCli : TUniQuery;
begin
  qryCli := fCriaQuery;
  Try
    qryCli.SQL.Clear;
    qryCli.SQL.Add(' SELECT HLC_CODTAB ');
    qryCli.SQL.Add(' FROM COMHLC ');
    qryCli.SQL.Add(' WHERE HLC_CODCLI = :CODCLI ');
    qryCli.ParamByName('CODCLI').AsString := strCodCli;
    qryCli.Open;

    If (Not qryCli.IsEmpty) Then
      Result := qryCli.FieldByName('HLC_CODTAB').AsString <> strCodTab
    Else
      Result := False;
  Finally
    FreeAndNil(qryCli);
  End;
end;


procedure TfrmCadFaixaDescontoLinhaGrupoCliente.pAdicionaProdutos;
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
      If (fFaixaExiste(qryProdutos.FieldByName('ITE_CODITE').AsString, StrToFloatDef(edtDesIni.Text, 0), StrToFloatDef(edtDesFin.Text, 0), edtTabPre.Text)) Then
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

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.pAdicionarCliente(strCodCli: String; strNomCli: String);
begin
  cdsCliente.Append;
  cdsClienteHLC_CODCLI.AsString := strCodCli;
  cdsClienteHLC_NOMCLI.AsString := strNomCli;
  cdsCliente.Post;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.btnConfirmarLinhaClick(
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

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.btnExcluirClick(
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
        pMensagensErro(E.Message,'[TfrmCadFaixaDescontoLinhaGrupoCliente.btnExcluirClick]');
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

function TfrmCadFaixaDescontoLinhaGrupoCliente.fExcluir(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('DELETE FROM COMHL1 WHERE HL1_CODTAB = :CODTAB');
    qryGen.ParamByName('CODTAB').AsString := strCodTabSel;
    qryGen.ExecSQL;

    pLimparTela;
  Finally
    FreeAndNil(qryGen);
  End;

  Result := True;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.pCadastrarHierarquia;
  Var
    qryCadastro : TUniQuery;
begin
  qryCadastro := fCriaQuery(Self);
  Try
    If blnAlterando Then
    Begin
      qryCadastro.SQL.Clear;
      qryCadastro.SQL.Add('DELETE FROM COMHL1 WHERE HL1_CODTAB = :CODTAB');
      qryCadastro.ParamByName('CODTAB').AsString := edtCodTab.Text;
      qryCadastro.ExecSQL;
    End;

    qryCadastro.Close;
    qryCadastro.SQL.Clear;
    qryCadastro.SQL.Add('SELECT * FROM COMHL1 WHERE FALSE');
    qryCadastro.Open;

    qryCadastro.Append;
    qryCadastro.FieldByName('HL1_CODTAB').AsString := edtCodTab.Text;
    qryCadastro.FieldByName('HL1_DESCRI').AsString := edtDescri.Text;
    qryCadastro.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMHL1', '');
    qryCadastro.Post;

    strCodTabSel := edtCodTab.Text;
  Finally
    FreeAndNil(qryCadastro);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.pVincularClientes;
  Var
    qryCliente : TUniQuery;
begin
  qryCliente := fCriaQuery(Self);
  Try
    qryCliente.Close;
    qryCliente.SQL.Clear;
    qryCliente.SQL.Add('SELECT * FROM COMHLC WHERE FALSE');
    qryCliente.Open;

    cdsCliente.First;
    While (Not cdsCliente.Eof) Do
    Begin
      qryCliente.Append;
      qryCliente.FieldByName('HLC_CODTAB').AsString := edtCodTab.Text;
      qryCliente.FieldByName('HLC_CODCLI').AsString := cdsClienteHLC_CODCLI.AsString;
      qryCliente.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMHLC', '');
      qryCliente.Post;

      cdsCliente.Next;
    End;
  Finally
    FreeAndNil(qryCliente);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.pVincularGrupos;
  Var
    qryGrupo : TUniQuery;
begin
  qryGrupo := fCriaQuery(Self);
  Try
    qryGrupo.Close;
    qryGrupo.SQL.Clear;
    qryGrupo.SQL.Add('SELECT * FROM HLCFAI WHERE FALSE');
    qryGrupo.Open;

    cdsGrupo.First;
    While (Not cdsGrupo.Eof) Do
    Begin
      qryGrupo.Append;
      qryGrupo.FieldByName('HLC_CODTAB').AsString := edtCodTab.Text;
      qryGrupo.FieldByName('HLC_CODGRU').AsString := cdsGrupoHLC_CODGRU.AsString;
      qryGrupo.FieldByName('HLC_DESINI').AsFloat  := cdsGrupoHLC_DESINI.AsFloat;
      qryGrupo.FieldByName('HLC_DESFIN').AsFloat  := cdsGrupoHLC_DESFIN.AsFloat;
      qryGrupo.FieldByName('HLC_PERCOM').AsFloat  := cdsGrupoHLC_PERCOM.AsFloat;
      qryGrupo.FieldByName('HLC_CODITE').AsString := cdsGrupoHLC_CODITE.AsString;
      qryGrupo.FieldByName('HLC_CODUNI').AsString := cdsGrupoHLC_CODUNI.AsString;
      qryGrupo.FieldByName('HLC_TABPRE').AsString := cdsGrupoHLC_TABPRE.AsString;
      qryGrupo.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('HLCFAI', '');
      qryGrupo.Post;

      cdsGrupo.Next;
    End;
  Finally
    FreeAndNil(qryGrupo);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.btnGravarClick(Sender: TObject);
begin
  inherited;

  If (Not fValidaCampos(edtCodTab)) Or (Not fValidaCampos(edtDescri)) Then
    Exit;

  If (cdsCliente.IsEmpty) Or (cdsGrupo.IsEmpty) Then
  Begin
    fMensagem('Atenção!', 'É necessário informar clientes e grupos!', ['&Ok']);
    Exit;
  End;

  fStartTransaction;
  Try
    pCadastrarHierarquia;
    pVincularClientes;
    pVincularGrupos;
    fCommit;

    pHabilitar(True);
    blnInserindo := False;
    blnAlterando := False;
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '[TfrmCadFaixaDescontoLinhaGrupoCliente.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.pAdicionarGrupo(strCodGru: String;
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

  cdsGrupoHLC_CODGRU.AsString := strCodGru;
  cdsGrupoHLC_DESGRU.AsString := strDesGru;
  cdsGrupoHLC_DESINI.AsFloat  := fltDesIni;
  cdsGrupoHLC_DESFIN.AsFloat  := fltDesFin;
  cdsGrupoHLC_PERCOM.AsFloat  := fltComis;
  cdsGrupoHLC_CODITE.AsString := strCodIte;
  cdsGrupoHLC_CODUNI.AsString := strCodUni;
  cdsGrupoHLC_DESITE.AsString := Concat(strCodIte,'-',fRetNomProduto(strCodIte));
  cdsGrupoHLC_TABPRE.AsString := strTabPre;
  cdsGrupo.Post;
end;

function TfrmCadFaixaDescontoLinhaGrupoCliente.fFaixaExiste(strCodIte: String;
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
      If (cdsGrupo.FieldByName('HLC_CODITE').AsString <> strCodIte) Or
        ((blnAltLinGru) And (cdsGrupo.RecNo = intRecNo)) Then
      Begin
        cdsGrupo.Next;
        Continue;
      End;

      If (fltDesIni >= cdsGrupo.FieldByName('HLC_DESINI').AsFloat) And (fltDesIni <= cdsGrupo.FieldByName('HLC_DESFIN').AsFloat) Then
        Result := True
      Else If (fltDesFin >= cdsGrupo.FieldByName('HLC_DESINI').AsFloat) And (fltDesFin <= cdsGrupo.FieldByName('HLC_DESFIN').AsFloat) Then
        Result := True
      Else If (fltDesIni <= cdsGrupo.FieldByName('HLC_DESINI').AsFloat) And (fltDesFin >= cdsGrupo.FieldByName('HLC_DESFIN').AsFloat) Then
        Result := True;

      If (Result) And (Not fEmptyStr(strTabPre)) And (strTabPre <> cdsGrupo.FieldByName('HLC_TABPRE').AsString) Then
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

function TfrmCadFaixaDescontoLinhaGrupoCliente.fHierarquiaExiste(strCodTab: String): Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT * FROM COMHL1 WHERE HL1_CODTAB = :CODTAB');
    qryGen.ParamByName('CODTAB').AsString := strCodTab;
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.btnIncluirClick(
  Sender: TObject);
begin
  inherited;
  pHabilitar(False);
  pLimparTela;

  blnInserindo := True;
  blnAlterando := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.pCarregarClientes(strCodTab: String);
  Var
    qryHLC : TUniQuery;
begin
  inherited;

  qryHLC := fCriaQuery;
  Try
    qryHLC.SQL.Clear;
    qryHLC.SQL.Add(' SELECT COMHLC.AUTOINCREM, COMHLC.HLC_CODCLI, CADCLI.CLI_NOMCLI ');
    qryHLC.SQL.Add(' FROM COMHLC ');
    qryHLC.SQL.Add(' INNER JOIN CADCLI ON COMHLC.HLC_CODCLI = CADCLI.CLI_CODCLI ');
    qryHLC.SQL.Add(' WHERE COMHLC.HLC_CODTAB = :CODTAB ');
    qryHLC.ParamByName('CODTAB').AsString := strCodTab;
    qryHLC.Open;

    qryHLC.First;
    While Not qryHLC.Eof Do
    Begin
      pAdicionarCliente(qryHLC.FieldByName('HLC_CODCLI').AsString, qryHLC.FieldByName('CLI_NOMCLI').AsString);

      qryHLC.Next;
    End;
  Finally
    FreeAndNil(qryHLC);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.pCarregarGrupos(strCodTab: String);
  Var
    qryFaixa : TUniQuery;
begin
  inherited;

  qryFaixa := fCriaQuery;
  Try
    qryFaixa.SQL.Clear;
    qryFaixa.SQL.Add(' SELECT HLCFAI.*, CADGRU.GRU_DESGRU ');
    qryFaixa.SQL.Add(' FROM HLCFAI ');
    qryFaixa.SQL.Add(' INNER JOIN CADGRU ON HLC_CODGRU = GRU_CODGRU ');
    qryFaixa.SQL.Add(' WHERE HLC_CODTAB = :CODTAB ');
    qryFaixa.ParamByName('CODTAB').AsString := strCodTab;
    qryFaixa.Open;

    qryFaixa.First;
    While Not qryFaixa.Eof Do
    Begin
      pAdicionarGrupo(qryFaixa.FieldByName('HLC_CODGRU').AsString,
                      qryFaixa.FieldByName('GRU_DESGRU').AsString,
                      qryFaixa.FieldByName('HLC_DESINI').AsFloat,
                      qryFaixa.FieldByName('HLC_DESFIN').AsFloat,
                      qryFaixa.FieldByName('HLC_PERCOM').AsFloat,
                      qryFaixa.FieldByName('HLC_CODITE').AsString,
                      qryFaixa.FieldByName('HLC_CODUNI').AsString,
                      qryFaixa.FieldByName('HLC_TABPRE').AsString);

      qryFaixa.Next;
    End;
  Finally
    FreeAndNil(qryFaixa);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.pCarregaTabelaPrecos;
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

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.btnPesquisaClick(
  Sender: TObject);
  Var
    qryConsulta : TUniQuery;
    arrSel : TConsultasArray;
    strSQL : String;
begin
  inherited;

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  HL1_CODTAB, ';
  strSQL := strSQL + '  HL1_DESCRI, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  COMHL1 ';

  qryConsulta := fCriaQuery;
  Try
    If fConsulta([strSQL],
                 ['Código', 'Descrição'],
                 ['HL1_CODTAB', 'HL1_DESCRI'],
                 'AUTOINCREM',
                 'COMHL1',
                 Self.Name,
                 'Cadastro de Faixa de Desconto Por Linha/Grupo - Cliente',
                 qryConsulta,
                 nil,
                 True,
                 arrSel,
                 'AUTOINCREM',
                 nil) Then
    Begin
      pLimparTela;
      strCodTabSel   := qryConsulta.FieldByName('HL1_CODTAB').AsString;

      edtCodTab.Text := strCodTabSel;
      edtDescri.Text := qryConsulta.FieldByName('HL1_DESCRI').AsString;

      pCarregarClientes(strCodTabSel);
      pCarregarGrupos(strCodTabSel);
      cxgGrupos.Enabled := False;
    End
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.cxGridDBTvClientesKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_DELETE Then
    If (Not cdsCliente.IsEmpty) And (blnInserindo Or blnAlterando) Then
      cdsCliente.Delete;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.cxGridDBTvGruposDblClick(
  Sender: TObject);
begin
  inherited;
  pMoveItemParaEdicao;
  cxgGrupos.Enabled := False;
  blnAltLinGru := True;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.cxGridDBTvGruposKeyDown(
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

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.edtCodCliExit(Sender: TObject);
begin
  inherited;

  if not fEmptyStr(edtCodCli.Text) then
  begin
    edtCodCli.Text := fStrZero(edtCodCli.Text, edtCodCli.TamCampo);
    edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
  end;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.edtCodCliKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If (fPesqCliente(conCliCompleta, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, False)) Then
  Begin
    If fValidaCampos(edtCodCli) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.edtCodGruKeyPress(
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

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.edtCodIteKeyPress(
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

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.edtCodUniKeyPress(
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

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.edtNomCliKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    btnConfirmarCliente.Click;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.FormCreate(Sender: TObject);
begin
  inherited;
  cdsCliente.CreateDataSet;
  cdsGrupo.CreateDataSet;

  pHabilitar(True);

  strCodTabSel := '';
  blnAltLinGru := False;
  cxgGrupos.Enabled := False;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.FormShow(Sender: TObject);
begin
  inherited;
  lblTabPre.Visible := fCfgSis('TPCHFD', varBoolean);
  edtTabPre.Visible := lblTabPre.Visible;
  clbPrcVenda.Visible := lblTabPre.Visible;
  cxgGruposDBTABPRE.Visible := lblTabPre.Visible;
  pCarregaTabelaPrecos;
end;

function TfrmCadFaixaDescontoLinhaGrupoCliente.fValidaCampos(
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
    Else If (Sender = edtCodCli) Then
    Begin
      If (fEmptyStr(edtCodCli.Text)) Then
      Begin
        fMensagem('AVISO','Código do cliente deve ser preenchido.', ['&OK']);
        Result := False;
      End
      Else If (edtCodCli.Text <> '00000000') And (edtNomCli.Text <> '+1') Then
      Begin
        edtNomCli.Text := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]);

        If (fEmptyStr(edtNomCli.Text)) Then
        Begin
          fMensagem('AVISO','Código do cliente não encontrado.', ['&OK']);
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

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.pHabilitar(
  blnHabilitar: Boolean);
begin
  btnIncluir.Enabled  := blnHabilitar;
  btnGravar.Enabled   := Not blnHabilitar;
  btnExcluir.Enabled  := blnHabilitar;
  btnCancela.Enabled  := Not blnHabilitar;
  btnPesquisa.Enabled := blnHabilitar;

  edtCodTab.Enabled := Not blnHabilitar;
  edtDescri.Enabled := Not blnHabilitar;
  edtCodCli.Enabled := Not blnHabilitar;
  cxgClientes.Enabled := Not blnHabilitar;
  btnConfirmarCliente.Enabled := Not blnHabilitar;

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

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.pLimparDadosCliente;
begin
  edtCodCli.Clear;
  edtNomCli.Clear;
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.pLimparDadosGrupo;
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

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.pLimparTela;
begin
  strCodTabSel := '';
  cdsCliente.EmptyDataSet;
  cdsGrupo.EmptyDataSet;

  edtCodTab.Clear;
  edtDescri.Clear;

  pLimparDadosCliente;
  pLimparDadosGrupo;

  pSetFocus(edtCodTab);
end;

procedure TfrmCadFaixaDescontoLinhaGrupoCliente.pMoveItemParaEdicao;
begin
  edtCodGru.Text   := cdsGrupoHLC_CODGRU.AsString;
  edtDesGru.Text   := fRetNomeLinhaGrupo(cdsGrupoHLC_CODGRU.AsString);
  edtCodUni.Text   := cdsGrupoHLC_CODUNI.AsString;
  edtSigUni.Text   := fRetSiglaUnidade(cdsGrupoHLC_CODUNI.AsString);
  edtCodIte.Text   := cdsGrupoHLC_CODITE.AsString;
  edtDesIte.Text   := fRetNomProduto(cdsGrupoHLC_CODITE.AsString);
  edtDesIni.Text   := FormatFloat(fMskDigitos(4),cdsGrupoHLC_DESINI.AsFloat);
  edtDesFin.Text   := FormatFloat(fMskDigitos(4),cdsGrupoHLC_DESFIN.AsFloat);
  edtComissao.Text := FormatFloat(fMskDigitos(4),cdsGrupoHLC_PERCOM.AsFloat);
  edtTabPre.Text   := cdsGrupoHLC_TABPRE.Text;
end;

end.
