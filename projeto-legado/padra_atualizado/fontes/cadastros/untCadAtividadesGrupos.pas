unit untCadAtividadesGrupos;

interface

uses
  Windows, Classes, Controls, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Grids, DBGridCitel, DBGrids, DB, Mask, MaskEditFocus, Uni, untAtiGru, AppEvnts,
  BitBtnLockedIncrem;

type
  TfrmCadAtividadesGrupos = class(TfrmPai)
    pnlAtividade: TPanel;
    edtCodAti: TEditFocus;
    dbgAtiGru: TDBGridCitel;
    pnlLinGru: TPanel;
    edtDesAti: TEditFocus;
    Label1: TLabel;
    lbl1: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgAtiGruKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    strCodAti: String;

    procedure pLimpaEdits(blnAtividade: Boolean);

  public
    { Public declarations }

    objAtiGru: TAtiGru;

  protected

    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    procedure pEscapePressed; override;

  end;

implementation

uses SysUtils, Forms, strUtils, UniClientDataSet, untFuncoesSimples, untConsultas,
  untTypesSistema;

{$R *.dfm}

{*******************************************}
{* VALIDA CAMPOS                           *}
{****************************************RL*}
function TfrmCadAtividadesGrupos.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  {***********************}
  {* VALIDA CLIENTE      *}
  {********************RL*}
  If (Sender = edtCodAti) Then
  Begin

    If fEmptyStr(edtCodAti.Text) Then
    Begin
      fMensagem('ATENÇÃO!','O código da atividade deve ser informado!',['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtDesAti.Text := fRetNomAtividade(edtCodAti.Text);

      If fEmptyStr(edtDesAti.Text) Then
      Begin
        fMensagem('', 'Atividade não encontrada!', ['&Ok']);
        Result := False;
      End

      Else If strCodAti <> edtCodAti.Text Then
        objAtiGru.fCarregaAtiGru(edtCodAti.Text);

      strCodAti := edtCodAti.Text;

    End;

  End

  Else If (Sender = mskLinGru) Then
  Begin
    If fEmptyStr(mskLinGru.Text) And (Not objAtiGru.IsEmpty) Then
    Begin
      blnMudarFoco := False;
      pSetFocus(dbgAtiGru);
    End
    Else If fEmptyStr(mskLinGru.Text) Then
    Begin
      fMensagem('', 'O código da Linha/Grupo deve ser informado!', ['&Ok']);
      Result := False;
    End
    Else If objAtiGru.fLinhaGrupoJaInformado(mskLinGru.Text) Then
    Begin
      fMensagem('', 'O código da Linha/Grupo já foi informado!', ['&Ok']);
      Result := False;
    End
    Else If objAtiGru.fLinhaGrupoJaInformado(LeftStr(mskLinGru.Text, 3) + '000') Then
    Begin
      fMensagem('', 'A Linha ' + LeftStr(mskLinGru.Text, 3) + '.000 ' +
                    'já foi informada. Não é necessário ' +
                    'inserir o grupo ' + fRetNomeLinhaGrupo(mskLinGru.Text) + '!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtDesGru.Text := fRetNomeLinhaGrupo(mskLinGru.Text);

      If fEmptyStr(edtDesGru.Text) Then
      Begin
        fMensagem('', 'Linha/Grupo não encontrado. Verifique o código informado!', ['&Ok']);
        Result := False;
      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadAtividadesGrupos.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, nil, Key, arrSel) Then
  Begin
    fvalidaCampos(mskLinGru,False);
  End;

end;

procedure TfrmCadAtividadesGrupos.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrAtiv: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrAtiv) Then
  Begin
    fValidaCampos(edtCodAti, True);
  End;
end;

{*******************************************}
{* ADICIONA METAS NA GRID                  *}
{****************************************RL*}
procedure TfrmCadAtividadesGrupos.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinGru.Text) Or (Not fValidaPanel(pnlLinGru)) Then
    Exit;

  objAtiGru.pAdicionar(mskLinGru.Text, edtDesGru.Text);

  btnCancelar.Click;

  btnConfirmar.Enabled := objAtiGru.ChangeCount > 0;
end;

procedure TfrmCadAtividadesGrupos.FormCreate(Sender: TObject);
begin
  inherited;

  objAtiGru := TAtiGru.Create(Self);

  dbgAtiGru.DataSource := objAtiGru.dtsSource;

  strCodAti := '';

end;

procedure TfrmCadAtividadesGrupos.dbgAtiGruKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin

    btnCancelar.Click

  End

  Else If (Key = VK_Delete) Then
  Begin
    objAtiGru.pExcluir;

    btnConfirmar.Enabled := objAtiGru.ChangeCount > 0;

    If objAtiGru.IsEmpty Then
      pSetFocus(edtCodAti);
  End;


end;

procedure TfrmCadAtividadesGrupos.pLimpaEdits(blnAtividade: Boolean);
begin
  If blnAtividade Then
  Begin
    strCodAti := '';
    edtCodAti.Clear;
    edtDesAti.Clear;
    pSetFocus(edtCodAti);
  end;

  mskLinGru.Clear;
  edtDesGru.Clear;
end;

procedure TfrmCadAtividadesGrupos.btnCancelarClick(Sender: TObject);
begin
  inherited;

  objAtiGru.Cancel;
  pLimpaEdits(False);
  pSetFocus(mskLinGru);

end;

procedure TfrmCadAtividadesGrupos.pEscapePressed;
begin

  If (ActiveControl.Parent = pnlLinGru) Then
  Begin
    btnCancelar.Click;
    pSetFocus(edtCodAti);
  End

  Else If (ActiveControl.Parent = pnlAtividade) And (Not fEmptyStr(edtCodAti.Text)) Then
  Begin

    pLimpaEdits(True);
    objAtiGru.CancelUpdates;
    objAtiGru.Close;

  End

  Else
    inherited;

end;

procedure TfrmCadAtividadesGrupos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) And (btnConfirmar.Enabled) Then
  Begin

    Key := 0;
    btnConfirmar.Click;

  End;

end;

procedure TfrmCadAtividadesGrupos.FormShow(Sender: TObject);
begin
  inherited;

end;

{*******************************************}
{* CADASTRA METAS                          *}
{****************************************RL*}
procedure TfrmCadAtividadesGrupos.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If Not (btnConfirmar.Enabled And btnConfirmar.Visible) Then
    Exit;

  Try

    fStartTransaction;

    objAtiGru.fSalvarAtiGru;

    fCommit;

    pLimpaEdits(True);
    objAtiGru.Close;

    btnConfirmar.Enabled := False;

  Except
    On E: Exception Do
    Begin

      pMensagensErro(E.Message, '[]');
      fRollBack;

    End;
  End;

end;


end.


