unit untInputDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, EditFocus,
  frxClass, frxExportCSVTestabilidade;

Type
  TValidaValue = function(Sender: TWinControl; blnBuscaPorChave: Boolean) : boolean of object;
type
  TfrmInputDialog = class(TfrmPai)
    pnlFundo: TPanel;
    btnConfirma: TBitBtnLocked;
    lblPrompt: TLabel;
    edtValue: TEditFocus;
    btnCancela: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    fValidaValue : TValidaValue;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

  function fInputDialog(const ACaption: string;
                        const APrompt: string;
                        const ADefault: string = '';
                        const MaxLength: Integer = 100;
                        const Width: Integer = 450;
                        const ATipoTexto: TControlTipoTexto = ttAlfanumerico;
                        const ACompZeros: Boolean = False;
                        const AError : string = '';
                        fValidaValue : TValidaValue = nil): string; overload;

  function fInputDialog(var ModalResult: Integer;
                        const ACaption: string;
                        const APrompt: string;
                        const ADefault: string = '';
                        const MaxLength: Integer = 100;
                        const Width: Integer = 450;
                        const ATipoTexto: TControlTipoTexto = ttAlfanumerico;
                        const ACompZeros: Boolean = False): string; overload;

var
  frmInputDialog: TfrmInputDialog;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmInputDialog }

function fInputDialog(const ACaption: string;
                      const APrompt: string;
                      const ADefault: string = '';
                      const MaxLength: Integer = 100;
                      const Width: Integer = 450;
                      const ATipoTexto: TControlTipoTexto = ttAlfanumerico;
                      const ACompZeros: Boolean = False;
                      const AError : string = '';
                      fValidaValue : TValidaValue = nil): string;
begin
  pCriarFormularios(TfrmInputDialog, frmInputDialog);
  Try
    frmInputDialog.Caption := ACaption;
    frmInputDialog.lblPrompt.Caption := APrompt;
    frmInputDialog.edtValue.Text := ADefault;
    frmInputDialog.edtValue.MaxLength := MaxLength;
    frmInputDialog.edtValue.TipoTexto := ATipoTexto;
    frmInputDialog.edtValue.CompZeros := ACompZeros;
    frmInputDialog.btnCancela.Visible := False;
    If ACompZeros Then
      frmInputDialog.edtValue.TamCampo := MaxLength;
    frmInputDialog.Width := Width;
    frmInputDialog.fValidaValue := fValidaValue;
    If frmInputDialog.ShowModal = mrOk Then
      Result := frmInputDialog.edtValue.Text
    Else
    begin
      if fEmptyStr(AError) then
        Result := ADefault
      else
        Result := AError;
    end;
  Finally
    pFreeAndNil(frmInputDialog);
  End;
end;

function fInputDialog(var ModalResult: Integer;
                      const ACaption: string;
                      const APrompt: string;
                      const ADefault: string = '';
                      const MaxLength: Integer = 100;
                      const Width: Integer = 450;
                      const ATipoTexto: TControlTipoTexto = ttAlfanumerico;
                      const ACompZeros: Boolean = False): string;
begin
  pCriarFormularios(TfrmInputDialog, frmInputDialog);
  Try
    frmInputDialog.Caption := ACaption;
    frmInputDialog.lblPrompt.Caption := APrompt;
    frmInputDialog.edtValue.Text := ADefault;
    frmInputDialog.edtValue.MaxLength := MaxLength;
    frmInputDialog.edtValue.TipoTexto := ATipoTexto;
    frmInputDialog.edtValue.CompZeros := ACompZeros;
    frmInputDialog.btnCancela.Visible := True;
    frmInputDialog.btnSair.Visible := False;
    If ACompZeros Then
      frmInputDialog.edtValue.TamCampo := MaxLength;
    frmInputDialog.Width := Width;
    If frmInputDialog.ShowModal = mrOk Then
      Result := frmInputDialog.edtValue.Text
    Else
      Result := ADefault;
  Finally
    ModalResult := frmInputDialog.ModalResult;
    pFreeAndNil(frmInputDialog);
  End;
end;

procedure TfrmInputDialog.btnConfirmaClick(Sender: TObject);
begin
  if not fVerificaCampos then
    ModalResult := mrNone;
end;

function TfrmInputDialog.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result    := True;

  if Sender = edtValue then
  begin
    if Assigned(fValidaValue) then
      result := fValidaValue(Sender, blnBuscaPorChave);
  end;


  If Not Result Then
  begin
    if blnMudarFoco then
    begin
      blnMudarFoco := False;
      pSetFocus(Sender);
    end;
  end;
end;

end.
