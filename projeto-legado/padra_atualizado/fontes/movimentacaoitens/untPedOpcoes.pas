unit untPedOpcoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, ExtCtrls, AppEvnts, Menus, Buttons;

type
  TfrmPedOpcoes = class(TfrmPai)
    pnlFundo: TPanel;
    rdgMultiLoja: TRadioGroup;
    rdgGiro: TRadioGroup;
    btnConfirmaDados: TBitBtn;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnGiro: Boolean;
    blnMultiLoja: Boolean;
    blnConfirma : Boolean;
  end;

var
  frmPedOpcoes: TfrmPedOpcoes;

implementation

{$R *.dfm}

procedure TfrmPedOpcoes.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If rdgMultiLoja.ItemIndex = 0 Then
    blnMultiLoja := True
  Else
    blnMultiLoja := False;

  If rdgGiro.ItemIndex = 0 Then
    blnGiro := True
  Else
    blnGiro := False;

  blnConfirma := True;

  Close;
end;

procedure TfrmPedOpcoes.btnSairClick(Sender: TObject);
begin
  blnGiro     := False;
  blnMultiLoja:= False;
  blnConfirma := False;
  inherited;
end;

procedure TfrmPedOpcoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) And (ActiveControl is TRadioButton) Then
    SelectNext(ActiveControl,true,true);
  If (Key = VK_Escape) Then
    btnSair.Click;
end;

procedure TfrmPedOpcoes.FormShow(Sender: TObject);
begin
  inherited;
  TRadioButton(rdgMultiLoja.Controls[0]).SetFocus;
end;

end.
