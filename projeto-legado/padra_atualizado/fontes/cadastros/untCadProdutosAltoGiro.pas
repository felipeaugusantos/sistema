unit untCadProdutosAltoGiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Uni, Data.DB, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, EditFocus, untTypesSistema;

type
  TfrmCadProdutosAltoGiro = class(TfrmPaiCad)
    dtsProEsp: TDataSource;
    pnlCentral: TPanel;
    lblUniCom: TLabel;
    edtCodIte: TDBEditFocus;
    edtDesIte: TEditFocus;
    Label1: TLabel;
    edtCodEmp: TDBEditFocus;
    edtNomEmp: TEditFocus;
    lbl5: TLabel;
    dbeOpeAlt: TDBEditFocus;
    edtNomOpe: TEditFocus;
    Label43: TLabel;
    dbeDtCadastro: TDBEditFocus;
    dbeHrCadastro: TDBEditFocus;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    qryProEsp: TUniQuery;
    qryCadPro: TUniQuery;
    procedure pCarregarCampos;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;

  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas;

{$R *.dfm}

function TfrmCadProdutosAltoGiro.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodIte) Then
    Begin
      edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

      If fEmptyStr(edtDesIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Produto não encontrado!', ['&Ok']);
        Result := False;
      End;
    End;

    If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa não informada!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtNomEmp.Text := fRetFantasiaEmpresa(edtCodEmp.Text);

        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
          Result := False;
        End
      End;
    End;

  End;

  If not Result Then
    pSetFocus(Sender);

End;

procedure TfrmCadProdutosAltoGiro.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryCadPro, Key, arrSel, True, nil, 'Consulta de Produtos', '1') then
    Begin
      If (fValidaCampos(edtCodIte, True)) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadProdutosAltoGiro.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregarCampos;
end;

procedure TfrmCadProdutosAltoGiro.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadProdutosAltoGiro.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregarCampos;
end;

procedure TfrmCadProdutosAltoGiro.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadProdutosAltoGiro.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadProdutosAltoGiro.btnIncluirClick(Sender: TObject);
begin
  inherited;
  edtDesIte.Clear;
  edtNomEmp.Clear;
  qryTabela.FieldByName('ESP_DTACAD').AsDateTime := VS_Date;
  qryTabela.FieldByName('ESP_HORCAD').AsDateTime := fTime();
  qryTabela.FieldByName('ESP_CODOPE').AsString   := strLoginUsuarioLogado;
  edtNomOpe.Text := fRetNomeOperador(strLoginUsuarioLogado);
  pSetFocus(edtCodIte);
end;

procedure TfrmCadProdutosAltoGiro.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
  arrProEsp : TConsultasArray;
begin
  chrKey := '/';
  If fPesqProdutosAltoGiro(Self, Nil, Nil, qryTabela, chrKey, arrProEsp) Then
  Begin
    edtDesIte.Text := fRetNomProduto(qryTabela.FieldByName('ESP_CODITE').AsString);
    edtNomEmp.Text := fRetFantasiaEmpresa(qryTabela.FieldByName('ESP_CODEMP').AsString);
    edtNomOpe.Text := fRetNomeOperador(qryTabela.FieldByName('ESP_CODOPE').AsString);
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadProdutosAltoGiro.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtCodEmp);
end;

procedure TfrmCadProdutosAltoGiro.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;

  If (Not edtCodEmp.ReadOnly) And
     fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProdutosAltoGiro.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;

  pSetaCodIte(edtCodIte);

  strNomeTabela     := 'PROESP';
  strNomeCampo      := 'ESP_CODITE';
  strSQL            := 'SELECT * FROM PROESP';
  qryProEsp         := fCriarQuery(strSQL, Self);
  qryTabela         := qryProEsp;
  dtsProEsp.DataSet := qryTabela;

  qryCadPro := fCriaQuery(Self);

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := edtCodIte;
  arrCamposChave[1] := edtCodEmp;
end;

procedure TfrmCadProdutosAltoGiro.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('ESP_CODITE');
  stlCampos.Add('ESP_CODEMP');
  stlCampos.Add('ESP_CODOPE');
  stlCampos.Add('ESP_DTACAD');
  stlCampos.Add('ESP_HORCAD');

  stlDesInd.Add('Produto');
  stlDesInd.Add('Empresa');
  stlDesInd.Add('Operador');
  stlDesInd.Add('Dt.Cadastro');
  stlDesInd.Add('Hr.Cadastro');
end;

procedure TfrmCadProdutosAltoGiro.pCarregarCampos;
begin
  if qrytabela.IsEmpty then
  begin
    edtDesIte.Clear;
    edtNomEmp.Clear;
    edtNomOpe.Clear;
  end
  else
  begin
    edtDesIte.Text := fRetNomProduto(qryTabela.FieldByName('ESP_CODITE').AsString);
    edtNomEmp.Text := fRetFantasiaEmpresa(qryTabela.FieldByName('ESP_CODEMP').AsString);
    edtNomOpe.Text := fRetNomeOperador(qryTabela.FieldByName('ESP_CODOPE').AsString);
  End;
end;

end.
