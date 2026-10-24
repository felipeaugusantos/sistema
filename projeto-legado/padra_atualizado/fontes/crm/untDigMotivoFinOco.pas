unit untDigMotivoFinOco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus;

type
  TfrmDigMotivoFinOco = class(TfrmPaiConfirma)
    lblMotivo: TLabel;
    edtCodMot: TEditFocus;
    edtDesMot: TEditFocus;
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregarMotivo;
  public
    { Public declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmDigMotivoFinOco.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    ModalResult := mrOk;
  End;
end;

procedure TfrmDigMotivoFinOco.edtCodMotKeyPress(Sender: TObject; var Key: Char);
Var
  arrMotivo: TConsultasArray;
begin
  inherited;

  If fPesqMotFinOco(Self, edtCodMot, edtDesMot, qryTabela, Key, arrMotivo) Then
  Begin
    If fValidaCampos(edtCodMot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigMotivoFinOco.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodMot);
end;

function TfrmDigMotivoFinOco.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtCodMot Then
    Begin
      If fEmptyStr(edtCodMot.Text) Then
      Begin
        fMensagem('', 'O motivo deve ser preenchido!' , ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregarMotivo;
        If fEmptyStr(edtDesMot.Text) Then
        Begin
          fMensagem('AVISO', 'Motivo de finalização de ocorrência não encontrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End;

  End;

  If (not Result) Then
  Begin
    pSetFocus(Sender);
  End;
end;

procedure TfrmDigMotivoFinOco.pCarregarMotivo;
begin
  edtDesMot.Clear;

  If fEmptyStr(edtCodMot.Text) Then
    Exit;

  edtDesMot.Text := fCampoTabela('MOT_DESCRI', 'MOTOCO', ['MOT_CODIGO'], [edtCodMot.Text]);
end;

end.
