unit untFatDigIdentServico;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Uni,
  ExtCtrls, Mask, MaskEditFocus, AppEvnts, EditFocus, StrUtils,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxButtons;

type
  TfrmFatDigIdentServico = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    btnCobrar: TcxButton;
    btnIsentar: TcxButton;
    btnRatear: TcxButton;
    procedure btnCobrarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  protected

  public
    { Public declarations }

    intIndImg : Integer; {* 0 - Cobrança NS *}
                         {* 1 - Isento      *}
                         {* 2 - Rateio      *}
  end;

var
  frmFatDigIdentServico: TfrmFatDigIdentServico;

implementation

uses untfuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmFatDigIdentServico.btnCobrarClick(Sender: TObject);
begin
  inherited;
  If Sender = btnCobrar Then
    intIndImg := 0
  Else If Sender = btnIsentar Then
    intIndImg := 1
  Else If Sender = btnRatear Then
    intIndImg := 2;
end;

procedure TfrmFatDigIdentServico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
  Begin
    intIndImg := -1;
    Key := 0;
    Close;
  End

  Else If Key = VK_F1 Then
    btnCobrar.Click

  Else If Key = VK_F2 Then
    btnIsentar.Click

  Else If Key = VK_F3 Then
    btnRatear.Click;
end;

End.


