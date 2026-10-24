unit untDigEmailCtaCorrente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, MemoFocus,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigEmailCtaCorrente = class(TfrmPai)
    pnlCentral: TPanel;
    Label1: TLabel;
    edtEmail: TEditFocus;
    Label2: TLabel;
    edtContato: TEditFocus;
    memObservacoes: TMemoFocus;
    Label3: TLabel;
    chkContaCorrente: TCheckBox;
    chkProduto: TCheckBox;
    chkCheque: TCheckBox;
    btnConfirma: TBitBtnLocked;
    chkDtaVen: TCheckBox;
    chkJuros: TCheckBox;
    procedure btnConfirmaClick(Sender: TObject);
    procedure chkProdutoClick(Sender: TObject);
    procedure chkContaCorrenteClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses  untfuncoesSimples;

{$R *.dfm}

{ TfrmEntDigEmail }

function TfrmDigEmailCtaCorrente.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtEmail) Then
  Begin
    If (fEmptyStr(edtEmail.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O email deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (Pos('@', edtEmail.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', edtEmail.Text + ' não é um email válido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtContato) Then
  Begin
    If (fEmptyStr(edtContato.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O contato deve ser preenchido!', ['&Ok']);
      Result := False;
    End
  End;

end;

procedure TfrmDigEmailCtaCorrente.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos)                                       And
     (fMensagem('', 'Enviar e-mail?', ['&Sim', '&Não']) = 1) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmDigEmailCtaCorrente.chkProdutoClick(Sender: TObject);
begin
  inherited;
  If chkProduto.Checked Then
    chkContaCorrente.Checked := True;
end;

procedure TfrmDigEmailCtaCorrente.chkContaCorrenteClick(Sender: TObject);
begin
  inherited;
  If Not chkContaCorrente.Checked Then
    chkProduto.Checked := False;
end;

end.

