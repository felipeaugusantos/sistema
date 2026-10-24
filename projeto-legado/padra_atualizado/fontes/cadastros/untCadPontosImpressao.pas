unit untCadPontosImpressao;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, DB, Mask, DBCtrls, DBEditFocus,
  BitBtnLockedIncrem, Uni, Clipbrd, SysUtils, strUtils, DateUtils,
  DBComboBoxFocus, frxClass, frxExportCSVTestabilidade, ComboBoxFocus, EditFocus,
  Vcl.CheckLst;

type
  TOpcSelecao = (opcMarcar, opcDesmarcar, opcInverter);

  TfrmCadPontosImpressao = class(TfrmPaiCad)
    pnlGeral: TPanel;
    Label1: TLabel;
    dbeCodPon: TDBEditFocus;
    Label2: TLabel;
    dbeNomPon: TDBEditFocus;
    dtsCadPon: TDataSource;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblEndMac: TLabel;
    lblNomMaq: TLabel;
    lblNomUsu: TLabel;
    btnGerTok: TSpeedButton;
    btnLibTok: TSpeedButton;
    gpbEmpDis: TGroupBox;
    lblEmpDis: TLabel;
    clbEmpDis: TCheckListBox;
    popSelEmp: TPopupMenu;
    MarcarTodos1: TMenuItem;
    DesmarcarTodos1: TMenuItem;
    N1: TMenuItem;
    InverterSeleo1: TMenuItem;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGerTokClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnLibTokClick(Sender: TObject);
    procedure lblEmpDisClick(Sender: TObject);
    procedure MarcarTodos1Click(Sender: TObject);
    procedure DesmarcarTodos1Click(Sender: TObject);
    procedure InverterSeleo1Click(Sender: TObject);
  private
    clbSelecionado: TCheckListBox;
    blnCampoEmpDisExiste: Boolean;
    strUltimaComunicacao: String;
  private
    function fPontoJaCadastrado(): Boolean;
    procedure pAtualizarInformacoes;
    procedure pAbrirPoup;
    procedure pCarregaLstEmpresa;
    procedure pSetaCheckList(CheckListBox: TCheckListBox);
    procedure pAtualizaLstEmpresa(strNomCam: String; clbEmpresa: TCheckListBox);
    function fRetEmpresasSel(clbEmpresa: TCheckListBox): String;
    procedure pExecutarSelecao(Opcao: TOpcSelecao);
    procedure pMarcaDesmarca(Opcao: Boolean);
    procedure pInverteSelecao;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
      override;
  public
    { Public declarations }
  end;

var
  frmCadPontosImpressao: TfrmCadPontosImpressao;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untSpoolImpressao,
  untModulo;

{$R *.dfm}

procedure TfrmCadPontosImpressao.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodPon, dbeNomPon, False);
  pAtualizarInformacoes;
end;

procedure TfrmCadPontosImpressao.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodPon, dbeNomPon, False)
  Else
    pHabilitaCodigo(dbeCodPon, dbeCodPon, True);
  pAtualizarInformacoes;
end;

procedure TfrmCadPontosImpressao.btnLibTokClick(Sender: TObject);
begin
  inherited;
  Try
    If (qryTabela.State In [dsBrowse]) And (Not qryTabela.IsEmpty) Then
    Begin
      qryTabela.Refresh;

      if qryTabela.FindField('PON_ULTCOM') <> nil then
        if not qryTabela.FindField('PON_ULTCOM').IsNull then
          if strUltimaComunicacao <> qryTabela.FindField('PON_ULTCOM').AsString then
          begin
            pMensagemOk('Serviço do spooler de impressão Citel ainda está '+
              'sendo executado no computador "' + qryTabela.FieldByName('PON_NOMMAQ').AsString +
              '".'+ sLineBreak + 'Favor remover o serviço deste computador antes de liberar o ponto de impressão '+
              'para uma nova instalação!');
            Exit;
          end;

      if fPergunta('Confirma liberar ponto de impressão para uma nova instalação?') Then
      Begin
        qryTabela.Edit;
        qryTabela.FieldByName('PON_MACADD').Clear;
        qryTabela.FieldByName('PON_NOMMAQ').Clear;
        qryTabela.FieldByName('PON_NOMUSU').Clear;
        qryTabela.Post;
      End;
    End;
  Finally
    pAtualizarInformacoes;
  End;
end;

procedure TfrmCadPontosImpressao.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrPon: TConsultasArray;
begin
  chrKey := '/';
  If fPesqPontosImpressao(Self, Nil, Nil, qryTabela, chrKey, arrPon) Then
  Begin
    pSetFocus(btnAlterar);
    pAtualizarInformacoes;
  End;
end;

procedure TfrmCadPontosImpressao.DesmarcarTodos1Click(Sender: TObject);
begin
  inherited;
  pExecutarSelecao(opcDesmarcar);
end;

procedure TfrmCadPontosImpressao.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pAtualizarInformacoes;
end;

procedure TfrmCadPontosImpressao.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pAtualizarInformacoes;
end;

procedure TfrmCadPontosImpressao.btnGerTokClick(Sender: TObject);
begin
  inherited;
  Try
    Clipboard.AsText := TSpoolImpressaoCitel.fGerarToken(dbeNomPon.Text);
    pMensagemOk('Token copiado para área de transferência com sucesso!');
  Except
    On E: Exception Do
      pMensagemOk(E.Message);
  End;
end;

procedure TfrmCadPontosImpressao.btnGravarClick(Sender: TObject);
begin
  if not dbeNomPon.Field.AsString.StartsWith(VS_strCodEmp) then
    dbeNomPon.Field.AsString := VS_strCodEmp + '_' + dbeNomPon.Field.AsString;

  dbeNomPon.Field.AsString := dbeNomPon.Field.AsString.Replace(' ', '_');

  if blnCampoEmpDisExiste then
    qryTabela.FieldByName('PON_EMPDIS').Value := fRetEmpresasSel(clbEmpDis);

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadPontosImpressao.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pAtualizarInformacoes;
end;

Function TfrmCadPontosImpressao.fRetEmpresasSel(clbEmpresa: TCheckListBox): String;
  Var
    intContador : Integer;
Begin
  Result := '';
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    If clbEmpresa.Checked[intContador] Then
      Result := Result + LeftStr(clbEmpresa.Items[intContador],3) + '_';
  End;
End;

procedure TfrmCadPontosImpressao.pCarregaLstEmpresa;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    clbEmpDis.Items.Clear;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM FROM CADEMP WHERE EMP_CODEMP <> "' + VS_strCodEmp + '"');
    qryGen.Open;
    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      clbEmpDis.Items.Add(qryGen.FieldByName('EMPNOM').AsString);
      qryGen.Next;
    End;
    qryGen.Close;
  Finally
    FreeAndNil(qryGen);
  End;
End;

function TfrmCadPontosImpressao.fPontoJaCadastrado: Boolean;
Var
  qryGen: TUniQuery;
begin
  inherited;
  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Text := 'SELECT PON_CODPON FROM CADPON WHERE ' +
      'PON_NOMPON = :NOMPON AND PON_CODPON <> :CODPON LIMIT 1';

    qryGen.ParamByName('NOMPON').AsString := dbeNomPon.Text;
    qryGen.ParamByName('CODPON').AsString := dbeCodPon.Text;
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Finally
    qryGen.Free;
  End;
end;

procedure TfrmCadPontosImpressao.FormCreate(Sender: TObject);
begin
  inherited;
  blnCampoEmpDisExiste := fCampoExiste('CADPON', 'PON_EMPDIS', True);
  pCarregaLstEmpresa;
  strNomeTabela := 'CADPON';
  strNomeCampo := 'PON_CODPON';
  qryTabela := fCriarQuery('SELECT * FROM CADPON WHERE FALSE', Self);
  dtsCadPon.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodPon;

  if not blnCampoEmpDisExiste then
  begin
    gpbEmpDis.Visible := False;
    Self.ClientHeight := Self.ClientHeight - gpbEmpDis.Height;
  end;
end;

procedure TfrmCadPontosImpressao.FormShow(Sender: TObject);
begin
  inherited;
  btnIncluir.Enabled := True;
  pAtualizarInformacoes;
end;

function TfrmCadPontosImpressao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodPon) Then
    Begin
      If (fEmptyStr(dbeCodPon.Text)) And (dbeCodPon.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Ponto de Impressão deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeNomPon) Then
    Begin
      If fEmptyStr(dbeNomPon.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome do Ponto de Impressão deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fPontoJaCadastrado Then
      Begin
        fMensagem('ATENÇÃO!', 'Já foi cadastrado um Ponto de Impressão com esse nome!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadPontosImpressao.InverterSeleo1Click(Sender: TObject);
begin
  inherited;
  pExecutarSelecao(opcInverter);
end;

procedure TfrmCadPontosImpressao.pAbrirPoup;
begin
  popSelEmp.Popup(Mouse.CursorPos.X + 2, Mouse.CursorPos.Y + 2);
end;

procedure TfrmCadPontosImpressao.pExecutarSelecao(Opcao: TOpcSelecao);
begin
  case Opcao of
    opcMarcar:    pMarcaDesmarca(True);
    opcDesmarcar: pMarcaDesmarca(False);
    opcInverter:  pInverteSelecao;
  End;
end;


procedure TfrmCadPontosImpressao.lblEmpDisClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbEmpDis);
  pAbrirPoup;
end;

procedure TfrmCadPontosImpressao.MarcarTodos1Click(Sender: TObject);
begin
  inherited;
  pExecutarSelecao(opcMarcar);
end;

procedure TfrmCadPontosImpressao.pSetaCheckList(CheckListBox : TCheckListBox);
begin
  clbSelecionado := CheckListBox;
end;

procedure TfrmCadPontosImpressao.pAtualizaLstEmpresa(strNomCam: String; clbEmpresa: TCheckListBox);
Var
  intContador: Integer;
  intFocus   : Integer;
  strEmpSel  : String;
begin
  intFocus := -1;
  strEmpSel := qryTabela.FieldByName(strNomCam).AsString;
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    If (Pos(LeftStr(clbEmpresa.Items[intContador],3), strEmpSel) > 0) Then
    Begin
      If intFocus = -1 Then
        intFocus := intContador;
      clbEmpresa.Checked[intContador] := True;
    End
    Else
      clbEmpresa.Checked[intContador] := False;
  End;
  clbEmpresa.ItemIndex := intFocus;
end;

procedure TfrmCadPontosImpressao.pAtualizarInformacoes;
begin
  if blnCampoEmpDisExiste then
    pAtualizaLstEmpresa('PON_EMPDIS', clbEmpDis);

  btnGerTok.Enabled := (qryTabela.State In [dsBrowse]) And (Not qryTabela.IsEmpty);

  btnLibTok.Enabled := (qryTabela.State in [dsBrowse]) And
    (Not qryTabela.FieldByName('PON_MACADD').AsString.IsEmpty);

  btnExcluir.Enabled := (qryTabela.State In [dsBrowse]) And (Not qryTabela.IsEmpty) And
    qryTabela.FieldByName('PON_MACADD').AsString.IsEmpty;

  dbeNomPon.Enabled := (qryTabela.State In [dsEdit, dsInsert]) And
    qryTabela.FieldByName('PON_MACADD').AsString.IsEmpty;

  clbEmpDis.Enabled := (qryTabela.State In [dsEdit, dsInsert]);
  lblEmpDis.Enabled := (qryTabela.State In [dsEdit, dsInsert]);

  lblEndMac.Caption := qryTabela.FieldByName('PON_MACADD').AsString;
  lblNomMaq.Caption := qryTabela.FieldByName('PON_NOMMAQ').AsString;
  lblNomUsu.Caption := qryTabela.FieldByName('PON_NOMUSU').AsString;

  if qryTabela.FindField('PON_ULTCOM') <> nil then
    strUltimaComunicacao := qryTabela.FindField('PON_ULTCOM').AsString;
end;

procedure TfrmCadPontosImpressao.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('PON_CODPON');
  stlCampos.Add('PON_NOMPON');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('PON_NOMPON');
  stlCamInd.Add('PON_CODPON');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadPontosImpressao.pInverteSelecao;
var
  intCount: Integer;
begin
  If Assigned(clbSelecionado) Then
  Begin
    For intCount := 0 to clbSelecionado.Items.Count - 1 Do
    Begin
      If clbSelecionado.Checked [intCount] = True then
        clbSelecionado.Checked [intCount] := False
      Else
        clbSelecionado.Checked [intCount] := True;
    End;
  End;
end;

procedure TfrmCadPontosImpressao.pMarcaDesmarca(Opcao: Boolean);
var
  intCount: Integer;
begin
  If Assigned(clbSelecionado) Then
  Begin
    for intCount := 0 to clbSelecionado.Items.Count - 1 do
      clbSelecionado.Checked [intCount] := Opcao;
  End;
end;

end.
