unit untCadGrupos;

interface

uses
  Classes, Controls,
  StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, Menus, Uni, AppEvnts, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, DBComboBoxFocus, QColorLabel,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxImage;

type
  TfrmCadGrupos = class(TfrmPaiCad)
    dbeCodgru: TDBEditFocus;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    Label2: TLabel;
    pnlFundo: TPanel;
    Label4: TLabel;
    dbePerCom: TDBEditFocus;
    Label5: TLabel;
    dtsCadGru: TDataSource;
    lblDesLin: TLabel;
    dbeDesLin: TDBEditFocus;
    lblDesGru: TLabel;
    dbeDesGru: TDBEditFocus;
    dbeDetLin: TDBEditFocus;
    dbeDetGru: TDBEditFocus;
    lblDetLin: TLabel;
    lblDetGru: TLabel;
    lblSgEtGr: TLabel;
    dbeSgEtGr: TDBEditFocus;
    pnlTipo: TPanel;
    lblTipo: TLabel;
    dbeTipGru: TDBEditFocus;
    clbTipGru: TColorLabel;
    pnlImgGru: TPanel;
    lblErrImg: TLabel;
    imgGru: TcxImage;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure imgGruDblClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  function fPodeExcluirLinha(strLinha: String): Boolean;
  procedure pDescricaoResumidaLinGruVisiveis;
    procedure pLimpaImagem;
    procedure pCarregaImagem;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pAfterOpen(DataSet: TDataSet);
  public
    { Public declarations }
  end;

implementation

uses SysUtils, Forms, StrUtils, untfuncoesSimples, untPai, untCadGru, untConsultas,
  untTypesSistema, untFuncoesImagem, untImagens;

{$R *.dfm}

procedure TfrmCadGrupos.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadGrupos.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'CADGRU';
  strNomeCampo        := 'GRU_CODGRU';
  qryTabela           := fCriaQuery(Self);
  qryTabela.AfterOpen := pAfterOpen;
  dtsCadGru.DataSet   := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodGru;

  pDescricaoResumidaLinGruVisiveis;

  pnlTipo.Visible := (fCfgSis('AUTCEN', VarBoolean));
end;

function TfrmCadGrupos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Self, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CODIGO DO GRUPO              *}
    {**************************************MV*}
    If (Sender = dbeCodgru) Then
    Begin
      dbeCodgru.Text := AnsiReplaceText(dbeCodgru.Text, ' ', '');
      If (fEmptyStr(dbeCodGru.Text)) And (dbeCodgru.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do grupo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Length(Trim(dbeCodgru.Text)) <> 6 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do grupo deve ter exatamente 6 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If (Not fVerificaLinhaCadGrupo(dbeCodgru.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa linha não existe! Verifique.', ['&Ok']);
        Result := False;
      End
      Else If (dbeCodGru.Enabled) And (Not fEmptyStr(fCfgSis('FRQLGD', varString))) And (Copy(dbeCodgru.Text, 1, 1) <> fCfgSis('FRQLGD', varString)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O primeiro dígito do Código deve ser [' + fCfgSis('FRQLGD', varString) + ']! Verifique.', ['&Ok']);
        Result := False;
      End
      {*****************************************}
      {* REALIZA BUSCA PELO CODIGO             *}
      {**************************************MV*}
      Else If (blnBuscaPorChave) Then
      Begin
        If fBuscaPorCamposChave Then
          pCarregaImagem
        else
        begin
          pLimparCampos;
          pLimpaImagem;
        end;
      End;
    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO                    *}
    {**************************************MV*}
    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do grupo deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    {*******************************************}
    {* VALIDA A COMISSÃO DO VENDEDOR           *}
    {****************************************MV*}
    Else If (Sender = dbePerCom) Then
    Begin

      If (fEmptyStr(dbePerCom.Text)) Then
      Begin
        dbePerCom.Field.AsFloat := 0.0;
      End
      Else If (Not fValidaEscala(dbePerCom.Text, 0, 99.99)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de comissão deve estar entre 0 e 99!', ['&Ok']);
        Result := False;
      End

    End

    Else If (Sender = dbeTipGru) Then Begin
      If (fCfgSis('AUTCEN', VarBoolean)) And
        (((dbeTipGru.Text <> '0') And (dbeTipGru.Text <> '1') And (dbeTipGru.Text <> '2'))
          Or (fEmptyStr(dbeTipGru.Text))) Then Begin
        fMensagem('ATENÇÃO!', 'O Tipo deve ser 0, 1 ou 2!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;


procedure TfrmCadGrupos.pCarregaImagem;
Begin
  if (qryTabela.Active) And (Not fEmptyStr(qryTabela.FieldByName('GRU_CODGRU').AsString)) Then
  Begin
    imgGru.Picture := nil;
    Application.ProcessMessages;

    Case fCarregaImagemLinhaGrupo(qryTabela.FieldByName('GRU_CODGRU').AsString, imgGru.Picture) of
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

procedure TfrmCadGrupos.imgGruDblClick(Sender: TObject);
begin
  inherited;

  If qryTabela.State = dsInsert Then
  Begin
    fMensagem('', 'Salve a Linha / Grupo antes de cadastrar a imagem!', ['&Ok']);
    Exit;
  End;

  If qryTabela.isEmpty Then
  Begin
    fMensagem('', 'Selecione uma Linha / Grupo para continuar!', ['&Ok']);
    Exit;
  End;

  if qryTabela.Active then
  begin
    TfrmImagens.pAbrirImagens(tiLinhaGrupo, qryTabela.FieldByName('GRU_CODGRU').AsString);
    pCarregaImagem;
  end;

end;

procedure TfrmCadGrupos.pLimpaImagem;
begin
  imgGru.Picture := Nil;
  imgGru.Visible := False;
  lblErrImg.Visible := False;
end;

procedure TfrmCadGrupos.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet do
  Begin
    If Active Then
    Begin
      If FindField('GRU_CODGRU') <> nil Then
        TStringField(FieldByName('GRU_CODGRU')).EditMask := '999.999;0;_';

      If FindField('GRU_PERCOM') <> nil Then
        TFloatField(FieldByName('GRU_PERCOM')).DisplayFormat := '#,##0.00';
    End;
  End;
end;

procedure TfrmCadGrupos.pDescricaoResumidaLinGruVisiveis;
begin
  // utiliza modulo industrial
  dbeDesLin.Visible := fCfgSis('UTIIND', varBoolean);
  lblDesLin.Visible := dbeDesLin.Visible;
  dbeDesGru.Visible := dbeDesLin.Visible;
  lblDesGru.Visible := dbeDesLin.Visible;
  dbeDetLin.Visible := dbeDesLin.Visible;
  lblDetLin.Visible := dbeDesLin.Visible;
  dbeDetGru.Visible := dbeDesLin.Visible;
  lblDetGru.Visible := dbeDesLin.Visible;
  dbeSgEtGr.Visible := dbeDesLin.Visible;
  lblSgEtGr.Visible := dbeDesLin.Visible;
  if not dbeDesLin.Visible then
    Self.Height := 188;
end;

procedure TfrmCadGrupos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('GRU_CODGRU');
  stlCampos.Add('GRU_DESGRU');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('GRU_DESGRU');
  stlCamInd.Add('GRU_CODGRU');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadGrupos.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodgru, dbeCodgru, True);

  If (dbeCodgru.Enabled) And (Not fEmptyStr(fCfgSis('FRQLGD', varString))) Then Begin
    dbeCodgru.Text := fCfgSis('FRQLGD', varString);
  End;

  If (fCfgSis('AUTCEN', VarBoolean)) Then
    dbeTipGru.Text := '0'
  Else
    dbeTipGru.Text := '';

  pLimpaImagem;
end;

procedure TfrmCadGrupos.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrGrupos: TConsultasArray;
begin
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  chrKey := '/';
  If fPesqGrupo(Self, dbeCodGru, Nil, qryTabela, chrKey, arrGrupos, True, dbeDesLin.Visible) Then
  Begin
    pCarregaImagem;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadGrupos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodgru, dbeDescri, False);
end;

{*****************************************}
{* RETORNA QUANTOS GRUPOS TEM EM DETER-  *}
{* NADA LINHA                            *}
{**************************************MV*}
function TfrmCadGrupos.fPodeExcluirLinha(strLinha: String): Boolean;
  Var
    strSQL   : String;
    strTemp  : String;
    qryGenGru: TUniQuery;

begin
  Try

    qryGenGru := fCriaQuery(Self);


    strTemp := LeftStr(strLinha, 3) + '%';
    Result := True;

    {*****************************************}
    {* É UM GRUPO, PORTANTO PODE EXCLUIR     *}
    {**************************************MV*}
    If RightStr(strLinha, 3) <> '000' Then
    Begin
      Exit;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADGRU ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GRU_CODGRU LIKE :CODGRU ';

    With qryGenGru Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODGRU').AsString := strTemp;
      Open;
      If FieldByName('QTD').AsInteger <= 1 Then
        Result := True
      Else
        Result := False;
      Close;
    End;

  Finally
    FreeAndNil(qryGenGru);
  End;            

end;

procedure TfrmCadGrupos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaImagem;
end;

procedure TfrmCadGrupos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If fPodeExcluirLinha(qryTabela.FieldByName('GRU_CODGRU').AsString) Then
  Begin
    inherited;
    if qryTabela.isEmpty then
      pLimpaImagem;
  End
  Else
  Begin
    fMensagem('', 'Há grupos relacionados a essa linha! Verifique.', ['&Ok']);
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGrupos.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadGrupos.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadGrupos.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

end;

end.

