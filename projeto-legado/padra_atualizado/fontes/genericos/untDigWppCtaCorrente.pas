unit untDigWppCtaCorrente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, MemoFocus,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, Vcl.Mask;

type
  TfrmDigWppCtaCorrente = class(TfrmPai)
    pnlCentral: TPanel;
    lblWhatsapp: TLabel;
    edtWhatsapp: TMaskEdit;
    lblContato: TLabel;
    edtContato: TEditFocus;
    memObservacoes: TMemoFocus;
    lblObservacoes: TLabel;
    chkContaCorrente: TCheckBox;
    chkProduto: TCheckBox;
    chkCheque: TCheckBox;
    btnConfirma: TBitBtnLocked;
    chkDtaVen: TCheckBox;
    chkJuros: TCheckBox;
    procedure btnConfirmaClick(Sender: TObject);
    procedure chkProdutoClick(Sender: TObject);
    procedure chkContaCorrenteClick(Sender: TObject);
    procedure edtWhatsappEnter(Sender: TObject);
    procedure edtWhatsappExit(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses
  untFuncoesSimples,
  untFuncoesGenerica;

{$R *.dfm}

{ TfrmEntDigWhatsapp }

function TfrmDigWppCtaCorrente.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtWhatsapp) Then
  Begin
    If (fEmptyStr(edtWhatsapp.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Whatsapp deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaCelular(edtWhatsapp.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', edtWhatsapp.Text + ' não é um Whatsapp válido!', ['&Ok']);
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

procedure TfrmDigWppCtaCorrente.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And
     (fMensagem('', 'Enviar whatsapp?', ['&Sim', '&Não']) = 1) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmDigWppCtaCorrente.chkProdutoClick(Sender: TObject);
begin
  inherited;
  If chkProduto.Checked Then
    chkContaCorrente.Checked := True;
end;

procedure TfrmDigWppCtaCorrente.edtWhatsappEnter(Sender: TObject);
begin
  inherited;
  edtWhatsapp.EditMask := '';
end;

procedure TfrmDigWppCtaCorrente.edtWhatsappExit(Sender: TObject);
begin
  inherited;
  edtWhatsapp.EditMask := fRetMascaraFonePais;
end;

procedure TfrmDigWppCtaCorrente.chkContaCorrenteClick(Sender: TObject);
begin
  inherited;
  If Not chkContaCorrente.Checked Then
    chkProduto.Checked := False;
end;

end.

