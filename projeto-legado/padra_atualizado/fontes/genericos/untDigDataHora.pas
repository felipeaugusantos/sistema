unit untDigDataHora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  MaskEditFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigDataHora = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    mskData__: TMaskEditFocus;
    mskHora__: TMaskEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    blnConfirma: Boolean;
  end;


implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmDigDataHora.btnConfirmaClick(Sender: TObject);
begin
  //inherited;
  If (fVerificaCampos) Then
  Begin
    blnConfirma := True;
    ModalResult := mrOk;
  End;
end;

procedure TfrmDigDataHora.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  ModalResult := mrCancel;
end;

procedure TfrmDigDataHora.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

function TfrmDigDataHora.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskData__) Then
    Begin
      If (fEmptyDate(mskData__.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(mskData__.Text, 0)) = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A data informada é inválida!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = mskHora__) Then
    Begin
      If (mskHora__.Visible) Then
      Begin
        If (fEmptyTime(mskHora__.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Hora deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If (StrToTimeDef(mskHora__.Text, -1) = -1) Then
        Begin
          fMensagem('ATENÇÃO!', 'A hora informada é inválida!', ['&O k']);
          Result := False;
        End;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.

