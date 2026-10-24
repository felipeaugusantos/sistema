unit untAltDataAgendamentoEntrega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Mask, MaskEditFocus, untFuncoesSimples;

type
  TfrmAltDataAgendamentoEntrega = class(TfrmPai)
    btnConfirmaDados: TBitBtnLocked;
    pnlCentral: TPanel;
    Label1: TLabel;
    lblDtaEnt: TLabel;
    edtDtaAge: TMaskEditFocus;
    edtHraAge: TMaskEditFocus;
    edtHraEnt: TMaskEditFocus;
    edtDtaEnt: TMaskEditFocus;
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmAltDataAgendamentoEntrega: TfrmAltDataAgendamentoEntrega;

implementation

{$R *.dfm}

{ TfrmAltDataAgendamentoEntrega }

procedure TfrmAltDataAgendamentoEntrega.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    inherited;
    Close;
    ModalResult := mrOk;
  end;
end;

function TfrmAltDataAgendamentoEntrega.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtDtaAge) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtDtaAge.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data agendamento deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtHraAge) Then
    Begin
      If fEmptyTime(edtHraAge.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora agendamento deve ser preenchida!', ['&OK']);
        Result := False;
      End
      Else If (StrToTimeDef(edtHraAge.Text, -1) = -1) Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora informada é inválida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDtaEnt) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtDtaEnt.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data entrega deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtHraEnt) Then
    Begin
      If fEmptyTime(edtHraEnt.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora entrega deve ser preenchida!', ['&OK']);
        Result := False;
      End
      Else If (StrToTimeDef(edtHraEnt.Text, -1) = -1) Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora informada é inválida!', ['&Ok']);
        Result := False;
      End;
    End;
  end;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
