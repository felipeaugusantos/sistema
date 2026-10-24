unit untOpcoesDocEnvioEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TExibirOpcoesReimpressao = record
    blnExibirDigConf : Boolean;
    blnExibirXMLDANFe : Boolean;
    blnExibirBoletos : Boolean;
  end;

type
  TfrmOpcoesDocEnvioEmail = class(TfrmPai)
    btnConfirmaDados: TBitBtnLocked;
    gbOpcoes: TGroupBox;
    chkDocSel: TCheckBox;
    chkBoletos: TCheckBox;
    chkDocDigConf: TCheckBox;
    chkTodos: TCheckBox;
    chkXML: TCheckBox;
    chkDANFe: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure chkTodosClick(Sender: TObject);
    procedure chkBoletosClick(Sender: TObject);
    procedure chkDocSelClick(Sender: TObject);
    procedure chkDocDigConfClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure chkDANFeClick(Sender: TObject);
    procedure chkXMLClick(Sender: TObject);
  private
    { Private declarations }
    procedure pMarcarTodos;
  public
    { Public declarations }
    Class function fAbrirOpcoesDocEnvioEmail(const AExibirOpcoes : TExibirOpcoesReimpressao; Var blnImpDocSel : Boolean; Var blnImpBoleto : Boolean; Var blnImpDocConf : Boolean; var blnXML : Boolean; var blnDANFe : Boolean) : Boolean;
  end;

implementation

{$R *.dfm}

Uses untFuncoesSimples;

procedure TfrmOpcoesDocEnvioEmail.chkBoletosClick(Sender: TObject);
begin
  inherited;
  If chkBoletos.Checked Then
  Begin
    If (not fVerificaAcessoSistema('REIBPE', strLoginUsuarioLogado)) Then
    Begin
      fMensagem('Atenção', 'Usuário não possui direito de acesso liberado para essa opção.', ['&Ok']);
      chkBoletos.Checked := False;
    end;
  End;
  pMarcarTodos;
end;

procedure TfrmOpcoesDocEnvioEmail.chkDANFeClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos;
end;

procedure TfrmOpcoesDocEnvioEmail.chkDocDigConfClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos;
end;

procedure TfrmOpcoesDocEnvioEmail.chkDocSelClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos;
end;

procedure TfrmOpcoesDocEnvioEmail.chkTodosClick(Sender: TObject);
begin
  inherited;
  chkDocSel.OnClick     := Nil;
  chkBoletos.OnClick    := Nil;
  chkDocDigConf.OnClick := Nil;
  chkXML.OnClick        := Nil;
  chkDANFe.OnClick      := Nil;

  chkDocSel.Checked     := True;
  chkBoletos.Checked    := (fVerificaAcessoSistema('REIBPE', strLoginUsuarioLogado)) And (chkTodos.Checked);
  chkDocDigConf.Checked := (chkDocDigConf.Visible) And (chkTodos.Checked);
  chkXML.Checked        := (chkXML.Visible) And (chkTodos.Checked);
  chkDANFe.Checked      := (chkDANFe.Visible) And (chkTodos.Checked);

  chkDocSel.OnClick     := chkDocSelClick;
  chkBoletos.OnClick    := chkBoletosClick;
  chkDocDigConf.OnClick := chkDocDigConfClick;
  chkXML.OnClick        := chkXMLClick;
  chkDANFe.OnClick      := chkDANFeClick;
end;

procedure TfrmOpcoesDocEnvioEmail.chkXMLClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos;
end;

procedure TfrmOpcoesDocEnvioEmail.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If (not chkTodos.Checked)   And
     (not chkDocSel.Checked)  And
     (not chkBoletos.Checked) And
     (not chkDanfe.Checked) And
     (not chkXML.Checked) And
     (not chkDocDigConf.Checked) Then
  Begin
    fMensagem('Atenção', 'Pelo menos uma das opções deve ficar marcada para o envio do E-mail.', ['&Ok']);
    CanClose := False;
  End;
end;

procedure TfrmOpcoesDocEnvioEmail.FormShow(Sender: TObject);
begin
  inherited;
  if (not chkDocDigConf.Visible) then
  Begin
    chkTodos.Top := chkDocDigConf.Top;
    Self.Height := Self.Height - chkDocDigConf.Height + 2;
  End;
end;

procedure TfrmOpcoesDocEnvioEmail.pMarcarTodos;
begin
  inherited;
  chkTodos.OnClick := Nil;
  chkTodos.Checked := ((chkDocSel.Checked) And
                      ((not fVerificaAcessoSistema('REIBPE', strLoginUsuarioLogado)) Or
                      (chkBoletos.Checked And fVerificaAcessoSistema('REIBPE', strLoginUsuarioLogado))) And
                      ((not chkDocDigConf.Visible) Or
                      (chkDocDigConf.Visible And chkDocDigConf.Checked))) And
                      ((not chkDANFe.Visible) Or chkDANFe.Checked) And
                      ((not chkXML.Visible) Or chkXML.Checked);

  chkTodos.OnClick := chkTodosClick;
end;


Class function TfrmOpcoesDocEnvioEmail.fAbrirOpcoesDocEnvioEmail(const AExibirOpcoes : TExibirOpcoesReimpressao; Var blnImpDocSel : Boolean; Var blnImpBoleto : Boolean; Var blnImpDocConf : Boolean; var blnXML : Boolean; var blnDANFe : Boolean) : Boolean;
  Var
    frmOpcoesDocEnvioEmail : TfrmOpcoesDocEnvioEmail;
begin
  pCriarFormularios(TfrmOpcoesDocEnvioEmail, frmOpcoesDocEnvioEmail);
  Try
    frmOpcoesDocEnvioEmail.chkDocDigConf.Visible := AExibirOpcoes.blnExibirDigConf;
    frmOpcoesDocEnvioEmail.chkXML.Visible        := AExibirOpcoes.blnExibirXMLDANFe;
    frmOpcoesDocEnvioEmail.chkDANFe.Visible      := AExibirOpcoes.blnExibirXMLDANFe;
    frmOpcoesDocEnvioEmail.chkBoletos.Visible := AExibirOpcoes.blnExibirBoletos;

    Result        := frmOpcoesDocEnvioEmail.ShowModal = mrOk;
    blnImpDocSel  := frmOpcoesDocEnvioEmail.chkDocSel.Checked;
    blnImpBoleto  := frmOpcoesDocEnvioEmail.chkBoletos.Checked    And AExibirOpcoes.blnExibirBoletos;
    blnImpDocConf := frmOpcoesDocEnvioEmail.chkDocDigConf.Checked And AExibirOpcoes.blnExibirDigConf;
    blnXML        := frmOpcoesDocEnvioEmail.chkXML.Checked        And AExibirOpcoes.blnExibirXMLDANFe;
    blnDANFe      := frmOpcoesDocEnvioEmail.chkDANFe.Checked      And AExibirOpcoes.blnExibirXMLDANFe;
  Finally
    pFreeAndNil(frmOpcoesDocEnvioEmail)
  End;
end;



end.
