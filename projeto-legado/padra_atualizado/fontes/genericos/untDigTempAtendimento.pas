unit untDigTempAtendimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus;

type
  TfrmDigTempAtendimento = class(TfrmPaiConfirma)
    lblTemperaturaAtend: TLabel;
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregarTempAtendimento;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
  public
    { Public declarations }
    strCodCor: String;
  end;

implementation

uses
  untTypesSistema, untConsultas, untFuncoesSimples;

{$R *.dfm}

procedure TfrmDigTempAtendimento.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    ModalResult := mrOk;
  End;
end;

procedure TfrmDigTempAtendimento.edtCodigoExit(Sender: TObject);
begin
  inherited;

  pCarregarTempAtendimento;
end;

procedure TfrmDigTempAtendimento.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqTempAtndCRM(Self, edtCodigo, edtDescri, qryTabela, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodigo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigTempAtendimento.FormShow(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(strCodCor) Then
  Begin
    edtCodigo.Text :=strCodCor;
    pCarregarTempAtendimento;
  End;
end;

function TfrmDigTempAtendimento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtCodigo Then
    Begin
      If fEmptyStr(edtCodigo.Text) Then
      Begin
        fMensagem('', 'O código deve ser preenchido!' , ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregarTempAtendimento;
        If fEmptyStr(edtDescri.Text) Then
        Begin
          fMensagem('AVISO', 'Código da Temperatura do Atendimento não encontrado!', ['&Ok']);
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

procedure TfrmDigTempAtendimento.pCarregarTempAtendimento;
begin
  edtDescri.Clear;

  If fEmptyStr(edtCodigo.Text) Then
    Exit;

  edtDescri.Text := fCampoTabela('TEA_DESCRI', 'CADTEA', ['TEA_CODIGO'], [edtCodigo.Text]);
end;

end.
