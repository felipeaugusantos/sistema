unit untCadPortos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, Uni;

type
  TfrmCadPortos = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    Label1: TLabel;
    dbeCodPorto: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    Label3: TLabel;
    dbeCodCid: TDBEditFocus;
    edtNomCid: TEditFocus;
    Label4: TLabel;
    edtEstado: TEditFocus;
    edtNomPais: TEditFocus;
    dbeCodPais: TDBEditFocus;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure dbeCodPaisKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
  private
    qryCadPorto: TUniQuery;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pRefresh;
    { Private declarations }
  Protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; Override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadPortos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodPorto, dbeDescri, False);
end;

procedure TfrmCadPortos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pRefresh;
end;

procedure TfrmCadPortos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  inherited;
  edtNomCid.Clear;
  edtEstado.Clear;
  dbeCodPais.Clear;
  edtNomPais.Clear;
end;

procedure TfrmCadPortos.btnGravarClick(Sender: TObject);
begin
  if not fVerificaCampos then
  begin
    Exit;
  end;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadPortos.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadPortos.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodPorto, dbeDescri, False);
  edtNomCid.Clear;
  edtEstado.Clear;
  dbeCodPais.Clear;
  edtNomPais.Clear;

end;

procedure TfrmCadPortos.btnPesquisaClick(Sender: TObject);
Var
  arrSel: TConsultasArray;
  Key   : Char;
begin
  Key := '/';
  If fPesqPortos(Self, dbeCodPorto, nil, qryTabela, Key, arrSel) then
  Begin
    fValidaCampos(dbeCodCid,  False);
    fValidaCampos(dbeCodPais, False);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadPortos.dbeCodCidKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqCidade(Self, dbeCodCid, edtNomCid, edtEstado, Nil, Key, arrSel) Then
    fValidaCampos(dbeCodCid, False);
end;

procedure TfrmCadPortos.dbeCodPaisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqPaises(Self, dbeCodPais, nil, Key, arrSel) Then
    fValidaCampos(dbeCodPais, False);
end;

procedure TfrmCadPortos.FormCreate(Sender: TObject);
var
  intIndex: Integer;
begin
  inherited;
  strNomeTabela     := 'CADPRT';
  strNomeCampo      := 'PRT_CODPRT';

  qryCadPorto       := fCriaQuery(Self);
  qryTabela         := qryCadPorto;
  dtsTabela.DataSet := qryTabela;

  qryTabela.AfterOpen := pAfterOpen;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodPorto;

  For intIndex := 0 To Self.ControlCount -1 Do
  Begin
    if (Self.Controls[intIndex] is TDBEditFocus) Then
      TDBEditFocus(Self.Controls[intIndex]).DataSource := dtsTabela;
  End;
end;

procedure TfrmCadPortos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);

  FreeAndNil(dtsTabela);
  FreeAndNil(qryTabela);

  inherited;
end;

procedure TfrmCadPortos.pAfterOpen(DataSet: TDataSet);
begin
  pRefresh;
end;

procedure TfrmCadPortos.pRefresh;
begin
  edtNomCid.Clear;
  edtEstado.Clear;
  edtNomPais.Clear;

  if not fEmptyStr(dbeCodCid.Text) Then
  Begin
    edtNomCid.Text := fRetNomCidade(dbeCodCid.Text, 0);
    edtEstado.Text := fRetNomCidade(dbeCodCid.Text, 1);
  End;

  if not fEmptyStr(dbeCodPais.Text) Then
  Begin
    edtNomPais.Text := fRetNomePais(dbeCodPais.Text);
  End;
end;

procedure TfrmCadPortos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('PRT_CODPRT');
  stlCampos.Add('PRT_DESCRI');
  stlCampos.Add('PRT_CODCID');
  stlCampos.Add('PRT_CODPAI');

  stlCamInd.Add('PRT_CODPRT');
  stlCamInd.Add('PRT_DESCRI');
  stlCamInd.Add('PRT_CODCID');
  stlCamInd.Add('PRT_CODPAI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Cód.Cidade');
  stlDesInd.Add('Cód.País');
end;

function TfrmCadPortos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    If (Sender = dbeDescri) Then
    Begin
      if fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('', 'O campo "Nome" deve ser preenchido!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodCid) Then
    Begin
      if fEmptyStr(dbeCodCid.Text) Then
      Begin
        fMensagem('', 'O campo "Cidade" deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        edtNomCid.Text := fRetNomCidade(dbeCodCid.Text, 0);
        edtEstado.Text := fRetNomCidade(dbeCodCid.Text, 1);

        if fEmptyStr(edtNomCid.Text) Then
        Begin
          fMensagem('', 'Cidade não cadastrada!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeCodPais) Then
    Begin
      if fEmptyStr(dbeCodPais.Text) Then
      Begin
        fMensagem('', 'O campo "País" deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        edtNomPais.Text := fRetNomePais(dbeCodPais.Text);

        if fEmptyStr(edtNomPais.Text) Then
        Begin
          fMensagem('', 'País não cadastrado!', ['&OK']);
          Result := False;
        End;
      End;
    End;

  End;

  If not Result Then
    pSetFocus(Sender);

end;

end.
