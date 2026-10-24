unit untCadNCMEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, MemDS, DBAccess, Uni, EditFocus;

type
  TfrmCadNCMEmpresa = class(TfrmPaiCad)
    btnImportar: TBitBtnLocked;
    dtsCadNCMEmpresa: TDataSource;
    lblCodIte: TLabel;
    dbeCodIte: TDBEditFocus;
    edtDesIte: TEditFocus;
    lblCodPais: TLabel;
    dbeCodEmp: TDBEditFocus;
    edtNomEmp: TEditFocus;
    lblCodNCM: TLabel;
    dbeCodNCM: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
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
    qryCadNCMEmpresa: TUniQuery;
    procedure pCarregarCampos;
    function fValidaGravacao: Boolean;
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

procedure TfrmCadNCMEmpresa.btnAlterarClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  inherited;
  pSetFocus(dbeCodIte)
end;

procedure TfrmCadNCMEmpresa.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregarCampos;
end;

procedure TfrmCadNCMEmpresa.btnExcluirClick(Sender: TObject);
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

  pCarregarCampos;
end;

function TfrmCadNCMEmpresa.fValidaGravacao: Boolean;
var
  strAutInc: String;
begin
  Result := True;

  If not (qryCadNCMEmpresa.state = dsInsert) Then
    Exit;

  strAutInc := fCampoTabela('AUTOINCREM', 'CADNCE', ['NCE_CODITE', 'NCE_CODEMP'],
                                                    [qryCadNCMEmpresa.FieldByName('NCE_CODITE').AsString,
                                                     qryCadNCMEmpresa.FieldByName('NCE_CODEMP').AsString]);
  If not fEmptyStr(strAutInc) Then
  Begin
    fMensagem('ATENÇÃO', 'Já existe cadastro de NCM do item '+qryCadNCMEmpresa.FieldByName('NCE_CODITE').AsString+' para a empresa '+qryCadNCMEmpresa.FieldByName('NCE_CODEMP').AsString+'.', ['&Ok']);
    Result := False ;
  End;
end;

procedure TfrmCadNCMEmpresa.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If not fValidaGravacao Then
    Exit;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadOcorrencias.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadNCMEmpresa.btnImportarClick(Sender: TObject);
begin
  inherited;
  pOpeProd(ImportCadNCE);
end;

procedure TfrmCadNCMEmpresa.btnIncluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  inherited;
  pCarregarCampos;
  pSetFocus(dbeCodIte);
end;

procedure TfrmCadNCMEmpresa.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCodigos: TConsultasArray;
begin
  chrKey := '/';
  If fPesqNCMEmpresa(Self, qryTabela, chrKey, arrCodigos) Then
  begin
    pCarregarCampos;
    pSetFocus(btnAlterar);
  end;
end;

procedure TfrmCadNCMEmpresa.dbeCodIteKeyPress(Sender: TObject;
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

procedure TfrmCadNCMEmpresa.dbeCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGen: TUniQuery;
    arrSel: TConsultasArray;
begin
  inherited;
  qryGen := fCriaQuery(Self);
  Try
    If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrSel, True) Then
    Begin
      If fValidaCampos(dbeCodEmp, True) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
    End;
  Finally
    pFreeAndNil(qryGen);
  End;
end;

procedure TfrmCadNCMEmpresa.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  inherited;
  btnImportar.Visible := fVerificaAcessoSistema('frmImportCadNOP');
end;

procedure TfrmCadNCMEmpresa.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strNomeTabela := 'CADNCE';
  strNomeCampo  := 'AUTOINCREM';

  strSQL                   := 'SELECT * FROM CADNCE WHERE FALSE';
  qryCadNCMEmpresa         := fCriarQuery(strSQL, Self);
  qryTabela                := qryCadNCMEmpresa;
  dtsCadNCMEmpresa.DataSet := qryTabela;
end;

function TfrmCadNCMEmpresa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodEmp) Then
    Begin
      If (fEmptyStr(dbeCodEmp.Text)) Then
      Begin
        pMensagemOk('O código da empresa deve ser preenchido!');
        Result := False;
      End
      Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          pMensagemOk('O código da empresa informada não é válido!');
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

procedure TfrmCadNCMEmpresa.pInicializaIndices;
begin
  inherited;

end;

procedure TfrmCadNCMEmpresa.pCarregarCampos;
begin
  If (fEmptyStr(dbeCodEmp.Text)) Then
    edtDesIte.Text := ''
  Else
    edtDesIte.Text := fRetNomProduto(dbeCodIte.Text);

  If (fEmptyStr(dbeCodEmp.Text)) Then
    edtNomEmp.Text := ''
  Else
    edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
end;

end.
