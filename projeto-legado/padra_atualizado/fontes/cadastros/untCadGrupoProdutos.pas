unit untCadGrupoProdutos;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, Mask, DBCtrls, DBEditFocus, DB,
  frxClass, frxExportCSVTestabilidade, SysUtils, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxImage;

type
  TfrmCadGrupoProdutos = class(TfrmPaiCad)
    pnlGeral: TPanel;
    dtsTabela: TDataSource;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDesGru: TDBEditFocus;
    pnlFornecedor: TPanel;
    Label7: TLabel;
    dbeCodFor: TDBEditFocus;
    edtNomFor: TEditFocus;
    pnlImgGru: TPanel;
    lblErrImg: TLabel;
    imgGru: TcxImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure imgGruDblClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    procedure pLimpaImagem;
    procedure pCarregaImagem;
  public
    { Public declarations }
  Protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

Uses untFuncoesSimples, untConsultas, untTypesSistema, untFuncoesImagem, untImagens;

{$R *.dfm}

procedure TfrmCadGrupoProdutos.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodigo, dbeDesGru, False);
end;

procedure TfrmCadGrupoProdutos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaImagem;
end;

procedure TfrmCadGrupoProdutos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
    if qryTabela.isEmpty then
      pLimpaImagem;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadGrupoProdutos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGrupoProdutos.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadGrupoProdutos.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGrupoProdutos.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodigo, dbeDesGru, False);
  edtNomFor.Text := '';

  pLimpaImagem;
end;

procedure TfrmCadGrupoProdutos.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrGprPro : TConsultasArray;
begin
//  inherited;

  {*************************************}
  {* NOVA CONSULTA DE GRUPO DE PRODUTO *}
  {**********************************G03}
  chrKey := '/';
  If fPesqGrupoProduto(Self, nil, nil, qryTabela, chrKey, arrGprPro) Then
  Begin
    pCarregaImagem;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadGrupoProdutos.dbeCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, dbeCodFor, Nil, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbeCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadGrupoProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'GRPPRD';
  strNomeCampo      := 'PRD_CODGRU';

  qryTabela         := fCriarQuery('SELECT * FROM GRPPRD', Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  pnlFornecedor.Visible := fCfgSis('TABPRD', varBoolean);
  If Not pnlFornecedor.Visible Then
    Self.Height := Self.Height - pnlFornecedor.Height + 16
  Else
  Begin
    pnlFornecedor.Top := dbeDesGru.Top + dbeDesGru.Height + 2;
  End;
end;

procedure TfrmCadGrupoProdutos.FormShow(Sender: TObject);
begin
  inherited;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

function TfrmCadGrupoProdutos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodigo) And (dbeCodigo.Enabled) And (fEmptyStr(dbeCodigo.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código deve ser informado!', ['&OK']);
      Result := False;
    End

    Else If (Sender = dbeDesGru) And (dbeDesGru.Enabled) And (fEmptyStr(dbeDesGru.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Descrição deve ser informada!', ['&OK']);
      Result := False;
    End

    Else If (Sender = dbeCodFor) Then
    Begin

      If pnlFornecedor.Visible Then
      Begin

        If fEmptyStr(dbeCodFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Fornecedor deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          edtNomFor.Text := fRetNomFornecedor(dbeCodFor.Text);

          If fEmptyStr(edtNomFor.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;

      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadGrupoProdutos.imgGruDblClick(Sender: TObject);
begin
  inherited;

  If qryTabela.State = dsInsert Then
  Begin
    fMensagem('', 'Salve o Grupo antes de cadastrar a imagem!', ['&Ok']);
    Exit;
  End;

  If qryTabela.isEmpty Then
  Begin
    fMensagem('', 'Selecione o Grupo para continuar!', ['&Ok']);
    Exit;
  End;

  if qryTabela.Active And (qryTabela.State = dsEdit) then
  begin
    TfrmImagens.pAbrirImagens(tiGrupoProduto, qryTabela.FieldByName('PRD_CODGRU').AsString);
    pCarregaImagem;
  end;

end;

procedure TfrmCadGrupoProdutos.pLimpaImagem;
begin
  imgGru.Picture := Nil;
  imgGru.Visible := False;
  lblErrImg.Visible := False;
end;

procedure TfrmCadGrupoProdutos.pCarregaImagem;
Begin
  if (qryTabela.Active) And (Not fEmptyStr(qryTabela.FieldByName('PRD_CODGRU').AsString)) Then
  Begin
    imgGru.Picture := nil;
    Application.ProcessMessages;

    Case fCarregaImagemGrupoProduto(qryTabela.FieldByName('PRD_CODGRU').AsString, imgGru.Picture) of
      riOk   :
      Begin
        imgGru.Visible := True;
        lblErrImg.Visible := False;
      End;
      riErro :
      Begin
        imgGru.Visible := False;
        lblErrImg.Visible := True;
      End;
      riNulo :
      Begin
        imgGru.Visible := False;
        lblErrImg.Visible := False;
      End;
    End;
  End
  Else
    imgGru.Picture := nil;

  Application.ProcessMessages;
End;

procedure TfrmCadGrupoProdutos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('PRD_CODGRU');
  stlCampos.Add('PRD_DESGRU');
  stlCampos.Add('PRD_CODEMP');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('PRD_CODGRU');
  stlCamInd.Add('PRD_DESGRU');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

end.
