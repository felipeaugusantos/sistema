unit untPedOpcoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, ExtCtrls, AppEvnts, Menus, Buttons, QColorLabel,
  EditFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmPedOpcoes = class(TfrmPai)
    pnlFundo: TPanel;
    rdgMultiLoja: TRadioGroup;
    rdgGiro: TRadioGroup;
    btnConfirmaDados: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnHlpImpClick(Sender: TObject);
  private
    { Private declarations }
    procedure OnIdle(Sender: TObject; Var Done: Boolean);
    function fOperadorComAcesoAMultiloja: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnGiro: Boolean;
    blnMultiLoja: Boolean;
    blnConfirma : Boolean;
  end;

var
  frmPedOpcoes: TfrmPedOpcoes;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmPedOpcoes.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (rdgMultiLoja.ItemIndex = 0) Then
    blnMultiLoja := True
  Else
    blnMultiLoja := False;

  If (rdgGiro.ItemIndex = 0) Then
    blnGiro := True
  Else
    blnGiro := False;

  blnConfirma := True;

  Close;
end;

procedure TfrmPedOpcoes.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  pMensagemOk('Operador logado não possui acesso para emitir pedido de compra multi-lojas (Cadastro de Operadores)');
end;

procedure TfrmPedOpcoes.btnSairClick(Sender: TObject);
begin
  blnGiro     := False;
  blnMultiLoja:= False;
  blnConfirma := False;
  inherited;
end;

function TfrmPedOpcoes.fOperadorComAcesoAMultiloja: Boolean;
begin
   Result := fCampoTabela('OPE_PEDMLT', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]) = 'S';
end;

procedure TfrmPedOpcoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.OnIdle := Nil;
  inherited;
end;

procedure TfrmPedOpcoes.FormCreate(Sender: TObject);
begin
  inherited;
  Application.OnIdle := Self.OnIdle;
  btnHlpImp.Visible := False;

end;

procedure TfrmPedOpcoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
//  If (Key = VK_Return) And (ActiveControl is TRadioButton) Then
//    SelectNext(ActiveControl,true,true);
  If (Key = VK_Escape) Then
    btnSair.Click;
end;

procedure TfrmPedOpcoes.FormShow(Sender: TObject);
Var
  blnPEDGEQ: Boolean;
begin
  blnPEDGEQ := fCfgSis('PEDGEQ', varBoolean);
  rdgGiro.ItemIndex := IIF(blnPEDGEQ,0,1);

  inherited;
  If frmPedOpcoes.rdgMultiLoja.ItemIndex = - 1 Then
    frmPedOpcoes.rdgMultiLoja.ItemIndex := 0;

  pSetFocus(TRadioButton(rdgMultiLoja.Controls[frmPedOpcoes.rdgMultiLoja.ItemIndex]));

  If Not fOperadorComAcesoAMultiloja Then
  Begin
    rdgMultiLoja.ItemIndex := 1;
    rdgMultiLoja.Enabled := False;
    btnHlpImp.Visible := True;
  End;

end;

function TfrmPedOpcoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
{ If (Sender = edtNivel) Then
  Begin
    If Not fEmptyStr(edtNivel.Text) Then
    Begin
      If (edtNivel.Text <> 'A') And (edtNivel.Text <> 'B') And (edtNivel.Text <> 'C') Then
      Begin
        fMensagem('','O campo Nível de Giro de Estoque deve ter A, B, ou C !',['&O K'],0);
        Result := False;
      End;
    End;
  End;}
end;

procedure TfrmPedOpcoes.OnIdle(Sender: TObject; var Done: Boolean);
begin
{  If (rdgGiro.ItemIndex = 0) Then
  Begin
    edtNivel.Enabled := True;
  End
  Else
  Begin
    edtNivel.Enabled := False;
  End;}
end;

end.
