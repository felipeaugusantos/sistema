unit untCadNCMOutrosPaises;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, MemDS, DBAccess, Uni, EditFocus;

type
  TfrmCadNCMOutrosPaises = class(TfrmPaiCad)
    btnImportar: TBitBtnLocked;
    dtsCadNCMPais: TDataSource;
    lblCodIte: TLabel;
    dbeCodIte: TDBEditFocus;
    edtDesIte: TEditFocus;
    lblCodPais: TLabel;
    dbeCodPai: TDBEditFocus;
    edtNomPai: TEditFocus;
    lblCodNCM: TLabel;
    dbeCodNCM: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodPaiKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
  private
    { Private declarations }
    qryCadNCMPais: TUniQuery;
    procedure pCarregarCampos;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples,
  untConsultas,
  untTypesSistema,
  untDllOpeProd,
  untDllOpeProdFuncoes;

{$R *.dfm}

procedure TfrmCadNCMOutrosPaises.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCodIte)
end;

procedure TfrmCadNCMOutrosPaises.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregarCampos;
end;

procedure TfrmCadNCMOutrosPaises.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadOcorrencias.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadNCMOutrosPaises.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  inherited;
end;

procedure TfrmCadNCMOutrosPaises.btnImportarClick(Sender: TObject);
begin
  inherited;
  pOpeProd(ImportCadNOP);
end;

procedure TfrmCadNCMOutrosPaises.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pCarregarCampos;
  pSetFocus(dbeCodIte);
end;

procedure TfrmCadNCMOutrosPaises.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCodigos: TConsultasArray;
begin
  chrKey := '/';
  If fPesqNCMOutrosPaises(Self, qryTabela, chrKey, arrCodigos) Then
  begin
    pCarregarCampos;
    pSetFocus(btnAlterar);
  end;
end;

procedure TfrmCadNCMOutrosPaises.dbeCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGen: TUniQuery;
    arrSel: TConsultasArray;
begin
  inherited;
  qryGen := fCriaQuery(Self);
  Try
    if fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, qryGen, Key, arrSel) then
    Begin
      If fValidaCampos(dbeCodIte, True) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
    End;
  Finally
    pFreeAndNil(qryGen);
  End;
end;

procedure TfrmCadNCMOutrosPaises.dbeCodPaiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGen: TUniQuery;
    arrSel: TConsultasArray;
begin
  inherited;
  qryGen := fCriaQuery(Self);
  Try
    If fPesqPaises(Self, dbeCodPai, qryGen, Key, arrSel) Then
    Begin
      If fValidaCampos(dbeCodPai, True) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
    End;
  Finally
    pFreeAndNil(qryGen);
  End;
end;

procedure TfrmCadNCMOutrosPaises.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  inherited;
  btnImportar.Visible := fVerificaAcessoSistema('frmImportCadNOP');
end;

procedure TfrmCadNCMOutrosPaises.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strNomeTabela := 'CADNOP';
  strNomeCampo  := 'AUTOINCREM';

  strSQL        := 'SELECT * FROM CADNOP WHERE FALSE';
  qryCadNCMPais := fCriarQuery(strSQL, Self);
  qryTabela     := qryCadNCMPais;
  dtsCadNCMPais.DataSet := qryTabela;
end;

function TfrmCadNCMOutrosPaises.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodPai) Then
    Begin
      If (fEmptyStr(dbeCodPai.Text)) Then
      Begin
        pMensagemOk('O código do país deve ser preenchido!');
        Result := False;
      End
      Else If Length(dbeCodPai.Text) <> 4 Then
      Begin
        pMensagemOk('O código do país deve ter 4 digitos!');
        Result := False;
      End
      Else
      Begin
        edtNomPai.Text := fRetNomePais(dbeCodPai.Text);
        If fEmptyStr(edtNomPai.Text) Then
        Begin
          pMensagemOk('O código do país informado não é válido!');
          Result := False;
        End;
      End;
    End
    Else If (Sender = dbeCodIte) Then
    Begin
      If (fEmptyStr(dbeCodIte.Text)) Then
      Begin
        pMensagemOk('O código do produto deve ser preenchido!');
        Result := False;
      End
      Else
      Begin
        edtDesIte.Text := fRetNomProduto(dbeCodIte.Text);
        If fEmptyStr(edtDesIte.Text) Then
        Begin
          pMensagemOk('O código do produto informado não é válido!');
          Result := False;
        End;
      End;
    End
    Else If (Sender = dbeCodNCM) Then
    Begin
      If (fEmptyStr(dbeCodNCM.Text)) Then
      Begin
        pMensagemOk('O NCM deve ser preenchido!');
        Result := False;
      End
      Else If Not (Length(Trim(dbeCodNCM.Text)) in [2, 8]) Then
      Begin
        pMensagemOk('O NCM deve ter 2 ou 8 caracteres!');
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadNCMOutrosPaises.pInicializaIndices;
begin
  inherited;

end;

procedure TfrmCadNCMOutrosPaises.pCarregarCampos;
begin
  If (fEmptyStr(dbeCodPai.Text)) Then
    edtDesIte.Text := ''
  Else
    edtDesIte.Text := fRetNomProduto(dbeCodIte.Text);

  If (fEmptyStr(dbeCodPai.Text)) Then
    edtNomPai.Text := ''
  Else
    edtNomPai.Text := fRetNomePais(dbeCodPai.Text);
end;

end.
