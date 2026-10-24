unit untCadLocalizacaoSeparacao;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, Menus, AppEvnts, Uni, DB, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, DBComboBoxFocus, ComboBoxFocus, SysUtils;

type
  TfrmCadLocalizacaoSeparacao = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    pnlFundo: TPanel;
    dtsTabela: TDataSource;
    lbl25: TLabel;
    cbbFormat: TComboBoxFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    Function fIndexToStr(intIndex: Integer): String;
    Function fStrToIndex(strFormat: String): Integer;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadMarcas }

function TfrmCadLocalizacaoSeparacao.fStrToIndex(strFormat: String): Integer;
begin
  Result := -1;

  If fEmptyStr(strFormat) Then
    Exit;

  If (strFormat = 'P') Then
    Result := 0

  Else If (strFormat = 'C') Then
    Result := 1;
end;

function TfrmCadLocalizacaoSeparacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA CODIGO DA LOCALIZAÇÃO          *}
    {**************************************MM*}
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código da Localização deve ser preenchido!', ['&Ok']);
      End
      {*****************************************}
      {* VERIFICA SE EXISTE O CODIGO INFORMADO *}
      {* CASO EXISTA TRAZ PARA EDICAO          *}
      {**************************************MM*}
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    {*****************************************}
    {* VALIDA DESCRICAO DA LOCALIZAÇÃO       *}
    {**************************************MM*}
    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A Descrição da Localização deve ser preenchida!', ['&Ok']);
      End;
    End

    {*****************************************}
    {* VALIDA DESCRICAO DA LOCALIZAÇÃO       *}
    {**************************************MM*}
    Else If (Sender = cbbFormat) Then
    Begin
      If (cbbFormat.Enabled) And
         ((fEmptyStr(cbbFormat.Text)) Or (cbbFormat.ItemIndex = -1)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Selecione o formato da Separação!', ['&Ok']);
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadLocalizacaoSeparacao.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('LSE_CODIGO');
  stlCampos.Add('LSE_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('LSE_DESCRI');
  stlCamInd.Add('LSE_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

procedure TfrmCadLocalizacaoSeparacao.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadLocalizacaoSeparacao.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADLSE';
  strNomeCampo      := 'LSE_CODIGO';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodigo;

  cbbFormat.Enabled := False;
end;

procedure TfrmCadLocalizacaoSeparacao.btnCancelaClick(Sender: TObject);
begin
  inherited;
  cbbFormat.Enabled := False;
end;

procedure TfrmCadLocalizacaoSeparacao.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadLocalizacaoSeparacao.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    cbbFormat.ItemIndex := -1;
    fCommit
  End
  Else
    fRollBack;

end;

procedure TfrmCadLocalizacaoSeparacao.btnGravarClick(Sender: TObject);
begin
  qryTabela.FieldByName('LSE_FORMAT').AsString := fIndexToStr(cbbFormat.ItemIndex);

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadLocalizacaoSeparacao.btnGravarClick]');
    End;
  End;

  if blnGravou Then
  begin
    cbbFormat.Enabled := False;
    fCommit
  end
  else
    fRollBack;
end;

procedure TfrmCadLocalizacaoSeparacao.btnIncluirClick(Sender: TObject);
begin
  inherited;

  cbbFormat.Enabled := True;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeDescri, True);
end;

procedure TfrmCadLocalizacaoSeparacao.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If blnAlterou Then
    cbbFormat.Enabled := True;

  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmCadLocalizacaoSeparacao.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadLocalizacaoSeparacao.btnPesquisaClick(Sender: TObject);
  Var
    arrLocSep : TConsultasArray;
    chrKey   : Char;
begin
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  chrKey := '/';
  If fPesqLocSep(Self, Nil, Nil, qryTabela, chrKey, arrLocSep) Then
  Begin
    cbbFormat.ItemIndex := fStrToIndex(qryTabela.FieldByName('LSE_FORMAT').AsString);
  End;
end;

function TfrmCadLocalizacaoSeparacao.fIndexToStr(intIndex: Integer): String;
begin
  Result := '';

  Case intIndex Of
   0: Result := 'P'; // Agrupando por Produtos
   1: Result := 'C'; // Agrupando por Cliente + Produtos
  End;
end;

end.

