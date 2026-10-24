unit untMaskInputDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, EditFocus,
  frxClass, frxExportCSVTestabilidade, Vcl.Mask, MaskEditFocus;

type
  TfrmMaskInputDialog = class(TfrmPai)
    pnlFundo: TPanel;
    btnConfirma: TBitBtnLocked;
    lblPrompt: TLabel;
    edtValue: TMaskEditFocus;
    btnCancela: TBitBtnLocked;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function fMaskInputDialog(const ACaption: string;
                            const APrompt: string;
                            const ADefault: string = '';
                            const MaxLength: Integer = 100;
                            const Width: Integer = 450;
                            const ACharCase: TEditCharCase = TEditCharCase.ecUpperCase;
                            const AEditMask: String = ''): string; overload;

  function fMaskInputDialog(var ModalResult: Integer;
                            const ACaption: string;
                            const APrompt: string;
                            const ADefault: string = '';
                            const MaxLength: Integer = 100;
                            const Width: Integer = 450;
                            const ACharCase: TEditCharCase = TEditCharCase.ecUpperCase;
                            const AEditMask: String = ''): string; overload;

var
  frmMaskInputDialog: TfrmMaskInputDialog;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmMaskInputDialog }

function fMaskInputDialog(const ACaption: string;
                          const APrompt: string;
                          const ADefault: string = '';
                          const MaxLength: Integer = 100;
                          const Width: Integer = 450;
                          const ACharCase: TEditCharCase = TEditCharCase.ecUpperCase;
                          const AEditMask: String = ''): string;
begin
  pCriarFormularios(TfrmMaskInputDialog, frmMaskInputDialog);
  Try
    frmMaskInputDialog.Caption := ACaption;
    frmMaskInputDialog.lblPrompt.Caption := APrompt;
    frmMaskInputDialog.edtValue.Text := ADefault;
    frmMaskInputDialog.edtValue.MaxLength := MaxLength;
    frmMaskInputDialog.edtValue.CharCase  := ACharCase;
    frmMaskInputDialog.edtValue.EditMask:= AEditMask;
    frmMaskInputDialog.btnCancela.Visible := False;
    frmMaskInputDialog.Width := Width;
    If frmMaskInputDialog.ShowModal = mrOk Then
      Result := frmMaskInputDialog.edtValue.Text
    Else
      Result := ADefault;
  Finally
    pFreeAndNil(frmMaskInputDialog);
  End;
end;

function fMaskInputDialog(var ModalResult: Integer;
                          const ACaption: string;
                          const APrompt: string;
                          const ADefault: string = '';
                          const MaxLength: Integer = 100;
                          const Width: Integer = 450;
                          const ACharCase: TEditCharCase = TEditCharCase.ecUpperCase;
                          const AEditMask: String = ''): string;
begin
  pCriarFormularios(TfrmMaskInputDialog, frmMaskInputDialog);
  Try
    frmMaskInputDialog.Caption := ACaption;
    frmMaskInputDialog.lblPrompt.Caption := APrompt;
    frmMaskInputDialog.edtValue.Text := ADefault;
    frmMaskInputDialog.edtValue.MaxLength := MaxLength;
    frmMaskInputDialog.edtValue.CharCase  := ACharCase;
    frmMaskInputDialog.edtValue.EditMask  := AEditMask;
    frmMaskInputDialog.btnCancela.Visible := True;
    frmMaskInputDialog.btnSair.Visible := False;
    frmMaskInputDialog.Width := Width;
    If frmMaskInputDialog.ShowModal = mrOk Then
      Result := frmMaskInputDialog.edtValue.Text
    Else
      Result := ADefault;
  Finally
    ModalResult := frmMaskInputDialog.ModalResult;
    pFreeAndNil(frmMaskInputDialog);
  End;
end;

end.
