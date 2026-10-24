unit untCadTiposOcorrencias;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, DB, Mask, DBCtrls, DBEditFocus, EditFocus, Uni,
  ExtDlgs, QColorLabel, BitBtnLockedIncrem, Dialogs, frxClass,
  frxExportCSVTestabilidade, MaskEditFocus, MemDS, DBAccess;

type
  TfrmCadTiposOcorrencias = class(TfrmPaiCad)
    pnlGeral: TPanel;
    dtsCadToc: TDataSource;
    dbeCodGoc: TDBEditFocus;
    edtDesCodGoc: TEditFocus;
    pnlImgPro: TPanel;
    imgPro: TImage;
    dbeDesToc: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    SalvaImagem: TSavePictureDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeAtivo: TDBEditFocus;
    ColorLabel22: TColorLabel;
    btnImportar: TBitBtnLocked;
    Label5: TLabel;
    Label6: TLabel;
    dbeTmpLim: TDBEditFocus;
    grbUsarEm: TGroupBox;
    dbcUsaCli: TDBCheckBox;
    dbcUsaPro: TDBCheckBox;
    dbcUsaFor: TDBCheckBox;
    dbcUsaGlo: TDBCheckBox;
    Label7: TLabel;
    dbeEnvEma: TDBEditFocus;
    ColorLabel1: TColorLabel;
    lblEmailDestino: TLabel;
    dbeEnvEmaDest: TDBEditFocus;
    lblDescEmailDestino: TColorLabel;
    lblSolTempAtendimento: TLabel;
    dbeSolTempAtend: TDBEditFocus;
    lblIdentSolTempAtendimento: TColorLabel;
    lblGerCom: TLabel;
    dbeGerCom: TDBEditFocus;
    cllGerCom: TColorLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure dbeCodGocKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodGocExit(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    qryCadGoc: TUniQuery;
    procedure pCarregaGrupoOcorrencia;
    procedure pCarregaImagem;
    function fExisteDiretorio(strCaminho: String): Boolean;

    procedure pTmpLimGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pTmpLimSetText(Sender: TField; const Text: string);
    procedure pAfterOpenQryTabela(DataSet: TDataSet);
    procedure pSetEnabledUsarEm;
    procedure pCarregaConfiguracoesDeTiposDeOcorrencias(stlConfigs: TStringList);
  protected
    procedure pInicializaIndices; override;
    function fExecutaAntesDoDelete: Boolean; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, Graphics, untFuncoesSimples, untConsultas, untPesqAux, untTypesSistema;

{$R *.dfm}

procedure TfrmCadTiposOcorrencias.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesToc, False);
  pSetEnabledUsarEm;
end;

procedure TfrmCadTiposOcorrencias.btnCancelaClick(Sender: TObject);
begin
  inherited;
  if fEmptyStr(dbeCodGoc.Text) then
    edtDesCodGoc.Clear;

  btnImportar.Enabled := (not qryTabela.IsEmpty);
  pCarregaImagem;
  pCarregaGrupoOcorrencia;
end;

procedure TfrmCadTiposOcorrencias.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTiposOcorrencias.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  btnImportar.Enabled := (not qryTabela.IsEmpty);
  pCarregaImagem;
  pCarregaGrupoOcorrencia;
end;

procedure TfrmCadTiposOcorrencias.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadTiposOcorrencias.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  btnImportar.Enabled := True;
end;

procedure TfrmCadTiposOcorrencias.btnImportarClick(Sender: TObject);
begin
  if not qryTabela.IsEmpty then
  begin
    if fExisteDiretorio(ExtractFilePath(Application.ExeName) + 'Imagens_crm\') then
    begin
      SalvaImagem.InitialDir := ExtractFileDrive(Application.ExeName);
      if SalvaImagem.Execute then
        If (SalvaImagem.FileName <> '') And ((ExtractFilePath(SalvaImagem.Filename) <> ExtractFilePath(Application.ExeName))) Then
        begin
          CopyFile( PChar(SalvaImagem.FileName), PChar( ExtractFilePath(Application.ExeName) + 'Imagens_crm\' + 'TOC_' + qryTabela.FieldByName('TOC_CODTOC').AsString + '.jpg'), False);
          pCarregaImagem;
        end;
    end;
  end;
end;

procedure TfrmCadTiposOcorrencias.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDesToc, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  btnImportar.Enabled := False;


  qryTabela.FieldByName('TOC_ATIVO_').AsString := 'S';
  qryTabela.FieldByName('TOC_ENVEMA').AsString := 'S';
  qryTabela.FieldByName('TOC_TMPLIM').AsInteger:= fCfgSis('RESOCO', varInteger) * 3600;

  qryTabela.FieldByName('TOC_USACLI').AsString := 'S';
  qryTabela.FieldByName('TOC_USAPRO').AsString := 'S';
  qryTabela.FieldByName('TOC_USAFOR').AsString := 'S';
  qryTabela.FieldByName('TOC_USAGLO').AsString := 'S';
  qryTabela.FieldByName('TOC_EMADES').AsString := 'S';
  qryTabela.FieldByName('TOC_TMPATD').AsString := 'N';
  qryTabela.FieldByName('TOC_GERCOM').AsString := 'N';


  imgPro.Picture := Nil;
  edtDesCodGoc.Clear;
end;

procedure TfrmCadTiposOcorrencias.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrTOcorr: TConsultasArray;
begin
  {**************************************}
  {* NOVA CONSULTA TIPOS DE OCORRENCIAS *}
  {***********************************AC*}
  chrKey := '/';
  If fPesqTiposOcorrencias(Self, Nil, Nil, qryTabela, chrKey, arrTOcorr, True, '', False) Then
  Begin
    pSetFocus(btnAlterar);
    pCarregaImagem;
    pCarregaGrupoOcorrencia;
    btnImportar.Enabled := True;
  End;

end;

procedure TfrmCadTiposOcorrencias.dbeCodGocExit(Sender: TObject);
begin
  inherited;
  pSetEnabledUsarEm;
end;

procedure TfrmCadTiposOcorrencias.dbeCodGocKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTOcorr: TConsultasArray;
begin
  inherited;
  {***************************************}
  {* NOVA CONSULTA GRUPOS DE OCORRENCIAS *}
  {************************************AC*}
  If fPesqGruposOcorrencias(Self, dbeCodGoc, edtDesCodGoc, nil, Key, arrTOcorr) Then
  Begin
    If fValidaCampos(dbeCodGoc, True) Then
      SelectNext(ActiveControl, True, True);
    pCarregaImagem;
  End;
end;

function TfrmCadTiposOcorrencias.fExisteDiretorio(strCaminho: String): Boolean;
begin
  Result := True;
  If Not( DirectoryExists(strCaminho) ) Then
    If Not( fCriaDiretorio(strCaminho) ) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é possível criar/carregar a pasta do cliente!!!'            +#13+
                            'Talvez você não tenha permissão de leitura/gravação na pasta!!!'+#13+
                            'Procure o Administrador do Sistema e informe este erro: '       +#13+
                            'Não conseguiu criar a pasta ' + strCaminho, ['&Ok']);
      Result := False;
    End;
end;

procedure TfrmCadTiposOcorrencias.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadGoc);
end;

procedure TfrmCadTiposOcorrencias.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADTOC';
  strNomeCampo      := 'TOC_CODTOC';
  qryTabela         := fCriarQuery('SELECT * FROM CADTOC', Self);
  dtsCadToc.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  qryTabela.AfterOpen := pAfterOpenQryTabela;

end;

procedure TfrmCadTiposOcorrencias.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
  btnImportar.Enabled := False;

  If Not(fCfgSis('CRMTEA', varBoolean)) Then
  Begin
    lblSolTempAtendimento.Visible := False;
    dbeSolTempAtend.Visible := False;
    lblIdentSolTempAtendimento.Visible := False;
  End;

  If Not(fCfgSis('CGCODO', varBoolean)) Then
  Begin
    lblGerCom.Visible := False;
    dbeGerCom.Visible := False;
    cllGerCom.Visible := False;
  End;

end;

function TfrmCadTiposOcorrencias.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Tipo de Ocorrência deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else
    If (Sender = dbeDesToc) Then
    Begin
      If fEmptyStr(dbeDesToc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Tipo de Ocorrência deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = dbeCodGoc) Then
    Begin
      If fEmptyStr(dbeCodGoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Grupo de Ocorrência deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaGrupoOcorrencia;
        If qryCadGoc.FieldByName('GOC_CODGOC').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Grupo de Ocorrência não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;

      pSetEnabledUsarEm;

    End

    Else
    If (Sender = dbeAtivo) Then
    Begin
      If fEmptyStr(dbeAtivo.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Ativo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If Pos(dbeAtivo.Text,'SN') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Ativo deve ser preenchido com S ou N!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = dbeEnvEma) Then
    Begin
      If fEmptyStr(dbeEnvEma.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Enviar ocorrência por e-mail deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If Pos(dbeEnvEma.Text,'SN') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Enviar ocorrência por e-mail deve ser preenchido com S ou N!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = dbeGerCom) And (dbeGerCom.Visible) Then
    Begin
      If fEmptyStr(dbeGerCom.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Gerar Compromisso?" deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If Pos(dbeGerCom.Text,'SN') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo "Gerar Compromisso?" deve ser preenchido com S ou N!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadTiposOcorrencias.pCarregaGrupoOcorrencia;
begin
  pPesquisaCadGOc(nil, qryCadGoc, dbeCodGoc.Text);
  With qryCadGoc Do
  Begin
    edtDesCodGoc.Text := FieldByName('GOC_DESGOC').AsString;
  End;
end;

procedure TfrmCadTiposOcorrencias.pCarregaImagem;
begin
  if not qryTabela.IsEmpty And FileExists(ExtractFilePath(Application.ExeName) + 'Imagens_crm\' + 'TOC_' + qryTabela.FieldByName('TOC_CODTOC').AsString + '.jpg') then
    imgPro.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Imagens_crm\' + 'TOC_' + qryTabela.FieldByName('TOC_CODTOC').AsString + '.jpg')
  else
    imgPro.Picture := Nil;
end;

procedure TfrmCadTiposOcorrencias.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('TOC_CODTOC');
  stlCampos.Add('TOC_DESTOC');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('TOC_DESTOC');
  stlCamInd.Add('TOC_CODTOC');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Tipo Ocorrência');

  qryCadGoc := fCriarQuery('SELECT * FROM CADGOC WHERE FALSE', Self);
end;

procedure TfrmCadTiposOcorrencias.pTmpLimGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
  Var
    strHraMin : String;
begin
  inherited;
  If Sender.AsInteger > 0 Then
  Begin
    strHraMin := fSegToTempoStr( Sender.AsInteger );

    strHraMin := Copy( strHraMin, 1, Length(strHraMin) - 3 );

    If Length(strHraMin) = 5 Then
      strHraMin := '0' + strHraMin;

    Text := strHraMin;
  End
  Else
    Text := '00:00';
end;

procedure TfrmCadTiposOcorrencias.pTmpLimSetText(Sender: TField;
  const Text: string);
begin
  inherited;
  Sender.AsInteger := (StrToIntDef( Copy(Text, 1, 3),0) * 3600) + (StrToIntDef( Copy(Text, 5, 2),0) * 60);
  If Sender.AsInteger > 3599940 Then
    Sender.AsInteger := 3599940;

end;

procedure TfrmCadTiposOcorrencias.pAfterOpenQryTabela(DataSet: TDataSet);
Begin
  TIntegerField(qryTabela.FieldByName('TOC_TMPLIM')).OnGetText := pTmpLimGetText;
  TIntegerField(qryTabela.FieldByName('TOC_TMPLIM')).OnSetText := pTmpLimSetText;

  TIntegerField(qryTabela.FieldByName('TOC_TMPLIM')).EditMask := '!9!99:99;9;_';

End;

procedure TfrmCadTiposOcorrencias.pSetEnabledUsarEm;
Begin
  dbcUsaCli.Enabled := fCampoTabela('GOC_USACLI', 'CADGOC', ['GOC_CODGOC'], [qryTabela.FieldByName('TOC_CODGOC').AsString]) = 'S';
  dbcUsaPro.Enabled := fCampoTabela('GOC_USAPRO', 'CADGOC', ['GOC_CODGOC'], [qryTabela.FieldByName('TOC_CODGOC').AsString]) = 'S';
  dbcUsaFor.Enabled := fCampoTabela('GOC_USAFOR', 'CADGOC', ['GOC_CODGOC'], [qryTabela.FieldByName('TOC_CODGOC').AsString]) = 'S';

  If (qryTabela.State in DsEditModes) Then
  Begin
    If (not dbcUsaCli.Enabled) And dbcUsaCli.Checked then
      dbcUsaCli.Field.AsString := 'N';

    If (not dbcUsaPro.Enabled) And dbcUsaPro.Checked then
      dbcUsaPro.Field.AsString := 'N';

    If (not dbcUsaFor.Enabled) And dbcUsaFor.Checked then
      dbcUsaFor.Field.AsString := 'N';
  End;

End;

function TfrmCadTiposOcorrencias.fExecutaAntesDoDelete: Boolean;
  Var
    stlConfigs: TStringList;
    intCont: Integer;
begin
  Result := False;
  stlConfigs := TStringList.Create;

  Try
    pCarregaConfiguracoesDeTiposDeOcorrencias(stlConfigs);

    For intCont := 0 To Pred(stlConfigs.Count) Do
    Begin
      If (Pos(dbeCodigo.Text, stlConfigs[intCont]) > 0) Then
      Begin
        fMensagem('ATENÇÃO!','Este Tipo de Ocorrência está sendo utilizado na configuração '+
                             'CFG_'+ Copy(stlConfigs[intCont], 0, 6) + '. Para prosseguir, '+
                             'ajuste a configuração.', ['&Ok']);
        Exit;
      End;
    End;

    Result := True;
  Finally
    FreeAndNil(stlConfigs);
  End;
end;

procedure TfrmCadTiposOcorrencias.pCarregaConfiguracoesDeTiposDeOcorrencias(stlConfigs: TStringList);
begin
  stlConfigs.Add('VENORC - ' + fCfgSis('VENORC'));
  stlConfigs.Add('VENPED - ' + fCfgSis('VENPED'));
  stlConfigs.Add('VENVN_ - ' + fCfgSis('VENVN_'));
  stlConfigs.Add('VENDEV - ' + fCfgSis('VENDEV'));
  stlConfigs.Add('VENCAN - ' + fCfgSis('VENCAN'));
  stlConfigs.Add('PEDCAN - ' + fCfgSis('PEDCAN'));
  stlConfigs.Add('OCODMP - ' + fCfgSis('OCODMP'));
  stlConfigs.Add('TOCEMA - ' + fCfgSis('TOCEMA'));
  stlConfigs.Add('TOC_TR - ' + fCfgSis('TOC_TR'));
  stlConfigs.Add('TOCLCR - ' + fCfgSis('TOCLCR'));
  stlConfigs.Add('OCOSEP - ' + fCfgSis('OCOSEP'));
  stlConfigs.Add('CRMPR_ - ' + fCfgSis('CRMPR_'));
  stlConfigs.Add('OCOPSQ - ' + fCfgSis('OCOPSQ'));
  stlConfigs.Add('OCOFIN - ' + fCfgSis('OCOFIN'));
end;

end.
