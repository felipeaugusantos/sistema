unit untFornecedoresTagsTigre;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  untConsultas, untForTagController, untPaiSimples, untTypesSistema,
  UniClientDataSet, DBAccess, Uni, DBGridCitel, Datasnap.DBClient;

type
  TfrmFornecedoresTagsTigre = class(TfrmPaiSimples)
    pnlTopo: TPanel;
    edtCodFornecedor: TEditFocus;
    edtNomFornecedor: TEditFocus;
    btnIncluir: TBitBtnLocked;
    lblFornecedor: TLabel;
    pnlCentro: TPanel;
    pnlRodape: TPanel;
    btnConfirmar: TBitBtnLocked;
    btnExit: TBitBtnLocked;
    Label1: TLabel;
    dtsFornecedores: TUniDataSource;
    cdsFornecedores: TUniClientDataSet;
    cdsFornecedoresCODEMP: TStringField;
    cdsFornecedoresCODFOR: TStringField;
    cdsFornecedoresNOMFOR: TStringField;
    dbgFornecedores: TDBGridCitel;
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgFornecedoresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure pIncluirFornecedor;
    procedure pCarregarFornecedoresTigre;
    procedure pGravarFornecedoresTigre;
    function fValidaDadosParaGravacao: Boolean;
    function fValidaInclusao: Boolean;
    procedure pLimpaCampos;
    function fPreencheNomFornecedor: Boolean;

  protected
    { Protected declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;

  public
    { Public declarations }
  end;

implementation

uses untPai, untFuncoesSimples;

{$R *.dfm}

procedure TfrmFornecedoresTagsTigre.btnConfirmarClick(Sender: TObject);
begin
  pGravarFornecedoresTigre;
end;

procedure TfrmFornecedoresTagsTigre.btnIncluirClick(Sender: TObject);
begin
  pIncluirFornecedor;
end;

procedure TfrmFornecedoresTagsTigre.dbgFornecedoresKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (Not cdsFornecedores.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!','Deseja realmente excluir o registro?', ['&Sim','&Não'], 2) = 1) Then
      cdsFornecedores.Delete;
  End;
end;

procedure TfrmFornecedoresTagsTigre.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFornecedoresTagsTigre.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtNomFornecedor, Nil, Key, arrFornec) Then
  Begin
    fValidaCampos(edtCodFornecedor, True);
  End;

  If (Key = #13) Then
  Begin
    edtCodFornecedor.Text := fStrZero(edtCodFornecedor.Text, 8);
    fPreencheNomFornecedor;
  End
  Else If (Key = #8) Then
    edtNomFornecedor.Text := '';
end;

procedure TfrmFornecedoresTagsTigre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If fCfgSis('TAGOXV', VarBoolean) And (Not fExisteFornecedorTigreConfigurado) Then
  Begin
    fMensagem('ATENÇÃO!','A CFG_TAGOXV está ativada, portanto é necessário informar pelo menos um fornecedor Tigre.', ['&Ok']);
    Action := caNone;
  End;
end;

procedure TfrmFornecedoresTagsTigre.FormShow(Sender: TObject);
begin
  pCarregarFornecedoresTigre;
end;

function TfrmFornecedoresTagsTigre.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = edtCodFornecedor) Then
    Begin
      If (fEmptyStr(edtCodFornecedor.Text)) Then
        pLimpaCampos
      Else If Not(fPreencheNomFornecedor) Then
        Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmFornecedoresTagsTigre.pIncluirFornecedor;
begin
  Try
    If (Not fValidaInclusao) Or (Not fValidaCampos(edtCodFornecedor, True)) Then
    Begin
      pSetFocus(edtCodFornecedor);
      Exit;
    End;

    cdsFornecedores.Append;
    cdsFornecedores.FieldByName('CODFOR').AsString := edtCodFornecedor.Text;
    cdsFornecedores.FieldByName('NOMFOR').AsString := edtNomFornecedor.Text;
    cdsFornecedores.FieldByName('CODEMP').AsString := VS_strCodEmp;
    cdsFornecedores.Post;

    pLimpaCampos;
  Except
    On E: Exception Do
      pMensagensErro('', '[frmFornecedoresTagsTigre.pIncluirFornecedor]');
  End;
end;

function TfrmFornecedoresTagsTigre.fValidaInclusao: Boolean;
begin
  Result := False;

  If (cdsFornecedores.Locate('CODFOR', edtCodFornecedor.Text, [])) Then
  Begin
    pMensagemOk('Fornecedor já inserido.');
    Exit;
  End;

  If (fEmptyStr(edtCodFornecedor.Text)) Then
  Begin
    pMensagemOk('Fornecedor não informado.');
    Exit;
  End;

  Result := True;
end;

procedure TfrmFornecedoresTagsTigre.pCarregarFornecedoresTigre;
  Var
    objForTagController: TForTagController;
begin
  objForTagController := TForTagController.Create;

  Try
    Try
      objForTagController.pCarregarCDS(cdsFornecedores, VS_strCodEmp);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFornecedoresTagsTigre.pCarregarFornecedoresTigre]');
    End;
  Finally
    FreeAndNil(objForTagController);
  End;
end;

procedure TfrmFornecedoresTagsTigre.pGravarFornecedoresTigre;
  Var
    objForTagController: TForTagController;
begin
  objForTagController := TForTagController.Create;

  Try
    Try
      If (Not fValidaDadosParaGravacao) Then
        Exit;

      If (objForTagController.fGravar(cdsFornecedores, VS_strCodEmp)) Then
      Begin
        pMensagemOk('Dados registrados com sucesso.');
        Close;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFornecedoresTagsTigre.pGravarFornecedoresTigre]');
    End;
  Finally
    FreeAndNil(objForTagController);
  End;
end;

function TfrmFornecedoresTagsTigre.fValidaDadosParaGravacao: Boolean;
begin
  Result := False;

  If ((cdsFornecedores = Nil) Or (cdsFornecedores.RecordCount = 0)) And
    (Not fExisteFornecedorTigreConfigurado) Then
  Begin
    pMensagemOk('Não há dados para gravação.');
    Exit;
  End;

  Result := True;
end;

procedure TfrmFornecedoresTagsTigre.pLimpaCampos;
begin
  edtCodFornecedor.Text := '';
  edtNomFornecedor.Text := '';
  pSetFocus(edtCodFornecedor);
end;

function TfrmFornecedoresTagsTigre.fPreencheNomFornecedor: Boolean;
begin
  Result := False;

  edtNomFornecedor.Text := fRetNomFornecedor(edtCodFornecedor.Text);

  If (fEmptyStr(edtNomFornecedor.Text)) Then
  Begin
    pMensagemOk('Fornecedor não encontrado.');
    pLimpaCampos;
    Exit;
  End;

  Result := True;
end;

end.
