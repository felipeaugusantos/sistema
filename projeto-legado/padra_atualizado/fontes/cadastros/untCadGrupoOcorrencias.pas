unit untCadGrupoOcorrencias;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, Mask, DBCtrls, DBEditFocus, DB, ExtDlgs, BitBtnLockedIncrem,
  Dialogs, frxClass, frxExportCSVTestabilidade, Uni;

type
  TfrmCadGrupoOcorrencias = class(TfrmPaiCad)
    pnlGeral: TPanel;
    pnlImgPro: TPanel;
    imgPro: TImage;
    dtsCadGoc: TDataSource;
    SalvaImagem: TSavePictureDialog;
    Label1: TLabel;
    Label2: TLabel;
    btnImportar: TBitBtnLocked;
    dbeDesGoc: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    grbUsarEm: TGroupBox;
    dbcUsaCli: TDBCheckBox;
    dbcUsaPro: TDBCheckBox;
    dbcUsaFor: TDBCheckBox;
    btnDirAce: TBitBtnLocked;
    procedure btnImportarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbcUsaCliClick(Sender: TObject);
    procedure btnDirAceClick(Sender: TObject);
  private
    { Private declarations }
    blnClickExit : Boolean;
    procedure pCarregaImagem;
    function fExisteDiretorio(strCaminho: String): Boolean;
    function fUpdateTipoDeOcorrencias: Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pOnStateChange; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, Graphics, Forms, untFuncoesSimples, untConsultas, untTypesSistema,
  untCadGrupoOcorrenciasDireitoAcesso;

{$R *.dfm}

procedure TfrmCadGrupoOcorrencias.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesGoc, False);
end;

procedure TfrmCadGrupoOcorrencias.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaImagem;
end;

procedure TfrmCadGrupoOcorrencias.btnDirAceClick(Sender: TObject);
begin
  inherited;
  TfrmCadGrupoOcorrenciasDireitoAcesso.fDirAcesso(qryTabela.FieldByName('GOC_CODGOC').AsString);
end;

procedure TfrmCadGrupoOcorrencias.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadGrupoOcorrencias.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  btnImportar.Enabled := False;
  pOnStateChange;
end;

procedure TfrmCadGrupoOcorrencias.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
    btnImportar.Enabled := True;
    fUpdateTipoDeOcorrencias;
  Except
    On E : Exception Do
    Begin
      fRollBack;
      btnImportar.Enabled := False;
      pMensagensErro(E.Message, 'TfrmCadGrupoOcorrencias.btnGravarClick');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

function TfrmCadGrupoOcorrencias.fUpdateTipoDeOcorrencias : Boolean;
  Var
    qryUpdate : TUniQuery;
Begin
  Result := True;
  If (qryTabela.FieldByName('GOC_USACLI').AsString = 'N') Or
     (qryTabela.FieldByName('GOC_USAPRO').AsString = 'N') Or
     (qryTabela.FieldByName('GOC_USAFOR').AsString = 'N') Then
  Begin
    Try
      qryUpdate := fCriaQuery;
      With qryUpdate, SQL Do
      Begin
        Close;
        Clear;
        Add( ' UPDATE CADTOC SET TOC_USACLI = IF(:USACLI = "S", TOC_USACLI, "N"), ');
        Add( '                   TOC_USAPRO = IF(:USAPRO = "S", TOC_USAPRO, "N"), ');
        Add( '                   TOC_USAFOR = IF(:USAFOR = "S", TOC_USAFOR, "N")  ');
        Add( ' WHERE TOC_CODGOC = :CODGOC                                         ');

        ParamByName('USACLI').AsString := qryTabela.FieldByName('GOC_USACLI').AsString;
        ParamByName('USAPRO').AsString := qryTabela.FieldByName('GOC_USAPRO').AsString;
        ParamByName('USAFOR').AsString := qryTabela.FieldByName('GOC_USAFOR').AsString;
        ParamByName('CODGOC').AsString := qryTabela.FieldByName('GOC_CODGOC').AsString;

        ExecSQL;

      End;

    Finally
      FreeAndNil(qryUpdate);
    End;

  End;
End;

procedure TfrmCadGrupoOcorrencias.btnImportarClick(Sender: TObject);
begin
  inherited;
  if not qryTabela.IsEmpty then
  begin
    if fExisteDiretorio(ExtractFilePath(Application.ExeName) + 'Imagens_crm\') then
    begin
      SalvaImagem.InitialDir := ExtractFileDrive(Application.ExeName);
      if SalvaImagem.Execute then
        If (SalvaImagem.FileName <> '') And ((ExtractFilePath(SalvaImagem.Filename) <> ExtractFilePath(Application.ExeName))) Then
        begin
          CopyFile( PChar(SalvaImagem.FileName), PChar( ExtractFilePath(Application.ExeName) + 'Imagens_crm\' + 'GOC_' + qryTabela.FieldByName('GOC_CODGOC').AsString + '.jpg'), False);
          pCarregaImagem;
        end;
    end;
  end;
end;

procedure TfrmCadGrupoOcorrencias.btnIncluirClick(Sender: TObject);
begin
  try
    blnClickExit := True;

    inherited;

    If blnUsaProCodigo Then
      pHabilitaCodigo(dbeCodigo, dbeDesGoc, False)
    Else
      pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
    btnImportar.Enabled := False;

    qryTabela.FieldByName('GOC_USACLI').AsString := 'S';
    qryTabela.FieldByName('GOC_USAPRO').AsString := 'S';
    qryTabela.FieldByName('GOC_USAFOR').AsString := 'S';
    imgPro.Picture := Nil;
  Finally
    blnClickExit := False;
  End;
end;

procedure TfrmCadGrupoOcorrencias.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrGOcorr: TConsultasArray;
begin
  {***************************************}
  {* NOVA CONSULTA GRUPOS DE OCORRENCIAS *}
  {************************************AC*}
  chrKey := '/';
  If fPesqGruposOcorrencias(Self, Nil, Nil, qryTabela, chrKey, arrGOcorr) Then
  Begin
    pSetFocus(btnAlterar);
    pCarregaImagem;
    btnImportar.Enabled := True;    
  End;
  pOnStateChange;
end;

procedure TfrmCadGrupoOcorrencias.dbcUsaCliClick(Sender: TObject);
  Var
    strTipo : String;
begin
  inherited;
  If not (qryTabela.State in DsEditModes) Then
    Exit;

  if blnClickExit Then
    Exit;

  Try
    Case TDBCheckBox(Sender).Tag Of
      0: strTipo := 'Cliente';
      1: strTipo := 'Prospecto';
      2: strTipo := 'Fornecedor';
    End;

    If Not TDBCheckBox(Sender).Checked Then
    Begin
      If fMensagem('', 'A partir de agora, nenhum tipo de ocorrência deste grupo poderá ser utilizado para ' + strTipo + ' no CRM. Confirma?', ['&Sim', '&Não'],2) = 2 Then
      Begin
        blnClickExit := True;
        TDBCheckBox(Sender).Field.AsString := 'S';
      End;
    End
    Else
    Begin
      If fMensagem('', 'Com a liberação do grupo de ocorrência, o controle para utilização do tipo de ocorrência no '+
                        'CRM será feito pelo cadastro de tipos de ocorrência. Confirma?', ['&Sim', '&Não'],2) = 2 Then
      Begin
        blnClickExit := True;
        TDBCheckBox(Sender).Field.AsString := 'N';
      End;
    End;
  Finally
    blnClickExit := False;
  End;

end;

procedure TfrmCadGrupoOcorrencias.FormCreate(Sender: TObject);
begin
  inherited;
  blnClickExit := False;
  strNomeTabela     := 'CADGOC';
  strNomeCampo      := 'GOC_CODGOC';
  qryTabela         := fCriarQuery('SELECT * FROM CADGOC', Self);
  dtsCadGoc.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadGrupoOcorrencias.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
  btnImportar.Enabled := False;  
end;

function TfrmCadGrupoOcorrencias.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Grupo de Ocorrência deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else
    If (Sender = dbeDesGoc) Then
    Begin
      If fEmptyStr(dbeDesGoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Grupo de Ocorrência deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadGrupoOcorrencias.pCarregaImagem;
begin
  if not qryTabela.IsEmpty And FileExists(ExtractFilePath(Application.ExeName) + 'Imagens_crm\' + 'GOC_' + qryTabela.FieldByName('GOC_CODGOC').AsString + '.jpg') then
    imgPro.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Imagens_crm\' + 'GOC_' + qryTabela.FieldByName('GOC_CODGOC').AsString + '.jpg')
  else
    imgPro.Picture := Nil;
end;

procedure TfrmCadGrupoOcorrencias.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('GOC_CODGOC');
  stlCampos.Add('GOC_DESGOC');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('GOC_DESGOC');
  stlCamInd.Add('GOC_CODGOC');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Grupo Ocorrência');
end;

procedure TfrmCadGrupoOcorrencias.pOnStateChange;
begin
  inherited;
  btnDirAce.Enabled := (not (qryTabela.State in dsEditModes)) And
                       (qryTabela.Active) And
                       (qryTabela.RecordCount > 0) And
                       (not fEmptyStr(qryTabela.FieldByName('GOC_CODGOC').AsString));
end;

function TfrmCadGrupoOcorrencias.fExisteDiretorio(strCaminho: String): Boolean;
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


end.

