unit untRcxRecebimentoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, untRcxResumoCaixa, strUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, MaskEditFocus, EditFocus;

type
  TfrmRcxRecebimentoPedido = class(TfrmPaiSimples)
    btnGravar: TBitBtnLocked;
    pnlModalidades: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label20: TLabel;
    Label4: TLabel;
    lblFinanc: TLabel;
    edtDinRec: TEditFocus;
    edtCarRec: TEditFocus;
    edtChqRec: TEditFocus;
    edtChqPre: TEditFocus;
    edtValJur: TEditFocus;
    edtValDes: TEditFocus;
    edtTroco: TEditFocus;
    edtOrdRec: TEditFocus;
    edtFinanc: TEditFocus;
    pnlPedido: TPanel;
    lblPedido: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    procedure pFormataTexto(Sender: TEditFocus);
    procedure pFocarCampo(Sender: TWinControl);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    procedure pAtualizarCampos;
  end;

var
  frmRcxRecebimentoPedido: TfrmRcxRecebimentoPedido;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema;

procedure TfrmRcxRecebimentoPedido.pAtualizarCampos;
  Var
    intControl: Integer;
    objControl: TControl;
    objComponente: TComponent;
begin
  For intControl := 0 To pnlModalidades.ControlCount -1 Do
  Begin
    objControl    := pnlModalidades.Controls[intControl];
    objComponente := frmRcxResumoCaixa.FindComponent(objControl.name);

    If objComponente = nil Then
      Continue;

    If objControl Is TEditFocus Then
    Begin
      TEditFocus(objControl).Text     := TEditFocus(objComponente).Text;
      TEditFocus(objControl).Color    := TEditFocus(objComponente).Color;
      TEditFocus(objControl).TabStop  := TEditFocus(objComponente).TabStop;
      TEditFocus(objControl).Visible  := TEditFocus(objComponente).Visible;
      TEditFocus(objControl).Enabled  := TEditFocus(objComponente).Enabled;
      TEditFocus(objControl).ReadOnly := TEditFocus(objComponente).ReadOnly;
    End;

    If objControl Is TLabel Then
    Begin
      TLabel(objControl).Visible  := TLabel(objComponente).Visible;
    End;
  End;
end;

procedure TfrmRcxRecebimentoPedido.btnGravarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    If frmRcxResumoCaixa.fGravar Then
    Begin
      pMensagemOk('Recebimento realizado com sucesso!');
      blnConfirma := True;
      Close;
    End
    Else
    Begin
      pAtualizarCampos;
      If Assigned(frmRcxResumoCaixa.ActiveControl) And
         Assigned(FindComponent(frmRcxResumoCaixa.ActiveControl.Name)) Then
      Begin
        pFocarCampo(TWinControl(FindComponent(frmRcxResumoCaixa.ActiveControl.Name)));
      End
      Else
        pFocarCampo(btnGravar);
    End;
  End;
end;

procedure TfrmRcxRecebimentoPedido.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  pAtualizarCampos;
  SelectFirst;
end;

function TfrmRcxRecebimentoPedido.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    objComponente: TComponent;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender Is TEditFocus Then
    Begin
      objComponente := frmRcxResumoCaixa.FindComponent(Sender.Name);
      If objComponente <> nil Then
      Begin
        pFormataTexto(TEditFocus(Sender));
        TEditFocus(objComponente).Text := TEditFocus(Sender).Text;
        Result := frmRcxResumoCaixa.fValidar(TEditFocus(objComponente), blnBuscaPorChave);
      End;
    End;
  End;

  pAtualizarCampos;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRcxRecebimentoPedido.pFormataTexto(Sender: TEditFocus);
begin
  If (Trim(Sender.EditFormat) <> '') Then
  Begin
    If (Sender.TipoTexto = ttNumerico) Then
    Begin
      If (Trim(Sender.Text) = '') Then
        Sender.Text := '0,00';
      Sender.Text := AnsiReplaceStr(Sender.Text, '.', '');
      Sender.Text := FormatFloat(Sender.EditFormat, fStrToFloat(Sender.Text));
    End;
  End;
end;

procedure TfrmRcxRecebimentoPedido.pFocarCampo(Sender: TWinControl);
begin
  SetForegroundWindow(Self.Handle);
  pSetFocus(Sender);
end;

end.
