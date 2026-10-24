unit untConfiguracoes;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPai, ComCtrls, Buttons, ExtCtrls, DBCtrls,
  Mask, DBEditFocus, EditFocus, {Qt,} Uni, DB, DBComboBoxFocus,
  MaskEditFocus, QColorLabel, Menus, ToolEdit, DirectoryEditFocus, AppEvnts, untLiberacao;

type
  TfrmCadConfiguracoes = class(TfrmPai)
    lsvOpcoes: TListView;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnConfResCaiClick(Sender: TObject);
    procedure lsvOpcoesResize(Sender: TObject);
    procedure lsvOpcoesDblClick(Sender: TObject);
    procedure lsvOpcoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private

    objLiberacao : TLiberacao;

    { Private declarations }
    procedure pAtualizaVariaveisGlobais;

  protected
    qryTabela: TUniQuery;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadConfiguracoes: TfrmCadConfiguracoes;

implementation

uses untFuncoes, untfuncoesSimples, untModulo, untFuncIns, untCadEmpresas,
  untPesqAux, untConstantes, untSplashExt, untPrincipal, untModuloCadPor,
  untModuloCadFor, untModuloCadEmp, untModuloCadBco, untModuloCadCta,
  untModuloCadGru, untModuloCadTra, untModuloCadCli, untCfgMovBan,
  untCfgCancelaDoc, untModuloSPR, untAtuVarGlobais;

{$R *.dfm}

procedure TfrmCadConfiguracoes.FormCreate(Sender: TObject);
begin
  inherited;

  lsvOpcoes.Selected    := lsvOpcoes.Items[0];
  lsvOpcoes.ItemFocused := lsvOpcoes.Items[0];
  lsvOpcoes.ItemIndex   := 0;

  qryTabela := frmModulo.qryCadCfg;
  fFecharTabela(qryTabela);
  fAbrirTabela(qryTabela);
  qryTabela.Edit;

  objLiberacao.Create;
end;


procedure TfrmCadConfiguracoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fFecharTabela(qryTabela);
end;

function TfrmCadConfiguracoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If Not Result Then
    Sender.SetFocus;
end;

procedure TfrmCadConfiguracoes.FormShow(Sender: TObject);
begin
  inherited;
  lsvOpcoes.SortType := stText;
  {********************************************}
  {* COMENTEI A PEDIDO DO RONALDO,PQ A ROTINA *}
  {* AINDA NÃO ESTA 100%                      *}
  {* TEM QUE INCLUIR NOVAMENTE NO  LSVOPCOES  *}
  {* QUANDO ESTIVER OK. TfrmCfgBackup         *}
  {*****************************************AC*}

end;

procedure TfrmCadConfiguracoes.pAtualizaVariaveisGlobais;
begin
  pAtuVarGlobais;
end;

procedure TfrmCadConfiguracoes.btnConfResCaiClick(Sender: TObject);
  Var
    strSenha: String;
begin
  inherited;
  If ffrmSenha(strSenha) Then
  Begin
    If (strSenha = SEN_AUTRCX) Then
    Begin

      qryTabela.Post;

      frmPrincipal.blnProgExterno := False;
      Self.Hide;
      Application.MainForm.Hide;

      Try
        Application.CreateForm(TfrmSplashExt,frmSplashExt);
        frmSplashExt.strProg := 'autrcx';
        frmSplashExt.ShowModal;
      Finally
        FreeAndNil(frmSplashExt);
      End;

      While (FindWindow(Nil, PChar('AutRcx')) > 0) Do;

      Self.Show;
      Application.MainForm.Show;

      SetForegroundWindow(Self.Handle);

      frmPrincipal.blnProgExterno := True;

      fAbrirTabela(qryTabela);
      qryTabela.Edit;

    End
    Else
    Begin
      fMensagem('', 'Senha incorreta!', ['&Ok']);
    End;
  End;
end;

procedure TfrmCadConfiguracoes.lsvOpcoesResize(Sender: TObject);
begin
  inherited;
  lsvOpcoes.Columns[0].Width := lsvOpcoes.Width - 20;
end;

procedure TfrmCadConfiguracoes.lsvOpcoesDblClick(Sender: TObject);
  Var
    PersistentClass: TPersistentClass;
    Form: TForm;
begin
  inherited;

  If (Not Assigned(lsvOpcoes.Selected)) Then
  Begin
    Exit;
  End;

  PersistentClass := GetClass(lsvOpcoes.Selected.SubItems[0]);

  Form := TComponentClass(PersistentClass).Create(Application) As TForm;
  If (Form.ShowModal = mrOk) Then
  Begin
    qryTabela.Post;
    pAtualizaVariaveisGlobais;

    utcRegistros.Limpar('frmFatDigDocumentoORfrmConsultaFatPedOrcFATGOR');
    utcRegistros.Limpar('frmFatDigDocumentoORVNfrmConsultaFatPedOrcFATGOR');
  End
  Else
  Begin
    qryTabela.CancelUpdates;
  End;
  qryTabela.Edit;
  FreeAndNil(Form);

end;

procedure TfrmCadConfiguracoes.lsvOpcoesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    lsvOpcoes.OnDblClick(Sender)
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End;
end;

procedure TfrmCadConfiguracoes.FormDestroy(Sender: TObject);
begin
  pFreeAndNil(objLiberacao);
  inherited;
end;

end.





