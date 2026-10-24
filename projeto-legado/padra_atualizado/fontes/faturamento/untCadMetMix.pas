unit untCadMetMix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, untCadMix, untCadMixController;

type
  TfrmCadMetMix = class(TfrmPaiCad)
    pnlFundo: TPanel;
    lblEmp: TLabel;
    Label1: TLabel;
    lblPorcentagem: TLabel;
    edtPerMet: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    objModel: TCadMix;
    objController: TCadMixController;
    procedure pPesquisaMetaMix;
    procedure pPreencheCampos;
    function fEscolheuRegistro: Boolean;
    procedure pLimpaCampos;
    procedure pPreencheObjModel;
    function fMetaAtualJaExistente: Boolean;
    function fConfirmaExclusao: Boolean;
    function fMetaJaCadastrada: Boolean;
    function fValidaDados: Boolean;
    function fValidaInclusao: Boolean;
    procedure pExcluiRegistro;
    procedure pGravar;
    { Private declarations }
  public
    { Public declarations }
  protected
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

var
  frmCadMetMix: TfrmCadMetMix;

implementation

uses
  untConsultas, untTypesSistema, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadMetMix.pGravar;
  Var
    blnGravou: Boolean;
begin
  Try
    blnGravou := objController.fGravar(objModel);

    If (blnGravou) Then
      fMensagem('ATENÇÃO!', 'Dados gravados com sucesso', ['&Ok']);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'TfrmCadMetMix.pGravar');
    End;
  End;
end;

procedure TfrmCadMetMix.pExcluiRegistro;
  Var
    blnExcluiu: Boolean;
begin
  Try
    blnExcluiu := objController.fDeletar(objModel.getAutInc);

    If (blnExcluiu) Then
      fMensagem('ATENÇÃO!', 'Dados deletados com sucesso', ['&Ok']);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'TfrmCadMetMix.pExcluiRegistro');
    End;
  End;
end;

procedure TfrmCadMetMix.pPreencheObjModel;
begin
  objModel := objModel.getInstance('', edtCodEmp.Text, fStrToFloat(edtPerMet.Text));
end;

function TfrmCadMetMix.fEscolheuRegistro: Boolean;
begin
  Result := False;

  If (Not fMetaAtualJaExistente) Then
  Begin
    fMensagem('ATENÇÃO!', 'Favor escolher um registro para essa operação', ['&Ok']);
    Exit;
  End;

  Result := True;
end;

function TfrmCadMetMix.fMetaAtualJaExistente: Boolean;
begin
  Result := (objModel <> Nil) And (Not fEmptyStr(objModel.getAutInc));
end;

procedure TfrmCadMetMix.pPreencheCampos;
begin
  edtCodEmp.Text := objModel.getCodEmp;
  edtDesEmp.Text := fRetNomeEmpresaSelec(objModel.getCodEmp);
  edtPerMet.Text := FormatFloat('#,##0.00', objModel.getPerMet);
end;

procedure TfrmCadMetMix.pLimpaCampos;
begin
  edtCodEmp.Text := '';
  edtDesEmp.Text := '';
  edtPerMet.Text := '0,00';
  objModel := Nil;
end;

procedure TfrmCadMetMix.btnAlterarClick(Sender: TObject);
begin
  If (Not fEscolheuRegistro) Then
    Exit;

  qryTabela.Edit;

  If blnChangeEnabledButton Then
    pOnStateChange;

  pEnabled(Self, True);
end;

procedure TfrmCadMetMix.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
end;

procedure TfrmCadMetMix.btnExcluirClick(Sender: TObject);
begin
  If (Not fEscolheuRegistro) Then
    Exit;

  If (fConfirmaExclusao) Then
  Begin
    pExcluiRegistro;
    btnCancela.Click;
  End;
end;

function TfrmCadMetMix.fConfirmaExclusao: Boolean;
begin
  Result := fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1;
end;

procedure TfrmCadMetMix.btnGravarClick(Sender: TObject);
begin
  If (fValidaDados) Then
  Begin
    pPreencheObjModel;
    pGravar;
    btnCancela.Click;
  End;
end;

function TfrmCadMetMix.fValidaDados: Boolean;
begin
  Result := False;

  If (Not fVerificaCampos) Then
    Exit;

  If (Not fValidaInclusao) Then
    Exit;

  Result := True;
end;

function TfrmCadMetMix.fValidaInclusao: Boolean;
begin
  Result := False;

  If (fMetaAtualJaExistente) Then
    Exit(True);

  If (fMetaJaCadastrada) Then
    Exit;

  Result := True;
end;

function TfrmCadMetMix.fMetaJaCadastrada: Boolean;
begin
  Result := True;

  Try
    If (objController.fExisteMeta(edtCodEmp.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Já existe uma Meta Mix cadastrada para esta empresa', ['&Ok']);
      pSetFocus(edtCodEmp);
      Exit;
    End;

    Result := False;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadMetMix.fMetaJaCadastrada]');
    End;
  End;
end;

procedure TfrmCadMetMix.btnIncluirClick(Sender: TObject);
begin
  btnCancela.Click;
  inherited;
end;

procedure TfrmCadMetMix.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  pPesquisaMetaMix;
end;

procedure TfrmCadMetMix.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMetMix.pInicializaIndices;
Begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
End;

procedure TfrmCadMetMix.FormCreate(Sender: TObject);
begin
  inherited;
  objController := TCadMixController.Create;
  objModel := Nil;
end;

procedure TfrmCadMetMix.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objController);
  FreeAndNil(objModel);
end;

procedure TfrmCadMetMix.FormShow(Sender: TObject);
begin
  strNomeTabela := 'CADMIX';
  strNomeCampo  := 'MIX_CODEMP';
  qryTabela     := fCriaQuery(Self);
  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := edtCodEmp;
  inherited;
end;

procedure TfrmCadMetMix.pPesquisaMetaMix;
  Var
    arrMeta: TConsultasArray;
    strAutInc: String;
begin
  Try
    If fPesqMetaMix(Self, strAutInc, Nil, arrMeta, True) Then
    Begin
      objModel := objController.fBuscarPorAutoIncremento(strAutInc);
      pPreencheCampos;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadMetMix.pPesquisaMetaMix]');
    End;
  End;
end;

function TfrmCadMetMix.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodEmp) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtDesEmp.Text := '';
        fMensagem('ATENÇÃO!','O Código da Empresa deve ser preenchido',['&OK']);
        Result := False;
      End
      Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Essa Empresa não está cadastrada',['&OK']);
          Result := False;
        End
      End;
    End
    Else If (Sender = edtPerMet) Then
    Begin
      If (fStrToFloat(edtPerMet.Text) > 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O % de Meta Mix não pode ser maior que 100', ['&Ok']);
        Result := False;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
