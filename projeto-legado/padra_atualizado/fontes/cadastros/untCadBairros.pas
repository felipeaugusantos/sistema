unit untCadBairros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, DB, Vcl.Mask,
  Vcl.DBCtrls, EditFocus, DBEditFocus;

type
  TfrmCadBairros = class(TfrmPaiCad)
    dbeCodBai: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dbeCodCid: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtNomCid: TEditFocus;
    edtEstado: TEditFocus;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    dtsTabela : TDataSource;
  public
    strCodCid : String;
  Protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; Override;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema;

procedure TfrmCadBairros.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodBai, dbeDescri, False);
end;

procedure TfrmCadBairros.btnCancelaClick(Sender: TObject);
begin
  inherited;
  fValidaCampos(dbeCodCid, False);
end;

procedure TfrmCadBairros.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadBairros.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  qryTabela.Close;
  edtNomCid.Clear;
  edtEstado.Clear;
end;

procedure TfrmCadBairros.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadBairros.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadBairros.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodBai, dbeDescri, False);
  edtNomCid.Clear;
  edtEstado.Clear;

  if not fEmptyStr(strCodCid) Then
  Begin
    dbeCodCid.Field.AsString := strCodCid;
    fValidaCampos(dbeCodCid, True);
  End;

end;

procedure TfrmCadBairros.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key   : Char;
begin
//  inherited;
  Key := '/';
  If fPesqBairro(Self, dbeCodBai, nil, qryTabela, Key, arrSel) then
  Begin
    fValidaCampos(dbeCodCid, False); // Carrega dados da Cidade.
    pSetFocus(btnAlterar);
  End;


end;

procedure TfrmCadBairros.dbeCodCidKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqCidade(Self, dbeCodCid, edtNomCid, edtEstado, Nil, Key, arrSel) Then
    fValidaCampos(dbeCodCid, False);
end;

procedure TfrmCadBairros.FormCreate(Sender: TObject);
  Var
    intIndex : Integer;
begin
  strCodCid := '';
  qryTabela := fCriaQuery(Self);
  dtsTabela := fCriaDataSource(qryTabela);

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  inherited;

  strNomeTabela := 'CADBAI';
  strNomeCampo  := 'BAI_CODBAI';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodBai;

  For intIndex := 0 To Self.ControlCount -1 Do
  Begin
    if (Self.Controls[intIndex] is TDBEditFocus) Then
      TDBEditFocus(Self.Controls[intIndex]).DataSource := dtsTabela;
  End;

end;

procedure TfrmCadBairros.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);

  FreeAndNil(dtsTabela);
  FreeAndNil(qryTabela);
  inherited;
end;

function TfrmCadBairros.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    If (Sender = dbeCodCid) Then
    Begin
      edtNomCid.Text := fRetNomCidade(dbeCodCid.Text, 0);
      edtEstado.Text := fRetNomCidade(dbeCodCid.Text, 1);

      if fEmptyStr(edtNomCid.Text) Then
      Begin
        fMensagem('', 'Cidade não cadastrada!', ['&OK']);
        Result := False;

      End;

    End
    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('', 'É necessário preencher a descrição!', ['&OK']);
        Result := False;
      End;
    End;

  End;

  If not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadBairros.pInicializaIndices;
begin
  inherited;
  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('BAI_CODBAI');
  stlCampos.Add('BAI_DESCRI');
  stlCampos.Add('BAI_CODCID');

  stlCamInd.Add('BAI_CODBAI');
  stlCamInd.Add('BAI_DESCRI');
  stlCamInd.Add('BAI_CODCID');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Cód.Cidade');
end;

end.
